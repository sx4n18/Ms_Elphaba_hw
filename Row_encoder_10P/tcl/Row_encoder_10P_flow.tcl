

##############################################################
# * Command tcl file
# * Created on Mon Mar 31 14:59:36 BST 2025 by Gen_doc_syn
##############################################################

source ../tcl/Row_encoder_10P_setup.tcl

read_hdl $RTL_LIST

elaborate

read_sdc ./Row_encoder_10P_constraint.sdc



set_db dft_scan_style muxed_scan
set_db dft_prefix DFT_
define_shift_enable -name SE -active high -create_port SE
check_dft_rules
	

syn_generic
syn_map
syn_opt

check_dft_rules
check_timing_intent
set_db design:Row_encoder_10P .dft_min_number_of_scan_chains 1
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports
connect_scan_chains -auto_create_chains
syn_opt -incremental
report_scan_chains
write_scandef > outputs/Row_encoder_10P_scanDEF.scandef
	

write_hdl > outputs/Row_encoder_10P_syn.v
write_sdc > outputs/Row_encoder_10P_syn.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split -setuphold split > outputs/Row_encoder_10P_delay.sdf

