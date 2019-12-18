// ## CL2HB.EXE - Converted
#Include "BOX.CH" 
#Include "VPF.CH" 
#Include "INKEY.CH" 
#Include "PTFUNCS.CH" 
#Include "PTVERBS.CH" 
 
/* 
* 
*      Funcao - CFGMASC 
*  Finalidade - Exibir os modulos que possuem configuracao e efetuar chamadas 
*               as rotinas de edicao de configuracao. 
* Programador - Valmor Pereira Flores 
*        Data - 01/Novembro/1994 
* Atualizacao - 15/Novembro/1994 
* 
*/ 
func cfgmasc() 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca oTAB,mOP:={}, WLOCALIZ:=0, cTELAR, nROW:=1, cCorRes, lMouseStatus 
  priv nMOD:=1           //* Variaveis para controle de fluxo entre os modulos   *// 
  priv nCMOD:=nXCMOD:=-1 //* Idem ^                                              *// 
 
  //* CRIAR ARQUIVO DE CONFIGURACAO, CASO NAO EXISTA E COLOCA-LO EM USO *// 
  if(!file(_VPB_CONFIG),createvpb(_COD_CONFIG),nil) 
  if !fdbusevpb(_COD_CONFIG,2) 
     aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_CONFIG)+".",24/2) 
     mensagem("Erro na abertura do arquivo de configuracao, tente novamente...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  //* FORMATACAO DA TELA *// 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  usermodulo("PARAMETROS DO SISTEMA") 
  vpbox(01,01,24-2,79-1,"",COR[16],.F.,.F.,COR[19]) 
  setcolor(COR[20]) 
  VPBox( 01, 0, 24-2, 22, , _COR_GET_BOX, .f., .f., ,.f. ) 
  setcolor( _COR_GET_EDICAO ) 
  setcursor(0) 
  mensagem("Pressione [ENTER][TAB] para selecionar ou [ESC] para retornar.") 
  AADD( mOP, { 99, "°°±±²² FORTUNA ²²±±°°" } ) 
  AADD( mOP, { 1,  "ÃÄCadastros          " } ) 
  AADD( mOP, { 11, "³ ÃÄClientes         " } ) 
  AADD( mOP, { 12, "³ ÃÄFornecedores     " } ) 
  AADD( mOP, { 13, "³ ÃÄProdutos         " } ) 
  AADD( mOP, { 14, "³ ÃÄBancos           " } ) 
  AADD( mOP, { 141,"³ ³ ÀÄBanrisul       " } ) 
  AADD( mOP, { 15, "³ ÀÄVendedores       " } ) 
  AADD( mOP, { 2,  "ÃÄEstoque            " } ) 
  AADD( mOP, { 3,  "ÃÄCompras (O.C.)     " } ) 
  AADD( mOP, { 4,  "ÃÄVenda              " } ) 
  AADD( mOP, { 41, "³ ÃÄPedido           " } ) 
  AADD( mOP, { 42, "³ ÀÄNota Fiscal      " } ) 
  AADD( mOP, { 5,  "ÃÄFinanceiro         " } ) 
  AADD( mOP, { 51, "³ ÃÄComissoes        " } ) 
  AADD( mOP, { 52, "³ ÀÄBloquetos        " } ) 
  AADD( mOP, { 6,  "ÃÄRelatorios         " } ) 
  AADD( mOP, { 61, "³ ÃÄClientes         " } ) 
  AADD( mOP, { 62, "³ ÃÄProdutos         " } ) 
  AADD( mOP, { 63, "³ ÃÄEstoque          " } ) 
  AADD( mOP, { 64, "³ ÃÄContas a Pagar   " } ) 
  AADD( mOP, { 65, "³ ÀÄContas a Receber " } ) 
  AADD( mOP, { 0,  "ÃÄGeral              " } ) 
  AADD( mOP, { 100,"ÀÄMeu Computador     " } ) 
  AADD( mOP, { 110,"  ÃÄMouse            " } ) 
  AADD( mOP, { 120,"  ÃÄProtecao de tela " } ) 
  AADD( mOP, { 121,"  ³ ÃÄPadrao         " } ) 
  AADD( mOP, { 122,"  ³ ÀÄNavegador      " } ) 
  AADD( mOP, { 130,"  ÃÄBarra de Rolagem " } ) 
  AADD( mOP, { 140,"  ÃÄMonitor          " } ) 
  AADD( mOP, { 160,"  ÃÄAtualizacao      " } ) 
  AADD( mOP, { 150,"  ÀÄPortas Impressao " } ) 
  oTAB:=tbrowsenew(02,01,24-3,21) 
  oTAB:addcolumn(tbcolumnnew(,{|| mOP[nROW][2]})) 
  oTAB:AUTOLITE:=.f. 
  oTAB:GOTOPBLOCK:={|| nROW:=1} 
  oTAB:GOBOTTOMBLOCK:={|| nROW:=len(mOP)} 
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,mOP,@nROW)} 
  oTAB:dehilite() 
  whil .t. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and. ! oTAB:stabilize() 
     enddo 
     nMOD=mOP[nROW][1] 
 
     IF !nMod==99 
        lMouseStatus:= MouseStatus() 
        DesligaMouse() 
        Informacoes( nMod ) 
        modulo( nMod ) 
     elseif nMod==99 
        DispBegin() 
        vpbox(01,23,22,79,,"15/09",.F.,.F.,"09/15", .F.) 
        SetColor( "15/09" ) 
        @ 03, 25 Say " Sistema " + ALLTRIM( _VER ) 
        @ 05, 25 Say " Licenciado para " + ALLTRIM( _EMP ) 
        @ 07, 25 Say " EVOLUTIVA °°°°°°±±±±±±²²²²²²²²²²²³³³³³³³³ÛÛÛÛÛÛÛÛÛÛÛÛÛÛ" 
        @ 07, 25 Say " EVOLUTIVA Sistemas de Gestao Empresarial        " Color "14/09" 
        @ 08, 25 Say "  Av. Protasio Alves, 5040                       " 
        @ 09, 25 Say "  Petropolis      - Porto Alegre/RS              " 
        @ 10, 25 Say "  CGC/MF 00.000.000/0001-01                      " 
        @ 12, 25 Say " Suporte Tecnico: (0xx51-3383.0583)              " 
 
        @ 14, 25 Say " Principais Colaboradores                        " 
        @ 15, 25 Say "                                                 " Color "14/09" 
 
        @ 17, 25 Say " Projeto & Desenvolvimento                       " 
        @ 18, 25 Say "  VALMOR PEREIRA FLORES                          " Color "14/09" 
 
        @ 20, 25 Say " Comercializacao & Marketing                     " 
        @ 21, 25 Say "  FORTUNA AUTOMACAO COMERCIAL LTDA               " Color "14/09" 
 
        DispEnd() 
     endif 
     LigaMouse( lMouseStatus ) 
 
 
     TECLA:=inkey(0) 
     if TECLA==K_ESC ;exit ;endif 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_TAB .OR. TECLA==K_ENTER 
             lMouseStatus:= MouseStatus() 
             DesligaMouse() 
             cTELAR:=screensave(01,01,24-2,20) 
             cCorRes:= SetColor() 
             SetColor( _COR_BROW_BOX ) 
             oTab:ColorSpec:= _COR_BROW_BOX 
             oTab:RefreshAll() 
             WHILE !oTab:Stabilize() 
             ENDDO 
             DISPBOX( 01, 00, 24-2, 22, Alltrim( _BOX_UM ) ) 
             editar() 
             oTab:ColorSpec:= _COR_GET_EDICAO 
             SetColor( cCorRes ) 
             screenrest(cTELAR) 
             SetColor( _COR_GET_EDICAO ) 
             VPBox( 01, 0, 24-2, 22, , _COR_GET_BOX, .f., .f., ,.f. ) 
             oTab:RefreshAll() 
             WHILE !oTab:Stabilize() 
             ENDDO 
             IF SWSet( _SYS_MOUSE ) 
                LigaMouse( lMouseStatus ) 
             ENDIF 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  enddo 
  GravaSWSet() 
  screenrest(cTELA) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
