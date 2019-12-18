// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ fSelecDup() 
³ Finalidade  ³ Selecao Duplicatas 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores + Airan 
³ Data        ³ Tue 24/08/99 - 11:49:30 h 
³ Atualizacao ³ 11/99 - Valmor 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
      Function fSelecDup() 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
				cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
      Local dBloDtV1:= CTOD( "  /  /  " ), dBloDtV2:= CTOD( "  /  /  " ),; 
            nBloCta1:= 0, nBloCta2:= 0, nBloCod1:= 0, nBloCod2:= 0, aBloCtas:= {} 
      Local nOpcaoData:= 0, nReg:= 0, nOpcContaAge:= 0 
 
      nDuplic1 := 0 
      nDuplic2 := 999999 
      nBanco1  := 0 
      nBanco2  := 799 
      nClient1 := 1 
      nClient2 := 999999 
      dVenc1   := CTOD( "  /  /  " ) 
      dVenc2   := Date() + 365 
      dEmiss1  := CTOD( "  /  /  " ) 
      dEmiss2  := Date() + 365 
      cSelEsp  := " " // C S T 
      cCodReg  := " " // D I E (DEBITO/INCLUSAO CAD./EXCLUSAO CAD.) 
      cCadTip  := " " // 2 1 (2=INCLUSAO 1=EXCLUSAO) 
      dDatVen  := CTOD( "  /  /  " ) 
 
      nValorL  := 999999999.99 
 
      nConta_  := 0      // VERIFICAR DESTINO (ACESSAR O ARQUIVO CORRESP.) 
//    cJaEmit  := "N" 
      cJaEmit  := "S" // PARA! PARA! PARA! PARA! --> SOMETE PARA TESTES! 
      nPerc    := 100 
      nMulta_  := 0            // Multa 
      nCorMon  := 0                             // Correcao Monetaria 
      nValPar  := 999999999.99 // Valor Maximo para Parcela 
 
      cIndice:= "CDESCR" 
 
      WHILE( .T. ) 
 
         DBSelectAr( _COD_DUPAUX ) 
 
         SetColor( _COR_BROWSE ) 
         Ajuda( "["+_SETAS+"]Edi‡„o dos Campos   [Esc]Sair" ) 
 
         SetColor( _COR_GET_EDICAO ) 
         VPBox ( 04, 05, 21, 74, " GERA€ŽO DE DUPLICATAS PARA REMESSA ", _COR_GET_EDICAO ) 
         Scroll( 06, 06, 20, 73 ) 
         Set( _SET_DELIMITERS, .T. ) 
 
         @ 05, 07 Say "Duplicata/Lancamento..................: De [        ] a [        ]" 
         @ 06, 07 Say "Conta ................................: De [      ]   a [      ]  " 
         @ 07, 07 Say "Banco ................................: De [   ]      a [   ]     " 
         @ 08, 07 Say "Cliente ..............................: De [      ]   a [      ]  " 
         @ 09, 07 Say "Vencimento ...........................: De [        ] a [        ]" 
         @ 10, 07 Say "Emiss„o ..............................: De [        ] a [         " 
         @ 11, 07 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
         @ 12, 07 Say "Remessa para Debito/Cadastramento ....: [ ]" 
         @ 13, 07 Say "Conta corrente p/recebimento .........: [   ]" 
         @ 14, 07 Say "Montante m ximo a ser remetido .......: [              ]" 
         @ 15, 07 Say "Valor m ximo para parcela ............: [              ]" 
         @ 16, 07 Say "Percentual de divis„o do valor .......: [    ]" 
         @ 17, 07 Say "Sele‡„o especial .....................: [ ]" 
         @ 18, 07 Say "Nova data de vencimento ..............: [        ]" 
         @ 19, 07 Say "Multa sobre o atraso p/sem fundos ....: [    ]" 
         @ 20, 07 Say "Corr. monet ria mensal p/atrasados ...: [    ]" 
 
         nLanc1:= 0 
         nLanc2:= 99999999 
 
         @ 05, 50 Get nLanc1 Pict "99999999" ; 
            When Mensagem( "Digite o codigo de lancamento inicial." ) 
         @ 05, 63 Get nLanc2 Pict "99999999" When; 
            Mensagem( "Digite o codigo de lancamento final." ) 
         @ 06, 50 Get nDuplic1  Pict "999999"  ; 
				When Mensagem( " Digite o n£mero da duplicata inicial " ) 
           @ 06, 63 Get nDuplic2  Pict "999999"  ; 
              When Mensagem( " Digite o n£mero da duplicata final " ) 
         @ 07, 50 Get nBanco1   Pict "999"     ; 
				When Mensagem( " Digite o c¢digo do banco inicial " ) 
           @ 07, 63 Get nBanco2   Pict "999"     ; 
              When Mensagem( " Digite o c¢digo do banco final " ) 
         @ 08, 50 Get nClient1  Pict "999999"  ; 
				When Mensagem( " Digite o c¢digo do cliente inicial " ) 
           @ 08, 63 Get nClient2  Pict "999999"  ; 
              When Mensagem( " Digite o c¢digo do cliente final " ) 
         @ 09, 50 Get dVenc1                   ; 
				When Mensagem( " Digite a data de vencimento inicial " ) 
           @ 09, 63 Get dVenc2                   ; 
              When Mensagem( " Digite a data de vencimento final " ) 
         @ 10, 50 Get dEmiss1                  ; 
				When Mensagem( " Digite a data de emiss„o inicial " ) 
           @ 10, 63 Get dEmiss2                  ; 
              When Mensagem( " Digite a data de emiss„o final " ) 
         @ 12, 47 Get cCodReg   Pict "!" Valid LastKey() == K_UP .OR. ; 
            IF( !LastKey() == K_UP, fCodReg( @cCodReg ), .T. ) ; 
            When Mensagem( " Digite D=Debito, I=Inclusao Cad. E=Exclusao Cad." ) 
         @ 13, 47 Get nConta_   Pict "999" Valid PesqCtaCorrente( @nConta_ ) ; 
            .OR. LastKey() == K_UP ; 
            When Mensagem( " Digite o c¢digo da conta corrente " ) 
         @ 14, 47 Get nValorL   Pict "@R 999,999,999.99" ; 
				When Mensagem( " Digite o valor m ximo a ser enviado ao banco " ) 
         @ 15, 47 Get nValPar   Pict "@R 999,999,999.99" ; 
				When Mensagem( " Digite o valor m ximo da parcela dividida " ) 
         @ 16, 47 Get nPerc     Pict "@R 999.99%" Valid( nPerc <= 100 ) ; 
            .OR. LastKey() == K_UP ; 
            When Mensagem( " Digite o percentual de divis„o do valor " ) 
         @ 17, 47 Get cSelEsp   Pict "!" Valid LastKey() == K_UP .OR. ; 
            IF( !LastKey() == K_UP, fSelEsp( @cSelEsp ), .T. ) ; 
            When Mensagem( " Digite S=Sem Fundos, C=Com Fundos ou T=Todas" ) 
         @ 18, 47 Get dDatVen  Pict "999999"  ; 
            When Mensagem( " Digite a nova data de vencimento " ) 
         @ 19, 47 Get nMulta_   Pict "@R 999.99%" Valid( nMulta_ <= 100 ) ; 
            .OR. LastKey() == K_UP ; 
            When Mensagem( " Digite o percentual da multa sobre o valor " ) 
         @ 20, 47 Get nCorMon   Pict "@R 999.99%" Valid( nCorMon <= 100 ) ; 
            .OR. LastKey() == K_UP ; 
            When Mensagem( " Digite o percentual da corre‡„o monet ria sobre o valor " ) 
 
         SetCursor( 1 ) 
         READ 
         SetCursor( 0 ) 
 
         IF LastKey() == K_ESC 
            EXIT 
         ELSE 
        IF LastKey () == K_PGDN 
           fCodReg( @cCodReg ) 
           fSelEsp( @cSelEsp ) 
           PesqCtaCorrente( @nConta_ ) 
        ENDIF 
        IF cSelEsp=="S" .AND. EMPTY( dDatVen ) 
           IF SWAlerta( "Atencao! Para Geracao de Informacoes ;de duplicatas com retorno bancario; Sem Fundo, ‚ importante que se informe ;uma nova data de vencimento", { "Cancela", "Gerar"} ) == 1 
              Loop 
           ENDIF 
        ENDIF 
        IF Confirma( 00,00, "Confirma a gera‡„o das duplicatas?", , "S" ) 
 
           DO CASE 
              CASE cCodReg=="D" 
                   cCadTip := " " 
              CASE cCodReg=="I" 
                   cCadTip := "2" 
              CASE cCodReg=="E" 
                   cCadTip := "1" 
           ENDCASE 
 
