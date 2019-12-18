#Include "FILEIO.CH"
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
Function impVendeProduto( cCODFAB, cDESCRI, cIcm, nQuantidade, nPreco, nDescPercentual, nDescValor, nct, cUnidade, nDepartamento )
Local cComando
Local cDesconto
Local nCasasVlr:= 0, nCasasQtd:= 0

cPreco:= PAD( StrTran( Alltrim( Str( nPreco, 8, 2 ) ), ".", "" ), 9 )
nDepartamento:= IF( nDepartamento==Nil, 0, nDepartamento )

DO CASE
   CASE Impressora=="Nenhuma"
       Return .T.
   CASE Impressora=="SIGTRON"
       /* formatacao das informacoes */
       cDescri:= Left( cDescri, 30 )
       cPreco:= StrTran( StrZero( nPreco, 10, 02 ), ".", "" )
       cQuantidade:= StrTran( StrZero( nQuantidade, 5, 0 ), ".", "" )
       IF nDescPercentual > 0
          cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescValor > 0
          cDesconto:= StrTran( StrZero( nDescValor, 10, 2 ), ".", "" )
       ELSE
          cDesconto:= "0000"
       ENDIF
       /* FORMATACAO DO COMANDO */
       cComando:= Chr( 27 ) + Chr( 215 ) +;
                  cIcm + PAD( cCodFab, 13 ) + "0000" +;
                         cDesconto + cPreco + ;
                         cQuantidade + ;
                         "UN" + PAD( cDescri, 30 )
       Com_Send( impPorta(), cComando )
       cRetorno:= Alltrim( Com_Read( impPorta(), 22 ) )
       IF Left( cRetorno, 2 ) == ":+" .and.;
          VAL( SubStr( cRetorno, 13, 9 ) ) > 0
          Return .T.
       ELSE
          Return .F.
       ENDIF
   CASE Impressora=="BEMATECH"
       IF nDescPercentual > 0
          cDesconto:= StrTran( StrZero( nDescPercentual, 5, 2 ), ".", "" )
       ELSEIF nDescValor  > 0
          cDesconto:= StrTran( StrZero( nDescValor, 9, 2 ), ".", "" )
       ELSE
          cDesconto:= "0000"
       ENDIF
       cIcm:= "01"
       cQuantidade:= StrTran( StrZero( nQuantidade, 8, 3 ), ".", "" )
       cPreco:= StrTran( StrZero( nPreco, 9, 2 ), ".", "" )
       cComando:= Chr( 27 ) + Chr( 251 ) + "09|" + PAD( cCodFab, 13 ) + "|" +;
                  PAD( cDescri, 29 ) + "|" + cIcm + "|" + cQuantidade + "|" +;
                  cPreco + "|0000|" + Chr( 27 )
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
        cTabela:= PAD( ALLTRIM( cTabela ), 2 )

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

   CASE Impressora=="ZANTHUS"

   CASE Impressora=="EPSON"
        cImp:= Set( _SET_PRINTER, PortaImpressao )
        Set( _SET_DEVICE, "PRINTER" )
        @ PROW()+1,00 Say PAD( Alltrim( cCodFab ) + " " + cDescri, 35 ) + " " + cUnidade + " "
        @ PROW()+1,00 Say " "+ StrZero( nCt+1, 3, 0 ) + "       " + Tran( nQuantidade, "@E 99,999.99" ) + ;
                   Tran( nPreco, "@E 999,999.99" ) + Tran( nPreco * nQuantidade, "@E 999,999.99" )
        IF EpsonVende( cCodFab, cDescri, nQuantidade, nPreco )
           @ PROW()+1,00 Say Chr( 27 ) + Chr( 18 ) + "#     Orcamento      " + Chr( 27 ) + Chr( 15 ) + "#"
        ENDIF
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
Local nRet:= 0
Local cComando

