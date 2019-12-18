#include "Inkey.Ch"

/*======================================
Programa    - Sistema PDV-Sigtron
Finalidade  - Impressao de Cupom Fiscal (Impressora Sigtron - FS300)
Programador - Valmor Pereira Flores
Data        - 16/Julho/1998
Atualizacao - Dezembro/1998
----------------------------------------*/
Para nModoVideo, nCorFundo, nCorSegFundo, cArquivoF, nColuna
Local lEditPreco:= .F.
Local xFonte
Local nCt:= 0, nArquivo, lMostra:= .T.
Local lFim:= .F., nMaximoItensTela:= 15, nLinQtd:= 8
Local nTeclaRes
Local cCampo, aCupom
Local nTecla,  oTb
Local GetList:= {}
Local nDescPercentual
Local nVenin:= 0
Local cCorPadrao, cCod
Local aParcelas:= {}
Local lCupomAberto:= .T.
Local lAchou:= .F., lRefaz:= .F., nTotal:= 0, nQuantidade:= 1,;
      cString:= "", nUltimoPerDesconto:= 0,;
      nUltimaQuantidade:= 1, nUltDescPerc:= nDescPercentual:= 0, cPreco:= "",;
      nUltDescValor:= nDescValor:= 0, nPrecoFinal:= 0,;
      nTroco:= 0, lCancelaItem:= .F., cDesconto:= "0000",;
      cNome__:= Space( 45 ), cCGC___:= Space( 14 ), cCpf___:= Space( 11 ),;
      cEndere:= Space( 35 ), cEstado:= "RS",;
      cCidade:= "PORTO ALEGRE        ",;
      lDisplay:= .T., aProduto:= {}
Local lManual, nCtx, lPrinter
Local nPerAcrDes:= 0, nVlrAcrDes:= 0, nValorPago:= 0, nValorPagar:= 0,;
      cAcrDes:= "D"
Local lAb:= .F.
Local nPercentual:= 0, nPrazo:= 0, nParcela:= 0, dVencimento:= CTOD( "  /  /  " ),;
      dPagamento:= CTOD( "  /  /  " ), nBanco:= 0, cCheque:= Space( 15 ),;
      nVezes:= 0
Priv  DiretorioDeDados:= "",;
      FormatodeImpressao:= 0,;
      Usuario:= "SOFT&WARE INFORMATICA"

Set Epoch To 1980
Set Date British
Set Deleted On

