@ECHO OFF

IF %1 .==. GOTO FIM
IF NOT %1 == PODE GOTO FIM

COPY MIN\SWPDV.EXE
COPY MIN\PDV.INI
COPY MIN\LOGOTIPO.BMP
COPY MIN\FUNDO.BMP
COPY MIN\AGSYSA14.PTX
COPY MIN\AGSYSD10.PTX
COPY MIN\AGSYSD10.PTX
COPY MIN\DGE1609.PTX
COPY MIN\RMN1914.PTX
COPY MIN\VSYS14.PTX

COPY PRG\*.INI
COPY PRG\*.PRG
COPY PRG\*.BAT
COPY PRG\*.INC
COPY PRG\*.TXT

rem COPY PRG\PDVN.INI
rem COPY PRG\PDVB.INI
rem COPY PRG\SWPDV.PRG
rem COPY PRG\C.BAT
rem COPY PRG\L.BAT
rem COPY PRG\E.BAT
rem COPY PRG\F.BAT
rem COPY PRG\CLF.BAT
rem COPY PRG\SAL.BAT
rem COPY PRG\SAL.INC
rem COPY PRG\EDIT.BAT
rem COPY PRG\INST.BAT
rem COPY PRG\INSTALA.BAT
rem COPY PRG\PKUNZIP.EXE
rem COPY PRG\BOXFILL.TXT
rem COPY PRG\LEIA.TXT
rem COPY PRG\PDV.BAT
rem COPY PRG\PDV_VER.BAT

:FIM

