// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC29700.PRG 
� Finalidade  � Inclusao / Alteracao / Exclusao de tabela de ICMs Reducao 
� Parametros  � Nil 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc29700()
#endif

LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   /* Seleciona area de tabalho */ 
   IF !AbreGrupo( "REDUCAO_ICM" ) 
      Return Nil 
   ENDIF 
   DBSelectAr( _COD_REDUCAO ) 
 
   /* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 16, 79,"TABELA DE ICMS & REDUCOES", _COR_GET_BOX, .F., .F. ) 
   VPBox( 17, 00, 22, 79," Display ", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
   /* Ajuste de mensagens */ 
   Mensagem("[INS]Incluir [ENTER]Alterar [DEL]Excluir ou [ESC]Finalizar.") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
   SetColor( _COR_BROWSE ) 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseDB( 18, 01, 21, 78 ) 
   oTb:AddColumn( tbcolumnnew( ,{|| CODIGO + " " + DESCRI + " " + Left( OBSERV, 34 ) + " " + Tran( PERRED, "@E 999.99999" ) })) 
 
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
 
       @ 02,03 Say "Codigo da Tabela.............: [" + CODIGO + "]" 
       @ 03,03 Say "Descricao....................: [" + DESCRI + "]" 
 
       @ 05,01 Say "  REDUCAO UNIFORME - PADRAO SOBRE QUALQUER SITUACAO                           " Color "00/15" 
       @ 06,03 Say "Observacao na Nota Fiscal....: [" + OBSERV + "]" 
       @ 07,03 Say "Percentual de Reducao........: [" + Tran( PERRED, "@E 999.99999" ) + "]" 
 
       @ 09,01 Say "  REDUCAO COM PARAMETROS DIFERENCIADOS POR ALIQUOTA & TIPO DE CLIENTE         " Color "00/15" 
       @ 10,01 Say " % ICMs %Reducao ECF  %Reducao ECF Observacao Nota               " 
 
 
 
       ////// EXIBE TABELA DE REDUCOES DIFERENCIADAS 
 
       RDA->( DBSeek( RED->CODIGO ) ) 
       nLin:= 10 
 
       Scroll( nLin+1, 03, 16, 78, 0 ) 
 
       WHILE RDA->CODIGO==RED->CODIGO .AND. !EOF() .AND. nLin < 16 
 
           // Configuracao de TELA ------------------------------------- 
           //        1         2         3         4         5         6         7 
           // 3456789012345678901234567890123456789012345678901234567890123456789012345 
           // 999.99 999.99999 XX 999,99999 XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
           // ---------------------------------------------------------- 
 
           /* ICMs */ 
           @ ++nLin,03 Say Tran( RDA->PERICM, "@R 999.99" ) 
 
           /* Consumo */ 
           @ nLin,10 Say Tran( RDA->PERRDC, "@R 999.99999" ) 
           @ nLin,20 Say RDA->ECF__C 
 
           /* Industria */ 
           @ nLin,23 Say Tran( RDA->PERRDI, "@E 999.99999" ) 
           @ nLin,33 Say RDA->ECF__I 
 
           /* Observacoes na nota */ 
           @ nLin,36 Say RDA->OBSERV 
 
           RDA->( DBSkip() ) 
 
       ENDDO 
 
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
 
          CASE nTecla==K_INS        ;ReducaoIncluir( oTb ) 
 
          CASE nTecla==K_DEL 
              cCodigo:= CODIGO 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              IF Exclui( oTb ) 
                 Aviso( "Buscando produtos com esta aliquota, aguarde..." ) 
                 MPR->( DBGoTop() ) 
                 WHILE !MPR->( EOF() ) 
                     IF ALLTRIM( MPR->( TABRED ) )==ALLTRIM( cCodigo ) 
                        IF MPR->( netrlock() ) 
                           Replace MPR->PERRED With 0,; 
                                   MPR->TABRED With Space( LEN( MPR->TABRED ) ) 
                        ENDIF 
                     ENDIF 
                     MPR->( DBSkip() ) 
                     MPR->( DBUnlockAll() ) 
                 ENDDO 
              ENDIF 
              ScreenRest( cTelaRes ) 
 
          CASE nTecla==K_ENTER      ;ReducaoAlterar( oTb ) 
 
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
� Funcao      � ReducaoIncluir 
� Finalidade  � Incluir itens na tabela de percentuais de reducao 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 05/Fevereiro/1998 
��������������� 
*/ 
FUNCTION ReducaoIncluir( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local cCodigo:= "  ", cDescri:= Space( 30 ), cObserv:= Space( 40 ), nPerRed:= 0 
 
   DBSelectAr( _COD_REDUCAO ) 
 
   WHILE ! LastKey() == K_ESC 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
      @ 02, 03 Say "Codigo da Tabela.............:" Get cCodigo Pict "!!" When Mensagem( " Digite este item da tabela." ) 
      @ 03, 03 Say "Descricao....................:" Get cDescri When Mensagem( "Digite a descricao/motivo deste item de reducao." ) 
 
      @ 06, 03 Say "Observacao na Nota Fiscal....:" Get cObserv When Mensagem( "Digite a mensagem que devera ser informada na Nota Fiscal. " ) 
      @ 07, 03 Say "Percentual de Reducao........:" Get nPerRed Pict "@E 999.99999" When Mensagem( "Digite o percentual de reducao para este iten." ) 
 
      READ 
      IF !( LastKey()==K_ESC ) 
 
         IF DBSeek( cCodigo ) 
            cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
            Aviso( "Atencao! Codigo ja esta cadastrado...", 12 ) 
            Pausa() 
            ScreenRest( cTelaRes ) 
         ELSE 
 
             ReducoesDiferenciadas( cCodigo ) 
             DBAppend() 
             IF netrlock() 
                Replace CODIGO With cCodigo,; 
                        DESCRI With cDescri,; 
                        OBSERV With cObserv,; 
                        PERRED With nPerRed 
             ENDIF 
             EXIT 
 
          ENDIF 
      ELSE 
         EXIT 
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
 
 
 
Function ReducoesDiferenciadas( cCodigo ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local nTecla, oTb 
 
    DBSelectAR( _COD_REDAUX ) 
    Set Filter To CODIGO==cCodigo 
    DBGoTop() 
 
    VPBox( 03, 03, 20, 75, "ICMs DIFERENCIADOS", _COR_GET_BOX ) 
    VPBox( 11, 04, 19, 74, "DISPLAY", _COR_BROW_BOX, .F., .F. ) 
 
    /* Ajuste de mensagens */ 
    Mensagem("[INS]Incluir [ENTER]Alterar [DEL]Excluir ou [ESC]Finalizar.") 
    Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
    SetColor( _COR_BROWSE ) 
 
    /* Inicializacao do objeto browse */ 
    oTb:=TBrowseDB( 12, 05, 18, 73 ) 
    oTb:AddColumn( tbcolumnnew( ,{|| Tran( PERICM, "@e 999.99" ) + " " + Tran( PERRDc, "@E 999.99999" ) + " " + ECF__C + " " + Tran( PERRDi, "@E 999.99999" ) + " " + ECF__I + " " + OBSERV })) 
 
    /* Variaveis do objeto browse */ 
    oTb:AutoLite:=.f. 
    oTb:dehilite() 
 
    WHILE .T. 
 
        /* Ajuste sa barra de selecao */ 
        oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
        WHILE NextKey()=0 .AND. !oTb:Stabilize() 
        ENDDO 
 
        SetColor( _COR_GET_EDICAO ) 
        @ 04,05 Say "% ICMs...............: [" + Tran( PERICM, "@e 999.99" ) + "]" Color _COR_GET_EDICAO 
        @ 05,05 Say "Consumo  => Reducao..: [" + Tran( PERRDc, "@E 999.99999" ) + "]" 
        @ 06,05 Say "            ECF......: [" + ECF__c + "]" 
        @ 07,05 Say "Industria=> Reducao..: [" + Tran( PERRDi, "@E 999.99999" ) + "]" 
        @ 08,05 Say "            ECF......: [" + ECF__i + "]" 
        @ 09,05 Say "Observacao na Nota...: [" + OBSERV + "]" 
        SetColor( _COR_BROWSE ) 
 
        /* Tecla */ 
        nTecla:= inkey( 0 ) 
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
                nPERICM:= pericm 
                nPerRdC:= PERRDC 
                nPerRdI:= PERRDI 
                cECF__C:= ECF__C 
                cECF__i:= ECF__I 
                cObserv:= OBSERV 
                SetColor( _COR_GET_EDICAO ) 
                @ 04,05 Say "% ICMs...............:" Get nPERICM Pict "@e 999.99" 
                @ 05,05 Say "Consumo  => Reducao..:" Get nPERRDc Pict "@E 999.99999" 
                @ 06,05 Say "            ECF......:" Get cECF__c 
                @ 07,05 Say "Industria=> Reducao..:" Get nPERRDi Pict "@E 999.99999" 
                @ 08,05 Say "            ECF......:" Get cECF__i 
                @ 09,05 Say "Observacao na Nota...:" Get cObserv 
                READ 
 
                /* Gravar informacoes */ 
                IF LastKey() <> K_ESC 
                   IF netrlock() 
                      Replace CODIGO With cCodigo,; 
                              PERICM With nPERICM,; 
                              PERRDc With nPERRDc,; 
                              ECF__c With cECF__c,; 
                              PERRDi With nPERRDi,; 
                              ECF__i With cECF__i,; 
                              OBSERV With cObserv 
                   ENDIF 
                ENDIF 
                SetColor( _COR_BROWSE ) 
 
           CASE nTecla==K_INS 
                nPERICM:= 0 
                nPerRdC:= 0 
                nPerRdI:= 0 
                cECF__C:= Space( 2 ) 
                cECF__i:= Space( 2 ) 
                cObserv:= Space( 40 ) 
                SetColor( _COR_GET_EDICAO ) 
                @ 04,05 Say "% ICMs...............:" Get nPERICM Pict "@e 999.99" 
                @ 05,05 Say "Consumo  => Reducao..:" Get nPERRDc Pict "@E 999.99999" 
                @ 06,05 Say "            ECF......:" Get cECF__c 
                @ 07,05 Say "Industria=> Reducao..:" Get nPERRDi Pict "@E 999.99999" 
                @ 08,05 Say "            ECF......:" Get cECF__i 
                @ 09,05 Say "Observacao na Nota...:" Get cObserv 
                READ 
 
                /* Gravar informacoes */ 
                IF LastKey() <> K_ESC 
                   DBAppend() 
                   Replace CODIGO With cCodigo,; 
                           PERICM With nPERICM,; 
                           PERRDc With nPERRDc,; 
                           ECF__c With cECF__c,; 
                           PERRDi With nPERRDi,; 
                           ECF__i With cECF__i,; 
                           OBSERV With cObserv 
                ENDIF 
                SetColor( _COR_BROWSE ) 
                oTb:RefreshAll() 
                WHILE !oTb:Stabilize() 
                ENDDO 
 
           OTHERWISE                 ;Tone(125); Tone(300) 
 
       ENDCASE 
 
       oTb:RefreshCurrent() 
       oTb:Stabilize() 
 
    ENDDO 
 
    DBSelectAr( _COD_REDAUX ) 
    Set Filter To 
 
    DBSelectAr( nArea ) 
    DBSetOrder( nOrdem ) 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � ReducaoAlterar 
� Finalidade  � Alterar itens na tabela de percentuais de reducao 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 05/Fevereiro/1998 
��������������� 
*/ 
FUNCTION ReducaoAlterar( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local cCodigo:= CODIGO, cDescri:= DESCRI, cObserv:= OBSERV, nPerRed:= PERRED 
 
   DBSelectAr( _COD_REDUCAO ) 
 
   /* Display das informacoes */ 
   SetColor( _COR_GET_EDICAO ) 
   @ 02, 03 Say "Codigo da Tabela.............: [" + cCodigo + "]" 
   @ 03, 03 Say "Descricao....................:" Get cDescri When Mensagem( "Digite a descricao/motivo deste item de reducao." ) 
 
   @ 06, 03 Say "Observacao na Nota Fiscal....:" Get cObserv When Mensagem( "Digite a mensagem que devera ser informada na Nota Fiscal. " ) 
   @ 07, 03 Say "Percentual de Reducao........:" Get nPerRed Pict "@E 999.99999" When Mensagem( "Digite o percentual de reducao para este iten." ) 
 
   READ 
 
   IF DBSeek( cCodigo ) .AND. ! LastKey() == K_ESC 
 
          IF LastKey() <> K_ESC 
             ReducoesDiferenciadas( cCodigo ) 
             IF netrlock() 
                Replace CODIGO With cCodigo,; 
                        DESCRI With cDescri,; 
                        OBSERV With cObserv,; 
                        PERRED With nPerRed 
             ENDIF 
             VPBox( 0, 0, 22, 79, "", _COR_GET_EDICAO ) 
             Mensagem( "Atualizando informacoes no cadastro de produtos, aguarde..." ) 
             SetColor( _COR_GET_EDICAO ) 
             MPR->( DBGoTop() ) 
             WHILE !MPR->( EOF() ) 
                 @ 21,03 Say MPR->DESCRI 
                 Scroll( 01, 01, 21, 78, 1 ) 
                 IF ALLTRIM( MPR->( TABRED ) )==ALLTRIM( cCodigo ) 
                    IF MPR->( netrlock() ) 
                       Replace MPR->PERRED With nPerRed,; 
                               MPR->TABRED With cCodigo 
                    ENDIF 
                    MPR->( DBUnlock() ) 
                 ENDIF 
                 MPR->( DBSkip() ) 
             ENDDO 
             ScreenRest( cTela ) 
             MPR->( DBGoTop() ) 
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
 
 
