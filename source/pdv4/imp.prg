#Include "FILEIO.CH"

/*
-------------------------------------------------------------------------------
  Telefones de Suporte Tecnico

  BEMATECH = 33951202
  SCHALTER = 33236800

******* ECF-URANO
VALMOR: Para impressora fiscal URANO ZPM/1EF a venda de produtos e diferente
        do modelo que esta implementado atualmente. Caso seja realizada a
        comercializacao para este modelo devemos modificar os parametros de
        venda de produto e emissao de leitura x e reducao z
        Em 25/09/2003

*/

/*====================================
Funcao      IMPVENDEPRODUTO
Finalidade  Lancar produto no Cupom Fiscal
Parametros  cCodFab =         Codigo de Fabrica do produto EAN13
            cDescri =         Descricao do produto
            cIcm =            Situacao Tributaria do Item
            nQuantidade =     Quantidade de pecas
            nPreco =          Preco Unitario do material
            nDescPercentual = Desconto Percentual
            nDescValor =      Desconto em Valor
            nCt =             Posicao
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98







-------------------------------------*/
Function impVendeProduto( cCODFAB, cDESCRI, cIcm, nQuantidade, nPreco, nDescPercentual, nDescValor, nct, cUnidade, nDepartamento, cRetorno )
Local cComando
Local cDesconto
Local nCasasVlr:= 0, nCasasQtd:= 0

cPreco:= PAD( StrTran( Alltrim( Str( nPreco, 8, 2 ) ), ".", "" ), 9 )
nDepartamento:= IF( nDepartamento==Nil, 0, nDepartamento )

IF cRetorno==Nil
   cRetorno:= ""
ENDIF

