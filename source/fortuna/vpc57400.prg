// ## CL2HB.EXE - Converted
 
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
#Define _MSG_PRODUTO     " Produto                   " 
#Define _MSG_QUANTIDADE  " Quantidade                " 
#Define _MSG_PREVISAO    " Previsao                  " 
#Define _MSG_MATERIAL    " Material utilizado        " 
#Define _MSG_SOLUCAO     " Solucao                   " 
#Define _MSG_DEFEITO     " Defeito                   " 
#Define _MSG_INFORMACAO  " Informacoes Adicionais    " 
#Define _MSG_DIAGNOSTICO " Diagnostico               " 
#Define _MSG_NOTAFISCAL  " Nota Fiscal               " 
#Define _MSG_NOTACOMPRA  " Nota Fiscal / O.Compra    " 
#Define _MSG_OBSERVACAO  " Historico                 " 
#Define _MSG_ERRO        " < INFORMACAO INCOMPLETA > " 
#Define _MSG_GRAVA       " Gravar Informacoes        " 
 
/* 
------------------ [ Rotinas & Utilizacao ] ----------------- 
CFE                = 1>Cliente / 2>Fornecedor / 3>Empresa 
                     (Adquirido da Base de dados dos Setores) 
Rotina Principal   = Montagem da tela, Selecao do Setor e Destinacao da base 
                     de dados em uso para aquisicao de informacoes (CFE) 
FrmDisplay()       = Exibe base de dados correspondente ao (CFE) 
DispInformacoes()  = Exibe informacoes cadastrais de (CFE) 
ExibeOcorrencias() = Mostra alhumas ocorrencias na parte superior da tela, conforme o 
                     espaco disponovel na mesma 
EditOcorrencias()  = Janela de Exibicao das ocorrencias por (CFE) & Setor, 
                     permitindo que o usuario navegue entre elas. caso pressionado 
                     INSERT / ENTER / DELETE inicia a edicao das ocorrencias. 
IncluiOcorrencia() = Responsavel pela inclusao de ficha nova. Inform.Cabecalho 
AlteraOcorrencia() = Responsavel pela alteracao de ficha. Inform.Cabecalho 
EditDetalheOcorr() = Responsavel pela edicao das informacoes detalhe da 
                     ficha de ocorrencias, normalmente chamada pelas rotinas 
                     IncluiOcorrencia, AlteraOcorrencia e ViewOcorrencia 
ExcluiOcorrencia() = Modulo de Exclusao de Ocorrencia/Ficha 
TabAtendimento()   = Pega tabela de atendimento conforme setor, pois podem haver 
                     diferentes metodos de captacao das informacoes conforme os 
                     setores. (ROTINA NAO DEVE SER MUDADA) 
PegaTabela()       = Rotina auxiliar a TabAtendimento(), onde s∆o armazenados os 
                     arrays de possibilidades no que se refere os tipos de 
                     telas e informacoes  a serem captadas. 
                     Esta opcao pode ser modificada, acrescentando-se mais 
                     possibilidades conforme necessario, desde que se facam 
                     as devidas modificacoes na rotina EditOcorrencia 
TipoCobranca()     = Reponsaveis pela exibicao da tabela com tipos de cobranca 
StatusOcorrencia() = Status das fichas 
----------------------------------- 
Programador - Valmor Pereira Flores 
Data        - Abril/2000 
*/


#ifdef HARBOUR
function vpc57400()
#endif


Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(), nCursor:= SetCursor() 
Local nCodSet:= Nil, cSetor:= " REGISTRO DE OCORRENCIAS / ATENDIMENTO " 
 
    FechaGrupo( "ESTOQUE" ) 
    AbreGrupo( "ATENDIMENTO" ) 
 
    VPBox( 00, 00, 23, 79, cSetor, _COR_GET_BOX ) 
    VPBox( 01, 00, 11, 45, , _COR_GET_BOX ) 
    VPBox( 12, 00, 23, 45, "Cliente / Fornecedor / Empresa" , _COR_GET_BOX, .F., .F. ) 
    VPBox( 01, 46, 11, 79, "Informacoes" , _COR_GET_BOX, .F., .F. ) 
    VPBox( 12, 46, 23, 79, "Ocorrencias/Solicitacoes" , _COR_GET_BOX, .F., .F. ) 
 
    /* Seleciona o Setor de Trabalho */ 
    SelecionaSetor( @nCodSet ) 
    SET->( DBSetOrder( 1 ) ) 
    SET->( DBSeek( nCodSet ) ) 
    cSetor:= SET->DESCRI 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    UserModulo( AllTrim( cSetor ) ) 
 
    /* Exibe Informacoes */ 
    WHILE .T. 
       IF SET->BSCCLI=="S" 
          FrmDisplay( 1 ) 
       ELSEIF SET->BSCFOR=="S" 
          FrmDisplay( 2 ) 
       ELSEIF SET->BSCEMP=="S" 
          FrmDisplay( 3 ) 
       ELSEIF !SET->CODCLI==0 
          CLI->( DBSetOrder( 1 ) ) 
          CLI->( DBSeek( SET->CODCLI ) ) 
          DispInformacoes( 1 ) 
          EditOcorrencias( 1 ) 
       ELSEIF !SET->CODFOR==0 
          FOR->( DBSetOrder( 1 ) ) 
          FOR->( DBSeek( SET->CODCLI ) ) 
          DispInformacoes( 2 ) 
          EditOcorrencias( 2 ) 
       ELSEIF !SET->CODEMP==0 
          DispInformacoes( 3 ) 
          DispInformacoes( 3 ) 
       ENDIF 
       DispInformacoes( 1 ) 
       IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
          EXIT 
       ENDIF 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    FechaGrupo( "ATENDIMENTO" ) 
    AbreGrupo(  "TODOS_OS_ARQUIVOS" ) 
    Keyboard Chr( 0 ) 
    Return Nil 
 
 
 
