// ## CL2HB.EXE - Converted
 
#include "vpf.ch" 
#include "inkey.ch" 
#include "ptfuncs.ch" 
#include "ptverbs.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � CONTAS A PAGAR 
� Finalidade  � Lancamento de Contas a Pagar 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/
#ifdef HARBOUR
function vpc91100
#endif

 Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 Local lFlag:= .F. 
   /* Verifica a Existencia de Arquivos */ 
   If !File(_VPB_DESPESAS) 
      Aviso("Arquivo de despesas diversas nao encontrado.",24/2) 
      lFlag:=.T. 
   ElseIf !lFlag 
      If !FDbUseVpb(_COD_DESPESAS,2) 
         Aviso("Impossivel acesso ao arquivo de despesas diversas.",24/2) 
         lFlag:=.T. 
      EndIf 
   EndIf 
   If lFlag 
      Ajuda("[ENTER]Retorna") 
      Mensagem("Pressione [ENTER] para retornar...",1) 
      Pausa() 
      ScreenRest(cTELA) 
      Return nil 
   EndIf 
   Set( _SET_DELIMITERS, .T. ) 
   DispBegin() 
   VPBox( 00, 00, 16, 79, "MOVIMENTO DE CONTAS A PAGAR", _COR_GET_BOX,.F.,.F.  ) 
   VPBox( 15, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   VpBox( 04, 45, 10, 77, "IMPOSTOS", _COR_GET_BOX, .F., .F. ) 
   DBSelectAr( _COD_PAGAR ) 
   ExibStr() 
   DBLeOrdem() 
   Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui [Espaco]Quitacao/Estorno" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 16, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew("Cod.Lan",{|| StrZero( CODIGO, 5, 0 ) })) 
   oTab:addcolumn(tbcolumnnew("DOC",{|| DOC___ })) 
   oTab:addcolumn(tbcolumnnew("For",{|| StrZero( CODFOR, 6, 0 ) })) 
   oTab:addcolumn(tbcolumnnew("Observacoes",{|| left( OBSERV, 30 ) })) 
   oTab:addcolumn(tbcolumnnew("Vencimen",{|| VENCIM })) 
   oTab:addcolumn(tbcolumnnew("Quitacao",{|| DATAPG })) 
   oTab:addcolumn(tbcolumnnew("Valor",{|| Tran( VALOR_, "@E 99999.99" ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      SetColor( _COR_GET_EDICAO ) 
      MostraPaga() 
      SetColor( "15/07" ) 
      SCROLL( 14, 00, 14, 79) 
      DEVPOS( 14, 02 ) 
      DEVOUT("Situacao da Duplicata: ") 
      DEVPOS( 14, 26 ) 
      IF !EMPTY( DATAPG ) 
         DEVOUT("Quitada   "+IF( DATAPG > VENCIM + 3, "(Atraso de "+ alltrim( STR( DATAPG - VENCIM, 10, 0 ) )+" dias)","") ) 
      ELSE 
         DEVOUT("Pendente  "+IF( DATE() > VENCIM + 3, "(Atraso de "+ alltrim( STR( DATE() - VENCIM, 10, 0 ) )+" dias)","" ) ) 
      ENDIF 
      SetColor( _COR_BROWSE ) 
      nTecla:=inkey(0) 
      if nTecla=K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_SH_F8
              gSemNome( "pagar" )
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:PanLeft() 
         case nTecla==K_RIGHT      ;oTab:PanRight() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_INS        ;IncluiPagar( oTab ) 
         Case nTecla==K_DEL 
              IF !EMPTY( DATAPG ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Esta conta foi quitada! Impossivel excluir." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 Exclui( oTab ) 
              ENDIF 
         case nTecla==K_ENTER 
              IF !EMPTY( DATAPG ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Esta conta foi quitada! Impossivel Alterar." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 AlteraPagar( oTab ) 
              ENDIF 
         Case nTecla==K_SPACE      ;BaixaPagar( oTab ) 
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         Case nTecla==K_F4         ;DBMudaOrdem( 3, oTab ) 
         Case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � INCLUIPAGAR 
� Finalidade  � Inclusao de registros em Contas a Pagar 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
func incluipagar( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
  Local nCODFOR:=nBANCO_:=0,; 
        dDATAEM:= dVENCIM:= date(),; 
        nVALOR_:=0,; 
        cOBSERV:=spac(40),; 
        dDATAPG:=ctod("  /  /  "),; 
        dCompet:=ctod("  /  /  "),; 
         nJUROS_:=0,; 
        cCHEQUE:=spac(15), nVLRIPI:= nVLRICM:=0,; 
        nNFISC_:= 0, dDEntra:= CTOD( "  /  /  " ),; 
        nLocal_:= 0, nTabOpe:= 0 
 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local lFlag:=.F. 
  Local nCODIGO:=0, cDOC___:=spac(10) 
 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 13, 79, "CONTAS A PAGAR (INCLUSAO)", _COR_GET_EDICAO, .F., .F. ) 
  VpBox( 04, 45, 10, 77, "IMPOSTOS", _COR_GET_BOX, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr(_COD_PAGAR) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCODIGO:= CODIGO + 1 
  dbgotop() 
  WHILE .T. 
     SetColor( _COR_GET_EDICAO ) 
     @ 01,02 Say "Emp/Codigo.: ["+ StrZero( SWSet( _GER_EMPRESA ), 3, 0 ) +"]["+strzero(nCODIGO,6,0)+"]" 
     @ 02,02 Say "Operacao...:" Get nTabOpe Pict "999" Valid TabelaOperacoes( @nTabOpe ) When; 
       Mensagem( "Digite a operacao p/ movimentacao." ) 
     @ 03,02 Say "Cli/Fornec.:" Get nCODFOR pict "999999" valid; 
       IF( OPE->CLIFOR=="C", PesqCli( @nCodFor ), DespesaSeleciona( @nCODFOR ) ) when; 
       Mensagem("Digite o codigo do fornecedor, despesa ou cliente.") 
     @ 04,02 Say "DOC........:" Get cDOC___ when; 
       Mensagem("Digite o numero do documento.") 
     @ 05,02 Say "Local/Banco:" Get nBANCO_ pict "999" valid; 
       PesqBco( @nBanco_ ) when; 
       Mensagem("Digite o numero do banco para pagamento.") 
     @ 06,02 Say "Emissao....:" Get dDATAEM when; 
       Mensagem("Digite a data de emissao do documento.") 
     @ 06,26 Say "Compet:" Get dCompet 
     @ 07,02 Say "Vencimento.:" Get dVENCIM when; 
       Mensagem("Digite a data de vencimento.") valid; 
       VerData(@dVENCIM) 
     @ 08,02 Say "Data pgto..: [" + DTOC(  dDATAPG ) + "]" 
     //when; 
     //  Mensagem("Digite a data em que foi pago o documento.") 
     @ 09,02 Say "Valor......:" Get nVALOR_ pict "@E 99,999,999,999.99" when; 
       Mensagem("Digite o valor que foi pago.") 
     @ 10,02 Say "Juros pagos:" Get nJUROS_ pict "@E 99,999,999,999.99" when; 
       Mensagem("Digite o valor dos juros pagos.") 
     @ 11,02 Say "Observacoes:" Get cOBSERV when; 
       Mensagem("Digite qualquer observacao que se refira ao documento.") 
     @ 12,02 Say "Localizacao:" Get nLocal_ Pict "999" when; 
       Mensagem( "Digite a localizacao da conta/banco." ) 
     READ 
     If LastKey()=K_ESC 
        exit 
     EndIf 
     Set(_SET_DELIMITERS,.F.) 
     VpBox( 04, 45, 10, 77, "IMPOSTOS", _COR_GET_BOX, .F., .F. ) 
     @ 05,46 Say "Nota Fiscal...:" Get nNFISC_ Pict "999999" 
     @ 06,46 Say "Cheque........:" Get cCHEQUE 
     @ 07,46 Say "Valor do ICMs.:" Get nVLRICM Pict "@E 9999,999,999.99" 
     @ 08,46 Say "Valor do IPI..:" Get nVLRIPI Pict "@E 9999,999,999.99" 
     @ 09,46 Say "Data Entrada..:" Get dDEntra 
     Read 
     Set(_SET_DELIMITERS,.T.) 
     If confirma(12,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        DBSelectAr( _COD_PAGAR ) 
        IF DBSeek( nCodigo ) 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           Aviso( "Codigo de lancamento ser� substituido" ) 
           Pausa() 
           ScreenRest( cTelaRes ) 
           DBGoBottom() 
           nCodigo:= nCodigo + 1 
        ENDIF 
        If buscanet(5,{|| dbappend(), !neterr()}) .AND.; 
           nCODIGO <> 0 
           Repl CODIGO with nCODIGO, DOC___ with cDOC___,; 
                CODFOR with nCODFOR,; 
                BANCO_ with nBANCO_, VENCIM with dVENCIM,; 
                VALOR_ with nVALOR_, DATAPG with dDATAPG,; 
                OBSERV with cOBSERV, EMISS_ with dDATAEM,; 
                COMPET With dCompet,; 
                JUROS_ with nJUROS_,; 
                QUITAD with If(dDATAPG<>ctod("  /  /  "),"S","N"),; 
                CHEQUE with cCHEQUE, NFISC_ with nNFISC_,; 
                VLRIPI with nVLRIPI, VLRICM with nVLRICM,; 
                DENTRA With dDEntra, LOCAL_ With nLocal_,; 
                TABOPE With nTabOpe 
//           ENDIF 
           DBUnlockAll() 
 
        EndIf 
        /* Limpa as variaveis */ 
        cDOC___:=spac(10) 
        nFORCOD:=nBANCO_:=0 
        nVALOR_:=0 
        cOBSERV:=spac(40) 
        nJUROS_:=nNFISC_:=nVLRIPI:=nVLRICM:=0 
        cCHEQUE:=spac(15) 
        /* Refaz o browse inferior */ 
        oTab:PageUp() 
        oTab:Down() 
        oTab:RefreshAll() 
        WHILE !oTab:Stabilize() 
        ENDDO 
        ++nCodigo 
        dbUnlockAll() 
     EndIf 
  Enddo 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Set Key K_TAB to 
  SetColor(cCOR) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � ALTERAPAGAR 
� Finalidade  � Alteracao de Contas a Pagar 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraPagar( oTab ) 
  Loca GETLIST:={} 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Loca nCODFOR:=CODFOR, nBANCO_:=BANCO_, dVENCIM:=VENCIM,; 
       nVALOR_:=VALOR_, cOBSERV:=OBSERV, dDATAPG:=DATAPG,; 
       dDATAEM:=EMISS_, nJUROS_:=JUROS_,; 
       cCHEQUE:=CHEQUE, nNFISC_:=NFISC_, nVLRIPI:=VLRIPI, nVLRICM:=VLRICM,; 
       dDentra:=DENTRA, nLocal_:=LOCAL_, nTabOpe:= TABOPE, dCompet:= COMPET 
  Loca cCONFIRMA:="S" 
  Loca nCODIGO:=CODIGO, cDOC___:=DOC___ 
  Local dDataPagamento:= DATAPG 
  Local nBancoConta:= 1, cBancoDescri:= "<< SEM INFORMACAO >>",; 
        nBancoSaldo:= 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo("ALTERACAO DE CONTAS A PAGAR") 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ESC]Retorna [ENTER]Confirma") 
  SetColor(COR[16]+","+COR[18]+",,,"+COR[17]) 
  OPE->( DBSetOrder( 1 ) ) 
  OPE->( DBSeek( PAG->TABOPE ) ) 
  @ 02,02 Say "Operacao...:" Get nTabOpe Pict "999" Valid TabelaOperacoes( @nTabOpe ) When; 
    Mensagem( "Digite a operacao p/ movimentacao." ) 
  @ 03,02 Say "Cli/Fornec.:" Get nCODFOR pict "999999" valid; 
    IF( OPE->CLIFOR=="C", PesqCli( @nCodFor ), DespesaSeleciona( @nCODFOR ) ) when; 
    Mensagem("Digite o codigo do fornecedor, despesa ou cliente.") 
  @ 04,02 Say "DOC........:" Get cDOC___ when; 
    Mensagem("Digite o numero do documento.") 
  @ 05,02 Say "Local/Banco:" Get nBANCO_ pict "999" when; 
    Mensagem("Digite o numero do banco para pagamento.") 
  @ 06,02 Say "Emissao....:" Get dDATAEM when; 
    Mensagem("Digite a data de emissao do documento.") 
  @ 06,26 Say "Compet:" Get dCompet 
  @ 07,02 Say "Vencimento.:" Get dVENCIM when; 
    Mensagem("Digite a data de vencimento.") valid; 
    VERDATA(@dVENCIM) 
  @ 08,02 Say "Data pgto..: [" + DTOC( dDATAPG ) + "]" 
    //Mensagem("Digite a data em que foi pago o documento.") 
  @ 09,02 Say "Valor......:" Get nVALOR_ pict "@E 99,999,999,999.99" when; 
    Mensagem("Digite o valor que foi pago.") 
  @ 10,02 Say "Juros pagos:" Get nJUROS_ pict "@E 99,999,999,999.99" when; 
     Mensagem("Digite o valor dos juros pagos.") 
  @ 11,02 Say "Observacoes:" Get cOBSERV when; 
    Mensagem("Digite qualquer observacao que se refira ao documento.") 
  @ 12,02 Say "Localizacao:" Get nLocal_ Pict "999" when; 
    Mensagem( "Digite a localizacao da conta/banco." ) 
  Read 
  IF !LastKey() == K_ESC 
     Set(_SET_DELIMITERS,.F.) 
     VpBox( 04, 45, 10, 77, "IMPOSTOS", _COR_GET_BOX, .F., .F. ) 
     @ 05,46 Say "Nota Fiscal...:" Get nNFISC_ Pict "999999" 
     @ 06,46 Say "Cheque........:" Get cCHEQUE 
     @ 07,46 Say "Valor do ICMs.:" Get nVLRICM Pict "@E 9999,999,999.99" 
     @ 08,46 Say "Valor do IPI..:" Get nVLRIPI Pict "@E 9999,999,999.99" 
     @ 09,46 Say "Data Entrada..:" Get dDEntra 
     Read 
  ENDIF 
  Set(_SET_DELIMITERS,.T.) 
  If Confirma( 12, 63, "Confirma?",; 
     "Digite [S] para confirmar o cadastramento.","S",; 
     COR[16]+","+COR[18]+",,,"+COR[17]) 
     /* Gravacao de informacoes em contas a pagar */ 
     DBSelectAr( _COD_PAGAR ) 
     If netrlock(5) 
        Repl CODIGO with nCODIGO,; 
             DOC___ with cDOC___,; 
             CODFOR with nCODFOR,; 
             BANCO_ with nBANCO_,; 
             VENCIM with dVENCIM,; 
             VALOR_ with nVALOR_,; 
             DATAPG with dDATAPG,; 
             OBSERV with cOBSERV,; 
             EMISS_ with dDATAEM,; 
             JUROS_ with nJUROS_,; 
             QUITAD with IF( dDATAPG <> ctod("  /  /  "), "S", "N" ),; 
             CHEQUE with cCHEQUE,; 
             NFISC_ with nNFISC_,; 
             VLRIPI with nVLRIPI,; 
             VLRICM with nVLRICM,; 
             DENTRA with dDEntra,; 
             COMPET With dCompet,; 
             TABOPE With nTabOpe,; 
             LOCAL_ With nLocal_ 
        DBUnlockAll() 
     EndIf 
  EndIf 
  SetColor(COR[21]) 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  SetColor(cCOR) 
  Return nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � BAIXAPAGAR 
� Finalidade  � Baixa de Contas a Pagar 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function BaixaPagar( oTab ) 
  Loca GETLIST:={} 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Loca nCODFOR:=CODFOR, nBANCO_:=BANCO_, dVENCIM:=VENCIM,; 
       nVALOR_:=VALOR_, cOBSERV:=OBSERV, dDATAPG:=DATAPG,; 
       dDATAEM:=EMISS_, nJUROS_:=JUROS_,; 
       cCHEQUE:=CHEQUE, nNFISC_:=NFISC_, nVLRIPI:=VLRIPI, nVLRICM:=VLRICM,; 
       dDentra:=DENTRA, nLocal_:=LOCAL_, nTabOpe:= TABOPE 
  Loca cCONFIRMA:="S" 
  Loca nCODIGO:=CODIGO, cDOC___:=DOC___ 
  Local dDataPagamento:= DATAPG 
  Local nBancoConta:= LOCAL_, cBancoDescri:= "<< SEM INFORMACAO >>",; 
        nBancoSaldo:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo("QUITACAO DE CONTAS A PAGAR") 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ESC]Retorna [ENTER]Confirma") 
 
  IF !EMPTY( dDataPg ) 
     IF Confirma( 0, 0, "Confirma o estorno desta Quitacao?", " ", "N" ) 
        cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
        lSaida:= .F. 
        WHILE !lSaida 
           PesqBco( @nBancoConta, .T. ) 
           IF LastKey() == K_ESC 
              lSaida:= .T. 
              SetColor( cCor ) 
              SetCursor( nCursor ) 
              ScreenRest( cTela ) 
              Return Nil 
           ENDIF 
           cBancoDescri:= BAN->DESCRI 
           nBancoSaldo:=  BAN->SALDO_ 
           cHistorico:= "Estorno Pagamento " + StrZero( nCodigo, 6, 0 ) + " D:" + cDoc___ + " C:" + StrZero( nCodFor, 4, 0 )
 
           /* Lancamento de Entrada p/ uma Conta de Transferencia */ 
           LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ESTORNO DE PAGAMENTO", cHistorico, 0, nValor_ ) 
           LancaSaldos( nBancoConta, cBancoDescri, "T", 0, nValor_ ) 
 
           DBSelectAr( _COD_DESPESAS ) 
           DBSetOrder( 1 ) 
           DBSeek( nCodFor )
           /* Lancamento de Saida na Conta Fornecedor/Despesa */ 
           LancaMovimento( DATE(), nCodFor, Des->DESCRI, "D", "ESTORNO DE PAGAMENTO", cHistorico, nValor_, 0 ) 
           LancaSaldos( nCodFor, Des->DESCRI, "D", nValor_, 0 ) 
 
           IF !nJuros_ == 0 
              /* Lancamento de Juros */ 
              LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ESTORNO DE JUROS", cHistorico, 0, nJuros_ ) 
              LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", 0, nJuros_ ) 
           ENDIF 
           lSaida:= .T. 
           DBSelectAr( _COD_PAGAR ) 
 
        ENDDO 
        IF netrlock(5) 
           repl DATAPG with CTOD( "  /  /  " ),; 
                QUITAD with If(dDATAPG<>ctod("  /  /  "),"S","N"),; 
                CHEQUE with cCHEQUE,; 
                OBSERV With cOBSERV 
           DBUnlockAll() 
        ENDIF 
 
     ENDIF 
  ELSE 
     SetColor(COR[16]+","+COR[18]+",,,"+COR[17]) 
     @ 08,02 Say "Data pgto..:" Get dDATAPG when; 
       Mensagem("Digite a data em que foi pago o documento.") 
     @ 09,02 Say "Valor......:" Get nVALOR_ pict "@E 99,999,999,999.99" when; 
       Mensagem("Digite o valor que foi pago.") 
     @ 10,02 Say "Juros pagos:" Get nJUROS_ pict "@E 99,999,999,999.99" when; 
       Mensagem("Digite o valor dos juros pagos.") 
     @ 11,02 Say "Observacoes:" Get cOBSERV when; 
       Mensagem("Digite qualquer observacao que se refira ao documento.") 
     @ 12,02 Say "Localizacao:" Get nLocal_ Pict "999" when; 
       Mensagem( "Digite a localizacao da conta/banco." ) 
     Read 
     IF !LastKey() == K_ESC 
        Set(_SET_DELIMITERS,.F.) 
        @ 06,46 Say "Cheque........:" Get cCHEQUE 
        Read 
     ENDIF 
     Set(_SET_DELIMITERS,.T.) 
     If Confirma( 12, 63, "Confirma?",; 
        "Digite [S] para confirmar o cadastramento.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        IF !LastKey() == K_ESC 
           IF dDataPagamento == CTOD( "  /  /  " ) .AND. !dDataPg == CTOD( "  /  /  " ) 
              cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
 
              /* Busca banco para quitacao & lancamento de valores financeiros */ 
              nBancoConta:= nLocal_ 
              lSaida:= .F. 
              WHILE !lSaida 
                 PesqBco( @nBancoConta, .T. ) 
                 IF LastKey() == K_ESC 
                    lSaida:= .T. 
                    SetColor( cCor ) 
                    SetCursor( nCursor ) 
                    ScreenRest( cTela ) 
                    Return Nil 
                 ENDIF 
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
                 lSaida:= .T. 
                 DBSelectAr( _COD_PAGAR ) 
 
 
              ENDDO 
 
 
           ENDIF 
 
        ENDIF 
        If netrlock() 
           repl VALOR_ with nVALOR_, DATAPG with dDATAPG,; 
                OBSERV with cOBSERV,; 
                JUROS_ with nJUROS_,; 
                QUITAD with If(dDATAPG<>ctod("  /  /  "),"S","N"),; 
                CHEQUE with cCHEQUE,; 
                LOCAL_ With nBancoConta 
           unLock 
        EndIf 
     EndIf 
  ENDIF 
  SetColor(COR[21]) 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  SetColor(cCOR) 
  Return nil 
 
 
  Stat Func DupAPagar() 
  LOCAL cCor:= SetColor() 
  LOCAL nCursor:= SetCursor() 
  loca cTela1:= SCREENSAVE(00,00,24,79) 
  Loca cTela:=  SCREENSAVE(00,00,24,79) 
  loca nLIN:=0 
  loca cQuitadas:= "SN " 
  loca dData1:= DATE() 
  loca dData2:= DATE() 
  loca nTotGeral:= 0 
  loca lImprime:= .T. 
  loca dData, aMatriz:={} 
  loca oTAB, nROW:=1 
  loca cString:="", cQuit:= " " 
  set(_SET_DELIMITERS,.F.) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  usermodulo("Modulo de impressao") 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
  if !file(_VPB_DESPESAS) 
     set(_SET_DELIMITERS,.T.) 
     mensagem("Arquivo de fornecedores inexistente, pressione [ENTER] p/ continuar...") 
     pausa() 
     screenrest(cTELA) 
     return nil 
  else 
     if !fdbusevpb(_COD_DESPESAS,2) 
         set(_SET_DELIMITERS,.T.) 
         mensagem("Acesso ao arq. de fornecedores nao permitido.") 
         pausa() 
         screenrest(cTELA) 
         return nil 
     endif 
  endif 
  if !file(_VPB_BANCO) 
     set(_SET_DELIMITERS,.T.) 
     mensagem("Atencao, arquivo de banco inexistente, pressione [ENTER] p/ continuar...") 
     pausa() 
     screenrest(cTELA) 
     return nil 
  else 
     if !fdbusevpb(_COD_BANCO,2) 
         set(_SET_DELIMITERS,.T.) 
         mensagem("Acesso ao arq. de bancos nao permitido, pressione [ENTER] p/ continuar...") 
         pausa() 
         screenrest(cTELA) 
         return nil 
     endif 
  endif 
  if !file(_VPB_PAGAR) 
     set(_SET_DELIMITERS,.T.) 
     mensagem("Atencao, arq. de ctas. a pagar inexistente, pressione [ENTER] p/ continuar...") 
     pausa() 
     screenrest(cTELA) 
     return nil 
  else 
     if !fdbusevpb(_COD_PAGAR,1) 
         set(_SET_DELIMITERS,.T.) 
         screenrest(cTELA) 
         return nil 
     endif 
  endif 
  VPbox( 01, 01, 21, 77, "Verificacao de duplicatas a pagar",COR[24],.T.,.F.,COR[24]) 
  mensagem("Digite o intervalo de dias a imprimir...") 
  SETCOLOR(COR[24]) 
  @ 02,03 say "INTERVALO => Dia:" get dDATA1 
  @ 02,30 say "ate" get dDATA2 
  @ 02,45 say "Quitadas?" get cQuit Pict "@!" valid cQuit$"SN " 
  read 
 
  IF cQuit=="S" 
     cQuitadas:= "S" 
  ELSEIF cQuit=="N" 
     cQuitadas:= "N " 
  ELSE 
     cQuitadas:= "SN " 
  ENDIF 
 
  mensagem("Transferindo dados entre arquivos, aguarde...",1) 
  dbselectar(_COD_PAGAR) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To 
  set relation to CODFOR into DES 
  #ifdef LINUX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On Vencim Tag At1 Eval {|| Processo() } To "&GDir/indres.ntx" For VENCIM>=dData1 .AND. VENCIM <=dData2 .AND. QUITAD $ cQuitadas 
  #else 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       index on vencim tag at1 eval {|| processo() } to "&gdir/indres.ntx" for vencim>=ddata1 .and. vencim <=ddata2 .and. quitad $ cquitadas 
     #else 
       Index On Vencim Tag At1 Eval {|| Processo() } To "&GDir\IndRes.NTX" For VENCIM>=dData1 .AND. VENCIM <=dData2 .AND. QUITAD $ cQuitadas 
     #endif
  #endif 
  // set filter to VENCIM>=dDATA1 .AND. VENCIM<=dDATA2 
  dbgotop() 
  mensagem("Transferindo dados p/ matriz, Aguarde...",1) 
  dbgotop() 
  nTOTGERAL:=0 
  dDATA:=ctod("01/01/01") 
  lIMPRIME:=.T. 
  aMatriz:={} 
 
  DISPBOX(02,58,03,70) 
  @ 02,61 SAY "Registro" 
 
  whil ! eof() 
     if !eof() 
        //.AND. QUITAD$cQUITADAS 
        whil ! eof() 
           if ! eof() 
              if VENCIM<>dDATA 
                 dDATA0:=VENCIM 
                 nREGISTRO:=recno() 
                 sum VALOR_ to nTOTDIA for VENCIM=dDATA0 .AND.; 
                             QUITAD$cQUITADAS 
                 dbgoto(nREGISTRO) 
                 if nTOTDIA<>0 
 
                    AADD( aMatriz, { SPAC(80) } ) 
                    AADD( aMatriz, { REPL("�",80) } ) 
 
                    cString:= semana(VENCIM)+", "+; 
                              alltrim(str(day(VENCIM)))+" de "+; 
                              mes(month(VENCIM))+" de "+; 
                              strzero(year(VENCIM),4,0)+" =>" 
 
                    /* Adiciona em aMATRIZ c/ valor */ 
                    AADD( aMatriz, { STUFF( SPACE(55)+; 
                          TRAN( nTOTDIA, "@E 999,999,999,999.99" ),; 
                          1,; 
                          LEN( cString ),; 
                          cString ) } ) 
 
                    nTOTGERAL+=nTOTDIA 
                    AADD( aMatriz, { repl("�",80) } ) 
                    nCODFOR:=CODFOR 
                    cDESCRI:=DES->DESCRI 
                    dDATA=VENCIM 
                    if (CODFOR=nCODFOR .OR. cDESCRI=DES->DESCRI) .AND.; 
                       VENCIM>=dDATA1 .AND. VENCIM<=dDATA2 .AND. QUITAD$cQUITADAS 
                       lIMPRIME:=.T. 
                    endif 
                 endif 
              endif 
           endif 
           nCODFOR:=CODFOR 
           cDESCRI:=DES->DESCRI 
           dDATA=VENCIM 
           if lIMPRIME 
              AADD( aMatriz, { SPACE(80) } ) 
              AADD( aMatriz, { STRZERO(CODFOR,4,0) +" "+ ALLTRIM( DES->DESCRI ) + REPL("�",80) } ) 
              lIMPRIME:=.F. 
           endif 
           if QUITAD$cQUITADAS 
              AADD( aMatriz, { STRZERO(CODIGO,4,0)+" "+; 
                               DOC___+" "+; 
                               DTOC( EMISS_ )+" "+; 
                               DTOC( VENCIM )+" "+; 
                               STRZERO( BANCO_, 3, 0 )+" "+; 
                               TRAN( VALOR_, "@E 999,999,999.99" )+" "+; 
                               DTOC( DATAPG )+" "+; 
                               IF( DATAPG<>CTOD("  /  /  "), "Quitada  ",; 
                                                             "Pendente ") } ) 
           endif 
           Roller( 05,64 ) 
           @ 03,64 say STRZERO(recno(),4,0) 
           dbskip() 
           if (CODFOR<>nCODFOR .OR. cDESCRI<>DES->DESCRI) .AND.; 
              VENCIM>=dDATA1 .AND. VENCIM<=dDATA2 .AND. QUITAD$cQUITADAS 
              lIMPRIME:=.T. 
           endif 
        enddo 
     endif 
     @ 03,64 say STRZERO(recno(),4,0) 
     dbskip() 
     if eof(); exit; endif 
  enddo 
  tone(500,1) 
  @ 20,04 say "Total geral:"+TRAN( nTOTGERAL, "@E 999,999,999,999.99" ) 
  setcolor(COR[21]+","+COR[22]) 
  setcursor(0) 
  cTela:=zoom(03,02,19,76) 
  vpbox(03,02,19,76,"Consulta",COR[20],.F.,.F.,COR[19]) 
  DEVPOS(04,03) 
  /*      0000 XXXXXXXXXX DD/MM/AA DD/MM/AA 000 000.000.000,00 DD/MM/AA XXXXXXXXXX */ 
  DEVOUT("Cod. Documento  Emissao  Vencim   Ban Valor          Pagto    Situacao") 
  DISPBOX(05,03,05,75,2) 
  IF LEN( aMatriz )==0 
     Tone( 300, 2 ) 
     Mensagem( "Nenhuma conta a pagar neste periodo...", 1 ) 
     Pausa() 
     /* Restaurar Indices */ 
     DBSelectAr( _COD_PAGAR ) 
 
     #ifdef LINUX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Set Index To "&GDir/pagind01.ntx", "&GDir/pagind02.ntx", "&GDir/pagind03.ntx" 
     #else 

        // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
        #ifdef LINUX
          set index to "&gdir/pagind01.ntx", "&gdir/pagind02.ntx", "&gdir/pagind03.ntx" 
        #else 
          Set Index To "&GDir\PAGIND01.NTX", "&GDir\PAGIND02.NTX", "&GDir\PAGIND03.NTX" 
        #endif
     #endif 
 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     UnZoom(cTela) 
     ScreenRest(cTela1) 
     return NIl 
  ENDIF 
  oTAB:=tbrowsenew(06,03,18,75) 
  oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[nRow][1] })) 
  oTAB:AUTOLITE:=.f. 
  oTAB:GOTOPBLOCK :={|| nRow:=1} 
  oTAB:GOBOTTOMBLOCK:={|| nRow:=len( aMatriz )} 
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nRow ) } 
  oTAB:dehilite() 
  whil .t. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
     whil nextkey()==0 .and. ! oTAB:stabilize() 
     end 
     Tecla:=inkey(0) 
     if TECLA==K_ESC   ;exit   ;endif 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_LEFT       ;oTAB:PanLeft() 
        case TECLA==K_RIGHT      ;oTAB:PanRight() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  enddo 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  UnZoom(cTela) 
  ScreenRest(cTela1) 
  /* Restaurar Indices */ 
  DBSelectAr( _COD_PAGAR ) 
  #ifdef LINUX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To "&GDir/pagind01.ntx", "&GDir/pagind02.ntx", "&GDir/pagind03.ntx" 
  #else 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/pagind01.ntx", "&gdir/pagind02.ntx", "&gdir/pagind03.ntx" 
  #else 
    Set Index To "&GDir\PAGIND01.NTX", "&GDir\PAGIND02.NTX", "&GDir\PAGIND03.NTX" 
  #endif
  #endif 
 
  return NIl 
 
 
/* 
** Funcao      - PESQCODIGO 
** Finalidade  - Pesquisa pelo numero de cadastro da Conta a Pagar 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
stat func pesqcodigo(nPCODIGO) 
  Loca cTELA:=ScreenSave(23,00,24,79), nREGISTRO:=recno() 
  If nPCODIGO=0; Return(.F.); EndIf 
  dbsetorder(1) 
  If dbseek(nPCODIGO) 
     If nORDEMG=1 
        exibedbf() 
     EndIf 
     Ajuda("[TAB]Altera [ESC]Cancela") 
     Mensagem("Item j� cadastrado, pressione [ENTER] para continuar....") 
     Pausa() 
     ScreenRest(cTELA) 
     dbgoto(nREGISTRO) 
     dbsetorder(nORDEMG) 
     Return(.F.) 
  EndIf 
  dbgoto(nREGISTRO) 
  dbsetorder(nORDEMG) 
  Return(.T.) 
 
 
/* 
** Funcao       - EXCLUSAOPAGAR 
** Finalidade   - Executar a inicializacao do modulo de exclusao de cta. pagar. 
** Programador  - Valmor Pereira Flores 
** Data         - 01/Novembro/1994 
** Atualizacao  - 
*/ 
func exclusaopagar 
  Loca cTELA:=ScreenSave(00,00,24,79), cCOR:=SetColor(),; 
       nCURSOR:=SetCursor() 
  Priv cTELA0 
  Priv nORDEMG:=1, nCODIGO:=0, cDOC___:=space(10), aTELA1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo(" Exclusao de Contas a Pagar ") 
  If !File(_VPB_PAGAR) 
     Aviso(" Arquivo de contas a pagar inexistente! ",24/2) 
     Ajuda("[ENTER]Retorna") 
     Mensagem("Pressione [ENTER] para retornar...",1) 
     Pausa() 
     ScreenRest(cTELA) 
     Return nil 
  EndIf 
  If !FDbUseVpb(_COD_PAGAR,1) 
     Aviso("ATENCAO! VerIfique o arquivo "+alltrim(_VPB_PAGAR)+".",24/2) 
     Mensagem("Erro na abertura do arquivo de ctas. a pagar, tente novamente...") 
     Pausa() 
     SetColor(cCOR) 
     SetCursor(nCURSOR) 
     ScreenRest(cTELA) 
     Return(NIL) 
  EndIf 
  SetColor(COR[16]) 
  Scroll(01,01,24-2,79-1) 
  VPBox( 01, 00, 12, 79, , COR[16] ) 
  VpBox( 12, 01, 12, 79-1," Arquivo ",COR[16],.F.,.F.,COR[16]) 
  aTELA1:=BoxSave(01,01,12,79-1) 
  cTELA0:=ScreenSave(02,40,08,72) 
  Whil LastKey()<>K_ESC 
     Ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [TAB]Exclui [ESC]Cancela") 
     exibstr() 
     pesquisadbf(2) 
  Enddo 
  Set Key K_TAB to 
  dbunlockall() 
  FechaArquivos() 
  SetColor(cCOR) 
  SetCursor(nCURSOR) 
  ScreenRest(cTELA) 
  Return nil 
 
/* 
** Funcao       - AlteracaoPagar 
** Finalidade   - Executar a inicializacao do modulo de alteracao de cta. pagar. 
** Programador  - Valmor Pereira Flores 
** Data         - 01/Novembro/1994 
** Atualizacao  - 
*/ 
func alteracaopagar 
  Loca cTELA:=ScreenSave(00,00,24,79), cCOR:=SetColor(),; 
       nCURSOR:=SetCursor() 
  Loca lFlag:=.F. 
  Priv cTELA0 
  Priv nORDEMG:=1, nCODIGO:=0, cDOC___:=space(10), aTELA1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo(" Alteracao de Contas a Pagar ") 
  If !File(_VPB_DESPESAS) 
     Aviso("Arquivo de despesas diversas nao encontrado.",24/2) 
     lFlag:=.T. 
  ElseIf !lFLAG 
     If !FDbUseVpb(_COD_DESPESAS,2) 
        Aviso("Impossivel acesso ao arquivo de despesas diversas.",24/2) 
        lFLAG:=.T. 
     EndIf 
  EndIf 
  If !File(_VPB_PAGAR) 
     Aviso(" Arquivo de contas a pagar inexistente! ",24/2) 
     lFLAG:=.T. 
  ElseIf !lFLAG 
     If !FDbUseVpb(_COD_PAGAR,2) 
        Aviso("Nao foi possivel carregar o arquivo de contas a pagar...",24/2) 
        lFLAG:=.T. 
     EndIf 
  EndIf 
  If lFLAG 
     Ajuda("[ENTER]Retorna") 
     Mensagem("Pressione [ENTER] para retornar...",1) 
     Pausa() 
     ScreenRest(cTELA) 
     Return nil 
  EndIf 
  SetColor(COR[16]) 
  Scroll(01,01,24-2,79-1) 
  VPBox( 01, 00, 12, 79, , COR[16] ) 
  VpBox(12,01,12,79-1," Arquivo ",COR[16],.F.,.F.,COR[16]) 
  aTELA1:=BoxSave(01,01,12,79-1) 
  cTELA0:=ScreenSave(02,40,08,72) 
  Whil LastKey()<>K_ESC 
     Ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [TAB]Exclui [ESC]Cancela") 
     exibstr() 
     pesquisadbf(1) 
  Enddo 
  Set Key K_TAB to 
  dbunlockall() 
  FechaArquivos() 
  SetColor(cCOR) 
  SetCursor(nCURSOR) 
  ScreenRest(cTELA) 
  Return nil 
 
/* 
** Funcao       - EXIBESTRU 
** Finalidade   - Exibir a estrutura do cadastro na tela 
** Programador  - VPF 
** Data         - 
** Atualizacao  - 
*/ 
stat func exibstr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 01,02 Say "Emp/Codigo.: [000]-["+strzero(CODIGO,6,0)+"]" 
  @ 02,02 Say "Operacao...: [" + StrZero( TABOPE, 3, 0 ) + "]" 
  @ 03,02 Say "Cli/Fornec.: ["+strzero(CODFOR,6,0)+"]" 
  @ 04,02 Say "DOC........: ["+DOC___+"]" 
  @ 05,02 Say "Local/Banco: ["+strzero(BANCO_,3,0)+"]" 
  @ 06,02 Say "Emissao....: ["+dtoc(EMISS_)+"]" 
  @ 06,26 Say "Compet: ["+DTOC(COMPET)+"]" 
  @ 07,02 Say "Vencimento.: ["+dtoc(VENCIM)+"]" 
  @ 08,02 Say "Data pgto..: ["+dtoc(DATAPG)+"]" 
  @ 09,02 Say "Valor......: ["+tran(VALOR_,"@E 99,999,999,999.99")+"]" 
  @ 10,02 Say "Juros pagos: ["+tran(JUROS_,"@E 99,999,999,999.99")+"]" 
  @ 11,02 Say "Observacoes: ["+OBSERV+"]" 
  @ 12,02 Say "Localizacao: [   ]" 
  @ 02,41 Say "" 
  SetColor( cCor ) 
  Return nil 
 
func mostrapaga(cTELA) 
  cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 01,16 Say StrZero( FILIAL, 3, 0 ) + "]-[" + strzero( CODIGO, 6, 0 ) 
  OPE->( DBSetOrder( 1 ) ) 
  IF OPE->( DBSeek( PAG->TABOPE ) ) 
     @ 02,30 Say " -> " + OPE->DESCRI 
     IF OPE->CLIFOR=="C" 
        CLI->( DBSetOrder( 1 ) ) 
        CLI->( DBSeek( PAG->CODFOR ) ) 
        @ 03,30 Say " -> " + CLI->DESCRI 
     ELSE 
        DES->( DBSetOrder( 1 ) ) 
        DES->( DBSeek( PAG->CODFOR ) ) 
        @ 03,30 Say " -> " + DES->DESCRI 
     ENDIF 
  ENDIF 
  @ 02,16 Say StrZero( OPE->CODIGO, 3, 0 ) 
  @ 03,16 Say strzero( CODFOR, 6, 0 ) 
  @ 04,16 Say DOC___ 
  @ 05,16 Say strzero(BANCO_,3,0) 
  @ 06,16 Say EMISS_ 
  @ 07,16 Say VENCIM 
  @ 08,16 Say DATAPG 
  @ 06,35 Say COMPET 
  @ 09,16 Say tran(VALOR_,"@E 99,999,999,999.99") 
  @ 10,16 Say tran(JUROS_,"@E 99,999,999,999.99") 
  @ 11,16 Say OBSERV 
  @ 12,16 Say Str( LOCAL_, 3 ) 
  VpBox( 04, 45, 10, 77, "IMPOSTOS", _COR_GET_BOX, .F., .F. ) 
  @ 05,46 Say "Nota Fiscal...: " + StrZero(NFISC_,6,0) 
  @ 06,46 Say "Cheque........: " + CHEQUE 
  @ 07,46 Say "Valor do ICMs.: " + Tran(VLRICM,"@E 9999,999,999.99") 
  @ 08,46 Say "Valor do IPI..: " + Tran(VLRIPI,"@E 9999,999,999.99") 
  @ 09,46 Say "Data Entrada..: " + DTOC( DENTRA ) 
  SetColor( cCor ) 
  Return nil 
 
 
/* 
** VERDATA 
** Verifica se a data cai num feriado ou nao 
** Valmor Pereira Flores 
*/ 
Function VerData(dDATA) 
  Loca cTELA:=SCREENSAVE(00,00,24,79), cCOR:=SetColor(),; 
       nCURSOR:=SetCursor(), nAREA:=Select(), nORDEM:=IndexOrd() 
  Loca cMensagem:="" 
  Loca dDATAR:=dDATA 
  Loca GETLIST:={} 
 
   /* Tabela de feriados */ 
   DBSelectAr( _COD_FERIADOS ) 
   SetCursor(0) 
   SetColor("W+/R") 
   If Dbseek(StrZero(Month(dDATA),2,0)+StrZero(Day(dDATA),2,0)) .OR.; 
      Dow(dDATA)=1 .OR.; 
      Dow(dDATA)=7 
      If Dow(dDATA)==1 .OR. Dow(dDATA)==7 
         cMensagem:= "Esta data cair� num fim-de-semana:;Dia da semana: "+SEMANA(dDATA) 
      Else 
         cMensagem:= "Neste dia ser� feriado;"+FER->DESCRI 
      Endif 
      If DES->ANTPOS=="A" 
         --dDATA 
         If dow(dDATA)=1        /* Domingo */ 
            dDATA-=2 
         ElseIf dow(dDATA)=7    /* Sabado */ 
            --dDATA 
         Endif 
      Else 
         ++dDATA 
         If dow(dDATA)=7        /* Sabado */ 
            dDATA+=2 
         ElseIf dow(dDATA)=1    /* Domingo */ 
            dDATA++ 
         Endif 
      Endif 
      cMensagem:= cMensagem + ";Atencao-Segundo o cadastro desta conta a;" 
      cMensagem:= cMensagem + "data de vencimento sera transferida para o dia;" 
      cMensagem:= cMensagem + dtoc(dDATA)+" "+SEMANA(dDATA) 
      If SWAlerta( cMensagem, {"Confirma","Cancela"} )==2 
         dDATA:=dDATAR 
      Endif 
   EndIf 
   DbSelectar(nAREA) 
   DbSetOrder(nORDEM) 
   SetColor(cCOR) 
   SetCursor(nCURSOR) 
   ScreenRest(cTELA) 
   Return( .T. ) 
 
 
