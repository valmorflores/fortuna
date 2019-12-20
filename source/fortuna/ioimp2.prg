// ## CL2HB.EXE - Converted
#include "vpf.ch"
#INCLUDE "Common.Ch" 

#ifdef HARBOUR
function ioimp2
#endif


LOCAL cArquivo:= SPACE(12) 
LOCAL GetList:={} 
PRIVATE COR:={"W+/B","W+/B","W+/B","W+/B","W+/B","W+/B","W+/B",; 
              "W+/G","W+/G","W+/B","W+/B","W+/B","W+/B","W+/B",; 
              "W+/R","W+/R","W+/B","W+/B","W+/B","W+/B","W+/B",; 
              "W+/N","W+/N","W+/B","W+/B"} 
 
priv XCONFIG:=.T. 
priv WPESQSN:=WSIMNAO:="", GDIR:="\"+curdir(), _VP2:=.t., WHELP:=.f. 
priv COR:={}, _EMP, _END, _END1, _END2, _CD, _COMSENHA, _COMDATA, _COMSOM, _MARGEM 
priv _COMSOMBRA, _COMZOOM, nMAXLIN:=24, nMAXCOL:=79 
priv _VIDEO_LIN:=25, _VIDEO_COL:=80 
priv cPODER, nGCODUSER, WUSUARIO 
SetConfig() 
 
ModoVga(.F.) 
SCROLL( 00, 00, 24, 79 ) 
DISPBOX( 01, 01, 03, 55 ) 
@ 02,03 SAY "Nome do arquivo:" GET cArquivo 
READ 
IF FILE( ALLTRIM( cArquivo ) ) 
   Relatorio( ALLTRIM( cArquivo ) ) 
ELSE 
   @ 02,03 SAY "Arquivo nao encontrado neste diret�rio..." 
   INKEY(0) 
ENDIF 
SCROLL( 00, 00, 24, 79) 
 
 
STATIC FUNC Relatorio( cFile ) 
LOCAL cTela:= SAVESCREEN(00,00,24,79) 
IF FILE( ALLTRIM( cFile ) ) 
   Impressao( ALLTRIM( cFile ) ) 
ELSE 
   DEVPOS( 24/2, 00 ) 
   DEVOUT( "Arquivo nao encontrado neste diret�rio..." ) 
   INKEY(0) 
ENDIF 
RESTSCREEN( 00, 00, 24, 79, cTela ) 
RETURN NIL 
 
 
STAT FUNCTION DispStatus( cArquivo, nLinha, cProcesso, lFlag, nControl ) 
/* 
LOCA cCor:= SETCOLOR(), cDevice 
IF SET( 20 )=="PRINT" .OR. nControl<>Nil 
   cDevice:= SET( 20, "SCREEN" ) 
ELSE 
   RETURN Nil 
ENDIF 
IF lFlag 
   VPBOX( 01, 01, 07, 65, "Monitor de Relatorio", "15/04" , .T., .T. ) 
ENDIF 
SCROLL( 02, 02, 06, 64 ) 
DEVPOS( 02, 02 ); DEVOUT("Sistema Gerador de Relatorios (REP)          ") 
DEVPOS( 03, 02 ); DEVOUT("Hora.........: " + TIME() ) 
DEVPOS( 04, 02 ); DEVOUT("Arquivo......: " + cArquivo ) 
DEVPOS( 05, 02 ); DEVOUT("Linha........: " + LTRIM( STR( nLinha ) ) ) 
DEVPOS( 06, 02 ); DEVOUT("Processo.....: " + LEFT( cProcesso, 45 ) ) 
SET( 20, cDevice ) 
*/ 
RETURN NIL 
 
 
STATIC FUNC IMPRESSAO( cARQUIVO ) 
LOCAL aIMP:={}, aIMPFORMAT:={}, aIMPRESSAO:={},; 
      cCAMPO, lPulaLinha:= .F.,; 
      nLargura:=80, nCt, nCt2, nPosIni, nPosFim, cString, cImpressao,; 
      variavel, VIf, cVariavel, nComando, nQtd, nLocalTam, nVarTam,; 
      nDiferenca, nQuantTirar, Verificador, lJump:=.F., aDefinicoes:={} 
 