Static Function FrmDisplay( nCodigo ) 
    Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(), nCursor:= SetCursor() 
    Local oTb, nTecla:= 0, nLenCodigo:= 0 
 
    DO CASE 
       CASE nCodigo==1 
            VPBox( 12, 00, 23, 45, "Clientes", _COR_GET_BOX, .F., .F. ) 
            nLenCodigo:= 6 
            DBSelectAr( _COD_CLIENTE ) 
            DBLeOrdem() 
 
       CASE nCodigo==2 
            VPBox( 12, 00, 23, 45, "Fornecedores", _COR_GET_BOX, .F., .F. ) 
            nLenCodigo:= 4 
            DBSelectAr( _COD_FORNECEDOR ) 
            DBLeOrdem() 
 
       CASE nCodigo==3 
            VPBox( 12, 00, 23, 45, "Empresa", _COR_GET_BOX, .F., .F. ) 
            nLenCodigo:= 3 
            DBSelectAr( _COD_FORNECEDOR ) 
 
    ENDCASE 
 
    Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
    SetColor( _COR_GET_EDICAO ) 
 
    /* Inicializacao do objeto browse */ 
    oTb:= TBrowseDB( 13, 01, 22, 44 ) 
    oTb:AddColumn( tbcolumnnew( ,{|| STRZERO( CODIGO, nLenCodigo ) + " " + DESCRI  })) 
    oTb:AddColumn( tbcolumnnew( ,{|| ENDERE + " " + BAIRRO })) 
 
    /* Variaveis do objeto browse */ 
    oTb:AutoLite:=.f. 
    oTb:dehilite() 
 
    WHILE .T. 
 
       /* Ajuste sa barra de selecao */ 
       oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
       WHILE NextKey()=0 .AND. !oTb:Stabilize() 
       ENDDO 
 
       /* Informacoes de Clientes / Fornecedores */ 
       IF Alias()=="CLI" 
          @ 02,01 Say "Informacoes sobre o cliente" Color "14/" + CorFundoAtual() 
       ENDIF 
       @ 03,01 Say "Nome..: " + LEFT( DESCRI, 35 ) 
       @ 04,01 Say "Fantas: " + LEFT( FANTAS, 35 ) 
       @ 05,01 Say "Ender.: " + ENDERE 
       @ 06,01 Say "Bairro: " + BAIRRO 
       @ 07,01 Say "Cidade: " + CIDADE + "-" +ESTADO 
       @ 08,01 Say "Fones.: " + FONE1_ + "-" + FONE2_ 
       IF Alias()=="CLI" 
          @ 09,01 Say "Comp..: " + LEFT( COMPRA, 35 ) 
          @ 10,01 Say "Resp..: " + LEFT( RESPON, 35 ) 
       ENDIF 
 
       /* Exibicao de Ocorrencias */ 
       ExibeOcorrencias( nCodigo ) 
       nTecla:=inkey(0) 
 
       /* Teste da tecla pressionadas */ 
       DO CASE 
          CASE nTecla==K_ESC 
               IF BuscaOcorrencia( nCodigo, oTb )==K_ESC 
                  EXIT 
               ELSE 
                  Keyboard Chr( LastKey() ) 
               ENDIF 
          CASE nTecla==K_UP         ;oTb:up() 
          CASE nTecla==K_LEFT       ;oTb:PanLeft() 
          CASE nTecla==K_RIGHT      ;oTb:PanRight() 
          CASE nTecla==K_DOWN       ;oTb:down() 
          CASE nTecla==K_PGUP       ;oTb:pageup() 
          CASE nTecla==K_PGDN       ;oTb:pagedown() 
          CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
          CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
          CASE DBPesquisa( nTecla, oTb ) 
          CASE nTecla==K_F2 
               DBMudaOrdem( 1, oTb ) 
          CASE nTecla==K_F3 
               DBMudaOrdem( 2, oTb ) 
          CASE nTecla==K_F4 
               DBMudaOrdem( 3, oTb ) 
          CASE nTecla==K_F5 
               IF Alias()=="CLI" 
                  DBMudaOrdem( 6, oTb ) 
               ENDIF 
          CASE DBPesquisa( nTecla, oTb ) 
          CASE DBPesquisa( nTecla, oTb ) 
          CASE nTecla==K_ENTER 
               DispInformacoes( nCodigo ) 
               EditOcorrencias( nCodigo ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          CASE nTecla==K_INS 
               IF nCodigo=1 
                  ClientesInclusao() 
               ENDIF 
          OTHERWISE                 ;Tone(125); Tone(300) 
      ENDCASE 
 
      oTb:RefreshCurrent() 
      oTb:Stabilize() 
 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
Static Function BuscaOcorrencia( nCodigo, oTbRes ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ),; 
         cCor:= SetColor(), nCursor:= SetCursor( 1 ) 
   Local nArea:= Select() 
   Local oTb, nTecla 
   Local nSetReg, nSetOrd 
 
 
    nSetor:= SET->CODIGO 
    nSetReg:= SET->( Recno() ) 
    nSetOrd:= SET->( IndexOrd() ) 
 
    SET->( DBSetOrder( 1 ) ) 
 
    dbSelectAr( _COD_ATEND ) 
    DBLeOrdem() 
 
    Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna [ENTER]Seleciona") 
    SetColor( _COR_GET_EDICAO ) 
 
    /* Inicializacao do objeto browse */ 
    SetColor( _COR_BROWSE ) 
    oTb:= TBrowseDB( 02, 01, 08, 44 ) 
    oTb:AddColumn( tbcolumnnew( ,{|| STRZERO( CODIGO, 8, 0 ) + " " + StrZero( STATUS, 1, 0 ) + " " + DESCRI + " " + DTOC( DATAEM ) })) 
 
    /* Variaveis do objeto browse */ 
    oTb:AutoLite:=.f. 
    oTb:dehilite() 
 
    WHILE .T. 
 
       /* Ajuste sa barra de selecao */ 
       oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
       WHILE NextKey()=0 .AND. !oTb:Stabilize() 
       ENDDO 
 
       SetColor( _COR_GET_EDICAO ) 
 
       SET->( DBSeek( ATD->SETOR_ ) ) 
       IF ATD->STATUS > 0 .AND. ATD->STATUS <= LEN( StatusOcorrencia( ATD->STATUS, {""} ) ) 
          @ 09,01 Say StrZero( SETOR_, 03, 00 ) + " " + IF( SETOR_ <> nSetor, LEFT( SET->DESCRI, 40 ), PAD( "Status: [" + StatusOcorrencia( ATD->STATUS, {""} )[ ATD->STATUS ] + "] ", 40 ) ) 
       ELSE 
          // Status invalido 
          @ 09,01 Say StrZero( SETOR_, 03, 00 ) + " " + IF( SETOR_ <> nSetor, LEFT( SET->DESCRI, 40 ), PAD( "Status: [Indefinido] " + STRZERO( ATD->STATUS, 2, 0 ), 35 ) ) 
       ENDIF 
 
       @ 10,01 Say "Ficha Emitida em " + DTOC( DATAEM ) + " por " + Left( ATD->ATEND_, 14 ) 
 
       IF LEFT( CODCFE, 1 )=="C" 
          DBSelectAr( _COD_CLIENTE ) 
          oTbRes:GoTop() 
          CLI->( DBSetOrder( 1 ) ) 
          CLI->( DBSeek( Val( ALLTRIM( SubStr( ATD->CODCFE, 2 ) ) ) ) ) 
          DBLeOrdem() 
          oTbRes:RefreshAll() 
          WHILE !oTbRes:Stabilize() 
          ENDDO 
 
       ELSEIF LEFT( CODCFE, 1 )=="F" 
          DBSelectAr( _COD_FORNECEDOR ) 
          oTbRes:GoTop() 
          FOR->( DBSetOrder( 1 ) ) 
          FOR->( DBSeek( Val( ALLTRIM( SubStr( ATD->CODCFE, 2 ) ) ) ) ) 
          DBLeOrdem() 
          oTbRes:RefreshAll() 
          WHILE !oTbRes:Stabilize() 
          ENDDO 
 
       ELSEIF LEFT( CODCFE, 1 )=="E" 
          oTbRes:GoTop() 
 
       ENDIF 
       DBSelectAr( _COD_ATEND ) 
 
       SetColor( _COR_BROWSE ) 
       nTecla:=inkey(0) 
       IF nTecla==K_ESC 
          EXIT 
       ENDIF 
 
       /* Teste da tecla pressionadas */ 
       DO CASE 
          CASE nTecla==K_TAB .OR. nTecla==K_ENTER 
               EXIT 
          CASE nTecla==K_UP         ;oTb:up() 
          CASE nTecla==K_LEFT       ;oTb:PanLeft() 
          CASE nTecla==K_RIGHT      ;oTb:PanRight() 
          CASE nTecla==K_DOWN       ;oTb:down() 
          CASE nTecla==K_PGUP       ;oTb:pageup() 
          CASE nTecla==K_PGDN       ;oTb:pagedown() 
          CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
          CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
          CASE DBPesquisa( nTecla, oTb ) 
          CASE nTecla==K_F2 
               DBMudaOrdem( 1, oTb ) 
          CASE nTecla==K_F3 
               DBMudaOrdem( 2, oTb ) 
          CASE nTecla==K_F4 
               DBMudaOrdem( 3, oTb ) 
          CASE DBPesquisa( nTecla, oTb ) 
          CASE DBPesquisa( nTecla, oTb ) 
          CASE nTecla==K_ENTER 
               DispInformacoes( nCodigo ) 
               EditOcorrencias( nCodigo ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          OTHERWISE                 ;Tone(125); Tone(300) 
      ENDCASE 
 
      oTb:RefreshCurrent() 
      oTb:Stabilize() 
 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    SET->( DBSetOrder( nSetOrd ) ) 
    SET->( dbGoTo( nSetReg ) ) 
    DBSelectAr( nArea ) 
    oTbRes:RefreshAll() 
    WHILE !oTbRes:Stabilize() 
    ENDDO 
    Return nTecla 
 
 
 
 
 
 
Static Function ExibeOcorrencias( nCodigo, oTb ) 
Local nArea:= Select() 
   DO CASE 
      CASE nCodigo==1 
           DBSelectAr( _COD_ATENDAUX ) 
           DBSetOrder( 1 ) 
           IF !oTb==Nil 
              IF oTb:nLeft==1 
                 nLin:= 0 
                 ATA->( DBSeek( ATD->CODIGO ) ) 
                 IF ATA->CODIGO == ATD->CODIGO 
                    @ ++nLin,02 Say Left( ATA->INFORM, LEN( _MSG_PRODUTO ) ) 
                    @ ++nLin,02 Say ATA->HISTO1 
                    @ ++nLin,02 Say Space( 30 ) + " " + ATA->HISTO2 
                    @ ++nLin,02 Say Space( 30 ) + " " + ATA->HISTO3 
                    @ ++nLin,02 Say Space( 30 ) + " " + ATA->HISTO4 
                    @ ++nLin,02 Say Space( 30 ) + " " + ATA->HISTO5 
                    ATA->( DBSkip() ) 
                 ENDIF 
              ENDIF 
           ENDIF 
   ENDCASE 
   DBSelectAr( nArea ) 
   Return Nil 
 
 
Static Function DispInformacoes( nCodigo ) 
    VPBox( 12, 00, 23, 45, "Cliente / Fornecedor / Empresa" , _COR_GET_BOX, .F., .F. ) 
    DO CASE 
       CASE nCodigo==1 
            @ 13, 02 Say "Nome" 
            @ 14, 02 Say "[" + PAD( CLI->DESCRI, 40 ) + "]" 
            @ 15, 02 Say "Endereco" 
            @ 16, 02 Say "[" + CLI->ENDERE + "]" 
            @ 17, 02 Say "[" + CLI->BAIRRO + "]" 
            @ 18, 02 Say "[" + CLI->CIDADE + "]" 
            @ 19, 02 Say "Fone/Fax" 
            @ 20, 02 Say "[" + CLI->FONE1_ + "/" + CLI->FAX___ + "]" 
            @ 21, 02 Say "Comprador" 
            @ 22, 02 Say "[" + CLI->COMPRA + "]" 
       CASE nCodigo==2 
            @ 13, 02 Say "Nome" 
            @ 14, 02 Say "[" + PAD( FOR->DESCRI, 40 ) + "]" 
            @ 15, 02 Say "Endereco" 
            @ 16, 02 Say "[" + FOR->ENDERE + "]" 
            @ 17, 02 Say "[" + FOR->BAIRRO + "]" 
            @ 18, 02 Say "[" + FOR->CIDADE + "]" 
            @ 19, 02 Say "Fone/Fax" 
            @ 20, 02 Say "[" + FOR->FONE1_ + "/" + FOR->FAX___ + "]" 
            @ 21, 02 Say "Vendedor/Contato" 
            @ 22, 02 Say "[" + FOR->VENDED + "]" 
       CASE nCodigo==3 
            @ 13, 02 Say "Nome" 
            @ 14, 02 Say "[" + PAD( FOR->DESCRI, 40 ) + "]" 
            @ 15, 02 Say "Endereco" 
            @ 16, 02 Say "[" + FOR->ENDERE + "]" 
            @ 17, 02 Say "[" + FOR->BAIRRO + "]" 
            @ 18, 02 Say "[" + FOR->CIDADE + "]" 
            @ 19, 02 Say "Fone/Fax" 
            @ 20, 02 Say "[" + FOR->FONE1_ + "/" + FOR->FAX___ + "]" 
            @ 21, 02 Say "Vendedor/Contato" 
            @ 22, 02 Say "[" + FOR->VENDED + "]" 
    ENDCASE 
    Return Nil 
 
 
Static Function EditOcorrencias( nCodigo ) 
   Local nArea:= Select() 
   Local nRow:= 1 
   Local oTb 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor() 
   Local aAtdCFE:= {} 
 
   /* Ajusta codigo cfe. FORNECEDOR / CLIENTE / EMPRESA */ 
   IF nCodigo==1 
      cCodAtdCFE:= PAD( "C" + StrZero( CLI->CODIGO, 6, 0 ), 10 ) 
   ELSEIF nCodigo==2 
      cCodAtdCFE:= PAD( "F" + StrZero( FOR->CODIGO, 4, 0 ), 10 ) 
   ELSEIF nCodigo==3 
      cCodAtdCFE:= PAD( "E" + StrZero( EMP->CODIGO, 3, 0 ), 10 ) 
   ENDIF 
   ATD->( DBSetOrder( 2 ) ) 
   ATD->( DBSeek( cCodAtdCFE ) ) 
   WHILE cCodAtdCFE==ATD->CODCFE 
       IF ATD->SETOR_==SET->CODIGO 
          AAdd( aAtdCFE, { StrZero( ATD->CODIGO, 8, 0 ), ATD->DATAEM, ATD->HORA__, ATD->STATUS, ATD->DESCRI } ) 
       ENDIF 
       ATD->( DBSkip() ) 
   ENDDO 
   IF Len( aAtdCFE ) <= 0 
      AAdd( aAtdCFE, { Space( 10 ), CTOD( "  /  /  " ), "  :  .  ", 0, Space( 45 ) } ) 
   ENDIF 
 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Move [INS]Novo [ENTER]Altera [DEL]Exclui [ESC]Retorna") 
   SetColor( _COR_GET_EDICAO ) 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseDB( 13, 47, 21, 78 ) 
   oTb:AddColumn( tbcolumnnew( ,{|| aAtdCFE[ nRow ][ 1 ] + ; 
                                    " " + DTOC( aAtdCFE[ nRow ][ 2 ] ) + ; 
                                    " " + Tran( aAtdCFE[ nRow ][ 3 ], "@R XX:XX" ) + ; 
                                    " " + StrZero( aAtdCFE[ nRow ][ 4 ], 2, 0 ) + ; 
                                    " " + aAtdCFE[ nRow ][ 5 ] + Space( 60 ) })) 
 
   oTb:GOTOPBLOCK:= {|| nRow:= 1 } 
   oTb:GOBOTTOMBLOCK:= {|| nRow:= Len( aAtdCFE ) } 
   oTb:SKIPBLOCK:= {|x| skipperarr( x, aAtdCFE, @nRow ) } 
 
   /* Variaveis do objeto browse */ 
   oTb:AutoLite:=.f. 
   oTb:dehilite() 
 
   WHILE .T. 
 
      /* Ajuste sa barra de selecao */ 
      oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
      WHILE NextKey()=0 .AND. !oTb:Stabilize() 
      ENDDO 
 
      /* Exibicao de Informacoes - Ficha de Atendimento a direira */ 
      @ 02,47 Say "Ficha Atendimento" 
      @ 03,47 Say LEFT( aAtdCFE[ nRow ][ 5 ], 31 ) Color "15/" + CorFundoAtual() 
      ATD->( DBSetOrder( 1 ) ) 
      IF ATD->( DBSeek( VAL( aAtdCFE[ nRow ][ 1 ] ) ) ) 
 
         /* Situacao */ 
         @ 05,47 Say "Situacao" 
 
         IF ATD->STATUS > 0 
            @ 05,56 Say StatusOcorrencia( ATD->STATUS, {""} )[ ATD->STATUS ] + "] " Color "15/" + CorFundoAtual() 
         ENDIF 
 
         /* Valor */ 
         IF ATD->VALOR_ > 0 
            @ 06,47 Say "Valor" 
            @ 06,56 Say Tran( ATD->VALOR_, "@E 9,999,999.99" ) Color "15/" + CorFundoAtual() 
         ENDIF 
 
         /* Cobranca */ 
         @ 07,47 Say "Cobranca" 
         @ 07,56 Say StrZero( ATD->COBRAN, 2, 0 ) Color "15/" + CorFundoAtual() 
 
         /* Responsavel */ 
         @ 08,47 Say "Responsavel" 
         @ 09,47 Say ATD->ATEND_ Color "15/" + CorFundoAtual() 
 
      ENDIF 
      @ 10,47 Say "Emitida em " 
      @ 10,59 Say DTOC( aAtdCFE[ nRow ][ 2 ] ) Color "15/" + CorFundoAtual() 
 
      /* Exibe detalhes a esquerda */ 
      Scroll( 1, 1, 11, 41 ) 
      nL:= 1 
      IF ATA->( DBSeek( VAL( aAtdCFE[ nRow ][ 1 ] ) ) ) 
         WHILE ATA->CODIGO==VAL( aAtdCFE[ nRow ][ 1 ] ) 
              IF ALLTRIM( ATA->INFORM ) <> ALLTRIM( _MSG_INFORMACAO ) 
                 @ ++nL,01 Say ALLTRIM( ATA->INFORM ) 
                 FOR nCt:= 1 TO 5 
                     cCampo:= "HISTO" + ALLTRIM( Str( nCT, 1 ) ) 
                     IF !ATA->( EMPTY( &cCampo ) ) .AND. nL <= 10 
                        @ ++nL,01 Say left( ATA->( &cCampo ), 40 ) COLOR "15/"+CorfundoAtual() 
                     ENDIF 
                 NEXT 
                 IF nL >= 10 
                    EXIT 
                 ENDIF 
              ENDIF 
              ATA->( DBSkip() ) 
         ENDDO 
      ENDIF 
 
 
      ///ExibeOcorrencias( nCodigo, oTb ) 
      nTecla:=inkey(0) 
      IF nTecla==K_ESC 
         EXIT 
      ENDIF 
 
      /* Teste da tecla pressionadas */ 
      DO CASE 
         CASE nTecla==K_UP         ;oTb:up() 
         CASE nTecla==K_LEFT       ;oTb:PanLeft() 
         CASE nTecla==K_RIGHT      ;oTb:PanRight() 
         CASE nTecla==K_DOWN       ;oTb:down() 
         CASE nTecla==K_PGUP       ;oTb:pageup() 
         CASE nTecla==K_PGDN       ;oTb:pagedown() 
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         CASE nTecla==K_DEL 
 
              /* Nota Fiscal Cancelada */ 
              IF Confirma( 0, 0, "Deseja excluir a ocorrencia?",,"N" ) 
                 ExcluiOcorrencia( aAtdCFE, nRow, oTb ) 
              ENDIF 
 
         CASE nTecla==K_TAB 
              cCodigoFicha:= aAtdCFE[ nRow ][ 1 ] 
              IF Confirma( 0, 0, "Imprimir esta ficha de atendimento?", "Imprimir Ficha Atendimento", "S" ) 
                 Relatorio( "ATD"+StrZero( SET->TIPTAB, 3, 0 ) + ".REP" ) 
              ENDIF 
 
         CASE nTecla==K_CTRL_TAB 
              IF Confirma( 0, 0, "Imprimir esta ficha secundaria de atendimento?", "S", "Imprimir" ) 
                 Relatorio( "ATEND01.REP" ) 
              ENDIF 
 
         CASE nTecla==K_CTRL_F1 
              IF Confirma( 0, 0, "Imprimir esta ficha Complementar de atendimento?", "S", "Imprimir" ) 
                 Relatorio( "ATEND02.REP" ) 
              ENDIF 
 
         CASE nTecla==K_CTRL_F2 
              IF Confirma( 0, 0, "Imprimir esta ficha Complementar de atendimento?", "S", "Imprimir" ) 
                 Relatorio( "ATEND03.REP" ) 
              ENDIF 
 
         CASE nTecla==K_INS 
              lMoveu:= .F. 
              IF !( oTb:nLeft <= 1 ) 
                 lMoveu:= .T. 
                 OcorrenciaExpand( oTb, cTela ) 
              ENDIF 
              IncluiOcorrencia( oTb, aAtdCFE, cCodAtdCFE ) 
              IF lMoveu 
                 OcorrenciaExpand( oTb, cTela ) 
              ENDIF 
 
         CASE nTecla==K_ENTER 
 
              ATD->( DBSetOrder( 1 ) ) 
              IF ! ATD->( DBSeek( VAL( aAtdCFE[ nRow ][ 1 ] ) ) ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Atencao! Registro n∆o existe ou foi excluida neste momento." ) 
                 Mensagem( "Pressione [ENTER] para continuar..." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 IF !( SET->CODIGO==ATD->SETOR_ ) 
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                    Aviso( "Atencao! Esta ficha n∆o pertence a este setor." ) 
                    Mensagem( "Pressione [ENTER] para continuar..." ) 
                    Pausa() 
                    ScreenRest( cTelaRes ) 
                 ELSE 
                   lMoveu:= .F. 
                   IF !( oTb:nLeft <= 1 ) 
                      lMoveu:= .T. 
                      OcorrenciaExpand( oTb, cTela ) 
                   ENDIF 
                   AlteraOcorrencia( oTb, aAtdCFE, cCodAtdCFE, nRow ) 
                   IF lMoveu 
                      OcorrenciaExpand( oTb, cTela ) 
                   ENDIF 
                 ENDIF 
              ENDIF 
 
         CASE nTecla==K_ALT_I 
              OcorrenciaExpand( oTb, cTela ) 
 
         OTHERWISE                 ;Tone(125); Tone(300) 
     ENDCASE 
     oTb:RefreshCurrent() 
     oTb:Stabilize() 
 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   DBSelectAr( nArea ) 
   Return Nil 
 
 
 
Function IncluiOcorrencia( oTab, aAtdCFE, cCodAtdCFE ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor() 
   Local cDescri:= Space( 45 ) 
   Local nCodigo:= 0 
   Local nValor_:= 0 
   Local nValMao:= 0 
   Local nValPro:= 0 
   Local nValKmr:= 0 
   Local nSituacao:= 0 
   Local dData__:= DATE() 
   Local cHora__:= TIME() 
   Local dDatFim:= CTOD( "  /  /  " ), cAtend_:= Space( 30 ) 
   Local nStatus:= 0 
   Local nCobran:= 0 
   Local aInformacoes 
   Local aOpcoes:= {} 
 
   VPBox( 12, 0, 23, 79, " Inclusao de Ordem de Servico ", _COR_GET_EDICAO, .F., .F. ) 
 
   DBSelectAr( _COD_ATEND ) 
 
   cHora__:= StrTran( cHora__, ":", "" ) 
   cHora__:= StrTran( cHora__, ".", "" ) 
   ATD->( DBSetOrder( 1 ) ) 
   ATD->( DBGoBottom() ) 
   nCodigo:= ATD->CODIGO + 1 
   @ 14,02 Say " Codigo.........:" Get nCodigo 
   @ 15,02 Say " Descricao......:" Get cDescri 
   @ 16,02 Say " Data Inclus∆o..:" Get dData__ 
   @ 17,02 Say " Hora ..........:" Get cHora__ Pict "@R XX:XX.XX" 
   @ 18,02 Say " Data Conclusao.:" Get dDatFim 
   @ 19,02 Say " Responsavel....:" Get cAtend_ 
   @ 20,02 Say " Situacao.......:" Get nStatus Pict "99" Valid StatusOcorrencia( @nStatus ) 
   @ 21,02 Say " Tipo Cobranca..:" Get nCobran Pict "99" Valid TipoCobranca( @nCobran ) 
   @ 19,51 Say " Mao de Obra...:" Get nValMao Pict "@E 99,999.99" 
   @ 20,51 Say " Mat. Utilizado:" Get nValPro Pict "@E 99,999.99" 
   @ 21,51 Say " Km Rodado.....:" Get nValKmr Pict "@E 99,999.99" valid SomValFicha(nValMao,nValPro,nValKmr,@nValor_) 
   @ 22,02 Say " Valor..........:" Get nValor_ Pict "@E 999,999.99" 
   READ 
   IF !LastKey()==K_ESC 
      IF ATD->( DBSeek( nCodigo ) ) 
         ATD->( DBGoBottom() ) 
         nCodigo:= ATD->CODIGO + 1 
      ENDIF 
      ATD->( DBAppend() ) 
      IF ATD->( NetRLock() ) 
         Replace ATD->CODIGO With nCodigo,; 
                 ATD->DESCRI With "RESERVADO" 
      ENDIF 
 
      /* aInformacoes ===> Responsavel por armazenar os dados digitados 
         na rotina editDetalhe, sendo que as informacoes que corresponsam 
         a um mesmo registro estarao no mesmo numero de registro, modicando 
         apenas o tipo de informacao. 
         Os dados s∆o armazenados nas posicoes 3/4/5/6/7 do array: 
         Ex. 
         Caso seja informacao de Produto+Observacao: 
         1ßElemento   { { 1, "Produto", "00000257", "110V ", Space(), Space(),; 
                                                    Space(), Space(), DTOC("") },; 
                        { 1, "Observacoes", "O PRODUTO ESTA COM DEFEITO",; 
                                                    Space(), Space(), Space(),; 
                                                    Space(), Space(), DTOC("") } } 
         2ßElemento   { { 2, "Produto", "00012445", "220V ", Space(), Space(),; 
                                                    Space(), Space(), DTOC("") },; 
                        { 2, "Observacoes", "O PRODUTO ESTA COM DEFEITO",; 
                                                    Space(), Space(), Space(),; 
                                                    Space(), Space(), DTOC("") } } 
         Cada um sub-elemento representara um registro na base de dados, 
         e cada elemento uma ocorrencia, devendo ser editado em conjunto. 
      */ 
 
      /* Pega tabela de atendimento destinada ao setor escolhido */ 
      nTabela:= SET->TIPTAB 
      TabAtendimento( @nTabela, @aOpcoes ) 
 
      aInformacoes:= {} 
      AAddInformacoes( @aInformacoes, aOpcoes ) 
      IF EditDetalheOcorr( @aInformacoes ) 
         Gravar( nCodigo, cDescri, dData__, cHora__, dDatFim,; 
                          cAtend_, nStatus, nCobran, nValor_, nValMao, nValPro, nValKmr, cCodAtdCFE, aInformacoes, aAtdCFE ) 
      ELSE 
         ATD->( DBSeek( nCodigo ) ) 
         IF ALLTRIM( ATD->DESCRI )=="RESERVADO" 
            IF ATD->( NetRLock() ) 
               ATD->( DBDelete() ) 
            ENDIF 
         ENDIF 
      ENDIF 
      oTab:RefreshAll() 
      WHILE !oTab:Stabilize() 
      ENDDO 
   ENDIF 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   Return .T. 
 
 
Function AlteraOcorrencia( oTab, aAtdCFE, cCodAtdCFE, nRow ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor() 
   Local cDescri:= Space( 45 ) 
   Local nCodigo:= 0 
   Local nSituacao:= 0 
   Local dData__:= DATE() 
   Local cHora__:= TIME() 
   Local dDatFim:= DATE() + 30, cAtend_:= Space( 30 ) 
   Local nStatus:= 0 
   Local nCobran:= 0 
   Local nValor_:= 0 
   Local nValMao:= 0 
   Local nValPro:= 0 
   Local nValKmr:= 0 
   Local aInformacoes 
   Local aOpcoes:= {} 
   Local nRegistro:= 1 
   Local nInfo:= 1 
 
   nCodigo:= VAL( aAtdCFE[ nRow ][ 1 ] ) 
   ATD->( DBSetOrder( 1 ) ) 
 
   IF !ATD->( DBSeek( nCodigo ) ) 
      Aviso( "Codigo de Ficha n∆o encontrado na base de dados." ) 
      Pausa() 
      Return Nil 
   ELSE 
      cDescri:= ATD->DESCRI 
      dData__:= ATD->DATAEM 
      cHora__:= ATD->HORA__ 
      dDatFim:= ATD->DATFIM 
      cAtend_:= ATD->ATEND_ 
      nStatus:= ATD->STATUS 
      nCobran:= ATD->COBRAN 
      nValor_:= ATD->VALOR_ 
      nValmao:= ATD->VALMAO 
      nValPro:= ATD->VALPRO 
      nValKmr:= ATD->VALKMR 
   ENDIF 
   cHora__:= StrTran( cHora__, ":", "" ) 
   cHora__:= StrTran( cHora__, ".", "" ) 
   VPBox( 12, 0, 23, 79, " Alteracao de Ficha de Atendimento ", _COR_GET_EDICAO, .F., .F. ) 
   @ 14,02 Say " Codigo.........:" Get nCodigo 
   @ 15,02 Say " Descricao......:" Get cDescri 
   @ 16,02 Say " Data Inclus∆o..:" Get dData__ 
   @ 17,02 Say " Hora ..........:" Get cHora__ Pict "@R XX:XX.XX" 
   @ 18,02 Say " Data Conclusao.:" Get dDatFim 
   @ 19,02 Say " Responsavel....:" Get cAtend_ 
   @ 20,02 Say " Situacao.......:" Get nStatus Pict "99" Valid StatusOcorrencia( @nStatus ) 
   @ 21,02 Say " Tipo Cobranca..:" Get nCobran Pict "99" Valid TipoCobranca( @nCobran ) 
   @ 19,51 Say " Mao de Obra...:" Get nValMao Pict "@E 99,999.99" 
   @ 20,51 Say " Mat. Utilizado:" Get nValPro Pict "@E 99,999.99" 
   @ 21,51 Say " Km Rodado.....:" Get nValKmr Pict "@E 99,999.99" valid SomValFicha(nValMao,nValPro,nValKmr,@nValor_) 
   @ 22,02 Say " Valor..........:" Get nValor_ Pict "@E 999,999,999.99" 
   READ 
   IF !LastKey()==K_ESC 
 
      /* Pega tabela de atendimento destinada ao setor escolhido */ 
      nTabela:= SET->TIPTAB 
      TabAtendimento( @nTabela, @aOpcoes ) 
 
      aInformacoes:= {} 
 
      ATA->( DBSetOrder( 1 ) ) 
      IF !ATA->( DBSeek( nCodigo ) ) 
         AAddInformacoes( @aInformacoes, aOpcoes ) 
      ELSE 
         WHILE ATA->CODIGO==nCodigo 
             AAddInformacoes( @aInformacoes, aOpcoes ) 
             nRegistro:= Len( aInformacoes ) 
             FOR nCt:= 1 TO Len( aOpcoes ) 
                 aInformacoes[ nRegistro ][ nCt ]:= { ATA->CODREG,; 
                                                    Left( ATA->INFORM, Len( _MSG_PRODUTO ) ),; 
                                                    ATA->HISTO1,; 
                                                    ATA->HISTO2,; 
                                                    ATA->HISTO3,; 
                                                    ATA->HISTO4,; 
                                                    ATA->HISTO5,; 
                                                    ATA->ATEND_,; 
                                                    ATA->DATA__,; 
                                                    ATA->STATUS } 
                 ATA->( DBSkip() ) 
             NEXT 
         ENDDO 
      ENDIF 
 
      IF EditDetalheOcorr( @aInformacoes ) 
         Gravar( nCodigo, cDescri, dData__, cHora__, dDatFim,; 
                          cAtend_, nStatus, nCobran, nValor_, nValMao, nValPro, nValKmr, cCodAtdCFE, aInformacoes, aAtdCFE ) 
      ENDIF 
 
      oTab:RefreshAll() 
      WHILE !oTab:Stabilize() 
      ENDDO 
 
   ENDIF 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   Return .T. 
 
 
/* Adiciona um novo registro em aInformacoes */ 
// aOpcoes= neste caso serve para determinar quantos sub-elementos devem ser 
//          adicionados ao array aInformacoes, para que n∆o hajam falhas no 
//          momento da edicao 
Function AAddInformacoes( aInformacoes, aOpcoes ) 
   /* Acrescenta o 1ß elemento em aInformacoes */ 
   AAdd( aInformacoes, { { Len( aInformacoes ) + 1,;                      && Numero do Registro 
                           Space( Len( _MSG_PRODUTO ) ),;                 && Tipo Cf.Tab #Define acima 
                           Space( 100 ),;                                  && Informacoes 
                           Space( 100 ),; 
                           Space( 100 ),; 
                           Space( 100 ),; 
                           Space( 100 ),; 
                           Space( 30 ),;                                  && Atendente 
                           CTOD( "  /  /  "),; 
                           0 } } )                                        && Status 
   /* Acrescenta os demais campos no elemento */ 
   FOR nCt:= 2 TO Len( aOpcoes ) 
       IF !( aOpcoes[ nCt ][ 1 ]==_MSG_GRAVA ) 
          AAdd( aInformacoes[ Len( aInformacoes ) ], {} ) 
          aInformacoes[ Len( aInformacoes ) ][ nCt ]:= { Len( aInformacoes ),;    && Numero do Registro 
                                       aOpcoes[ nCt ],;         && Tipo Cf.Tab #Define acima 
                                       Space( 100 ),;            && Informacoes 
                                       Space( 100 ),; 
                                       Space( 100 ),; 
                                       Space( 100 ),; 
                                       Space( 100 ),; 
                                       Space( 30 ),;            && Atendente 
                                       CTOD( "  /  /  "),;      && Data Ocorrencia 
                                       0 }                      && Status 
       ENDIF 
   NEXT 
   // Enfim Acrescentado os elementos 
   Return Nil 
 
 
 
Function EditDetalheOcorr( aInformacoes ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor() 
   Local nOpSaida:= 0 
   Local nOpcao:= 0, nRow, nTecla, oTab 
   Local nTabela 
   Local nRegistro:= 1, nInfo:= 1 
   Local aOpcoes:= {} 
 
   /* nRegistro = reponsavel pela representacao do registro no array 
                  aInformacoes. ex. se conter 1, significa que esta no 
                  primeiro elemento do array. 
      nInfo     = responsavel por armazenar a informacao que esta sendo editada 
                  no momento. pra exemplificar usaremos o mesmo ex. do aInformacoes. 
                  Ex. Naquele caso se nInfo estiver com conteudo 1, significa que 
                  o campo em exibicao eh ref. ao produto, bem como, se conter 2 
                  significa que o campo em edicao eh o 2ß 
   */ 
   SetCursor( 1 ) 
   SetColor( COR[16] + "," + COR[18] + ",,," + COR[17] ) 
 
   /* Pega tabela de atendimento destinada ao setor escolhido */ 
   nTabela:= SET->TIPTAB 
   TabAtendimento( @nTabela, @aOpcoes ) 
 
   /* Adiciona a Opcao de Salvamento das Informacoes */ 
   AAdd( aOpcoes, { _MSG_GRAVA, 1 } ) 
 
   nRow:= 1 
   nOpcao:= 1 
   lOk:= .F. 
   SetColor( "15/04, 00/14" ) 
   VPBoxSombra( 02, 01, 09, 29,, "15/04", "00/01" ) 
   oTAB:= tbrowsenew( 03, 02, 08, 28 ) 
   oTAB:addcolumn( tbcolumnnew( , {|| aOpcoes[ nRow ][ 1 ] } ) ) 
   oTAB:AUTOLITE:=.f. 
   oTAB:GOTOPBLOCK :={|| nRow:=1} 
   oTAB:GOBOTTOMBLOCK:={|| nRow:=len(aOpcoes)} 
   oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aOpcoes,@nRow)} 
   oTAB:dehilite() 
   lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
   WHILE .T. 
      WHILE .T. 
          oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
          WHILE nextkey()==0 .and. ! oTAB:stabilize() 
          ENDDO 
          @ 10,35 Say "        <<---- " + StrZero( nRegistro, 2, 0 ) +; 
                             "/" + StrZero( LEN( aInformacoes ), 2, 0 ) + "----->>       " Color "01/15" 
          nOpcao:= nRow 
          nInfo:= nOpcao 
          Visual( aInformacoes, nRegistro, nInfo, aOpcoes, nOpcao ) 
          TECLA:= Inkey( 0 ) 
          IF TECLA==K_ESC 
             nOpcao:= 0 
             exit 
          ENDIF 
          cTelaG:= ScreenSave( 0, 0, 24, 79 ) 
          DO CASE 
             CASE TECLA==K_UP         ;oTAB:up() 
             CASE TECLA==K_DOWN       ;oTAB:down() 
             CASE TECLA==K_LEFT 
                  IF nRegistro > 1 
                     --nRegistro 
                  ENDIF 
             CASE TECLA==K_RIGHT 
                  IF nRegistro + 1 <= Len( aInformacoes ) 
                     nRegistro:= nRegistro + 1 
                  ENDIF 
             CASE TECLA==K_PGUP       ;oTAB:pageup() 
             CASE TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
             CASE TECLA==K_PGDN       ;oTAB:pagedown() 
             CASE TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
             CASE TECLA==K_F12        ;Calculador() 
             CASE Chr( TECLA ) $ "Gg" 
                  /* Aciona disp. de Gravacao de Informacoes */ 
                  nOpcao:= Len( aOpcoes ) 
                  oTab:GoBottom() 
                  oTab:RefreshAll() 
                  WHILE !oTab:Stabilize() 
                  ENDDO 
                  EXIT 
 
             CASE TECLA==K_INS 
                  AAddInformacoes( @aInformacoes, aOpcoes ) 
                  oTab:GoTop() 
                  oTab:RefreshAll() 
                  WHILE !oTab:Stabilize() 
                  ENDDO 
                  nRegistro:= nRegistro + 1 
 
             CASE TECLA==K_DEL 
                  DelInformacoes( @aInformacoes, @nRegistro, @nRow, oTab ) 
 
             CASE TECLA==K_ENTER 
                  EXIT 
             OTHERWISE                ;tone(125); tone(300) 
          ENDCASE 
          oTAB:refreshcurrent() 
          oTAB:stabilize() 
      ENDDO 
      DO CASE 
         CASE nOpcao==0 
              IF SWAlerta( "Deseja abandonar a edicao e ;perder as alteracoes?", { "Sim", "Nao" } )==1 
                 nOpSaida:= 3 
                 EXIT 
              ENDIF 
         CASE nOpcao >= Len( aOpcoes ) 
              nOpSaida:= SWAlerta( "Fim da Edicao dos Dados.;O que voce deseja fazer?", { "Gravar", "Continuar Editando", "Abandonar" } ) 
              IF nOpSaida==1 .OR. nOpSaida==3 
                 EXIT 
              ENDIF 
         OTHERWISE 
              /* JANELA DE EDICAO DAS INFORMACOES ADQUIRIDAS */ 
              nInfo:= nOpcao 
              DO CASE 
                 CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_PRODUTO 
                      cHisto1:= Alltrim( aInformacoes[ nRegistro ][ nInfo ][ 3 ] ) 
                      cHisto2:= Left( aInformacoes[ nRegistro ][ nInfo ][ 4 ], 5 ) 
                      cHisto3:= Space( 100 ) 
                      cHisto4:= Space( 100 ) 
                      cHisto5:= Space( 100 ) 
                      cAtend_:= Space( 30 ) 
                      dData__:= CTOD( "  /  /  " ) 
                      SetColor( "15/01" ) 
                      @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) 
                      @ 03,32 Get cHisto1 Pict "@R 999-9999" Valid BuscaProduto( @cHisto1 ) 
                      @ 04,32 Say "Voltagem:" Get cHisto2 Pict "@R XXXXX" 
                      READ 
                      aInformacoes[ nRegistro ][ nInfo ][ 4 ]:= cHisto2 
                      aInformacoes[ nRegistro ][ nInfo ][ 3 ]:= cHisto1 
                      aInformacoes[ nRegistro ][ nInfo ][ 2 ]:= aOpcoes[ nInfo ][ 1 ] 
                      oTab:Down() 
                      oTab:RefreshAll() 
                      WHILE !oTab:Stabilize() 
                      ENDDO 
 
                 CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_INFORMACAO 
                      cHisto1:= LEFT( aInformacoes[ nRegistro ][ nInfo ][ 3 ], 1 ) 
                      cHisto2:= LEFT( aInformacoes[ nRegistro ][ nInfo ][ 4 ], 1 ) 
                      cHisto3:= CTOD( ALLTRIM( aInformacoes[ nRegistro ][ nInfo ][ 5 ] ) ) 
                      cHisto4:= LEFT( aInformacoes[ nRegistro ][ nInfo ][ 6 ], 4 ) 
                      cHisto5:= LEFT( aInformacoes[ nRegistro ][ nInfo ][ 7 ], 4 ) 
                      SetColor( "15/01" ) 
                      @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) 
                      @ 03,32 Say "Uso Inadequado (S/N):" Get cHisto1 Pict "!" 
                      @ 04,32 Say "Atendimento (I/E)...:" Get cHisto2 Pict "!" 
                      @ 05,32 Say "Data do Atendimento.:" Get cHisto3 
                      @ 06,32 Say "Hora do Atendimento.:" Get cHisto4 Pict "@R XX:XX" 
                      @ 07,32 Say "Tempo utilizado.....:" Get cHisto5 Pict "@R XX:XX" 
                      READ 
                      aInformacoes[ nRegistro ][ nInfo ][ 2 ]:= aOpcoes[ nInfo ][ 1 ] 
                      aInformacoes[ nRegistro ][ nInfo ][ 3 ]:= cHisto1 
                      aInformacoes[ nRegistro ][ nInfo ][ 4 ]:= cHisto2 
                      aInformacoes[ nRegistro ][ nInfo ][ 5 ]:= DTOC( cHisto3 ) 
                      aInformacoes[ nRegistro ][ nInfo ][ 6 ]:= cHisto4 
                      aInformacoes[ nRegistro ][ nInfo ][ 7 ]:= cHisto5 
                      oTab:Down() 
                      oTab:RefreshAll() 
                      WHILE !oTab:Stabilize() 
                      ENDDO 
 
                 CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_OBSERVACAO  .OR.; 
                      aOpcoes[ nOpcao ][ 1 ]==_MSG_DEFEITO     .OR.; 
                      aOpcoes[ nOpcao ][ 1 ]==_MSG_DIAGNOSTICO .OR.; 
                      aOpcoes[ nOpcao ][ 1 ]==_MSG_SOLUCAO     .OR.; 
                      aOpcoes[ nOpcao ][ 1 ]==_MSG_MATERIAL 
                      cHisto1:= aInformacoes[ nRegistro ][ nInfo ][ 3 ] 
                      cHisto2:= aInformacoes[ nRegistro ][ nInfo ][ 4 ] 
                      cHisto3:= aInformacoes[ nRegistro ][ nInfo ][ 5 ] 
                      cHisto4:= aInformacoes[ nRegistro ][ nInfo ][ 6 ] 
                      cHisto5:= aInformacoes[ nRegistro ][ nInfo ][ 7 ] 
 
                      Set Key K_F9 To BProdutos() 
                      @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) 
                      @ 03,32 Get cHisto1 pict "@S40" 
                      @ 04,32 Get cHisto2 pict "@S40" 
                      @ 05,32 Get cHisto3 pict "@S40" 
                      @ 06,32 Get cHisto4 pict "@S40" 
                      @ 07,32 Get cHisto5 pict "@S40" 
                      READ 
                      Set Key K_F9 To Busca99() 
                      if !trim(cHisto5) == "" .and. aOpcoes[ nOpcao ][ 1 ]==_MSG_MATERIAL 
                         IF SWAlerta( "Deseja lanáar mais Produtos ?", {"Sim", "Nao" } ) = 1 
                            keyboard chr(K_INS)+repl(chr(K_DOWN),6)+chr(K_RIGHT)+chr(K_ENTER) 
                         Endif 
                      endif 
 
                      aInformacoes[ nRegistro ][ nInfo ][ 2 ]:= aOpcoes[ nInfo ][ 1 ] 
                      aInformacoes[ nRegistro ][ nInfo ][ 3 ]:= cHisto1 
                      aInformacoes[ nRegistro ][ nInfo ][ 4 ]:= cHisto2 
                      aInformacoes[ nRegistro ][ nInfo ][ 5 ]:= cHisto3 
                      aInformacoes[ nRegistro ][ nInfo ][ 6 ]:= cHisto4 
                      aInformacoes[ nRegistro ][ nInfo ][ 7 ]:= cHisto5 
                      oTab:Down() 
                      oTab:RefreshAll() 
                      WHILE !oTab:Stabilize() 
                      ENDDO 
 
              ENDCASE 
      ENDCASE 
   ENDDO 
   SetColor( cCor ) 
   ScreenRest( cTela ) 
   SET( _SET_DELIMITERS, lDelimiters ) 
   Return ( nOpSaida==1 ) 
 
Static Function ExcluiOcorrencia( aAtdCFE, nRow, oTab ) 
   Local lDeletado:= .F. 
 
   IF nRow >= 1 .AND. nRow <= Len( aAtdCFE ) .AND. Len( aAtdCfe ) >= 1 
      ATD->( DBSetOrder( 1 ) ) 
      IF ATD->( DBSeek( VAL( aAtdCFE[ nRow ][ 1 ] ) ) ) 
         IF ATD->( NetRLock() ) 
            ATD->( DBDelete() ) 
            lDeletado:= .T. 
         ENDIF 
         ATA->( DBSetOrder( 1 ) ) 
         IF ATA->( DBSeek( VAL( aAtdCFE[ nRow ][ 1 ] ) ) ) 
            WHILE VAL( aAtdCFE[ nRow ][ 1 ] ) == ATA->CODIGO 
                IF ATA->( NetRLock() ) 
                   ATA->( DBDelete() ) 
                ENDIF 
                ATA->( DBSkip() ) 
            ENDDO 
         ENDIF 
         IF lDeletado 
            ADel( aAtdCFE, nRow ) 
            ASize( aAtdCFE, Len( aAtdCFE ) - 1 ) 
            IF Len( aAtdCFE ) <= 0 
               AAdd( aAtdCFE, { Space( 10 ), CTOD( "  /  /  " ), "  :  .  ", 0, Space( 45 ) } ) 
               nRow:= 1 
            ELSE 
               IF nRow > 1 
                  --nRow 
               ENDIF 
            ENDIF 
            oTab:RefreshAll() 
            WHILE !oTab:stabilize() 
            ENDDO 
         ENDIF 
      ENDIF 
   ENDIF 
   Return .T. 
 
 
 
Static Function DelInformacoes( aInformacoes, nRegistro, nRow, oTab ) 
   IF nRegistro >= 1 .AND. nRegistro <= Len( aInformacoes ) .AND. Len( aInformacoes ) > 1 
      ADel( aInformacoes, nRegistro ) 
      ASize( aInformacoes, Len( aInformacoes ) - 1 ) 
      nRegistro:= 1 
      nRow:= 1 
      oTab:RefreshAll() 
      WHILE !oTab:stabilize() 
      ENDDO 
   ELSEIF Len( aInformacoes )==1 
      SWAlerta( "<< OPERACAO INDEVIDA >>; Nao e permitido deixar uma ficha sem registros.;" +; 
                "Neste caso apague a ficha de atendimento.", {" OK "} ) 
   ENDIF 
   Return .T. 
 
 
Static Function BuscaProduto( cCodProd ) 
   MPR->( DBSetOrder( 1 ) ) 
   IF MPR->( DBSeek( PAD( cCodProd, 12 ) ) ) .OR. AllTrim( cCodProd )=="0000000" 
      Return .T. 
   ELSE 
      VisualProdutos( @cCodProd ) 
      cCodProd:= LEFT( MPR->INDICE, 7 ) 
   ENDIF 
   Return .T. 
 
 
 
Static Function Visual( aInformacoes, nRegistro, nInfo, aOpcoes, nOpcao ) 
   Local cCor:= SetColor() 
   IF nInfo > 0 .AND. nInfo <= Len( aOpcoes ) 
      DO CASE 
         CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_GRAVA 
              SetColor( _COR_GET_EDICAO ) 
              Scroll( 02, 32, 08, 78 ) 
              @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) Color _COR_GET_EDICAO 
              @ 05,32 Say "<<<<<<<< FIM DA EDICAO >>>>>>>>" Color _COR_GET_EDICAO 
              SetColor( cCor ) 
 
         CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_INFORMACAO 
              SetColor( _COR_GET_EDICAO ) 
              Scroll( 02, 32, 08, 78 ) 
              cHisto1:=   LEFT( aInformacoes[ nRegistro ][ nInfo ][ 3 ], 1 ) 
              cHisto2:=   LEFT( aInformacoes[ nRegistro ][ nInfo ][ 4 ], 1 ) 
              cHisto3:=   aInformacoes[ nRegistro ][ nInfo ][ 5 ] 
              cHisto4:=   aInformacoes[ nRegistro ][ nInfo ][ 6 ] 
              cHisto5:=   aInformacoes[ nRegistro ][ nInfo ][ 7 ] 
              @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) Color _COR_GET_EDICAO 
              @ 03,32 Say "Uso Inadequado (S/N): " + LEFT( cHisto1, 1 ) 
              @ 04,32 Say "Atendimento (I/E)...: " + LEFT( cHisto2, 1 ) 
              @ 05,32 Say "Data do Atendimento.: " + LEFT( cHisto3, 8 ) 
              @ 06,32 Say "Hora do Atendimento.: " + Tran( LEFT( cHisto4, 4 ), "@R XX:XX" ) 
              @ 07,32 Say "Tempo utilizado.....: " + Tran( LEFT( cHisto5, 4 ), "@R XX:XX" ) 
 
         CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_PRODUTO 
              SetColor( _COR_GET_EDICAO ) 
              Scroll( 02, 32, 08, 78 ) 
              cHisto1:=   ALLTRIM( aInformacoes[ nRegistro ][ nInfo ][ 3 ] ) 
              cHisto2:=   ALLTRIM( aInformacoes[ nRegistro ][ nInfo ][ 4 ] ) 
              @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) Color _COR_GET_EDICAO 
              @ 03,32 Say cHisto1 Pict "@R 999-9999" Color _COR_GET_EDICAO 
              @ 04,32 Say "Voltagem: " + cHisto2 Color _COR_GET_EDICAO 
              IF !cHisto1=="0000000" .AND. !cHisto1==Space( 7 ) 
                 MPR->( DBSetOrder( 1 )) 
                 MPR->( DBSeek( PAD( cHisto1, 12 ) ) ) 
                 @ 01,32 Say LEFT( MPR->DESCRI, 48 ) 
              ENDIF 
 
         CASE aOpcoes[ nOpcao ][ 1 ]==_MSG_OBSERVACAO  .OR.; 
              aOpcoes[ nOpcao ][ 1 ]==_MSG_DEFEITO     .OR.; 
              aOpcoes[ nOpcao ][ 1 ]==_MSG_DIAGNOSTICO .OR.; 
              aOpcoes[ nOpcao ][ 1 ]==_MSG_SOLUCAO     .OR.; 
              aOpcoes[ nOpcao ][ 1 ]==_MSG_MATERIAL 
 
              Set Key K_F9 To BProdutos() 
              SetColor( _COR_GET_EDICAO ) 
              Scroll( 02, 32, 08, 78 ) 
              @ 02,32 Say LTRIM( aOpcoes[ nInfo ][ 1 ] ) Color _COR_GET_EDICAO 
              @ 03,32 Say aInformacoes[ nRegistro ][ nInfo ][ 3 ] Color _COR_GET_EDICAO 
              @ 04,32 Say aInformacoes[ nRegistro ][ nInfo ][ 4 ] Color _COR_GET_EDICAO 
              @ 05,32 Say aInformacoes[ nRegistro ][ nInfo ][ 5 ] Color _COR_GET_EDICAO 
              @ 06,32 Say aInformacoes[ nRegistro ][ nInfo ][ 6 ] Color _COR_GET_EDICAO 
              @ 07,32 Say aInformacoes[ nRegistro ][ nInfo ][ 7 ] Color _COR_GET_EDICAO 
              Set Key K_F9 To Busca99() 
 
 
      ENDCASE 
   ENDIF 
   SetColor( cCor ) 
   Return Nil 
 
 
 
 
