

// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpFluxo() 
³ Finalidade  ³ Relacao de Fluxo Financeiro 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Fevereiro/1995 
³ Atualizacao ³ Outubro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpFluxo() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo, dData1:= CTOD( "  /  /  "  ), dData2:= DATE() 
  Local nContaNumero:= 0, cTipoConta:= "T" 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Saldos", "Extrato", "Movimentos", "Resumo", "Integracao", "<Personal>" },;
                   { " ORDEM       ", "Data", "Conta" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " FLUXO FINANCEIRO ", _COR_GET_EDICAO ) 
  WHILE .T. 
      cIndice:= "NCONTA" 
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
                 cArquivo:= RepFlxSaldos 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepFlxExtrato 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepFlxMovimentos 

            CASE aOpcao[ 2 ] == 5
                 cArquivo:= "FLUXOBAL.REP"

            CASE aOpcao[ 2 ] == 6
                 cArquivo:= "INTEGRAL.REP"

            CASE aOpcao[ 2 ] == 7
                 cArquivo:= RepFlxPersonal 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
 
 
         @ 05, 10 Say "Do Periodo entre.:" Get dData1 
         @ 05, 41 Say "At‚:" Get dData2 
         IF aOpcao[ 2 ] == 3 
            @ 06, 10 Say "Conta.............:" Get nContaNumero Pict "9999" 
            @ 07, 10 Say "Tipo Conta........:" Get cTipoConta Pict "!" Valid cTipoConta $ "RDT" 
         ENDIF 
         @ 08, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
         @ 09, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
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
     Set( 24, "FLUXO.PRN" ) 
     Aviso( "Impressao desviada para o arquivo FLUXO.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  DBSelectAr( _COD_MOVIMENTO ) 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "DATA__" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= "TCONTA + StrZero( NCONTA, 4, 0 )" 
  ENDIF 
 
  IF aOpcao[ 2 ] == 3
     nSaldoAnterior:= 0 
     DBGoTop() 
     WHILE !EOF() 
         IF DATA__ < dData1 .AND.; 
            NCONTA == nContaNumero .AND.; 
            TCONTA == cTipoConta 
            nSaldoAnterior:= nSaldoAnterior - DEBITO 
            nSaldoAnterior:= nSaldoAnterior + CREDIT 
         ENDIF 
         DBSkip() 
     ENDDO 

     INDEX ON &cIndice TO INDICE01.TMP FOR DATA__ >= dData1 .AND.;
                                           DATA__ <= dData2 .AND.; 
                                           NCONTA == nContaNumero .AND.; 
                                           TCONTA == cTipoConta 

     IF cTipoConta=="T"
        BAN->( DBSetOrder( 1 ) ) 
        BAN->( DBSeek( nContaNumero ) ) 
        PRIVATE cContaDescricao:= BAN->DESCRI 
     ELSEIF cTipoConta=="R" 
        REC->( DBSetOrder( 1 ) ) 
        REC->( DBSeek( nContaNumero ) ) 
        PRIVATE cContaDescricao:= REC->DESCRI 
     ELSEIF cTipoConta=="D" 
        DES->( DBSetOrder( 1 ) ) 
        DES->( DBSeek( nContaNumero ) ) 
        PRIVATE cContaDescricao:= DES->DESCRI 
     ENDIF 
  ELSEIF aOpcao[ 2 ] == 5

     // MOVIMENTO
     DBSelectAr( _COD_MOVIMENTO )
     INDEX ON NCONTA TO INDICE23.TMP
     DBGoTop()

     // RELATORIO DE RESUMO
     aStr:= { { "ORDEM_", "N", 09, 00 },;
              { "DESCRI", "C", 30, 00 },;
              { "QUANT_", "N", 05, 00 },;
              { "VALOR_", "N", 16, 02 },;
              { "CODIGO", "N", 04, 00 },;
              { "TIPO__", "C", 01, 00 } }
     DBCreate( "TEMP.TMP", aStr )
     DBSelectAr( 123 )
     USE TEMP.TMP ALIAS TMP
     INDEX ON ORDEM_ TO I210023
     INDEX ON strzero( CODIGO,4,0)+TIPO__ TO I210024
     SET INDEX TO I210023,I210024

     // Periodo
     DBSelectAr( 123 )
     DBAppend()
     Replace DESCRI With DTOC( dData1 ) + " A " + DTOC( dData2 )

     // MOVIMENTACAO DE RECEITAS =============================
     // Receitas referente atrasados
     nRecAtrasados:= 0
     nRecMes:= 0
     nRecAdiantado:= 0
     nRecRecuperado:= 0
     nQtdRecMes:= 0
     nQtdRecAtr:= 0
     nQtdRedAdian:= 0
     nQtdRecuperado:= 0
     DBSelectAr( _COD_DUPAUX )
     DBGoTop()
     WHILE !EOF()
         IF DTQT__ >= dData1 .AND. DTQT__ <= dData2 .AND. NFNULA == " " .AND. LOCAL_ < 800
            IF DTQT__ == VENC__                  // Recebido em dia
               nRecMes:= nRecMes + VLR___
               ++nQtdRecMes
            ELSEIF DTQT__ < VENC__                   // Recebido adiantado
               nRecAdiantado:= nRecAdiantado + VLR___
               ++nQtdRedAdian
            ELSEIF DTQT__ > VENC__                   // Recebido atrasado
               nRecAtrasados:= nRecAtrasados + VLR___
               ++nQtdRecAtr
            ENDIF
         ENDIF
         DBSkip()
     ENDDO
     DBSelectAr( 123 )

     DBAppend()
     Replace DESCRI With " * * * RECEITAS * * * ", TIPO__ With "C"


     DBAppend()
     Replace DESCRI With "DOCUMENTOS DO PERIODO (EM DIA)", VALOR_ With nRecMes,       QUANT_ With nQtdRecMes, TIPO__ With "R"
     DBAppend()
     Replace DESCRI With "DOCUMENTOS ATRASADOS          ", VALOR_ With nRecAtrasados, QUANT_ With nQtdRecAtr, TIPO__ With "R"
     DBAppend()
     Replace DESCRI With "DOCUMENTOS ANTECIPADOS        ", VALOR_ With nRecAdiantado, QUANT_ With nQtdRedAdian, TIPO__ With "R"
     DBCommitAll()

     // MOVIMENTACAO DE DESPESAS =============================
     DBAppend()
     Replace DESCRI With " * * * DESPESAS * * * ", TIPO__ With "C"

     DBSelectAr( 123 )
     DBSetOrder( 2 )

     DBSelectAr( _COD_MOVIMENTO )
     DBGoTop()
     WHILE !EOF()
           IF DATA__ >= dData1 .AND. DATA__ <= dData2 .AND. TCONTA == "D"
              IF !TMP->( DBSeek( STRZERO( MOV->NCONTA, 4, 0 ) + MOV->TCONTA  ) )
                 TMP->( DBAppend() )
                 Replace TMP->CODIGO With NCONTA,;
                         TMP->DESCRI With DCONTA,;
                         TMP->TIPO__ With TCONTA
              ELSE
                 TMP->( RLOCK() )
              ENDIF
              Replace TMP->VALOR_ With TMP->VALOR_ + CREDIT - DEBITO
              Replace TMP->QUANT_ With TMP->QUANT_ + 1
           ENDIF
           DBSkip()
     ENDDO

     DBSelectAr( 123 )
     DBAppend()
     Replace DESCRI With " * * * BANCOS * * * ", TIPO__ With "C"

     DBSelectAr( _COD_MOVIMENTO )
     DBGoTop()
     WHILE !EOF()
           IF DATA__ <= dData2 .AND. TCONTA == "T" .AND. NCONTA < 800
              IF !TMP->( DBSeek( STRZERO( MOV->NCONTA, 4, 0 ) + "B" ) )
                 TMP->( DBAppend() )
                 Replace TMP->CODIGO With NCONTA,;
                         TMP->DESCRI With DCONTA,;
                         TMP->TIPO__ With "B"
              ELSE
                 TMP->( RLOCK() )
              ENDIF
              Replace TMP->VALOR_ With TMP->VALOR_ + CREDIT - DEBITO
              Replace TMP->QUANT_ With TMP->QUANT_ + 1
           ENDIF
           DBSkip()
     ENDDO

     DBSelectAr( 123 )
     SET INDEX TO
     DBGoTop()

  ELSEIF aOpcao[ 2 ] == 6

     // MOVIMENTO
     DBSelectAr( _COD_MOVIMENTO )
     INDEX ON NCONTA TO INDICE23.TMP
     DBGoTop()

     // RELATORIO DE RESUMO
     aStr:= { { "ORDEM_", "N", 09, 00 },;
              { "DESCRI", "C", 30, 00 },;
              { "QUANT_", "N", 05, 00 },;
              { "VALOR_", "N", 16, 02 },;
              { "CODIGO", "N", 04, 00 },;
              { "TIPO__", "C", 01, 00 } }
     DBCreate( "TEMP.TMP", aStr )
     DBSelectAr( 123 )
     USE TEMP.TMP ALIAS TMP
     INDEX ON ORDEM_ TO I210023
     INDEX ON strzero( CODIGO,4,0)+TIPO__ TO I210024
     SET INDEX TO I210023,I210024

     // Periodo
     DBSelectAr( 123 )
     DBAppend()
     Replace DESCRI With DTOC( dData1 ) + " A " + DTOC( dData2 )

     // MOVIMENTACAO DE RECEITAS =============================
     // Receitas referente atrasados
     nRecAtrasados:= 0
     nRecMes:= 0
     nRecAdiantado:= 0
     nRecRecuperado:= 0
     nQtdRecMes:= 0
     nQtdRecAtr:= 0
     nQtdRedAdian:= 0
     nQtdRecuperado:= 0
     DBSelectAr( _COD_DUPAUX )
     DBGoTop()
     WHILE !EOF()
         IF DTQT__ >= dData1 .AND. DTQT__ <= dData2 .AND. NFNULA == " " .AND. LOCAL_ < 800
            IF DTQT__ == VENC__
               nRecMes:= nRecMes + VLR___
               ++nQtdRecMes
            ELSEIF DTQT__ < VENC__             // Recebido adiantado
               nRecAdiantado:= nRecAdiantado + VLR___
               ++nQtdRedAdian
            ELSEIF DTQT__ > VENC__          // Recebido atrasado
               nRecAtrasados:= nRecAtrasados + VLR___
               ++nQtdRecAtr
            ENDIF
         ENDIF
         DBSkip()
     ENDDO
     DBSelectAr( 123 )

     DBAppend()
     Replace DESCRI With " * * * RECEITAS * * * ", TIPO__ With "C"

     DBAppend()
     Replace DESCRI With "DOCUMENTOS DO PERIODO (EM DIA)", VALOR_ With nRecMes,       QUANT_ With nQtdRecMes, TIPO__ With "R"
     DBAppend()
     Replace DESCRI With "DOCUMENTOS ATRASADOS          ", VALOR_ With nRecAtrasados, QUANT_ With nQtdRecAtr, TIPO__ With "R"
     DBAppend()
     Replace DESCRI With "DOCUMENTOS ANTECIPADOS        ", VALOR_ With nRecAdiantado, QUANT_ With nQtdRedAdian, TIPO__ With "R"
     DBCommitAll()

     // MOVIMENTACAO DE DESPESAS =============================
     DBAppend()
     Replace DESCRI With " * * * DESPESAS * * * ", TIPO__ With "C"

     DBSelectAr( 123 )
     DBSetOrder( 2 )

     DES->( dbSetOrder( 1 ) )
     DBSelectAr( _COD_PAGAR )
     DBSetOrder( 4 ) 
     DBGoTop()
     WHILE !EOF()
           IF PAG->DATAPG >= dData1 .AND. PAG->DATAPG <= dData2 
              IF !TMP->( DBSeek( STRZERO( PAG->CODFOR, 4, 0 ) + "D"  ) )
                 DES->( DbSeek( PAG->CODFOR ) )
                 TMP->( DBAppend() )
                 Replace TMP->CODIGO With PAG->CODFOR,;
                         TMP->DESCRI With DES->DESCRI,;
                         TMP->TIPO__ With "D"
              ELSE
                 TMP->( RLOCK() )
              ENDIF
              Replace TMP->VALOR_ With TMP->VALOR_ + ( PAG->VALOR_ + PAG->JUROS_ )
              Replace TMP->QUANT_ With TMP->QUANT_ + 1
              mensagem( "Registrando " +  str( PAG->CODFOR ) + ":" + str( PAG->VALOR_ ) + " aguarde..." )
           ENDIF

           DBSkip()
     ENDDO

     DBSelectAr( 123 )
     DBAppend()
     Replace DESCRI With " * * * BANCOS * * * ", TIPO__ With "C"

     DBSelectAr( _COD_MOVIMENTO )
     DBGoTop()
     WHILE !EOF()
           IF DATA__ <= dData2 .AND. TCONTA == "T" .AND. NCONTA < 800
              IF !TMP->( DBSeek( STRZERO( MOV->NCONTA, 4, 0 ) + "B" ) )
                 TMP->( DBAppend() )
                 Replace TMP->CODIGO With NCONTA,;
                         TMP->DESCRI With DCONTA,;
                         TMP->TIPO__ With "B"
              ELSE
                 TMP->( RLOCK() )
              ENDIF
              Replace TMP->VALOR_ With TMP->VALOR_ + CREDIT - DEBITO
              Replace TMP->QUANT_ With TMP->QUANT_ + 1
           ENDIF
           DBSkip()
     ENDDO

     DBSelectAr( 123 )
     SET INDEX TO
     DBGoTop()


  ELSE
     INDEX ON &cIndice TO INDICE01.TMP FOR DATA__ >= dData1 .AND. DATA__ <= dData2
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
  SWGravar( 5 ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 

  DBSelectAr( _COD_MOVIMENTO )
  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/movind01.ntx", "&gdir/movind02.ntx"   
  #else 
    Set Index To "&GDIR\MOVIND01.NTX", "&GDIR\MOVIND02.NTX"   
  #endif
  Return Nil 
 
 
