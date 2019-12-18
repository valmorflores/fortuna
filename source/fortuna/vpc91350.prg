// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
/* 
**      Modulo - VPC91320 
**  Finalidade - Inclusao, Alteracao e Exclusao de ICM 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc913500()
#endif

loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(),; 
     cCDDES 
 
if(!file(_VPB_REDUCAO),createvpb(_COD_REDUCAO),nil) 
if !fdbusevpb(_COD_REDUCAO,2) 
   return nil 
endif 
dbgotop() 
setcursor(0) 
VPBOX(04,29,12,76," Tabela de ICM ", COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,11,75) 
oTAB:addcolumn(tbcolumnnew(,{|| CODIGO+" "+DESCRI+" "+ Tran( PERRED, "@e 99.9999" ) })) 
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
      case TECLA==K_INS        ;INCLUIICM(oTAB) 
      case TECLA==K_ENTER      ;ALTERAICM(oTAB) 
      case upper(chr(TECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
           cCDDES:=chr(TECLA)+spac(39) 
           keyboard chr(K_RIGHT) 
           cTELA2:=screensave(00,00,24,79) 
           vpbox(13,29,15,76,"Pesquisa") 
           mensagem("Digite o ICM para pesquisar.") 
           @ 14,31 say "CODIGO:" get cCDDES Pict "@S35" 
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
stat func incluiICM(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=Spac(40), cCODIGO:=Spac(2), cObserv:= SPACE( 40 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 02, 15, 04, 74, " Inclusao de ICM ", _COR_GET_BOX ) 
SetCursor( 1 ) 
SetColor( _COR_GET_EDICAO ) 
Whil LastKey()<>K_ESC 
   @ 03,16 Say "CODIGO:" Get cCODIGO When; 
     MENSAGEM("Digite o CODIGO.") VALID !DBSeek( cCodigo ) 
   @ 03,26 Say "Mes:" Get cDESCRI When; 
     MENSAGEM("Digite o mes.") 
   @ 03,36 Say "Descricao:" Get cOBSERV Pict "@S25" When; 
     MENSAGEM("Digite a descricao do ICM.") 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If NetRlock() 
         Repl CODIGO With cCODIGO,; 
              DESCRI With cDESCRI,; 
              OBSERV With cOBSERV 
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
stat func alteraICM(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, cCODIGO:=CODIGO, cOBSERV:=OBSERV 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 02, 15, 04, 74, " Alteracao de ICM ", _COR_GET_BOX ) 
SetCursor( 1 ) 
SetColor( _COR_GET_EDICAO ) 
@ 03,16 Say "CODIGO:" Get cCODIGO When; 
  MENSAGEM("Digite o CODIGO.") 
@ 03,26 Say "Mes:" Get cDESCRI When; 
  MENSAGEM("Digite o mes.") 
@ 03,36 Say "Descricao:" Get cOBSERV Pict "@S25" When; 
  MENSAGEM("Digite a descricao do ICM.") 
Read 
If Lastkey()<>K_ESC 
   If NetRlock() 
      Repl CODIGO With cCODIGO,; 
           DESCRI With cDESCRI,; 
           OBSERV With cOBSERV 
   Endif 
EndIf 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
