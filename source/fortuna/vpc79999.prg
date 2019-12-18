

// ## CL2HB.EXE - Converted
#Include "VPF.CH"
#Include "FORMATOS.CH"
#Include "INKEY.CH"

/*=============================================================================

                                          ROTINAS DE INCLUSAO DE NOVAS COTACOES

==============================================================================*/

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao       ³ PConsulta
³ Finalidade   ³ Consultar os dados de Clientes
³ Programador  ³ Valmor Pereira Flores
³ Parametros   ³ Nenhum
³ Retorno      ³ Nenhum
³ Data         ³ 03/Maio/1995
³ Atualizacao  ³ 29/Maio/1995 - 16/Novembro/1998 - 20/Agosto/1999 - Jun/2001
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function pConsulta( nCodCliente )
   Local cTelaRes
   Local cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(), cCOR:=SetColor()
   Local oPROD, oClie, nTECLA, nTELA:=1
   Local nCODPRO, cTELA0, aBOX[2], cDESCLI, cDESPRO
   Local lFLAG:=.F., lALTERAPOS:=.T.
   Local nOrdem:= IndexOrd(), nArea:= Select()
   Local nRegNovoCliente:= 0
   Local GETLIST:={}, lNovoCliente:= .F.
   Local cBuscar:= Space( 1 )
   Local nCodigo, cDescri, cEndere, cCidade, cEstado, cFone1_, cFax___,;
         cCompra, cCGCMf_, dDataCd, lAppend:= .T., cCodigo, nCodCli:= 0

   /* Variaveis para pedido */
   Local nPosicao:= 0, nPrecoInicial, nPerDesconto, nPrecoFinal, nQuantidade,;
         cCliente, aPedido:= {}, lAltera:= .F., lFechaFiles:= .F.

   Private CodigoReserva

   SWSet( 5000, .F. )

   DBSelectAr( _COD_PEDIDO )
   IF Used()
      lFechaFiles:= .F.
   ELSEIF !Used()
      IF !AbreGrupo( "PEDIDOS" )
         Return Nil
      ENDIF
      lFechaFiles:= .T.
   ENDIF
   DBSelectAr( _COD_PEDIDO )
   DBSetOrder( 1 )
   Tone( 750, 2 )

   /* Pegar o ultimo codigo */
   DBGoBottom()

   cCodigo:= StrZero( Val( Codigo ) + 1, 8, 0 )
   CodigoReserva:= cCodigo

   DBAppend()
   IF !NetErr()
      Replace CODIGO With cCodigo, DESCRI With _RESERVADO
   ELSE
      Mensagem( "Nao foi possivel gravar o registro..." )
      Mensagem( "Pressione [ENTER] e depois tente novamente." )
      Pausa()
      Return Nil
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

   SetCursor(0)
   DispBegin()
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   USERSCREEN()
   VPBOX( 00, 00, 22, 79, "Clientes", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .T. )
   VPBOX( 13, 00, 22, 79, "Display-Clientes", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. )
   aBOX[1]:=BOXSAVE(13,01,21,45)
   aBOX[2]:=BOXSAVE(13,46,21,76)
   SetColor( "15/05" )
   @ 03,40 Say " Codigo Pedido: " + cCodigo + " "
   SetColor( _COR_BROW_LETRA )
   DevPos(02,02);DevOut("Empresa.......:")
   DevPos(03,02);DevOut("Nome..........:")
   DevPos(04,02);DevOut("N.Fantasia....:")
   DevPos(05,02);DevOut("Endereco......:")
   DevPos(06,02);DevOut("Bairro/Cidade.:")
   DevPos(07,02);DevOut("Inscricao.....:")
   DevPos(08,02);DevOut("Contato.......:")
   DevPos(09,02);DevOut("Transportadora:")
   DevPos(10,02);DevOut("Data..........:")
   DevPos(11,02);DevOut("Fone(s).......:")
   DispEnd()
   Ajuda( "["+_SETAS+"]Move [INS]Outro_Cliente [F2][F3]Ordem [TAB]Janela [Nome/Codigo]Pesquisa")
   MENSAGEM("Pressione [TAB] para trocar de janela ou [ESC] para sair...")
   DBSelectAr(_COD_MPRIMA)
   DbSelectAr(_COD_CLIENTE)
   DBGoTop()

   nRegistro:= RECNO()
   /* Cotacao p/ cliente especifico */
   IF nCodCliente <> Nil
      DBSetOrder( 1 )
      DBSeek( nCodCliente )
      Mensagem( ALLTRIM( DESCRI ) )
      nRegistro:= RECNO()
   ENDIF
   DBLeOrdem()
   DBGoTo( nRegistro )

   SetColor( _COR_BROWSE )
   oClie:=TBrowseDb( 14, 02, 21, 75 )
   oClie:AddColumn(TbColumnNew(,{|| StrZero(CLI->CODIGO,6,0)+"³"+;
                                            CLI->DESCRI + "³"+;
                                            IF( EMPTY( CLI->CGCMF_ ), PAD( Tran( CLI->CPF___, "@R 999.999.999-99" ), 18 ), Tran( CLI->CGCMF_, "@R XX.XXX.XXX/XXXX-XX" ) ) + IF( Cli->Client=="S", "³JCP ", "³NCP " ) + SPACE( 20 ) }))
   oClie:AUTOLITE:=.F.
   oClie:dehilite()
   oClie:RefreshAll()
   WHILE !oClie:Stabilize()
   ENDDO

   While .T.
      IF nTELA=1
         IF lALTERAPOS
            DbSelectAr(_COD_CLIENTE)
            oClie:RefreshAll()
            While ! oClie:Stabilize()
            EndDo
            lALTERAPOS:=.F.
         ENDIF
         oClie:ColorRect({oClie:ROWPOS,1,oClie:ROWPOS,1},{2,1})
         WHILE NextKey()=0 .AND. !oClie:Stabilize()
         ENDDO
         Janela( 2 )
         DispBegin()
         SetColor( _COR_BROW_LETRA )
         DevPos(02,18);DevOut( StrZero( CLI->FILIAL, 3, 0 ) + " / " + StrZero( CLI->CODIGO, 6, 0 ) )
         DevPos(03,18);DevOut( CLI->DESCRI )
         DevPos(04,18);DevOut( CLI->FANTAS )
         DevPos(05,18);DevOut( CLI->ENDERE )
         DevPos(06,18);DevOut( CLI->BAIRRO + "  " + Left( CLI->CIDADE, 30 ) )
         DevPos(07,18);DevOut( CLI->INSCRI )
         DevPos(08,18);DevOut( CLI->COMPRA )
         DevPos(09,18);DevOut( StrZero( CLI->TRANSP, 3, 0 ) )
         DevPos(10,18);DevOut( CLI->DATACD )
         DevPos(11,18);DevOut( CLI->FONE1_ + "  " + CLI->Fone2_ + "  " + CLI->Fone3_  + "  FAX:" + CLI->FAX___ )
         Scroll( 08, 38, 11, 75 )
         @ 07,38 to 10,75
         @ 08,40 Say "Limite de Credito: " + Tran( LimCr_, "@r 999,999,999.99" )
         @ 09,40 Say "Saldo de Credito.: " + Tran( Saldo_, "@r 999,999,999.99" )
         DispEnd()
         SetColor( _COR_BROWSE )
      ELSEIF nTELA=2
         IF lALTERAPOS
            oClie:Refreshall()
            WHILE ! oClie:Stabilize()
            ENDDO
            DbSelectAr(_COD_MPRIMA)
            lALTERAPOS:=.F.
         ENDIF
      ENDIF
      IF CLI->FOLEMP > 0
         nOrdRes:= CLI->( IndexOrd() )
         nRegRes:= CLI->( RECNO() )
         nFolCod:= CLI->FOLEMP
         CLI->( DBSetOrder( 1 ) )
         CLI->( DBSeek( nFolCod ) )
         @ 02,18 Say LEFT( CLI->DESCRI, 30 )
         CLI->( DBSetOrder( nOrdRes ) )
         CLI->( DBGoTo( nRegRes ) )
      ELSE
         @ 02,18 Say PAD( StrZero( CLI->FILIAL, 3, 0 ) + " / " + StrZero( CLI->CODIGO, 6, 0 ), 30 )
      ENDIF
      nTECLA:= Inkey( 0 )

      IF nTECLA=K_ESC
         DBSelectAr( _COD_PEDIDO )
         DBSetOrder( 1 )
         DBSeek( cCodigo )
         IF Alltrim( DESCRI ) == Alltrim( _RESERVADO )
            IF NetRLock()
               DBDelete()
            ENDIF
            DBUnlock()
         ENDIF
         LimpaMarcas( aPedido )
         Aviso( "Limpando registros marcados. Aguarde...", 24 /2 )
         DBSelectar( _COD_MPRIMA )
         DBSetOrder( 6 )
         DBGoTop()
         DBSeek( "*" )
         Exit
      ENDIF

      do Case
         Case nTecla==K_INS
              /* nRegNovoCliente = registro do novo cliente */
              lNovoCliente:= ClientesInclusao( Nil, oClie, @nRegNovoCliente )

         Case nTecla==K_F8

              VPC41234( CLI->CODIGO )
              oClie:RefreshAll()
              WHILE !oClie:Stabilize()
              ENDDO

         Case nTecla==K_F12        ;Calculador()
         Case nTecla==K_UP         ;oClie:up()
         Case nTecla==K_DOWN       ;oClie:down()
         Case nTecla==K_PGUP       ;oClie:pageup()
         Case nTecla==K_PGDN       ;oClie:pagedown()
         Case nTecla==K_HOME .OR. nTecla==K_CTRL_PGUP ;oClie:gotop()
         Case nTecla==K_END  .OR. nTecla==K_CTRL_PGDN ;oClie:gobottom()
         Case DBPesquisa( nTecla, oClie, @cBuscar )
              if IndexOrd() == 7
                 cBuscar:= alltrim( Str( Val( cBuscar ), 12, 0 ) )
                 if !( alltrim( FONE1_ ) == alltrim( cBuscar ) )
                    cBuscar:= alltrim(  cBuscar )
                    if !DBSeek( pad( alltrim( cBuscar ), len( FONE1_ ) ) )
                       if !DBSeek( pad( SPACE( 1 ) + cBuscar, len( FONE1_ ) ) )
                         if !DBSeek( pad( SPACE( 2 ) + cBuscar, len( FONE1_ ) ) )
                            if !DBSeek( pad( SPACE( 3 ) + cBuscar, len( FONE1_ ) ) )
                               if !DBSeek( pad( SPACE( 4 ) + cBuscar, len( FONE1_ ) ) )
                                  if !DBSeek( pad( "51  " + cBuscar, len( FONE1_ ) ) )
                                     if !DBSeek( pad( "051 " + cBuscar, len( FONE1_ ) ) )
                                        if !DBSeek( pad( "0051" + cBuscar, len( FONE1_ ) ) )
                                           if !DBSeek( pad( "  51" + cBuscar, len( FONE1_ ) ) )
                                              if !DBSeek( pad( " 51 " + cBuscar, len( FONE1_ ) ) )
                                                 cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                                                 Aviso( "Fone:" + cBuscar + "! Cliente nao existe no cadastro com este telefone." )
                                                 Pausa()
                                                 screenRest( cTelaRes )
                                              endif
                                           endif
                                        endif
                                     endif
                                  endif
                               endif
                            endif
                         endif
                       endif
                    endif
                 endif
              endif
              oClie:RefreshAll()
              WHILE !oClie:Stabilize()
              ENDDO
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oClie )
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oClie )
         Case nTecla==K_F4         ;DBMudaOrdem( 3, oClie )
         Case nTecla==K_F5         ;DBMudaOrdem( 7, oClie )
         Case nTecla==K_TAB .OR. nTecla==K_ENTER

              /* Se atividade for negativa */
              IF CLI->CODATV < 0
                 ATV->( DBSetOrder( 1 ) )
                 ATV->( DBSeek( CLI->CODATV ) )
                 cAtividade:= ALLTRIM( ATV->DESCRI )

                 IF !EMPTY( cAtividade )
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                    VPBox( 15, 10, 17, 69, " ATENCAO ", "15/04" )
                    @ 16,12 Say PADC( cAtividade, 57 ) Color "15/04"
                    Tone( 800, 2 )
                    Tone( 700, 5 )
                    Tone( 400, 1 )
                    Pausa()
                    ScreenRest( cTelaRes )
                 ENDIF

                 /* Emite aviso */
                 IF !EMPTY( CLI->OBSER1 )
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                    VPBox( 10, 10, 19, 69, " ATENCAO ", "15/04" )
                    @ 12,12 Say PADC( ALLTRIM( CLI->OBSER1 ), 57 ) Color "15/04"
                    @ 13,12 Say PADC( ALLTRIM( CLI->OBSER2 ), 57 ) Color "15/04"
                    @ 14,12 Say PADC( ALLTRIM( CLI->OBSER3 ), 57 ) Color "15/04"
                    @ 15,12 Say PADC( ALLTRIM( CLI->OBSER4 ), 57 ) Color "15/04"
                    @ 16,12 Say PADC( ALLTRIM( CLI->OBSER5 ), 57 ) Color "15/04"
                    Tone( 800, 2 )
                    Tone( 700, 5 )
                    Tone( 400, 1 )
                    Pausa()
                    ScreenRest( cTelaRes )
                 ENDIF

              ENDIF

              /* Verifica limite de credito */
              IF SWSet( _PED_LIMITECREDITO )
                 SaldoCliente( CLI->CODIGO )
              ENDIF

              /* Verifica se data da ultima nota de
                 venda p/ cliente ‚ maior que <n> dias */
              IF SWSet( _NFA_DIAS ) > 0
                 lOk:= .T.
                 DPA->( DBSetOrder( 5 ) )
                 IF DPA->( DBSeek( CLI->CODIGO ) )
                    WHILE ( DPA->CLIENT==CLI->CODIGO ) .AND. !DPA->( EOF() )
                        DPA->( DBSkip() )
                    ENDDO
                    IF !EOF()
                       DPA->( DBSkip( -1 ) )
                       IF ( DATE() - DPA->DATAEM ) > SWSet( _NFA_DIAS ) .AND. ( DATE() - DPA->DATAEM ) < 1000
                          IF SWAlerta( "Atencao! ultima Duplicata p/ este cliente foi a " + Alltrim( Str( DATE() - DPA->DATAEM, 10, 0 ) ) + " dias", { "Cancelar", "Confirmar" } )==1
                             lUltimaFazTempo:= .T.
                             lOk:= .F.
                          ENDIF
                       ENDIF
                    ENDIF
                 ELSE
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                    Aviso( "Nunca houve fatura para este cliente!" )
                    Pausa()
                    ScreenRest( cTelaRes )
                 ENDIF
              ENDIF


              /* Verifica se esta OK! */
              IF lOk

                 /* Precos / Operacao / Condicoes de Pagamento */
                 IF !CLI->TABPRE == 0
                    PRE->( DBSetOrder( 1 ) )
                    PRE->( DBSeek( CLI->TABPRE ) )
                 ENDIF
                 IF !CLI->TABCND == 0
                    CND->( DBSetOrder( 1 ) )
                    CND->( DBSeek( CLI->TABCND ) )
                 ENDIF
                 IF !CLI->TABOPE == 0
                    OPE->( DBSetOrder( 1 ) )
                    OPE->( DBSeek( CLI->TABOPE ) )
                 ENDIF

                 DisplayMPR()
                 lAlteraPos:= .T.
                 IF lNovoCliente .AND. !SWSet( _PED_CADCLIENTE )
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 )

                    Aviso( "Aguarde, limpando informacoes do cliente.", 24 / 2 )
                    INKEY( 0 )

                    DBSelectAr( _COD_CLIENTE )
                    DBGoTo( nRegNovoCliente )
                    IF NetRLock()
                       Dele
                    ENDIF
                    DBUnlockAll()
                    lNovoCliente:= .F.
                    ScreenRest( cTelaRes )
                 ENDIF
              ENDIF
         OtherWise                ;tone(125); tone(300)
         endcase
         oClie:Refreshcurrent()
         oClie:Stabilize()
     enddo
     SetColor( cCOR )
     SetCursor( nCURSOR )
     ScreenRest( cTELA )
     IF lFechaFiles
        //DBUnlockAll()
        FechaArquivos()
     ENDIF
     Return(.T.)

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ displayMPR
³ Finalidade  ³ Display de Materia-Prima
³ Parametros  ³ Nenhum
³ Retorno     ³ Nenhum
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 05/Fevereiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DisplayMPR()

   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 ), cTelaRes, cCorRes
   Loca lQuantidade:= .F.
   Local cDetal1:= cDetal2:= cDetal3:= Space( 65 )
   LOCAL lAlteraPos:= .T., nTela:= 2, aPedido:= {}, nPerIpi:= 0
