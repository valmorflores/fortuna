// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ImpOutros() 
³ Finalidade  ³ Outros Relatorios 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Fevereiro/1995 
³ Atualizacao ³ Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function ImpOutros( cTitulo, nOpcao ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "<PADRAO>" },; 
                   { " ORDEM       ", "Nome", "Codigo" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, cTitulo, _COR_GET_EDICAO ) 
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
 
            /* Padrao */ 
            CASE aOpcao[ 2 ] == 2 
                 DO CASE 
                    CASE nOpcao == 1 
                         cArquivo:= RepOrigem 
                         DBSelectAr( _COD_ORIGEM ) 
                    CASE nOpcao == 2 
                         cArquivo:= RepVendedores 
                         DBSelectAr( _COD_VENDEDOR ) 
                    CASE nOpcao == 3 
                         cArquivo:= RepClasFiscal 
                         DBSelectAr( _COD_CLASFISCAL ) 
                    CASE nOpcao == 4 
                         cArquivo:= RepBancos 
                         DBSelectAr( _COD_BANCO ) 
                    CASE nOpcao == 5 
                         cArquivo:= RepAgencias 
                         DBSelectAr( _COD_AGENCIA ) 
                    CASE nOpcao == 6 
                         cArquivo:= RepTranspor 
                         DBSelectAr( _COD_TRANSPORTE ) 
                    CASE nOpcao == 7 
                         cArquivo:= RepReceitas 
                         DBSelectAr( _COD_RECEITAS ) 
                    CASE nOpcao == 8 
                         cArquivo:= RepDespesas 
                         DBSelectAr( _COD_DESPESAS ) 
                    CASE nOpcao == 9 
                         cArquivo:= RepReducoes 
                         DBSelectAr( _COD_REDUCAO ) 
                    CASE nOpcao == 10 
                         cArquivo:= RepFeriados 
                         DBSelectAr( _COD_FERIADOS ) 
                    CASE nOpcao == 11 
                         cArquivo:= RepAtividades 
                         DBSelectAr( _COD_ATIVIDADES ) 
                    CASE nOpcao == 12 
                         cArquivo:= RepNatOperacao 
                         DBSelectAr( _COD_NATOPERA ) 
                    CASE nOpcao == 13 
                         cArquivo:= RepEstados 
                         DBSelectAr( _COD_ESTADO ) 
                    CASE nOpcao == 14 
                         cArquivo:= RepHistoricos 
                         DBSelectAr( _COD_HISTORICO ) 
                    CASE nOpcao == 15 
                         cArquivo:= RepPrecos 
                         DBSelectAr( _COD_TABPRECO ) 
                    CASE nOpcao == 16 
                         cArquivo:= RepComissoes 
                         DBSelectAr( _COD_COMFORMULA ) 
                         DBSelectAr( _COD_COMFAUX ) 
                         DBSelectAr( _COD_COMPER ) 
                    CASE nOpcao == 17 
                         cArquivo:= RepFormas 
                         DBSelectAr( _COD_CONDICOES ) 
                    CASE nOpcao == 18
                         cArquivo:= RepOperacoes 
                         DBSelectAr( _COD_OPERACOES ) 
                 ENDCASE 
 
         ENDCASE 
         cArquivo:= PAD( cArquivo, 30 ) 
         @ 05, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
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
     Set( 24, "OUTROS.PRN" ) 
     Aviso( "Impressao desviada para o arquivo OUTROS.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  nOrdem:= 1 
  IF aOpcao[ 3 ] == 2 
     nOrdem:= 2 
  ELSEIF aOpcao[ 3 ] == 3 
     nOrdem:= 1 
  ENDIF 
 
  DBSetOrder( nOrdem ) 
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
  Return Nil 
 


Function ImpgOutros( cTitulo, nOpcao )
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
 
  /* Lista de Opcoes */ 
  aListaOpcoes:= { { " IMPRIMIR    " },; 
                   { " FORMATO     ", "<PADRAO>" },; 
                   { " ORDEM       ", "Nome", "Codigo" },; 
                   { " IMPRESSORA  ", "<PADRAO>", "<SELECAO MANUAL>" },; 
                   { " FORMULARIO  ", "Tela       ", "Impressora  ", "Arquivo     " },; 
                   { " DATA        ", DTOC( DATE() )  } } 
 
  aOpcao:= {} 
  FOR nCt:= 1 TO Len( aListaOpcoes ) 
     AAdd( aOpcao, 2 ) 
  NEXT 
  VPBox( 03, 08, 21, 79, cTitulo, _COR_GET_EDICAO ) 
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

         cArquivo:= "pedprod1.rep"
         DBSelectAr( "PED" )

         cArquivo:= PAD( cArquivo, 30 ) 
         cGrupo:= "999"
         dDataIni:= dDataFim:= Ctod( "  /  /  " )
         cSaldo:= " "
         cTitulo1:= cTitulo2:= Space( 30 )
         @ 05, 10 Say "Grupo ....: " Get cGrupo
         @ 06, 10 Say "Periodo ..: " Get dDataIni
         @ 06, 35 Say "ate"
         @ 06, 40 Get dDataFim
//         @ 07, 10 Say "Saldo <> 0 ?"
         @ 08, 10 Say "Titulo 01 :" Get cTitulo1
         @ 09, 10 Say "Titulo 02 :" Get cTitulo2
         @ 18, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo
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
     Set( 24, "OUTROS.PRN" ) 
     Aviso( "Impressao desviada para o arquivo OUTROS.PRN" ) 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
     ScreenRest( cTelaRes ) 
  ENDIF 
 
  nOrdem:= 1 
  IF aOpcao[ 3 ] == 2 
     nOrdem:= 2 
  ELSEIF aOpcao[ 3 ] == 3 
     nOrdem:= 1 
  ENDIF 
 
  DBGoTop() 
 
  IF aOpcao[ 4 ] == 2 
     SelecaoImpressora( .T. ) 
  ELSEIF aOpcao[ 4 ] == 3 
     SelecaoImpressora( .F. ) 
  ENDIF 
 
/*=======================*/

  Matrdads := {}

  aadd(matrdads, {"CODIGO","C",08,00})
  aadd(matrdads, {"CODPRO","N",10,00})
  aadd(matrdads, {"CODFAB","C",15,00})
  aadd(matrdads, {"DESCRI","C",50,00})
  aadd(matrdads, {"QUANT_","N",10,04})
  aadd(matrdads, {"VLRUNI","N",10,04})
  aadd(matrdads, {"VLRTOT","N",16,04})
  aadd(matrdads, {"CAMPO_","C",10,00})

  DBSelectAr( 123 )
  IF Used()
     DBCloseArea()
  EndIf
  dbcreate( "PEDPRO.TMP", matrdads )
  Use PEDPRO.TMP Alias BAR
  Index on CODPRO to ICODPRO
  Index on DESCRI to IDESPRO
  Use PEDPRO.TMP Index ICODPRO, IDESPRO Alias BAR

  PED->( DBGoTop() )
  PXP->( DBSETorder( 2 ) )
  BAR->( DBSETorder( 1 ) )

  While !( PED->( Eof() ) )
     If ( Empty( dDataIni ) .And. Empty( dDataFim) ) .Or.;
     PED->DATA__>=dDataIni .And. PED->DATA__<=dDataFim
        If PXP->( DBseek( PED->CODIGO, .t. ) )
           While PXP->CODIGO=PED->CODIGO
Mensagem( "Pressione [ENTER] para continuar..." )
              If Left( StrZero( PXP->CODPRO, 7 ), 3 )==cGrupo .Or.;
              cGrupo=="   " .Or. cGrupo=="999"
                 If BAR->( DBSeek( PXP->CODPRO ) )
                    Repl QUANT_ With QUANT_+PXP->QUANT_
                    Repl VLRTOT With VLRTOT+( PXP->VLRUNI*PXP->QUANT_ )
                 Else
                    Appe Blan
                    Repl CODIGO With PXP->CODIGO
                    Repl CODPRO With PXP->CODPRO
                    Repl CODFAB With PXP->CODFAB
                    Repl DESCRI With PXP->DESCRI
                    Repl QUANT_ With PXP->QUANT_
                    Repl VLRTOT With PXP->VLRUNI*PXP->QUANT_
                 EndIf
              EndIf
              PXP->( DBSkip() )
           EndDo
        EndIf
     EndIf
     PED->( DBSkip() )
  EndDo

  BAR->( DBSetOrder( nOrdem  ) )
  /* Emissao do relatorio */
  Relatorio( AllTrim( cArquivo ) )

  DBSelectAr( 123 )
  DBCloseArea()

  /*=======================*/

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
Return Nil

