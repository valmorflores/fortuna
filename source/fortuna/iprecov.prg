// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpPrecoVenda() 
³ Finalidade  ³ Lista de Precos de Venda 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Fevereiro/1995 
³ Atualizacao ³ Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpPrecoVenda() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Simples", "Completo", "Mod.A", "Mod.B", "Mod.C", "Mod.D", "<Personal>" },; 
                   { " ORDEM       ", "Nome", "Grupo", "Cod.Fabrica", "Origem+Grupo", "Fornecedor", "CFN" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " LISTAGEM DE PRECOS DE VENDA ", _COR_GET_EDICAO ) 
  WHILE .T. 
      cCodigo1:= "0000000" 
      cCodigo2:= "9999999" 
      cComSaldo:= " " 
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
                 cArquivo:= RepPVDSimples 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepPVDCompleto 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepPVDA 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepPVDB 
 
            CASE aOpcao[ 2 ] == 6 
                 cArquivo:= RepPVDC 
 
            CASE aOpcao[ 2 ] == 7 
                 cArquivo:= RepPVDD 
 
            CASE aOpcao[ 2 ] == 8 
                 cArquivo:= RepPVDPersonal 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
         @ 05, 10 Say "Do Codigo.....................:" Get cCodigo1 Pict "@R 999-9999" 
         @ 05, 51 Say "At‚:" Get cCodigo2 Pict "@R 999-9999" 
         @ 06, 10 Say "Saldo: [C]Com/[S]Sem/[ ]Todos.:" Get cComSaldo Pict "!" Valid cComSaldo $ "CS " 
         @ 07, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
         @ 08, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            TabelaPreco() 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  DBSelectAr( _COD_MPRIMA ) 
  /* Se estiver dispon¡vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "PRECOV.PRN" ) 
     Aviso( "Impressao desviada para o arquivo PRECOV.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 2 ] == 6 
 
     /* Se a tabela for C - Seleciona o Arquivo de Tabela de Preco Auxiliar */ 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 1 ) 
     DBSelectAr( _COD_TABAUX ) 
     Set Relation To CODPRO Into MPR 
     cIndice:= "CODPRO" 
     nCodigoTab:= PRE->CODIGO 
 
     /* Produtos SALDO [COM/SEM/TODOS] */ 
     IF cComSaldo == "C" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On &cIndice To INDICE01.TMP FOR Val( MPR->INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                              Val( MPR->INDICE ) <= Val( PAD( cCodigo2, 12 ) ) .AND. ; 
                                                   MPR->SALDO_ > 0 .AND. CODIGO = nCodigoTab Eval {|| Processo() } 
     ELSEIF cComSaldo == "S" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On &cIndice To INDICE01.TMP FOR Val( MPR->INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                              Val( MPR->INDICE ) <= Val( PAD( cCodigo2, 12 ) ) .AND. ; 
                                                   MPR->SALDO_ <= 0 .AND. CODIGO = nCodigoTab Eval {|| Processo() } 
     ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On &cIndice To INDICE01.TMP FOR Val( CODPRO ) >= Val( PAD( cCodigo1, 12 ) ) .AND.; 
                                              Val( CODPRO ) <= Val( PAD( cCodigo2, 12 ) ) .AND.; 
                                                   CODIGO = nCodigoTab Eval {|| Processo() } 
     ENDIF 
  ELSE 
     IF aOpcao[ 3 ] == 2 
        cIndice:= "DESCRI" 
     ELSEIF aOpcao[ 3 ] == 3 
        cIndice:= "SUBSTR(CODIGO,1,3)+DESCRI" 
     ELSEIF aOpcao[ 3 ] == 4 
        cIndice:= "CODFAB" 
     ELSEIF aOpcao[ 3 ] == 5 
        cIndice:= "ORIGEM+INDICE+DESCRI" 
     ELSEIF aOpcao[ 3 ] == 6 
        cIndice:= "STR( CODFOR )+DESCRI" 
     ELSEIF aOpcao[ 3 ] == 7 
        cIndice:= "STR( VAL( CODFAB ), 13, 0 )" 
 
     ENDIF 
     /* Produtos SALDO [COM/SEM/TODOS] */ 
     IF cComSaldo == "C" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On &cIndice To INDICE01.TMP FOR Val( MPR->INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                              Val( MPR->INDICE ) <= Val( PAD( cCodigo2, 12 ) ) .AND. ; 
                                                   MPR->SALDO_ > 0 Eval {|| Processo() } 
     ELSEIF cComSaldo == "S" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On &cIndice To INDICE01.TMP FOR Val( MPR->INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                              Val( MPR->INDICE ) <= Val( PAD( cCodigo2, 12 ) ) .AND. ; 
                                                   MPR->SALDO_ <= 0 Eval {|| Processo() } 
     ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On &cIndice To INDICE01.TMP FOR Val( MPR->INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                              Val( MPR->INDICE ) <= Val( PAD( cCodigo2, 12 ) ) Eval {|| Processo() } 
     ENDIF 
  ENDIF 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
     SelecaoImpressora( .F. ) 
  ENDIF 
 
  MPR->( DBGoTop() ) 
 
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
  DBSelectAr( _COD_TABAUX ) 
  Set Relation To 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/taxind01.ntx","&gdir/taxind02.ntx"   
  #else 
    Set Index To "&GDir\TAXIND01.NTX","&GDir\TAXIND02.NTX"   
  #endif
  DBSelectAr( _COD_MPRIMA ) 
  // Restaura os indices 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/mprind01.ntx",;  
                 "&gdir/mprind02.ntx",;  
                 "&gdir/mprind03.ntx",;  
                 "&gdir/mprind04.ntx",;  
                 "&gdir/mprind05.ntx" 
  #else
    Set Index To "&GDIR\MPRIND01.NTX",;  
                 "&GDIR\MPRIND02.NTX",;  
                 "&GDIR\MPRIND03.NTX",;  
                 "&GDIR\MPRIND04.NTX",;  
                 "&GDIR\MPRIND05.NTX" 

  #endif
  DBSetOrder( 1 ) 
  Return Nil 
 
 