return(if(TECLA=27,.f.,.t.)) 
 
/* 
* 
*      Funcao - INFORMACOES 
*  Finalidade - Exibir informacoes a respeito do respectivo GET 
*  Parametros - nPMOD=> Codigo da mensagem a exibir cfe. variavel editada 
* Programador - ValmorPF 
*     Retorno - .T. 
*        Data - 16/Novembro/1994 
* Atualizacao - 
* 
*/ 
stat func informacoes(nPMOD) 
  loca aINFORMACOES:= Nil 
 
  do case 
 
     case nPMOD=13 
          aINFORMACOES:={" Configuracao de cadastro de produtos do sistema.      ",; 
                         " Permite que voce configure se deseja ou nao utilizar  ",; 
                         " determinados campos do cadastro.                      ",; 
                         "                                                       "} 
     case nPMOD=141 
          aINFORMACOES:={" Configuracao de informacoes referentes ao Banrisul.   ",; 
                         " Permite que voce configure o codigo de convenio que a ",; 
                         " empresa mantem com o Banrisul para remessa de informa-",; 
                         " coes de debito automatico."} 
     case nPMOD=100 
          aINFORMACOES:={" Configuracao referente ao seu computador.             ",; 
                         " As informacoes contidas neste grupo de configuracao   ",; 
                         " nao severao afetar ou demais computadores, caso esteja",; 
                         " trabalhando em uma conexao de rede.                   "} 
 
     case nPMOD=110 
          aINFORMACOES:={" Configuracoes de seu mouse.                           ",; 
                         "                                                       ",; 
                         "                                                       ",; 
                         "                                                       "} 
     case nPMOD=120 .OR. nPMod==122 .OR. nPMod==123 
          aINFORMACOES:={" Configuracoes de protecao de tela.                    ",; 
                         "                                                       ",; 
                         "                                                       ",; 
                         "                                                       "} 
     case nPMOD=130 
          aINFORMACOES:={" Configuracoes da barra de rolagem ao topo da tela     ",; 
                         "                                                       ",; 
                         "                                                       ",; 
                         "                                                       "} 
     case nPMOD=140 
          aINFORMACOES:={" Configuracoes do Tipo de Monitor Utilizado.           ",; 
                         "                                                       ",; 
                         "                                                       ",; 
                         "                                                       "} 
     case nPMOD=150 
          aINFORMACOES:={" Configuracoes das portas de impressao do sistema.     ",; 
                         " Esta opcao afeta diretamente aos relatorio do sistema,",; 
                         " portanto e importante que voce consulte o administra- ",; 
                         " dor da Rede ates de fazer alguma alteracao.           "} 
     case nPMOD=160 
          aINFORMACOES:={" Sistematica de Atualizacao do Sistema neste terminal. ",; 
                         "                                                       ",; 
                         "                                                       ",; 
                         "                                                       "} 
     Otherwise 
          IF !( nPMOD == 99 ) 
             aINFORMACOES:={" Posicione a BARRA sobre o modulo em que deseja alterar",; 
                            " a configuracao dos dados e pressione a tecla [TAB].   ",; 
                            " Caso deseje abandonar esta operacao o  usuario devera ",; 
                            " pressionar a tecla [ESC].                             "} 
          ENDIF 
  endcase 
  IF !( aInformacoes==Nil ) 
     vpobsbox(.T.,24-7,23," Informacoes ",aINFORMACOES,COR[18],.F.) 
  ENDIF 
 
