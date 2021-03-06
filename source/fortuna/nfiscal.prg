// ## CL2HB.EXE - Converted
/*============================================================================ 
 
                          PROCESSAMENTO & GRAVACAO DE NOTA FISCAL AUTOMATICA 
 
=============================================================================*/ 

/* 
* Modulo      - nFiscal 
* Descricao   - Cadastro de Notas Fiscais 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "formatos.ch" 
#include "vpf.ch" 
#include "inkey.ch" 
#include "box.ch" 
#Include "NF.CH" 

#ifdef HARBOUR
function nfiscal()
#endif

 
Para cPedido 
Local nArea:= Select(), nOrdem:= IndexOrd(), nRegistro:= RECNO() 
loca cTELA:=zoom(11,34,13,51), cCOR:=setcolor(), nOPCAO:=0 
vpbox(11,34,13,51) 
NFInc( cPedido ) 
limpavar() 
unzoom(cTELA) 
setcolor(cCOR) 
/* Restaurar Situacao Anterior do Arquivo */ 
IF nArea <> Nil 
   IF nArea > 0 
      DBSelectAr( nArea ) 
      IF Used() 
         IF nOrdem <> Nil 
            IF nOrdem > 0 
               DBSetOrder( nOrdem ) 
            ENDIF 
         ENDIF 
         DBGoTo( nRegistro ) 
      ENDIF 
   ENDIF 
ENDIF 
 
return(nil) 
 
 
 
 
 
/* 
* Modulo      - NFINC 
* Finalidade  - Efetuar a inclusao de notas fiscais com base nos pedidos. 
* Programador - Valmor Pereira Flores. 
* Data        - 20/Outubro/1994. 
* Atualizacao - 
*/ 
Function NFInc( cCodigoPedido, lNotaManual ) 
  Local lDelimiters:= SET( _SET_DELIMITERS ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local aNFiscal:= { "", {}, {}, {}, {}, {}, {}, {}, {}, {,{}}, {}, {}, {} } 
  Local nRow, oTab, nTecla, lRefaz:= .F. 
  Local TECLA:= 0 
  Local lUltimaFazTempo 
  Local nPos 
  Local lSemCabecalho:= .F. 
  Local cVerMon:="N", cTipoNf:="U", nNUMERO:=0, lFLAGC:=.T.,; 
        lObservacoes:=.F., lFLAGM:=.F., nCLIENT:=0, cDESCRI:=spac(45),; 
        cEndere:=spac(35), cBairro:=spac(25), cCOBRAN:=spac(30),; 
        cCIDADE:=spac(30), cESTADO:=spac(2), cCODCEP:=spac(8),; 
        cCGCMF_:=spac(14), cINSCRI:=spac(12), nPEDIDO:=0, nVltPro:= 0,; 
        dDATAEM:=date(), nVENIN_:=0, nVENEX_:=0, nMONTA_:=0, nVLRNOT:=0,; 
        nVLRTOT:=0, nBASICM:=0, nVLRIPI:=0, nVLRICM:=0, nNVEZES:=0,; 
        cCONDIC:="S", cCONREV:="I", nFRETE_:=0, nDespesas:= 0, nSEGURO:=0, nDESTOT:=0,; 
        cPRODIG:="S", cORDEMC:="S", nNATOPE:=0,; 
        aORDEMC:= { spac(10), spac(10), spac(10), spac(10), spac(10), spac(10) },; 
        nTRANSP:=0, cTDESCR:=spac(20), cTFONE_:=spac(10),; 
        cVIATRA:="Rodoviario          ", nPESOLI:=0,; 
        nPESOBR:=0, aProdutos:={}, cUNIDAD:=spac(2), nICMCOD:=0, nIPICOD:=0,; 
        nCLAFIS:=0, nQTDPRO:=0, nVLRPRO:=0, nPERIPI:=0,; 
        nICMPER:=0, nVLPIPI:=0, cCLASSE:="", cMARCA_:=spac(8),; 
        cQUANT_:=spac(10), cHORA__:=spac(6), cESPEC_:=spac(8),; 
        cOBSER1:=spac(60), cOBSER2:=spac(60),; 
        cOBSER3:=spac(60), cOBSER4:=spac(60), cOBSER5:=spac(60),; 
        dDATAS_:=ctod("  /  /  "), nITEM:=0, cDESPRO:=spac(40),; 
        cCODFAB:=spac(12), cTELAG, nCOMIVT:=0, nCOMIVR:=0, nCOMIVP:=0,; 
        nCOMIVV:=0, lFLAG10:=.T., cDP:="",; 
        nDupl_A:=nDUPL_B:=nDUPL_C:=nDUPL_D:=0,; 
        nPERC_A:=nPERC_B:=nPERC_C:=nPERC_D:=0,; 
        nVLR__A:=nVLR__B:=nVLR__C:=nVLR__D:=0,; 
        nPRAZ_A:=nPRAZ_B:=nPRAZ_C:=nPRAZ_D:=0,; 
        dDTQT_A:=dDTQT_B:=dDTQT_C:=dDTQT_D:=ctod("  /  /  "),; 
        dVENC_A:=dVENC_B:=dVENC_C:=dVENC_D:=date(),; 
        cQUIT_A:=cQUIT_B:=cQUIT_C:=cQUIT_D:=spac(1),; 
        nBANC_A:=nBANC_B:=nBANC_C:=nBANC_D:=0,; 
        cCHEQ_A:=cCHEQ_B:=cCHEQ_C:=cCHEQ_D:=spac(15),; 
        cOBS__A:=cOBS__B:=cOBS__C:=cOBS__D:=spac(30),; 
        cMPRIMA:="*", cISIGLA:=cESIGLA:=cMSIGLA:=spac(2),; 
        nICVV__:=0, nECVV__:=0, nMCVV__:=0, nICVP__:=0, nECVP__:=0,; 
        nMCVP__:=0, nIBASEV:=0, nEBASEV:=0, nMBASEV:=0, nIBASEP:=0,; 
        nEBASEP:=0, nMBASEP:=0, nIVLRVV:=0, nEVLRVV:=0, nMVLRVV:=0,; 
        nIVLRVP:=0, nEVLRVP:=0, nMVLRVP:=0, cCODIGO:=spac(12),; 
        cDESCOD:=spac(40), nORDEMG:=1, nCODPRO:=0, cPlaca_:=space(08),; 
        nCODIGO:=0, aTELA1, aTELA, cPedido,; 
        nSitT01:= 0, nSitT02:= 0, lAutoPreenche:= .F. 
 
  IF lNotaManual==Nil 
     lNotaManual:= .F. 
  ENDIF 
 
  IF cPedido==Nil 
     cPedido:= Spac( 25 ) 
  ENDIF 
 
  IF cCodigoPedido <> Nil 
     IF Upper( Left( cCodigoPedido, 1 ) ) == "A" 
        cCodigoPedido:= SubStr( cCodigoPedido, 2, Len( cCodigoPedido ) ) 
        lAutoPreenche:= .T. 
        lNotaManual:= .F. 
        //lOk:= .F. 
     ELSEIF Upper( Left( cCodigoPedido, 1 ) ) == "E" ///////// BAIXA DE PEDIDO (AUTOM�TICA) 
        cCodigoPedido:= SubStr( cCodigoPedido, 2, Len( cCodigoPedido ) ) 
        lAutoPreenche:= .T. 
        lNotaManual:= .F. 
        lSemCabecalho:= .T. 
        //lOk:= .F. 
     ENDIF 
  ENDIF 
 
 
  IF lNotaManual 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     UserModulo( "Nota Fiscal Manual" ) 
  ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     UserModulo(" Nota Fiscal Por Pedido ") 
  ENDIF 
 
  IF !AbreGrupo( "NOTA_FISCAL" ) 
     RETURN NIL 
  ENDIF 
  SetCursor( 1 ) 
  SetColor( Cor[16] ) 
  Scroll( 01, 01, 24-2, 79-1 ) 
  VPBox( 1, 0, 24 - 2, 79,, Cor[16], .F., .F., Cor[15] ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Opcao [ESC]Cancela") 
  DBSelectAr( _COD_NFISCAL ) 
  DBSetOrder( 1 ) 
  DBSeek( 999999 ) 
  DBSkip( -1 ) 
  IF NF_->TIPONF==" " .AND. NF_->( LastRec() ) > 5 
     IF NF_->NUMERO > 2 
        DBSelectAr( 123 ) 
        DBCloseArea() 
        DBSelectAr( _COD_NFISCAL ) 
        Aviso( "Falha na ultima nota gravada! Nota Fiscal N�" + ALLTRIM( Str( NF_->NUMERO, 9, 0 ) ) + " - Informacoes Incompletas.", .T. ) 
        ScreenRest( cTela ) 
        Return Nil 
     ENDIF 
  ENDIF 
  nNumero:= NUMERO + 1
  IF nNumero <= 2 .AND. NF_->( LastRec() ) > 5
     IF SWAlerta( "<<< VERIFICADOR DE INTEGRIDADE >>>;A proxima nota a ser gravada; tera o numero " + StrZero( nNumero, 9, 0 ) + "," + ;
                  "portanto necessitamos que voce ;verifique se este dado;" + ;
                  "esta correto no seu sistema.", { " Aceitar ", " Corrigir " } )==2

         SetColor( cCor )
         ScreenRest( cTela )
         Return Nil
     ENDIF
  ENDIF
  SetCursor( 1 ) 
  SetColor( COR[16] + "," + COR[18] + ",,," + COR[17] ) 
  dbselectar(_COD_NFISCAL) 
  aOpcoes:= { { " Lista de Pedidos          ", 1 },; 
              { " Operacao                  ", 12 },; 
              { " Dados do Cliente          ", 2 },; 
              { " Cabecalho da Nota Fiscal  ", 3 },; 
              { " Transportadora            ", 4 },; 
              { " Produtos                  ", 5 },; 
              { " Servicos                  ", 11 },; 
              { " Comissoes                 ", 6 },; 
              { " Impostos (ICM/IPI/ISS/IRR)", 7 },; 
              { " Informacoes diversas      ", 8 },; 
              { " Fatura                    ", 9 },; 
              { " Grava                     ", 10 } } 
 
  IF lNotaManual 
     cPedido:= Nil 
     IF !lAutoPreenche 
        Keyboard Chr( K_DOWN ) 
     ENDIF 
     TECLA:= K_DOWN 
     aOpcoes[ 1 ][ 1 ]:= "*"+SubStr( aOpcoes[ 1 ][ 1 ], 2 ) 
 
     SelPedido( aNFiscal, Nil ) 
 
     lOK:= .T. 
  ELSE 
 
     // Apaga item 12 da lista de opcoes ///////////////////////////////// 
     nPos:= ASCAN( aOpcoes, {|x| x[ 2 ]==12 } ) 
     ADEL( aOpcoes, nPos ) 
     ASIZE( aOpcoes, LEN( aOpcoes )-1 ) 
     ///////////////////////////////////////////////////////////////////// 
 
     IF cPedido==Space( 25 ) 
        IF cCodigoPedido==Nil 
           cCodigoPedido:= "" 
        ENDIF 
        IF !lAutoPreenche 
           Keyboard Chr( K_ENTER ) + cCodigoPedido  
	   /* Quando entrar no modulo ja acessar a primeira opcao */ 
        ENDIF 
        lOk:= .F. 
     ENDIF 
  ENDIF 
 
  /// Informacoes 
  nRow:= 1 
  nOpcao:= 1 
 
  IF lAutoPreenche 
     IF .NOT. lSemCabecalho 
        /* Quando entrar no modulo ja acessar a primeira opcao */ 
        Keyboard Chr( K_ENTER ) + cCodigoPedido + Chr( K_ENTER ) + ; 
              Chr( K_DOWN ) + CHR( K_DOWN ) + CHR( K_DOWN ) + ; 
              Chr( K_DOWN ) + CHR( K_DOWN ) + CHR( K_DOWN ) + ; 
              CHR( K_DOWN ) + CHR( K_DOWN ) + CHR( K_DOWN ) + CHR( K_DOWN ) + ; 
              CHR( K_ENTER ) + Repl( CHR( K_PGDN ), 10 ) + Chr( K_ENTER ) 
     ELSEIF lSemCabecalho 
        // lSemCabecalho=.T. significa que � uma baixa de pedido 
        nOpcao:= Len( aOpcoes )-1 
 
        Keyboard Chr( K_ENTER ) 
        inkey(0) 
 
        // Selecionar Pedido 
        SelPedido( @aNFiscal, cCodigoPedido, aOpcoes ) 
 
        // Detalhamento de parcelas 
        ParcelasExpande( aNFiscal ) 
 
        // Numero baseado no numero do pedido 
        nNumero:= val( "9" + StrZero( VAL( cCodigoPedido ), 8, 0 ) ) 
 
        // Grava a nota fiscal Especial 
        Gravacao( aNFiscal, nNumero, .T. ) 
 
        Return Nil 
 
        lOk:= .T. 
 
     ENDIF 
  ENDIF 
  SetColor( "15/04, 00/14" ) 
  VPBoxSombra( 02, 01, 19, 29,, "15/04", "00/01" ) 
  oTAB:=tbrowsenew(03,02,18,28) 
  oTAB:addcolumn(tbcolumnnew(,{|| aOpcoes[nROW][1] })) 
  oTAB:AUTOLITE:=.f. 
  oTAB:GOTOPBLOCK :={|| nROW:=1} 
  oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aOpcoes)} 
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aOpcoes,@nROW)} 
  oTAB:dehilite() 
  Set( _SET_DELIMITERS, .F. ) 
  WHILE .T. 
     WHILE .T. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      WHILE nextkey()==0 .and. ! oTAB:stabilize() 
      ENDDO 
 
      IF lOk 
         lMouseStatus:= MouseStatus() 
         DesligaMouse() 
         /* Numero da Nota Fiscal */ 
         aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ]:= nNumero 
         CalculoImposto( aNFiscal ) 
         IF !lSemCabecalho 
            DisplayDados( aNFiscal, aOpcoes[ nRow ][ 2 ] ) 
         ENDIF 
         LigaMouse( lMouseStatus ) 
      ENDIF 
 
 
      IF lAutoPreenche 
         /// 
         /// Realizacao de auto-preenchimento das informacoes para gravacao da nota fiscal 
         /// By Valmor em 02/12/2002 
         /// 
      ELSE 
         /* Pula itens que iniciam em "*" */ 
         IF Left( aOpcoes[ nRow ][ 1 ], 1 )=="*" 
            IF nRow==1 
               Keyboard Chr( K_DOWN ) 
            ELSE 
               Keyboard CHR( TECLA ) 
            ENDIF 
         ENDIF 
      ENDIF 
 
      TECLA:= Inkey(0) 
      IF TECLA==K_ESC 
         nOpcao:= 0 
         exit 
      ENDIF 
      cTelaG:= ScreenSave( 0, 0, 24, 79 ) 
      DO CASE 
         CASE TECLA==K_UP         ;oTAB:up() 
         CASE TECLA==K_DOWN       ;oTAB:down() 
         CASE TECLA==K_LEFT       ;oTAB:up() 
         CASE TECLA==K_RIGHT      ;oTAB:down() 
         CASE TECLA==K_PGUP       ;oTAB:pageup() 
         CASE TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
         CASE TECLA==K_PGDN       ;oTAB:pagedown() 
         CASE TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
         CASE TECLA==K_F12        ;Calculador() 
         CASE TECLA==K_CTRL_F10   ;Calendar() 
         CASE TECLA==K_ENTER 
              //IF lAutoPreenche 
              //   lOk:= .T. 
              //ENDIF 
              IF !lOk 
                 oTab:GoTop() 
                 oTab:RefreshAll() 
                 WHILE !oTab:Stabilize() 
                 ENDDO 
                 nOpcao:= 1 
              ELSE 
                 nOpcao:= IF( !lOk, 1, aOpcoes[ nRow ][ 2 ] ) 
              ENDIF 
              EXIT 
         OTHERWISE                ;tone(125); tone(300) 
      ENDCASE 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   ENDDO 
     cTela100:= ScreenSave( 1, 0, 24, 79 ) 
     DO CASE 
        CASE nOpcao==1 
             VPBoxSombra( 02, 31, 04, 77,, "15/04", "00/01" ) 
             lEditar:= .T. 
             IF !( cPedido == SPACE( 25 ) ) 
                VPBoxSombra( 02, 31, 06, 77,, "15/04", "00/01" ) 
                @ 03,33 SAY "Este dado j� foi informado caso voc�  altere" 
                @ 04,33 SAY "esta informa��o os dados da N. Fiscal  ser�o" 
                @ 05,33 SAY "Duplicados.                                 " 
                INKEY(0) 
                EXIT 
                Scroll( 02, 31, 06, 77 ) 
                IF LastKey()==K_ENTER 
                   lEditar:= .T. 
                ELSE 
                   lEditar:= .F. 
                ENDIF 
             ENDIF 
             IF lEditar 
 
                @ 03,33 Say "Pedido(s):" Get cPedido VALID ; 
                   SelPedido( aNFiscal, @cPedido, aOpcoes ) When Mensagem( "Digite o N� dos pedidos de um mesmo cliente [ENTER]Busca." ) 
                READ 
 
 
                IF LastKey()==K_ESC 
                   EXIT 
                ENDIF 
 
                lOk:= PedidoAceito() 
 
                lUltimaFazTempo:= .F. 
                Cli->( DBSetOrder( 1 ) ) 
                IF Cli->( DBSeek( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ] ) ) 
                   /* Verifica Limite de Credito */ 
                   IF CLI->LIMCR_ > 0 .AND. aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] > CLI->SALDO_ 
                      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                      Aviso( "Cliente bloqueado! Saldo de credito baixo." ) 
                      Pausa() 
                      ScreenRest( cTelaRes ) 
                      lOk:= .F. 
                      EXIT 
                   ELSEIF CLI->LIMCR_ > 0 .AND. CLI->VALID_ < DATE() 
                      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                      Aviso( "Cliente bloqueado! Data Limite de Credito Expirada." ) 
                      Pausa() 
                      ScreenRest( cTelaRes ) 
                      lOk:= .F. 
                      EXIT 
                   ENDIF 
 
                   IF !lAutoPreenche 
                      /* Verifica se data da ultima nota de 
                         venda p/ cliente � maior que <n> dias */ 
                      IF SWSet( _NFA_DIAS ) > 0 
                         DPA->( DBSetOrder( 5 ) ) 
                         IF DPA->( DBSeek( CLI->CODIGO ) ) 
                            WHILE ( DPA->CLIENT==CLI->CODIGO ) .AND. !DPA->( EOF() ) 
                                DPA->( DBSkip() ) 
                            ENDDO 
                            IF !EOF() 
                               DPA->( DBSkip( -1 ) ) 
                               IF ( DATE() - DPA->DATAEM ) > SWSet( _NFA_DIAS ) 
                                  IF SWAlerta( "Atencao! ultima Duplicata p/ este cliente foi a " + Alltrim( Str( DATE() - DPA->DATAEM, 10, 0 ) ) + " dias", { "Cancelar", "Confirmar" } )==1 
                                     lUltimaFazTempo:= .T. 
                                     lOk:= .F. 
                                  ENDIF 
                              ENDIF 
                            ENDIF 
                         ELSE 
                            cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                            Aviso( "Nunca houve fatura para este cliente!" ) 
                            Pausa() 
                            ScreenRest( cTelaRes ) 
                         ENDIF 
                      ENDIF 
                   ENDIF 
 
                ENDIF 
                IF lUltimaFazTempo 
                   EXIT 
                ENDIF 
 
                IF Lastkey() == K_ESC 
                   lOk:= .F. 
                ENDIF 
             ENDIF 
             lRefaz:= .T. 
 
        CASE nOpcao==12 
 
             EditDados( aNFiscal, 12, lNotaManual, aOpcoes ) 
             lRefaz:= .T. 
 
        CASE nOpcao==2 
             EditDados( aNFiscal, 2, lNotaManual ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
        CASE nOpcao==3 
             EditDados( aNFiscal, 3, lNotaManual  ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
        CASE nOpcao==4 
             EditDados( aNFiscal, 4, lNotaManual  ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
 
        CASE nOpcao==5 
             EditDados( aNFiscal, 5, lNotaManual  ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
        CASE nOpcao==11 
             EditDados( aNFiscal, 11, lNotaManual  ) 
 
        CASE nOpcao==6 
             EditDados( aNFiscal, 6, lNotaManual  ) 
 
        CASE nOpcao==7 
             EditDados( aNFiscal, 7, lNotaManual  ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
        CASE nOpcao==8 
             EditDados( aNFiscal, 8, lNotaManual  ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
        CASE nOpcao==9 
             EditDados( aNFiscal, 9, lNotaManual  ) 
             IF lNotaManual 
                Keyboard Chr( K_DOWN ) 
             ENDIF 
 
        CASE nOpcao==10 
             IF aOpcoes[ LEN( aOpcoes ) ][ 1 ]=="  ��Impressao do Romaneio  " 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                Aviso( " Nota Fiscal j� esta gravada! " ) 
                mensagem( "Pressione [ENTER] para continuar..." ) 
                Pausa() 
                ScreenRest( cTelaRes ) 
             ELSE 
 
                nNumero:= Nil 
                // Sem Cabecalho ================================================= 
                IF lSemCabecalho 
                   cNumero:= "9" + cCodigoPedido 
                   aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ]:= Val( cNumero ) 
 
                   nNumero:= Val( cNumero ) 
                ENDIF 
                IF Gravacao( aNFiscal, nNumero ) 
                   AAdd( aOpcoes, { "  ��Impressao da N. Fiscal ", 14 } ) 
                   AAdd( aOpcoes, { "  ��Impressao do Bloqueto  ", 15 } ) 
                   AAdd( aOpcoes, { "  ��Impressao do Romaneio  ", 16 } ) 
                   lRefaz:= .T. 
                   oTab:Down() 
                ENDIF 
 
                // Deleta cabe�alho da nota fiscal =============================== 
                IF lSemCabecalho 
                   PNF->( DBSetOrder( 5 ) ) 
                   PNF->( DBSeek( nNumero ) ) 
                   WHILE PNF->CODNF_ = nNumero 
                       Mensagem( "Eliminando cabecalho da nota " + StrZero( nNumero, 9, 0 ) ) 
                       IF PNF->( netrlock() ) 
                          PNF->( DBDelete() ) 
                       ENDIF 
                       PNF->( DBSkip() ) 
                       IF PNF->( EOF() ) 
                          EXIT 
                       ENDIF 
                   ENDDO 
                   NF_->( DBSetOrder( 1 ) ) 
                   IF NF_->( DBSeek( nNumero ) ) 
                      IF NF_->( netrlock() ) 
                         nf_->( DBDelete() ) 
                      ENDIF 
                   ENDIF 
                   Return Nil 
 
                ENDIF 
 
             ENDIF 
        CASE nOpcao==14 
             IF Confirma( , , "Confirma a impressao da Nota Fiscal?",; 
                                "Digite [S] para imprimir ou [N] para cancelar.", "S" ) 
                Relatorio( "NFISCAL.REP" ) 
                lRefaz:= .T. 
                oTab:Down() 
             ENDIF 
        CASE nOpcao==15 
             DPA->( DBSetOrder( 1 ) ) 
             DPA->( DBSeek( NF_->NUMERO ) ) 
             VPCDoc() 
             lRefaz:= .T. 
             oTab:Down() 
        CASE nOpcao==16 
             /* Selecao de rodutos para Romaneio */ 
             aProdSelec:= {{Space(12),Space(13)," "}} 
             FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
                 cCodPro:= StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) 
                 VisualRomaneio( cCodPro, aProdSelec, aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ] ) 
             NEXT 
             /* Confirma a impressao */ 
             IF Confirma( 0, 0, "Confirma?", "Confirma a impressao do romaneio?", "S" ) 
                /* Romaneio */ 
                DBSelectAr( _COD_ROMANEIO ) 
                DBSetOrder( 3 ) 
                /* Impressao */ 
                Relatorio( "ROMANEIO.REP" ) 
                /* Nota Fiscal */ 
                DBSelectAr( _COD_NFISCAL ) 
             ENDIF 
             lRefaz:= .T. 
        CASE nOpcao==0 
             EXIT 
     ENDCASE 
     ScreenRest( cTela100 ) 
     IF lRefaz 
        oTab:RefreshAll() 
        WHILE !oTab:Stabilize() 
        ENDDO 
        lRefaz:= .F. 
     ENDIF 
     IF nOpcao < 10 
        ++nOpcao 
     ELSE 
        nOpcao:= 0 
     ENDIF 
  ENDDO 
  /* Libera geral */ 
  aNFiscal:= 0 
  aNFiscal:= "" 
  aNFiscal:= {} 
 
  Set( _SET_DELIMITERS, lDelimiters ) 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest( cTELA ) 
  setcursor( nCURSOR ) 
  setcolor( cCOR ) 
  Return Nil 
 
 
 
 
 
Function CalculoImposto( aNFiscal ) 
LOCAL nTotalNf:= 0, nTotalIpi:= 0, nTotalIRRF:= 0,; 
      nBaseIcm:= 0, nBaseIcmTotal:= 0, nTotalIcm:= 0,; 
      nIcm:= 0, cTabelaB, nTotalServicos:= 0, nPercISSQN:= SWSet( _GER_PERCISSQN ), ; 
      nPercIRRF:= SWSet( _GER_PERCIRRF ), nLimIRRF:= SWSet( _GER_LIMIRRF ),;
      nLimUFIR:=  SWSet( _GER_LIMUFIR  ), nVlrImpSobreRevenda:= 0, nPercImpSRevenda:= SWSet( _GER_IMPSR ),;
      nICMSubBase:= 0, nICMSubValor:= 0, nICMSubDemo:= 0, nICMAcr, nICMDes, nICMFrete, nICMDespesas,;
      nPercCOFIN:= IIF( aNFiscal[ P_CLIENTE ][ CLI_SIMPLES ] $ "S ", 0, SWSet( _NF__PERCOFINS ) )

FOR nCt:= 1 To Len( aNFiscal[ P_PRODUTOS ] ) 
 
    MPR->( DBSetOrder( 1 ) ) 
    MPR->( DBSeek( PAD( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ), 12 ) ) ) 
 
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ]:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ] *; 
                                                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] 
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ]:= ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALIPI ] *; 
                                                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] ) / 100 
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] 
 
    cTabelaB:= StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAB ], 2, 0 ) 
 
    nIcm:= BuscaPerIcm( aNFiscal[ P_CLIENTE ][ CLI_ESTADO ],; 
                    aNFiscal[ P_CLIENTE ][ CLI_CONSIND ],; 
                    nIcm ) 
 
    /* Se Estado == RS - Rio Grande do Sul */ 
    IF MPR->ICM___ > 0 .AND. aNFiscal[ P_CLIENTE ][ CLI_ESTADO ] == "RS" 
       aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ]:= MPR->ICM___ 
    ELSE 
       aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ]:= nIcm 
    ENDIF 
 
    DO CASE 
       CASE cTabelaB == "00" 
            nIcm:= nIcm 
 
       CASE cTabelaB == "30" 
            nIcm:= 0 
            aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
 
       CASE cTabelaB == "40" 
            nIcm:= 0 
            aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
 
       CASE cTabelaB == "41" 
            nIcm:= 0 
            aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
 
       CASE cTabelaB == "50" 
            nIcm:= 0 
            aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
 
       CASE cTabelaB == "51" 
            nIcm:= 0 
            aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
 
       CASE ( cTabelaB == "60" .AND. aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] <> "C" ) 
 
            nIcm:= nIcm 
 
            /***------------------------------------------------------------------*** 
            *                                                                       * 
            *                                                                       * 
            *      CALCULO DE PRODUTOS COM SUBSTITUICAO TRIBUT�RIA CST=60/70/10     * 
            *      Valmor Flores                                                    * 
            *                                                                       * 
            *-----------------------------------------------------------------------*/ 
 
            nPosicao:= nCt 
 
            nPerReducao:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PERREDUCAO ] 
            nVlrReducao:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOTOTAL ] * ; 
                        ( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PERREDUCAO ] / 100 ) 
 
 
            // Realiza Calculo com o valor do produto + MVA unitario 
            nVlrComMVA:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOVENDA ] + ( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOVENDA ] * ( MPR->MVAPER / 100 ) ) 
            nVlrComMVA:= nVlrComMVA - ( nVlrComMVA * ( nPerReducao / 100 ) ) 
 
            // Verifica se MVA esta informado em valores 
            IF MPR->MVAVLR > 0 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= 0 
               // Aplicar reducao sobre o MVA que esta cadastrado no produto 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= MPR->MVAVLR - ( MPR->MVAVLR * ( nPerReducao / 100 ) ) 
            ELSEIF MPR->MVAPER > 0 
               // Pega Percentual de MVA que esta informado no cadastro 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= MPR->MVAPER 
               // Armazena Valor com MVA 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= nVlrComMVA 
            ELSE 
               // Zera percentual e valor de MVA 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= 0 
               // Aplicar reducao sobre o MVA que esta cadastrado no produto 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= 0 
            ENDIF 
 
            // Totaliza MVA por produto (Multiplicando Valor Com MVA * QUANTIDADE 
            aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVATOTAL ]:= ( nVlrComMVA * aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_QUANTIDADE ] ) 
 
            // Observacoes diversas 
            AddObservacao( aNFiscal, "ITEM " + STRZERO( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_CODIGO ], 7, 0 ) + " Sub.Trib.Valor: " + Tran( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ], "@R 99,999.99" ) ) 
 
            //// .... Continuacao do Calculo ...... //// 
            nICMSubBase:= nICMSubBase + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MVATOTAL ] 
            nICMSubDemo:= nICMSubDemo + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MVATOTAL ] 
 
            // Valor de Substituicao Tributaria Sobre o total 
            aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_SUBSTITUICAO ]:= ; 
                 aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MVATOTAL ] * ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] / 100 ) 
 
 
       CASE cTabelaB == "20" .OR. ( ( cTabelaB == "70" .OR. cTabelaB == "10" ) .AND. aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] <> "C" ) 
 
            /*------------------------------------------------------------------ 
                                                 CALCULO DE REDUCAO DIFERENCIADO 
                                          POR TIPO DE CLIENTE & ALIQUOTA DE ICMs 
            ------------------------------------------------------------------*/ 
 
            /* Se reducao informada no produto possui uma 
               tabela de reducao auxiliar atrelada */ 
            nPerreducao:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERREDUCAO ] 
 
            /* Busca a reducao em tabela auxiliar de reducoes */ 
            IF RDA->( DBSeek( PAD( MPR->TABRED, 2 ) ) ) 
               lReducaoDiferenciada:= .F. 
               /* percorre todos os aux que possuem esta reducao */ 
               WHILE ALLTRIM( RDA->CODIGO ) == ALLTRIM( MPR->TABRED ) .AND. !( RDA->( EOF() ) ) 
                   /* Se percentual igual ao indicado no RDA */ 
                   IF aNFiscal[ P_PRODUTOS ][ Len( aNFiscal[ P_PRODUTOS ] ) ][ PRO_PERCENTUALICM ] == RDA->PERICM 
                      IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]=="I" 
                         nPerReducao:= RDA->PERRDI 
                         lReducaoDiferenciada:= .T. 
                      ELSEIF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]=="C" 
                         nPerReducao:= RDA->PERRDC 
                         lReducaoDiferenciada:= .T. 
                      ENDIF 
                      IF lReducaoDiferenciada 
                          AddObservacao( aNFiscal, RDA->OBSERV ) 
                      ENDIF 
                   ENDIF 
 
                   /* Proximo */ 
                   RDA->( DBSkip() ) 
               ENDDO 
 
               aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERREDUCAO ]:= nPerReducao 
 
 
            ENDIF 
 
            /***-----------------------------------------------***/ 
 
            IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERREDUCAO ] > 0 
 
               /* Calcula o valor de reducao */ 
               aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VLRREDUCAO ]:= ; 
                  ( ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] * ; 
                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERREDUCAO ] ) / 100 ) 
 
               /* Calcula a base de icm com reducao */ 
               aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= ; 
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] - ; 
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VLRREDUCAO ] 
 
 
            //   @ 01,01 SAY aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ] 
            //   INKEY( 0 ) 
 
 
            ENDIF 
 
            // Substituicao Tributaria 
            IF cTabelaB=="70" .OR. cTabelaB=="10" 
 
               /***------------------------------------------------------------------*** 
               *                                                                       * 
               *                                                                       * 
               *      CALCULO DE PRODUTOS COM SUBSTITUICAO TRIBUT�RIA CST=60/70/10     * 
               *      Valmor Flores                                                    * 
               *                                                                       * 
               *-----------------------------------------------------------------------*/ 
 
               nPosicao:= nCt 
 
               nPerReducao:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PERREDUCAO ] 
               nVlrReducao:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOTOTAL ] * ; 
                           ( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PERREDUCAO ] / 100 ) 
 
               // Realiza Calculo com o valor do produto + MVA unitario 
               nVlrComMVA:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOVENDA ] + ( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOVENDA ] * ( MPR->MVAPER / 100 ) ) 
               nVlrComMVA:= nVlrComMVA - ( nVlrComMVA * ( nPerReducao / 100 ) ) 
 
 
               // Verifica se MVA esta informado em valores 
               IF MPR->MVAVLR > 0 
                  aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= 0 
                  // Aplicar reducao sobre o MVA que esta cadastrado no produto 
                  aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= MPR->MVAVLR - ( MPR->MVAVLR * ( nPerReducao / 100 ) ) 
               ELSEIF MPR->MVAPER > 0 
                  // Pega Percentual de MVA que esta informado no cadastro 
                  aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= MPR->MVAPER 
                  // Armazena Valor com MVA 
                  aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= nVlrComMVA 
               ELSE 
                  // Zera percentual e valor de MVA 
                  aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= 0 
                  // Aplicar reducao sobre o MVA que esta cadastrado no produto 
                  aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= 0 
               ENDIF 
 
               // Totaliza MVA por produto (Multiplicando Valor Com MVA * QUANTIDADE  
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVATOTAL ]:= nVlrComMVA * aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_QUANTIDADE ] 
 
               //// .... Continuacao do Calculo ...... //// 
               nICMSubBase:= nICMSubBase + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MVATOTAL ] 
               nICMSubDemo:= nICMSubDemo + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MVATOTAL ] 
 
               AddObservacao( aNFiscal, "ITEM " + STRZERO( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_CODIGO ], 7, 0 ) + " Sub.Trib.Valor: " + Tran( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ], "@R 99,999.99" ) ) 
 
               // Valor de Substituicao Tributaria Sobre o total 
               aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_SUBSTITUICAO ]:= ; 
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MVATOTAL ] * ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] / 100 ) 
 
 
            ELSE 
 
               nICMSubBase:= nICMSubBase 
               nICMSubDemo:= nICMSubDemo 
 
            ENDIF 
 
       CASE cTabelaB == "90" 
            nIcm:= 0 
            aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
 
       OTHERWISE 
    ENDCASE 
 
 
 
    // Extrai da nICMSubBase o ICMs j� efetuado nos casos de 
    // Substituicao Tributaria, pois para efeito do c�lculo final da substituicao 
    // deve-se exibir o liquido 
    IF cTabelaB $ "60-70-10" .AND. aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] <> "C" 
       nICMSubBase:= ( nICMSubBase - aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ] ) 
    ENDIF 
 
    IF ( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] >= 5.99 .AND.; 
         aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] <= 5.999 ) .OR.; 
       ( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] >= 6.99 .AND.; 
         aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] <= 6.999 ) 
       IF ( OPE->CALICM==" " .OR. OPE->( EOF() ) ) 
          nIcm:= 0 
          aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
          aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ]:= nIcm 
       ENDIF 
    ENDIF 
    IF ( OPE->CALICM=="N" ) 
        nIcm:= 0 
        aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= 0 
        aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ]:= nIcm 
    ENDIF 
    nTotalNf+=  aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] 
    nTotalIpi+= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ] 
 
    /* Se for consumo (Base para ICMs) ser� sobre o ( TOTAL + IPI ) */ 
    IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] == "C" 
       nBaseIcm:= ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ] +; 
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ] ) 
    ELSE 
       nBaseIcm:= ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ] ) 
    ENDIF 
    nBaseIcmTotal+= nBaseIcm 
    nTotalIcm+= ( nBaseIcm * aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] ) / 100 
 
 
