onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/center_light_testbench/SW[9]}
add wave -noupdate /center_light_testbench/CLOCK_50
add wave -noupdate {/center_light_testbench/LEDR[6]}
add wave -noupdate {/center_light_testbench/LEDR[5]}
add wave -noupdate {/center_light_testbench/LEDR[4]}
add wave -noupdate /center_light_testbench/l_pressed
add wave -noupdate /center_light_testbench/r_pressed
add wave -noupdate {/center_light_testbench/KEY[3]}
add wave -noupdate {/center_light_testbench/KEY[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {5231 ps}