SET PRINTER TO LPT1 
WHILE .T. 
 
   cCAMPO:=MEMOREAD( cARQUIVO ) 
 
   /* Cria matriz com os dados de impressao */ 
   aIMPRESSAO:=IOFillText( cCAMPO ) 
 
   /* Cria duas replicas de aIMPRESSAO */ 
   FOR nCT:=1 TO LEN( aIMPRESSAO ) 
       AADD( aIMP, IF( LEFT( ALLTRIM( aIMPRESSAO[nCT] ), 1 )==":",; 
            ALLTRIM( SUBSTR( ALLTRIM( aIMPRESSAO[nCT] ), 2 ) ), "" ) ) 
       AADD( aIMPFORMAT, aIMPRESSAO[nCT] ) 
   NEXT 
 
   FOR nCt:=1 TO Len( aImpressao ) 
       /* Comando INCLUDE para Chamar um arquivo externo de definicoes */ 
       IF LEFT( UPPER( LTRIM( aImpressao[nCt] ) ), 8 ) == "$INCLUDE" 
          cDefines:= MEMOREAD( ALLTRIM( SUBSTR( aImpressao[nCt], 9 ) ) ) 
          aDefines:= IOFillText( cDefines ) 
          FOR nCt2:= 1 TO LEN( aDefines ) 
              AADD( aDefinicoes, SUBSTR( aDefines[nCt2], 9 ) ) 
          NEXT 
       ENDIF 
   NEXT 
 
   /* Pesquisa as definicoes de #_DEFINE */ 
   FOR nCt:=1 TO LEN( aIMPRESSAO ) 
       IF LEFT( UPPER( LTRIM( aIMPRESSAO[nCt] ) ), 7 ) == "$DEFINE" 
          AADD( aDefinicoes, SUBSTR( ALLTRIM( aImpressao[nCt] ), 9 ) ) 
          aIMP[nCt]:="$_DEFINICAO_$" 
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
 
          IF AT( cString, aImpressao[nCt2] ) >0 .AND. aIMP[nCt2]<>"$_DEFINICAO_$" 
 
             /* Pega a que ira substituir a anterior */ 
             cVariavel:= ALLTRIM( SUBSTR( aDefinicoes[nCt], nPosIni + 1 ) ) 
 
             /* Faz a substituicao de strings */ 
             aImpFormat[nCt2]:= STRTRAN( aImpressao[nCt2], cString, cVariavel ) 
             aImpressao[nCt2]:= STRTRAN( aImpressao[nCt2], cString, cVariavel ) 
 
          ENDIF 
       NEXT 
   NEXT 
 
   DispStatus( cArquivo, nCt, aImpFormat[1], .T., 1 ) 
 
   FOR nCT:=1 to Len( aIMPRESSAO ) 
 
       DispStatus( cArquivo, nCt, aImpFormat[nCt], .F. ) 
 
       IF INKEY()==27 .OR. NEXTKEY()==27 .OR. LASTKEY()==27 
          SET( 20, "SCREEN" ) 
          RETURN Nil 
       ENDIF 
 
       nCOMANDO:=0 
       lJump:= .F. 
 
       IF UPPER( LEFT( ALLTRIM( aIMPRESSAO[nCt] ), 8 ) )=="$VAIPARA" 
          nCOMANDO:= 4 
       ELSEIF AT( "$LINHAON",  UPPER( aIMPRESSAO[nCT] ) ) >0 
          lPulaLinha:= .T. 
          aIMP[nCT]:= "*_NULA_*" 
       ELSEIF AT( "$LINHAOFF", UPPER( aIMPRESSAO[nCT] ) ) >0 
          lPulaLinha:= .F. 
          aIMP[nCT]:= "*_NULA_*" 
       ELSEIF AT( "$LARGURA",  UPPER( aIMPRESSAO[nCT] ) ) >0 
          nCOMANDO:=6 
       ELSEIF AT( "$CALL",     UPPER( aIMPRESSAO[nCT] ) ) >0 
          nCOMANDO:=7 
       ELSEIF AT( "$RETORNA",  UPPER( aImpressao[nCt] ) ) >0 
          nComando:=8 
       ELSEIF AT( "$DEFINE",   UPPER( aImpressao[nCt] ) ) >0 
          nComando:=9 
       ELSEIF AT( "$FIM",      UPPER( aImpressao[nCt] ) ) >0 
          RETURN Nil 
       ELSEIF LEFT( ALLTRIM( aIMPRESSAO[nCt] ), 1 ) == "$" 
          nCOMANDO:= 1 
       ELSEIF LEFT( ALLTRIM( aIMPRESSAO[nCt] ), 2 ) == "//" .OR.; 
              LEFT( ALLTRIM( aIMPRESSAO[nCt] ), 2 ) == "/*" .OR.; 
              LEFT( ALLTRIM( aIMPRESSAO[nCt] ), 1 ) == "*" 
          nCOMANDO:= 2 
       ELSEIF AT( "�", aIMPRESSAO[nCT] ) > 0 
          nCOMANDO:= 3 
       ELSEIF LEFT( ALLTRIM( aIMPRESSAO[nCt] ), 1 ) == ":" 
          nCOMANDO:= 5 
       ENDIF 
 
       DO CASE 
          CASE nCOMANDO == 1 
 
               /* Transfere dados p/ variavel de trabalho */ 
               cIMPRESSAO:= ALLTRIM( aIMPRESSAO[nCT] ) 
 
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
               aIMP[nCt]:= "*_NULA_*" 
 
               /* Transporta resultado p/ impressao formatada */ 
               aIMPFORMAT[nCT]:= cIMPRESSAO 
 
          CASE nCOMANDO == 2 
 
               /* Anula a String */ 
               aIMP[nCT]:= "*_NULA_*" 
 
          CASE nCOMANDO == 3 
 
               cIMPRESSAO:= aIMPRESSAO[nCT] 
 
               WHILE AT( "�", cIMPRESSAO ) > 0 
 
                   /* Pega as posicoes */ 
                   nPosIni:= AT("�", cIMPRESSAO ) 
                   nPosFim:= AT("�", cIMPRESSAO ) 
                   nQtd:= nPosFim - nPosIni 
 
                   /* Pega a String que sera substituida */ 
                   cSTRING:= SUBSTR( cIMPRESSAO, nPosIni, nQtd + 1 ) 
 
                   cString:= NToC( cString ) 
 
                   /* Pega tamanho da variavel */ 
                   nLocalTam:= LEN( cSTRING ) 
 
                   Variavel:= SUBSTR( cIMPRESSAO, nPosIni + 1, nQtd - 1 ) 
                   Variavel:= NToC( Variavel ) 
 
                   /* Pega o valor que contem a variavel */ 
                   IF AT( "(", cSTRING ) > 0 .OR.; 
                      AT( "->", cSTRING ) > 0 
                      Variavel:= EVAL( &("{|| "+Variavel+"}") ) 
                   ELSEIF !EMPTY(Variavel) 
                      Variavel:= EVAL( FIELDBLOCK( Variavel ) ) 
                   ENDIF 
 
                   nVarTam:= LEN( NToC( Variavel ) ) 
 
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
 
              aIMPFORMAT[nCT]:= cIMPRESSAO 
 
         CASE nCOMANDO == 4 
 
              VIf:={"","",""} 
 
              cIMPRESSAO:= aIMPRESSAO[nCT] 
 
              cVariavel:= aIMPRESSAO[nCT] 
 
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
 
              /* Verifica se o primeiro parametro nao � um label */ 
              IF ( nCT2:= ASCAN( aIMP, ALLTRIM( VIf[1] ) ) ) > 0 
                 IF nCt2 > 1 .AND. nCt2 < LEN( aIMPRESSAO ) 
                    nCt:= nCt2 - 1 
                    lJump:= .T. 
                 ELSE 
                    SET(20,"SCREEN") 
                    SCROLL(00,00,24,79) 
                    @ 01,00 SAY "LABEL "+VIf[1]+" NAO ENCONTRADO...." 
                    QUIT 
                 ENDIF 
 
              /* Testa a condicao, pois � um jump (pulo) condicional */ 
              ELSE 
                 /* Se for a primeira */ 
                 IF ( Verificador:= Eval( &("{|| "+VIf[1]+"}") ) ) 
                    nCT2:= ASCAN( aIMP, ALLTRIM( VIf[2] ) ) 
                 ELSE /* Se for a segunda */ 
                    IF VIf[3]<>"Nil" 
                       nCT2:= ASCAN( aIMP, ALLTRIM( VIf[3] ) ) 
                    ELSE 
                       nCT2:= nCT + 1 
                    ENDIF 
                 ENDIF 
 
                 aIMP[nCT]:="*_NULA_*" 
 
                 IF UPPER( VIf[3] ) == "NIL" .AND. !Verificador 
                    lJump:= .T. 
                 ELSE 
                    IF nCT2 > 0 .AND. nCT2 <= LEN( aIMPRESSAO ) 
                       nCT:= nCT2 - 1 
                       lJump:= .T. 
                    ELSE 
                       IF nCt + 1 < LEN( aIMPRESSAO ) 
                          lJump:= .T. 
                       ELSE 
                          lJump:= .F. 
                       ENDIF 
                    ENDIF 
                 ENDIF 
              ENDIF 
 
          CASE nCOMANDO == 5 
 
               /* Criacao de Label */ 
               nPosIni:= AT( ":", aIMPRESSAO[nCT] ) 
               nPosFim:= LEN( aIMPRESSAO[nCT] ) 
               nQtd:= nPosFim - nPosIni 
 
               aIMP[nCT]:= ALLTRIM( SUBSTR( aIMPRESSAO[nCT], nPosIni + 1, nPosFim - 1 ) ) 
 
          CASE nCOMANDO == 6 
 
               /* Localizacao da largura do texto */ 
               nPosIni:= AT( "(", aIMPRESSAO[nCT] ) 
               nPosFim:= AT( ")", aIMPRESSAO[nCT] ) 
               nLargura:= VAL( SUBSTR( aIMPRESSAO[nCT], nPosIni+1, nPosFim - nPosIni - 1 ) ) 
 
          CASE nCOMANDO == 7 
               /* Localizacao da largura do texto */ 
               nPosIni:= AT( "(", aIMPRESSAO[nCT] ) 
               nPosFim:= AT( ")", aIMPRESSAO[nCT] ) 
 
               SaveStatus( aImpressao, aImp, aImpFormat, nCt ) 
 
               cArquivo:= ALLTRIM( SUBSTR( aIMPRESSAO[nCT], nPosIni+1, nPosFim - nPosIni - 1 ) ) 
               nCt:=1 
               aIMP:={} 
               aIMPFORMAT:={} 
               aIMPRESSAO:={} 
               lJump:= .T. 
               EXIT 
 
          CASE nComando == 8 
               RestoreStatus( @aImpressao, @aImp, @aImpFormat, @nCt ) 
               lJump:= .T. 
       ENDCASE 
 
