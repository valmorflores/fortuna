
/*
* VPBIBNET.PRG * BIBLIOTECA DE ROTINAS PARA TRABALHO EM REDES
* Programador  - Valmor Pereira Flores
* Data         - 27/Outubro/1994
* Atualizacao  -
*
* Copyright (c) 1994-1994, Valmor Pereira Flores
* Todos os direitos reservados.
*/
#include "VPF.CH"
#include "common.ch"
#define NET_WAIT  1

/*
* Funcao      - BUSCANET
* Finalidade  - Executar uma mesma operacao inumeras vezes ate' que o arquivo
*               aceite mesmo estando em modo compartilhado.
* Parametros  - nSEGUNDOS  => Numero de segundos a realizar a pesquiza
*               bACAO      => Rotina a executar
* Programador - Valmor Pereira Flores
* Data        -
* Atualizacao -
*/
func buscanet(nSEGUNDOS,bACAO)
loca nESPERA:=nSEGUNDOS
loca cTELA:=screensave(00,00,24,79)
mensagem("Acessando arquivo, aguarde...")
whil ! (lSUCESSO:=eval(bACAO)) .AND. nSEGUNDOS>0 .AND. !lERRO
     inkey(.5)
     nSEGUNDOS:=nSEGUNDOS-.5
enddo
if (!lSUCESSO .AND. (nSEGUNDOS<=0))
   aviso("Arquivo aberto em modo exclusivo por outro usuario",24/2)
   inkey(0)
endif
screenrest(cTELA)
return lSUCESSO

/*
* Funcao      - MODONET
* Finalidade  - Determina o modo defaut para um arquivo DBF
* Parametros  - lOPENMODO (.T.) SHARED (Compartilhado) ou
*                         (.F.) EXCLUSIVE (Exclusivo)
* Retorno     - Retorna o corrente modo de abertura do arquivo
* Programador - Valmor Pereira Flores
*/
func modonet(lNOVOMODO)
stat lOPENMODO:=.T.
return(iif(lNOVOMODO!=NIL,lOPENMODO:=lNOVOMODO,lOPENMODO))

/*
* NetUse( <cDATABASE>, [<lOPENMODO>], [<nWaitSeconds>],
*         [<cAlias>], [<lNoAlert>] ) --> lSuccess
*
* Funcao      - NETUSE
* Finalidade  - Abrir um arquivo num ambiente compartilhado
* Parametros  - cDATABASE  => Nome do arquivo a abrir
*               lOPENMODO  => Modo (.T.) para compartilhado conforme modonet
*               nSEGUNDOS  => Numero de segundos a executar a tarefa, ( default e' NET_WAIT )
*               cALIAS     => Nome do apelido para arquivo ( default e' o nome do arquivo )
*               lNAOALERTA => Se verdadeiro, desativa a notificacao de falha ao usuario.
* Retorno     - Verdadeiro se o arquivo for aberto com sucesso, senao .F.
* Programador - Valmor Pereira Flores
* Data        -
* Atualizacao -
*/
Func NetUse( cDATABASE, lOPENMODO, nSEGUNDOS, cALIAS, lNAOALERTA )
loca cERRMSG             // Mensagem de erro a apresentar
loca lINFINITA            // Variavel que determina o infinito retrocesso (retry)
loca lRESULTADO := .F.   // Return value, assume the worst
// Abrir no modo determinado por modonet()
DEFAULT lOPENMODO  TO !modonet()
// Retorna a quantidade de segundos cfe. NET_WAIT
DEFAULT nSEGUNDOS  TO NET_WAIT
// Default alias para arquivo DB
DEFAULT cALIAS     TO MakeAlias( cDATABASE )
// Ativa alerta cfe. default
DEFAULT lNAOALERTA TO .F.
cErrMsg:="Arquivo nao esta disponivel ; para abertura no modo" + iif( lOPENMODO, " exclusivo.", " compartilhado" ) + "; neste momento. Tente mais tarde."
IF !File( cDataBase )
   SWAlerta( "Arquivo " + cDataBase + " bloqueado.;" + cErrMsg, { " OK " } )
   Return .F.
