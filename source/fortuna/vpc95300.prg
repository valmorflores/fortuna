// ## CL2HB.EXE - Converted
#Include "VPF.CH"
#Include "INKEY.CH"


/*****

 Funcao      - VPC95300
 Finalidade  - Edicao de Notas Fiscais de Entrada
 Parametros  - Nil
 Retorno     - Nil
 Programador - Valmor Pereira Flores
 Data        -

-------------------------------------------------------
 PIS    - 1,65
 COFINS - 7,60
-------------------------------------------------------

*/
#ifdef HARBOUR
function vpc95300()
#endif

Local nCt
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nRow:= 1
Local nNotaF:= 0, nCodigo:= 0, nParcelas:= 0, nEmitDest:= 1,;
      nCodTra:= 0, nVenIn:= 0, nVenEx:= 0, nTabFat:= 0, nTabPre:= 0,;
      aProdutos:= {}, nCodOpe:= 0,;
      cObsNf1:= Space( 40 ), cObsNf2:= Space( 40 ), cObsNf3:= Space( 40 ),;
      cObsNf4:= Space( 40 ), nBanco:= 1, dDataEm, dDataMv, nLocal_:=0,;
      nTotQtd:= 0, nTotVal := 0, nXIcm:= 0, nTotIcm, ntotItens,;
      nValorItem:= 0, nValorUnitario:= 0, nPerIcm, nNatOpe, nVlrFre:= 0, nVlrDes:= 0,;
      nVlrSub:= nBaseSub:= 0
Local nRepresentatividade:= 0

      nCodOpe:= 0

// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen()
   VPBox( 00, 00, 12, 79, "NOTAS FISCAIS DE ENTRADA", _COR_GET_BOX, .F., .F., _COR_GET_TITULO )
   VPBox( 13, 00, 22, 79, "Produtos", _COR_BROW_BOX, .F., .F. )
   Mensagem("[INS]Novo [ESPACO]Seleciona, [ENTER]Altera [G]Gerar e [ESC]Sai")
   /* Clientes */
   DBSelectAr( _COD_CLIENTE )
   WHILE .T.
      EST->( DBSetOrder( 4 ) )
      EST->( DBGoTop() )
      nNotaF:= 0
      SetColor( _COR_GET_EDICAO )
      nTabPre:= PRE->CODIGO
      nTabFat:= CND->CODIGO
      aProdutos:= 0
      aProdutos:= {}
      nRow:= 1

      Scroll( 02, 02, 11, 78 )
      nBanco:= 1
      nCodigo:= 0
      aCondicoes:= {{ 0, CTOD( "  /  /  " ), 0, 0 }}
      nParcelas:= 0
      nVlrIpi:= 0
      nTotalP:= 0
      nVlrIcm:= 0
      dDataEm:= CTOD( "  /  /  " )
      dDataMv:= DATE()
      nLocal_:= 0
      dDataVen:= CTOD( "  /  /  " )
      nBaseIcm:= 0
      nBaseSub:= 0
      nVlrSub := 0
      dDataNota:= CTOD( "  /  /  " )
      @ 02,02 Say "Nota Fiscal....:" Get nNotaF Pict "99999999"
      @ 03,02 Say "Operacao.......:" Get nCodOpe Pict "999"      Valid TabelaOperacoes( @nCodOpe )
      @ 04,02 Say "Cliente/Fornec.:" Get nCodigo Pict "999999"   Valid BuscaCliente( @nCodigo, @nTabPre, @nVenin, @nVenEx, @nCodTra ) .AND. ;
                                                                       NotaExiste( @nNotaF, @nCodigo, @nCodOpe, @nTotalP, @nVlrIcm, @nParcelas, aProdutos, @dDataMv, @nBaseIcm, @dDataVen, @nLocal_, @dDataNota, @aCondicoes, @nVlrIpi, @nVlrFre, @nVlrDes, @nVlrSub, @nBaseSub )

      READ

      /* Finaliza sistema com ESC */
      IF LastKey() == K_ESC
         SetColor( cCor )
         SetCursor( nCursor )
         ScreenRest( cTela )
         Return Nil
      ENDIF


      lNotaExistente:= .F.
      dbSelectAr( _COD_ESTOQUE )
      DBSetOrder( 4 )
      aProdAnterior:= 0
      aProdAnterior:= {}
      IF DBSeek( PAD( Alltrim( Str( nNotaF, 15, 0 ) ), 15 ) + Str( nCodOpe, 2, 0 ) + Str( nCodigo, 6, 0 ) + "+", .T. )
         lNotaExistente:= .T.
         aProdAnterior:= ACLONE( aProdutos )
      ENDIF

      /* Verifica a Operacao que esta sendo utilizada */
      OPE->( DBSetOrder( 1 ) )
      IF OPE->( DBSeek( nCodOpe ) )
         IF OPE->ENTSAI == "S"
            SWAlerta( "OPERACAO INVALIDA: " + Alltrim( OPE->DESCRI ) + "; Saida nao pode ser utilizada neste modulo!", { "Cancelar" } )
            Loop
         ELSEIF OPE->ENTSAI == " "
            SWAlerta( "OPERACAO INVALIDA: " + Alltrim( OPE->DESCRI ) + "; O cadastro desta operacao esta incompleto!", { "Cancelar" } )
            Loop
         ENDIF
      ELSE
         SWAlerta( "OPERACAO INEXISTENTE!; Codigo nao consta no cadastro de Operacoes!", { "Cancelar" } )
         Loop
      ENDIF

      @ 05,02 Say "Data da Nota...:" Get dDataNota
      @ 06,02 Say "Total Nota.....:" Get nTotalP  Pict "@E 999,999,999.99"
// gelson
      @ 07,02 Say "Base de Calculo:" Get nBaseIcm Pict "@E 999,999,999.99"
      @ 08,02 Say "Valor ICMs.....:" Get nVlrIcm  Pict "@E 999,999,999.99"
      @ 09,02 Say "Base ICMs Subs.:" Get nBaseSub Pict "@E 999,999,999.99"
      @ 10,02 Say "Valor ICMs Subs:" Get nVlrSub  Pict "@E 999,999,999.99"
      @ 11,02 Say "Valor IPI......:" Get nVlrIpi  Pict "@E 999,999,999.99"
      // Coluna 2
      @ 06,42 Say "Data Entrada:" Get dDataMv
      @ 07,42 Say "N§Parcelas..:" Get nParcelas Pict "99" Valid FormaPgto( dDataNota, @nParcelas, @aCondicoes, nTotalP )
      @ 08,42 Say "Vlr.Frete...:" Get nVlrFre Pict "@E 999,999,999.99"
      @ 09,42 Say "Vlr.Desconto:" Get nVlrDes Pict "@E 999,999,999.99"
      READ
      nValorManual:= nVlrIcm
      IF LastKey() == K_ESC
         Loop
      ENDIF

