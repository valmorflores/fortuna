@ECHO OFF
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
ECHO.
ECHO.# PDV_PRO.BAT - Prote‡„o de uma determinada vers„o do programa SWPDV
ECHO.
ECHO.. Formato : PDV_PRO nnnn (nnnn = versao)
ECHO.
ECHO.. Exemplo : PDV_PRO 2001
ECHO.
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
DIR PDV* /AD
ECHO.

IF %1 .==. GOTO FIM
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
ARJ M PDV%1\PDV%1 PDV%1\*.* -JM
rem ATTRIB +R PDV%1\*.PRG
rem ATTRIB +R PDV%1\*.EXE
rem ATTRIB +R PDV%1\*.INI
ATTRIB +R PDV%1\*.ARJ

:FIM
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


