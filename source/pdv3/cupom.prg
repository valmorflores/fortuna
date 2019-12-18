*--------------------------------------------*
*  Andr‚ Luiz
*  Departamento de Suporte T‚cnico e Solu‡äes
*  BEMATECH
*  andre@bematech.com.br
*--------------------------------------------*
#INCLUDE "Fileio.ch"
Set Status Off
Set Score Off
Set Wrap On
*----------------------------*
* Abre a Porta de Comunica‡Æo
*---------------------------------------------------*
Porta := 0
Porta := FOpen("COM2", FO_READWRITE + FO_COMPAT)
*---------------------------------------------------*
Do While .T.
   Set Color to
   If LastKey() = 27
      Set Color To
      Clear
      Exit
   Endif
   Envia := 0
   Clear
   Set Color To N/Gb,W/R,,,,W/R,N/Gb
   /*@ 01,00 Clear to 12,35*/
   /*@ 01,00 To 12,35 Double*/
   @ 05,18 Clear to 14,53
   @ 05,18 To 14,53 Double
   @ 06,19 Prompt "        Abre Cupom Fiscal         "
   @ 07,19 Prompt "Vende Item c/ duas Casas Decimais "
   @ 08,19 Prompt "Vende Item c/ trˆs Casas Decimais "
   @ 09,19 Prompt "    Vende Item Personalizado      "
   @ 10,19 Prompt "Fecha Cupom Sem Forma de Pagamento"
   @ 11,19 Prompt "Fecha Cupom Com Forma de Pagamento"
   @ 12,19 Prompt "      Cancela Cupom Fiscal        "
   @ 13,19 Prompt "           Leitura X              "

   Menu To Opcao
   Do Case
      Case Opcao = 1
           *---------------------*
           *  Abre Cupom Fiscal
           *-------------------------------------*
           Envia:=Chr(27)+Chr(251)+"00|"+Chr(27)
           FWrite(Porta, @Envia, Len(Envia))
           Loop
           *-------------------------------------*
      Case Opcao = 2

           *---------------------*
           *  Vende Item Fixo com duas Casa Decimais
           *----------------------------------------*
           Envia := Chr(27) + Chr(251) + "09|0000000000001|Impressora MP20FI Bematech   |II|0001|00000001|0001|" + Chr(27)
           FWrite(Porta, @Envia, Len(Envia))
           Loop
           *---------------------------------------------------------------------------------------------------------------*
      Case Opcao = 3
           *---------------------*
           *  Vende Item Fixo com trˆs Casa Decimais
           *----------------------------------------*
           Envia := Chr(27) + Chr(251) + "56|0000000000001|Impressora DP20Plus          |II|0001000|00010000|0010|" + Chr(27)
           FWrite(Porta, @Envia, Len(Envia))
           Loop
           *-----------------------------------------------------------------------------------------------------------------*
      Case Opcao = 4
           *-----------------------*
           *  Vende Item Gen‚rico
           *-----------------------*
           * In¡cio - Vari veis **
           *
           Codigo := Space(13)
           Descricao := Space(29)
           Aliquota := Space(2)
           Quant := 0
           V := 0
           Desco := 0
           *
           * Fim - Vari veis **
           *
           * Tela de Entrada *
           *
           Set Color To W/B+,W/N,,,W/B+
           @ 06,13 Clear To 13,58
           @ 06,13 To 13,58 Double
           @ 07,15 Say "Codigo.....:" Get Codigo Pict "@!"
           @ 08,15 Say "Descri‡Æo..:" Get Descricao Pict "@"
           @ 09,15 Say "Al¡quota...:" Get Aliquota Pict "@!"
           @ 10,15 Say "Quantidade:" Get Quant Pict "9999"
           @ 11,15 Say "Valor.....:" Get V Pict "@e 99999999"
           @ 12,15 Say "Desconto..:" Get Desco Pict "9999"
           Read
           Quantidade := Strzero(Quant,4,0)
           Valor := Strzero(V,8,0)
           Desconto := Strzero(Desco,4,0)
           Envia := Chr(27) + Chr(251) + "09|" + Codigo + "|" + Descricao + "|" + Aliquota + "|" + Quantidade + "|" + Valor + "|" + Desconto + "|" + Chr(27)
           FWrite(Porta, @Envia, Len(Envia))
           Loop
           *--------------------------------------------------------------------------------------------------------------------------------------------------*
      Case Opcao = 5
           *---------------------*
           *  Fecha cupom sem Forma de Pagamento
           *-------------------------------------*
           S_Dec := " "
           S_Escolha := " "
           Set Color To W/B+,W/N,,,W/B+
           @ 07,02 Clear To 10,33
           @ 07,02 To 10,33 Double
           @ 08,03 Say "<D>esconto ou <A>cr‚scimo..:" Get S_Dec Pict "@!" Valid(S_Dec$"DA")
           @ 09,03 Say "Por <V>alor ou <P>ercentual:" Get S_Escolha Pict "@!" Valid(S_Escolha$"VP")
           Read
           If S_Escolha = "V"
                 S_Dec := Lower(S_Dec)
                 Valor_Pago := 0
                 Valor_Dec := 0
                 Mensagem := Space(70)
                 Set Color To W/B+,W/N,,,W/B+
                 @ 09,03 Clear To 14,75
                 @ 09,03 To 14,75 Double
                 @ 10,04 Say "Valor Pago....................:" Get Valor_Pago Pict "@e 99999999999999"
                 @ 11,04 Say "Valor do Acr‚scimo ou Desconto:" Get Valor_Dec Pict "@e 99999999999999"
                 @ 12,04 Say "Mensagem Promocional:"
                 @ 13,04 Get Mensagem Pict "@"
                 Read
                 Envia := Chr(27) + Chr(251) + "10|0000|" + StrZero(Valor_Pago,14,0) + "|" + S_Dec + "|" + StrZero(Valor_Dec,14,0) + "|" + AllTrim(Mensagem) + "|" + Chr(13) + Chr(10) + Chr(27)
                 FWrite(Porta, @Envia, Len(Envia))
           EndIf
           If S_Escolha = "P"
                 Valor_Pago := 0
                 Valor_Dec := 0
                 Mensagem := Space(70)
                 Set Color To W/B+,W/N,,,W/B+
                 @ 09,03 Clear To 14,74
                 @ 09,03 To 14,74 Double
                 @ 10,04 Say "Valor Pago....................:" Get Valor_Pago Pict "@e 99999999999999"
                 @ 11,04 Say "Valor do Acr‚scimo ou Desconto:" Get Valor_Dec Pict "@e 9999"
                 @ 12,04 Say "Mensagem Promocional:"
                 @ 13,04 Get Mensagem Pict "@"
                 Read
                 Envia := Chr(27) + Chr(251) + "10|" + StrZero(Valor_Dec,4,0) + "|" + StrZero(Valor_Pago,14,0) + "|" + S_Dec + "|" + AllTrim(Mensagem) + "|" + Chr(13) + Chr(10) + Chr(27)
                 FWrite(Porta, @Envia, Len(Envia))
                 Loop
           EndIf
           *-------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
      Case Opcao = 6
           *---------------------*
           * Inicia o Fechamento com Forma de Pagamento
           *--------------------------------------------*
           Set Color to W/B+,W/N,,,W/B+
           @ 08,14 Clear to 11,45
           @ 08,14 To 11,45 Double
           Dec := " "
           Escolha := " "
           Valor := 0
           @ 09,15 Say "<D>esconto ou <A>cr‚scimo..:" Get Dec Pict "@!" Valid(Dec$"DA")
           @ 10,15 Say "Por <V>alor ou <P>ercentual:" Get Escolha Pict "@!" Valid(Escolha$"VP")
           Read
           If Escolha = "V"
                 Dec := Lower(Dec)
                 Set Color To W/B+,W/N,,,W/B+
                 @ 11,16 Clear To 13,54
                 @ 11,16 To 13,54 Double
                 @ 12,17 Say "Valor..............:" Get Valor Pict "@e 99999999999999"
                 Read
                 Envia := Chr(27) + Chr(251) + "32|" + Dec + "|" + StrZero(Valor,14,0) + "|" + Chr(27)
                 FWrite(Porta, @Envia, Len(Envia))
                 * ----------------*
                 *  Define a Forma
                 * ----------------*
                 Forma := Space(22)
                 Pago := 0
                 Set Color To W/B+,W/N,,,W/B+
                 @ 13,18 Clear To 16,64
                 @ 13,18 To 16,64 Double
                 @ 14,19 Say "Forma de Pagamento.:" Get Forma Pict "@"
                 @ 15,19 Say "Valor Pago.........:" Get Pago Pict "@e 99999999999999"
                 Read
                 Envia := Chr(27) + Chr(251) + "33|" + Forma + "|" + StrZero(Pago,14,0) + "|" + Chr(27)
                 FWrite(Porta, @Envia, Len(Envia))
           EndIf
           If Escolha = "P"
                 Set Color To W/B+,W/N,,,W/B+
                 @ 11,15 Clear To 13,42
                 @ 11,15 To 13,42 Double
                 @ 12,16 Say "Valor em Percentual:" Get Valor Pict "@e 9999"
                 Read
                 Envia := Chr(27) + Chr(251) + "32|" + Dec + "|" + StrZero(Valor,4,0) + "|" + Chr(27)
                 FWrite(Porta, @Envia, Len(Envia))
                 *---------------*
                 * Define a Forma de Pagamento
                 *---------------*
                 Forma := Space(22)
                 Pago := 0
                 Set Color To W/B+,W/N,,,W/B+
                 @ 13,17 Clear To 16,61
                 @ 13,17 To 16,61 Double
                 @ 14,18 Say "Forma de Pagamento:" Get Forma Pict "@"
                 @ 15,18 Say "Valor Pago........:" Get Pago Pict "@e 99999999999999"
                 Read
                 Envia := Chr(27) + Chr(251) + "33|" + Forma + "|" + StrZero(Pago,14,0) + "|" + Chr(27)
                 FWrite(Porta, @Envia, Len(Envia))
           EndIf
           *-------------------------------------------------------------------------------------------*
           * Inicia o Fechamento com Forma de Pagamento Para a Finaliza‡…o do CMD35 do Cupom Fiscal
           *--------------------------------------------*
           Mensagem := Space(58)
           Set Color To W/B+,W/N,,,W/B+
           @ 16,19 Clear To 19,79
           @ 16,19 To 19,79 Double
           @ 17,20 Say "Mensagem:"
           @ 18,20 Get Mensagem Pict "@"
           Read
           Envia := Chr(27) + Chr(251) + "34|" + AllTrim(Mensagem) + "|" + Chr(13) + Chr(10) + Chr(27)
           FWrite(Porta, @Envia, Len(Envia))
           Loop
           *-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*
      Case Opcao = 7
           Envia := Chr(27) + Chr(251) + "14|" + Chr(27)
           FWrite(Porta, @Envia, Len(Envia))
           Loop
      Case Opcao = 8
           Envia := Chr(27) + Chr(251) + "06|" + Chr(27)
           FWrite(Porta, @Envia, Len(Envia))


   EndCase
EndDo
Return
