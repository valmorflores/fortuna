// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpPrecoCompra() 
³ Finalidade  ³ Lista de Precos de Venda 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Fevereiro/1995 
³ Atualizacao ³ Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpPrecoCompra() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Simples", "Completo", "Mod.A", "<Personal>" },; 
                   { " ORDEM       ", "Nome", "Codigo/Grupo", "Cod.Fabrica" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " LISTAGEM DE PRECOS DE COMPRA ", _COR_GET_EDICAO ) 
  WHILE .T. 
      cCodigo1:= "0000000" 
      cCodigo2:= "0009999" 
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
                 cArquivo:= RepPCPSimples 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepPCPCompleto 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepPCPA 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepPCPPersonal 
 
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
     Set( 24, "PRECOC.PRN" ) 
     Aviso( "Impressao desviada para o arquivo PRECOC.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "DESCRI" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= "CODIGO" 
  ELSE 
     cIndice:= "CODFAB" 
  ENDIF 
 
  /* Produtos SALDO [COM/SEM/TODOS] */ 
  IF cComSaldo == "C" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On &cIndice To INDICE01.TMP FOR Val( INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                           Val( INDICE ) <= Val( PAD( cCodigo2, 12 ) ) .AND. ; 
                                           SALDO_ > 0 
  ELSEIF cComSaldo == "S" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On &cIndice To INDICE01.TMP FOR Val( INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                           Val( INDICE ) <= Val( PAD( cCodigo2, 12 ) ) .AND. ; 
                                           SALDO_ <= 0 
  ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On &cIndice To INDICE01.TMP FOR Val( INDICE ) >= Val( PAD( cCodigo1, 12 ) ) .AND. ; 
                                           Val( INDICE ) <= Val( PAD( cCodigo2, 12 ) ) 
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
  Return Nil 
 
 
