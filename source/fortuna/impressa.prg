// ## CL2HB.EXE - Converted
function impressa()
Local nLin:= 10, nCol:= 10 
   nLin1:= nLin 
   nCol1:= nCol 
   nLin2:= nLin + 20 
   nCol2:= nCol + 63 
   VPBox( nLin1, nCol1, nLin2, nCol2, "IMPRESSORAS", Cor[16], .T., .T., Cor[15] ) 
   SetColor( Cor[16] ) 
   @ nLin1 + 2, nCol1 + 2  Say "IMPRESSORA" 
   @ nLin1 + 4, nCol1 + 2  Say "ÚÄFontesÄÄÄÄÄÄ¿ÚÄCodigoÄÂÄÄÄÄÄAtivarÄÄÄÄÄÂÄÄÄÄDesativarÄÄÄ¿" 
   @ nLin1 + 5, nCol1 + 2  Say "³ Negrito     ³³        ³                ³                ³" 
   @ nLin1 + 6, nCol1 + 2  Say "³ It lico     ³³        ³                ³                ³" 
   @ nLin1 + 7, nCol1 + 2  Say "³ Expandido   ³³        ³                ³                ³" 
   @ nLin1 + 8, nCol1 + 2  Say "³ Condensado  ³³        ³                ³                ³" 
   @ nLin1 + 9, nCol1 + 2  Say "³ Normal      ³³        ³                ³                ³" 
   @ nLin1 + 10, nCol1 + 2 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" 
   @ nLin1 + 11, nCol1 + 2 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
   @ nLin1 + 21, nCol1 + 2 Say " F2-Incluir  F3-Alterar  F4-Excluir  F5-Selecionar         " 
   Inkey(0) 
Return Nil 
