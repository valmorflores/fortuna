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

 01/10/2003 - COMPATIBILIDADE COM TEF 

 06/01/2003 - Criacao da variavel FormasDePagamento:= {}, possibilitando que o sistema registre nas devidas formas
 08/03/2000 - Gravacao do Codigo de Filial nos replace's
 01/03/2000 - Informacao de Condicao de Pagamento em dinheiro no PDV.INI = ForPagDinheiro p/ BematechFI2
 29/02/2000 - Lancamento de estoque havia uma falha onde lancamentos de cancelamento
              de item estavam saindo do estoque no campo saldo, embora o lancamento no
              movimento estivesse sendo feito corretamente.
 20/01/2000 - Venda na impressora Bematech estava desconsiderando o valor pago,
              imprimindo um saldo negativo no troco.
 15/01/2000 - Lancamento na moeda dinheiro

 Modificacoes Necessarias:
            - Movimentacao de Produtos Montados
            - Compatibilizacao do PDV com Windows 2000 e XP, pois, estes sistemas nao permitem o uso das funcoes TIME e SECOUNDS

*/

#Include "VPF.CH"
#include "COMMON.CH"
#include "INKEY.CH"
#Include "COMANDOS.CH"

#Define _VER    "Versao 3.0"



   Local Local1, Local2
   Local cVersao:= _VER
   Private ProtecaoTela:= 10
   Private ModoDeVideo:= 2
   Private CodigoFilial:= 0
   Private ForPagDinheiro:= "01"
   Private aConficaoDivida:= ""
   Private lAgendaCliente:= .F.
   Private lTef:= .F.

   && Verificar e avisar o limite de credito a cada selecao de produto
   Private ProdLimCredito:= .F.

   && Formas de Pagamento para lancamentos nos registradores fiscais  CHEQUE / CARTAO / DINHEIRO / CREDIARIO
   Private FormasDePagamento:= { "000-Dinheiro" }


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
   Local2:= { 19, 257, 259, 261, 18, 16 }
   Local1:= 1
   nMode:= ModoDeVideo
   SetBlink( .F. )

   fProForPag() // Programacao das Formas de Pagamento

   SetGMode( Local2[ nMode ] )
   SetHires( 0 )


   //@ 01,01 SAY TimeH() //HoraAtual()
   //@ 02,01 SAY DATE()

   //INKEY(0)
   //@ 01,01 SAY TIME()
   //INKEY(0)
   //@ 03,01 SAY SECONDS()
   //INKEY(0)

   Sistema( @cVersao )
   Settext()
   fFim()
   Return Nil


********************************
procedure TESTVMODES

   Local aModes
   amodes:= {{19,  " -> VGA       320x200 256 color  " },;
             {257, " -> SVGA      640x480 256 color  " },;
             {259, " -> SVGA      800x600 256 color  " },;
             {261, " -> SVGA      1024x768 256 color " },;
             {18,  " -> VGA       640x480 16 color   " },;
             {16,  " -> VGA       640x325 16 color   " } }
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




////// FUNCOES DA BIBLIOTECA VPBIBL96 ///////
FUNCTION SWSet( nCodigo, cConteudo )
LOCAL nPosicao
Static aSWSet
IF aSWSet == NIL
   IF cConteudo <> NIL
      aSWSet:= {}
      AAdd( aSWSet, { nCodigo, cConteudo } )
   ENDIF
ELSE
   nPosicao:= ASCAN( aSWSet, {|x| x[1] == nCodigo } )
   IF cConteudo == NIL
      IF ! nPosicao==0
         Return aSWSet[ nPosicao ][ 2 ]
      ELSE
         Return Nil
      ENDIF
   ELSE
      IF nPosicao == 0
         AAdd( aSWSet, { nCodigo, cConteudo } )
      ELSE
         aSWSet[ nPosicao ][ 2 ]:= cConteudo
      ENDIF
   ENDIF
ENDIF

Function Aviso( cMensagem )
@ 24,00 Say cMensagem

Function Diretorio( cDiretorio )
  MemoWrit( Alltrim( cDiretorio ) + "\X.TMP", "..." )
  IF !File( Alltrim( cDiretorio ) + "\X.TMP" )
     Return .F.
  ELSE
     Ferase( Alltrim( cDiretorio ) + "\X.TMP" )
     Return .T.
  ENDIF


Function VPBox( nLin1, nCol1, nLin2, nCol2 )
DispBox( nLin1, nCol1, nLin2, nCol2 )



Function HoraAtual()
Local nHora, nMinuto, nSegundo
   DosGetTime( @nHora, @nMinuto, @nSegundo )
Return StrZero( nHora, 2, 0 ) + ":" + StrZero( nMinuto, 2, 0 ) + ";" + StrZero( nSegundo, 2, 0 ) 



Function Pausa()
 Inkey(0)
