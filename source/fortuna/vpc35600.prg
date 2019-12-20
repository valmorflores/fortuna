// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
#include "ptfuncs.ch" 
#include "ptverbs.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � TABELA DE OBSERVACOES P/ NOTA FISCAL 
� Finalidade  � Lancamento de Tabela 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/
#ifdef HARBOUR
function vpc35600()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   DBSelectAr( _COD_OBSERVACOES ) 
   Set( _SET_DELIMITERS, .T. ) 
   DispBegin() 
   VPBox( 00, 00, 14, 79, "TABELAS DE OBSERVACOES NA NOTA FISCAL", _COR_GET_BOX,.F.,.F.  ) 
   VPBox( 15, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   ExibeStr() 
   DBLeOrdem() 
   Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 16, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                                             ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                               PAD( DESCRI, 50 ) + SPACE( 30 ) })) 
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
         case nTecla==K_INS        ;IncluiObservacao( oTab ) 
         case nTecla==K_ENTER      ;AlteraObservacao( oTab ) 
         Case nTecla==K_DEL 
              Exclui( oTab ) 
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
   Return Nil 
 
Static Function ExibeStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.......: [   ]" 
  @ 03,02 Say "Descricao....: [                                        ]" 
  @ 04,02 Say "Observacao NF: [                                                     ]" 
  SetColor( cCor ) 
  Return nil 
 
Static Function MostraDados(cTELA) 
  cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,18 Say StrZero(CODIGO,2,0) 
  @ 03,18 Say DESCRI 
  @ 04,18 Say LEFT( OBSERV, 55 ) 
  SetColor( cCor ) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � Selecao 
� Finalidade  � 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TabelaObservacoes( nCodigo ) 
  Local nArea:= Select() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_OBSERVACOES ) 
   DBSetOrder( 1 ) 
   DBGoTop() 
   IF DBSeek( nCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
   DispBegin() 
   VPBox( 05, 10, 18, 72, "TABELA DE OBSERVACOES", _COR_BROW_BOX, .T., .T.  ) 
   SetColor( _COR_BROWSE ) 
   DBLeOrdem() 
   DBGoTop() 
   Mensagem( "[ENTER]Seleciona" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 06, 11, 17, 71 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                                              ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                                DESCRI +" "+; 
                                                Space( 40 ) })) 
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
         case nTecla==K_ENTER 
              nCodigo:= CODIGO 
              SetColor( cCor ) 
              SetCursor( nCursor ) 
              ScreenRest( cTela ) 
              Return .T. 
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
   Return .F. 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiObservacao 
� Finalidade  � Inclusao de registros 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Func IncluiObservacao( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(30), nNatOpe:= 0, cEntSai:=" ",; 
        nNatFor:= 0, cDebCre:= " ", cCalIcm:= "S", cFrete_:= "1",; 
        nTabPre:= 0, nTabCnd:= 0, cComiss:= "S", cObserv:= Space( 40 ) 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 14, 79, "TABELA DE OBSERVACOES (INCLUSAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr( _COD_OBSERVACOES ) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCodigo:= Codigo + 1 
  dbgotop() 
  WHILE .T. 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,02 Say "Codigo.......:" Get nCODIGO Pict "999" 
     @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Descricao da tabela de precos.") 
     @ 04,02 Say "Observacao NF:" Get cObserv 
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
              repl CODIGO with nCODIGO,; 
                   DESCRI With cDescri,; 
                   OBSERV With cObserv 
           EndIf 
           /* Limpa as variaveis */ 
           cDESCRI:= Space( 40 ) 
           cEntSai:= " " 
           nNatOpe:= 0 
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
  Set Key K_TAB to 
  SetColor(cCOR) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � Alteracao de Observacoes 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraObservacao( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40) 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 14, 79, "TABELA DE OBSERVACOES", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  nCodigo:= CODIGO 
  cDescri:= DESCRI 
  cObserv:= OBSERV 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.......: ["+strzero(nCODIGO,3,0)+"]" 
  @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Digite a descricao da tabela de precos.") 
  @ 04,02 Say "Observacao NF:" Get cObserv 
  READ 
  IF !LastKey() == K_ESC 
     If confirma(12,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        If netrlock() 
           repl DESCRI With cDescri,; 
                OBSERV With cObserv 
 
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
  Set Key K_TAB to 
  SetColor(cCOR) 
