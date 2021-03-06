// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/***** 
�������������Ŀ 
� Funcao      � VPC91320 
� Finalidade  � Movimento de transferencia 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc91900()
#endif

loca nCURSOR:=setcursor(), cCOR:=setcolor(), cTELA, oTAB,; 
     cTELAR:=screensave(00,00,nMAXLIN,nMAXCOL), cTELA2,; 
     dDATA1:=dDATA2:=date(), cTELA0, nTela:= 1 
Local nDebito:= 0, nCredit:= 0 
Local cTipo 
Local dDataLan:= DATE(), aDuplicatas:= {} 
Local nVlrDeb:= 0, nVlrCred:= 0, nVlrSaldo:= 0,; 
      dData:= DATE(), cHistor1:= cHistor2:= Space( 30 ) 
Local aLancamento:= {} 
Local oTab2 
if(!file(_VPB_FORNECEDOR),createvpb(_COD_FORNECEDOR),nil) 
if !fdbusevpb(_COD_DESPESAS,2) 
   return nil 
endif 
dbgotop() 
setcursor(0) 
 
Mensagem("[Tab]Janela [F11]Extrato [F10]MovAtual [F9]At.Saldos [ENTER]Seleciona") 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
 
Set( _SET_DELIMITERS, .F. ) 
 
VPBOX( 13, 00, 22, 40, " Transferencias ", "15/00", .F., .F. ) 
SetColor( "07/00" ) 
@ 14, 02 Say " Saldo.............." 
@ 15, 02 Say " Valor Origem  (Sai)" 
@ 16, 02 Say " Valor Destino (Ent)" 
@ 17, 02 Say " ������������������ " 
@ 18, 02 Say " Historico          " 
SetColor( "15/01" ) 
@ 19, 05 Say Space( 30 ) 
@ 20, 05 Say Space( 30 ) 
SetColor( "07/00" ) 
@ 21, 02 Say " Data Lancamento    " 
 
SetColor( _COR_BROWSE ) 
DBSelectAr( _COD_RECEITAS ) 
DBLeOrdem() 
VPBOX( 00, 00, 12, 40, " Receitas ", _COR_BROW_BOX, .F., .F. ) 
oTAB1:=tbrowsedb( 01, 01, 11, 39 ) 
oTAB1:addcolumn(tbcolumnnew(,{|| STRZERO(REC->CODIGO,4,0)+" "+REC->DESCRI })) 
oTAB1:AUTOLITE:=.F. 
oTAB1:dehilite() 
 
DBSelectAr( _COD_BANCO ) 
dBLeOrdem() 
VPBOX( 00, 41, 12, 79, " Bancos ", _COR_BROW_BOX, .F., .F. ) 
oTAB2:=tbrowsedb( 01, 42, 11, 78 ) 
oTAB2:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,4,0)+" "+DESCRI })) 
oTAB2:AUTOLITE:=.F. 
oTAB2:dehilite() 
 
DBSelectAr( _COD_DESPESAS ) 
DBLeOrdem() 
VPBOX( 13, 41, 22, 79, " Despesas ", _COR_BROW_BOX, .F., .F. ) 
oTAB3:=tbrowsedb( 14, 42, 21, 78 ) 
oTAB3:addcolumn(tbcolumnnew(,{|| STRZERO(CODIGO,4,0)+" "+DESCRI })) 
oTAB3:AUTOLITE:=.F. 
oTAB3:dehilite() 
 
nTela:= 1 
DBSelectAr( _COD_RECEITAS ) 
 