Local nReserva
Local aCorTamQua:= { { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } },;
      nLinha, nClasse:= 0, nTamCod:= 0, nCorCod:= 0, nTamQua:= 0

   DispBegin()
   VPBox( 00, 00, 12, 79, "Produtos", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .T. )
   VPBox( 13, 00, 22, 79, "Display Produtos", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. )

   DevPos( 01, 01 ); DevOut( "Cliente.......: " + CLI->DESCRI )
   DevPos( 02, 01 ); DevOut( "Produto.......:" )
   DevPos( 03, 01 ); DevOut( "Codigo Fabrica:" )
   DevPos( 04, 01 ); DevOut( "Descricao.....:" )
   DevPos( 05, 01 ); DevOut( "ICMs / IPI....:" )
   DevPos( 06, 01 ); DevOut( "Saldo.........:" )
   DevPos( 07, 01 ); DevOut( "Reservado.....:" )
   DevPos( 08, 01 ); DevOut( "Disponivel....:" )
   DevPos( 09, 01 ); DevOut( "Preco Venda...:" )
   DevPos( 10, 01 ); DevOut( "Data..........:" )
   Janela( 3 )
   DispEnd()
   Ajuda( "["+_SETAS+"]Move [Tab]Cotacao [F2][F3][F4]Ordem [A..Z]Pesquisa [ESC]Cancela" )
   Mensagem( "Pressione [ENTER] p/ selecionar o produto ou [TAB] para ver a Cotacao." )

   DBSelectAr( _COD_ORIGEM )
   DBSetOrder( 3 )

   DbSelectAr(_COD_MPRIMA)
   Set Relation To ORIGEM Into ORG

   DBLeOrdem()
   SetColor( _COR_BROWSE )
   oPROD:=TBrowseDb(14, 01, 21, 78 )
   oPROD:AddColumn( TbColumnNew(,{|| IF( MPR->AVISO_ > 0, StrZero( MPR->AVISO_, 2, 0 ), Space( 2 ) ) + MPR->MARCA_ + Tran( Indice, "@R XXXXXXX" ) + "³" + MPR->CodFab + "³" + LEFT( MPR->Descri, 35 ) + "³" + MPR->ORIGEM + "³" + MPR->UNIDAD + "³" + Tran( PrecoConvertido(),"@E **,***.***") }))
   oPROD:AUTOLITE:=.F.
   oPROD:dehilite()
   While .T.
      oPROD:colorrect({oPROD:ROWPOS,1,oPROD:ROWPOS,1},{2,1})
      whil nextkey()=0 .and.! oPROD:stabilize()
      enddo
      SetColor( _COR_BROW_LETRA )
      nLinha:= ROW()
      DispBegin()
      cCorRes:= SetColor()
      SetColor( cCorRes )
      /* relacao de produtos no pedido */
      cCorRes:= SetColor()
      nLin:= 0
      VPBox( 06, 35, 12, 79, "Relacao de Produtos do seu pedido", "15/00",.F.,.F. )
      SetColor( "15/00" )
      FOR nCt:= 1 TO Len( aPedido )
          ++nLin
          IF AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) == nCt
             SetColor( "15/04" )
          ELSE
             SetColor( "15/00" )
          ENDIF
          IF nLin >= 5
             Scroll( 07, 36, 11, 78, 1 )
             nLin:= 4
          ENDIF
          @ nLin + 6, 36 Say Tran( StrZero( aPedido[ nCt ][ 11 ], 7, 0 ), "@R 999-9999" ) + ;
                      " => " + aPedido[ nCt ][ 1 ] + " ³ Qtd:" +;
                      Tran( aPedido[ nCt ][ 6 ], "@E 9,999.999" )
      NEXT
      IF Marca_ == "*"
         IF AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) > 0
            SetColor( "15/00" )
            @ 12,36 SAY "»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»"
         ELSE
            SetColor( "15/04" )
            @ 12,36 SAY " ESTE PRODUTO NAO FOI MARCADO POR VOCE  "
         ENDIF
      ENDIF

      /* Tabela de Preco */
      @ 02,28 Say " " + PRE->DESCRI
      @ 12,01 Say LEFT( " Preco Padrao - " + Tran( MPR->PRECOV, "@E 999,999.99" ), 33 ) Color "15/" + CorFundoAtual()


      SetColor( cCorRes )

      DevPos(02,17); DevOut( MPR->INDICE, "@R 999-9999" )
      DevPos(03,17); DevOut( MPR->CODFAB )
      DevPos(04,17); DevOut( MPR->DESCRI )

      DevPos(05,17); DevOut( StrZero( MPR->ICM___, 6, 2 ) )
      DevPos(05,27); DevOut( StrZero( MPR->IPI___, 6, 2 ) )

      IF MPR->CLASSE <> " "
         @ 03,29 Say "CLASSE " + MPR->CLASSE Color "14/" + CorFundoAtual()
      ELSE
         @ 03,29 Say "       " + " "
      ENDIF

      /* Preco de compra do produto */
      @ 05,40 Say "(c): " + Tran( PrecoCompra( MPR->INDICE ),"@E 99,999.999") + "/" + PAD( ALLTRIM( Tran( MPR->PERCPV, "@r 9,999.999" ) ), 10 ) Color "14/" + CorFundoAtual()

      @ 06,17 Say Tran( MPR->SALDO_,"@E 999999.999" )

      IF SWSet( _PED_CONTROLERESERVA )
         @ 07,17 Say Tran( IF( MPR->RESERV > 0, MPR->RESERV, 0 ),"@E 999999.999" ) Color "04/" + CorFundoAtual()
         @ 08,17 Say Tran( MPR->SALDO_ - IF( MPR->RESERV > 0, MPR->RESERV, 0 ),            "@E 999999.999" ) Color "10/" + CorFundoAtual()
      ELSE
         @ 07,17 Say "Desabilitado"
         @ 08,17 Say Tran( MPR->SALDO_, "@E 999999.999" ) Color "10/" + CorFundoAtual()
      ENDIF

      DevPos(09,17); DevOut( MPR->MOEDA_ + Tran( PrecoConvertido(),"@E ****,***.***" ) )
      DevPos(10,17); DevOut( MPR->DATA__ )

      IF LEFT( MPR->INDICE, 3 ) == SWSet( _GER_GRUPOSERVICOS )
         @ 11,01 Say "Servico            " Color "08/" + CorFundoAtual()
      ELSE
         @ 11,01 Say IF( MPR->MPRIMA=="S" .OR. MPR->MPRIMA==" ", "Materia-Prima      ", "Produto Composto   " ) Color "08/" + CorFundoAtual()
      ENDIF
      DispEnd()
      SetColor( _COR_BROWSE )

      /* Exibir o nome do produto com cores */
      IF MPR->AVISO_ > 0
         @ nLinha,26 Say LEFT( MPR->DESCRI, 35 ) Color "15/" + StrZero( MPR->AVISO_, 2, 0 )
      ENDIF


      IF ( nTECLA:= Inkey( 0 ) ) == K_ESC
         IF ! ( PED->CodCli == CLI->Codigo ) .AND. ! Empty( aPedido ) .AND. ! SWSet( 5000 )
            cTelaRes:= ScreenSave( 0, 0, 24, 79 )
            Aviso( "Atencao! Este pedido nao foi gravado. [ENTER]Grava [ESC]Cancela.", 24 / 2 )
            WHILE .T.
               nTeclaRes:= Inkey(0)
               IF nTeclaRes == K_ENTER
                  Keyboard "G"
                  Cotacao( aPedido )
                  Inkey()
                  Keyboard Chr( K_ESC ) + Chr( K_ESC )
               ELSEIF Chr( nTeclaRes ) $ "Cc" .OR. nTeclaRes == K_ESC
                  Keyboard Chr( K_ESC )
                  Exit
               ENDIF
            ENDDO
            ScreenRest( cTelaRes )
         ENDIF
         LimpaMarcas( aPedido )
         LimpaArquivo()
         Exit
      ENDIF
      if !( nTecla == K_ENTER )
         SwSet( _INT_ULTIMABUSCA, "" )
      endif
      do case
         case Acesso( nTecla )
         case nTecla==K_F12        ;Calculador()
         case nTecla==K_UP         ;oProd:up()
         case nTecla==K_DOWN       ;oProd:down()
         case nTecla==K_PGUP       ;oProd:pageup()
         case nTecla==K_PGDN       ;oProd:pagedown()
         Case nTecla==K_HOME .OR. nTecla==K_CTRL_PGUP ;oProd:gotop()
         Case nTecla==K_END  .OR. nTecla==K_CTRL_PGDN ;oProd:gobottom()
         case nTecla==K_F5
              Detalhamento()
         case nTecla==K_F9
              Similaridade( oProd )
         case nTecla==K_F7

         case nTecla==K_F8
              /* Escolha de tabela de preco diferenciada */
              IF SWAlerta( "<< TABELA DIFERENCIADA >>;A escolha de uma nova tabela influira ;nos precos dos proximos produtos selecionados!", { "Tabela de Preco", "   Cancelar   " } )==1
                 TabelaPreco()
                 oProd:RefreshAll()
                 WHILE !oProd:Stabilize()
                 ENDDO
              ENDIF

         Case nTecla==K_F11
              IF lquantidade
                 lquantidade := .f.
              else
                 lquantidade := .t.
              endif

         case DBPesquisa( nTecla, oProd )

              lEAN12:= .F.
              /* Se estiver em ordem de barra & formulario for 3 */
              IF ( IndexOrd()==4 ) .AND. ( SWSet( _PED_FORMULARIO ) == 3 )
                 /* Verifica se NAO localizou como EAN13 */
                 IF !( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ) == ALLTRIM( MPR->CODFAB ) )
                    /* Refaz a ultima busca, como sendo EAN12 */
                    IF DBSeek( PAD( LEFT( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ), LEN( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ) ) -1 ), 13 ) )
                       /* Se achar Transforma ultimaBUSCA em Formato EAN12, com um espaco no ultimo caractere */
                       SWSet( _INT_ULTIMABUSCA, PAD( LEFT( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ), LEN( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ) ) -1 ), 13 ) )
                       lEAN12:= .T.
                    ENDIF
                 ENDIF
                 IF ( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ) == ALLTRIM( CODFAB ) ) .AND. !lEAN12
                     /* Verifica se o n§de char procurado ‚ menor que o campo CODFAB e
                       soh assim d  ENTER, caso contrario o proprio campo preenchera as
                       informacoes nao sendo necessario o ENTER */
                    IF LEN( ALLTRIM( SWSet( _INT_ULTIMABUSCA ) ) ) < LEN( MPR->CODFAB )
                       Keyboard Chr( K_ENTER )
                    ENDIF
                 ENDIF
              ENDIF

         case nTecla=K_F2; DBMudaOrdem( 1, oProd )
         case nTecla=K_F3; DBMudaOrdem( 4, oProd )
         case nTecla=K_F4; DBMudaOrdem( 2, oProd )
         case nTECLA=K_TAB
              IF !Empty( aPedido )
                 Cotacao( aPedido )
              ELSE
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                 Tone( 300, 3 )
                 Aviso( "Selecione os produtos p/ poder ver a cotacao.", 24 / 2 )
                 Mensagem( "Pressione ENTER para continuar..." )
                 Pausa()
                 ScreenRest( cTelaRes )
                 cTelaRes:= Nil
              ENDIF

         case nTECLA=K_ENTER

              cTelaReserva:= ScreenSave( 0, 0, 24, 79 )

              /* Ordem */
              IF SWSet( _INT_ULTIMABUSCA ) == Nil
                 SWSet( _INT_ULTIMABUSCA, "" )
              ENDIF

              IF IndexOrd()==4 .AND. SWSet( _PED_FORMULARIO ) == 3 .AND. !( SWSet( _INT_ULTIMABUSCA )=="" )
                 IF ALLTRIM( SWSet( _INT_ULTIMABUSCA ) )==ALLTRIM( MPR->CODFAB )
                    lEdita:= .T.
                 ELSE
                    lEdita:= .F.
                 ENDIF
              ELSE
                 lEdita:= .T.
              ENDIF

              IF !lEdita .or. MPR->( eof() )
                 Aviso( "Produto: " + alltrim( SWSet( _INT_ULTIMABUSCA ) ) + " nao localizado." )
                 Pausa()
                 SWSet( _INT_ULTIMABUSCA, "" )
              ELSE
                 IF Marca_ <> Space( 1 )
                    nPosicao:= AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } )
                    IF PedidoProdutos== _TBI_MAIS_VEZES
                       nPosicao:= 0
                    ENDIF
                    IF nPosicao == 0
                       cDetal1:= MPR->Detal1
                       cDetal2:= MPR->Detal2
                       cDetal3:= MPR->Detal3
                       nPrecoInicial:= PrecoConvertido()
                       nPerDesconto:=  MPr->PercDc
                       nPrecoFinal:= 0.00
                       nQuantidade:= 0
                       cOrigem:= MPr->Origem + Space( 11 )
                       cUnidade:= MPr->Unidad
                       lAltera:= .F.
                       nPerIpi:= 0
                       dDtentre := space(10)
                       nUnidades := 0
                    ELSE
                       MPR->( DBSetOrder( 1 ) )
                       MPR->( DBSeek( Pad( Strzero(aPedido[ nPosicao ][ 11 ], 7 ), 12 ) ) )
                       nPrecoInicial:= aPedido[ nPosicao ][ 3 ]
                       nPerDesconto:=  aPedido[ nPosicao ][ 4 ]
                       nPrecoFinal:=   aPedido[ nPosicao ][ 5 ]
                       nQuantidade:=   aPedido[ nPosicao ][ 6 ]
                       cUnidade:=      aPedido[ nPosicao ][ 7 ]
                       cOrigem:=       aPedido[ nPosicao ][ 9 ]
                       nPerIpi:=       aPedido[ nPosicao ][ 8 ]
                       nClasse:=       aPedido[ nPosicao ][ 17 ]
                       nTamCod:=       aPedido[ nPosicao ][ 18 ]
                       nCorCod:=       aPedido[ nPosicao ][ 19 ]
                       cDetal1:=       aPedido[ nPosicao ][ 21 ]
                       cDetal2:=       aPedido[ nPosicao ][ 22 ]
                       cDetal3:=       aPedido[ nPosicao ][ 23 ]
                       cDtentre:=      aPedido[ nPosicao ][ 24 ]
                       nUnidades :=    0
