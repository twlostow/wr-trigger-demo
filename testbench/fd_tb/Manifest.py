action = "simulation"
target = "xilinx"
fetchto = "../../ip_cores"
vlog_opt="+incdir+../../sim/wb +incdir+../../sim +incdir+../../sim +incdir+../../sim/gn4124_bfm +incdir+../../sim/fdelay"

files = [ "main.sv" ]

modules = { "local" :  [ "../../top/spec-fd", "../../sim/gn4124_bfm", "../../modules/streamers", "../../modules/trigger"] }

