// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � RECEITAS / DESPESAS (Fichas de Movimentacao Financeira) 
� Finalidade  � Cadastro das Contas de Receita / Despesa 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 

#ifdef HARBOUR
function vpc70000()
#endif


loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, nTela:= 1 
Local oTab2 
if(!file(_VPB_FORNECEDOR),createvpb(_COD_FORNECEDOR),nil) 
if !fdbusevpb(_COD_DESPESAS,2) 
   return nil 
endif 
dbgotop() 
setcursor(0) 
VPBOX( 04, 29, 12, 76, " Fichas de Despesa ", COR[20], .T., .T. ) 
VPBOX( 13, 29, 21, 76, " Fichas de Receita ", COR[20], .T., .T. ) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[Tab]Janela [INS]Inclui [ENTER]Altera [DEL]Exclui e [A..Z]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
Keyboard Chr( K_TAB ) + Chr( K_TAB ) 
DBSelectAr( _COD_DESPESAS ) 
DBLeOrdem() 
DBGoTop() 
oTAB:=tbrowsedb(05,30,11,75) 
oTAB:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,4,0)+" "+DESCRI })) 
oTAB:AUTOLITE:=.F. 
oTAB:dehilite() 
DBSelectAr( _COD_RECEITAS ) 
DBLeOrdem() 
DBGoTop() 
oTAB2:=tbrowsedb(14,30,20,75) 
oTAB2:addcolumn(tbcolumnnew(,{|| STRZERO(REC->CODIGO,4,0)+" "+REC->DESCRI })) 
oTAB2:AUTOLITE:=.F. 
oTAB2:dehilite() 
DBSelectAr( _COD_DESPESAS ) 
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
         DBSelectAr( _COD_DESPESAS ) 
      ELSE 
         oTAB:refreshAll() 
         WHILE !oTab:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_RECEITAS ) 
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
         case nTecla==K_DEL 
              IF _FIELD->TIPO__="1" 
                 cTELA0:=SCREENSAVE(00,00,24,79) 
                 Aviso("Este item s� podera ser excluido atravez do modulo de fornecedores.",13) 
                 mensagem("Pressione [ENTER] para continuar....") 
                 Pausa() 
                 SCREENREST(cTELA0) 
              ELSE 
                 lDELETE:=.T. ;if(netrlock(5),exclui(oTAB),nil) 
              ENDIF 
         case nTecla==K_INS         ;INCLUIdespesa(oTAB) 
         case nTecla==K_ENTER 
              IF _FIELD->TIPO__="1" 
                 cTELA0:=SCREENSAVE(00,00,24,79) 
                 Aviso("Este item s� podera ser alterado atravez do modulo de fornecedores.",13) 
                 mensagem("Pressione [ENTER] para continuar....") 
                 Pausa() 
                 SCREENREST(cTELA0) 
              ELSE 
                 ALTERAdespesa(oTAB) 
              ENDIF 
         case nTecla == K_F2 
              DBMudaOrdem( 1, oTab ) 
         case nTecla == K_F3 
              DBMudaOrdem( 2, oTab ) 
         case DBPesquisa( nTecla, oTab ) 
         case nTecla==K_TAB 
 
         otherwise                ;tone(125); tone(300) 
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
         case nTecla==K_DEL 
              Exclui( oTab2 ) 
         case nTecla==K_INS 
              IncluiReceita( oTab2 ) 
         case nTecla==K_ENTER 
              AlteraReceita( oTab2 ) 
         case nTecla == K_F2 
              DBMudaOrdem( 1, oTab2 ) 
         case nTecla == K_F3 
              DBMudaOrdem( 2, oTab2 ) 
         case DBPesquisa( nTecla, oTab2 ) 
 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab2:refreshcurrent() 
      oTab2:stabilize() 
   ENDIF 
enddo 
dbunlockall() 
FechaArquivos() 
dbunlockall() 
/* Fecha arquivos de fornecedor e despesas, 
   para corrigir um defeito detectado no 
   cliente PONTOSUL Relogios, onde toda a vez 
   que fosse cadastrado novo fornecedor o 
   arquivo de indice ficava baguncado */ 
