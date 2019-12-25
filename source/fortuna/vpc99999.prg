// ## CL2HB.EXE - Converted
 
#include "vpf.ch" 
#include "inkey.ch" 
/* 
* Modulo      - VPC99999 
* Descricao   - Modulo responsavel pelo gerenciamento de relatorios. 
* Programador - Valmor Pereira Flores 
* Data        - 06/Janeiro/1995 
* Atualizacao - 07/Janeiro/1995 
*/ 
#ifdef HARBOUR
function vpc99999()
#endif

loca cTELA:=zoom( 05, 14, 21, 41 ), cCOR:=setcolor(), nOPCAO:=0
vpbox( 05, 14, 21, 41 ) 
whil .t. 
   mensagem("") 
   setcolor(COR[12]) 
   set decimals to 2 
   aadd( MENULIST,swmenunew(06,15," 1 Clientes              ",2,COR[11],; 
        "Relacao de clientes, etiquetas, ficha financeira.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(07,15," 2 Fornecedores          ",2,COR[11],; 
        "Relacao de fornecedores e origens.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(08,15," 3 Produtos              ",2,COR[11],; 
        "Relacao de produtos, montagens.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(09,15," 4 Lista Precos <Compra> ",2,COR[11],; 
        "Relacao de listas de precos de compra.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(10,15," 5 Lista Precos <Venda>  ",2,COR[11],; 
        "Relacao de listas de precos de venda.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(11,15," 6 Estoque               ",2,COR[11],; 
        "Relacao do movimento de estoque.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(12,15," 7 Contas a Pagar        ",2,COR[11],; 
        "Controle de contas a pagar.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(13,15," 8 Contas a Receber      ",2,COR[11],; 
        "Controle de contas a receber.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(14,15," 9 Fluxo Financeiro      ",2,COR[11],; 
        "Movimento de fluxo financeiro.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(15,15," A Resumo de Operacoes   ",2,COR[11],; 
        "Resumo de operacoes de compra/venda de mercadorias.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(16,15," B Entradas & Saidas     ",2,COR[11],; 
        "Relacao de Estatisticas",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(17,15," C Vendas                ",2,COR[11],; 
        "Relatorios especificos da empresa.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(18,15," D Etiquetas Avulsas     ",2,COR[11],; 
        "Cadastro de transportadoras.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(19,15," E Outros Cadastros...   ",2,COR[11],; 
        "Mais relatorios de itens referentes a cadastros e tabelas.",,,COR[6],.T.)) 
   aadd( MENULIST,swmenunew(20,15," 0 Retorna               ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   Do Case 
      Case nOPCAO=0 .or. nOPCAO=15; exit 
      Case nOPCAO=1  ; IMPClientes() 
      Case nOpcao=2  ; IMPFornecedores() 
      Case nOPCAO=3  ; IMPProdutos() 
      Case nOpcao=4  ; IMPPrecoCompra() 
      Case nOpcao=5  ; IMPPrecoVenda() 
      Case nOPCAO=6  ; IMPEstoque() 
      Case nOPCAO=7  ; IMPAPagar() 
      Case nOpcao=8  ; IMPCtaReceber() 
      Case nOPCAO=9  ; IMPFluxo() 
      Case nOpcao=10 ; IMPResumo() 
      Case nOpcao=11 ; IMPEntSai() 
      Case nOpcao=12 ; IMPVendas() 
      Case nOpcao=13 ; IMPEtqAvulsa() 
      Case nOpcao=14 ; SubMenu() 
      Case nOpcao=20 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           cCorRes:= SetColor() 
           VPBox( 18, 40, 20, 78, , _COR_GET_BOX ) 
           SetColor( _COR_GET_EDICAO ) 
           cRelatorio:= SPACE( 8 ) 
           @ 19,42 Say "Arquivo Report:" Get cRelatorio 
           READ 
           Relatorio( ALLTRIM( cRelatorio ) + ".REP" ) 
           SetColor( cCorRes ) 
           ScreenRest( cTelaRes ) 
    EndCase 
enddo 
unzoom(cTELA) 
set decimals to 
setcolor(cCOR) 
return(nil) 
 
/***** 
�������������Ŀ 
� Funcao      � SUBMenu 
� Finalidade  � Apresentacao de Sub-menu para relatorios 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Outubro/1998 
��������������� 
*/ 
Static Function SubMenu 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 1 
 
   /* Desativa a barra de rolagem */ 
   lBarra:= SWSet( _GER_BARRAROLAGEM ) 
   SWSet( _GER_BARRAROLAGEM, .F. ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   Fortuna() 
   vpbox( 02, 34, 23, 61 )
   WHILE .T. 
      mensagem("") 
      setcolor(COR[12]) 
      set decimals to 2 
      aadd( MENULIST,swmenunew(03,35," 1 Origem/Fabricantes    ",2,COR[11],; 
           "Relacao de Fabricantes.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(04,35," 2 Vendedores            ",2,COR[11],; 
           "Relacao de vendedores cadastrados.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(05,35," 3 Classificacao Fiscal  ",2,COR[11],; 
           "Relacao de Classificacao fiscal cadastradas.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(06,35," 4 Bancos                ",2,COR[11],; 
           "Relacao de Bancos Disponiveis no Sistema.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(07,35," 5 Agencias Bancarias    ",2,COR[11],; 
           "Relacao de agencias cadastradas.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(08,35," 6 Transportadoras       ",2,COR[11],; 
           "Relacao de transportadoras do sistema.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(09,35," 7 Fichas de Receita     ",2,COR[11],; 
           "Relacao de Fichas de receita.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(10,35," 8 Fichas de Despesa     ",2,COR[11],; 
           "Relacao de Fichas de Despesa.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(11,35," 9 ICMs/Reducoes         ",2,COR[11],; 
           "Relacao da Tabela de ICMs e Reducoes.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(12,35," A Feriados              ",2,COR[11],; 
           "Resumo de operacoes de compra/venda de mercadorias.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(13,35," B Atividades            ",2,COR[11],; 
           "Relacao do cadastro de atividades.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(14,35," C Natureza de Operacoes ",2,COR[11],; 
           "Relatorios de natureza de operacoes.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(15,35," D Estados e ICMs        ",2,COR[11],; 
           "Relacao de Estados.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(16,35," E Historicos de Cobranca",2,COR[11],; 
           "Relacao de Historicos de Cobranca Cadastrados.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(17,35," F Precos Diferenciados  ",2,COR[11],; 
           "Relacao do cadastro de atividades.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(18,35," G Comissoes % & Formulas",2,COR[11],; 
           "Relacao de Percentuais de Comissao e Formulas de Calculo.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(19,35," H Formas de Pagamento   ",2,COR[11],; 
           "Relacao de Formas de Pagamento.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(20,35," I Operacoes c/ Estoque  ",2,COR[11],;
           "Cadastro de Estados.",,,COR[6],.T.)) 
      aadd( MENULIST,swmenunew(21,35," J Produtos por Pedidos  ",2,COR[11],;
           "",,,COR[6],.T.))  // gelson 10/08/2004
      aadd( MENULIST,swmenunew(22,35," 0 Retorna               ",2,COR[11],;
           "Retorna ao menu anterior.",,,COR[6],.T.)) 
      swMenu(MENULIST,@nOPCAO); MENULIST:={} 
      Do Case 
         Case nOPCAO=0 .or. nOPCAO=20; exit
         Case nOPCAO=1  ; IMPOutros( "ORIGEM/FABRICANTES", nOpcao ) 
         Case nOpcao=2  ; IMPOutros( "VENDEDORES", nOpcao ) 
         Case nOPCAO=3  ; IMPOutros( "CLASSIFICACAO FISCAL", nOpcao ) 
         Case nOpcao=4  ; IMPOutros( "BANCOS", nOpcao ) 
         Case nOpcao=5  ; IMPOutros( "AGENCIAS", nOpcao ) 
         Case nOPCAO=6  ; IMPOutros( "TRANSPORTADORAS", nOpcao ) 
         Case nOPCAO=7  ; IMPOutros( "FICHAS DE RECEITA", nOpcao ) 
         Case nOpcao=8  ; IMPOutros( "FICHAS DE DESPESA", nOpcao ) 
         Case nOPCAO=9  ; IMPOutros( "ICMs & REDUCOES", nOpcao ) 
         Case nOpcao=10 ; IMPOutros( "FERIADOS", nOpcao ) 
         Case nOpcao=11 ; IMPOutros( "ATIVIDADES", nOpcao ) 
         Case nOpcao=12 ; IMPOutros( "NATUREZA DE OPERACOES", nOpcao ) 
         Case nOpcao=13 ; IMPOutros( "ESTADOS E ICMs", nOpcao ) 
         Case nOpcao=14 ; IMPOutros( "HISTORICOS DE COBRANCA", nOpcao ) 
         Case nOpcao=15 ; IMPOutros( "PRECOS DIFERENCIADOS", nOpcao ) 
         Case nOpcao=16 ; IMPOutros( "COMISSOES - PERCENTUAIS & FORMULAS", nOpcao ) 
         Case nOpcao=17 ; IMPOutros( "FORMAS DE PAGAMENTO", nOpcao ) 
         Case nOpcao=18 ; IMPOutros( "OPERACOES COM ESTOQUE", nOpcao ) 
         Case nOpcao=19 ; IMPgOutros( "PRODUTOS POR PEDIDOS", nOpcao ) // gelson 10/08/2004
       EndCase 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   SWSet( _GER_BARRAROLAGEM, lBarra ) 
   Return Nil 
 
/* Impressao de Etiqueta */ 
Function ImpEtqAvulsa() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Priv nNumero1:= 222000000001, nNumero2:= 222000000010 
Priv cDescricao:= Space( 35 ), nValor:= 0, cBarra 
 
   vpbox( 00, 00, 22, 79, "ETIQUETAS DE BARRAS - IMPRESSORAS ELTRON", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 03,02 Say "Intervalo de Numera��es:" Get nNumero1 Pict "@R 999999999999" 
   @ 04,02 Say "                        " Get nNumero2 Pict "@R 999999999999" 
   @ 05,02 Say "Descricao..............:" Get cDescricao 
   @ 06,02 Say "Valor..................:" Get nValor Pict "@E 999999.99" 
   READ 
 
   Relatorio( "ETQBAR00.REP" ) 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
 
 
