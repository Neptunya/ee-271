# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./pixel_start.sv"
vlog "./pixel_selected_coords.sv"
vlog "./pixel_selected.sv"
vlog "./pixel_norm.sv"
vlog "./adjacent_lights_counter.sv"
vlog "./LEDDriver.sv"
vlog "./DE1_SoC.sv"
vlog "./clock_divider.sv"
vlog "./button_fsm.sv"
vlog "./dff_pair.sv"
vlog "./dff_single.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