* Alberto Tue  14-05-02 
*           DiarioComunicacao( "Selecao de Duplicatas (DEB.AUTOMATICO)", "BANCO" ) 
*           DiarioComunicacao( "      Cad.Tipo: " + cCadTip, "LOG" ) 
*           DiarioComunicacao( "   Lancamentos: " + Str( nLanc1 ) + " " + Str( nLanc2 ),     "LOG" ) 
*           DiarioComunicacao( "       Emissao: " + DTOC( dEmiss1 ) + " " + DTOC( dEmiss2 ), "LOG" ) 
*           DiarioComunicacao( "    Vencimento: " + DTOC( dVenc1  ) + " " + DTOC( dVenc2  ), "LOG" ) 
*           DiarioComunicacao( "       Selecao: " + IF( cSelEsp=="S", "Sem Fundos", "Com Fundos" ), "LOG" ) 
 
           DBSelectAr( _COD_DUPAUX ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           SET INDEX TO 
 
                                    dbSelectAr(_COD_BANCO) 
           Set Filter To CODIGO >= nBanco1 .AND. CODIGO <= nBanco2 
           dbGoTop() 
 
           CLI->( DBSetOrder( 1 ) ) 
 
           dbSelectAr(_COD_DUPAUX) 
                                    dbgotop() 
 
           ERASE VPCCTRLB.$$$ 
 
                                    /* Filtra os registros que interessam */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO VPCCTRLB.$$$ EVAL {|| Processo() } ; 
              FOR CODIGO >= nLanc1 .AND. CODIGO <= nLanc2 .AND.; 
                  IF( TIPO__=="02", CODNF_ >= nDuplic1 .AND.; 
                                    CODNF_ <= nDuplic2, .T. ) .AND.; 
                  CLIENT >= nClient1 .AND. CLIENT <= nClient2 .AND.; 
                  EMPTY( DTQT__ ) .AND.; 
                                                     ( LOCAL_ >= nBanco1 .AND. LOCAL_ <= nBanco2 ) .AND.; 
                  ( VENC__ >= dVenc1  .AND. VENC__ <= dVenc2 )  .AND.; 
                                                     ( DATAEM >= dEmiss1 .AND. DATAEM <= dEmiss2 ) .AND.; 
                  NFNULA==" " 
                  //.AND. IF( cSelEsp=="S", !SITU__==" ", SITU__==" " ) 
           DBGOTOP() 
 
           Set Relation To CLIENT Into CLI 
           Mensagem( "Gerando a Selecao de Duplicatas, aguarde... " ) 
 
           IF FILE( "VPCCTRLB.$$$" ) 
                                            // Geracao do Controle 
              cVpcCtrlb:= ScreenSave( 0, 0, 24, 79 ) 
                                            Aviso( "Gerando as Duplicatas ..." ) 
              DBSelectAr( _COD_DUPAUX ) 
                                            DBGoTop() 
                                            nReg:= 0 
                                            nSoma:= 0 
 
              nFator:= Int( 100 / nPerc ) 
 
 
              CTB->( DBSetOrder( 5 ) ) 
 
              /* Filtro de Informacoes CTB */ 
              /* Caso a selecao especial seja "S" tirar da lista de enviadas 
                 as que estiverem com a Situacao Substituida, para q o sistema 
                 encontre apenas as com retorno 01 p/ exemplo. */ 
              IF cSelEsp=="S" 
                 nAreaRes:= Select() 
                 DBSelectAr( "CTB" ) 
                 Set Filter To !( SITRET $ "NA-NV" ) 
                 DBSelectAr( nAreaRes ) 
              ENDIF 
 
              dBloDtV1:= CTOD( "  /  /  " ) 
              dBloDtV2:= CTOD( "  /  /  " ) 
              nBloCta1:= 0 
              nBloCta2:= 0 
              nBloCod1:= 0 
              nBloCod2:= 0 
              aBloCtas:= {} 
              IF File( GDir - "\BLOQUEIO.DBF" ) 
                 BuscaBloqueios( @dBloDtV1, @dBloDtV2, @nBloCta1, @nBloCta2,; 
                                 @nBloCod1, @nBloCod2, @aBloCtas ) 
                 VPBox( 04, 05, 21, 74, "INFORMACOES DE BLOQUEIO / SELECAO", _COR_GET_BOX ) 
                 @ 07,07 Say "Com Vencimento entre " + DTOC( dBloDtV1 ) + " e " + DTOC( dBloDtV2 ) Color _COR_GET_EDICAO 
                 @ 08,07 Say "Com Conta de receita entre " + Str( nBloCta1, 3, 0 ) + " e " + Str( nBloCta2, 3, 0 ) Color _COR_GET_EDICAO 
                 @ 09,07 Say "Codigo Lancamento/Duplicata/Nota entre " + Str( nBloCod1, 9, 0 ) + " e " + Str( nBloCod2, 9, 0 ) Color _COR_GET_EDICAO 
                 FOR nCt:= 1 TO 30 
                    @ 11,07 Say "Preparando p/ iniciar" + Repl( ".", nCt ) 
                    Inkey(.05) 
                 NEXT 
              ENDIF 
 
              WHILE( !DPA->( EOF() ) .AND. nSoma <= nValorL ) 
 
                 lGerar:= .F. 
                 lBloqueado:= .F. 
 
                 IF ( CLI->CONTAC <= 0 .OR. AT( " ", LEFT( CLI->AGENCI, 4 ) ) > 0 ) .AND. !( nOpcContaAge == 3 ) 
                    IF ( nOpcContaAge:= SWAlerta( DPA->CDESCR + ";Cliente com Codificacao de Agencia ou Conta Invalida", { "Nao gerar", "Gerar mesmo assim", "Gerar sem avisar" } ) )==1 
                       lBloqueado:= .T. 
                    ELSE 
                       lBloqueado:= .F. 
                    ENDIF 
                 ENDIF 
 
                 /* Verifica se conta corrente esta na lista de bloquadas */ 
                 IF !lBloqueado .AND. Len( aBloCtas ) > 0 
                    FOR nCt:= 1 TO Len( aBloCtas ) 
                        IF StrZero( val( aBloCtas[ nCt ][ 2 ] ), 10 )==StrZero( CLI->CONTAC, 10, 0 ) .AND.; 
                           VAL( aBloCtas[ nCt ][ 2 ] ) <> 0 
                           lBloqueado:= .T. 
                           EXIT 
                        ENDIF 
                    NEXT 
                 ENDIF 
 
                 /* Verifica se conta esta bloqueada */ 
                 IF !lBloqueado .AND. nBloCta1 > 0 .AND. nBloCta2 > 0 
                    IF DPA->TIPO__=="02" 
                       IF DPA->CODNF_ >= nBloCta1 .AND. DPA->CODNF_ <= nBloCta2 
                          lBloqueado:= .T. 
                       ENDIF 
                    ELSE 
                       IF DPA->CODIGO >= nBloCta1 .AND. DPA->CODIGO <= nBloCta2 
                          lBloqueado:= .T. 
                       ENDIF 
                    ENDIF 
                 ENDIF 
 
                 /* Verifica se o lancamento / registro duplicata esta bloqueada */ 
                 IF !lBloqueado .AND. nBloCod1 > 0 .AND. nBloCod2 > 0 
                    IF DPA->TIPO__=="02" 
                       IF DPA->CODIGO >= nBloCod1 .AND. DPA->CODIGO <= nBloCod2 
                          lBloqueado:= .T. 
                       ENDIF 
                    ELSE 
                       IF DPA->CODNF_ >= nBloCod1 .AND. DPA->CODNF_ <= nBloCod2 
                          lBloqueado:= .T. 
                       ENDIF 
                    ENDIF 
                 ENDIF 
 
                 /* Verifica se o vencimento esta bloqueado */ 
                 IF !lBloqueado .AND. !dBloDtV1==CTOD( "  /  /  " ) .AND.; 
                    !dBloDtV2==CTOD( "  /  /  " ) 
                    IF DPA->VENC__ >= dBloDtV1 .AND. DPA->VENC__ <= dBloDtV2 
                       lBloqueado:= .T. 
                    ENDIF 
                 ENDIF 
                 IF File( GDir - "\BLOQUEIO.DBF" ) 
                    @ 12,07 Say IF( lBloqueado, "Registro Bloqueado", "Liberado...          " ) 
                    Scroll( 13, 07, 20, 73, 1 ) 
                    @ 20,07 Say CLI->DESCRI 
                 ENDIF 
 
                 lReSelecao:= .F. 
                 IF !lBloqueado .AND. ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) > 0 .AND.; 
                    IF( DPA->TIPO__=="02", DPA->CODIGO, DPA->CODNF_ ) > 0 
                    IF !cSelEsp == "T" 
                       cTmp:= IF( !EMPTY( CLI->IDENTI ), CLI->IDENTI, DPA->CDESCR ) 
                       IF CTB->( DBSeek( IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 10, 0 ), StrZero( DPA->CODNF_, 09, 0 ) + DPA->LETRA_ ) ) ) 
                          WHILE( !CTB->( EOF() ) .AND. CTB->CODIGO==IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 10, 0 ), StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) ) 
                             IF CTB->CODIGO == IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 10, 0 ), StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) 
 
                                IF cSelEsp $ "S" .AND.; 
                                   CTB->SITRET $ "01-14" 
 
                                   /* Verificacao da data de geracao das informacoes */ 
                                   IF !nOpcaoData==2 .AND. cSelEsp=="S" .AND. dDatVen <= DATE() + 1 
                                      nOpcaoData:= SWAlerta( DPA->CDESCR + "[" + Str( DPA->CODIGO ) + "] ;Data de Vencimento incompativel. ;Esta duplicata sera desconsiderada pelo banco.",; 
                                                   { "Nao gerar", "Nunca Gerar", "Gerar mesmo assim" } ) 
                                      IF nOpcaoData==1 
                                         lGerar:= .F. 
                                      ELSEIF nOpcaoData==2 
                                         lGerar:= .F. 
                                      ELSEIF nOpcaoData==3 
                                         lGerar:= lGerar 
                                      ENDIF 
                                   ELSEIF nOpcaoData==2 .AND. cSelEsp=="S" .AND. dDatVen < DATE() 
                                      lGerar:= .F. 
                                   ENDIF 
 
                                   IF nOpcaoData == 0 .OR. ( nOpcaoData <> 0 .AND. lGerar ) 
                                      IF CTB->( NetRLock() ) 
                                         IF CTB->SITRET=="01" //.OR. CTB->SITRET=="NV" 
                                            Replace CTB->SITRET With "NV",; 
                                                    CTB->SELEC_ With "Nao" 
                                            lGerar:= .T. 
                                            lReSelecao:= .T. 
                                         ELSEIF CTB->SITRET=="14" //.OR. CTB->SITRET=="NA" 
                                            Replace CTB->SITRET With "NA",; 
                                                    CTB->SELEC_ With "Nao" 
                                            lGerar:= .T. 
                                            lReSelecao:= .T. 
                                         ENDIF 
                                         dV:= CTB->DATVEN 
                                         nRegistro:= CTB->( RECNO() ) 
                                         /* Verifica se j  nao existe uma duplicata selecionada e enviada sem retorno */ 
                                         WHILE CTB->CODIGO==IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 10, 0 ), StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) .AND. !CTB->( EOF() ) 
                                             IF CTB->SITRET=="  " 
                                                lGerar:= .F. 
                                                lReSelecao:= .F. 
                                                EXIT 
                                             ENDIF 
                                             CTB->( DBSkip() ) 
                                         ENDDO 
                                         CTB->( DBGoTo( nRegistro ) ) 
                                      ENDIF 
                                   ENDIF 
                                ELSE 
                                   lGerar:= .F. 
                                ENDIF 
                                EXIT 
                             ENDIF 
                             CTB->( DBSkip() ) 
                          ENDDO 
                       ELSE 
                          lGerar:= .T. 
                       ENDIF 
                    ELSE 
                       lGerar:= .T. 
                    ENDIF 
 
                    IF lGerar 
                       nValOri:= DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES 
                       IF nMulta_ > 0 
                          nValOri:= nValOri * ( nMulta_ / 100 + 1 ) 
                       ENDIF 
                       IF nCorMon > 0 
                          nValOri:= nValOri + JurosFuturos( nValOri, ; 
                             DPA->VENC__, DATE(), nMulta_ ) 
                       ENDIF 
                       DO CASE 
                          CASE( nPerc == 0 .OR. nPerc == 100 ) ; 
                                .AND. ( nValPar == 0 ; 
                                .OR. nValPar == 999999999.99 ) 
                             nValorParc := nValOri 
                             nFatorx    := 1 
                          CASE( nPerc == 0 .OR. nPerc == 100 ) ; 
                                .AND. nValPar > 0 ; 
                                .AND. nValOri <= nValPar 
                             nValorParc := nValOri 
                             nFatorx    := 1 
                          CASE( nPerc == 0 .OR. nPerc == 100 ) ; 
                                .AND. nValPar > 0 ; 
                                .AND. nValOri > nValPar 
                             nValorParc := nValpar 
                             nFatorx    := Int( nValOri / nValpar ) 
                          CASE( nPerc > 0 .AND. nPerc < 100 ) ; 
                                .AND. ( nValPar == 0 ; 
                                .OR. nValPar == 999999999.99 ) 
                             nValorParc := Int( nValOri / nFator * 100 ) / 100 
                             nFatorx    := nFator 
                          CASE( nPerc > 0 .AND. nPerc < 100 ) ; 
                                .AND. nValPar > 0 ; 
                                .AND. nValOri <= nValPar 
                             nValorParc := Int( nValOri / nFator * 100 ) / 100 
                             nFatorx    := nFator 
                          CASE( nPerc > 0 .AND. nPerc < 100 ) ; 
                                .AND. nValPar > 0 ; 
                                .AND. nValOri > nValPar 
                             nValorParc := Int( nValOri / nFator * 100 ) / 100 
                             IF nValorParc > nValPar 
                                nValorParc := nValpar 
                                nFatorx    := Int( nValOri / nValpar ) 
                             ELSE 
                                nFatorx    := nFator 
                             ENDIF 
                       ENDCASE 
 
                       IF Abs( ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) - nValorParc ) < 0.05 
                          nValorParc := DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES 
                       ENDIF 
 
                       IF ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) - nValorParc * nFatorx > 0 
                          nFatorx++ 
                       ENDIF 
 
                       FOR nCt:= 1 TO nFatorx 
                          IF nCt == nFatorx 
                             IF ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) - nValorParc * ( nFatorx - 1 ) > 0 
                                nValorParc:= ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) - nValorParc * ( nFatorx - 1 ) 
                             ENDIF 
                          ENDIF 
                          IF buscanet(5,{|| CTB->( dbappend() ), !Neterr()}) 
                             cTmp:= IF( !EMPTY( CLI->IDENTI ), CLI->IDENTI, DPA->CDESCR ) 
                             Replace CTB->CODIGO With IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 9, 0 ) + "m", StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) 
                             Replace CTB->SUBCOD With StrZero( nCt, 2, 0 ) 
                             CTB->CODREG:= cCodReg     //Codigo do Registro 
                             CTB->CADTIP:= cCadTip     // Tipo do Cadastramento 
                             Replace CTB->IDECLI With CTB->CODIGO + " " + cTmp        // Identificacao do Cliente na Empresa 
                             CTB->IDECON:= cTmp                       // Identificao do Consumidor na Empresa 
                             CTB->NOMCON:= CLI->DESCRI // Nome do Consumidor 
                             CTB->CIDCON:= CLI->CIDADE // Cidade do Consumidor 
                             CTB->ESTCON:= CLI->ESTADO // Estado do Consumidor 
                             CTB->TIPCOD:= IF( !EMPTY( CLI->CGCMF_), "1", "2" ) // 1=CGC  2=CPF 
                             CTB->CGCCPF:= IF( !EMPTY( CLI->CGCMF_), CLI->CGCMF_, CLI->CPF___ ) // CGC ou CPF 
                             CTB->CONTAC:= VAL( STR( CLI->CONTAC, 9 ) + CLI->DIGVER ) // Conta Corrente 
                             CTB->NUMAGE:= CLI->AGENCI // Numero da Agencia 
                             CTB->CODCLI:= CLI->CODIGO 
                             CTB->CODBAN:= CLI->BANCO_ // Codigo do Banco 
                             IF BAN->(DBSeek ( CLI->BANCO_ ) ) 
                                CTB->NOMBAN:= BAN->DESCRI // Nome do Banco 
                             ELSE 
                                CTB->NOMBAN:= ""          // Nome do Banco 
                             ENDIF 
                             CTB->DATVEN:= IF( EMPTY( dDatVen ), ; 
                                DPA->VENC__, dDatVen ) // Data do Vencimento 
                             CTB->DATOPC:= DPA->DATAEM // Data da Opcao 
                             CTB->CODMOE:= "03"        // Codigo da Moeda (01=UFIR 03=REAIS) 
                             CTB->VALDEB:= nValorParc  // Valor do Debito Original/Parcela 
                             CTB->VALORI:= nValOri     // Valor do Debito Somente Original 
                             IF nValPar >= 999999.99 
                                Replace CTB->VALDEB With nValOri,; 
                                        CTB->VALORI With nValorParc 
                             ENDIF 
                             CTB->SITUAC:= IF( lReSelecao, "RE-SELECAO", "REMESSA" ) // Situacao da Cobranca (Remessa/Retorno) 
                             CTB->JAENVI:= "Nao"       // Marcacao de Enviado 
                             CTB->NOMEMP:= Alltrim( _EMP )       // Nome da Empresa 
                             CTB->CODCON:= SWSet( _GER_BCO_CONVENIO ) // Codigo de Convenio (Informado pelo Banco) 
                             CTB->CTAREC:= nConta_     // Codigo da Conta Corrente de Receptacao 
                             CTB->ENDAGE:= DPA->OBS___ 
                             CTB->SELEC_:= "Sim"       // ("Nao"=NAO VAI) ("Sim"=VAI SIM) 
                             IF DPA->TIPO__ =="02" 
                                CTB->NUMDUP:= DPA->CODIGO 
                             ELSE 
                                CTB->NUMDUP:= DPA->DUPL__ // Numero da Duplicata 
                             ENDIF 
                             CTB->SEQDUP:= DPA->LETRA_ // Sequencia da Duplicata 
                             CTB->MULTA_:= nMulta_     // Multa 
                             CTB->CORMON:= nCorMon     // Correcao Monetaria 
                             CTB->VALPAR:= nValPar     // Valor Maximo para Parcela 
                             nReg++ 
                             nSoma+= nValorParc 
                          ENDIF 
                       NEXT 
                       IF DPA->( NetRLock() ) 
                          DPA->SITU__:= "*" 
                       ENDIF 
                    ENDIF 
                 ENDIF 
                 DPA->( DBSkip() ) 
              ENDDO 
 
              dbSelectAr(_COD_BANCO) 
              Set Filter To 
 
              DBSelectAr( _COD_DUPAUX ) 
                                            Set Filter To 

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx",;   
                             "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx",;   
                             "&gdir/dpaind05.ntx" 
              #else
                SET INDEX TO "&GDIR\DPAIND01.NTX", "&GDIR\DPAIND02.NTX",;   
                             "&GDIR\DPAIND03.NTX", "&GDIR\DPAIND04.NTX",;   
                             "&GDir\DPAIND05.NTX" 

              #endif
              ERASE VPCCTRLB.$$$ 
 
              ScreenRest( cVpcCtrlb ) 
              cVpcCtrlb:= ScreenSave( 0, 0, 24, 79 ) 
              IF nReg == 0 
                 Aviso( "Nenhuma Duplicata Selecionada!" ) 
                 Mensagem( "Pressione [ENTER] para uma nova selecao..." ) 
                 Pausa() 
                 LOOP 
              ENDIF 
 
              Aviso( "Foram geradas " + Alltrim( Str( nReg, 6 ) ) + " duplicatas !" ) 
              Mensagem( "Pressione [ENTER] para Continuar..." ) 
              Pausa() 
              ScreenRest( cVpcCtrlb ) 
*              Aviso( "Foram geradas " + Alltrim( Str( nReg, 6 ) ) + " duplicatas !" ) 
*              DiarioComunicacao( "°°°°±±±±±±²²²²²²²²²²///////COBRANCA BANCARIA///////ÛÛÛ", "Fim da Selecao de Duplicatas" ) 
 
               EXIT 
 
             ENDIF 
          ENDIF 
        ENDIF 
     ENDDO 
 
      /* Desfazer Filtros */ 
      DBSelectAr( "CTB" ) 
      Set Filter To 
      DBCloseAll() 
      AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
 
      SetColor( cCor ) 
		SetCursor( nCursor ) 
		ScreenRest( cTela ) 
 
	Return Nil 
 
 
 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
   Function fSelEsp( cSelEsp ) 
 
		Local cCor:= SetColor(), nCursor:= SetCursor(),; 
				cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nTecla:= LastKey() 
      Local nOPCAO:= 1 
 
      IF cSelEsp == "C" .OR. cSelEsp == "S" 
         Return .T. 
      ENDIF 
 
      vpbox(16,56,20,70, , _COR_BROW_BOX, .F., .F. ) 
 
		mensagem("") 
      @ 17,50 Say " ÄÄÄÄ" Color _COR_GET_BOX 
 
		SetColor ( _COR_BROWSE ) 
      @ 17,57 Prompt " Com Fundos  " 
      @ 18,57 Prompt " Sem Fundos  " 
      @ 19,57 Say    " Todas       " Color "07/" + CorFundoAtual() 
 
		menu to nOpcao 
 
		DO CASE 
			CASE nOpcao == 2 
				cSelEsp := "S" 
			CASE nOpcao == 3 
				cSelEsp := "T" 
			OTHERWISE 
				cSelEsp := "C" 
            KeyBoard( Chr( nTecla ) ) 
            KeyBoard( Chr( nTecla ) ) 
      ENDCASE 
 
		SetColor( cCor ) 
		SetCursor( nCursor ) 
		ScreenRest( cTela ) 
 
   Return .T. 
 

   /*
   ---------------------------------------------------------------------- 
   Cobranca Simples Banrisul 
   Layout.: CNAB - BDL = DESERV( Central de Servicos ) 
   Contato: DEBORA... F: 215.2336 - Banrisul - Atendimento/Suporte 
 
   Cobranca Bradesco                     by Gelson Oliveira (Outubro/2002) 
   Sr. Peterson (Bradesco Porto Alegre)  4426.peterson@bradesco.com.br 
 
   Cobranca Santander                    by Gelson Oliveira (Marco/2004)
   Cliente: DacService (Anita)
 
   ---------------------------------------------------------------------- 
   Cobranca Banco do Brasil 
   Cliente: SULROL 
   Contato: 3337.4099 r. 206 - Paulo Moraes 
            3373.1780 - Debora - Convenio de cobranca  by Valmor Flores (Agosto/2003) 
                        Layout CNAB 
   */
   Function fGeraLCob(QualBanco) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
      Local cAno, cMes, cDia, cLinha, cVpcCtrlb, nHandle, nValTot, nNumSeqArq, nBytes 
 
      Local cTipoCob:= "805076" 
 
      Private cTipoDocumento:= "06", cTipoOcorrencia:= "01", nJuros:= 7, nDiasProtesto:= 3 
      Private cMensagem:= PAD( "MANUTENCAO MENSAL", 32 ), nTxMulta := 0, cAceite:= "N" 
      Private cInstr1:= "01", cInstr2:= "09", nDiasMulta:= 0, nQuaRegs:= 0
      Private nGerArqBAn:= 0, cgInstru:= Space( 30 )
 
      cAno:= Right( StrZero( Year (Date() ) , 4 ), 2 ) 
      cMes:= StrZero( Month( Date() ), 2 ) 
      cDia:= StrZero( Day  ( Date() ), 2 ) 
 
      if !diretorio( GDIR+"\ENVIO") 
         !md "&GDIR\envio" 
      endif 
      if !diretorio( GDIR+"\RETORNO") 
         !md "&GDIR\RETORNO" 
      endif 
 
      if QualBanco = 41 
         cArqRemessa:= Left( "&GDIR\ENVIO\D" + cDia + "E" + cAno + cMes + ".041" + Space( 100 ), 64 ) 
 
         FOR nCt:= 41 TO 941 Step 100 
             cArqRemessa:= Left( "&GDIR\ENVIO\D" + cDia + "E" + cAno + cMes + "." + StrZero( nCt, 3, 0 ) + ; 
                                Space( 100 ), 64 ) 
             IF !File( Alltrim( cArqRemessa ) ) 
                EXIT 
             ENDIF 
         NEXT 
      ENDIF 
      if QualBanco = 275 
         cArqRemessa:= Left( "&GDIR\ENVIO\REM" + cDia + cMes + ".TXT" + Space( 100 ), 64 ) 
         cLt := "" 
         // PEGA AS LETRAS DA TABELA ASC DE A ATE Z 
         FOR nCt:= 65 TO 90 
             cArqRemessa:= Left( "&GDIR\ENVIO\REM" + cDia + cMes + cLt+".TXT" + Space( 100 ), 64 ) 
             IF !File( Alltrim( cArqRemessa ) ) 
                EXIT 
             ENDIF 
             cLt := CHR(nCT) 
         NEXT 
      endif 
      if QualBanco = 409 
         //N.REG ATUAL DO BANCO 
         IF File( "UNIBANCO.MEM" ) 
            rest from UNIBANCO ADDI 
         ENDIF 
         nGerArqBAn ++ 
 
         cArqRemessa:= Left( "&GDIR\ENVIO\UNI" + cDia + cMes + "1.REM" + Space( 100 ), 64 ) 
         cLt := "1" 
         FOR nCt:= 1 TO 9 
             cArqRemessa:= Left( "&GDIR\ENVIO\REM" + cDia + cMes + cLt+".REM" + Space( 100 ), 64 ) 
             IF !File( Alltrim( cArqRemessa ) ) 
                EXIT 
             ENDIF 
             cLt := Str(nCT,1) 
         NEXT 
      endif 
 
      cArqRemessa:= Left( "&GDIR\ENVIO\BB" + cDia + cMes + "01.REM" + Space( 100 ), 64 ) 
      cLt := "01" 
      FOR nCt:= 1 TO 9 
          cArqRemessa:= Left( "&GDir\ENVIO\BB" + cDia + cMes + cLt+".REM" + Space( 100 ), 64 ) 
          IF !File( Alltrim( cArqRemessa ) ) 
             EXIT 
          ENDIF 
          cLt := StrZero(nCT,2) 
      NEXT 
 
      IF QualBanco = 1 
         cArqRemessa:= Left( "&GDIR\ENVIO\REM" + cDia + cMes + ".001" + Space( 100 ), 64 ) 
         cLt := "" 
         // PEGA AS LETRAS DA TABELA ASC DE A ATE Z 
         FOR nCt:= 65 TO 90 
             cArqRemessa:= Left( "&GDIR\ENVIO\REM" + cDia + cMes + cLt+".001" + Space( 100 ), 64 ) 
             IF !File( Alltrim( cArqRemessa ) ) 
                EXIT 
             ENDIF 
             cLt := CHR(nCT) 
         NEXT 
      ENDIF 
 
      if QualBanco = 237 
         //N.REG ATUAL DO BANCO 
         IF File( "BRADESCO.MEM" ) 
            rest from BRADESCO ADDI 
         ENDIF 
         nGerArqBAn ++ 
 
         cArqRemessa:= Left( "C:\TBI_TCP\CB" + cDia + cMes + "01.REM" + Space( 100 ), 64 ) 
         cLt := "01" 
         FOR nCt:= 1 TO 9 
             cArqRemessa:= Left( "C:\TBI_TCP\CB" + cDia + cMes + cLt+".REM" + Space( 100 ), 64 ) 
             IF !File( Alltrim( cArqRemessa ) ) 
                EXIT 
             ENDIF 
             cLt := StrZero(nCT,2) 
         NEXT 
      endif 

      if QualBanco = 8
         // GELSON 04/03/2004
         //N.REG ATUAL DO BANCO 
         IF File( "SANTANDE.MEM" )
            rest from SANTANDE ADDI
         ENDIF 
         nGerArqBAn ++ 
 
         cArqRemessa:= Left( "\MERIDION\REMESSAS\CB" + cDia + cMes + "01.ENT" + Space( 100 ), 64 )
         cLt := "01" 
         FOR nCt:= 1 TO 9 
             cArqRemessa:= Left( "\MERIDION\REMESSAS\CB" + cDia + cMes + cLt+".ENT" + Space( 100 ), 64 )
             IF !File( Alltrim( cArqRemessa ) ) 
                EXIT 
             ENDIF 
             cLt := StrZero(nCT,2) 
         NEXT 
      endif 
      SetColor( _COR_GET_EDICAO )
 
      cVpcCtrlb:= ScreenSave( 0, 0, 24, 79 ) 
 
      IF SWAlerta( "COBRANCA BANCARIA - VIA BDL-SIMPLES;"+; 
         "Geracao automatica do arquivo remessa" + ";" + ALLTRIM( cArqRemessa ) + ";para envio das duplicatas selecionaas ao banco!", { "Nao Gerar", "Gerar Envio" } )==2 
 
         IF LastKey()==K_ESC 
            SetColor( cCor ) 
            Return Nil 
         ENDIF 
 
         cArqRemessa:= PAD( cArqRemessa, 45 ) 
         if QualBanco = 41 
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - BANRISUL", _COR_GET_EDICAO ) 
            @ 02,02 Say "Tipo de Cobranca.....:" Get cTipoCob           When Instrucao( "1" ) 
            @ 03,02 Say "Mensagem.............:" Get cMensagem          When Instrucao( "0" ) 
            @ 04,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
            @ 05,02 Say "Aceite...............:" Get cAceite            When Instrucao( "0" ) 
            @ 06,02 Say "Tipo de Documento....:" Get cTipoDocumento     When Instrucao( "2" ) 
            @ 07,02 Say "Tipo de Ocorrencia...:" Get cTipoOcorrencia    When Instrucao( "3" ) 
            @ 08,02 Say "Instrucao............:" Get cInstr1            When Instrucao( "4" ) 
            @ 08,29 Get cInstr2 
            @ 09,02 Say "Dias p/Multa Apos Ven:" Get nDiasMulta Pict "99" when Instrucao( "5" ) 
            @ 10,02 Say "Dias p/Protesto......:" Get nDiasProtesto  Pict "99" when Instrucao( "6" ) 
            @ 11,02 Say "Taxa de Multa........:" Get nTxMulta       Pict "99.99" 
 
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa        when Instrucao( "Nome do arquivo" ) 
         ENDIF 
         if QualBanco = 237 
            nJuros := 7 
            nDiasProtesto := 7 
            cMensagem := "" 
            nTxMulta := 2 
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - BRADESCO", _COR_GET_EDICAO ) 
//            @ 02,02 Say "Tipo de Cobranca.....:" Get cTipoCob           When Instrucao( "1" ) 
//            @ 03,02 Say "Mensagem.............:" Get cMensagem          When Instrucao( "0" ) 
            @ 04,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
