// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/* 
**      Modulo - VPC91320 
**  Finalidade - Inclusao, Alteracao e Exclusao de FERIADOS 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/

#ifdef HARBOUR
function vpc91320()
#endif


loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(),; 
     cCDDES 
 
if(!file(_VPB_FERIADOS),createvpb(_COD_FERIADOS),nil) 
if !fdbusevpb(_COD_FERIADOS,2) 
   return nil 
endif 
dbgotop() 
setcursor(0) 
VPBOX(04,29,12,76," Tabela de Feriados ", COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,11,75) 
oTAB:addcolumn(tbcolumnnew(,{|| DIA___+"/"+MES___+" - "+DESCRI })) 
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
      case TECLA==K_DEL        ;lDELETE:=.T. ;if(netrlock(5),exclui(oTAB),nil) 
      case TECLA==K_INS        ;INCLUIFERIADO(oTAB) 
      case TECLA==K_ENTER      ;ALTERAFERIADO(oTAB) 
      case upper(chr(TECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
           cCDDES:=chr(TECLA)+spac(39) 
           keyboard chr(K_RIGHT) 
           cTELA2:=screensave(00,00,24,79) 
           vpbox(13,29,15,76,"Pesquisa") 
           mensagem("Digite o feriado para pesquisar.") 
           @ 14,31 say "Dia:" get cCDDES Pict "@S35" 
           read 
           oTAB:gotop() 
           dbsetorder(2) 
           dbseek(cCDDES,.T.) 
           screenrest(cTELA2) 
           oTAB:refreshall() 
           whil !oTAB:stabilize() 
           enddo 
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
stat func incluiferiado(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=Spac(40), cDIA___:=Spac(2), cMES___:=Spac(2) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 02, 15, 04, 74, " Inclusao de Feriados ", _COR_GET_BOX ) 
SetCursor( 1 ) 
SetColor( _COR_GET_EDICAO ) 
Whil LastKey()<>K_ESC 
   @ 03,16 Say "Dia:" Get cDIA___ When; 
     MENSAGEM("Digite o dia.") 
   @ 03,26 Say "Mes:" Get cMES___ When; 
     MENSAGEM("Digite o mes.") 
   @ 03,36 Say "Descricao:" Get cDESCRI Pict "@S25" When; 
     MENSAGEM("Digite a descricao do feriado.") 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl DIA___ With cDIA___,; 
              MES___ With cMES___,; 
              DESCRI With cDESCRI 
      Endif 
   EndIf 
EndDo 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
** 
stat func alteraferiado(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, cDIA___:=DIA___, cMES___:=MES___ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 02, 15, 04, 74, " Alteracao de Feriados ", _COR_GET_BOX ) 
SetCursor( 1 ) 
SetColor( _COR_GET_EDICAO ) 
@ 03,16 Say "Dia:" Get cDIA___ When; 
  MENSAGEM("Digite o dia.") 
@ 03,26 Say "Mes:" Get cMES___ When; 
  MENSAGEM("Digite o mes.") 
@ 03,36 Say "Descricao:" Get cDESCRI Pict "@S25" When; 
  MENSAGEM("Digite a descricao do feriado.") 
Read 
If Lastkey()<>K_ESC 
   If netrlock() 
      Repl DIA___ With cDIA___,; 
           MES___ With cMES___,; 
           DESCRI With cDESCRI 
   Endif 
EndIf 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
