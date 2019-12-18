// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
/* 
**      Modulo - VPC875000 
**  Finalidade - Cadastro DE Agencias (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc87800()
#endif

loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
if !fdbusevpb(_COD_AGENCIA,2) 
   return nil 
endif 
dbgotop() 
SetCursor(1) 
VPBOX(04,29,19,76," Cadastro de Agencias ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,30,18,75) 
oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 3, 0 ) + " " + DESCRI + " " + STRZERO( Banco_, 3, 0 ) + " " + NUMERO })) 
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
      case TECLA==K_INS        ;INCLUIAgencia(oTAB) 
      case TECLA==K_ENTER      ;ALTERAAgencia(oTAB) 
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
stat func incluiAgencia(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=0, cDESCRI:=Spac(30), cGerAdm:= Space(30), cGerFin:= Space(30),; 
     cFones_:= Space(30), cContat:= Space( 30 ), cEndere:= Space( 35 ),; 
     cCidade:= Space(30), cCodCep:= Space( 8 ), cNumero:= Space( 10 ), nBanco_:= 0,; 
     cEstado:= Space(2) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 14, 74, "Agencia", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
DBGOBOTTOM() 
Whil LastKey()<>K_ESC 
   nCodigo:= Codigo + 1 
   @ 03,16 Say "Codigo......:" Get nCODIGO PICT "999" When; 
     Mensagem( "Digite o Codigo.") 
   @ 04,16 Say "Banco.......:" Get nBanco_ Pict "999" Valid PesqBco( @nBanco_ ) when; 
     Mensagem( "Digite o codigo do banco." ) 
   @ 05,16 Say "N§ Agencia..:" Get cNumero When; 
     Mensagem( "Digite o numero da agencia cfe. tabela fornecida pelo banco." ) 
   @ 06,16 Say "Descricao...:" Get cDESCRI When; 
     Mensagem( "Digite a descricao da Agencia." ) 
   @ 07,16 Say "Gerente Adm.:" Get cGerAdm When; 
     Mensagem( "Digite o nome do gerente administrativo." ) 
   @ 08,16 Say "Gerente Fin.:" Get cGerFin When; 
     MEnsagem( "Digite o nome do gerente financeiro ou adjunto." ) 
   @ 09,16 Say "Endereco....:" Get cEndere When; 
     Mensagem( "Digite o endereco da agencia." ) 
   @ 10,16 Say "Cidade......:" Get cCidade When; 
     Mensagem( "Digite a cidade da agencia." ) 
   @ 11,16 Say "Estado......:" Get cEstado Valid VERUF( @cEstado ) When; 
     Mensagem( "Digite o estado da agencia." ) 
   @ 12,16 Say "Cep.........:" Get cCodCep Pict "@R 99.999-999" When; 
     Mensagem( "Digite o cep da agencia." ) 
   @ 13,16 Say "Contato.....:" Get cContat When; 
     Mensagem( "Digite o contato nesta agencia." ) 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If NetRlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI,; 
              GERADM With cGerAdm,; 
              GERFIN With cGerFin,; 
              NUMERO With cNumero,; 
              BANCO_ With nBanco_,; 
              ENDERE With cEndere,; 
              CIDADE With cCidade,; 
              ESTADO With cEstado,; 
              CODCEP With cCodCep,; 
              CONTAT With cContat,; 
              FONES_ With cFones_ 
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
stat func alteraAgencia(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=CODIGO, cDESCRI:=DESCRI, cGerAdm:= GERADM, cGerFin:= GERFIN,; 
     cFones_:=FONES_, cContat:=CONTAT, cEndere:= ENDERE,; 
     cCidade:=CIDADE, cCodCep:=CODCEP, cNumero:= NUMERO, nBanco_:= BANCO_,; 
     cEstado:=ESTADO 
 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 15, 14, 74, "Agencia", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
   @ 03,16 Say "Codigo......: [" + StrZero( nCODIGO, 3, 0 ) + "]" 
   @ 04,16 Say "Banco.......:" Get nBanco_ Pict "999" Valid PesqBco( @nBanco_ ) when; 
     Mensagem( "Digite o codigo do banco." ) 
   @ 05,16 Say "N§ Agencia..:" Get cNumero When; 
     Mensagem( "Digite o numero da agencia cfe. tabela fornecida pelo banco." ) 
   @ 06,16 Say "Descricao...:" Get cDESCRI When; 
     Mensagem( "Digite a descricao da Agencia." ) 
   @ 07,16 Say "Gerente Adm.:" Get cGerAdm When; 
     Mensagem( "Digite o nome do gerente administrativo." ) 
   @ 08,16 Say "Gerente Fin.:" Get cGerFin When; 
     MEnsagem( "Digite o nome do gerente financeiro ou adjunto." ) 
   @ 09,16 Say "Endereco....:" Get cEndere When; 
     Mensagem( "Digite o endereco da agencia." ) 
   @ 10,16 Say "Cidade......:" Get cCidade When; 
     Mensagem( "Digite a cidade da agencia." ) 
   @ 11,16 Say "Estado......:" Get cEstado Valid VERUF( @cEstado ) When; 
     Mensagem( "Digite o estado da agencia." ) 
   @ 12,16 Say "Cep.........:" Get cCodCep Pict "@R 99.999-999" When; 
     Mensagem( "Digite o cep da agencia." ) 
   @ 13,16 Say "Contato.....:" Get cContat When; 
     Mensagem( "Digite o contato nesta agencia." ) 
   Read 
   If Lastkey()<>K_ESC 
      If NetRlock() 
         Repl CODIGO With nCODIGO,; 
              DESCRI With cDESCRI,; 
              GERADM With cGerAdm,; 
              GERFIN With cGerFin,; 
              NUMERO With cNumero,; 
              BANCO_ With nBanco_,; 
              ENDERE With cEndere,; 
              CIDADE With cCidade,; 
              ESTADO With cEstado,; 
              CODCEP With cCodCep,; 
              CONTAT With cContat,; 
              FONES_ With cFones_ 
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
**  Finalidade - Cadastro de agencias (Pesquisa:Browse) 
** Programador - Valmor Pereira Flores 
**        Data - Dezembro/1997 
** Atualizacao - 
*/ 
Function Agencia(nCodigo) 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, GetList:={},; 
     nOrdem:= INDEXORD(), nArea:= SELECT() 
DBSelectar(_COD_AGENCIA) 
IF !Used() 
   IF( !file( _VPB_AGENCIA ), createvpb( _COD_AGENCIA ), nil ) 
   IF !fdbusevpb( _COD_AGENCIA, 2 ) 
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
VPBOX(04,29,12,76," Cadastro de Agencias ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
Mensagem("Pressione [Enter] para selecionar n/ Cadastro.") 
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
 
