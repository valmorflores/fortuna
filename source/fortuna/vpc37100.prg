// ## CL2HB.EXE - Converted

#include "vpf.ch"
#include "inkey.ch" 
#include "ptfuncs.ch" 
#include "ptverbs.ch" 
 
/*****�������������������������������������������������� 
�������������Ŀ 
� Arquivo     � VPC37100 
� Finalidade  � Lancamento de Tabela Criterio 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/
#ifdef HARBOUR
function vpc37100()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   dbSelectAr( _COD_MPRIMA ) 
   DBCloseArea() 
 
   dbSelectAr( _COD_CRITERIO ) 
   IF !File( _VPB_CRITERIO ) 
      CreateVPB( _COD_CRITERIO ) 
   ENDIF 
   FDBUseVpb( _COD_CRITERIO ) 
   DBSelectAr( _COD_CRITERIO ) 
   IF Used() 
      Set( _SET_DELIMITERS, .T. ) 
      DispBegin() 
      VPBox( 00, 00, 17, 79, "TABELAS DE CRITERIOS", _COR_GET_BOX,.F.,.F.  ) 
      VPBox( 17, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
      SetColor( _COR_BROWSE ) 
      ExibeStr() 
      DBLeOrdem() 
      Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
      Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
      oTab:=tbrowsedb( 18, 01, 21, 78 ) 
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
            case nTecla==K_INS        ;IncluiCriterio( oTab ) 
            case nTecla==K_ENTER      ;AlteraCriterio( oTab ) 
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
   dbSelectAr( _COD_CRITERIO ) 
   DBCloseArea() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   DBSelectAr( _COD_CLIENTE ) 
   Return Nil 
 
Static Function ExibeStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 01,02 Say "Itens                                                  Considerar " 
  @ 02,02 Say "V - Variedade dos Produtos Comprados                   A partir de" 
  @ 03,02 Say "    E=[����]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
 
  @ 05,02 Say "Q - Quantidade de Pecas (Somatorio de Pecas)                     " 
  @ 06,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
 
  @ 08,02 Say "F - Frequencia das Compras                                       " 
  @ 09,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
 
  @ 11,02 Say "T - Tempo em que e' cliente (Em Meses)                           " 
  @ 12,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]             " 
 
  @ 14,02 Say "P - Pagamento                                                    " 
  @ 15,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
  SetColor( cCor ) 
  Return nil 
 
Static Function MostraDados(cTELA) 
Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
 
//  @ 03,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]  B=[  /  /  ]" 
  @ 03,09 Say Tran( V____A, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 03,19 Say Tran( V____B, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 03,29 Say Tran( V____C, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 03,39 Say Tran( V____D, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 03,49 Say Tran( V____E, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 03,58 Say V_DATA Color _COR_GET_CURSOR 
 
//  @ 06,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
  @ 06,09 Say Tran( Q____A, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 06,19 Say Tran( Q____B, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 06,29 Say Tran( Q____C, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 06,39 Say Tran( Q____D, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 06,49 Say Tran( Q____E, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 06,58 Say Q_DATA Color _COR_GET_CURSOR 
 
//  @ 09,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
  @ 09,09 Say Tran( F____A, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 09,19 Say Tran( F____B, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 09,29 Say Tran( F____C, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 09,39 Say Tran( F____D, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 09,49 Say Tran( F____E, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 09,58 Say F_DATA Color _COR_GET_CURSOR 
 
//  @ 12,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]             " 
  @ 12,09 Say Tran( T____A, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 12,19 Say Tran( T____B, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 12,29 Say Tran( T____C, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 12,39 Say Tran( T____D, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 12,49 Say Tran( T____E, "@R 9999" ) Color _COR_GET_CURSOR 
 
//@ 15,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
  @ 15,09 Say Tran( P____A, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 15,19 Say Tran( P____B, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 15,29 Say Tran( P____C, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 15,39 Say Tran( P____D, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 15,49 Say Tran( P____E, "@R 9999" ) Color _COR_GET_CURSOR 
  @ 15,58 Say P_DATA Color _COR_GET_CURSOR 
 
// FIM // FIM // FIM // FIM // FIM // FIM // FIM // FIM // FIM // FIM // 
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
Function TabelaCriterios( nCodigo ) 
  Local nArea:= Select() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_CRITERIO ) 
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
   VPBox( 05, 10, 18, 72, "TABELA DE CRITERIO", _COR_BROW_BOX, .T., .T.  ) 
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
� Funcao      � IncluiCriterio 
� Finalidade  � Inclusao de registros 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Func IncluiCriterio( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(30), nNatOpe:= 0, cEntSai:=" ",; 
        nNatFor:= 0, cDebCre:= " ", cCalIcm:= "S", cFrete_:= "1",; 
        nTabPre:= 0, nTabCnd:= 0, cComiss:= "S", cObserv:= Space( 40 ) 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 14, 79, "TABELA DE CRITERIOS (INCLUSAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr( _COD_CRITERIO ) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCodigo:= Codigo + 1 
  dbgotop() 
  WHILE .T. 
 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     cDescri:= DESCRI 
     nCodigo:= CODIGO 
 
     SetColor( _COR_GET_EDICAO ) 
     VPBox( 01, 01, 05, 78, " INCLUSAO DE CRITERIO ", _COR_GET_BOX ) 
 
     @ 02,02 Say "Codigo.......:" Get nCODIGO Pict "999" 
     @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Descricao da tabela de precos.") 
     READ 
 
     ScreenRest( cTelaRes ) 
 
     nV____A:= V____A 
     nV____B:= V____B 
     nV____C:= V____C 
     nV____D:= V____D 
     nV____E:= V____E 
     nV_DATA:= V_DATA 
 
     @ 06,09 Say Tran( Q____A, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 06,19 Say Tran( Q____B, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 06,29 Say Tran( Q____C, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 06,39 Say Tran( Q____D, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 06,49 Say Tran( Q____E, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 06,58 Say Q_DATA Color _COR_GET_CURSOR 
 
   //  @ 09,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
     @ 09,09 Say Tran( F____A, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 09,19 Say Tran( F____B, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 09,29 Say Tran( F____C, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 09,39 Say Tran( F____D, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 09,49 Say Tran( F____E, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 09,58 Say F_DATA Color _COR_GET_CURSOR 
 
   //  @ 12,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]             " 
     @ 12,09 Say Tran( T____A, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 12,19 Say Tran( T____B, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 12,29 Say Tran( T____C, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 12,39 Say Tran( T____D, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 12,49 Say Tran( T____E, "@R 9999" ) Color _COR_GET_CURSOR 
 
   //@ 15,02 Say "    E=[    ]  D=[    ]  C=[    ]  B=[    ]  A=[    ]   [  /  /  ]" 
     @ 15,09 Say Tran( P____A, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 15,19 Say Tran( P____B, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 15,29 Say Tran( P____C, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 15,39 Say Tran( P____D, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 15,49 Say Tran( P____E, "@R 9999" ) Color _COR_GET_CURSOR 
     @ 15,58 Say P_DATA Color _COR_GET_CURSOR 
 
 
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
�������������Ŀ 
� Funcao      � 
� Finalidade  � Alteracao de Criterios 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraCriterio( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:= CODIGO, cDescri:= DESCRI 
  Local lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
 
  LOCAL nQ____A:= Q____A, nQ____B:= Q____B, nQ____C:= Q____C, nQ____D:= Q____D,; 
        nQ____E:= Q____E, dQ_DATA:= Q_DATA, nF____A:= F____A, nF____B:= F____B,; 
        nF____C:= F____C, nF____D:= F____D, nF____E:= F____E, dF_DATA:= F_DATA,; 
        nT____A:= T____A, nT____B:= T____B, nT____C:= T____C, nT____D:= T____D,; 
        nT____E:= T____E, nP____A:= P____A, nP____B:= P____B, nP____C:= P____C,; 
        nP____D:= P____D, nP____E:= P____E, dP_DATA:= P_DATA 
 
 
  VPBox( 00, 00, 14, 79, "TABELA DE CRITERIOS", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  SetColor( _COR_GET_EDICAO ) 
 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.......: ["+strzero(nCODIGO,3,0)+"]" 
  @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Digite a descricao da tabela de precos.") 
  READ 
 
  ExibeStr() 
  Set( _SET_DELIMITERS, .F. ) 
 
  @ 06,09 Get nQ____A Pict "@R 9999" 
  @ 06,19 Get nQ____B Pict "@R 9999" 
  @ 06,29 Get nQ____C Pict "@R 9999" 
  @ 06,39 Get nQ____D Pict "@R 9999" 
  @ 06,49 Get nQ____E Pict "@R 9999" 
  @ 06,58 Get dQ_DATA 
 
  @ 09,09 Get nF____A Pict "@R 9999" 
  @ 09,19 Get nF____B Pict "@R 9999" 
  @ 09,29 Get nF____C Pict "@R 9999" 
  @ 09,39 Get nF____D Pict "@R 9999" 
  @ 09,49 Get nF____E Pict "@R 9999" 
  @ 09,58 Get dF_DATA 
 
  @ 12,09 Get nT____A Pict "@R 9999" 
  @ 12,19 Get nT____B Pict "@R 9999" 
  @ 12,29 Get nT____C Pict "@R 9999" 
  @ 12,39 Get nT____D Pict "@R 9999" 
  @ 12,49 Get nT____E Pict "@R 9999" 
 
  @ 15,09 Get nP____A Pict "@R 9999" 
  @ 15,19 Get nP____B Pict "@R 9999" 
  @ 15,29 Get nP____C Pict "@R 9999" 
  @ 15,39 Get nP____D Pict "@R 9999" 
  @ 15,49 Get nP____E Pict "@R 9999" 
  @ 15,58 Get dP_DATA 
  READ 
  Set( _SET_DELIMITERS, lDelimiters ) 
 
  IF !LastKey() == K_ESC 
     IF Confirma( 00, 00, "Confirma?","Digite [S] para confirmar o cadastramento.","S" ) 
        If netrlock() 
           Repl DESCRI With cDescri,; 
                Q____A With nQ____A,; 
                Q____B With nQ____B,; 
                Q____C With nQ____C,; 
                Q____D With nQ____D,; 
                Q____E With nQ____E,; 
                Q_DATA With dQ_DATA,; 
                F____A With nF____A,; 
                F____B With nF____B,; 
                F____C With nF____C,; 
                F____D With nF____D,; 
                F____E With nF____E,; 
                F_DATA With dF_DATA,; 
                T____A With nT____A,; 
                T____B With nT____B,; 
                T____C With nT____C,; 
                T____D With nT____D,; 
                T____E With nT____E,; 
                P____A With nP____A,; 
                P____B With nP____B,; 
                P____C With nP____C,; 
                P____D With nP____D,; 
                P____E With nP____E,; 
                P_DATA With dP_DATA 
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
 
