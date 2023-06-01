onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/DE1_SoC_testbench/SW[9]}
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate {/DE1_SoC_testbench/SW[8]}
add wave -noupdate {/DE1_SoC_testbench/SW[3]}
add wave -noupdate -label l /DE1_SoC_testbench/dut/btn_l/pressed
add wave -noupdate -label r /DE1_SoC_testbench/dut/btn_r/pressed
add wave -noupdate -label t /DE1_SoC_testbench/dut/btn_t/pressed
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/RedPixels[3]}
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/RedPixels[2]}
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/RedPixels[1]}
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/RedPixels[0]}
add wave -noupdate /DE1_SoC_testbench/dut/p_slct_c/current_x
add wave -noupdate /DE1_SoC_testbench/dut/p_slct_c/current_y
add wave -noupdate /DE1_SoC_testbench/dut/p_slct_c/next_x
add wave -noupdate /DE1_SoC_testbench/dut/p_slct_c/next_y
add wave -noupdate /DE1_SoC_testbench/dut/p_slct_c/l
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/GrnPixels[4]}
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/GrnPixels[3]}
add wave -noupdate {/DE1_SoC_testbench/dut/Driver/GrnPixels[2]}
add wave -noupdate -expand -group pn_30 /DE1_SoC_testbench/dut/pn_30/ps
add wave -noupdate -expand -group pn_30 /DE1_SoC_testbench/dut/pn_30/ns
add wave -noupdate -expand -group pn_31 /DE1_SoC_testbench/dut/pn_31/ps
add wave -noupdate -expand -group pn_31 /DE1_SoC_testbench/dut/pn_31/ns
add wave -noupdate -expand -group pn_32 /DE1_SoC_testbench/dut/pn_32/count
add wave -noupdate -expand -group pn_32 /DE1_SoC_testbench/dut/pn_32/ps
add wave -noupdate -expand -group pn_32 /DE1_SoC_testbench/dut/pn_32/ns
add wave -noupdate -expand -group pn_33 /DE1_SoC_testbench/dut/pn_33/ps
add wave -noupdate -expand -group pn_33 /DE1_SoC_testbench/dut/pn_33/ns
add wave -noupdate -expand -group pn_42 /DE1_SoC_testbench/dut/pn_42/count
add wave -noupdate -expand -group pn_42 /DE1_SoC_testbench/dut/pn_42/ps
add wave -noupdate -expand -group pn_42 /DE1_SoC_testbench/dut/pn_42/ns
add wave -noupdate -expand -group pn_22 /DE1_SoC_testbench/dut/pn_22/count
add wave -noupdate -expand -group pn_22 /DE1_SoC_testbench/dut/pn_22/ps
add wave -noupdate -expand -group pn_22 /DE1_SoC_testbench/dut/pn_22/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7556 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 98
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {3081 ps} {8321 ps}
