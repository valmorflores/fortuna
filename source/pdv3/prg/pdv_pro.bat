@ECHO OFF
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
ECHO.
ECHO.# PDV_PRO.BAT - Prote뇙o de uma determinada vers꼘 do programa SWPDV
ECHO.
ECHO.. Formato : PDV_PRO nnnn (nnnn = versao)
ECHO.
ECHO.. Exemplo : PDV_PRO 2001
ECHO.
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
DIR PDV* /AD
ECHO.

IF %1 .==. GOTO FIM
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
ARJ M PDV%1\PDV%1 PDV%1\*.* -JM
rem ATTRIB +R PDV%1\*.PRG
rem ATTRIB +R PDV%1\*.EXE
rem ATTRIB +R PDV%1\*.INI
ATTRIB +R PDV%1\*.ARJ

:FIM
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�


