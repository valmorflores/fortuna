REM Sample of use for com2say
REM -------------------------------------------------------------------------
REM By Valmor Pereira Flores
:start
del codebar.txt >nul
com2say COM2 9600 N 7 1 codebar.txt key.txt
type codebar.txt
pause
goto start
