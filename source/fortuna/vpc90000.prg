// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC900000 
³ Finalidade  ³ Menu de Vendas 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/
#ifdef HARBOUR
function vpc90000()
#endif

loca cTELA:=zoom(10,14,20,36), cCOR:=setcolor(), nOPCAO:=0 
vpbox( 08, 14, 18, 36 ) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew( 09,15," 1 Nota Fiscal      ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de notas fiscais.",,,; 
        COR[6],.T.)) 
   AAdd(MENULIST,menuNew( 10,15," 2 Pedidos          ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de pedidos de clientes.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew( 11,15," 3 Romaneio         ",2,COR[11],; 
        "ImpressÆo de Romaneio de Saida.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew( 12,15," 4 Precos           ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de precos de venda.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew( 13,15," 5 Estatistica      ",2,COR[11],; 
        "Dados estatisticos por cliente.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew( 14,15," 6 Similaridade     ",2,COR[11],; 
        "Similaridade entre itens.",,,COR[6],.T.)) 
 
   aadd(MENULIST,menunew( 15,15," 7 Convenios        ",2,COR[11],; 
        "Informacoes sobre convenios/conveniados.",,,COR[6],.T.)) 
 
   aadd(MENULIST,menunew( 16,15," 8 Garantia         ",2,COR[11],; 
        "Informacoes de Garantias s/ produtos & Vendas.",,,COR[6],.T.)) 
 
   aadd(MENULIST,menunew( 17,15," 0 Retorna          ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=9; exit 
      case nOPCAO=1; VPC55500() 
      case nOPCAO=2; MenuPedido() 
      case nOPCAO=3; ImpRomaneio() 
      case nOPCAO=4; VPC98700() 
      case nOPCAO=5; PESTATISTICA()  /* MODULO: VPC799999.PRG */ 
      case nOpcao=6; VPC35120() 
      case nOpcao=7; VPC35130() 
      case nOpcao=8; VPC35140() 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ MENUPEDIDO 
³ Finalidade  ³ Menu p/ lancamento dos pedidos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function MenuPedido() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 1 
IF SWSet( _PED_FORMATO ) == 2 
   VPC88888() 
ELSE 
   vpbox( 10, 29, 21, 51 ) 
   whil .t. 
 
      // Tamanho da folha ===== com 10 chr - - - - - - // 
      mensagem("") 
      aadd(MENULIST,menunew( 11, 30, " 1 Assistente       ",2,COR[ 11 ],; 
           "Pedidos no Formato Telemarketing.",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menuNew( 12, 30, " 2 CPD              ",2,COR[ 11 ],; 
           "Inclusao de pedidos de clientes - Formato CPD.",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menunew( 13, 30, " 3 Pendentes        ",2,COR[ 11 ],; 
           "Relacao de Pedidos Pendentes por Transportadora (ROTA).",,,COR[6],.T.)) 
      AAdd(MENULIST,menunew( 14, 30, " 4 Manual / Cotacao ",2,COR[ 11 ],; 
           "Inclusao / Alteracao de Cotacoes manualmente.",,,COR[ 6 ],.T.)) 
      @ 15, 30 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color COR[ 11 ] 
      AAdd(MENULIST,menunew( 16, 30, " 5 Selecao Multipla ",2,COR[ 11 ],; 
           "Seleciona Pedidos p/ Entrega.",,,COR[6],.T.)) 
      @ 17, 30 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color COR[ 11 ] 
      AAdd(MENULIST,menunew( 18, 30, " 6 Pesquisas        ",2,COR[ 11 ],; 
           "Pesquisas sobre pedidos.",,,COR[6],.T.)) 
      @ 19, 30 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color COR[ 11 ] 
      AAdd(MENULIST,menunew( 20, 30, " 0 Retorna          ",2,COR[ 11 ],; 
           "Retorna ao menu anterior.",,,COR[6],.T.)) 
      menumodal(MENULIST,@nOPCAO); MENULIST:={} 
      DO CASE 
         CASE nOPCAO=0 .OR. nOPCAO=7; exit 
         CASE nOpcao=1 
              VPC88700() 
         CASE nOPCAO=2 
              VPC88800() 
         CASE nOpcao==3 
              VPC88870() 
         CASE nOpcao==4 
              VPC88770() 
         CASE nOpcao==5 
              MenuSelecao() 
         CASE nOpcao==6 
              MenuPedPesq() 
      ENDCASE 
   enddo 
ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
Function MenuSelecao() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 1 
 
   vpbox( 17, 49, 21, 71 ) 
   whil .t. 
 
      mensagem("") 
      aadd(MENULIST,menunew( 18, 50, " 1 Selecionar       ",2,COR[ 11 ],; 
           "Fazer uma nova selecao",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menuNew( 19, 50, " 2 Ver Selecoes     ",2,COR[ 11 ],; 
           "Verificacao de Selecoes Realizadas.",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menunew( 20, 50, " 0 Retorna          ",2,COR[ 11 ],; 
           "Retorna ao menu anterior.",,,COR[6],.T.)) 
      menumodal(MENULIST,@nOPCAO); MENULIST:={} 
      DO CASE 
         CASE nOPCAO=0 .OR. nOPCAO=3; exit 
         CASE nOpcao=1 
              VPC88780() 
         CASE nOPCAO=2 
              VisualSelPedido() 
      ENDCASE 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
Function MenuPedPesq() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOpcao:= 1 
 
   vpbox( 15, 49, 21, 71 ) 
   whil .t. 
 
      mensagem("") 
      aadd(MENULIST,menunew( 16, 50, " 1 Aproveitamento   ",2,COR[ 11 ],; 
           "Verificar o aproveitamento de pedidos.",,,COR[6],.T.)) 
      AAdd(MENULIST,menuNew( 17, 50, " 2 Lancamentos      ",2,COR[ 11 ],; 
           "Verificar pedidos lancados por periodo.",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menuNew( 18, 50, " 3 Lanc. Por Midia  ",2,COR[ 11 ],; 
           "Verificar Lancamentos por midia.",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menuNew( 19, 50, " 4 Controle Reserva ",2,COR[ 11 ],; 
           "Verificar Lancamentos por midia.",,,; 
           COR[6],.T.)) 
      AAdd(MENULIST,menunew( 20, 50, " 0 Retorna          ",2,COR[ 11 ],; 
           "Retorna ao menu anterior.",,,COR[6],.T.)) 
      menumodal(MENULIST,@nOPCAO); MENULIST:={} 
      DO CASE 
         CASE nOpcao=0 .OR. nOPCAO=5; exit 
         CASE nOpcao=1 
              VPC88011() 
         CASE nOpcao=2 
              VPC88012() 
         CASE nOpcao=3 
              VPC88013() 
         CASE nOpcao=4 
              VPC88014() 
      ENDCASE 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
 
