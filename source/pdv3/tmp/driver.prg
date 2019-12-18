Function Com_Send( cDriver, cComando, nSend )
ret:=space(70)
arqopen:= fopen("SIGFIS",2)
fwrite(arqopen,cComando,IF( nSend==Nil, Len(cComando), nSend ))
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
arqopen:= fopen("SIGFIS",2)
cRetorno:= Space( nTamanho )
fread( arqopen, @cRetorno, nTamanho )
fclose( arqopen )
Return cRetorno

Function LeRetorno()
Return Nil

