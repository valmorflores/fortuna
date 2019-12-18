// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
 
/*****ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Arquivo     ³ VPC37200 
³ Finalidade  ³ Lancamento de Tabela de Tipos de Contato 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Maio/2001 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/
#ifdef HARBOUR
function vpc37200()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   dbSelectAr( _COD_MPRIMA ) 
   DBCloseArea() 
 
   dbSelectAr( _COD_MIDIA ) 
   IF !File( _VPB_MIDIA ) 
      CreateVPB( _COD_MIDIA ) 
   ENDIF 
   FDBUseVpb( _COD_MIDIA ) 
   DBSelectAr( _COD_MIDIA ) 
   IF Used() 
      Set( _SET_DELIMITERS, .T. ) 
      DispBegin() 
      VPBox( 00, 00, 06, 79, "TABELAS DE TIPOS DE CONTATO", _COR_GET_BOX,.F.,.F.  ) 
      VPBox( 07, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
      SetColor( _COR_BROWSE ) 
      DBLeOrdem() 
      Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
      Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
      oTab:=tbrowsedb( 08, 01, 21, 78 ) 
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
         @ 03,02 Say "Descricao....: [" +  Descri + "]" Color _COR_GET_EDICAO 
         nTecla:=inkey(0) 
         if nTecla=K_ESC 
            exit 
         endif 
         do Case 
            Case nTecla==K_UP         ;oTab:up() 
            Case nTecla==K_LEFT       ;oTab:PanLeft() 
            Case nTecla==K_RIGHT      ;oTab:PanRight() 
            Case nTecla==K_DOWN       ;oTab:down() 
            Case nTecla==K_PGUP       ;oTab:pageup() 
            Case nTecla==K_PGDN       ;oTab:pagedown() 
            Case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
            Case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
            Case nTecla==K_INS        ;IncluiMidia( oTab ) 
            Case nTecla==K_ENTER      ;AlteraMidia( oTab ) 
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
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   dbSelectAr( _COD_MIDIA ) 
   DBCloseArea() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   DBSelectAr( _COD_CLIENTE ) 
   Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ Selecao 
³ Finalidade  ³ 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function TabelaMidia( nCodigo ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_MIDIA ) 
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
   VPBox( 05, 10, 18, 72, "TABELA DE MIDIAS - TIPOS DE CONTATO", _COR_BROW_BOX, .T., .T.  ) 
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
         nCodigo:= 0 
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
              exit 
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
   IF nArea <> Nil .AND. nOrdem <> Nil 
      IF nArea > 0 .AND. nOrdem > 0 
         DBSelectAr( nArea ) 
         DBSetOrder( nOrdem ) 
      ELSE 
         DBSelectAR( _COD_CLIENTE ) 
      ENDIF 
   ELSE 
      DBSelectAR( _COD_CLIENTE ) 
   ENDIF 
   Return .T. 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ IncluiMIDIA 
³ Finalidade  ³ Inclusao de registros 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Func IncluiMIDIA( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(30), nNatOpe:= 0, cEntSai:=" ",; 
        nNatFor:= 0, cDebCre:= " ", cCalIcm:= "S", cFrete_:= "1",; 
        nTabPre:= 0, nTabCnd:= 0, cComiss:= "S", cObserv:= Space( 40 ) 
  SetColor( _COR_GET_EDICAO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr( _COD_MIDIA ) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCodigo:= Codigo + 1 
  dbgotop() 
  WHILE .T. 
 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     cDescri:= DESCRI 
 
     SetColor( _COR_GET_EDICAO ) 
 
     @ 02,02 Say "Codigo.......:" Get nCODIGO Pict "999" 
     @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Descricao da tabela de precos.") 
     READ 
 
     ScreenRest( cTelaRes ) 
 
 
     IF !LastKey() == K_ESC 
        If confirma(12,63,"Confirma?",; 
           "Digite [S] para confirmar o cadastramento.","S",; 
           COR[16]+","+COR[18]+",,,"+COR[17]) 
           IF DBSeek( nCodigo ) 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Codigo de lancamento ser  substituido" ) 
              Pausa() 
              ScreenRest( cTelaRes ) 
              dbSetOrder( 1 ) 
              DBGoBottom() 
              nCodigo:= nCodigo + 1 
           ENDIF 
           If buscanet(5,{|| dbappend(), !neterr()}) .AND.; 
              nCODIGO <> 0 
              repl CODIGO with nCODIGO,; 
                   DESCRI With cDescri 
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
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ 
³ Finalidade  ³ Alteracao de Midias 
³ Parametros  ³ oTab 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function AlteraMidia( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:= CODIGO, cDescri:= DESCRI 
  Local lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
 
 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  SetColor( _COR_GET_EDICAO ) 
 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.......: ["+strzero(nCODIGO,3,0)+"]" 
  @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Digite a descricao da tabela de precos.") 
  READ 
 
  IF !LastKey() == K_ESC 
     IF Confirma( 00, 00, "Confirma?","Digite [S] para confirmar o cadastramento.","S" ) 
        If NetRLock() 
           Repl DESCRI With cDescri 
        ENDIF 
        dbUnlockAll() 
 
     ENDIF 
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
 
 
 
 
 
 
 
 
