@ECHO OFF
CALL PDV_MIN.BAT
DEL \SYSTEM\DISCO4\*.* < SIM.TXT
PKZIP \SYSTEM\DISCO4\SWSIG.ZIP MIN\*.*
COPY PDV_ATU.TXT C:\SYSTEM