return(.t.) 
 
 
/* 
* 
* Funcao      - MODULO 
* Finalidade  - Esta funcao e' responsavel pela apresentacao dos dados na janela 
* Programador - ValmorPF 
* Data        - 
* Atualizacao - 
* 
*/ 
stat func modulo( nMod ) 
  loca cCOR:=setcolor(), lModoVga 
  local aFileTmp, nCt 
  setcolor(COR[20]) 
  vpbox(01,23,24-08,79,,COR[20],.F.,.F.,COR[20], .F.) 
  do case 
     case nMOD=13 
 
          @ 03,25 say "Mascara p/ codigo....: [" + SWSET( _PRO_MASCACOD )  + "]" 
          @ 04,25 say "Mascara p/ quantidade: [" + SWSET( _PRO_MASCQUAN )  + "]" 
          @ 05,25 say "Mascara para valores.: [" + SWSET( _PRO_MASCPREC )  + "]" 
          @ 06,25 say "Utilizar Origens.....: [" + IF ( SWSET( _PRO_ORIGEM ), "S", "N" )  + "]" 
          @ 07,25 say "Assoc. (Quant.x Est.): [" + IF ( SWSET( _PRO_ASSOCIAR ), "S", "N" )  + "]" 
          @ 08,25 say "Utilizar Detalhamento: [" + IF ( SWSET( _PRO_DETALHE ), "S", "N" )  + "]" 
 
     case nMod==11 
          @ 03,25 Say "Cliente(Cons/Industr): [" + SWSet( _CL__CONSIND ) + "]" 
          @ 04,25 Say "Cidade...............: [" + pad( SWSet( _CL__CIDADE ), 25 ) + "]" 
          @ 05,25 Say "Estado...............: [" + SWSet( _CL__ESTADO ) + "]" 
 
     case nMod==141 
          @ 03,25 Say "Codigo de Convenio...: [" + Str( SWSet( _GER_BCO_CONVENIO ), 5 ) + "]" 
 
     case nMOD=2 
          @ 03,25 Say "Atual.Precos Autom...: [" + IF( SWSet( _GER_ATUALIZAPRECO ), "Sim", "Nao" ) + "]" 
 
     case nMod=41 
          @ 03,25 Say "Formatacao...........: [" + StrZero( SWSet( _PED_FORMATO ), 2, 0 ) + "]" 
          @ 04,25 Say "Maximo desconto......: [" + Str( SWSet( _PED_MAXDESCONTO ), 5, 2 ) + "]" 
          @ 05,25 Say "Consulta lim. de cred: [" + IF( SWSet( _PED_LIMITECREDITO ), "S", "N" ) + "]" 
          @ 06,25 Say "Apresentar Fornecedor: [" + IF( SWSet( _PED_FORNECEDOR ), "S", "N" ) + "]" 
          @ 07,25 Say "Vendedor Interno.....: [" + Pad( SWSet( _PED_VENDINTERNO ), 12 ) + "]" 
          @ 08,25 Say "Vendedor Externo.....: [" + Pad( SWSet( _PED_VENDEXTERNO ), 12 ) + "]" 
          @ 09,25 Say "Tipo Frete...........: [" + Str( SWSet( _PED_TIPOFRETE ), 2, 0 ) + "]" 
          @ 10,25 Say "Perm. alt. de preco..: [" + IF( SWSet( _PED_MUDARPRECO ), "S", "N" ) + "]" 
          @ 11,25 Say "Alterar cod.fabrica..: [" + IF( SWSet( _PED_CODFABRICA ), "S", "N" ) + "]" 
          @ 12,25 Say "Movimentar estoque...: [" + IF( SWSet( _PED_TIRADOESTOQUE ), "S", "N" ) + "]" 
          @ 13,25 Say "Imprimir pedido......: [" + SWSet( _PED_IMPRIMEPEDIDO ) + "]" 
          @ 14,25 Say "Controlar reservas...: [" + IF( SWSet( _PED_CONTROLERESERVA ), "S", "N" ) + "]" 
 
     case nMod=42 
          @ 03,25 Say "Natureza da Operacao.: [" + Str( SWSet( _NFA_NATOPERA ), 6, 3 ) + "]" 
          @ 04,25 Say "Razao................: [" + SWSet( _NFA_RAZAO ) + "]" 
          @ 05,25 Say "Via de Transporte....: [" + SWSet( _NFA_VIATRANSP ) + "]" 
          @ 06,25 Say "Data Saida Automatica: [" + IF( SWSet( _NF__DATA ), "Sim", "Nao" ) + "]" 
          @ 07,25 Say "Hora Saida Automatica: [" + IF( SWSet( _NF__HORA ), "Sim", "Nao" ) + "]" 
 
     case nMod=51 
          @ 03,25 Say "Calculo..............: [" + Str( SWSet( _CMS_TPCALCULO ), 3 ) + "]" 
          @ 04,25 Say "Grupos...............: [" + SWSet( _CMS_GRUPOS )[1] + "]" 
 
     case nMod=0 
          @ 03,25 Say "Percentual de ISSQN..: [" + Str( SWSet( _GER_PERCISSQN ), 5, 2 ) + "]" 
          @ 04,25 Say "Juros ao mes.........: [" + Str( SWSet( _GER_JUROSAOMES ), 5, 2 ) + "]" 
          @ 05,25 Say "Dias no mes..........: [" + Str( SWSet( _GER_DIASNOMES ), 2, 0 ) + "]" 
          @ 06,25 Say "Grupo de Servicos....: [" + SWSet( _GER_GRUPOSERVICOS ) + "]" 
          @ 07,25 Say "Dias p/Novo Vecto ...: [" + Str( SWSet( _GER_DIASNOVOVCTO ), 3, 0 ) + "]" 
          @ 08,25 Say "Percentual de COFINS : [" + Right( Str( SWSet( _NF__PERCOFINS ) ), 5 ) + "]"            // gelson 16/04/2004
 
     case nMod=110 
          @ 03,25 Say "Suporte ao Mouse.....: [" + IF( SWSet( _SYS_MOUSE ), "S", "N" ) + "]" 
 
     case nMod=120 
          @ 03,25 Say "Protecao de Tela.....: [" + StrZero( SWSet( _SYS_TIPOPROT ), 2, 0 ) +  "]" 
          @ 04,25 Say "Tempo para ativacao..: [" + StrZero( SWSet( _SYS_TEMPOPROT ), 02 ) + "]" 
          @ 05,25 Say "Utilizar senha.......: [" + IF( SWSet( _SYS_PROTSENHA ), "S", "N" ) + "]" 
 
     case nMod=121 
          @ 03,25 Say "Texto da protecao...: [" + SWSet( _SYS_PROT1 )[1] + "] [" + SWSet( _SYS_PROT2 )[1] + "]" 
          @ 04,25 Say "Cor da primeira pal.: [" + SWSet( _SYS_PROT1 )[2] + "]" 
          @ 05,25 Say "Cor da segunda pal..: [" + SWSet( _SYS_PROT2 )[2] + "]" 
          VPBox( 07, 25, 15, 77, , "15/00", .F., .F., , .F. ) 
          SWSet( _SYS_PROTELA, { 09, 27, 13, 75 } ) 
          @ 09,26 Say Space( 0 ) 
          ProtecaoTela() 
          Keyboard Chr( LastKey() ) 
          SWSet( _SYS_PROTELA, { 00, 00, 24, 79 } ) 
 
     case nMod=130 
          @ 03,25 Say "Exibir...............: ["  +   IF( SWSet( _GER_BARRAROLAGEM ), "Sim", "Nao" ) +   "]" 
          @ 04,25 Say "Cor Padrao...........: ["  + SWSet( _GER_BARRACOR ) + "]" 
 
     case nMod=140 
          @ 03,25 Say "Modo (VGA/CGA).......: [" + IF( ModoVga(), "VGA","CGA" ) + "]" 
          VPBox( 05, 25, 15, 77, " Exemplo de Apresentacao ", _COR_BROW_BOX, .F., .F., , .F. ) 
          lModoVga:= ModoVga() 
          ModoVga( .T. ) 
          VPBox( 07, 27, 13, 47, "Modo VGA", "15/01", .T., .T., , .F. ) 
          ModoVga( .F. ) 
          VPBox( 07, 52, 13, 73, "Modo CGA", "15/01", .T., .T., , .F. ) 
          ModoVga( lModoVga ) 
 
     case nMod=150 
          @ 03,25 Say "Cadastros............: ["  + PAD( SWSet( _PRN_CADASTRO ), 10 )   + "]" 
          @ 04,25 Say "Cotacao/Pedido.......: ["  + PAD( SWSet( _PRN_COTACAO ), 10 )    + "]" 
          @ 05,25 Say "Nota Fiscal..........: ["  + PAD( SWSet( _PRN_NFISCAL ), 10 )    + "]" 
          @ 06,25 Say "Romaneio.............: ["  + PAD( SWSet( _PRN_ROMANEIO ), 10 )   + "]" 
          @ 07,25 Say "Bloquetos............: ["  + PAD( SWSet( _PRN_BLOQUETOS ), 10 )  + "]" 
          @ 08,25 Say "Contas a Pagar.......: ["  + PAD( SWSet( _PRN_CTAPAGAR ), 10 )   + "]" 
          @ 09,25 Say "Contas a Receber.....: ["  + PAD( SWSet( _PRN_CTARECEBER ), 10 ) + "]" 
          @ 10,25 Say "Comissoes............: ["  + PAD( SWSet( _PRN_COMISSOES ), 10 )  + "]" 
          @ 11,25 Say "Outros Relatorios....: ["  + PAD( SWSet( _PRN_OUTROS ), 10 )     + "]" 
          @ 13,25 Say "Dir.Relatorios (Rede): ["  + PAD( SWSet( _SYS_DIRREPORT ), 25 )  + "]" 
     case nMod=160 
          @ 03,25 Say "Comando de Captura de Versao ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
          @ 04,25 Say LEFT( Alltrim( SWSet( _SYS_COMANDOVERSAO ) ), 53 ) Color "14/" + CorFundoAtual() 
          @ 05,25 Say "Atualizacao de Executavel ÄÄÄÄÄÄÄ REPORT\VERSAO.INI Ä" 
          IF File( "REPORT\VERSAO.INI" ) 
             aFileTmp:= IOFillText( MEMOREAD( "REPORT\VERSAO.INI" ) ) 
             FOR nCt:= 1 TO LEN( aFileTmp ) 
                 @ 06+nCt,25 Say aFileTmp[ nCt ] Color "14/" + CorFundoAtual() 
             NEXT 
          ENDIF 
   endcase 
 
return nil 
 
