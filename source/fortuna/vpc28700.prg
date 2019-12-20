// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC28700 
� Finalidade  � Formulas de Calculo de Comissoes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/

#ifdef HARBOUR
function vpc28700()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla 
 
SetColor( _COR_BROWSE ) 
SetCursor(0) 
Mensagem("[Tab]Janela [A..Z]Pesquisa [ENTER]Seleciona") 
Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 00, 00, 13, 79, " FORMULA DE CALCULO ", _COR_GET_BOX, .F., .F. ) 
VPBOX( 14, 00, 22, 79, " Display ", _COR_BROW_BOX, .F., .F. ) 
 
SetColor( _COR_GET_EDICAO ) 
@ 02, 02 Say "Codigo.......: [  ]" 
@ 03, 02 Say "Descricao....: [                    ]" 
/* 
@ 04, 02 Say "Comissionamento�������������������������������������������������" 
@ 05, 02 Say "Grupo........: [000]  [                                        ]" 
@ 06, 02 Say "Tabela Precos: [000]  [                                        ]" 
@ 07, 02 Say "Forma Pgto...: [0000] [                                        ]" 
@ 08, 02 Say "Campo          Comissao                Pagamento " 
@ 09, 02 Say "INTERNO        [00]-[                ] [        ]" 
@ 10, 02 Say "EXTERNO        [00]-[                ] [        ]" 
*@ 11, 12 Say "Pagar: [ ] (1) Sobre as vendas que constem o codigo do vendedor." 
*@ 12, 12 Say "           (2) Sobre o todas as Vendas.                         " 
* 
*/ 
 
SetColor( _COR_BROWSE ) 
DBSelectAr( _COD_COMFORMULA ) 
 
