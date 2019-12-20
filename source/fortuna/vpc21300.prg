// ## CL2HB.EXE - Converted
** 
** Modulo de cadastro de classificacao fiscal cfe. receita federal 
** para uso em conjunto com os arquivos que se referem a produtos, p/ 
** industrializacao. 
** 
 
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � CLASFISCAL 
� Finalidade  � Cadastro de Classificacao Fiscal 
� Parametros  � Nil 
� Retorno     � NIl 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function ClasFiscal() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), nTecla:= 0,; 
      nCursor:= SetCursor(), cCor:= SetColor() 
Local nArea:= Select(), nOrdem:= IndexOrd() 
 
  DBSelectAr( _COD_CLASFISCAL ) 
  DBGoTop() 
 
  SetCursor( 0 ) 
  VPBox( 00, 00, 07, 79, " Classificacao Fiscal ", _COR_GET_BOX ) 
  VPBox( 08, 00, 22, 79, " Display ", _COR_BROW_BOX ) 
  SetColor( _COR_BROWSE ) 
  Mensagem("[INS]Inclui [ENTER]Altera [DEL]Exclui [ESC]Finaliza") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [F3]Codigo [F4]Nome") 
  oTB:=TBrowseDB( 09, 01, 21, 78 ) 
  oTB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 3, 0 ) + " " + CODFIS + " " + OBSERV + Space( 50 ) })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  WHILE .T. 
     oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
     DisplayClas() 
     nTecla:=inkey(0) 
     if nTecla=K_ESC 
        exit 
     endif 
     do case 
        case nTecla==K_UP         ;oTB:up() 
        case nTecla==K_LEFT       ;oTB:up() 
        case nTecla==K_RIGHT      ;oTB:down() 
        case nTecla==K_DOWN       ;oTB:down() 
        case nTecla==K_PGUP       ;oTB:pageup() 
        case nTecla==K_PGDN       ;oTB:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
        case nTecla==K_F2         ;DBMudaOrdem( 1, oTb ) 
        case nTecla==K_F3         ;DBMudaOrdem( 2, oTb ) 
        case nTecla==K_INS        ;IncluiClassif( oTb ) 
        case nTecla==K_ENTER      ;AlteraClassif( oTb ) 
        case nTecla==K_DEL        ;Exclui( oTb ) 
        otherwise 
     endcase 
     oTB:refreshcurrent() 
     oTB:stabilize() 
  enddo 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
  return(if(nTecla=K_ENTER,.T.,.F.)) 
 
 
