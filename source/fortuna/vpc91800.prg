// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/

#ifdef HARBOUR
function vpc91800()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
 
  VPBox( 12, 35, 21, 68 ) 
  WHILE .T. 
      mensagem("") 
      AAdd( MENULIST,menunew(13,36," 1 Pagar & Receber             ", 2, COR[11],; 
           "Verificacao Sintetica de Contas a Pagar x Contas a Receber.",,, COR[6],.T.)) 
      AAdd( MENULIST,menuNew(14,36," 2 Receber por Cliente         ", 2, COR[11],; 
           "Consulta Por Cliente.",,,COR[6],.T.)) 
      AAdd( MENULIST,menunew(15,36," 3 Receber por Vencimento      ", 2, COR[11],; 
           "Consulta Por Vencimento.",,,COR[6],.T.)) 
      AAdd( MENULIST,menunew(16,36," 4 Receber + Acrescimos        ", 2, COR[11],; 
           "Verificacao Sintetica de Contas a Receber + Acrescimos.",,, COR[6],.T.)) 
      AAdd( MENULIST,menunew(17,36," 5 Receber + Acr. Por Cliente  ", 2, COR[11],; 
           "Verificacao Sintetica de Contas a Receber + Acrescimos Por Cliente.",,, COR[6],.T.)) 
      AAdd( MENULIST,menunew(18,36," 6 Pagar por Fornecedor        ", 2, COR[11],; 
           "Consulta Por Fornecedor.",,,COR[6],.T.)) 
      AAdd( MENULIST,menunew(19,36," 7 Pagar por Vencimento        ", 2, COR[11],; 
           "Consulta Por Vencimento.",,,COR[6],.T.)) 
      AAdd( MENULIST,menunew(20,36," 0 Retorna                     ", 2, COR[11],; 
           "Retorna ao menu anterior.",,,COR[6],.T.)) 
      menumodal(MENULIST,@nOPCAO); MENULIST:={} 
      do case 
         case nOPCAO=0 .or. nOPCAO=8; exit 
         case nOPCAO=1 
              PagarXReceber() 
         case nOPCAO=2 
              ReceberCliente() 
         case nOPCAO=3 
              ReceberVencimento() 
         case nOPCAO=4 
              ReceberAcrescimos( 1 ) 
         case nOPCAO=5 
              ReceberAcrescimos( 2 ) 
      endcase 
  enddo 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � PAGARXRECEBER 
