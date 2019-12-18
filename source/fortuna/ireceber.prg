// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpCtaReceber 
³ Finalidade  ³ Impressao de Contas a receber 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 12/Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpCtaReceber() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
  Local aOpcao 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Periodo", "Cliente", "Banco", "Emissao","Quitacao","Etiqueta","<Pers>" },; 
                   { " ORDEM       ", "<AUTOMATICA>", "N.Fiscal", "Vencimento", "Bloqueto" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
 
  VPBox( 03, 08, 21, 79, " MOVIMENTO DE CONTAS A RECEBER ", _COR_GET_EDICAO ) 
  WHILE .T. 
      cAnuladas:= "N" 
      nDuplic1:= 0 
      nDuplic2:= 999999999 
      cQuit:= "S" 
      nClient1:= 0 
      nClient2:= 999999 
      dQuit1:= CTOD( "  /  /  " ) 
      dQuit2:= Date() 
      dVenc1:= CTOD( "  /  /  " ) 
      dVenc2:= Date() 
      dEmiss1:= CTOD( "  /  /  " ) 
      dEmiss2:= Date() 
      nBanco1:= 0 
      nBanco2:= 799 
      nAtividade:= 0 
      nLimCr1:= 0 
      nLimCr2:= 99999999.99 
      cIndice:= "CDESCR" 
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
                 cArquivo:= RepRecPeriodo 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepRecCliente 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepRecBanco 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepRecEmissao 
 
            CASE aOpcao[ 2 ] == 6 
                 cArquivo:= RepRecQuitacao 
 
            CASE aOpcao[ 2 ] == 7 
                 cArquivo:= RepRecEtiqueta 
 
            CASE aOpcao[ 2 ] == 8 
                 cArquivo:= RepRecPersonal 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
         cAVista:= "N" 
         @ 05, 10 Say "Da Conta ou Nota Fiscal...........:" Get nDuplic1  Pict "999999999" 
         @ 05, 58 Say "At‚:" Get nDuplic2 Pict "999999999" 
         @ 06, 10 Say "Situacao..[S]Quit [N]Pend [ ]Todas:" Get cQuit      Pict "!" Valid cQuit   $ "SN " 
         @ 07, 10 Say "Com Banco do codigo...............:" Get nBanco1    Pict "999" 
         @ 07, 56 Say "At‚:" Get nBanco2 Pict "999" 
         @ 08, 10 Say "Do Cliente........................:" Get nClient1    Pict "999999" 
         @ 08, 56 Say "At‚:" Get nClient2 Pict "999999" 
         @ 09, 10 Say "Com Vencimento Entre..............:" Get dVenc1 
         @ 09, 56 Say "e:" Get dVenc2 
         @ 10, 10 Say "Com Quitacao Entre................:" Get dQuit1 
         @ 10, 56 Say "e:" Get dQuit2 
         @ 11, 10 Say "Com Emissao Entre.................:" Get dEmiss1 
         @ 11, 56 Say "e:" Get dEmiss2 
         @ 12, 10 Say "Incluir Contas Anuladas na Relacao:" Get cAnuladas   Pict "!" Valid cAnuladas $ "SN" 
         @ 13, 10 Say "Incluir Contas A VISTA............:" Get cAVista     Pict "!" Valid cAVista   $ "SN" 
         @ 14, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
         @ 15, 10 Say "Arquivo de Relatorio (.REP).......:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  IF cAnuladas=="S" 
     cNula:= " *" 
  ELSE 
     cNula:= " " 
  ENDIF 
 
  /* Consumo/Industria */ 
  IF cQuit ==  " " 
     cQuit:=   "SN " 
  ENDIF 
 
  DBSelectAr( _COD_DUPAUX ) 
  /* Se estiver dispon¡vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "RECEBER_.PRN" ) 
     Aviso( "Impressao desviada para o arquivo FORNECED.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  /* Organizacao dos arquivos conforme previa selecao Item aOpcao[2] */ 
  IF aOpcao[ 2 ] == 2 
     cIndice:= "STR( YEAR( VENC__ ) ) + STR( MONTH( VENC__ ) ) + STR( DAY( VENC__ ) )" 
  ELSEIF aOpcao[ 2 ] == 3 
     cIndice:= "CDESCR" 
  ELSEIF aOpcao[ 2 ] == 4 
     cIndice:= "StrZero( LOCAL_, 3, 0 )" 
  ELSEIF aOpcao[ 2 ] == 5 
     cIndice:= "STR( YEAR( DATAEM ) ) + STR( MONTH( DATAEM ) ) + STR( DAY( DATAEM ) )" 
  ELSEIF aOpcao[ 2 ] == 6 
     cIndice:= "STR( YEAR( DTQT__ ) ) + STR( MONTH( DTQT__ ) ) + STR( DAY( DTQT__ ) )" 
  ENDIF 
  IF aOpcao[ 3 ] == 2 
     cIndice:= cIndice + " + CDESCR" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= cIndice + " + Str( CODNF_ )" 
  ELSEIF aOpcao[ 3 ] == 4 
     cIndice:= cIndice + " + STR( YEAR( VENC__ ) ) + STR( MONTH( VENC__ ) ) + STR( DAY( VENC__ ) )" 
  ELSEIF aOpcao[ 3 ] == 5 
     cIndice:= cIndice + " + Str( SEQUE_ )" 
  ENDIF 
 
  dbSelectAr(_COD_BANCO) 
  set filter to CODIGO>=nBANCO1 .AND. CODIGO<=nBANCO2 
  dbgotop() 
  Cli->( DBSetOrder( 1 ) ) 
  dbSelectAr(_COD_DUPAUX) 
  set relation to CODNF_ into NF_, CLIENT Into CLI 
  IF cQuit == "S" 
     /* Filtra os registros que interessam */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON &cIndice TO INDICE01.TMP EVAL {|| Processo() } ; 
                                    FOR CLIENT >= nClient1   .AND. CLIENT <= nClient2 .AND.; 
                                        !empty( DTQT__ )     .AND.; 
                                        ( CODNF_ >= nDuplic1 .AND. CODNF_ <= nDuplic2 ) .AND.; 
                                        ( LOCAL_ >= nBanco1  .AND. LOCAL_ <= nBanco2 ) .AND.; 
                                        ( VENC__ >= dVenc1   .AND. VENC__ <= dVenc2 ) .AND.; 
                                        ( DTQT__ >= dQuit1   .AND. DTQT__ <= dQuit2 ) .AND.; 
                                        ( DATAEM >= dEmiss1  .AND. DATAEM <= dEmiss2 ) .AND.; 
                                        NFNULA $ cNula       .AND. IF( cAVista=="N", !(VENC__==DATAEM), .T. ) 
  ELSEIF cQuit == "N" 
     /* Filtra os registros que interessam */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON &cIndice TO INDICE01.TMP EVAL {|| Processo() } ; 
                                    FOR CLIENT >= nClient1   .AND. CLIENT <= nClient2 .AND.; 
                                        EMPTY( DTQT__ )      .AND.; 
                                        ( CODNF_ >= nDuplic1 .AND. CODNF_ <= nDuplic2 ) .AND.; 
                                        ( LOCAL_ >= nBanco1  .AND. LOCAL_ <= nBanco2 ) .AND.; 
                                        ( VENC__ >= dVenc1   .AND. VENC__ <= dVenc2 )   .AND.; 
                                        ( DATAEM >= dEmiss1  .AND. DATAEM <= dEmiss2 ) .AND.; 
                                        NFNULA $ cNula       .AND. IF( cAVista=="N", !(VENC__==DATAEM), .T. ) 
  ELSE 
     /* Filtra os registros que interessam */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON &cIndice TO INDICE01.TMP EVAL {|| Processo() } ; 
                                    FOR CLIENT >= nClient1   .AND. CLIENT <= nClient2 .AND.; 
                                        ( CODNF_ >= nDuplic1 .AND. CODNF_ <= nDuplic2 ) .AND.; 
                                        ( LOCAL_ >= nBanco1  .AND. LOCAL_ <= nBanco2 ) .AND.; 
                                        ( VENC__ >= dVenc1   .AND. VENC__ <= dVenc2 ) .AND.; 
                                        ( DTQT__ >= dQuit1   .AND. DTQT__ <= dQuit2 ) .AND.; 
                                        ( DATAEM >= dEmiss1  .AND. DATAEM <= dEmiss2 ) .AND.; 
                                        NFNULA $ cNula .AND. IF( cAVista=="N", !(VENC__==DATAEM), .T. ) 
  ENDIF 
  DBGoTop() 
 
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
  dbSelectAr(_COD_BANCO) 
  Set Filter To 
  DBSelectAr( _COD_DUPAUX ) 
  Set Relation To 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx", "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx", "&gdir/dpaind05.ntx"      
  #else 
    SET INDEX TO "&GDIR\DPAIND01.NTX", "&GDIR\DPAIND02.NTX", "&GDIR\DPAIND03.NTX", "&GDIR\DPAIND04.NTX", "&GDir\DPAIND05.NTX"      
  #endif
  Return Nil 
 
 