Function TipoCobranca( nGarantia ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ),  cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local aOpcoes:= {} 
 
   aOpcoes:= { " 1 Avulso             ",; 
               " 2 Pagamento          ",; 
               " 3 Contrato           ",; 
               " 4 Garantia           ",; 
               " 5 Instalacao         ",; 
               " 6 Gratuito           ",; 
               " 7 Outros             " } 
 
   SetColor( _COR_BROWSE ) 
   VPBox( 11, 30, 11+Len( aOpcoes )+1, 55, " TIPO DE COBRANCA ", _COR_BROW_BOX ) 
   FOR nCt:= 1 TO Len( aOpcoes ) 
       @ 11+nCt,31 Prompt aOpcoes[ nCt ] 
   NEXT 
   MENU TO nGarantia 
   SetColor( cCor ) 
   ScreenRest( cTela ) 
   Return .T. 
 
 
Function StatusOcorrencia( nCodStatus, aOpcoesReturn ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor() 
   Local aOpcoes:= {} 
   aOpcoes:= { " 1 Nao Iniciado        ",; 
               " 2 Em Andamento        ",; 
               " 3 Solucionado         ",; 
               " 4 Aguardando          ",; 
               " 5 Outros              " } 
 
   /* Verifica se e pra retornar aOpcoes */ 
   IF !( aOpcoesReturn==Nil ) 
      Return aOpcoes 
   ENDIF 
 
   // Menu com as opcoes de status 
   SetColor( _COR_BROWSE ) 
   VPBox( 11, 30, 11+Len( aOpcoes )+1, 55, " SITUACAO DA OCORRENCIA ", _COR_BROW_BOX ) 
   FOR nCt:= 1 TO Len( aOpcoes ) 
       @ 11+nCt,31 Prompt aOpcoes[ nCt ] 
   NEXT 
   MENU TO nCodStatus 
   SetColor( cCor ) 
   ScreenRest( cTela ) 
   Return .T. 
 
 
Function OcorrenciaExpand( oTb, cTela ) 
Local nCt 
  IF oTb:nLeft == 47 
     /* Ajuste gradual da tela - efeito frescura */ 
     FOR nCt:= 47 TO 0 Step -2 
         VPBox( 0,  nCt, 11, 79, " ATENDIMENTO ", _COR_GET_EDICAO, .F., .F. ) 
         VPBox( 12, nCt, 23, 79, " Ocorrencias/Solicitacoes ", _COR_GET_EDICAO, .F., .F. ) 
         oTb:nLeft:= nCt + 1 
         oTb:RefreshAll() 
         WHILE !oTb:Stabilize() 
         ENDDO 
         IF nCt < 12 
            Inkey( 0.01 ) 
         ENDIF 
     NEXT 
     /* Ajuste final - Default */ 
     oTb:nLeft:= 1 
     VPBox( 0,  0, 11, 79, " ATENDIMENTO ", _COR_GET_EDICAO, .F., .F. ) 
     VPBox( 12, 0, 23, 79, " Ocorrencias/Solicitacoes ", _COR_GET_EDICAO, .F., .F. ) 
  ELSE 
     oTb:nLeft:= 47 
     ScreenRest( cTela ) 
  ENDIF 
  oTb:RefreshAll() 
  WHILE !oTb:Stabilize() 
  ENDDO 
  Return Nil 
 
 
 
 
/* Se aOpcoes estiver Nil,  Significa que eh somente pra pegar 
   o numero nTabela e retorna-lo. caso aOpcoes estiver preenchido eh 
   pra retornar tbem a tabela para a mesma */ 
Function TabAtendimento( nTabela, aOpcoes ) 
  Local aNovaOpcoes 
  Local nRow, nTecla, oTab 
  Local aTabela:= PegaTabela( 999 ) 
  lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
 
  IF aOpcoes==Nil 
     nRow:= 1 
     IF nTabela <= Len( aTabela ) 
        IF nTabela >= 1 
           nRow:= nTabela 
        ENDIF 
     ENDIF 
     lOk:= .T. 
     VPBox( 08, 05, 20, 77, " INFORMACOES A SOLICITAR NA FICHA DE ATENDIMENTO ", _COR_BROW_BOX ) 
     SetColor( _COR_BROWSE ) 
     oTAB:= tbrowsenew( 09, 06, 19, 42 ) 
     oTAB:addcolumn( tbcolumnnew( , {|| PAD( aTabela[ nROW ][ 1 ], 44 ) } ) ) 
     oTAB:AUTOLITE:=.f. 
     oTAB:GOTOPBLOCK :={|| nROW:=1} 
     oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aTabela)} 
     oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aTabela,@nROW)} 
     oTAB:dehilite() 
  ENDIF 
  WHILE .T. 
     IF aOpcoes==Nil 
        oTab:RefreshAll() 
        WHILE !oTab:Stabilize() 
        ENDDO 
        oTab:RefreshCurrent() 
        oTab:Stabilize() 
        oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
        WHILE nextkey()==0 .and. ! oTAB:stabilize() 
        ENDDO 
 
        nTabela:= nRow 
        aNovaOpcoes:= PegaTabela( nTabela ) 
 
        /* Exibe Informacoes Conforme tabela */ 
        IF aOpcoes==Nil .AND. !( aNovaOpcoes==Nil ) 
           VPBox( 09, 44, 20, 77, , _COR_BROW_BOX ) 
           FOR nCt:= 1 TO Len( aNovaOpcoes ) 
               @ 09+nCt,45 Say aNovaOpcoes[ nCt ][ 1 ] Color _COR_BROW_BOX 
           NEXT 
        ENDIF 
        nTecla:= Inkey(0) 
        IF nTecla==K_ESC 
           nTabela:= 0 
           exit 
        ENDIF 
        cTelaG:= ScreenSave( 0, 0, 24, 79 ) 
        DO CASE 
           CASE nTecla==K_UP         ;oTAB:up() 
           CASE nTecla==K_DOWN       ;oTAB:down() 
           CASE nTecla==K_LEFT       ;oTAB:up() 
           CASE nTecla==K_RIGHT      ;oTAB:down() 
           CASE nTecla==K_PGUP       ;oTAB:pageup() 
           CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
           CASE nTecla==K_PGDN       ;oTAB:pagedown() 
           CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
           CASE nTecla==K_F12        ;Calculador() 
           CASE nTecla==K_ENTER 
                IF !lOk 
                   oTab:GoTop() 
                   oTab:RefreshAll() 
                   WHILE !oTab:Stabilize() 
                   ENDDO 
                   nTabela:= 1 
                ELSE 
                   nTabela:= IF( !lOk, 1, nRow ) 
                ENDIF 
                EXIT 
           OTHERWISE                ;tone(125); tone(300) 
        ENDCASE 
        oTAB:refreshcurrent() 
        oTAB:stabilize() 
     ENDIF 
     aNovaOpcoes:= PegaTabela( nTabela ) 
     IF !aOpcoes==Nil 
        EXIT 
     ENDIF 
  ENDDO 
  IF nTabela > 0 .AND. !( aNovaOpcoes==Nil ) 
     aOpcoes:= aNovaOpcoes 
  ENDIF 
  SET( _SET_DELIMITERS, lDelimiters ) 
  Return .T. 
 
 
