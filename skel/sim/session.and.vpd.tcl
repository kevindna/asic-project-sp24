# Begin_DVE_Session_Save_Info
# DVE view(Wave.1 ) session
# Saved on Sun Apr 14 13:01:23 2024
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 47 signals
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#<Session mode="View" path="/home/cc/eecs151/sp24/staff/eecs151-laa/asic-project-sp24/skel/sim/session.and.vpd.tcl" type="Debug">

#<Database>

gui_set_time_units 1ps
#</Database>

# DVE View/pane content session: 

# Begin_DVE_Session_Save_Info (Wave.1)
# DVE wave signals session
# Saved on Sun Apr 14 13:01:23 2024
# 47 signals
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#Add ncecessay scopes
gui_load_child_values {V1:rocketTestHarness.dut.cpu0.decode0.rf}
gui_load_child_values {V1:rocketTestHarness.dut.cpu0.decode0}
gui_load_child_values {V1:rocketTestHarness.dut.cpu0}

gui_set_time_units 1ps

set _wave_session_group_9 Fetch
if {[gui_sg_is_group -name "$_wave_session_group_9"]} {
    set _wave_session_group_9 [gui_sg_generate_new_name]
}
set Group1 "$_wave_session_group_9"

gui_sg_addsignal -group "$_wave_session_group_9" { {V1:rocketTestHarness.dut.cpu0.decode0.stall} {V1:rocketTestHarness.dut.cpu0.mem_stall} {V1:rocketTestHarness.dut.cpu0.f_instr} {V1:rocketTestHarness.dut.cpu0.f_pc_nxt} }

set _wave_session_group_10 Decode
if {[gui_sg_is_group -name "$_wave_session_group_10"]} {
    set _wave_session_group_10 [gui_sg_generate_new_name]
}
set Group2 "$_wave_session_group_10"

gui_sg_addsignal -group "$_wave_session_group_10" { {V1:rocketTestHarness.dut.cpu0.decode0.pc} {V1:rocketTestHarness.dut.cpu0.decode0.instr} {V1:rocketTestHarness.dut.cpu0.decode0.opcode} {V1:rocketTestHarness.dut.cpu0.stall} {V1:rocketTestHarness.dut.cpu0.decode0.stall_dly} {V1:rocketTestHarness.dut.cpu0.decode0.data_dep} {V1:rocketTestHarness.dut.cpu0.decode0.data_dep_check_rs1} {V1:rocketTestHarness.dut.cpu0.decode0.data_dep_check_rs2} {V1:rocketTestHarness.dut.cpu0.decode0.br_kill} {V1:rocketTestHarness.dut.cpu0.decode0.j_kill} {V1:rocketTestHarness.dut.cpu0.decode0.rs1} {V1:rocketTestHarness.dut.cpu0.decode0.rs2} {V1:rocketTestHarness.dut.cpu0.decode0.rd} {V2:rocketTestHarness.dut.cpu0.decode0.funct3} {V2:rocketTestHarness.dut.cpu0.decode0.funct7} {V2:rocketTestHarness.dut.cpu0.decode0.imm} {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd} }
gui_set_radix -radix {opcode} -signals {V1:rocketTestHarness.dut.cpu0.decode0.opcode}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs1}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs1}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs2}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs2}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rd}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rd}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd}

set _wave_session_group_11 $_wave_session_group_10|
append _wave_session_group_11 {Register File}
set {Decode|Register File} "$_wave_session_group_11"

gui_sg_addsignal -group "$_wave_session_group_11" { {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr0} {V1:rocketTestHarness.dut.cpu0.decode0.rf.rdata0} {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr1} {V1:rocketTestHarness.dut.cpu0.decode0.rf.rdata1} {V1:rocketTestHarness.dut.cpu0.decode0.rf.waddr0} {V1:rocketTestHarness.dut.cpu0.decode0.rf.wdata} {V1:rocketTestHarness.dut.cpu0.decode0.rf.ram} }

gui_sg_move "$_wave_session_group_11" -after "$_wave_session_group_10" -pos 17 

set _wave_session_group_12 Execute
if {[gui_sg_is_group -name "$_wave_session_group_12"]} {
    set _wave_session_group_12 [gui_sg_generate_new_name]
}
set Group3 "$_wave_session_group_12"

gui_sg_addsignal -group "$_wave_session_group_12" { {V2:rocketTestHarness.dut.cpu0.execute0.pc} {V2:rocketTestHarness.dut.cpu0.execute0.rs1data} {V2:rocketTestHarness.dut.cpu0.execute0.rs2data} {V2:rocketTestHarness.dut.cpu0.execute0.imm} {V2:rocketTestHarness.dut.cpu0.execute0.alu_out} {V2:rocketTestHarness.dut.cpu0.execute0.alu_op0} {V2:rocketTestHarness.dut.cpu0.execute0.alu_op1} {V2:rocketTestHarness.dut.cpu0.execute0.alu_op0_sel} {V2:rocketTestHarness.dut.cpu0.execute0.alu_op1_sel} }

set _wave_session_group_13 $_wave_session_group_12|
append _wave_session_group_13 {Stage2 PP}
set {Execute|Stage2 PP} "$_wave_session_group_13"

gui_sg_addsignal -group "$_wave_session_group_13" { {V2:rocketTestHarness.dut.cpu0.execute0.aluopcode} {V1:rocketTestHarness.dut.cpu0.s2_pc_reg} {V1:rocketTestHarness.dut.cpu0.s2_rs1data_reg} {V1:rocketTestHarness.dut.cpu0.s2_rs2data_reg} {V1:rocketTestHarness.dut.cpu0.s2_rd_reg} {V1:rocketTestHarness.dut.cpu0.s2_imm_reg} {V1:rocketTestHarness.dut.cpu0.s2_mem_addr_reg} {V1:rocketTestHarness.dut.cpu0.s2_kill_reg} {V1:rocketTestHarness.dut.cpu0.s2_opcode} {V1:rocketTestHarness.dut.cpu0.s2_aluop_reg} }
if {![info exists useOldWindow]} { 
	set useOldWindow true
}
if {$useOldWindow && [string first "Wave" [gui_get_current_window -view]]==0} { 
	set Wave.1 [gui_get_current_window -view] 
} else {
	set Wave.1 [lindex [gui_get_window_ids -type Wave] 0]
if {[string first "Wave" ${Wave.1}]!=0} {
gui_open_window Wave
set Wave.1 [ gui_get_current_window -view ]
}
}

set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 87777 474174
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group1}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group2}]
gui_list_add_group -id ${Wave.1}  -after {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd[4:0]} [list ${Decode|Register File}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group3}]
gui_list_add_group -id ${Wave.1}  -after ${Group3} [list ${Execute|Stage2 PP}]
gui_list_collapse -id ${Wave.1} ${Decode|Register File}
gui_list_collapse -id ${Wave.1} ${Execute|Stage2 PP}
gui_seek_criteria -id ${Wave.1} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group ${Execute|Stage2 PP}  -item {V2:rocketTestHarness.dut.cpu0.execute0.aluopcode[3:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 321464
gui_view_scroll -id ${Wave.1} -vertical -set 399
gui_show_grid -id ${Wave.1} -enable false
#</Session>