NEXT 
 
nIcm:= BuscaPerIcm( aNFiscal[ P_CLIENTE ][ CLI_ESTADO ],; 
                    aNFiscal[ P_CLIENTE ][ CLI_CONSIND ],; 
                    nIcm ) 
 
/*- IMPOSTO SOBRE REVENDA -*/ 
aNFiscal[ P_IMPOSTOS ][ IMP_VLRSOBREREV ]:= 0 
nVlrImpSobreRevenda:= 0 
nPercImpSRevenda:= aNFiscal[ P_IMPOSTOS ][ IMP_SOBREREVENDA ] 
IF nPercImpSRevenda > 0 
   FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
       nVlrImpSobreRevenda+= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] 
   NEXT 
   nVlrImpSobreRevenda:= ( nVlrImpSobreRevenda * nPercImpSRevenda ) /100 
   aNfiscal[ P_IMPOSTOS ][ IMP_VLRSOBREREV ]:= nVlrImpSobreRevenda 
ENDIF 
 
FOR nCt:= 1 TO Len( aNFiscal[ P_SERVICOS ] ) 
    nTotalServicos+= aNFiscal[ P_SERVICOS ][ nCt ][ SER_TOTAL ] 
NEXT 
 
/* Somando as Substituicoes e diminuindo os ICMs padroes ---------------*/ 
nICMSubValor:= 0 
FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
    IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 
       IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_SUBSTITUICAO ] > 0 
          IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] > 0 
             nIcmSubValor:= nICMSubValor + ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_SUBSTITUICAO ] - ; 
                   ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]  * ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] / 100 ) ) ) 
          ELSE 
             nIcmSubValor:= nICMSubValor + ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_SUBSTITUICAO ] - ; 
                   ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]  * ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] / 100 ) ) ) 
          ENDIF 
       ENDIF 
    ENDIF 
NEXT 
/*----------------------------------------------------------------------*/ 
 
nIcmAcr:=      ( aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ]  * nIcm )  / 100 
nIcmDesc:=     ( aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ]   * nIcm )  / 100 
nIcmFrete:=    ( aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE ] * nIcm )  / 100 
nIcmDespesas:= ( aNFiscal[ P_DIVERSOS ][ DIV_DESPESAS ] * nIcm )  / 100 
 
aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ]:= nTotalServicos 
aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ]:= nPercISSQN
aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ]:= ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] * aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ] ) / 100 
aNFiscal[ P_IMPOSTOS ][ IMP_PERCOFIN ]:= nPercCOFIN
aNFiscal[ P_IMPOSTOS ][ IMP_VLRCOFIN ]:= ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] * aNFiscal[ P_IMPOSTOS ][ IMP_PERCOFIN ] ) / 100
 
// �������������������������������������������������������������������������������� AQUI 
aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ]:= nPercIrrf 
aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ]:= ; 
   ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ]  * ; 
     aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF    ] ) / 100 
 
IF aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ] <= nLimIRRF // aqui da erro 
   nTotalIRRF := 0 
ELSE 
   nTotalIRRF := aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ] 
ENDIF 
 
 
// �������������������������������������������������������������������������������� 
 
aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ]:= nBaseIcmTotal +; 
                aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE ] +; 
              ( aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ] ) - ( aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ] ) + aNFiscal[ P_DIVERSOS ][ DIV_DESPESAS ] 
aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA    ]:= nTotalNf +; 
              ( aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ] ) - ( aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ] ) 
aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI     ]:= nTotalIpi 
 
// Verifica se e para calcular ICMs conforme Operacao 
IF OPE->CALICM=="S" .OR. OPE->CODIGO==0 .OR. OPE->( EOF() ) 
   aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM     ]:= nTotalIcm + ( nIcmAcr - nIcmDesc ) + nICMFrete + nICMDespesas 
ELSE 
   aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ]:= 0 
   aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM     ]:= 0 
ENDIF 
 
 
// Substituicao Tribut�ria 
aNfiscal[ P_IMPOSTOS ][ IMP_ICMSUBBASE ]:= nICMSubDemo 
 
//aNfiscal[ P_IMPOSTOS ][ IMP_ICMSUBVALOR ]:= ( nICMSubBase * ( nIcmPerSub / 100 ) ) 
aNfiscal[ P_IMPOSTOS ][ IMP_ICMSUBVALOR ]:= ( nICMSubValor ) 
 
aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL   ]:= ( nTotalNf + nTotalIpi + nTotalServicos + ; 
               aNfiscal[ P_IMPOSTOS ][ IMP_ICMSUBVALOR ] +; 
           ( ( aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ] ) - ( aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ] ) ) - nTotalIRRF ) +; 
               aNFiscal[ P_IMPOSTOS ][ IMP_VLRSOBREREV ] + ( aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE ] ) + ( aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ] ) + ( aNFiscal[ P_DIVERSOS ][ DIV_DESPESAS ] ) 
 
/* Desconto do ISSQN do total da Nota Fiscal Caso ultrapasse 1000 UFIRS */ 
IF aNFiscal[ P_IMPOSTOS ][ IMP_SNUFIR ]=="S" 
   IF nTotalServicos / aNFiscal[ P_IMPOSTOS ][ IMP_VLRUFIR ] >= nLimUfir 
      aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ]:= aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] - ; 
         aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ] 
   ENDIF 
ENDIF 
 
/* CALCULO DE COMISSOES */ 
aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAVISTA ]:= ; 
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_AVISTA ] ) / 100 
aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAPRAZO ]:= ; 
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_APRAZO ] ) / 100 
aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAVISTA ]:= ; 
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_AVISTA ] ) / 100 
aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAPRAZO ]:= ; 
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_APRAZO ] ) / 100 
 
