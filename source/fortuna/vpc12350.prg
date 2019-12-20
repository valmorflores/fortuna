// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � Transferencia() 
� Finalidade  � Transferencia de Informacoes entre empresas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 3/Janeiro/2000 
� Atualizacao � 
��������������� 
*/ 
Function Transferencia() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local aUnidade:= { Space( 60 ), Space( 60 ) } 
Local nRow:= 1 
Local nTecla:= 0, nVaiVem:= 2, aDir:= {}, aOpcoes:= {} 
Local cBuffer, nCt, nHandle, nOpcao, aBotao 
Local cCorFundo, cDiretorio, cInformacao 
Private cDirEmp 
 
 DBCloseAll() 
 /* Carregamento dos Titulos dos EXF */ 
 cDiretorio:= AllTrim( SWSet( _SYS_DIRREPORT ) ) 
 aDir:= DIRECTORY( cDiretorio + "\*.EXF" ) 
 cBuffer:= Space( 30 ) 
 FOR nCt:= 1 TO Len( aDir ) 
     Mensagem( cDiretorio + "\" + aDir[ nCt ][ 1 ] ) 
     IF File( cDiretorio + "\" + aDir[ nCt ][ 1 ] ) 
        cInformacao:= MEMOREAD( cDiretorio + "\" + aDir[ nCt ][ 1 ] ) 
        AAdd( aOpcoes, { SubStr( cInformacao, 11, 30 ), " ", aDir[ nCt ][ 1 ] } ) 
     ENDIF 
     nHandle:= 0 
 NEXT 
 IF Len( aOpcoes ) <= 0 
    Aviso( "N�o Existem Arquivos de Filtros Disponiveis. Contacte o Suporte Tecnico." ) 
    Pausa() 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 ENDIF 
 /*******************/ 
 
 /* ordena os itens da relacao de opcoes */ 
 ASort( aOpcoes,,, {|x, y| x[ 1 ] < y[ 1 ] } ) 
 
 /* Fecha todos os arquivos do Fortuna */ 
 Sele 124 
 IF !Used() 
    cDirEmp:= SWSet( _SYS_DIRREPORT ) + "\EMPRESAS.DBF" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    Use &cDirEmp Alias EMP 
 ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
 Index On CODIGO To INDICE0_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
 Index On DESCRI To INDICE1_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
 SET INDEX TO INDICE0_.NTX, INDICE1_.NTX 
 DBGoTop() 
 
 Sele 124 
 
 VPBox( 00, 00, 22, 79, "TRANSFERENCIA DE INFORMACOES" ) 
 VPBox( 04, 41, 18, 77, "Empresa Secundaria", _COR_GET_EDICAO, .F.,.F. ) 
 
 @ 02,30 Say "�������������������Ŀ" Color "14/" + CorFundoAtual() 
 @ 03,30 Say "�                   " Color "14/" + CorFundoAtual() 
 
 @ 01,03 Say LEFT( ALLTRIM( _EMP ), 33 ) 
 @ 02,03 Say "Ultima Transferencia " 
 @ 03,03 Say DTOC( DATE() ) + " " + TIME() + "Hs." 
 @ 08,03 Say "���������������������������������" 
 @ 09,03 Say "Informacoes Selecionadas.        " 
 
 aBotao:= { { 20, 05, " Iniciar Transferencia ", CorFundoAtual() },; 
            { 20, 35, " << ",       CorFundoAtual() },; 
            { 20, 45, " >> ",       CorFundoAtual() },; 
            { 20, 56, " Cancelar ", CorFundoAtual() } } 
 
 cCorFundo:= CorFundoAtual() 
 nOpcao:= 1 
 BotoesDown( aBotao, nTecla, 0 ) 
 
 Mensagem( "["+ Chr(27) + Chr(26) + "][ENTER]Botoes []Opcoes [ESC]Sair" ) 
 Ajuda( "Escolha a empresa de origem/destino use <Iniciar Transferencia> ") 
 SetColor( "15/04, 00/14" ) 
 VPBoxSombra( 04, 02, 17, 37,, "15/04", "00/01" ) 
 
 oTAB:=tbrowsenew( 05, 03, 16, 36 ) 
 oTAB:addcolumn(tbcolumnnew(,{|| Pad( aOpcoes[nROW][1], 33 ) + aOpcoes[nRow][ 2 ] })) 
 oTAB:AUTOLITE:=.f. 
 oTAB:GOTOPBLOCK :={|| nROW:=1} 
 oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aOpcoes)} 
 oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aOpcoes,@nROW)} 
 oTAB:dehilite() 
 lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
 WHILE .T. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
     WHILE nextkey()==0 .and. ! oTAB:stabilize() 
     ENDDO 
     nTecla:= Inkey(0) 
     BotoesDown( aBotao, nTecla, @nOpcao ) 
     IF nTecla==K_ESC 
        nOpcao:= 0 
        exit 
     ENDIF 
     cTelaG:= ScreenSave( 0, 0, 24, 79 ) 
     DO CASE 
        CASE nTecla==K_UP         ;oTAB:up() 
        CASE nTecla==K_DOWN       ;oTAB:down() 
        CASE nTecla==K_PGUP       ;oTAB:pageup() 
        CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
        CASE nTecla==K_PGDN       ;oTAB:pagedown() 
        CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
        CASE nTecla==K_F12        ;Calculador() 
        CASE nTecla==K_CTRL_A 
             FOR nCt:= 1 TO Len( aOpcoes ) 
                 aOpcoes[ nCt ][ 2 ]:= "" 
             NEXT 
             oTab:RefreshAll() 
             WHILE !oTab:Stabilize() 
             ENDDO 
 
        CASE nTecla==K_SPACE 
             IF !( aOpcoes[ nRow ][ 2 ] == "-" ) 
                aOpcoes[ nRow ][ 2 ]:= IF( aOpcoes[ nRow ][ 2 ]==" ", "", " " ) 
             ENDIF 
 
        CASE nTecla==K_CTRL_LEFT 
             nOpcao:= 2 
             BotoesDown( aBotao, K_ENTER, nOpcao ) 
 
        CASE nTecla==K_CTRL_RIGHT 
             nOpcao:= 3 
             BotoesDown( aBotao, K_ENTER, nOpcao ) 
 
        CASE nTecla==K_TAB 
             SeleEmpresa( oTab, @nOpcao, aBotao ) 
             @ 01,43 Say PAD( ALLTRIM( EMP->DESCRI ), 33 ) 
 
        CASE nTecla==K_ENTER 
             IF nOpcao==4 
                Keyboard Chr( K_ESC ) 
             ENDIF 
             IF nOpcao==1 
                IF nVaiVem==1 
                   nEscolha:= SWAlerta( "IMPORTACAO DE INFORMACOES;Os dados ser�o importados do diretorio;" + alltrim( aUnidade[ 1 ] ) + ".", {"Confirmar", "Cancelar", "Trocar Local"} ) 
                   IF nEscolha==1 
                      Importar( aOpcoes, aUnidade ) 
                   ELSEIF nEscolha==3 
                      TrocaUnidades( aUnidade ) 
                   ENDIF 
                ELSEIF nVaiVem==2 
                   nEscolha:= SWAlerta( "EXPORTACAO DE INFORMACOES;Os dados ser�o gravados no diretorio ;" + alltrim( aUnidade[ 2 ] ) + "", {"Confirmar", "Cancelar", "Trocar Local"} ) 
                   IF nEscolha==1 
                      Exportar( aOpcoes, aUnidade ) 
                   ELSEIF nEscolha==3 
                      TrocaUnidades( aUnidade ) 
                   ENDIF 
                ENDIF 
             ELSEIF nOpcao==2 
                nVaiVem:= 1 
                @ 02,30 Say "�������������������Ŀ" Color "14/"  + cCorFundo 
                @ 03,30 Say "                   �" Color "14/" + cCorFundo 
             ELSEIF nOpcao==3 
                nVaiVem:= 2 
                @ 02,30 Say "�������������������Ŀ" Color "14/"  + cCorFundo 
                @ 03,30 Say "�                   " Color "14/" + cCorFundo 
             ENDIF 
        OTHERWISE 
     ENDCASE 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
 ENDDO 
 Set( _SET_DELIMITERS, lDelimiters ) 
 dbunlockall() 
 FechaArquivos() 
 DBCloseAll() 
 AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
 
 ScreenRest( cTela ) 
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 Return Nil 
 
 
 Static Function TrocaUnidades( aUnidade ) 
 Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor() 
 
 VPBox( 08, 10, 14, 70, "Local de Origem/Destino dos dados", _COR_GET_EDICAO ) 
 SetColor( _COR_GET_EDICAO ) 
 @ 10,13 Say "Origem.:" Get aUnidade[ 1 ] Pict "@S45" 
 @ 12,13 Say "Destino:" Get aUnidade[ 2 ] Pict "@S45" 
 READ 
 SetColor( cCor ) 
 ScreenRest( cTela ) 
 Return Nil 
 
 
 Static Function Importar( aOpcoes, aLocalGravacao ) 
 Local lFinaliza:= .F. 
 Local cCor:= SetColor(), cTela:= ScreenSAve( 0, 0, 24, 79 ) 
 Local nCtFiles 
 Local aHandle:= {}, nCont 
 Local nCt, aCampos:= {} 
 Local cLocalGravacao:= Nil 
 Local nqtdFile:= 0 
 
 /* Elimina arquivos de Log */ 
 aeval( directory("DUPLIC00.*"), {|ARQ| FErase( ARQ[ 1 ] ) } ) 
 
 IF aLocalGravacao[ 2 ]==Nil 
    cLocalGravacao:= "" + CURDIR() + "\TRANSF" 
 ELSEIF Empty( aLocalGravacao[ 2 ] ) 
    cLocalGravacao:= "" + CURDIR() + "\TRANSF" 
 ELSE 
    cLocalGravacao:= aLocalGravacao[ 1 ] 
 ENDIF 
 IF !Diretorio( cLocalGravacao ) 
    SWAlerta( "Local de gravacao invalido ou inexistente.", { "  OK  " } ) 
 ENDIF 
 FOR nCt:= 1 TO Len( aOpcoes )            // Navega por todas as opcoes Filtros 
    IF !( aOpcoes[ nCt ][ 2 ]==" " )      // Verifica se esta marcado 
 
       cFile:= LEFT( aOpcoes[ nCt ][ 3 ], AT( ".", aOpcoes[ nCt ][ 3 ] )-1 ) + ".DBF" 
 
       /* ARRAY DE INDICES */ 
       aIndice:= {} 
       aIndiceUnico:= {} 
       aFileFuncoes:= IOFillText( MEMOREAD( SWSet( _SYS_DIRREPORT ) - "\" - aOpcoes[ nCt ][ 3 ] ) ) 
       FOR nCt00:= 1 TO Len( aFileFuncoes ) 
           IF Left( aFileFuncoes[ nCt00 ], 10 )=="INDICE   ." 
              cIndice:= ALLTRIM( SubStr( aFileFuncoes[ nCt00 ], AT( ".", aFileFuncoes[ nCt00 ] ) + 1  ) ) 
              AAdd( aIndice, cIndice ) 
           ELSEIF Left( aFileFuncoes[ nCt00 ], 10 )=="INDICEUNI." 
              cIndice:= ALLTRIM( SubStr( aFileFuncoes[ nCt00 ], AT( ".", aFileFuncoes[ nCt00 ] ) + 1  ) ) 
              AAdd( aIndiceUnico, cIndice ) 
           ENDIF 
       NEXT 
 
       /* Exibe Informacoes coletadas em status */ 
       @ 03,04 Say PAD( aOpcoes[ nCt ][ 1 ] + Space( 20 ) + "[ " + ; 
            cFile + " " + StrZero( BuscaArea( LEFT( aOpcoes[ nCt ][ 3 ],; 
                AT( ".", aOpcoes[ nCt ][ 3 ] )-1 ) + ".DBF" ),; 
                     03, 00 ) + " ]", 65 ) Color "04/07" 
 
       DBCloseAll() 
 
       nCtFiles:= 0 
 
       /* Adicionar em aArquivos os correspondentes as 
          leitura atual na lista de opcoes ex. 
          Caso em aOpcoes esteja em clientes, sera adicionado 
          em aArquivo:= { "CLIE0001.TXT", "CLIE0002.TXT", ...., "CLIE0005.TXT" } */ 
 
       aArquivos:= {} 
       FOR nCtFiles:= 1 TO 50 
           /* Pega o nome do arquivo */ 
           cArqDados:= cLocalGravacao + "\" + Alltrim( Left( aOpcoes[ nCt ][ 3 ], 4 ) + ; 
                                              StrZero( nCtFiles, 4, 0 ) + ".TXT" ) 
           IF File( cArqDados ) 
              AAdd( aArquivos, cArqDados ) 
           ENDIF 
       NEXT 
 
       /* Verifica se existe arquivos relacionados */ 
       IF Len( aArquivos ) > 0 
 
          /* Busca a area de trabalho no arquivo GRUPODBF p/ a posicao em aOpcoes ex. CLIENTES.DBF */ 
          IF ( nAreaFile:= BuscaArea( LEFT( aOpcoes[ nCt ][ 3 ], AT( ".", aOpcoes[ nCt ][ 3 ] )-1 ) + ".DBF" ) ) > 0 
 
              /* Abre o arquivo */ 
              IF fdbUseVpb( nAreaFile, 2,, .F. ) 
 
                 /* 
                 DBSelectAr( nAreaFile ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Set Index To 
                 FErase( "IND001.NTX" ) 
                 FErase( "IND002.NTX" ) 
                 FErase( "IND003.NTX" ) 
                 FErase( "IND004.NTX" ) 
                 FErase( "IND005.NTX" ) 
                 */ 
 
                 /* INDEXA O ARQUIVO RECEPTOR */ 
                 /* 
                 FOR nCtIndex:= 1 TO Len( aIndice ) 
                     cIndice:= ALLTRIM( aIndice[ nCtIndex ] ) 
                     cNumero:= StrZero( nCtIndex, 3, 0 ) + "" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     INDEX ON &cIndice TO IND&cNumero 
                 NEXT 
                 */ 
 
                 /* Conforme a quantidade de indices criados */ 
                 /* 
                 IF FILE( "IND005.NTX" )       ;Set Index To ind001, ind002, ind003, ind004, ind005 
                 ELSEIF FILE( "IND004.NTX" )   ;Set Index To ind001, ind002, ind003, ind004 
                 ELSEIF FILE( "IND003.NTX" )   ;Set Index To ind001, ind002, ind003 
                 ELSEIF FILE( "IND002.NTX" )   ;Set Index To ind001, ind002 
                 ELSEIF FILE( "IND001.NTX" )   ;Set Index To ind001 
                 ENDIF 
                 DBGoTop() 
                 */ 
                 /* Pega a Estrutura do arquivo */ 
                 aStr:= DBStruct() 
                 DBSelectAr( 1 ) 
 
                 cCampoInfo:= "" 
 
                 /* Em aCampos (array multidimensional) ser�o armazenadas 
                    as informacoes dos campos dos arquivos ex. inform. 
                    de CLIE0001, CLIE0002 ..., na mesma sequencia em que 
                    forem abertos */ 
 
                 aCampos:= 0 
                 aCampos:= {} 
 
                 /* Define area apartir de 123 */ 
                 nAreaTmp:= 123 
 
                 FOR nCtFiles:= 1 TO Len( aArquivos ) 
 
                     IF File( aArquivos[ nCtFiles ] ) 
                        cArqDados:= aArquivos[ nCtFiles ] 
 
                        DBSelectAr( ++nAreaTmp ) 
                        cAreaTmp:= StrZero( nAreaTmp, 3, 0 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                        Use &cArqDados Alias IE&cAreaTmp 
                        DBGoBottom() 
 
                        /* Posiciona no primeiro campo */ 
                        WHILE !LEFT( DADOS_, 2 )=="R1" .AND. !BOF() 
                             DBSkip(-1) 
                        ENDDO 
                        DBSkip( 1 ) 
 
                        /* Adiciona em aCampos um elemento correspondente ao 
                           arquivo de exportacao atual ex. CLIE0001.TXT onde 
                           ser�o jogadas as informacoes dos arquivos, sequentemente */ 
 
                        AAdd( aCampos, {} ) 
                        cCampoInfo:= "" 
 
                        WHILE LEFT( DADOS_, 2 )=="Z1" 
                            FOR nCtStr:= 3 TO Len( ALLTRIM( DADOS_ ) ) 
                               IF nCtStr < 390 
                                  IF !SubStr( DADOS_, nCtStr, 1 )=="*" 
                                     cCampoInfo:= cCampoInfo + SubStr( DADOS_, nCtStr, 1 ) 
                                  ELSE 
                                     AAdd( aCampos[ nCtFiles ], { Left( cCampoInfo, 6 ), SubStr( cCampoInfo, 7, 1 ),; 
                                                  VAL( SubStr( cCampoInfo, 8, 03 ) ), VAL( SubStr( cCampoInfo, 11, 03 ) ) } ) 
                                     cCampoInfo:= "" 
                                  ENDIF 
                               ENDIF 
                            NEXT 
                            DBSkip() 
                        ENDDO 
                        DBGoTop() 
                        WHILE !LEFT( DADOS_, 2 )=="R1" 
                            DBSkip() 
                            IF EOF() 
                               DBGoTop() 
                               EXIT 
                            ENDIF 
                        ENDDO 
 
                     ENDIF 
                 NEXT 
 
                 DBSelectAr( nAreaFile ) 
                 DispInfoCampos( aCampos ) 
 
                 /* Posiciona na primeira area p/ importacao */ 
                 nAreaTmp:= 123 
                 DBSelectAr( ++nAreaTmp ) 
 
                 nReg:= 0 
                 lRepetido:= .F. 
                 DBGoTop() 
                 WHILE !EOF() 
 
                     ++nReg 
                     DBSelectAr( nAreaFile ) 
 
                     /* BUSCA INFORMACAO DUPLICADA */ 
                     lRepetido:= .F. 
 
                     IF !lRepetido 
 
                        /* Abre registro no arquivo principal */ 
                        DBAppend() 
 
                        /* posiciona na primeira area */ 
                        nAreaTmp:= 123 
 
                        IF netrlock() 
 
                           /* Passa p/todos os arquivos ex. CLIE0001, CLIE0002, .... */ 
                           FOR nCtFiles:= 1 TO Len( aArquivos ) 
 
                               @ 04,04 Say StrZero( nCtFiles, 6, 0 ) + "/" + StrZero( Len( aArquivos ), 6, 0 ) 
                               DBSelectar( ++nAreaTmp ) 
                               DBSkip() 
                               cInformacao:= DADOS_ 
                               @ 08,04 Say StrZero( nAreaTmp, 6, 0 ) 
 
                               IF Left( cInformacao, 2 )=="R1" 
 
                                  @ 05,04 Say StrZero( nAreaTmp, 06, 0 ) 
                                  @ 07,04 Say StrZero( nReg, 06, 0 ) 
                                  DBSelectAr( nAreaFile ) 
 
                                  FOR nCont:= 1 TO Len( aCampos[ nCtFiles ] ) 
 
                                      @ 06,04 Say StrZero( nCont, 06, 0 ) 
                                      cCampo:= aCampos[ nCtFiles ][ nCont ][ 1 ] 
                                      nPosicao:= 0 
 
                                      FOR nTotal:= 1 TO Len( aCampos[ nCtFiles ] ) 
                                          IF !( aCampos[ nCtFiles ][ nTotal ][ 1 ] == aCampos[ nCtFiles ][ nCont ][ 1 ] ) 
                                             nPosicao:= nPosicao + aCampos[ nCtFiles ][ nTotal ][ 3 ] 
                                             //+ aCampos[ nCtFiles ][ nTotal ][ 4 ] 
                                          ELSE 
                                             EXIT 
                                          ENDIF 
                                      NEXT 
 
                                      IF FIELDPOS( cCampo ) > 0 
                                         lGrava:= .T. 
                                         cConteudo:= SubStr( cInformacao, nPosicao + 3, aCampos[ nCtFiles ][ nCont ][ 3 ] ) 
                                         @ 03,04 Say cCampo + " [" + Space( 55 ) + "]" Color "09/07" 
                                         @ 03,13 Say PAD( cConteudo, 53 ) Color "04/07" 
                                         //Inkey(1) 
                                         IF ValType( &cCampo )=="N" 
                                            cConteudo:= VAL( cConteudo ) 
                                            IF LEN( Alltrim( Str( INT( cConteudo ) ) ) ) > ( ValSize( Alltrim( cCampo ) ) - ValDec( Alltrim( cCampo ) ) ) 
                                               @ 03,04 Say PAD( "Tamanho da Informacao Incompativel com Campo", 65 ) Color "02/07" 
                                               lGrava:= .F. 
                                            ENDIF 
                                         ELSEIF ValType( &cCampo )=="D" 
                                            cConteudo:= CTOD( cConteudo ) 
                                         ENDIF 
                                         IF lGrava 
                                            _FIELD->&cCampo:= cConteudo 
                                         ENDIF 
                                      ELSE 
                                         @ 03,04 Say PAD( "Campo N�o Localizado", 65 ) Color "02/07" 
                                      ENDIF 
                                      Inkey() 
                                      IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
                                         lFinaliza:= .T. 
                                         EXIT 
                                      ENDIF 
                                  NEXT 
                                  IF lFinaliza 
                                     EXIT 
                                  ENDIF 
                               ENDIF 
 
                           NEXT 
                           IF lFinaliza 
                              EXIT 
                           ENDIF 
 
                        ENDIF 
 
                     ELSE 
 
                        /* Se for repetido - skip em todos os arquivos */ 
                        FOR nX:= 125 TO 135 
                           DBSelectAr( nX ) 
                           IF Used() 
                              DBSkip() 
                           ENDIF 
                        NEXT 
 
                     ENDIF 
 
                     /* Posiciona novamente na 1a. Area */ 
                     nAreaTmp:= 123 
                     DBSelectAr( ++nAreaTmp ) 
                     IF lFinaliza 
                        EXIT 
                     ENDIF 
 
                 ENDDO 
 
                 /* BUSCA INDICE COM aIndice */ 
                 FOR nCtIndice:= 1 TO Len( aIndice ) 
                     EliminaDuplicidade( aIndice[ nCtIndice ], nAreaFile ) 
                 NEXT 
                 FOR nCtIndice:= 1 TO Len( aIndiceUnico ) 
                     EliminaDuplicidade( aIndiceUnico[ nCtIndice ], nAreaFile, 1 ) 
                 NEXT 
 
              ENDIF 
           ENDIF 
       ENDIF 
    ENDIF 
    IF lFinaliza 
       EXIT 
    ENDIF 
 NEXT 
 nEscolha:= SWAlerta( "OPERACAO FINALIZADA;As informacoes foram Importadas;Deseja verificar os LOGs de exclusoes?", { "Nao", "Sim" } ) 
 IF nEscolha==1 
    aeval( directory("DUPLIC00.*"), {|ARQ| ViewFile( ARQ[ 1 ] ) } ) 
 ENDIF 
 ScreenRest( cTela ) 
 SetColor( cCor ) 
 Return Nil 
 
 
Static Function DispInfoCampos( aCampos ) 
Local cCor:= SetColor() 
Local nCt, nLin:= 2, nCol:= 2 
 
  VPBox( 02, 02, 22, 77, "INFORMACOES DE CAMPOS A IMPORTAR", "08/07" ) 
  nCtRes:= 0 
  FOR nCt:= 1 TO Len( aCampos ) 
      IF !( nCtRes == nCt ) 
         nLin:= 3 
         nCtRes:= nCt 
         IF nCtRes==1 
            nCol:= 04 
         ELSEIF nCtRes==2 
            nCol:= 24 
         ELSEIF nCtRes==3 
            nCol:= 44 
         ELSEIF nCtRes==4 
            nCol:= 64 
         ENDIF 
      ENDIF 
      FOR nCt2:= 1 TO Len( aCampos[ nCt ] ) 
          IF nLin+1==21 
             nCol:= nCol + 10 
             nLin:= 3 
          ENDIF 
          IF nCol < 70 
             IF FIELDPOS( aCampos[ nCt ][ nCt2 ][ 1 ] ) > 0 
                @ ++nLin, nCol Say aCampos[ nCt ][ nCt2 ][ 1 ] Color "01/07" 
             ELSE 
                @ ++nLin, nCol Say aCampos[ nCt ][ nCt2 ][ 1 ] Color "04/07" 
             ENDIF 
          ENDIF 
      NEXT 
  NEXT 
  SetColor( cCor ) 
  Return Nil 
 
 
 
 Static Function Exportar( aOpcoes, aLocalGravacao ) 
 Local lFinaliza:= .F. 
 Local cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
 Local cGravar 
 Local cCabecalho 
 Local aCampos:= {} 
 Local nCt, nAreaFile, nCtField, aStr, nLimiteLateral:= 390 
 Local aHandle:= {}, nCont:= 0, nQtdFile:= 0 
 Local cLocalGravacao:= Nil 
 Private cFile, cInformacao 
 IF aLocalGravacao[ 2 ]==Nil 
    cLocalGravacao:= "" + CURDIR() + "\TRANSF" 
 ELSEIF Empty( aLocalGravacao[ 2 ] ) 
    cLocalGravacao:= "" + CURDIR() + "\TRANSF" 
 ELSE 
    cLocalGravacao:= aLocalGravacao[ 2 ] 
 ENDIF 
 Status() 
 Status( "Analisando... " + ALLTRIM( cLocalGravacao ) ) 
 WHILE !Diretorio( cLocalGravacao ) 
    nEscolha:= SWAlerta( "ATENCAO!;O diretorio de gravacao;" + alltrim( cLocalGravacao ) + ";nao existe! O que voce deseja fazer?", {"Criar", "Cancelar" } ) 
    IF nEscolha==1 
       cDirCriar:= cLocalGravacao 
       !MD &cDirCriar >NUL 
    ELSEIF nEscolha==2 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
       Return Nil 
    ENDIF 
 ENDDO 
 Inkey( 1 ) 
 FOR nCt:= 1 TO Len( aOpcoes )            // Navega por todas as opcoes Filtros 
     IF !( aOpcoes[ nCt ][ 2 ]==" " )     // Verifica se esta marcado 
        cFile:= LEFT( aOpcoes[ nCt ][ 3 ], AT( ".", aOpcoes[ nCt ][ 3 ] )-1 ) + ".DBF" 
        Status( aOpcoes[ nCt ][ 1 ] ) 
        Status( Nil, Nil, cFile + " " + StrZero( BuscaArea( LEFT( aOpcoes[ nCt ][ 3 ], AT( ".", aOpcoes[ nCt ][ 3 ] )-1 ) + ".DBF" ), 03, 00 ) ) 
        nCont:= 0 
        nQtdFile:= 0 
        aHandle:= 0 
        aHandle:= {} 
        aCampos:= 0 
        aCampos:= {} 
        IF ( nAreaFile:= BuscaArea( LEFT( aOpcoes[ nCt ][ 3 ], AT( ".", aOpcoes[ nCt ][ 3 ] )-1 ) + ".DBF" ) ) > 0 
           IF fdbUseVpb( nAreaFile, 2,, .F. ) 
              DBSelectAr( nAreaFile ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Set Index To 
              DBGoTop() 
              aStr:= DBStruct() 
              FOR nCtField:= 1 TO Len( aStr ) 
                  IF ( nCont + ( aStr[ nCtField ][ 3 ] + aStr[ nCtField ][ 4 ] ) >= nLimiteLateral ) .OR. nCtField==1 
 
                     /* define novo nome de arquivo pra gravacao */ 
                     cFileExport:= cLocalGravacao + "\" + Alltrim( Left( aOpcoes[ nCt ][ 3 ], 4 ) + ; 
                                              StrZero( ++nQtdFile, 4, 0 ) + ".TXT" ) 
 
                     /* cria nova handle */ 
                     AAdd( aHandle, FCriar( cFileExport ) ) 
 
                     /* cria nova sequencia de campos */ 
                     AAdd( aCampos, aStr[ nCtField ][ 1 ] + aStr[ nCtField ][ 2 ] +; 
                           StrZero( aStr[ nCtField ][ 3 ], 3, 0 ) + ; 
                           StrZero( aStr[ nCtField ][ 4 ], 3, 0 ) + "*" ) 
 
                     /* reinicia a contagem */ 
                     nCont:= aStr[ nCtField ][ 3 ] + aStr[ nCtField ][ 4 ] 
 
                  ELSE 
 
                     /* contagem de campos */ 
                     nCont:= ( nCont + ( aStr[ nCtField ][ 3 ] + aStr[ nCtField ][ 4 ] ) ) 
 
                     /* adiciona o nome/tipo/tamanho/dec do campo */ 
                     aCampos[ Len( aCampos ) ]+= aStr[ nCtField ][ 1 ] + aStr[ nCtField ][ 2 ] +; 
                                        StrZero( aStr[ nCtField ][ 3 ], 3, 0 ) + ; 
                                        StrZero( aStr[ nCtField ][ 4 ], 3, 0 ) + "*" 
 
                  ENDIF 
              NEXT 
 
              /* Cabecalhos nas Handle's */ 
              cCabecalho:= PAD( "R0FORTUNA"+"/EMPRESA\0000P0000", nLimiteLateral ) + StrZero( 1, 10, 0 ) + Chr( 13 ) + Chr( 10 ) 
              FOR nCtFiles:= 1 TO Len( aHandle ) 
                  FGravar( aHandle[ nCtFiles ], cCabecalho, Len( cCabecalho ) ) 
              NEXT 
 
              /* Seleciona Area - Navega no Arquivo e grava as intrucoes na devida handle */ 
              dbSelectAr( nAreaFile ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Set Index To 
              dbGoTop() 
              nQtd:= 1 
 
              aString:= {} 
              aString:= AClone( aHandle ) 
              FOR nCtFiles:= 1 TO LEN( aString ) 
                  aString[ nCtFiles ]:= "" 
              NEXT 
              WHILE !EOF() 
 
                  FOR nCtField:= 1 TO Len( aStr ) 
                      FOR nHandle:= 1 TO Len( aCampos ) 
                          IF AT( aStr[ nCtField ][ 1 ], aCampos[ nHandle ] ) > 0 
                             EXIT 
                          ENDIF 
                      NEXT 
                      IF nHandle > 0 
                         cInformacao:= "" 
                         DO CASE 
                            CASE aStr[ nCtField ][ 2 ]=="N" 
                                 cInformacao:= " StrZero( " + aStr[ nCtField ][ 1 ] + "," + Str( aStr[ nCtField ][ 3 ] ) + "," + Str( aStr[ nCtField ][ 4 ] ) + " )" 
                            CASE aStr[ nCtField ][ 2 ]=="C" 
                                 cInformacao:= aStr[ nCtField ][ 1 ] 
                            CASE aStr[ nCtField ][ 2 ]=="D" 
                                 cInformacao:= " DTOC( " + aStr[ nCtField ][ 1 ] + " )" 
                            CASE aStr[ nCtField ][ 2 ]=="M" 
                                 cInformacao:= "" 
                         ENDCASE 
                         IF ValType( &cInformacao )     == "C" 
                            cInformacao:= &cInformacao 
                         ELSEIF ValType( &cInformacao ) == "N" 
                            cInformacao:= StrTran( StrZero( &cInformacao, aStr[ nCtField ][ 3 ], aStr[ nCtField ][ 4 ] ), ".", "" ) 
                         ELSEIF ValType( &cInformacao ) == "D" 
                            cInformacao:= DTOC( &cInformacao ) 
                         ENDIF 
                         /* acumula informacao */ 
                         aString[ nHandle ]:= aString[ nHandle ] + cInformacao 
                      ENDIF 
                  NEXT 
 
                  ++nQtd 
                  /* R1---grava informacoes */ 
                  FOR nHandle:= 1 TO Len( aHandle ) 
                      aString[ nHandle ]:= PAD( "R1" + aString[ nHandle ], nLimiteLateral ) + StrZero( nQtd, 10, 0 ) + Chr( 13 ) + Chr( 10 ) 
                      /* Registro */ 
                      FGravar( aHandle[ nHandle ], aString[ nHandle ], LEN( aString[ nHandle ] ) ) 
                      aString[ nHandle ]:= "" 
                  NEXT 
                  Status( Nil, Nil, Nil, StrZero( RECNO(), 08, 00 ) + "/" + StrZero( LastRec(), 8, 0 ) + " " + Str( ( RECNO()/LASTREC() ) * 100, 06, 02 ) + "%" ) 
                  INKEY() 
                  IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
                     lFinaliza:= .T. 
                     EXIT 
                  ENDIF 
                  DBSkip() 
 
              ENDDO 
              IF lFinaliza 
                 EXIT 
              ENDIF 
 
              /* Z1---Grava o final nos arquivos que foram gerados para explortacao */ 
              FOR nCtFiles:= 1 TO Len( aHandle ) 
                  cGravar:= PAD( "Z1" + aCampos[ nCtFiles ], nLimiteLateral ) + StrZero( nQtd, 10, 0 ) + Chr( 13 ) + Chr( 10 ) 
                  FGravar( aHandle[ nCtFiles ], cGravar, Len( cGravar ) ) 
                  IF Len( aCampos[ nCtFiles ] ) + 2 > nLimiteLateral 
                     cGravar:= PAD( "Z1" + SubStr( aCampos[ nCtFiles ], nLimiteLateral - 1 ), nLimiteLateral ) + StrZero( ++nQtd, 10, 00 ) + Chr( 13 ) + Chr( 10 ) 
                     FGravar( aHandle[ nCtFiles ], cGravar, Len( cGravar ) ) 
                  ENDIF 
              NEXT 
              IF lFinaliza 
                 EXIT 
              ENDIF 
              DBCloseArea() 
           ENDIF 
        ENDIF 
     ENDIF 
 NEXT 
 Status() 
 Return Nil 
 
 
 Function FGravar( cArquivo, cConteudo ) 
 Local nArea:= Select() 
 Local nHandle 
 Local cString 
 Private cArq:= cArquivo 
 DBSelectAr( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
 Use &cArq Alias ARQ Exclusive 
 IF Used() 
    DBAppend() 
    Replace DADOS_ With cConteudo 
 ENDIF 
 DBCloseArea() 
 DBSelectAr( nArea ) 
 Return Nil 
 
 
 Function FCriar( cArquivo ) 
 DBCreate( cArquivo, {{"DADOS_","C",450,00}} ) 
 Return cArquivo 
 
 Static Function Status( cMensagem, cCampo, cFile, cRegistro ) 
 Static lStatus, cTela 
 IF cMensagem==Nil .AND. cCampo==Nil .AND. cFile==Nil .AND. cRegistro==Nil 
    /* Inicio / Fim */ 
    IF lStatus==Nil 
       cTela:= ScreenSave( 0, 0, 24, 79 ) 
       lStatus:= .T. 
       VPBox( 07, 07, 17, 70, "INFORMACOES DE EXPORTACAO/IMPORTACAO", _COR_GET_EDICAO ) 
    ELSE 
       lStatus:= Nil 
       ScreenRest( cTela ) 
    ENDIF 
 ELSEIF !( cMensagem==Nil ) 
    @ 08,08 Say PAD( cMensagem, 40 ) Color _COR_GET_EDICAO 
 ELSEIF !( cFile==Nil ) 
    @ 09,08 Say pad( cFile, 40 )     Color _COR_GET_EDICAO 
 ELSEIF !( cRegistro==Nil ) 
    @ 10,08 Say pad( cRegistro, 40 ) Color _COR_GET_EDICAO 
 ENDIF 
 Return Nil 
 
 
 Static Function SeleEmpresa( oTb, nOpcao, aBotao ) 
 Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
       nCursor:= SetCursor() 
 Local nTecla 
 Local oTab 
 DBSelectAr( 124 ) 
 SetColor( _COR_GET_EDICAO ) 
 oTab:= TBrowseDB( 05, 42, 17, 76 ) 
 oTAB:addcolumn(tbcolumnnew(,{|| DESCRI })) 
 oTAB:AUTOLITE:=.f. 
 oTAB:dehilite() 
 oTab:RefreshAll() 
 WHILE .T. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
     WHILE nextkey()==0 .and. ! oTAB:stabilize() 
     ENDDO 
     nTecla:= Inkey(0) 
     BotoesDown( aBotao, nTecla, @nOpcao ) 
     IF nTecla==K_ESC 
        EXIT 
     ENDIF 
     DO CASE 
        CASE nTecla==K_UP         ;oTAB:up() 
        CASE nTecla==K_DOWN       ;oTAB:down() 
        CASE nTecla==K_PGUP       ;oTAB:pageup() 
        CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
        CASE nTecla==K_PGDN       ;oTAB:pagedown() 
        CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
        CASE nTecla==K_F12        ;Calculador() 
        CASE nTecla==K_CTRL_LEFT 
             nOpcao:= 2 
             BotoesDown( aBotao, K_ENTER, nOpcao ) 
 
        CASE nTecla==K_CTRL_RIGHT 
             nOpcao:= 3 
             BotoesDown( aBotao, K_ENTER, nOpcao ) 
 
        CASE nTecla==K_TAB 
             Return Nil 
 
        CASE nTecla==K_ENTER 
             Keyboard Chr( K_ESC ) + Chr( K_ENTER ) 
 
        OTHERWISE 
     ENDCASE 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
 
 ENDDO 
 Set( _SET_DELIMITERS, lDelimiters ) 
 dbUnlockAll() 
 ScreenRest( cTela ) 
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 Return Nil 
 
 
 Static Function BotoesDown( aBotao, nTecla, nOpcao ) 
 Local nCt 
 Local lMudou:= .F., nOpcaoAnterior:= nOpcao 
 IF nOpcao==0 
    nOpcao:= 1 
 ELSEIF nTecla==K_LEFT 
    nOpcao:= nOpcao - 1 
 ELSEIF nTecla==K_RIGHT 
    nOpcao:= nOpcao + 1 
 ELSEIF nOpcao==K_ENTER 
    Return nOpcao 
 ENDIF 
 IF nOpcao > Len( aBotao ) 
    nOpcao:= 1 
 ELSEIF nOpcao < 1 
    nOpcao:= Len( aBotao ) 
 ENDIF 
 IF !nOpcaoAnterior==nOpcao 
    FOR nCt:= 1 to len( aBotao ) 
        IF nCt==nOpcao 
           SWBotao( aBotao[ nCt ][ 1 ], aBotao[ nCt ][ 2 ], aBotao[ nCt ][ 3 ], aBotao[ nCt ][ 4 ], "14/04" ) 
        ELSE 
           SWBotao( aBotao[ nCt ][ 1 ], aBotao[ nCt ][ 2 ], aBotao[ nCt ][ 3 ], aBotao[ nCt ][ 4 ] ) 
        ENDIF 
    NEXT 
 ENDIF 
 Return Nil 
 
 
 
Function EliminaDuplicidade( cCampos, nArea, nTipo ) 
Local aStr:= { { "DESCRI","C",120,00 },; 
               { "INDEX_","C",120,00 },; 
               { "RECNO_","N",010,00 } } 
Priv cFieldName:= ALLTRIM( cCampos ) 
 
  nTipo:= IF( nTipo==Nil, 0, nTipo ) 
 
  IF nTipo==0                  /* Flexivel - Comparativo de Semelhanca */ 
     dbSelectAr( 123 ) 
     DBCloseArea() 
     DBCreate( "ARQUIVO.TMP", aStr ) 
 
     /* 1a.Fase - Transferencia de Informacoes p/ arquivo paralelo */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     USE ARQUIVO.TMP Alias TMP 
 
     /* Area a ser eliminada a duplicidade */ 
     DBSelectAr( nArea ) 
     dbgotop() 
 
     WHILE !EOF() 
         cDescri:= &cFieldName 
         cString:= SubStr( cDescri, 1, 3 ) 
         cString:= cString + SubStr( cDescri, Ocorrencia( 1, " ", cDescri ), 5 ) 
         cString:= cString + SubStr( cDescri, Ocorrencia( 2, " ", cDescri ), 4 ) 
         cString:= cString + SubStr( cDescri, Ocorrencia( 3, " ", cDescri ), 3 ) 
         nRegistro:= RECNO() 
 
         DBSelectAr( 123 ) 
         DBAppend() 
         Replace INDEX_ With cString,; 
                 DESCRI With cDescri,; 
                 RECNO_ With nRegistro 
 
         DBSelectAr( nArea ) 
         DBSkip() 
 
     ENDDO 
 
     /* 2a.Fase - Eliminacao de Informacoes duplicadas com base no arquivo paralelo */ 
     DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON INDEX_ TO IN02 
     DBGoTop() 
     cIndice:= "XXXXXXXXXXXX" 
     cDescri:= DESCRI 
     Set( 24, "DUPLIC00." + StrZero( nArea, 03, 00 ) ) 
     Set Device To Printer 
     WHILE !EOF() 
        IF ALLTRIM( cIndice ) == LEFT( INDEX_, LEN( Alltrim( cIndice ) ) ) 
           @ PROW(),PCOL() SAY DESCRI + cDescri + Chr( 13 ) + Chr( 10 ) 
           nRegistro:= RECNO_ 
           DBSelectAr( nArea ) 
           DBGoTo( nRegistro ) 
           IF netrlock() 
              DELE 
           ENDIF 
           DBSelectAr( 123 ) 
        ENDIF 
        cIndice:= INDEX_ 
        cDescri:= DESCRI 
        DBSkip() 
     ENDDO 
  ELSEIF nTipo==1             /* Com Indice Unico s/ codificacao repetida */ 
 
     DBSelectAr( nArea ) 
     DBGoTop() 
     xCampoInfo:= IF( VALTYPE( &cFieldName )=="N", -1, Repl( "�", Len( &cFieldName ) ) ) 
     WHILE !EOF() 
        IF &cFieldName==xCampoInfo 
           IF netrlock() 
              DELE 
           ENDIF 
        ENDIF 
        xCampoInfo:= &cFieldName 
        DBSkip() 
     ENDDO 
     dbGoTop() 
 
  ENDIF 
  Set Printer To LPT1 
  Set Device To Screen 
  dbUnlockAll() 
  Return Nil 
 