//       @ 10,00 SAY nCt 
//       @ 11,00 SAY LEN( aIMP ) 
 
       IF EMPTY( aIMP[nCT] ) .AND. !lJump 
          DEVPOS( IF( lPulaLinha, Linha( 1 ), Linha( NIL ) ), 00 ) 
          DEVOUT("") 
          DEVOUT( RTRIM( aIMPFORMAT[nCt] ) ) 
       ENDIF 
   NEXT 
ENDDO 
RETURN NIL 
 
/****************************** 
* Function Name: IOFillText 
* Purpose: Preenche um vetor com um texto memo 
* Parameters: cCAMPO, aTEXTO 
* Programador:Luciano Rosa 
* Data: 
**********/ 
FUNCTION IOFillText( cCAMPO ) 
** 
LOCAL Flag := .t., cTEXTO, aTEXTO := {}, FinalLinha 
#define CRLF   CHR(13)+CHR(10) 
cTEXTO := cCAMPO 
While Flag 
    FinalLinha := AT( CRLF, cTEXTO ) 
    AADD( aTEXTO,  SUBSTR( cTEXTO, 1 , FinalLinha-1 ) ) 
    cTEXTO     := SUBSTR( cTEXTO, FinalLinha+2 ) 
    IF EMPTY ( cTEXTO ) 
       Flag := .f. 
    ENDIF 