Static Function PegaTabela( nTabela ) 
   Local aNovaOpcoes 
   DO CASE 
      CASE nTabela==999   // Tabela de Opcoes Disponiveis 
           aNovaOpcoes:= { { " Producao                        " },; 
                           { " Assistencia Tecnica             " },; 
                           { " Financeiro                      " },; 
                           { " Atendimento                     " },; 
                           { " Fornecedores                    " },; 
                           { " Empresas / Filiais              " },; 
                           { " Atendimento ao Cliente          " } } 
 
      CASE nTabela==1     // Producao 
           aNovaOpcoes:= { { _MSG_PRODUTO    , 1 },; 
                           { _MSG_QUANTIDADE , 2 },; 
                           { _MSG_PREVISAO   , 3 },; 
                           { _MSG_OBSERVACAO , 4 },; 
                           { _MSG_SOLUCAO    , 5 } } 
 
      CASE nTabela==2     // Assistencia tecnica 
           aNovaOpcoes:= { { _MSG_PRODUTO    , 1 },; 
                           { _MSG_DEFEITO    , 2 },; 
                           { _MSG_DIAGNOSTICO, 3 },; 
                           { _MSG_INFORMACAO , 4 },; 
                           { _MSG_OBSERVACAO , 5 },; 
                           { _MSG_SOLUCAO    , 6 },; 
                           { _MSG_MATERIAL   , 7 } } 
 
      CASE nTabela==3     // Financeiro 
           aNovaOpcoes:= { { _MSG_NOTAFISCAL , 1 },; 
                           { _MSG_OBSERVACAO , 2 } } 
 
      CASE nTabela==4     // Atendimento 
           aNovaOpcoes:= { { _MSG_OBSERVACAO , 1 } } 
 
      CASE nTabela==5     // Fornecedore 
           aNovaOpcoes:= { { _MSG_NOTACOMPRA , 1 },; 
                           { _MSG_OBSERVACAO , 2 } } 
 
      CASE nTabela==6     // Empresas 
           aNovaOpcoes:= { { _MSG_OBSERVACAO , 1 } } 
 
      CASE nTabela==7     // Atendimento ao Cliente (Especial) 
           aNovaOpcoes:= { { _MSG_OBSERVACAO , 1 },; 
                           { _MSG_SOLUCAO    , 2 } } 
 
      OTHERWISE           // Nao Localizado 
           aNovaOpcoes:= { { _MSG_ERRO, 1 } } 
 
   ENDCASE 
   Return aNovaOpcoes 
 
 
 
