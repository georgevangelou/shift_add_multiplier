force -freeze sim:/testbench/Input1 5B 0
force -freeze sim:/testbench/Input2 10 0
force -freeze sim:/testbench/Start 0 0
run
force -freeze sim:/testbench/Start 1 0
run
force -freeze sim:/testbench/Start 0 0
run