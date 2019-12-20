
#include "formatos.ch"

REQUEST DBFCDX
REQUEST DBFNTX

*���������������������������*
* FORTUNA
* SISTEMA DE CONTROLE DE ESTOQUE
* Programador - Valmor Pereira Flores
* 10/Outubro/1994
*�����������������������������������������������������������������������������*

*
* Modulo      - VPC00000
* Descricao   - Criacao do menu principal
* Programador - Valmor Pereira Flores
* Data        - 10/Outubro/1994
* Atualizacao -
*
#include "vpf.ch"
#include "inkey.ch"


#ifdef HARBOUR
function vpc00000()
#endif

Local nOpcao:= 0

memvar MENULIST


IF ( nGCodUser == 0 .OR. nGCodUser == 999 ) .AND. cUserCode == Nil
   WHILE !( nOpcao==1 .OR. nOpcao==2 )
       VPBox( 04, 07, 21, 70, " Administrador Geral ", _COR_GET_BOX )
       VPBox( 09, 09, 19, 40, , _COR_GET_BOX, .F., .F. )
       SetColor( _COR_GET_EDICAO )
       @ 06,09 Say Alltrim( _EMP )
       @ 07,09 Say _SIS
       @ 10,10 Prompt " Acessar Sistema              "
       @ 11,10 SAY    "������������������������������"
       @ 12,10 Prompt " Configuracao de Poderes      "
       @ 13,10 SAY    "������������������������������"
       @ 14,10 Prompt " Usuarios                     "
       @ 15,10 SAY    "������������������������������"
       @ 16,10 Prompt " Gerador de Relatorios        "
       @ 17,10 SAY    "������������������������������"
       @ 18,10 Prompt " Finalizar Sistema            "
       Menu To nOpcao
       DO CASE
          CASE nOpcao == 1
          CASE nOpcao == 2
               SWSet( _SYS_CONFIGSENHAS, .T. )
               SetConfig()
               ConfiguraSenhas()
               _EMP:= "CONFIGURACAO DE PODERES UTILIZANDO GRUPO N� " + StrZero( nCodUser, 3, 0 )
               ScreenBack:= " Configuracao    Soft&Ware "
               SWSet( _GER_BARRAROLAGEM, .F. )
               VPTela()
               WTELA:=zoom(05,02,14,21)
               vpbox(05,02,15,21)
               titulo(_EMP)
               usuario( "[F1] Salvar Poderes" )
               XCONFIG:= .F.
          CASE nOpcao == 3
               DisplayUsuarios()
          CASE nOpcao == 4
               SBRes:= ScreenBack
               ScreenBack:= " Gerador de Relatorios    Soft&Ware "
               lBR:= SWSet( _GER_BARRAROLAGEM )
               SWSet( _GER_BARRAROLAGEM, .F. )
               VPTela()
               Titulo(_EMP)
               VPTela()
               Usuario( " S&W Report System " )
               Maximo()
               Usuario( wUsuario )
               ScreenBack:= SBRes
               SWSet( _GER_BARRAROLAGEM, lBR )
          CASE nOpcao == 5
               Fim()
      ENDCASE
   ENDDO
   nOpcao:= 1
ENDIF
SETBLINK(.F.)
IF AT( "Soft&Ware", MenBarraRolagem ) == 0
   MenBarraRolagem:= " INSTALACAO NAO AUTORIZADA - Software de Demonstracao     (Ligue 051-334.3225)  "
ENDIF



IF AT( "Demonstracao", _FORTUNA_ ) > 0

   VPBox( 02, 02, 20, 74, "Demonstracao do Sistema", _COR_GET_BOX, .F., .F. )
   SetColor( _COR_GET_EDICAO )

   @ 04,07 Say "Bem-vindo ao universo de produtos Fortuna" Color "14/" + CorFundoAtual()
   @ 05,07 Say "Esta versao do sistema destina-se a demonstracao dos"
   @ 06,07 Say "recursos do sistema FORTUNA de Automacao Comercial. "

   @ 16,07 Say PADR( "Equipe Fortuna", 50 )
   inkey(0)
   _EMP:= "EMPRESA DEMONSTRACAO"
   VPTELA()

ENDIF



