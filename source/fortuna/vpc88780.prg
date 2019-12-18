// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
#Define _SELECAO   "SELECAO." + StrZero( nCodTra, 03, 00 ) 
#Define _SELGERAL  "PEDSELEC.DBF" 


#ifdef HARBOUR
function vpc88780()
#endif


Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local nCodTra:= 0 
Local nTecla 
Local oTb 
Local nOpcao:= 1 
Local aStr 
Local dData1_:= DATE()-1, dData2_:= DATE(), lImpresso:= .F. 
Local lDelimiters 
 
    VPBox( 00, 00, 22, 79, " SELECAO DE PEDIDOS ", _COR_GET_BOX, .F., .F. ) 
    @ 02,02 Say "Transportadora.:" Get nCodTra Pict "999" Valid BuscaTransport( @nCodTra ) When; 
        Mensagem( "Digite o codigo da transportadora que voce deseja buscar." ) 
    READ 
 
    IF LastKey()==K_ESC 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       Return Nil 
    ENDIF 
 
 
    // Exibe o nome da transportadora 
    IF TRA->( EOF() ) 
       @ 02,26 Say "- [" + PAD( "INDEFINIDA", LEN( TRA->DESCRI ) ) + "]" 
    ELSE 
       @ 02,26 Say "- [" + TRA->DESCRI + "]" 
    ENDIF 
 
    DBSelectAr( 123 ) 
    aStr:= { { "CODPED", "C", 08, 00 },; 
             { "CODCLI", "N", 06, 00 },; 
             { "DESCRI", "C", 45, 00 },; 
             { "DATA__", "D", 08, 00 },; 
             { "HORA__", "C", 06, 00 },; 
             { "CODTRA", "N", 03, 00 }} 
 
    IF File( _SELECAO ) 
       nOpcao:= SWAlerta( "<< SELECAO DE PEDIDOS >>; Ja existem pedidos selecionados para esta transportadora; O que voce deseja fazer?", { "Acrescentar", "Nova Selecao", "Cancelar Operacao" } ) 
       IF nOpcao==2 
          DBCreate( _SELECAO, aStr ) 
       ELSEIF nOpcao==3 
          ScreenRest( cTela ) 
          SetColor( cCor ) 
          SetCursor( nCursor ) 
          Return Nil 
       ENDIF 
    ELSE 
      DBCreate( _SELECAO, aStr ) 
    ENDIF 
 
    DBSelectAr( _COD_PEDIDO ) 
    DBSetOrder( 1 ) 
 
    DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    Use (_SELECAO) Alias SLC 
    IF !Used() 
       Aviso( "Falha ao tentar abrir o arquivo de selecao! Tente mais tarde." ) 
       Pausa() 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       Return Nil 
    ENDIF 
 
    DBGoBottom() 
    IF CODPED=="INFO    " 
       dData1_:= CTOD( SubStr( DESCRI, 1, 08 ) ) 
       dData2_:= CTOD( SubStr( DESCRI, 9, 08 ) ) 
       IF NetRlock() 
          DBDelete() 
       ENDIF 
    ELSE 
      dData1_:= DATE() -3 
      dData2_:= DATE() +1 
    ENDIF 
 
    @ 03,02 Say "Data Emissao...:" Get dData1_ 
    @ 03,30 Say "Ate:" Get dData2_ 
    READ 
 
    lDelimiters:= SET( _SET_DELIMITERS, .F. ) 
    DBGoTop() 
 
    SetColor( _COR_BROWSE ) 
    oTb:= TBrowseDB( 05, 01, 21, 78 ) 
    oTb:AddColumn( TbColumnNew("Numero   Cliente                                                           ",; 
                   {|| CODPED + " " + StrZero( CODCLI, 6, 0 ) + " " + DESCRI + Space( 30 ) } ) ) 
    oTb:AUTOLITE:=.F. 
    oTb:dehilite() 
    While .T. 
        oTb:ColorRect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
        WHILE NextKey()=0 .AND. !oTb:Stabilize() 
        ENDDO 
        nTECLA:=inkey(0) 
        If nTECLA=K_ESC 
           Exit 
        EndIf 
        do case 
           case nTECLA==K_UP         ;oTb:up() 
           case nTECLA==K_DOWN       ;oTb:down() 
           case nTECLA==K_PGUP       ;oTb:pageup() 
           case nTECLA==K_PGDN       ;oTb:pagedown() 
           case nTECLA==K_HOME       ;oTb:gotop() 
           case nTECLA==K_END        ;oTb:gobottom() 
           case nTecla==K_F12        ;Calculador() 
           CASE nTecla==K_CTRL_F10   ;Calendar() 
           case nTecla==K_DEL 
                IF Confirma( 0, 0, "Excluir item da relacao?" ) 
                   IF NetRLock() 
                      DBDelete() 
                   ENDIF 
                ENDIF 
                oTb:RefreshAll() 
                WHILE !oTb:Stabilize() 
                ENDDO 
 
           Case nTecla==K_INS 
                nCodPed:= 0 
                DBAppend() 
                oTb:GoBottom() 
                oTb:RefreshAll() 
                WHILE !oTb:Stabilize() 
                ENDDO 
 
                PED->( DBSetOrder( 6 ) ) 
                lIncluir:= .F. 
                WHILE !lIncluir 
                   oTb:GoBottom() 
                   oTb:RefreshAll() 
                   WHILE !oTb:Stabilize() 
                   ENDDO 
                   @ ROW(), 01 Get nCodPed Pict "99999999" 
                   READ 
                   cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                   IF LastKey()==K_ESC 
                      EXIT 
                   ENDIF 
                   IF PED->( DBSeek( StrZero( nCodPed, 08, 00 ) ) ) 
                      IF PED->DATA__ >= dData1_ .AND. PED->DATA__ <= dData2_ 
                         nReg:= RECNO() 
                         DBGoTop() 
                         lIncluir:= .T. 
                         WHILE !EOF() 
                             IF CODPED==StrZero( nCodPed, 8, 0 ) 
                                IF SWAlerta( "<< DUPLICIDADE DE INFORMACOES >>;Ja existe este pedido selecionado.; O que voce deseja fazer?", { "Incluir Novamente", "NÆo incluir" } )==2 
                                   lIncluir:= .F. 
                                   DBGoTo( nReg ) 
                                   oTb:RefreshAll() 
                                   WHILE !oTb:Stabilize() 
                                   ENDDO 
                                ELSE 
                                   lIncluir:= .T. 
                                ENDIF 
                                EXIT 
                             ENDIF 
                             DBSkip() 
                         ENDDO 
                         DBGoTo( nReg ) 
                      ELSE 
                         Aviso( "Pedido nÆo foi gravado neste periodo." ) 
                         Pausa() 
                         lIncluir:= .F. 
                      ENDIF 
                   ELSE 
                      Aviso( "Pedido invalido ou inexistente." ) 
                      Pausa() 
                      lIncluir:= .F. 
                   ENDIF 
                   ScreenRest( cTelaRes ) 
                ENDDO 
 
                IF !LastKey()==K_ESC .AND. PED->( DBSeek( StrZero( nCodPed, 8, 0 ) ) ) 
                   IF NetRLock() 
                      Replace DESCRI With PED->DESCRI,; 
                              CODPED With PED->CODPED,; 
                              CODCLI With PED->CODCLI 
                   ENDIF 
                   Keyboard Chr( K_INS ) 
                ELSE 
                   IF NetRLock() 
                      DBDelete() 
                   ENDIF 
                ENDIF 
                oTb:RefreshAll() 
                WHILE !oTb:Stabilize() 
                ENDDO 
 
           Case nTecla==K_ENTER 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                cCodPed:= CODPED 
                IF PED->( DBSeek( cCodPed ) ) 
                   VPBox( 05, 01, 21, 78, "INFORMACOES ADICIONAIS", _COR_GET_BOX, .F., .F. ) 
                   @ 07, 02 Say "Observacoes" Color _COR_GET_BOX 
                   @ 08, 02 Say PED->OBSER1   Color _COR_GET_CURSOR 
                   @ 09, 02 Say PED->OBSER2   Color _COR_GET_CURSOR 
                   @ 11, 02 Say "Vendedores"  Color _COR_GET_BOX 
                   @ 12, 02 Say "Interno: "   Color _COR_GET_BOX 
                   @ 13, 02 Say "Externo: "   Color _COR_GET_BOX 
                   @ 12, 02 Say Str( PED->VENIN_, 03, 00 ) + " - " + PED->VENDE1 Color _COR_GET_CURSOR 
                   @ 13, 02 Say Str( PED->VENEX_, 03, 00 ) + " - " + PED->VENDE2 Color _COR_GET_CURSOR 
                   @ 15, 02 Say "Cliente"   Color _COR_GET_BOX 
                   @ 16, 02 Say PED->DESCRI Color _COR_GET_CURSOR 
                   @ 17, 02 Say PED->ENDERE Color _COR_GET_CURSOR 
                   @ 18, 02 Say PED->BAIRRO Color _COR_GET_CURSOR 
                   @ 19, 02 Say PED->CIDADE + "-" + PED->ESTADO   Color _COR_GET_CURSOR 
                   @ 20, 02 Say PED->FONFAX Color _COR_GET_CURSOR 
                   @ 19, 38 Say "Comprador" Color _COR_GET_BOX 
                   @ 20, 38 Say PED->COMPRA Color _COR_GET_CURSOR 
                ENDIF 
                Mensagem( "Pressione [ENTER] para continuar." ) 
                Pausa() 
                ScreenRest( cTelaRes ) 
 
           Case nTecla==K_TAB 
                nReg:= RECNO() 
                IF Confirma( 00, 00,; 
                   "Confirma a impressao para entrega?",; 
                   "Digite [S] para confirmar ou [N] p/ cancelar.", "N" ) 
                   PED->( DBSetOrder( 6 ) ) 
                   DBGoTop() 
                   lImpresso:= Relatorio( "PEDTR" + StrZero( nCodTra, 03, 0 ) + ".REP" ) 
                   EXIT 
                ENDIF 
                DBGoTo( nReg ) 
 
           case nTecla == K_F2; DBMudaOrdem( 1, oTb ) 
           case nTecla == K_F3; DBMudaOrdem( 2, oTb ) 
           otherwise                ;tone(125); tone(300) 
        endcase 
        oTb:Refreshcurrent() 
        oTb:Stabilize() 
    enddo 
    Set( _SET_DELIMITERS, lDelimiters ) 
    IF Used() 
       DBAppend() 
       Replace CODPED With "INFO    ",; 
               DESCRI With DTOC( dData1_ ) + DTOC( dData2_ ) 
    ENDIF 
    IF lImpresso 
       SLC->( DBGoTop() ) 
       WHILE !SLC->( EOF() ) 
          IF SLC->( NetRLock() ) 
             Replace SLC->HORA__ With TIME(),; 
                     SLC->DATA__ With DATE(),; 
                     SLC->CODTRA With nCodTra 
          ENDIF 
          SLC->( DBSkip() ) 
       ENDDO 
       DBSelectAr( 123 ) 
       IF !FILE( GDir - "\" -  _SELGERAL ) 
          dbCreate( GDir - "\" - _SELGERAL, aStr ) 
       ENDIF 
       cArq:= GDir - "\" - _SELGERAL 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       Use &cArq Alias GER 
       Append From (_SELECAO) 
       dbCloseArea() 
       FErase( _SELECAO ) 
    ENDIF 
    DBSelectAr( 123 ) 
    DBCloseArea() 
    DBSelectAR( 1 ) 
    SetColor(cCOR) 
    SetCursor(nCURSOR) 
    Screenrest(cTELA) 
    DBUnLockAll() 
    return(.T.) 
 
 
Function VisualSelPedido() 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local oTb, nTecla 
 
  IF !FILE( GDir - "\" -  _SELGERAL ) 
     Aviso( "Nunca foi realizada nenhuma selecao de pedidos." ) 
     Pausa() 
     ScreenRest( cTela ) 
  ENDIF 
  TRA->( DBSetOrder( 1 ) ) 
  cArq:= GDir - "\" - _SELGERAL 
 
  DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Use &cArq Alias GER 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  INDEX ON DTOS( DATA__ ) + HORA__ TO IND001 FOR Processo() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  INDEX ON DTOS( DATA__ ) + HORA__ TO IND002 FOR ALLTRIM( CODPED )=="INFO" .AND. Processo() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  INDEX ON CODPED TO IND003 FOR !ALLTRIM( CODPED )=="INFO" .AND. Processo() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  INDEX ON DESCRI TO IND004 FOR !ALLTRIM( CODPED )=="INFO" .AND. Processo() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To IND001, IND002, IND003, IND004 
  Set Relation TO CODTRA Into TRA 
 
  DBSetOrder( 2 ) 
  DBGoTop() 
 
  SetColor( _COR_BROWSE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
 
  Mensagem( "[F2..F5]Ordem [A..Z]Pesquisa [TAB]Imprime [CTRL+TAB]Resumo [ESC]Sair" ) 
  Ajuda( "[" + _SETAS + "][PgDn][PgUp]Movimenta [TAB]Imprime [CTRL+TAB]Sintetico" ) 
 
  VPBox( 0, 0, 22, 79, "VISUALIZACAO DE SELECOES REALIZADAS", _COR_BROW_BOX, .F., .F. ) 
  oTb:= TBrowseDB( 01, 01, 21, 78 ) 
  oTb:AddColumn( TbColumnNew(,; 
                 {|| PAD( IF( CODPED=="INFO    ", TRA->DESCRI + " " + DTOC( DATA__ ) + " " + LEFT( HORA__, 5 ),; 
                     Space( 10 ) + CODPED + " " + DESCRI ), 80 ) } ) ) 
  oTb:AUTOLITE:=.F. 
  oTb:dehilite() 
  While .T. 
      oTb:ColorRect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
      WHILE NextKey()=0 .AND. !oTb:Stabilize() 
      ENDDO 
      nTECLA:= inkey(0) 
      If nTECLA=K_ESC 
         Exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTb:up() 
         case nTecla==K_DOWN       ;oTb:down() 
         case nTecla==K_PGUP       ;oTb:pageup() 
         case nTecla==K_PGDN       ;oTb:pagedown() 
         case nTecla==K_HOME .OR.; 
              nTecla==K_CTRL_PGUP      ;oTb:gotop() 
         case nTecla==K_END .OR.; 
              nTecla==K_CTRL_PGDN       ;oTb:gobottom() 
         case nTecla==K_F12        ;Calculador() 
         case nTecla==K_F2; DBMudaOrdem( 1, oTb ) 
         case nTecla==K_F3; DBMudaOrdem( 2, oTb ) 
         case nTecla==K_F4; DBMudaOrdem( 3, oTb ) 
         case nTecla==K_F5; DBMudaOrdem( 4, oTb ) 
         case DBPesquisa( nTecla, oTb ) 
         case nTecla==K_DEL 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              IF IndexOrd()==2 .AND. ALLTRIM( CODPED )=="INFO" 
                 Aviso( "Nao e permitido excluir este registro neste modo de exibicao." ) 
                 Pausa() 
 
              ELSEIF IndexOrd()==1 .AND. ALLTRIM( CODPED )=="INFO" 
                 Aviso( "Esta exclusao deve eliminar todos os registros desta selecao!" ) 
                 Pausa() 
                 Set Deleted Off   /* Desabilita a exclusao p/ exibir os registros */ 
                 IF Exclui( oTb ) 
                    oTb:up() 
                    otb:RefreshAll() 
                    WHILE !oTB:Stabilize() 
                    ENDDO 
                    nReg:= 0 
                    WHILE !GER->( BOF() ) .AND. !Alltrim( GER->CODPED )=="INFO" 
                       IF GER->( NetRLock() ) 
                          GER->( DBDelete() ) 
                       ENDIF 
                       GER->( DBSkip( -1 ) ) 
                       IF ++nReg > 100  /* Evitar travamentos por falta de registro */ 
                          EXIT 
                       ENDIF 
                    ENDDO 
                    /* Bloqueia o arquivo e elimina os registros */ 
                    GER->( FLock() ) 
                    IF !GER->( NetErr() ) 
                       PACK 
                    ENDIF 
                    DBUnlockAll() 
                 ENDIF 
                 Set Deleted On 
 
              ELSEIF Exclui( oTb ) 
                 FLock() 
                 IF !NetErr() 
                    PACK 
                 ENDIF 
                 DBUnlockAll() 
              ENDIF 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
 
         case nTecla==K_CTRL_TAB 
              Relatorio( "SELEC02.REP" ) 
 
         case nTecla==K_TAB .OR. nTecla==K_CTRL_F1 
 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              dDataIni:= DATE() 
              dDataFim:= DATE() 
              Mensagem( "Selecione o periodo que deseja imprimir...." ) 
              VPBox( 15, 30, 19, 70, " Relacao de Selecoes Realizadas ", _COR_GET_BOX ) 
              cCorRes:= SetColor( _COR_GET_EDICAO ) 
              @ 17,32 Say "Periodo Entre:" Get dDataIni 
              @ 17,55 Say " e" Get dDataFim 
              READ 
              IF !LastKey()==K_ESC 
                 VPBox( 02, 30, 14, 70, " TRANSPORTADORA ", _COR_GET_BOX ) 
                 nCodTr1:= 0 
                 nCodTr2:= 0 
                 nCodTr3:= 0 
                 nCodTr4:= 0 
                 nCodTr5:= 0 
                 nCodTr6:= 0 
                 nCodTr7:= 0 
                 nCodTr8:= 0 
                 nCodTr9:= 0 
 
                 SetColor( _COR_GET_EDICAO ) 
                 VPBox( 15, 30, 19, 70, " Relacao de Selecoes Realizadas ", _COR_GET_BOX ) 
                 @ 17,32 Say "Periodo Entre: [" + DTOC(  dDataIni ) + "]" 
                 @ 17,57 Say " [" + DTOC( dDataFim ) + "]" 
                 @ 04,32 Say "1Ä" Get nCodTr1 Pict "@R 999" 
                 @ 05,32 Say "2Ä" Get nCodTr2 Pict "@R 999" 
                 @ 06,32 Say "3Ä" Get nCodTr3 Pict "@R 999" 
                 @ 07,32 Say "4Ä" Get nCodTr4 Pict "@R 999" 
                 @ 08,32 Say "5Ä" Get nCodTr5 Pict "@R 999" 
                 @ 09,32 Say "6Ä" Get nCodTr6 Pict "@R 999" 
                 @ 10,32 Say "7Ä" Get nCodTr7 Pict "@R 999" 
                 @ 11,32 Say "8Ä" Get nCodTr8 Pict "@R 999" 
                 @ 12,32 Say "9Ä" Get nCodTr9 Pict "@R 999" 
                 READ 
 
                 Priv aTransp:= { nCodTr1, nCodTr2, nCodTr3, nCodTr4,; 
                                  nCodTr5, nCodTr6, nCodTr7, nCodTr8,; 
                                  nCodTr9 } 
 
                 ScreenRest( cTelaRes ) 
                 SetColor( cCorRes ) 
                 IF !LastKey()==K_ESC 
                    IF nTecla==K_CTRL_F1 
                       Relatorio( "RELPEDS.REP" ) 
                    ELSEIF nTecla==K_TAB 
                       Relatorio( "SELEC01.REP" ) 
                    ENDIF 
                 ENDIF 
 
              ENDIF 
              ScreenRest( cTelaRes ) 
              SetColor( cCorRes ) 
 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:Refreshcurrent() 
      oTb:Stabilize() 
  enddo 
  DBSelectAr( 123 ) 
  DBCloseArea() 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  Return Nil 
 
 
 