/* 
* 
*      Funcao - MASCARAVALE 
*   Finlidade - Testar se a mascara digitada pelo usuario e' valida 
*  Parametros - MASCARA=>Variavel com a mascara digitada pelo usuario 
*             - MOD=>(1)-Teste atribuido a variaveis numericas. 
*             -      (2)-Teste especifico ao codigo de produtos. 
* Programador - ValmorPF 
*        Data - 10/Novembro/1994 
* Atualizacao - 10/Novembro/1994 
* 
*/ 
stat func mascaravale(MASCARA,MOD) 
  loca cMP:={}, cMA:="", nCT,; 
  cMASCARA:=alltrim(MASCARA), FIM:=0 
  if MOD=1 //* Valores *// 
     for nCT=1 to len(cMASCARA) 
         aadd(cMP,substr(cMASCARA,nCT,1)) 
         if cMP[nCT]<>"9" .AND. cMP[nCT]<>"," .AND. cMP[nCT]<>"." 
            mensagem("ERRO: Um dos caracteres digitado e' incompativel com os permitidos.",1) 
            pausa() 
            return(.F.) 
         endif 
         if cMP[nCT]="." .OR. cMP[nCT]="," 
            if cMP[nCT]=","  ;++FIM 
            elseif FIM=1 
                mensagem("ERRO: Nao pode ser digitado caracter separador apos a <,> decimal.") 
                pausa() 
                return(.F.) 
            endif 
         endif 
         if(nCT>1,cMA:=cMP[nCT-1],nil) 
         if cMA="," .OR. cMA="." 
            if cMA=cMP[nCT] .OR. (cMA+cMP[nCT]=".,") .OR. (cMA+cMP[nCT]=",.") 
               mensagem("ERRO: Conhecidencia de separadores ou <.> e <,> seguidos.",1) 
               pausa() 
               return(.F.) 
            endif 
         endif 
     next 
  elseif MOD=2 //* Codigo de produto *// 
     for nCT=1 to len(cMASCARA) 
         aadd(cMP,substr(cMASCARA,nCT,1)) 
         if !cMP[nCT]$"G-N.V " 
            mensagem("ERRO: Um dos caracteres digitado e' incompativel com os permitidos.",1) 
            pausa() 
            return(.F.) 
         endif 
         if(nCT>1,cMA:=cMP[nCT-1],nil) 
         if cMA="-" .OR. cMA="." 
            if cMA=cMP[nCT] .OR. (cMA+cMP[nCT]="-.") .OR. (cMA+cMP[nCT]=".-") 
               mensagem("ERRO: Conhecidencia de separadores ou <.> e <-> seguidos.",1) 
               pausa() 
               return(.F.) 
            endif 
         endif 
     next 
  endif 
return(.T.) 
 
