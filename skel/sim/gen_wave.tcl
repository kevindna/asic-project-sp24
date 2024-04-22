# Begin_DVE_Session_Save_Info
# DVE view(Wave.1 ) session
# Saved on Sat Apr 20 20:43:46 2024
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 70 signals
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#<Session mode="View" path="/home/tmp/eecs151-laa/asic-project-sp24/skel/sim/gen_wave.tcl" type="Debug">

#<Database>

gui_set_time_units 1ps
#</Database>

# DVE View/pane content session: 

# Begin_DVE_Session_Save_Info (Wave.1)
# DVE wave signals session
# Saved on Sat Apr 20 20:43:46 2024
# 70 signals
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#Add ncecessay scopes
gui_load_child_values {rocketTestHarness}
gui_load_child_values {rocketTestHarness.dut}
gui_load_child_values {rocketTestHarness.dut.cpu0.decode0.rf}
gui_load_child_values {rocketTestHarness.dut.cpu0.decode0}
gui_load_child_values {rocketTestHarness.dut.cpu0.execute0}
gui_load_child_values {rocketTestHarness.dut.cpu0}

gui_set_time_units 1ps

set _wave_session_group_33 Group2
if {[gui_sg_is_group -name "$_wave_session_group_33"]} {
    set _wave_session_group_33 [gui_sg_generate_new_name]
}
set Group1 "$_wave_session_group_33"

gui_sg_addsignal -group "$_wave_session_group_33" { {V1:rocketTestHarness.reset} }

set _wave_session_group_34 Fetch
if {[gui_sg_is_group -name "$_wave_session_group_34"]} {
    set _wave_session_group_34 [gui_sg_generate_new_name]
}
set Group2 "$_wave_session_group_34"

gui_sg_addsignal -group "$_wave_session_group_34" { {V1:rocketTestHarness.dut.cpu0.decode0.stall} {V1:rocketTestHarness.dut.cpu0.mem_stall} {V1:rocketTestHarness.dut.cpu0.f_instr} {V1:rocketTestHarness.dut.cpu0.f_pc_nxt} }

set _wave_session_group_35 Decode
if {[gui_sg_is_group -name "$_wave_session_group_35"]} {
    set _wave_session_group_35 [gui_sg_generate_new_name]
}
set Group3 "$_wave_session_group_35"

gui_sg_addsignal -group "$_wave_session_group_35" { {V1:rocketTestHarness.dut.cpu0.decode0.instr} {V1:rocketTestHarness.dut.cpu0.decode0.opcode} {V1:rocketTestHarness.dut.cpu0.decode0.partial_ld} {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd} {V1:rocketTestHarness.dut.cpu0.decode0.pc} }
gui_set_radix -radix {opcode} -signals {V1:rocketTestHarness.dut.cpu0.decode0.opcode}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd}

set _wave_session_group_36 $_wave_session_group_35|
append _wave_session_group_36 {Instr Fields}
set {Decode|Instr Fields} "$_wave_session_group_36"

gui_sg_addsignal -group "$_wave_session_group_36" { {V1:rocketTestHarness.dut.cpu0.decode0.rs1} {V1:rocketTestHarness.dut.cpu0.decode0.rs2} {V1:rocketTestHarness.dut.cpu0.decode0.rd} {V1:rocketTestHarness.dut.cpu0.decode0.funct3} {V1:rocketTestHarness.dut.cpu0.decode0.funct7} {V1:rocketTestHarness.dut.cpu0.decode0.imm} }
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs1}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs1}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs2}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rs2}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rd}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rd}
gui_set_radix -radix {hex} -signals {V1:rocketTestHarness.dut.cpu0.decode0.imm}
gui_set_radix -radix {twosComplement} -signals {V1:rocketTestHarness.dut.cpu0.decode0.imm}

gui_sg_move "$_wave_session_group_36" -after "$_wave_session_group_35" -pos 3 

set _wave_session_group_37 $_wave_session_group_35|
append _wave_session_group_37 {Stall Logic}
set {Decode|Stall Logic} "$_wave_session_group_37"

