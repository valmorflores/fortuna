/*
================================================================================
                           PDVTESTE - APLICATIVO DE TESTE DE IMPRESSORAS FISCAIS
                                                                 VALMOR P.FLORES
                                                                      JULHO/2001
================================================================================
*/


#Include "INKEY.CH"

Local nImpressora:= 1, nComando:= 1, nSistema:= 1
Local cRetorno:= ""
Local nLinComando

Local aComandos:= { " ABRE CUPOM FISCAL            ",;
                    " PEGA NUMERO DO CUPOM         ",;
                    " VENDE PRODUTO                ",;
                    " VENDE SERVICO                ",;
                    " CANCELA ULTIMO ITEM          ",;
                    " FECHA CUPOM                  ",;
                    " ANULA ULTIMO CUPOM           ",;
                    " LEITURA X                    ",;
                    " REDUCAO Z                    ",;
                    " LEITURA DA MEMORIA FISCAL    ",;
                    " RECARREGA PDV.INI            ",;
                    " EDITA PDV.INI                ",;
                    " AUTENTICA DOCUMENTO          "  }

Private Impressora:= "",;
        Driver:= "",;
        Porta:= "", Driver:= ""

    Set Date British
    SetColor( "15/00" )

    Relatorio( "PDV.INI" )

    Set Key K_CTRL_ENTER to MSDOS()

    CLS
    @ 00,01 Say "_________________________________________________________________________________" Color "14/00"
    @ 01,01 Say "°°°°°°°° SISTEMA FORTUNA DE TESTE DE COMANDOS DE IMPRESSORAS FISCAIS °°°°°°°°°°°°"

    @ 06,01 Say "                                                                              " Color "15/00"
    @ 07,01 Say "                       ÚÄÄÄÄÄÄÄÄ¿ ÚÄÄÄÄÄ¿   ÚÄ¿    ÚÄ¿                        " Color "08/00"
    @ 08,01 Say "                       ³ ÚÄÄÄÄ¿ ³ ³ ÚÄ¿ ÀÄ¿ ³ ³    ³ ³                        " Color "07/00"
    @ 09,01 Say "                       ³ ³    ³ ³ ³ ³ ÀÄ¿ ³ ³ ³    ³ ³                        " Color "15/00"
    @ 10,01 Say "      ÚÄÄÄÄÄÄÄÄÄ¿      ³ ÀÄÄÄÄÙ ³ ³ ³   ³ ³ ³ À¿  ÚÙ ³     ÚÄÄÄÄÄÄÄÄÄ¿        " Color "08/00"
    @ 11,01 Say "      ÀÄÄÄÄÄÄÄÄÄÙ      ³ ÚÄÄÄÄÄÄÙ ³ ³   ³ ³ À¿ À¿ÚÙ ÚÙ     ÀÄÄÄÄÄÄÄÄÄÙ        " Color "07/00"
    @ 12,01 Say "                       ³ ³        ³ ³ ÚÄÙ ³  À¿ ÀÙ ÚÙ                         " Color "15/00"
    @ 13,01 Say "                       ³ ³        ³ ÀÄÙ ÚÄÙ   À¿  ÚÙ                          " Color "08/00"
    @ 14,01 Say "                       ÀÄÙ        ÀÄÄÄÄÄÙ      ÀÄÄÙ                           " Color "07/00"
    @ 15,01 Say "                                                                              " Color "15/00"

    @ 22,00 Say "________________________________________________________________________________"
    @ 23,00 Say "Copyright(c) 2001-2001 Fortuna(r) - Todos os direitos reservados.             " Color "15/00"
    @ 24,00 Say "Pressione qualquer tecla para continuar..."
    Inkey(3)


    ExibeConfiguracoes()






    CLS
    IF Driver=="W2000"
       nSistema:= 2
    ENDIF

    @ 00,01 Say "SISTEMA OPERACIONAL____________________________________________________________" Color "14/00"
    @ 01,01 Prompt " 1> Windows 95 Compativel   "
    @ 02,01 Prompt " 2> Windows 2000 Compativel "
    Menu To nSistema
    IF LastKey()==K_ESC
       CLS
       Quit
    ENDIF

    IF nSistema==2
       Driver:= "W2000"
    ENDIF

    cls

    aImpressora:= { "SIGTRON-FS345",;
                    "SIGTRON",;
                    "BEMATECH-MP20FI-II",;
                    "BEMATECH",;
                    "SCHALTER-II",;
                    "SCHALTER",;
                    "URANO",;
                    "SWEDA",;
                    "Treinamento" }


    /* Busca a impressora configurada no PDV.INI */
    FOR nCt:= 1 TO Len( aImpressora )
       IF aImpressora[ nCt ]==Impressora
          nImpressora:= nCt
          EXIT
       ENDIF
    NEXT

    @ 00,01 Say "IMPRESSORA FISCAL______________________________________________________________" Color "14/00"
    /* Menu de Impressoras */
    FOR nCt:= 1 TO LEN( aImpressora )
       @ nCt,01 Prompt Alltrim( Str( nCt, 2 ) ) + "> " + aImpressora[ nCt ]
    NEXT
    Menu To nImpressora

    IF LastKey()==K_ESC
       CLS
       Quit
    ENDIF
    Impressora:= Trim( aImpressora[ nImpressora ] )


    CLS
    if Impressora == "URANO"
       nRetorno:= InitComm()
       if nRetorno <> 0
          @ 00,00 SAY "IMPRESSORA FISCAL URANO"
          @ 02,00 Say "Falha na comunicacao com a impressora"
          @ 03,00 Say "Codigo de erro: " + StrZero( nRetorno )
          Inkey(0)
       endif
    endif
       

    CLS
    nLinComando:= 2
    WHILE .T.

       @ 00,01 Say    "COMANDOS________________________________________________________________________" Color "14/00"
       @ 23,00 Say    "ECF: " + Impressora + IF( !( ALLTRIM( Driver ) == "" ), " com driver " + Driver, "" )
       @ 01,01 Prompt " 1> Abre Cupom Fiscal                "
       @ 02,01 Prompt " 2>    Pega Numero do Cupom          "
       @ 03,01 Prompt " 3>    Vende Produto                 "
       @ 04,01 Prompt " 4>    Vende Servico                 "
       @ 05,01 Prompt " 5>    Cancela Ultimo Item Vendido   "
       @ 06,01 Prompt " 6> Fecha Cupom                      "
       @ 07,01 Prompt " 7> Anula Ultimo Cupom               "
       @ 08,01 Say    "ÄLEITURASÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
       @ 09,01 Prompt " 8> Leitura X                        "
       @ 10,01 Prompt " 9> Reducao Z                        "
       @ 11,01 Prompt " A> Memoria Fiscal                   "
       @ 12,01 Say    "ÄPDV.INIÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
       @ 13,01 Prompt " X> Recarrega PDV.INI                "
       @ 14,01 Prompt " Y> Edita PDV.INI                    "
       @ 15,01 Say    "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
       @ 16,01 Prompt " B> Autentica Documento              "
       @ 17,01 Say    "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
       @ 18,01 Prompt " 0> Finaliza Ambiente de Testes      "

       Menu To nComando

       @ 01,50 Say "SEQUENCIA DE COMANDOS ENVIADOS"

       IF nComando==14 .OR. LastKey()==27
          CLS
          EXIT
       ENDIF

       @ 24,00 Say "ULTIMO RETORNO: "

       /* Limpa regiao dos resultados */
       Scroll( 14, 0, 20, 48 )
       @ 24,20 Say Space( 80 )

       @ nLinComando,50 Say ALLTRIM( aComandos[ nComando ] ) Color "12/00"
       IF nLinComando==22
          Scroll( 2, 50, 22, 79, 1 )
       ELSE
          ++nLinComando
       ENDIF
       @ 24,70 Say "Aguarde..."
       DO CASE
          CASE nComando==13
               Autentica( 123, 00, " TESTE DE AUTENTICACAO " )

          CASE nComando==11
               cTelaRes:= ScreenSave( 0, 0, 24, 79 )
               Relatorio( "PDV.INI" )
               ScreenRest( cTelaRes )

          CASE nComando==12
               Run EDIT PDV.INI

          CASE nComando==1
               cRetorno:= ImpAbreCupom()

          CASE nComando==2
               cRetorno:= ImpCupomAtual()


          CASE nComando==3
               cRetorno:= ImpVendeProduto( PAD( "00", 13 ),;             && Cod fabrica
                                PAD( "PRODUTO TESTE", 30 ),;  && Produto
                                STIsento,;                        && Tabela de ICM
                                1,;                           && Quantidade
                                0.50,;                        && Preco
                                0,;                           && Desc.Percentual
                                0,;                           && Desc.Valor
                                0,;                           && VDA->( LastRec() )
                                "UN",;                        && Unidade
                                Nil,;
                                @cRetorno )


          CASE nComando==4
               ImpVendeProduto( PAD( "00", 13 ),;             && Cod fabrica
                                PAD( "SERVICO TESTE", 30 ),;  && Produto
                                STServico,;                      && Tabela de ICM
                                1,;                           && Quantidade
                                0.50,;                        && Preco
                                0,;                           && Desc.Percentual
                                0,;                           && Desc.Valor
                                0,;                           && VDA->( LastRec() )
                                "UN",;
                                Nil,;
                                @cRetorno )



          CASE nComando==6

               IF Driver="W2000"
                  CRLF:= CHR( 10 )
               ELSE
                  CRLF:= CHR( 13 ) + CHR( 10 )
               ENDIF
               cRetorno:= ImpFechaSem( "D", 0, 0, 0.50, 1.00, "EMPRESA TESTE"  + CRLF + ;
                                                              "ENDERECO"       + CRLF + ;
                                                              "CIDADE-ESTADO"  + CRLF + ;
                                                              "F O R M A   D E   P A G A M E N T O" + CRLF +;
                                                              "-----------------------------------" + CRLF +;
                                                              "001      0,50              01/01/01" + CRLF +;
                                                              "-----------------------------------", ;
                                                              "01001001000101" )

          CASE nComando==5

          CASE nComando==7
               cRetorno:= ImpCancCupom()

          CASE nComando==8
               cRetorno:= ImpLeituraX()

          CASE nComando==9
               cRetorno:= ImpReducaoZ()

          CASE nComando==10
               cRetorno:= ImpLeMemoria()

       ENDCASE

       @ 24,20 Say cRetorno Color "07/01"
       @ 24,70 Say "OK........"

       IF Driver=="W2000"
          IF File( "RETORNO.TXT" )
             cFile:= MEMOREAD( "RETORNO.TXT" )
             @ 14,0 Say PAD( " ARQUIVO RETORNO.TXT - WINDOWS 2000 ", 49 ) COLOR "15/01"
             MEMOEDIT( cFile, 15, 0, 20, 48 )
             FErase( "RETORNO.TXT" )
          ENDIF
       ENDIF
       /* Limpa janela de retorno */
       Scroll( 14, 0, 20, 48 )

    ENDDO





