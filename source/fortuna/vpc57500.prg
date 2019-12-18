// ## CL2HB.EXE - Converted
 
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
Function PesqAtd() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      cCor:= SetColor(), nCursor:= SetCursor() 
Local dData1:= DATE(), dData2:= DATE(), cAtend_:= Space( 30 ), nSetor1:= 0,; 
      nSetor2:= 999, nCFE___:= 999999 
Local dDataFim1:= DATE(), dDataFim2:= DATE() 
Local aNStatus:= {} 
Local nTotalAtend:= 0 
Local oTb, nTecla 
Local nOrdem_:= 1 
Local bValidate:= {|| .T. } 
Priv nStatus:= 9, nCobran:= 9 
Priv aStatus:= StatusOcorrencia( 1, "GET" ) 
Priv cOrdem_:= "CODIGO" 
 
   FOR nCt:= 1 TO Len( aStatus ) 
      AAdd( aNStatus, 0 ) 
   NEXT 
 
   nStatus:= 9 
   nCobran:= 9 
   WHILE .T. 
 
      VPBox( 09, 13, 21, 70, "Relacao de Atendimentos Por Periodo/Setor", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 11,15 Say "Periodo de..:" Get dData1 
      @ 11,45 Say "Ate:" Get dData2 
      @ 12,15 Say "Concluido de:" Get dDataFim1 
      @ 12,45 Say "Ate:" Get dDataFim2 
      @ 13,15 Say "Atendente...:" Get cAtend_ 
      @ 14,15 Say "Setor.......:" Get nSetor1 Pict "999" 
      @ 15,15 Say "Ate.........:" Get nSetor2 Pict "999" 
      @ 16,15 Say "Cli/For/Emp.:" Get nCFE___ Pict "999999" 
      @ 17,15 Say "Ordem.......:" Get nOrdem_ Pict "9" Valid TabOrdem( @nOrdem_, @cOrdem_ ) 
      @ 18,15 Say "Status......:" Get nStatus Pict "9" 
      @ 19,15 Say "Cobranca....:" Get nCobran Pict "9" 
      READ 
      IF LastKey()==K_ESC 
         EXIT 
      ENDIF 
 
      /* Criterios de Validacao STATUS/COBRAN */ 
      IF nCobran<>9 .AND. nStatus==9 
         bValidate:= {|| COBRAN==nCobran } 
      ELSEIF nCobran==9 .AND. nStatus<>9 
         bValidate:= {|| STATUS==nStatus } 
      ELSEIF nCobran<>9 .AND. nStatus<>9 
         bValidate:= {|| STATUS==nStatus .AND. COBRAN==nCobran } 
      ENDIF 
 
      SET->( DBSetOrder( 1 ) ) 
      CLI->( DBSetOrder( 1 ) ) 
      FOR->( DBSetOrder( 1 ) ) 
 
      DBSelectAr( _COD_ATEND ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON &cOrdem_ TO INR203 FOR EVAL( bValidate ) .AND. DATAEM >= dData1 .AND. DATAEM <= dData2 .AND.; 
                          ALLTRIM( DESCRI )<>"<< RESERVADO >>" .AND.; 
                          DATFIM >= dDataFim1 .AND. DATFIM <= dDataFim2 .AND.; 
                          IIF( EMPTY( cAtend_ ), .T., ATEND_==cAtend_ ) .AND.; 
                          SETOR_ >= nSetor1 .AND. SETOR_ <= nSetor2 .AND.; 
                          IIF( nCFE___<>999999, VAL( SubStr( CODCFE, 2 ) )==nCFE___, .t. ) EVAL {|| Processo() } 
      DBGoTop() 
      SetColor( "15/00,15/01" ) 
      VPBox( 0, 0, 22, 79, "RELACAO DE ATENDIMENTOS", "15/00" ) 
      Mensagem( "[TAB]Imprime Relacao [ESC]Sair [A..Z]Pesquisa [" + _SETAS + "]Move" ) 
 
      oTb:= TBrowseDb( 01, 01, 18, 78 ) 
      oTb:AddColumn( tbcolumnnew( ,{|| STRZERO( CODIGO, 08, 00 ) + " " + ; 
                           DESCRI + " " + DTOC( DATAEM ) + " " +; 
                           IIF( STATUS > 0, aStatus[ STATUS ], Space( Len( aStatus[ 1 ] ) ) ) + " " + ; 
                           ATEND_ })) 
 
      /* Variaveis do objeto browse */ 
      oTb:AutoLite:=.f. 
      oTb:dehilite() 
 
      WHILE .T. 
 
         /* Ajuste sa barra de selecao */ 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         DispBegin() 
         SET->( DBSeek( ATD->SETOR_ ) ) 
         SetColor( "00/03" ) 
         Scroll( 19, 01, 21, 78 ) 
         @ 19,01 Say "Setor: " + SET->DESCRI + "     Atendente: " + left( ATEND_, 13 ) Color "00/03" 
         @ 20,01 Say Space( 52 ) + "Data Emissao..: " + DTOC( DATAEM ) Color "00/03" 
         @ 21,01 Say Space( 52 ) + "Data Previsao.: " + DTOC( DATFIM ) Color "00/03" 
 
         /* Exibe Informacao cfe. cadastro */ 
         IF Left( CODCFE, 1 )=="C" 
            CLI->( DBSeek( VAL( SubStr( ATD->CODCFE, 2 ) ) ) ) 
            @ 20,01 Say "C/F/E: " + CLI->DESCRI Color "00/03" 
            @ 21,01 Say "Fone.: " + CLI->FONE1_ Color "00/03" 
         ELSEIF Left( CODCFE, 1 )=="F" 
            FOR->( DBSeek( VAL( SubStr( ATD->CODCFE, 2 ) ) ) ) 
            @ 20,01 Say "C/F/E: " + FOR->DESCRI Color "00/03" 
            @ 21,01 Say "Fone.: " + FOR->FONE1_ Color "00/03" 
         ELSEIF Left( CODCFE, 1 )=="E" 
            //FOR->( DBSeek( VAL( SubStr( ATD->CODCFE, 2 ) ) ) ) 
            //@ 20,01 Say FOR->DESCRI 
         ENDIF 
         SetColor( "15/00,15/01" ) 
 
         DispEnd() 
 
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
            CASE DBPesquisa( nTecla, oTb ) 
            CASE nTecla==K_TAB 
                 IF Confirma( 0, 0, "Confirma a impressao da relacao?", "S", "S" ) 
                    nReg:= RECNO() 
                    Relatorio( "ATDREL.REP" ) 
                    DBGoTo( nReg ) 
                 ENDIF 
            CASE nTecla==K_F2 
                 DBMudaOrdem( 1, oTb ) 
            CASE nTecla==K_F3 
                 DBMudaOrdem( 2, oTb ) 
            CASE nTecla==K_F4 
                 DBMudaOrdem( 3, oTb ) 
            CASE DBPesquisa( nTecla, oTb ) 
            OTHERWISE                 ;Tone(125); Tone(300) 
        ENDCASE 
 
        oTb:RefreshCurrent() 
        oTb:Stabilize() 
 
      ENDDO 
      ScreenRest( cTela ) 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   DBSelectAr( _COD_ATEND ) 
   DBCloseArea() 
   IF !FDBUseVpb( _COD_ATEND, 2 ) 
      Aviso( "Falha na abertura do arquivo..." ) 
      Pausa() 
   ENDIF 
   Return Nil 
 
 
 
* PESQATDESTATISTICA =====================********* 
Function PesqAtdEstatistica() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      cCor:= SetColor(), nCursor:= SetCursor() 
Local dData1:= DATE(), dData2:= DATE(), cAtend_:= Space( 30 ), nSetor1:= 0,; 
      nSetor2:= 999, nCFE___:= 999999 
Local aStatus:= StatusOcorrencia( 1, "GET" ) 
Local aNStatus:= {} 
Local nTotalAtend:= 0 
Local nOrdem_:= 1 
Priv  cOrdem_ 
 
   FOR nCt:= 1 TO Len( aStatus ) 
      AAdd( aNStatus, 0 ) 
   NEXT 
 
   WHILE .T. 
 
      VPBox( 11, 13, 21, 70, "Estatistica de Atendimento Por Situacao", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 13,15 Say "Periodo de.:" Get dData1 
      @ 14,15 Say "Ate........:" Get dData2 
      @ 15,15 Say "Atendente..:" Get cAtend_ 
      @ 16,15 Say "Setor......:" Get nSetor1 Pict "999" 
      @ 17,15 Say "Ate........:" Get nSetor2 Pict "999" 
      @ 18,15 Say "Cli/For/Emp:" Get nCFE___ Pict "999999" 
      @ 19,15 Say "Ordem......: [Automatica]" 
      READ 
      nOrdem_:= 1 
      cOrdem_:= "CODIGO" 
      IF LastKey()==K_ESC 
         EXIT 
      ENDIF 
      DBSelectAr( _COD_ATEND ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON &cOrdem_ TO INR203 FOR DATAEM >= dData1 .AND. DATAEM <= dData2 .AND.; 
                          IIF( EMPTY( cAtend_ ), .T., ATEND_==cAtend_ ) .AND.; 
                          SETOR_ >= nSetor1 .AND. SETOR_ <= nSetor2 .AND.; 
                          IIF( nCFE___<>999999, VAL( SubStr( CODCFE, 2 ) )==nCFE___, .t. ) EVAL {|| Processo() } 
 
      /* Zera contador por Status */ 
      FOR nCt:= 1 TO Len( aNStatus ) 
          aNStatus[ nCt ]:= 0 
      NEXT 
 
      DBGoTop() 
      WHILE !EOF() 
         IF !STATUS==0 
            aNStatus[ STATUS ]:= aNStatus[ STATUS ] + 1 
         ENDIF 
         DBSkip() 
      ENDDO 
      VPBox( 0, 0, 22, 79, "ESTATISTICA DE ATENDIMENTO", "15/00" ) 
      Mensagem( "Pressione [ENTER] para visualizar grafico comparativo." ) 
      nTotalAtend:= 0 
      nLin:= 0 
      FOR nCt:= 1 TO Len( aStatus ) 
          @ nLin+=2,02 Say "  " Color "15/" + StrZero( nCt, 2, 0 ) 
          @ nLin,06 Say aStatus[ nCt ] 
          @ nLin,31 Say aNStatus[ nCt ] 
          nTotalAtend:= nTotalAtend + aNStatus[ nCt ] 
      NEXT 
      Pausa() 
      SetColor( "15/00" ) 
      VPBox( 1, 30, 22, 79, "GRAFICO", "15/00" ) 
 
      /* Pega o percentual de representacao do maior movimento */ 
      nPercMaior:= 0 
      FOR nCt:= 1 TO Len( aNStatus ) 
          IF ( ( aNStatus[ nCt ] / nTotalAtend ) * 100 ) > nPercMaior 
             nPercMaior:= ( ( aNStatus[ nCt ] / nTotalAtend ) * 100 ) 
          ENDIF 
      NEXT 
 
      nPercLinha:= nPercMaior / 17    /* Quanto representa cada linha, 
                                         basenando-se no % maior e considerando 
                                         que na tela caberiam 17 linhas */ 
      nPos:= 0                        /* Contador da Posicao da Barra em linha, 1a. 2a. ... */ 
      FOR nLinha:= 20 TO 3 Step -1    /* navega da linha 20 ate a linha 3 === 17 linhas */ 
          nColuna:= 30                /* Posiciona na 1a. coluna */ 
          nPos:= nPos + 1 
          FOR nCt:= 1 TO Len( aNStatus ) 
              nColuna:= nColuna + 5   /* navega pelas colunas de 5 em 5 */ 
              IF aNStatus[ nCt ] == 0 
                 @ 20, nColuna Say "___" Color StrZero( nCt, 2, 0 ) + "/00" 
              ELSE 
                 IF ( ( aNStatus[ nCt ] / nTotalAtend ) * 100 ) >= ( nPos * nPercLinha ) 
                    @ nLinha, nColuna Say "Û²°" Color StrZero( nCt, 2, 0 ) + "/15" 
                 ENDIF 
              ENDIF 
          NEXT 
      NEXT 
      Mensagem( "Pressione [ENTER] para sair." ) 
      Pausa() 
 
      ScreenRest( cTela ) 
 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   Return Nil 
 
 
Static Function TabOrdem( nOrdem_, cOrdem_ ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aOrdem_:= { "CODIGO", "DESCRI", "DATAEM", "ATEND_" } 
Local nOpcao:= nOrdem_ 
 
      VPBox( 15, 39, 20, 59, "Ordem" ) 
      @ 16,40 Prompt " 1 Codigo         " 
      @ 17,40 Prompt " 2 Descricao      " 
      @ 18,40 Prompt " 3 Emissao        " 
      @ 19,40 Prompt " 4 Atendente      " 
      Menu To nOpcao 
      IF nOpcao > 0 
         nOrdem_:= nOpcao 
         cOrdem_:= aOrdem_[ nOrdem_ ] 
      ENDIF 
 
      ScreenRest( cTela ) 
      Return .T. 
 
 
