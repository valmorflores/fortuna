
// ## CL2HB.EXE - Converted

#include "vpf.ch"
#include "inkey.ch"

/*=============================================================================

                                           TELA PRINCIPAL DE COTACOES/PEDIDOS &
                                             ROTINA DE ALTERACAO DE INFORMACOES
                                                    DAS COTACOES OU PEDIDOS QUE
                                                            JA ESTEJAM GRAVADOS

=============================================================================*/

/*
* Modulo      - VPC88700
* Descricao   - Modulo de pedidos / Cotacoes
* Programador - Valmor Pereira Flores
* Data        - 30/Novembro/1995
* Atualizacao -
*/

#ifdef HARBOUR
function vpc88700()
#endif


Para nCodCliente

   Cotacoes( nCodCliente )

Return Nil


/*
*�������������Ŀ
*�      Funcao � Cotacoes
*�  Finalidade � Consultar os dados de cotacoes/pedidos que j� foram gravados
*� Programador � Valmor Pereira Flores
*�  Parametros � Nenhum
*�     Retorno � Nenhum
*�        Data � 03/Maio/1995
*� Atualizacao � 29/Maio/1995
*�             � Junho/2001
*���������������
*/
Function Cotacoes( nCodCliente )
   Loca cTELA:= ScreenSave( 00, 00, 24, 79 ), nCURSOR:= SetCursor(),;
        cCOR:= SetColor()
   Loca nOrdem:= IndexOrd(), nArea:= Select()
   Loca oTb, oCLIE, nTecla:= 0, nTELA:=1
   Loca nCODCLI, nCODPRO, cTELA0, cDESCLI, cDESPRO
   Loca lFLAG:=.F., lALTERAPOS:=.T.
   Loca nRefreshTimer, anCursPos
   Loca GETLIST:= {}
   Loca aProdutos:= {}, cCodigoDele
   Loca nRegistro

   /* Variaveis para pedido */
   Local nPosicao:= 0, nPrecoInicial, nPerDesconto, nPrecoFinal, nQuantidade,;
         cCliente, aPedido:= {}, lAltera:= .F., cTelaRes


   Local dDataPed:=Date(), cTelaData

   SWSet( _PED_INFO_EXTRA, .F. )
   SetCursor(0)

   /* Aparencia da Tela */
   DispBegin()
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   USERSCREEN()
   VPBOX(0,0,12,79,"PEDIDOS - TELA PRINCIPAL", _COR_BROW_BOX ,.f.,.f., _COR_BROW_TITULO, .F. )
   VPBOX(13,0,22,79,"Display", _COR_BROW_BOX ,.f.,.F., _COR_BROW_TITULO, .F. )
   SetColor( _COR_BROWSE )
   @ 04,02 Say "Cliente.:"
   @ 05,02 Say "Endereco:"
   @ 06,02 Say "Cidade..:"
   @ 07,02 Say "Fone....:"
   @ 08,02 Say "FAX.....:"
   @ 09,02 Say "Contato.:"
   @ 10,02 Say "Transpor:"
   @ 11,02 Say "Data....:"
   @ 11,59 Say "Gravado em: "
   DispEnd()


   Ajuda("["+_SETAS+"][Ctrl][PgDn][PgUp]Move "+;
         "[TAB]Imprimir [F10]Identificador")
   Mensagem("[INS]Novo [ENTER]Alt [CTRL_A]Atualiza [DEL]Exclui [Ctrl+TAB]Montagem [TAB]Imp")

   DBSelectAr( _COD_TRANSPORTE )
   DBSetOrder( 1 )

   DBSelectAr( _COD_NFISCAL )
   DBSetOrder( 4 )

   DBSelectar( _COD_PEDIDO )
   DBSetOrder( 1 )
   Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA

   DBGoBottom()
   SetColor( _COR_BROWSE )

   DBLeOrdem()
   SWSet( _INT_GRAVAPEDIDO, .F. )
   SWSet( _INT_GRAVANOTA,   .F. )

   /* inicializacao do browse */
   oTb:=TBrowseDb( 14, 01, 21, 78 )

   oTb:AddColumn( TbColumnNew("C/P  Numero   Cliente                                Documento     Valor Situacao",;
                  {|| left( Situa_, 1 ) + " " + ;
                      TIPO__ + " " + ;
                      IF( !Empty( CodPed ), CodPed, Codigo ) + " " + ;
                      IIF( !EMPTY( IDENT_ ), IDENT_ + " " + Left( Descri, 28 ), Left( Descri, 37 ) ) + " " + ;
                      NF_->NFNULA + ;
                      StrZero( PED->CODNF_, 9, 0 ) + IIF( PED->CODNF_ > 900000000, ".", IF( PED->CODNF_ > 0, "+", " " ) ) + ;
                      Tran( VlrTot,  "@EZ 999999.99" ) + ;
                      IF( IMPRES==" ", " <NI>   ", "      " ) } ) )

   oTb:AUTOLITE:=.F.
   oTb:dehilite()
   While .T.

       oTb:ColorRect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
       While !oTb:Stabilize()
       enddo

       SetColor( _COR_BROW_LETRA )
       @ 4, 12 Say PED->Descri + " (" + StrZero( PED->CODCLI, 6, 0 ) + ")"
       @ 5, 12 Say PED->Endere
       @ 6, 12 Say PED->Cidade
       @ 7, 12 Say Tran( Left( PED->FonFax, AT( "/", PED->FonFax ) - 1 ),  "@R (9999)-9999.9999" )
       @ 8, 12 Say Tran( SubStr( PED->FonFax, AT( "/", PED->FonFax ) + 2 ), "@R (9999)-9999.9999" )
       @ 9, 12 Say LEFT( PED->Compra, 25 )
       @ 10,12 Say StrZero( PED->Transp, 4, 0 ) + "-" + LEFT( TRA->Descri, 25 )
       @ 11,12 Say PED->Data__
       @ 11,71 Say IF( PED->DATAEM==CTOD( "" ), PED->DATA__, PED->DATAEM )

       /* Teste das teclas que foram pressionadas por ultimo */
       /* INCLUSAO / ALTERACAO / EXCLUSAO */
       IF nTecla==K_INS .OR. nTecla==K_ENTER .OR. nTecla==K_DEL .OR. nTecla==0

          /* Coloca a tabela de Operacoes no padrao a cada venda */
          IF OPE->( CODIGO ) >= 1
             OPE->( DBSetOrder( 1 ) )
             OPE->( DBSeek( 0 ) )
          ENDIF

          /* Coloca a tabela de condicoes de pagamento padrao a cada venda */
          CND->( DBSetOrder( 1 ) )
          CND->( DBSeek( 0 ) )

          /* Volta para tabela padrao a cada venda */
          PRE->( DBSetOrder( 1 ) )
          PRE->( DBSeek( 0 ) )

          /* Relacionamento NF & Pedidos */
          NF_->( DBSetOrder( 4 ) )
          DBSelectar( _COD_PEDIDO )
          Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA

       ELSE

          /* Operacao atrelada ao pedido */
          OPE->( DBSetOrder( 1 ) )
          @ 05,50 Say "Operacao"
          IF OPE->( DBSeek( PED->TABOPE ) )
             @ 06,50 Say STRZERO( PED->TABOPE, 3, 0 ) + " - " + LEFT( OPE->DESCRI, 23 )
          ELSE
             @ 06,50 Say STRZERO( PED->TABOPE, 3, 0 ) + " - " + PAD( "INDEFINIDA", 23 )
          ENDIF

          /* Situacao normal de navegacao */
          CND->( DBSetOrder( 1 ) )
          IF CND->( DBSeek( PED->TABCND ) )
             @ 08,50 Say padC( "Forma de Pagamento", 28 ) Color "02/15"
             @ 09,50 Say pad( CND->DESCRI, 28 )           Color "15/02"
             @ 10,50 Say pad( "Acr:"   + Tran( CND->PERACR, "@E 9999.99" ) + "%" + ;
                               " Desc:" + Tran( CND->PERDES, "@E 9999.99" ) + "%", 28 ) Color "15/02"
          ELSE
             Scroll( 08, 50, 10, 78 )
          ENDIF

       ENDIF

       /* Desbloqueio de arquivo a cada pressionamento */
       MPR->( DBUnlock() )
       DBUnlockAll()

       SetColor( _COR_BROW_LETRA )
       DispBox( 01, 02, 03, 77 )
       DevPos( 02, 04 )
       IF !Empty( PED->CodPed )
          DevOut( "Pedido..: " + PED->CodPed )
          SetColor( "14/01" )
          @ 03, 55 Say " N� Cotacao  " + PED->Codigo
       ELSE
          DevOut( "Cotacao.: " + PED->Codigo )
          SetColor( _COR_BROW_LETRA )
          @ 03, 55 Say Space( 21 )
       ENDIF

       SetColor( _COR_BROWSE )
       nRefreshTimer:= SECONDS()

       /* Aguardando uma tecla com atualizacao a cada x segundos para REDE */
       WHILE (( nTecla:= INKEY()) == 0 )

           //OL_Yield()

           nRefreshTimer := IF( nRefreshTimer==Nil, SECONDS(), nRefreshTimer )
           IF (( nRefreshTimer + 5 ) < SECONDS() )    /* 5 = Tempo em segundos */
               DISPBEGIN()
               anCursPos := { ROW(), COL() }
               FreshOrder( oTb )
               SETPOS( anCursPos[1], anCursPos[2] )
               oTb:ColorRect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
               DISPEND()
               nRefreshTimer:= SECONDS()
           ENDIF
       ENDDO

       If nTecla=K_ESC
          Exit
       EndIf

       do case
          case Acesso( nTecla )
          case nTecla == K_F6; DBMudaOrdem( 8, oTb )
          case nTecla==K_CTRL_F9
// CRTL+F9 executa um get na data do pedido
               cTelaData:=SaveScreen(,,,)
               SetCursor( 1 )
               dDataPed:=PED->DATA__
               @ 11,11 Get dDataPed
               Read
               SetCursor( 0 )
               If dDataPed = PED->DATA__
                  RestScreen(cTelaData,,,,)
               Else
                  PED->( netrlock() )
                  PED->( FieldReplace( "DATA__" , dDataPed ) )
                  PED->( DBUnlock() )
               EndIf
          case nTecla==K_UP         ;oTb:up()
          case nTecla==K_DOWN       ;oTb:down()
          case nTecla==K_PGUP       ;oTb:pageup()
          case nTecla==K_PGDN       ;oTb:pagedown()
          case nTecla==K_CTRL_PGUP  ;oTb:gotop()
          case nTecla==K_CTRL_PGDN  ;oTb:gobottom()
//          case nTecla==K_F12        ;Calculador()
          case nTecla==K_CTRL_F10   ;Calendar()
          case nTecla==K_ALT_I
               Le_Serial()
          case nTecla==305  // K_CTRL_ALT_N
               GravaNotaAuto( @oTb )
          case nTecla==306  // K_ALT_M // by gelson
               IF Confirma( 0, 0, "ATENCAO!!! Regravar Todas as Notas Fiscais?",;
                            "Digite [S] para confirmar ou [N] p/ cancelar.", "S" )
