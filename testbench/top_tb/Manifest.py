action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
vlog_opt="+incdir+../../sim/wb +incdir+../../sim +incdir+../../sim +incdir+../../sim/gn4124_bfm"

files = [ "main.sv" ]

modules = { "local" :  [ "../../top/spec-dio", "../../sim/gn4124_bfm", "../../modules/streamers", "../../modules/trigger"] }