DO CASE
   CASE Impressora=="EPSON"
        cImp:= Set( _SET_PRINTER, PortaImpressao )
        Set( _SET_DEVICE, "PRINTER" )
        @ PROW()+1,00 Say "          O  R  C  A  M  E  N  T  O        "
        @ PROW()+1,00 Say " " + Cliche1
        @ PROW()+1,00 Say " " + Cliche2
        @ PROW()+1,00 Say " " + Cliche3
        @ PROW()+1,00 Say " " + Cliche4
        @ PROW()+1,00 Say "-Produto---------------------------UN------"
        @ PROW()+1,00 Say "            --Quant----Pr.Unit-----Total---"
        EpsonAbre()
        Set( _SET_PRINTER, cImp )
        Set( _SET_DEVICE, "SCREEN" )

   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 200 )
        Com_Send( impPorta(), cComando )
   CASE Impressora=="BEMATECH"
        private comando := chr(27) + chr(251) + "00|" + chr(27)
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

   CASE Impressora=="BEMATECH-MP20FI-II"
        private comando := chr(27) + chr(251) + "00|" + chr(27)
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
   CASE Impressora=="URANO"
        nRet:= ReportXZBegin( "1" )
        nRet:= ReportXZEnd( "00001" )
        AdvanceLine( "0", "07" )
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
   CASE Impressora=="URANO"
        nRet:= ReportXZBegin( "0" )
        nRet:= ReportXZEnd( "00001" )
        AdvanceLine( "0", "07" )
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
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + "p000"
        Com_Send( impPorta(), cComando )
   CASE Impressora=="URANO"
        OpenCash()
ENDCASE
Return Nil

