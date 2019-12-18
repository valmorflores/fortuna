/***
*
*       Errorsys.prg
*
*  Standard Clipper error handler
*
*  Copyright (c) 1990-1993, Computer Associates International, Inc.
*  All rights reserved.
*
*  Compile:  /m /n /w
*
*/


#Define _HELPDESK    "HelpDesk - Ligue 0xx51-3346.7913 / 0xx51-9112.8364"

#include "vpf.ch"
#include "error.ch"
#include "inkey.ch"

// put messages to STDERR
#command ? <list,...>   =>  ?? Chr(13) + Chr(10) ; ?? <list>
#command ?? <list,...>  =>  OutErr(<list>)


// used below
#define NTRIM(n)                ( LTrim(Str(n)) )



/***
*       ErrorSys()
*
*       Note:  automatically executes at startup
*/

proc ErrorSys()
        ErrorBlock( {|e| DefError(e)} )
return




/***
*       DefError()
*/
static func DefError(e)
local i, cMessage, aOptions, nChoice
Local nLin, nCol, lMarcar
Local cString:= "", lFalha

  Static nContInternal


        // by default, division by zero yields zero
        if ( e:genCode == EG_ZERODIV )
                return (0)
        end


        // for network open error, set NETERR() and subsystem default
        if ( e:genCode == EG_OPEN .and. e:osCode == 32 .and. e:canDefault )

                NetErr(.t.)
                return (.f.)                                                                    // NOTE

        end


        // for lock error during APPEND BLANK, set NETERR() and subsystem default
        if ( e:genCode == EG_APPENDLOCK .and. e:canDefault )

                NetErr(.t.)
                return (.f.)                                                                    // NOTE

        end



        // build error message
        cMessage := ErrorMessage(e)


        //@ 00,00 Say cMessage
        //Pausa()


        // build options array
        // aOptions := {"Break", "Quit"}
        aOptions := {"Finaliza"}

        if (e:canRetry)
                AAdd(aOptions, "Retorna")
        end

        if (e:canDefault)
                AAdd(aOptions, "Continua")
        end


        // put up alert box
        nChoice := 0


        IF nContInternal == Nil
           nContInternal:= 0
        ELSE
           ++nContInternal
        ENDIF

        IF e:osCode == 55 .OR. e:osCode == 51
           Mensagem( "Acessando o arquivo " + ALIAS() + "  #" + StrZero( nContInternal, 6, 0 ) + ", aguarde... " )
           Inkey(.1)

           IF nContInternal < 10
              dbUnLockAll()
              !DIR >NUL
              Return( .T. )
           ELSE
              nContInternal:= 0
              Mensagem( "Bloqueio de arquivo! Pressione [ENTER] para continuar..." )
              Inkey( 0 )
              nChoice:= 2
           ENDIF

        ENDIF

        while ( nChoice == 0 )

                if ( Empty(e:osCode) )
                        nChoice := Alert( cMessage, aOptions )

                else
                        nChoice := Alert( cMessage + ;
                                           ";(DOS Error " + NTRIM(e:osCode) + ")", ;
                                           aOptions )
                end

                //Return( .T. )

                if ( nChoice == NIL )
                        exit
                end

        end



        if ( !Empty(nChoice) )

                // do as instructed
                if ( aOptions[nChoice] == "Para" )
                        Break(e)

                elseif ( aOptions[nChoice] == "Retorna" )
                        return (.t.)

                elseif ( aOptions[nChoice] == "Continua" )
                        return (.f.)

                end

        end


        // display message and traceback
        if ( !Empty(e:osCode) )
                cMessage += " (DOS Error " + NTRIM(e:osCode) + ") "
        end

        /// INICIO BLOCO ////
        Set Device To Screen
