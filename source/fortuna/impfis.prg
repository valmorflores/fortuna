// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � Autentica 
� Finalidade  � Autenticacao de documentos 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function Autentica( nValor, nJuros ) 
Loca cTela 
Loca cComando 
IF !FILE( SWSet( _PDV_DIRETORIO ) + "\PDV.INI" ) 
   cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Aviso( "Arquivo PDV.INI n�o foi localizado no diretorio." ) 
   Pausa() 
   ScreenRest( cTela ) 
ELSE 
 
   IF SWSet( _PDV_IMPRESSORA )=="SIGTRON-FS345" 
 
      /* Abre comprovante nao fiscal nao vinculado */ 
      cComando:= Chr( 27 ) + Chr( 217 ) + "A3" +; 
            "000000000000" + StrZero( ( nValor + nJuros ) * 100, 12, 0 ) + ; 
                             "[VALOR="+ Alltrim( Tran( nValor, "@E 9,999,999.99" ) ) +"]+[JUROS=" + ALLTRIM( Tran( nJuros,"@E 999,999.99") ) + "]" + Chr( 255 ) + Chr( 13 ) 
      Com_Send( Nil, cComando ) 
 
      /* Aciona a autenticacao mecanica na impressora */ 
      cComando:=     Chr( 27 ) + "Y*[AUT]*" + Chr( 13 ) + Chr( 10 ) 
      IF !( nJuros==Nil ) 
         cComando:= Chr( 27 ) + "YJrs:" + AllTrim( Tran( nJuros, "@E 999,999.99" ) ) + "]*" + Chr( 13 ) + Chr( 10 ) 
      ENDIF 
      Com_Send( Nil, cComando ) 
 
      /* Imprime pagamento */ 
      cComando:= Chr( 27 ) + Chr( 242 ) + "A" + ; 
           StrZero( ( nValor + IF( nJuros==Nil, 0, nJuros ) ) * 100, 12, 0 ) + " Pagamento" + Chr( 255 ) 
      Com_Send( Nil, cComando ) 
 
   ELSEIF SWSet( _PDV_IMPRESSORA )=="SIGTRON" 
      cComando:=Chr( 27 ) + "Y*[" + Tran( nValor, "@E *,***,***.**" ) + "<S&W>]" + Chr(10) 
      IF !( nJuros==Nil ) 
          cComando:= Chr( 27 ) + "Y*[" + Tran( nValor, "@E *,***,***.**" ) + Tran( nJuros, "@E *,***,***.**" ) + "<S&W>]" + Chr(10) 
      ENDIF 
      Com_Send( Nil, cComando ) 
 
   ENDIF 
 
ENDIF 
Return Nil 
 
 
Function AbreGaveta() 
  Local cComando 
  DO CASE 
     CASE SWSet( _PDV_IMPRESSORA )=="SIGTRON-FS345" 
          cComando:= Chr( 27 ) + "p000" 
          Com_Send( Nil, cComando ) 
  ENDCASE 
  Return Nil 
 
 
 
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
 
 
