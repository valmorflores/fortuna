// ## CL2HB.EXE - Converted
/* 
* Modulo      - MovimPCP() 
* Descricao   - Controle de estoque PCP. (Entradas/Saidas) 
* Programador - Valmor Pereira Flores 
* Data        - 27/Marco/1995 
* Atualizacao - 
*/ 
#Include "vpf.ch" 
#Include "inkey.ch" 
/* 
menu de verificacao 
*/ 
   Func MovimPCP() 
 
      LOCAL cTELA:=zoom(13,24,16,48), cCOR:=setcolor(), nOPCAO:=0 
      VpBox(13,24,16,48) 
 
      Whil .t. 
         Mensagem("") 
         Aadd(MENULIST,MenuNew(14,25," 1 Producao           ",2,COR[11],; 
              "Entrada, saida e estorno de lancamentos de produtos em estoque PCP.",,,COR[6],.T.)) 
/* 
         Aadd(MENULIST,MenuNew(15,25," 2 Andamento Producao ",2,COR[11],; 
              "Entrada, saida e estorno de lancamentos de produtos em estoque PCP.",,,COR[6],.T.)) 
         Aadd(MENULIST,MenuNew(16,25," 3 Movimentacao Manual",2,COR[11],; 
              "Entrada, saida e estorno de lancamentos de produtos em estoque PCP.",,,COR[6],.T.)) 
         AAdd(MENULIST,MenuNew(17,25," 4 Anular          ",2,COR[11],; 
              "Anular lancamentos em estoque PCP.",,,COR[6],.T.)) 
         Aadd(MENULIST,MenuNew(18,25," 5 Pesquisas       ",2,COR[11],; 
              "Verificacao dos saldos de produtos e movimento geral p/ produto.",,,COR[6],.T.)) 
*/ 
         Aadd(MENULIST,MenuNew(15,25," 0 Retorna         ",2,COR[11],; 
              "Retorna ao menu anterior.",,,COR[6],.T.)) 
         MenuModal(MENULIST,@nOPCAO); MENULIST:={} 
         Do Case 
            Case nOPCAO=0 .or. nOPCAO=2; Exit 
            Case nOPCAO=1; PCPIniPro() 
