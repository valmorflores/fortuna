// ## CL2HB.EXE - Converted
#include "inkey.ch" 
#Include "vpf.ch" 
 
/* 
*      Funcao - VPC910000 
*  Finalidade - Movimentar Caixa 
*        Data - 
* Atualizacao - 
* Programador - VALMOR PEREIRA FLORES 
*/

#ifdef HARBOUR
function vpc91500()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, cDescri, cTelaRes, nTotal:= 0, nOpcao:= 1 
Local nMotivo:= 0 
Private nCodigo:= 1 
 
   IF !AbreGrupo( "CAIXA" ) 
      Return Nil 
   ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   WHILE .T. 
      DBSelectAr( _COD_CAIXA ) 
      SetCursor( 1 ) 
      SetColor( _COR_GET_EDICAO ) 
      /* Seleciona o caixa operador para fazer a manutencao de dinheiro */ 
      VPBox( 00, 00, 22, 79, "Fluxo de Caixa (PDV/Operador)", _COR_GET_BOX, .F., .F. ) 
      @ 02, 02 Say "Caixa Operador:" Get nCodigo Pict "999" When Mensagem( "Digite o codigo do operador." ) 
      READ 
      IF LastKey() == K_ESC 
         Exit 
      ENDIF 
      IF nCodigo > 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On DATAMV To INDICE93.TMP For VENDE_ == nCodigo Eval {|| Processo() } 
      ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On DATAMV To INDICE93.TMP Eval {|| Processo() } 
      ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Set Index To INDICE93.TMP 
      DBGoTop() 
      nTotal:= 0 
      While !Eof() 
          /* Verifica cupons fiscais cancelados */ 
          IF AT( "CANC", HISTOR ) > 0 
             nValor:= VALOR_ 
             cHistorico:= HISTOR 
             DBSkip( -1 ) 
             IF VALOR_ == nValor .AND.; 
                ALLTRIM( StrTran( cHistorico, "-CANCELADO!", "" ) ) == ALLTRIM( HISTOR ) 
                DBSkip() 
                IF ENTSAI == "+" 
                   nTotal+= VALOR_ 
                ELSE 
                   nTotal-= VALOR_ 
                ENDIF 
             ELSE 
                DBSkip() 
             ENDIF 
          ELSE 
             IF EntSai == "+" 
                nTotal+= VALOR_ 
             ELSE 
                nTotal-= VALOR_ 
             ENDIF 
          ENDIF 
          DBSkip() 
      Enddo 
      SetColor( _COR_BROWSE ) 
      VPBox( 00, 00, 03, 79, , _COR_BROW_BOX, .F., .F. ) 
      @ 01,01 Say  " Valor Disponivel em caixa (R$)......: " + Tran( nTotal, "@E 999,999,999.99" ) 
      VPBox( 03, 00, 22, 79, "FLUXO DE CAIXA", _COR_BROW_BOX, .F., .F. ) 
      SetCursor(0) 
      Mensagem( "Pressione [ENTER] para ver resumo ou [INS] para movimentar o caixa." ) 
      ajuda("["+_SETAS+"][PgUp][PgDn]Move [ENTER]Resumo [TAB]Imprime [INS]Novo [ESC]Retorna") 
      DBGoTop() 
      oTab:=tbrowsedb( 04, 01, 20, 77 ) 
      oTab:AddColumn( TbColumnNew( ,{|| "(" + DTOC( DATAMV ) + "-" + HORAMV + ") " + StrZero( VENDE_, 3, 0 ) + " " + DispMotivo( MOTIVO ) + ; 
                      " " + LEFT( IF( ALLTRIM( HISTOR )=="VENDA AO CONSUMIDOR", Space( 30 ), HISTOR ), 18 ) + " " + Tran( VALOR_, "@E 999,999,999.99" ) + IF( ENTSAI=="+", " ", "-" ) })) 
      oTab:AUTOLITE:=.f. 
      oTab:dehilite() 
      whil .t. 
         oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTab:stabilize() 
         enddo 
         nTecla:=inkey(0) 
         If nTecla=K_ESC 
            exit 
         EndIf 
         do case 
            case nTecla==K_UP         ;oTab:up() 
            case nTecla==K_LEFT       ;oTab:up() 
            case nTecla==K_RIGHT      ;oTab:down() 
            case nTecla==K_DOWN       ;oTab:down() 
            case nTecla==K_PGUP       ;oTab:pageup() 
            case nTecla==K_PGDN       ;oTab:pagedown() 
            case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
            case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
            case nTecla==K_TAB 
                 IF Confirma( 0, 0, "Imprimir?", "Imprimir o caixa?", "S" ) 
                    Relatorio( "PEQCAIXA.REP" ) 
                 ENDIF 
            case nTecla==K_ENTER 
                 IF nCodigo > 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    Index On DATAMV To INDICE93.TMP For VENDE_ == nCodigo Eval {|| Processo() } 
                 ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    Index On DATAMV To INDICE93.TMP Eval {|| Processo() } 
                 ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Set Index To INDICE93.TMP 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 VPBox( 02, 05, 22, 76, "RESUMO DE MOVIMENTACOES", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 nSaldo:= 0 
                 nVenda:= 0 
                 nDifCaixa:= 0 
                 nRetFec:= 0 
                 nDevolucao:= 0 
                 nOutras:= 0 
                 nTrocas:= 0 
                 nRetTroca:= 0 
                 nIndefinido:= 0 
                 nReg:= RECNO() 
                 DBGoTop() 
                 WHILE !EOF() 
                    DO CASE 
                       CASE MOTIVO==05 
                            nDevolucao+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==03 
                            nSaldo+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==00 
                            nVenda+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==01 
                            nRetFec+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==07 
                            nOutras+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==02 
                            nRetTroca+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==04 
                            nTrocas+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       CASE MOTIVO==06 
                            nDifCaixa+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                       OTHERWISE 
                            nIndefinido+= VALOR_ * IF( ENTSAI=="-", -1, 1 ) 
                            @ 04,06 Say MOTIVO 
                    ENDCASE 
                    DBSkip() 
                 ENDDO 
 
                 DBGoTo( nReg ) 
 
                 @ 04,06 Say " 03> SALDO INICIAL .................................. " + Tran( nSaldo,      "@E 999,999,999.99" ) Color IF( nOpcao==1, "14/00", SetColor() ) 
                 @ 06,06 Say " 00> VENDA AO CONSUMIDOR (AUTOMATICA) * ............. " + Tran( nVenda,      "@E 999,999,999.99" ) Color IF( nOpcao==2, "14/00", SetColor() ) 
                 @ 08,06 Say " 01> RETIRADA POR FECHAMENTO ........................ " + Tran( nRetFec,     "@E 999,999,999.99" ) Color IF( nOpcao==3, "14/00", SetColor() ) 
                 @ 10,06 Say " 02> RETIRADA POR TROCA DE OPERADOR ................. " + Tran( nRetTroca,   "@E 999,999,999.99" ) Color IF( nOpcao==4, "14/00", SetColor() ) 
                 @ 12,06 Say " 04> TROCA DE MERCADORIAS ........................... " + Tran( nTrocas,     "@E 999,999,999.99" ) Color IF( nOpcao==5, "14/00", SetColor() ) 
                 @ 14,06 Say " 05> DEVOLUCAO DE MERCADORIAS ....................... " + Tran( nDevolucao,  "@E 999,999,999.99" ) Color IF( nOpcao==6, "14/00", SetColor() ) 
                 @ 16,06 Say " 06> REPOSICAO DE DIFERENCA DE CAIXA ................ " + Tran( nDifCaixa,   "@E 999,999,999.99" ) Color IF( nOpcao==7, "14/00", SetColor() ) 
                 @ 18,06 Say " 07> OUTRAS (CFE. HISTORICO) ........................ " + Tran( nOutras,     "@E 999,999,999.99" ) Color IF( nOpcao==8, "14/00", SetColor() ) 
                 @ 20,06 Say " 14> INDEFINIDO / OUTROS RECEBIMENTOS ............... " + Tran( nIndefinido, "@E 999,999,999.99" ) Color IF( nOpcao==9, "14/00", SetColor() ) 
                 nSegundos:= SECONDS() 
                 WHILE Inkey()==0 
                     IF SECONDS() > nSegundos + 5 
                        SWAlerta( "AVISO!; Para verificar informacoes individualizadamente;"+; 
                                      "por motivo de lancamento basta selecionar;"+; 
                                      "uma das opcoes do menu e pressionar ENTER, bem como,;"+; 
                                      "para voltar a visualizacao completa basta pressionar ESC;"+; 
                                      "sem optar por nenhuma das alternativas.", { " OK " } ) 
                        Keyboard Chr( K_DOWN ) 
                     ENDIF 
                 ENDDO 
                 Keyboard Chr( LastKey() ) 
                 @ 04,06 Prompt " 03> SALDO INICIAL .................................. " + Tran( nSaldo,      "@E 999,999,999.99" ) 
                 @ 06,06 Prompt " 00> VENDA AO CONSUMIDOR (AUTOMATICA) * ............. " + Tran( nVenda,      "@E 999,999,999.99" ) 
                 @ 08,06 Prompt " 01> RETIRADA POR FECHAMENTO ........................ " + Tran( nRetFec,     "@E 999,999,999.99" ) 
                 @ 10,06 Prompt " 02> RETIRADA POR TROCA DE OPERADOR ................. " + Tran( nRetTroca,   "@E 999,999,999.99" ) 
                 @ 12,06 Prompt " 04> TROCA DE MERCADORIAS ........................... " + Tran( nTrocas,     "@E 999,999,999.99" ) 
                 @ 14,06 Prompt " 05> DEVOLUCAO DE MERCADORIAS ....................... " + Tran( nDevolucao,  "@E 999,999,999.99" ) 
                 @ 16,06 Prompt " 06> REPOSICAO DE DIFERENCA DE CAIXA ................ " + Tran( nDifCaixa,   "@E 999,999,999.99" ) 
                 @ 18,06 Prompt " 07> OUTRAS (CFE. HISTORICO) ........................ " + Tran( nOutras,     "@E 999,999,999.99" ) 
                 @ 20,06 Prompt " 14> INDEFINIDO / OUTROS RECEBIMENTOS ............... " + Tran( nIndefinido, "@E 999,999,999.99" ) 
                 menu to nOpcao 
                 IF nOpcao <= 0 
                    IF nCodigo > 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                       Index On DATAMV To INDICE93.TMP For VENDE_ == nCodigo Eval {|| Processo() } 
                    ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                       Index On DATAMV To INDICE93.TMP Eval {|| Processo() } 
                    ENDIF 
                 ELSE 
                    IF nOpcao==1 
                       nMotivo:= 03 
                    ELSEIF nOpcao==2 
                       nMotivo:= 00 
                    ELSEIF nOpcao==3 
                       nMotivo:= 01 
                    ELSEIF nOpcao==4 
                       nMotivo:= 02 
                    ELSEIF nOpcao==5 
                       nMotivo:= 04 
                    ELSEIF nOpcao==6 
                       nMotivo:= 05 
                    ELSEIF nOpcao==7 
                       nMotivo:= 06 
                    ELSEIF nOpcao==8 
                       nMotivo:= 07 
                    ELSEIF nOpcao==9 
                       nMotivo:= 14 
                    ENDIF 
                    IF nCodigo > 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                       Index On DATAMV To INDICE93.TMP For VENDE_ == nCodigo .AND. MOTIVO == nMotivo Eval {|| Processo() } 
                    ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                       Index On DATAMV To INDICE93.TMP For MOTIVO == nMotivo Eval {|| Processo() } 
                    ENDIF 
                 ENDIF 
                 ScreenRest( cTelaRes ) 
                 oTab:RefreshAll() 
                 WHILE !oTab:Stabilize() 
                 ENDDO 
 
            case nTecla==K_INS 
 
                 IF IncluiCaixa( oTab, nTotal, nCodigo ) 
                    DBGoTop() 
                    nTotal:= 0 
                    WHILE !EOF() 
                       IF EntSai == "+" 
                          nTotal+= VALOR_ 
                       ELSE 
                          nTotal-= VALOR_ 
                       ENDIF 
                       DBSkip() 
                    ENDDO 
                    @ 01,01 Say  " Valor Disponivel em caixa (R$)......: " + Tran( nTotal, "@E 999,999,999.99" ) 
                 ENDIF 
                 oTab:RefreshAll() 
                 WHILE !oTab:Stabilize() 
                 ENDDO 
 
            Case DBPesquisa( nTecla, oTab ) 
 
            Case nTecla == K_F2 
                 DBMudaOrdem( 1, oTab ) 
 
            Otherwise                ;tone(125); tone(300) 
         endcase 
         oTab:refreshcurrent() 
         oTab:stabilize() 
      ENDDO 
 
   ENDDO 
   FechaArquivos() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/cx_ind01.ntx" 
   #else 
     Set Index To "&GDir\CX_IND01.NTX" 
   #endif
   Release nCodigo 
   Return(.T.) 
 
Function IncluiCaixa( oTab, nSenha, nVendedor ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local dDataMv:= Date(), cHora:= Time(), cSenha:= Space(08),; 
      cRazao:= "*", nMotivo:= 2, cHistorico:= Space(40),; 
      nValor:= 0, cSenha1:= "*", cSenha2:= "*", cSenha3:= "*", cSenha4:= "*",; 
      cSenha5:= "*", cSenha6:= "*", nTecla:= 0, lRetorno:= .F. 
Local nTotal:= 0 
 
WHILE !LastKey() == K_ESC 
    VPBox( 05, 05, 15, 70, " Inclusao de registro no movimento de caixa ", _COR_GET_BOX, .F., .F. ) 
    SetColor( _COR_GET_EDICAO ) 
    @ 06,06 Say "Senha..........: [     ]" 
    nTecla:= 0 
    nLin:= 24 
    cSenha:= "" 
    WHILE ! nTecla == K_ENTER 
        nTecla:= Inkey(0) 
        DO CASE 
           CASE nTecla >= 48 .and. nTecla <= 57 
                cSenha+= Chr( nTecla ) 
           CASE nTecla == K_ENTER 
                EXIT 
           CASE nTecla == K_BS 
                cSenha:= Left( cSenha, Len( cSenha ) - 1 ) 
           CASE nTecla == K_ESC 
                EXIT 
        ENDCASE 
        @ 06,nLin Say PAD( Repl( "*", Len( cSenha ) ), 5 ) 
        IF Len( cSenha ) == 5 
           EXIT 
        ENDIF 
    ENDDO 
    cSenhaTeste:= Tran( nSenha, "@E 9999999999.99" ) 
    cSenhaTeste:= Left( cSenhaTeste, 10 ) + Right( cSenhaTeste, 2 ) 
    cSenhaTeste:= StrZero( Val( cSenhaTeste ), 10, 0 ) 
    cSenhaTeste:= Right( cSenhaTeste, 5 ) 
    @ 06,55 Say nSenha 
    IF !cSenha == cSenhaTeste 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       ScreenRest( cTela ) 
       Return .F. 
    ENDIF 
    SetCursor( 1 ) 
    @ 07,06 Say "Data...........:" Get dDataMv 
    @ 08,06 Say "Caixa Operador.:" Get nVendedor Pict "@E  999" 
    @ 09,06 Say "����������������������������������������������������������������" 
    @ 10,06 Say "Razao....(+/-).:" Get cRazao Pict "!" Valid cRazao $ "+-" 
    @ 11,06 Say "Motivo.........:" Get nMotivo Pict "99" Valid Motivo( @nMotivo ) 
    @ 12,06 Say "Hist�rico......:" Get cHistorico Pict "@!" 
    @ 13,06 Say "Valor..........:" Get nValor Pict "@E 999,999,999.99" Valid IF( cRazao == "-", nValor <= VAL( TRAN( nSenha, "999999999.99" ) ), .T. ) 
    @ 14,06 Say "Data/Hora......: [" + DTOC( Date() ) + " / " + Time() + "]" 
    Read 
 
    IF LastKey() == K_ESC 
       lRetorno:= .F. 
       Exit 
    ENDIF 
 
    if confirma( , , "Confirma?", "Digite [S] para confirmar as informacoes.", "S" ) 
       IF nVendedor >= 0 
          TrocaCaixa() 
          IF nMotivo == 1 .OR. nMotivo == 2 
             DBGoTop() 
             nTotal:= 0 
             WHILE !EOF() 
                 IF netrlock() 
                    IF ENTSAI=="+" 
                       nTotal:= nTotal + VALOR_ 
                    ELSE 
                       nTotal:= nTotal - VALOR_ 
                    ENDIF 
                    Dele 
                 ENDIF 
                 DBSkip() 
             ENDDO 
             dbappend() 
             if netrlock() 
                replace ENTSAI With "+",; 
                        VENDE_ With nVendedor,; 
                        HISTOR With "SALDO APOS FECHAMENTO",; 
                        VALOR_ With nTotal - nValor,; 
                        DATAMV With dDataMv,; 
                        HORAMV With TIME(),; 
                        MOTIVO With nMotivo 
             endif 
             DBSelectAr( _COD_CAIXAAUX ) 
             DBAppend() 
             IF netrlock() 
                Replace ENTSAI With cRazao,; 
                        VENDE_ With nVendedor,; 
                        HISTOR With cHistorico,; 
                        VALOR_ With nValor,; 
                        DATAMV With dDataMv,; 
                        HORAMV With TIME(),; 
                        MOTIVO With nMotivo 
             ENDIF 
             LancaMovimento( dDataMv, 0, "CAIXA", "T", "FECHAMENTO CAIXA " + StrZero( nVendedor, 3, 0 ), "H:" + LEFT( TIME(), 5 ) + "/U:"+ StrZero( nGCodUser, 3, 0 ) + "-" + wUsuario, 0, nValor ) 
             LancaSaldos( 0, "CAIXA", "T", 0, nValor ) 
             DBSelectAr( _COD_CAIXA ) 
          ELSE 
             DBSelectAr( _COD_CAIXA ) 
             dbappend() 
             if netrlock() 
                replace ENTSAI With cRazao,; 
                        VENDE_ With nVendedor,; 
                        HISTOR With cHistorico,; 
                        VALOR_ With nValor,; 
                        DATAMV With dDataMv,; 
                        HORAMV With TIME(),; 
                        MOTIVO With nMotivo 
             endif 
          ENDIF 
       ENDIF 
       DBUnLockAll() 
       dDataMv:= Date() 
       cHora:= Time() 
       cSenha:= Space(08) 
       nVendedor:= 0 
       cRazao:= "*" 
       nMotivo:= 2 
       cHistorico:= Space(40) 
       nValor:= 0 
       lRetorno:= .T. 
       EXIT 
 
    endif 
 
ENDDO 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oTab:RefreshAll() 
WHILE !oTab:Stabilize() 
ENDDO 
Return lRetorno 
 
/* 
Modulo        - LancCaixa 
Programador   - Valmor Pereira Flores 
Finalidade    - 
Date          - 28/01/98 
*/ 
Function LancCaixa( cRazao, nVendedor, cHistorico, nValor, dDataMv, nMotivo ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
   DBSelectAr( _COD_CAIXA ) 
   TrocaCaixa() 
   dbappend() 
   IF netrlock() 
      Replace ENTSAI With cRazao,; 
              VENDE_ With nVendedor,; 
              HISTOR With cHistorico,; 
              VALOR_ With nValor,; 
              DATAMV With dDataMv,; 
              HORAMV With TIME(),; 
              MOTIVO With nMotivo,; 
              CDUSER With nGCodUser 
   ENDIF 
   IF nArea > 0 
      DBSelectAr( nArea ) 
   ENDIF 
 
/***** 
�������������Ŀ 
� Funcao      � DispMotivo 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � Valmor 
� Data        � 
��������������� 
*/ 
Function DispMotivo( nMotivo ) 
DO CASE 
   CASE nMotivo == 0 
        cMotivo:= "VENDA CONSUMIDOR  " 
   CASE nMotivo == 1 
        cMotivo:= "FECHAMENTO        " 
   CASE nMotivo == 2 
        cMotivo:= "TROCA DE OPERADOR " 
   CASE nMotivo == 3 
        cMotivo:= "SALDO INICIAL     " 
   CASE nMotivo == 4 
        cMotivo:= "TROCA MERCADORIA  " 
   CASE nMotivo == 5 
        cMotivo:= "DEVOL. MERCADORIA " 
   CASE nMotivo == 6 
        cMotivo:= "DIFERENCA CAIXA   " 
   CASE nMotivo == 7 
        cMotivo:= "OUTRAS            " 
   CASE nMotivo == 8 
        cMotivo:= "AUTOMATICA        " 
   CASE nMotivo == 15 
        cMotivo:= "BAIXA DUPLICATA   " 
   OTHERWISE 
        cMotivo:= "                  " 
ENDCASE 
Return cMotivo 
 
/***** 
�������������Ŀ 
� Funcao      � Motivo 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function Motivo( nMotivo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
VPBox( 08, 09, 17, 50, , _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
@ 09,10 Prompt " 01> RETIRADA POR FECHAMENTO            " 
@ 10,10 Prompt " 02> RETIRADA POR TROCA DE OPERADOR     " 
@ 11,10 Prompt " 03> SALDO INICIAL                      " 
@ 12,10 Prompt " 04> TROCA DE MERCADORIAS               " 
@ 13,10 Prompt " 05> DEVOLUCAO DE MERCADORIAS           " 
@ 14,10 Prompt " 06> REPOSICAO DE DIFERENCA DE CAIXA    " 
@ 15,10 Prompt " 07> OUTRAS (CFE. HISTORICO)            " 
@ 16,10 Say    " 00> VENDA AO CONSUMIDOR (AUTOMATICA) * " 
Menu To nMotivo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � TROCACAIXA 
� Finalidade  � Trocar o caixa operador 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TrocaCaixa() 
   DBSelectAr( _COD_CAIXA ) 
   DBGoBottom() 
   IF !CDUSER == nGCodUser 
       DBAppend() 
       IF netrlock() 
          Replace DATAMV With Date(),; 
                  ENTSAI With " ",; 
                  HISTOR With "�Troca�de�Caixa������OPERADOR:" + StrZero( nGCodUser, 3, 0 ),; 
                  VALOR_ With 0,; 
                  CDUSER With nGCodUser,; 
                  HORAMV With "��������" 
       ENDIF 
   ENDIF 
 
 
Function VerSenha( cSenha, nCodigo ) 
local cSenhaPrincipal:= "123456" 
Static cCodigo 
DO CASE 
   CASE nCodigo == 1 
        cCodigo:= cSenha 
   CASE nCodigo >= 2 .AND. nCodigo <= 6 
        cCodigo:= cCodigo + cSenha 
        IF nCodigo == 6 
           IF cCodigo == cSenha 
              Return .T. 
           ELSE 
              cCodigo:= "" 
              Return .F. 
           ENDIF 
        ENDIF 
   CASE nCodigo == 7 
ENDCASE 
 
