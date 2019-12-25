// ## CL2HB.EXE - Converted

/*
* Modulo      - VPC69999
* Descricao   - Controle de estoque. (Entradas/Saidas)
* Programador - Valmor Pereira Flores
* Data        - 27/Marco/1995
* Atualizacao -
*/
#Include "vpf.ch"
#Include "inkey.ch"

#ifdef HARBOUR
function vpc69999()
#endif


Local cTELA:= Zoom( 12, 14, 18, 35 ), cCOR:= SetColor(), nOpcao:= 1

VpBox(12,14,18,35)
WHILE .T.
   Mensagem("")
   Aadd(MENULIST,swmenunew(13,15," 1 Movimentacao    ",2,COR[11],;
        "Entrada, saida e estorno de lancamentos de produtos em estoque.",,,COR[6],.T.))
   AAdd(MENULIST,swmenunew(14,15," 2 Anular          ",2,COR[11],;
        "Anular lancamentos em estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(15,15," 3 Pesquisas       ",2,COR[11],;
        "Verificacao dos saldos de produtos e movimento geral p/ produto.",,,COR[6],.T.))
   AAdd(MENULIST,swmenunew(16,15," 4 Custo Medio     ",2,COR[11],;
        "Atualizacao dos custos no mov. de estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(17,15," 0 Retorna         ",2,COR[11],;
        "Retorna ao menu anterior.",,,COR[6],.T.))
   swMenu(MENULIST,@nOPCAO); MENULIST:={}
   Do Case
      Case nOPCAO=0 .or. nOPCAO=5; Exit
      Case nOPCAO=1; EstoqueInc()
      Case nOpcao=2; EstoqueAlt()
      Case nOPCAO=3; EstoqueMenuVer()
      Case nOpcao=4; EstMenuSec()
      Case nOpcao=5; AtualizaCustoMedio()
   EndCase
EndDo
DBSelectAr( _COD_ESTOQUE )

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/estind01.ntx","&gdir/estind02.ntx","&gdir/estind03.ntx","&gdir/estind04.ntx"
#else
  Set Index To "&GDIR\ESTIND01.NTX","&GDIR\ESTIND02.NTX","&GDIR\ESTIND03.NTX","&GDir\ESTIND04.NTX"
#endif
UnZoom(cTELA)
SetColor(cCOR)
Return(nil)

Function EstMenuSec()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
LOCAL nOpcao:= 0
VPBox( 14, 24, 19, 53 )
Whil .t.
   Mensagem("")
   Aadd(MENULIST,swmenunew(15,25," 1 Atualiza Custo Medio    ",2,COR[11],;
        "Verifica saldo atual dos produtos em estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(16,25," 2 Visualiza Custo Medio   ",2,COR[11],;
        "Verifica o movimento individual de estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(17,25," 3 Monta Saldo Informativo ",2,COR[11],;
        "Ajusta saldo informativo com base no ultimo calculo de Custo Medio.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(18,25," 0 Retorna                 ",2,COR[11],;
        "Retorna ao menu anterior.",,,COR[6],.T.))
   swMenu(MENULIST,@nOPCAO); MENULIST:={}
   Do Case
      Case nOPCAO=0 .or. nOPCAO=4; Exit
      Case nOPCAO=1; CustoMedio()
      Case nOpcao=2; EstoqueV6()
      case nOpcao=3; QualAjuste()
   EndCase
EndDo
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)

Function QualAjuste()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
LOCAL nOpcao:= 0
VPBox( 17, 40, 21, 68 )
Whil .t.
   Mensagem("")
   Aadd(MENULIST,swmenunew(18,41," 1 Baseado em Lancamentos ",2,COR[11],;
        "Monta Saldo atual dos produtos em estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(19,41," 2 Baseado em Custo Medio ",2,COR[11],;
        "Monta Saldo atual dos produtos em estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(20,41," 0 Retorna                ",2,COR[11],;
        "Retorna ao menu anterior.",,,COR[6],.T.))
   swMenu(MENULIST,@nOPCAO); MENULIST:={}
   Do Case
      Case nOPCAO=0 .or. nOPCAO=3; Exit
      Case nOPCAO=1; SaldoConfLanc()  //Saldo conforme lancamentos
      Case nOpcao=2; MontaSaldo()
   EndCase
ENDdo
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)

Function SaldoConfLanc()
Local cTela:= ScreenSave( 0, 0, 24, 79 ),;
      cCor:= SetColor(), nCursor:= SetCursor(), nSaldoAtu := 0, nIndCdmP := 0
   IF SWAlerta( "Deseja ajustar saldo dos Produtos com base ;nos Lancamentos em Estoque?", { " Confirma ", " Cancela " } )==1
      nAtual  := 0
      Set( 24, "ERR.EST" )
      VPBox( 19, 10, 22, 69, " AJUSTE DE SALDOS ", _COR_GET_BOX  )
      SetColor( _COR_GET_EDICAO )
      EST->( DBSetOrder( 1 ) )
      DBSelectAr( "MPR" )
      nUltimo := LastRec()
      nIndCdmP := IndexOrd()
      DBSetOrder( 1 )
      DBGoTop()
      DO WHILE .NOT. EOF()
         nAtual ++
         @ 20,11 say subst(INDICE,1,7)+" "+DESCRI
         @ 21,11 say padc(strzero(natual,5)+"/"+strzero(nUltimo,5),58)
         nSaldoAtu := 0
         DBSelectAr( "EST" )
         DBSeek( MPR->INDICE )
         DO WHILE .NOT. EOF() .AND. CPROD_ == MPR->INDICE
            IF ANULAR != "*"
               IF ENTSAI == "+"
                  nSaldoAtu += QUANT_
               ENDIF
               IF ENTSAI == "-"
                  nSaldoAtu -= QUANT_
               ENDIF
            ENDIF
            DBSkip()
         ENDDO
         DBSelectAr( "MPR" )
         if val(str(SALDO_,10,3)) <> val(str(nSaldoAtu,10,3))
            Set( 20, "PRINT" )
            @ prow()+1,00 say subst(INDICE,1,7)+" "+DESCRI+" "+str(SALDO_,10,3)+" Lancamentos: "+str(nSaldoAtu,10,3)
            Set( 20, "SCREEN" )
         ENDIF
         IF netrlock()
            repl SALDO_ with nSaldoAtu
         ENDIF
         DBUnlock()
         DBSkip()
      ENDDO

   ENDIF
   Set( 24, "LPT1" )
   MPR->( DBSetOrder( nIndCdmP ) )
   ScreenRest( cTela )
   SetColor( cCor )
   SetCursor( nCursor )
Return Nil