//      VPBox( 06, 45, 09, 72, "Total Lancado", _COR_GET_BOX, .F., .F., _COR_GET_TITULO )
      @ 21,01 Say "Total em Quantidade: "
      @ 21,40 Say "Total em Valores: "

      SetColor( _COR_BROWSE )
      oTb:=TBrowseNew( 14, 1, 20, 78 )
      oTb:addcolumn(tbcolumnnew("Codigo",{|| StrZero( aProdutos[ nRow ][ 1 ], 7, 0 ) } ))
      oTb:addcolumn(tbcolumnnew("Descricao",{|| PAD( aProdutos[ nRow ][ 3 ], 40 ) } ))
      oTb:addcolumn(tbcolumnnew("Un",{|| aProdutos[ nRow ][ 8 ] } ))
      oTb:addcolumn(tbcolumnnew("Quantidade",{|| Tran( aProdutos[ nRow ][ 7 ], "@E 99999.999" ) } ))
      oTb:addcolumn(tbcolumnnew("     Preco",{|| Tran( aProdutos[ nRow ][ 6 ], "@E 999,999.999" ) } ))
      oTb:addcolumn(tbcolumnnew("S/N",{|| aProdutos[ nRow ][ 18 ] }))
      oTb:AUTOLITE:=.f.
      oTb:GOTOPBLOCK :={|| nRow:= 1}
      oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aProdutos ) }
      oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aProdutos,@nRow)}
      oTb:dehilite()
      Keyboard Chr( K_INS )

      /* Testa a existencia de um item em branco */
      if aProdutos[ 1 ][ 1 ] == 0
         if Len( aProdutos ) > 1
            cTelaRes:= ScreenSave( 0, 0, 24, 79 )
            Aviso( "Refazer a Selecao - 1§ Item em branco." )
            Pausa()
            ScreenRest( cTelaRes )
            Loop
         endif
      endif

      WHILE .t.
         oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,6},{2,1})
         whil nextkey()==0 .and. ! oTb:stabilize()
         end
         Ajuda( "[ESPACO]Custos [INS]Inserir [ENTER]Alterar [DEL]Excluir [F10]Analise [ESC]Finalizar" )
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
                          "Sim",;
                          "Sim",;
                          0,;
                          0,;
                          0,;
                          0,;
                          0,;
                          0,;
                          0 } )
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
                 @ nLin, 01 Get nCodPro Pict "9999999" Valid ;
                            BuscaProduto( @nCodPro, @nPreco, @nPreco1, @nPreco2 ) When;
                                mensagem( "Digite o codigo do produto." )
                 @ nLin, 52 Get nQuantidade Pict "@E 99,999.999" Valid TestaQuantidade( nQuantidade ) When;
                                mensagem( "Digite a quantidade de itens lancados." )
                 @ nLin, 64 Get nPreco Pict "@E 999,999.999"   Valid TestaPreco( nPreco ) when;
                                mensagem( "Digite o preco do item." )
                 READ
                 aProdutos[ nRow ][ 01 ]:=  nCodPro
                 aProdutos[ nRow ][ 04 ]:=  nPreco
                 aProdutos[ nRow ][ 05 ]:=  0
                 aProdutos[ nRow ][ 06 ]:=  nPreco
                 aProdutos[ nRow ][ 07 ]:=  nQuantidade
                 aProdutos[ nRow ][ 11 ]:=  nCodPro
                 MPR->( DBSetOrder( 1 ) )
                 IF MPR->( DBSeek( PAD( StrZero( nCodPro, 7, 0 ), 12 ) ) )
                    aProdutos[ nRow ][ 02 ]:=  MPR->CODFAB
                    aProdutos[ nRow ][ 03 ]:=  MPR->DESCRI
                    aProdutos[ nRow ][ 08 ]:=  MPR->UNIDAD
                    aProdutos[ nRow ][ 14 ]:= nPreco1
                    aProdutos[ nRow ][ 15 ]:= nPreco2
                    aProdutos[ nRow ][ 16 ]:= PRE->CODIGO
                    aProdutos[ nRow ][ 17 ]:= PRE->DESCRI
                    aProdutos[ nRow ][ 11 ]:= VAL( MPR->INDICE )
                    aProdutos[ nRow ][ 22 ]:= 12 // Percentual de ICMs
                    aProdutos[ nRow ][ 23 ]:= MPR->IPICMP
                    aProdutos[ nRow ][ 24 ]:= MPR->SITT03
                 ENDIF
                 Set( _SET_DELIMITERS, .T. )
                 IF !LastKey() == K_ESC
                    IF SWSet( _GER_CUSTOS_CONTABIL )
                        Keyboard Chr( K_SPACE )
                    ELSE
                        Keyboard Chr( K_INS )
                    ENDIF
                 ELSE
                    IF Len( aProdutos ) > 1
                       ASize( aProdutos, Len( aProdutos ) - 1 )
                    ENDIF
                    oTb:RefreshAll()
                    WHILE !oTb:Stabilize()
                    ENDDO
                 ENDIF


            case nTecla==K_F10
                 CompraVisualizar( aProdutos )


            case nTecla==K_SPACE

                 MPR->( DBSetOrder( 1 ) )
                 IF MPR->( DBSeek( PAD( StrZero( aProdutos[ nRow ][ 1 ], 7, 0 ), 12 ) ) )

                    cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                    cCorRes:= SetColor()
                    VPBox( 03, 10, 21, 70, " INFORMACOES TRIBUTARIAS / CONTABEIS ", _COR_GET_BOX )
                    SetColor( _COR_GET_EDICAO )
                    nQuantidade:= aProdutos[ nRow ][ 07 ]
                    nValorItem:= aProdutos[ nRow ][ 06 ]
                    nRepresentatividade:= ( ( ( nValorItem * nQuantidade ) / nTotalP ) * 100 )
                    nFreteItem:= ( ( nVlrFre * ( nRepresentatividade / 100 ) ) ) / nQuantidade
                    nDescontoItem:= ( ( nVlrDes * ( nRepresentatividade / 100 ) ) ) / nQuantidade

                    nVlrPis:= ( nValorItem - nDescontoItem ) * ( SWSet( _GER_CUSTOS_PIS ) / 100 )

                    // Expurgo de cofins desde 01/02/2004
                    // para empresas de Lucro Real sujeito ao regime nÆo cumulativo
                    IF dDataNota >= CTOD( "01/02/2004" )
                       nVlrCofins:= ( nValorItem - nDescontoItem ) * ( SWSet( _GER_CUSTOS_COFINS ) / 100 )
                    ELSE
                       nVlrCofins:= 0
                    ENDIF


                    nVlrAcrescimos:= ( nValorItem - nDescontoItem ) * ( SWSet( _GER_CUSTOS_ACRESCIMOS ) / 100 )
                    nVlrDescontos:=  ( nValorItem - nDescontoItem ) * ( SWSet( _GER_CUSTOS_DESCONTOS ) / 100 )

                    nPerIpi:= aProdutos[ nRow ][ 23 ]
                    nPerIcm:= aProdutos[ nRow ][ 22 ]

                    @ 05,12 Say Pad( "Custos do produto", 50 ) Color "15/" + CorFundoAtual()
                    @ 06,12 Say pad( Left( aProdutos[ nRow ][ 3 ], 50 ), 50 ) Color "15/" + CorFundoAtual()
                    @ 07,12 Say Replicate( "-", 55 ) Color "14/" + CorFundoAtual()

                    @ 08,12 Say "                Percentual  Vlr.Unitario      Vlr.Total"
                    @ 09,12 Say "Preco.........: [ 100.00] = [" + Tran( nValorItem, "@E 999,999.99" ) + "] [" + Tran( nValorItem * nQuantidade, "@E 99999,999.99" ) + "]"
                    @ 10,12 Say "% ICMs........:" Get nPerIcm Pict "@E 9999.99"
                    @ 11,12 Say "% IPI.........:" Get nPerIPI Pict "@E 9999.99"
                    @ 12,12 Say "% Pis.........: [" + Tran( SWSet( _GER_CUSTOS_PIS ),        "@e 9999.99" ) + "] = [" + Tran( nVlrPis,        "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nVlrPis,        "@E 99999,999.99" ) + "]"
                    @ 13,12 Say "% Cofins......: [" + Tran( SWSet( _GER_CUSTOS_COFINS ),     "@e 9999.99" ) + "] = [" + Tran( nVlrCofins,     "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nVlrCofins,     "@E 99999,999.99" ) + "]"
                    @ 14,12 Say "% Outros Acr..: [" + Tran( SWSet( _GER_CUSTOS_ACRESCIMOS ), "@e 9999.99" ) + "] = [" + Tran( nVlrAcrescimos, "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nVlrAcrescimos, "@E 99999,999.99" ) + "]"
                    @ 15,12 Say "% Outros Desc.: [" + Tran( SWSet( _GER_CUSTOS_DESCONTOS ),  "@e 9999.99" ) + "] = [" + Tran( nVlrDescontos,  "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nVlrDescontos,  "@E 99999,999.99" ) + "]"
                    @ 16,12 Say "Valor do Frete: [" + Tran( nRepresentatividade,  "@e 9999.99" ) +            "] = [" + Tran( nFreteItem,     "@e 999,999.99" ) + "] [" + Tran( nQuantidade * nFreteItem,     "@e 99999,999.99" ) + "]"
                    @ 17,12 Say "Valor do Desc.: [" + Tran( nRepresentatividade,  "@e 9999.99" ) +            "] = [" + Tran( nDescontoItem,  "@e 999,999.99" ) + "] [" + Tran( nQuantidade * nDescontoItem,  "@e 99999,999.99" ) + "]"
                    READ

                    nVlrIcm:= ( nValorItem - nDescontoItem ) * ( nPerIcm / 100 )
                    nVlrIpi:= ( nValorItem ) * ( nPerIpi / 100 )
                    nCustoLiquido:= ( nValorItem + nVlrIpi + nFreteItem ) - ( nDescontoItem + nVlrPis + nVlrCofins + nVlrIcm + nVlrDescontos )

                    @ 10,12 Say "% ICMs........: [" + Tran( nPerIcm,"@e 9999.99" ) + "] = [" + Tran( nVlrIcm, "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nVlrIcm, "@E 99999,999.99" ) + "]"
                    @ 11,12 Say "% IPI.........: [" + Tran( nPerIpi,"@e 9999.99" ) + "] = [" + Tran( nVlrIpi, "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nVlrIpi, "@E 99999,999.99" ) + "]"

                    @ 19,12 Say "Custo Liquido.:             [" + Tran( nCustoLiquido, "@E 999,999.99" ) + "] [" + Tran( nQuantidade * nCustoLiquido, "@E 99999,999.99" ) + "]"

                    aProdutos[ nRow ][ 21 ]:= nCustoLiquido
                    aProdutos[ nRow ][ 22 ]:= nPerIcm
                    aProdutos[ nRow ][ 23 ]:= nPerIpi

                    Inkey(0)
                    SetColor( cCorRes )
                    ScreenRest( cTelaRes )
                 ENDIF

            case nTecla==K_F12        ;Calculador()
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
                 cCliFor:= " "


                 /*========== BUSCA DE INFORMACOES NECESSARIAS =========*/
                 FOR->( DBSetOrder( 1 ) )
                 CLI->( DBSetOrder( 1 ) )
                 OPE->( DBSetOrder( 1 ) )
                 IF OPE->( DBSeek( nCodOpe ) )
                    IF OPE->CLIFOR=="F"
                       cEstado:= FOR->ESTADO
                       FOR->( DBSetOrder( 1 ) )
                       FOR->( DBSeek( nCodigo ) )
                    ELSE
                       CLI->( DBSetOrder( 1 ) )
                       CLI->( DBSeek( nCodigo ) )
                       cEstado:= CLI->ESTADO
                    ENDIF
                 ENDIF
                 UF->( DBSetOrder( 1 ) )
                 IF !UF->( DBSeek( cEstado ) )
                    cCorRes:= SetColor()
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                    Aviso( "Unidade de Federacao nao localizada!" )
                    Pausa()
                    ScreenRest( cTelaRes )
                    SetColor( cCorRes )
                 ENDIF
                 nNatOpe:= IF( cEstado=="RS", OPE->NATOPE, OPE->NATFOR )
                 nPerIcm:= UF->PERIND

                 nTotIcm:= 0
                 nTotItens:= 0
                 /*============= CONFERENCIA DE TOTAIS ===========*/
                 FOR nCt:= 1 TO Len( aProdutos )
                     IF aProdutos[ nCt ][ 18 ] == "Sim"
                        cProduto:= PAD( StrZero( aProdutos[ nCt ][ 1 ], 7 ), 12 )
                        MPR->( DBSetOrder( 1 ) )
                        MPR->( DBSeek( cProduto ) )
                        IF MPR->ICM___ > 0
                           nIcm:= MPR->ICM___
                        ELSE
                           nIcm:= nPerIcm
                        ENDIF
                        nxIcm:= 0
                        nValorUnitario:= aProdutos[ nCt ][ 6 ]
                        nValorItem:= aProdutos[ nCt ][ 6 ] * IF( aProdutos[ nCt ][ 7 ] == 0, 1, aProdutos[ nCt ][ 7 ] )
                        CalculoIcm( nValorItem, @nIcm, @nxIcm )
                        nTotIcm:= nTotIcm + nxIcm
                        nTotItens:= nTotItens + nValorItem
                     ENDIF
                 NEXT

                 nDiferenca:= 0
                 /*=== AVISO DE INCIDENCIA DE DIFERENCA DE ICMs ===*/
                 IF !( ROUND( nTotIcm, 2 ) == ROUND( nVlrIcm, 2 ) )
                    Aviso( "Diferenca de ICMs de " + ;
                           AllTrim( Tran( nTotIcm, "@E 999,999.99" ) ) + " para " +;
                           Alltrim( Tran( nVlrIcm, "@E 999,999.99" ) ) + "." )
                    Mensagem( "Pressione [TAB] p/ continuar ou qualquer tecla p/ corrigir." )
                    IF !( Inkey(0) == K_TAB )
                       ScreenRest( cTelaRes )
                       Loop
                    ENDIF
                    nDiferenca:= ROUND( nTotIcm, SWSet( 1998 ) ) - ROUND( nVlrIcm, SWSet( 1998 ) )
                 ENDIF

                 nDifItens:= 0
                 /*=== AVISO DE INCIDENCIA DE DIFERENCA ENTRE O TOTAL DOS ITENS ===*/
                 IF !( ROUND( nTotItens + nVlrIpi, 2 ) == ROUND( nTotalP, 2 ) )
                    Aviso( "Diferenca no Total da Nota Fiscal " + ;
                           AllTrim( Tran( nTotItens + nVlrIpi, "@E 999,999.99" ) ) + " para " +;
                           Alltrim( Tran( nTotalP, "@E 999,999.99" ) ) + "." )
                    Mensagem( "Pressione [TAB] p/ continuar ou qualquer tecla p/ corrigir." )
                    IF !( Inkey(0) == K_TAB )
                       ScreenRest( cTelaRes )
                       Loop
                    ENDIF
                    nDifItens:= ROUND( nTotItens, SWSet( 1998 ) ) - ROUND( nTotalP, SWSet( 1998 ) )
                 ENDIF

                 /*============ GRAVACAO DE INFORMACOES ============*/
                 // Estorna Lancamentos de Compras, incrementando no SALDO_ em produtos,
                 // caso seja uma regravacao de nota ja existente no sistema.
                 FOR nCt:= 1 TO Len( aProdAnterior )
                      cProduto:= PAD( StrZero( aProdAnterior[ nCt ][ 1 ], 7 ), 12 )
                      MPR->( DBSetOrder( 1 ) )
                      IF MPR->( DBSeek( cProduto ) )
                         IF MPR->( NetRLock() )
                            Mensagem( "Movimentando o Produto: " + cProduto + " " + StrZero( aProdAnterior[ nCt ][ 7 ], 10, 0 ) )
                            Replace MPR->SALDO_ With MPR->SALDO_ - aProdAnterior[ nCt ][ 7 ]
                         ENDIF
                      ENDIF
                 NEXT

                 nArea:= Select()
                 Aviso("Gravando Informacoes da Nota Fiscal...", 24 / 2 )
                 Mensagem("Gravando arquivo de ESTOQUE, aguarde...")
                 UF->( DBSetOrder( 1 ) )
                 DBSelectar( _COD_ESTOQUE )
                 DBSetOrder( 4 )
                 IF DBSeek( PAD( Alltrim( Str( nNotaF, 15, 0 ) ), 15 ) + Str( nCodOpe, 2, 0 ) + Str( nCodigo, 6, 0 ) + "+", .T. )
                    WHILE VAL( DOC___ ) == nNotaF .AND.;
                        CODIGO == nCodigo .AND. nCodOpe == CODMV_
                        IF ANULAR==" "
                           RLock()
                           Dele
                        ENDIF
                        DBSkip()
                    ENDDO
                 ENDIF
                 EST->( DBAppend() )
                 Repl EST->CODIGO With nCodigo,;
                      EST->CODRED With "***<NOTA>***",;
                      EST->DOC___ With Alltrim( Str( nNotaF ) ),;
                      EST->ENTSAI With "+",;
                      EST->NATOPE With nNatOpe,;
                      EST->PERICM With nIcm,;
                      EST->CPROD_ With "***<NOTA>***",;
                      EST->QUANT_ With 0,;
                      EST->VLRSAI With nTotalP,;
                      EST->VALOR_ With nTotalP,;
                      EST->DATAMV With dDataMv,;
                      EST->RESPON With nGCodUser,;
                      EST->CODMV_ With nCodOpe,;
                      EST->VLRBAS With nBaseIcm,;
                      EST->VLRICM With nValorManual,;
                      EST->DATANF With dDataNota,;
                      EST->VLRIPI With nVlrIpi,;
                      EST->VLRDES With nVlrDes,;
                      EST->VLRSUB With nVlrSub,;
                      EST->BASESU With nBaseSub,;
                      EST->VLRFRE With nVlrFre

                 FOR nCt:= 1 TO Len( aProdutos )
                     cProduto:= PAD( StrZero( aProdutos[ nCt ][ 1 ], 7 ), 12 )
                     EST->( DBAppend() )
                     MPR->( DBSetOrder( 1 ) )
                     IF MPR->( DBSeek( cProduto ) )
                        IF MPR->ICM___ > 0
                           nIcm:= MPR->ICM___
                        ELSE
                           nIcm:= nPerIcm
                        ENDIF
                        IF MPR->( NetRLock() )
                           IF aProdutos[ nCt ][ 18 ]=="Sim"
                              Replace MPR->SALDO_ With MPR->SALDO_ + aProdutos[ nCt ][ 7 ]
                           ENDIF
                        ENDIF
                     ENDIF
                     nxIcm:= 0
                     nValorUnitario:= aProdutos[ nCt ][ 6 ]
                     nValorItem:= ROUND( aProdutos[ nCt ][ 6 ] * IF( aProdutos[ nCt ][ 7 ] == 0, 1, aProdutos[ nCt ][ 7 ] ), SWSet( 1998 ) )
                     CalculoIcm( nValorItem, @nIcm, @nxIcm )
                     // Calculo novo
                     nRepresentatividade:= ( ( nValorItem / nTotalP ) * 100 )
                     // Frete por representatividade sobre total de mercadorias

                     //// VALMOR: Temporario
                     nPerIpi:= 5

                     nFreteItem:=        ( nVlrFre * ( nRepresentatividade / 100 ) )
		     nValorICMItem:=     ( nValorItem * ( nIcm / 100 ) )
		     nVlrIpiItem:=       ( nValorItem * nPerIpi )
		     nPisItem:=          ( nValorItem * ( SWSet( _GER_CUSTOS_PIS ) / 100 ) )
		     nCofinsItem:=       ( nValorItem * ( SWSet( _GER_CUSTOS_COFINS ) / 100 ) )
		     nOutrosDescontos:=  ( nValorItem * ( SWSet( _GER_CUSTOS_DESCONTOS ) / 100 ) )
		     nOutrosAcrescimos:= ( nValorItem * ( SWSet( _GER_CUSTOS_ACRESCIMOS ) / 100 ) )
		     // Rotina pre-existente
                     IF aProdutos[ nCt ][ 18 ] == "Sim"
                        Repl EST->CODIGO With nCodigo,;
                             EST->CODRED With cProduto,;
                             EST->DOC___ With Alltrim( Str( nNotaF ) ),;
                             EST->ENTSAI With "+",;
                             EST->NATOPE With nNatOpe,;
                             EST->CPROD_ With cProduto,;
                             EST->QUANT_ With aProdutos[ nCt ][ 7 ],;
                             EST->VLRSAI With nValorItem,;
                             EST->VALOR_ With nValorItem,;
                             EST->DATAMV With dDataMv,;
                             EST->RESPON With nGCodUser,;
                             EST->CODMV_ With nCodOpe,;
                             EST->VLRICM With 0,;
                             EST->DATANF With dDataNota,;
                             EST->VLRFRE With nFreteItem,;
                             EST->CUSTO_ With aProdutos[ nCt ][ 21 ],;
                             EST->PERICM With aProdutos[ nCt ][ 22 ],;
                             EST->PERIPI With aProdutos[ nCt ][ 23 ],;
                             EST->SITT03 With aProdutos[ nCt ][ 24 ]        // gelson 21-09-2004
                             //nxIcm
                     ENDIF

                     //
                     AtualPrecoCompra( cProduto, nValorunitario, nCodigo )
                 NEXT
                 DBUnlock()
                 OPE->( DBSetOrder( 1 ) )
                 OPE->( DBSeek( nCodOpe ) )
                 IF OPE->MOVFIN=="S"
                    PAG->( DBSetOrder( 4 ) )
                    PAG->( DBSeek( nCodigo ) )
                    /* LANCAMENTO DE CONTAS A PAGAR */
                    WHILE PAG->CODFOR==nCodigo .AND. !( PAG->( EOF() ) )
                       IF Alltrim( PAG->DOC___ ) == Alltrim( Str( nNotaF ) )
                          IF PAG->( NetRLock() )
                             PAG->( DBDelete() )
                          ENDIF
                       ENDIF
                       PAG->( DBSkip() )
                    ENDDO
                    PAG->( DBSetOrder( 1 ) )
                    PAG->( DBSeek( 99999, .T. ) )
                    IF PAG->( EOF() )
                       PAG->( DBSkip(-1) )
                    ENDIF
                    nCodLan:= PAG->CODIGO + 1
                    IF nParcelas > 0
                       FOR nCt:= 1 TO Len( aCondicoes )
                          PAG->( DBAppend() )
                          Repl PAG->CODIGO With nCodLan,;
                               PAG->CODFOR With nCodigo,;
                               PAG->TABOPE With nCodOpe,;
                               PAG->VALOR_ With aCondicoes[ nCt ][ 3 ],;
                               PAG->EMISS_ With dDataNota,;
                               PAG->VENCIM With aCondicoes[ nCt ][ 2 ],;
                               PAG->NFISC_ With nNotaF,;
                               PAG->DOC___ With Alltrim( Str( nNotaF ) ),;
                               PAG->BANCO_ With aCondicoes[ nCt ][ 4 ],;
                               PAG->LOCAL_ With aCondicoes[ nCt ][ 4 ]
                               nCodLan:= nCodLan+1
                           OPE->( DBSetOrder( 1 ) )
                           OPE->( DBSeek( nCodOpe ) )
                           Replace PAG->TABOPE With nCodOpe,;
                                   PAG->OBSERV With OPE->DESCRI
                           IF nCt==1
                              Replace PAG->VLRIPI With nVlrIPI,;
                                      PAG->VLRICM With nVlrIcm
                           ENDIF
                       NEXT
                    ENDIF
                 ENDIF
                 aCondicoes:= 0
                 aCondicoes:= {}
                 ScreenRest( cTelaRes )
                 EXIT

            Case nTecla==K_DEL
                 aProdutos[ nRow ][ 18 ]:= If( aProdutos[ nRow ][ 18 ]=="Sim", "Nao", "Sim" )
            Case nTecla==K_ENTER
                 MPR->( DBSetOrder( 1 ) )
                 MPR->( DBSeek( PAD( StrZero( aProdutos[ nRow ][ 1 ], 7, 0 ), 12 ) ) )
                 cTelaReserva:= ScreenSave( 0, 0, 24, 79 )
                 VPBox( 09, 10, 20, 70, " DADOS DO PRODUTO SELECIONADO ", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 SetColor( _COR_GET_EDICAO )
                 nPrecoInicial:= aProdutos[ nRow ][ 4 ]
                 nPerDesconto:=  aProdutos[ nRow ][ 5 ]
                 nPrecoFinal:=   aProdutos[ nRow ][ 4 ]
                 nQuantidade:=   aProdutos[ nRow ][ 7 ]
                 cOrigem:=       aProdutos[ nRow ][ 10 ]
                 SetCursor(1)
                 Keyboard Chr( K_ENTER ) + Chr( K_ENTER )
                 @ 10,12 Say "Produto....: [" + aProdutos[ nRow ][ 2 ] + "]"
                 @ 11,12 Say "Descri‡„o..: [" + LEFT( aProdutos[ nRow ][ 3 ], 40 ) + "]"
                 @ 12,12 Say "Fabricante.:" Get cOrigem Pict "XXXXXXXXXXXXXX" when Mensagem( "Digite a origem do produto." )
                 @ 13,12 Say "Pre‡o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco() .AND. Mensagem( "Digite o preco de venda para o produto." )
                 @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 15,12 Say "Pre‡o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999"  Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 VPBox( 16, 10, 18, 70,, _COR_GET_BOX, .F., .F., _COR_GET_TITULO )
                 @ 17,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" Valid TestaQuantidade( nQuantidade )
                 Read
                 If LastKey() <> K_ESC
                    aProdutos[ nRow ][ 19 ]:= "Sim"
                    aProdutos[ nRow ][ 04 ]:= nPrecoInicial
                    aProdutos[ nRow ][ 05 ]:= nPerDesconto
                    aProdutos[ nRow ][ 06 ]:= nPrecoFinal
                    aProdutos[ nRow ][ 07 ]:= nQuantidade
                    aProdutos[ nRow ][ 10 ]:= cOrigem
                    @ 19,12 Say "Complemento:"
                    nOpcao:= 1
                    @ 19,26 prompt "1" + Chr( 16 ) + "Continuar "
                    @ 19,40 prompt "2" + Chr( 16 ) + "Editar Informacoes "
                    menu to nOpcao
                    IF nOpcao == 2
                       clear typeahead
                       Keyboard Chr( K_SPACE )
                    ENDIF
                 EndIf
                 ScreenRest( cTelaReserva )
                 SetColor( _COR_BROWSE )
                 //CalculoGeral( aProdutos )
         OtherWise                ;tone(125); tone(300)
         EndCase
         oTb:refreshcurrent()
         oTb:stabilize()
         nTotQtd := nTotVal := 0
         For i = 1 TO Len( aProdutos )
             if aProdutos[ i ][ 18 ] == "Sim"
                nTotQtd += aProdutos[i,7]
                nTotVal += aProdutos[i,7]*aProdutos[i,6]
             endif
         Next
         @ 21,25 Say Str(nTotQtd,10,3)
         @ 21,58 Say transf(nTotVal,"@E 999,999.99")
      ENDDO
   ENDDO
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Return Nil



/*

  Funcao     - CompraVisualizar
  Finalidade - Visualizacao da nota fiscal de compra e seu resultado
  Parametros -
  Retorno    -
  Autor      - Valmor Pereira Flores
  Data       - 06-02-2004 08:51 PM

*/
Static Function CompraVisualizar( aProdutos )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local GetList:= {}
Local nCt, nTecla, oTb, nRow:= 1, nConfere
Local nTotal, nTotalProdutos:= 0

  IF Len( aProdutos ) <= 0
     Return .T.
  ENDIF

  SetColor( _COR_BROWSE )
  VPBox( 00, 00, 18, 79, "PRODUTOS & IMPOSTOS", _COR_BROW_BOX, .F., .F. )
  VPBox( 19, 00, 22, 79, "R E S U M O", _COR_BROW_BOX, .F., .F. )
  nTotal:= 0
  nTotalProdutos:= 0
  For i:= 1 to len( aProdutos )
      nTotal:= nTotal + ( aProdutos[ i ][ 21 ] * aProdutos[ nRow ][ 07 ] )
      nTotalProdutos:= nTotalProdutos + ( aProdutos[ i ][ 06 ] * aProdutos[ nRow ][ 07 ] )
  next
  @ 20,02 Say "Total (soma dos produtos): " + Tran( nTotalProdutos, "@E 999,999,999.99" )
  @ 21,02 Say "Total a custo m‚dio......: " + Tran( nTotal, "@E 999,999,999.99" )


  oTb:= TBrowseNew( 01, 01, 17, 78 )
  oTb:addcolumn(tbcolumnnew("Codigo",{|| StrZero( aProdutos[ nRow ][ 01 ], 7 ) } ))
  oTb:addcolumn(tbcolumnnew("Descricao",{|| Left( aProdutos[ nRow ][ 03 ], 25 ) } ))
  oTb:addcolumn(tbcolumnnew("Preco",{|| Tran( aProdutos[ nRow ][ 06 ],      "@Ez 99,999.99" ) } ))
  oTb:addcolumn(tbcolumnnew("Quantidade",{|| Tran( aProdutos[ nRow ][ 07 ], "@Ez 99,999.99" ) } ))
  oTb:addcolumn(tbcolumnnew("%ICM",{|| Tran( aProdutos[ nRow ][ 22 ],       "@Ez 999.99" ) } ))
  oTb:addcolumn(tbcolumnnew("%IPI",{|| Tran( aProdutos[ nRow ][ 23 ],       "@Ez 999.99" ) } ))
  oTb:addcolumn(tbcolumnnew("Custo",{|| Tran( aProdutos[ nRow ][ 21 ],      "@Ez 9999.999" ) } ))

  oTb:AUTOLITE:=.f.
  oTb:GOTOPBLOCK :={|| nRow:= 1}
  oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aProdutos ) }
  oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aProdutos,@nRow)}
  oTb:dehilite()
  WHILE .T.
     oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,7},{2,1})
     whil nextkey()==0 .and. ! oTb:stabilize()
     end
     nTecla:=inkey(0)
     if nTecla==K_ESC
        exit
     endif
     do case
        case nTecla==K_F12        ;Calculador()
        case nTecla==K_UP         ;oTb:up()
        case nTecla==K_DOWN       ;oTb:down()
        case nTecla==K_LEFT       ;oTb:up()
        case nTecla==K_RIGHT      ;oTb:down()
        case nTecla==K_PGUP       ;oTb:pageup()
        case nTecla==K_CTRL_PGUP  ;oTb:gotop()
        case nTecla==K_PGDN       ;oTb:pagedown()
        case nTecla==K_CTRL_PGDN  ;oTb:gobottom()
        Case nTecla==K_DEL
     OtherWise                ;tone(125); tone(300)
     EndCase
     oTb:refreshcurrent()
     oTb:stabilize()
  ENDDO
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return .T.



