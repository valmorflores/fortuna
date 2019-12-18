@ECHO OFF
IF %1 .==. GOTO EDI_ESP
IF %2 .==. GOTO EDI_ESP
GOTO SALVA

:EDI_ESP
ECHO.
ECHO.# EDIT.BAT - Editor especial com salvamento !
ECHO.
ECHO.. Descri‡„o   : Este Batch chama o editor de textos salvando, anteci-
ECHO.                padamente, o texto a ser alterado, com a extens„o
ECHO.                .001, .002, .003, etc, no limite de 50, onde, chegan-
ECHO.                do … este ponto o .001 ‚ eliminado para a inclus„o do
ECHO.                novo n£meto .010
ECHO.
ECHO.  Observa‡”es : Para n„o utilizar o salvamento use ED ao inv‚s de EDIT
ECHO.
ECHO.. Formato     : EDIT arquivo extens„o [nao salva]
ECHO.
ECHO..              (Informe a extens„o do arquivo separadamente !)
ECHO.
ECHO.. Exemplo     : EDIT LEIA TXT
ECHO.
PAUSE > NUL
GOTO FIM

:SALVA
IF %1 .==. GOTO FIM
IF %2 .==. GOTO FIM
IF EXIST %1.%2 GOTO REN_000
rem ECHO.
rem ECHO.
rem ECHO. N„o existe %1.%2 !
rem ECHO.
rem PAUSE > NUL
rem GOTO FIM
DIR *.BAT > %1.%2
GOTO EDITA
                                   
:REN_000
IF NOT %3 .==. GOTO EDITA
IF EXIST %1.000 GOTO REN_001
COPY %1.%2 %1.000|GOTO EDITA

:REN_001
IF EXIST %1.001 GOTO REN_002
COPY %1.%2 %1.001|GOTO EDITA

:REN_002
IF EXIST %1.002 GOTO REN_003
COPY %1.%2 %1.002|GOTO EDITA

:REN_003
IF EXIST %1.003 GOTO REN_004
COPY %1.%2 %1.003|GOTO EDITA
:REN_004
IF EXIST %1.004 GOTO REN_005
COPY %1.%2 %1.004|GOTO EDITA
:REN_005
IF EXIST %1.005 GOTO REN_006
COPY %1.%2 %1.005|GOTO EDITA
:REN_006
IF EXIST %1.006 GOTO REN_007
COPY %1.%2 %1.006|GOTO EDITA
:REN_007
IF EXIST %1.007 GOTO REN_008
COPY %1.%2 %1.007|GOTO EDITA
:REN_008
IF EXIST %1.008 GOTO REN_009
COPY %1.%2 %1.008|GOTO EDITA
:REN_009
IF EXIST %1.009 GOTO REN_010
COPY %1.%2 %1.009|GOTO EDITA
:REN_010
IF EXIST %1.010 GOTO TROCA
COPY %1.%2 %1.010|GOTO EDITA
GOTO EDITA

:TROCA
ECHO.
ECHO.. Salvando %1 anteriores ...
ECHO.
DEL %1.001
REN %1.002 %1.001
REN %1.003 %1.002
REN %1.004 %1.003
REN %1.005 %1.004
REN %1.006 %1.005
REN %1.007 %1.006
REN %1.008 %1.007
REN %1.009 %1.008
REN %1.010 %1.009
GOTO REN_010

:EDITA
IF %3 .==. GOTO EDITAX
IF %3 ==NG  GOTO NG_EDITA

:EDITAX
ED.COM %1.%2
rem SHIFT
rem SHIFT
rem SHIFT
rem GOTO SALVA
GOTO FIM

:NG_EDITA
NG.EXE ED.COM %1.%2
rem SHIFT
rem SHIFT
rem SHIFT
rem GOTO SALVA
GOTO FIM

:FIM
ECHO.

