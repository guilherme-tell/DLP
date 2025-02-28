onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instruction_tb/clk
add wave -noupdate /instruction_tb/rst
add wave -noupdate -divider PC
add wave -noupdate /instruction_tb/riscv/PC/PC_out
add wave -noupdate -divider {Instr Mem}
add wave -noupdate -radix hexadecimal /instruction_tb/riscv/Inst_Mem/RD
add wave -noupdate /instruction_tb/riscv/Inst
add wave -noupdate -divider ALU
add wave -noupdate /instruction_tb/riscv/ALU/SrcA
add wave -noupdate /instruction_tb/riscv/ALU/SrcB
add wave -noupdate /instruction_tb/riscv/ALU/ALUCOntrol
add wave -noupdate /instruction_tb/riscv/ALUResult
add wave -noupdate -divider REGFile
add wave -noupdate -radix decimal /instruction_tb/riscv/RegFile/A1
add wave -noupdate -radix unsigned /instruction_tb/riscv/RegFile/A2
add wave -noupdate -radix decimal /instruction_tb/riscv/RegFile/A3
add wave -noupdate -radix hexadecimal /instruction_tb/riscv/RegFile/WD3
add wave -noupdate -radix decimal /instruction_tb/riscv/RegFile/WE3
add wave -noupdate -radix decimal /instruction_tb/riscv/RegFile/RD1
add wave -noupdate -radix hexadecimal /instruction_tb/riscv/RegFile/RD2
add wave -noupdate -radix hexadecimal /instruction_tb/riscv/RegFile/ram
add wave -noupdate -divider DataMem
add wave -noupdate -radix decimal /instruction_tb/riscv/Data_Mem/A
add wave -noupdate -radix hexadecimal /instruction_tb/riscv/Data_Mem/WD
add wave -noupdate -radix hexadecimal /instruction_tb/riscv/Data_Mem/RD
add wave -noupdate /instruction_tb/riscv/Data_Mem/mem
add wave -noupdate -divider Control
add wave -noupdate /instruction_tb/riscv/Control_Unit/MemWrite
add wave -noupdate /instruction_tb/riscv/Control_Unit/ResultSrc
add wave -noupdate /instruction_tb/riscv/Control_Unit/ImmSrc
add wave -noupdate /instruction_tb/riscv/Control_Unit/ALUSrc
add wave -noupdate /instruction_tb/riscv/Control_Unit/RegWrite
add wave -noupdate /instruction_tb/riscv/Control_Unit/PCSrc
add wave -noupdate /instruction_tb/riscv/Control_Unit/ALUControl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21875 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
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
WaveRestoreZoom {0 ps} {130183 ps}