/*****

 Funcao      - FORMAPGTO
 Finalidade  - Captacao da Forma de Pagamento
 Parametros  - nParcelas, aCondicoes
 Retorno     - Nil
 Programador - Valmor Pereira Flores
 Data        -

*/
Static Function FormaPgto( dDataBase, nParcelas, aCondicoes, nTotal )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local GetList:= {}
Local nCt, nTecla, oTb, nRow:= 1, nConfere

  IF nParcelas==0
     Return .T.
  ENDIF
  IF Len( aCondicoes ) <= nParcelas
     FOR nCt:= 1 TO nParcelas
         IF nCt > Len( aCondicoes )
            AAdd( aCondicoes, { 0, CTOD( "  /  /  " ), 0, 0 } )
         ENDIF
     NEXT
  ENDIF
  SetColor( _COR_BROWSE )
  VPBox( 03, 49, 11, 77, "CONTAS A PAGAR", _COR_BROW_BOX, .F., .F. )
  oTb:= TBrowseNew( 04, 50, 10, 76 )
  oTb:addcolumn(tbcolumnnew(,{|| Str( aCondicoes[ nRow ][ 1 ], 3 ) } ))
  oTb:addcolumn(tbcolumnnew(,{|| DTOC( aCondicoes[ nRow ][ 2 ] ) } ))
  oTb:addcolumn(tbcolumnnew(,{|| Tran( aCondicoes[ nRow ][ 3 ], "@E 999,999.99" ) } ))
  oTb:addcolumn(tbcolumnnew(,{|| Tran( aCondicoes[ nRow ][ 4 ], "999" ) } ))
  oTb:AUTOLITE:=.f.
  oTb:GOTOPBLOCK :={|| nRow:= 1}
  oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aCondicoes ) }
  oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aCondicoes,@nRow)}
  oTb:dehilite()
  WHILE .T.
     oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,4},{2,1})
     whil nextkey()==0 .and. ! oTb:stabilize()
     end
     nTecla:=inkey(0)
     if nTecla==K_ESC
        exit
     endif
     do case
        case nTecla==K_F12        ;Calculador()
        case nTecla==K_UP         ;oTb:up()
        case nTecla==K_DOWN       ;oTb:down()
        case nTecla==K_LEFT       ;oTb:up()
        case nTecla==K_RIGHT      ;oTb:down()
        case nTecla==K_PGUP       ;oTb:pageup()
        case nTecla==K_CTRL_PGUP  ;oTb:gotop()
        case nTecla==K_PGDN       ;oTb:pagedown()
        case nTecla==K_CTRL_PGDN  ;oTb:gobottom()
        Case nTecla==K_DEL
        Case nTecla==K_TAB
             nConfere:= 0
             For nCt:= 1 TO Len( aCondicoes )
                 nConfere:= nConfere + aCondicoes[ nCt ][ 3 ]
             Next
             IF !(nConfere==nTotal)
                cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                Aviso( "Total da Nota nao confere c/ digitado. " + Alltrim( Tran( nConfere - nTotal, "@E 9,999,999.99" ) ) )
                Ajuda( "Total:" + Tran( nTotal, "@E 999,999,999.99" ) + " ÄÄÄÄÄ Soma das Parcelas: " + Tran( nConfere, "@E 999,999,999.99" ) )
                Mensagem( "Pressione [TAB] p/ aceitar ou qualquer tecla p/ continuar." )
                IF Inkey(0)==K_TAB
                   ScreenRest( cTela )
                   SetColor( cCor )
                   Return .T.
                ENDIF
                ScreenRest( cTelaRes )
             ELSE
                EXIT
             ENDIF
        Case nTecla==K_ENTER
             nPrazo:= aCondicoes[ nRow ][ 1 ]
             dData:= aCondicoes[ nRow ][ 2 ]
             nValor:= aCondicoes[ nRow ][ 3 ]
             nBanco:= aCondicoes[ nRow ][ 4 ]
             Set( _SET_DELIMITERS, .F. )
             @ Row(), 50 Get nPrazo Pict "999" Valid BuscaPrazo( dDataBase, nPrazo, @dData )
             @ Row(), 54 Get dData  Valid VerData( @dData )
             @ Row(), 63 Get nValor Pict "@E 999,999.99"
             @ Row(), 74 Get nBanco Pict "999"
             READ
             aCondicoes[ nRow ][ 1 ]:= nPrazo
             aCondicoes[ nRow ][ 2 ]:= dData
             aCondicoes[ nRow ][ 3 ]:= nValor
             aCondicoes[ nRow ][ 4 ]:= nBanco
             IF nRow==Len( aCondicoes )
                nConfere:= 0
                For nCt:= 1 TO Len( aCondicoes )
                    nConfere:= nConfere + aCondicoes[ nCt ][ 3 ]
                Next
                IF !nConfere==nTotal
                   cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                   Aviso( "Total da Nota nao confere c/ digitado. " + Alltrim( Tran( nConfere - nTotal, "@E 9,999,999.99" ) ) )
                   Ajuda( "Total:" + Tran( nTotal, "@E 999,999,999.99" ) + " ÄÄÄÄÄ Soma das Parcelas: " + Tran( nConfere, "@E 999,999,999.99" ) )
                   Mensagem( "Pressione [TAB] p/ aceitar ou qualquer tecla p/ continuar." )
                   IF Inkey(0)==K_TAB
                      ScreenRest( cTela )
                      SetColor( cCor )
                      Return .T.
                   ENDIF
                   ScreenRest( cTelaRes )
                ELSE
                   Exit
                ENDIF
             ENDIF
             Set( _SET_DELIMITERS, .T. )
             oTb:Down()
             oTb:RefreshAll()
             WHILE !oTb:Stabilize()
             ENDDO
     OtherWise                ;tone(125); tone(300)
     EndCase
     oTb:refreshcurrent()
     oTb:stabilize()
  ENDDO
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return .T.


