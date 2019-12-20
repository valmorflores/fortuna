// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � IMPPRODUTOS 
� Finalidade  � Imprimir o cadastro de produtos ou lista de precos. 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 07/08/1998 
��������������� 
*/ 
Function ImpProdutos() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Simples", "Completo", "Barras", "Composicao","<Personal>" },; 
                   { " ORDEM       ", "Nome", "Codigo", "Cod.Fabrica" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " CADASTRO DE PRODUTOS ", _COR_GET_EDICAO ) 
  WHILE .T. 
      cCodigo1:= "0000000" 
      cCodigo2:= "9999999" 
      nCodFor:= 0 
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
                 cArquivo:= RepProSimples 
 
            /* Completo */ 
            CASE aOpcao[ 2 ] == 3 
                 cArquivo:= RepProCompleto 
 
            CASE aOpcao[ 2 ] == 4 
                 cArquivo:= RepProSimples 
 
            CASE aOpcao[ 2 ] == 5 
                 cArquivo:= RepProCmp 
 
         ENDCASE 
         cComSaldo:= "S" 
         IF !aOpcao[ 2 ] == 4 
            cArquivo:= PAD( cArquivo, 30 ) 
            @ 05, 10 Say "Do Codigo.....................:" Get cCodigo1 Pict "@R 999-9999" 
            @ 05, 55 Say "At�:" Get cCodigo2 Pict "@R 999-9999" 
            @ 06, 10 Say "Fornecido por.................:" Get nCodFor  Pict "9999" 
//            @ 07, 10 Say "Produtos com Movimento........:" Get cComSaldo Pict "!" 
            @ 08, 10 Say "��������������������������������������������������������������������" 
            @ 09, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
            READ 
         ENDIF 
 
         /* Se for pressionado a tecla ESC */ 
         IF !LastKey() == K_ESC 
            Exit 
         ENDIF 
 
      ENDIF 
 
  ENDDO 
 
  DBSelectAr( _COD_MPRIMA ) 
  /* Se estiver dispon�vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 600 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "PRODUTOS.PRN" ) 
     Aviso( "Impressao desviada para o arquivo PRODUTOS.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "DESCRI" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= "CODIGO" 
  ELSEIF aOpcao[ 3 ] == 4 
     cIndice:= "CODFAB" 
  ENDIF 
 
  Mensagem( "Organizando o arquivo de produtos, aguarde..." ) 
  IF !( aOpcao[ 2 ] == 4 ) 
     IF nCodFor > 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE01.TMP FOR INDICE >= cCodigo1 .AND. INDICE <= cCodigo2 .AND.; 
                             CODFOR == nCodFor EVAL {|| Processo() } 
     ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON &cIndice TO INDICE01.TMP FOR INDICE >= cCodigo1 .AND. INDICE <= cCodigo2 EVAL ; 
                             {|| Processo() } 
     ENDIF 
  ELSE 
     MPR->( DBSetOrder( 1 ) ) 
  ENDIF 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
     SelecaoImpressora( .F. ) 
  ENDIF 
 
  IF aOpcao[ 2 ] == 4 
     CliBarra() 
  ELSE 
     /* Emissao do relatorio */ 
     Relatorio( AllTrim( cArquivo ) ) 
  ENDIF 
 
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
  DBSelectAr( _COD_MPRIMA ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/mprind01.ntx", "&gdir/mprind02.ntx",;   
                 "&gdir/mprind03.ntx", "&gdir/mprind04.ntx",;   
                 "&gdir/mprind05.ntx" 
  #else
    Set Index To "&GDIR\MPRIND01.NTX", "&GDIR\MPRIND02.NTX",;   
                 "&GDIR\MPRIND03.NTX", "&GDIR\MPRIND04.NTX",;   
                 "&GDIR\MPRIND05.NTX" 

  #endif
  Return Nil 
 
 
