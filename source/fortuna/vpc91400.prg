// ## CL2HB.EXE - Converted
#include "inkey.ch" 
#Include "vpf.ch" 
 
/* 
��������������Ŀ 
�       Funcao � VPC910000 
�   Finalidade � Exibir menu de comissoes 
�         Data � 
�  Atualizacao � 
�  Programador � VALMOR PEREIRA FLORES 
���������������� 
*/ 

#ifdef HARBOUR
function vpc91400()
#endif


  loca cTELA:=zoom(09,24,15,47), cCOR:=setcolor(), nOPCAO:=0
  DBSelectAr( _COD_COMISSAO ) 
  IF !Used() 
     FDBUseVpb( _COD_COMISSAO, 2 ) 
  ENDIF 
  vpbox(09,24,15,47) 
  whil .t. 
     mensagem("") 
     aadd(MENULIST,menunew(10,25," 1 Verif. Individual ",2,COR[11],; 
          "Verificacao individual de comissoes.",,,; 
          COR[6],.T.)) 
     aadd(MENULIST,menunew(11,25," 2 Verif. Totais     ",2,COR[11],; 
          "Verificacao dos totais de comissoes.",,,; 
          COR[6],.T.)) 
     aadd(MENULIST,menunew(12,25," 3 Baixa             ",2,COR[11],; 
          "Baixa das comissoes pagas.",,,; 
          COR[6],.T.)) 
     aadd(MENULIST,menunew(13,25," 4 Calcula           ",2,COR[11],; 
          "Calcula as comissoes pagas.",,,; 
          COR[6],.T.)) 
     aadd(MENULIST,menunew(14,25," 0 Retorna           ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
     menumodal(MENULIST,@nOPCAO); MENULIST:={} 
     do case 
        case nOPCAO=5 .OR. lastkey()=K_ESC ; exit 
        case nOpcao==1; VerIndividual() 
        case nOpcao==2; VerTotais() 
        case nOpcao==3; Baixa() 
        case nOpcao==4 
             CalculoGeral() 
     endcase 
  enddo 
  unzoom(cTELA) 
  setcolor(cCOR) 
  DBSelectAr( _COD_COMISSAO ) 
  DBCloseArea() 
return nil 
 
 
Static Function Baixa() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, cDescri, cTelaRes 
 
   IF !AbreGrupo( "COMISSOES" ) 
      Return Nil 
   ENDIF 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   DBSelectAr( _COD_VENDEDOR ) 
   SetColor( _COR_BROW_BOX ) 
   DBLeOrdem() 
   VPBox( 03, 02, 18, 55, "Tabela de Vendedores", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ENTER] para visualizar as comissoes do vendedor.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   DBLeOrdem() 
   oTab:=tbrowsedb( 04, 03, 17, 54 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| STRZERO( Codigo, 6, 0) })) 
   oTab:addcolumn(tbcolumnnew("Nome", {|| DESCRI } )) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,2},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      oTab:left() 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:up() 
         case nTecla==K_RIGHT      ;oTab:down() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_ENTER      ;BaixaComissoes() 
         case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   FechaArquivos() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 
   Return(.T.) 
 
 
 
STATIC FUNCTION VerIndividual() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, cDescri, cTelaRes 
 
   IF !AbreGrupo( "COMISSOES" ) 
      Return Nil 
   ENDIF 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   DBSelectAr( _COD_VENDEDOR ) 
   DBLeOrdem() 
   VPBox( 03, 02, 18, 55, "Tabela de Vendedores", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ENTER] para visualizar as comissoes do vendedor.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   oTab:=tbrowsedb( 04, 03, 17, 54 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| STRZERO( Codigo, 6, 0) })) 
   oTab:addcolumn(tbcolumnnew("Nome", {|| DESCRI } )) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,2},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:up() 
         case nTecla==K_RIGHT      ;oTab:down() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_ENTER      ;VisualComissoes() 
         case nTecla==K_F2 
              DBMudaOrdem( 1, oTab ) 
         case nTecla==K_F3 
              DBMudaOrdem( 2, oTab ) 
         case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   FechaArquivos() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 
   Return(.T.) 
 
 
STATIC FUNCTION VerTotais() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, cDescri, cTelaRes, nTotPend:=0, nTotDisp:= 0,; 
      nSaldoAnterior:= 0, nRow:= 1, aVendedores:= {}, nCt:= 0 
Static dDataInicio, dDataFim 
 
   IF !AbreGrupo( "COMISSOES" ) 
      Return Nil 
   ENDIF 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   /* Definicao de periodo */ 
   IF dDataInicio == NIL 
      dDataInicio:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ) 
      dDataFim:= Date() 
   ENDIF 
   VPBox( 14, 30, 18, 76, ,_COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   @ 15,33 Say "Periodo para verificacao de comissoes" 
   @ 16,33 Say "Inicial.:" Get dDataInicio 
   @ 17,33 Say "Final...:" Get dDataFim 
   READ 
 
   DBSelectAr( _COD_VENDEDOR ) 
   DBGoTop() 
   WHILE !EOF() 
      nTotDisp:= 0 
      nTotPend:= 0 
      nSaldoAnterior:= 0 
      DBSelectAr( _COD_COMISSAO ) 
      DBGoTop() 
      WHILE !EOF() 
         IF DTDisp < dDataInicio .AND. NFNULA==" " .AND. VENDE_ == VEN->CODIGO 
            nSaldoAnterior+= VALOR_ 
            IF SITUA_ == "LIBERADA  " 
               nTotDisp+= VALOR_ 
            ELSEIF SITUA_ == "PENDENTE  " 
               nTotPend+= VALOR_ 
            ENDIF 
         ELSEIF DTDisp >= dDataInicio .AND. DTDisp <= dDataFim .AND.; 
            NFNula==" " .AND. VENDE_ == VEN->CODIGO 
            @ 19,60 Say "Registro#" + StrZero( ++nCt, 4, 0 ) 
            IF SITUA_ == "LIBERADA  " 
               nTotDisp+= VALOR_ 
            ELSEIF SITUA_ == "PENDENTE  " 
               nTotPend+= VALOR_ 
            ENDIF 
         ENDIF 
         DBSkip() 
      ENDDO 
      DBSelectAr( _COD_VENDEDOR ) 
      AAdd( aVendedores, { CODIGO, DESCRI, nSaldoAnterior, nTotPend, nTotDisp } ) 
      DBSkip() 
   ENDDO 
   VPBox( 03, 09, 21, 78, "Situacao dos Vendedores", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ENTER] para visualizar as comissoes do vendedor.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   oTab:=tbrowseNew( 04, 10, 20, 77 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| STRZERO( aVendedores[ nRow ][ 1 ], 6, 0) })) 
   oTab:addcolumn(tbcolumnnew("Nome", {|| Left( aVendedores[ nRow ][ 2 ], 30 ) } )) 
   oTab:addcolumn(tbcolumnnew("Sdo.Ant.", {|| Tran( aVendedores[ nRow ][ 3 ], "@E 99,999.99" ) } )) 
   oTab:addcolumn(tbcolumnnew("Pendente", {|| Tran( aVendedores[ nRow ][ 4 ], "@E 9999.9999" ) } )) 
   oTab:addcolumn(tbcolumnnew("  Liberada", {|| Tran( aVendedores[ nRow ][ 5 ], "@E 9,999.9999" ) } )) 
   oTab:AUTOLITE:=.f. 
   oTab:GOTOPBLOCK :={|| nRow:=1} 
   oTab:GOBOTTOMBLOCK:={|| nRow:=len( aVendedores )} 
   oTab:SKIPBLOCK:={|WTOJUMP| SkipperArr(WTOJUMP, aVendedores,@nRow)} 
   oTab:dehilite() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,5},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:up() 
         case nTecla==K_RIGHT      ;oTab:down() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   FechaArquivos() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 
   Return(.T.) 
 