/***** 
�������������Ŀ 
� Funcao      � DisplayClas 
� Finalidade  � Apresentacao das informacoes na tela 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function DisplayClas() 
Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02, 02 Say "Codigo.........: [" + StrZero( CODIGO, 3, 0 ) + "]" 
  @ 03, 02 Say "Classificacao..: [" + CODFIS + "]" 
  @ 04, 02 Say "Descricao......: [" + OBSERV + "]" 
  @ 05, 02 Say "Observ.N.Fiscal: [" + Left( OBSNOT, 55 ) + "]" 
  SetColor( cCor ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiClassif 
� Finalidade  � Inclusao de Classificacao Fiscal 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
func IncluiClassif( oTb ) 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor() 
  Local nCodigo:= 0, cCodFis:= Spac( 10 ), cObserv:= Space( 30 ),; 
        cObsNota:= Space( 60 ) 
  SetColor( _COR_GET_EDICAO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move "+; 
        "[TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  DBSetOrder(1) 
  DBGOBOTTOM() 
  nCODIGO:= Codigo 
  WHILE .T. 
     ++nCodigo 
     SetColor( _COR_GET_EDICAO ) 
     SetCursor( 1 ) 
     @ 02,02 Say "Codigo.........:" Get nCodigo Pict "999" Valid !DBSeek( nCodigo ) When; 
       Mensagem("Digite o codigo p/ inclusao ou pressione [ESC] p/ retornar.") 
     @ 03,02 say "Classificacao..:" get cCodFis pict "@9" when; 
       mensagem("Digite o codigo de clas. cfe. tabela da Receita Federal.") 
     @ 04,02 say "Descricao......:" get cObserv pict "@!" when ; 
       mensagem("Digite qualquer observacao complementar.") 
     @ 05,02 Say "Observ.N.Fiscal:" Get cObsNota Pict "@S55" When; 
       Mensagem( "Digite uma observacao a ser impressa na nota fiscal." ) 
     READ 
     IF LastKey() == K_ESC 
        EXIT 
     ELSE 
        IF Confirma( 0, 0, "Confirma?", "Digite [S] para confirmar o cadastramento do cliente.",; 
                           "S",COR[16]+","+COR[18]+",,,"+COR[17]) 
           DBAppend() 
           Replace CODIGO with nCodigo,; 
                   CODFIS with cCodFis,; 
                   OBSERV with cObserv,; 
                   OBSNOT With cObsNota 
        ENDIF 
     ENDIF 
  ENDDO 
  dbUnlockAll() 
  SetColor(cCOR) 
  SetCursor(nCURSOR) 
  ScreenRest(cTELA) 
  oTb:RefreshAll() 
  WHILE !oTb:Stabilize() 
  ENDDO 
  Set Key K_TAB to 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � AlteraClassif 
� Finalidade  � Alteracao de Classificacao Fiscal 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function AlteraClassif( oTb ) 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor() 
  Local nCodigo:= CODIGO, cCodFis:= CODFIS, cObserv:= OBSERV, cObsNota:= OBSNOT 
  SetColor( _COR_GET_EDICAO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move "+; 
        "[TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  SetColor( _COR_GET_EDICAO ) 
  SetCursor( 1 ) 
  @ 03,02 say "Classificacao..:" get cCodFis pict "@9" when; 
     mensagem("Digite o codigo de clas. cfe. tabela da Receita Federal.") 
  @ 04,02 say "Descricao......:" get cObserv pict "@!" when ; 
    mensagem("Digite qualquer observacao complementar.") 
  @ 05,02 Say "Observ.N.Fiscal:" Get cObsNota Pict "@S55" When; 
    Mensagem( "Digite uma observacao a ser impressa na nota fiscal." ) 
  READ 
  IF LastKey() == K_ESC 
     SetCursor( nCursor ) 
     SetColor( cCor ) 
     Screenrest( cTela ) 
     Return Nil 
  ELSE 
     IF Confirma( 0, 0, "Confirma?", "Digite [S] para confirmar o cadastramento do cliente.",; 
                        "S",COR[16]+","+COR[18]+",,,"+COR[17]) 
        IF netrlock() 
           Replace CODIGO with nCodigo,; 
                   CODFIS with cCodFis,; 
                   OBSERV with cObserv,; 
                   OBSNOT With cObsNota 
        ENDIF 
 
     ENDIF 
  ENDIF 
  dbUnlockAll() 
  SetColor(cCOR) 
  SetCursor(nCURSOR) 
  ScreenRest(cTELA) 
  Return Nil 
 
/* 
* Modulo      - PESQUISA 
* Parametros  - Elemento objeto 
* Finalidade  - Pesquisa pelo codigo ou descricao 
* Programador - Valmor Pereira Flores 
* Data        - 15/Junho/1993 
* Atualizacao - 03/Fevereiro/1994 
*/ 
stat func pesquisa(oPOBJ) 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nOPCAO:=0, nCOD:=0, cDESC:=space(10), GETLIST:={} 
ajuda("[ESC]Finaliza") 
mensagem("Selecione sua opcao conforme o menu acima.") 
if lastrec()=0 
   mensagem("Cadastro vazio, [ENTER] para continuar.") 
   pausa() 
   return NIL 
endif 
//set key K_TAB to 
setcursor(1) 
set(_SET_SOFTSEEK,.t.) 
mensagem("") 
ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
vpbox(12,45,16,69," Pesquisa ",COR[20],.T.,.F.,COR[19]) 
setcolor(COR[21]+","+COR[22]) 
aadd(MENULIST,menunew(13,46," 1 Codigo             ",2,COR[19],; 
   "Pesquisa pelo codigo de cadastramento.",,,COR[6],.T.)) 
aadd(MENULIST,menunew(14,46," 2 Classif. fiscal    ",2,COR[19],; 
   "Pesquisa pelo codigo de classificacao fiscal.",,,COR[6],.T.)) 
