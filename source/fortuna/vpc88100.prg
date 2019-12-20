// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC88100.PRG 
� Finalidade  � Inclusao / Alteracao / Exclusao de tabela de SETORES 
� Parametros  � Nil 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 

#ifdef HARBOUR
function vpc88100()
#endif

   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_SETORES ) 
 
   /* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 08, 79,"TABELA DE SETORES", _COR_GET_BOX, .F., .F. ) 
   VPBox( 09, 00, 22, 79," Display de Informa��es ", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
   /* Ajuste de mensagens */ 
   Mensagem("[INS]Incluir [ENTER]Alterar [DEL]Excluir ou [ESC]Finalizar") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
   SetColor( _COR_BROWSE ) 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseDB( 11, 01, 21, 78 ) 
   oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI + " " + LEFT( OBSERV, 33 ) })) 
 
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
      @ 02, 03 Say "C�digo ........ [" + STR( CODIGO, 3 ) + "]" 
      @ 03, 03 Say "Descri��o ..... [" + DESCRI           + "]" 
      @ 04, 03 Say "Observa��es ... [" + OBSERV           + "]" 
      @ 05, 03 Say "Fornecedor .... [" + STR( CODFOR, 4 ) + "]     Buscar: ["  + BSCFOR + "]" 
      @ 06, 03 Say "Cliente ....... [" + STR( CODCLI, 6 ) + "]   Buscar: ["    + BSCCLI + "]" 
      @ 07, 03 Say "Empresa ....... [" + STR( CODEMP, 3 ) + "]      Buscar: [" + BSCEMP + "]" 
 
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
         CASE nTecla==K_INS        ;SetIncluir( oTb ) 
         CASE nTecla==K_DEL        ;Exclui( oTb ) 
         CASE nTecla==K_ENTER      ;SetAlterar( oTb ) 
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
�������������Ŀ 
� Funcao      � SetIncluir 
� Finalidade  � Incluir itens na tabela de percentuais de SETORES 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 05/Fevereiro/1998 
��������������� 
*/ 
FUNCTION SetIncluir( oTb ) 
 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   Local nCodigo:= 0, cDescri:= Space( 40 ), nCodEmp:= 0, nCodFor:= 0, ; 
         nCodCli:= 0, cObserv:= Space( 55 ), cBscCli:= "N", cBscFOR:= "N", cBscEmp:= "N" 
 
   Local nTipTab:= 0 
   DBSelectAr( _COD_SETORES ) 
 
   WHILE ! LastKey() == K_ESC 
 
      dbGoBottom() 
      nCodigo:= CODIGO + 1 
      dbGoTop() 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
      @ 02, 03 Say "C�digo ........" Get nCodigo Pict "999" When; 
         MENSAGEM("Digite o C�digo do SETOR") VALID !DBSeek( nCodigo ) 
      @ 03, 03 Say "Descri��o ....." Get cDescri When; 
         MENSAGEM("Digite a Descri��o do SETOR") ; 
         VALID LastKey()==K_UP .OR. VerForCli( @cDescri, @nCodFor, @nCodCli, GetList  ) 
      @ 04, 03 Say "Observa��es ..." Get cObserv When; 
         MENSAGEM("Digite as Observa��es do SETOR") 
      @ 05, 03 Say "Fornecedor ...." Get nCodFor Pict "9999" When; 
         MENSAGEM("Digite o C�digo do FORNECEDOR relacionado ao SETOR") 
      @ 05, 30 Say "Buscar:" Get cBscFor when nCodFor==0 valid cBscFor$'NS' pict '!' 
      @ 06, 03 Say "Cliente ......." Get nCodCli Pict "999999" When; 
         MENSAGEM("Digite o C�digo do CLIENTE relacionado ao SETOR") 
      @ 06, 30 Say "Buscar:" Get cBscCli when nCodCli==0 valid cBscCli$'NS' pict '!' 
      @ 07, 03 Say "Empresa ......." Get nCodEmp  Pict "999" When; 
         MENSAGEM("Digite o C�digo da EMPRESA relacionada ao SETOR") 
      @ 07, 30 Say "Buscar:" Get cBscEmp when nCodEmp==0 valid cBscEmp$'NS' pict '!' 
      READ 
 
      TabAtendimento( @nTipTab ) 
      IF DBSeek( nCodigo ) 
         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         Aviso( "Aten��o! O C�digo do SETOR j� est� cadastrado!", 12 ) 
         Pausa() 
         ScreenRest( cTelaRes ) 
 
      ELSEIF ! LastKey() == K_ESC 
 
          /* Gravacao de dados */ 
          IF Confirma( 0, 0, "Confirma ?", "Confirma a grava��o dos dados [S/N]?", "S" ) 
 
             DBAppend() 
             IF netrlock() 
                Repl CODIGO With nCodigo,; 
                     DESCRI With cDESCRI,; 
                     OBSERV With cObserv,; 
                     CODFOR With nCodFor,; 
                     CODCLI With nCodCli,; 
                     CODEMP With nCodEmp,; 
                     BSCCli With cBscCli,; 
                     BSCFor With cBscFor,; 
                     BSCEmp With cBscEmp,; 
                     TIPTab With nTipTab 
 
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
�������������Ŀ 
� Funcao      � SetAlterar 
� Finalidade  � Alterar itens na tabela de percentuais de SETORES 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 05/Fevereiro/1998 
��������������� 
*/ 
FUNCTION SetAlterar( oTb ) 
 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   Local nTipTab:= TIPTAB 
   Local nCodigo:= CODIGO, cDescri:= DESCRI, nCodEmp:= CODEMP, ; 
         nCodFor:= CODFOR, nCodCli:= CODCLI, cObserv:= OBSERV,; 
         cBscCli:= BSCCLI, cBscFor:= BSCFOR, cBscEmp:= BSCEMP 
 
   DBSelectAr( _COD_SETORES ) 
 
   /* Display das informacoes */ 
   SetColor( _COR_GET_EDICAO ) 
   @ 03, 03 Say "Descri��o ....." Get cDescri When; 
      MENSAGEM("Digite a Descri��o do SETOR") ; 
      VALID VerForCli( @cDescri, @nCodFor, @nCodCli, GetList  ) 
   @ 04, 03 Say "Observa��es ..." Get cObserv When; 
      MENSAGEM("Digite as Observa��es do SETOR") 
   @ 05, 03 Say "Fornecedor ...." Get nCodFor Pict "9999" When; 
      MENSAGEM("Digite o C�digo do FORNECEDOR relacionado ao SETOR") 
   @ 05, 30 Say "Buscar:" Get cBscFor when nCodFor==0 
   @ 06, 03 Say "Cliente ......." Get nCodCli Pict "999999" When; 
      MENSAGEM("Digite o C�digo do CLIENTE relacionado ao SETOR") 
   @ 06, 30 Say "Buscar:" Get cBscCli when nCodCli==0 
   @ 07, 03 Say "Empresa ......." Get nCodEmp  Pict "999" When; 
      MENSAGEM("Digite o C�digo da EMPRESA relacionada ao SETOR") 
   @ 07, 30 Say "Buscar:" Get cBscEmp when nCodEmp==0 
   READ 
 
   TabAtendimento( @nTipTab ) 
 
   IF DBSeek( nCodigo ) .AND. ! LastKey() == K_ESC 
 
          /* Gravacao de dados */ 
          IF Confirma( 0, 0, "Confirma ?", "Confirma a grava��o dos dados [S/N]?", "S" ) 
 
             IF netrlock() 
                Repl CODIGO With nCodigo,; 
                     DESCRI With cDESCRI,; 
                     OBSERV With cObserv,; 
                     CODFOR With nCodFor,; 
                     CODCLI With nCodCli,; 
                     CODEMP With nCodEmp,; 
                     BSCCli With cBscCli,; 
                     BSCFor With cBscFor,; 
                     BSCEmp With cBscEmp,; 
                     TIPTAB With nTipTab 
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
 
 
Function VerForCli( cDescri, nCodFor, nCodCli, GetList ) 
 
      Local cTela:= ScreenSave( 00, 00, 24, 79 ), cCor:= SetColor(),; 
            nCursor:= SetCursor(), nTela:= 1 
      Local nArea:= Select(), nOrdem:= IndexOrd() 
 
      IF !EMPTY( cDescri ) 
         Return .T. 
      ENDIF 
 
      VPBox( 04, 29, 12, 76," Fornecedores ", _COR_BROW_BOX, .T., .T. ) 
      VPBox( 13, 29, 21, 76," Clientes ", _COR_BROW_BOX, .T., .T. ) 
      setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
      MENSAGEM("[Tab]Janela [ENTER]Seleciona [A..Z]Pesquisa [ESC]Cancela") 
      ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
 
      DBSelectAr( _COD_FORNECEDOR ) 
      DBLeOrdem() 
      DBGoTop() 
      oTAB:=tbrowsedb(05,30,11,75) 
      oTAB:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,4,0)+" "+DESCRI })) 
      oTAB:AUTOLITE:=.F. 
      oTAB:dehilite() 
      oTab:RefreshAll() 
      WHILE !oTab:Stabilize() 
      ENDDO 
 
      DBSelectAr( _COD_CLIENTE ) 
      DBLeOrdem() 
      DBGoTop() 
      oTAB2:=tbrowsedb(14,30,20,75) 
      oTAB2:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,6,0)+" "+DESCRI })) 
      oTAB2:AUTOLITE:=.F. 
      oTAB2:dehilite() 
      oTab2:RefreshAll() 
      WHILE !oTab2:Stabilize() 
      ENDDO 
 
      DBSelectAr( _COD_FORNECEDOR ) 
      WHILE .T. 
         IF nTela == 1 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
            whil nextkey()==0 .and.! oTAB:stabilize() 
            enddo 
         ELSE 
            oTAB2:colorrect({oTab2:ROWPOS,1,oTab2:ROWPOS,oTab2:COLCOUNT},{2,1}) 
            whil nextkey()==0 .and.! oTab2:stabilize() 
            enddo 
         ENDIF 
 
         IF ( nTecla:=inkey(0) )==K_ESC 
            EXIT 
         ENDIF 
 
         IF nTecla==K_TAB 
            nTela:= IF( nTela == 1, 2, 1 ) 
            IF nTela == 1 
               oTAB2:refreshAll() 
               WHILE !oTab2:Stabilize() 
               ENDDO 
               DBSelectAr( _COD_FORNECEDOR ) 
            ELSE 
               oTAB:refreshAll() 
               WHILE !oTab:Stabilize() 
               ENDDO 
               DBSelectAr( _COD_CLIENTE ) 
            ENDIF 
         ENDIF 
 
         IF nTela == 1 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               case nTecla == K_F2 
                    DBMudaOrdem( 1, oTab ) 
               case nTecla == K_F3 
                    DBMudaOrdem( 2, oTab ) 
               case DBPesquisa( nTecla, oTab ) 
               case nTecla==K_ENTER 
                    nCodFor:= FOR->CODIGO 
                    cDescri:= FOR->DESCRI 
                    EXIT 
            endcase 
            oTAB:refreshcurrent() 
            oTAB:stabilize() 
         ELSE 
            do case 
               case nTecla==K_UP         ;oTab2:up() 
               case nTecla==K_LEFT       ;oTab2:up() 
               case nTecla==K_RIGHT      ;oTab2:down() 
               case nTecla==K_DOWN       ;oTab2:down() 
               case nTecla==K_PGUP       ;oTab2:pageup() 
               case nTecla==K_PGDN       ;oTab2:pagedown() 
               case nTecla==K_CTRL_PGUP  ;oTab2:gotop() 
               case nTecla==K_CTRL_PGDN  ;oTab2:gobottom() 
               case nTecla == K_F2 
                    DBMudaOrdem( 1, oTab2 ) 
               case nTecla == K_F3 
                    DBMudaOrdem( 2, oTab2 ) 
               case DBPesquisa( nTecla, oTab2 ) 
               case nTecla==K_ENTER 
                    nCodCli:= CLI->CODIGO 
                    cDescri:= CLI->DESCRI 
                    EXIT 
            endcase 
            oTab2:refreshcurrent() 
            oTab2:stabilize() 
         ENDIF 
      enddo 
 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      FOR nCt:= 1 TO Len( GetList ) 
          GetList[ nCt ]:Display() 
      NEXT 
      DBSelectAr( nArea ) 
      IF nOrdem > 0 
         DBSetOrder( nOrdem ) 
      ENDIF 
 
   Return !EMPTY( cDescri ) 
 
 
 
 