WHILE .T. 
   IF nVlrDeb == 0 
      SetColor( "07/00" ) 
      @ 15, 02 Say " Valor Origem  (Sai)                 " 
      @ 16, 02 Say " Valor Destino (Ent)                 " 
      @ 17, 02 Say " ������������������                  " 
      @ 18, 02 Say " Historico                           " 
      SetColor( "15/01" ) 
      @ 19, 05 Say Space( 30 ) 
      @ 20, 05 Say Space( 30 ) 
      SetColor( "07/00" ) 
      @ 21, 02 Say " Data Lancamento    " 
      SetColor( _COR_BROWSE ) 
   ENDIF 
 
   IF nTela == 1 
      DBSelectAr( _COD_RECEITAS ) 
      oTab1:RefreshCurrent() 
      WHILE !oTab1:Stabilize() 
      ENDDO 
      oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab1:stabilize() 
      enddo 
   ELSEIF nTela == 2 
      DBSelectAr( _COD_BANCO ) 
      oTab2:RefreshCurrent() 
      WHILE !oTab2:Stabilize() 
      ENDDO 
      oTAB2:colorrect({oTab2:ROWPOS,1,oTab2:ROWPOS,oTab2:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab2:stabilize() 
      enddo 
   ELSE 
      DBSelectAr( _COD_DESPESAS ) 
      oTab3:RefreshCurrent() 
      WHILE !oTab3:Stabilize() 
      ENDDO 
      oTab3:colorrect({oTab3:ROWPOS,1,oTab3:ROWPOS,oTab3:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab3:stabilize() 
      enddo 
   ENDIF 
 
   @ 14, 22 Say SALDO_ Pict "@E 9,999,999.99" 
   @ 15, 22 Say nVlrDeb Pict "@E 9,999,999.99" 
 
   IF ( nTecla:=inkey(0) )==K_ESC 
      IF ! nVlrDeb == 0 
         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         Aviso( "Restam valores a serem movimentados!" ) 
         Mensagem( "Pressione [TAB] para sair mesmo assim." ) 
         nTecla:= Inkey(0) 
         IF nTela==K_TAB 
            EXIT 
         ENDIF 
         ScreenRest( cTelaRes ) 
      ELSE 
         EXIT 
      ENDIF 
   ENDIF 
 
   IF nTecla==K_TAB 
      IF nTela == 1 
         nTela:= 2 
      ELSEIF nTela == 2 
         nTela:= 3 
      ELSE 
         nTela:= 1 
      ENDIF 
      IF nTela == 1 
         DBSelectAr( _COD_BANCO ) 
         oTAB2:refreshAll() 
         WHILE !oTab2:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_DESPESAS ) 
         oTAB3:refreshAll() 
         WHILE !oTab3:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_RECEITAS ) 
      ELSEIF nTela == 2 
         DBSelectAr( _COD_RECEITAS ) 
         oTAB1:refreshAll() 
         WHILE !oTab1:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_DESPESAS ) 
         oTAB3:refreshAll() 
         WHILE !oTab3:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_BANCO ) 
      ELSE 
         DBSelectAr( _COD_RECEITAS ) 
         oTab1:refreshAll() 
         WHILE !oTab1:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_BANCO ) 
         oTab2:refreshAll() 
         WHILE !oTab2:Stabilize() 
         ENDDO 
         DBSelectAr( _COD_DESPESAS ) 
      ENDIF 
   ELSEIF nTecla == K_F9 
      nDebito:= 0 
      nCredit:= 0 
      /* Busca de Informacoes & Atualizacao de Saldo */ 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      nAreaRes:= Select() 
      nRegistro:= RECNO() 
      IF nTela == 1 
         cTipo:= "R" 
      ELSEIF nTela == 2 
         cTipo:= "T" 
      ELSEIF nTela == 3 
         cTipo:= "D" 
      ENDIF 
      IF cTipo == "R" 
         DBSelectAr( _COD_RECEITAS ) 
      ELSEIF cTipo == "D" 
         DBSelectAr( _COD_DESPESAS ) 
      ELSEIF cTipo == "T" 
         DBSelectAr( _COD_BANCO ) 
      ENDIF 
      DBGoTop() 
      WHILE !EOF() 
          Ajuda( "Atualizando o Saldo da Conta " + Alltrim( DESCRI ) ) 
          nCodigo:= CODIGO 
          DBSelectAr( _COD_MOVIMENTO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          Index ON DATA__ TO IND001N FOR TCONTA==cTipo .AND. NCONTA==nCodigo EVAL {|| Processo() } 
          DBGoTop() 
          nDebito:= 0 
          nCredit:= 0 
          WHILE !EOF() 
             nDebito:= nDebito + DEBITO 
             nCredit:= nCredit + CREDIT 
             DBSkip() 
          ENDDO 
          IF cTipo == "R" 
             DBSelectAr( _COD_RECEITAS ) 
          ELSEIF cTipo == "D" 
             DBSelectAr( _COD_DESPESAS ) 
          ELSEIF cTipo == "T" 
             DBSelectAr( _COD_BANCO ) 
          ENDIF 
          IF netrlock() 
             Replace SALDO_ With nCredit - nDebito 
          ENDIF 
          IF cTipo == "R" 
             DBSelectAr( _COD_RECEITAS ) 
          ELSEIF cTipo == "D" 
             DBSelectAr( _COD_DESPESAS ) 
          ELSEIF cTipo == "T" 
             DBSelectAr( _COD_BANCO ) 
          ENDIF 
          DBSkip() 
      ENDDO 
      DBSelectAr( _COD_MOVIMENTO ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&gdir/movind01.ntx", "&gdir/movind02.ntx"   
      #else 
        Set Index To "&GDir\MOVIND01.NTX", "&GDir\MOVIND02.NTX"   
      #endif
      DBSelectAr( nAreaRes ) 
      DBGoTo( nRegistro ) 
      ScreenRest( cTelaRes ) 
 
   ELSEIF nTecla == K_F11         /* Tecla F11 - Visualiza todos os lancamentos da conta */ 
      IF nTela == 1 
         cTipo:= "R" 
      ELSEIF nTela == 2 
         cTipo:= "T" 
      ELSEIF nTela == 3 
         cTipo:= "D" 
      ENDIF 
      VisualDiario( cTipo ) 
 
   ELSEIF nTecla == K_F10         /* Tecla F10 - Visualiza lancamentos */
      VisualLancamento( aLancamento ) 
 
   ELSEIF nTecla == K_SH_F8      // by Gelson
      gSemNome( "moviment" )     // busca e exibe movimentos sem origem

   ENDIF 
 
   IF nTela == 1 
      do case 
         case nTecla==K_UP         ;oTab1:up() 
         case nTecla==K_LEFT       ;oTab1:up() 
         case nTecla==K_RIGHT      ;oTab1:down() 
         case nTecla==K_DOWN       ;oTab1:down() 
         case nTecla==K_PGUP       ;oTab1:pageup() 
         case nTecla==K_PGDN       ;oTab1:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
         case nTecla==K_TAB 
         case nTecla==K_INS 
              IF CODIGO == 0 
                 cHistor1:= Space( 30 ) 
                 cHistor2:= Space( 30 ) 
                 dDataLan:= DATE() 
                 nVlrCred:= BuscaDuplicatas( aDuplicatas, @cHistor1 ) 
                 dDataLan:= DATE() 
                 cHistor1:= PAD( cHistor1, 30 ) 
              ENDIF 
              @ 16, 22 Get nVlrCred Pict "@E 9,999,999.99" 
              @ 19, 05 Get cHistor1 
              @ 20, 05 Get cHistor2 
              @ 21, 22 Get dDataLan 
              READ 
              IF !LastKey() == K_ESC .AND. !nVlrCred == 0 
                 LancaMovimento( dDataLan, REC->CODIGO, REC->DESCRI, "R", cHistor1, cHistor2, 0, nVlrCred ) 
                 LancaSaldos( REC->CODIGO, REC->DESCRI, "R", 0, nVlrCred ) 
                 AAdd( aLancamento, { dDataLan,; 
                                   REC->CODIGO,; 
                                   REC->DESCRI,; 
                                   "R",; 
                                   cHistor1,; 
                                   cHistor2,; 
                                   0,; 
                                   nVlrCred } ) 
              ENDIF 
              nVlrSaldo:= 0 
              nVlrCred:= 0 
              nVlrDeb:= 0 
              aDuplicatas:= {} 
         case nTecla==K_ENTER 
              SetCursor( 1 ) 
              IF nVlrDeb == 0 
                 IF REC->SALDO_ <= 0 
                    SetCursor( 0 ) 
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                    Aviso( "Esta conta esta sem saldo!" ) 
                    Pausa() 
                    ScreenRest( cTelaRes ) 
                 ELSE 
                    IF CODIGO == 0 
                       aDuplicatas:= {} 
                       nVlrDeb:= 0 
                       cHistor1:= Space( 30 ) 
                       cHistor2:= Space( 30 ) 
                       cHistor1:= PAD( cHistor1, 30 ) 
                       dDataLan:= DATE() 
                    ELSE 
                       nVlrDeb:= 0 
                       cHistor1:= Space( 30 ) 
                       cHistor2:= Space( 30 ) 
                       dDataLan:= DATE() 
                    ENDIF 
                    @ 15, 22 Get nVlrDeb Pict "@E 9,999,999.99" 
                    @ 19, 05 Get cHistor1 
                    @ 20, 05 Get cHistor2 
                    @ 21, 22 Get dDataLan 
                    READ 
                    IF !LastKey() == K_ESC 
                       LancaMovimento( dDataLan, REC->CODIGO, REC->DESCRI, "R", cHistor1, cHistor2, nVlrDeb, 0 ) 
                       LancaSaldos( REC->CODIGO, REC->DESCRI, "R", nVlrDeb, 0 ) 
                       AAdd( aLancamento, { dDataLan,; 
                                         REC->CODIGO,; 
                                         REC->DESCRI,; 
                                         "R",; 
                                         cHistor1,; 
                                         cHistor2,; 
                                         nVlrDeb,; 
                                         0 } ) 
                       nVlrSaldo:= nVlrDeb 
                    ELSE 
                       nVlrDeb:= 0 
                    ENDIF 
                 ENDIF 
              ELSE 
                 nVlrCred:= 0 
                 dDataLan:= DATE() 
                 @ 16, 22 Get nVlrCred Pict "@E 9,999,999.99" 
                 @ 19, 05 Get cHistor1 
                 @ 20, 05 Get cHistor2 
                 @ 21, 22 Get dDataLan 
                 READ 
                 IF !nVlrCred == 0 
                    LancaMovimento( dDataLan, REC->CODIGO, REC->DESCRI, "R", cHistor1, cHistor2, 0, nVlrCred ) 
                    LancaSaldos( REC->CODIGO, REC->DESCRI, "R", 0, nVlrCred ) 
                    AAdd( aLancamento, { dDataLan,; 
                                         REC->CODIGO,; 
                                         REC->DESCRI,; 
                                         "R",; 
                                         cHistor1,; 
                                         cHistor2,; 
                                         0,; 
                                         nVlrCred } ) 
                     nVlrSaldo:= nVlrSaldo - nVlrCred 
                     nVlrDeb:= nVlrSaldo 
                     nVlrCred:= 0 
                 ENDIF 
              ENDIF 
              SetCursor( 0 ) 
         case nTecla == K_F2 
              DBMudaOrdem( 1, oTab1 ) 
         case nTecla == K_F3 
              DBMudaOrdem( 2, oTab1 ) 
         case DBPesquisa( nTecla, oTab1 ) 
         otherwise 
      endcase 
      oTab1:refreshcurrent() 
      oTab1:stabilize() 
   ELSEIF nTela == 2 
      do case 
         case nTecla==K_UP         ;oTab2:up() 
         case nTecla==K_LEFT       ;oTab2:up() 
         case nTecla==K_RIGHT      ;oTab2:down() 
         case nTecla==K_DOWN       ;oTab2:down() 
         case nTecla==K_PGUP       ;oTab2:pageup() 
         case nTecla==K_PGDN       ;oTab2:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab2:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab2:gobottom() 
         case nTecla==K_ENTER 
              SetCursor( 1 ) 
              IF nVlrDeb == 0 
                 IF BAN->SALDO_ <= 0 
                    SetCursor( 0 ) 
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                    Aviso( "Esta conta esta sem saldo!" ) 
                    Pausa() 
                    ScreenRest( cTelaRes ) 
                 ELSE 
                    nVlrDeb:= 0 
                    cHistor1:= Space( 30 ) 
                    cHistor2:= Space( 30 ) 
                    dDataLan:= DATE() 
                    @ 15, 22 Get nVlrDeb Pict "@E 9,999,999.99" 
                    @ 19, 05 Get cHistor1 
                    @ 20, 05 Get cHistor2 
                    @ 21, 22 Get dDataLan 
                    READ 
                    IF !LastKey() == K_ESC 
                       LancaMovimento( dDataLan, BAN->CODIGO, BAN->DESCRI, "T", cHistor1, cHistor2, nVlrDeb, 0 ) 
                       LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nVlrDeb, 0 ) 
                       AAdd( aLancamento, { dDataLan,; 
                                            BAN->CODIGO,; 
                                            BAN->DESCRI,; 
                                            "T",; 
                                            cHistor1,; 
                                            cHistor2,; 
                                            nVlrDeb,; 
                                            0 } ) 
                      nVlrSaldo:= nVlrDeb 
                    ENDIF 
                 ENDIF 
              ELSE 
                 nVlrCred:= 0 
                 dDataLan:= DATE() 
                 @ 16, 22 Get nVlrCred Pict "@E 9,999,999.99" 
                 @ 19, 05 Get cHistor1 
                 @ 20, 05 Get cHistor2 
                 @ 21, 22 Get dDataLan 
                 READ 
                 IF !nVlrCred == 0 
                    LancaMovimento( dDataLan, BAN->CODIGO, BAN->DESCRI, "T", cHistor1, cHistor2, 0, nVlrCred ) 
                    LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", 0, nVlrCred ) 
                    AAdd( aLancamento, { dDataLan,; 
                                         BAN->CODIGO,; 
                                         BAN->DESCRI,; 
                                         "T",; 
                                         cHistor1,; 
                                         cHistor2,; 
                                         0,; 
                                         nVlrCred } ) 
                    nVlrSaldo:= nVlrSaldo - nVlrCred 
                    nVlrDeb:= nVlrSaldo 
                 ENDIF 
              ENDIF 
              SetCursor( 0 ) 
         case nTecla == K_F2 
              DBMudaOrdem( 1, oTab2 ) 
         case nTecla == K_F3 
              DBMudaOrdem( 2, oTab2 ) 
         case DBPesquisa( nTecla, oTab2 ) 
 
         otherwise 
      endcase 
      oTab2:refreshcurrent() 
      oTab2:stabilize() 
   ELSE 
      do case 
         case nTecla==K_UP         ;oTab3:up() 
         case nTecla==K_LEFT       ;oTab3:up() 
         case nTecla==K_RIGHT      ;oTab3:down() 
         case nTecla==K_DOWN       ;oTab3:down() 
         case nTecla==K_PGUP       ;oTab3:pageup() 
         case nTecla==K_PGDN       ;oTab3:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab3:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab3:gobottom() 
         case nTecla==K_ENTER 
              SetCursor( 1 ) 
              IF nVlrDeb == 0 
                 SetCursor( 0 ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Voce nao pode retirar dinheiro de uma despesa!" ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 nVlrCred:= BuscaPagar( nVlrDeb, cHistor1 ) 
                 dDataLan:= DATE() 
                 @ 16, 22 Get nVlrCred Pict "@E 9,999,999.99" 
                 @ 19, 05 Get cHistor1 
                 @ 20, 05 Get cHistor2 
                 @ 21, 22 Get dDataLan 
                 READ 
                 IF !nVlrCred == 0 
                    LancaMovimento( dDataLan, DES->CODIGO, DES->DESCRI, "D", cHistor1, cHistor2, 0, nVlrCred ) 
                    LancaSaldos( DES->CODIGO, DES->DESCRI, "D", 0, nVlrCred ) 
                    AAdd( aLancamento, { dDataLan,; 
                                         DES->CODIGO,; 
                                         DES->DESCRI,; 
                                         "D",; 
                                         cHistor1,; 
                                         cHistor2,; 
                                         0,; 
                                         nVlrCred } ) 
                    nVlrSaldo:= nVlrSaldo - nVlrCred 
                    nVlrDeb:= nVlrSaldo 
                 ENDIF 
              ENDIF 
              SetCursor( 0 ) 
         case nTecla == K_F2 
              DBMudaOrdem( 1, oTab3 ) 
         case nTecla == K_F3 
              DBMudaOrdem( 2, oTab3 ) 
         case DBPesquisa( nTecla, oTab3 ) 
 
         otherwise 
      endcase 
      oTab3:refreshcurrent() 
      oTab3:stabilize() 
   ENDIF 
enddo 
dbunlockall() 
FechaArquivos() 
dbunlockall() 
/* Fecha arquivos de fornecedor e despesas, 
   para corrigir um defeito detectado no 
   cliente PONTOSUL Relogios, onde toda a vez 
   que fosse cadastrado novo fornecedor o 
   arquivo de indice ficava TRUNCADO */ 
DBSelectAr( _COD_FORNECEDOR ) 
DBCloseArea() 
DBSelectAr( _COD_DESPESAS ) 
DBCloseArea() 
FdbUsevpb( _COD_FORNECEDOR, 2, Nil, .T. ) 
FdbUsevpb( _COD_DESPESAS, 2, Nil ) 
ScreenRest( cTELAR ) 
SetColor( cCOR ) 
SetCursor( nCURSOR ) 
return nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � VISUALLANCAMENTO 
� Finalidade  � Visualizar lancamentos efetuados 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function VisualLancamento( aLancamentos, nSenha )
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nRow:= 1
Local oTab 
Local ngReg, dgData, ngLinha
If nSenha==Nil
   nSenha:= 0
EndIf
  IF Len( aLancamentos ) <= 0 
     Return Nil 
  ENDIF 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 05, 03, 18, 75, " LANCAMENTOS EFETUADOS ", _COR_GET_BOX ) 
  @ 15, 04 Say "� Observacoes �����������������������������������������" 
  oTab:= TBrowseNew( 06, 04, 14, 74 ) 
  oTAB:addcolumn(tbcolumnnew(  "Data          Conta                                Saidas     Entradas ",; 
                               {|| DTOC( aLancamentos[nROW][1] )+ " " +; 
                                  STRZERO( aLancamentos[nRow][2], 4, 0 ) + " " + ; 
                                   Left( aLancamentos[ nRow ][ 3 ], 28 ) + " " +; 
                                   aLancamentos[ nRow ][ 4 ] + " " +; 
                        Tran( aLancamentos[ nRow ][ 7 ], "@EZ 9,999,999.99" ) + " " +; 
                        Tran( aLancamentos[ nRow ][ 8 ], "@EZ 9,999,999.99" ) })) 
  oTAB:AUTOLITE:=.f. 
  oTAB:GOTOPBLOCK :={|| nROW:=1} 
  oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aLancamentos)} 
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aLancamentos,@nROW)} 
  oTAB:dehilite() 
  lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
  WHILE .T. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      WHILE nextkey()==0 .and. ! oTAB:stabilize() 
      ENDDO 
      SetColor( "15/00" )
      ngLinha:= Row()
      @ 16,04 Say aLancamentos[ nRow ][ 5 ] + Space( 20 ) 
      @ 17,04 Say aLancamentos[ nRow ][ 6 ] + Space( 20 ) 
      SetColor( _COR_GET_EDICAO ) 
      nTecla:= Inkey(0) 
      IF nTecla==K_ESC 
         nOpcao:= 0 
         exit 
      ENDIF

      If nSenha==2          // by Gelson
         If nTecla==K_ENTER
            ngReg:= aLancamentos[ nRow, 2 ]
            dgData:= aLancamentos[ nRow, 1 ]
            aLancamentos[ nRow, 1 ]:= gAlterar( ngLinha, ngReg, dgData )
         ElseIf nTecla==K_ALT_EQUALS
            ngReg:= aLancamentos[ nRow, 2 ]
            If ngReg<>0 .and. gExcluir( oTab, ngReg )
               aLancamentos[ nRow, 1 ]:= CtoD( "  /  /  " )
               aLancamentos[ nRow, 2 ]:= 0
               aLancamentos[ nRow, 3 ]:= ""
               aLancamentos[ nRow, 4 ]:= ""
               aLancamentos[ nRow, 5 ]:= "REGISTRO EXCLUIDO...           "
               aLancamentos[ nRow, 6 ]:= "                               "
               aLancamentos[ nRow, 7 ]:= 0
               aLancamentos[ nRow, 8 ]:= 0
            EndIf
         EndIf
      EndIf

      DO CASE 
         CASE nTecla==K_UP         ;oTAB:up() 
         CASE nTecla==K_DOWN       ;oTAB:down() 
         CASE nTecla==K_LEFT       ;oTAB:up() 
         CASE nTecla==K_RIGHT      ;oTAB:down() 
         CASE nTecla==K_PGUP       ;oTAB:pageup() 
         CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
         CASE nTecla==K_PGDN       ;oTAB:pagedown() 
         CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
         CASE nTecla==K_F12        ;Calculador() 
         CASE nTecla==K_CTRL_F10   ;Calendar() 
         OTHERWISE 
      ENDCASE 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � VISUALDIARIO 