*                       nUnidades :=    (nQuantidade/MPR->QTDPES)
                       lAltera:=       .T.
                    ENDIF
                 ELSE
                    cUnidade:=      MPr->UNIDAD
                    nPrecoInicial:= PrecoConvertido()
                    nPerDesconto:=  MPr->PercDc
                    nPrecoFinal:=   0.00
                    nQuantidade:=   0
                    cDetal1:=       MPR->Detal1
                    cDetal2:=       MPR->Detal2
                    cDetal3:=       MPR->Detal3
                    cOrigem:= MPr->Origem + Space( 11 )
                    nPerIpi:= MPr->IPI___
                    lAltera:= .F.
                    dDtentre := space(10)
                    nUnidades := 0
                 ENDIF

                 nClasse:= 0
                 nTamCod:= 0
                 nCorCod:= 0
                 nTamQua:= 0

                 cClasse  := SPACE( 40 )
                 cTamanho := SPACE( 10 )
                 cCorDes  := SPACE( 30 )

                 /* Se estiver preenchido DETALHE 1, 2 ou 3 Edita */
                 IF SWSet( _PED_DETALHE )
                    cTelaR5:= ScreenSave( 0, 0, 24, 79 )
                    VPBox( 08, 10, 20, 70, "DETALHAMENTO DE INFORMACOES", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                    SetColor( _COR_GET_EDICAO )
                    nCursorRes:= SetCursor( 1 )
                    @ 12,12 Say MPR->CODFAB
                    @ 13,12 Say MPR->DESCRI
                    /*--------------------------------------------------*/
                    @ 15,12 Say "Detalhamento"
                    @ 16,11 Get cDetal1 Pict "@S56"
                    @ 17,11 Get cDetal2 Pict "@S56"
                    @ 18,11 Get cDetal3 Pict "@S56"
                    READ
                    SetCursor( nCursorRes )
                    ScreenRest( cTelaR5 )
                 ENDIF

                 if SWSet( _PED_FORMULARIO ) == 3
                    nQuantidade:= 1
                    nPrecoInicial := nPrecoFinal:= PrecoConvertido()

                    IF lQuantidade .or. nPrecoFinal == 0
                       IF !( nPrecoFinal==0 )
                          keyb repl(chr(K_ENTER),3)
                       ENDIF
                       SetCursor(1)
                       SetColor( _COR_GET_EDICAO )
                       VPBox( 11, 10, 16, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                       @ 12,12 Say "Pre‡o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco() .AND. Mensagem( "Digite o novo preco de venda." )
                       @ 13,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                       @ 14,12 Say "Pre‡o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                       @ 15,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
                       READ
                       setcursor(0)
                    ENDIF
                    if MPR->MPRIMA == "N"
                       keyb chr(13)
                    endif
                    lQuantidade:= .f.
                 ELSE
                    VPBox( 08, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                    SetColor( _COR_GET_EDICAO )
                    @ 09,12 Say "Produto....: [" + MPR->CodFab + "]"
                    @ 10,12 Say "Descri‡„o..: [" + Alltrim( MPR->Descri ) + "]"
                    @ 11,12 Say "Fabrica....:" Get cOrigem Pict "XXXXXXXXXXXXXX"           When CodFabrica() .AND. Mensagem( "Digite o fabricante." )
                    @ 12,12 Say "Pre‡o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco() .AND. Mensagem( "Digite o novo preco de venda." )
                    @ 13,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                    @ 14,12 Say "Pre‡o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                    @ 15,12 Say "% IPI......:" Get nPerIpi Pict "@E 999.99"
                    @ 16,12 Say "Unidade....:" Get cUnidade Pict "!!"
                    IF SWSet( _PED_DTENTREGA )
                       @ 17,12 Say "Entrega....:" Get dDtentre pict "@!"
                    ENDIF
                    IF SWSet( _PED_FORMATO ) = 5 // METAIS DAR
                       @ 17,37 Say "Unidades...:" Get nUnidades pict "9999.99" valid F_CalUnixQuan(nUnidades,@nQuantidade)
                    ENDIF
                    VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                    @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" ;
                      When nClasse == 0 .AND. fVerPedGra( @nClasse, @nTamCod, ;
                         @nCorCod, @cClasse, @cTamanho, @cCorDes, @nTamQua, @aCorTamQua ) Valid ;
                           IIF( SWSet( _PED_FORMATO ) == 10, nQuantidade > 0, .T. )
                    SetCursor(1)
                    Read
                 ENDIF
                 IF SWSet( _PED_VERIFICASALDO )
                    IF SWSet( _PED_CONTROLERESERVA )
                       nReserva:= IF( MPR->RESERV > 0, MPR->RESERV, 0 )
                    ELSE
                       nReserva:= 0
                    ENDIF
                    IF ( MPR->SALDO_ - nReserva ) < nQuantidade .AND. nQuantidade > 0 .and. SWSet( _PED_FORMULARIO ) <> 3
                       Aviso( "Saldo disponivel insuficiente para a quantidade digitada." )
                       Tone( 800, 2 )
                       Tone( 700, 5 )
                       Tone( 400, 1 )
                       Pausa()
                    ENDIF
                 ENDIF

                 IF LastKey() <> K_ESC
                    IF lAltera
                       aPedido[ nPosicao ][ 3 ]:= nPrecoInicial
                       aPedido[ nPosicao ][ 4 ]:= nPerDesconto
                       aPedido[ nPosicao ][ 5 ]:= nPrecoFinal
                       aPedido[ nPosicao ][ 7 ]:= cUnidade
                       aPedido[ nPosicao ][ 6 ]:= nQuantidade
                       aPedido[ nPosicao ][ 9 ]:= cOrigem
                       aPedido[ nPosicao ][ 8 ]:= nPerIpi
                       aPedido[ nPosicao ][ 17 ] := nClasse
                       aPedido[ nPosicao ][ 18 ] := nTamCod
                       aPedido[ nPosicao ][ 19 ] := nCorCod
                       aPedido[ nPosicao ][ 21 ] := cDetal1
                       aPedido[ nPosicao ][ 22 ] := cDetal2
                       aPedido[ nPosicao ][ 23 ] := cDetal3
                       aPedido[ nPosicao ][ 24 ] := dDtentre
                       lAltera:= .F.
                    ELSE
                       IF NetRLock()
                          IF !( MPR->Marca_ == "*" )
                             Replace MPR->Marca_ With "*"
                          ENDIF
                          nPosicao:= 0
                          IF ( nPosicao:= ( AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) ) ) <= 0 .OR.;
                             PedidoProdutos== _TBI_MAIS_VEZES
                             IF nClasse > 0 .OR. nCorCod > 0   /* GRAVACAO COM SELECAO DE CLASSE E/OU COR */
                                FOR nCt:= 1 TO Len( aCorTamQua )
                                    FOR nCt2:= 2 TO Len( aCorTamQua[ nCt ] )
                                       IF aCorTamQua[ nCt ][ nCt2 ] > 0
                                          /* Calculo do preco de p/ tabela */
                                          nPreco:= MPR->PRECOV + ( ( MPR->PRECOV * PRE->PERACR ) / 100 )
                                          nPreco:= nPreco - ( ( nPreco * PRE->PERDES ) / 100 )
                                          AAdd( aPedido, { MPR->CodFab,  ;
                                                    MPR->Descri,  ;
                                                    nPrecoInicial,;
                                                    nPerDesconto, ;
                                                    nPrecoFinal,  ;
                                                    aCorTamQua[ nCt ][ nCt2 ],;
                                                    MPr->UNIDAD,  ;
                                                    MPr->IPI___,  ;
                                                    MPR->ORIGEM + "           ",;
                                                    "Sim",;
                                                    Val( MPR->INDICE ),;
                                                    MPR->PRECOV,;
                                                    nPreco,;
                                                    PRE->CODIGO,;
                                                    PRE->DESCRI,;
                                                    CND->CODIGO,;
                                                    nClasse,;
                                                    nCt2-1,;
                                                    aCorTamQua[ nCt ][ 1 ],;
                                                    cDetal1,;
                                                    cDetal2,;
                                                    cDetal3,;
                                                    dDtentre  } )
                                       ENDIF
                                    NEXT
                                NEXT
                             ELSE
                                /* GRAVACAO SIMPLIFICADA DO PRODUTO */
                                /* Calculo do preco de p/ tabela */
                                nPreco:= MPR->PRECOV + ( ( MPR->PRECOV * PRE->PERACR ) / 100 )
                                nPreco:= nPreco - ( ( nPreco * PRE->PERDES ) / 100 )
*                                                 MPr->UNIDAD,  ;
*                                                 MPr->IPI___,  ;
*                                                 MPR->ORIGEM + "           ",;
                                AAdd( aPedido, { MPR->CodFab,  ;
                                                 MPR->Descri,  ;
                                                 nPrecoInicial,;
                                                 nPerDesconto, ;
                                                 nPrecoFinal,  ;
                                                 nQuantidade,  ;
                                                 cUnidade,  ;
                                                 nPerIpi,  ;
                                                 cOrigem + "           ",;
                                                 "Sim",;
                                                 Val( MPR->INDICE ),;
                                                 MPR->PRECOV,;
                                                 nPreco,;
                                                 PRE->CODIGO,;
                                                 PRE->DESCRI,;
                                                 CND->CODIGO,;
                                                 nClasse,;
                                                 nTamCod,;
                                                 nCorCod,;
                                                 ,;
                                                 cDetal1,;
                                                 cDetal2,;
                                                 cDetal3,;
                                                 dDtentre } )
                             ENDIF
                          ELSEIF nPosicao > 0
                             aPedido[ nPosicao ][ 3 ]:= nPrecoInicial
                             aPedido[ nPosicao ][ 4 ]:= nPerDesconto
                             aPedido[ nPosicao ][ 5 ]:= nPrecoFinal
                             aPedido[ nPosicao ][ 6 ]:= nQuantidade
                             aPedido[ nPosicao ][ 9 ]:= cOrigem
                             aPedido[ nPosicao ][ 8 ]:= nPerIpi
                             aPedido[ nPosicao ][ 21 ]:= cDetal1
                             aPedido[ nPosicao ][ 22 ]:= cDetal2
                             aPedido[ nPosicao ][ 23 ]:= cDetal3
                             aPedido[ nPosicao ][ 24 ]:= dDtentre
                          ENDIF
                       ENDIF
                    ENDIF
                    DBUnlock()
                    IF ! lAltera .AND. MPR->MPRIMA == "N"      /* Produto novo na lista */
                       IF Confirma( 00, 00, "Produto Montado! Deseja abrir as partes deste produto?", "Digite [S]im ou [N]ao.", "N" )
                          nAreaRes:= Select()
                          DBSelectAr( _COD_ASSEMBLER )
                          DBSeek( MPR->INDICE )
                          WHILE MPR->INDICE == CODPRD
                             /* Calculo do preco de p/ tabela */
                             nPreco:= MPR->PRECOV + ( ( MPR->PRECOV * PRE->PERACR ) / 100 )
                             nPreco:= nPreco - ( ( nPreco * PRE->PERDES ) / 100 )
                             AAdd( aPedido, { CodFab,  ;
                                              Descri,  ;
                                              0,;
                                              0, ;
                                              0,  ;
                                              nQuantidade * QUANT_,  ;
                                              UNIDAD,  ;
                                              PERIPI,  ;
                                              SPACE( 3 ) + "           ",;
                                              "Sim",;
                                              Val( CODPRD ),;
                                              MPR->PRECOV,;
                                              nPreco,;
                                              PRE->CODIGO,;
                                              PRE->DESCRI,;
                                              CND->CODIGO,;
                                              nClasse,;
                                              nTamCod,;
                                              nCorCod,;
                                              ,;
                                              cDetal1,;
                                              cDetal2,;
                                              cDetal3,;
                                              dDtentre  } )
                             DBSkip()
                          ENDDO
                          DBSelectAr( nAreaRes )
                       ENDIF
                    ENDIF
                 ENDIF
              ENDIF
              SetColor( _COR_BROWSE )
              ScreenRest( cTelaReserva )

         case nTECLA=K_INS
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 )
              VPBox( 08, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
              SetColor( _COR_GET_EDICAO )
              nPrecoInicial:= 0
              nPerDesconto:=  0
              nPrecoFinal:= 0.00
              nQuantidade:= 0
              cOrigem:= Space( 14 )
              cCodFab:= Space( Len( MPR->CodFab ) )
              cDescricao:= Space( _ESP_DESCRICAO )
              cUnidade:= Space( 2 )
              cDetal1:= Space( 65 )
              cDetal2:= Space( 65 )
              cDetal3:= Space( 65 )
              dDtentre := space(10)
              nUnidades:= 0
              nPerIpi:= 0
              lAltera:= .F.
              SetCursor(1)
              @ 09,12 Say "Produto....:" Get cCodFab Pict "@!"
              @ 10,12 Say "Descri‡„o..:" Get cDescricao Pict "@!"
              @ 11,12 Say "Fabrica....:" Get cOrigem Pict "XXXXXXXXXXXXXX"           When CodFabrica() .AND. Mensagem( "Digite o fabricante." )
              @ 12,12 Say "Pre‡o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco() .AND. Mensagem( "Digite o novo preco de venda." )
              @ 13,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
              @ 14,12 Say "Pre‡o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
              @ 15,12 Say "% IPI......:" Get nPerIpi Pict "@E 999.99"
              @ 16,12 Say "Unidade....:" Get cUnidade Pict "!!"
              IF SWSet( _PED_DTENTREGA )
                 @ 17,12 Say "Entrega....:" Get dDtentre pict "@!"
              ENDIF
              VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
              @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
              Read

              /* Se estiver preenchido DETALHE 1, 2 ou 3 Edita */
              IF SWSet( _PED_DETALHE )
                 cTelaR5:= ScreenSave( 0, 0, 24, 79 )
                 VPBox( 08, 10, 20, 70, "DETALHAMENTO DE INFORMACOES", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 nCursorRes:= SetCursor( 1 )
                 @ 12,12 Say MPR->CODFAB
                 @ 13,12 Say MPR->DESCRI
                 /*--------------------------------------------------*/
                 @ 15,12 Say "Detalhamento"
                 @ 16,11 Get cDetal1 Pict "@S56"
                 @ 17,11 Get cDetal2 Pict "@S56"
                 @ 18,11 Get cDetal3 Pict "@S56"
                 READ
                 SetCursor( nCursorRes )
                 ScreenRest( cTelaR5 )
              ENDIF

              IF LastKey() <> K_ESC
                 nClasse:= 0 //aqui
                 nTamCod:= 0
                 nCorCod:= 0
                 AAdd( aPedido, { cCodFab, ;
                                  cDescricao, ;
                                  nPrecoInicial, ;
                                  nPerDesconto, ;
                                  nPrecoFinal, ;
                                  nQuantidade, ;
                                  cUnidade, ;
                                  nPerIpi, ;
                                  cOrigem,;
                                  "Sim",;
                                  0,;
                                  nPrecoInicial,;
                                  nPrecoInicial,;
                                  PRE->CODIGO,;
                                  PRE->DESCRI,;
                                  CND->CODIGO,;
                                  nClasse,;
                                  nTamCod,;
                                  nCorCod,;
                                  ,;
                                  cDetal1,;
                                  cDetal2,;
                                  cDetal3,;
                                  dDtentre } )
              ENDIF
              ScreenRest( cTelaReserva )
         otherwise                ;tone(125); tone(300)
         endcase
         oProd:Refreshcurrent()
         oProd:Stabilize()
     enddo
     SetColor( cCor )
     SetCursor( nCursor )
     ScreenRest( cTela )
     Return( .T. )

/*
* Modulo       - CalculoDesconto
* Finalidade   - Calcular o desconto.
* Programador  - Valmor Pereira Flores
* Data         - 26/Outubro/1995
* Atualizacao  -
*/
Function CalculaDesconto( GetList, nPrecoInicial, nPerDesconto, nPrecoFinal )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
   IF nPerDesconto > SWSet( _PED_MAXDESCONTO )
      Aviso( "Desconto m ximo permitido ‚ de " + StrZero( SWSet( _PED_MAXDESCONTO ), 2, 0 ) + "%.", 12 )
      Pausa()
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return .F.
   ENDIF
   /* Calcula o desconto */
   nPrecoFinal:= nPrecoInicial - ( ( nPrecoInicial * nPerDesconto ) / 100 )
   FOR nCt:= 1 TO Len( GetList )
       GetList[ nCt ]:Display()
   NEXT
   Return( .T. )

/*
* Modulo       - CalculoDesconto
* Finalidade   - Calcular o desconto.
* Programador  - Valmor Pereira Flores
* Data         - 26/Outubro/1995
* Atualizacao  -
*/
Function VerifPerDesc( GetList, nPrecoInicial, nPerDesconto, nPrecoFinal )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
   nPerDesconto:= 100 - ( ( nPrecoFinal / nPrecoInicial ) * 100 )
   IF nPerDesconto > SWSet( _PED_MAXDESCONTO )
      Aviso( "Desconto m ximo permitido ‚ de " + StrZero( SWSet( _PED_MAXDESCONTO ), 2, 0 ) + "%...", 12 )
      Pausa()
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return .F.
   ENDIF
   FOR nCt:= 1 TO Len( GetList )
       GetList[ nCt ]:Display()
   NEXT
   Return( .T. )




/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ LIMPAMARCAS
³ Finalidade  ³ Limpar as marcas deixadas pelo PEDIDO
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 26/Outubro/1995
³ Atualizacao ³ 16/Novembro/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function LimpaMarcas( aPedidos )
Local nCt, nOrdem:= Mpr->( IndexOrd() ), aPrBloqueados:= {}, nRegistro:= MPr->( Recno() ),;
      nArea:= Select()
IF !Empty( aPedidos )
   Mensagem( "Aguarde, limpando os produtos marcados..." )
   DBSelectAr( _COD_MPRIMA )
   DBSetOrder( 1 )
   For nCt:= 1 To Len( aPedidos )
       DBSeek( PAD( StrZero( aPedidos[ nCt ][ 11 ], 7, 0 ), 12 ) )
       IF !Eof()
          IF RLock()
             Replace MPr->Marca_ With " "
          ELSE
             Mensagem("Imposs¡vel desmarcar o produto: " + aPedidos[ nCt ][ 1 ] + "..." )
             AAdd( aPrBloqueados, aPedidos[ nCt ][ 1 ] )
          ENDIF
          DBUnlock()
       ENDIF
   Next
   MPR->( DBSetOrder( nOrdem ) )
   MPR->( DBGoto( nRegistro ) )
   DBSelectAr( nArea )
ENDIF
IF !Empty( aPrBloqueados )
   Mensagem( ">>>" + STRZero( Len( aPrBloqueados ), 2, 0 ) + " do(s) " + STRZero( Len( aPedidos ), 2, 0 ) + " produto(s) n„o foram desmarcado(s)..." )
   Pausa()
ENDIF
/* Zera a Matriz de Produtos */
aPedidos:= {}
Return Nil


Function DisplayIPI( nPrecoFinal )
Local nValorIpi:= ( ( nPrecoFinal * MPr->IPI___ ) / 100 )
   @ 16,12 Say "% IPI......: [" + Tran( MPr->IPI___, "@E 999.99" ) + "]"
   @ 17,12 Say "Valor IPI..: [" + Tran( nValorIpi, "@E 999,999.99" ) + "]"
   Return nValorIpi

/*
* Modulo      - COTACAO
* Parametro   - Nenhum
* Finalidade  - Verificacao & manutencao de cotacao quando ainda nao
*               esta gravada em arquivo, ESTA SOMENTE NA MEMORIA.
* Programador - Valmor Pereira Flores
* Data        - 26/Outubro/1995
* Atualizacao - Junho/2001 - Acrescimo & Desconto
*/
Func Cotacao( aPedido )
Loca nAreaRes:= Select(), nOrdemRes:= IndexOrd()
Loca oTb, cCor:= SetColor(), cScreen:= SaveScreen( 0, 0, 24, 79 ),;
     cTela, nRow:=1,;
     nSubTotal:= 0, nTotal:= 0, nIPI:= 0, nCt:= 0,;
     cPrazo_:= Space( 10 ), nValid_:= 0, cCondi_:= Space(15),;
     aOCompra:= {}, cPctDif:= "N", cPerDif:= Space(1), aPerDif:={0,0,0,0,0,0,0,0,0,0,0},;
     cFrete_:= Space( 15 ),;
     cObser1:= Space( 76 ), cObser2:= Space( 76 ),;
     nCodTra:= 0, cVende1:= cVende2:= Space( 12 ), nPerIpi:= 0, nVlrTot:= 0
Local cTelaRes
Local lCor:= .F., lClasse:= .F.
Priv cTama
   DispBegin()
   SetColor( _COR_BROWSE )
   VPBox( 0, 0, 22, 79, "Cotacao (Pendente)", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. )
   @ 1, 1 Say "Pedido.....: "
   @ 2, 1 Say "Codigo.....: " + StrZero( CLI->Codigo, 6, 0 )
   @ 3, 1 Say "Cliente....: " + Cli->Descri
   @ 4, 1 Say "Endere‡o...: " + Cli->Endere
   @ 5, 1 Say "Cidade.....: " + Cli->Cidade
   @ 6, 1 Say "Contato....: " + Cli->Compra
   @ 7, 1 Say "Fone/Fax...: " + Cli->Fone1_ + " / " + Cli->Fax___
   @ 8, 1 Say "Transport..: " + StrZero( Cli->Transp, 3, 0 )
   SetColor( _COR_BROW_TITULO )
   Scroll( 9, 0, 9, 79 )
   @ 09, 01 Say "Produto"
   @ 09, 33 Say "Un"
   @ 09, 37 Say "Quantidade"
   @ 09, 53 Say "Preco Unit rio"
   @ 09, 68 Say "%IPI"
   Janela( 4 )
   DispEnd()
   CalculoGeral( aPedido, CND->PERACR, CND->PERDES )
   SetCursor( 0 )
   Mensagem("[F7]Condicoes [ESPACO]Seleciona, [ENTER]Altera [G]Gravar [V]V.Inf [ESC]Sai")
   Ajuda( "[ESPACO]Marca/Desmarca [G]Grava" )
   SetColor( _COR_BROWSE )
   oTb:=TBrowseNew( 10, 1, 20, 78 )
   oTb:addcolumn(tbcolumnnew(,{|| Left( aPedido[ nRow ][ 1 ] + "-" + ;
                                        aPedido[ nRow ][ 2 ], 30 ) + ;
                                   " ³ " + aPedido[ nRow ][ 7 ] + " ³ " +;
                                     Tran( aPedido[ nRow ][ 6 ], "@E 9,999,999.99" ) + " ³ " +;
                                     Tran( aPedido[ nRow ][ 5 ], "@E 9999,999.999" ) + " ³ " +;
                                     Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )       +  " ³" + aPedido[ nRow ][ 10 ] }))
   oTb:AUTOLITE:=.f.
   oTb:GOTOPBLOCK :={|| nRow:= 1}
   oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aPedido ) }
   oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPedido,@nRow)}
   oTb:dehilite()

   /* Verificacao do Saldo do Cliente */
   nIpi:= 0
   nTotal:= 0
   nSubTotal:= 0
   For nCt:= 1 To Len( aPedido )
       IF aPedido[ nCt ][ 10 ] == "Sim"
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ]
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
       ENDIF
   Next
   nTotal:= nSubTotal + nIPI
   oTb:RefreshAll()
   WHILE !oTb:Stabilize()
   ENDDO
   SaldoCliente( CLI->CODIGO, nTotal )

   nAreaRes:= Select()
   /* Cor & Classe */
   DBSelectAr( "COR" )
   IF USED()
      lCor:= .T.
      COR->( DBSetOrder( 1 ) )
   ENDIF
   DBSelectAr( "CLA" )
   IF USED()
      lClasse:= .T.
      CLA->( DBSetOrder( 1 ) )
   ENDIF
   DBSelectAr( nAreaRes )

   WHILE .T.
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
      whil nextkey()==0 .and. ! oTb:stabilize()
      end

      /* Display nome do produto */
      SetColor( "W+/G" )
      @ 21,33 Say PadC( Alltrim( aPedido[ nRow ][ 2 ] ) + " - " + Left( aPedido[ nRow ][ 9 ], 3 ), 45, " " )

      /* Exibicao das propriedades do produto */
      IF !( aPedido[ nRow ][ 18 ] == 0 )
         IF lCor
            COR->( DBSeek( aPedido[ nRow ][ 19 ] ) )           /* cor */
         ENDIF
         IF lClasse
            CLA->( DBSeek( aPedido[ nRow ][ 17 ] ) )           /* classe */
         ENDIF
         cTama:= StrZero( aPedido[ nRow ][ 18 ] - 1, 2, 0 )    /* posicao do tamanho */
         cTama:= IF( cTama=="**", "00", cTama )
         Scroll( 06, 40, 06, 78 )
         IF lClasse .AND. lCor
            @ 06,40 Say LEFT( CLA->DESCRI, 18 ) + " " + LEFT( COR->DESCRI, 18 ) + " <" + Alltrim( CLA->TAMA&cTama ) + ">"
         ENDIF
      ENDIF

      @ 06,40 Say "Valor Total Item: " + TRAN( aPedido[ nRow ][ 5 ] * aPedido[ nRow ][ 6 ], "@E 999,999.99" )
      @ 07,40 Say "Tabela: " + aPedido[ nRow ][ 15 ]
      @ 08,40 Say "Cond..: " + CND->DESCRI
      SetColor( _COR_BROWSE )

      cTelaR6:= ScreenSave( 0, 0, 24, 79 )
      WHILE ( nTecla:= Inkey( 2 ) )==0
          IF SWSet( _PED_DETALHE )
             VPBox( 10, 03, 15, 75, "Detalhamento do Produto", _COR_GET_BOX )
             @ 11,05 Say aPedido[ nRow ][ 21 ] Color _COR_GET_EDICAO
             @ 12,05 Say aPedido[ nRow ][ 22 ] Color _COR_GET_EDICAO
             @ 13,05 Say aPedido[ nRow ][ 23 ] Color _COR_GET_EDICAO
          ENDIF
      ENDDO
      ScreenRest( cTelaR6 )

      IF nTecla==K_ESC   ;exit   ;ENDIF
      do case
         case nTecla==K_F7
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
              TabelaCondicoes( nTotal )
              CalculoGeral( aPedido, CND->PERACR, CND->PERDES )

         case nTecla==K_F12        ;Calculador()
         case nTecla==K_UP         ;oTb:up()
         case nTecla==K_DOWN       ;oTb:down()
         case nTecla==K_LEFT       ;oTb:up()
         case nTecla==K_RIGHT      ;oTb:down()
         case nTecla==K_PGUP       ;oTb:pageup()
         case nTecla==K_CTRL_PGUP  ;oTb:gotop()
         case nTecla==K_PGDN       ;oTb:pagedown()
         case nTecla==K_CTRL_PGDN  ;oTb:gobottom()
         case Chr( nTecla ) $ "Vv"
              nRecCli:= CLI->( RECNO() )
              DispEstat()
              CLI->( DBGoTo( nRecCli ) )

         case Chr( nTecla ) $ "Gg" .OR. nTecla==K_CTRL_G .OR. nTecla==K_CTRL_N
              nTC:= nTecla
              IF SWSet( _PED_LIMITECREDITO )
                 IF SWSet( _PED_COTACAOVERCR )
                    IF !VerificaLimiteCr( aPedido )
                       Loop
                    ENDIF
                 ENDIF
              ENDIF
              nArea:= Select()
              cCorRes:= SetColor()
              nCursorRes:= SetCursor()
              Aviso("Gerando Cotacao.", 24 / 2 )
              Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...")
              VPBox( 03, 04, 21, 75, , _COR_GET_BOX, .T., .T., _COR_GET_TITULO )
              SetColor( _COR_GET_EDICAO )
              SetCursor( 1 )
              Set( _SET_DELIMITERS, .F. )
              nCodTra:= Cli->Transp
              nVenin1:= Cli->Venin1
              nVenEx1:= Cli->VenEx1
              IF ! AllTrim( SWSet( _PED_VENDINTERNO ) ) == ""
                 cVende1:= PAD( SWSet( _PED_VENDINTERNO ), 12 )
                 cVende2:= PAD( SWSet( _PED_VENDEXTERNO ), 12 )
              ENDIF
              nTabCnd:= CND->CODIGO
              cCompra:= CLI->COMPRA
              nTabOpe:= OPE->CODIGO
              dDataEntrega:= DATE()
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

              @ 04,06 Say "Contato (Nome)............:" Get cCompra Pict "@!"
              @ 05,06 Say "Codigo da Transportadora..:" Get nCodTra Pict "999" Valid BuscaTransport( @nCodTra ) When Mensagem( "Digite o codigo da transportadora ou [F9] para ver lista." )
              @ 06,06 Say "Prazo de Entrega (EM DIAS):" Get cPrazo_ When Mensagem( "Digite o prazo de entrega desta mercadoria." )
              @ 07,06 Say "Validade da Proposta......:" Get nValid_ When Mensagem( "Digite o prazo de validade desta proposta em numero de dias." )
              @ 08,06 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
              @ 09,06 Say "Operacao..................:" Get nTabOpe Pict "999" Valid BuscaOperacao( @nTabOpe )
              @ 10,06 Say "Tabela de Condicoes.......:" Get nTabCnd Pict "9999" Valid BuscaCondicao( @nTabCnd, @cCondi_, nTotal )
              @ 11,06 Say "Detalhamento de Condicoes.:" Get cCondi_
              @ 12,06 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
              @ 13,06 Say "Tipo de Frete.............:" Get cFrete_ valid DisplayFrete( @cFrete_ ) When Mensagem( "Digite o tipo de frete ou [ENTER] para ver opcoes." )
              @ 14,06 Say "Vendedor Interno..........:" Get nVenIn1 Pict "@R 999" valid VenSeleciona( @nVenIn1, 1, @cVende1 ) When Mensagem( "Digite o codigo do vendedor interno.")
              @ 14,40 Get cVende1 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." )
              @ 15,06 Say "Vendedor Externo..........:" Get nVenEx1 Pict "@R 999" Valid VenSeleciona( @nVenEx1, 2, @cVende2 ) When Mensagem( "Digite o codigo do vendedor interno.")
              @ 15,40 Get cVende2 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." )
              @ 16,06 Say "ObservacoesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
              @ 17,06 Get cObser1 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." )
              @ 18,06 Get cObser2 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." )
              @ 19,06 Say "Complemento Nota Fiscal...:"
              @ 20,06 Say "Data do Pedido/Entrega....:" Get dDataEntrega
              Read
              EditaPlaca()

              VPBox( 08, 14, 21, 72, , _COR_GET_BOX, .T., .T., _COR_GET_TITULO )
              SetColor( "15/02" )
              @ 09,15 Say " Item                           No.Oc   Entrega "
              SetColor( _COR_GET_EDICAO )
              FOR nCt:= 1 To Len( aPedido )
                  @ 10 + nCt, 15 Say StrZero( nCt, 3, 0 ) +;
                         " - " + aPedido[ nCt ][ 1 ]
                  If nCt >= 9
                     Exit
                  Endif
              NEXT
              FOR nCt:= 1 To Len( aPedido )
                  AAdd( aOCompra, { Space( 6 ), 0, Space( 6 ) } )
                  IF nCt <= Len( aPedido )
                     aOCompra[ nCt ][ 2 ]:= aPedido[ nCt ][ 6 ]
                  ENDIF
                  @ 10 + nCt, 15 Say StrZero( nCt, 3, 0 )
                  @ 10 + nCt, 45 Get aOCompra[ nCt ][ 1 ]
                  //@ 10 + nCt, 54 Get aOCompra[ nCt ][ 2 ] Pict "999999"
                  @ 10 + nCt, 54 Get aOCompra[ nCt ][ 3 ]
                  /* Se ultrapassar 12, sair */
                  If nCt >= 9
                     EXIT
                  EndIf
              NEXT
              READ

              Set( _SET_DELIMITERS, .T. )
              DBSelectar( _COD_PEDIDO )
              IF CodigoReserva <> Nil
                 cCodigo:= CodigoReserva
              ELSE
                 cCodigo:= "< ERRO >"
              ENDIF
              SetColor( cCorRes )
              SetCursor( nCursorRes )

              /* fecha tudo */
              DBSelectAr( _COD_PEDIDO )
              FechaArea()

              DBSelectAr( _COD_PEDPROD )
              FechaArea()

              IF !AbreGrupo( "PEDIDOS_MAIN" )
                 Return Nil
              ENDIF
              DBSelectAr( _COD_PEDIDO )
              DBSetOrder( 1 )

              /* busca o codigo */
              IF !DBSeek( cCodigo )
                 DBAppend()
                 If !NetErr()
                    Replace CODIGO With cCodigo
                 Endif
              ENDIF

              IF cPctDif == "S"     /* Se foi informado percentuais diferenciados */
                 FOR nCt:= 1 To Len( aPerDif )
                     cPerDif:= cPerDif + "/"
                 NEXT
                 cPerDif:= Left( cPerDif, Len( cPerDif ) - 1 )
              ENDIF

              nVlrTot:= 0
              FOR nCt:= 1 TO Len( aPedido )
                  IF aPedido[ nCt ][ 10 ]=="Sim"
                     nVlrIpi:= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
                     nVlrTot:= nVlrTot + nVlrIpi + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] )
                  ENDIF
              NEXT

              /* Calculo de VLRTOT via funcao CalculoGeral */
              CND->( DBSetOrder( 1 ) )
              IF CND->( DBSeek( nTabCnd ) )
                 nVlrTot:= CalculoGeral( aPedido, CND->PERACR, CND->PERDES )
              ENDIF

              /* grava as informacoes do pedido */
              IF NetRLock()
                 Replace CodCli With Cli->Codigo,;
                         Descri With Cli->Descri,;
                         Endere With Cli->Endere,;
                         Bairro With Cli->Bairro,;
                         Cidade With Cli->Cidade,;
                         Estado With Cli->Estado,;
                         FANTAS With Cli->Fantas,;
                         Compra With cCompra,;
                         Cobran With Cli->Cobran,;
                         CGCMf_ With Cli->CGCMf_,;
                         Inscri With Cli->Inscri,;
                         Transp With nCodTra,;
                         FonFax With Cli->Fone1_ + " / " + Cli->Fax___,;
                         CodCep With Cli->CodCep,;
                         VenIn1 With nVenIn1,;
                         VenEx1 With nVenEx1,;
                         Select With "Nao",;
                         Data__ With dDataEntrega,;
                         Situa_ With "COT",;
                         Condi_ With cCondi_,;
                         PerDif With cPerDif,;
                         Frete_ With cFrete_,;
                         Obser1 With cObser1,;
                         Obser2 With cObser2,;
                         Prazo_ With cPrazo_,;
                         Valid_ With nValid_,;
                         Vende1 With cVende1,;
                         Vende2 with cVende2,;
                         VlrTot With nVlrTot,;
                         TabCnd With nTabCnd,;
                         TabOpe With nTabOpe,;
                         DataEm With DATE()

                 /* Tabela de condicoes - Grava % de desconto ou acrescimo */
                 CND->( DBSetOrder( 1 ) )
                 CND->( DBSeek( nTabCnd ) )
                 Replace PERDES With CND->PERDES,;
                         PERACR With CND->PERACR

                 IF EMPTY( CONDI_ )
                    CND->( DBSetOrder( 1 ) )
                    IF CND->( DBSeek( nTabCnd ) )
                       Replace CONDI_ With StrZero( CND->PARCA_, 3, 0 )
                    ENDIF
                 ENDIF

                 /* Repassando os campos */
                 FOR nCt:= 1 TO Len( aOCompra )
                     Eval( FieldBlock( "OC__" + StrZero( nCt, 2, 0 ) ), aOCompra[ nCt ][ 1 ] )
                     Eval( FieldBlock( "QTD_" + StrZero( nCt, 2, 0 ) ), aOCompra[ nCt ][ 2 ] )
                     Eval( FieldBlock( "ENT_" + StrZero( nCt, 2, 0 ) ), aOCompra[ nCt ][ 3 ] )
                 NEXT
              ENDIF
              DBUnlock()


              Mensagem( "Gravando arquivo de produtos por PEDIDOS/COTACOES, aguarde..." )
              MPR->( DBSetOrder( 1 ) )
              DBSelectar( _COD_PEDPROD )
              FOR nCt:= 1 TO Len( aPedido )
                 /* Calculo do preco de p/ tabela */
                 MPR->( DBSeek( PAD( StrZero( aPedido[ nCt ][ 11 ], 7, 0 ), 12 ) ) )
                 nPreco:= MPR->PRECOV + ( ( MPR->PRECOV * PRE->PERACR ) / 100 )
                 nPreco:= nPreco - ( ( nPreco * PRE->PERDES ) / 100 )
                 DBSelectar( _COD_PEDPROD )
                 IF aPedido[ nCt ][ 10 ]=="Sim"
                    DBAppend()
                    IF NetRLock()
                       Repl Codigo With cCodigo,;
                            CodPro With aPedido[ nCt ][ 11 ],;
                            CodFab With aPedido[ nCt ][ 1 ],;
                            Descri With aPedido[ nCt ][ 2 ],;
                            VlrIni With aPedido[ nCt ][ 3 ],;
                            PerDes With aPedido[ nCt ][ 4 ],;
                            VlrUni With aPedido[ nCt ][ 5 ],;
                            Quant_ With aPedido[ nCt ][ 6 ],;
                            Unidad With aPedido[ nCt ][ 7 ],;
                            Origem With aPedido[ nCt ][ 9 ],;
                            Select With aPedido[ nCt ][ 10 ],;
                            IPI___ With aPedido[ nCt ][ 8 ],;
                            Preco1 With aPedido[ nCt ][ 12 ],;
                            Preco2 With aPedido[ nCt ][ 13 ],;
                            TabPre With aPedido[ nCt ][ 14 ],;
                            DesPre With aPedido[ nCt ][ 15 ],;
                            TabCnd With aPedido[ nCt ][ 16 ],;
                            PCPCLA With aPedido[ nCt ][ 17 ],;
                            PCPTAM With aPedido[ nCt ][ 18 ],;
                            PCPCOR With aPedido[ nCt ][ 19 ],;
                            DTENTR With aPedido[ nCt ][ 24 ],;
                            EXIBIR With IF( nCt <= 1, "S", " " )

                       IF (!EMPTY( aPedido[ nCt ][ 21 ] )  .or.;      && Detalhamentos
                           !EMPTY( aPedido[ nCt ][ 22 ] )  .or.;
                           !EMPTY( aPedido[ nCt ][ 23 ] )) .and. SWSet( _PED_DETALHE )
                          DET->( DBAppend() )
                          IF DET->( NetRLock() )
                             Replace DET->INDICE With STRZERO( aPedido[ nCt ][ 11 ], 7, 0 ),;
                                     DET->DETAL1 With aPedido[ nCt ][ 21 ],;
                                     DET->DETAL2 With aPedido[ nCt ][ 22 ],;
                                     DET->DETAL3 With aPedido[ nCt ][ 23 ],;
                                     DET->ORDEM_ With nCt,;
                                     DET->CODPED With cCodigo
                          ENDIF
                       ENDIF
                    ENDIF
                 ENDIF
              NEXT
              For nCt:= Len( aPedido ) + 1 TO Len( aOCompra )
                  IF ! ( aOCompra[ nCt ][ 1 ] == Space( 6 ) ) .AND.;
                     ! ( aOCompra[ nCt ][ 2 ] == 0 )
                     DBAppend()
                     IF NetRLock()
                        Replace Codigo With cCodigo
                     ENDIF
                  ENDIF
              Next
              Mensagem("Desmarcando produtos, aguarde...")
              LimpaMarcas( aPedido )
              aPedido:= { NIL }

              SWSet( 5000, .T. )

              DBSelectar( nArea )

              Aviso( "Foi gravada a cotacao de numero: " + cCodigo + "...", 24 / 2 )
              Mensagem( "Pressione [ENTER] para continuar..." )
              Pausa()
              KeyBoard Chr( K_ESC ) + Chr( K_ESC )
              IF nTC==K_CTRL_G .OR. nTC==K_CTRL_N
                 SWSet( _INT_GRAVAPEDIDO, .T. )
                 IF nTC==K_CTRL_N
                    SWSet( _INT_GRAVANOTA, .T. )
                 ENDIF
              ENDIF

              /* Limpa pedido */
              aPedido:= 0
              aPedido:= {}
              DBUnlockAll()
              Exit

         case nTecla==K_SPACE
              aPedido[ nRow ][ 10 ]:= IF( aPedido[ nRow ][ 10 ]=="Sim", "Nao", "Sim" )
              CalculoGeral( aPedido, CND->PERACR, CND->PERDES )

         case nTecla==K_ENTER
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 )
              VPBox( 08, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
              SetColor( _COR_GET_EDICAO )
              nPrecoInicial:= aPedido[ nRow ][ 3 ]
              nPerDesconto:= aPedido[ nRow ][ 4 ]
              nPrecoFinal:= aPedido[ nRow ][ 5 ]
              nQuantidade:= aPedido[ nRow ][ 6 ]
              nPerIpi:= aPedido[ nRow ][ 8 ]
              cOrigem:= aPedido[ nRow ][ 9 ]
              cUnidade:= aPedido[ nRow ][ 7 ]
              cDetal1:=  aPedido[ nRow ][ 21 ]
              cDetal2:=  aPedido[ nRow ][ 22 ]
              cDetal3:=  aPedido[ nRow ][ 23 ]
              dDtentre:=  aPedido[ nRow ][ 24 ]
              cDescri:=  aPedido[ nRow ][ 2 ]
              SetCursor(1)

              IF SWSet( _PED_DETALHE )
                 /* Edicao do Detalhamento */
                 @ 10,12 Say cDescri
                 @ 12,12 Say "Detalhamento"
                 @ 13,12 Get cDetal1 Pict "@S55"
                 @ 14,12 Get cDetal2 Pict "@S55"
                 @ 15,12 Get cDetal3 Pict "@S55"
                 READ

                 Scroll( 09, 11, 19, 69, 0 )
              ENDIF

              @ 09,12 Say "Produto....:" Get aPedido[ nRow ][ 1 ]
              @ 10,12 Say "Descri‡„o..:" Get aPedido[ nRow ][ 2 ]
              Read
              @ 11,12 Say "Fabricante.:" Get cOrigem Pict "XXXXXXXXXXXXXX"           When CodFabrica() .AND. Mensagem( "Digite o fabricante." )
              @ 12,12 Say "Pre‡o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco() .AND. Mensagem( "Digite o novo preco de venda." )
              @ 13,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
              @ 14,12 Say "Pre‡o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
              @ 15,12 Say "% IPI......:" Get nPerIpi       Pict "@E 999.99"
              @ 16,12 Say "Unidade....:" Get cUnidade Pict "!!"
              IF SWSet( _PED_DTENTREGA )
                 @ 17,12 Say "Entrega....:" Get dDtentre pict "@!"
              ENDIF
              IF SWSet( _PED_FORMATO ) = 5 // METAIS DAR
                 @ 17,37 Say "Unidades...:" Get nUnidades pict "9999.99" valid F_CalUnixQuan(nUnidades,@nQuantidade)
              ENDIF
              VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
              @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
              Read
              IF LastKey() <> K_ESC .AND. UpDated()
                 aPedido[ nRow ][ 10 ]:= "Sim"
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial
                 aPedido[ nRow ][ 4 ]:= nPerDesconto
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal
                 aPedido[ nRow ][ 6 ]:= nQuantidade
                 aPedido[ nRow ][ 7 ]:= cUnidade
                 aPedido[ nRow ][ 9 ]:= cOrigem
                 aPedido[ nRow ][ 8 ]:= nPerIpi
                 aPedido[ nRow ][ 21 ]:= cDetal1
                 aPedido[ nRow ][ 22 ]:= cDetal2
                 aPedido[ nRow ][ 23 ]:= cDetal3
                 aPedido[ nRow ][ 24 ]:= dDtentre
              ENDIF
              ScreenRest( cTelaReserva )
              SetColor( _COR_BROWSE )
              CalculoGeral( aPedido, CND->PERACR, CND->PERDES )
         otherwise                ;tone(125); tone(300)
      endcase
      oTb:refreshcurrent()
      oTb:stabilize()
   enddo
   setcursor(1)
   setcolor(cCor)
   restscreen(00,00,24,79,cScreen)
   DBSelectAr( nAreaRes )
   DBSetOrder( nOrdemRes )
   return(IF(nTecla=27,.f.,.t.))

Function BuscaOperacao( nCodOpe )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
IF !nCodOpe == 0
   TabelaOperacoes( @nCodOpe )
   @ 09,40 Say LEFT( OPE->DESCRI, 30 )
   IF !OPE->TABPRE == PRE->CODIGO .AND. !OPE->TABPRE == 999
      Aviso( "Tabela de precos diferente nesta operacao!" )
      Pausa()
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return .F.
   ENDIF
ELSE
   @ 09,40 Say PAD( "<VENDA> - FORMATO ESPECIAL", 30 )
ENDIF
Return .T.

Function BuscaCondicao( nCodCnd, cCondicao, nValorTotal )
IF nCodCnd == 0
   @ 10,40 Say PAD( "<VENDA> - CONDICAO ESPECIAL", 30 )
ELSE
   IF nCodCnd <> Nil
      SWSet( _INT_CONDICOES, nCodCnd )
   ENDIF
   TabelaCondicoes( nValorTotal )
   nCodCnd:= CND->CODIGO
   @ 10,40 Say left( CND->DESCRI, 30 )
   cCondicao:= ALLTRIM( Str( CND->PARCA_, 3, 0 ) )
   FOR nCt:= 66 TO 88
       IF !CND->( EVAL( FieldBlock( "PARC" + Chr( nCt ) + "_" ) ) ) == 0
          cCondicao+= "/" + CND->( ALLTRIM( Str( EVAL( FieldBlock( "PARC" + Chr( nCt ) + "_" ) ), 3, 0 ) ) )
       ENDIF
   NEXT
   cCondicao:= PAD( cCondicao, 30 )
ENDIF
Return .T.

FUNCTION DisplayFrete( cFrete_ )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), nOpcao:= SWSet( _PED_TIPOFRETE )
IF EMPTY( cFrete_ ) .OR. Left( cFrete_, 4 ) == "9999"
   VPBox( 05, 30, 10, 60, " TIPO DE FRETE ", _COR_BROW_BOX )
   SetColor( _COR_BROW_BOX )
   @ 06,31 Prompt " 1->EMITENTE                 "
   @ 07,31 Prompt " 2->DESTINATARIO             "
   @ 08,31 Prompt " 3->CIF                      "
   @ 09,31 Prompt " 4->FOB                      "
   Menu To nOpcao
   DO CASE
      CASE nOpcao == 1
           cFrete_:= PAD( "1>-EMITENTE", LEN( cFrete_ ) )
      CASE nOpcao == 2
           cFrete_:= PAD( "2>-DESTINATARIO", LEN( cFrete_ ) )
      CASE nOpcao == 3
           cFrete_:= PAD( "1>-CIF", LEN( cFrete_ ) )
      CASE nOpcao == 4
           cFrete_:= PAD( "2>-FOB", LEN( cFrete_ ) )
   ENDCASE
