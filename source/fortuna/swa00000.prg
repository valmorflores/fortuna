// ## CL2HB.EXE - Converted
/* 
 
 
  ** ESTE APLICATIVO PODERA SER INSTALADO EM UMA PASTA DE UM CD-ROM 
     COMO \ATUALIZA\ OU NO WINCHESTER, DENTRO DE UMA PASTA OU SUBPASTA 
 
  ** COLOCAR SEMPRE UMA SUBPASTA FORTUNA CONTENDO UMA COPIA ATUALIZADA 
     DO SISTEMA. 
 
 
*/ 
 
*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ* 
* FORTUNA 
* SISTEMA DE ATUALIZACAO DE SISTEMAS 
* Programador - Valmor Pereira Flores 
*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ* 
 
#Include "ATUAL.CH" 
 
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH"


#ifdef HARBOUR
function swa00000()
#endif


memvar MENULIST 
Local nTipoAtualizacao:= 1 
Loca WTELA, nOPCAO:=0 
Priv cDirEmp 
priv XCONFIG:=.T. 
priv WPESQSN:=WSIMNAO:="",GDIR2SUB:= "DADOS", _VP2:=.t., WHELP:=.f. 
priv COR:={,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,},; 
     _EMP, _END, _END1, _END2, _CD, _COMSENHA, _COMDATA, _COMSOM, _MARGEM 
priv _COMSOMBRA, _COMZOOM, nMAXLIN:=24, nMAXCOL:=maxcol() 
priv _VIDEO_LIN:=25, _VIDEO_COL:=80 
priv cPODER, nGCODUSER:= 0, cUserGrupo:= "000", nCodUser:= 0 
Priv cUserCode:= "" 
Public cConfirmaSaida:= "SIM" 
 