Return .T. 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
********************************************************************* 
Function SelPedido( aNFiscal, cPedido, aOpcoes ) 
   Local cTelaReserva 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local aPedidos:= {}, nCt:= 1, cCodigo:= "", aClientes:= {},; 
         nPrimeiroCliente:= 0 
   Local nValorTotal:= 0,; 
         nValorIPI:= 0,; 
         nBaseIcm:= 0, nVlrReducao, nVlrComMVA 
   Local nAcrescimo:= 0, nDesconto:= 0 
   Local nOrdemRes:= 0 
   local nPos:= 0 
 
 
   Mensagem( "Validando teclas de selecao..." ) 
   IF cPedido <> Nil 
      IF !LastKey()==K_ENTER     /* Nao tirar esta linha pois o pedido pode se */ 
         Return .F.              /* repetir no que diz respeito as informacoes */ 
      ENDIF                      /* quando pressionado k_down OU k_up          */ 
      // Se cPedido nao tiver caractere de finalizacao colocar o mesmo 
      IF SubStr( TRIM( cPedido ), Len( TRIM( cPedido ) ), 1 ) $ "01234567890" 
         cPedido:= cPedido + ";" 
      ENDIF 
   ENDIF 
 
   Mensagem( "Verificando tabelas de pedidos & Notas Fiscais..." ) 
   If File( _VPB_PEDIDO ) .AND. File( _VPB_PEDPROD ) 
      If !FDBUseVpb( _COD_PEDIDO ) 
         Mensagem("Arquivo de pedidos nao esta disponivel neste momento...") 
         Pausa() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         DBSelectAr( nArea ) 
         DBSetOrder( nOrdem ) 
         Return( .F. ) 
      EndIf 
      If !FDBUseVpb( _COD_PEDPROD ) 
         Mensagem("Arquivo de produtos por pedido nao esta disponivel neste momento...") 
         Pausa() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         DBSelectAr( nArea ) 
         DBSetOrder( nOrdem ) 
         PedidoAceito( .F. ) 
         Return( .F. ) 
      EndIf 
   Else 
      Mensagem( "Arquivo de Pedidos nao encontrado..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      PedidoAceito( .F. ) 
      Return .F. 
   EndIf 
 
   IF cPedido==Nil 
      Mensagem( "Desabilitando pedidos para abertura de nota fiscal manual..." ) 
      cPedido:= "99999999" 
   ELSE 
      IF cPedido == Space( Len( cPedido ) ) 
         VisualPedido( @cPedido ) 
      ENDIF 
   ENDIF 
 
   aNFiscal[ P_PEDIDOS ]:= cPedido 
 
   PedidoAceito( .T. ) 
   OPE->( DBSetOrder( 1 ) ) 
 
   IF cPedido=="99999999" 
      lNotaManual:= .T. 
   ELSE 
      lNotaManual:= .F. 
   ENDIF 
 
   IF !lNotaManual 
      Mensagem( "Buscando informacoes sobre pedidos..." ) 
      DBSelectAr( _COD_PEDIDO ) 
      DBSetOrder( 6 ) /* Ordem de Numero de pedido */ 
      For nCt:= 1 To Len( cPedido ) 
          IF SubStr( cPedido, nCt, 1 ) $ ".,;-/*+ " 
             IF !DBSeek( StrZero( Val( cCodigo ), 8, 0 ) ) 
                IF Val( cCodigo ) <> 0 
                   cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
                   Aviso( "Nao consta o pedido n� " + cCodigo + " na lista de dispon�veis...", 12 ) 
                   Mensagem( "Pressione ENTER para continuar...", 1 ) 
                   Pausa() 
                   PedidoAceito( .F. ) 
                   ScreenRest( cTelaReserva ) 
                ENDIF 
             ELSEIF PED->CODCLI==0 .AND. PedidoAceito() 
                Aviso( "Atencao! Cliente nao possui codificacao neste pedido." ) 
                Pausa() 
                SetColor( cCor ) 
                SetCursor( nCursor ) 
                ScreenRest( cTela ) 
                PedidoAceito( .F. ) 
                Return( .F. ) 
             ELSE 
                AAdd( aPedidos, StrZero( Val( cCodigo ), 8, 0 ) ) 
                AAdd( aClientes, DESCRI ) 
             ENDIF 
             cCodigo:= "" 
          Else 
             cCodigo:= cCodigo + SubStr( cPedido, nCt, 1 ) 
          EndIf 
      Next 
      IF Len( aPedidos ) <= 0 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         PedidoAceito( .F. ) 
         mensagem( "Lista de pedidos invalida ^" + cPedido + "^" ) 
//         Aviso( "Nenhum pedido informado corretamente" ) 
//         Pausa() 
         // VALMOR: ---^ 
         Return( .F. ) 
      ELSE 
         PedidoAceito( .T. ) 
      ENDIF 
   ELSE 
 
      Mensagem( "Nota manual iniciada..." + STR( LEN( aPedidos ) ) ) 
      AAdd( aPedidos, cPedido ) 
      AAdd( aClientes, SPACE( len( PED->DESCRI ) ) ) 
      PedidoAceito( .T. ) 
 
   ENDIF 
 
   FOR nCt:= 1 To Len( aPedidos ) 
       If !aPedidos[ nCt ] == "00000000" 
          SetColor( _COR_GET_EDICAO ) 
          IF nCt == 1 
             IF !lNotaManual 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                UserModulo( ALLTRIM( aPedidos[ nCt ] + " - " + aClientes[ nCt ] ) ) 
             ENDIF 
          ENDIF 
          DBSelectAr( _COD_PEDPROD ) 
          DBSetOrder( 1 ) 
          DBSelectAr( _COD_PEDIDO ) 
          DBSetOrder( 6 ) /* Ordem de Numero de pedido */ 
          IF DBSeek( aPedidos[ nCt ] ) .OR. lNotaManual 
             If nCt == 1 
                nPrimeiroCliente:= CodCli 
                /* Dados do Cliente */ 
                IF Empty( aNFiscal[ P_CLIENTE ] ) 
                   DBSelectAr( _COD_CLIENTE ) 
                   nOrdemRes:= indexOrd() 
                   DBSetOrder( 1 ) 
                   DBSelectAr( _COD_PEDIDO ) 
                   Set Relation To CodCli Into Cli 
                   AAdd( aNFiscal[ P_NUMERO ], Val( aPedidos[ 1 ] ) ) 
                   AAdd( aNFiscal[ P_CLIENTE ], CodCli ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Descri ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Endere ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Bairro ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Cidade ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Estado ) 
                   AAdd( aNFiscal[ P_CLIENTE ], CodCep ) 
                   AAdd( aNFiscal[ P_CLIENTE ], CGCMF_ ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Inscri ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Cobran ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Cli->ConInd ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Cli->CPF___ ) 
                   AAdd( aNFiscal[ P_CLIENTE ], Cli->Fone1_ )
                   AAdd( aNFiscal[ P_CLIENTE ], CLI->SIMPL_ )
                   DBSelectAr( _COD_CLIENTE ) 
                   IF ! nOrdemRes == 0 
                      DBSetOrder( nOrdemRes ) 
                   ENDIF 
                   DBSelectAr( _COD_PEDIDO ) 
 
                   /* Dados da transportadora */ 
                   AAdd( aNFiscal[ P_TRANSPORTE ], Transp ) 
                   TRA->( DBSetOrder( 1 ) ) 
                   TRA->( DBSeek( PED->Transp ) ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Descri ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Endere ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], SPACE( 20 ) ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Cidade ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Estado ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], SPACE( 08 ) ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->CGCMF_ ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Inscri ) 
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Fone__ ) 
 
                   /* Dados das commissoes */ 
                   AAdd( aNFiscal[ P_COMISSOES ], { VenIn1, Perc( VenIn1, 1 ), Perc( VenIn1, 2 ), Perc( VenIn1, 3 ), Perc( VenIn1, 4 ), 0, 0, 0, 0, 0, Vende1 } ) 
                   AAdd( aNFiscal[ P_COMISSOES ], { VenEx1, Perc( VenEx1, 1 ), Perc( VenEx1, 2 ), Perc( VenEx1, 3 ), Perc( VenEx1, 4 ), 0, 0, 0, 0, 0, Vende2 } ) 
 
                   /* Dados do Cabecalho da N. Fiscal */ 
                   AAdd( aNFiscal[ P_CABECALHO ], 0 ) 
 
                   /* Se a operacao contiver o codigo de Natureza de Operacao */ 
                   IF PED->TABOPE > 0 .AND. OPE->( DBSeek( PED->TABOPE ) ) 
                      IF PED->ESTADO=="RS" .OR. PED->ESTADO=="  " 
                         AAdd( aNFiscal[ P_CABECALHO ], { OPE->NATOPE, PegaNatOpera( OPE->NATOPE ) } ) 
                      ELSE 
                         AAdd( aNFiscal[ P_CABECALHO ], { OPE->NATFOR, PegaNatOpera( OPE->NATFOR ) } ) 
                      ENDIF 
                      AAdd( aNFiscal[ P_CABECALHO ], Date() ) 
 
                      /* Verifica a Operacao */ 
                      IF OPE->ENTSAI $ "12E+" 
                         AAdd( aNFiscal[ P_CABECALHO ], "ENTRADA" ) 
 
                         /* comissoes */ 
                         nPos:= ASCAN( aOpcoes, {|x| x[2]==6 } ) 
                         aOpcoes[ nPos ][ 1 ]:= "*" + SubSTr( aOpcoes[ nPos ][ 1 ], 2 ) 
 
                         /* contas a receber passa a ser CONTAS A PAGAR */ 
                         nPos:= ASCAN( aOpcoes, {|x| x[2]==9 } ) 
                         aOpcoes[ nPos ][ 1 ]:= PAD( " Contas a Pagar ", LEN( aOpcoes[ nPos ][ 1 ] ) ) 
 
                      ELSE 
                         IF OPE->ENTSAI=="*" 
                            CFO->( DBSetOrder( 1 ) ) 
                            IF CFO->( DBSeek( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] ) ) 
                               AAdd( aNFiscal[ P_CABECALHO ], IF( LEFT( CFO->ENTSAI, 1 )=="E", "ENTRADA", "SAIDA" ) ) 
                            ELSE 
                               AAdd( aNFiscal[ P_CABECALHO ], "SAIDA" ) 
                            ENDIF 
                         ELSE 
                             AAdd( aNFiscal[ P_CABECALHO ], "SAIDA" ) 
                         ENDIF 
                      ENDIF 
 
                      AAdd( aNFiscal[ P_CABECALHO ], SWSet( _NFA_VIATRANSP ) ) 
                   ELSE // Senao, pega informacoes padrao do Sistema 
                      IF PED->ESTADO=="RS" .OR. PED->ESTADO=="  " 
                         AAdd( aNFiscal[ P_CABECALHO ], { SWSet( _NFA_NATOPERA ), PegaNatOpera( SWSet( _NFA_NATOPERA ) ) } ) 
                      ELSE 
                         AAdd( aNFiscal[ P_CABECALHO ], { SWSet( _NFA_NATOPERA ) + 1, PegaNatOpera( SWSet( _NFA_NATOPERA ) + 1 ) } ) 
                      ENDIF 
                      AAdd( aNFiscal[ P_CABECALHO ], Date() ) 
                      AAdd( aNFiscal[ P_CABECALHO ], SWSet( _NFA_RAZAO ) ) 
                      AAdd( aNFiscal[ P_CABECALHO ], SWSet( _NFA_VIATRANSP ) ) 
                   ENDIF 
 
                   AAdd( aNfiscal[ P_CABECALHO ], PAD( PED->OC__01, 10 ) +; 
                                                  PAD( PED->OC__02, 10 ) +; 
                                                  PAD( PED->OC__03, 10 ) +; 
                                                  PAD( PED->OC__04, 10 ) +; 
                                                  PAD( PED->OC__05, 10 ) +; 
                                                  PAD( PED->OC__06, 10 ) ) 
 
                ENDIF 
             ENDIF 
             DBSelectAr( _COD_MPRIMA ) 
             nOrdemRes:= IndexOrd() 
             DBSetOrder( 1 ) 
             /* Dados dos produtos */ 
             DBSelectAr( _COD_PEDPROD ) 
             Set Relation To StrZero( CODPRO, 7, 0 ) + Space( 5 ) Into MPR 
             cCotacao:= PED->Codigo 
             IF !( lNotaManual ) 
                DBSetOrder( 1 ) 
                IF DBSeek( cCotacao ) 
                   WHILE Codigo == cCotacao 
                        IF Left( StrZero( CODPRO, 7, 0 ), 3 ) == SWSet( _GER_GRUPOSERVICOS ) 
                           AAdd( aNFiscal[ P_SERVICOS ], { CodPro, Descri, VlrUni, VlrUni * Quant_, Quant_, MPR->MPRIMA } ) 
                        ELSE 
                           cDescricao:= Descri 
                           #ifdef CONECSUL 
                               cDescricao:= CodFab + " - " + Descri 
                           #endif 
                           AAdd( aNFiscal[ P_PRODUTOS ], { CodPro,; 
                                                           cDescricao,; 
                                                           Unidad,; 
                                                           VlrUni,; 
                                                           VlrUni * Quant_,; 
                                                           MPR->SITT01,; 
                                                           MPR->SITT02,; 
                                                           MPR->CLAFIS,; 
                                                           Quant_,; 
                                                           0,; 
                                                           IPI___,; 
                                                           ICM___,; 
                                                           MPR->MPrima,; 
                                                           PegaCodFiscal( MPR->ClaFis ),; 
                                                           CodFab,; 
                                                           Quant_,; 
                                                           ( Quant_ * VlrUni ),; 
                                                           MPR->PerRed,; 
                                                           0,; 
                                                           ORIGEM,; 
                                                           PED->TABOPE,; 
                                                           TABPRE,; 
                                                           PRECO1,; 
                                                           PCPCLA,; 
                                                           PCPTAM,; 
                                                           PCPCOR,; 
                                                           MPR->MVAPER,; 
                                                           MPR->MVAVLR,; 
                                                           MPR->MVAVLR,; 
                                                           0 } ) 
 
                           /*----------------------------------------------------- 
                                                   CALCULO DE REDUCAO DIFERENCIADO 
                                            POR TIPO DE CLIENTE & ALIQUOTA DE ICMs 
                           -----------------------------------------------------*/ 
 
                           /* Se reducao informada no produto possui uma 
                              tabela de reducao auxiliar atrelada */ 
                           nPerreducao:= MPR->PERRED 
 
                           /* Busca a reducao em tabela auxiliar de reducoes */ 
                           IF RDA->( DBSeek( PAD( MPR->TABRED, 2 ) ) ) 
 
                              /* percorre todos os aux que possuem esta reducao */ 
                              WHILE ALLTRIM( RDA->CODIGO )==ALLTRIM( MPR->TABRED ) .AND. !( RDA->( EOF() ) ) 
 
                                  /* Se percentual igual ao indicado no RDA */ 
                                  IF aNFiscal[ P_PRODUTOS ][ Len( aNFiscal[ P_PRODUTOS ] ) ][ PRO_PERCENTUALICM ] == RDA->PERICM 
                                     IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]=="I" 
                                        nPerReducao:= RDA->PERRDI 
                                     ELSEIF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]=="C" 
                                        nPerReducao:= RDA->PERRDC 
                                     ENDIF 
                                  ENDIF 
 
                                  /* Proximo */ 
                                  RDA->( DBSkip() ) 
 
                              ENDDO 
 
                              aNFiscal[ P_PRODUTOS ][ Len( aNFiscal[ P_PRODUTOS ] ) ][ PRO_PERREDUCAO ]:= nPerReducao 
 
                           ENDIF 
 
                           // Se for Consumidor nao calcular ICMs Reducao 
                           IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] <> "C" 
 
                              /***------------------------------------------------------------------*** 
                              *                                                                       * 
                              *      CALCULO DE PRODUTOS COM SUBSTITUICAO TRIBUT�RIA CST=60/70/10     * 
                              *      Valmor Flores                                                    * 
                              *                                                                       * 
                              *-----------------------------------------------------------------------*/ 
 
                              nPosicao:= Len( aNFiscal[ P_PRODUTOS ] ) 
 
                              nPerReducao:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PERREDUCAO ] 
                              nVlrReducao:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOTOTAL ] * ; 
                                          ( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PERREDUCAO ] / 100 ) 
 
                              // Realiza Calculo com o valor do produto + MVA unitario 
                              nVlrComMVA:= aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOVENDA ] + ( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_PRECOVENDA ] * ( MPR->MVAPER /100 ) ) 
                              nVlrComMVA:= nVlrComMVA - ( nVlrComMVA * ( nPerReducao / 100 ) ) 
 
 
                              // Verifica se MVA esta informado em valores 
                              IF MPR->MVAVLR > 0 
                                 aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= 0 
                                 // Aplicar reducao sobre o MVA que esta cadastrado no produto 
                                 aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= MPR->MVAVLR - ( MPR->MVAVLR * ( nPerReducao / 100 ) ) 
                              ELSEIF MPR->MVAPER > 0 
                                 // Pega Percentual de MVA que esta informado no cadastro 
                                 aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= MPR->MVAPER 
                                 // Armazena Valor com MVA 
                                 aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= nVlrComMVA 
                              ELSE 
                                 // Zera percentual e valor de MVA 
                                 aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAPERCENTUAL ]:= 0 
                                 // Aplicar reducao sobre o MVA que esta cadastrado no produto 
                                 aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ]:= 0 
                              ENDIF 
 
                              // Totaliza MVA por produto (Multiplicando Valor Com MVA * QUANTIDADE */ 
                              aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVATOTAL ]:= ( nVlrComMVA * aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_QUANTIDADE ] ) 
 
                              ////AddObservacao( aNFiscal, "ITEM " + STRZERO( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_CODIGO ], 7, 0 ) + " Sub.Trib.Valor: " + Tran( aNFiscal[ P_PRODUTOS ][ nPosicao ][ PRO_MVAVALOR ], "@R 99,999.99" ) ) 
 
                           ENDIF 
 
                        ENDIF 
                        DBSKip() 
 
                   ENDDO 
                ENDIF 
             ENDIF 
             IF Len( aNFiscal[ P_PRODUTOS ] ) <= 0 
                      AAdd( aNFiscal[ P_PRODUTOS ], { 0,; 
                                                      Space( 50 ),; 
                                                      Space( 2 ),; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      " ",; 
                                                      "          ",; 
                                                      Space( 15 ),; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      Space( 15 ),; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0,; 
                                                      0 } ) 
 
             ENDIF 
             Set Relation To 
             DBSelectAr( _COD_MPRIMA ) 
             IF ! nOrdemRes == 0 
                DBSetOrder( nOrdemRes ) 
             ENDIF 
             DBSelectAr( _COD_PEDPROD ) 
             AAdd( aNFiscal[ P_DIVERSOS ], "          " ) 
             AAdd( aNFiscal[ P_DIVERSOS ], "          " ) 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 ) 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 ) 
             AAdd( aNFiscal[ P_DIVERSOS ], IF( SWSet( _NF__DATA ), Date(), CTOD( "  /  /  " ) ) ) 
             AAdd( aNFiscal[ P_DIVERSOS ], IF( SWSet( _NF__HORA ), Left( Time(), 2 ) + SubStr( Time(), 4, 2 ), Space( 4 ) ) ) 
             AAdd( aNFiscal[ P_DIVERSOS ], Left( PED->FRETE_, 1 ) ) 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 ) 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 ) 
             AAdd( aNFiscal[ P_DIVERSOS ], { Space(60),; 
                                             Space(60),; 
                                             Space(60),; 
                                             Space(60),; 
                                             Space(60); 
                                             } ) 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 ) 
             AAdd( aNFiscal[ P_DIVERSOS ], PED->CONDI_ ) 
             AAdd( aNfiscal[ P_DIVERSOS ], PED->TABOPE ) 
             AAdd( aNFiscal[ P_DIVERSOS ], PED->TABCND ) 
 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 )  /* DESC */ 
             AAdd( aNFiscal[ P_DIVERSOS ], 0  )  /* ACRESCIMO */ 
             AAdd( aNFiscal[ P_DIVERSOS ], space(08) )  /* PLACA */ 
             AAdd( aNFiscal[ P_DIVERSOS ], 0 ) 
 
             /* Busca observacoes informadas nos pedidos */ 
             IF !EMPTY( PED->OBSNF1 ) 
                aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ 1 ]:= PAD( PED->OBSNF1, 60 ) 
             ENDIF 
             IF !EMPTY( PED->OBSNF2 ) 
                aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ 2 ]:= PAD( PED->OBSNF2, 60 ) 
             ENDIF 
             IF !EMPTY( PED->OBSNF3 ) 
                aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ 3 ]:= PAD( PED->OBSNF3, 60 ) 
             ENDIF 
             IF !EMPTY( PED->OBSNF4 ) 
                aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ 4 ]:= PAD( PED->OBSNF4, 60 ) 
             ENDIF 
 
             /* Limpa peso liquido & peso bruto */ 
             aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ]:=   0 
             aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ]:= 0 
             FOR nCt2:= 1 To LEN( aNFiscal[ P_PRODUTOS ] ) 
                 nValorTotal+= aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_PRECOTOTAL ] 
                 nValorIPI+= aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_VALORIPI ] 
                 MPR->( DBSetOrder( 1 ) ) 
                 IF MPR->( DBSeek( PAD( StrZero( aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_CODIGO ], 7, 0 ), 12 ) ) ) 
 
                    ////* BUSCA OBSERVACOES DE REDUCAO NA TABELA DE OBSERVACOES DA NOTA *///// 
                    RED->( DBSetOrder( 1 ) ) 
 
                    IF RED->( DBSeek( MPR->TABRED ) ) 
 
                       lAchou:= .F. 
 
                       FOR nObservacao:= 1 TO LEN( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ] ) 
 
                           IF ALLTRIM( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObservacao ] )==ALLTRIM( RED->OBSERV ) 
                              lAchou:= .T. 
                              EXIT 
                           ENDIF 
 
                           IF EMPTY( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObservacao ] ) .AND. !lAchou 
                              aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObservacao ]:= PAD( RED->OBSERV, Len( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObservacao ] ) ) 
                              lAchou:= .T. 
                           ENDIF 
 
                       NEXT 
 
                    ENDIF 
 
 
 
                 ENDIF 
                 aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ]:=   aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ]   + ( MPR->PESOBR * aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_QUANTIDADE ] ) 
                 aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ]:= aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ] + ( MPR->PESOLI * aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_QUANTIDADE ] ) 
                 #ifdef CONECSUL 
                  IF aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_CLAFISCAL ] == 7 
                     aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ]:= "CLAS.FISC.85364100 ISENTO DE IPI MED.PROV.1508-16 18/04/97" 
                  ENDIF 
                 #endif 
             NEXT 
             IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] <> "C" 
                nBaseIcm:= nValorTotal + nValorIPI 
             ENDIF 
 
             /* Acrescimos / Descontos */ 
             nAcrescimo:= ( nValorTotal * ( PED->PERACR / 100 ) ) 
             nDesconto:=  ( nValorTotal * ( PED->PERDES / 100 ) ) 
 
             /* Atribuicao de Acrescimo / Desconto ao Array */ 
             aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ]:= nAcrescimo 
             aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ]:=  nDesconto 
 
             AAdd( aNFiscal[ P_IMPOSTOS ], nValorTotal )             /* IMP_VALORTOTAL   */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], nValorIpi )               /* IMP_VALORIPI     */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], nValorTotal + nValorIpi ) /* IMP_VALORNOTA    */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], nBaseIcm )                /* IMP_VALORBASEICM */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* IMP_VALORICM     */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* servicos */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* issqn */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* valor imposto issqn */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* IRRF */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* valor imposto IRRF */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* Valor da UFIR */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], "N" )                     /* Sim/Nao-UFIR */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* IMPOSTO SOBRE REVENDA */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* IMPORTO SOBRE REVENDA */ 
             AAdd( aNfiscal[ P_IMPOSTOS ], 0 )                    /* ICM Sub Base */ 
             AAdd( aNfiscal[ P_IMPOSTOS ], 0 )                    /* ICM Sub Valor */ 
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* cofins */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* valor imposto cofins */
 
          ELSE 
             DBSelectAr( _COD_CLIENTE ) 
             nOrdemRes:= indexOrd() 
             DBSetOrder( 1 ) 
             DBSelectAr( _COD_PEDIDO ) 
             Set Relation To CodCli Into Cli 
             aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:=    CodCli 
             aNfiscal[ P_CLIENTE ][ CLI_DESCRICAO ]:= Descri 
             aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ]:=  Endere 
             aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ]:=    Bairro 
             aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]:=    Cidade 
             aNFiscal[ P_CLIENTE ][ CLI_ESTADO ]:=    Estado 
             aNFiscal[ P_CLIENTE ][ CLI_CEP ]:=       CodCep 
             aNFiscal[ P_CLIENTE ][ CLI_CGC ]:=       CGCMF_ 
             aNfiscal[ P_CLIENTE ][ CLI_INSCRICAO ]:= Inscri 
             aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ]:=  Cobran 
             aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]:=   CLI->ConInd 
             aNFiscal[ P_CLIENTE ][ CLI_CPF ]:=       Cli->CPF___ 
             aNFiscal[ P_CLIENTE ][ CLI_FONE ]:=      Cli->FONE1_
             aNFiscal[ P_CLIENTE ][ CLI_SIMPLES ]:=   Cli->SIMPL_

             DBSelectAr( _COD_CLIENTE ) 
             IF ! nOrdemRes == 0 
                  DBSetOrder( nOrdemRes ) 
             ENDIF 
             DBSelectAr( _COD_PEDIDO ) 
          ENDIF 
       ENDIF 
   NEXT 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   DBSelectAr( nArea ) 
   IF Used() 
      DBSetOrder( nOrdem ) 
   ENDIF 
   RETURN .T. 
 
 