aadd(MENULIST,menunew(15,46," 0 Encerramento       ",2,COR[19],; 
   "Executa a finalizacao da rotina de pesquisa.",,,COR[6],.T.)) 
menumodal(MENULIST,@nOPCAO); MENULIST:={} 
ajuda("["+_SETAS+"]Movimenta [ENTER]Confirma [ESC]Cancela") 
oPOBJ:gotop() 
do case 
   case nOPCAO=1 
        vpbox(11,25,13,48,"",COR[20],.T.,.F.,COR[19]) 
        @ 12,26 say "C�digo " get nCOD pict "9999" when; 
          mensagem("Digite o c�digo para pesquisa.") 
        read 
        mensagem("Executando a pesquisa pelo codigo, aguarde...") 
        dbsetorder(1) 
        dbseek(nCOD) 
   case nOPCAO=2 
        vpbox(11,20,13,63,"",COR[20],.T.,.F.,COR[19]) 
        @ 12,21 say "Cod.Classif. " get cDESC pict "@9" when; 
          mensagem("Digite o cod. de classificacao para pesquisa.") 
        read 
        mensagem("Executando a pesquisa pela classificacao fiscal, aguarde...") 
        dbsetorder(2) 
        dbseek(upper(cDESC)) 
   otherwise 
endcase 
set(_SET_SOFTSEEK,.f.) 
dbsetorder(nORDEMG) 
setcursor(0) 
setcolor(cCOR) 
screenrest(cTELA) 
oPOBJ:refreshall() 
whil ! oPOBJ:stabilize() 
enddo 
//set key K_TAB to pesqclasse() 
return nil 
 
 
/* 
*       Funcao - VERCLASSE 
*   Finalidade - Ver e selecionar classificacao fiscal. 
*  Programador - Valmor Pereira Flores 
*         Data - 
*  Atualizacao - 
*/ 
func VerClasse(nPCODIGO) 
  loca nCURSOR:=setcursor(), cCOR:=setcolor(), oTB,; 
       cTELA:=screensave(00,00,24,79) 
  loca nAREA:=select(), nORDEM:=indexord() 
  priv aTELA 
  if nPCODIGO=0 
     return(.T.) 
  else 
     dbselectar(_COD_CLASFISCAL) 
     dbsetorder(1) 
     aTELA:=screensave(00,00,24,79) 
     Set(_SET_SOFTSEEK,.F.) 
     if dbseek(nPCODIGO) 
        dbselectar(nAREA) 
        dbsetorder(nORDEM) 
        screenrest(aTELA) 
        return(.T.) 
     endif 
  endif 
  dbgotop() 
  screenrest(aTELA) 
  aTELA:=boxsave( 05, 01, 24-3, 50 ) 
  setcursor(0) 
  setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
  vpbox(12,01,24-3,50,"Classificacao fiscal") 
  mensagem("Pressione [TAB] p/ efetuar alteracoes.") 
  ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
        "[F2]Busca [F3]Codigo [F4]Nome [TAB]Seleciona") 
  oTB:=tbrowsedb(13,02,24-4,49) 
  oTB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 03, 0 ) + " " + CODFIS + " " + OBSERV })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  whil .t. 
     oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
     nPCODIGO=CODIGO 
     TECLA:=inkey(0) 
     if TECLA=K_ESC 
        exit 
     endif 
     do case 
        case TECLA==K_UP         ;oTB:up() 
        case TECLA==K_LEFT       ;oTB:up() 
        case TECLA==K_RIGHT      ;oTB:down() 
        case TECLA==K_DOWN       ;oTB:down() 
        case TECLA==K_PGUP       ;oTB:pageup() 
        case TECLA==K_PGDN       ;oTB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
        case TECLA==K_F2         ;pesquisa(oTB) 
        case TECLA==K_F3         ;organiza(oTB,1) 
        case TECLA==K_F4         ;organiza(oTB,2) 
        case TECLA==K_TAB .OR. TECLA==K_ENTER 
             nPCODIGO:=CODIGO 
             exit 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTB:refreshcurrent() 
     oTB:stabilize() 
  enddo 
  dbselectar(nAREA) 
  dbsetorder(nORDEM) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  boxrest(aTELA) 
  screenrest(cTELA) 
  return(if(TECLA=K_ENTER,.T.,.F.)) 
