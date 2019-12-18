para porta, Velocidade, tipo, byte, bit, arquivo, tecla
Local Retorno:= ""
Local Ret:= ""

if porta = nil
   porta:= ""
endif

if velocidade = nil
   velocidade:= ""
endif

if trim( porta )=="" 
   cls
   @ 00,00 SAY "Com2Say"
   @ 01,00 SAY "---------------------------------------------------"
   @ 03,00 SAY "This utility increase the serial port capture to "
   @ 04,00 SAY "a text file. For use with another application in "
   @ 05,00 SAY "scanner capture or other functions."

   @ 06,00 SAY "Author : VALMOR PEREIRA FLORES " Color "15/01"
   @ 06,00 SAY "Author :"

   @ 10,00 say "Syntax :"
   @ 12,00 say "com2say <port> <speed> [<parity>] [<bit>] [<stopbit>] [<file>] [<filekey>]" Color "15/00"
   @ 16,00 say "Samples:"
   @ 18,00 say "com2say COM2 9600 N 7 1 CAPTURE.TXT KEY.TXT" Color "15/00"
   @ 19,00 say "or"
   @ 20,00 say "com2say COM2 9600 N 7 1" Color "15/00"
   @ 23,00 say ""
   return nil

endif

if porta="COM1"
   porta:= "1"
endif
if porta="COM2"
   porta:= "2"
endif
if porta="COM3"
   porta:= "3"
endif
if porta="COM4"
   porta:= "4"
endif

velocidade:= "9600"
tipo:= "N"
bit:=  "1"
porta:= "2"

ComInit( val( velocidade ), tipo, val( byte ), val( bit ), val( porta ) )
pos:= 0
while .t.
   nTecla:= inkey()
   if nTecla > 0 .and. nTecla < 255
      if tecla <> nil
         memowrit( tecla, Chr( nTecla ) )
      endif
      exit
   endif
   ret:= ""
   if ComCheck( 2 )
      while comCheck( 2 )
          ret:= ret + comin( 2 )
      enddo
   endif
   IF !( TRIM( RET ) == "" )
      retorno:= retorno + RET
      IF AT( CHR( 13 ), RET ) > 0
         if arquivo = nil
            ?? retorno
         else
            memowrit( arquivo, retorno )
         endif
         retorno:= ""
         EXIT
      ENDIF
   ENDIF
enddo
