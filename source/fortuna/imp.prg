// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
/* layOut da pagina de Configuracao da impressora 
 
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
 ³ Impressora                                                             ³ 
 ³ Driver                                                                 ³ 
 ÃÄFontesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ 
 ³ Compactado 1  [XXXXXXXXXXXXXXXXXXXX] ³ 6 L.P.Polegada  [XXXXXXXXXXXXX] ³ 
 ³ Compactado 2  [XXXXXXXXXXXXXXXXXXXX] ³ 8 L.P.Polegada  [XXXXXXXXXXXXX] ³ 
 ³ Compactado 3  [XXXXXXXXXXXXXXXXXXXX] ³ Comprimento Pag [XXXXXXXXXXXXX] ³ 
 ³ Compactado 4  [XXXXXXXXXXXXXXXXXXXX] ³ PCOMPR          [XXXXXXXXXXXXX] ³ 
 ³ Compactado 5  [XXXXXXXXXXXXXXXXXXXX] ³ LCOMPR          [XXXXXXXXXXXXX] ³ 
 ³ Expandido On  [XXXXXXXXXXXXXXXXXXXX] ³ Porta           [XXXX]          ³ 
 ³ Expandido Off [XXXXXXXXXXXXXXXXXXXX] ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ 
 ³ Negrito       [XXXXXXXXXXXXXXXXXXXX] ³                                 ³ 
 ³ Normal        [XXXXXXXXXXXXXXXXXXXX] ÃÄFormato PapelÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ 
 ³ Carta On      [XXXXXXXXXXXXXXXXXXXX] ³ Retrato  [XXXXXXXXXXXXXXXXXXXX] ³ 
 ³ Carta Off     [XXXXXXXXXXXXXXXXXXXX] ³ Paisagem [XXXXXXXXXXXXXXXXXXXX] ³ 
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ 
 ³                                                                        ³ 
 ³                                                                        ³ 
 ³                                                                        ³ 
 ³                                                                        ³ 
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ IMPCFG 
³ Finalidade  ³ Configuracao da Impressora 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpCfg() 
 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBox( 01, 02, 21, 76, " CONFIGURACAO DE IMPRESSORAS " ) 
VPBox( 17, 02, 21, 76, " Impressoras Dispon¡veis ", , , , ) 
VPBox( 04, 02, 16, 40, , ,.F.,.F. ) 
VPBox( 04, 41, 12, 76, , ,.F.,.F. ) 
Sele 124 
IF !Used() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use CFGIMP 
ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Index On Nome To Indic023 
DisplayInfo() 
Mensagem( "[ENTER]Altera [INS]Inclui [DEL]Exclui [ESC]Finaliza" ) 
oTB:=tbrowsedb( 18, 03, 20, 75 ) 
oTB:addcolumn(tbcolumnnew(,{|| NOME + Space( 50 ) + SELECT + Space( 10 ) })) 
oTB:AUTOLITE:=.f. 
oTB:dehilite() 
WHILE .T. 
   oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTB:stabilize() 
   enddo 
   DisplayInfo() 
   nTecla:=inkey(0) 
   If nTecla=K_ESC 
      exit 
   EndIf 
   do case 
      case nTecla==K_UP         ;oTB:up() 
      case nTecla==K_LEFT       ;oTB:up() 
      case nTecla==K_RIGHT      ;oTB:down() 
      case nTecla==K_DOWN       ;oTB:down() 
      case nTecla==K_PGUP       ;oTB:pageup() 
      case nTecla==K_PGDN       ;oTB:pagedown() 
      case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
      case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
      case nTecla==K_ENTER 
           AlteraImpressora( oTb ) 
      Case nTecla==K_INS 
           IncluiImpressora( oTb ) 
      Case nTecla==K_DEL 
           IF Exclui( oTb ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
           ENDIF 
      Case DBPesquisa( nTecla, oTb ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTB:refreshcurrent() 
   oTB:stabilize() 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ DISPLAYINFO 
³ Finalidade  ³ Apresenta informacoes das impressoras 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 15/08/98 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function DisplayInfo() 
@ 02,03 Say "Impressora: " + NOME 
@ 03,03 Say "Driver....: " + DRIVER 
@ 05,03 Say "Descompactado " + Left( COMP0, 20 ) 
@ 06,03 Say "Compactado 1  " + Left( COMP1, 20 ) 
@ 07,03 Say "Compactado 2  " + Left( COMP2, 20 ) 
@ 08,03 Say "Compactado 3  " + Left( COMP3, 20 ) 
@ 09,03 Say "Compactado 4  " + Left( COMP4, 20 ) 
@ 10,03 Say "Expandido On  " + Left( EXPL, 20 ) 
@ 11,03 Say "Expandido Off " + Left( EXPD, 20 ) 
@ 12,03 Say "Negrito       " + Left( NEG, 20 ) 
@ 13,03 Say "Normal        " + Left( NOR, 20 ) 
@ 14,03 Say "Carta On      " + Left( CARTL, 20 ) 
@ 15,03 Say "Carta Off     " + Left( CARTD, 20 ) 
@ 05,42 Say "6 L.P.Polegada   " + left( LPP6, 15 ) 
@ 06,42 Say "8 L.P.Polegada   " + left( LPP8, 15 ) 
@ 07,42 Say "Def.Compr.Pagina " + Left( COMPRIMENT, 15 ) 
@ 08,42 Say "Def.Pag.Retrato  " + Left( PORTRAIT, 15 ) 
@ 09,42 Say "Def.Pag.Paisagem " + Left( LANDSCAPE, 15 ) 
@ 13,42 Say "C. Pag. P. Retr  " + Str( PCOMPR, 3 ) 
@ 14,42 Say "C. Pag. Paisagem " + Str( LCOMPR, 3 ) 
@ 15,42 Say "Porta            " + PORTA 
Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ AlteraImpressora 
³ Finalidade  ³ Inclusao de uma impressora 
³ Parametros  ³ oTb=Tbrowse principal 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 15/08/98 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function AlteraImpressora( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local cNome:= NOME, cDriver:= DRIVER,; 
      cComp0:= COMP0, cComp1:= COMP1, cComp2:= COMP2, cComp3:= COMP3,; 
      cComp4:= COMP4, cComp5:= COMP5,; 
      cExpL:= EXPL, cExpD:= EXPD, cNeg:= NEG, cNor:= NOR,; 
      cCartaL:= CARTL, cCartaD:= CARTD, cLPP6:= LPP6, cLPP8:= LPP8,; 
      cCompriment:= COMPRIMENT, cPortrait:= PORTRAIT, cLandScape:= LANDSCAPE,; 
      nComprLandscape:= LCOMPR, nComprPortrait:= PCOMPR,; 
      cPorta:= PORTA, cSelect:= SELECT 
 
   Set( _SET_DELIMITERS, .F. ) 
   @ 02,03 Say "Impressora:" Get cNome 
   @ 03,03 Say "Driver....:" Get cDriver 
   @ 05,03 Say "Desconpactado" Get cComp0 Pict "@S20" 
   @ 06,03 Say "Compactado 1 " Get cComp1 Pict "@S20" 
   @ 07,03 Say "Compactado 2 " Get cComp2 Pict "@S20" 
   @ 08,03 Say "Compactado 3 " Get cComp3 Pict "@S20" 
   @ 09,03 Say "Compactado 4 " Get cComp4 Pict "@S20" 
   @ 10,03 Say "Expandido On " Get cExpL  Pict "@S20" 
   @ 11,03 Say "Expandido Off" Get cExpD  Pict "@S20" 
   @ 12,03 Say "Negrito      " Get cNeg   Pict "@S20" 
   @ 13,03 Say "Normal       " Get cNor   Pict "@S20" 
   @ 14,03 Say "Carta On     " Get cCartaL Pict "@S20" 
   @ 15,03 Say "Carta Off    " Get cCartaD Pict "@S20" 
   @ 05,42 Say "6 L.P.Polegada  " Get cLPP6 Pict "@S15" 
   @ 06,42 Say "8 L.P.Polegada  " Get cLPP8 Pict "@S15" 
   @ 07,42 Say "Def.Compr.Pagina" Get cCompriment Pict "@S15" 
   @ 08,42 Say "Def.Pag.Retrato " Get cPortrait   Pict "@S15" 
   @ 09,42 Say "Def.Pag.Paisagem" Get cLandscape  Pict "@S15" 
   @ 13,42 Say "C. Pag. P. Retr " Get nComprPortrait Pict "999" 
   @ 14,42 Say "C. Pag. Paisagem" Get nComprLandScape Pict "999" 
   @ 15,42 Say "Porta           " Get cPorta 
   READ 
   Set( _SET_DELIMITERS, .T. ) 
   IF NetRLock() 
      Replace NOME With cNome,; 
              DRIVER With cDriver,; 
              COMP0   With cComp0,; 
              COMP1   With cComp1,; 
              COMP2   With cComp2,; 
              COMP3   With cComp3,; 
              COMP4   With cComp4,; 
              COMP5   With cComp5,; 
              EXPL    With cExpL,; 
              EXPD    With cExpD,; 
              NEG     With cNeg,; 
              NOR     With cNor,; 
              CARTL   With cCartaL,; 
              CARTD   With cCartaD,; 
              LPP6    With cLPP6,; 
              LPP8    With cLPP8,; 
              COMPRIMENT With cCompriment,; 
              PORTRAIT With cPortrait,; 
              LANDSCAPE With cLandScape,; 
              LCOMPR   With nComprLandscape,; 
              PCOMPR   With nComprPortrait,; 
              PORTA    With cPorta,; 
              SELECT   With cSelect 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ IncluiImpressora 
³ Finalidade  ³ Inclusao de uma impressora 
³ Parametros  ³ oTb=Tbrowse principal 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 15/08/98 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function IncluiImpressora( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local cNome:= Space( Len( NOME ) ), cDriver:= Space( Len( DRIVER ) ),; 
      cComp0:= Space( Len( COMP0 ) ), cComp1:= Space( Len( COMP1 ) ),; 
      cComp2:= Space( Len( COMP2 ) ), cComp3:= Space( Len( COMP3 ) ),; 
      cComp4:= Space( Len( COMP4 ) ), cComp5:= Space( Len( COMP5 ) ),; 
      cExpL:= Space( Len( EXPL ) ), cExpD:= Space( Len( EXPD ) ),; 
      cNeg:= Space( Len( NEG ) ), cNor:= Space( Len( NOR ) ),; 
      cCartaL:= Space( Len( CARTL ) ), cCartaD:= Space( Len( CARTD ) ),; 
      cLPP6:= Space( Len( LPP6 ) ), cLPP8:= Space( Len( LPP8 ) ),; 
      cCompriment:= Space( Len( COMPRIMENT ) ), cPortrait:= Space( Len( PORTRAIT ) ),; 
      cLandScape:= Space( Len( LANDSCAPE ) ), nComprLandscape:= 0,; 
      nComprPortrait:= 0, cPorta:= Space( Len( PORTA ) ),; 
      cSelect:= Space( Len( SELECT ) ) 
 
   Set( _SET_DELIMITERS, .F. ) 
   @ 02,03 Say "Impressora:" Get cNome 
   @ 03,03 Say "Driver....:" Get cDriver 
   @ 05,03 Say "Descompactado" Get cComp0 Pict "@S20" 
   @ 06,03 Say "Compactado 1 " Get cComp1 Pict "@S20" 
   @ 07,03 Say "Compactado 2 " Get cComp2 Pict "@S20" 
   @ 08,03 Say "Compactado 3 " Get cComp3 Pict "@S20" 
   @ 09,03 Say "Compactado 4 " Get cComp4 Pict "@S20" 
   @ 10,03 Say "Expandido On " Get cExpL  Pict "@S20" 
   @ 11,03 Say "Expandido Off" Get cExpD  Pict "@S20" 
   @ 12,03 Say "Negrito      " Get cNeg   Pict "@S20" 
   @ 13,03 Say "Normal       " Get cNor   Pict "@S20" 
   @ 14,03 Say "Carta On     " Get cCartaL Pict "@S20" 
   @ 15,03 Say "Carta Off    " Get cCartaD Pict "@S20" 
   @ 05,42 Say "6 L.P.Polegada  " Get cLPP6 Pict "@S15" 
   @ 06,42 Say "8 L.P.Polegada  " Get cLPP8 Pict "@S15" 
   @ 07,42 Say "Def.Compr.Pagina" Get cCompriment Pict "@S15" 
   @ 08,42 Say "Def.Pag.Retrato " Get cPortrait   Pict "@S15" 
   @ 09,42 Say "Def.Pag.Paisagem" Get cLandscape  Pict "@S15" 
   @ 13,42 Say "C. Pag. P. Retr " Get nComprPortrait Pict "999" 
   @ 14,42 Say "C. Pag. Paisagem" Get nComprLandScape Pict "999" 
   @ 15,42 Say "Porta           " Get cPorta 
   READ 
   Set( _SET_DELIMITERS, .T. ) 
   DBAppend() 
   IF NetRLock() 
      Replace NOME With cNome,; 
              DRIVER With cDriver,; 
              COMP0   With cComp0,; 
              COMP1   With cComp1,; 
              COMP2   With cComp2,; 
              COMP3   With cComp3,; 
              COMP4   With cComp4,; 
              COMP5   With cComp5,; 
              EXPL    With cExpL,; 
              EXPD    With cExpD,; 
              NEG     With cNeg,; 
              NOR     With cNor,; 
              CARTL   With cCartaL,; 
              CARTD   With cCartaD,; 
              LPP6    With cLPP6,; 
              LPP8    With cLPP8,; 
              COMPRIMENT With cCompriment,; 
              PORTRAIT With cPortrait,; 
              LANDSCAPE With cLandScape,; 
              LCOMPR   With nComprLandscape,; 
              PCOMPR   With nComprPortrait,; 
              PORTA    With cPorta,; 
              SELECT   With cSelect 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   oTb:RefreshAll() 
   WHILE !oTb:Stabilize() 
   ENDDO 
   Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ SELECAOIMPRESSORA 
³ Finalidade  ³ Seleciona a impressora 
³ Parametros  ³ lAutomatica = (.T./.F.) Selecao autom tica da impressora? 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 07/Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function SelecaoImpressora( lAutomatica ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local oTb, nTecla, nRegistro 

DBSelectAr( 1 )
// dbselectAr( 124 )
//IF !Used() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use CFGIMP.DBF Alias CFGIMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On NOME TO Indice00 
//ENDIF 
IF lAutomatica 
   DBGoTop() 
   WHILE !EOF() 
      IF ALLTRIM( PORTA ) == "<PADRAO>" .OR. SELECT=="*" 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         IF nArea > 0 
            DBSelectAr( nArea ) 
         ENDIF 
         Return .T. 
      ENDIF 
      DBSkip() 
   ENDDO 
   DBGoTop() 
   IF nArea > 0 
      DBSelectAr( nArea ) 
   ENDIF 
   Return .T. 
ELSE 
   DBGoTop() 
   WHILE .T. 
       IF Select == "*" 
          Exit 
       ENDIF 
       DBSkip() 
       IF EOF() 
          DBGoTop() 
          IF NetRLock() 
             Replace Select With "*" 
          ENDIF 
          Exit 
       ENDIF 
   ENDDO 
   VPBox( 02, 02, 21, 76, "Selecao de Impressora", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   oTB:= tbrowsedb( 03, 03, 20, 75 ) 
   oTB:addcolumn(tbcolumnnew(,{|| NOME + Space( 43 ) + IF( SELECT == "*", "<PADRAO>", Space(8) ) + Space( 10 ) })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   WHILE .T. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTB:up() 
         case nTecla==K_LEFT       ;oTB:up() 
         case nTecla==K_RIGHT      ;oTB:down() 
         case nTecla==K_DOWN       ;oTB:down() 
         case nTecla==K_PGUP       ;oTB:pageup() 
         case nTecla==K_PGDN       ;oTB:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
         case nTecla==K_ENTER 
              nRegistro:= RECNO() 
              DBGOTOP() 
              WHILE !EOF() 
                 IF Select == "*" .OR. Alltrim( PORTA )=="<PADRAO>" 
                    IF NetRLock() 
                       Replace Select With " ",; 
                               Porta  With Space( Len( PORTA ) ) 
                    ENDIF 
                 ENDIF 
                 DBSkip() 
              ENDDO 
              DBGoTo( nRegistro ) 
              IF NetRLock() 
                 Replace SELECT With "*",; 
                         PORTA  With "<PADRAO>" 
              ENDIF 
              EXIT 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   IF nArea > 0 
      DBSelectAr( nArea ) 
   ENDIF 
   Return .T. 
ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return .F. 
 