end 
RETURN( aTEXTO ) 
 
/**/ 
FUNCTION SetVariavel( cNome, cExpressao, aLista ) 
Public c, a 
M->a:= cExpressao 
M->c:= cNome 
Public &c := &(a) 
Release M->c, M->a 
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
 
FUNCTION IOOrganiza( cArquivo, cCampo ) 
dbCreateIndex( cArquivo, cCampo, &("{||"+cCampo+"}"), if( .F., .T., NIL ) ) 
RETURN Nil 
 
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
 
FUNCTION VerPilha( aIncremento ) 
STATIC Pilha 
Pilha:= IF( Pilha==NIL, {}, Pilha ) 
IF( aIncremento <> NIL, AADD( Pilha, aIncremento ), NIL ) 
RETURN Pilha 
 
FUNCTION SaveStatus( aIMPRESSAO, aIMP, aIMPFORMAT, nPosicao ) 
VerPilha( { aIMPRESSAO, aIMP, aIMPFORMAT, nPOSICAO } ) 
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
 
STATIC FUNCTION Ativa 
LOCAL ATIVA 
DBUSEAREA(.T.,,"ATIVA") 
DBSELECTAR("ATIVA") 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
INDEX ON ATIVA TO ATIVA 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
SET INDEX TO ATIVA 
SETCOLOR("ATIVA") 
SETCURSOR("ATIVA") 
DBSKIP() 
DBSEEK(0) 
DBGOTOP() 
INKEY("ATIVA") 
SET("ATIVA",1) 
ATIVA:=IF("ATIVA"="0",1,2) 
SCROLL(00,00,00,00,"ATIVA") 
DISPBOX(00,00,00,00,"ATIVA") 
NEXTKEY() 
INKEY(0) 
STRZERO(0,4,0) 
STR(0) 
SETPRC(00,00) 
RECNO() 
@ 00,00 PROMPT "1A" 
menu to ATIVA 
__EJECT() 
__QUIT() 
RETURN NIL 
