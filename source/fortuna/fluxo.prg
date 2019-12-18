// ## CL2HB.EXE - Converted
#include "Inkey.ch" 
#include "VPF.ch" 
 
#Define _MAX_HORIZONTAL   160 
#Define _MAX_VERTICAL     200 
#Define _ANO_INICIAL      ( year( Date() )-4 ) 
 
/* 
  FLUXO FINANCEIRO BASEADO EM CONTAS A PAGAR 
  ------------------------------------------ 
 
*/ 

#ifdef HARBOUR
function fluxo
#endif


Loca cCor:= SetColor(), ctela:= ScreenSave( 0, 0, 24, 79 )
Local cMascara:= "@EZ 999,999.99" 
Local aFluxo[ _MAX_VERTICAL ][ _MAX_HORIZONTAL ] 
 
  // Definicoes 
  SET DELETED ON 
  SET DATE BRITISH 
  SET EPOCH TO 1980 
  SET EXCLUSIVE OFF 
  SetCursor( 0 ) 
 
  nOpcao:= 1 
  CLS 
 
 
 
  VPBox( 0, 0, 24, 79, "FLUXO", _COR_BROW_BOX ) 
  SetColor( _COR_BROWSE ) 
 
  @ 02,02 SAY    "Menu de Opcoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 03,02 PROMPT "1-> CONTAS A PAGAR                        " 
  @ 04,02 PROMPT "2-> CONTAS A RECEBER                      " 
  Menu to nPagarReceber 
 
  Scroll( 1, 1, 10, 78 ) 
 
