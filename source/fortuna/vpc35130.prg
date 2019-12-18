// ## CL2HB.EXE - Converted
 
/* 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³  Modulo      ³ VPC35130 
³  Descricao   ³ Menu de Consultas a convenios 
³  Programador ³ Valmor Pereira Flores 
³  Data        ³ 
³  Cliente     ³ FARMACUSTO = Convenio 
³  Atualizacao ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#include "VPF.CH" 
#include "INKEY.CH" 

#ifdef HARBOUR
function vpc35130()
#endif


Loca cTELA:=zoom( 15, 27, 21, 50 ), cCOR:=setcolor(), nOPCAO:=0
VPBox( 15, 27, 21, 50 ) 
whil .t. 
 
   mensagem("") 
 
   aadd( MENULIST, menunew( 16, 28," 1 Extrato           ",2,COR[11],; 
         "Extrato.",,,COR[6],.F.)) 
 
   aadd( MENULIST, menunew( 17, 28," 2 Conveniados       ",2,COR[11],; 
         "Gerar arquivo.",,,COR[6],.F.)) 
 
   aadd( MENULIST, menunew( 18, 28," 3 Pesquisas         ",2,COR[11],; 
         "Outras Pesquisas relativas a convenios/conveniados.",,,COR[6],.F.)) 
 
   aadd( MENULIST, menunew( 19, 28," 4 Comunicacao       ",2,COR[11],; 
         "Importacao de Arquivos.",,,COR[6],.F.)) 
 
   aadd( MENULIST, menunew( 20, 28," 0 Retorna           ",2,COR[11],; 
         "Inclusao, alteracao e exclusao de grupos de classificacao de produtos.",,,COR[6],.F.)) 
 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOpcao=1 
           ExtratoConvenio() 
      case nOpcao=2 
           VisualConveniados() 
      case nOpcao=4 
           ImportaConvenio() 
 
   endcase 
 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
 
Function ImportaConvenio() 
Local nCt 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= setColor(),; 
      nCursor:= SetCursor() 
Local cDiretorio:= PAD( "IMPORTAR", 70 ), nEmpresa:= 0 
Local aInfo, cInfoEmpresa:= "" 
Local lEmTeste:= .F. 
 
  VPBox( 0, 0, 22, 79, "IMPORTACAO DE CONVENIOS", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Diretorio de Disponibilizacao de Informacoes" Color "15/" + CorFundoAtual() 
  @ 03,02 Get cDiretorio 
  READ 
  IF !File( ALLTRIM( cDiretorio ) - "\IDENT.TXT" ) 
      Aviso( "Arquivo de Identificacao inexistente em " + ALLTRIM( cDiretorio ) ) 
      Pausa() 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return Nil 
  ELSE 
      aInfo:= IOFillText( MEMOREAD( Alltrim( cDiretorio ) - "\IDENT.TXT" ) ) 
      FOR nCt:= 1 TO Len( aInfo ) 
          IF nCt==1 
             IF VAL( aInfo[ nCt ] ) <= 0 
                Aviso( "Numero da empresa invalido no arquivo IDENT.TXT"  ) 
                Pausa() 
                ViewFile( ALLTRIM( cDiretorio ) - "\IDENT.TXT" ) 
                ScreenRest( cTela ) 
                SetColor( cCor ) 
                Return Nil 
             ELSE 
                nEmpresa:= VAL( aInfo[ nCt ] ) 
             ENDIF 
          ELSEIF nCt==2 
             cInfoEmpresa:= aInfo[ nCt ] 
          ENDIF 
      NEXT 
  ENDIF 
  CLI->( DBSetOrder( 1 ) ) 
  @ 05,02 Say "Empresa" Color "15/" + CorFundoAtual() 
  @ 06,02 Get nEmpresa Pict "999999" Valid PesqCli( @nEmpresa ) 
  @ 08,02 Say "Modalidade" Color "15/" + CorFundoAtual() 
  READ 
 
  @ 10,02 Say "Informacao Coletada da Base de Dados" Color "15/" + CorFundoAtual() 
  @ 11,02 Say CLI->DESCRI 
  @ 12,02 Say CLI->CGCMF_ 
  @ 13,02 Say "Informacao Coletada dos dados Recebidos" Color "15/" + CorFundoAtual() 
  @ 14,02 Say cInfoEmpresa 
  CLI->( DBSetOrder( 1 ) ) 
  IF CLI->( DBSeek( nEmpresa ) ) 
     CLI->( CliComplemento() ) 
  ENDIF 
  IF CLI->CODIGO==nEmpresa 
     IF AT( "TESTE", CLI->FOLCOD ) > 0 
        @ 09,02 Say "  Empresa Em teste   " COLOR "14/04" 
     ELSE 
        @ 09,02 Say "  Validacao Oficial  " COLOR "14/02" 
     ENDIF 
     Inkey( 5 ) 
     IF SWAlerta( "Confirma as informacoes?", { "  OK  ", "Cancela" } )==1 
        aArquivo:= DIRECTORY( Alltrim( cDiretorio ) - "\*.*" ) 
        FOR nCt:= 1 TO LEN( aArquivo ) 
            IF Valida( cDiretorio - "\" - aArquivo[ nCt ][ 1 ], cDiretorio, nEmpresa ) 
               //Importa( cDiretorio - "\" - aArquivo[ nCt ][ 1 ], cDiretorio ) 
            ENDIF 
        NEXT 
        DispMenuOpcoes( cDiretorio, nEmpresa ) 
     ENDIF 
  ELSE 
     SWAlerta( "Cliente esta disfocado.... ;Execute a operacao novamente sem mudar ;de cliente na tela de complementos", {"OK"} ) 
  ENDIF 
  SetColor( cCor ) 
  ScreenRest( cTela ) 
  SetCursor( nCursor ) 
  Return Nil 
 
 
Function DispMenuOpcoes( cDiretorio, nEmpresa ) 
Local aStrErros:= {{ "CODIGO",      "N", 02, 00 },; 
                   { "DESCRICAO",   "C", 30, 00 },; 
                   { "OBSERVACOES", "C", 60, 00 }} 
 
Local cCor:= SetColor(), nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nMenuOpcao:= 0 
Local lErro:= .F. 
Local lFuncionario:= .T. 
 
Priv cCadFuncionario, cCadCargos, cCadDependente 
 
    cCadFuncionario:= IF( FILE( cDiretorio-"\CADFUNC.DBF" ), cDiretorio-"\CADFUNC.DBF", cDiretorio-"\CADFUNC.TMP" ) 
    cErros:=          cDiretorio - "\ERROS.TMP" 
    DBCreate( cErros, aStrErros ) 
 
    IF !File( cCadFuncionarios ) 
       lFuncionario:= .F. 
    ENDIF 
 
    VPBox( 06, 15, 20, 70, " Menu de Consultas Disponiveis ", _COR_GET_BOX ) 
 
    DBSelectAr( 126 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    Use &cErros Alias ERRO Exclusive 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    INDEX ON DESCRICAO TO INDERRO 
 
    IF lFuncionario 
       DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       Use &cCadFuncionario ALIAS FNC Exclusive 
 
       DBGoTop() 
       WHILE !EOF() 
          IF !EMPTY( BRANCO ) 
             cObservacoes:= "Registro " + StrZero( RECNO(), 10, 00 ) + " com problemas." 
             FOR nCt:= 1 TO LEN( ALLTRIM( BRANCO ) ) Step 3 
                 nCodigo:= SubStr( ALLTRIM( BRANCO ), nCt, 03 ) 
                 nCodigo:= StrTran( nCodigo, "-", "" ) 
                 nCodigo:= VAL( nCodigo ) 
                 ERRO->( DBAppend() ) 
                 IF ERRO->( NetRLock() ) 
                    Replace ERRO->OBSERVACOES With cObservacoes 
                    Replace ERRO->CODIGO      With nCodigo 
                 ENDIF 
             NEXT 
             lErro:= .T. 
          ENDIF 
          DBSkip() 
       ENDDO 
    ENDIF 
 
    WHILE .T. 
        ++nMenuOpcao 
 
        IF nMenuOpcao==1 .AND. !lErro 
           ++nMenuOpcao 
        ENDIF 
 
        SetColor( "00/07" ) 
        Scroll( 08, 16, 18, 63 ) 
 
        @ 08,65 Say IF( lErro, "ERRO", "Ok" ) Color "04/" + CorFundoAtual() 
 
        @ 08,16 Say    " INICIO  - Critica de dados                    " 
        @ 10,16 Prompt " 1a.FASE - Geracao do LOG de Erros detectados  " 
        @ 12,16 Prompt " 2a.FASE - Visualiza Registros de FUNCIONARIOS " 
        @ 14,16 Prompt " 3a.FASE - Visualiza Registros de DEPENDENTES  " 
        @ 16,16 Prompt " 4a.FASE - Geracao dos Arquivos de Retorno     " 
 
        CLI->( DBSetOrder( 1 ) ) 
        CLI->( DBSeek( nEmpresa ) ) 
 
        IF AT( "TESTE", CLI->FOLCOD ) > 0 
           @ 18,16 Prompt IF( !lErro, " FIM     - Emissao de Carta/Liberacao          ",; 
                          " FIM     - Imprimir Relacao de Falhas          " ) 
        ELSE 
           @ 18,16 Prompt " GRAVA   - IDENT> " + LEFT( CLI->DESCRI, 29 ) 
        ENDIF 
        Menu To nMenuOpcao 
 
        DO CASE 
           CASE nMenuOpcao==5 
 
                /* Grava IDENT.RET */ 
                Set( 24, cDiretorio-"\IDENT.RET" ) 
                Set( 20, "PRINT" ) 
 
                @ PROW(),PCOL() Say StrZero( CLI->CODIGO, 06, 00 )  + Chr( 13 ) + Chr( 10 ) 
                @ PROW(),PCOL() Say CLI->DESCRI + Chr( 13 ) + Chr( 10 ) 
 
                Set( 20, "SCREEN" ) 
                Set( 24, "LPT1" ) 
 
                EXIT 
 
           CASE nMenuOpcao==1 
                nLin:= 10 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                Aviso( "Gerando ERROS.LOG, aguarde..." ) 
                Set( 24, cDiretorio-"\ERROS.LOG" ) 
                Set( 20, "PRINT" ) 
                @ PROW(),PCOL() Say "## DESCRICAO DO ERRO                      OBSERVACOES/COMPLEMENTOS" + Chr( 13 ) + Chr( 10 ) 
                ERRO->( DBGoTop() ) 
                WHILE !ERRO->( EOF() ) 
                   @ PROW(),PCOL() Say ERRO->( StrZero( CODIGO, 02, 00 ) + " " + DESCRICAO + " " + OBSERVACOES   + Chr( 13 ) + Chr( 10 ) ) 
                   ERRO->( DBSkip() ) 
                ENDDO 
                @ PROW(),PCOL() Say "## " + _VER 
                Set( 20, "SCREEN" ) 
                Set( 24, "LPT1" ) 
                ScreenRest( cTelaRes ) 
 
           CASE nMenuOpcao==2 
                nLin:= 12 
 
                DBSelectAr( 123 ) 
                VisualFuncionario() 
 
           CASE nMenuOpcao==3 
                nLin:= 14 
 
           CASE nMenuOpcao==4 
                nLin:= 16 
 
        ENDCASE 
        @ nLin,65 Say "Ok" Color "04/" + CorFundoAtual() 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
