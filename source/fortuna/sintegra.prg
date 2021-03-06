
/*

  EVOLUTIVA SISTEMAS DE GESTAO EMPRESARIAL 
  Sistema de Automacao Comercial
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
#include "formatos.ch" 


#ifdef HARBOUR
   function main()
#endif

Para cCodigo, Debug 


Local cScreenRes 
Local nCodEmpresa 
Loca WTELA, nOPCAO:=0 

// Compatibilidade com versoes de fontes mais antigos
Private WUSUARIO:="Usu�rio"
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
 
 
SWSet( _PED_VERIFICASALDO, .T. ) 
SWSet( _PED_DETALHE, .F. )
SWSet( _PED_CONTROLERESERVA, .F. ) 
SWSet( _PDV_CAIXACENTRAL, .T. ) 
SWSet( _PED_CONTROLES, .F. ) 
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

Ajuda( "Versao do sistema [" + _VER + "]" )
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

/* STATUS */ 
SWDispStatus( .T. ) 
MontaArquivo( "suporte.ctr" ) 
 
SetConfig() 

System() 
SetBlink(.F.) 
 
IF ! SWSet( _SYS_MOUSE ) 
   DesligaMouse() 
ENDIF 
 
/* Protecao() */ 
WSIMNAO:="�xyz���������������" 

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


 
SISTEMA_SINTEGRA() 
 
 
 
 
 
 
 

 
 
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
 




REQUEST DBFCDX
REQUEST DBFNTX

*���������������������������*
* SINTEGRA
* GERADOR DE INFORMACOES PARA SINTEGRA 
* Programador - Valmor Pereira Flores 
* Janeiro de 2004
*�����������������������������������������������������������������������������* 



      
function Sistema_sintegra()


Local nOpcao:= 0

memvar MENULIST

nOpcao:= 1

SETBLINK(.F.) 
IF AT( "Soft&Ware", MenBarraRolagem ) == 0 
   MenBarraRolagem:= " INSTALACAO NAO AUTORIZADA - Software de Demonstracao     (Ligue 051-334.3225)  " 
ENDIF 
 
IF AT( "Demonstracao", _FORTUNA_ ) > 0 
 
   VPBox( 02, 02, 20, 74, "Demonstracao do Sistema", _COR_GET_BOX, .F., .F. ) 
   SetColor( _COR_GET_EDICAO ) 
 
   @ 04,07 Say "Bem-vindo ao universo de produtos Evolutiva" Color "14/" + CorFundoAtual() 
   @ 05,07 Say "Esta versao do sistema destina-se a demonstracao dos" 
   @ 06,07 Say "recursos do sistema F7 - Evolutiva Sistemas de Gestao"
   @ 07,07 Say "Empresarial ltda!"
 
   @ 16,07 Say PADR( "Equipe Fortuna", 50 ) 
   inkey(0) 
   _EMP:= "EMPRESA DEMONSTRACAO" 
   VPTELA() 
 
ENDIF 
 
 
 