/*====================================
Funcao      ImpLeMemoria
Finalidade  Leitura X
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
   CASE Impressora=="URANO"
        nRet:= ReadFiscalMemory( "0", CTOD( "01"+"/"+cMes+"/"+cAno ),;
                                      CTOD( cDia+"/"+cMes+"/"+cAno ), Space( 4 ), Space( 4 ) )
        AdvanceLine( "0", "07" )
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
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + Chr( 205 ) + StrZero( nPosicao, 3, 0 )
        Com_Send( impPorta(), cComando )

   CASE Impressora=="URANO"
        CancelItem( "Item Cancelado...", StrZero( nPosicao, 3, 0 ) )

   CASE Impressora=="EPSON"
        IF EpsonCancela( nPosicao )
           cImp:= Set( _SET_PRINTER, PortaImpressao )
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
   CASE Impressora == "SIGTRON"
        cComando:= Chr( 27 ) + Chr( 206 )
        Com_Send( impPorta(), cComando )
   CASE Impressora == "URANO"
        CancelVoucher( StrZero( CodigoCaixa, 8, 0 ) )
        AdvanceLine( "0", "07" )
   CASE Impressora == "EPSON"

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
ENDCASE
Return nil

/*====================================
Funcao       IMPFECHACP
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
Function impFechaSem(cAcrDes, nPerAcrDes, nVlrAcrDes, nVlrPagar, nValorPago, cMensagem, cCgcCpf )
Local cComando, cDesconto, cPago, nVlrDesconto
DO CASE
   CASE Impressora=="SIGTRON"
        /* Desconto Percentual ou sem Desconto */
        cDesconto:= StrTran( Tran( nPerAcrDes, "@R 99.99" ), ".", "" )
        cDesconto:= StrZero( VAL( cDesconto ), 4, 0 )
        cComando:= Chr( 27 ) + Chr( 201 ) + cDesconto
        IF nVlrAcrDes > 0
           cDesconto:= StrTran( Tran( nVlrAcrDes, "@R 9999999999.99" ), ".", "" )
           cDesconto:= StrZero( VAL( cDesconto ), 12, 0 )
           cComando:= Chr( 27 ) + Chr( 213 ) + cDesconto
       ENDIF
       /* configuracao do CGC/CPF */
       IF cCgcCpf <> Nil
          IF Len( cCgcCpf ) < 14
             cCgcCpf:= Space( 3 ) + Alltrim( cCgcCpf )
          ENDIF
       ELSE
          cCgcCpf:= Space( 14 )
       ENDIF
       cPago:= StrTran( Tran( nValorPago, "@R 9999999999.99" ), ".", "" )
       cMensagem:= cMensagem + Chr(13) + Chr(10) + " SOFT&WARE Informatica - Trabalhando por Voce!"
       /* Conclusao do comando */
       cComando:= cComando + cCGCCPF + cMensagem + Chr( 255 )
       Com_Send( impPorta(), cComando )

   CASE Impressora=="BEMATECH"
       cPago:= StrTran( StrZero( nValorPago, 16, 02 ), ".", "" )
       cComando:= Chr( 27 ) + Chr( 251 ) + "10|0000" + "|" + ;
                  cPago + "|D|" + cMensagem + Chr( 13 ) + Chr( 10 ) + "|" + Chr( 225 ) + Chr( 27 )
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

   CASE Impressora=="EPSON"
        cImp:= Set( _SET_PRINTER, PortaImpressao )
        Set( _SET_DEVICE, "PRINTER" )
        nFim:= 0
        @ Prow()+1,00 Say "---------- FECHAMENTO DO CUPOM -----------"
        @ PRow()+1,00 Say "Total.....:" + Space( 16 ) + Tran( nFim:= EpsonFinaliza(), "@E 999,999,999.99" )
        IF nVlrAcrDes > 0
           @ Prow()+1,00 Say "Desconto..:" + Space( 16 ) + Tran( nVlrAcrDes,             "@E 999,999,999.99" )
           nFim:= nFim  - nVlrAcrDes
        ENDIF
        @ Prow()+1,00 Say "Valor.....:" + Space( 16 ) + Tran( nValorPago,             "@E 999,999,999.99" )
        @ PRow()+1,00 Say "Diferenca.:" + Space( 16 ) + Tran( nValorPago - nFim,      "@E 999,999,999.99" )
        @ PRow()+1,00 Say "-------------------------------========<<<"
        @ PRow()+1,00 Say cMensagem
        @ PRow()+5,00 Say " "
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
        cMensagem:= Left( cMensagem, 60 ) + Chr(13) + Chr(10) + " SOFT&WARE Informatica - TRABALHANDO POR VOCE!"
        Payment( "PAGAMENTO", cValorPago )
        ComercialText( "0", cMensagem )
        EndSale( "A", StrZero( CodigoCaixa, 6, 0 ) )
        AdvanceLine( "0", "07" )

   CASE Impressora=="BEMATECH-MP20FI-II"

       /* inicio do fechamento SEM FORMAS DE PGTO */

       cComando := Chr( 27 ) + Chr( 251 ) + "10|"
       cComando += StrZero (nPerAcrDes * 100,  4, 0) + "|"
       cComando += StrZero (nValorPago * 100, 14, 0) + "|"

       IF (nPerAcrDes == 0 .AND. nVlrAcrDes > 0)
          cComando += LOWER (cAcrDes) + "|"
          cComando += StrZero (nVlrAcrDes * 100, 14, 0) + "|"
       ELSE
          cComando += cAcrDes + "|"
       ENDIF

       cComando += AllTrim(cMensagem) + "|" + Chr(13) + Chr(10) + Chr(27)

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

   Function impFechaCom (cAcrDes, nPerAcrDes, nVlrAcrDes, nValorPago, cForma, ;
                         cMensagem )

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
                cComando += StrZero (nPerAcrDes * 100,  4, 0) + Chr(27)
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

             cComando := Chr(27) + Chr(251) + "33|" + cForma +;
                   "|" + StrZero( nValorPago * 100, 14, 0 ) + "|" + Chr(27)

             FWrite(ImpFiscal, @cComando, LEN (cComando))

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
//SET DEVICE TO SCREEN
             Return lRetorno

      ENDCASE

   Return (.T.)

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
³ Finalidade  ³ Autenticacao de documentos
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ImpCarne( cCrediario, cCliente, cCGCcpf )
Local cComando
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
   CASE Impressora=="URANO"

ENDCASE
Return Nil


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
Function ImpCupomAtual()
Local cComando
cRetorno:= "000000"
IF Impressora=="SIGTRON"
   cComando:= Chr( 27 ) + Chr( 237 )
   Com_Send( ImpPorta(), cComando )
   cRetorno:= Com_Read( ImpPorta(), 70 )
   IF AT( ":n", cRetorno ) <= 0
      Inkey(.3)
      Com_Send( ImpPorta(), cComando )
      cRetorno:= Com_Read( ImpPorta(), 70 )
   ENDIF
   cRetorno:= SubStr( cRetorno, AT( ":n", cRetorno ) + 2, 6 )
ELSEIF Impressora=="Nenhuma" .OR. Impressora=="EPSON"
   nArea:= Select()
   Sele B
   Use &DiretorioDeDados\CUPOM___.VPB Alias XCUP Shared
   Set Index To &DiretoriodeDados\CUPIND01.IGD
   DBGoBottom()
   nNumero:= NUMERO
   DBCloseArea()
   cRetorno:= Right( StrZero( nNumero + 1, 9, 0 ), 6 )
   DBSelectAr( nArea )
