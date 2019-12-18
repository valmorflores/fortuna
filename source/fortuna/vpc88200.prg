// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC88200.PRG 
³ Finalidade  ³ Inclusao / Alteracao / Exclusao de tabela de CLASSES 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function vpc88200()
#endif

   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_CLASSES ) 
 
   /* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 14, 79,"TABELA DE CLASSES", _COR_GET_BOX, .F., .F. ) 
   VPBox( 15, 00, 22, 79," Display de Informa‡”es ", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
   /* Ajuste de mensagens */ 
   Mensagem("[INS]Incluir [ENTER]Alterar [DEL]Excluir ou [ESC]Finalizar") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
   SetColor( _COR_BROWSE ) 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseDB( 17, 01, 21, 78 ) 
   oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI + SPACE( 65 ) })) 
   /* Variaveis do objeto browse */ 
   oTb:AutoLite:=.f. 
   oTb:dehilite() 
 
   WHILE .T. 
 
      /* Ajuste sa barra de selecao */ 
      oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
      WHILE NextKey()=0 .AND. !oTb:Stabilize() 
      ENDDO 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
      @ 02, 03 Say "C¢digo ...... [" + STR( CODIGO, 3 ) + "]" 
      @ 03, 03 Say "Descri‡„o ... [" + DESCRI + "]" 
 
      VPBox( 05, 06, 13, 73," Tamanhos ", _COR_GET_BOX, .F., .F., ,.F. ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 06,  9 SAY "Cd   Tamanho    Cd   Tamanho    Cd   Tamanho    Cd   Tamanho" 
      @ 07,  9 SAY "ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ" 
 
      x:= 0 
      FOR K = 1 TO 4 
         FOR J = 1 TO 5 
            x ++ 
            y:= STRZERO( x, 2 ) 
            @ 07 + J, 09 + K * 16 - 16 Say STR (x, 2) + "- " + TAMA&y 
         NEXT J 
      NEXT K 
 
      nTecla:=inkey(0) 
      IF nTecla=K_ESC 
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
         CASE nTecla==K_INS        ;ClaIncluir( oTb ) 
         CASE nTecla==K_DEL        ;Exclui( oTb ) 
         CASE nTecla==K_ENTER      ;ClaAlterar( oTb ) 
         OTHERWISE                 ;Tone(125); Tone(300) 
      ENDCASE 
 
      oTb:RefreshCurrent() 
      oTb:Stabilize() 
 
   ENDDO 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ClaIncluir 
³ Finalidade  ³ Incluir itens na tabela de percentuais de CLASSES 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 05/Fevereiro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION ClaIncluir( oTb ) 
 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   Local nCodigo:= 0, cDescri:= Space( 40 ), nCodAux:= 0 
 
   aTam:= {} 
   FOR J = 1 TO 20 
      AADD( aTam, SPAC( 10 ) ) 
   NEXT J 
 
   DBSelectAr( _COD_CLASSES ) 
 
   WHILE ! LastKey() == K_ESC 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
 
      dbGoBottom() 
      nCodigo:= CODIGO + 1 
      dbGoTop() 
      KeyBoard( CHR (K_ENTER) ) 
 
      @ 02, 03 Say "C¢digo ......" Get nCodigo Pict "999" When; 
        MENSAGEM("Digite o C¢digo da CLASSES") VALID !DBSeek( nCodigo ) 
      @ 03, 03 Say "Descri‡„o ..." Get cDescri  When; 
        MENSAGEM("Digite a Descri‡„o da CLASSES") 
 
      VPBox( 05, 06, 13, 73," Tamanhos ", _COR_GET_BOX, .F., .F., ,.F. ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 06,  9 SAY "Cd   Tamanho    Cd   Tamanho    Cd   Tamanho    Cd   Tamanho" 
      @ 07,  9 SAY "ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ" 
 
      SET DELIMITERS OFF 
      x:= 0 
      FOR K = 1 TO 4 
         FOR J = 1 TO 5 
            x ++ 
            y:= STRZERO( x, 2 ) 
            @ 07 + J, 09 + K * 16 - 16 SAY STR (x, 2) + "-" GET aTam[ x ] When; 
               MENSAGEM("Digite o TAMANHO") 
         NEXT J 
      NEXT K 
 
      READ 
      SET DELIMITERS ON 
 
      IF DBSeek( nCodigo ) 
 
         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         Aviso( "Aten‡„o ! O C¢digo da CLASSES j  est  cadastrado !", 12 ) 
         Pausa() 
         ScreenRest( cTelaRes ) 
 
      ELSEIF ! LastKey() == K_ESC 
 
          /* Gravacao de dados */ 
          IF Confirma( 0, 0, "Confirma ?", "Confirma a grava‡„o dos dados [S/N]?", "S" ) 
 
             DBAppend() 
             IF NetRLock() 
                  Repl CODIGO With nCodigo,; 
                       DESCRI With cDESCRI,; 
                       CODAUX With nCodAux 
                  FOR J = 1 TO 20 
                     y:= STRZERO( J, 2 ) 
                     Repl TAMA&y With aTam[ J ] 
                  NEXT J 
             ENDIF 
 
             Exit 
 
          ENDIF 
 
      ENDIF 
 
   ENDDO 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
 
   /* Refaz o Browse */ 
   oTb:RefreshAll() 
   WHILE !oTb:Stabilize() 
   ENDDO 
 
   Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ClaAlterar 
³ Finalidade  ³ Alterar itens na tabela de percentuais de CLASSES 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 05/Fevereiro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
   FUNCTION ClaAlterar( oTb ) 
 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
      Local nCodigo:= CODIGO, cDescri:= DESCRI, nCodAux:= 0 
 
      aTam:= {} 
      FOR J = 1 TO 20 
         y:= STRZERO( J, 2 ) 
         AADD( aTam, TAMA&y ) 
      NEXT J 
 
      DBSelectAr( _COD_CLASSES ) 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
 
      @ 03, 03 Say "Descri‡„o ..." Get cDescri  When; 
        MENSAGEM("Digite a Descri‡„o da CLASSES") 
 
      VPBox( 05, 06, 13, 73," Tamanhos ", _COR_GET_BOX, .F., .F., ,.F. ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 06,  9 SAY "Cd   Tamanho    Cd   Tamanho    Cd   Tamanho    Cd   Tamanho" 
      @ 07,  9 SAY "ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ" 
 
      SET DELIMITERS OFF 
      x:= 0 
      FOR K = 1 TO 4 
         FOR J = 1 TO 5 
            x ++ 
            y:= STRZERO( x, 2 ) 
            @ 07 + J, 09 + K * 16 - 16 SAY STR (x, 2) + "-" GET aTam [x] When; 
               MENSAGEM("Digite o TAMANHO") 
         NEXT J 
      NEXT K 
 
      READ 
      SET DELIMITERS ON 
 
      IF DBSeek( nCodigo ) .AND. ! LastKey() == K_ESC 
 
             /* Gravacao de dados */ 
             IF Confirma( 0, 0, "Confirma ?", "Confirma a grava‡„o dos dados [S/N]?", "S" ) 
 
                IF NetRLock() 
                  Repl CODIGO With nCodigo,; 
                       DESCRI With cDESCRI,; 
                       CODAUX With nCodAux 
                  FOR J = 1 TO 20 
                     y:= STRZERO( J, 2 ) 
                     Repl TAMA&y With aTam[ J ] 
                  NEXT J 
                ENDIF 
 
             ENDIF 
 
      ENDIF 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
      /* Refaz o Browse */ 
      oTb:RefreshAll() 
      WHILE !oTb:Stabilize() 
      ENDDO 
 
   Return Nil 
 
//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function ExiClasse( nCla ) 
 
      LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla 
 
      DBSelectAr( _COD_CLASSES ) 
      DBSetOrder( 1 ) 
 
      IF !DBSeek( nCla, .T. ) 
         DBGoTop() 
      ENDIF 
 
      /* Ajuste da tela */ 
      VPBox( 03, 03, 15, 76,"TABELA DE CLASSES", _COR_BROWSE ) 
 
      SetColor( _COR_BROWSE ) 
      @ 04, 04 SAY "C¢d Descri‡„o                               Tamanhos" 
      @ 05, 04 SAY REPL ("Ä", 3) + " " + REPL ("Ä", 39) + " " + REPL ("Ä", 28) 
 
      /* Ajuste de mensagens */ 
      Mensagem("[ENTER]Selecionar [0]Zerar Classe [ESC]Finalizar") 
      Ajuda("["+_SETAS+"][PgUp][PgDn]Move") 
 
      /* Inicializacao do objeto browse */ 
      oTb:=TBrowseDB( 06, 04, 14, 75 ) 
      oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI + ; 
         LEFT (ALLTRIM ( TAMA01 ) + " " + ALLTRIM ( TAMA02 ) + " " + ; 
               ALLTRIM ( TAMA03 ) + " " + ALLTRIM ( TAMA04 ) + " " + ; 
               ALLTRIM ( TAMA05 ) + " " + ALLTRIM ( TAMA06 ) + " " + ; 
               ALLTRIM ( TAMA07 ) + " " + ALLTRIM ( TAMA08 ) + " " + ; 
               ALLTRIM ( TAMA09 ) + " " + ALLTRIM ( TAMA10 ) + " " + ; 
               ALLTRIM ( TAMA11 ) + " " + ALLTRIM ( TAMA12 ) + " " + ; 
               ALLTRIM ( TAMA13 ) + " " + ALLTRIM ( TAMA14 ) + " " + ; 
               ALLTRIM ( TAMA15 ) + " " + ALLTRIM ( TAMA16 ) + " " + ; 
               ALLTRIM ( TAMA17 ) + " " + ALLTRIM ( TAMA18 ) + " " + ; 
               ALLTRIM ( TAMA19 ) + " " + ALLTRIM ( TAMA20 ), 23) + ; 
               IF ( !EMPTY( TAMA09 ), " ...", "     " )})) 
 
      /* Variaveis do objeto browse */ 
      oTb:AutoLite:=.f. 
      oTb:dehilite() 
 
      WHILE .T. 
 
         /* Ajuste sa barra de selecao */ 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         SetColor( _COR_GET_BOX ) 
         nTecla:=inkey(0) 
         IF nTecla=K_ESC 
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
            CASE nTecla==K_ENTER 
               nCla:= CODIGO 
               EXIT 
            CASE nTecla == ASC( "*" ) .OR. nTecla == ASC( "0" ) 
               nCla:= 0 
               EXIT 
            OTHERWISE                 ;Tone(125); Tone(300) 
         ENDCASE 
 
         oTb:RefreshCurrent() 
         oTb:Stabilize() 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return Nil 
 
