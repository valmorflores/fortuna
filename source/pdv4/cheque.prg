*---------------------------------*
* Andr‚ Luiz
* Dep. de Suporte T‚cnico e Solu‡äes
* BEMATECH S/A
* andre@bematech.com.br
*---------------------------------*
# Include "Fileio.ch"
Set Status Off
Set Score Off
Set Wrap On
*-----------------------------*
* Abre a Porta de Comunica‡Æo *
*-----------------------------*
Porta := 0
Porta := FOpen("COM2", FO_READWRITE + FO_COMPAT)
*------------------------------------------------*
* Vari veis *
*-----------*
Banco := 0
Valor := 0
Favorecido := Space(45)
Local := Space(27)
Dia := 0
Mes := Space(10)
Ano := 0
*---------------------*
Do While .T.
   Set Color To
   If LastKey() = 27
      Exit
   Endif
   Clear
   Set Color To w+/g,,,,n/w,w+/g
   @ 02,01 Clear To 12,65
   @ 02,01 To 12,65 Double
   @ 02,02 Say "¹"
   @ 02,24 Say "Ì"
   @ 02,03 Say " ImpressÆo do Cheque "
   @ 04,03 Say "C¢digo do BANCO:"
   @ 05,03 Say "Valor..........:"
   @ 06,03 Say "Favorecido.....:"
   @ 07,03 Say "Localidade.....:"
   @ 08,03 Say "Data:"
   @ 09,03 Say "Dia:"
   @ 09,10 Say "Mˆs:"
   @ 09,25 Say "Ano:"
   *---------------------*
   @ 04,19 Get Banco Pict "999"
   @ 05,19 Get Valor Pict "99999999999999"
   @ 06,19 Get Favorecido Pict "@"
   @ 07,19 Get Local Pict "@"
   @ 09,07 Get Dia Pict "99"
   @ 09,14 Get Mes Pict "@"
   @ 09,29 Get Ano Pict "9999"
   Read
   Resp = Space(01)
   @ 11,02 Say "Confirma os Dados acima? (S/N):" Get Resp Pict "@!"
   Read
   If Resp = "S"
      Comando := Chr(27) + Chr(251) + "57|" + StrZero(Banco,3,0) + "|" + StrZero(Valor,14,0) + "|" + Favorecido + "|" + Local + "|" + StrZero(Dia,2,0) + "|" + Mes + "|" + StrZero(Ano,4,0) + "||" + Chr(27)
      FWrite(Porta, @Comando, Len(Comando))
      Banco := 0
      Valor := 0
      Favorecido := Space(45)
      Local := Space(27)
      Dia := 0
      Mes := Space(10)
      Ano := 0
      Loop
   Endif
   If Resp = "N"
      Loop
   Endif
EndDo
Set Color To
Clear
Return
