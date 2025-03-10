
##############################################################
# * Initialisation setup script 
# * Created on Fri Feb 28 17:35:18 GMT 2025 by Gen_doc_syn
##############################################################


date

set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR  "${LOCAL_DIR}/syn"
set TCL_PATH   "${LOCAL_DIR}/tcl"
set SDC_path   "${LOCAL_DIR}/syn"
set REPORTS_PATH   "${LOCAL_DIR}/syn/reports"
set PDK_PATH    "/eda/design_kits/xkit_root/xh018/"  
set LIB_PATH    "/eda/design_kits/xkit_root/xh018/diglibs/D_CELLS_HD/v5_0/liberty_LPMOS/v5_0_0/PVT_1_80V_range  \
/eda/design_kits/xkit_root/xh018/diglibs/D_CELLS_HD/v5_0/LEF/v5_0_0 \
/eda/design_kits/xkit_root/xh018/cadence/v9_0/techLEF/v9_0_1 \
/eda/design_kits/xkit_root/xh018/diglibs/IO_CELLS_3V/v2_1/liberty_LPMOS/v2_1_0/PVT_1_80V_3_30V_range"
set RTL_PATH    "${LOCAL_DIR}/rtl" 
set TECHLEF_PATH "/eda/design_kits/xkit_root/xh018/cadence/v9_0/techLEF/v9_0_1/" 

set DESIGN "Col_encoder_3B"  

# Baseline libraries

set LIB_LIST { 
D_CELLS_HD_LPMOS_slow_1_62V_125C.lib
IO_CELLS_3V_LPMOS_slow_1_62V_3_00V_125C.lib
}

set TECH_LEF_LIST { 
xh018_xx31_MET3_METMID.lef
}

set LEF_CELL_LIST { 
xh018_D_CELLS_HD.lef 
xh018_xx31_MET3_METMID_D_CELLS_HD_mprobe.lef 
} 

set LEF_LIST [concat $TECH_LEF_LIST $LEF_CELL_LIST]

# Baseline RTL
set RTL_LIST {
Col_encoder_3B.v
}

set_db hdl_track_filename_row_col true
set_db lp_power_unit mW
set_db init_lib_search_path $LIB_PATH
set_db script_search_path $TCL_PATH
set_db init_hdl_search_path $RTL_PATH
set_db error_on_lib_lef_pin_inconsistency true

read_libs $LIB_LIST

read_physical -lef $LEF_LIST     
