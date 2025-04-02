

##############################################################
# * Command tcl file
# * Created on Wed Mar 12 13:45:54 GMT 2025 by Gen_doc_syn
##############################################################

source ../tcl/Col_encoder_3B_plus_setup.tcl

read_hdl $RTL_LIST

elaborate

read_sdc ./Col_encoder_3B_plus_constraint.sdc



syn_generic
syn_map
syn_opt

write_hdl > outputs/Col_encoder_3B_plus_syn.v
write_sdc > outputs/Col_encoder_3B_plus_syn.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split -setuphold split > outputs/Col_encoder_3B_plus_delay.sdf