******************************************************************************* 
Function tiponf( cPVAR, nPMODULO, cTelaG ) 
Local cTELA:=ScreenSave(00,00,24,79), nCURSOR:=setcursor(), cCOR:=setcolor() 
if nPMODULO=1 
   ScreenRest( cTelaG ) 
   Mensagem("Digite o tipo de nota fiscal...") 
   setcolor( Cor[ 25 ] ) 
   vpbox(02,39,07,59,,COR[24],.F.,.F.,COR[23]) 
   @ 03,40 say " U = Serie Unica   " 
   @ 04,40 say " B = Balcao        " 
   @ 05,40 say " S = Servico       " 
   @ 06,40 say " P = Pedido        " 
endif 
setcolor(cCOR) 
return(.T.) 
 
 
************************************************************************ 
Static Function teclainativa() 
if lastkey()=K_PGUP .OR. lastkey()=K_PGDN 
   Mensagem("ATENCAO! Nao � poss�vel finalizar a ent. dados c/ [PgDn/PgUp].",1) 
   Pausa() 
   return(.T.) 
endif 
return(.F.) 
 
 
Static Function CalculosNF( cPCR, nPMOD, lATIVAPROD, nAlteracao, ; 
            cEstado, nBasIcm, nIcmPer, nVlrIcm, nVlrNot, nVltPro,; 
            nQtdPro, nVlrPro, nVlpIpi, npBaIcm, nVlrRed, nPerRed,; 
            nVluIcm ) 
Local GetList:= {} 
If ( cPCR<>"C" .AND. cPCR<>"I" ) .OR. teclainativa() 
   return(.F.) 
endif 
if cESTADO="RS"                           && ICMs no estado! 
   IF nPerIcm == 0 
      nPerIcm:=17.00 
      nIcmPer:=17.00 
   ENDIF 
else                                      && ICMs fora do estado! 
   IF nPerIcm == 0 
      nPerIcm:=12.00 
      nIcmPer:=12.00 
   ENDIF 
endif 
do case 
   case nPMOD=1 
        /* Esta linha de comando estava desabilitada */ 
        nVLRICM:=(nBASICM*nICMPER)/100 
 
   case nPMOD=2 
        nVLRTOT:=nVLRIPI+nVLRNOT          && Valor total da NF. 
 
   case nPMOD=3 
 
   case nPMOD=4 
        nVltPro:= nQtdPro * nVlrPro 
 
   case nPMOD=5 
        If nPerIpi<>0 
           nVlpIpi:= ( nVltPro * nPerIpi ) / 100 
        Else 
           nVlpIpi:= 0 
        Endif 
 
   case nPMOD=6 
        If cConRev=="C" 
           nPBaIcm:= nVltPro + nVlpIpi 
        Else 
           nPBaIcm:= nVltPro 
        EndIf 
        nVlrRed:= 0 
        nPerRed:= MPr->PerRed 
        If nSitT02 == 20 .OR.; 
           nSitT02 == 60 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           VPBox( 09, 10, 14, 52, "Reducao de ICMs", _COR_ALERTA_BOX, .T., .T., _COR_ALERTA_TITULO ) 
           SetColor( _COR_ALERTA_LETRA ) 
           @ 10,11 Say "Base de Calculo ICMs.:" + Tran( nPBaIcm, "@E 999,999,999.99" ) 
           @ 11,11 Say "Percentual de Reducao:" Get nPerRed Pict "@E 999.99" 
           @ 12,11 Say "�����������������������������������������" 
           Read 
           nVlrRed:= ( nPBaIcm * nPerRed ) / 100 
           @ 13,11 Say "Valor Base de Calculo:" + Tran( nPBaIcm:= nVltPro - nVlrRed, "@E 999,999,999.99" ) 
           Mensagem( "Pressione [ENTER] para continuar..." ) 
           Pausa(0) 
           ScreenRest( cTelaRes ) 
           SetColor( _COR_GET_EDICAO ) 
        EndIf 
        If nIpiCod <> 40 .and. nIpiCod <> 41 
           nVlUIcm:= ( nPBaIcm * nPerIcm ) / 100 
        Else 
           nVlUIcm:= 0 
        Endif 
 
endcase 
return(.T.) 
 
 
 