Function MontaSaldo()
Local cTela:= ScreenSave( 0, 0, 24, 79 ),;
      cCor:= SetColor(), nCursor:= SetCursor()

   IF SWAlerta( "Deseja ajustar saldo informativo com base ;no ultimo custo medio gerado?", { " Confirma ", " Cancela " } )==1

      VPBox( 0, 0, 22, 79, " AJUSTE DE SALDOS ", _COR_GET_BOX  )
      SetColor( _COR_GET_EDICAO )
      DBSelectAr( 123 )
      IF Used()
         DBCloseArea()
      ENDIF

      IF File( "ESTOQUE.INF" )
         /* Abertura e organizacao do arquivo */
         DBSelectAr( 123 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Use ESTOQUE.INF Alias ES
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On INDICE To INDICEX.NTX
         DBGoTop()

         MPR->( DBSetOrder( 1 ) )
         WHILE !EOF()
            IF MPR->( DBSeek( ES->INDICE ) )
               IF MPR->( netrlock() )
                  Scroll( 02, 02, 22, 78, 1 )
                  IF MPR->( SALDO_ ) <> ES->SATQTD
                     @ 22,02 Say MPR->DESCRI  + "  100% Ajustado...     "
                     Replace MPR->SALDO_ With ES->SATQTD
                  ELSE
                     @ 22,02 Say MPR->DESCRI  + "  Ja estava correto... "
                  ENDIF
               ENDIF
               DBUnlock()
            ENDIF
            DBSkip()
         ENDDO
         DBCloseAll()
         AbreGrupo( "TODOS_OS_ARQUIVOS" )
         Aviso( "Sincronismo de Saldos Concluido!"  )
         Pausa()

      ENDIF

   ENDIF
   ScreenRest( cTela )
   SetColor( cCor )
   SetCursor( nCursor )
   Return Nil


/*****
�������������Ŀ
� Funcao      � CustoMedio
� Finalidade  � CUSTO MEDIO PADRAO CONTABIL
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
���������������
*/
Function CustoMedio()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local dDataIni:= CTOD( "01/" + StrZero( MONTH( DATE() ), 2, 0 ) + "/" + Right( StrZero( YEAR( DATE() ), 4, 0 ), 2 ) ),;
      dDataFim:= DATE()

      VPBox( 0, 0, 22, 79, "CALCULO CUSTO MEDIO", _COR_GET_BOX )

      DBSelectAr( 123 )
      IF Used()
         DBCloseArea()
      ENDIF

      /* Define a estrutura p/ arquivo temporario com informacoes do estoque */
      aStr:= {{ "INDICE","C",12,00 },;        && Codigo do Produto
              { "DESCRI","C",40,00 },;        && Nome do Produto
              { "CUSANT","N",16,03 },;        && Custo Anterior
              { "CUSMED","N",16,03 },;        && Custo Medio
              { "SDOQTD","N",16,02 },;        && Saldo Anterior     - Quantidades
              { "ENTQTD","N",16,02 },;        && Entradas           - Quantidades
              { "SAIQTD","N",16,02 },;        && Saidas             - Quantidade
              { "SATQTD","N",16,02 },;        && Saldo              - Quantidade
              { "SDOVLR","N",16,02 },;        && Saldo              - Valores
              { "ENTVLR","N",16,02 },;        && Entradas           - Valores
              { "SAIVLR","N",16,02 },;        && Saidas             - Valores
              { "SAIVAL","N",16,02 },;        && Saidas             - Valor Real Venda
              { "SATVLR","N",16,02 },;        && Saldo Atual        - Valores
              { "SD_VLR","N",16,02 },;        && Saidas  No Dia     - Valores
              { "SD_QTD","N",16,02 },;        && Saidas  No Dia     - Quantidade
              { "ED_VLR","N",16,02 },;        && Entrada No Dia     - Valores
              { "ED_QTD","N",16,02 },;        && Entrada No Dia     � Quantidades
              { "OS_VLR","N",16,02 },;        && Outras Saidas      - Valores
              { "OS_QTD","N",16,02 },;        && Outras Saidas      - Quantidade
              { "ENT___","N",16,02 },;        && ENTRADAS
              { "SAI___","N",16,02 }}         && SAIDAS

      SWGravar( 999 )


      /* Apaga o arquivo temporario, para execucao da rotina */
      FErase( "TEMPOR.DBF" )

      /* Criacao do Arquivo */
      DBCreate( "ESTOQUE.INF", aStr )

      /* Abertura e organizacao do arquivo */
      DBSelectAr( 123 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Use ESTOQUE.INF Alias ES
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Index On INDICE To INDICEX.NTX

      SetColor( _COR_GET_EDICAO )
      @ 03,03 Say "Data Inicial:" Get dDataIni
      @ 04,03 Say "Data Final..:" Get dDataFim
      READ

      if !Confirma( 0,0, "Confirma processamento?", "Digite [S] para Processar a Atualizacao do Estoque", "S" )
         ScreenRest( cTela )
         SetColor( cCor )
         SetCursor( nCursor )
         Return Nil
      endif

      nMes:= MONTH( dDataIni )
      nAno:= YEAR( dDataIni )
      nAnoAnt:= nAno
      cFileAtu:= GDir - "\EST" + StrZero( nMes, 2, 0 ) + Right( StrZero( nAno, 4, 0 ), 2 ) + ".INF"
      IF nMes -1 > 0
         nMesAnt:= nMes -1
      ELSE
         nMesAnt:= 12
         nAnoAnt:= nAno -1
      ENDIF
      cFileAnt:= GDir - "\EST" + StrZero( nMesAnt, 2, 0 ) + Right( StrZero( nAnoAnt, 4, 0 ), 2 ) + ".INF"

      SWGravar( 999 )
      /* Criacao do Arquivo */
      DBCreate( cFileAtu, aStr )

      Informacao( "Gerando arquivo temporario...." )
      IF !File( cFileAnt )
         SWAlerta( "Voce esta usando esta rotina pela primeira vez.;Sera criado um arquivo de saldo inicial, vazio.", { "OK" } )
         Aviso( "Transportando produtos, aguarde..." )

         DBCreate( cFileAnt, aStr )

         dbSelectAr( 124 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Use &cFileAnt Alias ANT Exclusive
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On INDICE To INDICE_2.NTX

         MPR->( DBGoTop() )
         WHILE !MPR->( EOF() )
            ANT->( DBAppend() )
            Replace ANT->INDICE With MPR->INDICE,;
                    ANT->DESCRI With MPR->DESCRI
            MPR->( DBSkip() )
         ENDDO
         Ant->( DBGoTop() )

      ELSE

         DBSelectAr( 124 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Use &cFileAnt Alias ANT
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On INDICE To INDICE_2.NTX

      ENDIF

      DBSelectAr( 123 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Use &cFileAtu Alias ES
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Index On INDICE To INDICE_1.NTX

      IF !File( cFileAnt )
         ScreenRest( cTela )
         SetColor( cCor )
         SetCursor( nCursor )
         Return Nil
      ENDIF

      Informacao( "Transferindo Saldo Anterior...." )
      ANT->( DBGoTop() )
      WHILE !ANT->( EOF() )
          IF !( ES->( DBSeek( ANT->INDICE ) ) )
             ES->( DBAppend() )
          ENDIF
          IF ES->( netrlock() )
             Replace ES->INDICE With ANT->INDICE,;
                     ES->DESCRI With ANT->DESCRI,;
                     ES->CUSANT With ANT->CUSMED,;
                     ES->SDOQTD With ANT->SATQTD,;
                     ES->SDOVLR With ANT->SATVLR
          ENDIF
          ANT->( DBSkip() )
      ENDDO
      DBSelectAr( _COD_MPRIMA )
      DBGoTop()
      Informacao( "Inserindo novos itens na tabela...." )
      WHILE !EOF()
         IF !ES->( DBSeek( MPR->INDICE ) )
            ES->( DBAppend() )
            Replace ES->INDICE With MPR->INDICE,;
                    ES->DESCRI With MPR->DESCRI
            Informacao( MPR->DESCRI )
            DBUnlock()
         ENDIF
         MPR->( DBSkip() )
      ENDDO

      DBSelectAr( 123 )
      DBGoTop()

      /* Gravacao de Data da Nota aos movimentos de saida,
         pois, os mesmo estao armazenados somente em DATAMV */

      Informacao( "Fazendo verificacao das datas..." )

      DBSelectAr( _COD_ESTOQUE )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      SET INDEX TO
      DBGoTop()
      WHILE !EOF()
         IF EMPTY( DATANF )
            IF netrlock()
               Replace DATANF With DATAMV
            ENDIF
         ENDIF
         DBSkip()
      ENDDO

      DBGoBottom()
      Informacao( "Revisando cancelamentos de cupons...." )


      ////// GRAVACAO DE VALORES EM REGISTROS QUE NAO POSSUEM A INFORMACAO //////
      PXF->( DBSetOrder( 1 ) )
      EST->( DBGoTop() )
      WHILE !EST->( EOF() )
         IF EST->VALOR_ <= 0 .AND. EST->ENTSAI=="+"
            PXF->( DBSeek( EST->CPROD_ ) )
            IF EST->( netrlock() )
               Replace EST->VALOR_ With EST->QUANT_ * PXF->VALOR_,;
                       EST->STATUS With Space( 2 )
            ENDIF
         ENDIF
         EST->( DBSkip() )
      ENDDO


// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON SubStr( EST->DOC___, 5, 9 ) TO ID933430
      DBGoBottom()


/* Ajuste de Status p/ 00 caso haja cancelamento de Cupom Fiscal */
/////////////////////////////////////////
//
//
//      WHILE !BOF()
//          /* Cancelamento de item na venda s/ anulacao do cupom     ( F10 no Cupom )      */
//          IF RIGHT( ALLTRIM( DOC___ ), 1 )=="C" .AND. ENTSAI=="-"
//             IF netrlock()
//                Replace STATUS With "00"
//             ENDIF
//          /* Cancelamento do item por meio de uma entrada           ( CTRL_F10 no Cupom ) */
//          ELSEIF RIGHT( ALLTRIM( EST->DOC___ ), 1 )=="C" .AND. EST->ENTSAI=="+"
//           StatusCupom( SubStr( EST->DOC___, 5, 9 ), EST->CPROD_, "00"  )
//           Informacao( "Cancelamento do Cupom [ " + SubStr( EST->DOC___, 5, 9 ) + " ] " )
//          ENDIF
//
//          IF netrlock()
//             Replace STATUS With "  "
//          ENDIF
//          DBSkip( -1 )
//      ENDDO
//
//
//
////////////////////////////////////////////////////////////////// VALMOR //////



      DBGoTop()
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      SET INDEX TO

// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON CPROD_ + DTOS( DATANF ) + ENTSAI TO IND0020 FOR ;
            DATANF >= dDataIni .AND. DATANF <= dDataFim .AND. ANULAR==" " .AND.;
            STATUS == Space( 2 )

      DBSetOrder( 1 )
      DBGoTop()

      SWGravar( 600 )
      Set( 24, "ESTLOG.TXT" )

      /* Buscar Ultimos Valores gravados em Custo Medio/Entradas/Quantidades */
      nQtdOutras:=      0
      nValorOutras:=    0
      nValorSaida:=     0
      nVlrSaiReal:=     0
      nVlrEntrada:=     0
      nVlrDiaSaida:=    0
      nQtdDiaSaida:=    0
      nVlrDiaEntrada:=  0
      nQtdDiaEntrada:=  0
      nSdoQtd:=         0
      nQtdSaida:=       0
      nEntradas:=       0
      nSaidas:=         0
      nQtdEntra:=       0
      nValorEntrada:=   0
      nCustoMedio:=     0
      nTotal:=          LASTREC()
      nAtual:=          0
      cProduto:=        CPROD_

      Informacao( "Buscando Saldo Anterior em Itens...." )

      /* Pega Saldo Antertior */
      ES->( DBSeek( cProduto ) )
      nSaldoQtd:=       ES->SDOQTD
      nSaldoVlr:=       ES->SDOVLR

      MPR->( DBSetOrder( 1 ) )
      MPR->( DBSeek( cProduto ) )

      GravaLog( "                     E N T R A D A             S A I D A                S A L D O                     " )
      GravaLog( "DATA     QUANTIDADE    VALOR    UNITARIO   VLR.TOTAL  CUSTO MEDIO  QUANTIDADE  VALOR      CUSTO MEDIO " )

      GravaLog( "PRODUTO" )
      GravaLog( cProduto + " - " + MPR->DESCRI )

      WHILE .T.

         IF EST->CPROD_==cProduto .AND. !EOF()
            IF EST->ENTSAI=="+"
               IF RIGHT( ALLTRIM( DOC___ ), 1 ) == "C"
                  nSaidas:= nSaidas - QUANT_
                  nValorSaida:= nValorSaida - ( QUANT_ * nCustoMedio )
                  /* Cupons nao armazenam valores em VLRSAI, somente em VALOR_ */
                  nVlrSaiReal:= nVlrSaiReal - IF( VLRSAI <= 0, VALOR_, VLRSAI )
                  IF EST->DATANF==dDataFim
                     nVlrDiaSaida:= nVlrDiaSaida - ( QUANT_ * nCustoMedio )
                     nQtdDiaSaida:= nQtdDiaSaida - QUANT_
                  ENDIF
                  nQtdSaida:=   nQtdSaida - QUANT_
                  nSaldoQtd:=   nSaldoQtd + QUANT_
                  nSaldoVlr:=   nSaldoVlr + ( QUANT_ * nCustoMedio )
                  GravaLog( DTOC( EST->DATANF ) + " " + Tran( 0, "@E 999,999.99" ) + " "+;
                                                     Tran( 0, "@E 999,999.99" ) + " " +;
                                                     Tran( 0, "@E 999,999.99" ) + " " +;
                                                     Tran( QUANT_, "@E 999,999.99" ) + " " +;
                                                     Tran( QUANT_ * nCustoMedio, "@E 999,999.99" ) + " " +;
                                                     Tran( nCustoMedio, "@E 999,999.99" ) + " " +;
                                                     Tran( nSaldoQtd, "@E 999,999.99" ) + " " +;
                                                     Tran( nSaldoVlr, "@E 999,999.99" ) + " "+;
                                                     Tran( nCustoMedio, "@E 999,999.999" ) + " CANCELAMENTO DE CUPOM " )
               ELSE
                  IF VALOR_ > 0
                     nEntradas:= nEntradas + QUANT_
                     IF !( ALLTRIM( EST->DOC___ )=="***<AJUSTE>***" )
                        // Se custo estiver preenchido usa o mesmo,
                        // pois, � a melhor alternativa do ponto de
                        // vista contabil
                        IF EST->CUSTO_ > 0
                           nValorEntrada:= nValorEntrada + ( EST->CUSTO_ * EST->QUANT_ )
                           IF EST->DATANF==dDataFim
                              nVlrDiaEntrada:= nVlrDiaEntrada + ( EST->CUSTO_ * EST->QUANT_ )
                           ENDIF
                        ELSE
                           nValorEntrada:= nValorEntrada + VALOR_
                           IF EST->DATANF==dDataFim
                              nVlrDiaEntrada:= nVlrDiaEntrada + VALOR_
                           ENDIF
                        ENDIF
                     ENDIF
                     ES->( DBSeek( EST->CPROD_ ) )
                  ENDIF
                  nQtdEntra:= nQtdEntra + QUANT_
                  IF EST->DATANF == dDataFim
                     nQtdDiaEntrada:= nQtdDiaEntrada + QUANT_
                  ENDIF
                  nSaldoQtd:=   nSaldoQtd + QUANT_
////*******VALMOR novembro/2003 ****************====>
//////////////                 nSaldoVlr:=   ES->SDOVLR - nValorSaida + nValorEntrada   /* aqui */
                  //nSaldoVlr:=   nSaldoVlr + ( EST->VALOR_ ) /// nValorEntrada   /* aqui */
///******************* VALMOR ***************************************


                  // At� o dia 02/06/2004 esta linha estava ativa, mas, foi substituida pelas
                  // linhas seguintes: Valmor
                  // nSaldoVlr:=   nSaldoVlr + ( EST->VALOR_ )


                  // Utiliza custo
                  IF EST->CUSTO_ > 0
                     // Formato cont�bil.
                     // Baseia-se no custo que � formado na inser��o de nota de entrada
                     // conforme altera��es realizadas em 02/06/2004 com implementa��o de F10
                     // na rotina de registro de notas de entrada
                     // Implementado em 02/06/2004: Valmor Pereira Flores
                     nSaldoVlr:=   nSaldoVlr + ( EST->CUSTO_ * EST->QUANT_ )
                  ELSE
                     // Formato convencional
                     nSaldoVlr:=   nSaldoVlr + ( EST->VALOR_ )
                  ENDIF
                  nCustoMedio:= nSaldoVlr / nSaldoQtd

                  /////////////////// FORMA ANTERIOR ////////// ( ES->SDOVLR + nValorEntrada ) / ( nEntradas + ES->SDOQTD )
                  GravaLog( DTOC( EST->DATANF ) + " " + Tran( QUANT_, "@E 999,999.99" ) + " "+;
                                                        Tran( IIF( CUSTO_ > 0, CUSTO_ * QUANT_, VALOR_ ), "@E 999,999.99" ) + " " +;
                                                        Tran( IIF( CUSTO_ > 0, CUSTO_ * QUANT_, VALOR_ ) / QUANT_, "@E 999,999.99" ) + " " +;
                                                        Tran( 0, "@E 999,999.99" ) + " " +;
                                                        Tran( 0, "@E 999,999.99" ) + " " +;
                                                        Tran( 0, "@E 999,999.99" ) + " " +;
                                                        Tran( nSaldoQtd, "@E 999,999.99" ) + " " + ;
                                                        Tran( nSaldoVlr, "@E 999,999.99" ) + " " + ;
                                                        Tran( nCustoMedio, "@E 999,999.999" ) )
               ENDIF
            ELSE
               OPE->( DBSetOrder( 1 ) )
               OPE->( DBSeek( EST->CODMV_ ) )
               IF ( OPE->NATOPE >= 5.120 .AND. OPE->NATOPE <= 5.129 ) .OR.;
                  ( OPE->NATOPE >= 6.120 .AND. OPE->NATOPE <= 5.129 ) .OR.;
                  ( OPE->NATOPE >= 5.102 .AND. OPE->NATOPE <= 5.109 ) .OR.;
                  ( OPE->NATOPE >= 6.102 .AND. OPE->NATOPE <= 6.109 )

                  nSaidas:= nSaidas + QUANT_
                  nValorSaida:= nValorSaida + ( QUANT_ * nCustoMedio )
                  /* Cupons nao armazenam valores em VLRSAI, somente em VALOR_ */
                  nVlrSaiReal:= nVlrSaiReal + IF( VLRSAI <= 0, VALOR_, VLRSAI )
                  IF EST->DATANF==dDataFim
                     nVlrDiaSaida:= nVlrDiaSaida + ( QUANT_ * nCustoMedio )
                     nQtdDiaSaida:= nQtdDiaSaida + QUANT_
                  ENDIF
               ELSE
                  nValorOutras:= nValorOutras + ( QUANT_ * nCustoMedio )
                  nQtdOutras:=   nQtdOutras   + QUANT_
               ENDIF
               nQtdSaida:=   nQtdSaida + QUANT_
               nSaldoQtd:=   nSaldoQtd - QUANT_
               nSaldoVlr:=   nSaldoVlr - ( QUANT_ * nCustoMedio )
               GravaLog( DTOC( EST->DATANF ) + " " + Tran( 0, "@E 999,999.99" ) + " "+;
                                                     Tran( 0, "@E 999,999.99" ) + " " +;
                                                     Tran( 0, "@E 999,999.99" ) + " " +;
                                                     Tran( QUANT_, "@E 999,999.99" ) + " " +;
                                                     Tran( QUANT_ * nCustoMedio, "@E 999,999.99" ) + " " +;
                                                     Tran( nCustoMedio, "@E 999,999.99" ) + " " +;
                                                     Tran( nSaldoQtd, "@E 999,999.99" ) + " " +;
                                                     Tran( nSaldoVlr, "@E 999,999.99" ) + " "+;
                                                     Tran( nCustoMedio, "@E 999,999.999" ) )
            ENDIF

         ELSE

            /* Gravacao do Ultimo Custo Calculado */
            MPR->( DBSetOrder( 1 ) )

            /* Busca o nome do novo produto e grava no log */
            MPR->( DBSeek( EST->CPROD_ ) )
            GravaLog( "PRODUTO" )
            GravaLog( EST->CPROD_ + " - " + MPR->DESCRI )

            /* Busca ultimo produto processado */
            MPR->( DBSeek( PAD( cProduto, 12 ) ) )
            nCustoMedio:= ( ES->SDOVLR + ( nValorEntrada - nValorSaida ) ) / ( ( nEntradas - nSaidas ) + ES->SDOQTD )
            IF MPR->( netrlock() )
               IF !ES->( DBSeek( MPR->INDICE ) )
                  ES->( DBAppend() )
               ENDIF
               IF nCustoMedio <= 0
                  nCustoMedio:= ES->CUSANT
               ENDIF
               Replace MPR->CUSMED With nCustoMedio
               //Replace MPR->SALDO_ With nEntradas
               Replace MPR->DATA__ With dDataFim
               Replace MPR->ENTVLR With nValorEntrada
               IF ES->( netrlock() )
                  Replace ES->INDICE With MPR->INDICE,;
                          ES->DESCRI With MPR->DESCRI,;
                          ES->CUSMED With nCustoMedio,;
                          ES->ENTVLR With nValorEntrada,;
                          ES->ENTQTD With nQtdEntra,;
                          ES->SAIQTD With nQtdSaida,;
                          ES->SATVLR With nSaldoVlr,;            && Saldo Atual Valor
                          ES->SATQTD With nSaldoQtd,;            && Saldo Atual Quantidade
                          ES->SAIVAL With nVlrSaiReal,;
                          ES->SAIVLR With nValorSaida,;
                          ES->SD_VLR With nVlrDiaSaida,;
                          ES->SD_QTD With nQtdDiaSaida,;
                          ES->ED_VLR With nVlrDiaEntrada,;
                          ES->ED_QTD With nQtdDiaEntrada,;
                          ES->OS_VLR With nValorOutras,;
                          ES->OS_QTD With nQtdOutras
               ENDIF
            ENDIF
            /* Limpa Informacoes */
            nCustoMedio:=     0
            nValorEntrada:=   0
            nSaidas:=         0
            nEntradas:=       0
            cProduto:=        CPROD_
            nQtdEntra:=       0
            nVlrDiaEntrada:=  0
            nQtdDiaEntrada:=  0
            nVlrDiaSaida:=    0
            nQtdDiaSaida:=    0
            nQtdSaida:=       0
            nValorSaida:=     0
            nVlrSaiReal:=     0
            nSdoQtd:=         0
            nValorOutras:=    0
            nQtdOutras:=      0

            /* Busca o produto atual em ES */
            ES->( DBSeek( EST->CPROD_ ) )

            /* Pega Saldo Antertior & Custo Medio Anterior */
            nCustoMedio:= ES->SDOVLR / ES->SDOQTD
            nSaldoQtd:=   ES->SDOQTD
            nSaldoVlr:=   ES->SDOVLR

            /* Verifica se e final de arquivo */
            EST->( DBSkip() )
            IF EST->( EOF() )
               EXIT
            ENDIF
            EST->( DBSkip(-1) )

            /* Faz voltar um registro, para processar todas as informacoes
               deste produto novo, ja que logo abaixo tem um Skip(+1) */
            EST->( DBSkip( -1 ) )

         ENDIF
         EST->( DBSkip() )
      ENDDO

      /* AJUSTA INFORMACOES DE SALDOS */
      Informacao( "Verificando saldos em Valor x Quantidades...." )
      ES->( DBGoTop() )
      WHILE !ES->( EOF() )
         IF ES->( netrlock() )
            IF ES->CUSMED==0
               Replace ES->CUSMED With ES->CUSANT
            ENDIF
            IF ES->ENTQTD==0 .AND. ES->SAIQTD==0 .AND. ES->OS_QTD==0
               Replace ES->SATQTD With ES->SDOQTD
               Replace ES->SATVLR With ES->SATQTD * ES->CUSMED
            ENDIF
         ENDIF
         ES->( DBSkip() )
      ENDDO

      ES->( DBGOTOP() )
      WHILE !ES->( EOF() )
          IF ES->( netrlock() )
             IF ES->CUSMED==0
                Replace ES->CUSMED With ES->CUSANT
             ENDIF
             IF ES->ENTQTD==0 .AND. ES->SAIQTD==0 .AND. ES->OS_QTD==0
                Replace ES->SATQTD With ES->SDOQTD,;
                        ES->SATVLR With ES->SDOVLR
             ENDIF
          ENDIF
          ES->( DBSkip() )
      ENDDO

      Informacao( "Gravando Informacoes Definitivas de Custo Medio Calculado...." )

      /* Restaura Status */
      GravaLog( "" )

      Set( 24, "LPT1" )
      SWGravar( 5 )
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )

      /* Copia Informacoes ao ESTOQUE.INF Atual */
      DBSelectAr( 123 )
      DBGoTop()
      COPY TO ESTOQUE.INF

      DBCloseAll()
      AbreGrupo( "TODOS_OS_ARQUIVOS" )
      DBSelectAr( _COD_CLIENTE )

      Return Nil


Static Function Informacao( cInfo )
 Scroll( 02, 02, 20, 78, 1 )
 @ 20,02 Say LEFT( cInfo, 77 )
 Return Nil

Function StatusCupom( cCupom, cProduto, cStatus )
Local  nReg:= EST->( RECNO() )

   IF EST->( DBSeek( cCupom ) )
      WHILE ALLTRIM( SubStr( EST->DOC___, 5, 9 ) ) == ALLTRIM( cCupom )
         IF ALLTRIM( CPROD_ )==ALLTRIM( cProduto )
            IF EST->( netrlock() )
               Replace EST->STATUS With cStatus
            ENDIF
         ENDIF
         EST->( DBSkip() )
      ENDDO
   ENDIF
   EST->( DBGoTo( nReg ) )
   Return Nil


Static Function GravaLog( cMsg )
 Set( 20, "PRINT" )
 @ PROW(),PCOL() Say cMsg + Chr( 13 ) + Chr( 10 )
 Set( 20, "SCREEN" )
 Return Nil

/*****
�������������Ŀ
� Funcao      � visualCustos
� Finalidade  � Visualizacao dos Custos / Informacoes de Estoque
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor P.Flores
� Data        �
���������������
*/
Static Function VisualCustos()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nTecla, nOpcao:= 0, nArea:= Select()
Local nRow:= 1, TECLA

   VPBox( 06, 29, 18, 55, " Arquivos ", _COR_GET_BOX )
   SetColor( _COR_GET_EDICAO )
   aFiles:= Directory( GDir + "\*.INF" )
   ASORT( aFiles,,, {|x,y| x[3] > y[3] } )

   oTAB:=tbrowsenew( 07, 30, 17, 54 )
   oTAB:addcolumn(tbcolumnnew(,{|| PAD( aFiles[nROW][1], 12 ) + " em  " + DTOC( aFiles[ nRow ][ 3 ] ) }))
   oTAB:AUTOLITE:=.f.
   oTAB:GOTOPBLOCK :={|| nROW:=1}
   oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aFiles)}
   oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aFiles,@nROW)}
   oTAB:dehilite()
   lDelimiters:= Set( _SET_DELIMITERS, .F. )
   WHILE .T.
       oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1})
       WHILE nextkey()==0 .and. ! oTAB:stabilize()
       ENDDO
       TECLA:= Inkey(0)
       IF TECLA==K_ESC
          nOpcao:= 0
          exit
       ENDIF
       DO CASE
          CASE TECLA==K_UP         ;oTAB:up()
          CASE TECLA==K_DOWN       ;oTAB:down()
          CASE TECLA==K_LEFT       ;oTAB:up()
          CASE TECLA==K_RIGHT      ;oTAB:down()
          CASE TECLA==K_PGUP       ;oTAB:pageup()
          CASE TECLA==K_CTRL_PGUP  ;oTAB:gotop()
          CASE TECLA==K_PGDN       ;oTAB:pagedown()
          CASE TECLA==K_CTRL_PGDN  ;oTAB:gobottom()
          CASE TECLA==K_F12        ;Calculador()
          case Tecla==K_CTRL_F10   ;Calendar()
          CASE TECLA==K_ENTER
               nOpcao:= nRow
               EXIT
          OTHERWISE                ;tone(125); tone(300)
       ENDCASE
       oTAB:refreshcurrent()
       oTAB:stabilize()
   ENDDO

   IF nOpcao==0
      cFile:= "XYZ"
   ELSE
      cFile:= aFiles[ nOpcao ][ 1 ]
   ENDIF

   cFile:= GDir + "\" + cFile

   IF !FILE( cFile )
      Aviso( "Arquivo nao Encontrado." )
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return Nil
   ENDIF

   DBSelectAr( 123 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cFile Alias ES
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On INDICE To IN002930.NTX
   DBGoTop()

   Mensagem( "[CTRL-F1]Grava arquivo de ESTOQUE/VISUALIZACAO com as informacoes." )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen()
   VPBox( 0, 0, 22, 79, " INFORMACOES DE ESTOQUE / CUSTO MEDIO ", _COR_BROW_BOX, .F., .F. )
   SetColor( _COR_BROWSE )
   oTb:= TBrowseDB( 01, 01, 21, 78 )
   oTb:addcolumn(tbcolumnnew(,{|| Alltrim( INDICE ) + " " + LEFT( DESCRI, 39 ) + Tran( CUSMED, "@E 999,999.99" ) + Tran( CUSMED, "@E 999,999.999" ) + Tran( ENTVLR, "@E 999,999.999" ) + Tran( SAIVLR, "@E 999,999.99" ) }))
   oTb:AUTOLITE:=.f.
   oTb:dehilite()
   lDelimiters:= Set( _SET_DELIMITERS, .F. )
   WHILE .T.
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
      WHILE nextkey()==0 .and. ! oTb:stabilize()
      ENDDO
      nTecla:= Inkey(0)
      IF nTecla==K_ESC
         nOpcao:= 0
         exit
      ENDIF
      DO CASE
         CASE nTecla==K_UP         ;oTb:up()
         CASE nTecla==K_DOWN       ;oTb:down()
         CASE nTecla==K_LEFT       ;oTb:up()
         CASE nTecla==K_RIGHT      ;oTb:down()
         CASE nTecla==K_PGUP       ;oTb:pageup()
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop()
         CASE nTecla==K_PGDN       ;oTb:pagedown()
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom()
         CASE nTecla==K_F12        ;Calculador()
         case nTecla==K_CTRL_F10   ;Calendar()
         CASE DBPesquisa( nTecla, oTb )
         CASE nTecla==K_CTRL_F1
              COPY TO "&GDir\ESTOQUE.INF"
         CASE nTecla==K_ENTER
              cTelaRes:= ScreenSave( 0, 0, 24, 79 )
              VPBox( 05, 05, 22, 60, "Informacoes de Estoque", _COR_GET_BOX )
              SetColor( _COR_GET_EDICAO )
              nCusMed:=  CUSMED
              nSaldoAQ:= SATQTD
              nSaldoAV:= SATVLR
              nSaldoIV:= SDOVLR
              nSaldoIQ:= SDOQTD
              nCusAnt:=  CUSANT
              nEntQtd:=  ENTQTD
              nEntVlr:=  ENTVLR
              nSaiQtd:=  SAIQTD + OS_QTD
              nSaiVlr:=  SAIVLR + OS_VLR
              @ 07,07 Say "                      EM QUANTIDADE  EM VALORES "
              @ 09,07 Say " SALDO INICIAL          " + Tran( nSaldoIQ, "@E 9999,999.99 " ) +;
                                                     Tran( nSaldoIV, "@E 9999,999.99 " )
              @ 11,07 Say " E N T R A D A          " + Tran( nEntQtd,  "@E 9999,999.99 " ) +;
                                                     Tran( nEntVlr,  "@E 9999,999.99 " )
              @ 13,07 Say " S A I D A S            " + Tran( nSaiQtd,  "@E 9999,999.99 " ) +;
                                                     Tran( nSaiVlr,  "@E 9999,999.99 " )
              @ 15,07 Say " SALDO FINAL           " Get nSaldoAQ Pict "@E 9999,999.99 "
              @ 17,07 Say " CUSTO MEDIO   Inicial:" Get nCusAnt  Pict "@E 9999,999.999"
              @ 18,07 Say "               Final..:" Get nCusMed  Pict "@E 9999,999.999"
              @ 15,07 Say " SALDO FINAL MES                   " Get nSaldoAV Pict "@E 9999,999.99 "
              READ
              ScreenRest( cTelaRes )
              IF netrlock()
                 Replace ES->SATQTD With nSaldoAQ,;
                         ES->SATVLR With nSaldoAV,;
                         ES->CUSANT With nCusAnt,;
                         ES->CUSMED With nCusMed
              ENDIF

         CASE nTecla==K_DEL
              IF Exclui( oTb )
                 oTb:RefreshAll()
                 WHILE !oTb:Stabilize()
                 ENDDO
              ENDIF
     ENDCASE
     oTb:RefreshCurrent()
     WHILE !oTb:Stabilize()
     ENDDO
  ENDDO
  Set( _SET_DELIMITERS, lDelimiters )
  dbunlockall()
  DBCloseArea()
  DBSelectAr( nArea )
  FechaArquivos()
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return Nil



Function EstoqueMenuVer
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
LOCAL nOPCAO:=0
VPBox( 12, 24, 20, 53 )
Whil .t.
   Mensagem("")
   Aadd(MENULIST,swmenunew(13,25," 1 Saldos em Estoque       ",2,COR[11],;
        "Verifica saldo atual dos produtos em estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(14,25," 2 Individual              ",2,COR[11],;
        "Verifica o movimento individual de estoque.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(15,25," 3 Movimento Geral         ",2,COR[11],;
        "Verifica o movimento geral em estoque.",,,COR[6],.T.))
   AAdd(MENULIST,swmenunew(16,25," 4 Saidas por Cliente      ",2,COR[11],;
        "Verifica as saidas por cliente.",,,COR[6],.T.))
   AAdd(MENULIST,swmenunew(17,25," 5 Entradas por Fornecedor ",2,COR[11],;
        "Verifica as entradas por fornecedor.",,,COR[6],.T.))
   AAdd(MENULIST,swmenunew(18,25," 6 Detalhamento            ",2,COR[11],;
        "Saidas de Estoque Detalhadas.",,,COR[6],.T.))
   Aadd(MENULIST,swmenunew(19,25," 0 Retorna                 ",2,COR[11],;
        "Retorna ao menu anterior.",,,COR[6],.T.))
   swMenu(MENULIST,@nOPCAO); MENULIST:={}
   Do Case
      Case nOPCAO=0 .or. nOPCAO=7; Exit
      Case nOPCAO=1; EstoqueV1()
      Case nOPCAO=2; EstoqueV2()
      Case nOPCAO=3; EstoqueV3()
      Case nOPCAO=4; EstoqueV4()
      Case nOpcao=5; EstoqueV5()
//      Case nOpcao=6; EstoqueV7()
   EndCase
EndDo
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)


