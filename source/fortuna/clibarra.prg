// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ CLIBARRAS 
³ Finalidade  ³ Impressao de Codigo de Barras para produtos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 08/02/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function clibarra()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
local nCol2:= 27, cProduto1:= "0000000", cProduto2:= "0000000", nQuantidade:= 1 
local nColuna:= 2, cDevice:= "LPT1    ", nSkip:= 1, nQtd:= 0, nQtdOrigem:= 0, nOldColuna 
Local cEstoque:= "N", dDataBase:= DATE(), cTipo:= "E" 
Local cSaldoA:= "N", nDefSalto:= 13 
Local nEspacoColunas:= 16, nEspacoLinhas:= 5, nLargEtiqueta:= 38 
Local nEtiqueta:= 4 
Local aEtiqueta:= {{ 13, 16, 5, 38, 2, "Etiqueta 23 x 8  PIMACO 2 Colunas" },; 
                   { 13, 12, 2, 38, 2, "Etiqueta 23 x 12 PIMACO 2 Colunas" },; 
                   { 13, 2,  1, 15, 4, "Etiqueta 51 x 15 PIMACO 4 Colunas" },; 
                   { 13, 2,  1, 15, 4, "Etiqueta 51 x 15 PIMACO 4 Colunas" }} 
 
wtelag:= SaveScreen() 
 