ENDIF
// Tenta infinitamente se nSEGUNDOS for zero
lINFINITA:=(nSEGUNDOS==0)
Mensagem( "Acessando arquivo " + cDataBase + " aguarde..." )
whil (lINFINITA .OR. (nSEGUNDOS>0))
     if lOPENMODO

        IF SWSet( _RDD_PADRAO )=="NTX"
           USE ( cDataBase ) ALIAS ( cAlias ) EXCLUSIVE VIA "DBFNTX"
        ELSEIF SWSet( _RDD_PADRAO )=="MDX"
           USE ( cDataBase ) ALIAS ( cAlias ) EXCLUSIVE VIA "DBFMDX"
        ENDIF

     else
        IF SWSet( _RDD_PADRAO )=="MDX"
           USE ( cDataBase ) ALIAS ( cAlias ) SHARED VIA "DBFMDX"
        ELSE
           USE ( cDataBase ) ALIAS ( cAlias ) SHARED VIA "DBFNTX"
        ENDIF

     endif
     if !neterr() .AND. Used()  // Se nao houver erro
         lRESULTADO:=.T.
         exit
     endif
     inkey(1)       // Espera 1 segundo
     nSEGUNDOS--
     // Emite um alerta ao usuario se NAOALERTA estiver desativado e
     // caso ocorra um erro na abertura e se INFINITA for .F.
     if ( !lNAOALERTA .AND. !lINFINITA .AND. ( nSEGUNDOS <= 0 ))
        if ( SWAlerta( cErrMsg, { "Abandona", "Continua" } ) == 2 )
           nSEGUNDOS:=NET_WAIT
        endif
     endif
enddo
return(lRESULTADO)

/*
* Funcao      - NETPACK()
* Finalidade  - Executar um pack no dbf em uso
* Retorno     - Verdadeiro se PACK for bem sucedido, senao falso
*/
func NetPack()
loca lRESULTADO := .F.    // Retorna valor de NetPack()
if !modonet() // Se o modo NAO for SHARED posso efetuar o PACK sem problema algum.
   pack
   lRESULTADO := .T.
else          // Caso contrario, tenho que reabrir o arquivo no modo EXCLUSIVE.
   if !netuse( cur_dbf, .T., NIL, NIL, .T. )
      aviso(":: TENTATIVA FALHADA! Repita a operacao ::",12)
   else
      pack
      if netuse( cur_dbf, NIL, NIL, NIL, .T. )
         lRESULTADO := .T.    // Socesso na operacao
      else    // Nova falha no PACK
         aviso("Falha na nova tentativa de PACk.",12)
      endif
   endif
endif
return(lRESULTADO)

/*
* Funcao      - NETZAP()
* Finalidade  - Executar um ZAP no dbf em uso
* Retorno     - Verdadeiro se ZAP for bem sucedido, senao falso
* ************* cuidado com o uso de ZAP - Os dados podem ser perdidos
*/
func NetZAP()
loca lRESULTADO := .F.    // Retorna o valor de NetZAP()
if !modonet() // Se o modo NAO for SHARED posso efetuar o PACK sem problema algum.
   zap
   lRESULTADO := .T.
else          // Caso contrario, tenho que reabrir o arquivo no modo EXCLUSIVE.
   if !netuse( cur_dbf, .T., NIL, NIL, .T. )
      aviso(":: TENTATIVA FALHADA! Repita a operacao ::",12)
   else
      zap
      if netuse( cur_dbf, NIL, NIL, NIL, .T. )
         lRESULTADO := .T.    // Socesso na operacao
      else    // Nova falha no ZAP
         aviso("Falha na nova tentativa de ZAP.",12)
      endif
   endif
endif
return(lRESULTADO)

/*
* Funcao      - NETAPPEND( [<nSEGUNDOS>] ) --> lSuccess
* Finalidade  - Abrir um novo registro no arquivo em uso
* Parametros  - nSEGUNDOS => Opcional numero de segundos para retentar
*                            caso haja uma falha no comando append ( defaults e' NET_WAIT )
* Retorno     - Verdadeiro se append for com sucesso.
*/
func netappend(nSEGUNDOS)
loca lINFINITA
loca lRESULTADO:=.F.
loca cErrMsg:="Impossivel abrir novo registro."
DEFAULT nSEGUNDOS TO NET_WAIT
lINFINITA:=(nSEGUNDOS==0)
whil (lINFINITA .OR. (nSEGUNDOS>0))
    dbappend()
    if !neterr()
       lRESULTADO := .T.
       exit
    endif
    inkey(.5)         // Aguarda 1/2 segundo
    nSEGUNDOS-=.5
    // Pergunta ao usuario se aborta ou retry
    if (!lRESULTADO .AND. !lINFINITA .AND. (nSEGUNDOS<=0))
       if ( SWAlerta( cErrMsg, {"Abortar","Continuar"} ) == 2 )
          nSEGUNDOS:=NET_WAIT
       endif
    endif
