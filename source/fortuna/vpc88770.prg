// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 

#ifdef HARBOUR
function vpc88770()
#endif


Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor(0) 
Local oTb 
 
   SetCursor(0) 
   DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   USERSCREEN() 
   VPBOX( 0, 0, 12, 79, "COTACAO MANUAL - TELA PRINCIPAL", _COR_BROW_BOX ,.T.,.F., _COR_BROW_TITULO, .F. ) 
   VPBOX( 13,0, 21, 79, "DISPLAY", _COR_BROW_BOX ,.T.,.F., _COR_BROW_TITULO, .F. ) 
 
   SetColor( _COR_BROWSE ) 
   @ 01,02 Say "Lancamento manualmente de Informacoes a titulo de cotacao." Color "08/" + CorFundoAtual() 
   @ 02,01 Say Repl( "�", 78 ) Color "00/" + CorFundoAtual() 
 
   @ 04,02 Say "Nome....:" 
   @ 05,02 Say "Endereco:" 
   @ 06,02 Say "Cidade..:" 
   @ 07,02 Say "Fone....:" 
   @ 08,02 Say "FAX.....:" 
   @ 09,02 Say "Contato.:" 
   @ 10,02 Say "Transpor:" 
   @ 11,02 Say "Data....:" 
   DispEnd() 
 
   Ajuda("["+_SETAS+"][PgDn][PgUp][Home][End]Move "+; 
         "[TAB]Imprimir [Nome/Codigo]Pesquisa") 
   Mensagem("[INS]Novo [ENTER]Alt [F2..F5]Ordem [TAB]Imprime [ESC]Sair") 
 
   DBSelectAr( _COD_TRANSPORTE ) 
   DBSetOrder( 1 ) 
 
   DBSelectAr( _COD_NFISCAL ) 
   DBSetOrder( 4 ) 
 
   DBSelectar( _COD_PEDIDO ) 
   DBSetOrder( 1 ) 
   Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA 
 
   DBGoBottom() 
   SetColor( _COR_BROWSE ) 
 
   DBSelectAr( _COD_PEDIDO ) 
   DBLeOrdem() 
 
   oTb:=TBrowseDb( 14, 01, 20, 78 ) 
   oTb:AddColumn( TbColumnNew("C/P Numero Cliente                                Vlr.Ped.  Nota    Vlr.Nf.",; 
                  {|| Left( Situa_, 1 ) + " " + IF( !Empty( CodPed ), CodPed, Codigo ) + " " + ; 
                      Left( Descri, 36 ) + " " + Tran( VlrTot,  "@EZ 99999.99" ) + IF( NF_->Pedido==0, Space( 40 ), NF_->NFNULA + StrZero( NF_->Numero, 6, 0 ) + " " + Tran( NF_->VlrTot, "@E 999,999.99" ) ) + Space( 10 ) } ) ) 
   oTb:AUTOLITE:=.F. 
   oTb:dehilite() 
   While .T. 
         oTb:ColorRect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
         Whil NextKey()=0 .and.! oTb:Stabilize() 
         enddo 
         SetColor( _COR_BROW_LETRA ) 
 
         DevPos( 03, 02 ) 
         IF !Empty( CodPed ) 
            DevOut( "Pedido..: " + CodPed ) 
            SetColor( "14/01" ) 
            @ 03, 55 Say " N� Cotacao  " + Codigo 
         ELSE 
            DevOut( "Cotacao.: " + Codigo ) 
            SetColor( _COR_BROW_LETRA ) 
            @ 03, 55 Say Space( 21 ) 
         ENDIF 
 
         SetColor( _COR_BROW_LETRA ) 
         @ 4, 12 Say Descri 
         @ 5, 12 Say Endere 
         @ 6, 12 Say Cidade 
         @ 7, 12 Say Tran( Left( FonFax, AT( "/", FonFax ) - 1 ),  "@R (9999)-9999.9999" ) 
         @ 8, 12 Say Tran( SubStr( FonFax, AT( "/", FonFax ) + 2 ), "@R (9999)-9999.9999" ) 
         @ 9, 12 Say Compra 
         @ 10,12 Say StrZero( Transp, 4, 0 ) + "-" + TRA->Descri 
         @ 11,12 Say Data__ 
 
         SetColor( _COR_BROWSE ) 
         nTECLA:=inkey(0) 
         If nTECLA=K_ESC 
            Exit 
         EndIf 
         do case 
            case nTECLA==K_UP         ;oTb:up() 
            case nTECLA==K_DOWN       ;oTb:down() 
            case nTECLA==K_PGUP       ;oTb:pageup() 
            case nTECLA==K_PGDN       ;oTb:pagedown() 
            case nTECLA==K_HOME       ;oTb:gotop() 
            case nTECLA==K_END        ;oTb:gobottom() 
            case nTecla==K_F12        ;Calculador() 
            case nTecla==K_CTRL_F10   ;Calendar() 
            case nTecla==K_DEL 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Utilize o Assistente de Pedido p/ executar esta operacao!") 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
 
            Case nTecla==K_INS 
                 IncluiCotacao( oTb ) 
                 DBLeOrdem() 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
 
            Case nTecla==K_TAB 
                 IF Confirma( 00, 00,; 
                    "Confirma a impressao " + IF( EMPTY( CODPED ), "desta cotacao?", "deste pedido?" ),; 
                    "Digite [S] para confirmar ou [N] p/ cancelar.", "N" ) 
                    IF !Empty( CODPED ) 
                       Relatorio( "PEDIDOS.REP" ) 
                    ELSE 
                       Relatorio( "COTACAO.REP" ) 
                    ENDIF 
                 Endif 
 
            Case nTecla==K_ENTER 
                 IF LEFT( SITUA_, 1 )=="C" 
                    AlteraCotacao( oTb ) 
                    DBLeOrdem() 
                    oTb:RefreshAll() 
                    WHILE !oTb:Stabilize() 
                    ENDDO 
                 ELSE 
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                    Aviso( "Este PEDIDO deve ser modificado pelo Assistente de Pedido." ) 
                    Pausa() 
                    ScreenRest( cTelaRes ) 
                 ENDIF 
 
            case DBPesquisa( nTecla, oTb ) 
            case nTecla == K_F2; DBMudaOrdem( 1, oTb ) 
            case nTecla == K_F3; DBMudaOrdem( 3, oTb ) 
            case nTecla == K_F4; DBMudaOrdem( 4, oTb ) 
            case nTecla == K_F5; DBMudaOrdem( 6, oTb ) 
            otherwise                ;tone(125); tone(300) 
         endcase 
         oTb:Refreshcurrent() 
         oTb:Stabilize() 
     enddo 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     DBUnLockAll() 
     FechaArquivos() 
     return(.T.) 
 
 
