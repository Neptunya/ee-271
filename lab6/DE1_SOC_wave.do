onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/DE1_SOC_testbench/SW[9]}
add wave -noupdate /DE1_SOC_testbench/CLOCK_50
add wave -noupdate -label l_pressed /DE1_SOC_testbench/dut/btnL/pressed
add wave -noupdate -label r_pressed /DE1_SOC_testbench/dut/btnR/pressed
add wave -noupdate -label up {/DE1_SOC_testbench/KEY[3]}
add wave -noupdate -label down {/DE1_SOC_testbench/KEY[0]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[9]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[8]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[7]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[6]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[5]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[4]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[3]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[2]}
add wave -noupdate {/DE1_SOC_testbench/LEDR[1]}
add wave -noupdate -label winner_l /DE1_SOC_testbench/dut/ell/winner
add wave -noupdate -label winner_r /DE1_SOC_testbench/dut/elr/winner
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {459 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {7008 ps}