//                  cTelaRes:= ScreenSave( 0, 0, 24, 79 )
//                  PedidoDesfazProcessamento()
//                  ScreenRest( cTelaRes )
                  PED->( DBSetOrder( 1 ) )
                  PED->( DBGoTop() )
                  Keyboard Chr( K_CTRL_PGUP )
                  While .T.
                     cgCodPed:= PED->CODPED
                     GravaNotaAuto( @oTb, .T. )
                     Keyboard Chr( K_DOWN )
                     PED->( DBSetOrder( 1 ) )
                     PED->( DBSeek( cgCodPed ) )
                     PED->( DBSkip() )
                     If PED->( Eof() )
                        Exit
                     EndIf
                     Inkey( .2 )
                     If LastKey()==K_ESC
                        Exit
                     EndIf
                  EndDo
               ENDIF
          case nTecla==K_F9
               PedVerificaCustos( @oTb )

          case nTecla==K_F10
               EditaPlaca( oTb )

          case nTecla==K_CTRL_N
               IF !Empty( PED->CODPED )
                  IF PED->CODNF_ >= 900000000
                     IF Confirma( 0, 0, "Este pedido esta processado. Deseja desfazer o processamento?",;
                                  "Digite [S] para confirmar ou [N] p/ cancelar.", "S" )
                        cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                        PedidoDesfazProcessamento()
                        ScreenRest( cTelaRes )
                     ENDIF
                  ELSE
                     Set Relation To
                     NFiscal( PED->CODPED )
                     NF_->( DBSetOrder( 4 ) )
                     DBSelectar( _COD_PEDIDO )
                     Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA
                  ENDIF
                  oTb:RefreshAll()
                  WHILE !oTb:Stabilize()
                  ENDDO
               ELSE
                  cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                  Aviso( "Atencao! Pedido n�o foi Gravado ainda, impossivel gerar nota" )
                  Pausa()
                  ScreenRest( cTelaRes )
               ENDIF

          case nTecla==K_DEL

               IF Confirma(,,"Confirma a exclusao deste pedido?" )
                  lDeletar:= .T.
                  // DESFAZER O PROCESSAMENTO DE PEDIDOS QUE FORAM PROCESSADOS
                  // --------------------* * * * * * * * *
                  // VALMOR - AGOSTO/2003
                  IF SWSet( _PED_CONTROLES )
                     IF PedidoBaixado()
                        nOpcao:= 1   /////  SWAlerta( "Este pedido foi pre-processado, portanto, antes de excluir; voce deve decidir o que fazer com as informacoes ja processadas.; O que deseja fazer com tais informacoes?", { "Desfazer", "Manter", "Nao excluir" } )
                        IF nOpcao == 1
                           cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                           PedidoDesfazProcessamento()
                           ScreenRest( cTelaRes )
                        ENDIF
                        IF nOpcao = 3
                           lDeletar:= .F.
                        ENDIF
                     ENDIF
                  ENDIF

                  BEGIN SEQUENCE
                    IF lDeletar
                       cCodigoDele:= PED->CODIGO
                       FechaArquivos()
                       IF !AbreGrupo( "PEDIDOS" )
                          Aviso( "Falha ao tentar excluir.", 24 / 2 )
                          Pausa()
                          BREAK
                       ENDIF

                       /* EXLUINDO DETALHES */
                       DBSelectAr( _COD_DETALHE )
                       DET->( DBseek( cCodigoDele , .t. ) )
                       WHILE !eof() .and. CODPED = cCodigoDele
                          if netrlock()
                             dele
                             Dbunlock()
                          endif
                          Dbskip()
                       ENDDO

                       MPR->( DBSetOrder( 1 ) )
                       lPedido:= ( LEFT( PED->SITUA_, 1 )=="P" )

                       /* Limpando arquivo de produtos por pedido */
                       DBSelectar( _COD_PEDPROD )
                       DBSetOrder( 1 )
                       DBSeek( cCodigoDele )
                       WHILE !Eof() .and. Codigo==cCodigoDele
                          IF lPedido
                             IF ( NF_->NUMERO==0 .OR. NF_->( EOF() ) )
                                ControleDeReserva( "-", PAD( StrZero( PXP->CODPRO, 7, 0  ), 12 ), PXP->QUANT_ )
                             ENDIF
                          ENDIF
                          IF netrlock()
                             DBDelete()
                          ENDIF
                          DBUnlock()
                          DBSkip()
                       ENDDO

                       /* Limpado arquivo principal */
                       DBSelectar( _COD_PEDIDO )
                       DBSetOrder( 1 )
                       IF DBSeek( cCodigoDele )
                          IF netrlock()
                             DBDelete()
                          ENDIF
                          DBUnlock()
                       ENDIF
                       DBLeOrdem()
                    ENDIF
                 END SEQUENCE
               ENDIF

               DBUnLockAll()
               oTb:RefreshAll()
               WHILE !oTb:Stabilize()
               ENDDO

          Case nTecla==K_INS
               PConsulta( nCodCliente )

               DBSelectAr( _COD_PEDPROD )
               DBSelectAr( _COD_PEDIDO )
               DBSetOrder( 1 )
               oTb:RefreshAll()
               WHILE !oTb:Stabilize()
               ENDDO
               IF SWSet( _INT_GRAVAPEDIDO )
                  Keyboard Chr( K_ENTER ) + "G"
               ENDIF
               SWSet( _INT_GRAVAPEDIDO, .F. )

          Case nTecla==K_CTRL_TAB
               IF Confirma( 00, 00,;
                  "Confirma a impressao para producao?",;
                  "Digite [S] para confirmar ou [N] p/ cancelar.", "N" )
                  Relatorio( "MONTAGEM.REP" )
               ENDIF

          Case nTecla==K_CTRL_F1 .OR. nTecla==K_CTRL_F2
               IF Confirma( 00, 00,;
                  "Confirma a Impressao de Etiquetas?",;
                  "Digite [S] para confirmar ou [N] p/ cancelar.", "N" )
                  Relatorio( "ETQ2PRO.REP" )
               ENDIF

          Case nTecla==K_CTRL_F7 .OR. nTecla==K_CTRL_F6 .OR. nTecla==K_CTRL_F3 .OR.;
               nTecla==K_CTRL_F4 .OR. nTecla==K_CTRL_F5
               IF lConfirma:= Confirma( 00, 00,;
                  "Confirma a Exportacao p/ Microsoft Word?",;
                  "Digite [S] para confirmar ou [N] p/ cancelar.", "N" )
                  IF     nTecla==K_CTRL_F6 ;Relatorio( "EPEDIDO.REP" )
                  ELSEIF nTecla==K_CTRL_F7 ;Relatorio( "EPED0001.REP" )
                  ELSEIF nTecla==K_CTRL_F3 ;Relatorio( "EPED0002.REP" )
                  ELSEIF nTecla==K_CTRL_F4 ;Relatorio( "EPED0003.REP" )
                  ELSEIF nTecla==K_CTRL_F5 ;Relatorio( "EPED0004.REP" )
                  ENDIF
               ENDIF
               cTelaRes:= ScreenSave( 0, 0, 24, 79 )
               IF lConfirma
                  IF File( "EDICAO.BAT" )
                     !EDICAO.BAT PEDIDO.RTF
                  ENDIF
               ENDIF
               ScreenRest( cTelaRes )

          Case nTecla==K_CTRL_LEFT
               /* Gravacao de Informacoes / Tipo */
               IF netrlock()
                  IF TIPO__ $ "  -01-02-03-04-05-06-07"
                     IF VAL( TIPO__ ) > 1
                        Replace TIPO__ With StrZero( VAL( TIPO__ ) - 1, 2, 0 )
                     ELSE
                        Replace TIPO__ With "  "
                     ENDIF
                  ENDIF
               ENDIF
               DBUnlockAll()

          Case nTecla==K_SPACE .OR. nTecla==K_CTRL_RIGHT
               /* Gravacao de Informacoes / Tipo */
               IF netrlock()
                  IF TIPO__ $ "  -01-02-03-04-05-06-07"
                     IF VAL( TIPO__ ) < 7
                        Replace TIPO__ With StrZero( VAL( TIPO__ ) + 1, 2, 0 )
                     ELSE
                        Replace TIPO__ With "  "
                     ENDIF
                  ENDIF
               ENDIF
               DBUnlockAll()

          Case nTecla==K_TAB
              IF Confirma( 00, 00,;
                     "Confirma a impressao " + ;
                         IIF( TIPO__ == "  ", IF( EMPTY( CODPED ), "desta cotacao?", "deste pedido?" ),;
                         "do relatorio tipo " + TIPO__ + "?" ) ,;
                     "Digite [S] para confirmar ou [N] p/ cancelar.", "N" )

                  IF !Empty( CODPED ) .OR. VAL( TIPO__ ) > 0
                     DBUnlockAll()
                     IF TIPO__=="  "
                        Relatorio( "PEDIDOS.REP"  )
                     ELSEIF TIPO__=="01"
                        Relatorio( "ETQ2PRO.REP"  )
                     ELSEIF TIPO__=="02"
                        Relatorio( "EPEDIDO.REP"  )
                     ELSEIF TIPO__=="03"
                        Relatorio( "EPED0001.REP" )
                     ELSEIF TIPO__=="04"
                        Relatorio( "EPED0002.REP" )
                     ELSEIF TIPO__=="05"
                        Relatorio( "EPED0003.REP" )
                     ELSEIF TIPO__=="06"
                        Relatorio( "EPED0004.REP" )
                     ENDIF

                     IF netrlock()
                        IF IMPRES==" "
                           Replace IMPRES With "S"
                        ENDIF
                     ENDIF
                     DBUnlockAll()

                  ELSEIF TIPO__=="  "
                     Relatorio( "COTACAO.REP" )
                  ENDIF
               ENDIF

          Case nTecla==K_ENTER
               nRegistro:= Recno()
               VisualizaCotacoes( oTb )
               DBGoTo( nRegistro )
               oTb:RefreshAll()
               WHILE !oTb:Stabilize()
               ENDDO

          case nTecla == K_CTRL_A
               IF ( nOpcao:= SWAlerta( "<< INFORMACOES DE CLIENTE >>; Atualizacao de informacoes deste pedido.;O que voce deseja fazer?", { "Buscar Informacoes", "Cadastrar", "Cancelar" } ) )==2
                  ClientesEdicao( 1, oTb )
               ELSEIF nOpcao==1
                  ClientesEdicao( 2, oTb )
               ELSE
                  Aviso( "Informacoes deste pedido nao atualizadas.", .T. )
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
   DBSelectAr( _COD_PEDIDO )
   Set Relation To
   DBUnLockAll()
   FechaArquivos()
   IF nArea <> Nil
      IF nArea > 0
         DBSelectAr( nArea )
      ENDIF
      IF nOrdem <> Nil
         IF nOrdem > 0
            DBSetOrder( nOrdem )
         ENDIF
      ENDIF
   ENDIF
   Return(.T.)