gui_sg_addsignal -group "$_wave_session_group_37" { {V1:rocketTestHarness.dut.cpu0.stall} {V1:rocketTestHarness.dut.cpu0.decode0.stall_dly} {V1:rocketTestHarness.dut.cpu0.decode0.data_dep} {V1:rocketTestHarness.dut.cpu0.decode0.data_dep_check_rs1} {V1:rocketTestHarness.dut.cpu0.decode0.data_dep_check_rs2} {V1:rocketTestHarness.dut.cpu0.decode0.br_kill} {V1:rocketTestHarness.dut.cpu0.decode0.j_kill} }

gui_sg_move "$_wave_session_group_37" -after "$_wave_session_group_35" -pos 4 

set _wave_session_group_38 $_wave_session_group_35|
append _wave_session_group_38 {Branch Comp.}
set {Decode|Branch Comp.} "$_wave_session_group_38"

gui_sg_addsignal -group "$_wave_session_group_38" { {V1:rocketTestHarness.dut.cpu0.decode0.beq} {V1:rocketTestHarness.dut.cpu0.decode0.bge} {V1:rocketTestHarness.dut.cpu0.decode0.bgeu} }

gui_sg_move "$_wave_session_group_38" -after "$_wave_session_group_35" -pos 5 

set _wave_session_group_39 $_wave_session_group_35|
append _wave_session_group_39 {Mem INTF}
set {Decode|Mem INTF} "$_wave_session_group_39"

gui_sg_addsignal -group "$_wave_session_group_39" { {V1:rocketTestHarness.dut.cpu0.decode0.mem_re} {V1:rocketTestHarness.dut.cpu0.decode0.mem_stall} {V1:rocketTestHarness.dut.cpu0.decode0.mem_we} {V1:rocketTestHarness.dut.cpu0.decode0.mem_wdata} {V1:rocketTestHarness.dut.cpu0.decode0.mem_addr} }

gui_sg_move "$_wave_session_group_39" -after "$_wave_session_group_35" -pos 6 

set _wave_session_group_40 $_wave_session_group_35|
append _wave_session_group_40 {Register File}
set {Decode|Register File} "$_wave_session_group_40"

gui_sg_addsignal -group "$_wave_session_group_40" { {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr0} {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr1} {V1:rocketTestHarness.dut.cpu0.decode0.rf.rdata0} {V1:rocketTestHarness.dut.cpu0.decode0.rf.rdata1} {V1:rocketTestHarness.dut.cpu0.decode0.rf.we} {V1:rocketTestHarness.dut.cpu0.decode0.rf.waddr0} {V1:rocketTestHarness.dut.cpu0.decode0.rf.wdata} {V1:rocketTestHarness.dut.cpu0.decode0.rf.ram} }
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr0}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr0}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr1}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rf.raddr1}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rf.waddr0}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.rf.waddr0}

gui_sg_move "$_wave_session_group_40" -after "$_wave_session_group_35" -pos 7 

set _wave_session_group_41 $_wave_session_group_35|
append _wave_session_group_41 Writeback
set Decode|Writeback "$_wave_session_group_41"

gui_sg_addsignal -group "$_wave_session_group_41" { {V1:rocketTestHarness.dut.cpu0.decode0.wb_we} {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd} {V1:rocketTestHarness.dut.cpu0.decode0.wb_mask} {V1:rocketTestHarness.dut.cpu0.decode0.wb_op_sel} {V1:rocketTestHarness.dut.cpu0.decode0.wb_data} {V1:rocketTestHarness.dut.cpu0.decode0.wb_we_int} {V1:rocketTestHarness.dut.cpu0.decode0.wb_data_masked} }
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd}
gui_set_radix -radix {unsigned} -signals {V1:rocketTestHarness.dut.cpu0.decode0.wb_rd}

gui_sg_move "$_wave_session_group_41" -after "$_wave_session_group_35" -pos 8 

set _wave_session_group_42 Execute
if {[gui_sg_is_group -name "$_wave_session_group_42"]} {
    set _wave_session_group_42 [gui_sg_generate_new_name]
}
set Group4 "$_wave_session_group_42"

