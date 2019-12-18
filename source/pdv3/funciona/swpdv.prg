/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ    Soft&Ware Inform tica    ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

                         ÚÄÄÄÄÄÄÄÄ¿ ÚÄÄÄÄÄ¿   ÚÄ¿    ÚÄ¿
                         ³ ÚÄÄÄÄ¿ ³ ³ ÚÄ¿ ÀÄ¿ ³ ³    ³ ³
                         ³ ³    ³ ³ ³ ³ ÀÄ¿ ³ ³ ³    ³ ³
        ÚÄÄÄÄÄÄÄÄÄ¿      ³ ÀÄÄÄÄÙ ³ ³ ³   ³ ³ ³ À¿  ÚÙ ³     ÚÄÄÄÄÄÄÄÄÄ¿
        ÀÄÄÄÄÄÄÄÄÄÙ      ³ ÚÄÄÄÄÄÄÙ ³ ³   ³ ³ À¿ À¿ÚÙ ÚÙ     ÀÄÄÄÄÄÄÄÄÄÙ
                         ³ ³        ³ ³ ÚÄÙ ³  À¿ ÀÙ ÚÙ
                         ³ ³        ³ ÀÄÙ ÚÄÙ   À¿  ÚÙ
                         ÀÄÙ        ÀÄÄÄÄÄÙ      ÀÄÄÙ

ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

 Historico de Modificacoes:
 08/03/2000 - Gravacao do Codigo de Filial nos replace's
 01/03/2000 - Informacao de Condicao de Pagamento em dinheiro no PDV.INI = ForPagDinheiro p/ BematechFI2
 29/02/2000 - Lancamento de estoque havia uma falha onde lancamentos de cancelamento
              de item estavam saindo do estoque no campo saldo, embora o lancamento no
              movimento estivesse sendo feito corretamente.
 20/01/2000 - Venda na impressora Bematech estava desconsiderando o valor pago,
              imprimindo um saldo negativo no troco.
 15/01/2000 - Lancamento na moeda dinheiro


 Modificacoes Necessarias:
 Movimentacao de Produtos Montados


*/

#Include "..\FORTUNA\VPF.CH"
#Include "VPF.CH"
#include "COMMON.CH"
#include "INKEY.CH"
#Include "COMANDOS.CH"

   Local Local1, Local2
   Local cVersao:= _VER
   Private ProtecaoTela:= 10
   Private ModoDeVideo:= 2
   Private CodigoFilial:= 0
   Private ForPagDinheiro:= "01"
   Private aConficaoDivida:= ""
   Private lAgendaCliente:= .F.

   REQUEST DBFNTX
   REQUEST DBFNTX
   RDDSetDefault( "DBFNTX" )

   nMode:= 2
   Altd( 1 )
   SetCursor( 0 )
   SET EPOCH TO 1980
   SET DATE BRITISH
   SET SCOREBOARD OFF
   SET DELETED ON



   Keyboard Chr( 0 )
   Clear TypeaHead
   Relatorio( "PDV.INI" )

   CLS
   TestVModes()
   Local2:= {19, 257, 259, 261}
   Local1:= 1
   nMode:= ModoDeVideo
   SetBlink( .F. )

   fProForPag() // Programacao das Formas de Pagamento

   SetGMode( Local2[nMode] )
   SetHires( 0 )
   Sistema( @cVersao )
   Settext()
   fFim()
   Return Nil


********************************
procedure TESTVMODES

   Local aModes
   amodes:= {{19, "VGA       320x200 256 color"}, {257, ;
      "SVGA      640x480 256 color"}, {259, ;
      "SVGA      800x600 256 color"}, {261, ;
      "SVGA      1024x768 256 color"}}
   ? "Modo Grafico Detectado"
   ? "======================"
   ?
   for i:= 1 to Len(amodes)
      if (getgmode(amodes[i][1]) != 0)
         ? Str(i, 2) + "  "
         ?? amodes[i][2]
      endif
   next
   ?
   ? "Para Suporte ao modo SuperVGA sera necessario uma  placa"
   ? "Compativel ou um driver VESA residente em mem¢ria para a"
   ? "Utilizacao deste aplicativo"
   return Nil


