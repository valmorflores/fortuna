// ## CL2HB.EXE - Converted
 
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � Composicao 
� Finalidade  � Tela de Composicao de Produtos 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function Composicao() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTb,nClasse,nTamCod,nCorCod,cTemCor,nTamQua,cArq 
 
//fDepur( "FOR_DEP.TXT", REPL( "�", 60 ), .T. ) 
//fDepur( "FOR_DEP.TXT", "OK 5 EAN->SALDO_ = [" + STR( EAN->SALDO_, 6, 3 ) + "]" ) 
//fDepur( "FOR_DEP.TXT", "OK M.PRG" + REPL( "� ", 30 ) ) 
 
/* origem */ 
DBSelectAr( _COD_ORIGEM ) 
DBSetOrder( 3 ) 
 
/* cad. materia-prima */ 
DBSelectAr( _COD_MPRIMA ) 
Set Relation To ORIGEM Into ORG, TABRED Into RED 
 
Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
 
/* Apresentacao em tela */ 
VPBox( 0, 0, 18, 79, " COMPOSICAO DE PRODUTOS ", _COR_GET_BOX ) 
VPBox( 18, 0, 22, 79, , _COR_BROW_BOX, .F., .F. ) 
SetColor( _COR_BROWSE ) 
DBLeOrdem() 
oTB:=TBrowsedb( 19, 01, 21, 78 ) 
oTB:addcolumn( tbcolumnnew( , {|| IF( MPR->MPRIMA=="S", " ", "!" ) + Tran( Codigo, '@R XXX-XXXX' )+'  '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 )  } ) ) 
oTB:AUTOLITE:=.f. 
oTB:dehilite() 
whil .t. 
   oTB:colorrect( {oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1} ) 
   whil nextkey()=0 .and.! oTB:stabilize() 
   enddo 
   SetColor( _COR_GET_EDICAO ) 
   @ 01, 02 Say "Codigo..............: ["+Tran( INDICE, "@R 999-9999" ) + "]" 
   @ 02, 02 Say "Cod.Fabrica.........: ["+CODFAB+"]" 
   @ 03, 02 Say "Descricao...........: ["+DESCRI+"]" 
   @ 04, 02 Say "Unidade.............: ["+UNIDAD+"]" 
   @ 05, 02 Say "Fabricante..........: ["+ORIGEM+"]" 
   @ 06, 02 Say "Medida Unitaria.....: [" + Tran( QTDPES, "@E 999,999.9999" )+"]" 
   @ 07, 02 Say "Preco venda.........: [" + Tran( PRECOV, "@E 999,999,999.999" )+"]" 
   @ 08, 02 Say "Classificacao fiscal: [" + Tran( CLAFIS, "999" )+"]" 
   @ 09, 02 Say "Cod.Sit.Tributaria A: [" + Tran( SITT01, "9" )+"]" 
   @ 10, 02 Say "Cod.Sit.Tributaria B: [" + Tran( SITT02, "99" )+"]" 
   @ 11, 02 Say "Estoque minimo......: [" + Tran( ESTMIN, "@E 999,999.999" )+"]" 
   @ 12, 02 Say "Estoque maximo......: [" + Tran( ESTMAX, "@E 999,999.999" )+"]" 
   @ 13, 02 Say "% p/ calculo do IPI.: [" + Tran( IPI___, "999.99" )+"]" 
   @ 14, 02 Say "% p/ calculo do ICMs: [" + Tran( ICM___, "999.99" )+"]" 
   @ 15, 02 Say "Classe..............: [" + Tran( PCPCLA, "999" )+"]" 
   @ 16, 02 Say "Selecao de Cor......: [" + IIF ( EMPTY( PCPCSN ) == .T., "N", ; 
      PCPCSN ) + "]" 
   SetColor( _COR_BROW_BOX ) 
   nTecla:=inkey( 0 ) 
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
 
      case DBPesquisa( nTecla, oTb ) 
 
      case nTecla==K_F3         ;DBMudaOrdem( 2, oTB ) 
 
      case nTecla==K_F4         ;DBMudaOrdem( 3, oTB ) 
 
      case nTecla==K_F2         ;DBMudaOrdem( 1, oTB ) 
 
      case nTecla==K_ENTER      ;MontAlteracao( oTb ) 
 
      case nTecla==K_INS        ;MontInclusao( oTb ) 
 
      case nTecla==K_DEL 
           cCodigo:= MPR->INDICE 
           /* Exclusao de Produto Montado */ 
           IF !MPRIMA == "N" 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Este nao e' um produto montado!", 12 ) 
              Mensagem( "Pressione [ENTER] para retornar." ) 
              Pausa() 
              ScreenRest( cTelaRes ) 
           ELSEIF Exclui( oTb ) 
              DBSelectAr( _COD_ASSEMBLER ) 
              DBSeek( cCodigo ) 
              WHILE CODPRD == cCodigo 
                  IF netrlock() 
                     Dele 
                  ENDIF 
                  DBSkip() 
              ENDDO 
              DBUnlockAll() 
              DBSelectAr( _COD_MPRIMA ) 
           ENDIF 
 
      otherwise                 ;tone( 125 ); tone( 300 ) 
 
   endcase 
 
   oTB:refreshcurrent() 
   oTB:stabilize() 
 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � MontInclusao 
� Finalidade  � Montagem de Produto 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Abril-98 
��������������� 
*/ 
Function MontInclusao( oOldTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local aMenuOpcao, nOpcao, aSelecionados, nRow:= 1, nRow1:= 1 
Local cCodFabrica, cDescricao, cUnidade, cFabricante, aProRel 
Local aCorTamQua:= { { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } } 
Local nSITT01, nSitT02 
aProRel:= 0 
aProRel:= {} 
SetBlink( .F. ) 
SetColor( _COR_BROW_TITULO ) 
@ 00,00 SAY "��                     FICHA DE COMPOSICAO DE PRODUTOS                         " 
SetColor( _COR_BROW_BOX ) 
@ 01,00 Say "��������������������������������������������������������������������������������" 
@ 02,00 Say "� Produto Final                                                                �" 
@ 03,00 Say "�                                                                              �" 
@ 04,00 Say "�                                                                              �" 
@ 05,00 Say "��������������������������������������������������������������������������������" 
@ 06,00 Say "�Mat�ria-Prima Dispon�vel                � Fechamento de Custo e Preco Final   �" 
@ 07,00 Say "��������������������������������������������������������������������������������" 
@ 08,00 Say "�                                        � Preco de Custo �      �             �" 
@ 09,00 Say "�                                        � Margem de Lucro�      �             �" 
@ 10,00 Say "�                                        � Mao-de-Obra    �      �             �" 
@ 11,00 Say "�                                        � Valor Total    �      �             �" 
@ 12,00 Say "�                                        � Valor Usuario  �      �             �" 
@ 13,00 Say "�                                        � Valor de Venda �      �             �" 
@ 14,00 Say "��������������������������������������������������������������������������������" 
@ 15,00 Say "�Mat�ria-Prima Selecionada               � Un� Quant. � Custo    � Total       �" 
@ 16,00 Say "��������������������������������������������������������������������������������" 
@ 17,00 Say "�                                        �   �        �          �             �" 
@ 18,00 Say "�                                        �   �        �          �             �" 
@ 19,00 Say "�                                        �   �        �          �             �" 
@ 20,00 Say "�                                        �   �        �          �             �" 
@ 21,00 Say "�                                        �   �        �          �             �" 
@ 22,00 Say "��������������������������������������������������������������������������������" 
@ 24,00 say space( 0 ) 
cCodFabrica:= Space( 13 ) 
cDescricao:= Space( 40 ) 
cUnidade:= Space( 2 ) 
cFabricante:= Space( 3 ) 
Mensagem( "Digite as informacoes iniciais ref. cadastro." ) 
SetColor( _COR_BROW_BOX ) 
@ 03,02 Say "Codigo Fabrica:" Get cCodFabrica 
@ 04,02 Say "Descricao.....:" Get cDescricao 
@ 03,62 Say "Unidade:" Get cUnidade 
@ 04,62 Say "Fabrica:" Get cFabricante 
READ 
IF LastKey() == K_ESC 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return( .T. ) 
ENDIF 
 
nOpcao:= 1 
aCustos:= { { "Preco de Custo ", 0, 0 },; 
            { "Margem de Lucro", 0, 0 },; 
            { "Mao-de-Obra    ", 0, 0 },; 
            { "Valor Sugerido ", 0, 0 },; 
            { "Valor Usuario  ", 0, 0 },; 
            { "Valor Venda    ", 0, 0 } } 
 
aSelecionados:= { { Space( 13 ), Space( 40 ), Space( 2 ), 0, 0, 0, 0, SPACE( 12 ), 0, 0, 0, 0 },; 
                  { Space( 13 ), Space( 40 ), Space( 2 ), 0, 0, 0, 0, SPACE( 12 ), 0, 0, 0, 0 },; 
                  { Space( 13 ), Space( 40 ), Space( 2 ), 0, 0, 0, 0, SPACE( 12 ), 0, 0, 0, 0 },; 
                  { Space( 13 ), Space( 40 ), Space( 2 ), 0, 0, 0, 0, SPACE( 12 ), 0, 0, 0, 0 },; 
                  { Space( 13 ), Space( 40 ), Space( 2 ), 0, 0, 0, 0, SPACE( 12 ), 0, 0, 0, 0 },; 
                  { Space( 13 ), Space( 40 ), Space( 2 ), 0, 0, 0, 0, SPACE( 12 ), 0, 0, 0, 0 } } 
 
aMenuOpcao:= { { "�Mat�ria-Prima dispon�vel                �", 06,00 },; 
               { "�Mat�ria-Prima Selecionada               � Un� Quant. � Custo    � Total       �", 15,00 },; 
               { " Fechamento de Custo e Preco Final   �",  06,42 } } 
 
/* Display( Ajuda ) */ 
Mensagem( "[TAB]Janela [F2]Codigo [F3]CdFab [F4]Descricao [A..Z]Pesquisar [G]Gravar" ) 
Ajuda( "[PgDn][PgUp][" + _SETAS + "]Movimenta [ESC]Finaliza" ) 
SetColor( _COR_BROWSE ) 
 
DBSelectAr( _COD_MPRIMA ) 
oTb2:= TBrowseNew( 17, 01, 21, 78 ) 
oTb2:addcolumn( tbcolumnnew( ,{|| aSelecionados[nRow][1] + " " +; 
                                LEFT( aSelecionados[nRow][2], 26 ) + "� " +; 
                                aSelecionados[nRow][3] + "�" +; 
                          Tran( aSelecionados[nRow][4], "@E 9,999.99" ) + "�" +; 
                          Tran( aSelecionados[nRow][5], "@E 9,999.9999" ) + "�" +; 
                          Tran( aSelecionados[nRow][6], "@E 9999,999.9999" ) } ) ) 
oTb2:AUTOLITE:=.f. 
oTb2:dehilite() 
oTb2:GoTopBlock:= {|| nRow:=1 } 
oTb2:GoBottomBlock:= {|| nRow:= Len( aSelecionados ) } 
oTb2:SkipBlock:= {|x| SkipperArr( x, aSelecionados, @nRow ) } 
 
oTb3:= TBrowseNew( 08, 43, 13, 78 ) 
oTb3:addcolumn( tbcolumnnew( ,{|| aCustos[nRow1][1] + "�" +; 
                          Tran( aCustos[nRow1][2], "@E 999.99" ) + "�" +; 
                          Tran( aCustos[nRow1][3], "@E 9999,999.9999" ) } ) ) 
oTb3:AUTOLITE:=.f. 
oTb3:dehilite() 
oTb3:GoTopBlock:= {|| nRow1:=1 } 
oTb3:GoBottomBlock:= {|| nRow1:= Len( aCustos ) } 
oTb3:SkipBlock:= {|x| SkipperArr( x, aCustos, @nRow1 ) } 
 
DBLeOrdem() 
 
oTb2:RefreshAll() 
WHILE !oTb2:Stabilize() 
ENDDO 
 
oTb3:RefreshAll() 
WHILE !oTb3:Stabilize() 
ENDDO 
oTb:= TBrowseDB( 08, 01, 13, 40 ) 
oTb:addcolumn( tbcolumnnew( ,{|| CODFAB + " " + DESCRI } ) ) 
oTb:AUTOLITE:=.f. 
oTb:dehilite() 
whil .t. 
   SetCursor( 0 ) 
   oTb:RefreshCurrent() 
   WHILE !oTb:Stabilize() 
   ENDDO 
   @ 03,02 Say DESCRI 
   SetCursor( 1 ) 
   MenuSelect( nOpcao, aMenuOpcao ) 
   DO CASE 
      CASE nOpcao == 1 
           oTb:colorrect( {oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1} ) 
           While nextkey()==0 .and. ! oTb:stabilize() 
           EndDo 
      CASE nOpcao == 2 
           oTb2:colorrect( {oTb2:ROWPOS,1,oTb2:ROWPOS,1},{2,1} ) 
           While nextkey()==0 .and. ! oTb2:stabilize() 
           EndDo 
     CASE nOpcao == 3 
           oTb3:colorrect( {oTb3:ROWPOS,1,oTb3:ROWPOS,1},{2,1} ) 
           While nextkey()==0 .and. ! oTb3:stabilize() 
           EndDo 
 
   ENDCASE 
 
   nTecla:= InKey( 0 ) 
   IF Chr( nTecla ) $ "Gg" .AND. nOpcao == 3 
      cCorRes:= SetColor() 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      nQTDPES:= 1 
      nPRECOV:= aCustos[ 6 ][ 3 ] 
      nICMCOD:= 0 
      nIPICOD:= 0 
 
      //// Situacao tributaria (A/B) 
      nSitT01:= 0 
      nSitT02:= 0 
 
      nCLAFIS:= 0 
      nESTMIN:= 0 
      nESTMAX:= 0 
      nIPI___:= 0 
      cGrupo_:= Space( 3 ) 
      cCodigo:= Space( 4 ) 
      nICM___:= 0 
      nClaMPR:= 0 
      cTemCor:= "N" 
      VPBox( 04, 05, 21, 77, " Gravacao do Produto Final ", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 05, 07 Say "Codigo..............:" Get cGrupo_ Pict "999" Valid Grupo( @cGrupo_, @cCodigo ) 
      @ 05, 34 Say "-" 
      @ 05, 35 Get cCodigo Pict "9999" Valid Codigo( @cCodigo, GetList )                       when mensagem( "Digite o codigo para produto ou [ENTER] ara continuar." ) 
      @ 06, 07 Say "Codigo Fabrica......:" Get cCodFabrica 
      @ 07, 07 Say "Descricao...........:" Get cDescricao 
      @ 08, 07 Say "Unidade.............:" Get cUnidade 
      @ 09, 07 Say "Fabricante..........:" Get cFabricante 
      @ 10, 07 Say "Medida Unitaria.....:" Get nQTDPES pict "@E 999,999.9999" when mensagem( "Digite o peso, tamanho ou quantidade de pecas do produto." ) 
      @ 11, 07 Say "Preco venda.........:" Get nPRECOV pict "@E 999,999,999.999" when Mensagem( "Digite o preco de venda do produto." ) 
      @ 12, 07 Say "Classificacao fiscal:" Get nCLAFIS pict "999" valid verclasse( @nCLAFIS ) when Mensagem( "Digite o codigo de classificacao fiscal do produto." ) 
      @ 13, 07 Say "Cod.Sit.Tributaria A:" Get nSITT01 pict "9" valid classtrib( @nSITT01,1 ) when Mensagem( "Digite o codigo tributavel do produto para ICMs." ) 
      @ 14, 07 Say "Cod.Sit.Tributaria B:" Get nSITT02 pict "99" valid classtrib( @nSITT02,2 ) when Mensagem( "Digite o codigo de tributacao do IPI." ) 
      @ 15, 07 Say "Estoque minimo......:" Get nESTMIN pict "@E 999,999.999" When Mensagem( "Digite a quantidade permitida para estoque minimo." ) 
      @ 16, 07 Say "Estoque maximo......:" Get nESTMAX pict "@E 999,999.999" When Mensagem( "Digite a quantidade valida para estoque maximo." ) 
      @ 17, 07 Say "% p/ calculo do IPI.:" Get nIPI___ pict "999.99" when Mensagem( "Digite o percentual para calculo do IPI." ) 
      @ 18, 07 Say "% p/ calculo do ICMs:" Get nICM___ pict "999.99" when Mensagem( "Digite o percentual para calculo do ICMs." ) 
      @ 19, 07 Say "Classe..............:" Get nClaMPR pict "999" when ; 
         Mensagem( "Digite a Classe do Item." ) VALID IIF ( EMPTY( nClaMPR ) == ; 
         .T., fVerClasse( @nClaMPR ), .T. ) 
      @ 20, 07 Say "Selecao de Cor......:" Get cTemCor 
      READ 
      cCodigo:= PAD( cGrupo_ + cCodigo, 12 ) 
      IF ! LastKey() == K_ESC 
         IF Confirma( 0, 0, "Confirma Gravacao?", "Digite [S] para confirmar a gravacao.", "S" ) 
            DBAppend() 
            Replace INDICE With cCodigo,; 
                    CODIGO With cCodigo,; 
                    CODRED With RIGHT( ALLTRIM( cCodigo ), 4 ),; 
                    DESCRI With cDescricao,; 
                    CODFAB With cCodFabrica,; 
                    UNIDAD With cUnidade,; 
                    ORIGEM With cFabricante,; 
                    IPI___ With nIPI___,; 
                    ICM___ With nICM___,; 
                    PCPCLA With nClaMPR,; 
                    PCPCSN With cTemCor,; 
                    ICMCOD With nIcmCod,; 
                    IPICOD With nIPICod,; 
                    ESTMIN With nEstMin,; 
                    ESTMAX With nEstMax,; 
                    PRECOV With nPrecov,; 
                    CLAFIS With nClaFis,; 
                    QTDPES With nQtdPes,; 
                    PERCPV With aCustos[ 2 ][ 2 ],; 
                    MOBRAP With aCustos[ 3 ][ 2 ],; 
                    MOBRAV With aCustos[ 3 ][ 3 ],; 
                    MPRIMA With "N",; 
                    SITT01 With nSitT01,; 
                    SITT02 With nSitt02 
            dbSelectAr( _COD_ASSEMBLER ) 
            FOR nCt:= 1 TO Len( aSelecionados ) 
                IF !Empty( aSelecionados[ nCt ][ 1 ] ) .OR.; 
                   !Empty( aSelecionados[ nCt ][ 2 ] ) 
                   DBAppend() 
                   Replace CODPRD With cCodigo,; 
                           CODMPR With aSelecionados[ nCt ][  8 ],; 
                           QUANT_ With aSelecionados[ nCt ][  4 ],; 
                           DESCRI With aSelecionados[ nCt ][  2 ],; 
                           UNIDAD With aSelecionados[ nCt ][  3 ],; 
                           CODFAB With aSelecionados[ nCt ][  1 ],; 
                           CUSUNI With aSelecionados[ nCt ][  5 ],; 
                           CUSTOT With aSelecionados[ nCt ][  6 ],; 
                           PERIPI With aSelecionados[ nCt ][  7 ],; 
                           PCPCLA With aSelecionados[ nCt ][  9 ],; 
                           PCPTAM With aSelecionados[ nCt ][ 10 ],; 
                           PCPCOR With aSelecionados[ nCt ][ 11 ],; 
                           PCPQUA With aSelecionados[ nCt ][ 12 ] 
                ENDIF 
            NEXT 
            dbSelectAr( _COD_PRECOXFORN ) 
            IF BuscaNet( 5, {|| DBAppend(), !NetErr() } ) 
               Replace CPROD_ With cCodigo,; 
                       CODFOR With 0,; 
                       VALOR_ With nPrecov 
            ENDIF 
            dbSelectAr( _COD_MPRIMA ) 
         ENDIF 
      ENDIF 
      MoedaProduto() 
      nTecla:= 0 
      SetColor( cCorRes ) 
      ScreenRest( cTelaRes ) 
      IF !LastKey() == K_ESC 
         Keyboard Chr( K_ESC ) 
      ENDIF 
   ENDIF 
 
   DO CASE 
      CASE nTecla == K_ESC 
           exit 
      CASE nTecla == K_TAB 
           ++nOpcao 
           IF nOpcao > Len( aMenuOpcao ) 
              nOpcao:= 1 
           ENDIF 
           IF nOpcao == 1 
              Mensagem( "[TAB]Janela [F2]Codigo [F3]CdFab [F4]Descricao [A..Z]Pesquisar" ) 
           ELSEIF nOpcao == 2 
              Mensagem( "[TAB]Janela [ENTER]Altera [INS]Novo [DEL]Exclui" ) 
           ELSEIF nOpcao == 3 
              Mensagem( "[TAB]Janela [G]Gravar [ENTER]Editar" ) 
           ENDIF 
 
 
      CASE nTecla == K_F12;   Calculador() 
 
      CASE nTecla == K_DEL 
           IF nOpcao == 2 
              aCustos[ 1 ][ 3 ]:= aCustos[ nRow1 ][ 3 ] - aSelecionados[ nRow ][ 6 ] 
              aSelecionados[ nRow ]:= { SPACE( 13 ),; 
                                        PAD( "             ", 40 ),; 
                                        SPACE( 2 ),; 
                                        0,; 
                                        0,; 
                                        0,; 
                                        0,; 
                                        SPACE( 12 ),; 
                                        0,; 
                                        0,; 
                                        0,; 
                                        0} 
              oTb2:RefreshCurrent() 
              WHILE !oTb2:Stabilize() 
              ENDDO 
           ENDIF 
 
      CASE DBPesquisa( nTecla, oTb ) 
 
      CASE nTecla==K_F2;    DBMudaOrdem( 1, oTb ) 
 
      CASE nTecla==K_F3;    DBMudaOrdem( 4, oTb ) 
 
      CASE nTecla==K_F4;    DBMudaOrdem( 2, oTb ) 
 
      CASE nTecla == K_INS 
           IF nOpcao == 2 
              AAdd( aSelecionados, { SPACE( 13 ),; 
                                     PAD( "             ", 40 ),; 
                                     SPACE( 2 ),; 
                                     0,; 
                                     0,; 
                                     0,; 
                                     0,; 
                                     SPACE( 12 ),; 
                                     0,; 
                                     0,; 
                                     0,; 
                                     0} ) 
              oTb2:Down() 
              oTb2:RefreshAll() 
              WHILE !oTb2:Stabilize() 
              ENDDO 
           ENDIF 
 
      CASE nTecla == K_ENTER 
           IF nOpcao == 3 
              IF nRow1 == 2         /* Margem de Lucro */ 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 nMargem:= aCustos[ 2 ][ 2 ] 
                 VPBox( 06, 41, 10, 77, "Margem de Lucro", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 08,45 Say "% Margem.:" Get nMargem Pict "@E 99999.99" 
                 READ 
                 aCustos[ 2 ][ 2 ]:= nMargem 
                 aCustos[ 2 ][ 3 ]:=( aCustos[ 1 ][ 3 ] * nMargem ) / 100 
                 aCustos[ 4 ][ 3 ]:= aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] + aCustos[ 3 ][ 3 ] 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 oTb3:RefreshAll() 
                 WHILE !oTb3:Stabilize() 
                 ENDDO 
             ELSEIF nRow1 == 3 
                 lMudaPv:= IF ( aCustos[ 5 ][ 3 ] == aCustos[ 4 ][ 3 ], .T., .F. ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 nMObra:= aCustos[ 3 ][ 2 ] 
                 nValorMObra:= aCustos[ 3 ][ 3 ] 
                 VPBox( 06, 41, 11, 77, "Mao de Obra", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 08,43 Say "Mao-de-Obra.:" Get nMObra      Pict "@E 999.99" 
                 @ 09,43 Say "Valor M.Obra:" Get nValorMObra Pict "@E 9,999,999.99" 
                 READ 
                 nFator:=( ( 100 - nMObra ) / 100 ) 
                 aCustos[ 3 ][ 2 ]:= nMObra 
                 IF nMObra <> 0 
                    aCustos[ 3 ][ 3 ]:=( ( aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] ) / nFator ) -; 
                       ( aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] ) 
                 ELSE 
                    aCustos[ 3 ][ 3 ]:= nValorMObra 
                 ENDIF 
                 aCustos[ 4 ][ 3 ]:= aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] + aCustos[ 3 ][ 3 ] 
                 aCustos[ 5 ][ 3 ]:= IF ( aCustos[ 5 ][ 3 ] == 0, aCustos[ 4 ][ 3 ], aCustos[ 5 ][ 3 ] ) 
                 aCustos[ 6 ][ 3 ]:= IF ( lMudaPV, aCustos[ 4 ][ 3 ], aCustos[ 5 ][ 3 ] ) 
 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 oTb3:RefreshAll() 
                 WHILE !oTb3:Stabilize() 
                 ENDDO 
              ELSEIF nRow1 == 5 
                 lMudaPv:= .F. 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 nValorUsuario:= aCustos[ 5 ][ 3 ] 
                 VPBox( 06, 41, 11, 77, "Preco definido", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 09,43 Say "Valor.......:" Get nValorUsuario Pict "@E 9,999,999.99" 
                 READ 
 
                 IF nValorUsuario == 0 
                    aCustos[ 5 ][ 3 ]:= aCustos[ 4 ][ 3 ] 
                    aCustos[ 6 ][ 3 ]:= aCustos[ 5 ][ 3 ] 
                 ENDIF 
 
                 IF LastKey() <> K_ESC .AND. nValorUsuario > 0 
                    aCustos[ 5 ][ 3 ]:= nValorUsuario 
                    aCustos[ 6 ][ 3 ]:= aCustos[ 5 ][ 3 ] 
                 ENDIF 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 oTb3:RefreshAll() 
                 WHILE !oTb3:Stabilize() 
                 ENDDO 
              ENDIF 
 
           ELSEIF nOpcao == 1 .OR. nOpcao == 2 
              cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
              IF ( nPosicao:= AScan( aSelecionados,; 
                            {|x| x[1] == PAD( CODFAB, 13 ) .AND.; 
                                 x[2] == DESCRI } ) ) > 0 .OR. nOpcao == 2 
                 /* Se estiver na janela de selecionados a posicao 
                    sera == nRow, pois � o registro que esta sendo editado */ 
                 IF nOpcao == 2 
                    nPosicao:= nRow 
                 ENDIF 
                 cCodFab:= aSelecionados[ nPosicao ][ 1 ] 
                 cDescri:= aSelecionados[ nPosicao ][ 2 ] 
                 nCustoUnitario:= aSelecionados[ nPosicao ][ 5 ] 
                 cUnidad:= aSelecionados[ nPosicao ][ 3 ] 
                 nQuantidade:= aSelecionados[ nPosicao ][ 4 ] 
                 nCustoAnterior:= nCustoUnitario * nQuantidade 
                 nPerIpi:= aSelecionados[ nPosicao ][ 7 ] 
                 cIndice:= aSelecionados[ nPosicao ][ 8 ] 
                 nClasse:= aSelecionados[ nPosicao ][ 9 ] 
                 nTamCod:= aSelecionados[ nPosicao ][ 10 ] 
                 nCorCod:= aSelecionados[ nPosicao ][ 11 ] 
                 nTamQua:= aSelecionados[ nPosicao ][ 12 ] 
                 cArq:= "ASM" 
                 cTemCor:= IIF ( nCorCod > 0, "S", "N" ) 
              ELSE 
                 IF PXF->( DBSeek( MPR->INDICE ) ) 
                    nCustoUnitario:= PXF->VALOR_ 
                 ELSE 
                    nCustoUnitario:= MPR->PRECOV 
                 ENDIF 
                 cCodFab:= PAD( CODFAB, 13 ) 
                 cDescri:= DESCRI 
                 cUnidad:= UNIDAD 
                 cIndice:= INDICE 
                 nQuantidade:= 1 
                 nPerIpi:= IPI___ 
                 nPosicao:= 0 
                 // Materia Prima 
                 nClasse:= PCPCLA 
                 nTamCod:= PCPTAM 
                 cTemCor:= IIF ( PCPCSN == "S", "S", "N" ) 
                 nCorCod:= 0 
                 nTamQua:= 0 
                 cArq:= "MPR" 
              ENDIF 
 
              cClasse:= SPACE( 40 ) 
              cTamanho:= SPACE( 10 ) 
              cCorDes:= SPACE( 30 ) 
 
              fAcessaTamCor( nClasse, nTamCod, nCorCod, @cClasse, ; 
                             @cTamanho, @cCorDes, cTemCor ) 
 
              VPBox( 7, 10, 18, 75, " Edicao de Produtos ", _COR_GET_BOX ) 
              @  8,11 Say "Codigo Fabrica...:" Get cCodFab 
              @  9,11 Say "Descricao........:" Get cDescri        Pict "@S40" 
              @ 10,11 Say "Unidade..........:" Get cUnidad 
              @ 11,11 Say "% IPI............:" Get nPerIpi        Pict "@E 999.99" 
              @ 12,11 Say "Custo Unitario...:" Get nCustoUnitario Pict "@E 999,999.9999" 
              @ 13,11 Say "Quantidade.......:" Get nQuantidade    Pict "@E 999,999.9999" ; 
                 WHEN nClasse == 0 
              @ 14,11 Say REPL( "�", 64 ) 
              @ 15,11 Say "Classe ..........: [" + cClasse  + "]" 
              @ 16,11 Say "Cor .............: [" + cCorDes  + "]" 
              @ 17,11 Say "Tamanho .........: [" + cTamanho + "]" 
              READ 
              IF ! LastKey() == K_ESC 
 
                 fSelecTamCor( nClasse, @nTamCod, @nCorCod, @nTamQua, cArq, ; 
                    @nQuantidade, cTemCor, @aCorTamQua ) 
                 nCustoTotal:= nCustoUnitario * nQuantidade 
                 IF nPosicao > 0 
                    aSelecionados[ nPosicao ]:= { cCodFab,; 
                                                  cDescri,; 
                                                  cUnidad,; 
                                                  nQuantidade,; 
                                                  nCustoUnitario,; 
                                                  nCustoTotal,; 
                                                  nPerIpi,; 
                                                  cIndice,; 
                                                  nClasse,; 
                                                  nTamCod,; 
                                                  nCorCod,; 
                                                  nTamQua} 
                    aCustos[ 1 ][ 3 ]:= aCustos[ 1 ][ 3 ] -( nCustoAnterior ) + nCustoTotal 
                 ELSE 
                     /* Procura em branco */ 
                     nPosicao:= ASCAN( aSelecionados, {|x| Empty( x[1] ) .AND. Empty( x[2] ) } ) 
                     IF nPosicao == 0 
                        AAdd( aSelecionados, { cCodFab,; 
                                            cDescri,; 
                                            cUnidad,; 
                                            nQuantidade,; 
                                            nCustoUnitario,; 
                                            nCustoTotal,; 
                                            nPerIpi,; 
                                            cIndice,; 
                                            nClasse,; 
                                            nTamCod,; 
                                            nCorCod,; 
                                            nTamQua} ) 
                     ELSE 
                        aSelecionados[ nPosicao ]:= { cCodFab,; 
                                            cDescri,; 
                                            cUnidad,; 
                                            nQuantidade,; 
                                            nCustoUnitario,; 
                                            nCustoTotal,; 
                                            nPerIpi,; 
                                            cIndice,; 
                                            nClasse,; 
                                            nTamCod,; 
                                            nCorCod,; 
                                            nTamQua} 
                     ENDIF 
                     aCustos[ 1 ][ 3 ]:= aCustos[ 1 ][ 3 ] + nCustoTotal 
                 ENDIF 
              ENDIF 
              ScreenRest( cTelaRes ) 
              IF nOpcao == 1 
                 oTb2:Down() 
                 oTb2:RefreshAll() 
                 WHILE !oTb2:Stabilize() 
                 ENDDO 
              ENDIF 
              oTb3:RefreshAll() 
              WHILE !oTb3:Stabilize() 
              ENDDO 
           ENDIF 
   ENDCASE 
   DO CASE 
      CASE nOpcao == 1 
             oTb3:RefreshAll() 
             WHILE !oTb3:Stabilize() 
             ENDDO 
             Movimento( nTecla, nOpcao, oTb ) 
      CASE nOpcao == 2 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
             Movimento( nTecla, nOpcao, oTb2 ) 
      CASE nOpcao == 3 
             oTb2:RefreshAll() 
             WHILE !oTb2:Stabilize() 
             ENDDO 
             Movimento( nTecla, nOpcao, oTb3 ) 
   ENDCASE 
 
ENDDO 
SetCursor( 1 ) 
SetColor( cCor ) 
ScreenRest( cTela ) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
oOldTb:RefreshAll() 
WHILE !oOldTb:Stabilize() 
ENDDO 
Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � MontAlteracao 
� Finalidade  � Alteracao da Montagem de Produto 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Abril-98 
��������������� 
*/ 
Function MontAlteracao( oOldTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local aMenuOpcao, nOpcao, aSelecionados, nRow:= 1, nRow1:= 1 
Local cCodFabrica, cDescricao, cUnidade, cFabricante 
Local aTabRed, nPerRed, cTabRed, aProRel 
Local aCorTamQua:= { { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } } 
 
 
Local cCodigoProduto:= MPR->INDICE 
 
aProRel:= 0 
aProRel:= {} 
 
DBSelectAr( _COD_ASSEMBLER ) 
IF !DBSeek( MPR->INDICE ) 
   Keyboard Chr( K_RIGHT ) 
   IF nOpcao:= SWAlerta( "<<<< C O M P O S I C A O >>>>; Este produto nao possui composicao.", { "Converter", " Cancelar " } )==2 
      DBSelectAr( _COD_MPRIMA ) 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return( .T. ) 
   ELSE 
      IF MPR->( netrlock() ) 
         Replace MPR->MPRIMA With "N" 
         DBAppend() 
         Replace CODPRD With MPR->INDICE 
         DBUnlockAll() 
      ENDIF 
   ENDIF 
ENDIF 
 
 
SetBlink( .F. ) 
SetColor( _COR_BROW_TITULO ) 
@ 00,00 SAY "��                     FICHA DE COMPOSICAO DE PRODUTOS                         " 
SetColor( _COR_BROW_BOX ) 
@ 01,00 Say "��������������������������������������������������������������������������������" 
@ 02,00 Say "� Produto Final                                                                �" 
@ 03,00 Say "�                                                                              �" 
@ 04,00 Say "�                                                                              �" 
@ 05,00 Say "��������������������������������������������������������������������������������" 
@ 02,20 Say "Codigo: " + Tran( MPR->INDICE, "@R 999-9999" ) 
@ 06,00 Say "�Mat�ria-Prima Dispon�vel                � Fechamento de Custo e Preco Final   �" 
@ 07,00 Say "��������������������������������������������������������������������������������" 
@ 08,00 Say "�                                        � Preco de Custo �      �             �" 
@ 09,00 Say "�                                        � Margem de Lucro�      �             �" 
@ 10,00 Say "�                                        � Mao-de-Obra    �      �             �" 
@ 11,00 Say "�                                        � Valor Total    �      �             �" 
@ 12,00 Say "�                                        � Valor Usuario  �      �             �" 
@ 13,00 Say "�                                        � Valor de Venda �      �             �" 
@ 14,00 Say "��������������������������������������������������������������������������������" 
@ 15,00 Say "�Mat�ria-Prima Selecionada               � Un� Quant. � Custo    � Total       �" 
@ 16,00 Say "��������������������������������������������������������������������������������" 
@ 17,00 Say "�                                        �   �        �          �             �" 
@ 18,00 Say "�                                        �   �        �          �             �" 
@ 19,00 Say "�                                        �   �        �          �             �" 
@ 20,00 Say "�                                        �   �        �          �             �" 
@ 21,00 Say "�                                        �   �        �          �             �" 
@ 22,00 Say "��������������������������������������������������������������������������������" 
SetColor( _COR_BROW_BOX ) 
@ 24,00 say space( 0 ) 
nRegistro:= MPR->( recno() ) 
cCodFabrica:= MPR->CODFAB 
cDescricao:=  MPR->DESCRI 
cUnidade:=    MPR->UNIDAD 
cFabricante:= MPR->ORIGEM 
Keyboard Chr( K_PGDN ) 
@ 03,02 Say "Codigo Fabrica:" Get cCodFabrica 
@ 04,02 Say "Descricao.....:" Get cDescricao 
@ 03,62 Say "Unidade:" Get cUnidade 
@ 04,62 Say "Fabrica:" Get cFabricante 
READ 
 
nOpcao:= 1 
aCustos:= { { "Preco de Custo ", 0, 0 },; 
            { "Margem de Lucro", 0, 0 },; 
            { "Mao-de-Obra    ", 0, 0 },; 
            { "Valor Sugerido ", 0, 0 },; 
            { "Valor Usuario  ", 0, 0 },; 
            { "Valor Venda    ", 0, 0 } } 
 
aSelecionados:= 0 
aSelecionados:= {} 
WHILE MPR->INDICE == ASM->CODPRD 
   AAdd( aSelecionados, { PAD( CODFAB, 13 ), LEFT( DESCRI, 40 ), UNIDAD, ; 
      QUANT_, CUSUNI, CUSTOT, PERIPI, CODMPR, PCPCLA, PCPTAM, PCPCOR, PCPQUA } ) 
   aCustos[ 1 ][ 3 ]:= aCustos[ 1 ][ 3 ] + CUSTOT 
   DBSkip() 
ENDDO 
aCustos[ 2 ][ 2 ]:= MPR->PERCPV 
aCustos[ 3 ][ 2 ]:= MPR->MOBRAP 
aCustos[ 3 ][ 3 ]:= MPR->MOBRAV 
 
/* CALCULO DE CUSTOS */ 
nMargem:= aCustos[ 2 ][ 2 ] 
lMudaPv:= .T. 
aCustos[ 2 ][ 3 ]:=( aCustos[ 1 ][ 3 ] * nMargem ) / 100 
aCustos[ 4 ][ 3 ]:= aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] + aCustos[ 3 ][ 3 ] 
nMObra:= aCustos[ 3 ][ 2 ] 
nValorMObra:= aCustos[ 3 ][ 3 ] 
nFator:=( ( 100 - nMObra ) / 100 ) 
IF nMObra <> 0 
   aCustos[ 3 ][ 3 ]:=( ( aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] ) / nFator ) -; 
( aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] ) 
ELSE 
   aCustos[ 3 ][ 3 ]:= nValorMObra 
