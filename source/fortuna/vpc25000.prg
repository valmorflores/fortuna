// ## cl2hb.exe - converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC25000 - ORIGEM/FABRICANTES 
� Finalidade  � Cadastramento de Origem/Fabricantes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc25000()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
loca oTb, nTecla 
dbselectar(_COD_ORIGEM) 
dbsetorder(3)                             && Organiza pela abreviatura (CODABR) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
dbgotop() 
setcursor(0) 
setcolor( _COR_BROWSE ) 
VPBox( 00, 00, 06, 79, " ORIGEM / FABRICANTES ", _COR_GET_BOX, .F., .F. ) 
VPbox( 07, 00, 22, 79," DISPLAY ", _COR_BROW_BOX, .F., .F. ) 
mensagem("[INSERT]Inclui [DELETE]Exclui [ENTER]Altera.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
      "[A..Z]Pesquisa [F3]Codigo [F4]Nome [F5]Abrev. [ESC]Retorna") 
DBLeOrdem() 
oTb:=tbrowsedb( 08, 01, 21, 78 ) 
oTb:addcolumn(tbcolumnnew(,{|| CODABR+" - "+StrZero(CODIGO,4,0)+" => "+DESCRI+Space( 30 ) })) 
oTb:AUTOLITE:=.f. 
oTb:dehilite() 
whil .t. 
   oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTb:stabilize() 
   enddo 
   DisplayOrigem() 
   nTecla:=inkey(0) 
   if nTecla=K_ESC 
      exit 
   endif 
   do case 
      case nTecla==K_UP         ;oTb:up() 
      case nTecla==K_LEFT       ;oTb:up() 
      case nTecla==K_RIGHT      ;oTb:down() 
      case nTecla==K_DOWN       ;oTb:down() 
      case nTecla==K_PGUP       ;oTb:pageup() 
      case nTecla==K_PGDN       ;oTb:pagedown() 
      case nTecla==K_END        ;oTb:gotop() 
      case nTecla==K_HOME       ;oTb:gobottom() 
      case DBPesquisa( nTecla, oTb ) 
      case nTecla==K_F3         ;DBMudaOrdem( 1, oTb ) 
      case nTecla==K_F4         ;DBMudaOrdem( 2, oTb ) 
      case nTecla==K_F5         ;DBMudaOrdem( 3, oTb ) 
      case nTecla==K_ENTER 
           OrigemAltera( oTb ) 
      case nTecla==K_INS 
           OrigemInclui( oTb ) 
      case nTecla==K_DEL 
           Exclui( oTb ) 
 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTb:refreshcurrent() 
   oTb:stabilize() 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(if(nTecla==K_ENTER,.T.,.F.)) 
 
