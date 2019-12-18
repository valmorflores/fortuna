@ECHO OFF
:PDV
CD \DEVELOP\PDV3
SWPDV.EXE
CLS
ECHO. Acione Ctrl+C para encerrar ou outra tecla para entrar no FORTUNA ...
PAUSE > NUL

CD \DEVELOP\FORTUNA
CALL SWCEI.BAT
CLS
ECHO. Acione Ctrl+C para encerrar ou outra tecla para entrar no PDV ...
PAUSE > NUL
GOTO PDV