*****************************************************************************
Static Function DisplayIPI( nPrecoFinal )
Local nValorIpi:= ( ( nPrecoFinal * MPr->IPI___ ) / 100 )
   @ 16,12 Say "% IPI......: [" + Tran( MPr->IPI___, "@E 999.99" ) + "]"
   @ 17,12 Say "Valor IPI..: [" + Tran( nValorIpi, "@E 999,999.99" ) + "]"
   Return nValorIpi


Function GravaNotaAuto( oTb, lConverte )

If lConverte==Nil  // gelson
   lConverte:= .F.
EndIf
      IF !Empty( PED->CODPED )
          Set Relation To
          //Keyboard Chr( K_DOWN ) + Chr( K_DOWN ) + Chr( K_DOWN ) + Chr( K_DOWN ) + CHR( K_DOWN )
          /*
             Remete as informacoes de gravacao acrescentando a
             letra <A> de automatico
          */
          NFiscal( "A" + PED->CODPED, lConverte ) // gelson
          NF_->( DBSetOrder( 4 ) )
          DBSelectar( _COD_PEDIDO )
          Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA
          IF oTb <> NIL
             oTb:RefreshAll()
             WHILE !oTb:Stabilize()
             ENDDO
          ENDIF
      ELSE
          cTelaRes:= ScreenSave( 0, 0, 24, 79 )
          Aviso( "Atencao! Pedido n�o foi Gravado ainda, impossivel gerar nota" )
          Pausa()
          ScreenRest( cTelaRes )
      ENDIF








/*
* Modulo      - VisualizaCotacoes
* Parametro   - Nenhum
* Finalidade  - Verificacao/Manutencao de Cotacoes para gerar pedidos.
* Programador - Valmor Pereira Flores
* Data        - 26/Outubro/1995
* Atualizacao - JULHO/2001
*/
Static Func VisualizaCotacoes( oTBrowse )
Loca oTb, cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 ),;
     nRow:=1, aCotacoes:= {}, aPedido:= {},;
     nCursor:= SetCursor(), nArea:= Select(), nOrdem:= IndexOrd(),;
     cCodPed, nAreaRes, lPedido
Local cCompra, nCodTra, nPerAcr, cPrazo_, nValid_, cCondi_, cFrete_, nVenIn1,;
      nVenEx1, cVende1, cVende2, cObser1, cObser2, nTabCnd:= PED->TABCND
Local nPosicao, nVlrTot
Local cOC__01, cOC__02, cOC__03, cOC__04, cOC__05, cOC__06,;
      cOC__07, cOC__08, cOC__09, cOC__10, cOC__11, cOC__12, cOC__13,;
      nQTD_01, nQTD_02, nQTD_03, nQTD_04, nQTD_05, nQTD_06, nQTD_07,;
      nQTD_08, nQTD_09, nQTD_10, nQTD_11, nQTD_12, nQTD_13,;
      cENT_01, cENT_02, cENT_03, cENT_04, cENT_05, cENT_06,;
      cENT_07, cENT_08, cENT_09, cENT_10, cENT_11, cENT_12,;
      cENT_13