Function BuscaPrazo( dDataBase, nPrazo, dData )
dData:= dDataBase + nPrazo
Return .T.



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
@ 4, 1 Say "Endere‡o...: " + Cli->Endere
@ 5, 1 Say "Cidade.....: " + Cli->Cidade
@ 6, 1 Say "Contato....: " + Cli->Compra
@ 7, 1 Say "Fone/Fax...: " + Cli->Fone1_ + " / " + Cli->Fax___
@ 8, 1 Say "Transportad: " + StrZero( Cli->Transp, 3, 0 )
SetColor( _COR_BROW_TITULO )
Scroll( 9, 0, 9, 79 )
@ 09, 01 Say "Produto"
@ 09, 33 Say "Un"
@ 09, 37 Say "Quantidade"
@ 09, 53 Say "Preco Unit rio"
@ 09, 68 Say "%IPI"
DispEnd()
//CalculoGeral( aProdutos )
SetCursor( 0 )

DBSelectAr( nArea )
DBSetOrder( nOrdem )
setcursor(1)
setcolor(cCor)
ScreenRest( cTela )
return(if(nTecla=27,.f.,.t.))

/*-------------------------------------------------------
* Modulo      - CalculoGeral
* Finalidade  - Apresentar no rodap‚ o calculo total do pedido
* Programador - Valmor Pereira Flores
* Data        - 26/Outubro/1995
* Atualizacao -
*--------------------------------------*/
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

 Funcao      - VerGrupo
 Finalidade  - Pesquisar um grupo especifico.
 Parametros  - cGrupo_ => Codigo do grupo
 Retorno     - cCodigo => Codigo do produto a ser retornado.
 Programador - Valmor Pereira Flores
 Data        - 04/Dezembro/1995

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

 Funcao      - BuscaProduto
 Finalidade  - Busca Produt/Precos na tabela
 Parametros  - nCodPro, nPreco, nPreco1, nPreco2
 Retorno     - .T./.F.
 Programador - Valmor Pereira Flores
 Data        -