Static Function Gravar( nCodigo, cDescri, dData__, cHora__, dDatFim,; 
                        cAtend_, nStatus, nCobran, nValor_, nValMao, nValPro, nValKmr, cCodAtdCFE, aInformacoes, aAtdCFE ) 
 
Local aOpcoes:= {} 
 
Local lInclusao:= .T., NtotMater := 0 
 
   DBSelectAR( _COD_ATEND ) 
   ATD->( DBSetOrder( 1 ) ) 
   IF ATD->( DBSeek( nCodigo ) ) 
 
      IF !( ATD->( Alltrim( DESCRI ) )=="RESERVADO" ) 
         lInclusao:= .F. 
      ENDIF 
 
      IF ATD->( NetRLock() ) 
         Replace ATD->CODIGO With nCodigo,; 
                 ATD->DESCRI With cDescri,; 
                 ATD->DATAEM With dData__,; 
                 ATD->HORA__ With cHora__,; 
                 ATD->DATFIM With dDatFim,; 
                 ATD->ATEND_ With cAtend_,; 
                 ATD->STATUS With nStatus,; 
                 ATD->COBRAN With nCobran,; 
                 ATD->CODCFE With cCodAtdCFE,; 
                 ATD->SETOR_ With SET->CODIGO,; 
                 ATD->VALOR_ With nValor_,; 
                 ATD->VALMAO With nValMao,; 
                 ATD->VALPRO With nValPro,; 
                 ATD->VALKMR With nValKmr 