� Finalidade  � Consulta de Contas a Pagar / Contas a Receber 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 15/09/1998 
��������������� 
*/ 
Function PagarXReceber() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A PAGAR & CONTAS A RECEBER", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= DATE() 
  dDataFim:= DATE() 
  nOpcao:= 2 
  @ 02,02 Say "Selecionar do dia:" Get dDataIni 
  @ 03,02 Say "        ate o dia:" Get dDataFim 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  @ 06,02 Prompt " 1 Duplicatas Quitadas            " 
  @ 07,02 Prompt " 2 Duplicatas Pendentes           "  
  @ 08,02 Prompt " 3 Duplicatas Quitadas no periodo " 
  @ 09,02 Prompt " 4 Todas                          "

  MENU TO nOpcao 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  DBSelectAr( _COD_DESPESAS ) 
  DBSetOrder( 1 ) 
 
  Mensagem( "Processando as duplicatas a Pagar, aguarde..." ) 
  DBSelectAr( _COD_PAGAR ) 
  IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENCIM Tag AT1 Eval {|| Processo() } To PINDRES.TMP For VENCIM>=dDataIni .AND. VENCIM<=dDataFim .AND. !EMPTY( DATAPG ) 
  ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENCIM Tag AT1 Eval {|| Processo() } To PINDRES.TMP For VENCIM>=dDataIni .AND. VENCIM<=dDataFim .AND. EMPTY( DATAPG )
  ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENCIM Tag AT1 Eval {|| Processo() } To PINDRES.TMP For DATAPG>=dDataIni .AND. DATAPG<=dDataFim .AND. !EMPTY( DATAPG )
  ELSEIF nOpcao == 4 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENCIM Tag AT1 Eval {|| Processo() } To PINDRES.TMP For VENCIM>=dDataIni .AND. VENCIM<=dDataFim 
  ENDIF 
  DBGoTop() 
  WHILE !EOF() 
      IF EMPTY( DATAPG ) 
         IF DATE() - VENCIM >= 120 
            nPag120:= nPag120 + VALOR_ 
         ELSEIF DATE() - VENCIM >= 60 
            nPag60:= nPag60 + VALOR_ 
         ELSEIF DATE() - VENCIM >= 30 
            nPag30:= nPag30 + VALOR_ 
         ELSEIF DATE() - VENCIM >= 10 
            nPag10:= nPag10 + VALOR_ 
         ELSEIF DATE() - VENCIM > 5 
            nPag5:= nPag5 + VALOR_ 
         ELSEIF DATE() < VENCIM 
            nPag0:= nPag0 + VALOR_ 
         ELSEIF DATE() == VENCIM 
            nPagHoje:= nPagHoje + VALOR_ 
         ELSEIF DATE() - VENCIM <= 5 
            nPag4:= nPag4 + VALOR_ 
         ENDIF 
         nPagPendente:= nPagPendente + VALOR_ 
      ENDIF 
      nPagTotal:= nPagTotal + VALOR_ 
      DBSkip() 
  ENDDO 
  DBGoTop() 
 
  Set Relation To CODFOR Into DES 
 
  Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
  DBSelectAr( _COD_DUPAUX ) 
  IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. !EMPTY( DTQT__ ) .AND. NFNULA == " " 
  ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. EMPTY( DTQT__ ) .AND. NFNULA == " " 
  ELSEIF nOpcao == 3
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For DTQT__>=dDataIni .AND. DTQT__ <=dDataFim .AND. !EMPTY( DTQT__ ) .AND. NFNULA == " " 
  ELSEIF nOpcao == 4
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim  .AND. NFNULA == " " 
  ENDIF 
  DBGoTop() 
  WHILE !EOF() 
      IF EMPTY( DTQT__ ) 
         IF DATE() - VENC__ >= 120 
            nRec120:= nRec120 + VLR___ 
         ELSEIF DATE() - VENC__ >= 60 
            nRec60:= nRec60 + VLR___ 
         ELSEIF DATE() - VENC__ >= 30 
            nRec30:= nRec30 + VLR___ 
         ELSEIF DATE() - VENC__ >= 10 
            nRec10:= nRec10 + VLR___ 
         ELSEIF DATE() - VENC__ > 5 
            nRec5:= nRec5 + VLR___ 
         ELSEIF DATE() < VENC__ 
            nRec0:= nRec0 + VLR___ 
         ELSEIF DATE() == VENC__ 
            nRecHoje:= nRecHoje + VLR___ 
         ELSEIF DATE() - VENC__ <= 5 
            nRec4:= nRec4 + VLR___ 
         ENDIF 
         nRecPendente:= nRecPendente + VLR___ 
      ENDIF 
      nRecTotal:= nRecTotal + VLR___ 
      DBSkip() 
  ENDDO 
  DBGoTop() 
  DispBegin() 
  VPBox( 00, 00, 13, 79, "PAGAR & RECEBER", _COR_GET_BOX ) 
  VPBox( 14, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
  Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  SetColor( "00/02" ) 
  @ 02,02 Say "                                   CONTAS A RECEBER      CONTAS A PAGAR     " 
  SetColor( _COR_GET_BOX ) 
  @ 03,02 Say "Pendente a menos de  5 dias                                                 " 
  @ 04,02 Say "Pendente a mais de   5 dias                                                 " 
  @ 05,02 Say "Pendente a mais de  10 dias                                                 " 
  @ 06,02 Say "Pendente a mais de  30 dias                                                 " 
  @ 07,02 Say "Pendente a mais de  60 dias                                                 " 
  @ 08,02 Say "Pendente a mais de 120 dias                                                 " 
  @ 09,02 Say "A vencer                                                                    " 
  @ 10,02 Say "Com vencimento hoje                                                         " 
  @ 11,02 Say "Total relacionado no display                                                " 
  @ 12,02 Say "Total pendente                                                              " 
  @ 03,32 Say Tran( nRec4,   "@E 999,999,999.99" ) + " " + Str( ( nRec4 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 04,32 Say Tran( nRec5,   "@E 999,999,999.99" ) + " " + Str( ( nRec5 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 05,32 Say Tran( nRec10,  "@E 999,999,999.99" ) + " " + Str( ( nRec10 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 06,32 Say Tran( nRec30,  "@E 999,999,999.99" ) + " " + Str( ( nRec30 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 07,32 Say Tran( nRec60,  "@E 999,999,999.99" ) + " " + Str( ( nRec60 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 08,32 Say Tran( nRec120, "@E 999,999,999.99" ) + " " + Str( ( nRec120 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 09,32 Say Tran( nRec0,   "@E 999,999,999.99" ) + " " + Str( ( nRec0 / nRecPendente ) * 100, 6, 2 ) + "%" 
  SetColor( "15/04" ) 
  @ 10,32 Say Tran( nRecHoje,"@E 999,999,999.99" ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 11,32 Say Tran( nRecTotal,"@E 999,999,999.99" ) 
  @ 12,32 Say Tran( nRecPendente,"@E 999,999,999.99" ) + " " + Str( ( nRecPendente / nRecPendente ) * 100, 6, 2 ) + "%" 
 
  @ 03,55 Say Tran( nPag4,   "@E 999,999,999.99" )+ " " + Str( ( nPag4 / nPagPendente ) * 100, 6, 2 ) + "%" 
  @ 04,55 Say Tran( nPag5,   "@E 999,999,999.99" )+ " " + Str( ( nPag5 / nPagPendente ) * 100, 6, 2 ) + "%" 
  @ 05,55 Say Tran( nPag10,  "@E 999,999,999.99" )+ " " + Str( ( nPag10 / nPagPendente ) * 100, 6, 2 ) + "%" 
  @ 06,55 Say Tran( nPag30,  "@E 999,999,999.99" )+ " " + Str( ( nPag30 / nPagPendente ) * 100, 6, 2 ) + "%" 
  @ 07,55 Say Tran( nPag60,  "@E 999,999,999.99" )+ " " + Str( ( nPag60 / nPagPendente ) * 100, 6, 2 ) + "%" 
  @ 08,55 Say Tran( nPag120, "@E 999,999,999.99" )+ " " + Str( ( nPag120 / nPagPendente ) * 100, 6, 2 ) + "%" 
  @ 09,55 Say Tran( nPag0,   "@E 999,999,999.99" )+ " " + Str( ( nPag0 / nPagPendente ) * 100, 6, 2 ) + "%" 
  SetColor( "15/04" ) 
  @ 10,55 Say Tran( nPagHoje,"@E 999,999,999.99" ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 11,55 Say Tran( nPagTotal,"@E 999,999,999.99" ) 
  @ 12,55 Say Tran( nPagPendente,"@E 999,999,999.99" ) + " " + Str( ( nPagPendente / nPagPendente ) * 100, 6, 2 ) + "%" 
  SetColor( _COR_BROWSE ) 
  DBSelectAr( _COD_PAGAR ) 
  oTab2:=tbrowsedb(15,01,21,78) 
  oTab2:addcolumn(tbcolumnnew("Codigo...",{|| StrZero( CODIGO, 6, 0 ) })) 
  oTab2:addcolumn(tbcolumnnew("Forn",{|| CODFOR })) 
  oTab2:addcolumn(tbcolumnnew("Descricao",{|| LEFT( DES->DESCRI, 30 ) })) 
  oTab2:addcolumn(tbcolumnnew("Valor",{|| Tran( VALOR_, "@E 9,999,999.99" ) })) 
  oTab2:addcolumn(tbcolumnnew("Vencimen",{|| VENCIM })) 
  oTab2:addcolumn(tbcolumnnew("Quitacao",{|| DATAPG })) 
  oTab2:addcolumn(tbcolumnnew("Cheque",{|| CHEQUE })) 
  oTab2:addcolumn(tbcolumnnew("Ban",{|| BANCO_ })) 
  oTab2:AUTOLITE:=.f. 
  oTab2:dehilite() 
  DBSelectAr( _COD_DUPAUX ) 
  oTab1:=tbrowsedb(15,01,21,78) 
  oTab1:addcolumn(tbcolumnnew("Duplicata ",{|| IF( TIPO__=="02", StrZero( CODIGO, 9, 0 ), StrZero( CODNF_, 9, 0 ) + LETRA_ ) })) 
  oTab1:addcolumn(tbcolumnnew("Codigo",{|| CLIENT })) 
  oTab1:addcolumn(tbcolumnnew("Descricao",{|| LEFT( CDESCR, 30 ) })) 
  oTab1:addcolumn(tbcolumnnew("Valor",{|| Tran( VLR___, "@E 9,999,999.99" )  })) 
  oTab1:addcolumn(tbcolumnnew("Vencimen",{|| VENC__ })) 
  oTab1:AddColumn(tbcolumnnew("Emissao ",{|| DATAEM })) 
  oTab1:addcolumn(tbcolumnnew("Quitacao",{|| DTQT__ })) 
  oTab1:addcolumn(tbcolumnnew("Cheque",{|| CHEQ__ })) 
  oTab1:addcolumn(tbcolumnnew("Ban",{|| BANC__ })) 
  oTab1:addcolumn(tbcolumnnew("Loc",{|| LOCAL_ })) 
  oTab1:AUTOLITE:=.f. 
  oTab1:dehilite() 
  DispEnd() 
  whil .t. 
     IF nTela == 1 
        DBSelectAr( _COD_DUPAUX ) 
        oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
        whil nextkey()=0 .and.! oTab1:stabilize() 
        enddo 
 
     ELSEIF nTela == 2 
        DBSelectAr( _COD_PAGAR ) 
        oTab2:colorrect({oTab2:ROWPOS,1,oTab2:ROWPOS,oTab2:COLCOUNT},{2,1}) 
        whil nextkey()=0 .and.! oTab2:stabilize() 
        enddo 
     ENDIF 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        exit 
     ELSEIF nTecla==K_TAB 
        DispBegin() 
        IF nTela == 1 
           nTela:= 2 
           DBSelectAr( _COD_PAGAR ) 
           oTab2:RefreshAll() 
           WHILE !oTab2:Stabilize() 
           ENDDO 
           SetColor( "00/02" ) 
           @ 02,02 Say "                                   CONTAS A RECEBER      CONTAS A PAGAR     " 
           SetColor( "15/02" ) 
           @ 02,56 Say "  <CONTAS A PAGAR>   " 
           SetColor( _COR_BROWSE ) 
        ELSE 
           nTela:= 1 
           DBSelectAr( _COD_DUPAUX ) 
           oTab1:RefreshAll() 
           WHILE !oTab1:Stabilize() 
           ENDDO 
           SetColor( "00/02" ) 
           @ 02,02 Say "                                   CONTAS A RECEBER      CONTAS A PAGAR     " 
           SetColor( "15/02" ) 
           @ 02,34 Say "  <CONTAS A RECEBER>  " 
           SetColor( _COR_BROWSE ) 
        ENDIF 
        DispEnd() 
     ELSEIF nTecla == K_CTRL_TAB 
        DispBegin() 
        IF lDisplay 
           nTela:= 2 
           DBSelectAr( _COD_PAGAR ) 
           oTab2:RefreshAll() 
           WHILE !oTab2:Stabilize() 
           ENDDO 
           SetColor( "00/02" ) 
           @ 02,02 Say "                                   CONTAS A RECEBER      CONTAS A PAGAR     " 
           SetColor( "15/02" ) 
           @ 02,56 Say "  <CONTAS A PAGAR>   " 
           SetColor( _COR_BROWSE ) 
        ELSE 
           nTela:= 1 
           DBSelectAr( _COD_DUPAUX ) 
           oTab1:RefreshAll() 
           WHILE !oTab1:Stabilize() 
           ENDDO 
           SetColor( "00/02" ) 
           @ 02,02 Say "                                   CONTAS A RECEBER      CONTAS A PAGAR     " 
           SetColor( "15/02" ) 
           @ 02,34 Say "  <CONTAS A RECEBER>  " 
           SetColor( _COR_BROWSE ) 
        ENDIF 
        DispEnd() 
 
     ENDIF 
     IF nTela == 1 
        do case 
           case nTecla==K_UP         ;oTab1:up() 
           case nTecla==K_LEFT       ;oTab1:PanLeft() 
           case nTecla==K_RIGHT      ;oTab1:PanRight() 
           case nTecla==K_DOWN       ;oTab1:down() 
           case nTecla==K_PGUP       ;oTab1:pageup() 
           case nTecla==K_PGDN       ;oTab1:pagedown() 
           case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
           case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
           case DBPesquisa( ntecla, oTab1 ) 
           otherwise                ;tone(125); tone(300) 
        endcase 
        oTab1:refreshcurrent() 
        oTab1:stabilize() 
    ELSEIF nTela == 2 
       do case 
           case nTecla==K_UP         ;oTab2:up() 
           case nTecla==K_LEFT       ;oTab2:PanLeft() 
           case nTecla==K_RIGHT      ;oTab2:PanRight() 
           case nTecla==K_DOWN       ;oTab2:down() 
           case nTecla==K_PGUP       ;oTab2:pageup() 
           case nTecla==K_PGDN       ;oTab2:pagedown() 
           case nTecla==K_CTRL_PGUP  ;oTab2:gotop() 
           case nTecla==K_CTRL_PGDN  ;oTab2:gobottom() 
           case DBPesquisa( ntecla, oTab2 ) 
           otherwise                ;tone(125); tone(300) 
        endcase 
        oTab2:refreshcurrent() 
        oTab2:stabilize() 
    ENDIF 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSelectAr( _COD_DUPAUX ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx", "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx", "&gdir/dpaind05.ntx"      
#else 
  Set Index To "&GDir\DPAIND01.NTX", "&GDir\DPAIND02.NTX", "&GDir\DPAIND03.NTX", "&GDir\DPAIND04.NTX", "&GDir\DPAIND05.NTX"      
#endif
DBSelectAr( _COD_PAGAR ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/pagind01.ntx", "&gdir/pagind02.ntx", "&gdir/pagind03.ntx"    
#else 
  Set Index To "&GDir\PAGIND01.NTX", "&GDir\PAGIND02.NTX", "&GDir\PAGIND03.NTX"    
#endif
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � RECEBERACRESCIMOS
� Finalidade  � Consulta de Contas a Receber + Acrescimos 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 15/09/1998 
��������������� 
*/ 
Function ReceberAcrescimos( nTipo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
Local nRec1120:= 0, nRec160:= 0, nRec130:= 0, nRec110:= 0, nRec15:= 0, nRecX0:= 0, nRec14:= 0, nRec1Hoje:= 0,; 
      nRec1Total:= 0, nRec1Pendente:= 0 
Local nCodCli:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A RECEBER + ACRESCIMOS", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= DATE() 
  dDataFim:= DATE() 
  nOpcao:= 2 
  @ 02,02 Say "Selecionar do dia:" Get dDataIni 
  @ 03,02 Say "        ate o dia:" Get dDataFim 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  @ 06,02 Prompt " 1 Duplicatas Quitadas       " 
  @ 07,02 Prompt " 2 Duplicatas Pendentes      " 
  @ 08,02 Prompt " 3 Todas                     " 
  MENU TO nOpcao 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  IF nTipo==Nil 
     nTipo:= 1 
  ELSEIF nTipo==2 
     nCodCli:= 999999 
     PesqCli( @nCodCli ) 
  ENDIF 
 
  Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
  DBSelectAr( _COD_DUPAUX ) 
  IF nTipo == 1 
     IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. !EMPTY( DTQT__ ) .AND. NFNULA == " " 
     ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. EMPTY( DTQT__ ) .AND. NFNULA == " " 
     ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim  .AND. NFNULA == " " 
     ENDIF 
  ELSEIF nTipo == 2 
     IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. !EMPTY( DTQT__ ) .AND. NFNULA == " " .AND. CLIENT==nCodCli 
     ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. EMPTY( DTQT__ ) .AND. NFNULA == " " .AND. CLIENT==nCodCli 
     ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim  .AND. NFNULA == " " .AND. CLIENT==nCodCli 
     ENDIF 
  ENDIF 
  DBGoTop() 
  WHILE !EOF() 
      IF EMPTY( DTQT__ ) 
         IF DATE() - VENC__ >= 120 
            nRec120:= nRec120 + VLR___ + JUROS_ - VLRDES 
         ELSEIF DATE() - VENC__ >= 60 
            nRec60:= nRec60 + VLR___   + JUROS_ - VLRDES 
         ELSEIF DATE() - VENC__ >= 30 
            nRec30:= nRec30 + VLR___   + JUROS_ - VLRDES 
         ELSEIF DATE() - VENC__ >= 10 
            nRec10:= nRec10 + VLR___   + JUROS_ - VLRDES 
         ELSEIF DATE() - VENC__ > 5 
            nRec5:= nRec5 + VLR___     + JUROS_ - VLRDES 
         ELSEIF DATE() < VENC__ 
            nRec0:= nRec0 + VLR___     + JUROS_ - VLRDES 
         ELSEIF DATE() == VENC__ 
            nRecHoje:= nRecHoje + VLR___ + JUROS_ - VLRDES 
         ELSEIF DATE() - VENC__ <= 5 
            nRec4:= nRec4 + VLR___       + JUROS_ - VLRDES 
         ENDIF 
         nRecPendente:= nRecPendente + VLR___ + JUROS_ - VLRDES 
         IF DATE() - VENC__ >= 120 
            nRec1120:= nRec1120 + VLR___ 
         ELSEIF DATE() - VENC__ >= 60 
            nRec160:= nRec160 + VLR___ 
         ELSEIF DATE() - VENC__ >= 30 
            nRec130:= nRec130 + VLR___ 
         ELSEIF DATE() - VENC__ >= 10 
            nRec110:= nRec110 + VLR___ 
         ELSEIF DATE() - VENC__ > 5 
            nRec15:= nRec15 + VLR___ 
         ELSEIF DATE() < VENC__ 
            nRecX0:= nRecX0 + VLR___ 
         ELSEIF DATE() == VENC__ 
            nRec1Hoje:= nRec1Hoje + VLR___ 
         ELSEIF DATE() - VENC__ <= 5 
            nRec14:= nRec14 + VLR___ 
         ENDIF 
         nRec1Pendente:= nRec1Pendente + VLR___ 
      ENDIF 
      nRecTotal:= nRecTotal + VLR___ + JUROS_ - VLRDES 
      nRec1Total:= nRec1Total + VLR___ 
      DBSkip() 
  ENDDO 
  DBGoTop() 
  DispBegin() 
  VPBox( 00, 00, 13, 79, "RECEBER + ACRESCIMOS - DESCONTOS" , _COR_GET_BOX ) 
  VPBox( 14, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
  Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  SetColor( "00/02" ) 
  @ 02,02 Say "                                   CONTAS A RECEBER      RECEBER + ACR - DES" 
  SetColor( _COR_GET_BOX ) 
  @ 03,02 Say "Pendente a menos de  5 dias                                                 " 
  @ 04,02 Say "Pendente a mais de   5 dias                                                 " 
  @ 05,02 Say "Pendente a mais de  10 dias                                                 " 
  @ 06,02 Say "Pendente a mais de  30 dias                                                 " 
  @ 07,02 Say "Pendente a mais de  60 dias                                                 " 
  @ 08,02 Say "Pendente a mais de 120 dias                                                 " 
  @ 09,02 Say "A vencer                                                                    " 
  @ 10,02 Say "Com vencimento hoje                                                         " 
  @ 11,02 Say "Total relacionado no display                                                " 
  @ 12,02 Say "Total pendente                                                              " 
  /* Padrao + Juros */ 
  @ 03,56 Say Tran( nRec4,   "@E 999,999,999.99" ) + " " + Str( ( nRec4 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 04,56 Say Tran( nRec5,   "@E 999,999,999.99" ) + " " + Str( ( nRec5 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 05,56 Say Tran( nRec10,  "@E 999,999,999.99" ) + " " + Str( ( nRec10 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 06,56 Say Tran( nRec30,  "@E 999,999,999.99" ) + " " + Str( ( nRec30 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 07,56 Say Tran( nRec60,  "@E 999,999,999.99" ) + " " + Str( ( nRec60 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 08,56 Say Tran( nRec120, "@E 999,999,999.99" ) + " " + Str( ( nRec120 / nRecPendente ) * 100, 6, 2 ) + "%" 
  @ 09,56 Say Tran( nRec0,   "@E 999,999,999.99" ) + " " + Str( ( nRec0 / nRecPendente ) * 100, 6, 2 ) + "%" 
  /* Padrao */ 
  @ 03,32 Say Tran( nRec14,   "@E 999,999,999.99" ) + " " + Str( ( nRec14 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
  @ 04,32 Say Tran( nRec15,   "@E 999,999,999.99" ) + " " + Str( ( nRec15 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
  @ 05,32 Say Tran( nRec110,  "@E 999,999,999.99" ) + " " + Str( ( nRec110 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
  @ 06,32 Say Tran( nRec130,  "@E 999,999,999.99" ) + " " + Str( ( nRec130 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
  @ 07,32 Say Tran( nRec160,  "@E 999,999,999.99" ) + " " + Str( ( nRec160 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
  @ 08,32 Say Tran( nRec1120, "@E 999,999,999.99" ) + " " + Str( ( nRec1120 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
  @ 09,32 Say Tran( nRecX0,   "@E 999,999,999.99" ) + " " + Str( ( nRecX0 / nRec1Pendente ) * 100, 6, 2 ) + "%" 
 
  SetColor( "15/04" ) 
  @ 10,32 Say Tran( nRec1Hoje,"@E 999,999,999.99" ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 11,32 Say Tran( nRec1Total,"@E 999,999,999.99" ) 
  @ 12,32 Say Tran( nRec1Pendente,"@E 999,999,999.99" ) + " " + Str( ( nRec1Pendente / nRec1Pendente ) * 100, 6, 2 ) + "%" 
 
  SetColor( "15/04" ) 
  @ 10,56 Say Tran( nRecHoje,"@E 999,999,999.99" ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 11,56 Say Tran( nRecTotal,"@E 999,999,999.99" ) 
  @ 12,56 Say Tran( nRecPendente,"@E 999,999,999.99" ) + " " + Str( ( nRecPendente / nRecPendente ) * 100, 6, 2 ) + "%" 
 
  SetColor( _COR_BROWSE ) 
  DBSelectAr( _COD_DUPAUX ) 
  oTab1:=tbrowsedb(15,01,21,78) 
  oTab1:addcolumn(tbcolumnnew("Duplicata ",{|| IF( TIPO__=="02", StrZero( CODIGO, 9, 0 ), StrZero( CODNF_, 9, 0 ) + LETRA_ ) })) 
  oTab1:addcolumn(tbcolumnnew("Codigo",{|| CLIENT })) 
  oTab1:addcolumn(tbcolumnnew("Descricao",{|| LEFT( CDESCR, 30 ) })) 
  oTab1:addcolumn(tbcolumnnew("       Valor",{|| Tran( VLR___, "@E 9,999,999.99" )  })) 
  oTab1:addcolumn(tbcolumnnew("   Valor+A-D",{|| Tran( VLR___ + JUROS_ - VLRDES, "@E 9,999,999.99" )  })) 
  oTab1:addcolumn(tbcolumnnew("Vencimen",{|| VENC__ })) 
  oTab1:AddColumn(tbcolumnnew("Emissao ",{|| DATAEM })) 
  oTab1:addcolumn(tbcolumnnew("Quitacao",{|| DTQT__ })) 
  oTab1:addcolumn(tbcolumnnew("Cheque",{|| CHEQ__ })) 
  oTab1:addcolumn(tbcolumnnew("Ban",{|| BANC__ })) 
  oTab1:addcolumn(tbcolumnnew("Loc",{|| LOCAL_ })) 
  oTab1:AUTOLITE:=.f. 
  oTab1:dehilite() 
  DispEnd() 
  whil .t. 
     DBSelectAr( _COD_DUPAUX ) 
     oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
     whil nextkey()=0 .and.! oTab1:stabilize() 
     enddo 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTab1:up() 
        case nTecla==K_LEFT       ;oTab1:PanLeft() 
        case nTecla==K_RIGHT      ;oTab1:PanRight() 
        case nTecla==K_DOWN       ;oTab1:down() 
        case nTecla==K_PGUP       ;oTab1:pageup() 
        case nTecla==K_PGDN       ;oTab1:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
        case DBPesquisa( ntecla, oTab1 ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab1:refreshcurrent() 
     oTab1:stabilize() 
  enddo 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  DBSelectAr( _COD_DUPAUX ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx", "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx", "&gdir/dpaind05.ntx"      
  #else 
    Set Index To "&GDir\DPAIND01.NTX", "&GDir\DPAIND02.NTX", "&GDir\DPAIND03.NTX", "&GDir\DPAIND04.NTX", "&GDir\DPAIND05.NTX"      
  #endif
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � RECEBERCLIENTE 
� Finalidade  � Consulta de Contas a Receber x Cliente 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 15/09/1998 
��������������� 
*/ 
Function ReceberCliente() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A RECEBER", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= CTOD( "01/01/90" ) 
  dDataFim:= DATE() 
  nOpcao:= 2 
  @ 02,02 Say "Selecionar do dia:" Get dDataIni 
  @ 03,02 Say "        ate o dia:" Get dDataFim 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  @ 06,02 Prompt " 1 Duplicatas Quitadas       " 
  @ 07,02 Prompt " 2 Duplicatas Pendentes      " 
  @ 08,02 Prompt " 3 Todas                     " 
  MENU TO nOpcao 
 
  nCodCli:= 999999 
  PesqCli( @nCodCli ) 
 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
  DBSelectAr( _COD_DUPAUX ) 
  IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. !EMPTY( DTQT__ ) .AND. NFNULA == " " .AND. CLIENT==nCodCli 
  ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. EMPTY( DTQT__ ) .AND. NFNULA == " " .AND. CLIENT==nCodCli 
  ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim  .AND. NFNULA == " " .AND. CLIENT==nCodCli 
  ENDIF 
  DBGoTop() 
  DispBegin() 
  VPBox( 00, 00, 05, 79, "CONTAS A RECEBER", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Cliente......: " + CLI->DESCRI 
  @ 03,02 Say "No Periodo de: " + DTOC( dDataIni ) + " a " + DTOC( dDataFim ) 
  @ 04,02 Say IF( nOpcao==1, "Duplicatas Quitadas    ", "Duplicatas Pendentes   " ) 
  @ 04,02 Say IF( nOpcao==3, "Todas as Duplicatas    ", "" ) 
  VPBox( 06, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
  Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  SetColor( _COR_BROWSE ) 
  DBSelectAr( _COD_DUPAUX ) 
  oTab1:= TBrowseDB( 07, 01, 21, 78 ) 
  oTab1:AddColumn(tbcolumnnew("Duplicata ",{|| IF( TIPO__=="02", StrZero( CODIGO, 9, 0 ), StrZero( CODNF_, 9, 0 ) + LETRA_ ) })) 
  oTab1:AddColumn(tbcolumnnew("Codigo",{|| CLIENT })) 
  oTab1:AddColumn(tbcolumnnew("Valor",{|| Tran( VLR___, "@E 9,999,999.99" )  })) 
  oTab1:AddColumn(tbcolumnnew("J.Devidos",{|| Tran( JurosSimples( VLR___, VENC__, DTQT__ ), "@E 999,999.99" )  })) 
  oTab1:AddColumn(tbcolumnnew("Debito",{|| Tran( VLR___ + JurosSimples( VLR___, VENC__, DTQT__ ), "@E 999,999.99" )  })) 
  oTab1:AddColumn(tbcolumnnew("Vencimen",{|| VENC__ })) 
  oTab1:AddColumn(tbcolumnnew("Emissao ",{|| DATAEM })) 
  oTab1:AddColumn(tbcolumnnew("Quitacao",{|| DTQT__ })) 
  oTab1:AddColumn(tbcolumnnew("Ban",{|| BANC__ })) 
  oTab1:AddColumn(tbcolumnnew("Loc",{|| LOCAL_ })) 
  oTab1:AddColumn(tbcolumnnew("Cheque",{|| CHEQ__ })) 
  oTab1:AutoLite:=.f. 
  oTab1:dehilite() 
  DispEnd() 
  whil .t. 
     DBSelectAr( _COD_DUPAUX ) 
     oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
     WHILE NextKey() = 0 .AND. !oTab1:Stabilize() 
     ENDDO 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTab1:up() 
        case nTecla==K_LEFT       ;oTab1:PanLeft() 
        case nTecla==K_RIGHT      ;oTab1:PanRight() 
        case nTecla==K_DOWN       ;oTab1:down() 
        case nTecla==K_PGUP       ;oTab1:pageup() 
        case nTecla==K_PGDN       ;oTab1:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
        case DBPesquisa( ntecla, oTab1 ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab1:refreshcurrent() 
     oTab1:stabilize() 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSelectAr( _COD_DUPAUX ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx", "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx", "&gdir/dpaind05.ntx"      
#else 
  Set Index To "&GDir\DPAIND01.NTX", "&GDir\DPAIND02.NTX", "&GDir\DPAIND03.NTX", "&GDir\DPAIND04.NTX", "&GDir\DPAIND05.NTX"      
#endif
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � RECEBERVENCIMENTO 
� Finalidade  � Consulta de Contas a Receber x Vencimento 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 15/09/1998 
��������������� 
*/ 
Function ReceberVencimento() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab1, oTab2, nTecla, nTela:= 2 
Local nPag120:= 0, nPag60:= 0, nPag30:= 0, nPag10:= 0, nPag5:= 0, nPag0:= 0, nPag4:= 0, nPagHoje:= 0,; 
      nPagTotal:= 0, nPagPendente:= 0 
Local nRec120:= 0, nRec60:= 0, nRec30:= 0, nRec10:= 0, nRec5:= 0, nRec0:= 0, nRec4:= 0, nRecHoje:= 0,; 
      nRecTotal:= 0, nRecPendente:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "CONTAS A RECEBER", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  dDataIni:= DATE() 
  dDataFim:= DATE() 
  nOpcao:= 2 
  @ 02,02 Say "Selecionar do dia:" Get dDataIni 
  @ 03,02 Say "        ate o dia:" Get dDataFim 
  READ 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  @ 06,02 Prompt " 1 Duplicatas Quitadas       " 
  @ 07,02 Prompt " 2 Duplicatas Pendentes      " 
  @ 08,02 Prompt " 3 Todas                     " 
  MENU TO nOpcao 
 
  IF LastKey() == K_ESC 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  Mensagem( "Processando as duplicatas a Receber, aguarde..." ) 
  DBSelectAr( _COD_DUPAUX ) 
  IF nOpcao == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. !EMPTY( DTQT__ ) .AND. NFNULA == " " 
  ELSEIF nOpcao == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim .AND. EMPTY( DTQT__ ) .AND. NFNULA == " " 
  ELSEIF nOpcao == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     Index On VENC__ Tag AT2 Eval {|| Processo() } To RINDRES.TMP For VENC__>=dDataIni .AND. VENC__ <=dDataFim  .AND. NFNULA == " " 
  ENDIF 
  DBGoTop() 
  DispBegin() 
  VPBox( 00, 00, 05, 79, "CONTAS A RECEBER", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Cliente......: " + CLI->DESCRI 
  @ 03,02 Say "No Periodo de: " + DTOC( dDataIni ) + " a " + DTOC( dDataFim ) 
  @ 04,02 Say IF( nOpcao==1, "Duplicatas Quitadas    ", "Duplicatas Pendentes   " ) 
  @ 04,02 Say IF( nOpcao==3, "Todas as Duplicatas    ", "" ) 
  VPBox( 06, 00, 22, 79, "DISPLAY DE LANCAMENTOS", _COR_BROW_BOX ) 
  Mensagem("[TAB]Janela [Data]Pesquisa [ESC]Sair.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  SetColor( _COR_BROWSE ) 
  SetCursor( 0 ) 
  DBSelectAr( _COD_DUPAUX ) 
  oTab1:= TBrowseDB( 07, 01, 21, 78 ) 
  oTab1:AddColumn(tbcolumnnew("Duplicata ",{|| IF( TIPO__=="02", StrZero( CODIGO, 9, 0 ), StrZero( CODNF_, 9, 0 ) + LETRA_ ) })) 
  oTab1:AddColumn(tbcolumnnew("Codigo",{|| CLIENT })) 
  oTab1:AddColumn(tbcolumnnew("Valor",{|| Tran( VLR___, "@E 9,999,999.99" )  })) 
  oTab1:AddColumn(tbcolumnnew("J.Devidos",{|| Tran( JurosSimples( VLR___, VENC__, DTQT__ ), "@E 999,999.99" )  })) 
  oTab1:AddColumn(tbcolumnnew("Debito",{|| Tran( VLR___ + JurosSimples( VLR___, VENC__, DTQT__ ), "@E 999,999.99" )  })) 
  oTab1:AddColumn(tbcolumnnew("Vencimen",{|| VENC__ })) 
  oTab1:AddColumn(tbcolumnnew("Emissao ",{|| DATAEM })) 
  oTab1:AddColumn(tbcolumnnew("Quitacao",{|| DTQT__ })) 
  oTab1:AddColumn(tbcolumnnew("Ban",{|| BANC__ })) 
  oTab1:AddColumn(tbcolumnnew("Loc",{|| LOCAL_ })) 
  oTab1:AddColumn(tbcolumnnew("Cheque",{|| CHEQ__ })) 
  oTab1:AutoLite:=.f. 
  oTab1:dehilite() 
  DispEnd() 
  whil .t. 
     DBSelectAr( _COD_DUPAUX ) 
     oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
     WHILE NextKey() = 0 .AND. !oTab1:Stabilize() 
     ENDDO 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,02 Say "Cliente......: " + CDESCR 
     SetColor( _COR_BROWSE ) 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTab1:up() 
        case nTecla==K_LEFT       ;oTab1:PanLeft() 
        case nTecla==K_RIGHT      ;oTab1:PanRight() 
        case nTecla==K_DOWN       ;oTab1:down() 
        case nTecla==K_PGUP       ;oTab1:pageup() 
        case nTecla==K_PGDN       ;oTab1:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
        case DBPesquisa( ntecla, oTab1 ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab1:refreshcurrent() 
     oTab1:stabilize() 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSelectAr( _COD_DUPAUX ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx", "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx", "&gdir/dpaind05.ntx"      
#else 
  Set Index To "&GDir\DPAIND01.NTX", "&GDir\DPAIND02.NTX", "&GDir\DPAIND03.NTX", "&GDir\DPAIND04.NTX", "&GDir\DPAIND05.NTX"      
#endif
Return Nil 
 