//            @ 05,02 Say "Aceite...............:" Get cAceite            When Instrucao( "0" ) 
//            @ 06,02 Say "Tipo de Documento....:" Get cTipoDocumento     When Instrucao( "2" ) 
//            @ 07,02 Say "Tipo de Ocorrencia...:" Get cTipoOcorrencia    When Instrucao( "3" ) 
//            @ 08,02 Say "Instrucao............:" Get cInstr1            When Instrucao( "4" ) 
//            @ 08,29 Get cInstr2 
//            @ 09,02 Say "Dias p/Multa Apos Ven:" Get nDiasMulta Pict "99" when Instrucao( "5" ) 
            @ 06,02 Say "N§ Sequencial Envio..:" Get nGerArqBAn     Pict "9999999" 
            @ 10,02 Say "Dias p/Protesto......:" Get nDiasProtesto  Pict "99" when Instrucao( "6" ) 
            @ 11,02 Say "Taxa de Multa........:" Get nTxMulta       Pict "99.99" 
 
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa        when Instrucao( "Nome do arquivo" ) 
         ENDIF 
 
         // BANKBOSTON 
         if QualBanco = 479 
            nJuros := 0 
            nDiasProtesto := 7 
            cMensagem := "" 
            nTxMulta := 0 
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - BANKBOSTON", _COR_GET_EDICAO )
            @ 04,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
            @ 05,02 Say "Aceite...............:" Get cAceite            When Instrucao( "0" ) 
            @ 07,02 Say "Tipo de Ocorrencia...:" Get cTipoOcorrencia    When Instrucao( "3" ) 
            @ 10,02 Say "Dias p/Protesto......:" Get nDiasProtesto  Pict "99" when Instrucao( "6" ) 
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa        when Instrucao( "Nome do arquivo" ) 
         ENDIF 
 
         if QualBanco = 275 
            nJuros := 9 
            nDiasProtesto := 8 
            cTipoDocumento := 6 
            cTipoOcorrencia := 1 
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - BANCO REAL", _COR_GET_EDICAO ) 
            @ 02,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
            @ 03,02 Say "Especie do Titulo....:" Get cTipoDocumento  pict "99" When Instrucao( "7" ) 
            @ 04,02 Say "Codigo da Ocorrencia.:" Get cTipoOcorrencia pict "99" When Instrucao( "8" ) 
            @ 05,02 Say "Dias p/Protesto......:" Get nDiasProtesto   Pict "99" when Instrucao( "9" ) 
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa        when Instrucao( "Nome do arquivo" ) 
         ENDIF 
         if QualBanco = 409 
            nJuros := 9 
            nDiasProtesto := 8 
            cTipoDocumento := 6 
            cTipoOcorrencia := 1 
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - UNIBANCO", _COR_GET_EDICAO ) 
 *           @ 02,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
 *           @ 03,02 Say "Especie do Titulo....:" Get cTipoDocumento  pict "99" When Instrucao( "7" ) 
 *           @ 04,02 Say "Codigo da Ocorrencia.:" Get cTipoOcorrencia pict "99" When Instrucao( "8" ) 
            @ 02,02 Say "Dias para Protesto....:" Get nDiasProtesto   Pict "99" when Instrucao( "9" ) 
            @ 04,02 Say "N§ Sequencial de Envio:" Get nGerArqBAn      Pict "999" 
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa        when Instrucao( "Nome do arquivo" ) 
         ENDIF 
 
         IF QualBanco = 1 
            nJuros := 9 
            nDiasProtesto := 8 
            cTipoDocumento := 6 
            cTipoOcorrencia := 1
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - UNIBANCO", _COR_GET_EDICAO ) 
            @ 02,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
            @ 03,02 Say "Especie do Titulo....:" Get cTipoDocumento  pict "99" When Instrucao( "7" ) 
            @ 04,02 Say "Codigo da Ocorrencia.:" Get cTipoOcorrencia pict "99" When Instrucao( "8" ) 
            @ 05,02 Say "Dias para Protesto....:" Get nDiasProtesto   Pict "99" when Instrucao( "9" )
            // @ 04,02 Say "N§ Sequencial de Envio:" Get nGerArqBAn      Pict "999" 
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa        when Instrucao( "Nome do arquivo" ) 
         ENDIF 
 
         // SANTANDER MERIDIONAL
         if QualBanco = 8
            // GELSON 04/03/2004
            nJuros:= 10
            nDiasProtesto:= 7
            cMensagem:= ""
            nTxMulta:= 0
            cgInstru:= PadR( "APOS VENC. COBRAR MULTA DE 2%", 30 )
            VPBox( 00, 00, 22, 79, "COBRANCA SIMPLES - SANTANDER", _COR_GET_EDICAO )
            @ 04,02 Say "Taxa de Juros (MES)..:" Get nJuros Pict "@E 9,999.99" 
            @ 05,02 Say "Aceite...............:" Get cAceite            When Instrucao( "0" ) 
            @ 06,02 Say "N§ Sequencial Envio..:" Get nGerArqBAn     Pict "9999999"
            @ 07,02 Say "Tipo de Ocorrencia...:" Get cTipoOcorrencia    When Instrucao( "3" ) 
            @ 10,02 Say "Dias p/Protesto......:" Get nDiasProtesto  Pict "99" when Instrucao( "6" ) 
            @ 12,02 Say "Instrucao............:" Get cgInstru
            @ 18,02 Say "Arquivo de Remessa ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
            @ 19,01 Get cArqRemessa     //   when Instrucao( "Nome do arquivo" )
         ENDIF 
 
         READ 
         IF LastKey()==K_ESC 
            ScreenRest( cTela ) 
            SetColor( cCor ) 
            Return Nil 
         ENDIF 
         Aviso( "Gerando a Remessa ..." ) 
 
         cCodCed:= Space( 12 ) 
         nCodBanco:= 0 
         cCgcCedente := space(16) 
         /* Localizacao no Cadastro de Agencia */ 
         CON->( DBSetOrder( 1 ) ) 
         IF CON->( DBSeek( CTB->CTAREC ) )   /* Cfe. Conta Corrente de Recepcao Selecionada */ 
            IF CON->AGENC_ > 0 
               AGE->( DBSetOrder( 1 ) ) 
               IF AGE->( DBSeek( CON->AGENC_ ) ) 
                  nCodBanco:= AGE->BANCO_ 
                  BAN->( DBSetOrder( 1 ) ) 
                  IF BAN->( DBSeek( AGE->BANCO_ ) ) 
                     cDescBanco:= BAN->DESCRI 
                  ENDIF 
                  cCodCed:= Left( CON->CODCED, 12 ) 
                  cCgcCedente:= CON->DOCUME 
               ENDIF 
            ENDIF 
         ENDIF 
 
         /* Codigo do Banco na Empresa */ 
         IF QualBanco = 41 
            nCodBanco:= IF( nCodBanco==0, 041, nCodBanco ) 
            cDescBanco:= "BANRISUL" 
            RELATORIO( "BAN041.REP" ) 
         ENDIF 
         IF QualBanco = 275 
            nCodBanco:= IF( nCodBanco==0, 275, nCodBanco ) 
            cDescBanco:= "BANCO REAL" 
            RELATORIO( "BAN275.REP" ) 
         ENDIF 
         IF QualBanco = 409 
            nCodBanco:= IF( nCodBanco==0, 409, nCodBanco ) 
            cDescBanco:= "UNIBANCO" 
            RELATORIO( "BAN409.REP" ) 
            // Salva a sequencia atual no arquivo 
            Save to UNIBANCO all Like nGerArqBAn 
         ENDIF 
 
         IF QualBanco = 237 
            nCodBanco:= IF( nCodBanco==0, 237, nCodBanco ) 
            cDescBanco:= "BRADESCO" 
            RELATORIO( "BAN237.REP" ) 
            // Salva a sequencia atual no arquivo 
            Save to BRADESCO all Like nGerArqBAn 
         ENDIF 
         IF QualBanco = 479 
            nCodBanco:= IF( nCodBanco==0, 479, nCodBanco ) 
            cDescBanco:= "BANKBOSTON" 
            RELATORIO( "BAN479.REP" ) 
         ENDIF 
         IF QualBanco = 1 
            nCodBanco:= IF( nCodBanco==0, 1, nCodBanco ) 
            cDescBanco:= "BANCO DO BRASIL" 
            RELATORIO( "BAN001.REP" ) 
         ENDIF 
         IF QualBanco = 8
            // GELSON 04/03/2004
            nCodBanco:= QualBanco          // IF( nCodBanco==0, 8, nCodBanco )
            cDescBanco:= "MERIDIONAL"
            RELATORIO( "BAN008.REP" )
            // Salva a sequencia atual no arquivo
            Save to SANTANDE all Like nGerArqBAn
         ENDIF 
 
         IF( nQuaRegs == 2 ) 
            ERASE &cArqRemessa 
         ENDIF 
         nQuaRegs:= IF( nQuaRegs < 3, 0, nQuaRegs -2 ) 
         ScreenRest( cTela ) 
         IF( nQuaRegs == 0 ) 
            Aviso( "Nenhuma Duplicata Selecionada!" ) 
         ELSE 
            Aviso( "Foram gerados " + Alltrim( Str( nQuaRegs, 6 ) ) + " registros!" ) 
         ENDIF 