gui_sg_addsignal -group "$_wave_session_group_42" { {V1:rocketTestHarness.dut.cpu0.execute0.pc} {V1:rocketTestHarness.dut.cpu0.execute0.rs1data} {V1:rocketTestHarness.dut.cpu0.execute0.rs2data} {V1:rocketTestHarness.dut.cpu0.execute0.imm} {V1:rocketTestHarness.dut.cpu0.execute0.alu_out} {V1:rocketTestHarness.dut.cpu0.execute0.alu_op0} {V1:rocketTestHarness.dut.cpu0.execute0.alu_op1} {V1:rocketTestHarness.dut.cpu0.execute0.alu_op0_sel} {V1:rocketTestHarness.dut.cpu0.execute0.alu_op1_sel} }
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.execute0.imm}
gui_set_radix -radix {twosComplement} -signals {V1:rocketTestHarness.dut.cpu0.execute0.imm}
gui_set_radix -radix {decimal} -signals {V1:rocketTestHarness.dut.cpu0.execute0.alu_op1}
gui_set_radix -radix {twosComplement} -signals {V1:rocketTestHarness.dut.cpu0.execute0.alu_op1}

set _wave_session_group_43 $_wave_session_group_42|
append _wave_session_group_43 {Stage2 PP}
set {Execute|Stage2 PP} "$_wave_session_group_43"

gui_sg_addsignal -group "$_wave_session_group_43" { {V1:rocketTestHarness.dut.cpu0.execute0.aluopcode} {V1:rocketTestHarness.dut.cpu0.s2_pc_reg} {V1:rocketTestHarness.dut.cpu0.s2_rs1data_reg} {V1:rocketTestHarness.dut.cpu0.s2_rs2data_reg} {V1:rocketTestHarness.dut.cpu0.s2_rd_reg} {V1:rocketTestHarness.dut.cpu0.s2_imm_reg} {V1:rocketTestHarness.dut.cpu0.s2_mem_addr_reg} {V1:rocketTestHarness.dut.cpu0.s2_kill_reg} {V1:rocketTestHarness.dut.cpu0.s2_opcode} {V1:rocketTestHarness.dut.cpu0.s2_aluop_reg} }
gui_set_radix -radix {aluop} -signals {V1:rocketTestHarness.dut.cpu0.execute0.aluopcode}

set _wave_session_group_44 DCache
if {[gui_sg_is_group -name "$_wave_session_group_44"]} {
    set _wave_session_group_44 [gui_sg_generate_new_name]
}
set Group5 "$_wave_session_group_44"

gui_sg_addsignal -group "$_wave_session_group_44" { {V1:rocketTestHarness.dut.dcache_addr} {V1:rocketTestHarness.dut.dcache_din} {V1:rocketTestHarness.dut.dcache_dout} {V1:rocketTestHarness.dut.dcache_re} {V1:rocketTestHarness.dut.dcache_we} }
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
gui_wv_zoom_timerange -id ${Wave.1} 892338 1227931
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group1}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group2}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group3}]
gui_list_add_group -id ${Wave.1}  -after {rocketTestHarness.dut.cpu0.decode0.partial_ld[2:0]} [list ${Decode|Instr Fields}]
gui_list_add_group -id ${Wave.1} -after {Decode|Instr Fields} [list ${Decode|Stall Logic}]
gui_list_add_group -id ${Wave.1} -after {Decode|Stall Logic} [list ${Decode|Branch Comp.}]
gui_list_add_group -id ${Wave.1} -after {Decode|Branch Comp.} [list ${Decode|Mem INTF}]
gui_list_add_group -id ${Wave.1} -after {Decode|Mem INTF} [list ${Decode|Register File}]
gui_list_add_group -id ${Wave.1} -after {Decode|Register File} [list ${Decode|Writeback}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group4}]
gui_list_add_group -id ${Wave.1}  -after ${Group4} [list ${Execute|Stage2 PP}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group5}]
gui_list_collapse -id ${Wave.1} ${Group2}
gui_list_collapse -id ${Wave.1} ${Decode|Stall Logic}
gui_list_collapse -id ${Wave.1} ${Decode|Branch Comp.}
gui_list_collapse -id ${Wave.1} ${Decode|Mem INTF}
gui_list_collapse -id ${Wave.1} ${Decode|Register File}
gui_list_collapse -id ${Wave.1} ${Decode|Writeback}
gui_list_collapse -id ${Wave.1} ${Execute|Stage2 PP}
gui_list_select -id ${Wave.1} {rocketTestHarness.dut.cpu0.decode0.instr }
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
gui_list_set_insertion_bar  -id ${Wave.1} -group ${Group5}  -item {rocketTestHarness.dut.dcache_we[3:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 1010000
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
#</Session>