enddo
return(lRESULTADO)

/*
* Funcao     - NetRLock( [<nSegundos>] ) --> lSuccess
* Finalidade - Esta funcao obtem um registro bloqueado
* Parametros - nSegundos => Opcional numero de segundos para retentar
*                           caso haja uma falha no comando RLOCK ( defaults e' NET_WAIT )
* Retorno    - Verdadeiro se o registro foi bloqueado
*/
func NetRLock( nSegundos )
Loca cTela:= ScreenSave( 0, 0, 24, 79 )
loca lRESULTADO:=.F.
loca cERRMSG:="Bloqueio de registro = " + StrZero( RECNO(), 08, 0 ) + " em " + Alias() + "."
DEFAULT nSegundos TO NET_WAIT
lINFINITA:=(nSegundos==0)
WHILE nSegundos > 0
   IF Rlock()
      lResultado:= .T.
      Exit
   ENDIF
   inkey(.5)
   nSegundos-=.5
   // Pergunta ao usuario se aborta ou retry
   if nSegundos<=0
      if ( ( nOpcao:= SWAlerta( cERRMSG, { "Continuar", "Detalhes", "Abandonar" } ) )==1 )
         nSegundos:=NET_WAIT
      elseif nOpcao==2
         i := 1
         nLin:= 3
         nCol:= 3
         VPBox( 02, 02, 22, 76, "INFORMACOES", _COR_GET_EDICAO )
         SetColor( _COR_GET_EDICAO )
         @ 03,03 Say "Detalhamento para auxilio ao suporte..."
         @ 04,03 Say " "
         lMarcar:= .T.
         lFalha:= .F.
         WHILE ( !Empty(ProcName(i)) )
              lFalha:= .F.
              IF ProcLine(i) > 0 .AND. lMarcar
                 lMarcar:= .F.
                 lFalha:= .T.
              ENDIF
              @ ++nLin,nCol Say PAD( Trim(ProcName(i)) + "(" + LTRIM( STR(ProcLine(i) )) + ")  ", 19 ) + IF( lFalha, "*", "" )
              i++
              IF nLin > 20
                 Inkey( 0 )
                 Scroll( 04, 03, 21, 75, 0 )
                 nLin:= 4
              ENDIF
         ENDDO
         nAreaRes:= Select()
         FOR nCt:= 1 TO 255
             DBSelectAr( nCt )
             IF USED()
                @ ++nLin, nCol Say PAD( ALIAS(), 5 ) + " °°±±²² " + STRZERO( RECNO(), 6, 0 ) + " Û"
                IF nLin > 20
                   Inkey( 0 )
                   Scroll( 04, 03, 21, 75, 0 )
                   nLin:= 4
                ENDIF
             ENDIF
         NEXT
         DBSelectAr( nAreaRes )
         Inkey( 0 )
         ScreenRest( cTela )
         lResultado:=.F.
         EXIT
      else
         lResultado:=.F.
         EXIT
      endif
   endif
ENDDO
Return( lResultado )














 ******************
* Service routines *
 ******************

/*
*
*  MakeAlias( cString ) --> cALIASName
*
*  Takes cString and parses it, removing drive, path, and extension
*  information, returning only the filename
*
*  Parameters:
*     cString - The string to parse
*
*  Returns: The filename contained in cString
*
*/
func MakeAlias(cSTRING)
loca nPOS
if ((nPOS:=rat("\",cSTRING))!=0)
    cSTRING:=substr(cSTRING,++nPOS)
endif
if((nPOS:=rat(".",cSTRING))!=0)
    cSTRING:=substr(cSTRING,1,--nPos)
endif
return(cSTRING)