Function EstoqueV1
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), x
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen()
AbreGrupo( "ESTOQUE" )
DBSelectAr( _COD_MPRIMA )
DBSetOrder( 1 )
x:= GrupoDeProdutos
GrupoDeProdutos:= "999"
VisualProdutos( "0000000000" )
GrupoDeProdutos:= x
FechaArquivos()
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)

Function EstoqueV2
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), cCodigo:= "0000000000",;
      x, nFornecedor:= 0, cOrigem, nSaldo:= 0, cCodOrigem:= "   ", nPrecoVenda:= 0,;
      cCodFab:= Space( 15 ), cDescricao:= Space( 40 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen()
VPBox( 00, 00, 22, 79, "Verificacao de Estoque", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
////////AbreGrupo( "ESTOQUE" )
DBSelectAr( _COD_MPRIMA )
DBSetOrder( 1 )
While .T.
   x:= GrupoDeProduto
   GrupoDeProduto:= "999"
   MPR->( DBSetOrder( 1 ) )
   MPR->( DBSeek( cCodigo ) )
   IF MPR->( EOF() )
      MPR->( DBGoTop() )
   ENDIF
   VisualProdutos( cCodigo )
   GrupoDeProduto:= x
   IF LastKey()==K_ESC
      EXIT
   ENDIF
   cCodigo:= MPR->Indice
   cCodOrigem:= MPR->Origem
   nFornecedor:= MPR->CodFor
   nSaldo:= MPR->Saldo_
   nPrecoVenda:= MPR->PrecoV
   cCodFab:= MPR->CodFab
   cDescricao:= Mpr->Descri

   /* Busca o fabricante do produto */
   DBSelectAr( _COD_ORIGEM )
   DBSetOrder( 3 )
   IF DBSeek( cCodOrigem )
      cOrigem:= DESCRI
   ELSE
      cOrigem:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      "
   ENDIF

   /* Busca o fornecedor */
   DBSelectAr( _COD_FORNECEDOR )
   IF DBSeek( nFornecedor )
      cFornecedor:= DESCRI
   ELSE
      cFornecedor:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      "
   ENDIF

   /* Seleciona Cfe. selecionado */
   Private cCodPrd:= cCodigo
   DBSelectAr( _COD_ESTOQUE )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On DATAMV Tag DT1 Eval {|| Processo( 1 ) } To Indice20 For CPROD_ == cCodPrd
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To Indice20
   DBGoTop()
   nSaldo:= 0
   Mensagem( "Calculando Saldos, aguarde..." )
   WHILE !EOF()
      IF !( ANULAR=="*" )
         IF netrlock()
            nSaldo:= nSaldo + IF( ENTSAI=="+", QUANT_, QUANT_ * (-1) )
            Replace SALDO_ With nSaldo
         ENDIF
         DBUnlock()
      ENDIF
      DBSkip()
   ENDDO
   DBGoTop()
   Mensagem( "Digite [DATA] para pesquisar ou tecle [ENTER] para nova pesquisa." )
   VpBox(10,00,22,79,"MOVIMENTO", COR[20], .F., .F., COR[19], .F. )
   VpBox(12,01,12,78,"", _COR_BROW_BOX, .f., .f. )
   DbGoTop()
   SetColor( _COR_BROWSE )
   oTab:=TBrowseDb(13,01,21,78)
   oTab:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+;
            " "+if(ENTSAI="+","Entrada","Saida  ")+" "+ STRZERO( CODIGO, 6, 0 ) + ;
            " "+DOC___+" "+Tran(QUANT_,"@E 999,999.999")+;
            " "+Tran(IF( VALOR_==0, VLRSAI, VALOR_),"@E 9999999.99") + IF( Anular=="*", " Anulado", Tran( SALDO_, "@E 999,999,999.999") ) + SPACE( 20 ) }))
   oTab:AUTOLITE:=.F.
   oTab:Dehilite()
   OPE->( DBSetOrder( 1 ) )
   Whil .T.
      oTab:ColorRect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1})
      Whil NextKey()=0 .AND.! oTab:Stabilize()
      Enddo
      SetColor( _COR_GET_EDICAO )
      @ 01,02 Say "Produto...: [" + cDescricao + "]"
      @ 02,01 Say "������������������������������������������������������������������������������"
      @ 03,02 Say "Codificao.: [" + Tran( Left( CProd_, 7 ), "@R 999-9999" ) + "]     Codigo de Fabrica: [" + cCodFab + "]"
      @ 04,02 Say "Fabricante: [" + cCodOrigem + "]-[" + cOrigem + "]"
      OPE->( dbSeek( EST->CODMV_ ) )
      IF OPE->CLIFOR == "F"
         FOR->(DBseek( EST->CODIGO ) )
         @ 05,02 Say "Fornecedor: [" + StrZero( CODIGO, 6, 0 ) + "]-[" + FOR->DESCRI + "]"
      ELSE
         CLI->( DBseek( EST->CODIGO ) )
         @ 05,02 Say "Cliente...: [" + StrZero( CODIGO, 6, 0 ) + "]-[" + CLI->DESCRI + "]"
      ENDIF
      @ 06,01 Say "������������������������������������������������������������������������������"
      @ 07,02 Say "Saldo.....: [" + Tran( nSaldo, "@E 999,999.9999" ) + "]"
      @ 08,02 Say "Preco.....: [" + Tran( nPrecoVenda, "@E 999,999.9999" ) + "]"
      @ 09,02 Say "Preco Nota: [" + Tran( VALOR_/QUANT_, "@E 999,999.9999" ) + "]"
      SetColor( _COR_BROWSE )
      nTECLA:=inkey(0)
      If nTecla=K_ESC .OR. nTecla=K_ENTER
         Exit
      Endif
      Do Case
         Case nTECLA==K_UP         ;oTab:Up()
         Case nTECLA==K_LEFT       ;oTab:Up()
         Case nTECLA==K_DOWN       ;oTab:Down()
         Case nTECLA==K_RIGHT      ;oTab:Down()
         Case nTECLA==K_PGUP       ;oTab:PageUp()
         Case nTECLA==K_PGDN       ;oTab:PageDown()
         Case nTECLA==K_CTRL_PGUP  ;oTab:GoTop()
         Case nTECLA==K_CTRL_PGDN  ;oTab:GoBottom()
         Case nTecla==K_F2; DBMudaOrdem( 1, oTab )
         Case nTecla==K_F3; DBMudaOrdem( 2, oTab )
         Case nTecla==K_F4; DBMudaOrdem( 3, oTab )
         Case DBPesquisa( nTecla, oTab )
      EndCase
      oTab:RefreshCurrent()
      oTab:Stabilize()
   EndDo