whil .t.
   //TROCAFONTE(.T.)
   limpavar()
   if XCONFIG
      setcolor("00/00")
      SetConfig()
      vptela()
      WTELA:=zoom(05,02,15,21)
      vpbox(05,02,15,21)

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
//      IF SWSet( _SYS_MOUSE )
//         IF MOUSEINSTALLED()
//            MOUSERESET()
//            MOUSECSHOW()
//         ENDIF
//      ENDIF
   endif
   nLIN:=0
   mensagem("")
   ajuda("["+_SETAS+"]Movimenta [ENTER]Executa")
   SetColor( COR[12] + "," + COR[13] )

   LiberaMemoria()
   MenuList:= {}
   SetOpcao( MenuList, 0 )
   Set( _SET_DELIMITERS, .T. )
   aadd( MENULIST, menunew(06,03," 1 Utilitarios   ",2,COR[11],;
        "Organizacao de arquivos e configuracoes gerais do sistema.",,,COR[6],.F.))
   aadd( MENULIST, menunew(07,03," 2 Cadastro      ",2,COR[11],;
        "Cadastros em geral.",,,COR[6],.F.))
   aadd( MENULIST, menunew(08,03," 3 Estoque       ",2,COR[11],;
        "Controle de estoque.",,,COR[6],.F.))
   aadd( MENULIST, menunew(09,03," 4 Compras       ",2,COR[11],;
        "Controle de compras.",,,COR[6],.F.))
   aadd( MENULIST, menunew(10,03," 5 Vendas        ",2,COR[11],;
        "Controle de vendas.",,,COR[6],.F.))
   aadd( MENULIST, menunew(11,03," 6 Financeiro    ",2,COR[11],;
        "Movimento geral de ctas. a pagar e ctas a receber.",,,COR[6],.F.))
   aadd( MENULIST, menunew(12,03," 7 Servicos      ",2, COR[11],;
        "Emissao de relatorios diversos.",,,COR[6],.F.))
   aadd( MENULIST, menunew(13,03," 8 Relatorios    ",2,COR[11],;
        "Emissao de relatorios diversos.",,,COR[6],.F.))
   aadd( MENULIST, menunew(14,03," 0 Encerramento  ",2,COR[11],;
        "Execucao da finalizacao do programa.",,,COR[6],.F.))
   menumodal(MENULIST,@nOPCAO); MENULIST:={}
   do case
      case nOPCAO=9 .OR. ( LastKey() == K_ESC .AND. cConfirmaSaida == "SIM" )
           IF cConfirmaSaida == "SIM"
              IF ( nOp:= SWAlerta( "Finalizacao do Sistema FORTUNA de Automacao Comercial; O que voce deseja fazer?",;
                 { " Sair ", " Trocar Operador ", " Continuar " } ) ) == 1
                 EXIT
              ELSEIF nOp==2
                 SetCursor( 0 )

                 cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                 Dispbegin()

                 VPTela()
                 vpbox(04,02,19,73," Acesso Principal ",COR[16],.t.,.t.,COR[15])
                 vpbox(09,04,11,21,,COR[16],.f.,.f.,COR[16])
                 vpbox(06,04,08,21,,COR[16],.f.,.f.,COR[16])
                 vpbox(06,23,08,71,,COR[16],.f.,.f.,COR[16])
                 vpbox(09,23,18,71," Informacoes ",COR[16],.f.,.f.,COR[15])
                 vpbox(12,04,18,21,,COR[16],.f.,.f.,COR[16])
                 vpbox(13,06,17,19,,COR[16],.f.,.f.,COR[16])
                 vpbox(14,08,16,17,,COR[16],.f.,.f.,COR[16])
                 SetColor( COR[16] )
                 @ 10,08 say "["+dtoc( DATE() )+"]"
                 @ 10,25 say _SIS
                 @ 11,25 say "Suporte a Arquivos Microsoft Office (Via-RTF)"
                 @ 12,25 say "Diretorio Corrente...: " + Right( Curdir(), 23 )
                 @ 13,25 say "Diretorio de Pesquisa: " + Right( GDir, 23 )
                 @ 14,25 say "Driver de Arquivos...: " + RDDSetDefault()
                 @ 07,06 say "Codigo.: [  0]"
                 cTelaR2:= ScreenSave( 0, 0, 24, 79 )

                 aTelares:= {}
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
                 ScreenRest( cTelaRes )
                 DispEnd()

                 nCol:= 0
                 nCt2:= 1
                 nCt2:= Len( aTelaRes ) - 1   //AQUI
                 FOR nCt:=1 TO 8
                     cTelaX:=SaveScreen( 00, nCol, 24, 69 )
                     DispBegin()
                     inkey(.05)
                     nCol+=10
                     SetColor( "15/00" )
                     Scroll( 00, 00, 24, 79 )
                     IF nCt2 > 0 .AND. nCt2 < Len( aTelaR2 )
                          restscreen( 00, 00, 24, nCol, aTelaRes[ nCt2 ] )
                          nCt2:= nCt2 - 1
                     ENDIF
                     RestScreen( 00, nCol, 24, 79, cTelaX )
                     DispEnd()
                 NEXT
                 ScreenRest( cTelaR2 )
                 WUSUARIO:= vpsenha()
                 xFile:= SWSet( _SYS_DIRREPORT ) - _PATH_SEPARATOR + "senhas." + cUserGrupo
                 IF File( xFile )
                    Copy File &xFile To senhas.sys
                    GuardaPoderes( {} )
                 ELSE
                    cTelaRS:= ScreenSave( 0, 0, 24, 79 )
                    Aviso( "Senhas Nao Disponiveis para este grupo de Usuarios" )
                    Pausa()
                    ScreenRest( cTelaRS )
                    Release cTelaRS
                 ENDIF
                 ScreenRest( cTelaRes )
                 Usuario( WUSUARIO )
                 SetCursor( 1 )
                 nOpcao:= 1

              ENDIF
           ELSE
              EXIT
           ENDIF
      case nOPCAO=1; VPC10000()
      case nOPCAO=2; cadastro()
      case nOPCAO=3; VPC69999()
      case nOPCAO=4; VPC50000()
      case nOPCAO=5; VPC90000()
      case nOPCAO=6; VPC91000()
      case nOPCAO=7; VPCPRODU()
      case nOPCAO=8; VPC99999()
   endcase
