@ECHO OFF
GOTO NORMAL
IF %1 .==. GOTO NORMAL
rem IF %1 == TC GOTO EDIT_TC
rem IF %1 == tc GOTO EDIT_TC
rem IF %1 == PC GOTO EDIT_PC
rem IF %1 == pc GOTO EDIT_PC
rem IF %1 == 82 GOTO EDIT_82
GOTO FIM

rem ED VPC88300.PRG VPC88200.PRG VPC27000.PRG VPC21110.PRG VPC21111.PRG
rem ED VPCINITC.PRG
rem ED vpbibcei.prg vpc55100.prg pednfis.prg nfiscal.prg
rem NG CALL EDIT.BAT VPCINITC PRG
rem NG ED CONV_VPB.PRG GRUPOS.PRG
rem NG ED VPCINIPC.PRG
rem NG ED VPCINIPC.PRG VPCMOVPC.PRG
rem NG ED VPCMOVPC.PRG VPC69999.PRG
rem CALL EDIT.BAT VPCINIPC PRG VPCINITC PRG

:EDIT_PC
CALL EDIT.BAT VPCINIPC PRG %1
GOTO FIM

:EDIT_82
CALL EDIT.BAT VPC88200 PRG %1
GOTO FIM

:EDIT_TC
CALL EDIT.BAT VPCINITC PRG %1
GOTO FIM

:NORMAL
rem CALL EDIT.BAT VPCINIPC PRG %1
CALL EDIT.BAT SWPDV PRG %1

:FIM