/***** 
�������������Ŀ 
� Funcao      � BaixaComissoes 
� Finalidade  � Visualizacao das comissoes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
STATIC FUNCTION BaixaComissoes() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOrdem:= IndexOrd(), nArea:= Select() 
Local aComissoes:= {}, nRow:= 1, nTecla:= 0, nCt:= 0, nTotDisp:= 0,; 
      nSaldoAnterior:= 0, nTst, WTOJUMP, oTab, nCodMv_:= 0, lBaixa:= .F.,; 
      nTotGeral:= 0, nIni, nFim, nTotPago:= 0 
Local GetList:= {} 
Static dDataInicio, dDataFim 
   /* Definicao de periodo */ 
   IF dDataInicio == NIL 
      dDataInicio:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ) 
      dDataFim:= Date() 
   ENDIF 
   VPBox( 16, 30, 20, 76, , _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   @ 17,33 Say "Periodo para verificacao de comissoes" 
   @ 18,33 Say "Inicial.:" Get dDataInicio 
   @ 19,33 Say "Final...:" Get dDataFim 
   READ 
   SetCursor( 0 ) 
   IF LastKey() <> K_ESC 
      DBSelectAr( _COD_COMISSAO ) 
      DBSetOrder( 3 ) 
      DBGoTop() 
 
      /* Localiza o ultimo lancamento 
         de baixa de comissoes */ 
      WHILE !EOF() 
         IF CODMV_ >= nCodMv_ .AND. VENDE_ == VEN->CODIGO 
            nCodMv_:= CODMV_ + 1 
         ENDIF 
         DBSkip() 
      ENDDO 
 
      AAdd( aComissoes, { CTOD( "  /  /  " ), 0, "SALDO ANTERIOR.........................", 0, Space( 10 ), 0, 0, 0, 0, 0, 0 } ) 
      DBGoTop() 
      WHILE !EOF() 
         IF DTDisp < dDataInicio .AND. NFNULA==" " .AND. VENDE_ == VEN->CODIGO 
            nSaldoAnterior+= VALOR_ 
            nTotDisp+= VLRDSP 
            nTotPago+= VLRPAG 
         ELSEIF DTDisp >= dDataInicio .AND. DTDisp <= dDataFim .AND.; 
            NFNula==" " .AND. VENDE_ == VEN->CODIGO 
            @ 19,60 Say "Registro#" + StrZero( ++nCt, 4, 0 ) 
            AAdd( aComissoes, { DTDISP, CODNF_, DESCRI, VALOR_, SITUA_, CODDUP, CODMV_, Recno(), VLRDSP, VLRPAG, VLRPEN } ) 
            nTotGeral+= VALOR_ 
            nTotDisp+=  VLRDSP 
            nTotPago+=  VLRPAG 
         ENDIF 
         DBSkip() 
      ENDDO 
      Mensagem( "Pressione [ENTER] para visualizar detalhes da comissao." ) 
      aComissoes[ 1 ][ 4 ]:= nSaldoAnterior 
      /* display lateral */ 
      VPBox( 01, 02, 21, 77,,"15/03" ) 
      /* display p/ browse */ 
      VPBox( 04, 07, 20, 76,,_COR_BROW_BOX, .F., .F. ) 
      /* display com informacoes (superior) */ 
      VPBox( 01, 02, 04, 77,,"15/03", .F., .F. ) 
      SetColor( "15/03" ) 
      @ 02,04 Say "Vendedor........: " + ALLTrim( StrZero( VEN->CODIGO, 6, 0 ) + " - " + VEN->DESCRI ) 
      @ 03,04 Say "Total Dispon�vel: " + Tran( nTotDisp, "@E 9,999,999.9999" ) 
      @ 03,40 Say "Total Geral (PEND+DISP): " + Tran( nTotGeral, "@E 9999.9999" ) 
      SetColor( _COR_BROWSE ) 
      oTab:=TBrowseNew( 05, 03, 16, 75 ) 
      oTab:addcolumn(tbcolumnnew(,{|| StrZero( aComissoes[ nRow ][ 7 ], 4, 0 ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| aComissoes[ nRow ][ 1 ] })) 
      oTab:addcolumn(tbcolumnnew(,{|| Str( aComissoes[ nRow ][ 2 ], 9, 0 ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| Left( aComissoes[ nRow ][ 3 ], 27 ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| Tran( aComissoes[ nRow ][ 4 ],"@E 9,999.9999" ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| aComissoes[ nRow ][ 5 ] })) 
      oTab:AUTOLITE:=.f. 
      oTab:GOTOPBLOCK :={|| nRow:=1} 
      oTab:GOBOTTOMBLOCK:={|| nRow:=len( aComissoes )} 
      oTab:SKIPBLOCK:={|WTOJUMP| SkipperArr(WTOJUMP, aComissoes,@nRow)} 
      /*                                6     7     8    9*/ 
      oTab:ColorSpec:= SetColor() + ",15/04,15/03,01/14,15/05" 
      oTab:dehilite() 
      lRefresh:= .F. 
 
      WHILE .t. 
         nTst:= 0 
         /* Teste da ultima tecla pressionada p/ tirar 
            diferenca na cor da coluna liberada */ 
         IF nTecla == K_UP 
            nTst:= -1 
         ELSEIF nTecla == K_DOWN 
            nTst:= +1 
         ENDIF 
 
         IF lRefresh 
            oTaB:RefreshAll() 
            WHILE !oTab:Stabilize() 
            ENDDO 
            lRefresh:= .F. 
         ENDIF 
         Keyboard K_LEFT 
 
         IF nRow + nTst > Len( aComissoes ) .OR.; 
            nRow + nTst < 1 
            nTst:= 0 
         ENDIF 
 
         IF aComissoes[ nRow + nTst ][ 5 ] == "LIBERADA  " 
            oTab:colorrect({oTab:ROWPOS,2,oTab:ROWPOS,6},{6,1}) 
         ELSE 
            oTab:colorrect({oTab:ROWPOS,2,oTab:ROWPOS,6},{8,1}) 
         ENDIF 
 
         /* colocar uma cor em todo o campo esquerdo */ 
         oTab:colorRect({1,1,15,1},{7,2}) 
 
         /* Colocar cor diferente na barra do campo esquerdo */ 
         oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{6,2}) 
 
         Dispbegin() 
         WHILE nextkey()=0 .and.! oTab:stabilize() 
         ENDDO 
         cCorRes:= SetColor() 
         SetColor( Cor[12] ) 
         DispBox( 05, 07, 19, 07, "��������" ) 
         SetColor( "15/02" ) 
         Scroll( 17, 08, 19, 74 ) 
         @ 17,08 Say " Total Disponivel: " + TRAN( aComissoes[ nRow ][ 9 ], "@E 999,999,999.99" ) 
         @ 18,08 Say " Total Quitado...: " + TRAN( aComissoes[ nRow ][ 10 ], "@E 999,999,999.99" ) 
         @ 19,08 Say " Total Pendente..: " + TRAN( aComissoes[ nRow ][ 11 ], "@E 999,999,999.99" ) 
         SetColor( cCorRes ) 
         DispEnd() 
 
         nTecla:=inkey(0) 
         IF nTecla=K_ESC 
            exit 
         ENDIF 
         DO CASE 
            CASE nTecla==K_UP         ;oTab:up() 
            CASE nTecla==K_DOWN       ;oTab:down() 
            CASE nTecla==K_PGUP       ;oTab:pageup() 
            CASE nTecla==K_PGDN       ;oTab:pagedown() 
            CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
            CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
            CASE nTecla==K_SPACE 
                 DBGoTo( aComissoes[ nRow ][ 8 ] ) 
                 IF netrlock() 
                    REPLACE CODMV_ WITH nCodMV_,; 
                            SITUA_ With "QUITADA   ",; 
                            VLRPAG With VLRPAG+VLRPEN 
                    REPLACE VLRPEN With VLRDSP - VLRPAG 
                    aComissoes[ nRow ][ 7 ]:= nCodMv_ 
                    aComissoes[ nRow ][ 5 ]:= "QUITADA   " 
                    aComissoes[ nRow ][ 10 ]:= VLRPAG 
                    aComissoes[ nRow ][ 11 ]:= VLRPEN 
                    oTab:RefreshAll() 
                    WHILE !oTab:Stabilize() 
                    ENDDO 
                 ENDIF 
                 DBUnlockAll() 
            CASE nTecla==K_ENTER      ;VisualDetalhes( aComissoes[ nRow ][ 2 ] ) 
            OTHERWISE 
         ENDCASE 
         oTab:refreshcurrent() 
         oTab:stabilize() 
      ENDDO 
   ENDIF 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � VISUALCOMISSOES 
� Finalidade  � Visualizacao das comissoes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
STATIC FUNCTION VisualComissoes() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOrdem:= IndexOrd(), nArea:= Select() 
Local aComissoes:= {}, nRow:= 1, nTecla:= 0, nCt:= 0, nTotDisp:= 0, nTotPend:= 0 ,; 
      nSaldoAnterior:= 0, nTst, WTOJUMP, oTab 
Static dDataInicio, dDataFinal 
   /* Definicao de periodo */ 
   IF dDataInicio == NIL 
      dDataInicio:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ) 
      dDataFinal:= Date() 
   ENDIF 
   VPBox( 16, 30, 20, 76,, _COR_GET_BOX ) 
   SetCursor( 1 ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 17,33 Say "Periodo para verificacao de comissoes" 
   @ 18,33 Say "Inicial.:" Get dDataInicio 
   @ 19,33 Say "Final...:" Get dDataFinal 
   READ 
   SetCursor( 0 ) 
   IF LastKey() <> K_ESC 
      DBSelectAr( _COD_COMISSAO ) 
      DBSetOrder( 3 ) 
      AAdd( aComissoes, { CTOD( "  /  /  " ), 0, "SALDO ANTERIOR.........................", 0, Space( 10 ), 0, 0 } ) 
      DBGoTop() 
      WHILE !EOF() 
         IF DTDisp < dDataInicio .AND. NFNULA==" " .AND. VENDE_ == VEN->CODIGO 
            nSaldoAnterior+= VALOR_ 
            IF SITUA_ == "LIBERADA  " 
               nTotDisp+= VALOR_ 
            ELSEIF SITUA_ == "PENDENTE  " 
               nTotPend+= VALOR_ 
            ENDIF 
         ELSEIF DTDisp >= dDataInicio .AND. DTDisp <= dDataFinal .AND.; 
            NFNula==" " .AND. VENDE_ == VEN->CODIGO 
            @ 19,60 Say "Registro#" + StrZero( ++nCt, 4, 0 ) 
            AAdd( aComissoes, { DTDISP,CODNF_,DESCRI,VALOR_,SITUA_,CODDUP, CODMV_ } ) 
            IF SITUA_ == "LIBERADA  " 
               nTotDisp+= VALOR_ 
            ELSEIF SITUA_ == "PENDENTE  " 
               nTotPend+= VALOR_ 
            ENDIF 
         ENDIF 
         DBSkip() 
      ENDDO 
      Mensagem( "Pressione [ENTER] p/ visualizar detalhes da comissao ou [TAB]Imprimir." ) 
      aComissoes[ 1 ][ 4 ]:= nSaldoAnterior 
      /* display lateral */ 
      VPBox( 01, 02, 21, 77,,"15/03" ) 
      /* display p/ browse */ 
      VPBox( 04, 07, 20, 76,, _COR_BROW_BOX, .F., .F. ) 
      /* display com informacoes (superior) */ 
      VPBox( 01, 02, 04, 77,, _COR_BROW_BOX, .F., .F. ) 
      cCorRes:= SetColor() 
      SetColor( "15/02" ) 
      @ 02,04 Say "Vendedor........: " + ALLTrim( StrZero( VEN->CODIGO, 6, 0 ) + " - " + VEN->DESCRI ) 
      @ 03,04 Say "Total Dispon�vel: " + Tran( nTotDisp, "@E 999999.99" ) +; 
                                     " Pendente:" + Tran( nTotPend, "@E 99999.99" ) +; 
                                     " Total (DISP+PEND):" + Tran( nTotPend + nTotDisp, "@E 99999.999" ) 
      SetColor( _COR_BROWSE ) 
      oTab:=TBrowseNew( 05, 03, 19, 75 ) 
      oTab:addcolumn(tbcolumnnew(,{|| StrZero( aComissoes[ nRow ][ 7 ], 4, 0 ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| aComissoes[ nRow ][ 1 ] })) 
      oTab:addcolumn(tbcolumnnew(,{|| Str( aComissoes[ nRow ][ 2 ], 9, 0 ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| Left( aComissoes[ nRow ][ 3 ], 27 ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| Tran( aComissoes[ nRow ][ 4 ],"@E 99999.9999" ) })) 
      oTab:addcolumn(tbcolumnnew(,{|| aComissoes[ nRow ][ 5 ] })) 
      oTab:AUTOLITE:=.f. 
      oTab:GOTOPBLOCK :={|| nRow:=1} 
      oTab:GOBOTTOMBLOCK:={|| nRow:=len( aComissoes )} 
      oTab:SKIPBLOCK:={|WTOJUMP| SkipperArr(WTOJUMP, aComissoes,@nRow)} 
      /*                                6     7     8   */ 
      oTab:ColorSpec:= SetColor() + ",15/04,15/03,01/14" 
      oTab:dehilite() 
      WHILE .t. 
         nTst:= 0 
         /* Teste da ultima tecla pressionada p/ tirar 
            diferenca na cor da coluna liberada */ 
         IF nTecla == K_UP 
            nTst:= -1 
         ELSEIF nTecla == K_DOWN 
            nTst:= +1 
         ENDIF 
         IF nRow + nTst > Len( aComissoes ) .OR.; 
            nRow + nTst < 1 
            nTst:= 0 
         ENDIF 
 
         IF aComissoes[ nRow + nTst ][ 5 ] == "LIBERADA  " 
            oTab:colorrect({oTab:ROWPOS,2,oTab:ROWPOS,6},{6,1}) 
         ELSE 
            oTab:colorrect({oTab:ROWPOS,2,oTab:ROWPOS,6},{8,1}) 
         ENDIF 
 
         /* colocar uma cor em todo o campo esquerdo */ 
         oTab:colorRect({1,1,15,1},{7,2}) 
 
         /* Colocar cor diferente na barra do campo esquerdo */ 
         oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{6,2}) 
 
         WHILE nextkey()=0 .and.! oTab:stabilize() 
         ENDDO 
         cCorRes:= SetColor() 
         SetColor( _COR_BROW_BOX ) 
         DispBox( 05, 07, 19, 07, "��������" ) 
         SetColor( cCorRes ) 
         nTecla:=inkey(0) 
         IF nTecla=K_ESC 
            exit 
         ENDIF 
         DO CASE 
            CASE nTecla==K_UP         ;oTab:up() 
            CASE nTecla==K_LEFT       ;oTab:up() 
            CASE nTecla==K_RIGHT      ;oTab:down() 
            CASE nTecla==K_DOWN       ;oTab:down() 
            CASE nTecla==K_PGUP       ;oTab:pageup() 
            CASE nTecla==K_PGDN       ;oTab:pagedown() 
            CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
            CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
            CASE nTecla==K_ENTER      ;VisualDetalhes( aComissoes[ nRow ][ 2 ] ) 
            CASE nTecla==K_TAB 
                 cCorRes:= SetColor() 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 VPBox( 13, 38, 21, 77, "Periodo de Comissoes", _COR_GET_BOX ) 
                 dDataIni:= DATE() 
                 dDataFim:= DATE() 
                 nOpcao:= 1 
                 dDataLimite:= DATE() + 365 
                 dLimiteEmiss:= DATE() 
                 SetColor( _COR_GET_EDICAO ) 
                 SetCursor(1) 
                 @ 16,40 Say    "�������������������������������" 
                 @ 17,40 Say    "Data Inicial.:" Get dDataIni 
                 @ 18,40 Say    "Data Final...:" Get dDataFim 
                 @ 19,40 Say    "Limite (Venc):" Get dDataLimite 
                 @ 20,40 Say    "Limite (Emis):" Get dLimiteEmiss 
                 @ 14,40 Prompt " 1 Comissoes do Mes          " 
                 @ 15,40 Prompt " 2 Pendencias                " 
                 menu To nOpcao 
                 /* Ajustes Pre-get cfe. opcoes selecionadas */ 
                 IF nOpcao==2 
                    dDataIni:= Date() 
                    FOR nCt:= 1 TO 8 
                        IF DOW( dDataIni )==1 
                           EXIT 
                        ENDIF 
                        dDataIni:= dDataIni + 1 
                        dDataFim:= dDataIni 
                    NEXT 
                    dDataLimite:= DATE() + 365 
                    dLimiteEmiss:= DATE() + 365 
                 ENDIF 
                 Read 
                 IF !LastKey() == K_ESC 
                    DBGoTop() 
                    IF nOpcao==1 
                       Mensagem( "Alterando a situacao das informacoes que fogem do periodo..." ) 
                       WHILE !EOF() 
                           IF DTQUIT > dDataFim 
                              IF netrlock() 
                                 Replace DTQUIT With CTOD( "  /  /  " ),; 
                                         PGTO__ With " F ",; 
                                         VLRDSP With 0 
                              ENDIF 
                           ENDIF 
                           DBSkip() 
                       ENDDO 
                    ENDIF 
                    Mensagem( "Organizando comissoes, aguarde...." ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    INDEX ON STR( VENDE_ ) + STR( YEAR( VENCIM ) ) + STR( MONTH( VENCIM ) ) + STR( DAY( VENCIM ) ) ; 
                          TO INDR1.NTX FOR VENCIM <= dDataLimite .AND. ( ( DTQUIT >= dDataIni .AND. DTQUIT <= dDataFim ) .OR. PGTO__ == "   " ) .OR.; 
                                                            ( DTQUIT == CTOD( "  /  /  " ) ) .AND.; 
                                                            ( DTDISP <= dLimiteEmiss ) .AND.; 
                                                            ( VENDE_ == VEN->CODIGO ) EVAL {|| Processo() } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    Set Index To INDR1.NTX 
                    DBGotop() 
                    /* Ajuste de comissoes agrupados p/ percentual */ 
                    aStr:= {{"RESUMO","C",80,00},; 
                            {"PERC__","C",10,00},; 
                            {"VALOR_","N",16,02},; 
                            {"PENDEN","N",16,02},; 
                            {"TOTAL_","N",16,02},; 
                            {"PEND__","N",16,02}} 
                    DBSelectAr( 133 ) 
                    DBCreate( "FILE0293.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    Use FILE0293.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    INDEX ON RESUMO TO IndRd00 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    INDEX ON PERC__ TO IndRd02 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    Set Index To IndRd00, IndRd02 
                    DBSetOrder( 2 ) 
                    DBSelectAr( _COD_COMISSAO ) 
                    DBGoTop() 
                    nPendente:= 0 
                    WHILE !EOF() 
                        cPerc:= PAD( Tran( LePercentualFormula( FORMUL ), "@R 999.99" ), 10 ) 
                        IF !( VAL( PGTO__ ) >= 800 ) .AND. !NFNULA=="*" .AND. VENDE_ == VEN->CODIGO 
                           IF !RES->( DBSeek( cPerc ) ) 
                              RES->( DBAppend() ) 
                           ENDIF 
                           IF RES->( netrlock() ) 
                              nBase:= if( VLRPAR == 0, VLRBAS, VLRPAR ) 
                              Replace RES->VALOR_ With RES->VALOR_ + VLRDSP,; 
                                      RES->TOTAL_ With RES->TOTAL_ + IF( VLRDSP > 0, nBase, 0 ),; 
                                      RES->PERC__ With cPerc,; 
                                      RES->PENDEN With RES->PENDEN + IF( VLRDSP <= 0, VALOR_, 0 ),; 
                                      RES->PEND__ With RES->PEND__ + IF( VLRDSP <= 0, nBase, 0 ) 
                              cResumo:= cPerc + Space( 02 ) + ; 
                                        Tran( RES->TOTAL_, "@E 9,999,999.99" ) + ; 
                                        Tran( RES->VALOR_, "@E 9,999,999.99" ) + ; 
                                        Tran( RES->PEND__, "@E 9,999,999.99" ) + ; 
                                        Tran( RES->PENDEN, "@E 9,999,999.99" ) 
                              Replace RES->RESUMO With cResumo 
                           ENDIF 
                        ENDIF 
                        DBSKIP() 
                    ENDDO 
                    DBSetOrder( 5 ) 
                    DBGoTop() 
                    Relatorio( "COMISSAO.REP" ) 

                    // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
                    #ifdef LINUX
                      set index to "&gdir/cm_ind01.ntx", "&gdir/cm_ind02.ntx", "&gdir/cm_ind03.ntx", "&gdir/cm_ind04.ntx"     
                    #else 
                      Set Index To "&GDir\CM_IND01.NTX", "&GDir\CM_IND02.NTX", "&GDir\CM_IND03.NTX", "&GDir\CM_IND04.NTX"     
                    #endif
                    RES->( DBCloseArea() ) 
                 ENDIF 
                 SetColor( cCorRes ) 
                 ScreenRest( cTelaRes ) 
            OTHERWISE                ;tone(125); tone(300) 
         ENDCASE 
         oTab:refreshcurrent() 
         oTab:stabilize() 
      ENDDO 
   ENDIF 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � VISUALDETALHES 
� Finalidade  � Visualizacao do detalhe 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
STATIC FUNCTION VisualDetalhes( nCodNf_ ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOrdem:= IndexOrd(), nArea:= Select(), ntst 
Local aDetalhes:= {}, nRow:= 1, nTecla:= 0 
   SetCursor( 0 ) 
   DBSelectAr( _COD_COMISAUX ) 
   DBSetOrder( 2 ) 
   IF DBSeek( nCodNF_ ) 
      WHILE VENDE_ == VEN->CODIGO .AND. CODNF_ == nCodNf_ 
         AAdd( aDetalhes, { CODPRO,DESCRI,VLRBAS,PRCMVV,PRCMVP,VALOR_ } ) 
         DBSkip() 
      ENDDO 
      IF LEN( aDetalhes ) < 1 
         DBSelectAr( nArea ) 
         DBSetOrder( nOrdem ) 
         Return Nil 
      ENDIF 
      Mensagem( "Pressione [ESC] para retornar." ) 
      /* display lateral */ 
      VPBox( 07, 25, 16, 69,,"14/01" ) 
      VPBox( 17, 25, 19, 69,,"14/01" ) 
      oTab:=TBrowseNew( 08, 26, 15, 68 ) 
      oTab:addcolumn(tbcolumnnew( "Produto",  {|| Tran( aDetalhes[ nRow ][ 1 ], "@R 999-9999" ) })) 
      oTab:addcolumn(tbcolumnnew( "V.Venda",  {|| Tran( aDetalhes[ nRow ][ 3 ], "@E 9999.9999" ) })) 
      oTab:addcolumn(tbcolumnnew( "%Vista",   {|| Tran( aDetalhes[ nRow ][ 4 ], "@E 999.99" ) })) 
      oTab:addcolumn(tbcolumnnew( "%Prazo",   {|| Tran( aDetalhes[ nRow ][ 5 ], "@E 999.99" ) })) 
      oTab:addcolumn(tbcolumnnew( "Comissao", {|| Tran( aDetalhes[ nRow ][ 6 ], "@E 99,999.999" ) })) 
      oTab:AUTOLITE:=.f. 
      oTab:GOTOPBLOCK :={|| nRow:=1} 
      oTab:GOBOTTOMBLOCK:={|| nRow:=len( aDetalhes )} 
      oTab:SKIPBLOCK:={|x| SkipperArr(x, aDetalhes,@nRow)} 
      /*                                6     7     8   */ 
      oTab:ColorSpec:= SetColor() + ",15/04,15/03,01/14" 
      oTab:dehilite() 
      WHILE .t. 
 
         /* TRATAMENTO DA EXIBICAO DO NOME DO PRODUTO */ 
         nTst:= 0 
         /* Teste da ultima tecla pressionada p/ tirar 
            diferenca na cor da coluna liberada */ 
         IF nTecla == K_UP 
            nTst:= -1 
         ELSEIF nTecla == K_DOWN 
            nTst:= +1 
         ENDIF 
         IF nRow + nTst > Len( aDetalhes ) .OR.; 
            nRow + nTst < 1 
            nTst:= 0 
         ENDIF 
         @ 18,26 Say Left( aDetalhes[ nRow + nTst ][ 2 ], 43 ) 
 
         oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,5},{8,1}) 
         WHILE nextkey()=0 .and.! oTab:stabilize() 
         ENDDO 
         nTecla:=inkey(0) 
         IF nTecla=K_ESC .OR. nTecla=K_ENTER 
            exit 
         ENDIF 
         DO CASE 
            CASE nTecla==K_UP         ;oTab:up() 
            CASE nTecla==K_DOWN       ;oTab:down() 
            OTHERWISE 
         ENDCASE 
         oTab:refreshcurrent() 
         oTab:stabilize() 
      ENDDO 
   ENDIF 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � CalculoGeral 
� Finalidade  � Calcula as comissoes com base nas formulas de calculos 
�             � que estao anexas ao cadastro de vendedores do sistema. 
� Parametros  � NIL 
� Retorno     � NIL 
� Programador � Valmor Pereira Flores 
� Data        � 10/08/1997 
� Atualizacao � 01/03/2000 
��������������� 
*/ 
STATIC FUNCTION CalculoGeral() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      nArea:= Select(), nOrdem:= IndexOrd() 
 
Local dDataIni:= CTOD( "  /  /  " ), dDataFim:= CTOD( "  /  /  " ) 
Local nVend1:= 0, nVend2:= 999,; 
      dDataBase:= Date(), dDataI2, dDataF2 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    UserScreen() 
    VPBox( 04, 30, 21, 75, " CALCULO DE COMISSOES ", _COR_GET_BOX ) 
    dDataI2:=  CTOD( "01/01/90" ) 
    dDataIni:= CTOD( "01/01/90" ) 
    dDataF2:=  CTOD( "01/" + StrZero( MONTH( DATE() ), 2, 0 ) +; 
                       "/" + SubStr( StrZero( YEAR( DATE() ), 4, 0 ), 3, 2 ) ) 
    dDataFim:= CTOD( "01/" + StrZero( MONTH( DATE() ), 2, 0 ) +; 
                       "/" + SubStr( StrZero( YEAR( DATE() ), 4, 0 ), 3, 2 ) ) 
    SetColor( _COR_GET_EDICAO ) 
    SetCursor( 1 ) 
    @ 05,32 Say "Periodo de..:" Get dDataIni 
    @ 05,57 Say "At�:" Get dDataFim 
    @ 06,32 Say "Mes Calculo.:" Get dDataI2 
    @ 06,57 Say "At�:" Get dDataF2 
    @ 07,32 Say "Data Calculo:" Get dDataBase 
    @ 08,32 Say "�������������������������������������������" 
    READ 
 
    IF !LimpaCalculos() 
       SWAlerta( "Sistema esta aberto em outros equipamentos.;" + "Favor fechar o fortuna em todas as maquinas; antes de efetuar esta operacao.", { " OK " } ) 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       Return Nil 
    ENDIF 
 
    SWGravar( 1200 ) 
 
    /* Busca informacoes da Nota Fiscal */ 
    DBSelectAr( _COD_NFISCAL ) 
    DBSetOrder( 3 ) 
    DBSeek( dDataIni, .T. ) 
    Status() 
 
    FOR nCt:= 10 TO 10 
        Scroll( 09, 32, 20, 74, 1 ) 
        @ 20,32 Say SubStr( Repl( "�����������۱����", 20 ), nCt * 3, 42 ) COLOR StrZero( nCt, 2, 0 ) + "/01" 
        @ 20,34 Say "< 1a.Fase >" COLOR StrZero( nCt, 2, 0 ) + "/01" 
        INKEY(0.01) 
    NEXT 
 
    WHILE NF_->DATAEM >= dDataIni .AND. NF_->DATAEM <= dDataFim .AND. !NF_->( EOF() ) 
        lCalcula:= .F. 
        IF Inkey()==K_ESC .OR. NextKey()==K_ESC .OR. LastKey()==K_ESC 
           Exit 
        ENDIF 
        DPA->( DBSetOrder( 1 ) ) 
        IF DPA->( DBSeek( NF_->NUMERO ) ) 
           IF ( DPA->DTQT__==CTOD("  /  /  " ) ) .OR. ( DPA->DTQT__ >= dDataI2 .AND. DPA->DTQT__ <= dDataF2 ) .OR.; 
                                                      ( NF_->DATAEM >= dDataI2 .AND. NF_->DATAEM <= dDataF2 ) 
              lCalcula:= .T. 
           ELSE 
              Scroll( 09, 32, 20, 74, 1 ) 
              @ 20,32 Say PAD( STR( NF_->NUMERO, 8 ) + " " + NF_->CDESCR, 43 ) Color _COR_GET_REALSE 
              lCalcula:= .F. 
           ENDIF 
        ELSE 
           lCalcula:= .T. 
        ENDIF 
 
        OPE->( DBSetOrder( 1 ) ) 
        OPE->( DBSeek( NF_->TABOPE ) ) 
 
        DispBegin() 
        VPBox( 01, 03, 07, 50, " INFORMACOES P/ CALCULO ", _COR_GET_EDICAO ) 
        @ 02,05 Say "Data Duplicata: " + dtoc( NF_->DATAEM ) 
        @ 03,05 Say "Data Quitacao.: " + dtoc( DPA->DTQT__ ) 
        @ 04,05 Say "Numero Nota...: " + StrZero( NF_->NUMERO, 6, 0 ) 
        @ 05,05 Say "Calcular......: " + IF( lCalcula, "Sim", "Nao" ) + Str( NF_->NATOPE, 6, 2 ) + " " + StrZero( OPE->CODIGO, 3, 0 ) 
        @ 06,05 Say "Comissao......: " + OPE->COMISS + " " + StrZero( NF_->VENIN_, 3, 0 ) + " / " + StrZero( NF_->VENEX_, 3, 0 ) 
        DispEnd() 
 
        IF lCalcula .AND. !NF_->VLRTOT == 0 .AND. NF_->NFNULA == " " .AND. ( NF_->TIPONF == "S" .AND.; 
           ( ( NF_->NATOPE >= 5.120 .AND. NF_->NATOPE <= 5.129 )   .OR.; 
             ( NF_->NATOPE = 5.102 .OR. NF_->NATOPE = 6.102 .OR. NF_->NATOPE = 6.101 .OR. NF_->NATOPE = 5.101 )  .OR.; 
             ( NF_->NATOPE >= 6.120 .AND. NF_->NATOPE <= 6.129 ) ) .OR. OPE->COMISS=="S" ) 
 
           DBSelectAr( _COD_COMISSAO ) 
           DBSetOrder( 2 ) 
 
           DBSelectAr( _COD_VENDEDOR ) 
           DBSetOrder( 1 ) 
 
           Scroll( 09, 32, 20, 74, 1 ) 
           @ 20,32 Say PAD( STR( NF_->NUMERO, 8 ) + " " + NF_->CDESCR, 43 ) Color _COR_GET_EDICAO 
 
           IF !( NF_->VENIN_ + NF_->VENEX_ ) == 0 
              FOR nVnd:= 1 TO 2 
                 nCodVendedor:= IF( nVnd==1, NF_->VENIN_, NF_->VENEX_ ) 
                 IF DBSeek( nCodVendedor ) .AND. nCodVendedor > 0 
                    FOR nCt:= 1 to 10 
                       DBSelectAr( _COD_VENDEDOR ) 
                       /* Leitura e gravacao das comissoes da 1�/10� Formula */ 
                       IF nCt == 1 
                          nFormula:=  VEN->FORM01 
                          nMesIni:=   VEN->MINI01 
                          nMesFim:=   VEN->MFIM01 
                       ELSEIF nCt == 2 
                          nFormula:=  VEN->FORM02 
                          nMesIni:=   VEN->MINI02 
                          nMesFim:=   VEN->MFIM02 
                       ELSEIF nCt == 3 
                          nFormula:=  VEN->FORM03 
                          nMesIni:=   VEN->MINI03 
                          nMesFim:=   VEN->MFIM03 
                       ELSEIF nCt == 4 
                          nFormula:=  VEN->FORM04 
                          nMesIni:=   VEN->MINI04 
                          nMesFim:=   VEN->MFIM04 
                       ELSEIF nCt == 5 
                          nFormula:=  VEN->FORM05 
                          nMesIni:=   VEN->MINI05 
                          nMesFim:=   VEN->MFIM05 
                       ELSEIF nCt == 6 
                          nFormula:=  VEN->FORM06 
                          nMesIni:=   VEN->MINI06 
                          nMesFim:=   VEN->MFIM06 
                       ELSEIF nCt == 7 
                          nFormula:=  VEN->FORM07 
                          nMesIni:=   VEN->MINI07 
                          nMesFim:=   VEN->MFIM07 
                       ELSEIF nCt == 8 
                          nFormula:=  VEN->FORM08 
                          nMesIni:=   VEN->MINI08 
                          nMesFim:=   VEN->MFIM08 
                       ELSEIF nCt == 9 
                          nFormula:=  VEN->FORM09 
                          nMesIni:=   VEN->MINI09 
                          nMesFim:=   VEN->MFIM09 
                       ELSEIF nCt == 10 
                          nFormula:=  VEN->FORM10 
                          nMesIni:=   VEN->MINI10 
                          nMesFim:=   VEN->MFIM10 
                       ENDIF 
                       IF nFormula > 0 
                          aSituacao:= LeFormulas( nFormula, VEN->TIPO__, nMesIni, nMesFim, 1 ) 
 
                          IF aSituacao[ 1 ] > 0 
                             dbSelectAr( _COD_COMISSAO ) 
                             dbSetOrder( 2 ) 
                             lAppend:= .T. 
                             IF DBSeek( NF_->NUMERO ) 
                               /* Procura pelo calculo j� existente de comissao */ 
                                WHILE CODNF_ == NF_->NUMERO 
                                    IF VENDE_ == nCodVendedor .AND. FORMUL == nFormula 
                                       lAppend:= .F. 
                                       EXIT 
                                    ENDIF 
                                    DBSkip() 
                                ENDDO 
                             ENDIF 
                             IF lAppend 
                                BuscaNet( 5, {|| DBAppend(), !NetErr() } ) 
                             ENDIF 
                             IF netrlock() 
                                cPag:= " " 
                                dPgtoData:= CTOD( "  /  /  " ) 
                                DPA->( DBSetOrder( 1 ) ) 
                                IF DPA->( DBSeek( NF_->NUMERO ) ) 
                                   IF DPA->( !EMPTY( DTQT__ ) ) 
                                      cPag:= StrZero( DPA->LOCAL_, 3, 0 ) 
                                      dPgtoData:= DPA->DTQT__ 
                                   ENDIF 
                                ENDIF 
                                Repl CODNF_ With NF_->NUMERO,; 
                                     VENDE_ With nCodVendedor,; 
                                     DESCRI With NF_->CDESCR,; 
                                     FORMUL With nFormula,; 
                                     TABCND With NF_->TABCND,; 
                                     VLRBAS With aSituacao[ 1 ],; 
                                     VLRPAR With aSituacao[ 4 ],; 
                                     VALOR_ With aSituacao[ 2 ],; 
                                     DTDISP With NF_->DATAEM,; 
                                     VLRDSP With aSituacao[ 3 ],; 
                                     VLRPEN With aSituacao[ 3 ] - VLRPAG,; 
                                     TOTAL_ With NF_->VLRTOT,; 
                                     SITUA_ With IF( VLRPEN == 0, "PENDENTE", "LIBERADA" ),; 
                                     VENCIM With NF_->DATAEM + NF_->PRAZOA,; 
                                     PGTO__ With cPag,; 
                                     DTQUIT With dPgtoData 
                             ENDIF 
                          ENDIF 
                       ENDIF 
                    NEXT 
                 ENDIF 
              NEXT 
           ELSE 
              nCodVendedor:= 0 
              IF DBSeek( nCodVendedor ) .AND. nCodVendedor == 0 
                 FOR nCt:= 1 to 10 
                     DBSelectAr( _COD_VENDEDOR ) 
                     /* Leitura e gravacao das comissoes da 1�/10� Formula */ 
                     IF nCt == 1 
                        nFormula:=  VEN->FORM01 
                        nMesIni:=   VEN->MINI01 
                        nMesFim:=   VEN->MFIM01 
                     ELSEIF nCt == 2 
                        nFormula:=  VEN->FORM02 
                        nMesIni:=   VEN->MINI02 
                        nMesFim:=   VEN->MFIM02 
                     ELSEIF nCt == 3 
                        nFormula:=  VEN->FORM03 
                        nMesIni:=   VEN->MINI03 
                        nMesFim:=   VEN->MFIM03 
                     ELSEIF nCt == 4 
                        nFormula:=  VEN->FORM04 
                        nMesIni:=   VEN->MINI04 
                        nMesFim:=   VEN->MFIM04 
                     ELSEIF nCt == 5 
                        nFormula:=  VEN->FORM05 
                        nMesIni:=   VEN->MINI05 
                        nMesFim:=   VEN->MFIM05 
                     ELSEIF nCt == 6 
                        nFormula:=  VEN->FORM06 
                        nMesIni:=   VEN->MINI06 
                        nMesFim:=   VEN->MFIM06 
                     ELSEIF nCt == 7 
                        nFormula:=  VEN->FORM07 
                        nMesIni:=   VEN->MINI07 
                        nMesFim:=   VEN->MFIM07 
                     ELSEIF nCt == 8 
                        nFormula:=  VEN->FORM08 
                        nMesIni:=   VEN->MINI08 
                        nMesFim:=   VEN->MFIM08 
                     ELSEIF nCt == 9 
                        nFormula:=  VEN->FORM09 
                        nMesIni:=   VEN->MINI09 
                        nMesFim:=   VEN->MFIM09 
                     ELSEIF nCt == 10 
                        nFormula:=  VEN->FORM10 
                        nMesIni:=   VEN->MINI10 
                        nMesFim:=   VEN->MFIM10 
                     ENDIF 
                     IF nFormula > 0 
                        aSituacao:= LeFormulas( nFormula, VEN->TIPO__, nMesIni, nMesFim, 1 ) 
                        IF aSituacao[ 1 ] > 0 
                           dbSelectAr( _COD_COMISSAO ) 
                           dbSetOrder( 2 ) 
                           lAppend:= .T. 
                           IF DBSeek( NF_->NUMERO ) 
                             /* Procura pelo calculo j� existente de comissao */ 
                              WHILE CODNF_ == NF_->NUMERO 
                                  IF VENDE_ == nCodVendedor .AND. FORMUL == nFormula 
                                     lAppend:= .F. 
                                     EXIT 
                                  ENDIF 
                                  DBSkip() 
                              ENDDO 
                           ENDIF 
                           IF lAppend 
                              BuscaNet( 5, {|| DBAppend(), !NetErr() } ) 
                           ENDIF 
                           IF netrlock() 
                              cPag:= " " 
                              dPgtoData:= CTOD( "  /  /  " ) 
                              DPA->( DBSetOrder( 1 ) ) 
                              IF DPA->( DBSeek( NF_->NUMERO ) ) 
                                 IF DPA->( !EMPTY( DTQT__ ) ) 
                                    cPag:= StrZero( DPA->LOCAL_, 3, 0 ) 
                                    dPgtoData:= DPA->DTQT__ 
                                 ENDIF 
                              ENDIF 
                              Repl CODNF_ With NF_->NUMERO,; 
                                   VENDE_ With nCodVendedor,; 
                                   DESCRI With NF_->CDESCR,; 
                                   FORMUL With nFormula,; 
                                   TABCND With NF_->TABCND,; 
                                   VLRBAS With aSituacao[ 1 ],; 
                                   VLRPAR With aSituacao[ 4 ],; 
                                   VALOR_ With aSituacao[ 2 ],; 
                                   DTDISP With NF_->DATAEM,; 
                                   VLRDSP With aSituacao[ 3 ],; 
                                   VLRPEN With aSituacao[ 3 ] - VLRPAG,; 
                                   TOTAL_ With NF_->VLRTOT,; 
                                   SITUA_ With IF( VLRPEN == 0, "PENDENTE", "LIBERADA" ),; 
                                   VENCIM With NF_->DATAEM + NF_->PRAZOA,; 
                                   PGTO__ With cPag,; 
                                   DTQUIT With dPgtoData 
                           ENDIF 
                        ENDIF 
                     ENDIF 
                 NEXT 
              ENDIF 
           ENDIF 
        ENDIF 
        DBSelectAr( _COD_NFISCAL ) 
        DBSkip() 
    ENDDO 
 
    FOR nCt:= 11 TO 11 
        Scroll( 09, 32, 20, 74, 1 ) 
        @ 20,32 Say SubStr( Repl( "�����������۱����", 20 ), nCt * 3, 42 ) COLOR StrZero( nCt, 2, 0 ) + "/01" 
        @ 20,34 Say "< 2a.Fase >" COLOR StrZero( nCt, 2, 0 ) + "/01" 
        INKEY(0.01) 
    NEXT 
 
    /* Busca Informacoes nos Cupons Fiscais */ 
    DBSelectAr( _COD_CUPOM ) 
    DBSetOrder( 3 ) 
    DBSeek( dDataIni, .T. ) 
    WHILE CUP->DATAEM >= dDataIni .AND. CUP->DATAEM <= dDataFim .AND. !CUP->( EOF() ) 
        lCalcula:= .F. 
        IF Inkey()==K_ESC .OR. NextKey()==K_ESC .OR. LastKey()==K_ESC 
           Exit 
        ENDIF 
        DPA->( DBSetOrder( 1 ) ) 
        IF DPA->( DBSeek( CUP->NUMERO ) ) 
           IF ( DPA->DTQT__==CTOD("  /  /  " ) ) .OR. ( DPA->DTQT__ >= dDataI2 .AND. DPA->DTQT__ <= dDataF2 ) .OR.; 
                                                      ( CUP->DATAEM >= dDataI2 .AND. CUP->DATAEM <= dDataF2 ) 
              lCalcula:= .T. 
           ELSE 
              Scroll( 09, 32, 20, 74, 1 ) 
              @ 20,32 Say PAD( STR( CUP->NUMERO, 8 ) + " " + CUP->CDESCR, 43 ) Color _COR_GET_REALSE 
              lCalcula:= .F. 
           ENDIF 
        ELSE 
           lCalcula:= .T. 
        ENDIF 
 
        OPE->( DBSetOrder( 1 ) ) 
        OPE->( DBSeek( CUP->TABOPE ) ) 
 
        DispBegin() 
        VPBox( 01, 03, 07, 50, " INFORMACOES P/ CALCULO - CUPOM ", _COR_GET_EDICAO ) 
        @ 02,05 Say "Data Duplicata: " + dtoc( CUP->DATAEM ) 
        @ 03,05 Say "Data Quitacao.: " + dtoc( DPA->DTQT__ ) 
        @ 04,05 Say "Numero Nota...: " + StrZero( CUP->NUMERO, 9, 0 ) 
        @ 05,05 Say "Calcular......: " + IF( lCalcula, "Sim", "Nao" ) 
        @ 06,05 Say "Comissao......: " + Str( CUP->NATOPE, 6, 2 ) + " " +; 
               StrZero( OPE->CODIGO, 3, 0 ) + " " + OPE->COMISS + " " + StrZero( CUP->VENIN_, 3, 0 ) + " / " + StrZero( CUP->VENEX_, 3, 0 ) 
        DispEnd() 
 
        IF lCalcula .AND. !CUP->VLRTOT == 0 .AND. CUP->NFNULA == " " .AND. ( CUP->TIPONF == "S" .AND.; 
           ( ( CUP->NATOPE >= 5.120 .AND. CUP->NATOPE <= 5.129 )   .OR.; 
             ( CUP->NATOPE = 5.102 .OR. CUP->NATOPE = 6.102 .OR. CUP->NATOPE = 6.101 .OR. CUP->NATOPE = 5.101 )   .OR.; 
             ( CUP->NATOPE >= 6.120 .AND. CUP->NATOPE <= 6.129 ) ) .OR. OPE->COMISS=="S" ) 
 
           DBSelectAr( _COD_COMISSAO ) 
           DBSetOrder( 2 ) 
 
           DBSelectAr( _COD_VENDEDOR ) 
           DBSetOrder( 1 ) 
 
           Scroll( 09, 32, 20, 74, 1 ) 
           @ 20,32 Say PAD( STR( CUP->NUMERO, 8 ) + " " + CUP->CDESCR, 43 ) Color _COR_GET_EDICAO 
 
           IF !( CUP->VENIN_ + CUP->VENEX_ ) == 0 
              FOR nVnd:= 1 TO 2 
                 nCodVendedor:= IF( nVnd==1, CUP->VENIN_, CUP->VENEX_ ) 
                 IF DBSeek( nCodVendedor ) .AND. nCodVendedor > 0 
                    FOR nCt:= 1 to 10 
                       DBSelectAr( _COD_VENDEDOR ) 
                       /* Leitura e gravacao das comissoes da 1�/10� Formula */ 
                       IF nCt == 1 
                          nFormula:=  VEN->FORM01 
                          nMesIni:=   VEN->MINI01 
                          nMesFim:=   VEN->MFIM01 
                       ELSEIF nCt == 2 
                          nFormula:=  VEN->FORM02 
                          nMesIni:=   VEN->MINI02 
                          nMesFim:=   VEN->MFIM02 
                       ELSEIF nCt == 3 
                          nFormula:=  VEN->FORM03 
                          nMesIni:=   VEN->MINI03 
                          nMesFim:=   VEN->MFIM03 
                       ELSEIF nCt == 4 
                          nFormula:=  VEN->FORM04 
                          nMesIni:=   VEN->MINI04 
                          nMesFim:=   VEN->MFIM04 
                       ELSEIF nCt == 5 
                          nFormula:=  VEN->FORM05 
                          nMesIni:=   VEN->MINI05 
                          nMesFim:=   VEN->MFIM05 
                       ELSEIF nCt == 6 
                          nFormula:=  VEN->FORM06 
                          nMesIni:=   VEN->MINI06 
                          nMesFim:=   VEN->MFIM06 
                       ELSEIF nCt == 7 
                          nFormula:=  VEN->FORM07 
                          nMesIni:=   VEN->MINI07 
                          nMesFim:=   VEN->MFIM07 
                       ELSEIF nCt == 8 
                          nFormula:=  VEN->FORM08 
                          nMesIni:=   VEN->MINI08 
                          nMesFim:=   VEN->MFIM08 
                       ELSEIF nCt == 9 
                          nFormula:=  VEN->FORM09 
                          nMesIni:=   VEN->MINI09 
                          nMesFim:=   VEN->MFIM09 
                       ELSEIF nCt == 10 
                          nFormula:=  VEN->FORM10 
                          nMesIni:=   VEN->MINI10 
                          nMesFim:=   VEN->MFIM10 
                       ENDIF 
                       IF nFormula > 0 
                          aSituacao:= LeFormulas( nFormula, VEN->TIPO__, nMesIni, nMesFim, 2 ) 
 
                          IF aSituacao[ 1 ] > 0 
                             dbSelectAr( _COD_COMISSAO ) 
                             dbSetOrder( 2 ) 
                             lAppend:= .T. 
                             IF DBSeek( CUP->NUMERO ) 
                               /* Procura pelo calculo j� existente de comissao */ 
                                WHILE CODNF_ == CUP->NUMERO 
                                    IF VENDE_ == nCodVendedor .AND. FORMUL == nFormula 
                                       lAppend:= .F. 
                                       EXIT 
                                    ENDIF 
                                    DBSkip() 
                                ENDDO 
                             ENDIF 
                             IF lAppend 
                                BuscaNet( 5, {|| DBAppend(), !NetErr() } ) 
                             ENDIF 
                             IF netrlock() 
                                cPag:= " " 
                                dPgtoData:= CTOD( "  /  /  " ) 
                                DPA->( DBSetOrder( 1 ) ) 
                                IF DPA->( DBSeek( CUP->NUMERO ) ) 
                                   IF DPA->( !EMPTY( DTQT__ ) ) 
                                      cPag:= StrZero( DPA->LOCAL_, 3, 0 ) 
                                      dPgtoData:= DPA->DTQT__ 
                                   ENDIF 
                                ENDIF 
                                Repl CODNF_ With CUP->NUMERO,; 
                                     VENDE_ With nCodVendedor,; 
                                     DESCRI With CUP->CDESCR,; 
                                     FORMUL With nFormula,; 
                                     TABCND With CUP->TABCND,; 
                                     VLRBAS With aSituacao[ 1 ],; 
                                     VLRPAR With aSituacao[ 4 ],; 
                                     VALOR_ With aSituacao[ 2 ],; 
                                     DTDISP With CUP->DATAEM,; 
                                     VLRDSP With aSituacao[ 3 ],; 
                                     VLRPEN With aSituacao[ 3 ] - VLRPAG,; 
                                     TOTAL_ With CUP->VLRTOT,; 
                                     SITUA_ With IF( VLRPEN == 0, "PENDENTE", "LIBERADA" ),; 
                                     VENCIM With CUP->DATAEM + CUP->PRAZOA,; 
                                     PGTO__ With cPag,; 
                                     DTQUIT With dPgtoData 
                             ENDIF 
                          ENDIF 
                       ENDIF 
                    NEXT 
                 ENDIF 
              NEXT 
           ELSE 
              nCodVendedor:= 0 
              IF DBSeek( nCodVendedor ) .AND. nCodVendedor == 0 
                 FOR nCt:= 1 to 10 
                     DBSelectAr( _COD_VENDEDOR ) 
                     /* Leitura e gravacao das comissoes da 1�/10� Formula */ 
                     IF nCt == 1 
                        nFormula:=  VEN->FORM01 
                        nMesIni:=   VEN->MINI01 
                        nMesFim:=   VEN->MFIM01 
                     ELSEIF nCt == 2 
                        nFormula:=  VEN->FORM02 
                        nMesIni:=   VEN->MINI02 
                        nMesFim:=   VEN->MFIM02 
                     ELSEIF nCt == 3 
                        nFormula:=  VEN->FORM03 
                        nMesIni:=   VEN->MINI03 
                        nMesFim:=   VEN->MFIM03 
                     ELSEIF nCt == 4 
                        nFormula:=  VEN->FORM04 
                        nMesIni:=   VEN->MINI04 
                        nMesFim:=   VEN->MFIM04 
                     ELSEIF nCt == 5 
                        nFormula:=  VEN->FORM05 
                        nMesIni:=   VEN->MINI05 
                        nMesFim:=   VEN->MFIM05 
                     ELSEIF nCt == 6 
                        nFormula:=  VEN->FORM06 
                        nMesIni:=   VEN->MINI06 
                        nMesFim:=   VEN->MFIM06 
                     ELSEIF nCt == 7 
                        nFormula:=  VEN->FORM07 
                        nMesIni:=   VEN->MINI07 
                        nMesFim:=   VEN->MFIM07 
                     ELSEIF nCt == 8 
                        nFormula:=  VEN->FORM08 
                        nMesIni:=   VEN->MINI08 
                        nMesFim:=   VEN->MFIM08 
                     ELSEIF nCt == 9 
                        nFormula:=  VEN->FORM09 
                        nMesIni:=   VEN->MINI09 
                        nMesFim:=   VEN->MFIM09 
                     ELSEIF nCt == 10 
                        nFormula:=  VEN->FORM10 
                        nMesIni:=   VEN->MINI10 
                        nMesFim:=   VEN->MFIM10 
                     ENDIF 
                     IF nFormula > 0 
                        aSituacao:= LeFormulas( nFormula, VEN->TIPO__, nMesIni, nMesFim, 2 ) 
                        IF aSituacao[ 1 ] > 0 
                           dbSelectAr( _COD_COMISSAO ) 
                           dbSetOrder( 2 ) 
                           lAppend:= .T. 
                           IF DBSeek( CUP->NUMERO ) 
                             /* Procura pelo calculo j� existente de comissao */ 
                              WHILE CODNF_ == CUP->NUMERO 
                                  IF VENDE_ == nCodVendedor .AND. FORMUL == nFormula 
                                     lAppend:= .F. 
                                     EXIT 
                                  ENDIF 
                                  DBSkip() 
                              ENDDO 
                           ENDIF 
                           IF lAppend 
                              BuscaNet( 5, {|| DBAppend(), !NetErr() } ) 
                           ENDIF 
                           IF netrlock() 
                              cPag:= " " 
                              dPgtoData:= CTOD( "  /  /  " ) 
                              DPA->( DBSetOrder( 1 ) ) 
                              IF DPA->( DBSeek( CUP->NUMERO ) ) 
                                 IF DPA->( !EMPTY( DTQT__ ) ) 
                                    cPag:= StrZero( DPA->LOCAL_, 3, 0 ) 
                                    dPgtoData:= DPA->DTQT__ 
                                 ENDIF 
                              ENDIF 
                              Repl CODNF_ With CUP->NUMERO,; 
                                   VENDE_ With nCodVendedor,; 
                                   DESCRI With CUP->CDESCR,; 
                                   FORMUL With nFormula,; 
                                   TABCND With CUP->TABCND,; 
                                   VLRBAS With aSituacao[ 1 ],; 
                                   VLRPAR With aSituacao[ 4 ],; 
                                   VALOR_ With aSituacao[ 2 ],; 
                                   DTDISP With CUP->DATAEM,; 
                                   VLRDSP With aSituacao[ 3 ],; 
                                   VLRPEN With aSituacao[ 3 ] - VLRPAG,; 
                                   TOTAL_ With CUP->VLRTOT,; 
                                   SITUA_ With IF( VLRPEN == 0, "PENDENTE", "LIBERADA" ),; 
                                   VENCIM With CUP->DATAEM + CUP->PRAZOA,; 
                                   PGTO__ With cPag,; 
                                   DTQUIT With dPgtoData 
                           ENDIF 
                        ENDIF 
                     ENDIF 
                 NEXT 
              ENDIF 
           ENDIF 
        ENDIF 
        DBSelectAr( _COD_CUPOM ) 
        DBSkip() 
    ENDDO 
 
 
    DBSelectAr( _COD_COMISSAO ) 
    DBGoTop() 
    WHILE !EOF() 
         IF !( CODMV_==0 ) 
            IF netrlock() 
               Replace SITUA_ With "QUITADA" 
            ENDIF 
         ENDIF 
         DBSkip() 
    ENDDO 
 
    FOR nCt:= 10 TO 10 
        Scroll( 09, 32, 20, 74, 1 ) 
        @ 20,32 Say SubStr( Repl( "�����������۱����", 20 ), nCt * 3, 42 ) COLOR StrZero( nCt, 2, 0 ) + "/01" 
        @ 20,34 Say "<   FIM   >" COLOR StrZero( nCt, 2, 0 ) + "/01" 
        INKEY(0.01) 
    NEXT 
 
    DBUnlockAll() 
    SWGravar( 5 ) 
    Status() 
    /* Fechamento/Reabertura em modo compartilhado 
       os arquivos de comissao a vendedores */ 
    DBSelectAr( _COD_COMISSAO ) 
    DBCloseArea() 
    DBSelectAr( _COD_COMISAUX ) 
    DBCloseArea() 
    FDBUseVpb( _COD_COMISSAO, 2 ) 
    FDBUseVpb( _COD_COMISAUX, 2 ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    DBSelectAr( nArea ) 
    IF SWAlerta( " << FIM DO CALCULO DE COMISSOES >> ;O que voce deseja fazer?", { "Visualizar Comissoes", "Retornar ao Menu" } )==1 
       ScreenRest( cTela ) 
       VerIndividual() 
    ENDIF 
    ScreenRest( cTela ) 
    Return Nil 
 
 
Function LePercentualFormula( nFormula ) 
Local nArea:= Select(), nPercentual:= 0 
  /* Busca formula/percentual */ 
  DBSelectAr( _COD_COMFAUX ) 
  dbSetOrder( 1 ) 
  IF DBSeek( VAL( STR( nFormula ) ) ) 
     nCodComissao:= INTERN 
     DBSelectAr( _COD_COMPER ) 
     DBSetOrder( 1 ) 
     DBSeek( nCodComissao ) 
     nPercentual:= PERC__ 
  ENDIF 
  DBSelectAr( nArea ) 
  Return nPercentual 
 
/***** 
�������������Ŀ 
� Funcao      � LeFormulas 
� Finalidade  � leitura de formulas de calculo de comissoes 
� Parametros  � nFormula, cIntExt 
�             � nTipo=1 Nota Fiscal      nTipo=2 Cupom Fiscal 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function LeFormulas( nFormula, cIntExt, nMesIni, nMesFim, nTipo ) 
 Loca nArea:= Select() 
 Loca nPercentual:= 0, nBaseCalculo:= 0, nBaseTotal:= 0, nCalculoTotal:= 0,; 
      nTotalDisponivel:= 0, nBaseParcial:= 0, dDataF, dDataI, dDataF2, dDataI2 
 IF nFormula > 0 
    Status( "Formula Definida" ) 
    DBSelectAr( _COD_COMFAUX ) 
    dbSetOrder( 1 ) 
    IF DBSeek( VAL( STR( nFormula ) ) ) 
       Status( "Localizada Formula " + Str( nFormula, 2, 0 ) ) 
       IF nMesIni > nMesFim  /* Normalmente Novembro a Fevereiro p/ ex. */ 
          dDataI:=  CTOD( "01/" + StrZero( nMesIni, 2, 0 ) + "/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ) - 1, 4, 0 ), 3 ) ) 
          dDataI2:= CTOD( "01/" + StrZero( nMesIni, 2, 0 ) + "/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ), 4, 0 ), 3 ) ) 
          IF nMesFim+1 > 12 
             dDataF:= CTOD( "01/01/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ) + 1, 4, 0 ), 3 ) ) 
             dDataF2:= CTOD( "01/01/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ) + 2, 4, 0 ), 3 ) ) 
          ELSE 
             dDataF:= CTOD( "01/" + StrZero( nMesFim+1, 2, 0 ) + "/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ), 4, 0 ), 3 ) ) 
             dDataF2:= CTOD( "01/" + StrZero( nMesFim+1, 2, 0 ) + "/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ) + 1, 4, 0 ), 3 ) ) 
          ENDIF 
       ELSE 
          dDataI:= CTOD( "01/" + StrZero( nMesIni, 2, 0 ) + "/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ), 4, 0 ), 3 ) ) 
          dDataI2:= dDataI 
          IF nMesFim+1 > 12 
             dDataF:= CTOD( "01/01/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ) + 1, 4, 0 ), 3 ) ) 
          ELSE 
             dDataF:= CTOD( "01/" + StrZero( nMesFim+1, 2, 0 ) + "/" + SubStr( StrZero( YEAR( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) ), 4, 0 ), 3 ) ) 
          ENDIF 
          dDataF2:= dDataF 
       ENDIF 
 
       WHILE STRZERO( nFormula, 3, 0 ) == STRZERO( CODIGO, 3, 0 ) .AND.; 
                      ( ( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) >= dDataI  .AND. IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) < dDataF ) .OR.; 
                        ( IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) >= dDataI2 .AND. IF( nTipo==1, NF_->DATAEM, CUP->DATAEM ) < dDataF2 ) ) 
 
          nBaseCalculo:= 0 
          nPercentual:=  0 
          nCalculo:= 0 
          lCalculo:= .F. 
          IF !FORMA_ == 9999             // Se a forma de pagamento nao for generica 
             Status( "Forma de Pagamento restrita" ) 
             IF IF( nTipo==1, NF_->TABCND, CUP->TABCND ) == FORMA_    // Se a condicao da Nota for igual a forma da formula 
                IF CA_->PRECO_ == 999 .AND. CA_->GRUPO_ == 999 
                   Status( "Grupo/Preco sem Restricoes..." ) 
                   nBaseCalculo:= IF( nTipo==1, NF_->VLRTOT, CUP->VLRTOT ) 
                   nPercentual:= BuscaPercentual( cIntExt ) 
                   nCalculo:= ROUND( ( nBaseCalculo * nPercentual ) / 100, SWSet( 1998 ) ) 
                ELSE  // Se grupo ou preco for restrito 
                   Status( "Grupo/Preco Restrito" ) 
                   IF nTipo==1 
                      DBSelectAr( _COD_PRODNF ) 
                      DBSetOrder( 5 ) 
                      DBSeek( NF_->NUMERO ) 
                   ELSE 
                      DBSelectAr( _COD_CUPOMAUX ) 
                      DBSetOrder( 5 ) 
                      DBSeek( CUP->NUMERO ) 
                   ENDIF 
                   lCalculo:= .F. 
                   WHILE CODNF_ == IF( nTipo==1, NF_->NUMERO, CUP->NUMERO ) 
                      IF ( CA_->PRECO_ == TABPRE .OR. CA_->PRECO_ == 999 ) .AND.; 
                         ( Left( CODIGO, 3 ) == StrZero( CA_->GRUPO_, 3, 0 ) .OR. CA_->GRUPO_==999 ) 
                         nBaseCalculo+= PRECOT 
                         lCalculo:= .T. 
                      ELSE 
                         Status( "Base nao recuperada p/ TP|TG..." ) 
                      ENDIF 
                      DBSkip() 
                   ENDDO 
                   IF lCalculo 
                      nPercentual:= BuscaPercentual( cIntExt ) 
                      nCalculo:= ROUND( ( nBaseCalculo * nPercentual ) / 100, SWSet( 1998 ) ) 
                   ENDIF 
                ENDIF 
             ENDIF 
          ELSE 
             Status( "Forma de Pagamento Liberada" ) 
             IF CA_->PRECO_ == 999 .AND. CA_->GRUPO_ == 999 
                Status( "Grupo/Preco sem Restricoes..." ) 
                nBaseCalculo:= IF( nTipo==1, NF_->VLRTOT, CUP->VLRTOT ) 
                nPercentual:= BuscaPercentual( cIntExt ) 
                nCalculo:= ROUND( ( nBaseCalculo * nPercentual ) / 100, SWSet( 1998 ) ) 
             ELSE  // Se grupo ou preco for restrito 
                Status( "Grupo/Preco Restrito" ) 
                IF nTipo==1 
                   DBSelectAr( _COD_PRODNF ) 
                   DBSetOrder( 5 ) 
                   DBSeek( NF_->NUMERO ) 
                ELSE 
                   DBSelectAr( _COD_CUPOMAUX ) 
                   DBSetOrder( 5 ) 
                   DBSeek( CUP->NUMERO ) 
                ENDIF 
                lCalculo:= .F. 
                WHILE CODNF_ == IF( nTipo==1, NF_->NUMERO, CUP->NUMERO ) 
                   IF ( CA_->PRECO_ == TABPRE .OR. CA_->PRECO_ == 999 ) .AND.; 
                      ( Left( CODIGO, 3 ) == StrZero( CA_->GRUPO_, 3, 0 ) .OR. CA_->GRUPO_==999 ) 
                      nBaseCalculo+= PRECOT 
                      lCalculo:= .T. 
                   ELSE 
                      Status( "Base nao recuperada p/ TP|TG..." ) 
                   ENDIF 
                   DBSkip() 
                ENDDO 
                IF lCalculo 
                   nPercentual:= BuscaPercentual( cIntExt ) 
                   nCalculo:= ROUND( ( nBaseCalculo * nPercentual ) / 100, SWSet( 1998 ) ) 
                ENDIF 
             ENDIF 
          ENDIF 
          nBaseTotal+= nBaseCalculo 
          nCalculoTotal+= nCalculo 
          IF cIntExt == "I" 
             IF CA_->FORMAI == "1 " 
                nTotalDisponivel+= nCalculo 
                nBaseParcial:= nBaseTotal 
             ELSE 
                nTotalDisponivel+= ROUND( ( ( nCalculo * PerRecebido( nTipo ) ) / 100 ), SWSet( 1998 ) ) 
                nBaseParcial+= ( ( nBaseCalculo * PerRecebido( nTipo ) ) / 100 ) 
             ENDIF 
          ELSE 
             IF CA_->FORMAE == "1 " 
                nTotalDisponivel+= nCalculo 
                nBaseParcial:= nBaseTotal 
             ELSE 
                nTotalDisponivel+= ROUND( ( ( nCalculo * PerRecebido( nTipo  ) ) / 100 ), SWSet( 1998 ) ) 
                nBaseParcial+= ( ( nBaseCalculo * PerRecebido( nTipo ) ) / 100 ) 
             ENDIF 
          ENDIF 
          Status( "Base de Calculo: " + Tran( nBaseTotal, "@E 999,999,999.99" ) ) 
          DBSelectAr( _COD_COMFAUX ) 
          DBSkip() 
       ENDDO 
    ENDIF 
 ENDIF 
 DBSelectAr( nArea ) 
 Return { nBaseTotal, nCalculoTotal, nTotalDisponivel, nBaseParcial } 
 
/***** 
�������������Ŀ 
� Funcao      � BUSCAPERCENTUAL 
� Finalidade  � Pesquisa o percentual de comuissao 
� Parametros  � cIntExt=> Interno/Externo 
� Retorno     � nPrecentual 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
 Function BuscaPercentual( cIntExt ) 
 Local nPercentual:= 0 
 IF cIntExt == "I" 
    IF CP_->( DBSeek( CA_->INTERN ) ) 
       nPercentual+= CP_->PERC__ 
    ENDIF 
 ELSEIF cIntExt == "E" 
    IF CP_->( DBSeek( CA_->EXTERN ) ) 
       nPercentual+= CP_->PERC__ 
    ENDIF 
 ENDIF 
 Return nPercentual 
 
/***** 
�������������Ŀ 
� Funcao      � PERRECEBIDO 
� Finalidade  � Retornar o percentual recebido da nota fiscal atual 
� Parametros  � Nil 
� Retorno     � nPercentual 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function PerRecebido( nTipo ) 
Local nVlrBase:= IF( nTipo==1, NF_->VLRTOT, CUP->VLRTOT ), nPercentual:= 0, nRecebido:= 0, nPendente:= 0 
Local nArea:= Select() 
  /* 124 So estara sendo utilizado se for comissoes p/ fluxo */ 
  DBSelectAr( 124 ) 
  IF Used() 
     nPercentual:= 100 
  ELSE 
     DBSelectAr( _COD_DUPAUX ) 
     DBSetOrder( 1 ) 
     DBSeek( IF( nTipo==1, NF_->NUMERO, CUP->NUMERO ) ) 
     WHILE CODNF_ == IF( nTipo==1, NF_->NUMERO, CUP->NUMERO ) 
        IF TIPO__ == Space( 2 ) 
           IF EMPTY( DTQT__ ) 
              nPendente+= VLR___ 
           ENDIF 
        ENDIF 
        DBSkip() 
     ENDDO 
     nRecebido:= nVlrBase - nPendente 
     nPercentual:= ( nRecebido / nVlrBase ) * 100 
  ENDIF 
  DBSelectAr( nArea ) 
  Return nPercentual 
 
 
/***** 
�������������Ŀ 
� Funcao      � STATUS 
� Finalidade  � Apresenta o Status na Tela 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
STATIC FUNCTION Status( cStatus ) 
Local cCor:= SetColor() 
Static cTela 
IF cTela == Nil .AND. cStatus == Nil 
   cTela:= ScreenSave( 01, 01, 08, 53 ) 
   VPBox( 04, 05, 07, 50, "STATUS", "15/04" ) 
ELSEIF cStatus == Nil 
   ScreenRest( cTela ) 
   cTela:= Nil 
   Return Nil 
ENDIF 
IF !Empty( cStatus ) 
   SetColor( "14/04" ) 
   @ 06,06 Say Space( 42 ) 
   @ 06,06 Say cStatus 
   SetColor( cCor ) 
ENDIF 
 
/***** 
�������������Ŀ 
� Funcao      � LimpaCalculos 
� Finalidade  � Limpar Calculos de Comissoes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function LimpaCalculos() 
Local nArea:= Select() 
 
 DBSelectAr( _COD_COMISSAO ) 
 
 /* Tentativa de bloqueio de informacoes */ 
 IF Used() 
    FLOCK() 
    WHILE NetErr() 
       Mensagem( "Para efetuar esta operacao. Utilize somente um computador." ) 
       IF SWAlerta( "Feche o sistema em todos os computadores.", { " OK ", "Cancelar" } )==2 
          EXIT 
       ENDIF 
    ENDDO 
    DBCloseArea() 
 ENDIF 
 
 /* Excluir arquivos de comissoes */ 
 //FErase( _VPB_COMISSAO ) 
 //AEVAL( directory(GDir - "\CM_IND*.NTX"), {|ARQ|FileDel( GDIR+"\"+ARQ[1] ) } ) 
 //CreateVpb( _COD_COMISSAO ) 
 
 /* Abre arquivos de comissionamento */ 
 FDBUseVpb( _COD_COMISAUX, 2 ) 
 FDBUseVpb( _COD_COMISSAO, 2 ) 
 DBGOTOP() 
 WHILE !EOF() 
    IF CODMV_ == 0 .AND. VLRPAG == 0 
       DBSelectAr( _COD_COMISAUX ) 
       DBSetOrder( 2 ) 
       IF DBSeek( COM->CODNF_ ) 
          WHILE COM->CODNF_ == CODNF_ .AND. !EOF() 
             IF netrlock() 
                Dele 
             ENDIF 
             DBSkip() 
          ENDDO 
      ENDIF 
      DBSelectAr( _COD_COMISSAO ) 
      IF netrlock() 
         Dele 
      ENDIF 
    ENDIF 
    DBSkip() 
 ENDDO 
 DBSelectAr( _COD_COMISSAO ) 
 IF USED() 
    DBCloseArea() 
    IF FDBUseVpb( _COD_COMISSAO, 1 ) 
       PACK 
    ELSE 
       SWAlerta( "Impossivel utilizar o arquivo em modo exclusivo!", { "OK" } ) 
       DBUnlockAll() 
       DBSelectAr( nArea ) 
       Return .F. 
    ENDIF 
    DBCloseArea() 
    FDBUseVPB( _COD_COMISSAO, 2 ) 
 ENDIF 
 DBUnlockAll() 
 DBSelectAr( nArea ) 
 Return .T. 
 
