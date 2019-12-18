#include "FILEIO.CH"
#include "VPF.CH"


Function Com_Send( cDriver, cComando, nSend )

IF Driver=="W2000"

#ifdef _SIGTRON
   Ret:= Space( 70 )

   !COPY COMANDOS.LOG TEMP.TMP >NUL
   !COPY TEMP.TMP + ENTER.XXX + PARAM.TXT COMANDOS.LOG >NUL

   //// Cria arquivo de parametro
   CriaParam()

   //// Grava comando no arquivo de parametro
   arqopen:= fopen("Param.txt",2)
   fwrite( arqopen, cComando, Len( cComando ) )
   fclose( arqopen )

   //// Cria arquivo de liberacao para leitura
   Arq:= FCreate("Ready.ctl",FC_NORMAL)
   Fclose( Arq )

#endif

ELSE

   Ret:= Space( 70 )
   arqopen:= fopen("SIGFIS",2)
   fwrite( arqopen, cComando, Len( cComando ) )
   fclose( arqopen )

ENDIF
Return Nil

Function Com_Read( cDriver, nTamanho )
Local Start, End
Local nVezes:= 0
IF Driver=="W2000"

#ifdef _SIGTRON
   Start:= SECONDS()
   WHILE .T.
       End:= SECONDS()
       IF File( "OK.CTL" )
          Arqopen:= FOPEN( "RETORNO.TXT" )
          cRetorno:= Space( nTamanho )
          FRead( arqopen, @cRetorno, nTamanho )
          FClose( arqopen )
          FErase( "OK.CTL" )
          IF File( "PARAM.TXT" )
             FErase( "PARAM.TXT" )
          ENDIF
          !COPY COMANDOS.LOG TEMP.TMP >NUL
          !COPY TEMP.TMP + RETORNO.TXT COMANDOS.LOG >NUL
          //FErase( "RETORNO.TXT" )
          EXIT
       ELSEIF ( End ) > ( Start + 5.0 )    // TIME-OUT de 5 segundos
          cRetorno:= "ERRO!"
          //FErase( "RETORNO.TXT" )
          EXIT
       ENDIF
   ENDDO
#endif

ELSE
   arqopen:= fopen("SIGFIS",2)
   cRetorno:= Space( nTamanho )
   fread( arqopen, @cRetorno, nTamanho )
   fclose( arqopen )
ENDIF
Return cRetorno


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

Function LeRetorno()
Return Nil

#ifdef _SIGTRON

Function CriaParam()
 // No momento da criacao do parametro do comando e nescessario apagar
 // o arquivo de resposta da operacao anterior
 Start:=SECONDS()
 WHILE File("OK.ctl")
    End:=SECONDS()             // TIME-OUT de 3 segundos
    If (End)>(Start+5.0)
       Exit
    Endif
    erase OK.ctl
 ENDDO
 // E importante a construcao do laco para garantir que este arquivo
 // realmente sera apagado, um time-out para nao trancar o sistem tambem

 Arq=FCreate("Param.txt",FC_NORMAL) // Criando o arquivo de parametros
 Fclose(Arq)                        // do proximo comando

 Return Nil

#endif