ENDIF
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return .T.


/*
* Modulo      - CalculoGeral
* Finalidade  - Apresentar no rodap‚ o calculo total do pedido
* Programador - Valmor Pereira Flores
* Data        - 26/Outubro/1995
* Atualizacao -
*/
Function CalculoGeral( aPedido, nPerAcr, nPerDes )
Local cCor:= SetColor()
Local nSubTotal:= 0, nIPI:= 0, nTotal:= 0, nDesconto:= 0, nAcrescimo:= 0
   DispBegin()
   SetColor( "W+/G" )
   Scroll( 21, 1, 22, 78 )
   For nCt:= 1 To Len( aPedido )
       IF aPedido[ nCt ][ 10 ] == "Sim"
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ]
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
       ENDIF
   Next
   IF nPerAcr <> Nil
      nAcrescimo:= ( nSubTotal * ( nPerAcr / 100 ) )
   ENDIF
   IF nPerDes <> Nil
      nDesconto:=  ( nSubTotal * ( nPerDes / 100 ) )
   ENDIF
   nTotal:= nSubTotal + nIPI
   @ 21, 01 Say "Sub-Total..: " + Tran( nSubTotal, "@E 999,999,999,999.99" )
   @ 22, 01 Say "Valor IPI..: " + Tran( nIPI,      "@E 999,999,999,999.99" )
   @ 22, 37 Say "Total: " + Tran( nTotal,    "@E 999,999.99" )
   @ 22, 57 Say "Vlr.Cond: " + Tran( nTotal + nAcrescimo - nDesconto, "@E 999,999.99" )
   SetColor( cCor )
   SWSet( 2000, nTotal + nAcrescimo - nDesconto )
   DispEnd()
