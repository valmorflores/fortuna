// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � vpc888700 
� Finalidade  � Relacionar pedidos pendentes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc88870()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Loca  oTb, oCLIE, nTECLA, nTELA:=1, nCODCLI, nCODPRO, cTELA0,; 
      cDESCLI, cDESPRO, lFLAG:=.F., lALTERAPOS:=.T. 
Loca GETLIST:={} 
Local aProdutos:= {}, cCodigoDele 
 
/* Variaveis para pedido */ 
Local nPosicao:= 0, nPrecoInicial, nPerDesconto, nPrecoFinal, nQuantidade,; 
      cCliente, aPedido:= {}, lAltera:= .F., cTelaRes 
 
SetCursor(0) 
DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(00,00,12,79,"Pedidos Pendentes - Emissao de Romaneio", _COR_BROW_BOX ,.F.,.F., _COR_BROW_TITULO, .F. ) 
VPBOX(13,00,22,79,"Display", _COR_BROW_BOX ,.F.,.F., _COR_BROW_TITULO, .F. ) 
 
SetColor( _COR_BROWSE ) 
@ 02,02 Say "Nome....:" 
@ 03,02 Say "Endereco:" 
@ 04,02 Say "Cidade..:" 
@ 05,02 Say "Fone....:" 
@ 06,02 Say "FAX.....:" 
@ 07,02 Say "Contato.:" 
@ 08,02 Say "Transpor:" 
@ 09,02 Say "Data....:" 
@ 10,02 Say "Vendedor:" 
@ 11,02 Say "Operacao:" 
DispEnd() 
Ajuda("["+_SETAS+"][PgDn][PgUp][Home][End]Move "+; 
      "[Nome/Codigo]Pesquisa") 
Mensagem("[INS]Novo [ENTER]Alt [F2]Pendente [F3..F6]Ordem [DEL]Exclui [Ctrl+TAB]Menu") 
 
DBSelectAr( _COD_TRANSPORTE ) 
DBSetOrder( 1 ) 
 
DBSelectAr( _COD_NFISCAL ) 
DBSetOrder( 4 ) 
 
DBSelectar( _COD_PEDIDO ) 
DBSetOrder( 1 ) 
 
DBGoBottom() 
SetColor( _COR_BROWSE ) 
 
DBLeOrdem() 
 
/* inicializacao do browse */ 
oTb:=TBrowseDb( 14, 02, 21, 75 ) 
oTb:AddColumn( TbColumnNew("C/P Numero Cliente                                Vlr.Ped.  Nota    Vlr.Nf.",; 
               {|| Left( Situa_, 1 ) + " " + IF( !Empty( CodPed ), CodPed, Codigo ) + " " + ; 
                   Left( Descri, 36 ) + " " + Tran( VlrTot,  "@EZ 99999.99" ) + NF_->NFNULA + " " + StrZero( CODNF_, 8, 0 ) + " " + Tran( 0, "@E 999,999.99" ) + Space( 20 ) } ) ) 