FUNCTION DisplayDados( aNFiscal, nRow ) 
  LOCAL cCor:= SetColor(), nCt:= 1, lMouseStatus:= MouseStatus() 
  DesligaMouse() 
  DispBegin() 
  SetColor( Cor[16] ) 
  Scroll( 02, 31, 21, 78 ) 
  SetColor( "15/01" ) 
  DO CASE 
     CASE nRow==12 
          OPE->( DBSetOrder( 1 ) ) 
          OPE->( DBSeek( aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] ) ) 
          CND->( DBSetOrder( 1 ) ) 
          CND->( DBSeek( aNFIscal[ P_DIVERSOS ][ DIV_TABCONDICAO ] ) ) 
          VPBoxSombra( 02, 31, 14, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Operacao.: " + StrZero( aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ], 3, 0 ) + " - " + LEFT( OPE->DESCRI, 20 ) 
          @ 04,33 Say "Condicoes: " + StrZero( aNFIscal[ P_DIVERSOS ][ DIV_TABCONDICAO ], 3, 0 ) + " - " + LEFT( CND->DESCRI, 20 ) 
     CASE nRow==1 
          VPBoxSombra( 02, 31, 04, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Pedido(s): " + aNFiscal[ P_PEDIDOS ] 
     CASE nRow==2 
          VPBoxSombra( 02, 31, 14, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "C�digo...: " + StrZero( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ], 6, 0 ) 
          @ 04,33 Say "Nome.....: " + Left( aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ], 33 ) 
          @ 05,33 Say "CGC/CPF..: " + ; 
                       IF( EMPTY( aNFiscal[ P_CLIENTE ][ CLI_CGC ] ),; 
                            Tran( aNFiscal[ P_CLIENTE ][ CLI_CPF ], "@R 999.999.999-99" ),; 
                            Tran( aNFiscal[ P_CLIENTE ][ CLI_CGC ], "@R 99.999.999/9999-99" ) ) 
          @ 06,33 Say "Inscri��o: " + aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ] 
          @ 07,33 Say "Endere�o.: " + Left( aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ], 33 ) 
          @ 08,33 Say "Bairro...: " + aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ] 
          @ 09,33 Say "Cidade...: " + aNFiscal[ P_CLIENTE ][ CLI_CIDADE ] 
          @ 10,33 Say "Estado...: " + aNFIscal[ P_CLIENTE ][ CLI_ESTADO ] 
          @ 11,33 Say "CEP......: " + Tran( aNFiscal[ P_CLIENTE ][ CLI_CEP ], "@R 99999-999" ) 
          @ 12,33 Say "Cobran�a.: " + aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ] 
          @ 13,33 Say "Cons/Ind.: " + UPPER( aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] ) 
     CASE nRow==3 
          nArea:= DBSelectAr() 
          DBSelectAr( _COD_NATOPERA ) 
          IF DBSeek( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] ) 
             aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= Left( Descri, 27 ) 
          ELSE 
             aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= Space( 27 ) 
          ENDIF 
          DBSelectAr( nArea ) 
          VPBoxSombra( 02, 31, 08, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Raz�o....: " + aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ] 
          @ 04,33 Say "NF Numero: " + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 9, 0 ) 
          @ 05,33 Say "Nat.Oper.: " + Tran( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ], "@E 9.999" ) +; 
                                            " - " + Left( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ], 25 ) 
          @ 06,33 Say "Emissao..: " + DTOC( aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ] ) 
          @ 07,33 Say "V.Transp.: " + aNFiscal[ P_CABECALHO ][ CAB_VIATRANSP ] 
     CASE nRow==4 
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Codigo...: " + StrZero( aNFIscal[ P_TRANSPORTE ][ TRA_CODIGO ], 3, 0 ) 
          @ 04,33 Say "Nome.....: " + Left( aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ], 33 ) 
          @ 05,33 Say "CGC......: " + TRAN( aNFiscal[ P_TRANSPORTE ][ TRA_CGC ], "@R 99.999.999/9999-99" ) 
          @ 06,33 Say "Inscri��o: " + aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ] 
          @ 07,33 Say "Endere�o.: " + Left( aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ], 33 ) 
          @ 08,33 Say "Bairro...: " + aNFiscal[ P_TRANSPORTE ][ TRA_BAIRRO ] 
          @ 09,33 Say "Cidade...: " + aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ] 
          @ 10,33 Say "Estado...: " + aNFIscal[ P_TRANSPORTE ][ TRA_ESTADO ] 
          @ 11,33 Say "CEP......: " + Tran( aNFiscal[ P_TRANSPORTE ][ TRA_CEP ], "@R 99999-999" ) 
          @ 12,33 Say "Fone.....: " + Tran( aNFiscal[ P_TRANSPORTE ][ TRA_FONE ], "@R XXXX-XXXX.XXXX" ) 
     CASE nRow==5 
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Codigo...: " + Tran( StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) 
          @ 04,33 Say "Descricao: " + Left( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_DESCRICAO ], 33 ) 
          @ 05,33 Say "Unidade..: " + aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_UNIDADE ] 
          @ 06,33 Say "Tabela A.: " + StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CODTABELAA ], 1, 0 ) 
          @ 07,33 Say "Tabela B.: " + StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CODTABELAB ], 2, 0 ) 
          @ 08,33 Say "Clas.Fisc: " + StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CLAFISCAL ], 3, 0 ) 
          @ 09,33 Say "Preco Un.: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PRECOVENDA ], "@E 999,999.999" ) 
          @ 10,33 Say "Quantia..: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_QUANTIDADE ], "@E 999,999.99" ) 
          @ 11,33 Say "Total....: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PRECOTOTAL ], "@E 999,999,999.999" ) 
          @ 12,33 Say "% IPI....: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PERCENTUALIPI ], "@E 99.99" ) 
          @ 13,33 Say "Valor IPI: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_VALORIPI ], "@E 999,999,999.99" ) 
          @ 13,61 Say "% Red: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PERREDUCAO ], "@E 99.9999" ) 
          @ 14,33 Say "����������������� BROWSE ������������������" 
          @ 15,33 Say "Codigo   Descri�ao                         " 
          nFinal:= IF( Len( aNFiscal[ P_PRODUTOS ] ) > 4, 4, Len( aNFiscal[ P_PRODUTOS ] ) ) 
          FOR nCt:= 1 TO nFinal 
              @ 15 + nCt, 33 Say IF( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ]==0, " ", "�" ) 
              @ 15 + nCt, 34 Say Tran( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) 
              @ 15 + nCt, 43 Say Left( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ], 34 ) 
          NEXT 
     CASE nRow==11 
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/01" ) 
          IF Len( aNFiscal[ P_SERVICOS ] ) > 0 
             @ 03,33 Say "Codigo.....: " + Tran( StrZero( aNFiscal[ P_SERVICOS ][ 1 ][ SER_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) 
             @ 04,33 Say "Descricao..: " + Left( aNFiscal[ P_SERVICOS ][ 1 ][ SER_DESCRICAO ], 31 ) 
             @ 05,33 Say "Preco......: " + Tran( aNFiscal[ P_SERVICOS ][ 1 ][ SER_UNITARIO ], "@E 999,999,999.99" ) 
             @ 06,33 Say "Quantidade.: " + Tran( aNFiscal[ P_SERVICOS ][ 1 ][ SER_QUANTIDADE ], "@E 999,999.99" ) 
             @ 07,33 Say "Valor Total: " + Tran( aNFiscal[ P_SERVICOS ][ 1 ][ SER_TOTAL ], "@E 999,999,999.99" ) 
             @ 08,33 Say "�������������� Browse Servicos ������������" 
             @ 09,33 Say "Codigo   Descricao                         " 
             nFinal:= IF( Len( aNFiscal[ P_SERVICOS ] ) > 8, 4, Len( aNFiscal[ P_SERVICOS ] ) ) 
             FOR nCt:= 1 TO nFinal 
                 @ 09 + nCt, 33 Say Tran( StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) 
                 @ 09 + nCt, 42 Say Left( aNFiscal[ P_SERVICOS ][ nCt ][ SER_DESCRICAO ], 35 ) 
             NEXT 
          ENDIF 
     CASE nRow==6 
          VPBoxSombra( 02, 31, 16, 77, ,"15/01", "00/01" ) 
          @ 03,32 Say "C�lculo Geral de Comiss�es" 
          @ 04,32 Say "������������Ŀ�����������������������������Ŀ" 
          @ 05,32 Say "� Vendedor.. ��0000� INTERNO �0000� EXTERNO �" 
          @ 06,32 Say "������������Ĵ�����������������������������Ĵ" 
          @ 07,32 Say "� Nome       ��              �              �" 
          @ 08,32 Say "������������Ĵ�����������������������������Ĵ" 
          @ 09,32 Say "� A Vista... ��    �         �    �         �" 
          @ 10,32 Say "� A Prazo... ��    �         �    �         �" 
          @ 11,32 Say "� Recebidas. ��    �         �    �         �" 
          @ 12,32 Say "� Tot.Venda. ��    �         �    �         �" 
          @ 13,32 Say "������������Ĵ�����������������������������Ĵ" 
          @ 14,32 Say "� TOTAL      ��              �              �" 
          @ 15,32 Say "���������������������������������������������" 
          @ 05,47 Say StrZero( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_CODIGO ], 4, 0 ) 
          @ 05,62 Say StrZero( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_CODIGO ], 4, 0 ) 
          @ 07,48 Say aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_DESCRICAO ] 
          @ 07,63 Say aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_DESCRICAO ] 
 
          @ 09,47 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_AVISTA ], "@E 99.9" ) 
          @ 10,47 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_APRAZO ], "@E 99.9" ) 
 
          @ 09,52 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAVISTA ], "@E 99,999.99" ) 
          @ 10,52 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAPRAZO ], "@E 99,999.99" ) 
 
          @ 09,62 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_AVISTA ], "@E 99.9" ) 
          @ 10,62 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_APRAZO ], "@E 99.9" ) 
 
          @ 09,67 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAVISTA ], "@E 99,999.99" ) 
          @ 10,67 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAPRAZO ], "@E 99,999.99" ) 
 
     CASE nRow==7 
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Vlr.Total: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],"@E 99,999,999.99" ) 
 
 
          @ 04,33 Say "Vlr.IPI..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],     "@E 99,999,999.99" ) 
          @ 05,33 Say "Vlr.Nota.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],    "@E 99,999,999.99" ) 
          @ 04,58 Say "%S/Revend: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_SOBREREVENDA ], "@E 999.99" ) 
          @ 05,58 Say "Imp.S/Rev: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRSOBREREV ],  "@E 99999.99" ) 
          @ 06,33 Say "Base ICMs: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ], "@E 99,999,999.99" ) 
          @ 06,58 Say "% COFINS : " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERCOFIN ],     "@E 99.99" )
          @ 07,33 Say "Vlr.ICMs.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],     "@E 99,999,999.99" ) 
          @ 07,58 Say "Vl.COFINS: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRCOFIN ],   "@E 99999.99" )
          @ 08,33 Say "Tot.Serv.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ],"@E 99,999,999.99" ) 
          @ 08,58 Say "Em UFIR.: " +  Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] / aNFiscal[ P_IMPOSTOS ][ IMP_VLRUFIR ], "@E 9999.9999" ) 
          @ 09,33 Say "% ISSQN..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ],     "@E 99.99" ) 
          @ 09,58 Say "Vlr.UFIR: " +  Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRUFIR ],      "@E 9999.9999" ) 
          @ 10,33 Say "Vlr ISSQN: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ],     "@E 99,999,999.99" ) 
          @ 10,58 Say "Desc.Tot: " + aNFiscal[ P_IMPOSTOS ][ IMP_SNUFIR ] 
          @ 11,33 Say "% IRRF ..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ],      "@E 99.99" ) 
          @ 12,33 Say "Vlr IRRF : " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ],      "@E 99,999,999.99" ) 
          VPBoxSombra( 14, 31, 16, 77, , "15/01", "00/01" ) 
          @ 15,33 Say "Total NF.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],   "@E 99,999,999.99" ) 
          VPBoxSombra( 17, 31, 20, 77, , "15/01", "00/01" ) 
          @ 18,33 Say "Acrescimo: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ], "@E 99,999,999.99" ) 
          @ 19,33 Say "Desconto.: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ], "@E 99,999,999.99" ) 
          // ICM Sub Base 
          @ 11,58 Say "ICM S.B.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_ICMSUBBASE ],   "@e 99,999.99" ) 
          @ 12,58 Say "ICM Sub.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_ICMSUBVALOR ],  "@e 99,999.99" ) 
 
     CASE nRow==8 
          VPBoxSombra( 02, 31, 19, 77, , "15/01", "00/01" ) 
          @ 03,33 Say "Valor Seguro: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ], "@E 999,999,999.99" ) 
          @ 03,53 Say "Despesas: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_DESPESAS ], "@E 999,999,999.99" ) 
          @ 04,33 Say "Valor Frete.: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE  ], "@E 999,999,999.99" ) 
          @ 05,33 Say "Tp.Frete....: " + aNFiscal[ P_DIVERSOS ][ DIV_TIPOFRETE ] 
          @ 06,33 Say "Quantidade..: " + aNFiscal[ P_DIVERSOS ][ DIV_QUANTIDADE ] 
          @ 07,33 Say "Especie.....: " + aNFiscal[ P_DIVERSOS ][ DIV_ESPECIE ] 
          @ 08,33 Say "Peso Bruto..: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ], "999999.99" ) + "Kg" 
          @ 09,33 Say "Peso Liquido: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ], "999999.99" ) + "Kg" 
          @ 10,33 Say "Data Saida..: " + DTOC( aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ] ) 
          @ 11,33 Say "Hora Saida..: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_HORASAIDA ], "@R 99:99" ) + "hs." 
          @ 12,33 Say "Placa.......: " + aNFiscal[ P_DIVERSOS ][ DIV_PLACA ] 
          @ 13,32 Say "���������������������������������������������" 
          @ 14,32 Say "�                                           �" 
          @ 15,32 Say "�                                           �" 
          @ 16,32 Say "�                                           �" 
          @ 17,32 Say "�                                           �" 
          @ 18,32 Say "���������������������������������������������" 
          @ 14,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA1 ], 43 ) 
          @ 15,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA2 ], 43 ) 
          @ 16,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA3 ], 43 ) 
          @ 17,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ], 43 ) 
     CASE nRow==9 
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/01" ) 
          @ 03,32 Say "Pr Perc Valor     Dias Ban Dt.Venc   Dt.Pgto " 
          nLin:= 3 
          nCont:= 0 
          nSoma:= 0 
          IF !Empty( aNFiscal[ P_FATURA ] ) 
             FOR nCt:= 1 To LEN( aNFiscal[ P_FATURA ] ) 
                IF nCt <= 10 
                   @ ++nLin, 32 Say StrZero( ++nCont, 1, 0 ) 
                   @ nLin, 34 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] Pict "@E 999.99" 
                   @ nLin, 41 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ] Pict "@E 999,999.99" 
                   @ nLin, 52 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ] Pict "@E 999" 
                   @ nLin, 56 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ] Pict "@E 999" 
                   @ nLin, 60 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ] 
                   @ nLin, 69 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ] 
                ENDIF 
                nSoma:= nSoma + aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ] 
             NEXT 
             @ ++nLin, 34 Say "�������������������������������������������" 
             @ ++nLin, 38 Say "Total da Fatura: " + Tran( nSoma, "@E 999,999,999.99" ) 
             @ ++nLin, 38 Say "�������������������������������������Ŀ" 
             @ ++nLin, 38 Say "���������������� FIM ������������������" 
             @ ++nLin, 38 Say "���������������������������������������" 
          ENDIF 
  ENDCASE 
  DispEnd() 
  LigaMouse( lMouseStatus ) 
  SetColor( cCor ) 
 
 
 
  Function EditDados( aNfiscal, nRow, lNotaManual, aOpcao ) 
  LOCAL GetList:= {} 
  LOCAL nArea, nParcelas, nClasFis, nSomaParcelas, ntabope 
  LOCAL nColuna:= 33 
  LOCAL nCodCLi, cEntSai:= "S", nCodTra 
  LOCAL nPos 
 
  IF lNotaManual==Nil 
     lNotaManual:= .F. 
  ENDIF 
  SetColor( Cor[16] ) 
  Scroll( 02, 31, 21, 78 ) 
  SetColor( "15/01" ) 
  DO CASE 
     CASE nRow==12 
          VPBoxSombra( 02, 31, 14, 77, , "15/01", "00/01" ) 
          nTabOpe:= aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] 
          @ 03,33 Say "Operacao.:" Get nTabOpe Pict "@R 999" Valid TabelaOperacoes( @nTabOpe ) 
          @ 04,33 Say "Condicoes:" Get aNFIscal[ P_DIVERSOS ][ DIV_TABCONDICAO ] Pict "@R 999" 
          READ 
          aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] := nTabOpe 
          OPE->( DBSetOrder( 1 ) ) 
          OPE->( DBSeek( aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] ) ) 
          IF OPE->CLIFOR=="F" 
             nPos:= ASCAN( aOpcao, {|x| x[2]==2 } ) 
             IF nPos > 0 
                aOpcao[ nPos ][ 1 ]:= " Dados do Fornecedor       " 
             ENDIF 
          ELSE 
             nPos:= ASCAN( aOpcao, {|x| x[2]==2 } ) 
             IF nPos > 0 
                aOpcao[ nPos ][ 1 ]:= " Dados do Cliente          " 
             ENDIF 
          ENDIF 
          CND->( DBSetOrder( 1 ) ) 
          CND->( DBSeek( aNFIscal[ P_DIVERSOS ][ DIV_TABCONDICAO ] ) ) 
          aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ]:= OPE->NATOPE 
          CFO->( DBSetOrder( 1 ) ) 
          CFO->( DBSeek( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] ) ) 
          aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= CFO->DESCRI 
          IF LEFT( CFO->ENTSAI, 1 )=="S" 
             aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ]:= "SAIDA" 
          ELSE 
             aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ]:= "ENTRADA" 
          ENDIF 
 
     CASE nRow==3 
          VPBoxSombra( 02, 31, 08, 77, , "15/01", "00/01" ) 
          cEntSai:= LEFT( aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ], 1 ) 
          IF lNotaManual 
             @ 03,nColuna Say "Raz�o....:" Get cEntSai 
          ELSE 
             @ 03,nColuna Say "Raz�o....: " + aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ] 
          ENDIF 
          @ 04,nColuna Say "NF Numero: " + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 9, 0 ) 
          @ 05,nColuna Say "Nat.Oper.:" Get aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] Pict "@R 9.999" 
          @ 06,nColuna Say "Emissao..: " + DTOC( aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ] ) 
          @ 07,nColuna Say "V.Transp.:" Get aNFiscal[ P_CABECALHO ][ CAB_VIATRANSP ] 
          READ 
          IF cEntSai=="S" 
             aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ]:= "SAIDA" 
          ELSE 
             aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ]:= "ENTRADA" 
          ENDIF 
          nArea:= DBSelectAr() 
          DBSelectAr( _COD_NATOPERA ) 
          IF DBSeek( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] ) 
             aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= Left( Descri, 27 ) 
          ENDIF 
          DBSelectAr( nArea ) 
 
     CASE nRow==2 
          VPBoxSombra( 02, 31, 14, 77, , "15/01", "00/01" ) 
          nCodCli:= aNFiscal[ P_CLIENTE ][ CLI_CODIGO ] 
          IF lNotaManual 
              @ 03,nColuna Say "C�digo...:" Get nCodCli Pict "@R 999999" Valid BuscaCodCliente( @nCodCli, aNFiscal, lNotaManual, GetList ) 
          ELSE 
              @ 03,nColuna Say "C�digo...: " + StrZero( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ], 6, 0 ) 
          ENDIF 
          @ 04,nColuna Say "Nome.....:" Get aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ] Pict "@S33" 
          IF EMPTY( aNFiscal[ P_CLIENTE ][ CLI_CGC ] ) .AND. !EMPTY( aNFiscal[ P_CLIENTE ][ CLI_CPF ] ) 
             @ 05,nColuna Say "CPF......:" Get aNFiscal[ P_CLIENTE ][ CLI_CPF ] ; 
               Pict "@R 999.999.999-99" 
          ELSE 
             @ 05,nColuna Say "CGC......:" Get aNFiscal[ P_CLIENTE ][ CLI_CGC ] ; 
               Pict "@R 99.999.999/9999-99" 
          ENDIF 
          @ 06,nColuna Say "Inscri��o:" Get aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ] 
          @ 07,nColuna Say "Endere�o.:" Get aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ] Pict "@S33" 
          @ 08,nColuna Say "Bairro...:" Get aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ] 
          @ 09,nColuna Say "Cidade...:" Get aNFiscal[ P_CLIENTE ][ CLI_CIDADE ] 
          @ 10,nColuna Say "Estado...:" Get aNFIscal[ P_CLIENTE ][ CLI_ESTADO ] 
          @ 11,nColuna Say "CEP......:" Get aNFiscal[ P_CLIENTE ][ CLI_CEP ] Pict "@R 99999-999" 
          @ 12,nColuna Say "Cobran�a.:" Get aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ] 
          @ 13,nColuna Say "Cons/Ind.:" Get aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] Pict "!" 
          READ 
          IF UpDated() .AND. !lNotaManual 
             aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:= 0 
          ENDIF 
     CASE nRow==4 
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/01" ) 
          nCodTra:= aNFIscal[ P_TRANSPORTE ][ TRA_CODIGO ] 
          @ 03,nColuna Say "Codigo...:" Get nCodTra Pict "999" Valid BuscaCodTransportadora( @nCodTra, aNFiscal, GetList ) 
          @ 04,nColuna Say "Nome.....:" Get aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ] Pict "@S33" 
          @ 05,nColuna Say "CGC......:" Get aNFiscal[ P_TRANSPORTE ][ TRA_CGC ] Pict "@R 99.999.999/9999-99" 
          @ 06,nColuna Say "Inscri��o:" Get aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ] 
          @ 07,nColuna Say "Endere�o.:" Get aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ] Pict "@S33" 
          @ 08,nColuna Say "Bairro...:" Get aNFiscal[ P_TRANSPORTE ][ TRA_BAIRRO ] 
          @ 09,nColuna Say "Cidade...:" Get aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ] 
          @ 10,nColuna Say "Estado...:" Get aNFIscal[ P_TRANSPORTE ][ TRA_ESTADO ] 
          @ 11,nColuna Say "CEP......:" Get aNFiscal[ P_TRANSPORTE ][ TRA_CEP ] Pict "@R 99999-999" 
          @ 12,nColuna Say "Fone.....:" Get aNFiscal[ P_TRANSPORTE ][ TRA_FONE ] Pict "@R XXXX-XXXX.XXXX" 
          READ 
          IF UpDated() 
             aNFIscal[ P_TRANSPORTE ][ TRA_CODIGO ]:= nCodTra 
          ENDIF 
     CASE nRow==5 
          /* BROWSE PARA PRODUTOS */ 
          nRow:= 1 
          nTecla:= 0 
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/01" ) 
          oTAB:=tbrowsenew(16,nColuna,19,76) 
          oTAB:addcolumn(tbcolumnnew(,{|| IF( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_QUANTIDADE ]==0, " ", "�" ) + ; 
                               Tran( StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) + ; 
                                        " " + aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_DESCRICAO ] } ) ) 
          oTAB:AUTOLITE:=.f. 
          oTAB:GOTOPBLOCK :={|| nROW:=1} 
          oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aNFiscal[ 5 ] )} 
          oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aNFiscal[ 5 ],@nROW)} 
          oTAB:dehilite() 
          lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
          WHILE .T. 
              oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
              WHILE nextkey()==0 .and. ! oTAB:stabilize() 
              ENDDO 
              @ 03,nColuna Say "Codigo...: " + Tran( StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) + "  " 
              @ 04,nColuna Say "Descricao: " + Left( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_DESCRICAO ], 33 ) 
              @ 05,nColuna Say "Unidade..: " + aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_UNIDADE ] 
              @ 06,nColuna Say "Tabela A.: " + StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAA ], 1, 0 ) 
              @ 07,nColuna Say "Tabela B.: " + StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAB ], 2, 0 ) 
              @ 08,nColuna Say "Clas.Fisc: " + StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CLAFISCAL ], 3, 0 ) 
              @ 09,nColuna Say "Preco Un.: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOVENDA ], "@E 999,999.999" ) 
              @ 10,nColuna Say "Quantia..: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_QUANTIDADE ], "@E 999,999.99" ) 
              @ 11,nColuna Say "Total....: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOTOTAL ], "@E 999,999,999.999" ) 
              @ 12,nColuna Say "% IPI....: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERCENTUALIPI ], "@E 99.99" ) 
              @ 13,nColuna Say "Valor IPI: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_VALORIPI ], "@E 999,999,999.99" ) 
 
              // Percentual de ICMs 
              @ 06,60 Say "Base...: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_BASEICM ],       "@E 9999.99" ) 
              @ 07,60 Say "ICM (%): " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERCENTUALICM ], "@E 9999.999" ) 
              @ 08,60 Say "ICM Sub: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_SUBSTITUICAO ],  "@E 9999.999" ) 
 
              // ICMs Substituicao 
              @ 09,60 Say "    ICMs-MVA    " Color "00/15" 
 
/* 
wait nRow             // 1 
wait PRO_MVAVALOR     // 28 
wait len(anfiscal) 
wait aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_MVAVALOR ] // erro 
*/ 
 
              @ 11,61 Say "Tot >"  + Tran( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_MVATOTAL ],      "@E 99,999.99" ) 
              @ 12,61 Say "(%) >"  + Tran( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_MVAPERCENTUAL ], "@E 99,999.99" ) 
 
              @ 10,61 Say "Vlr >"  + Tran( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_MVAVALOR ],      "@E 99,999.99" ) 
              @ 11,61 Say "Tot >"  + Tran( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_MVATOTAL ],      "@E 99,999.99" ) 
              @ 12,61 Say "(%) >"  + Tran( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_MVAPERCENTUAL ], "@E 99,999.99" ) 
 
              @ 13,61 Say "% Red: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERREDUCAO ], "@E 99.9999" ) 
              @ 14,nColuna Say "����������������� BROWSE ������������������" 
              @ 15,nColuna Say "Codigo   Descri�ao                         " 
              nTecla:= Inkey(0) 
              IF nTecla==K_ESC 
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
                 CASE nTecla==K_SPACE 
                      aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_QUANTIDADE ]:= 0 
                      aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOTOTAL ]:= 0 
                 CASE nTecla==K_ENTER 
                      nClasFis:= 0 
                      nClasFis:= aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CLAFISCAL ] 
                      nSitT01:= aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAA ] 
                      nSitT02:= aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAB ] 
                      classtrib(@nSITT02,2) 
                      @ 06,nColuna Say "Tabela A.:" Get nSitT01 Pict "9" Valid Classtrib( @nSitT01, 1 ) 
                      @ 07,nColuna Say "Tabela B.:" Get nSitT02  Pict "99" Valid Classtrib( @nSitT02, 2 ) 
                      @ 08,nColuna Say "Clas.Fisc:" Get nClasFis Pict "@R 999"  valid verClasse( @nClasFis ) 
                      @ 09,nColuna Say "Preco Un.:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOVENDA ]    Pict "@E 999,999.999"     valid CalculoImposto( aNFiscal ) 
                      @ 10,nColuna Say "Quantia..:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_QUANTIDADE ]    Pict "@E 999,999.99"      valid CalculoImposto( aNFiscal ) 
                      @ 11,nColuna Say "Total....:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOTOTAL ]    Pict "@E 999,999,999.999" valid CalculoImposto( aNFiscal ) 
                      @ 12,nColuna Say "% IPI....:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERCENTUALIPI ] Pict "@E 99.99"           valid CalculoImposto( aNFiscal ) 
                      @ 13,nColuna Say "Valor IPI:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_VALORIPI ]      Pict "@E 999,999,999.99"  valid CalculoImposto( aNFiscal ) 
                      @ 13,61 Say "% Red:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERREDUCAO ] Pict "@R 99.9999" 
                      Read 
                      aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CLAFISCAL ]:= nClasFis 
                      aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAA ]:= nSitT01 
                      aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAB ]:= nSitT02 
                      oTab:RefreshAll() 
                      WHILE !oTab:Stabilize() 
                      ENDDO 
                      CalculoImposto( aNFiscal ) 
                 CASE nTecla==K_INS 
                      cCodPro:= "0000000" 
                      VisualProdutos( cCodPro ) 
                      IF LastKey()==K_ENTER 
                         AAdd( aNFiscal[ P_PRODUTOS ], { VAL( ALLTRIM( MPR->INDICE ) ),; 
                                                         MPR->DESCRI,; 
                                                         MPR->UNIDAD,; 
                                                         MPR->PRECOV,; 
                                                         MPR->PRECOV,; 
                                                         MPR->SITT01,; 
                                                         MPR->SITT02,; 
                                                         MPR->CLAFIS,; 
                                                         1,;     && Quantidade 
                                                         0,; 
                                                         MPR->IPI___,; 
                                                         MPR->ICM___,; 
                                                         MPR->MPrima,; 
                                                         PegaCodFiscal( MPR->ClaFis ),; 
                                                         MPR->CodFab,; 
                                                         1,; 
                                                         ( 1 * MPR->PRECOV ),; 
                                                         MPR->PerRed,; 
                                                         0,; 
                                                         MPR->ORIGEM,; 
                                                         0,; 
                                                         PRE->CODIGO,; 
                                                         0,; 
                                                         0,; 
                                                         0,; 
                                                         0,; 
                                                         0,; 
                                                         0,; 
                                                         0,; 
                                                         0,; 
                                                         0 } ) 
                         nRow:= LEN( aNFiscal[ P_PRODUTOS ] ) 
                         oTab:RefreshAll() 
                         WHILE !oTAb:Stabilize() 
                         ENDDO 
