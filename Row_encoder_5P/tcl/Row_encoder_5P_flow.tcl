

##############################################################
# * Command tcl file
# * Created on Wed Mar 19 11:19:42 GMT 2025 by Gen_doc_syn
##############################################################

source ../tcl/Row_encoder_5P_setup.tcl

read_hdl $RTL_LIST

elaborate

read_sdc ./Row_encoder_5P_constraint.sdc



syn_generic
set_db syn_map_effort medium
syn_map
syn_opt

write_hdl > outputs/Row_encoder_5P_syn_update.v
write_sdc > outputs/Row_encoder_5P_syn.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split -setuphold split > outputs/Row_encoder_5P_delay.sdf

