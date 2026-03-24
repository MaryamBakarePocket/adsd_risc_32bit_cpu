
create_clock -name clk -period 20.000 [get_ports clk]
set_output_delay -clock clk 2.0 [get_ports LEDport[*]]
set_false_path -from [get_ports rst]
