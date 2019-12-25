// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC88800 
� Finalidade  � Edicao de  Pedido em Formato CPD 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc88800()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nRow:= 1 
Local nPedido:= 0, nCodCli:= 0, nPrazo:= 0, nEmitDest:= 1,; 
      nCodTra:= 0, nVenIn:= 0, nVenEx:= 0, nTabFat:= 0, nTabPre:= 0,; 
      aProdutos:= {}, nCodOpe:= 0,; 
      cObsNf1:= Space( 40 ), cObsNf2:= Space( 40 ), cObsNf3:= Space( 40 ),; 
      cObsNf4:= Space( 40 ), nBanco:= 1 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 10, 79, "Edicao de Pedidos", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
   VPBox( 11, 00, 22, 79, "Produtos", _COR_BROW_BOX, .F., .F. ) 
   Mensagem("[INS]Novo [ESPACO]Seleciona, [ENTER]Altera [G]Gerar e [ESC]Sai") 
 
   WHILE .T. 
      DBSelectAr( _COD_PEDIDO ) 
      PED->( DBSetOrder( 6 ) ) 
      PED->( DBSeek( "99999999" ) ) 
      PED->( DBSkip( -1 ) ) 
      nPedido:= VAL( PED->CODPED ) + 1 
 
      SetColor( _COR_GET_EDICAO ) 
      nTabPre:= PRE->CODIGO 
      nTabFat:= CND->CODIGO 
      aProdutos:= 0 
      aProdutos:= {} 
      nRow:= 1 
      AAdd( aProdutos, { 0,; 
                         Space( 13 ),; 
                         Space( 45 ),; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         Space( 2 ),; 
                         0,; 
                         0,; 
                         0,; 
                         Space( 3 ),; 
                         Recno(),; 
                         0,; 
                         0,; 
                         0,; 
                         Space( 40 ),; 
                         0,; 
                         "Sim" } ) 
      Scroll( 02, 02, 09, 78 ) 
      nBanco:= 1 
      @ 02,02 Say "Pedido.........:" Get nPedido Pict "99999999" Valid PedidoExiste( @nPedido ) 
      @ 03,02 Say "Cliente........:" Get nCodCli Pict "999999"   Valid BuscaCliente( @nCodCli, @nTabPre, @nVenin, @nVenEx, @nCodTra ) 
      @ 04,02 Say "Operacao.......:" Get nCodOpe Pict "999"      Valid TabelaOperacoes( @nCodOpe ) 
      @ 05,02 Say "Vend.Interno...:" Get nVenIn Pict "999"       Valid CodVen( @nVenin, Nil ) 
      @ 06,02 Say "Vend.Externo...:" Get nVenEx pict "999"       Valid CodVen( Nil, @nVenEx ) 
      @ 07,02 Say "Prazo em dias..:" Get nPrazo Pict "99999"     When Prazo( @nPrazo ) Valid VerPrazo( @nPrazo ) 
      @ 08,02 Say "Transportadora.:" Get nCodTra Pict "999"      Valid BuscaTransport( @nCodTra ) When Mensagem( "Selecione a transportadora." ) 
      @ 09,02 Say "Frete-Emit/Dest:" Get nEmitDest Pict "9" 