*/
Static Function BuscaProduto( nCodPro, nPreco, nPreco1, nPreco2 )
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
   nPreco:= PrecoCompra( cProduto )
   Return .T.

Static Function BuscaPreco( nTabPre )
Local cCor:= SetColor()
PRE->( DBSetOrder( 1 ) )
IF !PRE->( DBSeek( nTabPre ) )
   TabelaPreco()
   nTabPre:= PRE->CODIGO
ENDIF
SetColor( "14/01" )
@ 02,40 Say "C/F.: " + ALLTRIM( IF( OPE->CLIFOR=="C", CLI->DESCRI, FOR->DESCRI ) )
@ 03,40 Say "Tab.: <Preco de Compra>"
SetColor( cCor )
Return .T.

Static Function BuscaCondicoes( nTabFat, nPrazo, nVenIn, nVenEx )
Local cCor:= SetColor()
CND->( DBSetOrder( 1 ) )
IF !CND->( DBSeek( nTabFat ) )
ENDIF
nTabFat:= CND->CODIGO
nPrazo:=  CND->PARCA_
SetColor( "14/01" )
@ 04,40 Say "Cond: " + Alltrim( CND->DESCRI )
@ 05,40 Say "Oper: " + ALLTRIM( OPE->DESCRI )
SetColor( cCor )
Return .T.

