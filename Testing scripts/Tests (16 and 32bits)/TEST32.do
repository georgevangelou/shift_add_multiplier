force -freeze sim:/testbench/Input1 12345678 0
force -freeze sim:/testbench/Input2 abcdef12 0
force -freeze sim:/testbench/Start 0 0
run
force -freeze sim:/testbench/Start 1 0
run
force -freeze sim:/testbench/Start 0 0
run