Relatorio( "PDV.INI", "\" + CURDIR() )

/* Convers∆o dos parÉmetros */
nCorFundo:= VAL( nCorFundo )
nCorSegFundo:= VAL( nCorSegFundo )
nModoVideo:= VAL( nModoVideo )
nColuna:= VAL( nColuna )

lPrinter:= .T.
IF Impressora == "Nenhuma"
   @ Row(), 00 Say "Nenhuma Impressora conectada..."
   lPrinter:= .F.
   Inkey(.5)
   Cls
ELSE
   IF Status() == 1 .AND. !Impressora=="Nenhuma"
      Quit
   ELSE
      Cls
   ENDIF
ENDIF
DO CASE
   CASE Impressora=="URANO"
        IF InitComm() <> 0
           QUIT
        ENDIF
ENDCASE


/* Abertura do arquivo de produtos */
Sele A
Use &DiretorioDeDados\CDMPRIMA.VPB Alias MPR Shared
IF !File( DiretorioDeDados-"\MPRPDV01.IGD" )
   Index On SUBSTR( INDICE, 1, 3 ) + STRZERO( CODFOR, 3, 0 ) + SUBSTR( INDICE, 4, 4 ) + Space( 3 ) To &DiretorioDeDados\MPRPDV01.IGD
ENDIF
Set Index To &DiretorioDeDados\MPRIND02.IGD,;
             &DiretorioDeDados\MPRIND04.IGD,;
             &DiretorioDeDados\MPRIND01.IGD,;
             &DiretorioDeDados\MPRPDV01.IGD

IF !File( "CUPOM.TXT" )
   Set Printer To "CUPOM.TXT"
ELSEIF File( "CUPOM.TXT" )
   lCupomAberto:= .T.
   cCAMPO:= MemoRead( "CUPOM.TXT" )
   /* Cria matriz com os dados de impressao */
   aCupom:=IOFillText( cCAMPO )
   aProduto:= 0
   aProduto:= {}
   nTotal:= 0
   cCod:= "0"
   /*
    Desabilita os cupons que foram cancelados, p/ que
    nao aprecam na proxima apresentacao e tambem nao sejam
    regravados no arquivo de cupons.
   */
   FOR nCt:= 1 TO Len( aCupom )
       IF Alltrim( Left( aCupom[ nCt ], 11 ) )=="Cancelado: "
          cCod:= SubStr( aCupom[ nCt ], 12, 25 )
          FOR nCt2:= Len( aCupom ) TO 1 Step -1
              Mostra( Left( aCupom[ nCt2 ], 13 ) + SubStr( aCupom[ nCt2 ], 113, 12 ) )
              IF ALLTRIM( Left( aCupom[ nCt2 ], 13 ) + SubStr( aCupom[ nCt2 ], 113, 12 ) ) == ALLTRIM( cCod )
                 aCupom[ nCt2 ]:= Space( 1 )
              ENDIF
          NEXT
       ENDIF
   NEXT

   lAb:= .F.

   ********** REPOSICIONAR ***********
   IF Protegido
   Set Printer To "CUPOM.TXT"
   Set Device To Print
   FOR nCt:= 1 TO Len( aCupom )
       IF Alltrim( Left( aCupom[ nCt ], 11 ) )=="Cancelado: "
          Mostra( aCupom[ nCt ], 1 )
       ELSEIF !Empty( aCupom[ nCt ] )
          /* Recolocando informacoes no arquivo de cupom */
          @ PRow()+1,00 Say aCupom[ nCt ]
          lAb:= .T.
       ENDIF
       IF !SubStr( aCupom[ nCt ], 1, 13 ) == "ANULADO======"
          nQuantidade:= Val( SubStr( aCupom[ nCt ], 78, 12 ) )
          nDescPercentual:= 0
          nDescValor:= 0
          nPrecoVenda:= Val( SubStr( aCupom[ nCt ], 66, 12 ) )
          AAdd( aProduto, { SubStr( aCupom[ nCt ], 1, 13 ),;
                            SubStr( aCupom[ nCt ], 14,  LEN( MPR->DESCRI ) ),;
                            SubStr( aCupom[ nCt ], 14 + LEN( MPR->DESCRI ), 2 ),;
                            nPrecoVenda,;
                            nQuantidade,;
                            nDescPercentual,;
                            nDescValor,;
                            0,;
                            SubStr( aCupom[ nCt ], 113, 12 ) } )
          nTotal:= nTotal + ( nPrecoVenda * nQuantidade )
       ENDIF
   NEXT
   @ PRow() + 1, 00 Say "----------------------------"
   Set Device To Screen
   nPrecoFinal:= 0
   nValorPagar:= 0
ENDIF
Release aCupom, cCod
ENDIF

/* Se lAb=Cupom efetivamente aberto */
IF lAb
   @ Row(),00 Say "Voce possui produtos pendentes em um CUPOM FISCAL aberto!"
   Inkey(0)
ENDIF

/* Inicializacao */
Bc_Inic( nModoVideo )
Bc_Siscoo( 2 )
Bc_Limpa( nCorFundo )
Bc_DEscala( 1, 1 )
/* Abertura da Porta de Impress∆o */
/* Monta a Tela de Fundo */
SetColor( StrZero( nCorFundo, 2, 0 ) + "/00" )
DO CASE
   CASE nModoVideo == 20
        BC_ArqVd( .0, .0, "FUNDO20.PCX", 10 )

   CASE !cArquivoF == Nil
        BC_ArqVd( .0, .0, cArquivoF, 2 )

   OTHERWISE
        BC_ArqVd( .0, .0, "FUNDO.PCX", 2 )
ENDCASE
SetCursor(0)
Sele A
DBSetOrder( OrdemProduto )
DBGotop()
/* Cabecalho do Sistema */
SetBlink( .F. )
SetColor( "00/15" )
Set Scoreboard Off
MaxLin( 24 )
DO CASE
   CASE nModoVideo == 256
        nMaximoItensTela:= 12
        nLinQtd:= 6
        MaxLin( 33 )
   CASE nModoVideo == 257
        nMaximoItensTela:= 10
        nLinQtd:= 8
        MaxLin( 25 )
   CASE nModoVideo == 25
        nMaximoItensTela:= 12
        MaxLin( 26 )
   CASE nModoVideo == 259
        nMaximoItensTela:= 19
        nLinQtd:= 11
        MaxLin( 38 )
   CASE nModoVideo == 25
        nMaximoItensTela:= 15
   CASE nModoVideo == 10
        nMaximoItensTela:= 12
   CASE nModoVideo == 20
        nMaximoItensTela:= 12
ENDCASE
WHILE !lFim
   /* Limpa a sub-tela de apresentacao de itens selecionados */
   SetColor( "15/00" )
   SCroll( 04, 48, 12, 79, 0 )
   SetColor( "15/" + StrZero( nCorSegFundo, 2, 0 ) )

   lPropaganda:= .T.
   Mostra( " ", 0 )
   Mostra( " ", 0 )
   Mostra( " FORTUNA Automacao Comercial ", 0 )
   Mostra( "      Soft&Ware Informatica     ", 0 )
   Mostra( "      Sistemas & Consultoria    ", 0 )
   Mostra( " ", 0 )
   Mostra( " ", 0 )
   Mostra( " ", 0 )

   IF lCupomAberto
      IF lAb
         Mostra( "**** P E N D E N T E ****", 5 )
      ENDIF
      FOR nCt:= 1 TO Len( aProduto )
          IF !Empty( aProduto[ nCt ][ 2 ] )
             Mostra( aProduto[ nCt ][ 2 ], 0 )
             Inkey(0.01)
          ENDIF
      NEXT
   ENDIF

   /* Topo do arquivo */
   DBGoTop()
   /* Reinicializacao de variaveis */
   lAchou:= .F.
   lRefaz:= .F.

   IF !lCupomAberto
      aProduto:= 0
      aProduto:= {}
      nTotal:= 0
      nPrecoFinal:= 0
      nValorPagar:= 0
   ENDIF
   Total( nTotal )
   nTroco:= 0
   nQuantidade:= 1
   cString:= ""
   nUltimoPerDesconto:= 0
   nUltimaQuantidade:= 1
   nUltDescPerc:= nDescPercentual:= 0
   cPreco:= ""
   nUltDescValor:= nDescValor:= 0
   lCancelaItem:= .F.
   cDesconto:= "0000"
   cNome__:= Space( 45 )
   cCGC___:= Space( 14 )
   cCpf___:= Space( 11 )
   cEndere:= Space( 35 )
   cEstado:= "RS"
   cCidade:= Cidade
   aCliente:= { 0, cNome__, cCGC___, cCpf___, cEndere, cCidade, cEstado, 0 }
   nPerAcrDes:= 0
   nVlrAcrDes:= 0

   lDisplay:= .T.


   AbrePortaCom( PortaImpressao )
   IF lPrinter
      ImpPorta( PortaImpressao )
   ENDIF

   nForma:= 0
   aParcelas:= 0
   aParcelas:= {}

   Sele A
   cCorPadrao:="07/" + StrZero( nCorSegFundo, 2, 0 ) + ",15/04,,,15/00"
   SetColor( cCorPadrao )
   oTB:=TBrowseDB( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-4, 45 )
   oTB:AddColumn( TBColumnNew(, {|| Left( MPR->DESCRI, 36 ) + " " +;
                                    StrTran( Tran( MPR->PRECOV, "@E 9999.999" ), " ", "0" ) } ) )
   oTB:AUTOLITE:=.f.
   oTB:DehiLite()
   /* Refaz o display */
   oTb:RefreshAll()
   WHILE !oTB:Stabilize()
   ENDDO
   /* Loop do Browse */
   WHILE .T.
      IF lDisplay
         oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
         WHILE !oTb:Stabilize()
         ENDDO
         WHILE Nextkey()=0 .AND.! oTB:stabilize()
         ENDDO
         DisplayInfo()
      ENDIF
      lDisplay:= .T.
      IF lMostra
         DispBegin()
         Scroll( 03, 01 + nColuna, 12, 44 )
         Scroll( nLinQtd, 01 + nColuna, nLinQtd+1, 44 )
         @ nLinQtd,2 + nColuna Say "Quantidade: " + Tran( nQuantidade, "@E 99999.999" )
         IF lCancelaItem
            SetColor( "14/00*" )
         ENDIF
         @ nLinQtd+1,2 + nColuna Say IF( lCancelaItem, "<CANCELAR ITEM>", "PDV Normal        " )
         IF lEditPreco
            SetColor( "14/00*" )
            @ nLinQtd+1,2 + nColuna Say IF( lEditPreco, "<  P R E C O  >", "" )
         ENDIF
         SetColor( cCorPadrao )
         lMostra:= .F.
         DispEnd()
      ENDIF
      WHILE (nTecla:=inkey())==0
          IF lPropaganda .OR. nTecla==K_CTRL_F1
             DispM( Propaganda )
             lPropaganda:= .T.
          ENDIF
      ENDDO
      IF lPropaganda .AND. !( nTecla==K_CTRL_F1 )
         Scroll( 01, 01 + nColuna, 02, 79 )
         lPropaganda:= .F.
      ENDIF
      /* Pega o buffer de nTeclado */
      IF nTecla >= 48 .AND. nTecla <= 57
         DBSetOrder( OrdemProduto )
         cString:= ""
         @ nLinQtd + 1, 2 Say "Edicao            "
         FOR nCt:= 1 TO 13
             cString+= CHR( nTecla )
             nTecla:= INKEY(0)
             IF nTecla == K_ENTER .OR. !Chr( nTecla ) $ "0123456789"
                Exit
             ENDIF
         NEXT
         /* se localizar o codigo */
         DBSetOrder( OrdemProduto )
         IF DBSeek( PAD( cString, 13 ) )
            oTb:RefreshCurrent()
            WHILE !oTb:Stabilize()
            ENDDO
            nTecla:= K_ENTER
            DisplayInfo()
         ELSE
            oTb:RefreshAll()
            WHILE !oTb:Stabilize()
            ENDDO
            Loop
         ENDIF
         lRefaz:= .T.
      ENDIF
      If nTecla=K_ESC
         IF Inkey(0) == K_ESC
            IF Len( aProduto ) > 0
               IF Protegido
                  Set Device To Print
                  @ PRow() + 1, 00 Say "-----------------------------"
                  Set Device To Screen
               ENDIF
               Mostra( "<< ATENCAO! CUPOM PENDENTE >>", 0, 4 )
               Tone( 223, 2 )
               IF Inkey(0) == K_ESC
                  lFim:= .T.
                  Exit
               ENDIF
            ELSE
               lFim:= .T.
               Exit
            ENDIF
         ENDIF
      EndIf
      do case
         CASE nTecla==K_UP         ;oTB:up()
         CASE nTecla==K_LEFT       ;oTB:up()
         CASE nTecla==K_RIGHT      ;oTB:down()
         CASE nTecla==K_DOWN       ;oTB:down()
         CASE nTecla==K_PGUP       ;oTB:pageup()
         CASE nTecla==K_PGDN       ;oTB:pagedown()
         CASE nTecla==K_CTRL_PGUP  ;oTB:gotop()
         CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom()
         CASE nTecla==K_F11
              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )
              SetCursor( 1 )
              aCliente:= { 0, cNome__, cCGC___, cCpf___, cEndere, cCidade, cEstado, 0 }
              @ 15,02 + nColuna Say "Obs:" Get cObserv1 Pict "@S25"
              @ 16,02 + nColuna Say "    " Get cObserv2 Pict "@S25"
              READ
              SetCursor( 0 )
              oTb:RefreshAll()
              WHILE !oTB:stabilize()
              ENDDO
              lDisplay:= .F.

         CASE nTecla==K_F12
              IF !lCancelaItem
                 lEditPreco:= IF( !lEditPreco, .T., .F. )
                 lMostra:= .T.
              ENDIF
         CASE nTecla==K_ENTER
              lDisplay:= .T.
              IF !lCancelaItem
                 cUnidade:= MPR->UNIDAD
                 nPrecoVenda:= MPR->PRECOV
                 IF nPrecoVenda == 0 .OR. lEditPreco
                    Scroll( nLinQtd, 02 + nColuna, nLinQtd, 44 )
                    @ nLinQtd,02 + nColuna Say "Edicao:"
                    SetCursor( 1 )
                    nRow:= Row()
                    nCol:= Col()
                    @ Row(), Col() Get nPrecoVenda Pict "@E 9,999,999.99"
                    READ
                    lEditPreco:= .F.
                    IF nPrecoVenda==0
                       Tone( 230, 3 )
                    ENDIF
                    Scroll( nLinQtd, 02 + nColuna, nLinQtd + 1, 44 )
                    @ nLinQtd, 02 + nColuna Say "PDV Normal"
                 ENDIF
                 IF MPR->TABRED == "  "  /* Se tabela de reducao estiver
                                            em branco utiliza DEFAULT = TB */
                    IF MPR->IPICOD == 4  /* ISENCAO icms cfe. tabela de Situacao Tributaria */
                       cTabela:= STIsento
                    ELSEIF MPR->IPICOD == 1 .OR. MPR->IPICOD == 3
                       cTabela:= STSubstituicao
                    ELSE
                       cTabela:= STPadrao
                    ENDIF

                 ELSE
                    DO CASE
                       CASE Impressora=="SIGTRON"
                            /* Se em TABRED constar toda a informacao ex. TA, TB, TC, utiliza direto */
                            IF LEFT( AllTrim( MPR->TABRED ), 1 ) == "T" .AND.;
                               LEN( AllTrim( MPR->TABRED ) ) > 1
                               cTabela:= AllTrim( MPR->TABRED )
                            ELSE        /* Caso em TABRED conste somente a
                                     letra A, B, C, faz a uniao c/ T */
                               cTabela:= "T" + AllTrim( MPR->TABRED )
                            ENDIF
                       CASE Impressora=="URANO"
                            cTabela:= Alltrim( MPR->TABRED )
                    ENDCASE
                 ENDIF

                 IF Len( aProduto ) == 0
                    IF lPrinter
                       ImpAbreCupom()
                    ENDIF
                    NumeroCupom( "000000" )
                    DisplayInfo()
                    Mostra( "---------CUPOM FISCAL--------", 0, 1 )
                    Mostra( "Nß: " + NumeroCupom(), 0 )
                 ENDIF

                 /* Verifica Descontos */
                 IF ! nDescPercentual == 0
                    nPrecoFinal:= ( nPrecoVenda * nQuantidade )
                    nPrecoFinal:= ( nPrecoFinal ) -;
                                ROUND( ROUND( nDescPercentual * nPrecoFinal, 2 ) / 100, 2 )
                 ELSEIF ! nDescValor == 0
                    nPrecoFinal:= ( nPrecoVenda * nQuantidade ) - nDescValor
                 ELSE
                    nPrecoFinal:= ( nPrecoVenda * nQuantidade )
                 ENDIF

                 lRetorno:= .F.
                 /* Adiciona no Cupom Fiscal */
                 cCodFab:= MPR->CODFAB
                 cDescricao:= MPR->DESCRI
                 IF lPrinter
                    lRetorno:= impVendeProduto( cCodFab,;
                                 Left( cDescricao, 30 ),;
                                 cTabela,;
                                 nQuantidade,;
                                 nPrecoVenda,;
                                 nDescPercentual,;
                                 nDescValor,;
                                 Len( aProduto ),;
                                 cUnidade )
                 ENDIF
                 IF lRetorno .OR. Impressora=="Nenhuma" .OR. Len( aProduto ) <= 1
                    /* Gravacao do produto no arquivo CUPOM.TXT */
                    IF Protegido
                       Set Device To Print
                       @ PRow()+1,00 Say MPR->CODFAB + MPR->DESCRI + MPR->UNIDAD + ;
                                     Tran( nPrecoVenda, "@R 999999999.99" )  + ;
                                     Tran( nQuantidade, "@R 999999999.99" )  + ;
                                     Tran( nDescPercentual, "@R 999.99" )    + ;
                                     Tran( nDescValor, "@R 999999.99" )      + ;
                                     "00000000" + MPR->INDICE + Chr( 13 ) + Chr( 10 )
                       Set Device To Screen
                    ENDIF
                    /* Adiciona Item no Array */
                    AAdd( aProduto, { MPR->CODFAB,;
                                      MPR->DESCRI,;
                                      MPR->UNIDAD,;
                                      nPrecoVenda,;
                                      nQuantidade,;
                                      nDescPercentual,;
                                      nDescValor,;
                                      0,;
                                      MPR->INDICE } )
                    Mostra( MPR->DESCRI, nPrecoVenda )
                    aProduto[ len( aProduto ) ][ 8 ]:= nPrecoFinal
                    Total( nTotal+= nPrecoFinal )
                    lCancelaItem:= .F.
                    lDisplay:= .F.
                    lMostra:= .F.
                    IF nQuantidade > 1
                       lMostra:= .T.
                       nQuantidade:= 1
                    ENDIF
                 ELSE
                    Mostra( "**** Item invalido ****", 0 )
                 ENDIF
             ELSE
                 FOR nCt:= Len( aProduto ) TO 1 Step -1
                     IF aProduto[nCt][1] == CODFAB .AND.;
                        aProduto[nCt][9] == INDICE
                        nQtdSai:= aProduto[ nCt ][ 5 ]
                        nPrecoFinal:= aProduto[ nCt ][ 8 ]
                        IF lPrinter
                           impCancItem( nCt )
                        ENDIF
                        lAchou:= .T.
                        aProduto[ nCt ][ 1 ]:= "ANULADO======"
                        aProduto[ nCt ][ 9 ]:= "ANULADO*****" +;
                                                aProduto[ nCt ][ 9 ]
                        IF Protegido
                           Set Device To Print
                           @ PRow()+1,00 Say "Cancelado: " + CODFAB+INDICE + Chr( 13 ) + Chr( 10 )
                           Set Device To Screen
                        ENDIF
                        EXIT
                     ENDIF
                     lAchou:= .F.
                 NEXT
                 IF lAchou
                    Mostra( aProduto[ nCt ][ 2 ], 0, 4 )
                    Total( nTotal-= nPrecoFinal )
                    nQuantidade:= 1
                 ENDIF
                 lCancelaItem:= .F.
                 lMostra:= .T.
                 lDisplay:= .F.
              ENDIF
              nDescPercentual:= 0
              nDescValor:= 0
         CASE nTecla == K_F5
              IF lPrinter
                 impSubTotCupom()
              ENDIF

         CASE nTecla == K_F4
              IF !lEditPreco
                 IF lCancelaItem == .T.
                    lCancelaItem:= .F.
                 ELSE
                    lCancelaItem:= .T.
                 ENDIF
                 lDisplay:= .F.
                 lMostra:= .T.
              ELSE
                 Tone( 700, 1 )
              ENDIF

         CASE nTecla == K_CTRL_F10
              AnulaCupom( impCupomAtual() )
              IF lPrinter
                 ImpCancCupom()
              ENDIF


         CASE nTecla == K_F12


         CASE nTecla == K_F2
              nUltDescValor:= nDescPercentual
              nUltDescPerc:=  nDescValor
              nDescPercentual:= 0
              nDescValor:= 0
              Scroll( nLinQtd, 02 + nColuna, nLinQtd, 44 )
              @ nLinQtd,2 + nColuna Say "%Desconto.: "
              nTeclaRes:= Inkey( 0 )
              IF nTeclaRes == K_F2
                 nDescPercentual:= nUltDescPerc
                 nDescValor:= nUltDescValor
                 @ Row(), Col() Say nDescPercentual Pict "99.99"
                 @ Row(), Col() + 2 Say "Valor: " +;
                              Tran( nDescValor, '@E 9,999.99' )
                 Loop
              ELSE
                 nDescPercentual:= 0
                 Keyboard Chr( nTeclaRes )
              ENDIF
              SetCursor( 1 )
              nRow:= Row()
              nCol:= Col()
              @ Row(), Col() Get nDescPercentual Pict "99.99"
              READ
              IF nDescPercentual == 0
                 @ nRow, nCol + 2 Say "Valor:" Get ;
                                       nDescValor Pict "@E 9,999.99"
                 READ
              ENDIF
              nUltDescPerc:=  nDescPercentual
              nUltDescValor:= nDescValor
              SetCursor( 0 )
              lDisplay:= .F.
         CASE nTecla == K_F1
              Scroll( nLinQtd, 02 + nColuna, nLinQtd, 44 )
              @ nLinQtd,2 + nColuna Say "Quantidade: "
              nTeclaRes:= Inkey( 0 )
              IF nTeclaRes == K_F1
                 nQuantidade:= nUltimaQuantidade
                 @ Row(), Col() Say nQuantidade Pict "@E 99999.999"
                 Loop
              ELSE
                 nQuantidade:= 0
                 Keyboard Chr( nTeclaRes )
              ENDIF
              SetCursor( 1 )
              @ Row(), Col() Get nQuantidade Pict "@E 99999.999" ;
                           Valid nQuantidade > 0
              READ
              SetCursor( 0 )
              nUltimaQuantidade:= nQuantidade
              lDisplay:= .F.
              lMostra:= .T.
         CASE nTecla == K_F8
              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )
              SetCursor( 1 )
              aCliente:= { 0, cNome__, cCGC___, cCpf___, cEndere, cCidade, cEstado, 0 }
              @ 15,02 + nColuna Say "Cliente.:" Get cNome__ ;
                                      Pict "@!S24" Valid BuscaCliente( MaxLin() - nMaximoItensTela, 1, MaxLin()-2, 45, @cNome__, @cCgc___, @cCPF___, @cEndere, @cCidade, @cEstado, @aCliente )
              @ 16,02 + nColuna Say "CGC.....:" Get cCGC___ ;
                                      Pict "@R 99.999.999/9999-99"
              @ 17,02 + nColuna Say "CPF.....:" Get cCpf___ ;
                                      Pict "@R 999.999.999-99"
              @ 18,02 + nColuna Say "Endereco:" Get cEndere ;
                                      Pict "@!S24"
              @ 19,02 + nColuna Say "Cidade..:" Get cCidade Pict "@S24"
              @ 20,02 + nColuna Say "Estado..:" Get cEstado
              READ
              SetCursor( 0 )
              oTb:RefreshAll()
              WHILE !oTB:stabilize()
              ENDDO
              lDisplay:= .F.
         CASE nTecla == K_F7
              SetCursor( 2 )
              IF nVezes == 0
                 nBanco:= 0
                 aParcelas:= 0
                 aParcelas:= {}
                 nValorPagar:= 0
                 nPerAcrDes:= 0
                 nVlrAcrDes:= 0
                 cAcrDes:= "D"
                 nVezes:= 0
                 nBanco:= 0
                 nPrazo:= 0
                 nParcela:= 0
                 nPercentual:= 0
                 dVencimento:= DATE()
                 dPagamento:= CTOD( "  /  /  " )
                 cCheque:= Space( 15 )
              ENDIF
              nVenin:= aCliente[ 8 ]
              SetCursor( 2 )
              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )
              @ 15,02 + nColuna Say "Acrescimo/Desc:" Get cAcrDes ;
                              Pict "!" ;
                              Valid cAcrDes $ "DA" .AND.;
                              AcrDes( cAcrDes, nPerAcrDes, ;
                              @nVlrAcrDes, @nValorPagar, ;
                              nTotal )
              @ 16,02 + nColuna Say "% Acr/Desc....:" Get nPerAcrDes ;
                              Pict "@R 999.99" When IF( nVlrAcrDes > 0,;
                              Pula(), .T. ) Valid ;
                              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes,;
                              @nValorPagar, nTotal )
              @ 17,02 + nColuna Say "Vlr. Acr/Desc.:" Get nVlrAcrDes ;
                              Pict "@R 99,999,999,999.99" When ;
                              IF( nPerAcrDes > 0, Pula(), .T. ) Valid ;
                              ExibeTotais( "A Pagar: ", nValorPagar ) .AND.;
                              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes,;
                              @nValorPagar, nTotal )
              @ 18,02 + nColuna Say "Total a Pagar.:" Get nValorPagar ;
                              Pict "@E 99,999,999,999.99"
              @ 19,02 + nColuna Say "Vendedor......:" Get nVenin Pict "@R 999" Valid BuscaVendedor( @nVenin )
              READ
              aCliente[ 8 ]:= nVenin
              SetCursor( 2 )

              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )

              /* Apresenta as formas de pagamento cadastradas */
              FormaPagamento( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45, aParcelas, nValorPagar, @nVezes, @nForma )

              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )

              @ 15,02 + nColuna Say "Parcelas:" Get nVezes Pict "99"
              READ
              nParAcumulado:= 0
              FOR nCt:= 1 TO nVezes
                  IF nCt <= Len( aParcelas )
                     nPercentual:= aParcelas[ nCt ][ 1 ]
                     nPrazo:=      aParcelas[ nCt ][ 2 ]
                     nParcela:=    aParcelas[ nCt ][ 3 ]
                     dVencimento:= aParcelas[ nCt ][ 4 ]
                     dPagamento:=  aParcelas[ nCt ][ 5 ]
                     nBanco:=      aParcelas[ nCt ][ 6 ]
                     cCheque:=     aParcelas[ nCt ][ 7 ]
                     nLocal:=      aParcelas[ nCt ][ 8 ]
                     lManual:= .F.
                     IF nCt==2
                        IF ( nParcela:= ( nValorPagar - aParcelas[ 1 ][ 3 ] ) / ( nVezes-1 ) ) <> aParcelas[ nCt ][ 3 ]
                           nPercentual:= 0
                           lManual:= .T.
                        ENDIF
                     ELSEIF nCt==3
                        IF ( nParcela:= ( nValorPagar - ( aParcelas[ 1 ][ 3 ] + aParcelas[ 2 ][ 3 ] ) ) / ( nVezes-2 ) ) <> aParcelas[ nCt ][ 3 ]
                           lManual:= .T.
                           nPercentual:= 0
                        ENDIF
                     ELSEIF nCt==4
                        IF ( nParcela:= ( nValorPagar - ( aParcelas[ 1 ][ 3 ] + aParcelas[ 2 ][ 3 ] + aParcelas[ 3 ][ 3 ] ) ) / ( nVezes-3 ) ) <> aParcelas[ nCt ][ 3 ]
                           lManual:= .T.
                           nPercentual:= 0
                        ENDIF
                     ELSEIF nCt==5
                        IF ( nParcela:= ( nValorPagar - ( aParcelas[ 1 ][ 3 ] + aParcelas[ 2 ][ 3 ] + aParcelas[ 3 ][ 3 ] + aParcelas[ 4 ][ 3 ] ) ) / ( nVezes-3 ) ) <> aParcelas[ nCt ][ 3 ]
                           lManual:= .T.
                           nPercentual:= 0
                        ENDIF
                     ENDIF
                  ENDIF
                  SetCursor( 1 )
                  @ 16,02 + nColuna Say "Parcela " + StrZero( nCt, 03, 0 )
                  @ 17,02 + nColuna Say "Percentual:" Get nPercentual Pict "@EZ 999.99" Valid CalcParcela( nValorPagar, nPercentual, @nParcela, lManual )
                  @ 18,02 + nColuna Say "Prazo/Dias:" Get nPrazo Pict "999" Valid CalcVenc( DATE(), nPrazo, @dVencimento )
                  @ 19,02 + nColuna Say "Valor.....:" Get nParcela Pict "@EZ 9999,999.99"
                  @ 20,02 + nColuna Say "Vencimento:" Get dVencimento
                  @ 21,02 + nColuna Say "Pagamento.:" Get dPagamento
                  @ 22,02 + nColuna Say "Banco.....:" Get nBanco Pict "999"
                  @ 23,02 + nColuna Say "Cheque....:" Get cCheque
                  @ 24,02 + nColuna Say "Local.....:" Get nLocal Pict "999"
                  READ
                  SetCursor( 0 )
                  IF LastKey() == K_PGUP
                     nParAcumulado:= nParAcumulado - nParcela
                     nCt:= nCt - 2
                     IF nCt < 0
                        nCt:= 0
                     ENDIF
                  ELSE
                     nParAcumulado:= nParAcumulado + nParcela
                     IF nCt == nVezes .AND. !nParAcumulado == nValorPagar
                        //Scroll( 16, 02, 22, 45 )
                        //@ 17,02 Say "FALHA DE OPERACAO - Soma Nao Confere!"
                        //@ 18,02 Say "**** Valores Descartados ****"
                        //@ 19,02 Say "Favor Repetir Esta Operacao...   "
                        //Pausa()
                        //Keyboard Chr( K_F7 )
                        EXIT
                     ENDIF
                     IF nCt <= Len( aParcelas )
                        aParcelas[ nCt ][ 1 ]:= nPercentual
                        aParcelas[ nCt ][ 2 ]:= nPrazo
                        aParcelas[ nCt ][ 3 ]:= nParcela
                        aParcelas[ nCt ][ 4 ]:= dVencimento
                        aParcelas[ nCt ][ 5 ]:= dPagamento
                        aParcelas[ nCt ][ 6 ]:= nBanco
                        aParcelas[ nCt ][ 7 ]:= cCheque
                        aParcelas[ nCt ][ 8 ]:= nLocal
                     ELSE
                        AAdd( aParcelas, { nPercentual,;
                                           nPrazo,;
                                           nParcela,;
                                           dVencimento,;
                                           dPagamento,;
                                           nBanco,;
                                           cCheque,;
                                           nLocal } )
                     ENDIF
                  ENDIF
              NEXT
              /* Retira lancamentos caso haja sobra */
              FOR nCt:= 1 TO Len( aParcelas )
                  IF LEN( aParcelas ) > nVezes
                     ADEL( aParcelas, nVezes + 1 )
                     ASIZE( aParcelas, Len( aParcelas ) - 1 )
                  ENDIF
              NEXT
              SetCursor( 0 )
              oTb:RefreshAll()
              WHILE !oTB:stabilize()
              ENDDO
              lDisplay:= .F.
              SetCursor( 0 )
              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )
              Mostra( "Cliente.: " + aCliente[ 2 ], 0, 6 )
              Mostra( "Parcelas: " + StrZero( nVezes, 2, 0 ), 0, 5 )
              Mostra( "Cupom Fiscal pode ser finalizado...", 0, 2 )
              Inkey(0)
         CASE nTecla == K_F6
              nValorPago:= 0
              nValorPagar:= 0
              nVezes:= 0
              cAcrDes:= "D"
              nVenin:= aCLiente[ 8 ]
              Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )
              IF Len( aParcelas ) > 0
                 AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )
              ELSEIF Len( aParcelas ) <= 0
                 Keyboard Chr( K_DOWN ) + Chr( K_DOWN ) + Chr( K_DOWN )
                 SetCursor( 1 )
                 @ 15,02 + nColuna Say "Acrescimo/Desc:" Get cAcrDes ;
                              Pict "!" ;
                              Valid cAcrDes $ "D" .AND.;
                              AcrDes( cAcrDes, nPerAcrDes, ;
                              @nVlrAcrDes, @nValorPagar, ;
                              nTotal )
                 @ 16,02 + nColuna Say "% Acr/Desc....:" Get nPerAcrDes ;
                              Pict "@R 999.99" When IF( nVlrAcrDes > 0,;
                              Pula(), .T. ) Valid ;
                              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes,;
                              @nValorPagar, nTotal )
                 @ 17,02 + nColuna Say "Vlr. Acr/Desc.:" Get nVlrAcrDes ;
                              Pict "@R 99,999,999,999.99" When ;
                              IF( nPerAcrDes > 0, Pula(), .T. ) Valid ;
                              ExibeTotais( "A Pagar: ", nValorPagar ) .AND.;
                              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes,;
                              @nValorPagar, nTotal )
                 @ 18,02 + nColuna Say "Total a Pagar.:" Get nValorPagar ;
                              Pict "@E 99,999,999,999.99" When Pula()
                 @ 19,02 + nColuna Say "Valor Pago....:" Get nValorPago ;
                              Pict "@R 99,999,999,999.99" Valid ;
                              ( nValorPago >= nValorPagar ) .OR. ;
                              LastKey() == K_UP
                 @ 20,02 + nColuna Say "Vendedor......:" Get nVenin Pict "@R 999" Valid BuscaVendedor( @nVenin )
                 READ
              ENDIF
              IF !LastKey() == K_ESC
                 SetCursor( 0 )
                 nTroco:= nValorPago - nValorPagar
                 @ 20,02 + nColuna Say "Troco.........: " + ;
                              Tran( nTroco, "@R 99,999,999,999.99" )
                 aCliente[ 8 ]:= nVenin
                 ExibeTotais( "Troco:", nTroco )
                 oTb:RefreshAll()
                 WHILE !oTB:stabilize()
                 ENDDO
                 IF cAcrDes == "D"
                    IF nPerAcrDes > 0
                       /* deixar negativo caso seja desconto */
                       nPerAcrDes:= nPerAcrDes * (1)
                    ELSEIF nVlrAcrDes > 0
                       /* Deixar negativo caso seja desconto */
                       nVlrAcrDes:= nVlrAcrDes * (1)
                    ENDIF
                 ENDIF
                 cCgcCpf:= IF( Empty( cCGC___ ),;
                                Tran( cCpf___, "99999999999" ),;
                                Tran( cCGC___, "99999999999999" ) )
                 cMensagem:= ""
                 IF !EMPTY( cObserv1 )
                    cMensagem:= cMensagem + cObserv1 + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 IF !EMPTY( cObserv2 )
                    cMensagem:= cMensagem + cObserv2 + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 IF !EMPTY( cObserv3 )
                    cMensagem:= cMensagem + cObserv3 + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 IF !EMPTY( cNome__ )
                    cMensagem:= cMensagem + cNome__ + Chr( 13 ) + Chr( 10 ) +;
                                cEndere + Chr( 13 ) + Chr( 10 ) +;
                                Alltrim( cCidade ) + "-" + cEstado + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 cCrediario:= "Pagamento: A VISTA"
                 nCol:= 1
                 IF Len( aParcelas ) > 0 .AND. CarneInterno
                    cCrediario:= "                C  A  R  N  E                  " + Chr( 13 ) + Chr( 10 )
                    cCrediario:= cCrediario + "Pr---Vencim--Valor------Pr---Vencim--Valor-----" + Chr( 13 ) + Chr( 10 )
                    FOR nCt:= 1 TO Len( aParcelas )
                        cVlr:= Tran( aParcelas[ nCt ][ 3 ], "@E 999,999.99" )
                        cVenc:= DTOC( aParcelas[ nCt ][ 4 ] )
                        cP:= Str( aParcelas[ nCt ][ 2 ], 3, 0 )
                        cCrediario:= cCrediario + cP + " " + cVenc + " " + cVlr
                        IF nCol==2 .OR. nCt == Len( aParcelas )
                           cCrediario:= cCrediario + Chr( 13 ) + Chr( 10 )
                           nCol:= 0
                        ENDIF
                        nCol:= nCol + 1
                        nCodCli:= 0
                    NEXT
                    cCrediario:= cCrediario + "***-----------------*** ***-----------------***" + Chr( 13 ) + Chr( 10 )
                    cMensagem:= cMensagem + cCrediario
                 ELSEIF !CarneInterno
                    cCrediario:= ""
                    cCrediario:= cCrediario + "Pr---Vencim--------------------------VALOR-----" + Chr( 13 ) + Chr( 10 )
                    FOR nCt:= 1 TO Len( aParcelas )
                        cVlr:= Tran( aParcelas[ nCt ][ 3 ], "@E 999,999.99" )
                        cVenc:= DTOC( aParcelas[ nCt ][ 4 ] )
                        cP:= Str( aParcelas[ nCt ][ 2 ], 3, 0 )
                        cCrediario:= cCrediario + cP + " " + cVenc + "......................... " + cVlr + Chr( 13 ) + Chr( 10 )
                        FOR nLin:= 1 TO 5
                            cCrediario:= cCrediario + " " + Chr( 13 ) + Chr( 10 )
                        NEXT
                        nCol:= nCol + 1
                        nCodCli:= 0
                    NEXT
                 ENDIF
                 IF nPerAcrDes > 0 .AND. nVlrAcrDes==0
                    nVlrAcrDes:= ROUND( ( nTotal * nPerAcrDes ) / 100, 2 )
                    nPerAcrDes:= 0
                 ENDIF
                 IF lPrinter
                    impFechaSem( nPerAcrDes, nVlrAcrDes, nTotal, nValorPago, cMensagem, cCgcCpf )
                 ENDIF

                 BaixaEstoque( aProduto )
                 LancaCupom( aProduto, aCliente, nValorPagar )
                 Scroll( MaxLin() - nMaximoItensTela, 1 + nColuna, MaxLin()-2, 45 )
                 @ 18,02 + nColuna SAY " Fim de Cupom Fiscal "
                 @ 19,02 + nColuna SAY "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
                 @ 20,02 + nColuna SAY "≥ CANCELA - [ F10 ] ≥"
                 @ 21,02 + nColuna SAY "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
                 Scroll( 03, 01 + nColuna, 12, 44, 0 )
                 @ 04,02 SAY "∞∞∞∞∞∞∞∞∞∞ CONDICOES DE PAGAMENTO ∞∞∞∞∞∞∞∞∞"
                 FOR nCt:= 1 TO Len( aParcelas )
                     nPercentual:= aParcelas[ nCt ][ 1 ]
                     nPrazo:=      aParcelas[ nCt ][ 2 ]
                     nParcela:=    aParcelas[ nCt ][ 3 ]
                     dVencimento:= aParcelas[ nCt ][ 4 ]
                     dPagamento:=  aParcelas[ nCt ][ 5 ]
                     nBanco:=      aParcelas[ nCt ][ 6 ]
                     cCheque:=     aParcelas[ nCt ][ 7 ]
                     nLocal:=      aParcelas[ nCt ][ 8 ]
                     @ nCt+4,02 Say "   " + Tran( nPercentual, "@E 999.99" ) +;
                                 Tran( nParcela, "@E 9,999,999.99" ) + " " +;
                                 DTOC( dVencimento ) Color "14/01"
                 NEXT
                 IF lPrinter
                    ImpAbreGaveta()
                 ENDIF
                 Inkey(0)
                 Scroll( 03, 01 + nColuna, 12, 44, 0 )
                 IF LastKey() == K_F10
                    AnulaCupom( impCupomAtual() )
                    IF lPrinter
                       ImpCancCupom()
                    ENDIF
                    RetornaEstoque( aProduto )
                 ELSEIF LastKey() == K_F9
                    IF lPrinter
                       Autentica( 0 )
                       Inkey(0)
                    ENDIF
                 ELSEIF LastKey() == K_ESC
                    LancaReceber( aParcelas, aCliente )
                    LancaEmCaixa( nValorPagar )
                    BC_Fim()
                    Cls
                    Set Printer To LPT1
                    Ferase( "CUPOM.TXT" )
                    Quit
                 ENDIF
                 /* Se nao for cancelado o cupom,
                    fazer o lancamento em caixa */
                 IF !LastKey() == K_F10
                    IF Len( ALLTRIM( cCrediario ) ) > 100 .AND. lPrinter .AND. !CarneInterno
                       ImpCarne( cCrediario, cNome__,;
                                 IF( !Empty( cCgc___ ), Tran( cCgc___, "@R 99.999.999/9999-99" ),;
                                                     Tran( cCpf___, "@R 999.999.999-99" ) ) )
                    ENDIF
                    LancaReceber( aParcelas, aCliente )
                    LancaEmCaixa( nValorPagar )
                 ENDIF
                 DBUnLockAll()
                 IF Protegido
                    Set Printer To "CUPOM.TXT"
                    Set device To Screen
                 ENDIF
                 lCupomAberto:= .F.
                 Exit
              ELSE
                 oTb:RefreshAll()
                 WHILE !oTb:Stabilize()
                 ENDDO
              ENDIF
         CASE nTecla >= 32 .AND. nTecla <= 126
              cDescricao:= Chr( nTecla ) + Space( Len( DESCRI ) - 1 )
              Scroll( nLinQtd, 02 + nColuna, nLinQtd, 44 )
              Keyboard Chr( K_RIGHT )
              SetCursor( 1 )
              @ nLinQtd,2 + nColuna Say "Procurar: " Get cDescricao Pict "@!S24"
              READ
              SetCursor( 0 )
              DBSetOrder( 1 )
              oTb:GoTop()
              DBSeek( cDescricao, .T. )
              oTb:RefreshAll()
              WHILE !oTb:Stabilize()
              ENDDO
              lMostra:= .T.

         CASE nTecla == K_F9
              Autentica( 0 )

         CASE nTecla == K_F10
              IF lPrinter
                 ImpAbreGaveta()
              ENDIF

         OTHERWISE                ;tone(125); tone(300)
              lDisplay:= .F.
      ENDCASE
      IF lRefaz .AND. !nTecla == K_ENTER
         oTb:RefreshAll()
         WHILE !oTb:Stabilize()
         ENDDO
         lRefaz:= .F.
      ENDIF
      IF lDisplay
         oTB:refreshcurrent()
         oTB:stabilize()
      ENDIF
   enddo
