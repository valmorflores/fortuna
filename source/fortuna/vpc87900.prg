// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/* 
**      Modulo - VPC87900 
**  Finalidade - Cadastro DE contas (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc87900()
#endif

loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,;
     dDATA1:=dDATA2:=date(), cTELA0 
if !fdbusevpb(_COD_CONTA,2) 
   return nil 
endif 
dbgotop() 
SetCursor(1) 
VPBOX(04,29,19,76," Cadastro de contas ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
DBLeOrdem() 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta [A..Z]Pesquisa [F2/F3]Ordem") 
oTAB:=tbrowsedb(05,30,18,75) 
oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 3, 0 ) + " " + DESCRI + " " + CONTA_ })) 
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
      case TECLA==K_INS        ;INCLUIConta(oTAB) 
      case TECLA==K_ENTER      ;ALTERAConta(oTAB) 
      case DBPesquisa( Tecla, oTab ) 
      case TECLA==K_F2         ;DBMudaOrdem( 1, oTab ) 
      case TECLA==K_F3         ;DBMudaOrdem( 2, oTab ) 
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
stat func incluiConta(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=0, cDESCRI:=Spac(30), cConta_:= Space(20), nAgenc_:= 0,; 
     dData__:= Date(), cDocume := DOCUME, cCodCed:= Space( 20 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(02,15,10,74,"Conta Corrente") 
DBGOBOTTOM() 
Whil LastKey()<>K_ESC 
   nCodigo:= Codigo + 1 
   @ 03,16 Say "Codigo......:" Get nCODIGO PICT "999" When; 
     Mensagem( "Digite o Codigo.") 
   @ 04,16 Say "C/C.........:" Get cConta_ When; 
     Mensagem( "Digite o numero da conta." ) 
   @ 05,16 Say "Codigo Agenc:" Get nAgenc_ Pict "999" When; 
     Mensagem( "Digite o numero da Conta." ) Valid BuscaAgencia( @nAgenc_ ) 
   @ 06,16 Say "Nome Favorec:" Get cDESCRI When; 
     Mensagem( "Digite o nome do favorecido." ) 
   @ 07,16 Say "Cod. Cedente:" Get cCodCed When; 
     Mensagem( "Digite o codigo de cedente do correntista." ) 
   @ 08,16 Say "Documento...:" Get cDocume pict "@!" When; 
     Mensagem( "Digite o Documento da Conta (CPF/CGC/Outros)." ) 
   @ 09,16 Say "Dt.Abertura.:" Get dData__ When; 
     Mensagem( "Digite a data de abertura da conta." ) 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If netrlock() 
         Repl CODIGO With nCodigo,; 
              DESCRI With cDescri,; 
              AGENC_ With nAgenc_,; 
              DATA__ With dData__,; 
              CONTA_ With cConta_,; 
              CODCED With cCodCed,; 
              DOCUME With cDocume 
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
stat func alteraConta(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCODIGO:=CODIGO, cDESCRI:=DESCRI, cConta_:= CONTA_, nAgenc_:= AGENC_,; 
     dData__:= DATA__, cDocume := DOCUME, cCodCed:= CODCED 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBox(02,15,10,74,"Conta Corrente") 
 @ 03,16 Say "Codigo......: [" + StrZero( nCODIGO, 3, 0 ) + "]" 
 @ 04,16 Say "C/C.........:" Get cConta_ When; 
   Mensagem( "Digite o numero da conta." ) 
 @ 05,16 Say "Codigo Agenc:" Get nAgenc_ Pict "999" When; 
   Mensagem( "Digite o numero de cadastro da agencia" ) Valid BuscaAgencia( @nAgenc_ ) 
 @ 06,16 Say "Nome Favorec:" Get cDESCRI When; 
   Mensagem( "Digite o nome do favorecido." ) 
 @ 07,16 Say "Cod. Cedente:" Get cCodCed When; 
   Mensagem( "Digite o codigo de cedente do correntista." ) 
 @ 08,16 Say "Documento...:" Get cDocume pict "@!" When; 
   Mensagem( "Digite o Documento da Conta (CPF/CGC/Outros)." ) 
 @ 09,16 Say "Dt.Abertura.:" Get dData__ When; 
    Mensagem( "Digite a data de abertura da conta." ) 
 Read 
 If Lastkey()<>K_ESC 
    If netrlock() 
       Repl CODIGO With nCodigo,; 
            DESCRI With cDescri,; 
            AGENC_ With nAgenc_,; 
            DATA__ With dData__,; 
            CONTA_ With cConta_,; 
            CODCED With cCodCed,; 
            DOCUME With cDocume 
    Endif 
 EndIf 
 ScreenRest(cTELA) 
 SetColor(cCOR) 
 SetCursor(nCURSOR) 
 oOBJ:Refreshall() 
 Whil !oOBJ:Stabilize() 
 EndDo 
 Return Nil 
 
/* 
**      Modulo - 
**  Finalidade - Cadastro de contas (Pesquisa:Browse) 
** Programador - Valmor Pereira Flores 
**        Data - Dezembro/1997 
** Atualizacao - 
*/ 
Function Conta(nCodigo) 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, GetList:={},; 
     nOrdem:= INDEXORD(), nArea:= SELECT() 
DBSelectar(_COD_CONTA) 
IF !Used() 
   IF( !file( _VPB_CONTA ), createvpb( _COD_CONTA ), nil ) 
   IF !fdbusevpb( _COD_CONTA, 2 ) 
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
VPBOX(04,29,12,76," Cadastro de contas ",COR[20],.T.,.T.) 
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
 
 
/***** 
�������������Ŀ 
� Funcao      � BuscaAgencia 
� Finalidade  � Apresentar um display com informacoes da agencia bancaria 
�             � utilizada pelo cliente. 
� Parametros  � nAgenc_ = Numero da Agencia Bancaria no Sistema 
� Retorno     � .T./.F. 
� Programador � Valmor Pereira Flores 
� Data        � 24/08/98 
��������������� 
*/ 
Function BuscaAgencia( nAgenc_ ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
 
   DBSelectAr( _COD_AGENCIA ) 
   DBSetOrder( 1 ) 
   IF nAgenc_ > 0 
      IF DBSeek( nAgenc_ ) 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         DBSelectAr( nArea ) 
         DBSetOrder( nOrdem ) 
         Return ( .T. ) 
      ENDIF 
   ENDIF 
 
   DBSelectAr( _COD_AGENCIA ) 
   DBLeOrdem() 
   DBGoTop() 
   VPBOX(04,29,15,76," Agencias Bancarias ",COR[20],.T.,.T.) 
   SetColor( COR[21] + "," + COR[22] + ",,," + COR[17] ) 
   Mensagem("Pressione [Enter] para selecionar.") 
   Ajuda("[F2/F3]Ordem [A a Z]Pesquisa ["+_SETAS+"][PgUp][PgDn]Move") 
   oTAB:=TBrowseDB(05,30,14,75) 
   oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 3, 0 ) + " " + NUMERO + " " + StrZero( BANCO_, 3, 0 ) + " " + DESCRI  })) 
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
         case TECLA==K_ENTER      ;nAgenc_:= CODIGO; EXIT 
         case DBPesquisa( Tecla, oTab ) 
         case Tecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         case Tecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
Return( ( LASTKEY()==13 ) ) 
 
