// ## CL2HB.EXE - Converted

#ifdef HARBOUR
static function swconfig()
#endif


LOCAL cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      cCor:= SetColor() 
 
SET SCOREBOARD OFF 
SETCOLOR( '15/07,15/04' ) 
SCROLL( 01, 00, 24, 79 ) 
Sele 100 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USE vpceicfg.dat 
XDIRETORIO:= UNZIPCHR( GDIR__ ) 
XEMPRESA:=   UNZIPCHR( DESCRI ) 
XLINE1:=     UNZIPCHR( LINE01 ) 
XLINE2:=     UNZIPCHR( LINE02 ) 
XLINE3:=     UNZIPCHR( LINE03 ) 
XLINE4:=     UNZIPCHR( LINE04 ) 
XLINE5:=     UNZIPCHR( LINE05 ) 
SETCOLOR( "00/15" ) 
@ 00,00 SAY  " SISTEMA DE CONFIGURACAO " + SPACE( 80 ) 
SETCOLOR( '15/07,15/04' ) 
@ 03,02 SAY "Diretorio de Trabalho: " GET XDIRETORIO 
@ 05,02 SAY "Empresa..............: " GET XEMPRESA 
@ 07,02 SAY "Linha 01.............: " GET XLINE1 
@ 09,02 SAY "Linha 02.............: " GET XLINE2 
@ 11,02 SAY "Linha 03.............: " GET XLINE3 
@ 13,02 SAY "Linha 04.............: " GET XLINE4 
@ 15,02 SAY "Linha 05.............: " GET XLINE5 
READ 
REPL GDIR__ WITH ZIPCHR(XDIRETORIO),; 
     DESCRI WITH ZIPCHR(XEMPRESA),; 
     LINE01 WITH ZIPCHR(XLINE1),; 
     LINE02 WITH ZIPCHR(XLINE2),; 
     LINE03 WITH ZIPCHR(XLINE3),; 
     LINE04 WITH ZIPCHR(XLINE4),; 
     LINE05 WITH ZIPCHR(XLINE5) 
SETCOLOR("W/N") 
SetColor( cCor ) 
ScreenRest( cTela ) 
Return Nil 
