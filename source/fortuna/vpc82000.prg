// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ BANCOS 
³ Finalidade  ³ Distribuir o menu dos bancos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION Banco() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
   Ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
   SetColor( COR[12]+","+COR[13] ) 
   VPBox( 11, 35, 18, 53 ) 
   WHILE .T. 
      aadd(MENULIST,menunew(12,36," 1 Bancos       ",2,COR[11],; 
           "Cadastro de bancos.",,,COR[6],.F.)) 
      aadd(MENULIST,menunew(13,36," 2 Agˆncias     ",2,COR[11],; 
           "Cadastros de agˆncias.",,,COR[6],.F.)) 
      @ 14,36 Say  "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
      aadd(MENULIST,menunew(15,36," 3 Contas       ",2,COR[11],; 
           "Lancamento de contas correntes.",,,COR[6],.F.)) 
      @ 16,36 Say  "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
      aadd(MENULIST,menunew(17,36," 0 Retorna      ",2,COR[11],; 
           "Retorna ao menu anterior.",,,COR[6],.F.)) 
      menumodal(MENULIST,@nOPCAO); MENULIST:={} 
      do case 
         case nOPCAO==4 .or. nOpcao==0; exit 
         case nOPCAO==1 ;BancoCad() 
         case nOPCAO==2 ;VPC87800() 
         case nOPCAO==3 ;VPC87900() 
      endcase 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
/* 
**      Modulo - BANCOCAD 
**  Finalidade - TABELA DE bancoS (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 08/Maio/2002 
*/ 
FUNCTION BancoCad() 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
 
IF !Abregrupo( "BANCOS" ) 
   return nil 
endif 
dbSelectAr( _COD_BANCO ) 
dbgotop() 
SetCursor(1) 
VPBOX(04,26,19,76," Tabela de Bancos ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(05,27,18,75) 
oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 3, 0 ) + " " + DESCRI })) 
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
      case TECLA==K_INS        ;IncluiBanco(oTAB) 
      case TECLA==K_ENTER      ;AlteraBanco(oTAB,Tecla) 
      case TECLA==K_SPACE      ;AlteraBanco(oTab,Tecla) 
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
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ 
³ Finalidade  ³ 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
stat func IncluiBanco(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca nCodigo:=0, cDESCRI:=Spac(45) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(04,26,07,76,"Cadastro de Novo Banco", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
SetColor( _COR_GET_EDICAO ) 
DBGOBOTTOM() 
Whil LastKey()<>K_ESC 
   @ 05,28 Say "Codigo:" Get nCodigo PICT "999" When; 
     MENSAGEM("Digite o banco.") 
   @ 06,28 Say "Banco.:" Get cDescri Pict "@S38" When; 
     MENSAGEM("Digite a descricao da ATIVIDADE.") 
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If NetRlock() 
         Repl CODIGO With nCodigo,; 
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
stat func AlteraBanco(oOBJ,nTecla) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, nCodigo:=Codigo, nSaldo_:= SALDO_, nSldAnter:=0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   USERSCREEN() 
   VPBOX( 02, 15, 06, 64, IIF( nTecla==K_SPACE, "Ajuste de Saldos", "Tabela de Bancos" ), COR[20] ) 
   nSldAnter:=SALDO_ 
   @ 03,16 Say "Codigo...: [" + StrZero( nCodigo, 3, 0 ) + "]" 
   IF nTecla==K_SPACE 
      @ 04,16 Say "Descricao: [" + lEFT( cDESCRI, 35 ) + "]" 
   ELSE 
      @ 04,16 Say "Descricao:" Get cDESCRI Pict "@S35" When Mensagem( "Digite a descricao da ATIVIDADE." ) 
   ENDIF 
   IF nGCodUser==0 .OR. nGCodUser==999 
      @ 05,16 Say "Saldo....:" Get nSaldo_ Pict "@E 999,999,999.99" 
   ELSE 
      @ 05,16 Say "Saldo....: [" + Tran( nSaldo_, "@E 999,999,999.99" ) + "]" 
   ENDIF 
   Read 
   If Lastkey()<>K_ESC 
      If NetRlock() 
         Repl CODIGO With nCodigo,; 
              DESCRI With cDescri,; 
              SALDO_ With nSaldo_ 
      Endif 
      IF nTecla <> K_SPACE 
         If nSldAnter<nSaldo_ 
            LancaMovimento( DATE(), nCodigo, cDescri, "T", ; 
               " **** AJUSTE DE SALDO **** ", " ", 0 , nSaldo_-nSldAnter ) 
         ElseIf nSldAnter>nSaldo_ 
            LancaMovimento( DATE(), nCodigo, cDescri, "T", ; 
               " **** AJUSTE DE SALDO **** ", " ", nSldAnter-nSaldo_ , 0 ) 
         EndIf 
      Endif 
   EndIf 
   SCREENREST(cTELA) 
   SetColor(cCOR) 
   SetCursor(nCURSOR) 
   oOBJ:Refreshall() 
   Whil !oOBJ:Stabilize() 
   EndDo 
   Return Nil 
 
