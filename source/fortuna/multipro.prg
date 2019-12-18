// ## CL2HB.EXE - Converted
 
#Include "VPF.CH" 
#Include "INKEY.CH" 
#Include "FORMATOS.CH" 
 
/* Definicao de parcelamento */ 
#Define   FAT_PARCELA        1 
#Define   FAT_PERCENTUAL     2 
#Define   FAT_VALOR          3 
#Define   FAT_DIAS           4 
#Define   FAT_BANCO          5 
#Define   FAT_VENCIMENTO     6 
#Define   FAT_TIPO           7 
#Define   FAT_PAGAMENTO      8 
#Define   FAT_CHEQUE         9 
#Define   FAT_NUMERO        10 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ MULTIROTA 
³ Finalidade  ³ Multi-processamento por rota de entrega/transportadora 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function MultiRota() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nValorTotal:= 0, dDataEm, nNumero, nTecla, dDataPedido:= DATE() 
 
Local cOrdemCmp:= "" 
Local nRota:= 0, nCodCliente 
 
 
     NF_->( DBSetOrder( 1 ) ) 
     NF_->( DBSeek( 999999 ) ) 
     NF_->( DBSkip( -1 ) ) 
     cObserv:= Space( 40 ) 
     nNatOpe:= SWSet( _NFA_NATOPERA ) 
     nNumero:= NF_->NUMERO + 1 
     cRazao:= "S" 
     cViaTra:= SWSet( _NFA_VIATRANSP ) 
     dDataEm:= DATE() 
     nBanco:= 0 
     nPesoLiquido:= 0 
     nPesoBruto:=   0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     UserScreen() 
     VPBox( 0, 0, 22, 79, " MULTI-PROCESSAMENTO DE NOTA FISCAL POR ROTA ", _COR_GET_BOX ) 
     Mensagem( "Processamento multiplo" ) 
     SetColor( _COR_GET_EDICAO ) 
     @ 01,02 Say "Empresa >>>>> " + ALLTRIM( _EMP ) 
     @ 02,02 Say "Rota.......................:" Get nRota Pict "@E 999" 
     @ 03,02 Say "Data de Emissao............:" Get dDataEm 
     @ 04,02 Say "Pedidos c/ data............:" Get dDataPedido 
     READ 
     SWGravar( 600 ) 
     IF !LastKey() == K_ESC 
        DBSelectAr( _COD_NFISCAL ) 
        DBSetOrder( 5 ) 
        IF DBSeek( "Sim" ) 
           IF Confirma( 0, 0, "Existem NFs selecionadas p/ romaneio! Desfazer a ultima selecao?",; 
                "Digite [S] para limpar a ultima selecao ou [N] para manter.", "N" ) 
              IF !LastKey() == K_ESC 
                 LimpaSelecao() 
              ENDIF 
           ENDIF 
        ENDIF 
 
 
        DBSetOrder( 1 ) 
 
        Scroll( 01, 01, 21, 78, 0 ) 
        DBSelectAr( _COD_MPRIMA ) 
        DBSetOrder(1) 
 
        OPE->( DBSetOrder( 1 ) ) 
        CLI->( DBSetOrder( 1 ) ) 
 
        /* Seleciona arquivos de produtos por pedido */ 
        DBSelectAr( _COD_PEDPROD ) 
 
        DBSelectAr( _COD_PEDIDO ) 
        DBSetOrder( 7 ) 
        DBGoTop() 
        nNotaFiscal:= nNumero 
 
        // Verifica se alguma Empresa esta selecionada 
        IF AT( "0", GDir ) <= 0 
           Keyboard Chr( K_RIGHT ) 
           IF SWAlerta( "<< Empresa padrao est  selecionada >>; O que voce deseja fazer?", { "Continuar", "Cancelar" } )==2 
              ScreenRest( cTela ) 
              SetColor( cCor ) 
              SetCursor( nCursor ) 
              Return Nil 
           ENDIF 
        ENDIF 
 
        // Inicio da gravacao 
        GravaUsuario(   "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 ) + ; 
                        " Multi-processamento em: " + DTOC( DATE() ) + Chr( 13 ) + Chr( 10 ) +; 
                        " Diretorio (GDir): " + GDir + Chr( 13 ) + Chr( 10 ) +; 
                        " Rota: " + Str( nRota ) + Chr( 13 ) + Chr( 10 ) +; 
                        " Usuario: " + StrZero( nGCodUser, 3, 0 ) + Chr( 13 ) + Chr( 10 ) +; 
                        " N§ Nota Fiscal Inicial: " + StrZero( nNotaFiscal, 9, 0 ) + Chr( 13 ) + Chr( 10 ) ) 
 
        WHILE !EOF() 
 
           // Verificar o acionamento da tecla ESC 
           Inkey() 
           IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
              Keyboard Chr( K_RIGHT ) 
              IF SwAlerta( "<< INTERROMPER >>; Deseja imterromper a gravacao?", { "Sim", "Nao" } )==1 
                 EXIT 
              ENDIF 
           ENDIF 
 
           lGravada:= .F. 
           IF PED->CODNF_ == 0 .AND. ( PED->TRANSP == nRota .OR. nRota==999 ) .AND.; 
              AT( "REGISTRO RESERVADO", PED->DESCRI ) <= 0 .and. PED->SITUA_ == "PED" .AND. PED->( DATA__ ) == dDataPedido 
 
              /**** Sintese das variaveis definidas pela operacao ************/ 
              nTabOpe:= PED->TABOPE 
              OPE->( DBSeek( nTabOpe ) ) 
              cRazao:= iif( OPE->ENTSAI $ "E12", "E", "S" ) 
              nNatOpe:= IF( ESTADO == SWSet( _CL__ESTADO ), OPE->NATOPE, OPE->NATFOR ) 
              lCalculaIcm:= ( OPE->CALICM=="S" ) 
              cTipoFrete:= OPE->FRETE_ 
              lCalculaComissao:= ( OPE->COMISS=="S" ) 
              CLI->( DBSeek( PED->CODCLI ) ) 
              nCodCliente:= PED->CODCLI 
              cConsumoIndustria:= CLI->CONIND 
 
              /* Percentual de ICMs */ 
              nPercentual:= BuscaPerIcm( CLI->ESTADO, CLI->CONIND, 0 ) 
              DBSelectAr( _COD_PEDPROD ) 
              DBSetOrder( 1 ) 
              DBSeek( ( cCotacao:= PED->CODIGO ) ) 
              aProdutos:= 0 
              aProdutos:= {} 
              nPesoLiquido:= 0 
              nPesoBruto:= 0 
              WHILE CODIGO == cCotacao 
                  MPR->( DBSeek( StrZero( PXP->CODPRO, 7, 0 ) + Space( 5 ) ) ) 
                  IF ( QUANT_ * VLRUNI ) > 0 
                     AAdd( aProdutos, { CODPRO,; 
                                        DESCRI,; 
                                        UNIDAD,; 
                                        VLRUNI,; 
                                        VLRUNI * QUANT_,; 
                                        MPR->ICMCOD,; 
                                        MPR->IPICOD,; 
                                        MPR->CLAFIS,; 
                                        QUANT_,; 
                                        ( ( VLRUNI * QUANT_ ) * IPI___ ) / 100,; 
                                        IPI___,; 
                                        ICM___,; 
                                        MPR->MPrima,; 
                                        PegaCodFiscal( MPR->CLAFIS ),; 
                                        CODFAB,; 
                                        QUANT_,; 
                                        QUANT_ * VLRUNI,; 
                                        MPR->TABRED,; 
                                        0,; 
                                        ORIGEM,; 
                                        TABPRE,; 
                                        DESPRE,; 
                                        nPercentual } ) 
                                        nPesoLiquido+= ( MPR->PESOLI * QUANT_ ) 
                                        nPesoBruto+=   ( MPR->PESOBR * QUANT_ ) 
                  ENDIF 
                  DBSkip() 
              ENDDO 
              Set Relation To 
 
              DBSelectAr( _COD_REDUCAO ) 
              DBSetOrder( 1 ) 
              DBSelectAr( _COD_CLIENTE ) 
              DBSetOrder( 1 ) 
              DBSeek( PED->CODCLI ) 
 
              /* Soma dos produtos */ 
              nValorTotal:= 0 
              nValorIpi:= 0 
              nBaseIcm:= 0 
              aObservacoes:= 0 
              aObservacoes:= {} 
 
              /* Busca observacoes informadas nos pedidos */ 
              IF !EMPTY( PED->OBSNF1 ) 
                 AAdd( aObservacoes, PED->OBSNF1 ) 
              ENDIF 
              IF !EMPTY( PED->OBSNF2 ) 
                 AAdd( aObservacoes, PED->OBSNF2 ) 
              ENDIF 
              IF !EMPTY( PED->OBSNF3 ) 
                 AAdd( aObservacoes, PED->OBSNF3 ) 
              ENDIF 
              IF !EMPTY( PED->OBSNF4 ) 
                 AAdd( aObservacoes, PED->OBSNF4 ) 
              ENDIF 
 
 
 
              FOR nCt:= 1 TO Len( aProdutos ) 
                  /* Soma Valor Total da Nota Fiscal */ 
                  nValorTotal+= aProdutos[ nCt ][ 5 ] 
                  nValorIpi+=   aProdutos[ nCt ][ 10 ] 
 
                  /* Verifica se ‚ consumo ou industria */ 
                  IF !cConsumoIndustria == "C" 
                      nBaseProIcm:= aProdutos[ nCt ][ 5 ] + aProdutos[ nCt ][ 10 ] 
                  ELSE 
                      nBaseProIcm:= aProdutos[ nCt ][ 5 ] 
                  ENDIF 
 
                  /* Busca observacoes cfe. classificaocao fiscal */ 
                  IF aProdutos[ nCt ][ 8 ] > 0 
                     IF CF_->( DBSeek( aProdutos[ nCt ][ 8 ] ) ) 
                        IF ASCAN( aObservacoes, CF_->OBSNOT ) <= 0 
                           AAdd( aObservacoes,  CF_->OBSNOT ) 
                        ENDIF 
                     ENDIF 
                  ENDIF 
 
                  IF aProdutos[ nCt ][ 7 ] == 2        /* COM REDUCAO DA BASE DE CALCULO */ 
                     DBSelectAr( _COD_REDUCAO ) 
                     DBSeek( aProdutos[ nCt ][ 18 ] ) 
                     IF !Empty( RED->OBSERV ) 
                        IF AScan( aObservacoes, RED->OBSERV ) <= 0 
                           AAdd(  aObservacoes, RED->OBSERV ) 
                        ENDIF 
                     ENDIF 
                     nPerReducao:= RED->PERRED 
                     nValorReducao:= ( nBaseProIcm * nPerReducao ) / 100 
                     nBaseProIcm:= nBaseProIcm - nValorReducao 
                  ELSEIF aProdutos[ nCt ][ 7 ] == 4    /* ISENTO OU NAO TRIBUTADO */ 
                     nBaseProIcm:= 0 
                     aProdutos[ nCt ][ 23 ]:= 0 
                  ENDIF 
 
                  /* Busca na Tab. Observacoes relacionada ao Produto */ 
                  IF MPR->TABOBS > 0 
                     OBS->( DBSetOrder( 1 ) ) 
                     OBS->( DBSeek( MPR->TABOBS ) ) 
                     IF AScan( aObservacoes, OBS->OBSERV ) <= 0 
                        AAdd(  aObservacoes, OBS->OBSERV ) 
                     ENDIF 
                  ENDIF 
 
                  /* Soma informacoes na base de ICMs */ 
                  nBaseIcm+= nBaseProIcm 
 
              NEXT 
 
              /* Se nao for p/ calcular ICMs ZERA base de Calculo */ 
              IF !lCalculaIcm 
                 nBaseIcm:= 0 
              ENDIF 
 
              /* Calcula o Icms */ 
              nPercentual:= BuscaPerIcm( CLI->ESTADO, CLI->CONIND, 0 ) 
              nVlrIcm:= ( nBaseIcm * nPercentual / 100 ) 
 
              DBSelectAr( _COD_NFISCAL ) 
              NF_->( DBSetOrder( 1 ) ) 
              NF_->( DBSeek( 999999 ) ) 
              NF_->( DBSkip( -1 ) ) 
              nNumero:= NUMERO + 1 
              Scroll( 01, 01, 21, 78, 1 ) 
              @ 21,02 Say PED->DESCRI 
              DBAppend() 
              @ 21,40 Say "Gravando Informacoes Cliente...       " 
              cOrdemCmp:= Pad( PED->OC__01, 10 ) +; 
                          Pad( PED->OC__02, 10 ) +; 
                          Pad( PED->OC__03, 10 ) +; 
                          Pad( PED->OC__04, 10 ) +; 
                          Pad( PED->OC__05, 10 ) +; 
                          Pad( PED->OC__06, 10 ) 
 
              IF NetRLock() 
                 Replace NUMERO With nNumero,; 
                         CLIENT With PED->CODCLI,; 
                         CDESCR With PED->DESCRI,; 
                         CENDER With PED->ENDERE,; 
                         CBAIRR With PED->BAIRRO,; 
                         CCIDAD With PED->CIDADE,; 
                         CESTAD With PED->ESTADO,; 
                         CCDCEP With PED->CODCEP,; 
                         CFONE2 With PED->FONFAX,; 
                         CCGCMF With PED->CGCMF_,; 
                         CINSCR With PED->INSCRI,; 
                         TRANSP With PED->TRANSP,; 
                         VENIN_ With PED->VENIN1,; 
                         VENEX_ With PED->VENEX1,; 
                         VIATRA With cViaTra,; 
                         DATAEM With dDataEm,; 
                         VLRTOT With nValorTotal,; 
                         BASICM With nBaseIcm,; 
                         VLRICM With nVlrIcm,; 
                         VLRNOT With nValorTotal,; 
                         NATOPE With nNatOpe,; 
                         TABCND With PED->TABCND,; 
                         ENTSAI With cRazao,; 
                         TIPONF With cRazao,; 
                         PRAZOA With Val( PED->CONDI_ ),; 
                         SELECT With "Sim",; 
                         PEDIDO With Val( PED->CODPED ),; 
                         ORDEMC With cOrdemCmp,; 
                         PESOLI With nPesoLiquido,; 
                         PESOBR With nPesoBruto,; 
                         FPC12_ With cTipoFrete,; 
                         CONREV With cConsumoIndustria,; 
                         TABOPE With nTabOpe 
 
                 /* Grava Observacoes */ 
                 FOR nCt:= 1 TO Len( aObservacoes ) 
                     IF nCt==1 
                        Replace OBSER1 With aObservacoes[ nCt ] 
                     ELSEIF nCt==2 
                        Replace OBSER2 With aObservacoes[ nCt ] 
                     ELSEIF nCt==3 
                        Replace OBSER3 With aObservacoes[ nCt ] 
                     ELSEIF nCt==4 
                        Replace OBSER4 With aObservacoes[ nCt ] 
                     ENDIF 
                 NEXT 
 
                 @ 21,40 Say "Gravando Informacoes Produtos...    " 
                 /* Produtos - Nota Fiscal */ 
                 DBSelectAr( _COD_PRODNF ) 
                 FOR nCt:= 1 TO Len( aProdutos ) 
                     DBAppend() 
                     nPrecoVista:= PrecoAVista( PED->TABCND, StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ) ) 
                     cDescricao:= aProdutos[ nCt ][ 2 ] 
                     #ifdef CONECSUL 
                         cDescricao:= ( LEFT( aProdutos[ nCt ][ 15 ], 12 ) + " - " + aProdutos[ nCt ][ 2 ] ) 
                     #endif 
                     IF NetRLock() 
                        Replace CODNF_ With nNumero,; 
                                CODRED With StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ),; 
                                CODIGO With StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ),; 
                                DESCRI With cDescricao,; 
                                UNIDAD With aProdutos[ nCt ][ 3 ],; 
                                QUANT_ With aProdutos[ nCt ][ 16 ],; 
                                PRECOV With aProdutos[ nCt ][ 4 ],; 
                                PRECOT With aProdutos[ nCt ][ 5 ],; 
                                ICMCOD With aProdutos[ nCt ][ 6 ],; 
                                IPICOD With aProdutos[ nCt ][ 7 ],; 
                                CLAFIS With aProdutos[ nCt ][ 8 ],; 
                                TABPRE With aProdutos[ nCt ][ 21 ],; 
                                DESPRE With aProdutos[ nCt ][ 22 ],; 
                                DATA__ With dDataEm,; 
                                CLIENT With PED->CODCLI,; 
                                PERICM With aProdutos[ nCt ][ 23 ],; 
                                PRECO1 With IF( nPrecoVista > 0, nPrecoVista, aProdutos[ nCt ][ 4 ] ) 
 
                        IF OPE->ENTSAI $ "S34" 
                           LancEstoque( StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ),; 
                                        StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ),; 
                                        "-","NF: " + StrZero( nNumero, 8, 0 ),; 
                                        PED->CODCLI, 0, aProdutos[ nCt ][ 5 ],; 
                                        aProdutos[ nCt ][ 16 ], nGCodUser,; 
                                        dDataEm, nVlrIcm, 0, 0, nTabOpe, nNatOpe ) 
                        ELSEIF OPE->ENTSAI $ "E12" 
                           LancEstoque( StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ),; 
                                        StrZero( aProdutos[ nCt ][ 1 ], 7, 0 ),; 
                                        "+","NF: " + StrZero( nNumero, 8, 0 ),; 
                                        PED->CODCLI, 0, aProdutos[ nCt ][ 5 ],; 
                                        aProdutos[ nCt ][ 16 ], nGCodUser,; 
                                        dDataEm, nVlrIcm, 0, 0, nTabOpe, nNatOpe ) 
                        ENDIF 
                     ENDIF 
                 NEXT 
 
 
                 IF ( ( nNatOpe >= 5.100 .AND. nNatOpe <= 5.129 ) .OR.; 
                      ( nNatOpe >= 6.100 .AND. nNatOpe <= 6.129 ) ) .AND. Upper( OPE->MOVFIN ) == "S" 
                    @ 21,40 Say "Gravando Informacoes Duplicatas...   " 
                    /* Gravacao de duplicatas recebidas e/ou a receber */ 
 
                    aDias:= {} 
                    cString:= PED->CONDI_ + "/" 
                    nPos:= 0 
 
                    IF Empty( aDias ) 
                       FOR nCt:= 1 TO Len( PED->CONDI_ ) 
                           AAdd( aDias, Val( SubStr( cString, 1, At( "/", cString ) - 1 ) ) ) 
                           cString:= SubStr( cString, At( "/", cString ) + 1 ) 
                       NEXT 
                    ENDIF 
 
                    nFatura:= StrVezes( "/", PED->CONDI_ ) + 1 
 
 
                    aParcelas:= 0 
                    aParcelas:= {} 
                    FOR nCt:= 1 TO nFatura 
                        AAdd( aParcelas, { 0, 0, 0, 0, 0, Date(), " ", CTOD( "  /  /  " ), Space( 10 ), 0 } ) 
                    NEXT 
                    DO CASE 
                       CASE nFatura == 1 
                            aParcelas[1][ FAT_PERCENTUAL ]:= 100 
                       CASE nFatura == 2 
                            aParcelas[1][ FAT_PERCENTUAL ]:= 50 
                            aParcelas[2][ FAT_PERCENTUAL ]:= 50 
                       CASE nFatura == 3 
                            aParcelas[1][ FAT_PERCENTUAL ]:= 34 
                            aParcelas[2][ FAT_PERCENTUAL ]:= 33 
                            aParcelas[3][ FAT_PERCENTUAL ]:= 33 
                       CASE nFatura == 4 
                            aParcelas[1][ FAT_PERCENTUAL ]:= 25 
                            aParcelas[2][ FAT_PERCENTUAL ]:= 25 
                            aParcelas[3][ FAT_PERCENTUAL ]:= 25 
                            aParcelas[4][ FAT_PERCENTUAL ]:= 25 
                       OTHERWISE 
                            ASIZE( aParcelas, nFatura ) 
                            FOR nCt:= 1 TO LEN( aParcelas ) 
                                IF aParcelas[ nCt ][ FAT_PERCENTUAL ] == 0 
                                   aParcelas[ nCt ][ FAT_PERCENTUAL ]:= 100 / nFatura 
                                ENDIF 
                            NEXT 
                    ENDCASE 
                    nCont:= 0 
                    WHILE LastKey() <> K_ESC 
                         IF nCont + 1 > Len( aDias ) .OR. nCont + 1 > Len( aParcelas ) 
                            EXIT 
                         ENDIF 
                         z:= aDias[ ++nCont ] 
                         aParcelas[ nCont ][ FAT_DIAS ]:= z 
                         aParcelas[ nCont ][ FAT_VALOR ]:= ( nValorTotal * aParcelas[ nCont ][ FAT_PERCENTUAL ] ) / 100 
                         aParcelas[ nCont ][ FAT_BANCO ]:= 0 
                         aParcelas[ nCont ][ FAT_VENCIMENTO ]:= dDataEm + aParcelas[ nCont ][ FAT_DIAS ] 
                         aParcelas[ nCont ][ FAT_PAGAMENTO ]:= CTOD( "  /  /  " ) 
                         IF nCont + 1 > Len( aParcelas ) 
                            EXIT 
                         ENDIF 
                    ENDDO 
 
                    IF Len( aParcelas ) == 0 
                       Aviso( "Parcelas nao confere!" ) 
                       Pausa() 
                    ENDIF 
 
                    CLI->( DBSetOrder( 1 ) ) 
                    CLI->( DBSeek( nCodCliente ) ) 
                    IF LEFT( Alltrim( CLI->COBRAN ), 4 ) == "CLI*" 
                       nCodCliente:= VAL( SubStr( Alltrim( CLI->COBRAN ), 5 ) ) 
                    ENDIF 
 
                    FOR nCt:= 1 TO Len( aParcelas ) 
                        DBSelectAr( _COD_DUPAUX ) 
                        DBAppend() 
                        IF NetRLock() 
                           Replace CODNF_ With nNumero,; 
                                   CDESCR With PED->DESCRI,; 
                                   VENC__ With aParcelas[ nCont ][ FAT_VENCIMENTO ],; 
                                   PRAZ__ With aParcelas[ nCont ][ FAT_DIAS ],; 
                                   VLR___ With aParcelas[ nCont ][ FAT_VALOR ],; 
                                   BANC__ With aParcelas[ nCont ][ FAT_BANCO ],; 
                                   DATAEM With dDataEm,; 
                                   CLIENT With nCodCliente,; 
                                   FUNC__ With nGCodUser,; 
                                   LOCAL_ With aParcelas[ nCont ][ FAT_BANCO ],; 
                                   DUPL__ With nNumero,; 
                                   LETRA_ With Chr( ASC( "A" ) + nCt - 1 ) 
 
                           IF aParcelas[ nCt ][ FAT_DIAS ] == 0 
                              BaixaReceber( Nil, .T. ) 
                              //Replace DTQT__ With aParcelas[ nCont ][ FAT_VENCIMENTO ] 
                              //Replace HISTOR With 1, SEQUEN With nSequencia 
                           ENDIF 
 
                        ENDIF 
                    NEXT 
                 ENDIF 
                 lGravada:= .T. 
                 /* GRAVA INFORMACOES DO CLIENTE */ 
                 CliInfo( nCodCliente, nValorTotal, "-", dDataEm, nNumero, nValorTotal ) 
              ENDIF 
           ENDIF 
           DBSelectAr( _COD_PEDIDO ) 
           nRegistro:= RECNO() 
           lFim:= .F. 
           DBSkip( 1 ) 
           IF !EOF() 
              nRegistro:= RECNO() 
           ELSE 
              lFim:= .T. 
           ENDIF 
           DBSkip( -1 ) 
 
           @ 21,40 Say "Gravando Informacoes Pedido...      " 
           IF lGravada 
              IF NetRLock() 
                 Replace DATANF With dDataEm,; 
                         CODNF_ With nNumero 
              ENDIF 
           ENDIF 
 
           /* FIM DA GRAVACAO */ 
           DBUnlockAll() 
           @ 21,40 Say "OK!                                 " 
           DBGoTo( nRegistro ) 
           IF CODNF_ > 0 .OR. ( lFim .AND. EOF() ) 
              EXIT 
           ENDIF 
 
        ENDDO 
 
        // Termino da gravacao 
        GravaUsuario(   "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 ) + ; 
                        " Multi-processamento em: " + DTOC( DATE() ) + Chr( 13 ) + Chr( 10 ) +; 
                        " N§ Nota Fiscal Final..: " + StrZero( nNumero, 9, 0 ) + Chr( 13 ) + Chr( 10 ) ) 
 
        IF File( "ERRO.TXT" ) 
           //aErro:= DIRECTORY( "ERRO.TXT" ) 
           //MEMOWRIT( "TEMP\T" + AllTrim( aErro[ 1 ][ 2 ] ) + ".ERR", "Tamanho do arquivo em " + DTOC( DATE() ) + " as " + TIME() + " ===>" + DIRECTORY( "ERRO.TXT" )[ 1 ][ 2 ] ) 
        ENDIF 
 
        Aviso( "Notas Fiscais Gravadas..." ) 
        Pausa() 
        IF Confirma( 0, 0, "Deseja imprimir as notas fiscais gravadas?", "", "S" ) 
           Set( 24, "NFISCAL.PRN" ) 
           Aviso( "Impressao desviada para arquivo NFISCAL.PRN" ) 
           Pausa() 
           DBSelectAr( _COD_NFISCAL ) 
           DBSetOrder( 1 ) 
           NF_->( DBSeek( nNotaFiscal ) ) 
           /* Busca formatacao e guarda em buffer */ 
           WHILE !NF_->( EOF() ) 
              DBSelectAr( _COD_NFISCAL ) 
              Relatorio( "NFISCAL.REP" ) 
              NF_->( DBSkip() ) 
           ENDDO 
           LimpaBuffer() 
           Set( 20, "SCREEN" ) 
           IF Confirma( 0, 0, "Imprimir arquivo NFISCAL.PRN?" ) 
              PortaNotaFisal:= SWSet( _PRN_NFISCAL ) 
              !TYPE NFISCAL.PRN >&PortaNotafiscal 
           ENDIF 
           Set( 24, "LPT1" ) 
        ENDIF 
     ENDIF 
     SWGravar( 5 ) 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ PRECOAVISTA 