Local nOpcao:= 1
Local nPerIpi, cUnidad, cOrigem, cDetal1, cDetal2, cDetal3
Local nCt, GetList:= {}
Local nTecla
Loca lQuantidade:= .F.

   aCotacoes:= 0
   aCotacoes:= {}
   AAdd( aCotacoes, { Ped->Codigo, Ped->CodCli, Ped->Descri } )

   lPedido:= !EMPTY( PED->CODPED )

   /* Coloca em ordem default */
   DBSetOrder( 1 )

   /* Apaga o arquivo de indice provis�rio */
   FErase( "INDICERES.NTX" )

   DBSelectar( _COD_PEDPROD )
   DBSetOrder( 1 )


   IF Len( aCotacoes ) <= 0 .OR. VAL( PED->CODIGO ) <= 0 .OR. !( PED->( netrlock() ) )
      SWAlerta( "Este pedido/cotacao deve estar; em uso por outro terminal. ;Tente mais tarde.", { "OK" } )
      ScreenRest( cTela )
      DBSelectAr( nArea )
      DBUnlockAll()
      Return .F.
   ELSE
      Aviso( "Abrindo " + IF( LEFT( PED->SITUA_, 1 )=="C", "esta cotacao", "este pedido" ) + ", aguarde... " )
   ENDIF
   PED->( DBUnlock() )

   For nCt:= 1 To Len( aCotacoes )
       If DBSeek( aCotacoes[ nCt ][ 1 ] )
          While ( aCotacoes[ nCt ][ 1 ] == PXP->CODIGO )
              AAdd( aPedido, { PXP->CodFab,;
                               PXP->Descri,;
                               PXP->VlrIni,;
                               PXP->PerDes,;
                               PXP->VlrUni,;
                               PXP->Quant_,;
                               PXP->Unidad,;
                               PXP->IPI___,;
                               PXP->Icm___,;
                               PXP->Select,;
                               PXP->Origem,;
                               Recno(),;
                               PXP->Preco1,;
                               PXP->Preco2,;
                               PXP->TabPre,;
                               PXP->DesPre,;
                               PXP->CodPro,;
                               PXP->PCPCLA,;
                               PXP->PCPTAM,;
                               PXP->PCPCOR,;
                               Space( 65 ),;
                               Space( 65 ),;
                               Space( 65 ),;
                               PXP->DTENTR } )

              /* DETALHAMENTO DE PRODUTOS *************************************/
              /* ORDEM 1                                                      */
              /*                 Busca composta por causa do detalhamento     */
              /*                 CODPED             + INDICE       + ORDEM_   */
              /*==============================================================*/
              IF Len( aPedido ) > 0
                 IF DET->( DBSeek( aCotacoes[ nCt ][ 1 ] + PAD( StrZero( PXP->CODPRO, 7, 0 ), 12 ) + Str( LEN( aPedido ), 3 ) ) )
                    aPedido[ LEN( aPedido ) ][ 21 ] := DET->DETAL1
                    aPedido[ LEN( aPedido ) ][ 22 ] := DET->DETAL2
                    aPedido[ LEN( aPedido ) ][ 23 ] := DET->DETAL3
                 ENDIF
              ENDIF
              /* Fim */

              IF lPedido
                 ControleDeReserva( "-", pad( strZero( PXP->CODPRO, 7, 0 ), 12 ), PXP->QUANT_ )
              ENDIF
              DBSkip()

          EndDo
          DbGoBottom()
       EndIf
   Next

   DBUnlockAll()
   If Empty( aCotacoes ) .OR. Empty( aPedido )
      Aviso( "Pedido/Cotacao sem produto selecionado...", 12 )
      Tone( 300, 3 )
      Inkey( 1 )
      DBUnlockAll()
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      DBSelectAr( nArea )
      DBSetOrder( nOrdem )
      Return Nil
   EndIf

   /* Informacoes do Cliente */
   IF LEFT( ALLTRIM( PED->DESCRI ), 3 )=="222"
      IF ( nOpcao:= SWAlerta( "<< INFORMACOES DE CLIENTE >>; Cliente nao consta na base de dados;O que voce deseja fazer?", { "Buscar Informacoes", "Cadastrar", "Cancelar" } ) )==2
         ClientesEdicao( 1 )
      ENDIF
   ENDIF

   /* Busca a condicao escolhida previamente */
   CND->( DBSetOrder( 1 ) )
   CND->( DBSeek( PED->TABCND ) )

   /* Ordem de COR & CLA */
   COR->( DBSetOrder( 1 ) )
   CLA->( DBSetOrder( 1 ) )

   DispBegin()
   SetColor( _COR_BROWSE )

   /* Titulo condicional (Cotacao/Pedido) */
   VPBox( 0, 0, 22, 79,;
              IF( LEFT( PED->SITUA_, 1 )=="C","Cotacao (Gravada)","Pedido" ),;
               _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. )

   @ 1, 1 Say "Pedido.....: " + Ped->Codigo
   @ 2, 1 Say "Codigo.....: " + StrZero( Ped->CodCli, 6, 0 )
   @ 3, 1 Say "Cliente....: " + Ped->Descri
   @ 4, 1 Say "Endere�o...: " + Ped->Endere
   @ 5, 1 Say "Cidade.....: " + Ped->Cidade
   @ 6, 1 Say "Contato....: " + Ped->Compra
   @ 7, 1 Say "Fone/Fax...: " + Ped->FonFax
   @ 8, 1 Say "Transportad: " + StrZero( Ped->Transp, 3, 0 )

   SetColor( _COR_BROW_TITULO )
   Scroll( 9, 0, 9, 79 )
   @ 09, 01 Say "Produto"
   @ 09, 33 Say "Un"
   @ 09, 37 Say "Quantidade"
   @ 09, 53 Say "Preco Unit�rio"
   @ 09, 68 Say "%IPI"
   DispEnd()

   DBSelectar( _COD_PEDPROD )

   CalculoGeral( aPedido, CND->PERACR, CND->PERDES )

   SetCursor( 0 )
   Mensagem("[Espaco]Sel, [INS]Novo [ENTER]Altera [G]Gravar [Ctrl+A]Inf [Ctrl+B]Pedidos")

   SetColor( _COR_BROWSE )
   oTb:=TBrowseNew( 10, 1, 20, 78 )
   IF SWSet( _PED_FORMULARIO ) == 2
      oTb:addcolumn(tbcolumnnew(,{|| Left( Tran( aPedido[ nRow ][ 17 ], "@R 999-9999" ) + "-" + ;
                                     aPedido[ nRow ][ 2 ], 30 ) + ;
                                " � " + aPedido[ nRow ][ 7 ] + " � " +;
                                  Tran( aPedido[ nRow ][ 6 ], "@E 9,999,999.99" ) + " � " +;
                                  Tran( aPedido[ nRow ][ 5 ], "@E 9999,999.999" ) + " � " +;
                                  Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )       +  " �" + aPedido[ nRow ][ 10 ] }))
   ELSE
      oTb:addcolumn(tbcolumnnew(,{|| Left( aPedido[ nRow ][ 1 ] + "-" + ;
                                     aPedido[ nRow ][ 2 ], 30 ) + ;
                                " � " + aPedido[ nRow ][ 7 ] + " � " +;
                                  Tran( aPedido[ nRow ][ 6 ], "@E 9,999,999.99" ) + " � " +;
                                  Tran( aPedido[ nRow ][ 5 ], "@E 9999,999.999" ) + " � " +;
                                  Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )       +  " �" + aPedido[ nRow ][ 10 ] }))
   ENDIF
   oTb:AUTOLITE:=.f.
   oTb:GOTOPBLOCK :={|| nRow:= 1}
   oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aPedido ) }
   oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPedido,@nRow)}
   oTb:dehilite()
   WHILE .T.
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
      whil nextkey()==0 .and. ! oTb:stabilize()
      end
      Scroll( 06, 40, 06, 78 )

      SetColor( "W+/G" )

      /* Colocado em 20/Agosto/1999           */
      /* Exibicao das propriedades do produto */
      IF !( aPedido[ nRow ][ 19 ] == 0 )
         COR->( DBSeek( aPedido[ nRow ][ 20 ] ) )          /* cor */
         CLA->( DBSeek( aPedido[ nRow ][ 18 ] ) )          /* classe */
         cTama:= StrZero( aPedido[ nRow ][ 19 ] - 1, 2, 0 )    /* posicao do tamanho */
         cTama:= IF( cTama=="**", "00", cTama )
         @ 06,40 Say PAD( LEFT( CLA->DESCRI, 16 ) + " " + LEFT( COR->DESCRI, 16 ) + " <" + Alltrim( CLA->TAMA&cTama ) + ">", 39 )
      ENDIF

      IF SWSet( _PED_DTENTREGA )
         @ 05,40 Say PAD( "Entrega: " + aPedido[ nRow ][ 24 ], 39 )
      ENDIF

      @ 06,40 Say PAD( "Tabela: " + aPedido[ nRow ][ 16 ], 39 )
      @ 07,40 Say PAD( "Cond..: " + CND->DESCRI, 39 )
      @ 08,40 Say PAD( "Valor Total Item:" + Tran( aPedido[ nRow ][ 5 ] * aPedido[ nRow ][ 6 ], "@E 999,999.99" ), 39 )
      @ 21,33 Say PadC( Alltrim( aPedido[ nRow ][ 2 ] ) + " - " + Left( aPedido[ nRow ][ 11 ], 3 ), 45, " " )

      SetColor( _COR_BROWSE )
      nTecla:= inkey(0)
      if nTecla==K_ESC   ;exit   ;endif
      do case
         case nTecla==K_CTRL_F
              nAreaRes:= Select()
              DBSelectAr( _COD_PEDIDO )
              cGarantia:=  GARANT
              nMaoObra:=   MOBRA_
              nOpc1:=      OPC1__
              nOpc2:=      OPC2__
              nOpc3:=      OPC3__
              cFrete:=     FRETE_
              cObser1:=    OBSER1
              cObser2:=    OBSER2
              cTelaRes:=   ScreenSave( 0, 0, 24, 79 )
              cCorRes:=    SetColor()
              nCursorRes:= SetCursor( 1 )
              VPBox( 05, 05, 21, 77, " OUTRAS INFORMACOES", _COR_GET_BOX )
              SetColor( _COR_GET_EDICAO )
              @ 06,06 Say "Garantia...........:" Get cGarantia Pict "@!"
              @ 07,06 Say "Mao-de-Obra........:" Get nMaoObra Pict "@E 999,999,999.99"
              @ 08,06 Say "Opcional (A).......:" Get nOpc1 Pict "@E 999,999.99"
              @ 09,06 Say "Opcional (B).......:" Get nOpc2 Pict "@E 999,999.99"
              @ 10,06 Say "Opcional (C).......:" Get nOpc3 Pict "@E 999,999.99"
              @ 11,06 Say "Frete..............:" Get cFrete
              @ 12,06 Say "Observacoes-------------------------------------------------"
              @ 13,06 Get cObser1 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." )
              @ 14,06 Get cObser2 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." )
              READ
              SetCursor( nCursorRes )
              ScreenRest( cTelaRes )
              SetColor( cCorRes )
              IF netrlock()
                 Replace FRETE_ With cFrete,;
                         GARANT With cGarantia,;
                         MOBRA_ With nMaoObra,;
                         OPC1__ With nOpc1,;
                         OPC2__ With nOpc2,;
                         OPC3__ With nOpc3,;
                         Frete_ With cFrete,;
                         Obser1 With cObser1,;
                         Obser2 With cObser2
              ENDIF
              DBUnlockAll()
              DBCommitAll()
              DBSelectAr( nAreaRes )
         case nTecla==K_F12        ;Calculador()
         case nTecla==K_UP         ;oTb:up()
         case nTecla==K_DOWN       ;oTb:down()
         case nTecla==K_LEFT       ;oTb:up()
         case nTecla==K_RIGHT      ;oTb:down()
         case nTecla==K_PGUP       ;oTb:pageup()
         case nTecla==K_CTRL_PGUP  ;oTb:gotop()
         case nTecla==K_PGDN       ;oTb:pagedown()
         case nTecla==K_CTRL_PGDN  ;oTb:gobottom()
         case nTecla==K_CTRL_A
              nAreaRes:= Select()
              DBSelectAr( _COD_PEDIDO )
              nVlrTot:= VLRTOT
              cCompra:= Compra
              nCodTra:= Transp
              nPerAcr:= PerAcr
              nPerDes:= PerDes
              cPrazo_:= Prazo_
              nValid_:= Valid_
              cCondi_:= Condi_
              cFrete_:= Frete_
              nVenIn1:= VenIn1
              nVenEx1:= VenEx1
              cVende1:= Vende1
              cVende2:= Vende2
              cObser1:= Obser1
              cObser2:= Obser2
              nTabCnd:= TabCnd
              cObsNf1:= ObsNf1
              CND->( DBSetOrder( 1 ) )
              CND->( DBSeek( nTabCnd ) )
              cTelaRes:= ScreenSave( 0, 0, 24, 79 )
              cCorRes:= SetColor()
              nCursorRes:= SetCursor( 1 )
              VPBox( 04, 05, 21, 77, " Informacoes Diversas", _COR_GET_BOX )
              SetColor( _COR_GET_EDICAO )
              @ 06,06 Say "Contato (Nome)............:" Get cCompra Pict "@!"
              @ 07,06 Say "Codigo da Transportadora..:" Get nCodTra Pict "999" Valid BuscaTransport( @nCodTra ) When Mensagem( "Digite o codigo da transportadora ou [F9] para ver lista." )
              @ 08,06 Say "% Acrescimo (Mensal)......:" Get nPerAcr Pict "@E 999.99"  When Mensagem( "Digite o percentual de acrescimo." )
              @ 09,06 Say "Prazo de Entrega (EM DIAS):" Get cPrazo_ When Mensagem( "Digite o prazo de entrega desta mercadoria." )
              @ 10,06 Say "Validade da Proposta......:" Get nValid_ When Mensagem( "Digite o prazo de validade desta proposta em numero de dias." )
              @ 11,06 Say "Tabela de Condicoes.......:" Get nTabCnd Pict "999" when mensagem( "Tabela de condicoes de pagamento." ) Valid BuscaCondicao( @nTabCnd, @cCondi_, nVlrTot )
              @ 12,06 Say " ��Detalhamento Condicoes.:" Get cCondi_ When Mensagem( "Digite as condicoes de pagamento Ex. [30/60/90/120   ]." )
              @ 13,06 Say "Tipo de Frete.............:" Get cFrete_ valid DisplayFrete( @cFrete_ ) When Mensagem( "Digite o tipo de frete ou [ENTER] para ver opcoes." )
              @ 14,06 Say "Vendedor Interno..........:" Get nVenIn1 Pict "@R 999" valid VenSeleciona( @nVenIn1, 1, @cVende1 ) When Mensagem( "Digite o codigo do vendedor interno.")
              @ 14,40 Get cVende1 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." )
              @ 15,06 Say "Vendedor Externo..........:" Get nVenEx1 Pict "@R 999" Valid VenSeleciona( @nVenEx1, 2, @cVende2 ) When Mensagem( "Digite o codigo do vendedor interno.")
              @ 15,40 Get cVende2 Pict "!!!!!!!!!!!!" When Mensagem( "Digite o nome, numero ou sigla do vendedor." )
              @ 16,06 Say "Observacoes"
              @ 17,06 Get cObser1 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." )
              @ 18,06 Get cObser2 Pict "@S60" When Mensagem( "Digite alguma observacao que se faca necessaria." )
              @ 20,06 Say "Observacao na Nota Fiscal.:" Get cObsNf1
              Read

              /* Transp.info da tabela condicoes */
              nPerAcr:= CND->PERACR
              nPerDes:= CND->PERDES

              SetCursor( nCursorRes )
              ScreenRest( cTelaRes )
              SetColor( cCorRes )
              IF netrlock()
                 Replace Compra With cCompra,;
                         Transp With nCodTra,;
                         PerDes With nPerDes,;
                         PerAcr With nPerAcr,;
                         Prazo_ With cPrazo_,;
                         Valid_ With nValid_,;
                         Condi_ With cCondi_,;
                         Frete_ With cFrete_,;
                         VenIn1 With nVenIn1,;
                         VenEx1 With nVenEx1,;
                         Vende1 With cVende1,;
                         Vende2 With cVende2,;
                         Obser1 With cObser1,;
                         Obser2 With cObser2,;
                         TabCnd With nTabCnd,;
                         ObsNf1 With cObsNf1,;
                         DATAEM With DATE()
              ENDIF

              /* recalculo */
              CalculoGeral( aPedido, nPerAcr, nPerDes )

              DBUnlockAll()
              DBCommitAll()
              DBSelectAr( nAreaRes )

         case nTecla==K_CTRL_B
              nAreaRes:= Select()
              DBSelectAr( _COD_PEDIDO )
              cOC__01:= OC__01
              cOC__02:= OC__02
              cOC__03:= OC__03
              cOC__04:= OC__04
              cOC__05:= OC__05
              cOC__06:= OC__06
              cOC__07:= OC__07
              cOC__08:= OC__08
              cOC__09:= OC__09
              cOC__10:= OC__10
              cOC__11:= OC__11
              cOC__12:= OC__12
              cOC__13:= OC__13
              nQTD_01:= QTD_01
              nQTD_02:= QTD_02
              nQTD_03:= QTD_03
              nQTD_04:= QTD_04
              nQTD_05:= QTD_05
              nQTD_06:= QTD_06
              nQTD_07:= QTD_07
              nQTD_08:= QTD_08
              nQTD_09:= QTD_09
              nQTD_10:= QTD_10
              nQTD_11:= QTD_11
              nQTD_12:= QTD_12
              nQTD_13:= QTD_13
              cENT_01:= ENT_01
              cENT_02:= ENT_02
              cENT_03:= ENT_03
              cENT_04:= ENT_04
              cENT_05:= ENT_05
              cENT_06:= ENT_06
              cENT_07:= ENT_07
              cENT_08:= ENT_08
              cENT_09:= ENT_09
              cENT_10:= ENT_10
              cENT_11:= ENT_11
              cENT_12:= ENT_12
              cENT_13:= ENT_13
              cCompra:= Compra
              nCodTra:= Transp
              nPerAcr:= PerAcr
              cPrazo_:= Prazo_
              nValid_:= Valid_
              cCondi_:= Condi_
              cFrete_:= Frete_
              nVenIn1:= VenIn1
              nVenEx1:= VenEx1
              cVende1:= Vende1
              cVende2:= Vende2
              cObser1:= Obser1
              cObser2:= Obser2
              nTabCnd:= TABCND
              cTelaRes:= ScreenSave( 0, 0, 24, 79 )
              cCorRes:= SetColor()
              VPBox( 05, 05, 19, 77, " Informacoes de Ordens de Compra ", _COR_GET_BOX )
              SetColor( _COR_GET_EDICAO )
              @ 06,06 Say "PRODUTO--------------------------OC------QUANTIDADE-----ENTREGA----"
              DBSelectAr( _COD_PEDPROD )
              DBSetOrder( 1 )
              IF DBSeek( PED->CODIGO )
                 nLin:= 06
                 WHILE .T.
                     @ ++nLin,07 Say DESCRI
                     DBSkip()
                     IF EOF() .OR. ! PED->CODIGO == CODIGO
                        EXIT
                     ENDIF
                 ENDDO
              ENDIF
              SetCursor( 1 )
              @ 07,36 Get cOC__01
              @ 07,50 Get nQTD_01 Pict "@E 999999"
              @ 07,66 Get cENT_01
              @ 08,36 Get cOC__02
              @ 08,50 Get nQTD_02 Pict "@E 999999"
              @ 08,66 Get cENT_02
              @ 09,36 Get cOC__03
              @ 09,50 Get nQTD_03 Pict "@E 999999"
              @ 09,66 Get cENT_03
              @ 10,36 Get cOC__04
              @ 10,50 Get nQTD_04 Pict "@E 999999"
              @ 10,66 Get cENT_04
              @ 11,36 Get cOC__05
              @ 11,50 Get nQTD_05 Pict "@E 999999"
              @ 11,66 Get cENT_05
              @ 12,36 Get cOC__06
              @ 12,50 Get nQTD_06 Pict "@E 999999"
              @ 12,66 Get cENT_06
              @ 13,36 Get cOC__07
              @ 13,50 Get nQTD_07 Pict "@E 999999"
              @ 13,66 Get cENT_07
              @ 14,36 Get cOC__08
              @ 14,50 Get nQTD_08 Pict "@E 999999"
              @ 14,66 Get cENT_08
              @ 15,36 Get cOC__09
              @ 15,50 Get nQTD_09 Pict "@E 999999"
              @ 15,66 Get cENT_09
              @ 16,36 Get cOC__10
              @ 16,50 Get nQTD_10 Pict "@E 999999"
              @ 16,66 Get cENT_10
              @ 17,36 Get cOC__11
              @ 17,50 Get nQTD_11 Pict "@E 999999"
              @ 17,66 Get cENT_11
              @ 18,36 Get cOC__12
              @ 18,50 Get nQTD_12 Pict "@E 999999"
              @ 18,66 Get cENT_12
              READ
              SetCursor( 0 )
              ScreenRest( cTelaRes )
              SetColor( cCorRes )
              DBSelectAr( _COD_PEDIDO )
              IF netrlock()
                 Replace OC__01 With cOC__01,;
                         QTD_01 With nQTD_01,;
                         ENT_01 With cENT_01,;
                         OC__02 With cOC__02,;
                         QTD_02 With nQTD_02,;
                         ENT_02 With cENT_02,;
                         OC__03 With cOC__03,;
                         QTD_03 With nQTD_03,;
                         ENT_03 With cENT_03,;
                         OC__04 With cOC__04,;
                         QTD_04 With nQTD_04,;
                         ENT_04 With cENT_04,;
                         OC__05 With cOC__05,;
                         QTD_05 With nQTD_05,;
                         ENT_05 With cENT_05,;
                         OC__06 With cOC__06,;
                         QTD_06 With nQTD_06,;
                         ENT_06 With cENT_06,;
                         OC__07 With cOC__07,;
                         QTD_07 With nQTD_07,;
                         ENT_07 With cENT_07,;
                         OC__08 With cOC__08,;
                         QTD_08 With nQTD_08,;
                         ENT_08 With cENT_08,;
                         OC__09 With cOC__09,;
                         QTD_09 With nQTD_09,;
                         ENT_09 With cENT_09,;
                         OC__10 With cOC__10,;
                         QTD_10 With nQTD_10,;
                         ENT_10 With cENT_10,;
                         OC__11 With cOC__11,;
                         QTD_11 With nQTD_11,;
                         ENT_11 With cENT_11,;
                         OC__12 With cOC__12,;
                         QTD_12 With nQTD_12,;
                         ENT_12 With cENT_12
              ENDIF
              DBUnlockAll()
              DBCommitAll()
              DBSelectAr( nAreaRes )

         case Chr( nTecla ) $ "Gg" .OR. nTecla==K_F1 .OR. nTecla==K_CTRL_N
              IF nTecla==K_CTRL_N
                 SWSet( _INT_GRAVANOTA, .T. )
              ENDIF

              cTelaReserva:= ScreenSave( 0, 0, 24, 79 )
              DBSelectar( _COD_PEDIDO )
              DBSetOrder( 1 )
              DBSeek( aCotacoes[ 1 ][ 1 ] )

              /* SE AINDA FOR COTACAO */
              IF Empty( CODPED )
                 Aviso("Gerando Pedido...", 24 / 2 )
                 Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...")
                 ScreenRest( cTelaReserva )
                 DBSelectar( _COD_PEDIDO )
                 cCodCot:= Codigo
                 DBSetOrder( 6 )
                 DBGoBottom()
                 cCodPed:= StrZero( Val( CodPed ) + 1, 8, 0 )
                 DBSetOrder( 1 )
                 nVlrTot:= 0

                 /* Instalacao de aplicativo */
                 FOR nCt:= 1 TO Len( aPedido )
                     IF aPedido[ nCt ][ 10 ]=="Sim"
                        nVlrIpi:= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
                        nVlrTot:= nVlrTot + nVlrIpi + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] )
                     ENDIF
                 NEXT

                 CND->( DBSetOrder( 1 ) )
                 IF CND->( DBSeek( nTabCnd ) )
                    nVlrTot:= CalculoGeral( aPedido, CND->PERACR, CND->PERDES )
                 ENDIF

                 FOR nCt:= 1 To Len( aCotacoes )
                     If DBSeek( aCotacoes[ nCt ][ 1 ] )
                        IF netrlock()
                           Replace Situa_ With "PED",;
                                   Select With "Nao",;
                                   CodPed with cCodPed,;
                                   VlrTot With nVlrTot
                        EndIf
                        DBUnLock()
                     Else
                        Aviso( "Cotacao n� " + aCotacoes[ nCt ][ 1 ] + " nao foi encontrada...", 24 / 2 )
                        Pausa()
                     EndIf
                 NEXT

                 Aviso( "Atualizando os produtos...", 24 / 2 )
                 Mensagem( "Gravando arquivo de produtos por PEDIDOS, aguarde..." )
                 DBSelectar( _COD_PEDPROD )
                 DBSetOrder( 1 )
                 nCt:= 0
                 If DBSeek( cCodCot )
                    WHILE left( cCodCot, 8 ) == Left( PxP->Codigo, 8 )
                        IF netrlock()
                           Replace CodPed With cCodPed
                        ENDIF
                        IF ( nPosicao:= AScan( aPedido, {|x| Alltrim( x[1] ) == Alltrim( PXP->CODFAB ) .AND.;
                                                             Alltrim( x[2] ) == Alltrim( PXP->DESCRI ) .AND.;
                                                             x[12] == Recno() } ) ) > 0
                           IF aPedido[ nPosicao ][ 10 ] == "Nao"
                              DBSelectAr( _COD_DETALHE )
                              DET->( DBSETorder( 1 ) )
                              IF DBseek( PED->CODIGO + pad(strzero(PXP->CODPRO,7),12) + str(nPosicao,3))
                                 if netrlock()
                                    dele
                                    Dbunlock()
                                 endif
                              ENDIF
                              DET->( DBSETorder( 2 ) )
                              DET->( DBseek( PED->CODIGO , .t.) )
                              nProdatu := 1
                              While !eof() .and. CODPED = PED->CODIGO
                                 if netrlock()
                                    repl ORDEM_ with nProdatu
                                    Dbunlock()
                                 endif
                                 Dbskip()
                                 nProdatu ++
                              enddo
                              DET->( DBSETorder( 1 ) )
                              DBSelectar( _COD_PEDPROD )
                              IF netrlock()
                                 Dele
                              ENDIF
                           ELSE
                              IF netrlock()
                                 Replace QUANT_ With aPedido[ nPosicao ][ 6 ],;
                                         VLRINI With aPedido[ nPosicao ][ 3 ],;
                                         PERDES With aPedido[ nPosicao ][ 4 ],;
                                         VLRUNI With aPedido[ nPosicao ][ 5 ],;
                                         DTENTR With aPedido[ nPosicao ][ 24 ],;
                                         SELECT With "Sim",;
                                         EXIBIR With IF( nPosicao <= 1, "S", " " )

                              ENDIF
                              DBUnlock()
                           ENDIF
                        ENDIF
                        DBUnlockAll()
                        DBSkip()
                    ENDDO
                 EndIf
                 IF SWSet( _INT_GRAVANOTA )
                    DBSelectar( _COD_PEDIDO )
                    Set Relation To
                    NFiscal( PED->CODPED )
                    SWSet( _INT_GRAVANOTA, .F. )
                    NF_->( DBSetOrder( 4 ) )
                    nAreaRes:= Select()
                    DBSelectar( _COD_PEDIDO )
                    Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA
                    DBSelectAr( nAreaRes )
                 ENDIF

              /* SE FOR PEDIDO */
              ELSE

                 //                                                     //
                 //    ���������������������������������������������    //
                 //     Esta opcao faz a regravacao das informacoes     //
                 //     sobre um pedido que ja exista, nao  criando     //
                 //     um novo codigo para isto, conforme abaixo.      //
                 //    ���������������������������������������������    //
                 //                                                     //

                 Aviso( "Esta cotacao ja esta gravada como pedido.", 24 / 2 )
                 Mensagem( "Pressione [ENTER] para continuar..." )
                 ScreenRest( cTelaReserva )
                 DBSelectar( _COD_PEDIDO )
                 cCodCot:= Codigo
                 DBSetOrder( 6 )
                 DBGoBottom()
                 cCodPed:= StrZero( Val( CodPed ), 8, 0 )
                 DBSetOrder( 1 )
                 nVlrTot:= 0
                 FOR nCt:= 1 TO Len( aPedido )
                     IF aPedido[ nCt ][ 10 ]=="Sim"
                        nVlrIpi:= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
                        nVlrTot:= nVlrTot + nVlrIpi + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] )
                     ENDIF
                 NEXT

                 /* Com Condicoes de Pagamento */
                 CND->( DBSetOrder( 1 ) )
                 IF CND->( DBSeek( nTabCnd ) )
                    nVlrTot:= CalculoGeral( aPedido, CND->PERACR, CND->PERDES )
                 ENDIF

                 For nCt:= 1 To Len( aCotacoes )
                     If DBSeek( aCotacoes[ nCt ][ 1 ] )
                        IF netrlock()
                           Replace Situa_ With "PED",;
                                   Select With "Nao",;
                                   VlrTot With nVlrTot
                        EndIf
                        DBUnLock()
                     Else
                        Aviso( "Cotacao n� " + aCotacoes[ nCt ][ 1 ] + " nao foi encontrada...", 24 / 2 )
                        Pausa()
                     EndIf
                 Next
                 IF ! SWSet( _PED_CONTROLES )
                    Aviso( "Atualizando os produtos...", 24 / 2 )
                    Mensagem( "Gravando arquivo de produtos por PEDIDOS, aguarde..." )
                 ENDIF
                 DBSelectar( _COD_PEDPROD )
                 DBSetOrder( 1 )
                 nCt:= 0
                 If DBSeek( cCodCot )
                    WHILE left( cCodCot, 8 ) == Left( PxP->Codigo, 8 )
                        IF netrlock()
                           IF ( nPosicao:= AScan( aPedido, {|x| Alltrim( x[1] ) == Alltrim( PXP->CODFAB ) .AND.;
                                                                Alltrim( x[2] ) == Alltrim( PXP->DESCRI ) .AND.;
                                                                x[12] == Recno() } ) ) > 0
                              IF aPedido[ nPosicao ][ 10 ] == "Nao"
                                 DBSelectAr( _COD_DETALHE )
                                 DET->( DBSETorder( 1 ) )
                                 IF DBseek( PED->CODIGO + pad(strzero(PXP->CODPRO,7),12) + str(nPosicao,3))
                                    if netrlock()
                                       dele
                                       Dbunlock()
                                    endif
                                 ENDIF
                                 DET->( DBSETorder( 2 ) )
                                 DET->( DBseek( PED->CODIGO , .t.) )
                                 nProdatu := 1
                                 While !eof() .and. CODPED = PED->CODIGO
                                    if netrlock()
                                       repl ORDEM_ with nProdatu
                                       Dbunlock()
                                    endif
                                    Dbskip()
                                    nProdatu ++
                                 enddo
                                 DET->( DBSETorder( 1 ) )
                                 DBSelectar( _COD_PEDPROD )
                                 IF netrlock()
                                    Dele
                                 ENDIF
                              ELSE
                                 IF netrlock()
                                    Replace QUANT_ With aPedido[ nPosicao ][ 6 ],;
                                            VLRINI With aPedido[ nPosicao ][ 3 ],;
                                            PERDES With aPedido[ nPosicao ][ 4 ],;
                                            VLRUNI With aPedido[ nPosicao ][ 5 ],;
                                            DTENTR With aPedido[ nPosicao ][ 24 ],;
                                            SELECT With "Sim",;
                                            CODPED With cCodPed,;
                                            EXIBIR With IF( nPosicao==1, "S", " " )
                                 ENDIF
                              ENDIF
                           ENDIF
                        ENDIF
                        DBUnlockAll()
                        DBSkip()
                    ENDDO
                 ENDIF
                 IF SWSet( _INT_GRAVANOTA )
                    NFiscal( PED->CODPED )
                    SWSet( _INT_GRAVANOTA, .F. )
                 ENDIF
              ENDIF

              // Controle = Grava nota
              IF SWSet( _PED_CONTROLES )
                 IF PED->CODCLI == 0
                    WHILE .T.
                        SWAlerta( "<< Falha na Atualizacao de Estoque >>;Pedido esta sem a informacao do cliente.;Antes de tentar gravar o pedido voce deve; carregar os dados do cliente por CTRL+A.", { "  OK  " } )
                        EXIT
                        /*
                        mensagem( "Pressione [TAB] para continuar" )
                        INKEY(0)
                        IF LastKey() == K_TAB .OR. NextKey() == K_TAB
                           EXIT
                        ENDIF
                        */
                    ENDDO
                 ELSEIF PED->CODNF_ <= 0 .OR. PED->CODNF_ >= 900000000
                    PedidoProcessa()
                    oTb:RefreshAll()
                    WHILE !oTb:Stabilize()
                    ENDDO
                 ELSEIF PED->CODNF_ < 900000000
                    //SWAlerta( "Nota fiscal ja processada. Se houver troca de mercadoria; Ou qualquer outro tipo de entrada ou sa�da para movimentar estoque; deve ser feito um lancamento manual ou um novo pedido,; porque estas moficacoes n�o terao efeito sobre os lancamentos; que ja estao realizados.", { "OK" } )
                 ENDIF
              ENDIF
              EXIT


         case nTecla==K_INS
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 )
              VPBox( 10, 10, 20, 70, "INCLUSAO DE ITEM", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
              SetColor( _COR_GET_EDICAO )
              cCodigo:= "9999"
              cGrupo_:= "999"
              nPrecoInicial:= 0.00
              nPerDesconto:= 0.00
              nPrecoFinal:= 0.00
              nQuantidade:= 0.00
              nUnidades:= 0.00
              nPercIPI:= 0.00
              dDtentre := space(10)
              SetCursor(1)
              nOperacao:= PED->TABOPE
              OPE->( DBSetOrder( 1 ) )
              IF !nOperacao==0
                 OPE->( DBSetOrder( 1 ) )
                 OPE->( DBSeek( nOperacao ) )
                 PRE->( DBSetOrder( 1 ) )
                 PRE->( DBSeek( OPE->TABPRE ) )
                 CND->( DBSetOrder( 1 ) )
                 CND->( DBSeek( OPE->TABCND ) )
              ENDIF
              IF SWSet( _PED_FORMULARIO ) == 2
                 @ 11,12 Say "Produto....:" Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo )
                 @ 11,30 Say "-"
                 @ 11,31 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList ) when mensagem("Digite o c�digo do produto.")
                 READ
                 IF MPR->PRECOV > 0 .AND.;
                    CND->CODIGO > 0 .AND.;
                    PRE->CODIGO > 0 .AND.  OPE->CODIGO > 0
                    nPrecoInicial:= PrecoCnd( 1 )
                    nPrecoFinal:=   PrecoCnd( CND->CODIGO )
                 ELSE
                    nPrecoInicial:= MPR->PRECOV
                    nPrecoFinal:=   MPR->PRECOV
                    INKEY( 0 )
                 ENDIF
                 nPercIPI:= MPR->IPI___
                 @ 12,12 Say "Descri��o..: [" + Left( MPR->DESCRI, 30 ) + "]"
                 @ 13,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
                 @ 14,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999"
                 @ 15,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 16,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 IF SWSet( _PED_DTENTREGA )
                    @ 17,12 Say "Entrega....:" Get dDtentre      pict "@!"
                 ENDIF
              ELSE
                 @ 11,12 Say "Produto....:" Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo )
                 @ 11,30 Say "-"
                 @ 11,31 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList ) when mensagem("Digite o c�digo do produto.")
                 @ 12,12 Say "Descri��o..: [" + Space( 40 ) + "]"
                 @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999"
                 @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 IF SWSet( _PED_DTENTREGA )
                    @ 16,12 Say "Entrega....:" Get dDtentre      pict "@!"
                 ENDIF
                 IF SWSet( _PED_FORMATO ) = 5 // METAIS DAR
                    @ 16,37 Say "Unidades...:" Get nUnidades pict "9999.99" valid F_CalUnixQuan(nUnidades,@nQuantidade)
                 ENDIF
                 @ 17,12 Say "% IPI......:" Get nPercIPI Pict "@E 99,999.99"
                 VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
              ENDIF
              Read

              /* Descricao do produto - codigo fabrica */
              IF SWSet( _PED_INFO_EXTRA )
                 cCodFab:= Space( 15 )
                 cDescricao:= Space( 40 )
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                 VPBox( 11, 10, 14, 74, " Produto ", _COR_GET_BOX )
                 @ 12,12 Say "Codigo Fabrica:" Get cCodFab
                 @ 13,12 Say "Descricao.....:" Get cDescricao
                 Read
                 ScreenRest( cTelaRes )
              ENDIF

              If LastKey() <> K_ESC .AND. UpDated()
                 AAdd( aPedido, { Space( 15 ),;
                                  Space( 50 ),;
                                         0.00,;
                                         0.00,;
                                         0.00,;
                                         0.00,;
                                         Spac( 2 ),;
                                         nPercIPI,;
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
                                         0,;
                                         Space( 65 ),;
                                         Space( 65 ),;
                                         Space( 65 ),;
                                         ctod("")    } )

                 nRow:= Len( aPedido )
                 aPedido[ nRow ][ 1 ]:= MPr->CodFab
                 aPedido[ nRow ][ 2 ]:= MPr->Descri
                 IF SWSet( _PED_INFO_EXTRA )
                    aPedido[ nRow ][ 1 ]:= cCodFab
                    aPedido[ nRow ][ 2 ]:= cDescricao
                 ENDIF
                 aPedido[ nRow ][ 10 ]:= "Sim"
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial
                 aPedido[ nRow ][ 4 ]:= nPerDesconto
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal
                 aPedido[ nRow ][ 6 ]:= nQuantidade
                 aPedido[ nRow ][ 11 ]:= MPr->Origem
                 aPedido[ nRow ][ 15 ]:= PRE->CODIGO
                 aPedido[ nRow ][ 16 ]:= PRE->DESCRI
                 aPedido[ nRow ][ 17 ]:= VAL( Mpr->Indice )
                 aPedido[ nRow ][ 24 ]:= dDtentre
                 DBSelectAr( _COD_PEDPROD )
                 DBAppend()
                 IF netrlock()
                    Replace CODIGO With PED->CODIGO,;
                            CODPRO With VAL( cGrupo_ + cCodigo ),;
                            CODFAB With aPedido[ nRow ][ 1 ],;
                            DESCRI With aPedido[ nRow ][ 2 ],;
                            UNIDAD With aPedido[ nRow ][ 7 ],;
                            QUANT_ With aPedido[ nRow ][ 6 ],;
                            VLRINI With aPedido[ nRow ][ 3 ],;
                            PERDES With aPedido[ nRow ][ 4 ],;
                            VLRUNI With aPedido[ nRow ][ 5 ],;
                            IPI___ With aPedido[ nRow ][ 8 ],;
                            ICM___ With MPR->ICM___,;
                            SELECT With "Sim",;
                            ORIGEM With aPedido[ nRow ][ 11 ],;
                            PCPCLA With aPedido[ nRow ][ 18 ],;
                            PCPTAM With aPedido[ nRow ][ 19 ],;
                            PCPCOR With aPedido[ nRow ][ 20 ],;
                            DTENTR With aPedido[ nRow ][ 24 ]
                 ENDIF
                 DBUnlock()
                 aPedido[ nRow ][ 12 ]:= Recno()
              ENDIF
              ScreenRest( cTelaReserva )
              SetColor( _COR_BROWSE )

              /* Desconto & Acrescimo */
              CND->( dbSetOrder( 1 ) )
              CND->( DBSeek( PED->TABCND ) )

              nPerAcr:= CND->PERACR
              nPerDes:= CND->PERDES

              CalculoGeral( aPedido, nPerAcr, nPerDes )

              oTb:RefreshAll()
              WHILE !oTb:stabilize()
              ENDDO

         Case nTecla==K_SPACE
              aPedido[ nRow ][ 10 ]:= If( aPedido[ nRow ][ 10 ]=="Sim", "Nao", "Sim" )

              /* Desconto & Acrescimo */
              CND->( DBSetOrder( 1 ) )
              CND->( DBSeek( PED->TABCND ))

              nPerAcr:= CND->PERACR
              nPerDes:= CND->PERDES

              CalculoGeral( aPedido, nPerAcr, nPerDes )

         Case nTecla==K_ENTER
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 )
              SetColor( _COR_GET_EDICAO )
              cDescri:=       aPedido[ nRow ][ 2 ]
              nPrecoInicial:= aPedido[ nRow ][ 3 ]
              nPerDesconto:=  aPedido[ nRow ][ 4 ]
              nPrecoFinal:=   aPedido[ nRow ][ 5 ]
              nQuantidade:=   aPedido[ nRow ][ 6 ]
              nPerDesconto:=  ( ( nPrecoFinal / nPrecoInicial ) * 100 ) - 100
              nPerDesconto:=  nPerDesconto * (-1)
              // Busca Produto
              MPR->( DBSetOrder( 1 ) )
              MPR->( DBSeek( Pad( Strzero( aPedido[ nRow ][ 17 ], 7 ), 12 ) ) )

              nUnidades:= 0
