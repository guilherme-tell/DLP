onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /senhas_tb/clk
add wave -noupdate -radix unsigned /senhas_tb/senha
add wave -noupdate /senhas_tb/rst
add wave -noupdate /senhas_tb/enter
add wave -noupdate /senhas_tb/acesso/enter_sync
add wave -noupdate /senhas_tb/resultado
add wave -noupdate -divider {memory adress}
add wave -noupdate -radix unsigned /senhas_tb/acesso/myCNT/count
add wave -noupdate -divider CONTROL
add wave -noupdate /senhas_tb/acesso/mycontrol/state
add wave -noupdate /senhas_tb/acesso/mycontrol/reset_cnt
add wave -noupdate -radix unsigned /senhas_tb/acesso/mycontrol/ena_cnt
add wave -noupdate -radix unsigned /senhas_tb/acesso/mycontrol/out_mem
add wave -noupdate /senhas_tb/acesso/FC
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {3265690 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 238
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10500 ns}