//      @ 09,50 Say "Carteira/Banco.:" Get nBanco Pict "9" Valid nBanco == 1 .OR. nBanco == 0 When Mensagem( "Digite [0] para carteira ou [1] para banco." ) 
      READ 
      IF LastKey() == K_ESC 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
      nTabPre:= OPE->TABPRE 
      nTabFat:= OPE->TABCND 
      BuscaPreco( @nTabPre ) 
      BuscaCondicoes( @nTabFat, nPrazo, nVenIn, nVenEx ) 
      SetColor( _COR_BROWSE ) 
      oTb:=TBrowseNew( 12, 1, 20, 78 ) 
      oTb:addcolumn(tbcolumnnew(,{|| StrZero( aProdutos[ nRow ][ 1 ], 7, 0 ) } )) 
      oTb:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 2 ] } )) 
      oTb:addcolumn(tbcolumnnew(,{|| Left( aProdutos[ nRow ][ 3 ], 17 ) } )) 
      oTb:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 8 ] } )) 
      oTb:addcolumn(tbcolumnnew(,{|| Tran( aProdutos[ nRow ][ 7 ], "@E 9,999,999.99" ) } )) 
      oTb:addcolumn(tbcolumnnew(,{|| Tran( aProdutos[ nRow ][ 6 ], "@E 9999,999.999" ) } )) 
      oTb:addcolumn(tbcolumnnew(,{|| Tran( aProdutos[ nRow ][ 9 ], "@E 99.99" ) } )) 
      oTb:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 19 ] })) 
      oTb:AUTOLITE:=.f. 
      oTb:GOTOPBLOCK :={|| nRow:= 1} 
      oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aProdutos ) } 
      oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aProdutos,@nRow)} 
      oTb:dehilite() 
      Keyboard Chr( K_INS ) 
      whil .t. 
         oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,7},{2,1}) 
         whil nextkey()==0 .and. ! oTb:stabilize() 
         end 
         nTecla:=inkey(0) 
         if nTecla==K_ESC 
            exit 
         endif 
         do case 
            case Chr( nTecla ) $ "0123456789" 
            case nTecla==K_INS 
                 IF aProdutos[ 1 ][ 1 ] > 0 
                    AAdd( aProdutos, { 0,; 
                          Space( 13 ),; 
                          Space( 45 ),; 
                          0,; 
                          0,; 
                          0,; 
                          0,; 
                          Space( 2 ),; 
                          0,; 
                          0,; 
                          0,; 
                          Space( 3 ),; 
                          Recno(),; 
                          0,; 
                          0,; 
                          0,; 
                          Space( 40 ),; 
                          0,; 
                          "Sim" } ) 
                 ENDIF 
                 oTb:GoBottom() 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
                 nLin:= Row() 
                 nCodPro:= 0 
                 nQuantidade:= 0 
                 nPreco:= 0 
                 nPreco1:= 0 
                 nPreco2:= 0 
                 Set( _SET_DELIMITERS, .F. ) 
                 PRE->( DBSetOrder( 1 ) ) 
                 PRE->( DBSeek( OPE->TABPRE ) ) 
                 CND->( DBSetOrder( 1 ) ) 
                 CND->( DBSeek( OPE->TABCND ) ) 
                 @ nLin, 01 Get nCodPro Pict "9999999"             Valid BuscaProduto( @nCodPro, @nPreco, @nPreco1, @nPreco2 ) 
                 @ nLin, 43 Get nQuantidade Pict "@E 9999,999.999" Valid TestaQuantidade( nQuantidade ) 
                 @ nLin, 56 Get nPreco Pict "@E 999,999,999.99"    Valid TestaPreco( nPreco ) 
                 READ 
                 aProdutos[ nRow ][ 1 ]:=  nCodPro 
                 aProdutos[ nRow ][ 7 ]:=  nQuantidade 
                 aProdutos[ nRow ][ 4 ]:=  PrecoConvertido() 
                 aProdutos[ nRow ][ 5 ]:=  (( nPreco / PrecoConvertido() ) * 100 ) - 100 
                 aProdutos[ nRow ][ 5 ]:= aProdutos[ nRow ][ 5 ] * (-1) 
                 aProdutos[ nRow ][ 6 ]:=  nPreco 
                 aProdutos[ nRow ][ 11 ]:= nCodPro 
                 MPR->( DBSetOrder( 1 ) ) 
                 IF MPR->( DBSeek( PAD( StrZero( nCodPro, 7, 0 ), 12 ) ) ) 
                    aProdutos[ nRow ][ 2 ]:= MPR->CODFAB 
                    aProdutos[ nRow ][ 3 ]:= MPR->DESCRI 
                    aProdutos[ nRow ][ 8 ]:= MPR->UNIDAD 
                    aProdutos[ nRow ][ 14 ]:= nPreco1 
                    aProdutos[ nRow ][ 15 ]:= nPreco2 
                    aProdutos[ nRow ][ 16 ]:= PRE->CODIGO 
                    aProdutos[ nRow ][ 17 ]:= PRE->DESCRI 
                    aProdutos[ nRow ][ 18 ]:= OPE->TABCND 
                    aProdutos[ nRow ][ 11 ]:= VAL( MPR->INDICE ) 
                 ENDIF 
                 Set( _SET_DELIMITERS, .T. ) 
                 IF !LastKey() == K_ESC 
                    Keyboard Chr( K_INS ) 
                 ELSE 
                    IF Len( aProdutos ) > 1 
                       ASize( aProdutos, Len( aProdutos ) - 1 ) 
                    ENDIF 
                    oTb:RefreshAll() 
                    WHILE !oTb:Stabilize() 
                    ENDDO 
                 ENDIF 
                 CalculoGeral( aProdutos ) 
            case Chr( nTecla ) $ "Oo" 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 VPBox( 12, 12, 18, 60, " OBSERVACOES NA NOTA FISCAL ", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 lConf:= Set( _SET_CONFIRM, .F. ) 
                 lDelimiter:= Set( _SET_DELIMITERS, .F. ) 
                 @ 13,13 Get cObsNf1 
                 @ 14,13 Get cObsNf2 
                 @ 15,13 Get cObsNf3 
                 @ 16,13 Get cObsNf4 
                 READ 
                 Set( _SET_DELIMITERS, lDelimiter ) 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 Set( _SET_CONFIRM, lConf ) 
            case nTecla==K_F12        ;Calculador() 
            CASE nTecla==K_CTRL_F10   ;Calendar() 
            case nTecla==K_UP         ;oTb:up() 
            case nTecla==K_DOWN       ;oTb:down() 
            case nTecla==K_LEFT       ;oTb:up() 
            case nTecla==K_RIGHT      ;oTb:down() 
            case nTecla==K_PGUP       ;oTb:pageup() 
            case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
            case nTecla==K_PGDN       ;oTb:pagedown() 
            case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
            case Chr( nTecla ) $ "Gg" .OR. nTecla==K_F1 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 nArea:= Select() 
                 Aviso("Gerando pedido...", 24 / 2 ) 
                 Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...") 
                 DBSelectar( _COD_PEDIDO ) 
                 DBSetOrder( 1 ) 
                 cCodigo:= StrZero( nPedido, 8, 0 ) 
                 IF !DBSeek( cCodigo ) 
                    DBAppend() 
                 ELSE 
                    IF !AllTrim( DESCRI ) == "<< REGISTRO RESERVADO >> - CPD" 
                       PedidoExiste( @nPedido ) 
                       cCodigo:= StrZero( nPedido, 8, 0 ) 
                       DBAppend() 
                    ENDIF 
                 ENDIF 
                 RLock() 
                 If !NetErr() 
                     Replace Codigo With cCodigo,; 
                             CodPed With cCodigo,; 
                             CodCli With Cli->Codigo,; 
                             Descri With Cli->Descri,; 
                             Endere With Cli->Endere,; 
                             Bairro With Cli->Bairro,; 
                             Cidade With Cli->Cidade,; 
                             Estado With Cli->Estado,; 
                             Compra With Cli->Compra,; 
                             Cobran With Cli->Cobran,; 
                             CGCMf_ With Cli->CGCMf_,; 
                             Inscri With Cli->Inscri,; 
                             Transp With nCodTra,; 
                             FonFax With Cli->Fone1_ + " / " + Cli->Fax___,; 
                             CodCep With Cli->CodCep,; 
                             VenIn1 With nVenIn,; 
                             VenEx1 With nVenEx,; 
                             Select With "Nao",; 
                             Data__ With Date(),; 
                             Situa_ With "PED",; 
                             Condi_ With StrZero( nPrazo, 4, 0 ),; 
                             TabCnd With nTabFat,; 
                             TabOpe With nCodOpe,; 
                             OBSNF1 With cObsNF1,; 
                             OBSNF2 With cObsNF2,; 
                             OBSNF3 With cObsNF3,; 
                             OBSNF4 With cObsNF4,; 
                             BANCO_ With nBanco 
                 EndIf 
                 DBUnlock() 
                 Mensagem( "Gravando arquivo de produtos por PEDIDOS/COTACOES, aguarde..." ) 
                 DBSelectar( _COD_PEDPROD ) 
                 DBSeek( cCodigo ) 
                 WHILE Codigo == cCodigo 
                       RLock() 
                       IF !NetErr() 
                           dele 
                           DBSkip() 
                       ENDIF 
                       DBUnlock() 
                 ENDDO 
                 For nCt:= 1 To Len( aProdutos ) 
                     IF aProdutos[ nCt ][ 19 ] == "Sim" 
                        DBAppend() 
                        RLock() 
                        If !NetErr() 
                           Repl  Codigo With cCodigo,; 
                                 CodPro With aProdutos[ nCt ][ 1 ],; 
                                 CodFab With aProdutos[ nCt ][ 2 ],; 
                                 Descri With aProdutos[ nCt ][ 3 ],; 
                                 VlrIni With aProdutos[ nCt ][ 4 ],; 
                                 PerDes With aProdutos[ nCt ][ 5 ],; 
                                 VlrUni With aProdutos[ nCt ][ 6 ],; 
                                 Quant_ With aProdutos[ nCt ][ 7 ],; 
                                 Unidad With aProdutos[ nCt ][ 8 ],; 
                                 IPI___ With aProdutos[ nCt ][ 9 ],; 
                                 SELECT With aProdutos[ nCt ][ 19 ],; 
                                 PRECO1 With aProdutos[ nCt ][ 14 ],; 
                                 PRECO2 With aProdutos[ nCt ][ 15 ],; 
                                 TABPRE With aProdutos[ nCt ][ 16 ],; 
                                 DESPRE With aProdutos[ nCt ][ 17 ],; 
                                 TABCND With aProdutos[ nCt ][ 18 ] 
                        EndIf 
                        DBUnlock() 
                     ENDIF 
                 Next 
                 Mensagem("Desmarcando produtos, aguarde...") 
                 LimpaMarcas( aProdutos ) 
                 aProdutos:= {} 
                 DBSelectar( nArea ) 
                 ScreenRest( cTelaRes ) 
                 cObsNf1:= Space( 40 ) 
                 cObsNf2:= Space( 40 ) 
                 cObsNf3:= Space( 40 ) 
                 cObsNf4:= Space( 40 ) 
                 Exit 
            case nTecla==K_SPACE 
                 aProdutos[ nRow ][ 19 ]:= If( aProdutos[ nRow ][ 19 ]=="Sim", "Nao", "Sim" ) 
                 CalculoGeral( aProdutos ) 
            case nTecla==K_ENTER 
                 MPR->( DBSetOrder( 1 ) ) 
                 MPR->( DBSeek( PAD( StrZero( aProdutos[ nRow ][ 1 ], 7, 0 ), 12 ) ) ) 
                 cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
                 VPBox( 09, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
                 SetColor( _COR_GET_EDICAO ) 
                 nPrecoInicial:= aProdutos[ nRow ][ 4 ] 
                 nPerDesconto:= aProdutos[ nRow ][ 5 ] 
                 nPrecoFinal:= aProdutos[ nRow ][ 6 ] 
                 nQuantidade:= aProdutos[ nRow ][ 7 ] 
                 cOrigem:= aProdutos[ nRow ][ 10 ] 
                 SetCursor(1) 
                 Keyboard Chr( K_ENTER ) + Chr( K_ENTER ) 
                 @ 10,12 Say "Produto....: [" + aProdutos[ nRow ][ 2 ] + "]" 
                 @ 11,12 Say "Descri��o..: [" + LEFT( aProdutos[ nRow ][ 3 ], 40 ) + "]" 
                 @ 12,12 Say "Fabricante.:" Get cOrigem Pict "XXXXXXXXXXXXXX" when Mensagem( "Digite a origem do produto." ) 
                 @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco() .AND. Mensagem( "Digite o preco de venda para o produto." ) 
                 @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
                 @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999"  Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal ) 
                 VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
                 @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" Valid TestaQuantidade( nQuantidade ) 
                 Read 
                 If LastKey() <> K_ESC .AND. UpDated() 
                    aProdutos[ nRow ][ 19 ]:= "Sim" 
                    aProdutos[ nRow ][ 4 ]:= nPrecoInicial 
                    aProdutos[ nRow ][ 5 ]:= nPerDesconto 
                    aProdutos[ nRow ][ 6 ]:= nPrecoFinal 
                    aProdutos[ nRow ][ 7 ]:= nQuantidade 
                    aProdutos[ nRow ][ 10 ]:= cOrigem 
                 EndIf 
                 ScreenRest( cTelaReserva ) 
                 SetColor( _COR_BROWSE ) 
                 CalculoGeral( aProdutos ) 
         otherwise                ;tone(125); tone(300) 
         endcase 
         oTb:refreshcurrent() 
         oTb:stabilize() 
      ENDDO 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
/* 
* Modulo      - COTACAO 
* Parametro   - Nenhum 
* Finalidade  - Verificacao/Manutencao de Cotacao. 
* Programador - Valmor Pereira Flores 
* Data        - 26/Outubro/1995 
* Atualizacao - 
*/ 
Static Func Cotacao( aProdutos ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Loca oTb, cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 ),; 
     nRow:=1,; 
     nSubTotal:= 0, nTotal:= 0, nIPI:= 0, nCt:= 0 
 
DispBegin() 
SetColor( _COR_BROWSE ) 
VPBox( 0, 0, 22, 79, "Cotacao", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. ) 
@ 1, 1 Say "Pedido.....: " 
@ 2, 1 Say "Codigo.....: " + StrZero( CLI->Codigo, 4, 0 ) 
@ 3, 1 Say "Cliente....: " + Cli->Descri 
@ 4, 1 Say "Endere�o...: " + Cli->Endere 
@ 5, 1 Say "Cidade.....: " + Cli->Cidade 
@ 6, 1 Say "Contato....: " + Cli->Compra 
@ 7, 1 Say "Fone/Fax...: " + Cli->Fone1_ + " / " + Cli->Fax___ 
@ 8, 1 Say "Transportad: " + StrZero( Cli->Transp, 3, 0 ) 
SetColor( _COR_BROW_TITULO ) 
Scroll( 9, 0, 9, 79 ) 
@ 09, 01 Say "Produto" 
@ 09, 33 Say "Un" 
@ 09, 37 Say "Quantidade" 
@ 09, 53 Say "Preco Unit�rio" 
@ 09, 68 Say "%IPI" 
DispEnd() 
CalculoGeral( aProdutos ) 
SetCursor( 0 ) 
 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
setcursor(1) 
setcolor(cCor) 
ScreenRest( cTela ) 
return(if(nTecla=27,.f.,.t.)) 
 
/* 
* Modulo      - CalculoGeral 
* Finalidade  - Apresentar no rodap� o calculo total do pedido 
* Programador - Valmor Pereira Flores 
* Data        - 26/Outubro/1995 
* Atualizacao - 
*/ 
Static Function CalculoGeral( aProdutos ) 
Local cCor:= SetColor() 
Local nSubTotal:= 0, nIPI:= 0, nTotal:= 0 
   DispBegin() 
   SetColor( "W+/G" ) 
   Scroll( 21, 1, 22, 78 ) 
   For nCt:= 1 To Len( aProdutos ) 
       If aProdutos[ nCt ][ 19 ] == "Sim" 
          nSubTotal+= aProdutos[ nCt ][ 6 ] * aProdutos[ nCt ][ 7 ] 
          nIPI+= ( ( aProdutos[ nCt ][ 6 ] * aProdutos[ nCt ][ 7 ] ) * aProdutos[ nCt ][ 9 ] ) / 100 
       EndIf 
   Next 
   nTotal:= nSubTotal + nIPI 
   @ 21, 01 Say "Sub-Total..: " + Tran( nSubTotal, "@E 999,999,999,999.99" ) 
   @ 22, 01 Say "Valor IPI..: " + Tran( nIPI,      "@E 999,999,999,999.99" ) 
   @ 22, 47 Say "Total Geral: " + Tran( nTotal,    "@E 999,999,999,999.99" ) 
   SetColor( cCor ) 
   DispEnd() 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerGrupo 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerGrupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      Return( .T. ) 
   EndIf 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 ) 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
/***** 
�������������Ŀ 
� Funcao      � BuscaProduto 
� Finalidade  � Busca Produt/Precos na tabela 
� Parametros  � nCodPro, nPreco, nPreco1, nPreco2 
� Retorno     � .T./.F. 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function BuscaProduto( nCodPro, nPreco, nPreco1, nPreco2 ) 
Local nRow:= ROW(), nCol:= COL(), cProduto:= PAD( StrZero( nCodPro, 7, 0 ), 12 ) 
   MPR->( DBSetOrder( 1 ) ) 
   IF !MPR->( DBSeek( cProduto ) ) 
      IF Val( cProduto ) > 0 .AND. !Val( cProduto ) == 9999999 
         Tone( 700, 2 ) 
         Return .F. 
      ENDIF 
      VisualProdutos( @cProduto ) 
      cProduto:= MPR->INDICE 
      IF LastKey() == K_ESC 
         Return .F. 
      ENDIF 
   ENDIF 
   @ nRow, nCol Say Space(0) 
   @ Row(), 23 Say Left( MPR->DESCRI, 17 ) 
   TAX->( DBSetOrder( 2 ) ) 
   TAX->( DBSeek( cProduto ) ) 
   WHILE !PRE->CODIGO == TAX->CODIGO .AND. !TAX->CODPRO == cProduto 
      TAX->( DBSkip() ) 
      IF TAX->( EOF() ) 
         EXIT 
      ENDIF 
   ENDDO 
   nCodPro:= VAL( cProduto ) 
   IF !TAX->( EOF() ) .AND. PRE->CODIGO == TAX->CODIGO 
      nPreco:= PrecoCnd( OPE->TABCND, PrecoCompra( cProduto ), TAX->MARGEM ) 
   ELSE 
      Tone( 280, 2 ) 
      nPreco:= PrecoCnd( OPE->TABCND ) 
   ENDIF 
   Return .T. 
 
Static Function BuscaPreco( nTabPre ) 
Local cCor:= SetColor() 
PRE->( DBSetOrder( 1 ) ) 
IF !PRE->( DBSeek( nTabPre ) ) 
   TabelaPreco() 
   nTabPre:= PRE->CODIGO 
ENDIF 
SetColor( "14/01" ) 
@ 02,30 Say "Cl..: " + ALLTRIM( CLI->DESCRI ) 
@ 03,30 Say "Tab.: " + ALLTRIM( PRE->DESCRI ) 
SetColor( cCor ) 
Return .T. 
 
Static Function BuscaCondicoes( nTabFat, nPrazo, nVenIn, nVenEx ) 
Local cCor:= SetColor() 
CND->( DBSetOrder( 1 ) ) 
IF !CND->( DBSeek( nTabFat ) ) 
   TabelaCondicoes( 0 ) 
ENDIF 
nTabFat:= CND->CODIGO 
nPrazo:=  CND->PARCA_ 
SetColor( "14/01" ) 
@ 04,30 Say "Cond: " + Alltrim( CND->DESCRI ) 
@ 05,30 Say "Oper: " + ALLTRIM( OPE->DESCRI ) 
VEN->( DBSetOrder( 1 ) ) 
VEN->( DBSeek( nVenIn ) ) 
@ 06,30 Say "Int.: " + ALLTRIM( VEN->DESCRI ) 
VEN->( DBSeek( nVenEx ) ) 
@ 07,30 Say "Ext.: " + ALLTRIM( VEN->DESCRI ) 
SetColor( cCor ) 
Return .T. 
 
Static Function CodVen( nVenIn, nVenEx ) 
IF !nVenIn == Nil 
   IF nVenIn > 0 
      Tone( 700, 3 ) 
   ENDIF 
ENDIF 
Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � PRAZO 
� Finalidade  � Busca o prazo conforme a tabela de condicoes que esta 
�             � referenciada na tabela de operacoes 
� Parametros  � nPrazo 
� Retorno     � .T. 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function Prazo( nPrazo ) 
CND->( DBSetOrder( 1 ) ) 
IF CND->( DBSeek( OPE->TABCND ) ) 
   nPrazo:= CND->PARCA_ 
ENDIF 
Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � VerPrazo 
� Finalidade  � Fazer uma verificacao no prazo digitado 
� Parametros  � nPrazo = Prazo Digitado 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function VerPrazo( nPrazo ) 
CND->( DBSetOrder( 1 ) ) 
IF CND->( DBSeek( OPE->TABCND ) ) 
   IF LastKey() == K_TAB .AND. !nPrazo == CND->PARCA_ 
      Tone( 200, 2 ) 
      Return .T. 
   ELSEIF !nPrazo == CND->PARCA_ 
      Tone( 720, 3 ) 
      nPrazo:= CND->PARCA_ 
      Return .F. 
   ENDIF 
ENDIF 
Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � PedidoExiste 
� Finalidade  � Verifica a existencia do pedido 
� Parametros  � nPedido 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function PedidoExiste( nPedido ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 PED->( DBSetOrder( 6 ) ) 
 IF PED->( DBSeek( StrZero( nPedido, 8, 0 ) ) ) 
    Aviso( "Pedido ja existe gravado." ) 
    Pausa() 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    ScreenRest( cTela ) 
    PED->( DBSeek( "99999999" ) ) 
    PED->( DBSkip( -1 ) ) 
    nPedido:= VAL( PED->CODPED ) + 1 
    Return .F. 
 ENDIF 
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 ScreenRest( cTela ) 
 Return .T. 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerCodigo 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerCodigo( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 1 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
 
   SWSet( _PED_INFO_EXTRA, .F. ) 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
//      GetList[3]:VarPut( Space( Len( MPr->Descri ) ) ) 
//      GetList[4]:VarPut( Space( Len( MPr->Unidad ) ) ) 
      SWSet( _PED_INFO_EXTRA, .T. ) 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      ScreenRest( cTela ) 
      Return( .T. ) 
   EndIf 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Pressione [Enter] para ver lista..." ) 
      Pausa() 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[1]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   GetList[3]:VarPut( IF( MPr->PrecoD<>0, MPr->PrecoD, MPr->PrecoV ) ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
   Static FUNCTION MudaPreco() 
   IF !SWSet( _PED_MUDARPRECO ) 
      IF LastKey() == K_ENTER .OR. LastKey() == K_DOWN .OR. LastKey() == 0 
         nTecla:= K_DOWN 
      ELSEIF LastKey() == K_UP 
         nTecla:= K_UP 
      ELSE 
         nTecla:= K_DOWN 
      ENDIF 
      Keyboard Chr( nTecla ) 
   ENDIF 
   Return .T. 
 
   static FUNCTION CodFabrica() 
   IF !SWSet( _PED_CODFABRICA ) 
      Keyboard Chr( K_DOWN ) 
   ENDIF 
   Return .T. 
 
Function TestaQuantidade( nQuantidade ) 
 IF nQuantidade <= 0 
    Tone( 680, 2 ) 
    Return .F. 
 ENDIF 
 IF !MPR->QTDMIN==0 
    IF !INT( nQuantidade / MPR->QTDMIN ) == nQuantidade / MPR->QTDMIN 
       Tone( 680, 2 ) 
       Return .F. 
    ENDIF 
 ELSEIF !Empty( MPR->SEGURA ) 
    IF !INT( nQuantidade / MPR->QTDPES ) == nQuantidade / MPR->QTDPES 
       Tone( 680, 2 ) 
       Return .F. 
    ENDIF 
 ENDIF 
 Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � TESTAPRECO 
� Finalidade  � Testa se o preco corresponde ao necessario 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � 
� Data        � 
��������������� 
*/ 
Function TestaPreco( nPreco ) 
 Local cCor:= SetColor(), nCursor:= SetCursor(),; 
       cTela:= ScreenSave( 0, 0, 24, 79 ) 
 IF nPreco <= 0 
    Tone( 680, 2 ) 
    Return .F. 
 ELSEIF nPreco > 3 * ( PrecoConvertido() ) .OR. nPreco * 3 < PrecoConvertido() 
    Aviso( "Preco � maior ou menor que permitido." ) 
    Mensagem( "Pressione [ENTER] para manter ou [ESC] para redigitar." ) 
    Tone( 220, 2 ) 
    IF Inkey(0)==K_ESC 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       ScreenRest( cTela ) 
       Return .F. 
    ELSE 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       ScreenRest( cTela ) 
       Return .T. 
    ENDIF 
 ENDIF 
 Return .T. 
 
Function BuscaCliente( nCodCli, nTabPre, nVenIn, nVenEx, nCodTra ) 
CLI->( DBSetOrder( 1 ) ) 
IF !CLI->( DBSeek( nCodCli ) ) 
   PesqCli( @nCodCli ) 
ENDIF 
IF Cli->TABPRE > 0 
   nTabPre:= CLI->TABPRE 
ENDIF 
*IF CLI->CODATV < 0 
*   ATV->( DBSetOrder( 1 ) ) 
*   ATV->( DBSeek( CLI->CODATV ) ) 
   cAtividade:= iif(CLI->VALID_<>CTOD("") .AND. CLI->VALID_<DATE(),"CLIENTE BLOQUEADO. Data Limite de Credito Expirada","") 
   IF !EMPTY( cAtividade ) 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      VPBox( 15, 10, 17, 69, " ATENCAO ", "15/04" ) 
      @ 16,12 Say cAtividade Color "15/04" 
      Tone( 500 , 2 ) 
      Tone( 500 , 2 ) 
      Tone( 500 , 2 ) 
      inkey(0) 
      ScreenRest( cTelaRes ) 
      Return .F. 
   ENDIF 
*ENDIF 
IF nCodCli > 0 
   nVenIn:=  CLI->VENIN1 
   nVenEx:=  CLI->VENEX1 
   IF CLI->TRANSP > 0 
      nCodTra:= CLI->TRANSP 
   ENDIF 
   @ 03,30 Say CLI->DESCRI 
   Return .T. 
ELSE 
   Return .F. 
ENDIF 
 