*              nUnidades:= (nQuantidade/MPR->QTDPES)

              nPerIpi:=       aPedido[ nRow ][ 8 ]
              cUnidad:=       aPedido[ nRow ][ 7 ]
              cOrigem:=       aPedido[ nRow ][ 11 ]
              cDetal1:=       aPedido[ nRow ][ 21 ]
              cDetal2:=       aPedido[ nRow ][ 22 ]
              cDetal3:=       aPedido[ nRow ][ 23 ]
              dDtentre:=      aPedido[ nRow ][ 24 ]

              SetCursor(1)

              IF SWSet( _PED_FORMULARIO ) == 2
                 VPBox( 09, 10, 18, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 10,12 Say "Produto....: [" + aPedido[ nRow ][ 1 ] + "]"
                 @ 11,12 Say "Descri��o..: [" + Left( aPedido[ nRow ][ 2 ], 26 ) + "]"
                 @ 12,12 Say "Fabricante.: [" + cOrigem + "]"
                 @ 13,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
                 @ 14,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999"     When MudaPreco()
                 @ 15,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"             Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 16,12 Say "Pre�o Venda:" Get nPrecoFinal   Pict "@E 999,999,999.999"    Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 IF SWSet( _PED_DTENTREGA )
                    @ 17,12 Say "Entrega....:" Get dDtentre      pict "@!"
                 ENDIF
              ELSEIF SWSet( _PED_FORMULARIO ) == 3
                 VPBox( 09, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 10,12 Say "Produto....: [" + aPedido[ nRow ][ 1 ] + "]"
                 @ 11,12 Say "Descri��o..:" Get cDescri Pict "@S36"
                 @ 12,12 Say "Fabricante.:" Get cOrigem when CodFabrica()
                 @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999"     When MudaPreco()
                 @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"             Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999"    Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 16,12 Say "Perc. IPI..:" Get nPerIpi       Pict "@E 999.99"
                 @ 17,12 Say "Unidade....:" Get cUnidad
                 VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999"
              ELSE
                 VPBox( 09, 10, 21, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 10,12 Say "Produto....: [" + aPedido[ nRow ][ 1 ] + "]"
                 @ 11,12 Say "Descri��o..:" Get cDescri Pict "@S36"
                 @ 12,12 Say "Fabricante.:" Get cOrigem when CodFabrica()
                 @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999" When MudaPreco()
                 @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid CalculaDesconto( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" Valid VerifPerDesc( GetList, @nPrecoInicial, @nPerDesconto, @nPrecoFinal )
                 @ 16,12 Say "Perc. IPI..:" Get nPerIpi       Pict "@E 999.99"
                 @ 17,12 Say "Unidade....:" Get cUnidad
                 IF SWSet( _PED_DTENTREGA )
                    @ 18,12 Say "Entrega....:" Get dDtentre      pict "@!"
                 ENDIF
                 IF SWSet( _PED_FORMATO ) == 5 // METAIS DAR
                    @ 18,37 Say "Unidades...:" Get nUnidades pict "9999.99" valid F_CalUnixQuan(nUnidades,@nQuantidade)
                 ENDIF
                 VPBox( 19, 10, 21, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 20,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" Valid IIF( SWSet( _PED_FORMATO )==10, nQuantidade > 0, .T. )
              ENDIF
              Read

              /* Detalhamento do produto no pedido */
              IF SWSet( _PED_DETALHE )
                 VPBox( 09, 03, 16, 76, "DADOS DO PRODUTO", _COR_GET_BOX, .T., .F., _COR_GET_TITULO )
                 @ 11,05 Say "Detalhamento"
                 @ 12,05 Get cDetal1
                 @ 13,05 Get cDetal2
                 @ 14,05 Get cDetal3
                 READ
                 IF !( LastKey()==K_ESC )
                    aPedido[ nRow ][ 21 ]:=  cDetal1
                    aPedido[ nRow ][ 22 ]:=  cDetal2
                    aPedido[ nRow ][ 23 ]:=  cDetal3
                 ENDIF
              ENDIF

              /* Testa se tecla == K_ESC */
              If LastKey() <> K_ESC .AND. UpDated()
                 aPedido[ nRow ][ 10 ]:= "Sim"
                 aPedido[ nRow ][ 2 ]:= cDescri
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial
                 aPedido[ nRow ][ 4 ]:= nPerDesconto
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal
                 aPedido[ nRow ][ 6 ]:= nQuantidade
                 aPedido[ nRow ][ 8 ]:= nPerIpi
                 aPedido[ nRow ][ 7 ]:= cUnidad
                 aPedido[ nRow ][ 24 ]:= dDtentre
              EndIf
              nValorTotal:= 0
              FOR nCt:= 1 To Len( aPedido )
                  nValorTotal:= nValorTotal + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] )
              NEXT
              ScreenRest( cTelaReserva )
              SetColor( _COR_BROWSE )

              /* Desconto & Acrescimo */

              nPerAcr:= CND->PERACR
              nPerDes:= CND->PERDES

              /* Desconto & Acrescimo */
              CND->( DBSetOrder( 1 ) )
              CND->( DBSeek( PED->TABCND ))

              nPerAcr:= CND->PERACR
              nPerDes:= CND->PERDES

              CalculoGeral( aPedido, nPerAcr, nPerDes )

              DBSelectar( _COD_PEDIDO )
              cCodCot:= Codigo
              IF netrlock()
                 Replace VlrTot With nValorTotal
              ENDIF
              DBUnlock()
              DBSelectar( _COD_PEDPROD )
              DBSetOrder( 1 )
              nCt:= 0
              If DBSeek( cCodCot )
                 While left( cCodCot, 8 ) == Left( PxP->Codigo, 8 )
                     IF ( nPosicao:= AScan( aPedido, {|x| x[12] == Recno() } ) ) > 0
                        IF netrlock()
                           Repl CODFAB With aPedido[ nPosicao ][ 1 ],;
                                DESCRI With aPedido[ nPosicao ][ 2 ],;
                                VLRUNI With aPedido[ nPosicao ][ 5 ],;
                                VLRINI With aPedido[ nPosicao ][ 3 ],;
                                PERDES With aPedido[ nPosicao ][ 4 ],;
                                QUANT_ With aPedido[ nPosicao ][ 6 ],;
                                IPI___ With aPedido[ nPosicao ][ 8 ],;
                                UNIDAD With aPedido[ nPosicao ][ 7 ],;
                                DTENTR With aPedido[ nPosicao ][ 24 ]

                            IF SWSet( _PED_DETALHE )
                               /* Gravacoes em detalhes */
                               DET->( DBSETorder( 1 ) )
                               DET->(DBseek( PED->CODIGO + pad(strzero(PXP->CODPRO,7),12) + str(nPosicao,3)))
                               /* se nao tiver gravado antes grava agora se tem algo */
                               IF (!EMPTY( aPedido[nPosicao,21] ) .or. ;
                                   !EMPTY( aPedido[nPosicao,22] ) .or. ;
                                   !EMPTY( aPedido[nPosicao,23] )) .and. DET->( eof() )
                                   DET->( DBAppend() )
                                   IF DET->( netrlock() )
                                      Replace DET->INDICE With pad(strzero(PXP->CODPRO,7),12) ,;
                                              DET->ORDEM_ With nPosicao                       ,;
                                              DET->CODPED With PED->CODIGO
                                      Dbunlock()
                                   ENDIF
                               endif

                               if DET->( netrlock() )
                                  repl DET->DETAL1 with aPedido[nPosicao,21]
                                  repl DET->DETAL2 with aPedido[nPosicao,22]
                                  repl DET->DETAL3 with aPedido[nPosicao,23]
                                  DET->( DBunlock() )
                               endif
                            ENDIF
                        ENDIF
                     ENDIF
                     DBUnlock()
                     DBSkip()
                 EndDo
              EndIf
         otherwise                ;tone(125); tone(300)
      endcase
      oTb:refreshcurrent()
      oTb:stabilize()
   ENDDO

   /* Verifica se e' pedido ou se foi gravado com G ou F1 */
   IF lPedido .OR. CHR( nTecla ) $ "Gg" .OR. nTecla==K_F1
      FOR nCt:= 1 TO Len( aPedido )
          IF aPedido[ nCt ][ 10 ] == "Sim"
             IF VALTYPE( aPedido[ nCt ][ 17 ] )=="N"
                ControleDeReserva( "+", PAD( StrZero( aPedido[ nCt ][ 17 ], 7, 0 ), 12 ), aPedido[ nCt ][ 6 ] )
             ELSEIF VALTYPE( aPedido[ nCt ][ 17 ] )=="C"
                ControleDeReserva( "+", PAD( StrZero( VAL( aPedido[ nCt ][ 17 ] ), 7, 0 ), 12 ), aPedido[ nCt ][ 6 ] )
             ENDIF
          ENDIF
      NEXT
   ENDIF

   //////////////// TESTE DE REMENDO /////////////////
   nVlrTot:= 0

   FOR nCt:= 1 TO Len( aPedido )
        IF aPedido[ nCt ][ 10 ]=="Sim"
             nVlrIpi:= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
             nVlrTot:= nVlrTot + nVlrIpi + ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] )
        ENDIF
   NEXT
   DBSelectAr( _COD_PEDIDO )
   IF netrlock()
      Replace VlrTot With nVlrTot
   EndIf
   DBUnLock()




   SetCursor( 1 )
   SetColor( cCor )
   ScreenRest( cTela )
   DBUnlockAll()
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )
   return(if(nTecla=27,.f.,.t.))