EndDo
DBSelectAr( _COD_ESTOQUE )

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/estind01.ntx","&gdir/estind02.ntx","&gdir/estind03.ntx","&gdir/estind04.ntx"
#else
  Set Index To "&GDIR\ESTIND01.NTX","&GDIR\ESTIND02.NTX","&GDIR\ESTIND03.NTX","&GDir\ESTIND04.NTX"
#endif
///FechaArquivos()
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)


Function EstoqueV4
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), cCodigo:= "0000000000",;
      x, nFornecedor:= 0, cOrigem, nSaldo:= 0, cCodOrigem:= "   ", nPrecoVenda:= 0,;
      cCodFab:= Space( 15 ), cDescricao:= Space( 40 ), nCodCli:= 18
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen()
VPBox( 00, 00, 22, 79, "Verificacao de Estoque", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
READ
AbreGrupo( "ESTOQUE" )
DBSelectAr( _COD_MPRIMA )
DBSetOrder( 1 )
DBSelectAr( _COD_ESTOQUE )
Set Relation To CPROD_ INTO MPR
While .T.
   x:= GrupoDeProduto
   VisualClientes()
   IF LastKey()==K_ESC
      EXIT
   ENDIF
   nCodCli:= Cli->Codigo
   cDescri:= Cli->Descri
   cFone1:=  Cli->Fone1_
   cFone2:=  Cli->Fone2_
   cFone3:=  Cli->Fone3_
   cComprador:= Cli->Compra
   cResponsavel:= Cli->Respon
   cCodigo:= MPR->Indice
   cCodOrigem:=  MPR->Origem
   nFornecedor:= MPR->CodFor
   nSaldo:=      MPR->Saldo_
   nPrecoVenda:= MPR->PrecoV
   cCodFab:=     MPR->CodFab
   cDescricao:=  Mpr->Descri

   /* Busca o fabricante do produto */
   DBSelectAr( _COD_ORIGEM )
   DBSetOrder( 3 )
   IF DBSeek( cCodOrigem )
      cOrigem:= DESCRI
   ELSE
      cOrigem:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      "
   ENDIF

   /* Busca o fornecedor */
   DBSelectAr( _COD_FORNECEDOR )
   IF DBSeek( nFornecedor )
      cFornecedor:= DESCRI
   ELSE
      cFornecedor:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      "
   ENDIF

   /* Seleciona Cfe. selecionado */
   DBSelectAr( _COD_ESTOQUE )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On DataMv Tag DT1 Eval {|| Processo( 1 ) } To Indice20 For Codigo == nCodCli .AND. EntSai == "-"
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To Indice20.Ntx
   Mensagem( "Digite [Data/Documento] para pesquisar ou tecle [ENTER] para proximo." )
   VpBox(12,00,22,79,"Movimento de SAIDA para o cliente", COR[20], .F., .F., COR[19], .F. )
   DbGoTop()
   SetColor( _COR_BROWSE )
   oTab:=TBrowseDb(13,01,21,78)
   oTab:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+;
            " "+if(ENTSAI="+","Entrada","Saida  ")+" "+ tran( CProd_, "@R 999-9999" ) + ;
            " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+;
            " "+Tran( IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) + SPACE( 20 ) }))
   oTab:AUTOLITE:=.F.
   oTab:Dehilite()
   Whil .T.
      oTab:ColorRect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1})
      Whil NextKey()=0 .AND.! oTab:Stabilize()
      Enddo
      SetColor( _COR_GET_EDICAO )
      @ 01,02 Say "Cliente....: [" + StrZero( nCodCli, 6, 0 ) + "] - [" + cDescri + "]"
      @ 02,02 Say "Telefone...: [" + cFone1 + "][" + cFone2 + "][" + cFone3 + "]"
      @ 03,02 Say "Comprador..: [" + cComprador + "]"
      @ 04,02 Say "Responsavel: [" + cResponsavel + "]"
      @ 05,02 Say "������������������������������������������������������������������������������"
      @ 06,02 Say "Produto....: [" + MPR->DESCRI + " " + MPR->UNIDAD + "]"
      @ 07,02 Say "Cod.Fabrica: [" + MPR->CODFAB + "]"
      @ 08,02 Say "Fabricante.: [" + MPR->ORIGEM + "]"
      @ 09,02 Say "Saldo......: [" + Tran( MPR->SALDO_, "@E 999,999.9999" ) + "]"
      @ 10,02 Say "Preco......: [" + Tran( MPR->PRECOV, "@E 999,999.9999" ) + "]"
      SetColor( _COR_BROWSE )
      nTECLA:=inkey(0)
      If nTecla=K_ESC .OR. nTecla=K_ENTER
         Exit
      Endif
      Do Case
         Case nTECLA==K_UP         ;oTab:Up()
         Case nTECLA==K_DOWN       ;oTab:Down()
         Case nTECLA==K_PGUP       ;oTab:PageUp()
         Case nTECLA==K_PGDN       ;oTab:PageDown()
         Case nTECLA==K_CTRL_PGUP  ;oTab:GoTop()
         Case nTECLA==K_CTRL_PGDN  ;oTab:GoBottom()
         Case dbPesquisa( nTecla, oTab )
         Case nTecla==K_F2; DBMudaOrdem( 1, oTab )
         Case nTecla==K_F3; DBMudaOrdem( 2, oTab )
         Case nTecla==K_F4; DBMudaOrdem( 3, oTab )
         OtherWise
              EXIT
      EndCase
      oTab:RefreshCurrent()
      oTab:Stabilize()
   EndDo
EndDo
DBSelectAr( _COD_ESTOQUE )

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/estind01.ntx","&gdir/estind02.ntx","&gdir/estind03.ntx"
#else
  Set Index To "&GDIR\ESTIND01.NTX","&GDIR\ESTIND02.NTX","&GDIR\ESTIND03.NTX"
#endif
FechaArquivos()
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)

Function EstoqueV5
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), cCodigo:= "0000000000",;
      x, nFornecedor:= 0, cOrigem, nSaldo:= 0, cCodOrigem:= "   ", nPrecoVenda:= 0,;
      cCodFab:= Space( 15 ), cDescricao:= Space( 40 ), nCodCli:= 18
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen()
VPBox( 00, 00, 22, 79, "Verificacao de Estoque", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
READ
AbreGrupo( "ESTOQUE" )
DBSelectAr( _COD_MPRIMA )
DBSetOrder( 1 )
DBSelectAr( _COD_ESTOQUE )
Set Relation To CPROD_ INTO MPR
While .T.
   x:= GrupoDeProduto
   ForSeleciona( 999999 )
   IF LastKey()==K_ESC
      EXIT
   ENDIF
   nCodFor:=      FOR->Codigo
   cDescri:=      FOR->Descri
   cFone1:=       FOR->Fone1_
   cVendador:=    FOR->Vended
   cResponsavel:= FOR->Respon

   cCodigo:=      MPR->Indice
   cCodOrigem:=   MPR->Origem
   nFornecedor:=  MPR->CodFor
   nSaldo:=       MPR->Saldo_
   nPrecoVenda:=  MPR->PrecoV
   cCodFab:=      MPR->CodFab
   cDescricao:=   MPR->Descri

   /* Busca o fabricante do produto */
   DBSelectAr( _COD_ORIGEM )
   DBSetOrder( 3 )
   IF DBSeek( cCodOrigem )
      cOrigem:= DESCRI
   ELSE
      cOrigem:= "NAO IDENTIFICADO. VERIFIQUE O CADASTRO!      "
   ENDIF

   /* Seleciona Cfe. selecionado */
   DBSelectAr( _COD_ESTOQUE )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On dataMv Tag DT1 Eval {|| Processo( 1 ) } To Indice20 For Codigo == nCodFor .AND. EntSai == "+"
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To Indice20.Ntx
   Mensagem( "Digite [Data/Documento] para pesquisar ou tecle [ENTER] para proximo." )
   VpBox(12,00,22,79,"Movimento de SAIDA para o cliente", COR[20], .F., .F., COR[19], .F. )
   DbGoTop()
   SetColor( _COR_BROWSE )
   oTab:=TBrowseDb(13,01,21,78)
   oTab:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+;
            " "+if(ENTSAI="+","Entrada","Saida  ")+" "+ tran( CProd_, "@R 999-9999" ) + ;
            " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+;
            " "+Tran( IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) + SPACE( 20 ) }))
   oTab:AUTOLITE:=.F.
   oTab:Dehilite()
   Whil .T.
      oTab:ColorRect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1})
      Whil NextKey()=0 .AND.! oTab:Stabilize()
      Enddo
      SetColor( _COR_GET_EDICAO )
      @ 01,02 Say "Fornecedor.: [" + StrZero( nCodFor, 6, 0 ) + "] - [" + cDescri + "]"
      @ 02,02 Say "Telefone...: [" + cFone1 + "]"
      @ 03,02 Say "Vendador...: [" + cVendador + "]"
      @ 04,02 Say "Responsavel: [" + cResponsavel + "]"
      @ 05,02 Say "������������������������������������������������������������������������������"
      @ 06,02 Say "Produto....: [" + MPR->DESCRI + " " + MPR->UNIDAD + "]"
      @ 07,02 Say "Cod.Fabrica: [" + MPR->CODFAB + "]"
      @ 08,02 Say "Fabricante.: [" + MPR->ORIGEM + "]"
      @ 09,02 Say "Saldo......: [" + Tran( MPR->SALDO_, "@E 999,999.9999" ) + "]"
      @ 10,02 Say "Preco......: [" + Tran( MPR->PRECOV, "@E 999,999.9999" ) + "]"
      SetColor( _COR_BROWSE )
      nTECLA:=inkey(0)
      If nTecla=K_ESC .OR. nTecla=K_ENTER
         Exit
      Endif
      Do Case
         Case nTECLA==K_UP         ;oTab:Up()
         Case nTECLA==K_DOWN       ;oTab:Down()
         Case nTECLA==K_PGUP       ;oTab:PageUp()
         Case nTECLA==K_PGDN       ;oTab:PageDown()
         Case nTECLA==K_CTRL_PGUP  ;oTab:GoTop()
         Case nTECLA==K_CTRL_PGDN  ;oTab:GoBottom()
         Case dbPesquisa( nTecla, oTab )
         Case nTecla==K_F2; DBMudaOrdem( 1, oTab )
         Case nTecla==K_F3; DBMudaOrdem( 2, oTab )
         Case nTecla==K_F4; DBMudaOrdem( 3, oTab )
         OtherWise
              EXIT
      EndCase
      oTab:RefreshCurrent()
      oTab:Stabilize()
   EndDo
