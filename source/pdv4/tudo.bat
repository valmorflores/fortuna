@ECHO OFF
IF %1 .==. GOTO FIM
CALL PDV_MIN.BAT
CALL PDV_VER.BAT %1
CALL INSTSYS.BAT

:FIM