/*
* Modulo      - CalculoGeral
* Finalidade  - Apresentar no rodap� o calculo total do pedido
* Programador - Valmor Pereira Flores
* Data        - 26/Outubro/1995
* Atualizacao -
*/
Static Function CalculoGeral( aPedido, nPerAcr, nPerDes )
Local cCor:= SetColor()
Local nSubTotal:= 0, nIPI:= 0, nTotal:= 0, nDesconto:= 0, nAcrescimo:= 0
Local nCt
   DispBegin()
   SetColor( "W+/G" )
   Scroll( 21, 1, 22, 78 )
   For nCt:= 1 To Len( aPedido )
       If aPedido[ nCt ][ 10 ] == "Sim"
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ]
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100
       EndIf
   Next
   IF nPerAcr == Nil
      nPerAcr:= 0
   ENDIF
   IF nPerDes == Nil
      nPerDes:= 0
   ENDIF
   nAcrescimo:= ( nSubTotal * ( nPerAcr / 100 ) )
   nDesconto:=  ( nSubTotal * ( nPerDes / 100 ) )
   nTotal:= nSubTotal + nIPI
   @ 21, 01 Say "Sub-Total..: " + Tran( nSubTotal, "@E 999,999,999,999.99" )
   @ 22, 01 Say "Valor IPI..: " + Tran( nIPI,      "@E 999,999,999,999.99" )
   @ 22, 47 Say "Total Geral: " + Tran( nTotal + ( nAcrescimo - nDesconto ),    "@E 999,999,999,999.99" )
   SetColor( cCor )
   DispEnd()
