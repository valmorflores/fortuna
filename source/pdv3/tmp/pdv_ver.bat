@ECHO OFF
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
ECHO.
ECHO.# PDV_VER.BAT - Salvamento do programa SWPDV em uma determinada vers꼘
ECHO.
ECHO.. Formato : PDV_VER nnnn (nnnn = versao)
ECHO.
ECHO.. Exemplo : PDV 2001
ECHO.
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
DIR PDV* /AD
ECHO.

IF %1 .==. GOTO FIM
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
MD PDV%1
COPY SWPDV.EXE PDV%1
COPY *.PRG PDV%1
COPY *.INI PDV%1
COPY *.BMP PDV%1
COPY *.PTX PDV%1

:FIM
ECHO.컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