//        SetColor( _COR_ALERTA_BOX )
//        @ 02,02 Say cMessage
//        @ 03,02 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        i:= 2
        nLin:= 3
        nCol:= 2
        cString:= ""
        cString+= Chr( 13 ) + Chr( 10 )
        cString+= "Dia " + DTOC( DATE() ) + " as " + TIME() + "h." + Chr( 13 ) + Chr( 10 )
        cString+= StrTran( cMessage, "Error", "Exce‡„o" ) + Chr( 13 ) + Chr( 10 )
        cString+= "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 )
        lMarcar:= .T.
        lFalha:= .F.
        WHILE ( !Empty(ProcName(i)) )
             lFalha:= .F.
             IF ProcLine(i) > 0 .AND. lMarcar
                lMarcar:= .F.
                lFalha:= .T.
             ENDIF
             cString+= "" + PAD( Trim(ProcName(i)) + "(" + NTRIM(ProcLine(i)) + ")  ", 19 ) + IF( lFalha, "*", "" ) + Chr( 13 ) + Chr( 10 )
             i++
             IF nLin >21
                nLin:= 3
                nCol:= nCol + 20
             ENDIF
        ENDDO
        cString+= "Ambiente & Status do FortunaÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 )
        cString+= "Versao   " + _VER + Chr( 13 ) + Chr( 10 )
        cString+= "Arquivo  " + Alias( Select() ) + Chr( 13 ) + Chr( 10 )
        cString+= "Area     " + StrZero( Select(), 03, 00 ) + Chr( 13 ) + Chr( 10 )
        cString+= "Indice   " + IndexKey( IndexOrd() ) + Chr( 13 ) + Chr( 10 )
        cString+= "Ordem    " + StrZero( IndexOrd(), 03, 00 ) + Chr( 13 ) + Chr( 10 )
        cString+= "Registro " + StrZero( Recno(), 10, 00 ) + Chr( 13 ) + Chr( 10 )
        cString+= "GDir     " + M->GDir + Chr( 13 ) + Chr( 10 )
        cString+= "---------" + Chr( 13 ) + Chr( 10 )
        cString+= "Usuario  " + M->WUsuario + Chr( 13 ) + Chr( 10 )

        cString+= Chr( 13 ) + Chr( 10 )
        MEMOWRIT( "LOG.TXT", cString )
        IF File( "ERRO.TXT" )
           !Copy LOG.TXT + ERRO.TXT TEMPORA.TXT >NUL
           !Copy TEMPORA.TXT ERRO.TXT >NUL
        ELSE
           !Copy LOG.TXT ERRO.TXT >NUL
        ENDIF
        /// FIM BLOCO ///

        MEMOWRIT( "TELA.TMP", ScreenSave( 0, 0, 24, 79 ) )

        /* Exibicao em Video */
        VPBox( 06, 08, 18, 68, DTOC( DATE() ) + " " + TIME() + "h", "15/01" )
        SetColor( "11/01" )
        @ 08,10 Say M->WUSUARIO Color "10/01"
        @ 10,10 Say " Em decorrˆncia de uma execu‡„o imprevista, o  sistema  "
        @ 11,10 Say " ser  suspenso garantindo assim a seguranca e preserva- "
        @ 12,10 Say " cao da integridade de sua base de dados.               "
        @ 13,10 Say " Caso esta mensagem se repita neste memsmo modulo con-  "
        @ 13,10 Say " Contacte nosso servico de suporte tecnico.             "
        @ 16,10 Say "                                               FORTUNA  " Color "06/01"
        Mensagem( _HELPDESK )
        SetColor( "00/00" )

        Inkey(0)
        CLS
        cString:= "SET CLIPPER=F255 "  + Chr( 13 ) + Chr( 10 )
        cString+= "VPCEI1U2.EXE "      + StrZero( M->nGCodUser, 3, 0 ) + "" + Chr( 13 ) + Chr( 10 )
        cString+= "CALL EXECUTAR.BAT " + Chr( 13 ) + Chr( 10 )

        MEMOWRIT( "EXECUTAR.BAT", cString )


        // give up
        ErrorLevel(1)

        Finaliza(1)

return (.f.)