Return ( nTotal + ( nAcrescimo - nDesconto ) )


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
   IF SWSet( _PED_FORMULARIO ) == 2
      GetList[1]:VarPut( Left( MPr->Indice, 3 ) )
      GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) )
   ELSE
      GetList[1]:VarPut( Left( MPr->Indice, 3 ) )
      GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) )
      GetList[3]:VarPut( IF( MPR->PERCDC > 0, MPR->PRECOD, MPR->PRECOV )  )
      GetList[4]:VarPut( )             //* gelson 28012005 *//
      GetList[5]:VarPut( )
      GetList[6]:VarPut( )
      GetList[7]:VarPut( MPR->IPI___ ) //* gelson 28012005 *//
   ENDIF
   FOR nCt:=1 To Len( GetList )
       GetList[ nCt ]:Display()
   NEXT
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )
   Return( .T. )


Function MudaPreco()
Local nTecla
   IF !SWSet( _PED_MUDARPRECO )
      IF LastKey() == K_ENTER .OR.;
         LastKey() == K_DOWN .OR.;
         LastKey() == 0
         nTecla:= K_DOWN
      ELSEIF LastKey() == K_UP
         nTecla:= K_UP
      ELSE
         nTecla:= K_DOWN
      ENDIF
      Keyboard Chr( nTecla )
   ENDIF
   Return .T.

