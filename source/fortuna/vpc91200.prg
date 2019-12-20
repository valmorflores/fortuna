// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC912000 
� Finalidade  � Gerenciamento de Contas a Receber 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 26/Agosto/1998 
��������������� 
*/
#ifdef HARBOUR
function vpc91200()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, cTelaRes, dData1:= dData2:= DATE(), cCliente 
Local lDelimiters:= Set( _SET_DELIMITERS ) 
Local cNossoN 
Local nDesReg:= 0 
 
   /* Verifica a existencia do arquivo de NOTA FISCAL e 
      CADASTRO DE CLIENTES */ 
 
   nDesReg:= DES->( RECNO() ) 
   DES->( DBSetOrder( 1 ) ) 
   DES->( DBSeek( 999999 ) ) 
 
   DBSelectAr( _COD_NFISCAL ) 
   DBSetOrder( 1 ) 
 
   DBSelectAr( _COD_DUPAUX ) 
   DBLeOrdem() 
 
   SetCursor(0) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   Set( _SET_DELIMITERS, .F. ) 
 
   VPbox( 00, 00, 16, 79, " DUPLICATAS A RECEBER ", _COR_GET_BOX, .F., .F. ) 
   VPbox( 17, 00, 24-2, 79," RELACAO DE DUPLICATAS ", _COR_BROW_BOX, .F., .F. ) 
   MostraStr() 
   SetColor( _COR_BROWSE ) 
   Mensagem( "[F8]Pendente [Espaco][+]Quita [-]Estorna [INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   Ajuda( "[CTRL-F1]Info [/]Remessa [*]Anula [TAB]DOC [CTRL+TAB]Dup [Ctrl+F4][Ctrl+F5]E/I" ) 
   oTab:= TBrowsedb( 18, 01, 24-3, 78 ) 
   oTab:Addcolumn( tbColumnNew("N", {|| NFNULA } ) ) 
   oTab:Addcolumn( tbColumnNew("Documento", {|| IF( TIPO__=="02", StrZero( CODNF_, 3, 0 ) + "-" + StrZero( CODIGO, 6, 0 ), Tran( StrZero( CODNF_, 9, 0 ), "@R 999-999999" ) + LETRA_ ) } ) ) 
   oTab:Addcolumn( tbColumnNew("Nome do Cliente", {|| LEFT( CDESCR, 30 ) } ) ) 
   oTab:Addcolumn( tbColumnNew("Vencimen", {|| VENC__ } ) ) 
   oTab:Addcolumn( tbColumnNew("Quitacao", {|| DTQT__ } ) ) 
   oTab:Addcolumn( tbColumnNew("       Valor", {|| Tran( VLR___ + JUROS_ - VLRDES, "@E 9,999,999.99" ) } ) ) 
   oTab:AUTOLITE:=.F. 
   oTab:dehilite() 
   WHILE .T. 
 
      oTab:ColorRect( { oTab:ROWPOS, 1, oTab:ROWPOS, oTab:COLCOUNT }, { 2, 1 } ) 
      WHILE NextKey()==0 .AND.! oTab:Stabilize() 
      ENDDO 
 
      DispBegin() 
      IF NFNULA == "*" 
         cCorRes:= SetColor( "15/02" ) 
         @ Row(), 55 Say " < Lancamento Anulado > " 
         SetColor( cCorRes ) 
      ENDIF 
 
      MostraDados() 
      SetColor( "15/07" ) 
      SCROLL( 16, 00, 16, 79) 
      DEVPOS( 16, 02 ) 
      DEVOUT("Situacao da Duplicata: ") 
      DEVPOS( 16, 26 ) 
      IF !EMPTY( DTQT__ ) 
         DEVOUT("Quitada   "+IF( DTQT__ > VENC__ + 3, "(Atraso de "+ alltrim( STR( DTQT__ - VENC__, 10, 0 ) )+" dias)","") ) 
      ELSE 
         DEVOUT("Pendente  "+IF( DATE() > VENC__ + 3, "(Atraso de "+ alltrim( STR( DATE() - VENC__, 10, 0 ) )+" dias)","" ) ) 
      ENDIF 
 
      // Se houver informacao adicional 
      IF !EMPTY( OBSERV ) .OR. !EMPTY( OBSERV ) 
         @ 16,74 Say "[F11]" Color "15/00" 
      ELSE 
         @ 16,74 Say "     " 
      ENDIF 
 
 
      IF TIPO__=="02" 
         SetColor( _COR_GET_EDICAO ) 
         Scroll( 06, 45, 12, 77 ) 
         @ 11,36 Say subst(SITUAC,1,40) 
         SetColor( _COR_BROWSE ) 
      ELSE 
         Set( _SET_DELIMITERS, .F. ) 
         VpBox( 06, 45, 09, 77, "DIVERSOS", _COR_GET_BOX, .F., .F. ) 
         SetColor( _COR_GET_EDICAO ) 
         @ 07,46 Say "Nota Fiscal...: " + Tran( StrZero( CODNF_, 9, 0 ), "@R 999-999999" ) 
         @ 08,46 Say "Cheque........: " + CHEQ__ 
         SetColor( _COR_BROWSE ) 
      ENDIF 
      DispEnd() 
 
      /* Aguarda o pressionamento de uma tecla */ 
      IF ( nTecla:=inkey(0) )==K_ESC 
         EXIT 
      ENDIF 
      DO CASE 
         CASE Acesso( nTecla ) 

         case nTecla == K_SH_F8
              gSemNome( "receber" )           // by Gelson 21/03/2004
         CASE nTecla == K_F8
              cCliente:= DPA->CDESCR 
              WHILE DPA->CDESCR == cCliente .AND. !( DPA->DTQT__ == Ctod( "  /  /  " ) ) 
                  DBSkip() 
              ENDDO 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 

         CASE nTecla==K_UP         ;oTab:up()
         CASE nTecla==K_LEFT       ;oTab:up() 
         CASE nTecla==K_RIGHT      ;oTab:down() 
         CASE nTecla==K_DOWN       ;oTab:down() 
         CASE nTecla==K_PGUP       ;oTab:pageup() 
         CASE nTecla==K_PGDN       ;oTab:pagedown() 
         CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_CTRL_F10   ;Calendar() 
         CASE nTecla==K_TAB        ;VPCDoc() 
         CASE nTecla==K_F10 
              // Nosso N�mero 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              cCorRes:=  SetColor() 
              cNossoN:=  DPA->NOSSON 
              VPBOX( 03, 10, 09, 50, "Cobranca Bancaria", _COR_GET_BOX  ) 
              SetColor( _COR_GET_EDICAO ) 
              SetCursor( 1 ) 
              @ 05,15 Say " Nosso Numero " Color "15/" + CorFundoAtual() 
              @ 06,15 Say " Codigo fornecido pelo banco " 
              @ 07,15 Say " impresso no boleto bancario " 
              @ 08,15 Say " -- " Get cNossoN 
              READ 
              IF DPA->( netrlock() ) 
                 Replace DPA->NOSSON With cNossoN 
              ENDIF 
              SetCursor( 0 ) 
              ScreenRest( cTelaRes ) 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         CASE nTecla==K_F11 
              cObservacao:= DPA->OBSERV 
              cObserv2:= DPA->OBSER1 
              ListaEdita( @cObservacao, @cObserv2 ) 
              ListaGrava( cObservacao, cObserv2 ) 
 
         CASE Chr( nTecla ) $ "/" 
              BAN->( DBSetOrder( 1 ) ) 
              CLI->( DBSetOrder( 1 ) ) 
              IF CLI->( DBSeek( DPA->CLIENT ) ) 
                 IF SITU__==" " 
                    IF SWAlerta( "Deseja colocar esta duplicata; com as remetidas p/ banco?", { "Confirmar", "Cancelar " } )==1 
                       IF netrlock() 
                          Replace SITU__ With "*" 
                       ENDIF 
                       CTB->( dbappend() ) 
                       IF CTB->( netrlock() ) 
                          cTmp:= IF( !EMPTY( CLI->IDENTI ), CLI->IDENTI, DPA->CDESCR ) 
                          Replace CTB->CODIGO With IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 09, 0 ) + "m", StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) 
                          Replace CTB->SUBCOD With StrZero( 1, 2, 0 ) 
                          Replace CTB->CODREG With "D" 
                          Replace CTB->CADTIP With " " 
                          Replace CTB->IDECLI With CTB->CODIGO + " " + cTmp        // Identificacao do Cliente na Empresa 
                          Replace CTB->IDECON With cTmp                       // Identificao do Consumidor na Empresa 
                          Replace CTB->NOMCON With CLI->DESCRI // Nome do Consumidor 
                          Replace CTB->CIDCON With CLI->CIDADE // Cidade do Consumidor 
                          Replace CTB->ESTCON With CLI->ESTADO // Estado do Consumidor 
                          Replace CTB->TIPCOD With IF( !EMPTY( CLI->CGCMF_), "1", "2" ) // 1=CGC  2=CPF 
                          Replace CTB->CGCCPF WIth IF( !EMPTY( CLI->CGCMF_), CLI->CGCMF_, CLI->CPF___ ) // CGC ou CPF 
                          Replace CTB->CONTAC With VAL( STR( CLI->CONTAC, 9 ) + CLI->DIGVER ) // Conta Corrente 
                          Replace CTB->NUMAGE With CLI->AGENCI // Numero da Agencia 
                          Replace CTB->CODCLI With CLI->CODIGO 
                          Replace CTB->CODBAN With CLI->BANCO_ // Codigo do Banco 
                          IF BAN->(DBSeek ( CLI->BANCO_ ) ) 
                             Replace CTB->NOMBAN With BAN->DESCRI // Nome do Banco 
                          ELSE 
                             Replace CTB->NOMBAN With ""          // Nome do Banco 
                          ENDIF 
                          Replace CTB->DATVEN With DPA->VENC__ 
                          Replace CTB->DATOPC With DPA->DATAEM // Data da Opcao 
                          Replace CTB->CODMOE With "03"        // Codigo da Moeda (01=UFIR 03=REAIS) 
                          Replace CTB->VALDEB With VLR___ + JUROS_ - VLRDES 
                          Replace CTB->VALORI With VLR___ + JUROS_ - VLRDES 
                          Replace CTB->SITUAC With "REMESSA"   // Situacao da Cobranca (Remessa/Retorno) 
                          Replace CTB->JAENVI With "Sim"       // Marcacao de Enviado 
                          Replace CTB->NOMEMP With Alltrim( _EMP )       // Nome da Empresa 
                          Replace CTB->CODCON With SWSet( _GER_BCO_CONVENIO ) // Codigo de Convenio (Informado pelo Banco) 
                          Replace CTB->CTAREC With 1            // Codigo da Conta Corrente de Receptacao 
                          Replace CTB->SELEC_ With "Nao"        // ("Nao"=NAO VAI) ("Sim"=VAI SIM) 
                          Replace CTB->NUMDUP With DPA->DUPL__  // Numero da Duplicata 
                          Replace CTB->SEQDUP With DPA->LETRA_  // Sequencia da Duplicata 
                          Replace CTB->MULTA_ With 0            // Multa 
                          Replace CTB->CORMON With 0            // Correcao Monetaria 
                          Replace CTB->VALPAR With 999999999.99 // Valor Maximo para Parcela 
                       ENDIF 
                    ENDIF 
                 ELSE 
                    IF SWAlerta( "Deseja retirar esta duplicata; da relacao de remetidas p/ banco?", { "Confirmar", "Cancelar " } )==1 
                       IF DPA->( netrlock() ) 
                          Replace SITU__ With " " 
                          CTB->( DBSetOrder( 1 ) ) 
                          IF CTB->( DBSeek( IF( DPA->TIPO__ =="02", StrZero( DPA->CODIGO, 09, 0 ) + "m", StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_ ) ) ) 
                             IF CTB->( netrlock() ) 
                                CTB->( DBDelete() ) 
                             ENDIF 
                             CTB->( DBSkip() ) 
                          ELSE 
                             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                             Aviso( "Registro n�o localizado nas remetidas...." ) 
                             Pausa() 
                             ScreenRest( cTelaRes ) 
                          ENDIF 
                       ENDIF 
                    ENDIF 
                 ENDIF 
                 DBUnLockAll() 
              ELSE 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Cliente nao localizado! Impossivel executar esta operacao." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ENDIF 
         CASE nTecla==K_CTRL_F1 
              RegCliente( 1 ) 
 
         CASE nTecla==K_CTRL_TAB 
              IF Confirma( 00, 00,; 
                 "Confirma a impress�o desta duplicata?",; 
                 "Digite [S] para confirmar ou [N] p/ cancelar.", "N" ) 
                 Relatorio( "DUP.REP" ) 
              ENDIF 
 
         CASE Chr( nTecla )=="-" 
              IF EMPTY( DTQT__ ) 
                 cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
                 Aviso( "Esta duplicata nao foi quitada! Impossivel Estornar." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 BaixaReceber( oTab ) 
              ENDIF 
 
         CASE nTecla==K_CTRL_F4 
 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              IF SWAlerta( "<< GRAVAR RELACAO P/ BAIXA >>; Gravar relacao de baixas em disquete?; Arquivo A:\BAIXAS.TXT",; 
                 { " OK ", " Cancelar " } )==1 
                 DBGoTop() 
                 Set( 24, "A:\BAIXAS.TXT" ) 
                 Set( 20, "PRINT" ) 
                 WHILE !EOF() 
                    @ PROW(),PCOL() Say "X" + STRZERO( CODNF_, 12, 0 )    +; 
                                             LETRA_                       +; 
                                             DTOC( DATAEM )               +; 
                                             DTOC( DTQT__ )               +; 
                                             STRZERO( VLR___, 16, 02 )    + Chr( 13 ) + Chr( 10 ) 
                    DBSkip() 
                 ENDDO 
                 Set( 24, "LPT1" ) 
                 Set( 20, "SCREEN" ) 
              ENDIF 
              IF File( "A:\BAIXAS.TXT" ) 
                 Aviso( "Copia das baixas em disquete realizada com sucesso!" ) 
                 Pausa() 
              ELSE 
                 Aviso( "FALHA NA GRAVACAO" ) 
                 Pausa() 
                 Aviso( "REALIZE NOVA GRAVACAO COM OUTRO DISQUETE!" ) 
                 Pausa() 
              ENDIF 
              ScreenRest( cTelaRes ) 
              oTab:GoTop() 
              oTab:Refreshall() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         CASE nTecla==K_CTRL_F5 
 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              IF SWAlerta( "<< BAIXA AUTOMATICA DE TITULOS >>; Gravar baixas do disquete?",; 
                 { " OK ", " Cancelar " } )==1 
                 DPA->( DBSetOrder( 1 ) ) 
                 DBSelectAr( 123 ) 
                 DBCreate( "BAIXA.TMP", { { "ORIGEM", "C", 100, 00 } } ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Use BAIXA.TMP Alias TMP 
                 APPEND FROM A:\BAIXAS.TXT SDF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 INDEX ON ORIGEM TO INDICE 
                 DBGoTop() 
                 nLinha:= 1 
                 VPBox( 0, 0, 22, 79, "TITULOS", "15/01" ) 
                 WHILE !EOF() 
                     nDuplicata:= VAL( SubStr( ORIGEM, AT( "X", ORIGEM ) + 1, 12 ) ) 
                     cLetra:= SubStr( ORIGEM, AT( "X", ORIGEM ) + 13, 1 ) 
                     dDataQuitacao:= CTOD( SubStr( ORIGEM, AT( "X", ORIGEM ) + 22, 8 ) ) 
 
                     @ ++nLinha,01 Say LEFT( ORIGEM, 78 ) Color IF( AT( "21A", ORIGEM ) > 0, "15/04", "15/01" ) 
 
                     IF nLinha >= 21 
                        Scroll( 01, 01, 21, 78, 1 ) 
                        nLinha:= 20 
                     ENDIF 
                     IF !EMPTY( dDataQuitacao ) 
                        IF DPA->( DBSeek( nDuplicata ) ) 
                           WHILE DPA->( CODNF_ == nDuplicata ) .AND. !EOF() 
                               IF DPA->LETRA_ == cLetra 
                                  IF EMPTY( DPA->DTQT__ ) 
                                     Aviso( "Baixando " + StrZero( nDuplicata, 8, 0 ) + "-" + cLetra  + " em " + DTOC( dDataQuitacao ) ) 
                                     IF DPA->( netrlock() ) 
                                        Replace DPA->DTQT__ With dDataQuitacao 
                                     ENDIF 
                                     DPA->( BaixaReceber( oTab, .T. ) ) 
                                  ENDIF 
                               ENDIF 
                               DPA->( DBSKIP() ) 
                           ENDDO 
                        ENDIF 
                     ENDIF 
                     DBSkip() 
                 ENDDO 
                 dbSelectAr( 123 ) 
                 DBCloseArea() 
                 DBSelectAr( _COD_DUPAUX ) 
              ENDIF 
              ScreenRest( cTelaRes ) 
              Aviso( "Baixas efetuadas com sucesso!" ) 
              Pausa() 
              oTab:GoTop() 
              oTab:Refreshall() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         CASE nTecla==K_SPACE .OR. Chr( nTecla ) == "+" 
              IF !EMPTY( DTQT__ ) 
                 cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
                 Aviso( "Esta duplicata foi quitada! Impossivel Quitar." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 BaixaReceber( oTab ) 
              ENDIF 
 
         CASE chr(nTecla)="*" 
              AnulaDuplicata( oTab ) 
 
         CASE nTecla==K_INS 
              IncluiReceber( oTab ) 
 
         CASE nTecla==K_ENTER 
              IF !EMPTY( DTQT__ ) 
                 cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
                 Aviso( "Esta duplicata foi quitada! Impossivel alterar." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSEIF SITU__=="*" 
 
                 cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
 
                 Aviso( "Esta duplicata foi enviada! Impossivel Alterar." ) 
                 Mensagem( "Pressione [ENTER] para continuar..." ) 
                 Pausa() 
 
                 ScreenRest( cTelaRes ) 
 
              ELSE 
                 IF Tipo__ == "  " 
                    AltRecDuplicata( oTab ) 
                 ELSEIF Tipo__ == "01" 
                    //AltRecCupom( oTab ) 
                 ELSEIF Tipo__ == "02" 
                    AltRecManual( oTab ) 
                 ENDIF 
              ENDIF 
 
 
         CASE nTecla==K_DEL 
              IF !EMPTY( DTQT__ ) 
                 cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
                 Aviso( "Esta duplicata foi quitada! Impossivel excluir." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSEIF SITU__=="*" 
                 cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
                 Aviso( "Esta duplicata foi enviada! Impossivel excluir." ) 
                 Mensagem( "Para excluir mesmo assim pressione [F1]." ) 
                 IF Inkey(0)==K_F1 
                    IF Exclui( oTab ) 
                       LancaCliente( nCliente, nValor, 0 ) 
                    ENDIF 
                 ENDIF 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 nCliente:= CLIENT 
                 nValor:= VLR___ + JUROS_ - VLRDES 
                 IF Exclui( oTab ) 
                    LancaCliente( nCliente, nValor, 0 ) 
                 ENDIF 
              ENDIF 
 
         CASE DBPesquisa( nTecla, oTab ) 
 
         CASE nTecla == K_F2 
              DBMudaOrdem( 1, oTab ) 
 
         CASE nTecla == K_F3 
              DBMudaOrdem( 2, oTab ) 
 
         CASE nTecla == K_F4 
              DBMudaOrdem( 3, oTab ) 
 
         CASE nTecla == K_F5 
              DBMudaOrdem( 4, oTab ) 
 
         CASE nTecla == K_F6 
              DBMudaOrdem( 5, oTab ) 
 
         CASE nTecla == K_F9 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Abrindo gaveta, aguarde..." ) 
              AbreGaveta() 
              Inkey( 0.3 ) 
              ScreenRest( cTelaRes ) 
 
         OTHERWISE                ;tone(125); tone(300) 
      ENDCASE 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   dbunlockall() 
   FechaArquivos() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Set( _SET_DELIMITERS, lDelimiters ) 
   DES->( DBGoTo( nDesReg ) ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � MOSTRASTR 
� Finalidade  � Apresenta a estrutura p/ apresentacao 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
� Alteracao   � Alterado Alberto,Wed  11-04-01,colocar Letra junto com a dup. 
��������������� 
*/ 
Static Function MostraStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 01,02 Say "Empresa.......: [   ]" 
  @ 02,02 Say "Lancamento....: [        ]" 
  IF TIPO__ == "  " 
     @ 03,02 Say "Nota Fiscal...: [999999999]" 
  ELSEIF TIPO__ == "02" 
     @ 03,02 Say "Conta.........: [   ]" 
  ELSEIF TIPO__ == "03" 
     @ 03,02 Say "Cupom Fiscal..: [000-000000]" 
  ENDIF 
  @ 04,02 Say "Cliente.......: [      ]-[                                             ]" 
  @ 05,02 Say "Duplicata.....: [        ]" 
  @ 06,02 Say "Banco.........: [   ]" 
  @ 07,02 Say "Emissao.......: [  /  /  ]" 
  @ 08,02 Say "Prazo em Dias.: [   ]" 
  @ 09,02 Say "Vencimento....: [  /  /  ]" 
  @ 10,02 Say "Quitacao......: [  /  /  ]" 
  @ 11,02 Say "Valor.........: [              ]" 
  @ 11,02 Say "Valor.........: [              ]" 
  @ 12,02 Say "Acrescimos....: [              ]" 
  @ 13,02 Say "Descontos.....: [              ]" 
  @ 14,02 Say "Observacoes...: [                              ]" 
  @ 15,02 Say "Localizacao...: [   ]" 
  SetColor( cCor ) 
 
Static Function MostraDados() 
  Local cCor:= SetColor() 
  Local nMulta:= 0, nTabOpe:= 0, nTabCnd:= 0 
  SetColor( _COR_GET_EDICAO ) 
  @ 01,19 Say StrZero( FILIAL, 3, 0 ) 
  @ 02,19 Say StrZero( CODIGO, 8, 0 ) 
  IF TIPO__ == "  " 
     SetColor( "15/02" ) 
     @ 02,55 Say " NOTA FISCAL       " 
     SetColor( _COR_GET_EDICAO ) 
     @ 03,02 Say "Nota Fiscal...: [999999999]    " 
     @ 03,19 Say StrZero( CODNF_, 9, 0 ) 
  ELSEIF TIPO__ == "02" 
     SetColor( "15/04" ) 
     @ 02,55 Say " LANCAMENTO MANUAL " 
     SetColor( _COR_GET_EDICAO ) 
     @ 03,02 Say "Conta.........: [   ]       " 
     @ 03,19 Say StrZero( CODNF_, 3, 0 ) 
  ELSEIF TIPO__ == "03" 
     SetColor( "15/05" ) 
     @ 02,55 Say " CUPOM FISCAL      " 
     SetColor( _COR_GET_EDICAO ) 
     @ 03,02 Say "Cupom Fiscal..: [000-000000]" 
     @ 03,19 Say Tran( StrZero( CODNF_, 9, 0 ), "@R 999-999999" ) 
  ENDIF 
  @ 03,30 Say Space( 47 ) 
  IF TIPO__=="02" 
     @ 03,30 Say Space( 47 ) 
     REC->( DBSetOrder( 1 ) ) 
     IF REC->( DBSeek( DPA->CODNF_ ) ) 
        @ 03,31 Say PADL( ALLTRIM( REC->DESCRI ), 44, "�" ) Color "14/" + _COR_GET_FUNDO 
     ELSE 
     ENDIF 
  ENDIF 
  @ 04,19 Say StrZero( CLIENT, 6, 0 ) 
  @ 04,28 Say CDESCR 
  @ 05,19 Say Tran( StrZero( CODNF_, 9, 0 ), "@R 999-999999" )+"/"+LETRA_ 
  @ 05,32 Say IF( SEQUE_ > 0, StrZero( SEQUE_, 8, 0 ), Space( 8 ) ) + "]" 
  @ 06,19 Say StrZero( BANC__, 3, 0 ) 
  @ 07,19 Say DATAEM 
  @ 08,19 Say StrZero( PRAZ__, 3, 0 ) 
  @ 09,19 Say VENC__ 
  @ 10,19 Say DTQT__ 
  @ 11,19 Say Tran( VLR___, "@E 999,999,999.99" ) 
  @ 11,36 Say subst(SITUAC,1,40) 
  @ 12,19 Say Tran( JUROS_, "@E 999,999,999.99" ) 
  @ 13,19 Say Tran( VLRDES, "@E 999,999,999.99" ) 
  @ 13,35 Say "[" + Tran( VLR___ + JUROS_ - VLRDES, "@E 99,999,999.99" ) + "]" 
  @ 14,19 Say OBS___ 
  @ 15,19 Say StrZero( LOCAL_, 3, 0 ) 
  BAN->( DBSetOrder( 1 ) ) 
  BAN->( DBSeek( DPA->LOCAL_ ) ) 
  @ 15,25 Say BAN->DESCRI + " " + IF( SITU__=="*", "< DOC >", "       " ) 
  IF NFNULA==" " 
 
     /* ------------------------------------------------------------------ */ 
     IF TIPO__=="  " .OR. TIPO__=="03" 
 
        /*******==========[ TIPO / "  " / "02" / "03" ]=========******/ 
        IF TIPO__=="  " 
           NF_->( DBSetOrder( 1 ) ) 
           NF_->( DBSeek( DPA->CODNF_ ) ) 
           nTabOpe:= NF_->TABOPE 
           nTabCnd:= NF_->TABCND 
        ELSE 
           CUP->( DBSetOrder( 1 ) ) 
           CUP->( DBSeek( DPA->CODNF_ ) ) 
           nTabOpe:= CUP->TABOPE 
           nTabCnd:= CUP->TABCND 
        ENDIF 
 
        OPE->( DBSetOrder( 1 ) ) 
        CND->( DBSetOrder( 1 ) ) 
        IF OPE->( DBSeek( nTabOpe ) ) 
           IF CND->( DBSeek( IF( nTabCnd > 0, nTabCnd, OPE->TABCND ) ) ) 
              @ 12,52 Say "Multa....:" + Tran( Multa( VLR___, VENC__, DTQT__, CND->TOLERA, CND->MULTA_ ), "@E 999,999,999.99" ) 
              nMulta:= Multa( VLR___, VENC__, DTQT__, CND->TOLERA, CND->MULTA_ ) 
           ELSE 
              @ 12,52 Say "Multa....: F.PAGTO  =" + Str( nTabCnd, 3, 0 ) 
           ENDIF 
        ELSE 
           @ 12,52 Say    "Multa....: OPERACAO =" + Str( nTabOpe, 3, 0 ) 
        ENDIF 
     ELSE 
         @ 12,52 Say      "Multa....: //////////// " 
     ENDIF 
     @ 13,52 Say "J.s/Valor:" + Tran( JurosSimples( VLR___, VENC__, DTQT__ ), "@E 999,999,999.99" ) 
     @ 14,52 Say "Vlr+Juros:" + Tran( VLR___ + JurosSimples( VLR___, VENC__, DTQT__ ), "@E 999,999,999.99" ) 
     @ 15,52 Say "V+M+A-D+J:" + Tran( VLR___ + nMulta + JUROS_ - VLRDES + JurosSimples( ( VLR___ + JUROS_ ) - VLRDES, VENC__, DTQT__ ), "@E 999,999,999.99" ) 
  ELSE 
     @ 12,52 Say "Multa....:" + Tran(      0, "@E 999,999,999.99" ) 
     @ 13,52 Say "J.s/Valor:" + Tran(      0, "@E 999,999,999.99" ) 
     @ 14,52 Say "Vlr+Juros:" + Tran( VLR___, "@E 999,999,999.99" ) 
     @ 15,52 Say "V+M+A-D+J:" + Tran(      0, "@E 999,999,999.99" ) 
  ENDIF 
  SetColor( cCor ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiReceber 
� Finalidade  � Inclusao de Duplicatas a Receber 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function IncluiReceber( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 4 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo( "INCLUSAO DE CONTAS A RECEBER" ) 
  SetColor( _COR_GET_BOX ) 
  Scroll( 02, 02, 15, 77 ) 
 
  // Box p/ Opcoes 
  @ 01,02 Say "������������������������������������������������" 
  @ 02,02 Say " SELECIONE A OPCAO DESEJADA                     " 
  @ 03,02 Say "������������������������������������������������" 
  @ 04,02 Say "�                                              �" 
  @ 05,02 Say "�                                              �" 
  @ 06,02 Say "�                                              �" 
  @ 07,02 Say "�                                              �" 
  @ 08,02 Say "�                                              �" 
  @ 09,02 Say "�                                              �" 
  @ 10,02 Say "������������������������������������������������" 
 
  // Opcoes 
  @ 04,03 Prompt " 1 Relacionadas Com Notas Fiscais           " 
  @ 05,03 Prompt " 2 Relacionadas Com Cupons                  " 
  @ 06,03 Prompt " 3 Outras Receitas (LANCAMENTO MANUAL)      " 
  @ 07,03 Prompt " 4 Outras Receitas (MULTIPLO)               " 
  @ 08,03 Say    "���������������������������������������������" 
  @ 09,03 Prompt " 5 Unificacao de Titulos - Quitacao         " 
  Menu To nOpcao 
 
  IF !LastKey() == K_ESC 
     IF nOpcao == 1 
        IncRecDuplicata( oTab ) 
     ELSEIF nOpcao == 2 
        Aviso( "Impossivel a inclusao de contas para cupons!" ) 
        Pausa() 
     ELSEIF nOpcao == 3 
        IncRecManual( oTab ) 
     ELSEIF nOpcao == 4 
        IncMulti( oTab ) 
     ELSEIF nOpcao == 5 
        BaixaMulti( oTab ) 
     ENDIF 
  ENDIF 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncRecDuplicata 
� Finalidade  � Inclusao de Contas a Receber Duplicatas 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function IncRecDuplicata( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local nOpcao:= 3, cTipo__ 
Local nClient:= 0, nCodLan:= 0, nValor_:= 0, nNVezes:= 0, oTabNew 
Local dDatabase:= CTOD( "  /  /  " ) 
Local aLancamentos:= {}, nRow:= 1 
Local cLetra:= "A" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo( "INCLUSAO DE CONTAS A RECEBER - [NOTA FISCAL        ]" ) 
  WHILE .T. 
    DispBegin() 
    SetColor( _COR_GET_EDICAO ) 
    Scroll( 01, 01, 14, 78 ) 
    MostraStr() 
    DispEnd() 
    nCodNf_:= 0 
    nClient:= CLIENT 
    cDescri:= CDESCR 
    cDesConta:= Space( 30 ) 
    SetCursor( 1 ) 
    Set( _SET_DELIMITERS, .F. ) 
    @ 03,02 Say "Nota Fiscal...: [         ]    " 
    @ 03,19 Get nCodNf_ Pict "@R 999999999" Valid PesqNFiscal( @nCodNf_, @nClient ) 
    @ 04,19 Get nClient Pict "@R 999999" valid nClient == 0 .OR. PesqCliente( @nClient, @cDescri ) 
    @ 04,28 Get cDescri 
    READ 
    IF LastKey() == K_ESC 
       EXIT 
    ELSE 
       DBSelectAr( _COD_DUPAUX ) 
       DBSetOrder( 1 ) 
       IF DBSeek( nCodNf_ ) 
          lExiste:= .F. 
          WHILE CODNF_ == nCodNf_ 
              IF CODNF_ == nCodNf_ .AND. TIPO__ == "  " 
                 lExiste:= .T. 
                 WHILE CODNF_ == nCodNf_ 
                    cLetra:= CHR( ASC( LETRA_ ) + 1 ) 
                    DBSkip() 
                 ENDDO 
                 EXIT 
              ELSE 
                 lExiste:= .F. 
              ENDIF 
              DBSkip() 
          ENDDO 
          IF lExiste 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             Aviso( "Esta nota fiscal j� possui movimento de duplicata!" ) 
             Pausa() 
             ScreenRest( cTelaRes ) 
          ENDIF 
       ENDIF 
 
       /* Limpando Variaveis p/ lancamento */ 
       IF !NF_->NUMERO == nCodNf_ 
          NF_->( DBSeek( nCodNf_ ) ) 
       ENDIF 
       cTipo__:= "  " 
       nValor_:= 0 
       dDataEm:= NF_->DATAEM 
       nVlr___:= 0 
       nJuros_:= 0 
       nVlrDes:= 0 
       nPraz__:= 0 
       dVenc__:= CTOD( "  /  /  " ) 
       dQuit__:= CTOD( "  /  /  " ) 
       nBanc__:= 0 
       cCheq__:= Space( 15 ) 
       cObs___:= Space( 30 ) 
       cSitu__:= "0" 
       nCodigo:= 0 
       nFunc__:= nGCodUser 
       cTipo__:= "  " 
       nTotal:=  NF_->VLRTOT 
       nVlrICM:= NF_->VLRICM 
       nVlrIPI:= NF_->VLRIPI 
       nVlrISS:= NF_->ISSQNV 
       nLocal_:= 0 
       Set( _SET_DELIMITERS, .T. ) 
       @ 06,02 Say "Banco.........:" Get nBanc__ Pict "999" Valid PesqBco( @nBanc__ ) 
       @ 07,02 Say "Emissao.......:" Get dDataEm 
       @ 08,02 Say "Prazo em Dias.:" Get nPraz__ Pict "999" Valid Vencimento( nPraz__, dDataEm, @dVenc__ ) 
       @ 09,02 Say "Vencimento....:" Get dVenc__ Valid VerData( @dVenc__ ) 
       @ 10,02 Say "Quitacao......:" Get dQuit__ 
       @ 11,02 Say "Valor.........:" Get nValor_ Pict "@E 999,999,999.99" 
       @ 12,02 Say "Acrescimos....:" Get nJuros_ Pict "@E 999,999,999.99" 
       @ 13,02 Say "Descontos.....:" Get nVlrDes Pict "@E 999,999,999.99" 
       @ 14,02 Say "Observacoes...:" Get cObs___ 
       @ 15,02 Say "Localizacao...:" Get nLocal_ Pict "999" Valid PesqBco( @nLocal_ ) 
       READ 
       IF !LastKey() == K_ESC 
          Set( _SET_DELIMITERS, .F. ) 
          VpBox( 06, 45, 09, 77, "DIVERSOS", _COR_GET_BOX, .F., .F. ) 
          SetColor( _COR_GET_EDICAO ) 
          @ 07,46 Say "Nota Fiscal...: " + Tran( nCODNF_, "999999999" ) 
          @ 08,46 Say "Cheque........:" Get cCHEQ__ 
          READ 
          Set( _SET_DELIMITERS, .T. ) 
          SetColor( _COR_BROWSE ) 
          DBAppend() 
          IF netrlock() 
             Replace CLIENT With nClient,; 
                     CDESCR With cDescri,; 
                     CODNF_ With nCodNf_,; 
                     DUPL__ With val(Str(nCodNf_,9)+Strzero(Month(dVenc__),2)),; 
                     CODIGO With nCodigo,; 
                     DATAEM With dDataEm,; 
                     TIPO__ With cTipo__,; 
                     CODIGO With nCodigo,; 
                     CODNF_ With nCodNf_,; 
                     VLR___ With nValor_,; 
                     JUROS_ With nJuros_,; 
                     VLRDES With nVlrDes,; 
                     CLIENT With nClient,; 
                     CDESCR With cDescri,; 
                     PERC__ With 0,; 
                     PRAZ__ With nPraz__,; 
                     VENC__ With dVenc__,; 
                     QUIT__ With IF( !EMPTY( dQuit__ ), "S", " " ),; 
                     DTQT__ With dQuit__,; 
                     BANC__ With nBanc__,; 
                     OBS___ With cObs___,; 
                     LETRA_ With cLetra,; 
                     CHEQ__ With cCheq__,; 
                     VLRICM With nVlrIcm,; 
                     VLRIPI With nVlrIpi,; 
                     VLRISS With nVlrIss,; 
                     LOCAL_ With nLocal_ 
             LancaCliente( nClient, 0, nValor_ ) 
             IF !Empty( dQuit__ ) 
                 /* Se foi preenchida a data de quitacao da duplicata 
                    o sistema lanca a baixa automaticamente */ 
                 BaixaReceber( oTab, .T. ) 
             ENDIF 
          ENDIF 
       ENDIF 
    ENDIF 
  ENDDO 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � AltRecDuplicata 
� Finalidade  � Alteracao de Contas a Receber Duplicatas 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function AltRecDuplicata( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local nOpcao:= 3, cTipo__ 
Local nClient:= 0, nCodLan:= 0, nValor_:= 0, nNVezes:= 0, oTabNew 
Local dDatabase:= CTOD( "  /  /  " ) 
Local aLancamentos:= {}, nRow:= 1 
Local lQuitada:= .F. 
Local cLetra_ 
  DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo( "ALTERACAO DE CONTAS A RECEBER - [NOTA FISCAL        ]" ) 
  SetColor( _COR_GET_EDICAO ) 
  MostraStr() 
  MostraDados() 
  DispEnd() 
  nCodNf_:= CODNF_ 
  nClient:= CLIENT 
  cDescri:= CDESCR 
  cDesConta:= Space( 30 ) 
  SetCursor( 1 ) 
  Set( _SET_DELIMITERS, .F. ) 
  @ 03,19 Get nCodNf_ Pict "@R 999999999" Valid PesqNFiscal( @nCodNf_, @nClient ) 
  @ 04,19 Get nClient Pict "@R 999999" valid nClient == 0 .OR. PesqCliente( @nClient, @cDescri ) 
  @ 04,28 Get cDescri 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     oTab:RefreshAll() 
     WHILE !oTab:Stabilize() 
     ENDDO 
     Return Nil 
  ELSE 
     /* Limpando variaveis p/ lancamento */ 
     IF !NF_->NUMERO == nCodNf_ 
        IF NF_->( DBSeek( nCodNf_ ) ) 
           dDataEm:= NF_->DATAEM 
        ELSE
           dDataEm:= DATAEM
        ENDIF
     ENDIF 
     cLetra_:= LETRA_ 
     cTipo__:= TIPO__ 
     nValor_:= VLR___ 
     nVlr___:= VLR___ 
     nJuros_:= JUROS_ 
     nVlrDes:= VLRDES 
     nPraz__:= PRAZ__ 
     dVenc__:= VENC__ 
     dQuit__:= DTQT__ 
     nBanc__:= BANC__ 
     cCheq__:= CHEQ__ 
     cObs___:= OBS___ 
     cSitu__:= SITU__ 
     nCodigo:= CODIGO 
     cTipo__:= "  " 
     nTotal:=  NF_->VLRTOT 
     nVlrICM:= VLRICM 
     nVlrIPI:= VLRIPI 
     nVlrISS:= VLRISS 
     nLocal_:= LOCAL_ 
     nValorInicial:= VLR___ 
     lQuitada:= IF( EMPTY( dQuit__ ), .F., .T. ) 
     Set( _SET_DELIMITERS, .T. ) 
     @ 06,02 Say "Banco.........:" Get nBanc__ Pict "999" Valid PesqBco( @nBanc__ ) 
     @ 07,02 Say "Emissao.......:" Get dDataEm 
     @ 08,02 Say "Prazo em Dias.:" Get nPraz__ Pict "999" Valid Vencimento( nPraz__, dDataEm, @dVenc__ ) 
     @ 09,02 Say "Vencimento....:" Get dVenc__ Valid VerData( @dVenc__ ) 
     @ 10,02 Say "Quitacao......:" Get dQuit__ 
     @ 11,02 Say "Valor.........:" Get nValor_ Pict "@E 999,999,999.99" 
     @ 12,02 Say "Acrescimos....:" Get nJuros_ Pict "@E 999,999,999.99" 
     @ 13,02 Say "Descontos.....:" Get nVlrDes Pict "@E 999,999,999.99" 
     @ 14,02 Say "Observacoes...:" Get cObs___ 
     @ 15,02 Say "Localizacao...:" Get nLocal_ Pict "999" Valid PesqBco( @nLocal_ ) 
     READ 
     IF !LastKey() == K_ESC 
        Set( _SET_DELIMITERS, .F. ) 
        VpBox( 06, 45, 09, 77, "DIVERSOS", _COR_GET_BOX, .F., .F. ) 
        SetColor( _COR_GET_EDICAO ) 
        @ 07,46 Say "Nota Fiscal...: " + Tran( nCODNF_, "999999999" ) 
        @ 08,46 Say "Cheque........:" Get cCHEQ__ 
        READ 
        Set( _SET_DELIMITERS, .T. ) 
        SetColor( _COR_BROWSE ) 
        IF netrlock() 
           Replace CLIENT With nClient,; 
                   CDESCR With cDescri,; 
                   CODNF_ With nCodNf_,; 
                   CODIGO With nCodigo,; 
                   DATAEM With dDataEm,; 
                   TIPO__ With cTipo__,; 
                   CODIGO With nCodigo,; 
                   CODNF_ With nCodNf_,; 
                   VLR___ With nValor_,; 
                   JUROS_ With nJuros_,; 
                   VLRDES With nVlrDes,; 
                   CLIENT With nClient,; 
                   CDESCR With cDescri,; 
                   PERC__ With 0,; 
                   PRAZ__ With nPraz__,; 
                   VENC__ With dVenc__,; 
                   QUIT__ With IF( !EMPTY( dQuit__ ), "S", " " ),; 
                   DTQT__ With dQuit__,; 
                   BANC__ With nBanc__,; 
                   OBS___ With cObs___,; 
                   LETRA_ With cLetra_,; 
                   CHEQ__ With cCheq__,; 
                   VLRICM With nVlrIcm,; 
                   VLRIPI With nVlrIpi,; 
                   VLRISS With nVlrIss,; 
                   LOCAL_ With nLocal_ 
        ENDIF 
 
        /* Se foi modificado o valor */ 
        IF !nValorInicial == VLR___ 
           LancaCliente( CLIENT, nValorInicial, 0 ) 
           LancaCliente( CLIENT, 0, VLR___ ) 
        ENDIF 
 
        IF !Empty( dQuit__ ) .AND. !lQuitada 
           /* Se nao estava quitada e foi preenchida a data 
              de quitacao da duplicata o sistema lanca a baixa 
              automaticamente */ 
           BaixaReceber( oTab, .T. ) 
        ENDIF 
     ENDIF 
  ENDIF 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � BAIXARECEBER 
� Finalidade  � Baixa de Contas a Receber 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function BaixaReceber( oTab, lAutomatico, dData ) 
  Local GETLIST:={} 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nVlrAut:= 0 
  Local nClient:= Client, nBANCO_:= Banc__, dVENCIM:= Venc__,; 
        nVALOR_:= Vlr___, cOBSERV:= Obs___, dDATAPG:= DTQT__,; 
        dDATAEM:= DATAEM, nJuros_:= JUROS_, nVlrDes:= VLRDES,; 
        cCheque:= CHEQ__, nNFISC_:= CODNF_, nVLRIPI:= VLRIPI, nVLRICM:= VLRICM,; 
        nLocal:=  LOCAL_ 
  Local nCodigo:= Codigo, cDOC___:= StrZero( CODNF_, 9, 0 ) + LETRA_ 
  Local dDataPagamento:= DTQT__ 
  Local nBancoConta:= -1, cBancoDescri:= "<< SEM INFORMACAO >>",; 
        nBancoSaldo:= 0 
 
  IF lAutomatico == Nil 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     UserModulo("QUITACAO DE CONTAS A RECEBER") 
     Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ESC]Retorna [ENTER]Confirma") 
  ENDIF 
 
  IF NFNULA == "*" 
     Aviso( "Esta duplicata esta anulada! Impossivel Quitar/Estornar." ) 
     Pausa() 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  IF !EMPTY( dDataPg ) .AND. lAutomatico == Nil 
     IF Confirma( 0, 0, "Confirma o estorno desta Quitacao?", " ", "N" ) 
        IF SWSet( _PDV_CAIXACENTRAL ) 
           cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
           nBancoConta:= LOCAL_ 
           lSaida:= .F. 
           WHILE !lSaida 
              PesqBco( @nBancoConta ) 
              IF LastKey() == K_ESC 
                 lSaida:= .T. 
                 SetColor( cCor ) 
                 SetCursor( nCursor ) 
                 ScreenRest( cTela ) 
                 Return Nil 
              ENDIF 
              cBancoDescri:= BAN->DESCRI 
              nBancoSaldo:=  BAN->SALDO_ 
              cHistorico:= "Lan:" + StrZero( nCodigo, 6, 0 ) + " D:" + cDoc___ + " C:" + StrZero( nClient, 4, 0 ) 
 
              /* Lancamento de Saida de uma Conta de Transferencia p/ estorno de quitacao */ 
              LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ESTORNO DE RECEBIMENTO", cHistorico, nValor_, 0 ) 
              LancaSaldos( nBancoConta, cBancoDescri, "T", nValor_, 0 ) 
 
              IF !( nJuros_ == 0 ) 
                 /* Lancamento de Juros */ 
                 LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ESTORNO DE JUROS RECEBIDOS", cHistorico, nJuros_, 0 ) 
                 LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nJuros_, 0 ) 
              ENDIF 
 
              IF !( nVlrDes == 0 ) 
                 /* Lancamento de Descontos */ 
                 LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ESTORNO DE DESCONTO CONCEDIDO", cHistorico, 0, nVlrDes ) 
                 LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", 0, nVlrDes ) 
              ENDIF 
 
 
              lSaida:= .T. 
              DBSelectAr( _COD_DUPAUX ) 
           ENDDO 
        ELSE 
           DBSelectAR( _COD_CAIXA ) 
           DBAppend() 
           Replace FILIAL With 0,; 
                   DATAMV With DATE(),; 
                   VENDE_ With 1,; 
                   ENTSAI With "-",; 
                   MOTIVO With 7,; 
                   HISTOR With "ESTORNO DE QUITACAO / DUP:" + cDoc___ + " C:" + StrZero( nClient, 4, 0 ),; 
                   VALOR_ With DPA->VLR___,; 
                   HORAMV With TIME(),; 
                   CDUSER With nGCodUser 
           DBSelectAr( _COD_DUPAUX ) 
        ENDIF 
        IF netrlock(5) 
           repl DTQT__ with CTOD( "  /  /  " ),; 
                QUIT__ with If(dDATAPG<>ctod("  /  /  "),"S","N"),; 
                CHEQ__ with cCHEQUE,; 
                OBS___ With cOBSERV 
        ENDIF 
        LancaCliente( CLIENT, 0, DPA->VLR___ ) 
     ENDIF 
  ELSE 
     Set( _SET_DELIMITERS, .T. ) 
     SetColor(COR[16]+","+COR[18]+",,,"+COR[17]) 
     SetCursor( 1 ) 
     IF Empty( dDataPg ) 
        dDataPg:= DATE() 
     ENDIF 
     IF lAutomatico == Nil 
        @ 10,02 Say "Quitacao......:" Get dDATAPG when; 
          Mensagem("Digite a data em que foi recebido o documento.") 
        @ 11,02 Say "Valor.........:" Get nVALOR_ pict "@E 999,999,999.99" when; 
          Mensagem("Digite o valor que foi recebido.") Valid TestaValor( @nValor_, @nJuros_, @nVlrDes, @nLocal, @dDataPg, , @nVlrAut ) 
        @ 12,02 Say "Acrescimos....:" Get nJUROS_ pict "@E 999,999,999.99" when; 
          Mensagem("Digite o valor dos juros Recebidos") 
        @ 13,02 Say "Descontos.....:" Get nVlrDes Pict "@E 999,999,999.99" when; 
          Mensagem( "Digite o valor de descontos concedidos." ) 
        @ 14,02 Say "Observacoes...:" Get cOBSERV when; 
          Mensagem("Digite qualquer observacao que se refira ao documento.") 
        @ 15,02 Say "Localizacao...:" Get nLocal Pict "999" 
        Read 
        IF !LastKey() == K_ESC 
           Set(_SET_DELIMITERS,.F.) 
           @ 08,46 Say "Cheque........:" Get cCHEQUE 
           Read 
        ENDIF 
     ENDIF 
     Set(_SET_DELIMITERS,.T.) 
     IF !LastKey() == K_ESC 
        IF !dDataPg == CTOD( "  /  /  " ) 
           IF SWSet( _PDV_CAIXACENTRAL ) 
              cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
              lSaida:= .F. 
              nBancoConta:= nLocal 
              WHILE !lSaida 
                 PesqBco( @nBancoConta ) 
                 IF LastKey() == K_ESC 
                    lSaida:= .T. 
                    SetColor( cCor ) 
                    SetCursor( nCursor ) 
                    ScreenRest( cTela ) 
                    Return Nil 
                 ENDIF 
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
 
 
                 lSaida:= .T. 
                 DBSelectAr( _COD_DUPAUX ) 
 
              ENDDO 
           ELSE 
              DBSelectAR( _COD_CAIXA ) 
              DBAppend() 
              Replace FILIAL With 0,; 
                      DATAMV With DATE(),; 
                      VENDE_ With 1,; 
                      ENTSAI With "+",; 
                      MOTIVO With 7,; 
                      HISTOR With "QUITACAO / DUP:" + cDoc___ + " C:" + StrZero( nClient, 4, 0 ),; 
                      VALOR_ With DPA->VLR___,; 
                      HORAMV With TIME(),; 
                      CDUSER With nGCodUser 
              DBSelectAr( _COD_DUPAUX ) 
           ENDIF 
        ENDIF 
        IF !dData==Nil 
           IF VALTYPE( dData )=="D" 
              dDataPg:= dData 
           ENDIF 
        ENDIF 
        IF netrlock(5) 
           repl VLR___ with nVALOR_, DTQT__ with dDATAPG,; 
                OBS___ with cOBSERV,; 
                JUROS_ with nJUROS_,; 
                VLRDES With nVlrDes,; 
                QUIT__ with If( dDATAPG<>ctod("  /  /  "),"S","N"),; 
                CHEQ__ with cCHEQUE,; 
                LOCAL_ With nLocal 
 
           IF TIPO__ == "03" 
              IF SWAlerta( " << AUTENTICACAO MECANICA >> ;Deseja realizar autenticacao de documento?", { "Sim", "Nao" } )==1 
 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Mensagem( "Autentica��o mec�nica - Pressione <ENTER> " ) 
                 // gelson Mensagem( "Autentica��o mec�nica - " + Tran( nVlrAut, "@E 9,999,999.999" ) + Tran( nJuros_, "@E 99,999.99" )  ) 
                 Pausa() 
 
                 Aviso( "Carregando sistema de autenticacao, aguarde..."  ) 
 
                 nJuros:= nJuros_ 
                 nValor:= nVlrAut 
 
                 /* Abre Comprovante Nao Fiscal Nao vinculado */ 
                 // Lista de Parametros: 
                 // A..P 
                 // 3=Acrescimo em valor 
                 // Juros 
                 // Valor 
                 // Descricao (At� 40 caracteres) 
                 /* gelson 
                 cComando:= Chr( 27 ) + Chr( 217 ) + "A" + "3" +; 
                    IF( nJuros==Nil, "000000000000" + StrZero( nValor * 100, 12, 0 ),; 
                                        StrZero( nJuros * 100, 12, 00 ) +; 
                                        StrZero( nValor * 100, 12, 00 ) ) +; 
                                        LEFT( Alltrim( "Doc: " + StrZero( CODNF_, 9, 0 ) + "-"+LETRA_ + " " + chr(13) + chr(10) + "Nome: " + ALLTRIM( STR( DPA->CLIENT, 6, 0 ) ) + " " +  DPA->CDESCR ), 40 ) + Chr( 255 ) 
                 ComandoSend( Nil, cComando ) 
                 Inkey( 0.5 ) 
                 gelson */ 
                ///// Valmor: 27+Y Transferida Autenticacao que estava aqui ---> 
 
                 /* Imprime pagamento */ 
                 /* gelson 
                 cComando:= Chr( 27 ) + Chr( 242 ) + ForPagPagamento + ; 
                      StrZero( ( nValor ) * 100, 12, 0 ) + "" + Chr( 255 )   // gelson 
                 ComandoSend( Nil, cComando ) 
                 Inkey( 0.5 ) 
                 gelson */ 
 
                 /* aciona a autenticacao mecanica na impressora */ 
                 /* gelson 
                 cComando:=     Chr( 27 ) + "Y*[AUT]*" + Chr( 13 ) + Chr( 10 ) 
                 IF !( nJuros==Nil ) 
                     cComando:= Chr( 27 ) + "Y*[AUT]*" + Chr( 13 ) + Chr( 10 ) 
                 ENDIF 
                 gelson */ 
                 //// 
                 //// Colocar juros na autenticacao mecanica 
                 //// + If( nJuros==Nil, "          ", " Juros: " + AllTrim( Str( nJuros, 12, 2 ) ) ) 
                 //// Valmor 
                 //// 
                 /* gelson 
                 ComandoSend( Nil, cComando ) 
                 Inkey( 0.5 ) 
                 gelson */ 
                 Relatorio( "Aut.rep" )     // gelson 
                 ScreenRest( cTelaRes ) 
              ENDIF 
           ENDIF 
        ENDIF 
        LancaCliente( CLIENT, DPA->VLR___, 0 ) 
     ENDIF 
  ENDIF 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  SetColor(cCOR) 
  IF oTab <> Nil 
     oTab:RefreshAll() 
     WHILE !oTab:Stabilize() 
     ENDDO 
  ENDIF 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � IncRecManual 
� Finalidade  � Inclusao de Contas a Receber MANUAL 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function IncRecManual( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 3, cTipo__ 
Local nClient:= 0, nCodLan:= 0, nValor_:= 0, nNVezes:= 0, oTabNew 
Local dDataBase:= DATE() 
Local aLancamentos:= {}, nRow:= 1 
  cTipo__:= "02" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo( "INCLUSAO DE CONTAS A RECEBER - [LANCAMENTO MANUAL  ]" ) 
  WHILE .T. 
    DispBegin() 
    SetColor( _COR_GET_EDICAO ) 
    Scroll( 01, 01, 14, 78 ) 
    MostraStr() 
    DispEnd() 
    nConta_:= 0 
    nClient:= CLIENT 
    cDescri:= CDESCR 
    cLetra:= "#" 
    cDesConta:= Space( 30 ) 
    SetCursor( 1 ) 
    Set( _SET_DELIMITERS, .F. ) 
    @ 03,02 Say "Conta.........: [   ]          " 
    @ 03,19 Get nConta_ Pict "@R 9999" Valid PesqConta( @nConta_, cDesConta ) 
    @ 04,19 Get nClient Pict "@R 999999" valid nClient == 0 .OR. PesqCliente( @nClient, @cDescri ) 
    @ 04,28 Get cDescri 
    READ 
    Set( _SET_DELIMITERS, .T. ) 
    IF !LastKey() == K_ESC 
       DPA->( DBSetOrder( 3 ) ) 
       DPA->( DBGoBottom() ) 
       nCodigo:= DPA->CODIGO + 1 
       nCodNf_:= nConta_ 
       nValor_:= 0 
       dDataEm:= DATE() 
       nVlr___:= 0 
       nJuros_:= 0 
       nVlrDes:= 0 
       nPraz__:= 0 
       dVenc__:= CTOD( "  /  /  " ) 
       dQuit__:= CTOD( "  /  /  " ) 
       nBanc__:= 0 
       cCheq__:= Space( 15 ) 
       cObs___:= Space( 30 ) 
       cSitu__:= "0" 
       nFunc__:= nGCodUser 
       nTotal:=  0 
       nVlrICM:= 0 
       nVlrIPI:= 0 
       nVlrISS:= 0 
       nLocal_:= 0 
       Set( _SET_DELIMITERS, .T. ) 
       @ 06,02 Say "Banco.........:" Get nBanc__ Pict "999" Valid PesqBco( @nBanc__ ) 
       @ 07,02 Say "Emissao.......:" Get dDataEm 
       @ 08,02 Say "Prazo em Dias.:" Get nPraz__ Pict "999"  Valid Vencimento( nPraz__, dDataEm, @dVenc__ ) 
       @ 09,02 Say "Vencimento....:" Get dVenc__ Valid VerData( @dVenc__ ) 
       @ 10,02 Say "Quitacao......:" Get dQuit__ 
       @ 11,02 Say "Valor.........:" Get nValor_ Pict "@E 999,999,999.99" 
       @ 12,02 Say "Acrescimos....:" Get nJuros_ Pict "@E 999,999,999.99" 
       @ 13,02 Say "Descontos.....:" Get nVlrDes Pict "@E 999,999,999.99" 
       @ 14,02 Say "Observacoes...:" Get cObs___ 
       @ 15,02 Say "Localizacao...:" Get nLocal_ Pict "999" Valid PesqBco( @nLocal_ ) 
       READ 
       IF !LastKey() == K_ESC 
          Set( _SET_DELIMITERS, .F. ) 
          VpBox( 06, 45, 09, 77, "DIVERSOS", _COR_GET_BOX, .F., .F. ) 
          SetColor( _COR_GET_EDICAO ) 
          @ 07,46 Say "Conta.........: " + Tran( nCODNF_, "999999999" ) 
          @ 08,46 Say "Cheque........:" Get cCHEQ__ 
          READ 
          Set( _SET_DELIMITERS, .T. ) 
          SetColor( _COR_BROWSE ) 
          DBAppend() 
          IF netrlock() 
             Replace CLIENT With nClient,; 
                     CDESCR With cDescri,; 
                     CODNF_ With nCodNf_,; 
                     CODIGO With nCodigo,; 
                     DATAEM With dDataEm,; 
                     TIPO__ With cTipo__,; 
                     CODIGO With nCodigo,; 
                     CODNF_ With nCodNf_,; 
                     VLR___ With nValor_,; 
                     CLIENT With nClient,; 
                     CDESCR With cDescri,; 
                     PERC__ With 0,; 
                     PRAZ__ With nPraz__,; 
                     VENC__ With dVenc__,; 
                     QUIT__ With IF( !EMPTY( dQuit__ ), "S", " " ),; 
                     DTQT__ With dQuit__,; 
                     BANC__ With nBanc__,; 
                     OBS___ With cObs___,; 
                     LETRA_ With cLetra,; 
                     CHEQ__ With cCheq__,; 
                     VLRICM With nVlrIcm,; 
                     VLRIPI With nVlrIpi,; 
                     VLRISS With nVlrIss,; 
                     LOCAL_ With nLocal_ 
 
             LancaCliente( CLIENT, 0, VLR___ ) 
             IF !Empty( dQuit__ ) 
                 /* Se foi preenchida a data de quitacao da duplicata 
                    o sistema lanca a baixa automaticamente */ 
                 BaixaReceber( oTab, .T. ) 
             ENDIF 
          ENDIF 
       ENDIF 
    ELSE 
       EXIT 
    ENDIF 
  ENDDO 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � IncMulti 
� Finalidade  � Inclusao de Contas a Receber MULTI-LANCAMENTOS 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function IncMulti() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select() 
Local aParcelas:= {} 
Local nParcel:= 1 
Local aTabela:= {{ 0, 0, " ", CTOD( "  /  /  " ), Space( 30 ), 0.00, Space( 12 ), 0, CTOD( "  /  /  " ), 0 }} 
Local GetList:= {} 
Local nOpcao:= 3, cTipo__ 
Local nClient:= 0, nCodLan:= 0, nValor_:= 0, nNVezes:= 0, oTabNew 
Local dDataBase:= DATE() 
Local aLancamentos:= {}, nRow:= 1 
Local lDelimiters:= Set( _SET_DELIMITERS ) 
Local nPerJur:= SWSet( _GER_JUROSAOMES ), nDiasMes:= SWSet( _GER_DIASNOMES ) 
Local nTotal:= 0 
 
    cTipo__:= "02" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    UserModulo( "INCLUSAO DE CONTAS A RECEBER - [ MULTI-LANCAMENTOS ]" ) 
    DispBegin() 
    SetColor( _COR_GET_EDICAO ) 
    Scroll( 01, 01, 14, 78 ) 
    MostraStr() 
    DispEnd() 
    nConta_:= 0 
    CLI->( DBSetOrder( 1 ) ) 
    CLI->( DBSeek( DPA->CLIENT ) ) 
    nClient:= CLIENT 
    cDescri:= CDESCR 
    cLetra:= "#" 
    cDesConta:= Space( 30 ) 
    SetCursor( 1 ) 
    VPBox( 00, 10, 06, 76, " INFORMACOES DO CLIENTE ", _COR_GET_EDICAO ) 
    WHILE .T. 
       @ 01,11 Say " Clientes: [INS]Novo [ENTER]Selecionar " 
       nTecla:= Inkey(0) 
       nCodCli:= 0 
       IF nTecla==K_INS 
          ClientesInclusao( nCodCli, Nil ) 
       ENDIF 
       nClient:= nCodCli 
       cDescri:= Space( LEN( CLI->DESCRI ) ) 
       PesqCliente( @nClient, @cDescri ) 
       IF LastKey()==K_ESC 
          ScreenRest( cTela ) 
          SetCursor( nCursor ) 
          SetColor( cCor ) 
          DBSelectAr( nArea ) 
          Return Nil 
       ELSEIF LastKey()==K_ENTER 
          EXIT 
       ENDIF 
    ENDDO 
    nValorP:= 0 
    nFormaP:= 0 
    dDataEm:= DATE() 
    @ 02,11 Say " Nome...........: [" + cDescri + "]" 
    @ 03,11 Say " Conta..........:" Get nConta_ Pict "@R 9999" Valid PesqConta( @nConta_, cDesConta ) 
    @ 04,11 Say " Valor..........:" Get nValorP Pict "@E 999,999,999.99" 
    @ 05,11 Say " Forma Pagamento:" Get nFormaP Pict "999" Valid BuscaCondicao( @nFormaP, nValorP ) 
    READ 
    IF LastKey()==K_ESC 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       ScreenRest( cTela ) 
       Set( _SET_DELIMITERS, lDelimiters ) 
       DBSelectAr( nArea ) 
       Return Nil 
    ENDIF 
    nVlrIni:= nValorP 
    IF nFormaP == 0 
       @ 05,28 Say " < CONDICAO ESPECIAL - CFE.NEGOCIACAO > " 
    ELSE 
       @ 05,28 Say CND->DESCRI 
    ENDIF 
 
    Keyboard Chr( K_INS ) 
    VPBox( 07, 10, 20, 76, " INCLUSAO MULTI-LANCAMENTOS / CFE CONDICOES DE PAGAMENTO ", _COR_BROW_BOX ) 
    SetColor( _COR_BROWSE ) 
    Ajuda( "["+_SETAS+"][PgUp][PgDn]Movimenta [*]Anula [TAB]Imprime_DOCs [CTRL+TAB]Imprime_DUP" ) 
    oTab:= TBrowsedb( 08, 11, 19, 75 ) 
    oTab:Addcolumn( tbColumnNew(, {|| Str( aTabela[ nRow ][ 1 ], 03, 00 ) + " " + ; 
                             StrZero( aTabela[ nRow ][ 2 ], 03, 00 ) + " " +; 
                                DTOC( aTabela[ nRow ][ 4 ] ) + " " + ; 
                                      aTabela[ nRow ][ 5 ] + " " + ; 
                                Tran( aTabela[ nRow ][ 6 ], "@E 999,999,999.99" ) } ) ) 
 
 
 
    oTab:GOTOPBLOCK :={|| nROW:=1} 
    oTab:GOBOTTOMBLOCK:={|| nROW:=len(aTabela)} 
    oTab:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aTabela,@nROW)} 
    oTab:AUTOLITE:=.F. 
    oTab:dehilite() 
    WHILE .T. 
 
       oTab:ColorRect( { oTab:ROWPOS, 1, oTab:ROWPOS, oTab:COLCOUNT }, { 2, 1 } ) 
       WHILE NextKey()==0 .AND.! oTab:Stabilize() 
       ENDDO 
 
       DispBegin() 
       DispEnd() 
 
       /* Aguarda o pressionamento de uma tecla */ 
       IF ( nTecla:= Inkey(0) ) == K_ESC 
          EXIT 
       ENDIF 
 
       DO CASE 
          CASE nTecla==K_UP         ;oTab:up() 
          CASE nTecla==K_LEFT       ;oTab:up() 
          CASE nTecla==K_RIGHT      ;oTab:down() 
          CASE nTecla==K_DOWN       ;oTab:down() 
          CASE nTecla==K_PGUP       ;oTab:pageup() 
          CASE nTecla==K_PGDN       ;oTab:pagedown() 
          CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
          CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
          CASE Acesso( nTecla ) 
          CASE nTecla==K_TAB 
               aParcelas:= 0 
               aParcelas:= {} 
               nPar:= 0 
               FOR nCt:= 1 TO Len( aTabela ) 
                   FOR nCt2:= 1 TO aTabela[ nCt ][ 1 ] 
                       AAdd( aParcelas, {         ++nPar,;                   // Posicao Parcela 
                             aTabela[ nCt ][ 2 ] * nCt2,;                    // Dias * Parcela 
                                                     " ",;                   // "" 
                      aTabela[ nCt ][ 11 ] + ( aTabela[ nCt ][ 2 ] * nCt2),;  // Vencimento + Dias 
                                         aTabela[ nCt ][ 5 ],;               // Observacoes 
                                         aTabela[ nCt ][ 6 ],;               // Valor Parcela 
                                       Space( 12 ),; 
                                         0,; 
                                     CTOD( "  /  /  " ),; 
                                     aTabela[ nCt ][ 10 ],; 
                                     aTabela[ nCt ][ 11 ] } )                // Emissao 
                   NEXT 
               NEXT 
               VisualFAberta( aParcelas, nValorP ) 
          CASE Chr( nTecla ) $ "gG" 
               nTotal:= 0 
               aParcelas:= 0 
               aParcelas:= {} 
               nPar:= 0 
               FOR nCt:= 1 TO Len( aTabela ) 
                   FOR nCt2:= 1 TO aTabela[ nCt ][ 1 ] 
                       AAdd( aParcelas, {         ++nPar,;                   // Posicao Parcela 
                             aTabela[ nCt ][ 2 ] * nCt2,;                    // Dias * Parcela 
                                                     " ",;                   // "" 
                   aTabela[ nCt ][ 11 ] + ( aTabela[ nCt ][ 2 ] * nCt2 ),;   // Vencimento + dias 
                                         aTabela[ nCt ][ 5 ],;               // Observacoes 
                                         aTabela[ nCt ][ 6 ],;               // Valor Parcela 
                                       Space( 12 ),;                         // Space-12 
                                       0,;                                   // 0 
                                     CTOD( "  /  /  " ),;                    // 
                                     aTabela[ nCt ][ 10 ],;                  // Data de Quitacao 
                                     aTabela[ nCt ][ 11 ] } )                  // Data de Emissao 
                       nTotal:= nTotal + aTabela[ nCt ][ 6 ] 
                   NEXT 
               NEXT 
               IF !( nTotal == nValorP ) 
                  cTelaRes:= ScreenSave( 0, 0,24,79 ) 
                  Aviso( "Valor de parcelas diferente do Informado! Diferenca: " + Alltrim( Tran( nValorP - nTotal, "@E 9,999,999.99" ) ) ) 
                  Pausa() 
                  ScreenRest( cTelaRes ) 
                  Loop 
               ELSE 
 
                  /* CONFIRMA ALTERACAO DE JUROS P/ VENCIMENTOS ENTRE 15/30 DIAS */ 
                  lConfirma:= .F. 
                  FOR nCt:= 1 TO Len( aParcelas ) 
                      /* Colocacao do ultimo elemento como Valor do Juros Futuros */ 
                      AAdd( aParcelas[ nCt ], JurosFuturos( aParcelas[ nCt ][ 6 ],; 
                              aParcelas[ nCt ][ 4 ],; 
                              aParcelas[ nCt ][ 11 ],;    && Emissao 
                              aParcelas[ nCt ][ 10 ] ) ) 
                     IF aParcelas[ nCt ][ 2 ] >= 15 .AND. aParcelas[ nCt ][ 2 ] <= 30 
                        lConfirma:= IF( lConfirma, .T., Confirma( 0, 0,; 
                               "Existem vencimentos entre 15 e 30 dias, deseja aplicar % direto?", "","S" ) ) 
                        IF lConfirma 
                           aParcelas[ nCt ][ Len( aParcelas[ nCt ] ) ]:= ; 
                              ( aParcelas[ nCt ][ 6 ] * aParcelas[ nCt ][ 10 ] ) / 100 
                        ENDIF 
                     ENDIF 
                  NEXT 
 
                  /* GRAVACAO DE PARAMETROS */ 
                  FOR nCt:= 1 TO Len( aParcelas ) 
                      SetColor( _COR_BROWSE ) 
                      DBSelectAr( _COD_DUPAUX ) 
                      DBSetOrder( 3 ) 
                      DBGoBottom() 
                      nCodigo:= CODIGO + 1 
                      DBAppend() 
                      IF netrlock() 
                         Repl CLIENT With nClient,; 
                              CDESCR With cDescri,; 
                              CODNF_ With nCodNf_,; 
                              CODIGO With nCodigo,; 
                              DATAEM With aParcelas[ nCt ][ 11 ],;    && Emissao 
                              TIPO__ With cTipo__,; 
                              CODIGO With nCodigo,; 
                              CODNF_ With nCodNf_,; 
                              VLR___ With aParcelas[ nCt ][ 6 ],; 
                              JUROS_ With aParcelas[ nCt ][ Len( aParcelas[ nCt ] ) ],; 
                              CLIENT With nClient,; 
                              CDESCR With cDescri,; 
                              PERC__ With 0,; 
                              PRAZ__ With aParcelas[ nCt ][ 2 ],; 
                              VENC__ With aParcelas[ nCt ][ 4 ],; 
                              QUIT__ With IF( !EMPTY( dQuit__ ), "S", " " ),; 
                              DTQT__ With dQuit__,; 
                              BANC__ With nBanc__,; 
                              OBS___ With cObs___,; 
                              LETRA_ With cLetra,; 
                              CHEQ__ With cCheq__,; 
                              VLRICM With nVlrIcm,; 
                              VLRIPI With nVlrIpi,; 
                              VLRISS With nVlrIss,; 
                              LOCAL_ With nLocal_ 
                         LancaCliente( CLIENT, 0, VLR___ ) 
                         IF !Empty( dQuit__ ) 
                             BaixaReceber( oTab, .T. ) 
                         ENDIF 
                      ENDIF 
                  NEXT 
               ENDIF 
               DBSelectAr( _COD_DUPAUX ) 
               DBLeOrdem() 
               EXIT 
          CASE nTecla==K_DEL 
               oTab:RefreshAll() 
               WHILE !oTab:Stabilize() 
               ENDDO 
               FOR nCt:= 1 TO Len( aParcelas ) 
                   ADel( aParcelas, nRow ) 
                   ADel( aTabela, nRow ) 
               NEXT 
               ASize( aParcelas, Len( aParcelas )-1 ) 
               ASize( aTabela, Len( aTabela )-1 ) 
               oTab:Up() 
               oTab:RefreshAll() 
               WHILE !oTab:Stabilize() 
               ENDDO 
 
          CASE nTecla==K_INS 
               IF !LastKey() == K_ESC 
                  nParcel:= 1 
                  nCodNf_:= nConta_ 
                  nTotalRes:= 0 
                  FOR nCt:= 1 TO Len( aTabela ) 
                      nTotalRes+= aTabela[ nCt ][ 1 ] * aTabela[ nCt ][ 6 ] 
                  NEXT 
                  IF nValorP > nTotalRes 
                     nValor_:= nValorP - nTotalRes 
                  ELSE 
                     nValor_:= 0 
                  ENDIF 
                  nVlr___:= 0 
                  nJuros_:= 0 
                  nVlrDes:= 0 
                  nPraz__:= 0 
                  dVenc__:= CTOD( "  /  /  " ) 
                  dQuit__:= CTOD( "  /  /  " ) 
                  nBanc__:= 0 
                  cCheq__:= Space( 15 ) 
                  cObs___:= Space( 30 ) 
                  cSitu__:= "0" 
                  nCodigo:= 0 
                  nFunc__:= nGCodUser 
                  nTotal:=  0 
                  nVlrICM:= 0 
                  nVlrIPI:= 0 
                  nVlrISS:= 0 
                  nLocal_:= 0 
                  Set( _SET_DELIMITERS, .T. ) 
                  cCorRes:= SetColor() 
                  nCursorRes:= SetCursor() 
                  cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                  VPBox( 05, 20, 14, 74, " INCLUSAO DE LANCAMENTOS ", _COR_GET_EDICAO ) 
                  SetColor( _COR_GET_EDICAO ) 
                  @ 06,22 Say "N�Parcelas....:" Get nParcel Pict "999" 
                  @ 07,22 Say "Valor.........:" Get nValor_ Pict "@E 999,999,999.99" 
                  @ 08,22 Say "% Juros ao Mes:" Get nPerJur Pict "@E 999.99" 
                  @ 09,22 Say "������������������������������������������" 
                  @ 10,22 Say "Data Base.....:" Get dDataEm Valid PulaCampo() 
                  @ 11,22 Say "Prazo em Dias.:" Get nPraz__ Pict "999" Valid Vencimento( nPraz__, dDataEm, @dVenc__ ) 
                  @ 12,22 Say "1�Vencimento..:" Get dVenc__ Valid VerDataVenc( dDataEm, @dVenc__, @nPraz__ ) 
                  READ 
                  IF !LastKey() == K_ESC 
                     nVlrIni:= nValorP - nValor_ 
                     nVlrIni:= IF( nVlrIni > 0, nVlrIni, 0 ) 
                     Set( _SET_DELIMITERS, .F. ) 
                     SetColor( _COR_GET_EDICAO ) 
                     Set( _SET_DELIMITERS, .T. ) 
                     AAdd( aTabela, { nParcel, nPraz__, " ", dVenc__, cObs___, nValor_, cCheq__, nLocal_, dQuit__, nPerJur, dDataEm } ) 
                  ENDIF 
                  SetColor( cCorRes ) 
                  SetCursor( nCursorRes ) 
                  ScreenRest( cTelaRes ) 
                  oTab:RefreshAll() 
                  WHILE !oTab:Stabilize() 
                  ENDDO 
               ENDIF 
          CASE nTecla==K_ENTER 
          CASE nTecla==K_DEL 
          OTHERWISE                ;tone(125); tone(300) 
       ENDCASE 
       oTab:refreshcurrent() 
       oTab:stabilize() 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  DBSelectAr( nArea ) 
  Set( _SET_DELIMITERS, lDelimiters ) 
 
 
 
 
 
#Define _TAB_TITULO          1 
#Define _TAB_LETRA           2 
#Define _TAB_VALOR           3 
#Define _TAB_OBS             4 
 
/***** 
�������������Ŀ 
� Funcao      � BaixaMulti 
� Finalidade  � Inclusao de Contas a Receber MULTI-LANCAMENTOS 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function BaixaMulti( oTb ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select() 
Local aParcelas:= {} 
Local nParcel:= 1 
Local aTabela:= {{ 0, " ", 0, Space( Len( DPA->OBS___ ) )  }} 
Local GetList:= {} 
Local nOpcao:= 3, cTipo__ 
Local nClient:= 0, nCodLan:= 0, nValor_:= 0, nNVezes:= 0, oTabNew 
Local dDataBase:= DATE() 
Local aLancamentos:= {}, nRow:= 1 
Local lDelimiters:= Set( _SET_DELIMITERS ) 
Local nPerJur:= SWSet( _GER_JUROSAOMES ), nDiasMes:= SWSet( _GER_DIASNOMES ) 
Local nTotal:= 0 
LOCAL lErro 
Local nNotaFiscal:= 0 
Local nLocalQuitar:= 801 
Local nLocalCheque:= 0 
Local nTotalValidacao:= 0 
Local cLetras 
Local cObservacao:= Space( Len( DPA->OBSERV ) ) 
Local cValores:=    Space( Len( DPA->OBSER1 ) ) 
 
    cTipo__:= "02" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    UserModulo( "BAIXA DE MULTIPLAS DUPLICATAS COM MULTIPLOS CHEQUES" ) 
    DispBegin() 
    SetColor( _COR_GET_EDICAO ) 
    Scroll( 01, 01, 14, 78 ) 
    MostraStr() 
    DispEnd() 
    nConta_:= 0 
    CLI->( DBSetOrder( 1 ) ) 
    CLI->( DBSeek( DPA->CLIENT ) ) 
    nClient:= CLIENT 
    cDescri:= CDESCR 
    cLetra:= "#" 
    cDesConta:= Space( 30 ) 
    SetCursor( 1 ) 
 
    VPBox( 00, 10, 07, 76, " INFORMACOES ", _COR_GET_EDICAO ) 
    SetColor( _COR_GET_EDICAO ) 
    @ 01,11 Say "Soma dos Titulos (Conferencia):" Get nTotalValidacao Pict "999999999.99" 
    @ 02,11 Say "Quitar Titulos na Localizacao.:" Get nLocalQuitar Pict "999" 
    @ 03,11 Say "Novo Titulo na Localizacao....:" Get nLocalCheque Pict "999" 
    READ 
    @ 04,11 Say "��������������������������������������������������������������" 
 
    VPBox( 08, 10, 20, 76, " INCLUSAO MULTI-LANCAMENTOS / CFE CONDICOES DE PAGAMENTO ", _COR_BROW_BOX ) 
    SetColor( _COR_BROWSE ) 
    Ajuda( "["+_SETAS+"][PgUp][PgDn]Movimenta [*]Anula [TAB]Imprime_DOCs [CTRL+TAB]Imprime_DUP" ) 
    oTab:= TBrowsedb( 09, 11, 19, 75 ) 
    oTab:Addcolumn( tbColumnNew(, {|| Str( aTabela[ nRow ][ _TAB_TITULO ], 09, 00 ) + aTabela[ nRow ][ _TAB_LETRA ] + " " + ; 
                                Tran( aTabela[ nRow ][ _TAB_VALOR ], "@E 999,999,999.99" )  + " " + ; 
                                      aTabela[ nRow ][ _TAB_OBS ]  } ) ) 
    oTab:GOTOPBLOCK :={|| nROW:=1} 
    oTab:GOBOTTOMBLOCK:={|| nROW:=len(aTabela)} 
    oTab:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aTabela,@nROW)} 
    oTab:AUTOLITE:=.F. 
    oTab:dehilite() 
 
    cLetras:= "ABCDEFGHIJKLMNOPQRSTUVXYZ#" 
    nItem:= 0 
    nCodCli:= -1 
    nItem:= 1 
    WHILE .T. 
       nCodNf_:= 0 
       cDoc___:= Space( 10 ) 
       cLetra_:= SubStr( cLetras, nItem, 1 ) 
       SetColor( _COR_GET_EDICAO ) 
       @ 05,11 Say "Nota Fiscal......:" Get nCodNf_ 
       @ 06,11 Say "Sequencia/Parcela:" Get cLetra_ 
       READ 
       nItem:= AT( cLetra_, cLetras ) + 1 
 
       SetColor( _COR_BROWSE ) 
       IF LastKey()==K_ESC 
          ScreenRest( cTela ) 
          SetCursor( nCursor ) 
          SetColor( cCor ) 
          DBSelectAr( nArea ) 
          Return Nil 
       ENDIF 
       nNotaFiscal:= nCodNF_ 
       lLocalizada:= .F. 
       IF nNotaFiscal > 0 
          DPA->( DBSetOrder( 1 ) ) 
          IF DPA->( DBSeek( nCodNf_ )  ) 
             WHILE DPA->( CODNF_ )==nNotaFiscal 
                  IF DPA->LETRA_ == cLetra_ 
                     lLocalizada:= .T. 
                        IF CTOD("") <> DPA->DTQT__ 
                           cTelares:= ScreenSave( 0, 0, 24, 79 ) 
                           Aviso( "Este titulo ja foi quitado em " + DTOC( DPA->DTQT__ ) ) 
                           Pausa() 
                           Screenrest( cTelaRes ) 
                        ELSE 
                           IF nCodCli <> DPA->CLIENT .and. nCodCli >= 0 
                              cTelares:= ScreenSave( 0, 0, 24, 79 ) 
                              Aviso( "Numero de cliente invalido " + STR( DPA->CLIENT ) ) 
                              Pausa() 
                              Screenrest( cTelares ) 
                           ELSE 
                              nCodCli:= DPA->CLIENT 
                              cli->( DBSetOrder( 1 ) ) 
                              Cli->( DBSeek( nCodCli ) ) 
 
                              // Informacoes 
                              cDescri:= CLI->DESCRI 
                              nClient:= nCodCli 
                              nValor:= DPA->VLR___ 
                              @ 05,32 say Left( cDescri, 30 ) 
                              AAdd( aTabela, { nNotaFiscal, cLetra_, nValor, DPA->OBS___ } ) 
                              nTotal:= nTotal + nValor 
                              oTab:RefreshAll() 
                              WHILE !oTab:Stabilize() 
                              ENDDO 
                           ENDIF 
                        ENDIF 
                        // Fim 
                        EXIT 
                  ENDIF 
                  DPA->( DBSkip() ) 
             ENDDO 
             IF !lLocalizada 
                cTelares:= ScreenSave( 0, 0, 24, 79 ) 
                Aviso( "Titulo nao localizado" ) 
                Pausa() 
                screenrest( cTelares ) 
             ENDIF 
          ELSE 
             cTelares:= ScreenSave( 0, 0, 24, 79 ) 
             Aviso( "Duplicata nao localizada" ) 
             Pausa() 
             screenRest( cTelaRes ) 
          ENDIF 
       ELSE 
          EXIT 
       ENDIF 
    ENDDO 
 
    //ListaEdita( @cObservacao, @cValores ) 
 
    WHILE .T. 
 
       oTab:ColorRect( { oTab:ROWPOS, 1, oTab:ROWPOS, oTab:COLCOUNT }, { 2, 1 } ) 
       WHILE NextKey()==0 .AND.! oTab:Stabilize() 
       ENDDO 
 
       /* Aguarda o pressionamento de uma tecla */ 
       IF ( nTecla:= Inkey(0) ) == K_ESC 
          EXIT 
       ENDIF 
 
       DO CASE 
          CASE nTecla==K_UP         ;oTab:up() 
          CASE nTecla==K_LEFT       ;oTab:up() 
          CASE nTecla==K_RIGHT      ;oTab:down() 
          CASE nTecla==K_DOWN       ;oTab:down() 
          CASE nTecla==K_PGUP       ;oTab:pageup() 
          CASE nTecla==K_PGDN       ;oTab:pagedown() 
          CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
          CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
          CASE Acesso( nTecla ) 
          CASE Chr( nTecla ) $ "gG" 
               lContinuar:= .T. 
               IF nTotal <> nTotalValidacao .AND.; 
                  ( !( STR( nTotal, 10, 2 ) == STR( nTotalValidacao, 10, 2 ) ) ) 
                  cTelares:= ScreenSave( 0, 0, 24, 79 ) 
                  Aviso( "Diferenca nos totais - Verifique: " + STR( nTotal, 10, 2 ) + " para " + STR( nTotalValidacao, 10, 2 ) ) 
                  nKey:= Inkey(0) 
                  IF nKey==K_TAB 
                     lContinuar:= .T. 
                  ELSE 
                     lContinuar:= .F. 
                  ENDIF 
                  screenRest( cTelaRes ) 
               ENDIF 
               // Continuar? 
               IF lContinuar 
                  DBSelectAr( _COD_DUPAUX ) 
                  lErro:= .F. 
                  cObservacao:= "" 
                  cValores:= "" 
                  FOR i:= 1 TO LEN( aTabela ) 
                      IF aTabela[ i ][ _TAB_TITULO ] > 0 
                         DBSeek( aTabela[ i ][ 1 ] ) 
                         WHILE DPA->CODNF_==aTabela[ i ][ _TAB_TITULO ] 
                             Mensagem( "Gravando baixa da duplicata " + StrZero( aTabela[ i ][ _TAB_TITULO ], 9, 0 ) ) 
                             IF DPA->LETRA_==aTabela[ i ][ _TAB_LETRA ] 
                                IF DPA->( netrlock() ) 
                                   Replace DPA->LOCAL_ With nLocalQuitacao 
                                   cObservacao:= cObservacao + PAD( StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_, 10 ) 
                                   cValores:= cValores + Str( DPA->VLR___, 10, 02 ) 
                                   BaixaReceber( oTab, .T. ) 
                                ENDIF 
                             ENDIF 
                             DPA->( DBSkip() ) 
                         ENDDO 
                      ENDIF 
                  NEXT 
 
                  /// Cria um novo registro com valor total 
                  cLetra_:= "_" 
                  cObs___:= "## QUITACAO MULTIPLA ##" 
                  DBSelectAr( _COD_DUPAUX ) 
                  DBSetOrder( 3 ) 
                  DBGoBottom() 
                  nCodigo:= CODIGO + 1 
                  DBAppend() 
                  IF netrlock() 
                     Repl CLIENT With nClient,; 
                          CDESCR With cDescri,; 
                          CODNF_ With nCodNf_,; 
                          CODIGO With nCodigo,; 
                          DATAEM With DATE(),;    && Emissao 
                          TIPO__ With cTipo__,; 
                          CODIGO With nCodigo,; 
                          CODNF_ With nCodNf_,; 
                          VLR___ With nTotal,; 
                          JUROS_ With 0,; 
                          CLIENT With nClient,; 
                          CDESCR With cDescri,; 
                          PERC__ With 0,; 
                          PRAZ__ With 0,; 
                          VENC__ With DATE(),; 
                          QUIT__ With " ",; 
                          DTQT__ With CTOD( "" ),; 
                          BANC__ With nLocalCheque,; 
                          OBS___ With cObs___,; 
                          LETRA_ With cLetra_,; 
                          CHEQ__ With "",; 
                          VLRICM With 0,; 
                          VLRIPI With 0,; 
                          VLRISS With 0,; 
                          LOCAL_ With nLocalCheque 
                     ListaGrava( cObservacao, cValores ) 
                     LancaCliente( CLIENT, 0, VLR___ ) 
                  ENDIF 
                  DBSelectAr( _COD_DUPAUX ) 
                  DBLeOrdem() 
                  EXIT 
               ENDIF 
          CASE nTecla==K_DEL 
               oTab:RefreshAll() 
               WHILE !oTab:Stabilize() 
               ENDDO 
               FOR nCt:= 1 TO Len( aTabela ) 
                   ADel( aTabela, nRow ) 
               NEXT 
               ASize( aTabela, Len( aTabela )-1 ) 
               oTab:Up() 
               oTab:RefreshAll() 
               WHILE !oTab:Stabilize() 
               ENDDO 
          CASE nTecla==K_ENTER 
          CASE nTecla==K_DEL 
          OTHERWISE                ;tone(125); tone(300) 
       ENDCASE 
       oTab:refreshcurrent() 
       oTab:stabilize() 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  DBSelectAr( nArea ) 
  Set( _SET_DELIMITERS, lDelimiters ) 
 
 
Function ListaGrava( cObservacao, cObserv1 ) 
   IF DPA->( netrlock() ) 
      Replace DPA->OBSERV With cObservacao 
      Replace DPA->OBSER1 With cObserv1 
   ENDIF 
   Return Nil 
 
 
 
Function ListaEdita( cObservacao, cValores ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      cCor:= SetColor(), nCursor:= SetCursor() 
Local cInformacao:= Space( 10 ) 
Local aInfo:= {{ Space( 10 ), Space( 10 ) }} 
Local nValor:= 0 
Local oTab, nRow, nTecla 
 
    nRow:= 1 
    FOR i:= 0 TO ( Len( cObservacao ) / 10 ) -1 
        AAdd( aInfo, { SubStr( cObservacao, ( 10 * i )+1, 10 ),; 
                       SubStr( cValores, ( 10 * i )+1, 10 ) } ) 
    NEXT 
    SetColor( _COR_BROWSE ) 
    VPBox( 02, 49, 20, 76, "Titulos", _COR_BROWSE ) 
    oTab:= TBrowsedb( 03, 50, 19, 75 ) 
    oTab:Addcolumn( tbColumnNew(, {|| aInfo[ nRow ][ 1 ] } ) ) 
    oTab:Addcolumn( tbColumnNew(, {|| aInfo[ nRow ][ 2 ] } ) ) 
    oTab:GOTOPBLOCK :={|| nROW:=1} 
    oTab:GOBOTTOMBLOCK:={|| nROW:=len( aInfo )} 
    oTab:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aInfo,@nROW)} 
    oTab:AUTOLITE:=.F. 
    oTab:dehilite() 
 
    WHILE .T. 
 
       oTab:ColorRect( { oTab:ROWPOS, 1, oTab:ROWPOS, oTab:COLCOUNT }, { 2, 1 } ) 
       WHILE NextKey()==0 .AND.! oTab:Stabilize() 
       ENDDO 
 
       /* Aguarda o pressionamento de uma tecla */ 
       IF ( nTecla:= Inkey(0) ) == K_ESC 
          EXIT 
       ENDIF 
 
       DO CASE 
          CASE nTecla==K_UP         ;oTab:up() 
          CASE nTecla==K_LEFT       ;oTab:up() 
          CASE nTecla==K_RIGHT      ;oTab:down() 
          CASE nTecla==K_DOWN       ;oTab:down() 
          CASE nTecla==K_PGUP       ;oTab:pageup() 
          CASE nTecla==K_PGDN       ;oTab:pagedown() 
          CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
          CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
          CASE Acesso( nTecla ) 
          CASE nTecla==K_ENTER 
               SetCursor( 1 ) 
               nValor:= Val( aInfo[ nRow ][ 2 ] ) 
 
               SetColor( _COR_GET_EDICAO ) 
               @ ROW(),52 Get aInfo[ nRow ][ 1 ] 
               @ ROW(),63 Get nValor Pict "@E 9999999.99" 
               READ 
               SetColor( _COR_BROWSE ) 
 
               aInfo[ nRow ][ 2 ]:= Str( nValor, 10, 2 ) 
               SetCursor( 0 ) 
               cObservacao:= "" 
               cValores:= "" 
               FOR i:= 1 TO Len( aInfo ) 
                  if !Empty( aInfo[ i ][ 1 ] ) .or. !Empty( aInfo[ i ][ 2 ] ) 
                     cObservacao:= cObservacao + PAD( aInfo[ i ][ 1 ], 10 ) 
                     cValores:= cValores + aInfo[ i ][ 2 ] 
                  endif 
               NEXT 
               cObservacao:= PAD( cObservacao, LEN( DPA->OBSERV ) ) 
               cValores:= PAD( cValores, LEN( DPA->OBSER1 ) ) 
 
          CASE nTecla==K_DEL 
          OTHERWISE                ;tone(125); tone(300) 
       ENDCASE 
       oTab:refreshcurrent() 
       oTab:stabilize() 
  enddo 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  Return Nil 
 
 
 
 
Function VerDataVenc( dDataEmissao, dData, nPrazo ) 
Local cTela:= ScreenSave( 0, 0, 24, 79  ), nCursor:= SetCursor(),; 
      cCor:= SetColor() 
VerData( @dData ) 
nPrazo:= dData - dDataEmissao 
IF nPrazo < 0 
   nPrazo:= 0 
   dData:= dDataEmissao 
   Aviso( "Data com VENCIMENTO inferior ao da EMISSAO!" ) 
   Pausa() 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return .F. 
ENDIF 
Return .T. 
 
 
/***** 
�������������Ŀ 
� Funcao      � VISUALFABERTA 
� Finalidade  � Apresentacao das condicoes de pagamento de forma aberta 
� Parametros  � aParcelas 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Agosto de 1999 
��������������� 
*/ 
Function VisualFAberta( aParcelas, nTotalGeral ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local oTab, nRow:= 1, nTecla 
  Local lDelimiters:= Set( _SET_DELIMITERS ) 
  Local nTotal:= 0, nTotalReajuste:= 0 
 
  /* Rotina p/ totalizacao de parcelas */ 
  FOR nCt:= 1 TO LEN( aParcelas ) 
      nTotal:= nTotal + aParcelas[ nCt ][ 6 ] 
      nTotalReajuste:= nTotalReajuste + ; 
          ( aParcelas[ nCt ][ 6 ] + JurosFuturos( aParcelas[ nCt ][ 6 ], aParcelas[ nCt ][ 4 ], DATE(), aParcelas[ nCt ][ 10 ] ) ) 
  NEXT 
 
  VPBox( 00, 00, 22, 79, "APRESENTACAO DAS CONDICOES DE PAGAMENTO", _COR_BROW_BOX ) 
  VPBox( 17, 00, 22, 79, " T O T A I S ", _COR_GET_BOX ) 
  @ 19,02 Say " Total das Parcelas               " + Tran( nTotal,         "@E 999,999,999.99" ) Color _COR_GET_EDICAO 
  @ 20,02 Say " Total das Parcelas Reajustadas   " + Tran( nTotalReajuste, "@E 999,999,999.99" ) Color _COR_GET_EDICAO 
  @ 21,02 Say " Valor Base                       " + Tran( nTotalGeral,    "@E 999,999,999.99" ) Color _COR_GET_EDICAO 
  SetColor( _COR_BROWSE ) 
  Ajuda( "["+_SETAS+"][PgUp][PgDn]Movimenta [*]Anula [TAB]Imprime_DOCs [CTRL+TAB]Imprime_DUP" ) 
  oTab:= TBrowsedb( 01, 01, 16, 78 ) 
  oTab:Addcolumn( tbColumnNew(, {|| Str( aParcelas[ nRow ][ 1 ], 03, 00 ) + " " + ; 
                                StrZero( aParcelas[ nRow ][ 2 ], 03, 00 ) + " " +; 
                                   DTOC( aParcelas[ nRow ][ 4 ] ) + " " + ; 
                                         aParcelas[ nRow ][ 5 ] + " " + ; 
                                   Tran( aParcelas[ nRow ][ 6 ], "@E 999,999,999.99" ) + " " +; 
                                   Tran( aParcelas[ nRow ][ 6 ] + ; 
                           JurosFuturos( aParcelas[ nRow ][ 6 ], aParcelas[ nRow ][ 4 ], aParcelas[ nRow ][ 11 ], aParcelas[ nRow ][ 10 ] ), "@E 999,999,999.99" ) } ) ) 
  oTab:GOTOPBLOCK :={|| nROW:=1} 
  oTab:GOBOTTOMBLOCK:={|| nROW:=len(aParcelas)} 
  oTab:SKIPBLOCK:={|WTOJUMP| SkipperArr(WTOJUMP,aParcelas,@nROW)} 
  oTab:AUTOLITE:=.F. 
  oTab:dehilite() 
  WHILE .T. 
     oTab:ColorRect( { oTab:ROWPOS, 1, oTab:ROWPOS, oTab:COLCOUNT }, { 2, 1 } ) 
     WHILE NextKey()==0 .AND.! oTab:Stabilize() 
     ENDDO 
     /* Aguarda o pressionamento de uma tecla */ 
     IF ( nTecla:=inkey(0) )==K_ESC 
        EXIT 
     ENDIF 
 
     DO CASE 
        CASE nTecla==K_UP         ;oTab:up() 
        CASE nTecla==K_LEFT       ;oTab:up() 
        CASE nTecla==K_RIGHT      ;oTab:down() 
        CASE nTecla==K_DOWN       ;oTab:down() 
        CASE nTecla==K_PGUP       ;oTab:pageup() 
        CASE nTecla==K_PGDN       ;oTab:pagedown() 
        CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
        CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
        CASE Acesso( nTecla ) 
        CASE nTecla==K_ENTER .OR. nTecla==K_TAB 
             exit 
        CASE nTecla==K_DEL 
        OTHERWISE                ;tone(125); tone(300) 
     ENDCASE 
     oTab:refreshcurrent() 
     oTab:stabilize() 
  ENDDO 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Set( _SET_DELIMITERS, lDelimiters ) 
 
/***** 
�������������Ŀ 
� Funcao      � AltRecManual 
� Finalidade  � Alteracao de Contas a Receber MANUAL 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Agosto/1998 
��������������� 
*/ 
Function AltRecManual( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local nOpcao:= 3, cTipo__ 
Local nClient:= 0, nCodLan:= 0, nValor_:= 0, nNVezes:= 0, oTabNew 
Local aLancamentos:= {}, nRow:= 1 
Local lQuitada:= .F. 
  DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo( "ALTERACAO DE CONTAS A RECEBER - [LANCAMENTO MANUAL  ]" ) 
  SetColor( _COR_GET_EDICAO ) 
  MostraStr() 
  MostraDados() 
  DispEnd() 
  cTipo__:= "02" 
  SetColor( _COR_GET_EDICAO ) 
  nConta_:= CODNF_ 
  nClient:= CLIENT 
  cDescri:= CDESCR 
  cLetra:= "#" 
  cDesConta:= Space( 30 ) 
  SetCursor( 1 ) 
  Set( _SET_DELIMITERS, .F. ) 
  @ 03,02 Say "Conta.........: [   ]          " 
  @ 03,19 Get nConta_ Pict "@R 9999" Valid PesqConta( @nConta_, cDesConta ) 
  @ 04,19 Get nClient Pict "@R 999999" valid nClient == 0 .OR. PesqCliente( @nClient, @cDescri ) 
  @ 04,28 Get cDescri 
  READ 
  nCodNf_:= nConta_ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     oTab:RefreshAll() 
     WHILE !oTab:Stabilize() 
     ENDDO 
     Return Nil 
  ELSE 
     /* Limpando Variaveis p/ lancamento */ 
     cTipo__:= TIPO__ 
     nValor_:= VLR___ 
     dDataEm:= DATAEM 
     nVlr___:= VLR___ 
     nJuros_:= JUROS_ 
     nVlrDes:= VLRDES 
     nPraz__:= PRAZ__ 
     dVenc__:= VENC__ 
     dQuit__:= DTQT__ 
     nBanc__:= BANC__ 
     cCheq__:= CHEQ__ 
     cObs___:= OBS___ 
     cSitu__:= SITU__ 
     nCodigo:= CODIGO 
     nTotal:=  NF_->VLRTOT 
     nVlrICM:= VLRICM 
     nVlrIPI:= VLRIPI 
     nVlrISS:= VLRISS 
     nValorInicial:= VLR___ 
     nLocal_:= LOCAL_ 
     lQuitada:= IF( EMPTY( dQuit__ ), .F., .T. ) 
     Set( _SET_DELIMITERS, .T. ) 
     @ 06,02 Say "Banco.........:" Get nBanc__ Pict "999" Valid PesqBco( @nBanc__ ) 
     @ 07,02 Say "Emissao.......:" Get dDataEm 
     @ 08,02 Say "Prazo em Dias.:" Get nPraz__ Pict "999" Valid Vencimento( nPraz__, dDataEm, @dVenc__ ) 
     @ 09,02 Say "Vencimento....:" Get dVenc__ Valid VerData( @dVenc__ ) 
     @ 10,02 Say "Quitacao......:" Get dQuit__ 
     @ 11,02 Say "Valor.........:" Get nValor_ Pict "@E 999,999,999.99" 
     @ 12,02 Say "Acrescimos....:" Get nJuros_ Pict "@E 999,999,999.99" 
     @ 13,02 Say "Descontos.....:" Get nVlrDes Pict "@E 999,999,999.99" 
     @ 14,02 Say "Observacoes...:" Get cObs___ 
     @ 15,02 Say "Localizacao...:" Get nLocal_ Pict "999" Valid PesqBco( @nLocal_ ) 
     READ 
     IF !LastKey() == K_ESC 
        Set( _SET_DELIMITERS, .F. ) 
        VpBox( 06, 45, 09, 77, "DIVERSOS", _COR_GET_BOX, .F., .F. ) 
        SetColor( _COR_GET_EDICAO ) 
        @ 07,46 Say "Nota Fiscal...: " + Tran( nCODNF_, "999999999" ) 
        @ 08,46 Say "Cheque........:" Get cCHEQ__ 
        READ 
        Set( _SET_DELIMITERS, .T. ) 
        SetColor( _COR_BROWSE ) 
        IF netrlock() 
           Replace CLIENT With nClient,; 
                   CDESCR With cDescri,; 
                   CODNF_ With nCodNf_,; 
                   CODIGO With nCodigo,; 
                   DATAEM With dDataEm,; 
                   TIPO__ With cTipo__,; 
                   CODIGO With nCodigo,; 
                   CODNF_ With nCodNf_,; 
                   VLR___ With nValor_,; 
                   JUROS_ With nJuros_,; 
                   VLRDES With nVlrDes,; 
                   CLIENT With nClient,; 
                   CDESCR With cDescri,; 
                   PERC__ With 0,; 
                   PRAZ__ With nPraz__,; 
                   VENC__ With dVenc__,; 
                   QUIT__ With IF( !EMPTY( dQuit__ ), "S", " " ),; 
                   DTQT__ With dQuit__,; 
                   BANC__ With nBanc__,; 
                   OBS___ With cObs___,; 
                   LETRA_ With cLetra,; 
                   CHEQ__ With cCheq__,; 
                   VLRICM With nVlrIcm,; 
                   VLRIPI With nVlrIpi,; 
                   VLRISS With nVlrIss,; 
                   LOCAL_ With nLocal_ 
           /* Se foi modificado o valor */ 
           IF !nValorInicial == VLR___ 
              LancaCliente( CLIENT, nValorInicial, 0 ) 
              LancaCliente( CLIENT, 0, VLR___ ) 
           ENDIF 
           IF !Empty( dQuit__ ) .AND. !lQuitada 
              /* Se nao estava quitada e foi preenchida a data 
              de quitacao da duplicata o sistema lanca a baixa 
              automaticamente */ 
              BaixaReceber( oTab, .T. ) 
           ENDIF 
        ENDIF 
     ENDIF 
  ENDIF 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � PESQCONTA 
� Finalidade  � Pesquisa da Conta de Lancamento 
� Parametros  � nCodigo / cDescricao 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function PesqConta( nCodigo, cDescricao ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), oTB, nTecla, GETLIST:={} 
 
  dbSelectAr( _COD_RECEITAS ) 
  dbSetOrder( 1 ) 
  IF dbseek( nCodigo ) 
     cDescricao:= DESCRI 
  ELSE 
     DBLeOrdem() 
     SetColor( _COR_BROWSE ) 
     vpbox(05,33,20,74,"SELECAO DE CONTAS DE RECEITA", _COR_BROW_BOX ) 
     dbgotop() 
     SetCursor(0) 
     Mensagem("Pressione [ENTER] p/ selecionar.") 
     Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F2]Codigo [F3]Nome") 
     oTB:=tbrowsedb(06,35,19,73) 
     oTB:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" -> "+DESCRI + SPACE( 10 ) })) 
     oTB:AUTOLITE:=.f. 
     oTB:dehilite() 
     WHILE .T. 
        oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
        whil nextkey()=0 .and.! oTB:stabilize() 
        enddo 
        IF ( nTecla:=inkey(0) ) == K_ESC 
           nCodigo:= 0 
           cDescricao:= Space( 40 ) 
           EXIT 
        ENDIF 
        DO CASE 
           CASE nTecla==K_UP         ;oTB:up() 
           CASE nTecla==K_LEFT       ;oTB:up() 
           CASE nTecla==K_RIGHT      ;oTB:down() 
           CASE nTecla==K_DOWN       ;oTB:down() 
           CASE nTecla==K_PGUP       ;oTB:pageup() 
           CASE nTecla==K_PGDN       ;oTB:pagedown() 
           CASE nTecla==K_CTRL_PGUP  ;oTB:gotop() 
           CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
           CASE DBPesquisa( nTecla, oTb ) 
           CASE nTecla==K_F2         ;DBMudaOrdem( 1, oTb ) 
           CASE nTecla==K_F3         ;DBMudaOrdem( 2, oTb ) 
           CASE nTecla==K_ENTER 
                nCodigo:= CODIGO 
                cDescricao:= DESCRI 
                EXIT 
           OTHERWISE                ;tone(125); tone(300) 
        ENDCASE 
        oTB:refreshcurrent() 
        oTB:stabilize() 
     ENDDO 
  ENDIF 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  dbSelectar( nArea ) 
  Return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � VENCIMENTO 
� Finalidade  � Calcular o vencimento com base em uma data 
� Parametros  � 
� Retorno     � .T. 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
  Function Vencimento( nPrazoDias, dData, dVencimento ) 
  dVencimento:= dData + nPrazoDias 
  Return .T. 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � AnulaDuplicata 
� Finalidade  � Anular uma Duplicata 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
  Function AnulaDuplicata( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
   IF netrlock() 
      DBSelectAr( _COD_DUPAUX ) 
      nCodigo:= CODIGO 
      nValor_:= VLR___ 
      nClient:= CLIENT 
      cDoc___:= StrZero( CODNF_, 9, 0 ) + LETRA_ 
      nJuros_:= JUROS_ 
      nVlrDes:= VLRDES 
      nBancoConta:= LOCAL_ 
      lSaida:= .F. 
      /* Se ja foi quitado, modifica o saldo da conta */ 
      IF !EMPTY( DTQT__ ) 
         IF NFNULA == " " 
            WHILE !lSaida 
               PesqBco( @nBancoConta ) 
               IF LastKey() == K_ESC 
                  lSaida:= .T. 
                  SetColor( cCor ) 
                  SetCursor( nCursor ) 
                  ScreenRest( cTela ) 
                  Return Nil 
               ENDIF 
               cBancoDescri:= BAN->DESCRI 
               nBancoSaldo:=  BAN->SALDO_ 
               cHistorico:= "Lan:" + StrZero( nCodigo, 6, 0 ) + " D:" + cDoc___ + " C:" + StrZero( nClient, 4, 0 ) 
               /* Lancamento de Saida de uma Conta de Transferencia p/ estorno de quitacao */ 
               LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ANULACAO DE RECEBIMENTO", cHistorico, nValor_, 0 ) 
               LancaSaldos( nBancoConta, cBancoDescri, "T", nValor_, 0 ) 
               IF !nJuros_ == 0 
                  /* Lancamento de Juros */ 
                  LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ANULACAO DE JUROS RECEBIDOS", cHistorico, nJuros_, 0 ) 
                  LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nValor_, 0 ) 
               ENDIF 
               IF !nVlrDes == 0 
                  /* Lancamento de Descontos */ 
                  LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "ANULACAO DE DESCONTO CONCEDIDO", cHistorico, 0, nVlrDes ) 
                  LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nValor_, 0 ) 
               ENDIF 
 
 
               lSaida:= .T. 
               DBSelectAr( _COD_DUPAUX ) 
            ENDDO 
         ELSE 
            WHILE !lSaida 
               PesqBco( @nBancoConta ) 
               IF LastKey() == K_ESC 
                  lSaida:= .T. 
                  SetColor( cCor ) 
                  SetCursor( nCursor ) 
                  ScreenRest( cTela ) 
                  Return Nil 
               ENDIF 
               cBancoDescri:= BAN->DESCRI 
               nBancoSaldo:=  BAN->SALDO_ 
               cHistorico:= "Lan:" + StrZero( nCodigo, 6, 0 ) + " D:" + cDoc___ + " C:" + StrZero( nClient, 4, 0 ) 
               /* Lancamento de Saida de uma Conta de Transferencia p/ estorno de quitacao */ 
               LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "RESTAURACAO DE DUPLICATA", cHistorico, 0, nValor_ ) 
               LancaSaldos( nBancoConta, cBancoDescri, "T", 0, nValor_ ) 
               IF !nJuros_ == 0 
                  /* Lancamento de Juros */ 
                  LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "RESTAURACAO DE JUROS DUP", cHistorico, 0, nJuros ) 
                  LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", 0, nValor_ ) 
               ENDIF 
 
               IF !nVlrDes == 0 
                  /* Lancamento de Descontos */ 
                  LancaMovimento( DATE(), nBancoConta, cBancoDescri, "T", "RESTAURACAO DE DESC.CONCEDIDO", cHistorico, nVlrDes, 0 ) 
                  LancaSaldos( BAN->CODIGO, BAN->DESCRI, "T", nVlrDes, 0 ) 
               ENDIF 
 
               lSaida:= .T. 
               DBSelectAr( _COD_DUPAUX ) 
            ENDDO 
        ENDIF 
     ENDIF 
     DBSelectAr( _COD_DUPAUX ) 
     IF netrlock() 
        Replace NFNula WITH IF( NFNula == "*", " ", "*" ) 
        /* Se a data de quitacao estiver em branco lanca o credito p/ cliente */ 
        IF !Empty( DTQT__ ) .AND. NFNULA == "*" 
           LancaCliente( CLIENT, 0, VLR___ ) 
        ELSEIF !Empty( DTQT__ ) .AND. NFNULA == " " 
           LancaCliente( CLIENT, VLR___, 0 ) 
        ELSEIF Empty( DTQT__ ) .AND. NFNULA == "*" 
           LancaCliente( CLIENT, VLR___, 0 ) 
        ELSEIF Empty( DTQT__ ) .AND. NFNULA == " " 
           LancaCliente( CLIENT, 0, VLR___ ) 
        ENDIF 
     ENDIF 
  ENDIF 
  DBUnlockAll() 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
 
 
 
 
   Function MarcaEnvioBanco( oTab ) 
 
              cTELA0:= ScreenSave(10,30, 24, 79 ) 
              nREGISTRO:=recno() 
              vpbox(10,30,12,73,"<<* Marca de envio para o banco *>>") 
              @ 11,32 say "Intervalo: de" get dDATA1 when; 
                mensagem("Digite a data de inicio da atualizacao....") 
              @ 11,56 say " ate " get dDATA2 when; 
                mensagem("Digite a data do final da atualizacao....") 
              read 
              if lastkey()=K_ENTER 
                 mensagem("Alterando a situacao da serie A mediante (Banco/Cliente).") 
                 set filter to VENC_A>=dDATA1 .AND. VENC_A<=dDATA2 
                 dbgotop() 
                 whil ! eof() 
                    if VENC_A<>ctod("  /  /  ") 
                       if netrlock() 
                          repl SITU_A with "1" 
                       endif 
                    endif 
                    @ 12,65 say "ROT#"+strzero(recno(),4,0) 
                    dbskip() 
                 enddo 
                 mensagem("Alterando a situacao da serie B mediante (Banco/Cliente).") 
                 set filter to VENC_B>=dDATA1 .AND. VENC_B<=dDATA2 
                 dbgotop() 
                 whil ! eof() 
                    if VENC_B<>ctod("  /  /  ") 
                       if netrlock() 
                          repl SITU_B with "1" 
                       endif 
                    endif 
                    @ 12,59 say "ROT#"+strzero(recno(),4,0) 
                    dbskip() 
                 enddo 
                 mensagem("Alterando a situacao da serie C mediante (Banco/Cliente).") 
                 set filter to VENC_C>=dDATA1 .AND. VENC_C<=dDATA2 
                 dbgotop() 
                 whil ! eof() 
                    if VENC_C<>ctod("  /  /  ") 
                       if netrlock() 
                          repl SITU_C with "1" 
                       endif 
                    endif 
                    @ 12,59 say "ROT#"+strzero(recno(),4,0) 
                    dbskip() 
                 enddo 
                 mensagem("Alterando a situacao da serie D mediante (Banco/Cliente).") 
                 set filter to VENC_D>=dDATA1 .AND. VENC_D<=dDATA2 
                 dbgotop() 
                 whil ! eof() 
                    if VENC_D<>ctod("  /  /  ") 
                       if netrlock() 
                          repl SITU_D with "1" 
                       endif 
                    endif 
                    @ 12,59 say "ROT#"+strzero(recno(),4,0) 
                    dbskip() 
                 enddo 
              endif 
              set filter to 
              ScreenRest(cTELA0) 
              dbgoto(nREGISTRO) 
 
 
