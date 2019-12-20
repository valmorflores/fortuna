// ## CL2HB.EXE - Converted
 
#Include "vpf.ch" 
#Include "inkey.ch" 
 
FUNCTION Romaneio( nOrdemCmp, cProduto, nQuantidade, nCodFor, nNota ) 
Local GetList:= {} 
Local lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aCodigo, nOpcao 
Local nRow:= 1, oTb, nTecla:= 0, nPosL, nPosC, lAchou, nLin, nCol 
 
/* Montagem da tela de edicao */ 
VPBox( 0, 0, 22, 79, "ROMANEIO DE ENTRADA DE PRODUTOS", _COR_GET_BOX ) 
SetColor( "15/01" ) 
@ 02,01 Say " Produto:                                                    Qtd:             " 
SetColor( "14/01" ) 
@ 02,11 Say MPR->DESCRI 
@ 02,68 Say INT( nQuantidade ) 
SetColor( _COR_BROWSE ) 
@ 03,01 Say "����������������������������������������������������������������������������Ŀ" 
@ 04,01 Say "�            A             B             C             D             E       �" 
@ 05,01 Say "�   1  ������������� ������������� ������������� ������������� ������������� �" 
@ 06,01 Say "�   2  ������������� ������������� ������������� ������������� ������������� �" 
@ 07,01 Say "�   3  ������������� ������������� ������������� ������������� ������������� �" 
@ 08,01 Say "�   4  ������������� ������������� ������������� ������������� ������������� �" 
@ 09,01 Say "�   5  ������������� ������������� ������������� ������������� ������������� �" 
@ 10,01 Say "�   6  ������������� ������������� ������������� ������������� ������������� �" 
@ 11,01 Say "�   7  ������������� ������������� ������������� ������������� ������������� �" 
@ 12,01 Say "�   8  ������������� ������������� ������������� ������������� ������������� �" 
@ 13,01 Say "�   9  ������������� ������������� ������������� ������������� ������������� �" 
@ 14,01 Say "�  10  ������������� ������������� ������������� ������������� ������������� �" 
@ 15,01 Say "�  11  ������������� ������������� ������������� ������������� ������������� �" 
@ 16,01 Say "�  12  ������������� ������������� ������������� ������������� ������������� �" 
@ 17,01 Say "�  13  ������������� ������������� ������������� ������������� ������������� �" 
@ 18,01 Say "�  14  ������������� ������������� ������������� ������������� ������������� �" 
@ 19,01 Say "����������������������������������������������������������������������������Ĵ" 
@ 20,01 Say "� Tipo de Codificacao do Produto: [1]Propria [2]Fabricante [3]Especial       �" 
@ 21,01 Say "������������������������������������������������������������������������������" 
/* montagem do array */ 
aCodigo:= {} 
FOR nCt:= 1 TO INT( nQuantidade / 10 ) 
     AAdd( aCodigo, { StrZero( nCt, 4, 0 ), Space( 100 ), Space( 100 ), Space( 100 ), Space( 100 ),; 
                     Space( 100 ), Space( 100 ), Space( 100 ), Space( 100 ),; 
                     Space( 100 ), Space( 100 ), Space( 100 ), Space( 100 ) } ) 
    IF nCt > 50 
       Exit 
    ENDIF 
NEXT 
nCt= nCt - 1 
IF nQuantidade - ( nCt * 10 ) > 0 
   nFalta:= nQuantidade - ( nCt * 10 ) 
   AAdd( aCodigo, { StrZero( nCt + 2, 4, 0 ) } ) 
   FOR nCt:= 1 TO 10 
       IF nCt <= nFalta 
          AAdd( aCodigo[ Len( aCodigo ) ], Space( 100 ) ) 
       ELSE 
          AAdd( aCodigo[ Len( aCodigo ) ], "�������������" ) 
       ENDIF 
   NEXT 
ENDIF 
 
/* AJUDA */ 
Mensagem( "[Enter]Edicao [G]Gravar [ESC]Cancelar" ) 
Ajuda( "[" + _SETAS + "]Movimenta [ESC]Sair" ) 
 
