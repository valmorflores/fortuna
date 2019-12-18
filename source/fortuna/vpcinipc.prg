// ## CL2HB.EXE - Converted
#Include "FORMATOS.CH" 
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPCINIPC.PRG 
³ Finalidade  ³ PCP INICIO DE PRODUCAO 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
   Func PCPIniPro() 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ), nQuadro:= 0 
      Local Otb, Otb2, aProRel, nCodigo, nRowProRel:= 1, nTamCod:= 0, ; 
            nCorCod:= 0, xTela, yTela 
 
      aProRel:= 0 
      aProRel:= {} 
      Set Deleted On 
      SetCursor( 0 ) 
 
      DBSelectAr( _COD_PCPMOVI ) 
 
      nCodigo:= PCM->CODIGO 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      UserScreen() 
      VPBox( 00, 00, 13, 79,"ORDEM DE SERVICO / PRODUCAO", _COR_GET_BOX, .F., .F. ) 
      VPBox( 14, 00, 22, 79,"Display", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
      Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
      SetColor( _COR_BROWSE ) 
 
      MPR->( DBSetOrder( 1 ) ) 
      PCL->( DBSetOrder( 1 ) ) 
 
      DBLeOrdem() 
      oTb:=TBrowseDB( 15, 01, 21, 78 ) 
      oTb:AddColumn( tbcolumnnew( "C¢digo Descri‡„o" + ; 
         "                                    Situa‡„o           In¡cio",; 
         {|| STR( PCM->CODIGO, 6 ) + " " + LEFT( PCM->DESCRI, 44 ) + " " + ; 
            fVerifSitProd( PCM->SITPER ) + " " + STR( PCM->SITPER, 3) + "% " + ; 
            DTOC( PCM->DATINI ) + SPACE( 65 ) } ) ) 
      oTb:AutoLite:=.f. 
      oTb:dehilite() 
 
     // ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
      xTela:= ScreenSave( 0, 0, 24, 79 ) 
 
      SetColor( _COR_BROWSE ) 
      VPBox( 05, 04, 12, 75," Informa‡”es Adicionais ", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
      fProRel( @nCodigo, @aProRel, @nRowProRel, @nTamCod ) 
 
      oTb2:=TBrowseNew( 06, 05, 11, 74 ) 
 
      oTb2:AddColumn( tbcolumnnew( ; 
                      "Produto  C¢d.F brica   Descri‡„o do Produto" + ; 
                      "                        Sel", ; 
                      {|| ; 
                     LEFT( aProRel [nRowProRel, 1], 3 )    + "-" + ; 
                     SUBSTR( aProRel [nRowProRel, 1], 4, 4 ) + " " + ; 
                             aProRel [nRowProRel, 2]        + " " + ; 
                     LEFT( aProRel [nRowProRel, 3], 43 )   + " " + ; 
                             aProRel [nRowProRel, 4]        + " " + ; 
                             Space( 65 ) } ) ) 
 
      oTb2:AutoLite:=.f. 
      oTb2:GOTOPBLOCK:={|| nRowProRel:= 1 } 
      oTb2:GOBOTTOMBLOCK:={|| nRowProRel:= Len( aProRel ) } 
      oTb2:SKIPBLOCK:={|x| skipperarr( x, aProRel, @nRowProRel )} 
      oTb2:dehilite() 
 
      ScreenRest( xTela ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
      IF( nQuadro = 0 ) 
         Mensagem( "[INS]Inc [ENTER]Alt [DEL]Exc [CRTL+ENTER]Itens [TAB]Impress„o [ESC]Sair" ) 
      ELSE 
         Mensagem( "[INS]Inclus„o [ENTER]Quantidade [CRTL+ENTER]Produ‡„o [ESC]Sair" ) 
      ENDIF 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
      WHILE .T. 
 
         IF nQuadro == 0 
            oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT  }, { 2, 1 } ) 
            WHILE !oTb:Stabilize() 
            ENDDO 
         ENDIF 
 
         DispBegin() 
         IF nQuadro == 0 
            // Display das informacoes // 
            SetColor( _COR_GET_EDICAO ) 
            @ 02, 03 Say "C¢digo da Produ‡„o .. [      ]" 
            @ 03, 03 Say "Descri‡„o ........... [" + SPACE( _ESP_DESCRICAO ) + "]" 
            @ 04, 03 Say "Situa‡„o ............ [   %] [                    ]" 
            @ 05, 03 Say "Data Inicial ........ [  /  /  ]" 
            @ 06, 03 Say "Data Final .......... [  /  /  ]" 
            @ 07, 03 Say "Emitente ............ [                    ]" 
            @ 08, 03 Say "Encarregado ......... [                    ]" 
            @ 09, 03 Say "Observa‡”es ......... [                                        ] ..." 
            @ 10, 03 Say REPL( "Ä", 74 ) 
            @ 11, 03 Say "N£mero do Pedido .... [        ]" 
            @ 12, 03 Say "Cliente ............. [      ] [                                        ]" 
 
            @ 02, 26 Say STR( PCM->CODIGO ) 
            @ 03, 26 Say PCM->DESCRI 
            @ 04, 26 Say PCM->SITPER 
               @ 04, 33 Say fVerifSitProd( PCM->SITPER ) 
            @ 05, 26 Say PCM->DATINI 
            @ 06, 26 Say PCM->DATFIN 
            @ 07, 26 Say PCM->EMITEN 
            @ 08, 26 Say PCM->ENCARR 
            @ 09, 26 Say LEFT( PCM->OBSERV, 40 ) 
 
            @ 11, 26 Say PCM->CODPED 
            @ 12, 26 Say PCM->CODCLI 
               @ 12, 35 Say LEFT( PCM->DESCLI, 40 ) 
         ENDIF 
 
         nCodigo:= PCM->CODIGO 
         IF( nQuadro = 0 ) 
            IF( LASTKEY() == K_UP .OR. LASTKEY() == K_DOWN ) 
               KeyBoard( CHR( K_LEFT ) ) 
            ENDIF 
         ELSE 
            oTb2:colorrect( { oTb2:ROWPOS, 1, oTb2:ROWPOS, oTb2:COLCOUNT }, { 2, 1 } ) 
            WHILE !oTb2:Stabilize() 
            ENDDO 
         ENDIF 
         DispEnd() 
 
         nTecla:=inkey( 0 ) 
 
         // Teste da tecla pressionadas // 
         DO CASE 
            CASE nTecla==K_ESC 
               IF nQuadro == 0 
                  EXIT 
               ELSE 
                  nQuadro:= 0 
                  ScreenRest( xTela ) 
               ENDIF 
            CASE nTecla==K_UP 
               IF( nQuadro = 0, oTb:up()      , oTb2:up() ) 
            CASE nTecla==K_LEFT 
               IF( nQuadro = 0, oTb:PanLeft() , oTb2:PanLeft() ) 
            CASE nTecla==K_RIGHT 
               IF( nQuadro = 0, oTb:PanRight(), oTb2:PanRight() ) 
            CASE nTecla==K_DOWN 
               IF( nQuadro = 0, oTb:down()    , oTb2:down() ) 
            CASE nTecla==K_PGUP 
               IF( nQuadro = 0, oTb:pageup()  , oTb2:pageup() ) 
            CASE nTecla==K_PGDN 
               IF( nQuadro = 0, oTb:pagedown(), oTb2:pagedown() ) 
            CASE nTecla==K_CTRL_PGUP 
               IF( nQuadro = 0, oTb:gotop()   , oTb2:gotop() ) 
            CASE nTecla==K_CTRL_PGDN 
               IF( nQuadro = 0, oTb:gobottom(), oTb2:gobottom() ) 
            CASE nTecla==K_INS 
               IF( nQuadro = 0 ) 
                  PCPMovInc( @oTb, @nCorCod, @nTamCod, ; 
                             @aProRel, @nRowProRel, @oTb2, @nCodigo ) 
               ELSE 
                  IF !EMPTY( PCM->CODPED ) 
                     yTela:= ScreenSave( 0, 0, 24, 79 ) 
                     Aviso( "Todos os ¡tens do Pedido s„o inclusos autom ticamente !", 12 ) 
                     Pausa() 
                     ScreenRest( yTela ) 
                  ELSE 
                     aProRel:= 0 
                     aProRel:= {} 
                     cDescri:= PCM->DESCRI 
                     nTamCod:= 1 
                     fPCPVerPro( @nCodigo, @cDescri, GetList, ; 
                                 @aProRel, @nRowProRel, @nTamCod, @oTb2 ) 
                  ENDIF 
               ENDIF 
            CASE nTecla==K_ENTER 
               IF nQuadro == 0 
                  PCPMovAlt( @oTb, @nCorCod, @nTamCod, ; 
                     @aProRel, @nRowProRel, @oTb2, @nCodigo ) 
                  CLEAR TYPEAHEAD 
               ELSE 
                  nClasse:= aProRel[ nRowProRel ][ 5 ] 
                  cTemCor:= aProRel[ nRowProRel ][ 6 ] 
                  IF( nClasse <> 0 .OR. cTemCor == "S" ) 
                     PCPIniTam( @aProRel, @nRowProRel, nCodigo, @nCorCod, @nTamCod, "INI" ) 
                  ELSE 
                     fRecQua( @aProRel, @nRowProRel, nCodigo, @nCorCod, @nTamCod ) 
                  ENDIF 
               ENDIF 
            CASE nTecla==K_TAB 
               IF( nQuadro == 0 ) 
                  IF Confirma( 00, 00,; 
                     "Confirma a impress„o desta Produ‡„o?",; 
                     "Digite [S] para confirmar ou [N] p/ cancelar.", "N" ) 
                     Relatorio( "ORDEMPRO.REP" ) 
                  ENDIF 
               ENDIF 
            CASE nTecla==K_CTRL_ENTER // TECLA TEMPORARIA 
               IF nQuadro == 0 
                  nQuadro:= 1 
                  xTela:= ScreenSave( 0, 0, 24, 79 ) 
                  VPBox( 05, 04, 12, 75," Itens da Produ‡„o ", _COR_BROW_BOX, .F., .F., ,.F. ) 
                  fProRel( @nCodigo, @aProRel, @nRowProRel, @nTamCod, @oTb2 ) 
                  oTb2:colorrect( { oTb2:ROWPOS, 1, oTb2:ROWPOS, 3 }, { 2, 1 } ) 
                  oTb2:RefreshAll() 
                  WHILE !oTb2:Stabilize() 
                  ENDDO 
                  Mensagem( "[INS]Inclus„o [ENTER]Quantidade [CRTL+ENTER]Produ‡„o [ESC]Sair" ) 
                  oTb:RefreshAll() 
                  WHILE !oTb:Stabilize() 
                  ENDDO 
               ELSE 
                  nQuadro:= 0 
                  ScreenRest( xTela ) 
               ENDIF 
            CASE nTecla==K_DEL 
               IF( nQuadro = 0 ) 
                  IF Exclui( oTb ) 
                     oTb:RefreshAll() 
                     WHILE !oTb:Stabilize() 
                     ENDDO 
                     aProRel:= 0 
                     aProRel:= {} 
                  ENDIF 
               ELSE 
                  IF Confirma( 00, 00, "Confirma a exclus„o deste ¡tem?",; 
                        "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
                     Adel( aProRel, nRowProRel ) 
                     IF( Len( aProRel ) <= 0 ) 
                        AADD( aProRel, {Space( 12 ), Space( 13 ), Space( 40 ), Space( 4 ), 0, "N", 0} ) 
                     ENDIF 
                     oTb2:RefreshAll() 
                     WHILE !oTb2:Stabilize() 
                     ENDDO 
                     cProdut:= PCL->CODPRO 
                     nCodigo:= PCL->CODIGO 
                     fExcItensProd( cProdut, nCodigo ) 
                  ENDIF 
               ENDIF 
            CASE nTecla==K_F2;  IF( nQuadro = 0, DBMudaOrdem( 1, oTb ), NIL ) 
            CASE nTecla==K_F3;  IF( nQuadro = 0, DBMudaOrdem( 2, oTb ), NIL ) 
            CASE IF( nQuadro = 0, DBPesquisa( nTecla, oTb ), .T. ) 
 
            OTHERWISE                 ;Tone( 125 ); Tone( 300 ) 
         ENDCASE 
 
         IF( nQuadro = 0 ) 
            oTb:RefreshCurrent() 
            oTb:Stabilize() 
         ELSE 
            oTb2:RefreshCurrent() 
            oTb2:Stabilize() 
         ENDIF 
 
      ENDDO 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func PCPMovInc( oTb, nCorCod, nTamCod, aProRel, nRowProRel, oTb2, nCodigo ) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd() 
 
      Local cDescri, nSitPer, dDatini, dDatfin, cEmiten, cEncarr, cObserv, ; 
            cCodped, nCodcli, cDescli 
 
      cDescri:= Space( _ESP_DESCRICAO ) 
      nSitPer:= 0 
      dDatini:= DATE() 
      dDatfin:= CTOD( "  /  /  " ) 
      cEmiten:= Space( 20 ) 
      cEncarr:= Space( 20 ) 
      cObserv:= Space( 120 ) 
      cCodped:= Space( 08 ) 
      nCodcli:= 0 
      cDescli:= Space( 40 ) 
 
      DBSelectAr( _COD_PCPMOVI ) 
 
      WHILE ! LastKey() == K_ESC 
 
         PCM->( DBSetOrder( 1 ) ) 
         PCM->( dbGoBottom() ) 
         nCodigo:= PCM->CODIGO + 1 
         PCM->( DBSetOrder( nOrdem ) ) 
         PCM->( dbGoTop() ) 
         KeyBoard( CHR( K_ENTER ) ) 
 
         // Display das informacoes // 
         SetColor( _COR_GET_EDICAO ) 
 
         @ 02, 03 Say "C¢digo da Produ‡„o .." Get nCodigo Pict "999999" ; 
            When MENSAGEM( "Digite o C¢digo da Produ‡„o" ) ; 
            VALID LASTKEY() = K_ESC .OR. fPCPVerPrc( nCodigo, @oTb, GetList ) 
 
         @ 03, 03 Say "Descri‡„o ..........." Get cDescri ; 
            When MENSAGEM( "Digite a Descri‡„o da Produ‡„o" ) ; 
            VALID !LASTKEY() == K_ESC .AND. !LASTKEY() == K_UP .AND. ; 
               !EMPTY( cDescri ) 
 
         @ 04, 03 Say "Situa‡„o ............" Get nSitPer Pict "999%"     ; 
            When MENSAGEM( "Digite o percentual da situa‡„o da Produ‡„o" ) 
         @ 05, 03 Say "Data Inicial ........" Get dDatini Pict "99/99/99" ; 
            When MENSAGEM( "Digite a data de in¡cio da Produ‡„o" ) 
         @ 06, 03 Say "Data Final .........." Get dDatfin Pict "99/99/99" ; 
            When MENSAGEM( "Digite a data final da Produ‡„o" ) 
         @ 07, 03 Say "Emitente ............" Get cEmiten                 ; 
            When MENSAGEM( "Digite o nome do emitente da Produ‡„o" ) 
         @ 08, 03 Say "Encarregado ........." Get cEncarr                 ; 
            When MENSAGEM( "Digite o nome do encarregado da Produ‡„o" ) 
         @ 09, 03 Say "Observa‡”es ........." Get cObserv Pict "@S40"     ; 
            When MENSAGEM( "Digite as observa‡”es sobre a Produ‡„o" ) 
 
         SetCursor( 1 ) 
         READ 
         SetCursor( nCursor ) 
 
         IF ! LastKey() == K_ESC 
 
            fPCPVerPed( @nCodigo, @cCodPed, @cDescri, ; 
                        @nCodCli, @cDesCli, GetList ) 
 
            IF LEN( ALLTRIM( cCodPed ) ) == 0 
               fPCPVerPro( @nCodigo, @cDescri, GetList, ; 
                           @aProRel, @nRowProRel, @nTamCod, @oTb2 ) 
            ENDIF 
 
            // Gravacao de dados // 
            PCM->( DBAppend() ) 
            IF NetRLock() 
               PCM->CODIGO := nCodigo 
               PCM->DESCRI := cDescri 
               PCM->SITPER := nSitPer 
               PCM->DATINI := dDatini 
               PCM->DATFIN := dDatfin 
               PCM->EMITEN := cEmiten 
               PCM->ENCARR := cEncarr 
               PCM->OBSERV := cObserv 
               PCM->CODPED := cCodped 
               PCM->CODCLI := nCodcli 
               PCM->DESCLI := cDescli 
            ENDIF 
 
            KEYBOARD( CHR( K_CTRL_ENTER ) ) 
 
            EXIT 
 
         ENDIF 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
      oTb:RefreshAll() 
      WHILE !oTb:Stabilize() 
      ENDDO 
 
   Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func PCPMovAlt( oTb, nCorCod, nTamCod, aProRel, nRowProRel, oTb2, nCodigo ) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd() 
 
      Local cDescri, nSitPer, dDatini, dDatfin, cEmiten, cEncarr, cObserv, ; 
            cCodped, nCodcli, cDescli 
 
      cDescri:= PCM->DESCRI 
      nSitPer:= PCM->SITPER 
      dDatini:= PCM->DATINI 
      dDatfin:= PCM->DATFIN 
      cEmiten:= PCM->EMITEN 
      cEncarr:= PCM->ENCARR 
      cObserv:= PCM->OBSERV 
      cCodped:= PCM->CODPED 
      nCodcli:= PCM->CODCLI 
      cDescli:= PCM->DESCLI 
 
      DBSelectAr( _COD_PCPMOVI ) 
 
      WHILE ! LastKey() == K_ESC 
 
         nCodigo:= PCM->CODIGO 
 
         // Display das informacoes // 
         SetColor( _COR_GET_EDICAO ) 
 
         @ 03, 03 Say "Descri‡„o ..........." Get cDescri ; 
            When MENSAGEM( "Digite a Descri‡„o da Produ‡„o" ) ; 
            VALID !LASTKEY() == K_ESC .AND. !LASTKEY() == K_UP .AND. ; 
               !EMPTY( cDescri ) 
 
         @ 04, 03 Say "Situa‡„o ............" Get nSitPer Pict "999%"     ; 
            When MENSAGEM( "Digite o percentual da situa‡„o da Produ‡„o" ) 
         @ 05, 03 Say "Data Inicial ........" Get dDatini Pict "99/99/99" ; 
            When MENSAGEM( "Digite a data de in¡cio da Produ‡„o" ) 
         @ 06, 03 Say "Data Final .........." Get dDatfin Pict "99/99/99" ; 
            When MENSAGEM( "Digite a data final da Produ‡„o" ) 
         @ 07, 03 Say "Emitente ............" Get cEmiten                 ; 
            When MENSAGEM( "Digite o nome do emitente da Produ‡„o" ) 
         @ 08, 03 Say "Encarregado ........." Get cEncarr                 ; 
            When MENSAGEM( "Digite o nome do encarregado da Produ‡„o" ) 
         @ 09, 03 Say "Observa‡”es ........." Get cObserv Pict "@S40"     ; 
            When MENSAGEM( "Digite as observa‡”es sobre a Produ‡„o" ) 
 
         SetCursor( 1 ) 
         READ 
         SetCursor( nCursor ) 
 
         IF ! LastKey() == K_ESC 
 
            // Gravacao de dados // 
            IF NetRLock() 
               PCM->CODIGO := nCodigo 
               PCM->DESCRI := cDescri 
               PCM->SITPER := nSitPer 
               PCM->DATINI := dDatini 
               PCM->DATFIN := dDatfin 
               PCM->EMITEN := cEmiten 
               PCM->ENCARR := cEncarr 
               PCM->OBSERV := cObserv 
               PCM->CODPED := cCodped 
               PCM->CODCLI := nCodcli 
               PCM->DESCLI := cDescli 
            ENDIF 
 
            KEYBOARD( CHR( K_ENTER ) ) 
 
            EXIT 
 
         ENDIF 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
      oTb:RefreshAll() 
      WHILE !oTb:Stabilize() 
      ENDDO 
 
   Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fPCPVerPrc( nCodigo, Otb, GetList  ) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd() 
      Local lRet:= .T. 
 
      PCM->( DBSetOrder( 1 ) ) 
 
      IF PCM->( DBSeek( nCodigo ) ) 
         Aviso( "Produ‡„o j  existente !", 12 ) 
         Pausa() 
         lRet:= .F. 
      ENDIF 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
      oTb:RefreshAll() 
      WHILE !oTb:Stabilize() 
      ENDDO 
 
   Return( lRet ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fPCPVerPed( nCodigo, cCodPed, cDescri, nCodCli, cDesCli, ; 
                    GetList ) 
 
      LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla, lRet:= .F. 
 
      DBSelectAr( _COD_PEDIDO ) 
      DBLeOrdem() 
      dbGoTop() 
 
      SetColor( _COR_BROWSE ) 
      VPBox( 14, 00, 22, 79,"CADASTRO DE PEDIDOS", _COR_BROW_BOX, .F., .F. ) 
 
      Mensagem( "[ENTER]Selecionar [ESC]Mat‚rias-Primas" ) 
      Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
      oTb:=TBrowseDB( 15, 01, 21, 78 ) 
      oTb:AddColumn( tbcolumnnew( ,{|| LEFT( CODIGO, 8 ) + " " + DESCRI + ; 
         SPACE( 65 ) } ) ) 
 
      oTb:AutoLite:=.f. 
      oTb:dehilite() 
 
      WHILE .T. 
 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         nTecla:=inkey( 0 ) 
 
         IF nTecla=K_ESC 
            cCodPed:= "" 
            EXIT 
         ENDIF 
 
         // Teste da tecla pressionadas // 
         DO CASE 
            CASE nTecla==K_UP         ;oTb:up() 
            CASE nTecla==K_LEFT       ;oTb:PanLeft() 
            CASE nTecla==K_RIGHT      ;oTb:PanRight() 
            CASE nTecla==K_DOWN       ;oTb:down() 
            CASE nTecla==K_PGUP       ;oTb:pageup() 
            CASE nTecla==K_PGDN       ;oTb:pagedown() 
            CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
            CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
            CASE DBPesquisa( nTecla, oTb ) 
            CASE nTecla==K_F2;    DBMudaOrdem( 1, oTb ) 
            CASE nTecla==K_F3;    DBMudaOrdem( 2, oTb ) 
            CASE nTecla==K_F4;    DBMudaOrdem( 3, oTb ) 
            CASE nTecla==K_F5;    DBMudaOrdem( 4, oTb ) 
            CASE nTecla==K_ENTER 
               cCodPed:= CODIGO 
               IF( EMPTY( cDescri ) == .T. ) 
                  IF( LEN( DESCRI ) < _ESP_DESCRICAO ) 
                     cDescri:= DESCRI + SPACE( _ESP_DESCRICAO - LEN( DESCRI ) ) 
                  ELSE 
                     cDescri:= DESCRI 
                  ENDIF 
               ENDIF 
               nCODCLI:= PED->CODCLI 
               cDESCLI:= PED->DESCRI 
               lRet:= .T. 
               fIncProPed( @nCodigo, @cCodPed, @cDescri, GetList ) 
               EXIT 
            OTHERWISE                 ;Tone( 125 ); Tone( 300 ) 
        ENDCASE 
 
        oTb:RefreshCurrent() 
        oTb:Stabilize() 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
 
   Return( lRet ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fPCPVerPro( nCodigo, cDescri, GetList, aProRel, nRowProRel, nTamCod, oTb2 ) 
 
      LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla, lRet:= .F. 
 
      VPBox( 05, 04, 12, 75," Itens da Produ‡„o ", _COR_BROW_BOX, .F., .F., ,.F. ) 
      fProRel( @nCodigo, @aProRel, @nRowProRel, @nTamCod, @oTb2 ) 
      oTb2:RefreshAll() 
      WHILE !oTb2:Stabilize() 
      ENDDO 
 
      DBSelectAr( _COD_MPRIMA ) 
      DBLeOrdem() 
      dbGoTop() 
 
      SetColor( _COR_BROWSE ) 
      VPBox( 14, 00, 22, 79,"CADASTRO DE PRODUTOS", _COR_BROW_BOX, .F., .F. ) 
 
      Mensagem( "[ENTER]Selecionar [TAB/ESC]Itens da Produ‡„o" ) 
      Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
      oTb:=TBrowseDB( 15, 01, 21, 78 ) 
      oTb:AddColumn( tbcolumnnew( ,{|| LEFT( INDICE, 8 ) + " " + CODFAB + " " + ; 
         DESCRI + SPACE( 35 ) } ) ) 
 
      oTb:AutoLite:=.f. 
      oTb:dehilite() 
 
      WHILE .T. 
 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         nTecla:=inkey( 0 ) 
 
         IF nTecla=K_ESC 
            CLEAR TYPEAHEAD 
            EXIT 
         ENDIF 
 
         // Teste da tecla pressionada // 
         DO CASE 
            CASE nTecla==K_UP         ;oTb:up() 
            CASE nTecla==K_LEFT       ;oTb:PanLeft() 
            CASE nTecla==K_RIGHT      ;oTb:PanRight() 
            CASE nTecla==K_DOWN       ;oTb:down() 
            CASE nTecla==K_PGUP       ;oTb:pageup() 
            CASE nTecla==K_PGDN       ;oTb:pagedown() 
            CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
            CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
            CASE nTecla==K_ENTER .OR. nTecla==K_TAB 
 
               IF( EMPTY( cDescri ) == .T. ) 
                  IF( LEN( MPR->DESCRI ) < _ESP_DESCRICAO ) 
                     cDescri:= MPR->DESCRI + SPACE( _ESP_DESCRICAO - LEN( MPR->DESCRI ) ) 
                  ELSE 
                     cDescri:= MPR->DESCRI 
                  ENDIF 
               ENDIF 
 
               nQua := 0 
               IF !MPR->PCPCLA > 0 .AND. !MPR->PCPCSN == "S" 
                  // Quantidade direta quando produto nao tem tamanho e cor 
                  IF fRecQuaMPR( @nQua ) == .F. 
                     CLEAR TYPEAHEAD 
                     LOOP 
                  ENDIF 
//             ELSE 
//                PCPIniTam( @aProRel, @nRowProRel, nCodigo, 0, @nTamCod, "INI" ) 
               ENDIF 
 
               IF( PCL->( NetRLock() ) ) 
                  PCL->( DBAppend() ) 
                  PCL->CODIGO:= nCodigo 
                  PCL->CODPRO:= LEFT( MPR->INDICE, 7 ) 
                  PCL->QUAT00:= nQua 
               ENDIF 
 
               fProRel( @nCodigo, @aProRel, @nRowProRel, @nTamCod, @oTb2 ) 
               oTb2:gobottom() 
               oTb2:RefreshAll() 
               WHILE !oTb2:Stabilize() 
               ENDDO 
 
               lRet:= .T. 
 
            CASE DBPesquisa( nTecla, oTb ) 
            CASE nTecla==K_F2;    DBMudaOrdem( 1, oTb ) 
            CASE nTecla==K_F3;    DBMudaOrdem( 2, oTb ) 
            CASE nTecla==K_F4;    DBMudaOrdem( 3, oTb ) 
            CASE nTecla==K_F5;    DBMudaOrdem( 4, oTb ) 
            CASE nTecla==K_F6;    DBMudaOrdem( 5, oTb ) 
 
            OTHERWISE                 ;Tone( 125 ); Tone( 300 ) 
 
        ENDCASE 
 
        oTb:RefreshCurrent() 
        oTb:Stabilize() 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
      oTb2:RefreshAll() 
      WHILE !oTb2:Stabilize() 
      ENDDO 
 
   Return( lRet ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fProRel( nCodigo, aProRel, nRowProRel, nTamCod ) 
 
      Local lTem:= .F., cTem 
 
      aProRel:= 0 
      aProRel:= {} 
 
      MPR->( DBSetOrder( 1 ) ) 
      PCL->( DBSetOrder( 1 ) ) 
 
      IF( PCL->( DBSeek( nCodigo ) ) = .T. ) 
 
         WHILE( PCL->( EOF() ) = .F. .AND. PCL->CODIGO = nCodigo ) 
 
            cTem:= "   " 
            FOR nPos = 0 TO 20 
               cPos:= STRZERO( nPos, 2 ) 
               IF( PCL->QUAT&cPos > 0 ) 
                  cTem:= "Sim" 
                  nTamCod:= nPos 
                  EXIT 
               ENDIF 
            NEXT 
 
            IF( MPR->( DBSeek( PCL->CODPRO ) ) = .T. ) 
               AADD( aProRel, {MPR->INDICE,; 
                               MPR->CODFAB,; 
                               MPR->DESCRI,; 
                               cTem,; 
                               MPR->PCPCLA, ; 
                               MPR->PCPCSN, ; 
                               PCL->QUAT00} ) 
               lTem:= .T. 
            ENDIF 
            PCL->( DBSKIP() ) 
         ENDDO 
 
      ENDIF 
 
      IF( Len( aProRel ) <= 0 ) 
         AADD( aProRel, {Space( 12 ), Space( 13 ), Space( 40 ), Space( 4 ), 0, "N", 0} ) 
      ENDIF 
 
      nRowProRel:= 1 
 
   Return( lTem ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fIncProPed( nCodigo, cCodPed, cDescri, GetList ) 
 
      Local lTem:= .F., cCodPro, nQua 
 
      PED->( DBSetOrder( 1 ) ) 
      PXP->( DBSetOrder( 1 ) ) 
 
      IF( PED->( DBSeek( cCodPed ) ) = .T. ) 
 
         IF( PXP->( DBSeek( PED->CODIGO ) ) = .T. ) 
 
            While( PXP->( EOF() ) = .F. .AND. ; 
                   LEFT( PXP->CODIGO, 8 ) = LEFT( PED->CODIGO, 8 ) ) 
 
               cCodPro:= RIGHT( ALLTRIM( STRZERO( PXP->CODPRO ) ), 7 ) 
 
               // Quantidade direta quando produto nao tem tamanho e cor 
               nQua := 0 
               IF MPR->( DBSeek( cCodPro ) ) == .T. 
                  IF !MPR->PCPCLA > 0 .AND. !MPR->PCPCSN == "S" 
                      nQua := PXP->QUANT_ 
                  ENDIF 
               ENDIF 
 
               IF( PCL->( NetRLock() ) ) 
                  PCL->( DBAppend() ) 
                  PCL->CODIGO:= nCodigo 
                  PCL->CODPRO:= LEFT( cCodPro, 7 ) 
                  PCL->QUAT00:= nQua 
               ENDIF 
 
               lTem:= .T. 
 
               PXP->( DBSkip() ) 
 
            END 
 
         ENDIF 
 
      ENDIF 
 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
 
   Return( lTem ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fRecQua( aProRel, nProLin, nCodigo, nCorCod, nTamCod ) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ), nQuaAnt 
 
      VpBox( 7, 47, 10, 66, " Quantidade", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .F. ) 
 
      SetColor( _COR_GET_EDICAO ) 
 
      nQuaAnt:= aProRel [nProlin, 7] 
 
      @  9, 49 GET aProRel [nProlin, 7] PICT( "@E 99,999,999.999" ) ; 
         VALID fKeyboard( @nTecla ) 
      SetCursor( 1 ) 
      READ 
      SetCursor( nCursor ) 
 
      IF !nTecla == K_ESC .AND. aProRel [nProlin, 7] <> nQuaAnt 
         fGraPCL( @nCodigo, @aProRel, @nProLin ) 
         aProRel [nProLin, 4]:= "Sim" 
      ENDIF 
 
      IF( nTecla == 0 ) 
         nTecla:= K_TAB 
      ENDIF 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( .T. ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fGraPCL( nCodigo, aProRel, nProLin, nQua ) 
 
      nCodCor:= 0 
 
      PCL->( DBSetOrder( 2 ) ) 
 
      IF( PCL->( DBSeek( STR( nCodigo, 6 ) + aProRel [nProLin, 1] + ; 
          STR( nCodCor, 2 ) ) ) = .F. ) 
          PCL->( DBAppend() ) 
          PCL->CODIGO:= nCodigo 
          PCL->CODPRO:= aProRel [nProLin, 1] 
      ENDIF 
 
      IF( PCL->( NetRLock() ) ) 
 
         PCL->CODCOR:= nCodCor 
         PCL->QUAT00:= aProRel [nProLin, 7] 
 
      ENDIF 
//AQUI 
// *** ROTINA DE MOVIMENTACAO NO PCPESTOQ.DBF *** 
 
//    ACESSA PCPESTOQ.DBF 
//      SE EXISTE ACESSA CDMPRIMA.DBF 
//        SE EXISTE ATUALIZA LANCAMENTO COM A QUANTIDADE NOVA 
//        SE NAO EXISTE INCLUIR REGISTRO COM "+" E CODSET = 999 
/* 
      fAtuEstPCP( MPR->INDICE, MPR->CODRED, "+",  "", nCodigo, 0, ; 
                        0,   nQuant,  nRespons, dData,   nVlrIcm, nVlrIpi, ; 
                        nVlrFre,  nMovEst, nNatOpe,  nPerIcm, nClasse, nTamCod, ; 
                        nCorCod,  nTamQua, aCorTamQua ) 
*/ 
   Return( .T. ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fRecQuaMPR( nQua ) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ), nQuaAnt, lRet:= .T. 
 
      VpBox( 7, 47, 10, 66, " Quantidade", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .F. ) 
 
      SetColor( _COR_GET_EDICAO ) 
 
      @  9, 49 GET nQua PICT( "@E 99,999,999.999" ) ; 
         VALID fKeyboard( @nTecla ) 
      SetCursor( 1 ) 
      READ 
      SetCursor( nCursor ) 
 
      IF nTecla == K_ESC .OR. nQua == 0 
         lRet:= .F. 
      ENDIF 
 
      IF( nTecla == 0 ) 
         nTecla:= K_TAB 
      ENDIF 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( lRet ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func XProRel( nCodigo ) 
   Local cCor 
 
       cCor:= SetColor( _COR_BROW_BOX ) 
       Scroll( 06, 06, 11, 67 ) 
 
       SetColor( _COR_BROW_LETRA ) 
       @ 06, 05 SAY "Produto  C¢d.F brica   Descri‡„o do Produto" + ; 
                    "                        Sel" 
       nLin:= 6 
       IF PCL->( DBSeek( nCodigo ) ) 
          WHILE( PCL->( EOF() ) = .F. .AND. PCL->CODIGO == nCodigo ) 
             IF( MPR->( DBSeek( PCL->CODPRO ) ) = .T. ) 
                @ ++nLin,05 Say Tran( MPR->INDICE, "@R 999-9999" ) + ; 
                   " " + MPR->CODFAB + " " + Left( MPR->DESCRI, 43 ) 
                IF nLin >= 11 
                   EXIT 
                ENDIF 
             ENDIF 
             PCL->( DBSKIP() ) 
          ENDDO 
       ENDIF 
       SetColor( cCor ) 
 
   Return( Nil ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fVerifSitProd( nSit ) 
 
      Local cRet := "NAO INICIADA" 
 
      DO CASE 
         CASE( nSit > 0) 
            cRet := "EM ENDAMENTO" 
         CASE( nSit == 100) 
            cRet := "CONCLUIDA   " 
      ENDCASE 
 
   Return( cRet ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fExcItensProd( cProdut, nCodigo ) 
 
      Local nOrdem:= PCL->( IndexOrd() ) 
 
      PCL->( DBSetOrder( 3 ) ) // CODPRO + STR (CODIGO, 6) + STR (CODCOR, 2) 
 
      IF( PCL->( DBSeek( cProdut + Str( nCodigo, 6 ) ) ) = .T. ) 
         WHILE( PCL->( EOF() ) == .F. .AND. PCL->CODPRO == cProdut ; 
            .AND. PCL->CODIGO == nCodigo ) 
            PCL->( DBDelete() ) 
            PCL->( DBSKIP() ) 
         ENDDO 
      ENDIF 
 
      PCL->( DBSetOrder( nOrdem ) ) 
 
   Return( .T.) 
 
 
