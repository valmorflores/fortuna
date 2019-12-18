@ECHO OFF
ECHO.
ECHO.# PDV.BAT - Execu‡„o do programa SWPDV de uma determinada vers„o
ECHO.
ECHO.. Formato : PDV nnnn (nnnn = versao)
ECHO.
ECHO.. Exemplo : PDV 2001
ECHO.
IF %1 .==. GOTO FIM
CD \DEVELOP\PDV3\PDV%1
ARJ E PDV%1
SWPDV.EXE

:FIM



















