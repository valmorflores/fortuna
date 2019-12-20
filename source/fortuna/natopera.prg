// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/* 
**      Modulo - VPC875000 
**  Finalidade - Tabela de N. Operacao (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
  function natopera()
#endif


loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
if(!file(_VPB_NATOPERA),createvpb(_COD_NATOPERA),nil) 
if !fdbusevpb(_COD_NATOPERA,2) 
   return nil 
endif 
dbgotop() 
setcursor(0) 
VPBOX(04,29,18,76," Tabela de N. Operacao ", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
SetColor( _COR_BROWSE ) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,17,75) 
oTAB:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,6,3)+" "+DESCRI })) 
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
      case TECLA==K_INS        ;INCLUINatOpera(oTAB) 
      case TECLA==K_ENTER      ;ALTERANatOpera(oTAB) 
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
stat func incluiNatOpera(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=0, cDESCRI:=Spac(40), cEntSai:= "*" 
VPBox( 03, 15, 09, 74, "Natureza da Operacao (Inclusao)", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
Whil LastKey()<>K_ESC 
   ++nCODIGO 
   @ 05,16 Say "Codigo.......:" Get nCODIGO PICT "99.999" Valid PesqNatOpera( nCodigo ) When; 
     Mensagem("Digite o Codigo.") 
   @ 06,16 Say "Descricao....:" Get cDESCRI When; 
     Mensagem("Digite a descricao.") 
   @ 07,16 Say "Entrada/Saida:" Get cEntSai Pict "!" Valid cEntSai $ "ES" When; 
     Mensagem( "Digite [E] para Entrada ou [S] para sa�da..." ) 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI,; 
              ENTSAI With IF( cEntSai=="E", "ENT", "SAI" ) 
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
stat func alteraNatOpera(oOBJ) 
   Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
        cCOR:=SetColor() 
   LOCAL cDESCRI:=DESCRI, nCODIGO:=CODIGO, cEntSai:= Left( ENTSAI, 1 ) 
   VPBox( 03, 15, 09, 74, "Natureza da Operacao (Inclusao)", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
   SetColor( _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   @ 05,16 Say "Codigo.......: [" + StrZero( nCODIGO, 6, 3 ) + "]" 
   @ 06,16 Say "Descricao....:" Get cDESCRI When; 
     Mensagem("Digite a descricao.") 
   @ 07,16 Say "Entrada/Saida:" Get cEntSai Pict "!" Valid cEntSai $ "ES" When; 
     Mensagem( "Digite [E] para Entrada ou [S] para sa�da..." ) 
   Read 
   If Lastkey()<>K_ESC 
      If netrlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI,; 
              ENTSAI With IF( cENTSAI=="S", "SAI", "ENT" ) 
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
**  Finalidade - Tabela de N. Operacao (Pesquisa:Browse) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Agosto/1995 
** Atualizacao - 
*/ 
function localIZA22(nCodAtv) 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, GetList:={},; 
     nOrdem:= INDEXORD(), nArea:= SELECT() 
DBSelectar(_COD_NATOPERA) 
IF !Used() 
   IF( !file( _VPB_NATOPERA ), createvpb( _COD_NATOPERA ), nil ) 
   IF !fdbusevpb( _COD_NATOPERA, 2 ) 
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
setcursor(0) 
VPBOX(04,29,12,76," Tabela de N. Operacao ",COR[16],.T.,.T.) 
setcolor( _COR_BROWSE ) 
Mensagem("Pressione [Enter] para selecionar n/ tabela.") 
Ajuda("[A a Z]Pesquisa ["+_SETAS+"][PgUp][PgDn]Move") 
oTAB:=TBrowseDB( 05, 30, 11, 75 ) 
oTAB:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO, 6, 3)+" "+DESCRI })) 
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
 
/* 
* Funcao      - PesqNatOpera 
* Finalidade  - Ver se j� existe o codigo digitado 
* Parametro   - Codigo 
* Retorno     - lFlag=> Verdadeiro se nao existe ; Falso se existe 
* Programador - Valmor Pereira Flores 
* Data        - 07/Marco/1996 
*/ 
Static Function PesqNatOpera( nCodigo ) 
  LOCAL cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 ),; 
        nCursor:= SetCursor(), lFlag:= .T. 
 
  /* Pesquisa o codigo */ 
  IF DBSeek( nCodigo ) 
 
     /* Se nao encontrar */ 
     SetCursor( 1 ) 
     Aviso( "Natureza da Operacao J� cadastrada...", 24 /2 ) 
     Mensagem( "Pressione ENTER para retornar a edicao." ) 
     Pausa() 
     lFlag:= .F. 
 
  ENDIF 
 
  /* Restaura */ 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return( lFlag ) 
