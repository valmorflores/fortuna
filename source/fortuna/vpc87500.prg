// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/* 
**      Modulo - VPC875000 
**  Finalidade - TABELA DE ATIVIDADES (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc87500()
#endif

loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
if(!file(_VPB_ATIVIDADES),createvpb(_COD_ATIVIDADES),nil) 
if !fdbusevpb(_COD_ATIVIDADES,2) 
   return nil 
endif 
dbgotop() 
setcursor(0) 
DBLeOrdem() 
VPBOX(04,29,21,76," Tabela de Atividades ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,20,75) 
oTAB:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,4,0)+" "+DESCRI })) 
oTAB:AUTOLITE:=.F. 
oTAB:dehilite() 
whil .t. 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTAB:stabilize() 
   enddo 
   if ( TECLA:=inkey(0) )==K_ESC 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oTAB:up() 
      case TECLA==K_LEFT       ;oTAB:up() 
      case TECLA==K_RIGHT      ;oTAB:down() 
      case TECLA==K_DOWN       ;oTAB:down() 
      case TECLA==K_PGUP       ;oTAB:pageup() 
      case TECLA==K_PGDN       ;oTAB:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
      case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
      case TECLA==K_DEL 
           lDELETE:=.T. ;if(netrlock(5),exclui(oTAB),nil) 
      case TECLA==K_INS        ;INCLUIATIVIDADE(oTAB) 
      case TECLA==K_ENTER      ;ALTERAATIVIDADE(oTAB) 
      case TECLA==K_F2         ;DBMudaOrdem( 1, oTab ) 
      case TECLA==K_F3         ;DBMudaOrdem( 2, oTab ) 
      case DBPesquisa( TECLA, oTab ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
enddo 
dbunlockall() 
FechaArquivos() 
screenrest(cTELAR) 
setcolor(cCOR) 
setcursor(nCURSOR) 
return nil 
 
 
** 
Stat Func IncluiATIVIDADE(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=0, cDESCRI:=Spac(40) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 05, 74, "INCLUSAO DE ATIDADES DE CLIENTES",_COR_GET_BOX) 
SetColor( _COR_GET_EDICAO ) 
DBSetOrder( 1 ) 
DBGOBOTTOM() 
nCODIGO:=CODIGO 
Whil LastKey()<>K_ESC 
   VPBOX( 02, 15, 05, 74, , _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   ++nCODIGO 
   @ 03,16 Say "Codigo:" Get nCODIGO PICT "9999" When; 
     MENSAGEM("Digite o Codigo.") 
   @ 03,36 Say "Descricao:" Get cDESCRI Pict "@S25" When; 
     MENSAGEM("Digite a descricao da ATIVIDADE.") 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI 
      Endif 
   EndIf 
   oObj:refreshAll() 
   WHILE !oObj:Stabilize() 
   ENDDO 
EndDo 
DBLeOrdem() 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
** 
stat func alteraATIVIDADE(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, nCODIGO:=CODIGO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(01,15,04,74,"ALTERACAO DE ATIVIDADES DE CLIENTES",_COR_GET_BOX) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
@ 03,16 Say "Codigo: [" + StrZero( nCODIGO, 3, 0 ) + "]" 
@ 03,36 Say "Descricao:" Get cDESCRI Pict "@S25" When; 
  MENSAGEM("Digite a descricao da ATIVIDADE.") 
Read 
If Lastkey()<>K_ESC 
   If netrlock() 
      Repl CODIGO With nCODIGO,; 
           DESCRI With cDESCRI 
   Endif 
EndIf 
ScreenRest( cTELA ) 
SetColor( cCOR ) 
SetCursor( nCURSOR ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
/* 
**      Modulo - LOCALIZAATV 
**  Finalidade - TABELA DE ATIVIDADES (Pesquisa:Browse) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Agosto/1995 
** Atualizacao - 
*/ 
function localizaAtv(nCodAtv) 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, GetList:={},; 
     nOrdem:= INDEXORD(), nArea:= SELECT() 
IF LastKey() == K_UP .OR. LastKey() == K_DOWN 
   Return .T. 
ENDIF 
DBSelectar(_COD_ATIVIDADES) 
IF !Used() 
   IF( !file( _VPB_ATIVIDADES ), createvpb( _COD_ATIVIDADES ), nil ) 
   IF !fdbusevpb( _COD_ATIVIDADES, 2 ) 
      DBSELECTAR( nArea ) 
      DBSETORDER( nOrdem ) 
      RETURN(.F.) 
   ENDIF 
ENDIF 
DBSETORDER(1) 
IF DBSEEK(nCodAtv) 
   DBSELECTAR( nArea ) 
   DBSETORDER( nOrdem ) 
   RETURN(.T.) 
ENDIF 
DBGOTOP() 
DBLeOrdem() 
setcursor(0) 
VPBOX(04,29,16,76," Tabela de Atividades ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
Mensagem("Pressione [Enter] para selecionar n/ tabela.") 
Ajuda("[A a Z]Pesquisa ["+_SETAS+"][PgUp][PgDn]Move") 
oTAB:=TBrowseDB(05,30,15,75) 
oTAB:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,4,0)+" "+DESCRI })) 
oTAB:AUTOLITE:=.F. 
oTAB:dehilite() 
whil .t. 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTAB:stabilize() 
   enddo 
   if ( TECLA:=inkey(0) )==K_ESC 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oTAB:up() 
      case TECLA==K_LEFT       ;oTAB:up() 
      case TECLA==K_RIGHT      ;oTAB:down() 
      case TECLA==K_DOWN       ;oTAB:down() 
      case TECLA==K_PGUP       ;oTAB:pageup() 
      case TECLA==K_PGDN       ;oTAB:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
      case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
      case TECLA==K_ENTER      ;nCodAtv:= CODIGO; EXIT 
      case TECLA==K_F2         ;DBMudaOrdem( 1, oTab ) 
      case TECLA==K_F3         ;DBMudaOrdem( 2, oTab ) 
      case DBPesquisa( TECLA, oTab ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
enddo 
Screenrest(cTELAR) 
setcolor(cCOR) 
setcursor(nCURSOR) 
DBSELECTAR( nArea ) 
DBSETORDER( nOrdem ) 
Return( ( LASTKEY()==13 ) ) 
 