Return ( nTotal + nAcrescimo - nDesconto )

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ LIMPAARQUIVO
³ Finalidade  ³ Limpar marcas do arquivpo de produtos
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 05/Fevereiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function LimpaArquivo()
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 ),;
         nArea:= Select(), nOrdem:= IndexOrd(), nRegistro
   Aviso( "Limpando registros marcados. Aguarde...", 24 /2 )
   DBSelectar( _COD_MPRIMA )
   nRegistro:= Recno()
   DBSetOrder( 6 )
   DBGoTop()
   DBSeek( "*" )
   WHILE MPr->Marca_ == "*"
       Mensagem( StrZero( Mpr->( Recno() ), 5, 0 ) + " => Limpando..." )
       IF NetRLock()
          Replace MPr->Marca_ WIth " "
       ELSE
          Mensagem( "Nao foi poss¡vel desmarcar todos os produtos...", 1 )
       ENDIF
       DBUnlock()
       DBSkip()
   ENDDO
   DBGoTo( nRegistro )
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Return Nil


  Static Function Janela( nJanela )
  Local cCor:= SetColor()
  SetColor( "15/12" )
  Scroll( 03, 70, 05, 75 )
  @ 04,72 Say StrZero( nJanela, 2, 0 )
  SetColor( cCor )