/*****

 Funcao      - BuscaCliente
 Finalidade  - Buscar cadastro de Clientes/Fornecedores
 Parametros  -
 Retorno     -
 Programador - Valmor Pereira Flores
 Data        -

*/
Static Function BuscaCliente( nCodigo, nTabPre, nVenIn, nVenEx, nCodTra )
IF OPE->CLIFOR=="C"
   CLI->( DBSetOrder( 1 ) )
   IF !CLI->( DBSeek( nCodigo ) )
      PesqCli( @nCodigo )
   ENDIF
   IF Cli->TABPRE > 0
      nTabPre:= CLI->TABPRE
   ENDIF
   IF nCodigo > 0
      nVenIn:=  CLI->VENIN1
      nVenEx:=  CLI->VENEX1
      IF CLI->TRANSP > 0
         nCodTra:= CLI->TRANSP
      ENDIF
      @ 04,30 Say CLI->DESCRI
      Return .T.
   ELSE
      Return .F.
   ENDIF
ELSE
   FOR->( DBSetOrder( 1 ) )
   IF !FOR->( DBSeek( nCodigo ) )
      ForSeleciona( @nCodigo )
   ENDIF
   IF nCodigo > 0
      @ 04,30 Say FOR->DESCRI
      Return .T.
   ELSE
      Return .F.
   ENDIF
ENDIF
Return .T.


Static Function CodVen( nVenIn, nVenEx )
IF !nVenIn == Nil
   IF nVenIn > 0
      Tone( 700, 3 )
   ENDIF
ENDIF
Return .T.

/*****
 Funcao      - PRAZO
 Finalidade  - Busca o prazo conforme a tabela de condicoes que esta
             - referenciada na tabela de operacoes
 Parametros  - nPrazo
 Retorno     - .T.
 Programador - Valmor Pereira Flores
 Data        -

*/
Static Function Prazo( nPrazo )
CND->( DBSetOrder( 1 ) )
IF CND->( DBSeek( OPE->TABCND ) )
   nPrazo:= CND->PARCA_
ENDIF
Return .T.

