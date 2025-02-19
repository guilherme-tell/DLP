// Base para desenvolvimento de algoritmos de PDS do tipo amostra a amostra
#include <stdio.h>
#include "stm32f446xx.h"
#include "signals.h"
#include "uart.h"
#include "arm_math.h"
#include "adc.h"
#include "tim.h"
#include "fpu.h"
#include "clock.h"
#include "gpio.h"

#include "arm_const_structs.h"

#define N		7680
#define Fs	 	3840
#define Nppc	Fs/60

#define pi		3.14159265358979
#define doispi	6.28318530717959

#define	NUM_MEAN	4

#define SIGNAL_LEN	7680
#define acc		SIGNAL_LEN/N

#define	J		64		//Tamanho da janela deslizante da DFT
//#define N		7680	//Numero de amostras em 1 seg de sinal

float32_t REXc[Nppc];
float32_t IMXc[Nppc];

float32_t REXp[Nppc];
float32_t IMXp[Nppc];

float32_t MAGc[Nppc];
float32_t MAGp[Nppc];

int contador;

uint8_t g_process_flg	= 0;
uint8_t trigger_flg		= 0;

uint32_t sensor_data;

uint32_t mean_sensor_data;
uint8_t ensemble;

uint32_t g_sensor_value;
uint32_t handler_flg;

uint32_t n;

//float32_t sinal [SIGNAL_LEN]={0.0};
//float32_t sinal_interpolado[SIGNAL_LEN] = {0.0};

/*sinal de entrada*/
float32_t input_signal, x;

/*pre filtro zero crossing-------------------------------------------------------------------------------------------------------------------------*/
/* 1 secao */
float32_t x1 = 0.0;
float32_t x1_1 = 0.0;
float32_t x1_2 = 0.0;

float32_t y11 = 0.0;
float32_t y1_1 = 0.0;
float32_t y1_2 = 0.0;

/* 2 secao */
float32_t x2 = 0.0;
float32_t x2_1 = 0.0;
float32_t x2_2 = 0.0;

float32_t y2 = 0.0;
float32_t y2_1 = 0.0;
float32_t y2_2 = 0.0;

/* 3 secao */
float32_t x3 = 0.0;
float32_t x3_1 = 0.0;
float32_t x3_2 = 0.0;

float32_t y3 = 0.0;
float32_t y3_1 = 0.0;
float32_t y3_2 = 0.0;

/*Zero-crossing---------------------------------------------------------------------------------------------------------------------------------*/
float32_t amostra_atual = 0.0;
float32_t amostra_anterior = 0.0;

float32_t Tsc = 0.0;
float32_t T1 = 0.0;
float32_t T2 = 0.0;
float32_t F = 60.0;        //nova frequencia
float32_t Nb = 0.0;

float32_t Ts;

/*Interpolador ---------------------------------------------------------------------------------------------------------------------------------*/
float32_t saida_farrow = 0.0;

//float32_t buffer_farrow[4] = {0.0};
//
//float32_t lamb = 0.0;
//float32_t alfa = 0.0;
float32_t flag = 1.0;

//float32_t H0 = 0.0;
//float32_t H1 = 0.0;
//float32_t H2 = 0.0;
//float32_t H3 = 0.0;

//Interpolador alternativo
float32_t H0[4] = {0.1667, -0.5000, 0.5000, -0.1667};
float32_t H1[4] = {0.5000, -1.0000, 0.5000, 0};
float32_t H2[4] = {0.3333, 0.5000, -1.0000, 0.1667};

float32_t y00, y01, y02;
float32_t Ts_out;
float32_t xbuf[4] = {0.0, 0.0, 0.0, 0.0};

float32_t alpha;
float32_t lambda;

/*----------------------------------------------------------------------------------------------------------------------------------------------*/

uint8_t count = 0;

uint32_t a, b, c, c_inter, ii, k, k_inter, kk, i_teste, y;		//contadores diversos
// a = ll, b = hh, c = jj, k = mm

//Variaveis da SWRDFT do sinal amostrado (16 componentes: dc ate o 15° harmônico)
float32_t	w0 = doispi/Nppc;
float32_t	re_SA[16];
float32_t	im_SA[16];
float32_t	re_ant_SA[16];
float32_t	im_ant_SA[16];
float32_t	mag_DFT_SA[16];
float32_t	phi_DFT_SA[16];
float32_t	buff_DFT_SA[J];
float32_t	*phi_pointer_SA;
float32_t	*harm_pointer_SA;