/***** 
�������������Ŀ 
� Funcao      � DISPLAYORIGEM 
� Finalidade  � Apresentar Informacoes da origem atual 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function DisplayOrigem() 
Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo......: [    ]" 
  @ 03,02 Say "Descricao...: [" + Space( 45 ) + "]" 
  @ 04,02 Say "Abreviatura.: [   ]" 
  SetColor( _COR_GET_CURSOR ) 
  @ 02,17 Say StrZero( CODIGO, 4, 0 ) 
  @ 03,17 Say DESCRI 
  @ 04,17 Say CODABR 
  SetColor( cCor ) 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � ORIGEMINCLUI 
� Finalidade  � Inclusao de uma nova origem na base de dados 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function OrigemInclui( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cDescri:= SPACE( 45 ), nCodigo:= 0, cCodAbr:= Space( 3 ) 
Local nOrdem:= IndexOrd() 
 
  SetCursor( 1 ) 
  DBSetOrder( 1 ) 
  DBSeek( 9999 ) 
  DBSkip( -1 ) 
  nCodigo:= CODIGO + 1 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 say "Codigo......:" Get nCodigo pict "9999" valid !DBSeek( nCodigo ) When; 
       mensagem("Digite o codigo da origem que sera cadastrado.") 
  @ 03,02 say "Descricao...:" get cDescri pict "@!" when; 
       mensagem("Digite o nome do fabricante.") 
  @ 04,02 say "Abreviatura.:" get cCodAbr pict "!!!" when; 
       mensagem("Digite o codigo de uso do fabricante / Abreviatura.") 
  READ 
  IF !LastKey()==K_ESC 
     IF BuscaNet( 5, {|| dbappend(), !neterr() } ) 
        Replace CODIGO With nCodigo,; 
                DESCRI With cDescri,; 
                CODABR With cCodAbr 
     ENDIF 
  ENDIF 
  ScreenRest( cTela ) 
  DBUnlockAll() 
  oTb:RefreshAll() 
  WHILE !oTb:Stabilize() 
  ENDDO 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � ORIGEMALTERA 
� Finalidade  � Alteracao de uma origem na base de dados 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function OrigemAltera( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cDescri:= SPACE( 45 ), nCodigo:= 0, cCodAbr:= Space( 3 ) 
Local nOrdem:= IndexOrd() 
 
  nCodigo:= CODIGO 
  cDescri:= DESCRI 
  cCodAbr:= CODABR 
  SetCursor( 1 ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 03,02 say "Descricao...:" get cDescri pict "@!" when; 
       mensagem("Digite o nome do fabricante.") 
  @ 04,02 say "Abreviatura.:" get cCodAbr pict "!!!" when; 
       mensagem("Digite o codigo de uso do fabricante / Abreviatura.") 
  READ 
  IF !LastKey()==K_ESC 
     IF netrlock() 
        Replace CODIGO With nCodigo,; 
                DESCRI With cDescri,; 
                CODABR With cCodAbr 
     ENDIF 
  ENDIF 
  ScreenRest( cTela ) 
  DBUnlockAll() 
  oTb:RefreshAll() 
  WHILE !oTb:Stabilize() 
  ENDDO 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  Return Nil 
 
/* 
* Funcao      - OSELECIONA 
* Finalidade  - Selecao de Origens a partir de outros modulos. 
* Programador - Valmor Pereira Flores 
* Data        - 
* Atualizacao - 20/Novembro/1994 
*/ 
func oseleciona(ORABR) 
loca nAREA:=select(), nORDEM:=indexord() 
loca cTELA:=screensave(00,00,nMAXLIN,nMAXCOL), cCOR:=setcolor(),; 
     nCURSOR:=setcursor() 
loca oTb, TECLA 
loca mBUSCA 
priv nORDEMG:=1 
if ORABR="   " 
   aviso("Origem (fabricante) ausente. ",nMAXLIN/2) 
   inkey(.4) 
   screenrest(cTELA) 
   return(.T.) 
endif 
dbselectar(_COD_ORIGEM) 
dbsetorder(3)                             && Organiza pela abreviatura (CODABR) 
if dbseek(ORABR)                          && Pesquisa 
   dbselectar(nAREA) 
   dbsetorder(nORDEM) 
   return(.T.) 
endif 
 
//* INICIALIZACAO DA TELA E CORES *// 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
usermodulo(" Selecao de Origens ") 
dbgotop() 
setcursor(0) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
vpbox(11,15,nMAXLIN-4,76," ORIGENS ") 
mensagem("Para selecionar pressione [ENTER] com o cursor sobre a origem.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
      "[A..Z]Pesquisa [F3]Codigo [F4]Nome [F5]Abrev. [ESC]Retorna") 
 
DBLeOrdem() 
//* INICIO DA CLASSE TBROWSE() *// 
oTb:=tbrowsedb(12,16,nMAXLIN-5,75) 
oTb:addcolumn(tbcolumnnew(,{|| CODABR+" - "+strzero(CODIGO,4,0)+" => "+DESCRI+"       "})) 
oTb:AUTOLITE:=.f. 
oTb:dehilite() 
whil .t. 
   oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTb:stabilize() 
   enddo 
   TECLA:=inkey(0) 
   if TECLA=K_ESC 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oTb:up() 
      case TECLA==K_LEFT       ;oTb:up() 
      case TECLA==K_RIGHT      ;oTb:down() 
      case TECLA==K_DOWN       ;oTb:down() 
      case TECLA==K_PGUP       ;oTb:pageup() 
      case TECLA==K_PGDN       ;oTb:pagedown() 
      case TECLA==K_END        ;oTb:gotop() 
      case TECLA==K_HOME       ;oTb:gobottom() 
      case DBPesquisa( TECLA, oTb ) 
      case TECLA==K_F3         ;DBMudaOrdem( 1, oTb ) 
      case TECLA==K_F4         ;DBMudaOrdem( 2, oTb ) 
      case TECLA==K_F5         ;DBMudaOrdem( 3, oTb ) 
      case TECLA==K_ENTER 
           ORABR:=CODABR                  && Codigo de abreviatura 
           exit 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTb:refreshcurrent() 
   oTb:stabilize() 
enddo 
dbselectar(nAREA) 
dbsetorder(nORDEM) 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(if(TECLA==K_ENTER,.T.,.F.)) 
 
 
