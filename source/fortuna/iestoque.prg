// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � IMPESTOQUE 
� Finalidade  � Impressao de relatorios referentes a movimento de estoque 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Agosto/1998 
�             � 23/Junho/1999 ----------------------------------------------- 
�             � Opcao 6=Vendas  Entender Cupom como Produto Vendido, atraves 
�             �                 do codigo CF: no inicio do campo DOC___ 
�             � 
�             � 
��������������� 
*/ 
Function ImpEstoque() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
  Priv cCodPro1, cCodPro2, dData1:= DATE(), dData2:= DATE() 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Saldos", "Saldo $", "Analise", "Sintese", "Vendas", "Lanc", "Resultado", "<Personal>" },; 
                   { " ORDEM       ", "Codigo", "Descricao", "Data" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " MOVIMENTO DE ESTOQUE ", _COR_GET_EDICAO ) 
  WHILE .T. 
      nOperacao:= 999 
      nForn1:= 1 
      nForn2:= 999999 
      cAntPos:= " " 
      cCliente:= " " 
      nVendedor:=  0 
      nAtividade:= 0 
      nLimCr1:= 0 
      nLimCr2:= 99999999.99 
      cIndice:= "DESCRI" 
      Set( _SET_DELIMITERS, .T. ) 
      SetCursor( 1 ) 
      SetColor( _COR_GET_EDICAO ) 
      Scroll( 04, 09, 20, 78 ) 
      SWDispStatus( .F. ) 
      Relatorio( "REPORT.INI", CURDIR() ) 
      SWDispStatus( .T. ) 
      IF !DispSelecao( 06, 09, @aListaOpcoes, @aOpcao ) 
         IF LastKey() == K_ESC 
            SetColor( cCor ) 
            SetCursor( nCursor ) 
            ScreenRest( cTela ) 
            Return Nil 
         ENDIF 
      ELSE 
         /* Selecao de Relatorio */ 
         DO CASE 
 
            /* Simples */ 
            CASE aOpcao[ 2 ] == 2 
                 cArquivo:= RepEstSaldos 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepEstMoney 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepEstAnal 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepEstSt 
 
            CASE aOpcao[ 2 ] == 6 
                 cArquivo:= RepEstSint 
 
            CASE aOpcao[ 2 ] == 7 
                 cArquivo:= RepEstLan 
 
            CASE aOpcao[ 2 ] == 8 
                 cArquivo:= RepEstLucro 
 
            CASE aOpcao[ 2 ] == 9 
                 cArquivo:= RepEstPersonal 
                 SetColor( cCor ) 
                 SetCursor( nCursor ) 
                 ScreenRest( cTela ) 
                 Return Nil 
 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
 
         cCodPro1:= "0000000" 
         cCodPro2:= "9999999" 
         nVen1:= 0 
         nVen2:= 999 
         cComSaldo:= "T" 
         cFab1:= "   " 
         cFab2:= "ZZZ" 
         cES:= " " 
         cACUMULAR:="N" 
         cCancelados:= "S" 
         cDoc___:= " " 
 
 
         IF aOpcao[ 2 ] == 2 .OR. aOpcao[ 2 ] == 3   //sem datas 
            @ 05, 10 Say "Do Codigo.................:" Get cCodPro1 Pict "@R 999-9999" 
            @ 05, 53 Say "Ate:" Get cCodPro2 Pict "@R 999-9999" 
            @ 06, 10 Say "Fabricante de:" Get cFab1 Pict "!!!" 
            @ 06, 34 Say "Ate:"           Get cFab2 Pict "!!!" 
            @ 07, 10 Say "[A]baixo Minimo/Acima [M]aximo/[I]gual Zero/Me[N]or Zero" 
            @ 08, 10 Say "[D]Diferente de Zero [>]Maior Zero [T]odos:" Get cComSaldo Pict "!" Valid cComSaldo $ "AMINTD>" 
 
         ELSE 
            @ 05, 10 Say "Do Codigo.................:" Get cCodPro1 Pict "@R 999-9999" 
            @ 05, 53 Say "Ate:" Get cCodPro2 Pict "@R 999-9999" 
            @ 06, 10 Say "No Periodo de:" Get dData1 
            @ 06, 36 Say "At�:" Get dData2 
            @ 07, 10 Say "Fabricante de:" Get cFab1 Pict "!!!" 
            @ 07, 34 Say "Ate:"           Get cFab2 Pict "!!!" 
            IF aOpcao[ 2 ] == 7 
               cDoc___:= Space( 15 ) 
               @ 08,10 Say "[E]ntradas/[S]aidas/[*]Entradas+Vendas[ ]Todas?" Get cES Pict "!" 
               @ 09,10 Say "Com Movimentos na Operacao:" Get nOperacao Pict "999" 
               @ 10,10 Say "Acumular Por Produto......:" Get cAcumular Pict "!" 
               @ 11, 10 Say "Doc.Contenha: " Get cDoc___ 
            ENDIF 
         endif 
         READ 
         @ 14, 10 Say "��������������������������������������������������������������������" 
 
         READ 
 
         cDoc___:= Trim( cDoc___ ) 
         IF Trim( cDoc___ )=="" 
            cDoc___:= " " 
         ENDIF 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  SWGravar( 30000 ) 
  /* Se estiver dispon�vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "ESTOQUE.PRN" ) 
     Aviso( "Impressao desviada para o arquivo ESTOQUE.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "STR( CODIGO, 6 )" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= "DOC___" 
  ELSEIF aOpcao[ 3 ] == 4 
     cIndice:= "STR( YEAR( DATAMV ) ) + STR( MONTH( DATAMV ) ) + STR( DAY( DATAMV ) )" 
  ENDIF 
 
  IF aOpcao[ 2 ] <> 7 
     @ 15, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
     READ 
  ENDIF 
 
  lTemporario:= .F. 
  IF aOpcao[ 2 ] == 5 
     lTemporario:= .T. 
     aStr:= {{"CODPRO","C",12,00},; 
             {"DESCRI","C",30,00},; 
             {"CODFAB","C",15,00},; 
             {"UNIDAD","C",02,00},; 
             {"SALDOI","N",16,02},; 
             {"ENTDIA","N",16,02},; 
             {"ENTPER","N",16,02},; 
             {"SAIDIA","N",16,02},; 
             {"SAIPER","N",16,02},; 
             {"SALDOA","N",16,02},; 
             {"CUSTO_","N",16,02},; 
             {"VALOR_","N",16,02}} 
     DBSelectAr( 123 ) 
     DBCreate( "RES1245.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RES1245.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On CODPRO To INDICA.Ntx 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_ESTOQUE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To 
     DBGoTop() 
     Set Relation To CPROD_ Into MPR 
     DBSelectAr( 123 ) 
     NF_->( DBSetOrder( 1 ) ) 
     @ 11,20 Say "/" 
     @ 11,21 Say ALLTRIM( STR( EST->( LastRec() ) ) ) 
     WHILE .T. 
        EST->( Processo() ) 
        @ 11,12 Say EST->( Recno() ) 
        IF ( VAL( EST->CPROD_ ) >= VAL( cCodPro1 ) .AND.; 
             VAL( EST->CPROD_ ) <= VAL( cCodPro2 ) ) .AND. EST->ANULAR==" " 
           IF !RES->( DBSeek( EST->CPROD_ ) ) 
               DBAppend() 
               IF netrlock() 
                  Repl RES->CODPRO With EST->CPROD_,; 
                       RES->DESCRI With MPR->DESCRI,; 
                       RES->UNIDAD With MPR->UNIDAD,; 
                       RES->CODFAB With MPR->CODFAB,; 
                       RES->CUSTO_ With MPR->CUSMED 
               ENDIF 
            ENDIF 
            IF EST->DATAMV < dData1 
               IF netrlock() 
                  IF EST->ENTSAI == "+" 
                     Replace RES->SALDOI With RES->SALDOI + EST->QUANT_ 
                  ELSE 
                     Replace RES->SALDOI With RES->SALDOI - EST->QUANT_ 
                  ENDIF 
               ENDIF 
            ELSEIF EST->DATAMV >= dData1 .AND. EST->DATAMV <= dData2 
               IF netrlock() 
                  IF EST->ENTSAI=="-" 
                     IF EST->DATAMV == dData2 
                        Replace RES->SAIDIA With RES->SAIDIA + EST->QUANT_ 
                     ENDIF 
                     Replace SAIPER With SAIPER + EST->QUANT_ 
                  ELSEIF EST->ENTSAI=="+" 
                     IF Left( EST->DOC___, 3 )=="CF:" 
                        /* Se for uma entrada p/ cupom fiscal, 
                           significa um cancelamento e retorna p/ estoque */ 
                        Replace RES->SAIPER With RES->SAIPER - EST->QUANT_ 
                     ELSE 
                        IF EST->DATAMV == dData2 
                           Replace RES->ENTDIA With RES->ENTDIA + EST->QUANT_ 
                        ENDIF 
                        Replace ENTPER With ENTPER + EST->QUANT_ 
                     ENDIF 
                  ENDIF 
               ENDIF 
            ENDIF 
            IF netrlock() 
               Replace RES->SALDOA With RES->SALDOI + RES->ENTPER - RES->SAIPER 
               Replace RES->VALOR_ With RES->CUSTO_ * RES->SALDOA 
            ENDIF 
         ENDIF 
         EST->( DBSkip() ) 
         IF EST->( EOF() ) 
            EXIT 
         ENDIF 
     ENDDO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On CODPRO To INDICA9.Ntx 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To INDICA9.Ntx 
     DBGoTop() 
  ELSEIF aOpcao[ 2 ] == 8 
     lTemporario:= .T. 
     aStr:= {{"CODPRO","C",12,00},; 
             {"DESCRI","C",30,00},; 
             {"CODFAB","C",15,00},; 
             {"UNIDAD","C",02,00},; 
             {"SALDOI","N",16,02},; 
             {"ENTDIA","N",16,02},; 
             {"ENTPER","N",16,02},; 
             {"SAIDIA","N",16,02},; 
             {"SAIPER","N",16,02},; 
             {"SALDOA","N",16,02},; 
             {"VENDIA","N",16,02},; 
             {"VENPER","N",16,02},; 
             {"OUTPER","N",16,02},; 
             {"CUSTO_","N",16,03},; 
             {"CUSTOA","N",16,02},; 
             {"VALOR_","N",16,02},; 
             {"LUCRO_","N",16,02},; 
             {"SENPER","N",16,02},; 
             {"SSAPER","N",16,02},; 
             {"ENTQTD","N",16,02},; 
             {"SAIQTD","N",16,02},; 
             {"SDOQTD","N",16,02},; 
             {"SDOANT","N",16,02}} 
 
     DBSelectAr( 124 ) 
     IF Used() 
        DBCloseArea() 
     ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use ESTOQUE.INF Alias ES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On INDICE To RESIN02.NTX 
     @ 01,00 Say Alias() 
     DBGoTop() 
     dData2:= CTOD( SubStr( DESCRI, 1, 8 ) ) 
     dData1:= CTOD( "01/" + SubStr( DESCRI, 4, 5 ) ) 
     DBSkip() 
 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
 
     DBSelectAr( 124 ) 
     Set Relation To INDICE Into MPR 
 
     DBSelectAr( 123 ) 
     DBCreate( "RES1245.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RES1245.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On CODPRO To INDICA.NTX 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( 123 ) 
     @ 11,20 Say "/" 
     @ 11,21 Say ALLTRIM( STR( ES->( LastRec() ) ) ) 
     ES->( DBGoTop() ) 
     WHILE .T. 
 
        ES->( Processo() ) 
        @ 11,12 Say ES->( Recno() ) 
        IF LastKey() == K_ESC .OR. NextKey() == K_ESC 
           EXIT 
        ENDIF 
 
        IF ( VAL( ES->INDICE ) >= VAL( cCodPro1 ) .AND.; 
             VAL( ES->INDICE ) <= VAL( cCodPro2 ) ) .AND.; 
             ( ES->ED_QTD + ES->ENTVLR + ES->SD_VLR + ES->SAIVLR +; 
               ES->SDOVLR ) <> 0 
           IF !RES->( DBSeek( ES->INDICE ) ) 
               RES->( DBAppend() ) 
               IF netrlock() 
                  Repl RES->CODPRO With ES->INDICE,; 
                       RES->DESCRI With MPR->DESCRI,; 
                       RES->UNIDAD With MPR->UNIDAD,; 
                       RES->CODFAB With MPR->CODFAB,; 
                       RES->CUSTO_ With MPR->CUSMED 
                       Repl RES->LUCRO_ With 0,; 
                            RES->VALOR_ With ES->SATVLR,; 
                            RES->SALDOA With ES->SATVLR,; 
                            RES->ENTPER With ES->ENTVLR,; 
                            RES->ENTQTD With ES->ENTQTD,; 
                            RES->SSAPER With ES->SAIVLR,; 
                            RES->SDOANT With ES->SDOQTD,; 
                            RES->SALDOI With ES->SDOVLR,; 
                            RES->CUSTO_ With ES->CUSMED,; 
                            RES->SAIQTD With ES->SAIQTD,; 
                            RES->SAIPER With ES->SAIVLR,; 
                            RES->SDOQTD With ES->SDOQTD,; 
                            RES->OUTPER With ES->OS_VLR,; 
                            RES->VENPER With ES->SAIVAL,; 
                            RES->VENDIA With ES->SD_VLR,; 
                            RES->ENTDIA With ES->ED_VLR 
                    ENDIF 
            ENDIF 
            IF RES->( netrlock() ) 
               Replace RES->VALOR_ With RES->SALDOA 
               Replace RES->LUCRO_ With ( RES->VENPER - RES->SAIPER ) 
               //- RES->OUTPER 
            ENDIF 
         ENDIF 
         ES->( DBSkip() ) 
         IF ES->( EOF() ) 
            EXIT 
         ENDIF 
     ENDDO 
     DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On CODPRO To INDICA9.Ntx 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To INDICA9.Ntx 
     DBGoTop() 
 
  ELSEIF aOpcao[ 2 ] == 6 
     lTemporario:= .T. 
     aStr:= {{"CODPRO","C",12,00},; 
             {"DESCRI","C",30,00},; 
             {"CODFAB","C",15,00},; 
             {"UNIDAD","C",02,00},; 
             {"QTDDIA","N",16,02},; 
             {"QTDPER","N",16,02},; 
             {"QTDDEV","N",16,02},; 
             {"VLRDIA","N",16,02},; 
             {"VLRPER","N",16,02},; 
             {"QTDNUL","N",16,02},; 
             {"VLRNUL","N",16,02},; 
             {"DIANUL","N",16,02},; 
             {"OUTRAS","N",16,02}} 
     DBSelectAr( 123 ) 
     DBCreate( "RES1245.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RES1245.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On CODPRO To INDICA.Ntx 
 
     @ 08, 10 Say "Do Vendedor:" get nVen1 Pict "999" 
     @ 08, 45 Say "At�:" Get nVen2 Pict "999" 
     READ 
 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_ESTOQUE ) 
     DBSetOrder( 2 ) 
     Set Relation To CPROD_ Into MPR 
     DBSeek( dData1, .T. ) 
     DBSelectAr( 123 ) 
     NF_->( DBSetOrder( 1 ) ) 
     nRegistro:= 0 
     nMaximo:= EST->( LastRec() ) 
     Processo( 0, nMaximo, 0 ) 
     WHILE EST->DATAMV >= dData1 .AND. EST->DATAMV <= dData2 
         IF ( NF_->( DBSeek( Val( SubStr( EST->DOC___, 4 ) ) ) ) .AND.; 
              LEFT( EST->DOC___, 3 ) == "NF:" ) .OR. LEFT( EST->DOC___, 3 ) == "CF:" 
            IF LEFT( EST->DOC___, 3 ) == "CF:" 
               nVendedor:= 0 
            ELSEIF nVen1 + nVen2 == 0 .AND. !( NF_->VENIN_ + NF_->VENEX_ == 0 ) 
               nVendedor:= -1 
            ELSE 
               /* Busca um vendedor pr�ximo ao requesito */ 
               IF NF_->VENIN_ >= nVen1 .AND. NF_->VENIN_ <= nVen2 
                  nVendedor:= NF_->VENIN_ 
               ELSE 
                  nVendedor:= NF_->VENEX_ 
               ENDIF 
            ENDIF 
         ELSE 
            nVendedor:= -1 
         ENDIF 
         IF !RES->( DBSeek( EST->CPROD_ ) ) 
            DBAppend() 
            IF netrlock() 
               Replace CODPRO With EST->CPROD_,; 
                       DESCRI With MPR->DESCRI,; 
                       UNIDAD With MPR->UNIDAD,; 
                       CODFAB With MPR->CODFAB 
            ENDIF 
         ENDIF 
         IF ( ( VAL( EST->CPROD_ ) >= VAL( cCodPro1 ) .AND.; 
                VAL( EST->CPROD_ ) <= VAL( cCodPro2 ) ) .AND.; 
                  ( !( EST->NATOPE >= 5.12  .AND. EST->NATOPE <= 5.129  ) ) .AND.; 
                  ( !( EST->NATOPE >= 6.12  .AND. EST->NATOPE <= 6.129  ) ) .AND.; 
                  ( !( EST->NATOPE >= 6.11  .AND. EST->NATOPE <= 6.119  ) ) .AND.; 
                  ( !( EST->NATOPE >= 5.11  .AND. EST->NATOPE <= 5.119  ) ) .AND.; 
                  ( !( EST->NATOPE >= 5.102 .AND. EST->NATOPE <= 5.1029 ) ) .AND.;       && Em Janeiro de 2003 
                  ( !( EST->NATOPE >= 6.102 .AND. EST->NATOPE <= 6.1029 ) ) .AND.; 
                  ( !( EST->NATOPE >= 6.101 .AND. EST->NATOPE <= 6.1019 ) ) .AND.; 
                  ( !( EST->NATOPE >= 5.101 .AND. EST->NATOPE <= 5.1019 ) ) .AND.; 
                   EST->ANULAR==" " .AND. EST->ENTSAI=="-" ) .AND. !LEFT( EST->DOC___, 3 )=="CF:" 
             IF RES->( netrlock() ) 
                Replace RES->OUTRAS With RES->OUTRAS + EST->QUANT_ 
             ENDIF 
         ENDIF 
         IF RES->( netrlock() ) 
         ENDIF 
         IF ( VAL( EST->CPROD_ ) >= VAL( cCodPro1 ) .AND.; 
              VAL( EST->CPROD_ ) <= VAL( cCodPro2 ) ) .AND.; 
              ( nVendedor >= nVen1 .AND. nVendedor <= nVen2 ) .AND.; 
              ( ( NF_->NATOPE >= 5.100 .AND. NF_->NATOPE <= 5.129 ) .OR.; 
                ( NF_->NATOPE >= 6.100 .AND. NF_->NATOPE <= 6.129 ) .OR.; 
                  LEFT( EST->DOC___, 3 ) == "CF:" ) 
               /* Se estiver anulada a nota fiscal */ 
               IF EST->ENTSAI=="-" .AND. EST->ANULAR=="*" 
                  IF EST->DATAMV == dData2 
                     Replace DIANUL With DIANUL + IF( EST->DATAMV==dData2, EST->QUANT_, 0 ) 
                  ENDIF 
                  Replace QTDNUL With QTDNUL + EST->QUANT_,; 
                          VLRNUL With VLRNUL + EST->VLRSAI 
               /* Verifica se � uma entrada */ 
               ELSEIF EST->ENTSAI=="+" .AND. ( LEFT( EST->DOC___, 3 ) == "CF:" .OR.; 
                                                   ( EST->NATOPE>=5.300 .AND. EST->NATOPE<=5.329 ) .OR.; 
                                                   ( EST->NATOPE>=6.300 .AND. EST->NATOPE<=6.329 ) ) .AND.; 
                                                     EST->ANULAR==" " 
                  Replace QTDDEV With QTDDEV + EST->QUANT_ 
                  IF Left( EST->DOC___, 3 )=="CF:" 
                     Replace QTDPER With QTDPER - EST->QUANT_,; 
                             QTDDIA With QTDDIA - IF( EST->DATAMV==dData2, EST->QUANT_, 0 ),; 
                             VLRPER With VLRPER - EST->VLRSAI,; 
                             VLRDIA With VLRDIA - IF( EST->DATAMV==dData2, EST->VLRSAI, 0 ) 
                  ENDIF 
               /* Verifica se � uma saida */ 
               ELSEIF EST->ENTSAI=="-" .AND. EST->ANULAR==" " 
                  Replace QTDDIA With QTDDIA + IF( EST->DATAMV==dData2, EST->QUANT_, 0 ),; 
                          QTDPER With QTDPER + EST->QUANT_,; 
                          VLRPER With VLRPER + EST->VLRSAI,; 
                          VLRDIA With VLRDIA + IF( EST->DATAMV==dData2, EST->VLRSAI, 0 ) 
               ENDIF 
         ENDIF 
         Processo( ++nRegistro, nMaximo, nRegistro ) 
         EST->( DBSkip() ) 
     ENDDO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On CODPRO To INDICA9.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To INDICA9.NTX 
     DBGoTop() 
  ELSEIF aOpcao[ 2 ] == 4 .OR. aOpcao[ 2 ] == 7 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_ESTOQUE ) 
     cEntSai:= "+-" 
     IF aOpcao[ 2 ] == 7 
        cIndice:= cIndice + " + CPROD_" 
     ELSE 
        cIndice:= "CPROD_ + " + cIndice 
     ENDIF 
     IF aOpcao[ 2 ] == 7 
        IF cEs=="E" 
           cArquivo:= PAD( RepEstLanE, 30 ) 
        ELSEIF cES=="S" 
           cArquivo:= PAD( RepEstLanS, 30 ) 
        ELSE 
           cArquivo:= PAD( RepEstLan, 30 ) 
        ENDIF 
 
        @ 15, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
        READ 
        //// 5.12 / 6.12 = 1 DE JANEIRO DE 2003 
        IF cES=="*" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR ( VAL( CPROD_ ) >= VAL( cCodPro1 )   .AND.; 
                                                   VAL( CPROD_ ) <= VAL( cCodPro2 ) ) .AND.; 
                                              DATAMV >= dData1 .AND. DATAMV <= dData2 .AND.; 
                                        IIF( nOperacao<>999, CODMV_==nOperacao, .T. ) .AND.; 
                                      IIF( ENTSAI=="-", ( ( NATOPE>=5.100 .AND. NATOPE<=5.129 ) .OR.; 
                                                          ( NATOPE>=6.100 .AND. NATOPE<=6.129 ) ), .T. ) .AND.; 
                                                            ANULAR==" " .AND. cDoc___ $ DOC___ + " " 
        ELSE 
           cEntSai:= IF( cES=="E", "+", "+-" ) 
           cEntSai:= IF( cES=="S", "-", cEntSai ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR ( VAL( CPROD_ ) >= VAL( cCodPro1 ) .AND.; 
                                                VAL( CPROD_ ) <= VAL( cCodPro2 ) ) .AND.; 
                                                DATAMV >= dData1 .AND. DATAMV <= dData2 .AND.; 
                                                ( IIF( cES=="S", LEFT( DOC___, 3 )=="CF:" .OR. ENTSAI $ cEntSai, ENTSAI $ cEntSai ) ) .AND.; 
                                                IIF( nOperacao<>999, CODMV_==nOperacao, .T. ) .AND. cDoc___ $ DOC___ + " " 
        ENDIF 
     ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE01.TMP FOR ( VAL( CPROD_ ) >= VAL( cCodPro1 ) .AND.; 
                                                VAL( CPROD_ ) <= VAL( cCodPro2 ) ) .AND.; 
                                                DATAMV >= dData1 .AND. DATAMV <= dData2 .AND. ENTSAI $ cEntSai .AND.; 
                                                IIF( nOperacao<>999, CODMV_==nOperacao, .T. ) .AND. cDoc___ $ DOC___ + " " 
     ENDIF 
     IF cAcumular=="S" 
        DBSelectAr( 123 ) 
        aStr:=  {{"FILIAL","N",03,00},; 
                 {"CODFIL","N",06,00},; 
                 {"CPROD_","C",12,00},; 
                 {"CODRED","C",12,00},; 
                 {"ENTSAI","C",01,00},; 
                 {"QUANT_","N",12,03},; 
                 {"DOC___","C",15,00},; 
                 {"CODIGO","N",06,00},; 
                 {"VLRSDO","N",16,02},; 
                 {"VLRSAI","N",16,02},; 
                 {"VLRICM","N",16,02},; 
                 {"VALOR_","N",16,02},; 
                 {"TOTAL_","N",16,02},; 
                 {"DATAMV","D",08,00},; 
                 {"RESPON","N",03,00},; 
                 {"ANULAR","C",01,00},; 
                 {"PERICM","N",06,02},; 
                 {"PERIPI","N",06,02},; 
                 {"VLRIPI","N",16,02},; 
                 {"VLRFRE","N",16,02},; 
                 {"NATOPE","N",06,03},; 
                 {"CUSMED","N",16,04},; 
                 {"CODMV_","N",03,00},; 
                 {"CUSATU","N",16,04},; 
                 {"PCPCLA","N",03,00},; 
                 {"PCPTAM","N",02,00},; 
                 {"PCPCOR","N",03,00},; 
                 {"PCPQUA","N",12,02}} 
        DBCreate( "INFO.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        use INFO.TMP Alias TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON CPROD_ + ENTSAI + Str( CODMV_ ) TO I1292033 
        EST->( DBGoTop() ) 
        WHILE !EST->( EOF() ) 
            lGravar:= .T. 
            IF lGravar 
               IF !( TMP->( DBSeek( EST->CPROD_ + EST->ENTSAI + Str( CODMV_ ) ) ) ) 
                  TMP->( DBAppend() ) 
               ENDIF 
               FOR nCt:= 1 TO Len( aStr ) 
                  cCampo:= aStr[ nCt ][ 1 ] 
                  IF cCampo $ "VALOR_-QUANT_-VLRSAI-TOTAL_" 
                     Replace TMP->&cCampo With TMP->&cCampo + EST->&cCampo 
                  ELSE 
                     Replace TMP->&cCampo With EST->&cCampo 
                  ENDIF 
               NEXT 
            ENDIF 
            EST->( DBSkip() ) 
        ENDDO 
        DBSelectAr( 123 ) 
        Set Relation To CPROD_ Into MPR 
        DBGoTop() 
     ELSE 
        DBSelectAr( _COD_ESTOQUE ) 
        DBGoTop() 
        Set Relation To CPROD_ Into MPR 
     ENDIF 
 
  ELSE 
     IF aOpcao[ 3 ] == 2 
        cIndice:= "INDICE" 
     ELSEIF aOpcao[ 3 ] == 3 
        cIndice:= "DESCRI" 
     ENDIF 
 
     DBSelectAr( _COD_MPRIMA ) 
 
     DO CASE 
     CASE cComSaldo=="T"  // todos 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     CASE cComSaldo=="A"  // Saldo abaixo minimo 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. SALDO_ < ESTMIN .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     CASE cComSaldo=="M"  // Saldo acima do maximo 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. SALDO_ > ESTMAX .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     CASE cComSaldo=="I"  // Igual a zero 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. SALDO_ == 0 .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     CASE cComSaldo=="N"  // menor que zero 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. SALDO_ < 0 .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     CASE cComSaldo=="D"  // Diferente de Zero 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. SALDO_ <> 0 .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     CASE cComSaldo==">"  // Maior que Zero 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE02.TMP FOR INDICE >= PAD( cCodPro1, 12 ) .AND. INDICE <= PAD( cCodPro2, 12 ) .AND. SALDO_ > 0 .AND. ORIGEM >= cFab1 .AND. ORIGEM <= cFab2 
     ENDCASE 
  ENDIF 
 
  @ 01,00 Say Alias() 
  DBGoTop() 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSE 
     SelecaoImpressora( .F. ) 
  ENDIF 
 
  /* Emissao do relatorio */ 
  Relatorio( AllTrim( cArquivo ) ) 
 
  /* Se estiver dispon�vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     ViewFile( "TELA0000.TMP" ) 
  ENDIF 
 
  /* Retorna para porta DEFAULT */ 
  Set( 24, "LPT1" ) 
  SWGravar( 5 ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  IF lTemporario 
     DBSelectAr( 123 ) 
     DBCloseArea() 
  ENDIF 
  DBCloseAll() 
  AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
  dbSelectAr( _COD_MPRIMA ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/mprind01.ntx",;  
                 "&gdir/mprind02.ntx",;  
                 "&gdir/mprind03.ntx",;  
                 "&gdir/mprind04.ntx",;  
                 "&gdir/mprind05.ntx" 
  #else
    Set index To "&GDIR\MPRIND01.NTX",;  
                 "&GDIR\MPRIND02.NTX",;  
                 "&GDIR\MPRIND03.NTX",;  
                 "&GDIR\MPRIND04.NTX",;  
                 "&GDIR\MPRIND05.NTX" 

  #endif
  dbSelectAr( _COD_ESTOQUE ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/estind01.ntx",;  
                 "&gdir/estind02.ntx",;  
                 "&gdir/estind03.ntx",;  
                 "&gdir/estind04.ntx" 
  #else
    Set Index To "&GDIR\ESTIND01.NTX",;  
                 "&GDIR\ESTIND02.NTX",;  
                 "&GDIR\ESTIND03.NTX",;  
                 "&GDIR\ESTIND04.NTX" 

  #endif
  Return Nil 
 