//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function ExiTamanhos( nCla, nTam ) 
 
      LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla, aTam 
 
      DBSelectAr( _COD_CLASSES ) 
      DBSetOrder( 1 ) 
 
      IF !DBSeek( nCla, .T. ) 
         DBGoTop() 
      ENDIF 
 
      /* Ajuste da tela */ 
      VPBox( 05, 06, 13, 73," Tamanhos ", _COR_GET_BOX, .F., .F., ,.F. ) 
      VPBox( 15, 35, 18, 45," C¢digo ", _COR_GET_BOX, .F., .F., ,.F. ) 
 
      VPBox( 05, 06, 13, 73," Tamanhos ", _COR_GET_BOX, .F., .F., ,.F. ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 06,  9 SAY "Cd   Tamanho    Cd   Tamanho    Cd   Tamanho    Cd   Tamanho" 
      @ 07,  9 SAY "ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ" 
 
      SetColor( _COR_GET_EDICAO ) 
      aTam:= {} 
      FOR J = 1 TO 20 
         y:= STRZERO( J, 2 ) 
         AADD( aTam, TAMA&y ) 
      NEXT J 
 
      x:= 0 
      FOR K = 1 TO 4 
         FOR J = 1 TO 5 
            x ++ 
            y:= STRZERO( x, 2 ) 
            @ 07 + J, 09 + K * 16 - 16 Say STR (x, 2) + "- " + TAMA&y 
         NEXT J 
      NEXT K 
 
      /* Ajuste de mensagens */ 
      Mensagem("Digite o c¢digo do tamanho") 
      Ajuda("["+_SETAS+"][PgUp][PgDn]Move[ESC]Finalizar") 
 
      SET DELIMITERS OFF 
 
      WHILE (.T.) 
 
         SetColor( _COR_GET_EDICAO ) 
         @ 17, 39 GET nTam 
         READ 
 
         IF Lastkey() == K_ESC .OR. nTam == 0 
            EXIT 
         ENDIF 
 
         IF nTam < 21 
            y:= STRZERO( nTam, 2 ) 
            IF !EMPTY( TAMA&y ) 
               EXIT 
            ENDIF 
         ENDIF 
 
      END 
 
      SET DELIMITERS ON 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return nTam 
 
/* 
ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
  C¢digo ...... [999] 
  Descri‡„o ... [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX] 
 
  Tamanhos .... : 
 
     [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] 
     [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] 
     [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] 
     [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] [XXXXXXXXXX] 
 
  1[XXXXXXXXXX]  5[XXXXXXXXXX]  9[XXXXXXXXXX] 13[XXXXXXXXXX] 17[XXXXXXXXXX] 
  2[XXXXXXXXXX]  6[XXXXXXXXXX] 10[XXXXXXXXXX] 14[XXXXXXXXXX] 18[XXXXXXXXXX] 
  3[XXXXXXXXXX]  7[XXXXXXXXXX] 11[XXXXXXXXXX] 15[XXXXXXXXXX] 19[XXXXXXXXXX] 
  4[XXXXXXXXXX]  8[XXXXXXXXXX] 12[XXXXXXXXXX] 16[XXXXXXXXXX] 20[XXXXXXXXXX] 
 
      1=[XXXXXXXXXX]  6=[XXXXXXXXXX] 11=[XXXXXXXXXX] 16=[XXXXXXXXXX] 
      2=[XXXXXXXXXX]  7=[XXXXXXXXXX] 12=[XXXXXXXXXX] 17=[XXXXXXXXXX] 
      3=[XXXXXXXXXX]  8=[XXXXXXXXXX] 13=[XXXXXXXXXX] 18=[XXXXXXXXXX] 
      4=[XXXXXXXXXX]  9=[XXXXXXXXXX] 14=[XXXXXXXXXX] 19=[XXXXXXXXXX] 
      5=[XXXXXXXXXX] 10=[XXXXXXXXXX] 15=[XXXXXXXXXX] 20=[XXXXXXXXXX] 
 
          1=XXXXXXXXXX  6=XXXXXXXXXX 11=XXXXXXXXXX 16=XXXXXXXXXX 
          2=XXXXXXXXXX  7=XXXXXXXXXX 12=XXXXXXXXXX 17=XXXXXXXXXX 
          3=XXXXXXXXXX  8=XXXXXXXXXX 13=XXXXXXXXXX 18=XXXXXXXXXX 
          4=XXXXXXXXXX  9=XXXXXXXXXX 14=XXXXXXXXXX 19=XXXXXXXXXX 
          5=XXXXXXXXXX 10=XXXXXXXXXX 15=XXXXXXXXXX 20=XXXXXXXXXX 
 
   1=XXXXXXXXXX  5=XXXXXXXXXX  9=XXXXXXXXXX 13=XXXXXXXXXX 17=XXXXXXXXXX 
   2=XXXXXXXXXX  6=XXXXXXXXXX 10=XXXXXXXXXX 14=XXXXXXXXXX 18=XXXXXXXXXX 
   3=XXXXXXXXXX  7=XXXXXXXXXX 11=XXXXXXXXXX 15=XXXXXXXXXX 19=XXXXXXXXXX 
   4=XXXXXXXXXX  8=XXXXXXXXXX 12=XXXXXXXXXX 16=XXXXXXXXXX 20=XXXXXXXXXX 
 
        1-XXXXXXXXXX  6-XXXXXXXXXX 11-XXXXXXXXXX 16-XXXXXXXXXX 
     Cd   Tamanho    Cd   Tamanho    Cd   Tamanho    Cd   Tamanho 
     ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ ÄÄ   ÄÄÄÄÄÄÄÄÄÄ 
      1- XXXXXXXXXX  6- XXXXXXXXXX 11- XXXXXXXXXX 16- XXXXXXXXXX 
      1- XXXXXXXXXX  6- XXXXXXXXXX 11- XXXXXXXXXX 16- XXXXXXXXXX 
 
  Auxiliar .... [999] 
*/ 
 
