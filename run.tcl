create_project cordic_verif ./.cordic_verif -part xc7a100tcsg324-1 -force
source top.tcl
make_wrapper -files [get_files ./.cordic_verif/cordic_verif.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ./.cordic_verif/cordic_verif.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
launch_runs impl_1 -to_step write_bitstream -jobs 10
wait_on_run impl_1
file copy ./.cordic_verif/cordic_verif.runs/impl_1/design_1_wrapper.bit ./cordic_verif.bit