/*****

 Funcao      - VerPrazo
 Finalidade  - Fazer uma verificacao no prazo digitado
 Parametros  - nPrazo = Prazo Digitado
 Retorno     - Nil
 Programador - Valmor Pereira Flores
 Data        -

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

 Funcao      - NotaExiste
 Finalidade  - Verifica a existencia do pedido
 Parametros  - nNotaF
 Retorno     -
 Programador - Valmor Pereira Flores
 Data        -

*/
Static Function NotaExiste( nNotaF, nCodigo, nTabOpe, nTotalP, nVlrIcm, nPrazo, aProdutos, dDataMv, nBaseIcm, dDataVen, nLocal_, dDataNota, aCondicoes, nVlrIpi, nVlrFre, nVlrDes, nVlrSub, nBaseSub ) // gelson
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nEscolha:= 1

 dbSelectAr( _COD_ESTOQUE )
 DBSetOrder( 4 )
 IF DBSeek( PAD( Alltrim( Str( nNotaF, 15, 0 ) ), 15 ) + Str( nTabOpe, 2, 0 ) + Str( nCodigo, 6, 0 ) + "+", .T. )
    nTotalP:= 0
    nVlrIcm:= 0

    IF ( nEscolha:= SWAlerta( "ATENCAO! NOTA FISCAL JA EXISTE.; Escolha a operacao que deseja efetuar com esta nota.", { " Alterar ", " Excluir ", " Cancelar " } ) ) == 1

       /* Busca a data de vencimento no contas a pagar */
       OPE->( DBSetOrder( 1 ) )
       OPE->( DBSeek( nTabOpe ) )
       IF OPE->MOVFIN=="S"
          aCondicoes:= 0
          aCondicoes:= {}
          PAG->( dbSetOrder( 2 ) )
          IF PAG->( DBSeek( PAD( Alltrim( Str( nNotaF, 10, 0 ) ), 10 ) ) )
             while Alltrim( PAG->DOC___ ) == Alltrim( Str( nNotaF, 15, 0 ) )
                IF nCodigo == PAG->CODFOR
                   AAdd( aCondicoes, { PAG->VENCIM - EST->DATANF, PAG->VENCIM, PAG->VALOR_, PAG->LOCAL_ } )
                   nLocal_:=  PAG->LOCAL_
                ENDIF
                PAG->( DBSkip() )
                IF PAG->( EOF() )
                   EXIT
                ENDIF
             enddo
             nPrazo:= Len( aCondicoes )
          ENDIF
       ENDIF

       WHILE VAL( DOC___ ) == nNotaF .AND.;
           CODIGO == nCodigo .AND. nTabOpe == CODMV_
           IF ANULAR==" " .AND. Alltrim( CPROD_ ) == "***<NOTA>***"
              /* Acumula o Valor de ICMs */
              nVlrIcm:=  VLRICM
              nTotalP:=  VALOR_
              nBaseIcm:= VLRBAS
              nVlrIpi:=  VLRIPI
              nVlrDes:=  VLRDES
              nVlrFre:=  VLRFRE
              nBaseSub:= BASESU
              nVlrSub := VLRSUB
           ELSEIF ANULAR==" " .AND. VAL( CPROD_ ) > 0
              dDataMv:= EST->DATAMV
              MPR->( DBSetOrder( 1 ) )
              MPR->( DBSeek( EST->CPROD_ ) )
              nValor:= IF( QUANT_ <> 0, VALOR_ / QUANT_, VALOR_ )
              dDataNota:= EST->DATANF
              AAdd( aProdutos, { VAL( CPROD_ ),;
                                 MPR->CODFAB,;
                                 MPR->DESCRI,;
                                 ROUND( nValor, SWSet( 1998 ) ),;
                                 0,;
                                 ROUND( nValor, SWSet( 1998 ) ),;
                                 QUANT_,;
                                 MPR->UNIDAD,;
                                 QUANT_,;
                                 0,;
                                 0,;
                                 VAL( CPROD_ ),;
                                 0,;
                                 0,;
                                 0,;
                                 0,;
                                 0,;
                                 "Sim",;
                                 "Sim",;
                                 VAL( CPROD_ ),;
                                 CUSTO_,;
                                 PERICM,;
                                 PERIPI,;
                                 VLRFRE,;
                                 VLRDES,;
                                 SITT03 } )
           ENDIF
           DBSkip()
       ENDDO

    ELSEIF nEscolha==2

       /* Busca a data de vencimento no contas a pagar */
       OPE->( DBSetOrder( 1 ) )
       OPE->( DBSeek( nTabOpe ) )

       /* Limpa Informacoes do movimento financeiro */
       IF OPE->MOVFIN=="S"
          PAG->( dbSetOrder( 2 ) )
          IF PAG->( DBSeek( PAD( Alltrim( Str( nNotaF, 10, 0 ) ), 10 ) ) )
             WHILE Alltrim( PAG->DOC___ ) == Alltrim( Str( nNotaF, 15, 0 ) )
                IF nCodigo == PAG->CODFOR
                   IF PAG->( NetRLock() )
                      PAG->( DBDelete() )
                   ENDIF
                ENDIF
                PAG->( DBSkip() )
                IF PAG->( EOF() )
                   EXIT
                ENDIF
             ENDDO
          ENDIF
       ENDIF

       /* Limpa Informacoes do Estoque */
       WHILE VAL( DOC___ ) == nNotaF .AND.;
           CODIGO == nCodigo .AND. nTabOpe == CODMV_
           IF ANULAR==" " .AND. Alltrim( CPROD_ ) == "***<NOTA>***"
              /* Limpa cabecalho da nota fiscal */
              IF NetRLock()
                 DBDelete()
              ENDIF

           ELSEIF ANULAR==" " .AND. VAL( CPROD_ ) > 0
              /* Limpa Produtos da Nota Fiscal, tirando saldos ao estoque */
              IF NetRLock()
                 MPR->( DBSetOrder( 1 ) )
                 MPR->( DBSeek( EST->CPROD_ ) )
                 IF MPR->( NetRLock() )
                    Replace MPR->SALDO_ With MPR->SALDO_ - QUANT_
                 ENDIF
                 IF NetRLock()
                    DBDelete()
                 ENDIF
              ENDIF
           ENDIF
           DBSkip()
       ENDDO
       Return .F.

    ELSE

       /* Se a escolha for cancelar */
       Keyboard Chr( K_ESC )
       Return .F.

    ENDIF

 ENDIF
 nItens:= 0
// IF Len( aProdutos ) > 1
//    FOR nCt:= 1 TO Len( aProdutos )
//        IF aProdutos[ nCt ][ 1 ] == 0
//           ADEL( aProdutos, nCt )
//        ELSE
//           ++nItens
//        ENDIF
//    NEXT
//    IF nItens > 0
//       ASize( aProdutos, nItens )
//    ENDIF
// ENDIF
 IF Len( aProdutos ) <= 0
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
                       "Sim",;
                       "Sim",;
                       0,;
                       0,;
                       0,;
                       0,;
                       0,;
                       0 } )

 ENDIF
 SetColor( cCor )
 SetCursor( nCursor )
 ScreenRest( cTela )
 Return .T.


/*****

 Funcao      - VencNota()
 Finalidade  - Retorna a data de vencimento de uma determinada nota
 Parametros  - Nil
 Retorno     -
 Programador - Valmor Pereira Flores
 Data        -

*/
Function VencNota()
Local nNotaF, nCodigo, nTabOpe, nTotalP, nVlrIcm, nPrazo, aProdutos, dDataMv, nBaseIcm, dDataVen, nLocal_, dDataNota
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )

    nNotaF:= VAL( EST->DOC___ )
    nCodigo:= EST->CODIGO

    dDataVen:= CTOD( "  /  /  " )
    nTabOpe:= EST->CODMV_
    OPE->( DBSetOrder( 1 ) )
    OPE->( DBSeek( nTabOpe ) )
    /* Se estiver autorizada a movimentacao financeira nesta operacao */
    IF OPE->MOVFIN=="S"
       /* Busca a data de vencimento no contas a pagar */
       PAG->( dbSetOrder( 2 ) )
       IF PAG->( DBSeek( PAD( Alltrim( Str( nNotaF, 10, 0 ) ), 10 ) ) )
          WHILE Alltrim( PAG->DOC___ ) == Alltrim( Str( nNotaF, 15, 0 ) )
             IF nCodigo==PAG->CODFOR
                dDataVen:= PAG->VENCIM
                EXIT
             ENDIF
             PAG->( DBSkip() )
             IF PAG->( EOF() )
                EXIT
             ENDIF
          ENDDO
       ENDIF
    ENDIF
    Return dDataVen


/*****

 Funcao      - VerCodigo
 Finalidade  - Pesquisar a existencia de um codigo igual ao digitado
 Parametros  - cCodigo=> Codigo digitado pelo usu rio
 Retorno     -
 Programador - Valmor Pereira Flores
 Data        - 04/Dezembro/1995

*/
Static Function VerCodigo( cCodigo, GetList )
   LOCAL cGrupo_:= GetList[ 1 ]:VarGet()
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 )
   LOCAL nArea:= Select()
   LOCAL nOrdem:= IndexOrd(), nCt:= 0

   SWSet( 5322, .F. )
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ;
      ( cGrupo_ + cCodigo ) == "0000000"
//      GetList[3]:VarPut( Space( Len( MPr->Descri ) ) )
//      GetList[4]:VarPut( Space( Len( MPr->Unidad ) ) )
      SWSet( 5322, .T. )
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
      Aviso( "C¢digo n„o existente neste grupo...", 24 / 2 )
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


/*

  Funcao     - MudaPreco
  Finalidade - Verificar se ‚ permitida a mudanca de precos e fazer o campo pular
               caso nÆo seja poss¡vel.
  Parametros -
  Retorno    -
  Autor      - Valmor Pereira Flores
  Data       - 06-02-2004 12:48 PM

*/
Static Function MudaPreco()
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