Function SelecionaSetor( nCodSet ) 
Local cCor:= SetColor(), nCursor:= SetCursor( 0 ),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
 
 
    DBSelectAr( _COD_SETORES ) 
    IF !( nCodSet==Nil ) 
       DBSetOrder( 1 ) 
       DBSeek( nCodSet ) 
    ENDIF 
    nCodSet:= 0 
    DBLeOrdem() 
 
    VPBox( 04, 29, 20, 76," SETORES ", _COR_BROW_BOX, .T., .T. ) 
    setcolor( _COR_BROWSE ) 
 
    Mensagem("[TAB]Janela [ENTER]Seleciona [A..Z]Pesquisa [ESC]Cancela") 
    Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
 
    DBGoTop() 
    oTab:=tbrowsedb( 05, 30, 19, 75 ) 
    oTab:addcolumn(tbcolumnnew(,{|| STRZERO( CODIGO, 6, 0 ) + " " + ; 
                                    DESCRI + " " + StrZero( CODFOR, 4, 0 ) +; 
                                    StrZero( CODCLI, 6, 0 ) + " " +; 
                                    StrZero( CODEMP, 3, 0 )  } ) ) 
    oTab:AUTOLITE:=.F. 
    oTab:dehilite() 
    oTab:RefreshAll() 
    WHILE !oTab:Stabilize() 
    ENDDO 
 
    WHILE .T. 
 
       oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
       whil nextkey()==0 .and.! oTAB:stabilize() 
       enddo 
 
       IF ( nTecla:=inkey(0) )==K_ESC 
          EXIT 
       ENDIF 
 
       do case 
          case nTecla==K_UP         ;oTAB:up() 
          case nTecla==K_LEFT       ;oTAB:up() 
          case nTecla==K_RIGHT      ;oTAB:down() 
          case nTecla==K_DOWN       ;oTAB:down() 
          case nTecla==K_PGUP       ;oTAB:pageup() 
          case nTecla==K_PGDN       ;oTAB:pagedown() 
          case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
          case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
          case nTecla == K_F2 
               DBMudaOrdem( 1, oTab ) 
          case nTecla == K_F3 
               DBMudaOrdem( 2, oTab ) 
          case DBPesquisa( nTecla, oTab ) 
          case nTecla==K_ENTER 
               nCodSet:= CODIGO 
               EXIT 
       endcase 
       oTAB:refreshcurrent() 
       oTAB:stabilize() 
 
    ENDDO 
 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    DBSelectAr( nArea ) 
    IF nOrdem > 0 
       DBSetOrder( nOrdem ) 
    ENDIF 
    Return nCodSet 
 
 
