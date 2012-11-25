target = "xilinx"
action = "synthesis"

fetchto = "../../ip_cores"

syn_device = "xc6slx45t"
syn_grade = "-3"
syn_package = "fgg484"
syn_top = "spec_top"
syn_project = "trigdist-spec-fd.xise"

files = ["wrc.ram"]
modules = { "local" : 
						[ "../../top/spec-fd" ] 
					}
