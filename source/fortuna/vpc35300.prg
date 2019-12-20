// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � TABELA DE ROTAS 
� Finalidade  � Lancamento de Tabela Rotas de Entrega 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/ 
Function Rotas() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   DBSelectAr( _COD_TABROTAS ) 
   Set( _SET_DELIMITERS, .T. ) 
   DispBegin() 
   VPBox( 00, 00, 13, 79, "TABELAS DE ROTAS DE ENTREGA", _COR_GET_BOX,.F.,.F.  ) 
   VPBox( 13, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   ExibeStr() 
   DBLeOrdem() 
   Mensagem( "[+]Produtos [INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 14, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                        ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                               PAD( DESCRI, 50 ) + SPACE( 40 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      MostraDados() 
      nTecla:=inkey(0) 
      if nTecla=K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:PanLeft() 
         case nTecla==K_RIGHT      ;oTab:PanRight() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_INS        ;IncluiRota( oTab ) 
         case nTecla==K_ENTER      ;AlteraRota( oTab ) 
         Case nTecla==K_DEL 
              IF !CODIGO == 0 
                 Exclui( oTab ) 
              ENDIF 
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         Case nTecla==K_SPACE 
              nRegistro:= Recno() 
              DBGoTop() 
              WHILE !EOF() 
                  IF netrlock() 
                     IF Recno() == nRegistro 
                        Replace SELECT With "*" 
                     ELSE 
                        Replace SELECT With " " 
                     ENDIF 
                  ENDIF 
                  dbUnLock() 
                  DBSkip() 
              ENDDO 
              DBGoTo( nRegistro ) 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
         Case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Static Function ExibeStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.....: [    ]" 
  @ 03,02 Say "Descricao..: [                                        ]" 
  SetColor( cCor ) 
  Return nil 
 
Static Function MostraDados(cTELA) 
  cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,16 Say strzero(CODIGO,4,0) 
  @ 03,16 Say DESCRI 
  SetColor( cCor ) 
  Return nil 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiRota 
� Finalidade  � Inclusao de registros em Contas a Pagar 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Func IncluiRota( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40) 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 12, 79, "TABELA DE ROTAS (INCLUSAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr(_COD_TABROTA) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCodigo:= Codigo + 1 
  IF nCodigo == 1 
     IF !DBSeek( 0 ) 
        DBAppend() 
        IF netrlock() 
           Replace CODIGO With 0,; 
                   DESCRI With "TABELA PADRAO" 
        ENDIF 
     ENDIF 
  ENDIF 
  dbgotop() 
  WHILE .T. 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,02 Say "Codigo.....: ["+strzero(nCODIGO,6,0)+"]" 
     @ 03,02 Say "Descricao..:" Get cDescri when Mensagem("Descricao da tabela de Rotas.") 
     READ 
     IF !LastKey() == K_ESC 
        If confirma(12,63,"Confirma?",; 
           "Digite [S] para confirmar o cadastramento.","S",; 
           COR[16]+","+COR[18]+",,,"+COR[17]) 
           IF DBSeek( nCodigo ) 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Codigo de lancamento ser� substituido" ) 
              Pausa() 
              ScreenRest( cTelaRes ) 
              DBGoBottom() 
              nCodigo:= nCodigo + 1 
           ENDIF 
           If buscanet(5,{|| dbappend(), !neterr()}) .AND.; 
             nCODIGO <> 0 
               repl CODIGO with nCODIGO, DESCRI With cDescri 
           EndIf 
           /* Limpa as variaveis */ 
           cDESCRI:= Space( 40 ) 
           oTab:PageUp() 
           oTab:Down() 
           oTab:RefreshAll() 
           WHILE !oTab:Stabilize() 
           ENDDO 
           ++nCodigo 
           dbUnlockAll() 
        EndIf 
     ELSE 
        Exit 
     ENDIF 
  Enddo 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  SetColor(cCOR) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � ALTERARota 
� Finalidade  � Alteracao de Rotas 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraRota( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40) 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 12, 79, "TABELA DE ROTAS (ALTERACAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  nCodigo:= Codigo 
  cDescri:= DESCRI 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.....: ["+strzero(nCODIGO,6,0)+"]" 
  @ 03,02 Say "Descricao..:" Get cDescri when Mensagem("Digite a descricao da tabela de Rotas.") 
  READ 
  IF !LastKey() == K_ESC 
     If confirma(12,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        If netrlock() 
           repl DESCRI With cDescri 
        EndIf 
        dbUnlockAll() 
     EndIf 
  ENDIF 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  SetColor(cCOR) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � Selecao da Tabela de Rota 
� Finalidade  � 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TabelaRota() 
  Local nArea:= Select() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_TABROTA ) 
   DispBegin() 
   VPBox( 05, 10, 18, 62, "TABELA DE ROTAS", _COR_BROW_BOX, .T., .T.  ) 
   SetColor( _COR_BROWSE ) 
   DBLeOrdem() 
   DBGoTop() 
   WHILE !CODIGO == SWSet( _INT_TABROTA ) 
      DBSkip() 
      IF EOF() 
         EXIT 
      ENDIF 
   ENDDO 
   Mensagem( "[ENTER]Seleciona" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 06, 11, 15, 61 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                                  ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                               PAD( DESCRI, 40 ) +" "+; 
                                               Space( 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      if nTecla=K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:PanLeft() 
         case nTecla==K_RIGHT      ;oTab:PanRight() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_F8 .OR. nTecla==K_ENTER 
              EXIT 
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         Case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
 
 
 