enddo
/* mouseCHide()    */
/* TrocaFonte(.F.) */
Guardiao( "<FIM> Finalizacao do sistema �����������������������������" )
fim()

/*
*      Funcao - CADASTROS
*  Finalidade - Exibir menu de cadastros
*        Data -
* Atualizacao -
*/
stat func cadastro()
  loca cTela, cCOR:=setcolor(), nOPCAO:=0
  loca nLin:=7, nCol:=15
  cTela:= Zoom( 8-1, 15-1, 8 + 11, 15 + 25 )
  VPBox( 8-1, 15-1, 8 + 11, 15 + 25 )
  MenuList:= 0
  MenuList:= {}
  whil .t.
    MenuList:= 0
    MenuList:= {}
    aadd( MENULIST, MenuNew( 08, 15, " 1 Clientes             ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de clientes."            ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 09, 15, " 2 Fornecedores         ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de fornecedores."        ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 10, 15, " 3 Produtos e Servicos  ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de produtos."            ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 11, 15, " 4 Origem / Fabricantes ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de origens."             ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 12, 15, " 5 Vendedores           ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de vendedores."          ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 13, 15, " 6 Classificacao fiscal ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de classificacao fiscal.",,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 14, 15, " 7 Banco/Agen/Contas    ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de bancos/agencias/contas.",,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 15, 15, " 8 Transportadoras      ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de transportadores."     ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 16, 15, " 9 Ficha de Movimentos  ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de contas."              ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 17, 15, " A Tabelas              ", 2, COR[11],"Tabelas de ICMs / Estados / Historicos, etc."                        ,,, COR[6], .T. ) )
    aadd( MENULIST, MenuNew( 18, 15, " 0 Retorna              ", 2, COR[11],"Retorna ao menu anterior.",,,COR[6],.T.))
     mensagem("")
     menumodal(MENULIST,@nOPCAO); MENULIST:= {}
     IF nOPCAO=0 .or. nOPCAO=11
        exit
     ENDIF
     do case
        case nOPCAO=1;  VPC40000()
        case nOPCAO=2;  VPC31000()
        case nOPCAO=3;  VPC21000()
        case nOPCAO=4;  VPC25000()
        case nOPCAO=5;  VPC51100()
        case nOPCAO=6;  clasfiscal()       && Modulo: VPC26100
        case nOPCAO=7;  banco()            && Modulo: VPC80000
        case nOPCAO=8;  VPC26000()
        case nOPCAO=9;  VPC70000()
        case nOPCAO=10; Tabelas()
     endcase
  enddo
  MenuList:= 0
  MenuList:= {}
  unzoom(cTELA)
  setcolor(cCOR)
