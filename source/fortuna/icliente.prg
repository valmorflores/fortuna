// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ impClientes() 
³ Finalidade  ³ Relacao de Clientes 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Fevereiro/1995 
³ Atualizacao ³ Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpClientes() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nQtdImpressao:= 1 

  // VALMOR:
  Local cRDDDefault:= RDDSetDefault()
 
  Local cTelaRes 
  Local cArquivo 
  Local cE_Mail:= " " 
  Local cBairro, cEstado:= "  " 
 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "Simples", "Ficha", "Completo", "Compl", "Etiqueta", "Exportar", "<Pers>" },; 
                   { " ORDEM       ", "Nome", "Nome Fantasia", "Codigo", "Endereco" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela     ", "Impressora  ", "Arquivo   " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, " CADASTRO DE CLIENTES ", _COR_GET_EDICAO ) 
  IF !DispSelecao( 06, 09, @aListaOpcoes, @aOpcao ) 
     IF LastKey() == K_ESC 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        Return Nil 
     ENDIF 
  ENDIF 
 
 
  // Inicializacao das Variaveis 
  nClien1:= 1 
  nClien2:= 999999 
  cConInd:= " " 
  cCliente:= " " 
  cCidade:= Space( LEN( CLI->CIDADE ) ) 
  cBairro:= Space( LEN( CLI->BAIRRO ) ) 
  cAniver1:= Space( 4 ) 
  cAniver2:= Space( 4 ) 
  nVendedor:=  0 
  nAtividade:= 0 
  dUltcmp:= date() 
  nLimCr1:= 0 
  nLimCr2:= 99999999.99 
  nCodFil1:= 0 
  nCodFil2:= 9999999 
  cIndice:= "DESCRI" 
 
 
 
  Set( _SET_DELIMITERS, .T. ) 
  SetCursor( 1 ) 
  SetColor( _COR_GET_EDICAO ) 
  Scroll( 04, 09, 20, 74 ) 
 
  SWDispStatus( .F. ) 
  #ifdef HARBOUR
     Relatorio( "report.ini", _PATH_SEPARATOR + CURDIR() ) 
  #else
     Relatorio( "report.ini", curdir() ) 
  #endif
  SWDispStatus( .T. ) 
 
  /* Selecao de Relatorio */ 
  DO CASE 
 
     /* Simples */ 
     CASE aOpcao[ 2 ] == 2 
          cArquivo:= RepCliSimples 
 
     /* Completo */ 
     CASE aOpcao[ 2 ] == 4 
          cArquivo:= RepCliCompleto 
 
     /* Ficha */ 
     CASE aOpcao[ 2 ] == 3 
          cArquivo:= RepCliFicha 
 
     /* Com Complemento */ 
     CASE aOpcao[ 2 ] == 5 
          cArquivo:= RepCliCmpto 
 
     /* Etiqueta para mala-direta */ 
     CASE aOpcao[ 2 ] == 6 
          cArquivo:= RepCliMala 
 
     CASE aOpcao[ 2 ] == 7 
          cArquivo:= RepCliExportar 
 
     CASE aOpcao[ 2 ] == 8 
          cArquivo:= RepCliPersonal 
 
  ENDCASE 
  cArquivo:= PAD( cArquivo, 30 ) 
  @ 05, 10 Say "Do C¢digo.....................:" Get nClien1    Pict "999999" 
  @ 05, 51 Say "At‚:" Get nClien2 Pict "999999" 
  @ 06, 10 Say "Com Codigo Principal..........:" Get nCodFil1   Pict "@R 999-9999" 
  @ 06, 53 Say "At‚:" Get nCodFil2 Pict "@R 999-9999" 
  @ 07, 10 Say "Tipo [C]Cons/[I]Ind/[ ]Todos..:" Get cConInd    Pict "!" Valid cConInd $ "CI " 
  @ 08, 10 Say "Cliente [S]Sim [N]Nao [ ]Todos:" Get cCliente   Pict "!" Valid cCliente $ "SN " 
  @ 09, 10 Say "Vendedor......................:" Get nVendedor  Pict "9999" 
  @ 10, 10 Say "Tabela de Atividade...........:" Get nAtividade Pict "9999" 
  @ 11, 10 Say "Com Limite de Credito Entre...:" Get nLimCr1 Pict "@E 999,999,999.99" 
  @ 11, 59 Say "e:" Get nLimCr2 Pict "@E 999,999,999.99" 
  @ 12, 10 Say "Cidade........................:" Get cCidade 
  @ 13, 10 Say "Bairro........................:" Get cBairro 
  @ 14, 10 Say "Aniversario / Inauguracao.....:" Get cAniver1 Pict "@R 99/99" 
  @ 14, 51 Say "a:" Get cAniver2 Pict "@R 99/99" 
  @ 15, 10 Say "Quantidade de Copias..........:" Get nQtdImpressao Pict "999" 
  @ 16, 10 Say "[C]Com/[S]Sem e-mail [ ]Todos.:" Get cE_Mail Pict "!!" 
  @ 17, 10 Say "Ultima compra antes do dia....:" Get dUltcmp 
  @ 18, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 19, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
  READ 
 
  /* Consumo/Industria */ 
  IF cConInd ==  " " 
     cConInd:=   "CI " 
  ENDIF 
 
  /* Cliente/Nao_Cliente */ 
  IF cCliente == " " 
     cCliente:=  "SN " 
  ENDIF 
 
  /* Se for pressionado a tecla ESC */ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  DBSelectAR( _COD_CLIENTE ) 

  // VALMOR:
  //cRDDDefault:= RDDSetDefault()
  //DBSelectAR( _COD_CLIENTE ) 
  //DBCloseArea() 
  //USE "&GDir\CLIENTES.DBF" VIA "DBFCDX" Alias CLI 
  //DBSelectAr( _COD_CLIENTE ) 
 
  /* Se estiver dispon¡vel para a tela */ 
  IF aOpcao[ 5 ] == 2 
     SWGravar( 5 ) 
     Set( 24, "TELA0000.TMP" ) 
  ELSEIF aOpcao[ 5 ] == 3 
     Set( 24, SWSet( _PRN_CADASTRO ) ) 
  ELSEIF aOpcao[ 5 ] == 4 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Set( 24, "CLIENTES.PRN" ) 
     Aviso( "Impressao desviada para o arquivo CLIENTES.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  IF aOpcao[ 3 ] == 2 
     cIndice:= "DESCRI" 
  ELSEIF aOpcao[ 3 ] == 3 
     cIndice:= "FANTAS" 
  ELSEIF aOpcao[ 3 ] == 4 
     cIndice:= "CODIGO"
  ELSEIF aOpcao[ 3 ] == 5 
     cIndice:= "ENDERE" 
  ENDIF 
 
  /* 
  Selecao: 
  ====================================== 
  Com Vendedor e Com Codigo de Atividade 
  Com Vendedor e Sem Codigo de Atividade 
  Sem Vendedor e Sem Codigo de Atividade 
  Sem Vendedor e Com Codigo de Atividade 
  -------------------------------------- 
  */ 
  IF cAniver1==Space( 4 ) 
     bValidate:= {|| IIF( !EMPTY( cE_Mail ), IF( cE_Mail=="C", !EMPTY( E_MAIL ), EMPTY( E_MAIL ) ), .T. ) .and. ULTCMP <= Dultcmp } 
  ELSE 
 
     nDia1:= Val( SubStr( cAniver1, 1, 2 ) ) 
     nMes1:= Val( SubStr( cAniver1, 3, 2 ) ) 
 
     nDia2:= Val( SubStr( cAniver2, 1, 2 ) ) 
     nMes2:= Val( SubStr( cAniver2, 3, 2 ) ) 
 
     bValidate:= {|| ( MONTH( NASCIM ) >= nMes1 .and.; 
                       MONTH( NASCIM ) <= nMes2 .and.; 
                         DAY( NASCIM ) >= nDia1 .and.; 
                         DAY( NASCIM ) <= nDia2 ) .and.; 
               IIF( !EMPTY( cE_Mail ), IF( cE_Mail=="C", !EMPTY( E_MAIL ), EMPTY( E_MAIL ) ), .T.) .AND. ; 
                     ULTCMP <= Dultcmp } 
  ENDIF 
 
  IF !EMPTY( cCIDADE ) 
     IF !EMPTY( cBairro ) 
        cCidade:= PAD( cCidade, 30 ) 
        cBairro:= PAD( cBairro, Len( CLI->BAIRRO ) ) 
        IF nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate )  .AND.; 
                    CIDADE $ cCidade .AND. BAIRRO $ cBairro .AND.; 
                    CLIENT $ cCliente .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2 .AND.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2 Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CIDADE $ cCidade .AND. BAIRRO $ cBairro .AND. CLIENT $ cCliente .AND. CODATV == nAtividade  .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2 .and.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2  Eval {|| Processo() } 
        ENDIF 
     ELSE 
        IF nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CIDADE $ cCidade .AND. CLIENT $ cCliente .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2 .and.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2 Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CIDADE $ cCidade .AND. CLIENT $ cCliente .AND. CODATV == nAtividade .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2 .AND.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2 Eval {|| Processo() } 
        ENDIF 
     ENDIF 
  ELSE 
     IF ! nVendedor == 0 
        IF ! nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate )  .AND. CLIENT $ cCliente .AND.; 
                    CODATV == nAtividade .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2  .AND.; 
                    ( VENIN1 == nVendedor .OR. VENEX1 == nVendedor) .AND.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2 Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2  .AND. CLIENT $ cCliente .AND. ( VENIN1 == nVendedor .OR.; 
                    VENEX1 == nVendedor ) .AND. LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2  Eval {|| Processo() } 
        ENDIF 
     ELSE 
        IF nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CLIENT $ cCliente .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2 .AND.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2 Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CLIENT $ cCliente .AND. CODATV == nAtividade .AND. CODFIL >= nCodFil1 .AND. CODFIL <= nCodFil2 .AND.; 
                    LIMCR_ >= nLimCr1 .AND. LIMCR_ <= nLimCr2 Eval {|| Processo() } 
        ENDIF 
     ENDIF 
  ENDIF 
 
 
 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
     SelecaoImpressora( .F. ) 
  ENDIF 

  /////
  ///// VALMOR:
  ///// Exemplo de indice sem complexidade
  /////
  /////  INDEX ON DESCRI TO INDICE


  /* Emissao do relatorio */ 
  FOR nCont:= 1 TO nQtdImpressao 
      DBGoTop() 
      Relatorio( AllTrim( cArquivo ) ) 
  NEXT 
 
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
 
  DBSelectAr( 124 ) 
  DBCloseArea() 
 
  DBSelectAr( _COD_CLIENTE ) 
  DBCloseArea() 
  FDBUseVpb( _COD_CLIENTE, 2 ) 
 
  Return Nil 
 
 
