#include "common.ch"
#include "inkey.ch"

Function botao()

SWBotao( 02,02, " Inclusao ", "15" )
SWBotao( 06,02, " Inclusao ", "12" )
SWBotao( 10,02, " Inclusao ", "11" )
SWBotao( 14,02, " Inclusao ", "10" )
SWBotao( 18,02, " Inclusao ", "02" )

Function SWBotao( nLin, nCol, cBotao, cCorFundo, cCorTxt )


Local Local20, Local21

   Arg4:= 1
   Arg2:= 2
   Local10:= cBotao
   Arg1:= { cBotao, Nil, Nil, .F., Nil, nLin, nCol, cBotao, Len( cBotao )+6 }
   Arg6:= .T.
   Arg3:= { 0, 0, 0, 0, 0, 0, 0 }

      Local1:= "00/"+cCorFundo          /* Luminosidade / Fundo */
      Local4:= IF( cCorTxt==Nil, "15/01", cCorTxt )                                          /* Cor do Botao - Parte Interna */
      Local2:= Right( Local1, 2 ) + "/" + Right( Local4, 2 )    /* Luminosidade na esquerda */
      Local9:= Local4
      Local7:= ""
      Local8:= ""

      /* Desenho do Botao
       »……………………… 
       œ  Frase  À
       ŒÕÕÕÕÕÕÕÕÕÃ
      */

   if (Arg4 == 1)
      Local10:= padc( Local10, Arg1[ 9 ] - 3 )
      Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
      Local5:= iif(Arg1[4], Local3, Local4)
      Local8:= Local7
   elseif (Arg4 == 2)
      Local10:= padc(Local10, Arg1[9] - 3)
      Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
      Local5:= iif(Arg1[4], Local3, Local4)
      Local8:= Local6
   elseif (Arg4 == 3)
      Local10:= " " + Left(padc(Local10, Arg1[9] - 3), Arg1[9] - 4)
      Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
      Local5:= iif(Arg1[4], Local3, Local4)
      Local8:= Local6
   endif
   Local20:= At(alltrim(Local10), Local10) - 1
   Local21:= Local20 + Len(Arg1[1]) + 2

   if .t.
      Local12:= "»"
      Local13:= iif( Arg6, "…", "…")
      Local14:= " "
      Local15:= "À"
      Local16:= "Ã"
      Local17:= "Õ"
      Local18:= "Œ"
      Local19:= "œ"
   else
      Local12:= ""
      Local13:= iif(Arg6, "", "")
      Local14:= "∏"
      Local15:= "π"
      Local16:= "æ"
      Local17:= "œ"
      Local18:= "‘"
      Local19:= "€"
   endif

   DevPos( Arg1[6] - 1, Arg1[7] )
   devout( Local12 + Replicate(Local13, Arg1[9] - 2) + Local14, ;
      Local1)
   DevPos(Arg1[6], Arg1[7])
   devout(Local19, Local1)
   DevPos(Arg1[6], Arg1[7] + 1)
   devout("À", Local2)
   DevPos(Arg1[6], Arg1[7] + 2)
   devout(Local10, Local5)
   DevPos(Arg1[6], Arg1[7] + 2 + Local11)
   devout(Arg1[8], Local9)
   DevPos(Arg1[6], Arg1[7] + Arg1[9] - 1)
   devout(Local15, Local1)
   DevPos(Arg1[6] + 1, Arg1[7])
   devout(Local18 + Replicate(Local17, Arg1[9] - 2) + Local16, ;
      Local1)
   DevPos(Arg1[6], Arg1[7] + Local20)
   devout("", Local8)
   DevPos(Arg1[6], Arg1[7] + Local21)
   devout("", Local8)