*         ATD->( NetRLock() ) 
      ENDIF 
   ENDIF 
   ATA->( DBSetOrder( 1 ) ) 
   ATA->( DBSeek( nCodigo ) ) 
 
   /* Pega tabela "aOpcoes" destinada ao setor escolhido */ 
   nTabela:= SET->TIPTAB 
   TabAtendimento( @nTabela, @aOpcoes ) 
 
   FOR nRegistro:= 1 TO Len( aInformacoes ) 
       FOR nInfo:= 1 TO Len( aInformacoes[ nRegistro ] ) 
           IF !ATA->CODIGO==nCodigo 
              ATA->( DBAppend() ) 
           ENDIF 
           IF ATA->( NetRLock() ) 
 
              /* Gravar informacoes de aOpcoes[ x ] na tabela de informacoes, pois, 
                 pode acontecer do usuario entrar nas opcoes e editar somente algumas, 
                 deixando outras em branco e indo para a gravacao, o que sem esta linha 
                 ocasionaria um erro de data Type, pois o campo contendo o cabecalho 
                 nao estaria corretamente preenchido */ 
              aInformacoes[ nRegistro ][ nInfo ][ 2 ]:= aOpcoes[ nInfo ][ 1 ] 
 
              /* Gravacao dos dados na tabela */ 
              Replace ATA->CODIGO With nCodigo,; 
                      ATA->CODCFE With cCodAtdCFE,; 
                      ATA->CODREG With aInformacoes[ nRegistro ][ nInfo ][ 1 ],; 
                      ATA->INFORM With aInformacoes[ nRegistro ][ nInfo ][ 2 ],; 
                      ATA->HISTO1 With aInformacoes[ nRegistro ][ nInfo ][ 3 ],; 
                      ATA->HISTO2 With aInformacoes[ nRegistro ][ nInfo ][ 4 ],; 
                      ATA->HISTO3 With aInformacoes[ nRegistro ][ nInfo ][ 5 ],; 
                      ATA->HISTO4 With aInformacoes[ nRegistro ][ nInfo ][ 6 ],; 
                      ATA->HISTO5 With aInformacoes[ nRegistro ][ nInfo ][ 7 ],; 
                      ATA->ATEND_ With aInformacoes[ nRegistro ][ nInfo ][ 8 ],; 
                      ATA->DATA__ With aInformacoes[ nRegistro ][ nInfo ][ 9 ],; 
                      ATA->STATUS With aInformacoes[ nRegistro ][ nInfo ][ 10 ] 
              IF ALLTRIM( _MSG_MATERIAL ) $ ATA->INFORM 
                 IF subst(ATA->HISTO1,8,2) == "R$" .and. subst(ATA->HISTO1,15,1) == "." 
                    NtotMater += (val(subst(ATA->HISTO1,1,6))*val(subst(ATA->HISTO1,11,7))) 
                 ENDIF 
                 IF subst(ATA->HISTO2,8,2) == "R$" .and. subst(ATA->HISTO2,15,1) == "." 
                    NtotMater += (val(subst(ATA->HISTO2,1,6))*val(subst(ATA->HISTO2,11,7))) 
                 ENDIF 
                 IF subst(ATA->HISTO3,8,2) == "R$" .and. subst(ATA->HISTO3,15,1) == "." 
                    NtotMater += (val(subst(ATA->HISTO3,1,6))*val(subst(ATA->HISTO3,11,7))) 
                 ENDIF 
                 IF subst(ATA->HISTO4,8,2) == "R$" .and. subst(ATA->HISTO4,15,1) == "." 
                    NtotMater += (val(subst(ATA->HISTO4,1,6))*val(subst(ATA->HISTO4,11,7))) 
                 ENDIF 
                 IF subst(ATA->HISTO5,8,2) == "R$" .and. subst(ATA->HISTO5,15,1) == "." 
                    NtotMater += (val(subst(ATA->HISTO5,1,6))*val(subst(ATA->HISTO5,11,7))) 
                 ENDIF 
              ENDIF 
           ENDIF 
           ATA->( DBSkip() ) 
       NEXT 
   NEXT 
   /* Apaga registros que por ventura deixem de existir */ 
   WHILE ATA->CODIGO==nCodigo 
      IF ATA->( NetRlock() ) 
         ATA->( DBDelete() ) 
      ENDIF 
      ATA->( DBSkip() ) 
   ENDDO 
   IF NtotMater <> 0 
      IF ATD->( NetRLock() ) 
         Replace ATD->VALPRO With nTotMater 
         Replace ATD->VALOR_ With (ATD->VALPRO+ATD->VALMAO+ATD->VALKMR) 
      ENDIF 
   ENDIF 
   IF lInclusao 
      AAdd( aAtdCFE, { StrZero( ATD->CODIGO, 08, 0 ), ATD->DATAEM, ATD->HORA__, ATD->STATUS, ATD->DESCRI } ) 
   ENDIF 
   DBUnlockAll() 
 
   Return .T. 
 
 