Static Function CodFabrica()
   IF !SWSet( _PED_CODFABRICA )
      Keyboard Chr( K_DOWN )
   ENDIF
   Return .T.

Static Function TestaQuantidade( nQuantidade )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )

 IF nQuantidade < 0
    Tone( 680, 2 )
    Mensagem( "Quantidade esta negativa! [TAB]Aceitar" )
    Inkey(0)
    SetColor( cCor )
    SetCursor( nCursor )
    ScreenRest( cTela )
    Return LastKey()==K_TAB
 ENDIF
 IF !MPR->QTDMIN==0
    IF !INT( nQuantidade / MPR->QTDMIN ) == nQuantidade / MPR->QTDMIN
       Tone( 680, 2 )
       Mensagem( "Diferenca com quantidade minima permitida [TAB]Aceitar." )
       Inkey(0)
       SetColor( cCor )
       SetCursor( nCursor )
       ScreenRest( cTela )
       Return LastKey()==K_TAB
    ENDIF
 ELSEIF !Empty( MPR->SEGURA )
    IF !INT( nQuantidade / MPR->QTDPES ) == nQuantidade / MPR->QTDPES
       Tone( 680, 2 )
       Mensagem( "Produto possui seguranca de quantidade minima! [TAB]Aceitar." )
       Inkey(0)
       SetColor( cCor )
       SetCursor( nCursor )
       ScreenRest( cTela )
       Return LastKey()==K_TAB
    ENDIF
 ENDIF
 Return .T.

/*****

 Funcao      - TESTAPRECO
 Finalidade  - Testa se o preco corresponde ao necessario
 Parametros  - Nil
 Retorno     - Nil
 Programador -
 Data        -

*/
Static Function TestaPreco( nPreco )
 Local cCor:= SetColor(), nCursor:= SetCursor(),;
       cTela:= ScreenSave( 0, 0, 24, 79 )
 IF nPreco <= 0
    Tone( 680, 2 )
    Mensagem( "Preco esta negativo ou sem informacao! [TAB]Aceitar." )
    Inkey(0)
    SetColor( cCor )
    SetCursor( nCursor )
    ScreenRest( cTela )
    Return LastKey()==K_TAB
 ELSEIF nPreco > 2.0 * ( PrecoConvertido() ) .OR. nPreco * 2.0 < PrecoConvertido()
    Aviso( "Preco maior ou menor que permitido." )
    Mensagem( "Pressione [TAB] p/ manter ou [ESC] para redigitar." )
    Tone( 220, 2 )
    Inkey(0)
    SetColor( cCor )
    SetCursor( nCursor )
    ScreenRest( cTela )
    Return Lastkey()==K_TAB
 ENDIF
 Return .T.



/*


    Funcao       - AtualprecoCompra
    Finalidade   - Atualizar precos de compra
    Autor        - Valmor Pereira Flores
    Data         - Maio/2004

*/
Function AtualPrecoCompra( cProduto, nNovoPreco, nCodFor )
Local lFornecedorCorreto:= .F.
Local GetList:= {}
Local cTela:= ScreenSave( 0, 0, 24, 79 )
Local cCor:= SetColor()
Local nCt, nMargem:= 0
Local nOrdem:= MPR->( IndexOrd() ), nArea:= Select()
Local nOpcao:= 0

   if SWSet( _CMP_ATUALIZA_PRECO )
       // preco esta diferente do ultimo - atualizar tabela de precos
       if mpr->( dbseek( pad( cproduto, 12 ) ) )
           pxf->( dbsetorder( 1 ) )
           pxf->( dbseek( pad( cproduto, 12 ) ) )
           // localiza fornecedor
           lok:= .f.
           while !pxf->( eof() ) .and. pad( cproduto, 12 ) == pxf->cprod_
                if pxf->codfor == ncodfor
                   lok:= .t.
                   exit
                endif
                pxf->( dbskip() )
           enddo
           // se næo encontrou o fornecedor, cria o mesmo
           // com o preco == 0
           if !lok
              pxf->( dbappend() )
              replace pxf->cprod_ with pad( cProduto, 12 ),;
                      pxf->codfor with ncodfor,;
                      pxf->valor_ with 0
           endif
           nprecocompratabela:= pxf->valor_
           if nnovopreco <> nprecocompratabela
              mensagem( "Novo preco de compra: [" + tran( nnovopreco, "@e 999,999,999.99" ) + "]  novo preco de venda: ["  + tran( nnovopreco + ( ( nnovopreco * mpr->percpv ) / 100 ), "@e 999,999,999.99" ) + "]" )
              if ( nopcao:= swalerta( "<< Atualizar tabela de precos? >>;" + "produto: " + alltrim( mpr->descri ) + ";preco de compra diferente da tabela. deseja atualizar; os precos de compra e precos de venda com base neste dado novo?", { "Sim", "Manualmente", "Nao" } ) )==1
                 pxf->( rlock() )
                 replace pxf->pvelho with nprecocompratabela
                 replace pxf->data__ with date()
                 replace pxf->valor_ with nnovopreco
                 // se fornecedor for o fornecedor
                 // usado como padrao pelo sistema entao
                 // atualiza o preco de venda do produto com
                 // base nos parametros preco de compra e margem
                 lfornecedorcorreto:= .f.
                 if ncodfor == mpr->codfor
                    lfornecedorcorreto:= .t.
                 else
                    if swalerta( trim( mpr->descri ) + ";" + "Este produto possui outro fornecedor padrao.;deseja trocar o fornecedor padrao do produto; ou nao atualizaro preco de venda?", { " trocar fornecedor ", " nao mudar preco venda " } ) == 1
                       lfornecedorcorreto:= .t.
                    else
                       lfornecedorcorreto:= .f.
                    endif
                 endif
                 if lfornecedorcorreto
                    mpr->( rlock() )
                    replace mpr->codfor with ncodfor,;
                            mpr->precov  with nnovopreco + ( ( nnovopreco * mpr->percpv ) / 100 )
                    if mpr->percdc <> 0
                       replace mpr->precod with mpr->precov - ( mpr->precov * ( mpr->percdc / 100 ) )
                    endif
                    mpr->( dbunlock() )
                 endif
              elseif nopcao == 2
                 while .t.
                    nmargem:= mpr->percpv
                    nvenda:= 0
                    cconfirma:= "s"
                    vpbox( 06, 10, 22, 79, "PRECOS DA MERCADORIA", _COR_GET_BOX )
                    @ 08,11 say mpr->indice
                    @ 09,11 say mpr->descri
                    @ 11,11 say "Preco de compra novo..:" get nnovopreco pict "@e 999,999,999.99"
                    if ncodfor == mpr->codfor
                       @ 12,11 say "Margem (%)............:   " get nmargem    pict "@e 999,999.999"
                    endif
                    read
                    if mpr->codfor == ncodfor
                       nvenda:= nnovopreco + ( ( nnovopreco * nmargem ) / 100 )
                       @ 13,11 say "Preco de venda........:" + tran( nvenda, "@e 999,999,999.99" )
                       npercajuste:= ( ( nvenda / mpr->precov ) * 100 ) - 100
                       @ 15,11 say "Este sera o novo preco para o produto apos a gravacao."
                       @ 16,11 say "Houve um reajuste de " + trim( str( npercajuste, 12, 3 ) ) + "% na tabela de precos."
                       @ 18,11 say "Confirma a gravacao desta informacao?" get cconfirma pict "!"
                       read
                    endif
                    if cconfirma $ "ss"
                       pxf->( rlock() )
                       replace pxf->pvelho with nprecocompratabela
                       replace pxf->data__ with date()
                       replace pxf->valor_ with nnovopreco
                       mpr->( rlock() )
                       if mpr->codfor == ncodfor
                          replace mpr->precov with nnovopreco + ( ( nnovopreco * nmargem ) / 100 )
                          replace mpr->percpv with nmargem
                          if mpr->percdc <> 0
                             replace mpr->precod with mpr->precov - ( mpr->precov * ( mpr->percdc / 100 ) )
                          endif
                          mpr->( dbunlock() )
                       else
                          swalerta( "O preco de venda nao sofreu mudanca porque ;o fornecedor padrao informado neste produto ‚ outro.", { " ok " } )
                       endif
                       exit
                    endif
                 enddo
              endif
           endif
       endif

       clear typeahead
   endif


DBSelectAr( nArea )
MPR->( DBSetOrder( nOrdem ) )
SetColor( cCor )
ScreenRest( cTela )
Return Nil