*alberto Tue  14-05-02 
*         DiarioComunicacao( "Arquivo de Remessa " + cArqRemessa, cDescBanco) 
         Mensagem( "Pressione [ENTER] para encerrar." ) 
         Pausa() 
      ENDIF 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return Nil 
 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function fConsSelec( nTipo ) 
 
		Local cCor:= SetColor(), nCursor:= SetCursor(),; 
				cTela:= ScreenSave( 0, 0, 24, 79 ), nQuadro:= 0 
      Local Otb, cTmp1, cTmp2 
 
		SetCursor( 0 ) 
      DBSelectAr( _COD_CTRLBANC ) 
      IF nTipo==1 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           index on codigo tag ctbx5 for selec_=="sim" eval {|| processo() } to rebind01.ntx 
         #else 
           Index On CODIGO Tag CTBX5 For SELEC_=="Sim" Eval {|| Processo() } To REBIND01.NTX 
         #endif

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           set index to rebind01.ntx, "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx",;   
                  "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", "&gdir/ctbind05.ntx"    
         #else
           Set Index To REBIND01.NTX, "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX",;   
                  "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", "&GDir\CTBIND05.NTX"    

         #endif
      ELSE 
         DBLeOrdem() 
      ENDIF 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
		UserScreen() 
      VPBox( 00, 00, 14, 79,"CONSULTA AS DUPLICATAS SELECIONADAS", _COR_GET_BOX, .F., .F. ) 
      VPBox( 15, 00, 22, 79,"Display", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
		Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
		SetColor( _COR_BROWSE ) 
 
      CTB->( DBGoTop() ) 
 
      oTb:=TBrowseDB( 16, 01, 21, 78 ) 
      oTb:AddColumn( tbcolumnnew( "Identificao do Cliente   Vencimento" + ; 
			"        D‚bito Situa‡„o da Cobran‡a Vai Foi",; 
			{|| Left( CTB->IDECLI, 25 ) + " " + DtoC( CTB->DATVEN ) + " " + ; 
				 Tran ( CTB->VALDEB, "@E 999,999,999.99" ) + " " + ; 
				 Left( CTB->SITUAC, 20 ) + " " + Left( CTB->SELEC_, 03 ) + " " + ; 
				 IF( CTB->JAENVI == "Sim", Left( CTB->JAENVI, 03 ), ; 
					  Space( 3 ) ) + " " + SPACE( 65 ) } ) ) 
      oTb:HeadSep:= "Ä" 
		oTb:AutoLite:=.f. 
		oTb:dehilite() 
 
		Mensagem( "[ESPACO][ENTER]Vai(Sim/Nao) [DEL]Exc [TAB]Impress„o [ESC]Sair" ) 
 
      WHILE .T. 
 
			oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT  }, { 2, 1 } ) 
			WHILE !oTb:Stabilize() 
			ENDDO 
 
			DispBegin() 
			// Display das informacoes // 
			SetColor( _COR_GET_EDICAO ) 
         DO CASE 
            CASE CTB->CODREG=="D" 
               cTmp1 := "COBRANCA       " 
               cTmp2 := "               " 
            CASE CTB->CODREG=="I" 
               cTmp1 := "CADASTRAMENTO  " 
               cTmp2 := "INCLUSAO       " 
            CASE CTB->CODREG=="E" 
               cTmp1 := "CADASTRAMENTO  " 
               cTmp2 := "EXCLUSAO       " 
            OTHERWISE 
               cTmp1 := "               " 
               cTmp2 := "               " 
         ENDCASE 
         @ 02, 02 Say "Identifi‡„o do Cliente...: [" + Left( CTB->IDECLI, 25 ) + "]" 
         @ 03, 02 Say "Nome.....................: [" + Left( CTB->NOMCON, 45 ) + "]" 
         @ 04, 02 Say "Conta Corrente...........: [" + Str ( CTB->CONTAC, 10 ) + "]" 
         @ 05, 02 Say "Data da Op‡„o............: [" + DtoC( CTB->DATOPC )     + "]" 
         @ 06, 02 Say "Nome do Banco............: [" + Left( CTB->NOMBAN, 20 ) + "]" 
         @ 07, 02 Say "Data do Vencimento.......: [" + DtoC( CTB->DATVEN )     + "]" 
         @ 08, 02 Say "Valor do D‚bito..........: [" + Str ( CTB->VALDEB, 15, 2 ) + "]" 
         @ 09, 02 Say "Valor Original Corrigido.: [" + Str ( CTB->VALORI, 15, 2 ) + "]" 
         @ 13, 02 Say "Tipo de Remessa..........: [" + cTmp1 + "] [" + cTmp2 + "]" 
         IF !EMPTY( CTB->SITRET ) 
            @ 08, 53 Say "Situacao do Ultimo Retorno" 
            @ 09, 53 Say PAD( StatusRetorno( CTB->SITRET ), 26 ) Color "01/14" 
         ELSE 
            Scroll( 08, 53, 09, 78 ) 
         ENDIF 
         @ 10, 02 Say REPL( "Ä", 76 ) 
         @ 11, 02 Say "Situa‡„o da Cobran‡a.....: [" + Left( CTB->SITUAC, 45 ) + "]" 
         @ 12, 02 Say "Situacao do Debito.......: [" 
         cStatus:= "" 
         cCorStatus:= "07" 
         IF CTB->SITRET=="00" 
            cStatus:= "Debito Efetuado! Recebimento Lancado." 
            cCorStatus:= "15" 
         ELSEIF LEFT( CTB->SITRET, 1 )=="N" 
            cStatus:= "Desconsiderada/Substituida." 
            cCorStatus:= "14" 
         ELSEIF LEFT( CTB->SELEC_, 3 ) == "Sim" .AND. LEFT( CTB->JAENVI, 3 ) == "Nao" 
            cStatus:= "Selecionada para ser enviada." 
            cCorStatus:= "10" 
         ELSEIF LEFT( CTB->SELEC_, 3 ) == "Sim" .AND. LEFT( CTB->JAENVI, 3 ) == "Sim" 
            cStatus:= "Selecionada p/prox.envio, embora ja tenha sido remetida." 
            cCorStatus:= "12" 
         ELSEIF LEFT( CTB->SELEC_, 3 ) == "Nao" .AND.; 
            LEFT( CTB->JAENVI, 3 ) == "Sim" 
            cStatus:= "Ja Foi Enviada." 
            cCorStatus:= "02" 
         ELSEIF LEFT( CTB->SELEC_, 3 ) == "Nao" .AND.; 
            LEFT( CTB->JAENVI, 3 ) == "Nao" 
            cStatus:= "Nunca Foi Enviada e nao esta selecionada." 
            cCorStatus:= "12" 
         ENDIF 
         @ ROW(), COL() Say PAD( cStatus, 45 ) Color cCorStatus + "/" + CorFundoAtual() 
         @ ROW(), COL() Say "]" 
 
         IF( LASTKEY() == K_UP .OR. LASTKEY() == K_DOWN ) 
				KeyBoard( CHR( K_LEFT ) ) 
			ENDIF 
			DispEnd() 
 
			nTecla:=inkey( 0 ) 
 
			// Teste da tecla pressionadas // 
			DO CASE 
				CASE nTecla==K_ESC 
					EXIT 
				CASE nTecla==K_UP 		 ; oTb:up() 
				CASE nTecla==K_LEFT		 ; oTb:PanLeft() 
				CASE nTecla==K_RIGHT 	 ; oTb:PanRight() 
				CASE nTecla==K_DOWN		 ; oTb:down() 
				CASE nTecla==K_PGUP		 ; oTb:pageup() 
				CASE nTecla==K_PGDN		 ; oTb:pagedown() 
				CASE nTecla==K_CTRL_PGUP ; oTb:gotop() 
				CASE nTecla==K_CTRL_PGDN ; oTb:gobottom() 
				CASE nTecla==K_ENTER .OR. nTecla==K_SPACE 
               IF LEFT( CTB->SITRET, 1 )=="N" 
                  cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                  Aviso( "Este debito foi substituido por outro lancamento." ) 
                  Pausa() 
                  ScreenRest( cTelaRes ) 
               ELSEIF CTB->SITRET=="00" 
                  cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                  Aviso( "Este debito ja foi efetuado." ) 
                  Pausa() 
                  ScreenRest( cTelaRes ) 
               ELSEIF CTB->( NetRLock () ) 
						CTB->SELEC_:= IIF( CTB->SELEC_ == "Nao", "Sim", "Nao" ) 
					ENDIF 
				CASE nTecla==K_TAB 
					IF Confirma( 00, 00,; 
						"Confirma a impress„o desta Duplicata?",; 
						"Digite [S] para confirmar ou [N] p/ cancelar.", "N" ) 
						 Relatorio( "CTRLBANC.REP" ) 
					ENDIF 
            CASE nTecla==K_DEL 
               IF CTB->SEQDUP == "#" 
                  DPA->( DBSetOrder( 3 ) ) 
               ELSE 
                  DPA->( DBSetOrder( 1 ) ) 
               ENDIF 
               nCodigo:= val(left(CTB->CODIGO,9)) 
               cLetra := CTB->SEQDUP 
               IF Exclui( oTb ) 
                  oTb:RefreshAll() 
                  WHILE !oTb:Stabilize() 
                  ENDDO 
                  IF DPA->( DBSeek( nCodigo ) ) 
                     IF cLetra != "#" 
                        WHILE .NOT. DPA->(EOF()) .AND. DPA->CODNF_ = nCodigo 
                           if DPA->LETRA_ == cLetra 
                              exit 
                           endif 
                        ENDDO 
                     ENDIF 
                     IF DPA->( NetRLock() ) 
                        Replace DPA->SITU__ With " " 
                     ENDIF 
                  ENDIF 
               ENDIF 
            CASE nTecla==K_CTRL_DEL 
               DBSetOrder( 2 ) 
               IF nTipo==1 
                  IF Confirma( 0, 0, "Atencao! Desmarcar todos os lancamentos selecionados?", "", "N" ) 
                     DBGoTop() 
                     WHILE !EOF() 
                        IF CTB->SELEC_=="Sim" 
                           IF NetRLock() 
                              IF CTB->SEQDUP == "#" 
                                 DPA->( DBSetOrder( 3 ) ) 
                              ELSE 
                                 DPA->( DBSetOrder( 1 ) ) 
                              ENDIF 
                              nCodigo:= val(left(CTB->CODIGO,9)) 
                              cLetra := CTB->SEQDUP 
                              Dele 
                              IF DPA->( DBSeek( nCodigo ) ) 
                                 IF cLetra != "#" 
                                    WHILE .NOT. DPA->(EOF()) .AND. DPA->CODNF_ = nCodigo 
                                       if DPA->LETRA_ == cLetra 
                                          exit 
                                       endif 
                                    ENDDO 
                                 ENDIF 
                                 IF DPA->( NetRLock() ) 
                                    Replace DPA->SITU__ With " " 
                                 ENDIF 
                              ENDIF 
                           ENDIF 
                        ENDIF 
                        DBSkip() 
                     ENDDO 
                     DBUnlockAll() 
                     DBSetOrder( 1 ) 
                     oTb:RefreshAll() 
                     WHILE !oTb:Stabilize() 
                     ENDDO 
                  ENDIF 
               ENDIF 
            CASE nTecla==K_F2;  DBMudaOrdem( 1, oTb ) 
            CASE nTecla==K_F3;  DBMudaOrdem( 2, oTb ) 
            CASE nTecla==K_F4;  DBMudaOrdem( 4, oTb ) 
            CASE nTecla==K_F5;  DBMudaOrdem( 5, oTb ) 
 
            CASE nTecla==K_F8 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 VPBox( 0, 0, 22, 79, "Informacoes", _COR_GET_EDICAO ) 
                 aEnvios:= Directory("*.*") 
                 aRetornos:= Directory("*.*") 
                 Inkey(0) 
                 ScreenRest( cTelaRes ) 
 
            CASE DBPesquisa( nTecla, oTb ) 
 
				OTHERWISE					  ;Tone( 125 ); Tone( 300 ) 
			ENDCASE 
 
			oTb:RefreshCurrent() 
			oTb:Stabilize() 
 
		ENDDO 
 
		SetColor( cCor ) 
		SetCursor( nCursor ) 
		ScreenRest( cTela ) 
      DBSelectAr( _COD_CTRLBANC ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;   
                     "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;   
                     "&gdir/ctbind05.ntx" 
      #else
        Set Index To "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX", ;   
                     "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", ;   
                     "&GDir\CTBIND05.NTX"

      #endif
 
	Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
Function fImportRet() 
 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
                cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local GetList:={}, oTb, nRow:= 1, aFiles, cFile:= "" 
   Local cAno, cMes, cDia, cLinha, cVpcCtrlb, nHandle, nQuaRegs, nValTot, ; 
         nNumSeqArq, nBytes, cArqAtu, dNovoVcto, nDiasVcto 
   Priv cArquivo 
   Priv aOcorrencia:= {} 
   Priv aPosicoes:= {} 
 
   cVpcCtrlb:= ScreenSave( 0, 0, 24, 79 ) 
   cArqRet:= PAD( "A:\*.*", 64 ) 
 
*   UserScreen() 
*   SetColor( _COR_GET_EDICAO ) 
 
   lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
   nCodBAnco := 0 
   WHILE( .T. ) 
 
      cArquivo:= Arquivos( "*.*", gDir+"\RETORNO\" ) 
 
      SetCursor( 0 ) 
 
      IF LastKey() == K_ESC 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Set( _SET_DELIMITERS, lDelimiters ) 
         Return Nil 
      ENDIF 
 
      IF cArquivo==Nil 
         cVpcCtrlb:= ScreenSave( 0, 0, 24, 79 ) 
         Aviso( "Unidade sem arquivo ou arquivo invalido p/ retorno!" ) 
         Mensagem( " Pressione [ENTER] para continuar..." ) 
         Pausa() 
         ScreenRest( cTela ) 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         Return Nil 
      ELSE 
         nLayOut:= EscolheLayOut( .T. ) 
         IF nLayOut <> Nil 
            DO CASE 
               CASE nLayOut==1 
                    nCodBanco := 141 
               CASE nLayOut==2 
                    nCodBanco := 41 
               CASE nLayOut==3 
                    nCodBanco := 275 
               OTHERWISE 
            ENDCASE 
            EXIT 
         ENDIF 
      ENDIF 
   ENDDO 
   if nCodBanco = 0 
      retu NIL 
   endif 
   Aviso("Aguarde Buscando Informacoes...") 
   cRelBanco:= "RET"+strzero(nCodBAnco,3)+".REP" 
   Relatorio( cRelBanco ) 
   CLI->(Dbsetorder( 1 )) 
   aSTRUT:={{"RETORN" ,"C",526,00},; // Linha do aruivo 
            {"DOCUM_" ,"C",10,00},; // Identif. Cliente na Empresa 
            {"CLIENT" ,"C",15,00},; // CLIENTE 
            {"VALDEB" ,"N",12,02},; // Valor do Debito 
            {"SITRET" ,"C",02,00},; // Codigo de Retorno 
            {"DESRET" ,"C",45,00},; // DEscri do retorno 
            {"VALPGO" ,"N",12,02},; // Valor pago 
            {"JUROS_" ,"N",12,02},; // Juros 
            {"MULTA_" ,"N",12,02},; // Multa 
            {"DTVENC" ,"D",08,00},; // Data vencimento do debito 
            {"DTPGTO" ,"D",08,00},; // Data de Pagamento do debito 
            {"SELECT" ,"C",03,00}}  // Data de Pagamento do debito 
 
   dbcreate( "&GDir\CTRLTEMP.$$$", aSTRUT ) 
 
   DBSelectAr( 125 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/ctrltemp.$$$" alias "ctt"  
   #else 
     USE "&GDir\CTRLTEMP.$$$" ALIAS "CTT"  
   #endif
   APPEND FROM &cArquivo SDF 
   DBgoTop() 
   DBdelete() 
   DBgoBottom() 
   DBdelete() 
   DBgoTop() 
   WHILE .NOT. EOF() 
      cRegistro := RETORN 
      cDocumento := space( 10 ) 
      nValor := 0 
      cOcorrencia := space(02) 
      nJuros:= 0 
      nMulta:= 0 
      dDataPago:= ctod("") 
      For nI:= 1 to  Len( aPosicoes  ) 
          if aPosicoes[ nI ][ 1 ]=="DOCUMENTO" 
             cDocumento:= SubStr( cRegistro, aPosicoes[ nI ][ 2 ], aPosicoes[ nI ][ 3 ] ) 
          endif 
          if aPosicoes[ nI ][ 1 ]=="VALPAGO" 
             nValor:= Val( SubStr( cRegistro, aPosicoes[ nI ][ 2 ], aPosicoes[ nI ][ 3 ] ))/100 
          endif 
          if aPosicoes[ nI ][ 1 ]=="OCORRENCIA" 
             cOcorrencia:= SubStr( cRegistro, aPosicoes[ nI ][ 2 ], aPosicoes[ nI ][ 3 ] ) 
          endif 
          if aPosicoes[ nI ][ 1 ]=="JUROS" 
             nJuros:= Val( SubStr( cRegistro, aPosicoes[ nI ][ 2 ], aPosicoes[ nI ][ 3 ] ))/100 
          endif 
          if aPosicoes[ nI ][ 1 ]=="MULTA" 
             nMulta:= Val( SubStr( cRegistro, aPosicoes[ nI ][ 2 ], aPosicoes[ nI ][ 3 ] ))/100 
          endif 
          if aPosicoes[ nI ][ 1 ]=="DTPGTO" 
             cDataPago := SubStr( cRegistro, aPosicoes[ nI ][ 2 ], aPosicoes[ nI ][ 3 ] ) 
             dDataPago := ctod(subst(Cdatapago,1,2)+"/"+subst(Cdatapago,3,2)+"/"+subst(Cdatapago,5,2)) 
          endif 
      Next 
      if subst(cDocumento,10,1) == "m" 
         DPA->(Dbsetorder( 3 )) 
      else 
         DPA->(Dbsetorder( 1 )) 
      endif 
      DPA->(DBseek(val(subst(cDocumento,1,9)))) 
      CLI->(DBseek(DPA->CLIENT)) 
      if NetRLock() 
         repl DOCUM_ with cDocumento 
         repl CLIENT with subst(CLI->DESCRI,1,15) 
         repl VALDEB with DPA->VLR___ 
         repl SITRET with cOcorrencia 
         repl VALPGO with nValor 
         repl JUROS_ with nJuros 
         repl MULTA_ with nMulta 
         repl DTVENC with DPA->VENC__ 
         repl DTPGTO with dDataPago 
         repl SELECT with "Nao" 
         nAcao := ASCan( aOcorrencia, {|x| x[1]=cOcorrencia } ) 
         if nAcao > 0 
            repl DESRET with aOcorrencia[nAcao][2] 
            IF aOcorrencia[nAcao][3]=="BAIXAR" 
               repl SELECT with "Sim" 
            ENDIF 
         endif 
         DBunlock() 
      endif 
      DBSkip() 
   ENDDO 
 
   VpBox( 00, 00, 22, 79,"Arquivo de Retorno" ) 
   oTb:=TBrowseDB( 01, 01, 21, 78 ) 
 
   oTb:AddColumn( tbcolumnnew( "Sel Documento  Cliente         vl.Pago  Dt.Pago  Retorno",; 
                      {|| SELECT+ " "+DOCUM_+" "+CLIENT+" "+transf(VALPGO,"@e 99999.99")+" "+ ; 
                          dtoc(DTPGTO)+" "+subst(DESRET,1,25) })) 
   *   SIM 123456789. 123456789.12345 12378.99 12/12/12 123456789.12345679.12345 
   oTb:HeadSep:= "Ä" 
   oTb:AutoLite:=.f. 
   oTb:dehilite() 
 
   Mensagem( "[TAB]Impress„o [G]Importa‡„o [ESC]Sair" ) 
 
   CTT->( DBGoTop() ) 
 
   WHILE .T. 
 
      oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT  }, { 2, 1 } ) 
      WHILE !oTb:Stabilize(); ENDDO 
 
 
      nTecla:=inkey( 0 ) 
 
      DO CASE 
         CASE nTecla==K_ESC 
            EXIT 
         CASE CHR( nTecla ) $ "Gg" 
            GravaREtorno() 
            EXIT 
         CASE nTecla==K_UP                ; oTb:up() 
         CASE nTecla==K_LEFT              ; oTb:PanLeft() 
         CASE nTecla==K_RIGHT     ; oTb:PanRight() 
         CASE nTecla==K_DOWN              ; oTb:down() 
         CASE nTecla==K_PGUP              ; oTb:pageup() 
         CASE nTecla==K_PGDN              ; oTb:pagedown() 
         CASE nTecla==K_CTRL_PGUP ; oTb:gotop() 
         CASE nTecla==K_CTRL_PGDN ; oTb:gobottom() 
         CASE nTecla==K_TAB 
             IF Confirma( 00, 00,"Confirma a impress„o deste Retorno?",; 
                                 "Digite [S] para confirmar ou [N] p/ cancelar.", "N" ) 
                Relatorio( "CTRLRETO.REP" ) 
             ENDIF 
         OTHERWISE 
             Tone( 125 ); Tone( 300 ) 
      ENDCASE 
 
      oTb:RefreshCurrent() 
      oTb:Stabilize() 
   ENDDO 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
 
   CTT->( DBCloseArea() ) 
 
Return Nil 
 
Function Gravaretorno() 
Begin Sequence 
   nOpcao:= SWAlerta( "Confirma a Importacao do Arquivo", { "Sim", "Nao" } ) 
   IF nOpcao=2 
      break 
   ENDIF 
   CTB->( DBSetorder( 1 ) ) 
   DBSelectArea( "CTT" ) 
   DBGoTop() 
   WHILE .NOT. EOF() 
      if CTB->( DBSeek( CTT->DOCUM_ ) ) 
         IF CTB->( NetRlock() ) 
            replace CTB->SITUAC with CTT->DESRET 
            replace CTB->SELEC_ with "Nao" 
         ENDIF 
         CTB->( DBUnlock() ) 
      endif 
      IF subst(CTT->DOCUM_,10,10) == "m" 
         DPA->(DBsetorder( 3 )) 
      ELSE 
         DPA->(DBsetorder( 1 )) 
      ENDIF 
      nCodigo:= Val(subst(CTT->DOCUM_,1,9)) 
      cLetra := subst(CTT->DOCUM_,10,1) 
      IF DPA->( DBSeek( nCodigo ) ) 
         IF cLetra != "m" 
            WHILE .NOT. DPA->(EOF()) .AND. DPA->CODNF_ = nCodigo 
               if DPA->LETRA_ == cLetra 
                  exit 
               endif 
               DPA->( DbSkip() ) 
            ENDDO 
         ENDIF 
         IF DPA->( NetRlock() ) 
            repl DPA->SITUAC with CTT->DESRET 
            IF CTT->SELECT == "Sim" 
               if EMPTY( DPA->DTQT__ ) 
                  IF (CTT->JUROS_ + CTT->MULTA_) <> 0 
                     repl DPA->JUROS_ with (CTT->JUROS_ + CTT->MULTA_) 
                  ENDIF 
                  DPA->( BaixaReceber( Nil, .T., CTT->DTPGTO ) ) 
               ENDIF 
            ENDIF 
            DPA->( DBUnlock() ) 
         ENDIF 
      ENDIF 
      DBSkip() 
   ENDDO 
End Sequence 
retu .T. 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ PesquisaReceber 
³ Finalidade  ³ Busca situacao de Contas a Receber cfe. Arquivos Remetidos/Retornos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function PesquisaReceber() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
 
  VPBox( 16, 45, 21, 78 ) 
  WHILE .T. 
      mensagem("") 
      AAdd( MENULIST,menunew(17,46," 1 Registros (Geral)           ", 2, COR[11],; 
           "Verificacao Sintetica de Contas a Receber.",,, COR[6],.T.)) 
      AAdd( MENULIST,menuNew(18,46," 2 Registros por Cliente       ", 2, COR[11],; 
           "Consulta Por Cliente.",,,COR[6],.T.)) 
      AAdd( MENULIST,menunew(19,46," 3 Registros por Retorno       ", 2, COR[11],; 
           "Verificacao Sintetica de Contas a Receber.",,, COR[6],.T.)) 
      AAdd( MENULIST,menunew(20,46," 0 Retorna                     ", 2, COR[11],; 
           "Retorna ao menu anterior.",,,COR[6],.T.)) 
      menumodal(MENULIST,@nOPCAO); MENULIST:={} 
      do case 
         case nOPCAO=0 .or. nOPCAO=4; exit 
         case nOPCAO=1 
              Receber() 
         case nOPCAO=2 
              RegCliente() 
         case nOPCAO=3 
              ReceberRetorno() 
      endcase 
  enddo 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ RECEBER 
³ Finalidade  ³ Consulta de Contas a Receber 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 15/09/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function Receber() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A RECEBER POR LOCALIZACAO", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= CTOD( "01/01/90" ) 
  dDataFim:= DATE() + 365 
  nLocal_:=  41 
  nOpcao:= 2 
  @ 02,02 Say "Selecionar do dia:" Get dDataIni 
  @ 03,02 Say "        ate o dia:" Get dDataFim 
  @ 04,02 Say "Localizadas Em...:" Get nLocal_ Pict "999" 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  @ 08,02 Prompt " 1 Duplicatas Quitadas       " 
  @ 09,02 Prompt " 2 Duplicatas Pendentes      " 
  @ 10,02 Prompt " 3 Todas                     " 
  MENU TO nOpcao 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
  DBSelectAr( _COD_CTRLBANC ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To 
 
  IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim .AND. SITRET=="00" 
  ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim .AND. SITRET=="  " 
  ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim 
  ENDIF 
  DBGoTop() 
  WHILE !EOF() 
      IF !SITRET=="00" .AND. !SITRET=="NV" .AND. !SITRET=="NA" 
         IF DATE() - DATVEN >= 120 
            nRec120:= nRec120 + VALDEB 
         ELSEIF DATE() - DATVEN >= 60 
            nRec60:= nRec60 + VALDEB 
         ELSEIF DATE() - DATVEN >= 30 
            nRec30:= nRec30 + VALDEB 
         ELSEIF DATE() - DATVEN >= 10 
            nRec10:= nRec10 + VALDEB 
         ELSEIF DATE() - DATVEN > 5 
            nRec5:= nRec5 + VALDEB 
         ELSEIF DATE() < DATVEN 
            nRec0:= nRec0 + VALDEB 
         ELSEIF DATE() == DATVEN 
            nRecHoje:= nRecHoje + VALDEB 
         ELSEIF DATE() - DATVEN <= 5 
            nRec4:= nRec4 + VALDEB 
         ENDIF 
         nRecPendente:= nRecPendente + VALDEB 
      ENDIF 
      IF !LEFT( SITRET, 1 )=="N" 
         nRecTotal:= nRecTotal + VALDEB 
      ENDIF 
      DBSkip() 
  ENDDO 
  DBGoTop() 
  DispBegin() 
  VPBox( 00, 00, 13, 79, "RECEBER", _COR_GET_BOX ) 
  VPBox( 14, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
  Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  SetColor( "00/02" ) 
  @ 02,02 Say "                                   CONTAS A RECEBER" 
  SetColor( _COR_GET_BOX ) 
  @ 03,02 Say "Pendente a menos de  5 dias                                                 " 
  @ 04,02 Say "Pendente a mais de   5 dias                                                 " 
  @ 05,02 Say "Pendente a mais de  10 dias                                                 " 
  @ 06,02 Say "Pendente a mais de  30 dias                                                 " 
  @ 07,02 Say "Pendente a mais de  60 dias                                                 " 
  @ 08,02 Say "Pendente a mais de 120 dias                                                 " 
  @ 09,02 Say "A vencer                                                                    " 
  @ 10,02 Say "Com vencimento hoje                                                         " 
  @ 11,02 Say "Total relacionado no display                                                " 
  @ 12,02 Say "Total pendente                                                              " 
  @ 03,32 Say Tran( nRec4,   "@E 999,999,999.99" ) + " " + Str( ( nRec4 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 04,32 Say Tran( nRec5,   "@E 999,999,999.99" ) + " " + Str( ( nRec5 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 05,32 Say Tran( nRec10,  "@E 999,999,999.99" ) + " " + Str( ( nRec10 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 06,32 Say Tran( nRec30,  "@E 999,999,999.99" ) + " " + Str( ( nRec30 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 07,32 Say Tran( nRec60,  "@E 999,999,999.99" ) + " " + Str( ( nRec60 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 08,32 Say Tran( nRec120, "@E 999,999,999.99" ) + " " + Str( ( nRec120 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 09,32 Say Tran( nRec0,   "@E 999,999,999.99" ) + " " + Str( ( nRec0 / nRecPendente ) * 100, 6, 2 ) + "%" 
  SetColor( "15/04" ) 
  @ 10,32 Say Tran( nRecHoje,"@E 999,999,999.99" ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 11,32 Say Tran( nRecTotal,"@E 999,999,999.99" ) 
  @ 12,32 Say Tran( nRecPendente,"@E 999,999,999.99" ) + " " + Str( ( nRecPendente / nRecPendente ) * 100, 6, 2 ) + "%" 
 
  DBGoTop() 
  SetColor( _COR_BROWSE ) 
  oTab1:=tbrowsedb(15,01,21,78) 
  oTab1:addcolumn(tbcolumnnew("Identificacao ",{|| IDECLI })) 
  oTab1:addcolumn(tbcolumnnew("Valor",{|| Tran( VALDEB, "@E 9,999,999.99" ) })) 
  oTab1:addcolumn(tbcolumnnew("Vencimen",{|| DATVEN })) 
  oTab1:addcolumn(tbcolumnnew("ST",{|| SITRET })) 
  oTab1:addcolumn(tbcolumnnew("Status",{|| PAD( StatusRetorno( SITRET ), 25 ) })) 
  oTab1:AUTOLITE:=.f. 
  oTab1:dehilite() 
  DispEnd() 
  whil .t. 
     oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
     whil nextkey()=0 .and.! oTab1:stabilize() 
     enddo 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTab1:up() 
        case nTecla==K_LEFT       ;oTab1:PanLeft() 
        case nTecla==K_RIGHT      ;oTab1:PanRight() 
        case nTecla==K_DOWN       ;oTab1:down() 
        case nTecla==K_PGUP       ;oTab1:pageup() 
        case nTecla==K_PGDN       ;oTab1:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
        case DBPesquisa( ntecla, oTab1 ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab1:refreshcurrent() 
     oTab1:stabilize() 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;   
               "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;   
               "&gdir/ctbind05.ntx" 
#else
  Set Index To "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX", ;   
               "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", ;   
               "&GDir\CTBIND05.NTX" 

#endif
Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ RECEBERRETORNO 
³ Finalidade  ³ Consulta de Contas a Receber Por Retorno 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 15/09/1999 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function ReceberRetorno() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A RECEBER POR RETORNO", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= CTOD( "01/01/90" ) 
  dDataFim:= DATE() + 365 
  nLocal_:=  41 
  nOpcao:= 2 
  @ 02,02 Say "Selecionar do dia:" Get dDataIni 
  @ 03,02 Say "        ate o dia:" Get dDataFim 
  @ 04,02 Say "Localizadas Em...:" Get nLocal_ Pict "999" 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     dbSelectAr( _COD_CTRLBANC ) 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;   
                    "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;   
                    "&gdir/ctbind05.ntx" 
     #else
       Set Index To "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX", ;   
                    "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", ;   
                    "&GDir\CTBIND05.NTX" 

     #endif
     Return Nil 
  ENDIF 
  Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
  DBSelectAr( _COD_CTRLBANC ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim .AND. !( SITRET=="00" ) .AND. !SITRET=="  " 
  DBGoTop() 
  WHILE !EOF() 
      IF !SITRET=="00" .AND. !SITRET=="NV" .AND. !SITRET=="NA" 
         IF DATE() - DATVEN >= 120 
            nRec120:= nRec120 + VALDEB 
         ELSEIF DATE() - DATVEN >= 60 
            nRec60:= nRec60 + VALDEB 
         ELSEIF DATE() - DATVEN >= 30 
            nRec30:= nRec30 + VALDEB 
         ELSEIF DATE() - DATVEN >= 10 
            nRec10:= nRec10 + VALDEB 
         ELSEIF DATE() - DATVEN > 5 
            nRec5:= nRec5 + VALDEB 
         ELSEIF DATE() < DATVEN 
            nRec0:= nRec0 + VALDEB 
         ELSEIF DATE() == DATVEN 
            nRecHoje:= nRecHoje + VALDEB 
         ELSEIF DATE() - DATVEN <= 5 
            nRec4:= nRec4 + VALDEB 
         ENDIF 
         nRecPendente:= nRecPendente + VALDEB 
      ENDIF 
      IF !LEFT( SITRET, 1 )=="N" 
         nRecTotal:= nRecTotal + VALDEB 
      ENDIF 
      DBSkip() 
  ENDDO 
  DBGoTop() 
  DispBegin() 
  VPBox( 00, 00, 13, 79, "RECEBER", _COR_GET_BOX ) 
  VPBox( 14, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
  Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  SetColor( "00/02" ) 
  @ 02,02 Say " Dados do Cliente                                       CONTAS A RECEBER   " 
  SetColor( _COR_GET_BOX ) 
  @ 03,41 Say "A menos de  5 dias                                                 " 
  @ 04,41 Say "A mais de   5 dias                                                 " 
  @ 05,41 Say "A mais de  10 dias                                                 " 
  @ 06,41 Say "A mais de  30 dias                                                 " 
  @ 07,41 Say "A mais de  60 dias                                                 " 
  @ 08,41 Say "A mais de 120 dias                                                 " 
  @ 09,41 Say "A vencer                                                                    " 
  @ 10,41 Say "Hoje                                                         " 
  @ 11,41 Say "Total no display                                                " 
  @ 12,41 Say "Total pendente                                                              " 
  @ 03,59 Say Tran( nRec4,   "@E 9999,999.99" ) + " " + Str( ( nRec4 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 04,59 Say Tran( nRec5,   "@E 9999,999.99" ) + " " + Str( ( nRec5 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 05,59 Say Tran( nRec10,  "@E 9999,999.99" ) + " " + Str( ( nRec10 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 06,59 Say Tran( nRec30,  "@E 9999,999.99" ) + " " + Str( ( nRec30 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 07,59 Say Tran( nRec60,  "@E 9999,999.99" ) + " " + Str( ( nRec60 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 08,59 Say Tran( nRec120, "@E 9999,999.99" ) + " " + Str( ( nRec120 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 09,59 Say Tran( nRec0,   "@E 9999,999.99" ) + " " + Str( ( nRec0 / nRecPendente ) * 100, 6, 2 ) + "%" 
  SetColor( "15/04" ) 
  @ 10,59 Say Tran( nRecHoje,"@E 9999,999.99" ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 11,59 Say Tran( nRecTotal,"@E 9999,999.99" ) 
  @ 12,59 Say Tran( nRecPendente,"@E 9999,999.99" ) + " " + Str( ( nRecPendente / nRecPendente ) * 100, 6, 2 ) + "%" 
 
  DBGoTop() 
  SetColor( _COR_BROWSE ) 
  oTab1:=tbrowsedb(15,01,21,78) 
  oTab1:addcolumn(tbcolumnnew("Identificacao ",{|| IDECLI })) 
  oTab1:addcolumn(tbcolumnnew("Valor",{|| Tran( VALDEB, "@E 9,999,999.99" ) })) 
  oTab1:addcolumn(tbcolumnnew("Vencimen",{|| DATVEN })) 
  oTab1:addcolumn(tbcolumnnew("ST",{|| SITRET })) 
  oTab1:addcolumn(tbcolumnnew("Status",{|| PAD( StatusRetorno( SITRET ), 25 ) })) 
  oTab1:AUTOLITE:=.f. 
  oTab1:dehilite() 
  DispEnd() 
  whil .t. 
     oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
     whil nextkey()=0 .and.! oTab1:stabilize() 
     enddo 
     SetColor( _COR_GET_EDICAO ) 
     DispBegin() 
     DPA->( DBSetOrder( 3 ) ) 
     CLI->( DBSetOrder( 1 ) ) 
     IF DPA->( DBSeek( VAL( Left( CTB->IDECLI, 10 ) ) ) ) 
        CLI->( DBSeek( DPA->CLIENT ) ) 
     ELSE 
        CLI->( DBGoBottom() ) 
        CLI->( DBSkip( +1 ) ) 
     ENDIF 
     @ 03,02 Say "Codigo..: [" + StrZero( CLI->CODIGO, 6, 0 ) + "]" 
     @ 04,02 Say "" + Left( CLI->DESCRI, 37 ) Color "14/" + CorFundoAtual() 
     @ 05,02 Say "Fone....: [" + CLI->FONE1_ + "]" 
     @ 06,02 Say "Conta...: [" + StrZero( CLI->CONTAC, 9, 0 ) + "-" + CLI->DIGVER + "]" 
     @ 07,02 Say "Agencia.: [" + CLI->AGENCI + "]" 
     @ 08,02 Say LEFT( CLI->OBSER1, 30 ) 
     @ 09,02 Say LEFT( CLI->OBSER2, 30 ) 
     @ 10,02 Say LEFT( CLI->OBSER3, 30 ) 
     @ 11,02 Say LEFT( CLI->OBSER4, 30 ) 
     DispEnd() 
     SetColor( _COR_BROWSE ) 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTab1:up() 
        case nTecla==K_LEFT       ;oTab1:PanLeft() 
        case nTecla==K_RIGHT      ;oTab1:PanRight() 
        case nTecla==K_DOWN       ;oTab1:down() 
        case nTecla==K_PGUP       ;oTab1:pageup() 
        case nTecla==K_PGDN       ;oTab1:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
        case DBPesquisa( ntecla, oTab1 ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab1:refreshcurrent() 
     oTab1:stabilize() 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;   
                     "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;   
                     "&gdir/ctbind05.ntx" 
#else
  Set Index To "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX", ;   
                     "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", ;   
                     "&GDir\CTBIND05.NTX" 

#endif
Return Nil 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ REGCLIENTE 
³ Finalidade  ³ Consulta de Contas a Receber x Cliente 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 15/09/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function RegCliente( nTipo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select() 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A RECEBER POR LOCALIZACAO - REMETIDOS", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= CTOD( "01/01/90" ) 
  dDataFim:= DATE() + 365 
  nLocal_:=  41 
  nOpcao:= 3 
  IF nTipo==Nil 
     @ 02,02 Say "Selecionar do dia:" Get dDataIni 
     @ 03,02 Say "        ate o dia:" Get dDataFim 
     @ 04,02 Say "Localizadas Em...:" Get nLocal_ Pict "999" 
     READ 
     IF LastKey() == K_ESC 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        DBSelectAr( nArea ) 
        Return Nil 
     ENDIF 
     @ 08,02 Prompt " 1 Duplicatas Quitadas       " 
     @ 09,02 Prompt " 2 Duplicatas Pendentes      " 
     @ 10,02 Prompt " 3 Todas                     " 
     MENU TO nOpcao 
     IF LastKey() == K_ESC 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        DBSelectAr( nArea ) 
        Return Nil 
     ENDIF 
  ENDIF 
 
  WHILE .T. 
     nPag120:= 0 
     nPag60:= 0 
     nPag30:= 0 
     nPag10:= 0 
     nPag5:= 0 
     nPag0:= 0 
     nPag4:= 0 
     nPagHoje:= 0 
     nPagTotal:= 0 
     nPagPendente:= 0 
     nRec120:= 0 
     nRec60:= 0 
     nRec30:= 0 
     nRec10:= 0 
     nRec5:= 0 
     nRec0:= 0 
     nRec4:= 0 
     nRecHoje:= 0 
     nRecTotal:= 0 
     nRecPendente:= 0 
     nCodCli:= -9999 
     PesqCli( @nCodCli ) 
 
     IF LastKey() == K_ESC 
        dbSelectAr( _COD_CTRLBANC ) 

        // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
        #ifdef LINUX
          set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;   
                       "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;   
                       "&gdir/ctbind05.ntx" 
        #else
          Set Index To "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX", ;   
                       "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", ;   
                       "&GDir\CTBIND05.NTX" 

        #endif
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        DBSelectAr( nArea ) 
        Return Nil 
     ENDIF 
 
     Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
     DBSelectAr( _COD_CTRLBANC ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To 
 
     IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim .AND. SITRET=="00" .AND. CODCLI==nCodCli 
     ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim .AND. SITRET=="  " .AND. CODCLI==nCodCli 
     ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On DATVEN Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DATVEN >= dDataIni .AND. DATVEN <= dDataFim .AND. CODCLI==nCodCli 
     ENDIF 
     DBGoTop() 
     WHILE !EOF() 
         IF !SITRET=="00" .AND. !SITRET=="NV" .AND. !SITRET=="NA" 
            IF DATE() - DATVEN >= 120 
               nRec120:= nRec120 + VALDEB 
            ELSEIF DATE() - DATVEN >= 60 
               nRec60:= nRec60 + VALDEB 
            ELSEIF DATE() - DATVEN >= 30 
               nRec30:= nRec30 + VALDEB 
            ELSEIF DATE() - DATVEN >= 10 
               nRec10:= nRec10 + VALDEB 
            ELSEIF DATE() - DATVEN > 5 
               nRec5:= nRec5 + VALDEB 
            ELSEIF DATE() < DATVEN 
               nRec0:= nRec0 + VALDEB 
            ELSEIF DATE() == DATVEN 
               nRecHoje:= nRecHoje + VALDEB 
            ELSEIF DATE() - DATVEN <= 5 
               nRec4:= nRec4 + VALDEB 
            ENDIF 
            nRecPendente:= nRecPendente + VALDEB 
         ENDIF 
         IF !LEFT( SITRET, 1 )=="N" 
            nRecTotal:= nRecTotal + VALDEB 
         ENDIF 
         DBSkip() 
     ENDDO 
     DBGoTop() 
     DispBegin() 
     VPBox( 00, 00, 13, 79, "RECEBER", _COR_GET_BOX ) 
     VPBox( 14, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
     Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
     Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
     SetColor( "00/02" ) 
     @ 02,02 Say "                             RELACAO DE LANCAMENTOS " 
     SetColor( _COR_GET_BOX ) 
     @ 03,02 Say "Pendente a menos de  5 dias                                                 " 
     @ 04,02 Say "Pendente a mais de   5 dias                                                 " 
     @ 05,02 Say "Pendente a mais de  10 dias                                                 " 
     @ 06,02 Say "Pendente a mais de  30 dias                                                 " 
     @ 07,02 Say "Pendente a mais de  60 dias                                                 " 
     @ 08,02 Say "Pendente a mais de 120 dias                                                 " 
     @ 09,02 Say "A vencer                                                                    " 
     @ 10,02 Say "Com vencimento hoje                                                         " 
     @ 11,02 Say "Total relacionado no display                                                " 
     @ 12,02 Say "Total pendente                                                              " 
     @ 03,32 Say Tran( nRec4,   "@E 999,999,999.99" ) + " " + Str( ( nRec4 / nRecPendente ) * 100, 6, 2 ) + "%" 
     @ 04,32 Say Tran( nRec5,   "@E 999,999,999.99" ) + " " + Str( ( nRec5 / nRecPendente ) * 100, 6, 2 ) + "%" 
     @ 05,32 Say Tran( nRec10,  "@E 999,999,999.99" ) + " " + Str( ( nRec10 / nRecPendente ) * 100, 6, 2 ) + "%" 
     @ 06,32 Say Tran( nRec30,  "@E 999,999,999.99" ) + " " + Str( ( nRec30 / nRecPendente ) * 100, 6, 2 ) + "%" 
     @ 07,32 Say Tran( nRec60,  "@E 999,999,999.99" ) + " " + Str( ( nRec60 / nRecPendente ) * 100, 6, 2 ) + "%" 
     @ 08,32 Say Tran( nRec120, "@E 999,999,999.99" ) + " " + Str( ( nRec120 / nRecPendente ) * 100, 6, 2 ) + "%" 
     @ 09,32 Say Tran( nRec0,   "@E 999,999,999.99" ) + " " + Str( ( nRec0 / nRecPendente ) * 100, 6, 2 ) + "%" 
     SetColor( "15/04" ) 
     @ 10,32 Say Tran( nRecHoje,    "@E 999,999,999.99" ) 
     SetColor( _COR_GET_EDICAO ) 
     @ 11,32 Say Tran( nRecTotal,   "@E 999,999,999.99" ) 
     @ 12,32 Say Tran( nRecPendente,"@E 999,999,999.99" ) + " " + Str( ( nRecPendente / nRecPendente ) * 100, 6, 2 ) + "%" 
 
     DBGoTop() 
     SetColor( _COR_BROWSE ) 
     oTab1:=tbrowsedb(15,01,21,78) 
     oTab1:addcolumn(tbcolumnnew("Identificacao ",{|| IDECLI })) 
     oTab1:addcolumn(tbcolumnnew("Valor",{|| Tran( VALDEB, "@E 9,999,999.99" ) })) 
     oTab1:addcolumn(tbcolumnnew("Vencimen",{|| DATVEN })) 
     oTab1:addcolumn(tbcolumnnew("ST",{|| SITRET })) 
     oTab1:addcolumn(tbcolumnnew("Status",{|| PAD( StatusRetorno( SITRET ), 25 ) })) 
     oTab1:AUTOLITE:=.f. 
     oTab1:dehilite() 
     DispEnd() 
     WHILE .T. 
        oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
        whil nextkey()=0 .and.! oTab1:stabilize() 
        enddo 
        nTecla:=inkey(0) 
        IF nTecla=K_ESC 
           exit 
        ENDIF 
        do case 
           case nTecla==K_UP         ;oTab1:up() 
           case nTecla==K_LEFT       ;oTab1:PanLeft() 
           case nTecla==K_RIGHT      ;oTab1:PanRight() 
           case nTecla==K_DOWN       ;oTab1:down() 
           case nTecla==K_PGUP       ;oTab1:pageup() 
           case nTecla==K_PGDN       ;oTab1:pagedown() 
           case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
           case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
           case DBPesquisa( ntecla, oTab1 ) 
           otherwise                ;tone(125); tone(300) 
        endcase 
        oTab1:refreshcurrent() 
        oTab1:stabilize() 
     ENDDO 
 ENDDO 

 // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
 #ifdef LINUX
   set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;   
                     "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;   
                     "&gdir/ctbind05.ntx" 
 #else
   Set Index To "&GDir\CTBIND01.NTX", "&GDir\CTBIND02.NTX", ;   
                     "&GDir\CTBIND03.NTX", "&GDir\CTBIND04.NTX", ;   
                     "&GDir\CTBIND05.NTX" 

 #endif
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 ScreenRest( cTela ) 
 DBSelectAr( nArea ) 
 Return Nil 
 
Function StatusRetorno( cCodigo ) 
Local nPos:= 0, cStatus:= Space( 20 ) 
Local aOcorrencia:= {{ "00", "DEBITO EFETUADO   ", "DEBITO EFETUADO                              " },; 
                     { "01", "SEM FUNDOS        ", "INSUFICIENCIA DE FUNDOS                      " },; 
                     { "02", "CONTA INEXISTENTE ", "CONTA CORRENTE NAO CADASTRADA                " },; 
                     { "04", "OUTRAS RESTRICOES ", "OUTRAS RESTRICOES                            " },; 
                     { "10", "AGENCIA ENCERRANDO", "AGENCIA EM REGIME DE ENCERRAMENTO            " },; 
                     { "12", "VALOR INVALIDO    ", "VALOR INVALIDO                               " },; 
                     { "13", "DATA LANC INVALIDA", "DATA DE LANCAMENTO INVALIDA                  " },; 
                     { "14", "AGENCIA INVALIDA  ", "AGENCIA INVALIDA                             " },; 
                     { "15", "DAC CONTA VALIDO  ", "DAC DA CONTA CORRENTE VALIDO                 " },; 
                     { "18", "DATA DEB INVALIDA ", "DATA DO DEBITO ANTERIOR A DO PROCESSAMENTO   " },; 
                     { "30", "SEM CONTRATO      ", "SEM CONTRATO DE DEBITO AUTOMATICO            " },; 
                     { "96", "ALTERACAO CADASTRO", "MANUTENCAO DO CADASTRO                       " },; 
                     { "97", "CANC INEXISTENTE  ", "CANCELAMENTO - NAO ENCONTRADO                " },; 
                     { "98", "CANC FORA DO TEMPO", "CANCELAMENTO - FORA DE TEMPO HABIL           " },; 
                     { "99", "CANCELADO         ", "CANCELAMENTO - CANCELADO CONFORME SOLICITACAO" },; 
                     { "NV", "SEM FUNDO         ", "SEM FUNDO - SUBSTITUIDA                      " },; 
                     { "NA", "AGENCIA INVALIDA  ", "AGENCIA INVALIDA - SUBSTITUIDA               " }} 
IF ( nPos:= ASCAN( aOcorrencia, {|x| x[ 1 ]==cCodigo } ) ) > 0 
   cStatus:= aOcorrencia[ nPos ][ 3 ] 
ENDIF 
Return cStatus 
 
 
Function BloquearNaSelecao() 
Loca cTela:= ScreenSave( 0, 0, 24, 79 ),; 
     cCor:= SetColor(), nCursor:= SetCursor() 
Local dDataVen1, dDataVen2, nConta1, nConta2,; 
     nCodigo1, nCodigo2, aContas:= { { 0, Space( 10 ) } } 
 
     VPBox( 00, 00, 22, 79, "BLOQUEAR NA SELECAO", _COR_GET_BOX ) 
     VPBox( 13, 01, 21, 78, "BLOQUEAR AS CONTAS", _COR_GET_BOX, .F., .F. ) 
 
     IF File( GDir-"\BLOQUEIO.DBF" ) 
        BuscaBloqueios( @dDataVen1, @dDataVen2, @nConta1, @nConta2,; 
                        @nCodigo1, @nCodigo2, @aContas ) 
     ELSE 
        dDataVen1:= CTOD( "  /  /  " ) 
        dDataVen2:= CTOD( "  /  /  " ) 
        nConta1:=  0 
        nConta2:=  0 
        nCodigo1:= 0 
        nCodigo2:= 0 
     ENDIF 
     Mensagem( "Digite as Formas de Bloqueio p/ selecao que desejar...." ) 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,02 Say "Aviso!" 
     @ 03,02 Say "As duplicatas em  contas  a  receber  que  satisfizerem  as condicoes abaixo" Color "07/" + CorFundoAtual() 
     @ 04,02 Say "relacionadas nÆo serÆo  selecionadas,  sendo  que  voce dever  ter  o m ximo" Color "07/" + CorFundoAtual() 
     @ 05,02 Say "de atencao e conviccao das que deseja realmente bloquear."                    Color "07/" + CorFundoAtual() 
     @ 06,02 Say "O Filtro abaixo ‚ por tempo indeterminado, enquanto existir,  o Fortuna fara" Color "07/" + CorFundoAtual() 
     @ 07,02 Say "utilizacao no momento da Selecao.                                 "           Color "07/" + CorFundoAtual() 
     @ 08,01 Say Repl( "º", 78 ) Color "00/" + CorFundoAtual() 
     @ 09,02 Say "Da Conta............:" Get nConta1 Pict "999" 
     @ 09,42 Say "Ate:" Get nConta2 Pict "999" 
     @ 10,02 Say "Com Vencimento Entre:" Get dDataVen1 
     @ 10,42 Say "e..:" Get dDataVen2 
     @ 11,02 Say "Do Codigo/N.Fiscal..:" Get nCodigo1 Pict "999999999" 
     @ 11,42 Say "Ate:" Get nCodigo2 Pict "999999999" 
     READ 
 
     oTb:= TBrowseNew( 14, 02, 20, 77 ) 
 
     IF !LastKey()==K_ESC 
        GravaBloqueios( dDataVen1, dDataVen2, nConta1, nConta2,; 
                        nCodigo1, nCodigo2, @aContas ) 
     ENDIF 
 
     ScreenRest( cTela ) 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     Return Nil 
 
 
 
Function BuscaBloqueios( dDataVen1, dDataVen2, nConta1, nConta2,; 
                         nCodigo1, nCodigo2, aContas ) 
Local aCampos, nCt 
   aCampos:= IOFillText( MEMOREAD( Gdir-"\BLOQUEIO.DBF" ) ) 
   FOR nCt:= 1 TO Len( aCampos ) 
       DO CASE 
          CASE Left( aCampos[ nCt ], 10 )=="VENCIMENTO" 
               dDataVen1:= CTOD( SubStr( aCampos[ nCt ], 11, 8 ) ) 
               dDataVen2:= CTOD( SubStr( aCampos[ nCt ], 19, 8 ) ) 
          CASE Left( aCampos[ nCt ], 10 )=="CONTA     " 
               nConta1:= VAL( SubStr( aCampos[ nCt ], 11, 3 ) ) 
               nConta2:= VAL( SubStr( aCampos[ nCt ], 15, 3 ) ) 
          CASE Left( aCampos[ nCt ], 10 )=="CODIGO    " 
               nCodigo1:= VAL( SubStr( aCampos[ nCt ], 11, 9 ) ) 
               nCodigo2:= VAL( SubStr( aCampos[ nCt ], 21, 9 ) ) 
          CASE Left( aCampos[ nCt ], 10 )=="CCORRENTE " 
               AAdd( aContas, { VAL( SubStr( aCampos[ nCt ], 11, 04 ) ), SubStr( aCampos[ nCt ], 15, 10 ) } ) 
       ENDCASE 
   NEXT 
 
 
 
Function GravaBloqueios( dDataVenc1, dDataVenc2, nConta1, nConta2,; 
                         nCodigo1, nCodigo2, aContas ) 
Local aCampos, nCt 
 
   Set( 24, Gdir-"\BLOQUEIO.DBF" ) 
   Set( 20, "PRINT" ) 
 
   /* Setor de Gravacao de Informacoes */ 
   @ PROW(),PCOL() Say "VENCIMENTO"+DTOC( dDataVenc1 )+DTOC( dDataVenc2 ) + Chr( 13 ) + Chr( 10 ) 
   @ PROW(),PCOL() Say "CONTA     "+StrZero( nConta1, 3, 0 )+StrZero( nConta2, 3, 0 ) + Chr( 13 ) + Chr( 10 ) 
   @ PROW(),PCOL() Say "CODIGO    "+StrZero( nCodigo1, 9, 0 )+StrZero( nCodigo2, 9, 0 ) + Chr( 13 ) + Chr( 10 ) 
   FOR nCt:= 1 TO Len( aContas ) 
       @ PROW(),PCOL() Say "CCORRENTE " + StrZero( aContas[ nCt ][ 1 ], 04, 00 ) + aContas[ nCt ][ 2 ] + Chr( 13 ) + Chr( 10 ) 
   NEXT 
   Set( 20, "SCREEN" ) 
   Set( 24, "LPT1" ) 
 
 
Static Function Instrucao( cCodigo, nBanco ) 
   Scroll( 04, 38, 21, 78 ) 
   DO CASE 
      CASE cCodigo=="2" 
         IF nBanco == Nil 
            VPBox( 05, 41, 10, 78, "Tipo de Documento", _COR_GET_EDICAO, .F., .F. ) 
            @ 06,42 Say "04 - Cobranca Direta     " 
            @ 07,42 Say "06 - Cobranca Escritural " 
            @ 08,42 Say "08 - CCB                 " 
            @ 09,42 Say "09 - Titulos/Terceiros   " 
         ELSE 
            IF nBanco == 479 
            ENDIF 
         ENDIF 
      CASE cCodigo=="1" 
         IF nBanco==Nil 
            VPBox( 05, 41, 16, 78, "Tipo de Carteira", _COR_GET_EDICAO, .F., .F. ) 
            @ 06,42 Say "805076 - Cob.Simples     " 
            @ 07,42 Say "815055 - Cob.Caucionada  " 
            @ 08,42 Say "845094 - Cob.em IGPM     " 
            @ 09,42 Say "835501 - Cob.CGB Especial" 
            @ 10,42 Say "825786 - Cob.em UFIR     " 
            @ 11,42 Say "835684 - Cob.em IDTR     " 
            @ 12,42 Say "805726 - Cob.em CUB      " 
            @ 13,42 Say "825468 - Cob.em Dollar   " 
         ELSE 
            IF nBanco == 479 
            ENDIF 
         ENDIF 
      CASE cCodigo=="3" 
         VPBox( 05, 41, 21, 78, "Codigo Ocorrencia", _COR_GET_EDICAO, .F., .F. ) 
         IF nBanco==Nil 
            @ 06,42 Say "01 - REMESSA                     " 
            @ 07,42 Say "02 - PEDIDO DE BAIXA             " 
            @ 08,42 Say "04 - PEDIDO DE ABATIMENTO        " 
            @ 20,42 Say "21 - ALT.CEP SACADO              " 
         ELSE 
            IF nBanco == 479 
               @ 06,42 Say "01 - REMESSA                     " 
               @ 07,42 Say "02 - PEDIDO DE BAIXA             " 
               @ 08,42 Say "04 - PEDIDO DE ABATIMENTO        " 
               @ 20,42 Say "21 - ALT.CEP SACADO              " 
            ENDIF 
         ENDIF 
      CASE cCodigo=="4" 
         VPBox( 05, 41, 15, 78, "Codigo de Instrucao", _COR_GET_EDICAO, .F., .F. ) 
         @ 06,42 Say "01 - Nao disp.comissao de Permanenc" 
         @ 07,42 Say "08 - Nao Cobrar Comissao           " 
         @ 08,42 Say "09 - Protestar Caso Impago NN dias " 
         @ 09,42 Say "15 - Devolver Caso Impago NN dias  " 
         @ 10,42 Say "18 - Apos NN dias cob. XX,XX% multa" 
         @ 11,42 Say "20 - Apos NN dias cob. XX,XX% multa" 
         @ 12,42 Say "     ao mes ou fracao              " 
         @ 13,42 Say "22 - Apos V.UFIR+JUROS+1% a.m.2%Mul" 
         @ 14,42 Say "23 - Nao Protestar                 " 
      CASE cCodigo=="0" 
 
      CASE cCodigo=="5" 
         VPBox( 05, 41, 11, 78, "MULTA", _COR_GET_EDICAO, .F., .F. ) 
         @ 06,42 Say "  Digite o numero de dias caso haja" 
         @ 07,42 Say "a instrucao 18 ou 20,  que  indicam" 
         @ 08,42 Say "se havera ou nao incidencia de mul-" 
         @ 09,42 Say "ta em caso de atraso.              " 
      CASE cCodigo=="6" 
         VPBox( 05, 41, 11, 78, "PROTESTO", _COR_GET_EDICAO, .F., .F. ) 
         @ 06,42 Say "  Digite o numero de dias p/protes-" 
         @ 07,42 Say "to caso use instrucao 09.          " 
      CASE cCodigo=="7" 
         VPBox( 05, 38, 10, 78, "ESPECIE DO TITULO", _COR_GET_EDICAO, .F., .F. ) 
         @ 06,39 Say "01 - Duplicata               " 
         @ 07,39 Say "02 - Nota Promissoria        " 
         @ 08,39 Say "03 - Nota de Seguro          " 
         @ 09,39 Say "04 - Cobr. Seriada           " 
         @ 09,39 Say "05 - Recibo                  " 
         @ 09,39 Say "06 - Banco Emitira'Bloquetes " 
         @ 09,39 Say "07 - Banco n~Emitira Bloqs   " 
         @ 09,39 Say "08 - Duplicata de Servico    " 
         @ 09,39 Say "09 - Outros                  " 
      CASE cCodigo=="8" 
         VPBox( 05, 41, 21, 78, "Codigo Ocorrencia", _COR_GET_EDICAO, .F., .F. ) 
         @ 06,42 Say "01 - ENTRADA                     " 
         @ 07,42 Say "02 - BAIXAR                      " 
         @ 08,42 Say "04 - CONCENTIMENTO DE ABATIMENTO " 
         @ 09,42 Say "05 - CANCELAMENTO DE ABATIMENTO  " 
         @ 10,42 Say "06 - ALTERACAO DE VENCIMENTO     " 
         @ 11,42 Say "07 - ALTERACAO DE USO EMP        " 
         @ 12,42 Say "08 - ALTERACAO DE SEU N§         " 
         @ 13,42 Say "09 - PROTESTAR AGORA             " 
         @ 14,42 Say "10 - SUSTAR PROTESTO             " 
         @ 15,42 Say "11 - NAO PROTESTAR               " 
         @ 16,42 Say "13 - CANCELAR MULTA              " 
         @ 17,42 Say "14 - ALTERAR MULTA               " 
         @ 18,42 Say "16 - SUSTAR PROTESTO BAIX.TITULO " 
         @ 19,42 Say "17 - CONCEDER DESCONTO           " 
         @ 20,42 Say "18 - CANCELAR PROTESTO AUTOMATICO" 
      CASE cCodigo=="9" 
         VPBox( 05, 41, 11, 78, "PROTESTO", _COR_GET_EDICAO, .F., .F. ) 
         @ 06,42 Say " Digite o numero de dias p/protesto" 
   ENDCASE 
   Return .T. 
 

 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function fArqRemet( cRemRet ) 
 
      Local cUltimo, dVencimUlt, nValorUlt 
 
		LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
				cTela:= ScreenSave( 0, 0, 24, 79 ) 
		Local GetList:={}, oTb, nRow:= 1, aFiles, cFile:= "", cArqRem 
		SetCursor (0) 
 
		SetColor( _COR_GET_EDICAO ) 
 
      IF cRemRet == "REM" .OR. cRemRet=="EXC" 
         cArqRem:= Left( "&GDIR\ENVIO\D??E????.*" + Space( 100 ), 64 ) 
      ELSE 
         cArqRem:= Left( "&GDIR\RETORNO\BJW?????.*" + Space( 100 ), 64 ) 
      ENDIF 
 
      //Scroll( 10, 06, 11, 73 ) 
      Set( _SET_DELIMITERS, .T. ) 
 
      SetCursor( 0 ) 
 
		IF LastKey() == K_ESC 
			SetColor( cCor ) 
			SetCursor( nCursor ) 
			ScreenRest( cTela ) 
			Return Nil 
		ENDIF 
 
      IF cRemRet == "REM" 
         VPBox( 04, 13, 21, 72, " CONSULTA ARQUIVOS REMETIDOS ", _COR_BROW_BOX ) 
      ELSEIF cRemRet == "EXC" 
         VPBox( 04, 13, 21, 72, " EXCLUSAO DE ARQUIVOS REMETIDOS ", _COR_BROW_BOX ) 
      ELSE 
         VPBox( 04, 13, 21, 72, " CONSULTA ARQUIVOS RETORNADOS ", _COR_BROW_BOX ) 
      ENDIF 
 
		aFiles:= directory( cArqRem ) 
 
		IF len(aFiles) > 0 
			For nCt:= 1 TO Len( aFiles ) 
            AAdd( aFiles[ nCt ], aFiles[ nCt ][ 1 ] ) 
            cFile:= GDIR + "\" + aFiles[ nCt ][ 1 ] 
            cCampo:= MEMOREAD( cFile ) 
            nTotal:= ( VAL( SubStr( RIGHT( cCampo, 150 ), 8, 17 ) ) / 100 ) 
            AAdd( aFiles[ nCt ], nTotal ) 
			Next 
 
			/* Ajuste de mensagens */ 
			Mensagem("[ENTER]Visualiza‡„o [ESC]Sair") 
			Ajuda("["+_SETAS+"][PgUp][PgDn]Move") 
 
			SetColor( _COR_BROWSE ) 
 
         ASort( aFiles,,, { |x,y| x[3] > y[3] } ) 
 
			/* Inicializacao do objeto browse */ 
         oTb:=TBrowseNew( 05, 14, 20, 71 ) 
			oTb:AddColumn( tbcolumnnew( ; 
            "Nome           Data     Hora    Caracteres      Em Valores " , ; 
				{|| aFiles[ nRow ][ 1 ] + " " + ; 
				Dtoc( aFiles[ nRow ][ 3 ] ) + " " + ; 
				aFiles[ nRow ][ 4 ] + " " + ; 
				Tran( aFiles[ nRow ][ 2 ], "@E 999,999,999" ) + ; 
            Tran( aFiles[ nRow ][ 7 ], "@E 99999,999,999.99" ) + SPACE( 20 ) } )) 
 
			/* Movimentacao no browse */ 
			oTb:HeadSep:= "Ä" 
			oTb:GoTopBlock:= {|| nRow:= 1 } 
			oTb:GoBottomBlock:= {|| nRow:= Len( aFiles ) } 
			oTb:SkipBlock:= {|x| SkipperArr( x, aFiles, @nRow ) } 
 
         /*ÄÄÄÄ Variaveis do objeto browse ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Informacoes Diversas ÄÄÄÄ*/ 
			oTb:AutoLite:=.F. 
			oTb:dehilite() 				 /* Nao	- Sim */ 
			oTb:ColorSpec:= SetColor() + ",10/02,14/09" 
 
			WHILE .T. 
 
				oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
 
				/* Stabilize */ 
				WHILE NextKey()=0 .AND. !oTb:Stabilize() 
				ENDDO 
 
				nTecla:= Inkey(0) 
 
				IF nTecla==K_ESC 
					EXIT 
				ENDIF 
 
				/* Teste da tecla pressionadas */ 
				DO CASE 
 
					CASE nTecla==K_UP 		  ; oTb:up() 
 
					CASE nTecla==K_LEFT		  ; oTb:PanLeft() 
 
					CASE nTecla==K_RIGHT 	  ; oTb:PanRight() 
 
					CASE nTecla==K_DOWN		  ; oTb:down() 
 
               CASE nTecla==K_PGUP       ; oTb:pageup() 
 
					CASE nTecla==K_PGDN		  ; oTb:pagedown() 
 
					CASE nTecla==K_CTRL_PGUP  ; oTb:gotop() 
 
					CASE nTecla==K_CTRL_PGDN  ; oTb:gobottom() 
 
               CASE nTecla==K_CTRL_TAB 
                    cTelaAnt:= ScreenSave(  0, 0, 24, 79 ) 
                    IF cRemRet=="EXC" 
                       IF SWAlerta( "Deseja remarcar os registros; caso nÆo estejam fazendo; parte da relacao de enviados", { "Confirma", "Cancela" } )==1 
                          aRegistros:= "" 
                          aRegistros:= {} 
                          cFile:= Gdir + "\" + aFiles[ nRow ][ 1 ] 
                          aRegistros:= IOFilltext( MEMOREAD( cFile ) ) 
                          DBSelectAr( _COD_CTRLBANC ) 
                          DPA->( DBSetOrder( 3 ) ) 
                          CTB->( DBSetOrder( 5 ) ) 
                          nQuantReg:= 0 
                          SetColor( _COR_GET_EDICAO ) 
                          VPBox( 02, 04, 19, 70, "INFORMACOES DO ARQUIVO", _COR_GET_EDICAO ) 
                          @ 03,06 Say "Arquivo " + cFile 
                          @ 04,06 Say "Valor   " 
                          nValor:= 0 
                          nSoma:= 0 
                          FOR nCt:= 1 TO Len( aRegistros ) 
                              IF Left( aRegistros[ nCt ], 1 )=="E" 
                                 Scroll( 06, 05, 18, 59, 1 ) 
                                 @ 18,06 Say SubStr( aRegistros[ nCt ], 2, 10 ) + ; 
                                             " - " + SubStr( aRegistros[ nCt ], 12, 40 ) 
                                 INKEY( 0.01 ) 
                                 lGravado:= .F. 
                                 IF CTB->( DBSeek( SubStr( aRegistros[ nCt ], 2, 10 ), .T. ) ) 
                                    WHILE LEFT( CTB->IDECLI, 10 ) == SubStr( aRegistros[ nCt ], 2, 10 ) 
                                       IF LEFT( CTB->IDECLI, 10 ) == SubStr( aRegistros[ nCt ], 2, 10 ) .AND.; 
                                              YEAR( CTB->DATVEN ) == VAL( SubStr( aRegistros[ nCt ], 45, 04 ) ) .AND.; 
                                             MONTH( CTB->DATVEN ) == VAL( SubStr( aRegistros[ nCt ], 49, 02 ) ) .AND.; 
                                               DAY( CTB->DATVEN ) == VAL( SubStr( aRegistros[ nCt ], 51, 02 ) ) .AND.; 
                                                      CTB->VALDEB == VAL( SubStr( aRegistros[ nCt ], 53, 15 ) ) / 100 .AND.; 
                                                      CTB->CONTAC == VAL( SubStr( aRegistros[ nCt ], 31, 10 ) ) 
                                             lGravado:= .T. 
                                             IF CTB->( NetRLock() ) 
                                                IF !Alltrim( CTB->SITUAC )=="RECUPERADO" 
                                                    IF DPA->( DBSeek( VAL( SUBSTR( CTB->IDECLI, 2, 10 ) ) ) ) 
                                                       IF DPA->( NetRLock() ) 
                                                          Replace DPA->SITU__ With "*" 
                                                       ENDIF 
                                                    ENDIF 
                                                ENDIF 
                                             ENDIF 
                                          ENDIF 
                                          CTB->( DBSkip() ) 
                                    ENDDO 
                                 ENDIF 
                                 cCodReg:= "01" 
                                 cCadTip:= "01" 
                                 nMulta_:= 0 
                                 nConta_:= 1 
                                 nCorMon:= 0 
                                 nValPar:= 99999999.99 
                                 nReg:= 0 
                                 CLI->( DBSetOrder( 1 ) ) 
                                 BAN->( DBSetOrder( 1 ) ) 
                                 IF !lGravado .AND. DPA->( DBSeek( VAL( SUBSTR( aRegistros[ nCt ], 2, 10 ) ) ) ) 
                                    IF ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) > 0 
                                        nValorParc:= ( DPA->VLR___ + DPA->JUROS_ - DPA->VLRDES ) 
                                    ENDIF 
                                    IF CLI->( DBSeek( DPA->CLIENT ) ) 
                                       IF buscanet( 5, {|| CTB->( dbappend() ), !Neterr() } ) 
                                          cTmp:= IF( !EMPTY( CLI->IDENTI ), CLI->IDENTI, DPA->CDESCR ) 
                                          CTB->CODIGO:= IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 10, 0 ), StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) 
                                          CTB->SUBCOD:= StrZero( 1, 2, 0 ) 
                                          CTB->CODREG:= cCodReg     // Codigo do Registro 
                                          CTB->CADTIP:= cCadTip     // Tipo do Cadastramento 
                                          Replace CTB->IDECLI With CTB->CODIGO + " " + cTmp        // Identificacao do Cliente na Empresa 
                                          CTB->IDECON:= cTmp                       // Identificao do Consumidor na Empresa 
                                          CTB->NOMCON:= CLI->DESCRI // Nome do Consumidor 
                                          CTB->CIDCON:= CLI->CIDADE // Cidade do Consumidor 
                                          CTB->ESTCON:= CLI->ESTADO // Estado do Consumidor 
                                          CTB->TIPCOD:= IF( !EMPTY( CLI->CGCMF_), "1", "2" ) // 1=CGC  2=CPF 
                                          CTB->CGCCPF:= IF( !EMPTY( CLI->CGCMF_), CLI->CGCMF_, CLI->CPF___ ) // CGC ou CPF 
                                          CTB->CONTAC:= VAL( STR( CLI->CONTAC, 9 ) + CLI->DIGVER ) // Conta Corrente 
                                          CTB->NUMAGE:= CLI->AGENCI // Numero da Agencia 
                                          CTB->CODCLI:= CLI->CODIGO 
                                          CTB->CODBAN:= CLI->BANCO_ // Codigo do Banco 
                                          IF BAN->(DBSeek ( CLI->BANCO_ ) ) 
                                             CTB->NOMBAN:= BAN->DESCRI // Nome do Banco 
                                          ELSE 
                                             CTB->NOMBAN:= ""          // Nome do Banco 
                                          ENDIF 
                                          CTB->DATVEN:= DPA->VENC__ 
                                          CTB->DATOPC:= DPA->DATAEM // Data da Opcao 
                                          CTB->CODMOE:= "03"        // Codigo da Moeda (01=UFIR 03=REAIS) 
                                          CTB->VALDEB:= nValorParc  // Valor do Debito Original/Parcela 
                                          CTB->VALORI:= nValorParc  // Valor do Debito Somente Original 
                                          nValori:= nValorParc 
                                          IF nValPar >= 999999.99 
                                             Replace CTB->VALDEB With nValOri,; 
                                                     CTB->VALORI With nValorParc 
                                          ENDIF 
                                          CTB->SITUAC:= "REMESSA"   // Situacao da Cobranca (Remessa/Retorno) 
                                          CTB->JAENVI:= "Sim"       // Marcacao de Enviado 
                                          CTB->NOMEMP:= Alltrim( _EMP )       // Nome da Empresa 
                                          CTB->CODCON:= SWSet( _GER_BCO_CONVENIO ) // Codigo de Convenio (Informado pelo Banco) 
                                          CTB->CTAREC:= nConta_     // Codigo da Conta Corrente de Receptacao 
                                          CTB->SELEC_:= "Nao"       // ("Nao"=NAO VAI) ("Sim"=VAI SIM) 
                                          CTB->NUMDUP:= DPA->DUPL__ // Numero da Duplicata 
                                          CTB->SEQDUP:= DPA->LETRA_ // Sequencia da Duplicata 
                                          CTB->MULTA_:= nMulta_     // Multa 
                                          CTB->CORMON:= nCorMon     // Correcao Monetaria 
                                          CTB->VALPAR:= nValPar     // Valor Maximo para Parcela 
                                          ++nQuantReg 
                                          nReg++ 
                                          nSoma+= nValorParc 
                                          @ 04,14 Say Tran( nValor+=CTB->VALDEB, "@E 999,999,999.99" ) 
                                       ENDIF 
                                    ELSE 
                                       cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                                       Aviso( "Cliente:" + SubStr( aRegistros[ nCt ], 2, 30 ) + " nao existe mais..." ) 
                                       Pausa() 
                                       ScreenRest( cTelaRes ) 
                                    ENDIF 
                                 ENDIF 
                                 IF DPA->( NetRLock() ) 
                                    Replace DPA->SITU__ With "*" 
                                 ENDIF 
                              ENDIF 
                          NEXT 
                          IF nQuantReg > 0 .OR. nReg > 0 
                             Aviso( "Foram Retornadas ao Status Remetido " + Alltrim( Str( nReg + nQuantReg ) ) + " Registros." ) 
                             Pausa() 
                             Keyboard Chr( K_ESC ) 
                          ENDIF 
                       ENDIF 
                    ENDIF 
                    Sele CTB 
                    DBGoTop() 
                    cUltimo:= "" 
                    dVecimUlt:= CTOD( "  /  /  " ) 
                    nValorUlt:= 0 
                    nIgnorados:= 0 
                    WHILE !CTB->( EOF() ) 
                       IF CTB->CODIGO==cUltimo .AND.; 
                          CTB->DATVEN==dVencimUlt .AND.; 
                          CTB->VALDEB==nValorUlt 
                          IF CTB->( NetRLock() ) 
                             ++nIgnorados 
                             Replace CTB->SITUAC With "<<EXCLUIR>>" 
                          ENDIF 
                       ENDIF 
                       cUltimo:=    CTB->CODIGO 
                       dVencimUlt:= CTB->DATVEN 
                       nValorUlt:=  CTB->VALDEB 
                       CTB->( DBSkip() ) 
                    ENDDO 
 
                    ScreenRest( cTelaAnt ) 
                    IF nIgnorados > 0 
                       Aviso( "Desconsiderados " + Alltrim( Str( nIgnorados ) ) + " Registros ja marcados." ) 
                       Pausa() 
                       CTB->( DBGoTop() ) 
                       WHILE !CTB->( EOF() ) 
                          IF Alltrim( CTB->SITUAC )=="<<EXCLUIR>>" 
                             IF CTB->( NetRLock() ) 
                                CTB->( DBDelete() ) 
                             ENDIF 
                          ENDIF 
                          CTB->( DBSkip() ) 
                       ENDDO 
                    ENDIF 
 
                    ScreenRest( cTelaAnt ) 
 
               CASE Chr( nTecla ) $ "gG" 
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                    cCorRes:= SetColor( _COR_GET_EDICAO ) 
                    Private cUnidade:= "A", cFormatar:= "S" 
                    VPBox( 10, 10, 20, 79, " GRAVACAO EM DISQUETE ", _COR_GET_BOX ) 
                    @ 12,12 Say "Digite a Unidade..:" Get cUnidade  Pict "@R !:" Valid cUnidade $ "AB" 
                    @ 14,12 Say "Formatar a Unidade:" Get cFormatar Pict "!" 
                    READ 
                    cFile:= GDir + "\" + aFiles[ nRow ][ 1 ] 
                    cDestino:= cUnidade + ":\" + aFiles[ nRow ][ 1 ] 
                    cUnidade:= cUnidade + ":" 
                    IF !LastKey()==K_ESC 
                       COPY FILE C:\CONFIG.SYS TO "&cUnidade\CONFIG.SYS" 
                       IF FILE( cUnidade + "\CONFIG.SYS" ) 
                          IF cFormatar=="S" 
                             !FORMAT "&cUnidade /AUTOTEST" /Q >Nil  
                          ELSE 
                             FErase( cUnidade + "\CONFIG.SYS" ) 
                          ENDIF 
                          COPY FILE &cFile TO &cDestino 
                          IF !File( cDestino ) 
                              Aviso( "Impossivel copiar arquivo!" ) 
                              Pausa() 
                          ENDIF 
                       ELSE 
                          Aviso( "Unidade vazia ou tipo de midia Invalida!" ) 
                          Pausa() 
                       ENDIF 
                    ENDIF 
                    SetColor( cCorRes ) 
                    ScreenRest( cTelaRes ) 
                    Release cUnidade 
                    Release cFormatar 
 
               CASE nTecla==K_DEL 
                    IF cRemRet=="EXC" 
                       IF Confirma( 0, 0, "Desfazer Registros desta Remessa?", "N" ) 
                          cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                          cCorRes:= SetColor() 
                          cFile:= GDir + "\" + aFiles[ nRow ][ 1 ] 
                          aRegistros:= "" 
                          aRegistros:= {} 
                          aRegistros:= IOFillText( MEMOREAD( cFile ) ) 
                          DBSelectAr( _COD_CTRLBANC ) 
                          DPA->( DBSetOrder( 3 ) ) 
                          CTB->( DBSetOrder( 5 ) ) 
                          nQuantReg:= 0 
                          SetColor( _COR_GET_EDICAO ) 
                          VPBox( 02, 04, 19, 70, "INFORMACOES DO ARQUIVO", _COR_GET_EDICAO ) 
                          @ 03,06 Say "Arquivo " + cFile 
                          @ 04,06 Say "Valor   " 
                          nValor:= 0 
                          FOR nCt:= 1 TO Len( aRegistros ) 
                              IF Left( aRegistros[ nCt ], 1 )=="E" 
                                 Scroll( 06, 05, 18, 59, 1 ) 
                                 @ 18,06 Say SubStr( aRegistros[ nCt ], 2, 10 ) + ; 
                                             " -:*:- " + SubStr( aRegistros[ nCt ], 12, 30 ) 
                                 INKEY( 0.01 ) 
                                 IF CTB->( DBSeek( SubStr( aRegistros[ nCt ], 2, 10 ), .T. ) ) 
                                    WHILE LEFT( CTB->IDECLI, 10 ) == SubStr( aRegistros[ nCt ], 2, 10 ) 
                                          IF LEFT( CTB->IDECLI, 10 ) == SubStr( aRegistros[ nCt ], 2, 10 ) .AND.; 
                                               YEAR( CTB->DATVEN ) == VAL( SubStr( aRegistros[ nCt ], 45, 04 ) ) .AND.; 
                                             MONTH( CTB->DATVEN ) == VAL( SubStr( aRegistros[ nCt ], 49, 02 ) )  .AND.; 
                                               DAY( CTB->DATVEN ) == VAL( SubStr( aRegistros[ nCt ], 51, 02 ) )  .AND.; 
                                                    CTB->VALDEB == VAL( SubStr( aRegistros[ nCt ], 53, 15 ) ) / 100 .AND.; 
                                                    CTB->CONTAC == VAL( SubStr( aRegistros[ nCt ], 31, 10 ) ) 
                                             IF CTB->( NetRLock() ) 
                                                IF !Alltrim( CTB->SITUAC )=="<<EXCLUIR ITEM>>" 
                                                    Replace CTB->SITUAC With "<<EXCLUIR ITEM>>" 
                                                    IF DPA->( DBSeek( VAL( SUBSTR( CTB->IDECLI, 2, 10 ) ) ) ) 
                                                       IF DPA->( NetRLock() ) 
                                                          Replace DPA->SITU__ With " " 
                                                       ENDIF 
                                                    ELSE 
                                                       cTelaR1:= ScreenSave( 0, 0, 24, 79 ) 
                                                       Aviso( "Registro " + SubStr( CTB->IDECLI, 2, 10 ) + " nÆo localizado..." ) 
                                                       Pausa() 
                                                       ScreenRest( cTelaR1 ) 
                                                    ENDIF 
                                                    ++nQuantReg 
                                                    @ 04,14 Say Tran( nValor+=CTB->VALDEB, "@E 999,999,999.99" ) 
                                                ENDIF 
                                             ENDIF 
                                          ELSE 
                                             cTelaR1:= ScreenSave( 0, 0, 24, 79 ) 
                                             Aviso( "Registro " + SubStr( aRegistros[ nCt ], 2, 10 ) + " nÆo localizado..." ) 
                                             Pausa() 
                                             ScreenRest( cTelaR1 ) 
                                          ENDIF 
                                          CTB->( DBSkip() ) 
                                    ENDDO 
                                 ELSE 
                                    cTelaR1:= ScreenSave( 0, 0, 24, 79 ) 
                                    Aviso( "Registro: " + LEFT( aRegistros[ nCt ], 40 ) + " nao localizado..." ) 
                                    Pausa() 
                                    ScreenRest( cTelaR1 ) 
                                 ENDIF 
                              ENDIF 
                          NEXT 
                          CTB->( DBGoTop() ) 
                          WHILE !CTB->( EOF() ) 
                              IF Alltrim( CTB->SITUAC )=="<<EXCLUIR ITEM>>" 
                                 IF CTB->( NetRLock() ) 
                                    CTB->( DBDelete() ) 
                                 ENDIF 
                              ENDIF 
                              CTB->( DBSkip() ) 
                          ENDDO 
                          DBUnlockAll() 
                          IF nQuantReg > 0 
                             FErase( cFile ) 
                             Aviso( "Foram Retornadas ao Status Padrao " + Alltrim( Str( nQuantReg ) ) + " Registros." ) 
                             Pausa() 
                             Keyboard Chr( K_ESC ) 
                          ELSE 
                             IF Confirma( 0, 0, "Excluir arquivo " + cFile + "?", "Excluir arquivo", "S" ) 
                                FErase( cFile ) 
                             ENDIF 
                          ENDIF 
                          ScreenRest( cTelaRes ) 
                          SetColor( cCorRes ) 
                          EXIT 
                       ENDIF 
                    ENDIF 
 
               CASE nTecla==K_ENTER 
 
                    SWGravar( 10000 ) 
                    cFile:= GDIR + "\" + aFiles[ nRow ][ 1 ] 
						  ViewFile( cFile ) 
                    SWGravar( 5 ) 
 
					OTHERWISE					  ; Tone(125); Tone(300) 
 
				ENDCASE 
 
				oTb:RefreshAll() 
				oTb:Stabilize() 
 
			ENDDO 
 
		EndIf 
 
		SetColor( cCor ) 
		SetCursor( nCursor ) 
		ScreenRest( cTela ) 
 
	Return cFile 
 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function fGeracLay() 
 
		Local cCor:= SetColor(), nCursor:= SetCursor(),; 
				cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
		Local cAno, cMes, cDia, cLinha, cVpcCtrlb, nHandle, nQuaRegs, nValTot, ; 
				nNumSeqArq, nBytes 
 
		cAno:= Right( StrZero( Year  (Date() ), 4 ), 2 ) 
		cMes:= StrZero( Month( Date() ), 2 ) 
		cDia:= StrZero( Day	( Date() ), 2 ) 
 
 
      if !diretorio(GDIR+"\ENVIO") 
         !md "&GDIR\envio" 
      endif 
      if !diretorio(GDIR+"\RETORNO") 
         !md "&GDIR\RETORNO" 
      endif 
 
      cArqRemessa:= Left( "&GDIR\ENVIO\D" + cDia + "E" + cAno + cMes + ".041" + ; 
         Space( 100 ), 64 ) 
 
      FOR nCt:= 41 TO 941 Step 100 
          cArqRemessa:= Left( "&GDIR\ENVIO\D" + cDia + "E" + cAno + cMes + "." + StrZero( nCt, 3, 0 ) + ; 
                             Space( 100 ), 64 ) 
          IF !File( Alltrim( cArqRemessa ) ) 
             EXIT 
          ENDIF 
      NEXT 
 
      SetColor( _COR_GET_EDICAO ) 
      cVpcCtrlb:= ScreenSave( 0, 0, 24, 79 ) 
 
      IF SWAlerta( "COBRANCA BANCARIA VIA DEBITO AUTOMATICO;"+; 
         "Geracao automatica do arquivo remessa" + ";" + ALLTRIM( cArqRemessa ) + ";para envio das duplicatas selecionaas ao banco!", { "Nao Gerar", "Gerar Envio" } )==2 
 
         IF LastKey()==K_ESC 
            SetColor( cCor ) 
            Return Nil 
         ENDIF 
 
         Aviso( "Gerando a Remessa ..." ) 
 
         nHandle := FCREATE( cArqRemessa ) 
 
         IF FERROR() != 0 
            SWAlerta( "Excecao " + StrZero( FERROR(), 2) + ; 
                      " na criacao do ..." + Right( cArqRemessa, 20 ), { "Cancelar" } ) 
            ScreenRest( cTela ) 
            SetColor( cCor ) 
            Return Nil 
         ENDIF 
 
         nQuaRegs := 0 
         nValTot  := 0 
 
         // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä 
         // --- Registro "A" - HEADER 
 
         cLinha := "A" 
         cLinha += "1" 
         cLinha += StrZero ( CTB->CODCON, 5 ) 
         cLinha += Space   ( 15 ) 
         cLinha += Left    ( CTB->NOMEMP, 20 ) 
 
         /* Codigo do Banco na Empresa */ 
         nCodBanco:= CTB->CODBAN 
         cDescBanco:= "BANRISUL" 
 
         /* Localizacao no Cadastro de Agencia */ 
         CON->( DBSetOrder( 1 ) ) 
         IF CON->( DBSeek( CTB->CTAREC ) )   /* Cfe. Conta Corrente de Recepcao Selecionada */ 
            IF CON->AGENC_ > 0 
               AGE->( DBSetOrder( 1 ) ) 
               IF AGE->( DBSeek( CON->AGENC_ ) ) 
                  nCodBanco:= AGE->BANCO_ 
                  BAN->( DBSetOrder( 1 ) ) 
                  IF BAN->( DBSeek( AGE->BANCO_ ) ) 
                     cDescBanco:= BAN->DESCRI 
                  ENDIF 
               ENDIF 
            ENDIF 
         ENDIF 
 
         cLinha += StrZero ( nCodBanco, 3 ) 
         cLinha += PAD( cDescBanco, 20 ) 
         cLinha += StrZero ( Year( Date() ), 4) 
         cLinha += StrZero ( Month( Date() ), 2) 
         cLinha += StrZero ( Day( Date() ), 2) 
         nNumSeqArq := 1 // ALTERAR 
         cLinha += StrZero (nNumSeqArq, 6) 
         cLinha += "04" 
         cLinha += "DEBITO AUTOMATICO" 
         cLinha += Space   (52) 
         cLinha += _CRLF 
 
         nBytes := FWRITE( nHandle, @cLinha, Len (cLinha )) 
 
         IF FERROR() != 0 
            SWAlerta( "Excecao " + StrZero( FERROR(), 2) + ; 
                      " na criacao do ..." + Right( cArqRemessa, 20 ), { "Cancelar" } ) 
            FCLOSE( nHandle ) 
            ScreenRest( cTela ) 
            SetColor( cCor ) 
            Return Nil 
         ENDIF 
 
         nQuaRegs ++ 
 
         CTB->( DBGoTop() ) 
 
         While( CTB->( !EOF() ) ) 
 
            IF CTB->SELEC_ == "Sim" 
 
               DO CASE 
                  CASE CTB->CODREG=="D" 
                     // --- Registro "E" - DEBITO EM CONTA CORRENTE 
                     cLinha := "E" 
                     cLinha += Left    (CTB -> IDECLI, 25) 
                     cLinha += Left    (CTB -> NUMAGE, 4) 
                     cLinha += StrZero (CTB -> CONTAC, 10) 
                     cLinha += Space   (4) 
                     cLinha += StrZero (Year  (CTB -> DATVEN), 4) 
                     cLinha += StrZero (Month (CTB -> DATVEN), 2) 
                     cLinha += StrZero (Day   (CTB -> DATVEN), 2) 
                     cLinha += StrZero (CTB -> VALDEB * 100, 15) 
                     cLinha += Left    (CTB->CODMOE, 2) 
                     cLinha += PAD( StrZero( CTB->NUMDUP, 10 ) + " " + CTB->SEQDUP + " " + CTB->IDECLI + " " + DTOC( CTB->DATOPC ), 60 ) 
                     cLinha += Space   (20) 
                     cLinha += "0"          // 0=Debito Normal   1=Cancelamento 
                     cLinha += _CRLF 
                  CASE CTB->CODREG=="I" .OR. CTB->CODREG=="E" 
                     // --- Registro "B" - CADASTRAMENTO DE DEBITO AUTOMATICO 
                     cLinha := "B" 
                     cLinha += Left    (CTB -> IDECLI, 25) 
                     cLinha += Left    (CTB -> NUMAGE, 4) 
                     cLinha += StrZero (CTB -> CONTAC, 10) 
                     cLinha += Space   (4) 
                     cLinha += StrZero (Year  (CTB -> DATVEN), 4) 
                     cLinha += StrZero (Month (CTB -> DATVEN), 2) 
                     cLinha += StrZero (Day   (CTB -> DATVEN), 2) 
                     cLinha += Space   (97) 
                     cLinha += Left    (CTB -> CADTIP, 1) // 1=Exclusao 2=Inclusao 
                     cLinha += _CRLF 
               ENDCASE 
 
               nBytes := FWRITE( nHandle, @cLinha, Len (cLinha )) 
 
               IF FERROR() != 0 
                  SWAlerta( "Excecao " + StrZero( FERROR(), 2) + ; 
                      " na criacao do ..." + Right( cArqRemessa, 20 ), { "Cancelar" } ) 
                  FCLOSE( nHandle ) 
                  ScreenRest( cTela ) 
                  SetColor( cCor ) 
                  EXIT 
               ENDIF 
 
               nQuaRegs ++ 
               nValTot+= CTB->VALDEB 
 
               IF CTB->( NetRLock () ) 
                  CTB->JAENVI:= "Sim" 
                  CTB->SELEC_:= "Nao" 
               ENDIF 
 
            ENDIF 
 
            CTB->( DBSkip() ) 
 
         END 
 
         // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä 
 
         // --- Registro "Z" - TRAILLER 
 
         nQuaRegs ++ 
 
         cLinha := "Z" 
         cLinha += StrZero( nQuaRegs, 6 ) 
         cLinha += StrTran( StrZero( nValTot, 18, 02 ), ".", "" ) 
         cLinha += Space( 126 ) 
         cLinha += _CRLF 
 
         nBytes := FWRITE( nHandle, @cLinha, Len( cLinha ) ) 
 
         IF FERROR() != 0 
            SWAlerta( "Excecao " + StrZero( FERROR(), 2) + ; 
                      " na criacao do ..." + Right( cArqRemessa, 20 ), { "Cancelar" } ) 
            FCLOSE( nHandle ) 
            ScreenRest( cTela ) 
            SetColor( cCor ) 
            Return Nil 
         ENDIF 
 
         // Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä 
 
         FCLOSE( nHandle ) 
 
         IF( nQuaRegs == 2 ) 
            ERASE &cArqRemessa 
         ENDIF 
 
         nQuaRegs:= IF( nQuaRegs < 3, 0, nQuaRegs -2 ) 
 
         ScreenRest( cTela ) 
 
         IF( nQuaRegs == 0 ) 
            Aviso( "Nenhuma Duplicata Selecionada!" ) 
         ELSE 
            Aviso( "Foram gerados " + Alltrim( Str( nQuaRegs, 6 ) ) + " registros!" ) 
         ENDIF 
*alberto Tue  14-05-02 
*         DiarioComunicacao( "Arquivo de Remessa " + cArqRemessa, "BANRISUL" ) 
         Mensagem( "Pressione [ENTER] para encerrar." ) 
         Pausa() 
 
      ENDIF 
 
		SetColor( cCor ) 
		SetCursor( nCursor ) 
		ScreenRest( cTela ) 
 
	Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function fCodReg( cCodReg ) 
 
		Local cCor:= SetColor(), nCursor:= SetCursor(),; 
				cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nOPCAO:= 1 
 
      IF cCodReg == "D" .OR. cCodReg == "I" .OR. cCodReg == "E" 
         Return .T. 
      ENDIF 
 
      vpbox(11,56,15,72, , _COR_BROW_BOX, .F., .F. ) 
 
		mensagem("") 
      @ 12,50 Say " ÄÄÄÄ" Color _COR_GET_BOX 
 
      SetColor ( _COR_BROWSE ) 
      @ 12,57 Prompt " D‚bito Conta  " 
      @ 13,57 Prompt " Inclus„o Cad. " 
      @ 14,57 Prompt " Exclus„o Cad. " 
 
		menu to nOpcao 
 
		DO CASE 
			CASE nOpcao == 2 
            cCodReg := "I" 
         CASE nOpcao == 3 
            cCodReg := "E" 
         OTHERWISE 
            cCodReg := "D" 
		ENDCASE 
 
		SetColor( cCor ) 
		SetCursor( nCursor ) 
		ScreenRest( cTela ) 
 
   Return .T. 
 
 
 
