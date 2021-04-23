vlib work
vlib viterbilib

vcom -work work ../../src/decoder/viterbi_package.vhd

vcom -f vcomp.list
vcom ../bench/tb_systol_vit.vhd

vsim -novopt tb_systol_vit

add wave -hex -r *
#add wave -hex -r sim:/tb_systol_vit/dut/disreg/*
#add wave sim:/tb_systol_vit/*
run 100000 ns