/* MONTAGEM DO BROWSE */ 
SetColor( _COR_BROWSE ) 
oTb:= TBrowseDb( 04, 02, 18, 77 ) 
oTb:AddColumn( tbcolumnnew("    ",          {|| aCodigo[nRow][1] })) 
oTb:AddColumn( tbcolumnnew("      A      ", {|| PADR( ALLTRIM( aCodigo[nRow][2] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      B      ", {|| PADR( ALLTRIM( aCodigo[nRow][3] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      C      ", {|| PADR( ALLTRIM( aCodigo[nRow][4] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      D      ", {|| PADR( ALLTRIM( aCodigo[nRow][5] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      E      ", {|| PADR( ALLTRIM( aCodigo[nRow][6] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      F      ", {|| PADR( ALLTRIM( aCodigo[nRow][7] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      G      ", {|| PADR( ALLTRIM( aCodigo[nRow][8] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      H      ", {|| PADR( ALLTRIM( aCodigo[nRow][9] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      I      ", {|| PADR( ALLTRIM( aCodigo[nRow][10] ), 13 ) })) 
oTb:AddColumn( tbcolumnnew("      J      ", {|| PADR( ALLTRIM( aCodigo[nRow][11] ), 13 ) })) 
oTb:ColorSpec:= SetColor() + ",15/04,14/03" 
oTb:Freeze:= 1 
oTb:AUTOLITE:=.f. 
oTb:GOTOPBLOCK:={|| nRow:= 1 } 
oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aCodigo ) } 
oTb:SKIPBLOCK:={|x| skipperarr( x, aCodigo, @nRow ) } 
OTb:dehilite() 
 
nOpcao:= 2 
@ 20,36 Prompt "1" 
@ 20,47 Prompt "2" 
@ 20,61 Prompt "3" 
Menu to nOpcao 
oTb:Right() 
nCont:= 0 
 
DO CASE 
   CASE nOpcao == 1 
        DBSelectAr( _COD_ROMANEIO ) 
        DBSetOrder( 1 ) 
        DBSeek( MPR->INDICE ) 
        WHILE !SUBSTR( ROMANE, 1, 9 ) == StrZero( nCodFor, 3, 0 ) + StrZero( nNota, 6, 0 ) .AND.; 
           !EOF() 
           DBSkip() 
        ENDDO 
        WHILE MPR->INDICE == CODPRO .AND. StrZero( nCodFor, 3, 0 ) + StrZero( nNota, 6, 0 ) == SubStr( ROMANE, 1, 9 ) .AND.; 
            !EOF() 
            nCont:= VAL( SubStr( ROMANE, 10, 3 ) ) + 1 
            DBSkip() 
        ENDDO 
        //@ 11,11 SAY MPR->INDICE 
        //@ 12,11 SAY nCont 
        //Pausa() 
        FOR nCt:= 1 TO Len( aCodigo ) 
           FOR nCt2:= 2 TO Len( aCodigo[ nCt ] ) 
               IF !ALLTRIM( aCodigo[ nCt ][ nCt2 ] ) == "�������������" 
                  ++nCont 
                  cCodigo:= StrZero( nCodFor, 3, 0 ) + StrZero( nNota, 6, 0 ) + StrZero( nCont, 3, 0 ) 
                  aCodigo[ nCt ][ nCt2 ]:= PAD( cCodigo + TWCalcDig( cCodigo ), 100 ) 
                  oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, oTb:ColCount }, { 7, 1 } ) 
                  oTB:colorrect( { oTB:ROWPOS, oTb:COLPOS, oTB:ROWPOS, oTB:COLPOS }, { 6, 1 } ) 
                  WHILE !oTb:Stabilize() 
                  ENDDO 
                  Inkey( .01 ) 
                  oTb:Right() 
                  oTb:RefreshCurrent() 
               ENDIF 
           NEXT 
           oTb:Down() 
           oTb:PanLeft() 
           oTb:RefreshAll() 
        NEXT 
   CASE nOpcao == 3 
        nCodigoIni:= 0 
        nCodigoFinal:= 0 
        cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
        @ 03,03 Say "Codigo Inicial:" Get nCodigoIni 
        @ 04,03 Say "Codigo Final:  " Get nCodigoFinal 
        READ 
        ScreenRest( cTelaRes ) 
        nCont:= nCodigoIni-1 
        FOR nCt:= 1 TO Len( aCodigo ) 
           FOR nCt2:= 2 TO Len( aCodigo[ nCt ] ) 
               IF !ALLTRIM( aCodigo[ nCt ][ nCt2 ] ) == "�������������" 
                  ++nCont 
                  cCodigo:= StrZero( nCont, 08, 0 ) 
                  cCodigo:= NossoNumero( cCodigo ) 
                  cCodigo:= cCodigo + TWCalcDig( cCodigo ) 
                  cCodigo:= Tran( cCodigo, "@R 99999999.99-9" ) 
                  aCodigo[ nCt ][ nCt2 ]:= PAD( cCodigo, 100 ) 
                  oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, oTb:ColCount }, { 7, 1 } ) 
                  oTB:colorrect( { oTB:ROWPOS, oTb:COLPOS, oTB:ROWPOS, oTB:COLPOS }, { 6, 1 } ) 
                  WHILE !oTb:Stabilize() 
                  ENDDO 
                  oTb:Right() 
                  oTb:RefreshCurrent() 
               ENDIF 
               IF nCont >= nCodigoFinal 
                  EXIT 
               ENDIF 
           NEXT 
           oTb:Down() 
           oTb:PanLeft() 
           oTb:RefreshAll() 
           IF nCont >= nCodigoFinal 
               EXIT 
           ENDIF 
        NEXT 
ENDCASE 
 
whil .t. 
 
     oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, oTb:ColCount }, { 7, 1 } ) 
     oTB:colorrect( { oTB:ROWPOS, oTb:COLPOS, oTB:ROWPOS, oTB:COLPOS }, { 6, 1 } ) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
 
     @ 20,03 Say PAD( aCodigo[ nRow ][ oTb:ColPos ], 73 ) 
 
     IF ( nTecla:=inkey(0) ) == K_ESC 
        Exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTB:up() 
        case nTecla==K_LEFT       ;oTB:left() 
        case nTecla==K_RIGHT      ;oTB:right() 
        case nTecla==K_DOWN       ;oTB:down() 
        case nTecla==K_PGUP       ;oTB:pageup() 
        case nTecla==K_PGDN       ;oTB:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
        case Chr( nTecla ) $ "0123456789" 
             cPesquisa:= Space( 120 ) 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             VPBox( 20, 01, 23, 70, "Pesquisa", "07/00" ) 
             Keyboard Chr( nTecla ) 
 
             SetCursor( 1 ) 
             @ 22,03 Get cPesquisa Pict "@S63" Color "00/15,15/00" 
             Read 
             SetCursor( 0 ) 
 
             lAchou:= .F. 
             FOR nLin:= 1 TO Len( aCodigo ) 
                 FOR nCol:= 2 TO Len( aCodigo[ nLin ] ) 
                     IF ALLTRIM( aCodigo[ nLin, nCol ] )==ALLTRIM( cPesquisa ) 
                        lAchou:= .T. 
                        nPosL:= nLin 
                        nPosC:= nCol 
                     ENDIF 
                 NEXT 
             NEXT 
 
             /* Se nao achou, tenta com espaco em branco */ 
             IF !lAchou 
                FOR nLin:= 1 TO Len( aCodigo ) 
                    FOR nCol:= 2 TO Len( aCodigo[ nLin ] ) 
                        IF ALLTRIM( aCodigo[ nLin, nCol ] )=="" 
                           lAchou:= .T. 
                           nPosL:=  nLin 
                           nPosC:=  nCol 
                           nLin:=   Len( aCodigo )           && Linha 
                           nCol:=   Len( aCodigo[ nLin ] )   && Forcar a saida 
                        ENDIF 
                    NEXT 
                NEXT 
             ENDIF 
 
             IF lAchou 
                nRow:= nPosL 
                oTb:ColPos:= nPosC 
                /* Pressiona ENTER p/ Alterar e a tecla digitada no espaco em branco */ 
                Clear Typeahead 
                Keyboard Chr( K_ENTER ) + cPesquisa 
             ENDIF 
             ScreenRest( cTelaRes ) 
 
        case Chr( nTecla ) $ "Gg" 
             GravaRomaneio( aCodigo, IF( nOpcao == 1, "I", "E" ) ) 
             Keyboard Chr( K_ESC ) 
 
        case nTecla == K_ENTER 
 
             IF oTb:ColPos > 1 .AND. ! ALLTRIM( aCodigo[ nRow ][ oTb:ColPos ] ) == "�������������" 
                nColPos:= oTb:ColPos 
                WHILE !oTb:Stabilize() 
                ENDDO 
                SetCursor( 1 ) 
                @ row(),col() Say "< Editando! >" 
                @ 20, 03 Get aCodigo[ nRow ][ nColPos ] Pict "@S73" 
                Read 
                SetCursor( 0 ) 
                IF oTb:RowPos + 1 <= oTb:RowCount 
                   oTb:Down() 
                ELSE 
                   oTb:PageUp() 
                   oTb:Right() 
                ENDIF 
                oTb:RefreshAll() 
                WHILE !oTb:Stabilize() 
                ENDDO 
             ENDIF 
 
     endcase 
     oTb:Refreshcurrent() 
     oTb:stabilize() 
enddo 
Set( _SET_DELIMITERS, lDelimiters ) 
setcolor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
IF nArea > 0 
   DBSelectAr( nArea ) 
   if nOrdem > 0 
      DBSetOrder( nOrdem ) 
   endif 
ENDIF 
Return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � GravaRomaneio 
� Finalidade  � Gravar informacoes de romaneio 
� Parametros  � aCodigo=>Array com informacoes de romaneio 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function GravaRomaneio( aCodigo, cIntExt ) 
 
    DBSelectAr( _COD_ROMANEIO ) 
    /* Gravacao dos dados */ 
    For nCt:= 1 TO Len( aCodigo ) 
        For nCt2:= 2 To Len( aCodigo[ nCt ] ) 
            IF ! aCodigo[ nCt ][ nCt2 ] == "�������������" 
               DBAppend() 
               Repl ROMANE With aCodigo[ nCt ][ nCt2 ],; 
                    CODPRO With MPR->INDICE,; 
                    DATENT With DATE(),; 
                    INTEXT With cIntExt 
            ENDIF 
        Next 
    Next 
    DBUnlockAll() 
    Return Nil 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function VisualRomaneio( cCodProduto, aSelecionados, nNumero ) 
Local GetList:= {} 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 1 ) 
IF !DBSeek( PAD( cCodProduto, 12 ) ) 
   Aviso( "Um dos produtos n�o foi localizado no cadastro.", 12 ) 
   Mensagem( "Pressione [Enter] para continuar." ) 
   Pausa() 
   ScreenRest( cTela ) 
   Return .F. 
ENDIF 
DBSelectAr( _COD_ROMANEIO ) 
Set Filter To CODPRO == MPR->INDICE 
DBGobottom() 
VPBox( 02, 33, 20, 77, "NUMEROS DE SERIE", _COR_BROW_BOX ) 
SetColor( _COR_BROWSE ) 
@ 03,34 Say "Produto Selecionado: " + Tran( cCodProduto, "@R 999-9999" ) 
@ 04,34 Say MPR->CODFAB 
@ 05,34 Say Left( MPR->DESCRI, 43 ) 
@ 06,34 Say "�������������������������������������������" 
oTb:= TBrowseDb( 07, 34, 19, 76 ) 
oTb:AddColumn( tbcolumnnew("Numero/Serie", {|| SELECT + " " + ROMANE } ) ) 
oTb:AddColumn( tbcolumnnew("I/E",          {|| IF( IntExt == "I", "Cod.Interno", "Cod.Fabrica" ) } ) ) 
oTb:AddColumn( tbcolumnnew("Entrada",      {|| DatEnt } ) ) 
oTb:AddColumn( tbcolumnnew("Saida",        {|| DatSai } ) ) 
oTb:ColorSpec:= SetColor() + ",15/04,14/03" 
oTb:AUTOLITE:=.f. 
oTb:dehilite() 
WHILE .T. 
     oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, oTb:ColCount }, { 7, 1 } ) 
     oTB:colorrect( { oTB:ROWPOS, oTb:COLPOS, oTB:ROWPOS, oTB:COLPOS }, { 6, 1 } ) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
     IF ( nTecla:=inkey(0) ) == K_ESC 
        Exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTB:up() 
        case nTecla==K_LEFT       ;oTB:left() 
        case nTecla==K_RIGHT      ;oTB:right() 
        case nTecla==K_DOWN       ;oTB:down() 
        case nTecla==K_PGUP       ;oTB:pageup() 
        case nTecla==K_PGDN       ;oTB:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
        case nTecla==K_INS 
 
             cCorRes:= SetColor() 
             cNumero:= Space( 100 ) 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             dDataEm:= Date() 
             cIntExt:= "I" 
             VPBox( 09, 06, 16, 70, " Novo Numero de Serie ", _COR_GET_BOX ) 
             SetColor( _COR_GET_BOX ) 
             @ 11, 08 Say "Cod.Produto....:" Get cCodProduto When; 
                  Mensagem( "Digite o codigo do produto." ) 
             @ 12, 08 Say "N�Serie........:" Get cNumero Pict "@S20" When; 
                  Mensagem( "Digite o numero se serie para cadastrar." ) 
             @ 13, 08 Say "Data Entrada...:" Get dDataEm When; 
                  Mensagem( "Digite a data de entrada deste item." ) 
             @ 14, 08 Say "Cd.Int./Exter..:" Get cIntExt When; 
                  Mensagem( "Digite [I] caso o codigo interno ou [E] seja fornecido p/ fabrica." ) 
             READ 
             IF Confirma( 0, 0, "Confirma?", "Confirma o cadastramento do item?", "S" ) 
                DBAppend() 
                IF netrlock() 
                   Replace CODPRO With PAD( cCodProduto, 12 ),; 
                           ROMANE With cNumero,; 
                           DATENT With dDataEm,; 
                           DATSAI With DATE(),; 
                           CODNF_ With nNumero,; 
                           INTEXT With cIntExt 
                   AAdd( aSelecionados, { PAD( cCodProduto, 12 ),; 
                                       cNumero,; 
                                       Space( 1 ) } ) 
                ENDIF 
                DBUnlock() 
             ENDIF 
             SetColor( cCorRes ) 
             ScreenRest( cTelaRes ) 
             oTb:RefreshAll() 
             WHILE !oTB:Stabilize() 
             ENDDO 
        CASE nTecla==K_ESC 
             Exit 
        case nTecla==K_ENTER 
             IF netrlock() 
                Replace Select With IF( Select == "*", " ", "*" ) 
                IF CODNF_ == nNumero .OR. CODNF_ == 0 
                   Replace DatSai With IF( Select == "*", DATE(), CTOD( "  /  /  " ) ),; 
                           CODNF_ With IF( Select == "*", nNumero, 0 ) 
                   IF Select == "*" 
                      AAdd( aSelecionados,  { CODPRO, ROMANE, INTEXT } ) 
                   ELSE 
                      IF ( nPos:= AScan( aSelecionados, {|x| x[2] == ROMANE } ) ) > 0 
                         aSelecionados[ nPos ][ 1 ]:= Space( 12 ) 
                         aSelecionados[ nPos ][ 2 ]:= Space( 100 ) 
                         aSelecionados[ nPos ][ 3 ]:= Space( 1 ) 
                      ENDIF 
                   ENDIF 
                ELSE 
                   cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                   Aviso( "Foi vendido c/ a Nota Fiscal n� " + StrZero( CODNF_, 6, 0 ) + " do dia " + DTOC( DatSai ) + ".", 12 ) 
                   Pausa() 
                   ScreenRest( cTelaRes ) 
                ENDIF 
             ENDIF 
             DBUnlock() 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
 
     ENDCASE 
     oTb:RefreshCurrent() 
     WHILE !oTb:Stabilize() 
     ENDDO 
ENDDO 
IF nArea > 0 
   DBSelectAr( nArea ) 
   IF nOrdem > 0 
      DBSetOrder( nOrdem ) 
   ENDIF 
ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return .T. 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � IMPROMANEIO 
� Finalidade  � Impressao de Romaneio com base nas notas fiscais 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function ImpRomaneio() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
  DBSelectAr( _COD_NFISCAL ) 
  DBGoBottom() 
  DBLeOrdem() 
 
  SetCursor( 0 ) 
  SetColor( _COR_BROWSE ) 
  VPBox( 0, 0, 24-2, 79, " IMPRESSAO DE ROMANEIO DE SAIDA ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. ) 
  Mensagem( "Pressione [ENTER] para selecionar a nota fiscal." ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Imprime [ESC]Cancela") 
  VPBox( 16, 00, 22, 79, , _COR_BROW_BOX, .F., .F. ) 
  SetColor( _COR_BROWSE ) 
  oTB:=tbrowsedb( 17, 01, 24-3, 79-1 ) 
  oTB:addcolumn(tbcolumnnew(,{|| NFNULA + TIPONF + StrZero(NUMERO,6,0)+"-"+CDESCR+" "+dtoc(DATAEM) + " " + StrZero( TRANSP, 3, 0 ) + " " + Tran( NATOPE, "9.999" ) + " " + SELECT })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  whil .t. 
     oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
     IF SELECT == "Sim" 
        SetColor( "15/01" ) 
        @ Row(), 75 Say "Sim" 
        SetColor( _COR_BROWSE ) 
     ENDIF 
 
     DisplayRomaneio() 
     nTecla:=inkey(0) 
     if nTecla=K_ESC 
        exit 
     endif 
     do case 
        case nTecla==K_UP         ;oTB:up() 
        case nTecla==K_LEFT       ;oTB:up() 
        case nTecla==K_RIGHT      ;oTB:down() 
        case nTecla==K_DOWN       ;oTB:down() 
        case nTecla==K_PGUP       ;oTB:pageup() 
        case nTecla==K_PGDN       ;oTB:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
        case nTecla==K_CTRL_TAB 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             nCursorRes:= SetCursor() 
             cCorRes:= SetColor() 
             VPbox( 04, 37, 11, 73, , _COR_GET_BOX ) 
             SetColor( _COR_GET_EDICAO ) 
             nOpcao:= 1 
             @ 05,38 Prompt " Rom. Definitivo (Por Rota)       " 
             @ 06,38 Prompt " Rom. Definitivo (Todas as Rotas) " 
             @ 07,38 Prompt " Relacao de Notas Fiscais (Rota)  " 
             @ 08,38 Prompt " Espelho de Notas Fiscais         " 
             @ 09,38 Prompt " Rom. de Garantia (NF)            " 
             @ 10,38 Prompt " Relacao p/ Separacao de Material " 
             Menu To nOpcao 
             SetColor( _COR_GET_EDICAO ) 
             nRota:= 0 
             nRota1:= 0 
             nRota2:= 999 
             IF nOpcao==2 
                nRota:= 999 
                nOpcao:= 1 
             ENDIF 
 
             /* Impressao cfe. rota de transporte */ 
             DO CASE 
                CASE nOpcao == 4 
                     DBSetOrder( 5 ) 
                     DBSeek( "Sim" ) 
                     IF Confirma( 0, 0, "Imprimir Romaneio Geral?", "Digite [S] para imprimir o romaneio.", "S" ) 
                        Relatorio( "ROMGERAL.REP" ) 
                     ENDIF 
                     dbselectar(_COD_NFISCAL) 
 
                CASE nOpcao == 5 
                     DBSelectAr( _COD_ROMANEIO ) 
                     DBSetOrder( 3 ) 
                     IF Confirma( 0, 0, "Imprimir?", "Digite [S] para imprimir o romaneio.", "S" ) 
                        Relatorio( "ROMANEIO.REP" ) 
                     ENDIF 
                     dbselectar(_COD_NFISCAL) 
 
                CASE nOpcao == 3 
 
                     *-RELACAO DE NOTAS FISCAIS POR ROTA-----------------------------------* 
                     dDataIni:= DATE() 
                     dDataFim:= DATE() 
 
                     SetCursor( 1 ) 
                     VPBox( 08, 08, 14, 60, " Selecao p/ Impressao ", _COR_GET_BOX ) 
                     SetColor( _COR_GET_EDICAO ) 
 
                     @ 10,10 Say " Imprimir do dia:" Get dDataIni 
                     @ 11,10 Say "       Ate o dia:" Get dDataFim 
                     IF nRota == 0 
                        @ 12,10 Say "         Da Rota:" Get nRota1 
                        @ 13,10 Say "      Ate a Rota:" Get nRota2 
                     ENDIF 
                     READ 
 
                     nRota:= nRota1 
                     nRegistro:= NF_->( RECNO() ) 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 7 ) 
                     aStr:= {{"PEDIDO","C",08,00},; 
                             {"CODNF_","N",06,00},; 
                             {"PRAZO_","N",04,00},; 
                             {"ROTA__","N",04,00},; 
                             {"VALOR_","N",16,02},; 
                             {"NATOPE","N",06,03}} 
                     dbcreate( "RESERVA.TMP", aStr ) 
                     DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Use Reserva.Tmp Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) To Indice01 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Set Index To Indice01 
                     DBSetOrder( 1 ) 
                     DBSelectAr( _COD_NFISCAL ) 
                     DBSetOrder( 3 ) 
                     DBSeek( dDataIni, .T. ) 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 6 ) 
                     DBSeek( StrZero( NF_->PEDIDO, 8, 0 ) ) 
                     PXP->( DBSetOrder( 2 ) ) 
                     WHILE !NF_->( EOF() ) .AND. NF_->( DATAEM >= dDataIni .AND. DATAEM <= dDataFim ) 
                        DBSeek( StrZero( NF_->PEDIDO, 8, 0 ) ) 
                        IF ( ( PED->TRANSP >= nRota1 .AND. PED->TRANSP <= nRota2 ) .AND. NF_->NFNULA==" " ) .OR. nRota == 999 
                           IF nRota == 999 
                              nRotaAtual:= 999 
                           ELSE 
                              nRotaAtual:= PED->TRANSP 
                           ENDIF 
                           RES->( DBAppend() ) 
                           RES->( netrlock() ) 
                           Replace RES->PEDIDO With PED->CODPED,; 
                                   RES->PRAZO_ With NF_->PRAZOA,; 
                                   RES->CODNF_ With NF_->NUMERO,; 
                                   RES->ROTA__ With nRotaAtual,; 
                                   RES->VALOR_ With NF_->VLRTOT,; 
                                   RES->NATOPE With NF_->NATOPE 
                        ENDIF 
                        NF_->( DBSkip() ) 
                     ENDDO 
                     DBSelectAr( _COD_MPRIMA ) 
                     DBSetOrder( 1 ) 
                     DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + STR( CODNF_ ) To IND33913.TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Set Index To IND33913.TMP 
                     DBGoTop() 
                     IF Confirma( 00, 00,; 
                        "Confirma a impressao da Lista de Notas Fiscais?",; 
                        "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                        Relatorio( "RELROTA3.REP" ) 
                     ENDIF 
                     DBSelectAr( 133 ) 
                     DBCloseArea() 
                     DBSelectAr( _COD_NFISCAL ) 
                     DBGoTo( nRegistro ) 
 
                CASE nOpcao == 1 
 
                     *-ROMANEIO DE PRODUTOS------------------------------------------------* 
                     dDataIni:= DATE() 
                     dDataFim:= DATE() 
 
                     SetCursor( 1 ) 
                     VPBox( 08, 08, 14, 60, " Selecao p/ Impressao ", _COR_GET_BOX ) 
                     SetColor( _COR_GET_EDICAO ) 
                     @ 10,10 Say " Imprimir do dia:" Get dDataIni 
                     @ 11,10 Say "       Ate o dia:" Get dDataFim 
                     IF nRota == 0 
                        @ 12,10 Say "         Da Rota:" Get nRota1 
                        @ 13,10 Say "      Ate a Rota:" Get nRota2 
                     ENDIF 
                     READ 
 
                     nRegistro:= NF_->( RECNO() ) 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 7 ) 
                     aStr:= {{"PEDIDO","C",08,00},; 
                             {"CODPRO","C",12,00},; 
                             {"DESPRO","C",45,00},; 
                             {"QUANT_","N",16,04},; 
                             {"QTDINT","N",16,04},; 
                             {"DIFER_","N",16,04},; 
                             {"UNIDAD","C",02,00},; 
                             {"ROTA__","N",03,00},; 
                             {"PADRAO","N",16,04},; 
                             {"PESOLI","N",16,04},; 
                             {"PESOBR","N",16,04}} 
                     dbcreate( "RESERVA.TMP", aStr ) 
                     DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Use Reserva.Tmp Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + DESPRO To Indice01 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + CODPRO To Indice02 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Set Index To Indice01, Indice02 
                     DBSetOrder( 1 ) 
                     DBSelectAr( _COD_NFISCAL ) 
                     DBSetOrder( 3 ) 
                     DBSeek( dDataIni, .T. ) 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 6 ) 
                     DBSeek( StrZero( NF_->PEDIDO, 8, 0 ) ) 
                     PXP->( DBSetOrder( 2 ) ) 
                     WHILE !NF_->( EOF() ) .AND. NF_->( DATAEM >= dDataIni .AND. DATAEM <= dDataFim ) 
                        DBSeek( StrZero( NF_->PEDIDO, 8, 0 ) ) 
                        IF ( PED->TRANSP >= nRota1 .AND. PED->TRANSP <= nRota2 ) .OR. nRota == 999 
                           PXP->( DBSeek( PED->CODIGO ) ) 
                           WHILE PXP->CODIGO == PED->CODIGO .AND. !PXP->( EOF() ) 
                              IF nRota == 999 
                                 nRotaAtual:= 999 
                              ELSE 
                                 nRotaAtual:= PED->TRANSP 
                              ENDIF 
                              IF RES->( DBSeek( Str( nRotaAtual, 3, 0 ) + PAD( PXP->DESCRI, 45 ) ) ) 
                                 IF RES->( netrlock() ) 
                                    Replace RES->QUANT_ With RES->QUANT_ + PXP->QUANT_ 
                                 ENDIF 
                              ELSE 
                                 RES->( DBAppend() ) 
                                 RES->( netrlock() ) 
                                 Replace RES->PEDIDO With PXP->CODIGO,; 
                                         RES->CODPRO With StrZero( PXP->CODPRO, 7, 0 ) + Space( 5 ),; 
                                         RES->DESPRO With PXP->DESCRI,; 
                                         RES->QUANT_ With PXP->QUANT_,; 
                                         RES->UNIDAD With PXP->UNIDAD,; 
                                         RES->ROTA__ With nRotaAtual 
                              ENDIF 
                              PXP->( DBSkip() ) 
                           ENDDO 
                        ENDIF 
                        NF_->( DBSkip() ) 
                     ENDDO 
                     DBSelectAr( _COD_MPRIMA ) 
                     DBSetOrder( 1 ) 
                     DBSelectAr( 133 ) 
                     Set Relation To CODPRO Into MPR 
                     DBGoTop() 
                     WHILE !EOF() 
                        IF netrlock() 
                           nCoef:=  QUANT_ / MPR->QTDPES 
                           nQuantInteira:= Int( nCoef ) 
                           nDifer:= QUANT_ - ( INT( nCoef ) * MPR->QTDPES ) 
                           Replace  QTDINT With nQuantInteira,; 
                                    DIFER_ With nDifer,; 
                                    PADRAO With MPR->QTDPES,; 
                                    PESOLI With MPR->PESOLI * QUANT_,; 
                                    PESOBR With MPR->PESOBR * QUANT_ 
                        ENDIF 
                        DBSkip() 
                     ENDDO 
                     DBSetOrder( 2 ) 
                     DBGoTop() 
                     IF Confirma( 00, 00,; 
                        "Confirma a impressao de itens por rota?",; 
                        "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                        Relatorio( "RELROTA2.REP" ) 
                     ENDIF 
                     DBSelectAr( 133 ) 
                     DBCloseArea() 
                     DBSelectAr( _COD_NFISCAL ) 
                     DBGoTo( nRegistro ) 
 
             ENDCASE 
             SetColor( cCorRes ) 
             SetCursor( nCursorRes ) 
 
        case DBPesquisa( nTecla, oTB ) 
             IF IndexOrd() == 2 
                BuscaUltima( oTb ) 
             ENDIF 
        case nTecla==K_F3         ;DBMudaOrdem( 1, oTB ) 
        case nTecla==K_F4         ;DBMudaOrdem( 2, oTB ) 
        case nTecla==K_INS 
             //IncluiRomaneio() 
        case nTecla==K_ENTER 
             AlteraRomaneio() 
 
        case nTecla==K_SPACE 
             IF netrlock() 
                Replace SELECT With IF( SELECT == "Sim", "Nao", "Sim" ) 
             ENDIF 
             DBUnlock() 
 
        case nTecla==K_F8         ;BuscaUltima( oTb ) 
 
 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTB:refreshcurrent() 
   oTB:stabilize() 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBUnlockAll() 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function AlteraRomaneio() 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      oTb 
 
 
  VPBox( 00, 00, 14, 79, " ROMANEIO DE SAIDA - NUMEROS DE SERIE POR PRODUTO ", _COR_GET_BOX, .F., .F. ) 
  VPBox( 08, 0, 15, 79, " RELACAO DE PRODUTOS DA NOTA FISCAL ", _COR_BROW_BOX, .F., .F. ) 
 
  DBSelectAr( _COD_ROMANEIO ) 
  Mensagem( "N� Serie: [ENTER]Altera [INS]Inclui [ESC]Finalizar." ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Imprime [ESC]Cancela") 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Index On CODPRO To Indice99 eval {|| processo() } For CODNF_ == NF_->NUMERO 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to indice99, "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"    
  #else 
    Set Index To Indice99, "&GDir\ROMIND01.NTX", "&GDir\ROMIND02.NTX", "&GDir\ROMIND03.NTX"    
  #endif
 
  DBSelectAr( _COD_PRODNF ) 
  DBSetOrder( 5 ) 
  DBSeek( NF_->NUMERO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Imprime [ESC]Cancela") 
 
  SetColor( _COR_BROWSE ) 
  oTB:=tbrowsedb( 09, 01, 14, 78 ) 
  oTB:addcolumn(tbcolumnnew(,{|| IF( NF_->NUMERO == PNF->CODNF_, TRAN( CODIGO, "@R 999-9999" ) + " " + DESCRI + " " + LEFT( ORIGEM, 3 ) + " " + UNIDAD + TRAN( QUANT_, "@E 999,999.999" ) + " NF" + STRZERO( CODNF_, 08, 00 ) + Space( 10 ), Space( 80 ) ) })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  whil .t. 
     oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
 
     /* Display do Romaneio */ 
     DispBegin() 
     SetColor( _COR_GET_EDICAO ) 
     DBSelectAr( _COD_ROMANEIO ) 
     DBSeek( PNF->CODIGO ) 
     Scroll( 01, 01, 07, 78 ) 
     nLin:= 2 
     nCol:= 2 
     WHILE ROM->CODPRO == PNF->CODIGO .AND.; 
           ROM->CODNF_ == PNF->CODNF_ 
         @ nLin, nCol Say ROM->ROMANE + "  " + DTOC( DATENT ) 
         nCol:= nCol + 25 
         IF nCol >= 60 
            nCol:= 2 
            nLin:= nLin + 1 
            IF nLin > 6 
               Exit 
            ENDIF 
         ENDIF 
         DBSkip() 
         IF ROM->( EOF() ) 
            Exit 
         ENDIF 
     ENDDO 
     SetColor( _COR_BROWSE ) 
     DispEnd() 
     DBSelectAr( _COD_PRODNF ) 
 
     nTecla:=inkey(0) 
     if nTecla=K_ESC 
        exit 
     endif 
     do case 
        case nTecla==K_UP 
             oTb:Up() 
        case nTecla==K_DOWN 
             oTb:Down() 
        case nTecla==K_PGUP       ;oTB:pageup() 
        case nTecla==K_PGDN       ;oTB:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
        case nTecla==K_INS 
             SetCursor( 1 ) 
             DBSelectAr( _COD_ROMANEIO ) 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             dDataEntrada:= Date() 
             cRomaneio:= Space( LEN( ROMANE ) ) 
             VPBOX( 09, 09, 12, 50, " INCLUSAO DE N� NO ROMANEIO ", _COR_GET_BOX ) 
             SetColor( _COR_GET_EDICAO ) 
             @ 10, 10 Say "Numero de Serie:" Get cRomaneio when mensagem( "Digite o numero de serie." ) 
             @ 11, 10 Say "Data de Entrada:" Get dDataEntrada When mensagem( "Digite a data de entrada." ) 
             READ 
             DBAppend() 
             Replace CODPRO With PNF->CODIGO,; 
                     CODNF_ With PNF->CODNF_,; 
                     DATENT With dDataEntrada,; 
                     ROMANE With cRomaneio 
             DBSelectAr( _COD_PRODNF ) 
             SetColor( _COR_BROWSE ) 
             ScreenRest( cTelaRes ) 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
             SetCursor( 0 ) 
        case nTecla == K_ENTER .OR. Chr( nTecla ) $ "0123456789" 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             lConfirma:= Set( _SET_CONFIRM, .T. ) 
             IF !NF_->NUMERO == CODNF_ 
                Aviso( "Este produto nao pertence a nota selecionada!" ) 
                Pausa() 
             ELSE 
                SetColor( _COR_GET_EDICAO ) 
                SetCursor( 1 ) 
                /* ABRE A QUANTIDADE DE APPENDS NECESSARIAS */ 
                DBSelectAr( _COD_ROMANEIO ) 
                DBSeek( PNF->CODIGO ) 
                nQuantidade:= 0 
                WHILE ROM->CODPRO == PNF->CODIGO 
                    ++nQuantidade 
                    DBSKIP() 
                    IF ROM->( EOF() ) 
                       EXIT 
                    ENDIF 
                ENDDO 
                nQuantidade:= PNF->QUANT_ - nQuantidade 
                FOR nCt:= 1 TO nQuantidade 
                    DBAppend() 
                    IF netrlock() 
                       Replace CODPRO With PNF->CODIGO,; 
                               CODNF_ With PNF->CODNF_ 
                    ENDIF 
                NEXT 
                /* FIM DA ABERTURA DE APPENDS */ 
 
                DBSelectAr( _COD_ROMANEIO ) 
                DBGoTop() 
                DBSeek( PNF->CODIGO ) 
                nLin:= 2 
                nCol:= 2 
                WHILE ROM->CODPRO == PNF->CODIGO 
                    cRomaneio:= ROM->ROMANE 
                    @ nLin, nCol-1 Get cRomaneio Pict "@S35" when mensagem( "Digite o numero de serie." ) 
                    READ 
                    IF LastKey() == K_ESC 
                       Exit 
                    ENDIF 
                    nCol:= nCol + 25 
                    IF nCol >= 60 
                       nCol:= 2 
                       nLin:= nLin + 1 
                       IF nLin > 6 
                          Scroll( 01, 01, 07, 78 ) 
                          nLin:= 2 
                       ENDIF 
                    ENDIF 
                    IF ROM->( netrlock() ) 
                       Replace ROMANE With cRomaneio 
                    ENDIF 
                    DBSkip() 
                ENDDO 
             ENDIF 
             SetColor( _COR_BROWSE ) 
             DBSelectAr( _COD_PRODNF ) 
             Set( _SET_CONFIRM, lConfirma ) 
             SetCursor( 0 ) 
             ScreenRest( cTelaRes ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTB:refreshcurrent() 
   oTB:stabilize() 
enddo 
 
dbSelectAr( _COD_ROMANEIO ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"    
#else 
  Set Index To "&GDir\ROMIND01.NTX", "&GDir\ROMIND02.NTX", "&GDir\ROMIND03.NTX"    
#endif
 
dbSelectAr( _COD_PRODNF ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/pnfind01.ntx", "&gdir/pnfind02.ntx", "&gdir/pnfind03.ntx", "&gdir/pnfind04.ntx", "&gdir/pnfind05.ntx"      
#else 
  Set Index To "&GDir\PNFIND01.NTX", "&GDir\PNFIND02.NTX", "&GDir\PNFIND03.NTX", "&GDir\PNFIND04.NTX", "&GDir\PNFIND05.NTX"      
#endif
 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � DISPLAYROMANEIO 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function DisplayRomaneio() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cCorProduto:= "15/09" , nLin, nCol 
   SetColor( _COR_GET_EDICAO ) 
   Scroll( 1, 1, 15, 78 ) 
   nLin:= 1 
   nCol:= 7 
   DBSelectAr( _COD_PRODNF )        /* Seleciona produtos p/ Nf */ 
   DBSetOrder( 5 )                  /* Ordem de Numero de Nota Fiscal */ 
   DBSeek( NF_->NUMERO )            /* Procura o numero da nf */ 
   DBSelectAr( _COD_ROMANEIO ) 
   DBSetOrder( 3 )                  /* Ordem de Numero Nf */ 
   DBSeek( NF_->NUMERO ) 
   nLin:= 0 
   WHILE PNF->CODNF_ == NF_->NUMERO 
       SetColor( cCorProduto ) 
       @ nLin+=2, 02 Say " " + Tran( PNF->CODIGO, "@R 999-9999" ) + " " + Left( PNF->DESCRI, 45 ) + " " + PNF->UNIDAD + " " + StrZero( PNF->TABPRE, 3, 0 ) + " " + Tran( PNF->QUANT_, "@E 999,999.999" ) 
       IF nLin > 12 
          EXIT 
       ENDIF 
       SetColor( _COR_GET_BOX ) 
       PNF->( DBSkip() ) 
   ENDDO 
   DBSelectAr( _COD_NFISCAL ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