ENDDO
BC_Fim()
DO CASE
   CASE Impressora=="URANO"
        EndComm()
ENDCASE

/*====================================
Funcao      TOTAL
Finalidade  Display o total da Compra
Parametros  nTotal = Valor total
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function Total( nTotal )
Local cFileFonte:= "P31SERF.BCM"
Local cFonte
cFonte:= BC_FONTEM( cFileFonte )
if cfonte <> 0
   BC_DTEXTM(15,-1,-1,"", cFonte, nCorFundo)
   BC_TEXTM( 0.02+((nColuna+3)/100), .60, "Total        R$ " +;
       Tran( nTotal, "@E 99,999.99" ) + SPACE( 5 ) )
else
   //@ 10,20 say "ERRO: O arquivo de fonte nao foi encontrado: " + cFileFonte
endif
BC_LIBFM( cFonte )

/*====================================
Funcao      MOSTRA
Finalidade  Display o produto e preco
Parametros  cDescri = Descricao do produto
            nPrecoV = Preco de Venda do Item
            nSai = Tipo de Saida
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function Mostra( cDescri, nPrecov, nSai )
Local cCor:= SetColor()
Local cFileFonte:= "P12BOLD.BCM"
Local cFonte
cFonte:= BC_FONTEM( cFileFonte )
if cFonte <> 0
   IF nSai == NIL
      SETCOLOR( "15/00" )
      BC_DTEXTM(14,-1,-1,"", cFonte, 0 )
   ELSE
      SETCOLOR( "15/00" )
      BC_DTEXTM(15,-1,-1,"", cFonte, nSai )
   ENDIF
   SCROLL( 04, MaxCol() - 31, 12, MaxCol(), 1 )
   BC_TEXTM( 0.60, 0.56, cDescri + Space( 30 ) )
else
  // @ 10,20 say "ERRO: O arquivo de fonte nao foi encontrado: " + cFilefonte
endif
Bc_Libfm( cFonte )
SetColor( cCor )
Return Nil

/*====================================
Funcao      DISPLAYINFO
Finalidade  Display Informacoes diversas
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
FUNCTION DisplayInfo()
Local nome_Fonte, Fonte2, Fonte3, Fonte
&& carrega fonte em memoria.
nome_fonte = "P21NORM.BCM"
nome_f2 = "P26ITA.BCM"
fonte2 = BC_FONTEM(nome_f2)
nome_f3 = "P21NORM.BCM"
fonte3 = BC_FONTEM(nome_f3)
fonte = BC_FONTEM(nome_fonte)
IF nModoVideo == 20
   Scroll( 01, 01 + nColuna, 07, 44, 0 )
ENDIF
IF Fonte <> 0
   BC_DTEXTM(  14, -1, -1,"",fonte,nCorFundo) && muda cor do fonte p/ ciano claro.
   BC_TEXTM( 0.03 + ( (nColuna+1)/100), .85,  MPR->UNIDAD + SPACE( 20 ) )
   BC_DTEXTM(  12, -1, -1,"",fonte2,nCorFundo) && muda cor do fonte p/ ciano claro.
   BC_TEXTM( 0.03 + ( (nColuna+1)/100), .90, PAD( MPR->DESCRI, 80 ) )
   BC_DTEXTM(  11, -1, -1,"",fonte3,nCorFundo) && muda cor do fonte p/ ciano claro.
   BC_TEXTM( 0.03 + ( (nColuna+1)/100), .84, MPR->ORIGEM + Space( 10 ) )
   BC_TEXTM( 0.03 + ( (nColuna+1)/100), .79, "Saldo: " + Str( MPR->SALDO_, 8, 3 ) + SPACE( 20 ) )
   BC_TEXTM( 0.03 + ( (nColuna+1)/100), .74, "Preáo: " + Tran( MPR->PRECOV, "@E 99,999.99" ) + SPACE( 20 ) )
ELSE
   //@ 10,20 say "ERRO: O arquivo de fonte nao foi encontrado: " + nome_fonte
ENDIF
BC_LIBFM(fonte)                 && libera fonte matricial.
BC_LIBFM(fonte2)
BC_LIBFM(fonte3)

/*====================================
Funcao       SOFTWARE
Finalidade   Exibir SoftWare
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function SoftWare()
Local Texto, Cor
declare nome_fonte[2]
declare fonte[2]
arquivo = "simplex.bcv"
fonte[1] = BC_FONTEV(arquivo)
BC_DTEXTV(13, 3, 6, 0.2, 0.0, 0, 0, fonte[1])
texto = " SOFT&WARE "
cor = 15
BC_DTEXTV(cor, 6, 6, 0.2, 90, 0, 0, fonte[1])
BC_TEXTV(218, 2, texto)
BC_LIBFON(fonte[1])
return Nil

/*====================================
Funcao       TELAABERTURA
Finalidade   Apresenta a tela de abertura do sistema
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function TelaAbertura
Local cFileF1:= "P31SERF.BCM",;
      cFileF2:= "P26BOLD.BCM"
Local cFonte1, cFonte2
Local nCt, nCont, nPos, aTexto
BC_Inic( 25 )
BC_Limpa()                /* Limpa Video */
cFonte1:= BC_FONTEM( cFileF1 )
cFonte2:= BC_FONTEM( cFileF2 )
if cfonte1 <> 0
   BC_DTEXTM( 14, -1, -1, "", cFonte1, 0 )
   BC_TEXTM( 0.02, .02, "Sistema PDV-Soft&Ware Informatica" )
   nCont:= 0
   nPos:= 0
   atexto:= { "Sistema PDV-Soft&Ware",;
              "SOFT&WARE INFORMATICA" }

   BC_DTEXTM( 2, -1, -1, "", cFonte1, 0 )
   for nCt:= 1 to 28
       Scroll( 0, 0, 30, 79, 1 )
       if ++nCont == 2
          if nPos + 1 > Len( atexto )
             Exit
          endif
          BC_TEXTM( 0.02, .02, aTexto[ ++nPos ] )
          nCont:= 0
       endif
   next
   inkey( 1 )
   BC_DTEXTM( 4, -1, -1, "", cFonte2, 0 )
   for nCt:= 1 to 79
       Scroll( 0, 0, 30, 79, 1 )
       IF ++nCont == 2
         if nPos + 1 > Len( atexto )
             Exit
         endif
         BC_TEXTM( 0.02, .02, aTexto[ ++nPos ] )
         inkey()
       endif
   next