� Finalidade  � Visualizar lancamentos efetuados 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function VisualDiario( cTipo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select() 
Local aLancamentos:= {} 
Local nRow:= 1 
Local oTab 
Local nDebito:= 0, nCredit:= 0 
 
 
  IF cTipo == "R" 
     DBSelectAr( _COD_RECEITAS ) 
  ELSEIF cTipo == "D" 
     DBSelectAr( _COD_DESPESAS ) 
  ELSEIF cTipo == "T" 
     DBSelectAr( _COD_BANCO ) 
  ENDIF 
 
  nCodigo:= CODIGO 
  DBSelectAr( _COD_MOVIMENTO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Index ON DATA__ TO IND001N FOR TCONTA==cTipo .AND. NCONTA==nCodigo EVAL {|| Processo() } 
  DBGoTop() 
  WHILE !EOF() 
     nDebito:= nDebito + DEBITO 
     nCredit:= nCredit + CREDIT 
     DBSkip() 
  ENDDO 
  DBGoTop() 
  Mensagem( "Pressione [ESC] para sair" ) 
  lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 05, 03, 18, 75, " LANCAMENTOS EFETUADOS ", _COR_GET_BOX ) 
  @ 15, 04 Say "� Observacoes ����������������������������������������� TOTAIS �������" 
  @ 16, 49 Say Tran( nDebito, "@E 9,999,999.99" ) + " " + Tran( nCredit, "@E 9,999,999.99" ) 
  @ 17, 49 Say " Saldo Atual " + Tran( nCredit - nDebito, "@E 9,999,999.99" ) 
  oTab:= TBrowseDB( 06, 04, 14, 74 ) 
  oTAB:addcolumn(tbcolumnnew(  "Data          Conta                                Saidas     Entradas ",; 
                               {|| DTOC( DATA__ )+ " " +; 
                                  STRZERO( NCONTA, 4, 0 ) + " " + ;
                                   Left( DCONTA, 28 ) + " " +; 
                                   TCONTA + " " +; 
                        Tran( DEBITO, "@EZ 9,999,999.99" ) + " " +; 
                        Tran( CREDIT, "@EZ 9,999,999.99" ) })) 
  oTAB:AUTOLITE:=.f. 
  oTAB:dehilite() 
  WHILE .T. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      WHILE nextkey()==0 .and. ! oTAB:stabilize() 
      ENDDO 
      SetColor( "15/00" ) 
      @ 16,04 Say HISTO1 + Space( 10 ) 
      @ 17,04 Say HISTO2 + Space( 10 ) 
      SetColor( _COR_GET_EDICAO ) 
      nTecla:= Inkey(0) 
      IF nTecla==K_ESC .OR. nTecla == K_TAB 
         IF nTecla == K_TAB 
            Keyboard Chr( K_TAB ) 
         ENDIF 
         nOpcao:= 0 
         exit 
      ENDIF 
      DO CASE 
         CASE nTecla==K_UP         ;oTAB:up() 
         CASE nTecla==K_DOWN       ;oTAB:down() 
         CASE nTecla==K_LEFT       ;oTAB:up() 
         CASE nTecla==K_RIGHT      ;oTAB:down() 
         CASE nTecla==K_PGUP       ;oTAB:pageup() 
         CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
         CASE nTecla==K_PGDN       ;oTAB:pagedown() 
         CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
         CASE nTecla==K_F12        ;Calculador() 
         CASE nTecla==K_CTRL_F10   ;Calendar() 
         CASE nTecla==K_ALT_EQUALS ;Exclui( oTab )
         OTHERWISE 
      ENDCASE 
      oTAB:refreshcurrent() 
      oTAB:stabilize()
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( _COD_MOVIMENTO ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/movind01.ntx", "&gdir/movind02.ntx"   
   #else 
     Set Index To "&GDir\MOVIND01.NTX", "&GDir\MOVIND02.NTX"   
   #endif
   DBSelectAr( nArea ) 
Return Nil 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � BUSCADUPLICATAS 
� Finalidade  � Buscar duplicatas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 02/Setembro/1998 
��������������� 
*/ 
Static Function BuscaDuplicatas( aDuplicatas, cHistorico ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local nValorTotal:= 0 
Local oTab 
cHistorico:= "REF. RECEBIMENTOS N/ DATA " 
DBSelectAr( _COD_DUPAUX ) 
DBLeOrdem() 
VPBOX( 03, 03, 20, 76, " DUPLICATAS DO SISTEMA ", _COR_BROW_BOX, .F., .F. ) 
oTab:=tbrowsedb( 04, 04, 19, 75 ) 
oTab:addcolumn(tbcolumnnew(,{|| STRZERO(CODNF_,6,0)+" "+LEFT( CDESCR, 34 )+" "+Tran( VLR___, "@E 9,999,999.99" ) + " " + DTOC( VENC__ ) + " " + DTOC( DTQT__ )})) 
oTab:AUTOLITE:=.F. 
oTab:dehilite() 
WHILE .T. 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTab:stabilize() 
   enddo 
   IF ( nTecla:=inkey(0) )==K_ESC 
      EXIT 
   ENDIF 
   do case 
      case nTecla==K_UP         ;oTab:up() 
      case nTecla==K_LEFT       ;oTab:up() 
      case nTecla==K_RIGHT      ;oTab:down() 
      case nTecla==K_DOWN       ;oTab:down() 
      case nTecla==K_PGUP       ;oTab:pageup() 
      case nTecla==K_PGDN       ;oTab:pagedown() 
      case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
      case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
      case nTecla==K_ENTER 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           IF !EMPTY( DTQT__ ) 
              Aviso( "Duplicata j� esta quitada!" ) 
              Pausa() 
           ELSE 
              VPBox( 05, 05, 14, 40, "Pagamento", _COR_GET_BOX ) 
              SetColor( _COR_GET_EDICAO ) 
              dData:= DATE() 
              cCheque:= CHEQ__ 
              nValor:= VLR___ 
              nBanco:= 0 
              nLocal_:=   LOCAL_ 
              nJuros:=    JUROS_ 
              nDesconto:= VLRDES 
              nResiduo:=  0 
              dVencimento:= CTOD( "  /  /  " ) 
              cCheque2:= Space( 15 ) 
              nCursorRes:= SetCursor( 1 ) 
              nRecebido:= 0 
              cObservacoes:= OBS___ 
              @ 06,06 Say "Data Pagamento:" Get dData 
              @ 07,06 Say "Cheque........:" Get cCheque 
              @ 08,06 Say "Local.........:" Get nLocal_ 
              @ 09,06 Say "Valor Pago....:" Get nValor Pict "@E 9 999 999.99" Valid TestaValor( @nValor, @nJuros, @nDesconto, @nLocal_, @dData, @nRecebido ) 
              @ 10,06 Say "Juros.........:" Get nJuros Pict "@E 9 999 999.99" 
              @ 11,06 Say "Desconto......:" Get nDesconto Pict "@E 9 999 999.99" 
              @ 12,06 Say "Observacoes...:" Get cObservacoes 
              READ 
              IF !LastKey()==K_ESC 
                 lSaida:= .F. 
                 IF netrlock() 
                    Replace VLR___ With nValor 
                    Replace CHEQ__ With cCheque,; 
                            DTQT__ With dData,; 
                            QUIT__ With "S",; 
                            LOCAL_ With nLocal_ 
                    LancaCliente( CLIENT, nRecebido, 0 ) 
                 ENDIF 
                 nValorTotal:= nValorTotal + nRecebido 
                 IF AT( StrZero( CODNF_, 6, 0 ), cHistorico ) <= 0 
                    cHistorico:= cHistorico + " " + StrZero( CODNF_, 6, 0 ) + "," 
                 ENDIF 
              ENDIF 
              SetCursor( nCursorRes ) 
           ENDIF 
           ScreenRest( cTelaRes ) 
           oTab:RefreshAll() 
           WHILE !oTab:Stabilize() 
           ENDDO 
      case nTecla == K_F2 
           DBMudaOrdem( 1, oTab ) 
      case nTecla == K_F3 
           DBMudaOrdem( 2, oTab ) 
      case nTecla == K_F4 
           DBMudaOrdem( 4, oTab ) 
      case DBPesquisa( nTecla, oTab ) 
      otherwise 
   endcase 
   oTab:refreshcurrent() 
   oTab:stabilize() 
ENDDO 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return nValorTotal 
 
/***** 
�������������Ŀ 
� Funcao      � BUSCAPAGAR 
� Finalidade  � Buscar duplicatas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 02/Setembro/1998 
��������������� 
*/ 
Static Function BuscaPagar( nVlrDisponivel, cHistorico ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local nValorTotal:= 0 
Local oTab 
cHistorico:= "REF. PAGAMENTOS DIVERSOS" 
DBSelectAr( _COD_PAGAR ) 
Set Filter To CODFOR == DES->CODIGO 
DBGoTop() 
DBLeOrdem() 
VPBOX( 03, 03, 20, 76, " CONTAS PAGAS & A PAGAR ", _COR_BROW_BOX, .F., .F. ) 
oTab:=tbrowsedb( 04, 04, 19, 75 ) 
oTab:addcolumn(tbcolumnnew(,{|| DOC___+" "+StrZero( BANCO_, 3, 0 )+" "+Tran( VALOR_, "@E 9,999,999.99" ) + " " + DTOC( VENCIM ) + " " + DTOC( DATAPG ) + " " + CHEQUE })) 
oTab:AUTOLITE:=.F. 
oTab:dehilite() 
WHILE .T. 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTab:stabilize() 
   enddo 
   IF ( nTecla:=inkey(0) )==K_ESC 
      EXIT 
   ENDIF 
   do case 
      case nTecla==K_UP         ;oTab:up() 
      case nTecla==K_LEFT       ;oTab:up() 
      case nTecla==K_RIGHT      ;oTab:down() 
      case nTecla==K_DOWN       ;oTab:down() 
      case nTecla==K_PGUP       ;oTab:pageup() 
      case nTecla==K_PGDN       ;oTab:pagedown() 
      case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
      case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
      case nTecla==K_ENTER 
           IF !EMPTY( DATAPG ) 
              //nValorTotal + VALOR_ > nVlrDisponivel 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Conta j� esta quitada!" ) 
              Pausa() 
              Screenrest( cTelaRes ) 
           ELSE 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 05, 05, 14, 40, "Pagamento", _COR_GET_BOX ) 
              SetColor( _COR_GET_EDICAO ) 
              dData:= DATE() 
              cCheque:= CHEQUE 
              nValor:= VALOR_ 
              nBanco:= 0 
              nResiduo:= 0 
              dVencimento:= CTOD( "  /  /  " ) 
              cCheque2:= Space( 15 ) 
              @ 06,06 Say "Data Pagamento:" Get dData 
              @ 07,06 Say "Cheque........:" Get cCheque 
              @ 08,06 Say "Valor Pago....:" Get nValor Pict "@E 9 999 999.99" 
              @ 09,06 Say "�������������Diferenca�����������-" 
              @ 10,06 Say "Valor.........:" Get nResiduo Pict "@E 9 999 999.99" When PegaDif( VALOR_, nValor, @nResiduo ) 
              @ 11,06 Say "Vencimento....:" Get dVencimento 
              @ 12,06 Say "Banco.........:" Get nBanco Pict "999" Valid PesqBco( @nBanco ) 
              @ 13,06 Say "Cheque........:" Get cCheque2 
              READ 
              IF netrlock() 
                 Replace CHEQUE With cCheque,; 
                         DATAPG With dData,; 
                         QUITAD With "S" 
              ENDIF 
              IF nResiduo > 0 
                 nCodNF_:= NFISC_ 
                 nCodFor:= CODFOR 
                 cObserv:= "PARCELA COMPLEMENTAR (DIF)" 
                 nCodigo:= CODIGO 
                 DBAppend() 
                 IF netrlock() 
                    Replace NFISC_ With nCodNf_,; 
                            CODFOR With nCodFor,; 
                            VALOR_ With nResiduo,; 
                            OBSERV With cObserv,; 
                            BANCO_ With nBanco,; 
                            EMISS_ With DATE(),; 
                            VENCIM With dVencimento,; 
                            CHEQUE With cCheque2,; 
                            CODIGO With nCodigo 
                 ENDIF 
              ENDIF 
              nValorTotal:= nValorTotal + nValor 
              //IF AT( StrZero( NFISC_, 6, 0 ), cHistorico ) <= 0 
              //   cHistorico:= cHistorico + " " + StrZero( NFISC_, 6, 0 ) + "," 
              //ENDIF 
              ScreenRest( cTelaRes ) 
           ENDIF 
      case nTecla == K_F2 
           DBMudaOrdem( 1, oTab ) 
      case nTecla == K_F3 
           DBMudaOrdem( 2, oTab ) 
      case nTecla == K_F4 
           DBMudaOrdem( 4, oTab ) 
      case DBPesquisa( nTecla, oTab ) 
      otherwise 
   endcase 
   oTab:refreshcurrent() 
   oTab:stabilize() 
ENDDO 
Set Filter To 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return nValorTotal 
 
Function PegaDif( nValorPago, nValor, nResiduo ) 
nResiduo:= nValorPago - nValor 
Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � LancaConta 
� Finalidade  � Fazer Lancamentos Contabeis 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function LancaMovimento( dDataLan, nConta, cDescricao, cTipo, ; 
                     cHis1, cHis2, nVlrDeb, nVlrCred ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
DBSelectAr( _COD_MOVIMENTO ) 
DBAppend() 
Replace DATA__ With dDataLan,; 
        NCONTA With nConta,; 
        TCONTA With cTipo,; 
        DCONTA With cDescricao,; 
        HISTO1 With cHis1,; 
        HISTO2 With cHis2,; 
        DEBITO With nVlrDeb,; 
        CREDIT With nVlrCred 
DBSelectAr( nArea ) 
DBUnlockAll() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � LancaSaldos 
� Finalidade  � Fazer Lancamentos nas Respectivas Contas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function LancaSaldos( nConta, cDescricao, cTipo, nVlrDeb, nVlrCred ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
 
   /* Seleciona o arquivo conforme o lancamento */ 
   IF cTipo == "R" 
      DBSelectAr( _COD_RECEITAS ) 
   ELSEIF cTipo == "D" 
      DBSelectAr( _COD_DESPESAS ) 
   ELSEIF cTipo == "T" 
      DBSelectAr( _COD_BANCO ) 
   ENDIF 
 
   /* Faz Lancamentos */ 
   nOrd:= IndexOrd() 
   DBSetOrder( 1 ) 
   IF DBSeek( nConta ) 
      IF netrlock() 
         Replace SALDO_ With SALDO_ + nVlrCred 
         Replace SALDO_ With SALDO_ - nVlrDeb 
      ENDIF 
   ENDIF 
   DBSetOrder( nOrd ) 
 
DBSelectAr( nArea ) 
Return Nil 



/*-------------------------------------------*/
/*  ==>> by Gelson 21/03/2004                */
/*  Localiza todos lancamentos de uma dupl e */
/* exibe na tela possibilitando a alteracao  */
/* da data ou exclusao dos mesmos.           */
/* SHIFT F8   Busca Lancamentos              */
/* ALT =      Exclui Lancamento              */
/* ENTER      Altera data do Lancamento      */
/*-------------------------------------------*/
Function gSemNome( Arquivo )
Local cTela:= SaveScreen( ,,, ), nAreaRes:= Select(), nRegistro:= Recno(),;
      aErro:= {}, nOrdDpa:= DPA->( DBSetOrder() ), nOrdPag:= PAG->( DBSetOrder() ),;
      dData
Local GETLIST:={}

DBSelectAr( _COD_MOVIMENTO )

/// contas a receber
If Upper( Arquivo )=="RECEBER"
   // receber manual
   INDEX ON SUBSTR( HISTO2, 5, 6 ) TO IND001 FOR SUBSTR( HISTO2, 14, 10 )=="000000000#" EVAL {|| Processo() }
   // Receber x notas
   INDEX ON SUBSTR( HISTO2, 14, 10 ) TO IND003 FOR SUBSTR( HISTO2, 12, 1 ) == "D" EVAL {|| Processo() }
   set index to ind001, ind003

   IF dpa->CODIGO > 0
     // Lancamento Manual
     DBSelectAr( _COD_MOVIMENTO )
     DBSetOrder( 1 )
     cDoc:= StrZero( dpa->CODIGO, 6, 0  )
     IF DBSeek( cDoc )
        WHILE SUBSTR( HISTO2, 5, 6 ) == cDoc
           AAdd( aErro, { data__, RECNO(), dconta, tconta, histo1, histo2, debito, credit } )
           DBSkip()
        ENDDO
     ENDIF
   ELSE
     // Duplicatas Nota Fiscal
     DBSetOrder( 2 )
     cDoc:= StrZero( dpa->CODNF_, 9, 0  ) + dpa->LETRA_
     IF DBSeek( cDoc )
        WHILE SUBSTR( HISTO2, 14, 10 ) == cDoc
           AAdd( aErro, { data__, RECNO(), dconta, tconta, histo1, histo2, debito, credit } )
           DBSkip()
        ENDDO
     ENDIF
   ENDIF
   IF Len( aErro ) > 600
      Aadd( aErro, { 0, " REC: Limite de 600 registros excedido." } )
   endif

/// contas a pagar
ElseIf Upper( Arquivo )=="PAGAR"
   INDEX ON SUBSTR( HISTO2, 19, 6 ) TO IND001 EVAL {|| Processo() }
   set index to ind001

   cDoc:= StrZero( pag->CODigo, 6, 0  )
   IF DBSeek( cDoc )
      WHILE SUBSTR( HISTO2, 19, 6 ) == cDoc
         AAdd( aErro, { data__, RECNO(), dconta, tconta, histo1, histo2, debito, credit } )
         DBSkip()
      ENDDO
   ENDIF
   IF Len( aErro ) > 600
      Aadd( aErro, { 0, " REC: Limite de 600 registros excedido." } )
   endif

/// movimentos
ElseIf Upper( Arquivo )=="MOVIMENT"

   PAG->( DBSetOrder( 1 ) )
   DPA->( DBSetOrder( 1 ) )
   DBGoTop()

   Aviso( "Buscando Informacoes, aguarde..." )
   While !Eof()
      cDoc:= ""

      If Upper( Left( HISTO2, 3 ) )=="LAN"
         If Val( SubStr( HISTO2, 5, 6 ) )>0
            cDoc:= SubStr( HISTO2, 5, 6 )
         ElseIf Val( SubStr( HISTO2, 14, 9 ) )>0
            cDoc:= SubStr( HISTO2, 14, 9 )
         Else
            cDoc:= SubStr( HISTO2, 14, 7 )
         EndIf
      ElseIf Upper( Left( HISTO2, 9 ) )=="PAGAMENTO"
         cDoc:= SubStr( HISTO2, 19, 6 )
      ElseIf Upper( Left( HISTO2, 7 ) )=="ESTORNO"
         cDoc:= "99999999"
      EndIf
      dData:= DATA__

      If !( PAG->( DBSeek( Val( cDoc ) ) ) .And. PAG->DATAPG==dData )
         If !( DPA->( DBSeek( Val( cDoc ) ) ) .And. DPA->DTQT__==dData )
            AAdd( aErro, { data__, RECNO(), dconta, tconta, histo1, histo2, debito, credit } )
         EndIf
      EndIf

      If Len( aErro ) > 600
         Aadd( aErro, { 0, " REC: Limite de 600 registros excedido." } )
         Exit
      EndIf

      DBSkip()
   EndDo

EndIf

If Len( aErro ) > 0
   VisualLancamento( aErro, 2 )

ElseIf Upper( Arquivo )=="RECEBER" .And. !Empty( DPA->DTQT__ )

   Set( _SET_DELIMITERS, .T. )

   If Confirma( 12, 63, "Sem Lancamentos para esta duplicata !!!",;
      "Digite [S] para refazer os lancamentos.","S",;
      COR[16]+","+COR[18]+",,,"+COR[17] )

      IF !LastKey() == K_ESC

         nClient:= DPA->Client
         nBANCO_:= DPA->Banc__
         dVENCIM:= DPA->Venc__
         dDATAEM:= DPA->DATAEM
         nNFISC_:= DPA->CODNF_
         nVLRIPI:= DPA->VLRIPI
         nVLRICM:= DPA->VLRICM
         nCodigo:= DPA->Codigo
         cDOC___:= StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_
         dDataPagamento:= DPA->DTQT__
         cBancoDescri:= "<< SEM INFORMACAO >>"
         nBancoSaldo:= 0
         nVALOR_ := DPA->VLR___
         dDATAPG := DPA->DTQT__
         cOBSERV := DPA->OBS___
         nJUROS_ := DPA->JUROS_
         nVlrDes := DPA->VLRDES
         cCHEQUE := DPA->CHEQ__
         nLocal  := DPA->LOCAL_
         nBancoConta:= nLocal

         PesqBco( @nBancoConta )

         cBancoDescri:= BAN->DESCRI
         nBancoSaldo:=  BAN->SALDO_
         cHistorico:= "Lan:" + StrZero( nCodigo, 6, 0 ) + " D:" + cDoc___ + " C:" + StrZero( nClient, 4, 0 )
 
         /* Lancamento de Saida de uma Conta de Transferencia */
         LancaMovimento( dDataPg, nBancoConta, cBancoDescri, "T", "REF. RECEBIMENTO N/ DATA", cHistorico, 0, nValor_ )
         LancaSaldos( nBancoConta, cBancoDescri, "T", 0, nValor_ )
 
         DBSelectAr( _COD_DESPESAS )
         DBSetOrder( 1 )
         DBSeek( nClient )
 
         IF !nJuros_ == 0
            /* Lancamento de Juros */
            LancaMovimento( dDataPg, nBancoConta, cBancoDescri, "T", "JUROS S/ CONTA RECEBIDA", cHistorico, 0, nJuros_ )
            LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", 0, nJuros_ )
         ENDIF

         IF !nVlrDes == 0
            /* Lancamento de Descontos */
            LancaMovimento( dDataPg, nBancoConta, cBancoDescri, "T", "DESCONTO CONCEDIDO", cHistorico, nVlrDes, 0 )
            LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nVlrDes, 0 )
         ENDIF
      EndIf
   EndIf

ElseIf Upper( Arquivo )=="PAGAR" .And. !Empty( PAG->DATAPG )

   Set( _SET_DELIMITERS,.T. )

   If Confirma( 12, 63, "Sem Lancamentos para esta duplicata !!!",;
      "Digite [S] para refazer os lancamentos.","S",;
      COR[16]+","+COR[18]+",,,"+COR[17] )

      IF !LastKey() == K_ESC

         nCODFOR:= PAG->CODFOR
         nBANCO_:= PAG->BANCO_
         dVENCIM:= PAG->VENCIM
         dDATAEM:= PAG->EMISS_
         nNFISC_:= PAG->NFISC_
         nVLRIPI:= PAG->VLRIPI
         nVLRICM:= PAG->VLRICM
         dDentra:= PAG->DENTRA
         nLocal_:= PAG->LOCAL_
         nTabOpe:= PAG->TABOPE
         cCONFIRMA:= "S"
         nCODIGO:= PAG->CODIGO
         cDOC___:= PAG->DOC___
         dDataPagamento:= PAG->DATAPG
         cBancoDescri:= "<< SEM INFORMACAO >>"
         nVALOR_     := PAG->VALOR_
         dDATAPG     := PAG->DATAPG
         cOBSERV     := PAG->OBSERV
         nJUROS_     := PAG->JUROS_
         cCHEQUE     := PAG->CHEQUE
         nBancoConta := PAG->LOCAL_

         PesqBco( @nBancoConta, .T. )

         cBancoDescri:= BAN->DESCRI
         nBancoSaldo:=  BAN->SALDO_
         cHistorico:= "Pagamento n/ data " + StrZero( nCodigo, 6, 0 ) + " D:" + cDoc___ + " C:" + StrZero( nCodFor, 4, 0 )

         /* Lancamento de Saida de uma Conta de Transferencia */
         LancaMovimento( dDataPg, nBancoConta, cBancoDescri, "T", DES->DESCRI, cHistorico, nValor_, 0 )
         LancaSaldos( nBancoConta, cBancoDescri, "T", nValor_, 0 )

         DBSelectAr( _COD_DESPESAS )
         DBSetOrder( 1 )
         DBSeek( nCodFor )

         /* Lancamento de Entrada na Conta Fornecedor/Despesa */
         LancaMovimento( dDataPg, nCodFor, DES->DESCRI, "D", DES->DESCRI, cHistorico, 0, nValor_ )
         LancaSaldos( nCodFor, Des->DESCRI, "D", 0, nValor_ )

         IF !nJuros_ == 0
             /* Lancamento de Juros */
            LancaMovimento( dDataPg, nBancoConta, cBancoDescri, "T", "Juros s/ conta paga", cHistorico, nJuros_, 0 )
            LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nJuros_, 0 )
         ENDIF
      EndIf
   EndIf
Else
   Aviso( "Sem Lancamentos para esta Duplicata !!!" )
   Pausa()
EndIf

Select( nAreaRes )
DBGoTo( nRegistro )
RestScreen( ,,,, cTela )

Retu



/*--------------------------------------------*/
/*  ==>> by Gelson 21/03/2004                 */
/*  Altera data do lancamento de uma dupl     */
/* <ENTER> (gSemNome) Altera Data Lancamento  */
/*--------------------------------------------*/
Function gAlterar( nLinha, nReg, dData )
Local nCursor:= SetCursor()

DBSelectAr( _COD_MOVIMENTO )
Go nReg
If netrlock( 5 )
   SetCursor( 1 )
   @ nLinha, 04 Get dData Color "W/B"
   Read
   Repl data__ With dData
   Unlock
Else
   Aviso( "Impossivel Bloquear o Registro !!!" )
   Pausa()
EndIf

SetCursor( nCursor )
Retu dData



/*-------------------------------------------*/
/*  ==>> by Gelson 21/03/2004                */
/*  Exclui lancamentos de uma dupl           */
/* < ALT = > (gSemNome) Exclui Lancamento    */
/*-------------------------------------------*/
Function gExcluir( oObj, nReg )                      // 594-1411 osmar tintas

DBSelectAr( _COD_MOVIMENTO )
Go nReg
If Recno()==nReg
   Exclui( oObj )
Else
   Aviso( "Lancamento nao existe !!!" )
   Pausa()
EndIf

Retu