Function Alert( cMensagem, aOpcoes )
Local nCt
Local nOpcao:= 1, nTecla, nArea, nLinha:= 3, nColuna:= 1, lSom:= .F.
Local cString, cDevice:= Set( 20, "SCREEN" )
Local nLin, nCol, i, cMessage, lFalha, lMarcar
Local cTela:= ScreenSave( 0, 0, 24, 79 )

   VPBox( 01, 13, 11, 63, "<<< EXECUCAO INTERROMPIDA >>>", "15/08", .T., .T. )
   nLinha:= 3
   nColuna:= 0
   IF cMensagem==Nil
      cMensagem:= ""
   ENDIF
   cString:= "ALERTA °°±±²²" + Chr( 13 ) + Chr( 10 )
   cString+= "Dia " + DTOC( DATE() ) + " as " + TIME() + "h." + Chr( 13 ) + Chr( 10 )
   cString+= StrTran( cMensagem, "Error", "Exce‡„o" ) + Chr( 13 ) + Chr( 10 )
   cString+= "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 )
   MEMOWRIT( "LOG.TXT", cString )
   IF File( "ERRO.TXT" )
      !Copy LOG.TXT + ERRO.TXT TEMPORA.TXT >NUL
      !Copy TEMPORA.TXT ERRO.TXT >NUL
   ELSE
      !COPY LOG.TXT ERRO.TXT >NUL
   ENDIF
   cMensagem:= StrTran( UPPER( cMensagem ), "ERROR", "" )
   cMensagem:= StrTran( UPPER( cMensagem ), "ERRO",  "" )
   cMensagem:= ALLTRIM( cMensagem )
   cMensagem:= StrTran( cMensagem, "   ", " " )
   cMensagem:= StrTran( cMensagem, "  ",  " " ) + " "
   cMensagem:= PAD( cMensagem, 450, "±" )
   FOR nCt:= 1 TO Len( cMensagem )
       IF SubStr( cMensagem, nCt, 1 ) $ ";" .OR. nColuna >= 49
          IF SubStr( cMensagem, nCt, 1 ) == "±"
             EXIT
          ENDIF
          ++nLinha
          nColuna:= 0
       ELSE
          ++nColuna
          @ nLinha,nColuna+13 Say SubStr( cMensagem, nCt, 1 ) Color "14/08"
          IF lSom
             Tone( 8, 0.01 )
          ENDIF
       ENDIF
       IF Inkey() <> 0
          lSom:= .F.
       ENDIF
   NEXT
   IF AT( "PRINT", UPPER( cMensagem ) ) > 0
      VPBox( 07, 13, 17, 63, " IMPRESSORA DESABILITADA ", "15/02" )
      SetColor( "14/02" )
      Mensagem( _HELPDESK )
      @ 09,15 Say " Verifique se a impressora  est  ligada ou se o"
      @ 10,15 Say " cabo est  conectado. Caso opere em  rede, cer-"
      @ 11,15 Say " tifique-se de que o servidor de impress„o  es-"
      @ 12,15 Say " teja ativo e que seu computador possua a  con-"
      @ 13,15 Say " figuracao adequada.                           "
      @ 14,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/02"
      @ 15,15 Say "    [ENTER]Continua  [ESC]Desviar Impressao    " Color "15/02"
      nTecla:= Inkey( 0 )
      IF nTecla==K_ENTER
         nOpcao:= 2
      ELSE
         Set( 24, "ERROPRN.PRN" )
         nOpcao:= 2
      ENDIF
      Set( 20, cDevice )

  ELSEIF AT( "(DOS 4)", UPPER( cMensagem ) ) > 0
      nArea:= Select()
      VPBox( 07, 13, 17, 63, " LIMITE DE 256 ARQUIVOS EXCEDIDO ", "15/04" )
      SetColor( "14/04" )
      Mensagem( _HELPDESK )
      @ 09,15 Say " Este aplicativo nÆo pode ser aberto mais de   "
      @ 10,15 Say " uma vez no mesmo computador em Windows 95/98  "
      @ 11,15 Say " e tambem nÆo deve ser utilizado com outro pro-"
      @ 12,15 Say " grama de base de dados em MS-DOS.             "
      @ 14,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/04"
      @ 15,15 Say "        [ENTER][ESC]Finaliza o Sistema         " Color "15/04"
      nTecla:= Inkey( 0 )
      DBSelectAr( nArea )
      DBCloseAll()
      nTecla:= K_ESC
      Set( 20, cDevice )
      IF nTecla== K_ENTER .OR. Chr( nTecla ) $ "Cc"
         nOpcao:= Len( aOpcoes )
      ELSE
         nOpcao:= 1
      ENDIF
      MEMOWRIT( "EXECUTAR.BAT", "CLS" )

      Mensagem( "Pressione [ALT+TAB] para verificar se esta aberto o aplicativo." )
      INKEY( 4 )

      QUIT

  ELSEIF AT( "CORRUPTION", UPPER( cMensagem ) ) > 0 .AND.;
         AT( "DBF", UPPER( cMensagem ) ) > 0
      nArea:= Select()
      VPBox( 07, 13, 17, 63, " ARQUIVO DA BASE DE DADOS CORROMPIDO ", "15/04" )
      SetColor( "14/04" )
      Mensagem( _HELPDESK )
      UseDBFGrupo()
      DBGoTop()
      WHILE !EOF()
         IF GRP->AREA == nArea
            EXIT
         ENDIF
         DBSkip()
      ENDDO
      IF !GRP->( EOF() )
         @ 09,15 Say " O Arquivo " + GRP->ARQUIVO + " est  com problemas "
         @ 12,15 Say " Entre em contato com o revendedor do FORTUNA.  " Color "10/04"
         @ 13,15 Say " Se tiver reg. na Soft&Ware Contacte o suporte!" Color "10/04"
         @ 14,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/04"
         @ 15,15 Say "    [ENTER]Continua  [ESC]Finaliza o Sistema   " Color "15/04"
         nTecla:= Inkey( 0 )

        /// INICIO BLOCO ////
        Set Device To Screen