ENDIF 
aCustos[ 4 ][ 3 ]:= aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] + aCustos[ 3 ][ 3 ] 
aCustos[ 5 ][ 3 ]:= MPR->PRECOV 
aCustos[ 6 ][ 3 ]:= MPR->PRECOV 
//IF ( aCustos[ 5 ][ 3 ] == 0, aCustos[ 4 ][ 3 ], aCustos[ 5 ][ 3 ] ) 
//aCustos[ 6 ][ 3 ]:= IF ( lMudaPV, aCustos[ 4 ][ 3 ], aCustos[ 5 ][ 3 ] ) 
/* FIM DO CALCULO DE CUSTOS / MARGEM / M.OBRA */ 
 
aMenuOpcao:= { { "�Mat�ria-Prima dispon�vel                �", 06,00 },; 
               { "�Mat�ria-Prima Selecionada               � Un� Quant. � Custo    � Total       �", 15,00 },; 
               { " Fechamento de Custo e Preco Final   �",  06,42 } } 
 
/* Display( Ajuda ) */ 
Mensagem( "[TAB]Janela [F2]Codigo [F3]CdFab [F4]Descricao [A..Z]Pesquisar [G]Gravar" ) 
Ajuda( "[PgDn][PgUp][" + _SETAS + "]Movimenta [ESC]Finaliza" ) 
SetColor( _COR_BROWSE ) 
 
