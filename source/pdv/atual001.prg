USE JVDADOS1.SIE EXCLUSIVE
DBGOTOP()
WHILE !EOF()
   IF TITULO==SPACE(15)
      DELE
   ENDIF
   @ 01,00 SAY NOME
   DBSKIP()
ENDDO
PACK