DO CASE
   CASE Impressora $ "Nenhuma-Treinamento"
       Return .T.

   CASE Impressora=="SIGTRON"
       /* formatacao das informacoes */
       cDescri:= Left( cDescri, 30 )
       cPreco:= StrTran( StrZero( nPreco, 10, 02 ), ".", "" )

       IF ( cIcm == Nil )
          cIcm:= STPadrao
       ELSEIF ( cIcm == Space( 2 ) )
          cIcm:= STPadrao
       ENDIF

       /* Possiveis Quantidades */
       IF nQuantidade > 999.9
          cQuantidade:= StrZero( nQuantidade, 5, 0 )
       ELSE
          cQuantidade:= StrTran( StrZero( nQuantidade, 5, 1 ), ".", "," )
       ENDIF

       IF nDescPercentual > 0
          cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescValor > 0
          cDesconto:= "0000"
          // INEXISTE   cDesconto:= StrTran( StrZero( nDescValor, 10, 2 ), ".", "" )
       ELSE
          cDesconto:= "0000"
       ENDIF
       /* FORMATACAO DO COMANDO */
       cComando:= Chr( 27 ) + Chr( 215 ) +;
                  cIcm + PAD( cCodFab, 13 ) + "0000" +;
                         cDesconto + cPreco + ;
                         cQuantidade + ;
                         cUnidade + PAD( cDescri, 30 )

       Com_Send( impPorta(), cComando )
       cRetorno:= Alltrim( Com_Read( impPorta(), 22 ) )
       IF Left( cRetorno, 2 ) == ":E"
          Return .F.
       ELSE
          Return .T.
       ENDIF

   CASE Impressora=="SCHALTER-II"
       cCodFab:= PAD( cCodFab, 13 )
       cDescri:= Left( cDescri, 30 )
       cPreco:= StrTran( StrZero( nPreco * nQuantidade, 10, 02 ), ".", "" )
       cQuantidade:= StrTran( StrZero( nQuantidade, 7, 02 ), ".", "," )
       IF nDescPercentual > 0
          cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescValor > 0
          cDesconto:= StrTran( StrZero( nDescValor, 10, 2 ), ".", "" )
       ELSE
          cDesconto:= "0000"
       ENDIF
       IF Left( cIcm, 1 ) $ "01234567890T"
          cIcm:= VAL( cIcm )
       ENDIF

       IF ( nErro:= VendItem78( PAD( cCodFab, 13 ) + " " + cDescri + Space( 4 ) + cQuantidade + " " + cUnidade, cPreco, cIcm ) ) == 0
          Return .T.
       ELSE
          Return .F.
       ENDIF

   CASE Impressora=="SCHALTER"
       cCodFab:= PAD( cCodFab, 13 )
       cDescri:= Left( cDescri, 30 )
       cPreco:= StrTran( StrZero( nPreco, 10, 02 ), ".", "" )
       cQuantidade:= StrTran( StrZero( nQuantidade, 7, 02 ), ".", "," )
       IF nDescPercentual > 0
          cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescValor > 0
          cDesconto:= StrTran( StrZero( nDescValor, 10, 2 ), ".", "" )
       ELSE
          cDesconto:= "0000"
       ENDIF
       IF Left( cIcm, 1 ) $ "01234567890T"
          cIcm:= VAL( cIcm )
       ENDIF

       IF ( nErro:= VndItem3( PAD( cCodFab, 13 ), cDescri, cQuantidade, cPreco, cIcm, cUnidade, "2" ) )==0
          Return .T.
       ELSE
          Return .F.
       ENDIF

   CASE Impressora=="SIGTRON-FS345"
       /* Formatacao das informacoes */
       cDescri:= PAD( cDescri, 30 )
       cPreco:= StrTran( StrZero( nPreco, 10, 02 ), ".", "" )
       IF nQuantidade - Int( nQuantidade ) <> 0
          /* QUEBRADO COM CENTAVOS */
          cQuantidade:= StrTran( StrZero( nQuantidade, 5, 2 ), ".", "," )
       ELSE
          /* INTEIRO */
          cQuantidade:= StrTran( StrZero( nQuantidade, 5, 0 ), ".", "," )
       ENDIF
       IF nDescPercentual < 0
          cDesconto:= "1" + StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescPercentual > 0
          cDesconto:= "0" + StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSE
          cDesconto:= "00000"
       ENDIF

       /* FORMATACAO DO COMANDO */
       cComando:= Chr( 27 ) + Chr( 215 ) +;
                  cIcm + PAD( cCodFab, 13 ) + "000" +;
                         cDesconto + cPreco + ;
                         cQuantidade + ;
                         cUnidade + PAD( cDescri, 30 )

       Com_Send( impPorta(), cComando )
       cRetorno:= Alltrim( Com_Read( impPorta(), 22 ) )

       IF Driver=="W2000"
          IF AT( ":E", cRetorno ) > 0
             Return .F.
          ELSE
             Return .T.
          ENDIF
       ELSE
          IF AT( ":+", cRetorno ) > 0
             Return .T.
          ELSE
             IF !( AT( ":E", cRetorno ) > 0 )
                Return .T.
             ELSE
                Return .F.
             ENDIF
          ENDIF
       ENDIF

   CASE Impressora=="BEMATECH"
       IF nDescPercentual > 0
          cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescValor  > 0
          cDesconto:= StrTran( StrZero( nDescValor, 9, 2 ), ".", "" )
       ELSE
          cDesconto:= "0000"
       ENDIF
       IF LEN( cIcm ) > 2
          cIcm:= StrZero( VAL( cIcm ), 02, 0 )
       ENDIF
       cQuantidade:= StrTran( StrZero( nQuantidade, 8, 3 ), ".", "" )
       cPreco:= StrTran( StrZero( nPreco, 9, 2 ), ".", "" )
       cComando:= Chr( 27 ) + Chr( 251 ) + "09|" + PAD( cCodFab, 13 ) + "|" +;
                  PAD( cDescri, 29 ) + "|" + cIcm + "|" + cQuantidade + "|" +;
                  cPreco + "|0000|" + Chr( 27 )
       private ack := space(1)
       private st1 := space(1)
       private st2 := space(1)
       Private Comando:= cComando
       ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
       fwrite( ImpFiscal, @comando,len(comando))
       lFim:= .F.
       if ferror() # 0
          lFim:= .T.
          lRetorno:= .F.
       endif
       fread(ImpFiscal,@ack,1)
       if ferror() # 0 .and. !lFim
          lFim:= .T.
          lRetorno:= .F.
       endif
       IF !lFim
          FRead( ImpFiscal, @st1, 1 )
          IF ferror() # 0 .AND. !lFim
             lFim:= .T.
             lRetorno:= .F.
          ENDIF
       ENDIF
       IF !lFim
          fread(ImpFiscal,@st2,1)
          if ferror() # 0 .AND. !lFim
             lFim:= .T.
             lRetorno:= .F.
          endif
       ENDIF
       IF Erro(ack,st1,st2)
          lRetorno:= .f.
       ELSE
          lRetorno:= .t.
       ENDIF
       FClose( ImpFiscal )
       RELEASE st1
       RELEASE st2
       RELEASE ImpFiscal
       RELEASE Comando
       RELEASE lFim
       /////// RETORNA CORRETO SEMPRE ///////
       Return .T.

   CASE Impressora=="BEMATECH-MP20FI-II"
        /* Composicao-Formatacao dos Campos a serem impressos */
        nCasasQtd:= IF( CasasDecimais( nQuantidade ) > 0, 3, 0 )
        nCasasVlr:= IF( CasasDecimais( nPreco ) > 2, 3, 2 )
        IF nCasasQtd==3
           cQuantidade:= StrTran( StrZero( nQuantidade, 8, 3 ), ".", "" )
        ELSE
           cQuantidade:= StrZero( nQuantidade, 4, 0 )
        ENDIF
        IF nCasasVlr <= 2
           cCmd:= "09|"
           cPreco:= StrTran( StrZero( nPreco, 9, 2 ), ".", "" )
        ELSEIF nCasasVlr >= 3
            cCmd:= "56|"
            cPreco:= StrTran( StrZero( nPreco, 9, 3 ), ".", "" )
        ENDIF
        IF nDescPercentual > 0
           cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
        ELSEIF nDescValor  > 0
           cDesconto:= StrTran( StrZero( nDescValor, 9, 2 ), ".", "" )
        ELSE
           cDesconto:= "0000"
        ENDIF

        cTabela:= cIcm
        cTabela:= PAD( ALLTRIM( cTabela ), 2 )
        IF cTabela=="2 "
           cTabela:= "02"
        ELSEIF cTabela=="3 "
           cTabela:= "03"
        ELSEIF cTabela=="4 "
           cTabela:= "04"
        ELSEIF cTabela=="5 "
           cTabela:= "05"
        ELSEIF cTabela=="6 "
           cTabela:= "06"
        ELSEIF cTabela=="7 "
           cTabela:= "07"
        ELSEIF cTabela=="8 "
           cTabela:= "08"
        ELSEIF cTabela=="9 "
           cTabela:= "09"
        ELSEIF cTabela=="0 "
           cTabela:= "10"
        ENDIF

        /* Composicao do Comando de Impressao */
        cComando:= Chr( 27 ) + Chr( 251 ) + cCmd + PAD( cCodFab, 13 ) + "|" +;
                   PAD( cDescri, 29 ) + "|" + cTabela + "|" + cQuantidade + "|" +;
                   cPreco + "|" + cDesconto + "|" + Chr( 27 )

        private ack := space(1)
        private st1 := space(1)
        private st2 := space(1)
        Private Comando:= cComando
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fwrite( ImpFiscal, @comando,len(comando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
          lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread(ImpFiscal,@st2,1)
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
           lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        Release st1
        Release st2
        Release ImpFiscal
        Release Comando
        Release lFim
        Return lRetorno

   CASE Impressora=="SWEDA"

        IF nDescValor == Nil
           nDescValor:=  0
        ENDIF
        IF nDescPercentual > 0
           nDescValor:= ( nPreco * nDescPercentual ) / 100
        ENDIF
        IF nDescValor < nPreco
           nPreco:= nPreco - ( nDescValor / IF( nDescPercentual > 0, 1, nQuantidade ) )
        ENDIF

        cComando:= Chr( 27 ) + ".01"
        cComando+= IF( EMPTY( cCodFab ), "0            ", PAD( cCodFab, 13 ) )
        cComando+= StrTran( StrZero( nQuantidade, 8, 3 ), ".", "" )
        cComando+= StrTran( StrZero( nPreco, 10, 2 ), ".", "" )
        cComando+= StrTran( StrZero( nPreco * nQuantidade, 13, 2 ), ".", "" )
        cComando+= PAD( ALLTRIM( cDescri ), 24 )

        cTabela:= cIcm
        IF Len( cTabela )==3
           cComando+= cTabela
        ELSE
           cComando+= "T" + PAD( cTabela, 2 )
        ENDIF
        cComando+= ""
        cComando+= ""
        cComando+= "}"

        Set Printer To IFSWEDA
        Set Device To Print
        @ PRow(), PCol() Say cComando
        Set Device To Screen
        Return( LEN( VerErro( cComando ) ) <= 1 )

   CASE Impressora=="ZANTHUS"

   CASE Impressora=="EPSON"
        cImp:= Set( 24, PortaImpressao, .f. )

/*
@11,05 say "vende"
@12,05 say impressora
@13,05 say portaimpressao
@14,05 SAY SET(24)
INKEY(0)
@11,04 clear to 14,10
SET PRINTER TO &PORTAIMPRESSAO.
*/

        Set( _SET_DEVICE, "PRINTER" )
        @ PROW()+1,00 Say PAD( Alltrim( cCodFab ) + " " + cDescri, 35 ) + " " + cUnidade + " "
        @ PROW()+1,00 Say " "+ StrZero( nCt+1, 3, 0 ) + "       " + Tran( nQuantidade, "@E 99,999.99" ) + ;
                   Tran( nPreco, "@E 999,999.99" ) + Tran( nPreco * nQuantidade, "@E 999,999.99" )
        IF EpsonVende( cCodFab, cDescri, cUnidade, nQuantidade, nPreco )
           @ PROW()+1,00 Say Chr( 27 ) + Chr( 18 ) + "#     Orcamento      " + Chr( 27 ) + Chr( 15 ) + "#"
        ENDIF
        Set( 24, "LPT2" )
        Set( 24, "LPT1" )
        Set( _SET_PRINTER, cImp )
        Set( _SET_DEVICE, "SCREEN" )
        Return .T.

   CASE Impressora=="URANO"
        cUnidade:= Alltrim( cUnidade )
        IF cUnidade=="KG"
           cQuantidade:= StrZero( nQuantidade, 7, 3 )
        ELSE
           cQuantidade:= StrZero( nQuantidade, 7, 0 )
        ENDIF
        cPreco:= PAD( StrTran( Alltrim( Str( nPreco, 8, 2 ) ), ".", "" ), 9 )
        cPreco:= ALLTRIM( cPreco )
        @ 01,01 say cPreco
        /* AJUSTE MALUCO, POIS CONSIDERA MAIS UM DIGITO */
        //cPreco:= Left( cPreco, Len( cPreco ) - 1 )
        IF SaleItem( PAD( cCodFab, 13 ), " "+Alltrim( Pad( cDescri, 24 ) ),;
                     cQuantidade, cPreco,;
                     cIcm, cUnidade, "0" ) == 0
           /* Caso haja desconto */
           IF nDescPercentual <> Nil
              IF nDescPercentual > 0 .AND. nDescValor == 0
                 nDescValor:= ( nPreco * nDescPercentual ) / 100
              ENDIF
           ENDIF
           IF nDescValor <> Nil
              IF nDescValor > 0
                 IF DiscountItem( "0",;
                                  PAD( " ", 26 ),;
                                  StrTran( StrZero( nDescValor, 8, 2 ), ".", "" ) ) == 0
                    Return .T.
                 ELSE
                    Return .F.
                 ENDIF
              ENDIF
           ENDIF

           Return .T.
        ENDIF

ENDCASE
Return .F.

/*====================================
Funcao      ImpAbreCupom
Finalidade  Abrir o Cupom para Utilizacao
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function impAbreCupom()
Local cNumero:= ""
Local nRet:= 0
Local cComando

DO CASE
   CASE Impressora=="EPSON"
        cImp:= Set( 24, PortaImpressao, .f. )

/*
@11,05 say "abre"
@12,05 say impressora
@13,05 say portaimpressao
@14,05 SAY SET(24)
inkey(0)
@11,04 clear to 14,10
SET PRINTER TO &PORTAIMPRESSAO
*/

        Set( _SET_DEVICE, "PRINTER" )
        NumeroCupom( "<Buscar>" )
        cNumero:= StrZero( VAL( NumeroCupom() ), 6, 0 )
        @ PROW()+1,00 Say "          O  R  C  A  M  E  N  T  O        "
        @ PROW()+1,00 Say " " + StrTran( Cliche1, "NUMEROCUPOM", cNumero )
        @ PROW()+1,00 Say " " + StrTran( Cliche2, "NUMEROCUPOM", cNumero )
        @ PROW()+1,00 Say " " + StrTran( Cliche3, "NUMEROCUPOM", cNumero )
        @ PROW()+1,00 Say " " + StrTran( Cliche4, "NUMEROCUPOM", cNumero )
        @ PROW()+1,00 Say "-Produto---------------------------UN------"
        @ PROW()+1,00 Say "            --Quant----Pr.Unit-----Total---"
        EpsonAbre()
        Set( _SET_PRINTER, cImp )
        Set( _SET_DEVICE, "SCREEN" )

   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 200 )
        Com_Send( impPorta(), cComando )
        IF Driver=="W2000"
           Com_Read( impPorta(), 20 )
        ENDIF
        ImpCupomAtual( "PEGAR" )

   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 200 )
        Com_Send( impPorta(), cComando )
        ImpCupomAtual( "PEGAR" )

   CASE Impressora=="SCHALTER-II"
        IF ImpCab( 146 )==0
           ImpCupomAtual()
        ENDIF

   CASE Impressora=="SCHALTER"
        IF ImpCab( 146 )==0
           ImpCupomAtual()
        ENDIF

   CASE Impressora=="BEMATECH"
        private comando := chr(27) + chr(251) + "00|" + chr(27)
        private ack := Space(1)
        private st1 := Space(1)
        private st2 := Space(1)
        Private ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fwrite( ImpFiscal, @comando, len( comando ) )
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
           lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread( ImpFiscal, @st2, 1 )
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
           lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        RELEASE st1
        RELEASE st2
        RELEASE ImpFiscal
        RELEASE Comando
        RELEASE lFim
        Return lRetorno

   CASE Impressora=="BEMATECH-MP20FI-II"
        private comando := chr(27) + chr(251) + "00|" + chr(27)
        private ack:= Space(1)
        private st1:= Space(1)
        private st2:= Space(1)

        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fwrite( ImpFiscal, @comando,len(comando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
           lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread(ImpFiscal,@st2,1)
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
          lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        RELEASE st1
        RELEASE st2
        RELEASE ImpFiscal
        RELEASE Comando
        RELEASE lFim
        Return lRetorno

   CASE Impressora=="SWEDA"
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".17}"
        @ PRow(), PCol() Say cComando
        Set Device To Screen
        Return( LEN( VerErro( cComando ) ) <= 1 )

   CASE Impressora=="URANO"
        IF !( nRet:= PrintHeader() )==0
           Return nRet
        ENDIF

ENDCASE
Return nRet

/*====================================
Funcao      ImpSubTotCupom
Finalidade  Sub-Totaliza o cupom fiscal
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function impSubTotCupom()
Local cComando
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 227 )
        Com_Send( impPorta(), cComando, 2 )

   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 227 )
        Com_Send( impPorta(), cComando, 2 )

   CASE Impressora=="URANO"


ENDCASE
Return Nil


/*====================================
Funcao      ImpReducaoZ
Finalidade  Emitir a reducao em Z
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function ImpReducaoZ()
Local cComando, nRet:= 0
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 208 ) + DTOC( DATE() ) + StrTran( TIME(), ":", "" )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 208 ) + DTOC( DATE() ) + StrTran( TIME(), ":", "" )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SWEDA"
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".14}"
        @ PRow(), PCol() Say cComando
        Set Device To Screen
        Return( LEN( VerErro( cComando ) ) <= 1 )

   CASE Impressora=="URANO"
        nRet:= ReportXZBegin( "1" )
        nRet:= ReportXZEnd( "00001" )
        AdvanceLine( "0", "07" )

   CASE Impressora=="BEMATECH-MP20FI-II"
        cComando:= Chr( 27 ) + Chr( 251 ) + "05|" + Chr( 27 )
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Impressora=="BEMATECH"
        cComando:= Chr( 27 ) + Chr( 251 ) + "05|" + Chr( 27 )
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Impressora=="SCHALTER-II"
        IF ReducaoZ("")==0
           Return .T.
        ELSE
           Return .F.
        ENDIF

   CASE Impressora == "SCHALTER"
        IF ReducaoZ("")==0
           Return .T.
        ELSE
           Return .F.
        ENDIF



ENDCASE
Return nRet

/*====================================
Funcao      ImpLeituraX
Finalidade  Emitir a LEITURA X
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function ImpLeituraX()
Local cComando, nRet:= 0
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 207 )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 207 )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SWEDA"
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".13}"
        @ PRow(), PCol() Say cComando
        Set Device To Screen
        Return( LEN( VerErro( cComando ) ) <= 1 )

   CASE Impressora=="URANO"
        nRet:= ReportXZBegin( "0" )
        nRet:= ReportXZEnd( "00001" )
        AdvanceLine( "0", "07" )

   CASE Impressora=="BEMATECH-MP20FI-II"
        cComando:= Chr( 27 ) + Chr( 251 ) + "06|" + Chr( 27 )
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Impressora=="BEMATECH"
        cComando:= Chr( 27 ) + Chr( 251 ) + "06|" + Chr( 27 )
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Impressora=="SCHALTER-II"
        nRet:= LeituraX( "OPERADOR" )

   CASE Impressora=="SCHALTER"
        nRet:= LeituraX( "OPERADOR" )

ENDCASE
Return nRet

/*====================================
Funcao      ImpAbreGaveta
Finalidade  Abre Gaveta
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function ImpAbreGaveta()
Local cComando
DO CASE
   CASE Gaveta=="SIGTRON"
        cComando:= Chr( 27 ) + "p000"
        Com_Send( impPorta(), cComando )

   CASE Gaveta=="SCHALTER-II"
        AbreGaveta()

   CASE Gaveta=="SCHALTER"
        AbreGaveta()

   CASE Gaveta=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + "p000"
        Com_Send( impPorta(), cComando )

   CASE Gaveta=="URANO"
        OpenCash()
                                                               
   CASE Gaveta=="BEMATECH"
        cComando:= Chr( 27 ) + Chr( 251 ) + "22|" + cAbreGaveta
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Gaveta=="BEMATECH-MP20FI-II"
        cComando:= Chr( 27 ) + Chr( 251 ) + "22|" + cAbreGaveta
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Gaveta=="SWEDA"

        // Abre gaveta
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".21}"
        @ PRow(), PCol() Say cComando
        Set Device To Screen

        // Abre gaveta acoplada ao ECF
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".42}"
        @ PRow(), PCol() Say cComando
        Set Device To Screen

        Return( LEN( VerErro( cComando ) ) <= 1 )

ENDCASE
Return Nil

/*====================================
Funcao      ImpLeMemoria
Finalidade  Leitura da Memoria Fiscal
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function ImpLeMemoria()
Local cMes:= StrZero( Month( DATE() ), 2, 0 )
Local cAno:= Right( StrZero( Year( DATE() ), 4, 0 ), 2 )
Local cDia:= StrZero( Day( DATE() ), 2, 0 )
Local cComando, nRet:= 0
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 209 ) + "01"+cMes+cAno+cDia+cMes+cAno
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 209 ) + "x01"+cMes+cAno+cDia+cMes+cAno
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SWEDA"
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".16"
        cComando+= "01"+cMes+ cAno+ cDia+ cMes+ cAno+ "}"
        @ PRow(), PCol() Say cComando
        Set Device To Screen
        Return( LEN( VerErro( cComando ) ) <= 1 )

   CASE Impressora=="URANO"
        nRet:= ReadFiscalMemory( "0", CTOD( "01"+"/"+cMes+"/"+cAno ),;
                                      CTOD( cDia+"/"+cMes+"/"+cAno ), Space( 4 ), Space( 4 ) )
        AdvanceLine( "0", "07" )

   CASE Impressora=="BEMATECH-MP20FI-II"
        cComando:= Chr( 27 ) + Chr( 251 ) + "08|" + "01" + "|" + cMes + "|" + cAno + "|"+;
                                                    cDia + "|" + cMes + "|" + cAno + "|I|" + Chr( 27 )
        ImpFiscal:= fOpen( PortaImpressao, FO_READWRITE )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

   CASE Impressora=="BEMATECH"
        cComando:= Chr( 27 ) + Chr( 251 ) + "08|" + "01" + "" + cMes + "" + cAno + "|"+;
                                                    cDia + "" + cMes + "" + cAno + "|I|" + Chr( 27 )
        ImpFiscal:= fOpen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fWrite( ImpFiscal, @cComando,len(cComando))
        fClose( ImpFiscal )

ENDCASE
Return nRet

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ AbrePortaCom
³ Finalidade  ³ Abrir uma porta de comunicacao
³ Parametros  ³ nPorta = Porta a ser inicializada
³ Retorno     ³ Se foi possivel a inicializacao
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Julho/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function AbrePortaCom( nPorta )
Com_Open( nPorta, 10 )
Com_Init( nPorta, 9600, "N", 8, 1 )
Com_Rts( nPorta, .T. )
Com_Dtr( nPorta, .T. )
Return Com_Cts( nPorta )


/*===================================
Funcao      impPorta
Finalidade  Guardar e Retornar a Porta ativa da impressora
Parametros  Porta de Comunicacao a Setar
Retorno     Porta Set
Programador Valmor Pereira Flores
------------------------------*/
Function ImpPorta( nPorta )
Static nPortaAtiva
IF nPorta <> Nil
   nPortaAtiva:= nPorta
ENDIF
Return nPortaAtiva

/*====================================
Funcao      IMPCANCELAITEM
Finalidade  Cancelar um item do cupom
Parametros  nPosicao = Posicao de Cancelamento do Item
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function impCancItem( nPosicao )
Local cComando
DO CASE
   CASE Impressora=="SWEDA"
        /* Este modelo cancela somente o ultimo item vendido */
        Set Printer To IFSWEDA
        Set Device To Print
        cComando:= Chr( 27 ) + ".04}"
        @ PRow(),PCol() Say cComando
        Set Device To Screen
        Return( LEN( VerErro( cComando ) ) <= 1 )

   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 205 ) + StrZero( nPosicao, 3, 0 )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 205 ) + StrZero( nPosicao, 3, 0 )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="URANO"
        CancelItem( "Item Cancelado...", StrZero( nPosicao, 3, 0 ) )

   CASE Impressora=="EPSON"
        IF EpsonCancela( nPosicao )
           cImp:= Set( 24, PortaImpressao, .f. )
           Set( _SET_DEVICE, "PRINTER" )
           @ PROW()+1,00 Say "Cancelado Item: " + StrZero(  nPosicao, 3, 0 )
           Set( _SET_PRINTER, cImp )
           Set( _SET_DEVICE, "SCREEN" )
        ENDIF

   CASE Impressora=="BEMATECH-MP20FI-II"
        private comando := chr(27) + chr(251) + "31|" + StrZero( nPosicao, 4, 0 ) + chr(27)
        private ack := Space(1)
        private st1 := Space(1)
        private st2 := Space(1)

        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fwrite( ImpFiscal, @comando,len(comando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
           lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread(ImpFiscal,@st2,1)
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
           lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        RELEASE st1
        RELEASE st2
        RELEASE ImpFiscal
        RELEASE Comando
        RELEASE lFim
        Return lRetorno

   CASE Impressora=="BEMATECH"
        private comando := chr(27) + chr(251) + "31|" + StrZero( nPosicao, 4, 0 ) + chr(27)
        private ack := Space(1)
        private st1 := Space(1)
        private st2 := Space(1)

        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fwrite( ImpFiscal, @comando,len(comando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
           lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread(ImpFiscal,@st2,1)
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
           lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        RELEASE st1
        RELEASE st2
        RELEASE ImpFiscal
        RELEASE Comando
        RELEASE lFim
        Return lRetorno

   CASE Impressora=="SCHALTER-II"
        IF CancIDef( Str( nPosicao, 4, 0 ), "ITEM CANCELADO" )==0
           Return .T.
        ELSE
           Return .F.
        ENDIF

   CASE Impressora=="SCHALTER"
        IF CancIDef( Str( nPosicao, 4, 0 ), "ITEM CANCELADO" )==0
           Return .T.
        ELSE
           Return .F.
        ENDIF

ENDCASE
Return Nil

/*====================================
Funcao      IMPCANCCUPOM
Finalidade  Cancelar o ultimo cupom emitido
Parametros  Nil
Programador Valmor Pereira Flores
Data        15/07/98
Atualizacao 15/07/98
-------------------------------------*/
Function impCancCupom()
Local cComando
DO CASE
   CASE Impressora=="SCHALTER-II"
        IF CancVenda("")==0     /* Cupom Aberto */
           Return .T.
        ELSEIF CancDoc("")==0   /* Cupom Fechado */
           Return .T.
        ELSE                    /* Falha nas Operacoes */
           Return .F.
        ENDIF

   CASE Impressora == "SCHALTER"
        IF CancVenda("")==0     /* Cupom Aberto */
           Return .T.
        ELSEIF CancDoc("")==0   /* Cupom Fechado */
           Return .T.
        ELSE                    /* Falha nas Operacoes */
           Return .F.
        ENDIF

   CASE Impressora == "SWEDA"
        cComando:= Chr( 27 ) + ".05}"
        Set Printer To IFSWEDA
        Set Device To Print
        @ Prow(), PCol() Say cComando
        Set Device To Screen
        Return LEN( VerErro( cComando ) ) <= 1

   CASE Impressora == "SIGTRON"
        cComando:= Chr( 27 ) + Chr( 206 )
        Com_Send( impPorta(), cComando )


   CASE Impressora=="SIGTRON-FS345"
        cComando:= Chr( 27 ) + Chr( 206 )
        Com_Send( impPorta(), cComando )

   CASE Impressora == "URANO"
        CancelVoucher( StrZero( CodigoCaixa, 8, 0 ) )
        AdvanceLine( "0", "07" )

   CASE Impressora == "EPSON"
        IF EpsonCanCupom()
           cImp:= Set( 24, PortaImpressao, .f. )
           Set( _SET_DEVICE, "PRINTER" )
           @ PROW()+1,00 Say "----------------------------------------"
           @ PROW()+1,00 Say " CANCELAMENTO  DE  ORCAMENTO "
           @ PROW()+1,00 Say "-------------------------------"+ TIME()
           @ PROW()+5,00 Say "Responsavel____________________________"
           @ PROW()+5,00 Say "======================================="
           Set( _SET_PRINTER, cImp )
           Set( _SET_DEVICE, "SCREEN" )
           Return .T.
        ENDIF
        /* Cadastro de Materia Prima */

   CASE Impressora=="BEMATECH"
        private comando := chr(27) + chr(251) + "14|" + chr(27)
        private ack := Space(1)
        private st1 := Space(1)
        private st2 := Space(1)
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        fwrite( ImpFiscal, @comando,len(comando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
           lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread(ImpFiscal,@st2,1)
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
           lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        Release st1
        Release st2
        Release ImpFiscal
        Release Comando
        Release lFim
        Return lRetorno

   CASE Impressora=="BEMATECH-MP20FI-II"
        private comando := chr(27) + chr(251) + "14|" + chr(27)
        private ack := Space(1)
        private st1 := Space(1)
        private st2 := Space(1)
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
        fwrite( ImpFiscal, @comando,len(comando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
           lRetorno:= .F.
        endif
        fread(ImpFiscal,@ack,1)
        if ferror() # 0 .and. !lFim
           lFim:= .T.
           lRetorno:= .F.
        endif
        IF !lFim
           FRead( ImpFiscal, @st1, 1 )
           IF ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           ENDIF
        ENDIF
        IF !lFim
           fread( ImpFiscal, @st2, 1 )
           if ferror() # 0 .AND. !lFim
              lFim:= .T.
              lRetorno:= .F.
           endif
        ENDIF
        IF Erro(ack,st1,st2)
           lRetorno:= .f.
        ELSE
           lRetorno:= .t.
        ENDIF
        FClose( ImpFiscal )
        Release st1
        Release st2
        Release ImpFiscal
        Release Comando
        Release lFim
        Return lRetorno
ENDCASE
Return nil

/*====================================
Funcao       IMPFECHASEM
Finalidade   Fechar o Cupom com Desconto Percentual ou Valor s/ Total
Parametros   nPerAcrDes = Percentual de desconto
             nVlrAcrDes = Valor de Acrescimo/Desconto
             nValorPago = Valor Pago pelo Cliente
             cMensagem = Mensagem Promocional
             cCgcCpf = CGC/CPF do cliente
Procedimento Se nPerAcrDes <> NIL = Desconto/Acrescimo em %
             Se nPerAcrDes < 0 = Desconto
             Se nPerAcrDes > 0 = Acrescimo
             Se nVlrAcrDes <> NIL = Desconto/Acrescimo em R$
             Se nVlrAcrDes < 0 = Desconto
             Se nVlrAcrDes > 0 = Acrescimo
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98                                                         
-------------------------------------*/
Function impFechaSem( cAcrDes, nPerAcrDes, nVlrAcrDes, nVlrPagar, nValorPago, cMensagem, cCgcCpf )
Local cComando, cDesconto, cPago, nVlrDesconto
Local nMens:= 0
DO CASE
   CASE Impressora $ "Nenhuma-Treinamento"

   CASE Impressora=="SIGTRON-FS345"

        IF Driver="W2000"
           CRLF:= CHR( 10 )
        ELSE
           CRLF:= CHR( 13 ) + CHR( 10 )
        ENDIF

        // Verifica se informacao esta negativa
        IF nVlrAcrDes < 0
           nVlrAcrDes:= nVlrAcrDes * (-1)
        ENDIF


        /* TOTALIZACAO DO CUPOM FISCAL */
        /* Desconto Percentual / Sem Desconto */
        cComando:= Chr( 27 ) + Chr( 241 ) + "0000" + "000000000"

        If cAcrDes = "D"
           IF nPerAcrDes > 0
              cDesconto:= StrTran( Tran( nPerAcrDes, "@R 99.99" ), ".", "" )
              cDesconto:= "0" + StrZero( VAL( cDesconto ), 4, 0 )
              cComando:= Chr( 27 ) + Chr( 241 ) + cDesconto + "00000000"
           ELSEIF nVlrAcrDes > 0
              cDesconto:= StrTran( Tran( nVlrAcrDes, "@R 9999999999.99" ), ".", "" )
              cDesconto:= "1" + StrZero( VAL( cDesconto ), 12, 0 )
              cComando:= Chr( 27 ) + Chr( 241 ) + cDesconto
           ENDIF
        Else
           IF nPerAcrDes > 0
              cDesconto:= StrTran( Tran( nPerAcrDes, "@R 99.99" ), ".", "" )
              cDesconto:= "2" + StrZero( VAL( cDesconto ), 4, 0 )
              cComando:= Chr( 27 ) + Chr( 241 ) + cDesconto + "00000000"
           ELSEIF nVlrAcrDes > 0
              cDesconto:= StrTran( Tran( nVlrAcrDes, "@R 9999999999.99" ), ".", "" )
              cDesconto:= "3" + StrZero( VAL( cDesconto ), 12, 0 )
              cComando:= Chr( 27 ) + Chr( 241 ) + cDesconto
           ENDIF
        EndIf
        /* Primeiro Comando 241 */
        Com_Send( impPorta(), cComando )
        IF Driver="W2000"
           IF AT( ":E", Com_Read( "", 200 ) ) > 0
               /* ERRO */
           ENDIF
        ENDIF

        /// FECHAMENTO -> FORMA DE PAGAMENTO
        IF AT( "F O R M A   D E   P A G A M E N T O", cMensagem ) > 0
           cComando:= Chr( 27 ) + Chr( 242 ) + ForPagAPrazo + "0000000000000" + " Condicao Especial ---------------------------" + Chr( 255 )
        ELSEIF AT( "Pr--", cMensagem ) > 0
           cMensagem:= Left( cMensagem, AT( "Pr--", cMensagem ) )
           cComando:= Chr( 27 ) + Chr( 242 ) + ForPagAPrazo + "0000000000000" + ForPagAPrazo + " = Crediario" +  Chr( 255 )
        ELSE
           cComando:= Chr( 27 ) + Chr( 242 ) + ForPagDinheiro + "0000000000000" + ForPagDinheiro + " = A Vista" +  Chr( 255 )
        ENDIF

        //// MULTIPLAS ///


        /* Segundo Comando 242 = OBSERVACOES */
        Com_Send( impPorta(), cComando )
        IF Driver="W2000"
           IF AT( ":E", Com_Read( "", 200 ) ) > 0
               /* ERRO */
           ENDIF
        ENDIF

        /* configuracao do CGC/CPF */
        IF cCgcCpf <> Nil
           IF Len( ALLTRIM( cCgcCpf ) ) < 14
              cCgcCpf:= "CPF: " + Tran( Alltrim( cCgcCpf ), "@R 999.999.999-99" )
           ELSE
              cCgcCpf:= "CGC: " + Tran( Alltrim( cCgcCpf ), "@R 99.999.999/9999-99" )
           ENDIF
        ELSE
           cCgcCpf:= Space( 14 )
        ENDIF

        cComando:= Chr( 27 ) + Chr( 243 ) + cCgcCpf +  CRLF + cMensagem + CRLF
        cComando:= cComando + " Soft&Ware -       www.fortunaonline.com.br   " + Chr( 255 )

        /* Terceiro Comando 243 - Fim do Fechamento */
        Com_Send( impPorta(), cComando )
        IF Driver="W2000"
           IF AT( ":E", Com_Read( "", 200 ) ) > 0
               /* ERRO */
           ENDIF
        ENDIF

   CASE Impressora=="SIGTRON"

       IF Driver=="W2000"
          CRLF:= CHR( 10 )
       ELSE
          CRLF:= CHR( 13 ) + CHR( 10 )
       ENDIF

       /* Desconto Percentual / Sem Desconto */
       IF nVlrAcrDes > 0
          cDesconto:= StrTran( Tran( nVlrAcrDes, "@R 9999999999.99" ), ".", "" )
          cDesconto:= StrZero( VAL( cDesconto ), 12, 0 )
          cComando:= Chr( 27 ) + Chr( 213 ) + cDesconto
       ELSE
          cDesconto:= StrTran( Tran( nPerAcrDes, "@R 99.99" ), ".", "" )
          cDesconto:= StrZero( VAL( cDesconto ), 4, 0 )
          cComando:= Chr( 27 ) + Chr( 201 ) + cDesconto
       ENDIF

       /* configuracao do CGC/CPF */
       IF cCgcCpf <> Nil
          IF Len( ALLTRIM( cCgcCpf ) ) < 14
             cCgcCpf:= "CPF: " + Tran( Alltrim( cCgcCpf ), "@R 999.999.999-99" )
          ELSE
             cCgcCpf:= "CGC: " + Tran( Alltrim( cCgcCpf ), "@R 99.999.999/9999-99" )
          ENDIF
       ELSE
          cCgcCpf:= Space( 14 )
       ENDIF

       cPago:= StrTran( Tran( nValorPago, "@R 9999999999.99" ), ".", "" )

       cMensagem:= cCgcCpf + CRLF + cMensagem + CRLF + " SOFT&WARE           www.fortunaonline.com.br"

       /* Conclusao do comando */
       cComando:= cComando + cMensagem + Chr( 255 )
       Com_Send( impPorta(), cComando )

       IF Driver="W2000"
          IF AT( ":E", Com_Read( "", 200 ) ) > 0
              /* ERRO */
          ENDIF
       ENDIF

   CASE Impressora=="BEMATECH"

       cPago:= StrTran( StrZero( nValorPago * 10, 16, 02 ), ".", "" )
       cComando:= Chr( 27 ) + Chr( 251 ) + "10|0000" + "|" + ;
                  cPago + "|D|" + cCGCCPF + Chr( 13 ) + Chr( 10 ) + cMensagem + Chr( 13 ) + Chr( 10 ) + "|" + Chr( 225 ) + Chr( 27 )
       private ack := space(1)
       private st1 := space(1)
       private st2 := space(1)
       Private Comando:= cComando
       ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
       fwrite( ImpFiscal, @comando,len(comando))
       lFim:= .F.
       if ferror() # 0
          lFim:= .T.
          lRetorno:= .F.
       endif
       fread( ImpFiscal, @ack, 1 )
       if ferror() # 0 .and. !lFim
          lFim:= .T.
          lRetorno:= .F.
       endif
       IF !lFim
          FRead( ImpFiscal, @st1, 1 )
          IF ferror() # 0 .AND. !lFim
             lFim:= .T.
             lRetorno:= .F.
          ENDIF
       ENDIF
       IF !lFim
          fread(ImpFiscal,@st2,1)
          if ferror() # 0 .AND. !lFim
             lFim:= .T.
             lRetorno:= .F.
          endif
       ENDIF
       IF Erro(ack,st1,st2)
          lRetorno:= .f.
       ELSE
         lRetorno:= .t.
       ENDIF
       FClose( ImpFiscal )
       RELEASE st1
       RELEASE st2
       RELEASE ImpFiscal
       RELEASE Comando
       RELEASE lFim
       Return lRetorno

   CASE Impressora=="SCHALTER-II"

        cValor:= "000000000"
        IF nPerAcrDes > 0
           cDesconto:= nVlrPagar * ( nPerAcrDes / 100 )
           cValor:= StrZero( cDesconto * 100, 9, 0 )
        ELSEIF nVlrAcrDes > 0
           cDesconto:= StrTran( Tran( nVlrAcrDes, "@R 9999999999.99" ), ".", "" )
           cValor:= StrZero( VAL( cDesconto ) * 100, 9, 0 )
        ENDIF
        IF VAL( cValor ) > 0
           IF SubTotal()==0
              CADSubTot( IF( cAcrDes=="D", 0, 1 ),;
                               0,;
               IF( cAcrDes=="D","", "" ),;
                         cValor )
           ENDIF
        ENDIF

        cCondicao:= "00"

        /// Se Valor Pago==0, joga como crediario ///
        IF nValorPago==0
           nValorPago:= nVlrPagar
           cCondicao:= "01"
        ENDIF

        nRet:= 0
        /* Lanca Pagamento */
        IF ( nRet:= Pagamnt( 0,;
                    StrZero( nValorPago * 100, 10, 0 ),;
                    0,;
                    1,;
                   cCondicao ) )==0

           ImpLinha( "-----------------------------------------" )

           nPos:= 1
           FOR nCt:= 1 TO Len( cMensagem )
               IF SubStr( cMensagem, nCt, 2 )==CHR( 13 )+CHR( 10 )
                  IF !ALLTRIM( SubStr( cMensagem, nPos, nCt-nPos ) )==""
                     ImpLinha( ALLTRIM( SubStr( cMensagem, nPos, nCt-nPos ) ) )
                     IF !( Alltrim( cCgcCPF ) == "" )
                        ImpLinha( cCgcCPF )
                     endif
                  ENDIF
                  nPos:= nCt + 2
               ENDIF
           NEXT

           IMPLinha( "/////////////// WWW.FORTUNAONLINE.COM.BR" )

           IF FimTrans( "FORTUNA" )==0
              LineFeed( 1, 10 )
              Return .T.
           ELSE
              Return .F.
           ENDIF
        ELSE
           @ 24,01 Say nRet
           @ 24,01 Say "IMP#"
           INKEY(0)
           Return .F.
        ENDIF

   CASE Impressora=="SCHALTER"

        cValor:= "000000000"
        IF nPerAcrDes > 0
           cDesconto:= nVlrPagar * ( nPerAcrDes / 100 )
           cValor:= StrZero( cDesconto * 100, 9, 0 )
        ELSEIF nVlrAcrDes > 0
           cDesconto:= StrTran( Tran( nVlrAcrDes, "@R 9999999999.99" ), ".", "" )
           cValor:= StrZero( VAL( cDesconto ) * 100, 9, 0 )
        ENDIF
        IF VAL( cValor ) > 0
           IF SubTotal()==0
              CADSubTot( IF( cAcrDes=="D", 0, 1 ),;
                               0,;
               IF( cAcrDes=="D","", "" ),;
                         cValor )
           ENDIF
        ENDIF

        cCondicao:= "00"

        /// Se Valor Pago==0, joga como crediario ///
        IF nValorPago==0
           nValorPago:= nVlrPagar
           cCondicao:= "01"
        ENDIF

        nRet:= 0
        /* Lanca Pagamento */
        IF ( nRet:= Pagamnt( 0,;
                    StrZero( nValorPago * 100, 10, 0 ),;
                    0,;
                    1,;
                   cCondicao ) )==0

           ImpLinha( "-----------------------------------------" )

           nPos:= 1
           FOR nCt:= 1 TO Len( cMensagem )
               IF SubStr( cMensagem, nCt, 2 )==CHR( 13 )+CHR( 10 )
                  IF !ALLTRIM( SubStr( cMensagem, nPos, nCt-nPos ) )==""
                     ImpLinha( ALLTRIM( SubStr( cMensagem, nPos, nCt-nPos ) ) )
                  ENDIF
                  nPos:= nCt + 2
               ENDIF
           NEXT

           IMPLinha( "/////////////// WWW.FORTUNAONLINE.COM.BR" )

           IF FimTrans( "FORTUNA" )==0
              LineFeed( 1, 10 )
              Return .T.
           ELSE
              Return .F.
           ENDIF
        ELSE
           @ 24,01 Say nRet
           @ 24,01 Say "IMP#"
           INKEY(0)
           Return .F.
        ENDIF

   CASE Impressora=="EPSON"
        cImp:= Set( 24, PortaImpressao, .f. )

/*
@11,05 say "fecha"
@12,05 say impressora
@13,05 say portaimpressao
@14,05 SAY SET(24)
inkey(0)
@11,04 clear to 14,10
SET PRINTER TO &PORTAIMPRESSAO.
*/

        Set( _SET_DEVICE, "PRINTER" )
        nFim:= 0
        @ Prow()+1,00 Say "-------- FECHAMENTO DO ORCAMENTO ---------"
        @ PRow()+1,00 Say "Total.....:" + Space( 16 ) + Tran( nFim:= EpsonFinaliza(), "@E 999,999,999.99" )
        IF nVlrAcrDes > 0
           @ Prow()+1,00 Say "Desconto..:" + Space( 16 ) + Tran( nVlrAcrDes,             "@E 999,999,999.99" )
           nFim:= nFim  - nVlrAcrDes
        ENDIF
        @ Prow()+1,00 Say "Valor.....:" + Space( 16 ) + Tran( nValorPago,             "@E 999,999,999.99" )
        @ PRow()+1,00 Say "Diferenca.:" + Space( 16 ) + Tran( nValorPago - nFim,      "@E 999,999,999.99" )
        @ PRow()+1,00 Say "-------------------------------========<<<"
        @ PRow()+1,00 Say cMensagem
        @ PRow()+1,00 Say "SEM VALOR FISCAL ************************ "
        @ PRow()+1,00 Say "************ SEM VALOR FISCAL *********** "
        @ PRow()+1,00 Say "************************ SEM VALOR FISCAL "
        Set( 20, "PRINT" )
        Set( 24, "LPT2" )
        Set( 20, "PRINT" )
        Set( 24, "LPT1" )
        Set( 20, "PRINT" )
        Set( _SET_PRINTER, cImp )
        Set( _SET_DEVICE, "SCREEN" )

   CASE Impressora=="URANO"
        cValorPago:= StrTran( Tran( nValorPago, "9999999.99" ), ".", "" )
        /* Tratamento de desconto ao final do cupom Fiscal */
        IF nPerAcrDes > 0 .OR. nVlrAcrDes > 0
           IF nVlrAcrDes > 0
              nVlrDesconto:= nVlrAcrDes
           ELSE
              nVlrDesconto:= ( nVlrPagar * nPerAcrDes ) / 100
           ENDIF
           cDesconto:= Tran( nVlrDesconto, "9999999.99" )
           DiscountSubTotal( "0", " ", StrTran( cDesconto, ".", "" ) )
        ENDIF
        cMensagem:= Left( cMensagem, 60 ) + Chr(13) + Chr(10) + " SOFT&WARE         www.fortunaonline.com.br"
        Payment( "PAGAMENTO", cValorPago )
        ComercialText( "0", cMensagem )
        EndSale( "A", StrZero( CodigoCaixa, 6, 0 ) )
        AdvanceLine( "0", "07" )

   CASE Impressora=="SWEDA"

        /* CASO HAJA DESCONTO EM PERCENTUAL */
        IF nVlrAcrDes > 0
           cComando:= Chr( 27 ) + ".03ABATIMENTO" + StrZero( nVlrAcrDes * 100, 12, 0 )
           cComando+= "}"
           Set Printer To IFSWEDA
           Set Device To Print
           @ PRow(), PCol() Say cComando
           Set Device To Screen

        /* CASO HAJA DESCONTO EM VALOR */
        ELSEIF nPerAcrDes > 0
           nVlrAcrDes:= ( nVlrPagar * nPerAcrDes ) / 100
           cComando:= Chr( 27 ) + ".03ABATIMENTO" + StrZero( nVlrAcrDes * 100, 12, 0 )
           cComando+= "}"
           Set Printer To IFSWEDA
           Set Device To Print
           @ PRow(), PCol() Say cComando
           Set Device To Screen
        ENDIF

        /* RECEBIMENTOS - CREDIARIO OU A VISTA */
        cComando:= Chr( 27 ) + ".10"
        IF nValorPago==0
           cComando+= "04" + StrTran( StrZero( nVlrPagar, 13, 02 ), ".", "" )
        ELSE
           cComando+= "01" + StrTran( StrZero( nValorPago, 13, 02 ), ".", "" )
        ENDIF
        cComando+= "}"
        Set Printer To IFSWEDA
        Set Device To Print
        @ PRow(), PCol() Say cComando
        Set Device To Screen
        lErro:= !( LEN( VerErro( cComando ) ) <= 1 )
        IF !lErro .OR. .T.

           // Comando sem mensagem - Padrao //
           cComando:= Chr( 27 ) + ".12}"
           IF !( cMensagem == Nil )
              IF !( Fechamento == Nil )
                 IF Len( Fechamento ) > 0
                    cMsg:= ""
                    nMens:= 0
                    // Inicializacao do Comando
                    cComando:= Chr( 27 ) + ".12"
                    FOR nCt:= 1 TO Len( cMensagem )
                        IF SubStr( cMensagem, nCt, 1 )==Chr( 13 )
                           IF ++nMens > 8
                              EXIT
                           ENDIF
                           // Ascrecenta mensagem ao comando
                           cMsg:= "0" + PAD( cMsg, 40 )
                           cComando:= cComando + cMsg
                           cMsg:= ""
                           nCt:= nCt + 1   // Pular Chr( 10 ) ja que as mensagens
                                           // sao separadas pelos Chr( 13 ) + Chr( 10 )
                        ELSE
                           cMsg:= cMsg + SubStr( cMensagem, nCt, 1 )
                        ENDIF
                    NEXT
                    // Finalizacao do comando
                    cComando:= cComando + "}"
                 ENDIF
              ENDIF
           ENDIF

           /* Imprime CGC-CPF */
           if !Empty( cCGCCPF )
              if LEN( ALLTRIM( cCgcCpf ) )==11
                 cCmd:= Chr( 27 ) +  ".06001 " + Tran( cCGCCPF, "@R 999.999.999-99" ) + "}"
              else
                  cCmd:= Chr( 27 ) + ".06002 " + Tran( cCGCCPF, "@R 99.999.999/9999-99" ) + "}"
              endif
              Set Printer To IFSWEDA
              Set Device To Print
              @ PRow(), PCol() Say cCmd
              Set Device To Screen
           endif

           Set Printer To IFSWEDA
           Set Device To Print
           @ PRow(), PCol() Say cComando
           Set Device To Screen
           Return Len( VerErro( cComando ) ) <= 1

        ENDIF
        Set Device To Screen
        Return .F.

   CASE Impressora=="BEMATECH-MP20FI-II"

       /* inicio do fechamento SEM FORMAS DE PGTO */

       cComando := Chr( 27 ) + Chr( 251 ) + "10|"
       cComando += StrZero( nPerAcrDes * 100,  4, 0) + "|"
       cComando += StrZero( nValorPago * 100, 14, 0) + "|"

       IF (nPerAcrDes == 0 .AND. nVlrAcrDes > 0)
          cComando += LOWER( cAcrDes ) + "|"
          cComando += StrZero( nVlrAcrDes * 100, 14, 0 ) + "|"
       ELSE
          cComando += cAcrDes + "|"
       ENDIF

       cComando += AllTrim(cMensagem) + Chr( 13 ) + Chr( 10 ) + Propaganda + "|" + Chr(13) + Chr(10) + Chr(27)

       /* Comanda a impressora */
       private ack := space(1)
       private st1 := space(1)
       private st2 := space(1)
       Private Comando:= cComando
       ImpFiscal:= fopen( PortaImpressao, FO_READWRITE )
       fwrite( ImpFiscal, @comando,len(comando))
       lFim:= .F.
       if ferror() # 0
          lFim:= .T.
          lRetorno:= .F.
       endif
       fread(ImpFiscal,@ack,1)
       if ferror() # 0 .and. !lFim
          lFim:= .T.
          lRetorno:= .F.
       endif
       IF !lFim
          FRead( ImpFiscal, @st1, 1 )
          IF ferror() # 0 .AND. !lFim
             lFim:= .T.
             lRetorno:= .F.
          ENDIF
       ENDIF
       IF !lFim
          fread(ImpFiscal,@st2,1)
          if ferror() # 0 .AND. !lFim
             lFim:= .T.
             lRetorno:= .F.
          endif
       ENDIF
       IF Erro(ack,st1,st2)
          lRetorno:= .f.
       ELSE
         lRetorno:= .t.
       ENDIF
       FClose( ImpFiscal )
       RELEASE st1
       RELEASE st2
       RELEASE ImpFiscal
       RELEASE Comando
       RELEASE lFim

    Return lRetorno

ENDCASE
Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function impFechaCom( cAcrDes, nPerAcrDes, nVlrAcrDes,;
                         nValorPago, cForma, cMensagem )
   Local cComando

      DO CASE
         CASE Impressora=="BEMATECH-MP20FI-II"

             /* Comanda a impressora */
             private ack := space(1)
             private st1 := space(1)
             private st2 := space(1)

             ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )

             /* inicio do fechamento COM FORMAS DE PGTO */
             cComando := Chr(27) + Chr (251) + "32|"

             IF (nPerAcrDes > 0)
                cComando += cAcrDes + "|"
                cComando += StrZero (nPerAcrDes * 100,  4, 0) + "|" + Chr(27)
             ELSE
                IF (nVlrAcrDes > 0)
                   cComando += LOWER (cAcrDes) + "|"
                   cComando += StrZero (nVlrAcrDes * 100, 14, 0) + "|" + Chr(27)
                ELSE
                   cComando += cAcrDes + "|"
                   cComando += StrZero (0,  4, 0) + "|" + Chr(27)
                ENDIF
             ENDIF

             FWrite (ImpFiscal, @cComando, LEN(cComando))
             FClose( ImpFiscal )

             private ack := space(1)
             private st1 := space(1)
             private st2 := space(1)

             ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )

             private ack := space(1)
             private st1 := space(1)
             private st2 := space(1)

             ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )

             cCom_72 := Chr(27) + Chr (251) + "72|"
             cCom_72 += ForPagDinheiro + "|" + StrZero( nValorPago * 100, 14, 0 ) + ;
                            "||" + Chr(27)

             FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
             FClose( ImpFiscal )

             private ack := space(1)
             private st1 := space(1)
             private st2 := space(1)

             ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )

             cComando := Chr(27) + Chr(251) + "34|" + cMensagem + "|" + ;
                         Chr(13) + Chr(10) + Chr(27)

             FWrite (ImpFiscal, @cComando, LEN (cComando))

             lFim:= .F.
             if ferror() # 0
                lFim:= .T.
                lRetorno:= .F.
             endif
             fread(ImpFiscal,@ack,1)
             if ferror() # 0 .and. !lFim
                lFim:= .T.
                lRetorno:= .F.
             endif
             IF !lFim
                FRead( ImpFiscal, @st1, 1 )
                IF ferror() # 0 .AND. !lFim
                   lFim:= .T.
                   lRetorno:= .F.
                ENDIF
             ENDIF
             IF !lFim
                fread(ImpFiscal,@st2,1)
                if ferror() # 0 .AND. !lFim
                   lFim:= .T.
                   lRetorno:= .F.
                endif
             ENDIF
             IF Erro(ack,st1,st2)
                lRetorno:= .f.
             ELSE
               lRetorno:= .t.
             ENDIF
             FClose( ImpFiscal )
             RELEASE st1
             RELEASE st2
             RELEASE ImpFiscal
             RELEASE Comando
             RELEASE lFim
             Return lRetorno

      ENDCASE

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fProForPag () // Programacao das Formas de Pagamento

   Local cComando

      DO CASE

         CASE Impressora=="BEMATECH-MP20FI-II"

            private ack := space(1)
            private st1 := space(1)
            private st2 := space(1)
            ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
            cCom_71 := Chr(27) + Chr (251) + "71|" + PAD( "Ticket's", 16 ) + "|" + Chr(27)
            FWrite ( ImpFiscal, @cCom_71, LEN( cCom_71 ) )
            FClose( ImpFiscal )

            private ack := space(1)
            private st1 := space(1)
            private st2 := space(1)
            ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
            cCom_71 := Chr(27) + Chr (251) + "71|" + PAD( "Cheque", 16 ) + "|" + Chr(27)
            FWrite ( ImpFiscal, @cCom_71, LEN( cCom_71 ) )
            FClose( ImpFiscal )

            private ack := space(1)
            private st1 := space(1)
            private st2 := space(1)
            ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
            cCom_71 := Chr(27) + Chr (251) + "71|" + PAD( "Cartao", 16 ) + "|" + Chr(27)
            FWrite ( ImpFiscal, @cCom_71, LEN( cCom_71 ) )
            FClose( ImpFiscal )

            private ack := space(1)
            private st1 := space(1)
            private st2 := space(1)
            ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
            cCom_71 := Chr(27) + Chr (251) + "71|" + PAD( "V.Prazo", 16 ) + "|" + Chr(27)
            FWrite ( ImpFiscal, @cCom_71, LEN( cCom_71 ) )
            FClose( ImpFiscal )

            private ack := space(1)
            private st1 := space(1)
            private st2 := space(1)
            ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
            cCom_71 := Chr(27) + Chr (251) + "71|" + PAD( "Outros", 16 ) + "|" + Chr(27)
            FWrite ( ImpFiscal, @cCom_71, LEN( cCom_71 ) )
            FClose( ImpFiscal )

            // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä

            lFim:= .F.
            if ferror() # 0
               lFim:= .T.
               lRetorno:= .F.
            endif
            fread(ImpFiscal,@ack,1)
            if ferror() # 0 .and. !lFim
               lFim:= .T.
               lRetorno:= .F.
            endif
            IF !lFim
               FRead( ImpFiscal, @st1, 1 )
               IF ferror() # 0 .AND. !lFim
                  lFim:= .T.
                  lRetorno:= .F.
               ENDIF
            ENDIF
            IF !lFim
               fread(ImpFiscal,@st2,1)
               if ferror() # 0 .AND. !lFim
                  lFim:= .T.
                  lRetorno:= .F.
               endif
            ENDIF

            IF Erro(ack,st1,st2)
               lRetorno:= .f.
            ELSE
              lRetorno:= .t.
            ENDIF

            FClose( ImpFiscal )
            RELEASE st1
            RELEASE st2
            RELEASE ImpFiscal
            RELEASE Comando
            RELEASE lFim
            Return lRetorno

      ENDCASE

   Return (.T.)
//
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fImpMoeda (nPgtDin, nPgtTic, nPgtChq, nPgtCar, nPgtPra, nPgtOut, cMensagem )  //AQUI 04 = 32 72 34

   Local cComando

      DO CASE

         CASE Impressora=="BEMATECH-MP20FI-II"

             IF (nPgtDin > 0 .OR. nPgtTic > 0 .OR. nPgtChq > 0 .OR. ;
                 nPgtPra > 0 .OR. nPgtOut > 0)

                private ack := space(1)
                private st1 := space(1)
                private st2 := space(1)

                ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )

                // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä

                cComando := Chr(27) + Chr (251) + "32|"

                cComando += "A"+ "|"
                cComando += StrZero (0,  4, 0) + "|" + Chr(27)

                FWrite (ImpFiscal, @cComando, LEN(cComando))

                // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä

                IF (nPgtDin > 0)
                   private ack := space(1)
                   private st1 := space(1)
                   private st2 := space(1)
                   ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
                   cCom_72 := Chr(27) + Chr (251) + "72|"
                   cCom_72 += "01|" + StrZero( nPgtDin * 100, 14, 0 ) + ;
                              "||" + Chr(27)
                   FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
                   FClose( ImpFiscal )

                ENDIF

                IF (nPgtTic > 0)
                   private ack := space(1)
                   private st1 := space(1)
                   private st2 := space(1)
                   ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
                   cCom_72 := Chr(27) + Chr (251) + "72|"
                   cCom_72 += ForPagTickets + "|" + StrZero( nPgtTic * 100, 14, 0 ) + ;
                              "||" + Chr(27)
                   FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
                   FClose( ImpFiscal )
                ENDIF

                IF (nPgtChq > 0)
                   private ack := space(1)
                   private st1 := space(1)
                   private st2 := space(1)
                   ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
                   cCom_72 := Chr(27) + Chr (251) + "72|"
                   cCom_72 += ForPagCheque + "|" + StrZero( nPgtChq * 100, 14, 0 ) + ;
                              "||" + Chr(27)
                   FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
                   FClose( ImpFiscal )
                ENDIF

                IF (nPgtCar > 0)
                   private ack := space(1)
                   private st1 := space(1)
                   private st2 := space(1)
                   ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
                   cCom_72 := Chr(27) + Chr (251) + "72|"
                   cCom_72 += ForPagCartao + "|" + StrZero( nPgtCar * 100, 14, 0 ) + ;
                              "||" + Chr(27)
                   FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
                   FClose( ImpFiscal )
                ENDIF

                IF (nPgtPra > 0)
                   private ack := space(1)
                   private st1 := space(1)
                   private st2 := space(1)
                   ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
                   cCom_72 := Chr(27) + Chr (251) + "72|"
                   cCom_72 += ForPagAPrazo + "|" + StrZero( nPgtPra * 100, 14, 0 ) + ;
                              "||" + Chr(27)
                   FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
                   FClose( ImpFiscal )
                ENDIF

                IF (nPgtOut > 0)
                   private ack := space(1)
                   private st1 := space(1)
                   private st2 := space(1)
                   ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
                   cCom_72 := Chr(27) + Chr (251) + "72|"
                   cCom_72 += ForPagOutros + "|" + StrZero( nPgtOut * 100, 14, 0 ) + ;
                              "||" + Chr(27)
                   FWrite ( ImpFiscal, @cCom_72, LEN( cCom_72 ) )
                   FClose( ImpFiscal )
                ENDIF

                // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä

                ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )

*               cMensagem:= ""
                cCom_34 := Chr(27) + Chr(251) + "34|" + cMensagem + "|" + ;
                              Chr(13) + Chr(10) + Chr(27)


                FWrite(ImpFiscal, @cCom_34, LEN (cCom_34))

                // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä

                lFim:= .F.
                if ferror() # 0
                   lFim:= .T.
                   lRetorno:= .F.
                endif
                fread(ImpFiscal,@ack,1)
                if ferror() # 0 .and. !lFim
                   lFim:= .T.
                   lRetorno:= .F.
                endif
                IF !lFim
                   FRead( ImpFiscal, @st1, 1 )
                   IF ferror() # 0 .AND. !lFim
                      lFim:= .T.
                      lRetorno:= .F.
                   ENDIF
                ENDIF
                IF !lFim
                   fread(ImpFiscal,@st2,1)
                   if ferror() # 0 .AND. !lFim
                      lFim:= .T.
                      lRetorno:= .F.
                   endif
                ENDIF

                IF Erro(ack,st1,st2)
                   lRetorno:= .f.
                ELSE
                  lRetorno:= .t.
                ENDIF

                FClose( ImpFiscal )
                RELEASE st1
                RELEASE st2
                RELEASE ImpFiscal
                RELEASE Comando
                RELEASE lFim
                Return lRetorno

             ENDIF

      ENDCASE

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ impHora()
³ Finalidade  ³ Pega a hora da impressora
³ Parametros  ³ Nil
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ImpHora()
Local nCont:= 0
Local cComando:= Chr( 27 ) + Chr( 239 )
Com_Send( impPorta(), cComando )
cRetorno:= Com_Read( ImpPorta(), 73 )
cRetorno:= SubStr( cRetorno, 17, 6 )
Return Tran( cRetorno, "@R 99:99:99" )



/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ ImpLeStatus
³ Finalidade  ³ Fazer a leitura dos dados guardados na impressora
³ Parametros  ³ Nil
³ Retorno     ³ Status
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ImpLeStatus()
Local nCont:= 0
Local cComando, cRet:= Space( 20 ), cRetorno
IF Impressora=="SIGTRON"
   cComando:= Chr( 27 ) + Chr( 240 )
   Com_Send( impPorta(), cComando )
   cRetorno:= Com_Read( ImpPorta(), 100 )
   cRetorno:= SubStr( cRetorno, AT( Chr( 58 ) + Chr( 27 ) + Chr( 240 ), cRetorno ) )
ELSEIF Impressora=="URANO"
   ReadRegister("01",@cRet)
   cRetorno:= Space( 4 ) + Alltrim( cRet )
   ReadRegister("03",@cRet)
   cRetorno:= cRetorno   + Alltrim( cRet )
   ReadRegister("02",@cRet)
   cRetorno:= cRetorno   + Alltrim( cRet )
ENDIF
Return cRetorno

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CUPOM NAO FISCAL
³ Finalidade  ³
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ImpCarne( cCrediario, cCliente, cCGCcpf, nValor )
Local nCt
Local cComando
Local lErro:= .F.
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 211 )
        Com_Send( impPorta(), cComando )
        cComando:= Chr( 13 ) + Chr( 10 ) + ;
                   Chr( 13 ) + Chr( 10 ) + ;
                   Chr( 13 ) + Chr( 10 ) + ;
                   Chr( 27 ) + "E" + "==================  C A R N E  =================" + Chr( 27 ) + "F" + Chr( 13 ) + Chr( 10 ) + ;
                             "                                                " + Chr( 13 ) + Chr( 10 ) + ;
                             " Cliente: " + ALLTRIM( cCliente ) + Chr( 13 ) + Chr( 10 ) + ;
                             "          " + cCgcCpf  + Chr( 13 ) + Chr( 10 ) + ;
                             "                                                " + Chr( 13 ) + Chr( 10 ) + ;
                             cCrediario + Chr( 13 )  + Chr( 10 ) + ;
                             "                                                " + Chr( 13 ) + Chr( 10 ) + ;
                             "                                                " + Chr( 13 ) + Chr( 10 ) + ;
                             IF( !EMPTY( cObserv1 ), cObserv1 + Chr( 13 ) + Chr( 10 ), "" ) + ;
                             IF( !EMPTY( cObserv2 ), cObserv2 + Chr( 13 ) + Chr( 10 ), "" ) + ;
                             IF( !EMPTY( cObserv3 ), cObserv3 + Chr( 13 ) + Chr( 10 ), "" ) + ;
                             "                                                " + Chr( 13 ) + Chr( 10 ) + ;
                             "                                                " + Chr( 13 ) + Chr( 10 ) + Chr( 255 )

        Com_Send( impPorta(), cComando )
        cComando:= Chr( 27 ) + Chr( 212 )
        Com_Send( impPorta(), cComando )
        lErro:= .F.


   CASE Impressora=="SIGTRON-FS345"


        lErro:= .T.
        nTentativa:= 0

        // Tenta abrir o cupom adicional quatro vezes,
        // verificando se deu erro
        WHILE lErro .AND. ( ++nTentativa < 4 )

           // Atualiza Informacao do Cupom Atual
           ImpCupomAtual( "ATUALIZAR" )

           // ForPagAPrazo
           cComando:= Chr( 27 ) + Chr( 219 ) + "A"          + ForPagAPrazo + ImpCupomAtual( "RETORNAR" ) + StrZero( nValor * 100, 12, 0 )
           Com_Send( impPorta(), cComando )
           Inkey( 0.01 )

           cRetorno:= Alltrim( Com_Read( impPorta(), 22 ) )
           if AT( ":E", cRetorno ) > 0
              lErro:= .T.
           else
              IF AT( ":V", cRetorno ) > 0
                 lErro:= .F.
              ELSE
                 lErro:= .T.
              ENDIF
           endif
        ENDDO

        if !lErro

           /* Mensagens a serem impressas no corpo do cupom
              NAOFISCAL vinculado */
           FOR nCt:= 1 TO 2
               cComando:= Chr( 27 ) + Chr( 213 ) + "" + Chr( 255 )
               Com_Send( impPorta(), cComando )
           NEXT

           Inkey(0.01)
           cComando:= Chr( 27 ) + Chr( 213 ) + ALLTRIM( cCliente ) + Chr( 255 )
           Com_Send( impPorta(), cComando )

           cComando:= Chr( 27 ) + Chr( 213 ) + cCgcCpf + Chr( 255 )
           Com_Send( impPorta(), cComando )

           IF !EMPTY( cObserv1 )
              cComando:= Chr( 27 ) + Chr( 213 ) + IF( !EMPTY( cObserv1 ), cObserv1, " " ) + Chr( 255 )
              Com_Send( impPorta(), cComando )
           ENDIF
           IF !EMPTY( cObserv2 )
              cComando:= Chr( 27 ) + Chr( 213 ) + IF( !EMPTY( cObserv2 ), cObserv2, " " ) + Chr( 255 )
              Com_Send( impPorta(), cComando )
           ENDIF
           IF !EMPTY( cObserv3 )
              Inkey(0.01)
              cComando:= Chr( 27 ) + Chr( 213 ) + IF( !EMPTY( cObserv3 ), cObserv3, " " ) + Chr( 255 )
              Com_Send( impPorta(), cComando )
           ENDIF

           cComando:= Chr( 27 ) + Chr( 213 ) + " " + Chr( 255 )
           Com_Send( impPorta(), cComando )

           Inkey(0.01)
           aCrediario:= {}
           cMsg:= ""
           FOR nCt:= 1 TO Len( cCrediario )
               IF SubStr( cCrediario, nCt, 1 )==Chr( 255 ) .OR.;
                  SubStr( cCrediario, nCt, 1 )==Chr( 10 )
                  cMsg:= cMsg + ""
               ELSEIF SubStr( cCrediario, nCt, 1 )==Chr( 13 )
                  AAdd( aCrediario, cMsg )
                  cMsg:= " "
               ELSE
                  cMsg:= cMsg + SubStr( cCrediario, nCt, 1 )
               ENDIF
           NEXT
           AAdd( aCrediario, cMsg )
           FOR nCt:= 1 TO Len( aCrediario )
               Inkey(0.01)
               cComando:= Chr( 27 ) + Chr( 213 ) + PAD( StrTran( aCrediario[ nCt ], "..", "." ), 42 ) + Chr( 255 )
               Com_Send( impPorta(), cComando )
           NEXT

           // Imprime a conficao de d¡vida
           FOR nCt:= 1 TO Len( aConficaoDivida )
               Inkey(0.01)
               cComando:= Chr( 27 ) + Chr( 213 ) + PAD( aConficaoDivida[ nCt ], 42 ) + Chr( 255 )
               Com_Send( impPorta(), cComando )
           NEXT

           cComando:= Chr( 27 ) + Chr( 213 ) + "------------------------------------------------" + Chr( 255 )
           Com_Send( impPorta(), cComando )

           cComando:= Chr( 27 ) + Chr( 212 )
           Com_Send( impPorta(), cComando )

        endif

   CASE Impressora=="URANO"


ENDCASE
Return ( !lErro )


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ impCupomAtual
³ Finalidade  ³ Pegar o numero do Cupom Atual
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ImpCupomAtual( cCupom )
Local cComando
Static cRetorno

/* TRATAMENTO P/ IMPRESSORAS QUE RETORNAM O NUMERO DO CUPOM NA ABERTURA */
IF Impressora=="SIGTRON-FS345"
   IF cCupom=="RETORNAR" .OR. cCupom==Nil    /* Retornar o numero armazenado */
      IF cRetorno==Nil
         cRetorno:= "000000"
      ENDIF
      Return cRetorno
   ELSEIF cCupom=="PEGAR"                    /* Buscar o numero do cupom */
      cRetorno:= Com_Read( ImpPorta(), 70 )
      IF AT( ":A", cRetorno ) <= 0
         cRetorno:= Com_Read( ImpPorta(), 70 )
      ENDIF
      cRetorno:= SubStr( cRetorno, AT( ":A", cRetorno ) + 2, 6 )
   ELSEIF cCupom=="ATUALIZAR"               /* Buscar o numero do cupom NA MARRA */
      cComando:= Chr( 27 ) + Chr( 239 )
      Com_Send( impPorta(), cComando )
      cRetorno:= Com_Read( impPorta(), 60 )
      IF len( cRetorno ) < 60
         cRetorno:= "000000"
      ELSE
         IF SubStr( cRetorno, 8, 1 ) == "1"
            cRetorno:= SubStr( cRetorno, 9, 6 )
         ELSE
            cRetorno:= StrZero( Val( SubStr( cRetorno, 9, 6 ) ) -1, 6, 0 )
         ENDIF
      ENDIF
   ELSEIF cCupom=="LIMPAR"                   /* Limpar o ultimo numero de cupom */
      cRetorno:= "000000"
   ELSE
      cRetorno:= cCupom                      /* Retorno Cupom */
   ENDIF
ELSE
   cRetorno:= "000000"
ENDIF

DO CASE
   CASE Impressora=="SCHALTER-II"
        IF ( aArray:= StatusCup() )[1] == 0
            Return StrZero( aArray[ 4 ], 6, 0 )
        ELSE
            Return "000000"
        ENDIF

   CASE Impressora=="SCHALTER"
        IF ( aArray:= StatusCup() )[1] == 0
            Return StrZero( aArray[ 4 ], 6, 0 )
        ELSE
            Return "000000"
        ENDIF

   CASE Impressora=="SIGTRON"

        IF Driver=="W2000"
           cComando:= Chr( 27 ) + Chr( 237 )
           Com_Send( ImpPorta(), cComando )
           cRetorno:= Com_Read( ImpPorta(), 70 )
           nSegundos:= SECONDS()
           EndSegundos:= nSegundos
           WHILE AT( ":n", cRetorno ) <= 0 .AND. nSegundos + ( 5.0 ) < EndSegundos
              EndSegundos:= SECONDS()
              Inkey(0.03)
              cRetorno:= Com_Read( ImpPorta(), 70 )
           ENDDO
           cRetorno:= SubStr( cRetorno, AT( ":n", cRetorno ) + 2, 6 )
        ELSE
           cComando:= Chr( 27 ) + Chr( 237 )
           Com_Send( ImpPorta(), cComando )
           cRetorno:= Com_Read( ImpPorta(), 70 )
           IF AT( ":n", cRetorno ) <= 0
              Inkey(.3)
              Com_Send( ImpPorta(), cComando )
              cRetorno:= Com_Read( ImpPorta(), 70 )
           ENDIF
           cRetorno:= SubStr( cRetorno, AT( ":n", cRetorno ) + 2, 6 )
        ENDIF

   CASE Impressora=="SIGTRON-FS345"
        Return cRetorno

   CASE Impressora $ "Nenhuma-Treinamento" .OR. Impressora=="EPSON"
        nArea:= Select()
        DBSelectAr( 133 )
        Use &DiretorioDeDados\CUPOM___.DBF Alias XXC Shared
        Set Index To &DiretoriodeDados\CUPIND01.NTX

        /* Busca primeiro registro do proximo operador
           e decrementa 1 para buscar o ultimo registro deste operador */
        IF !DBSeek( ( ( CodigoCaixa + 1 ) * 1000000 ) + 1 )
           DBSeek( ( ( CodigoCaixa + 1 ) * 1000000 ) + 1, .T. )
        ENDIF
        DBSkip( -1 )

        nNumero:= NUMERO
        DBCloseArea()
        cRetorno:= Right( StrZero( nNumero + 1, 9, 0 ), 6 )
        DBSelectAr( nArea )

   CASE Impressora=="BEMATECH-MP20FI-II"
        cComando:= Chr( 27 ) + Chr( 251 ) + "30|" + Chr( 27 )
        cRetorno:= ""
        private ack := space(1)
        private st1 := space(1)
        private st2 := space(1)
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        FWrite(ImpFiscal, @cComando, LEN (cComando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
        endif
        fread( ImpFiscal, @ack, 1 )
        if ferror() # 0 .and. !lFim
           lFim:= .T.
         endif
         IF !lFim
            FRead( ImpFiscal, @st1, 1 )
            IF ferror() # 0 .AND. !lFim
               lFim:= .T.
            ENDIF
         ENDIF
         IF !lFim
            fread(ImpFiscal,@st2,1)
            if ferror() # 0 .AND. !lFim
               lFim:= .T.
            endif
        ENDIF
        IF !Erro(ack,st1,st2) .AND. !lFim
           cRetorno:= SPACE (6)
           FRead( ImpFiscal, @cRetorno, 6 )
        ENDIF
        FClose( ImpFiscal )
        Release st1
        Release st2
        Release ImpFiscal
        Release cComando
        Release lFim
        Return cRetorno

   CASE Impressora=="BEMATECH"
        cComando:= Chr( 27 ) + Chr( 251 ) + "30|" + Chr( 27 )
        cRetorno:= ""
        private ack := space(1)
        private st1 := space(1)
        private st2 := space(1)
        ImpFiscal:= fopen( PortaImpressao, FO_READWRITE + FO_COMPAT )
        FWrite(ImpFiscal, @cComando, LEN (cComando))
        lFim:= .F.
        if ferror() # 0
           lFim:= .T.
        endif
        fread( ImpFiscal, @ack, 1 )
        if ferror() # 0 .and. !lFim
           lFim:= .T.
         endif
         IF !lFim
            FRead( ImpFiscal, @st1, 1 )
            IF ferror() # 0 .AND. !lFim
               lFim:= .T.
            ENDIF
         ENDIF
         IF !lFim
            fread(ImpFiscal,@st2,1)
            if ferror() # 0 .AND. !lFim
               lFim:= .T.
            endif
        ENDIF
        IF !Erro(ack,st1,st2) .AND. !lFim
           cRetorno:= SPACE (6)
           FRead( ImpFiscal, @cRetorno, 6 )
        ENDIF
        FClose( ImpFiscal )
        Release st1
        Release st2
        Release ImpFiscal
        Release cComando
        Release lFim
        Return cRetorno


   CASE Impressora=="URANO"
        cRetorno:= Space( 10 )
        ReadRegister( "40", @cRetorno )
        cRetorno:= Alltrim( cRetorno )

ENDCASE
Return cRetorno


FUNCTION NtoSBit( number )
local var:= number, String:=""

   if(var= 1, String:= "1",)

   do while var > 1
      if int(var%2) <> 0
         String:= "1" + String
      else
         String:= "0" + String
      endif
      if int(var/2) = 1
         String:= "1" + String
      endif

      var:=int(var/2)
   enddo
return String


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Autentica
³ Finalidade  ³ Autenticacao de documentos
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Autentica( nValor, nJuros, cInformacoes )
Local cComando
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + "Y*[" + Tran( nValor, "@E *,***,***.**" ) + Tran( nJuros, "@E *,***,***.**" ) + "<S&W>]" + Chr(10)
        IF nValor==0
           cComando:=Chr( 27 ) + "Y*[Cfe.FormaPgto<S&W>]" + Chr(10)
        ENDIF
        Com_Send( Nil, cComando )

   CASE Impressora=="SCHALTER-II"
      IF ImpCab( 146 )==0
         IF InCupNFisc( 1 )==0
            IF VendaItem( "RECEBIDO NESTA DATA", STRZERO( ( nValor+nJuros )*100, 9, 0 ), 0 )==0
               Tone(100,2)
               Tone(220,3)
               Tone(700,1)
               Tone(500,2)
               Inkey(0)
               IF Autenti( "[" + Tran( nValor, "@E *,***,***.**" ) + Tran( nJuros, "@E *,***,***.**" ) + "<S&W>]" )==0
                  IF ( nRet:= Pagamnt( 0,;
                       StrZero( nValor * 100, 10, 0 ),;
                       0,;
                       1,;
                       "00" ) )==0
                       FimTrans( "fortuna" )
                  ENDIF
                  Return .T.
               ELSE
                  CancVenda( "fortuna" )
                  Return .F.
              ENDIF
            ELSE
               CancVenda( "fortuna" )
               CancDoc( "fortuna" )
               Return .F.
            ENDIF
         ELSE
            CancVenda( "fortuna" )
            CancDoc( "fortuna" )
            Return .F.
         ENDIF
         FimTrans( "fortuna" )
      ENDIF


   CASE Impressora=="SCHALTER"
      IF ImpCab( 146 )==0
         IF InCupNFisc( 1 )==0
            IF VendaItem( "RECEBIDO NESTA DATA", STRZERO( ( nValor+nJuros )*100, 9, 0 ), 0 )==0
               Tone(100,2)
               Tone(220,3)
               Tone(700,1)
               Tone(500,2)
               Inkey(0)
               IF Autenti( "[" + Tran( nValor, "@E *,***,***.**" ) + Tran( nJuros, "@E *,***,***.**" ) + "<S&W>]" )==0
                  IF ( nRet:= Pagamnt( 0,;
                       StrZero( nValor * 100, 10, 0 ),;
                       0,;
                       1,;
                       "00" ) )==0
                       FimTrans( "fortuna" )
                  ENDIF
                  Return .T.
               ELSE
                  CancVenda( "fortuna" )
                  Return .F.
              ENDIF
            ELSE
               CancVenda( "fortuna" )
               CancDoc( "fortuna" )
               Return .F.
            ENDIF
         ELSE
            CancVenda( "fortuna" )
            CancDoc( "fortuna" )
            Return .F.
         ENDIF
         FimTrans( "fortuna" )
      ENDIF

   CASE Impressora=="SIGTRON-FS345"

      /* abre comprovante nÆo fiscal nÆo vinculado */
      cComando:= Chr( 27 ) + Chr( 217 ) + ImpPagPagamento + "3" +;
            IF( nJuros==Nil, "000000000000" + StrZero( nValor * 100, 12, 0 ),;
                             StrZero( nJuros * 100, 12, 00 ) +;
                             StrZero( nValor * 100, 12, 00 ) ) +;
                             Alltrim( MensPagamento ) + Chr( 255 ) + Chr( 13 )
      Com_Send( Nil, cComando )

      /* INFORMACOES ADICIONAIS NA IMPRESSORA */
      IF cInformacoes <> Nil
         cComando:=     Chr( 27 ) + Chr( 213 )  + cInformacoes + Chr( 255 ) + Chr( 13 )
         Com_Send( Nil, cComando )
      ENDIF

      /* aciona a autenticacao mecanica na impressora */
      cComando:=     Chr( 27 ) + "Y*[AUT]*" + Chr( 13 ) + Chr( 10 )
      IF !( nJuros==Nil )
          cComando:= Chr( 27 ) + "Y*[AUT]*" + Chr( 13 ) + Chr( 10 )
      ENDIF
      Com_Send( Nil, cComando )

      /* Imprime pagamento */
      cComando:= Chr( 27 ) + Chr( 242 ) + ImpPagPagamento + ;
           StrZero( ( nValor + IF( nJuros==Nil, 0, nJuros ) ) * 100, 12, 0 ) + " Pagamento" + Chr( 255 )
      Com_Send( Nil, cComando )


   CASE Impressora=="SWEDA"
        cComando:= Chr( 27 ) + ".26"
        cComando+= "0"
        cComando+= PAD( ALLTRIM( "Autenticaca Mecanica" ), 24 )
        cComando+= "}"
        Set Printer To IFSWEDA
        Set Device To Print
        @ Prow(), PCol() Say cComando
        Set Device To Screen
        Return LEN( VerErro( cComando ) ) <= 1



   CASE Impressora=="URANO"
        Autentic( "*[" + Tran( nValor, "@E *,***,***.**" ) + "<S&W>]" )

   CASE Impressora=="BEMATECH-MP20FI-II"

ENDCASE
Return Nil


/* BEMATECH */
********************************************************************************
*    Rotina....: erro()
*    Descricao.: Analiza os codigos de retorno do Device Driver apos a execucao de
*                um comando para verificar a ocorrencia de erro.
*                Da display de mensagens ao usuario do erro para tomada de
*                providencias.
*    Parametros: ACK, ST1, ST2
*    Retornado.: .t. caso seja encontrado algum erro que impressa a execucao do
*                comando
*                .f. caso nao seja encontrado nenhum erro que seja fatal
********************************************************************************
function erro(pack, pst1, pst2)
private vst1 := { "0","0","0","0","0","0","0","0" }
private vst2 := { "0","0","0","0","0","0","0","0" }

if pst1=chr(0) .and. pst2=chr(0)
   return .f.
else

*         IF pack==21
*             TELA("NAK - NAO COMUNICA!!",9)
*             RETURN .T.
*         ENDIF

ASC1:=ASC(PST1)
ASC2:=ASC(PST2)

binario(ASC1, @vst1)
binario(ASC2, @vst2)
for i := 8 to 1 step -1
//    @ 00, 8-i say vst1[i]
//    @ 00, 8-i+10 say vst2[i]
next

if vst1[1] = "1"
   TELA("1/ST1 - Parametro(s) Invalido(s)!")
   return .t.
endif

if vst1[2] = "1"
   TELA("2/ST1 - Cupom Aberto!")
   return .F.
endif

if vst1[3] = "1"
   TELA("3/ST1 - Comando Inexistente!")
   return .t.
endif

if vst1[4] = "1"
   TELA("4/ST1 - Comando nao foi ESC!")
   return .t.
endif

if vst1[5] = "1"
   TELA("5/ST1 - Impressora Loca!")
   return .t.
endif

if vst1[6] = "1"
   TELA("6/ST1 - Carregar Driver!")
   return .t.
endif

if vst1[7] = "1"
    TELA("7/ST1 - Pouco Papel")
endif

if vst1[8] = "1"
   TELA("8/ST1 - Fim de Papel")

   return .t.
endif

if vst2[1] = "1"
   tela("1/ST2 - Comando Nao Executado!")
   return .t.
endif

if vst2[2] = "1"
   tela("2/ST2 - CGC/IE nao Programados!")
   return .t.
endif

if vst2[3] = "1"
   q=q+1
   tela("3/ST2 - Cancelamento Nao Permitido!",@q)
   return .t.
endif

if vst2[4] = "1"
   tela("4/ST2 - Numero Maximo de Aliquotas")
   return .t.
endif

if vst2[5] = "1"
   tela("5/ST2 - Aliquota NAO Programada!")
   return .t.
endif

if vst2[6] = "1"
   tela("6/ST2 - Erro na CMOS! Te livrou!")
   return .t.
endif

if vst2[7] = "1"
   tela("7/ST2 - Memoria Fiscal LOTADA!")
   return .t.
endif

if vst2[8] = "1"
   tela("8/ST2 - Parametro Invalido!")
   return .t.
endif
endif
return .f.

********************************************************************************
*    Rotina....: binario(pbyte, pbits)
*    Descricao.: Transforma um byte em um vetor de 0 e 1.
*    Parametros: pbyte - Byte a ser convertido
*                pbits - Array de retorno dos valores
*    Retornado.: Vetor de 0 e 1.
********************************************************************************
procedure binario(pbyte,pbits)
local d := { 1 , 2 , 4 , 8 , 16 , 32 , 64 , 128 }
for i:=8 to 1 step -1
    pbits[i] := if(pbyte-d[i] >= 0,"1","0")
    pbyte := if(pbyte-d[i] >= 0, pbyte-d[i], pbyte)
next



*******************************************************************************
*  Rotina:     TELA(men,qq)
*  Descricao:  imprime mensagem passada como parametro (texto)
******************************************************************************
procedure tela(men)
return .t.



/* URANO */
Function impErro( nCodigo )
*--- Define os codigos de erros retornados pela ZPMFisc ---*
local ZPM_ERRO[115], cRetorno
IF nCodigo==Nil
   Return ""
ENDIF
DO CASE
   CASE Impressora=="URANO"
        IF nCodigo <= 0
           cRetorno:= "Normal"
           Return cRetorno
        ENDIF
        ZPM_ERRO[001] = "Comando Invalido para o Device. Erro Interno!"
        ZPM_ERRO[002] = "Impressora esta fora de linha, desligada ou desconectada"
        ZPM_ERRO[003] = "Device Driver ocupado. Erro Interno!"
        ZPM_ERRO[004] = "Comando nao implementado. Erro Interno!"
        ZPM_ERRO[005] = "Erro de Sintaxe em comando. Erro Interno!"
        ZPM_ERRO[006] = "Fim do Tempo p/exec.comando."
        ZPM_ERRO[007] = "Parametro invalido passado p/ LIB"
        ZPM_ERRO[008] = "LIB ja esta ativa"
        ZPM_ERRO[009] = "LIB nao esta ativa"
        ZPM_ERRO[010] = "Device Driver nao instalado"
        ZPM_ERRO[011] = "Banco nao esta cadastrado no arquivo de configuracao"
        ZPM_ERRO[012] = "Coordenadas de Valor nao informadas ou invalida"
        ZPM_ERRO[013] = "Coordenadas de Extenso nao informadas ou invalida"
        ZPM_ERRO[014] = "Coordenadas de Favorecido nao informadas ou invalida"
        ZPM_ERRO[015] = "Coordenadas de Cidade nao informadas ou invalida"
        ZPM_ERRO[016] = "Coordenadas da Data nao informadas ou invalida"
        ZPM_ERRO[017] = "Erro de sintaxe em descricao das coordenadas no arquivo"
        ZPM_ERRO[018] = "Nao conseguiu acessar arquivo de configuracao"
        ZPM_ERRO[032] = "Cancelamento invalido"
        ZPM_ERRO[033] = "Abertura do dia invalida"
        ZPM_ERRO[034] = "Aliquota nao carregada"
        ZPM_ERRO[035] = "Erro na gravacao da memoria fiscal"
        ZPM_ERRO[036] = "Numero Maximo de Troca de Estabelecimento alcancado"
        ZPM_ERRO[037] = "Erro no Byte Verificador da Memoria Fiscal"
        ZPM_ERRO[038] = "Impressora em intervencao tecnica"
        ZPM_ERRO[039] = "Memoria Fiscal desconectada"
        ZPM_ERRO[040] = "Indice da Aliquota invalido"
        ZPM_ERRO[041] = "Nao houve desconto anterior"
        ZPM_ERRO[042] = "Desconto invalido"
        ZPM_ERRO[043] = "Nao houve acrescimo no subtotal"
        ZPM_ERRO[044] = "Data inicial nao localizada"
        ZPM_ERRO[045] = "Perda da memoria RAM"
        ZPM_ERRO[046] = "Comando aceito apenas em intervencao tecnica"
        ZPM_ERRO[047] = "Valor invalido p/ preenchimento do cheque"  && 2EFE/1EFNF apenas
        ZPM_ERRO[048] = "Memoria Fiscal ja inicializada"
        ZPM_ERRO[049] = "Fechamento nao realizado"
        ZPM_ERRO[050] = "Fechamento ja realizado"
        ZPM_ERRO[051] = "Comando fora de sequencia"
        ZPM_ERRO[052] = "Nao comecou a venda"
        ZPM_ERRO[053] = "Nao houve pagamento"
        ZPM_ERRO[054] = "Configuracao permitida apenas apos fechamento"  && NF apenas
        ZPM_ERRO[055] = "Cupom ja totalizado"
        ZPM_ERRO[056] = "Comando inexistente"
        ZPM_ERRO[057] = "Impressora retornou timeout RX"
        ZPM_ERRO[058] = "Uso de palavra reservada"
        ZPM_ERRO[059] = "Nao houve desconto no subtotal"
        ZPM_ERRO[060] = "Caracter invalido"
        ZPM_ERRO[061] = "Valor de desconto invalido"
        ZPM_ERRO[062] = "Operacao nao permitida em documento nao fiscal"
        ZPM_ERRO[063] = "Cancelamento de cupom invalido"
        ZPM_ERRO[064] = "Propaganda permitida apenas apos pagamento completo"
        ZPM_ERRO[065] = "Falta inicializar cupom nao fiscal"
        ZPM_ERRO[066] = "Aliquota indisponivel"
        ZPM_ERRO[067] = "Troca de proprietario apenas apos fechamento"
        ZPM_ERRO[068] = "Reducao inicial nao localizada"
        ZPM_ERRO[069] = "Memoria fiscal cheia"
        ZPM_ERRO[070] = "Troca de situacao tributaria apenas apos fechamento"
        ZPM_ERRO[071] = "Codigo de mercadoria invalida"
        ZPM_ERRO[072] = "Limite de valor do item ultrapassado"
        ZPM_ERRO[073] = "Cabecalho ja impresso"
        ZPM_ERRO[074] = "Acerto de horario de verao somente apos fechamento"
        ZPM_ERRO[075] = "Acerto de horario de verao permitido somente 1 vez ao dia"
        ZPM_ERRO[076] = "Relogio inconsistente"
        ZPM_ERRO[077] = "Comando valido apenas para Nota Fiscal" && 1EFNF
        ZPM_ERRO[078] = "Impressao de NFVC somente em venda"  && 1EFNF
        ZPM_ERRO[079] = "Campo ja impresso"      && 1EFNF
        ZPM_ERRO[080] = "Coordenada invalida"     && 1EFNF
        ZPM_ERRO[081] = "Registrador invalido"
        ZPM_ERRO[082] = "Nro. maximo de troca de simbolo da moeda alcancado"
        ZPM_ERRO[083] = "1EF - Falta papel para autenticacao"  && 1EF apenas
        ZPM_ERRO[084] = "Comando valido apenas para cupom fiscal" && 1EFNF apenas
        ZPM_ERRO[085] = "Nao ha item a descontar"
        ZPM_ERRO[086] = "Transacao inexistente"
        ZPM_ERRO[087] = "Transacao ja cancelada"
        ZPM_ERRO[088] = "Memoria fiscal nao apagada"
        ZPM_ERRO[089] = "Faltou papel"
        ZPM_ERRO[090] = "Acrescimo no subtotal invalido"
        ZPM_ERRO[091] = "Desconto no subtotal invalido"
        ZPM_ERRO[092] = "Valor do relogio invalido"
        ZPM_ERRO[093] = "Montante da operacao igual a 0 (zero)"
        ZPM_ERRO[094] = "2EFE - Papel perto do fim"     && 2EF apenas
        ZPM_ERRO[095] = "Nome da moeda nao carregado"
        ZPM_ERRO[096] = "NF - Necessita natureza da operacao"
        ZPM_ERRO[097] = "NF - Necessita configurar formulario"
        ZPM_ERRO[098] = "Intervencao Tecnica"
        ZPM_ERRO[099] = "Em periodo de venda"
        ZPM_ERRO[100] = "Em venda de item"
        ZPM_ERRO[101] = "Em pagamento"
        ZPM_ERRO[102] = "Em comercial"
        ZPM_ERRO[103] = "Esperando fech. do cupom de leitura X ou reducao Z"
        ZPM_ERRO[104] = "Em cupom nao fiscal"
        ZPM_ERRO[105] = "Dia fechado"
        ZPM_ERRO[106] = "Impressora nao pronta"
        ZPM_ERRO[107] = "Palavra Chave nao encontrada"
        ZPM_ERRO[108] = "108 - Reservado"
        ZPM_ERRO[109] = "109 - Reservado"
        ZPM_ERRO[110] = "110 - Reservado"
        ZPM_ERRO[111] = "111 - Reservado"
        ZPM_ERRO[112] = "Campo [data] no cheque invalido"
        ZPM_ERRO[114] = "Erro desconhecido "
        ZPM_ERRO[115] = "Impressora retornou caracter desconhecido "
        cRetorno:= ZPM_ERRO[ nCodigo ]
        IF cRetorno==Nil
           cRetorno:= "Erro Nao Identificado!"
        ENDIF
ENDCASE
Return cRetorno

Function CasasDecimais( nNumero )
Local nCasas:= 0

   IF !VAL( STR( ROUND( nNumero, 5 ) ) ) == nNumero
        nCasas:= 6
   ELSEIF !VAL( STR( ROUND( nNumero, 4 ) ) ) == nNumero
        nCasas:= 5
   ELSEIF !VAL( STR( ROUND( nNumero, 3 ) ) ) == nNumero
        nCasas:= 4
   ELSEIF !VAL( STR( ROUND( nNumero, 2 ) ) ) == nNumero
        nCasas:= 3
   ELSEIF !VAL( STR( ROUND( nNumero, 1 ) ) ) == nNumero
        nCasas:= 2
   ELSEIF !VAL( STR( ROUND( nNumero, 0 ) ) ) == nNumero
        nCasas:= 1
   ENDIF

Return nCasas

/*
Varifica se houve erro de comunicacao com a impressora
*/
Function VerErro( cComando )
Local Hand, Resp, slip, bob, aut
Local Resto, nVez, nIni, nFim, nLine, cRetorno:=""
  SetCursor( 0 )
  Set Printer To LPT1
  Set Device To Screen
  DO CASE
     CASE Impressora=="SWEDA"
          IF (Len(cComando) > 78)
             resto:= mod( Len(cComando), 78 )
             nVez:= ( Len( cComando) - resto ) / 78
             nline:= 17
             nIni:= 1
             nFim:= 78
             for i:= 0 to nVez
                nline:= nline + 1
                nIni:= nFim + 1
                nFim:= nFim+ 75
             next
          ENDIF
          resp:= Space(128)
          hand:= fopen("IFSWEDA.PRN", 2)
          resp:= freadstr( hand, 128)
          fclose( hand )
          SetCursor(1)
          if (SubStr(resp, 2, 1) = "-")
             if (Len(resp) == 7)
                if (SubStr(resp, 6, 1) = "2")
                   cRetorno:= "Time-Out de Transmiss„o. Verifique a conex„o PC/Impressor ou FIM DE PAPEL !"
                elseif (SubStr(resp, 6, 1) = "6")
                   cRetorno:= "Time-Out de Recep‡„o. Verifique a conex„o PC/Impressor ou FIM DE PAPEL !"
                endif
             endif
          elseif (SubStr(resp, 2, 1) = "+")
          endif
          set color to g+/b
          aut:= SubStr(resp, 4, 1)
          slip:= SubStr(resp, 5, 1)
          bob:= SubStr(resp, 6, 1)
          if (SubStr(resp, 3, 1) = "P")
             if (Len(Trim(resp)) > 10)
                do case
                case aut = "0"
                   cRetorno:= "AUT : H  documento para autenticar"
                case aut = "1"
                   cRetorno:= "AUT : Impressora  off-line        "
                case aut = "2"
                   cRetorno:=  "AUT : Time-out de Transmissao     "
                case aut = "5"
                   cRetorno:=  "AUT :Sem documento para autenticar"
                case aut = "6"
                   cRetorno:= "AUT : Time-out de recepcao        "
                endcase
                do case
                case slip = "0"
                   cRetorno:= "SLIP: H  folha presente      "
                case slip = "1"
                   cRetorno:= "SLIP: Impressora  off-line    "
                case slip = "2"
                   cRetorno:= "SLIP: Time-out de Transmissao "
                case slip = "5"
                   cRetorno:= "SLIP: Sem folha solta presente"
                case slip = "6"
                   cRetorno:= "SLIP: Time-out de recepcao    "
                endcase
                do case
                case bob = "0"
                   cRetorno:= "BOBINA: Impressora tem papel"
                case bob = "1"
                   cRetorno:= "BOBINA:Impressora off-line"
                case bob = "2"
                   cRetorno:= "BOBINA:Time-out de Transmissao"
                case bob = "3"
                   cRetorno:= "BOBINA:Sem papel, lado Jornal"
                case bob = "4"
                   cRetorno:= "BOBINA:Sem papel, lado cupom"
                case bob = "5"
                   cRetorno:= "BOBINA:Sem papel, cupom e jornal"
                case bob = "6"
                   cRetorno:= "BOBINA:Time-out de recepcao"
                endcase
             endif
          elseif (SubStr(resp, 3, 1) = "G")
             if (SubStr(resp, 6, 1) = "0")
                cRetorno:= "Gaveta Aberta"
             elseif (SubStr(resp, 6, 1) = "1")
                cRetorno:= "Gaveta Fechada"
             endif
          endif
          resp:= ""
  ENDCASE
  Return cRetorno



static function comunicaBematech( buffer_a_ser_enviado, tam_a_ser_ret )

  numero_abertura_porta := fopen( PortaImpressao, FO_READWRITE + FO_COMPAT)

  if ferror () != 0
     qout("Problemas de comunicacao. Pressione qualquer tecla.")
     return
  endif

 /* evia sequencia de bytes para impressora */

 fwrite( numero_abertura_porta, @buffer_a_ser_enviado, len(buffer_a_ser_enviado))

 /* pega o retorno da impressora NAK/ACK ST1 ST2 */

 retorno_impressora := ack := nak := st1 := st2 := space(1)

 for contador1 := 1 to 3

     fread(numero_abertura_porta,@retorno_impressora,1)

     do case
        case contador1 = 1
             do case
                case asc(retorno_impressora) = 21 /* retorno em caracter 21d=15h=NAK */
                     clear
                     ?
                     ? "Atencao... a impressora retornou 21d=15h=NAK"
                     ?
                     ? "NAK"
                     ?
                     ? "Programa abortado!"
                     ?
//                    fclose(numero_abertura_porta)
//                     quit
//                     executou_sn := .f.
                case asc(retorno_impressora) = 06
                     ack := transform(asc(retorno_impressora),"99")
                otherwise
                     clear
                     ?
                     ? "Atencao... provavelmente o driver nao foi carregado !"
                     ? "Programa abortado!"
                     ?
                     fclose(numero_abertura_porta)
                     quit
//                     executou_sn := .f.
             endcase
        case contador1 = 2
             st1 := transform(asc(retorno_impressora),"999")
        case contador1 = 3
             st2 := transform(asc(retorno_impressora),"999")
     endcase

 next contador1

 /* pega sequencia de retorno caso necess rio */

 sequencia_retorno := ""
 for contador2 := 1 to tam_a_ser_ret
    fread(numero_abertura_porta, @retorno_impressora, 1)
    sequencia_retorno += retorno_impressora
 next contador2

 if asc(retorno_impressora) # 21

    clear
    ?
    ? "ACK = [" + ack + "]   ST1 = [" + st1 + "]   ST2 = ["+ st2 + "]"
    ? "Retorno = [" + sequencia_retorno + "]"
    ?
    ?
    wait "Tecle algo para retornar"

 endif

 fclose( numero_abertura_Porta )

return sequencia_retorno /* executou_sn */

// verifica se a impressora
// possui um cupom fiscal aberto e retorna .T. se existir

Function ImpCupomAberto
if Impressora== "SIGTRON-FS345"
   cComando:= Chr( 27 ) + Chr( 239 )
   Com_Send( impPorta(), cComando )
   cRetorno:= Com_Read( impPorta(), 20 )
//   @ 24,00 Say cRetorno
//   Inkey(0)
   IF len( cRetorno ) < 20
      Return .F.
   ELSE            
      IF SubStr( cRetorno, 8, 1 ) == "1"
         Return .T.
      ENDIF
   ENDIF
   
endif
Return .F.


Function ImpSubTotal
   cComando:= Chr( 27 ) + Chr( 239 )
   Com_Send( impPorta(), cComando )
   cRetorno:= Com_Read( impPorta(), 60 )
//   @ 24,00 Say cRetorno
//   Inkey(0)
   IF len( cRetorno ) < 60
      Return 0
   ELSE            
      IF SubStr( cRetorno, 8, 1 ) == "1"
         Return ( Val( SubStr( cRetorno, 29, 14 ) ) / 100 )
      ENDIF
   ENDIF
   Return 0


