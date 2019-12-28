// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC10000 
* Descricao   - Utilitarios 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function vpc10000()
#endif


Local cTELA:=zoom( 08, 14, 19, 34 ), cCOR:=setcolor(), nOPCAO:=0 
VPBox( 08, 14, 19, 34 ) 
WHILE .T. 
   mensagem("") 
   aadd(MENULIST,swmenunew(09,15," 1 Senhas         ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de senhas/usuarios.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(10,15," 2 Configuracao   ",2,COR[11],; 
        "Configuracao do ambiente de trabalho, cores, zoom, etc.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(11,15," 3 Reindexacao    ",2,COR[11],; 
        "Reorganizacao dos arquivos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(12,15," 4 Comunicacao    ",2,COR[11],; 
        "Remessa de T�tulos ao Banco / Importar Lista de Precos / Exportar Arquivos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(13,15," 5 Transferencia  ",2,COR[11],; 
        "Copias de seguranca.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(14,15," 6 Empresa        ",2,COR[11],; 
        "Copias de seguranca.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(15,15," 7 LOG Execucao   ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(16,15," 8 Limpeza Dados  ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(17,15," 9 API comunicar  ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(18,15," 0 Retorna        ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
 
   // Selecoes de menu 
   do case 
      case nOpcao=0 .or. nOPCAO=10; exit 
      case nOpcao=1; DisplayUsuarios() 
      case nOpcao=2; VPC14300() 
      case nOpcao=3; VPC15000() 
      case nOpcao=4; MenuComunica() 
      case nOpcao=5; Transferencia() 
      case nOpcao=6; Empresa() 
      case nOpcao=8; MenuLimpa() 
      case nOpcao=9; ComunicaAPI()
      case nOpcao=7 
           ViewFile( "LOG.TXT" ) 
           EXIT 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
 
 
 
 
 
 
 
 
 
 
 
 
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
Function MenuComunica() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
  aOpcoes:= { { " BANCO     ", " BANRISUL                  ", 01, {|| Nil } },; 
              { " BANCO     ", " BANCO DO BRASIL           ", 02, {|| Nil } },; 
              { " BANCO     ", " BRADESCO                  ", 03, {|| Nil } },; 
              { " BANCO     ", " BAMERINDUS                ", 04, {|| Nil } },; 
              { " BANCO     ", " ITAU                      ", 05, {|| Nil } },; 
              { " BANCO     ", " REAL                      ", 06, {|| Nil } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " FEIRAS    ", " IMPORTACAO DE PEDIDOS     ", 47, {|| ImportaPedidos() } },; 
              { " FEIRAS    ", " PREPARACAO DO MICRO       ", 48, {|| PCF() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " FARMACIA  ", " DIMED                     ", 07, {|| Nil } },; 
              { " FARMACIA  ", " ABAFARMA                  ", 08, {|| Abafarma() } },; 
              { " FARMACIA  ", " PANARELLO                 ", 09, {|| Panarello() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " AUTOPECAS ", " BARROS                    ", 10, {|| Barros() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " CORES     ", " COMBILUX GLASURIT         ", 19, {|| CGlasurit() } },; 
              { " CORES     ", " MIXING GLASURIT           ", 11, {|| Glasurit() } },; 
              { " CORES     ", " A.C.S. CORAL              ", 12, {|| ACS() } },; 
              { " CORES     ", " RENNER AUTOMOTIVO         ", 13, {|| Renner() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " SISTEMA   ", " EVOLUTIVA                 ", 14, {|| SoftWare() } },; 
              { " SISTEMA   ", " ATUALIZACAO VIA INTERNET  ", 15, {|| Nil } },; 
              { " SISTEMA   ", " DIARIO DE COMUNICACAO     ", 16, {|| VisualComunicacao() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " MERCADOS  ", " BALANCAS TOLEDO           ", 14, {|| ExpToledo() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " LIVROS    ", " WinLIVROS - DATACEMPRO (R)", 16, {|| ExpWinLivros() } },; 
              { "           ", "���������������������������",  0, {|| Nil } },; 
              { " FINALIZA  ", " TERMINO DA EXECUCAO       ", 00, {|| Nil } } }
  vpbox(00,00,22,79, " SISTEMA DE IMPORTACOES / EXPORTACOES ", ,.F., .F. ) 
  lOk:= .F. 
  nRow:= 1 
  nOpcao:= 1 
  SetColor( "15/04, 00/14" ) 
  VPBoxSombra( 02, 01, 19, 39,, "15/04", "00/01" ) 
  oTAB:=tbrowsenew(03,02,18,38) 
  oTAB:addcolumn(tbcolumnnew(,{|| aOpcoes[ nRow ][ 1 ] + " - " + aOpcoes[ nRow ][ 2 ] })) 
  oTAB:AUTOLITE:=.F. 
  oTAB:GOTOPBLOCK :={|| nROW:=1} 
  oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aOpcoes)} 
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aOpcoes,@nROW)} 
  oTAB:dehilite() 
  WHILE .T. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      WHILE nextkey()==0 .and. ! oTAB:stabilize() 
      ENDDO 
      nTecla:= Inkey(0) 
      IF nTecla==K_ESC 
         nOpcao:= 0 
         exit 
      ENDIF 
      cTelaG:= ScreenSave( 0, 0, 24, 79 ) 
      DO CASE 
         CASE nTecla==K_UP         ;oTAB:up() 
         CASE nTecla==K_DOWN       ;oTAB:down() 
         CASE nTecla==K_LEFT       ;oTAB:up() 
         CASE nTecla==K_RIGHT      ;oTAB:down() 
         CASE nTecla==K_PGUP       ;oTAB:pageup() 
         CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
         CASE nTecla==K_PGDN       ;oTAB:pagedown() 
         CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
         CASE nTecla==K_F12        ;Calculador() 
         CASE nTecla==K_CTRL_F10   ;Calendar() 
         CASE nTecla==K_ENTER 
              IF aOpcoes[ nRow ][ 3 ] == 0 
                 EXIT 
              ELSE 
                 SWSet( _GER_BARRAROLAGEM, .F. ) 
                 cCorRes:= SetColor( "15/01" ) 
                 Eval( aOpcoes[ nRow ][ 4 ] ) 
                 SetColor( cCorRes ) 
                 SWSet( _GER_BARRAROLAGEM, .T. ) 
              ENDIF 
         OTHERWISE                ;tone(125); tone(300) 
      ENDCASE 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
  ENDDO 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � Panarello 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function Panarello() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(02,45," 1 Lista de Precos        ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(03,45," 2 Espelho de Nota Fiscal ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(04,45," 3 O. Compra - Remessa    ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(05,45," 4 O. Compra - Retorno    ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(06,45," 5 Promocoes              ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(07,45," 0 Retorna                ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=6; exit 
      case nOPCAO=1; iPrecoPanarello() 
      case nOPCAO=2; iNFPanarello() 
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � Barros 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function Barros() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(02,45," 1 Lista de Produtos      ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(03,45," 2 Lista de Fabricantes   ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(04,45," 0 Retorna                ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=6; exit 
      case nOPCAO=1; iProdBarros() 
      case nOPCAO=2; iFabBarros() 
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � Glasurit 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function Glasurit() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(02,45," 1 Base de dados          ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(03,45," 2 Formulas               ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(04,45," 0 Retorna                ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=3; exit 
      case nOPCAO=1; iGlasBase() 
      case nOpcao=2; iGlasFormula() 
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
 
 
/***** 
�������������Ŀ 
� funcao      � cglasurit 
� finalidade  � 
� parametros  � 
� retorno     � 
� programador � 
� data        � 
��������������� 
*/ 
static function cglasurit() 
local ccor:= setcolor(), ncursor:= setcursor(),; 
      ctela:= screensave( 0, 0, 24, 79 ) 
local nopcao:= 0 
whil .t. 
   mensagem("") 
   aadd(menulist,swmenunew(02,45," 1 produtos/precos        ",2,cor[11],; 
        "",,,cor[6],.t.)) 
   aadd(menulist,swmenunew(03,45," 0 retorna                ",2,cor[11],; 
        "retorna ao menu anterior.",,,cor[6],.t.)) 
   swMenu(menulist,@nopcao); menulist:={} 
   do case 
      case nopcao=0 .or. nopcao=3; exit 
      case nopcao=1; icglaspro() 
   endcase 
enddo 
setcolor( ccor ) 
setcursor( ncursor ) 
screenrest( ctela ) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � Renner 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function Renner() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(02,45," 1 Base de dados / Precos ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(03,45," 0 Retorna                ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=2; exit 
      case nOPCAO=1; RennerPreco() 
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
 
/***** 
�������������Ŀ 
� Funcao      � ACS 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function ACS() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(02,45," 1 Lista de Precos        ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(03,45," 2 Base de dados          ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(04,45," 0 Retorna                ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=3; exit 
      case nOPCAO=2; iACSBase() 
      case nOpcao=1; iACSPreco() 
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � ABAFARMA 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function Abafarma() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew( 02, 45," 1 Lista de Precos        ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew( 03, 45," 2 Lista de Prod. Novos   ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew( 04, 45," 3 Lista de Fabricantes   ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew( 05, 45," 4 Executar ABFCONS.EXE   ",2,COR[11],; 
        "Executa sistema de consulta abafarma.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew( 06, 45," 0 Retorna                ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOPCAO=1; iProdPreAbafar() 
      case nOPCAO=2; iProdAbafar() 
      case nOPCAO=3; iFabAbafar() 
      case nOpcao=4 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           cDiretorio:= "\" + CURDIR() 
           cDrive:= "C:" 
           IF AT( "FORTUNA",     CURDIR("C") ) > 0 
              cDrive:= "C:" 
           ELSEIF AT( "FORTUNA", CURDIR("D") ) > 0 
              cDrive:= "D:" 
           ELSEIF AT( "FORTUNA", CURDIR("E") ) > 0 
              cDrive:= "E:" 
           ELSEIF AT( "FORTUNA", CURDIR("F") ) > 0 
              cDrive:= "F:" 
           ELSEIF AT( "FORTUNA", CURDIR("G") ) > 0 
              cDrive:= "G:" 
           ENDIF 
 
           Run MODE CO80      >Nul 
           Run C:             >Nul 
           Run CD\ABFP1       >Nul 
           Run ABFCONS        >Nul 
 
           DispBegin() 
           Run &cDrive        >Nul 
           Run CD &cDiretorio >Nul 
           ModoVga( .T. ) 
           Run START RestauraModo 
           DispEnd() 
           ScreenRest( cTelaRes ) 
           SetBlink( .F. ) 
 
   ENDCASE 
ENDDO 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � SoftWare 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function SoftWare() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 0 
SWSet( _GER_BARRAROLAGEM, .F. ) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(02,45," 1 Estoque        - Remessa ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(03,45," 2 Estoque        - Retorno ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(04,45," 3 Duplicatas     - Remessa ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(05,45," 4 Duplicatas     - Retorno ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(06,45," 5 Clientes       - Remessa ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(07,45," 6 Clientes       - Retorno ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(08,45," 7 Produtos       - Remessa ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(09,45," 8 Produtos       - Retorno ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(10,45," 9 Pedidos        - Remessa ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(11,45," A Pedidos        - Consulta",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(12,45," B Pedidos        - Retorno ",2,COR[11],; 
        "",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(13,45," 0 Retorna                  ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=12; exit 
      case nOPCAO=1; iSWEstoque() 
      case nOpcao==4; iSWBaseCobranca() 
      case nOPCAO==5; eSWCliente() 
      case nOPCAO=6; iSWCliente() 
      case nOPCAO=8; iSWProduto() 
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
SWSet( _GER_BARRAROLAGEM, .F. ) 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � EMPRESA 
� Finalidade  � Cadastro de Multi-Empresas 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function Empresa() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local ctelaRes, aTelares:= {} 
   aTelaRes:= 0 
   aTelaRes:= {} 
   aTelaR2:= 0 
   aTelaR2:= {} 
   nCol:= 80 
   FOR nCt:=1 TO 8 
       nCol:= nCol-10 
       AAdd( aTelaRes, SaveScreen( 00, 00, 24, nCol ) ) 
       AAdd( aTelaR2,  SaveScreen( 00, nCol, 24, 79 ) ) 
   NEXT 
   nCol:= -80 
   nLin:= -25 
   FOR nCt:= 1 TO 8 
       nCol:= nCol + 10 
       nLin:= nLin + 3 
       Dispbegin() 
       VPBox( nLin, nCol, nLin+22, nCol + 79, " < Multi E M P R E S A > - Soft&Ware Inform�tica ", _COR_BROW_BOX ) 
       Inkey(.1) 
       DispEnd() 
   NEXT 
 
   IF !File( SWSet( _SYS_DIRREPORT ) + "\EMPRESAS.DBF" ) 
      aStr:= {{"CODIGO", "N", 03, 00 },; 
              {"DESCRI", "C", 45, 00 },; 
              {"ENDERE", "C", 35, 00 },; 
              {"BAIRRO", "C", 25, 00 },; 
              {"CIDADE", "C", 20, 00 },; 
              {"ESTADO", "C", 02, 00 },; 
              {"CODCEP", "C", 08, 00 },; 
              {"RESPON", "C", 45, 00 },; 
              {"CGCMF_", "C", 14, 00 },; 
              {"DATA__", "D", 08, 00 }} 
      DBCreate( SWSet( _SYS_DIRREPORT ) + "\EMPRESAS.DBF", aStr ) 
   ENDIF 
 
   /* Abre empresa na area tempor�ria 124 */ 
   DBSelectAr( 124 ) 
   cDirEmp:= SWSet( _SYS_DIRREPORT ) + "\EMPRESAS.DBF" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cDirEmp Alias EMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODIGO To INDICE0_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On DESCRI To INDICE1_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To INDICE0_.NTX, INDICE1_.NTX 
   DBGoTop() 
 
   DispBegin() 
   SetColor( _COR_BROW_BOX ) 
   VPBox( 0, 0, 22, 79, " < Multi E M P R E S A > - Soft&Ware Inform�tica ", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ENTER] p/ Selecionar a Empresa.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [INS]Novo [DEL]Exclui [*]Altera [ENTER]Selec. [ESC]Sai") 
   DBLeOrdem() 
   oTab:=tbrowsedb( 01, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew(,{|| STRZERO( Codigo, 3, 0) + " " + DESCRI + Space( 30 ) } )) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   /* Busca a Empresa */ 
   IF AT( "\0", Alltrim( GDir ) ) - 1 > 0 
      nCodigo:= VAL( Alltrim( SubStr( GDir, AT( "\0", Alltrim( GDir ) ) + 2 ) ) ) 
      nTentativa:= 0 
      WHILE !EOF() 
         IF ++nTentativa > 100 
            DBGoTop() 
            EXIT 
         ELSEIF !( nCodigo == CODIGO ) 
            oTab:Down() 
            oTab:RefreshAll() 
            WHILE !oTab:Stabilize() 
            ENDDO 
         ELSE 
            EXIT 
         ENDIF 
      ENDDO 
   ENDIF 
   DispEnd() 
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
         case Chr( nTecla )=="*" 
              AlteraEmp( oTab ) 
         case nTecla==K_ENTER 
              IF Codigo == 0 
                 IF AT( "\0", Alltrim( GDir ) ) - 1 > 0 
                    GDir:= Left( GDir, AT( "\0", Alltrim( GDir ) ) - 1 ) 
                 ELSE 
                    GDir:= Alltrim( GDir ) 
                 ENDIF 
                 nRecno:= RECNO() 
                 Config( 0 ) 
                 _EMP:= "*> " + DESCRI 
              ELSE 
                 Config( CODIGO ) 
                 _EMP:= DESCRI 
                 nCol:= 0 
                 nCt2:= 1 
                 //nCt2:= Len( aTelaRes ) - 1 
                 FOR nCt:=1 TO 8 
                     cTelaRes:=SaveScreen( 00, nCol, 24, 69 ) 
                     DispBegin() 
                     inkey(.1) 
                     nCol+=10 
                     SetColor( "15/00" ) 
                     Scroll( 00, 00, 24, 79 ) 
                     IF nCt2 > 0 .AND. nCt2 < Len( aTelaR2 ) 
                        restscreen( 00, 00, 24, nCol - 1, aTelaR2[ nCt2 ] ) 
                        nCt2:= nCt2 + 1 
//                        restscreen( 00, 00, 24, nCol, aTelaRes[ nCt2 ] ) 
//                        nCt2:= nCt2 - 1 
                     ENDIF 
                     restscreen( 00, nCol+2, 24, 79+2, cTelaRes ) 
                     DispEnd() 
                 NEXT 
                 IF AT( "\0", Alltrim( GDir ) ) - 1 > 0 
                    GDir:= Left( GDir, AT( "\0", Alltrim( GDir ) ) - 1 ) + "\0" + StrZero( CODIGO, 3 ) 
                 ELSE 
                    GDir:= Alltrim( GDir ) + "\0" + StrZero( CODIGO, 3 ) 
                 ENDIF 
 
                 /// Reposiciona diretorio padrao com base em GDir 
                 SetDiretorioPadrao( 0 ) 
 
                 nRecno:= RECNO() 
                 SetCursor( nCursor ) 
                 ScreenRest( cTela ) 
 
              ENDIF 
              Aviso( "Aguarde a substituicao da empresa!" ) 
              DBCloseAll() 
              AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
 
              /* SELECIONA EMPRESAS */ 
              Sele 124 
              IF !Used() 
                  cDirEmp:= SWSet( _SYS_DIRREPORT ) + "\EMPRESAS.DBF" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                  Use &cDirEmp Alias EMP 
              ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Index On CODIGO To INDICE0_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Index On DESCRI To INDICE1_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Set Index To INDICE0_.NTX, INDICE1_.NTX 
 
              DBGoTo( nRecno ) 
 
              // Aviso( "Selecionado diretorio de trabalho " + GDIR ) 
              // Pausa() 
 
              Exit 
         case nTecla==K_INS        ;IncluiEmp(oTab) 
         case nTecla==K_DEL 
              nCodigo:= CODIGO 
              Exclui( oTab ) 
              IF Confirma( 0, 0, "Destruir os dados desta empresa?", "*", "*" ) 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Mensagem( " " ) 
                 IF AT( "\0", Alltrim( GDir ) ) - 1 > 0 
                    GDirRes:= Left( GDir, AT( "\0", Alltrim( GDir ) ) - 1 ) + "\0" + StrZero( nCodigo, 3 ) 
                 ELSE 
                    GDirRes:= Alltrim( GDir ) + "\0" + StrZero( nCodigo, 3 ) 
                 ENDIF 
                 @ Row(),02 Say Space( 0 ) 
                 !DelTree &GDirRes /Y 
                 !Md &GDirRes 
                 !Rd &GDirRes 
                 ScreenRest( cTelaRes ) 
                 Mensagem( "" ) 
              ENDIF 
         case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
 
   dbCloseArea() 
   DBSelectAr( _COD_CLIENTE ) 
   FechaArquivos() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 
   IF !( LastKey() == K_ESC ) 
      SetColor( "15/00" ) 
      Scroll( 01, 01, 01, 45, ,-1 ) 
      FOR nCt:= 1 TO 45 
          Scroll( 01, 01, 01, 45, ,-1 ) 
          @ 01,01 Say SubStr( PAD( _EMP, 45 ), 45 - nCt ) 
          IF nCt==1  .OR. nCt==5  .OR. nCt==10 .OR. nCt==15 .OR.; 
             nCt==20 .OR. nCt==25 .OR. nCt==30 .OR.; 
             nCt==35 .OR. nCt==40 .OR. nCt==45 
             Inkey(0.01) 
          ENDIF 
      NEXT 
      SetColor( cCor ) 
      Titulo( PAD( _EMP, 45 ) ) 
   ENDIF 
 
   Return(.T.) 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiEmp() 
� Finalidade  � Inclusao de uma nova empresa no sistema 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function IncluiEmp( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= 0, cDESCRI:= Space( 45 ), cENDERE:= Space( 35 ),; 
      cBAIRRO:= Space( 25 ), cCIDADE:= Space( 20 ), cESTADO:= Space( 02 ),; 
      cCODCEP:= Space( 08 ), cRESPON:= Space( 45 ), cCGCMF_:= Space( 14 ),; 
      dDATA__:= Date() 
Local nOrdem:= IndexOrd() 
    SetCursor( 1 ) 
    VPBox( 07, 10, 18, 75, " Inclusao ", _COR_GET_BOX ) 
    SetColor( _COR_GET_EDICAO ) 
    @ 08,12 Say "Codigo........:" Get nCodigo Pict "999" 
    @ 09,12 Say "Nome/R. Social:" Get cDescri 
    @ 10,12 Say "CGC/MF........:" Get cCGCMF_ Pict "@R 99.999.999/9999-99" 
    @ 11,12 Say "Endereco......:" Get cEndere 
    @ 12,12 Say "Bairro........:" Get cBairro 
    @ 13,12 Say "Cidade........:" Get cCidade 
    @ 14,12 Say "Estado........:" Get cEstado 
    @ 15,12 Say "Cep...........:" Get cCodCep Pict "@R 99999-999" 
    @ 16,12 Say "Responsavel...:" Get cRespon 
    @ 17,12 Say "Data..........:" Get dData__ 
    READ 
    IF !LastKey()==K_ESC 
       dbAppend() 
       Replace CODIGO With nCodigo,; 
               DESCRI With cDescri,; 
               ENDERE With cEndere,; 
               BAIRRO With cBairro,; 
               CIDADE With cCidade,; 
               ESTADO With cEstado,; 
               CODCEP With cCodCep,; 
               CGCMF_ With cCGCMF_,; 
               RESPON With cRespon,; 
               DATA__ With dData__ 
    ENDIF 
    IF AT( "\0", Alltrim( GDir ) ) - 1 > 0 
       GDirRes:= Left( GDir, AT( "\0", Alltrim( GDir ) ) - 1 ) + "\0" + StrZero( nCODIGO, 3 ) 
    ELSE 
       GDirRes:= Alltrim( GDir ) + "\0" + StrZero( nCODIGO, 3 ) 
    ENDIF 
    !Md &GDirRes 
    DBSetOrder( nOrdem ) 
 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    ScreenRest( cTela ) 
    oTab:RefreshAll() 
    WHILE !oTab:Stabilize() 
    ENDDO 
    Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � AlteraEmp() 
� Finalidade  � Alteracao da Empresa No Sistema 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraEmp( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= CODIGO, cDESCRI:= DESCRI, cENDERE:= ENDERE,; 
      cBAIRRO:= BAIRRO, cCIDADE:= CIDADE, cESTADO:= ESTADO,; 
      cCODCEP:= CODCEP, cRESPON:= RESPON, cCGCMF_:= CGCMF_,; 
      dDATA__:= DATA__ 
Local nOrdem:= IndexOrd(), cPorta 
    SetCursor( 1 ) 
    VPBox( 07, 10, 18, 75, " Altera ", _COR_GET_BOX ) 
    SetColor( _COR_GET_EDICAO ) 
    @ 08,12 Say "Codigo........: [" + Str( nCodigo, 3, 0 ) + "]" 
    @ 09,12 Say "Nome/R. Social:" Get cDescri 
    @ 10,12 Say "CGC/MF........:" Get cCGCMF_ Pict "@R 99.999.999/9999-99" 
    @ 11,12 Say "Endereco......:" Get cEndere 
    @ 12,12 Say "Bairro........:" Get cBairro 
    @ 13,12 Say "Cidade........:" Get cCidade 
    @ 14,12 Say "Estado........:" Get cEstado 
    @ 15,12 Say "Cep...........:" Get cCodCep Pict "@R 99999-999" 
    @ 16,12 Say "Responsavel...:" Get cRespon 
    @ 17,12 Say "Data..........:" Get dData__ 
    READ 
    IF !LastKey()==K_ESC 
       IF netrlock() 
          Repl DESCRI With cDescri,; 
               ENDERE With cEndere,; 
               BAIRRO With cBairro,; 
               CIDADE With cCidade,; 
               ESTADO With cEstado,; 
               CODCEP With cCodCep,; 
               CGCMF_ With cCGCMF_,; 
               RESPON With cRespon,; 
               DATA__ With dData__ 
       ENDIF 
    ENDIF 
    DBSetOrder( nOrdem ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    ScreenRest( cTela ) 
    oTab:RefreshAll() 
    WHILE !oTab:Stabilize() 
    ENDDO 
    Return Nil 
 
Function ExpToledo() 
IF Confirma( 00, 00, "Deseja Importar os Produtos para TXINTENS.TXT ?", "Digite [S]im ou [N]ao.", "N" ) 
   MENSAGEM( "Aguarde, Exportando Produtos Para TXTITENS.TXT... ") 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   cPorta := Set(24) 
   Set( 24, M->GDir-"\TXITENS.TXT" ) 
   Set( 20,"PRINT" ) 
   dBgotop() 
   do while .not. eof() 
      if subst(INDICE,1,3) $ Swset( _GER_GRPPESADO ) 
         cString := strzero(val(subst(INDICE,3,1)),2) 
         cString += "03"+if(upper(UNIDAD) $ "UN-PC-  ","1","0") 
         cString += "00"+subst(INDICE,3,1)+subst(INDICE,5,3) 
         cString += strzero(iif(PRECOD<>0,PRECOD,PRECOV)*100,6,0)+"000"+left(DESCRI,20) 
         @ prow(),PCOL() say cString + Chr( 13 )+chr( 10 ) 
      endif 
      DBskip() 
   enddo 
   Set( 20,"SCREEN" ) 
   Set( 24, cPorta ) 
   Aviso( "Fim da Exportacao do Produtos", .t. ) 
   MENSAGEM( " " ) 
ENDIF 
retu .t. 
 
Function Digtoledo(cCodaver) 
local nDigit, nNum1, nNum2, cDezena 
nNum1 := (val(subst(cCodaver,1,1))+val(subst(cCodaver,3,1))+val(subst(cCodaver,5,1)))*3 
nNum2 := val(subst(cCodaver,2,1))+val(subst(cCodaver,4,1)) 
nNum1 := nNum1+nNum2 
cDezena := (nNum1+1) 
do while .t. 
   if right(str(cDezena,5),1) == "0" 
      exit 
   endif 
   cDezena ++ 
enddo 
nDigit := cDezena - nNum1 
if nDigit = 10 
   nDigit := 0 
endif 
retu str(nDigit,1) 


         
Function ExpWinLivros()
Local cTELA:=zoom( 00, 00, 24, 78  ), cCOR:=setcolor(), nOPCAO:=0

   @ 03, 45 Say "Notas Fiscais de Saida?"
   @ 04, 45 Say "De: [  /  /  ] at� [  /  /  ]"
           
   @ 06, 45 Say "Notas Fiscais de Entrada?"
   @ 07, 45 say "De: [  /  /  ] at� [  /  /  ]"

   @ 09, 45 say "Cupons Fiscais?"
   @ 10, 45 say "De: [  /  /  ] at� [  /  /  ]"

   @ 12, 45 say "Este modulo permite a transferen-"
   @ 13, 45 say "cia de arquivos do nosso  sistema"
   @ 14, 45 say "winLivros que e  o  aplicativo de"
   @ 15, 45 say "livros fiscais da DataCempro."

   @ 17, 45 say "Desenvolvido por Valmor P. Flores"
   @ 18, 45 say "em 05/04/2004.                "

INKEY(0)

unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 




