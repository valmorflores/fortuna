// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC88300.PRG 
³ Finalidade  ³ Inclusao / Alteracao / Exclusao de tabela de CORES 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function vpc88300()
#endif

   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_CORES ) 
 
   /* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 04, 79,"TABELA DE CORES", _COR_GET_BOX, .F., .F. ) 
   VPBox( 05, 00, 22, 79," Display de Informa‡”es ", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
   /* Ajuste de mensagens */ 
   Mensagem("[INS]Incluir [ENTER]Alterar [DEL]Excluir ou [ESC]Finalizar") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
   SetColor( _COR_BROWSE ) 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseDB( 07, 01, 21, 78 ) 
   oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI + " " + SPACE( 44 ) })) 
 
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
       @ 03, 03 Say "Descri‡„o ... [" + DESCRI           + "]" 
 
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
          CASE nTecla==K_INS        ;CorIncluir( oTb ) 
          CASE nTecla==K_DEL        ;Exclui( oTb ) 
          CASE nTecla==K_ENTER      ;CorAlterar( oTb ) 
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
³ Funcao      ³ CorIncluir 
³ Finalidade  ³ Incluir itens na tabela de percentuais de CORES 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 05/Fevereiro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION CorIncluir( oTb ) 
 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   Local nCodigo:= 0, cDescri:= Space( 30 ) 
 
   DBSelectAr( _COD_CORES ) 
 
   WHILE ! LastKey() == K_ESC 
 
      dbGoBottom() 
      nCodigo:= CODIGO + 1 
      dbGoTop() 
      KeyBoard( CHR (K_ENTER) ) 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
      @ 02, 03 Say "C¢digo ......" Get nCodigo Pict "999" When; 
         MENSAGEM("Digite o C¢digo da COR") VALID !DBSeek( nCodigo ) 
      @ 03, 03 Say "Descri‡„o ..." Get cDescri When; 
         MENSAGEM("Digite a Descri‡„o da COR") 
      READ 
 
      IF DBSeek( nCodigo ) 
 
         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         Aviso( "Aten‡„o ! O C¢digo da COR j  est  cadastrado !", 12 ) 
         Pausa() 
         ScreenRest( cTelaRes ) 
 
      ELSEIF ! LastKey() == K_ESC 
 
          /* Gravacao de dados */ 
          IF Confirma( 0, 0, "Confirma ?", "Confirma a grava‡„o dos dados [S/N]?", "S" ) 
 
             DBAppend() 
             IF NetRLock() 
                Repl CODIGO With nCodigo,; 
                     DESCRI With cDESCRI 
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
³ Funcao      ³ CorAlterar 
³ Finalidade  ³ Alterar itens na tabela de percentuais de CORES 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 05/Fevereiro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION CorAlterar( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local nCodigo:= CODIGO, cDescri:= DESCRI 
 
   DBSelectAr( _COD_CORES ) 
 
   /* Display das informacoes */ 
   SetColor( _COR_GET_EDICAO ) 
   @ 03, 03 Say "Descri‡„o ..." Get cDescri When; 
      MENSAGEM("Digite a Descri‡„o da COR") 
   READ 
 
   IF DBSeek( nCodigo ) .AND. ! LastKey() == K_ESC 
 
          /* Gravacao de dados */ 
          IF Confirma( 0, 0, "Confirma ?", "Confirma a grava‡„o dos dados [S/N]?", "S" ) 
 
             IF NetRLock() 
                Repl CODIGO With nCodigo,; 
                     DESCRI With cDESCRI 
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
 
   Function ExiCores( nCor ) 
 
      LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla 
 
      DBSelectAr( _COD_CORES ) 
      DBSetOrder( 1 ) 
 
      IF !DBSeek( nCor, .T. ) 
         DBGoTop() 
      ENDIF 
 
      /* Ajuste da tela */ 
      VPBox( 03, 17, 15, 64,"TABELA DE CORES", _COR_BROWSE, .F., .F., ,.F. ) 
 
//                999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
 
      SetColor( _COR_BROWSE ) 
      @ 04, 18 SAY "C¢d Descri‡„o" 
      @ 05, 18 SAY REPL ("Ä", 3) + " " + REPL ("Ä", 42) 
 
      /* Ajuste de mensagens */ 
      Mensagem("[ENTER]Selecionar [0]Zerar Cor [ESC]Finalizar") 
      Ajuda("["+_SETAS+"][PgUp][PgDn]Move") 
 
      /* Inicializacao do objeto browse */ 
      oTb:=TBrowseDB( 06, 18, 14, 63 ) 
      oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI + SPACE (67) })) 
 
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
               nCor:= CODIGO 
               EXIT 
            CASE nTecla==ASC ("*") .OR. nTecla==ASC ("0") 
               nCor:= 0 
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
 
 