//                         Keyboard Chr( K_ENTER ) 
                      ENDIF 
                 OTHERWISE                ;tone(125); tone(300) 
              ENDCASE 
              oTAB:refreshcurrent() 
              oTAB:stabilize() 
          ENDDO 
          /* FIM BROWSE PARA PRODUTOS */ 
 
     CASE nRow==11 
          /* BROWSE PARA SERVICOS */ 
          nRow:= 1 
          nTecla:= 0 
          IF Len( aNFiscal[ P_SERVICOS ] ) <= 0 
             DBSelectAr( "MPR" ) 
             Set Filter To LEFT( INDICE, 3 )==SWSet( _GER_GRUPOSERVICOS ) 
             cCodPro:= "0000000" 
             VisualProdutos( cCodPro ) 
 
             Mensagem( "Aguarde... Buscando informacoes deste servico..." ) 
             AAdd( aNFiscal[ P_SERVICOS ], { VAL( MPR->INDICE ),; 
                                                  MPR->Descri,; 
                                                  MPR->PRECOV,; 
                                                  MPR->PRECOV*1,; 
                                                   1,; 
                                                  MPR->MPRIMA } ) 
 
             Set Filter To 
 
          ENDIF 
          Mensagem( "[INS]Novo [ENTER]Altera" ) 
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/01" ) 
          oTAB:=tbrowsenew( 10, nColuna, 19, 76 ) 
          oTAB:addcolumn(tbcolumnnew(,{|| IF( aNFiscal[ P_SERVICOS ][ nRow ][ SER_QUANTIDADE ]==0, " ", "�" ) + ; 
                               Tran( StrZero( aNFiscal[ P_SERVICOS ][ nRow ][ SER_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) + ; 
                                        " " + aNFiscal[ P_SERVICOS ][ nRow ][ SER_DESCRICAO ] } ) ) 
          oTAB:AUTOLITE:=.f. 
          oTAB:GOTOPBLOCK :={|| nROW:=1} 
          oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aNFiscal[ P_SERVICOS ] )} 
          oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aNFiscal[ P_SERVICOS ], @nROW ) } 
          oTAB:dehilite() 
          lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
          WHILE .T. 
              oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
              WHILE nextkey()==0 .and. ! oTAB:stabilize() 
              ENDDO 
              @ 03,nColuna Say "Codigo...: " + Tran( StrZero( aNFiscal[ P_SERVICOS ][ nRow ][ SER_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) + "  " 
              @ 04,nColuna Say "Descricao: " + Left( aNFiscal[ P_SERVICOS ][ nRow ][ SER_DESCRICAO ], 33 ) 
              @ 05,nColuna Say "Preco Un.: " + TRAN( aNFiscal[ P_SERVICOS ][ nRow ][ SER_UNITARIO ], "@E 999,999.999" ) 
              @ 06,nColuna Say "Quantia..: " + TRAN( aNFiscal[ P_SERVICOS ][ nRow ][ SER_QUANTIDADE ], "@E 999,999.99" ) 
              @ 07,nColuna Say "Total....: " + TRAN( aNFiscal[ P_SERVICOS ][ nRow ][ SER_TOTAL ], "@E 999,999,999.999" ) 
              @ 08,nColuna Say "����������������� BROWSE ������������������" 
              @ 09,nColuna Say "Codigo   Descri�ao                         " 
              nTecla:= Inkey(0) 
              IF nTecla==K_ESC 
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
                 CASE nTecla==K_SPACE .or. nTecla==K_DEL 
 
                      aNFiscal[ P_SERVICOS ][ nRow ][ SER_QUANTIDADE ]:= 0 
                      aNFiscal[ P_SERVICOS ][ nRow ][ SER_TOTAL ]:= 0 
 
                 CASE nTecla==K_ENTER 
 
                      @ 05,nColuna Say "Preco Un.:" Get aNFiscal[ P_SERVICOS ][ nRow ][ SER_UNITARIO ]      Pict "@E 999,999.999"     valid CalculoImposto( aNFiscal ) 
                      @ 06,nColuna Say "Quantia..:" Get aNFiscal[ P_SERVICOS ][ nRow ][ SER_QUANTIDADE ]    Pict "@E 999,999.99"      valid CalculoImposto( aNFiscal ) 
                      Read 
 
                      aNFiscal[ P_SERVICOS ][ nRow ][ SER_TOTAL ]:= aNFiscal[ P_SERVICOS ][ nRow ][ SER_UNITARIO ] * aNFiscal[ P_SERVICOS ][ nRow ][ SER_QUANTIDADE ] 
                      @ 07,nColuna Say "Total....: " + Tran( aNFiscal[ P_SERVICOS ][ nRow ][ SER_TOTAL ], "@E 999,999,999.999" ) 
                      CalculoImposto( aNFiscal ) 
 
                      oTab:RefreshAll() 
                      WHILE !oTab:Stabilize() 
                      ENDDO 
 
                 CASE nTecla==K_INS 
                      cCodPro:= "0000000" 
                      DBSelectAr( "MPR" ) 
                      Set Filter To LEFT( INDICE, 3 )==SWSet( _GER_GRUPOSERVICOS ) 
                      VisualProdutos( cCodPro ) 
                      Set Filter To 
                      IF LastKey()==K_ENTER 
 
                         /* Adicionando servico */ 
                         AAdd( aNFiscal[ P_SERVICOS ], { VAL( MPR->INDICE ),; 
                                                       MPR->Descri,; 
                                                       MPR->PRECOV,; 
                                                       MPR->PRECOV*1,; 
                                                       1,; 
                                                       MPR->MPRIMA } ) 
 
                         nRow:= LEN( aNFiscal[ P_SERVICOS ] ) 
                         oTab:RefreshAll() 
                         WHILE !oTAb:Stabilize() 
                         ENDDO 
                      ENDIF 
                      DBSelectAr( _COD_NFISCAL ) 
                 OTHERWISE                ;tone(125); tone(300) 
              ENDCASE 
              oTAB:refreshcurrent() 
              oTAB:stabilize() 
          ENDDO 
          /* FIM BROWSE PARA SERVICOS */ 
 
     CASE nRow==6 
 
          DisplayDados( aNFiscal, 6 ) 
 
          //////============== VENDEDORES =============////// 
          @ 05,47 Get aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_CODIGO ] Pict "@R 9999" 
          @ 05,62 Get aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_CODIGO ] Pict "@R 9999" 
          READ 
          VEN->( DBSetOrder( 1 )) 
 
          // Vendedor Interno 
          VEN->( DBSeek( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_CODIGO ] ) ) 
          aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_DESCRICAO ]:= LEFT( VEN->DESCRI, AT( " ", VEN->DESCRI ) ) 
 
          // Vendedor Externo 
          VEN->( DBSeek( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_CODIGO ] ) ) 
          aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_DESCRICAO ]:= LEFT( VEN->DESCRI, AT( " ", VEN->DESCRI ) ) 
 
     CASE nRow==7 
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/01" ) 
          @ 04,58 Say "%S/Revend: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_SOBREREVENDA ], "@E 999.99" ) 
          @ 05,58 Say "Imp.S/Rev: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRSOBREREV ],  "@E 99999.99" ) 
          @ 03,nColuna Say "Vlr.Total: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],"@E 99,999,999.99" ) 
 
          @ 04,nColuna Say "Vlr.IPI..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],     "@E 99,999,999.99" ) 
          @ 05,nColuna Say "Vlr.Nota.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],    "@E 99,999,999.99" ) 
          @ 06,nColuna Say "Base ICMs: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ], "@E 99,999,999.99" ) 
          @ 06,58 Say "% COFINS : " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERCOFIN ], "@E 99.99" )
          @ 07,nColuna Say "Vlr.ICMs.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],     "@E 99,999,999.99" ) 
          @ 07,58 Say "Vl.COFINS: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRCOFIN ],     "@E 99,999,999.99" )
          @ 08,nColuna Say "Tot.Serv.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ],"@E 99,999,999.99" ) 
          @ 08,58 Say "Em UFIR.: " +  Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] / aNFiscal[ P_IMPOSTOS ][ IMP_VLRUFIR ], "@E 9999.9999" ) 
          @ 09,nColuna Say "% ISSQN..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ],     "@E 99.99" ) 
          @ 10,nColuna Say "Vlr ISSQN: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ],     "@E 99,999,999.99" ) 
          @ 11,nColuna Say "% IRRF ..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ],     "@E 99.99" ) 
          @ 12,nColuna Say "Vlr IRRF : " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ],     "@E 99,999,999.99" ) 
          IF SWSet( _GER_IMPSR ) > 0 
             @ 04,58 Say "%S/Revend:" Get aNFiscal[ P_IMPOSTOS ][ IMP_SOBREREVENDA ] pict "@E 999.99" 
          ENDIF 
          IF SWSet( _GER_LIMUFIR ) > 0 
             @ 09,58 Say "Vlr.UFIR:" Get aNFiscal[ P_IMPOSTOS ][ IMP_VLRUFIR ] Pict "@E 9999.9999" 
             @ 10,58 Say "Desc.Tot:" Get aNFiscal[ P_IMPOSTOS ][ IMP_SNUFIR ]  Pict "!" 
          ENDIF 
          VPBoxSombra( 14, 31, 16, 77, , "15/01", "00/01" ) 
 
          @ 15,nColuna Say "Total NF.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],   "@E 99,999,999.99" ) 
 
          VPBoxSombra( 17, 31, 20, 77, , "15/01", "00/01" ) 
          @ 18,nColuna Say "Acrescimo:" Get aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ] Pict "@E 99,999,999.99" 
          @ 19,nColuna Say "Desconto.:" Get aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ]  Pict "@E 99,999,999.99" 
          Read 
     CASE nRow==8 
          VPBoxSombra( 02, 31, 19, 77, , "15/01", "00/01" ) 
          @ 03,nColuna Say "Valor Seguro:" Get aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ] Pict "@E 999,999,999.99" 
          @ 03,53      Say "Despesas: "    gET aNFiscal[ P_DIVERSOS ][ DIV_DESPESAS ]    pICT "@E 999,999,999.99" 
          @ 04,nColuna Say "Valor Frete.:" Get aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE  ] Pict "@E 999,999,999.99" 
          @ 05,nColuna Say "Tp.Frete....:" Get aNFiscal[ P_DIVERSOS ][ DIV_TIPOFRETE ]   Pict "9" 
          @ 06,nColuna Say "Quantidade..:" Get aNFiscal[ P_DIVERSOS ][ DIV_QUANTIDADE ] 
          @ 07,nColuna Say "Especie.....:" Get aNFiscal[ P_DIVERSOS ][ DIV_ESPECIE ] 
          @ 08,nColuna Say "Peso Bruto..:" Get aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ] Pict "@E 999999.99" 
          @ 09,nColuna Say "Peso Liquido:" Get aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ] Pict "@E 999999.99" 
          @ 10,nColuna Say "Data Saida..:" Get aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ] 
          @ 11,nColuna Say "Hora Saida..:" Get aNFiscal[ P_DIVERSOS ][ DIV_HORASAIDA ] Pict "@R 99:99" 
          @ 12,nColuna Say "Placa.......:" Get aNFiscal[ P_DIVERSOS ][ DIV_PLACA ] Pict "@!" 
          @ 13,nColuna-1 Say "���������������������������������������������" 
          @ 14,nColuna-1 Say "�                                           �" 
          @ 15,nColuna-1 Say "�                                           �" 
          @ 16,nColuna-1 Say "�                                           �" 
          @ 17,nColuna-1 Say "�                                           �" 
          @ 18,nColuna-1 Say "���������������������������������������������" 
          #ifndef CONECSUL 
             @ 14,nColuna Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA1 ] Pict "@S43" 
             @ 15,nColuna Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA2 ] Pict "@S43" 
          #endif 
          @ 16,nColuna Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA3 ] Pict "@S43" 
          @ 17,nColuna Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ] Pict "@S43" 
          Read 
 
     CASE nRow==9 
          nLin:= 3 
          nCont:= 0 
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/01" ) 
          aDias:= {} 
          cString:= aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] + "/" 
          nPos:= 0 
          IF Empty( aDias ) 
             FOR nCt:= 1 TO Len( aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] ) 
                 AAdd( aDias, Val( SubStr( cString, 1, At( "/", cString ) - 1 ) ) ) 
                 cString:= SubStr( cString, At( "/", cString ) + 1 ) 
             NEXT 
          ENDIF 
 
          IF aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 0 
             aNFiscal[ P_DIVERSOS ][ DIV_FATURA ]:= StrVezes( "/", aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] ) + 1 
          ENDIF 
 
          nFatura:= aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
 
          @ 03,nColuna Say "Qt. parcelas p/ fatura desta nota?" Get aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] Pict "99" valid ; 
                      aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] > 0 
          READ 
          IF Len( aNFiscal[ P_FATURA ] ) < aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
             nParcelas:= aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] - Len( aNFiscal[ P_FATURA ] ) 
             FOR nCt:= 1 TO nParcelas 
                 AAdd( aNFiscal[ P_FATURA ], { 0, 0, 0, 0, 0, Date(), " ", CTOD( "  /  /  " ), Space( 10 ), 0 } ) 
             NEXT 
          ENDIF 
          DO CASE 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 1 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 100 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 2 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 50 
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 50 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 3 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 34 
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 33 
                  aNFiscal[ P_FATURA ][3][ FAT_PERCENTUAL ]:= 33 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 4 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 25 
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 25 
                  aNFiscal[ P_FATURA ][3][ FAT_PERCENTUAL ]:= 25 
                  aNFiscal[ P_FATURA ][4][ FAT_PERCENTUAL ]:= 25 
             OTHERWISE 
                  ASIZE( aNFiscal[ P_FATURA ], aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] ) 
                  FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] ) 
                      IF aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] == 0 .OR.; 
                         ! nFatura == aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
                         aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ]:= 100 / aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
                      ENDIF 
                  NEXT 
          ENDCASE 
          @ 03,nColuna Say "Pr Perc Valor     Dias Ban Dt.Venc   Dt.Pgto " 
          WHILE LastKey() <> K_ESC 
               /* Scroll quando a tela estiver cheia */ 
               IF nLin + 1 > 17 
                  nLin:= 16 
                  Scroll( 03, nColuna, 17, 76, 1 ) 
               ENDIF 
               @ ++nLin, nColuna Say StrZero( ++nCont, 1, 0 ) 
               IF Len( aDias ) >= nCont 
                  IF aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ] <= 0 
                     aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]:= aDias[ nCont ] 
                  ENDIF 
               ENDIF 
               VerDias( aNFiscal ) 
               @ nLin, nColuna+2  Get aNFiscal[ P_FATURA ][ nCont ][ FAT_PERCENTUAL ] Pict "@E 999.99" Valid VerPercentual( aNFiscal ) 
               @ nLin, nColuna+8  Get aNFiscal[ P_FATURA ][ nCont ][ FAT_VALOR ]      Pict "@E 999,999.99" Valid verValorPercentual( aNFiscal, nCont, GetList ) 
               @ nLin, nColuna+19 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]       Pict "@E 999" Valid VerDias( aNFiscal ) 
               @ nLin, nColuna+23 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_BANCO ]      Pict "@E 999" 
               @ nLin, nColuna+27 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ] 
               @ nLin, nColuna+36 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_PAGAMENTO ] 
               READ 
 
               IF aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ] - DATE() <> aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ] 
                  aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]:= aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ] - DATE() 
               ENDIF 
 
               IF !Empty( aNFiscal[ P_FATURA ][ nCont ][ FAT_PAGAMENTO ] ) .AND. LastKey() <> K_ESC 
                  cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                  VPBOX( nLin, 50, nLin + 3, 75 ) 
                  @ nLin+1, 51 Say "Pagamento em cheque n�:" 
                  @ nLin+2, 60 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_CHEQUE ] 
                  READ 
                  ScreenRest( cTelaRes ) 
               ENDIF 
               IF nCont + 1 > Len( aNfiscal[ P_FATURA ] ) 
                  EXIT 
               ENDIF 
          ENDDO 
  ENDCASE 
  RETURN Nil 
 
 
  Function verPercentual( aNFiscal ) 
     FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] ) 
         aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ]:= ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] ) / 100 
     NEXT 
  Return .t. 
 
  Function verValorPercentual( aNFiscal, nPosicao, GetList ) 
  Local nSomaPercentuais:= 0 
     FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] ) 
         aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ]:= ( ( aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ] / aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] ) * 100 ) 
     NEXT 
     FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] ) 
         IF nCt <= nPosicao 
            nSomaPercentuais+= aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] 
         ELSEIF nCt > nPosicao 
            aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ]:= ( 100 - nSomaPercentuais ) / ( Len( aNFiscal[ P_FATURA ] ) - nPosicao ) 
         ENDIF 
     NEXT 
     FOR nCt:= 1 TO Len( GetList ) 
         GetList[ nCt ]:Display() 
     NEXT 
  Return .T. 
 
 
 
  Static Function verDias( aNFiscal ) 
     FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] ) 
         aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ]:= Date() + aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ] 
     NEXT 
  Return .T. 
 
 
 
 
  /* 
 
    PEDIDO ACEITO 
    Guardar o Status de Pedido 
 
  */ 
  Static function pedidoaceito( lOk ) 
  Static lGuardar 
  If lOk <> Nil 
     lGuardar:= lOk 
  Endif 
  Return lGuardar 
 
 
Function ParcelasExpande( aNFiscal ) 
local  nLin:= 3,  nCont:= 0, aDias:= {},; 
       nPos:= 0, nFatura:= 0, nColuna:= 13 
 
 
       cString:= aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] + "/" 
 
 
          IF Empty( aDias ) 
             FOR nCt:= 1 TO Len( aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] ) 
                 AAdd( aDias, Val( SubStr( cString, 1, At( "/", cString ) - 1 ) ) ) 
                 cString:= SubStr( cString, At( "/", cString ) + 1 ) 
             NEXT 
          ENDIF 
 
          IF aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 0 
             aNFiscal[ P_DIVERSOS ][ DIV_FATURA ]:= StrVezes( "/", aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] ) + 1 
          ENDIF 
 
          nFatura:= aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
 
          @ 03,nColuna Say "Qt. parcelas p/ fatura desta nota?" Get aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] Pict "99" valid ; 
                      aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] > 0 
 
          IF Len( aNFiscal[ P_FATURA ] ) < aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
             nParcelas:= aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] - Len( aNFiscal[ P_FATURA ] ) 
             FOR nCt:= 1 TO nParcelas 
                 AAdd( aNFiscal[ P_FATURA ], { 0, 0, 0, 0, 0, Date(), " ", CTOD( "  /  /  " ), Space( 10 ), 0 } ) 
             NEXT 
          ENDIF 
          DO CASE 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 1 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 100 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 2 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 50 
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 50 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 3 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 34 
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 33 
                  aNFiscal[ P_FATURA ][3][ FAT_PERCENTUAL ]:= 33 
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 4 
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 25 
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 25 
                  aNFiscal[ P_FATURA ][3][ FAT_PERCENTUAL ]:= 25 
                  aNFiscal[ P_FATURA ][4][ FAT_PERCENTUAL ]:= 25 
             OTHERWISE 
                  ASIZE( aNFiscal[ P_FATURA ], aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] ) 
                  FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] ) 
                      IF aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] == 0 .OR.; 
                         ! nFatura == aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
                         aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ]:= 100 / aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] 
                      ENDIF 
                  NEXT 
          ENDCASE 
//          @ 03,nColuna Say "Pr Perc Valor     Dias Ban Dt.Venc   Dt.Pgto " 
          WHILE LastKey() <> K_ESC 
//               /* Scroll quando a tela estiver cheia */ 
               IF nLin + 1 > 17 
                  nLin:= 16 
//                  Scroll( 03, nColuna, 17, 76, 1 ) 
               ENDIF 
               @ ++nLin, nColuna Say StrZero( ++nCont, 1, 0 ) 
               IF Len( aDias ) >= nCont 
                  IF aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ] <= 0 
                     aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]:= aDias[ nCont ] 
                  ENDIF 
               ENDIF 
               VerDias( aNFiscal ) 
               Keyboard Chr( K_ENTER ) + Chr( K_ENTER ) + Chr( K_ENTER ) + Chr( K_ENTER ) + Chr( K_ENTER ) + Chr( K_ENTER ) + Chr( K_ENTER ) 
               @ nLin, nColuna+2  Get aNFiscal[ P_FATURA ][ nCont ][ FAT_PERCENTUAL ] Pict "@E 999.99" Valid VerPercentual( aNFiscal ) 
               @ nLin, nColuna+8  Get aNFiscal[ P_FATURA ][ nCont ][ FAT_VALOR ]      Pict "@E 999,999.99" Valid verValorPercentual( aNFiscal, nCont, GetList ) 
               @ nLin, nColuna+19 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]       Pict "@E 999" Valid VerDias( aNFiscal ) 
               @ nLin, nColuna+23 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_BANCO ]      Pict "@E 999" 
               @ nLin, nColuna+27 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ] 
               @ nLin, nColuna+36 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_PAGAMENTO ] 
               READ 
 
               IF aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ] - DATE() <> aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ] 
                  aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]:= aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ] - DATE() 
               ENDIF 
 
               IF nCont + 1 > Len( aNfiscal[ P_FATURA ] ) 
                  EXIT 
               ENDIF 
          ENDDO 
 