EndDo
DBSelectAr( _COD_ESTOQUE )

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/estind01.ntx","&gdir/estind02.ntx","&gdir/estind03.ntx"
#else
  Set Index To "&GDIR\ESTIND01.NTX","&GDIR\ESTIND02.NTX","&GDIR\ESTIND03.NTX"
#endif
FechaArquivos()
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return (.T.)

/*
* Modulo      - Estoqueinc
* Finalidade  - Entrada/Saida de produtos (Inclusao)
* Programador - Valmor Pereira Flores
* Data        - 20/Outubro/1994
* Atualizacao -
*/
func EstoqueInc(lExporta)
LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),;
     nCURSOR:=setcursor()
Local aCorTamQua:= { { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } }
LOCAL GetList:= {}
LOCAL nCODPRO:=0,;
     cENTSAI:=" ",;
     nQUANT_:=0,;
     cDOC___:=spac(15),;
     nVALOR_:=0,;
     nCODIGO:=0,;
     dDATAMV:=date(),;
     cGrupo_:= Space( 3 ),;
     cCodigo:= Space( 4 ),;
     nMovEst:= 0,;
     cCliFor:= " ",;
     nNatOpe:= 0,;
     nVlrUni:= 0,;
     nPerIcm:= 0,;
     nPerIPI:= 0,;
     nVlrIcm:= 0,;
     nVlrIPI:= 0,;
     nVlrFre:= 0,;
     nClasse:= 0,;
     nTamCod:= 0,;
     nCorCod:= 0,;
     nTamQua:= 0,;
     cTemCor:= "N",;
     nQuantidade := 0,;
     cTipoMovimento:= " "
if lExporta == NIL
   lExporta := .f.
endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen()
IF !AbreGrupo( "ESTOQUE" )
   Return (.T.)
EndIf
DBSelectar( _COD_MPRIMA )
SetColor(COR[16])
SetCursor( 1 )
VPBox( 0, 0, 24-2, 79, " Movimento de Estoque " ,_COR_GET_BOX, .F., .F., _COR_GET_TITULO )
ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela")
WHILE LastKey() <> K_ESC

     nClasse:= 0
     nTamCod:= 0
     nCorCod:= 0
     nTamQua:= 0

     cClasse  := SPACE (40)
     cTamanho := SPACE (10)
     cCorDes  := SPACE (30)

     SetColor( _COR_GET_EDICAO )
     @ 02,03 Say "Produto......:" Get cGrupo_ Pict "999" Valid VerGrupo( ;
        cGrupo_, @cCodigo)
     @ 02,23 Say "-"

     @ 02,24 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList, ;
        @nClasse, @cTemCor, @nTamCod, @nCorCod, @nTamQua, @nQuantidade, ;
        @cClasse, @cTamanho, @cCorDes, @nQUANT_, @aCorTamQua, @nVlrUni ) ;
        when mensagem("Digite o c�digo do produto.")


//   @ 03,03 Say "Classe ......: [" + cClasse  + "]"
//   @ 02,33 Say "Cor .........: [" + cCorDes  + "]"
//   @ 03,33 Say "Tamanho .....: [" + cTamanho + "]"

     @ 03,03 Say "Descricao ...: [" + SPACE ( 55 ) + "]"
     @ 04,03 Say "Classe ......: [" + cClasse  + "]"
     @ 05,03 Say REPL( "�", 74 )

     @ 06,03 Say "Cod.Movimento:" Get nMovEst Pict "@R 99" ;
        Valid VerTabOperacoes( @nMovEst, @nNatOpe, @cEntSai, @cCliFor, ;
           @nClasse, @cTemCor, @nTamCod, @nCorCod, @cTipoMovimento )

     @ 07,03 Say "Nat.Operacao.:" Get nNatOpe Pict "@E 9.999"
     @ 08,03 say "Ent/Saida....:" Get cEntSai pict "!"  valid cENTSAI$"+-" when mensagem("Digite (+) para entradas ou (-) para saida.")
     @ 09,03 say "Documento....:" Get cDoc___ When Mensagem( "Digite o codigo do documento, numero da nota fiscal." )
     @ 10,03 say "Cli/Fornec...:" Get nCodigo pict "999999" ;
         Valid If(cCliFor="C",SeleCliente(@nCODIGO),SeleFornecedor(@nCODIGO)) ;
         When Mensagem("Digite o codigo do fornecedor ou cliente.")
     @ 11,03 say "Quantidade...:" Get nQuant_ pict "@E 9999999.9999" valid ;
        versaldo(nQUANT_,cENTSAI, cGrupo_, cCodigo ) ;
        When nClasse == 0 .AND. mensagem("Digite a quantidade.")
     @ 12,03 Say "Vlr. Unitario:" Get nVlrUni Pict "@E 999,999,999,999.99" Valid QuantxUni( nQuant_, nVlrUni, @nValor_ )
     @ 13,03 say "Valor........:" Get nValor_ pict "@E 999,999,999,999.99" when mensagem("Digite o valor desta Entrada/Saida.")
     @ 14,03 Say "% IPI........:" Get nPerIpi Pict "@E 99.99" Valid CalculoIpi( nValor_, nPerIpi, @nVlrIpi )
     @ 15,03 Say "Valor IPI....:" Get nVlrIpi Pict "@E 999,999,999.99"
     @ 16,03 Say "% ICMs.......:" Get nPerIcm Pict "@E 99.99" Valid CalculoIcm( nValor_, @nPerIcm, @nVlrIcm )
     @ 17,03 Say "Valor ICMs...:" Get nVlrIcm Pict "@E 999,999,999.99"
     @ 18,03 Say "Valor Frete..:" Get nVlrFre Pict "@E 999,999,999.99"
     @ 19,03 say "Data Entrada.:" Get dDataMv
     Read
     IF LastKey()==K_ESC
        EXIT
     ENDIF
     DbSelectAr(_COD_ESTOQUE)
     cTelaRes:= ScreenSave( 0, 0, 24, 79 )
     IF Confirma(10,63,"Confirma?","Digite [S] para confirmar este registro.","S")
        LancEstoque( cGrupo_ + cCodigo, cGrupo_ + cCodigo, cEntSai, cDoc___,;
                     nCodigo, 0, nValor_, nQuant_, nGCodUser, dDataMv,;
                     nVlrIcm, nVlrIpi, nVlrFre, nMovEst, nNatOpe, nPerICM, ;
                     nClasse, nTamCod, nCorCod, nTamQua, aCorTamQua, cTipoMovimento )
        DbSelectAr(_COD_MPRIMA)
     ENDIF
     ScreenRest( cTelaRes )
     if lExporta
        exit
     endif
ENDDO
dbunlockall()
FechaArquivos()
screenrest(cTELA)
setcursor(nCURSOR)
setcolor(cCOR)
Return (.T.)


Function QuantxUni( nQuant_, nVlrUni, nValor_ )
nValor_:= nQuant_ * nVlrUni
Return .T.

Function CalculoIpi( nValor_, nPerIpi, nVlrIpi )
nVlrIpi:= ( nValor_ * nPerIpi ) / 100
Return .T.

Function CalculoIcm( nValor_, nPerICM, nVlrICM )
IF MPR->SITT02 == 40
   nVlrICM:= 0
   nPerICM:= 0
ELSEIF MPR->SITT02 == 20
   RED->( DBSetOrder( 1 ) )
   RED->( DBSeek( MPR->TABRED ) )
   nBase:= nValor_ - ( ( nValor_ * RED->PERRED ) / 100 )
   nVlrICM:= ( nBase * nPerICM ) / 100
ELSE
   nVlrICM:= ( nValor_ * nPerICM ) / 100
ENDIF
Return .T.

/*****
�������������Ŀ
� Funcao      � vertabOperacoes
� Finalidade  � Busca tabela de operacoes
� Parametros  �
� Retorno     �
� Programador � Valmor Pereira Flores
� Data        �
���������������
*/
Static Function VerTabOperacoes( nMovEst, nNatOpe, cEntSai, cCliFor, ;
                                 nClasse, cTemCor, nTamCod, nCorCod, cTipoMovimento )
Local cTela:= ScreenSave( 0, 0, 24, 79 )
IF !LastKey() == K_UP
   TabelaOperacoes( @nMovEst )
   IF !LASTKEY()==K_ESC

      nNatOpe:= OPE->NATOPE

      cTipoMovimento:= OPE->ENTSAI
      IF cTipoMovimento $ "1/2/E/+"
         cEntSai:= "+"
      ELSEIF cTipoMovimento $ "3/4/S/-"
         cEntSai:= "-"
      ELSE
         cEntSai:= "*"
         Aviso( "Atencao! Voce esta usando uma operacao indevida." )
         Pausa()
         ScreenRest( cTela )
      ENDIF
      cCliFor:= OPE->CLIFOR
      CFO->( dbSetOrder( 1 ) )
      CFO->( dbSeek( nNatOpe ) )
      @ 06,40 Say "<-- " + LEFT (OPE->DESCRI, 34)
      @ 07,40 Say "<-- " + LEFT (CFO->DESCRI, 34)
      @ 08,40 Say "<-- " + IF( cEntSai == "-", "Saida   (-)", "Entrada (+)" )
         Keyboard Chr( K_ENTER ) + Chr( K_ENTER )
   ENDIF
ELSE
   nClasse:= 0
   nTamCod:= 0
   nCorCod:= 0
   nTamQua:= 0
   @ 03,19 Say SPACE( 55 )
   @ 04,19 Say SPACE( 40 )
ENDIF
Return .T.

/*
** Funcao      - ESTOQUEALT
** Finalidade  - Anular estoque
** Data        -
** Atualizacao -
*/
Stat Func EstoqueAlt()
LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),;
     nCURSOR:=setcursor()
Local oTBrowse, nTecla
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen()
IF !AbreGrupo( "ESTOQUE" )
   Return (.T.)
EndIf

     OPE->( DBSetOrder( 1 ) )
     DBSELECTAR(_COD_MPRIMA)
     DBSETORDER(1)
     DBSELECTAR(_COD_ESTOQUE)
     DBSETORDER(1)
     SET RELATION TO CPROD_ INTO MPR, CODMV_ INTO OPE

     DbSelectAr(_COD_ESTOQUE)
     DbSetOrder(1)
     VpBox( 00, 00, 13, 79, "MOVIMENTO DE ESTOQUE", _COR_GET_BOX, .f., .f. )
     VpBox( 14, 00, 22, 79, "Display", _COR_BROW_BOX, .F., .F. )
     DbGoTop()
     SetCursor(0)
     SetColor( _COR_BROWSE )
     Mensagem( "Digite [Data/Documento] para pesquisar ou [ESC] para sair." )
     Ajuda("["+_SETAS+"][PgUp][PgDn]Move [Codigo/Nome]Pesquisa [F3]Codigo [F4]Nome")
     DisplayEstoque( .T. )
     oTBROWSE:=TBrowseDb(16,01,21,78)
     oTBROWSE:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+" "+TRAN( cProd_, "@R 999-9999" )+;
              " "+if(ENTSAI="+","Entrada","Saida  ") + " " + StrZero( CODIGO, 6, 0) + ;
              " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+;
              " "+Tran(IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 9999999.99") + IF( Anular=="*", " Anulado", "        " ) }))
     oTBROWSE:AUTOLITE:=.F.
     oTBROWSE:Dehilite()
     Whil .T.
        oTBROWSE:ColorRect({oTBROWSE:ROWPOS,1,oTBROWSE:ROWPOS,1},{2,1})
        Whil NextKey()=0 .AND.! oTBROWSE:Stabilize()
        Enddo
        DisplayEstoque()
        nTECLA:=inkey(0)
        If nTECLA=K_ESC
           Exit
        Endif
        Do Case
           Case nTECLA==K_UP         ;oTBROWSE:Up()
           Case nTECLA==K_DOWN       ;oTBROWSE:Down()
           Case nTECLA==K_PGUP       ;oTBROWSE:PageUp()
           Case nTECLA==K_PGDN       ;oTBROWSE:PageDown()
           Case nTECLA==K_CTRL_PGUP  ;oTBROWSE:GoTop()
           Case nTECLA==K_CTRL_PGDN  ;oTBROWSE:GoBottom()
           Case Chr( nTecla ) == "*"
                IF netrlock() .AND. ANULAR == " "
                   Replace ANULAR With "*"
                   MPR->( DBSetOrder( 1 ) )
                   MPR->( DBSeek( EST->CPROD_ ) )
                   IF MPR->( netrlock() )
                      IF EST->ENTSAI == "+"
                         Replace MPR->SALDO_ With MPR->SALDO_ - EST->QUANT_,;
                                 MPR->SDOVLR With MPR->SDOVLR - EST->CUSMED,;
                                 MPR->CUSMED With MPR->SDOVLR / MPR->SALDO_
                         Replace MPR->CUSATU With MPR->CUSMED
                      ELSE
                         Replace MPR->SALDO_ With MPR->SALDO_ + EST->QUANT_,;
                                 MPR->SDOVLR With MPR->SDOVLR + EST->VLRSAI,;
                                 MPR->CUSMED With MPR->SDOVLR / MPR->SALDO_
                         Replace MPR->CUSATU With MPR->CUSMED
                      ENDIF
                   ENDIF
                ENDIF
                DBUnlockAll()
           Case dbPesquisa( nTecla, oTBrowse )
           Case nTecla==K_F2; DBMudaOrdem( 1, oTbrowse )
           Case nTecla==K_F3; DBMudaOrdem( 2, oTBrowse )
           Case nTecla==K_F4; DBMudaOrdem( 3, oTBrowse )
           OtherWise                 ;Tone(125);tone(300)
        EndCase
        oTBROWSE:RefreshCurrent()
        oTBROWSE:Stabilize()
     EndDo
     SetCursor(nCURSOR)
   dbunlockall()
   FechaArquivos()
   screenrest(cTELA)
   setcursor(nCURSOR)
   setcolor(cCOR)
   Return (.T.)

/*
** Funcao      - ESTOQUEVER
** Finalidade  - Verificacao do cadastro de estoque
** Data        -
** Atualizacao -
*/
Stat Func EstoqueV3()
LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),;
     nCURSOR:=setcursor()
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen()
IF !AbreGrupo( "ESTOQUE" )
   Return (.T.)
