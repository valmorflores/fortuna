
Function TesteMenuMain()

Local aMenu
Local nOpcao:= 0

   // Inicializacao da Variavel
   aMenu:= {}

   // Alimentacao do Menu
   AAdd( aMenu, { .T., Nil, Nil, ">Utilitarios                         ", "Utilitarios do sistema", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Senhas                           ", "Senhas, usuarios e poderes", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Configuracoes                    ", "Configuracoes do sistema", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Parametros                    ", "Parametros de configuracao do sistema", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "            >Cores                      ", "Configuracoes de cores do sistema", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Reindexacao                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Comunicacao                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Transferencia                    ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Empresa                          ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >LOG Execucao                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Limpeza de dados                 ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Cadastro                            ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Clientes                         ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Edicao                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >-                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Pesquisa                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "            >Complemento                ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "            >Crediario                  ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Fornecedores                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Produtos e Servicos              ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Materia-prima                 ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Composicao                    ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Servicos                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Grupos                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Etiquetas                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Origem / Fabricantes             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Vendedores                       ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Classificacao Fiscal             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Bancos/Agen/Contas               ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Bancos                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Agencias                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >-                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Contas                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Transportadoras                  ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "    >Tabelas                          ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >ICMs e Reducoes               ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Feriados Nacionais            ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Atividades                    ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Nat. de Operacao              ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Estados                       ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Historicos (Cobr)             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Precos                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Comissoes                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Formas de Pagamento           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Operacoes                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Observacoes (NF)              ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Setores                       ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Garantia e Validade           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "        >Mais tabelas...               ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "            >Moedas                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "            >Variacao Cambial           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "            >Tipo de Contato            ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Estoque                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Movimentacao                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Anular                           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Pesquisas                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Saldos em Estoque             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Individual                    ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Movimento Geral               ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Saidas por cliente            ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Entradas por fornecedor       ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Detalhamento                  ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Custo Medio                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Garantia e Validade           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Visualiza Custo Medio         ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Monta saldo informativo       ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Compras                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Ordem de Compra                  ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Preco de Compra                  ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Nota Fiscal                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Vendas                              ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Nota Fiscal                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Automatico                    ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Manual                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Multi-processamento           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >-                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Cupom Fiscal                  ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >-                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Pesquisas                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Precos Por Produto x Cliente ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Vendas Por Produto         ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Notas Por Cliente          ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Quantidade de vendas de cada produto", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Notas de Venda Emitidas no Periodo", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Lucratividade <Cupons x Preco de Compra)", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Produtos x Cupons Fiscais        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Lucratividade (Notas x Preco Compra)", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Pedidos                          ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Assistente                    ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >CPD                           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Pendentes                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Manual / Cotacao              ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >-                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Selecao Multipla              ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >-                             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Pesquisas                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Aproveitamento             ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Lancamentos                ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Lanc. Por Midia            ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "         >Controle Reserva           ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Romaneio                         ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Estatisticas                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Total de Notas Fiscais        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Clientes (Individual)         ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Clientes (Multiplos)          ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Similaridade                     ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Garantia                         ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Por Nota                      ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Por Produto                   ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Todas as Series               ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "      >Series vendidas               ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Financeiro                          ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Contas a Pagar                   ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Contas a Receber                 ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >-                                ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Comissoes                        ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >-                                ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, "   >Fluxo Financeiro                 ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Servicos                            ", "", Nil } )
   AAdd( aMenu, { .T., Nil, Nil, ">Relatorios                          ", "", Nil } )

   SWMenuMake( aMenu, "15/01", "14/01" )


Function SWMenuMake( aMenu, cCor, cCorRealse, lRetorno )
   Local cOpcao:= "", nOpcao:= 0, nOpcaoAtual:= 0
   Local MenuList:= {}
   Local aMenuFormat:= {}

   WHILE .T.
       cls
/*

       nNivel:= LEN( cOpcao )+1
       IF nNivel == 1
          nOpcaoAtual:= 0
       ELSE
          FOR i:= 1 TO LEN( aMenu )
              nNivelAtual:= at( ">", aMenu[i][4] )
              nNivel:= Len( cOpcao ) + 1
              IF nNivelAtual > nNivel
                 cOp:= cOp + StrZero( nNivel, 3, 0 ) + "."
              ELSEIF nNivelAtual < nNivel
                 cOp:= SubStr( cOp, 1, Len( cOp ) - 4 )
              ELSEIF nNivelAtual == nNivel
                 cOp:= SubStr( cOp, 1, Len( cOp ) - 4 ) + StrZero( ++nOpcao, 3, 0 ) + "."
              ENDIF
          NEXT
       ENDIF

*/

//       @ 24,30 SAY cOpcao
//       @ 23,00 Say Len( cOpcao )+1
//       @ 24,00 Say nOpcaoAtual
       aMenuFormat:= {}
       FOR i:= 1 TO LEN( aMenu )
          nNivelAtual:= at( ">", aMenu[i][4] )
          IF i >= nOpcaoAtual
             IF nNivel == nNivelAtual
                cDescricao:= AllTrim( SubStr( aMenu[i][4], at( ">", aMenu[i][4] )+1 ) )
                AAdd( aMenuFormat, { cDescricao, aMenu[i][5] } )
                nOpcaoAtual:= nOpcaoAtual + 1
             ELSEIF nNivelAtual < nNivel
                EXIT
             ENDIF
          ENDIF
       NEXT
       MenuList:= {}
       nLin:= 0
       nCol:= 0

       // valmor

       FOR i:= 1 TO Len( aMenuFormat )
           @ ++nLin, nCol Prompt aMenuFormat[i][1] message aMenuFormat[i][2]
           aadd( MenuList, "" )
//           aadd( MenuList, menunew( ++nLin, nCol,;
//                   aMenuFormat[i][1], 2, cCor,;
//                   aMenuFormat[i][2],,, cCorRealse, .F. ) )
       NEXT

       Aadd( MenuList, "" )
       @ ++nLin, nCol Prompt "0> Retorna " //aMenuFormat[i][1] message aMenuFormat[i][2]

       menu to nOpcao
//       menumodal( MenuList, @nOPCAO )

       IF nOpcao > 0 .and. nOpcao < Len( MenuList )
          cOpcao:= cOpcao + StrZero( nOpcao, 3, 0 ) + "."
       ELSE
          cOpcao:= SubStr( cOpcao, 1, Len( cOpcao )-4 )
          nOpcaoAtual:= nOpcaoAtual - ( Len( MenuList ) )
       ENDIF
       MenuList:= {}
   ENDDO
   Return nOpcao


Function SWMenuDown( aMenu, nOpcao )