/// Busca Produtos = BProdutos 
Static Function BProdutos() 
Local GetList:= {} 
Local cCor:= SetColor(), nCursor:= setCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nQuantidade:= nValor := 0 
Local cProduto:= "" 
Local cQuantidade:= cValor := "" 
 
 
   Set Key K_F9 to Busca99() 
   IF SWAlerta( "Lanáar movimento de estoque?", {"Sim", "Nao" } ) = 2 
 
      // Informacoes 
      VisualProdutos() 
      nValor := IIF(MPR->PERCDC = 0,MPR->PRECOV,MPR->PRECOD) 
      VPBox( 17, 28, 21, 79, "INFORMACOES DO PRODUTO", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      SetCursor( 1 ) 
      @ 18,30 Say "Nome......:" + MPR->DESCRI 
      @ 19,30 Say "Quantidade:" Get nQuantidade Pict "@E 999.99" 
      @ 20,30 Say "Valor.....:" Get nValor      Pict "@E 9999.99" 
      READ 
 
      // Quantidade de Produtos 
      IF nQuantidade = Int( nQuantidade ) 
         cQuantidade:= STRZERO( nQuantidade, 06, 0 ) 
      ELSE 
         cQuantidade:= STRZERO( nQuantidade, 06, 2 ) 
      ENDIF 
      cValor:= "R$ "+STRZERO( nValor, 07, 2 ) 
 
      // Ultima Tecla 
      IF LastKey() <> K_ESC 
         Keyboard CHR( K_HOME ) + LEFT( cQuantidade + " " + cValor + " " + LEFT( MPR->INDICE, 7 ) + " " + MPR->DESCRI, 100 ) + CHR( K_ENTER ) 
      ENDIF 
   ELSE 
 
      Estoqueinc(.T.) 
*      VPC69999() 
      IF lastKey() <> K_ESC 
         // Quantidade de Produtos 
         nQuantidade:= EST->QUANT_ 
         nValor     := EST->VALOR_ 
         IF nQuantidade = Int( nQuantidade ) 
            cQuantidade:= STRZERO( nQuantidade, 06, 0 ) 
         ELSE 
            cQuantidade:= STRZERO( nQuantidade, 06, 2 ) 
         ENDIF 
         cValor:= "R$ "+STRZERO( nValor, 07, 2 ) 
 
         MPR->( DBSetOrder( 1 ) ) 
         IF MPR->( DBSeek( EST->CPROD_ ) ) 
            // Ultima Tecla 
            IF LastKey() <> K_ESC 
               Keyboard CHR( K_HOME ) + LEFT( cQuantidade + " " + cValor + " " + LEFT( MPR->INDICE, 7 ) + " " + MPR->DESCRI, 100 ) + CHR( K_ENTER ) 
            ENDIF 
         ENDIF 
      ENDIF 
   ENDIF 
 
   Set Key K_F9 to BProdutos() 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return .T. 
 
Static Function SomValFicha(nValMao,nValPro,nValKmr,nValor_) 
nValor_ := (nValMao+nValPro+nValKmr) 
retu .t. 