float32_t lastSample_SA, Sample_J_SA;

//Variaveis da SWRDFT do sinal interpolado (16 componentes: dc ate o 15° harmônico)
float32_t	re[16];
float32_t	im[16];
float32_t	re_ant[16];
float32_t	im_ant[16];
float32_t	mag_DFT[16];
float32_t	phi_DFT[16];
float32_t	buff_DFT[J];
float32_t	*phi_pointer;
float32_t	*harm_pointer;

float32_t lastSample, Sample_J;

//Vetores para alocação dos bins de frequencia
float32_t	harm_1st_SA[N];
float32_t	harm_3rd_SA[N];
float32_t	harm_5th_SA[N];
//float32_t	phi_1st_SA[N];
//float32_t	phi_3rd_SA[N];
//float32_t	phi_5th_SA[N];
//float32_t	harm_1st[N];
//float32_t	harm_3rd[N];
//float32_t	harm_5th[N];
//float32_t	phi_1st[N];
//float32_t	phi_3rd[N];
//float32_t	phi_5th[N];

//float32_t frequencia_estimada[N];

//Vetores de seno e cosseno
extern float32_t cc[J];
extern float32_t ss[J];
extern float32_t cc2[64];
extern float32_t ss2[64];

//extern uint32_t signal_data[7680];

void gpio_interrupt(void);
static void pseudo_dly(int dly);

