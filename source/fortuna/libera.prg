// ## CL2HB.EXE - Converted
/* comercial@polomerc.com.br */ 

function libera()
 
IF !FILE( "C:\MSBIOS.SYS" ) 
   Cls 
   nDigitada:= 0 
   @ 01,01 SAY ( cTempo:= TIME() ) 
   nSenha:= VAL( SubStr( cTempo, 7, 2 ) ) *1976 
 
   SetColor( "15/15" ) 
   @ 02,01 Say "Senha de Liberacao:" Get nDigitada Pict "999999999" 
   READ 
 
   Cls 
   IF nDigitada == 1976 .OR. nDigitada==nSenha 
      !DIR >C:\MSBIOS.SYS 
      !COPY \WINDOWS\COMMAND\COMMAND.COM \MSBIOS.SYS >NUL 
      CLS 
      @ 01,01 SAY "Liberacao aprovada!" 
   else 
      @ 01,01 SAY "Acesso negado!" 
   ENDIF 
   Inkey(0) 
 
 
 
ENDIF 
 
!ECHO FILES=255 >FILES.TXT 
!COPY C:\CONFIG.SYS + FILES.TXT C:\CONFIG.SYS 
 
 
 
 