endif
BC_LIBFM( cFonte1 )
BC_LIBFM( cFonte2 )
SETCURSOR( 0 )
Return Nil

/*====================================
Funcao       EXIBETOTAIS
Finalidade   Apresenta os totais com fonte especial
Parametros   cRef = Referencia
             nValor = Valor Total a apresentar
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function ExibeTotais( cRef, nValor )
Local cFileF1:= "P31SERF.BCM",;
      cFileF2:= "P26BOLD.BCM"
Local cFonte1, cFonte2
cFonte1:= BC_FONTEM( cFileF1 )
cFonte2:= BC_FONTEM( cFileF2 )
if cfonte1 <> 0
   BC_DTEXTM( 11, -1, -1, "", cFonte1, nCorFundo )
   BC_TEXTM( 0.02+((nColuna+3)/100), .60, cRef + "     " + Tran( nValor, "@E 999,999,999.99" ) + Space(7) )
endif
BC_LIBFM( cFonte1 )
BC_LIBFM( cFonte2 )
SETCURSOR( 0 )
Return .T.

/*====================================
Funcao       PULA
Finalidade   Pula campos
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function Pula()
Keyboard Chr( LastKey() )
Return .T.

/*====================================
Funcao       ACRDES
Finalidade   Acrescenta
Parametros   cAcrDes = Acrescimo/Desconto
             nPerAcrDes = % Acrescimo/Desconto s/ total
             nVlrAcrDes = Vlr Acrescimo/Desconto s/ total
             nValorPagar = Valor a pagar (Passado por @referencia)
             nTotal = Valor Total (Passado por @referencia)
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function AcrDes( cAcrDes, nPerAcrDes, nVlrAcrDes, nValorPagar, nTotal )
IF cAcrDes == "A"
   IF nPerAcrDes > 0
      nValorPagar:= nTotal + ( ( nTotal * nPerAcrDes ) / 100 )
   ELSEIF nVlrAcrDes > 0
      nValorPagar:= nTotal + nVlrAcrDes
   ELSE
      nValorPagar:= nTotal
   ENDIF
ELSEIF cAcrDes == "D"
   IF nPerAcrDes > 0
      nValorPagar:= nTotal - ( ( nTotal * nPerAcrDes ) / 100 )
      nVlrAcrDes:= nTotal - nValorPagar
   ELSEIF nVlrAcrDes > 0
      nValorPagar:= nTotal - nVlrAcrDes
   ELSE
      nValorPagar:= nTotal
      nVlrAcrDes:= 0
   ENDIF
ENDIF
Return .T.

/*====================================
Funcao       NUMEROCUPOM
Finalidade   Retornar o numero do Cupom
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function NumeroCupom( cNum )
Static cNumeroCupom
IF !cNum == Nil
   IF cNum == "000000"
      cNumeroCupom:= Nil
   ELSE
      cNumeroCupom:= StrZero( CodigoCaixa, 3, 0 ) + cNum
   ENDIF
ENDIF
IF cNumeroCupom == Nil
   cNumeroCupom:= StrZero( CodigoCaixa, 3, 0 ) + impCupomAtual()
ENDIF
Return cNumeroCupom

/*====================================
Funcao       ANULACUPOM
Finalidade   Anular cupons lancados no sistema
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function AnulaCupom( nCupom )


/*====================================
Funcao       LANCACUPOM
Finalidade   Lanca Cupom no movimento de Cupons
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function LancaCupom( aProduto, aCliente, nValorPagar )
Local nValorIcm:= 0, nValorIpi:= 0, nValorBase:= 0
  Sele B
  DBCloseArea()
  Use &DiretoriodeDados\CUPOM___.VPB Alias CUP Shared
  Set Index To &DiretoriodeDados\CUPIND01.IGD,;
               &DiretoriodeDados\CUPIND02.IGD,;
               &DiretoriodeDados\CUPIND03.IGD,;
               &DiretoriodeDados\CUPIND04.IGD
  Sele C
  Use &DiretoriodeDados\CUPOMAUX.VPB Alias CPA Shared
  Set Index To &DiretoriodeDados\CAUIND01.IGD,;
               &DiretoriodeDados\CAUIND02.IGD,;
               &DiretoriodeDados\CAUIND03.IGD,;
               &DiretoriodeDados\CAUIND04.IGD,;
               &DiretoriodeDados\CAUIND05.IGD
  Sele C
  FOR nCt:= 1 TO Len( aProduto )
      IF A->( DBSeek( aProduto[ nCt ][ 9 ] ) )
         C->( DBAppend() )
         C->( RLock() )
         IF !A->( NetErr() )
            Replace C->CODIGO With aProduto[ nCt ][ 9 ],;
                    C->CODRED With aProduto[ nCt ][ 9 ],;
                    C->CODIGO With aProduto[ nCt ][ 9 ],;
                    C->DESCRI With A->DESCRI,;
                    C->MPRIMA With A->MPRIMA,;
                    C->UNIDAD With A->UNIDAD,;
                    C->QUANT_ With aProduto[ nCt ][ 5 ],;
                    C->PRECOV With aProduto[ nCt ][ 4 ],;
                    C->PRECOT With aProduto[ nCt ][ 5 ] * aProduto[ nCt ][ 4 ],;
                    C->CODNF_ With Val( NumeroCupom() )
         ENDIF
         IF !( A->IPICOD==4 )
            nValorIcm:= nValorIcm + ( C->PRECOT * Icm ) / 100
            nValorBase:= nValorIcm + ( C->PRECOT )
         ENDIF
         C->( DBUnlock() )
      ENDIF
  NEXT
  IF Len( aProduto ) <= 0
     Sele A
     Return Nil
  ENDIF
  Sele B
  DBAppend()
  IF !NetErr()
     Replace TIPONF With "S",;
             NATOPE With 5.12,;
             NUMERO With Val( NumeroCupom() ),;
             CLIENT With aCliente[ 1 ],;
             CDESCR With aCliente[ 2 ],;
             CCGCMF With aCliente[ 3 ],;
             CCPF__ With aCliente[ 4 ],;
             CENDER With aCliente[ 5 ],;
             CCIDAD With aCliente[ 6 ],;
             CESTAD With aCliente[ 7 ],;
             VLRNOT With nValorPagar,;
             VLRTOT With nValorPagar,;
             VLRICM With nValorIcm,;
             VLRIPI With nValorIPI,;
             BASICM With nValorBase,;
             FUNC__ With CodigoCaixa,;
             DATAEM With DATE(),;
             VENIN_ With aCliente[ 8 ]
  ENDIF
  Sele A
  Return Nil


/*====================================
Funcao       BAIXAESTOQUE
Finalidade   Baixar do estoque o produto
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function BaixaEstoque( aProduto )
Local nCt
  Sele G
  Use &DiretoriodeDados\CESTOQUE.VPB Alias EST Shared
  Set Index To &DiretoriodeDados\ESTIND01.IGD,;
               &DiretoriodeDados\ESTIND02.IGD,;
               &DiretoriodeDados\ESTIND03.IGD,;
               &DiretoriodeDados\ESTIND04.IGD
  Sele A
  dbSetOrder( 3 )
  FOR nCt:= 1 TO Len( aProduto )
      IF A->( DBSeek( aProduto[ nCt ][ 9 ] ) )
         A->( RLock() )
         IF !A->( NetErr() )
            Replace A->SALDO_ With A->SALDO_ - aProduto[ nCt ][ 5 ]
         ENDIF
         A->( DBUnlock() )
      ENDIF
      Sele G
      DBAppend()
      IF !NetErr()
         Replace CPROD_ With aProduto[ nCt ][ 9 ],;
                 CODRED With aProduto[ nCt ][ 9 ],;
                 ENTSAI With "-",;
                 QUANT_ With aProduto[ nCt ][ 5 ],;
                 DOC___ With "CF: " + NumeroCupom(),;
                 CODIGO With 0,;
                 VLRSDO With 0,;
                 VLRSAI With aProduto[ nCt ][ 5 ] * aProduto[ nCt ][ 4 ],;
                 VALOR_ With aProduto[ nCt ][ 5 ] * aProduto[ nCt ][ 4 ],;
                 DATAMV With Date(),;
                 RESPON With 0
      ENDIF
  NEXT
  Sele G
  DBCloseArea()
  Sele A
  Return Nil

/*====================================
Funcao       LancaEmCaixa
Finalidade   Lancar valores recebidos no movimento de caixa
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function LancaEmCaixa( nRecebido )
Local nCt
  Sele C
  Use &DiretoriodeDados\CAIXA___.VPB Alias CX Shared
  Set Index To &DiretoriodeDados\CX_IND01.IGD
  DBAppend()
  IF !NetErr()
     Replace DATAMV With DATE(),;
             VENDE_ With CodigoCaixa,;
             ENTSAI With "+",;
             MOTIVO With 00,;
             HISTOR With "CF: " + NumeroCupom(),;
             VALOR_ With nRecebido,;
             HORAMV With TIME(),;
             CDUSER With 0
  ENDIF
  Sele A
  Return Nil



/*====================================
Funcao       RetornaESTOQUE
Finalidade   Retornar material ao estoque
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function RetornaEstoque( aProduto )
Local nCt
  Sele B
  Use &DiretoriodeDados\CESTOQUE.VPB Alias ES1 Shared
  Set Index To &DiretoriodeDados\ESTIND01.IGD,;
               &DiretoriodeDados\ESTIND02.IGD,;
               &DiretoriodeDados\ESTIND03.IGD,;
               &DiretoriodeDados\ESTIND04.IGD
  Sele A
  dbSetOrder( 3 )
  FOR nCt:= 1 TO Len( aProduto )
      IF A->( DBSeek( aProduto[ nCt ][ 9 ] ) )
         A->( RLock() )
         IF !A->( NetErr() )
            Replace A->SALDO_ With A->SALDO_ + aProduto[ nCt ][ 5 ]
         ENDIF
         A->( DBUnlock() )
      ENDIF
      Sele B
      DBAppend()
      IF !NetErr()
         Replace CPROD_ With aProduto[ nCt ][ 9 ],;
                 CODRED With aProduto[ nCt ][ 9 ],;
                 ENTSAI With "+",;
                 QUANT_ With aProduto[ nCt ][ 5 ],;
                 DOC___ With "CF: " + NumeroCupom() + "C",;
                 CODIGO With 0,;
                 VLRSDO With 0,;
                 VALOR_ With aProduto[ nCt ][ 5 ] * aProduto[ nCt ][ 4 ],;
                 DATAMV With Date(),;
                 RESPON With 0
      ENDIF
  NEXT
  Sele B
  DBCloseArea()
  Sele A
  Return Nil




/*---------------------------------------------------------------------------
  By Valmor Pereira Flores
----------------------------------------------------------------------------*/

