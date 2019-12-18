// ## CL2HB.EXE - Converted
 
#Include "Inkey.Ch" 
#Include "VPF.Ch" 
 
#Define COR_FRENTE    "14/09" 
#Define COR_BOX       "15/09" 
#Define COR_TITULO    "00/" + LEFT( COR_BOX, 2 ) 
#Define COR_LETRA     "15/" + RIGHT( COR_BOX, 2 ) 
#Define COR_BARRA     "15/08" 
#Define COR_BROWSE    "15/01" 
#Define COR_DISPLAY   "14/" + RIGHT( COR_BOX, 2 ) 
#Define COR_IMP       "15/01" 
#Define COR_GET       COR_LETRA + ",14/01" 
#Define _IMPRESSORA   "IMPCFG00.SYS" 

#ifdef HARBOUR
function impcfg()
#endif


Local cScreen:= ScreenSave( 0, 0, 24, 79 ),; 
      nCursor:= SetCursor(), cCor:= SetColor(), lDelimiters:= Set(_SET_DELIMITERS,.F.) 
Local nLin:= 4, nCol:= 10, nLin1, nCol1, nLin2, nCol2, aStruct, oTb, nTecla,; 
      lEdita:= .F., lAppend:= .F., nRegistro:= 0,; 
      nC_Negr:= 0, nC_Ital:= 0, nC_Expa:= 0, nC_Cond:= 0, nC_Norm:= 0,; 
      cA_Negr:= Space( 14 ), cA_Ital:= Space( 14 ), cA_Expa:= Space( 14 ),; 
      cA_Cond:= Space( 14 ), cA_Norm:= Space( 14 ),; 
      cD_Negr:= Space( 14 ), cD_Ital:= Space( 14 ), cD_Expa:= Space( 14 ),; 
      cD_Cond:= Space( 14 ), cD_Norm:= Space( 14 ) 
 
   /* Criacao do arquivo de impressoras */ 
   If !File( _IMPRESSORA ) 
      aStruct:= { { "IMPRES", "C", 58, 00 },; 
                  { "C_NEGR", "N", 06, 00 },; 
                  { "C_ITAL", "N", 06, 00 },; 
                  { "C_EXPA", "N", 06, 00 },; 
                  { "C_COND", "N", 06, 00 },; 
                  { "C_NORM", "N", 06, 00 },; 
                  { "A_NEGR", "C", 34, 00 },; 
                  { "A_ITAL", "C", 34, 00 },; 
                  { "A_EXPA", "C", 34, 00 },; 
                  { "A_COND", "C", 34, 00 },; 
                  { "A_NORM", "C", 34, 00 },; 
                  { "D_NEGR", "C", 34, 00 },; 
                  { "D_ITAL", "C", 34, 00 },; 
                  { "D_EXPA", "C", 34, 00 },; 
                  { "D_COND", "C", 34, 00 },; 
                  { "D_NORM", "C", 34, 00 },; 
                  { "SELECT", "C", 01, 00 },; 
                  { "PORTA_", "C", 10, 00 } } 
      DBCreate( _IMPRESSORA, aStruct ) 
   EndIf 
 
   /* Abertura do arquivo de impressoras */ 
   DBSelectArea(1) 
   DBUseArea( .F.,, _IMPRESSORA, "IMP", .T., .F. ) 
 
   /* Teste de falha na abertura */ 
   If !Used() .OR. NetErr() 
      Mensagem("Arquivo n„o dispon¡vel. Pressione [ENTER] para continuar...") 
      Ajuda( "[ENTER]Coninua" ) 
      Pausa() 
   Else 
 
      /* Indexacao/Reindexacao */ 
      Mensagem("Organizando arquivo de impressoras, aguarde...") 
      If !File( "IMPCFG01.INT" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index on IMPRES to IMPCFG01.INT 
      EndIf 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Set Index to IMPCFG01.INT 
 
      /* Formata‡„o das vari veis para uso geral */ 
      nLin1:= nLin 
      nCol1:= nCol 
      nLin2:= nLin + 16 
      nCol2:= nCol + 62 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      UserScreen() 
 
      /* Ajuste da tela */ 
      DispBegin() 
      VPBox( nLin1, nCol1, nLin2, nCol2, "IMPRESSORAS", COR_BOX, .T., .T., COR_TITULO ) 
      SetColor( COR_LETRA ) 
      @ nLin1 + 2, nCol1 + 2  Say "IMPRESSORA" 
      @ nLin1 + 3, nCol1 + 2  Say "     Porta" 
      @ nLin1 + 4, nCol1 + 2  Say "ÚÄFontesÄÄÄÄÄÄ¿ÚÄCodigoÄÂÄÄÄÄÄAtivarÄÄÄÄÄÂÄÄÄÄDesativarÄÄÄ¿" 
      @ nLin1 + 5, nCol1 + 2  Say "³ Negrito     ³³        ³                ³                ³" 
      @ nLin1 + 6, nCol1 + 2  Say "³ It lico     ³³        ³                ³                ³" 
      @ nLin1 + 7, nCol1 + 2  Say "³ Expandido   ³³        ³                ³                ³" 
      @ nLin1 + 8, nCol1 + 2  Say "³ Condensado  ³³        ³                ³                ³" 
      @ nLin1 + 9, nCol1 + 2  Say "³ Normal      ³³        ³                ³                ³" 
      @ nLin1 + 10, nCol1 + 2 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" 
      @ nLin1 + 11, nCol1 + 2 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
      Mensagem( "[INS]Incluir [ENTER]Alterar [DEL]Excluir [ESPACO]Selecionar" ) 
      DispEnd() 
 
      /* Localiza a impressora selecionada */ 
      Locate For Imp->SELECT <> Space(1) 
      If( Eof(), DBGoTop(), NIL ) 
 
      SetCursor(0) 
      SetColor( _COR_BROWSE ) 
      oTB:= Tbrowsedb( nLin1 + 12, nCol1 + 2, nLin2 - 1, nCol2 - 2 ) 
      oTB:AddColumn( TBColumnNew(, {|| Left( IMP->IMPRES, 57 ) } ) ) 
      oTB:AddColumn( TBColumnNew(, {|| " " + IMP->SELECT } ) ) 
      oTB:ColSep:= "" 
      oTB:ColorSpec:= SetColor() + "," + COR_BOX 
      oTB:AutoLite:= .F. 
      oTB:DeHilite() 
      While .T. 
 
          oTB:ColorRect( { oTB:RowPos, 1, oTB:RowPos, 1 }, { 2, 1 } ) 
          oTB:ColorRect( { oTB:RowPos, 2, oTB:RowPos, 2 }, { 1, 3 } ) 
          While NextKey()==0 .AND. !oTB:Stabilize() 
          Enddo 
 
          DispBegin() 
          SetColor( _COR_GET_EDICAO ) 
          /* Apresentacao da configuracao principal */ 
          @ nLin1 + 2, nCol1 + 13 Say LEFT( Imp->IMPRES, 48 ) Color COR_IMP 
          @ nLin1 + 3, nCol1 + 13 Say PORTA_ Color COR_IMP 
 
          /* Negrito */ 
          @ nLin1 + 5, nCol1 + 19 Say Str( Imp->C_NEGR, 6, 0 ) Color COR_DISPLAY 
          @ nLin1 + 5, nCol1 + 28 Say Left( Imp->A_NEGR, 14 ) Color COR_DISPLAY 
          @ nLin1 + 5, nCol1 + 45 Say Left( Imp->D_NEGR, 14 ) Color COR_DISPLAY 
 
          /* Italico */ 
          @ nLin1 + 6, nCol1 + 19 Say Str( Imp->C_ITAL, 6, 0 ) Color COR_DISPLAY 
          @ nLin1 + 6, nCol1 + 28 Say Left( Imp->A_ITAL, 14 ) Color COR_DISPLAY 
          @ nLin1 + 6, nCol1 + 45 Say Left( Imp->D_ITAL, 14 ) Color COR_DISPLAY 
 
          /* Expandido */ 
          @ nLin1 + 7, nCol1 + 19 Say Str( Imp->C_EXPA, 6, 0 ) Color COR_DISPLAY 
          @ nLin1 + 7, nCol1 + 28 Say Left( Imp->A_EXPA, 14 ) Color COR_DISPLAY 
          @ nLin1 + 7, nCol1 + 45 Say Left( Imp->D_EXPA, 14 ) Color COR_DISPLAY 
 
          /* Condensado */ 
          @ nLin1 + 8, nCol1 + 19 Say Str( Imp->C_COND, 6, 0 ) Color COR_DISPLAY 
          @ nLin1 + 8, nCol1 + 28 Say Left( Imp->A_COND, 14 ) Color COR_DISPLAY 
          @ nLin1 + 8, nCol1 + 45 Say "Inutilizado   " Color COR_DISPLAY 
 
          /* Normal */ 
          @ nLin1 + 9, nCol1 + 19 Say Str( Imp->C_NORM, 6, 0 ) Color COR_DISPLAY 
          @ nLin1 + 9, nCol1 + 28 Say Left( Imp->A_NORM, 14 ) Color COR_DISPLAY 
          @ nLin1 + 9, nCol1 + 45 Say "Inutilizado   " Color COR_DISPLAY 
          SetColor( _COR_BROWSE ) 
          DispEnd() 
 
          /* Espera pela tecla */ 
          If ( nTecla:=inkey(0) ) == K_ESC 
             Exit 
          EndIf 
 
          /* Teste das teclas */ 
          Do Case 
             Case nTecla==K_INS 
 
                  cImpres:= Space( 58 ) 
 
                  nC_Negr:= nC_Ital:= nC_Expa:= nC_Cond:= nC_Norm:= 0 
                  cA_Negr:= cA_Ital:= cA_Expa:= cA_Cond:= cA_Norm:= Space( 34 ) 
                  cD_Negr:= cD_Ital:= cD_Expa:= cD_Cond:= cD_Norm:= Space( 34 ) 
                  cPorta_:= Space( Len( Porta_ ) ) 
 
                  lEdita:= .T. 
                  lAppend:= .T. 
 
             Case nTecla==K_DEL 
                  Exclui( oTb ) 
 
             Case nTecla==K_ENTER 
 
                  cImpres:= Imp->IMPRES 
                  nC_Negr:= Imp->C_NEGR 
                  nC_Ital:= Imp->C_ITAL 
                  nC_Expa:= Imp->C_EXPA 
                  nC_Cond:= Imp->C_COND 
                  nC_Norm:= Imp->C_NORM 
                  cA_Negr:= Imp->A_NEGR 
                  cA_Ital:= Imp->A_ITAL 
                  cA_Expa:= Imp->A_EXPA 
                  cA_Cond:= Imp->A_COND 
                  cA_Norm:= Imp->A_NORM 
                  cD_Negr:= Imp->D_NEGR 
                  cD_Ital:= Imp->D_ITAL 
                  cD_Expa:= Imp->D_EXPA 
                  cPorta_:= Imp->PORTA_ 
 
                  lEdita:= .T. 
 
             Case nTecla==K_UP         ;oTb:up() 
             Case nTecla==K_LEFT       ;oTb:up() 
             Case nTecla==K_RIGHT      ;oTb:down() 
             Case nTecla==K_DOWN       ;oTb:down() 
             Case nTecla==K_PGUP       ;oTb:pageup() 
             Case nTecla==K_PGDN       ;oTb:pagedown() 
             Case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
             Case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
             Case nTecla==K_SPACE 
 
                  Rlock() 
                  If !NetErr() 
                     Replace SELECT With Chr(17) 
                  EndIf 
                  nRegistro:= Recno() 
                  Locate For Imp->SELECT == Chr(17) .AND. Recno() <> nRegistro 
                  If !Eof() 
                     Rlock() 
                     If !NetErr() 
                        Replace Imp->SELECT With Space(1) 
                     Endif 
                  Endif 
                  DBGoto( nRegistro ) 
                  oTb:RefreshAll() 
 
             OtherWise                 ;tone(125); tone(300) 
          EndCase 
 
          If lEdita 
 
             SetCursor(1) 
             SetColor( COR_GET ) 
 
             DispBegin() 
             /* Inclusao de impressora */ 
             @ nLin1 + 2, nCol1 + 13 Get cImpres Pict "@S48" When Mensagem("Digite o nome da impressora.") Valid !Empty( cImpres ) 
             @ nLin1 + 3, nCol1 + 13 Get cPorta_ When Mensagem( "Digite a porta ou dispositivo de saida desta impressora." ) 
 
             /* Negrito */ 
             @ nLin1 + 5, nCol1 + 19 Get nC_Negr Pict "999999" When Mensagem("Digite o codigo do negrito.") 
             @ nLin1 + 5, nCol1 + 28 Get cA_Negr Pict "@S14" When Mensagem("Digite a sequencia de comandos para ativar o negrito.") 
             @ nLin1 + 5, nCol1 + 45 Get cD_Negr Pict "@S14" When Mensagem("Digite a sequencia de comandos para desativar o negrito.") 
 
             /* Italico */ 
             @ nLin1 + 6, nCol1 + 19 Get nC_Ital Pict "999999" When Mensagem("Digite o codigo do it lico.") 
             @ nLin1 + 6, nCol1 + 28 Get cA_Ital Pict "@S14" When Mensagem("Digite a sequencia de comandos para ativar o negrito.") 
             @ nLin1 + 6, nCol1 + 45 Get cD_Ital Pict "@S14" When Mensagem("Digite a sequencia de comandos para desativar o negrito.") 
 
             /* Expandido */ 
             @ nLin1 + 7, nCol1 + 19 Get nC_Expa Pict "999999" When Mensagem("Digite o codigo do expandido.") 
             @ nLin1 + 7, nCol1 + 28 Get cA_Expa Pict "@S14" When Mensagem("Digite a sequencia de comandos para ativar o expandido.") 
             @ nLin1 + 7, nCol1 + 45 Get cD_Expa Pict "@S14" When Mensagem("Digite a sequencia de comandos para desativar o expandido.") 
 
             /* Condensado */ 
             @ nLin1 + 8, nCol1 + 19 Get nC_Cond Pict "999999" 
             @ nLin1 + 8, nCol1 + 28 Get cA_Cond Pict "@S14" When Mensagem("Digite a sequencia de comandos para ativar o condensado.") 
 
             /* Normal */ 
             @ nLin1 + 9, nCol1 + 19 Get nC_Norm Pict "999999" 
             @ nLin1 + 9, nCol1 + 28 Get cA_Norm Pict "@S14" When Mensagem("Digite a sequencia de comandos para ativar o normal.") 
             DispEnd() 
             Read 
 
             If Lastkey()==K_ESC; Exit; Endif 
 
             SetCursor(0) 
             SetColor( COR_BROWSE + "," + COR_BARRA ) 
 
             If lAppend 
                DBAppend() 
             EndIf 
 
             Rlock() 
 
             /* Gravacao do registro */ 
             If !NetErr() 
                Replace IMPRES With cImpres,; 
                        C_NEGR With nC_Negr, A_NEGR With cA_Negr, D_NEGR With cD_Negr,; 
                        C_ITAL With nC_Ital, A_ITAL With cA_Ital, D_ITAL With cD_Ital,; 
                        C_EXPA With nC_Expa, A_EXPA With cA_Expa, D_EXPA With cD_Expa,; 
                        C_COND With nC_Cond, A_COND With cA_Cond,; 
                        C_NORM With nC_Norm, A_NORM With cA_Norm,; 
                        PORTA_ With cPorta_ 
             EndIf 
 
             /* Refaz Browse */ 
             oTb:RefreshAll() 
             While !oTb:Stabilize 
             EndDo 
 
             lEdita:= .F. 
             lAppend:= .F. 
 
             Mensagem( "Pressione [ENTER] para selecionar ou [ESC] para sair." ) 
 
          EndIf 
 
          oTb:RefreshCurrent() 
          oTb:Stabilize() 
 
      EndDo 
   EndIf 
   FechaArquivos() 
   Setcolor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cScreen ) 
   Set(_SET_DELIMITERS,lDelimiters) 
 