Function ExibeConfiguracoes()

    CLS
    @ 00,01 Say "PRINCIPAIS CONFIGURACOES P/PDV_______________________________________________________" Color "14/00"

    @ 01,01 Say "         Impressora Fiscal: " + Impressora
    @ 02,01 Say "     Driver de comunicacao: " + IF( Driver=="", "Padrao", Driver )
    @ 03,01 Say "          Driver p/ Gaveta: " + Gaveta
    @ 04,01 Say "      Diretorio do Fortuna: " + DiretorioDeDados
    @ 05,01 Say "        Porta de Impressao: " + PortaImpressao
    @ 06,01 Say "        Senha p/ descontos: " + SSCode
    @ 07,01 Say "   Variaveis de fechamento: ForPagDinheiro   => " + ForPagDinheiro
    @ 08,01 Say "                            ForPagTickets    => " + ForPagTickets
    @ 09,01 Say "                            ForPagCheque     => " + ForPagCheque
    @ 10,01 Say "                            ForPagCartao     => " + ForPagCartao
    @ 11,01 Say "                            ForPagAPrazo     => " + ForPagAPrazo
    @ 12,01 Say "                            ForPagOutros     => " + ForPagOutros
    @ 13,01 Say "                            ForPagAVista     => " + ForPagAVista
    @ 14,01 Say "                            ForPagPagamento  => " + ForPagPagamento
    @ 15,01 Say "                            ImpPagPagamento  => " + ImpPagPagamento
    @ 16,01 Say "        Moedas Especificas: " + MoedasEspecificas
    @ 17,01 Say "         Variaveis de ICMs: STPadrao         => " + STPadrao
    @ 18,01 Say "                            STIsento         => " + STIsento
    @ 19,01 Say "                            STSubstituicao   => " + STSubstituicao
    @ 20,01 Say "                            STServico        => " + STServico
    @ 21,01 Say "                    % ICMs: " + Tran( Icm, "@e 999.99" )
    @ 22,01 Say "             Grupo Servico: " + GrupoServico
    @ 23,01 Say "              Grupo Pesado: " + GrupoPesado

    Inkey( 0 )
    Cls



Function MSDOS()
   !COMMAND