DBLeOrdem() 
oTab:=tbrowsedb( 15, 01, 21, 78 ) 
oTab:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 2, 0 ) + " " + DESCRI + Space( 60 ) })) 
oTab:AUTOLITE:=.F. 
oTab:dehilite() 
WHILE .T. 
 
   oTab:RefreshCurrent() 
   WHILE !oTab:Stabilize() 
   ENDDO 
 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTab:stabilize() 
   enddo 
 
   SetColor( _COR_GET_CURSOR ) 
   @ 02, 18 Say StrZero( CODIGO, 2, 0 ) 
   @ 03, 18 Say DESCRI 
   SetColor( _COR_BROWSE ) 
 
   IF ( nTecla:=inkey(0) )==K_ESC 
      EXIT 
   ENDIF 
 
   do case 
      case nTecla==K_UP         ;oTab:up() 
      case nTecla==K_LEFT       ;oTab:up() 
      case nTecla==K_RIGHT      ;oTab:down() 
      case nTecla==K_DOWN       ;oTab:down() 
      case nTecla==K_PGUP       ;oTab:pageup() 
      case nTecla==K_PGDN       ;oTab:pagedown() 
      case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
      case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
      case nTecla==K_ENTER 
           AlteraFormulaComissao( oTab ) 
      case nTecla==K_INS 
           IncluiFormulaComissao( oTab ) 
      case nTecla==K_DEL 
           Exclui( oTab ) 
      case nTecla == K_F2 
           DBMudaOrdem( 1, oTab ) 
      case nTecla == K_F3 
           DBMudaOrdem( 2, oTab ) 
      case DBPesquisa( nTecla, oTab ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTab:refreshcurrent() 
   oTab:stabilize() 
 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiFormulaComissao 
� Finalidade  � Inclusao de Percentual de Comissao na Tabela 
� Parametros  � Nil 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function IncluiFormulaComissao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= CODIGO + 1, cDescri:= Space( 20 ),; 
      nPerc__:= 0, nValor:= 0 
 
  DBSetOrder( 1 ) 
  DBSeek( 999 ) 
  DBSkip( -1 ) 
  WHILE !LastKey() == K_ESC 
      nCodigo:= CODIGO + 1 
      cDescri:= Space( 20 ) 
      nPerc__:= 0 
      nValor:= 0 
      SetColor( _COR_GET_EDICAO ) 
      SetCursor( 1 ) 
      @ 02, 02 Say "Codigo.......:" Get nCodigo Pict "99" 
      @ 03, 02 Say "Comissao.....:" Get cDescri 
      READ 
      IF !LastKey() == K_ESC 
         IF DBSeek( nCodigo ) 
            DBSeek( 999 ) 
            DBSkip( -1 ) 
            nCodigo:= CODIGO + 1 
         ENDIF 
         DBAppend() 
         IF netrlock() 
            Replace CODIGO With nCodigo,; 
                    DESCRI With cDescri 
         ENDIF 
         DBUnlockAll() 
         EditFormulas() 
         SetColor( _COR_BROWSE ) 
         oTab:RefreshAll() 
         WHILE !oTab:Stabilize() 
         ENDDO 
      ENDIF 
  ENDDO 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oTab:RefreshAll() 
WHILE !oTab:Stabilize() 
ENDDO 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � AlteraFormulaComissao 
� Finalidade  � Inclusao de Percentual de Comissao na Tabela 
� Parametros  � Nil 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function AlteraFormulaComissao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cDescri:= DESCRI 
 
   SetColor( _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   @ 03, 02 Say "Descricao....:" Get cDescri 
   READ 
   IF !LastKey() == K_ESC 
      IF netrlock() 
         Replace DESCRI With cDescri 
      ENDIF 
      DBUnlockAll() 
      EditFormulas() 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
 
Static Function EditFormulas() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, nArea:= Select(), nOrdem:= IndexOrd() 
 
   VPBox( 03, 11, 13, 79, "Comissionamento", _COR_GET_BOX ) 
   VPBox( 14, 11, 20, 79, "Display", _COR_BROW_BOX ) 
   CP_->( DBSetOrder( 1 ) ) 
   nCodigo:= FML->CODIGO 
   DBSelectAr( _COD_CONDICOES ) 
   DBSetOrder( 1 ) 
   DBSelectAr( _COD_GRUPO ) 
   DBSetOrder( 1 ) 
   DBSelectAr( _COD_COMFAUX ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODIGO To INDRES00.TMP For CODIGO == nCodigo Eval {|| Processo() } 
   Set Relation To GRUPO_ Into GR0, PRECO_ Into PRE, FORMA_ Into CND 
   SetColor( _COR_GET_EDICAO ) 
   @ 04, 12 Say "Grupo........: [000]  [                                        ]" 
   @ 05, 12 Say "Tabela Precos: [000]  [                                        ]" 
   @ 06, 12 Say "Forma Pgto...: [0000] [                                        ]" 
   @ 07, 12 Say "Campo          Comissao                Pagamento " 
   @ 08, 12 Say "INTERNO        [00]-[                ] [        ]" 
   @ 09, 12 Say "EXTERNO        [00]-[                ] [        ]" 
*   @ 10, 12 Say "Pagar: [ ] (1) Sobre as vendas que constem o codigo do vendedor." 
*   @ 11, 12 Say "           (2) Sobre o todas as Vendas.                         " 
* ALBERTO Thu  03-05-01 
   SetColor( _COR_BROWSE ) 
   oTab:=tbrowsedb( 15, 12, 19, 78 ) 
   oTab:addcolumn(tbcolumnnew(,{|| StrZero( GRUPO_, 3, 0 ) + " " + ; 
                                   StrZero( PRECO_, 3, 0 ) + " " + StrZero( FORMA_, 4, 0 ) + ; 
                                   "    Comissoes-> " + STRZERO( INTERN, 2, 0 ) + " " + ; 
                                   FORMAI + " " + ; 
                                   StrZero( EXTERN, 2, 0 ) + " " + FORMAE + "  " + BASESB + Space( 40 ) })) 
   oTab:AUTOLITE:=.F. 
   oTab:dehilite() 
   WHILE .T. 
 
      oTab:RefreshCurrent() 
      WHILE !oTab:Stabilize() 
      ENDDO 
 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab:stabilize() 
      enddo 
 
      SetColor( _COR_GET_CURSOR ) 
      @ 04, 28 Say StrZero( GRUPO_, 3, 0 ) 
      @ 04, 35 Say Left( GR0->DESCRI, 40 ) 
      @ 05, 28 Say StrZero( PRECO_, 3, 0 ) 
      @ 05, 35 Say Left( PRE->DESCRI, 40 ) 
      @ 06, 28 Say StrZero( FORMA_, 4, 0 ) 
      @ 06, 35 Say Left( CND->DESCRI, 40 ) 
      @ 08, 28 Say StrZero( INTERN, 2, 0 ) 
      @ 09, 28 Say StrZero( EXTERN, 2, 0 ) 
      @ 08, 52 Say IF( LEFT( FORMAI, 1 ) == "1", "Emissao ", "Quitacao" ) 
      @ 09, 52 Say IF( LEFT( FORMAE, 1 ) == "1", "Emissao ", "Quitacao" ) 
        CP_->( DBSeek( CA_->INTERN ) ) 
      @ 08, 33 Say Left( CP_->DESCRI, 16 ) 
        CP_->( DBSeek( CA_->EXTERN ) ) 
      @ 09, 33 Say Left( CP_->DESCRI, 16 ) 
      @ 10, 20 Say LEFT( BASESB, 1 ) 
      SetColor( _COR_BROWSE ) 
 
      IF ( nTecla:=inkey(0) )==K_ESC 
         EXIT 
      ENDIF 
 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:up() 
         case nTecla==K_RIGHT      ;oTab:down() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_ENTER 
              nGrupo_:= GRUPO_ 
              nPreco_:= PRECO_ 
              nIntern:= INTERN 
              cFormaI:= Left( FORMAI, 1 ) 
              nExtern:= EXTERN 
              cFormaE:= Left( FORMAE, 1 ) 
              cPagar:=  Left( BASESB, 1 ) 
              nForma_:= FORMA_ 
              SetColor( _COR_GET_EDICAO ) 
              @ 04,27 Get nGrupo_ Pict "@E 999" 
              @ 05,27 Get nPreco_ Pict "@E 999" 
              @ 06,27 Get nForma_ Pict "@E 9999" 
              @ 08,27 Get nIntern Pict "99" 
              @ 08,51 Get cFormaI Pict "9" 
              @ 09,27 Get nExtern Pict "99" 
              @ 09,51 get cFormaE Pict "9" 
              READ 
              IF !LastKey() == K_ESC 
                 IF netrlock() 
                    Replace GRUPO_ With nGrupo_,; 
                            PRECO_ With nPreco_,; 
                            INTERN With nIntern,; 
                            FORMAI With cFormaI,; 
                            EXTERN With nExtern,; 
                            FORMAE With cFormaE,; 
                            BASESB With cPagar,; 
                            CODIGO With nCodigo,; 
                            FORMA_ With nForma_ 
                 ENDIF 
              ENDIF 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         case nTecla==K_INS 
              nGrupo_:= 999 
              nPreco_:= 999 
              nPreco_:= 0 
              nIntern:= 0 
              nPrazoI:= 0 
              cFormaI:= " " 
              nExtern:= 0 
              nPrazoE:= 0 
              cFormaE:= " " 
              cPagar:= "1" 
              nForma_:= 9999 
              SetColor( _COR_GET_EDICAO ) 
              @ 04,27 Get nGrupo_ Pict "@E 999" 
              @ 05,27 Get nPreco_ Pict "@E 999" 
              @ 06,27 Get nForma_ Pict "@E 9999" 
              @ 08,27 Get nIntern Pict "99" 
              @ 08,51 Get cFormaI Pict "9" 
              @ 09,27 Get nExtern Pict "99" 
              @ 09,51 get cFormaE Pict "9" 
              READ 
              IF !LastKey() == K_ESC 
                 DBAppend() 
                 IF netrlock() 
                    Replace GRUPO_ With nGrupo_,; 
                            PRECO_ With nPreco_,; 
                            INTERN With nIntern,; 
                            FORMAI With cFormaI,; 
                            EXTERN With nExtern,; 
                            FORMAE With cFormaE,; 
                            BASESB With cPagar,; 
                            CODIGO With nCodigo,; 
                            FORMA_ With nForma_ 
                 ENDIF 
              ENDIF 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         case nTecla==K_DEL 
              Exclui( oTab ) 
         case nTecla == K_F2 
              DBMudaOrdem( 1, oTab ) 
         case nTecla == K_F3 
              DBMudaOrdem( 2, oTab ) 
         case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
 
   enddo 
   DBSelectAr( _COD_COMFAUX ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/ca_ind01.ntx", "&gdir/ca_ind02.ntx"   
   #else 
     Set Index To "&GDir\CA_IND01.NTX", "&GDir\CA_IND02.NTX"   
   #endif
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
