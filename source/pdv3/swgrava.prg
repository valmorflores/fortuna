/*

  BIBLIOTECA DE FUNCOES DE GRAVACAO DE INFORMACOES NO FORTUNA
  ============================================================================

  Estas funcoes tem a finalidade de gravar as informacoes de pdv nos
  arquivos de controle de cupons do sistema Fortuna

  Valmor P. Flores
  
*/

#Include "VPF.CH"


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ LancaReceber
³ Finalidade  ³ Lanca Contas a Receber
³ Parametros  ³ aParcelas
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function LancaReceber( aParcelas, nCliCodigo, cCliDescri )

   DBSelectAr( _COD_DUPAUX )
   Use _VPB_DUPAUX Alias DPA Shared
   IF File( DiretoriodeDados + "\DPAIND05.NTX" )
      Set Index To "&DiretoriodeDados\DPAIND01.NTX",;
                   "&DiretoriodeDados\DPAIND02.NTX",;
                   "&DiretoriodeDados\DPAIND03.NTX",;
                   "&DiretoriodeDados\DPAIND04.NTX",;
                   "&DiretoriodeDados\DPAIND05.NTX"
   ELSE
      Set Index To "&DiretoriodeDados\DPAIND01.NTX",;
                   "&DiretoriodeDados\DPAIND02.NTX",;
                   "&DiretoriodeDados\DPAIND03.NTX",;
                   "&DiretoriodeDados\DPAIND04.NTX"
   ENDIF

   DBSetOrder( 1 )
   FOR nCt:= 1 TO Len( aParcelas )
       DBAppend()
       IF RLock()
          nCodCli:= 0
          Replace CODNF_ With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() ),;
                  DUPL__ With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() ),;
                  LETRA_ With Chr( nCt + 64 ),;
                  PERC__ With aParcelas[ nCt ][ 1 ],;
                  VLR___ With aParcelas[ nCt ][ 3 ],;
                  PRAZ__ With aParcelas[ nCt ][ 2 ],;
                  BANC__ With aParcelas[ nCt ][ 6 ],;
                  CHEQ__ With aParcelas[ nCt ][ 7 ],;
                  VENC__ With aParcelas[ nCt ][ 4 ],;
                  DTQT__ With aParcelas[ nCt ][ 5 ],;
                  TIPO__ With "03",;
                  DATAEM With DataEmissao(),;
                  FUNC__ With CodigoCaixa,;
                  OBS___ With DTOC(DataEmissao()) + "|" + HORA() + "/" + StrZero( CodigoCaixa, 3, 0 ),;
                  CLIENT With nCliCodigo,;
                  CDESCR With cCliDescri,;
                  LOCAL_ With aParcelas[ nCt ][ 8 ]
       ENDIF
   NEXT
   DBCloseArea()
   Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CancelaReceber
³ Finalidade  ³ Cancela Lancamento em Contas a Receber
³ Parametros  ³ aParcelas
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function CancelaReceber()
Local nArea:= Select()
   DBSelectAr( _COD_DUPAUX )
   Use _VPB_DUPAUX Alias DPA Shared
   IF File( DiretoriodeDados + "\DPAIND05.NTX" )
      Set Index To "&DiretoriodeDados\DPAIND01.NTX",;
                   "&DiretoriodeDados\DPAIND02.NTX",;
                   "&DiretoriodeDados\DPAIND03.NTX",;
                   "&DiretoriodeDados\DPAIND04.NTX",;
                   "&DiretoriodeDados\DPAIND05.NTX"
   ELSE
      Set Index To "&DiretoriodeDados\DPAIND01.NTX",;
                   "&DiretoriodeDados\DPAIND02.NTX",;
                   "&DiretoriodeDados\DPAIND03.NTX",;
                   "&DiretoriodeDados\DPAIND04.NTX"
   ENDIF
   DBSetOrder( 1 )
   IF VAL( NumeroCupom() ) > 0
      IF DBSeek( Val( StrZero( CodigoCaixa, 03, 00 ) + NumeroCupom() ) )
         WHILE CODNF_== Val( StrZero( CodigoCaixa, 03, 00 ) + NumeroCupom() )
            IF TIPO__=="03"
               IF Rlock()
                  Replace NFNULA With "*"
               ENDIF
            ENDIF
            DBSkip()
         ENDDO
      ENDIF
   ENDIF
   DBCloseArea()
   DBSelectAr( nArea )
   Return Nil


// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
   Function LanRecMoeDiv( aMoedas, nCliCodigo, cCliDescri, nPerAcrDes, ;
                          cAcrDes  )

      DBSelectAr( _COD_DUPAUX )
      Use _VPB_DUPAUX Alias DPA Shared
      IF File( DiretoriodeDados + "\DPAIND05.NTX" )
         Set Index To "&DiretoriodeDados\DPAIND01.NTX",;
                      "&DiretoriodeDados\DPAIND02.NTX",;
                      "&DiretoriodeDados\DPAIND03.NTX",;
                      "&DiretoriodeDados\DPAIND04.NTX",;
                      "&DiretoriodeDados\DPAIND05.NTX"
      ELSE
         Set Index To "&DiretoriodeDados\DPAIND01.NTX",;
                      "&DiretoriodeDados\DPAIND02.NTX",;
                      "&DiretoriodeDados\DPAIND03.NTX",;
                      "&DiretoriodeDados\DPAIND04.NTX"
      ENDIF
      DBSetOrder( 1 )

      FOR nCt := 1 TO LEN( aMoedas )
         IF aMoedas [ nCt ][ 2 ] > 0 // [ 1 ] = Codigo   [ 2 ] = Valor
            fGravaMoeda( aMoedas[ nCt ][ 1 ], ;
                         aMoedas[ nCt ][ 2 ], ;
                         nCliCodigo, cCliDescri, nCt, nPerAcrDes, cAcrDes )
         ENDIF
      NEXT

      DBCloseArea()

   Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fGravaMoeda( nCodigo, nValor, nCliCodigo, cCliDescri, nCt, ;
                         nPerAcrDes, cAcrDes )

      DBAppend()

      IF RLock()
         nCodCli:= 0
         IF( nPerAcrDes > 0)
            IF( cAcrDes == "A" )
               cTmp := " (ACRESC)"
            ELSE
               cTmp := " (DESC)"
            ENDIF
         ELSE
            cTmp := ""
         ENDIF
         Replace CODNF_ With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() ),;
                 DUPL__ With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() ),;
                 LETRA_ With Chr( nCt + 64 )                      ,;
                 PERC__ With nPerAcrDes                           ,;
                 VLR___ With nValor                               ,;
                 TIPO__ With "03"                                 ,;
                 DATAEM With DataEmissao()                        ,;
                 FUNC__ With CodigoCaixa                          ,;
                 OBS___ With DTOC(DataEmissao() ) + "|" + HORA() + "/" + ;
                             StrZero( CodigoCaixa, 3, 0 ) + cTmp  ,;
                 CLIENT With nCliCodigo                           ,;
                 CDESCR With cCliDescri                           ,;
                 LOCAL_ With nCodigo
      ENDIF

   Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    

/*====================================
Funcao       LANCACUPOM
Finalidade   Lanca Cupom no movimento de Cupons
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
Falta Gravar o CPF e mais informacoes
-------------------------------------*/
Function LancaCupom( nCliCodigo, cCliDescri, cCliEndere, cCliBairro, cCliCidade, cCliEstado, cCliFone, cCliCodCep, cCliIEstadual, cCliCGCCPF, nValorPagar, nVendedor, nForma, cObserv1, cObserv2, cObserv3 )
Local nValorIcm:= 0, nValorIpi:= 0, nValorBase:= 0
  DBSelectAr( _COD_CUPOM )
  IF !USED()
     AbreBaseCupom()
  ENDIF
  DBSelectAr( _COD_CUPAUX )
  IF !USED()
     Use _VPB_CUPAUX Alias CAU Shared
     Set Index To "&DiretoriodeDados\CAUIND01.NTX",;
               "&DiretoriodeDados\CAUIND02.NTX",;
               "&DiretoriodeDados\CAUIND03.NTX",;
               "&DiretoriodeDados\CAUIND04.NTX",;
               "&DiretoriodeDados\CAUIND05.NTX"
  ENDIF
  DBSelectAr( _VENDAFILE )
  DBGoTop()
  WHILE !EOF()
      IF MPR->( DBSeek( VDA->INDICE ) ) .AND. VDA->STATUS==" "
         CAU->( DBAppend() )
         IF CAU->( RLock() )
            Replace CAU->CODIGO With VDA->INDICE
            Replace CAU->CODRED With VDA->INDICE
            Replace CAU->CODIGO With VDA->INDICE
            Replace CAU->DESCRI With VDA->DESCRI
            Replace CAU->MPRIMA With MPR->MPRIMA
            Replace CAU->UNIDAD With VDA->UNIDAD
            Replace CAU->QUANT_ With VDA->QUANT_
            Replace CAU->PRECOV With VDA->PRECOV
            Replace CAU->DATA__ With DataEmissao()
            Replace CAU->PRECOT With VDA->PRECOT
            Replace CAU->CODNF_ With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() )
         ENDIF
         IF !( MPR->SITT02==40 .OR. MPR->SITT02==41 )
            nValorIcm:=  nValorIcm + ( CAU->PRECOT * Icm ) / 100
            nValorBase:= nValorBase + ( CAU->PRECOT )
         ENDIF
         CAU->( DBUnlock() )
      ENDIF
      DBSkip()
  ENDDO
  IF VDA->( LastRec() ) <= 0
     DBSelectAR( _COD_MPRIMA )
     Return Nil
  ENDIF
  DBSelectAr( _COD_CUPOM )
  DBAppend()
  IF !NetErr()
     Replace TIPONF With "S",;
             NATOPE With 5.12,;
             NUMERO With Val( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() ),;
             CLIENT With nCliCodigo,;
             CDESCR With cCliDescri,;
             CENDER With cCliEndere,;
             CBAIRR With cCliBairro,;
             CCIDAD With cCliCidade,;
             CESTAD With cCliEstado,;
             CFONE2 With cCliFone,;
             CCDCEP With cCliCodCep,;
             CINSCR With cCliIEstadual,;
             CCGCMF With cCliCGCCPF,;
             VLRNOT With nValorPagar,;
             VLRTOT With nValorPagar,;
             VLRICM With nValorIcm,;
             VLRIPI With nValorIPI,;
             BASICM With nValorBase,;
             FUNC__ With CodigoCaixa,;
             DATAEM With DataEmissao(),;
             VENIN_ With nVendedor,;
             TABCND With nForma,;
             OBSER1 With cObserv1,;
             OBSER2 With cObserv2,;
             OBSER3 With cObserv3,;
             PRICMP With IF( lPrimeiraCompra, "*", " " )
     lPrimeiraCompra:= .F.
  ENDIF
  CLI->( DBSetOrder( 1 ) )
  IF CLI->( DBSeek( nCliCodigo ) )
     IF CLI->( RLock() )
        Replace CLI->ULTCMP With DataEmissao(),;
                CLI->ULTVLR With nValorPagar
        IF CLI->MAIVLR < CLI->ULTVLR
           Replace CLI->MAICMP With CLI->ULTCMP,;
                   CLI->MAIVLR With CLI->ULTVLR
        ENDIF
     ENDIF
  ENDIF
  DBSelectAr( _COD_MPRIMA )
  Return Nil


// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*====================================
Funcao       LancaEmCaixa
Finalidade   Lancar valores recebidos no movimento de caixa
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function LancaEmCaixa( nRecebido )
Local nCt
  DBSelectAr( _COD_CAIXA )
  Use _VPB_CAIXA Alias CX Shared
  Set Index To "&DiretoriodeDados\CX_IND01.NTX"
  DBAppend()
  IF !NetErr()
     Replace DATAMV With DataEmissao(),;
             VENDE_ With CodigoCaixa,;
             ENTSAI With "+",;
             MOTIVO With 00,;
             HISTOR With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom(),;
             VALOR_ With nRecebido,;
             HORAMV With HORA(),;
             CDUSER With 0
  ENDIF
  DBSelectAr( _COD_MPRIMA )
  Return Nil

Function CancelaCaixa( nRecebido )
  DBSelectAr( _COD_CAIXA )
  Use _VPB_CAIXA Alias CX Shared
  Set Index To "&DiretoriodeDados\CX_IND01.NTX"
  DBAppend()
  IF !NetErr()
     Replace DATAMV With DataEmissao(),;
             VENDE_ With CodigoCaixa,;
             ENTSAI With "-",;
             MOTIVO With 00,;
             HISTOR With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + "-CANCELADO!",;
             VALOR_ With nRecebido,;
             HORAMV With HORA(),;
             CDUSER With 0
  ENDIF
  DBCloseArea()
  DBSelectAr( _COD_MPRIMA )
  Return Nil


// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*====================================
Funcao       LancaESTOQUE
Finalidade
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function LancaEstoque(nRegAtuCli, nRegAtuEAN)
Local nCt

  AbreFile( _COD_MPRIMA ) 
  AbreFile( _COD_CLIENTE )
  AbreFile( _COD_ESTOQUE )

  IF nRegAtuCli <> Nil
     IF (nRegAtuCli <> 0)
        CLI->( DBGoTo( nRegAtuCli ) )
     ENDIF
  ENDIF

  IF DataEmissao() == Nil
     DataEmissao( date() )
  ENDIF

  MPR->( DBSetOrder( 1 ) )
  DBSelectAr( _VENDAFILE )
  IF !USED()
     VendaFile( _ABRIR )
  ENDIF
  DBGoTop()
  WHILE !EOF()
      IF STATUS==" " .OR. STATUS=="E" .OR. STATUS=="X"
         IF MPR->( DBSeek( VDA->INDICE ) )
            IF MPR->( RLock() )
               IF VDA->STATUS==" " .OR. VDA->STATUS=="X"
                  /* Vendido */
                  Replace MPR->SALDO_ With MPR->SALDO_ - VDA->QUANT_
               ELSE
                  /* Item cancelado na venda - Retorna para o estoque */
                  Replace MPR->SALDO_ With MPR->SALDO_ + VDA->QUANT_
               ENDIF
            ENDIF
            DBUnlockAll()
         ENDIF
         EST->( DBAppend() )
         IF EST->( RLock() )
            /* Registro no estoque */
            Replace EST->CPROD_ With VDA->INDICE,;
                    EST->CODRED With VDA->INDICE,;
                    EST->ENTSAI With IF( VDA->STATUS==" " .OR. VDA->STATUS=="X","-","+" ),;
                    EST->QUANT_ With VDA->QUANT_,;
                    EST->NATOPE With 5.12,;
                    EST->DOC___ With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," "," C" ),;
                    EST->CODIGO With 0,;
                    EST->VLRSDO With 0,;
                    EST->VALOR_ With VDA->PRECOT,;
                    EST->DATAMV With DataEmissao(),;
                    EST->RESPON With 0,;
                    EST->PCPCLA With VDA->PCPCLA,;
                    EST->PCPTAM With VDA->PCPTAM,;
                    EST->PCPCOR With VDA->PCPCOR,;
                    EST->FILIAL With CodigoFilial
            IF !MPR->MPRIMA=="S"
               IF LancaMontagem
                  LancaMontagem( VDA->INDICE, IF( VDA->STATUS==" " .OR. VDA->STATUS=="X","-","+" ), VDA->QUANT_, "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," "," C" ) )
               ENDIF
            ENDIF
         ENDIF
         DBUnlockAll()
         DBSelectAr( _COD_PDVEAN )
         IF Used()
            // *** SALDO NO PDVEAN
            EAN -> (DBSetOrder (3)) // CODPRO ...
            IF (EAN -> (DBSeek (VDA -> INDICE + STR (VDA -> PCPCLA, 3) + ;
                            STR (VDA -> PCPTAM, 2) + STR (VDA -> PCPCOR, 3))) == .T.)
               IF EAN->( Rlock() )
                  IF VDA->STATUS==" " .OR. VDA->STATUS=="X"
                     Replace EAN->SALDO_ With EAN->SALDO_ - VDA->QUANT_
                  ELSE
                     Replace EAN->SALDO_ With EAN->SALDO_ + VDA->QUANT_
                  ENDIF
               ENDIF
               EAN->( DBUnlock() )
            ENDIF
         ENDIF
         DBSelectAr( _VENDAFILE )
         // *** SALDO NO CLIENTES
         IF (nRegAtuCli <> 0)
            IF CLI->( Rlock() )
               IF VDA->STATUS==" " .OR. VDA->STATUS=="X"
                  CLI->SALDO_-=VDA->PRECOT
               ELSE
                  CLI->SALDO_+=VDA->PRECOT
               ENDIF
            ENDIF
            CLI->( DBUnlock() )
         ENDIF
      ENDIF
      VDA->( DBSkip() )
  ENDDO
  DBSelectAr( _COD_ESTOQUE )
  dbCloseArea()
  DBSelectAr( _COD_MPRIMA )
  DBSetOrder( 1 )
  Return Nil

Function LancaMontagem( cIndice, cEntSai, nQuantidade, cDoc )
 Local nArea:= Select()
 Local nRegistro:= MPR->( RECNO() )
 Local cProduto:= cIndice
 /* sub-produtos em caso de
    venda de um produto montado */
 MPR->( DBSetOrder( 1 ) )
 DBSelectAr( _COD_ASSEMBLER )
 IF !Used()
    USE "&DiretorioDeDados\MONTAGEM.DBF" Alias ASM Shared
    SET INDEX TO "&DiretorioDeDados\ASMIND01.NTX", "&DiretorioDeDados\ASMIND02.NTX"
 ENDIF
 DBSetOrder( 1 )
 IF DBSeek( cProduto )
    WHILE ASM->CODPRD == cProduto
        DBSelectAr( _COD_ESTOQUE )
        MPR->( DBSeek( ASM->CODMPR ) )
        IF MPR->( Rlock() )
           IF cEntSai=="+"
              Replace MPR->SALDO_ With MPR->SALDO_ + ( nQuantidade * ASM->QUANT_ )
           ELSE
              Replace MPR->SALDO_ With MPR->SALDO_ - ( nQuantidade * ASM->QUANT_ )
           ENDIF
        ENDIF
        EST->( dbappend() )
        IF EST->( Rlock() )
           Repl EST->CPROD_ with ASM->CODMPR
           Repl EST->CODRED with ASM->CODMPR
           Repl EST->ENTSAI with cEntSai
           Repl EST->DOC___ with ALLTrim( cDoc ) + "CM"
           Repl EST->CODIGO with 0
           Repl EST->VLRSDO with 0
           Repl EST->VLRSAI with 0
           Repl EST->QUANT_ with nQuantidade * ASM->QUANT_
           Repl EST->DATAMV With DataEmissao()
           Repl EST->FILIAL With CodigoFilial
        ENDIF
        ASM->( DBSkip() )
    ENDDO
 ENDIF
 MPR->( DBGoTo( nRegistro ) )
 DBSelectAr( nArea )
 Return Nil


/*====================================
Funcao       RetornaEstoque
Finalidade
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function RetornaEstoque()
Local nCt
  DBSelectAr( _COD_ESTOQUE )
  Use _VPB_ESTOQUE Alias EST Shared
  Set Index To &DiretoriodeDados\ESTIND01.NTX,;
               &DiretoriodeDados\ESTIND02.NTX,;
               &DiretoriodeDados\ESTIND03.NTX,;
               &DiretoriodeDados\ESTIND04.NTX
  MPR->( DBSetOrder( 1 ) )
  DBSelectAr( _VENDAFILE )
  DBGoTop()
  WHILE !EOF()
      IF STATUS==" "
         IF MPR->( DBSeek( VDA->INDICE ) )
            IF MPR->( RLock() )
               Replace MPR->SALDO_ With MPR->SALDO_ + VDA->QUANT_
            ENDIF
            DBUnlockAll()
         ENDIF
         EST->( DBAppend() )
         IF EST->( RLock() )
            Replace EST->CPROD_ With VDA->INDICE,;
                    EST->CODRED With VDA->INDICE,;
                    EST->ENTSAI With "+",;
                    EST->QUANT_ With VDA->QUANT_,;
                    EST->DOC___ With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + " Cancelamento",;
                    EST->CODIGO With 0,;
                    EST->VLRSDO With 0,;
                    EST->VALOR_ With VDA->PRECOT,;
                    EST->DATAMV With DataEmissao(),;
                    EST->RESPON With 0,;
                    EST->PCPCLA With VDA->PCPCLA,;
                    EST->PCPTAM With VDA->PCPTAM,;
                    EST->PCPCOR With VDA->PCPCOR,;
                    EST->FILIAL With CodigoFilial
            IF !MPR->MPRIMA=="S"
               IF LancaMontagem
                  LancaMontagem( VDA->INDICE, "+", VDA->QUANT_, "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," "," CANCELA" ) )
               ENDIF
            ENDIF
         ENDIF
         DBUnlockAll()
         EAN->( DBSetOrder( 3 ) )
         IF ( EAN->( DBSeek( VDA->INDICE + STR( VDA ->PCPCLA, 3 ) + ;
                         STR( VDA->PCPTAM, 2) + STR( VDA->PCPCOR, 3 ) ) ) == .T.)
            EAN->( Rlock() )
            IF !EAN->( NetErr() )
                EAN->SALDO_+=VDA->QUANT_
            ENDIF
            EAN->( DBUnlock() )
         ENDIF
      ENDIF
      VDA->( DBSkip() )
  ENDDO
  DBSelectAr( _COD_MPRIMA )
  DBSetOrder( 1 )
  Return Nil



// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function AnulaCupom( cCupom, nTotal )
Local nCt:= 0, lCancelado:= .F.
  DBSelectAr( _COD_CUPOM )
  IF !USED()
     AbreBaseCupom()
  ENDIF
  DBSelectAr( _COD_CUPAUX )
  IF !USED()
     Use _VPB_CUPAUX Alias CAU Shared
     Set Index To &DiretoriodeDados\CAUIND01.NTX,;
               &DiretoriodeDados\CAUIND02.NTX,;
               &DiretoriodeDados\CAUIND03.NTX,;
               &DiretoriodeDados\CAUIND04.NTX,;
               &DiretoriodeDados\CAUIND05.NTX
  ENDIF
  DBSelectAr( _COD_CUPOM )
  DBGoBottom()
  WHILE nCt < 10
     ++nCt
     IF CUP->VLRTOT==nTotal .AND. CUP->FUNC__==CodigoCaixa .AND. CUP->DATAEM==DataEmissao()
        IF CUP->( RLock() )
           Replace CUP->NFNULA With "*"
           lCancelado:= .T.
           EXIT
        ENDIF
     ENDIF
     CUP->( DBSkip( -1 ) )
  ENDDO
  IF !lCancelado
     CUP->( DBSetOrder( 1 ) )
     IF CUP->( DBSeek( VAL( StrZero( CodigoCaixa, 03, 00 ) + NumeroCupom() ) ) )
        IF CUP->( RLock() )
           Replace CUP->NFNULA With "*"
        ENDIF
     ENDIF
  ENDIF
  //CUP->( DBCloseArea() )
  DBSelectAr( _COD_MPRIMA )
  RetornaEstoque( Nil )
  Return .F.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ


Function AbreFile( nCodigoArquivo )
Local cRDDDefault:= RDDSetDefault()
DO CASE

   CASE nCodigoArquivo == _COD_ESTOQUE
       /// Estoque
       DBSelectAr( _COD_ESTOQUE )
       IF !USED()
          Use _VPB_ESTOQUE Alias EST Shared
          Set Index To "&DiretoriodeDados\ESTIND01.NTX",;
                 "&DiretoriodeDados\ESTIND02.NTX",;
                 "&DiretoriodeDados\ESTIND03.NTX",;
                 "&DiretoriodeDados\ESTIND04.NTX"
       ENDIF

   CASE nCodigoArquivo==_COD_MPRIMA

      DBSelectAr( _COD_MPRIMA )
      Use _VPB_MPRIMA Alias MPR Shared
      IF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" ) .AND.;
         File( DiretorioDeDados-"\MPRIND03.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND04.NTX" ) .AND.;
         File( DiretorioDeDados-"\MPRIND05.NTX" )
         Set Index To "&DiretorioDeDados\MPRIND01.NTX","&DiretorioDeDados\MPRIND02.NTX",;
                      "&DiretorioDeDados\MPRIND03.NTX","&DiretorioDeDados\MPRIND04.NTX","&DiretorioDeDados\MPRIND05.NTX"
      ELSEIF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" ) .AND.;
             File( DiretorioDeDados-"\MPRIND03.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND04.NTX" )
         Set Index To "&DiretorioDeDados\MPRIND01.NTX","&DiretorioDeDados\MPRIND02.NTX","&DiretorioDeDados\MPRIND03.NTX","&DiretorioDeDados\MPRIND04.NTX"
      ELSEIF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" ) .AND.;
             File( DiretorioDeDados-"\MPRIND03.NTX" )
         Set Index To "&DiretorioDeDados\MPRIND01.NTX","&DiretorioDeDados\MPRIND02.NTX","&DiretorioDeDados\MPRIND03.NTX"
      ELSEIF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" )
         Set Index To "&DiretorioDeDados\MPRIND01.NTX","&DiretorioDeDados\MPRIND02.NTX"
      ENDIF

   CASE nCodigoArquivo==_COD_CLIENTE

#ifdef _GMATRIX
       **********
       Sele 130
       USE "&DiretorioDeDados\MAISINFO" ALIAS MAISINFO Shared
       IF !File(  DiretorioDeDados - "\INFIND01.NTX" )
          Index On CODIGO To "&DiretorioDeDados\INFIND01.NTX"
          Index On DESCRI To "&DiretorioDeDados\INFIND02.NTX"
       ENDIF
       Set Index To "&DiretorioDeDados\INFIND01.NTX", "&DiretorioDeDados\INFIND02.NTX"
       
#endif

       DBSelectAr( _COD_CLIENTE )
       IF !Used()
          RDDSetDefault( "DBFNTX" )
          Use _VPB_CLIENTE Alias CLI Shared
          IF !File( DiretorioDeDados-"\CLIIND01.NTX" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND02.NTX" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND03.NTX" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND04.NTX" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND05.NTX" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND06.NTX" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND07.NTX" )

             Index On CODIGO Tag CLIX1 ;
                     Eval {|| .T. } ;
                     To "&DiretorioDeDados\CLIIND01.NTX"
             Index On Upper(Descri) Tag CLIX2 ;
                     Eval {|| .T. } ;
                     To "&DiretorioDeDados\CLIIND02.NTX"
             Index On FANTAS Tag CLIX3 ;
                     Eval {|| .T. } ;
                     To "&DiretorioDeDados\CLIIND03.NTX"
             Index On StrZero( FILIAL, 03, 00 ) +;
                      StrZero( CODFIL, 06, 00 ) Tag CLIX4 ;
                      Eval {|| .T. } to "&DiretorioDeDados\CLIIND04.NTX"
             Index On CODBAR Tag CLIX5 ;
                     Eval {|| .T. } ;
                     To "&DiretorioDeDados\CLIIND05.NTX"
             Index On ENDERE Tag CLIX6 ;
                     Eval {|| .T. } ;
                     To "&DiretorioDeDados\CLIIND06.NTX"
             Index On FONE1_ Tag CLIX7 ;
                     Eval {|| .T. } ;
                     To "&DiretorioDeDados\CLIIND07.NTX"
          ENDIF
          Set Index To "&DiretoriodeDados\CLIIND01.NTX",;
                       "&DiretoriodeDados\CLIIND02.NTX",;
                       "&DiretoriodeDados\CLIIND03.NTX",;
                       "&DiretoriodeDados\CLIIND04.NTX",;
                       "&DiretoriodeDados\CLIIND05.NTX",;
                       "&DiretoriodeDados\CLIIND06.NTX",;
                       "&DiretorioDeDados\CLIIND07.NTX"

       ENDIF
       RDDSetDefault( cRDDDefault )
ENDCASE


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ VendaFILE
³ Finalidade  ³ Tratamento de Informacoes p/ arquivo de seguranca
³             ³ com Informacoes sobre a venda.
³ Parametros  ³ xPar1..xPar4
³ Retorno     ³ xRetorno- Conforme o parametro de chamada
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 03/07/1999
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function VendaFile( xPar1, xPar2, xPar3, xPar4, nTamEAN, nCorEAN, xPar7, xPar8, xPar9 )
Local nVezes:= 0
Local nCodLan, aStr, nReg
Local nPrecoV, nPrecoT, nQuant_, cSt
Local nArea:= Select()
Local xRetornar:= Nil

   IF xPar1==_VENDA_ITEM
      DBSelectAr( _VENDAFILE )
      IF Used()
         DBSetOrder( 2 )
         DBGoBottom()
         nCodLan:= CODLAN + 1
         nPrecoV:= MPR->( PrecoConvertido() )
         nPrecoT:= xPar2
         nQuant_:= xPar3
         cSt:=     xPar4

         IF LEFT( MPR->DESCRI, 8 )=="<EDITAR>"
            cProdut:= xPar7
            cCodFab:= xPar8
            cUnidad:= xPar9
            nPrecoV:= xPar2 / xPar3
         ELSE
            cProdut:= MPR->DESCRI
            cUnidad:= MPR->UNIDAD
            cCodFab:= MPR->CODFAB
         ENDIF

         DBAppend()

         Replace CODLAN With nCodLan
         Replace INDICE With MPR->( INDICE )
         Replace CODFAB With cCodFab
         Replace DESCRI With cProdut
         Replace UNIDAD With cUnidad
         Replace STATUS With " "
         Replace PRECOV With nPrecoV
         Replace QUANT_ With nQuant_
         Replace PRECOT With nPrecoT
         Replace DATA__ With DataEmissao()
         Replace HORA__ With HORA()
         Replace ST____ With cSt
         Replace PCPCLA With MPR->PCPCLA
         Replace PCPTAM With nTamEAN
         Replace PCPCOR With nCorEAN
         Replace NUMCUP With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() )

      ENDIF
   ELSEIF xPar1 == _CRIAR
      aStr:= {{ "CODLAN", "N", 03, 00 },;
              { "INDICE", "C", 12, 00 },;
              { "CODFAB", "C", 13, 00 },;
              { "DESCRI", "C", 45, 00 },;
              { "UNIDAD", "C", 02, 00 },;
              { "PRECOV", "N", 16, 02 },;
              { "PRECOT", "N", 16, 02 },;
              { "QUANT_", "N", 16, 03 },;
              { "ST____", "C", 03, 00 },;
              { "STATUS", "C", 01, 00 },;
              { "DATA__", "D", 08, 00 },;
              { "HORA__", "C", 08, 00 },;
              { "INFO__", "C", 80, 00 },;
              { "PCPCLA", "N", 03, 00 },;
              { "PCPTAM", "N", 02, 00 },;
              { "PCPCOR", "N", 03, 00 },;
              { "NUMCUP", "N", 09, 00 },;
              { "ENVIAD", "C", 01, 00 },;
              { "CODCLI", "N", 06, 00 }}

      DBCreate( _ARQUIVO, aStr )

   ELSEIF xPar1 == _ABRIR
      DBSelectAr( _VENDAFILE )
      IF !Used()
         Use _ARQUIVO Alias VDA Exclusive
         IF !Used()
            ? "O sistema PDV ja esta em uso neste computador."
            Quit
         ENDIF
         Index On INDICE TAG VDA1 To PDV_PEND.NT1
         Index On CODLAN TAG VDA2 To PDV_PEND.NT2
         Set Index To PDV_PEND.NT1, PDV_PEND.NT2
      ENDIF

   ELSEIF xPar1 == _EXCLUIR
      DBSelectAr( _VENDAFILE )
      IF Used()
         DBCloseArea()
      ENDIF
      FErase( _ARQUIVO )
   ELSEIF xPar1 == _BUSCAR_ITEM
      xRetornar:= .F.
      DBSelectAr( _VENDAFILE )
      IF Used()
         nReg:= RECNO()
         IF xPar2 == Nil  /* Se nÆo tiver com numero do produto,
                             o sistema posiciona no ultimo que nÆo esteja
                             anulado e retorna .T. */
            DBSetOrder( 2 )
            DBGoBottom()
            WHILE !BOF()
               IF STATUS==" "
                  xRetornar:= .T.
                  EXIT
               ELSE
                  DBSkip(-1)
               ENDIF
               xRetornar:= .F.
            ENDDO
         ELSE
            DBSetOrder( 1 )
            DBGoBottom()
            WHILE !BOF()
               IF xPar2 == INDICE .AND. STATUS==" "
                  xRetornar:= .T.
                  EXIT
               ELSE
                  DBSkip(-1)
               ENDIF
               xRetornar:= .F.
            ENDDO
         ENDIF
         IF BOF()
            xRetornar:= .F.
         ENDIF
      ENDIF
   ELSEIF xPar1 == _ARMAZENAR
      DBSelectAr( _VENDAFILE )
      COPY TO _BACKUP

   ELSEIF xPar1 == _RESTAURAR
      IF File( _BACKUP )
         DBSelectAr( 111 )
         Use _BACKUP Alias BKP
         COPY TO _ARQUIVO
         DBCloseArea()
         xRetornar:= .T.
      ELSE
         VendaFile( _CRIAR )
         xRetornar:= .F.
      ENDIF

   ELSEIF xPar1 == _ANULAR_ITEM
      DBSelectAr( _VENDAFILE )
      IF Used()
         DBSetOrder( 1 )
         IF VendaFile( _BUSCAR_ITEM, xPar2 )
            cIndice:= INDICE
            nPrecoV:= PRECOV
            nPrecoT:= PRECOT
            nQuant_:= QUANT_
            cSt:=     ST____
            IF xPar2 == Nil
               MPR->( DBSetOrder( 1 ) )
               MPR->( DBSeek( cIndice ) )
            ENDIF
            Replace STATUS With "X"
            DBAppend()
            Replace CODLAN With -1,;
                    INDICE With MPR->( INDICE ),;
                    CODFAB With MPR->CODFAB,;
                    DESCRI With MPR->DESCRI,;
                    UNIDAD With MPR->UNIDAD,;
                    STATUS With "E",;
                    PRECOV With nPrecoV,;
                    QUANT_ With nQuant_,;
                    PRECOT With nPrecoT,;
                    DATA__ With DataEmissao(),;
                    HORA__ With HORA(),;
                    ST____ With cSt
            xRetornar:= .T.
         ELSE
            xRetornar:= .F.
         ENDIF
      ELSE
         xRetornar:= .F.
      ENDIF
   ELSEIF xPar1 == _INFORMACOES_ITEM
      DBSelectAr( _VENDAFILE )
      IF Used()
         xRetornar:= { CODLAN, INDICE, CODFAB, DESCRI, UNIDAD, STATUS, PRECOV,;
                       QUANT_, PRECOT, DATA__, HORA__, ST____ }
      ENDIF
   ELSEIF xPar1 == _LIMPAR
      DBSelectAr( _VENDAFILE )
      IF Used()
         Zap
      ENDIF
   ELSEIF xPar1 == _ULTIMOREGISTRO
      DBSelectAr( _VENDAFILE )
      IF Used()
         xRetornar:= LASTREC()
      ELSE
         xRetornar:= 0
      ENDIF

   ELSEIF xPar1 == _ENVIAR_PARA_MATRIZ
      DBSelectAr( _VENDAFILE )
      nVezes:= 0
      // Se o arquivo PDV_OK.DBF existe
      // significa que tem um cupom que esta
      // sendo processado neste momento pelo FLINE.EXE, portanto,
      // as informacoes devem entÆo serem armazenadas em PDV_BAK.DBF
      // para um posterior envio pelo FLINE ao servidor.
      // Valmor (em 31/10/2003)
      IF FILE( "PDV_OK.OK" )
         WHILE FILE( "PDV_OK.OK" )
             ++nVezes
             //
             // Aguardando 60 segundos para que fline
             // remova o arquivo PDV_OK.DBF
             // Apos 60 segundo abandona o loop
             //
             ////////////@ 24,02 Say alltrim( Str( nVezes ) ) + "/60" + "= Aguardando...      "
             //INKEY( 1 )
             IF nVezes > 6000
                EXIT
             ENDIF
         ENDDO
         ///@ 24,02 Say "Liberacao aprovada...             "
      ENDIF
      // Se vezes <= 60000 nao ocorreu nenhum erro
      IF nVezes <= 60000
         ///@ 24,02 Say "Gravando informacao para FLINE    "
         COPY TO PDV_OK.DBF
         //INKEY( 0.5 )
         MEMOWRIT( "PDV_OK.OK", "" )
      ELSE
         ///@ 24,02 Say "Gravando arquivo de desvio        "
         COPY TO PDV_ERRO.DBF
         IF FILE( "PDV_BAK.DBF" )
            DBSelectAr( 151 )
            USE PDV_BAK ALIAS PDV_BAK EXCLUSIVE
            IF USED()
               APPEND FROM PDV_ERRO.DBF
               DBCloseArea()
            ELSE
               Alert( "Falha na gravacao de PDV_BAK.DBF; Retorne ao PDV e tente fechar o cupom novamente." )
               QUIT
            ENDIF
            DBSelectAr( _VENDAFILE )
         ENDIF
      ENDIF
   ENDIF
   DBSelectAr( nArea )
   Return xRetornar

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Function NumeroCupom( cNumero )

      Static cCupom
      IF cNumero == Nil
         IF cCupom == Nil
            Return "NAO INFORMADO"
         ELSEIF cCupom == ""
            Return "NAO INFORMADO"
         ENDIF
      ELSEIF cNumero=="<Buscar>"
         IF ( cCupom:= ImpCupomAtual() )== Nil
            Return ""
         ENDIF
      ELSEIF VAL( cNumero ) > 0
         cCupom:= cNumero
      ELSE
         cCupom:= ImpCupomAtual()
      ENDIF

   Return cCupom


// ACABAR COM ESTA FUNCAO

Function AbreBaseCupom()
      DBSelectAr( _COD_CUPOM )
      IF !Used()
         Use _VPB_CUPOM Alias CUP Shared
         Set Index To "&DiretoriodeDados\CUPIND01.NTX",;
                      "&DiretoriodeDados\CUPIND02.NTX",;
                      "&DiretoriodeDados\CUPIND03.NTX",;
                      "&DiretoriodeDados\CUPIND04.NTX",;
                      "&DiretoriodeDados\CUPIND05.NTX"
      ENDIF
Return Nil


Function DataEmissao( dData )
Stat dDataEmissao
   IF dData <> Nil
      dDataEmissao:= dData
   ENDIF
   Return dDataEmissao



Function Aguarda()
Local Start, End
 Start:=SECONDS()
 WHILE .T.
    End:=SECONDS()             // TIME-OUT de 3 segundos
    If (End)>(Start+2.0)
       Exit
    Endif
 ENDDO




Function Hora()
   IF AT( "NOTIME", Driver ) > 0
      //!TIME /T >HORA.TXT
      Return MEMOREAD( "HORA.TXT" )
   ELSE
      Return TIME()
   ENDIF


