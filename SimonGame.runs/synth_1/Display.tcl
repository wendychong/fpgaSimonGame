# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Leilani/Documents/Game Simon/Game Simon.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Leilani/Documents/Game Simon/Game Simon.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/Leilani/Documents/Game Simon/Game Simon.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  {C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/sources_1/new/Display.v}
  {C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/sources_1/new/Yeah.v}
  {C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/sources_1/new/sequence.v}
  {C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/sources_1/new/button_sync.v}
  {C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/sources_1/new/counter.v}
  {C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/sources_1/new/delay.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/constrs_1/new/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Leilani/Documents/Game Simon/Game Simon.srcs/constrs_1/new/Basys3_Master.xdc}}]


synth_design -top Display -part xc7a35tcpg236-1


write_checkpoint -force -noxdef Display.dcp

catch { report_utilization -file Display_utilization_synth.rpt -pb Display_utilization_synth.pb }