EndIf

     OPE->( DBSetOrder( 1 ) )
     DBSELECTAR(_COD_MPRIMA)
     DBSETORDER(1)
     DBSELECTAR(_COD_ESTOQUE)
     DBSETORDER(1)
     SET RELATION TO CPROD_ INTO MPR, CODMV_ INTO OPE

     DbSelectAr(_COD_ESTOQUE)
     DbSetOrder(1)
     VpBox( 00, 00, 13, 79, "MOVIMENTO DE ESTOQUE", _COR_GET_BOX, .f., .f. )
     VpBox( 14, 00, 22, 79, "Display", _COR_BROW_BOX, .F., .F. )
     DbGoTop()
     SetCursor(0)
     SetColor( _COR_BROWSE )
     Mensagem( "Digite [Data/Documento] para pesquisar ou [ESC] para sair." )
     Ajuda("["+_SETAS+"][PgUp][PgDn]Move [Codigo/Nome]Pesquisa [F3]Codigo [F4]Nome")
     DisplayEstoque( .T. )
     oTBROWSE:=TBrowseDb(16,01,21,78)
     oTBROWSE:AddColumn(TbColumnNew(,{|| Dtoc(DATAMV)+" "+TRAN( cProd_, "@R 999-9999" )+;
              " "+if(ENTSAI="+","Entrada","Saida  ")+" "+StrZero( CODIGO, 6, 0 )+;
              " "+DOC___+" "+Tran(QUANT_,"@E 9999,999.999")+;
              " "+Tran(IF( VALOR_==0, VLRSAI, VALOR_ ),"@E 999999.999") + IF( Anular=="*", " Anulado", "        " ) }))
     oTBROWSE:AUTOLITE:=.F.
     oTBROWSE:Dehilite()
     Whil .T.
        oTBROWSE:ColorRect({oTBROWSE:ROWPOS,1,oTBROWSE:ROWPOS,1},{2,1})
        Whil NextKey()=0 .AND.! oTBROWSE:Stabilize()
        Enddo
        DisplayEstoque()
        nTECLA:=inkey(0)
        If nTECLA=K_ESC
           Exit
        Endif
        Do Case
           Case nTECLA==K_UP         ;oTBROWSE:Up()
           Case nTECLA==K_DOWN       ;oTBROWSE:Down()
           Case nTECLA==K_PGUP       ;oTBROWSE:PageUp()
           Case nTECLA==K_PGDN       ;oTBROWSE:PageDown()
           Case nTECLA==K_CTRL_PGUP  ;oTBROWSE:GoTop()
           Case nTECLA==K_CTRL_PGDN  ;oTBROWSE:GoBottom()
           Case dbPesquisa( nTecla, oTBrowse )
           Case nTecla==K_F2; DBMudaOrdem( 1, oTBrowse )
           Case nTecla==K_F3; DBMudaOrdem( 2, oTBrowse )
           Case nTecla==K_F4; DBMudaOrdem( 3, oTBrowse )
           Case nTecla==K_CTRL_DEL
                nOperacao:=   CODMV_
                nFornecedor:= CODIGO
                cDocumento:=  DOC___
                dData:=       DATAMV
                Keyboard Chr( K_RIGHT )
                IF SWAlerta( "<< EXCLUSAO MULTIPLA >>;Deseja excluir registros semelhantes?", {"Confirma","Cancela"} )==1
                   IF SWAlerta( "<< EXCLUSAO MULTIPLA >>;Voce est� certo desta operacao?", {"Confirma","Cancela"} )==1
                      nOrdemRes:= IndexOrd()
                      DBSetOrder( 2 )
                      DBSeek( dData, .T. )
                      Mensagem( "Buscando informacoes identicas, aguarde..." )
                      WHILE DATAMV==dData
                           Inkey()
                           IF LastKey()==K_ESC .OR. NextKey()==K_ESC
                              IF SWAlerta( "<< ABANDONAR >>;Deseja abandonar a operacao?", {"Confirma","Cancela"} )==1
                                 EXIT
                              ENDIF
                           ENDIF
                           IF nOperacao == CODMV_ .AND.;
                              nFornecedor == CODIGO .AND.;
                              cDocumento == DOC___ .AND.;
                              dData == DATAMV
                              IF netrlock()
                                 IF ENTSAI="+"
                                    TiraDoEstoque( EST->CPROD_, QUANT_ )
                                 ELSE
                                    PoeNoEstoque( EST->CPROD_, QUANT_ )
                                 ENDIF
                              ENDIF
                              IF netrlock()
                                 DBDelete()
                              ENDIF
                              oTBrowse:RefreshAll()
                              WHILE !oTBrowse:Stabilize()
                              ENDDO
                           ENDIF
                           DBSkip()
                      ENDDO
                      Mensagem( "Operacao concluida." )
                      DBSetOrder( nOrdemRes )
                      oTBrowse:RefreshAll()
                      WHILE !oTBrowse:Stabilize()
                      ENDDO
                   ENDIF
                ENDIF

           Case nTecla==K_DEL
                IF SWAlerta( "<< EXCLUSAO >>;Deseja excluir este registro?", {"Confirma","Cancela"} )==1
                   IF netrlock()
                      nOperacao:=   CODMV_
                      nFornecedor:= CODIGO
                      cDocumento:=  DOC___
                      MPR->( DBSetOrder( 1 ) )
                      IF ENTSAI="+"
                         TiraDoEstoque( EST->CPROD_, QUANT_ )
                      ELSE
                         PoeNoEstoque( EST->CPROD_, QUANT_ )
                      ENDIF
                      DBDelete()
                      oTBrowse:RefreshAll()
                      WHILE !oTBrowse:Stabilize()
                      ENDDO
                   ENDIF
                ENDIF
           OtherWise                 ;Tone(125);tone(300)
        EndCase
        oTBROWSE:RefreshCurrent()
        oTBROWSE:Stabilize()
     EndDo
     SetCursor(nCURSOR)
dbunlockall()
FechaArquivos()
screenrest(cTELA)
setcursor(nCURSOR)
setcolor(cCOR)
Return (.T.)

/*
** Funcao      - VERSALDO
** Finalidade  - Verificar a situacao do estoque apos lancamento de saida.
** Programador - Valmor Pereira Flores
** Data        - 26/Marco/1995
** Atualizacao - 28/Marco/1995 - Quarta-feira
*/
Stat Func VerSaldo(QUANTIDADE,ENTSAI, cGrupo_, cCodigo)
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, 79 )
  LOCAL nAREA:=Select(), nORDEM:=IndexOrd()
  LOCAL cProduto, aProdutos:= {}, lReturn:= .T.

  If ENTSAI="-"
     DbSelectAr(_COD_MPRIMA)
     dbSetOrder(3)
     If SALDO_-QUANTIDADE<0
        Aviso("ATENCAO! Sdo. produto ficara negativo...",24/2)
        Pausa()
     ElseIf SALDO_-QUANTIDADE<ESTMIN
        Aviso("ATENCAO! Sdo. do produto ficara abaixo do estoque permitido...",24/2)
        Pausa()
     EndIf
  Endif
  DBSelectAr( _COD_MPRIMA )
  IF cGrupo_ <> NIL .AND. cCodigo <> NIL
     IF MPR->MPRIMA=="N"
        cProduto:= cGrupo_ + cCodigo + Space( 12 - Len( cGrupo_ + cCodigo ) )
        DBSelectAr( _COD_ASSEMBLER )
        IF DBSeek( cProduto )
           nRegistro:= Recno()
           WHILE cProduto == ASM->CODPRD
               DBSelectAr( _COD_MPRIMA )
               DBSetOrder( 1 )
               IF DBSeek( ASM->CODMPR )
                  IF ( MPR->SALDO_ - ( QUANTIDADE * ASM->QUANT_ ) ) <= 0
                     AAdd( aProdutos, { Alltrim( MPR->INDICE ), MPR->CODFAB, Left( MPR->DESCRI, 30 ), MPR->SALDO_, ASM->QUANT_ * QUANTIDADE, MPR->UNIDAD, "15/04" } )
                  ELSE
                     AAdd( aProdutos, { Alltrim( MPR->INDICE ), MPR->CODFAB, Left( MPR->DESCRI, 30 ), MPR->SALDO_, ASM->QUANT_ * QUANTIDADE, MPR->UNIDAD, "15/01" } )
                  ENDIF
               ENDIF
               ASM->( DBSkip() )
           ENDDO
           DBGoto( nRegistro )
           IF Len( aProdutos ) > 0
              VPBox( 00,00,22,79, "Saldos necessarios p/ lancamento deste produto no estoque" )
              nLin:=02
              @ nLin,01 Say "Codigo  Cod.Fab      Produto                        Saldo       Qtd.Necessaria"
              FOR nCt:= 1 TO Len( aProdutos )
                  IF aProdutos[nCt][4] < aProdutos[nCt][5]
                     lReturn:= .F.
                  ENDIF
                  SetColor( aProdutos[nCt][7] )
                  @ ++nLin,01 say aProdutos[nCt][1] + " " + aProdutos[nCt][2] + " " + aProdutos[nCt][3] + " " + Tran( aProdutos[nCt][4], "@E 999,999.999" ) +;
                                  " " + Tran( aProdutos[nCt][5], "@E 999,999.999" ) + " " + aProdutos[nCt][6]
              NEXT
              IF !lReturn
                  Mensagem("A materia-prima para movimentar este produto esta em falta." )
                  Pausa()
              ELSE
                  Mensagem( "Esta quantidade podera ser produzida/embalada pois estoque esta ok." )
                  Pausa()
              ENDIF
           ENDIF
        ENDIF
     ENDIF
  ENDIF
  DbSelectAr(nAREA)
  DbSetOrder(nORDEM)
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return( lReturn )

/*
** Funcao      - SELECLIENTE
** Finalidade  - Selecionar clientes apartir do cadastro.
** Programador - Valmor Pereira Flores
** Data        -
** Atualizacao -
*/
Stat Func SeleCliente( nCodigo )
  If LastKey()=K_UP
     Return(.T.)
//ElseIf nCODIGO=0
//   Return(.F.)
  EndIf
  PesqCli( @nCodigo )
  @ 10,40 SAY "<-- " + LEFT (CLI->DESCRI, 34)
  Return .T.


/*
** Funcao      - SELEFORNECEDOR
** Finalidade  - Selecionar Fornecedores apartir do cadastro.
** Programador - Valmor Pereira Flores
** Data        -
** Atualizacao -
*/
Stat Func SeleFornecedor(nCODIGO)
  If LastKey()=K_UP
     Return(.T.)
//ElseIf nCODIGO=0
//   Return(.F.)
  EndIf
  ForSeleciona( @nCodigo )
  @ 10,40 SAY "<-- " + LEFT (FOR->DESCRI, 34)
  Return .T.


/*****
�������������Ŀ
� Funcao      � VerGrupo
� Finalidade  � Pesquisar um grupo especifico.
� Parametros  � cGrupo_ => Codigo do grupo
� Retorno     � cCodigo => Codigo do produto a ser retornado.
� Programador � Valmor Pereira Flores
� Data        � 04/Dezembro/1995
���������������
*/
Static Function VerGrupo( cGrupo_, cCodigo )

   LOCAL nArea:= Select(), nOrdem:= IndexOrd()
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(), nCt

   If cGrupo_ == Left( MPr->Indice, 3 )
      Return( .T. )
   EndIf

   DBSetOrder( 1 )

   DBSeek( cGrupo_, .T. )

   If cGrupo_ == Left( MPr->Indice, 3 )
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 )
   Else
      cCodigo:= "0001"
   EndIf

   DBSetOrder( nOrdem )

// SetColor( "15/01" )

// @ 02,31 Say LEFT (MPr->Descri, 40)
// @ 03,03 Say "[" + MPr->Descri + "]"

// SetColor( _COR_GET_EDICAO )
// @ 03,19 Say MPr->Descri

   SetColor( cCor )
   SetCursor( nCursor )

Return(.T.)

/*****
�������������Ŀ
� Funcao      � VerCodigo
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio
� Retorno     �
� Programador � Valmor Pereira Flores
� Data        � 04/Dezembro/1995
���������������
*/
Static Function VerCodigo( cCodigo, GetList, nClasse, cTemCor, nTamCod, ;
                           nCorCod, nTamQua, nQuantidade, cClasse, cTamanho, ;
                           cCorDes, nQUANT_, aCorTamQua, nVlrUni )
   LOCAL cGrupo_:= GetList[ 1 ]:VarGet()
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 )
   LOCAL nArea:= Select()
   LOCAL nOrdem:= IndexOrd(), nCt:= 0
   If LastKey()==K_UP .OR. LastKey()==K_ESC
      Return( .T. )
   EndIf
   DBSelectar( _COD_MPRIMA )
   DBSetOrder( 1 )
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) )
      Ajuda("[Enter]Continua")
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 )
      Mensagem( "Pressione qualquer tecla para ver lista..." )
      VisualProdutos( cGrupo_ + cCodigo )
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
   EndIf
   If LastKey() == K_ESC
      Return( .F. )
   EndIf

   nClasse := MPR -> PCPCLA
   cTemCor := IIF (MPR -> PCPCSN == "S", "S", "N")

   fSelecTamCor (@nClasse, @nTamCod, @nCorCod, @nTamQua, "EST", ;
      @nQuantidade, cTemCor, @aCorTamQua )
   nQUANT_ := nQuantidade

   fAcessaTamCor (nClasse, nTamCod, nCorCod, @cClasse, @cTamanho, @cCorDes, cTemCor)

