// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 

#ifdef HARBOUR
function mail()
#endif


Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local GetList:= {} 
Local nArea:= Select(), nOrdem:= IndexOrd(), nRegistro:= RECNO() 
Local nTecla, oTb1, oTb2, nRow1:= 1, nRow2:= 1, aEnviada, aRecebida 
Local aStr, nOpcao, cDestinatario, cTitulo 
Local nRefreshTimer:= SECONDS() 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    UserScreen() 
    VPBox( 01, 01, 22, 78, " GERENCIADOR DE MENSAGENS INTERNAS ", "15/01" ) 
    @ 03,03 Say m->wUsuario Color "11/01" 
    VPBox( 05, 02, 12, 40, " MENSAGENS ENVIADAS ",  "14/00", .F., .F., , .F. ) 
    VPBox( 13, 02, 20, 40, " MENSAGENS RECEBIDAS ", "14/00", .F., .F., , .F. ) 
    VPBox( 05, 41, 20, 77, " QUADRO DE AVISOS ",    "14/09", .F., .F., ,.F. ) 
 
    IF !File( SWSet( _SYS_DIRREPORT ) + "\MFORTUNA.SYS" ) 
       aStr:= {{ "DATA__", "D", 08, 00 },; 
               { "HORA__", "C", 04, 00 },; 
               { "ENVIOU", "C", 20, 00 },; 
               { "RECEBE", "C", 20, 00 },; 
               { "TITULO", "C", 30, 00 },; 
               { "OK____", "C", 01, 00 },; 
               { "ARQUIV", "C", 08, 00 },; 
               { "ORIGEM", "C", 01, 00 },; 
               { "DESTIN", "C", 01, 00 }} 
       DBCreate( SWSet( _SYS_DIRREPORT ) + "\MFORTUNA.SYS", aStr ) 
    ENDIF 
 
    DBSelectAr( 123 ) 
    iif( Used(), DBCloseArea(), Nil ) 
    cDirRep:= SWSet( _SYS_DIRREPORT ) 

    // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
    #ifdef LINUX
      use "&cdirrep/mfortuna.sys" alias f1_ shared  
    #else 
      USE "&cDirRep\MFORTUNA.SYS" Alias F1_ Shared  
    #endif
 
    aEnviada:= {} 
    DBGoBottom() 
    WHILE !BOF() 
       IF ENVIOU==Pad( wUsuario, LEN( ENVIOU ) ) .AND.; 
          ORIGEM==" " 
          AAdd( aEnviada, { DATA__, HORA__, TITULO, ARQUIV, RECEBE, OK____ } ) 
       ENDIF 
       DBSkip(-1) 
    ENDDO 
    IF Len( aEnviada ) <= 0 
       AAdd( aEnviada, { CTOD( "  /  /  " ), "  :  ", Space( 20 ), Space( 8 ), Space( 20 ), " " } ) 
    ENDIF 
    aRecebida:= {} 
    DBGoBottom() 
    WHILE !BOF() 
       IF RECEBE==Pad( wUsuario, LEN( RECEBE ) ) .OR. Alltrim( RECEBE ) == "TODOS" .AND.; 
          DESTIN==" " 
          AAdd( aRecebida, { DATA__, HORA__, TITULO, ARQUIV, ENVIOU, OK____ } ) 
       ENDIF 
       DBSkip(-1) 
    ENDDO 
    IF Len( aRecebida ) <= 0 
       AAdd( aRecebida, { CTOD( "  /  /  " ), "  :  ", Space( 20 ), Space( 8 ), Space( 20 ), " " } ) 
    ENDIF 
 
    nTela:= 1 
    Keyboard Chr( K_TAB ) 
    SetColor( "07/00,14/01" ) 
    oTb1:= TBrowseNew( 06, 03, 11, 39 ) 
    oTb1:addcolumn(tbcolumnnew(,{|| DTOC( aEnviada[ nRow1 ][ 1 ] ) + " " +; 
                                    aEnviada[ nRow1 ][ 2 ] + " " + aEnviada[ nRow1 ][ 3 ] })) 
    oTb1:AUTOLITE:=.f. 
    oTb1:GoTopBlock:= {|| nRow1:=1 } 
    oTb1:GoBottomBlock:= {|| nRow1:= LEN( aEnviada ) } 
    oTb1:SkipBlock:= {|x| SkipperArr( x, aEnviada, @nRow1 ) } 
    oTb1:dehilite() 
 
    oTb2:= TBrowseNew( 14, 03, 19, 39 ) 
    oTb2:addcolumn(tbcolumnnew(,{|| DTOC( aRecebida[ nRow2 ][ 1 ] ) + " " +; 
                                    aRecebida[ nRow2 ][ 2 ] + " " + aRecebida[ nRow2 ][ 3 ] })) 
    oTb2:AUTOLITE:=.f. 
    oTb2:GoTopBlock:= {|| nRow2:=1 } 
    oTb2:GoBottomBlock:= {|| nRow2:= LEN( aRecebida ) } 
    oTb2:SkipBlock:= {|x| SkipperArr( x, aRecebida, @nRow2 ) } 
    oTb2:dehilite() 
 
    lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
    WHILE .T. 
       IF nTela==1 
          oTb1:colorrect({oTb1:ROWPOS,1,oTb1:ROWPOS,1},{2,1}) 
          WHILE NextKey()==0 .AND. ! oTb1:stabilize() 
          ENDDO 
          @ 21, 03 Say "Para " + aEnviada[ nRow1 ][ 5 ] Color "11/01" 
          @ 21, 68 Say IF( aEnviada[ nRow1 ][ 6 ]=="*", "          ", "<Pendente>" ) Color "10/01" 
       ELSE 
          oTb2:colorrect({oTb2:ROWPOS,1,oTb2:ROWPOS,1},{2,1}) 
          WHILE NextKey()==0 .AND. ! oTb2:Stabilize() 
          ENDDO 
          @ 21, 03 Say "De   " + aRecebida[ nRow2 ][ 5 ] Color "11/01" 
          @ 21, 68 Say IF( aRecebida[ nRow2 ][ 6 ]=="*", "          ", "<Pendente>" ) Color "10/01" 
       ENDIF 
       WHILE ( nTecla:= Inkey() )==0 
          IF ( ( nRefreshTimer+5 ) < SECONDS() ) 
             DispBegin() 
             oTb1:RefreshAll() 
             oTb1:forceStable() 
             WHILE !oTb1:Stabilize() 
             ENDDO 
             oTb2:RefreshAll() 
             oTb2:forceStable() 
             WHILE !oTb2:Stabilize() 
             ENDDO 
             DispEnd() 
             nRefreshTimer:= SECONDS() 
             EXIT 
          ENDIF 
       ENDDO 
       IF nTecla==K_ESC .OR. nTecla==K_CTRL_F12 
          exit 
       ENDIF 
       DO CASE 
          CASE nTecla==K_UP         ;IF( nTela==1, oTb1:up(), oTb2:up()) 
          CASE nTecla==K_DOWN       ;IF( nTela==1, oTb1:down(), oTb2:down()) 
          CASE nTecla==K_LEFT       ;IF( nTela==1, oTb1:up(), oTb2:up()) 
          CASE nTecla==K_RIGHT      ;IF( nTela==1, oTb1:down(), oTb2:down()) 
          CASE nTecla==K_PGUP       ;IF( nTela==1, oTb1:pageup(), oTb2:pageup()) 
          CASE nTecla==K_CTRL_PGUP  ;IF( nTela==1, oTb1:gotop(), oTb2:gotop()) 
          CASE nTecla==K_PGDN       ;IF( nTela==1, oTb1:pagedown(), oTb2:pagedown()) 
          CASE nTecla==K_CTRL_PGDN  ;IF( nTela==1, oTb1:gobottom(), oTb2:gobottom()) 
          CASE nTecla==K_DEL 
               IF nTela==1 
                  DBGoTop() 
                  WHILE !EOF() 
                     /* Caso seja pressionado DEL na enviada, marca origem como 
                        nao interessada em rever a mensagem */ 
                     IF DATA__ == aEnviada[ nRow1 ][ 1 ] .AND.; 
                        ARQUIV == aEnviada[ nRow1 ][ 4 ] 
                        IF netrlock() 
                           Replace ORIGEM With "*" 
                        ENDIF 
                     ENDIF 
                     DBSkip() 
                  ENDDO 
               ELSE 
                  DBGoTop() 
                  WHILE !EOF() 
                     /* Caso seja pressionado DEL na recebida, marca o destino */ 
                     IF DATA__ == aRecebida[ nRow2 ][ 1 ] .AND.; 
                        ARQUIV == aRecebida[ nRow2 ][ 4 ] 
                        IF netrlock() 
                           Replace DESTIN With "*" 
                        ENDIF 
                     ENDIF 
                     DBSkip() 
                  ENDDO 
               ENDIF 
 
          CASE nTecla==K_INS 
               IF !UseSenha() 
                  Loop 
               ENDIF 
               cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
               cCorRes:= SetColor( "00/02" ) 
               nCurRes:= SetCursor( 1 ) 
               Mensagem( "[" + _SETAS + "]Move [ENTER]Seleciona" ) 
               VPBox( 04, 07, 18, 70, " DESTINATARIO ", "15/02" ) 
               DBGoTop() 
               WHILE .T. 
                   nTeclaRes:= Inkey(0) 
                   DO CASE 
                      CASE nTeclaRes==K_ENTER 
                           EXIT 
                      CASE nTeclaRes==K_UP 
                           DBSkip( -1 ) 
                      CASE nTeclaRes==K_DOWN 
                           DBSkip( +1 ) 
                   ENDCASE 
                   @ 06,10 Say IF( EOF() .OR. BOF(), PAD( "TODOS", 20 ), PAD( UnZipChr( SEN->DESCRI ), 40 ) ) 
               ENDDO 
               cDestinatario:= UnzipChr( SEN->DESCRI ) 
               cTitulo:= Space( 30 ) 
               @ 07,10 Say "Titulo/Assunto:" Get cTitulo 
               READ 
               DBCloseArea() 
               DBSelectAr( 123 ) 
               SetCursor( 1 ) 
               Mensagem( "[CTRL+W]Salva [ESC]Cancela" ) 
               VPBox( 08, 07, 18, 70, " MENSAGEM ", "15/02" ) 
               FOR nCt:= 1 TO 9999 
                  IF !File( SWSet( _SYS_DIRREPORT ) + "\MAIL" + StrZero( nCt, 4, 0 ) + ".SGM" ) 
                     cArquivo:= SWSet( _SYS_DIRREPORT ) + "\MAIL" + StrZero( nCt, 4, 0 ) + ".SGM" 
                     EXIT 
                  ENDIF 
               NEXT 
               MEMOWRIT( cArquivo, "" ) 
               cTexto:= MEMOREAD( cArquivo ) 
               cTexto:= MEMOEDIT( cTexto, 09, 08, 17, 69  ) 
               MEMOWRIT( cArquivo, cTexto ) 
               DBSelectAr( 123 ) 
               DBAppend() 
               IF netrlock() 
                  Repl DATA__ With DATE(),; 
                       HORA__ With TIME(),; 
                       TITULO With cTitulo,; 
                       ARQUIV With "MAIL" + StrZero( nCt, 4, 0 ),; 
                       ENVIOU With wUsuario,; 
                       RECEBE With cDestinatario 
               ENDIF 
               DBUnlockAll() 
               AAdd( aEnviada, { DATA__, HORA__, TITULO, ARQUIV, RECEBE, " " } ) 
               SetColor( cCorRes ) 
               SetCursor( 0 ) 
               ScreenRest( cTelaRes ) 
               oTb1:RefreshAll() 
               WHILE !oTb1:Stabilize() 
               ENDDO 
               oTb2:RefreshAll() 
               WHILE !oTb2:Stabilize() 
               ENDDO 
 
               /* Sai ap�s gravar a mensagem */ 
               EXIT 
 
          CASE nTecla==K_DEL 
 
 
          CASE nTecla==K_ENTER 
               IF nTela == 2 .OR. nTela == 1 
                  IF IIF( nTela==2, File( SWSet( _SYS_DIRREPORT ) - "\" - aRecebida[ nRow2 ][ 4 ] + ".SGM" ),; 
                                    File( SWSet( _SYS_DIRREPORT ) - "\" -  aEnviada[ nRow1 ][ 4 ] + ".SGM" ) ) 
                     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                     cCorRes:= SetColor( "14/02" ) 
                     VPBox( 02, 05, 19, 72, " MENSAGEM ", "14/09", .T.,.T.,"00/14", ) 
                     IF nTela==1 
                        cOrigem:= wUsuario 
                        cDestino:= aEnviada[ nRow1 ][ 5 ] 
                     ELSE 
                        cOrigem:= aRecebida[ nRow2 ][ 5 ] 
                        cDestino:= wUsuario 
                     ENDIF 
                     @ 04,07 Say "De    " + cOrigem  Color "15/09" 
                     @ 05,07 Say "Para  " + cDestino Color "15/09" 
                     VPBox( 07, 07, 18, 70, ALLTRIM( IF( nTela==1, aEnviada[ nRow1 ][ 3 ], aRecebida[ nRow2 ][ 3 ] ) ), "15/02", .F., .F.,,.F. ) 
                     IF nTela==2 
                        ViewFile( SWSet( _SYS_DIRREPORT ) - "\" - aRecebida[ nRow2 ][ 4 ] + ".SGM", 08, 08, 15, 69 ) 
                     ELSEIF nTela==1 
                        ViewFile( SWSet( _SYS_DIRREPORT ) - "\" - aEnviada[ nRow1 ][ 4 ] + ".SGM", 08, 08, 15, 69 ) 
                     ENDIF 
 
                     IF aRecebida[ nRow2 ][ 6 ] == Space( 1 ) .AND. nTela == 2 
                        nOpcao:= 1 
                        @ 17, 09 Prompt " Marcar Como Lida " 
                        @ 17, 49 Prompt " Manter Mensagem  " 
                        Menu To nOpcao 
                        IF nOpcao==1 
                           DBGoTop() 
                           WHILE !EOF() 
                              IF DATA__ == aRecebida[ nRow2 ][ 1 ] .AND.; 
                                 ARQUIV == aRecebida[ nRow2 ][ 4 ] 
                                 IF netrlock() 
                                    Replace OK____ With "*" 
                                 ENDIF 
                                 aRecebida[ nRow2 ][ 6 ]:= "*" 
                              ENDIF 
                              DBSkip() 
                           ENDDO 
                        ENDIF 
                     ENDIF 
                     ScreenRest( cTelaRes ) 
                     SetColor( cCorRes ) 
                  ENDIF 
               ENDIF 
 
          CASE nTecla==K_TAB 
               nTela:= IF( nTela==1, 2, 1 ) 
 
               oTb1:RefreshAll() 
               WHILE !oTb1:Stabilize() 
               ENDDO 
 
               oTb2:RefreshAll() 
               WHILE !oTb2:Stabilize() 
               ENDDO 
 
          OTHERWISE 
       ENDCASE 
       oTb1:refreshcurrent() 
       oTb1:stabilize() 
       oTb2:refreshcurrent() 
       oTb2:stabilize() 
    ENDDO 
    Set( _SET_DELIMITERS, lDelimiters ) 
    dbunlockall() 
    DBCloseArea() 
    IF nArea > 0 
       DBSelectAr( nArea ) 
       IF nOrdem <> 0 
          DBSetOrder( nOrdem ) 
       ENDIF 
       IF nRegistro <> 0 
          DBGoTo( nRegistro ) 
       ENDIF 
    ENDIF 
    FechaArquivos() 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
 
Function ExisteMensagem() 
    cDirRep:= SWSet( _SYS_DIRREPORT ) 
    IF !FILE( cDirRep + "\MFORTUNA.SYS" ) 
       Return .F. 
    ENDIF 
    DBSelectAr( 123 ) 
    iif( Used(), DBCloseArea(), Nil ) 

    // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
    #ifdef LINUX
      use "&cdirrep/mfortuna.sys" alias f1_ shared  
    #else 
      USE "&cDirRep\MFORTUNA.SYS" Alias F1_ Shared  
    #endif
    aRecebida:= {} 
    DBGoBottom() 
    WHILE !BOF() 
       IF ( RECEBE==Pad( wUsuario, LEN( RECEBE ) ) .OR. ALLTRIM( RECEBE )=="TODOS" ) .AND. DESTIN==" " 
          IF Empty( OK____ ) 
             dbCloseArea() 
             DBSelectAR( _COD_CLIENTE ) 
             Return .T. 
          ENDIF 
       ENDIF 
       DBSkip(-1) 
    ENDDO 
    DBCloseArea() 
    Return .F. 
 
