
Parameters cParametro

set cursor off

Set Epoch To 1980
Set Date British
Relatorio( "PDV.INI", "\" + CURDIR() )
/* Carregamento de Impressora - Autenticacao */
IF !( cParametro==Nil )
   bCmd:= ALLTRIM( cParametro )
   bCmd:= &( "{|| " + bCmd + "}" )
   EVAL( bCmd )
   Return Nil
ENDIF

Informacao()
Inkey(1)

DO CASE
   CASE Impressora=="URANO"
        IF ( Retorno:= InitComm() ) <> 0
           ? "Falha de comunicacao com a impressora urano"
           ? "Retorno " + Str( Retorno )
           ? ""
           Inkey(0)
//           Quit
        ENDIF
ENDCASE


BC_INIC( 257 )                        && inicializa contexto grafico da CLBC

BC_LIMPA(7)                           && Limpa o video com cor cinza

Bc_ArqVd( .0, .0, "INFOFN.PCX", 2 )
Bc_ArqVd( .480, .180, "INFO.PCX", 2 )
SetColor( "15/01" )
@ 00,00 SAY " PDV - Sistema de Suporte                                  Soft&Ware Informatica "

ncor = BC_CNCOR()                     && consulta numero de cores disponivel

if ncor = 2                           && video monocromatico

   img = BC_ARQME("..\DISQUETE.PCX")  && carrega na memoria imagem de 2 cores

   BC_DTEXTM(0 , "", "", "", "", 1)   && Texto preto com fundo branco

else

   BC_DTEXTM("", "", "", "", "", 7)   && Texto com fundo cinza nos outros casos

   if ncor = 16

      img = BC_ARQME("..\rocha16.pcx") && carrega imagem de 16 cores

   else

      img = BC_ARQME("..\pinh256.pcx") && carrega imagem de 256 cores

   endif

endif

SetBlink( .F. )
corbot  = 4     && inicializacao de parametros da funcao BC_DCORBOT
corcong = 3
cormold = 2
corsel  = 1

pos     = 1     && inicializacao de parametros da funcao BC_DBOT
subl    = 0
mx      = 0.007
my      = 0.007
relevo  = 1

&& cria botoes

bot_A        = BC_CRIABOT(0.01, 0.85, "", "", 2, asc("X"), ' Leitura "~X" (Inicio do dia)   ' )
bot_posicao  = BC_CRIABOT(0.01, 0.80, "", "", 2, asc("Z"), ' Reduá∆o "~Z" (Final do dia)    ' )
bot_subl     = BC_CRIABOT(0.01, 0.75, "", "", 2, asc("M"), " Leitura da ~Mem¢ria Fiscal     " )
bot_relevo   = BC_CRIABOT(0.01, 0.70, "", "", 2, asc("R"), " Leitura do ~Rel¢gio Interno    " )
bot_amx      = BC_CRIABOT(0.01, 0.65, "", "", 2, asc("A"), " Leitura dos tempos ~Ativ/Ligado" )
bot_dmx      = BC_CRIABOT(0.01, 0.60, "", "", 2, asc("C"), " Codigo do ~Cupom Atual         " )
bot_amy      = BC_CRIABOT(0.01, 0.55, "", "", 2, asc("S"), " Le ~Status da Impressora Fiscal" )
bot_DMY      = BC_CRIABOT(0.01, 0.50, "", "", 2, asc("L"), " ~Le Status dos Registradores   " )
bot_Fim      = BC_CRIABOT(0.01, 0.10, "", "", 2, asc("F"), " ~Finaliza Sistema              " )

tecla  = 0 && variaveis utilizadas pela BC_LEMOUSE
codigo = 0
bot_teste = 1

AbrePortaCom( 2 )
ImpPorta( 2 )
Status( "Porta Com2 Habilitada " )

do while tecla <> 27

   BC_DCORBOT(corbot, corcong, cormold, corsel)  && define cor do botao

   BC_DBOT(pos, subl, mx, my, relevo) && define caracteristicas do botao

   BC_LEMOUSE(@codigo, "", @tecla, "", "", "FUNC_USUARIO") && le opcao

   do case

      CASE Codigo = Bot_A
           Status( "Leitura X..." )
           if ( cRet:= impLeituraX() ) <> Nil
              cRet:= IF( VALTYPE( cRet )=="N", Str( cRet ), cRet )
              Status( "Retorno..." + cRet )
           endif

      CASE Codigo = Bot_Posicao
           lImpRed:= .T.
           IF VAL( LEFT( TIME(), 2 ) ) < 17
              Status( " Atencao! Esta opcao deve ser  ")
              Status( "executada ao final do dia, pois")
              Status( "fecha as atividades com o ECF. ")
              Status( "Pressione [ENTER] p/ Reducao Z" )
              lImpRed:= ( Inkey(0) == 13 )
           ENDIF
           IF lImpRed
              Status( "Reducao Z" )
              Status( impErro( impReducaoZ() ) )
           ELSE
              Status( "Nao realizada" )
           ENDIF

      case codigo = bot_subl     && habilita ou nao o sublinhamento
           Status( "Leitura da Memoria Fiscal..." )
           Status( impErro( impLeMemoria() ) )

      case codigo = bot_amx                    && aumenta a margem X

           mx = min(mx + 0.01, 0.1)

      case codigo = bot_dmx                    && diminui a margem X

           Status( impCupomAtual() )

      case codigo = bot_amy                    && aumenta a margem Y

           Status( "STATUS DA IMPRESSORA               " )
           Status( "-----------------------------------" )
           Status( "Abrindo o driver de impressao      " )
           DO CASE
              CASE Impressora=="SIGTRON"
                   Arq:= FOpen( "SIGFIS", 2 )
                   FWrite( arq, Chr(9)+Chr(5), 2 )
                   FClose( Arq )
                   Status( "Lendo informacoes...               " )
                   Arq:= Fopen( "SIGFIS", 2 )
                   RetStatus:= Space( 8 )
                   IF Fread( Arq, @RetStatus, 1 ) <> 1
                      Status( "Falha de comunicacao em SIGFIS." )
                      FClose( Arq )
                   ELSE
                      Status( "Redirecionando Status              " )
                      FClose( Arq )
                      ValStatus:= ASC( RetStatus )
                      cStatus:= NToSbit( ValStatus )
                      Status( "-----------------------------------" )
                      FOR nCt:= 1 TO Len( cStatus )
                          IF SubStr( cStatus, nCt, 1 ) == "1"
                             cSt:= " 0 "
                          ELSE
                             cSt:= "   "
                          ENDIF
                          DO CASE
                             CASE nCt == 8
                                  cSt:= cSt + " Proximidade do fim do papel"
                             CASE nCt == 7
                                  cSt:= cSt + " Reducao Z Pendente"
                             CASE nCt == 6
                                  cSt:= Space( 10 )
                             CASE nCt == 5
                                  cSt:= cSt + " Impressora OffLine"
                             CASE nCt == 4
                                  cSt:= cSt + " Fim da bobina de papel"
                             CASE nCt == 3
                                  cSt:= Space( 10 )
                             CASE nCt == 2
                                  cSt:= cSt + " Falha Geral"
                             CASE nCt == 1
                                  cSt:= cSt + " Gaveta Aberta"
                          ENDCASE
                          IF Left( cSt, 3 ) == " 0 "
                             Status( SubStr( cSt, 5 ) )
                          ENDIF
                      NEXT
                   ENDIF
              CASE Impressora=="URANO"
                   nStatus:= StatusPrinter()
                   IF nStatus > 0
                      Status( impErro( nStatus ) )
                   ENDIF
           ENDCASE
           Status( "-----------------------------------" )

      case codigo = bot_dmy                    && diminui a margem Y

           Status( "Lendo Registradores, aguarde..." )
           cStatus:= ImpLeStatus()
           IF Len( cStatus ) > 2
              Status( "-----------------------------------" )
              Status( "Total (GT):    " + Tran( SubStr( cStatus, 4,  18 ), "@R XXXXXXXXXXXXXXXX.XX" ) )
              Status( "Descontos Dia: " + "0000" + Tran( SubStr( cStatus, 22, 14 ), "@R XXXXXXXXXXXX.XX" ) )
              Status( "Cancelamentos: " + "0000" + Tran( SubStr( cStatus, 36, 14 ), "@R XXXXXXXXXXXX.XX" ) )
              Status( "-----------------------------------" )
           ELSE
              Status( "Falha na Recepcao das Informacoes..." )
           ENDIF
           my = max(my - 0.01, 0.007)

      case codigo = bot_relevo                 && altera o relevo do botao
           cHora:= ImpHora()
           IF LEN( Alltrim( cHora ) ) >= 6
              Status( cHora )
           ELSE
              Status( " ** Erro! Ocupada..." )
           ENDIF

      case codigo = bot_fim                    && finaliza

           exit

   endcase

enddo

BC_LIBMEM(img)             && libera imagem
BC_ELIMBOT()               && elimina todos os botoes
BC_FIM()                   && finaliza contexto grafico da CLBC
DO CASE
   CASE Impressora=="URANO"
        IF EndComm() <> 0
           ?? "Falha de Comunicacao com Impressora"
           Inkey(0)
           Quit
        ENDIF
ENDCASE


****************************************************************************
function FUNC_USUARIO
parameters modo, tecla, cod
****************************************************************************
* Funcao do usuario chamada pela BC_LEMOUSE
*

if modo = 0 .or. modo = 1    && se o botao for selecionado ou
                             && se o cursor entrar no botao
   do case

      case cod = bot_posicao

         BC_TEXTM(0.01, 0.01,"")

      case cod = bot_subl

         if subl = 0
            BC_TEXTM(0.01, 0.01,"")
         else
            BC_TEXTM(0.01, 0.01,"")
         endif

      case cod = bot_amx

         BC_TEXTM(0.01, 0.01,""+space(28))

      case cod = bot_dmx

         BC_TEXTM(0.01, 0.01,""+space(28))

      case cod = bot_amy

         BC_TEXTM(0.01, 0.01,""+space(28))

      case cod = bot_dmy

         BC_TEXTM(0.01, 0.01,""+space(28))

      case cod = bot_relevo

         BC_TEXTM(0.01, 0.01,""+space(23))

      case cod = bot_fim

         BC_TEXTM(0.01, 0.01,""+space(38))

   endcase

elseif modo = 2            && se o cursor do mouse sair do botao

   BC_TEXTM(0.01, 0.01,space(46))

endif

return(0)


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ Status
≥ Finalidade  ≥ Impressao em tela do status enviado
≥ Parametros  ≥ cdescricao
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ 23/07/98
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function Status( cDescricao )
Local cCor:= SetColor()
SetColor( "15/15" )
Scroll( 06, 40, 22, 73, 1 )
SetColor( "00/15" )
@ 22,40 Say PAD( cDescricao, 34 ) Color "07/01"
SetColor( cCor )
Return Nil



/*---------------------------------------------------------------------------
  By Valmor Pereira Flores
----------------------------------------------------------------------------*/

/*-------------------------------------------*/
#Include "COMMON.CH"
#Include "VPF.CH"

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ Relatorio
≥ Finalidade  ≥ Impressao de relatorio
≥ Parametros  ≥ cFile=>Nome do Aruivo
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Nil
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
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
SCROLL( 03, 17, 06, 64 )
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
              !AT( "Æ", aImpressao[ nCt ] ) > 0 .AND.;
              !Left( AllTrim( aImpressao[ nCt ] ), 1 ) == ":" .AND.;
              !AT( "/*", aImpressao[ nCt ] ) > 0
          aImpressao[ nCt ]:= "$" + AllTrim( aImpressao[ nCt ] )
       ENDIF
       nPosicao:= 0
   NEXT

   DispStatus( cArquivo, nCt, aImpFormat[1], .T., 1 )

   FOR nCT:=1 to Len( aImpRESSAO )

       DispStatus( cArquivo, nCt, aImpFormat[nCt], .F. )

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
       ELSEIF AT( "Æ", aImpRESSAO[nCT] ) > 0
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

               WHILE AT( "Æ", cIMPRESSAO ) > 0

                   /* Pega as posicoes */
                   nPosIni:= AT("Æ", cIMPRESSAO )
                   nPosFim:= AT("Ø", cIMPRESSAO )
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

              /* Verifica se o primeiro parametro nao Ç um label */
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

              /* Testa a condicao, pois Ç um jump (pulo) condicional */
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
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ SetVariavel
≥ Finalidade  ≥ Set uma variavel de memoria
≥ Parametros  ≥ cNome / cExpressao / VarList
≥ Retorno     ≥
≥ Programador ≥
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
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
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ CONDENSADO/NEGRITO/ITALICO/DRAFT
≥ Finalidade  ≥ Retornam uma string de formatacao conforme o fonte, portanto
≥             ≥ usar num .REP da seguinte forma: Ex. ÆCondensado(.T.)Ø
≥ Parametros  ≥ lSim-Liga/Desliga Condensado/Negrito/Etc.
≥ Retorno     ≥ String
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Abril/1998
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
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
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ BUSCAFONTE
≥ Finalidade  ≥ Conforme o device, busca a impressora e o fonte cfe.
≥             ≥ o parametro campo para a mesma e retorna uma string
≥             ≥ com a configuracao para a impressora e determinado
≥             ≥ fonte cfe. as rotinas de chamada acima, Ngrito(),
≥             ≥ Condensado()
≥ Parametros  ≥ bCampo-Bloco com o nome do campo a retornar
≥ Retorno     ≥ cString-String de formatacao de impressora
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Abril/1998
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
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
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ IOFillText()
≥ Finalidade  ≥ Preencher um array com informacoes de um arquivo texto
≥ Parametros  ≥ cCampo - Variavel c/ o campo: Ex. IOFilltext( MEMOREAD( "COPIA.REP" ) )
≥ Retorno     ≥ aArray
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
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


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ CalcVenc
≥ Finalidade  ≥ Ajustar a data de vencimento cfe. a quantidade de dias
≥ Parametros  ≥ dDataBase, nDias, dVencimento
≥ Retorno     ≥ .T.
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function CalcVenc( dDataBase, nDias, dDataVencimento )
dDataVencimento:= dDataBase + nDias
Return .T.


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ CalcParcela
≥ Finalidade  ≥ Calcula parcela
≥ Parametros  ≥ nValorPagar, nPercentual, nParcela
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function CalcParcela( nValorPagar, nPercentual, nParcela )
nParcela:= ( nValorPagar * nPercentual ) / 100
Return .T.


/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ FORMAPAGAMENTO
≥ Finalidade  ≥ Apresentacao das formas de pagamentos disponiveis
≥ Parametros  ≥ nLin1, nCol1, nLin2, nCol2, aParcelas
≥ Retorno     ≥ Nil
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥ Novembro/1998
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function FormaPagamento( nLin1, nCol1, nLin2, nCol2, aParcelas, nValorPagar, nVezes, nForma )
Local nArea:= Select()
Local oTb

   DBSelectAr( 22 )
   Use &DiretoriodeDados\CDDUPAUX.DBF Alias DPA Shared
   IF File( DiretoriodeDados + "\DPAIND05.NTX" )
      Set Index To &DiretoriodeDados\DPAIND01.NTX,;
                   &DiretoriodeDados\DPAIND02.NTX,;
                   &DiretoriodeDados\DPAIND03.NTX,;
                   &DiretoriodeDados\DPAIND04.NTX,;
                   &DiretoriodeDados\DPAIND05.NTX
   ELSE
      Set Index To &DiretoriodeDados\DPAIND01.NTX,;
                   &DiretoriodeDados\DPAIND02.NTX,;
                   &DiretoriodeDados\DPAIND03.NTX,;
                   &DiretoriodeDados\DPAIND04.NTX
   ENDIF
   DBSetOrder( 2 )
   DBGotop()
   DBSelectAr( 11 )
   Use &DiretoriodeDados\CONDICAO.DBF Alias CND Shared
   Set Index To &DiretoriodeDados\CNDIND01.NTX,;
                &DiretoriodeDados\CNDIND02.NTX
   DBSetOrder( 1 )
   IF !DBSeek( nForma )
      DBGoTop()
   ENDIF
   DBSetOrder( 2 )
   cCorPadrao:="07/" + StrZero( nCorSegFundo, 2, 0 ) + ",15/04,,,15/00"
   SetColor( cCorPadrao )
   oTB:=TBrowseDB( nLin1, nCol1, nLin2, nCol2 )
   oTB:AddColumn( TBColumnNew(, {|| Left( CND->DESCRI, 45 ) + Space( 20 ) } ) )
   oTB:AUTOLITE:=.f.
   oTB:DehiLite()
   /* Refaz o display */
   oTb:RefreshAll()
   WHILE !oTB:Stabilize()
   ENDDO
   /* Loop do Browse */
   WHILE .T.
       oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
       WHILE !oTb:Stabilize()
       ENDDO
       nTecla:=inkey(0)
       If nTecla=K_ESC
          lFim:= .T.
          exit
       EndIf
       do case
          CASE nTecla==K_UP         ;oTB:up()
          CASE nTecla==K_LEFT       ;oTB:up()
          CASE nTecla==K_RIGHT      ;oTB:down()
          CASE nTecla==K_DOWN       ;oTB:down()
          CASE nTecla==K_PGUP       ;oTB:pageup()
          CASE nTecla==K_PGDN       ;oTB:pagedown()
          CASE nTecla==K_CTRL_PGUP  ;oTB:gotop()
          CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom()
          CASE nTecla==K_ENTER
               nVezes:= 0
               AAdd( aParcelas, { 100, PARCA_, nValorPagar, DATE() + PARCA_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
               ++nVezes
               IF !PARCB_ == 0
                  AAdd( aParcelas, { 100, PARCB_, nValorPagar, DATE() + PARCB_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                  ++nVezes
                  IF !PARCC_ == 0
                     AAdd( aParcelas, { 100, PARCC_, nValorPagar, DATE() + PARCC_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                     ++nVezes
                     IF !PARCD_ == 0
                        AAdd( aParcelas, { 100, PARCD_, nValorPagar, DATE() + PARCD_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                        ++nVezes
                        IF !PARCE_ == 0
                           AAdd( aParcelas, { 100, PARCE_, nValorPagar, DATE() + PARCE_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                           ++nVezes
                           IF !PARCF_ == 0
                              AAdd( aParcelas, { 100, PARCF_, nValorPagar, DATE() + PARCF_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                              ++nVezes
                              IF !PARCG_ == 0
                                 AAdd( aParcelas, { 100, PARCG_, nValorPagar, DATE() + PARCG_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                 ++nVezes
                                 IF !PARCH_ == 0
                                    AAdd( aParcelas, { 100, PARCH_, nValorPagar, DATE() + PARCH_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                    ++nVezes
                                    IF !PARCI_ == 0
                                       AAdd( aParcelas, { 100, PARCI_, nValorPagar, DATE() + PARCI_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                       ++nVezes
                                       IF !PARCJ_ == 0
                                          AAdd( aParcelas, { 100, PARCJ_, nValorPagar, DATE() + PARCJ_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                          ++nVezes
                                          IF !PARCK_ == 0
                                             AAdd( aParcelas, { 100, PARCK_, nValorPagar, DATE() + PARCK_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                             ++nVezes
                                             IF !PARCL_ == 0
                                                AAdd( aParcelas, { 100, PARCL_, nValorPagar, DATE() + PARCL_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                                ++nVezes
                                                IF !PARCM_ == 0
                                                   AAdd( aParcelas, { 100, PARCM_, nValorPagar, DATE() + PARCM_, CTOD( "  /  /  " ), 0, Space( 15 ), 0 } )
                                                   ++nVezes
                                                ENDIF
                                             ENDIF
                                          ENDIF
                                       ENDIF
                                    ENDIF
                                 ENDIF
                              ENDIF
                           ENDIF
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF

               /* Percentual */
               nPercentual:= ( 100 - PERCA_ ) / ( nVezes - 1 )
               aParcelas[ 1 ][ 1 ]:= PERCA_
               aParcelas[ 1 ][ 3 ]:= ( nValorPagar * PERCA_ ) / 100

               /* Retira lancamentos caso haja sobra */
               FOR nCt:= 2 TO Len( aParcelas )
                   IF LEN( aParcelas ) > nVezes
                      ADEL( aParcelas, nVezes + 1 )
                      ASIZE( aParcelas, Len( aParcelas ) - 1 )
                   ELSE
                      aParcelas[ nCt ][ 1 ]:= nPercentual
                      aParcelas[ nCt ][ 3 ]:= ( nValorPagar * nPercentual ) / 100
                   ENDIF
               NEXT

               SetCursor( 0 )
               oTb:RefreshAll()
               WHILE !oTB:stabilize()
               ENDDO
               lDisplay:= .F.
               SetCursor( 0 )
               nForma:= CODIGO
               Exit

          OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      oTB:refreshcurrent()
      oTB:stabilize()
   ENDDO
   DBSelectAr( 11 )
   DBCloseArea()
   DBSelectAr( 22 )
   DBCloseArea()
   DBSelectAr( nArea )
   Return .T.

/*****
⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒø
≥ Funcao      ≥ INFORMACAO
≥ Finalidade  ≥ Retornar o Status da Impressora Fiscal
≥ Parametros  ≥ Nil
≥ Retorno     ≥
≥ Programador ≥ Valmor Pereira Flores
≥ Data        ≥
¿ƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
*/
Function Informacao
nRetorno:= -1
DO CASE
   CASE Impressora=="SIGTRON"
        ? "Aguarde, iniciando comunicacao..."
        RetStatus:= Space( 8 )
        arqST = fopen("SIGFIS",2)
        Fwrite(arqST,CHR(29)+CHR(5),2)
        fclose(arqST)
        arqST = fopen("SIGFIS",2)
        IF FREAD(arqST,@RetStatus,1) <> 1
           ? "Erro de leitura !"
           fclose(arqST)
           Return 0
        ELSE
           arqRES:=fopen("RETORNO.TXT",2)
           Fwrite(arqRES,NtoSBit(ASC(RetStatus))+chr(13),70)
           fclose(arqRES)
           fclose(arqST)
           VALST:=ASC(RetStatus)    /* Pega o valor ASCII de retStatus */
           VST:= NtoSBit(VALST)     /* Retorna o valor em bits         */
           nRetorno:= Tabela( VST )
        ENDIF
   CASE Impressora=="BEMATECH"

   CASE Impressora=="URANO"
        SetColor( "14/00" )
        ? "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"
        ? "€€≤≤€€€€≤€≤≤≤≤≤≤≤€€€≤≤≤≤≤€€≤≤≤€€€€≤€≤≤≤≤≤≤≤€€"
        ? "€€≤≤€€€€≤€≤≤€€€€≤≤€≤≤€€€≤≤€≤≤≤≤€€≤≤€≤≤€€€€≤€€"
        ? "€€≤≤€€€€≤€≤≤≤≤≤≤€€€≤≤≤≤≤≤≤€≤≤€≤≤€≤≤€≤≤€€€€≤€€"
        ? "€€≤≤€€€€≤€≤≤€€€≤≤€€≤≤€€€≤≤€≤≤€€≤≤≤≤€≤≤€€€€≤€€"
        ? "€€≤≤≤≤≤≤≤€≤≤€€€€≤≤€≤€€€€€≤€≤€€€€≤≤≤€≤≤≤≤≤≤≤€€"
        ? "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€"
        IF ReadSensor( "1" ) <> 0
        ENDIF

ENDCASE
Return nRetorno


Function Tabela( VST )

   WHILE Len(VST)<8
       VST:="0"+VST
   ENDDO

   aBit:=  { 1, 2, 3, 4, 5, 6, 7, 8 }
   aSema:= { 1, 2, 3, 4, 5, 6, 7, 8 }

   /* Resposta SIGFIS em bits */
   FOR nCt:= 1 TO Len( VST )
       IF nCt <= 8
          aBit[ nCt ]:= SubStr( VST, nCt, 1 )
       ENDIF
   NEXT

   FOR nCt:= 1 TO Len( abit )
       aSema[ nCt ]:= IF( aBit[ nCt ] == "1", " ", "  " )
   NEXT

   SetColor( "15/01" )
   Cls
   @ 00,01 Say ""
   @ Row()+1,00 Say " ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ "
   @ Row()+1,00 Say " Status da Impressora FS-300                           "
   @ Row()+1,00 Say " ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ "
   @ Row()+1,00 Say "   Gaveta Aberta                                 Bit8  "
   @ Row()+1,00 Say "   Falha Geral                                   Bit7  "
   @ Row()+1,00 Say "   <RESERVADO>                                   Bit6  "
   @ Row()+1,00 Say "   Fim da bobina de papel                        Bit5  "
   @ Row()+1,00 Say "   Impressora Off-Line                           Bit4  "
   @ Row()+1,00 Say "   <RESERVADO>                                   Bit3  "
   @ Row()+1,00 Say "   Reducao Z Pendente                            Bit2  "
   @ Row()+1,00 Say "   Proximidade do Fim do papel                   Bit1  "
   @ Row()+1,00 Say " ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ "
   @ Row()+1,00 Say ""
   @ Row()+1,00 Say ""
   nLin:= ROW()
   /* Verificacao p retorno */
   nRetorno:= -1
   FOR nCt:= 1 TO Len( aSema )
      IF ! ( nCt==3 .OR. nCt==6 )
         @ nLin-11+nCt,01 Say aSema[ nCt ]
      ENDIF
      IF !aSema[ nCt ]=="  "
         DO CASE
            CASE nCt == 1 .OR. nCt == 2 .OR. nCt == 3
                 nRetorno:= IF( nRetorno < 0, 0, nRetorno )
            CASE nCt == 4
                 nRetorno:= 1
            OTHERWISE
         ENDCASE
      ENDIF
   NEXT
   Inkey(0)
   ? " "
   RETURN nRetorno