Function VisualFuncionario() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
    VPBox( 00, 00, 22, 79, " CADFUNC.xxx ", _COR_GET_BOX ) 
    SetColor( _COR_GET_EDICAO ) 
    WHILE .T. 
        DispBegin() 
        @ 02,03 Say "NOME            > " +NOME 
        @ 03,03 Say "ENDERECO        > " +ENDERECO 
        @ 04,03 Say "BAIRRO          > " +BAIRRO 
        @ 05,03 Say "CIDADE          > " +CIDADE 
        @ 06,03 Say "ESTADO          > " +ESTADO 
        @ 07,03 Say "CEP             > " +CEP 
        @ 08,03 Say "FONE1           > " +FONE1 
        @ 09,03 Say "FONE2           > " +FONE2 
        @ 10,03 Say "CPF             > " +STR( CPF, 11, 0 ) 
        @ 11,03 Say "RG              > " +STR( RG, 10, 0 ) 
        @ 12,03 Say "SEUCODIGO       > " +SEUCODIGO 
        @ 13,03 Say "LIMITECREDITO   > " +TRAN( LIMITECRED / 100, "@E 999,999,999,999.99" ) 
        @ 14,03 Say "MAE             > " +MAE 
        @ 15,03 Say "DATA            > " +Tran( DATAADMISS, "@R 99/99/99" ) 
        @ 16,03 Say "FUNCAO          > " +FUNCAO 
        @ 17,03 Say "TIPOOPERACAO    > " +STR( TIPOOPERAC, 1, 0 ) 
        @ 18,03 Say "BRANCO          > " +Space( 0 ) 
        @ 19,03 Say "SEQUENCIAL      > " +StrZero( SEQUENCIAL, 10, 0 ) 
 
        IF !EMPTY( BRANCO ) 
           @ 21,03 Say "Atencao! Este registro possui um erro..." Color "15/04" 
        ELSE 
           @ 21,03 Say Space( 60 ) 
        ENDIF 
 
        DispEnd() 
        nTecla:= INKEY( 0 ) 
        IF nTecla==K_RIGHT .OR. nTecla==K_DOWN 
           DBSkip() 
        ELSEIF nTecla==K_LEFT .OR. nTecla=K_UP 
           DBSkip(-1) 
        ELSE 
           EXIT 
        ENDIF 
    ENDDO 
    ScreenRest( cTela ) 
    Return Nil 
 
 
 
