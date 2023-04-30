onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/tb_Marketboard/SW[9]}
add wave -noupdate {/tb_Marketboard/SW[8]}
add wave -noupdate {/tb_Marketboard/SW[7]}
add wave -noupdate {/tb_Marketboard/SW[0]}
add wave -noupdate {/tb_Marketboard/LEDR[9]}
add wave -noupdate {/tb_Marketboard/LEDR[0]}
add wave -noupdate /tb_Marketboard/HEX0
add wave -noupdate /tb_Marketboard/HEX1
add wave -noupdate /tb_Marketboard/HEX2
add wave -noupdate /tb_Marketboard/HEX3
add wave -noupdate /tb_Marketboard/HEX4
add wave -noupdate /tb_Marketboard/HEX5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {150 ps} 0}
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
WaveRestoreZoom {0 ps} {426 ps}
