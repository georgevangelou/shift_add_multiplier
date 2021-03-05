force -freeze sim:/testbench/Input1 02 0
force -freeze sim:/testbench/Input2 01 0
force -freeze sim:/testbench/Start 0 0
run
force -freeze sim:/testbench/Start 1 0
run
force -freeze sim:/testbench/Start 0 0
run