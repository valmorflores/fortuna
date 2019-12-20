// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � ImpResumo() 
� Finalidade  � Resumo de movimentacoes financeiras com estoque 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Fevereiro/1995 
� Atualizacao � Agosto/1998 
��������������� 
*/ 
Function ImpResumo() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Sintetico", "Analitico", "<Personal>" },; 
                   { " ORDEM       ", "<AUTOMATICA>" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " RESUMO DE MOVIMENTACOES ", _COR_GET_EDICAO ) 
  WHILE .T. 
      dDataIni:= DATE() 
      dDataFim:= DATE() 
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
                 cArquivo:= RepResumo 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepResumo2 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepResumoP 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
         @ 06, 10 Say "Periodo de....:" Get dDataIni 
         @ 06, 36 Say "Ate:" Get dDataFim 
         @ 07, 10 Say "��������������������������������������������������������������������" 
         @ 08, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  DBSelectAr( _COD_ESTOQUE ) 
  /* Se estiver dispon�vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "RESUMO.PRN" ) 
     Aviso( "Impressao desviada para o arquivo RESUMO.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "CODMV_" 
  ENDIF 
 
  IF aOpcao[ 2 ] == 2 
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
             {"TABOPE","N",04,00},; 
             {"NFNULA","C",01,00}} 
     DBCreate( "RES01234.TMP", aStr ) 
     DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RES01234.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DATAEM To Indice 
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
 
     /* * * * * * * * * * */ 
     /*    S A I D A S    */ 
     /* * * * * * * * * * */ 
 
     WHILE DATAEM >= dDataIni .AND. DATAEM <= dDataFim 
         IF TIPONF == cEntSai 
            nContabil:= NF_->VLRTOT 
            nOutros:= 0 
            nIsento:= 0 
            nIcm:= 0 
            OPE->( DBSetOrder( 1 ) ) 
            OPE->( DBSeek( NF_->TABOPE ) ) 
            nVlrIcm:= 0 
            WHILE PNF->CODNF_ == NF_->NUMERO 
                 IF PNF->PERICM > 0 
                    nIcm:= PNF->PERICM 
                 ENDIF 
                 IF PNF->IPICOD==4 .OR. OPE->CALICM=="N" 
                    nIsento:= nIsento + PNF->PRECOT 
                 ELSEIF PNF->IPICOD==2 
                    RED->( DBSetOrder( 1 ) ) 
                    RED->( DBSeek( MPR->TABRED ) ) 
                    nReducao:= PNF->PRECOT - ( ( PNF->PRECOT * ( 100 - RED->PERRED ) ) / 100 ) 
                    nOutros:= nOutros + nReducao 
                 ELSE 
                    nVlrIcm:= nVlrIcm + PNF->VLRICM 
                 ENDIF 
                 PNF->( DBSkip() ) 
            ENDDO 
 
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
 
            nVlrIcm:= IF( nVlrIcm==0, NF_->VLRICM, nVlrIcm ) 
            //nIsento:= NF_->VLRNOT - ( BASICM + ( nOutros ) ) 
            RES->( DBAppend() ) 
            Replace RES->CODNF_ With NF_->NUMERO,; 
                    RES->CODCLI With NF_->CLIENT,; 
                    RES->SERIE_ With "U",; 
                    RES->DATAEM With NF_->DATAEM,; 
                    RES->CONTAB With NF_->VLRNOT,; 
                    RES->NATOPE With NF_->NATOPE,; 
                    RES->BASICM With nBaseIcm,; 
                    RES->PERICM With nIcm,; 
                    RES->VLRICM With nVlrIcm,; 
                    RES->ISENTO With nIsento,; 
                    RES->OUTROS With nOutros,; 
                    RES->NFNULA With NF_->NFNULA,; 
                    RES->TABOPE With NF_->TABOPE 
         ENDIF 
         Mensagem( "Processando nota fiscal " + StrZero( NF_->NUMERO, 8, 0 ) + ", Aguarde..." ) 
         NF_->( DBSkip() ) 
 
     ENDDO 
 
     DBSelectAr( 123 ) 
     aSaidas:= 0 
     /* CONTABIL, BASE, ICM, ISENTO, OUTRAS */ 
     aSaidas:= { 0, 0, 0, 0, 0 } 
     aSaiDia:= { 0, 0, 0, 0, 0 } 
     aSaiDiaExtra:= {} 
     aSaiExtra:= 0 
     aSaiExtra:= {} 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On STR( YEAR( DATAEM ) ) + STR( MONTH( DATAEM ) ) + STR( DAY( DATAEM ) ) + STR( NATOPE ) + STR( TABOPE ) To INDICE98 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To INDICE98 
     DBGoTop() 
     WHILE !EOF() 
         IF NFNULA==" " 
            IF ( NATOPE >= 5.120 .AND. NATOPE <= 5.129 ) .OR.; 
               ( NATOPE >= 6.120 .AND. NATOPE <= 6.129 ) 
               aSaidas[ 1 ]:= aSaidas[ 1 ] + CONTAB 
               aSaidas[ 2 ]:= aSaidas[ 2 ] + BASICM 
               aSaidas[ 3 ]:= aSaidas[ 3 ] + VLRICM 
               aSaidas[ 4 ]:= aSaidas[ 4 ] + ISENTO 
               aSaidas[ 5 ]:= aSaidas[ 5 ] + OUTROS 
               IF DATAEM == dDataFim 
                  aSaiDia[ 1 ]:= aSaiDia[ 1 ] + CONTAB 
                  aSaiDia[ 2 ]:= aSaiDia[ 2 ] + BASICM 
                  aSaiDia[ 3 ]:= aSaiDia[ 3 ] + VLRICM 
                  aSaiDia[ 4 ]:= aSaiDia[ 4 ] + ISENTO 
                  aSaiDia[ 5 ]:= aSaiDia[ 5 ] + OUTROS 
               ENDIF 
            ELSE 
               IF ( nPos:= ASCAN( aSaiExtra, {|x| x[1] == TABOPE } ) ) > 0 
                  aSaiExtra[ nPos ][ 2 ][ 1 ]:= aSaiExtra[ nPos ][ 2 ][ 1 ] + CONTAB 
                  aSaiExtra[ nPos ][ 2 ][ 2 ]:= aSaiExtra[ nPos ][ 2 ][ 2 ] + BASICM 
                  aSaiExtra[ nPos ][ 2 ][ 3 ]:= aSaiExtra[ nPos ][ 2 ][ 3 ] + VLRICM 
                  aSaiExtra[ nPos ][ 2 ][ 4 ]:= aSaiExtra[ nPos ][ 2 ][ 4 ] + ISENTO 
                  aSaiExtra[ nPos ][ 2 ][ 5 ]:= aSaiExtra[ nPos ][ 2 ][ 5 ] + OUTROS 
                  IF !( nPos:= ASCAN( aSaiDiaExtra, {|x| x[1] == TABOPE } ) ) > 0 
                     AAdd( aSaiDiaExtra, { TABOPE, { 0, 0, 0, 0, 0 } } ) 
                  ENDIF 
               ELSE 
                  AAdd( aSaiExtra, { TABOPE, { CONTAB, BASICM, VLRICM, ISENTO, OUTROS } } ) 
                  IF !( nPos:= ASCAN( aSaiDiaExtra, {|x| x[1] == TABOPE } ) ) > 0 
                     AAdd( aSaiDiaExtra, { TABOPE, { 0, 0, 0, 0, 0 } } ) 
                  ENDIF 
               ENDIF 
               IF DATAEM == dDataFim 
                  IF ( nPos:= ASCAN( aSaiDiaExtra, {|x| x[1] == TABOPE } ) ) > 0 
                     aSaiDiaExtra[ nPos ][ 2 ][ 1 ]:= aSaiDiaExtra[ nPos ][ 2 ][ 1 ] + CONTAB 
                     aSaiDiaExtra[ nPos ][ 2 ][ 2 ]:= aSaiDiaExtra[ nPos ][ 2 ][ 2 ] + BASICM 
                     aSaiDiaExtra[ nPos ][ 2 ][ 3 ]:= aSaiDiaExtra[ nPos ][ 2 ][ 3 ] + VLRICM 
                     aSaiDiaExtra[ nPos ][ 2 ][ 4 ]:= aSaiDiaExtra[ nPos ][ 2 ][ 4 ] + ISENTO 
                     aSaiDiaExtra[ nPos ][ 2 ][ 5 ]:= aSaiDiaExtra[ nPos ][ 2 ][ 5 ] + OUTROS 
                  ELSE 
                     AAdd( aSaiDiaExtra, { TABOPE, { CONTAB, BASICM, VLRICM, ISENTO, OUTROS } } ) 
                  ENDIF 
               ENDIF 
            ENDIF 
         ENDIF 
         Mensagem( "Somando as saidas "+ Str( RECNO() ) + ", aguarde...." ) 
         DBSkip() 
     ENDDO 
     DBCloseArea() 
 
     /* * * * * * * * * * */ 
     /*  E N T R A D A S  */ 
     /* * * * * * * * * * */ 
     aStr:= {{"CODNF_","C",08,00},; 
             {"CODFOR","N",06,00},; 
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
     DBCreate( "RS101224.TMP", aStr ) 
     DBSelectAr( 122 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RS101224.TMP Alias RS1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On DATAEM To Indice 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_ESTOQUE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On Str( YEAR( DATAMV ) ) + Str( MONTH( DATAMV ) ) + Str( DAY( DATAMV ) ) + DOC___ + Str( CODMV_, 3, 0 ) To IND1998.NTX Eval {|| Processo() } 
     DBGoTop() 
     EST->( DBSetOrder( 2 ) ) 
     EST->( DBSeek( Str( YEAR( dDataIni ) ) + Str( MONTH( dDataIni ) ) + Str( DAY( dDataIni ) ) + Space( 15 ) + "   ", .T. ) ) 
     WHILE EST->DATAMV >= dDataIni .AND. EST->DATAMV <= dDataFim .AND. !EST->( EOF() ) 
         IF EST->ENTSAI == "+" .AND. EST->ANULAR == " " 
            nValorIcm:= 0 
            nContabil:= 0 
            nOutros:= 0 
            nIsento:= 0 
            nIcm:= 0 
            nReducao:= 0 
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
                     //nBaseIcm:= nBaseIcm + EST->VLRBAS 
                  ENDIF 
               ENDIF 
               EST->( DBSkip() ) 
            ENDDO 
            IF ( nOutros + nIsento ) == 0 
               nBaseIcm:= nContabil 
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
            IF EST->ANULAR == Space( 1 ) 
               RS1->( DBAppend() ) 
               Replace RS1->CODNF_ With ALLTRIM( EST->DOC___ ),; 
                       RS1->CODFOR With EST->CODIGO,; 
                       RS1->SERIE_ With "U",; 
                       RS1->DATAEM With EST->DATAMV,; 
                       RS1->CONTAB With nContabil,; 
                       RS1->NATOPE With EST->NATOPE,; 
                       RS1->BASICM With nBaseIcm,; 
                       RS1->PERICM With nIcm,; 
                       RS1->VLRICM With nValorIcm,; 
                       RS1->ISENTO With nIsento,; 
                       RS1->OUTROS With nOutros,; 
                       RS1->NFNULA With EST->ANULAR,; 
                       RS1->TABOPE With EST->CODMV_ 
            ENDIF 
         ENDIF 
         Mensagem( "Processando registro " + StrZero( recno(), 8, 0 ) + ", Aguarde..." ) 
         EST->( DBSkip() ) 
     ENDDO 
     DBSelectAr( 122 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On STR( YEAR( DATAEM ) ) + STR( MONTH( DATAEM ) ) + STR( DAY( DATAEM ) ) + STR( NATOPE ) + STR( TABOPE ) To INDICE99 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To INDICE99 
     DBGoTop() 
     aEntradas:= 0 
                 /* CONTABIL,BASE,ICM,ISENTO,OUTRAS */ 
     aEntDia:=      { 0, 0, 0, 0, 0 } 
     aEntDiaExtra:= {} 
     aEntradas:=    { 0, 0, 0, 0, 0 } 
     aEntExtra:=    {} 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On STR( YEAR( DATAEM ) ) + STR( MONTH( DATAEM ) ) + STR( DAY( DATAEM ) ) + STR( TABOPE ) + STR( NATOPE ) To IN98 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To IN98 
     DBGoTop() 
     WHILE !EOF() 
         IF NFNULA==" " 
            IF ( nPos:= ASCAN( aEntExtra, {|x| x[1] == TABOPE } ) ) > 0 
               aEntExtra[ nPos ][ 2 ][ 1 ]:= aEntExtra[ nPos ][ 2 ][ 1 ] + CONTAB 
               aEntExtra[ nPos ][ 2 ][ 2 ]:= aEntExtra[ nPos ][ 2 ][ 2 ] + BASICM 
               aEntExtra[ nPos ][ 2 ][ 3 ]:= aEntExtra[ nPos ][ 2 ][ 3 ] + VLRICM 
               aEntExtra[ nPos ][ 2 ][ 4 ]:= aEntExtra[ nPos ][ 2 ][ 4 ] + ISENTO 
               aEntExtra[ nPos ][ 2 ][ 5 ]:= aEntExtra[ nPos ][ 2 ][ 5 ] + OUTROS 
            ELSE 
               AAdd( aEntExtra, { TABOPE, { CONTAB, BASICM, VLRICM, ISENTO, OUTROS } } ) 
               IF !( nPos:= ASCAN( aEntDiaExtra, {|x| x[1] == TABOPE } ) ) > 0 
                  AAdd( aEntDiaExtra, { TABOPE, { 0, 0, 0, 0, 0 } } ) 
               ENDIF 
            ENDIF 
            IF DATAEM == dDataFim 
               IF ( nPos2:= ASCAN( aEntDiaExtra, {|x| x[1] == TABOPE } ) ) > 0 
                  aEntDiaExtra[ nPos2 ][ 2 ][ 1 ]:= aEntDiaExtra[ nPos2 ][ 2 ][ 1 ] + CONTAB 
                  aEntDiaExtra[ nPos2 ][ 2 ][ 2 ]:= aEntDiaExtra[ nPos2 ][ 2 ][ 2 ] + BASICM 
                  aEntDiaExtra[ nPos2 ][ 2 ][ 3 ]:= aEntDiaExtra[ nPos2 ][ 2 ][ 3 ] + VLRICM 
                  aEntDiaExtra[ nPos2 ][ 2 ][ 4 ]:= aEntDiaExtra[ nPos2 ][ 2 ][ 4 ] + ISENTO 
                  aEntDiaExtra[ nPos2 ][ 2 ][ 5 ]:= aEntDiaExtra[ nPos2 ][ 2 ][ 5 ] + OUTROS 
               ELSE 
                  AAdd( aEntDiaExtra, { TABOPE, { CONTAB, BASICM, VLRICM, ISENTO, OUTROS } } ) 
               ENDIF 
            ENDIF 
         ENDIF 
         Mensagem( "Somando as Entradas "+ Str( RECNO() ) + ", aguarde...." ) 
         DBSkip() 
     ENDDO 
     aEntDiaExtra:= ASORT( aEntDiaExtra,,,{|x,y| x[1] < y[1] } ) 
     aEntExtra:=    ASORT( aEntExtra,,,{|x,y| x[1] < y[1] } ) 
     DBCloseArea() 
 
  ELSEIF aOpcao[ 2 ] == 3 
 
     DBSelectAr( _COD_DUPAUX ) 
     DBSetOrder( 1 ) 
 
     DBSelectAr( _COD_NFISCAL ) 
     DBSetOrder( 3 ) 
     Set Relation To NUMERO Into DPA 
 
     aStr:= {{"TABOPE","N",04,00},; 
             {"DESOPE","C",30,00},; 
             {"TABCND","N",04,00},; 
             {"DESCND","C",30,00},; 
             {"TABPRE","N",04,00},; 
             {"DESPRE","C",30,00},; 
             {"PRAZO_","N",06,00},; 
             {"VLRPER","N",16,02},; 
             {"VLRDIA","N",16,02},; 
             {"DIRDIA","N",16,02},; 
             {"DIRPER","N",16,02},; 
             {"VENCIM","D",08,00}} 
     DBCreate( "RES3252.TMP", aStr ) 
 
     CND->( DBSetOrder( 1 ) ) 
     OPE->( DBSetOrder( 1 ) ) 
     PRE->( DBSetOrder( 1 ) ) 
 
     DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Use RES3252.TMP Alias RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On STR( TABOPE, 3, 0 ) + STR( PRAZO_, 3, 0 ) To IND99345.TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Set Index To IND99345.TMP 
     DBSelectAr( _COD_NFISCAL ) 
     DBSeek( dDataIni, .T. ) 
     WHILE DATAEM >= dDataIni .AND. DATAEM <= dDataFim .AND. !EOF() 
         cForma:= STR( NF_->TABOPE, 3, 0 ) + STR( NF_->PRAZOA, 3, 0 ) 
         IF NF_->NFNULA==Space(1) .AND. ( ( NF_->NATOPE >= 5.120 .AND.; 
                                            NF_->NATOPE <= 5.129 ) .OR.; 
                                          ( NF_->NATOPE >= 6.120 .AND.; 
                                            NF_->NATOPE <= 6.129 ) ) 
            IF !RES->( DBSeek( cForma ) ) 
               RES->( DBAppend() ) 
            ENDIF 
            CND->( DBSeek( NF_->TABCND ) ) 
            OPE->( DBSeek( NF_->TABOPE ) ) 
            IF RES->( netrlock() ) 
               Replace RES->TABOPE With NF_->TABOPE,; 
                       RES->TABCND With NF_->TABCND,; 
                       RES->PRAZO_ With NF_->PRAZOA,; 
                       RES->DESOPE With OPE->DESCRI,; 
                       RES->DESCND With CND->DESCRI,; 
                       RES->VLRPER With RES->VLRPER + NF_->VLRTOT,; 
                       RES->VLRDIA With RES->VLRDIA + IF( NF_->DATAEM == dDataFim, NF_->VLRTOT, 0 ),; 
                       RES->DIRDIA With RES->DIRDIA + IF( NF_->DATAEM == dDataFim .AND. NF_->VENIN_ + NF_->VENEX_ == 0, NF_->VLRTOT, 0 ),; 
                       RES->DIRPER With RES->DIRPER + IF( NF_->VENIN_ + NF_->VENEX_ == 0, NF_->VLRTOT, 0 ),; 
                       RES->VENCIM With NF_->DATAEM + NF_->PRAZOA 
            ENDIF 
         ENDIF 
         NF_->( DBSkip() ) 
    ENDDO 
    DBSelectAr( 133 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    Index On DESOPE To IND29993.TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    Set Index To IND29993.TMP 
 
  ENDIF 
 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
     SelecaoImpressora( .F. ) 
  ENDIF 
 
  /* Emissao do relatorio */ 
  Relatorio( AllTrim( cArquivo ) ) 
 
  DBSelectAr( 133 ) 
  dbCloseArea() 
 
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
  DBSelectAr( _COD_ESTOQUE ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/estind01.ntx", "&gdir/estind02.ntx", "&gdir/estind03.ntx", "&gdir/estind04.ntx"     
  #else 
    Set Index To "&GDir\ESTIND01.NTX", "&GDir\ESTIND02.NTX", "&GDir\ESTIND03.NTX", "&GDir\ESTIND04.NTX"     
  #endif
  Return Nil 
 