/* 
* 
* Funcao       - EDITAR 
* Finalidade   - Permite que o usuario faca configuracao dos campos de produtos. 
* Programador  - Valmor Pereira Flores 
* Data         - 01/Novembro/1994 
* Atualizacao  - 16/Novembro/1994 
* 
*/ 
stat func editar() 
 
  Local cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  Local nFORMATO, nMAXDESC, lLIMCRED, lAPREFOR, cVENDINT, cVENDEXT, nTIPFRET,; 
        lALTPREC, lALTCODI, lMOVESTO, lIMPPEDI, nNATOPERA, cRAZAO, cVIATRANS,; 
        nCALCULO, cGRUPO, nPERCISSQN, nJUROSAOMES, nDIASNOMES, cPROT1, cPROT2,; 
        cCOR1, cCOR2, cMONITOR, cMASCACOD, cMASCQUAN, cMASCPERC, cORIGEM, cASSOCIAR,; 
        cSuportMouse, nTipoProtecao, nTempoProtecao, cProtSenha, cDetalhe,; 
        cDirReport, nPERCOFINS
 
  priv nCMOD:=0 
  setcursor(1) 
  setcolor( _COR_GET_EDICAO ) 
  VPBox( 01, 23, 24-08, 79, " Edicao ", _COR_GET_EDICAO,.F., .F., ,.F. ) 
 
  DO CASE 
     CASE nMod==11 
          cConsInd:= SWSet( _CL__CONSIND ) 
          cCidade:=  pad( SWSet( _CL__CIDADE ), 40 ) 
          cEstado:=  pad( SWSet( _CL__ESTADO ), 02 ) 
          @ 03,25 Say "Cliente(Cons/Industr):" Get cConsInd 
          @ 04,25 Say "Cidade...............:" Get cCidade Pict "@S25" 
          @ 05,25 Say "Estado...............:" Get cEstado 
          READ 
 
          SWSet( _CL__CONSIND, cConsInd ) 
          SWSet( _CL__CIDADE, Alltrim( cCidade ) ) 
          SWSet( _CL__ESTADO, cEstado ) 
 
          GravaSWSet( '$SWSet( _CL__CONSIND, "' + cConsInd + '" )' ) 
          GravaSWSet( '$SWSet( _CL__CIDADE, "' + Alltrim( cCidade ) + '" )' ) 
          GravaSWSet( '$SWSet( _CL__ESTADO, "' + cEstado + '" )' ) 
 
     CASE nMOD=13  // Cadastro de Produtos 
 
          cMASCACOD := SWSET( _PRO_MASCACOD ) 
          cMASCQUAN := SWSET( _PRO_MASCQUAN ) 
          cMASCPREC := SWSET( _PRO_MASCPREC ) 
          cORIGEM   := IF( SWSET( _PRO_ORIGEM ), "S", "N" ) 
          cASSOCIAR := IF( SWSET( _PRO_ASSOCIAR ), "S", "N" ) 
          cDetalhe  := IF( SWSET( _PRO_DETALHE ), "S", "N" ) 
 
          @ 03,25 say "Mascara p/ codigo....:" get cMASCACOD pict "!!!!!!!!!!!" valid mascaravale(cMASCACOD,2) when informacoes(1) 
          @ 04,25 say "Mascara p/ quantidade:" get cMASCQUAN pict "!!!!!!!!!!!!" valid mascaravale(cMASCQUAN,1) when informacoes(2) 
          @ 05,25 say "Mascara para valores.:" get cMASCPREC pict "XXXXXXXXXXXXXXXX" valid mascaravale(cMASCPREC,1) when informacoes(3) 
          @ 06,25 say "Utilizar Origens.....:" get cORIGEM pict "!" valid cORIGEM$"SN" when informacoes(4) 
          @ 07,25 say "Assoc. (Quant.x Est.):" get cASSOCIAR pict "!" valid cASSOCIAR$"SN" when informacoes(5) 
          @ 08,25 say "Utilizar Detalhamento:" get cDetalhe Pict "!" Valid cDetalhe $ "SN" When Mensagem( "Digite [S] para utilizacao de detalhamento." ) 
 
          READ 
 
          GravaSWSet( '$SWSet( _PRO_MASCACOD, "' + cMASCACOD + '" )' ) 
          GravaSWSet( '$SWSet( _PRO_MASCQUAN, "' + cMASCQUAN + '" )' ) 
          GravaSWSet( '$SWSet( _PRO_MASCPREC, "' + cMASCPREC + '" )' ) 
          GravaSWSet( "$SWSet( _PRO_ORIGEM, " + IF ( cORIGEM == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( "$SWSet( _PRO_ASSOCIAR, " + IF ( cASSOCIAR == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( "$SWSet( _PRO_DETALHE, " + IF ( cDetalhe == "S", ".T.", ".F." ) + " )" ) 
 
     CASE nMOD=2 
 
          cAtualiza:= IF( SWSet( _GER_ATUALIZAPRECO ), "S", "N" ) 
          @ 03,25 Say "Atual.Precos Autom...:" Get cAtualiza Pict "!" 
          READ 
          GravaSWSet( "$SWSet( _GER_ATUALIZAPRECO, " + IF ( cAtualiza == "S", ".T.", ".F." ) + " )" ) 
          SWSet( _GER_ATUALIZAPRECO, cAtualiza=="S" ) 
 
     CASE nMOD=141 
 
          nVar1:= SWSet( _GER_BCO_CONVENIO ) 
          @ 03,25 Say "Codigo de Convenio...:" Get nVar1 Pict "99999" 
          READ 
          GravaSWSet( "$SWSet( _GER_BCO_CONVENIO, " + Str( nVar1, 5, 0 ) + " )" ) 
          SWSet( _GER_BCO_CONVENIO, nVar1 ) 
 
     CASE nMOD=41    // Pedido 
 
          nFORMATO := SWSET( _PED_FORMATO ) 
          nMAXDESC := SWSET( _PED_MAXDESCONTO ) 
          lLIMCRED := IF ( SWSET( _PED_LIMITECREDITO ), "S", "N" ) 
          lAPREFOR := IF ( SWSET( _PED_FORNECEDOR ), "S", "N" ) 
          cVENDINT := Pad( SWSet( _PED_VENDINTERNO ), 12 ) 
          cVENDEXT := Pad( SWSet( _PED_VENDEXTERNO ), 12 ) 
          nTIPFRET := SWSET( _PED_TIPOFRETE ) 
          lALTPREC := IF ( SWSET( _PED_MUDARPRECO ), "S", "N" ) 
          lALTCODI := IF ( SWSET( _PED_CODFABRICA ), "S", "N" ) 
          lMOVESTO := IF ( SWSET( _PED_TIRADOESTOQUE ), "S", "N" ) 
          lIMPPEDI := SWSET( _PED_IMPRIMEPEDIDO ) 
          cContRes := IF( SWSET( _PED_CONTROLERESERVA ), "S", "N" ) 
 
          @ 03,25 Say "Formatacao...........:" Get nFORMATO PICT "99" when mensagem("Formato do pedido.") 
          @ 04,25 Say "Maximo desconto......:" Get nMAXDESC PICT "99.99" when mensagem("Maximo de desconto do pedido.") 
          @ 05,25 Say "Consulta lim. de cred:" Get lLIMCRED PICT "!" VALID lLIMCRED $ "SN" when mensagem("Limite de credito do pedido?") 
          @ 06,25 Say "Apresentar Fornecedor:" Get lAPREFOR PICT "!" VALID lAPREFOR $ "SN" when mensagem("Apresentar fornecedor no pedido?") 
          @ 07,25 Say "Vendedor Interno.....:" Get cVENDINT PICT "XXXXXXXXXXXXXX" when mensagem("Nome do vendedor interno.") 
          @ 08,25 Say "Vendedor Externo.....:" Get cVENDEXT PICT "XXXXXXXXXXXXXX" when mensagem("Nome do vendedor externo.") 
          @ 09,25 Say "Tipo Frete...........:" Get nTIPFRET PICT "99" when mensagem("Tipo de frete do pedido.") 
          @ 10,25 Say "Perm. alt. de preco..:" Get lALTPREC PICT "!" VALID lALTPREC $ "SN" when mensagem("Permitir alteracao de preco no pedido?") 
          @ 11,25 Say "Alterar cod.fabrica..:" Get lALTCODI PICT "!" VALID lALTCODI $ "SN" when mensagem("Alterar codigo de fabrica do pedido?") 
          @ 12,25 Say "Movimentar estoque...:" Get lMOVESTO PICT "!" VALID lMOVESTO $ "SN" when mensagem("Permitir movimentacao no estoque?") 
          @ 13,25 Say "Imprimir pedido......:" Get lIMPPEDI PICT "!" VALID lIMPPEDI $ "SN" when mensagem("Permitir impressao do pedido?") 
          @ 14,25 Say "Controlar reserva....:" Get cContRes PICT "!" VALID cContRes $ "SN" when mensagem("Fazer controle de reserva por pedido?") 
          READ 
 
          GravaSWSet( "$SWSet( _PED_FORMATO, " + ALLTRIM( STR( nFORMATO ) ) + " )" ) 
          GravaSWSet( "$SWSet( _PED_MAXDESCONTO, " + ALLTRIM( STR( nMAXDESC ) ) + " )" ) 
          GravaSWSet( "$SWSet( _PED_LIMITECREDITO, " + IF ( lLIMCRED == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( "$SWSet( _PED_FORNECEDOR, "    + IF ( lAPREFOR == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( '$SWSet( _PED_VENDINTERNO, "' + cVENDINT + '" )' ) 
          GravaSWSet( '$SWSet( _PED_VENDEXTERNO, "' + cVENDEXT + '" )' ) 
          GravaSWSet( "$SWSet( _PED_TIPOFRETE, " + ALLTRIM( STR( nTIPFRET ) ) + " )" ) 
          GravaSWSet( "$SWSet( _PED_MUDARPRECO, " + IF ( lALTPREC == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( "$SWSet( _PED_CODFABRICA, " + IF ( lALTCODI == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( "$SWSet( _PED_TIRADOESTOQUE, " + IF ( lMOVESTO == "S", ".T.", ".F." ) + " )" ) 
          GravaSWSet( '$SWSet( _PED_IMPRIMEPEDIDO, "' + lIMPPEDI + '" )' ) 
          GravaSWSet( "$SWSet( _PED_CONTROLERESERVA, " + IF( cContRes=="S", ".T.", ".F." ) + " )" ) 
 
 
          SWSet( _PED_FORMATO,         nFORMATO ) 
          SWSet( _PED_MAXDESCONTO,     nMAXDESC ) 
          SWSet( _PED_LIMITECREDITO,   lLIMCRED=="S" ) 
          SWSet( _PED_FORNECEDOR,      lAPREFOR=="S" ) 
          SWSet( _PED_VENDINTERNO,     cVENDINT ) 
          SWSet( _PED_VENDEXTERNO,     cVENDEXT ) 
          SWSet( _PED_TIPOFRETE,       nTIPFRET ) 
          SWSet( _PED_MUDARPRECO,      lALTPREC=="S" ) 
          SWSet( _PED_CODFABRICA,      lALTCODI=="S" ) 
          SWSet( _PED_TIRADOESTOQUE,   lMOVESTO=="S" ) 
          SWSet( _PED_IMPRIMEPEDIDO,   lIMPPEDI ) 
          SWSet( _PED_CONTROLERESERVA, cContRes=="S" ) 
 
 
     CASE nMOD=42    // Nota Fiscal 
 
          nNATOPERA := SWSET( _NFA_NATOPERA ) 
          cRAZAO    := SWSET( _NFA_RAZAO ) 
          cVIATRANS := SWSET( _NFA_VIATRANSP ) 
 
          @ 03,25 Say "Natureza da Operacao.:" Get nNATOPERA PICT "99.999" when mensagem("Natureza da operacao da nota fiscal.") 
          @ 04,25 Say "Razao................:" Get cRAZAO    PICT "XXXXXXXX" when mensagem("Razao da nota fiscal.") 
          @ 05,25 Say "Via de Transporte....:" Get cVIATRANS PICT "XXXXXXXXXXXXX" when mensagem("Via de transporte da nota fiscal.") 
          READ 
 
          GravaSWSet( "$SWSet( _NFA_NATOPERA, " + ALLTRIM( STR( nNATOPERA ) ) + " )" ) 
          GravaSWSet( '$SWSet( _NFA_RAZAO, "' + cRAZAO + '" )' ) 
          GravaSWSet( '$SWSet( _NFA_VIATRANSP, "' + cVIATRANS + '" )' ) 
 
          SWSet( _NFA_NATOPERA,  nNATOPERA ) 
          SWSet( _NFA_RAZAO,     cRAZAO ) 
          SWSet( _NFA_VIATRANSP, cVIATRANS ) 
 
 
     CASE nMOD=51    // Comissoes 
 
          nCALCULO := SWSET( _CMS_TPCALCULO ) 
          cGRUPO   := SWSET( _CMS_GRUPOS )[1] 
 
          @ 03,25 Say "Calculo..............:" Get nCALCULO PICT "999" when mensagem("Calculo de comissoes.") 
          @ 04,25 Say "Grupo................:" Get cGRUPO PICT "XXX" when mensagem("Grupo de comissoes.") 
          READ 
 
          GravaSWSet( "$SWSet( _CMS_TPCALCULO, " + ALLTRIM( STR( nCALCULO ) ) + " )" ) 
          GravaSWSet( '$SWSet( _CMS_GRUPO, { "' + cGRUPO + '" } )' ) 
 
     CASE nMOD=0    // Geral 
 
          nPERCISSQN  := SWSET( _GER_PERCISSQN )
          nJUROSAOMES := SWSET( _GER_JUROSAOMES ) 
          nDIASNOMES  := SWSET( _GER_DIASNOMES ) 
          cGrupoServicos:= SWSet( _GER_GRUPOSERVICOS ) 
          nDiasNovoVcto:= SWSet( _GER_DIASNOVOVCTO ) 
          nPERCOFINS  := SWSET( _NF__PERCOFINS )            // gelson 16/04/2004
 
          @ 03,25 Say "Percentual de ISSQN..:" Get nPERCISSQN  PICT "99.99" when mensagem("Informe o percentual de ISSQN.") 
          @ 04,25 Say "Juros ao mes.........:" Get nJUROSAOMES PICT "99.99" when mensagem("Percentual de juros ao mes.") 
          @ 05,25 Say "Dias no mes..........:" Get nDIASNOMESO PICT "99" when mensagem("Total de dias no mes.") 
          @ 06,25 Say "Grupo de Servicos....:" Get cGrupoServicos Pict "999" when mensagem( "Digite o codigo do grupo utilizado p/ servicos." ) 
          @ 07,25 Say "Dias p/Novo Vecto ...:" Get nDiasNovoVcto Pict "999" ; 
             when mensagem( "Digite os dias para novo vencimento em duplicatas rejeitadas." ) 
          @ 08,25 Say "Percentual de COFINS :" Get nPERCOFINS  PICT "99.99" when mensagem("Informe o percentual de COFINS.")            // gelson 16/04/2004
          READ 
 
          GravaSWSet( "$SWSet( _GER_PERCISSQN, " + ALLTRIM( STR( nPERCISSQN ) ) + " )" ) 
          GravaSWSet( "$SWSet( _GER_JUROSAOMES, " + ALLTRIM( STR( nJUROSAOMES ) ) + " )" ) 
          GravaSWSet( "$SWSet( _GER_DIASNOMES, " + ALLTRIM( STR( nDIASNOMES ) ) + " )" ) 
          GravaSWSet( "$SWSet( _GER_GRUPOSERVICOS, '" + ALLTRIM( cGrupoServicos ) + "' )" ) 
          GravaSWSet( "$SWSet( _GER_DIASNOVOVCTO, " + ALLTRIM( Str( nDiasNovoVcto )) + " )" ) 
          GravaSWSet( "$SWSet( _NF__PERCOFINS, " + ALLTRIM( STR( nPERCOFINS ) ) + " )" )            // gelson 16/04/2004
 
          SWSet( _GER_PERCISSQN,  nPERCISSQN  ) 
          SWSet( _GER_JUROSAOMES, nJUROSAOMES ) 
          SWSet( _GER_DIASNOMES,  nDIASNOMES  ) 
          SWSet( _GER_GRUPOSERVICOS, ALLTRIM( cGrupoServicos ) ) 
          SWSet( _GER_DIASNOVOVCTO, nDiasNovoVcto ) 
          SWSet( _NF__PERCOFINS,  nPERCOFINS  )            // gelson 16/04/2004
 
     CASE nMod=110 
 
          cSuportMouse:= IF( SWSet( _SYS_MOUSE ), "S", "N" ) 
          @ 03,25 Say "Suporte ao Mouse.....:" Get cSuportMouse PICT "!" when mensagem("Informe de deseja usar ou nao o suporte ao mouse.") Valid cSuportMouse $ "SN" 
          READ 
          IF cSuportMouse == "S" 
             //SetMouseSeta() 
             LigaMouse( .T. ) 
          ELSE 
             DesligaMouse() 
          ENDIF 
          SWSet( _SYS_MOUSE, .T. ) 
          GravaSWSet( "$SWSet( _SYS_MOUSE, " + IF( cSuportMouse == "S", " .T. ", " .F. " ) + " ) " ) 
 
     CASE nMod = 120 
 
          nTipoProtecao:= SWSet( _SYS_TIPOPROT ) 
          nTempoProtecao:= SWSet( _SYS_TEMPOPROT ) 
          cProtSenha:= IF( SWSet( _SYS_PROTSENHA ), "S", "N" ) 
 
          @ 03,25 Say "Protecao de Tela.....:" Get nTipoProtecao Pict "99" When mensagem("Selecione o tipo de protecao [1/2]." ) Valid nTipoProtecao >= 1 .AND. nTipoProtecao <= 2 
          @ 04,25 Say "Tempo para ativacao..:" Get nTempoProtecao Pict "99" When mensagem( "Tempo de protecao." ) Valid nTempoProtecao >= 0 .AND. nTempoProtecao <= 60 
          @ 05,25 Say "Utilizar senha.......:" Get cProtSenha Pict "!" When Mensagem( "Usar a senha para sair da protecao." ) Valid cProtSenha $ "SN" 
          READ 
 
          GravaSWSet( "$SWSet( _SYS_TIPOPROT, " + Str( nTipoProtecao, 2, 0 ) + ") " ) 
          GravaSWSet( "$SWSet( _SYS_TEMPOPROT, " + Str( nTempoProtecao, 2, 0 ) + ") " ) 
          GravaSWSet( "$SWSet( _SYS_PROTSENHA, " + IF( cProtSenha == "S", " .T. ", " .F. " ) + " )" ) 
 
     CASE nMOD=121    // Protacao de Tela 
 
          cPROT1 := SWSET( _SYS_PROT1 )[1] 
          cPROT2 := SWSET( _SYS_PROT2 )[1] 
          cCOR1  := SWSET( _SYS_PROT1 )[2] 
          cCOR2  := SWSET( _SYS_PROT2 )[2] 
 
          VPBox( 07, 25, 15, 77, , "15/00", .F., .F., , .F. ) 
 
          @ 03,25 Say "Texto da protecao...:" Get cPROT1 PICT "XXXXXXXXXXXXX" when mensagem("Texto a ser exibido na protecao de tela.") 
          @ 03,63                             Get cPROT2 PICT "XXXXXXXXXXXXX" when mensagem("Texto a ser exibido na protecao de tela.") 
          @ 04,25 Say "Cor da primeira pal.:" Get cCOR1  PICT "XX/XX" when mensagem("Cor do primeiro texto.") 
          @ 05,25 Say "Cor da segunda pal..:" Get cCOR2  PICT "XX/XX" when mensagem("Cor do segundo texto.") 
          READ 
 
          GravaSWSet( '$SWSet( _SYS_PROT1, { "' + cPROT1 + '", "' + cCOR1 + '" } )' ) 
          GravaSWSet( '$SWSet( _SYS_PROT2, { "' + cPROT2 + '", "' + cCOR2 + '" } )' ) 
 
     CASE nMod=130 
 
          cBarra:= IF( SWSet( _GER_BARRAROLAGEM ), "S", "N" ) 
          cCor1:= SWSet( _GER_BARRACOR ) 
          @ 03,25 Say "Exibir...............:" Get cBarra Pict "!" Valid cBarra $ "SN" when; 
             mensagem( "Digite [S] para ativar a barra de rolagem ou [N] para desativar." ) 
          @ 04,25 Say "Cor Padrao...........:" Get cCor1 Pict "XX/XX" When; 
             mensagem( "Digite a cor padrao para a barra de rolagem." ) 
          READ 
 
          GravaSWSet( "$SWSet( _GER_BARRAROLAGEM, " + IF( cBarra == "S", " .T. ", " .F. " ) + " )" ) 
          GravaSWSet( "$SWSet( _GER_BARRACOR, '" + cCor1 + "' )" ) 
 
          SWSet( _GER_BARRAROLAGEM, ( cBarra == "S" ) ) 
          SWSet( _GER_BARRACOR, cCor1 ) 
 
     CASE nMOD=140    // Monitor 
 
          cMONITOR := IF( ModoVga(), "VGA","CGA" ) 
 
          VPBox( 05, 25, 15, 77, " Exemplo de Apresentacao ", _COR_BROW_BOX, .F., .F., , .F. ) 
          lModoVga:= ModoVga() 
          ModoVga( .T. ) 
          VPBox( 07, 27, 13, 47, "Modo VGA", "15/01", .T., .T., , .F. ) 
          ModoVga( .F. ) 
          VPBox( 07, 52, 13, 73, "Modo CGA", "15/01", .T., .T., , .F. ) 
          ModoVga( lModoVga ) 
 
          @ 03,25 Say "Modo (VGA/CGA).......:" Get cMONITOR PICT "XXX" VALID cMONITOR == "VGA" .OR. cMONITOR == "CGA" when mensagem("Tipo de Monitor [VGA/CGA].") 
          READ 
 
          GravaSWSet( "$ModoVga( " + IF ( cMONITOR == "VGA", ".T.", ".F." ) + " )" ) 
          ModoVga( cMONITOR == "VGA" ) 
 
     CASE nMOD=150    // Impressoras 
 
          cPrnCadastro:= PAD( SWSet( _PRN_CADASTRO ), 10 ) 
          cPrnBloqueto:= PAD( SWSet( _PRN_BLOQUETOS ), 10 ) 
          cPrnRomaneio:= PAD( SWSet( _PRN_ROMANEIO ), 10 ) 
          cPrnNFiscal := PAD( SWSet( _PRN_NFISCAL ), 10 ) 
          cPrnCtaPagar:= PAD( SWSet( _PRN_CTAPAGAR ), 10 ) 
          cPrnCtaReceb:= PAD( SWSet( _PRN_CTARECEBER ), 10 ) 
          cPrnComissoe:= PAD( SWSet( _PRN_COMISSOES ), 10 ) 
          cPrnOutros  := PAD( SWSet( _PRN_OUTROS ), 10 ) 
          cPrnCotacao := PAD( SWSet( _PRN_COTACAO ), 10 ) 
          cDirReport  := PAD( SWSet( _SYS_DIRREPORT ), 40 ) 
 
          @ 03,25 Say "Cadastros............:" Get cPrnCadastro 
          @ 04,25 Say "Cotacao/Pedido.......:" Get cPrnCotacao 
          @ 05,25 Say "Nota Fiscal..........:" Get cPrnNFiscal 
          @ 06,25 Say "Romaneio.............:" Get cPrnRomaneio 
          @ 07,25 Say "Bloquetos............:" Get cPrnBloquetos 
          @ 08,25 Say "Contas a Pagar.......:" Get cPrnCtaPagar 
          @ 09,25 Say "Contas a Receber.....:" Get cPrnCtaReceber 
          @ 10,25 Say "Comissoes............:" Get cPrnComissoes 
          @ 11,25 Say "Outros Relatorios....:" Get cPrnOutros 
          @ 13,25 Say "Dir.Relatorios (Rede):" Get cDirReport Pict "@S25" 
          READ 
 
          GravaSWSet( '$SWSet( _PRN_CADASTRO,  [' + Alltrim( cPrnCadastro   ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_COTACAO,   [' + Alltrim( cPrnCotacao    ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_NFISCAL,   [' + Alltrim( cPrnNFiscal    ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_ROMANEIO,  [' + Alltrim( cPrnRomaneio   ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_BLOQUETOS, [' + Alltrim( cPrnBloquetos  ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_CTAPAGAR,  [' + Alltrim( cPrnCtaPagar   ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_CTARECEBER,[' + Alltrim( cPrnCtaReceber ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_COMISSOES, [' + Alltrim( cPrnComissoes  ) + '] )' ) 
          GravaSWSet( '$SWSet( _PRN_OUTROS,    [' + Alltrim( cPrnOutros     ) + '] )' ) 
          GravaSWSet( '$SWSet( _SYS_DIRREPORT, [' + Alltrim( cDirReport     ) + '] )' ) 
 
          SWSet( _PRN_CADASTRO,   Alltrim( cPrnCadastro   ) ) 
          SWSet( _PRN_COTACAO,    Alltrim( cPrnCotacao )    ) 
          SWSet( _PRN_NFISCAL,    Alltrim( cPrnNFiscal    ) ) 
          SWSet( _PRN_ROMANEIO,   Alltrim( cPrnRomaneio   ) ) 
          SWSet( _PRN_BLOQUETOS,  Alltrim( cPrnBloquetos  ) ) 
          SWSet( _PRN_CTAPAGAR,   Alltrim( cPrnCtaPagar   ) ) 
          SWSet( _PRN_CTARECEBER, Alltrim( cPrnCtaReceber ) ) 
          SWSet( _PRN_COMISSOES,  Alltrim( cPrnComissoes  ) ) 
          SWSet( _PRN_OUTROS,     Alltrim( cPrnOutros     ) ) 
          SWSet( _SYS_DIRREPORT,  Alltrim( cDirReport     ) ) 
 
     CASE nMOD=160    // Atualizacao 
 
          cComando:= PAD( Alltrim( SWSet( _SYS_COMANDOVERSAO ) ), 200 ) 
 
          @ 03,25 Say "Comando de Captura de Versao ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
 
          @ 05,25 Say "Atualizacao de Executavel ÄÄÄÄÄÄÄ REPORT\VERSAO.INI Ä" 
          IF File( "REPORT\VERSAO.INI" ) 
             aFileTmp:= IOFillText( MEMOREAD( "REPORT\VERSAO.INI" ) ) 
             FOR nCt:= 1 TO LEN( aFileTmp ) 
                 @ 06+nCt,25 Say aFileTmp[ nCt ] Color "14/" + CorFundoAtual() 
             NEXT 
          ENDIF 
 
          @ 04,25 Get cComando Pict "@S51" 
          READ 
 
          IF File( "REPORT\VERSAO.INI" ) 
             IF ( nOpcao:= SWAlerta( "<< ARQUIVO DE ATUALIZACAO >>; Existe um arquivo de configuracao VERSAO.INI; O que deseja fazer?", { "Editar", "Apagar", "Cancelar" } ) )==1 
                !edit REPORT\VERSAO.INI 
             ELSEIF nOpcao==2 
                FErase( "REPORT\VERSAO.INI" ) 
             ENDIF 
          ELSE 
             IF ( nOpcao:= SWAlerta( "<< ARQUIVO DE ATUALIZACAO >>; Nao existe um arquivo de configuracao VERSAO.INI?", { "Criar", "Cancelar" } ) )==1 
                MEMOWRIT( "REPORT\VERSAO.INI" ) 
                !edit REPORT\VERSAO.INI 
             ENDIF 
          ENDIF 
          SetBlink( .F. ) 
 
          GravaSWSet( '$SWSet( _SYS_COMANDOVERSAO, [' + Alltrim( cComando ) + '] )' ) 
 
  ENDCASE 
 
  screenrest(cTELA) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
 
return nil 
 
/* 
* 
* Funcao       - GravaSWSet 
* Finalidade   - Efetua a gravacao dos novos valores de configuracao do sistema. Programador  - Valmor Pereira Flores 
* Data         - 10/fevereiro/1998 
* Atualizacao  - 10/fevereiro/1998 
* 
*/ 
STATIC FUNCTION GravaSWSet( cString ) 
 
    STATIC aConfigur := {} 
    LOCAL nIndice := 0, nLinha := 5, nPosicao:= 0, cString2 := " " 
    LOCAL aConfig 
 
    IF ! cString == Nil   // Adiciona no array de configuracoes 
 
       /* Pega a string s/ $ */ 
       cString2 := SubStr( cString, 2 ) 
 
       /* Busca arquivo Config.Def */ 
       aConfig:= IOFillText( MEMOREAD( "CONFIG.DEF" ) ) 
 
       /* busca a posicao no arquivo CONFIG.DEF */ 
       cContStr:= SubStr( cString2, At( "(", cString2 ) + 1, At( ",", cString2 ) - At( "(", cString2 ) - 1 ) 
 
       /* Procura a posicao em aConfig */ 
       nPosicao:= ASCAN( aConfig, {|x| AT( cContStr, x ) > 0 } ) 
 
       IF nPosicao > 0 
          cString2:= StrTran( cString2, cContStr, SubStr( aConfig[ nPosicao ], AT( ">", aConfig[ nPosicao ] ) + 1 ) ) 
          EVAL( &( "{|| " +  cString2 + " } " ) ) 
 
       ENDIF 
 
       /* teste da existencia da string no array */ 
       nPosicao:= ASCAN( aConfigur, {|x| AT( SubStr( cString, At( "(", cString ) + 1, At( ",", cString ) - At( "(", cString ) ), x ) > 0 } ) 
 
       IF nPosicao == 0 
          AADD( aConfigur, cString ) 
       ELSE 
          aConfigur[ nPosicao ]:= cString 
       ENDIF 
 
    ELSE   // Executa a rotina de gravacao em arquivo 
 
       FazConfigur( aConfigur ) 
 
    ENDIF 
 
RETURN NIL 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ FazConfigur 
³ Finalidade  ³ Montar arquivo de confirguracao 
³ Parametros  ³ aArray - Matriz com as novas confirguracoes do arquivo CONFIGUR.Sys 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION FazConfigur( aNewConfig ) 
 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Local nLinha:= 0, aConfig, nCt, cArqOrigem, cArqDestino 
 
   IF Len( aNewConfig ) > 0 
 
      IF Confirma( 0, 0, "Confirma a gravacao dos parƒmetros do sistema?",; 
                        "Digite [S] para confirmar ou [N] para cancelar.", "*" ) 
 
          /* Copia de arquivos (Origem x Destino) */ 
          cArqOrigem:=  SWSet( _SYS_DIRREPORT ) - "\CONFIGUR.SYS" 
          cArqDestino:= SWSet( _SYS_DIRREPORT ) - "\CONFIGUR.BAK" 
 
          /* Busca arquivo Configur.Sys */ 
          aConfig:= IOFillText( MEMOREAD( cArqOrigem ) ) 
 
          __CopyFile( cArqOrigem, cArqDestino ) 
 
          FOR nCt:= 1 TO Len( aNewConfig ) 
 
              /* Pega a posicao em aNetConfig atual */ 
              cString:= Left( aNewConfig[ nCt ], AT( ",", aNewConfig[ nCt ] ) - 1 ) 
 
              /* teste da existencia da string no array */ 
              nPosicao:= ASCAN( aConfig, {|x| SubStr( Alltrim( x ), 1, AT( ",", X ) - 1 ) == cString } ) 
 
              IF nPosicao > 0 
 
                 /* Repassa o novo valor */ 
                 aConfig[ nPosicao ]:= aNewConfig[ nCt ] 
 
                 Mensagem( "Gravando " + ALLTrim( aConfig[ nPosicao ] ) + ", aguarde..." ) 
 
              ENDIF 
 
          NEXT 
 
          /* Grava em arquivo texto ----------------------*/ 
          Set( 24, cArqOrigem ) 
          Set( 20, "PRINT" ) 
 
          FOR nCt:= 1 TO Len( aConfig ) 
 
              IF ! "X" + Alltrim( aConfig[ nCt ] ) == "X" 
                 @ PROW(),PCOL() Say aConfig[ nCt ] + Chr( 13 ) + Chr( 10 ) 
 
              ENDIF 
 
          NEXT 
          @ PRow(), 00 Say Space(1) + Chr( 13 ) + Chr( 10 ) 
 
          Set( 24, "LPT1" ) 
          Set( 20, "SCREEN" ) 
 
          /* gravacao de informacoes no arquivo config.ini */ 
          /* CONFIG.INI CONFIG.INI CONFIG.INI CONFIG.INI -------- */ 
 
          /* Copia de arquivos (Origem x Destino) */ 
          cArqOrigem:=  "REPORT\CONFIG.INI" 
          cArqDestino:= "REPORT\CONFIG.BAK" 
 
          /* Busca arquivo Configur.Sys */ 
          aConfig:= IOFillText( MEMOREAD( cArqOrigem ) ) 
 
          __CopyFile( cArqOrigem, cArqDestino ) 
 
          FOR nCt:= 1 TO Len( aNewConfig ) 
 
              /* Pega a posicao em aNetConfig atual */ 
              cString:= Left( aNewConfig[ nCt ], AT( ",", aNewConfig[ nCt ] ) - 1 ) 
 
              /* teste da existencia da string no array */ 
              nPosicao:= ASCAN( aConfig, {|x| SubStr( Alltrim( x ), 1, AT( ",", X ) - 1 ) == cString } ) 
 
              IF nPosicao > 0 
 
                 /* Repassa o novo valor */ 
                 aConfig[ nPosicao ]:= aNewConfig[ nCt ] 
 
                 Mensagem( "Gravando " + ALLTrim( aConfig[ nPosicao ] ) + ", aguarde..." ) 
 
              ENDIF 
 
          NEXT 
 
          /* Grava em arquivo texto ----------------------*/ 
          Set( 24, cArqOrigem ) 
          Set( 20, "PRINT" ) 
 
          FOR nCt:= 1 TO Len( aConfig ) 
 
              IF ! "X" + Alltrim( aConfig[ nCt ] ) == "X" 
                 @ PROW() + 1,00 Say aConfig[ nCt ] 
 
              ENDIF 
 
          NEXT 
          @ PRow() + 1, 00 Say Space(1) + Chr( 13 ) + Chr( 10 ) 
 
          Set( 24, "LPT1" ) 
          Set( 20, "SCREEN" ) 
 
          /* Fim da gravacao em arquivo Texto -------------*/ 
 
      ELSE 
 
          Relatorio( "CONFIG.INI", SWSet( _DIR_PRINCIPAL ) ) 
 
          IF !File( SWSet( _SYS_DIRREPORT ) - "\CONFIGUR.SYS" ) 
             Mensagem( "Arquivo de configuracoes (configur.sys) nao localizado.") 
             Pausa() 
             Fim() 
          ENDIF 
 
          Relatorio( "CONFIGUR.SYS" ) 
 
      ENDIF 
 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
