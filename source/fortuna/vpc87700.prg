// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/* 
**      Modulo - VPC875000 
**  Finalidade - TABELA DE Hist�ricos (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc87700()
#endif

loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
if !fdbusevpb(_COD_HISTORICO,2) 
   return nil 
endif 
dbgotop() 
SetCursor(1) 
VPBOX(04,29,16,76," Tabela de Hist�ricos ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,15,75) 
oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 3, 0 ) + " " + DESCRI + " " + Tran( VALORP, "@E 9999,999.99" ) })) 
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
      case TECLA==K_INS        ;INCLUIHistorico(oTAB) 
      case TECLA==K_ENTER      ;ALTERAHistorico(oTAB) 
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
stat func incluiHistorico(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=0, cDESCRI:=Spac(30), nValorP:= 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(02,15,06,74,"Historico") 
DBGOBOTTOM() 
Whil LastKey()<>K_ESC 
   nCodigo:= Codigo + 1 
   @ 03,16 Say "Codigo......:" Get nCODIGO PICT "999" When; 
     MENSAGEM("Digite o Codigo.") 
   @ 04,16 Say "Descricao...:" Get cDESCRI When; 
     MENSAGEM("Digite a descricao do Historico.") 
   @ 05,16 Say "Valor Padrao:" Get nValorP Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite um valor padrao para este hist�rico." ) 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI,; 
              VALORP With nValorP 
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
stat func alteraHistorico(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, nCodigo:=Codigo, nValorP:= ValorP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 06, 74,"Historico") 
@ 03,16 Say "Codigo......: [" + StrZero( nCODIGO, 3, 0 ) + "]" 
@ 04,16 Say "Descricao...:" Get cDESCRI When; 
  MENSAGEM("Digite a descricao do Historico.") 
@ 05,16 Say "Valor Padrao:" Get nValorP Pict "@E 999,999,999.99" when; 
  Mensagem( "Digite um valor padrao para este hist�rico." ) 
Read 
If Lastkey()<>K_ESC 
   If netrlock() 
      Repl CODIGO With nCODIGO 
      Repl DESCRI With cDESCRI 
      Repl VALORP With nValorP 
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
**      Modulo - 
**  Finalidade - TABELA DE DESCRICAO (Pesquisa:Browse) 
** Programador - Valmor Pereira Flores 
**        Data - Dezembro/1997 
** Atualizacao - 
*/ 
Function Historico(nCodigo) 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, GetList:={},; 
     nOrdem:= INDEXORD(), nArea:= SELECT() 
DBSelectar(_COD_HISTORICO) 
IF !Used() 
   IF( !file( _VPB_HISTORICO ), createvpb( _COD_HISTORICO ), nil ) 
   IF !fdbusevpb( _COD_HISTORICO, 2 ) 
      DBSELECTAR( nArea ) 
      DBSETORDER( nOrdem ) 
      RETURN(.F.) 
   ENDIF 
ENDIF 
DBSETORDER(1) 
IF DBSEEK(nCodigo) 
   DBSELECTAR( nArea ) 
   DBSETORDER( nOrdem ) 
   RETURN(.T.) 
ENDIF 
DBGOTOP() 
SetCursor(1) 
VPBOX(04,29,12,76," Tabela de Hist�ricos ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
Mensagem("Pressione [Enter] para selecionar n/ tabela.") 
Ajuda("[A a Z]Pesquisa ["+_SETAS+"][PgUp][PgDn]Move") 
oTAB:=TBrowseDB(05,30,11,75) 
oTAB:addcolumn(tbcolumnnew(,{|| CODIGO+" "+DESCRI +" "+Tran( PERCON, "@e 99.99" ) +" "+Tran( PERIND, "@e 99.99" ) })) 
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
      case TECLA==K_ENTER      ;nCodigo:= CODIGO; EXIT 
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
 
