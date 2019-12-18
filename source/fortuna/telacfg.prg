// ## CL2HB.EXE - Converted
 
#include "VPF.CH" 
#Include "INKEY.CH" 
 
/* 
Programador - Valmor P. Flores 
Data        - Novembro/2000 
Atualizacao - Junho/2001 


*/

#ifdef HARBOUR
function telacfg()
#endif


Local cTela:= ScreenSave( 0, 0, 24, 79 )
Local cCor:= SetColor(), aCorRes:= M->COR 
Local aCores, nCt, nTecla 
Local oTab 
 
   IF !File( GDir-"\CORES.DBF" ) 
      aCores:= {{"DESCRI","C", 15,00},; 
                {"COR___","C", 60,00}} 
      DBCreate( GDir-"\CORES.DBF", aCores ) 
   ENDIF 
 
   /* Abrir arquivo de TODAS AS CORES */ 
   DBSelectAr( 123 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/cores.dbf" alias ccc  
   #else 
     USE "&GDir\CORES.DBF" Alias CCC  
   #endif
 
   /* Gravar primeira cor */ 
   IF Lastrec() == 0 
      DBAppend() 
      Replace COR___ With "",; 
              DESCRI With "Cor Atual      " 
   ENDIF 
 
   /* Tela & Cor */ 
   VPBox( 0, 00, 24, 79, " CONFIGURACAO ", "15/00", .T., .T., "00/15" ) 
   SetColor( "07/00,15/01" ) 
 
   @ 10,59 Say "[ENTER] Seleciona " 
   @ 11,59 Say "[INS]   Edita/Cria" 
   @ 12,59 Say "["+_SETAS+"]  Movimenta" 
   @ 13,59 Say "[ESC]   Finaliza  " 
 
   @ 14,59 Say "컴컴컴컴컴컴컴컴컴" 
   @ 15,59 Say "As cores armazena-" Color "07/00" 
   @ 16,59 Say "das na  biblioteca" Color "07/00" 
   @ 17,59 Say "ficarao  disponi- " Color "07/00" 
   @ 18,59 Say "veis para todos os" Color "07/00" 
   @ 19,59 Say "usuarios da rede. " Color "07/00" 
 
   oTab:=tbrowseDB( 03, 59, 08, 77 ) 
   oTab:AddColumn( TbColumnNew(,{|| " " + DESCRI + Space( 5 ) })) 
   oTab:AUTOLITE:=.F. 
   oTab:dehilite() 
   while .T. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
      WHILE nextkey()==0 .and. ! oTab:stabilize() 
      ENDDO 
      IF !EMPTY( COR___ ) 
         COR:= Nil 
         COR:={} 
         FOR WCT:= 1 TO Len( COR___ ) 
             aadd( COR, tran( restbyte( substr( COR___, WCT, 2 ) ),"@R XX/XX" ) ) 
             ++WCT 
         NEXT 
      ENDIF 
      ConfigTela( 0 ) 
      nTecla:= Inkey(0) 
      IF nTecla==K_ESC 
         EXIT 
      ENDIF 
      DO CASE 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         Case nTecla==K_HOME .OR. nTecla==K_CTRL_PGUP ;oTab:gotop() 
         Case nTecla==K_END  .OR. nTecla==K_CTRL_PGDN ;oTab:gobottom() 
         CASE nTecla==K_DEL 
              IF CCC->( NetRLock() ) 
                 CCC->( DBDelete() ) 
                 oTab:refreshAll() 
                 WHILE !oTab:Stabilize() 
                 ENDDO 
              ENDIF 
 
         CASE nTecla==K_INS 
              ConfiguraCores() 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         CASE nTecla==K_ENTER 
              DBSelectAr( 124 ) 
              IF !buscanet(15,{|| dbusearea(.f.,,_VPD_CONFIG,"CFG",.t.,.f.),!neterr()}) 
                 ScreenRest( cTela ) 
                 SetColor( cCor ) 
                 DBSelectAr( _COD_CLIENTE ) 
                 Return Nil 
              ENDIF 
 
              DBGoTop() 
              cCorSalva:= "" 
              FOR nCt:= 1 TO Len( Cor ) 
                  cCorSalva:= cCorSalva + TranByte( Cor[ nCt ] ) 
              NEXT 
              IF NetRLock() 
                 Replace CORESV With cCorSalva 
              ENDIF 
              XCONFIG:= .T. 
              DBCloseArea() 
 
              DBSelectAr( 123 ) 
              exit 
 
      ENDCASE 
      oTab:RefreshCurrent() 
      oTab:Stabilize() 
   ENDDO 
   IF nTecla==K_ESC 
      Cor:= aCorRes 
   ENDIF 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   DBSelectAr( 123 ) 
   DBCloseArea() 
   DBSelectAr( _COD_CLIENTE ) 
   Return Nil 
 
Static Function ConfiguraCores() 
Local aCorRes:= M->Cor 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local nOpcaoLCor:= 0,; 
      nOpcaoCCor:= 0 
Local lDesativado:= .T. 
Local nSubOpcao:= 1 
Local oTab, nTecla, lDelimiters, nRow:= 1 
Local aOpcoes:= { { " Tela Principal  ", 1 },; 
                  { " Menu de Opcoes  ", 2 },; 
                  { " Edicao de dados ", 3 } } 
 
   aSubOpcoes:= { { 1, "Titulo do Sistema",; 
                       "Empresa",; 
                       "Usuario",; 
                       "Barra de Rolagem",; 
                       "Fundo",; 
                       "Mensagem",; 
                       "Ajuda" },; 
                  { 2, "Box",; 
                       "Opcao",; 
                       "Realce",; 
                       "Barra Selecao",; 
                       "Sombra" },; 
                  { 3, "Descricao Campo",; 
                       "Campo em Edicao",; 
                       "Campo Editado",; 
                       "Display de Opcoes",; 
                       "Barra do Display" } } 
 
   VPBox( 0, 00, 24, 79, " CONFIGURACAO ", "15/00", .T., .T., "00/15" ) 
   SetColor( "07/00,15/01" ) 
   oTab:=tbrowsenew( 03, 59, 08, 77 ) 
   oTab:addcolumn(tbcolumnnew(,{|| PAD( aOpcoes[nROW][1], 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:GOTOPBLOCK :={|| nROW:=1} 
   oTab:GOBOTTOMBLOCK:={|| nROW:=len(aOpcoes)} 
   oTab:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aOpcoes,@nROW)} 
   oTab:dehilite() 
   lAtivaSelecaoCor:= .F. 
   lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
   WHILE .T. 
 
      IF lDesativado 
         oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
         WHILE nextkey()==0 .and. ! oTab:stabilize() 
         ENDDO 
      ENDIF 
      ConfigTela( aOpcoes[ nRow ][ 2 ] ) 
 
      // Exibe Sub-Opcoes 
      cCorRes:= SetColor( "07/00" ) 
      IF lDesativado 
         Scroll( 09, 59, 20, 78 ) 
         @ 09,59 Say "컴컴컴컴컴컴컴컴컴�" Color "08/00" 
         @ 17,59 Say "컴컴컴컴컴컴컴컴컴�" Color "08/00" 
         FOR nCt:= 1 TO Len( aSubOpcoes ) 
             IF aSubOpcoes[ nCt ][ 1 ]==aOpcoes[ nRow ][ 2 ] 
                FOR nPos:= 2 TO Len( aSubOpcoes[ nCt ] ) 
                    @ 08+nPos,59 Say aSubOpcoes[ nCt ][ nPos ] Color IF( nSubOpcao + 1 == nPos, "14/00", "07/00" ) 
                NEXT 
             ENDIF 
         NEXT 
      ENDIF 
      SetColor( cCorRes ) 
 
      IF !lAtivaSelecaoCor 
         nTecla:= Inkey(0) 
      ELSE 
         nTecla:= 0 
      ENDIF 
 
      IF nTecla==K_ESC 
         nOpcao:= 0 
         exit 
      ENDIF 
      cTelaG:= ScreenSave( 0, 0, 24, 79 ) 
      DO CASE 
         CASE nTecla==K_LEFT 
              IF nSubOpcao > 1 
                 --nSubOpcao 
              ENDIF 
         CASE nTecla==K_RIGHT 
              ++nSubOpcao 
 
         CASE nTecla==K_UP         ;oTab:up() 
              nSubOpcao:= 1 
         CASE nTecla==K_DOWN       ;oTab:down() 
              nSubOpcao:= 1 
         CASE nTecla==K_F12        ;Calculador() 
         CASE nTecla==K_ENTER 
              lAtivaSelecaoCor:= .T. 
              nOpcaoLCor:= 0 
              nOpcaoCCor:= 0 
 
         OTHERWISE 
             IF nTecla > 0 
                tone(125); tone(300) 
             ENDIF 
      ENDCASE 
      IF lAtivaSelecaoCor 
 
         IF lDesativado 
            cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         ENDIF 
 
         DispBegin() 
         nLinha:= 03 
         nColuna:= 60 
 
         /* Configura as cores */ 
         cCorOk:= StrZero( nOpcaoLCor, 2, 0 ) + "/" + ; 
                  StrZero( nOpcaoCCor, 2, 0 ) 
 
         IF aOpcoes[ nRow ][ 2 ]==1 
            IF nSubOpcao==1 
               _COR_SISTEMA:= cCorOK 
            ELSEIF nSubOpcao==2 
               _COR_EMPRESA:= cCorOK 
            ELSEIF nSubOpcao==3 
               _COR_USUARIO:= cCorOK 
            ELSEIF nSubOpcao==4 
               SWSet( _GER_BARRACOR, cCorOK ) 
            ELSEIF nSubOpcao==5 
               _COR_FUNDO:= cCorOk 
            ELSEIF nSubOpcao==6 
               _COR_MENSAGEM:= cCorOk 
            ELSEIF nSubOpcao==7 
               _COR_AJUDA:= cCorOk 
            ENDIF 
         ELSEIF aOpcoes[ nRow ][ 2 ]==2 
            IF nSubOpcao==1 
               _COR_MENU_BOX:= cCorOK 
            ELSEIF nSubOpcao==2 
               _COR_MENU_OP:= cCorOK 
            ELSEIF nSubOpcao==3 
               _COR_MENU_REALSE:= cCorOK 
            ELSEIF nSubOpcao==4 
               _COR_MENU_BARRA:= cCorOK 
            ELSEIF nSubOpcao==5 
               _COR_SOMBRA:= cCorOk 
            ENDIF 
         ELSEIF aOpcoes[ nRow ][ 2 ]==3 
            IF nSubOpcao==1 
               _COR_GET_LETRA:=  cCorOk 
            ELSEIF nSubOpcao==2 
               _COR_GET_REALSE:= cCorOk 
            ELSEIF nSubOpcao==3 
               _COR_GET_CURSOR:= cCorOk 
            ELSEIF nSubOpcao==4 
               _COR_BROW_LETRA:= cCorOk 
               _COR_BROW_BOX:= cCorOk 
            ELSEIF nSubOpcao==5 
               _COR_BROW_BARRA:= cCorOk 
            ENDIF 
         ENDIF 
 
         // Remonta a tela 
         ConfigTela( aOpcoes[ nRow ][ 2 ] ) 
 
         // Exibe tabela de cores para selecao 
         IF lDesativado 
            VPBox( nLinha-1, nColuna-1, nLinha+19, nColuna+17, , "15/01", .F., .F. ) 
         ENDIF 
 
         /* Seta */ 
         SetColor( "15/01" ) 
         Scroll( nLinha, nColuna+16, nLinha+16, nColuna+16 ) 
         Scroll( nLinha+16, nColuna, nLinha+16, nColuna+16 ) 
         @ nLinha+nOpcaoLCor,nColuna+16  Say "" Color "15/01" 
         @ nLinha+16,nColuna+nOpcaoCCor Say  "" Color "15/01" 
 
         @ nLinha+18,nColuna Say "< 같굇께昉껑굅� >" Color ; 
                        StrZero( nOpcaoLCor, 2, 0 ) + "/" + ; 
                        StrZero( nOpcaoCCor, 2, 0 ) 
 
         IF lDesativado 
            FOR nFrente:= 0 TO 15 
                FOR nFundo:= 0 TO 15 
                    @ nLinha+nFrente,nColuna+nFundo Say "*" Color StrZero( nFrente, 2 ) + "/" + StrZero( nFundo, 2 ) 
                NEXT 
            NEXT 
         ENDIF 
         DispEnd() 
 
         lDesativado:= .F. 
         nTeclaCor:= Inkey(0) 
         DO CASE 
            CASE nTeclaCor==K_RIGHT 
                 IF nOpcaoCCor < 15 
                    ++nOpcaoCCor 
                 ENDIF 
            CASE nTeclaCor==K_UP 
                 IF nOpcaoLCor > 0 
                    --nOpcaoLCor 
                 ENDIF 
            CASE nTeclaCor==K_DOWN 
                 IF nOpcaoLCor < 15 
                    ++nOpcaoLCor 
                 ENDIF 
            CASE nTeclaCor==K_LEFT 
                 IF nOpcaoCCor > 0 
                    --nOpcaoCCor 
                 ENDIF 
            CASE nTeclaCor==K_ENTER 
                 lAtivaSelecaoCor:= .F. 
                 ScreenRest( cTelaRes ) 
                 lDesativado:= .T. 
         ENDCASE 
 
      ENDIF 
      IF lDesativado 
         oTab:refreshcurrent() 
         oTab:stabilize() 
      ENDIF 
   ENDDO 
 
   IF ( nOp:= SWAlerta( "<< CONFIGURACOES >>;Foram modificadas as configuracoes do sistema;"+; 
               "O que voce deseja fazer?", { "Gravar na Biblioteca", "Gravar", "Cancelar" } ) )==2 
 
      DBSelectAr( 124 ) 
      IF !buscanet(15,{|| dbusearea(.f.,,_VPD_CONFIG,"CFG",.t.,.f.),!neterr()}) 
         ScreenRest( cTela ) 
         SetColor( cCor ) 
         DBSelectAr( _COD_CLIENTE ) 
         Return Nil 
      ENDIF 
 
      DBGoTop() 
      cCorSalva:= "" 
      FOR nCt:= 1 TO Len( Cor ) 
          cCorSalva:= cCorSalva + TranByte( Cor[ nCt ] ) 
      NEXT 
      IF NetRLock() 
         Replace CORESV With cCorSalva 
      ENDIF 
      XCONFIG:= .T. 
      DBCloseArea() 
 
      Keyboard Chr( K_ESC ) + Chr( K_ESC ) + Chr( K_ESC ) + Chr( K_ESC ) + Chr( K_ESC ) 
 
      DBSelectAr( 123 ) 
 
   ELSEIF nOp==1 
      cCorAnterior:= CCC->DESCRI 
      cCorSalva:= "" 
      cDescri:= CCC->DESCRI 
      VPBox( 10, 13, 18, 70, "Editar/Acrescentar Cor na Biblioteca", "15/01" ) 
      @ 12,15 Say "Descricao" 
      @ 13,15 Get cDescri 
      READ 
      IF ! ( ALLTRIM( cDescri ) == ALLTRIM( cCorAnterior ) ) 
         CCC->( DBAppend() ) 
      ENDIF 
      FOR nCt:= 1 TO Len( Cor ) 
          cCorSalva:= cCorSalva + TranByte( Cor[ nCt ] ) 
      NEXT 
      IF CCC->( NetRLock() ) 
         Replace CCC->DESCRI With cDescri,; 
                 CCC->COR___ With cCorSalva 
      ENDIF 
   ELSE 
      Cor:= aCorRes 
   ENDIF 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
 
 
STAT func tranbyte(STRING) 
return(chr(val(substr(STRING,1,2))+150)+chr(val(substr(STRING,4,2))+150)) 
 
 
Static Function ConfigTela( nOpcao ) 
 
  DispBegin() 
 
  // Tela Principal 
  @ 03,02 Say " FORTUNA Automacao Comercial                  00:00:00 " Color _COR_SISTEMA 
  @ 04,02 Say " Empresa                                               " Color _COR_EMPRESA 
  @ 04,48 Say " Usuario "                                     Color _COR_USUARIO 
  @ 05,02 Say " <<< Barra de Rolagem <<<                              " Color _COR_BARRA 
  SetColor( _COR_FUNDO ) 
  VPFundoFraze( 06, 02, 19, 56, ScreenBack ) 
  @ 20,02 Say "                  Mensagem de Auxilio                  " Color _COR_MENSAGEM 
  @ 21,02 Say "                     [Tecla]Funcao                     " Color _COR_AJUDA 
 
  DO CASE 
     CASE nOpcao==2 
          // Menu 
          VPBox( 07, 05, 11, 20 ) 
          SetColor( _COR_MENU_OP ) 
          @ 08,06 Say "   Opcao 1   " Color _COR_MENU_BARRA 
          @ 08,07 Say "1"              Color _COR_MENU_BARRA 
          @ 09,06 Say "   Opcao 2   " Color _COR_MENU_OP 
          @ 09,07 Say "2"              Color _COR_MENU_REALSE 
          @ 10,06 Say "   Opcao 3   " Color _COR_MENU_OP 
          @ 10,07 Say "0"              Color _COR_MENU_REALSE 
 
     CASE nOpcao==3 
          // Edicao 
          VPBox( 03, 02, 19, 56, " EDICAO ", _COR_GET_EDICAO, .F., .F. ) 
          @ 05,04 Say "Campo1......: [                                    ]" Color _COR_GET_EDICAO 
          @ 05,19 Say PAD( "Campo em edicao", 36 )   Color _COR_GET_REALSE 
          @ 06,04 Say "Campo2......: [                         ]" Color _COR_GET_EDICAO 
          @ 06,19 Say PAD( "Campo Editado",   25 )   Color _COR_GET_CURSOR 
          @ 07,04 Say "Campo3......: [                         ]" Color _COR_GET_EDICAO 
          @ 07,19 Say PAD( "Campo Editado",   25 )   Color _COR_GET_CURSOR 
          VPBox( 13, 02, 19, 56, " Display ", _COR_BROW_BOX, .F., .F. ) 
          @ 14,03 Say PAD( "0001 Informacao Gravada A         ", 53 ) Color _COR_BROWSE 
          @ 15,03 Say PAD( "0002 Informacao Em Edicao         ", 53 ) Color _COR_BROW_BARRA 
          @ 16,03 Say PAD( "0003 Informacao Gravada B         ", 53 ) Color _COR_BROWSE 
          @ 17,03 Say PAD( "...", 53 ) Color _COR_BROWSE 
 
   ENDCASE 
   DispEnd() 
 
 