SET DEVICE TO SCREEN 
VPBOX( 0, 0, 11, 79, " Impressao de Etiquetas de Codigo de Barras ", _COR_GET_BOX ) 
VPBOX( 12, 0, 22, 79, " Informacoes de Impressao ", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
@ 01,02 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Ä ÄÄÄÄÄÄÄÄ Ä ÄÄÄ¿" 
@ 02,02 Say "³³³Û³³Û³³³³³ Formato EAN13 ³³ °°°±±±²² Sistema CodeBarra-BarSys ²²±±±°°° ³" 
@ 03,02 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Ä ÄÄÄÄÄÄÄÄ Ä ÄÄÄÙ" 
@ 04,02 Say "Etiqueta TP (1/2/3/4)...:" Get nEtiqueta Pict "9" 
READ 
nDefSalto:=          aEtiqueta[ nEtiqueta ][ 1 ] 
nEspacoColunas:=     aEtiqueta[ nEtiqueta ][ 2 ] 
nEspacoLinhas:=      aEtiqueta[ nEtiqueta ][ 3 ] 
nLargEtiqueta:=      aEtiqueta[ nEtiqueta ][ 4 ] 
nColuna:=            aEtiqueta[ nEtiqueta ][ 5 ] 
cDescricaoEtiqueta:= aEtiqueta[ nEtiqueta ][ 6 ] 
@ 04,40 Say "Formulario: "  + cDescricaoEtiqueta 
@ 05,02 Say "Intervalo de Produtos de:" Get cProduto1 Pict "@R 999-9999" 
@ 05,40 Say "At‚:" Get cProduto2 Pict "@R 999-9999" 
@ 06,02 Say "Quantidade de Etiquetas.:" Get nQuantidade 
@ 07,02 Say "Impressora..............: EPSON" 
@ 08,02 Say "Formulario (Colunas)....:" Get nColuna Pict "999" 
@ 09,02 Say "Local de Saida..........:" Get cDevice 
@ 07,40 Say "Movimento de Estoque?  " Get cEstoque 
@ 08,40 Say "[E]Ent/[S]Sai/[ ]Geral:" Get cTipo Pict "!" 
@ 09,40 Say "Data Base.............:" Get dDataBase 
@ 10,02 Say "Quant.Saldo Atual.......:" Get cSaldoA Pict "!" 
READ 
IF LastKey() == K_ESC 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
 
TAX->( DBSetOrder( 2 ) ) 
 
VPBox( 05, 05, 10, 55, " <<< CONFIGURACAO DA ETIQUETA >>> ", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
@ 06,06 Say "Espaco Em Colunas.:" Get nEspacoColuna Pict "999" 
@ 07,06 Say "Espaco Em Linhas..:" Get nEspacoLinha  Pict "999" 
@ 08,06 Say "Definicao de Salto:" Get nDefSalto     Pict "999" 
@ 09,06 Say "Largua Etiqueta...:" Get nLargEtiqueta Pict "999" 
READ 
 
IF !LastKey()==K_ESC 
   TabelaPreco() 
   DBSelectAr( _COD_MPRIMA ) 
ENDIF 
 
/* Incrementa o espacamento entre colunas */ 
nCol2:= nCol2 + nEspacoColuna 
 
nQtdOrigem:= nQuantidade 
IF Val( cProduto1 ) - Val( cProduto2 ) == 0 
   IF nQuantidade == 1 
      nColuna:= 1 
      nSkip:= 0 
      nSkipFinal:= 1 
   ELSE 
      nColuna:= 2 
      nQtdOrigem:= nQuantidade 
      nQtd:= ROUND( nQuantidade / nColuna, 0 ) 
      nQuantidade:= IF( nQtd < ( nQuantidade / nColuna ), nQtd + 1, nQtd ) 
      nSkip:= 0 
      nSkipFinal:= 1 
   ENDIF 
ELSE 
   IF nColuna == 2 
      nSkipFinal:= 2 
   ELSE 
      nSkipFinal:= 1 
   ENDIF 
ENDIF 
 
SET( 24, Alltrim( cDevice ) ) 
DRVCORBOX:= "15/01" 
DRVCORGET:= "01/05" 
 
SetColor(drvcorbox, drvcorget) 
setcursor(1) 
 
 IF cEstoque=="S" 
    DBSelectAr( _COD_MPRIMA ) 
    DBSetOrder( 1 ) 
    Set Relation To INDICE Into TAX 
    DBGoTop() 
    DBSelectAr( _COD_ESTOQUE ) 
    DBSetOrder( 2 ) 
    DBGoTop() 
    dbSeek( dDataBase ) 
    nQuant:= nQuantidade 
 ELSE 
    DBSelectAr( _COD_MPRIMA ) 
    DBSetOrder( 1 ) 
    Set Relation To INDICE Into TAX 
    DBGoTop() 
 ENDIF 
 
 private mcliente 
 
 nOldColuna:= nColuna 
 
 IF cTipo=="S" 
    cTipo:= "-" 
 ELSEIF cTipo=="E" 
    cTipo:= "+" 
 ELSE 
    cTipo:= "+- " 
 ENDIF 
 
 DO CASE 
    CASE nEtiqueta <= 3 
         IF cEstoque $ "sS" 
            nSkipFinal:= 1 
            DBCloseAll() 
            AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
            DBSelectAr( _COD_MPRIMA ) 
            DBSetOrder( 1 ) 
            Set Relation To INDICE Into TAX 
            DBGoTop() 
            DBSelectAr( _COD_ESTOQUE ) 
            DBSetOrder( 2 ) 
            DBGoTop() 
            dbSeek( dDataBase ) 
            WHILE !EST->( EOF() ) .and. EST->DATAMV == dDataBase 
               MPR->( DBSetOrder( 1 ) ) 
               MPR->( DBSeek( PAD( EST->CPROD_, 12 ) ) ) 
               nColuna:= 1 
               nQuantidade:= EST->QUANT_ 
               mcliente:= ALLTRIM( MPR->CODFAB ) 
               mcliente:= mcliente 
               SET DEVICE TO SCREEN 
               @ 13,02 Say "Produto.........: " + PAD( MPR->INDICE + MPR->DESCRI, 55 ) 
               @ 14,02 Say "Cod.Movimentacao: " + EST->CPROD_ 
               @ 15,02 SAY "Registro Produto: " + Str( MPR->( RECNO() ) ) 
               @ 16,02 SAY "Registro Estoque: " + Str( EST->( RECNO() ) ) 
               @ 17,02 SAY "Indices.........: MPR->" + MPR->( INDEXKEY(0) ) + " EST->" + EST->( INDEXKEY(0) ) 
               @ 18,02 SAY "Quantidade......: " + Str( nQuantidade, 8, 2 ) + Str( EST->QUANT_, 8, 2 ) 
               SET DEVICE TO PRINT 
               public cprn_half_, cprn_conde, cprn_norma 
               acer1:= "3" 
               acer8:= "3" 
               acer7:= "3" 
               ljunta:= "1" 
               ljcomp:= "1" 
               normal:= "0" 
               twinic()
               twdefcode( TWEAN13 )       /* TWC39 / TWEAN13 */ 
               twdefsalto( 13 ) 
               twdeflbars( 2, 4 ) 
               twdefalt( 8 ) 
               twdefprint( TWEPSON ) 
               wcod1:= mcliente 
               gen1:= "" 
               IF !cProduto1 == cProduto2 .AND. cProduto2 == Alltrim( MPR->INDICE ) 
                  nSkip:= 0 
                  nQtd:= ROUND( nQuantidade / nColuna, 0 ) 
                  nQuantidade:= IF( nQtd < ( nQuantidade / nColuna ), nQtd + 1, nQtd ) 
                  nSkip:= 0 
                  nSkipFinal:= 1 
                  cProduto1:= cProduto2 
               ENDIF 
               /* ROTINA DE IMPRESSAO */ 
               FOR nCt:= 1 TO ( nQuantidade / nColuna ) + 1 
                   Set Device To Screen 
                   IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
                      SetCursor( nCursor ) 
                      SetColor( cCor ) 
                      ScreenRest( cTela ) 
                      Return Nil 
                   ENDIF 
                  @ 18,02 SAY "Qtd.Impressoes..: " + ; 
                                Alltrim( Str( nCt, 8 ) ) + ; 
                        " / " + Alltrim( Str( nQuantidade, 8 ) ) + Space( 10 ) 
                  Set Device To Print 
                  IF VAL( CPROD_ ) >= VAL( cProduto1 ) .AND.; 
                     VAL( CPROD_ ) <= VAL( cProduto2 ) 
                     nColuna:= nOldColuna 
                     IF cProduto1 == cProduto2 
                        IF ( nQtdOrigem / 2 ) < nQuantidade .AND.; 
                            ( nCt == nQuantidade ) 
                            nColuna:= 1 
                        ENDIF 
                     ENDIF 
                     TWDEFSALTO( nDefSalto ) 
                     @ PROW() + nEspacoLinhas, 00 SAY " " 
                     TWDEFSALTO( 13 ) 
                     @ PROW(), 00 SAY PADC( Left( _EMP, 26 ), 26 ) 
                     IF nColuna == 2 
                        DBSkip( + nSkip ) 
                        IF VAL( CPROD_ ) >= VAL( cProduto1 ) .AND.; 
                           VAL( CPROD_ ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 Say PADC( Left( _EMP, 26 ), 26 ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
                     @ PROW() + 1, 00 SAY " " + LEFT( MPR->DESCRI, 26 ) 
                     @ PROW(),     00 SAY " " + LEFT( MPR->DESCRI, 26 ) 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 Say " " + LEFT( MPR->DESCRI, 26 ) 
                           @ PROW(), nCol2 SAY " " + LEFT( MPR->DESCRI, 26 ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
                     @ PROW()+1,00 SAY Space(1)          ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), PCOL() + 1 Say "         Preco R$ " 
                     @ PROW(), 0 SAY LJCOMP + SPACE( 1 ) ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), 0 SAY LJCOMP + SPACE( 1 ) ; twimpcod( MPR->CODFAB ) 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 SAY Space(1)          ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), PCOL() + 1 Say "          Preco R$ " 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
                     @ PROW()+1, 0 SAY LJCOMP + Space(1) ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), 0 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), 0 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
                     @ PROW() + 1, 00 Say acer1 + " " + acer7 
                     @ PROW() + 1, 00 Say iNegrito( .T. ) + iExpandido( .t. ) + "        " + TRAN( MPR->PRECOV, "@E 999,999.99" ) + iExpandido( .F. ) 
                     @ PROW(), 00 Say LEFT( " " + MPR->CODFAB + " " + LEFT( MPR->DESCRI, 2 ) + STRTRAN( ALLTRIM( STR( TAX->PRECOV, 6, 2 ) ), ".", "-" ), nLargEtiqueta ) 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 Say acer1 + " " + acer7 
                           @ PROW(), nCol2 Say iNegrito( .T. ) + iExpandido( .t. ) + "        " + TRAN( MPR->PRECOV, "@E 999,999.99" ) + iExpandido( .F. ) 
                           @ PROW(), nCol2 Say LEFT( " " + MPR->CODFAB + " " + LEFT( MPR->DESCRI, 2 ) + STRTRAN( ALLTRIM( STR( TAX->PRECOV, 6, 2 ) ), ".", "-" ), nLargEtiqueta ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
                     @ PROW(), 00 Say normal 
                     @ PROW(), 00 SAY SPACE( 2 ) 
                  ENDIF 
               NEXT 
               EST->( DBSkip( nSkipFinal ) ) 
            ENDDO 
         ELSE 
            WHILE !MPR->( EOF() ) 
                mcliente:= ALLTRIM( MPR->CODFAB ) 
                //caixa(mold, 8, 15, 14, 64, 500, .T.) 
                mcliente:= mcliente 
                SET DEVICE TO SCREEN 
                @ 13,02 Say "Produto.........: " + PAD( MPR->INDICE + MPR->DESCRI, 55 ) 
                @ 14,02 Say "Cod.Movimentacao: " + EST->CPROD_ 
                @ 15,02 SAY "Registro Produto: " + Str( MPR->( RECNO() ) ) 
                @ 16,02 SAY "Registro Estoque: Inexistente" 
                @ 17,02 SAY "Indices.........: MPR->" + MPR->( INDEXKEY(0) ) 
                @ 18,02 SAY "Quantidade......: " + Str( nQuantidade, 8, 2 ) 
                SET DEVICE TO PRINT 
                public cprn_half_, cprn_conde, cprn_norma 
                acer1:= "3" 
                acer8:= "3" 
                acer7:= "3" 
                ljunta:= "1" 
                ljcomp:= "1" 
                normal:= "0" 
                twinic() 
                twdefcode( TWEAN13 )       /* TWC39 / TWEAN13 */ 
                twdefsalto( 13 ) 
                twdeflbars( 2, 4 ) 
                twdefalt( 8 ) 
                twdefprint( TWEPSON ) 
                wcod1:= mcliente 
                gen1:= "" 
                IF !cProduto1 == cProduto2 .AND. cProduto2 == Alltrim( MPR->INDICE ) 
                   nSkip:= 0 
                   nQtd:= ROUND( nQuantidade / nColuna, 0 ) 
                   nQuantidade:= IF( nQtd < ( nQuantidade / nColuna ), nQtd + 1, nQtd ) 
                   nSkip:= 0 
                   nSkipFinal:= 1 
                   cProduto1:= cProduto2 
                ENDIF 
 
                IF cSaldoA=="S" 
                   nQuantidade:= ( MPR->SALDO_ / nColuna ) 
                   IF nQuantidade > INT( nQuantidade ) 
                      nQuantidade:= nQuantidade + 1 
                   ENDIF 
                   IF MPR->SALDO_ > 0 
                      nSkipFinal:= 1 
                   ELSE 
                      nSkipFinal:= 1 
                   ENDIF 
                   nSkip:= 0 
                ENDIF 
 
               /* ROTINA DE IMPRESSAO */ 
               FOR nCt:= 1 TO nQuantidade 
 
                  IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
                     Set Device To Screen 
                     SetCursor( nCursor ) 
                     SetColor( cCor ) 
                     ScreenRest( cTela ) 
                     Return Nil 
                  ENDIF 
 
                  IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                     VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
 
                     nColuna:= nOldColuna 
                     IF cProduto1 == cProduto2 
                        IF ( nQtdOrigem / 2 ) < nQuantidade .AND.; 
                           ( nCt == nQuantidade ) 
                           nColuna:= 1 
                        ENDIF 
                     ENDIF 
 
                     TWDEFSALTO( nDefSalto ) 
                     @ PROW() + nEspacoLinha, 00 SAY " " 
                     TWDEFSALTO( 13 ) 
                     @ PROW(), 00 SAY PADC( Left( _EMP, 26 ), 26 ) 
                     IF nColuna == 2 
                        DBSkip( + nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 Say PADC( Left( _EMP, 26 ), 26 ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
 
                     @ PROW() + 1, 00 SAY " " + LEFT( MPR->DESCRI, 26 ) 
                     @ PROW(),     00 SAY " " + LEFT( MPR->DESCRI, 26 ) 
 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 Say " " + LEFT( MPR->DESCRI, 26 ) 
                           @ PROW(), nCol2 SAY " " + LEFT( MPR->DESCRI, 26 ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
 
                     @ PROW()+1,00 SAY Space(1)          ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), PCOL() + 1 Say "         Preco R$ " 
                     @ PROW(), 0 SAY LJCOMP + SPACE( 1 ) ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), 0 SAY LJCOMP + SPACE( 1 ) ; twimpcod( MPR->CODFAB ) 
 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 SAY Space(1)          ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), PCOL() + 1 Say "          Preco R$ " 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
 
                     @ PROW()+1, 0 SAY LJCOMP + Space(1) ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), 0 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                     @ PROW(), 0 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1) ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                           @ PROW(), nCol2 SAY LJCOMP + Space(1)   ; twimpcod( MPR->CODFAB ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
 
                     @ PROW() + 1, 00 Say acer1 + " " + acer7 
                     @ PROW() + 1, 00 Say iNegrito( .T. ) + iExpandido( .t. ) + "        " + TRAN( MPR->PRECOV, "@E 999,999.99" ) + iExpandido( .F. ) 
                     @ PROW(), 00 Say LEFT( " " + MPR->CODFAB + " " + LEFT( MPR->DESCRI, 2 ) + STRTRAN( ALLTRIM( STR( TAX->PRECOV, 6, 2 ) ), ".", "-" ), nLargEtiqueta ) 
 
                     IF nColuna == 2 
                        DBSkip( nSkip ) 
                        IF VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                           VAL( MPR->INDICE ) <= VAL( cProduto2 ) 
                           @ PROW(), nCol2 Say acer1 + " " + acer7 
                           @ PROW(), nCol2 Say iNegrito( .T. ) + iExpandido( .t. ) + "        " + TRAN( MPR->PRECOV, "@E 999,999.99" ) + iExpandido( .F. ) 
                           @ PROW(), nCol2 Say LEFT( " " + MPR->CODFAB + " " + LEFT( MPR->DESCRI, 2 ) + STRTRAN( ALLTRIM( STR( TAX->PRECOV, 6, 2 ) ), ".", "-" ), nLargEtiqueta ) 
                        ENDIF 
                        DBSkip( nSkip * (-1) ) 
                     ENDIF 
                     @ PROW(), 00 Say normal 
                     @ PROW(), 00 SAY SPACE( 2 ) 
                  ENDIF 
               NEXT 
               DBSkip( nSkipFinal ) 
           end 
        ENDIF 
    CASE nEtiqueta >= 4 
        DBCloseAll() 
        AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
        TAX->( DBSetOrder( 2 ) ) 
        DBSelectAr( _COD_MPRIMA ) 
        DBSetOrder( 1 ) 
        Set Relation To INDICE Into TAX 
        DBGoTop() 
        IF cEstoque $ "sS" 
           DBSelectAr( _COD_ESTOQUE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           Index On DATAMV To In9200 FOR VAL( CPROD_ ) >= VAL( cProduto1 ) .AND. ; 
                                         VAL( CPROD_ ) <= VAL( cProduto2 ) .AND.; 
                                         ENTSAI $ cTipo .AND.; 
                                         DATAMV == dDataBase EVAL {|| Processo() } 
           DBGoTop() 
           dbSeek( dDataBase ) 
           WHILE !EST->( EOF() ) 
               MPR->( DBSeek( PAD( EST->CPROD_, 12 ) ) ) 
               nQuantidade:= EST->QUANT_ 
               cProd1:= "" 
               cProd2:= "" 
               cProd3:= "" 
               cProd4:= "" 
               Set Device To Screen 
               IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
                  SetCursor( nCursor ) 
                  SetColor( cCor ) 
                  ScreenRest( cTela ) 
                  Return Nil 
               ENDIF 
               cProd1:=   MPR->DESCRI 
               cCodFab1:= MPR->CODFAB 
               nPreco11:= MPR->PRECOV 
               nPreco21:= TAX->PRECOV 
               nQuantidade:= EST->QUANT_ 
               ++nQtd 
               IF nQtd >= nQuantidade 
                  nQtd:= 0 
                  EST->( DBSkip() ) 
                  MPR->( DBSeek( PAD( EST->CPROD_, 12 ) ) ) 
                  nQuantidade:= EST->QUANT_ 
               ENDIF 
               cProd2:=   MPR->DESCRI 
               cCodFab2:= MPR->CODFAB 
               nPreco12:= MPR->PRECOV 
               nPreco22:= TAX->PRECOV 
               ++nQtd 
               IF nQtd >= nQuantidade 
                  nQtd:= 0 
                  EST->( DBSkip() ) 
                  MPR->( DBSeek( PAD( EST->CPROD_, 12 ) ) ) 
                  nQuantidade:= EST->QUANT_ 
               ENDIF 
               cProd3:=   MPR->DESCRI 
               cCodFab3:= MPR->CODFAB 
               nPreco13:= MPR->PRECOV 
               nPreco23:= TAX->PRECOV 
               ++nQtd 
               IF nQtd >= nQuantidade 
                  nQtd:= 0 
                  EST->( DBSkip() ) 
                  MPR->( DBSeek( PAD( EST->CPROD_, 12 ) ) ) 
                  nQuantidade:= EST->QUANT_ 
               ENDIF 
               cProd4:=   MPR->DESCRI 
               cCodFab4:= MPR->CODFAB 
               nPreco14:= MPR->PRECOV 
               nPreco24:= TAX->PRECOV 
               ++nQtd 
               IF nQtd >= nQuantidade 
                  nQtd:= 0 
                  EST->( DBSkip() ) 
                  MPR->( DBSeek( PAD( EST->CPROD_, 12 ) ) ) 
                  nQuantidade:= EST->QUANT_ 
               ENDIF 
               Relatorio( "BARRAS.REP" ) 
           ENDDO 
        ELSE 
           /* Materia-Prima */ 
           DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           Index On DESCRI To IND0001.NTX FOR VAL( MPR->INDICE ) >= VAL( cProduto1 ) .AND.; 
                                              VAL( MPR->INDICE ) <= VAL( cProduto2 ) EVAL {|| Processo() } 
           DBGoTop() 
           WHILE !MPR->( EOF() ) 
              Set Device To Screen 
              Inkey() 
              IF LastKey()==K_ESC .OR. NextKey()==K_ESC 
                 SetCursor( nCursor ) 
                 SetColor( cCor ) 
                 ScreenRest( cTela ) 
                 Return Nil 
              ENDIF 
              cProd1:= "" 
              cProd2:= "" 
              cProd3:= "" 
              cProd4:= "" 
              cProd1:=   MPR->DESCRI 
              cCodFab1:= MPR->CODFAB 
              nPreco11:= MPR->PRECOV 
              nPreco21:= TAX->PRECOV 
              IF ++nQtd >= nQuantidade 
                 nQtd:= 0 
                 MPR->( DBSkip() ) 
                 IF cSaldoA=="S" 
                    nQuantidade:= MPR->SALDO_ 
                 ENDIF 
              ENDIF 
              cProd2:=   MPR->DESCRI 
              cCodFab2:= MPR->CODFAB 
              nPreco12:= MPR->PRECOV 
              nPreco22:= TAX->PRECOV 
              IF ++nQtd >= nQuantidade 
                 nQtd:= 0 
                 MPR->( DBSkip() ) 
                 IF cSaldoA=="S" 
                    nQuantidade:= MPR->SALDO_ 
                 ENDIF 
              ENDIF 
              cProd3:=   MPR->DESCRI 
              cCodFab3:= MPR->CODFAB 
              nPreco13:= MPR->PRECOV 
              nPreco23:= TAX->PRECOV 
              IF ++nQtd >= nQuantidade 
                 nQtd:= 0 
                 MPR->( DBSkip() ) 
                 IF cSaldoA=="S" 
                    nQuantidade:= MPR->SALDO_ 
                 ENDIF 
              ENDIF 
              cProd4:=   MPR->DESCRI 
              cCodFab4:= MPR->CODFAB 
              nPreco14:= MPR->PRECOV 
              nPreco24:= TAX->PRECOV 
              IF ++nQtd >= nQuantidade 
                 nQtd:= 0 
                 MPR->( DBSkip() ) 
                 IF cSaldoA=="S" 
                    nQuantidade:= MPR->SALDO_ 
                 ENDIF 
              ENDIF 
              Relatorio( "BARRAS.REP" ) 
           ENDDO 
        ENDIF 
   ENDCASE 
 
   Set(20, "SCREEN") 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   IF Used() 
      DBCloseAll() 
   ENDIF 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
FUNCTION iExpandido( lExpande ) 
Local cReturn 
IF lExpande 
   cReturn:= CHR( 14 ) 
ELSE 
   cReturn:= CHR( 20 ) 
ENDIF 
Return cReturn 
 
 
FUNCTION iNegrito( lNegrito ) 
Local cReturn 
IF lNegrito 
   cReturn:= CHR( 27 ) + CHR( 69 ) 
ELSE 
   cReturn:= CHR( 20 ) + CHR( 70 ) 
ENDIF 
Return cReturn 
 
FUNCTION iCompactado( lSim ) 
IF lSim 
   cReturn:= CHR( 27 ) + CHR( 15 ) 
ELSE 
   cReturn:= CHR( 27 ) + CHR( 18 ) 
ENDIF 
Return cReturn 
