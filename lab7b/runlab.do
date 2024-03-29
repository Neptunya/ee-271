# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./dff_single.sv"
vlog "./dff_pair.sv"
vlog "./button_fsm.sv"
vlog "./center_light.sv"
vlog "./normal_light.sv"
vlog "./end_light_left.sv"
vlog "./end_light_right.sv"
vlog "./score_counter.sv"
vlog "./clock_divider.sv"
vlog "./cyberplayer.sv"
vlog "./comparator_10.sv"
vlog "./lfsr_10.sv"
vlog "./DE1_SOC.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SOC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SOC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
