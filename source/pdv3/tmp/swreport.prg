/*---------------------------------------------------------------------------
  By Valmor Pereira Flores
----------------------------------------------------------------------------*/

/*-------------------------------------------*/
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
FUNCTION Relatorio( cFile, cDiretorio )
LOCAL cTela:= SAVESCREEN(00,00,24,79)
IF cDiretorio == Nil
   cDiretorio:= "\" + CURDIR()
ENDIF
IF FILE( ALLTRIM( cDiretorio - "\" - cFile ) )
   Impressao( ALLTRIM( cDiretorio - "\" - cFile ) )
ELSE
   Aviso( "Arquivo " + cDiretorio - "\" - cFile +" nao encontrado neste diret¢rio...", 12 )
   Pausa()
ENDIF
RESTSCREEN( 00, 00, 24, 79, cTela )
RETURN NIL

STATIC FUNCTION DispStatus( cArquivo, nLinha, cProcesso, lFlag, nControl )
LOCA cCor:= SETCOLOR(), cDevice
IF SET( 20 )=="PRINT" .OR. nControl<>Nil
   cDevice:= SET( 20, "SCREEN" )
ELSE
   RETURN Nil
ENDIF
IF lFlag
   VPBOX(01,01,07,65,"Monitor de Relatorio","12/04",.T.,.T.,"14/12")
   SetColor( "15/04" )
   DEVPOS( 02, 02 ); DEVOUT("Sistema Gerador de Relatorios (REP)          ")
   DEVPOS( 03, 02 ); DEVOUT("Hora.........: " + TIME() )
   DEVPOS( 04, 02 ); DEVOUT("Arquivo......: " + cArquivo )
   DEVPOS( 05, 02 ); DEVOUT("Linha........: " + LTRIM( STR( nLinha ) ) )
   DEVPOS( 06, 02 ); DEVOUT("Processo.....: " + LEFT( cProcesso, 45 ) )
   VPBOX( 08, 01, 21, 65, ,"15/01" )
ENDIF
SETCOLOR( "15/04" )
Scroll( 03, 17, 06, 64 )
DEVPOS( 03, 17 ); DEVOUT( TIME() )
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

STATIC FUNC IMPRESSAO( cARQUIVO )
Local GetList:= {}, MenuList:= {}
LOCAL aImp:={}, aImpFORMAT:={}, aImpRESSAO:={},;
      cCAMPO, lPulaLinha:= .F.,;
      nLargura:=80, nCt, nCt2, nPosIni, nPosFim, cString, cImpressao,;
      variavel, VIf, cVariavel, nComando, nQtd, nLocalTam, nVarTam,;
      nDiferenca, nQuantTirar, Verificador, lJump:=.F., aDefinicoes:={},;
      lPassadaDupla:= .F.

WHILE .T.

   cCAMPO:=MEMOREAD( cARQUIVO )

   /* Cria matriz com os dados de impressao */
   aImpRESSAO:=IOFillText( cCAMPO )

   /* Cria duas replicas de aImpRESSAO */
   FOR nCT:=1 TO LEN( aImpRESSAO )
       AADD( aImp, IF( LEFT( ALLTRIM( aImpRESSAO[nCT] ), 1 )==":",;
            ALLTRIM( SUBSTR( ALLTRIM( aImpRESSAO[nCT] ), 2 ) ), "" ) )
       AADD( aImpFormat, aImpRESSAO[nCT] )
   NEXT

   FOR nCt:=1 TO Len( aImpressao )
       /* Comando INCLUDE para Chamar um arquivo externo de definicoes */
       IF LEFT( UPPER( LTRIM( aImpressao[nCt] ) ), 8 ) == "$INCLUDE"
          IF !File( ALLTRIM( "\" + CURDIR() - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) )
             Aviso( "Arquivo " + ALLTRIM( "\" + CURDIR() - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) + " nao foi localizado. ", 12 )
             Pausa()
          ENDIF

          cDefines:= MEMOREAD( ALLTRIM( "\" + CURDIR() - "\" - ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) )
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
       ELSEIF  AT( "(", aImpressao[ nCt ] ) > 0 .AND.;
              !AT( "$", aImpressao[ nCt ] ) > 0 .AND.;
              !AT( "®", aImpressao[ nCt ] ) > 0 .AND.;
              !Left( AllTrim( aImpressao[ nCt ] ), 1 ) == ":" .AND.;
              !AT( "/*", aImpressao[ nCt ] ) > 0
          aImpressao[ nCt ]:= "$" + AllTrim( aImpressao[ nCt ] )
       ENDIF
       nPosicao:= 0
   NEXT

   FOR nCT:=1 to Len( aImpRESSAO )

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
          DEVPOS( IF( lPulaLinha, Linha( 1 ), Linha( NIL ) ), 00 )
          DEVOUT("")
          DEVOUT( RTRIM( aImpFormat[nCt] ) )
          IF lPassadaDupla
             DEVPOS( Linha( NIL ), 00 )
             DEVOUT("")
             DEVOUT( RTRIM( aImpFormat[nCt] ) )
          ENDIF

       ENDIF
   NEXT
ENDDO
RETURN NIL


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

FUNCTION Variavel( Nada )
RETURN Nil

Function ImprimeFile( cArquivo )
  PRIVATE cArq:= cArquivo
  Set Printer To ARQUIVO2.PRN
  Set Device To Printer
  cCampo:= MEMOREAD( cArquivo )
  aArquivo:= IOFillText( cCampo )
  FOR nCt:= 1 TO Len( aArquivo )
      @ nCt - 1, 0 Say aArquivo[ nCt ]
  NEXT
  Set Device To Screen
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
Return BuscaFonte( IF( lSim, {|| A_COND }, {|| A_NORM } ) )

Function Draft()
Return BuscaFonte( {|| A_NORM } )

Function Negrito( lSim )
Return BuscaFonte( IF( lSim, {|| A_NEGR }, {|| D_NEGR } ) )

Function Italico( lSim )
Return BuscaFonte( IF( lSim, {|| A_ITAL }, {|| D_ITAL } ) )

Function Expandido( lSim )
Return BuscaFonte( IF( lSim, {|| A_EXPA }, {|| D_EXPA } ) )

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
³ Funcao      ³ IOFillText()
³ Finalidade  ³ Preencher um array com informacoes de um arquivo texto
³ Parametros  ³ cCampo - Variavel c/ o campo: Ex. IOFilltext( MEMOREAD( "COPIA.REP" ) )
³ Retorno     ³ aArray
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function IOFillText( cCampoMemo )
LOCAL aTexto:= {}, nFinalLinha
WHILE .T.
    nFinalLinha:= AT( CHR( 13 ) + CHR( 10 ), cCampoMemo )
    AADD( aTexto,  SubStr( cCampoMemo, 1 , nFinalLinha - 1 ) )
    cCampoMemo:= SubStr( cCampoMemo, nFinalLinha + 2 )
    IF Empty( cCampoMemo )
       Exit
    ENDIF
ENDDO
RETURN aTexto


Function VPBox( nLin1, nCol1, nLin2, nCol2 )
@ nLin1, nCol1 To nLin2, nCol2
Return Nil

Function Pausa()
Inkey(0)

Function Aviso( cAviso )
Local cCor:= SetColor()
SetColor( "15/04" )
@ 24,00 Say cAviso
SetColor( cCor )
Return Nil

/*
* Modulo      - SCREENSAVE
* Finalidade  - Gravar parte da tela e suas coordenadas na variavel caracter.
* Parametros  - LIN1,COL1,LIN2,COL2=>Coordenadas.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screensave(LIN1,COL1,LIN2,COL2)
Local cTela
cTela:=chr(LIN1)+CHR(COL1)+CHR(LIN2)+CHR(COL2)+savescreen(LIN1,COL1,LIN2,COL2)
return(cTela)

/*
* Modulo      - SCREENREST
* Finalidade  - Carregar a tela a partir da variavel criada por SCREENSAVE()
*               Recupera as coordenadas originais da tela
* Parametros  - TELA=>Variavel que contem a tela.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screenrest(TELA)
restscreen(asc(substr(TELA,1,1)),asc(substr(TELA,2,1)),;
           asc(substr(TELA,3,1)),asc(substr(TELA,4,1)),substr(TELA,5))
return nil