//          Case nOPCAO=2; PCPAndPro() 
//          Case nOPCAO=3; PCPEstInc() 
//          Case nOpcao=4; PCPEstAlt() 
//          Case nOPCAO=5; PCPEstMenVer() 
         EndCase 
      EndDo 
      DBSelectAr( _COD_PCPESTO ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&gdir/pceind01.ntx","&gdir/pceind02.ntx","&gdir/pceind03.ntx","&gdir/pceind04.ntx"     
      #else 
        Set Index To "&GDIR\PCEIND01.NTX","&GDIR\PCEIND02.NTX","&GDIR\PCEIND03.NTX","&GDir\PCEIND04.NTX"     
      #endif
      UnZoom(cTELA) 
      SetColor(cCOR) 
 
   Return(nil) 
 
Function PCPEstMenVer 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
LOCAL nOPCAO:=0 
VPBox( 14, 34, 20, 63 ) 
Whil .t. 
   Mensagem("") 
   Aadd(MENULIST,MenuNew(15,35," 1 Saldos em Estoque       ",2,COR[11],; 
        "Verifica saldo atual dos produtos em estoque PCP.",,,COR[6],.T.)) 
   Aadd(MENULIST,MenuNew(16,35," 2 Individual              ",2,COR[11],; 
        "Verifica o movimento individual de estoque PCP.",,,COR[6],.T.)) 
   Aadd(MENULIST,MenuNew(17,35," 3 Movimento Geral         ",2,COR[11],; 
        "Verifica o movimento geral em estoque PCP.",,,COR[6],.T.)) 
   AAdd(MENULIST,MenuNew(18,35," 4 Movimento por Setor     ",2,COR[11],; 
        "Verifica as entradas por fornecedor.",,,COR[6],.T.)) 
   Aadd(MENULIST,MenuNew(19,35," 0 Retorna                 ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   MenuModal(MENULIST,@nOPCAO); MENULIST:={} 
   Do Case 
      Case nOPCAO=0 .or. nOPCAO=5; Exit 
      Case nOPCAO=1; PCPEstV1() 
      Case nOPCAO=2; PCPEstV2() 
      Case nOPCAO=3; PCPEstV3() 
      Case nOpcao=4; PCPEstV5() 
   EndCase 
EndDo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
Function PCPEstV1 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ), x 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
AbreGrupo( "ESTOQUE" ) 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 1 ) 
x:= GrupoDeProdutos 
GrupoDeProdutos:= "999" 
VisualProdutos( "0000000000" ) 
GrupoDeProdutos:= x 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
Function PCPEstV2 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ), cCodigo:= "0000000000",; 
      x, nFornecedor:= 0, cOrigem, nSaldo:= 0, cCodOrigem:= "   ", nPrecoVenda:= 0,; 
      cCodFab:= Space( 15 ), cDescricao:= Space( 40 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBox( 00, 00, 22, 79, "Verificacao de Estoque PCP", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. ) 
AbreGrupo( "ESTOQUE" ) 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 1 ) 
While .T. 
   x:= GrupoDeProduto 
   GrupoDeProduto:= "999" 
   VisualProdutos( cCodigo ) 
   GrupoDeProduto:= x 
   IF LastKey()==K_ESC 
      EXIT 
   ENDIF 
   cCodigo:= MPR->Indice 
   cCodOrigem:= MPR->Origem 
   nFornecedor:= MPR->CodFor 
   nSaldo:= MPR->Saldo_ 
   nPrecoVenda:= MPR->PrecoV 
   cCodFab:= MPR->CodFab 
   cDescricao:= Mpr->Descri 
 
   /* Busca o fabricante do produto */ 
   DBSelectAr( _COD_ORIGEM ) 
   DBSetOrder( 3 ) 
   IF DBSeek( cCodOrigem ) 
      cOrigem:= DESCRI 
   ELSE 
      cOrigem:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      " 
   ENDIF 
 
   /* Busca o fornecedor */ 
   DBSelectAr( _COD_FORNECEDOR ) 
   IF DBSeek( nFornecedor ) 
      cFornecedor:= DESCRI 
   ELSE 
      cFornecedor:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      " 
   ENDIF 
 
   /* Seleciona Cfe. selecionado */ 
   DBSelectAr( _COD_PCPESTO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On DataMv Tag DT1 Eval {|| Processo( 1 ) } To Indice20 For CProd_ == cCodigo 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To Indice20.Ntx 
   Mensagem( "Digite [Data/Documento] para pesquisar ou tecle [ENTER] para proximo." ) 
   VpBox(10,00,22,79,"MOVIMENTO", COR[20], .F., .F., COR[19], .F. ) 
   VpBox(12,01,12,78,"", _COR_BROW_BOX, .f., .f. ) 
   DbGoTop() 
   SetColor( _COR_BROWSE ) 
   oTab:=TBrowseDb(13,01,21,78) 
   oTab:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+; 
            " "+if(ENTSAI="+","Entrada","Saida  ")+" "+ STRZERO( CODIGO, 5, 0 ) + ; 
            " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+; 
            " "+Tran(IF( VALOR_==0, VLRSAI, VALOR_),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) + SPACE( 20 ) })) 
   oTab:AUTOLITE:=.F. 
   oTab:Dehilite() 
   Whil .T. 
      oTab:ColorRect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
      Whil NextKey()=0 .AND.! oTab:Stabilize() 
      Enddo 
      SetColor( _COR_GET_EDICAO ) 
      @ 01,02 Say "Produto...: [" + cDescricao + "]" 
      @ 02,01 Say "������������������������������������������������������������������������������" 
      @ 03,02 Say "Codific�o.: [" + Tran( Left( CProd_, 7 ), "@R 999-9999" ) + "]     Codigo de Fabrica: [" + cCodFab + "]" 
      @ 04,02 Say "Fabricante: [" + cCodOrigem + "]-[" + cOrigem + "]" 
      @ 05,02 Say "Fornecedor: [" + StrZero( nFornecedor, 3, 0 ) + "]-[" + cFornecedor + "]" 
      @ 06,01 Say "������������������������������������������������������������������������������" 
      @ 07,02 Say "Saldo.....: [" + Tran( nSaldo, "@E 999,999.9999" ) + "]" 
      @ 08,02 Say "Pre�o.....: [" + Tran( nPrecoVenda, "@E 999,999.9999" ) + "]" 
      SetColor( _COR_BROWSE ) 
      nTECLA:=inkey(0) 
      If nTecla=K_ESC .OR. nTecla=K_ENTER 
         Exit 
      Endif 
      Do Case 
         Case nTECLA==K_UP         ;oTab:Up() 
         Case nTECLA==K_DOWN       ;oTab:Down() 
         Case nTECLA==K_PGUP       ;oTab:PageUp() 
         Case nTECLA==K_PGDN       ;oTab:PageDown() 
         Case nTECLA==K_CTRL_PGUP  ;oTab:GoTop() 
         Case nTECLA==K_CTRL_PGDN  ;oTab:GoBottom() 
         OtherWise 
              EXIT 
      EndCase 
      oTab:RefreshCurrent() 
      oTab:Stabilize() 
   EndDo 
EndDo 
DBSelectAr( _COD_PCPESTO ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/pceind01.ntx","&gdir/pceind02.ntx","&gdir/pceind03.ntx","&gdir/pceind04.ntx"     
#else 
  Set Index To "&GDIR\PCEIND01.NTX","&GDIR\PCEIND02.NTX","&GDIR\PCEIND03.NTX","&GDir\PCEIND04.NTX"     
#endif
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
Function PCPEstV5 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ), cCodigo:= "0000000000",; 
      x, nFornecedor:= 0, cOrigem, nSaldo:= 0, cCodOrigem:= "   ", nPrecoVenda:= 0,; 
      cCodFab:= Space( 15 ), cDescricao:= Space( 40 ), nCodCli:= 18 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBox( 00, 00, 22, 79, "Verificacao de Estoque PCP", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. ) 
