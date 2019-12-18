#Include "INKEY.CH"
#Include "COMMON.CH"
#Include "VPF.CH"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Relatorio
³ Finalidade  ³ Impressao de relatorio
³ Parametros  ³ cFile=>Nome do Aruivo
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Nil
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION Relatorio( cFile, cDiretorio, lLeFormatos, lFormatar )
LOCAL cTela:= SAVESCREEN(00,00,24,79), lRelatorio:= .T.
IF cDiretorio == Nil
   cDiretorio:= SWSet( _SYS_DIRREPORT )
   IF cDiretorio==Nil
      if at( "\", CurDir() ) > 4 
         cDiretorio:= "\" + Curdir()
      else
         cDiretorio:= Curdir()
      endif
   ENDIF
ENDIF

/*---------------------------------------------------------------------------
   Nota Fiscal Especifica
   Verifica se e Nota Fiscal e se existe o REPORT
   <nfiscal> correspondente a empresa que se esta trabalhando exemplo
   F:\FORTUNA\GENERIC\NFISCAL.001 em caso de rede ou
   C:\FORTUNA\REPORT\NFISCAL.001 em caso de desktop
                                                             Valmor P. Flores
---------------------------------------------------------------------------*/

cFile:= UPPER( cFile )
IF AT( "NFISCAL", cFile ) > 0
   IF AT( "0", GDir ) > 0
      nCodEmpresa:= VAL( SubStr( GDir, AT( "\0", GDir ) + 2 ) )
      IF FILE( cDiretorio - "\" - ( cArq:= LEFT( cFile, AT( ".", cFile ) ) + StrZero( nCodEmpresa, 3, 0 ) ) )
         cFile:= cArq
      ENDIF
   ENDIF
ENDIF

IF FILE( ALLTRIM( cDiretorio - "\" - cFile ) )
   Impressao( ALLTRIM( cDiretorio - "\" - cFile ), lLeFormatos, lFormatar )
   IF LastKey()==K_ESC
      lRelatorio:= .F.
   ELSE
      lRelatorio:= .T.
   ENDIF
ELSE
   Aviso( "Arquivo " + cDiretorio - "\" - cFile +" nao encontrado neste diret¢rio...", 12 )
   Pausa()
   lRelatorio:= .F.
ENDIF
RESTSCREEN( 00, 00, 24, 79, cTela )
RETURN lRelatorio

STATIC FUNCTION DispStatus( cArquivo, nLinha, cProcesso, lFlag, nControl )
LOCA cCor:= SETCOLOR(), cDevice
Local aSubChar
IF SET( 20 )=="PRINT" .OR. nControl<>Nil
   cDevice:= SET( 20, "SCREEN" )
ELSE
   RETURN Nil
ENDIF

IF lFlag
   VPBOX(01,01,07,65,"Monitor de Relatorio","12/04",.T.,.T.,"14/12")
   SetColor( "15/04" )
   DEVPOS( 02, 02 ); DEVOUT("Sistema Gerador de Relatorios (REP)          ")
   DEVPOS( 03, 02 ); DEVOUT("Hora.........: "  )   // + TIME()
   DEVPOS( 04, 02 ); DEVOUT("Arquivo......: " + cArquivo )
   DEVPOS( 05, 02 ); DEVOUT("Linha........: " + LTRIM( STR( nLinha ) ) )
   DEVPOS( 06, 02 ); DEVOUT("Processo.....: " + LEFT( cProcesso, 45 ) )
   VPBOX( 08, 01, 21, 65, ,"15/01" )
ENDIF
SETCOLOR( "15/04" )
SCROLL( 03, 17, 06, 64 )
DEVPOS( 03, 17 ) //; DEVOUT( TIME() )
DEVPOS( 04, 17 ); DEVOUT( cArquivo )
DEVPOS( 05, 17 ); DEVOUT( LTRIM( STR( nLinha ) ) )
DEVPOS( 06, 17 ); DEVOUT( LEFT( cProcesso, 45 ) )
IF ! Left( cProcesso, 1 ) $ ":$" + Chr( 27 )
   SetColor( "15/01" )
   Scroll( 09, 02, 20, 64, 1 )
   @ 20,02 Say Left( cProcesso, 62 )
ENDIF
SET( 20, cDevice )
SETCOLOR(cCor)
RETURN NIL

STATIC FUNC IMPRESSAO( cARQUIVO, lLeFormatos, lFormatar )
Local GetList:= {}, MenuList:= {}
LOCAL aImp:={}, aImpFORMAT:={}, aImpRESSAO:={},;
      cCAMPO, lPulaLinha:= .F.,;
      nLargura:=80, nCt, nCt2, nPosIni, nPosFim, cString, cImpressao,;
      variavel, VIf, cVariavel, nComando, nQtd, nLocalTam, nVarTam,;
      nIf:= 0, aImpTmp, aWhileCondicoes,;
      nDiferenca, nQuantTirar, Verificador, lJump:=.F., aDefinicoes:={},;
      lPassadaDupla:= .F.

WHILE .T.

   IF lLeFormatos == Nil
      lLeFormatos:= .T.
   ENDIF

   IF lLeFormatos

      cCAMPO:=FILELE( cARQUIVO )

      /* Cria matriz com os dados de impressao */
      aImpressao:= FileTOArray( cCAMPO )

      /* Faz substituicao de alguns comandos de RTF */
      FOR nCt:= 1 TO Len( aImpressao )
         aImpressao[ nCt ]:= StrTran( aImpressao[ nCt ], "\'ab", "®" )
         aImpressao[ nCt ]:= StrTran( aImpressao[ nCt ], "\'bb", "¯" )
         aImpressao[ nCt ]:= StrTran( aImpressao[ nCt ], "\'rdblquote ", ["] )
         aImpressao[ nCt ]:= StrTran( aImpressao[ nCt ], "\'ldblquote ", ["] )
      NEXT

      /* Adiciona Finalizacao */
      //AAdd( aImpressao, "$FIM" )

      /* TRATAMENTO DE ; AO FINAL DA LINHA */
      FOR nCt:= 1 TO Len( aImpressao )

          /* verifica a existencia de ; na extrema direita */
          IF RIGHT( ALLTRIM( aImpressao[ nCt ] ), 1 )==";" .AND.;
             (    nCt+1 < Len( aImpressao )   )

             /* Concatena esta linha com a anterior */
             aImpressao[ nCt ]:= LEFT( RTRIM( aImpressao[ nCt ] ),;
                                  LEN( RTRIM( aImpressao[ nCt ] ) ) -1 ) +;
                                  aImpressao[ nCt+1 ]

             /* Limpa Informacoes da proxima linha */
             ADEL( aImpressao, nCt+1 )
             ASIZE( aImpressao, Len( aImpressao )-1 )

             /* Forca o reprocessamento da mesma linha pode podera haver
                a divisao da mesma em mais partes */
             nCt:= ( nCt-1 )

          ENDIF
      NEXT

      /* TRATAMENTO DE IFs ELSEs & ENDIFs EM aImpressao */
      aWhileCondicoes:= {}
      nWhile:= 0
      nWhilePrincipal:= 0
      nIf:= 0
      nIfPrincipal:= 0
      aImpTmp:= {}
      FOR nCt:= 1 TO LEN( aImpressao )
          /* IF  ELSE  ENDIF */
          IF UPPER( LEFT( ALLTRIM( aImpressao[ nCt ] ), 3 ) )=="IF "
             /* Adiciona IF */
             IF nIf == 0
                ++nIfPrincipal
             ENDIF
             ++nIf
             cIf:= StrZero( nIfPrincipal, 2, 0 ) + StrZero( nIf, 3, 0 )
             AAdd( aImpTmp, "VaiPara( !( " + SubStr( ALLTRIM( aImpressao[ nCt ] ), 4 ) + " ), Else" + cIf + " )" )
          ELSEIF UPPER( LEFT( ALLTRIM( aImpressao[ nCt ] ), 5 ) )=="ENDIF"
             /* Verifica a existencia de um Else */
             cIf:= StrZero( nIfPrincipal, 2, 0 ) + StrZero( nIf, 3, 0 )
             IF ASCAN( aImpTmp, ":Else"+cIf ) <= 0
                AAdd( aImpTmp, ":Else" + cIf )
             ENDIF
             /* Adiciona ENDIF */
             AAdd( aImpTmp, ":EndIf" + cIf )
             --nIf
          ELSEIF UPPER( LEFT( ALLTRIM( aImpressao[ nCt ] ), 4 ) )=="ELSE"
             /* ELSE */
             cIf:= StrZero( nIfPrincipal, 2, 0 ) + StrZero( nIf, 3, 0 )
             // Acrescenta um VaiPara( EndifXXXX )
             AAdd( aImpTmp, "VaiPara( EndIf" + cIf + " )" )
             AAdd( aImpTmp, ":Else" + cIf )
          ELSE
             /* WHILE ENDDO */
             IF UPPER( LEFT( ALLTRIM( aImpressao[ nCt ] ), 6 ) )=="WHILE "
                /* Adiciona WHILE */
                IF nWhile==0
                   aWhileCondicoes:= 0
                   aWhileCondicoes:= {}
                   ++nWhilePrincipal
                ENDIF
                ++nWhile
                cWhile:= StrZero( nWhilePrincipal, 2, 0 ) + StrZero( nWhile, 3, 0 )
                cWhileCondicao:= SubStr( ALLTRIM( aImpressao[ nCt ] ), 6 )
                AAdd( aWhileCondicoes, cWhileCondicao )
                AAdd( aImpTmp, ":While" + cWhile )
                AAdd( aImpTmp, "VaiPara( !( " + cWhileCondicao + " ), EndDo" + cWhile + " )" )
             ELSEIF UPPER( LEFT( ALLTRIM( aImpressao[ nCt ] ), 5 ) )=="ENDDO"
                IF nWhile > Len( aWhileCondicoes ) .OR. nWhile <= 0
                   Aviso( "REPORT: ENDDO na linha " + Str( nCt ) + " esta incorreto." )
                   Pausa()
                   Return Nil
                ENDIF
                cWhileCondicao:= aWhileCondicoes[ nWhile ]
                cWhile:= StrZero( nWhilePrincipal, 2, 0 ) + StrZero( nWhile, 3, 0 )
                AAdd( aImpTmp, "VaiPara( (" + cWhileCondicao + " ), While" + cWhile + " )" )
                AAdd( aImpTmp, ":EndDo" + cWhile )
                --nWhile
             ELSEIF LEFT( ALLTRIM( aImpressao[ nCt ] ), 1 )=="@"
                /* Posiciona apartir da arroba na margem da esquerda */
                AAdd( aImpTmp, StrTran( LTRIM( aImpressao[ nCt ] ), "@", "" ) )
             ELSE
                /* Comando normal */
                AAdd( aImpTmp, aImpressao[ nCt ] )
             ENDIF
          ENDIF
      NEXT

      /* Arquivo Temporario */
      cDevTmp:= Set( 24 )
      Set( 24, "XXX.XXX" )
      Set( 20, "PRINT" )
      FOR nCt:= 1 TO LEN( aImpTmp )
          @ PROW(),PCOL() Say ALLTRIM( aImpTmp[ nCt ] ) + Chr( 13 ) + Chr( 10 )
      NEXT
      Set( 20, "SCREEN" )
      Set( 24, cDevTmp )

      /* COPIA aImpTmp para aImpressao */
      aImpressao:= aclone( aImpTmp )

      /* Cria duas replicas de aImpRESSAO */
      FOR nCT:=1 TO LEN( aImpRESSAO )
          AADD( aImp, IF( LEFT( ALLTRIM( aImpRESSAO[nCT] ), 1 )==":",;
               ALLTRIM( SUBSTR( ALLTRIM( aImpRESSAO[nCT] ), 2 ) ), "" ) )
          AADD( aImpFormat, aImpRESSAO[nCT] )
      NEXT

      FOR nCt:=1 TO Len( aImpressao )
          /* Comando INCLUDE para Chamar um arquivo externo de definicoes */
          IF LEFT( UPPER( LTRIM( aImpressao[nCt] ) ), 8 ) == "$INCLUDE"
             IF !File( ALLTRIM( SWSet( _SYS_DIRREPORT ) - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) )
                Aviso( "Arquivo " + ALLTRIM( SWSet( _SYS_DIRREPORT ) - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) + " nao foi localizado. ", 12 )
                Pausa()
             ENDIF

             cDefines:= MEMOREAD( ALLTRIM( SWSet( _SYS_DIRREPORT ) - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) )
             aDefines:= IOFillText( cDefines )
             FOR nCt2:= 1 TO LEN( aDefines )
                 AADD( aDefinicoes, SUBSTR( aDefines[nCt2], 9 ) )
                 aImp[nCt]:="$_DEFINICAO_$"
             NEXT
          ENDIF
      NEXT

      /* Pesquisa as definicoes de $define */
      FOR nCt:=1 TO LEN( aImpRESSAO )
          IF LEFT( UPPER( LTRIM( aImpRESSAO[nCt] ) ), 7 ) == "$DEFINE"
             AADD( aDefinicoes, SUBSTR( ALLTRIM( aImpressao[nCt] ), 9 ) )
             aImp[nCt]:="$_DEFINICAO_$"
          ENDIF
      NEXT

      /* Faz a substituicao cfe. definicoes */
      FOR nCt:=1 TO LEN( aDefinicoes )

          /* Pega a posicao inicial do sinal > na variavel */
          nPosIni:= AT( ">", aDefinicoes[nCt] )

          /* Faz a pesquisa na matriz principal */
          FOR nCt2:=1 TO LEN( aImpFormat )

             /* Pega a string a ser substituida */
             cString:= ALLTRIM( LEFT( aDefinicoes[nCt], nPosIni -1 ) )

             IF AT( cString, aImpressao[nCt2] ) >0 .AND. aImp[nCt2]<>"$_DEFINICAO_$"

                /* Pega a que ira substituir a anterior */
                cVariavel:= ALLTRIM( SUBSTR( aDefinicoes[nCt], nPosIni + 1 ) )

                /* Faz a substituicao de strings */
                aImpFormat[nCt2]:= STRTRAN( aImpressao[nCt2], cString, cVariavel )
                aImpressao[nCt2]:= STRTRAN( aImpressao[nCt2], cString, cVariavel )

             ENDIF
          NEXT
      NEXT

      FOR nCt:= 1 TO Len( aImpressao )
          IF ( nPosicao:= AT( ":=", aImpressao[ nCt ] ) ) > 0 .AND.;
             !( AT( "$", aImpressao[ nCt ] ) > 0 )
             aImpressao[ nCt ]:= "$SetVariavel( '" + ;
                                 AllTrim( Left( aImpressao[ nCt ], nPosicao - 1 ) ) +;
                                 "', '" + Alltrim( SubStr( aImpressao[ nCt ], nPosicao + 2 ) ) + " ' )"
          ELSEIF AT( "(", aImpressao[ nCt ] ) > 0 .AND.;
                 AT( "(", aImpressao[ nCt ] ) <= 20 .AND.;
                 ( ( AT( "(", ALLTRIM( aImpressao[ nCt ] ) ) < AT( " ", ALLTRIM( aImpressao[ nCt ] ) ) ) .OR.;
                     AT( " ", ALLTRIM( aImpressao[ nCt ] ) ) <= 0 ) .AND.;
                 !( AT( "$", aImpressao[ nCt ] ) > 0 ) .AND.;
                 !( AT( "®", aImpressao[ nCt ] ) > 0 ) .AND.;
                 !( Left( AllTrim( aImpressao[ nCt ] ), 1 ) == ":" ) .AND.;
                 !( AT( "/*", aImpressao[ nCt ] ) > 0 .OR. AT( "//", aImpressao[ nCt ] ) > 0 )

             aImpressao[ nCt ]:= "$" + AllTrim( aImpressao[ nCt ] )
          ENDIF
          nPosicao:= 0
      NEXT

      IF SWDispStatus()
         DispStatus( cArquivo, nCt, aImpFormat[1], .T., 1 )
      ENDIF


      /* Arquivo Temporario *.CMP */
      cDevTmp:= Set( 24 )
      Set( 24, "CMD.XXX" )
      Set( 20, "PRINT" )
      FOR nCt:= 1 TO LEN( aImpTmp )
          @ PROW(),PCOL() Say ALLTRIM( aImpTmp[ nCt ] ) + Chr( 13 ) + Chr( 10 )
      NEXT
      Set( 20, "SCREEN" )
      Set( 24, cDevTmp )



      /* Verifica se ‚ para armazenar em buffer */
      IF !lFormatar == Nil
         /* guarda as definicoes em buffer para uma futura utilizacao */
         SWSet( 10101010, aImpressao )
         SWSet( 20202020, aImpFormat )
         SWSet( 30303030, aImp )
      ENDIF

   ELSE

      /* Busca definicoes que estao guardadas em buffer, nos enderecos abaixo */
      aImpressao:= SWSet( 10101010 )
      aImpFormat:= SWSet( 20202020 )
      aImp:=       SWSet( 30303030 )
      nCt:= 1

      IF SWDispStatus()
         DispStatus( cArquivo, nCt, aImpFormat[1], .T., 1 )
      ENDIF

   ENDIF





   /* INTERPRETACAO DO RELATORIO */
   FOR nCT:=1 to Len( aImpressao )

       IF SWDispStatus()
          DispStatus( cArquivo, nCt, aImpFormat[nCt], .F. )
       ENDIF

       IF INKEY()==27 .OR. NEXTKEY()==27 .OR. LASTKEY()==27
          SET( 20, "SCREEN" )
          RETURN Nil
       ENDIF

       nComando:=0
       lJump:= .F.

       IF UPPER( LEFT( ALLTRIM( aImpressao[nCt] ), 8 ) )=="$VAIPARA"
          nComando:= 4
       ELSEIF AT( "$LINHAON",  UPPER( aImpressao[nCT] ) ) >0
          lPulaLinha:= .T.
          aImp[nCT]:= "*_NULA_*"
       ELSEIF AT( "$LINHAOFF", UPPER( aImpressao[nCT] ) ) >0
          lPulaLinha:= .F.
          aImp[nCT]:= "*_NULA_*"
       ELSEIF AT( "$LARGURA",  UPPER( aImpressao[nCT] ) ) >0
          nComando:=6
       ELSEIF AT( "$CALL",     UPPER( aImpressao[nCT] ) ) >0
          nComando:=7
       ELSEIF AT( "$RETORNA",  UPPER( aImpressao[nCt] ) ) >0
          nComando:=8
       ELSEIF AT( "$DEFINE",   UPPER( aImpressao[nCt] ) ) >0
          nComando:=9
       ELSEIF AT( "$FIM",      UPPER( aImpressao[nCt] ) ) >0
          SubChar( 0 )
          RETURN Nil
       ELSEIF AT( "$PASSADADUPLA", UPPER( aImpressao[nCt] ) ) >0
          lPassadaDupla:= .T.
          aImp[nCT]:= "*_NULA_*"
       ELSEIF LEFT( ALLTRIM( aImpRESSAO[nCt] ), 1 ) == "$"
          nComando:= 1
       ELSEIF LEFT( ALLTRIM( aImpRESSAO[nCt] ), 2 ) == "//" .OR.;
              LEFT( ALLTRIM( aImpRESSAO[nCt] ), 2 ) == "/*" .OR.;
              LEFT( ALLTRIM( aImpRESSAO[nCt] ), 1 ) == "*"
          nComando:= 2
       ELSEIF AT( "®", aImpRESSAO[nCT] ) > 0
          nComando:= 3
       ELSEIF LEFT( ALLTRIM( aImpRESSAO[nCt] ), 1 ) == ":"
          nComando:= 5
       ENDIF

       DO CASE
          CASE nComando == 1

               /* Transfere dados p/ variavel de trabalho */
               cIMPRESSAO:= ALLTRIM( aImpRESSAO[nCT] )

               /* Pega as posicoes */
               nPosIni:= AT( "$", cIMPRESSAO )
               nPosFim:= LEN( cIMPRESSAO )
               nQtd:= nPosFim - nPosIni
               Variavel:= SUBSTR( cIMPRESSAO, nPosIni + 1, nQtd )

               /* Pega o valor que contem a variavel */
               IF AT( "(", cIMPRESSAO ) > 0
                  Variavel:= EVAL( &("{|| "+Variavel+"}") )
               ENDIF

               /* Anula a String */
               aImp[nCt]:= "*_NULA_*"

               /* Transporta resultado p/ impressao formatada */
               aImpFormat[nCT]:= cIMPRESSAO

          CASE nComando == 2

               /* Anula a String */
               aImp[nCT]:= "*_NULA_*"

          CASE nComando == 3

               cIMPRESSAO:= aImpRESSAO[nCT]

               WHILE AT( "®", cIMPRESSAO ) > 0

                   /* Pega as posicoes */
                   nPosIni:= AT("®", cIMPRESSAO )
                   nPosFim:= AT("¯", cIMPRESSAO )
                   nQtd:= nPosFim - nPosIni

                   /* Pega a String que sera substituida */
                   cSTRING:= SUBSTR( cIMPRESSAO, nPosIni, nQtd + 1 )

                   //cString:= NToC( cString )

                   /* Pega tamanho da variavel */
                   nLocalTam:= LEN( cSTRING )

                   Variavel:= SUBSTR( cIMPRESSAO, nPosIni + 1, nQtd - 1 )
                   //Variavel:= NToC( Variavel )

                   /* Pega o valor que contem a variavel */
                   IF AT( "(", cSTRING ) > 0 .OR.;
                      AT( "->", cSTRING ) > 0
                      Variavel:= EVAL( &("{|| "+Variavel+"}") )
                   ELSEIF !EMPTY(Variavel)
                      Variavel:= EVAL( FIELDBLOCK( Variavel ) )
                   ENDIF

                   //nVarTam:= LEN( NToC( Variavel ) )
                   nVarTam:= LEN( Variavel )

                   IF nLocalTam > nVarTam
                      nQuantTirar:= nLocalTam
                      nDiferenca:= nLocalTam - nVarTam
                      Variavel:= Variavel+SPACE( nDiferenca )
                   ELSEIF nVarTam >= nLocalTam
                      nQuantTirar:= nVarTam
                   ENDIF

                   /* Substitui */
                   cIMPRESSAO:= STUFF( cIMPRESSAO, nPosIni, nQuantTirar, Variavel )

              ENDDO

              aImpFormat[nCT]:= cIMPRESSAO

         CASE nComando == 4

              VIf:={"","",""}

              cIMPRESSAO:= aImpRESSAO[nCT]

              cVariavel:= aImpRESSAO[nCT]

              FOR nCT2:= 1 TO 3

                  /* Pega as posicoes e tamanho */
                  IF nCt2 == 1
                     nPosIni:= AT( "(", cVariavel )
                  ELSEIF nCt2 >= 2
                     nPosIni:= 1
                  ENDIF

                  IF ( nPosFim:= AT( ",", cVariavel ) ) == 0
                      nPosFim:= AT( ")", cVariavel )
                  ENDIF

                  nQtd:= nPosFim - nPosIni

                  /* Pega o verificador nCT2 */
                  VIf[nCT2]:= SUBSTR( cVariavel, nPosIni + 1, nQtd -1 )

                  /* Altera o valor do nCT2 atual para null */
                  cVariavel:= SUBSTR( cVariavel, nPosFim + 1 )

                  IF nCt2==3 .AND. ALLTRIM( VIf[3] ) == ""
                     VIf[3]:="Nil"
                  ENDIF
              NEXT

              /* Verifica se o primeiro parametro nao ‚ um label */
              IF ( nCT2:= ASCAN( aImp, ALLTRIM( VIf[1] ) ) ) > 0
                 IF nCt2 > 1 .AND. nCt2 < LEN( aImpRESSAO )
                    nCt:= nCt2 - 1
                    lJump:= .T.
                 ELSE
                    SET(20,"SCREEN")
                    SCROLL(00,00,24,79)
                    @ 01,00 SAY "LABEL "+VIf[1]+" NAO ENCONTRADO...."
                    QUIT
                 ENDIF

              /* Testa a condicao, pois ‚ um jump (pulo) condicional */
              ELSE
                 /* Se for a primeira */
                 IF ( Verificador:= Eval( &("{|| "+VIf[1]+"}") ) )
                    nCT2:= ASCAN( aImp, ALLTRIM( VIf[2] ) )
                 ELSE /* Se for a segunda */
                    IF VIf[3]<>"Nil"
                       nCT2:= ASCAN( aImp, ALLTRIM( VIf[3] ) )
                    ELSE
                       nCT2:= nCT + 1
                    ENDIF
                 ENDIF

                 aImp[nCT]:="*_NULA_*"

                 IF UPPER( VIf[3] ) == "NIL" .AND. !Verificador
                    lJump:= .T.
                 ELSE
                    IF nCT2 > 0 .AND. nCT2 <= LEN( aImpRESSAO )
                       nCT:= nCT2 - 1
                       lJump:= .T.
                    ELSE
                       IF nCt + 1 < LEN( aImpRESSAO )
                          lJump:= .T.
                       ELSE
                          lJump:= .F.
                       ENDIF
                    ENDIF
                 ENDIF
              ENDIF

          CASE nComando == 5

               /* Criacao de Label */
               nPosIni:= AT( ":", aImpRESSAO[nCT] )
               nPosFim:= LEN( aImpRESSAO[nCT] )
               nQtd:= nPosFim - nPosIni

               aImp[nCT]:= ALLTRIM( SUBSTR( aImpRESSAO[nCT], nPosIni + 1, nPosFim - 1 ) )

          CASE nComando == 6

               /* Localizacao da largura do texto */
               nPosIni:= AT( "(", aImpRESSAO[nCT] )
               nPosFim:= AT( ")", aImpRESSAO[nCT] )
               nLargura:= VAL( SUBSTR( aImpRESSAO[nCT], nPosIni+1, nPosFim - nPosIni - 1 ) )

          CASE nComando == 7
               /* Localizacao da largura do texto */
               nPosIni:= AT( "(", aImpRESSAO[nCT] )
               nPosFim:= AT( ")", aImpRESSAO[nCT] )

               SaveStatus( aImpressao, aImp, aImpFormat, nCt )

               cArquivo:= ALLTRIM( SUBSTR( aImpRESSAO[nCT], nPosIni+1, nPosFim - nPosIni - 1 ) )
               nCt:=1
               aImp:={}
               aImpFormat:={}
               aImpRESSAO:={}
               lJump:= .T.
               EXIT

          CASE nComando == 8
               RestoreStatus( @aImpressao, @aImp, @aImpFormat, @nCt )
               lJump:= .T.
       ENDCASE

       IF EMPTY( aImp[nCT] ) .AND. !lJump
//        IF !lPulaLinha .AND. Alltrim( aImpFormat[ nCt ] ) == Chr( 13 ) + Chr( 10 )
          IF !lPulaLinha .AND. Len( Alltrim( aImpFormat[ nCt ] ) ) <= 2
             /* Quando estiver linhaOff() e nao conter nada na linha nao faz nada */
          ELSE
             // Substitui conforme tabela de SubChar
             IF ( aSubChar:= SubChar() ) <> Nil
                FOR iChar:= 1 TO Len( aSubChar )
                   IF aSubChar[iChar][1] <> Nil
                      aImpFormat[nCt]:= StrTran( aImpFormat[nCt], aSubChar[iChar][1], aSubChar[iChar][2] )
                   ENDIF
                NEXT
             ENDIF
             DEVPOS( IF( lPulaLinha, Linha( 1 ), Linha( NIL ) ), 00 )
             DEVOUT("")
             DEVOUT( RTRIM( aImpFormat[nCt] ) )
             IF lPassadaDupla
                DEVPOS( Linha( NIL ), 00 )
                DEVOUT("")
                DEVOUT( RTRIM( aImpFormat[nCt] ) )
             ENDIF
          ENDIF
       ENDIF
   NEXT

ENDDO
RETURN NIL

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ LimpaBuffer
³ Finalidade  ³ Limpa o buffer utilizado por impressao
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION LimpaBuffer()
SWSet( 10101010, "<AREA RESERVADA> - BUFFER DE FORMATACAO File.REP" )
SWSet( 20202020, "<AREA RESERVADA> - BUFFER DE FORMATACAO File.REP" )
SWSet( 30303030, "<AREA RESERVADA> - BUFFER DE FORMATACAO File.REP" )
Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ SetVariavel
³ Finalidade  ³ Set uma variavel de memoria
³ Parametros  ³ cNome / cExpressao / VarList
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION SetVariavel( cNome, cExpressao, aLista )
Public c___, a___
M->a___:= cExpressao
M->c___:= cNome
Public &c___ := &(a___)
Release M->c___, M->a___
IF PCOUNT() >= 3
   AADD( aLista, cNome )
ENDIF
Return NIL

FUNCTION ClearMemory( aLista )
LOCAL nCt:= 1
FOR nCt:= 1 TO LEN( aLista )
    ClearVariavel( aLista[nCt] )
NEXT
RETURN NIL

FUNCTION ClearVariavel( cNome )
Public c, a
M->c:= cNome
Public &c
Release &c

FUNCTION Linha( nLin )
IF nLin == NIL
   Return( IF( Set(20)=="PRINT", Prow(), Row() ) )
ELSE
   nLin+= IF( Set(20)=="PRINT", Prow(), Row() )
   @ nLin,00 SAY Space(0)
ENDIF
RETURN NIL

FUNCTION IndexFile( cArquivo, cCampo )
dbCreateIndex( cArquivo, cCampo, &("{||"+cCampo+"}"), if( .F., .T., NIL ) )
Return Nil

FUNCTION ReOrganiza( cArquivo )
if !.F.
   ordListClear()
end
ordListAdd( cArquivo )
RETURN Nil

FUNCTION Filtro( cCampo )
dbSetFilter( &("{||"+cCampo+"}"), cCampo )
RETURN Nil

FUNCTION Say( nLin, nCol, cString )
DevPos( IF( nLin<>Nil, nLin, Row() ), IF( nCol<>Nil, nCol, Col() ) )
DevOut( IF( cString<>NIL, cString, "") )
RETURN Nil

FUNCTION VPFGet( cVariavel, cPicture, bwhen, bvalid )
AAdd( M->GetList, _GET_( &cVariavel, cVariavel, cPicture , bwhen, bvalid ):display() )
RETURN Nil

FUNCTION ListGet( nLin, nCol, cString, cVariavel, cPicture, bWhen, bValid )
Say( nLin, nCol, cString )
AAdd( M->GetList, _GET_( &cVariavel, cVariavel, cPicture , bWhen, bValid ):display() )
RETURN Nil

FUNCTION SayGet( nLin, nCol, cString, cVariavel, cPicture, bWhen, bValid )
Say( nLin, nCol, cString )
AAdd( M->GetList, _GET_( &cVariavel, cVariavel, cPicture , bWhen, bValid ):display() )
RETURN Nil


FUNCTION VerPilha( aIncremento )
STATIC Pilha
Pilha:= IF( Pilha==NIL, {}, Pilha )
IF( aIncremento <> NIL, AADD( Pilha, aIncremento ), NIL )
RETURN Pilha

FUNCTION SaveStatus( aImpRESSAO, aImp, aImpFormat, nPosicao )
VerPilha( { aImpRESSAO, aImp, aImpFormat, nPOSICAO } )
RETURN NIL

FUNCTION RestoreStatus( aImpressao, aImp, aImpFormat, nPosicao, nCodigo )
LOCAL Pilha:= VerPilha()
Pilha:= IF( Pilha==NIL, {}, Pilha )
IF nCodigo == NIL
   nCodigo:= LEN( Pilha ) - 1
ENDIF
IF nCodigo<=0
   nCodigo:=1
ENDIF
aImpressao:= Pilha[nCodigo][1]
aImp:= Pilha[nCodigo][2]
aImpFormat:= Pilha[nCodigo][3]
nPosicao:= Pilha[nCodigo][4]
RETURN Nil

FUNCTION IOMenu( cVariavel, Valor )
LOCAL nOpcao:= 0
Priv bBlock:= "{|_1| if( PCount() == 0, "+cVariavel+", "+cVariavel+" := _1)}"
nOpcao := __MenuTo( &( bBlock ), cVariavel )
&cVariavel:= nOpcao
return nOpcao

FUNCTION SWMenu( cVariavel, Valor )
LOCAL nOpcao:= 0
Priv bBlock:= "{|_1| if( PCount() == 0, "+cVariavel+", "+cVariavel+" := _1)}"
nOpcao := __MenuTo( &( bBlock ), cVariavel )
&cVariavel:= nOpcao
return nOpcao


FUNCTION Variavel( Nada )
RETURN Nil

Function ImprimeFile( cArquivo )
  PRIVATE cArq:= cArquivo, cDevice:= Set( 24 )
  !TYPE &cArq >&cDevice
  /* Set Printer To ARQUIVO2.PRN
  Set Device To Printer
  cCampo:= MEMOREAD( cArquivo )
  aArquivo:= IOFillText( cCampo )
  FOR nCt:= 1 TO Len( aArquivo )
      @ nCt - 1, 0 Say aArquivo[ nCt ]
  NEXT
  Set Device To Screen */
Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ IMPRESSORA
³ Finalidade  ³ Desviar para a impressora conforme lista de impressoras
³ Parametros  ³ nCodigo
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Static Function Impressora( nCodSWSet )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
IF nCodSWSet == 410
ELSE
   Set( 24, SWSet( nCodSWSet ) )
ENDIF
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CONDENSADO/NEGRITO/ITALICO/DRAFT
³ Finalidade  ³ Retornam uma string de formatacao conforme o fonte, portanto
³             ³ usar num .REP da seguinte forma: Ex. ®Condensado(.T.)¯
³ Parametros  ³ lSim-Liga/Desliga Condensado/Negrito/Etc.
³ Retorno     ³ String
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Abril/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Condensado( lSim )
Variavel:= IF( lSim, ALLTRIM( CFGIMP->COMP2 ), ALLTRIM( CFGIMP->COMP0 ) )
Return EVAL( &( "{|| " + Variavel + "}" ) )

Function Micro( lSim )
Variavel:= IF( lSim, ALLTRIM( CFGIMP->COMP2 ), ALLTRIM( CFGIMP->COMP3 ) )
Return EVAL( &( "{|| " + Variavel + "}" ) )

Function Draft()
Return BuscaFonte( {|| A_NORM } )

Function Negrito( lSim )
Variavel:= IF( lSim, ALLTRIM( CFGIMP->NEG ), ALLTRIM( CFGIMP->NOR ) )
Return EVAL( &( "{|| " + Variavel + "}" ) )

Function Italico( lSim )
Return BuscaFonte( IF( lSim, {|| A_ITAL }, {|| D_ITAL } ) )

Function LPP6( lSim )
Variavel:= IF( lSim, ALLTRIM( CFGIMP->LPP6 ), ALLTRIM( CFGIMP->LPP6 ) )
Return EVAL( &( "{|| " + Variavel + "}" ) )

Function LPP8( lSim )
Variavel:= IF( lSim, ALLTRIM( CFGIMP->LPP8 ), ALLTRIM( CFGIMP->LPP6 ) )
Return EVAL( &( "{|| " + Variavel + "}" ) )


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ EXPANDIDO
³ Finalidade  ³ Habilita o expandido da impressora
³ Parametros  ³ lSim-Sim/Nao
³ Retorno     ³ String
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Expandido( lSim )
Variavel:= IF( lSim, ALLTRIM( CFGIMP->EXPL ), ALLTRIM( CFGIMP->EXPD ) )
Return EVAL( &( "{|| " + Variavel + "}" ) )

Function ImpLinhas()
Return 64

Function LandScape()

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ BUSCAFONTE
³ Finalidade  ³ Conforme o device, busca a impressora e o fonte cfe.
³             ³ o parametro campo para a mesma e retorna uma string
³             ³ com a configuracao para a impressora e determinado
³             ³ fonte cfe. as rotinas de chamada acima, Ngrito(),
³             ³ Condensado()
³ Parametros  ³ bCampo-Bloco com o nome do campo a retornar
³ Retorno     ³ cString-String de formatacao de impressora
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Abril/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function BuscaFonte( bCampo )
Local cCampo, cString:= ""
Local nArea:= Select(), nOrdem:= IndexOrd(), cDevice
DBSelectAr( 1 )
IF !Used()
   DBUseArea( .F.,, "IMPCFG00.SYS", "IMP", .T., .F. )
ENDIF
Index On PORTA_ to IMPCFG02.INT
Set Index To IMPCFG02.INT
IF AT( ".", Set( 24 ) ) > 0
   cDevice:= SubStr( Set( 24 ), 1, At( ".", Set( 24 ) ) - 1 )
ELSE
   cDevice:= Set( 24 )
ENDIF
DBSeek( cDevice, .T. )
IF Alltrim( PORTA_ ) == AllTrim( cDevice )
   cCampo:= Eval( bCampo )
   FOR nCt:= 1 TO Len( cCampo )
       cString:= cString + Chr( Val( SubStr( cCampo, 1, At( ",", cCampo ) - 1 ) ) )
       cCampo:= SubStr( cCampo, At( ",", cCampo ) + 1 )
   NEXT
   cString:= cString - Chr( Val( SubStr( cCampo, 1 ) ) )
ENDIF
DBSelectAr( nArea )
DBSetOrder( nOrdem )
Return cString


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ DISPSELECAO
³ Finalidade  ³ Apresentar menu de selecao para os relatorios
³ Parametros  ³ nLinIni, nColIni = Linha e coluna de apresentacao
³             ³ aListaOpcoes = Lista de Opcoes a serem apresentadas
³             ³ aOpcao = Lista de Opcoes
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 06/08/98
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DispSelecao( nLinIni, nColIni, aListaOpcoes, aOpcaoOld )
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, 79 )
  Local lOk:= .T.
  Local nLin, nCol, cString:= ""
  Private aOpcao:= aOpcaoOld

  Set Key K_RIGHT To MnuMoveRight()
  Set Key K_LEFT  To MnuMoveLeft()
  Set Key K_ALT_1 To TeclaFuncao()
  Set Key K_ALT_2 To TeclaFuncao()
  Set Key K_ALT_3 To TeclaFuncao()
  Set Key K_ALT_4 To TeclaFuncao()
  Set Key K_ALT_5 To TeclaFuncao()
  Set Key K_ALT_6 To TeclaFuncao()
  Set Key K_ALT_7 To TeclaFuncao()
  Set Key K_ALT_8 To TeclaFuncao()

  FOR nOpcao:= 1 TO Len( aListaOpcoes )
      nLin:= nLinIni - 2
      nLin:= nLin + ( nOpcao * 2 )
      nCol:= nColIni
      SetColor( _COR_GET_EDICAO )
      @ nLin, nCol + Len( aListaOpcoes[ nOpcao ][ 1 ] ) Say Space(1)
      FOR nCt:= 2 To Len( aListaOpcoes[ nOpcao ] )
         if nCt == aOpcao[ nOpcao ]
            cDestaque:= Repl( "º", Len( aListaOpcoes[ nOpcao ][ nCt ] ) )
            SetColor( _COR_ALERTA_LETRA )
         else
            cDestaque:= Repl( " ", Len( aListaOpcoes[ nOpcao ][ nCt ] ) )
            SetColor( _COR_GET_EDICAO )
         endif
         nCol:= Col()
         @ nLin+1, nCol +1 Say cDestaque Color _COR_GET_EDICAO
         @ nLin, nCol + 1 Say aListaOpcoes[ nOpcao ][ nCt ]
      NEXT
  NEXT
  nOpcao:= 1
  WHILE .T.
    nLin:= nLinIni
    nCol:= nColIni
    SetColor( _COR_GET_EDICAO )

    aOpcoesMenu:= {}
    FOR nOp:= 1 TO LEN( aListaOpcoes )
        cOpcao:= " "
        FOR nCt:= 1 TO Len( aListaOpcoes[ nOp ] )
            cOpcao:= cOpcao + aListaOpcoes[ nOp ][ nCt ] + " "
        NEXT
        AAdd( aOpcoesMenu, cOpcao )
    NEXT

    cCorRes:= SetColor()
    FOR nCt:= 1 TO Len( aOpcoesMenu )
        SetColor( "11/" + CorFundoAtual() )
        @ nLin,nCol Prompt aOpcoesMenu[ nCt ]  // ListaOpcoes
        nLin:= nLin + 2
    NEXT

    Menu To nOpcao
    SetColor( cCorRes )

    IF Lastkey() ==K_ESC
       lOk:= .F.
       Exit
    ENDIF
    IF nOpcao == 1
       lOk:= .T.
       Exit
    ENDIF
    IF nOpcao <> 0
       aOpcao[ nOpcao ]++
       IF aOpcao[ nOpcao ] > Len( aListaOpcoes[ nOpcao ] )
          aOpcao[ nOpcao ]:= 2
       ENDIF
    ENDIF
    nLin:= nLinIni - 2
    nLin:= nLin + ( nOpcao * 2 )
    @ nLin, nCol + Len( aListaOpcoes[ nOpcao ][ 1 ] ) Say Space(1)
    FOR nCt:= 2 To Len( aListaOpcoes[ nOpcao ] )
        if nCt == aOpcao[ nOpcao ]
           cDestaque:= Repl( "º", Len( aListaOpcoes[ nOpcao ][ nCt ] ) )
           SetColor( _COR_ALERTA_LETRA )
           cCorSelecao:= "15/04"
        else
           cDestaque:= Repl( " ", Len( aListaOpcoes[ nOpcao ][ nCt ] ) )
           SetColor( _COR_GET_EDICAO )
           cCorSelecao:= SetColor()
        endif
        nCol:= Col()
        @ nLin+1, nCol +1 Say cDestaque Color _COR_GET_EDICAO
        @ nLin, nCol + 1 Say aListaOpcoes[ nOpcao ][ nCt ] Color cCorSelecao
     NEXT
  ENDDO
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Set Key K_LEFT To
  Set Key K_RIGHT To
  Set Key K_ALT_1 To
  Set Key K_ALT_2 To
  Set Key K_ALT_3 To
  Set Key K_ALT_4 To
  Set Key K_ALT_5 To
  Set Key K_ALT_6 To
  Set Key K_ALT_7 To
  Set Key K_ALT_8 To
  Return lOk

  Stat Function MnuMoveRight()
  Keyboard Chr( K_ENTER )

  Stat Function TeclaFuncao()
  IF LastKey()==K_ALT_1
     aOpcao[ nOpcao ]:= 1
  ELSEIF LastKey()==K_ALT_2
     aOpcao[ nOpcao ]:= 2
  ELSEIF LastKey()==K_ALT_3
     aOpcao[ nOpcao ]:= 3
  ELSEIF LastKey()==K_ALT_4
     aOpcao[ nOpcao ]:= 4
  ELSEIF LastKey()==K_ALT_5
     aOpcao[ nOpcao ]:= 5
  ELSEIF LastKey()==K_ALT_6
     aOpcao[ nOpcao ]:= 6
  ELSEIF LastKey()==K_ALT_7
     aOpcao[ nOpcao ]:= 7
  ELSEIF LastKey()==K_ALT_8
     aOpcao[ nOpcao ]:= 8
  ENDIF
  IF nOpcao==2
     Keyboard Chr( K_RIGHT ) + Chr( K_LEFT ) + Chr( K_UP ) + Chr( K_UP ) + Chr( K_UP ) + Chr( K_UP )  + Chr( K_ENTER )
  ELSE
     Keyboard Chr( K_RIGHT ) + Chr( K_LEFT ) + "I"
  ENDIF
  Return Nil


  Stat Function MnuMoveLeft()
  Keyboard Chr( K_ENTER ) + Chr( 0 )
  IF aOpcao[ nOpcao ]-2 >= 1
     aOpcao[ nOpcao ]:= aOpcao[ nOpcao ] - 2
  ELSE
     aOpcao[ nOpcao ]:= 1
  ENDIF
  Return Nil



 /*****
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Funcao      ³ ArrayAtribui
 ³ Finalidade  ³ Atribuicao em array multi-direcional
 ³ Parametros  ³ aArray-Destino
 ³             ³ nPosicao-Posicao a Atribuir
 ³             ³ aConteudo-Array uni-dimensional a atribuir
 ³ Retorno     ³ Nil
 ³ Programador ³ Valmor Pereira Flores
 ³ Data        ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 */
 Function ArrayAtribui( aArray, nPosicao, aConteudo )
 aArray[ nPosicao ]:= aConteudo
 Return Nil

 /*****
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Funcao      ³ A2rrayAtribui ( o retorno )
 ³ Finalidade  ³ Atribuicao em array multi-direcional
 ³ Parametros  ³ aArray-Destino
 ³             ³ nPosicao-Posicao a Atribuir
 ³             ³ aConteudo-Array uni-dimensional a atribuir
 ³ Retorno     ³ Nil
 ³ Programador ³ Valmor Pereira Flores
 ³ Data        ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 */
 Function A2rrayAtribui( aArray, nPosicao, nPosCol, XConteudo )
 aArray[ nPosicao,nPosCol ]:= XConteudo
 Return Nil

 /*****
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Funcao      ³ SWDispStatus
 ³ Finalidade  ³ Apresentacao do Status - Sim/Nao
 ³ Parametros  ³ lStatus - Status de Apresentacao
 ³ Retorno     ³ lStatus
 ³ Programador ³ Valmor Pereira Flores
 ³ Data        ³ 07/08/1998
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 */
 Function SWDispStatus( lStatus )
 Static lDispStatus
 IF !lStatus == NIL
    lDispStatus:= lStatus
 ENDIF
 IF lDispStatus == Nil
    lDispStatus:= .T.
 ENDIF
 Return lDispStatus


 Function TiraLinhaBranco( cFile )
 Local nArea:= Select()
 Local aStr:= {{ "ORIGEM", "C", 400, 00 }}
 SWGravar( 8000 )
 dbSelectAR( 127 )
 DBCreate( "TMPTMP.TMP", aStr )
 Use TMPTMP.TMP Alias T__
 cArq:= cFile
 Append From &cArq SDF
 Set( 24, cFile )
 Set( 20, "PRINT" )
 dbGOtop()
 WHILE !EOF()
     IF !EMPTY( ORIGEM )
        @ PROW(),PCOL() Say AllTrim( ORIGEM ) + Chr( 13 ) + Chr( 10 )
     ENDIF
     DBSkip()
 ENDDO
 SWGravar( 5 )
 Set( 24, "LPT1" )
 Set( 20, "SCREEN" )
 DBCloseArea()
 IF nArea > 0
    DBSelectAr( nArea )
 ENDIF
 Return Nil

 Function FileLe( cFile )
 Local nArea:= Select()
 Local aStr:= {{"DESCRI", "C", 300, 00 }}
 Local cDiretorio

 /* Verifica a existencia de uma pasta temporaria C:\FORTUNA\TEMP */
 IF Diretorio( "C:TEMP" )
    cDiretorio:= "C:TEMP\"
 ELSE
    cDiretorio:= "C:"
 ENDIF

 cFileCriar:= cDiretorio - "REPORT.T00"
 FOR nCt:= 1 TO 50
    cFileX:=  cDiretorio - "REPORT.T" + StrZero( nCt, 2 )
    IF !File( cFileX )
       cFileCriar:= cFileX
    ENDIF
 NEXT
 dbSelectAr( 199 )
 DBCreate( cFileCriar, aStr )
 Use &cFileCriar
 cArq:= cFile
 IF File( cArq )
    Append From &cArq SDF
 ENDIF
 Release cArq
 dbCloseArea()
 IF nArea > 0
    dbSelectAr( nArea )
 ENDIF
 Return cFileCriar


//
// SUBCHAR
//
// Realiza uma substituicao de caracteres
// na impressao dos relatorios que possuirem
// as declaracoes desta funcao.
//
// Valmor
// Abril/2002
//
Function SubChar( cChr1, cChr2 )
Static aChar
If ValType( cChr1 )=="N"
   aChar:= Nil
   Return Nil
Endif
If cChr1==Nil
   Return aChar
endif
IF aChar==Nil
   aChar:= {}
endif
AAdd( aChar, { cChr1, cChr2 } )
Return Nil



 Function FileToArray( cFile )
 Local nArea:= Select()
 Local aArray:= {}
 cArq:= cFile
 DBSelectAr( 199 )
 Use &cArq
 WHILE !EOF()
    AAdd( aArray, RTRIM( DESCRI ) )
    DBSkip()
 ENDDO
 DBCloseArea()
 IF nArea > 0
    DBSelectAr( nArea )
 ENDIF
 Return aArray

 // Replace 
 Function FieldReplace( cCampo, cValor )
 FieldPut( FieldPos( cCampo ), cValor )
 Return Nil


Static Function AdicionarFuncoes
 DBRecall()
 Return Nil








