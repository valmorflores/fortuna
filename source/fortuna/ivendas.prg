// ## CL2HB.EXE - Converted
 
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � IMPVendas 
� Finalidade  � Impressao de relatorios referentes a movimento de Vendas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Agosto/1998 
��������������� 
*/ 
Function ImpVendas() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
  Priv cCodPro1, cCodPro2, dData1:= DATE(), dData2:= DATE() 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Detalhamento","ProdxRep", "ProdxTab","<Personal>" },; 
                   { " ORDEM       ", "Codigo", "Descricao", "Data" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " MOVIMENTO DE VENDAS ", _COR_GET_EDICAO ) 
  WHILE .T. 
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
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepVenProducao 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepVenTabela 
 
            CASE aOpcao[ 3 ] == 2 
                 cArquivo:= RepVenDetalhe 
 
            CASE aOpcao[ 2 ] == 7 
                 cArquivo:= RepVenPersonal 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
 
         cCodPro1:= "0000000" 
         cCodPro2:= "9999999" 
         nVen1:= 0 
         nVen2:= 999 
         cComSaldo:= "S" 
 
         @ 05, 10 Say "Do Codigo.......................:" Get cCodPro1 Pict "@R 999-9999" 
         @ 05, 53 Say "Ate:" Get cCodPro2 Pict "@R 999-9999" 
         @ 06, 10 Say "No Periodo de:" Get dData1 
         @ 06, 36 Say "At�:" Get dData2 
         @ 08, 10 Say "��������������������������������������������������������������������" 
         @ 09, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  /* Se estiver dispon�vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "VENDAS.PRN" ) 
     Aviso( "Impressao desviada para o arquivo VENDAS.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "CODIGO" 
  ENDIF 
 
  lTemporario:= .T. 
  DO CASE 
     CASE aOpcao[ 2 ] == 2 
 
        DO CASE 
           CASE aOpcao[ 3 ] == 4 
                cIndice:= "DATAMV" 
           CASE aOpcao[ 3 ] == 3 
                cIndice:= "INDICE" 
           CASE aOpcao[ 3 ] == 2 
                cIndice:= "DOC___" 
        ENDCASE 
 
        cES:= " " 
        nOperacao:= 999 
        @ 07, 10 Say Space( 60 ) 
        @ 07, 10 Say "Operacao:" Get nOperacao Pict "999" 
        READ 
        cEntSai:= "-" 
        MPR->( DBSetOrder( 1 ) ) 
        DBSelectAr( _COD_ESTOQUE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE01.TMP FOR ( VAL( CPROD_ ) >= VAL( cCodPro1 )    .AND.; 
                                                VAL( CPROD_ ) <= VAL( cCodPro2 ) )  .AND.; 
                                           DATAMV >= dData1 .AND. DATAMV <= dData2  .AND.; 
                                                                  ENTSAI $ cEntSai  .AND.; 
                                     IIF( nOperacao<>999, CODMV_==nOperacao, .T. )  .AND.; 
                                          ( ( NATOPE >= 5.11 .AND. NATOPE <= 5.119 ) .OR.; 
                                            ( NATOPE >= 6.11 .AND. NATOPE <= 6.119 ) .OR.; 
                                            ( NATOPE >= 5.12 .AND. NATOPE <= 5.129 ) .OR.; 
                                            ( NATOPE >= 6.12 .AND. NATOPE <= 6.129 ) ) .AND.; 
                                              ANULAR==" " 
 
 
        dbGoTop() 
        Set Relation To CPROD_ Into MPR 
 
     CASE aOpcao[ 2 ] == 3 
        aStr:= {{"CODPRO","C",12,00},; 
                {"DESCRI","C",40,00},; 
                {"UNIDAD","C",02,00},; 
                {"vend00","n",16,02},; 
                {"VEND01","N",16,02},; 
                {"VEND02","N",16,02},; 
                {"VEND03","N",16,02},; 
                {"VEND04","N",16,02},; 
                {"VEND05","N",16,02},; 
                {"VEND06","N",16,02},; 
                {"VEND07","N",16,02},; 
                {"VEND08","N",16,02},; 
                {"VEND09","N",16,02},; 
                {"VEND10","N",16,02},; 
                {"VEND11","N",16,02},; 
                {"VEND12","N",16,02},; 
                {"ULTIMA","D",09,00}} 
 
        DBSelectAr( 123 ) 
        DBCreate( "RES0005.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Use RES0005.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On CODPRO To INDICA.Ntx 
 
        DBSelectAr( _COD_PRODNF ) 
        DBSetOrder( 5 ) 
        DBSelectAr( _COD_NFISCAL ) 
        DBSetOrder( 3 ) 
        DBSeek( dData1, .T. ) 
        DBSelectar( 123 ) 
        WHILE NF_->DATAEM >= dData1 .AND. NF_->DATAEM <= dData2 
            IF ( NF_->NATOPE >= 5.100 .AND. NF_->NATOPE <= 5.129 ) .OR.; 
               ( NF_->NATOPE >= 6.100 .AND. NF_->NATOPE <= 6.129 ) 
               IF PNF->( DBSeek( NF_->NUMERO ) ) 
                  WHILE PNF->CODNF_ == NF_->NUMERO .AND. !PNF->( EOF() ) 
                      IF ALLTRIM( PNF->CODRED ) >= cCodPro1 .AND. ALLTRIM( PNF->CODRED ) <= cCodPro2 
                         IF !DBSeek( PAD( PNF->CODRED, 12 ) ) 
                            DBAppend() 
                            RLock() 
                            Replace CODPRO With PNF->CODRED,; 
                                    DESCRI With PNF->DESCRI,; 
                                    UNIDAD With PNF->UNIDAD 
                         ENDIF 
                         RLock() 
 
                         /* VENDEDORES EXTERNOS */ 
                         DO CASE 
                            CASE NF_->VENEX_ == 0 .AND. NF_->VENIN_ == 0 
                                 Replace VEND00 With VEND00 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 1 
                                 Replace VEND01 With VEND01 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 2 
                                 Replace VEND02 With VEND02 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 3 
                                 Replace VEND03 With VEND03 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 4 
                                 Replace VEND04 With VEND04 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 5 
                                 Replace VEND05 With VEND05 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 6 
                                 Replace VEND06 With VEND06 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 7 
                                 Replace VEND07 With VEND07 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 8 
                                 Replace VEND08 With VEND08 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 9 
                                 Replace VEND09 With VEND09 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 10 
                                 Replace VEND10 With VEND10 + PNF->QUANT_ 
                         ENDCASE 
 
                         /* VENDEDORES INTERNOS */ 
                         DO CASE 
                            CASE NF_->VENIN_ == 1 
                                 Replace VEND01 With VEND01 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 2 
                                 Replace VEND02 With VEND02 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 3 
                                 Replace VEND03 With VEND03 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 4 
                                 Replace VEND04 With VEND04 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 5 
                                 Replace VEND05 With VEND05 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 6 
                                 Replace VEND06 With VEND06 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 7 
                                 Replace VEND07 With VEND07 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 8 
                                 Replace VEND08 With VEND08 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 9 
                                 Replace VEND09 With VEND09 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 10 
                                 Replace VEND10 With VEND10 + PNF->QUANT_ 
                         ENDCASE 
                      ENDIF 
                      PNF->( DBSkip() ) 
                  ENDDO 
               ENDIF 
            ENDIF 
            NF_->( DBSkip() ) 
        ENDDO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On CODPRO To INDICA9.Ntx 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Set Index To INDICA9.Ntx 
        DBGoTop() 
   CASE aOpcao[ 2 ] == 4 
        aStr:= {{"CODPRO","C",12,00},; 
                {"DESCRI","C",40,00},; 
                {"UNIDAD","C",02,00},; 
                {"VEN000","N",16,02},; 
                {"VEN001","N",16,02},; 
                {"VEN002","N",16,02},; 
                {"VEN003","N",16,02},; 
                {"VEN004","N",16,02},; 
                {"VEN010","N",16,02},; 
                {"VEN011","N",16,02},; 
                {"VEN012","N",16,02},; 
                {"VEN013","N",16,02},; 
                {"VEN014","N",16,02},; 
                {"VEN020","N",16,02},; 
                {"VEN021","N",16,02},; 
                {"VEN022","N",16,02},; 
                {"VEN023","N",16,02},; 
                {"VEN024","n",16,02},; 
                {"VEN030","N",16,02},; 
                {"VEN031","N",16,02},; 
                {"VEN032","N",16,02},; 
                {"VEN033","N",16,02},; 
                {"VEN034","N",16,02},; 
                {"VEN040","N",16,02},; 
                {"VEN041","N",16,02},; 
                {"VEN042","N",16,02},; 
                {"VEN043","N",16,02},; 
                {"VEN044","N",16,02},; 
                {"VEN050","N",16,02},; 
                {"VEN051","N",16,02},; 
                {"VEN052","N",16,02},; 
                {"VEN053","N",16,02},; 
                {"VEN054","N",16,02},; 
                {"VEN060","N",16,02},; 
                {"VEN061","N",16,02},; 
                {"VEN062","N",16,02},; 
                {"VEN063","N",16,02},; 
                {"VEN064","N",16,02},; 
                {"VEN070","N",16,02},; 
                {"VEN071","N",16,02},; 
                {"VEN072","N",16,02},; 
                {"VEN073","N",16,02},; 
                {"VEN074","N",16,02},; 
                {"VEN080","N",16,02},; 
                {"VEN081","N",16,02},; 
                {"VEN082","N",16,02},; 
                {"VEN083","N",16,02},; 
                {"VEN084","N",16,02},; 
                {"VEN090","N",16,02},; 
                {"VEN091","N",16,02},; 
                {"VEN092","N",16,02},; 
                {"VEN093","N",16,02},; 
                {"VEN094","N",16,02},; 
                {"VEN100","N",16,02},; 
                {"VEN101","N",16,02},; 
                {"VEN102","N",16,02},; 
                {"VEN103","N",16,02},; 
                {"VEN104","N",16,02},; 
                {"CUSMED","N",16,02},; 
                {"ULTIMA","D",08,00}} 
        DBSelectAr( 123 ) 
        DBCreate( "RES0005.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Use RES0005.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On CODPRO To INDICA.Ntx 
        DBSelectAr( _COD_PRODNF ) 
        DBSetOrder( 5 ) 
        DBSelectAr( _COD_NFISCAL ) 
        DBSetOrder( 3 ) 
        DBSeek( dData1, .T. ) 
        DBSelectar( 123 ) 
        WHILE NF_->DATAEM >= dData1 .AND. NF_->DATAEM <= dData2 
            IF ( NF_->NATOPE >= 5.100 .AND. NF_->NATOPE <= 5.129 ) .OR.; 
               ( NF_->NATOPE >= 6.100 .AND. NF_->NATOPE <= 6.129 ) .AND. NF_->NFNULA == " " 
               IF PNF->( DBSeek( NF_->NUMERO ) ) 
                  WHILE PNF->CODNF_ == NF_->NUMERO .AND. !PNF->( EOF() ) 
                      IF ALLTRIM( PNF->CODRED ) >= cCodPro1 .AND. ALLTRIM( PNF->CODRED ) <= cCodPro2 
                         IF !DBSeek( PAD( PNF->CODRED, 12 ) ) 
                            MPR->( DBSetOrder( 1 ) ) 
                            MPR->( DBSeek( PNF->CODRED ) ) 
                            DBAppend() 
                            RLock() 
                            Replace CODPRO With PNF->CODRED,; 
                                    DESCRI With PNF->DESCRI,; 
                                    UNIDAD With PNF->UNIDAD 
                         ENDIF 
                         RLock() 
                         Replace CUSMED With CUSMED + ( MPR->CUSMED * PNF->QUANT_ ) 
 
                         // VENDEDOR EXTERNO 
                         DO CASE 
                            CASE NF_->VENEX_ == 0 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN000 With VEN000 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN001 With VEN001 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN002 With VEN002 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN003 With VEN003 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 1 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN010 With VEN010 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN011 With VEN011 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN012 With VEN012 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN013 With VEN013 + PNF->PRECOT 
                                 ENDIF 
                                 Replace VEN01 With VEN01 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 2 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN020 With VEN020 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN021 With VEN021 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN022 With VEN022 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN023 With VEN023 + PNF->PRECOT 
                                 ENDIF 
                                 Replace VEN02 With VEN02 + PNF->QUANT_ 
                            CASE NF_->VENEX_ == 3 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN030 With VEN030 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN031 With VEN031 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN032 With VEN032 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN033 With VEN033 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 4 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN040 With VEN040 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN041 With VEN041 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN042 With VEN042 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN043 With VEN043 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 5 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN050 With VEN050 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN051 With VEN051 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN052 With VEN052 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN053 With VEN053 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 6 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN060 With VEN060 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN061 With VEN061 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN062 With VEN062 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN063 With VEN063 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 7 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN070 With VEN070 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN071 With VEN071 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN072 With VEN072 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN073 With VEN073 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 8 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN080 With VEN080 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN081 With VEN081 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN082 With VEN082 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN083 With VEN083 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 9 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN090 With VEN090 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN091 With VEN091 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN092 With VEN092 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN093 With VEN093 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENEX_ == 10 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN100 With VEN100 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN101 With VEN101 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN102 With VEN102 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN103 With VEN103 + PNF->PRECOT 
                                 ENDIF 
                         ENDCASE 
 
 
                         // VENDEDOR INTERNO 
                         DO CASE 
                            CASE NF_->VENIN_ == 0 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN000 With VEN000 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN001 With VEN001 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN002 With VEN002 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN003 With VEN003 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 1 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN010 With VEN010 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN011 With VEN011 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN012 With VEN012 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN013 With VEN013 + PNF->PRECOT 
                                 ENDIF 
                                 Replace VEN01 With VEN01 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 2 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN020 With VEN020 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN021 With VEN021 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN022 With VEN022 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN023 With VEN023 + PNF->PRECOT 
                                 ENDIF 
                                 Replace VEN02 With VEN02 + PNF->QUANT_ 
                            CASE NF_->VENIN_ == 3 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN030 With VEN030 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN031 With VEN031 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN032 With VEN032 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN033 With VEN033 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 4 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN040 With VEN040 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN041 With VEN041 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN042 With VEN042 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN043 With VEN043 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 5 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN050 With VEN050 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN051 With VEN051 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN052 With VEN052 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN053 With VEN053 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 6 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN060 With VEN060 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN061 With VEN061 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN062 With VEN062 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN063 With VEN063 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 7 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN070 With VEN070 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN071 With VEN071 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN072 With VEN072 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN073 With VEN073 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 8 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN080 With VEN080 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN081 With VEN081 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN082 With VEN082 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN083 With VEN083 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 9 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN090 With VEN090 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN091 With VEN091 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN092 With VEN092 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN093 With VEN093 + PNF->PRECOT 
                                 ENDIF 
                            CASE NF_->VENIN_ == 10 
                                 IF PNF->TABPRE == 0 
                                    Replace VEN100 With VEN100 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 01 
                                    Replace VEN101 With VEN101 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 02 
                                    Replace VEN102 With VEN102 + PNF->PRECOT 
                                 ELSEIF PNF->TABPRE == 03 
                                    Replace VEN103 With VEN103 + PNF->PRECOT 
                                 ENDIF 
                         ENDCASE 
 
                      ENDIF 
                      PNF->( DBSkip() ) 
                  ENDDO 
               ENDIF 
            ENDIF 
            NF_->( DBSkip() ) 
        ENDDO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On CODPRO To INDICA9.Ntx 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Set Index To INDICA9.Ntx 
        DBGoTop() 
  ENDCASE 
 
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
 
  dbselectar( _COD_MPRIMA ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/mprind01.ntx", "&gdir/mprind02.ntx", "&gdir/mprind03.ntx", "&gdir/mprind04.ntx", "&gdir/mprind05.ntx"      
  #else 
    Set index To "&GDIR\MPRIND01.NTX", "&GDIR\MPRIND02.NTX", "&GDIR\MPRIND03.NTX", "&GDIR\MPRIND04.NTX", "&GDIR\MPRIND05.NTX"      
  #endif
 
  dbselectar( _COD_ESTOQUE ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/estind01.ntx", "&gdir/estind02.ntx", "&gdir/estind03.ntx", "&gdir/estind04.ntx"     
  #else 
    Set Index To "&GDIR\ESTIND01.NTX", "&GDIR\ESTIND02.NTX", "&GDIR\ESTIND03.NTX", "&GDIR\ESTIND04.NTX"     
  #endif
  Set Relation To 
 
  Return Nil 
 
 
