// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpEntSai 
³ Finalidade  ³ Impressao de ENTRADAS / SAIDAS 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpEntSai() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
  Local cCodPro1, cCodPro2 
  Local dData1:= DATE(), dData2:= DATE(), dDataEm1:= CTOD( "  /  /  " ), dDataEm2:= DATE()+365 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Entradas", "Saidas", "Resumo", "NF Entrada", "Detalhe", "ProdXServ" },; 
                   { " ORDEM       ", "Nota", "Cliente", "Data", "CFO" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " ENTRADAS & SAIDAS ", _COR_GET_EDICAO ) 
  DBSelectAr( _COD_ATALHO ) 
  DBclosearea() 
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
            CASE aOpcao[ 2 ] == 2 
                 cArquivo:= RepESEntrada 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepESSaida 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepESResumo 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepESNotaS 
 
            CASE aOpcao[ 2 ] == 6 
                 cArquivo:= RepESSaide 
 
            CASE aOpcao[ 2 ] == 7 
                 cArquivo:= RepProdxServico 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
 
         cCodPro1:= "0000000" 
         cCodPro2:= "9999999" 
 
         dDataIni:= DATE() 
         dDataFim:= DATE() 
         @ 05, 10 Say "No periodo entre..:" Get dDataIni 
         @ 05, 51 Say "Ate:" Get dDataFim 
         @ 09, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
         @ 10, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
 
  /* Se estiver dispon¡vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "ENTSAI.PRN" ) 
     Aviso( "Impressao desviada para o arquivo ENTSAI.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  nOrdem:= 1 
  IF aOpcao[ 3 ] == 2 
     nOrdem:= 1 
  ELSEIF aOpcao[ 3 ] == 3 
     nOrdem:= 2 
  ELSEIF aOpcao[ 3 ] == 4 
     nOrdem:= 3 
  ENDIF 
 
  IF aOpcao[ 2 ] == 3 .or. aOpcao[ 2 ] == 6 
     nClient1:= 0 
     nClient2:= 999999 
     nNatop  := 9.999 
     nCodope := 999 
*     IF aOpcao[ 2 ] == 6 
        @ 06, 10 Say "Do Cliente........................: " Get nClient1    Pict "999999" 
        @ 06, 56 Say "At‚:" Get nClient2 Pict "999999" 
        @ 07, 10 Say "Natureza da Operacao (9.999 todas): " Get nnatop     Pict "@R 9.999" 
        @ 08, 10 Say "Codigo da Operacao (999) Todas....: " Get nCodope    Pict "999" 
        READ 
*     ENDIF 
     aStr:= {{"CODNF_","N",08,00},; 
             {"CODCLI","N",06,00},; 
             {"SERIE_","C",01,00},; 
             {"DATAEM","D",08,00},; 
             {"CONTAB","N",16,02},; 
             {"NATOPE","N",06,03},; 
             {"BASICM","N",16,02},; 
             {"PERICM","N",10,03},; 
             {"VLRICM","N",16,02},; 
             {"ISENTO","N",16,02},; 
             {"OUTROS","N",16,02},; 
             {"TABOPE","N",03,00},; 
             {"NFNULA","C",01,00}} 
     DBCreate( "RES01234.TMP", aStr ) 
     DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     USE RES01234.TMP ALIAS RES 
     IF aOpcao[ 2 ] == 6 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On str(CODCLI,6)+dtos(DATAEM) To Indice 
     ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On DATAEM To Indice 
     ENDIF 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_PRODNF ) 
     DBSetOrder( 5 ) 
     Set Relation To CODIGO Into MPR 
     DBSelectAr( _COD_NFISCAL ) 
     DBSetOrder( 3 ) 
     Set Relation To NUMERO Into PNF 
     DBSeek( dDataIni, .T. ) 
     cEntSai:= "S" 
 
     WHILE  !( NF_->( EOF() ) ) .and. DATAEM >= dDataIni .AND. DATAEM <= dDataFim 
         Mensagem( "Processando nota fiscal " + StrZero( NF_->NUMERO, 8, 0 ) + ", Aguarde..." ) 
         if nNatop <> 9.999 
            if NATOPE <> nNatop 
               skip 
               loop 
            endif 
         endif 
         if nCodope <> 999 
            if TABOPE <> nCodope 
               skip 
               loop 
            endif 
         endif 
         IF CLIENT >= nClient1 .and. CLIENT <= nClient2 
            IF TIPONF == cEntSai 
               nContabil:= NF_->VLRTOT 
               nOutros:= 0 
               nIsento:= 0 
               nIcm:= 0 
               OPE->( DBSetOrder( 1 ) ) 
               OPE->( DBSeek( NF_->TABOPE ) ) 
               nVlrIcm:= 0 
               nValorProdutos:= 0 
               nValorServicos:= 0 
               WHILE !PNF->( EOF() ) .and. PNF->CODNF_ == NF_->NUMERO 
                    IF LEFT( PNF->CODIGO, 3 ) <> SWSet( _GER_GRUPOSERVICOS ) 
                       IF PNF->PERICM > 0 
                          nIcm:= PNF->PERICM 
                       ENDIF 
                       IF PNF->IPICOD==4 .OR. OPE->CALICM=="N" .OR. PNF->SITT02==40 .OR. PNF->SITT02==41 
                          nIsento:= nIsento + PNF->PRECOT 
                       ELSEIF PNF->SITT02==51 .OR. PNF->SITT02==50 
                          nOutros:= nOutros + PNF->PRECOT 
                       ELSEIF PNF->IPICOD==2 .OR. PNF->SITT02==20 
                          RED->( DBSetOrder( 1 ) ) 
                          RED->( DBSeek( MPR->TABRED ) ) 
                          nReducao:= PNF->PRECOT - ( ( PNF->PRECOT * ( 100 - RED->PERRED ) ) / 100 ) 
                          nOutros:= nOutros + nReducao 
                       ELSE 
                          nVlrIcm:= nVlrIcm + PNF->VLRICM 
                       ENDIF 
                       nValorProdutos:= nValorProdutos + PNF->PRECOT 
                    ELSE 
                       nValorServicos:= nValorServicos + PNF->PRECOT 
                       //nOutros:= nOutros + PNF->PRECOT 
                    ENDIF 
                    PNF->( DBSkip() ) 
               ENDDO 
 
               /* Verifica diferenca de soma na nota fiscal */ 
               IF ROUND( nValorServicos + nValorProdutos, 0 ) <> ROUND( NF_->VLRNOT, 0 ) .AND.; 
                  ROUND( nValorServicos + nValorProdutos - NF_->VLRDES, 0 ) <> ROUND( NF_->VLRNOT, 0 ) .AND.; 
                  ROUND( nValorProdutos - NF_->VLRDES, 0 ) <> ROUND( NF_->VLRNOT, 0 ) 
 
                  Aviso( "Nota Fiscal n§ " + StrZero( NF_->NUMERO, 8, 0 ) + " com diferencas de valores nos seus produtos." ) 
                  Pausa() 
               ENDIF 
 
               nBaseIcm:= NF_->BASICM 
 
               IF OPE->CALICM == "N" 
                  nIsento:= NF_->VLRTOT 
                  nVlrIcm:= 0 
               ENDIF 
 
               IF ( nOutros + nIsento ) == 0 
                  nBaseIcm:= nContabil 
               ENDIF 
 
               IF nOutros > 0 
                  nOutros:= nContabil - ( nIsento + nBaseIcm ) 
               ELSEIF nIsento > 0 
                  nIsento:= nContabil - ( nBaseIcm + nOutros ) 
               ENDIF 
 
               IF ( nOutros + nIsento ) > 0 
                  nBaseIcm:= nContabil - ( nOutros + nIsento ) 
               ENDIF 
 
               IF nIsento < 0 
                  nIsento:= 0 
                  nOutros:= nOutros + nIsento 
               ENDIF 
 
               IF nOutros < 0 
                  nOutros:= 0 
               ENDIF 
 
               IF nIsento < 0 
                  nIsento:= 0 
               ENDIF 
 
 
               nVlrIcm:= IF( nVlrIcm==0, NF_->VLRICM, nVlrIcm ) 
               //nIsento:= NF_->VLRNOT - ( BASICM + ( nOutros ) ) 
               RES->( DBAppend() ) 
               Replace RES->CODNF_ With NF_->NUMERO,; 
                       RES->CODCLI With NF_->CLIENT,; 
                       RES->SERIE_ With "U",; 
                       RES->DATAEM With NF_->DATAEM,; 
                       RES->CONTAB With IF( NF_->NFNULA=="*", 0, NF_->VLRNOT ),; 
                       RES->NATOPE With NF_->NATOPE,; 
                       RES->BASICM With nBaseIcm,; 
                       RES->PERICM With nIcm,; 
                       RES->VLRICM With nVlrIcm,; 
                       RES->ISENTO With nIsento,; 
                       RES->OUTROS With nOutros,; 
                       RES->NFNULA With NF_->NFNULA,; 
                       RES->TABOPE With NF_->TABOPE 
            ENDIF 
         ENDIF 
         NF_->( DBSkip() ) 
     ENDDO 
 
     DBSelectAr( 123 ) 
     DBGoTop() 
 
  ELSEIF aOpcao[ 2 ] == 4 
     nOperacao:= 999 
     nCliFor:=   999999 
     @ 06,10 Say "Codigo de Operacao:" Get nOperacao Pict "999" 
     @ 07,10 Say "Cliente/Fornecedor:" Get nCliFor Pict "999999" 
     READ 
 
  ELSEIF aOpcao[ 2 ] == 2 
     nOperacao:= 999 
     @ 06,10 Say "Codigo de Operacao:" Get nOperacao Pict "999" 
     @ 07,10 Say "Com Emissao de....:" Get dDataEm1 
     @ 07,45 Say "Ate:" Get dDataEm2 
     READ 
 
     aStr:= {{"CODNF_","C",08,00},; 
             {"CODFOR","N",06,00},; 
             {"DESCRI","C",40,00},; 
             {"SERIE_","C",01,00},; 
             {"DATAEM","D",08,00},; 
             {"CONTAB","N",16,02},; 
             {"NATOPE","N",06,03},; 
             {"BASICM","N",16,02},; 
             {"PERICM","N",10,03},; 
             {"VLRICM","N",16,02},; 
             {"ISENTO","N",16,02},; 
             {"OUTROS","N",16,02},; 
             {"NFNULA","C",01,00}} 
     DBCreate( "RES01234.TMP", aStr ) 
     DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RES01234.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DATAEM To Indice 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_ESTOQUE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On Str( YEAR( DATAMV ) ) + Str( MONTH( DATAMV ) ) + Str( DAY( DATAMV ) ) + DOC___ + STR( CODIGO ) To IND1998.NTX Eval {|| Processo() } 
     DBGoTop() 
     EST->( DBSetOrder( 2 ) ) 
     EST->( DBSeek( Str( YEAR( dDataIni ) ) + Str( MONTH( dDataIni ) ) + Str( DAY( dDataIni ) ) + Space( 15 ), .T. ) ) 
     WHILE EST->DATAMV >= dDataIni .AND. EST->DATAMV <= dDataFim .AND. !EST->( EOF() ) 
         IF EST->ENTSAI == "+" .AND. EST->ANULAR == " " .AND. ( EST->DATANF >= dDataEm1 .AND. EST->DATANF <= dDataEm2 ) 
            nValorIcm:= 0 
            nContabil:= 0 
            nOutros:=   0 
            nIsento:=   0 
            nIcm:=      0 
            nReducao:=  0 
            nNumeroNf:=  EST->DOC___ 
            nCodCliFor:= EST->CODIGO 
            nBaseIcm:= 0 
            WHILE EST->DOC___ == nNumeroNf .AND. EST->CODIGO == nCodCliFor 
               IF EST->ANULAR == Space( 1 ) 
                  IF EST->CPROD_ == "***<NOTA>***" 
                     nValorIcm:= EST->VLRICM 
                     nContabil:= EST->VALOR_ 
                     nBaseIcm:=  EST->VLRBAS 
                  ELSE 
                     IF EST->PERICM > 0 
                        nIcm:= EST->PERICM 
                     ENDIF 
                     MPR->( DBSeek( EST->CPROD_ ) ) 
                     IF MPR->IPICOD==4 
                        nIsento:= nIsento + EST->VALOR_ 
                     ELSEIF MPR->IPICOD==2 
                        RED->( DBSetOrder( 1 ) ) 
                        RED->( DBSeek( MPR->TABRED ) ) 
                        nReducao:= EST->VALOR_ - ( ( EST->VALOR_ * ( 100 - RED->PERRED ) ) / 100 ) 
                        nOutros:= nOutros + nReducao 
                     ENDIF 
                     //nValorIcm+= VLRICM 
                     nNumeroNf:=  EST->DOC___ 
                     nCodCliFor:= EST->CODIGO 
                     //nContabil:= nContabil + EST->VALOR_ 
                     //nBaseIcm:= nContabil - ( nOutros + nIsento ) 
                  ENDIF 
               ENDIF 
               EST->( DBSkip() ) 
            ENDDO 
            //nBaseIcm:= ROUND( ( 100 / nIcm ) * nValorIcm, SWSet( 1998 ) ) 
            IF ( nOutros + nIsento ) == 0 
               IF nBaseIcm <= 0
                  nBaseIcm:= nContabil
               ENDIF
            ENDIF 
            IF nOutros > 0 
               nOutros:= nContabil - ( nIsento + nBaseIcm ) 
            ELSEIF nIsento > 0 
               nIsento:= nContabil - ( nBaseIcm + nOutros ) 
            ENDIF 
 
            /* Outros + Isentos */ 
            IF ( nOutros + nIsento ) > 0 
               nBaseIcm:= nContabil - ( nOutros + nIsento ) 
            ENDIF 
 
            EST->( DBSkip( -1 ) ) 
            IF EST->ANULAR == Space( 1 ) .AND. ( EST->CODMV_ == nOperacao .OR. nOperacao == 999 ) 
               RES->( DBAppend() ) 
               OPE->( DBSetOrder( 1 ) ) 
               OPE->( DBSeek( EST->CODMV_ ) ) 
               CLI->( DBSetOrder( 1 ) ) 
               CLI->( DBSeek( EST->CODIGO ) ) 
               FOR->( DBSetOrder( 1 ) ) 
               FOR->( DBSeek( EST->CODIGO ) ) 
               Replace RES->CODNF_ With ALLTRIM( EST->DOC___ ),; 
                       RES->CODFOR With EST->CODIGO,; 
                       RES->DESCRI With IF( OPE->CLIFOR=="C", CLI->DESCRI, FOR->DESCRI ),; 
                       RES->SERIE_ With "U",; 
                       RES->DATAEM With EST->DATAMV,; 
                       RES->CONTAB With nContabil,; 
                       RES->NATOPE With EST->NATOPE,; 
                       RES->BASICM With nBaseIcm,; 
                       RES->PERICM With nIcm,; 
                       RES->VLRICM With nValorIcm,; 
                       RES->ISENTO With nIsento,; 
                       RES->OUTROS With nOutros,; 
                       RES->NFNULA With EST->ANULAR 
            ENDIF 
         ENDIF 
         Mensagem( "Processando registro " + StrZero( recno(), 8, 0 ) + ", Aguarde..." ) 
         EST->( DBSkip() ) 
     ENDDO 
     DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DESCRI + STR( CODFOR ) + CODNF_ To Indic014 
     DBGoTop() 
 
  ELSEIF aOpcao[ 2 ] == 5                     /* Notas de Entrada */ 
 
     DBSelectAr( _COD_ESTOQUE ) 
     cIndice:= "STR( YEAR( DATAMV ) ) + STR( MONTH( DATAMV ) ) + STR( DAY( DATAMV ) )" 
     cIndice:= cIndice + " + Str( CODIGO ) + DOC___" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON &cIndice TO IND0293.RES FOR ENTSAI=="+" .AND. ( DATAMV >= dDataIni .AND. DATAMV <= dDataFim ) .AND. ANULAR==" " Eval {|| Processo() } 
     DBSetOrder( 1 ) 
     cData:= "STR( YEAR( dDataIni ) ) + STR( MONTH( dDataIni ) ) + STR( DAY( dDataIni ) )" 
     cData:= cIndice + Str( 000000 ) 
     DBSeek( cData, .T. ) 
 
  ENDIF 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
     SelecaoImpressora( .F. ) 
  ENDIF 
 
  /* Emissao do relatorio */ 
  Relatorio( AllTrim( cArquivo ) ) 
 
  /* Se estiver dispon¡vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     ViewFile( "TELA0000.TMP" ) 
  ENDIF 
  /* Retorna para porta DEFAULT */ 
  Set( 24, "LPT1" ) 
  DBSelectAr( _COD_ESTOQUE ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/estind01.ntx", "&gdir/estind02.ntx", "&gdir/estind03.ntx", "&gdir/estind04.ntx"     
  #else 
    Set Index To "&GDir\ESTIND01.NTX", "&GDir\ESTIND02.NTX", "&GDir\ESTIND03.NTX", "&GDir\ESTIND04.NTX"     
  #endif
  SWGravar( 5 ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  DBSelectAr( 123 ) 
  DBCloseArea() 
  FDBusevpb( _COD_ATALHO , 2) 
  Return Nil 
 
 
