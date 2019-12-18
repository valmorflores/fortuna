/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Autentica
³ Finalidade  ³ Autenticacao de documentos
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Autentica( nValor, nJuros )
Local cComando:=Chr( 27 ) + "Y*[" + Tran( nValor, "@E *,***,***.**" ) + "<S&W>]" + Chr(10)
IF !( nJuros==Nil )
    cComando:= Chr( 27 ) + "Y*[" + Tran( nValor, "@E *,***,***.**" ) + Tran( nJuros, "@E *,***,***.**" ) + "<S&W>]" + Chr(10)
ENDIF
Com_Send( Nil, cComando )
Return Nil


Function Com_Send( cDriver, cComando, nSend )
ret:=space(70)
cComa:= cComando
arqopen:= fopen("SIGFIS",2)
fwrite( arqopen, cComa, IF( nSend==Nil, Len(cComa), nSend ) )
fclose(arqopen)
Return Nil

Function Com_Open()
Return Nil

Function Com_Init
Return Nil

Function Com_RTS
Return Nil

Function Com_DTR
Return Nil

Function Com_CTS
Return Nil

Function Com_Count
Return Nil

Function Com_Read( cDriver, nTamanho )
Private cRetorno:= Space( nTamanho )
Private arqopen:=  fopen("SIGFIS",2)
fread( arqopen, @cRetorno, nTamanho )
fclose( arqopen )
Return cRetorno

Function LeRetorno()
Return Nil