DBSelectAr( _COD_FORNECEDOR ) 
DBCloseArea() 
DBSelectAr( _COD_DESPESAS ) 
DBCloseArea() 
FdbUsevpb( _COD_FORNECEDOR, 2, Nil, .T. ) 
FdbUsevpb( _COD_DESPESAS, 2, Nil ) 
ScreenRest( cTELAR ) 
SetColor( cCOR ) 
SetCursor( nCURSOR ) 
return nil 
 
 
** 
stat func incluidespesa(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=0, cDESCRI:=Spac(40), cANTPOS:=" " 
Loca nOrdem:= IndexOrd() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 05, 74, "Inclui Despesa", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
dbSetOrder( 1 ) 
DBGOBOTTOM() 
nCODIGO:=CODIGO 
Whil LastKey()<>K_ESC 
     cDESCRI:=Space( 40 ) 
     cANTPOS:=Space( 1 ) 
   ++nCODIGO 
   @ 03,16 Say "Codigo:" Get nCODIGO PICT "9999" When; 
     MENSAGEM("Digite o Codigo.") 
   @ 03,36 Say "Descricao:" Get cDESCRI Pict "@!S25" When; 
     MENSAGEM("Digite a descricao da despesa.") 
   @ 04,16 Say "A/P:" get cANTPOS PICT "!" When; 
    mensagem("Pagamento em caso de feriado: [A]Anterior, [P]Posterior."); 
     valid cANTPOS$"AP " 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI,; 
              TIPO__ With "0",; 
              ANTPOS With cANTPOS 
      Endif 
   EndIf 
EndDo 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
DBSetOrder( nOrdem ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiReceita 
� Finalidade  � Inclusao de uma nova ficha de receita 
� Parametros  � otab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function incluiReceita( oObj ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= 0, cDescri:= Spac(40), cANTPOS:=" ", nOrdem:= IndexOrd() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 05, 74, "INCLUI RECEITA", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
DBSetOrder( 1 ) 
DBGOBOTTOM() 
nCODIGO:=CODIGO 
Whil LastKey()<>K_ESC 
   ++nCODIGO 
   @ 03,16 Say "Codigo:" Get nCODIGO PICT "9999" When; 
     MENSAGEM("Digite o Codigo.") 
   @ 03,36 Say "Descricao:" Get cDESCRI Pict "@!S25" When; 
     MENSAGEM("Digite a descricao da despesa.") 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI 
      Endif 
   EndIf 
EndDo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSetOrder( nOrdem ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � AlteraReceita 
� Finalidade  � Alteracao de uma conta de Receita 
� Parametros  � otab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function AlteraReceita( oObj ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= CODIGO, cDescri:= DESCRI, cANTPOS:=" " 
VPBOX( 02, 15, 05, 74, "ALTERA RECEITA", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
@ 03,16 Say "Codigo: [" + StrZero( CODIGO, 3, 0 ) + "]" 
@ 03,36 Say "Descricao:" Get cDESCRI Pict "@!S25" When; 
  MENSAGEM("Digite a descricao da despesa.") 
Read 
If Lastkey()<>K_ESC 
   If netrlock() 
       Repl DESCRI With cDESCRI 
   Endif 
EndIf 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
** 
stat func alteraDESPESA(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, nCODIGO:=CODIGO, cANTPOS:=ANTPOS 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 05, 74, "Altera Despesa", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
@ 03,16 Say "Codigo: ["+StrZero(nCODIGO,3,0)+"]" 
@ 03,36 Say "Descricao:" Get cDESCRI Pict "@!S25" When; 
  MENSAGEM("Digite a descricao da despesa.") 
@ 04,16 Say "A/P:" get cANTPOS PICT "!" When; 
 mensagem("Pagamento em caso de feriado: [A]Anterior, [P]Posterior."); 
 valid cANTPOS$"AP " 
Read 
If Lastkey()<>K_ESC 
   If netrlock() 
      Repl CODIGO With nCODIGO,; 
           DESCRI With cDESCRI,; 
           ANTPOS With cANTPOS 
   Endif 
EndIf 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