//Keyboard Chr( K_TAB ) + Chr( K_TAB ) + Chr( K_DOWN ) + Chr( K_ENTER ) + ; 
//         Chr( K_ENTER ) + Chr( K_ENTER ) + Chr( K_DOWN ) + Chr( K_ENTER ) 
 
DBSelectAr( _COD_MPRIMA ) 
oTb2:= TBrowseNew( 17, 01, 21, 78 ) 
oTb2:addcolumn( tbcolumnnew( ,{|| aSelecionados[nRow][1] + " " +; 
                                LEFT( aSelecionados[nRow][2], 26 ) + "� " +; 
                                aSelecionados[nRow][3] + "�" +; 
                          Tran( aSelecionados[nRow][4], "@E 9,999.99" ) + "�" +; 
                          Tran( aSelecionados[nRow][5], "@E 9,999.9999" ) + "�" +; 
                          Tran( aSelecionados[nRow][6], "@E 9999,999.9999" ) } ) ) 
oTb2:AUTOLITE:=.f. 
oTb2:dehilite() 
oTb2:GoTopBlock:= {|| nRow:=1 } 
oTb2:GoBottomBlock:= {|| nRow:= Len( aSelecionados ) } 
oTb2:SkipBlock:= {|x| SkipperArr( x, aSelecionados, @nRow ) } 
 
oTb3:= TBrowseNew( 08, 43, 13, 78 ) 
oTb3:addcolumn( tbcolumnnew( ,{|| aCustos[nRow1][1] + "�" +; 
                          Tran( aCustos[nRow1][2], "@E 999.99" ) + "�" +; 
                          Tran( aCustos[nRow1][3], "@E 9999,999.9999" ) } ) ) 
oTb3:AUTOLITE:=.f. 
oTb3:dehilite() 
oTb3:GoTopBlock:= {|| nRow1:=1 } 
oTb3:GoBottomBlock:= {|| nRow1:= Len( aCustos ) } 
oTb3:SkipBlock:= {|x| SkipperArr( x, aCustos, @nRow1 ) } 
 
DBLeOrdem() 
 
oTb2:RefreshAll() 
WHILE !oTb2:Stabilize() 
ENDDO 
 