READ 
AbreGrupo( "ESTOQUE" ) 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 1 ) 
DBSelectAr( _COD_PCPESTO ) 
Set Relation To CPROD_ INTO MPR 
While .T. 
   x:= GrupoDeProduto 
   ForSeleciona( 999999 ) 
   IF LastKey()==K_ESC 
      EXIT 
   ENDIF 
   nCodFor:=      FOR->Codigo 
   cDescri:=      FOR->Descri 
   cFone1:=       FOR->Fone1_ 
   cVendador:=    FOR->Vended 
   cResponsavel:= FOR->Respon 
 
   cCodigo:=      MPR->Indice 
   cCodOrigem:=   MPR->Origem 
   nFornecedor:=  MPR->CodFor 
   nSaldo:=       MPR->Saldo_ 
   nPrecoVenda:=  MPR->PrecoV 
   cCodFab:=      MPR->CodFab 
   cDescricao:=   MPR->Descri 
 
   /* Busca o fabricante do produto */ 
   DBSelectAr( _COD_ORIGEM ) 
   DBSetOrder( 3 ) 
   IF DBSeek( cCodOrigem ) 
      cOrigem:= DESCRI 
   ELSE 
      cOrigem:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      " 
   ENDIF 
 
   /* Seleciona Cfe. selecionado */ 
   DBSelectAr( _COD_PCPESTO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On dataMv Tag DT1 Eval {|| Processo( 1 ) } To Indice20 For Codigo == nCodFor .AND. EntSai == "+" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To Indice20.Ntx 
   Mensagem( "Digite [Data/Documento] para pesquisar ou tecle [ENTER] para proximo." ) 
   VpBox(12,00,22,79,"Movimento de SAIDA para o cliente", COR[20], .F., .F., COR[19], .F. ) 
   DbGoTop() 
   SetColor( _COR_BROWSE ) 
   oTab:=TBrowseDb(13,01,21,78) 
   oTab:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+; 
            " "+if(ENTSAI="+","Entrada","Saida  ")+" "+ tran( CProd_, "@R 999-9999" ) + ; 
            " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+; 
            " "+Tran( IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) + SPACE( 20 ) })) 
   oTab:AUTOLITE:=.F. 
   oTab:Dehilite() 
   Whil .T. 
      oTab:ColorRect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
      Whil NextKey()=0 .AND.! oTab:Stabilize() 
      Enddo 
      SetColor( _COR_GET_EDICAO ) 
      @ 01,02 Say "Fornecedor.: [" + StrZero( nCodFor, 6, 0 ) + "] - [" + cDescri + "]" 
      @ 02,02 Say "Telefone...: [" + cFone1 + "]" 
      @ 03,02 Say "Vendador...: [" + cVendador + "]" 
      @ 04,02 Say "Responsavel: [" + cResponsavel + "]" 
      @ 05,02 Say "������������������������������������������������������������������������������" 
      @ 06,02 Say "Produto....: [" + MPR->DESCRI + " " + MPR->UNIDAD + "]" 
      @ 07,02 Say "Cod.Fabrica: [" + MPR->CODFAB + "]" 
      @ 08,02 Say "Fabricante.: [" + MPR->ORIGEM + "]" 
      @ 09,02 Say "Saldo......: [" + Tran( MPR->SALDO_, "@E 999,999.9999" ) + "]" 
      @ 10,02 Say "Pre�o......: [" + Tran( MPR->PRECOV, "@E 999,999.9999" ) + "]" 
      SetColor( _COR_BROWSE ) 
      nTECLA:=inkey(0) 
      If nTecla=K_ESC .OR. nTecla=K_ENTER 
         Exit 
      Endif 
      Do Case 
         Case nTECLA==K_UP         ;oTab:Up() 
         Case nTECLA==K_DOWN       ;oTab:Down() 
         Case nTECLA==K_PGUP       ;oTab:PageUp() 
         Case nTECLA==K_PGDN       ;oTab:PageDown() 
         Case nTECLA==K_CTRL_PGUP  ;oTab:GoTop() 
         Case nTECLA==K_CTRL_PGDN  ;oTab:GoBottom() 
         Case Upper(Chr(nTECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
              PCPAceEst( 1, oTab ) 
         Case Chr(nTECLA)$"1234567890" 
              PCPAceEst( 2, oTab ) 
         OtherWise 
              EXIT 
      EndCase 
      oTab:RefreshCurrent() 
      oTab:Stabilize() 
   EndDo 
EndDo 
DBSelectAr( _COD_PCPESTO ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/pceind01.ntx","&gdir/pceind02.ntx","&gdir/pceind03.ntx"    
#else 
  Set Index To "&GDIR\PCEIND01.NTX","&GDIR\PCEIND02.NTX","&GDIR\PCEIND03.NTX"    
#endif
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
/* 
* Modulo      - PCPEstInc 
* Finalidade  - Entrada/Saida de produtos (Inclusao) 
* Programador - Valmor Pereira Flores 
* Data        - 20/Outubro/1994 
* Atualizacao - 
*/ 
Stat func PCPEstInc() 
LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nCURSOR:=setcursor() 
LOCAL nCODPRO:=0,; 
     cENTSAI:=" ",; 
     nQUANT_:=0,; 
     cDOC___:=spac(15),; 
     nVALOR_:=0,; 
     nCODIGO:=0,; 
     dDATAMV:=date(),; 
     cGrupo_:= Space( 3 ),; 
     cCodigo:= Space( 4 ),; 
     nMovEst:= 0,; 
     cCliFor:= " ",; 
     nNatOpe:= 0,; 
     nVlrUni:= 0,; 
     nPerIcm:= 0,; 
     nPerIPI:= 0,; 
     nVlrIcm:= 0,; 
     nVlrIPI:= 0,; 
     nVlrFre:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
IF !AbreGrupo( "ESTOQUE" ) 
   Return Nil 
EndIf 
DBSelectar( _COD_MPRIMA ) 
SetColor(COR[16]) 
SetCursor( 1 ) 
VPBox( 0, 0, 24-2, 79, " Movimento de Estoque PCP" ,_COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
WHILE LastKey() <> K_ESC 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,03 Say "Produto......:" Get cGrupo_ Pict "999" Valid PCPVerGru( cGrupo_, @cCodigo ) 
     @ 02,23 Say "-" 
     @ 02,24 Get cCodigo Pict "9999" Valid PCPVerCod( cCodigo, GetList ) when mensagem("Digite o c�digo do produto.") 
     @ 03,03 Say "Cod.Movimento:" Get nMovEst Pict "@R 99" Valid VerTabOperacoes( @nMovEst, @nNatOpe, @cEntSai, @cCliFor ) 
     @ 04,03 Say "Nat.Operacao.:" Get nNatOpe Pict "@E 9.999" 
     @ 05,03 say "Ent/Saida....:" Get cEntSai pict "!"  valid cENTSAI$"+-" when mensagem("Digite (+) para entradas ou (-) para saida.") 
     @ 06,03 say "Documento....:" Get cDoc___ When Mensagem( "Digite o codigo do documento, numero da nota fiscal." ) 
     @ 07,03 say "Cli/Fornec...:" Get nCodigo pict "999999" Valid If(cCliFor="C",PCPSelCli(@nCODIGO),PCPSelFor(@nCODIGO)) When Mensagem("Digite o codigo do fornecedor ou cliente.") 
     @ 08,03 say "Quantidade...:" Get nQuant_ pict "@E 9999999.99" valid PCPVerSal(nQUANT_,cENTSAI, cGrupo_, cCodigo )            When mensagem("Digite a quantidade.") 
     @ 09,03 Say "Vlr. Unitario:" Get nVlrUni Pict "@E 999,999,999,999.99" Valid PCPQuaXUni( nQuant_, nVlrUni, @nValor_ ) 
     @ 10,03 say "Valor........:" Get nValor_ pict "@E 999,999,999,999.99" when mensagem("Digite o valor desta Entrada/Saida.") 
     @ 11,03 Say "% IPI........:" Get nPerIpi Pict "@E 99.99" Valid PCPCalIPI( nValor_, nPerIpi, @nVlrIpi ) 
     @ 12,03 Say "Valor IPI....:" Get nVlrIpi Pict "@E 999,999,999.99" 
     @ 13,03 Say "% ICMs.......:" Get nPerIcm Pict "@E 99.99" Valid PCPCalICM( nValor_, @nPerIcm, @nVlrIcm ) 
     @ 14,03 Say "Valor ICMs...:" Get nVlrIcm Pict "@E 999,999,999.99" 
     @ 15,03 Say "Valor Frete..:" Get nVlrFre Pict "@E 999,999,999.99" 
     @ 16,03 say "Data Entrada.:" Get dDataMv 
     Read 
     IF LastKey()==K_ESC 
        EXIT 
     ENDIF 
     DbSelectAr(_COD_PCPESTO) 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     IF Confirma(10,63,"Confirma?","Digite [S] para confirmar este registro.","S") 
        LancEstoque( cGrupo_ + cCodigo, cGrupo_ + cCodigo, cEntSai, cDoc___,; 
                     nCodigo, 0, nValor_, nQuant_, nGCodUser, dDataMv,; 
                     nVlrIcm, nVlrIpi, nVlrFre, nMovEst, nNatOpe, nPerICM ) 
        DbSelectAr(_COD_MPRIMA) 
     ENDIF 
     ScreenRest( cTelaRes ) 
ENDDO 
dbunlockall() 
FechaArquivos() 
screenrest(cTELA) 
setcursor(nCURSOR) 
setcolor(cCOR) 
return nil 
 
Function PCPQuaXUni( nQuant_, nVlrUni, nValor_ ) 
nValor_:= nQuant_ * nVlrUni 
Return .T. 
 
Function PCPCalIPI( nValor_, nPerIpi, nVlrIpi ) 
nVlrIpi:= ( nValor_ * nPerIpi ) / 100 
Return .T. 
 
Function PCPCalICM( nValor_, nPerICM, nVlrICM ) 
IF MPR->IPICOD == 4 
   nVlrICM:= 0 
   nPerICM:= 0 
ELSEIF MPR->IPICOD == 2 
   RED->( DBSetOrder( 1 ) ) 
   RED->( DBSeek( MPR->TABRED ) ) 
   nBase:= nValor_ - ( ( nValor_ * RED->PERRED ) / 100 ) 
   nVlrICM:= ( nBase * nPerICM ) / 100 
ELSE 
   nVlrICM:= ( nValor_ * nPerICM ) / 100 
ENDIF 
Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � vertabOperacoes 
� Finalidade  � Busca tabela de operacoes 
� Parametros  � 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function VerTabOperacoes( nMovEst, nNatOpe, cEntSai, cCliFor ) 
IF !LastKey() == K_UP 
   TabelaOperacoes( @nMovEst ) 
   IF !LASTKEY()==K_ESC 
      nNatOpe:= OPE->NATOPE 
      cEntSai:= IF( OPE->ENTSAI == "S", "-", "+" ) 
      cCliFor:= OPE->CLIFOR 
      CFO->( dbSetOrder( 1 ) ) 
      CFO->( dbSeek( nNatOpe ) ) 
      @ 03,31 Say OPE->DESCRI 
      @ 04,31 Say CFO->DESCRI 
      @ 05,31 Say IF( cEntSai == "-", "Saida   (-)", "Entrada (+)" ) 
      Keyboard Chr( K_ENTER ) + Chr( K_ENTER ) 
   ENDIF 
ENDIF 
Return .T. 
 
/* 
** Funcao      - PCPEstAlt 
** Finalidade  - Anular estoque 
** Data        - 
** Atualizacao - 
*/ 
Stat Func PCPEstAlt() 
LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nCURSOR:=setcursor() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
IF !AbreGrupo( "ESTOQUE" ) 
   Return Nil 
EndIf 
 
     OPE->( DBSetOrder( 1 ) ) 
     DBSELECTAR(_COD_MPRIMA) 
     DBSETORDER(1) 
     DBSELECTAR(_COD_PCPESTO) 
     DBSETORDER(1) 
     SET RELATION TO CPROD_ INTO MPR, CODMV_ INTO OPE 
 
     DbSelectAr(_COD_PCPESTO) 
     DbSetOrder(1) 
     VpBox( 00, 00, 13, 79, "MOVIMENTO DE ESTOQUE PCP", _COR_GET_BOX, .f., .f. ) 
     VpBox( 14, 00, 22, 79, "Display", _COR_BROW_BOX, .F., .F. ) 
     DbGoTop() 
     SetCursor(0) 
     SetColor( _COR_BROWSE ) 
     Mensagem( "Digite [Data/Documento] para pesquisar ou [ESC] para sair." ) 
     Ajuda("["+_SETAS+"][PgUp][PgDn]Move [Codigo/Nome]Pesquisa [F3]Codigo [F4]Nome") 
     PCPExiEst( .T. ) 
     oTBROWSE:=TBrowseDb(16,01,21,78) 
     oTBROWSE:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+" "+TRAN( cProd_, "@R 999-9999" )+; 
              " "+if(ENTSAI="+","Entrada","Saida  ")+" "+StrZero(CODIGO,4,0)+; 
              " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+; 
              " "+Tran(IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) })) 
     oTBROWSE:AUTOLITE:=.F. 
     oTBROWSE:Dehilite() 
     Whil .T. 
        oTBROWSE:ColorRect({oTBROWSE:ROWPOS,1,oTBROWSE:ROWPOS,1},{2,1}) 
        Whil NextKey()=0 .AND.! oTBROWSE:Stabilize() 
        Enddo 
        PCPExiEst() 
        nTECLA:=inkey(0) 
        If nTECLA=K_ESC 
           Exit 
        Endif 
        Do Case 
           Case nTECLA==K_UP         ;oTBROWSE:Up() 
           Case nTECLA==K_DOWN       ;oTBROWSE:Down() 
           Case nTECLA==K_PGUP       ;oTBROWSE:PageUp() 
           Case nTECLA==K_PGDN       ;oTBROWSE:PageDown() 
           Case nTECLA==K_CTRL_PGUP  ;oTBROWSE:GoTop() 
           Case nTECLA==K_CTRL_PGDN  ;oTBROWSE:GoBottom() 
           Case Chr( nTecla ) == "*" 
                IF netrlock() .AND. ANULAR == " " 
                   Replace ANULAR With "*" 
                   MPR->( DBSetOrder( 1 ) ) 
                   MPR->( DBSeek( PCE->CPROD_ ) ) 
                   IF MPR->( netrlock() ) 
                      IF PCE->ENTSAI == "+" 
                         Replace MPR->SALDO_ With MPR->SALDO_ - PCE->QUANT_,; 
                                 MPR->SDOVLR With MPR->SDOVLR - PCE->CUSMED,; 
                                 MPR->CUSMED With MPR->SDOVLR / MPR->SALDO_ 
                         Replace MPR->CUSATU With MPR->CUSMED 
                      ELSE 
                         Replace MPR->SALDO_ With MPR->SALDO_ + PCE->QUANT_,; 
                                 MPR->SDOVLR With MPR->SDOVLR + PCE->VLRSAI,; 
                                 MPR->CUSMED With MPR->SDOVLR / MPR->SALDO_ 
                         Replace MPR->CUSATU With MPR->CUSMED 
                      ENDIF 
                   ENDIF 
                ENDIF 
                DBUnlockAll() 
           Case nTECLA==K_F3         ;Organiza(oTBROWSE,1) 
           Case nTECLA==K_F4         ;Organiza(oTBROWSE,2) 
           Case Upper(Chr(nTECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
                PCPAceEst( 1, oTBrowse ) 
           Case Chr(nTECLA)$"1234567890" 
                PCPAceEst( 2, oTBrowse ) 
           OtherWise                 ;Tone(125);tone(300) 
        EndCase 
        oTBROWSE:RefreshCurrent() 
        oTBROWSE:Stabilize() 
     EndDo 
     SetCursor(nCURSOR) 
dbunlockall() 
FechaArquivos() 
screenrest(cTELA) 
setcursor(nCURSOR) 
setcolor(cCOR) 
return nil 
 
/* 
** Funcao      - ESTOQUEVER 
** Finalidade  - Verificacao do cadastro de estoque 
** Data        - 
** Atualizacao - 
*/ 
Stat Func PCPEstV3() 
LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nCURSOR:=setcursor() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
IF !AbreGrupo( "ESTOQUE" ) 
   Return Nil 
EndIf 
 
     OPE->( DBSetOrder( 1 ) ) 
     DBSELECTAR(_COD_MPRIMA) 
     DBSETORDER(1) 
     DBSELECTAR(_COD_PCPESTO) 
     DBSETORDER(1) 
     SET RELATION TO CPROD_ INTO MPR, CODMV_ INTO OPE 
 
     DbSelectAr(_COD_PCPESTO) 
     DbSetOrder(1) 
     VpBox( 00, 00, 13, 79, "MOVIMENTO DE ESTOQUE PCP", _COR_GET_BOX, .f., .f. ) 
     VpBox( 14, 00, 22, 79, "Display", _COR_BROW_BOX, .F., .F. ) 
     DbGoTop() 
     SetCursor(0) 
     SetColor( _COR_BROWSE ) 
     Mensagem( "Digite [Data/Documento] para pesquisar ou [ESC] para sair." ) 
     Ajuda("["+_SETAS+"][PgUp][PgDn]Move [Codigo/Nome]Pesquisa [F3]Codigo [F4]Nome") 
     PCPExiEst( .T. ) 
     oTBROWSE:=TBrowseDb(16,01,21,78) 
     oTBROWSE:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+" "+TRAN( cProd_, "@R 999-9999" )+; 
              " "+if(ENTSAI="+","Entrada","Saida  ")+" "+StrZero(CODIGO,4,0)+; 
              " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+; 
              " "+Tran(IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) })) 
     oTBROWSE:AUTOLITE:=.F. 
     oTBROWSE:Dehilite() 
     Whil .T. 
        oTBROWSE:ColorRect({oTBROWSE:ROWPOS,1,oTBROWSE:ROWPOS,1},{2,1}) 
        Whil NextKey()=0 .AND.! oTBROWSE:Stabilize() 
        Enddo 
        PCPExiEst() 
        nTECLA:=inkey(0) 
        If nTECLA=K_ESC 
           Exit 
        Endif 
        Do Case 
           Case nTECLA==K_UP         ;oTBROWSE:Up() 
           Case nTECLA==K_DOWN       ;oTBROWSE:Down() 
           Case nTECLA==K_PGUP       ;oTBROWSE:PageUp() 
           Case nTECLA==K_PGDN       ;oTBROWSE:PageDown() 
           Case nTECLA==K_CTRL_PGUP  ;oTBROWSE:GoTop() 
           Case nTECLA==K_CTRL_PGDN  ;oTBROWSE:GoBottom() 
           Case nTECLA==K_F3         ;Organiza(oTBROWSE,1) 
           Case nTECLA==K_F4         ;Organiza(oTBROWSE,2) 
           Case Upper(Chr(nTECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
                PCPAceEst( 1, oTBrowse ) 
           Case Chr(nTECLA)$"1234567890" 
                PCPAceEst( 2, oTBrowse ) 
           OtherWise                 ;Tone(125);tone(300) 
        EndCase 
        oTBROWSE:RefreshCurrent() 
        oTBROWSE:Stabilize() 
     EndDo 
     SetCursor(nCURSOR) 
dbunlockall() 
FechaArquivos() 
screenrest(cTELA) 
setcursor(nCURSOR) 
setcolor(cCOR) 
return nil 
 
/* 
** Funcao      - PCPVerSal 
** Finalidade  - Verificar a situacao do estoque PCP apos lancamento de saida. 
** Programador - Valmor Pereira Flores 
** Data        - 26/Marco/1995 
** Atualizacao - 28/Marco/1995 - Quarta-feira 
*/ 
Stat Func PCPVerSal(QUANTIDADE,ENTSAI, cGrupo_, cCodigo) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  LOCAL nAREA:=Select(), nORDEM:=IndexOrd() 
  LOCAL cProduto, aProdutos:= {}, lReturn:= .T. 
 
  If ENTSAI="-" 
     DbSelectAr(_COD_MPRIMA) 
     dbSetOrder(3) 
     If SALDO_-QUANTIDADE<0 
        Aviso("ATENCAO! Sdo. produto ficara negativo...",24/2) 
        Pausa() 
     ElseIf SALDO_-QUANTIDADE<ESTMIN 
        Aviso("ATENCAO! Sdo. do produto ficara abaixo do estoque PCP permitido...",24/2) 
        Pausa() 
     EndIf 
  Endif 
  DBSelectAr( _COD_MPRIMA ) 
  IF cGrupo_ <> NIL .AND. cCodigo <> NIL 
     IF MPR->MPRIMA=="N" 
        cProduto:= cGrupo_ + cCodigo + Space( 12 - Len( cGrupo_ + cCodigo ) ) 
        DBSelectAr( _COD_ASSEMBLER ) 
        IF DBSeek( cProduto ) 
           nRegistro:= Recno() 
           WHILE cProduto == ASM->CODPRD 
               DBSelectAr( _COD_MPRIMA ) 
               DBSetOrder( 1 ) 
               IF DBSeek( ASM->CODMPR ) 
                  IF ( MPR->SALDO_ - ( QUANTIDADE * ASM->QUANT_ ) ) <= 0 
                     AAdd( aProdutos, { Alltrim( MPR->INDICE ), MPR->CODFAB, Left( MPR->DESCRI, 30 ), MPR->SALDO_, ASM->QUANT_ * QUANTIDADE, MPR->UNIDAD, "15/04" } ) 
                  ELSE 
                     AAdd( aProdutos, { Alltrim( MPR->INDICE ), MPR->CODFAB, Left( MPR->DESCRI, 30 ), MPR->SALDO_, ASM->QUANT_ * QUANTIDADE, MPR->UNIDAD, "15/01" } ) 
                  ENDIF 
               ENDIF 
               ASM->( DBSkip() ) 
           ENDDO 
           DBGoto( nRegistro ) 
           IF Len( aProdutos ) > 0 
              VPBox( 00,00,22,79, "Saldos necessarios p/ lancamento deste produto no estoque PCP" ) 
              nLin:=02 
              @ nLin,01 Say "Codigo  Cod.Fab      Produto                        Saldo       Qtd.Necessaria" 
              FOR nCt:= 1 TO Len( aProdutos ) 
                  IF aProdutos[nCt][4] < aProdutos[nCt][5] 
                     lReturn:= .F. 
                  ENDIF 
                  SetColor( aProdutos[nCt][7] ) 
                  @ ++nLin,01 say aProdutos[nCt][1] + " " + aProdutos[nCt][2] + " " + aProdutos[nCt][3] + " " + Tran( aProdutos[nCt][4], "@E 999,999.999" ) +; 
                                  " " + Tran( aProdutos[nCt][5], "@E 999,999.999" ) + " " + aProdutos[nCt][6] 
              NEXT 
              IF !lReturn 
                  Mensagem("A materia-prima para movimentar este produto esta em falta." ) 
                  Pausa() 
              ELSE 
                  Mensagem( "Esta quantidade podera ser produzida/embalada pois estoque PCP esta ok." ) 
                  Pausa() 
              ENDIF 
           ENDIF 
        ENDIF 
     ENDIF 
  ENDIF 
  DbSelectAr(nAREA) 
  DbSetOrder(nORDEM) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return( lReturn ) 
 
/* 
** Funcao      - PCPSelCli 
** Finalidade  - Selecionar clientes apartir do cadastro. 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
Stat Func PCPSelCli( nCodigo ) 
  If LastKey()=K_UP 
     Return(.T.) 
  ElseIf nCODIGO=0 
     Return(.F.) 
  EndIf 
  PesqCli( @nCodigo ) 
  @ 07,31 SAY CLI->DESCRI 
  Return .T. 
 
 
/* 
** Funcao      - PCPSelFor 
** Finalidade  - Selecionar Fornecedores apartir do cadastro. 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
Stat Func PCPSelFor(nCODIGO) 
  If LastKey()=K_UP 
     Return(.T.) 
  ElseIf nCODIGO=0 
     Return(.F.) 
  EndIf 
  ForSeleciona( @nCodigo ) 
  @ 07,31 SAY FOR->DESCRI 
  Return .T. 
 
 
/***** 
�������������Ŀ 
� Funcao      � PCPVerGru 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function PCPVerGru( cGrupo_, cCodigo ) 
   LOCAL nArea:= Select(), nOrdem:= IndexOrd() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      Return( .T. ) 
   EndIf 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 ) 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( "15/01" ) 
   @ 02,31 Say MPr->Descri 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � PCPVerCod 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function PCPVerCod( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 1 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
   If LastKey()==K_UP .OR. LastKey()==K_ESC 
      Return( .T. ) 
   EndIf 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Pressione qualquer tecla para ver lista..." ) 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[1]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( "15/01" ) 
   @ 02,31 Say MPr->Descri 
   SetColor( cCor ) 
   Return( .T. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � PCPPesq 
� Finalidade  � Pesquisar o codigo do produto no banco de dados. 
� Parametros  � cCodigo => Codigo do Produto 
� Retorno     � .F.>Nao encontrou / .T.>Encontrou 
� Programador � Valmor Pereira Flores 
� Data        � 29/Novembro/1995 
��������������� 
*/ 
Static Function PCPPesq( cCodigo ) 
LOCAL nArea:= Select(), nOrdem:= IndexOrd(), lResultado 
 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   lResultado:= DBSeek( cCodigo ) 
   DBSelectar( nArea ) 
   DBSetOrder( nOrdem ) 
 
   Return( lResultado ) 
 
/***** 
�������������Ŀ 
� Funcao      � PCPExiEst 
� Finalidade  � Apresentar os dados do registro setado no momento 
� Parametros  � lTela=> Se for para exibir (.T.)Tela (.F.)Dados 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 20/Janeiro/1996 
� Atualizacao � 21/Janeiro/1996 
��������������� 
*/ 
FUNCTION PCPExiEst( lTela ) 
   LOCAL cCor:= SetColor() 
   LOCAL cCodPro:= CProd_, nQtdAnt:= Quant_, cEntSai:= EntSai,; 
         nQuant_:= Quant_, cDoc___:= Doc___, nValor_:= IF( VALOR_==0, VLRSAI, VALOR_ ),; 
         nCodigo:= Codigo, dDataMv:= DataMv 
   lTela:= IF( Empty( lTela ), .F., .T. ) 
 
   /* Se o parametro lTela for verdadeiro, monta a tela */ 
   IF lTela 
      CLI->( DBSetOrder( 1 ) ) 
      FOR->( DBSetOrder( 1 ) ) 
      SetColor( _COR_BROW_LETRA ) 
      @ 15,02 Say Spac(76) 
      @ 15,02 Say "Data    Produto  Ent/Sai CL/For Documento       Quantidade   Valor       " 
   ELSE 
      SetColor( _COR_GET_LETRA ) 
      @ 01,02 say "Codigo.....: [" + Tran( Left( cCodPro, 7 ), "@R XXX-XXXX" ) + "]" 
      @ 02,02 Say "Produto....: [" + MPr->Descri + "]" 
      @ 03,02 Say "Cod.Fabrica: [" + MPr->CODFAB + "]" 
      @ 04,02 Say "Operacao...: [" + StrZero( CODMV_, 3, 0 ) + "]" 
      @ 05,02 say "Ent/Saida..: [" + cEntSai + "]" 
      @ 06,02 say "Cli/Fornec.: [" + Tran( nCodigo, "99999" ) + "]" 
      @ 07,02 say "Documento..: [" + cDoc___ + "]" 
      @ 08,02 say "Quantidade.: [" + Tran( nQuant_, "@E 9999999.99" ) + "]" 
      @ 09,02 say "Valor......: [" + Tran( nValor_, "@E 999,999,999,999.99" ) + "]" 
      @ 10,02 say "Data.......: [" + DtoC( dDataMv ) + "]" 
      @ 11,02 Say "Custo Medio: [" + Tran( CUSATU, "@E 999,999,999.9999" ) + "]" 
      @ 12,02 Say "Situacao...: [" + IF( MPR->Saldo_ < MPR->EstMin - 1, "MENOR QUE MINIMO ", "NORMAL           " ) + "]" 
      SetColor( "14/" + SubStr( _COR_GET_EDICAO, AT( "/", _COR_GET_EDICAO ) + 1, 02 ) ) 
      @ 04,31 Say OPE->DESCRI 
      @ 05,31 Say IF( cEntSai=="+", "ENTRADA  ", "SAIDA    " ) 
      CLI->( DBSeek( nCodigo ) ) 
      FOR->( DBSeek( nCodigo ) ) 
      @ 06,31 Say IF( OPE->CLIFOR=="C", CLI->DESCRI, FOR->DESCRI ) 
      @ 09,55 Say "��Calculo de ImpostosĿ" 
      @ 10,55 Say "� ICMs - " + Tran( VLRICM, "@E 9,999,999.99" ) + " �" 
      @ 11,55 Say "� IPI  - " + Tran( VLRIPI, "@E 9,999,999.99" ) + " �" 
      @ 12,55 Say "�����������������������" 
   ENDIF 
   SetColor( cCor ) 
   Return Nil 
 
FUNCTION PCPAceEst( nOpcao, oTBrowse ) 
   DO CASE 
      CASE nOpcao == 1 
           cCorRes:= SetColor() 
           cDESCRICAO:=Chr(nTECLA)+Spac(14) 
           Keyboard Chr(K_RIGHT) 
           cTELA1:=ScreenSave( 20, 01, 24, 79 ) 
           VpBox( 20, 01, 22, 32, "Pesquisa", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .F. ) 
           SetColor( _COR_GET_EDICAO ) 
           @ 21,02 Say " Documento: " Get cDESCRICAO Pict "@!" When; 
             mensagem("Digite o documento para pesquisa.") 
           Read 
           oTBROWSE:GoTop() 
           DbSetOrder(3) 
           DbSeek( cDESCRICAO, .T. ) 
           ScreenRest(cTELA1) 
           oTBROWSE:RefreshAll() 
           Whil !oTBROWSE:Stabilize();EndDo 
           SetColor( cCorRes ) 
      CASE nOpcao == 2 
           cCorRes:= SetColor() 
           SetCursor( 1 ) 
           dData:= Chr( nTecla ) + Space( 5 ) 
           Keyboard Chr( K_RIGHT ) 
           cTELA1:=ScreenSave(20,01,24,79) 
           VpBox( 20, 01, 22, 38, "Pesquisa", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .F. ) 
           SetColor( _COR_GET_EDICAO ) 
           @ 21,03 Say "Data de Movimento:" Get dData Pict "@R 99/99/99" When; 
             mensagem("Digite a data de movimento para pesquisa...") 
           read 
           oTBROWSE:GoTop() 
           DbSetOrder( 2 ) 
           DbSeek( CTOD( Tran( dData, "@R 99/99/99" ) ), .T. ) 
           ScreenRest(cTELA1) 
           oTBROWSE:RefreshAll() 
           Whil !oTBROWSE:Stabilize() 
           EndDo 
           SetColor( cCorRes ) 
   ENDCASE 
 
// Func PCPAndPro() 
 
// Return(nil) 
 
 