/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³
³ Finalidade  ³
³ Parametros  ³
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
  Function BuscaTransport( nCodigo )
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, 79 )
  Local nArea:= Select(), nOrdem:= IndexOrd()

  DBSelectAr( _COD_TRANSPORTE )
  DBSetOrder( 1 )
  Clear TypeaHead
  IF !DBSeek( nCodigo ) .OR. nCodigo==0
     vpbox(11,39,20,77,"Selecao de Transportadora",COR[24],,,COR[23])
     dbgotop()
     setcursor(0)
     setcolor(COR[25]+","+COR[22]+",,,"+COR[17])
     Mensagem("Pressione [ENTER] para selecionar.")
     ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Busca")
     oTB:=tbrowsedb(12,40,19,76)
     oTB:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" -> "+DESCRI + Space( 10 )}))
     oTB:AUTOLITE:=.f.
     oTB:dehilite()
     whil .t.
         oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
         whil nextkey()=0 .and.! oTB:stabilize()
         enddo
         TECLA:=inkey(0)
         if TECLA=K_ESC
            exit
         endif
         do case
            case TECLA==K_F12        ;Calculador()
            case TECLA==K_UP         ;oTB:up()
            case TECLA==K_LEFT       ;oTB:up()
            case TECLA==K_RIGHT      ;oTB:down()
            case TECLA==K_DOWN       ;oTB:down()
            case TECLA==K_PGUP       ;oTB:pageup()
            case TECLA==K_PGDN       ;oTB:pagedown()
            case TECLA==K_CTRL_PGUP  ;oTB:gotop()
            case TECLA==K_CTRL_PGDN  ;oTB:gobottom()
            case TECLA==K_ENTER .OR. TECLA=K_TAB
                 nCodigo:= CODIGO
                 exit
            case Chr( TECLA ) $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
                 DBSetOrder( 2 )
                 oTb:GoTop()
                 DBSeek( Chr( Tecla ), .T. )
                 oTb:RefreshAll()
                 WHILE !oTb:Stabilize()
                 ENDDO
            otherwise                ;tone(125); tone(300)
         endcase
         oTB:refreshcurrent()
         oTB:stabilize()
     enddo
     setcursor(nCURSOR)
   endif
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )

   IF nArea > 0
      DBSelectAr( nArea )
   ENDIF

   IF !nOrdem==Nil
      IF nOrdem > 0
         DBSetOrder( nOrdem )
      ENDIF
   ENDIF
   Return( .T. )




