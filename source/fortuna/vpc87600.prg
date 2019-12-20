// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/* 
**      Modulo - VPC875000 
**  Finalidade - TABELA DE ESTADOS (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/

#ifdef HARBOUR
function vpc87600()
#endif


loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
if !fdbusevpb(_COD_ESTADO,2) 
   return nil 
endif 
dbgotop() 
SetCursor(1) 
VPBOX(04,29,16,76," Tabela de Estados ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,15,75) 
oTAB:addcolumn(tbcolumnnew(,{|| ESTADO + " " + DESCRI +" "+Tran( PERCON, "@e 99.99" ) +" "+Tran( PERIND, "@e 99.99" ) })) 
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
      case upper(chr(TECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
           cCDDES:=chr(TECLA)+spac(39) 
           keyboard chr(K_RIGHT) 
           cTELA2:=screensave(00,00,24,79) 
           vpbox(13,29,15,76,"Pesquisa") 
           mensagem("Digite a conta para pesquisar.") 
           @ 14,31 say "Conta:" get cCDDES Pict "@S33" 
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
stat func incluiATIVIDADE(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cESTADO:=0, cDESCRI:=Spac(40) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(02,15,05,74) 
DBGOBOTTOM() 
cESTADO:=SPACE( 2 ) 
Whil LastKey()<>K_ESC 
   @ 03,16 Say "ESTADO:" Get cESTADO PICT "!!" When; 
     MENSAGEM("Digite o ESTADO.") 
   @ 03,36 Say "Descricao:" Get cDESCRI Pict "@S25" When; 
     MENSAGEM("Digite a descricao da ATIVIDADE.") 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl ESTADO With cESTADO,; 
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
stat func alteraATIVIDADE(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, cESTADO:=ESTADO, nPerCon:= PERCON, nPerInd:= PERIND 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 12, 64, "Tabela de Estados / ICMs", COR[20] ) 
@ 03,16 Say "Estado...: [" + cESTADO + "]" 
@ 04,16 Say "Descricao:" Get cDESCRI Pict "@S25" When; 
  MENSAGEM("Digite a descricao da ATIVIDADE.") 
@ 05,16 Say "���������������������������������Ŀ" 
@ 06,16 Say "�           Tabela ICMs           �" 
@ 07,16 Say "���������������������������������Ĵ" 
@ 08,16 Say "� Consumo        �    [00.00] %   �" 
@ 09,16 Say "���������������������������������Ĵ" 
@ 10,16 Say "� Industria      �    [00.00] %   �" 
@ 11,16 Say "�����������������������������������" 
@ 08,38 Get nPerCon Pict "@E 99.99" 
@ 10,38 Get nPerInd Pict "@E 99.99" 
Read 
If Lastkey()<>K_ESC 
   If netrlock() 
      Repl ESTADO With cESTADO,; 
           DESCRI With cDESCRI,; 
           PERCON With nPerCon,; 
           PERIND With nPerInd 
   Endif 
EndIf 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
/* 
**      Modulo - LOCALIZAATV 
**  Finalidade - TABELA DE ESTADO (Pesquisa:Browse) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Agosto/1[20]5 
** Atualizacao - 
*/ 
STATIC function localizaAtv(nCodAtv) 
 
 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, GetList:={},; 
     nOrdem:= INDEXORD(), nArea:= SELECT() 
DBSelectar(_COD_ESTADO) 
IF !Used() 
   IF( !file( _VPB_ESTADO ), createvpb( _COD_ESTADO ), nil ) 
   IF !fdbusevpb( _COD_ESTADO, 2 ) 
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
SetCursor(1) 
VPBOX(04,29,12,76," Tabela de ESTADO ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
Mensagem("Pressione [Enter] para selecionar n/ tabela.") 
Ajuda("[A a Z]Pesquisa ["+_SETAS+"][PgUp][PgDn]Move") 
oTAB:=TBrowseDB(05,30,11,75) 
oTAB:addcolumn(tbcolumnnew(,{|| ESTADO+" "+DESCRI +" "+Tran( PERCON, "@e 99.99" ) +" "+Tran( PERIND, "@e 99.99" ) })) 
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
      case TECLA==K_ENTER      ;nCodAtv:= ESTADO; EXIT 
      case upper(chr(TECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
           cCDDES:=chr(TECLA)+spac(39) 
           keyboard chr(K_RIGHT) 
           cTELA2:=screensave(00,00,24,79) 
           vpbox(13,29,15,76,"Pesquisa") 
           mensagem("Digite a conta para pesquisar.") 
           @ 14,31 say "Ativ.:" get cCDDES Pict "@S33" 
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
Screenrest(cTELAR) 
setcolor(cCOR) 
setcursor(nCURSOR) 
DBSELECTAR( nArea ) 
DBSETORDER( nOrdem ) 
Return( ( LASTKEY()==13 ) ) 
 