int main()
{
	/*Enable fpu*/
	 fpu_enable();

	 /*Configure clock tree*/
	 clock_180MHz_config();

	/*Initialize the uart*/
	 uart2_tx_init();

	/*Initialize ADC*/
	 pa1_adc_init();

	/*Start ADC conversion*/
	 start_conversion();

	/*Enable background thread*/
	 tim2_interrupt();

	 /*Enable external interruption routines*/
	 gpio_interrupt();

	Ts = 1.0/Fs;

	while(1)
	{
//		sensor_data = signal_data[y];

//		g_process_flg = 1;

		if(g_process_flg)
		{

			if(n < SIGNAL_LEN)
			{

//				x = (float32_t)mean_sensor_data/4095*3.3-1.1257;		//Offset atualizado para 0.0V de offset no gerador de função : 1.12 (arquivo .arb)
//				x = (float32_t)mean_sensor_data/4095*3.3-1.65;			// Amplitude para o gerador de funcoes: 1.533V
				x = (float32_t)mean_sensor_data/4095*3.3-1.65;

//				sinal[n] = x;

/*--------------Implementação da SWRDFT do Sinal Amostrado (SA)--------------------------------------------------------------------------------------------------------*/

				lastSample_SA = x;
				Sample_J_SA = buff_DFT_SA[a];

				for(b = 1; b < 7; b += 2)		// DFT ate o 5º harmônico
				{
//					re_SA[b] = re_ant_SA[b] + (lastSample_SA - Sample_J_SA)*cc[(b*a)%J];
//					im_SA[b] = im_ant_SA[b] + (lastSample_SA - Sample_J_SA)*ss[(b*a)%J];
					re_SA[b] = re_ant_SA[b] + (lastSample_SA - Sample_J_SA)*cc2[(b*a)%J];
					im_SA[b] = im_ant_SA[b] + (lastSample_SA - Sample_J_SA)*ss2[(b*a)%J];

					// 2/J = 2/128 = 0.015625, 2/64 = 0.03125
					harm_pointer_SA = &mag_DFT_SA[b];
					arm_sqrt_f32(re_SA[b]*re_SA[b] + im_SA[b]*im_SA[b], harm_pointer_SA);
					mag_DFT_SA[b] = 0.03125*mag_DFT_SA[b];

					if(b == 0)		// magnitude do componente d.c.
					{
						mag_DFT_SA[b] /= 2;
					}

					if(re_SA[b] == 0)
					{
						re_SA[b] = 0.000000001;
					}
					phi_pointer_SA = &phi_DFT_SA[b];
					arm_atan2_f32(im_SA[b],re_SA[b], phi_pointer_SA);
//					*phi_pointer_SA = atan2(im_SA[b], re_SA[b]);
					re_ant_SA[b] = re_SA[b];
					im_ant_SA[b] = im_SA[b];

				}

				buff_DFT_SA[a] = lastSample_SA;

				a++;
				if(a > (J - 1))
				{
					a = 0;
				}

				harm_1st_SA[n] = mag_DFT_SA[1];
				harm_3rd_SA[n] = mag_DFT_SA[3];
				harm_5th_SA[n] = mag_DFT_SA[5];

//				phi_1st_SA[n] = (phi_DFT_SA[1]+b*w0)*180/pi;
//				phi_3rd_SA[n] = phi_DFT_SA[3]*180/pi;
//				phi_5th_SA[n] = phi_DFT_SA[5]*180/pi;

/*--------------pre-filtro zero crossing--------------------------------------------------------------------------------------------------------*/
				/*Secao 1 */
				x1 = x*0.615089250452674;
				y11 = x1 - 1.976807847899757*x1_1 + x1_2 + 1.948321338555645*y1_1 - 0.962586582007368*y1_2;

				x1_2 = x1_1;
				x1_1 = x1;

				y1_2 = y1_1;
				y1_1 = y11;

				/*Secao 2*/
				x2 = y11*0.442537969917818;
				y2 = x2 - 1.956939074607570*x2_1 + x2_2 + 1.844400456753102*y2_1 - 0.863456551259050*y2_2;

				x2_2 = x2_1;
				x2_1 = x2;

				y2_2 = y2_1;
				y2_1 = y2;

				/*Secao 3 */
				x3 = y2*0.098185425944027;
				y3 = x3 - 1.699499939983501*x3_1 + x3_2 + 1.681701824664379*y3_1 - 0.711206551053305*y3_2;

				x3_2 = x3_1;
				x3_1 = x3;

				y3_2 = y3_1;
				y3_1 = y3;

//				sinal_filtrado[n] = y3;
				amostra_atual = y3;

/*--------------Zero Crossing-------------------------------------------------------------------------------------------------------------*/
				Tsc     = Tsc + Ts;

				if((amostra_anterior >= 0)) //completou 1 ciclo
				{
					if(amostra_atual <= 0)
				  {  // Frequência de 1 ciclo em 1 ciclo

					Nb      = amostra_atual / (amostra_atual - amostra_anterior);
					T2      = Nb*Ts;
					Tsc     = Tsc + T1 - T2;
					F       = 1/Tsc;
					T1      = T2;
					Tsc     = 0.0;
				   }
				}

//				F = 60;
//				frequencia_estimada[n] = F;
				amostra_anterior = amostra_atual;

				flag   = 1.0;
				Ts_out = 1.0/(J*F);
				lambda = Ts_out/Ts;

				if(F>54.0)
				{
					if(F<66.0)
					{
						if(flag == 1)
						{
							count = 0;
							while(alpha < 1)
							{
								y00 = 0.0;
								y01 = 0.0;
								y02 = 0.0;

								for(kk = 0; kk < 4; kk++)
								{
									y00 = y00 + H0[kk]*xbuf[kk];
									y01 = y01 + H1[kk]*xbuf[kk];
									y02 = y02 + H2[kk]*xbuf[kk];
								}
								saida_farrow = alpha*(alpha*(alpha*y00+y01)+y02)+xbuf[1];
//								sinal_interpolado[k] = saida_farrow;

								lastSample = saida_farrow;
//								lastSample = sinal_interpolado[k];
								Sample_J = buff_DFT[c];	//buff_DFT[c]
								alpha = alpha + lambda;

							    count = count + 1;
									/*--------------Implementação da SWRDFT do sinal interpolado---------------------------------------------------------------------------------*/
								for(b = 1; b < 7; b += 2)
								{
//								    	float32_t arg2 = (b*c)%J;
//								    	re[b] = re_ant[b] + (lastSample - Sample_J)*cc[(b*c)%J];
//								    	im[b] = im_ant[b] + (lastSample - Sample_J)*ss[(b*c)%J];
									re[b] = re_ant[b] + (lastSample - Sample_J)*cc2[(b*c)%J];
									im[b] = im_ant[b] + (lastSample - Sample_J)*ss2[(b*c)%J];

//										2/J = 2/128 = 0.015625, 2/64 = 0.03125
									harm_pointer = &mag_DFT[b];
									arm_sqrt_f32(re[b]*re[b] + im[b]*im[b], harm_pointer);
//									*harm_pointer = sqrt(re[b]*re[b] + im[b]*im[b]);
									mag_DFT[b] = 0.03125*mag_DFT[b];

									if(b == 0)		//magnitude do componente d.c.
									{
										mag_DFT[b] /= 2;
									}

									if(re_SA[b] == 0)
									{
										re_SA[b] = 0.000000001;
									}

									phi_pointer = &phi_DFT[b];
									arm_atan2_f32(im[b],re[b], phi_pointer);
//									*phi_pointer = atan2(im[b], re[b]);

									re_ant[b] = re[b];
									im_ant[b] = im[b];

								}

							    buff_DFT[c] = lastSample;	//buff_DFT[c]


							    c++;
							    if(c > (J - 1))
							    {
							    	c = 0;
							    }

//									harm_1st[k] = mag_DFT[1];
//									harm_3rd[k] = mag_DFT[3];
//									harm_5th[k] = mag_DFT[5];

//									phi_1st[k] = ((phi_DFT[1]+b*w0)*180/pi);
//									phi_3rd[k] = (phi_DFT[3]+b*w0)*180/pi;
//									phi_5th[k] = (phi_DFT[5]+b*w0)*180/pi;



								k++;		// mm = k

							}

							//alfa = (float)alfa - 1.0;
							alpha = alpha - 1.0;
						}
					}
				}

	            for(ii = 3; ii >= 1; ii--)    // deslocamento amostras buffer
	            {
	                xbuf[ii] = xbuf[ii-1];
	            }
	            xbuf[0] = x;    // próxima amostra aquisitada


	            y++;
	        	if(y == SIGNAL_LEN)
	        	{
	        		y = 0;
	        	}

				n++;
			}

			else
			{

//				for(int i = 0; i<SIGNAL_LEN; i++)
//				{
//					printf("%f\n\r",sinal[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",sinal_filtrado[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",frequencia_estimada[i]);
//				}
//
//				for(int i = 0; i<SIGNAL_LEN; i++)
//				{
//					printf("%f\n\r",sinal_interpolado[i]);
//				}

				for(int i = 0; i<N; i++)
				{
					printf("%f\n\r",harm_1st_SA[i]);
				}

				for(int i = 0; i<N; i++)
				{
					printf("%f\n\r",harm_3rd_SA[i]);
				}

				for(int i = 0; i<N; i++)
				{
					printf("%f\n\r",harm_5th_SA[i]);
				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",phi_1st_SA[i]);
//				}

//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",phi_3rd_SA[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",phi_5th_SA[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",harm_1st[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",harm_3rd[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",harm_5th[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",phi_1st[i]);
//				}

//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",phi_3rd[i]);
//				}
//
//				for(int i = 0; i<N; i++)
//				{
//					printf("%f\n\r",phi_5th[i]);
//				}

				n = 0;
			}

			/*Reset process flag*/
			g_process_flg = 0;

		}
	}
}

static void tim2_callback(void)
{
	for(ensemble = 0; ensemble < NUM_MEAN; ensemble++)
	{
		sensor_data += adc_read();
//		sensor_data += signal_data[y];
		contador++;
	}
	mean_sensor_data = (uint32_t)sensor_data/NUM_MEAN;    /*Acquisition from ADC*/
	sensor_data = 0;

//	sensor_data = signal_data[y];
	g_process_flg = 1;

}


void TIM2_IRQHandler(void)
{
	/*Clear update interrupt flag*/
	TIM2->SR &= ~SR_UIF;
	handler_flg++;
	/*Do something...*/
	tim2_callback();
}

void EXTI15_10_IRQHandler(void)
{
	GPIOA->BSRR = GPIO_BSRR_BS8;		/*Set GPIOA Pin 8 to HIGH*/
	TIM2->CR1 	= TIM_CR1_CEN;			/*Enable Timer 2 Counter*/

//	sensor_data = adc_read();    /*Acquisition from ADC*/
//	g_process_flg = 1;


	EXTI->PR = EXTI_PR_PR13;		//Trigger request ocurred
}

static void pseudo_dly(int dly)
{
	for( int i = 0; i < dly; i++ ){}
}
