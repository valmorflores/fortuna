/*

  FORTUNA AUTOMACAO COMERCIAL

  VPVCEI
  Fortuna - Sistema de Automacao Comercial

  Versao console.

  Compativel com Windows, Linux, OS/2
  Compativel com os Compiladores  xHarbour, Clipper, C3

  Valmor Pereira Flores

  ---------------------------------------------------------------------
  Modulo Principal do Sistema           = vpcei.prg
  Ultima atualizacao deste modulo       = Setembro/2003
  Responsavel                           = Valmor P. Flores
  ---------------------------------------------------------------------
  Todos os direitos reservados a Fortuna Automacao Comercial


*/

#include "vpf.ch"
#include "inkey.ch"


//vpcei()

//#ifdef HARBOUR

function main()
//#endif

//REQUEST HB_GT_WIN_DEFAULT
Para cCodigo, Debug


Local cScreenRes
Local nCodEmpresa
Loca WTELA, nOPCAO:=0

// Compatibilidade com versoes de fontes mais antigos
Private WUSUARIO:="Usu�rio"
Private cUserCode:= ""
Public _FORTUNA_:= "_VERSAO_"+_VER
Public MenBarraRolagem:= " �� Soft&Ware Inform�tica �� �������� �� (51)471.6249 9134.6249 9112.8364 �� ������������������" 
Public cConfirmaSaida:= "SIM" 
Public DiretorioDeDados:= 'dados'
PUBLIC COR:={"15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01"}

Private GDir:= "<Indefinido>"

// Show de variaveis globais
Priv Driver:= ""
Priv cDirEmp
priv XCONFIG:=.T.
priv WPESQSN:=WSIMNAO:="", GDIR2SUB:= "DADOS", _VP2:=.t., WHELP:=.f.

Priv _EMP, _END, _END1, _END2, _CD, _COMSENHA, _COMDATA, _COMSOM, _MARGEM
priv _COMSOMBRA, _COMZOOM, nMAXLIN:=24, nMAXCOL:=79
priv _VIDEO_LIN:=25, _VIDEO_COL:=80
priv cPODER, nGCODUSER:= 0, cUserGrupo:= "000", nCodUser:= 0
priv AbreArquivosInicio:= .T.
priv ForPagPagamento:= "A"
Public ScreenBack:= 'Sistema'
Public lERRO:=.F.


cUserCode:= cCodigo

IF cCodigo <> Nil
   IF Upper( cCodigo )=="DEMO"
      _FORTUNA_:= "Fortuna-Demonstracao"
   ENDIF
ENDIF

SetCancel( .T. )
mensagem( 'Iniciando o sistema, aguarde...')

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
//OL_AutoYield( .T. )

IF Debug==Nil
   Debug:= ""
ENDIF

SWSet( _SYS_DEBUG, Debug )

GDIR:= "dados"
Cor[14]:= "07/07"          /* Cor de Sombra */
Cor[16]:= "15/01"          /* Cor de Box para menu's */
Cor[21]:= "15/01"          /* Cor de Browse */
Cor[22]:= "14/07"
Cor[17]:= "07/01"
Public smBUSCA:={}
Public smPG:={}


SWSet( _PED_VERIFICASALDO, .T. )
SWSet( _PED_DETALHE, .F. )
SWSet( _PED_CONTROLERESERVA, .F. )
SWSet( _PDV_CAIXACENTRAL, .T. )
SWSet( _PED_CONTROLES, .F. )
SWSet( _SYS_MOUSE, .F. )

/* Parametros de custos contabeis */
SWSet( _GER_CUSTOS_PIS, 0 )
SWSet( _GER_CUSTOS_COFINS, 0 )
SWSet( _GER_CUSTOS_DESCONTOS, 0 )
SWSet( _GER_CUSTOS_ACRESCIMOS, 0 )
SWSet( _GER_CUSTOS_CONTABIL, .F. )
SWSet( _CMP_ATUALIZA_PRECO, .T. )

/* Configura Diretorio de Report como sendo REPORT */
SWSet( _SYS_DIRREPORT, "report" )
SWSet( _DIR_PRINCIPAL, "report" )
SWSet( _RDD_PADRAO, "NTX" )
// SWSet( _ENT_MUDAPRECO, .T. )

ConfigDefault()

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

Ajuda( "Versao do sistema [" + _VER + "]" )
IF !File( _CONFIG_INI ) .and. !File( "report/config.ini" )
   Mensagem( "Arquivo de configuracoes (" + _CONFIG_INI + ") nao localizado.")
   Pausa()
   Fim()
ENDIF

//Relatorio( "config.ini", "report" )     // {SWSet( _DIR_PRINCIPAL ) )}

mensagem( SWSet( _SYS_DIRREPORT ) )
IF !File( SWSet( _SYS_DIRREPORT ) + _PATH_SEPARATOR + "configur.sys" )
   Mensagem( "Arquivo de configuracoes (configur.sys) nao localizado.")
   Pausa()
   Fim()
ENDIF

//Relatorio( "configur.sys" )

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
WSIMNAO:="�xyz���������������"

SETBLINK(.F.)
/* NoCopy() */

WHILE !Diretorio( ALLTRIM( GDir ) )
   nOpcao:= SWAlerta( "Impossivel acessar informacoes do sistema"+;
           ";Acesso negado ao diretorio " + Alltrim( GDir ) + "...",;
            { " 1-Finalizar o Programa ", " 2-Alterar Temporariamente " } )
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
   Run Mode Co80  >NUL
   Run Mode Co80  >NUL
   Run Mode Co80  >NUL
   CLS
   Scroll( 0, 0, 24, 79 )
   Run MVIDEO RESTAURAMODO
   FErase( "VIDEO.256" )
ENDIF
CLS

/* Empresa Selecionada ==== Exibir informacoes na tela */
IF AT( _PATH_SEPARATOR + "0", GDir ) > 0
   nCodEmpresa:= Val( SubStr( GDir, AT( _PATH_SEPARATOR + "0", GDir )+1, 4 ) )
   /* Abre empresa na area tempor�ria 124 */
   DBSelectAr( 124 )
   cDirEmp:= SWSet( _SYS_DIRREPORT ) + _PATH_SEPARATOR + "empresas.dbf"
   IF File( cDirEmp )
      Use &cDirEmp Alias EMP
      Index On CODIGO To indice0_.ntx
      Index On DESCRI To indice1_.ntx
      Set Index To indice0_.ntx, indice1_.ntx
      IF DBSeek( nCodEmpresa )
         @ 00,00 Say Pad( " Empresa Selecionada: " + StrZero( nCodEmpresa, 4, 0 ) + " - " + DESCRI, 80 ) Color "04/15"
         @ 01,00 Say Repl( "�", 80 ) Color "07/00"
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
   //Abregrupo( "TODOS_OS_ARQUIVOS" )
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
Guardiao( "<INICIO> Inicializacao do sistema ������������������������" )
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



vpc00000()










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

