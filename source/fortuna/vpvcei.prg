/*

  EVOLUTIVA SISTEMAS DE GESTAO EMPRESARIAL

  VPVCEI
  Fortuna - Sistema de Automacao Comercial

  Versao visual for Windows ( xHarbour + MiniGui + hwGui ) compat¡vel

  Valmor Pereira Flores
  Setembro de 2003

  ---------------------------------------------------------------------
  Modulo Principal do Sistema           = vpcei.prg
  Ultima atualizacao deste modulo       = Setembro/2003
  Responsavel                           = Valmor P. Flores
  ---------------------------------------------------------------------
  Todos os direitos reservados a Fortuna Automacao Comercial

*/

#include "vpf.ch" 
#include "inkey.ch" 
#include "minigui.ch"


#ifdef HARBOUR
   function main()
#endif

Para cCodigo, Debug 

Local cScreenRes 
Local nCodEmpresa 
Loca WTELA, nOPCAO:=0 

// Compatibilidade com versoes de fontes mais antigos
Private WUSUARIO:="Usu rio"
Private cUserCode:= ""
Public _FORTUNA_:= "_VERSAO_"+_VER

Private GDir:= "<Indefinido>"
 
// Show de variaveis globais
Priv Driver:= ""
Priv cDirEmp 
priv XCONFIG:=.T. 
priv WPESQSN:=WSIMNAO:="", GDIR2SUB:= "DADOS", _VP2:=.t., WHELP:=.f. 
priv COR:={"15/01","15/01","15/01","15/01","15/01","15/01","15/01",; 
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",; 
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",; 
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",; 
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",; 
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01"} 
 
Priv _EMP, _END, _END1, _END2, _CD, _COMSENHA, _COMDATA, _COMSOM, _MARGEM 
priv _COMSOMBRA, _COMZOOM, nMAXLIN:=24, nMAXCOL:=79 
priv _VIDEO_LIN:=25, _VIDEO_COL:=80 
priv cPODER, nGCODUSER:= 0, cUserGrupo:= "000", nCodUser:= 0 
priv AbreArquivosInicio:= .T. 
priv ForPagPagamento:= "A" 
 
Public lERRO:=.F. 


    /// TELA PRINCIPAL

    DEFINE WINDOW MainForm ;
        AT 0,0 ;
        WIDTH 640 ;
        HEIGHT 480 ;
        TITLE _VER + " - " + _SIS ;
        MAIN 

    END WINDOW

    ACTIVATE WINDOW MainForm







#ifdef _CONSIDERAR_COMENTARIO_A_PARTIR_DAQUI

cUserCode:= cCodigo 

IF cCodigo <> Nil 
   IF Upper( cCodigo )=="DEMO" 
      _FORTUNA_:= "Fortuna-Demonstracao" 
   ENDIF 
ENDIF 

SetCancel( .T. )

set key K_F1         to SelecaoDevice() 
set key K_F6         to ConversorMoedas() 
set key K_F7         to TabelaCondicoes() 
set key K_F8         to TabelaPreco() 
set key K_F9         to Busca99() 
set key K_F10        to InsertMensagem() 
set key K_F11        to Atalho() 
set key K_F12        to Calculador() 
set key K_CTRL_F10   to Calendar() 
set key K_CTRL_F12   to Mail() 
set key K_CTRL_ENTER to ExecuteExternal() 
set key K_CTRL_F11   to vpc14100() 
set key K_CTRL_F2    to AreasUsadas() 
 
SETBLINK( .F. )

// FreeCPU
// Compatibilidade Clipper x Windows
// 10 de Setembro de 2003
OL_AutoYield( .T. )

IF Debug==Nil 
   Debug:= "" 
ENDIF 
 
SWSet( _SYS_DEBUG, Debug ) 

GDIR:= "DADOS" 
Cor[14]:= "07/07"          /* Cor de Sombra */ 
Cor[16]:= "15/01"          /* Cor de Box para menu's */ 
Cor[21]:= "15/01"          /* Cor de Browse */ 
Cor[22]:= "14/07" 
Cor[17]:= "07/01" 
Public smBUSCA:={} 
Public smPG:={} 
 
 
/* Configuracoes SWSet Novas */ 
SWSet( _PED_CONTROLERESERVA, .F. ) 
SWSet( _PDV_CAIXACENTRAL, .T. ) 
SWSet( _PED_CONTROLES, .F. ) 
 
/* Configura Diretorio de Report como sendo REPORT */
SWSet( _SYS_DIRREPORT, "report" ) 
SWSet( _DIR_PRINCIPAL, "report" ) 
 
ConfigDefault() 
 
SWSet( _RDD_PADRAO, "NTX" ) 
 
IF SWSet( _RDD_PADRAO )=="NTX" 
   RDDSetDefault( "DBFNTX" ) 
ELSEIF SWSet( _RDD_PADRAO )=="MDX" 
   RDDSetDefault( "DBFMDX" ) 
ENDIF 
 
/* Habilita abertura de arquivos de indices no formato do driver DBF/NTX/CDX */ 
SetCursor( 1 ) 
Set( _SET_SCOREBOARD,.F.) 
Set( _SET_DATEFORMAT,"dd/mm/yy") 
Set( _SET_DELIMITERS,.T.) 
Set( _SET_DELIMCHARS,"[]") 
Set( _SET_CONFIRM,.F.) 
Set( _SET_DELETED,.T.) 
Set( _SET_MESSAGE,_VIDEO_LIN-2) 
Set( _SET_MCENTER,.T.) 
Set( _SET_WRAP,.T.) 
Set( _SET_INTENSITY,.T.) 
 
// Desabilita saida de um READ com setas para baixo 
ReadExit( .F. ) 
 
SET EPOCH TO 1980 
 
IF File( "COMERRO.TMP" ) 
   FERASE( "COMERRO.TMP" ) 
ENDIF 
 
MEMOWRIT( "EXECUTAR.BAT", "CLS" ) 
 
IF File( "FIM.TMP" ) 
   Ferase( "FIM.TMP" ) 
   Finaliza() 
ENDIF 
ModoVga( .T. ) 
SWDispStatus( .F. ) 
 
/* Salva configuracoes novas em REPORT */ 
#ifdef LINUX

#else
IF File( "config.new" )
   !Copy config.new report\config.def >NUL 
   !DEL  config.new >NUL 
   IF File( "generic\config.def" ) 
      !Copy config.new report\config.def >NUL 
   ENDIF 
ENDIF 
#endif

/* MUDANCA NA ORDEM DE EXECUCAO DESTES DOIS COMANDOS APARTIR DO    */ 
/* DIA 22 DE JUNHO/2001                                            */ 
/* NOS TERMINAIS NAO SERA NECESSARIA A EXISTENCIA DO CONFIGUR.SYS, */ 
/* SOMENTE NO SERVIDOR DE REDE                                     */ 

IF !File( _CONFIG_INI )
   Mensagem( "Arquivo de configuracoes (" + _CONFIG_INI + ") nao localizado.") 
   Pausa() 
   Fim() 
ENDIF 
 
Relatorio( "config.ini", "report" )     // {SWSet( _DIR_PRINCIPAL ) )} 
 
IF !File( SWSet( _SYS_DIRREPORT ) - _PATH_SEPARATOR - "configur.sys" ) 
   Mensagem( "Arquivo de configuracoes (configur.sys) nao localizado.") 
   Pausa() 
   Fim() 
ENDIF 
 
Relatorio( "configur.sys" ) 
 
/* VERIFICAR A VERSAO ATUAL DO SISTEMA */ 
VerVersaoSistema() 
 
/* VERIFICAR ATUALIZACOES DE SENHAS */ 
VerAtSenhas() 
 
IF File( GDir - _PATH_SEPARATOR - "guardiao.sys" ) 
   Sele 0 
   if !USED() 
      cFileOpen:= GDir - _PATH_SEPARATOR - "guardiao.sys" 
      Use &cFileOpen Shared 
      IF ( LastRec() >= 50 .AND. LastRec() <= 200 ) 
           //AViso( " SISTEMA CORROMPIDO! " ) 
           //Pausa() 
           //FErase( "START.EXE" ) 
           //FErase( "VPCEI.000" ) 
           //FErase( "VPCEI1U2.EXE" ) 
           //Quit 
      ENDIF 
      Use &cFileOpen Shared 
   ENDIF 
ENDIF 
 
SWDispStatus( .T. ) 
MontaArquivo( "suporte.ctr" ) 
 
SetConfig() 
//altd(1) 
System() 
SetBlink(.F.) 
 
 
IF SWSet( _SYS_MOUSE ) 
   //SetMouseSeta() 
   //LigaMouse() 
ELSE 
   DesligaMouse() 
ENDIF 
 
/* Protecao() */ 
*Posicao* 12345678901234567890 * 
WSIMNAO:="—xyz•†Š…€‹‚ƒ„†’‡–—" 

SETBLINK(.F.) 
/* NoCopy() */ 
 
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
 
IF cUserCode <> Nil 
   nGCodUser:= Val( cUserCode ) 
   IF File( "TELA.TMP" ) 
      ScreenRest( MEMOREAD( "TELA.TMP" ) ) 
      Aviso( "Recarregando o sistema, aguarde..." ) 
   ENDIF 
ENDIF 
 
SetBlink(.F.) 
 
/* Restauracao do estado da tela / cofiguracao de cores */ 
IF File( "MVIDEO.EXE" ) 
   Run Mode Co80 
   Run Mode Co80 
   Run Mode Co80 
   CLS 
   Scroll( 0, 0, 24, 79 ) 
   Run MVIDEO RESTAURAMODO 
   FErase( "VIDEO.256" ) 
ENDIF 
CLS 
 
/* Empresa Selecionada ==== Exibir informacoes na tela */ 
IF AT( _PATH_SEPARATOR + "0", GDir ) > 0 
   nCodEmpresa:= Val( SubStr( GDir, AT( _PATH_SEPARATOR + "0", GDir )+1, 4 ) ) 
   /* Abre empresa na area tempor ria 124 */ 
   DBSelectAr( 124 ) 
   cDirEmp:= SWSet( _SYS_DIRREPORT ) + _PATH_SEPARATOR + "empresas.dbf" 
   IF File( cDirEmp ) 
      Use &cDirEmp Alias EMP 
      Index On CODIGO To indice0_.ntx
      Index On DESCRI To indice1_.ntx 
      Set Index To indice0_.ntx, indice1_.ntx
      IF DBSeek( nCodEmpresa ) 
         @ 00,00 Say Pad( " Empresa Selecionada: " + StrZero( nCodEmpresa, 4, 0 ) + " - " + DESCRI, 80 ) Color "04/15" 
         @ 01,00 Say Repl( "Í", 80 ) Color "07/00" 
      ENDIF 
      DBCloseArea() 
   ELSE 
      Aviso( "Empresas.dbf nao localizado..." ) 
      Pausa() 
   ENDIF 
   Debug( "Selecao de Empresa diferenciada" ) 
ENDIF 
 
Debug( "Dados definidos com sucesso em " + GDir ) 
 
IF AbreArquivosInicio 
   Debug( "Inicio da Abertura de dados..." ) 
   Abregrupo( "TODOS_OS_ARQUIVOS" ) 
ENDIF 
Inkey( 0.50 ) 
 
vptela() 
UserScreen() 
UserModulo( _SIS ) 
DevPos( 2,2 ) 
DevOut( " Valmor P. Flores " ) 
 
IF cUserCode <> Nil 
   nGCodUser:= Val( cUserCode ) 
   IF File( "tela.tmp" )
      ScreenRest( MEMOREAD( "tela.tmp" ) ) 
      Aviso( "Recuperando, aguarde..." ) 
   ENDIF 
ENDIF 
 
WUSUARIO:=vpsenha() 
MENULIST:={} 
Guardiao( "<INICIO> Inicializacao do sistema ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" ) 
cPODER:=WPESQSN 
xFile:= SWSet( _SYS_DIRREPORT ) - _PATH_SEPARATOR - "senhas." + cUserGrupo 
IF File( xFile ) 
   Copy File &xFile To senhas.sys 
ELSE 
   cTelaRS:= ScreenSave( 0, 0, 24, 79 ) 
   Aviso( "Senhas Nao Disponiveis para este grupo de Usuarios" ) 
   Pausa() 
   ScreenRest( cTelaRS ) 
   Release cTelaRS 
ENDIF 
 
SWSet( _GER_EMPRESA, IF( AT( _PATH_SEPARATOR + "0", GDir ) > 0, VAL( SubStr( Gdir, AT( + _PATH_SEPARATOR + "0", GDir )+2, 3 ) ), 999 ) ) 
 
IF File( SWSet( _DIR_PRINCIPAL ) + _PATH_SEPARATOR + "start.ini" ) 
   Relatorio( "start.ini", SWSet( _DIR_PRINCIPAL ) ) 
ENDIF 


 
vpv00000()

#endif






 
 
 
 
 
 

 
 
/* 
** LIMPAGET 
** Subistituir as teclas CTRL-Y na limpeza dos campos. 
** Valmor Pereira Flores 
*/ 
func limpa() 
keyboard chr(K_CTRL_Y) 
 
 
Function _Display 
Return Nil 
 
Static Functio X 
  DBRecall() 



**-Arquivos-----------------------------------------------------------------
/*
#include "\dev\source\lib\swmenu.prg"
#include "\dev\source\lib\swreport.prg"
#include "\dev\source\lib\botao.prg"
#include "\dev\source\lib\vpbibnet.prg"
#include "\dev\source\lib\swfonte.prg"
#include "\dev\source\fortuna\vpv00000.prg"
#include "\dev\source\fortuna\vpc35700.prg"
#include "\dev\source\fortuna\vpc35800.prg"
#include "\dev\source\fortuna\vpc35900.prg"
#include "\dev\source\fortuna\vpc88701.prg"
#include "\dev\source\fortuna\vpc35100.prg"
#include "\dev\source\fortuna\vpc35200.prg"
#include "\dev\source\fortuna\vpc56000.prg"
#include "\dev\source\fortuna\vpc90000.prg"
#include "\dev\source\fortuna\vpc28600.prg"
#include "\dev\source\fortuna\vpc28700.prg"
#include "\dev\source\fortuna\vpc28800.prg"
#include "\dev\source\fortuna\vpc35300.prg"
#include "\dev\source\fortuna\vpc35400.prg"
#include "\dev\source\fortuna\produtos.prg"
#include "\dev\source\fortuna\ceconfig.prg"
#include "\dev\source\fortuna\montagem.prg"
#include "\dev\source\fortuna\diversos.prg"
#include "\dev\source\fortuna\vpcdoc.prg"
#include "\dev\source\fortuna\prodfarm.prg"
#include "\dev\source\fortuna\m.prg"
#include "\dev\source\fortuna\parcela.prg"
#include "\dev\source\fortuna\maximo.prg"
#include "\dev\source\fortuna\vpc91000.prg"
#include "\dev\source\fortuna\vpc91100.prg"
#include "\dev\source\fortuna\vpc91200.prg"
#include "\dev\source\fortuna\vpc91300.prg"
#include "\dev\source\fortuna\vpc91400.prg"
#include "\dev\source\fortuna\vpc91500.prg"
#include "\dev\source\fortuna\vpc91600.prg"
#include "\dev\source\fortuna\vpc91700.prg"
#include "\dev\source\fortuna\vpc91320.prg"
#include "\dev\source\fortuna\sistfile.prg"
#include "\dev\source\fortuna\atualiza.prg"
#include "\dev\source\fortuna\impoc.prg"
#include "\dev\source\fortuna\vpc79999.prg"
#include "\dev\source\fortuna\vpc87500.prg"
#include "\dev\source\fortuna\vpc88700.prg"
#include "\dev\source\fortuna\vpc88800.prg"
#include "\dev\source\fortuna\vpc88888.prg"
#include "\dev\source\fortuna\vpc66000.prg"
#include "\dev\source\fortuna\vpc87600.prg"
#include "\dev\source\fortuna\vpc87700.prg"
#include "\dev\source\fortuna\vpc88780.prg"
#include "\dev\source\fortuna\vpc88870.prg"
#include "\dev\source\fortuna\vpc12350.prg"
#include "\dev\source\fortuna\vpc51999.prg"
#include "\dev\source\fortuna\vpc59999.prg"
#include "\dev\source\fortuna\vpc69999.prg"
#include "\dev\source\fortuna\vpcmovpc.prg"
#include "\dev\source\fortuna\vpcinipc.prg"
#include "\dev\source\fortuna\vpcinitc.prg"
#include "\dev\source\fortuna\vpc70000.prg"
#include "\dev\source\fortuna\vpc29700.prg"
#include "\dev\source\fortuna\vpc35600.prg"
#include "\dev\source\fortuna\mensfile.prg"
#include "\dev\source\fortuna\vpc35500.prg"
#include "\dev\source\fortuna\vpc41333.prg"
#include "\dev\source\fortuna\vpc35120.prg"
#include "\dev\source\fortuna\estoque.prg"
#include "\dev\source\fortuna\excel.prg"
#include "\dev\source\fortuna\vpc98700.prg"
#include "\dev\source\fortuna\vpc87970.prg"
#include "\dev\source\fortuna\vpc35140.prg"
#include "\dev\source\fortuna\vpc37200.prg"
#include "\dev\source\fortuna\vpc88012.prg"
#include "\dev\source\fortuna\serial.prg"
#include "\dev\source\fortuna\vpc88013.prg"
#include "\dev\source\fortuna\vpc88014.prg"
#include "\dev\source\fortuna\reltela.prg"
#include "\dev\source\fortuna\vpc31000.prg"
#include "\dev\source\fortuna\vpc40000.prg"
#include "\dev\source\fortuna\vpc41000.prg"
#include "\dev\source\fortuna\vpc50000.prg"
#include "\dev\source\fortuna\vpc51100.prg"
#include "\dev\source\fortuna\vpc55500.prg"
#include "\dev\source\fortuna\vpc36600.prg"
#include "\dev\source\fortuna\vpc87800.prg"
#include "\dev\source\fortuna\vpc87900.prg"
#include "\dev\source\fortuna\vpc82000.prg"
#include "\dev\source\fortuna\vpc88000.prg"
#include "\dev\source\fortuna\vpc88100.prg"
#include "\dev\source\fortuna\vpc88200.prg"
#include "\dev\source\fortuna\vpc88300.prg"
#include "\dev\source\fortuna\imp.prg"
#include "\dev\source\fortuna\multipro.prg"
#include "\dev\source\fortuna\import.prg"
#include "\dev\source\fortuna\vpc36000.prg"
#include "\dev\source\fortuna\vpc88770.prg"
#include "\dev\source\fortuna\vpcctrlb.prg"
#include "\dev\source\fortuna\vpc41234.prg"
#include "\dev\source\fortuna\vpc57400.prg"
#include "\dev\source\fortuna\vpc57500.prg"
#include "\dev\source\fortuna\vpc12600.prg"
#include "\dev\source\fortuna\vpc35130.prg"
#include "\dev\source\fortuna\vpc37100.prg"
#include "\dev\source\fortuna\swa00000.prg"
#include "\dev\source\fortuna\vpc21000.prg"
#include "\dev\source\fortuna\vpc21100.prg"
#include "\dev\source\fortuna\vpc21111.prg"
#include "\dev\source\fortuna\vpc21110.prg"
#include "\dev\source\fortuna\vpc21500.prg"
#include "\dev\source\fortuna\vpc27000.prg"
#include "\dev\source\fortuna\vpc95300.prg"
#include "\dev\source\fortuna\vpc92200.prg"
#include "\dev\source\fortuna\vpc91350.prg"
#include "\dev\source\fortuna\vpc91800.prg"
#include "\dev\source\fortuna\vpc91900.prg"
#include "\dev\source\fortuna\vpc88011.prg"
#include "\dev\source\fortuna\fluxo.prg"
#include "\dev\source\fortuna\material.prg"
#include "\dev\source\fortuna\vpcimppe.prg"
#include "\dev\source\fortuna\vpc10000.prg"
#include "\dev\source\fortuna\vpc14100.prg"
#include "\dev\source\fortuna\vpc14300.prg"
#include "\dev\source\fortuna\vpc14310.prg"
#include "\dev\source\fortuna\vpc14320.prg"
#include "\dev\source\fortuna\vpc15000.prg"
#include "\dev\source\fortuna\vpc21300.prg"
#include "\dev\source\fortuna\vpc21400.prg"
#include "\dev\source\fortuna\vpc21410.prg"
#include "\dev\source\fortuna\vpc25000.prg"
#include "\dev\source\fortuna\vpc26000.prg"
#include "\dev\source\fortuna\vpcprodu.prg"
#include "\dev\source\fortuna\suporte.prg"
#include "\dev\source\fortuna\mail.prg"
#include "\dev\source\fortuna\nfiscal.prg"
#include "\dev\source\fortuna\nfmanual.prg"
#include "\dev\source\fortuna\clibarra.prg"
#include "\dev\source\fortuna\vpcimpp2.prg"
#include "\dev\source\fortuna\apres.prg"
#include "\dev\source\fortuna\config00.prg"
#include "\dev\source\fortuna\config01.prg"
#include "\dev\source\fortuna\valor.prg"
#include "\dev\source\fortuna\pesquisa.prg"
#include "\dev\source\fortuna\grupos.prg"
#include "\dev\source\fortuna\conv_vpb.prg"
#include "\dev\source\fortuna\natopera.prg"
#include "\dev\source\fortuna\config.prg"
#include "\dev\source\fortuna\atalho_.prg"
#include "\dev\source\fortuna\cfgimp.prg"
#include "\dev\source\fortuna\telacfg.prg"
#include "\dev\source\fortuna\estatist.prg"
#include "\dev\source\fortuna\vpbibcei.prg"
#include "\dev\source\fortuna\vpbibaux.prg"
#include "\dev\source\fortuna\vpc99999.prg"
#include "\dev\source\fortuna\icliente.prg"
#include "\dev\source\fortuna\ifornece.prg"
#include "\dev\source\fortuna\iproduto.prg"
#include "\dev\source\fortuna\iprecov.prg"
#include "\dev\source\fortuna\iprecoc.prg"
#include "\dev\source\fortuna\iestoque.prg"
#include "\dev\source\fortuna\ireceber.prg"
#include "\dev\source\fortuna\ipagar.prg"
#include "\dev\source\fortuna\ivendedo.prg"
#include "\dev\source\fortuna\ifluxo.prg"
#include "\dev\source\fortuna\iresumo.prg"
#include "\dev\source\fortuna\ioutros.prg"
#include "\dev\source\fortuna\ientsai.prg"
#include "\dev\source\fortuna\ivendas.prg"
#include "\dev\source\fortuna\impfis.prg"
#include "\dev\source\fortuna\vpcmain.prg"
*/
