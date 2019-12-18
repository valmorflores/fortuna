@ECHO OFF
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
ECHO.
ECHO.# PDV_VER.BAT - Salvamento do programa SWPDV em uma determinada vers„o
ECHO.
ECHO.. Formato : PDV_VER nnnn (nnnn = versao)
ECHO.
ECHO.. Exemplo : PDV_VER 2001
ECHO.
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
DIR PDV* /AD /ON
ECHO.

IF %1 .==. GOTO FIM
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
MD PDV%1
COPY SWPDV.EXE PDV%1
COPY *.PRG PDV%1
COPY *.INI PDV%1
COPY *.BMP PDV%1
COPY *.PTX PDV%1
ECHO "SWPDV v%1" > PDV_ATU.TXT

:FIM
ECHO.ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