Function IncluiCotacao( oTbA ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local GetList:= {} 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor( 1 ) 
   Local nRow:= 1 
   Local nCodigo, cCondi_:= Space( 30 ), cPrazo_:= Space( 10 ), nValid_:= 0,; 
         nTabOpe:= 0, cFrete_:= "", nCodTra:= 0, cObser1:= Space( 60 ),; 
         cObser2:= Space( 60 ), cVende1:= Space( 15 ), cVende2:= Space( 15 ),; 
         nVenEx1:= 0 
 
   VPBox( 00, 00, 22, 79, "INCLUSAO DE COTACAO ", _COR_GET_BOX ) 
   VPBox( 03, 01, 12, 78, , _COR_GET_BOX, .f., .f. ) 
   VPBox( 11, 01, 20, 78, , "15/00", .f., .f., "15/00" ) 
 
   CND->( DBSetOrder( 1 ) ) 
   PRE->( DBSetOrder( 1 ) ) 
 
   nCodigo:= 0 
   dData__:= DATE() 
   cCodCli:= 0 
   cDescri:= Space( LEN( PED->DESCRI ) ) 
   cEndere:= Space( LEN( PED->ENDERE ) ) 
   cBairro:= Space( LEN( PED->BAIRRO ) ) 
   cCidade:= Space( LEN( PED->CIDADE ) ) 
   cEstado:= Space( LEN( PED->ESTADO ) ) 
   cFonFax:= Space( LEN( PED->FONFAX ) ) 
   cCompra:= Space( LEN( PED->COMPRA ) ) 
   nTabCnd:= 0 
   nTotal_:= 0 
   nVenin1:= 0 
   cVenin1:= Space( 15 ) 
   nFrete_:= 0 
 
   SetColor( _COR_GET_EDICAO ) 
   Mensagem( "Digite as Informacoes do Cliente." ) 
   @ 01,03 Say "Cotacao N�.: [" + StrZero( nCodigo, 6, 0 ) + "]" 
   @ 02,03 Say "Emissao....:" Get dData__ 
   @ 04,03 Say "Cliente....:" Get cDescri 
   @ 05,03 Say "Endereco...:" Get cEndere 
   @ 06,03 Say "Bairro.....:" Get cBairro 
   @ 07,03 Say "Cidade.....:" Get cCidade 
   @ 07,50 Say "-" Get cEstado 
   @ 08,03 Say "Fone/Fax...:" Get cFonFax Pict "@R XXXX-XXXX.XXXX" 
   @ 09,03 Say "Contato....:" Get cCompra 
   READ 
   IF LastKey()==K_ESC 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      DBSelectAr( nArea ) 
      Return Nil 
   ENDIF 
 
   aPedido:= { { Space( 13 ),; 
                 Space( 40 ),; 
                 0,; 
                 0,; 
                 0,; 
                 0,; 
                 "  ",; 
                 0,; 
                 "   ",; 
                 "Sim",; 
                 "  ",; 
                 0,; 
                 0,; 
                 0,; 
                 0,; 
                 "                                   ",; 
                 "        ",; 
                 0,; 
                 0,; 
                 0 } } 
 
   Keyboard Chr( K_ENTER ) 
   Mensagem("[ESPACO]Seleciona [INS]Novo [ENTER]Altera [DEL]Excluir") 
   SetColor( "15/00,14/01" ) 
   oTb:=TBrowseNew( 12, 2, 19, 77 ) 
   oTb:addcolumn(tbcolumnnew(,{|| aPedido[ nRow ][ 2 ] + ; 
                                " " + aPedido[ nRow ][ 7 ] + " " +; 
                                  Tran( aPedido[ nRow ][ 6 ], "@E 999,999.99" ) + " " +; 
                                  Tran( aPedido[ nRow ][ 5 ], "@E 99,999.999" ) + " " +; 
                                  Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )      +  " " + aPedido[ nRow ][ 10 ] })) 
   oTb:AUTOLITE:=.f. 
   oTb:GOTOPBLOCK :={|| nRow:= 1} 
   oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aPedido ) } 
   oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPedido,@nRow)} 
   oTb:dehilite() 
   WHILE .T. 
 
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTb:stabilize() 
      end 
 
      SetColor( _COR_BROWSE ) 
      IF ( nTecla:=inkey(0) )==K_ESC 
         EXIT 
      ENDIF 
      DO Case 
         Case Chr( nTecla ) $ "gG" 
              EXIT 
         Case nTecla==K_F12        ;Calculador() 
         Case nTecla==K_UP         ;oTb:up() 
         Case nTecla==K_DOWN       ;oTb:down() 
         Case nTecla==K_LEFT       ;oTb:up() 
         Case nTecla==K_RIGHT      ;oTb:down() 
         Case nTecla==K_PGUP       ;oTb:pageup() 
         Case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         Case nTecla==K_PGDN       ;oTb:pagedown() 
         Case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         Case nTecla==K_INS 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 10, 10, 20, 70, "INCLUSAO DE ITEM", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              SetColor( _COR_GET_EDICAO ) 
              cDescricao:= Space( 40 ) 
              cCodFab:= Space( 13 ) 
              cCodigo:= "0000" 
              cGrupo_:= "000" 
              nPrecoInicial:= 0.00 
              nPerDesconto:=  0.00 
              nPerIPI:= 0.00 
              nPrecoFinal:=   0.00 
              nQuantidade:=   0.00 
              nPrecoInicial:= 0 
              nPrecoFinal:=   0 
              SetCursor(1) 
              @ 11,12 Say "Codigo.....: [INDEFINIDO]" 
              @ 12,12 Say "Descri놹o..:" Get cDescricao 
              READ 
              @ 13,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              @ 14,12 Say "Pre뇇......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 15,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 16,12 Say "Pre뇇 Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 17,12 Say "% IPI......:" Get nPerIPI Pict "999.99" 
              READ 
              If !LastKey()==K_ESC 
                 AAdd( aPedido, { Space( 15 ),; 
                                  Space( 40 ),; 
                                         0.00,; 
                                         0.00,; 
                                         0.00,; 
                                         0.00,; 
                                         Spac( 2 ),; 
                                         0.00,; 
                                         0.00,; 
                                         Space( 3 ),; 
                                         Space( 15 ),; 
                                         0,; 
                                         0,; 
                                         0,; 
                                         0,; 
                                         Space( 40 ),; 
                                         Space( 10 ),; 
                                         0,; 
                                         0,; 
                                         0 } ) 
                 nRow:= Len( aPedido ) 
                 aPedido[ nRow ][ 1 ]:= cCodFab 
                 aPedido[ nRow ][ 2 ]:= cDescricao 
                 aPedido[ nRow ][ 10 ]:= "Sim" 
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial 
                 aPedido[ nRow ][ 4 ]:= nPerDesconto 
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal 
                 aPedido[ nRow ][ 6 ]:= nQuantidade 
                 aPedido[ nRow ][ 8 ]:= nPerIpi 
                 aPedido[ nRow ][ 11 ]:= Space( 3 ) 
                 aPedido[ nRow ][ 15 ]:= 0 
                 aPedido[ nRow ][ 16 ]:= "<INFORMADO MANUALMENTE>" 
                 aPedido[ nRow ][ 17 ]:= PAD( "0000000", 10 ) 
              ENDIF 
              ScreenRest( cTelaReserva ) 
              SetColor( _COR_BROWSE ) 
              CalculoGeral( aPedido ) 
              oTb:RefreshAll() 
              WHILE !oTb:stabilize() 
              ENDDO 
 
         Case nTecla==K_SPACE 
              aPedido[ nRow ][ 10 ]:= If( aPedido[ nRow ][ 10 ]=="Sim", "Nao", "Sim" ) 
              CalculoGeral( aPedido ) 
 
         Case nTecla==K_ENTER 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              SetColor( _COR_GET_EDICAO ) 
              cDescricao:=    aPedido[ nRow ][ 2 ] 
              nPrecoInicial:= aPedido[ nRow ][ 3 ] 
              nPerDesconto:=  aPedido[ nRow ][ 4 ] 
              nPrecoFinal:=   aPedido[ nRow ][ 5 ] 
              nQuantidade:=   aPedido[ nRow ][ 6 ] 
              IF nPrecoFinal > 0 .AND. nPrecoInicial > 0 
                 nPerDesconto:= ( ( nPrecoFinal / nPrecoInicial ) * 100 ) - 100 
              ELSE 
                 nPerDesconto:= 0.00 
              ENDIF 
              nPerDesconto:=  nPerDesconto * (-1) 
              nPerIpi:=       aPedido[ nRow ][ 8 ] 
              cUnidad:=       aPedido[ nRow ][ 7 ] 
              cOrigem:=       aPedido[ nRow ][ 11 ] 
              SetCursor(1) 
              VPBox( 09, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              @ 11,12 Say "Codigo.....: [INDEFINIDO]" 
              @ 12,12 Say "Descri놹o..:" Get cDescricao 
              READ 
              @ 13,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              @ 14,12 Say "Pre뇇......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 15,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 16,12 Say "Pre뇇 Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 17,12 Say "% IPI......:" Get nPerIPI Pict "999.99" 
              READ 
              If LastKey() <> K_ESC .AND. UpDated() 
                 aPedido[ nRow ][ 10 ]:= "Sim" 
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial 
                 aPedido[ nRow ][ 4 ]:= nPerDesconto 
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal 
                 aPedido[ nRow ][ 6 ]:= nQuantidade 
                 aPedido[ nRow ][ 8 ]:= nPerIpi 
                 aPedido[ nRow ][ 7 ]:= cUnidad 
                 aPedido[ nRow ][ 2 ]:= cDescricao 
              EndIf 
              nValorTotal:= 0 
              FOR nCt:= 1 To Len( aPedido ) 
                  nValorTotal:= nValorTotal + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) 
              NEXT 
              ScreenRest( cTelaReserva ) 
              SetColor( _COR_BROWSE ) 
              CalculoGeral( aPedido ) 
              DBSelectar( _COD_PEDIDO ) 
              cCodCot:= Codigo 
              DBSelectar( _COD_PEDPROD ) 
              DBSetOrder( 1 ) 
              nCt:= 0 
              If DBSeek( cCodCot ) 
                 While left( cCodCot, 8 ) == Left( PxP->Codigo, 8 ) 
                     IF ( nPosicao:= AScan( aPedido, {|x| x[12] == Recno() } ) ) > 0 
                     ENDIF 
                     DBUnlockAll() 
                     DBSkip() 
                 EndDo 
              EndIf 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:refreshcurrent() 
      oTb:stabilize() 
   enddo 
 
 
   cCondi_:= Space( 30 ) 
   cPrazo_:= Space( 10 ) 
   nValid_:= 0 
   nTabOpe:= 0 
   cFrete_:= Space( LEN( PED->FRETE_ ) ) 
   nCodTra:= 0 
   cObser1:= Space( 60 ) 
   cObser2:= Space( 60 ) 
   cVende1:= Space( 15 ) 
   cVende2:= Space( 15 ) 
   nVenEx1:= 0 
   cObsNf1:= Space( 40 ) 
 
   IF ! AllTrim( SWSet( _PED_VENDINTERNO ) ) == "" 
      cVende1:= PAD( SWSet( _PED_VENDINTERNO ), 12 ) 
      cVende2:= PAD( SWSet( _PED_VENDEXTERNO ), 12 ) 
   ENDIF 
   nIpi:= 0 
   nTotal:= 0 
   nSubTotal:= 0 
   FOR nCt:= 1 TO Len( aPedido ) 
       IF aPedido[ nCt ][ 10 ] == "Sim" 
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] 
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
       ENDIF 
   NEXT 
   nTotal:= nSubTotal + nIPI 
   VPBox( 02, 04, 20, 77, , _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 04,06 Say "Contato (Nome)............:" Get cCompra Pict "@!" 
   @ 05,06 Say "Codigo da Transportadora..:" Get nCodTra Pict "999" Valid BuscaTransport( @nCodTra ) When Mensagem( "Digite o codigo da transportadora ou [F9] para ver lista." ) 
   @ 06,06 Say "Prazo de Entrega (EM DIAS):" Get cPrazo_ When Mensagem( "Digite o prazo de entrega desta mercadoria." ) 
   @ 07,06 Say "Validade da Proposta......:" Get nValid_ When Mensagem( "Digite o prazo de validade desta proposta em numero de dias." ) 
   @ 08,06 Say "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�" 
   @ 09,06 Say "Operacao..................:" Get nTabOpe Pict "999" Valid  BuscaOperacao( @nTabOpe ) 
   @ 10,06 Say "Tabela de Condicoes.......:" Get nTabCnd Pict "9999" Valid BuscaCondicao( @nTabCnd, @cCondi_, nTotal ) 
   @ 11,06 Say "Detalhamento de Condicoes.:" Get cCondi_ 
   @ 12,06 Say "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�" 
   @ 13,06 Say "Tipo de Frete.............:" Get cFrete_ valid DisplayFrete( @cFrete_ ) When Mensagem( "Digite o tipo de frete ou [ENTER] para ver opcoes." ) 
   @ 14,06 Say "Vendedor Interno..........:" Get nVenIn1 Pict "@R 999" valid VenSeleciona( @nVenIn1, 1, @cVende1 ) When Mensagem( "Digite o codigo do vendedor interno.") 
   @ 14,40 Get cVende1 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." ) 
   @ 15,06 Say "Vendedor Externo..........:" Get nVenEx1 Pict "@R 999" Valid VenSeleciona( @nVenEx1, 2, @cVende2 ) When Mensagem( "Digite o codigo do vendedor interno.") 
   @ 15,40 Get cVende2 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." ) 
   @ 16,06 Say "Observacoes컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴" 
   @ 17,06 Get cObser1 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." ) 
   @ 18,06 Get cObser2 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." ) 
   READ 
 
   nAreaRes:= Select() 
   DBSelectAr( _COD_PEDIDO ) 
   cGarantia:=  GARANT 
   nMaoObra:=   MOBRA_ 
   nOpc1:=      OPC1__ 
   nOpc2:=      OPC2__ 
   nOpc3:=      OPC3__ 
   cTelaRes:=   ScreenSave( 0, 0, 24, 79 ) 
   cCorRes:=    SetColor() 
   nCursorRes:= SetCursor( 1 ) 
   VPBox( 05, 25, 13, 67, " OUTRAS INFORMACOES", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 06,26 Say "Garantia...........:" Get cGarantia Pict "@!" 
   @ 07,26 Say "Mao-de-Obra........:" Get nMaoObra Pict "@E 999,999,999.99" 
   @ 08,26 Say "Opcional (A).......:" Get nOpc1 Pict "@E 999,999.99" 
   @ 09,26 Say "Opcional (B).......:" Get nOpc2 Pict "@E 999,999.99" 
   @ 10,26 Say "Opcional (C).......:" Get nOpc3 Pict "@E 999,999.99" 
   @ 11,26 Say "Valor Frete........:" Get nFrete_ Pict "@E 9,9999,999.99" 
   READ 
   SetCursor( nCursorRes ) 
   ScreenRest( cTelaRes ) 
   SetColor( cCorRes ) 
 
   IF !LastKey()==K_ESC 
      IF Confirma( 0, 0, "Confirma a Gravacao da Cotacao?", "S", "S" ) 
         cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
 
         Aviso("Gerando Cotacao...", 24 / 2 ) 
         Mensagem("Gravando arquivo de Cotacoes, aguarde...") 
 
         DBSelectAr( _COD_PEDIDO ) 
         DBSetOrder( 1 ) 
         dbGoBottom() 
         Tone( 750, 2 ) 
         cCodigo:= StrZero( Val( Codigo ) + 1, 8, 0 ) 
         cCodigo2:= cCodigo 
         nArea:= Select() 
         cCorRes:= SetColor() 
         nCursorRes:= SetCursor() 
         Aviso("Gerando Cotacao.", 24 / 2 ) 
         Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...") 
         nPerAcr:= 0 
         VPBox( 03, 04, 20, 75, , _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
         SetColor( _COR_GET_EDICAO ) 
         SetCursor( 1 ) 
         Set( _SET_DELIMITERS, .F. ) 
 
         /* Guardar o codigo no Arquivo */ 
         Set Printer To "&GDIR\PEDIDOS.VPM"
         Set Device To Printer 
         @ 0,0 SAY "CAMPO: " + cCodigo 
         Set Device To Screen 
         Set Printer To Lpt1 
 
         DBSelectAr( _COD_PEDIDO ) 
         DBSetOrder( 1 ) 
         Tone( 750, 2 ) 
 
         CodigoReserva:= cCodigo 
 
         DBAppend() 
         IF !NetErr() 
            Replace CODIGO With cCodigo, DESCRI With _RESERVADO 
         ELSE 
            Mensagem( "Nao foi possivel gravar o registro..." ) 
            Pausa() 
         ENDIF 
         cCodigo2:= cCodigo 
         DBSelectAR( _COD_PEDIDO ) 
         FechaArea() 
         Mensagem( "Reabrindo arquivo de pedidos, aguarde..." ) 
         IF !FDBUseVpb( _COD_PEDIDO, 2 ) 
            Return Nil 
         ENDIF 
         DBSelectAr( _COD_PEDIDO ) 
         DBSetOrder( 1 ) 
         DBGoBottom() 
 
         nArea:= Select() 
         cCorRes:= SetColor() 
         nCursorRes:= SetCursor() 
         Aviso("Gerando Cotacao.", 24 / 2 ) 
         Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...") 
         nPerAcr:= 0 
         VPBox( 03, 04, 20, 75, , _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
         SetColor( _COR_GET_EDICAO ) 
         SetCursor( 1 ) 
         Set( _SET_DELIMITERS, .F. ) 
 
 
         Set( _SET_DELIMITERS, .T. ) 
         DBSelectar( _COD_PEDIDO ) 
         IF CodigoReserva <> Nil 
            cCodigo:= CodigoReserva 
         ELSE 
            cCodigo:= "< ERRO >" 
         ENDIF 
         SetColor( cCorRes ) 
         SetCursor( nCursorRes ) 
 
         Set( _SET_DELIMITERS, .T. ) 
 
         nVlrTot:= 0 
         FOR nCt:= 1 TO Len( aPedido ) 
             IF aPedido[ nCt ][ 10 ] == "Sim" 
                nVlrIpi:= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
                nVlrTot:= nVlrTot + nVlrIpi + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) 
             ENDIF 
         NEXT 
 
         /* grava as informacoes do pedido */ 
         RLock() 
         IF !NetErr() 
            Replace CodCli With 0,; 
                    Descri With cDescri,; 
                    Endere With cEndere,; 
                    Bairro With cBairro,; 
                    Cidade With cCidade,; 
                    Estado With cEstado,; 
                    Compra With cCompra,; 
                    Transp With nCodTra,; 
                    FonFax With cFonFax,; 
                    VenIn1 With nVenIn1,; 
                    VenEx1 With nVenEx1,; 
                    Select With "Nao",; 
                    Data__ With Date(),; 
                    Situa_ With "COT",; 
                    PerAcr With nPerAcr,; 
                    Condi_ With cCondi_,; 
                    Frete_ With cFrete_,; 
                    Obser1 With cObser1,; 
                    Obser2 With cObser2,; 
                    Prazo_ With cPrazo_,; 
                    Valid_ With nValid_,; 
                    Vende1 With cVende1,; 
                    Vende2 with cVende2,; 
                    Vlrtot With nVlrTot,; 
                    TabCnd With nTabCnd,; 
                    TabOpe With nTabOpe,; 
                    VLRFRE With nFrete_ 
 
            IF NetRLock() 
               Repl GARANT With cGarantia,; 
                    MOBRA_ With nMaoObra,; 
                    OPC1__ With nOpc1,; 
                    OPC2__ With nOpc2,; 
                    OPC3__ With nOpc3 
            ENDIF 
 
            IF EMPTY( CONDI_ ) 
               CND->( DBSetOrder( 1 ) ) 
               IF CND->( DBSeek( nTabCnd ) ) 
                  Replace CONDI_ With StrZero( CND->PARCA_, 3, 0 ) 
               ENDIF 
            ENDIF 
 
            dbUnlock() 
         ENDIF 
         DBUnlockAll() 
         Mensagem( "Gravando arquivo de produtos por PEDIDOS/COTACOES, aguarde..." ) 
         DBSelectar( _COD_PEDPROD ) 
         FOR nCt:= 1 TO Len( aPedido ) 
            IF aPedido[ nCt ][ 10 ] == "Sim" 
               DBAppend() 
               IF NetRLock() 
                  Repl Codigo With cCodigo,; 
                       CodPro With 0,; 
                       CodFab With aPedido[ nCt ][ 1 ],; 
                       Descri With aPedido[ nCt ][ 2 ],; 
                       VlrIni With aPedido[ nCt ][ 3 ],; 
                       PerDes With aPedido[ nCt ][ 4 ],; 
                       VlrUni With aPedido[ nCt ][ 5 ],; 
                       Quant_ With aPedido[ nCt ][ 6 ],; 
                       Unidad With aPedido[ nCt ][ 7 ],; 
                       Select With aPedido[ nCt ][ 10 ],; 
                       IPI___ With aPedido[ nCt ][ 8 ],; 
                       EXIBIR With IF( nCt <= 1, "S", " " ) 
               ENDIF 
            ENDIF 
         NEXT 
         Mensagem("Desmarcando produtos, aguarde...") 
         aPedido:= { NIL } 
 
         SWSet( 5000, .T. ) 
 
         DBSelectar( nArea ) 
 
         Aviso( "Foi gravada a cotacao de numero: " + cCodigo + "...", 24 / 2 ) 
         Mensagem( "Pressione [ENTER] para continuar..." ) 
         Pausa() 
 
         /* Limpa pedido */ 
         aPedido:= 0 
         aPedido:= {} 
 
      ENDIF 
   ENDIF 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   oTbA:RefreshAll() 
   WHILE !oTbA:Stabilize() 
   ENDDO 
   Return Nil 
 
Function AlteraCotacao( oTbA ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local GetList:= {} 
   Local aPedido:= {} 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor( 1 ) 
   Local cDescricao 
   Local nRow:= 1 
   Local nCodigo, cCondi_:= Space( 30 ), cPrazo_:= Space( 10 ), nValid_:= 0,; 
         nTabOpe:= 0, cFrete_:= "", nCodTra:= 0, cObser1:= Space( 60 ),; 
         cObser2:= Space( 60 ), cVende1:= Space( 15 ), cVende2:= Space( 15 ),; 
         nVenEx1:= 0 
 
   VPBox( 00, 00, 22, 79, "ALTERACAO DE COTACAO ", _COR_GET_BOX ) 
   VPBox( 03, 01, 12, 78, , _COR_GET_BOX, .f., .f. ) 
   VPBox( 11, 01, 20, 78, , "15/00", .f., .f., "15/00" ) 
 
   CND->( DBSetOrder( 1 ) ) 
   PRE->( DBSetOrder( 1 ) ) 
 
   nCodigo:= VAL( PED->CODIGO ) 
   dData__:= DATE() 
   cCodCli:= 0 
   cDescri:= PED->DESCRI 
   cEndere:= PED->ENDERE 
   cBairro:= PED->BAIRRO 
   cCidade:= PED->CIDADE 
   cEstado:= PED->ESTADO 
   cFonFax:= PED->FONFAX 
   cCompra:= PED->COMPRA 
   nTabCnd:= PED->TABCND 
   nTotal_:= PED->VLRTOT 
   nVenin1:= PED->VENIN1 
   cVenin1:= PED->VENDE1 
   cFrete_:= PED->FRETE_ 
   nFrete_:= PED->VLRFRE 
 
 
   PXP->( DBSetOrder( 1 ) ) 
   IF PXP->( DBSeek( PED->CODIGO ) ) 
      WHILE PXP->CODIGO==PED->CODIGO 
         AAdd( aPedido, { PXP->CODFAB,; 
                          Left( PXP->DESCRI, 40 ),; 
                          PXP->VLRINI,; 
                          PXP->PERDES,; 
                          PXP->VLRUNI,; 
                          PXP->QUANT_,; 
                          PXP->UNIDAD,; 
                          PXP->IPI___,; 
                          PXP->ORIGEM,; 
                          PXP->SELECT,; 
                          0,; 
                          PXP->VLRUNI,; 
                          0,; 
                          PXP->TABPRE,; 
                          PXP->DESPRE,; 
                          PXP->TABCND,; 
                          0,; 
                          0,; 
                          0 } ) 
         PXP->( DBSkip() ) 
      ENDDO 
   ELSE 
      aPedido:= { { Space( 13 ),; 
                 Space( 40 ),; 
                 0,; 
                 0,; 
                 0,; 
                 0,; 
                 "  ",; 
                 0,; 
                 "   ",; 
                 "Sim",; 
                 "  ",; 
                 0,; 
                 0,; 
                 0,; 
                 0,; 
                 "                                   ",; 
                 "        ",; 
                 0,; 
                 0,; 
                 0 } } 
   ENDIF 
 
   /* PREPARANDO PREVIAMENTE O BROWSE */ 
   SetColor( "15/00,14/01" ) 
   oTb:=TBrowseNew( 12, 2, 19, 77 ) 
   oTb:addcolumn(tbcolumnnew(,{|| aPedido[ nRow ][ 2 ] + ; 
                                " " + aPedido[ nRow ][ 7 ] + " " +; 
                                  Tran( aPedido[ nRow ][ 6 ], "@E 999,999.99" ) + " " +; 
                                  Tran( aPedido[ nRow ][ 5 ], "@E 99,999.999" ) + " " +; 
                                  Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )      +  " " + aPedido[ nRow ][ 10 ] })) 
 
   oTb:AUTOLITE:=.f. 
   oTb:GOTOPBLOCK :={|| nRow:= 1} 
   oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aPedido ) } 
   oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPedido,@nRow)} 
   oTb:dehilite() 
   oTb:RefreshAll() 
   WHILE !oTb:Stabilize() 
   ENDDO 
 
   Keyboard Chr( K_ENTER ) 
   SetColor( _COR_GET_EDICAO ) 
   Mensagem( "Digite as Informacoes do Cliente." ) 
   @ 01,03 Say "Cotacao N�.: [" + StrZero( nCodigo, 8, 0 ) + "]" 
   @ 02,03 Say "Emissao....:" Get dData__ 
   @ 04,03 Say "Cliente....:" Get cDescri 
   @ 05,03 Say "Endereco...:" Get cEndere 
   @ 06,03 Say "Bairro.....:" Get cBairro 
   @ 07,03 Say "Cidade.....:" Get cCidade 
   @ 07,50 Say "-" Get cEstado 
   @ 08,03 Say "Fone/Fax...:" Get cFonFax Pict "@R XXXX-XXXX.XXXX" 
   @ 09,03 Say "Contato....:" Get cCompra 
   READ 
   IF LastKey()==K_ESC 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      DBSelectAr( nArea ) 
      Return Nil 
   ENDIF 
 
   Mensagem("[ESPACO]Seleciona [INS]Novo [ENTER]Altera [DEL]Excluir") 
   SetColor( "15/00,14/01" ) 
   oTb:RefreshAll() 
   WHILE !oTb:Stabilize() 
   ENDDO 
 
   WHILE .T. 
 
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTb:stabilize() 
      end 
 
      SetColor( _COR_BROWSE ) 
      IF ( nTecla:=inkey(0) )==K_ESC 
         EXIT 
      ENDIF 
      DO Case 
         Case Chr( nTecla ) $ "gG" 
              EXIT 
         Case nTecla==K_F12        ;Calculador() 
         Case nTecla==K_UP         ;oTb:up() 
         Case nTecla==K_DOWN       ;oTb:down() 
         Case nTecla==K_LEFT       ;oTb:up() 
         Case nTecla==K_RIGHT      ;oTb:down() 
         Case nTecla==K_PGUP       ;oTb:pageup() 
         Case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         Case nTecla==K_PGDN       ;oTb:pagedown() 
         Case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         Case nTecla==K_INS 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 10, 10, 20, 70, "INCLUSAO DE ITEM", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              SetColor( _COR_GET_EDICAO ) 
              cDescricao:= Space( 40 ) 
              cCodFab:= Space( 13 ) 
              cCodigo:= "0000" 
              cGrupo_:= "000" 
              nPrecoInicial:= 0.00 
              nPerDesconto:=  0.00 
              nPerIPI:= 0.00 
              nPrecoFinal:=   0.00 
              nQuantidade:=   0.00 
              nPrecoInicial:= 0 
              nPrecoFinal:=   0 
              SetCursor(1) 
              @ 11,12 Say "Codigo.....: [INDEFINIDO]" 
              @ 12,12 Say "Descri놹o..:" Get cDescricao 
              READ 
              @ 13,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              @ 14,12 Say "Pre뇇......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 15,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 16,12 Say "Pre뇇 Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 17,12 Say "% IPI......:" Get nPerIPI Pict "999.99" 
              READ 
              If LastKey() <> K_ESC .AND. UpDated() 
                 AAdd( aPedido, { Space( 15 ),; 
                                  Space( 40 ),; 
                                         0.00,; 
                                         0.00,; 
                                         0.00,; 
                                         0.00,; 
                                         Spac( 2 ),; 
                                         0.00,; 
                                         0.00,; 
                                         Space( 3 ),; 
                                         Space( 15 ),; 
                                         0,; 
                                         0,; 
                                         0,; 
                                         0,; 
                                         Space( 40 ),; 
                                         Space( 10 ),; 
                                         0,; 
                                         0,; 
                                         0 } ) 
                 nRow:= Len( aPedido ) 
                 aPedido[ nRow ][ 1 ]:= cCodFab 
                 aPedido[ nRow ][ 2 ]:= cDescricao 
                 aPedido[ nRow ][ 10 ]:= "Sim" 
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial 
                 aPedido[ nRow ][ 4 ]:= nPerDesconto 
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal 
                 aPedido[ nRow ][ 6 ]:= nQuantidade 
                 aPedido[ nRow ][ 8 ]:= nPerIpi 
                 aPedido[ nRow ][ 11 ]:= Space( 3 ) 
                 aPedido[ nRow ][ 15 ]:= 0 
                 aPedido[ nRow ][ 16 ]:= "<INFORMADO MANUALMENTE>" 
                 aPedido[ nRow ][ 17 ]:= PAD( "0000000", 10 ) 
              ENDIF 
              ScreenRest( cTelaReserva ) 
              SetColor( _COR_BROWSE ) 
              CalculoGeral( aPedido ) 
              oTb:RefreshAll() 
              WHILE !oTb:stabilize() 
              ENDDO 
 
         Case nTecla==K_SPACE 
              aPedido[ nRow ][ 10 ]:= If( aPedido[ nRow ][ 10 ]=="Sim", "Nao", "Sim" ) 
              CalculoGeral( aPedido ) 
 
         Case nTecla==K_ENTER 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              SetColor( _COR_GET_EDICAO ) 
              cDescricao:=    aPedido[ nRow ][ 2 ] 
              nPrecoInicial:= aPedido[ nRow ][ 3 ] 
              nPerDesconto:=  aPedido[ nRow ][ 4 ] 
              nPrecoFinal:=   aPedido[ nRow ][ 5 ] 
              nQuantidade:=   aPedido[ nRow ][ 6 ] 
              nPerDesconto:=  ( ( nPrecoFinal / nPrecoInicial ) * 100 ) - 100 
              nPerDesconto:=  nPerDesconto * (-1) 
              nPerIpi:=       aPedido[ nRow ][ 8 ] 
              cUnidad:=       aPedido[ nRow ][ 7 ] 
              cOrigem:=       aPedido[ nRow ][ 11 ] 
              SetCursor(1) 
              VPBox( 09, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              @ 11,12 Say "Codigo.....: [INDEFINIDO]" 
              @ 12,12 Say "Descri놹o..:" Get cDescricao 
              READ 
              @ 13,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              @ 14,12 Say "Pre뇇......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 15,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 16,12 Say "Pre뇇 Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
              @ 17,12 Say "% IPI......:" Get nPerIPI Pict "999.99" 
              READ 
              If !( LastKey()==K_ESC ) 
                 aPedido[ nRow ][ 10 ]:= "Sim" 
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial 
                 aPedido[ nRow ][ 4 ]:= nPerDesconto 
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal 
                 aPedido[ nRow ][ 6 ]:= nQuantidade 
                 aPedido[ nRow ][ 8 ]:= nPerIpi 
                 aPedido[ nRow ][ 7 ]:= cUnidad 
                 aPedido[ nRow ][ 2 ]:= cDescricao 
              EndIf 
              nValorTotal:= 0 
              FOR nCt:= 1 To Len( aPedido ) 
                  nValorTotal:= nValorTotal + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) 
              NEXT 
              ScreenRest( cTelaReserva ) 
              SetColor( _COR_BROWSE ) 
              CalculoGeral( aPedido ) 
              DBSelectar( _COD_PEDIDO ) 
              cCodCot:= Codigo 
              DBSelectar( _COD_PEDPROD ) 
              DBSetOrder( 1 ) 
              nCt:= 0 
              If DBSeek( cCodCot ) 
                 While left( cCodCot, 8 ) == Left( PxP->Codigo, 8 ) 
                     IF ( nPosicao:= AScan( aPedido, {|x| x[12] == Recno() } ) ) > 0 
                     ENDIF 
                     DBUnlockAll() 
                     DBSkip() 
                 EndDo 
              EndIf 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:refreshcurrent() 
      oTb:stabilize() 
   enddo 
 
   cCondi_:= PED->CONDI_ 
   cPrazo_:= PED->PRAZO_ 
   nValid_:= PED->VALID_ 
   nTabOpe:= PED->TABOPE 
   nCodTra:= PED->TRANSP 
   cObser1:= PED->OBSER1 
   cObser2:= PED->OBSER2 
   cVende1:= PED->VENDE1 
   cVende2:= PED->VENDE2 
   nVenEx1:= PED->VENEX1 
   cObsNf1:= PED->OBSNF1 
   nIpi:= 0 
   nTotal:= 0 
   nSubTotal:= 0 
   FOR nCt:= 1 TO Len( aPedido ) 
       IF aPedido[ nCt ][ 10 ] == "Sim" 
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] 
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
       ENDIF 
   NEXT 
   nTotal:= nSubTotal + nIPI 
   VPBox( 02, 04, 20, 77, , _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 04,06 Say "Contato (Nome)............:" Get cCompra Pict "@!" 
   @ 05,06 Say "Codigo da Transportadora..:" Get nCodTra Pict "999" Valid BuscaTransport( @nCodTra ) When Mensagem( "Digite o codigo da transportadora ou [F9] para ver lista." ) 
   @ 06,06 Say "Prazo de Entrega (EM DIAS):" Get cPrazo_ When Mensagem( "Digite o prazo de entrega desta mercadoria." ) 
   @ 07,06 Say "Validade da Proposta......:" Get nValid_ When Mensagem( "Digite o prazo de validade desta proposta em numero de dias." ) 
   @ 08,06 Say "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�" 
   @ 09,06 Say "Operacao..................:" Get nTabOpe Pict "999" Valid  BuscaOperacao( @nTabOpe ) 
   @ 10,06 Say "Tabela de Condicoes.......:" Get nTabCnd Pict "9999" Valid BuscaCondicao( @nTabCnd, @cCondi_, nTotal ) 
   @ 11,06 Say "Detalhamento de Condicoes.:" Get cCondi_ 
   @ 12,06 Say "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�" 
   @ 13,06 Say "Tipo de Frete.............:" Get cFrete_ valid DisplayFrete( @cFrete_ ) When Mensagem( "Digite o tipo de frete ou [ENTER] para ver opcoes." ) 
   @ 14,06 Say "Vendedor Interno..........:" Get nVenIn1 Pict "@R 999" valid VenSeleciona( @nVenIn1, 1, @cVende1 ) When Mensagem( "Digite o codigo do vendedor interno.") 
   @ 14,40 Get cVende1 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." ) 
   @ 15,06 Say "Vendedor Externo..........:" Get nVenEx1 Pict "@R 999" Valid VenSeleciona( @nVenEx1, 2, @cVende2 ) When Mensagem( "Digite o codigo do vendedor interno.") 
   @ 15,40 Get cVende2 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." ) 
   @ 16,06 Say "Observacoes컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴" 
   @ 17,06 Get cObser1 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." ) 
   @ 18,06 Get cObser2 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." ) 
   Read 
 
   nAreaRes:= Select() 
   DBSelectAr( _COD_PEDIDO ) 
   cGarantia:=  PED->GARANT 
   nMaoObra:=   PED->MOBRA_ 
   nOpc1:=      PED->OPC1__ 
   nOpc2:=      PED->OPC2__ 
   nOpc3:=      PED->OPC3__ 
   cFrete:=     PED->FRETE_ 
   cTelaRes:=   ScreenSave( 0, 0, 24, 79 ) 
   cCorRes:=    SetColor() 
   nCursorRes:= SetCursor( 1 ) 
   VPBox( 05, 25, 13, 67, " OUTRAS INFORMACOES", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 06,26 Say "Garantia...........:" Get cGarantia Pict "@!" 
   @ 07,26 Say "Mao-de-Obra........:" Get nMaoObra Pict "@E 999,999,999.99" 
   @ 08,26 Say "Opcional (A).......:" Get nOpc1 Pict "@E 999,999.99" 
   @ 09,26 Say "Opcional (B).......:" Get nOpc2 Pict "@E 999,999.99" 
   @ 10,26 Say "Opcional (C).......:" Get nOpc3 Pict "@E 999,999.99" 
   @ 11,26 Say "Valor Frete........:" Get nFrete_ Pict "@E 9,9999,999.99" 
   READ 
   SetCursor( nCursorRes ) 
   ScreenRest( cTelaRes ) 
   SetColor( cCorRes ) 
 
   IF !LastKey()==K_ESC 
      IF Confirma( 0, 0, "Confirma a Gravacao da Cotacao?", "S", "S" ) 
         cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
         DBSelectar( _COD_PEDIDO ) 
         DBSetOrder( 1 ) 
         Aviso("Gerando Cotacao...", 24 / 2 ) 
         Mensagem("Gravando arquivo de Cotacoes, aguarde...") 
         DBSelectAr( _COD_PEDIDO ) 
         DBSetOrder( 1 ) 
         cCodigo:= StrZero( Val( Codigo ), 8, 0 ) 
         nArea:= Select() 
         cCorRes:= SetColor() 
         nCursorRes:= SetCursor() 
         Aviso("Gerando Cotacao.", 24 / 2 ) 
         Mensagem("Gravando arquivo de COTACOES, aguarde...") 
         nPerAcr:= 0 
 
         nVlrTot:= 0 
         FOR nCt:= 1 TO Len( aPedido ) 
             IF aPedido[ nCt ][ 10 ]=="Sim" 
                nVlrIpi:= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
                nVlrTot:= nVlrTot + nVlrIpi + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) 
             ENDIF 
         NEXT 
 
         /* grava as informacoes do pedido */ 
         IF NetRLock() 
            Replace CodCli With 0,; 
                    Descri With cDescri,; 
                    Endere With cEndere,; 
                    Bairro With cBairro,; 
                    Cidade With cCidade,; 
                    Estado With cEstado,; 
                    Compra With cCompra,; 
                    Transp With nCodTra,; 
                    FonFax With cFonFax,; 
                    VenIn1 With nVenIn1,; 
                    VenEx1 With nVenEx1,; 
                    Select With "Nao",; 
                    Data__ With Date(),; 
                    Situa_ With "COT",; 
                    PerAcr With nPerAcr,; 
                    Condi_ With cCondi_,; 
                    Frete_ With cFrete_,; 
                    Obser1 With cObser1,; 
                    Obser2 With cObser2,; 
                    Prazo_ With cPrazo_,; 
                    Valid_ With nValid_,; 
                    Vende1 With cVende1,; 
                    Vende2 with cVende2,; 
                    Vlrtot With nVlrTot,; 
                    TabCnd With nTabCnd,; 
                    TabOpe With nTabOpe,; 
                    VLRFRE With nFrete_ 
 
            IF NetRLock() 
               Repl GARANT With cGarantia,; 
                    MOBRA_ With nMaoObra,; 
                    OPC1__ With nOpc1,; 
                    OPC2__ With nOpc2,; 
                    OPC3__ With nOpc3 
            ENDIF 
 
            IF EMPTY( CONDI_ ) 
               CND->( DBSetOrder( 1 ) ) 
               IF CND->( DBSeek( nTabCnd ) ) 
                  Replace CONDI_ With StrZero( CND->PARCA_, 3, 0 ) 
               ENDIF 
            ENDIF 
 
            dbUnLock() 
         ENDIF 
         DBUnlockAll() 
         Mensagem( "Gravando arquivo de produtos por PEDIDOS/COTACOES, aguarde..." ) 
 
         DBSelectar( _COD_PEDPROD ) 
         DBSetOrder( 1 ) 
         DBSeek( PED->CODIGO ) 
         WHILE PXP->CODIGO==PED->CODIGO .AND. !PXP->( EOF() ) 
             IF NetRLock() 
                DBDelete() 
             ENDIF 
             DBSkip() 
         ENDDO 
         DBUnlockAll() 
 
         FOR nCt:= 1 TO Len( aPedido ) 
            IF aPedido[ nCt ][ 10 ]=="Sim" 
               DBAppend() 
               IF NetRlock() 
                  Repl CODIGO With cCodigo,; 
                       CODPRO With 0,; 
                       CODFAB With aPedido[ nCt ][ 1 ],; 
                       DESCRI With aPedido[ nCt ][ 2 ],; 
                       VLRINI With aPedido[ nCt ][ 3 ],; 
                       PERDES With aPedido[ nCt ][ 4 ],; 
                       VLRUNI With aPedido[ nCt ][ 5 ],; 
                       QUANT_ With aPedido[ nCt ][ 6 ],; 
                       UNIDAD With aPedido[ nCt ][ 7 ],; 
                       SELECT With aPedido[ nCt ][ 10 ],; 
                       IPI___ With aPedido[ nCt ][ 8 ],; 
                       EXIBIR With IF( nCt <= 1, "S", " " ) 
               ENDIF 
            ENDIF 
         NEXT 
         Mensagem("Desmarcando produtos, aguarde...") 
         aPedido:= { NIL } 
 
         SWSet( 5000, .T. ) 
 
         DBSelectar( nArea ) 
 
         /* Limpa pedido */ 
         aPedido:= 0 
         aPedido:= {} 
 
      ENDIF 
   ENDIF 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   oTbA:RefreshAll() 
   WHILE !oTbA:Stabilize() 
   ENDDO 
   Return Nil 
 
 
 
 
 
 
 
 
 
 
 