oTb3:RefreshAll() 
WHILE !oTb3:Stabilize() 
ENDDO 
oTb:= TBrowseDB( 08, 01, 13, 40 ) 
oTb:addcolumn( tbcolumnnew( ,{|| CODFAB + " " + DESCRI } ) ) 
oTb:AUTOLITE:=.f. 
oTb:dehilite() 
whil .t. 
   SetCursor( 0 ) 
   oTb:RefreshCurrent() 
   WHILE !oTb:Stabilize() 
   ENDDO 
   @ 03,02 Say DESCRI 
   SetCursor( 1 ) 
 
   MenuSelect( nOpcao, aMenuOpcao ) 
   DO CASE 
      CASE nOpcao == 1 
           oTb:colorrect( {oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1} ) 
           While nextkey()==0 .and. ! oTb:stabilize() 
           EndDo 
      CASE nOpcao == 2 
           oTb2:colorrect( {oTb2:ROWPOS,1,oTb2:ROWPOS,1},{2,1} ) 
           While nextkey()==0 .and. ! oTb2:stabilize() 
           EndDo 
      CASE nOpcao == 3 
           oTb3:colorrect( {oTb3:ROWPOS,1,oTb3:ROWPOS,1},{2,1} ) 
           While nextkey()==0 .and. ! oTb3:stabilize() 
           EndDo 
 
   ENDCASE 
   nTecla:= InKey( 0 ) 
   IF Chr( nTecla ) $ "Gg" .AND. nOpcao == 3 
 
      MPR->( DBSetOrder( 1 )) 
      MPR->( DBSeek( cCodigoProduto ) ) 
 
      cCorRes:= SetColor() 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      nQTDPES:= 1 
      nPRECOV:= aCustos[ 6 ][ 3 ] 
      nICMCOD:= ICMCOD 
      nIPICOD:= IPICOD 
      nCLAFIS:= CLAFIS 
      nESTMIN:= ESTMIN 
 
      nSitT01:= SITT01 
      nSitT02:= SITT02 
 
      nESTMAX:= ESTMAX 
      nIPI___:= IPI___ 
      nICM___:= ICM___ 
      nClaMPR:= PCPCLA 
      cTemCor:= IIF ( PCPCSN == "S", "S", "N" ) 
      cGrupo_:= Left( MPR->INDICE, 3 ) 
      cMod:= "N" 
      cCodigo:= SubStr( MPR->INDICE, 4, 4 ) 
      VPBox( 04, 05, 22, 77, " Gravacao do Produto Final ", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 05, 07 Say "Codigo..............: [" + cGrupo_ + "]-[" + cCodigo + "]" 
      @ 06, 07 Say "Codigo Fabrica......:" Get cCodFabrica 
      @ 07, 07 Say "Descricao...........:" Get cDescricao 
      @ 08, 07 Say "Unidade.............:" Get cUnidade 
      @ 09, 07 Say "Fabricante..........:" Get cFabricante 
      @ 10, 07 Say "Medida Unitaria.....:" Get nQTDPES pict "@E 999,999.9999" when mensagem( "Digite o peso, tamanho ou quantidade de pecas do produto." ) 
      @ 11, 07 Say "Preco venda.........:" Get nPRECOV pict "@E 999,999,999.999" when Mensagem( "Digite o preco de venda do produto." ) 
      @ 12, 07 Say "Classificacao fiscal:" Get nCLAFIS pict "999" valid verclasse( @nCLAFIS ) when Mensagem( "Digite o codigo de classificacao fiscal do produto." ) 
      @ 13, 07 Say "Cod.Sit.Tributaria A:" Get nSITT01 pict "9" valid classtrib( @nSITT01,1 ) when Mensagem( "Digite o codigo tributavel do produto para ICMs." ) 
      @ 14, 07 Say "Cod.Sit.Tributaria B:" Get nSITT02 pict "99" valid classtrib( @nSITT02,2 ) when Mensagem( "Digite o codigo de tributacao do IPI." ) 
      @ 15, 07 Say "Estoque minimo......:" Get nESTMIN pict "@E 999,999.999" When Mensagem( "Digite a quantidade permitida para estoque minimo." ) 
      @ 16, 07 Say "Estoque maximo......:" Get nESTMAX pict "@E 999,999.999" When Mensagem( "Digite a quantidade valida para estoque maximo." ) 
      @ 17, 07 Say "% p/ calculo do IPI.:" Get nIPI___ pict "999.99" when Mensagem( "Digite o percentual para calculo do IPI." ) 
      @ 18, 07 Say "% p/ calculo do ICMs:" Get nICM___ pict "999.99" when Mensagem( "Digite o percentual para calculo do ICMs." ) 
      @ 19, 07 Say "Classe..............:" Get nClaMPR pict "999" when ; 
         Mensagem( "Digite a Classe do Item." ) VALID IIF ( EMPTY( nClaMPR ) == ; 
         .T., fVerClasse( @nClaMPR ), .T. ) 
      @ 20, 07 Say "Selecao de Cor......:" Get cTemCor 
      READ 
      //MPR->( DBGoto( nRegistro ) ) 
      cCodigo:= PAD( cGrupo_ + cCodigo, 12 ) 
      IF ! LastKey() == K_ESC 
         aTabRed:= IcmReducao( nSitT02 ) 
         nPerRed:= aTabRed[1] 
         cTabRed:= aTabRed[2] 
         IF Confirma( 0, 0, "Confirma Gravacao?", "Digite [S] para confirmar a gravacao.", "S" ) 
            DBSelectAr( _COD_MPRIMA ) 
            DBSetOrder( 1 ) 
            //DBGoTo( nRegistro ) 
            IF netrlock() 
               Repl INDICE With cCodigo,; 
                    CODIGO With cCodigo,; 
                    CODRED With SUBSTR( cCodigo, 4 ),; 
                    DESCRI With cDescricao,; 
                    CODFAB With cCodFabrica,; 
                    UNIDAD With cUnidade,; 
                    ORIGEM With cFabricante,; 
                    IPI___ With nIPI___,; 
                    ICM___ With nICM___,; 
                    PCPCLA With nClaMPR,; 
                    PCPCSN With cTemCor,; 
                    ICMCOD With nIcmCod,; 
                    IPICOD With nIPICod,; 
                    ESTMIN With nEstMin,; 
                    ESTMAX With nEstMax,; 
                    PRECOV With nPrecov,; 
                    CLAFIS With nClaFis,; 
                    QTDPES With nQtdPes,; 
                    MPRIMA With "N",; 
                    PERCPV With aCustos[ 2 ][ 2 ],; 
                    MOBRAP With aCustos[ 3 ][ 2 ],; 
                    MOBRAV With aCustos[ 3 ][ 3 ],; 
                    TABRED With cTabRed,; 
                    PERRED With nPerRed,; 
                    SITT01 With nSitT01,; 
                    SITT02 With nSitT02 
            ENDIF 
            dbSelectAr( _COD_ASSEMBLER ) 
            IF dbSeek( MPR->INDICE ) 
               WHILE MPR->INDICE == CODPRD 
                  IF netrlock() 
                     Mensagem( "Excluindo " + Alltrim( CODPRD ) + ", aguarde..." ) 
                     Dele 
                  Endif 
                  dbSkip() 
               ENDDO 
            ENDIF 
            FOR nCt:= 1 TO Len( aSelecionados ) 
                IF !Empty( aSelecionados[ nCt ][ 1 ] ) .OR.; 
                   !Empty( aSelecionados[ nCt ][ 2 ] ) 
                   DBAppend() 
                   IF netrlock() 
                      Replace CODPRD With cCodigo,; 
                              CODMPR With aSelecionados[ nCt ][  8 ],; 
                              QUANT_ With aSelecionados[ nCt ][  4 ],; 
                              DESCRI With aSelecionados[ nCt ][  2 ],; 
                              UNIDAD With aSelecionados[ nCt ][  3 ],; 
                              CODFAB With aSelecionados[ nCt ][  1 ],; 
                              CUSUNI With aSelecionados[ nCt ][  5 ],; 
                              CUSTOT With aSelecionados[ nCt ][  6 ],; 
                              PERIPI With aSelecionados[ nCt ][  7 ],; 
                              PCPCLA With aSelecionados[ nCt ][  9 ],; 
                              PCPTAM With aSelecionados[ nCt ][ 10 ],; 
                              PCPCOR With aSelecionados[ nCt ][ 11 ],; 
                              PCPQUA With aSelecionados[ nCt ][ 12 ] 
                   ENDIF 
                ENDIF 
            NEXT 
            dbSelectAr( _COD_PRECOXFORN ) 
            dbSetOrder( 1 ) 
            IF DBSeek( cCodigo ) 
               IF netrlock() 
                  Replace CPROD_ With cCodigo,; 
                          CODFOR With 0,; 
                          VALOR_ With nPrecov 
               ENDIF 
            ENDIF 
            dbSelectAr( _COD_MPRIMA ) 
            DBUnlockAll() 
         ENDIF 
      ENDIF 
      MoedaProduto() 
      nTecla:= 0 
      SetColor( cCorRes ) 
      ScreenRest( cTelaRes ) 
      IF !LastKey() == K_ESC 
         Keyboard Chr( K_ESC ) 
      ENDIF 
   ENDIF 
 
   DO CASE 
      CASE nTecla == K_ESC 
           exit 
      CASE nTecla == K_TAB 
           ++nOpcao 
           IF nOpcao > Len( aMenuOpcao ) 
              nOpcao:= 1 
           ENDIF 
           IF nOpcao == 1 
              Mensagem( "[TAB]Janela [F2]Codigo [F3]CdFab [F4]Descricao [A..Z]Pesquisar" ) 
           ELSEIF nOpcao == 2 
              Mensagem( "[TAB]Janela [ENTER]Altera [INS]Novo [DEL]Exclui" ) 
           ELSEIF nOpcao == 3 
              Mensagem( "[TAB]Janela [G]Gravar [ENTER]Editar" ) 
           ENDIF 
 
      CASE nTecla == K_F12;   Calculador() 
 
      CASE nTecla == K_DEL 
           IF nOpcao == 2 
              aCustos[ 1 ][ 3 ]:= aCustos[ nRow1 ][ 3 ] - aSelecionados[ nRow ][ 6 ] 
              aSelecionados[ nRow ]:= { SPACE( 13 ),; 
                                        PAD( "             ", 40 ),; 
                                        SPACE( 2 ),; 
                                        0,; 
                                        0,; 
                                        0,; 
                                        0,; 
                                        SPACE( 12 ),; 
                                        0,; 
                                        0,; 
                                        0,; 
                                        0 } 
              oTb2:RefreshCurrent() 
              WHILE !oTb2:Stabilize() 
              ENDDO 
           ENDIF 
 
      CASE DBPesquisa( nTecla, oTb ) 
 
      CASE nTecla==K_F2;    DBMudaOrdem( 1, oTb ) 
 
      CASE nTecla==K_F3;    DBMudaOrdem( 4, oTb ) 
 
      CASE nTecla==K_F4;    DBMudaOrdem( 2, oTb ) 
 
      CASE nTecla == K_INS 
           IF nOpcao == 2 
              AAdd( aSelecionados, { SPACE( 13 ),; 
                                     PAD( "             ", 40 ),; 
                                     SPACE( 2 ),; 
                                     0,; 
                                     0,; 
                                     0,; 
                                     0,; 
                                     SPACE( 12 ),; 
                                     0,; 
                                     0,; 
                                     0,; 
                                     0 } ) 
              oTb2:Down() 
              oTb2:RefreshAll() 
              WHILE !oTb2:Stabilize() 
              ENDDO 
           ENDIF 
 
      CASE nTecla == K_ENTER 
           IF nOpcao == 3 
              IF nRow1 == 2         /* Margem de Lucro */ 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 nMargem:= aCustos[ 2 ][ 2 ] 
                 VPBox( 06, 41, 10, 77, "Margem de Lucro", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 08,45 Say "% Margem.:" Get nMargem Pict "@E 99999.99" 
                 READ 
                 aCustos[ 2 ][ 2 ]:= nMargem 
                 aCustos[ 2 ][ 3 ]:=( aCustos[ 1 ][ 3 ] * nMargem ) / 100 
                 aCustos[ 4 ][ 3 ]:= aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] + aCustos[ 3 ][ 3 ] 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 oTb3:RefreshAll() 
                 WHILE !oTb3:Stabilize() 
                 ENDDO 
             ELSEIF nRow1 == 3 
                 lMudaPv:= IF ( aCustos[ 5 ][ 3 ] == aCustos[ 4 ][ 3 ], .T., .F. ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 nMObra:= aCustos[ 3 ][ 2 ] 
                 nValorMObra:= aCustos[ 3 ][ 3 ] 
                 VPBox( 06, 41, 11, 77, "Mao de Obra", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 08,43 Say "Mao-de-Obra.:" Get nMObra      Pict "@E 999.99" 
                 @ 09,43 Say "Valor M.Obra:" Get nValorMObra Pict "@E 9,999,999.99" 
                 READ 
                 nFator:=( ( 100 - nMObra ) / 100 ) 
                 aCustos[ 3 ][ 2 ]:= nMObra 
                 IF nMObra <> 0 
                    aCustos[ 3 ][ 3 ]:=( ( aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] ) / nFator ) -; 
                       ( aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] ) 
                 ELSE 
                    aCustos[ 3 ][ 3 ]:= nValorMObra 
                 ENDIF 
                 aCustos[ 4 ][ 3 ]:= aCustos[ 1 ][ 3 ] + aCustos[ 2 ][ 3 ] + aCustos[ 3 ][ 3 ] 
                 aCustos[ 5 ][ 3 ]:= IF ( aCustos[ 5 ][ 3 ] == 0, aCustos[ 4 ][ 3 ], aCustos[ 5 ][ 3 ] ) 
                 aCustos[ 6 ][ 3 ]:= IF ( lMudaPV, aCustos[ 4 ][ 3 ], aCustos[ 5 ][ 3 ] ) 
 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 oTb3:RefreshAll() 
                 WHILE !oTb3:Stabilize() 
                 ENDDO 
              ELSEIF nRow1 == 5 
                 lMudaPv:= .F. 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 nValorUsuario:= aCustos[ 5 ][ 3 ] 
                 VPBox( 06, 41, 11, 77, "Preco definido", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 09,43 Say "Valor.......:" Get nValorUsuario Pict "@E 9,999,999.99" 
                 READ 
 
                 IF nValorUsuario == 0 
                    aCustos[ 5 ][ 3 ]:= aCustos[ 4 ][ 3 ] 
                    aCustos[ 6 ][ 3 ]:= aCustos[ 5 ][ 3 ] 
                 ENDIF 
 
                 IF LastKey() <> K_ESC .AND. nValorUsuario > 0 
                    aCustos[ 5 ][ 3 ]:= nValorUsuario 
                    aCustos[ 6 ][ 3 ]:= aCustos[ 5 ][ 3 ] 
                 ENDIF 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 oTb3:RefreshAll() 
                 WHILE !oTb3:Stabilize() 
                 ENDDO 
              ENDIF 
 
           ELSEIF nOpcao == 1 .OR. nOpcao == 2 
              cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
              IF ( nPosicao:= AScan( aSelecionados,; 
                            {|x| x[1] == PAD( CODFAB, 13 ) .AND.; 
                                 x[2] == DESCRI } ) ) > 0 .OR. nOpcao == 2 
                 /* Se estiver na janela de selecionados a posicao 
                    sera == nRow, pois � o registro que esta sendo editado */ 
                 IF nOpcao == 2 
                    nPosicao:= nRow 
                 ENDIF 
                 cCodFab:= aSelecionados[ nPosicao ][ 1 ] 
                 cDescri:= aSelecionados[ nPosicao ][ 2 ] 
                 nCustoUnitario:= aSelecionados[ nPosicao ][ 5 ] 
                 cUnidad:= aSelecionados[ nPosicao ][ 3 ] 
                 nQuantidade:= aSelecionados[ nPosicao ][ 4 ] 
                 nCustoAnterior:= nCustoUnitario * nQuantidade 
                 nPerIpi:= aSelecionados[ nPosicao ][ 7 ] 
                 cIndice:= aSelecionados[ nPosicao ][ 8 ] 
                 nClasse:= aSelecionados[ nPosicao ][ 9 ] 
                 nTamCod:= aSelecionados[ nPosicao ][ 10 ] 
                 nCorCod:= aSelecionados[ nPosicao ][ 11 ] 
                 nTamQua:= aSelecionados[ nPosicao ][ 12 ] 
                 cArq:= "ASM" 
                 cTemCor:= IIF ( nCorCod > 0, "S", "N" ) 
              ELSE 
                 IF PXF->( DBSeek( MPR->INDICE ) ) 
                    nCustoUnitario:= PXF->VALOR_ 
                 ELSE 
                   nCustoUnitario:= 0 
                 ENDIF 
                 cCodFab:= PAD( CODFAB, 13 ) 
                 cDescri:= DESCRI 
                 cUnidad:= UNIDAD 
                 cIndice:= INDICE 
                 nQuantidade:= 1 
                 nPerIpi:= IPI___ 
                 nPosicao:= 0 
                 // Materia Prima 
                 nClasse:= PCPCLA 
                 nTamCod:= PCPTAM 
                 cTemCor:= IIF ( PCPCSN == "S", "S", "N" ) 
                 nCorCod:= 0 
                 nTamQua:= 0 
                 cArq:= "MPR" 
              ENDIF 
 
              cClasse:= SPACE( 40 ) 
              cTamanho:= SPACE( 10 ) 
              cCorDes:= SPACE( 30 ) 
              fAcessaTamCor( nClasse, nTamCod, nCorCod, @cClasse, ; 
                             @cTamanho, @cCorDes, cTemCor ) 
 
              VPBox( 7, 10, 18, 75, " Edicao de Produtos ", _COR_GET_BOX ) 
              @  8,11 Say "Codigo Fabrica...:" Get cCodFab 
              @  9,11 Say "Descricao........:" Get cDescri        Pict "@S40" 
              @ 10,11 Say "Unidade..........:" Get cUnidad 
              @ 11,11 Say "% IPI............:" Get nPerIpi        Pict "@E 999.99" 
              @ 12,11 Say "Custo Unitario...:" Get nCustoUnitario Pict "@E 999,999.9999" 
              @ 13,11 Say "Quantidade.......:" Get nQuantidade    Pict "@E 999,999.9999" ; 
                 WHEN nClasse == 0 
              @ 14,11 Say REPL( "�", 64 ) 
              @ 15,11 Say "Classe ..........: [" + cClasse  + "]" 
              @ 16,11 Say "Cor .............: [" + cCorDes  + "]" 
              @ 17,11 Say "Tamanho .........: [" + cTamanho + "]" 
              READ 
              IF ! LastKey() == K_ESC 
 
                 fSelecTamCor( nClasse, @nTamCod, @nCorCod, @nTamQua, cArq, ; 
                    @nQuantidade, cTemCor, @aCorTamQua ) 
                 nCustoTotal:= nCustoUnitario * nQuantidade 
                 IF nPosicao > 0 
                    aSelecionados[ nPosicao ]:= { cCodFab,; 
                                                  cDescri,; 
                                                  cUnidad,; 
                                                  nQuantidade,; 
                                                  nCustoUnitario,; 
                                                  nCustoTotal,; 
                                                  nPerIpi,; 
                                                  cIndice,; 
                                                  nClasse,; 
                                                  nTamCod,; 
                                                  nCorCod,; 
                                                  nTamQua} 
                    aCustos[ 1 ][ 3 ]:= aCustos[ 1 ][ 3 ] -( nCustoAnterior ) + nCustoTotal 
                 ELSE 
                     /* Procura em branco */ 
                     nPosicao:= ASCAN( aSelecionados, {|x| Empty( x[1] ) .AND. Empty( x[2] ) } ) 
                     IF nPosicao == 0 
                        AAdd( aSelecionados, { cCodFab,; 
                                            cDescri,; 
                                            cUnidad,; 
                                            nQuantidade,; 
                                            nCustoUnitario,; 
                                            nCustoTotal,; 
                                            nPerIpi,; 
                                            cIndice,; 
                                            nClasse,; 
                                            nTamCod,; 
                                            nCorCod,; 
                                            nTamQua} ) 
                     ELSE 
                        aSelecionados[ nPosicao ]:= { cCodFab,; 
                                            cDescri,; 
                                            cUnidad,; 
                                            nQuantidade,; 
                                            nCustoUnitario,; 
                                            nCustoTotal,; 
                                            nPerIpi,; 
                                            cIndice,; 
                                            nClasse,; 
                                            nTamCod,; 
                                            nCorCod,; 
                                            nTamQua} 
                     ENDIF 
                     aCustos[ 1 ][ 3 ]:= aCustos[ 1 ][ 3 ] + nCustoTotal 
                 ENDIF 
              ENDIF 
              ScreenRest( cTelaRes ) 
              IF nOpcao == 1 
                 oTb2:Down() 
                 oTb2:RefreshAll() 
                 WHILE !oTb2:Stabilize() 
                 ENDDO 
              ENDIF 
              oTb3:RefreshAll() 
              WHILE !oTb3:Stabilize() 
              ENDDO 
           ENDIF 
   ENDCASE 
   DO CASE 
      CASE nOpcao == 1 
             oTb3:RefreshAll() 
             WHILE !oTb3:Stabilize() 
             ENDDO 
             Movimento( nTecla, nOpcao, oTb ) 
      CASE nOpcao == 2 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
             Movimento( nTecla, nOpcao, oTb2 ) 
      CASE nOpcao == 3 
             oTb2:RefreshAll() 
             WHILE !oTb2:Stabilize() 
             ENDDO 
             Movimento( nTecla, nOpcao, oTb3 ) 
   ENDCASE 
 
ENDDO 
SetCursor( 1 ) 
SetColor( cCor ) 
ScreenRest( cTela ) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
oOldTb:RefreshAll() 
WHILE !oOldTb:Stabilize() 
ENDDO 
Return( .T. ) 
/***** 
�������������Ŀ 
� Funcao      � MenuSelect 
� Finalidade  � Apresentar a opcao selecionada no menu 
� Parametros  � nOpcao - aMenuOpcao 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Abril/98 
��������������� 
*/ 
Function MenuSelect( nOpcao, aMenuOpcao ) 
SetColor( _COR_GET_BOX ) 
FOR nCt:= 1 TO Len( aMenuOpcao ) 
    SetColor( IF ( nCt==nOpcao, "04/15", _COR_GET_BOX ) ) 
    @ aMenuOpcao[nCt][2], aMenuOpcao[nCt][3] Say aMenuOpcao[nCt][1] 
NEXT 
Return( .T. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � Movimento 
� Finalidade  � Referente movimento de produtos 
� Parametros  � Tecla/Opcao/oTb 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Abr-98 
��������������� 
*/ 
Function Movimento( nTecla, nOpcao, oTb ) 
   do case 
      case nTecla==K_UP         ;oTb:up() 
      case nTecla==K_DOWN       ;oTb:down() 
      case nTecla==K_LEFT       ;oTb:up() 
      case nTecla==K_RIGHT      ;oTb:down() 
      case nTecla==K_PGUP       ;oTb:pageup() 
      case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
      case nTecla==K_PGDN       ;oTb:pagedown() 
      case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
      case nTecla==K_ENTER 
 
   endcase 
   oTb:refreshcurrent() 
   oTb:stabilize() 
 
/***** 
�������������Ŀ 
� Funcao      � MoedaProduto 
� Finalidade  � Gravar a Moeda do Produto 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
FUNCTION MoedaProduto() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
DBSelectAr( _COD_MPRIMA ) 
cMoeda:= MPR->MOEDA_ 
SetColor( _COR_GET_EDICAO ) 
VPBox( 15, 20, 19, 65, " Moeda ", _COR_GET_BOX ) 
@ 17, 22 Say " Moeda Utilizada      Preco Venda   " 
@ 18, 22 Say "     " Get cMoeda 
@ 18, 43 Say "[" + Tran( PRECOV, "@E 999,999,999.99" ) + "]" 
READ 
/* Gravacao */ 
IF netrlock() 
   Replace MOEDA_ With cMoeda 
ENDIF 
ScreenRest( cTela ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � Grupo 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function Grupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt, cGrupoR:= "000" 
   DBSelectAr( _COD_GRUPO ) 
   DBSetOrder( 1 ) 
   IF DBSeek( cGrupo_ ) 
      cGrupo_:= CODIGO 
      cCodigo:= cGrupo_ + Right( cCodigo, 4 ) 
   ELSE 
      cGrupoR:= cGrupo_ 
      DBGoTop() 
      VerificaGrupo( @cGrupoR ) 
      cGrupo_:= cGrupoR 
      cCodigo:= cGrupo_ + Right( cCodigo, 4 ) 
   ENDIF 
   IF cGrupo_ == "999" 
      cGrupo_:= "000" 
   ENDIF 
   Mensagem( "Procurando o ultimo codigo utilizado pelo grupo: " + cGrupo_ + ", aguarde..." ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   SetColor( _COR_BROW_LETRA ) 
   IF cGrupo_ == Left( MPr->Indice, 3 ) 
      While cGrupo_ == Left( MPr->Indice, 3 ) 
         DBSkip() 
         IF EOF() 
            Exit 
         ENDIF 
      EndDo 
      DBSkip( -1 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ) + 1, 4, 0 ) 
      For nCt:= 24 - 2 To 24 - 5 Step -1 
          If !Bof() 
             DBSkip( -1 ) 
          EndIf 
      Next 
   ELSE 
      cCodigo:= "0001" 
   ENDIF 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return( .T. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � Codigo 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function Codigo( cCodigo, GetList ) 
   Local cGrupo_:= GetList[ 1 ]:VarGet() 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ), nTecla 
   Local nOrdem:= IndexOrd() 
   DBSetOrder( 1 ) 
   If DBSeek( PAD( cGrupo_ + cCodigo, 12 ) ) 
      Ajuda( "[Enter]Continua" ) 
      Aviso( "C�digo j� existente neste grupo...", 24 / 2 ) 
      Mensagem( "Pressione [ENTER]Novo ou [TAB]Ignorar..." ) 
      nTecla:= Inkey( 0 ) 
      IF nTecla==K_TAB 
         cCodigo:= cCodigo 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return .T. 
      ELSE 
         cCodigo:= StrZero( Val( MPr->CodRed ) + 1, 4, 0 ) 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return .F. 
      ENDIF 
   EndIf 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
 
   Func fSelecTamCor( nClasse, nTamCod, nCorCod, nTamQua, cArq, nQuantidade, ; 
        cTemCor, aCorTamQua ) 
 
      Local nArea:= Select(), nOrdem:= IndexOrd(), cCorAnt:= SetColor(), ; 
            nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local aTamanhos 
 
      IF ( nClasse == 0 .AND. nTamCod == 0 .AND. nCorCod == 0 .AND. cTemCor == "N" ) 
         Return( .F. ) 
      ENDIF 
 
      IF ( nClasse <> 0 ) 
 
         aTamanhos:= 0 
         aTamanhos:= {} 
 
         AADD( aTamanhos, {"<Nenhum>  ", 0, 0} ) 
 
         CLA->( DBSetOrder( 3 ) ) 
 
         IF ( CLA->( DBSeek( nClasse ) ) == .T. ) 
            FOR nPos:= 2 TO 21 
               cPos:= STRZERO( nPos - 1, 2 ) 
               IF ( EMPTY( CLA->TAMA&cPos ) == .T. ) 
                  EXIT 
               ENDIF 
               IF ( nPos - 1 == nTamCod ) 
                  nTmpQua:= nTamQua 
                  IF ! ( cArq=="EST" ) 
                     nQuantidade:= nTamQua 
                  ENDIF 
               ELSE 
                  nTmpQua:= 0 
               ENDIF 
               AADD( aTamanhos, {CLA->TAMA&cPos, nTmpQua, nPos - 1} ) 
            NEXT nPos 
         ENDIF 
/* 
         IF cArq == "ASM" 
 
            IF nCorCod > 0 
               KEYBOARD REPL( CHR( K_DOWN ), nCorCod ) 
            ENDIF 
 
            IF nCorCod > 0 .AND. nTamCod > 0 
               KEYBOARD CHR( K_ENTER ) 
            ENDIF 
 
            IF nTamCod > 0 
               KEYBOARD REPL( CHR( K_DOWN ), nTamCod ) 
            ENDIF 
 
         ENDIF 
*/ 
      ENDIF 
 
      fTamCor( @aTamanhos, @nTamCod, @nCorCod, @nTamQua, @nQuantidade, ; 
               @nClasse, cTemCor, cArq, @aCorTamQua ) 
 
      /* Soma Quantidades antes de retornar */ 
      nQuantidade:= 0 
      FOR nCt:= 1 TO LEN( aCorTamQua ) 
          FOR nCt2:= 2 TO Len( aCorTamQua[ nCt ] ) 
              nQuantidade+= aCorTamQua[ nCt ][ nCt2 ] 
          NEXT 
      NEXT 
 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCorAnt ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
 
   Func fTamCor( aTamanhos, nTamCod, nCorCod, nTamQua, nQuantidade, ; 
                 nClasse, cTemCor, cArq, aCorTamQua ) 
      Local GetList:= {} 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ), cQuadro:= "COR" 
      Local nTamLin:= 1, nArea:= Select(), ; 
            nOrdem:= IndexOrd(), lCorTopo:= .T., nXXXPosicao:= 0 
 
      SetCursor( 1 ) 
 
// � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � 
 
      IF ( nCorCod <> 0 .OR. cTemCor == "S" ) 
 
         VPBox( 02, 08, 13, 39, "Cores", _COR_BROW_BOX, .T., .T., , , .T. ) 
 
         SetColor( _COR_BROW_BARRA ) 
         @ 03, 09 SAY "<Nenhuma Cor>                 " 
 
         SetColor( _COR_BROWSE ) 
         Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
         DBSelectAr( _COD_CORES ) 
 
         COR->( DbGoTop() ) 
 
         oCores:=TBrowseDB( 04, 09, 12, 38 ) 
         oCores:AddColumn( tbcolumnnew( ,{|| COR->DESCRI + SPACE( 65 ) } ) ) 
         oCores:AutoLite:=.f. 
         oCores:dehilite() 
 
         oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 3 }, { 2, 1 } ) 
         WHILE !oCores:Stabilize() 
         ENDDO 
 
      ENDIF 
 
// � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � 
 
      IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
 
         VPBox( 02, 43, 13, 72, "   Tamanhos        Quantidade", _COR_BROW_BOX, .T., .T., , , .T. ) 
 
         SetColor( _COR_BROWSE ) 
         oTamanhos:=TBrowseNew( 03, 44, 12, 71 ) 
         oTamanhos:AddColumn( tbcolumnnew( ,; 
            {|| aTamanhos [nTamLin, 1] + "    " + ; 
            TRAN( aTamanhos [nTamLin, 2], "@E 99,999,999.999" ) + Space( 65 ) } ) ) 
         oTamanhos:AutoLite:=.f. 
         oTamanhos:GOTOPBLOCK:={|| nTamLin:= 1} 
         oTamanhos:GOBOTTOMBLOCK:={|| nTamLin:= Len( aTamanhos ) } 
         oTamanhos:SKIPBLOCK:={|x| skipperarr( x,aTamanhos,@nTamLin )} 
         oTamanhos:dehilite() 
 
      ENDIF 
 
// � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � 
 
      IF ( nCorCod <> 0 .OR. cTemCor == "S" ) 
          cQuadro:= "COR" 
      ELSE 
          cQuadro:= "TAM" 
      ENDIF 
 
      SetCursor( 0 ) 
 
      WHILE .T. 
 
         SetColor( _COR_GET_EDICAO ) 
 
         IF ( cQuadro = "COR" ) 
 
            // Cores 
            Mensagem( "[TAB, " + CHR( 27 ) + ", " + CHR( 26 ) + "ENTER]]Selecionar Cor   [ESC]Sair" ) 
            IF ( lCorTopo = .F. ) 
               oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, oCores:COLCOUNT  }, { 2, 1 } ) 
               WHILE !oCores:Stabilize() 
               ENDDO 
            ENDIF 
 
            IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
 
               oTamanhos:GoTop() 
 
               // Tamanhos 
               oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, 3 }, { 2, 1 } ) 
               oTamanhos:RefreshAll() 
               WHILE !oTamanhos:Stabilize() 
               ENDDO 
 
            ENDIF 
 
         ELSE 
 
            // Tamanhos 
            Mensagem( "[ENTER]Quantidade   [TAB, " + CHR( 27 ) + ", " + CHR( 26 ) + ; 
               "]Voltar p/Cores   [ESC]Sair" ) 
            oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, oTamanhos:COLCOUNT  }, { 2, 1 } ) 
            WHILE !oTamanhos:Stabilize() 
            ENDDO 
 
         ENDIF 
 
         nTecla:=inkey( 0 ) 
 
         DO CASE 
            CASE nTecla==K_ESC .OR. Chr( nTecla ) $ "gG" 
               EXIT 
            CASE nTecla==K_UP 
               IF ( cQuadro = "COR" ) 
                  oCores:up() 
                  oCores:RefreshAll() 
                  WHILE !oCores:Stabilize() 
                  ENDDO 
                  IF ( oCores:HITTOP = .T. ) 
                     SetColor( _COR_BROW_BARRA ) 
                     @ 03, 09 SAY "<Nenhuma Cor>                 " 
                     SetColor( _COR_BROWSE ) 
                     oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 3 }, { 2, 1 } ) 
                     oCores:RefreshAll() 
                     WHILE !oCores:Stabilize() 
                     ENDDO 
                     lCorTopo:= .T. 
                  ENDIF 
               ELSE 
                  oTamanhos:up() 
               ENDIF 
            CASE nTecla==K_DOWN 
               IF ( cQuadro = "COR" ) 
                  IF ( lCorTopo = .T. ) 
                     SetColor( _COR_BROWSE ) 
                     @ 03, 09 SAY "<Nenhuma Cor>                 " 
                     IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
                        oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, oTamanhos:COLCOUNT  }, { 2, 1 } ) 
                        WHILE !oTamanhos:Stabilize() 
                        ENDDO 
                     ENDIF 
                     lCorTopo:= .F. 
                  ELSE 
                     oCores:down() 
                  ENDIF 
               ELSE 
                  oTamanhos:down() 
               ENDIF 
            CASE nTecla==K_PGUP 
               IF ( cQuadro = "COR", oCores:pageup()  , oTamanhos:pageup() ) 
            CASE nTecla==K_PGDN 
               IF ( cQuadro = "COR", oCores:pagedown(), oTamanhos:pagedown() ) 
            CASE nTecla==K_CTRL_PGUP 
               IF ( cQuadro = "COR", oCores:gotop()   , oTamanhos:gotop() ) 
            CASE nTecla==K_CTRL_PGDN 
               IF ( cQuadro = "COR", oCores:gobottom(), oTamanhos:gobottom() ) 
 
            CASE nTecla==K_ENTER .OR. CHR( nTecla ) $ "0123456789.-" 
 
               IF nTecla==K_ENTER .AND. cQuadro=="COR" 
 
                  IF ( lCorTopo == .F. ) 
                     nCorCod:= COR->CODIGO 
                  ELSE 
                     nCorCod:= 0 
                  ENDIF 
                  IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
                     cQuadro:= "TAM" 
                     /* Armazena informacoes p/ edicao p/ aTamanhos */ 
                     IF ( nXXXPosicao:= ASCAN( aCorTamQua, {|x| x[1]==nCorCod } ) ) <= 0 
                        AAdd( aCorTamQua, { nCorCod, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } ) 
                        nXXXPosicao:= Len( aCorTamQua ) 
                     ENDIF 
                     FOR nCt:= 2 TO Len( aTamanhos ) + 1 
                         aTamanhos[nCt-1][ 2 ]:= aCorTamQua[nXXXPosicao][ nCt ] 
                     NEXT 
                     oTamanhos:RefreshAll() 
                     WHILE !oTamanhos:Stabilize() 
                     ENDDO 
                  ELSE 
                     IF ! ( cArq=="EST" ) .OR. nClasse == 0 .OR. nTamCod == 0 
                        EXIT 
                     ENDIF 
                  ENDIF 
               ELSEIF ( cQuadro = "TAM" ) 
                  IF !( nTecla==K_ENTER ) 
                     KeyBoard( CHR( nTecla ) ) 
                  ENDIF 
 
                  fTamRec( @aTamanhos, @nTamLin, @nTecla, @lCorTopo, ; 
                           @nTamCod, @nCorCod, @nTamQua, @nQuantidade, cArq ) 
                  IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
                     /* Recupera Informacoes */ 
                     IF nXXXPosicao == 0 
                        nXXXPosicao := 1 
                     ENDIF 
                     FOR nCt:= 2 TO Len( aTamanhos ) + 1 
                         aCorTamQua[ nXXXPosicao ][ nCt ]:= aTamanhos[nCt-1][ 2 ] 
                     NEXT 
                     oTamanhos:RefreshAll() 
                     WHILE !oTamanhos:Stabilize() 
                     ENDDO 
                  ENDIF 
                  IF ! ( cArq=="EST" ) 
                     EXIT 
                  ENDIF 
               ENDIF 
 
          CASE nTecla==K_TAB 
          //.OR. nTecla==K_LEFT .OR. nTecla==K_RIGHT 
               IF ( cQuadro = "COR" ) 
 
                  SetColor( _COR_BROW_BARRA ) 
            //      @ 03, 09 SAY "<Nenhuma Cor>                 " 
            //      lCorTopo:= .T. 
            //      oCores:GoTop() 
 
            //      oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 3 }, { 2, 1 } ) 
            //      oCores:RefreshAll() 
            //      WHILE !oCores:Stabilize() 
            //      ENDDO 
                  IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
                     cQuadro:= "TAM" 
                  ENDIF 
                  /* Armazena informacoes p/ edicao p/ aTamanhos */ 
                  IF ( nXXXPosicao:= ASCAN( aCorTamQua, {|x| x[1]==nCorCod } ) ) <= 0 
                     AAdd( aCorTamQua, { nCorCod, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } ) 
                     nXXXPosicao:= Len( aCorTamQua ) 
                  ENDIF 
                  FOR nCt:= 2 TO Len( aTamanhos ) + 1 
                      aTamanhos[nCt-1][ 2 ]:= aCorTamQua[nXXXPosicao][ nCt ] 
                  NEXT 
                  oTamanhos:RefreshAll() 
                  WHILE !oTamanhos:Stabilize() 
                  ENDDO 
               ELSE 
                  IF ( nCorCod <> 0 .OR. cTemCor == "S" ) 
                     cQuadro:= "COR" 
                  ENDIF 
               ENDIF 
 
            OTHERWISE 
               Tone( 125 ); Tone( 300 ) 
         ENDCASE 
 
         IF ( cQuadro = "COR" ) 
            oCores:RefreshCurrent() 
            WHILE !oCores:Stabilize() 
            ENDDO 
 
            IF ( lCorTopo = .F. ) 
               nCorCod:= COR->CODIGO 
            ELSE 
               nCorCod:= 0 
            ENDIF 
 
            /* Armazena informacoes p/ edicao p/ aTamanhos */ 
            IF ( nXXXPosicao:= ASCAN( aCorTamQua, {|x| x[1]==nCorCod } ) ) <= 0 
               AAdd( aCorTamQua, { nCorCod, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } ) 
               nXXXPosicao:= Len( aCorTamQua ) 
            ENDIF 
            IF ( nClasse <> 0 .OR. nTamCod <> 0 ) 
               FOR nCt:= 2 TO Len( aTamanhos ) + 1 
                  aTamanhos[nCt-1][ 2 ]:= aCorTamQua[nXXXPosicao][ nCt ] 
               NEXT 
               oTamanhos:RefreshAll() 
               WHILE !oTamanhos:Stabilize() 
               ENDDO 
            ENDIF 
         ELSE 
            oTamanhos:RefreshCurrent() 
            oTamanhos:Stabilize() 
         ENDIF 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
 
   Func fTamRec( aTamanhos, nTamLin, nTecla, lCorTopo, nTamCod, nCorCod, ; 
                 nTamQua, nQuantidade, cArq ) 
 
      Local GetList:= {} 
      Local nArea:= Select(), nOrdem:= IndexOrd(), cCorAnt:= SetColor(), ; 
            nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nTamAnt 
 
      VpBox( 6, 47,  9, 66, " Quantidade", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .F. ) 
 
      SetColor( _COR_GET_EDICAO ) 
 
      nTamAnt:= aTamanhos [nTamLin, 2] 
 
      nTam:= aTamanhos [nTamLin, 2] 
      @  8, 49 GET nTam ; 
         PICT( "@E 99,999,999.999" ) VALID fKeyboard( @nTecla ) 
      SetCursor( 3 ) 
      READ 
 
      IF ( nTam <> nTamAnt ) 
         IF ! ( cArq=="EST" ) 
            FOR nCt:= 1 to Len( aTamanhos ) 
                aTamanhos[ nCt ][ 2 ]:= 0 
            NEXT 
         ENDIF 
         aTamanhos[ nTamLin ][ 2 ]:= nTam 
         nTamQua:= aTamanhos [nTamLin, 2] 
         nTamCod:= aTamanhos [nTamLin, 3] 
         IF ! ( cArq=="EST" ) 
            nQuantidade := nTam 
         ELSE 
            nQuantidade += nTam 
         ENDIF 
      ENDIF 
 
      IF ( lCorTopo = .F. ) 
         nCorCod:= COR->CODIGO 
      ELSE 
         nCorCod:= 0 
      ENDIF 
 
      IF ( nTecla == 0 ) 
         nTecla:= K_TAB 
      ENDIF 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCorAnt ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
 
   Func fKeyboard( nTecla ) 
 
      IF ( LASTKEY() == K_TAB ) 
         nTecla:= 0 
         KeyBoard( CHR( K_ESC ) ) 
      ENDIF 
 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
 
   Func fAcessaTamCor( nClasse, nTamCod, nCorCod, cClasse, cTamanho, cCorDes ) 
 
      Local nArea:= Select(), nOrdem:= IndexOrd(), cCorAnt:= SetColor(), ; 
            nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
      IF ( nClasse <> 0 ) 
 
         CLA->( DBSetOrder( 3 ) ) 
 
         IF ( CLA->( DBSeek( nClasse ) ) == .T. ) 
            cClasse:= CLA->DESCRI 
            IF ( nTamCod <> 0 ) 
               cPos:= STRZERO( nTamCod, 2 ) 
               cTamanho:= CLA->TAMA&cPos 
            ELSE 
               cTamanho:= SPACE( 10 ) 
            ENDIF 
         ENDIF 
 
      ENDIF 
 
      IF ( nCorCod <> 0 ) 
 
         COR->( DBSetOrder( 1 ) ) // CODIGO 
 
         IF ( COR->( DBSeek( nCorCod ) ) = .T. ) 
            cCorDes:= COR->DESCRI 
         ENDIF 
 
      ENDIF 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCorAnt ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
 
   Function fVerClasse( nClaMPR ) 
 
      nCla:= nClaMPR 
      nClaAnt:= nCla 
 
      ExiClasse( @nCla ) 
 
      IF ( nCla <> nClaAnt ) 
         nClaMPR:= nCla 
         IF netrlock() 
            MPR->PCPCLA:= nCla 
         ENDIF 
      ENDIF 
 
   Return( .T. ) 
 
// ����������������������������������������������������������������������������� 
// ����������������������������������������������������������������������������� 
// ����������������������������������������������������������������������������� 
 