/*-------------------------------------------*/
#Include "COMMON.CH"
#Include "VPF.CH"

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ Relatorio
≥ Finalidade  ≥ Impressao de relatorio
≥ Parametros  ≥ cFile=>Nome do Aruivo
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Nil
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
FUNCTION Relatorio( cFile, cDiretorio )
LOCAL cTela:= SAVESCREEN(00,00,24,79)
IF cDiretorio == Nil
   cDiretorio:= "\" + CURDIR()
ENDIF
IF FILE( ALLTRIM( cDiretorio - "\" - cFile ) )
   Impressao( ALLTRIM( cDiretorio - "\" - cFile ) )
ELSE
   Aviso( "Arquivo " + cDiretorio - "\" - cFile +" nao encontrado neste diret¢rio...", 12 )
   Pausa()
ENDIF
RESTSCREEN( 00, 00, 24, 79, cTela )
RETURN NIL

STATIC FUNCTION DispStatus( cArquivo, nLinha, cProcesso, lFlag, nControl )
LOCA cCor:= SETCOLOR(), cDevice
IF SET( 20 )=="PRINT" .OR. nControl<>Nil
   cDevice:= SET( 20, "SCREEN" )
ELSE
   RETURN Nil
ENDIF
IF lFlag
   VPBOX(01,01,07,65,"Monitor de Relatorio","12/04",.T.,.T.,"14/12")
   SetColor( "15/04" )
   DEVPOS( 02, 02 ); DEVOUT("Sistema Gerador de Relatorios (REP)          ")
   DEVPOS( 03, 02 ); DEVOUT("Hora.........: " + TIME() )
   DEVPOS( 04, 02 ); DEVOUT("Arquivo......: " + cArquivo )
   DEVPOS( 05, 02 ); DEVOUT("Linha........: " + LTRIM( STR( nLinha ) ) )
   DEVPOS( 06, 02 ); DEVOUT("Processo.....: " + LEFT( cProcesso, 45 ) )
   VPBOX( 08, 01, 21, 65, ,"15/01" )
ENDIF
SETCOLOR( "15/04" )
Scroll( 03, 17, 06, 64 )
DEVPOS( 03, 17 ); DEVOUT( TIME() )
DEVPOS( 04, 17 ); DEVOUT( cArquivo )
DEVPOS( 05, 17 ); DEVOUT( LTRIM( STR( nLinha ) ) )
DEVPOS( 06, 17 ); DEVOUT( LEFT( cProcesso, 45 ) )
IF ! Left( cProcesso, 1 ) $ ":$" + Chr( 27 )
   SetColor( "15/01" )
   Scroll( 09, 02, 20, 64, 1 )
   @ 20,02 Say Left( cProcesso, 62 )
ENDIF
SET( 20, cDevice )
SETCOLOR(cCor)
RETURN NIL

STATIC FUNC IMPRESSAO( cARQUIVO )
Local GetList:= {}, MenuList:= {}
LOCAL aImp:={}, aImpFORMAT:={}, aImpRESSAO:={},;
      cCAMPO, lPulaLinha:= .F.,;
      nLargura:=80, nCt, nCt2, nPosIni, nPosFim, cString, cImpressao,;
      variavel, VIf, cVariavel, nComando, nQtd, nLocalTam, nVarTam,;
      nDiferenca, nQuantTirar, Verificador, lJump:=.F., aDefinicoes:={},;
      lPassadaDupla:= .F.

WHILE .T.

   cCAMPO:=MEMOREAD( cARQUIVO )

   /* Cria matriz com os dados de impressao */
   aImpRESSAO:=IOFillText( cCAMPO )

   /* Cria duas replicas de aImpRESSAO */
   FOR nCT:=1 TO LEN( aImpRESSAO )
       AADD( aImp, IF( LEFT( ALLTRIM( aImpRESSAO[nCT] ), 1 )==":",;
            ALLTRIM( SUBSTR( ALLTRIM( aImpRESSAO[nCT] ), 2 ) ), "" ) )
       AADD( aImpFormat, aImpRESSAO[nCT] )
   NEXT

   FOR nCt:=1 TO Len( aImpressao )
       /* Comando INCLUDE para Chamar um arquivo externo de definicoes */
       IF LEFT( UPPER( LTRIM( aImpressao[nCt] ) ), 8 ) == "$INCLUDE"
          IF !File( ALLTRIM( "\" + CURDIR() - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) )
             Aviso( "Arquivo " + ALLTRIM( "\" + CURDIR() - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) + " nao foi localizado. ", 12 )
             Pausa()
          ENDIF

          cDefines:= MEMOREAD( ALLTRIM( "\" + CURDIR() - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) )
          aDefines:= IOFillText( cDefines )
          FOR nCt2:= 1 TO LEN( aDefines )
              AADD( aDefinicoes, SUBSTR( aDefines[nCt2], 9 ) )
              aImp[nCt]:="$_DEFINICAO_$"
          NEXT
       ENDIF
   NEXT

   /* Pesquisa as definicoes de $define */
   FOR nCt:=1 TO LEN( aImpRESSAO )
       IF LEFT( UPPER( LTRIM( aImpRESSAO[nCt] ) ), 7 ) == "$DEFINE"
          AADD( aDefinicoes, SUBSTR( ALLTRIM( aImpressao[nCt] ), 9 ) )
          aImp[nCt]:="$_DEFINICAO_$"
       ENDIF
   NEXT

   /* Faz a substituicao cfe. definicoes */
   FOR nCt:=1 TO LEN( aDefinicoes )

       /* Pega a posicao inicial do sinal > na variavel */
       nPosIni:= AT( ">", aDefinicoes[nCt] )

       /* Faz a pesquisa na matriz principal */
       FOR nCt2:=1 TO LEN( aImpFormat )

          /* Pega a string a ser substituida */
          cString:= ALLTRIM( LEFT( aDefinicoes[nCt], nPosIni -1 ) )

          IF AT( cString, aImpressao[nCt2] ) >0 .AND. aImp[nCt2]<>"$_DEFINICAO_$"

             /* Pega a que ira substituir a anterior */
             cVariavel:= ALLTRIM( SUBSTR( aDefinicoes[nCt], nPosIni + 1 ) )

             /* Faz a substituicao de strings */
             aImpFormat[nCt2]:= STRTRAN( aImpressao[nCt2], cString, cVariavel )
             aImpressao[nCt2]:= STRTRAN( aImpressao[nCt2], cString, cVariavel )

          ENDIF
       NEXT
   NEXT


   FOR nCt:= 1 TO Len( aImpressao )
       IF ( nPosicao:= AT( ":=", aImpressao[ nCt ] ) ) > 0 .AND.;
          !( AT( "$", aImpressao[ nCt ] ) > 0 )
          aImpressao[ nCt ]:= "$SetVariavel( '" + ;
                              AllTrim( Left( aImpressao[ nCt ], nPosicao - 1 ) ) +;
                              "', '" + Alltrim( SubStr( aImpressao[ nCt ], nPosicao + 2 ) ) + " ' )"
       ELSEIF  AT( "(", aImpressao[ nCt ] ) > 0 .AND.;
              !AT( "$", aImpressao[ nCt ] ) > 0 .AND.;
              !AT( "Æ", aImpressao[ nCt ] ) > 0 .AND.;
              !Left( AllTrim( aImpressao[ nCt ] ), 1 ) == ":" .AND.;
              !AT( "/*", aImpressao[ nCt ] ) > 0
          aImpressao[ nCt ]:= "$" + AllTrim( aImpressao[ nCt ] )
       ENDIF
       nPosicao:= 0
   NEXT

   DispStatus( cArquivo, nCt, aImpFormat[1], .T., 1 )

   FOR nCT:=1 to Len( aImpRESSAO )

       DispStatus( cArquivo, nCt, aImpFormat[nCt], .F. )

       IF INKEY()==27 .OR. NEXTKEY()==27 .OR. LASTKEY()==27
          SET( 20, "SCREEN" )
          RETURN Nil
       ENDIF

       nComando:=0
       lJump:= .F.

       IF UPPER( LEFT( ALLTRIM( aImpressao[nCt] ), 8 ) )=="$VAIPARA"
          nComando:= 4
       ELSEIF AT( "$LINHAON",  UPPER( aImpressao[nCT] ) ) >0
          lPulaLinha:= .T.
          aImp[nCT]:= "*_NULA_*"
       ELSEIF AT( "$LINHAOFF", UPPER( aImpressao[nCT] ) ) >0
          lPulaLinha:= .F.
          aImp[nCT]:= "*_NULA_*"
       ELSEIF AT( "$LARGURA",  UPPER( aImpressao[nCT] ) ) >0
          nComando:=6
       ELSEIF AT( "$CALL",     UPPER( aImpressao[nCT] ) ) >0
          nComando:=7
       ELSEIF AT( "$RETORNA",  UPPER( aImpressao[nCt] ) ) >0
          nComando:=8
       ELSEIF AT( "$DEFINE",   UPPER( aImpressao[nCt] ) ) >0
          nComando:=9
       ELSEIF AT( "$FIM",      UPPER( aImpressao[nCt] ) ) >0
          RETURN Nil
       ELSEIF AT( "$PASSADADUPLA", UPPER( aImpressao[nCt] ) ) >0
          lPassadaDupla:= .T.
          aImp[nCT]:= "*_NULA_*"
       ELSEIF LEFT( ALLTRIM( aImpRESSAO[nCt] ), 1 ) == "$"
          nComando:= 1
       ELSEIF LEFT( ALLTRIM( aImpRESSAO[nCt] ), 2 ) == "//" .OR.;
              LEFT( ALLTRIM( aImpRESSAO[nCt] ), 2 ) == "/*" .OR.;
              LEFT( ALLTRIM( aImpRESSAO[nCt] ), 1 ) == "*"
          nComando:= 2
       ELSEIF AT( "Æ", aImpRESSAO[nCT] ) > 0
          nComando:= 3
       ELSEIF LEFT( ALLTRIM( aImpRESSAO[nCt] ), 1 ) == ":"
          nComando:= 5
       ENDIF

       DO CASE
          CASE nComando == 1

               /* Transfere dados p/ variavel de trabalho */
               cIMPRESSAO:= ALLTRIM( aImpRESSAO[nCT] )

               /* Pega as posicoes */
               nPosIni:= AT( "$", cIMPRESSAO )
               nPosFim:= LEN( cIMPRESSAO )
               nQtd:= nPosFim - nPosIni
               Variavel:= SUBSTR( cIMPRESSAO, nPosIni + 1, nQtd )

               /* Pega o valor que contem a variavel */
               IF AT( "(", cIMPRESSAO ) > 0
                  Variavel:= EVAL( &("{|| "+Variavel+"}") )
               ENDIF

               /* Anula a String */
               aImp[nCt]:= "*_NULA_*"

               /* Transporta resultado p/ impressao formatada */
               aImpFormat[nCT]:= cIMPRESSAO

          CASE nComando == 2

               /* Anula a String */
               aImp[nCT]:= "*_NULA_*"

          CASE nComando == 3

               cIMPRESSAO:= aImpRESSAO[nCT]

               WHILE AT( "Æ", cIMPRESSAO ) > 0

                   /* Pega as posicoes */
                   nPosIni:= AT("Æ", cIMPRESSAO )
                   nPosFim:= AT("Ø", cIMPRESSAO )
                   nQtd:= nPosFim - nPosIni

                   /* Pega a String que sera substituida */
                   cSTRING:= SUBSTR( cIMPRESSAO, nPosIni, nQtd + 1 )

                   //cString:= NToC( cString )

                   /* Pega tamanho da variavel */
                   nLocalTam:= LEN( cSTRING )

                   Variavel:= SUBSTR( cIMPRESSAO, nPosIni + 1, nQtd - 1 )
                   //Variavel:= NToC( Variavel )

                   /* Pega o valor que contem a variavel */
                   IF AT( "(", cSTRING ) > 0 .OR.;
                      AT( "->", cSTRING ) > 0
                      Variavel:= EVAL( &("{|| "+Variavel+"}") )
                   ELSEIF !EMPTY(Variavel)
                      Variavel:= EVAL( FIELDBLOCK( Variavel ) )
                   ENDIF

                   nVarTam:= LEN( Variavel )

                   IF nLocalTam > nVarTam
                      nQuantTirar:= nLocalTam
                      nDiferenca:= nLocalTam - nVarTam
                      Variavel:= Variavel+SPACE( nDiferenca )
                   ELSEIF nVarTam >= nLocalTam
                      nQuantTirar:= nVarTam
                   ENDIF

                   /* Substitui */
                   cIMPRESSAO:= STUFF( cIMPRESSAO, nPosIni, nQuantTirar, Variavel )

              ENDDO

              aImpFormat[nCT]:= cIMPRESSAO

         CASE nComando == 4

              VIf:={"","",""}

              cIMPRESSAO:= aImpRESSAO[nCT]

              cVariavel:= aImpRESSAO[nCT]

              FOR nCT2:= 1 TO 3

                  /* Pega as posicoes e tamanho */
                  IF nCt2 == 1
                     nPosIni:= AT( "(", cVariavel )
                  ELSEIF nCt2 >= 2
                     nPosIni:= 1
                  ENDIF

                  IF ( nPosFim:= AT( ",", cVariavel ) ) == 0
                      nPosFim:= AT( ")", cVariavel )
                  ENDIF

                  nQtd:= nPosFim - nPosIni

                  /* Pega o verificador nCT2 */
                  VIf[nCT2]:= SUBSTR( cVariavel, nPosIni + 1, nQtd -1 )

                  /* Altera o valor do nCT2 atual para null */
                  cVariavel:= SUBSTR( cVariavel, nPosFim + 1 )

                  IF nCt2==3 .AND. ALLTRIM( VIf[3] ) == ""
                     VIf[3]:="Nil"
                  ENDIF
              NEXT

              /* Verifica se o primeiro parametro nao Ç um label */
              IF ( nCT2:= ASCAN( aImp, ALLTRIM( VIf[1] ) ) ) > 0
                 IF nCt2 > 1 .AND. nCt2 < LEN( aImpRESSAO )
                    nCt:= nCt2 - 1
                    lJump:= .T.
                 ELSE
                    SET(20,"SCREEN")
                    SCROLL(00,00,24,79)
                    @ 01,00 SAY "LABEL "+VIf[1]+" NAO ENCONTRADO...."
                    QUIT
                 ENDIF
              /* Testa a condicao, pois Ç um jump (pulo) condicional */
              ELSE
                 /* Se for a primeira */
                 IF ( Verificador:= Eval( &("{|| "+VIf[1]+"}") ) )
                    nCT2:= ASCAN( aImp, ALLTRIM( VIf[2] ) )
                 ELSE /* Se for a segunda */
                    IF VIf[3]<>"Nil"
                       nCT2:= ASCAN( aImp, ALLTRIM( VIf[3] ) )
                    ELSE
                       nCT2:= nCT + 1
                    ENDIF
                 ENDIF

                 aImp[nCT]:="*_NULA_*"

                 IF UPPER( VIf[3] ) == "NIL" .AND. !Verificador
                    lJump:= .T.
                 ELSE
                    IF nCT2 > 0 .AND. nCT2 <= LEN( aImpRESSAO )
                       nCT:= nCT2 - 1
                       lJump:= .T.
                    ELSE
                       IF nCt + 1 < LEN( aImpRESSAO )
                          lJump:= .T.
                       ELSE
                          lJump:= .F.
                       ENDIF
                    ENDIF
                 ENDIF
              ENDIF

          CASE nComando == 5

               /* Criacao de Label */
               nPosIni:= AT( ":", aImpRESSAO[nCT] )
               nPosFim:= LEN( aImpRESSAO[nCT] )
               nQtd:= nPosFim - nPosIni

               aImp[nCT]:= ALLTRIM( SUBSTR( aImpRESSAO[nCT], nPosIni + 1, nPosFim - 1 ) )

          CASE nComando == 6

               /* Localizacao da largura do texto */
               nPosIni:= AT( "(", aImpRESSAO[nCT] )
               nPosFim:= AT( ")", aImpRESSAO[nCT] )
               nLargura:= VAL( SUBSTR( aImpRESSAO[nCT], nPosIni+1, nPosFim - nPosIni - 1 ) )

          CASE nComando == 7
               /* Localizacao da largura do texto */
               nPosIni:= AT( "(", aImpRESSAO[nCT] )
               nPosFim:= AT( ")", aImpRESSAO[nCT] )

               SaveStatus( aImpressao, aImp, aImpFormat, nCt )

               cArquivo:= ALLTRIM( SUBSTR( aImpRESSAO[nCT], nPosIni+1, nPosFim - nPosIni - 1 ) )
               nCt:=1
               aImp:={}
               aImpFormat:={}
               aImpRESSAO:={}
               lJump:= .T.
               EXIT

          CASE nComando == 8
               RestoreStatus( @aImpressao, @aImp, @aImpFormat, @nCt )
               lJump:= .T.
       ENDCASE

       IF EMPTY( aImp[nCT] ) .AND. !lJump
          DEVPOS( IF( lPulaLinha, Linha( 1 ), Linha( NIL ) ), 00 )
          DEVOUT("")
          DEVOUT( RTRIM( aImpFormat[nCt] ) )
          IF lPassadaDupla
             DEVPOS( Linha( NIL ), 00 )
             DEVOUT("")
             DEVOUT( RTRIM( aImpFormat[nCt] ) )
          ENDIF

       ENDIF
   NEXT
ENDDO
RETURN NIL


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ SetVariavel
≥ Finalidade  ≥ Set uma variavel de memoria
≥ Parametros  ≥ cNome / cExpressao / VarList
≥ Retorno     ≥
≥ Programador ≥
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
FUNCTION SetVariavel( cNome, cExpressao, aLista )
Public c___, a___
M->a___:= cExpressao
M->c___:= cNome
Public &c___ := &(a___)
Release M->c___, M->a___
IF PCOUNT() >= 3
   AADD( aLista, cNome )
ENDIF
Return NIL

FUNCTION ClearMemory( aLista )
LOCAL nCt:= 1
FOR nCt:= 1 TO LEN( aLista )
    ClearVariavel( aLista[nCt] )
NEXT
RETURN NIL

FUNCTION ClearVariavel( cNome )
Public c, a
M->c:= cNome
Public &c
Release &c

FUNCTION Linha( nLin )
IF nLin == NIL
   Return( IF( Set(20)=="PRINT", Prow(), Row() ) )
ELSE
   nLin+= IF( Set(20)=="PRINT", Prow(), Row() )
   @ nLin,00 SAY Space(0)
ENDIF
RETURN NIL

FUNCTION IndexFile( cArquivo, cCampo )
dbCreateIndex( cArquivo, cCampo, &("{||"+cCampo+"}"), if( .F., .T., NIL ) )
Return Nil

FUNCTION ReOrganiza( cArquivo )
if !.F.
   ordListClear()
end
ordListAdd( cArquivo )
RETURN Nil

FUNCTION Filtro( cCampo )
dbSetFilter( &("{||"+cCampo+"}"), cCampo )
RETURN Nil

FUNCTION Say( nLin, nCol, cString )
DevPos( IF( nLin<>Nil, nLin, Row() ), IF( nCol<>Nil, nCol, Col() ) )
DevOut( IF( cString<>NIL, cString, "") )
RETURN Nil

FUNCTION VPFGet( cVariavel, cPicture, bwhen, bvalid )
AAdd( M->GetList, _GET_( &cVariavel, cVariavel, cPicture , bwhen, bvalid ):display() )
RETURN Nil

FUNCTION ListGet( nLin, nCol, cString, cVariavel, cPicture, bWhen, bValid )
Say( nLin, nCol, cString )
AAdd( M->GetList, _GET_( &cVariavel, cVariavel, cPicture , bWhen, bValid ):display() )
RETURN Nil

FUNCTION SayGet( nLin, nCol, cString, cVariavel, cPicture, bWhen, bValid )
Say( nLin, nCol, cString )
AAdd( M->GetList, _GET_( &cVariavel, cVariavel, cPicture , bWhen, bValid ):display() )
RETURN Nil


FUNCTION VerPilha( aIncremento )
STATIC Pilha
Pilha:= IF( Pilha==NIL, {}, Pilha )
IF( aIncremento <> NIL, AADD( Pilha, aIncremento ), NIL )
RETURN Pilha

FUNCTION SaveStatus( aImpRESSAO, aImp, aImpFormat, nPosicao )
VerPilha( { aImpRESSAO, aImp, aImpFormat, nPOSICAO } )
RETURN NIL

FUNCTION RestoreStatus( aImpressao, aImp, aImpFormat, nPosicao, nCodigo )
LOCAL Pilha:= VerPilha()
Pilha:= IF( Pilha==NIL, {}, Pilha )
IF nCodigo == NIL
   nCodigo:= LEN( Pilha ) - 1
ENDIF
IF nCodigo<=0
   nCodigo:=1
ENDIF
aImpressao:= Pilha[nCodigo][1]
aImp:= Pilha[nCodigo][2]
aImpFormat:= Pilha[nCodigo][3]
nPosicao:= Pilha[nCodigo][4]
RETURN Nil

FUNCTION IOMenu( cVariavel, Valor )
LOCAL nOpcao:= 0
Priv bBlock:= "{|_1| if( PCount() == 0, "+cVariavel+", "+cVariavel+" := _1)}"
nOpcao := __MenuTo( &( bBlock ), cVariavel )
&cVariavel:= nOpcao
return nOpcao

FUNCTION Variavel( Nada )
RETURN Nil

Function ImprimeFile( cArquivo )
  PRIVATE cArq:= cArquivo
  Set Printer To ARQUIVO2.PRN
  Set Device To Printer
  cCampo:= MEMOREAD( cArquivo )
  aArquivo:= IOFillText( cCampo )
  FOR nCt:= 1 TO Len( aArquivo )
      @ nCt - 1, 0 Say aArquivo[ nCt ]
  NEXT
  Set Device To Screen
Return Nil


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ CONDENSADO/NEGRITO/ITALICO/DRAFT
≥ Finalidade  ≥ Retornam uma string de formatacao conforme o fonte, portanto
≥             ≥ usar num .REP da seguinte forma: Ex. ÆCondensado(.T.)Ø
≥ Parametros  ≥ lSim-Liga/Desliga Condensado/Negrito/Etc.
≥ Retorno     ≥ String
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Abril/1998
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/

Function Condensado( lSim )
Return BuscaFonte( IF( lSim, {|| A_COND }, {|| A_NORM } ) )

Function Draft()
Return BuscaFonte( {|| A_NORM } )

Function Negrito( lSim )
Return BuscaFonte( IF( lSim, {|| A_NEGR }, {|| D_NEGR } ) )

Function Italico( lSim )
Return BuscaFonte( IF( lSim, {|| A_ITAL }, {|| D_ITAL } ) )

Function Expandido( lSim )
Return BuscaFonte( IF( lSim, {|| A_EXPA }, {|| D_EXPA } ) )

Function ImpLinhas()
Return 64

Function LandScape()

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ BUSCAFONTE
≥ Finalidade  ≥ Conforme o device, busca a impressora e o fonte cfe.
≥             ≥ o parametro campo para a mesma e retorna uma string
≥             ≥ com a configuracao para a impressora e determinado
≥             ≥ fonte cfe. as rotinas de chamada acima, Ngrito(),
≥             ≥ Condensado()
≥ Parametros  ≥ bCampo-Bloco com o nome do campo a retornar
≥ Retorno     ≥ cString-String de formatacao de impressora
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Abril/1998
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function BuscaFonte( bCampo )
Local cCampo, cString:= ""
Local nArea:= Select(), nOrdem:= IndexOrd(), cDevice
DBSelectAr( 1 )
IF !Used()
   DBUseArea( .F.,, "IMPCFG00.SYS", "IMP", .T., .F. )
ENDIF
Index On PORTA_ to IMPCFG02.INT
Set Index To IMPCFG02.INT
IF AT( ".", Set( 24 ) ) > 0
   cDevice:= SubStr( Set( 24 ), 1, At( ".", Set( 24 ) ) - 1 )
ELSE
   cDevice:= Set( 24 )
ENDIF
DBSeek( cDevice, .T. )
IF Alltrim( PORTA_ ) == AllTrim( cDevice )
   cCampo:= Eval( bCampo )
   FOR nCt:= 1 TO Len( cCampo )
       cString:= cString + Chr( Val( SubStr( cCampo, 1, At( ",", cCampo ) - 1 ) ) )
       cCampo:= SubStr( cCampo, At( ",", cCampo ) + 1 )
   NEXT
   cString:= cString - Chr( Val( SubStr( cCampo, 1 ) ) )
ENDIF
DBSelectAr( nArea )
DBSetOrder( nOrdem )
Return cString



/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ IOFillText()
≥ Finalidade  ≥ Preencher um array com informacoes de um arquivo texto
≥ Parametros  ≥ cCampo - Variavel c/ o campo: Ex. IOFilltext( MEMOREAD( "COPIA.REP" ) )
≥ Retorno     ≥ aArray
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function IOFillText( cCampoMemo )
LOCAL aTexto:= {}, nFinalLinha
WHILE .T.
    nFinalLinha:= AT( CHR( 13 ) + CHR( 10 ), cCampoMemo )
    AADD( aTexto,  SubStr( cCampoMemo, 1 , nFinalLinha - 1 ) )
    cCampoMemo:= SubStr( cCampoMemo, nFinalLinha + 2 )
    IF Empty( cCampoMemo )
       Exit
    ENDIF
ENDDO
RETURN aTexto


Function VPBox( nLin1, nCol1, nLin2, nCol2 )
@ nLin1, nCol1 To nLin2, nCol2
Return Nil

Function Pausa()
Inkey(0)

Function Aviso( cAviso )
Local cCor:= SetColor()
SetColor( "15/04" )
@ 24,00 Say cAviso
SetColor( cCor )
Return Nil

/*
* Modulo      - SCREENSAVE
* Finalidade  - Gravar parte da tela e suas coordenadas na variavel caracter.
* Parametros  - LIN1,COL1,LIN2,COL2=>Coordenadas.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screensave(LIN1,COL1,LIN2,COL2)
Local cTela
cTela:=chr(LIN1)+CHR(COL1)+CHR(LIN2)+CHR(COL2)+savescreen(LIN1,COL1,LIN2,COL2)
return(cTela)

/*
* Modulo      - SCREENREST
* Finalidade  - Carregar a tela a partir da variavel criada por SCREENSAVE()
*               Recupera as coordenadas originais da tela
* Parametros  - TELA=>Variavel que contem a tela.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screenrest(TELA)
restscreen(asc(substr(TELA,1,1)),asc(substr(TELA,2,1)),;
           asc(substr(TELA,3,1)),asc(substr(TELA,4,1)),substr(TELA,5))
return nil


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ CalcVenc
≥ Finalidade  ≥ Ajustar a data de vencimento cfe. a quantidade de dias
≥ Parametros  ≥ dDataBase, nDias, dVencimento
≥ Retorno     ≥ .T.
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function CalcVenc( dDataBase, nDias, dDataVencimento )
dDataVencimento:= dDataBase + nDias
Return .T.


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ CalcParcela
≥ Finalidade  ≥ Calcula parcela
≥ Parametros  ≥ nValorPagar, nPercentual, nParcela
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function CalcParcela( nValorPagar, nPercentual, nParcela, lManual )
IF !lManual
   nParcela:= ( nValorPagar * nPercentual ) / 100
ENDIF
Return .T.


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ FORMAPAGAMENTO
≥ Finalidade  ≥ Apresentacao das formas de pagamentos disponiveis
≥ Parametros  ≥ nLin1, nCol1, nLin2, nCol2, aParcelas
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Novembro/1998
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function FormaPagamento( nLin1, nCol1, nLin2, nCol2, aParcelas, nValorPagar, nVezes, nForma )
Local nArea:= Select()
Local oTb

   DBSelectAr( 22 )
   Use &DiretoriodeDados\CDDUPAUX.VPB Alias DPA Shared
   IF File( DiretoriodeDados + "\DPAIND05.IGD" )
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD,;
                   &DiretoriodeDados\DPAIND05.IGD
   ELSE
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD
   ENDIF
   DBSetOrder( 2 )
   DBGotop()
   DBSelectAr( 11 )
   Use &DiretoriodeDados\CONDICAO.VPB Alias CND Shared
   Set Index To &DiretoriodeDados\CNDIND01.IGD,;
                &DiretoriodeDados\CNDIND02.IGD
   DBSetOrder( 1 )
   IF !DBSeek( nForma )
      DBGoTop()
   ENDIF
   DBSetOrder( 2 )
   cCorPadrao:="07/" + StrZero( nCorSegFundo, 2, 0 ) + ",15/04,,,15/00"
   SetColor( cCorPadrao )
   oTB:=TBrowseDB( nLin1, nCol1, nLin2, nCol2 )
   oTB:AddColumn( TBColumnNew(, {|| Left( CND->DESCRI, 45 ) + Space( 20 ) } ) )
   oTB:AUTOLITE:=.f.
   oTB:DehiLite()
   /* Refaz o display */
   oTb:RefreshAll()
   WHILE !oTB:Stabilize()
   ENDDO
   /* Loop do Browse */
   WHILE .T.
       oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
       WHILE !oTb:Stabilize()
       ENDDO
       nTecla:=inkey(0)
       If nTecla=K_ESC
          lFim:= .T.
          exit
       EndIf
       do case
          CASE nTecla==K_UP         ;oTB:up()
          CASE nTecla==K_LEFT       ;oTB:up()
          CASE nTecla==K_RIGHT      ;oTB:down()
          CASE nTecla==K_DOWN       ;oTB:down()
          CASE nTecla==K_PGUP       ;oTB:pageup()
          CASE nTecla==K_PGDN       ;oTB:pagedown()
          CASE nTecla==K_CTRL_PGUP  ;oTB:gotop()
          CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom()
          CASE nTecla==K_ENTER
               nVezes:= 0
               AAdd( aParcelas, { 100, PARCA_, nValorPagar, DATE() + PARCA_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
               ++nVezes
               IF !PARCB_ == 0
                  AAdd( aParcelas, { 100, PARCB_, nValorPagar, DATE() + PARCB_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                  ++nVezes
                  IF !PARCC_ == 0
                     AAdd( aParcelas, { 100, PARCC_, nValorPagar, DATE() + PARCC_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                     ++nVezes
                     IF !PARCD_ == 0
                        AAdd( aParcelas, { 100, PARCD_, nValorPagar, DATE() + PARCD_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                        ++nVezes
                        IF !PARCE_ == 0
                           AAdd( aParcelas, { 100, PARCE_, nValorPagar, DATE() + PARCE_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                           ++nVezes
                           IF !PARCF_ == 0
                              AAdd( aParcelas, { 100, PARCF_, nValorPagar, DATE() + PARCF_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                              ++nVezes
                              IF !PARCG_ == 0
                                 AAdd( aParcelas, { 100, PARCG_, nValorPagar, DATE() + PARCG_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                 ++nVezes
                                 IF !PARCH_ == 0
                                    AAdd( aParcelas, { 100, PARCH_, nValorPagar, DATE() + PARCH_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                    ++nVezes
                                    IF !PARCI_ == 0
                                       AAdd( aParcelas, { 100, PARCI_, nValorPagar, DATE() + PARCI_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                       ++nVezes
                                       IF !PARCJ_ == 0
                                          AAdd( aParcelas, { 100, PARCJ_, nValorPagar, DATE() + PARCJ_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                          ++nVezes
                                          IF !PARCK_ == 0
                                             AAdd( aParcelas, { 100, PARCK_, nValorPagar, DATE() + PARCK_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                             ++nVezes
                                             IF !PARCL_ == 0
                                                AAdd( aParcelas, { 100, PARCL_, nValorPagar, DATE() + PARCL_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                                ++nVezes
                                                IF !PARCM_ == 0
                                                   AAdd( aParcelas, { 100, PARCM_, nValorPagar, DATE() + PARCM_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                                   ++nVezes
                                                ENDIF
                                             ENDIF
                                          ENDIF
                                       ENDIF
                                    ENDIF
                                 ENDIF
                              ENDIF
                           ENDIF
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF

               /* Percentual */
               nPercentual:= ( 100 - PERCA_ ) / ( nVezes - 1 )
               aParcelas[ 1 ][ 1 ]:= PERCA_
               aParcelas[ 1 ][ 3 ]:= ( nValorPagar * PERCA_ ) / 100

               /* Retira lancamentos caso haja sobra */
               FOR nCt:= 2 TO Len( aParcelas )
                   IF LEN( aParcelas ) > nVezes
                      ADEL( aParcelas, nVezes + 1 )
                      ASIZE( aParcelas, Len( aParcelas ) - 1 )
                   ELSE
                      aParcelas[ nCt ][ 1 ]:= nPercentual
                      aParcelas[ nCt ][ 3 ]:= ( nValorPagar * nPercentual ) / 100
                   ENDIF
               NEXT

               SetCursor( 0 )
               oTb:RefreshAll()
               WHILE !oTB:stabilize()
               ENDDO
               lDisplay:= .F.
               SetCursor( 0 )
               nForma:= CODIGO
               Exit

          OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      oTB:refreshcurrent()
      oTB:stabilize()
   ENDDO
   DBSelectAr( 11 )
   DBCloseArea()
   DBSelectAr( 22 )
   DBCloseArea()
   DBSelectAr( nArea )
   Return .T.


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ LancaReceber
≥ Finalidade  ≥ Lanca Contas a Receber
≥ Parametros  ≥ aParcelas
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function LancaReceber( aParcelas, aCliente )
   DBSelectAr( 22 )
   Use &DiretoriodeDados\CDDUPAUX.VPB Alias DPA Shared
   IF File( DiretoriodeDados + "\DPAIND05.IGD" )
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD,;
                   &DiretoriodeDados\DPAIND05.IGD
   ELSE
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD
   ENDIF
   DBSetOrder( 1 )
   FOR nCt:= 1 TO Len( aParcelas )
       DBAppend()
       IF RLock()
          nCodCli:= 0
          Replace CODNF_ With VAL( NumeroCupom() ),;
                  DUPL__ With VAL( NumeroCupom() ),;
                  LETRA_ With Chr( nCt + 64 ),;
                  PERC__ With aParcelas[ nCt ][ 1 ],;
                  VLR___ With aParcelas[ nCt ][ 3 ],;
                  PRAZ__ With aParcelas[ nCt ][ 2 ],;
                  BANC__ With aParcelas[ nCt ][ 6 ],;
                  CHEQ__ With aParcelas[ nCt ][ 7 ],;
                  VENC__ With aParcelas[ nCt ][ 4 ],;
                  DTQT__ With aParcelas[ nCt ][ 5 ],;
                  TIPO__ With "03",;
                  DATAEM With DATE(),;
                  FUNC__ With CodigoCaixa,;
                  OBS___ With DTOC(DATE()) + "|" + TIME() + "/" + StrZero( CodigoCaixa, 3, 0 ),;
                  CLIENT With aCliente[ 1 ],;
                  CDESCR With aCliente[ 2 ],;
                  LOCAL_ With aParcelas[ nCt ][ 8 ]

       ENDIF
   NEXT
   DBCloseArea()
   Return Nil

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ BUSCACLIENTE
≥ Finalidade  ≥ Apresentar relacao de clientes no PDV
≥ Parametros  ≥ cNome
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function BuscaCliente( nLin1, nCol1, nLin2, nCol2, cNome, cCgc___, cCPF___, cEndere, cCidade, cEstado, aCliente )
Local nCursor:= SetCursor()
Local nArea:= Select()
   DBSelectAr( 33 )
   Use &DiretoriodeDados\CLIENTES.VPB Alias CLI Shared
   Set Index To &DiretoriodeDados\CLIIND01.IGD,;
                &DiretoriodeDados\CLIIND02.IGD,;
                &DiretoriodeDados\CLIIND03.IGD
   DBSetOrder( 2 )
   DBGotop()
   IF DBSeek( PAD( cNome, 45 ) )
      IF ALLTRIM( cNome ) == ALLTRIM( DESCRI )
         aCliente:= { CODIGO, DESCRI, CGCMF_, CPF___, ENDERE, CIDADE, ESTADO, 0 }
      ENDIF
      DBSelectAr( 33 )
      DBCloseArea()
      DBSelectAr( 22 )
      DBCloseArea()
      DBSelectAr( nArea )
      SetCursor( nCursor )
      Return .T.
   ELSE
      IF !EMPTY( cNome )
         aCliente[ 1 ]:= 0
         aCliente[ 2 ]:= cNome
         DBSelectAr( 33 )
         DBCloseArea()
         DBSelectAr( 22 )
         DBCloseArea()
         DBSelectAr( nArea )
         SetCursor( nCursor )
         Return .T.
      ENDIF
      DBSeek( PAD( cNome, 45 ), .T. )
      DBSetOrder( 2 )
      cCorPadrao:="07/" + StrZero( nCorSegFundo, 2, 0 ) + ",15/04,,,15/00"
      SetColor( cCorPadrao )
      oTB:=TBrowseDB( nLin1, nCol1 + nColuna, nLin2, nCol2 )
      oTB:AddColumn( TBColumnNew(, {|| Left( CLI->DESCRI, 45 ) + Space( 20 ) } ) )
      oTB:AUTOLITE:=.f.
      oTB:DehiLite()
      /* Refaz o display */
      oTb:RefreshAll()
      WHILE !oTB:Stabilize()
      ENDDO
      /* Loop do Browse */
      WHILE .T.
          oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
          WHILE !oTb:Stabilize()
          ENDDO
          nTecla:=inkey(0)
          If nTecla=K_ESC
             lFim:= .T.
             exit
          EndIf
          DO CASE
             CASE nTecla==K_UP         ;oTB:up()
             CASE nTecla==K_LEFT       ;oTB:up()
             CASE nTecla==K_RIGHT      ;oTB:down()
             CASE nTecla==K_DOWN       ;oTB:down()
             CASE nTecla==K_PGUP       ;oTB:pageup()
             CASE nTecla==K_PGDN       ;oTB:pagedown()
             CASE nTecla==K_CTRL_PGUP  ;oTB:gotop()
             CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom()
             CASE nTecla >= 32 .AND. nTecla <= 126
                  cDescricao:= Chr( nTecla ) + Space( Len( DESCRI ) - 1 )
                  nLinQtd:= 8
                  Scroll( nLinQtd, 02+nColuna, nLinQtd, 44 )
                  Keyboard Chr( K_RIGHT )
                  SetCursor( 1 )
                  @ nLinQtd,2+nColuna Say "Procurar: " Get cDescricao Pict "@!S24"
                  READ
                  SetCursor( 0 )
                  DBSetOrder( 2 )
                  oTb:GoTop()
                  DBSeek( cDescricao, .T. )
                  oTb:RefreshAll()
                  WHILE !oTb:Stabilize()
                  ENDDO

             CASE nTecla==K_TAB
                  EXIT
             CASE nTecla==K_ENTER
                  cNome:= DESCRI
                  cCgc___:= CGCMF_
                  cCPF___:= CPF___
                  cEndere:= ENDERE
                  cCidade:= CIDADE
                  cEstado:= ESTADO
                  aCliente:= { CODIGO, DESCRI, CGCMF_, CPF___, ENDERE, CIDADE, ESTADO, 0 }
                  oTb:RefreshAll()
                  WHILE !oTB:stabilize()
                  ENDDO
                  Scroll( nLin1, nCol1+nColuna, nLin2, nCol2 )
                  @ 15,02+nColuna Say "Cliente.:"
                  @ 16,02+nColuna Say "CGC.....:"
                  @ 17,02+nColuna Say "CPF.....:"
                  @ 18,02+nColuna Say "Endereco:"
                  @ 19,02+nColuna Say "Cidade..:"
                  @ 20,02+nColuna Say "Estado..:"
                  EXIT
             OTHERWISE                ;tone(125); tone(300)
         ENDCASE
         oTB:refreshcurrent()
         oTB:stabilize()
      ENDDO
   ENDIF
   DBSelectAr( 33 )
   DBCloseArea()
   DBSelectAr( 22 )
   DBCloseArea()
   DBSelectAr( nArea )
   SetCursor( nCursor )
   Return .T.

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ BUSCAVENDEDOR
≥ Finalidade  ≥ Apresentar relacao de VENDEDORs no PDV
≥ Parametros  ≥ cNome
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function BuscaVENDEDOR( nCodigo )
Local nCursor:= SetCursor()
Local nArea:= Select()
   DBSelectAr( 34 )
   IF !Used()
      Use &DiretoriodeDados\VENDEDOR.VPB Alias VEN Shared
      Set Index To &DiretoriodeDados\VENIND01.IGD,;
                   &DiretoriodeDados\VENIND02.IGD
   ENDIF
   DBSetOrder( 1 )
   DBGotop()
   IF DBSeek( nCodigo )
      DBSelectAr( 34 )
      DBCloseArea()
      DBSelectAr( nArea )
      SetCursor( nCursor )
      Return .T.
   ELSEIF nCodigo==0
      DBSelectAr( 34 )
      DBCloseArea()
      DBSelectAr( nArea )
      SetCursor( nCursor )
      Return .T.
   ENDIF
   Return .F.

Function MaxLin( nLinha )
Static Linha
IF !nLinha==Nil
   Linha:= nLinha
ENDIF
Return Linha

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ STATUS
≥ Finalidade  ≥ Retornar o Status da Impressora Fiscal
≥ Parametros  ≥ Nil
≥ Retorno     ≥
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function Status
nRetorno:= -1
DO CASE
   CASE Impressora=="SIGTRON"
        ? "Aguarde, iniciando comunicacao..."
        RetStatus:= Space( 8 )
        arqST = fopen("SIGFIS",2)
        Fwrite(arqST,CHR(29)+CHR(5),2)
        fclose(arqST)
        arqST = fopen("SIGFIS",2)
        IF FREAD(arqST,@RetStatus,1) <> 1
           ? "Erro de leitura !"
           fclose(arqST)
           Return 0
        ELSE
           arqRES:=fopen("RETORNO.TXT",2)
           Fwrite(arqRES,NtoSBit(ASC(RetStatus))+chr(13),70)
           fclose(arqRES)
           fclose(arqST)
           VALST:=ASC(RetStatus)    /* Pega o valor ASCII de retStatus */
           VST:= NtoSBit(VALST)     /* Retorna o valor em bits         */
           nRetorno:= Tabela( VST )
        ENDIF
   CASE Impressora=="BEMATECH"

   CASE Impressora=="URANO"
        SetColor( "14/00" )
        ? " ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹ﬂ URANO ﬂ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹ "
        ? "‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹"
        ? "€€≤≤€€€€≤€≤≤≤≤≤≤≤€€€≤≤≤≤≤€€≤≤≤€€€€≤€≤≤≤≤≤≤≤€€"
        ? "€€≤≤€€€€≤€≤≤€€€€≤≤€≤≤€€€≤≤€≤≤≤≤€€≤≤€≤≤€€€€≤€€"
        ? "€€≤≤€€€€≤€≤≤≤≤≤≤€€€≤≤≤≤≤≤≤€≤≤€≤≤€≤≤€≤≤€€€€≤€€"
        ? "€€≤≤€€€€≤€≤≤€€€≤≤€€≤≤€€€≤≤€≤≤€€≤≤≤≤€≤≤€€€€≤€€"
        ? "€€≤≤≤≤≤≤≤€≤≤€€€€≤≤€≤€€€€€≤€≤€€€€≤≤≤€≤≤≤≤≤≤≤€€"
        ? "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
        ? "  ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ  "
        IF ReadSensor( "1" ) <> 0
        ENDIF
        Inkey(1)

ENDCASE
Return nRetorno


Function Tabela( VST )

   WHILE Len(VST)<8
       VST:="0"+VST
   ENDDO

   aBit:=  { 1, 2, 3, 4, 5, 6, 7, 8 }
   aSema:= { 1, 2, 3, 4, 5, 6, 7, 8 }

   /* Resposta SIGFIS em bits */
   FOR nCt:= 1 TO Len( VST )
       IF nCt <= 8
          aBit[ nCt ]:= SubStr( VST, nCt, 1 )
       ENDIF
   NEXT

   FOR nCt:= 1 TO Len( abit )
       aSema[ nCt ]:= IF( aBit[ nCt ] == "1", " ", "  " )
   NEXT

   SetColor( "15/01" )
   Cls
   @ 00,01 Say ""
   @ Row()+1,00 Say " ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ "
   @ Row()+1,00 Say " Status da Impressora FS-300                           "
   @ Row()+1,00 Say " ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ "
   @ Row()+1,00 Say "   Gaveta Aberta                                 Bit8  "
   @ Row()+1,00 Say "   Falha Geral                                   Bit7  "
   @ Row()+1,00 Say "   <RESERVADO>                                   Bit6  "
   @ Row()+1,00 Say "   Fim da bobina de papel                        Bit5  "
   @ Row()+1,00 Say "   Impressora Off-Line                           Bit4  "
   @ Row()+1,00 Say "   <RESERVADO>                                   Bit3  "
   @ Row()+1,00 Say "   Reducao Z Pendente                            Bit2  "
   @ Row()+1,00 Say "   Proximidade do Fim do papel                   Bit1  "
   @ Row()+1,00 Say " ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ "
   @ Row()+1,00 Say ""
   @ Row()+1,00 Say ""
   nLin:= ROW()
   /* Verificacao p retorno */
   nRetorno:= -1
   FOR nCt:= 1 TO Len( aSema )
      IF ! ( nCt==3 .OR. nCt==6 )
         @ nLin-11+nCt,01 Say aSema[ nCt ]
      ENDIF
      IF !aSema[ nCt ]=="  "
         DO CASE
            CASE nCt == 1 .OR. nCt == 2 .OR. nCt == 3
                 nRetorno:= IF( nRetorno < 0, 0, nRetorno )
            CASE nCt == 4
                 nRetorno:= 1
            OTHERWISE
         ENDCASE
      ENDIF
   NEXT
   Inkey(0)
   ? " "
   RETURN nRetorno

   Function DispM( cMensagem )
   Local cFileF1:= "P31SERF.BCM",;
         cFileF2:= "P26BOLD.BCM"
   Local cCor:= SetColor()
   Local cPedaco, cStringCompleta
   Static cTime, nCont1, nQuant
   Static cTela
   Static cTimeProtT
   SetColor( "15/01" )
   IF cTime==Nil
      cTime:= "0"
      cTimeProtT:= Right( Time(), 2 )
//      @ 00, 01 + nColuna Say cMensagem
   ENDIF
   IF VAL( Right( Time(), 1 ) ) <> VAL( cTime )
      cTime:= Right( Time(), 1 )
      IF nQuant == NIL .AND. nCont1 == NIL
         nCont1:= 0
         nQuant:= Len( cMensagem )
      ENDIF
      SetCursor( 0 )
      ++nCont1
      nQuant:= Len( cMensagem ) - nCont1
      cPedaco:= SubStr( cMensagem, nCont1, nQuant )
      cStringCompleta:= cPedaco + ;
            SubStr( cMensagem, 1, Len( cMensagem ) - Len( cPedaco ) )
      cFonte1:= BC_FONTEM( "P26ITA.BCM" )
      cFonte2:= BC_FONTEM( "P21NORM.BCM" )
      if cfonte1 <> 0
         BC_DTEXTM( CorPropaganda, -1, -1, "", cFonte1, nCorFundo )
         BC_TEXTM( 0.02+((nColuna+3)/100), .90, cStringCompleta )
     endif
     BC_LIBFM( cFonte1 )
     BC_LIBFM( cFonte2 )
     IF nCont1 = Len ( cMensagem )
        nCont1:= 0
        nQuant:= Len ( cMensagem )
     ENDIF
   ENDIF
   SetColor( cCor )
   Return Nil

