onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SOC_testbench/dut/clk_select
add wave -noupdate {/DE1_SOC_testbench/SW[9]}
add wave -noupdate /DE1_SOC_testbench/dut/sc1/reset_round
add wave -noupdate -label l_pressed /DE1_SOC_testbench/dut/btnL/pressed
add wave -noupdate -label r_pressed /DE1_SOC_testbench/dut/btnR/pressed
add wave -noupdate -label up {/DE1_SOC_testbench/KEY[3]}
add wave -noupdate -label down {/DE1_SOC_testbench/KEY[0]}
add wave -noupdate /DE1_SOC_testbench/dut/tap
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[9]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[8]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[7]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[6]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[5]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[4]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[3]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[2]}
add wave -noupdate -expand -group leds {/DE1_SOC_testbench/LEDR[1]}
add wave -noupdate -group winner -label l_winner /DE1_SOC_testbench/dut/ell/winner
add wave -noupdate -group winner /DE1_SOC_testbench/dut/sc1/l_win
add wave -noupdate -group winner /DE1_SOC_testbench/dut/sc1/l_count
add wave -noupdate -group winner -label r_winner /DE1_SOC_testbench/dut/elr/winner
add wave -noupdate -group winner /DE1_SOC_testbench/dut/sc1/r_win
add wave -noupdate -group winner /DE1_SOC_testbench/dut/sc1/r_count
add wave -noupdate -group winner /DE1_SOC_testbench/dut/sc1/ps
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/l
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/r
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/nl
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/nr
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/light_on
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/ps
add wave -noupdate -group {LEDR[4]} /DE1_SOC_testbench/dut/nl4/ns
add wave -noupdate -group center_light /DE1_SOC_testbench/dut/cl/nl
add wave -noupdate -group center_light /DE1_SOC_testbench/dut/cl/nr
add wave -noupdate -group center_light /DE1_SOC_testbench/dut/cl/light_on
add wave -noupdate -group center_light /DE1_SOC_testbench/dut/cl/ps
add wave -noupdate -group center_light /DE1_SOC_testbench/dut/cl/ns
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/l
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/r
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/nl
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/nr
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/light_on
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/ps
add wave -noupdate -group {LEDR[6]} /DE1_SOC_testbench/dut/nl6/ns
add wave -noupdate -group {LEDR[9]} /DE1_SOC_testbench/dut/ell/nr
add wave -noupdate -group {LEDR[9]} /DE1_SOC_testbench/dut/ell/light_on
add wave -noupdate -group {LEDR[9]} /DE1_SOC_testbench/dut/ell/ps
add wave -noupdate -group {LEDR[9]} /DE1_SOC_testbench/dut/ell/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2401 ps} 0}
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