FUNCTION VerificaLimiteCr( aPedido )
   Local cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 )

   nSubTotal:= 0
   nIPI:= 0
   For nCt:= 1 To Len( aPedido )
       IF aPedido[ nCt ][ 10 ] == "Sim"
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ]
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
       ENDIF
   Next
   IF Cli->Saldo_ < nSubTotal + nIpi
      Aviso( "Cliente nao possui credito para esta compra.", 12 )
      Aviso( "Saldo de credito do cliente: " + Alltrim( TRAN( Cli->Saldo_, "@E 9,999,999,999.99" ) ) + " - Liberacao mediante senha.", 14 )
      Mensagem( "Digite [V] para ver a situacao atual do cliente ou [ENTER] para continuar." )
      INKEY(0)
      IF LastKey() == K_ENTER
      ELSEIF Chr( LastKey() ) $ "Vv"
         DispEstat()
      ENDIF
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return .F.
   ENDIF
   Return .T.


   Function DispEstat()
   Local cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 )
   VPBox( 01, 45, 13, 78, " Informacoes de Duplicatas ", _COR_BROW_BOX )
   Estatistica()
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Return Nil


   Function PerDif( aPerDif, cCondi_, cPctDif )
   Local cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 )

   Local nVezes:= StrVezes( "/", cCondi_ ) + 1, aPercentual:= {}, aJuros:= {}
   Local GetList:= {}, aDias:= {}, aData:= {}

   IF cPctDif == "N" .OR. LastKey() == K_UP .OR.;
                          LastKey() == K_DOWN
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return .T.
   ENDIF

   /* Calculo de Datas de Vencimentos */
   cString:= cCondi_
   nPos:= 0
   FOR nCt:= 1 TO Len( cCondi_ )
       AAdd( aDias, Val( SubStr( cString, 1, At( "/", cString ) - 1 ) ) )
       AAdd( aData, DATE() + Val( SubStr( cString, 1, At( "/", cString ) - 1 ) ) )
       cString:= SubStr( cString, At( "/", cString ) + 1 )
   NEXT
   /* Monta os GETs de solicitacao */
   VPBox( 10, 30, 20, 78, " Forma de Parcelamento ", _COR_GET_BOX )
   SetColor( _COR_GET_EDICAO )
   FOR nCt:= 1 TO nVezes
       IF Len( aPercentual ) < nCt
          AADD( aPercentual, aPerDif[ nCt ] )
       ELSE
          aPercentual[ nCt ]:= aPerDif[ nCt ]
       ENDIF
       @ 10 + nCt, 32 Say StrZero( nCt, 2, 0 ) + " - " + DTOC( aData[ nCt ] )
       @ 10 + nCt, 47 Get aPercentual[ nCt ] Pict "@R 99 %" Valid PercParcelas( aPercentual, nVezes, aDias )
   NEXT
   READ

   FOR nCt:= 1 TO Len( aPercentual )
       aPerDif[ nCt ]:= aPercentual[ nCt ]
   NEXT

   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Return .T.


   Function PercParcelas( aPercentual, nVezes, aDias )
   Local nTotal:= SWSet( 2000 ), nValor, nValorcJuros
   FOR nCt:= 1 TO Len( aPercentual )
      nValor:= ( nTotal * aPercentual[ nCt ] ) / 100
      nJuros:= ( SWSet( _GER_JUROSAOMES ) / SWSet( _GER_DIASNOMES ) * aDias[ nCt ] ) / 100
      nValorCJuros:= nValor + nJuros
      @ 10 + nCt, 52 Say nValor       Pict "@E 999,999.99"
      @ 10 + nCt, 65 Say nValorCJuros Pict "@E 999,999.99"
   NEXT
   RETURN .T.

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ BuscaCliente
   ³ Finalidade  ³ Pesquisa cliente no cadastro
   ³ Parametros  ³ cDescri, nCodCli
   ³ Retorno     ³ .T./.F.
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Static Function BuscaCliente( cDescri, nCodCli )
   Local cTela:= ScreenSave( 0, 0, 24, 79 )
   Local nOrdem:= IndexOrd(), lBusca:= .T.
   DBSetOrder( 2 )
   IF DBSeek( cDescri ) .AND. ! CLI->CODIGO == nCodCli
      Aviso( "Atencao! Cliente j  existente no cadastro de n§ " + StrZero( CLI->CODIGO, 6, 0 ) + "...", 12 )
      Mensagem( "Pressione [ENTER] para continuar..." )
      Pausa()
      lBusca:= .F.
      ScreenRest( cTela )
   ENDIF
   DBSetOrder( nOrdem )
   Return lBusca

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ PrecoConvertido
   ³ Finalidade  ³ Retorna o preco convertido conforme a tabela de precos
   ³             ³ utiliada no momento
   ³ Parametros  ³ nPrecoBase= Condicional, frazendo a conversao do preco determinado
   ³ Retorno     ³ nPrecoFinal
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function PrecoConvertido( nPrecoBase )
   Local nPrecoPadrao, nPrecoFinal
   IF !nPrecoBase == Nil
      nPrecoPadrao:= nPrecoBase
   ELSE
      nPrecoPadrao:= MPR->PRECOV
      IF TabelaComposta()
         nPrecoPadrao:= PrecoTabela()
      ENDIF
   ENDIF
   nPrecoFinal:= nPrecoPadrao + ( ( nPrecoPadrao * PRE->PERACR ) / 100 )
   nPrecoFinal:= nPrecoFinal  - ( ( nPrecoFinal * PRE->PERDES ) / 100 )
   //nPrecoFinal:= nPrecoFinal  + ( ( nPrecoFinal * CND->PERACR ) / 100 )
   //nPrecoFinal:= nPrecoFinal  - ( ( nPrecoFinal * CND->PERDES ) / 100 )
   Return nPrecoFinal

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ TabelaComposta()
   ³ Finalidade  ³ Retornar .T. se tabela selecionada for composta ou .F. caso contrario
   ³ Parametros  ³ Nil
   ³ Retorno     ³ Nil
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function TabelaComposta()
   TAX->( DBSetOrder( 1 ) )
   /* Se localiza em tabela auxiliar a tabela */
   IF TAX->( DBSeek( PRE->CODIGO ) )
      Return .T.
   ENDIF
   Return .F.

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ PrecoTabela
   ³ Finalidade  ³ Retornar o preco Conforme a tabela que esta
   ³             ³ sendo utilizada no momento ou retornar o preco
   ³             ³ padrao do produto
   ³ Parametros  ³ Nil
   ³ Retorno     ³ Nil
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function PrecoTabela()
   TAX->( DBSetOrder( 2 ) )
   IF TAX->( DBSeek( MPR->INDICE ) )
      /* Se localiza o produto na tabela de preco seleciona,
         retorna o valor PRECOV nela informado */
      WHILE TAX->CODPRO == MPR->INDICE
         IF TAX->CODIGO == PRE->CODIGO
            IF TAX->MARGEM==0
               Return TAX->PRECOV
            ELSE
               Return PrecoCusto() + ( PrecoCusto() * TAX->MARGEM / 100 )
            ENDIF
         ENDIF
         TAX->( DBSkip() )
      ENDDO
   ENDIF
   Return MPR->PRECOV


   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ PrecoCusto
   ³ Finalidade  ³ Retornar o preco de Custo do produto
   ³ Parametros  ³ Nil
   ³ Retorno     ³ nPrecoCusto
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function PrecoCusto()
   if !( PXF->CPROD_ == MPR->INDICE )
      PXF->( DBSetOrder( 1 ) )
      PXF->( DBSeek( MPR->INDICE ) )
   endif
   Return PXF->VALOR_

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ PrecoCompra
³ Finalidade  ³ Retornar o preco de compra do produto passado por
³             ³ referencia
³ Parametros  ³ cProduto= Codigo do Produto
³ Retorno     ³ nPrecoCompra
³ Programador ³ Valmor Pereira Flores
³ Data        ³
³ Atualizacao ³ Gelson Oliveira 28/01/2005
³             ³ Valmor Florez 16/02/2005
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function PrecoCompra( cProduto )
   Local nPrecoCompra:= 0, dUltCmp:= CtoD( '01/01/1901' )
   PXF->( DBSetOrder( 1 ) )
   PXF->( DBSeek( PAD( cProduto, 12 ) ) )
   While AllTrim( PXF->CPROD_ )==AllTrim( cProduto )
      If PXF->DATA__>=dUltCmp
         nPrecoCompra:= PXF->VALOR_
         dUltCmp:= PXF->DATA__
      EndIf
      PXF->( DBSkip() )
      // VALMOR: Mudanca em 16/02/05 - Teste de fim de arquivo evitando loop infinito 
      IF PXF->( EOF() )
         EXIT
      ENDIF
   EndDo
   Return nPrecoCompra


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ PrecoCnd
³ Finalidade  ³ Calcular o preco de Venda conforme a condicao de pagamento
³ Parametros  ³ nCondicao= Codigo da condicao de pagamento
³             ³ nPrecoCompra= Preco de Compra do produto
³             ³ nMargem= Opcional que indica qual margem utilizar no calculo
³ Retorno     ³ nPrecoFinal
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function PrecoCnd( nCondicao, nPrecoCompra, nMargem )
   Local aPrecos:= 0
   aPrecos:= { ROUND( PrecoCndAux( 1, nPrecoCompra, nMargem ), 2 ),;
               ROUND( PrecoCndAux( 2, nPrecoCompra, nMargem ), 2 ),;
               ROUND( PrecoCndAux( 3, nPrecoCompra, nMargem ), 2 ),;
               ROUND( PrecoCndAux( 4, nPrecoCompra, nMargem ), 2 ) }
   lIguais:= .F.
   FOR nLin:= 1 TO Len( aPrecos )
       FOR nCol:= nLin + 1 TO Len( aPrecos )
           IF aPrecos[ nLin ]==aPrecos[ nCol ] .AND. ! nLin == nCol
              lIguais:= .T.
              aPrecos[ nCol ]:= aPrecos[ nCol ] + 0.01
              nLin:= 1
           ENDIF
       NEXT
   NEXT
   IF nCondicao <= 0
      nCondicao:= 1
   ELSE
      IF nCondicao <= Len( aPrecos )
         Return ROUND( aPrecos[ nCondicao ], SWSet( 1998 ) )
      ENDIF
   ENDIF
   Return ROUND( PrecoCndAux( nCondicao, nPrecoCompra, nMargem ), SWSet( 1998 ) )

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ PRECOCNDAUX
   ³ Finalidade  ³ Preco / Condicoes - Auxiliar
   ³ Parametros  ³ nCondicao / nPrecoCompra / nMargem
   ³ Retorno     ³ nPreco
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function PrecoCndAux( nCondicao, nPrecoCompra, nMargem )
   Local nPrecoFinal:= 0
   CND->( DBSetOrder( 1 ) )
   CND->( DBSeek( nCondicao ) )
   IF nPrecoCompra == NIL .AND. nMargem == NIL
      CND->( DBSetOrder( 1 ) )
      IF CND->( DBSeek( nCondicao ) )
         nPrecoFinal:= PrecoConvertido() + ( ( PrecoConvertido() * CND->PERACR ) / 100 )
         nPrecoFinal:= nPrecoFinal - ( ( PrecoConvertido() * CND->PERDES ) / 100 )
      ELSE
         nPrecoFinal:= PrecoConvertido()
      ENDIF
   ELSE
      IF nPrecoCompra > 0
         nPrecoFinal:= nPrecoCompra + ( ( nPrecoCompra * nMargem ) / 100 )
         nPrecoFinal:= nPrecoFinal  + ( ( nPrecoFinal * CND->PERACR ) / 100 )
         nPrecoFinal:= nPrecoFinal  - ( ( nPrecoFinal * CND->PERDES ) / 100 )
      ENDIF
   ENDIF
   Return nPrecoFinal


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Condicao
³ Finalidade  ³ Retorna a descricao da condicao de pagamento
³ Parametros  ³ nCondicao= Codigo da condicao no cadastro
³ Retorno     ³ cCondicao= Descricao da condicao
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
   Function Condicao( nCondicao )
   Local cCondicao
   CND->( DBSetOrder( 1 ) )
   IF CND->( DBSeek( nCondicao ) )
      cCondicao:= PAD( CND->DESCRI, 15 )
   ELSE
      cCondicao:= ""
   ENDIF
   Return Alltrim( cCondicao )


   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ ValorCondicional
   ³ Finalidade  ³ Retornar o valor convertido conforme a tabela de
   ³             ³ condicoes utilizada no momento
   ³ Parametros  ³
   ³ Retorno     ³
   ³ Programador ³
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function ValorCondicional( nTotal )
   nTotal:= nTotal + ( ( nTotal * CND->PERACR ) / 100 )
   nTotal:= nTotal - ( ( nTotal * CND->PERDES ) / 100 )
   Return nTotal


   Func fVerPedGra( nClasse, nTamCod, nCorCod, cClasse, cTamanho, cCorDes, nTamQua, aCorTamQua )

      nClasse := MPR -> PCPCLA
      cTemCor := IIF (MPR -> PCPCSN == "S", "S", "N")
      fSelecTamCor( @nClasse, @nTamCod, @nCorCod, @nTamQua, "EST", ;
         @nQuantidade, cTemCor, @aCorTamQua )

   Return( .T. )




Static Function Detalhamento()
LOCAL cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor()

    VPBox( 00, 00, 11, 79, "DETALHAMENTO DE INFORMACOES", _COR_GET_BOX )
    SetColor( _COR_GET_EDICAO )
    @ 02, 02 Say "Produto......: " + MPR->INDICE
    @ 03, 02 Say "Cod.Fabrica..: " + MPR->CODFAB
    @ 04, 02 Say "Descricao....: " + MPR->DESCRI
    @ 05, 02 Say Repl( "±", 30 ) + " Detalhamento " + Repl( "±", 30 )
    @ 06, 02 Say MPR->DETAL1
    @ 07, 02 Say MPR->DETAL2
    @ 08, 02 Say MPR->DETAL3
    @ 09, 02 Say MPR->DETAL4
    @ 10, 02 Say MPR->DETAL5
    Inkey( 5 )
    SetColor( cCor )
    ScreenRest( cTela )
    Return Nil