RETURN .T. 
 
 
 
 
  /***** 
  �������������Ŀ 
  � Funcao      � GRAVACAO 
  � Finalidade  � Verificar integridade de dados e efetuar a gravacao dos mesmos 
  � Parametros  � Nil 
  � Retorno     � Nil 
  � Programador � Valmor Pereira Flores 
  � Data        � 12/06/97 
  ��������������� 
  */ 
  Static Function Gravacao( aNFiscal, nNumero, lEspecial ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local aCorTamQua 
  Local nVlrFaturado:= 0 
  Local nCt:= 0, nLin:= 5, nCol:= 20, lOk:= .F.,; 
        lErro1:= .F., lErro2:= .F., lErro3:= .F., lErro4:= .F.,; 
        lErro5:= .F., lErro6:= .F., lMouse:= MouseStatus(),; 
        nQuantidade:= 0, nQtdPermitida:= 0, lAvisar:= .t. 
 
  // Especial = Processamento previo de pedidos 
  IF lEspecial = Nil 
     lEspecial:= .F. 
  ENDIF 
 
  /* Limpa as numeracoes armazenadas */ 
  NumeroNota( "LIMPAR" ) 
  DesligaMouse() 
  SetColor( COR[ 24 ] ) 
  aNFiscal[ P_TESTE ][ TES_ERROS ]:= 0   /* Limpa a matriz */ 
  aNFiscal[ P_TESTE ][ TES_ERROS ]:= {}  /* Refaz a matriz */ 
 
  VPBox( nLin, nCol, nLin+15, nCol + 47, "TESTE PRE-GRAVACAO", _COR_BROW_BOX ) 
  SetColor( _COR_BROW_BOX ) 
  ++nLin 
  @ nLin+01, nCol+1 Say "� Testes de dados �����������������Ŀ� Sit Ŀ" 
  @ nLin+02, nCol+1 Say "�                                   ��   0% �" 
  @ nLin+03, nCol+1 Say "�  [ ] Integridade de Cadastros     ��  10% �" 
  @ nLin+04, nCol+1 Say "�  [ ] Verificacao de CGC / CPF     ��  20% �" 
  @ nLin+05, nCol+1 Say "�  [ ] Integridade de Calculos      ��  30% �" 
  @ nLin+06, nCol+1 Say "�  [ ] Integridade de Pedidos       ��  40% �" 
  @ nLin+07, nCol+1 Say "�  [ ] Diferencas entre arquivos    ��  50% �" 
  @ nLin+08, nCol+1 Say "�  [ ] Baixa de Estoque             ��  60% �" 
  @ nLin+09, nCol+1 Say "�                                   ��  70% �" 
  @ nLin+10, nCol+1 Say "�����������������������������������Ĵ�  80% �" 
  @ nLin+11, nCol+1 Say "�  Numero da Nota fiscal:           ��  90% �" 
  @ nLin+12, nCol+1 Say "�  Data de Emissao......:           �� 100% �" 
  @ nLin+13, nCol+1 Say "���������������������������������������������" 
 
  Mensagem( "Dados Cadastrais: CLIENTES ******************" ) 
  /* CADASTRO DE CLIENTES */ 
  IF aNFiscal[ P_CLIENTE ][ CLI_CGC ] == Space( 14 ) .AND.; 
     aNFiscal[ P_CLIENTE ][ CLI_CPF ] == Space( 11 ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta CGC ou CPF no cadastro do cliente." ) 
  ENDIF 
  IF aNfiscal[ P_CLIENTE ][ CLI_CONSIND ] == Space( 1 ) 
     AAdd( aNFIscal[ P_TESTE ][ TES_ERROS ], "Falta informar no cliente se e' [C]ONSUMO OU [I]NDUSTRIA..." ) 
  ENDIF 
  IF aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ] == Space( 45 ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta razao social do cliente." ) 
  ENDIF 
  IF aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ] == Space( 35 ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta Endereco do cliente." ) 
  ENDIF 
  IF aNFiscal[ P_CLIENTE ][ CLI_CEP ] == Space( 8 ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta o cep do cliente." ) 
  ENDIF 
  IF aNFiscal[ P_CLIENTE ][ CLI_ESTADO ] == Space( 2 ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta o estado do cliente." ) 
  ENDIF 
 
  Mensagem( "Dados Cadastrais: TRANSPORTADORA ************" ) 
  IF aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ] == Space( 20 ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta o nome da transportadora." ) 
  ENDIF 
 
  IF Len( aNFiscal[ P_TESTE ][ TES_ERROS ] ) == 0 
     lErro1:= .F. 
     @ nLin + 03, nCol + 05 Say "X" 
  ELSE 
     lErro1:= .T. 
     @ nLin + 03, nCol + 05 Say "!" 
  ENDIF 
 
  Mensagem( "Verificando a integridade de CGC / CPF, aguarde..." ) 
  //Inkey( .10 ) 
  @ nLin + 04, nCol + 05 Say "X" 
  Mensagem( "Verificando a integridade dos calculos, aguarde..." ) 
  //Inkey( .10 ) 
  @ nLin + 05, nCol + 05 Say "X" 
  Mensagem( "Verificando a integridade dos pedidos, aguarde..." ) 
 
  Mensagem( "Integridade de Calculo: VERIFICACAO DA FATURA" ) 
  IF Empty( aNFiscal[ P_FATURA ] ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Fatura nao foi lancada." ) 
     lErro4:= .T. 
  ENDIF 
 
  Mensagem( "Verificando o lancamento da fatura, aguarde..." ) 
  nSoma:= 0 
  IF !Empty( aNFiscal[ P_FATURA ] ) 
     FOR nCt:= 1 To LEN( aNFiscal[ P_FATURA ] ) 
         nSoma:= nSoma + aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ] 
     NEXT 
  ENDIF 
  IF !Tran( nSoma, "@E 999,999,999.99" ) == Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ], "@E 999,999,999.99" ) 
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Total da fatura diferente do total da Nota." ) 
     lErro4:= .T. 
  ENDIF 
  Inkey( .10 ) 
 
  @ nLin + 06, nCol + 05 Say "X" 
  Mensagem( "Verificando alteracoes efetuadas nas informacoes, aguarde..." ) 
 
  /* verificacao de estoques a movimentar */ 
     FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
        IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 
           IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 .OR.; 
              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ] > 0 
              OPE->( DBSetOrder( 1 ) ) 
              OPE->( DBSeek( aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] ) ) 
              IF OPE->ENTSAI $ "+-ES1234 " 
              ELSE 
                 AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "(Alerta) Operacao com movimento indefinido para o seguinte produto: " ) 
                 AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "         " + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
                 lErro6:= .T. 
              ENDIF 
           ELSE 
              AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "(Alerta) Este produto esta sem preco e qtd e n�o vai movimentar o estoque: " ) 
              AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ],  aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
              lErro6:= .T. 
           ENDIF 
        ENDIF 
     NEXT 
 
 
 
 
/* 
  DBSelectAr( _COD_PEDBAIXA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To 
  cNumeroPedido:= StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  index On CODPRO TO INDICE29.NTX ; 
                  EVAL {|| Processo() } FOR CODIGO == cNumeroPedido 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Set Index To INDICE29.NTX 
  DBGOTOP() 
  FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
      nQuantidade:= 0 
      DBSeek( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) + "     ", .T. ) 
      WHILE StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) + "     " == CODPRO 
          nQuantidade:= nQuantidade + QUANT_ 
          DBSkip() 
          IF EOF() 
             EXIT 
          ENDIF 
      ENDDO 
      IF ( nQuantidade + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] ) > aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QTDPADRAO ] 
         nQtdPermitida:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QTDPADRAO ] - nQuantidade 
         IF nQtdPermitida < 0 
            nQtdPermitida:= 0 
         ENDIF 
         AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "No produto " + StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) + " foi excedida a qtd. solicitada. Use " + AllTrim( Tran( nQtdPermitida, "@E 999,999.999"  ) ) + " na qtd."  ) 
         lErro2:= .T. 
      ENDIF 
  NEXT 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to &gdir/pb_ind01.ntx 
  #else 
    Set Index To &GDIR\PB_IND01.NTX 
  #endif
  //--------------- FIM DE VERIFICACAO DE ENTREGAS ---------------------- 
  Inkey( .10 ) 
 
*/ 
 
  @ nLin + 07, nCol + 05 Say "X" 
  Mensagem( "Verificando alteracoes efetuadas nas informacoes, aguarde..." ) 
  Inkey( .10 ) 
  @ nLin + 08, nCol + 05 Say "X" 
 
  @ nLin + 03, nCol + 05 Say IF( lErro1, "!", "X" ) 
  @ nLin + 04, nCol + 05 Say IF( lErro2, "!", "X" ) 
  @ nLin + 05, nCol + 05 Say IF( lErro3, "!", "X" ) 
  @ nLin + 06, nCol + 05 Say IF( lErro4, "!", "X" ) 
  @ nLin + 07, nCol + 05 Say IF( lErro5, "!", "X" ) 
  @ nLin + 08, nCol + 05 Say IF( lErro6, "!", "X" ) 
 
  Mensagem( "Verificacoes efetuadas. Pressione ENTER para continuar." ) 
  IF ! lEspecial 
     VPBOX( 0, 0, 22, 79, " GRAVACAO DE NOTA FISCAL ", _COR_BROW_BOX ) 
  ELSE 
     VPBOX( 0, 0, 22, 79, " PRE-PROCESSAMENTO DE PEDIDOS ", _COR_BROW_BOX ) 
  ENDIF 
  SetColor( _COR_BROW_BOX ) 
  FOR nCt:= 1 To Len( aNFiscal[ P_TESTE ][ TES_ERROS ] ) 
      @ nCt, 02 Say aNFiscal[ P_TESTE ][ TES_ERROS ][ nCt ] 
  NEXT 
  IF Len( aNFiscal[ P_TESTE ][ TES_ERROS ] ) == 0 
     @ 02,02 Say "Nenhum erro foi encontrado nos dados analisados..." 
     @ 03,02 Say "Os dados ja podem ser gravados com seguranca.     " 
     nOpcao:= 1 
  ELSE 
     nOpcao:= 2 
  ENDIF 

  IF lEspecial
     nOpcao:= 1
     lAvisar:= .F.
  ELSE
     Set Key K_CTRL_TAB To AjustaNumeroNota()
     DispBox( 17, 49, 21, 75 )

     @ 18,50 Say "Voce deseja" 
     @ 19,50 Prompt                 " 1. Gravar               " 
     @ 20,50 Prompt IF( nOpcao = 2, " 2. Corrigir Erros       ",; 
                                    " 2. Retornar             " ) 
     Menu To nOpcao 
     Set Key K_CTRL_TAB To
  ENDIF
 
 
  IF nOpcao == 1 
     Gravando( "GRAVANDO! Aguarde..." ) 
     Gravando( "���������������������������������������������������������������������" ) 
     For nCt:= 2 To Len( aNFiscal ) 
         For nCt2:= 1 To Len( aNFiscal[ nCt ] ) 
             Gravando( aNFiscal[ nCt ][ nCt2 ] ) 
         Next 
     Next 
     Gravando( "Atualizando arquivo de notas fiscais, aguarde... " ) 
 
     /* Retornar Numero Nota, se numero estiver em branco */ 
     IF nNumero = Nil 
        nNumero:= NumeroNota()[1] 
     ENDIF 
 
     aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ]:= NumeroNota()[2] 
 
     /* Grava Informacao no cadastro de Pedido */ 
     DBSelectAr( _COD_PEDIDO ) 
     IF !EOF() 
        IF netrlock() 
           Replace CODNF_ With nNumero 
        ENDIF 
     ENDIF 
 
     Gravando( "Atualizando arquivos auxiliares..." ) 
     DBSelectAr( _COD_DETALHE ) 
     DBseek( PED->CODIGO ) 
     While !eof() .and. CODPED = PED->CODIGO 
        IF !Empty( DET->DETAL1 ) .or.; 
           !Empty( DET->DETAL2 ) .or.; 
           !Empty( DET->DETAL3 ) 
           D_N->( DBAppend() ) 
           if D_N->( netrlock() ) 
              Replace D_N->CODNF_ with nNumero,; 
                      D_N->ORDEM_ With DET->ORDEM_,; 
                      D_N->INDICE With DET->INDICE,; 
                      D_N->DETAL1 With DET->DETAL1,; 
                      D_N->DETAL2 With DET->DETAL2,; 
                      D_N->DETAL3 With DET->DETAL3 
           endif 
        ENDIF 
        DBskip() 
     enddo 
 
     DBSelectAr( _COD_NFISCAL ) 
     aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ]:= nNumero 
 
     // NOTAS ESPECIAIS NAO POSSUEM CABECALHO 
     // E, TAMBEM NAO POSSUEM PRODUTOS 
     IF ! lEspecial 
 
         DBAppend() 
 
         Gravando( "Cabecalho da Nota Fiscal" ) 
         Replace NUMERO With nNumero,; 
                 NATOPE With aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ],; 
                 DATAEM With aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
                 VIATRA With aNFiscal[ P_CABECALHO ][ CAB_VIATRANSP ],; 
                 ENTSAI With aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ],; 
                 ORDEMC With aNFiscal[ P_CABECALHO ][ CAB_ORDEMCOMPRA ] 
 
         Gravando( "Cadastro do Cliente." ) 
         Replace CLIENT With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
                 CDESCR With aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ],; 
                 CENDER With aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ],; 
                 CBAIRR With aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ],; 
                 CCIDAD With aNFiscal[ P_CLIENTE ][ CLI_CIDADE ],; 
                 CESTAD With aNFiscal[ P_CLIENTE ][ CLI_ESTADO ],; 
                 CCDCEP With aNFiscal[ P_CLIENTE ][ CLI_CEP ],; 
                 CCGCMF With aNFiscal[ P_CLIENTE ][ CLI_CGC ],; 
                 CINSCR With aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ],; 
                 CCOBRA With aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ],; 
                 CONREV With aNFiscal[ P_CLIENTE ][ CLI_CONSIND ],; 
                 CCPF__ With aNFiscal[ P_CLIENTE ][ CLI_CPF ],; 
                 CFONE2 With aNFiscal[ P_CLIENTE ][ CLI_FONE ] 
 
         Gravando( "Dados da transportadora." ) 
         Replace TRANSP With aNFiscal[ P_TRANSPORTE ][ TRA_CODIGO ],; 
                 TDESCR With aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ],; 
                 TFONE_ With aNFiscal[ P_TRANSPORTE ][ TRA_FONE ],; 
                 TENDER With aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ],; 
                 TCIDAD With aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ],; 
                 TESTAD With aNFiscal[ P_TRANSPORTE ][ TRA_ESTADO ],; 
                 TCGCMF With aNFiscal[ P_TRANSPORTE ][ TRA_CGC ],; 
                 TINSCR With aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ] 
 
         Gravando( "Informacao de vendedores..." ) 
         Replace VENIN_ With aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_CODIGO ],; 
                 VENEX_ With aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_CODIGO ] 
 
         Gravando( "Calculo de impostos..." ) 
         Replace VLRTOT With aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],; 
                 VLRNOT With aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],; 
                 VLRICM With aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],; 
                 VLRIPI With aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],; 
                 BASICM With aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ],; 
                 PERSRV With aNFiscal[ P_IMPOSTOS ][ IMP_SOBREREVENDA ],; 
                 VLRSRV With aNFiscal[ P_IMPOSTOS ][ IMP_VLRSOBREREV ],; 
                 BASSUB With aNFiscal[ P_IMPOSTOS ][ IMP_ICMSUBBASE ],; 
                 ICMSUB With aNFiscal[ P_IMPOSTOS ][ IMP_ICMSUBVALOR ] 
 
         Gravando( "Servicos Imposto sobre servicos (ISSQN)..." ) 
         IF aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] > 0 
            Replace ISSQNB With aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ],; 
                    ISSQNV With aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ],; 
                    ISSQNP With aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ],;
                    COFINV With aNFiscal[ P_IMPOSTOS ][ IMP_VLRCOFIN ],;
                    COFINP With aNFiscal[ P_IMPOSTOS ][ IMP_PERCOFIN ]
         ENDIF 
 
         Gravando( "Servicos Imposto sobre servicos (IRRF)..." ) 
         IF aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] > 0 
            Replace IRRF_B With aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],; 
                    IRRF_V With aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ],; 
                    IRRF_P With aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ] 
         ENDIF 
 
         Gravando( "Informacoes do pedido - Numero -->>> " + StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ) ) 
         Replace PEDIDO With aNFiscal[ P_NUMERO ][ NUM_PEDIDO ] 
 
         Gravando( "Observacoes, quantidade de volume e embalagem..." ) 
         Replace QUANT_ With aNFiscal[ P_DIVERSOS ][ DIV_QUANTIDADE ],; 
                 ESPEC_ With aNFiscal[ P_DIVERSOS ][ DIV_ESPECIE ],; 
                 PESOBR With aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ],; 
                 PESOLI With aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ],; 
                 SAIDAT With aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ],; 
                 SAIHOR With aNFiscal[ P_DIVERSOS ][ DIV_HORASAIDA ],; 
                 DESPES With aNFiscal[ P_DIVERSOS ][ DIV_DESPESAS ],; 
                 FPC12_ With aNFiscal[ P_DIVERSOS ][ DIV_TIPOFRETE ],; 
                 FRETE_ With aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE ],; 
                 SEGURO With aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ],; 
                 OBSER1 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA1 ],; 
                 OBSER2 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA2 ],; 
                 OBSER3 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA3 ],; 
                 OBSER4 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ],; 
                 OBSER5 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA5 ],; 
                 NVEZES With aNFiscal[ P_DIVERSOS ][ DIV_FATURA ],; 
                 TABOPE With aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ],; 
                 TABCND With aNFiscal[ P_DIVERSOS ][ DIV_TABCONDICAO ],; 
                 VLRDES With aNFiscal[ P_DIVERSOS ][ DIV_DESCONTO ],; 
                 VLRACR With aNFiscal[ P_DIVERSOS ][ DIV_ACRESCIMO ],; 
                 PLACA_ With aNFiscal[ P_DIVERSOS ][ DIV_PLACA ] 
 
 
        Gravando( "Produtos..." ) 
        DBSelectAr( _COD_PRODNF ) 
        FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
           Gravando( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
 
           IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 
              CF_->( DBSetOrder( 1 ) ) 
              CF_->( DBSeek( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CLAFISCAL ] ) ) 
              aNFiscal[P_PRODUTOS ][ nCt ][ PRO_CODIGOFISCAL ]:= CF_->CODFIS 
              DBAppend() 
 
              /* Situacao Tributaria modificada */ 
              && ICMCOD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAA ],; 
              && IPICOD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAB ],; 
 
              Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],; 
                   CLIENT With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
                   DATA__ With aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
                   CODRED With StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),; 
                   CODIGO With StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),; 
                   DESCRI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ],; 
                   UNIDAD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_UNIDADE ],; 
                   PRECOV With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ],; 
                   PRECOT With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ],; 
                   SITT01 With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAA ],; 
                   SITT02 With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAB ],; 
                   CLAFIS With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CLAFISCAL ],; 
                   QUANT_ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],; 
                   IPI___ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ],; 
                   PERIPI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALIPI ],; 
                   PERICM With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ],; 
                   MPRIMA With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MATERIAPRIMA ],; 
                   CODFIS With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGOFISCAL ],; 
                   ORIGEM With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_ORIGEM ],; 
                   VLRICM With ( ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] * ; 
                                   aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ] ) * ; 
                                   aNfiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] ) / 100,; 
                   TABPRE With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_TABPRECO ],; 
                   TABOPE With aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ],; 
                   PRECO1 With PrecoAVista( aNFiscal[ P_DIVERSOS ][ DIV_TABCONDICAO ], Alltrim( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) ) ),; 
                   PCPCLA With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CLASSE ],; 
                   PCPTAM With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_TAMANHO ],; 
                   PCPCOR With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_COR ] 
 
 
                   /* Gera Informacao p/ Baixa de Controle de Reservas Por Pedidos */ 
                   ControleDeReserva( "-",; 
                        pad( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ), 12 ),; 
                                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] ) 
 
              DBSelectAr( _COD_PRODNF ) 
           ENDIF 
        NEXT 
     ENDIF 
     //// FIM IF lEspecial 
 
     /// PRODUTOS ESTOQUE 
     FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
 
              IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 .OR.; 
                 aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ] > 0 
 
                 DBSelectAr( _COD_ESTOQUE ) 
 
                 /* Montagem da tabela de tamanho/Cor/Quantidade p/ atualizacao de PdvEAN-Saldos de Produtos */ 
                 aCorTamQua:= { { aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_COR ], 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } } 
                 aCorTamQua[ 1 ][ aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_TAMANHO ] + 1 ]:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] 
 
                 OPE->( DBSetOrder( 1 ) ) 
                 OPE->( DBSeek( aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] ) ) 
                 IF OPE->ENTSAI $ "+-ES1234 " 
                    cTipoMovimento:= OPE->ENTSAI 
                    IF cTipoMovimento == " " 
                       cTipoMovimento:= "-" 
                    ENDIF 
                    Gravando( "Estoque: " + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
                    LancEstoque( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),; 
                              StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),; 
                              IF( aNfiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ] $ "ENTRADA-E-1-2", "+", "-" ),; 
                              IF( lEspecial, "PD: ", "NF: " ) + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 9, 0 ),; 
                              aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
                               0,; 
                              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ],; 
                              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],; 
                              nGCodUser,; 
                              aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
                              aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],; 
                              aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],; 
                              0,; 
                              aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ],; 
                              aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ],; 
                               Nil,; 
                              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CLASSE ],; 
                              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_TAMANHO ],; 
                              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_COR ],; 
                              aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],; 
                              @aCorTamQua,; 
                              cTipoMovimento ) 
 
                 ELSE 
                    Gravando( "(Alerta) Movimento de estoque indefinido para o seguinte produto: " ) 
                    Gravando( "         " + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
                 ENDIF 
              ELSE 
                 Gravando( "(Alerta) Este produto esta sem preco e qtd e n�o vai movimentar o estoque: " ) 
                 Gravando( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
              ENDIF 
              DBSelectAr( _COD_PRODNF ) 
     NEXT 
 
     //// SERVICOS 
     FOR nCt:= 1 TO Len( aNFiscal[ P_SERVICOS ] ) 
           Gravando( aNFiscal[ P_SERVICOS ][ nCt ][ SER_DESCRICAO ] ) 
           IF aNFiscal[ P_SERVICOS ][ nCt ][ SER_QUANTIDADE ] > 0 
              DBAppend() 
              Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],; 
                   CODRED With StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ),; 
                   CODIGO With StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ),; 
                   DESCRI With aNFiscal[ P_SERVICOS ][ nCt ][ SER_DESCRICAO ],; 
                   PRECOV With aNFiscal[ P_SERVICOS ][ nCt ][ SER_UNITARIO ],; 
                   PRECOT With aNFiscal[ P_SERVICOS ][ nCt ][ SER_TOTAL ],; 
                   QUANT_ With aNFiscal[ P_SERVICOS ][ nCt ][ SER_QUANTIDADE ],; 
                   MPRIMA With aNFiscal[ P_SERVICOS ][ nCt ][ SER_MPRIMA ] 
              DBSelectAr( _COD_ESTOQUE ) 
              LancEstoque( StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ),; 
                           StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ),; 
                           IF( aNfiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ] $ "ENTRADA-E-1-2", "+", "-" ),; 
                            IF( lEspecial, "PD: ", "NF: " ) + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 9, 0 ),; 
                           aNFiscal[ P_CLIENTE ][ CLI_CODIGO ], 0,; 
                           aNFiscal[ P_SERVICOS ][ nCt ][ SER_TOTAL ],; 
                           aNFiscal[ P_SERVICOS ][ nCt ][ SER_QUANTIDADE ],; 
                           nGCodUser, aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
                           aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ], aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],; 
                           0,; 
                           aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ],; 
                           aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] ) 
              DBSelectAr( _COD_PRODNF ) 
           ENDIF 
     NEXT 
 
 
     DBSelectAr( _COD_PEDBAIXA ) 
     FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] ) 
        Gravando( "Controle: " + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] ) 
        IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 
           DBAppend() 
           IF netrlock() 
              Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],; 
                   CODIGO With StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ),; 
                   CODCLI With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
                   SERIE_ With "A",; 
                   CODPRO With StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),; 
                   CODFAB With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODFABRICA ],; 
                   DESCRI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ],; 
                   UNIDAD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_UNIDADE ],; 
                   QUANT_ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],; 
                   VLRINI With 0,; 
                   PERDES With 0,; 
                   VLRUNI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ],; 
                   IPI___ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALIPI ],; 
                   ICM___ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ],; 
                   ENTREG With aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ],; 
                   CODPED With StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ),; 
                   DATSEL With Date() 
           ENDIF 
        ENDIF 
     NEXT 
     DBSelectAr( _COD_PEDIDO ) 
     IF !EOF() 
        IF netrlock() 
           Replace CODNF_ With nNumero 
        ENDIF 
     ENDIF 
     DBUnlockAll() 
 
     Gravando( "Atualizando Informacoes de Maior Compra / Ultima Compra p/ Cliente..." ) 
     /* Atualiza Informacoes de Maior Compra / Ultima Compra */ 
     CliInfo( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
              Nil, "-",; 
              aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
              aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],; 
              aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] ) 
 
     /////////// Atualizacao de Informacoes a titulo de Duplicatas //////////// 
     /* Alteracao do Codigo do Cliente p/ Lancamento de Duplicata 
        cfe.cad.secundario co-relacionado atraves do CLI*00000 no campo 
        endereco de cobranca na base de dados do cliente atual */ 
     CLI->( DBSetOrder( 1 ) ) 
     IF CLI->( DBSeek( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ] ) ) 
        IF LEFT( Alltrim( CLI->COBRAN ), 4 ) == "CLI*" 
           IF SWAlerta( "<< MATRIZ DE FATURAMENTO DIFERENCIADA >>;" +; 
                     "O cliente esta relacionado com o endereco de cobranca;" +; 
                     "e demais informacoes ao cliente " + ALLTRIM( SubStr( Alltrim( CLI->COBRAN ), 5 ) ) + ".;" +; 
                     "Em relacao ao faturamento. O que deseja fazer?",; 
                     { "Desconsiderar", "Usar Informacoes", "Cancelar" } )==2 
              aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:= VAL( SubStr( Alltrim( CLI->COBRAN ), 5 ) ) 
              IF CLI->( DBSeek( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ] ) ) 
                 aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ]:= CLI->DESCRI 
              ENDIF 
           ENDIF 
        ENDIF 
     ENDIF 
 
     Gravando( "Duplicatas..." ) 
     IF aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ] $ "ENTRADA-E-1-2" 
        Gravando( "Entrada..." ) 
        DBSelectAr( _COD_PAGAR ) 
        DBSetOrder( 1 ) 
        DBGoBottom() 
        nCodigo:= CODIGO 
        FOR nCt:= 1 TO Len( aNFiscal[ P_FATURA ] ) 
            DBAppend() 
            IF netrlock() 
               Repl CODIGO With ++nCodigo,; 
                    TABOPE With aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ],; 
                    DOC___ With StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 09, 00 ),; 
                    CODFOR With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
                    BANCO_ With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],; 
                    LOCAL_ With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],; 
                    VALOR_ With aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ],; 
                    EMISS_ With aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
                    VENCIM With aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ],; 
                    DATAPG With aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ],; 
                    QUITAD With IF( !EMPTY( aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ] ), "S", " " ),; 
                    JUROS_ With 0,; 
                    VLRIPI With 0,; 
                    VLRICM With 0,; 
                    NFISC_ With aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ] 
            ENDIF 
        NEXT 
     ELSE 
        Gravando( "Saida (Contas a Receber)..." ) 
        DBSelectAr( _COD_DUPAUX ) 
        FOR nCt:= 1 TO Len( aNFiscal[ P_FATURA ] ) 
            aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ]:= ; 
               VAL( StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 9, 0 ) + ; 
               StrZero( Month( aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ] ), 2, 0 ) ) 
 
            nVezes:= nCt 
            /* Soma as faturas em aberto */ 
            IF EMPTY( aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ] ) 
               nVlrFaturado:= nVlrFaturado +  aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ] 
            ENDIF 
 
            /* Gravacao de duplicata no formato novo */ 
            DBSelectAr( _COD_DUPAUX ) 
            IF USED() 
               DBAppend() 
               IF netrlock() 
                  Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],; 
                       CDESCR With aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ],; 
                       CLIENT With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
                       DUPL__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ],; 
                       VLR___ With aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ],; 
                       VENC__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ],; 
                       DTQT__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ],; 
                       PERC__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ],; 
                       PRAZ__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ],; 
                       BANC__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],; 
                       LOCAL_ With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],; 
                       CHEQ__ With aNFiscal[ P_FATURA ][ nCt ][ FAT_CHEQUE ],; 
                       QUIT__ With If( !Empty( aNfiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ] ),"S", " "),; 
                       LETRA_ With Chr( 64 + nCt ),; 
                       DATAEM With aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],; 
                       VLRICM With aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],; 
                       VLRIPI With aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],; 
                       VLRISS With aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ],; 
                       VLRIRR With aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ] 
                  IF !Empty( DTQT__ ) 
                     BaixaReceber( Nil, .T. ) 
                  ENDIF 
               ENDIF 
            ENDIF 
        NEXT 
     ENDIF 
 
     DBSelectAr( _COD_NFISCAL ) 
     IF netrlock() 
        Replace NVEZES With nVezes 
        Replace TIPONF With aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ] 
     ENDIF 
 
     ////////////////// INFORMACOES DE CREDITO ////////////////// 
     Gravando( "Atualizando Informacoes de Credito p/ Cliente..." ) 
     /* Atualiza Informacoes de Credito */ 
     CliInfo( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],; 
              nVlrFaturado, "-" ) 
 
     IF lAvisar 
        /* FIM DA GRAVACAO */ 
        Gravando( " * * * * * * GRAVACAO FINALIZADA * * * * * * " ) 
        Aviso( " Gravado documento no. " + StrZero( nNumero, 10, 0 ) + " com sucesso.", 12 ) 
        Pausa() 
     ELSE 
        mensagem( " Informacoes gravadas no codigo " + StrZero( nNumero, 9, 0 ) + " com sucesso.", 12 ) 
     ENDIF 
 
     lOk:= .T. 
  ENDIF 
  LigaMouse( lMouse ) 
  IF !lAvisar 
     // Se nao avisar, mantem as informacoes na tela 
     // VALMOR: Provisorio 13/08/03 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
  ENDIF 
  DBUnlockAll() 
  Return lOk 
 
  Static Function Gravando( cDados ) 
  Scroll( 01, 01, 21, 78, 1 ) 
  @ 21,02 Say cDados 
