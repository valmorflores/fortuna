// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH" 
#include "PTVERBS.CH" 
#include "BOX.Ch" 
#include "FORMATOS.CH" 
 
/* 
 
  CUPOM FISCAL 
  Visualizacao de Cupom Fiscal 
 
*/ 

#ifdef HARBOUR
function vpc56000()
#endif



  Local nEmpresa:= 0
 
  Local cTELA:=ScreenSave(00,00,24,79), nCURSOR:=setcursor(),; 
       cCOR:=setcolor(), oTB 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
  VPBOX( 0, 0, 24-2, 79, "VERIFICACAO DE CUPONS FISCAIS" , _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. ) 
  cTELAG:=ScreenSave(02,39,22,77) 
  ajuda("["+_SETAS+"][PgDn][PgUp]Move "+; 
        "[ENTER]Seleciona [CTRL-F12]Altera [TAB]Imprime [ESC]Cancela") 
  dbselectar(_COD_CUPOM) 
  dbgobottom() 
  dbLeOrdem() 
  setcursor(0) 
  SetColor( _COR_BROWSE ) 
  Scroll( 19, 00, 24-2, 79 ) 
  DispBox( 19, 00, 24-2, 79, _BOX_UM ) 
 
  Mensagem("[ENTER]Detalhes [F8]Ultima [CTRL_F9]Gerar Pedido") 
 
  ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
        "[F2..F4]Ordem [ESC]Sair") 
  dbgobottom() 
  oTB:=tbrowsedb( 20, 02, 24-3, 79-2 ) 
  oTB:addcolumn(tbcolumnnew(,{|| spac(6)+NFNULA+ Tran( strzero(NUMERO,9,0), "@R 999-999999" ) +"=>"+CDESCR+" "+dtoc(DATAEM)+spac(6) })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  WHILE .T. 
     oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
     mostraCupom() 
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
        case TECLA==K_CTRL_F9 
             nCodCli:= CUP->CLIENT 
             CAU->( DBSetOrder( 5 ) ) 
             CAU->( DBSeek( CUP->NUMERO ) ) 
             aProdutos:= {} 
             while CAU->( CODNF_ ) == CUP->NUMERO 
                 AADD( aProdutos, { CAU->CODRED, CAU->DESCRI, CAU->UNIDAD, CAU->PRECOV, CAU->QUANT_ } ) 
                 CAU->( DBSkip() ) 
             enddo 
             if SWAlerta( "<< CUPOM FISCAL x PEDIDO >>; Gravar pedido com base no cupom?", { "Sim", "Nao" } )==1 
                BuscaEmpresa( @nEmpresa ) 
                nCliente:= TransfereCliente( nCodCli, nEmpresa ) 
                GeraPedido( nEmpresa, nCliente, aProdutos ) 
             endif 
 
        case TECLA==K_CTRL_F12 
             EdicaoCupom() 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
        case DBPesquisa( Tecla, oTB ) 
             IF IndexOrd() == 2 
                BuscaUltima( oTb ) 
             ENDIF 
        case TECLA==K_TAB 
             nReg:= RECNO() 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             cCorRes:= SetColor() 
             nCursor:= SetCursor() 
             nNumeroIni:= 0 
             nNumeroFim:= 999999999 
             dDataIni:= DATE() 
             dDataFim:= DATE() 
             SetCursor( 1 ) 
             VPBox( 03, 05, 17, 44, "FILTRO", _COR_GET_BOX ) 
             SetColor( _COR_GET_EDICAO ) 
             nOpcao:= 1 
             @ 12,06 Prompt " 1> Relacao separada por vendedor  " 
             @ 13,06 Prompt " 2> Relacao geral                  " 
             @ 14,06 Prompt " 3> Relacao geral separada p/data  " 
             @ 15,06 Prompt " 4> Relacao c/ produtos            " 
             @ 16,06 Prompt " 5> Relacao p/ canal               " 
             menu to nOpcao 
 
             nVendedor:= 0 
             cSaida := "V" 
             @ 05,06 Say "Vendedor   " Get nVendedor Pict "999" Valid VenSeleciona( @nVendedor, 1 ) 
             @ 06,06 Say "Emitida de " Get dDataIni 
             @ 07,06 Say "At‚        " Get dDataFim 
             @ 08,06 Say "--------------------------------------" 
             @ 09,06 Say "Numero de  " Get nNumeroIni 
             @ 10,06 Say "At‚        " Get nNumeroFim 
             @ 11,06 Say "Saida          (V)ideo (I)mpressora" 
             @ 11,18 get cSaida pict "@!" valid cSaida $ "VI" 
             READ 
             IF LastKey() <> K_ESC 
                if cSaida == "V" 
                   Set( 24, "TELA0000.TMP" ) 
                else 
                   Set( 24, "LPT1" ) 
                endif 
                DO CASE 
                   CASE nOpcao==1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                        INDEX ON STRZERO( VENIN_, 3, 0 ) + DTOS( DATAEM ) + STRZERO( NUMERO, 9, 0 ) TO INDTMPC FOR DATAEM >= dDataIni .AND. DATAEM <= dDataFim .AND. NUMERO >= nNumeroIni .AND. NUMERO <= nNumeroFim .AND. ( VENIN_ = nVendedor .OR. nVendedor==0 ) 
                        Relatorio( "CUPOMV.REP" ) 
                   CASE nOpcao==2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                        INDEX ON STRZERO( NUMERO, 9, 0 ) TO INDTMPC FOR DATAEM >= dDataIni .AND. DATAEM <= dDataFim .AND. NUMERO >= nNumeroIni .AND. NUMERO <= nNumeroFim .AND. ( VENIN_ = nVendedor .OR. nVendedor==0 ) 
                        Relatorio( "CUPOM_.REP" ) 
                   CASE nOpcao==3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                        INDEX ON DTOS( DATAEM ) + STRZERO( NUMERO, 9, 0 ) TO INDTMPC FOR DATAEM >= dDataIni .AND. DATAEM <= dDataFim .AND. NUMERO >= nNumeroIni .AND. NUMERO <= nNumeroFim .AND. ( VENIN_ = nVendedor .OR. nVendedor==0 ) 
                        Relatorio( "CUPOMX.REP" ) 
                   CASE nOpcao==4 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                        INDEX ON STRZERO( NUMERO, 9, 0 ) TO INDTMPC FOR DATAEM >= dDataIni .AND. DATAEM <= dDataFim .AND. NUMERO >= nNumeroIni .AND. NUMERO <= nNumeroFim .AND. ( VENIN_ = nVendedor .OR. nVendedor==0 ) 
                        Relatorio( "CUPOMC.REP" ) 
                   CASE nOpcao==5 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                        INDEX ON DTOS( DATAEM ) + STRZERO( NUMERO, 9, 0 ) TO INDTMPC FOR DATAEM >= dDataIni .AND. DATAEM <= dDataFim 
                        Relatorio( "CUPOML.REP" ) 
                ENDCASE 
                if cSaida == "V" 
                   VerArquivo( "TELA0000.TMP" ) 
                endif 
                Set( 24, "LPT1" ) 
             ENDIF 
             ScreenRest( cTelaRes ) 
             SetColor( cCorRes ) 

             // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
             #ifdef LINUX
               set index to "&gdir/cupind01.ntx",; 
                            "&gdir/cupind02.ntx",; 
                            "&gdir/cupind03.ntx",; 
                            "&gdir/cupind04.ntx",; 
                            "&gdir/cupind05.ntx" 
             #else
               Set Index To "&GDir\CUPIND01.NTX",; 
                            "&GDir\CUPIND02.NTX",; 
                            "&GDir\CUPIND03.NTX",; 
                            "&GDir\CUPIND04.NTX",; 
                            "&GDir\CUPIND05.NTX" 

             #endif
 
             SetCursor( nCursor ) 
             DBGoTo( nReg ) 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
        case TECLA==K_DEL 
 
             cTELA1:=ScreenSave(00,00,24,MaxCol()) 
             dbselectar(_COD_CUPOM ) 
             nNUMERO=NUMERO 
             IF NFNULA == "*" 
                Aviso( "Nota Fiscal anulada! Impossivel Excluir." ) 
                Pausa() 
                ScreenRest( cTela1 ) 
                Loop 
             ENDIF 
             If Confirma( , , "Confirma?", , "N" ) 
                Mensagem( "Aguarde, excluindo nota fiscal...." ) 
                aviso("Aguarde, limpando arquivos...",24/2) 
                IF NetRLock() 
                   DBDelete() 
                EndIf 
                DBUnlock() 
                Mensagem( "Aguarde, excluindo as duplicatas desta nota fiscal..." ) 
                DBSelectAr( _COD_DUPAUX ) 
                DBSetOrder( 1 ) 
                IF DBSeek( nNumero ) 
                   WHILE !EOF() 
                      nBanco:= LOCAL_ 
                      PesqBco( @nBanco ) 
                      cBancoDescri:= BAN->DESCRI 
                      IF TIPO__ == "03" .AND. nNumero == CODNF_ 
                         IF !Empty( DTQT__ ) 
                            LancaMovimento( DATE(), nBanco, cBancoDescri, "T", "ESTORNO P/ EXCLUSAO NF", "", VLR___, 0 ) 
                            LancaSaldos( nBanco, cBancoDescri, "T", VLR___, 0 ) 
                            IF JUROS_ > 0 
                               LancaMovimento( DATE(), nBanco, cBancoDescri, "T", "ESTORNO JUROS P/ EXCLUSAO", "NOTA FISCAL", JUROS_, 0 ) 
                               LancaSaldos( nBanco, cBancoDescri, "T", JUROS_, 0 ) 
                            ENDIF 
                         ELSE 
                            CliInfo( DPA->CLIENT, DPA->VLR___, "+" ) 
                         ENDIF 
 
                         IF NetRlock() 
                            DBDelete() 
                         ELSE 
                            Aviso( "Falha na exclusao do arquivo!" ) 
                            Pausa() 
                         ENDIF 
 
                      ELSE 
                         IF !CODNF_ == nNumero 
                            Exit 
                         ENDIF 
                      ENDIF 
                      DBSkip() 
                   ENDDO 
                ENDIF 
                Mensagem( "Aguarde, excluindo produtos da nota fiscal..." ) 
                DBSelectar( _COD_CUPOMAUX ) 
                DBSetOrder( 5 ) 
                IF DBSeek( nNumero ) 
                   WHILE CodNf_ == nNumero 
                       IF PRECOV > 0 
                          PoeNoEstoque( CODRED, QUANT_ ) 
                       ENDIF 
                       IF NetRLock() 
                          DBDelete() 
                       Endif 
                       DBUnlockAll() 
                       DBSkip() 
                   ENDDO 
                ENDIF 
                DBSetOrder( 1 ) 
                Set Filter To 
                Mensagem( "Atualizando a tela principal..." ) 
                DBSelectAr( _COD_NFISCAL ) 
                Set Filter To 
 
                DBSelectAr( _COD_ESTOQUE ) 
                DBSetOrder( 3 ) 
                cNumero:= "CF:" 
                IF DBSeek( cNumero, .T. ) 
                   WHILE AT( "CF:", DOC___ ) > 0 
                      IF AT( STRZERO( nNumero, 9, 0 ), DOC___ ) > 0 .OR.; 
                         AT( STRZERO( nNumero, 6, 0 ), DOC___ ) > 0 
                         IF NetRLock() 
                            DELE 
                         ENDIF 
                         DBUnlockAll() 
                      ENDIF 
                      DBSkip() 
                   ENDDO 
                ENDIF 
                DBSetOrder( 1 ) 
                DBSelectAr( _COD_CUPOM ) 
             ENDIF 
             ScreenRest( cTela1 ) 
             oTb:RefreshAll() 
             WHILE !oTb:Stabilize() 
             ENDDO 
        case TECLA==K_F2         ;DBMudaOrdem( 1, oTB ) 
        case TECLA==K_F3         ;DBMudaOrdem( 2, oTB ) 
        case TECLA==K_F4         ;DBMudaOrdem( 3, oTB ) 
        case TECLA==K_F5         ;DBMudaOrdem( 5, oTB ) 
        case TECLA==K_ENTER 
             IF Numero == 0 
                Loop 
             ENDIF 
             cCONREV:=CONREV 
             nBASICM:=BASICM 
             nVLRTOT:=VLRTOT 
             nVLRNOT:=VLRNOT 
             nVLRIPI:=VLRIPI 
 
             nNUMERO:=NUMERO 
             cTELAR:={NIL,NIL,NIL,NIL} 
             cTELAR[1]:=ScreenSave(00,00,24,79) 
             cCORRES:=setcolor() 
             dbselectar(_COD_CUPOMAUX) 
             dbgotop() 
             setcolor( _COR_ALERTA_LETRA ) 
             nLIN=3 
             Mensagem("Lendo arquivo de produtos, aguarde...") 
             DBSetOrder( 5 ) 
             DBSeek( nNumero ) 
             aProdutos:= 0 
             aProdutos:= {} 
             whil CODNF_ == nNumero 
                Mensagem("Pesquisando registro #"+strzero(recno(),4,0)+", aguarde...") 
                AAdd( aProdutos, { Tran( CodRed, "@R 999-9999" ),; 
                                   SubStr( Descri, 1, 24 ),; 
                                   StrZero( icmCod, 1, 0 ),; 
                                   StrZero( ipiCod, 1, 0 ),; 
                                   Tran( Quant_, "@E 99999.99" ),; 
                                   Tran( Precov, "@E 99999.999" ),; 
                                   Tran( PrecoT, "@E 999,999.999" ),; 
                                   Tran( PerIcm, "@E 999.99" ) } ) 
                DBSkip() 
             enddo 
             ExibeProdLista( aProdutos ) 
             cTELAR[2]:=ScreenSave(00,00,24-2,79) 
             if lastkey()<>K_ESC 
                dbselectar(_COD_CUPOM) 
                vpbox( 03, 02, 20, 75, "Diversos", _COR_ALERTA_BOX, .T., .F., _COR_ALERTA_TITULO ) 
                SetColor( _COR_ALERTA_LETRA ) 
                @ 04,4 say "Frete.......:"+tran(FRETE_,"@E 999,999,999.99") 
                @ 05,4 say "Seguro......:"+tran(SEGURO,"@E 999,999,999.99") 
                @ 06,4 say "Marca.......: Nao utilizado" 
                @ 07,4 say "Numero......: Nao utilizado" 
                @ 08,4 say "Quantidade..:"+QUANT_ 
                @ 09,4 say "Data Saida..:"+dtoc(SAIDAT) 
                @ 10,4 say "Hora Saida..:"+tran(SAIHOR,"@R XX:XX.XX") 
                @ 11,4 say "Especie.....:"+ESPEC_ 
                @ 12,4 say "Peso liquido:"+tran(PESOLI,"9999.99") 
                @ 13,4 say "Peso Bruto..:"+tran(PESOBR,"9999.99") 
                @ 14,4 say "Obs:"+OBSER1 
                @ 15,4 say "   :"+OBSER2 
                @ 16,4 say "   :"+OBSER3 
                @ 17,4 say "   :"+OBSER4 
                @ 18,4 say "   :"+OBSER5 
                VPBox( 05, 56, 15, 73, "O.COMPRA", _COR_ALERTA_BOX, .F., .F., _COR_ALERTA_TITULO, .F.  ) 
                @ 07,58 Say SubStr( ORDEMC, 1,  10 ) 
                @ 08,58 Say SubStr( ORDEMC, 11, 10 ) 
                @ 09,58 Say SubStr( ORDEMC, 21, 10 ) 
                @ 10,58 Say SubStr( ORDEMC, 31, 10 ) 
                @ 11,58 Say SubStr( ORDEMC, 41, 10 ) 
                @ 12,58 Say SubStr( ORDEMC, 51, 10 ) 
                VPBox( 16, 56, 19, 73, " PEDIDO ", _COR_ALERTA_BOX, .F., .F., _COR_ALERTA_TITULO, .F.  ) 
                @ 18,58 Say StrZero( PEDIDO, 8, 0 ) 
                cTELAR[3]:=ScreenSave(00,00,24-2,79) 
             endif 
             inkey(0) 
             if lastkey()<>K_ESC 
                dbselectar(_COD_DUPAUX) 
                dbsetorder(1) 
                dbseek(nNUMERO) 
                aDuplicatas:= 0 
                aDuplicatas:= {} 
                WHILE CODNF_ == nNumero 
                    IF TIPO__ == "03" 
                       AAdd( aDuplicatas, { Str( DUPL__, 10, 0 ),; 
                                            LETRA_,; 
                                            Tran( PERC__, "@E 999.99" ),; 
                                            Tran( VLR___, "@E 9,999,999.99" ),; 
                                            DTOC( VENC__ ),; 
                                            DTOC( DTQT__ ),; 
                                            StrZero( BANC__, 3, 0 ),; 
                                            CHEQ__,; 
                                            StrZero( LOCAL_, 3, 0 ) } ) 
 
                    ENDIF 
                    DBSkip() 
                ENDDO 
                ExibeDupLista( aDuplicatas ) 
 
 
                cTELAR[4]:=ScreenSave(00,00,24-2,79) 
                nMOD:=4 
                ajuda("["+_SETAS+"]Movimenta [ESC]Retorna") 
                Mensagem("Utilize as teclas ["+_SETAS+"] p/ movimentar entre telas.") 
                whil inkey(0)<>K_ESC 
                   if lastkey()=K_DOWN .OR. lastkey()=K_RIGHT 
                      if nMOD=2 
                         exit 
                      endif 
                      if nMOD>2 
                         --nMOD 
                      endif 
                   elseif lastkey()=K_UP .OR. lastkey()=K_LEFT 
                      if nMOD<4 
                         ++nMOD 
                      endif 
                   endif 
                   If !Empty( cTelar ) 
                      If Len( cTelar ) >= nMod 
                         If cTelaR[nMod] <> Nil 
                            ScreenRest( cTELAR[nMOD] ) 
                         EndIf 
                      Endif 
                   Endif 
                enddo 
             endif 
             dbselectar(_COD_CUPOM) 
             ScreenRest(cTELAR[1]) 
             setcolor(cCORRES) 
        case TECLA==K_F8         ;BuscaUltima( oTb ) 
        otherwise                ;tone(125); tone(300) 
   endcase 
   oTB:refreshcurrent() 
   oTB:stabilize() 
enddo 
dbunlockall() 
FechaArquivos() 
setcolor(cCOR) 
setcursor(nCURSOR) 
ScreenRest(cTELA) 
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
Static Function BuscaUltima( oTb ) 
Local cTela:= ScreenSave( 23, 00, 24, 79 ) 
Mensagem( "Pesquisando a ultima nota fiscal, aguarde..." ) 
 
IF !( IndexOrd() == 2 ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
 
cDescri:= CDESCR 
cDesRes:= CDESCR 
oTb:GoTop() 
DBSeek( cDescri, .T. ) 
WHILE !EOF() 
   Mensagem( "Buscando nota fiscal numero: " + StrZero( Numero, 6, 0 ) + ", aguarde..." ) 
   IF CDESCR == cDescri 
      DBSkip() 
   ELSE 
      DBSkip( -1 ) 
      EXIT 
   ENDIF 
ENDDO 
IF EOF() .OR. BOF() 
   DBSeek( cDesRes, .T. ) 
ENDIF 
 
ScreenRest( cTela ) 
oTb:RefreshAll() 
WHILE !oTb:Stabilize() 
ENDDO 
Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ MostraCupom 
³ Finalidade  ³ Apresentar informacoes gravadas nocupom fiscal 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function MostraCupom() 
Local cCor:= SetColor() 
  SetColor( _COR_GET_BOX ) 
  @ 02,03 Say "C U P O M          [" + Tran( StrZero( NUMERO, 9, 0 ), "@R 999-999999" ) +"]" 
  @ 03,03 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 04,03 Say "Data.............: ["+DTOC(DATAEM)+"]" 
  @ 05,03 Say "Cliente..........: ["+strzero(CLIENT,6,0)+"]-[" + CDESCR + "]" 
  @ 06,03 Say "Endereco.........: ["+CENDER + "]" 
  @ 07,03 Say "Bairro...........: ["+CBAIRR + "]" 
  @ 08,03 Say "Cidade...........: ["+CCIDAD + "-" + CESTAD + "] Fone: [" + CFONE2 + "]" 
  @ 09,03 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 10,03 Say "Vend. Interno....: ["+strzero(VENIN_,4,0)+"]" 
  @ 11,03 Say "Vend. Externo....: ["+strzero(VENEX_,4,0)+"]" 
  VEN->( DBSetOrder(1)) 
  VEN->( DBSeek( CUP->VENIN_ ) ) 
  @ 10,32 Say VEN->DESCRI 
  VEN->( DBSeek( CUP->VENEX_ ) ) 
  @ 11,32 Say VEN->DESCRI 
  @ 12,03 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 13,03 Say "Total Mercadorias: ["+tran(VLRNOT,"@E 999,999,999.99")+"]" 
  @ 14,03 Say "Valor IPI total..: ["+tran(VLRIPI,"@E 999,999,999.99")+"]" 
  @ 15,03 Say "Vlr. total da NF.: ["+tran(VLRTOT,"@E 999,999,999.99")+"]" 
  @ 16,03 Say "Base de calc. ICM: ["+tran(BASICM,"@E 999,999,999.99")+"]" 
  @ 17,03 Say "Valor ICMs.......: ["+tran(VLRICM,"@E 999,999,999.99")+"]" 
  @ 18,03 Say "Condicao Pgto....: ["+tran(NVEZES,"9")+"][" + StrZero( TABCND, 4, 0 ) + "]" 
 
  @ 14,43 Say "ÚÄInformacoes AdicionaisÄÄÄÄÄÄÄÄÄÄ¿" 
  @ 15,43 Say "³ " + LEFT( OBSER1, 31 ) + " ³" 
  @ 16,43 Say "³ " + LEFT( OBSER2, 31 ) + " ³" 
  @ 17,43 Say "³ " + LEFT( OBSER3, 31 ) + " ³" 
  @ 18,43 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" 
 
SetColor( cCor ) 
Return(.T.) 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ExibeDupLista 
³ Finalidade  ³ Exibir a lista de produtos da nota fiscal 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function ExibeDupLista( aDuplicatas ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, nRow:= 1 
 
   IF Len( aDuplicatas ) <= 0 
      Return Nil 
   ENDIF 
 
   VPBox( 01, 01, 16, 71, "DUPLICATAS", _COR_ALERTA_LETRA ) 
   SetColor( _COR_BROWSE ) 
   SetColor( _COR_ALERTA_LETRA ) 
   oTab:=tbrowseNew( 02, 02, 15, 70 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| aDuplicatas[ nRow ][ 1 ] })) 
   oTab:addcolumn(tbcolumnnew("L",{|| aDuplicatas[ nRow ][ 2 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 3 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 4 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 5 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 6 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 7 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| Left( aDuplicatas[ nRow ][ 8 ], 13 ) })) 
   oTab:GoTopBlock:= {|| nRow:= 1 } 
   oTab:GoBottomBlock:= {|| nRow:= Len( aDuplicatas ) } 
   oTab:SkipBlock:= {|x| SkipperArr( x, aDuplicatas, @nRow ) } 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
       oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
       whil nextkey()=0 .and.! oTab:stabilize() 
       enddo 
       setcolor(COR[25]) 
       TECLA:=inkey(0) 
       if TECLA=K_ESC 
          exit 
       endif 
       do case 
          case TECLA==K_UP         ;oTab:up() 
          case TECLA==K_LEFT       ;oTab:up() 
          case TECLA==K_RIGHT      ;oTab:down() 
          case TECLA==K_DOWN       ;oTab:down() 
          case TECLA==K_PGUP       ;oTab:pageup() 
          case TECLA==K_PGDN       ;oTab:pagedown() 
          case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
          case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
          case TECLA==K_ENTER .OR. TECLA=K_TAB 
               exit 
          otherwise                ;tone(125); tone(300) 
       endcase 
       oTab:refreshcurrent() 
       oTab:stabilize() 
   enddo 
   setcursor(nCURSOR) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ExibeProdLista 
³ Finalidade  ³ Exibir a lista de produtos da nota fiscal 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function ExibeProdLista( aProdutos ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, nRow:= 1 
 
   IF Len( aProdutos ) <= 0 
      Return Nil 
   ENDIF 
 
   VPBox( 01, 01, 21, 77, "PRODUTOS", _COR_ALERTA_LETRA ) 
   SetColor( _COR_BROWSE ) 
   SetColor( _COR_ALERTA_LETRA ) 
   oTab:=tbrowseNew( 02, 02, 20, 76 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| aProdutos[ nRow ][ 1 ] })) 
   oTab:addcolumn(tbcolumnnew("Descricao",{|| aProdutos[ nRow ][ 2 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 3 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 4 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 5 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 6 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 7 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 8 ] })) 
   oTab:GoTopBlock:= {|| nRow:= 1 } 
   oTab:GoBottomBlock:= {|| nRow:= Len( aProdutos ) } 
   oTab:SkipBlock:= {|x| SkipperArr( x, aProdutos, @nRow ) } 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
       oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
       whil nextkey()=0 .and.! oTab:stabilize() 
       enddo 
       setcolor(COR[25]) 
       TECLA:=inkey(0) 
       if TECLA=K_ESC 
          exit 
       endif 
       do case 
          case TECLA==K_UP         ;oTab:up() 
          case TECLA==K_LEFT       ;oTab:up() 
          case TECLA==K_RIGHT      ;oTab:down() 
          case TECLA==K_DOWN       ;oTab:down() 
          case TECLA==K_PGUP       ;oTab:pageup() 
          case TECLA==K_PGDN       ;oTab:pagedown() 
          case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
          case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
          case TECLA==K_ENTER .OR. TECLA=K_TAB 
               exit 
          otherwise                ;tone(125); tone(300) 
       endcase 
       oTab:refreshcurrent() 
       oTab:stabilize() 
   enddo 
   setcursor(nCURSOR) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
 
Function EdicaoCupom() 
Local cTela:= ScreenSAve( 0, 0, 24, 79 ) 
Local cCor:= SetColor(), nCursor:= SetCursor() 
Local nNumero:= CUP->Numero, dData:= CUP->DATAEM, nVendedor:= CUP->VENIN_,; 
      cObser1:= CUP->OBSER1, cObser2:= CUP->OBSER2 
      dDataOriginal:= CUP->DATAEM 
 
      VPBox( 05, 05, 12, 70, "ALTERACAO DE INFORMACOES - CUPOM", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      SetCursor( 1 ) 
      @ 07, 08 Say "Numero.....: [" + StrZero( CUP->NUMERO, 09, 0 ) + "]" 
      @ 08, 08 Say "Data.......:" Get dData 
      @ 09, 08 Say "Vendedor...:" Get nVendedor Valid VenSeleciona( @nVendedor, 1 ) 
      @ 10, 08 Say "Informacoes:" Get cObser1 Pict "@S30" 
      @ 11, 08 Say "            " Get cObser2 Pict "@S30" 
      READ 
      IF CUP->( NetRLOck() ) 
         Replace CUP->DATAEM With dData,; 
                 CUP->VENIN_ With nVendedor,; 
                 CUP->OBSER1 With cObser1,; 
                 CUP->OBSER2 With cObser2 
         IF dData <> dDataOriginal 
            DBSelectAr( _COD_DUPAUX ) 
            DBSetOrder( 1 ) 
            IF DBSeek( nNumero ) 
               WHILE !EOF() 
                  IF TIPO__ == "03" .AND. nNumero == CODNF_ 
                     IF !Empty( DTQT__ ) 
                        IF NetRLock() 
                           Replace DATAEM With dData,; 
                                   DTQT__ With dData 
                        ENDIF 
                     ELSE 
                        IF NetRLock() 
                           Replace DATAEM With dData 
                        ENDIF 
                     ENDIF 
                  ELSE 
                     IF !CODNF_ == nNumero 
                        Exit 
                     ENDIF 
                  ENDIF 
                  DBSkip() 
               ENDDO 
            ENDIF 
         ENDIF 
      ENDIF 
      SetCursor( nCursor ) 
      SetColor( cCor ) 
      ScreenRest( cTela ) 
      DBSelectAr( "CUP" ) 
      Return Nil 
 
 