//        SetColor( _COR_ALERTA_BOX )
//        @ 02,02 Say cMessage
//        @ 03,02 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        i:= 2
        nLin:= 3
        nCol:= 2
        cString:= ""
        cString+= Chr( 13 ) + Chr( 10 )
        cString+= "Dia " + DTOC( DATE() ) + " as " + TIME() + "h." + Chr( 13 ) + Chr( 10 )
        if cMessage == NIL
           cMessage := ""
        endif
        cString+= StrTran( cMessage, "Error", "Exce‡„o" ) + Chr( 13 ) + Chr( 10 )
        cString+= "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 )
        lMarcar:= .T.
        lFalha:= .F.
        WHILE ( !Empty(ProcName(i)) )
             lFalha:= .F.
             IF ProcLine(i) > 0 .AND. lMarcar
                lMarcar:= .F.
                lFalha:= .T.
             ENDIF
             cString+= "" + PAD( Trim(ProcName(i)) + "(" + NTRIM(ProcLine(i)) + ")  ", 19 ) + IF( lFalha, "*", "" ) + Chr( 13 ) + Chr( 10 )
             i++
             IF nLin >21
                nLin:= 3
                nCol:= nCol + 20
             ENDIF
        ENDDO
        cString+= "Ambiente & Status do FortunaÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 )
        cString+= "Versao   " + _VER + Chr( 13 ) + Chr( 10 )
        cString+= "Arquivo  " + Alias( Select() ) + Chr( 13 ) + Chr( 10 )
        cString+= "Area     " + StrZero( Select(), 03, 00 ) + Chr( 13 ) + Chr( 10 )
        cString+= "Indice   " + IndexKey( IndexOrd() ) + Chr( 13 ) + Chr( 10 )
        cString+= "Ordem    " + StrZero( IndexOrd(), 03, 00 ) + Chr( 13 ) + Chr( 10 )
        cString+= "Registro " + StrZero( Recno(), 10, 00 ) + Chr( 13 ) + Chr( 10 )
        cString+= "GDir     " + M->GDir + Chr( 13 ) + Chr( 10 )
        cString+= "---------" + Chr( 13 ) + Chr( 10 )
        cString+= "Usuario  " + M->WUsuario + Chr( 13 ) + Chr( 10 )

        cString+= Chr( 13 ) + Chr( 10 )
        MEMOWRIT( "LOG.TXT", cString )
        IF File( "ERRO.TXT" )
           !Copy LOG.TXT + ERRO.TXT TEMPORA.TXT >NUL
           !Copy TEMPORA.TXT ERRO.TXT >NUL
        ELSE
           !Copy LOG.TXT ERRO.TXT >NUL
        ENDIF
        /// FIM BLOCO ///
        IF nTecla==K_ESC
           QUIT
        ELSE
           DBSelectAr( nArea )
           DBReindex()
           DBCloseAll()
           VPTela()
           VPC15000()
           nTecla:= K_ENTER
           Set( 20, cDevice )
           IF nTecla== K_ENTER .OR. Chr( nTecla ) $ "Cc"
              nOpcao:= Len( aOpcoes )
           ELSE
              nOpcao:= 1
           ENDIF
         ENDIF
      ELSE
         @ 09,15 Say " Falha Grave! Problemas em seu disco rigido... "
         @ 10,15 Say " Favor favor entrar em contato com o revendedor"
         @ 11,15 Say " FORTUNA ou caso possua registro,contacte nosso"
         @ 12,15 Say " suporte tecnico.                              "
         @ 13,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/04"
         @ 14,15 Say "    [ENTER]Continua  [ESC]Finaliza o Sistema   " Color "15/04"
         nTecla:= Inkey( 0 )
         DBSelectAr( nArea )
         nOpcao:= 1
      ENDIF

  ELSEIF AT( "CORRUPTION", UPPER( cMensagem ) ) > 0
      nArea:= Select()
      VPBox( 07, 13, 17, 63, " ARQUIVO DE INDICE CORROMPIDO ", "15/04" )
      SetColor( "14/04" )
      Mensagem( _HELPDESK )
      UseDBFGrupo()
      DBGoTop()
      WHILE !EOF()
         IF GRP->AREA == nArea
            EXIT
         ENDIF
         DBSkip()
      ENDDO
      IF !GRP->( EOF() )
         @ 09,15 Say " O Arquivo " + GRP->ARQUIVO + " est  com  seus indices"
         @ 10,15 Say " desatualizados em rela‡„o ao banco de dados.  "
         @ 12,15 Say " O sistema ir  reformul -los automaticamente.  "
         @ 14,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/04"
         @ 15,15 Say "    [ENTER]Continua  [ESC]Finaliza o Sistema   " Color "15/04"
         nTecla:= Inkey( 0 )
         DBSelectAr( nArea )
         DBReindex()
         DBCloseAll()
         VPTela()
         VPC15000()
         nTecla:= K_ENTER
         Set( 20, cDevice )
         IF nTecla== K_ENTER .OR. Chr( nTecla ) $ "Cc"
            nOpcao:= Len( aOpcoes )
         ELSE
            nOpcao:= 1
         ENDIF
      ELSE
         @ 09,15 Say " Falha Grave! Problemas em indices/arquivos    "
         @ 10,15 Say " Favor fazer uma reindexa‡„o no banco de dados "
         @ 11,15 Say " para continuar trabalhando sem problemas deste"
         @ 12,15 Say " tipo.                                         "
         @ 13,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/04"
         @ 14,15 Say "    [ENTER]Continua  [ESC]Finaliza o Sistema   " Color "15/04"
         nTecla:= Inkey( 0 )
         DBSelectAr( nArea )
         nOpcao:= 1
      ENDIF

  ELSEIF AT( "CREATE", UPPER( cMensagem ) ) > 0
      VPBox( 07, 13, 17, 63, " REDE / DIRETORIO DE DADOS INDISPONIVEL ", "15/09" )
      SetColor( "14/09" )
      Mensagem( _HELPDESK )
      @ 09,15 Say " Verifique o diretorio de procura dos dados do "
      @ 10,15 Say " sistema. Caso opere em rede, certifique-se de "
      @ 11,15 Say " que o mapeamento de Rede esteja destinado  ao "
      @ 12,15 Say " servidor de forma adequada."
      @ 13,15 Say " Dados.: " + M->GDir  Color "11/09"
      @ 14,15 Say " Report: " + SWSet( _SYS_DIRREPORT )  Color "11/09"
      @ 15,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ " Color "10/09"
      @ 16,15 Say "    [ENTER]Continua  [ESC]Finaliza o Sistema   " Color "15/09"
      nTecla:= Inkey( 0 )
      Set( 20, cDevice )
      IF nTecla== K_ENTER .OR. Chr( nTecla ) $ "Cc"
         nOpcao:= Len( aOpcoes )
      ELSE
         nOpcao:= 1
      ENDIF
  ELSE

      VPBox( 07, 13, 17, 63, " OPERACAO INDISPONIVEL ", "15/09" )
      SetColor( "14/09" )
      Mensagem( _HELPDESK )
      @ 09,15 Say " Esta Operacao nao est  disponivel no  momento"
      @ 10,15 Say " ou deve estar recebendo melhorias pela equipe"
      @ 11,15 Say " de desenvolvimento FORTUNA.                  "
      @ 12,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "10/09"
      @ 13,15 Say " Caso esta mensagem se repita neste modulo con"
      @ 14,15 Say " tacte-nos relatando o ocorrido.              "
      @ 15,15 Say " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "10/09"
      @ 16,15 Say "    [ENTER]Continua  [ESC]Finaliza o Sistema  " Color "15/09"
      nTecla:= Inkey( 0 )
      Set( 20, cDevice )
      IF Chr( nTecla ) $ "Cc" .OR. nTecla==K_ENTER
         nOpcao:= Len( aOpcoes )
      ELSEIF nTecla==K_ESC
         nOpcao:= 1
      ENDIF
  ENDIF
  ScreenRest( cTela )
  Inkey( 3 )

Return nOpcao


/***
*       ErrorMessage()
*/
static func ErrorMessage(e)
local cMessage


        // start error message
        cMessage := if( e:severity > ES_WARNING, "Error ", "Warning " )


        // add subsystem name if available
        if ( ValType(e:subsystem) == "C" )
                cMessage += e:subsystem()
        else
                cMessage += "???"
        end


        // add subsystem's error code if available
        if ( ValType(e:subCode) == "N" )
                cMessage += ("/" + NTRIM(e:subCode))
        else
                cMessage += "/???"
        end


        // add error description if available
        if ( ValType(e:description) == "C" )
                cMessage += ("  " + e:description)
        end


        // add either filename or operation
        if ( !Empty(e:filename) )
                cMessage += (": " + e:filename)

        elseif ( !Empty(e:operation) )
                cMessage += (": " + e:operation)

        end


return (cMessage)


