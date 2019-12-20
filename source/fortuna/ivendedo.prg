// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � ImpVendedor() 
� Finalidade  � Relacao de Vendedor 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Fevereiro/1995 
� Atualizacao � Agosto/1998 
��������������� 
*/ 
Function ImpVendedor() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Simples", "Completo", "Etiquetas", "<Personal>" },; 
                   { " ORDEM       ", "Nome", "Codigo" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " CADASTRO DE VENDEDORES ", _COR_GET_EDICAO ) 
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
                 cArquivo:= RepForSimples 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepForCompleto 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= "VENETQ.REP" 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepForPersonal 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
         @ 05, 10 Say "Do Codigo.....................:" Get nForn1    Pict "999999" 
         @ 05, 51 Say "At�:" Get nForn2 Pict "999999" 
         @ 06, 10 Say "Pgto. Feriado [A]Ant. [P]Pos..:" Get cAntPos    Pict "!" Valid cAntPos $ "AP " 
         @ 07, 10 Say "��������������������������������������������������������������������" 
         @ 08, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
         READ 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  /* Consumo/Industria */ 
  IF cAntPos ==  " " 
     cAntPos:=   "AP " 
  ENDIF 
 
  DBSelectAr( _COD_FORNECEDOR ) 
  /* Se estiver dispon�vel para a tela */ 
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
     cIndice:= "DESCRI" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= "CODIGO" 
  ENDIF 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nForn1 .AND. CODIGO <= nForn2 .AND.; 
                       ANTPOS $ cAntPos 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
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

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/forind01.ntx", "&gdir/forind02.ntx"   
  #else 
    Set Index To "&GDIR\FORIND01.NTX", "&GDIR\FORIND02.NTX"   
  #endif
  Return Nil 
 