/***** 
�������������Ŀ 
� Funcao      � PESQCLIENTE 
� Finalidade  � Pesquisa de cliente 
� Parametros  � nCodigo / cDescricao 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function PesqCliente( nCodigo, cDescricao ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), oTB, nTecla, GetList:= {} 
 dbSelectAr(_COD_CLIENTE) 
 DBSetOrder( 1 ) 
 IF nCodigo <> 0 .AND. dbseek( nCodigo ) 
    cDescricao:= CLI->DESCRI 
 ELSE 
    VPBox( 04, 13, 20, 74, "SELECAO DE CLIENTE", _COR_BROW_BOX ) 
    DBLeOrdem() 
    IF EOF() 
       dbGotop() 
    ENDIF 
    setcursor(0) 
    setcolor( _COR_BROWSE ) 
    Mensagem("Pressione [ENTER] p/ selecionar.") 
    Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3]Codigo [F4]Nome") 
    oTB:=tbrowsedb(05,14,19,73) 
    oTB:addcolumn(tbcolumnnew(,{|| strzero( CODIGO, 6, 0 )+" -> "+DESCRI + SPACE( 10 )})) 
    oTB:AUTOLITE:=.f. 
    oTB:dehilite() 
    WHILE .T. 
 
        oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
        whil nextkey()=0 .and.! oTB:stabilize() 
        enddo 
 
        IF ( nTecla:=inkey(0) ) == K_ESC 
           nCodigo:= 0 
           cDescricao:= Space( 45 ) 
           EXIT 
        ENDIF 
 
        DO CASE 
           CASE nTecla==K_UP         ;oTB:up() 
           CASE nTecla==K_LEFT       ;oTB:up() 
           CASE nTecla==K_RIGHT      ;oTB:down() 
           CASE nTecla==K_DOWN       ;oTB:down() 
           CASE nTecla==K_PGUP       ;oTB:pageup() 
           CASE nTecla==K_PGDN       ;oTB:pagedown() 
           CASE nTecla==K_CTRL_PGUP  ;oTB:gotop() 
           CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
           CASE DBPesquisa( nTecla, oTb ) 
           CASE nTecla==K_F2         ;DBMudaOrdem( 1, oTB ) 
           CASE nTecla==K_F3         ;DBMudaOrdem( 2, oTB ) 
           CASE nTecla==K_ENTER 
                nCodigo:= CODIGO 
                cDescricao:= DESCRI 
                EXIT 
           OTHERWISE                ;tone(125); tone(300) 
        ENDCASE 
        oTB:refreshcurrent() 
        oTB:stabilize() 
     enddo 
 ENDIF 
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 ScreenRest( cTela ) 
 dbSelectar( nArea ) 
 Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � PESQNFISCAL 
� Finalidade  � Pesquisa de Nota Fiscal 
� Parametros  � nCodigo / cDescricao 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function PesqNFiscal( nCodigo, nCliente ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), oTB, nTecla, GetList:= {} 


 dbSelectAr(_COD_NFISCAL) 
 DBSetOrder( 1 ) 
 IF dbseek( nCodigo ) 
    nCliente:= NF_->CLIENT 
 ELSE 
    if SWAlerta( "Esta nota fiscal nao foi encontrada. O que deseja fazer?", { "Aceitar", "Buscar Nota" } )==2 
	VPBox( 06, 23, 20, 74, "SELECAO DE NOTA FISCAL EMITIDA", _COR_BROW_BOX ) 
	DBLeOrdem() 
	dbGotop() 
	setcursor( 0 ) 
	setcolor( _COR_BROWSE ) 
	Mensagem("Pressione [ENTER] p/ selecionar.") 
	Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3]Codigo [F4]Nome") 
	oTB:=tbrowsedb( 07, 24, 19, 73 ) 
	oTB:addcolumn(tbcolumnnew(,{|| strzero(NUMERO,6,0)+" -> "+CDESCR })) 
	oTB:AUTOLITE:=.f. 
	oTB:dehilite() 
	WHILE .T. 
	
	oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
	whil nextkey()=0 .and.! oTB:stabilize() 
	enddo 
	
	IF ( nTecla:=inkey(0) ) == K_ESC 
		nCodigo:= 0 
		nCliente:= 0 
		EXIT 
	ENDIF 
	
	DO CASE 
		CASE nTecla==K_UP         ;oTB:up() 
		CASE nTecla==K_LEFT       ;oTB:up() 
		CASE nTecla==K_RIGHT      ;oTB:down() 
		CASE nTecla==K_DOWN       ;oTB:down() 
		CASE nTecla==K_PGUP       ;oTB:pageup() 
		CASE nTecla==K_PGDN       ;oTB:pagedown() 
		CASE nTecla==K_CTRL_PGUP  ;oTB:gotop() 
		CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
		CASE DBPesquisa( nTecla, oTb ) 
		CASE nTecla==K_F2         ;DBMudaOrdem( 1, oTB ) 
		CASE nTecla==K_F3         ;DBMudaOrdem( 2, oTB ) 
		CASE nTecla==K_F4         ;DBMudaOrdem( 3, oTb ) 
		CASE nTecla==K_ENTER 
		nCodigo:= NUMERO 
		nCliente:= CLIENT 
		EXIT 
		OTHERWISE                ;tone(125); tone(300) 
	ENDCASE 
	oTB:refreshcurrent() 
	oTB:stabilize() 
	enddo 
     endif
 ENDIF 
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 ScreenRest( cTela ) 
 dbSelectar( nArea ) 
 Return( .T. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � QuitaReceber 
� Finalidade  � Quitacao de duplicatas a receber 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/Setembro/1998 
��������������� 
*/ 
Function QuitaReceber() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nQuitado:= 0 
Local nArea:= Select() 
Local nRow:= 1 
Local aLancamentos:= {} 
 
  VPBox( 05, 02, 20, 75, "QUITACAO DE DUPLICATAS", _COR_BROW_BOX ) 
  SetColor( _COR_BROWSE ) 
  DBSelectAr( _COD_DUPAUX ) 
  nCodNf_:=   DUP->CODNF_ 
  dDataBase:= DUP->DATAEM 
  nClient:=   DUP->CLIENT 
  cDescri:=   DUP->CDESCR 
  nTotal:=    DUP->VALOR_ 
  nCodigo:=   DUP->CODIGO 
  cTipo__:=   DUP->TIPO__ 
  IF EMPTY( dDataBase ) 
     dDatabase:= DUP->VENC_A - DUP->PRAZ_A 
  ENDIF 
  DBSelectAr( _COD_DUPAUX ) 
  DBSetOrder( 1 ) 
  IF DBSeek( DUP->CODNF_ ) 
     FOR nCt:= 1 TO 23 
         AAdd( aLancamentos, { Chr( nCt + 64 ), 0, 0, 0, 0, 0, CTOD( "  /  /  " ), CTOD( "  /  /  " ), 0, Space(15), Space(30) } ) 
         IF nCodNf_ == DPA->CODNF_ 
            aLancamentos[ nCt ][ 2 ]:=  nCodNf_ 
            aLancamentos[ nCt ][ 3 ]:=  DUPL__ 
            aLancamentos[ nCt ][ 4 ]:=  PERC__ 
            aLancamentos[ nCt ][ 5 ]:=  VLR___ 
            aLancamentos[ nCt ][ 6 ]:=  PRAZ__ 
            aLancamentos[ nCt ][ 7 ]:=  VENC__ 
            aLancamentos[ nCt ][ 8 ]:=  DTQT__ 
            aLancamentos[ nCt ][ 9 ]:=  BANC__ 
            aLancamentos[ nCt ][ 10 ]:= CHEQ__ 
            aLancamentos[ nCt ][ 11 ]:= OBS___ 
         ENDIF 
         DBSkip() 
         IF EOF() .OR. !nCodNf_ == DPA->CODNF_ 
            EXIT 
         ENDIF 
     NEXT 
  ENDIF 
  lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
  oTabNew:= TBrowseNew( 06, 03, 19, 74 ) 
  oTabNew:AddColumn( TBColumnNew( , {|| aLancamentos[ nRow ][ 1 ] } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| Tran( StrZero( aLancamentos[ nRow ][ 2 ], 6, 0 ), "@R 999.999-" ) + StrZero( MONTH( aLancamentos[ nRow ][ 7 ] ), 2, 0 ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| Tran( aLancamentos[ nRow ][ 4 ], "@E 999.99" ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| Tran( aLancamentos[ nRow ][ 6 ], "@E 99" ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| aLancamentos[ nRow ][ 7 ] } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| IF( !EMPTY( aLancamentos[ nRow ][ 8 ] ), "S", " " ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| aLancamentos[ nRow ][ 8 ] } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| StrZero( aLancamentos[ nRow ][ 9 ], 3, 0 ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| Left( aLancamentos[ nRow ][ 10 ], 12 ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| Tran( aLancamentos[ nRow ][ 5 ], "@E 999,999.99" ) } )) 
  oTabNew:AddColumn( TBColumnNew( , {|| " " } )) 
  oTabNew:ColSep:= " " 
  oTabNew:SkipBlock:= {|x| SkipperArr( x, aLancamentos, @nRow ) } 
  oTabNew:GoBottomBlock:= {|| nRow:= Len( aLancamentos ) } 
  oTabNew:GoTopBlock:= {|| nRow:= 1 } 
  oTabNew:AUTOLITE:=.F. 
  oTabNew:dehilite() 
  oTabNew:GoTop() 
  WHILE .T. 
    oTabNew:ColorRect( { oTabNew:ROWPOS, 1, oTabNew:ROWPOS, oTabNew:COLCOUNT }, { 2, 1 } ) 
    WHILE NextKey()==0 .AND.! oTabNew:Stabilize() 
    ENDDO 
 
    /* Aguarda o pressionamento de uma tecla */ 
    IF ( nTecla:=inkey(0) )==K_ESC 
       /* Somando o Total Geral */ 
       nTotal:= 0 
       For nCt:= 1 TO Len( aLancamentos ) 
           nTotal:= nTotal + aLancamentos[ nCt ][ 5 ] 
       Next 
       nAreaRes:= Select() 
       IF nTotal > 0 
          IF Confirma( 0, 0, "Gravar Informacoes?" ,, "S") 
             DBSelectAr( _COD_DUPAUX ) 
             DBSetOrder( 1 ) 
             IF DBSeek( nCodNf_ ) 
                WHILE !EOF() 
                   IF CODNF_ == nCodNf_ 
                      IF netrlock() 
                         Dele 
                      ENDIF 
                   ELSE 
                      Exit 
                   ENDIF 
                   DBSkip() 
                ENDDO 
             ENDIF 
             DBLeOrdem() 
             DBSelectAr( _COD_DUPAUX ) 
             FOR nCt:= 1 TO Len( aLancamentos ) 
                 IF aLancamentos[ nCt ][ 5 ] > 0 
                    DBAppend() 
                    IF netrlock() 
                       Replace CODIGO With nCodigo,; 
                               CODNF_ With nCodNf_,; 
                               VLR___ With aLancamentos[ nCt ][ 5 ],; 
                               CLIENT With nClient,; 
                               CDESCR With cDescri,; 
                               PERC__ With aLancamentos[ nCt ][ 4 ],; 
                               PRAZ__ With aLancamentos[ nCt ][ 6 ],; 
                               VENC__ With aLancamentos[ nCt ][ 7 ],; 
                               QUIT__ With IF( !EMPTY( aLancamentos[ nCt ][ 8 ] ), "S", " " ),; 
                               DTQT__ With aLancamentos[ nCt ][ 8 ],; 
                               BANC__ With aLancamentos[ nCt ][ 9 ],; 
                               OBS___ With alancamentos[ nCt ][ 11 ],; 
                               DATAEM With dDataBase,; 
                               LETRA_ With aLancamentos[ nCt ][ 1 ],; 
                               CHEQ__ With aLancamentos[ nCt ][ 10 ] 
                    ENDIF 
                 ENDIF 
             NEXT 
             IF nQuitado > 0 
                LancaMovimento( DATE(), 0, "CLIENTES", "R", "Ref. baixa Duplicatas", "Nota Fiscal " + StrZero( nCodNf_, 9, 0 ), 0, nQuitado ) 
                LancaSaldos( 0, "CLIENTES", "R", 0, nQuitado ) 
             ENDIF 
          ENDIF 
       ENDIF 
       DBSelectAr( nAreaRes ) 
       DBLeOrdem() 
       DBSelectAr( nArea ) 
       EXIT 
    ENDIF 
    DO CASE 
       CASE nTecla==K_UP         ;oTabNew:up() 
       CASE nTecla==K_LEFT       ;oTabNew:up() 
       CASE nTecla==K_RIGHT      ;oTabNew:down() 
       CASE nTecla==K_DOWN       ;oTabNew:down() 
       CASE nTecla==K_PGUP       ;oTabNew:pageup() 
       CASE nTecla==K_PGDN       ;oTabNew:pagedown() 
       CASE nTecla==K_CTRL_PGUP  ;oTabNew:gotop() 
       CASE nTecla==K_CTRL_PGDN  ;oTabNew:gobottom() 
       CASE nTecla==K_SPACE .OR. nTecla==K_ENTER 
            IF !EMPTY( aLancamentos[ nRow ][ 8 ] ) 
               cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
               Aviso( "Esta duplicata ja esta quitada!" ) 
               Pausa() 
               ScreenRest( cTelaRes ) 
            ELSE 
               dQuitacao:=    DATE() 
               nBanco:=       aLancamentos[ nRow ][ 9 ] 
               cCheque:=      aLancamentos[ nRow ][ 10 ] 
               nValor:=       aLancamentos[ nRow ][ 5 ] 
               cObservacoes:= aLancamentos[ nRow ][ 11 ] 
               SetCursor( 1 ) 
               @ oTabNew:RowPos + 5, 37 Get dQuitacao 
               @ oTabNew:RowPos + 5, 46 Get nBanco      Pict "@E 999" Valid PesqBco( @nBanco ) 
               @ oTabNew:RowPos + 5, 50 Get cCheque     Pict "@S12" 
               @ oTabNew:RowPos + 5, 63 Get nValor      Pict "@E 999,999.99" 
               READ 
               SetCursor( 0 ) 
               aLancamentos[ nRow ][ 8 ]:=    dQuitacao 
               aLancamentos[ nRow ][ 9 ]:=    nBanco 
               aLancamentos[ nRow ][ 10 ]:=   cCheque 
               aLancamentos[ nRow ][ 5 ]:=    nValor 
               aLancamentos[ nRow ][ 11 ]:=   cObservacoes 
               nQuitado:= nQuitado + nValor 
               /* Somando o Total Geral */ 
               nTotal:= 0 
               nQuitado:= 0 
               For nCt:= 1 TO Len( aLancamentos ) 
                   nTotal:= nTotal + aLancamentos[ nCt ][ 5 ] 
                   IF !EMPTY( aLancamentos[ nCt ][ 8 ] ) 
                      nQuitado:= nQuitado + aLancamentos[ nCt ][ 5 ] 
                  ENDIF 
               Next 
               /* Atribui os percentuais */ 
               For nCt:= 1 TO Len( aLancamentos ) 
                   aLancamentos[ nCt ][ 4 ]:= ( alancamentos[ nCt ][ 5 ] / nTotal ) * 100 
               Next 
               /* Refaz */ 
               oTabNew:Down() 
               oTabNew:RefreshAll() 
               WHILE !oTabNew:Stabilize() 
               ENDDO 
            ENDIF 
       OTHERWISE                ;tone(125); tone(300) 
    ENDCASE 
    oTabNew:refreshcurrent() 
    oTabNew:stabilize() 
 ENDDO 
 Set( _SET_DELIMITERS, lDelimiters ) 
 SetColor( cCor ) 
 SetCursor( nCursor ) 
 ScreenRest( cTela ) 
 Return Nil 
 
stat func situacao(pcSITUACAO) 
if pcSITUACAO=" " 
   pcSITUACAO="0" 
elseif ! pcSITUACAO$" 012" 
   return(.f.) 
endif 
return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � TestaValor 
� Finalidade  � Teste no valor da duplicata na baixa da mesma 
� Parametros  � nValor / Juros / VlrDesconto 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TestaValor( nValor_, nJuros_, nVlrDes, nLocal_, dQuit__, nRecebido, nVlrAut ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ), nValorPadrao:= VLR___,; 
      dQuitPadrao:= dQuit__ 
Local nTecla, Getlist:= {} 
nRecebido:= nValor_ 
IF ! nValor_ == VLR___ 
   WHILE .T. 
      Tone( 322, 3 ) 
      Aviso( "Valor a ser baixado nao corresponde ao valor da conta." ) 
      Mensagem( "Digite [TAB]PgtoParcial [ESPACO]ValorPadrao [ESC]Desconto/Acrescimo." ) 
      nTecla:= Inkey(0) 
      DO CASE 
         CASE nTecla==K_SPACE 
              nValor_:=   VLR___ 
              nRecebido:= VLR___ 
              nVlrAut:=   VLR___ 
              ScreenRest( cTela ) 
              Return .T. 
         CASE nTecla==K_ESC 
              IF nValor_ < VLR___ 
                 nVlrDes:= ( VLR___ - nValor_ ) 
                 nValor_:= VLR___ 
                 nVlrAut:=   VLR___ - nVlrDes 
                 nRecebido:= VLR___ - nVlrDes 
              ELSEIF nValor_ > VLR___ 
                 nJuros_:= ( nValor_ - VLR___ ) 
                 nValor_:=   VLR___ 
                 nRecebido:= VLR___ + nJuros_ 
                 nVlrAut:=   VLR___ 
              ENDIF 
              ScreenRest( cTela ) 
              Return .T. 
         CASE nTecla==K_TAB 
              SetColor( _COR_GET_EDICAO ) 
              VPBox( 05, 05, 20, 70, " DUPLICATA COM PAGAMENTO PARCIAL ", _COR_GET_BOX ) 
              @ 07,06 Say "Valor Total: [801] [" + Tran( VLR___, "@E 999,999.99" ) + "]" 
              @ 09,06 Say "Por Conta..: [700] [" + Tran( nValor_, "@E 999,999.99" ) + "]" 
              @ 11,06 Say "Diferenca..: [000] [" + Tran( VLR___ - nValor_, "@E 999,999.99" ) + "]" 
              @ 13,06 Say "Vencimento.: [  /  /  ]" 
              IF nValor_ > VLR___ 
                 Mensagem( "VALOR PARCIAL ESTA MAIOR QUE O VALOR PADRAO." ) 
                 Pausa() 
                 nValor_:= VLR___ 
                 SetColor( cCor ) 
                 SetCursor( nCursor ) 
                 ScreenRest( cTela ) 
                 Return .F. 
              ENDIF 
              dVencim:= VENC__ 
              @ 13,06 Say "Vencimento.:" Get dVencim 
              READ 
              nRegistro:= Recno() 
              FOR nCt:= 1 TO 2 
                  cObs___:= OBS___ 
                  dVenc__:= VENC__ 
                  dQuit__:= dQuit__ 
                  IF nCt == 1 
                     nValor_:= nValor_ 
                     cObs___:= "POR CONTA" 
                     dQuit__:= dQuit__ 
                     dVenc__:= VENC__ 
                     nRecebido:= nValor_ 
                  ELSEIF nCt == 2 
                     nValor_:= VLR___ - nValor_ 
                     cObs___:= "SALDO" 
                     nLocal_:= 0 
                     dVenc__:= dVencim 
                     dQuit__:= CTOD( "  /  /  " ) 
                  ENDIF 
                  cLetra_:= " " 
                  cTipo__:= TIPO__ 
                  nClient:= CLIENT 
                  cDescri:= CDESCR 
                  nCodNf_:= CODNF_ 
                  dDataEm:= DATAEM 
                  nVlr___:= VLR___ 
                  nJuros_:= JUROS_ 
                  nVlrDes:= VLRDES 
                  nPraz__:= ( dVenc__ - dDataEm ) 
                  nBanc__:= BANC__ 
                  cCheq__:= CHEQ__ 
                  cSitu__:= SITU__ 
                  nCodigo:= CODIGO 
                  nTotal:=  NF_->VLRTOT 
                  nVlrICM:= VLRICM 
                  nVlrIPI:= VLRIPI 
                  nVlrISS:= VLRISS 
                  nDupl:=   DUPL__ 
                  nLocal_:= LOCAL_ 
                  nValorInicial:= VLR___ 
                  lQuitada:= IF( EMPTY( dQuit__ ), .F., .T. ) 
                  DBAppend() 
                  IF netrlock() 
                     Repl CLIENT With nClient,; 
                          CDESCR With cDescri,; 
                          CODNF_ With nCodNf_,; 
                          DUPL__ With nDupl,; 
                          CODIGO With nCodigo,; 
                          DATAEM With dDataEm,; 
                          TIPO__ With cTipo__,; 
                          CODNF_ With nCodNf_,; 
                          VLR___ With nValor_,; 
                          JUROS_ With nJuros_,; 
                          VLRDES With nVlrDes,; 
                          PRAZ__ With nPraz__,; 
                          VENC__ With dVenc__,; 
                          QUIT__ With IF( !EMPTY( dQuit__ ), "S", " " ),; 
                          DTQT__ With dQuit__,; 
                          BANC__ With nBanc__,; 
                          OBS___ With cObs___,; 
                          LETRA_ With cLetra_,; 
                          LOCAL_ With nLocal_ 
                  ENDIF 
                  DBGoTo( nRegistro ) 
              NEXT 
              DBGoTo( nRegistro ) 
              nValor_:= nValorPadrao 
              dQuit__:= dQuitPadrao 
              nLocal_:= 801 
              cObs___:= "PARCIAL" 
              Keyboard Chr( K_PGDN ) + Chr( K_ENTER ) 
              SetColor( cCor ) 
              SetCursor( nCursor ) 
              ScreenRest( cTela ) 
              Return .T. 
      ENDCASE 
   ENDDO 
ELSE 
   nVlrAut:= VLR___ 
ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return .T. 
 
 
 
 
 
Static Function BuscaCondicao( nCodCnd, nValorTotal ) 
IF nCodCnd == 0 
ELSE 
   TabelaCondicoes( nValorTotal ) 
   nCodCnd:= CND->CODIGO 
   cCondicao:= ALLTRIM( Str( CND->PARCA_, 3, 0 ) ) 
   FOR nCt:= 66 TO 88 
       IF !CND->( EVAL( FieldBlock( "PARC" + Chr( nCt ) + "_" ) ) ) == 0 
          cCondicao+= "/" + CND->( ALLTRIM( Str( EVAL( FieldBlock( "PARC" + Chr( nCt ) + "_" ) ), 3, 0 ) ) ) 
       ENDIF 
   NEXT 
   cCondicao:= PAD( cCondicao, 30 ) 
ENDIF 
Return .T. 
 
 
 
 
Static Function ComandoSend( cImp, cComando, nSend ) 
IF Driver=="W2000" 
 
   Inkey( 0.01 ) 
   Ret:= Space( 70 ) 
 
   Mensagem( "Armazenando log de execuacao..." ) 
   !COPY COMANDOS.LOG TEMP.TMP >NUL 
   !COPY TEMP.TMP + ENTER.XXX + PARAM.TXT COMANDOS.LOG >NUL 
 
   Mensagem( "Criando arquivo de parametros" ) 
   //// Cria arquivo de parametro 
   F_CriaParam() 
 
 
   mensagem( "Gravando comandos, aguarde..." ) 
   //// Grava comando no arquivo de parametro 
   arqopen:= fopen("param.txt",2) 
   fwrite( arqopen, cComando, Len( cComando ) ) 
   fclose( arqopen ) 
 
 
   mensagem( "Liberando para leitura do PSIG2000..." ) 
   //// Cria arquivo de liberacao para leitura 
   Arq:= FCreate("Ready.ctl",0) 
   Fclose( Arq ) 
 
ELSE 
   ret:=space(70) 
   arqopen:= fopen("SIGFIS",2) 
   fwrite(arqopen,cComando,IF( nSend==Nil, Len(cComando), nSend )) 
   fclose(arqopen) 
ENDIF 
Return Nil 
 
 
 
Static Function F_CriaParam() 
 // No momento da criacao do parametro do comando e nescessario apagar 
 // o arquivo de resposta da operacao anterior 
 Start:=SECONDS() 
 WHILE File("OK.ctl") 
    End:=SECONDS()             // TIME-OUT de 3 segundos 
    If (End)>(Start+5.0) 
       Exit 
    Endif 
    !del OK.ctl 
 ENDDO 
 if file( "OK.CTL"  ) 
    Aviso( "Nao foi possivel apagar o arquivo de controle OK.CTL" ) 
    Pausa() 
 endif 
 // E importante a construcao do laco para garantir que este arquivo 
 // realmente sera apagado, um time-out para nao trancar o sistem tambem 
 
 Arq=FCreate("param.txt",0) // Criando o arquivo de parametros 
 Fclose(Arq)                        // do proximo comando 
 
 Return Nil 
 
 
 