oTb:AUTOLITE:=.F. 
oTb:dehilite() 
While .T. 
      oTb:ColorRect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      Whil NextKey()=0 .and.! oTb:Stabilize() 
      enddo 
      SetColor( _COR_BROW_LETRA ) 
      IF CODNF_ == 0 
         SetColor( "15/02" ) 
         @ Row(), 58 Say " < Pendente > " 
         SetColor( _COR_BROWSE ) 
      ENDIF 
 
      DevPos( 01, 02 ) 
      IF !Empty( CodPed ) 
         DevOut( "Pedido..: " + CodPed ) 
         SetColor( "14/01" ) 
      ELSE 
         DevOut( "Cotacao.: " + Codigo ) 
         SetColor( _COR_BROW_LETRA ) 
         @ 01, 55 Say Space( 21 ) 
      ENDIF 
 
      SetColor( _COR_BROW_LETRA ) 
      @ 2, 12 Say Descri 
      @ 3, 12 Say Endere 
      @ 4, 12 Say Cidade 
      @ 5, 12 Say Tran( Left( FonFax, AT( "/", FonFax ) - 1 ),  "@R (9999)-9999.9999" ) 
      @ 6, 12 Say Tran( SubStr( FonFax, AT( "/", FonFax ) + 2 ), "@R (9999)-9999.9999" ) 
      @ 7, 12 Say Compra 
      @ 8, 12 Say StrZero( Transp, 4, 0 ) + "-" + TRA->Descri 
      @ 9, 12 Say Data__ 
 
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
         case nTecla==K_F2 
              DBSelectAr( _COD_PEDIDO ) 
              DBSetOrder( 5 ) 
              DBSeek( 0 ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
         case nTecla==K_CTRL_TAB 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              VPbox( 03, 37, 16, 73, "MENU DE CONSULTAS", _COR_GET_BOX ) 
              SetColor( _COR_GET_EDICAO ) 
              nOpcao:= 1 
              @ 05,38 Prompt " 1 Relacao de Pedidos Por Periodo " 
              @ 06,38 Prompt " 2 Pedidos Pendentes              " 
              @ 07,38 Prompt " 3 Pre-Romaneio (Por Rota)        " 
              @ 08,38 Prompt " 4 Pre-Romaneio (Todas as Rotas)  " 
              @ 09,38 Prompt " 5 Espelho para Montagem          " 
              @ 10,38 Prompt " 6 Relatorio em Formato Pedido    " 
              @ 11,38 Prompt " 7 Relatorio em Formato Cotacao   " 
              @ 12,38 Prompt " 8 Relacao Pedidos Por Servicos   " 
              @ 13,38 Prompt " 9 Mapa Pedidos Por Produtos      " 
              @ 14,38 Prompt " A Relacao de Pedidos & Valores   " 
              @ 15,38 Prompt " B Relacao de Pedidos & Produtos  " 
              Menu To nOpcao 
              nRota:= 0 
              nRota1:= 0 
              nRota2:= 999 
              lPendentes := .t. 
 
              /* Impressao cfe. rota de transporte */ 
              DO CASE 
                 CASE nOpcao == 2 
                      cDiaPen := "P" 
                      SetCursor( 1 ) 
                      VPBox( 16, 44, 20, 79, "Rota de Transporte", _COR_GET_BOX ) 
                      SetColor( _COR_GET_EDICAO ) 
                      @ 17,50 Say "Da Rota...:" Get nRota1 Pict "999" When; 
                        Mensagem( "Digite o intervalo de rota a imprimir..." ) 
                      @ 18,50 Say "Ate a Rota:" Get nRota2 Pict "999" 
                      @ 19,50 Say "(D)ia/(P)endentes: " get cDiaPen pict "!@" valid cDiaPen $ "DP" 
                      READ 
                      lPendentes := ( cDiaPen=="P" ) 
                      SetCursor( 0 ) 
                 CASE nOpcao == 3 
                      cDiaPen := "P" 
                      SetCursor( 1 ) 
                      VPBox( 16, 44, 20, 79, "Rota de Transporte", _COR_GET_BOX ) 
                      SetColor( _COR_GET_EDICAO ) 
                      @ 17,50 Say "Da Rota...:" Get nRota1 Pict "999" When; 
                        Mensagem( "Digite o intervalo de rota a imprimir..." ) 
                      @ 18,50 Say "Ate a Rota:" Get nRota2 Pict "999" 
                      @ 19,50 Say "(D)ia/(P)endentes: " get cDiaPen pict "!@" valid cDiaPen $ "DP" 
                      READ 
                      lPendentes := ( cDiaPen=="P" ) 
                      SetCursor( 0 ) 
                 CASE nOpcao == 4 
                      nRota:= 999 
                      nOpcao:= 3 
                      cDiaPen := "D" 
                      SetCursor( 1 ) 
                      VPBox( 16, 44, 19, 79, "Mapa Geral", _COR_GET_BOX ) 
                      SetColor( _COR_GET_EDICAO ) 
                      @ 17,50 Say "(D)ia/(P)endentes: " get cDiaPen pict "!@" valid cDiaPen $ "DP" 
                      read 
                      lPendentes := ( cDiaPen=="P" ) 
                      SetCursor( 0 ) 
 
                 CASE nOpcao == 1 .OR. nOpcao == 9 .OR. nOpcao == 10 .OR. nOpcao == 11 
                      nVenIni:= 0 
                      nVenFim:= 999 
                      dData1:= DATE() 
                      dData2:= DATE() 
                      SetCursor( 1 ) 
                      VPBox( 14, 44, 19, 79, "PERIODO", _COR_GET_BOX ) 
                      SetColor( _COR_GET_EDICAO ) 
                      @ 15,50 Say "De........:" Get dData1 When; 
                        Mensagem( "Digite o intervalo de datas a imprimir..." ) 
                      @ 16,50 Say "Ate.......:" Get dData2 
                      @ 17,50 Say "Vendedor..:" Get nVenIni Pict "999" 
                      @ 18,50 Say "Ate.......:" Get nVenFim Pict "999" 
                      READ 
                      SetCursor( 0 ) 
 
                 CASE nOpcao == 8 
                      cCorRes:= SetColor( _COR_GET_EDICAO ) 
                      VPBox( 16, 48, 20, 79, "PERIODO", _COR_GET_BOX ) 
                      cProduto1:= SWSet( _GER_GRUPOSERVICOS ) + "0001" 
                      cProduto2:= SWSet( _GER_GRUPOSERVICOS ) + "9999" 
                      dData:= DATE() 
                      SetCursor( 1 ) 
                      @ 17,50 Say "Produto....:" Get cProduto1 Pict "@r 999-9999" 
                      @ 18,50 Say "Ate........:" Get cProduto2 Pict "@R 999-9999" 
                      @ 19,50 Say "Dia........:" Get dData 
                      READ 
                      SetCursor( 0 ) 
                      SetColor( cCorRes ) 
 
              ENDCASE 
 
              DO CASE 
                 CASE nOpcao == 1 .OR. nOpcao == 9 .OR. nOpcao == 10 .OR. nOpcao == 11 
                      DBSelectAr( _COD_PEDIDO ) 
                      DBSetOrder( 1 ) 
                      DBGoBottom() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                      INDEX ON DTOS( DATA__  ) + CODPED TO INDR27 FOR ( DATA__ >= dData1 .AND. DATA__ <= dData2 ) .AND.; 
                                 ( ( VENIN1 >= nVenIni  .AND. VENIN1 <= nVenFim ) .OR.; 
                                   ( VENEX1 >= nVenIni  .AND. VENEX1 <= nVenFim ) ) Eval {|| Processo() } 
                      DBGoTop() 
                      IF nOpcao == 1 
                         Relatorio( "RELPED.REP" ) 
                      ELSEIF nOpcao == 9 
                         Relatorio( "RELROTA.REP" ) 
                      ELSEIF nOpcao == 10 
                         Relatorio( "RELPED1.REP" ) 
                      ELSEIF nOpcao == 11 
                         Relatorio( "RELPED2.REP" ) 
                      ENDIF 
                      DBSelectAr( _COD_PEDIDO ) 

                      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
                      #ifdef LINUX
                        set index to "&gdir/pedind01.ntx", "&gdir/pedind02.ntx", "&gdir/pedind03.ntx",;    
                                     "&gdir/pedind04.ntx", "&gdir/pedind05.ntx", "&gdir/pedind06.ntx", "&gdir/pedind07.ntx"     
                      #else
                        Set Index To "&GDir\PEDIND01.NTX", "&GDir\PEDIND02.NTX", "&GDir\PEDIND03.NTX",;    
                                     "&GDir\PEDIND04.NTX", "&GDir\PEDIND05.NTX", "&GDir\PEDIND06.NTX", "&GDir\PEDIND07.NTX"     

                      #endif
 
                 CASE nOpcao == 8 
                      DBSelectAr( _COD_PEDIDO ) 
                      DBSetOrder( 6 ) 
                      DBSelectAr( _COD_PEDPROD ) 
                      Set Relation To CODPED Into PED 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                      INDEX ON CODPED TO INDR123 FOR PED->DATA__ == dData .AND.; 
                            CODPRO >= VAL( cProduto1 ) .AND. CODPRO <= VAL( cProduto2 ) Eval {|| Processo() } 
                      DBGoTop() 
 
                      Relatorio( "RELPEDP.REP" ) 
 
                      DBSelectAr( _COD_PEDPROD ) 

                      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
                      #ifdef LINUX
                        set index to "&gdir/ppdind01.ntx", "&gdir/ppdind02.ntx", "&gdir/ppdind03.ntx",;    
                                     "&gdir/ppdind04.ntx", "&gdir/ppdind05.ntx"   
                      #else
                        Set Index To "&GDir\PPDIND01.NTX", "&GDir\PPDIND02.NTX", "&GDir\PPDIND03.NTX",;    
                                     "&GDir\PPDIND04.NTX", "&GDir\PPDIND05.NTX"   

                      #endif
 
                      DBSelectAr( _COD_PEDIDO ) 

                      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
                      #ifdef LINUX
                        set index to "&gdir/pedind01.ntx", "&gdir/pedind02.ntx", "&gdir/pedind03.ntx",;    
                                     "&gdir/pedind04.ntx", "&gdir/pedind05.ntx", "&gdir/pedind06.ntx", "&gdir/pedind07.ntx"     
                      #else
                        Set Index To "&GDir\PEDIND01.NTX", "&GDir\PEDIND02.NTX", "&GDir\PEDIND03.NTX",;    
                                     "&GDir\PEDIND04.NTX", "&GDir\PEDIND05.NTX", "&GDir\PEDIND06.NTX", "&GDir\PEDIND07.NTX"     

                      #endif
 
 
                 CASE nOpcao == 2 
                     nRegistro:= RECNO() 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 5 ) 
                     DBSeek( 0 ) 
                     IF EOF() 
                        ScreenRest( cTelaRes ) 
                        oTb:RefreshAll() 
                        WHILE !oTb:Stabilize() 
                        ENDDO 
                        LOOP 
                     ENDIF 
                     aStr:= {{"PEDIDO","C",08,00},; 
                             {"DESCRI","C",45,00},; 
                             {"ROTA__","N",03,00}} 
 
                     dbcreate( "RESERVA.TMP", aStr ) 
                     DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Use RESERVA.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + DESCRI To Indice01 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + PEDIDO To Indice02 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Set Index To Indice01, Indice02 
                     DBSetOrder( 1 ) 
                     DBSelectAr( _COD_PEDIDO ) 
                     PXP->( DBSetOrder( 1 ) ) 
                     WHILE !PED->( EOF() ) 
                        IF ( ( PED->CODNF_ == 0 .AND. lPendentes ) .OR.; 
                             ( !lPendentes      .AND. PED->DATA__==DATE() ) ) 
                           IF ( PED->TRANSP >= nRota1 .AND. PED->TRANSP <= nRota2 ) .OR. nRota == 999 
                              IF nRota == 999 
                                 nRotaAtual:= 999 
                              ELSE 
                                 nRotaAtual:= PED->TRANSP 
                              ENDIF 
                              IF RES->( DBSeek( Str( nRotaAtual, 3, 0 ) + PAD( PXP->DESCRI, 45 ) ) ) 
                              ELSE 
                                 RES->( DBAppend() ) 
                                 RES->( netrlock() ) 
                                 Replace RES->PEDIDO With PED->CODIGO,; 
                                         RES->DESCRI With PED->DESCRI,; 
                                         RES->ROTA__ With nRotaAtual 
                              ENDIF 
                           ENDIF 
                        ENDIF 
                        PED->( DBSkip() ) 
                     ENDDO 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 1 ) 
                     DBSelectAr( 133 ) 
                     DBSetOrder( 2 ) 
                     Set Relation To PEDIDO Into PED 
                     DBGoTop() 
                     IF !LastKey() == K_ESC .AND. !NextKey() == K_ESC 
                        Relatorio( "SEPARAR_.REP" ) 
                     ENDIF 
                     DBSelectAr( 133 ) 
                     DBCloseArea() 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBGoTo( nRegistro ) 
                 CASE nOpcao == 4 
 
 
                 CASE nOpcao == 3 
                     nRegistro:= RECNO() 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBSetOrder( 5 ) 
                     DBSeek( 0 ) 
                     IF EOF() 
                        LOOP 
                     ENDIF 
                     aStr:= {{"PEDIDO","C",08,00},; 
                             {"CODPRO","C",12,00},; 
                             {"DESPRO","C",45,00},; 
                             {"QUANT_","N",16,04},; 
                             {"QTDINT","N",16,04},; 
                             {"DIFER_","N",16,04},; 
                             {"UNIDAD","C",02,00},; 
                             {"ROTA__","N",03,00},; 
                             {"PADRAO","N",16,04},; 
                             {"PESOLI","N",16,04},; 
                             {"PESOBR","N",16,04}} 
                     dbcreate( "RESERVA.TMP", aStr ) 
                     DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Use Reserva.Tmp Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + DESPRO To Indice01 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Index On Str( ROTA__, 3, 0 ) + CODPRO To Indice02 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     Set Index To Indice01, Indice02 
                     DBSetOrder( 1 ) 
                     DBSelectAr( _COD_PEDIDO ) 
                     PXP->( DBSetOrder( 2 ) ) 
                     WHILE !PED->( EOF() ) .and. PED->CODNF_ = 0 
                        IF ( ( PED->CODNF_ == 0 .AND. lPendentes ) .OR.; 
                             ( !lPendentes      .AND. PED->DATA__==DATE() ) ) 
                           IF ( PED->TRANSP >= nRota1 .AND. PED->TRANSP <= nRota2 ) .OR. nRota == 999 
                              PXP->( DBSeek( PED->CODIGO ) ) 
                              WHILE PXP->CODIGO == PED->CODIGO .AND. !PXP->( EOF() ) 
                                 IF nRota == 999 
                                    nRotaAtual:= 999 
                                 ELSE 
                                    nRotaAtual:= PED->TRANSP 
                                 ENDIF 
                                 IF RES->( DBSeek( Str( nRotaAtual, 3, 0 ) + PAD( PXP->DESCRI, 45 ) ) ) 
                                    IF RES->( netrlock() ) 
                                       Replace RES->QUANT_ With RES->QUANT_ + PXP->QUANT_ 
                                    ENDIF 
                                 ELSE 
                                    RES->( DBAppend() ) 
                                    RES->( netrlock() ) 
                                    Replace RES->PEDIDO With PXP->CODIGO,; 
                                            RES->CODPRO With StrZero( PXP->CODPRO, 7, 0 ) + Space( 5 ),; 
                                            RES->DESPRO With PXP->DESCRI,; 
                                            RES->QUANT_ With PXP->QUANT_,; 
                                            RES->UNIDAD With PXP->UNIDAD,; 
                                            RES->ROTA__ With nRotaAtual 
                                 ENDIF 
                                 PXP->( DBSkip() ) 
                              ENDDO 
                           ENDIF 
                        ENDIF 
                        PED->( DBSkip() ) 
                     ENDDO 
                     DBSelectAr( _COD_MPRIMA ) 
                     DBSetOrder( 1 ) 
                     DBSelectAr( 133 ) 
                     //IF nRota == 999 
                     //   DBGoTop() 
                     //   WHILE !EOF() 
                     //       IF netrlock() 
                     //          Replace ROTA__ With 999 
                     //       ENDIF 
                     //       DBSkip() 
                     //   ENDDO 
                     //ENDIF 
                     Set Relation To CODPRO Into MPR 
                     DBGoTop() 
                     WHILE !EOF() 
                        IF netrlock() 
                           nCoef:=  QUANT_ / MPR->QTDPES 
                           nQuantInteira:= Int( nCoef ) 
                           nDifer:= QUANT_ - ( INT( nCoef ) * MPR->QTDPES ) 
                           Replace  QTDINT With nQuantInteira,; 
                                    DIFER_ With nDifer,; 
                                    PADRAO With MPR->QTDPES,; 
                                    PESOLI With MPR->PESOLI * QUANT_,; 
                                    PESOBR With MPR->PESOBR * QUANT_ 
                        ENDIF 
                        DBSkip() 
                     ENDDO 
                     DBSetOrder( 2 ) 
                     DBGoTop() 
                     IF Confirma( 00, 00,; 
                        "Confirma a impressao de itens por rota?",; 
                        "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                        Relatorio( "RELROTA_.REP" ) 
                     ENDIF 
                     DBSelectAr( 133 ) 
                     DBCloseArea() 
                     DBSelectAr( _COD_PEDIDO ) 
                     DBGoTo( nRegistro ) 
 
                 CASE nOpcao == 5 
                     IF Confirma( 00, 00,; 
                        "Confirma a impressao para Montagem?",; 
                        "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                        Relatorio( "MONTAGEM.REP" ) 
                     ENDIF 
 
                 CASE nOpcao == 5 
                     IF Confirma( 00, 00,; 
                        "Confirma a impressao deste pedido?",; 
                        "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                        IF !Empty( CODPED ) 
                           Relatorio( "PEDIDOS.REP" ) 
                        ELSE 
                           Aviso( "Este relatorio n�o poder� ser emitido, pois nao foi gravado!" ) 
                           Pausa() 
                        ENDIF 
                     ENDIF 
                 CASE nOpcao == 7 
                      IF Confirma( 00, 00,; 
                         "Confirma a impressao?",; 
                         "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                         Relatorio( "COTACAO.REP" ) 
                      ENDIF 
              ENDCASE 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
         case nTecla==K_TAB 
              IF Confirma( 00, 00,; 
                 "Confirma a impressao deste pedido?",; 
                 "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                 IF !Empty( CODPED ) 
                    Relatorio( "PEDIDOS.REP" ) 
                 ELSE 
                    Relatorio( "COTACAO.REP" ) 
                 ENDIF 
              Endif 
         case DBPesquisa( nTecla, oTb ) 
         case nTecla == K_F6; DBMudaOrdem( 1, oTb ) 
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
 
 
