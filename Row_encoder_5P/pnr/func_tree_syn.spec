###############################################################
#  Generated by:      Cadence Innovus 21.35-s114_1
#  OS:                Linux x86_64(Host ID allman)
#  Generated on:      Mon Mar 24 15:41:01 2025
#  Design:            Row_encoder_5P
#  Command:           create_clock_tree_spec -out_file func_tree_syn.spec
###############################################################
#-------------------------------------------------------------------------------
# Clock tree setup script - dialect: Common UI
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

if { [get_db clock_trees] != {} } {
  error {Cannot run clock tree spec: clock trees are already defined.}
}

namespace eval ::ccopt {}
namespace eval ::ccopt::ilm {}
set ::ccopt::ilm::ccoptSpecRestoreData {}
# Start by checking for unflattened ILMs.
# Will flatten if so and then check the db sync.
if { [catch {ccopt_check_and_flatten_ilms_no_restore}] } {
  return -code error
}
# cache the value of the restore command output by the ILM flattening code
set ::ccopt::ilm::ccoptSpecRestoreData $::ccopt::ilm::ccoptRestoreILMState

# The following pins are clock sources
set_db port:clk .cts_is_sdc_clock_root true

# Clocks present at pin clk
#   CLK (period 25.000ns) in timing_config sdc_cons([./Row_encoder_5P_syn_dft_fun.sdc])
create_clock_tree -name CLK -source clk -no_skew_group
set_db clock_tree:CLK .cts_clock_tree_source_driver {INHDX1/A INHDX1/Q}
# Clock period setting for source pin of CLK
set_db port:clk .cts_clock_period 25

##############################################################################
##
## Timing connectivity based skew groups: off
##
##############################################################################
set_db cts_timing_connectivity_info {}

# Skew group to balance non generated clock:CLK in timing_config:sdc_cons (sdc ./Row_encoder_5P_syn_dft_fun.sdc)
create_skew_group -name CLK/sdc_cons -sources clk -auto_sinks
set_db skew_group:CLK/sdc_cons .cts_skew_group_include_source_latency true
set_db skew_group:CLK/sdc_cons .cts_skew_group_target_insertion_delay 2.500
set_db skew_group:CLK/sdc_cons .cts_skew_group_created_from_clock CLK
set_db skew_group:CLK/sdc_cons .cts_skew_group_created_from_constraint_mode sdc_cons
set_db skew_group:CLK/sdc_cons .cts_skew_group_created_from_delay_corners {max_delay min_delay}


check_clock_tree_convergence
# Restore the ILM status if possible
if { [get_db ccopt_auto_design_state_for_ilms] == 0 } {
  if {$::ccopt::ilm::ccoptSpecRestoreData != {} } {
    eval $::ccopt::ilm::ccoptSpecRestoreData
  }
}

