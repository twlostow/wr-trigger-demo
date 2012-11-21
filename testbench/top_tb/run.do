#make -f Makefile
vsim -L unisim work.main -voptargs="+acc" -t 1ps
# -novopt 
 set StdArithNoWarnings 1
set NumericStdNoWarnings 1
do wave.do
radix -hexadecimal
run 200us
wave zoomfull
radix -hexadecimal
