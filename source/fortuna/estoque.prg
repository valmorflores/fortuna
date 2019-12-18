// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ProdutoCustoMedio 
³ Finalidade  ³ Retornar o calculo do custo medio de um produto 
³ Parametros  ³ cProduto= Codigo do produto 
³ Retorno     ³ nCusMed= Custo medio do produto 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 31/Marco/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION ProdutoCustoMedio( cProduto ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd(), nSdoVlr:= 0, nSdoQtd:= 0,; 
      nCusMed:= 0, nSaldo, nRegistro:= RECNO() 
 
   DBSelectAr( _COD_ESTOQUE ) 
   cProduto:= PAD( cProduto, Len( CPROD_ ) ) 
 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   IF DBSeek( cProduto ) 
      nSaldo:= SALDO_ 
   ELSE 
      nSaldo:= 0 
   ENDIF 
 
   /* movimento em estoque */ 
   dbselectar(_COD_ESTOQUE) 
   DBSetOrder( 1 ) 
   nRegistros:= 1 
 
   DBSeek( cProduto ) 
   /* Vai para o ultimo registro do banco de dados do estoque */ 
   WHILE CPROD_ == cProduto 
       DBSkip() 
   ENDDO 
   DBSkip( -1 ) 
 
   /* Loop */ 
   WHILE CPROD_ == cProduto 
         IF EntSai == "+" 
           nEntQtd:= Quant_ 
           nSdoQtd:= nSdoQtd + nEntQtd 
           nEntVlr:= Valor_ 
           nSdoVlr:= nSdoVlr + Valor_ 
           nCusUni:= Valor_  / Quant_ 
        ENDIF 
        nCusMed:= nSdoVlr / nSdoQtd 
        IF nSdoQtd >= nSaldo 
           Exit 
        ENDIF 
        dbSkip( -1 ) 
        ++nRegistros 
   ENDDO 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
 
   IF nOrdem > 0 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
      DBGoTo( nRegistro ) 
   ENDIF 
 
   /* Retorna o custo medio */ 
   Return nCusMed 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ IcmMedio 
³ Finalidade  ³ Retornar o calculo do custo medio de ICM de um produto 
³ Parametros  ³ cProduto= Codigo do produto 
³ Retorno     ³ nCusMed= Custo medio do produto 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 31/Marco/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION IcmMedio( cProduto ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd(), nSdoVlr:= 0, nSdoQtd:= 0,; 
      nIcmMed:= 0 
 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   cProduto:= PAD( cProduto, Len( INDICE ) ) 
   IF DBSeek( cProduto ) 
      nSaldo:= SALDO_ 
   ELSE 
      nSaldo:= 0 
   ENDIF 
 
   /* filtrar movimento em estoque */ 
   dbselectar(_COD_ESTOQUE) 
   DBSetOrder( 1 ) 
   nRegistros:= 1 
 
   DBSeek( cProduto ) 
 
   /* Vai para o ultimo registro do banco de dados do estoque */ 
   WHILE CPROD_ == cProduto 
       DBSkip() 
   ENDDO 
   DBSkip( -1 ) 
 
   /* Loop */ 
   WHILE CPROD_ == cProduto 
        IF EntSai == "+" 
           nEntQtd:= Quant_ 
           nSdoQtd:= nSdoQtd + nEntQtd 
           nEntVlr:= VlrIcm 
           nSdoVlr:= nSdoVlr + VlrIcm 
           nCusUni:= VlrIcm / Quant_ 
        ENDIF 
        nIcmMed:= nSdoVlr / nSdoQtd 
        IF nSdoQtd >= nSaldo 
           Exit 
        ENDIF 
        dbSkip( -1 ) 
        ++nRegistros 
   ENDDO 
 
   /* Se possuia alguma ordem, restaura */ 
   IF nOrdem > 0 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
   ENDIF 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
 
   /* Retorna o custo medio */ 
   Return nIcmMed 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ UltimoPreco 
³ Finalidade  ³ Ver ultimo preco do produto 
³ Parametros  ³ cProduto= Codigo do produto 
³ Retorno     ³ nCusMed= Custo medio do produto 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 31/Marco/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION UltimoPreco( cProduto ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd(), nSdoVlr:= 0, nSdoQtd:= 0,; 
      nUltimoPreco:= 0 
 
   /* filtrar movimento em estoque */ 
   dbselectar(_COD_ESTOQUE) 
   DBSetOrder( 1 ) 
   nRegistros:= 1 
 
   cProduto:= PAD( cProduto, Len( CPROD_ ) ) 
   DBSeek( cProduto ) 
 
   /* Loop */ 
   WHILE CPROD_ == cProduto 
        IF EntSai == "+" 
           nUltimoPreco:= VALOR_ / Quant_ 
        ENDIF 
        dbSkip() 
        IF EOF() 
           Exit 
        ENDIF 
   ENDDO 
 
   /* Se possuia alguma ordem, restaura */ 
   IF nOrdem > 0 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
   ENDIF 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
 
   /* Retorna o ultimo preco */ 
   Return nUltimoPreco 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ OrdensPendentes 
³ Finalidade  ³ 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function OrdensPendentes( cProduto ) 
Local nOrdem:= IndexOrd(), nArea:= Select() 
Local nQtdPendente:= 0 
DBSelectAr( _COD_OC_AUXILIA ) 
DBSetOrder( 2 ) 
cProduto:= PAD( cProduto, 12 ) 
DBSeek( cProduto ) 
WHILE cProduto == CODPRO 
    IF Recebi < Quant_ 
       nQtdPendente+= Quant_ - Recebi 
    ENDIF 
    DBSkip() 
ENDDO 
DBSetOrder( 1 ) 
IF nOrdem > 0 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
Endif 
Return nQtdPendente 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ AtualizaPreco 
³ Finalidade  ³ Atualizar preco dos produtos com base no preco de custo MEDIO 
³ Parametros  ³ cProduto 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function AtualizaPreco( cProduto ) 
cProduto:= PAD( cProduto, 12 ) 
nCustoMedio:= CustoMedio( cProduto ) 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 1 ) 
IF DBSeek( cProduto ) 
   Mensagem( " Ajustando P. Venda Produto: " + Alltrim( CODFAB ) + "->" + Alltrim( DESCRI ) + ", aguarde..." ) 
   /* claculando e gravando o preco de venda */ 
   nPrecoVenda:= nCustoMedio + ( ( nCustoMedio * PERCPV ) / 100 ) 
   IF NetRLock() 
      Replace PRECOV With ROUND( nPrecoVenda, 2 ) 
      DBUnlock() 
   ENDIF 
   /* Pesquisando preco por fornecedor */ 
   DBSelectAr( _COD_PRECOXFORN ) 
   DBSetOrder( 1 ) 
   IF DBSeek( cProduto ) 
      IF NetRLock() 
         Replace PVELHO With VALOR_ 
         Replace CPROD_ With cProduto,; 
                 VALOR_ With ROUND( nCustoMedio, 2 ),; 
                 DATA__ With DATE() 
      ENDIF 
   ENDIF 
ENDIF 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TiraDoEstoque 
³ Finalidade  ³ Retirar saldo do arquivo de produtos 
³ Parametros  ³ cProduto, nQuantidade 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 20/Janeiro/1996 
³ Atualizacao ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function TiraDoEstoque( cProduto, nQuantidade ) 
   LOCAL nArea:= Select(), nOrdem:= IndexOrd(),; 
         cTela:= ScreenSave( 22, 0, 24, 79 ) 
   Mensagem( "Atualizando arquivo de produtos, aguarde..." ) 
   DBSelectArea( _COD_MPRIMA ) 
   IF Used() 
      DBSetOrder( 1 ) 
      /* Ajuste da variavel cProduto para o tamanho original ( 12 ) */ 
      cProduto:= PAD( cProduto, 12 ) 
      IF dbSeek( cProduto ) 
         IF NetRLock() 
            Replace MPR->Saldo_ With ( MPR->SALDO_ - nQuantidade ) 
            GravaLogTmp( "ESTOQUE! " + "Gravacao realizada com sucesso!" + "Em " + DTOC( DATE() ) + "as " + TIME() + " USUARIO:" + StrZero( nGCodUser, 3, 0 ) + Chr( 13 ) + Chr( 10 ) ) 
 
            /* 
            IF MPR->MPRIMA == "N" 
               DBSelectAr( _COD_ASSEMBLER ) 
               IF DBSeek( cProduto ) 
                  WHILE ASM->CODPRD == cProduto 
                      DBSelectAr( _COD_MPRIMA ) 
                      IF dbseek( ASM->CODMPR ) 
                         IF NetRLock() 
                            Replace MPR->SALDO_ With MPR->SALDO_ - ( nQuantidade * ASM->QUANT_ ) 
                         ENDIF 
                      ENDIF 
                      ASM->( DBSkip() ) 
                  ENDDO 
               ENDIF 
            ENDIF 
            */ 
 
         ELSE 
            cTela:= ScreenSave( 0, 0, 21, 79 ) 
            Aviso( "ESTOQUE: Atualizacao de saida do produto " + ALLTRIM( cProduto ) + " imposs¡vel...", .T. ) 
            GravaLogTmp( "ESTOQUE! " + "Produto nao localizado...." + " USUARIO:" + StrZero( nGCodUser, 3, 0 ) + Chr( 13 ) + Chr( 10 ) ) 
         ENDIF 
         DBUnlock() 
      ELSE 
         cTela:= ScreenSave( 0, 0, 21, 79 ) 
         Aviso( "ESTOQUE: Atualizacao de saida do produto " + ALLTRIM( cProduto ) + " imposs¡vel...", .T. ) 
         GravaLogTmp( "ESTOQUE! " + "Produto nao localizado...." + " USUARIO:" + StrZero( nGCodUser, 3, 0 ) + " Em " + DTOC( DATE() ) + " as " + TIME() + Chr( 13 ) + Chr( 10 ) ) 
      ENDIF 
   ENDIF 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ PoeNoEstoque 
³ Finalidade  ³ Colocar saldo no arquivo de produtos 
³ Parametros  ³ cProduto, nQuantidade 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 20/Janeiro/1996 
³ Atualizacao ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function PoeNoEstoque( cProduto, nQuantidade ) 
   LOCAL nArea:= Select(), nOrdem:= IndexOrd(), cTela:= ScreenSave( 22, 00, 24, 79 ) 
   Mensagem( "Atualizando arquivo de produtos, aguarde..." ) 
   DBSelectArea( _COD_MPRIMA ) 
   IF Used() 
      DBSetOrder( 1 ) 
      /* Ajuste da variavel cProduto para o tamanho original ( 12 ) */ 
      cProduto:= cProduto + Space( 12 - Len( cProduto ) ) 
      IF dbSeek( cProduto ) 
         IF NetRLock() 
            Replace MPR->Saldo_ With ( MPR->SALDO_ + nQuantidade ) 
            /* Atualizacao de sub-produtos em caso de 
               venda de um produto montado */ 
 
            /* 
            IF MPR->MPRIMA == "N" 
               DBSelectAr( _COD_ASSEMBLER ) 
               IF DBSeek( cProduto ) 
                  WHILE ASM->CODPRD == cProduto 
                      DBSelectAr( _COD_MPRIMA ) 
                      IF dbseek( ASM->CODMPR ) 
                         IF NetRLock() 
                            Replace MPR->SALDO_ With MPR->SALDO_ + ( nQuantidade * ASM->QUANT_ ) 
                         ENDIF 
                      ENDIF 
                      ASM->( DBSkip() ) 
                  ENDDO 
               ENDIF 
            ENDIF 
            */ 
 
 
 
         ENDIF 
         DBUnlock() 
      ELSE 
         cTela:= ScreenSave( 0, 0, 21, 79 ) 
         Aviso( "ESTOQUE: Atualizacao de Entrada do produto " + cProduto + "nÆo foi poss¡vel...", .T. ) 
         GravaLogTmp( "ESTOQUE! " + "Produto nao localizado...." + " USUARIO: " + StrZero( nGCodUser, 3, 0 ) + Chr( 13 ) + Chr( 10 ) ) 
         ScreenRest( cTela ) 
      ENDIF 
   ENDIF 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ LANCEstoque() 
³ Finalidade  ³ Efetuar os lancamento no movimento de estoque 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄ´ 
³ Variaveis   ³ cTipoMovimento == "E/S/1/2/3/4" 
³ Importantes ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION LancEstoque( cProduto, cCodRed, cEntSai, cDoc, nCodigo, nVlrSdo, ; 
   nValor, nQuant, nRespons, dData, nVlrIcm, nVlrIpi, nVlrFre, nMovEst, ; 
   nNatOpe, nPerIcm, nClasse, nTamCod, nCorCod, nTamQua, aCorTamQua, cTipoMovimento ) 
 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local nMprReg:= MPR->( RECNO() ) 
   Local nEntSai:= 0, cString:= "" 
 
   // Busca produto no cadastro 
   MPR->( DBSetOrder( 1 ) ) 
   MPR->( DBSeek( cProduto ) ) 
 
   /* Conferencia da Variavel cTipoMovimento */ 
   IF cTipoMovimento==Nil 
      cTipoMovimento:= cEntSai 
   ELSEIF VALTYPE( cTipoMovimento ) <> "C" 
      cTipoMovimento:= cEntSai 
   ENDIF 
 
   IF !( cEntSai $ "+-" ) 
      ScreenRest( cTela ) 
      nEntSai:= SWAlerta( " << PROBLEMA NO ESTOQUE >>; NÆo esta definida uma operacao para; esta movimentacao com produtos; O que deseja fazer?", { "Dar Saida", "Dar Entrada", "Nao Atualizar Estoque" } ) 
      IF nEntSai==1 
         cEntSai:= "+" 
      ELSE 
         cEntSai:= "-" 
      ENDIF 
 
      cString:=           "FALHA NO ESTOQUE!"                     + Chr( 10 ) + Chr( 13 ) 
      cString:= cString + "Usuario:" + StrZero( nGCodUser, 3, 0 ) + Chr( 10 ) + Chr( 13 ) 
      cString:= cString + "*********"                             + Chr( 10 ) + Chr( 13 ) 
 
      GravaLogTmp( cString ) 
 
   ENDIF 
 
   nVlrIpi:= IF( nVlrIpi == Nil, 0, nVlrIpi ) 
   nMovEst:= IF( nMovEst == Nil, 0, nMovEst ) 
   nVlrFre:= IF( nVlrFre == Nil, 0, nVlrFre ) 
   nNatOpe:= IF( nNatOpe == Nil, 0, nNatOpe ) 
   nClasse:= IF( nClasse == Nil, 0, nClasse ) 
   nTamCod:= IF( nTamCod == Nil, 0, nTamCod ) 
   nCorCod:= IF( nCorCod == Nil, 0, nCorCod ) 
   nTamQua:= IF( nTamQua == Nil, 0, nTamQua ) 
   aCorTamQua := IF( aCorTamQua == Nil, {}, aCorTamQua ) 
 
   /* Atualiza Precos */ 
   IF cTipoMovimento $ "E/S/2/4/+/-" 
      IF cEntSai == "+" 
         MPR->( DBSetOrder( 1 ) ) 
         IF MPR->( DBSeek( PAD( cProduto, 12 ) ) ) 
            IF MPR->( NetRLock() ) 
               Replace MPR->SDOVLR With MPR->SDOVLR + nValor,; 
                       MPR->CUSMED With MPR->SDOVLR / MPR->SALDO_,; 
                       MPR->ENTQTD With MPR->ENTQTD + nQuant,; 
                       MPR->DTULTE With dData,; 
                       MPR->QTULTE With nQuant,; 
                       MPR->CUSATU With MPR->CUSMED 
            ENDIF 
            PoeNoEstoque( cProduto, nQuant ) 
            IF SWSet( _GER_ATUALIZAPRECO ) 
               AtualizaPreco( cProduto ) 
            ENDIF 
         ENDIF 
      ELSEIF cEntSai == "-" 
         MPR->( DBSetOrder( 1 ) ) 
         IF MPR->( DBSeek( PAD( cProduto, 12 ) ) ) 
            IF MPR->( NetRLock() ) 
               Replace MPR->SDOVLR With MPR->SDOVLR - ( nQuant * MPR->CUSMED ),; 
                       MPR->SAIQTD With MPR->SAIQTD + nQuant,; 
                       MPR->DTULTS With dData,; 
                       MPR->QTULTS With nQuant 
            ENDIF 
            TiraDoEstoque( cProduto, nQuant ) 
         ENDIF 
      ENDIF 
   ENDIF 
 
   lMovimenta:= .T. 
   MPR->( DBSetOrder( 1 ) ) 
   IF MPR->( DBSeek( cProduto ) ) 
      IF MPR->MPRIMA == "N" 
         /* produto composto.... verifica o tipo de movimento 
            que devera ser realizado */ 
         IF cTipoMovimento $ "E/S/2/4/+/-" 
            lMovimenta:= .T. 
         ELSE 
            lMovimenta:= .F. 
         ENDIF 
      ENDIF 
   ENDIF 
 
   DBSelectar( _COD_ESTOQUE ) 
   IF lMovimenta 
      IF buscanet(5,{|| dbappend(), !neterr()}) 
         repl CPROD_ with cProduto,; 
              CODRED with cCodRed,; 
              ENTSAI with cEntSai,; 
              DOC___ with cDoc,; 
              CODIGO with nCodigo,; 
              VLRSDO with nVlrSdo,; 
              VLRSAI with nValor,; 
              QUANT_ with nQuant,; 
              VALOR_ With nValor,; 
              RESPON with nRespons,; 
              DATAMV With dData,; 
              CODMV_ With nMovEst,; 
              VLRIPI With nVlrIpi,; 
              VLRFRE With nVlrFre,; 
              NATOPE With nNatOpe,; 
              PERICM With IF( nPerIcm==Nil, 0, nPerIcm ),; 
              CUSMED With MPR->CUSATU,; 
              PCPCLA With nClasse,; 
              PCPTAM With nTamCod,; 
              PCPCOR With nCorCod,; 
              PCPQUA With nTamQua 
         IF !( nVlrIcm == Nil ) 
            Replace VLRICM With nVlrIcm,; 
                    TOTAL_ With nVlrIpi + nVlrFre + nVlrIcm + nValor 
         ENDIF 
         fAtuEstPCP( cProduto, cCodRed, cEntSai,  cDoc,    nCodigo, nVlrSdo, ; 
                     nValor,   nQuant,  nRespons, dData,   nVlrIcm, nVlrIpi, ; 
                     nVlrFre,  nMovEst, nNatOpe,  nPerIcm, nClasse, nTamCod, ; 
                     nCorCod,  nTamQua, aCorTamQua ) 
      ENDIF 
   ENDIF 
 
   DBSelectArea( _COD_MPRIMA ) 
   IF Used() 
      DBSetOrder( 1 ) 
      /* Ajuste da variavel cProduto para o tamanho original ( 12 ) */ 
      cProduto:= PAD( cProduto, 12 ) 
      IF dbSeek( cProduto ) 
         lMovimenta:= .F. 
         IF MPR->MPRIMA == "N" 
            IF cTipoMovimento $ "E/S/1/3/+/-" 
               lMovimenta:= .T. 
            ELSE 
               lMovimenta:= .F. 
            ENDIF 
         ENDIF 
         IF lMovimenta 
            /* Atualizacao de sub-produtos em caso de 
               Movimento de um produto montado */ 
            DBSelectAr( _COD_ASSEMBLER ) 
            DBSetOrder( 1 ) 
            IF DBSeek( cProduto ) 
               WHILE TRIM( ASM->CODPRD ) == TRIM( cProduto ) 
                     DBSelectAr( _COD_ESTOQUE ) 
                     LancEstoque( ASM->CODMPR, ASM->CODMPR, cEntSai,; 
                                          ALLTrim( cDoc ) + "*CMP*",; 
                                     nCodigo, 0, 0, nQuant * ASM->QUANT_,; 
                                     nRespons, dData, nVlrIcm, nVlrIPI,; 
                                     nVlrFre, nMovEst, nNatOpe, nPerIcm,; 
                                     nClasse, nTamCod, nCorCod, nTamQua,; 
                                     aCorTamQua, IF( cTipoMovimento $ "E/1/2", "E", "S" ) ) 
                                     //cTipoMovimento ) 
                     ASM->( DBSkip() ) 
               ENDDO 
            ENDIF 
         ENDIF 
      ENDIF 
   ELSE 
      Aviso( "Lancamento deste produto em estoque nao foi possivel", 24 / 2 ) 
      Pausa() 
   ENDIF 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   MPR->( DBGoTo( nMprReg ) ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
Function GravaLogTmp( cString ) 
/* 
  MEMOWRIT( "LOG.TXT", cString ) 
  IF File( "EST.TXT" ) 
     IF File( "LOG.TXT" ) 
        !Copy LOG.TXT + EST.TXT TEMPORA.TXT >NUL 
        IF File( "TEMPORA.TXT" ) 
           !Copy TEMPORA.TXT EST.TXT >NUL 
        ENDIF 
     ENDIF 
  ELSEIF File( "LOG.TXT" ) 
     !Copy LOG.TXT EST.TXT >NUL 
  ENDIF 
*/ 
 
 
Function TabelaMovimento( nCodigo ) 
   DBSelectAr( _COD_MESTOQUE ) 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ATUALIZACUSTOMEDIO 
³ Finalidade  ³ Atualizar custo medio dos produtos 
³             ³ Esta rotina foi baseada em IESTOQUE - cImpEstoque, portanto 
³             ³ quaisquer modificacoes que a mesma venha a sofrer devera ser 
³             ³ feita em ambos os modulos p/ que nao hajam diferencas. 
³             ³ 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ Valmor Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function AtualizaCustoMedio() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nSdoVlr:= 0, nREGISTROS:=0, nCusUni:= 0, nEntQtd:= 0, nSaiQtd:= 0,; 
      nSdoQtd:= 0, nEntVlr:= 0, nSaiVlr:= 0, nCusMed:= 0 
 
     DBSelectAr(_COD_ESTOQUE) 
     DBGoTop() 
 
     nCProd1_:= 0 
     nCProd2_:= 9999999 
     dData1:=   CTOD( "01/01/90" ) 
     dData2:=   CTOD( "31/12/70" ) 
     DBSelectAr(_COD_MPRIMA) 
     DBSetOrder(1) 
     dbselectar(_COD_ESTOQUE) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON CPROD_ + STR( YEAR( DATAMV ) ) + STR( MONTH( DATAMV ) ) + ; 
              STR( DAY( DATAMV ) ) TO INDI03 FOR Val(CPROD_)>=nCPROD1_ .AND.; 
                   Val(CPROD_)<=nCPROD2_; 
                   .AND. DATAMV>=dDATA1 .AND. DATAMV<=dDATA2 .AND.; 
                   ANULAR == " " .AND. !SubStr( DOC___, 1, 3 )=="***" .AND. !SubStr( CPROD_, 1, 2 )=="**" EVAL {|| Processo() } 
     SET RELATION TO CPROD_ INTO MPR 
     mensagem("Atualizando, Aguarde...",1) 
     dbgotop() 
     nTOTGERAL:=0 
     dDATA:=ctod("01/01/01") 
     lIMPRIME:=.T. 
     nREGISTROS:=1 
     DBGOTOP() 
 
     nEntAcumulado:= 0 
     nEntVlrAcumul:= 0 
 
     cProduto:= CPROD_ 
     /* ATUALIZACAO DE INFORMACOES - CUSTO MEDIO */ 
     IF ALLTRIM( DOC___ ) = "SDO.INICIAL" 
        nCusUni:= VALOR_ / QUANT_ 
        IF ENTSAI=="-" 
           nSdoVlr:= VALOR_ * (-1) 
           nSdoQtd:= QUANT_ * (-1) 
           nEntVlrAcumul:= nSdoVlr 
           nEntAcumulado:= nSdoQtd 
           nCusMed:= nSdoVlr / nSdoQtd 
        ENDIF 
        nSdoQtd:= 0 
     ENDIF 
 
     WHILE !EOF() 
          if prow()>=nLIN+55 .OR. nRegistros == 0 
             nLIN:=prow() 
             cProduto:= CPROD_ 
          endif 
          nCusMed:= nSdoVlr / nSdoQtd 
          IF !EOF() 
              dPRODUTO:=CPROD_ 
              nREGISTRO:=recno() 
              IF EntSai == "+" 
                 nSdoAnterior:= nSdoVlr 
                 nEntQtd:= QUANT_ 
                 nSaiQtd:= 0 
                 nSdoQtd:= nSdoQtd + nEntQtd 
                 nEntVlr:= VALOR_ 
                 nSaiVlr:= 0 
                 nCusUni:= VALOR_ / QUANT_ 
                 nEntAcumulado:= nEntAcumulado + nEntQtd 
                 nEntVlrAcumul:= nEntVlrAcumul + nEntVlr 
                 nSdoVlr:= nSdoVlr + nEntVlr 
              ELSE 
                 nSdoAnterior:= nSdoVlr 
                 nEntQtd:= 0 
                 nSaiQtd:= QUANT_ 
                 nSdoQtd:= nSdoQtd - nSaiQtd 
                 nEntVlr:= 0 
                 nSaiVlr:= nCusMed * nSaiQtd 
                 nSdoVlr:= nSdoVlr - nSaiVlr 
              ENDIF 
              nCusMed:= nEntVlrAcumul / nEntAcumulado 
              IF nSdoAnterior < 0 .AND. nEntQtd > 0 .AND. nEntVlr > 0 
                 nCusMed:= nEntVlr / nEntQtd 
              ENDIF 
 
              /* SdoVlr / nSdoQtd */ 
              NCPROD:=CPROD_ 
              dbskip() 
              ++nREGISTROS 
              IF NCPROD<>CPROD_ .AND. ! EOF() 
                 Mensagem( StrZero(nREGISTROS,4,0)+" Registro(s)" ) 
                 DBSkip( -1 ) 
                 MPR->( NetRLock() ) 
                 Replace MPR->CUSMED With nCusMed 
                 MPR->( DBUnlockAll() ) 
                 DBSkip( +1 ) 
                 nREGISTROS:=0 
                 nCusUni:= 0 
                 nEntQtd:= 0 
                 nSaiQtd:= 0 
                 nSdoQtd:= 0 
                 nEntVlr:= 0 
                 nSaiVlr:= 0 
                 nCusMed:= 0 
                 //nSdoVlr:= 0 
                 nCusUni:= 0 
                 nEntVlrAcumul:= 0 
                 nEntAcumulado:= 0 
                 /* ATUALIZACAO DE INFORMACOES - CUSTO MEDIO */ 
                 IF ALLTRIM( DOC___ ) = "SDO.INICIAL" 
                    nCusUni:= VALOR_ / QUANT_ 
                    IF ENTSAI=="-" 
                       nSdoVlr:= VALOR_ * (-1) 
                       nSdoQtd:= QUANT_ * (-1) 
                       nEntVlrAcumul:= nSdoVlr 
                       nEntAcumulado:= nSdoQtd 
                       nCusMed:= nSdoVlr / nSdoQtd 
                    ENDIF 
                    nSdoQtd:= 0 
                 ENDIF 
              ENDIF 
          ENDIF 
          if eof(); exit; endif 
     enddo 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function fAtuSalPCP (cEntSai, nClasse, nTamCod, nCorCod, nQuant) 
 
      // *** SALDO NO PDVEAN 
      EAN -> (DBSetOrder (3)) // CODPRO ... 
      IF (EAN -> (DBSeek (MPR -> INDICE + STR (nClasse, 3) + ; 
                          STR (nTamCod, 2) + STR (nCorCod, 2))) ; 
                          == .T.) 
         IF EAN->( NetRlock() ) 
            IF (cEntSai == "-") 
               EAN -> SALDO_ -= nQuant 
            ELSE 
               EAN -> SALDO_ += nQuant 
            ENDIF 
         ENDIF 
         EAN->( DBUnlock() ) 
      ELSE 
         EAN-> ( dbGoBottom() ) 
         cCodigo:= IIF (EMPTY( EAN->CODIGO ), "990000000001", ; 
           STRZERO( VAL( LEFT( EAN->CODIGO, 12 ) ) + 1, 12 )  ) 
         cCodigo+= TWCalcDig ( cCodigo ) 
         EAN -> (DBAppend ()) 
         IF EAN->( NetRLock () ) 
            EAN->CODIGO := cCodigo 
            EAN->CODPRO := MPR -> INDICE 
            EAN->PCPCLA := nClasse 
            EAN->PCPTAM := nTamCod 
            EAN->PCPCOR := nCorCod 
            EAN->CODEAN := MPR -> CODFAB 
            EAN->SALDO_ := nQuant * IF( cEntSai=="-", (-1), 1 ) 
         ENDIF 
         EAN->( DBUnlock() ) 
      ENDIF 
 
   Return (.T.) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Function fAtuEstPCP(cProduto, cCodRed, cEntSai,  cDoc,    nCodigo, nVlrSdo, ; 
                        nValor,   nQuant,  nRespons, dData,   nVlrIcm, nVlrIpi, ; 
                        nVlrFre,  nMovEst, nNatOpe,  nPerIcm, nClasse, nTamCod, ; 
                        nCorCod,  nTamQua, aCorTamQua ) 
   Local nCt1, nCt2, nCCod, nTCod, nTQua 
 
      IF (LEN(aCorTamQua) == 0) 
         Return(.F.) 
      ENDIF 
 
      DBSelectar( _COD_PCPESTO ) 
 
      FOR nCt1:= 1 TO LEN( aCorTamQua ) 
         nCCod:= aCorTamQua[nCt1][1] 
         FOR nCt2:= 2 TO 21 
            nTCod:= nCt2 - 2 
            nTQua:= aCorTamQua[nCt1][nCt2] 
            IF !( nTQua == 0 ) 
               IF buscanet(5,{|| dbappend(), !neterr()}) 
                  Replace CPROD_ With cProduto,; 
                          CODRED With cCodRed,; 
                          ENTSAI With cEntSai,; 
                          DOC___ With cDoc,; 
                          CODIGO With nCodigo,; 
                          VLRSDO With nVlrSdo,; 
                          VLRSAI With nValor,; 
                          QUANT_ With nTQua,; 
                          VALOR_ With nValor,; 
                          RESPON With nRespons,; 
                          DATAMV With dData,; 
                          CODMV_ With nMovEst,; 
                          VLRIPI With nVlrIpi,; 
                          VLRFRE With nVlrFre,; 
                          NATOPE With nNatOpe,; 
                          PERICM With IF ( nPerIcm==Nil, 0, nPerIcm ),; 
                          CUSMED With MPR->CUSATU,; 
                          PCPCLA With nClasse,; 
                          PCPTAM With nTCod,; 
                          PCPCOR With nCCod 
                     IF  !( nVlrIcm == Nil ) 
                        Replace VLRICM With nVlrIcm,; 
                                TOTAL_ With nVlrIpi + nVlrFre + nVlrIcm + nValor 
                     ENDIF 
                     fAtuSalPCP( cEntSai, nClasse, nTCod, nCCod, nTQua ) 
               ELSE 
                  Aviso( "Lancamento deste produto em estoque PCP nao foi possivel", 24 / 2 ) 
                  Pausa( ) 
               ENDIF 
            ENDIF 
         NEXT 
      NEXT 
   Return( .T. ) 
 
 
Function ControleDeReserva( cMaisMenos, cProduto, nQuantidade ) 
Local nArea:= Select() 
Local nOrdem:= MPR->( IndexOrd() ), nReg:= MPR->( RECNO() ) 
   IF SWSet( _PED_CONTROLERESERVA ) 
      MPR->( DBSetOrder( 1 ) ) 
      IF !MPR->( DBSeek( cProduto ) ) 
         SWAlerta( "Produto "+cProduto+" nao localizado!; Verifique com o administrador do sistema se; existe este produto na base de dados ou se o mesmo esta; sofrendo alguma modificacao neste momento.; Impossivel atualizar informacoes de reserva deste produto.", { "   OK   " } ) 
 
         // RESERVA 
         GravaLogTmp( "ESTOQUE! Lancar reserva do produto " + cProduto + " nao foi possivel. ControleDeReserva() ====>" + " USUARIO:" + StrZero( nGCodUser, 3, 0 ) + " Em " + DTOC( DATE() ) + " as " + TIME() ) 
      ELSE 
         DO CASE 
            CASE cMaisMenos=="-" 
                 DBselectar( "MPR" ) 
                 IF DBSeek( cProduto ) 
                    IF RESERV - nQuantidade >= 0 
                       IF NetRlock() 
                          Replace RESERV With RESERV - nQuantidade 
                          // RESERVA 
                          GravaLogTmp( "ESTOQUE! Reserva (-) " + cProduto + " " + Tran( nQuantidade, "@E 999,999.99" ) + " Usuario:" + StrZero( nGCodUser, 3, 0 ) + " Em " + DTOC( DATE() ) + " as " + TIME() ) 
                       ENDIF 
                    ELSE 
                       IF NetRLock() 
                          Replace RESERV With 0 
                       ENDIF 
                       // RESERVA 
                       GravaLogTmp( "ESTOQUE! Reserva (-) nao realizada - saldo em reserva insuficiente " + cProduto + " " + Tran( nQuantidade, "@E 999,999.99" ) + " Usuario:" + StrZero( nGCodUser, 3, 0 ) + " Em " + DTOC( DATE() ) + " as " + TIME() ) 
                    ENDIF 
                 ENDIF 
                 MPR->( DBUnlock() ) 
            CASE cMaisMenos=="+" 
                 DBselectar( "MPR" ) 
                 IF DBSeek( cProduto ) 
                    IF NetRlock() 
                       Replace RESERV With RESERV + nQuantidade 
                       // RESERVA 
                       GravaLogTmp( "ESTOQUE! Reserva (+) " + cProduto + " " + Tran( nQuantidade, "@E 999,999.99" ) + " Usuario:" + StrZero( nGCodUser, 3, 0 ) + " Em " + DTOC( DATE() ) + " as " + TIME() ) 
                    ENDIF 
                    DBUnlock() 
                 ENDIF 
            OTHERWISE 
                 IF MPR->( DBSeek( cProduto ) ) 
                    IF nOrdem > 0 
                       MPR->( DBSetOrder( nOrdem ) ) 
                       MPR->( DBGoTo( nReg ) ) 
                    ENDIF 
                    Return MPR->RESERV 
                 ELSE 
                    IF nOrdem > 0 
                       MPR->( DBSetOrder( nOrdem ) ) 
                       MPR->( DBGoTo( nReg ) ) 
                    ENDIF 
                    Return 0 
                 ENDIF 
         ENDCASE 
      ENDIF 
      IF nOrdem > 0 
         MPR->( DBSetOrder( nOrdem ) ) 
         MPR->( DBGoTo( nReg ) ) 
      ENDIF 
   ENDIF 
   IF nArea > 0 
      DBSelectAr( nArea ) 
   ENDIF 
   MPR->( DBUnlockAll() ) 
   Return 0 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