Function Valida( cArquivo, cDiretorio, nEmpresa ) 
Local nCt 
Local lDBF:= .F. 
Local cRetorno:= "" 
Local lCargoNaoExiste:= .F. 
Local aStrFuncionario:= {{ "NOME",       "C", 040, 000 },; 
                         { "ENDERECO",   "C", 040, 000 },; 
                         { "BAIRRO",     "C", 020, 000 },; 
                         { "CIDADE",     "C", 030, 000 },; 
                         { "ESTADO",     "C", 002, 000 },; 
                         { "CEP",        "C", 008, 000 },; 
                         { "FONE1",      "C", 012, 000 },; 
                         { "FONE2",      "C", 012, 000 },; 
                         { "CPF",        "N", 011, 000 },; 
                         { "RG",         "N", 010, 000 },; 
                         { "SEUCODIGO",  "C", 015, 000 },; 
                         { "LIMITECRED", "N", 015, 000 },; 
                         { "MAE",        "C", 040, 000 },; 
                         { "DATAADMISS", "C", 006, 000 },; 
                         { "FUNCAO",     "C", 030, 000 },; 
                         { "TIPOOPERAC", "N", 001, 000 },; 
                         { "BRANCO",     "C", 098, 000 },; 
                         { "SEQUENCIAL", "N", 010, 000 }} 
 
Local aStrDependente := {{ "NOME",       "C", 040, 000 },; 
                         { "CODIGOMAST", "C", 015, 000 },; 
                         { "CPF",        "N", 011, 000 },; 
                         { "RG",         "N", 010, 000 },; 
                         { "TIPOOPERAC", "C", 001, 000 },; 
                         { "BRANCO",     "C", 312, 000 },; 
                         { "SEQUENCIAL", "N", 010, 000 }} 
 
