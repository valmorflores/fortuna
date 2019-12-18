// ## CL2HB.EXE - Converted
/* 
* Modulo      - VPC21000 
* Descricao   - Cadastro de Produtos 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 09/Novembro/1994 
*/ 
#include "VPF.CH" 
#include "INKEY.CH" 

#ifdef HARBOUR
function vpc21000()
#endif


loca cTELA:=zoom(05,34,16,54), cCOR:=setcolor(), nOPCAO:=0
vpbox( 04, 34, 17, 54 ) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(05,35," 1 Materia-Prima  ",2,COR[11],; 
        "Inclusao de materia-prima.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(06,35," 2 Composicao     ",2,COR[11],; 
        "Montagem de produtos.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(07,35," 3 Servicos       ",2,COR[11],; 
        "Cadastro de servicos.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(08,35," 4 Grupos         ",2,COR[11],; 
        "Inclusao, alteracao e exclusao de grupos de classificacao de produtos.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(09,35," 5 Similaridade   ",2,COR[11],; 
        "Similaridade entre produtos.",,,COR[6],.F.)) 
                   @ 10,35 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
   aadd(MENULIST,menunew(11,35," 6 Pesquisas      ",2,COR[11],; 
        "Verificacao de produtos, montagem e servicos.",,,COR[6],.F.)) 
                   @ 12,35 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
   aadd(MENULIST,menunew(13,35," 7 Ajustes        ",2,COR[11],; 
        "Ajuste de saldos em estoque e codigo barras.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(14,35," 8 Complemento    ",2,COR[11],; 
        "Alteracao Complementar de Produtos Compostos/Materia-Prima.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(15,35," 9 Etiquetas      ",2,COR[11],; 
        "Impressao de Etiquetas Com codigo de barras.",,,COR[6],.F.)) 
   aadd(MENULIST,menunew(16,35," 0 Retorna        ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.F.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=10; exit 
      case nOPCAO=1 
           IF SWSet( _CAD_PRODUTOS ) == 1 
              do VPC21110 
           ELSEIF SWSet( _CAD_PRODUTOS ) == 2 
              do PRODFARM 
           ENDIF 
      case nOPCAO=2; Composicao() 
      case nOpcao=3; do VPC88000 
      case nOpcao=4; GrupoProduto() 
      case nOpcao=5; VPC36000() 
      case nOpcao=6; Montagem() 
      case nOpcao=7; Ajustes() 
      case nOpcao=8; VPC21110(.T.) 
      case nOpcao=9; VPC21500() 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
STATIC FUNCTION GrupoProduto() 
Local oTab, Tecla, cTela := ScreenSave(00,00,24,79),; 
      cCor:= SetColor(), nCursor:= SetCursor() 
IF !Abregrupo( "GRUPO" ) 
   return nil 
endif 
DBSelectAr( _COD_GRUPO ) 
ajuda("[F2]Codigo [F3]Nome ["+_SETAS+"][PgUp][PgDn]Movimenta") 
DBLeOrdem() 
Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui [F9]Atualiza Precos [F10]Margens") 
bBlock:= {|| CODIGO + " " + LEFT( DESCRI, 30 ) + Tran( MARG_A, "@eZ 9999.999" ) + " " + ;
                                     Tran( MARG_B, "@eZ 9999.999" ) + " " + ;
                                     Tran( MARG_C, "@eZ 9999.999" ) + " " + ;
                                     Tran( MARG_D, "@eZ 9999.999" ) }                                    
Tecla := NIL 
do while Tecla <> K_ESC 
   SetColor( _COR_BROWSE ) 
   oTAB:= Browse( 02, 06, 21, 76, ; 
           "Cod Descricao                            A        B        C        D", bBlock,; 
           " Tabela de Grupos ", @Tecla ) 
   do case 
      case TECLA==K_F9
           GrupoAtualPrecos()
      case TECLA==K_F10
           GrupoAtualPrecos( 1 )
      case TECLA==K_F2
           DBMudaOrdem( 1, oTab ) 
      case TECLA==K_F3 
           DBMudaOrdem( 2, oTab ) 
      case TECLA==K_DEL 
           lDELETE:=.T. ;if(netrlock(5),exclui(oTAB),nil) 
           dbUnlockAll() 
      case TECLA==K_INS        ;incluiGrupo(oTAB) 
      case TECLA==K_ENTER      ;AlteraGrupo(oTAB) 
      case DBPesquisa( Tecla, oTab ) 
   endcase 
enddo 
screenrest(cTELA) 
dbunlockall() 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
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
stat func incluiGrupo(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cCodigo:="000", cDESCRI:=Spac(100), cMaiorCod:=Space(3), nDesconto:=0
Local nMargemA:= 0, nMargemB:= 0, nMargemC:= 0, nMargemD:= 0
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
DBGOBOTTOM() 
SetCursor(1) 
Whil LastKey()<>K_ESC 
   cDESCRI:=Spac(100) 
   nDesconto:=0 
   dBGoTop() 
   cMaiorCod:=CODIGO 
   dBSkip() 
   Whil !eof() 
       if CODIGO>cMaiorCod 
          cMaiorCod:=CODIGO 
       endif 
       dBSkip() 
   enddo 
   cCodigo:=strzero(val(cMaiorCod)+1,3) 
   VPBOX( 02, 15, 11, 74, "Cadastro de Novo Grupo", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 03,16 Say "Codigo:" Get cCodigo PICT "999" When; 
     MENSAGEM("Digite o Grupo.") valid pesqcodigo(cCodigo) 
   @ 04,16 Say "Grupo.:" Get cDescri Pict "@S40" When; 
     MENSAGEM("Digite a descricao do Grupo.") 
   @ 05,16 Say "% de desconto maximo permitido no PDV:" Get nDesconto Pict ; 
         "@E 999,999.99" When Mensagem( "Digite o desconto maximo p/ grupo no momento da venda." )
   @ 06,16 Say "-- Margem Sugestiva (Grupo x Calsse)-------------------------"
   @ 07,18 Say "Classe/Giro [A]: " Get nMargemA Pict "@EZ 999,999.999"
   @ 08,18 Say "Classe/Giro [B]: " Get nMargemB Pict "@EZ 999,999.999"
   @ 09,18 Say "Classe/Giro [C]: " Get nMargemC Pict "@EZ 999,999.999"
   @ 10,18 Say "Classe/Giro [D]: " Get nMargemD Pict "@EZ 999,999.999"
   Read 
   If Lastkey()<>K_ESC 
      DBAppend() 
      If NetRlock() 
         Repl CODIGO With strzero(val(cCodigo),3),; 
              DESCRI With cDESCRI,; 
              DESMAX With nDesconto,;
              MARG_A With nMargemA,;
              MARG_B With nMargemB,;
              MARG_C With nMargemC,;
              MARG_D With nMargemD
      Endif 
   EndIf 
   oOBJ:Refreshall() 
   Whil !oOBJ:Stabilize() 
   EndDo 
EndDo 
SCREENREST(cTELA) 
SetColor(cCOR) 
SetCursor(nCURSOR) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
** 
Stat func AlteraGrupo(oOBJ) 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(),; 
     cCOR:=SetColor() 
Loca cDESCRI:=DESCRI, cCodigo:=Codigo, nDesconto:= DESMAX
Loca nMargemA:= MARG_A, nMargemB:= MARG_B, nMargemC:= MARG_C, nMargemD:= MARG_D
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
VPBOX( 02, 15, 11, 74, "Tabela de Grupos", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
@ 03,16 Say "Codigo...: [" +  cCodigo + "]" 
@ 04,16 Say "Descricao:" Get cDESCRI Pict "@S45" When Mensagem( "Digite a descricao do Grupo." ) 
@ 05,16 Say "% de desconto maximo permitido no PDV:" Get nDesconto Pict "@E 999,999.99" When Mensagem( "Digite o desconto maximo p/ grupo no momento da venda." )
@ 06,16 Say "--[ Margem Sugestiva por Grupo x Classe ]----"
@ 07,16 Say "   Classe/Giro [A]: " Get nMargemA Pict "@EZ 999,999.999"
@ 08,16 Say "   Classe/Giro [B]: " Get nMargemB Pict "@EZ 999,999.999"
@ 09,16 Say "   Classe/Giro [C]: " Get nMargemC Pict "@EZ 999,999.999"
@ 10,16 Say "   Classe/Giro [D]: " Get nMargemD Pict "@EZ 999,999.999"
READ
If Lastkey()<>K_ESC
   If NetRlock() 
      Repl CODIGO With cCodigo,; 
           DESCRI With cDescri,; 
           DESMAX With nDesconto,;
           MARG_A With nMargemA,;
           MARG_B With nMargemB,;
           MARG_C With nMargemC,;
           MARG_D With nMargemD
   Endif 
EndIf 
ScreenRest( cTELA ) 
SetColor( cCOR ) 
SetCursor( nCURSOR ) 
oOBJ:Refreshall() 
Whil !oOBJ:Stabilize() 
EndDo 
Return Nil 
 
 
FUNCTION VerificaGrupo( cGrupo_ ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ), oTab,; 
      cTela2, dData1:= dData2:= Date(), cTela0 
IF !Abregrupo( "GRUPO" ) 
   return nil 
endif 
dbSelectAr( _COD_GRUPO ) 
dbgotop() 
IF DBSeek( cGrupo_ ) 
   Return Nil 
ELSE 
   DBGoTop() 
ENDIF 
SetCursor(1) 
VPBOX(03,26,19,76," Tabela de Grupos ",COR[20],.T.,.T.) 
setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
MENSAGEM("Pressione [Enter] para selecionar.") 
DBLeOrdem() 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
oTAB:=tbrowsedb(04,27,18,75) 
oTAB:addcolumn(tbcolumnnew(,{|| CODIGO + " " + DESCRI })) 
oTAB:AUTOLITE:=.F. 
oTAB:dehilite() 
whil .t. 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTAB:stabilize() 
   enddo 
   if ( TECLA:=inkey(0) )==K_ESC 
      cGrupo_:= "000" 
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
      case TECLA==K_ENTER      ;cGrupo_:= CODIGO; exit 
      case DBPesquisa( TECLA, oTab ) 
      case TECLA==K_F2         ;DBMudaOrdem( 1, oTab ) 
      case TECLA==K_F3         ;DBMudaOrdem( 2, oTab ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
enddo 
dbunlockall() 
screenrest(cTELA) 
setcolor(cCOR) 
setcursor(nCURSOR) 
return nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ AJUSTES 
³ Finalidade  ³ Ajustar campos / saldo e Cod Barras 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
STATIC FUNCTION Ajustes() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ), oTab,; 
      cTela2, dData1:= dData2:= Date(), cTela0 
Local cComis_:= Space( 1 ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
 
/* Ajuste arquivo */ 
dbSelectAr( _COD_MPRIMA ) 
dbSetOrder( 2 ) 
dbgotop() 
 
/* Ajuste de tela */ 
SetCursor(1) 
dDataBase:= DATE() 
VPBOX( 00, 00, 22, 79," Ajuste de Codigo de Barras e Saldos ", _COR_BROW_BOX, .F., .F. ) 
@ 02,02 Say "Data Base p/ calculos de saldo:" Get dDataBase 
READ 
SetColor( _COR_BROWSE ) 
Mensagem( "Pressione [ENTER] para Lancar as informacoes." ) 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta [ESPACO]Com registro em Estoque") 
 
DBLeOrdem()            /* gelson ??? 
DBSelectAr( _COD_ESTOQUE ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/estind01.ntx", "&gdir/estind02.ntx", "&gdir/estind03.ntx", "&gdir/estind04.ntx"     
#else 
  SET INDEX TO "&GDir\ESTIND01.NTX", "&GDir\ESTIND02.NTX", "&GDir\ESTIND03.NTX", "&GDir\ESTIND04.NTX"     
#endif
 
 
/* Ajuste de Browse */ 
oTAB:=tbrowsedb( 01, 01, 21, 78 ) 
oTAB:addcolumn( tbcolumnnew(,{|| Tran( INDICE, "@R 999-9999" ) + " " + LEFT( DESCRI, 40 ) + " " + CODFAB + " " + ORIGEM + TRAN( SALDO_, "@E 99,999.999" ) })) 
oTAB:AUTOLITE:=.F. 
oTAB:dehilite() 
 
/* Inicio Browse */ 
whil .t. 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTAB:stabilize() 
   enddo 
   if ( TECLA:=inkey(0) )==K_ESC 
      exit 
   endif 
 
   /* Teste de teclagem */ 
   do case 
 
      case TECLA==K_UP         ;oTAB:up() 
 
      case TECLA==K_LEFT       ;oTAB:up() 
 
      case TECLA==K_RIGHT      ;oTAB:down() 
 
      case TECLA==K_DOWN       ;oTAB:down() 
 
      case TECLA==K_PGUP       ;oTAB:pageup() 
 
      case TECLA==K_PGDN       ;oTAB:pagedown() 
 
      case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
 
      case Tecla==K_CTRL_PGDN  ;oTAB:gobottom() 
 
      case Chr( Tecla ) $ "0123456789" .AND. IndexOrd() == 1 
           DBPesquisa( Tecla, oTab ) 
 
      case Tecla==K_SPACE 
           /* Salva  tela */ 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
 
           /* Formata a variavel */ 
           IF Tecla == K_ENTER 
              cCodFab:= CODFAB 
           ELSE 
              cCodFab:= Chr( Tecla ) + SubStr( CODFAB, 2 ) 
              /* Joga a variavel no buffer e salva a tela */ 
              keyboard chr(K_RIGHT) 
           ENDIF 
           nSaldo_:= Saldo_ 
 
           /* Display tela */ 
           VPBox( 08, 10, 18, 65, " AJUSTE DE INFORMACOES / SALDOS", _COR_GET_BOX ) 
           SetColor( _COR_GET_EDICAO ) 
 
           @ 09, 12 Say  MPR->DESCRI 
           @ 10, 12 Say  MPR->CODFAB 
 
           cComis_:= IF( Comis_ == " ", "N", Comis_ ) 
 
           DBSelectAr( _COD_ESTOQUE ) 
           DBSelectAr( _COD_MPRIMA ) 
 
           EST->( DBSetOrder( 1 ) ) 
           EST->( DBSeek( MPR->INDICE ) ) 
           nReserv:= MPR->RESERV 
           nEntradas:= 0 
           nSaidas:= 0 
           nSaldoM:= 0 
           nSaldoF:= 0 
 
           WHILE !EST->( EOF() ) .AND.  EST->CPROD_ == MPR->INDICE 
              IF EST->ANULAR == Space( 1 ) .AND. EST->DATAMV <= dDataBase 
                 IF EST->ENTSAI=="+" 
                    nEntradas+= EST->QUANT_ 
                 ELSEIF EST->ENTSAI=="-" 
                    nSaidas+=   EST->QUANT_ 
                 ENDIF 
              ENDIF 
              @ 15,11 Say Tran( nEntradas - nSaidas, "9,999,999.99" ) + Tran( EST->QUANT_, "@E 9,999,999.99" ) + " " + EST->DOC___ 
              EST->( DBSkip() ) 
              Scroll( 12, 11, 15, 58, 1 ) 
           ENDDO 
           nSaldoM:= nEntradas - nSaidas 
           nSaldoF:= nSaldoM 
           dDataMv:= dDataBase 
 
           /* Limpeza da tela de apresentacao */ 
           Scroll( 12, 11, 17, 58, 0 ) 
 
           /* Edicao */ 
           @ 12,11 Say " Saldo Informativo..........:" Get nSaldo_ Pict "@E 999,999,999.999" 
           @ 13,11 Say " Saldo p/ Movimentacoes.....: [" + Tran( nSaldoM, "@E 999,999,999.999" ) + "]" 
           @ 14,11 Say " Saldo Fisico...............:" Get nSaldoF Pict "@E 999,999,999.999" 
           @ 15,11 Say " Reservado Por Pedidos......:" Get nReserv Pict "@E 999,999,999.999" 
           @ 16,11 Say " Data de Ajuste.............:" Get dDataMv 
           READ 
 
           IF LastKey() == K_ESC 
              Screenrest( cTelaRes ) 
              Loop 
           ENDIF 
 
           nDiferenca:= nSaldoF - nSaldoM 
           /* Gravacao */ 
           IF ! LastKey() == K_ESC 
              IF NetRLock() 
                 Replace SALDO_ With nSaldo_,; 
                         RESERV With nReserv 
                 AtualizaTabPreco( MPR->INDICE, MPR->DESCRI, MPR->CODFAB ) 
              ENDIF 
           ENDIF 
 
           IF nDiferenca < 0 
              cEntSai:= "-" 
              nDiferenca:= nDiferenca * (-1) 
           ELSE 
              cEntSai:= "+" 
           ENDIF 
 
           IF nDiferenca > 0 
              EST->( DBAppend() ) 
              IF EST->( NetRLock() ) 
                 Replace EST->CPROD_ With MPR->INDICE,; 
                         EST->CODRED With MPR->INDICE,; 
                         EST->QUANT_ With nDiferenca,; 
                         EST->CODIGO With 0,; 
                         EST->RESPON With nGCodUser,; 
                         EST->DATAMV With dDataMv,; 
                         EST->DOC___ With "***<AJUSTE>***",; 
                         EST->VLRSAI With 0,; 
                         EST->VALOR_ With 0,; 
                         EST->ENTSAI With cEntSai 
              ENDIF 
           ENDIF 
 
           /* Restaura situacao */ 
           ScreenRest( cTelaRes ) 
           SetColor( _COR_BROWSE ) 
 
      case Upper( Chr( Tecla ) ) $ "0123456789" .OR. Tecla == K_ENTER 
 
           /* Salva a tela */ 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
 
           /* Formata a variavel */ 
           IF Tecla == K_ENTER 
              cCodFab:= CODFAB 
           ELSE 
              cCodFab:= Chr( Tecla ) + SubStr( CODFAB, 2 ) 
              /* Joga a variavel no buffer e salva a tela */ 
              keyboard chr(K_RIGHT) 
           ENDIF 
           nSaldo_:= Saldo_ 
 
           IF MPR->RESERV < 0 
              IF MPR->( NetRlock() ) 
                 Replace MPR->RESERV With 0 
              ENDIF 
              MPR->( DBUnlock() ) 
           ENDIF 
           nReserv:= MPR->RESERV 
 
           /* Display tela */ 
           VPBox( 09, 10, 14, 65, " Edicao de dados ", _COR_GET_BOX ) 
           SetColor( _COR_GET_EDICAO ) 
           cComis_:= IF( Comis_ == " ", "N", Comis_ ) 
 
           @ 10, 12 Say  MPR->DESCRI 
 
           /* Edicao */ 
           @ 11,11 Say " Codigo de Fabrica..........:" Get cCodFab 
           @ 12,11 Say " Saldo em estoque...........:" Get nSaldo_ Pict "@E 999,999,999.99" 
           @ 13,11 Say " Reservado por Pedidos......:" Get nReserv Pict "@E 999,999,999.99" 
//           @ 13,11 Say " Com incidencia de comissao?:" Get cComis_ Pict "!" 
           READ 
 
           /* Gravacao */ 
           IF ! LastKey() == K_ESC 
              IF NetRLock() 
                 Replace CodFab With cCodFab,; 
                         Saldo_ With nSaldo_,; 
                         Comis_ With cComis_,; 
                         RESERV With nReserv 
                 AtualizaTabPreco( MPR->INDICE, MPR->DESCRI, MPR->CODFAB ) 
              ENDIF 
           ENDIF 
 
           /* Restaura situacao */ 
           ScreenRest( cTelaRes ) 
           SetColor( _COR_BROWSE ) 
 
      case DBPesquisa( TECLA, oTab ) 
 
      case Tecla == K_F2; DBMudaOrdem( 1, oTab ) 
 
      case Tecla == K_F3; DBMudaOrdem( 2, oTab ) 
 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
 
enddo 
dbunlockall() 
FechaArquivos() 
screenrest(cTELA) 
setcolor(cCOR) 
setcursor(nCURSOR) 
return nil 
 
/* 
* Funcao      - PESQCODIGO 
* Finalidade  - Pesquisa no banco de dados atravez do codigo de controle. 
* Programador - Valmor Pereira Flores / Gelson Oliveira 
* Data        - 14/Setembro/1993 
* Atualizacao - 01/Fevereiro/1994     / 03/05/2002 
*/ 
stat func pesqcodigo(nPCODIGO) 
loca cTELA:=screensave(24-1,00,24,79), nREGISTRO:=recno(), nORDEMG:=dBSetOrder() 
local cTela1 
if val(nPCODIGO)=0; return(.f.); endif 
dbsetorder(1) 
if dbseek(strzero(val(nPCODIGO),3)) 
   cTela1:=screensave(00,00,24,79) 
   SetCursor( 0 ) 
   aviso("Grupo ja cadastrado !!!") 
   Mensagem( "Pressione [Enter] para continuar ..." ) 
   nTECLA:=inkey(0) 
   SetCursor( 1 ) 
   ScreenRest( cTela1 ) 
   screenrest(cTELA) 
   dbgoto(nREGISTRO) 
   dbsetorder(nORDEMG) 
   return(.f.) 
endif 
dbgoto(nREGISTRO) 
dbsetorder(nORDEMG) 
return(.t.) 

/* 
* Modulo      - GRUPOATUALPRECOS
* Descricao   - Atualizacao de precos com base em informacoes dos grupos
* Programador - Valmor Pereira Flores 
* Data        - 03/01/2004 Sabado
*/
Static Function GrupoAtualPrecos( nTipo )
Local cTela:= ScreenSave( 0, 0, 24, 79 ), nCursor:= SetCursor()
Local nArredonda:= 0
Local cCor:= SetColor()
  SetColor( _COR_GET_EDICAO )
  IF IIF( nTipo==Nil, SWAlerta( "<< ATUALIZAR PRECOS >>; Voce deseja realmente atualizar os ;precos dos produtos com base nas; margens informadas na tabela de grupos?", { "Sim, atualizar", "Cancelar" } )==1, .T. )
     IF nTipo == Nil
        VPBox( 0, 0, 22, 79, "ATUALIZACAO DE PRECOS", _COR_GET_EDICAO )
        nArredonda:= SWAlerta( "<< TIPO DE ARREDONDAMENTO >>; Escolha o tipo de arredondamento:", { "2 casas (0.00)", "3 casas (0.000)", "Nenhum" } )
        nTipo:= 0
     ELSEIF nTipo == 1
        VPBox( 0, 0, 22, 79, "AJUSTE DE MARGEM DE LUCRO", _COR_GET_EDICAO )
        IF SWAlerta( "<< MARGEM DE LUCRO >>;Este programa ira atualizar as margens de ;lucro dos produtos sem mudar os precos de compra;dos mesmos.", { "OK", "Cancelar" } )== 2
           SetColor( cCor )
           ScreenRest( cTela )
           Return Nil
        ENDIF
     ENDIF

     MPR->( DBGoTop() )
     WHILE !MPR->( EOF() )
         IF MPR->CLASSE <> " "
            DBSelectAr( _COD_GRUPO )
            DBSetOrder( 1 )
            IF dbSeek( LEFT( MPR->INDICE, 3 ) )
               IF MPR->( RLOCK() )
                  PXF->( DBSetOrder( 1 ) )
                  IF !( PXF->( DBSeek( MPR->INDICE ) ) )
                     PXF->( DBAppend() )
                     Replace PXF->CPROD_ With MPR->INDICE,;
                             PXF->CODFOR With MPR->CODFOR,;
                             PXF->VALOR_ With 0
                  ELSE
                     WHILE MPR->INDICE == PXF->CPROD_ .AND. !PXF->( EOF() )
                          IF PXF->CODFOR == MPR->CODFOR
                             EXIT
                          ENDIF
                          PXF->( DBSkip() )
                     ENDDO
                  ENDIF
                  // Exibe a Descricao da Mercadoria
                  @ 21,01 SAY MPR->DESCRI COLOR "15/" + CorFundoAtual()
                  IF MPR->CLASSE == "A"
                     Replace MPR->PERCPV With MARG_A
                  ELSEIF MPR->CLASSE == "B"
                     Replace MPR->PERCPV With MARG_B
                  ELSEIF MPR->CLASSE == "C"
                     Replace MPR->PERCPV With MARG_C
                  ELSEIF MPR->CLASSE == "D"
                     Replace MPR->PERCPV With MARG_D
                  ENDIF
                  IF nTipo == 0
                     // Calculo do preco de venda
                     Replace MPR->PRECOV With PXF->VALOR_ + ( PXF->VALOR_ * ( MPR->PERCPV / 100 ) )
                     // Preco com desconto
                     Replace MPR->PRECOD With MPR->PRECOV - ( MPR->PRECOV * ( MPR->PERCDC / 100 ) )
                     // Arredondamento dos valores
                     IF nArredonda==1
                        Replace MPR->PRECOV With ROUND( MPR->PRECOV, 2 ),;
                                MPR->PRECOD With ROUND( MPR->PRECOD, 2 )
                     ELSEIF nArredonda==2
                        Replace MPR->PRECOV With ROUND( MPR->PRECOV, 3 ),;
                                MPR->PRECOD With ROUND( MPR->PRECOD, 2 )
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
            MPR->( DBUnlock() )
         ELSE
            @ 21,02 SAY MPR->DESCRI 
         ENDIF
         Scroll( 1, 1, 21, 79, 1 )
         MPR->( DBSkip() )
     ENDDO
  ENDIF
  ScreenRest( cTela )
  SetColor( cCor )





 