return nil


/*****
�������������Ŀ
� Funcao      � TABELAS
� Finalidade  � menu de acesso ao cadastro de tabelas
� Parametros  � nil
� Retorno     � nil
� Programador � Valmor Pereira Flores
� Data        � 14/Fevereiro/1998
���������������
*/
FUNCTION Tabelas()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nOpcao:= 1

  /* Limpa Tela */
  lBarra:= SWSet( _GER_BARRAROLAGEM )
  SWSet( _GER_BARRAROLAGEM, .F. )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen()
  Fortuna()

cTela1:= Zoom( 02, 30, 20, 54 )
VPBox( 02, 30, 20, 54 )

WHILE .T.

    /* Preparacao do Menu */
    AAdd( MENULIST, MenuNew( 03, 31, " 1 ICMs & Reducoes    ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de tabela de [ICMs/Reducao]..."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 04, 31, " 2 Feriados Nacionais ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de feriados do ano."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 05, 31, " 3 Atividades         ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de atividades." , , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 06, 31, " 4 Nat. de Operacao   ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de natureza de operacao." , , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 07, 31, " 5 Estados            ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de estados." , , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 08, 31, " 6 Hist�ricos (Cobr)  ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de hist�ricos." , , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 09, 31, " 7 Precos             ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de tabelas de precos.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 10, 31, " 8 Comissoes (%)      ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de tabelas de % de comissoes.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 11, 31, " 9 Formas de Pagamento", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de tabela de forma de Pagamento.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 12, 31, " A Operacoes          ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de tabela de Operacoes com Estoque.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 13, 31, " B Observacoes (NF)   ", 2, COR[11],"Inclusao, alteracao, verificacao e exclusao de tabela de observacoes na nota fiscal.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 14, 31, " C Setores            ", 2, COR[11],"Inclus�o, Altera��o, Verifica��o e Exclus�o de tabela de Setores da Empresa.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 15, 31, " D Classes            ", 2, COR[11],"Inclus�o, Altera��o, Verifica��o e Exclus�o de tabela de Classes.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 16, 31, " E Cores              ", 2, COR[11],"Inclus�o, Altera��o, Verifica��o e Exclus�o de tabela de Cores.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 17, 31, " F Garantia/Validade  ", 2, COR[11],"Inclus�o, Altera��o, Verifica��o e Exclus�o de tabela de Garantia/Validade Produto.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 18, 31, " H Mais Tabelas...    ", 2, COR[11],"Menu com mais tabelas.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 19, 31, " 0 Retorna            ", 2, COR[11],"Retorna ao menu anterior." , , , COR[6], .T. ) )

    MenuModal(MenuList,@nOpcao); MenuList:= {}

    /* Teste da opcao selecionada */
    DO CASE
       CASE nOpcao==17 .OR. LastKey() == K_ESC
            Exit
       CASE nOpcao=1 ; VPC29700()
       CASE nOpcao=2 ; VPC91320()
       CASE nOPCAO=3 ; VPC87500()
       CASE nOpcao=4 ; NatOpera()
       CASE nOpcao=5 ; VPC87600()
       CASE nOpcao=6 ; VPC87700()
       CASE nOpcao=7 ; MenuPrecos()
       CASE nOpcao=8 ; MenuComissoes()
       CASE nOpcao=9 ; VPC28800()
       CASE nOpcao=10; VPC35400()
       CASE nOpcao=11; VPC35600()
       CASE nOpcao=12; VPC88100()
       CASE nOpcao=13; VPC88200()
       CASE nOpcao=14; VPC88300()
       CASE nOpcao=15; VPC87970()
       CASE nOpcao=16; MaisTabelas()
    ENDCASE
ENDDO
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
SWSet( _GER_BARRAROLAGEM, lBarra )
Return Nil


/*



*/
FUNCTION MaisTabelas()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 3, 0, 24, 79 )
Local nOpcao:= 1

cTela1:= Zoom( 15, 44, 21, 68 )
VPBox( 15, 44, 21, 68 )

WHILE .T.

    /* Preparacao do Menu */
    AAdd( MENULIST, MenuNew( 16, 45, " 1 Moedas             ", 2, COR[11],"Inclus�o, Altera��o, Verifica��o e Exclus�o de tabela de Moedas.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 17, 45, " 2 Variacao Cambial   ", 2, COR[11],"Inclus�o, Altera��o, Verifica��o e Exclus�o de tabela de Variacoes.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 18, 45, " 3 Criterio/Clientes  ", 2, COR[11],"Estabelece criterios p/ selecao de clientes.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 19, 45, " 4 Tipo de Contato    ", 2, COR[11],"Tipo de Contato com clientes.", , , COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 20, 45, " 0 Retorna            ", 2, COR[11],"Retorna ao menu anterior." , , , COR[6], .T. ) )
    MenuModal( MenuList, @nOpcao ); MenuList:= {}

    /* Teste da opcao selecionada */
    DO CASE
       CASE nOpcao==5 .OR. LastKey() == K_ESC
            Exit
       CASE nOpcao==01; VPC35700()
       CASE nOpcao==02; VPC35800()
       CASE nOpcao==03; VPC37100()
       CASE nOpcao==04; VPC37200()
    ENDCASE
ENDDO
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil



/*****
�������������Ŀ
� Funcao      � MENUPRECOS
� Finalidade  � menu de acesso ao cadastro de precos
� Parametros  � nil
� Retorno     � nil
� Programador � Valmor Pereira Flores
� Data        � 14/Fevereiro/1998
���������������
*/
FUNCTION MenuPrecos()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 3, 0, 24, 79 )
Local nOpcao:= 1

cTela1:= Zoom( 13, 44, 20, 68 )
VPBox( 13, 44, 20, 68 )

WHILE .T.

    /* Preparacao do Menu */
    AAdd( MENULIST, MenuNew( 14, 45, " 1 Tab. Padrao        ", 2, COR[11],"Tabela de Precos de venda Padr�o..."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 15, 45, " 2 Tab. Diferenciadas ", 2, COR[11],"Tabela de Precos de venda diferenciado."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 16, 45, " 3 Produto x Tabela   ", 2, COR[11],"Lista de Produtos e Margem conforme tabela."     ,,, COR[6], .T. ) )
    @ 17,45 Say "���������������������"
    AAdd( MENULIST, MenuNew( 18, 45, " 4 Copia Tabela       ", 2, COR[11],"Faz um copia da tabela de precos."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 19, 45, " 0 Retorna            ", 2, COR[11],"Retorna ao menu anterior." , , , COR[6], .T. ) )
    MenuModal(MenuList,@nOpcao); MenuList:= {}

    /* Teste da opcao selecionada */
    DO CASE
       CASE nOpcao==6 .OR. LastKey() == K_ESC
            Exit
       CASE nOpcao==1; VPC35100()
       CASE nOpcao==2; VPC35200()
       CASE nOpcao==3; VPC35500()
       CASE nOpcao==4; VPC36600()
    ENDCASE
ENDDO
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil


/*****
�������������Ŀ
� Funcao      � MENUCOMISSOES
� Finalidade  � menu de acesso ao cadastro de COMISSOES
� Parametros  � nil
� Retorno     � nil
� Programador � Valmor Pereira Flores
� Data        � 14/Fevereiro/1998
���������������
*/
FUNCTION MenuComissoes()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 3, 0, 24, 79 )
Local nOpcao:= 1
cTela1:= Zoom( 18, 44, 22, 68 )
VPBox( 18, 44, 22, 68 )
WHILE .T.
    /* Preparacao do Menu */
    AAdd( MENULIST, MenuNew( 19, 45, " 1 Percentuais        ", 2, COR[11],"Tabela de Percentuais de Comissoes..."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 20, 45, " 2 Formulas Calculos  ", 2, COR[11],"Tabela de Formulas de Calculos de Comissoes."     ,,, COR[6], .T. ) )
    AAdd( MENULIST, MenuNew( 21, 45, " 0 Retorna            ", 2, COR[11],"Retorna ao menu anterior." , , , COR[6], .T. ) )
    MenuModal(MenuList,@nOpcao); MenuList:= {}

    /* Teste da opcao selecionada */
    DO CASE
       CASE nOpcao==3 .OR. LastKey() == K_ESC
            Exit
       CASE nOpcao==1; VPC28600()
       CASE nOpcao==2; VPC28700()
    ENDCASE
ENDDO
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil


/*
Funcao     - ConfigDefault
Finalidade - Set das configuracoes default do sistema
*/
Function ConfigDefault()

  Return .T.



