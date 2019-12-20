// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC28600 
� Finalidade  � Cadastro de Percentuais para Calculo de Comissoes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc28600()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla 
 
SetColor( _COR_BROWSE ) 
SetCursor(0) 
Mensagem("[Tab]Janela [A..Z]Pesquisa [F11]Extrato [F10]MovAtual [ENTER]Seleciona") 
Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 00, 00, 10, 79, " % Calculo de Comissoes ", _COR_GET_BOX, .F., .F. ) 
VPBOX( 11, 00, 22, 79, " Display ", _COR_BROW_BOX, .F., .F. ) 
 
SetColor( _COR_GET_EDICAO ) 
@ 02, 02 Say "Codigo.......: [  ]" 
@ 03, 02 Say "Comissao.....: [                    ]" 
@ 04, 02 Say "% Calculo....: [      ]" 
@ 05, 02 Say "Valor........: [              ]" 
//@ 06, 02 Say " " 
//@ 07, 02 Say "Grupo........: [000]-[DESCRICAO DO GRUPO DE PRODUTOS]" 
//@ 08, 02 Say "Tabela Precos: [000]-[DESCRICAO DA TABELA DE PRECOS]" 
//@ 09, 02 Say "INTERNO        Venda A Vista: [00]- " 
 
SetColor( _COR_BROWSE ) 
DBSelectAr( _COD_COMPER ) 
 
DBLeOrdem() 
oTab:=tbrowsedb( 12, 01, 21, 78 ) 
oTab:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 2, 0 )+" "+DESCRI + Tran( PERC__, "@e 999.99" ) + " " + Tran( VLR___, "@e 999,999,999.99" ) + Space( 40 ) })) 
oTab:AUTOLITE:=.F. 
oTab:dehilite() 
WHILE .T. 
 
   oTab:RefreshCurrent() 
   WHILE !oTab:Stabilize() 
   ENDDO 
 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTab:stabilize() 
   enddo 
 
   SetColor( _COR_GET_REALSE ) 
   @ 02, 18 Say StrZero( CODIGO, 2, 0 ) 
   @ 03, 18 Say DESCRI 
   @ 04, 18 Say Tran( PERC__, "@e 999.99" ) 
   @ 05, 18 Say Tran( VLR___, "@E 999,999,999.99" ) 
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
           AlteraPerComissao( oTab ) 
      case nTecla==K_INS 
           IncluiPerComissao( oTab ) 
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
� Funcao      � IncluiPerComissao 
� Finalidade  � Inclusao de Percentual de Comissao na Tabela 
� Parametros  � Nil 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function IncluiPerComissao( oTab ) 
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
      @ 04, 02 Say "% Calculo....:" Get nPerc__ Pict "@E 999.99" 
      @ 05, 02 Say "Valor........:" Get nValor  Pict "@E 999,999,999.99" 
      READ 
      IF !LastKey() == K_ESC 
         IF Confirma( 0, 0, "Confirma?", "Confirma [S/N]?", "S" ) 
            IF DBSeek( nCodigo ) 
               DBSeek( 999 ) 
               DBSkip( -1 ) 
               nCodigo:= CODIGO + 1 
            ENDIF 
            DBAppend() 
            IF netrlock() 
               Replace CODIGO With nCodigo,; 
                       DESCRI With cDescri,; 
                       PERC__ With nPerc__,; 
                       VLR___ With nValor 
            ENDIF 
            SetColor( _COR_BROWSE ) 
            oTab:RefreshAll() 
            WHILE !oTab:Stabilize() 
            ENDDO 
         ENDIF 
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
� Funcao      � AlteraPerComissao 
� Finalidade  � Inclusao de Percentual de Comissao na Tabela 
� Parametros  � Nil 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function AlteraPerComissao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cDescri:= DESCRI, nPerc__:= PERC__, nValor:= VLR___ 
 
   SetColor( _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   @ 03, 02 Say "Comissao.....:" Get cDescri 
   @ 04, 02 Say "% Calculo....:" Get nPerc__ Pict "@E 999.99" 
   @ 05, 02 Say "Valor........:" Get nValor  Pict "@E 999,999,999.99" 
   READ 
   IF !LastKey() == K_ESC 
      IF netrlock() 
         Replace DESCRI With cDescri,; 
                 PERC__ With nPerc__,; 
                 VLR___ With nValor 
      ENDIF 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