//   @ 03,03 Say "Classe ......: [" + cClasse  + "]"
//   @ 04,03 Say "Cor .........: [" + cCorDes  + "]"
//   @ 05,03 Say "Tamanho .....: [" + cTamanho + "]"

     @ 03,03 Say "Descricao ...: [" + SPACE ( 55 ) + "]"
     @ 04,03 Say "Classe ......: [" + cClasse  + "]"
     @ 05,03 Say REPL( "�", 74 )

   PXF->( DBSetOrder( 1 ) )
   IF PXF->( DBSeek( MPR->INDICE ) )
      nVlrUni:= PXF->VALOR_
   ENDIF

   GetList[1]:VarPut( Left( MPr->Indice, 3 ) )
   GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) )
   For nCt:=1 To Len( GetList )
       GetList[ nCt ]:Display()
   Next
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )

// SetColor( "15/01" )

// @ 02,31 Say LEFT (MPr->Descri, 40)
// @ 03,03 Say "[" + MPr->Descri + "]"

   SetColor( _COR_GET_EDICAO )
   @ 03,19 Say MPr->Descri
   SetColor( cCor )

Return( .T. )


/*****
�������������Ŀ
� Funcao      � Pesquisa
� Finalidade  � Pesquisar o codigo do produto no banco de dados.
� Parametros  � cCodigo => Codigo do Produto
� Retorno     � .F.>Nao encontrou / .T.>Encontrou
� Programador � Valmor Pereira Flores
� Data        � 29/Novembro/1995
���������������
*/
Static Function Pesquisa( cCodigo )
LOCAL nArea:= Select(), nOrdem:= IndexOrd(), lResultado

   DBSelectAr( _COD_MPRIMA )
   DBSetOrder( 1 )
   lResultado:= DBSeek( cCodigo )
   DBSelectar( nArea )
   DBSetOrder( nOrdem )

   Return( lResultado )

/*****
�������������Ŀ
� Funcao      � DISPLAYESTOQUE
� Finalidade  � Apresentar os dados do registro setado no momento
� Parametros  � lTela=> Se for para exibir (.T.)Tela (.F.)Dados
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        � 20/Janeiro/1996
� Atualizacao � 21/Janeiro/1996
���������������
*/
FUNCTION DisplayEstoque( lTela )
   LOCAL cCor:= SetColor()
   LOCAL cCodPro:= CProd_, nQtdAnt:= Quant_, cEntSai:= EntSai,;
         nQuant_:= Quant_, cDoc___:= Doc___, nValor_:= IF( VALOR_==0, VLRSAI, VALOR_ ),;
         nCodigo:= Codigo, dDataMv:= DataMv
   PRIV cClasse
   lTela:= IF( Empty( lTela ), .F., .T. )

   /* Se o parametro lTela for verdadeiro, monta a tela */
   IF lTela
      CLI->( DBSetOrder( 1 ) )
      FOR->( DBSetOrder( 1 ) )
      SetColor( _COR_BROW_LETRA )
      @ 15,02 Say Spac(76)
      @ 15,02 Say "Data    Produto  Ent/Sai CL/For Documento       Quantidade   Valor       "
   ELSE
      SetColor( _COR_GET_LETRA )
      @ 01,02 say "Codigo.....: [" + Tran( Left( cCodPro, 7 ), "@R XXX-XXXX" ) + "]"
      @ 02,02 Say "Produto....: [" + MPr->Descri + "]"
      @ 03,02 Say "Cod.Fabrica: [" + MPr->CODFAB + "]"
      @ 04,02 Say "Operacao...: [" + StrZero( CODMV_, 3, 0 ) + "]"
      @ 05,02 say "Ent/Saida..: [" + cEntSai + "]"
      @ 06,02 say "Cli/Fornec.: [" + Tran( nCodigo, "999999" ) + "]"
      @ 07,02 say "Documento..: [" + cDoc___ + "]"
      @ 08,02 say "Quantidade.: [" + Tran( nQuant_, "@E 9999999.99" ) + "]"
      @ 09,02 say "Valor......: [" + Tran( nValor_, "@E 999,999,999,999.99" ) + "]"
      @ 10,02 say "Data.......: [" + DtoC( dDataMv ) + "]"
      @ 11,02 Say "Custo Medio: [" + Tran( CUSATU, "@E 999,999,999.9999" ) + "]"
      @ 12,02 Say "Situacao...: [" + IF( MPR->Saldo_ < MPR->EstMin - 1, "MENOR QUE MINIMO ", "NORMAL           " ) + "]"
      SetColor( "14/" + SubStr( _COR_GET_EDICAO, AT( "/", _COR_GET_EDICAO ) + 1, 02 ) )
      COR->( DBSetOrder( 1 ) )
      CLA->( DBSetOrder( 1 ) )
      COR->( DBSeek( EST->PCPCOR ) )
      CLA->( DBSeek( EST->PCPCLA ) )
      IF !( EST->PCPTAM == 0 ) .AND. EST->PCPTAM <= 10
         cClasse:= StrZero( EST->PCPTAM, 2, 0 )
         Scroll( 03, 35, 08, 78 )
         @ 03,35 Say LEFT( CLA->DESCRI, 18 ) + " " + LEFT( COR->DESCRI, 18 ) + " <" + Alltrim( CLA->TAMA&cClasse ) + ">"
      ENDIF
      @ 04,35 Say LEFT( OPE->DESCRI, 40 )
      @ 05,35 Say IF( cEntSai=="+", "ENTRADA  ", "SAIDA    " )
      CLI->( DBSeek( nCodigo ) )
      FOR->( DBSeek( nCodigo ) )
      @ 06,31 Say IF( OPE->CLIFOR=="C", CLI->DESCRI, FOR->DESCRI )
      @ 09,55 Say "��Calculo de ImpostosĿ"
      @ 10,55 Say "� ICMs - " + Tran( VLRICM, "@E 9,999,999.99" ) + " �"
      @ 11,55 Say "� IPI  - " + Tran( VLRIPI, "@E 9,999,999.99" ) + " �"
      @ 12,55 Say "�����������������������"
   ENDIF
   SetColor( cCor )
   Return (.T.)

/*****
�������������Ŀ
� Funcao      � ESTOQUEV7
� Finalidade  � Pesquisa de movimentos de saida diversos
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor P.Flores
� Data        �
���������������
*/
Function EstoqueV7()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nTecla, nOpcao:= 0, nArea:= Select()
Local nCliente:= nFornecedor:= 999999

  VPBox( 0, 0, 22, 79, "RELACAO DETALHADA DE ENTRADAS / SAIDAS", _COR_BROW_BOX )
  SetColor( _COR_BROWSE )
  @ 03,03 Prompt "1 Compras + Outras Entradas       "
  @ 04,03 Prompt "2 Vendas  + Outras Saidas         "
  @ 05,03 Prompt "3 Vendas                          "
  @ 06,03 Prompt "4 Compras                         "
  @ 07,03 Prompt "5 Todas as Movimentacoes          "
  menu to nOpcao

  IF LastKey()==K_ESC
     Return Nil
  ENDIF
  IF nOpcao==3
     @ 09,03 Say "Codigo do Cliente...:" Get nCliente    Pict "@R 999999"
     READ
  ELSEIF nOpcao==4
     @ 09,03 Say "Codigo do Fornecedor:" Get nFornecedor Pict "@R 999999"
     READ
  ENDIF

  IF nOpcao==1 .OR. nOpcao==2 .OR. nOpcao==3 .OR.;
     nOpcao==4 .OR. nOpcao==5
     DBSelectAr( _COD_GRUPO )
     VPBox( 10, 02, 20, 50, "GRUPOS DE PRODUTOS", _COR_BROW_BOX )
     oTBROWSE:=TBrowseDb( 11, 03, 19, 49 )
     oTBROWSE:AddColumn( TbColumnNew(, {|| CODIGO + " " + LEFT( DESCRI, 30 ) + " " + SELECT } ) )
     oTBROWSE:AUTOLITE:=.F.
     oTBROWSE:Dehilite()
     Whil .T.
        oTBROWSE:ColorRect({oTBROWSE:ROWPOS,1,oTBROWSE:ROWPOS,1},{2,1})
        Whil NextKey()=0 .AND.! oTBROWSE:Stabilize()
        Enddo
        nTECLA:=inkey(0)
        If nTECLA=K_ESC
           Exit
        Endif
        Do Case
           Case nTECLA==K_UP         ;oTBROWSE:Up()
           Case nTECLA==K_DOWN       ;oTBROWSE:Down()
           Case nTECLA==K_PGUP       ;oTBROWSE:PageUp()
           Case nTECLA==K_PGDN       ;oTBROWSE:PageDown()
           Case nTECLA==K_CTRL_PGUP  ;oTBROWSE:GoTop()
           Case nTECLA==K_CTRL_PGDN  ;oTBROWSE:GoBottom()
           Case dbPesquisa( nTecla, oTBrowse )
           Case nTecla==K_F2; DBMudaOrdem( 1, oTbrowse )
           Case nTecla==K_F3; DBMudaOrdem( 2, oTbrowse )
           Case nTecla==K_F4; DBMudaOrdem( 3, oTbrowse )
           Case nTecla==K_SPACE
                IF netrlock()
                   Replace SELECT With IF( SELECT=="Sim", "Nao", "Sim" )
                ENDIF
           Case nTecla==K_DEL
                IF SWAlerta( "<< EXCLUSAO >>;Deseja excluir este registro?", {"Confirma","Cancela"} )==1
                   IF netrlock()
                      DBDelete()
                   ENDIF
                ENDIF
           OtherWise                 ;Tone(125);tone(300)
        EndCase
        oTBROWSE:RefreshCurrent()
        oTBROWSE:Stabilize()
     EndDo
     SetCursor(nCURSOR)
  ENDIF

  dbunlockall()
  FechaArquivos()
  screenrest(cTELA)
  setcursor(nCURSOR)
  setcolor(cCOR)
  Return (.T.)














