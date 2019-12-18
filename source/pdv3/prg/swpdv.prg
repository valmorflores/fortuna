/*
旼컴컴컴컴컴컴컴컴컴컴컴�    Soft&Ware Inform쟴ica    컴컴컴컴컴컴컴컴컴컴컴커
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

                         旼컴컴컴커 旼컴컴�   旼�    旼�
                         � 旼컴커 � � 旼� 읕� � �    � �
                         � �    � � � � 읕� � � �    � �
        旼컴컴컴컴�      � 읕컴켸 � � �   � � � 읏  粕 �     旼컴컴컴컴�
        읕컴컴컴컴�      � 旼컴컴켸 � �   � � 읏 읏粕 粕     읕컴컴컴컴�
                         � �        � � 旼� �  읏 잎 粕
                         � �        � 읕� 旼�   읏  粕
                         읕�        읕컴컴�      읕켸

旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

 Historico de Modificacoes:
 08/03/2000 - Gravacao do Codigo de Filial nos replace's
 01/03/2000 - Informacao de Condicao de Pagamento em dinheiro no PDV.INI = ForPagDinheiro p/ BematechFI2
 29/02/2000 - Lancamento de estoque havia uma falha onde lancamentos de cancelamento
              de item estavam saindo do estoque no campo saldo, embora o lancamento no
              movimento estivesse sendo feito corretamente.
 20/01/2000 - Venda na impressora Bematech estava desconsiderando o valor pago,
              imprimindo um saldo negativo no troco.
 15/01/2000 - Lancamento na moreda dinheiro


 Modificacoes Necessarias:
 Movimentacao de Produtos Montados


*/

#Include "VPF.CH"
#include "COMMON.CH"
#include "INKEY.CH"
#Include "COMANDOS.CH"

   Local Local1, Local2
   Local cVersao := "SWPDV v2.1-23"
   Private ProtecaoTela:= 10
   Private ModoDeVideo:= 2
   Private CodigoFilial:= 0
   Private ForPagDinheiro:= "01"


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
   ? "Compativel ou um driver VESA residente em mem줿ia para a"
   ? "Utilizacao deste aplicativo"
   return Nil