Public lERRO:=.F. 
 
 
lGuardiao:= .F. 
 
 
REQUEST DBFNTX 
RDDSetDefault( "DBFNTX" ) 
 
 
/* Busca Informacoes no diretorio do Fortuna - Arquivos de configuracoes ----*/ 
DBSelectAr( 123 ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  use vpceicfg.dat alias res 
#else 
  Use C:\FORTUNA\VPCEICFG.DAT Alias RES 
#endif
GDir:= UnZipChr( GDIR__ ) 
DBCloseArea() 
 
SWSet( _DIR_AUTOEXEC, "C:" ) 
SWSet( _DIR_FORTUNA,  "C:\FORTUNA" ) 
SWSet( _DIR_DADOS,    Alltrim( GDir ) ) 
SWSet( _DIR_PDV,      "C:\FORTUNA\PDV" ) 
SWSet( _DIR_INSTALL,  "FORTUNA" ) 
SWSet( _DIR_CONFIG,   "C:\FORTUNA\REPORT" ) 
 
/* Cores --------------------------------------------------------------------*/ 
Cor[14]:= "07/07"          /* Cor de Sombra */ 
Cor[16]:= "15/01"          /* Cor de Box para menu's */ 
Cor[21]:= "15/01"          /* Cor de Browse */ 
Cor[22]:= "14/07" 
Cor[17]:= "07/01" 
/*---------------------------------------------------------------------------*/ 
 
SWSet( _SYS_CONFIGSENHAS, .F. ) 
MenBarraRolagem:= " ìí Soft&Ware Inform tica ìí °°°±±±²² àá (51)471.6249 9134.6249 9112.8364 àá ²²²°°°±±±°°°±±±²²²" 
 
 
/* Configura Diretorio de Report como sendo \FORTUNA\REPORT -----------------*/ 
SWSet( _SYS_DIRREPORT, "FORTUNA\REPORT" ) 
SWSet( _DIR_PRINCIPAL, "FORTUNA" ) 
 
SetCursor( 1 ) 
Set( _SET_SCOREBOARD, .F. ) 
Set( _SET_DATEFORMAT, "dd/mm/yy" ) 
Set( _SET_DELIMITERS, .T. ) 
Set( _SET_DELIMCHARS, "[]" ) 
Set( _SET_CONFIRM, .F. ) 
Set( _SET_DELETED, .T. ) 
Set( _SET_MESSAGE, _VIDEO_LIN - 2 ) 
Set( _SET_MCENTER, .T. ) 
Set( _SET_WRAP, .T. ) 
Set( _SET_INTENSITY, .T. ) 
 
SET EPOCH TO 1980 
 
ModoVga( .T. ) 
SWDispStatus( .F. ) 
 
SWSet( _SYS_DIRREPORT, "C:\FORTUNA\REPORT" ) 
Relatorio( "CONFIG.INI" ) 
 
aUnidades:= { "C:", "F:", "E:", "P:", "H:" } 
FOR nCt:= 1 TO Len( aUnidades ) 
     /* Procura CONFIGUR.SYS em varios locais */ 
     IF !File( SWSet( _SYS_DIRREPORT ) - "\CONFIGUR.SYS" ) 
        SWSet( _SYS_DIRREPORT, aUnidades[ nCt ] + "\FORTUNA\GENERIC" ) 
     ELSE 
        EXIT 
     ENDIF 
NEXT 
 
/* Executa CONFIGUR & CONFIG padrao, do servidor */ 
Relatorio( "CONFIGUR.SYS" ) 
 
SWDispStatus( .T. ) 
MontaArquivo( "SUPORTE.CTR" ) 
 
SetConfig() 
//Altd(1) 
System() 
SetBlink(.F.) 
 
/* Protecao() */ 
*Posicao* 12345678901234567890 * 
WSIMNAO:="—xyz•†Š…€‹‚ƒ„†’‡–—" 
 
SETBLINK(.F.) 
 
WHILE !Diretorio( ALLTRIM( GDir ) ) 
   nOpcao:= SWAlerta( "Impossivel acessar informacoes do sistema Fortuna"+; 
           ";Acesso negado ao diretorio " + Alltrim( GDir ) + "...",; 
            { " Finalizar o Programa ", " Alterar Temporariamente " } ) 
   IF nOpcao==1 
      Cls 
      Quit 
   ELSEIF nOpcao==2 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      VPBox( 05, 05, 20, 72, "Diretorio Temporario de Busca dos Dados", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      GDir:= PAD( GDir, 40 ) 
      @ 07,07 Say "Dados......: " Get GDir 
 
      @ 09,07 Say "EM REDE" 
      @ 10,07 Say "Verifique o mapeamento de rede." 
 
      @ 12,07 Say "EM COMPUTADORES INDIVIDUALIZADOS" 
      @ 13,07 Say "Lembre de configurar o diretorio no modulo " 
      @ 14,07 Say "UTILITARIOS > CONFIGURACAO > DIVERSOS > DIRETORIO" 
      @ 15,07 Say "p/que nao ocorra mais esta situacao de nao localizacao de dados." 
 
      @ 17,07 Say "Caso hajam duvidas com relacao a config. Contacte nosso servico " 
      @ 18,07 Say "de suporte tecnico!" 
 
      READ 
 
      nOpcao:= 1 
      GDir:= Alltrim( GDir ) 
      ScreenRest( cTelaRes ) 
   ENDIF 
ENDDO 
 
/* Restauracao do estado da tela / cofiguracao de cores */ 
Run Mode Co80 
Run Mode Co80 
Run Mode Co80 
CLS 
Scroll( 0, 0, 24, 79 ) 
Run MVIDEO RESTAURAMODO 
 
SetBlink(.F.) 
ScreenBack:= " ¯¯¯¯ Fortuna ®®®®ÄÄÄÄÄÄ¯¯¯¯ Disco de Atualizacao do Sistema ¯¯¯¯ " 
vptela() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserModulo( _SIS ) 
DevPos( 2,2 ) 
DevOut( " FORTUNA " ) 
WUSUARIO:=vpsenha() 
MENULIST:={} 
Guardiao( "<INICIO> Inicializacao do sistema ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" ) 
cPODER:=WPESQSN 
 
SWSet( _GER_EMPRESA, IF( AT( "\0", GDir ) > 0, VAL( SubStr( Gdir, AT( "\0", GDir )+2, 3 ) ), 999 ) ) 
 
SETBLINK(.F.) 
WHILE .t. 
   limpavar() 
   if XCONFIG 
      setcolor("00/00") 
      SetConfig() 
      vptela() 
      WTELA:=zoom(05,02,15,21) 
      vpbox(05,02,15,21) 
      titulo(_EMP) 
      Usuario( WUSUARIO ) 
      XCONFIG=.F. 
   endif 
   nLIN:=0 
   Mensagem("") 
 
   Ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
   SetColor( COR[12] + "," + COR[13] ) 
 
   SetOpcao( MenuList, 0 ) 
   Set( _SET_DELIMITERS, .T. ) 
 
 
   Scroll( 06, 03, 14, 20 ) 
   aadd( MENULIST, menunew( 06, 03," 1 Windows       ",2,COR[11],; 
        "",,,COR[6],.F.)) 
   aadd( MENULIST, menunew( 07, 03," 2 Linux         ",2,COR[11],; 
        "",,,COR[6],.F.)) 
   aadd( MENULIST, menunew( 08, 03," 3 Novell 4.10   ",2,COR[11],; 
        "",,,COR[6],.F.)) 
   aadd( MENULIST, menunew( 09, 03," 4 Personalizada ",2,COR[11],; 
        "",,,COR[6],.F.)) 
   @ 13,03 Say Repl( "Ä", 18 ) Color COR[6] 
   aadd( MENULIST, menunew(14,03," 0 Encerramento  ",2,COR[11],; 
        "Execucao da finalizacao do programa.",,,COR[6],.F.)) 
   menumodal(MENULIST,@nTipoAtualizacao ); MENULIST:={} 
 
   DO CASE 
      CASE nTipoAtualizacao==5 .OR. LastKey()==K_ESC .OR. ; 
           nTipoAtualizacao==0 
           EXIT 
 
      CASE nTipoAtualizacao==1 
           VerConfiguracao() 
           IF ! ( LastKey()==K_ESC ) 
              lAutomatica:= .T. 
              AtualExecuta( lAutomatica ) 
              EXIT 
           ENDIF 
 
      CASE nTipoAtualizacao==2 
           VerConfiguracao() 
           IF ! ( LastKey()==K_ESC ) 
              nUnidade:= SWAlerta( "Selecione a Unidade do Servidor" , { "F", "E", "P", "G", "H", "Cancela" } ) 
              IF nUnidade==1 
                 cUnidade:= "F" 
              ELSEIF nUnidade==2 
                 cUnidade:= "E" 
              ELSEIF nUnidade==3 
                 cUnidade:= "P" 
              ELSEIF nUnidade==4 
                 cUnidade:= "G" 
              ELSEIF nUnidade==5 
                 cUnidade:= "H" 
              ELSEIF nUnidade==6 
                 EXIT 
              ENDIF 
              SWSet( _DIR_FORTUNA,   cUnidade + ":\FORTUNA" ) 
              SWSet( _DIR_PDV,       "" ) 
              SWSet( _DIR_AUTOEXEC,  "" ) 
              SWSet( _SYS_DIRREPORT, cUnidade + ":\FORTUNA\GENERIC" ) 
              SWSet( _DIR_DADOS,     cUnidade + ":\FORTUNA\DADOS"   ) 
              SWSet( _DIR_CONFIG,    cUnidade + ":\FORTUNA\REPORT"  ) 
              lAutomatica:= .T. 
              AtualExecuta( lAutomatica, 1 ) 
              cDirFortuna:= "C:\FORTUNA" 
              IF File( "C:\FORTUNA\VPCEI.000" ) .OR. File( "C:\FORTUNA\VPCEI1U2.EXE" ) 
                 cDirInstalacao:= ALLTRIM( PAD( SWSet( _DIR_INSTALL ), 50 ) ) 
                 !COPY "&cDirInstalacao\*.UPD" "&cDirFortuna\." >Nul   
                 !COPY "&cDirInstalacao\REPORT\*.DEF" "&cDirFortuna\REPORT\." >Nul   
                 SWAlerta( "Execute o sistema primeiro neste terminal; para que seja atualizada a base de dados; do seu servidor LINUX.", { " OK " } ) 
              ELSE 
                 Aviso( "Impossivel localizar pasta C:\FORTUNA neste terminal." ) 
                 Pausa() 
              ENDIF 
              EXIT 
           ENDIF 
 
      CASE nTipoAtualizacao==4 
           Ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
           SetColor( COR[12] + "," + COR[13] ) 
 
           SetOpcao( MenuList, 0 ) 
           Set( _SET_DELIMITERS, .T. ) 
           aadd( MENULIST, menunew(06,03," 1 Configuracoes ",2,COR[11],; 
                "",,,COR[6],.F.)) 
           aadd( MENULIST, menunew(07,03," 2 Executar      ",2,COR[11],; 
                "",,,COR[6],.F.)) 
           @ 08,03 Say Repl( "Ä", 18 ) Color COR[6] 
           aadd( MENULIST, menunew(09,03," 3 CONFIG.SYS    ",2,COR[11],; 
                "",,,COR[6],.F.)) 
           aadd( MENULIST, menunew(10,03," 4 AUTOEXEC.BAT  ",2,COR[11],; 
                "",,,COR[6],.F.)) 
           aadd( MENULIST, menunew(11,03," 5 SWCEI.BAT     ",2,COR[11],; 
                "",,,COR[6],.F.)) 
           aadd( MENULIST, menunew(12,03," 6 PDV.INI       ",2,COR[11],; 
                "",,,COR[6],.F.)) 
           @ 13,03 Say Repl( "Ä", 18 ) Color COR[6] 
           aadd( MENULIST, menunew(14,03," 0 Encerramento  ",2,COR[11],; 
                "Execucao da finalizacao do programa.",,,COR[6],.F.)) 
           menumodal(MENULIST,@nOPCAO); MENULIST:={} 
           do case 
              case nOPCAO=7 .OR. ( LastKey() == K_ESC .AND. cConfirmaSaida == "SIM" ) 
                   EXIT 
              case nOPCAO=1; AtualConfigura() 
              case nOPCAO=2; AtualExecuta() 
              case nOPCAO=3 
                   IF( FILE( SWSet( _DIR_AUTOEXEC ) - "\AUTOEXEC.BAT" ), ViewFile( SWSet( _DIR_AUTOEXEC ) - "\AUTOEXEC.BAT" ), Nil ) 
              case nOPCAO=4 
                   IF( FILE( SWSet( _DIR_AUTOEXEC ) - "\CONFIG.SYS" ),   ViewFile( SWSet( _DIR_AUTOEXEC ) - "\CONFIG.SYS" ), Nil ) 
              case nOPCAO=5 
                   IF( FILE( SWSet( _DIR_FORTUNA ) + "\SWCEI.BAT" ),     ViewFile( SWSet( _DIR_FORTUNA ) + "\SWCEI.BAT" ), Nil ) 
              case nOPCAO=6 
                   IF( FILE( SWSet( _DIR_PDV ) + "\PDV.INI" ),           ViewFile( SWSet( _DIR_PDV ) + "\PDV.INI" ), Nil ) 
           endcase 
   ENDCASE 
 
ENDDO 
Guardiao( "<FIM> Finalizacao do sistema ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" ) 
fim() 
 
 
 
 
 
 
 
/************* FUNCOES **************/ 
 
FUNCTION AtualConfigura() 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor(), lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
 
   Local cDirFortuna:=    PAD( SWSet( _DIR_FORTUNA ), 50 ),; 
         cDirPDV:=        PAD( SWSet( _DIR_PDV ), 50 ),; 
         cDirAutoexec:=   PAD( SWSet( _DIR_AUTOEXEC ), 50 ),; 
         cDirRelatorios:= PAD( SWSet( _SYS_DIRREPORT ), 50 ),; 
         cDirDados:=      PAD( SWSet( _DIR_DADOS ), 50 ),; 
         cDirInstalacao:= PAD( SWSet( _DIR_INSTALL ), 50 ) 
         cDirConfig:=     PAD( SWSet( _DIR_CONFIG ), 50 ) 
 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 22, 79, "CONFIGURACAO DO SISTEMA DE ATUALIZACAO", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
 
   IF !Diretorio( cDirPdv ) 
      cDirPDV:= PAD( " ", 50 ) 
   ENDIF 
 
   @ 02,54 Say "Configuracao Servidor" 
   @ 03,54 Say PADL( "C: ", 25 )                  Color "00/03" 
   @ 06,54 Say PADL( "C:\FORTUNA ", 25 )          Color "00/03" 
   @ 09,54 Say PADL( "C:\FORTUNA\PDV ", 25 )      Color "00/03" 
   @ 12,54 Say PADL( "F:\FORTUNA\DADOS " , 25 )   Color "00/03" 
   @ 15,54 Say PADL( "F:\FORTUNA\GENERIC ", 25 )  Color "00/03" 
   @ 18,54 Say PADL( "C:\FORTUNA\REPORT ", 25 )   Color "00/03" 
   @ 21,54 Say PADL( "FORTUNA", 25 )              Color "00/03" 
 
   @ 02,02 Say "Diretorio dos Arquivos de Configuracoes do S.O." Color "14/" + CorFundoAtual() 
   @ 03,02 Get cDirAutoexec 
 
   @ 05,02 Say "Diretorio do Sistema Fortuna       " Color "14/" + CorFundoAtual() 
   @ 06,02 Get cDirFortuna 
 
   @ 08,02 Say "Diretorio do Sistema PDV           " Color "14/" + CorFundoAtual() 
   @ 09,02 Get cDirPDV 
 
   @ 11,02 Say "Diretorio de dados do Sistema      "  Color "14/" + CorFundoAtual() 
   @ 12,02 Get cDirDados 
 
   @ 14,02 Say "Diretorio do Servidor de Relatorios"  Color "14/" + CorFundoAtual() 
   @ 15,02 Get cDirRelatorios 
 
   @ 17,02 Say "Diretorio de Configuracoes Locais  "  Color "14/" + CorFundoAtual() 
   @ 18,02 Get cDirConfig 
 
   @ 20,02 Say "Diretorio com Copia Atual do Sistema"  Color "14/" + CorFundoAtual() 
   @ 21,02 Get cDirInstalacao 
 
   READ 
 
   SWSet( _DIR_FORTUNA,     ALLTRIM( cDirFortuna      ) ) 
   SWSet( _DIR_DADOS,       ALLTRIM( cDirDados        ) ) 
   SWSet( _DIR_PDV,         ALLTRIM( cDirPDV          ) ) 
   SWSet( _DIR_AUTOEXEC,    ALLTRIM( cDirAutoexec     ) ) 
   SWSet( _SYS_DIRREPORT,   ALLTRIM( cDirRelatorios   ) ) 
   SWSet( _DIR_INSTALL,     ALLTRIM( cDirInstalacao   ) ) 
   SWSet( _DIR_CONFIG,      ALLTRIM( cDirConfig       ) ) 
   GDir:= ALLTRIM( cDirDados ) 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
 
FUNCTION VerConfiguracao() 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor(), lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
 
   Local cDirFortuna:=    PAD( SWSet( _DIR_FORTUNA ), 50 ),; 
         cDirPDV:=        PAD( SWSet( _DIR_PDV ), 50 ),; 
         cDirAutoexec:=   PAD( SWSet( _DIR_AUTOEXEC ), 50 ),; 
         cDirRelatorios:= PAD( SWSet( _SYS_DIRREPORT ), 50 ),; 
         cDirDados:=      PAD( SWSet( _DIR_DADOS ), 50 ),; 
         cDirInstalacao:= PAD( SWSet( _DIR_INSTALL ), 50 ) 
         cDirConfig:=     PAD( SWSet( _DIR_CONFIG ), 50 ) 
 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 22, 79, "CONFIGURACAO DO SISTEMA DE ATUALIZACAO", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
 
   IF !Diretorio( cDirPdv ) 
      cDirPDV:= PAD( " ", 50 ) 
   ENDIF 
 
   @ 02,54 Say "Configuracao Servidor" 
   @ 03,54 Say PADL( "C: ", 25 )                  Color "00/03" 
   @ 06,54 Say PADL( "C:\FORTUNA ", 25 )          Color "00/03" 
   @ 09,54 Say PADL( "C:\FORTUNA\PDV ", 25 )      Color "00/03" 
   @ 12,54 Say PADL( "F:\FORTUNA\DADOS " , 25 )   Color "00/03" 
   @ 15,54 Say PADL( "F:\FORTUNA\GENERIC ", 25 )  Color "00/03" 
   @ 18,54 Say PADL( "C:\FORTUNA\REPORT ", 25 )   Color "00/03" 
   @ 21,54 Say PADL( "FORTUNA", 25 )              Color "00/03" 
 
   @ 02,02 Say "Diretorio dos Arquivos de Configuracoes do S.O." Color "14/" + CorFundoAtual() 
   @ 03,02 Say cDirAutoexec 
 
   @ 05,02 Say "Diretorio do Sistema Fortuna       " Color "14/" + CorFundoAtual() 
   @ 06,02 Say  cDirFortuna 
 
   @ 08,02 Say "Diretorio do Sistema PDV           " Color "14/" + CorFundoAtual() 
   @ 09,02 Say cDirPDV 
 
   @ 11,02 Say "Diretorio de dados do Sistema      "  Color "14/" + CorFundoAtual() 
   @ 12,02 Say cDirDados 
 
   @ 14,02 Say "Diretorio do Servidor de Relatorios"  Color "14/" + CorFundoAtual() 
   @ 15,02 Say cDirRelatorios 
 
   @ 17,02 Say "Diretorio de Configuracoes Locais  "  Color "14/" + CorFundoAtual() 
   @ 18,02 Say cDirConfig 
 
   @ 20,02 Say "Diretorio com Copia Atual do Sistema"  Color "14/" + CorFundoAtual() 
   @ 21,02 Say cDirInstalacao 
 
   Inkey(0) 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
 
 
 
Function AtualExecuta( lAutomatico, nTipoMaquina ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor(), lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
   Local aConfigSis, aConfigNovo 
   Local cVariavel, cConteudo 
   Priv cDir 
   Priv cDirDados:=      SWSet( _DIR_DADOS ) 
   Priv cDirFortuna:=    SWSet( _DIR_FORTUNA ) 
   Priv cDirPDV:=        SWSet( _DIR_PDV ) 
   Priv cDirAutoexec:=   SWSet( _DIR_AUTOEXEC ) 
   Priv cDirRelatorios:= SWSet( _SYS_DIRREPORT ) 
   Priv cDirInstalacao:= SWSet( _DIR_INSTALL ) 
   Priv cDirConfig:=     SWSet( _DIR_CONFIG ) 
 
   IF lAutomatico==Nil 
      lAutomatico:= .F. 
   ENDIF 
 
 
   IF !lAutomatico 
      IF SWAlerta( "<<< ATUALIZACAO DO SISTEMA >>>; Inicio da atualizacao do sistema FORTUNA", { "Confirma", "Cancela" } )==2 
         ScreenRest( cTela ) 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         Return Nil 
      ENDIF 
   ENDIF 
 
   IF !Diretorio( cDirFortuna ) 
      SWAlerta( "Diretorio " + cDirFortuna + " nao localizado!; Impossivel fazer atualizacao.", { "OK" } ) 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      Return Nil 
   ELSEIF !Diretorio( cDirConfig ) 
      SWAlerta( "Diretorio " + cDirConfig + " nao localizado!; Impossivel fazer atualizacao.", { "OK" } ) 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      Return Nil 
   ELSEIF !Diretorio( cDirRelatorios ) 
      SWAlerta( "Diretorio " + cDirRelatorios + " nao localizado!; Impossivel fazer atualizacao.", { "OK" } ) 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      Return Nil 
   ELSEIF !Diretorio( cDirDados ) 
      SWAlerta( "Diretorio " + cDirDados + " nao localizado!; Impossivel fazer atualizacao.", { "OK" } ) 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      Return Nil 
   ENDIF 
 
   IF nTipoMaquina==Nil 
      IF UPPER( LEFT( ALLTRIM( cDirRelatorios ), 1 ) ) <> "C" 
         Keyboard Chr( K_RIGHT ) 
         nTipoMaquina:= 2 
      ELSE 
         nTipoMaquina:= 1 
      ENDIF 
   ENDIF 
 
   IF !lAutomatico 
      nTipoMaquina:= SWAlerta( "Escolha o tipo de m quina que; est  sendo atualizada", { "Servidor / Mono Usuario", "Esta‡ao da Rede" } ) 
   ENDIF 
 
   IF nTipoMaquina == 1 
      IF SWAlerta( "<< BACKUP >>;Deseja fazer BACKUP neste computador?",; 
                  { " Fazer Backup ", " Nao Realizar Backup " } )==1 
         FOR nCt:= 0 TO 9 
             cDirBackup:= "C:\BCK" + StrZero( MONTH( DATE() ), 2, 0 ) + StrZero( DAY( DATE() ), 02, 00 ) + StrZero( nCt, 1, 0 ) 
             IF !Diretorio( cDirBackup ) 
                EXIT 
             ENDIF 
         NEXT 
         Aviso( "Backup ser  resguardado na pasta " + cDirBackup ) 
         Pausa() 
         ScreenRest( cTela ) 
         Aviso( "Realizando backup das informacoes, aguarde...." ) 
         !MD &cDirBackup >Nul 
         !XCOPY "&cDirFortuna\*.*" "&cDirBackup\." /s  >Nul   
      ENDIF 
 
      /* 
         Se existir o config.ini e o diretorio for FORTUNA\GENERIC deleta o 
         arquivo CONFIG.INI pois o mesmo nÆo ‚ necessario nesta pasta 
      */ 
      /* Deletar o config.ini do F:\FORTUNA\GENERIC */ 
      IF File( cDirRelatorios-"\CONFIG.INI" )  .AND.; 
         !( ALLTRIM( cDirRelatorios ) == ALLTRIM( cDirConfig ) ) 
         FErase( cDirRelatorios-"\CONFIG.INI" ) 
      ENDIF 
 
   ELSE 
      /* 
         Se existir o CONFIGUR.SYS no diretorio C:\FORTUNA\REPORT 
         e estiver atualizando uma estacao de trabalho, faz com que 
         o mesmo seja deletado. 
      */ 
      IF File( cDirConfig - "\CONFIGUR.SYS" ) .AND.; 
         ! ( ALLTRIM( cDirRelatorios ) == ALLTRIM( cDirConfig ) ) 
         FErase( cDirConfig-"\CONFIGUR.SYS" ) 
      ENDIF 
   ENDIF 
 
 
   /* Converte arquivos .VPB em .DBF */ 
   aArquivos:= DIRECTORY( cDirDados - "\*.VPB" ) 
   Aviso( "Convertendo de VPB/IGD para DBF/NTX/NDX, aguarde..." ) 
   IF Len( aArquivos ) > 0 
      FOR nCt:= 1 to Len( aArquivos ) 
          cArqOrigem:= cDirDados-"\" - aArquivos[ nCt ][ 1 ] 
          cArqDestino:= StrTran( cArqOrigem, ".VPB", ".DBF" ) 
          IF File( cArqOrigem ) 
             Mensagem( cArqOrigem ) 
             !COPY &cArqOrigem &cArqDestino >NUL 
             IF File( cArqDestino ) 
                FErase( cArqOrigem ) 
             ENDIF 
          ENDIF 
      NEXT 
   ENDIF 
 
 
   ScreenRest( cTela ) 
   Aviso( "Buscando arquivos para atualizacao...." ) 
 
 
   IF File( cDirRelatorios - "\CONFIGUR.SYS" ) 
      EliminaVariaveis( cDirRelatorios - "\CONFIGUR.SYS" ) 
      EliminaVariaveis( cDirConfig - "\CONFIG.INI" ) 
   ENDIF 
 
   AtualizaFile(     cDirConfig - "\CONFIG.INI",   cDirInstalacao - "\REPORT\CONFIG.INI", lAutomatico ) 
   AtualizaFile( cDirRelatorios - "\CONFIGUR.SYS", cDirInstalacao - "\REPORT\CONFIGUR.SYS", lAutomatico ) 
 
   /* Verificar se diretorio de configuracao ‚ diferente do diretorio de relatorios */ 
   /* Coloca CONFIG.INI & CONFIGUR.SYS nos moldes atuais */ 
   MEMOWRIT( cDirConfig-"\FILE.CTL", "" ) 
   IF !File( cDirRelatorios-"\FILE.CTL" ) 
      IF File( cDirConfig-"\CONFIGUR.SYS" ) 
         FErase( cDirConfig-"\CONFIGUR.SYS" ) 
      ENDIF 
      IF File( cDirRelatorios - "\CONFIG.INI" ) 
         FErase( cDirRelatorios-"\CONFIG.INI" ) 
      ENDIF 
      aFileConfig:= IOFillText( MEMOREAD( cDirConfig-"\CONFIG.INI" ) ) 
      Set( 24, cDirConfig-"\CONFIG.INI" ) 
      Set( 20, "PRINT" ) 
      FOR nCt:= 1 TO Len( aFileConfig ) 
          IF UPPER( ALLTRIM( aFileConfig[ nCt ] ) )=="$FIM" 
             @ PROW(),PCOL() Say "$SWSet( _SYS_DIRREPORT, ["+ALLTRIM( cDirRelatorios )+"] )" + CHR( 13 ) + CHR( 10 ) 
          ENDIF 
          @ PROW(),PCOL() Say aFileConfig[ nCt ] + CHR( 13 ) + CHR( 10 ) 
      NEXT 
      Set( 20, "SCREEN" ) 
      Set( 24, "LPT1" ) 
   ENDIF 
   FErase( cDirConfig-"\FILE.CTL" ) 
 
 
   IF File( cDirInstalacao-"\REPORT\SENHAS.000" ) 
      /* Grava senhas padrao em SENHAS.000 */ 
      !COPY "&cDirInstalacao\REPORT\SENHAS.000"  "&cDirRelatorios\." >Nul   
   ENDIF 
 
   AtualizaFile(    cDirFortuna - "\REPORT.INI",   cDirInstalacao - "\REPORT.INI", lAutomatico ) 
 
   ScreenRest( cTela ) 
   Aviso( "Transferindo informacoes do arquivo GRUPODBF...." ) 
 
 
   /* Dois locais REPORT & GENERIC */ 
   FOR nCt:= 1 TO 2 
      DBSelectAr( 124 ) 
 
      cArquivo:= IF( nCt==1, cDirConfig-"\GRUPODBF.DBF", cDirRelatorios-"\GRUPODBF.DBF" ) 
      IF File( cArquivo ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         USE &cArquivo Alias DESTINO 
 
         DBGoTop() 
 
         /* Substituindo dentro DBF/NTX do GRUPODBF.DBF */ 
         WHILE !Eof() 
            marq:= strtran(ARQUIVO,".VPB",".DBF") 
            repl ARQUIVO with marq 
            skip 
         ENDDO 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON GRUPO + ARQUIVO TO INDRES.TMP 
         DBGoTop() 
 
         DBSelectAr( 125 ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&cdirinstalacao/report/grupodbf.dbf" alias origem  
         #else 
           USE "&cDirInstalacao\REPORT\GRUPODBF.DBF" ALIAS ORIGEM  
         #endif
         DBGOTOP() 
 
         WHILE !ORIGEM->( EOF() ) 
             IF !( DESTINO->( DBSeek( ORIGEM->( GRUPO + ARQUIVO ) ) ) ) 
                DESTINO->( DBAppend() ) 
                Replace DESTINO->ARQUIVO  With ORIGEM->ARQUIVO,; 
                        DESTINO->AREA     With ORIGEM->AREA,; 
                        DESTINO->GRUPO    With ORIGEM->GRUPO,; 
                        DESTINO->MODO     With ORIGEM->MODO,; 
                        DESTINO->CRIAR    With ORIGEM->CRIAR,; 
                        DESTINO->GENERICO With ORIGEM->GENERICO 
             ENDIF 
             ORIGEM->( DBSkip() ) 
         ENDDO 
      ELSE 
 
         /* Copia da instalcao caso nÆo exista o arquivo GRUPODBF.DBF */ 
         !COPY "&cDirInstalacao\REPORT\GRUPODBF.DBF" &cArquivo > Nul  
 
      ENDIF 
 
   NEXT 
 
   ScreenRest( cTela ) 
   Aviso( "Transferindo o sistema...." ) 
 
   !COPY "&cDirInstalacao\VPCEI1U2.EXE" &cDirFortuna  >Nul  
   IF !File( cDirInstalacao-"\PDV\SWPDV.EXE" ) .AND. File( cDirPDV - "\SWPDV.EXE" ) 
      ScreenRest( cTela ) 
      Aviso( "Arquivo SWPDV.EXE nao localizado na instalacao." ) 
      Pausa() 
      ScreenRest( cTela ) 
   ELSE 
 
      /* Atualiza SWPDV.EXE e INFO.EXE */ 
 
      IF Diretorio( cDirPDV ) 
 
         ScreenRest( cTela ) 
         Aviso( "Transferindo arquivos do PDV..." ) 
 
         /* Arquivo SWPDV.EXE */ 
         !COPY "&cDirInstalacao\PDV\SWPDV.EXE" "&cDirPDV\." >Nul   
 
         IF File( cDirInstalacao-"\PDV\INFO.EXE" ) 
 
            /* Arquivo INFO.EXE */ 
            !COPY "&cDirInstalacao\PDV\INFO.EXE" "&cDirPDV\." >Nul   
 
            /* Arquivo INFO32.EXE */ 
            !COPY "&cDirInstalacao\PDV\INFO.EXE" "&cDirPDV\." >Nul   
 
            IF File( cDirInstalacao - "\PDV\INFOFN.PCX" ) 
               !COPY "&cDirInstalacao\PDV\*.PCX" "&cDirPDV\." >Nul   
            ENDIF 
 
            !COPY "&cDirInstalacao\PDV\*.DLL" "&cDirPDV\." >Nul   
 
            !COPY "&cDirInstalacao\PDV\*.PTX" "&cDirPDV\." >Nul   
 
            IF !Diretorio( cDirPDV - "\IMAGEM" ) 
 
               ScreenRest( cTela ) 
               Aviso( "Montando protecao de tela com arquivos do Windows..." ) 
 
               !MD "&cDirPdv\IMAGEM" >Nul  
               IF File( "C:\WINDOWS\NUVENS.BMP" ) 
                  !COPY C:\WINDOWS\*.BMP "&cDirPdv\IMAGEM\." >Nul  
               ENDIF 
 
            ENDIF 
 
         ENDIF 
 
      ENDIF 
 
   ENDIF 
 
   IF File( cDirFortuna-"\VPCEI.000" ) 
      FErase( cDirFortuna-"\VPCEI.000" ) 
   ENDIF 
 
   IF !File( cDirDados-"\CORES.DBF" ) 
      !Copy "&cDirInstalacao\DADOS\CORES.DBF" "&cDirDados\." >Nul   
   ENDIF 
 
   IF !File( cDirConfig-"\VERSAO.INI" ) 
      !Copy "&cDirInstalacao\REPORT\VERSAO.INI" "&cDirConfig\." >Nul   
   ENDIF 
 
   ScreenRest( cTela ) 
   Aviso( "Transferindo arquivos UPD...." ) 
 
   !COPY "&cDirInstalacao\*.UPD" "&cDirFortuna\." >Nul   
 
   ScreenRest( cTela ) 
 
 
   ////// ATUALIZACAO DE ARQUIVOS REPORT 
   Aviso( "Transferindo arquivos REPORT novos...." ) 
 
   aRep:= DIRECTORY( cDirInstalacao - "\REPORT\*.REP" ) 
   aReport:= {} 
   FOR nCt:= 1 TO Len( aRep ) 
       AAdd( aReport, { aRep[ nCt ][ 1 ], IF( !File( cDirRelatorios - "\" - aRep[ nCt ][ 1 ] ), "Sim", "Nao" ) } ) 
   NEXT 
 
   lAtReport:= .T. 
   IF !lAutomatico 
      IF !( lAtReport:= EditaListaReport( @aReport ) ) 
         IF !lAutomatico 
            Aviso( "Voce optou por nao atualizar REPORT por este terminal." ) 
            Pausa() 
         ENDIF 
      ENDIF 
   ENDIF 
 
   IF lAtReport .AND. LEN( aReport ) > 0 
      FOR nCt:= 1 TO LEN( aReport ) 
          cArquivo:= aReport[ nCt ][ 1 ] 
          IF aReport[ nCt ][ 2 ]=="Sim" 
             cArqOrigem:= cDirInstalacao - "\REPORT\" - cArquivo 
             !COPY &cArqOrigem "&cDirRelatorios\." >Nul  
          ENDIF 
      NEXT 
   ENDIF 
 
   ScreenRest( cTela ) 
   Aviso( "Transferindo arquivos de definicoes..." ) 
   !COPY "&cDirInstalacao\REPORT\*.DEF" "&cDirRelatorios\." >Nul   
   !COPY "&cDirInstalacao\REPORT\*.DEF" "&cDirConfig\." >Nul   
 
   // DEFINICOES DE OPCOES - SERVIDOR OU ESTACAO DE TRABALHO // 
   IF ( nTipoMaquina )==2 
 
      Aviso( "Ajustando configuracoes para terminal CLIENT...." ) 
      /* Exclui arquivos .REP do diretorio REPORT */ 
      aConfig:= DIRECTORY( cDirConfig - "\*.REP" ) 
      FOR nCt:= 1 TO LEN( aConfig ) 
          FErase( cDirConfig - "\" - aConfig[ nCt ][ 1 ] ) 
      NEXT 
 
      /* Exclui arquivos *.UPD, desnecessarios a computadores que nÆo sÆo 
         responsaveis por atualizacoes do sistema */ 
      aUPD:= DIRECTORY( cDirFortuna - "\*.UPD" ) 
      FOR nCt:= 1 TO LEN( aUPD ) 
          FErase( cDirFortuna - "\" - aUPD[ nCt ][ 1 ] ) 
      NEXT 
 
   ELSE 
 
      ScreenRest( cTela ) 
      Aviso( "Eliminando arquivo de Indices desatualizados...." ) 
 
      aIGD:= DIRECTORY( cDirDados - "\*.NTX" ) 
      FOR nCt:= 1 TO LEN( aIGD ) 
          FErase( cDirDados - "\" - aIGD[ nCt ][ 1 ] ) 
      NEXT 
 
      aIGD:= DIRECTORY( cDirDados - "\*.IGD" ) 
      FOR nCt:= 1 TO LEN( aIGD ) 
          FErase( cDirDados - "\" - aIGD[ nCt ][ 1 ] ) 
      NEXT 
 
      aIGD:= DIRECTORY( cDirDados - "\*.NDX" ) 
      FOR nCt:= 1 TO LEN( aIGD ) 
          FErase( cDirDados - "\" - aIGD[ nCt ][ 1 ] ) 
      NEXT 
 
      aIGD:= DIRECTORY( cDirDados - "\$IND*.*" ) 
      FOR nCt:= 1 TO LEN( aIGD ) 
          FErase( cDirDados - "\" - aIGD[ nCt ][ 1 ] ) 
      NEXT 
 
   ENDIF 
 
   ScreenRest( cTela ) 
   Aviso( "Eliminando arquivos temporarios, aguarde...." ) 
 
   aNTX:= DIRECTORY( cDirFortuna - "\*.NTX" ) 
   FOR nCt:= 1 TO LEN( aNTX ) 
       FErase( cDirFortuna - "\" - aNTX[ nCt ][ 1 ] ) 
   NEXT 
 
   aIND:= DIRECTORY( cDirFortuna - "\$SIN*.*" ) 
   FOR nCt:= 1 TO LEN( aIND ) 
       FErase( cDirFortuna - "\" - aIND[ nCt ][ 1 ] ) 
   NEXT 
 
   ScreenRest( cTela ) 
   Aviso( "Rotina de atualizacao realizada com sucesso." ) 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
Static Function AtualizaFile( cArquivo, cArqAtual, lAutomatico ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local lRetorno:= .F. 
 
   /* Edicao do Arquivo CONFIG.INI */ 
   IF !File( cArquivo ) .OR.; 
      !File( cArqAtual ) 
 
      SWAlerta( "<< ARQUIVO NAO LOCALIZADO >>;" + cArquivo + " ou; " + cArqAtual + " nao encontrado.", { "OK" } ) 
 
      ScreenRest( cTela ) 
      Return Nil 
 
   ELSE 
      aTmpCfgSis:=  FileToArray( FileLe( cArquivo ) ) 
      aTmpCfgNovo:= FileToArray( FileLe( cArqAtual ) ) 
 
      aConfigSis:= {} 
      aConfigNovo:= {} 
 
      Leitura( @aConfigSis,  aTmpCfgSis ) 
      Leitura( @aConfigNovo, aTmpCfgNovo ) 
 
      /* Verifica Configuracoes ja realizadas */ 
      FOR nCt:= 1 TO Len( aConfigNovo ) 
          IF ASCAN( aConfigSis, {|x| ALLTRIM( UPPER( x[ 1 ] ) )==ALLTRIM( UPPER( aConfigNovo[ nCt ][ 1 ] ) ) } ) > 0 
             aConfigNovo[ nCt ][ 2 ]:= Repl( "°", 60 ) 
          ENDIF 
      NEXT 
 
      IF Len( aConfigNovo ) <= 0 
         AAdd( aConfigNovo, { "100% Desnecessario Conversoes...........", Space( 40 ), "%%%" } ) 
      ENDIF 
 
      IF iif( lAutomatico, .T., DisplayEdicao( aConfigNovo, aConfigSis, cArquivo ) ) 
         /* Grava alteracoes no arquivo */ 
         GravaInformacoes( cArquivo, aConfigSis, aConfigNovo ) 
         lRetorno:= .T. 
      ENDIF 
 
   ENDIF 
 
   Return lRetorno 
 
 
 
 
Static Function GravaInformacoes( cArquivo, aConfigSis, aConfigNovo ) 
   Local nCt 
   Local aArqFormatado:= {} 
   Local cStringNova, cStringVelha 
 
   FOR nCt:= 1 TO Len( aConfigNovo ) 
 
       /* Formata a String Padrao */ 
       cStringVelha:= " " 
       IF nCt <= Len( aConfigSis ) 
          IF aConfigSis[ nCt ][ 3 ]==">>>" 
             cStringVelha:= aConfigSis[ nCt ][ 1 ] 
          ELSEIF aConfigSis[ nCt ][ 3 ]=="Pad" 
             cStringVelha:= aConfigSis[ nCt ][ 1 ] + ":= " + aConfigSis[ nCt ][ 2 ] 
          ELSEIF aConfigSis[ nCt ][ 3 ]=="Set" 
             cStringVelha:= "$SWSet( " + aConfigSis[ nCt ][ 1 ] + ", " + aConfigSis[ nCt ][ 2 ] + " )" 
          ENDIF 
 
          /* Caso exista na mesma posicao uma configuracao no novo que nao seja "°°°" 
             faz a gravacao da mesma no arquivo de configuracoes */ 
          IF LEN( aConfigNovo[ nCt ] ) >= 3 
             IF !( aConfigNovo[ nCt ][ 2 ]==Repl( "°", 60 ) ) 
                cStringNova:= "" 
                IF aConfigNovo[ nCt ][ 3 ]==">>>" 
                   cStringNova:= aConfigNovo[ nCt ][ 1 ] 
                ELSEIF aConfigNovo[ nCt ][ 3 ]=="Pad" 
                   cStringNova:= aConfigNovo[ nCt ][ 1 ] + ":= " + aConfigSis[ nCt ][ 2 ] 
                ELSEIF aConfigNovo[ nCt ][ 3 ]=="Set" 
                   cStringNova:= "$SWSet( " + aConfigNovo[ nCt ][ 1 ] + ", " + aConfigNovo[ nCt ][ 2 ] + " )" 
                ENDIF 
                AAdd( aArqFormatado, cStringNova ) 
             ENDIF 
          ENDIF 
 
       ENDIF 
 
       /* Adiciona a String Padrao */ 
       AAdd( aArqFormatado, cStringVelha ) 
 
   NEXT 
 
   /* Imprime arquivo */ 
   Set( 24, cArquivo ) 
   Set( 20, "PRINT" ) 
   FOR nCt:= 1 TO Len( aArqFormatado ) 
       IF !UPPER( Left( ALLTRIM( aArqFormatado[ nCt ] ), 4 ) ) =="$FIM" .AND.; 
          !EMPTY( aArqFormatado[ nCt ] ) 
          @ PROW(),PCOL() Say aArqFormatado[ nCt ] + CHR( 13 ) + CHR( 10 ) 
       ENDIF 
   NEXT 
   /* Grava finalizacao do arquivo */ 
   @ PROW(),PCOL() Say "$FIM" + Chr( 13 ) + Chr( 10 ) 
 
   Set( 20, "SCREEN" ) 
   Set( 24, "LPT1" ) 
 
   Return Nil 
 
 
Static Function EditaListaReport( aReportList ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor(), lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
   Local nTela:= 1 
   Local oTb, nTecla 
   Local nRow:= 1 
 
   IF Len( aReportList ) <= 0 
      Aviso( "Lista de Relatorios Indisponivel" ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return .F. 
   ENDIF 
 
   /* Ordenar a Lista de Arquivos .REP */ 
   aReportList:= ASort( aReportList,,, {|x,y| x[1] < y[1] } ) 
 
   SetColor( "15/00,15/01" ) 
   VPBox( 05, 05, 19, 75, "REPORT LIST", "15/00" ) 
   Mensagem( "[G]Grava Arquivos [ENTER/ESPACO]Sim/Nao." ) 
 
   /* BROWSE PADRAO DO FORTUNA */ 
   oTb:= TBrowseNew( 06, 06, 18, 74 ) 
   oTb:addcolumn(tbcolumnnew("Arquivo",{|| PAD( aReportList[ nRow ][ 1 ], 60 ) })) 
   oTb:addcolumn(tbcolumnnew("S/N",    {|| PAD( aReportList[ nRow ][ 2 ], 03 ) })) 
   oTb:AUTOLITE:= .F. 
   oTb:GOTOPBLOCK:= {|| nRow:=1 } 
   oTb:GOBOTTOMBLOCK:= {|| nRow:= len( aReportList ) } 
   oTb:SKIPBLOCK:={|WTOJUMP| SkipperArr( WTOJUMP, aReportList, @nRow ) } 
   oTb:dehilite() 
 
   WHILE .T. 
 
       oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, 2 },{ 2, 1 } ) 
       WHILE nextkey()==0 .and. !oTb:stabilize() 
       ENDDO 
 
       nTecla:= Inkey(0) 
       IF nTecla==K_ESC .OR. Chr( nTecla ) $ "Gg" 
          nOpcao:= 0 
          IF ( nOpcao:= SWAlerta( "<< GRAVACAO DE INFORMACOES >>; Atualizar REPORTs selecionados?", { "Gravar", "Nao Atualizar", "Continuar Selecao" } ) )==1 
             ScreenRest( cTela ) 
             SetColor( cCor ) 
             Return .T. 
          ELSEIF nOpcao==2 
             ScreenRest( cTela ) 
             SetColor( cCor ) 
             Return .F. 
          ENDIF 
       ELSE 
          DO CASE 
             CASE nTecla==K_UP         ;oTb:up() 
             CASE nTecla==K_DOWN       ;oTb:down() 
             CASE nTecla==K_LEFT       ;oTb:up() 
             CASE nTecla==K_RIGHT      ;oTb:down() 
             CASE nTecla==K_PGUP       ;oTb:pageup() 
             CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
             CASE nTecla==K_PGDN       ;oTb:pagedown() 
             CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
             CASE nTecla==K_F12        ;Calculador() 
             CASE nTecla==K_ENTER .OR.; 
                  nTecla==K_SPACE 
                  IF aReportList[ nRow ][ 2 ]=="Sim" 
                     aReportList[ nRow ][ 2 ]:= "Nao" 
                  ELSE 
                     aReportList[ nRow ][ 2 ]:= "Sim" 
                  ENDIF 
             OTHERWISE                ;tone(125); tone(300) 
          ENDCASE 
          oTb:refreshcurrent() 
          oTb:stabilize() 
       ENDIF 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return .F. 
 
 
 
Static Function DisplayEdicao( aArquivo, aArquivoNovo, cArquivo ) 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor(), lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
   Local nTela:= 1 
   Local oTb1, oTb2, nTecla 
   Local nRow1:= 1, nRow2:= 1 
 
   SetColor( _COR_BROWSE ) 
   VPBox( 00, 00, 10, 79, "CONFIGURACOES ADICIONAIS - " + cArquivo, _COR_BROWSE ) 
   VPBox( 11, 00, 22, 79, "CONFIGURACAO DA EMPRESA", "15/04" ) 
 
   Mensagem( "[TAB]Janelas [G]Grava modificacoes [ENTER]Altera Parametros." ) 
 
   /* BROWSE PADRAO DO FORTUNA */ 
   oTb1:= TBrowseNew( 01, 01, 09, 78 ) 
   oTb1:addcolumn(tbcolumnnew(,{|| PAD( aArquivo[ nRow1 ][ 3 ], 3 ) })) 
   oTb1:addcolumn(tbcolumnnew("Variavel",{|| PAD( aArquivo[ nRow1 ][ 1 ], 36 ) })) 
   oTb1:addcolumn(tbcolumnnew("Conteudo",{|| PAD( aArquivo[ nRow1 ][ 2 ], 36 ) })) 
   oTb1:AUTOLITE:= .F. 
   oTb1:GOTOPBLOCK:= {|| nRow1:=1 } 
   oTb1:GOBOTTOMBLOCK:= {|| nRow1:= len( aArquivo ) } 
   oTb1:SKIPBLOCK:={|WTOJUMP| SkipperArr( WTOJUMP, aArquivo, @nRow1 ) } 
   oTb1:dehilite() 
 
   /* BROWSE PADRAO DA EMPRESA USUARIA DO SISTEMA */ 
   SetColor( "15/04" ) 
   oTb2:= TBrowseNew( 12, 01, 21, 78 ) 
   oTb2:addcolumn(tbcolumnnew(,{|| PAD( aArquivoNovo[ nRow2 ][ 3 ], 3 ) })) 
   oTb2:addcolumn(tbcolumnnew("Variavel",{|| PAD( aArquivoNovo[ nRow2 ][ 1 ], 36 ) })) 
   oTb2:addcolumn(tbcolumnnew("Conteudo",{|| PAD( aArquivoNovo[ nRow2 ][ 2 ], 36 ) })) 
   oTb2:AUTOLITE:= .F. 
   oTb2:GOTOPBLOCK:= {|| nRow2:=1 } 
   oTb2:GOBOTTOMBLOCK:= {|| nRow2:= len( aArquivoNovo ) } 
   oTb2:SKIPBLOCK:={|WTOJUMP| SkipperArr( WTOJUMP, aArquivoNovo, @nRow2 ) } 
   oTb2:dehilite() 
 
   WHILE .T. 
 
       SetColor( _COR_BROWSE ) 
       oTb1:colorrect( { oTb1:ROWPOS, 1, oTb1:ROWPOS, 3 },{ 2, 1 } ) 
       WHILE nextkey()==0 .and. !oTb1:stabilize() 
       ENDDO 
 
       SetColor( "15/04" ) 
       oTb2:colorrect( { oTb2:ROWPOS, 1, oTb2:ROWPOS, 3 },{ 2, 1 } ) 
       WHILE nextkey()==0 .and. !oTb2:stabilize() 
       ENDDO 
 
       IF nTela==1 
          SetColor( _COR_BROWSE ) 
       ELSE 
          SetColor( "15/04" ) 
       ENDIF 
 
       nTecla:= Inkey(0) 
       IF nTecla==K_ESC 
          nOpcao:= 0 
          exit 
       ELSEIF nTecla==K_TAB 
          nTela:= IF( nTela==2, 1, 2 ) 
       ELSEIF Chr( nTecla ) $ "Gg" 
          IF SWAlerta( "<< FINALIZACAO DE OPERACAO >>; Gravar as informacoes no arquivo da empresa?", { "Gravar Alteracoes", "Continuar Edicao" } )==1 
             ScreenRest( cTela ) 
             SetColor( cCor ) 
             Return .T. 
          ENDIF 
       ELSE 
          IF nTela==1 
             DO CASE 
                CASE nTecla==K_UP         ;oTb1:up() 
                CASE nTecla==K_DOWN       ;oTb1:down() 
                CASE nTecla==K_LEFT       ;oTb1:up() 
                CASE nTecla==K_RIGHT      ;oTb1:down() 
                CASE nTecla==K_PGUP       ;oTb1:pageup() 
                CASE nTecla==K_CTRL_PGUP  ;oTb1:gotop() 
                CASE nTecla==K_PGDN       ;oTb1:pagedown() 
                CASE nTecla==K_CTRL_PGDN  ;oTb1:gobottom() 
                CASE nTecla==K_F12        ;Calculador() 
                CASE nTecla==K_ENTER 
                     EditaParametro( aArquivo, nRow1, oTb1 ) 
                OTHERWISE                ;tone(125); tone(300) 
             ENDCASE 
             oTb1:refreshcurrent() 
             oTb1:stabilize() 
 
          ELSE 
             DO CASE 
                CASE nTecla==K_UP         ;oTb2:up() 
                CASE nTecla==K_DOWN       ;oTb2:down() 
                CASE nTecla==K_LEFT       ;oTb2:up() 
                CASE nTecla==K_RIGHT      ;oTb2:down() 
                CASE nTecla==K_PGUP       ;oTb2:pageup() 
                CASE nTecla==K_CTRL_PGUP  ;oTb2:gotop() 
                CASE nTecla==K_PGDN       ;oTb2:pagedown() 
                CASE nTecla==K_CTRL_PGDN  ;oTb2:gobottom() 
                CASE nTecla==K_F12        ;Calculador() 
                CASE nTecla==K_ENTER 
                     EditaParametro( aArquivoNovo, nRow2, oTb2 ) 
                OTHERWISE                ;tone(125); tone(300) 
             ENDCASE 
             oTb2:refreshcurrent() 
             oTb2:stabilize() 
          ENDIF 
       ENDIF 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return .F. 
 
Function EditaParametro( aArray, nRow, oTb ) 
  Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
        nCursor:= SetCursor() 
  Local cTipo:= PAD( aArray[ nRow ][ 3 ], 3 ),; 
        cParametro:= PAD( aArray[ nRow ][ 1 ], 120 ),; 
        cConteudo:=  PAD( aArray[ nRow ][ 2 ], 120 ) 
 
  VPBox( 06, 10, 17, 70, "EDICAO DE PARAMETRO", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
 
  IF aArray[ nRow ][ 2 ]==Repl( "°", 60 ) 
     Aviso( "Este parametro nÆo deve ser alterado nesta janela." ) 
     Pausa() 
     ScreenRest( cTela ) 
     SetColor( cCor ) 
     Return Nil 
  ENDIF 
 
  @ 08,12 Say "Tipo" 
  @ 09,12 Get cTipo Pict "!XX" Valid cTipo$"Set-Pad->>>" 
  @ 11,12 Say "Parametro" 
  @ 12,12 Get cParametro Pict "@S55" 
  @ 14,12 Say "Conteudo" 
  @ 15,12 Get cConteudo Pict "@S55" 
  READ 
 
  IF !LastKey()==K_ESC 
     aArray[ nRow ][ 1 ]:= Alltrim( cParametro ) 
     aArray[ nRow ][ 2 ]:= Alltrim( cConteudo ) 
     aArray[ nRow ][ 3 ]:= cTipo 
  ENDIF 
 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  oTb:RefreshAll() 
  WHILE !oTb:Stabilize() 
  ENDDO 
  Return Nil 
 
 
 
 
 
 
Function Leitura( aArquivo, aTmpCfgSis ) 
   Local cVariavel, cConteudo 
 
   FOR nCt:=1 TO Len( aTmpCfgSis ) 
       cVariavel:= Space( 30 ) 
       cConteudo:= Space( 30 ) 
       cTipo:= "   " 
 
       IF ( nPos:= AT( ":=", aTmpCfgSis[ nCt ] ) ) > 0 
 
          cVariavel:= SubStr( aTmpCfgSis[ nCt ], 1, nPos - 1 ) 
          cConteudo:= SubStr( aTmpCfgSis[ nCt ], nPos + 2 ) 
          cTipo:= "Pad" 
 
       ELSEIF UPPER( LEFT( alltrim( aTmpCfgSis[ nCt ] ), 6 ) )=="SWSET(" .OR.; 
              UPPER( LEFT( alltrim( aTmpCfgSis[ nCt ] ), 7 ) )=="$SWSET(" 
 
          IF UPPER( LEFT( alltrim( aTmpCfgSis[ nCt ] ), 7 ) )=="$SWSET(" 
             aTmpCfgSis[ nCt ]:=  StrTran( aTmpCfgSis[ nCt ], "$SWSet(", "SWSet(" ) 
          ENDIF 
 
          cX:= ALLTRIM( aTmpCfgSis[ nCt ] ) 
          cVariavel:= SubStr( cX, 1, AT( ",", cX ) - 1 ) 
          cVariavel:= StrTran( cVariavel, "SWSet(", "" ) 
          cConteudo:= SubStr( cX, AT( ",", cX ) + 1 ) 
          cConteudo:= LEFT( ALLTRIM( cConteudo ), LEN( ALLTRIM( cConteudo ) ) - 1 ) 
          cTipo:= "Set" 
 
       ELSE 
 
          cVariavel:= aTmpCfgSis[ nCt ] 
          cConteudo:= Space( 1 ) 
          cTipo:= ">>>" 
 
       ENDIF 
 
       IF !EMPTY( cVariavel + cConteudo ) 
          AAdd( aArquivo, { ALLTRIM( cVariavel ), ALLTRIM( cConteudo ), cTipo } ) 
       ENDIF 
 
   NEXT 
   Return .T. 
 
 
 
 
/* 
 Funcao        - EliminaVariaveis 
 Finalidade    - Tirar a linha que contenha uma varivel desnecessarias nos 
                 Arquivos CONFIGUR.SYS ou CONFIG.INI 
 Data          - Julho/2001 
 Programador   - Valmor P. Flores 
*/ 
Function EliminaVariaveis( cArquivo ) 
Local aFile:= {}, aVariaveis:= {} 
Local nCt, nVariavel:= 1 
 
   IF AT( "CONFIGUR.SYS", cArquivo ) > 0 
      aVariaveis:= { "SCREENBACK",; 
                     "$SWSET( _SYS_DIRREPORT" } 
   ELSEIF AT( "CONFIG.INI", cArquivo ) > 0 
      aVariaveis:= { "$SWSET( _SYS_DIRREPORT" } 
   ENDIF 
   FOR nVariavel:= 1 TO LEN( aVariaveis ) 
       aFile:= IOFillText( MEMOREAD( cArquivo ) ) 
       Set( 24, cArquivo ) 
       Set( 20, "PRINT" ) 
       FOR nCt:= 1 TO Len( aFile ) 
           IF AT( aVariaveis[ nVariavel ], UPPER( aFile[ nCt ] ) ) <= 0 
              @ PROW(),PCOL() SAY aFile[ nCt ] + CHR( 13 ) + CHR( 10 ) 
           ENDIF 
       NEXT 
       Set( 20, "SCREEN" ) 
       Set( 24, "LPT1" ) 
   NEXT 
   Return .T. 
 
