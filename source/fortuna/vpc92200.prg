// ## CL2HB.EXE - Converted
 
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ SelecaoClientes() 
³ Finalidade  ³ Relacao de Clientes 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Fevereiro/1995 
³ Atualizacao ³ Agosto/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function vpc92200()
#endif

  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local cTelaRes 
  Local cArquivo 
  Local cBairro 
 
  VPBox( 03, 08, 21, 79, " CLIENTES ", _COR_GET_EDICAO ) 
  nClien1:= 1 
  nClien2:= 999999 
  cConInd:= " " 
  cCliente:= " " 
  cCidade:= Space( LEN( CLI->CIDADE ) ) 
  cBairro:= Space( LEN( CLI->BAIRRO ) ) 
  cAniver:= Space( 4 ) 
  nVendedor:=  0 
  nAtividade:= 0 
  nLimCr1:= 0 
  nRegSpc2:= 0 
  nRegSpc1:= 0 
  nAtraso:=  15 
  nLimCr2:= 99999999.99 
  dVenIni:= CTOD("") 
  dVenFim:= CTOD("") 
  cIndice:= "DESCRI" 
  Set( _SET_DELIMITERS, .T. ) 
  SetCursor( 1 ) 
  SetColor( _COR_GET_EDICAO ) 
  Scroll( 04, 09, 20, 74 ) 
 
  SWDispStatus( .F. ) 
  Relatorio( "REPORT.INI", CURDIR() ) 
  SWDispStatus( .T. ) 
  cArquivo:= RepCliExportar 
  cArquivo:= PAD( cArquivo, 30 ) 
  @ 05, 10 Say "Do C¢digo.....................:" Get nClien1    Pict "999999" 
  @ 05, 51 Say "At‚:" Get nClien2 Pict "999999" 
  @ 06, 10 Say "Tipo [C]Cons/[I]Ind/[ ]Todos..:" Get cConInd    Pict "!" Valid cConInd $ "CI " 
  @ 07, 10 Say "Cliente [S]Sim [N]Nao [ ]Todos:" Get cCliente   Pict "!" Valid cCliente $ "SN " 
  @ 08, 10 Say "Vendedor......................:" Get nVendedor  Pict "9999" 
  @ 09, 10 Say "Tabela de Atividade...........:" Get nAtividade Pict "9999" 
  @ 10, 10 Say "Com Limite de Credito Entre...:" Get nLimCr1 Pict "@E 999,999,999.99" 
  @ 10, 59 Say "e:" Get nLimCr2 Pict "@E 999,999,999.99" 
  @ 11, 10 Say "Cidade........................:" Get cCidade 
  @ 12, 10 Say "Bairro........................:" Get cBairro 
  @ 13, 10 Say "c/ Registro SPC/Cobranca entre:" Get nRegSpc1 Pict "9" 
  @ 13, 45 Say " e:" Get nRegSpc2 Pict "9" 
  @ 14, 10 Say "Com atraso (em dias) de.......:" Get nAtraso Pict "9999" 
  @ 15, 10 Say "Com vencimento entre..........:" Get dVenIni 
  @ 15, 53 Say "e..:" Get dVenFim 
  @ 16, 10 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 17, 10 Say "Arquivo de Relatorio (.REP)...:" Get cArquivo 
  READ 
 
 
  // Intervalo de Vencimentos 
  IF dVenIni == CTOD( "  /  /  " ) 
     dVenIni:= CTOD( "01/01/90" ) 
  ENDIF 
  IF dVenFim == CTOD( "  /  /  " ) 
     dVenFim:= DATE() + ( 5 * 365 ) 
  ENDIF 
 
 
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
 
  DBSelectAr( _COD_CLIENTE ) 
 
  DPA->( DBSetOrder( 5 ) ) 
  DBGoTop() 
  WHILE !EOF() 
     IF RLock() 
        Replace SELECT With "Nao",; 
                ATRA_D With 0 
     ENDIF 
     DBSkip() 
  ENDDO 
  CCR->( DBSetOrder( 1 ) ) 
  Set Relation To CODIGO Into CCR 
  DBGoTop() 
  WHILE !EOF() 
     DPA->( DBSeek( CLI->CODIGO ) ) 
     WHILE DPA->CLIENT==CLI->CODIGO 
        IF EMPTY( DPA->DTQT__ ) .AND. DPA->VENC__ >= dVenIni .AND. DPA->VENC__ <= dVenFim .AND. DPA->NFNULA==" " 
           IF DATE() - DPA->VENC__ >= nAtraso 
              /* Se nÆo foi a primeira vez que passou 
                 ou se atraso atual ‚ maior que o gravado */ 
              IF ( DATE()-DPA->VENC__ >= ATRA_D ) .OR. SELECT=="Nao" 
                 IF NetRlock() 
                    Replace ATRA_D With DATE() - DPA->VENC__,; 
                            SELECT With IF( CCR->SPCEST >= nRegSpc1 .AND. CCR->SPCEST <= nRegSpc2, "Sim", "Nao" ) 
                 ENDIF 
              ENDIF 
           ENDIF 
        ENDIF 
        DPA->( DBSkip() ) 
     ENDDO 
     CLI->( DBSkip() ) 
  ENDDO 
 
  DBGoTop() 
 
  cIndice:= "DESCRI" 
 
  /* 
  Selecao: 
  ====================================== 
  Com Vendedor e Com Codigo de Atividade 
  Com Vendedor e Sem Codigo de Atividade 
  Sem Vendedor e Sem Codigo de Atividade 
  Sem Vendedor e Com Codigo de Atividade 
  -------------------------------------- 
  */ 
  IF cAniver==Space( 4 ) 
     bValidate:= {|| .T. } 
  ELSE 
     nDia:= Val( SubStr( cAniver, 1, 2 ) ) 
     nMes:= Val( SubStr( cAniver, 3, 2 ) ) 
     bValidate:= {|| MONTH( NASCIM )==nMes .AND. DAY( NASCIM )==nDia } 
  ENDIF 
 
  IF !EMPTY( cCIDADE ) 
     IF !EMPTY( cBairro ) 
        cCidade:= PAD( cCidade, 30 ) 
        cBairro:= PAD( cBairro, Len( CLI->BAIRRO ) ) 
        IF nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate )  .AND. CIDADE $ cCidade .AND. BAIRRO $ cBairro .AND. ATRA_D >= nAtraso .AND. CLIENT $ cCliente Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CIDADE $ cCidade .AND. BAIRRO $ cBairro .AND. ATRA_D >= nAtraso .AND. CLIENT $ cCliente .AND. CODATV == nAtividade Eval {|| Processo() } 
        ENDIF 
     ELSE 
        IF nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND. ATRA_D >= nAtraso .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CIDADE $ cCidade .AND. CLIENT $ cCliente Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND. ATRA_D >= nAtraso .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. CIDADE $ cCidade .AND. CLIENT $ cCliente .AND. CODATV == nAtividade Eval {|| Processo() } 
        ENDIF 
     ENDIF 
  ELSE 
     IF ! nVendedor == 0 
        IF ! nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. ATRA_D >= nAtraso  .AND. CLIENT $ cCliente .AND.; 
                    CODATV == nAtividade .AND.; 
                    ( VENIN1 == nVendedor .OR. VENEX1 == nVendedor) Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. ATRA_D >= nAtraso  .AND. CLIENT $ cCliente .AND. ( VENIN1 == nVendedor .OR.; 
                    VENEX1 == nVendedor ) Eval {|| Processo() } 
        ENDIF 
     ELSE 
        IF nAtividade == 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. ATRA_D >= nAtraso .AND. CLIENT $ cCliente Eval {|| Processo() } 
        ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON &cIndice TO INDICE01.TMP FOR CODIGO >= nCLIEN1 .AND. CODIGO <= nCLIEN2 .AND.; 
                    CONIND $ cConInd .AND. EVAL( bValidate ) .AND. ATRA_D >= nAtraso .AND. CLIENT $ cCliente .AND. CODATV == nAtividade Eval {|| Processo() } 
        ENDIF 
     ENDIF 
  ENDIF 
 
  SetCursor( 0 ) 
  DBGoTop() 
  Mensagem( "[ALT+I]Informacoes [TAB]Gerar_Arquivo [ESC]Finaliza [ESPACO]Seleciona" ) 
  VPBox( 00, 00, 22, 79, "CLIENTES SELECIONADOS", _COR_GET_BOX, .F., .F. ) 
  oTb:= TBrowseDB( 01, 01, 21, 78 ) 
  oTb:AddColumn( TbColumnNew("Codigo   Cliente                                  SPC Informacoes  ATR S/N",; 
               {|| StrZero( CODIGO, 8, 0 ) + " " + Left( DESCRI, 40 ) + " " + StrZero( CCR->SPCEST, 1, 0 ) + SPCInfo( CCR->SPCEST ) + StrZero( ATRA_D, 3, 0 ) + " " + Select + Space( 10 ) } ) ) 
  oTb:AUTOLITE:=.F. 
  oTb:dehilite() 
  While .T. 
      oTb:ColorRect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      Whil NextKey()=0 .and.! oTb:Stabilize() 
      enddo 
      IF oTb:nRight < 78 
         DispBegin() 
         SetColor( "15/03" ) 
         Scroll( 02, 52, 21, 78 ) 
         DPA->( DBSeek( CLI->CODIGO ) ) 
         nCt:= 1 
         @ ++nCt,52 Say "Duplic Vencimen       Valor" 
         WHILE DPA->CLIENT==CLI->CODIGO .AND. nCt < 18 
            IF DPA->DTQT__==CTOD( "  /  /  " ) 
               IF DPA->VENC__ < DATE() 
                  SetColor( "04/03" ) 
               ELSE 
                  SetColor( "15/03" ) 
               ENDIF 
               @ ++nCt,52 Say StrZero( DPA->CODNF_, 06, 0 ) +" "+DTOC( DPA->VENC__ )+" " + Tran( DPA->VLR___, "@E 9999,999.99" ) 
            ENDIF 
            DPA->( DBSkip() ) 
         ENDDO 
         SetColor( "15/03" ) 
         IF nCt==2 
            @ nCt,52 Say "Sem Pendencias             " 
         ENDIF 
         SetColor( "00/07" ) 
         Scroll( 19, 52, 21, 78 ) 
         @ 19,52 Say Alltrim( SPCInfo( CCR->SPCEST ) ) 
         @ 20,52 Say "Maior Atraso: " + StrZero( ATRA_D, 3, 0 ) 
         @ 21,52 Say IF( Select=="Sim", "Selecionado", " " ) 
         DispEnd() 
         SetColor( _COR_GET_EDICAO ) 
      ENDIF 
      nTECLA:=inkey(0) 
      If nTECLA=K_ESC 
         Exit 
      EndIf 
      do case 
         case nTECLA==K_UP         ;oTb:up() 
         case nTECLA==K_DOWN       ;oTb:down() 
         case nTECLA==K_PGUP       ;oTb:pageup() 
         case nTECLA==K_PGDN       ;oTb:pagedown() 
         case nTECLA==K_HOME       ;oTb:gotop() 
         case nTECLA==K_END        ;oTb:gobottom() 
         case nTecla==K_F12        ;Calculador() 
         CASE nTecla==K_CTRL_F10   ;Calendar() 
         case nTecla==K_ALT_I 
              IF oTb:nRight==78 
                 FOR nCt:= 79 TO 52 Step -1 
                    oTb:nRight:= oTb:nRight - 1 
                    VPBox( 01, nCt-1, 22, 79,  ,"15/03", .F., .F. ) 
                    SetColor( "15/03" ) 
                    Scroll( 02, nCt+1, 21, 78 ) 
                 NEXT 
                 SetColor( _COR_GET_EDICAO ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
              ELSE 
                 FOR nCt:= 52 TO 79 
                    oTb:nRight:= oTb:nRight + 1 
                    SetColor( _COR_GET_EDICAO ) 
                    Scroll( 01, nCt-1, 22, 78, , -1 ) 
                    @ 22, nCt-1 Say "»" Color _COR_GET_BOX 
                    //oTb:RefreshAll() 
                    //WHILE !oTb:Stabilize() 
                    //ENDDO 
                 NEXT 
                 DispBegin() 
                 VPBox( 0, 0, 22 , 79, "CLIENTES SELECIONADOS", _COR_GET_BOX, .F., .F. ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
                 DispEnd() 
              ENDIF 
         case DBPesquisa( nTecla, oTb ) 
         case nTecla == K_F2; DBMudaOrdem( 1, oTb ) 
         case nTecla == K_F3; DBMudaOrdem( 3, oTb ) 
         case nTecla == K_F4; DBMudaOrdem( 4, oTb ) 
         case nTecla == K_F5; DBMudaOrdem( 6, oTb ) 
         case nTecla == K_SPACE 
              IF NetRLock() 
                 Replace SELECT With IF( SELECT=="Nao","Sim","Nao") 
              ENDIF 
         case nTecla == K_TAB 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              DBGoTop() 
              WHILE !EOF() 
                 IF SELECT=="Sim" 
                    DBSelectAr( _COD_CREDIARIO ) 
                    Mensagem( "buscando informacoes de crediario, aguarde..." ) 
                    IF NetRLock() .AND. !EOF() 
                       IF CCR->SPCEST < 5 
                          Replace CCR->SPCEST With CCR->SPCEST + 1 
                       ENDIF 
                    ELSE 
                       cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                       Mensagem( "O cliente nÆo possui ficha de crediario!" ) 
                       Pausa() 
                       ScreenRest( cTelaRes ) 
                    ENDIF 
                    DBSelectAR( _COD_CLIENTE ) 
                    DBSkip() 
                 ELSEIF SELECT=="Nao" 
                    DBSkip() 
                 ENDIF 
              ENDDO 
              Set Filter To SELECT == "Sim" 
              DBGoTop() 
              /* Emissao do relatorio */ 
              Relatorio( AllTrim( cArquivo ) ) 
              DispBegin() 
              Set Filter To 
              DBGoTop() 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
              DispEnd() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:Refreshcurrent() 
      oTb:Stabilize() 
  enddo 
  /* Retorna para porta DEFAULT */ 
  Set( 24, "LPT1" ) 
  SWGravar( 5 ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/cliind01.ntx", "&gdir/cliind02.ntx", "&gdir/cliind03.ntx", "&gdir/cliind04.ntx", "&gdir/cliind05.ntx", "&gdir/cliind06.ntx", "&gdir/cliind07.ntx"        
  #else 
    Set Index To "&GDIR\CLIIND01.NTX", "&GDIR\CLIIND02.NTX", "&GDIR\CLIIND03.NTX", "&GDIR\CLIIND04.NTX", "&GDIR\CLIIND05.NTX", "&GDir\CLIIND06.NTX", "&GDir\CLIIND07.NTX"        
  #endif
  Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ SPCInfo 
³ Finalidade  ³ Retornar informacoes de SPC 
³ Parametros  ³ nCodigo-Codigo de Informacao 
³ Retorno     ³ cDescricao 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function SPCInfo( nCodigo ) 
IF CCR->( EOF() ) 
   cDescri:= " SEM CREDIARIO  " 
   IF Select=="Sim" .AND. NetRLock() 
      Replace SELECT With "Nao" 
   ENDIF 
ELSE 
   cDescri:= "                " 
   DO CASE 
      CASE nCodigo==0 
           cDescri:= " Sem Cartas     " 
      CASE nCodigo==1 
           cDescri:= " 1§ Aviso       " 
      CASE nCodigo==2 
           cDescri:= " 2§ Aviso       " 
      CASE nCodigo==3 
           cDescri:= " 3§ Aviso       " 
      CASE nCodigo==4 
           cDescri:= " SPC            " 
      CASE nCodigo>=5 
           cDescri:= " Bloqueado      " 
           IF Select=="Sim" .AND. NetRLock() 
              Repl SELECT With "Nao" 
           ENDIF 
   ENDCASE 
ENDIF 
Return cDescri 