ELSEIF Impressora=="BEMATECH-MP20FI-II"
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
ELSEIF Impressora=="URANO"
   cRetorno:= Space( 10 )
   ReadRegister( "40", @cRetorno )
   cRetorno:= Alltrim( cRetorno )
ENDIF
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
Function Autentica( nValor, nJuros )
Local cComando
DO CASE
   CASE Impressora=="SIGTRON"
        cComando:= Chr( 27 ) + "Y*[" + Tran( nValor, "@E *,***,***.**" ) + Tran( nJuros, "@E *,***,***.**" ) + "<S&W>]" + Chr(10)
        IF nValor==0
           cComando:=Chr( 27 ) + "Y*[Cfe.FormaPgto<S&W>]" + Chr(10)
        ENDIF
        Com_Send( Nil, cComando )

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
   INKEY(0)
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
   INKEY(0)
   return .t.
endif

if vst1[7] = "1"
    TELA("7/ST1 - Pouco Papel")
    INKEY(0)
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
   INKEY(0)
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
//SETCOLOR("15/01")
//@ 25,1 to 27,38
//@ 26,3 SAY men



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
        ZPM_ERRO[1]  = "Comando Invalido para o Device. Erro Interno!"
        ZPM_ERRO[2]  = "Impressora esta fora de linha, desligada ou desconectada"
        ZPM_ERRO[3]  = "Device Driver ocupado. Erro Interno!"
        ZPM_ERRO[4]  = "Comando nao implementado. Erro Interno!"
        ZPM_ERRO[5]  = "Erro de Sintaxe em comando. Erro Interno!"
        ZPM_ERRO[6]  = "Fim do Tempo p/exec.comando."
        ZPM_ERRO[7]  = "Parametro invalido passado p/ LIB"
        ZPM_ERRO[8]  = "LIB ja esta ativa"
        ZPM_ERRO[9]  = "LIB nao esta ativa"
        ZPM_ERRO[10] = "Device Driver nao instalado"
        ZPM_ERRO[11] = "Banco nao esta cadastrado no arquivo de configuracao"
        ZPM_ERRO[12] = "Coordenadas de Valor nao informadas ou invalida"
        ZPM_ERRO[13] = "Coordenadas de Extenso nao informadas ou invalida"
        ZPM_ERRO[14] = "Coordenadas de Favorecido nao informadas ou invalida"
        ZPM_ERRO[15] = "Coordenadas de Cidade nao informadas ou invalida"
        ZPM_ERRO[16] = "Coordenadas da Data nao informadas ou invalida"
        ZPM_ERRO[17] = "Erro de sintaxe em descricao das coordenadas no arquivo"
        ZPM_ERRO[18] = "Nao conseguiu acessar arquivo de configuracao"
        ZPM_ERRO[32] = "Cancelamento invalido"
        ZPM_ERRO[33] = "Abertura do dia invalida"
        ZPM_ERRO[34] = "Aliquota nao carregada"
        ZPM_ERRO[35] = "Erro na gravacao da memoria fiscal"
        ZPM_ERRO[36] = "Numero Maximo de Troca de Estabelecimento alcancado"
        ZPM_ERRO[37] = "Erro no Byte Verificador da Memoria Fiscal"
        ZPM_ERRO[38] = "Impressora em intervencao tecnica"
        ZPM_ERRO[39] = "Memoria Fiscal desconectada"
        ZPM_ERRO[40] = "Indice da Aliquota invalido"
        ZPM_ERRO[41] = "Nao houve desconto anterior"
        ZPM_ERRO[42] = "Desconto invalido"
        ZPM_ERRO[43] = "Nao houve acrescimo no subtotal"
        ZPM_ERRO[44] = "Data inicial nao localizada"
        ZPM_ERRO[45] = "Perda da memoria RAM"
        ZPM_ERRO[46] = "Comando aceito apenas em intervencao tecnica"
        ZPM_ERRO[47] = "Valor invalido p/ preenchimento do cheque"  && 2EFE/1EFNF apenas
        ZPM_ERRO[48] = "Memoria Fiscal ja inicializada"
        ZPM_ERRO[49] = "Fechamento nao realizado"
        ZPM_ERRO[50] = "Fechamento ja realizado"
        ZPM_ERRO[51] = "Comando fora de sequencia"
        ZPM_ERRO[52] = "Nao comecou a venda"
        ZPM_ERRO[53] = "Nao houve pagamento"
        ZPM_ERRO[54] = "Configuracao permitida apenas apos fechamento"  && NF apenas
        ZPM_ERRO[55] = "Cupom ja totalizado"
        ZPM_ERRO[56] = "Comando inexistente"
        ZPM_ERRO[57] = "Impressora retornou timeout RX"
        ZPM_ERRO[58] = "Uso de palavra reservada"
        ZPM_ERRO[59] = "Nao houve desconto no subtotal"
        ZPM_ERRO[60] = "Caracter invalido"
        ZPM_ERRO[61] = "Valor de desconto invalido"
        ZPM_ERRO[62] = "Operacao nao permitida em documento nao fiscal"
        ZPM_ERRO[63] = "Cancelamento de cupom invalido"
        ZPM_ERRO[64] = "Propaganda permitida apenas apos pagamento completo"
        ZPM_ERRO[65] = "Falta inicializar cupom nao fiscal"
        ZPM_ERRO[66] = "Aliquota indisponivel"
        ZPM_ERRO[67] = "Troca de proprietario apenas apos fechamento"
        ZPM_ERRO[68] = "Reducao inicial nao localizada"
        ZPM_ERRO[69] = "Memoria fiscal cheia"
        ZPM_ERRO[70] = "Troca de situacao tributaria apenas apos fechamento"
        ZPM_ERRO[71] = "Codigo de mercadoria invalida"
        ZPM_ERRO[72] = "Limite de valor do item ultrapassado"
        ZPM_ERRO[73] = "Cabecalho ja impresso"
        ZPM_ERRO[74] = "Acerto de horario de verao somente apos fechamento"
        ZPM_ERRO[75] = "Acerto de horario de verao permitido somente 1 vez ao dia"
        ZPM_ERRO[76] = "Relogio inconsistente"
        ZPM_ERRO[77] = "Comando valido apenas para Nota Fiscal" && 1EFNF
        ZPM_ERRO[78] = "Impressao de NFVC somente em venda"  && 1EFNF
        ZPM_ERRO[79] = "Campo ja impresso"      && 1EFNF
        ZPM_ERRO[80] = "Coordenada invalida"     && 1EFNF
        ZPM_ERRO[81] = "Registrador invalido"
        ZPM_ERRO[82] = "Nro. maximo de troca de simbolo da moeda alcancado"
        ZPM_ERRO[83] = "1EF - Falta papel para autenticacao"  && 1EF apenas
        ZPM_ERRO[84] = "Comando valido apenas para cupom fiscal" && 1EFNF apenas
        ZPM_ERRO[85] = "Nao ha item a descontar"
        ZPM_ERRO[86] = "Transacao inexistente"
        ZPM_ERRO[87] = "Transacao ja cancelada"
        ZPM_ERRO[88] = "Memoria fiscal nao apagada"
        ZPM_ERRO[89] = "Faltou papel"
        ZPM_ERRO[90] = "Acrescimo no subtotal invalido"
        ZPM_ERRO[91] = "Desconto no subtotal invalido"
        ZPM_ERRO[92] = "Valor do relogio invalido"
        ZPM_ERRO[93] = "Montante da operacao igual a 0 (zero)"
        ZPM_ERRO[94] = "2EFE - Papel perto do fim"     && 2EF apenas
        ZPM_ERRO[95] = "Nome da moeda nao carregado"
        ZPM_ERRO[96] = "NF - Necessita natureza da operacao"
        ZPM_ERRO[97] = "NF - Necessita configurar formulario"
        ZPM_ERRO[98] = "Intervencao Tecnica"
        ZPM_ERRO[99] = "Em periodo de venda"
        ZPM_ERRO[100]= "Em venda de item"
        ZPM_ERRO[101]= "Em pagamento"
        ZPM_ERRO[102]= "Em comercial"
        ZPM_ERRO[103]= "Esperando fech. do cupom de leitura X ou reducao Z"
        ZPM_ERRO[104]= "Em cupom nao fiscal"
        ZPM_ERRO[105]= "Dia fechado"
        ZPM_ERRO[106]= "Impressora nao pronta"
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