Local aStrCargos:=      {{ "CODIGO",     "N", 005, 000 },; 
                         { "DESCRICAO",  "C", 030, 000 },; 
                         { "BRANCO",     "C", 365, 000 },; 
                         { "SEQUENCIAL", "N", 010, 000 }} 
 
   DO CASE 
      //////////////////////// CADASTRO DE FUNCIONARIO ///////////////////////// 
      CASE AT( "CADFUNC.TXT", cArquivo ) > 0 .OR. AT( "CADFUNC.DBF", cArquivo ) > 0 
           IF File( cDiretorio - "\CADCARGO.TXT" ) 
              DBCreate( cDiretorio - "\CADCARGO.TMP", aStrCargos ) 
              cArquivoCargo:= cDiretorio - "\CADCARGO.TMP" 
           ELSEIF File( cDiretorio - "\CADCARGO.DBF" ) 
              cArquivoCargo:= cDiretorio - "\CADCARGO.DBF" 
              lDBF:= .T. 
           ELSE 
              lCargoNaoExiste:= .T. 
           ENDIF 
           IF !lCargoNaoExiste 
              DBSelectAr( 124 ) 
              IF lDBF 
                 // Usa o arquivo no formato original 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Use &cArquivoCargo Alias CARGO 
              ELSE 
                 // Usa o arquivo no formato criado aqui para fazer a importacao 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Use &cArquivoCargo Alias CARGO 
                 DBSelectAr( 123 ) 
                 DBCreate( "TEMP.TMP", {{ "ORIGEM", "C", 400, 00 }} ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Use TEMP.TMP Alias TMP 
                 cArqOrigem:= cDiretorio - "\CADCARGO.TXT" 
                 Append From &cArqOrigem SDF 
                 DBGoTop() 
                 WHILE !TMP->( EOF() ) 
                     CARGO->( DBAppend() ) 
                     IF CARGO->( NetRLock() ) 
                        Replace CARGO->CODIGO     With VAL( LEFT( TMP->ORIGEM, 05 ) ),; 
                                CARGO->DESCRICAO  With    SUBSTR( TMP->ORIGEM, 06, 30 ),; 
                                CARGO->BRANCO     With    SUBSTR( TMP->ORIGEM, 31, 355 ),; 
                                CARGO->SEQUENCIAL With VAL( SUBSTR( TMP->ORIGEM, 391, 10 ) ) 
                     ENDIF 
                     TMP->( DBSkip() ) 
                 ENDDO 
              ENDIF 
              DBSelectAr( 123 ) 
              DBCloseArea() 
              DBSelectAr( 124 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              INDEX ON CODIGO TO I0000001 
           ENDIF 
           DBSelectAr( 125 ) 
           IF cArquivo=="CADFUNC.DBF" 
              cArqFuncionario:= cDiretorio - "\CADFUNC.DBF" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Use &cArqFuncionario Alias FC 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              INDEX ON CODIGO TO I0000002 
           ELSE 
              DBCreate( cDiretorio-"\CADFUNC.TMP", aStrFuncionario ) 
              cArqFuncionario:= cDiretorio - "\CADFUNC.TMP" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Use &cArqFuncionario Alias FC 
              DBSelectAr( 123 ) 
              DBCreate( "TEMP.TMP", {{ "ORIGEM", "C", 400, 00 }} ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Use TEMP.TMP Alias TMP 
              cArqOrigem:= cDiretorio - "\CADFUNC.TXT" 
              Append From &cArqOrigem SDF 
              DBGoTop() 
              WHILE !TMP->( EOF() ) 
                  FC->( DBAppend() ) 
                  IF FC->( NetRLock() ) 
                     Repl FC->NOME         With SubStr( TMP->ORIGEM, 001, 040 ),; 
                          FC->ENDERECO     With SubStr( TMP->ORIGEM, 041, 040 ),; 
                          FC->BAIRRO       With SubStr( TMP->ORIGEM, 081, 020 ),; 
                          FC->CIDADE       With SubStr( TMP->ORIGEM, 101, 030 ),; 
                          FC->ESTADO       With SubStr( TMP->ORIGEM, 131, 002 ),; 
                          FC->CEP          With SubStr( TMP->ORIGEM, 133, 008 ),; 
                          FC->FONE1        With SubStr( TMP->ORIGEM, 141, 012 ),; 
                          FC->FONE2        With SubStr( TMP->ORIGEM, 153, 012 ),; 
                          FC->CPF          With VAL( SubStr( TMP->ORIGEM, 165, 011 ) ),; 
                          FC->RG           With VAL( SubStr( TMP->ORIGEM, 176, 010 ) ),; 
                          FC->SEUCODIGO    With SubStr( TMP->ORIGEM, 186,  015 ),; 
                          FC->LIMITECRED   With VAL( SubStr( TMP->ORIGEM, 201, 015 ) ),; 
                          FC->MAE          With SubStr( TMP->ORIGEM, 216,  040 ),; 
                          FC->DATAADMISS   With SubStr( TMP->ORIGEM, 256,  006 ),; 
                          FC->FUNCAO       With SubStr( TMP->ORIGEM, 262,  030 ),; 
                          FC->TIPOOPERAC   With VAL( SubStr( TMP->ORIGEM, 292,  001 ) ),; 
                          FC->BRANCO       With SubStr( TMP->ORIGEM, 293,  40 ),; 
                          FC->SEQUENCIAL   With VAL( SubStr( TMP->ORIGEM, 391,  10 ) ) 
                  ENDIF 
                  TMP->( DBSkip() ) 
              ENDDO 
           ENDIF 
 
           // Modifica Indice de Clientes */ 
           DBSelectAr( _COD_CLIENTE ) 

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             index on folcod to id001 for folemp==nempresa 
           #else 
             INDEX ON FOLCOD TO ID001 FOR FOLEMP==nEmpresa 
           #endif

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to id001, "&gdir/cliind01.ntx", "&gdir/cliind02.ntx",;   
                          "&gdir/cliind03.ntx", "&gdir/cliind04.ntx",;   
                          "&gdir/cliind05.ntx", "&gdir/cliind06.ntx", "&gdir/cliind07.ntx"    
           #else
             Set Index To ID001, "&GDir\CLIIND01.NTX", "&GDir\CLIIND02.NTX",;   
                          "&GDir\CLIIND03.NTX", "&GDir\CLIIND04.NTX",;   
                          "&GDir\CLIIND05.NTX", "&GDir\CLIIND06.NTX", "&GDir\CLIIND07.NTX"    

           #endif
 
           CLI->( DBSetOrder( 1 )) 
 
           ///// CRITICA DE INFORMACOES ///// 
           DBSelectAr( 125 ) 
           DBGoTop() 
           WHILE ! FC->( EOF() ) 
 
                /**************°°°° 1a.FASE DA CONFERENCIA °°°°*************/ 
                ///// Critica da Funcao/Cargo - Verifica se e' codificada //// 
                cFuncao:= FC->FUNCAO 
                IF !lCargoNaoExiste           // Verifica se arquivo de cargo esta disponivel 
                   IF Left( cFuncao, 04 )=="0000" 
                      IF CARGO->( DBSeek( VAL( cFuncao ) ) ) 
                         cFuncao:= CARGO->DESCRICAO 
                      ELSE 
                         IF FC->TIPOOPERAC==1 
                            cRetorno:= "-14"   // Cargo Invalido = Nao Localizado na tabela 
                         ENDIF 
                      ENDIF 
                   ENDIF 
                ENDIF 
 
                ///// Verifica o campo DATAADMISS ///// 
                IF !( VAL( FC->DATAADMISS )==0 ) 
                   IF CTOD( Tran( FC->DATAADMISS, "@R 99/99/99" ) )==CTOD( "  /  /  " ) 
                      cRetorno:= cRetorno + "-15" 
                   ENDIF 
                ENDIF 
 
                ///// Verifica a opercao solicitada ///// 
                IF FC->TIPOOPERAC <= 0 .OR. FC->TIPOOPERAC >= 8 
                   cRetorno:= cRetorno + "-16" 
                ENDIF 
 
                ///// Critica dos Campos Obrigatorios p/ Inclusao/Alteracao ///// 
                IF FC->TIPOOPERAC==1 .OR.; 
                   FC->TIPOOPERAC==2 .OR.; 
                   FC->TIPOOPERAC==6 
                   aCamposObrigatorios:= { "NOME", "ENDERECO", "CIDADE", "SEUCODIGO" } 
                   FOR nCt:= 1 TO Len( aCamposObrigatorios ) 
                       cCampo:= aCamposObrigatorios[ nCt ] 
                       IF EMPTY( &cCampo ) 
                          cRetorno:= cRetorno + "-91" 
                          EXIT 
                       ENDIF 
                   NEXT 
                ENDIF 
 
                ///// Critica dos Campos Obrigatorios p/ Exclusao/Demissao/Suspensao/Bloqueio ///// 
                IF FC->TIPOOPERAC==3 .OR.; 
                   FC->TIPOOPERAC==4 .OR.; 
                   FC->TIPOOPERAC==5 .OR.; 
                   FC->TIPOOPERAC==7 
                   aCamposObrigatorios:= { "NOME", "SEUCODIGO" } 
                   FOR nCt:= 1 TO Len( aCamposObrigatorios ) 
                       cCampo:= aCamposObrigatorios[ nCt ] 
                       IF EMPTY( &cCampo ) 
                          IF !( AT( "91", cRetorno ) > 0 ) 
                             cRetorno:= cRetorno + "-91" 
                             EXIT 
                          ENDIF 
                       ENDIF 
                   NEXT 
                ENDIF 
 
                /***********°°°° 2a.FASE DA CONFERENCIA °°°°************/ 
 
                CLI->( DBSeek( FC->SEUCODIGO ) ) 
 
                ////// Critica da Existencia ou nao do funcionario /////// 
                   //// Se for p/ cadastrar, verifica se ja nao existe o codigo /////// 
                IF FC->TIPOOPERAC==1 .AND. !CLI->( EOF() ) 
                   cRetorno:= cRetorno + "-11" 
                   //// Se for p/ alterar/Excluir... e tiver em EOF sig. que nao existe o cliente //// 
                ELSEIF ( FC->TIPOOPERAC==2 .OR. FC->TIPOOPERAC==3 .OR.; 
                         FC->TIPOOPERAC==4 .OR. FC->TIPOOPERAC==5 .OR.; 
                         FC->TIPOOPERAC==6 .OR. FC->TIPOOPERAC==7 ) .AND. CLI->( EOF() ) 
                   cRetorno:= cRetorno + "-10" 
                ENDIF 
 
                /* Armazena os retornos, caso existam */ 
                IF VAL( cRetorno ) <> 0 
                   IF FC->( NetRlock() ) 
                      Replace FC->BRANCO With cRetorno 
                      // Space( LEN( FC->BRANCO ) - LEN( cRetorno ) ) + cRetorno 
                   ENDIF 
                   cRetorno:= "" 
                ELSE 
                   IF FC->( NetRlock() ) 
                      Replace FC->BRANCO With Space( len( FC->BRANCO ) ) 
                   ENDIF 
                ENDIF 
 
                FC->( DBSkip() ) 
 
           ENDDO 
 
           // Reestabelece indice de clientes // 
           DBSelectAr( _COD_CLIENTE ) 

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cliind01.ntx", "&gdir/cliind02.ntx",;   
                          "&gdir/cliind03.ntx", "&gdir/cliind04.ntx",;   
                          "&gdir/cliind05.ntx", "&gdir/cliind06.ntx", "&gdir/cliind07.ntx"    
           #else
             Set Index To "&GDir\CLIIND01.NTX", "&GDir\CLIIND02.NTX",;   
                          "&GDir\CLIIND03.NTX", "&GDir\CLIIND04.NTX",;   
                          "&GDir\CLIIND05.NTX", "&GDir\CLIIND06.NTX", "&GDir\CLIIND07.NTX"    

           #endif
 
   ENDCASE 
   DBSelectAr( 123 ) 
   IF( Used(), DBCloseArea(), Nil ) 
   DBSelectAr( 124 ) 
   IF( Used(), DBCloseArea(), Nil ) 
   DBSelectAr( 125 ) 
   IF( Used(), DBCloseArea(), Nil ) 
   DBSelectAr( 126 ) 
   IF( Used(), DBCloseArea(), Nil ) 
   DBSelectAr( 127 ) 
   IF( Used(), DBCloseArea(), Nil ) 
   DBSelectAr( _COD_CLIENTE ) 
   Return .T. 
 
 
Function Importa( cArquivo ) 
 
 
 
 
 
Function ExtratoConvenio() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= setColor(),; 
      nCursor:= SetCursor() 
Local dDataIni:= DATE(), dDataFim:= DATE() 
Local nEmpresa:= 0, nBanco:= 0 
Local aStr:= {} 
 
 
  VPBox( 00, 00, 22, 79, " EXTRATO [ CONVENIO ] ", _COR_BROW_BOX ) 
  SetColor( _COR_BROWSE ) 
  @ 02,02 Say "Folha - Empresa........:" Get nEmpresa Pict "@r 999999" 
  @ 03,02 Say "Banco..................:" Get nBanco Pict "999" 
  @ 04,02 Say "Periodo................:" Get dDataIni 
  @ 04,42 Say "Ate:" Get dDataFim 
  READ 
  IF LastKey()==K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  aStr:= {{"CODIGO","C",15,00},; 
          {"DESCRI","C",45,00},; 
          {"PRODUT","C",45,00},; 
          {"TIPO__","C",01,00},; 
          {"QUANT_","N",16,03},; 
          {"VALOR_","N",16,02},; 
          {"DATA__","D",08,00},; 
          {"CUPOM_","N",08,00}} 
 
  // Tipo=1-Regisstro do Cliente.... 2-Registro Cupom.... 3-Detalhe Cupom 
 
  DBSelectAr( 123 ) 
  DBCreate( "EMPTEMP.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Use EMPTEMP.TMP Alias TMP 
 
  DBSelectAr( _COD_CUPOM ) 
  DBSetOrder( 4 ) 
  dbGoTop() 
 
  DBSelectAr( _COD_CLIENTE ) 
  DBGoTop() 
 
  WHILE !EOF() 
 
      /// LOCALIZACAO E REGISTRO DE CLIENTE NA BASE DE DADOS 
      IF CLI->FOLEMP==nEmpresa 
         TMP->( DBAppend() ) 
         Replace TMP->DESCRI With CLI->DESCRI,; 
                 TMP->CODIGO With CLI->FOLCOD,; 
                 TMP->TIPO__ With "1" 
 
         CUP->( DBSeek( CLI->CODIGO ) ) 
         IF CUP->CLIENT==CLI->CODIGO 
            WHILE CUP->CLIENT==CLI->CODIGO .AND. !cup->( EOF() ) 
               DPA->( DBSetOrder( 1 ) ) 
               DPA->( DBSeek( CUP->NUMERO ) ) 
               IF CUP->DATAEM >= dDataIni .AND. CUP->DATAEM <= dDataFim .AND.; 
                  ( IF( nBanco > 0, DPA->BAN___ == nBanco, .T. ) ) 
 
                  /// REGISTRO DE CABECALHO DE CUPOM 
                  TMP->( DBAppend() ) 
                  Replace TMP->DESCRI With CLI->DESCRI,; 
                          TMP->CODIGO With CLI->FOLCOD,; 
                          TMP->CUPOM_ With CUP->NUMERO,; 
                          TMP->DATA__ With CUP->DATAEM,; 
                          TMP->VALOR_ With CUP->VLRTOT,; 
                          TMP->TIPO__ With "2" 
 
                  /// REGISTRO DE PRODUTOS - DETALHE 
                  nCupom:= TMP->CUPOM_ 
                  CAU->( DBSetOrder( 5 ) ) 
                  CAU->( DBSeek( TMP->CUPOM_ ) ) 
                  WHILE CAU->CODNF_ == nCupom 
                      TMP->( DBAppend() ) 
                      Replace TMP->DESCRI With CLI->DESCRI,; 
                              TMP->PRODUT With PAD( CAU->DESCRI, 40 ) + " " +  CAU->UNIDAD,; 
                              TMP->CODIGO With CLI->FOLCOD,; 
                              TMP->CUPOM_ With CUP->NUMERO,; 
                              TMP->DATA__ With CUP->DATAEM,; 
                              TMP->QUANT_ With CAU->QUANT_,; 
                              TMP->VALOR_ With CAU->PRECOT,; 
                              TMP->TIPO__ With "3" 
                      CAU->( DBSkip() ) 
                  ENDDO 
 
               ENDIF 
               CUP->( DBSkip() ) 
            ENDDO 
         ENDIF 
      ENDIF 
      CLI->( DBSkip() ) 
 
  ENDDO 
 
  DBSelectAr( 123 ) 
  DBGoBottom() 
  nReg:= 0 
  nSoma:= 0 
  WHILE ! BOF() 
      IF TIPO__=="1" 
         IF NetRlock() 
            IF nSoma > 0 
               Replace VALOR_ With nSoma 
            ELSE 
               Replace TIPO__ With "*" 
            ENDIF 
         ENDIF 
         nSoma:= 0 
      ELSE 
         nSoma:= nSoma + IF( TIPO__== "2", VALOR_, 0 ) 
      ENDIF 
      TMP->( DBSkip(-1) ) 
  ENDDO 
  fLock() 
  DELE FOR TIPO__=="*" 
  PACK 
  DBGoTop() 
 
  DisplayExtrato( nEmpresa ) 
 
  DBSelectAr( 123 ) 
  DBCloseArea() 
 
  DBSelectAr( _COD_CLIENTE ) 
 
  SetColor( cCor ) 
  ScreenRest( cTela ) 
  SetCursor( nCursor ) 
  Return Nil 
 
 
 
 
Function DisplayExtrato( nEmpresa ) 
Local cArquivoRep 
   DBSelectAr( 123 ) 
   DBGoTop() 
   nTotal:= 0 
   nQuant:= 0 
   VPBox( 03, 01, 17, 78, "E X T R A T O", _COR_BROW_BOX ) 
   VPBox( 18, 01, 21, 78, "T O T A I S", _COR_BROW_BOX ) 
   WHILE !TMP->( EOF() ) 
      // Tipo="2" 
      nTotal:= nTotal + IF( TMP->TIPO__=="2", TMP->VALOR_, 0 ) 
      nQuant:= nQuant + IF( TMP->TIPO__=="2", TMP->QUANT_, 0 ) 
      TMP->( DBSkip() ) 
      @ 19,02 Say "Quantidade.....:" + Tran( nQuant, "@E 999,999,999.999" ) 
      @ 20,02 Say "Valor..........:" + Tran( nTotal, "@E 999,999,999.999" ) 
   ENDDO 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   INDEX ON DESCRI TO INDKK2 FOR VAL( TIPO__ ) >= 0 
   DBGoTop() 
 
   Mensagem( "Relatorios: [TAB]Extrato [CTRL+TAB]Arquivo" ) 
 
   oTAB:=tbrowseDB(04,02,16,77) 
   oTAB:addcolumn(tbcolumnnew(,{|| CODIGO + " " + IIF( TIPO__=="1", DESCRI + "ÄÄÄÄ>" + Tran( VALOR_, "@E 999,999.99" ), IF( TIPO__=="2", "  * Cupom *" + StrZero( CUPOM_, 8, 0 ) + " " + DTOC( DATA__ ), "     " + PRODUT + Tran( VALOR_, "@E 999,999.999" ) ) )+ SPACE( 60 ) })) 
   oTAB:AUTOLITE:=.f. 
   oTAB:dehilite() 
   WHILE .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTAB:stabilize() 
      end 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_UP         ;oTAB:up() 
         case TECLA==K_DOWN       ;oTAB:down() 
         case TECLA==K_LEFT       ;oTAB:up() 
         case TECLA==K_RIGHT      ;oTAB:down() 
         case TECLA==K_PGUP       ;oTAB:pageup() 
         case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
         case TECLA==K_PGDN       ;oTAB:pagedown() 
         case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
         case TECLA==K_ENTER 
         case TECLA==K_CTRL_TAB 
 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              cCorRes:=  SetColor() 
              nOpcao:= 1 
              VPBox( 05, 30, 11, 76, " Relatorios ", _COR_GET_BOX ) 
              SetColor( _COR_GET_EDICAO ) 
              @ 06,31 Prompt " 1 Extrato Sintetico Impresso     " 
              @ 07,31 Prompt " 2 Extrato Analitico Impresso     " 
              @ 08,31 Prompt " 3 Em Arquivo (Totais)            " 
              @ 09,31 Prompt " 4 Em Arquivo (Detalhamento)      " 
              @ 10,31 Prompt " 0 Retornar                       " 
              Menu To nOpcao 
              ScreenRest( cTelaRes ) 
              SetColor( cCorRes ) 
 
              DO CASE 
                 CASE nOpcao==1 
                      cArquivoRep:= "FCES" 
                 CASE nOpcao==2 
                      cArquivoRep:= "FCEA" 
                 CASE nOpcao==3 
                      cArquivoRep:= "FCAS" 
                 CASE nOpcao==4 
                      cArquivoRep:= "FCAA" 
              ENDCASE 
 
              IF nOpcao <= 4 
                 IF Confirma( 0, 0, "Gerar Informacoes?", "S", "S" ) 
                    IF FILE( SWSet( _SYS_DIRREPORT ) - "\" + cArquivoRep + StrZero( nEmpresa, 04, 00 ) + ".REP" ) 
                       Relatorio( cArquivoRep + StrZero( nEmpresa, 04, 00 ) + ".REP" ) 
                    ELSE 
                       Relatorio( cArquivoRep + "0000.REP" ) 
                    ENDIF 
                 ENDIF 
              ENDIF 
 
         otherwise          ;tone(125); tone(300) 
      endcase 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   ENDDO 
 
 
 
 
 
 
 
 
Function VisualConveniados() 
 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= setColor(),; 
      nCursor:= SetCursor() 
Local dDataIni:= DATE(), dDataFim:= DATE() 
Local nEmpresa:= 0, nBanco:= 0 
Local aStr:= {} 
 
 
  VPBox( 00, 00, 22, 79, " EXTRATO [ CONVENIO ] ", _COR_BROW_BOX ) 
  SetColor( _COR_BROWSE ) 
  @ 02,02 Say "Folha - Empresa........:" Get nEmpresa Pict "@r 999999" 
  READ 
  IF LastKey()==K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  aStr:= {{"CLIENT","N",06,00},; 
          {"CODIGO","C",15,00},; 
          {"DESCRI","C",45,00},; 
          {"PRODUT","C",45,00},; 
          {"TIPO__","C",01,00},; 
          {"QUANT_","N",16,03},; 
          {"VALOR_","N",16,02},; 
          {"DATA__","D",08,00},; 
          {"CUPOM_","N",08,00}} 
  // Tipo=1-Regisstro do Cliente..... 2-Registro Cupom.... 3-Detalhe Cupom 
 
  DBSelectAr( 123 ) 
  DBCreate( "EMPTEMP.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Use EMPTEMP.TMP Alias TMP 
 
  DBSelectAr( _COD_CUPOM ) 
  DBSetOrder( 4 ) 
  dbGoTop() 
 
  DBSelectAr( _COD_CLIENTE ) 
  DBGoTop() 
 
  WHILE !EOF() 
      /// LOCALIZACAO E REGISTRO DE CLIENTE NA BASE DE DADOS 
      IF CLI->FOLEMP==nEmpresa 
         TMP->( DBAppend() ) 
         Replace TMP->DESCRI With CLI->DESCRI,; 
                 TMP->CODIGO With CLI->FOLCOD,; 
                 TMP->TIPO__ With "1",; 
                 TMP->CLIENT With CLI->CODIGO 
      ENDIF 
      CLI->( DBSkip() ) 
  ENDDO 
 
  DisplayConveniados( nEmpresa ) 
 
  DBSelectAr( 123 ) 
  DBCloseArea() 
 
  DBSelectAr( _COD_CLIENTE ) 
 
  SetColor( cCor ) 
  ScreenRest( cTela ) 
  SetCursor( nCursor ) 
  Return Nil 
 
Function DisplayConveniados( nEmpresa ) 
 
   DBSelectAr( 123 ) 
   DBGoTop() 
   nTotal:= 0 
   nQuant:= 0 
   VPBox( 03, 01, 17, 78, "CONVENIADOS EMPRESA " + Str( nEmpresa, 08, 00 ), _COR_BROW_BOX ) 
   VPBox( 18, 01, 21, 78, "TOTAL", _COR_BROW_BOX ) 
   WHILE !TMP->( EOF() ) 
      nTotal:= nTotal + TMP->VALOR_ 
      nQuant:= nQuant + 1 
      TMP->( DBSkip() ) 
      @ 19,02 Say "Total de " + Alltrim( Tran( nQuant, "@E 999,999,999.999" ) ) + " conveniado(s)..." 
   ENDDO 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   INDEX ON DESCRI TO INDKK2 FOR VAL( TIPO__ ) >= 0 
   DBGoTop() 
 
   oTAB:=tbrowseDB(04,02,16,77) 
   oTAB:addcolumn(tbcolumnnew(,{|| CODIGO + " " + IIF( TIPO__=="1", DESCRI, IF( TIPO__=="2", "  * Cupom *" + StrZero( CUPOM_, 8, 0 ) + " " + DTOC( DATA__ ), "     " + PRODUT + Tran( VALOR_, "@E 999,999.999" ) ) )+ SPACE( 60 ) })) 
   oTAB:AUTOLITE:=.f. 
   oTAB:dehilite() 
   WHILE .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTAB:stabilize() 
      end 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_UP         ;oTAB:up() 
         case TECLA==K_DOWN       ;oTAB:down() 
         case TECLA==K_LEFT       ;oTAB:up() 
         case TECLA==K_RIGHT      ;oTAB:down() 
         case TECLA==K_PGUP       ;oTAB:pageup() 
         case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
         case TECLA==K_PGDN       ;oTAB:pagedown() 
         case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
         case TECLA==K_ENTER 
         case TECLA==K_TAB 
              IF Confirma( 0, 0, "Gerar relacao de conveniados desta empresa?", "S", "S" ) 
                 Relatorio( "RELACAOC.REP" ) 
              ENDIF 
         otherwise          ;tone(125); tone(300) 
      endcase 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   ENDDO 
 
 
 
