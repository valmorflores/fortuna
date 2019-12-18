*---------------------------------------------*
*---------------------------------------------*
#Include "Fileio.ch"
 !MODE COM2:9600,n,8,1
 Porta := 0
 Porta := FOpen("COM2", FO_READWRITE + FO_COMPAT)
*------------------------------------------------------------------------*
* Leitura X
*
 Comando := Chr(2) + Chr(4) + Chr(0) + Chr(27) + Chr(6) + Chr(33) + Chr(0)
 FWrite(Porta, @Comando, Len(Comando))
*------------------------------------------------------------------------*
* Abre Cupom Fiscal
*
* Comando := Chr(2) + Chr(4) + Chr(0) + Chr(27) + Chr(0) + Chr(27) + Chr(0)
* FWrite(Porta, @Comando, Len(Comando))
*------------------------------------------------------------------------*
* Vende Item
*---------------------------------------*
/*Cod := "0000000000001"
For x1 := 1 To 13
    Codigo := SubStr(Cod,x1,1)
    ? Asc(Codigo)
Next x1
Inkey(0)
*----------------------------------------*
Clear
Descri := "boneca da xuxa               "
For x2 := 1 To 29
    Descricao := SubStr(Descri,x2,1)
    ? Asc(Descricao)
Next x2
Inkey(0)
*----------------------------------------*
Clear
Aliq := "FF"
For x3 := 1 To 2
    Aliquota := SubStr(Aliq,x3,1)
    ? Asc(Aliquota)
Next x3
Inkey(0)
*----------------------------------------*
Clear
Q := 10
Qtde := StrZero(Q,4,0)
For x4 := 1 To 4
    Quantidade := SubStr(Qtde,x4,1)
    ? Asc(Quantidade)
Next x4
Inkey(0)
*----------------------------------------*
Clear
V := 100
Va := StrZero(V,8,0)
For x5 := 1 To 8
    Valor := SubStr(Va,x5,1)
    ? Asc(Valor)
Next x5
Inkey(0)
*----------------------------------------*
Clear
D := 0
Desc := StrZero(D,4,0)
For x6 := 1 To 4
    Desconto := SubStr(Desc,x6,1)
    ? Asc(Desconto)
Next x6
Inkey(0)
*----------------------------------------*
*********
* FWrite(Porta, @Comando, Len(Comando))
*------------------------------------------------------------------------*
* Fecha Cupom s/ Pagamento
*

* FWrite(Porta, @Comando, Len(Comando))
******
*/
Return