whil .t. 

   limpavar() 
   if XCONFIG 
      setcolor("00/00") 
      SetConfig() 
      vptela() 
      WTELA:=zoom(05,02,13,27) 
      vpbox(05,02,13,27) 
 
      /* Busca o nome da empresa selecionada */ 
      IF AT( _PATH_SEPARATOR + "0", GDir ) > 0  .AND. File( SWSet( _SYS_DIRREPORT ) + _PATH_SEPARATOR + "empresas.dbf" ) 
         nCodigo:= VAL( AllTrim( SubStr( GDir, AT( _PATH_SEPARATOR + "0", Alltrim( GDir ) ) + 2 ) ) ) 
         IF nCodigo > 0 
            Sele 124 
            cDirEmp:= SWSet( _SYS_DIRREPORT ) + _PATH_SEPARATOR + "empresas.dbf" 
            Use &cDirEmp Alias EMP 
            DBGoTop() 
            WHILE !EOF() 
               IF CODIGO==nCodigo 
                  _EMP:= DESCRI 
                  Exit 
               ENDIF 
               DBSkip() 
            ENDDO 
            DBCloseArea() 
         ENDIF 
      ENDIF 
      /* Fim da Busca */ 
 
      titulo(_EMP) 
      usuario(WUSUARIO) 
      XCONFIG=.F. 
   endif 
   nLIN:=0 
   mensagem("") 
   ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
   SetColor( COR[12] + "," + COR[13] ) 
 
   LiberaMemoria() 
   MenuList:= {} 

   IF File( "SINTEGRA.INI" )
      DBSelectAr( 123 )
      DBCloseArea()
      SintegraCarrega()
      SintegraExibe()
   ENDIF

   // ABRE TABELA DE EMPRESAS
   cReport:= SWSet( _SYS_DIRREPORT )
   DBSelectar( 124 )
   USE &cReport\EMPRESAS.DBF ALIAS EMP
   INDEX ON CODIGO TO TEMP\IND00293.TMP

   SetOpcao( MenuList, 0 )
   Set( _SET_DELIMITERS, .T. ) 
   aadd( MENULIST, swmenunew(06,03," 1 Gerar Arquivo       ",2,COR[11],; 
        "Gerar arquivo compativel com o sistema SINTEGRA do ICMs.",,,COR[6],.F.)) 
   aadd( MENULIST, swmenunew(07,03," 2 Definir Parametros  ",2,COR[11],; 
        "Definir parametros para geracao do arquivo.",,,COR[6],.F.)) 
   aadd( MENULIST, swmenunew(08,03," 3 Selecionar Empresa  ",2,COR[11],; 
        "Selecionar a base de dados de origem.",,,COR[6],.F.)) 
   aadd( MENULIST, swmenunew(09,03," 4 Ler arquivo         ",2,COR[11],;
        "Recarregar configuracoes e parametros.",,,COR[6],.F.))
   aadd( MENULIST, swmenunew(10,03," 5 Editar Mapa Resumo  ",2,COR[11],;
        "Editar resumo de cupons fiscais.",,,COR[6],.F.))
   aadd( MENULIST, swmenunew(11,03," 6 Exportar            ",2,COR[11],;
        "Exportar para sistema de livros fiscais",,,COR[6],.F.))
   aadd( MENULIST, swmenunew(12,03," 0 Encerramento        ",2,COR[11],;
        "Execucao da finalizacao do programa.",,,COR[6],.F.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 

      case nOPCAO=7 .OR. ( LastKey() == K_ESC .AND. cConfirmaSaida == "SIM" )
           IF cConfirmaSaida == "SIM" 
              IF ( nOp:= SWAlerta( "Finalizacao do Sistema; O que voce deseja fazer?",; 
                 { " Sair ", " Continuar " } ) ) == 1 
                 EXIT 
              ENDIF 
           ELSE 
              EXIT 
           ENDIF
      CASE nOpcao == 1
          SintegraGera()
      CASE nOpcao == 2
          SintegraConfigura()
      CASE nOpcao == 3
          Empresa()
      CASE nOpcao == 5
          SintEdResumo()
      CASE nOpcao == 6
          SintExporta()
   endcase 
enddo 
Guardiao( "<FIM> Finalizacao do sistema �����������������������������" ) 
fim() 
 
 
/* 
Funcao     - ConfigDefault 
Finalidade - Set das configuracoes default do sistema 
*/ 
Function ConfigDefault() 
  Return .T. 

Function ExisteMens()
  Return .F.

#Define _SIN_CONVENIO        30000
#Define _SIN_NATUREZA        30001
#Define _SIN_FINALIDADE      30002

#Define _SIN_IE              30100
#Define _SIN_DATAINICIAL     30201
#Define _SIN_DATAFINAL       30202
#Define _SIN_CNPJ            30300

#Define _SIN_EMPRESA         30400
#Define _SIN_LOGRADOURO      30500
#Define _SIN_NUMERO          30501
#Define _SIN_COMPLEMENTO     30502
#Define _SIN_BAIRRO          30503
#Define _SIN_CEP             30504
#Define _SIN_RESPONSAVEL     30600
#Define _SIN_TELEFONE        30601
#Define _SIN_TIPO            30700

#Define _SIN_ARQUIVO         30900

Function SintegraConfigura()
  Local cCor:= SetColor()
  Local cTela:= ScreenSave( 0, 0, 24, 79 )
  Local cEmpresa:= "", cConvenio, cNatureza, cFinalidade, cIE, dDataInicial,;
        dDataFinal, cCNPJ, cArquivo, cBairro, cCep, cTipo

   SintegraCarrega()

   cConvenio:=   SWSet( _SIN_CONVENIO )
   cNatureza:=   SWSet( _SIN_NATUREZA )
   cFinalidade:= SWSet( _SIN_FINALIDADE )
   cIE:=         SWSet( _SIN_IE )
   dDataInicial:=SWSet( _SIN_DATAINICIAL )
   dDataFinal:=  SWSet( _SIN_DATAFINAL )
   cCNPJ:=       SWSet( _SIN_CNPJ )
   cEmpresa:=    SWSet( _SIN_EMPRESA )
   cArquivo:=    SWSet( _SIN_ARQUIVO )

   cEndereco:=   SWSet( _SIN_LOGRADOURO )
   cNumero:=     SWSet( _SIN_NUMERO  )
   cComplemento:=SWSet( _SIN_COMPLEMENTO )
   cBairro:=     SWSet( _SIN_BAIRRO )
   cCEP:=        SWSet( _SIN_CEP )

   cResponsavel:=SWSet( _SIN_RESPONSAVEL  )
   cTelefone:=   SWSet( _SIN_TELEFONE  )

   cTipo:=       SWSet( _SIN_TIPO )

   SetColor( _COR_GET_EDICAO )
   @ 04,30 Say "Arquivo........:" Get cArquivo Pict "@S25"
   @ 05,30 Say "Convenio.......:" get cConvenio
   @ 06,30 Say "Natureza.......:" Get cNatureza
   @ 07,30 Say "Finalidade.....:" Get cFinalidade
   @ 08,30 Say "IE.............:" Get cIE
   @ 09,30 Say "Data Inicial...:" Get dDataInicial
   @ 10,30 Say "Data Final.....:" Get dDataFinal
   @ 11,30 Say "CNPJ...........:" Get cCNPJ
   @ 12,30 Say "Empresa........:" Get cEmpresa     Pict "@S25" 
   @ 13,30 Say "Logradouro.....:" Get cEndereco    Pict "@S25" 
   @ 14,30 Say "Numero.........:" Get cNumero
   @ 15,30 Say "Complemento....:" Get cComplemento
   @ 16,30 Say "Bairro.........:" Get cBairro      
   @ 17,30 Say "CEP............:" Get cCep          
   @ 18,30 Say "Responsavel....:" Get cResponsavel Pict "@S25" 
   @ 19,30 Say "Telefone.......:" Get cTelefone
   @ 20,30 Say "Entradas.......:" Get cTipo
   READ

   Aviso( "Gravando informacoes de parametros do SINTEGRA, aguarde..." )
   SWSet( _SIN_CONVENIO,    cConvenio    )
   SWSet( _SIN_NATUREZA,    cNatureza    )
   SWSet( _SIN_FINALIDADE,  cFinalidade  )
   SWSet( _SIN_IE,          cIE          )
   SWSet( _SIN_DATAINICIAL, dDataInicial )
   SWSet( _SIN_DATAFINAL,   dDataFinal   )
   SWSet( _SIN_CNPJ,        cCNPJ        )
   SWSet( _SIN_EMPRESA,     cEmpresa     )
   SWSet( _SIN_LOGRADOURO,  cEndereco    )
   SWSet( _SIN_NUMERO,      cNumero      )
   SWSet( _SIN_COMPLEMENTO, cComplemento )
   SWSet( _SIN_BAIRRO,      cBairro      )
   SWSet( _SIN_CEP,         cCEP         )

   SWSet( _SIN_RESPONSAVEL, cResponsavel )
   SWSet( _SIN_TELEFONE,    cTelefone    )

   SWSet( _SIN_TIPO,        cTipo        )

   SintegraSalva()
   ScreenRest( cTela )
   SintegraExibe()
   SetColor( cCor )
   Return Nil


Function SintegraCarrega()
   IF File( "SINTEGRA.INI" )
      DBSelectAr( 123 )
      IF !USED()
         DBCreate( "TEMP.DBF", { { "ORIGEM", "C", 200, 0 } } )
         USE TEMP ALIAS TMP EXCLUSIVE
      ELSE
         ZAP
      ENDIF
      APPEND FROM SINTEGRA.INI SDF
      SWSet( _SIN_ARQUIVO,     CarregaCampo( "Arquivo" ) )
      SWSet( _SIN_CONVENIO,    CarregaCampo( "Convenio" ) )
      SWSet( _SIN_NATUREZA,    CarregaCampo( "Natureza" ) )
      SWSet( _SIN_FINALIDADE,  CarregaCampo( "Finalidade" ) )
      SWSet( _SIN_IE,          CarregaCampo( "IE" ) )
      SWSet( _SIN_DATAINICIAL, CarregaCampo( "DataInicial" ) )
      SWSet( _SIN_DATAFINAL,   CarregaCampo( "DataFinal" ) )
      SWSet( _SIN_CNPJ,        CarregaCampo( "CNPJ" ) )
      SWSet( _SIN_EMPRESA,     CarregaCampo( "Empresa" ) )
      SWSet( _SIN_LOGRADOURO,  CarregaCampo( "Endereco" ) )
      SWSet( _SIN_NUMERO,      CarregaCampo( "Numero" ) )
      SWSet( _SIN_COMPLEMENTO, CarregaCampo( "Complemento" ) )
      SWSet( _SIN_BAIRRO,      CarregaCampo( "Bairro" ) )
      SWSet( _SIN_CEP,         CarregaCampo( "Cep" ) )

      SWSet( _SIN_RESPONSAVEL, CarregaCampo( "Responsavel" ) )
      SWSet( _SIN_TELEFONE,    CarregaCampo( "Telefone" ) )

      SWSet( _SIN_TIPO,        CarregaCampo( "Tipo" ) )

   ENDIF



Function SintegraExibe()
Local cCor:= SetColor()
   VPBox( 03, 28, 21, 75, "PARAMETROS", _COR_GET_BOX )
   SetColor( _COR_GET_EDICAO )
   @ 04,30 Say "Arquivo........: [" + LEFT( SWSet( _SIN_ARQUIVO ), 25 )  + "]"
   @ 05,30 Say "Convenio.......: [" + SWSet( _SIN_CONVENIO )   + "]"
   @ 06,30 Say "Natureza.......: [" + SWSet( _SIN_NATUREZA )   + "]"
   @ 07,30 Say "Finalidade.....: [" + SWSet( _SIN_FINALIDADE ) + "]"
   @ 08,30 Say "IE.............: [" + SWSet( _SIN_IE ) + "]"
   @ 09,30 Say "Data Inicial...: [" + SWSet( _SIN_DATAINICIAL ) + "]"
   @ 10,30 Say "Data Final.....: [" + SWSet( _SIN_DATAFINAL ) + "]"
   @ 11,30 Say "CNPJ...........: [" + SWSet( _SIN_CNPJ ) + "]"
   @ 12,30 Say "Empresa........: [" + LEFT( SWSet( _SIN_EMPRESA ), 25 ) + "]"
   @ 13,30 Say "Logradouro.....: [" + LEFT( SWSet( _SIN_LOGRADOURO ), 25 )   + "]"
   @ 14,30 Say "Numero.........: [" + SWSet( _SIN_NUMERO  )      + "]"
   @ 15,30 Say "Complemento....: [" + SWSet( _SIN_COMPLEMENTO )  + "]"
   @ 16,30 Say "Bairro.........: [" + SWSet( _SIN_BAIRRO )  + "]"
   @ 17,30 Say "CEP............: [" + SWSet( _SIN_CEP )  + "]"
   @ 18,30 Say "Responsavel....: [" + LEFT( SWSet( _SIN_RESPONSAVEL  ), 25 ) + "]"
   @ 19,30 Say "Telefone.......: [" + SWSet( _SIN_TELEFONE  )    + "]"
   @ 20,30 Say "Tipo...........: [" + PAD( SWSet( _SIN_TIPO ), 25 ) + "]"
   SetColor( cCor )
   Return Nil

Function SintegraSalva()
      DBSelectAr( 123 )
      IF !used()
         DBCreate( "TEMP.DBF", { { "ORIGEM", "C", 200, 0 } } )
         USE TEMP ALIAS TMP EXCLUSIVE
      ENDIF
      ZAP
      GravaCampo( 'Arquivo:= "' + SWSet( _SIN_ARQUIVO ) + '"' )
      GravaCampo( 'Convenio:= "' + SWSet( _SIN_CONVENIO ) + '"' )
      GravaCampo( 'Natureza:= "' + SWSet( _SIN_NATUREZA ) + '"')
      GravaCampo( 'Finalidade:= "' + SWSet( _SIN_FINALIDADE ) + '"' )
      GravaCampo( 'IE:= "'  + SWSet( _SIN_IE ) + '"' )
      GravaCampo( 'DataInicial:= "' + SWSet( _SIN_DATAINICIAL ) + '"' )
      GravaCampo( 'DataFinal:=  "' + SWSet( _SIN_DATAFINAL ) + '"' )
      GravaCampo( 'CNPJ:= "' + SWSet( _SIN_CNPJ ) + '"' )
      GravaCampo( 'Empresa:= "'  + SWSet( _SIN_EMPRESA ) + '"' )
      GravaCampo( 'Endereco:= "' + SWSet( _SIN_LOGRADOURO ) + '"' )
      GravaCampo( 'Numero:= "' + SWSet( _SIN_NUMERO  ) + '"' )
      GravaCampo( 'Complemento:= "' + SWSet( _SIN_COMPLEMENTO ) + '"' )
      GravaCampo( 'Bairro:= "' + SWSet( _SIN_BAIRRO ) + '"' )
      GravaCampo( 'CEP:= "' + SWSet( _SIN_CEP ) + '"' )
      GravaCampo( 'Responsavel:= "' + SWSet( _SIN_RESPONSAVEL ) + '"' )
      GravaCampo( 'Telefone:= "' + SWSet( _SIN_TELEFONE ) + '"' )
      GravaCampo( 'Tipo:= "' + SWSet( _SIN_TIPO ) + '"' )

      // Gravar informacoes no arquivo .ini
      Set( 24, "SINTEGRA.INI" )
      Set( 20, "PRINT" )
      DBGoTop()
      @ PROW(),PCOL() SAY "[CONFIGURACOES]" + CHR( 13 ) + CHR( 10 )
      WHILE !EOF()
         @ PROW(),PCOL() SAY ORIGEM + CHR( 13 ) + CHR( 10 )
         DBSkip()
      ENDDO
      Set( 20, "SCREEN" )
      Set( 24, "LPT1" )




Function SintegraLe()

Function SintegraGera()
     IF SWAlerta( "Gerar informa��es da empresa;"  + ;
                   "" + _EMP + ";" + ;
                   " IE: " + SWSet( _SIN_IE ), { "Sim", "Nao" } ) == 1
        Relatorio( "SINTEGRA.REP" )
     ENDIF

Function SintExporta()
     nOpcao:= SWAlerta( "Gerar informa��es da empresa;"  + ;
                   "" + _EMP + ";" + ;
                   " IE: " + SWSet( _SIN_IE ), { "A", "B", "C", "D" } )
     IF nOpcao == 1
        Relatorio( "SINTEXP1.REP" )
     ENDIF




Function CarregaCampo( cCampo )
Local Result
Priv cConteudo
   DBSelectAr( "TMP" )
   DBGoTop()
   WHILE !EOF()
      IF AT( UPPER( cCampo ), SubStr( UPPER( ORIGEM ), 1, AT( "=", UPPER( ORIGEM ) )-2 ) ) > 0
         Result:= SubStr( ORIGEM, at( "=", UPPER( ORIGEM ) ) + 1 )
         cConteudo:= Result
         Result:= &cConteudo
         EXIT
      ENDIF
      TMP->( DBSkip() )
   ENDDO
   // PREPARA RESULT PARA RETORNAR
   IF VALTYPE( Result ) == "N"
      Result:= Str( Result )
   ELSEIF VALTYPE( Result ) == "D"
      Result:= DTOC( Result )
   ELSEIF Result = Nil
      Result:= "Nil"
   ENDIF
   Return Result


Function GravaCampo( cConteudo )
   TMP->( DbAppend() )
   Replace TMP->ORIGEM with cConteudo
   DBCommitAll()


function ProdCriaLista()
   DBSelectAr( 126 )
   DBCreate( "TEMP\LISTA.DBF", { { "CODRED", "C", 07, 0 },;
                                 { "DESCRI", "C", 50, 0 },;
                                 { "UNIDAD", "C", 02, 0 } } )

   USE TEMP\LISTA.DBF ALIAS LIS
   INDEX ON CODRED TO TEMP\INDEE293
Return Nil


function ProdExiste()
   IF TRIM( PNF->CODRED )=="1200025"
      SET( 20, "SCREEN" )
      IF ( LIS->( DBSeek( SUBSTR( PNF->CODRED, 1, 7 ) ) ) ) 
         Mensagem( "ERRO! Produto j� existente na tabela" )
      ELSE
         Mensagem( "ERRO! Produto nao encontrado na tabela, incluir na lista" )
      ENDIF
      INKEY(0)
      SET( 20, "PRINTER" )
   ENDIF
   Return ( LIS->( DBSeek( SUBSTR( PNF->CODRED, 1, 7 ) ) ) )

function ProdDiferente()
   Return ( !( TRIM( PNF->DESCRI ) == TRIM( LIS->DESCRI ) ) .OR.;
            !( TRIM( PNF->UNIDAD ) == TRIM( LIS->UNIDAD ) )     ;
          )

function ProdGrava()
   SET( 20, "SCREEN" )
   LIS->( DBAppend() )
   Replace LIS->CODRED With SUBSTR( PNF->CODRED, 1, 7 ),;
           LIS->DESCRI With PNF->DESCRI,;
           LIS->UNIDAD With PNF->UNIDAD
   Set( 20, "PRINTER" )
   Return Nil


Function NotaMesclada( nNota )
Local nRegNF_:= NF_->( RECNO() ), nRegPNF:= PNF->( RECNO() )
   IF NF_->( DBSeek( nNota ) )
      PNF->( DBSeek( nNota, .T. ) )
      IF NF_->ISSQNB > 0 .AND. ( nf_->VLRTOT <> nf_->ISSQNB )
         nf_->( dbGOTO( nRegNF_ ) )
         pnf->( dbGOTO( nRegPNF ) )
         Return .T.
      ELSE
         nf_->( dbGOTO( nRegNF_ ) )
         pnf->( dbGOTO( nRegPNF ) )
         Return .F.
      ENDIF
   ENDIF
   Return .F.


Function SintEdResumo()
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local Tecla, oTab 

   // Abrir base
   DBSelectAr( 123 )
   cFile:= gDir - "\resumo.dbf"
   #ifdef HARBOUR
    cFile:= gDir - "/resumo.dbf"
   #endif
   NetUse(  cFile, ( 2==1 ), 1, "RES", .F.  )
   Index On DTOS( DATAEM ) + STR( REGIST ) to Ind20422 

   // Exibir Browse
   VPBOX( 02, 02, 20, 77, "RELACAO DE MOVIMENTOS - REDUCAO Z", _COR_BROW_BOX )
   SetColor( _COR_BROWSE )
   oTab:= tbrowsedb( 03, 03, 19, 76 )                                     
   oTab:addcolumn(tbcolumnnew("Data   Registro Operacao   Aliq    Venda      Base    Isento   Outros  Vlr.Icm",{|| DTOC( DATAEM ) + " " + STRZERO( REGIST, 6, 0 ) + " " + StrZero( OPERAC, 6, 0 ) + ;
               Tran( PERICM, "@e 999.99" ) + " " + Tran( VENDA_, "@e 9999,999.99" ) + " " + ;
               Tran( BASICM, "@e 999,999.99" ) + " " + ;
               Tran( ISENTO, "@e 999,999.99" ) + " " + ;
               Tran( OUTROS, "@e 999,999.99" ) + " " + ;
               Tran( VLRICM, "@e 99,999.99" ) } ))
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      TECLA:=inkey(0) 
      If TECLA=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case TECLA==K_UP         ;oTab:up() 
         case TECLA==K_LEFT       ;oTab:up() 
         case TECLA==K_RIGHT      ;oTab:down() 
         case TECLA==K_DOWN       ;oTab:down() 
         case TECLA==K_PGUP       ;oTab:pageup() 
         case TECLA==K_PGDN       ;oTab:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
         case TECLA==K_ENTER
              SinResEditar()
         case DBPesquisa( TECLA, oTab ) 
         case TECLA==K_INS
              DBAppend()
              SinResEditar()
         case TECLA==K_F2
              DBMudaOrdem( 1, oTab ) 
         case TECLA==K_F3 
              DBMudaOrdem( 2, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   DBCloseArea()
   DBSelectAr( nArea )
   DBSetOrder( nOrdem ) 
   Setcolor(   cCOR  ) 
   Setcursor(  nCURSOR ) 
   Screenrest( cTELA ) 
Return Nil

Function SinResEditar()
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 

Local  dDataEm:= DATAEM,;
       nBasIcm:= BASICM,;
       nPerICm:= PERICM,;
       nReduc_:= REDUC_,;
       nRegist:= REGIST,;
       nOperac:= OPERAC,;
       nIsento:= ISENTO,;
       nOutros:= OUTROS,;
       nVenda_:= VENDA_,;
       nVlrIcm:= VLRICM

       VPBox( 04, 08, 16, 55, "REGISTROS", _COR_GET_BOX )
       SetColor( _COR_GET_EDICAO )
       @ 05, 11 Say "Registro.....:" Get nRegist
       @ 06, 11 Say "Data.........:" get dDataEm
       @ 07, 11 Say "Aliquota.....:" get nPerIcm
       @ 08, 11 Say "Operacao.....:" get nOperac
       @ 09, 11 Say "-------------------------------------------"
       @ 10, 11 Say "Venda........:" Get nVenda_
       @ 11, 11 Say "Base de ICMs.:" Get nBasIcm
       @ 12, 11 Say "Isento.......:" Get nIsento
       @ 13, 11 Say "Outros.......:" Get nOutros
       @ 14, 11 Say "Vlr.ICMs.....:" Get nVlrIcm
       READ
       RLOCK()
       Replace DATAEM with dDataEm,;
               BASICM with nBasIcm,;
               PERICM with nPerICm,;
               REDUC_ with nReduc_,;
               REGIST with nRegist,;
               OPERAC with nOperac,;
               ISENTO with nIsento,;
               OUTROS with nOutros,;
               VENDA_ with nVenda_,;
               VLRICM with nVlrIcm

   Setcolor(   cCOR  )
   Setcursor(  nCURSOR ) 
   Screenrest( cTELA ) 