³ Finalidade  ³ Busca o preco a Vista de um determinado produto conforme a 
³             ³ operacao utilizada 
³ Parametros  ³ nTabOpe, cProduto 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function PrecoAVista( nTabOpe, cProduto ) 
Local nMargem:= 0, nOrdem:= MPR->( IndexOrd() ) 
OPE->( DBSetOrder( 1 ) ) 
OPE->( DBSeek( nTabOpe ) ) 
PRE->( DBSetOrder( 1 ) ) 
PRE->( DBSeek( OPE->TABPRE ) ) 
TAX->( DBSetOrder( 1 ) ) 
TAX->( DBSeek( PRE->CODIGO ) ) 
WHILE !Alltrim( TAX->CODPRO ) == ALLTRIM( cProduto ) .AND. !TAX->( EOF() ) 
   TAX->( DBSkip() ) 
ENDDO 
IF !TAX->( EOF() ) 
   nMargem:= TAX->MARGEM 
ELSE 
   nMargem:= PRE->PERACR 
ENDIF 
Return PrecoCnd( 1, PrecoCompra( PAD( cProduto, 12 ) ), nMargem ) 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ LIMPASELECAO 
³ Finalidade  ³ Limpa Selecao das Notas Fiscais 
³ Parametros  ³ NIL 
³ Retorno     ³ NIL 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function LimpaSelecao() 
 Local nArea:= Select(), nOrdem:= IndexOrd() 
 DBSelectAr( _COD_NFISCAL ) 
 DBSetOrder( 5 ) 
 WHILE DBSeek( "Sim" ) .AND. !Inkey()==K_ESC .AND.; 
                             !LastKey()==K_ESC .AND.; 
                             !NextKey()==K_ESC 
    IF NetRLock() 
       Replace SELECT With "   " 
    ENDIF 
 ENDDO 
 DBSelectAr( nArea ) 
 DBSetOrder( nOrdem ) 
 
 
