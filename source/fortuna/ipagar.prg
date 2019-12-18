// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpAPagar 
³ Finalidade  ³ Impressao de Contas a Pagar 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 19/08/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpAPagar() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  Private RepPagQuitacao:= "CTAPGQT.REP" 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Periodo", "Fornecedor", "Banco", "Quitacao", "<Personal>" },; 
                   { " ORDEM       ", "Quitacao", "Vencimento", "Emissao" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  dPag1:= CTOD( "" ) 
  dPag2:= DATE() 
  dCmp1:= CTOD( "" ) 
  dCmp2:= DATE() 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " MOVIMENTO DE CONTAS A PAGAR ", _COR_GET_EDICAO ) 
  WHILE .T. 
      nConta1:= 1 
      nConta2:= 999999 
      cQuit:= "S" 
      nFornec1:= 0 
      nFornec2:= 999999 
      dVenc1:= CTOD( "  /  /  " ) 
      dVenc2:= Date() 
      nBanco1:= 0 
      nBanco2:= 999 
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
                 cArquivo:= RepPagPeriodo 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepPagFornecedor 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepPagBanco 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepPagQuitacao 
 
            CASE aOpcao[ 2 ] == 6 
                 cArquivo:= RepPagPersonal 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
         @ 05, 10 Say "Da Conta..........................:" Get nConta1  Pict "999999" 
         @ 05, 56 Say "At‚:" Get nConta2 Pict "999999" 
         @ 06, 10 Say "Situacao..[S]Quit [N]Pend [ ]Todas:" Get cQuit      Pict "!" Valid cQuit   $ "SN " 
         @ 07, 10 Say "Com Banco do codigo...............:" Get nBanco1    Pict "999" 
         @ 07, 56 Say "At‚:" Get nBanco2 Pict "999" 
         @ 08, 10 Say "Do Fornecedor.....................:" Get nFornec1    Pict "999999" 
         @ 08, 56 Say "At‚:" Get nFornec2 Pict "999999" 
         @ 09, 10 Say "Com Vencimento Entre..............:" Get dVenc1 
         @ 09, 56 Say "e:" Get dVenc2 
         @ 10, 10 Say "Com Pagamento entre...............:" Get dPag1 
         @ 10, 56 Say "e:" Get dPag2 
         @ 11, 10 Say "Data de Competencia entre.........:" Get dCmp1 
         @ 11, 56 Say "e:" Get dCmp2 
         @ 13, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
         @ 13, 10 Say "Arquivo de Relatorio (.REP).......:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  /* Consumo/Industria */ 
  IF cQuit ==  " " 
     cQuit:=   "SN " 
  ENDIF 
 
  /* Se estiver dispon¡vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "FORNECED.PRN" ) 
     Aviso( "Impressao desviada para o arquivo FORNECED.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
 
     IF aOpcao[ 2 ] == 2 
        cIndice:= "VENCIM" 
     ELSEIF aOpcao[ 2 ] == 3 
        cIndice:= "STR( CODFOR ) + DTOS( DATAPG )" 
     ELSEIF aOpcao[ 2 ] == 4 
        cIndice:= "STR( BANCO_ ) + DTOS( DATAPG )" 
     ELSEIF aOpcao[ 2 ] == 5 
        cIndice:= "DATAPG" 
     ENDIF 
 
  ELSEIF aOpcao[ 3 ] == 3 
 
     IF aOpcao[ 2 ] == 2 
        cIndice:= "VENCIM" 
     ELSEIF aOpcao[ 2 ] == 3 
        cIndice:= "STR( CODFOR ) + DTOS( VENCIM )" 
     ELSEIF aOpcao[ 2 ] == 4 
        cIndice:= "STR( BANCO_ ) + DTOS( VENCIM )" 
     ELSEIF aOpcao[ 2 ] == 5 
        cIndice:= "DATAPG" 
     ENDIF 
 
  ELSEIF aOpcao[ 3 ] == 4 
 
     IF aOpcao[ 2 ] == 2 
        cIndice:= "VENCIM" 
     ELSEIF aOpcao[ 2 ] == 3 
        cIndice:= "STR( CODFOR ) + DTOS( EMISS_ )" 
     ELSEIF aOpcao[ 2 ] == 4 
        cIndice:= "STR( BANCO_ ) + DTOS( EMISS_ )" 
     ELSEIF aOpcao[ 2 ] == 5 
        cIndice:= "DATAPG" 
     ENDIF 
 
  ENDIF 
 
 
  dbSelectAr( _COD_BANCO ) 
  dbSetOrder( 1 ) 
  dbSelectAr( _COD_DESPESAS ) 
  dbSetOrder( 1 ) 
  dbSelectAr( _COD_PAGAR ) 
  IF cQuit=="N" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On &cIndice TO INDICE01.TMP Eval {|| Processo() } ; 
                    FOR CODFOR >= nFornec1 .AND. CODFOR <= nFornec2 .AND.; 
                        BANCO_ >= nBanco1  .AND. BANCO_ <= nBanco2  .AND.; 
                        VENCIM >= dVenc1   .AND. VENCIM <= dVenc2   .AND.; 
                        CODIGO >= nConta1  .AND. CODIGO <= nConta2  .AND.; 
                        EMPTY( DATAPG )    .AND. COMPET >= dCmp1 .AND. COMPET <= dCmp2 
  ELSEIF cQuit=="S" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On &cIndice TO INDICE01.TMP Eval {|| Processo() } ; 
                    FOR CODFOR >= nFornec1 .AND. CODFOR <= nFornec2 .AND.; 
                        BANCO_ >= nBanco1  .AND. BANCO_ <= nBanco2  .AND.; 
                        VENCIM >= dVenc1   .AND. VENCIM <= dVenc2   .AND.; 
                        CODIGO >= nConta1  .AND. CODIGO <= nConta2 .AND.; 
                        !EMPTY( DATAPG )   .AND. DATAPG >= dPag1 .AND.; 
                                                 DATAPG <= dPag2 .AND. COMPET >= dCmp1 .AND. COMPET <= dCmp2 
  ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On &cIndice TO INDICE01.TMP Eval {|| Processo() } ; 
                    FOR CODFOR >= nFornec1 .AND. CODFOR <= nFornec2 .AND.; 
                        BANCO_ >= nBanco1  .AND. BANCO_ <= nBanco2  .AND.; 
                        VENCIM >= dVenc1   .AND. VENCIM <= dVenc2   .AND.; 
                        CODIGO >= nConta1  .AND. CODIGO <= nConta2  .AND.; 
                                  DATAPG >= dPag1 .AND. DATAPG <= dPag2 .AND. COMPET >= dCmp1 .AND. COMPET <= dCmp2 
  ENDIF 
 
  Set Relation To CODFOR Into DES, BANCO_ Into BAN 
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
  DBSelectAr( _COD_PAGAR ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/pagind01.ntx", "&gdir/pagind02.ntx", "&gdir/pagind03.ntx"    
  #else 
    Set Index To "&GDIR\PAGIND01.NTX", "&GDIR\PAGIND02.NTX", "&GDIR\PAGIND03.NTX"    
  #endif
  Return Nil 
 