//  @ 00,00 SAY PAD( _VER + " - PROGRAMA DE FLUXO DE CONTAS A PAGAR ", 80 ) COLOR "15/02" 
  @ 02,02 SAY    "Menu de Opcoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
  @ 03,02 PROMPT "1-> Contas quitadas por data de quitacao  " 
  @ 04,02 PROMPT "2-> Contas pendentes por vencimento       " 
  @ 05,02 PROMPT "3-> Geral por data de emissao             " 
  @ 06,02 PROMPT "4-> Geral por data de vencimento          " 
  MENU TO nOpcao 
 
 
  DO CASE 
     CASE nPagarReceber == 1 
 
          /// Opcoes de Conta 
          DBSelectar( "OPE" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON DESCRI TO INDD02 
 
          OPE->( DBGOTop() ) 
          aOperacoes:= {  {"999", PAD( "TODAS", LEN( OPE->DESCRI ) ) } } 
          WHILE !OPE->( EOF() ) 
              IF OPE->ENTSAI=="E" 
                 AAdd( aOperacoes, { STRZERO( OPE->CODIGO, 3, 0 ), OPE->DESCRI } ) 
              ENDIF 
              OPE->( DBSkip() ) 
          ENDDO 
          @ 02,02 Say   "Operacao ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
          Scroll( 03, 01, 12, 78 ) 
          FOR i:= 1 TO Len( aOperacoes ) 
              @ ROW()+1,02 PROMPT aOperacoes[ i ][ 1 ] + " - " + aOperacoes[ i ][ 2 ] 
          NEXT 
          Menu to nOperacao 
          IF Lastkey() == K_ESC 
             nOperacao:= 1 
          ENDIF 
          nOperacao:= VAL( aOperacoes[ nOperacao ][ 1 ] ) 
 
          DBCreate( "FLUXO", { { "MESANO", "C", 06, 00 },; 
                               { "CONTA_", "N", 08, 00 },; 
                               { "VALOR_", "N", 16, 02 } } ) 
 
 
          //SELE C 
          //USE DADOS\CADFORN_.DBF ALIAS DES 
          //INDEX ON CODIGO TO IND002 
 
          //SELE B 
          //USE DADOS\CTAPAGAR.DBF ALIAS PAG 
          //INDEX ON CODFOR TO INDPAG 
 
          DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          USE FLUXO ALIAS res 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON STRZERO( CONTA_, 6, 0 ) + MESANO TO INDICE01 
 
          // 
          // Filtro das informacoes conforme selecao 
          // 
          PAG->( DBGoTop() ) 
 
          WHILE !PAG->( EOF() ) 
               DO CASE 
                  CASE nOpcao==1   /// POR QUITACAO, COM DATA DE QUITACAO PREENCHIDA 
                      @ 07,01 SAY PAG->( DATAPG ) 
                      IF PAG->DATAPG <> CTOD( "" ) .AND.; 
                          ( nOperacao==999 .OR. PAG->TABOPE == nOperacao ) 
                         cMes:=   STRZERO( MONTH( PAG->DATAPG ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( PAG->DATAPG ), 04, 00 ) 
                         nValor:= PAG->VALOR_ 
                         IF !res->( DBSeek( STRZERO( PAG->CODFOR, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With PAG->CODFOR,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
                  CASE nOpcao==2   /// POR VENCIMENTO, QUE ESTAO EM ABERTO 
                      @ 07,01 SAY PAG->( VENCIM ) 
                      IF PAG->VENCIM <> CTOD( "" ) .AND. PAG->DATAPG == CTOD( "" ) .AND.; 
                          ( nOperacao==999 .OR. PAG->TABOPE == nOperacao ) 
                         cMes:=   STRZERO( MONTH( PAG->VENCIM ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( PAG->VENCIM ), 04, 00 ) 
                         nValor:= PAG->VALOR_ 
                         IF !res->( DBSeek( STRZERO( PAG->CODFOR, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With PAG->CODFOR,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
                  CASE nOpcao==3   /// POR EMISSAO, INDEPENDENTE DE QUITA€ÇO 
                      @ 07,01 SAY PAG->( EMISS_ ) 
                      IF PAG->EMISS_ <> CTOD( "" ) .AND.; 
                          ( nOperacao==999 .OR. PAG->TABOPE == nOperacao ) 
 
                         cMes:=   STRZERO( MONTH( PAG->EMISS_ ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( PAG->EMISS_ ), 04, 00 ) 
                         nValor:= PAG->VALOR_ 
                         IF !res->( DBSeek( STRZERO( PAG->CODFOR, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With PAG->CODFOR,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
                  CASE nOpcao==4   /// POR VENCIMENTO, INDEPENDENTE DE QUITA€ÇO 
                      @ 07,01 SAY PAG->( VENCIM ) 
                      IF PAG->VENCIM <> CTOD( "" ) .AND.; 
                          ( nOperacao==999 .OR. PAG->TABOPE == nOperacao ) 
 
                         cMes:=   STRZERO( MONTH( PAG->VENCIM ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( PAG->VENCIM ), 04, 00 ) 
                         nValor:= PAG->VALOR_ 
                         IF !res->( DBSeek( STRZERO( PAG->CODFOR, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With PAG->CODFOR,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
 
               ENDCASE 
               PAG->( DBSkip() ) 
          ENDDO 
 
     CASE nPagarReceber == 2 
 
          DBCreate( "FLUXO", { { "MESANO", "C", 06, 00 },; 
                               { "CONTA_", "N", 08, 00 },; 
                               { "VALOR_", "N", 16, 02 } } ) 
          //SELE C 
          //USE DADOS\CLIENTES.DBF ALIAS CLI 
          //INDEX ON CODIGO TO IND002 
 
          //SELE B 
          DBSelectAr( "DPA" ) 
          DBSetOrder( 3 ) 
 
          DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          USE FLUXO ALIAS RES 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON STRZERO( CONTA_, 6, 0 ) + MESANO TO INDICE01 
          // 
          // Filtro das informacoes conforme selecao 
          // 
          DPA->( DBGoTop() ) 
 
          WHILE !DPA->( EOF() ) 
               DO CASE 
                  CASE nOpcao==1   /// POR QUITACAO, COM DATA DE QUITACAO PREENCHIDA 
                      @ 07,01 SAY DPA->( DTQT__ ) 
                      IF DPA->DTQT__ <> CTOD( "" ) .AND. DPA->NFNULA==" " 
                         cMes:=   STRZERO( MONTH( DPA->DTQT__ ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( DPA->DTQT__ ), 04, 00 ) 
                         nValor:= DPA->VLR___ 
                         IF !res->( DBSeek( STRZERO( DPA->CLIENT, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With DPA->CLIENT,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
                  CASE nOpcao==2   /// POR VENCIMENTO, QUE ESTAO EM ABERTO 
                      @ 07,01 SAY DPA->( VENC__ ) 
                      IF DPA->VENC__ <> CTOD( "" ) .AND. DPA->DTQT__ == CTOD( "" )  .AND. DPA->NFNULA==" " 
                         cMes:=   STRZERO( MONTH( DPA->VENC__ ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( DPA->VENC__ ), 04, 00 ) 
                         nValor:= DPA->VLR___ 
                         IF !res->( DBSeek( STRZERO( DPA->CLIENT, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With DPA->CLIENT,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
                  CASE nOpcao==3   /// POR EMISSAO, INDEPENDENTE DE QUITA€ÇO 
                      @ 07,01 SAY DPA->( DATAEM ) 
                      IF DPA->DATAEM <> CTOD( "" ) .AND. DPA->NFNULA==" " 
 
                         cMes:=   STRZERO( MONTH( DPA->DATAEM ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( DPA->DATAEM ), 04, 00 ) 
                         nValor:= DPA->VLR___ 
                         IF !res->( DBSeek( STRZERO( DPA->CLIENT, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With DPA->CLIENT,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
                  CASE nOpcao==4   /// POR VENCIMENTO, INDEPENDENTE DE QUITACAO 
                      @ 07,01 SAY DPA->( VENC__ ) 
                      IF DPA->VENC__ <> CTOD( "" )  .AND. DPA->NFNULA==" " 
                         cMes:=   STRZERO( MONTH( DPA->VENC__ ), 02, 00 ) 
                         cAno:=   STRZERO(  YEAR( DPA->VENC__ ), 04, 00 ) 
                         nValor:= DPA->VLR___ 
                         IF !res->( DBSeek( STRZERO( DPA->CLIENT, 6, 0  ) + cAno + cMes ) ) 
                            DBAppend() 
                         ENDIF 
                         Rlock() 
                         Replace MESANO With cAno + cMes,; 
                                 CONTA_ With DPA->CLIENT,; 
                                 VALOR_ With VALOR_ + nValor 
                      ENDIF 
 
               ENDCASE 
               DPA->( DBSkip() ) 
          ENDDO 
 
  ENDCASE 
 
 
  // aTitulo 
  aTitulo:= {} 
  FOR i:= 1 TO _MAX_HORIZONTAL 
      AAdd( aTitulo, Space( 10 ) ) 
  NEXT 
 
 
  // Zeramento de Informacoes em aFluxo 
  FOR x:= 1 TO LEN( aFluxo ) 
      FOR y:= 1 TO Len( aFluxo[ x ] ) 
          aFluxo[ x ][ y ]:= 0 
      NEXT 
  NEXT 
  FOR x:= 1 TO Len( aFluxo ) 
      aFluxo[ x ][ 2 ]:= SPACE( 30 ) 
  NEXT 
 
 
  // Inicio 
  nMeses:= 12 
  nVertical:= 1 
  nConta:= CONTA_ 
  IF nPagarReceber == 1 
     IF DES->( DBSeek( nConta ) ) 
        aFluxo[ nVertical ][ 2 ]:= DES->DESCRI 
     ENDIF 
  ELSE 
     IF CLI->( DBSeek( nConta ) ) 
        aFluxo[ nVertical ][ 2 ]:= CLI->DESCRI 
     ENDIF 
  ENDIF 
 
  res->( DBGoTop() ) 
  WHILE !res->( EOF() ) 
 
        // Informacoes 
        nMes:= VAL( SUBSTR( res->MESANO, 5, 2 ) ) 
        nHorizontal:= ( ( VAL( Left( res->MESANO, 4 ) ) - _ANO_INICIAL ) * nMeses ) + nMes 
 
        // Define uma posicao para nVertical, 
        // correspondente a conta 
        nVertical:= PosicaoConta( aFluxo, res->CONTA_ ) 
 
        IF nVertical >= Len( aFluxo ) .OR. nVertical <= 0 
           nVertical:=   _MAX_VERTICAL  - 1 
        ENDIF 
        IF nHorizontal >= Len( aFluxo[ nVertical ] ) .OR. nHorizontal <= 0 
           nHorizontal:= _MAX_HORIZONTAL -1 
        ENDIF 
 
        IF nHorizontal > 2 
           IF UPPER( VALTYPE( aFluxo[ nVertical ][ nHorizontal ] ) ) == "N" 
              aFluxo[ nVertical ][ nHorizontal ]:= aFluxo[ nVertical ][ nHorizontal ] + res->VALOR_ 
           ELSE 
              aFluxo[ nVertical ][ nHorizontal ]:= res->VALOR_ 
           ENDIF 
        ENDIF 
 
        aTitulo[ nHorizontal ]:= PADL( Mes( VAL( SUBSTR( res->MESANO, 5, 2 ) ) ) + "/" + SubStr( res->MESANO, 1, 4 ), LEN( Tran( 0, cMascara ) ) ) 
 
        // Proximo 
        res->( DBSkip() ) 
        IF res->( EOF() ) 
           EXIT 
        ELSEIF nConta <> res->( CONTA_ ) 
           nConta:=  res->( CONTA_ ) 
           nVertical:= PosicaoConta( aFluxo, nConta ) 
           IF nPagarReceber == 1 
              IF DES->( DBSeek( nConta ) ) 
                 aFluxo[ nVertical ][ 1 ]:= nConta 
                 aFluxo[ nVertical ][ 2 ]:= DES->DESCRI 
              ENDIF 
           ELSE 
              IF CLI->( DBSeek( nConta ) ) 
                 aFluxo[ nVertical ][ 1 ]:= nConta 
                 aFluxo[ nVertical ][ 2 ]:= CLI->DESCRI 
              ENDIF 
           ENDIF 
 
        ENDIF 
  ENDDO 
 
  DisplayFluxo( aFluxo ) 
  Screenrest( cTela ) 
  SetColor( cCor ) 
  DBSelectAr( 123 ) 
  DBCloseArea() 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
Function DisplayFluxo( aFluxo ) 
Local nRow:= 1, nTecla 
Local cMascara:= "@EZ 999,999.99" 
lOCAL nMes:= 1 
 
 
nAno:= _ANO_INICIAL 
nMes:= 1 
 
// Complementa demais meses 
// aTitulo:= { "", "", ... _MAX_HORIZONTAL } 
 
FOR x:= 1 TO LEN( aTitulo ) 
 
    @ 07,01 SAY "POSICAO X " + STR( x ) 
    @ 08,01 SAY "TAMANHO DO ARRAY: " + StR( Len( aTitulo ) ) 
    @ 09,01 say "CONTEUDO DO ELEMENTO NA POSICAO X:" + IF( VALTYPE( aTitulo[ x ] )=="C", aTitulo[ x ], "NAOVALIDO" ) 
 
    IF ALLTRIM( aTitulo[ x ] )=="" 
       cMes:= "___" 
       IF nMes >= 1 .AND. nMes <= 12 
          cMes:= Mes( nMes ) 
       ENDIF 
       aTitulo[ x ]:= cMes + "/" + StrZero( nAno, 4, 0 ) 
    ENDIF 
    nMes:= nMes + 1 
    IF nMes > 12 
       nMes:= 1 
       nAno:= nAno + 1 
    ENDIF 
NEXT 
aTitulo[ 1 ]:= "Conta" 
aTitulo[ 2 ]:= "Descricao da Conta" 
 
// Totalizadores 
nVertical:= PosicaoConta( aFluxo, 999999 ) 
aFluxo[ nVertical ][ 2 ]:= PAD( "T O T A L", 30 ) 
FOR x:= 1 TO LEN( aFluxo ) 
    FOR y:= 2 TO LEN( aFluxo[ x ] ) - 1 
        // Totalizador Vertical 
        IF x < nVertical 
           aFluxo[ nVertical ][ y ]:= aFluxo[ nVertical ][ y ] + aFluxo[ x ][ y ] 
        ENDIF 
 
        // Totalizador Horizontal 
        IF VALTYPE( aFluxo[ x ][ y ] ) == "N" 
           IF !( VALTYPE( aFluxo[ x ][ Len( aFluxo[ x ] ) ] ) == "N" ) 
              aFluxo[ x ][ Len( aFluxo[ x ] ) ]:= 0 
              aFluxo[ x ][ Len( aFluxo[ x ] ) ]:= aFluxo[ x ][ Len( aFluxo[ x ] ) ] + aFluxo[ x ][ y ] 
           ELSE 
              aFluxo[ x ][ Len( aFluxo[ x ] ) ]:= aFluxo[ x ][ Len( aFluxo[ x ] ) ] + aFluxo[ x ][ y ] 
           ENDIF 
        ENDIF 
    NEXT 
NEXT 
 
// Verificacao de integridade nos nomes das contas 
FOR i:= 1 TO Len( aFluxo ) 
   IF !( VALTYPE( aFluxo[ i ][ 2 ] ) == "C" ) 
      aFluxo[ i ][ 2 ]:= "<Conta_Indefinida>" 
   ELSEIF ALLTRIM( aFluxo[ i ][ 2 ] ) == "" .AND. aFluxo[ i ][ 1 ] <> 0 
      aFluxo[ i ][ 2 ]:= "" 
   ENDIF 
NEXT 
 
// ANO 
nAno:= _ANO_INICIAL 
cKey:= "" 
FOR i:= 1 TO ( ( YEAR( DATE() ) - _ANO_INICIAL ) * 12 ) + MONTH( DATE() ) 
   cKey:= cKey + Chr( K_RIGHT ) 
NEXT 
Keyboard cKey 
 
// SetColor( "07/01,15/00,01,,14/01" ) 
SetColor( SUBSTR( _COR_BROWSE, 1, 16 ) ) 
oTb:= TBrowseDb( 01, 01, 21, 78 ) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 001 ], {|| StrZero( aFluxo[ nRow ][ 1 ], 6, 0 ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 002 ], {|| LEFT( aFluxo[ nRow ][ 2 ],  38 ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 003 ], {|| Tran( aFluxo[ nRow ][ 3 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 004 ], {|| Tran( aFluxo[ nRow ][ 4 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 005 ], {|| Tran( aFluxo[ nRow ][ 5 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 006 ], {|| Tran( aFluxo[ nRow ][ 6 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 007 ], {|| Tran( aFluxo[ nRow ][ 7 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 008 ], {|| Tran( aFluxo[ nRow ][ 8 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 009 ], {|| Tran( aFluxo[ nRow ][ 9 ],  cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 010 ], {|| Tran( aFluxo[ nRow ][ 10 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 011 ], {|| Tran( aFluxo[ nRow ][ 11 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 012 ], {|| Tran( aFluxo[ nRow ][ 12 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 013 ], {|| Tran( aFluxo[ nRow ][ 13 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 014 ], {|| Tran( aFluxo[ nRow ][ 14 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 015 ], {|| Tran( aFluxo[ nRow ][ 15 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 016 ], {|| Tran( aFluxo[ nRow ][ 16 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 017 ], {|| Tran( aFluxo[ nRow ][ 17 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 018 ], {|| Tran( aFluxo[ nRow ][ 18 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 019 ], {|| Tran( aFluxo[ nRow ][ 19 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 020 ], {|| Tran( aFluxo[ nRow ][ 20 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 021 ], {|| Tran( aFluxo[ nRow ][ 21 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 022 ], {|| Tran( aFluxo[ nRow ][ 22 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 023 ], {|| Tran( aFluxo[ nRow ][ 23 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 024 ], {|| Tran( aFluxo[ nRow ][ 24 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 025 ], {|| Tran( aFluxo[ nRow ][ 25 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 026 ], {|| Tran( aFluxo[ nRow ][ 26 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 027 ], {|| Tran( aFluxo[ nRow ][ 27 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 028 ], {|| Tran( aFluxo[ nRow ][ 28 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 029 ], {|| Tran( aFluxo[ nRow ][ 29 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 030 ], {|| Tran( aFluxo[ nRow ][ 30 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 031 ], {|| Tran( aFluxo[ nRow ][ 31 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 032 ], {|| Tran( aFluxo[ nRow ][ 32 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 033 ], {|| Tran( aFluxo[ nRow ][ 33 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 034 ], {|| Tran( aFluxo[ nRow ][ 34 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 035 ], {|| Tran( aFluxo[ nRow ][ 35 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 036 ], {|| Tran( aFluxo[ nRow ][ 36 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 037 ], {|| Tran( aFluxo[ nRow ][ 37 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 038 ], {|| Tran( aFluxo[ nRow ][ 38 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 039 ], {|| Tran( aFluxo[ nRow ][ 39 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 040 ], {|| Tran( aFluxo[ nRow ][ 40 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 041 ], {|| Tran( aFluxo[ nRow ][ 41 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 042 ], {|| Tran( aFluxo[ nRow ][ 42 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 043 ], {|| Tran( aFluxo[ nRow ][ 43 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 044 ], {|| Tran( aFluxo[ nRow ][ 44 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 045 ], {|| Tran( aFluxo[ nRow ][ 45 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 046 ], {|| Tran( aFluxo[ nRow ][ 46 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 047 ], {|| Tran( aFluxo[ nRow ][ 47 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 048 ], {|| Tran( aFluxo[ nRow ][ 48 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 049 ], {|| Tran( aFluxo[ nRow ][ 49 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 050 ], {|| Tran( aFluxo[ nRow ][ 50 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 051 ], {|| Tran( aFluxo[ nRow ][ 51 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 052 ], {|| Tran( aFluxo[ nRow ][ 52 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 053 ], {|| Tran( aFluxo[ nRow ][ 53 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 054 ], {|| Tran( aFluxo[ nRow ][ 54 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 055 ], {|| Tran( aFluxo[ nRow ][ 55 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 056 ], {|| Tran( aFluxo[ nRow ][ 56 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 057 ], {|| Tran( aFluxo[ nRow ][ 57 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 058 ], {|| Tran( aFluxo[ nRow ][ 58 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 059 ], {|| Tran( aFluxo[ nRow ][ 59 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 060 ], {|| Tran( aFluxo[ nRow ][ 60 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 061 ], {|| Tran( aFluxo[ nRow ][ 61 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 062 ], {|| Tran( aFluxo[ nRow ][ 62 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 063 ], {|| Tran( aFluxo[ nRow ][ 63 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 064 ], {|| Tran( aFluxo[ nRow ][ 64 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 065 ], {|| Tran( aFluxo[ nRow ][ 65 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 066 ], {|| Tran( aFluxo[ nRow ][ 66 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 067 ], {|| Tran( aFluxo[ nRow ][ 67 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 068 ], {|| Tran( aFluxo[ nRow ][ 68 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 069 ], {|| Tran( aFluxo[ nRow ][ 69 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 070 ], {|| Tran( aFluxo[ nRow ][ 70 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 071 ], {|| Tran( aFluxo[ nRow ][ 71 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 072 ], {|| Tran( aFluxo[ nRow ][ 72 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 073 ], {|| Tran( aFluxo[ nRow ][ 73 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 074 ], {|| Tran( aFluxo[ nRow ][ 74 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 075 ], {|| Tran( aFluxo[ nRow ][ 75 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 076 ], {|| Tran( aFluxo[ nRow ][ 76 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 077 ], {|| Tran( aFluxo[ nRow ][ 77 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 078 ], {|| Tran( aFluxo[ nRow ][ 78 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 079 ], {|| Tran( aFluxo[ nRow ][ 79 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( aTitulo[ 080 ], {|| Tran( aFluxo[ nRow ][ 80 ], cMascara ) })) 
oTb:AddColumn( tbcolumnnew( "TOTAL",        {|| Tran( aFluxo[ nRow ][ _MAX_HORIZONTAL ], "@E 999,999,999.99" )  })) 
oTb:ColorSpec:= SetColor() + ",15/06,14/03,00/03,15/01" 
oTB:ColSep:= "³" 
//oTB:HeadSep:= "°" 
oTB:footSep:= "°" 
oTb:Freeze:= 2 
oTb:AUTOLITE:=.f. 
oTb:GOTOPBLOCK:={|| nRow:= 1 } 
oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aFluxo ) } 
oTb:SKIPBLOCK:={|x| skipperarr( x, aFluxo, @nRow ) } 
OTb:dehilite() 
whil .t. 
 
    DISPBEGIN() 
 
     // Cor das duas primeiras colunas - fixadas 
     oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, 2 }, { 2, 1 } ) 
 
     // Barra de Selecao - cursor 
     oTB:colorrect( { oTB:ROWPOS, oTB:COLPOS, oTB:ROWPOS, oTB:COLPOS }, { 2, 1 } ) 
     oTb:REFRESHALL() 
     whil nextkey()=0 .and. !oTB:stabilize() 
     enddo 
 
     // Cor da coluna 
     oTB:colorrect( { 1, oTB:COLPOS, oTB:ROWCOUNT, oTB:COLPOS }, { 5, 2 } ) 
     whil nextkey()=0 .and. !oTB:stabilize() 
     enddo 
 
     /////////////////////// 
     // Cor das duas primeiras colunas - fixadas 
     oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, 2 }, { 2, 1 } ) 
 
     // Barra de Selecao - cursor 
     oTB:colorrect( { oTB:ROWPOS, oTB:COLPOS, oTB:ROWPOS, oTB:COLPOS }, { 2, 1 } ) 
     whil nextkey()=0 .and. !oTB:stabilize() 
     enddo 
     /// 
    DISPEND() 
 
 
 
 
 
     cCorRes:= SetColor() 
 
     SetColor( "00/03" ) 
     Scroll( 22, 00, 24, 79, 0 ) 
     @ 22,01 Say "Total acumulado no mes " + IIF( oTb:COLPOS > 2, ALLTRIM( aTitulo[ oTB:COLPOS ] ), "" ) + " = " + Tran( aFluxo[ nVertical ][ oTB:COLPOS ], cMascara ) 
     @ 23,01 Say "Total acumulado nesta conta = " + Tran( aFluxo[ nRow ][ _MAX_HORIZONTAL ], cMascara ) 
     @ 24,01 Say "Total Geral no periodo = " + Tran( aFluxo[ nVertical ][ _MAX_HORIZONTAL ], "@e 99,999,999.99" ) 
 
     // Display 
     DO CASE 
        CASE nOpcao==1 
             @ 24,40 SAY "1-> Contas quitadas por data de quitacao  " 
        CASE nOpcao==2 
             @ 24,40 SAY "2-> Contas pendentes por vencimento       " 
        CASE nOpcao==3 
             @ 24,40 SAY "3-> Geral por data de emissao             " 
        CASE nOpcao==4 
             @ 24,40 SAY "4-> Geral por data de vencimento          " 
     ENDCASE 
 
 
 
     SetColor( cCorRes ) 
 
     IF ( nTecla:=inkey(0) ) == K_ESC 
        Exit 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTB:up() 
        case nTecla==K_LEFT       ;oTB:left() 
        case nTecla==K_RIGHT      ;oTB:right() 
        case nTecla==K_DOWN       ;oTB:down() 
        case nTecla==K_HOME       ;oTB:panleft() 
        case nTecla==K_END        ;oTB:panright() 
        case nTecla==K_PGUP       ;oTB:pageup() 
        case nTecla==K_PGDN       ;oTB:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
     endcase 
     oTb:Refreshcurrent() 
     oTb:stabilize() 
enddo 
Return(.T.) 
 
 
Function PosicaoConta( aFluxo, nConta ) 
Local nVertical:= -1 
 
     FOR i:= 1 TO Len( aFluxo ) 
         IF aFluxo[ i ][ 1 ] == nConta 
            nVertical:= i 
            EXIT 
         ENDIF 
     NEXT 
     IF nVertical==-1 
        FOR i:= 1 TO Len( aFluxo ) 
            IF aFluxo[ i ][ 1 ] == Nil 
               nVertical:= i 
               EXIT 
            ELSEIF aFluxo[ i ][ 1 ] == 0 
               nVertical:= i 
               EXIT 
            ENDIF 
        NEXT 
     ENDIF 
 
     IF nVertical <= 0 
        nVertical:= 1 
     ENDIF 
 
     IF nVertical < LEN( aFluxo ) 
        IF nVertical > 1 
           IF LEN( aFluxo[ nVertical ] ) >= 1 
              aFluxo[ nVertical ][ 1 ]:= nConta 
           ENDIF 
        ENDIF 
     ENDIF 
 
Return nVertical 
 
 
 
 
 
 
 
 
 
 
 