Function CodFabrica()
   IF !SWSet( _PED_CODFABRICA )
      Keyboard Chr( K_DOWN )
   ENDIF
   Return .T.


/***
*
*   FreshOrder()
*
*   Refresh respecting any change in index order
*/

Static Func FreshOrder(oB)

local nRec

   nRec := Recno()
   oB:refreshAll()

   /* stabilize to see if TBrowse moves the record pointer */
   oB:forceStable()

   if ( nRec != LastRec() + 1 )
      /* record pointer may move if bof is on screen */
      while ( Recno() != nRec .and. !ob:hitTop )
         /* falls through unless record is closer to bof than before */
         oB:up():forceStable()
      end
   end

return (NIL)


Function ClientesEdicao( nFormato, oTab )
Local cTela:= ScreenSave( 0, 0, 24, 79 )
Local cCor:= SetColor()
LOCAL lAtualizarPedido:= .F.
   DO CASE
      CASE nFormato==1      //// INCLSAO DE CLIENTE NA BASE DE DADOS
         /* Incluir Cliente */
         ClientesInclusao()
         IF LastKey() <> K_ESC
            lAtualizarPedido:= .T.
         ENDIF

      CASE nFormato==2      //// BUSCA DE CLIENTE NA BASE DE DADOS
         CLI->( DBSetOrder( 1 ) )
         CLI->( DBSeek( PED->CODCLI ) )
         PesqCli()
         IF LastKey() <> K_ESC
            lAtualizarPedido:= .T.
         ENDIF

   ENDCASE
   IF lAtualizarPedido
      VPBox( 0, 0, 22, 79, "SUBSTITUICAO DE INFORMACOES", _COR_GET_EDICAO )
      SetColor( _COR_GET_EDICAO )
      @ 02,02 Say "Nome   " Color "14/" + CorFundoAtual()
      @ 04,02 Say "End.   " Color "14/" + CorFundoAtual()
      @ 06,02 Say "Bairro " Color "14/" + CorFundoAtual()
      @ 08,02 Say "Cidade " Color "14/" + CorFundoAtual()
      @ 10,02 Say "Estado " Color "14/" + CorFundoAtual()
      @ 12,02 Say "Cep    " Color "14/" + CorFundoAtual()
      @ 14,02 Say "CGC/MF " Color "14/" + CorFundoAtual()
      @ 16,02 Say "Inscr. " Color "14/" + CorFundoAtual()
      @ 18,02 Say "Codigo " Color "14/" + CorFundoAtual()
      @ 20,02 Say "Fon/Fax" Color "14/" + CorFundoAtual()

      @ 01,10 Say "Informacao Atual"
      @ 02,10 Say LEFT( PED->DESCRI, 29 ) Color "11/"+CorFundoAtual()
      @ 04,10 Say LEFT( PED->ENDERE, 29 ) Color "11/"+CorFundoAtual()
      @ 06,10 Say LEFT( PED->BAIRRO, 29 ) Color "11/"+CorFundoAtual()
      @ 08,10 Say LEFT( PED->CIDADE, 29 ) Color "11/"+CorFundoAtual()
      @ 10,10 Say LEFT( PED->ESTADO, 29 ) Color "11/"+CorFundoAtual()
      @ 12,10 Say LEFT( PED->CODCEP, 29 ) Color "11/"+CorFundoAtual()
      @ 14,10 Say LEFT( PED->CGCMF_, 29 ) Color "11/"+CorFundoAtual()
      @ 16,10 Say LEFT( PED->INSCRI, 29 ) Color "11/"+CorFundoAtual()
      @ 18,10 Say ALLTRIM( STR( PED->CODCLI, 9 ) ) Color "11/"+CorFundoAtual()
      @ 20,10 Say PED->FONFAX Color "11/"+CorFundoAtual()

      @ 01,40 Say "Informacao apos atualizacao"
      @ 02,40 Say LEFT( CLI->DESCRI, 29 ) Color "12/"+CorFundoAtual()
      @ 04,40 Say LEFT( CLI->ENDERE, 29 ) Color "12/"+CorFundoAtual()
      @ 06,40 Say LEFT( CLI->BAIRRO, 29 ) Color "12/"+CorFundoAtual()
      @ 08,40 Say LEFT( CLI->CIDADE, 29 ) Color "12/"+CorFundoAtual()
      @ 10,40 Say LEFT( CLI->ESTADO, 29 ) Color "12/"+CorFundoAtual()
      @ 12,40 Say LEFT( CLI->CODCEP, 29 ) Color "12/"+CorFundoAtual()
      @ 14,40 Say LEFT( CLI->CGCMF_, 29 ) Color "12/"+CorFundoAtual()
      @ 16,40 Say LEFT( CLI->INSCRI, 29 ) Color "12/"+CorFundoAtual()
      @ 18,40 Say ALLTRIM( STR( CLI->CODIGO, 9 ) ) Color "12/"+CorFundoAtual()
      @ 20,40 Say Cli->Fone1_ + " / " + Cli->Fax___ Color "12/" + CorFundoAtual()

      @ 02,01 Say IF( !ALLTRIM( PED->DESCRI ) == ALLTRIM( CLI->DESCRI ), "*", " " )
      @ 04,01 Say IF( !ALLTRIM( PED->ENDERE ) == ALLTRIM( CLI->ENDERE ), "*", " " )
      @ 06,01 Say IF( !ALLTRIM( PED->BAIRRO ) == ALLTRIM( CLI->BAIRRO ), "*", " " )
      @ 08,01 Say IF( !ALLTRIM( PED->CIDADE ) == ALLTRIM( CLI->CIDADE ), "*", " " )
      @ 10,01 Say IF( !ALLTRIM( PED->ESTADO ) == ALLTRIM( CLI->ESTADO ), "*", " " )
      @ 12,01 Say IF( !ALLTRIM( PED->CODCEP ) == ALLTRIM( CLI->CODCEP ), "*", " " )
      @ 14,01 Say IF( !ALLTRIM( PED->CGCMF_ ) == ALLTRIM( CLI->CGCMF_ ), "*", " " )
      @ 16,01 Say IF( !ALLTRIM( PED->INSCRI ) == ALLTRIM( CLI->INSCRI ), "*", " " )
      @ 18,01 Say IF( PED->CODCLI <> CLI->CODIGO, "*", " " )
      @ 20,01 Say ""

      Mensagem( "Pressione qualquer tecla para atualizar ou [ESC] para cancelar" )
      Inkey( 0 )

      IF LastKey() <> K_ESC
         Aviso( "Atualizando cadastro de clientes no pedido..." )
         IF PED->( netrlock() )

            // Fone/Fax foi adicionado nesta lista no dia 18/09/2003
            // por Valmor Flores

            Replace PED->DESCRI With CLI->DESCRI,;
                    PED->ENDERE With CLI->ENDERE,;
                    PED->BAIRRO With CLI->BAIRRO,;
                    PED->CIDADE With CLI->CIDADE,;
                    PED->ESTADO With CLI->ESTADO,;
                    PED->CODCEP With CLI->CODCEP,;
                    PED->CGCMF_ With CLI->CGCMF_,;
                    PED->INSCRI With CLI->INSCRI,;
                    PED->CODCLI With CLI->CODIGO,;
                    PED->FONFAX With Cli->Fone1_ + " / " + Cli->Fax___


         ENDIF
         DBUnlockAll()
      ENDIF
   ENDIF
   SetColor( cCor )
   ScreenRest( cTela )
   IF oTab <> Nil
      oTab:refreshAll()
      WHILE !oTab:Stabilize()
      ENDDO
   ENDIF
   Return Nil

Function F_CalUnixQuan(nUnidades,nQuantidade)
if nUnidades <> 0
   nQuantidade := (nUnidades*MPR->QTDPES)
endif
retu .t.

Function EditaPlaca( oTb )
Local cTelaRes:= SaveScreen(), nCurRes:= SetCursor(), cPlaca_
               SetCursor( 1 )
               VPBox( 16, 10, 20, 60, " IDENTIFICACAO ", _COR_GET_BOX )
               cPlaca_:= PED->IDENT_
               @ 18,13 Say "Digite a identificacao:" Get cPlaca_ Color _COR_GET_EDICAO
               Read
               IF LastKey() <> K_ESC
                  IF PED->( RLOCK() )
                     Replace PED->IDENT_ WITH cPlaca_
                  ENDIF
                  PED->( DBUnlock() )
               ENDIF
               RestScreen( cTelaRes )
               // REFRESH
               if oTb <> Nil
                  oTB:RefreshAll()
                  WHILE !oTb:Stabilize()
                  ENDDO
               endif
               SetCursor( nCurRes )



** 614