/*****
�������������Ŀ
� Funcao      � ESTOQUEV6
� Finalidade  � Visualizacao do LOG do Ultimo Estoque Calculado
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor P.Flores
� Data        �
���������������
*/
Function EstoqueV6()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nTecla, nOpcao:= 0, nArea:= Select()
Local nRow:= 1, TECLA

   IF !File( "ESTLOG.TXT" )
      Aviso( "Nao foi efetuado calculo de custo medio neste computador." )
      Pausa()
      ScreenRest( cTela )
      Return Nil
   ENDIF

   SWGravar( 600 )
   aStr:= { { "ORIGEM", "C", 200, 00 } }
   DBCreate( "TEMP.TMP", aStr )
   DBSelectAR( 124 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   USE TEMP.TMP Alias TMP
   Append From ESTLOG.TXT SDF
   DBGoTop()
   cFile:= "ESTLOG.TXT"
   IF !FILE( cFile )
      Aviso( "Arquivo nao Encontrado." )
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Return Nil
   ENDIF
   DBSelectAr( 123 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use ESTOQUE.INF Alias ES
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On INDICE To IN002930.NTX
   DBGoTop()

// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen()
   VPBox( 0, 0, 23, 79, " SELECAO DE PRODUTOS ", _COR_BROW_BOX, .F., .F. )
   SetColor( _COR_BROWSE )
   oTb:= TBrowseDB( 01, 01, 21, 78 )
   oTb:addcolumn(tbcolumnnew(,{|| Alltrim( INDICE ) + " " + LEFT( DESCRI, 39 ) + Tran( SATQTD, "@E 999,999.99" ) + Tran( CUSMED, "@E 999,999.999" ) + Tran( SATVLR, "@E 999,999.999" ) + Tran( SAIVLR, "@E 999,999.99" ) }))
   oTb:AUTOLITE:=.f.
   oTb:dehilite()
   lDelimiters:= Set( _SET_DELIMITERS, .F. )
   WHILE .T.
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
      WHILE nextkey()==0 .and. ! oTb:stabilize()
      ENDDO
      nTecla:= Inkey(0)
      IF nTecla==K_ESC
         nOpcao:= 0
         exit
      ENDIF
      DO CASE
         CASE nTecla==K_UP         ;oTb:up()
         CASE nTecla==K_DOWN       ;oTb:down()
         CASE nTecla==K_LEFT       ;oTb:up()
         CASE nTecla==K_RIGHT      ;oTb:down()
         CASE nTecla==K_PGUP       ;oTb:pageup()
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop()
         CASE nTecla==K_PGDN       ;oTb:pagedown()
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom()
         CASE nTecla==K_F12        ;Calculador()
         case nTecla==K_CTRL_F10   ;Calendar()
         CASE DBPesquisa( nTecla, oTb )
         CASE nTecla==K_TAB
              IF Confirma( 0, 0, "Deseja imprimir um inventario?", "S" )
                 Relatorio( "INVENTAR.REP" )
              ENDIF
         CASE nTecla==K_ENTER
              VisualResumo( ES->INDICE )
     ENDCASE
     oTb:RefreshCurrent()
     WHILE !oTb:Stabilize()
     ENDDO
  ENDDO
  DBSelectAr( 124 )
  DBCloseArea()
  Set( _SET_DELIMITERS, lDelimiters )
  dbunlockall()
  DBCloseArea()
  DBSelectAr( nArea )
  FechaArquivos()
  DBCloseAll()
  AbreGrupo( "TODOS_OS_ARQUIVOS" )
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return Nil




  Function VisualResumo( cIndice )
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
  Local oTb, nTecla
  Local nArea:= Select()

   aStr:= { { "CODPRO", "C", 12, 00 },;
            { "DATA__", "D", 08, 00 },;
            { "ENTQTD", "N", 16, 03 },;
            { "ENTVLR", "N", 16, 02 },;
            { "SAIQTD", "N", 16, 03 },;
            { "SAIVLR", "N", 16, 02 },;
            { "SDOQTD", "N", 16, 03 },;
            { "SDOVLR", "N", 16, 02 },;
            { "CUSMED", "N", 16, 03 } }

   IF !FILE( "TEMPOR.DBF" )
      DBCreate( "TEMPOR.DBF", aStr )
      DBSelectAr( 125 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Use TEMPOR.DBF Alias RES
      DBSelectAR( 124 )
      cProduto:= ""
      dbGoTop()
      WHILE !EOF()
         IF ALLTRIM( ORIGEM )=="PRODUTO"
            DBSkip()
            cProduto:= SubStr( ORIGEM, 1, 12 )
         ELSE
            RES->( DBAppend() )
            Replace RES->CODPRO With cProduto,;
                    RES->DATA__ With CTOD( SubStr( ORIGEM, 1, 8 ) ),;
                    RES->ENTQTD With StrToNum( SubStr( ORIGEM,  9, 11 ) ),;
                    RES->ENTVLR With StrToNum( SubStr( ORIGEM, 20, 11 ) ),;
                    RES->SAIQTD With StrToNum( SubStr( ORIGEM, 42, 11 ) ),;
                    RES->SAIVLR With StrToNum( SubStr( ORIGEM, 53, 11 ) ),;
                    RES->SDOQTD With StrToNum( SubStr( ORIGEM, 75, 11 ) ),;
                    RES->SDOVLR With StrToNum( SubStr( ORIGEM, 86, 11 ) ),;
                    RES->CUSMED With StrToNum( SubStr( ORIGEM, 97, 12 ) )
         ENDIF
         DBSkip()
      ENDDO
   ELSE
      DBSelectAr( 125 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Use TEMPOR.DBF Alias RES
   ENDIF
   nCusMed:=  ES->CUSMED
   nSaldoAQ:= ES->SATQTD
   nSaldoAV:= ES->SATVLR
   nSaldoIV:= ES->SDOVLR
   nSaldoIQ:= ES->SDOQTD
   nCusAnt:=  ES->CUSANT
   nEntQtd:=  ES->ENTQTD
   nEntVlr:=  ES->ENTVLR
   nSaiQtd:=  ES->SAIQTD + ES->OS_QTD
   nSaiVlr:=  ES->SAIVLR + ES->OS_VLR

   DBSelectAr( 125 )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   INDEX ON DATA__ TO IN91239 FOR CODPRO==cIndice .AND. !EMPTY( DATA__ ) EVAL {|| Processo() }
   DBGoTop()

   nEnt___:= 0
   nSai___:= 0
   while !eof()
        nEnt___:= nEnt___ + ENTVLR
        nSai___:= nSai___ + SAIVLR
        dbskip()
   enddo
   dbGoTop()

   MPR->( DBSetOrder( 1 ) )
   MPR->( DBSeek( cIndice ) )

   VPBox( 00, 00, 24, 79, ALLTRIM( MPR->DESCRI ), _COR_GET_BOX )
   SetColor( _COR_GET_EDICAO )

   @ 01,01 Say "       E N T R A D A S         S A I D A S            S A L D O          CUSTO" Color "00/03"
   @ 02,01 Say "DIA QUANTIDADE      VALOR QUANTIDADE      VALOR QUANTIDADE      VALOR    MEDIO" Color "00/03"

   @ 03,01 Say "Saldo Inicial ��������������������������������� " + ;
                              Tran( nSaldoIQ, "@E 99,999.999" ) + " " + ;
                              Tran( nSaldoIV, "@E 999,999.99" ) + Tran( nCusAnt, "@E 9,999.999" ) Color "15/" + CorFundoAtual()
   @ 22,01 Say "Saldo Atual ����������������������������������� " + ;
                              Tran( nSaldoAQ, "@E 99,999.999" ) + " " + ;
                              Tran( nSaldoAV, "@E 999,999.99" ) + Tran( nCusMed, "@E 9,999.999" ) Color "15/" + CorFundoAtual()
   @ 23,30 Say "[G]=Grafico de Movimentacoes [R]=Resumo"

   @ 22, 16 Say Tran( nEnt___, "@E 999,999.99" )
   @ 22, 38 Say Tran( nSai___, "@E 999,999.99" )

   SetColor( _COR_BROWSE )
   oTb:= TBrowseDB( 04, 01, 21, 78 )
   oTb:addcolumn(tbcolumnnew(,{|| LEFT( DTOC( DATA__ ), 2 ) + "  " + ;
                                 TRAN( ENTQTD, "@EZ 99,999.999" ) + ;
                                 TRAN( ENTVLR, "@EZ 9999,999.99" ) + ;
                                 TRAN( SAIQTD, "@EZ 999,999.999" ) + ;
                                 TRAN( SAIVLR, "@EZ 9999,999.99" ) + ;
                                 TRAN( SDOQTD, "@EZ 999,999.999" ) + ;
                                 TRAN( SDOVLR, "@EZ 9999,999.99" ) + ;
                                 TRAN( CUSMED, "@EZ 9,999.999" ) } ) )

   oTb:AUTOLITE:=.f.
   oTb:dehilite()
   lDelimiters:= Set( _SET_DELIMITERS, .F. )
   WHILE .T.
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
      WHILE nextkey()==0 .and. ! oTb:stabilize()
      ENDDO
      @ 23,01 Say Pad( MES( MONTH( DATA__ ) ) + "/" + StrZero( YEAR( DATA__ ), 4, 0 ), 15 ) Color _COR_GET_EDICAO
      nTecla:= Inkey(0)
      IF nTecla==K_ESC
         nOpcao:= 0
         exit
      ENDIF
      DO CASE
         CASE nTecla==K_UP         ;oTb:up()
         CASE nTecla==K_DOWN       ;oTb:down()
         CASE nTecla==K_LEFT       ;oTb:up()
         CASE nTecla==K_RIGHT      ;oTb:down()
         CASE nTecla==K_PGUP       ;oTb:pageup()
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop()
         CASE nTecla==K_PGDN       ;oTb:pagedown()
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom()
         CASE nTecla==K_F12        ;Calculador()
         case nTecla==K_CTRL_F10   ;Calendar()
         CASE Chr( nTecla ) $ "Rr"
              ViewResumo()
         CASE Chr( nTecla ) $ "Gg"
              ViewGrafico()
         CASE DBPesquisa( nTecla, oTb )
     ENDCASE
     oTb:RefreshCurrent()
     WHILE !oTb:Stabilize()
     ENDDO
  ENDDO
  ScreenRest( cTela )
  SetColor( cCor )
  SetCursor( nCursor )
  DBSelectAr( 125 )
  DBCloseArea()
  DBSelectAr( nArea )
  Return Nil



Function StrToNum( cNumero )
  cNumero:= StrTran( cNumero, ",", "x" )
  cNumero:= StrTran( cNumero, ".", "" )
  cNumero:= StrTran( cNumero, "x", "." )
  Return Val( cNumero )


Static Function ViewResumo()
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
  Local nReg:= RECNO()
  Local nTotEnt:= nTotSai:= nTotSdo:= 0
  Local cTitulo, nUltimo
  Local aQtd:= {}, nPos:= 1

  FOR nCt:= 1 TO LastDay( DATA__ )
     AAdd( aQtd, { 0, 0, 0 } )
  NEXT
  DBGoTop()

  /* Saldo Inicial */
  aQtd[ 1 ][ 3 ]:= ES->SDOQTD

  /* Soma em Totais */
  WHILE !EOF()
      nTotEnt:= nTotEnt + ENTQTD
      nTotSai:= nTotSai + SAIQTD
      nTotSdo:= nTotSdo + SDOQTD
      aQtd[ DAY( DATA__ ) ][ 1 ]:= aQtd[ DAY( DATA__ ) ][ 1 ] + ENTQTD
      aQtd[ DAY( DATA__ ) ][ 2 ]:= aQtd[ DAY( DATA__ ) ][ 2 ] + SAIQTD
      aQtd[ DAY( DATA__ ) ][ 3 ]:= SDOQTD
      DBSkip()
  ENDDO

  /* armazenar o ultimo saldo nos casos vazios */
  FOR nPos:= 3 TO 3
     nUltimo:= 0
     FOR nDia:= 1 TO Len( aQtd )
         IF !( aQtd[ nDia ][ nPos ]==0 )
            nUltimo:= aQtd[ nDia ][ nPos ]
         ELSEIF aQtd[ nDia ][ nPos ]==0
            aQtd[ nDia ][ nPos ]:= nUltimo
         ENDIF
     NEXT
  NEXT

  VPBox( 00, 00, 24, 79, "RESUMO DE MOVIMENTACOES DIARIAS",_COR_GET_BOX, .F., .F. )

  nLinha:=  03
  nColuna:= 02
  @ ++nLinha, nColuna Say "00" Color "15/00"
  @   nLinha, nColuna + 3 Say " Saldo Inicial        = " + Tran( ES->SDOQTD, "@E 99,999.999" )

  DBGoTop()
  FOR nDia:= 1 TO LastDay( DATA__ )
      IF nLinha > 18 .AND. nColuna < 40
         nLinha:= 03
         nColuna:= 41
      ENDIF
      @ ++nLinha,   nColuna Say StrZero( nDia, 02, 00 ) Color "15/00"
      @ nLinha, nColuna + 3 Say Tran( aQtd[ nDia ][ 1 ], "@E 99,999.999" ) + " " +;
                                Tran( aQtd[ nDia ][ 2 ], "@E 99,999.999" ) + " = " +;
                                Tran( aQtd[ nDia ][ 3 ], "@E 99,999.999" ) Color "15/" + CorFundoAtual()
  NEXT

  SetCursor( 0 )
  Inkey(0)
  ScreenRest( cTela )
  SetColor( cCor )
  SetCursor( nCursor )
  DBGoTo( nReg )
  Return Nil






Static Function ViewGrafico()
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
  Local nReg:= RECNO()
  Local nTotEnt:= nTotSai:= nTotSdo:= 0
  Local cTitulo, nUltimo
  Local aQtd:= {}, nPos:= 1

  FOR nCt:= 1 TO LastDay( DATA__ )
     AAdd( aQtd, { 0, 0, 0 } )
  NEXT
  DBGoTop()

  /* Saldo Inicial */
  aQtd[ 1 ][ 3 ]:= ES->SDOQTD

  /* Soma em Totais */
  WHILE !EOF()
      nTotEnt:= nTotEnt + ENTQTD
      nTotSai:= nTotSai + SAIQTD
      nTotSdo:= nTotSdo + SDOQTD
      aQtd[ DAY( DATA__ ) ][ 1 ]:= aQtd[ DAY( DATA__ ) ][ 1 ] + ENTQTD
      aQtd[ DAY( DATA__ ) ][ 2 ]:= aQtd[ DAY( DATA__ ) ][ 2 ] + SAIQTD
      aQtd[ DAY( DATA__ ) ][ 3 ]:= SDOQTD
      DBSkip()
  ENDDO

  /* armazenar o ultimo saldo nos casos vazios */
  FOR nPos:= 3 TO 3
     nUltimo:= 0
     FOR nDia:= 1 TO Len( aQtd )
         IF !( aQtd[ nDia ][ nPos ]==0 )
            nUltimo:= aQtd[ nDia ][ nPos ]
         ELSEIF aQtd[ nDia ][ nPos ]==0
            aQtd[ nDia ][ nPos ]:= nUltimo
         ENDIF
     NEXT
  NEXT

  /* Negativar as saidas */
  FOR nPos:= 2 TO 2
     FOR nDia:= 1 TO Len( aQtd )
         aQtd[ nDia ][ nPos ]:= aQtd[ nDia ][ nPos ] * (-1)
     NEXT
  NEXT

  nPos:= 1
  DBGoTop()
  SetColor( _COR_GET_BOX )
  WHILE .T.
     IF nPos==1
        cTitulo:= "ENTRADAS & SAIDAS"
        nValor:= ABS( nTotEnt )
     ELSEIF nPos==2
        cTitulo:= "SAIDAS  "    // PENSAR
        nValor:= ABS( nTotSai )
     ELSE
        cTitulo:= "SALDOS  "
        nValor:= ABS( nTotSdo )
     ENDIF
     VPBox( 00, 00, 24, 79, cTitulo,_COR_GET_BOX, .F., .F. )

     /* Exibe Numeracao */
     nColuna:= 3
     FOR nCt:= 1 TO Len( aQtd ) Step 2
         @ 12, nColuna Say StrZero( nCt, 2, 0 ) Color StrZero( nCt, 2, 0 ) + "/00"
         nColuna:= nColuna + 4
         //+ CorFundoAtual()
     NEXT

     nPercMaior:= 0
     FOR nCt:= 1 TO Len( aQtd )
        IF nPos==1    // Se Entradas & Saidas
           nValorMaior:= IF( ABS( aQtd[ nCt ][ nPos ] ) > ABS( aQtd[ nCt ][ nPos + 1 ] ), ABS( aQtd[ nCt ][ nPos ] ), ABS( aQtd[ nCt ][ nPos + 1 ] ) )
        ELSE          // Saldos
           nValorMaior:= ABS( aQtd[ nCt ][ nPos ] )
        ENDIF
        IF ( ( nValorMaior / nValor ) * 100 ) > nPercMaior
           nPercMaior:= ( ( ABS( aQtd[ nCt ][ nPos ] ) / nValor ) * 100 )
        ENDIF
     NEXT
     nPercLinha:= nPercMaior / 10
     nPosLi:= 0

     /* Parte Positiva */
     FOR nLinha:= 11 TO 1 Step - 1
         nColuna:= 1
         nPosLi:= nPosLi + 1
         FOR nCt:= 1 TO Len( aQtd )
             nColuna:= nColuna + 2
             IF aQtd[ nCt ][ nPos ] == 0
             ELSEIF aQtd[ nCt ][ nPos ] > 0
                IF ( ( aQtd[ nCt ][ nPos ] / nValor ) * 100 ) >= ( nPosLi * nPercLinha )
                   @ nLinha, nColuna Say "��" Color StrZero( nCt, 2, 0 ) + "/00"
                ELSE
                   IF nLinha = 20
                      @ nLinha, nColuna Say "--" Color StrZero( nCt, 2, 0 ) + "/" + CorFundoAtual()
                   ENDIF
                ENDIF
             ENDIF
         NEXT
     NEXT

     /* Se a posicao atual for 1, faz passar para posicao 2> SAIDAS
     para exibir na area negativa da tela as informacoes, sem aguardar
     o pressionamento de outra tecla */

     IF nPos==1
        nPos:= 2
     ENDIF

     /* Parte Negativa */
     nPosLi:= 0

     FOR nLinha:= 13 TO 23 Step + 1
         nColuna:= 1
         nPosLi:= nPosLi + 1
         FOR nCt:= 1 TO Len( aQtd )
             nColuna:= nColuna + 2
             IF aQtd[ nCt ][ nPos ] == 0
             ELSEIF aQtd[ nCt ][ nPos ] < 0
                IF ( ( ABS( aQtd[ nCt ][ nPos ] ) / nValor ) * 100 ) >= ( nPosLi * nPercLinha )
                   @ nLinha, nColuna Say "��" Color StrZero( nCt, 2, 0 ) + "/00"
                ELSE
                   IF nLinha = 12
                      @ nLinha, nColuna Say "--" Color StrZero( nCt, 2, 0 ) + "/" + CorFundoAtual()
                   ENDIF
                ENDIF
             ENDIF
         NEXT
     NEXT

     nTecla:= Inkey(0)
     IF nTecla==K_ESC
        EXIT
     ENDIF
     IF nPos < 3
        ++nPos
     ELSE
        nPos:= 1
     ENDIF
  ENDDO

  DBGoTo( nReg )
  ScreenRest( cTela )
  SetColor( cCor )
  Return Nil




