// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 

/* 
**      Modulo - VPC880000 
**  Finalidade - TABELA DE SERVICOS (Inc/Alt/Excl) 
** Programador - Valmor Pereira Flores 
**        Data - 14/Janeiro/1995 
** Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc88000()
#endif


loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTela:= ScreenSave( 0, 0, 24, 79 ), oTAB,;
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0 
if !AbreGrupo( "SERVICOS" ) 
   return nil 
endif 
 
DBSelectAr( _COD_SERVICO ) 
dbgotop() 
SetCursor(1) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX(00,00,11,79, " Cadastro de Servicos ", COR[16], .F., .F. ) 
VPBOX(12,00,22,79, ,  COR[20], .F., .F. ) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
Mensagem("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(13,01,21,78) 
oTAB:addcolumn(tbcolumnnew(,{|| Tran( SUBCTA, "@R XX.XX" ) + " " + IF( Val( Codigo ) <> 0, Tran( Codigo, "@R 999-9999" ), Space(8) ) + " " + DESCRI + " " + Tran( VALORP, "@E 9999,999.99" ) + Tran( CUSEXE, "@E 9999,999.99" ) })) 
oTAB:AUTOLITE:=.F. 
oTAB:dehilite() 
whil .t. 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTAB:stabilize() 
   enddo 
   VisualServico() 
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
      case TECLA==K_INS        ;INCLUIServico(oTAB) 
      case TECLA==K_ENTER      ;ALTERAServico(oTAB) 
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
³ Funcao      ³ IncluiServico 
³ Finalidade  ³ Inclusao de servicos 
³ Parametros  ³ oObj 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
stat func incluiServico(oOBJ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cSubCta:= Space( 4 ), cDescri:= Space( 33 ),; 
      nCusExe:= nValorP:= nSaldoA:= nDebito:= nCredit:= nSaldo_:= 0,; 
      nEspaco:= 0, cCodigo:= GrupoServicos + "0000" 
DBSelectAr( _COD_SERVICO ) 
VPBox( 00, 00, 11, 79, "Inclusao de Servicos", _COR_GET_BOX, .F., .F. ) 
SetColor( _COR_GET_EDICAO ) 
DBGoBottom() 
   cDescri:= Space( 33 ) 
   @ 01,03 Say "Conta............:" Get cSubCta Pict "@R XX.XX" Valid VerSubServico( @cSubCta ) When; 
     Mensagem( "Digite o numero da conta/sub-conta para o servico." ) 
   @ 02,03 Say "Codigo...........:" Get cCodigo Pict "@R 999-9999" Valid VerifCodigo( @cCodigo, cSubCta ) When; 
     Mensagem( "Digite o grupo do servico.") 
   @ 03,03 Say "Descricao........:" Get cDescri When; 
     Mensagem("Digite a descricao do Servico.") 
   @ 04,03 Say "Custo de execucao:" Get nCusExe Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor do custo para a execucao deste servico." ) 
   @ 05,03 Say "Valor Padrao.....:" Get nValorP Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite um valor padrao para este hist¢rico." ) 
   @ 06,03 Say Repl( "Ä", 73 ) 
   @ 06,04 Say " Ajuste de Saldos " 
   @ 07,03 Say "Receitas Anter...:" Get nSaldoA Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor dos recebimentos anteriores a traves deste servico." ) 
   @ 08,03 Say "Custos...........:" Get nDebito Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor total dos custos deste servico." ) 
   @ 09,03 Say "Recebimentos.....:" Get nCredit Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor recebido por este servico." ) 
   @ 10,03 Say "Resultado Atual..:" Get nSaldo_ Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor do saldo atual deste servico." ) 
   Read 
   nEspaco:= 0 
   IF Val( Left( cSubCta, 2 ) ) > 0 
      ++nEspaco 
      IF Val( Right( cSubCta, 2 ) ) > 0 
         ++nEspaco 
         IF Val( Right( cCodigo, 4 ) ) > 0 
            ++nEspaco 
         ENDIF 
      ENDIF 
   ENDIF 
   cDescri:= Space( 2 * nEspaco ) + cDescri 
   DBSelectAr( _COD_SERVICO ) 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If NetRlock() 
         Repl Codigo With cCodigo,; 
              SubCta with cSubCta,; 
              Descri With cDescri,; 
              CusExe With nCusExe,; 
              ValorP With nValorP,; 
              SaldoA With nSaldoA,; 
              Debito With nDebito,; 
              Credit With nCredit,; 
              Saldo_ With nSaldo_ 
      Endif 
      If Val( Right( cCodigo, 4 ) ) > 0 
         DBSelectAr( _COD_MPRIMA ) 
         DBAppend() 
         If NetRlock() 
            Repl Codigo With cCodigo,; 
                 Indice With cCodigo,; 
                 Descri With LTrim( cDescri ),; 
                 PrecoV With nValorP,; 
                 Saldo_ With 999999 
         Endif 
      Endif 
   Endif 
   DBSelectAr( _COD_SERVICO ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ AlteraServico 
³ Finalidade  ³ Inclusao de servicos 
³ Parametros  ³ oObj 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
stat func AlteraServico(oOBJ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cSubCta:= SubCta, cDescri,; 
      nCusExe:= CUSExe, nValorP:= ValorP, nSaldoA:= SaldoA,; 
      nDebito:= Debito, nCredit:= Credit, nSaldo_:= Saldo_,; 
      nEspaco:= 0, cCodigo:= Left( CODIGO, 7 ) 
 
   DBSelectAr( _COD_SERVICO ) 
   VPBox( 00, 00, 11, 79, "Alteracao de Servicos", _COR_GET_BOX, .F., .F. ) 
   SetColor( _COR_GET_EDICAO ) 
 
   cDescri:= PADL( LTrim( Descri ), 33 ) 
   @ 01,03 Say "Conta............: [" + Tran( cSubCta, "@R XX.XX" ) + "]" 
   @ 02,03 Say "Codigo...........: [" + Tran( cCodigo, "@R 999-9999" ) + "]" 
   @ 03,03 Say "Descricao........:" Get cDescri When; 
     Mensagem("Digite a descricao do Servico.") 
   @ 04,03 Say "Custo de execucao:" Get nCusExe Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor do custo para a execucao deste servico." ) 
   @ 05,03 Say "Valor Padrao.....:" Get nValorP Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite um valor padrao para este hist¢rico." ) 
   @ 06,03 Say Repl( "Ä", 73 ) 
   @ 06,04 Say " Ajuste de Saldos " 
   @ 07,03 Say "Receitas Anter...:" Get nSaldoA Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor dos recebimentos anteriores a traves deste servico." ) 
   @ 08,03 Say "Custos...........:" Get nDebito Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor total dos custos deste servico." ) 
   @ 09,03 Say "Recebimentos.....:" Get nCredit Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor recebido por este servico." ) 
   @ 10,03 Say "Resultado Atual..:" Get nSaldo_ Pict "@E 999,999,999.99" when; 
     Mensagem( "Digite o valor do saldo atual deste servico." ) 
   Read 
   nEspaco:= 0 
   IF Val( Left( cSubCta, 2 ) ) > 0 
      ++nEspaco 
      IF Val( Right( cSubCta, 2 ) ) > 0 
         ++nEspaco 
         IF Val( Right( cCodigo, 4 ) ) > 0 
            ++nEspaco 
         ENDIF 
      ENDIF 
   ENDIF 
   cDescri:= Space( 2 * nEspaco ) + cDescri 
   DBSelectAr( _COD_SERVICO ) 
   If Lastkey()<>K_ESC 
      If NetRlock() 
         Repl Codigo With cCodigo,; 
              SubCta with cSubCta,; 
              CusExe With nCusExe,; 
              Descri With cDescri,; 
              ValorP With nValorP,; 
              SaldoA With nSaldoA,; 
              Debito With nDebito,; 
              Credit With nCredit,; 
              Saldo_ With nSaldo_ 
      Endif 
      IF Val( Right( cCodigo, 4 ) ) > 0 
         DBSelectAr( _COD_MPRIMA ) 
         IF DBSeek( cCodigo + Space( 5 ) ) 
            If NetRlock() 
               Repl Codigo With cCodigo,; 
                    Indice With cCodigo,; 
                    Descri With LTrim( cDescri ),; 
                    PrecoV With nValorP 
            Endif 
         Endif 
      Endif 
   Endif 
   DBSelectAr( _COD_SERVICO ) 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
STATIC FUNCTION VisualServico() 
Local cCor:= SetColor(), nCursor:= SetCursor() 
Local cSubCta:= SubCta, cDescri:= PADL( LTrim( Descri ), 33 ),; 
      nCusExe:= CUSExe, nValorP:= ValorP, nSaldoA:= SaldoA,; 
      nDebito:= Debito, nCredit:= Credit, nSaldo_:= Saldo_,; 
      nEspaco:= 0, cCodigo:= Left( CODIGO, 7 ) 
 
   SetColor( _COR_GET_EDICAO ) 
   @ 01,03 Say "Conta............: [" + Tran( cSubCta, "@R XX.XX" ) + "]" 
   @ 02,03 Say "Codigo...........: [" + Tran( cCodigo, "@R 999-9999" ) + "]" 
   @ 03,03 Say "Descricao........: [" + cDescri + "]" 
   @ 04,03 Say "Custo de execucao: [" + Tran( nCusExe, "@E 999,999,999.99" ) + "]" 
   @ 05,03 Say "Valor Padrao.....: [" + Tran( nValorP, "@E 999,999,999.99" ) + "]" 
   @ 06,03 Say Repl( "Ä", 73 ) 
   @ 06,04 Say " Ajuste de Saldos " 
   @ 07,03 Say "Receitas Anter...: [" + Tran( nSaldoA, "@E 999,999,999.99" ) + "]" 
   @ 08,03 Say "Custos...........: [" + Tran( nDebito, "@E 999,999,999.99" ) + "]" 
   @ 09,03 Say "Recebimentos.....: [" + Tran( nCredit, "@E 999,999,999.99" ) + "]" 
   @ 10,03 Say "Resultado Atual..: [" + Tran( nSaldo_, "@E 999,999,999.99" ) + "]" 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
STATIC FUNCTION VerifCodigo( cCodigo, cSubCta ) 
Local cGrupo_ 
Local nArea:= Select(), nOrdem:= IndexOrd() 
IF Alltrim( cCodigo ) == "0000000" 
   DBSelectAr( _COD_SERVICO ) 
   IF !DBSeek( cSubCta ) 
      Return .T. 
   ENDIF 
ENDIF 
DBSelectAr( _COD_GRUPO ) 
IF !DBSeek( Left( cCodigo, 3 ) ) 
   cGrupo_:= Left( cCodigo, 3 ) 
   VerificaGrupo( @cGrupo_ ) 
   cCodigo:= cGrupo_ + Right( cCodigo, 4 ) 
ENDIF 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 1 ) 
DBSeek( Left( cCodigo, 3 ) + "9999     ", .T. ) 
DBSkip( -1 ) 
IF Left( INDICE, 3 ) == Left( cCodigo, 3 ) 
   cCodigo:= Left( cCodigo, 3 ) + StrZero( Val( SubStr( INDICE, 4, 4 ) ) + 1, 4 ) 
ELSE 
   cCodigo:= Left( cCodigo, 3 ) + "0001" 
ENDIF 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
Return .T. 
 
 
STATIC FUNCTION VerSubServico( cSubCta ) 
IF DBSeek( StrTran( cSubCta, "00", "  " ) ) 
   Keyboard Chr( K_ENTER ) 
   Return .T. 
ELSE 
   IF !DBSeek( Left( cSubCta, 2 ) ) 
      IF Right( cSubCta, 2 ) <> "00" 
         Return .F. 
      ENDIF 
   ENDIF 
   Return .T. 
ENDIF 
 
