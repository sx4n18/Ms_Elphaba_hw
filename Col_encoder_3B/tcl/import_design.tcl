

###############################################################
## The load-up tcl file for the innovus flow
## Generated on Mon Mar  3 16:50:54 GMT 2025 by Gen_doc_pnr
##
## 
## 
###############################################################


set_db init_lef_files {/eda/design_kits/xkit_root/xh018/cadence/v9_0/techLEF/v9_0_1/xh018_xx31_MET3_METMID.lef /eda/design_kits/xkit_root/xh018/diglibs/D_CELLS_HD/v5_0/LEF/v5_0_0/xh018_D_CELLS_HD.lef /eda/design_kits/xkit_root/xh018/diglibs/D_CELLS_HD/v5_0/LEF/v5_0_0/xh018_xx31_MET3_METMID_D_CELLS_HD_mprobe.lef}
set_db init_mmmc_files {./General_MMMC.view}

set_db init_power_nets VDD
set_db init_ground_nets VSS

set_db init_read_netlist_files {/export/home/j05003sx/New_proj/Col_encoder_3B/syn/outputs/Col_encoder_3B_syn.v}


read_mmmc [get_db init_mmmc_files]
read_physical -lef [get_db init_lef_files]
read_netlist [get_db init_read_netlist_files]
init_design


gui_set_draw_view fplan


set_db design_process_node 180
## set_db extract_rc_lef_tech_file_map 

set_db place_global_cong_effort auto 
set_db place_global_clock_gate_aware true 

set_db opt_fix_drv_with_miller_cap true 
set_db opt_fix_fanout_load true 

set_multi_cpu_usage -local_cpu 4 -cpu_per_remote_host 1 -remote_host 0 -keep_license true -verbose -thread_info 2

set_distributed_hosts -local 

time_design -pre_place

write_db saved_design/import_design.inv