//  fDepur( "NFISCAL.LOG", cDados ) 
  Return Nil 
 
  Function PegaCodFiscal( nCodigo ) 
  Local nOrdem:= IndexOrd(), nArea:= Select() 
  DBSelectAr( _COD_CLASFISCAL ) 
  DBSetOrder( 1 ) 
  IF DBSeek( nCodigo ) 
     IF !nArea == 0 
        DBSelectAr( nArea ) 
        DBSetOrder( nOrdem ) 
     ENDIF 
     Return CF_->CodFis 
  ELSE 
     IF !nArea == 0 
        DBSelectAr( nArea ) 
        DBSetOrder( nOrdem ) 
     ENDIF 
     Return Space( 10 ) 
  ENDIF 
 
 
  Function PegaNatOpera( nCodigo ) 
  Local nOrdem:= IndexOrd(), nArea:= Select() 
  DBSelectAr( _COD_NATOPERA ) 
  DBSetOrder( 1 ) 
  IF DBSeek( nCodigo ) 
     IF !nArea == 0 
        DBSelectAr( nArea ) 
        DBSetOrder( nOrdem ) 
     ENDIF 
     Return CFO->DESCRI 
  ELSE 
     IF !nArea == 0 
        DBSelectAr( nArea ) 
        DBSetOrder( nOrdem ) 
     ENDIF 
     Return Space( 40 ) 
  ENDIF 
 
 
Static Function Perc( nVendedor, nTipoVenda ) 
  Local nPercentual:= 0 
  Local nOrdem:= IndexOrd(), nArea:= Select() 
  DBSelectAr( _COD_VENDEDOR ) 
  Set Filter To 
  DBSetOrder( 1 ) 
  IF DBSeek( nVendedor ) 
     DO CASE 
        CASE nTipoVenda == 1        /* A VISTA */ 
             nPercentual:= COMIVV 
        CASE nTipoVenda == 2        /* A PRAZO */ 
             nPercentual:= COMIVP 
        CASE nTipoVenda == 3        /* VENDAS RECEBIDAS */ 
             nPercentual:= COMIVR 
        CASE nTipoVenda == 4        /* VENDA TOTAL */ 
             nPercentual:= COMIVT 
     ENDCASE 
  ENDIF 
  IF !( nArea == 0 ) 
     DBSelectAr( nArea ) 
     DBSetOrder( nOrdem ) 
  ENDIF 
  Return nPercentual 
 
 
Function VisualPedido( cPedido ) 
Local GetList:= {} 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd(), oTb, nTecla, lRet:= .T. 
 
   DBSelectAr( _COD_PEDIDO ) 
   DBLeOrdem() 
   dbGoTop() 
 
   SetColor( _COR_BROWSE ) 
   VPBox( 03, 05, 19, 76, "SELECAO DE PEDIDOS GRAVADOS", _COR_BROW_BOX, .T., .T. ) 
 
   Mensagem( "[ENTER]Selecionar [ESC]Sair" ) 
   Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
   oTb:=TBrowseDB( 04, 06, 18, 75 ) 
   oTb:AddColumn( tbcolumnnew( ,{|| DTOC( DATA__ ) + " " + LEFT( CODPED, 8 ) + " " + LEFT( DESCRI, 40 ) + Tran( VLRTOT, "@E 9,999,999.99" ) + " " + ; 
      SPACE( 65 ) } ) ) 
 
   oTb:AutoLite:=.f. 
   oTb:dehilite() 
 
   WHILE .T. 
 
      oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
      WHILE NextKey()=0 .AND. !oTb:Stabilize() 
      ENDDO 
 
      nTecla:=inkey( 0 ) 
 
      IF nTecla=K_ESC 
         lRet:= .F. 
         cPedido:= Space( Len( cPedido ) ) 
         EXIT 
      ENDIF 
 
      DO CASE 
         CASE nTecla==K_UP         ;oTb:up() 
         CASE nTecla==K_LEFT       ;oTb:PanLeft() 
         CASE nTecla==K_RIGHT      ;oTb:PanRight() 
         CASE nTecla==K_DOWN       ;oTb:down() 
         CASE nTecla==K_PGUP       ;oTb:pageup() 
         CASE nTecla==K_PGDN       ;oTb:pagedown() 
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         CASE DBPesquisa( nTecla, oTb ) 
         CASE nTecla==K_F2;    DBMudaOrdem( 1, oTb ) 
         CASE nTecla==K_F3;    DBMudaOrdem( 2, oTb ) 
         CASE nTecla==K_F4;    DBMudaOrdem( 3, oTb ) 
         CASE nTecla==K_F5;    DBMudaOrdem( 4, oTb ) 
         CASE nTecla==K_ENTER 
              cPedido:= PAD( CODPED, Len( cPedido ) ) 
              EXIT 
         OTHERWISE                 ;Tone( 125 ); Tone( 300 ) 
     ENDCASE 
 
     oTb:RefreshCurrent() 
     oTb:Stabilize() 
 
   ENDDO 
 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
 
   Return( lRet ) 
 
 
Function NumeroNota( cOpcao ) 
Local cCor:= SetColor(), cTela, nCursor 
 
Static NumeroNota, DataEmissao 
 
  IF cOpcao==Nil 
     IF NumeroNota==Nil 
        DBSelectAr( _COD_NFISCAL ) 
        DBSetOrder( 1 ) 
        DBSeek( 999999 ) 
        DBSkip( -1 ) 
        NumeroNota:= NUMERO + 1 
        DataEmissao:= DATE() 
     ENDIF 
 
  ELSEIF cOpcao=="AJUSTAR" 
     cTela:= ScreenSave( 0, 0, 24, 79 ) 
     nCursor:= SetCursor(1) 
     DBSelectAr( _COD_NFISCAL ) 
     DBSetOrder( 1 ) 
     DBSeek( 999999 ) 
     DBSkip( -1 ) 
     NumeroNota:= NUMERO + 1 
     DataEmissao:= DATE() 
     SetColor( _COR_GET_EDICAO ) 
     VPBox( 15, 40, 21, 78, "NUMERACAO DE NOTA", _COR_GET_BOX ) 
     @ 17,41 Say "Numero da Nota Fiscal:" Get NumeroNota Pict "99999999" 
     @ 18,41 Say "Data de Emissao......:" Get DataEmissao 
     READ 
     SetCursor( nCursor ) 
     nTecla:= 0 
     cSenha:= "" 
     SetCursor( 0 ) 
     @ 19,41 Say "Senha de Acesso......: [000000]" 
     WHILE .T. 
        nTecla:= INKEY(0) 
        DO CASE 
           CASE nTecla==K_ESC .OR. nTecla==K_ENTER 
                EXIT 
           CASE nTecla==K_BS 
                cSenha:= Left( cSenha, LEN( cSenha ) - 1 ) 
           OTHERWISE 
              IF Len( cSenha ) <= 6 
                 cSenha:= cSenha + Chr( nTecla ) 
              ENDIF 
        ENDCASE 
        @ 19,65 Say PAD( REPL( "*", Len( cSenha ) ), 6 ) Color _COR_GET_REALSE 
     ENDDO 
     If DBSeek( NumeroNota ) 
        Aviso( "Numeracao de Nota Ja Existe!!!" ) 
        Pausa() 
        NumeroNota( "LIMPAR" )  // Limpa Numero Nota 
        NumeroNota( Nil )       // Pega novo numero padrao / baseado no arquivo 
     EndIf 
     IF !( cSenha=="123456" ) 
        Aviso( "Numeracao de Nota recusado!" ) 
        Pausa() 
        NumeroNota( "LIMPAR" )  // Limpa Numero Nota 
        NumeroNota( Nil )       // Pega novo numero padrao / baseado no arquivo 
     ENDIF 
     ScreenRest( cTela ) 
 
  ELSEIF cOpcao=="LIMPAR" 
     NumeroNota:=  Nil 
     DataEmissao:= Nil 
 
  ENDIF 
  SetColor( cCor ) 
  Return { NumeroNota, DataEmissao } 
 
 
Function AjustaNumeroNota() 
  NumeroNota( "AJUSTAR" ) 
 
 
Static Function BuscaCodTransportadora( nCodTra, aNFiscal, GetList ) 
    IF PesqTransportadora( @nCodTra ) 
       aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ]:= TRA->Descri 
       aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ]:=  TRA->Endere 
       aNFiscal[ P_TRANSPORTE ][ TRA_BAIRRO ]:=    SPACE( 20 ) 
       aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ]:=    TRA->Cidade 
       aNFiscal[ P_TRANSPORTE ][ TRA_ESTADO ]:=    TRA->Estado 
       aNFiscal[ P_TRANSPORTE ][ TRA_CEP    ]:=    SPACE( 08 ) 
       aNFiscal[ P_TRANSPORTE ][ TRA_CGC ]:=       TRA->CGCMF_ 
       aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ]:= TRA->Inscri 
       aNFiscal[ P_TRANSPORTE ][ TRA_FONE ]:=      TRA->Fone__ 
    ENDIF 
    FOR nCt:= 1 TO Len( GetList ) 
         GetList[ nCt ]:Display() 
    NEXT 
    Return .T. 
 
 
 
 
 
Static Function BuscaCodCliente( nCodigo, aNFiscal, lNotaManual, GetList ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd(), nTecla 
  IF nCodigo == 999999 
     IF lNotaManual .AND. OPE->( DBSeek( aNFiscal[ P_DIVERSOS ][ DIV_TABOPERACAO ] ) ) 
        IF OPE->CLIFOR=="F" 
           ForSeleciona( -1 ) 
           aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:=    0 
           aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ]:= FOR->DESCRI 
           aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ]:=  FOR->ENDERE 
           aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ]:=    FOR->BAIRRO 
           aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]:=    FOR->CIDADE 
           aNFiscal[ P_CLIENTE ][ CLI_ESTADO ]:=    FOR->ESTADO 
           aNFiscal[ P_CLIENTE ][ CLI_CEP ]:=       FOR->CODCEP 
           aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ]:= FOR->INSCRI 
           aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ]:=  PAD( "       ", LEN( CLI->COBRAN ) ) 
           aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]:=   "I" 
           aNFiscal[ P_CLIENTE ][ CLI_CPF ]:=       Space( 11 ) 
           aNFiscal[ P_CLIENTE ][ CLI_CGC ]:=       Space( 14 ) 
           aNFiscal[ P_CLIENTE ][ CLI_FONE ]:=      FOR->FONE1_ 
           nCodigo:= 0 
        ELSE 
           IF PesqCli( -1 ) 
              aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:=    CLI->CODIGO 
              aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ]:= CLI->DESCRI 
              aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ]:=  CLI->ENDERE 
              aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ]:=    CLI->BAIRRO 
              aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]:=    CLI->CIDADE 
              aNFiscal[ P_CLIENTE ][ CLI_ESTADO ]:=    CLI->ESTADO 
              aNFiscal[ P_CLIENTE ][ CLI_CEP ]:=       CLI->CODCEP 
              aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ]:= CLI->INSCRI 
              aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ]:=  CLI->COBRAN 
              aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]:=   CLI->CONIND 
              aNFiscal[ P_CLIENTE ][ CLI_CPF ]:=       CLI->CPF___ 
              aNFiscal[ P_CLIENTE ][ CLI_CGC ]:=       CLI->CGCMF_ 
              aNFiscal[ P_CLIENTE ][ CLI_FONE ]:=      CLI->FONE1_
              aNFiscal[ P_CLIENTE ][ CLI_SIMPLES ]:=   Cli->SIMPL_
              nCodigo:= CLI->CODIGO 
           ENDIF 
        ENDIF 
     ELSE 
        IF PesqCli( -1 ) 
           aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:=    CLI->CODIGO 
           aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ]:= CLI->DESCRI 
           aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ]:=  CLI->ENDERE 
           aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ]:=    CLI->BAIRRO 
           aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]:=    CLI->CIDADE 
           aNFiscal[ P_CLIENTE ][ CLI_ESTADO ]:=    CLI->ESTADO 
           aNFiscal[ P_CLIENTE ][ CLI_CEP ]:=       CLI->CODCEP 
           aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ]:= CLI->INSCRI 
           aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ]:=  CLI->COBRAN 
           aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]:=   CLI->CONIND 
           aNFiscal[ P_CLIENTE ][ CLI_CPF ]:=       CLI->CPF___ 
           aNFiscal[ P_CLIENTE ][ CLI_CGC ]:=       CLI->CGCMF_
           aNFiscal[ P_CLIENTE ][ CLI_FONE ]:=      CLI->FONE1_
           aNFiscal[ P_CLIENTE ][ CLI_SIMPLES ]:=   Cli->SIMPL_
           nCodigo:= CLI->CODIGO 
        ENDIF 
     ENDIF 
     FOR nCt:= 1 TO Len( GetList ) 
         GetList[ nCt ]:Display() 
     NEXT 
  ENDIF 
  Return .T. 
 
 
 
 
Function AddObservacao( aNFiscal, cObservacao ) 
Local nObs:= 1 
    /* ARMAZENAMENTO DE OBSERVACOES DIVERSAS */ 
    FOR nObs:= 1 TO Len( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ] ) 
        /* Verifica se j� esta gravada a observacao */ 
        IF ALLTRIM( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObs ] ) == ALLTRIM( cObservacao  ) 
           EXIT 
        /* Verifica se tem um espaco em branco para a observacao */ 
        ELSEIF EMPTY( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObs ] ) 
           aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObs ]:= PAD( cObservacao, Len( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ nObs ] ) ) 
           EXIT 
        ENDIF 
    NEXT 
 
 
