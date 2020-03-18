
set TclPath [file dirname [file normalize [info script]]]
set NewLoc [string range $TclPath 0 [string last / $TclPath]-5]

set PartDev "xc7a50tftg256-1"
set PrjDir [string range $TclPath 0 [string last / $NewLoc]]
set TopName [string range $NewLoc [string last / $NewLoc]+1 end]

set PrjName $TopName.xpr
set SrcDir $PrjDir/$TopName/src
set VivNm "vivado"
set VivDir $PrjDir/$TopName/$VivNm

cd $PrjDir/$TopName
pwd

if {[file exists $VivNm] == 1} { file delete -force $VivNm }
file mkdir $VivNm
cd $VivDir

set SrcVer [findFiles "$SrcDir/rtl" "*.s*v"]
set SrcXCI [findFiles "$SrcDir/xci" "*.xci"]
set SrcXDC [findFiles "$SrcDir/xdc" "*.xdc"]
set SrcTcl [findFiles "$SrcDir/tcl" "*.tcl"]
set SrcSim [findFiles "$SrcDir/tb" "*.s*v"]


create_project -force $TopName $VivDir -part $PartDev
set_property target_language Verilog [current_project]

if { $SrcVer != ""} { add_files 					-norecurse $SrcVer }
if { $SrcXCI != ""} { add_files 					-norecurse $SrcXCI }
if { $SrcXDC != ""} { add_files -fileset constrs_1  -norecurse $SrcXDC }
if { $SrcTcl != ""} { add_files 					-norecurse $SrcTcl }

if { $SrcSim != ""} { add_files -fileset sim_1 		-norecurse $SrcSim }

foreach str $SrcTcl {
    if { [string match "\*create.tcl" $str] == 1 } {
        set_property is_enabled false [get_files  $str]
    }
}


