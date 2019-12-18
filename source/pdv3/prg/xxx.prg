
#include "COMMON.CH"
#include "INKEY.CH"
#Include "COMANDOS.CH"
#Include "VPF.CH"

#Define _COD_MPRIMA        10
#Define _VPB_MPRIMA        &DiretorioDeDados\CDMPRIMA.VPB

#Define _COD_PRECOAUX      11
#Define _VPB_PRECOAUX      &DiretorioDeDados\TABAUX__.VPB

#Define _COD_ESTOQUE       12
#Define _VPB_ESTOQUE       &DiretorioDeDados\CESTOQUE.VPB

#Define _COD_CLIENTE       13
#Define _VPB_CLIENTE       &DiretorioDeDados\CLIENTES.VPB

#Define _COD_BANCO         14
#Define _VPB_BANCO         &DiretorioDeDados\CDBANCOS.VPB

#Define _COD_VENDEDOR      15
#Define _VPB_VENDEDOR      &DiretorioDeDados\VENDEDOR.VPB

#Define _COD_CAIXA         16
#Define _VPB_CAIXA         &DiretorioDeDadis\CAIXA___.VPB

#Define _COD_DUPAUX        17
#Define _VPB_DUPAUX        &DiretoriodeDados\CDDUPAUX.VPB

#Define _COD_CUPOM         18
#Define _VPB_CUPOM         &DiretoriodeDados\CUPOM___.VPB

#Define _COD_CUPAUX        19
#Define _VPB_CUPAUX        &DiretoriodeDados\CUPOMAUX.VPB

#Define _ARQUIVO           "PDV_PEND.VPB"
#Define _VENDAFILE         123

#Define _BACKUP            "BAKUPULT.VPB"

#define _COD_PDVEAN        20
#define _VPB_PDVEAN        &DiretoriodeDados\PDVEAN__.VPB

#define _COD_CORES         21
#define _VPB_CORES         &DiretoriodeDados\CORES___.VPB

#define _COD_CLASSES       22
#define _VPB_CLASSES       &DiretoriodeDados\CLASSES_.VPB

#Define _COD_ASSEMBLER     23
#define _VPB_ASSEMBLER     &DiretoriodeDados\MONTAGEM.VPB

#Define _COD_CONDICOES     24
#Define _VPB_CONDICOES     &DiretorioDeDados\CONDICAO.VPB

#Define _COD_TABPRECO      25
#Define _VPB_TABPRECO      &DiretorioDeDados\TABPRECO.VPB

#Define _COD_TABAUX        26
#Define _VPB_TABAUX        &DiretorioDeDados\TABAUX__.VPB

#Define _ABRIR             2
#Define _LIMPAR            3
#Define _EXCLUIR           4
#Define _ANULAR_ITEM       5
#Define _CRIAR             6
#Define _VENDA_ITEM        7
#Define _INFORMACOES_ITEM  8
#Define _BUSCAR_ITEM       9
#Define _ULTIMOREGISTRO    10
#Define _ARMAZENAR         11
#Define _RESTAURAR         12

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Function Sistema(cVersao)

   Local lFim := .F., lCupomPendente := .F., lVersaoConflito:= .F.
   Local nHandProd, nHandDisp, nHandInfo, nhandLogo

   // Mensagem de cupom pendente - Inicio //
   IF File( _ARQUIVO )
      lCupomPendente := .T.
      !Del *.NTX
      VendaFile( _ABRIR )
   ENDIF
   // Mensagem de cupom pendente - Fim //

   SetCursor( 0 )

   MReset()
   MSetWin( 10, 10, 1340, 990 )
   MCurOn()
   MCurOff()

   setbkfill(0)
   boxfill(0, 0, 1350, 1000, 20, 0)
   i:= 1
   adirectory:= {}
   adirectory:= directory("*.BMP")
   boxfill(0, 0, 1350, 1000, 0, 0)

   PicRead( 000, 000, 129, "FUNDO.BMP"    )
   PicRead( 782, 055, 001, "LOGOTIPO.BMP" )

   IF (CorPadrao == "CINZA")
      BoxFill( 10, 5, 1332, 30, 0, 03 )
   ELSE
      BoxFill( 10, 5, 1332, 30, 0, 07 )
   ENDIF

   LoadcSet( 0, "VSYS14.PTX" )

   SayString(    2,  3, 4, 0, 15, "  [      ] Aux  [   ] Quant  [   ] Canc  [        ] Venda  [   ] Cliente  [   ] Cond  [   ] Fecha")

   SayString(   44,  4, 4, 0,  0, "Home" )
   SayString(  232,  4, 4, 0,  0, "F1" )
   SayString(  406,  4, 4, 0,  0, "F4" )
   SayString(  577,  4, 4, 0,  0, "ENTER" )
   SayString(  816,  4, 4, 0,  0, "F8" )
   SayString( 1012,  4, 4, 0,  0, "F7" )
   SayString( 1175,  4, 4, 0,  0, "F6" )

   SayString(   42,  3, 4, 0, 14, "Home" )
   SayString(  230,  3, 4, 0, 14, "F1" )
   SayString(  404,  3, 4, 0, 14, "F4" )
   SayString(  575,  3, 4, 0, 14, "ENTER" )
   SayString(  814,  3, 4, 0, 14, "F8" )
   SayString( 1010,  3, 4, 0, 14, "F7" )
   SayString( 1173,  3, 4, 0, 14, "F6" )

   IF (CorPadrao == "CINZA")
      BoxFill( 25, 910, 1298,  72, 128, 3 )
   ELSE
      BoxFill( 25, 910, 1298,  72, 128, 1 )
   ENDIF

   nHandProd:= SnapCopy(  20, 900, 1300, 980, 0 )
   nHandDisp:= SnapCopy( 400, 500,  740, 880, 0 )
   nHandInfo:= SnapCopy( 220,  75,  740, 250, 0 )
   nHandLogo:= SnapCopy( 600, 450, 1350, 960, 0 )

   WHILE !LastKey()==K_ESC .AND. lFim == .F.
      IF !File( _ARQUIVO )
         VendaFile( _CRIAR )
      ENDIF
      VendaFile( _ABRIR )

      SnapPaste( 220,  75, nHandInfo )
      SnapPaste( 20,  900, nHandProd )
      SnapPaste( 400, 500, nHandDisp )
      SnapPaste( 600, 450, nHandLogo )

      LoadcSet( 0, "AGSYSA14.PTX" )
      SayString( 1140, 580, 4, 0, 0, cVersao ) // Versao do Programa

      Browse( @lFim, @lCupomPendente, @lVersaoConflito, @cVersao, nHandInfo, nHandProd, nHandDisp, nHandLogo )

      DBCloseAll()

   ENDDO

   Return 0


// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ BROWSE
³ Finalidade  ³ Apresentacao da Tela do Browse
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Browse(lFim, lCupomPendente, lVersaoConflito, cVersao, nHandInfo, nHandProd, nHandDisp, nHandLogo )
  Local TECLA, nTotal:= 0, cTelaRes, nSave,;
        lSubTotal:= .F., nUltReg:= -1
  Local oTab
  Local cProdut, cUnidad, cCodFab
  Local cObserv1:= Space( 60 ), cObserv2:= Space( 60 )
  Local lCancelaItem:= .F., nDescPercentual:= 0, nDescValor:= 0, nQuantidade:= 1
  Local cFontBrowse:= "VSYS14.PTX"
  Local lPrinter:= .T.
  Local nForma:= 0
  Local nCt
  Local GetList:= {}
  Local nVendedor:= 0, nCliCodigo:= 0,;
        cCliDescri:= Space( 45 ), cCliEndere:= Space( 35 ),;
        cCliCidade:= Space( 30 ), cCliBairro:= Space( 25 ),;
        cCliEstado:= Space( 2 ),  cCliCodCep:= Space( 8 ),;
        cCliCGCCPF:= Space( 14 )
  Local nBanco:= 0, aParcelas:= {}, nValorPagar:= 0, nPerAcrDes:= 0,;
        nVlrAcrDes:= 0, cAcrDes:= "D", nVezes:= 0, nPrazo:= 0,;
        nParcela:= 0, nPercentual:= 0, dVencimento:= DATE(),;
        dPagamento:= CTOD( "  /  /  " ), cCheque:= Space( 15 ), nLocal := 0
  Local nStatusAnt:= 1
  Local nStatus:= 1, aStatus:= { "Em Consulta",;
                                 "Cupom Fiscal",;
                                 "Cancelamento Cupom",;
                                 "Cancelamento Item",;
                                 "Fechamento",;
                                 "Cliente",;
                                 "Condicoes",;
                                 "Preco Diferenciado",;
                                 "Desconto Produto",;
                                 "Consulta Produto" }
  Local nUltimaQuantidade:= 0
  Local cBusca:= "", lVerPreco := .F., lAchou := .T.
  Local nSalLimCre:= 0, lLimCredAvis := .F.
  Local nTamEAN := 0, nCorEAN := 0, nRegAtuEAN := 0, ;
        nRegAtuCli := 0, cForma := ""

  Priv nPgtDin:=0, nPgtTic:=0, nPgtChq:=0, nPgtCar:=0, nPgtPra:=0, ;
       nPgtOut:=0, nTroco := 0, ;
       cPgtDin:= Space( 40 ), cPgtTic:= Space( 40 ), cPgtCar:= Space( 40 ), ;
       cPgtChq:= Space( 40 ), cPgtOut:= Space( 40 ), cPgtPra:= Space( 40 )


  IF MReset() > 0
     //mCurOff()
  ENDIF

   IF (CorPadrao == "CINZA")
      // Ajusta a Cor Cinza Claro
      SetRGBDac(   7,  192, 192, 192 )
      SetRGBDac(  15,  220, 220, 205 )
      SetRGBDac(  73,  192, 192, 192 )
      SetRGBDac(  88,  220, 220, 205 )
   ELSE
      // CONFIGURACAO DE CORES - AZUL
      SetRGBDac(   1,   48,   0, 152 ) // Titulo
      SetRGBDac(   7,    0, 152, 248 ) // Box
      SetRGBDac(   8,    0,  48,  96 ) // Sombras Diversas
      SetRGBDac(  13,   18,  96, 200 ) // Realce do Box
      SetRGBDac(  15,  152, 200, 248 ) // Fundo do Box
      SetRGBDac(  63,    0,  48,  96 ) // Sombras - Imagem
      SetRGBDac(  73,    0, 152, 248 ) // Complemento do Box - Imagem
      SetRGBDac(  88,  152, 200, 248 ) // Fundo do Box - Imagem
      SetRGBDac( 177,    0,  48,  96 ) // Sombra do Box
   ENDIF

  SetColor( "00/07, 07/08" )

   // Abertura do arquivo de Correspondencias de codigos EAN
  IF File( DiretorioDeDados-"\PDVEAN__.VPB" )
      DBSelectAr( _COD_PDVEAN )
      Use _VPB_PDVEAN Alias EAN Shared
      IF !File( DiretorioDeDados-"\EANIND01.IGD" ) .OR. ;
         !File( DiretorioDeDados-"\EANIND02.IGD" )
         !File( DiretorioDeDados-"\EANIND03.IGD" )
         Index On CODIGO Tag EANX1 ;
                 Eval {|| .T. } ;
                 To &DiretorioDeDados\EANIND01.IGD
         Index On CODEAN + CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                 STR (PCPCOR, 3) Tag EANX2 ;
                 Eval {|| .T. } ;
                 To &DiretorioDeDados\EANIND02.IGD
         Index On CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                 STR (PCPCOR, 3) Tag EANX3 ;
                 Eval {|| .T. } ;
                 To &DiretorioDeDados\EANIND03.IGD
      ENDIF
      Set Index To &DiretorioDeDados\EANIND01.IGD,;
                   &DiretorioDeDados\EANIND02.IGD,;
                   &DiretorioDeDados\EANIND03.IGD
   ELSE
       SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
               {{0, " "},;
                {0, "   O arquivo de Correspondencias EAN nao consta no diretorio !"},;
                {0, " "},;
                {0, "   Inclua o arquivo PDVEAN__.VPB no diretorio de dados do"},;
                {0, "        Fortuna"},;
                {0, "   Acione qualquer tecla para encerrar o PDV"}, ;
                {0, " "}}, 7, 4)
       Settext()
       fFim ()
       __QUIT ()
   ENDIF
   
   // Abertura do arquivo de Precos
   IF File( DiretorioDeDados-"\TABPRECO.VPB" )
       DBSelectAr( _COD_TABPRECO )
       Use _VPB_TABPRECO Alias PRE Shared
       Set Index To &DiretorioDeDados\TPRIND01.IGD, &DiretorioDeDados\TPRIND02.IGD
       DBGoTop()
   ENDIF

   // Abertura do arquivo de Precos Auxiliar
   IF File( DiretorioDeDados-"\TABAUX__.VPB" )
       DBSelectAr( _COD_TABAUX )
       Use _VPB_TABAUX Alias TAX Shared
       Set Index To &DiretorioDeDados\TAXIND01.IGD, &DiretorioDeDados\TAXIND02.IGD
       DBGoTop()
   ENDIF

   // Abertura do arquivo de Cores
   IF File( DiretorioDeDados-"\CORES___.VPB" )
       DBSelectAr( _COD_CORES )
       Use _VPB_CORES Alias COR Shared
       IF !File( DiretorioDeDados-"\CORIND01.IGD" )
          Index On CODIGO Tag CORX1 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CORIND01.IGD
       ENDIF
       Set Index To &DiretorioDeDados\CORIND01.IGD
   ENDIF

   // Abertura do arquivo de CLASSES
   IF File( DiretorioDeDados-"\CLASSES_.VPB" )
       DBSelectAr( _COD_CLASSES )
       Use _VPB_CLASSES Alias CLA Shared
       IF !File( DiretorioDeDados-"\CLAIND01.IGD" )
          Index On CODIGO Tag CLAX1 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CLAIND01.IGD
       ENDIF
       Set Index To &DiretorioDeDados\CLAIND01.IGD
   ENDIF

   // Abertura do arquivo de CLIENTES
   IF File( DiretorioDeDados-"\CLIENTES.VPB" )
       DBSelectAr( _COD_CLIENTE )
       AbreFile( _COD_CLIENTE )
   ENDIF

  // Abertura do arquivo de Materia-Prima - Produtos
  IF File( DiretorioDeDados-"\CDMPRIMA.VPB" )
      DBSelectAr( _COD_MPRIMA )
      Use _VPB_MPRIMA Alias MPR Shared
      IF File( DiretorioDeDados-"\MPRIND01.IGD" ) .AND. File( DiretorioDeDados-"\MPRIND02.IGD" ) .AND.;
         File( DiretorioDeDados-"\MPRIND03.IGD" ) .AND. File( DiretorioDeDados-"\MPRIND04.IGD" ) .AND.;
         File( DiretorioDeDados-"\MPRIND05.IGD" )
         Set Index To &DiretorioDeDados\MPRIND01.IGD,&DiretorioDeDados\MPRIND02.IGD,;
                      &DiretorioDeDados\MPRIND03.IGD,&DiretorioDeDados\MPRIND04.IGD,&DiretorioDeDados\MPRIND05.IGD
      ELSEIF File( DiretorioDeDados-"\MPRIND01.IGD" ) .AND. File( DiretorioDeDados-"\MPRIND02.IGD" ) .AND.;
             File( DiretorioDeDados-"\MPRIND03.IGD" ) .AND. File( DiretorioDeDados-"\MPRIND04.IGD" )
         Set Index To &DiretorioDeDados\MPRIND01.IGD,&DiretorioDeDados\MPRIND02.IGD,&DiretorioDeDados\MPRIND03.IGD,&DiretorioDeDados\MPRIND04.IGD
      ELSEIF File( DiretorioDeDados-"\MPRIND01.IGD" ) .AND. File( DiretorioDeDados-"\MPRIND02.IGD" ) .AND.;
             File( DiretorioDeDados-"\MPRIND03.IGD" )
         Set Index To &DiretorioDeDados\MPRIND01.IGD,&DiretorioDeDados\MPRIND02.IGD,&DiretorioDeDados\MPRIND03.IGD
      ELSEIF File( DiretorioDeDados-"\MPRIND01.IGD" ) .AND. File( DiretorioDeDados-"\MPRIND02.IGD" )
         Set Index To &DiretorioDeDados\MPRIND01.IGD,&DiretorioDeDados\MPRIND02.IGD
      ENDIF
  ELSE
      SWGAviso( "ARQUIVO DE MATERIAS PRIMAS",;
              {{0, " "},;
               {0, "   O arquivo de Materias Primas nao consta no diretorio !"},;
               {0, " "},;
               {0, "   Inclua o arquivo CDMPRIMA.VPB no diretorio de dados do"},;
               {0, "        Fortuna"},;
               {0, "   Acione qualquer tecla para encerrar o PDV"}, ;
               {0, " "}}, 7, 4)
      Settext()
      fFim ()
      __QUIT ()
  ENDIF

  /* Verifica se tabela de Preco ‚ Diferente da padrao */
  //IF TabelaDePreco > 0
  //ENDIF


  PicWrite( 0, 0, 740, 900, 1, "PDV_LEF.$$$" )
  LoadcSet( 0, cFontBrowse )
  SetColor( "08/07,00/07" )

  DBSelectAr( _COD_MPRIMA )
  oTab:=tbrowseDB(19,02,24,43)
  oTab:addcolumn(tbcolumnnew(,{|| PAD( " " + Left( MPR->DESCRI, 39 ), 45 ) }))
  oTab:AUTOLITE:=.f.
  oTab:dehilite()
  lDelimiters:= Set( _SET_DELIMITERS, .F. )
  //mCurOff()
  mSetWin( 5, 5, 1280, 1000 )
  mFixPos( 6, 6 )
  loadcSet( 0, "AGSYSD10.PTX" )

  SayString( 35, 820, 4, 0, 0, "Codigo Fabrica . . . . . . . . . . . . ." )
  SayString( 35, 780, 4, 0, 0, "Unidade de Medida . . . . . . . . . . " )
  SayString( 35, 740, 4, 0, 0, "Quantidade  . . . . . . . . . . . . . . ." )
  SayString( 35, 700, 4, 0, 0, "Origem/Fabricante  . . . . . . . . . . " )
  SayString( 35, 660, 4, 0, 0, "Saldo em Estoque . . . . . . . . . . . "  )
  SayString( 35, 620, 4, 0, 0, "Status . . . . . . . . . . . . . . . . . . . "  )
  SayString( 35, 580, 4, 0, 0, "Cliente  . . . . . . . . . . . . . . . . . . "  )

  loadcSet( 0, "VSYS14.PTX" )
  SayString( 35, 500, 4, 0, 0, "Total" )

  /* Informacoes de Baixo */
  loadcSet( 0, "AGSYSD10.PTX" )
  SayString( 35, 125, 4, 0, 0, "Ordenacao        " )
  SayString( 35, 100, 4, 0, 0, "Busca            " )
  SayString( 35, 075, 4, 0, 0, "Codigo Interno   " )

  DBSelectAr( _VENDAFILE )
  //mCurOff()
  loadcSet( 0, cFontBrowse )
  IF LastRec() > 0
     IF nStatus == 1
        FOR nCt:= 1 TO 10
            DispCupom( " ", 0, .F.)
        NEXT
     ENDIF
     DBSetOrder( 2 )
     DBGoTop()
     NumeroCupom( RIGHT( StrZero( VDA->NUMCUP, 9, 0 ), 6 ) )
     DispCupom( "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\", 0, .T.)
     DispCupom( " ", 0)
     DispCupom( "  . . .  C O N T I N U A C A O", 0)
     DispCupom( " ", 0)
     DispCupom( "VENDA FOI INICIADA AS " + VDA->HORA__ + "Hs.", 0 )
     DispCupom( "Cupom Fiscal No. " + NumeroCupom(), 0 )
     DispCupom( "Produto                                               Preco", 5)
     DispCupom( "======================================= ==========", 0)
     WHILE !EOF()
        IF STATUS==" " .OR. STATUS=="X"
           nTotal:= nTotal + PRECOT
           DispCupom( Left( VDA->DESCRI, 31), 4 )
           DispValor( Tran( VDA->PRECOV, "@E 999,999.99"), 4 )
        ELSEIF STATUS=="E"
           nTotal:= nTotal - PRECOT
           DispCupom( Left( VDA->DESCRI, 31), 5 )
           DispValor( Tran( VDA->PRECOV, "@E 999,999.99"), 5 )
        ENDIF
        DBSkip()
     ENDDO
     lSubTotal:= .T.
     nStatus:= 2
  ENDIF

  /* Variaveis q devem ser inicializadas inicialmente */
  cAcrDes:= "D"
  nPerAcrDes:= 0
  nVlrAcrDes:= 0

  DBSelectAr( _COD_MPRIMA )
  MPR->( DBSetOrder( 2 ) ) // upper( Descri )
  MPR->( DBGotop( ) )

  WHILE .T.
      loadcSet( 0, cFontBrowse )
      IF LastKey()==K_DOWN
         cBusca:= ""; lAchou := .T.
         BoxFill( 35, 446, 700, 4, 0, 7 )
         oTab:RefreshAll()
         WHILE !oTab:Stabilize()
         ENDDO
//    ELSEIF !UPPER( Chr( LastKey() ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW& - 0123456789+* /"
//       cBusca:= ""; lAchou := .T.
      ELSE
         SnapPaste( 220,  75, nHandInfo )
         SayString( 250, 125, 4, 0, 1, PAD( Alltrim( STR( MPR->( INDEXORD() ) ) ), 20 ) )
         SayString( 250, 100, 4, 0, 1, PAD( cBusca, 28 ) )
      ENDIF
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1})
      WHILE nextkey()==0 .and. ! oTab:stabilize()
      ENDDO
      //mCurOff()

      /* Diplay de Contorno */
      DO CASE
         CASE oTab:ROWPOS==1;  BoxFill( 35, 422, 700, 27, 20 + 32, 12 )
         CASE oTab:ROWPOS==2;  BoxFill( 35, 394, 700, 27, 20 + 32, 12 )
         CASE oTab:ROWPOS==3;  BoxFill( 35, 365, 700, 27, 20 + 32, 12 )
         CASE oTab:ROWPOS==4;  BoxFill( 35, 336, 700, 27, 20 + 32, 12 )
         CASE oTab:ROWPOS==5;  BoxFill( 35, 306, 700, 27, 20 + 32, 12 )
         CASE oTab:ROWPOS==6;  BoxFill( 35, 277, 700, 27, 20 + 32, 12 )
      ENDCASE

      IF !nUltReg==RECNO() .OR. lSubTotal

         SnapPaste( 20,  900, nHandProd )
         /* Exibicao c/ Sombra */
         loadcSet( 0, "RMN1914.PTX" )

         SayString( 37, 915, 4, 0, 00, MPR->DESCRI )
         SayString( 34, 920, 4, 0, 14, MPR->DESCRI )

         SnapPaste( 400, 500, nHandDisp )
         LoadCSet( 0, "VSYS14.PTX" )

         SayString( 400, 820, 4, 0, IF( EMPTY( MPR->CODFAB ), 15, 1 ), IIF (EMPTY (MPR -> CODFAB) = .F., MPR -> CODFAB, "~~"))
         SayString( 400, 780, 4, 0, IF( EMPTY( MPR->UNIDAD ), 15, 1 ), IIF (EMPTY (MPR -> UNIDAD) = .F., MPR -> UNIDAD, "~~" ))
         SayString( 400, 740, 4, 0, IF( EMPTY( nQuantidade ), 15, 1 ), IIF (EMPTY (nQuantidade) = .F., Alltrim( Tran( nQuantidade, "@E 999,999.999" ) ), "~~"))
         SayString( 400, 700, 4, 0, IF( EMPTY( MPR->ORIGEM ), 15, 1 ), IIF (EMPTY (MPR->ORIGEM) = .F., MPR->ORIGEM, "~~"))
         SayString( 400, 660, 4, 0, IF( EMPTY( MPR->SALDO_ ), 15, 1 ), IIF (EMPTY (MPR->SALDO_) = .F., Alltrim( Str( MPR->SALDO_ ) ), "~~"))

         SnapPaste( 220,  75, nHandInfo )
         SayString( 250, 125, 4, 0, 1, PAD( Alltrim( STR( MPR->( INDEXORD() ) ) ), 20 ) )
         SayString( 250, 100, 4, 0, 1, PAD( cBusca, 28 ) )
         SayString( 250, 075, 4, 0, 1, PAD( ALLTRIM( MPR->INDICE ) + "-" + ALLTRIM( STR( PrecoConvertido() ) ) + "00", 40 ) )

         SayString( 400, 580, 4, 0, IF( EMPTY( cCliDescri ), 15, 1 ), ;
            IIF (EMPTY (cCliDescri) = .F., ;
            LEFT (Alltrim( cCliDescri ), 18) + " ...", "~~"))

         IF nStatus==10
            SayString( 400, 620, 4, 0, 2, aStatus[ nStatus ] )
         ELSE
            SayString( 400, 620, 4, 0, IF( nStatus==4, 4, 1 ), aStatus[ nStatus ] )
         ENDIF

         nUltReg:= RECNO()
      ENDIF
      IF lSubTotal
         LoadcSet( 0, "DGE1609.PTX" )
         IF nStatus==10
            SayString( 400, 500, 4, 0, 08, Alltrim( Tran( PrecoConvertido(), "@E 999,999.99" ) ) )
            SayString( 400, 502, 4, 0, 03, Alltrim( Tran( PrecoConvertido(), "@E 999,999.99" ) ) )
         ELSE
            SayString( 400, 500, 4, 0, 7, Alltrim( Tran( nTotal, "@E 999,999.99" ) ) )
            SayString( 400, 502, 4, 0, 1, Alltrim( Tran( nTotal, "@E 999,999.99" ) ) )
         ENDIF
         //lSubTotal:= .F.
      ENDIF
      //mCurOn()

      // Mensagem de Conflito de Versao - Inicio //
      IF (lVersaoConflito == .T.)
         lVersaoConflito := .F.
         SWGAviso( "VERSAO DO PROGRAMA",;
                 {{0, "   Conflito de versoes !"},;
                  {0, " "},;
                  {1, "         Versao do programa = " + ALLTRIM (cVersao)} ,;
                  {1, "         Versao do PDV.INI    = " + ALLTRIM (Versao)} ,;
                  {0, " "},;
                  {0, "   Acione qualquer tecla para continuar no PDV"}, ;
                  {0, " "}}, 7, 4)
      ENDIF

      // Mensagem de Conflito de Versao - Fim //
      nSegundos:= SECONDS()
      WHILE ( nTecla:=Inkey() )==0 // #01

         /* Protecao de Tela - Carregamento de Imagens em IMGEM\ */
         IF SECONDS() - nSegundos > 60 * ProtecaoTela
            aDirImagem:= DIRECTORY( "IMAGEM\*.BMP" )
            nTeclaRes:= 0
            nSaveScreen:= SWSnapCopy( 0, 0, 1350, 1000, 0, "PDVSCR.$$$" )
            cCorRes:= SetColor( "00/00" )
            SetGMode( 257 )
            SetHires( 0 )
            WHILE nTeclaRes==0
                FOR nCt:= 1 TO Len( aDirImagem )
                    PicRead( 000, 000, 129, "\" + CURDIR() + "\IMAGEM\" + aDirImagem[ nCt ][ 1 ] )
                    IF !( nTeclaRes:= Inkey( 3 ) ) == 0
                       EXIT
                    ENDIF
                NEXT
            ENDDO
            SetGMode( 257 )
            SetHires( 0 )
            SWSnapPaste( 0, 0, nSaveScreen )
            SWSnapKill( @nSaveScreen )
            SetColor( cCorRes )
            nSegundos:= SECONDS()
         ENDIF
         nRegiao:= 1
         nBotao:= MStatus()
         IF MMotion() <> 0
            //mCurOff()
            //mCurOn()
         ENDIF
         IF nRegiao > 0
            IF nBotao==1
               Keyboard Chr( K_UP ) + Chr( 0 )
            ELSEIF nBotao==2
               Keyboard Chr( K_DOWN ) + Chr( 0 )
            ENDIF
         ENDIF
      ENDDO
      //mCurOff()

      DO CASE
         CASE nTecla==K_ESC
            cBusca:= ""; lAchou := .T.
            IF (!nStatus == 2)
               SWGAviso( "FINALIZACAO DO PDV",;
                       {{0, " "},;
                        {0, "   O Sistema sera FINALIZADO !"},;
                        {0, " "},;
                        {0, "   Para confirmar, acione a tecla [ESC], novamente"},;
                        {0, " "},;
                        {0, "   Para continuar a rotina normal, acione qualquer tecla"}, ;
                        {0, " "}}, 7, 4)
               IF (LASTKEY () == K_ESC)
                  nOpcao:= 0
                  IF nTotal == 0
                     VendaFile( _EXCLUIR )
                  ENDIF
                  nTecla := 0
                  lFim:= .T.
                  EXIT
               ENDIF
            ELSE
               SWGAviso( "FINALIZACAO DO PDV",;
                       {{0, " "},;
                        {0, "   O Sistema sera FINALIZADO com um Cupom Pendente !"},;
                        {0, " "},;
                        {0, "   Para Sair Pressione [ENTER]"},;
                        {0, " "},;
                        {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                        {0, " "}}, 7, 4)
               IF ( LASTKEY () == K_ENTER )
                  nOpcao:= 0
                  IF nTotal == 0
                     VendaFile( _EXCLUIR )
                  ENDIF
                  nTecla := 0
                  lFim:= .T.
                  EXIT
               ENDIF
            ENDIF
            nTecla:= 0
            CLEAR TYPEAHEAD
         CASE nTecla==K_TAB
            nTecla:= 0
            lFim:= .T.
            nOpcao:= 0
            IF nTotal == 0
               VendaFile( _EXCLUIR )
            ENDIF
            CLEAR TYPEAHEAD
            EXIT

         CASE nTecla==K_BS .OR. nTecla==K_LEFT .OR. nTecla==K_RIGHT
            IF (EMPTY (cBusca) == .F.)
               cBusca := LEFT (cBusca, LEN (cBusca) - 1)
               LoadcSet( 0, "VSYS14.PTX" )
               SayString( 250, 100, 4, 0, 1, PAD( cBusca, 29 ) )
            ENDIF
         CASE nTecla==K_UP         ;oTab:up();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_DOWN       ;oTab:down();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_PGUP       ;oTab:pageup();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() ;cBusca:= ""; lAchou := .T.
         CASE nTecla==K_PGDN       ;oTab:pagedown();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_CTRL_F7;cBusca:= ""; lAchou := .T.
              DispCupom( "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\", 0, .T.)
              DispCupom( " ", 0)
              DispCupom( " ", 0)
              DispCupom( "Cupom Fiscal No. " + NumeroCupom( ), 0 )
              DispCupom( "Produto                                               Preco", 5)
              DispCupom( "======================================= ==========", 0)

         CASE nTecla==K_ENTER // #01

               /* Se campo busca nao estiver vazio */
               IF !cBusca==""
                  IF Left( MPR->DESCRI, LEN( ALLTRIM( cBusca ) ) )==UPPER( Alltrim( cBusca ) ) .AND.;
                     !Left( cBusca, 1 ) $ "01234567890"
                     /* Busca 100% */
                     cBusca:= ""
                  ELSE
                     IF (fVerifBusca (@cBusca, @nRegAtuEAN, @oTab) == .F.)
                        cBusca:= ""
                        CLEAR TYPEAHEAD
                        LOOP
                     ENDIF
                     IF !( cBusca == "" ) .AND. !LEFT( cBusca, 1 ) $ "01234567890"
                        IF !( cBusca == "" )
                           IF !( Left( MPR->DESCRI, Len( Alltrim( cBusca ) ) )==Alltrim( cBusca ) )
                              cBusca:= ""; lAchou := .T.
                              DispCupom( "Pesquisa NAO COMPLETADA !", 2 )
                              LOOP
                           ENDIF
                        ENDIF
                        IF (lAchou == .F.)
                           cBusca:= ""; lAchou := .T.
                           DispCupom( "Pesquisa NAO COMPLETADA !", 2 )
                           LOOP
                        ENDIF
                     ELSEIF Left( cBusca, 1 ) $ "01234567890"
                        IF !MPR->CODFAB == PAD( cBusca, LEN( MPR->CODFAB ) ) .OR. MPR->( EOF() )
                           DispCupom( "Codigo EAN Inexistente!", 2 )
                           cBusca:= ""; lAchou:= .T.
                           LOOP
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF
               cBusca:= ""
               IF MPR->( EOF() )
                  LOOP
               ENDIF

               IF nStatus==1 .OR. nStatus==2 .OR. nStatus==8 .OR. nStatus==9
                  IF nStatus == 1
                     FOR nCt:= 1 TO 10
                         DispCupom( " ", 0, .F.)
                     NEXT
                  ENDIF

                  LoadcSet( 0, "VSYS14.PTX" )

                  IF (fVerLimCred (@lLimCredAvis, @nCliCodigo, @nTotal, ;
                                   @nSalLimCre) == .F.)
                     IF !nStatus==10
                        nStatus:= 2
                     ENDIF
                     LOOP
                  ENDIF

                  IF (MPR->PCPCSN=="S")
                     EAN -> (DBSetOrder (3)) // CODPRO ...
                     EAN -> (DBSeek (MPR -> INDICE, .T.))
                     IF (EAN -> CODPRO == MPR -> INDICE)
                        nCorEAN:= fCorEAN()
                     ELSE
                        nCorEAN:= 0
                     ENDIF
                  ELSE
                     nCorEAN:= 0
                  ENDIF

                  IF (LASTKEY () == K_ESC)
                     IF !nStatus==10
                        nStatus:= 2
                     ENDIF
                     LOOP
                  ENDIF

                  IF (MPR->PCPCLA > 0)
                     EAN -> (DBSetOrder (3)) // CODPRO ...
                     EAN -> (DBSeek (MPR -> INDICE, .T.))
                     IF (EAN -> CODPRO == MPR -> INDICE)
                        nTamEan:= fTamEAN(@nCorEAN)
                     ELSE
                        nTamEAN:= 0
                     ENDIF
                  ELSE
                     nTamEAN:= 0
                  ENDIF

                  IF (LASTKEY () == K_ESC)
                     IF !nStatus==10
                        nStatus:= 2
                     ENDIF
                     LOOP
                  ENDIF

                  IF (AvisaSaldoEst == "SIM")
                     IF (fVerSalEst (@nQuantidade, @nTamEAN, @nCorEAN, ;
                         @nRegAtuEAN) == .F.)
                        IF !nStatus==10
                           nStatus:= 2
                        ENDIF
                        LOOP
                     ENDIF
                  ENDIF

                  nPreco:= MPR->( PrecoConvertido() )
                  cProdut:= MPR->DESCRI
                  cCodFab:= MPR->CODFAB
                  cUnidad:= MPR->UNIDAD

                  //////////////////  PRODUTOS EDITAVEIS  ////////////////////
                  /* Verifica se nome do produto esta como editar no inicio */
                  ////////////////////////////////////////////////////////////
                  IF UPPER( LEFT( MPR->DESCRI, 8 ) )=="<EDITAR>"
                     nSaveFF2:= SWSnapCopy( 50, 100, 1320, 950, 0, "PEDIT.$$$" )
                     loadcSet( 0, "VSYS14.PTX" )
                     SWGBox( 120, 190, 1170, 850, "PRODUTO EDITAVEL" , 15 )
                     BoxFill( 341, 707, 750, 40, 20 + 32, 0 )  /* NOME */
                     BoxFill( 341, 649, 280, 40, 20 + 32, 0 )  /* COD.FABRICA */
                     BoxFill( 341, 589, 60,  40, 20 + 32, 0 )  /* UNIDADE */
                     BoxFill( 341, 532, 190, 40, 20 + 32, 0 )  /* PRECO UNITARIO */


                     BoxFill( 180, 300, 920, 200, 20 + 32, 0 )  /* INFORMACOES */
                     cCorRes:= SetColor( "08/15,01/15" )

                     @ 18,13 Say PADC( "Os produtos registrados por este metododo durante", 50 )
                     @ 19,13 Say PADC( "a venda nao serao 100% controlados pelo FORTUNA.", 50 )
                     @ 20,13 Say PADC( "Voce devera preencher todas as informacoes acima", 50 )
                     @ 21,13 Say PADC( "solicitadas para que nao ocorra falha na venda", 50 )
                     @ 22,13 Say PADC( "do item junto a sua impressora fiscal. ", 50 )

                     cProdut:= LTRIM( StrTran( UPPER( cProdut ), "<EDITAR>", "" ) )
                     Mensagem()
                     @ 09,10 Say "Descricao:" Get cProdut PICT "@!" when;
                       Mensagem( "Digite a descricao do produto." )
                     @ 11,10 Say "Cod.Fab..:" Get cCodFab when ;
                       Mensagem( "Digite o codigo de fabrica do produto." )
                     @ 13,10 Say "Unidade..:" Get cUnidad when ;
                        Mensagem( "Digite a unidade de medida do produto." )
                     @ 15,10 Say "Preco....:" Get nPreco Pict "@E 999,999.99" ;
                        When Mensagem( "Digite o Preco do item" ) Valid nPreco > 0
                     SetCursor( 1 )
                     READ
                     SetCursor( 0 )

                     SetColor( cCorRes )
                     SWSnapPaste( 50, 100, nSaveFF2 )
                     SWSnapKill( @nSaveFF2 )
                     IF (LASTKEY () = K_ESC)
                        IF !nStatus==10
                           nStatus:= 2
                        ENDIF
                        LOOP
                     ENDIF

                  /* Se Estiver habilitado o F12 ou se PrecoVenda==0 */
                  ELSEIF nStatus==8 .OR. MPR->( PrecoConvertido() ) <= 0

                     nPreco:= MPR->( PrecoConvertido() )
                     cCorRes:= SetColor( "08/15,14/01" )

                     nSaveF2:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F2__.$$$" )
                     loadcSet( 0, "VSYS14.PTX" )
                     SWGBox( 220, 490, 670, 720, "Preco do Item" , 15 )
                     BoxFill( 400, 590, 210, 40, 20 + 32, 0 )
                     cCorRes:= SetColor( "08/15,01/15" )

                     Mensagem()
                     @ 13,15 Say "Preco"
                     @ 13,25 Get nPreco Pict "@E 999,999.99" ;
                        When Mensagem( "Digite o Preco do item" ) Valid nPreco > 0

                     SetCursor( 1 )
                     READ
                     SetCursor( 0 )

                     SetColor( cCorRes )
                     SWSnapPaste( 50, 100, nSaveF2 )
                     SWSnapKill( @nSaveF2 )
                     IF (LASTKEY () = K_ESC)
                        IF !nStatus==10
                           nStatus:= 2
                        ENDIF
                        LOOP
                     ENDIF
                  ELSE
                     nPreco:= MPR->( PrecoConvertido() )
                  ENDIF

                  cTabela:= STPadrao
                  IF Left( MPR->INDICE, 3 ) == GrupoServico
                     cTabela:= STServico                             /* SERVICOS */
                  ELSEIF MPR->TABRED == "  "
                     IF MPR->IPICOD == 4                             /* ISENTO */
                        cTabela:= STIsento
                     ELSEIF MPR->IPICOD == 1 .OR. MPR->IPICOD == 3   /* SUBSTITUICAO TRIBUTARIA */
                        cTabela:= STSubstituicao
                     ELSE                                            /* PADRAO */
                        cTabela:= STPadrao
                     ENDIF
                  ELSE
                     cTabela:= MPR->TABRED
                  ENDIF

                  IF nStatus == 1 .OR. VendaFile( _ULTIMOREGISTRO ) <= 0
                     IF lPrinter
                        ImpAbreCupom()
                     ENDIF
                     NumeroCupom( "<Buscar>" )
                     DispCupom( "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\", 0, .T.)
                     DispCupom( " ", 0)
                     DispCupom( " ", 0)
                     DispCupom( "VENDA INICIADA AS " + TIME() + "Hs.", 0 )
                     DispCupom( "Cupom Fiscal No. " + NumeroCupom( ), 0 )
                     DispCupom( "Produto                                               Preco", 5)
                     DispCupom( "======================================= ==========", 0)
                  ENDIF

                  nPrecoFinal:= ( nPreco * nQuantidade )
                  IF nStatus==9
                     /* Verifica Descontos */
                     IF !nDescPercentual == 0
                        nPrecoFinal:= ( nPreco * nQuantidade )
                        nPrecoFinal:= ( nPrecoFinal ) -;
                                    ROUND( ROUND( nDescPercentual * nPrecoFinal, 2 ) / 100, 2 )
                     ELSEIF !nDescValor == 0
                        nPrecoFinal:= ( nPreco * nQuantidade ) - nDescValor
                     ELSE
                        nPrecoFinal:= ( nPreco * nQuantidade )
                     ENDIF
                  ENDIF

                  lRetorno:= .F.

                  cTabela:= PAD( ALLTRIM( cTabela ), 2 )
                  IF lPrinter
                     lRetorno:= impVendeProduto( cCodFab,;
                                  Left( cProdut, 30 ),;
                                  cTabela,;
                                  nQuantidade,;
                                  nPreco,;
                                  IF( nStatus==9, nDescPercentual, 0 ),;
                                  IF( nStatus==9, nDescValor, 0 ),;
                                  VDA->( LastRec() ),;
                                  cUnidad )
                  ENDIF
                  IF lRetorno .OR. Impressora=="Nenhuma"
                     VendaFile( _VENDA_ITEM, nPrecoFinal, nQuantidade, ;
                                cTabela, @nTamEAN, @nCorEAN, cProdut, cCodFab, cUnidad )
                     lCancelaItem:= .F.
                     nDescPercentual:= 0
                     nDescValor:= 0
                     DispCupom( Left( cProdut, 31), 4 )
                     DispValor( Tran( nPrecoFinal, "@E 999,999.99"), 4 )
                     nTotal:= nTotal + nPrecoFinal
                  ELSE
                     DispCupom( "**** FALHA NA VENDA DESTE PRODUTO ****", 13 )
                  ENDIF
               ELSEIF nStatus==4
                  IF VendaFile( _BUSCAR_ITEM, MPR->INDICE )
                     nPosicao:=    VendaFile( _INFORMACOES_ITEM )[ 1 ]
                     nPrecoFinal:= VendaFile( _INFORMACOES_ITEM )[ 9 ]
                     IF VendaFile( _ANULAR_ITEM, MPR->INDICE )
                        IF lPrinter
                           impCancItem( nPosicao )
                        ENDIF
                        nTotal-= nPrecoFinal
                        DispCupom( MPR->DESCRI, 5 )
                        lCancelaItem:= .F.
                     ELSE
                        DispCupom( "** ITEM NAO EXCLUIDO **", 3 )
                        lCancelaItem:= .F.
                     ENDIF
                  ELSE
                     DispCupom( "** ITEM SELECIONADO NAO CONSTA NA LISTA VENDIDA **", 5 )
                     lCancelaItem:= .F.
                  ENDIF
               ENDIF
               nDescPercentual := 0
               nDescValor := 0
               nQuantidade:= 1
               lSubTotal:= .T.
               IF !nStatus==10
                  nStatus:= 2
               ENDIF
               LoadcSet( 0, cFontBrowse )

         CASE nTecla==K_F4
              IF Impressora=="SWEDA" /* Impressora cancela somente item anterior */
                 /* Busca e anula o ultimo item da lista */
                 VendaFile( _BUSCAR_ITEM )
                 nItem:=       VendaFile( _INFORMACOES_ITEM )[ 1 ]
                 cDescricao:=  VendaFile( _INFORMACOES_ITEM )[ 4 ]
                 nPrecoFinal:= VendaFile( _INFORMACOES_ITEM )[ 9 ]

                 // Anula Item
                 VendaFile( _ANULAR_ITEM )
                 VendaFile( _BUSCAR_ITEM )

                 // Cancela na Impressora Fiscal
                 IF lPrinter
                    impCancItem( nItem )
                 ENDIF
                 nTotal-= nPrecoFinal

                 // Exibe nome do Item cancelado
                 DispCupom( cDescricao, 5 )

              ELSE /* Outras impressoras, que permitem cancelar qualquer item */
                 cBusca:= ""; lAchou := .T.
                 IF nStatus == 2 .OR. nStatus == 4
                    lCancelaItem:= IF( lCancelaItem, .F., .T. )
                    nStatus:= IF( lCancelaItem, 4, 2 )
                    lSubTotal:= .T.
                 ENDIF
              ENDIF

         CASE nTecla==K_CTRL_ENTER
              MudaTabela()


         CASE nTecla==K_F12
              cBusca:= ""; lAchou := .T.
              IF nStatus == 2 .OR. nStatus == 1 .OR. nStatus == 8
                 IF !( nStatus==8 )
                    nStatusAnt:= nStatus
                 ENDIF
                 nStatus:= IF( nStatus==8, nStatusAnt, 8 )
                 lSubTotal:= .T.
              ENDIF

         CASE nTecla==K_F8 .AND. nStatus==2
              cBusca:= ""; lAchou := .T.
              //mCurOff()
              nSaveF8:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F8__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )
              SWGBox( 220, 220, 1250, 800, "Cadastro de Clientes", 15 )

              BoxFill( 415, 680, 770, 40, 20 + 32, 0 )
              BoxFill( 415, 622, 620, 40, 20 + 32, 0 )
              BoxFill( 415, 562, 450, 40, 20 + 32, 0 )
              BoxFill( 415, 505, 520, 40, 20 + 32, 0 )
              BoxFill( 415, 445, 050, 40, 20 + 32, 0 )
              BoxFill( 415, 387, 150, 40, 20 + 32, 0 )
              BoxFill( 415, 327, 315, 40, 20 + 32, 0 )

              cCorRes:= SetColor( "08/15,01/15" )
              Mensagem()
              @ 10, 15 Say "Cliente  " Get cCliDescri ;
                 When Mensagem( "Digite o Nome do cliente" ) ;
                 Valid BuscaCli( @nCliCodigo, @cCliDescri, @cCliEndere, ;
                    @cCliBairro,  @cCliCidade,  @cCliEstado,  @cCliCodCep, ;
                    @cCliCGCCPF, GetList )
              @ 12, 15 Say "Endereco " Get cCliEndere ;
                 When Mensagem( "Digite o Endereco do Cliente" )
              @ 14, 15 Say "Bairro   " Get cCliBairro ;
                 When Mensagem( "Digite o Bairro do cliente" )
              @ 16, 15 Say "Cidade   " Get cCliCidade ;
                 When Mensagem( "Digite a Cidade do cliente" )
              @ 18, 15 Say "Estado   " Get cCliEstado ;
                 When Mensagem( "Digite o Estado  do cliente" )
              @ 18, 15 Say "Fone   " Get cCliFone ;
                 When Mensagem( "Digite o Estado  do cliente" )
              @ 20, 15 Say "CEP      " Get cCliCodCep ;
                 When Mensagem( "Digite o Cep do cliente" )
              @ 22, 15 Say "CGC/CPF  " Get cCliCgcCpf ;
                 When Mensagem( "Digite o CFG/CPF do cliente" )

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SetColor( cCorRes )
              SWSnapPaste( 50, 100, nSaveF8 )
              SWSnapKill( @nSaveF8 )
              //mCurOn()

              DbSelectAr( _COD_CLIENTE )
              IF Alltrim( CLI->DESCRI )==Alltrim( cCliDescri ) .AND. !EMPTY( cCliDescri )
                 nCliCodigo:= CLI->CODIGO
                 nSalLimCre := CLI->SALDO_ - nTotal
                 DispCupom( "Cliente ATIVADO !", 2 )
                 nRegAtuCli := CLI->(RECNO ())
              ELSEIF !( LastKey()==K_ESC )
                 SWGAviso( "CADASTRO DE CLIENTES",;
                           {{0, " "},;
                            {0, "   O cliente digitado nao consta no cadastro!"},;
                            {0, " "},;
                            {0, "   Acione a tecla [TAB] para inclui-lo no cadastro" },;
                            {0, " "}}, 7, 4)
                 IF LastKey()==K_TAB
                    nOrdRes:= IndexOrd()
                    CLI->( DBSetOrder( 1 ) )
                    CLI->( DBSeek( 999999 ) )
                    CLI->( DBSkip(-1) )
                    nCliCodigo:= CLI->CODIGO + 1
                    CLI->( DBAppend() )
                    CLI->( RLock() )
                    IF !( CLI->( NetErr() ) )
                       Replace CLI->CODIGO With nCliCodigo,;
                               CLI->DESCRI With cCliDescri,;
                               CLI->ENDERE With cCliEndere,;
                               CLI->BAIRRO With cCliBairro,;
                               CLI->CIDADE With cCliCidade,;
                               CLI->ESTADO With cCliEstado,;
                               CLI->CODCEP With cCliCodCep
                        IF Len( Alltrim( ALLTRIM( cCliCGCCPF ) ) )==11
                           Replace CLI->CPF___ With cCliCgcCpf
                        ELSE
                           Replace CLI->CGCMF_ With cCliCgcCpf
                        ENDIF
                    ENDIF
                    DBSetOrder( nOrdRes )
                    DispCupom( "Cliente ATIVADO !", 2 )
                    nRegAtuCli:= CLI->( RECNO() )
                 ELSE
                    nCliCodigo:= 0
                    nRegAtuCli:= 0
                    DispCupom( "Cliente DESATIVADO !", 2 )
                 ENDIF
              ENDIF
              DBSelectAr( _COD_MPRIMA )

         CASE nTecla==K_F11
              cBusca:= ""; lAchou := .T.
              //mCurOff()
              nSaveF11:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F11_.$$$" )
              loadcSet( 0, "VSYS14.PTX" )
              cCorRes:= SetColor( "08/15,03/15" )
              SetColor( "08/15,01/15" )
              SWGBox( 135, 339, 1210, 550, "Observacoes no Cupom", 7 )

              Mensagem()
              @ 18,10 Get cObserv1 When Mensagem( "Digite a Observacao que ira no Cupom" )
              @ 19,10 Get cObserv2 When Mensagem( "Digite a Observacao que ira no Cupom" )

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SetColor( cCorRes )
              SWSnapPaste( 50, 100, nSaveF11 )
              SWSnapKill( @nSaveF11 )
              oTab:RefreshAll()
              WHILE !oTab:Stabilize()
              ENDDO

         CASE nTecla == K_CTRL_F5
              cBusca:= ""; lAchou := .T.
              IF lPrinter
                 impSubTotCupom()
              ENDIF

         CASE (nTecla == K_CTRL_F10)
              cBusca:= ""; lAchou := .T.
              SetColor( 0 )
              IF VDA->( LASTREC() ) <= 0
                 IF FILE( _BACKUP )
                    SWGAviso( "ANULACAO DO CUPOM FISCAL ( ANTERIOR )",;
                      {{0, " "},;
                       {0, "   O ultimo Cupom Fiscal gravado sera Restaurado e em seguida"},;
                       {0, "    anulado (Caixa/Estoque/Cupom/Receber) no sistema Fortuna. "},;
                       {0, "                                                              "},;
                       {0, "   Para confirmar pressione [F10]"},;
                       {0, "   Para continuar a rotina normal, pressione qualquer tecla. "},;
                       {0, " "}}, 7, 4)
                 ELSE
                    SWGAviso( "SEM REGISTRO ANTERIOR",;
                      {{0, " "},;
                       {0, "   O ultimo Cupom Fiscal gravado nao esta registrado ou ja   "},;
                       {0, "    foi cancelado anteriormente.                              "},;
                       {0, "   Para tentar cancalar novamente pressione [F10]"},;
                       {0, " "},;
                       {0, "   Para continuar a rotina normal, pressione qualquer tecla."},;
                       {0, " "}}, 7, 4)
                 ENDIF
              ELSE
                 SWGAviso( "ANULACAO DO CUPOM FISCAL ATUAL",;
                      {{0, " "},;
                       {0, "   O Cupom Fiscal que esta sendo impresso sera cancelado." },;
                       {0, "                                                  "},;
                       {0, "   Para confirmar pressione [F10]"},;
                       {0, " "},;
                       {0, "   Para continuar a rotina normal, peressione qualquer tecla"},;
                       {0, " "}}, 7, 4)
              ENDIF
              IF (LASTKEY()==K_CTRL_F10 .or. LASTKEY()==K_F10)
                 SetCursor( 0 )
                 IF !VDA->( LASTREC() ) > 0         /* Se esta com cupom em branco */
                    VDA->( DBCloseArea() )         /* restaura informacoes do ultimo */
                    VendaFile( _EXCLUIR )          /* cupom gravado no sistema neste */
                    VendaFile( _RESTAURAR )        /* computador e anula as informacoes */
                    Ferase( _BACKUP )
                    VendaFile( _ABRIR )            /* referentes ao mesmo */
                    DBSelectAr( _VENDAFILE )
                    loadcSet( 0, cFontBrowse )
                    IF LastRec() > 0
                       IF nStatus == 1
                          FOR nCt:= 1 TO 10
                              DispCupom( " ", 0, .F.)
                          NEXT
                       ENDIF
                       nTotal:= 0
                       NumeroCupom( Right( StrZero( VDA->NUMCUP, 9, 0 ), 6 ) )
                       DBGoTop()
                       DispCupom( "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\", 0, .T.)
                       DispCupom( " ", 0)
                       DispCupom( "CUPOM FISCAL RESTAURADO",  0)
                       DispCupom( " ", 0)
                       DispCupom( "VENDA FOI INICIADA AS " + VDA->HORA__ + "Hs.", 0 )
                       DispCupom( "Cupom Fiscal No. " + NumeroCupom(), 0 )
                       DispCupom( "Produto                                               Preco", 5)
                       DispCupom( "======================================= ==========", 0)
                       WHILE !EOF()
                          IF STATUS==" " .OR. STATUS=="X"
                             nTotal:= nTotal + PRECOT
                             DispCupom( Left( VDA->DESCRI, 31), 4 )
                             DispValor( Tran( VDA->PRECOV, "@E 999,999.99"), 4 )
                          ELSEIF STATUS=="E"
                             nTotal:= nTotal - PRECOT
                             DispCupom( Left( VDA->DESCRI, 31), 5 )
                             DispValor( Tran( VDA->PRECOV, "@E 999,999.99"), 5 )
                          ENDIF
                          DBSkip()
                       ENDDO
                       INKEY( 2 )
                       lSubTotal:= .T.
                       nStatus:= 2
                       CancelaCaixa( nTotal )
                       CancelaReceber( NumeroCupom() )
                    ENDIF
                    DBSelectAr( _COD_MPRIMA )
                    MPR->( DBSetOrder( 2 ) )
                    MPR->( DBGotop( ) )
                    AnulaCupom( impCupomAtual(), nTotal )
                 ENDIF
                 IF lPrinter
                    ImpCancCupom()
                 ENDIF
                 VendaFile( _EXCLUIR )
                 VendaFile( _CRIAR )
                 VendaFile( _ABRIR )
                 DispCupom( "Cupom ANULADO!", 2 )
                 EXIT
              ENDIF

         CASE nTecla == K_CTRL_F12 .AND. nStatus==2
              cBusca:= ""; lAchou := .T.
              SWGAviso( "LIMPEZA DO BUFFER DO CUPOM FISCAL (SEM IMPRESSAO)",;
                      {{0, " "},;
                       {0, "   O Buffer do Cupom Fiscal sera LIMPO !"},;
                       {0, " "},;
                       {0, "   Para confirmar, acione as teclas [Ctrl+F12], novamente"},;
                       {0, " "},;
                       {0, "   Para continuar a rotina normal, acione qualquer tecla"}, ;
                       {0, " "}}, 7, 4)

              IF (LASTKEY () == K_CTRL_F12)
                 VendaFile( _EXCLUIR )
                 VendaFile( _CRIAR )
                 VendaFile( _ABRIR )
                 nTotal:= 0
                 nSalLimCre := 0
                 EXIT
                //PicRead( 780, 400, 001, "FORTUNA.SYS" )
              ENDIF

         CASE nTecla == K_F3
              cBusca:= ""; lAchou := .T.
              nPreco:= MPR->( PrecoConvertido() )
              nSaveF3:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F3__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )

              SWGBox( 220, 475, 660, 740, "Desconto Percentual/Valor" , 15 )
              BoxFill( 460, 620, 170, 40, 20 + 32, 0 )
              BoxFill( 460, 560, 170, 40, 20 + 32, 0 )

              cCorRes:= SetColor( "08/15,01/15" )
              nDescPercentual:= 0
              nDescValor:= 0
              @ 12,15 Say "Desconto(%)"
              @ 14,15 Say "Valor      "

              Mensagem()
              @ 12,28 Get nDescPercentual Pict "   99.99%" ;
                When Mensagem( "Digite o % de desconto" )
              @ 14,28 Get nDescValor      Pict "@E 9,999.99" ;
                When Mensagem( "Digite o Valor do desconto" ) .AND. ;
                   nDescPercentual == 0

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SetColor( cCorRes )
              SWSnapPaste( 50, 100, nSaveF3 )
              SWSnapKill( @nSaveF3 )

              IF (nDescPercentual > 0 .OR. nDescValor > 0)
                 nStatus := 9
                 lSubTotal:= .T.
              ENDIF

         CASE nTecla == K_F1
              cBusca:= ""; lAchou := .T.
              nSaveF1:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F1__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )

              SWGBox( 221, 489, 671, 720, "Quantidade" , 15 )
              BoxFill( 450, 590, 190, 40, 20 + 32, 0 )
              cCorRes:= SetColor( "08/15,01/15" )

              @ 13,15 Say "Quantidade"

              nTeclaRes:= Inkey( 0 )

              IF nTeclaRes == K_F1
                 nQuantidade:= nUltimaQuantidade
                 @ 13, 28 Say nQuantidade Pict "@E 99999.999"
              ELSE
                 nQuantidade:= 0
                 Keyboard Chr( nTeclaRes )
              ENDIF

              Mensagem()
              @ 13,28 Get nQuantidade Pict "@E 99999.999" ;
                When Mensagem( "Digite a Quantidade" ) ;
                Valid nQuantidade > 0

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              nUltimaQuantidade:= nQuantidade
              lSubTotal:= .T.
              SWSnapPaste( 50, 100, nSaveF1 )
              SWSnapKill( @nSaveF1 )
              SetColor( cCorRes )

         CASE nTecla == K_F7 .AND. nStatus==2
              cBusca:= ""; lAchou := .T.
              nSaveF7:= SWSnapCopy( 50, 100, 1320, 980, 0, "PDV_F7__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )

              nBanco:= 0
              aParcelas:= 0
              aParcelas:= {}
              nValorPagar:= 0
              nPerAcrDes:= 0
              nVlrAcrDes:= 0
              cAcrDes:= "D"
              nVezes:= 0
              nBanco:= 0
              nLocal:= 0
              nPrazo:= 0
              nParcela:= 0
              nPercentual:= 0
              dVencimento:= DATE()
              dPagamento:= CTOD( "  /  /  " )
              cCheque:= Space( 15 )

              SWGBox( 220, 350,  995, 800, "Condicoes de Pagamento", 15 )

              BoxFill( 605, 680,  50, 40, 20 + 32, 0 )
              BoxFill( 605, 622, 145, 40, 20 + 32, 0 )
              BoxFill( 605, 562, 350, 40, 20 + 32, 0 )
              BoxFill( 605, 505, 350, 40, 20 + 32, 0 )
              BoxFill( 605, 445, 100, 40, 20 + 32, 0 )

              SetColor( "08/15,01/15" )
              @ 10,15 Say "Acresc/Desc(A/D)   "
              @ 12,15 Say "Acresc/Desc(%)     "
              @ 14,15 Say "Acresc/Desc(R$)    "
              @ 16,15 Say "Total a Pagar      "
              @ 18,15 Say "Vendedor           "

              Mensagem()

              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )

              @ 10,37 Get cAcrDes ;
                              Pict "!" ;
                              When Mensagem( "Digite [A]Acrescimo [D]Desconto") ;
                              Valid cAcrDes $ "DA" .AND.;
                              AcrDes( cAcrDes, nPerAcrDes, ;
                              @nVlrAcrDes, @nValorPagar, ;
                              nTotal )
              @ 12,36 Get nPerAcrDes ;
                              Pict "@R  999.99%" When ;
                              Mensagem( "Digite o % de Acrescimo/Desconto" ) .AND.;
                              IF( nVlrAcrDes > 0, Pula(), .T. ) Valid ;
                              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )
              @ 14,36 Get nVlrAcrDes ;
                              Pict "@E    99,999,999,999.99" When ;
                              Mensagem( "Digite o Valor de Acrescimo/Desconto" ) .AND.;
                              IF( nPerAcrDes > 0, Pula(), .T. ) Valid ;
                              ExibeTotais( "A Pagar ", nValorPagar ) .AND.;
                              AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )
              @ 16,36 Get nValorPagar Pict "@E    99,999,999,999.99" When;
                              Mensagem( "Digite o Valor a pagar" )
              @ 18,36 Get nVendedor Pict "@R   999" Valid BuscaVendedor( @nVendedor ) When;
                              Mensagem( "Digite o Codigo do vendedor" )

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SWSnapPaste( 50, 100, nSaveF7 )
              //SWSnapKill( @nSaveF7 )

              IF LastKey() == K_ESC
                 LOOP
              ENDIF

              /* Apresenta as formas de pagamento cadastradas */
              FormaPagamento( 10, 15, 23, 70, aParcelas, nValorPagar, @nVezes, ;
                              @nForma, @cForma )

              nTamPar := LEN (aParcelas)

              IF LastKey() == K_ESC
                 LOOP
              ENDIF

              SWGBox ( 520, 490, 860, 720, "Parcelas", 15 )
              BoxFill( 740, 590,  70, 40, 20 + 32, 0 )

              cCorRes:= SetColor( "08/15,01/15" )
              Mensagem()
              @ 13,33 Say "Parcelas"
              @ 13,45 Get nVezes Pict "99" When;
                Mensagem( "Numero de Vezes" ) Valid LastKey()==K_ENTER

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SWSnapPaste( 50, 100, nSaveF7 )

              IF LastKey() == K_ESC
                 SWSnapKill( @nSaveF7 )
                 LOOP
              ENDIF

// LEMBRETE : NA PARCELA 4 DE 5 SER FOR DIGITADO UM PERCENTUAL E AVANCAR PARA A
//            PROXIMA, RETORNAR COM PGUP E AVANCAR DENOVO, O CALCULO DA QUINTA
//            PARCELA NAO OCORRE ADEQUADAMENTE ! AIRAN

              FOR nCt:= 1 TO nVezes

                  nParPerAcu := 0
                  nParValAcu := 0
                  IF (nCt > 1)
                     FOR J = 1 TO nCt - 1
                         nParPerAcu += aParcelas[ J ][ 1 ]
                         nParValAcu += aParcelas[ J ][ 3 ]
                     NEXT J
                  ENDIF
                  nParPerAnt := (100 - nParPerAcu) / (nVezes - nCt + 1)
                  nParValAnt := (nValorPagar - nParValAcu) / (nVezes - nCt + 1)

                  IF nCt <= nTamPar .OR. nCt <= LEN (aParcelas)
                     IF (LASTKEY () <> K_PGUP)
                        aParcelas[ nCt ][ 1 ] := nParPerAnt
                        aParcelas[ nCt ][ 3 ] := nParValAnt
                     ENDIF
                     nPercentual           := aParcelas[ nCt ][ 1 ]
                     nPrazo                := aParcelas[ nCt ][ 2 ]
                     nParcela              := aParcelas[ nCt ][ 3 ]
                     dVencimento           := aParcelas[ nCt ][ 4 ]
                     dPagamento            := aParcelas[ nCt ][ 5 ]
                     nBanco                := aParcelas[ nCt ][ 6 ]
                     cCheque               := aParcelas[ nCt ][ 7 ]
                     nLocal                := aParcelas[ nCt ][ 8 ]
                     lManual               := .F.
                  ELSE
                     nPercentual           := nParPerAnt
                     nPrazo                := 0
                     nParcela              := nParValAnt
                     dVencimento           := DATE()
                     dPagamento            := CTOD( "  /  /  " )
                     nBanco                := 0
                     cCheque               := Space( 15 )
                     nLocal                := 0
                  ENDIF

                  SWGBox( 220, 200, 820, 825, "Parcela " + ;
                    ALLTRIM( Str( nCt, 3, 0 ) ) + " de " + ;
                    ALLTRIM( Str( nVezes, 3, 0 ) ), 15 )
                  BoxFill( 510, 707, 142, 40, 20 + 32, 0 )
                  BoxFill( 510, 649, 210, 40, 20 + 32, 0 )
                  BoxFill( 510, 591,  80, 40, 20 + 32, 0 )
                  BoxFill( 510, 533, 160, 40, 20 + 32, 0 )
                  BoxFill( 510, 475, 160, 40, 20 + 32, 0 )
                  BoxFill( 510, 417,  80, 40, 20 + 32, 0 )
                  BoxFill( 510, 357, 280, 40, 20 + 32, 0 )
                  BoxFill( 510, 297,  80, 40, 20 + 32, 0 )
                  SetColor( "08/15,01/15" )

                  @ 09,15 Say "Percentual "
                  @ 11,15 Say "Valor      "
                  @ 13,15 Say "Prazo/Dias "
                  @ 15,15 Say "Vencimento "
                  @ 17,15 Say "Pagamento  "
                  @ 19,15 Say "Banco      "
                  @ 21,15 Say "Cheque     "
                  @ 23,15 Say "Local      "

                  Mensagem()

                  nPercAnt := nPercentual
                  @ 09,31 Get nPercentual Pict "999.99%" ;
                     When Mensagem( "Digite o Percentual da Parcela" ) ;
                        .AND. nCt <> nVezes ;
                     Valid CalcParcela( nValorPagar, nPercentual, @nParcela, ;
                     lManual, @nPercAnt ) .AND. !LastKey()==K_ESC ;
                     .AND. nPercentual < (100 - (nVezes - nCt - 1) * 0.01 - nParPerAcu)

                  @ 11,31 Get nParcela Pict "@E 9999,999.99" ;
                     When Mensagem( "Digite o Valor da Parcela" ) ;
                        .AND. nCt <> nVezes ;
                        .AND. nPercAnt == nPercentual ;
                     Valid fCalcPerc (@nPercentual, @nValorPagar, @nParcela ) ;
                        .AND. !LastKey()==K_ESC ;
                        .AND. nParcela < (nValorPagar - (nVezes - nCt - 1) * 0.01 - nParValAcu)

                  @ 13,31 Get nPrazo Pict "999" ;
                     When Mensagem( "Digite o Prazo em dias" ) ;
                     Valid CalcVenc( DATE(), nPrazo, @dVencimento ) ;
                        .AND. !LastKey()==K_ESC

                  @ 15,31 Get dVencimento ;
                     When Mensagem( "Digite a Data de Vencimento" ) ;
                     Valid !LastKey()==K_ESC

                  @ 17,31 Get dPagamento  ;
                     When Mensagem( "Digite a Data de Quitacao" ) ;
                     Valid !LastKey()==K_ESC

                  @ 19,31 Get nBanco Pict "999" ;
                     When Mensagem( "Digite o Banco do Cheque" ) ;
                     Valid !LastKey()==K_ESC

                  @ 21,31 Get cCheque           ;
                     When Mensagem( "Digite o Numero do Cheque" ) ;
                     Valid !LastKey()==K_ESC

                  @ 23,31 Get nLocal Pict "999" ;
                     When Mensagem( "Digite a Localizacao" ) ;
                     Valid ( !LastKey()==K_ESC .AND. VerificaQuit( dPagamento, nLocal ) )

                  /* Se nÆo estiver quitado nao deixa informar caixa==0 */

                  SetCursor( 1 )
                  READ
                  SetCursor( 0 )

                  IF LastKey() == K_ESC
                     aParcelas:= 0
                     aParcelas:= {}
                     EXIT
                  ENDIF

                  IF LastKey() == K_PGUP
                     nCt:= nCt - 2
                     IF nCt < 0
                        nCt:= 0
                     ENDIF
                  ELSE
                     IF nCt <= nTamPar
                        aParcelas[ nCt ][ 1 ]:= nPercentual
                        aParcelas[ nCt ][ 2 ]:= nPrazo
                        aParcelas[ nCt ][ 3 ]:= nParcela
                        aParcelas[ nCt ][ 4 ]:= dVencimento
                        aParcelas[ nCt ][ 5 ]:= dPagamento
                        aParcelas[ nCt ][ 6 ]:= nBanco
                        aParcelas[ nCt ][ 7 ]:= cCheque
                        aParcelas[ nCt ][ 8 ]:= nLocal
                     ELSE
                        AAdd( aParcelas, { nPercentual,;
                                           nPrazo,;
                                           nParcela,;
                                           dVencimento,;
                                           dPagamento,;
                                           nBanco,;
                                           cCheque,;
                                           nLocal } )
                     ENDIF
                  ENDIF
              NEXT

              IF (LEN (aParcelas) > 0)
                 ASIZE( aParcelas, nVezes )
              ENDIF

              SWSnapPaste( 50, 100, nSaveF7 )
              SWSnapKill( @nSaveF7 )
              DBSelectAr( _COD_MPRIMA )
              oTab:RefreshAll()
              WHILE !oTab:stabilize()
              ENDDO
              lDisplay:= .F.
              IF (LEN (aParcelas) > 0)
                 DispCupom( "Condicoes de Pagamento ATIVADA !", 2 )
                 DispCupom( "Cliente.: " + cCliDescri,              1 )
                 DispCupom( "Parcelas: " + StrZero( nVezes, 2, 0 ), 1 )
                 DispCupom( "Cupom Fiscal pode ser finalizado...",  1 )
              ELSE
                 DispCupom( "Condicoes de Pagamento CANCELADA !", 1 )
              ENDIF
//            Inkey(0)

         CASE nTecla == K_F6 .AND. nStatus==2
              cBusca:= ""; lAchou := .T.
              nValorPago:= 0
              nValorPagar:= 0
              nVezes:= 0

              loadcSet( 0, "VSYS14.PTX" )
              nSaveF6:= SWSnapCopy( 50, 100, 1320, 950, 0, "PDV_F6__.$$$" )

              IF Len( aParcelas ) > 0
                 CLI->( DBSetOrder( 1 ) )
                 CLI->( DBSeek( nCliCodigo ) )
                 nSalLimCre:= CLI->SALDO_ - nTotal
                 IF !fVerLimCred( @lLimCredAvis, @nCliCodigo, @nTotal, @nSalLimCre )
                 ENDIF
                 AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )
              ELSEIF Len( aParcelas ) <= 0

                  IF (MoedasEspecificas == "NAO")

                     // SEM MOEDAS ESPECIFICAS
                     WHILE (.T.)

                       SWGBox( 220, 289,  950, 800, "Fechamento da Venda", 15 )

                       BoxFill( 555, 680,  65, 40, 20 + 32, 0 )
                       BoxFill( 555, 622, 145, 40, 20 + 32, 0 )
                       BoxFill( 555, 562, 365, 40, 20 + 32, 0 )
                       BoxFill( 555, 505, 365, 40, 20 + 32, 0 )
                       BoxFill( 555, 445, 365, 40, 20 + 32, 0 )
                       BoxFill( 555, 385, 115, 40, 20 + 32, 0 )

                       SetColor( "08/15,01/15" )

                       Keyboard Chr( K_DOWN ) + Chr( K_DOWN ) + Chr( K_DOWN )
                       @ 10,15 Say "Acresc/Desc(A/D) "
                       @ 12,15 Say "Acresc/Desc(%)   "
                       @ 14,15 Say "Acresc/Desc(R$)  "
                       @ 16,15 Say "Total a Pagar    "
                       @ 18,15 Say "Valor Pago       "
                       @ 20,15 Say "Vendedor         "

                       Mensagem()
                       @ 10,34 Get cAcrDes ;
                               Pict "!" ;
                               When Mensagem( "Digite [A]Acrescimo/[D]Desconto" ) ;
                               Valid cAcrDes $ "D" .AND. ;
                               AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, ;
                               @nValorPagar, nTotal )
                       @ 12,34 Get nPerAcrDes ;
                               Pict "@R 999.99%" ;
                               When IF( nVlrAcrDes > 0, Pula(), .T. ) .AND. ;
                               Mensagem( "Digite o % Acrescimo/Desconto" ) ;
                               Valid AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes,;
                               @nValorPagar, nTotal )
                       @ 14,33 Get nVlrAcrDes ;
                               Pict "@R    99,999,999,999.99" ;
                               When IF( nPerAcrDes > 0, Pula(), .T. ) .AND.;
                               Mensagem( "Valor Acrescimo/Desconto" ) ;
                               Valid ExibeTotais( "A Pagar ", nValorPagar ) .AND. ;
                               AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, ;
                               @nValorPagar, nTotal )
                       @ 16,33 Get nValorPagar ;
                               Pict "@E    99,999,999,999.99" ;
                               When Pula() .AND. ;
                               Mensagem( "Digite o Valor a Pagar" );
                                 Color "04/15"
                       @ 18,33 Get nValorPago ;
                               Pict "@R    99,999,999,999.99" ;
                               When Mensagem( "Digite o Valor Pago" ) ;
                               Valid INT( nValorPago ) >= INT( nValorPagar ) .OR. ;
                                 LastKey() == K_UP
                       @ 20,33 Get nVendedor ;
                               Pict "@R   999" ;
                               When Mensagem( "Digite o Codigo do Vendedor" ) ;
                               Valid BuscaVendedor( @nVendedor )

                       SetCursor( 1 )
                       READ
                       SetCursor( 0 )

                       IF (AvisaValorPago == "SIM")
                          IF (LASTKEY () == K_ESC .OR. ;
                             fValorPago (@nValorPago, @nValorPagar) == .T.)
                             EXIT
                          ENDIF
                       ELSE
                          EXIT
                       ENDIF

                     END

                     SWSnapPaste( 50, 100, nSaveF6 )

                 ELSE

                     // COM MOEDAS ESPECIFICAS

                     WHILE (.T.)

                       SWGBox( 220, 170,  950, 920, "Fechamento da Venda", 15 )

                       BoxFill( 555, 796,  65, 40, 20 + 32, 0 ) // Acresc/Desc(A/D)
                       BoxFill( 805, 796, 115, 40, 20 + 32, 0 ) // Em(%)
                       BoxFill( 555, 738, 365, 40, 20 + 32, 0 ) // Acresc/Desc(R$)
                       BoxFill( 555, 680, 365, 40, 20 + 32, 0 ) // Total a Pagar

                       BoxFill( 555, 622, 365, 40, 20 + 32, 0 ) // Em Ticket's
                       BoxFill( 555, 562, 365, 40, 20 + 32, 0 ) // Em Cheque
                       BoxFill( 555, 505, 365, 40, 20 + 32, 0 ) // Em Cartao
                       BoxFill( 555, 445, 365, 40, 20 + 32, 0 ) // Em Outros
                       BoxFill( 555, 385, 365, 40, 20 + 32, 0 ) // Em Dinheiro
// INICIO DAS FLORZINHAS! //AQUI
                       BoxFill( 285, 622, 255, 40, 20 + 32, 0 ) // Em Ticket's
                       BoxFill( 285, 562, 255, 40, 20 + 32, 0 ) // Em Cheque
                       BoxFill( 285, 505, 255, 40, 20 + 32, 0 ) // Em Cartao
                       BoxFill( 285, 445, 255, 40, 20 + 32, 0 ) // Em Outros
                       BoxFill( 285, 385, 255, 40, 20 + 32, 0 ) // Em Dinheiro

                       @ 12,15 Say "" Color "14/15" // "07/15"
                       @ 14,15 Say "" Color "14/15" // "07/15"
                       @ 16,15 Say "" Color "14/15" // "07/15"
                       @ 18,15 Say "" Color "14/15" // "07/15"
                       @ 20,15 Say "" Color "14/15" // "07/15"
// FIM DAS FLORZINHAS!
                       BoxFill( 555, 325, 365, 40, 20 + 32, 0 ) // Troco
                       BoxFill( 555, 265, 115, 40, 20 + 32, 0 ) // Vendedor

                       SetColor( "08/15,01/15" )

                       Keyboard Chr( K_DOWN ) + Chr( K_DOWN ) + Chr( K_DOWN )
                       @ 06,15 Say "Acresc/Desc(A/D) "
                       @ 06,41 Say "Em(%)"
                       @ 08,15 Say "Acresc/Desc(R$)  "
                       @ 10,15 Say "Total a Pagar    "

                       @ 12,18 Say "Em Ticket's " // Color "14/15"
                       @ 14,18 Say "Em Cheque   " // Color "14/15"
                       @ 16,18 Say "Em Cartao   " // Color "14/15"
                       @ 18,18 Say "Em Outros   " // Color "14/15"
                       @ 20,18 Say "Em Dinheiro " // Color "14/15"

                       @ 22,15 Say "Troco            "
                       @ 24,15 Say "Vendedor         "

                       nPgtDin := nValorPagar
                       @ 20,34 Say nPgtDin Pict "@E    99,999,999,999.99"

                       Mensagem()
                       @ 06,34 Get cAcrDes ;
                               Pict "!" ;
                               When Mensagem( "Digite [A]Acrescimo/[D]Desconto" ) ;
                               Valid cAcrDes $ "D" .AND. ;
                               AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, ;
                               @nValorPagar, nTotal ) .AND. ;
                                  fPgtDin (@nValorPagar, GetList)
                       @ 06,48 Get nPerAcrDes ;
                               Pict "@R 999.99" ;
                               When Mensagem( "Digite o % Acrescimo/Desconto" ) ;
                               Valid AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes,;
                               @nValorPagar, nTotal ) .AND. ;
                                  fPgtDin (@nValorPagar, GetList)
                       @ 08,34 Get nVlrAcrDes ;
                               Pict "@R    99,999,999,999.99" ;
                               When Mensagem( "Valor Acrescimo/Desconto" ) ;
                               Valid ExibeTotais( "A Pagar ", nValorPagar ) .AND. ;
                               AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, ;
                               @nValorPagar, nTotal ) .AND. ;
                                  fPgtDin (@nValorPagar, GetList)
                       @ 10,34 Get nValorPagar ;
                               Pict "@E    99,999,999,999.99" ;
                               When Pula() .AND. ;
                                 Mensagem( "Digite o Valor a Pagar" ) ;
                                 Color "04/15"

                       @ 12,34 Get cPgtTic Pict "@KS20" ;
                               When Mensagem( "Digite o quanto sera pago em Ticket's" ) ;
                               Valid fExiFor( cPgtTic, "nPgtTic" ) Color "02/15"
                       @ 12,34 Get nPgtTic Pict "@E    99,999,999,999.99" ;
                               Valid fExiForNum( @cPgtTic, nPgtTic, GetList ) ;
                                   .AND. fPgtDin (@nValorPagar, GetList)

                       @ 14,34 Get cPgtChq Pict "@KS20" ;
                               When Mensagem( "Digite o quanto sera pago em Cheque" ) ;
                               Valid fExiFor( cPgtChq, "nPgtChq" ) Color "02/15"
                       @ 14,34 Get nPgtChq Pict "@E    99,999,999,999.99";
                               Valid fExiForNum( @cPgtChq, nPgtChq, GetList ) ;
                                   .AND. fPgtDin (@nValorPagar, GetList)

                       @ 16,34 Get cPgtCar Pict "@KS20" ;
                               When Mensagem( "Digite o quanto sera pago com Cartao" ) ;
                               Valid fExiFor( cPgtCar, "nPgtCar" ) Color "02/15"

                       @ 16,34 Get nPgtCar Pict "@E    99,999,999,999.99";
                               Valid fExiForNum( @cPgtCar, nPgtCar, GetList ) ;
                                   .AND. fPgtDin (@nValorPagar, GetList)

                       @ 18,34 Get cPgtOut Pict "@KS20" ;
                               When Mensagem( "Digite o quanto sera pago em Outros" ) ;
                               Valid fExiFor( cPgtOut, "nPgtOut" ) Color "02/15" 

                       @ 18,34 Get nPgtOut Pict "@E    99,999,999,999.99";
                               Valid fExiForNum( @cPgtOut, nPgtOut, GetList ) ;
                                   .AND. fPgtDin (@nValorPagar, GetList)

                       @ 20,34 Get cPgtDin Pict "@KS20" ;
                               When Mensagem( "Digite o quanto sera pago em Dinheiro" ) ;
                               Valid fExiFor( cPgtDin, "nPgtDin" ) Color "02/15"

                       @ 20,34 Get nPgtDin Pict "@E    99,999,999,999.99" ;
                               Valid LastKey() == K_UP .OR. ;
                                     nPgtDin + nPgtTic + nPgtChq + nPgtCar + ;
                                     nPgtOut >= nValorPagar .AND. ;
                                     fExiForNum( @cPgtDin, nPgtDin, GetList ) ;
                                    .AND. fTroco( @nValorPagar, @nValorPago)

                       @ 24,34 Get nVendedor Pict "@R   999" ;
                               When Mensagem( "Digite o Codigo do Vendedor" ) ;
                               Valid BuscaVendedor( @nVendedor )

                       SetCursor( 1 )
                       READ
                       SetCursor( 0 )

                       IF (AvisaValorPago == "SIM")
                          IF (LASTKEY () == K_ESC .OR. ;
                             fValorPago (@nValorPago, @nValorPagar) == .T.)
                             EXIT
                          ENDIF
                       ELSE
                          EXIT
                       ENDIF

                     END

                     SWSnapPaste( 50, 100, nSaveF6 )

                 ENDIF

              ENDIF

              IF !LastKey() == K_ESC

                 /* Consumidor - Venda S/ cliente */
                 IF EMPTY( cCliDescri )
                    cCliDescri:= "CONSUMIDOR"
                    nCliCodigo:= 1
                 ENDIF

                 IF lPrinter
                    ImpAbreGaveta()
                 ENDIF

                 aAviso:= {}
                 FOR nCt:= 1 TO Len( aParcelas )
                     nPercentual:= aParcelas[ nCt ][ 1 ]
                     nPrazo:=      aParcelas[ nCt ][ 2 ]
                     nParcela:=    aParcelas[ nCt ][ 3 ]
                     dVencimento:= aParcelas[ nCt ][ 4 ]
                     dPagamento:=  aParcelas[ nCt ][ 5 ]
                     nBanco:=      aParcelas[ nCt ][ 6 ]
                     cCheque:=     aParcelas[ nCt ][ 7 ]
                     nLocal:=      aParcelas[ nCt ][ 8 ]
                     AAdd( aAviso, {0, " " + Tran( nPercentual, "@E 999.99%" ) +;
                                         Tran( nParcela, "@E 9,999,999.99" ) + " " +;
                                         DTOC( dVencimento )}  )
                 NEXT

                 IF Len( aParcelas ) > 0
                    SWGAviso( "CONDICOES DE PAGAMENTO                                     [F10]Anula", aAviso, 7, 3 )
                 ENDIF

                  IF (LASTKEY () == K_ESC)
                     LOOP
                  ENDIF

//               ExibeTotais( "Troco", nValorPago - nValorPagar )
                 //oTb:RefreshAll()
                 //WHILE !oTB:stabilize()
                 //ENDDO
                 IF cAcrDes == "D"
                    IF nPerAcrDes > 0
                       /* deixar negativo caso seja desconto */
                       nPerAcrDes:= nPerAcrDes * (1)
                    ELSEIF nVlrAcrDes > 0
                       /* Deixar negativo caso seja desconto */
                       nVlrAcrDes:= nVlrAcrDes * (1)
                    ENDIF
                 ENDIF
                 //cCgcCpf:= IF( Empty( cCGC___ ),;
                 //               Tran( cCpf___, "99999999999" ),;
                 //               Tran( cCGC___, "99999999999999" ) )
                 cMensagem:= ""
                 IF !EMPTY( cObserv1 )
                    cMensagem:= cMensagem + cObserv1 + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 IF !EMPTY( cObserv2 )
                    cMensagem:= cMensagem + cObserv2 + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 IF !EMPTY( cObserv3 )
                    cMensagem:= cMensagem + cObserv3 + Chr( 13 ) + Chr( 10 )
                 ENDIF
                 IF !EMPTY( cCliDescri )
                    cMensagem:= cMensagem + cCliDescri + Chr( 13 ) + Chr( 10 ) +;
                                cCliEndere + Chr( 13 ) + Chr( 10 ) +;
                                Alltrim( cCliCidade ) + "-" + cCliEstado + Chr( 13 ) + Chr( 10 )
                 ENDIF

                 IF !Impressora=="SIGTRON-FS345"
                    cCrediario:= "Pagamento: A VISTA"
                 ELSE
                    cCrediario:= ""
                 ENDIF

                 nCol:= 1
                 IF Len( aParcelas ) > 0 .AND. CarneInterno
                    lExibeParcelas:= .F.
                    FOR nCt:= 1 TO Len( aParcelas )
                        /* Se nÆo econtrar o banco na lista de nÆo imprimir */
                        IF !( ASCAN( NaoImprimeCarne, aParcelas[ nCt ][ 8 ] ) > 0 )
                           lExibeParcelas:= .T.
                           EXIT
                        ENDIF
                    NEXT
                    IF lExibeParcelas      
                       cCrediario:= "       F O R M A   D E   P A G A M E N T O     " + Chr( 13 ) + Chr( 10 )
                       cCrediario:= cCrediario + "Pr---Vencim--Valor------Pr---Vencim--Valor-----" + Chr( 13 ) + Chr( 10 )
                       FOR nCt:= 1 TO Len( aParcelas )
                           /* Se o Codigo do banco nesta Parcela nÆo estiver na lista de NaoImprimeCarne */
                           IF !( ASCAN( NaoImprimeCarne, aParcelas[ nCt ][ 8 ] ) > 0 )
                              cVlr:= Tran( aParcelas[ nCt ][ 3 ], "@E 999,999.99" )
                              cVenc:= DTOC( aParcelas[ nCt ][ 4 ] )
                              cP:= Str( aParcelas[ nCt ][ 2 ], 3, 0 )
                              cCrediario:= cCrediario + cP + " " + cVenc + " " + cVlr
                              IF nCol==2 .OR. nCt == Len( aParcelas )
                                 cCrediario:= cCrediario + Chr( 13 ) + Chr( 10 )
                                 nCol:= 0
                              ENDIF
                              nCol:= nCol + 1
                           ENDIF
                       NEXT
                       cCrediario:= cCrediario + "***-----------------*** ***-----------------***" + Chr( 13 ) + Chr( 10 )
                    ENDIF
                    cMensagem:= cMensagem + cCrediario
                 ELSEIF !CarneInterno .AND. Len( aParcelas ) > 0

                    /* Ver se e' para exibir parcelas */
                    lExibeParcelas:= .F.
                    FOR nCt:= 1 TO Len( aParcelas )
                        IF !( ASCAN( NaoImprimeCarne, aParcelas[ nCt ][ 8 ] ) > 0 )
                           lExibeParcelas:= .T.
                           EXIT
                        ENDIF
                    NEXT

                    /* Se exibir parcelas */
                    IF lExibeParcelas
                       cCrediario:= ""
                       cCrediario:= cCrediario + "Pr---Vencim--------------------------VALOR-----" + Chr( 13 ) + Chr( 10 )
                       FOR nCt:= 1 TO Len( aParcelas )
                           /* Se nÆo encontrar este banco na lista de NaoImprimeCarne */
                           IF !( ASCAN( NaoImprimeCarne, aParcelas[ nCt ][ 8 ] ) > 0 )
                              cVlr:= Tran( aParcelas[ nCt ][ 3 ], "@E 999,999.99" )
                              cVenc:= DTOC( aParcelas[ nCt ][ 4 ] )
                              cP:= Str( aParcelas[ nCt ][ 2 ], 3, 0 )
                              cCrediario:= cCrediario + cP + " " + cVenc + "......................... " + cVlr + Chr( 13 ) + Chr( 10 )
                              FOR nLin:= 1 TO 5
                                  cCrediario:= cCrediario + " " + Chr( 13 ) + Chr( 10 )
                              NEXT
                              nCol:= nCol + 1
                           ENDIF
                       NEXT
                    ENDIF
                 ENDIF
                 IF nPerAcrDes > 0 .AND. nVlrAcrDes==0
                    nVlrAcrDes:= ROUND( ( nTotal * nPerAcrDes ) / 100, 2 )
                    nPerAcrDes:= 0
                 ENDIF

                 IF lPrinter
                     IF (Impressora == "BEMATECH-MP20FI-II")
                        IF (MoedasEspecificas == "SIM")
                           fImpMoeda( nPgtDin, nPgtTic, nPgtChq, nPgtCar, nPgtPra, nPgtOut )
                        ENDIF
                        ImpFechaCom( cAcrDes, nPerAcrDes, nVlrAcrDes, ;
                                     nValorPago, cForma, cMensagem + cCrediario + Chr( 13 ) + Chr( 10 ) + Propaganda )
                     ELSE

                        IF Impressora=="SIGTRON-FS345" .AND. !CarneInterno
                           // FS345 Sem Carne Interno
                           ImpFechaSem( cAcrDes, nPerAcrDes, nVlrAcrDes, nTotal, nValorPago, cMensagem + cCrediario, ALLTRIM( cCliCGCCPF ) )

                        ELSEIF Impressora=="SWEDA"
                           // Inibida Informacoes de Crediario - Somente mensagens
                           ImpFechaSem( cAcrDes, nPerAcrDes, nVlrAcrDes, nTotal, nValorPago, cMensagem, ALLTRIM( cCliCGCCPF ) )

                        ELSE
                           // Impressoras Padräes
                           ImpFechaSem( cAcrDes, nPerAcrDes, nVlrAcrDes, nTotal, nValorPago, cMensagem, ALLTRIM( cCliCGCCPF ) )

                        ENDIF

                     ENDIF
                 ENDIF

                 // Movimentacoes de Estoque
                 LancaEstoque(@nRegAtuCli, @nRegAtuEAN)

                 // Registro do Cupom Fiscal
                 LancaCupom( nCliCodigo, cCliDescri, cCliEndere, cCliBairro, ;
                             cCliCidade, cCliEstado, nValorPagar, nVendedor)

                 IF (Len( aParcelas ) == 0)
                    nTroco := nValorPago - nValorPagar
                    IF( nTroco < 0)
                       nTroco := 0
                    ENDIF
                    WHILE (.T.)
                       IF (nTroco == 0)
                          SWGAviso( "FIM DO CUPOM FISCAL",;
                                  {{0, " "},;
                                   {0, "   O Cupom Fiscal foi finalizado !"},;
                                   {0, " "},;
                                   {0, "   Para anular o Cupom, acione a tecla [F10]"},;
                                   {0, " "},;
                                   {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                                   {0, " "}}, 7, 3 )
                       ELSE
                          SWGAviso( "FIM DO CUPOM FISCAL",;
                                  {{0, " "},;
                                   {0, "   O Cupom Fiscal foi finalizado !"},;
                                   {0, " "},;
                                   {1, "        Troco = R$  "   + ALLTRIM (TRAN (nValorPago - nValorPagar, "@E 99,999,999.99" ))} ,;
                                   {0, " "},;
                                   {0, "   Para anular o Cupom, acione a tecla [F10]"},;
                                   {0, " "},;
                                   {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                                   {0, " "}}, 7, 3, 300, 200, 800, 1220)
                       ENDIF
                       IF (LASTKEY () <> K_ESC)
//                        KeyBoard (CHR (LASTKEY ()))
                          EXIT
                       ENDIF
                    END
                 ENDIF

                  IF (LASTKEY () == K_ENTER)
                     CLEAR TYPEAHEAD
                  ENDIF

                 IF LastKey() == K_F10 .OR. LastKey() == K_CTRL_F10
                    SWGAviso( "ANULACAO DO CUPOM FISCAL",;
                            {{0, " "},;
                             {0, "   O Cupom Fiscal sera ANULADO !"},;
                             {0, " "},;
                             {0, "   Para confirmar, acione a tecla [F10]"},;
                             {0, " "},;
                             {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                             {0, " "}}, 7, 4)
                    IF (LASTKEY () == K_F10 .OR. LASTKEY () == K_CTRL_F10)
                       AnulaCupom( impCupomAtual(), nValorPagar )
                       IF lPrinter
                          ImpCancCupom()
                       ENDIF
                       VendaFile( _EXCLUIR )
                       VendaFile( _CRIAR )
                       VendaFile( _ABRIR )
                       DispCupom( "Cupom ANULADO!", 2 )
                    ENDIF
                    IF (LASTKEY () == K_ESC)
                       CLEAR TYPEAHEAD
                    ENDIF
                 ELSEIF LastKey() == K_F9
                    IF lPrinter
                       Autentica( 0 )
                       Inkey(0)
                    ENDIF
                 ENDIF

                 /* Se nao for cancelado o cupom,
                    fazer o lancamento em caixa */

                 IF (!LastKey() == K_F10 .AND. !LastKey() == K_CTRL_F10)
                    IF Len( ALLTRIM( cCrediario ) ) > 100 .AND. lPrinter .AND. ;
                          !CarneInterno
                       IF (!Impressora == "BEMATECH-MP20FI-II")
                            ImpCarne( cCrediario, cCliDescri,;
                                      IF( !Empty( cCliCgcCpf ), ;
                                      Tran( cCliCgcCPF, ;
                                      "@R 99.999.999/9999-99" ),;
                                       Tran( cCliCgcCpf, "@R 999.999.999-99" ) ), nValorPagar )
                       ENDIF
                    ENDIF
                    IF (MoedasEspecificas == "SIM")
                       aMoedas := {}
                       AADD( aMoedas, { 794, nPgtDin })
                       AADD( aMoedas, { 795, nPgtTic })
                       AADD( aMoedas, { 796, nPgtChq })
                       AADD( aMoedas, { 797, nPgtCar })
                       AADD( aMoedas, { 798, nPgtPra })
                       AADD( aMoedas, { 799, nPgtOut })
                       LanRecMoeDiv( aMoedas, nCliCodigo, cCliDescri, ;
                                     nPerAcrDes, cAcrDes )
                    ELSE
                       LancaReceber( aParcelas, nCliCodigo, cCliDescri )
                    ENDIF

                    /* VALOR A LANCAR NO PEQ. CAIXA */
                    nValorCaixa:= 0
                    FOR nCt:= 1 TO Len( aParcelas )
                        /* Se nÆo esta em branco a data de Quitacao/Pagamento */
                        IF !EMPTY( aParcelas[ nCt ][ 5 ] )
                           nValorCaixa:= nValorCaixa + aParcelas[ nCt ][ 3 ]
                        ENDIF
                    NEXT
                    IF Len( aParcelas ) <= 0
                       nValorCaixa:= nValorPagar
                    ENDIF
                    IF nValorCaixa > 0
                       LancaEmCaixa( nValorCaixa )
                    ENDIF
                    VendaFile( _ARMAZENAR )
                    VendaFile( _EXCLUIR )
                    VendaFile( _CRIAR )
                    VendaFile( _ABRIR )
                    DispCupom( " ", 0)
                    DispCupom( "Cupom FECHADO!", 2 )
                    DispCupom( " ", 0)
                    DispCupom( "\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/", 0, .T.)
                 ENDIF
                 DBUnLockAll()
                 lCupomAberto:= .F.
                 Exit
              ELSE
                 SWSnapPaste( 50, 100, nSaveF6 )
                 oTab:RefreshAll()
                 WHILE !oTab:Stabilize()
                 ENDDO
              ENDIF
              SWSnapKill( @nSaveF6 )

         CASE nTecla == K_F9
              cBusca:= ""; lAchou := .T.
              Autentica( 0 )

         CASE nTecla == K_F5
              cBusca:= ""; lAchou := .T.
              IF lPrinter
                 ImpAbreGaveta()
              ENDIF

         CASE nTecla == K_CTRL_F1 // Verificacao de Preco
              cBusca:= ""; lAchou := .T.
              IF (nStatus == 10)
                 nStatus:= nStatusAnt
              ELSE
                 nStatusAnt:= nStatus
                 nStatus:= 10
              ENDIF

         CASE nTecla == K_CTRL_A // Auxilio
              cBusca:= ""; lAchou := .T.
              fAuxilio (@cVersao)

         CASE nTecla == K_CTRL_TAB // Visualizacao do PDV.INI
              cBusca:= ""; lAchou := .T.
              nSavePDVIni:= SWSnapCopy( 50, 100, 1300, 950, 0, "PDV_PDVI.$$$" )
              SWGBox( 70, 200, 1290, 900, "CONFIGURACOES DO SISTEMA         " + ;
                 "                [CTRL+W] Grava   [ESC] Abandona", 15 )
              cPDVIni := MEMOREAD ("PDV.INI")
              cCorRes:= SetColor( "00/15" )
              cCurAnt := SetCursor ()
              SetCursor (3)
              cPDVIni:= MEMOEDIT( cPDVINI, 6, 6, 24, 74 )
              SetCursor (cCurAnt)
              MEMOWRIT( "PDV.INI", cPDVINI )
              SWSnapPaste( 50, 100, nSavePDVIni )
              SetColor( cCorRes )

         CASE UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVWXYZ01234566789 -+*/"
              LoadcSet( 0, "VSYS14.PTX" )
              IF ALLTRIM( cBusca ) == ""
                 /* Se for primeira letra da busca - prepara o browse */
                 MPR->( DBSetOrder( 2 ) )
                 MPR->( DBGoTop() )
                 oTab:Up()
                 oTab:Up()
                 oTab:Up()
                 oTab:Up()
                 oTab:Up()
                 oTab:Up()
                 oTab:RefreshAll()
                 WHILE !oTab:Stabilize()
                 ENDDO
              ENDIF
              cBusca:= cBusca + CHR( nTecla )
              SayString( 250, 100, 4, 0, 1, PAD( cBusca, 28 ) )
              IF UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVWXYZ-/0123456789-+*"
                 nReg:= MPR -> (RECNO())
                 MPR->( DBSetOrder( 2 ) ) // upper( Descri )
                 IF MPR->( DBSeek( UPPER( cBusca ) ) )
                    nReg:= MPR->( RECNO() )
                    MPR->( DBGoTo( nReg ) )
                    MPR->( DBSetOrder( 2 ) ) // upper( Descri )
                    LoadcSet( 0, "VSYS14.PTX" )
                    oTab:RefreshAll()
                    WHILE !oTab:Stabilize()
                    ENDDO
                    lAchou := .T.
                 ELSE
                    MPR->( DBGoTo( nReg ) )
                    lAchou := .F.
                 ENDIF
              ENDIF
         OTHERWISE                ;tone(125); tone(300)
      ENDCASE

      loadcSet( 0, cFontBrowse )
      oTab:refreshcurrent()
      oTab:stabilize()

   ENDDO
   //mCurOff()

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fExiFor( cFormula, nPgtXXX )

      Local lTemPonto := .F.

      FOR nCt := 1 TO Len( Alltrim( cFormula ) )
         cPos := Subs( Alltrim( cFormula ), nCt, 1 )
         IF !( cPos $ "0123456789.+-*/" )
            Return .F.
         ENDIF
         // As proximas linhas evitam : "123.45678.90"
         IF cPos == "."
            IF lTemPonto == .T.
               Return .F.
            ENDIF
            lTemPonto := .T.
         ENDIF
         IF cPos $ "+-*/"
            lTemPonto := .F.
         ENDIF
      NEXT

      IF RIGHT( ALLTRIM( cFormula ), 1 ) $ "+-*/." .OR.;
         LEFT( ALLTRIM( cFormula ), 1 ) $ "*/" .OR.;
         AT( "+-", cFormula ) > 0 .OR.;
         AT( "++", cFormula ) > 0 .OR.;
         AT( "+/", cFormula ) > 0 .OR.;
         AT( "+*", cFormula ) > 0 .OR.;
         AT( "--", cFormula ) > 0 .OR.;
         AT( "-+", cFormula ) > 0 .OR.;
         AT( "-/", cFormula ) > 0 .OR.;
         AT( "-*", cFormula ) > 0 .OR.;
         AT( "/-", cFormula ) > 0 .OR.;
         AT( "/+", cFormula ) > 0 .OR.;
         AT( "//", cFormula ) > 0 .OR.;
         AT( "/*", cFormula ) > 0 .OR.;
         AT( "*-", cFormula ) > 0 .OR.;
         AT( "*+", cFormula ) > 0 .OR.;
         AT( "*/", cFormula ) > 0 .OR.;
         AT( "**", cFormula ) > 0 .OR.;
         AT( "..", cFormula ) > 0
         Return .F.
      ENDIF
      IF !EMPTY( cFormula )
         &nPgtXXX := &cFormula
         IF !( LASTKEY () == K_UP )
            KeyBoard( CHR( K_ENTER ) )
         ENDIF
      ENDIF

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fExiForNum( cFormula, nPgtXXX, GetList )
   Private cFor:= cFormula

      IF EMPTY( cFormula )
         cFormula:= PAD( Alltrim( Str( nPgtXXX, 14, 2 ) ), 40 )
      ELSEIF !( nPgtXXX == &cFor )
         cFormula:= PAD( Alltrim( Str( nPgtXXX, 14, 2 ) ), 40 )
      ENDIF
      Release cFor

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fPgtDin (nValorPagar, GetList )

      nPgtDin := nValorPagar - nPgtTic - nPgtChq - nPgtCar - nPgtOut

      IF nPgtDin < 0
         nPgtDin := 0
      ENDIF

      cPgtDin := PAD( Alltrim( Str( nPgtDin, 14, 2 ) ), 40 )

      fTroco( nValorPagar, nValorPago )

      FOR nCt:= 1 TO Len( GetList )
          GetList[ nCt ]:Display()
      NEXT

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fTroco( nValorPagar, nValorPago )

      nValorPago := nPgtDin + nPgtTic + nPgtChq + nPgtCar + nPgtOut

      @ 22,37 Say nValorPago - nValorPagar Pict "@R 99,999,999,999.99" ;
         Color "04/15"

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fVerifBusca (cBusca, nRegAtuEAN, oTab)

      Local lRet := .F.

      IF ! EMPTY( cBusca )
         IF (SUBSTR (cBusca, 1, 1) $ "0123456789" .AND. ;
             SUBSTR (cBusca, 2, 1) $ "0123456789" .AND. ;
             SUBSTR (cBusca, 3, 1) $ "0123456789")
             MPR->( DBSetOrder( 4 ) )
             IF !MPR->( DBSeek( PAD( cBusca, 13 ) ) )
                IF fCodigoEAN( @cBusca, @nRegAtuEAN)
                   lRet := .T.
                   nReg:= MPR->( RECNO() )
                ENDIF
             ELSE
                nReg:= MPR ->( RECNO() )
                lRet:= .T.
                /* Ajusta o Browse, pois localizou o produto */
                LoadcSet( 0, "VSYS14.PTX" )
                oTab:Up()
                oTab:Up()
                oTab:Up()
                oTab:Up()
                oTab:Up()
                oTab:RefreshAll()
                WHILE !oTab:Stabilize()
                ENDDO
                MPR->( DBSeek( cBusca ) )
             ENDIF
         ENDIF
      ENDIF
      MPR -> (DBSetOrder (2)) // upper( Descri )
      LoadcSet( 0, "VSYS14.PTX" )
      oTab:RefreshAll()
      WHILE !oTab:stabilize()
      ENDDO

   Return (lRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fCodigoEAN (cBusca, nRegAtuEAN)

      Local lRet := .T.

      EAN -> (DBSetOrder (1)) // CODIGO (Codigo EAN Interno)
      IF (EAN -> (DBSeek (UPPER( cBusca ))) = .F.)

         EAN -> (DBSetOrder (2)) // CODEAN (Codigo EAN Fabrica)
         IF (EAN -> (DBSeek (UPPER( cBusca ))) = .F.)

            nReg:= MPR -> (RECNO())
            MPR->( DBSetOrder( 4 ) )
            IF ( MPR->( DBSeek( UPPER( cBusca ) ) )==.F. )
               MPR->( DBSeek( UPPER( cBusca ), .T. ) )
               IF !UPPER( Left( MPR->CODFAB, LEN( ALLTRIM( cBusca ) ) ) ) == UPPER( alltrim( cBusca ) )
                  SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
                        {{0, " "},;
                         {0, "   O codigo EAN Interno e/ou Fabrica nao consta no arquivo !"},;
                         {0, " "},;
                         {0, "   Verifique o arquivo de Materias Primas do Fortuna"},;
                         {0, " "},;
                         {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                         {0, " "}}, 7, 4)

                  MPR->( DBGoTo( nReg ) )
                  lRet:= .F.
               ENDIF

            ENDIF

         ENDIF

      ENDIF

   Return (lRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fCorEAN ()

      Local cCorAnt:= SetColor( ), nCursor:= SetCursor( ), nArea:= Select(), ;
            nOrdem:= IndexOrd( )
      Local nSaveCorEAN, nTecla, oCores, nCorLin := 1, nCorRet := 0,;
            nRegistro, aCores

      nRegAtuEAN := 0
      aCores := 0
      aCores := {}

      COR -> (DBSetOrder (1)) // CODIGO

      cCodProAnt:= EAN->CODPRO
      nRegistro:= EAN->( RECNO() )

      WHILE (EAN -> (EOF ()) = .F. .AND. EAN -> CODPRO == cCodProAnt)
         IF (COR -> (DBSeek (EAN -> PCPCOR)) = .T.)
            IF (ASCAN (aCores, {| nElem | nElem [1] == COR -> CODIGO}) == 0)
               AADD (aCores, {COR -> CODIGO, COR -> DESCRI})
            ENDIF
         ENDIF
         EAN -> (DBSkip ())
      END

      EAN->( DBGoTo( nRegistro ) )

      IF Len( aCores ) == 0
         DBSetOrder( nOrdem )
         Return 0
      ENDIF

      ASORT( aCores,,, {|x,y| x[2] < y[2] } )

      nSaveCorEAN:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_CORE.$$$" )

      IF (CorPadrao == "CINZA")
         SetColor( "08/15,00/03" ) // CURSOR CIANO    (CINZA CLARO)
      ELSE
         SetColor( "08/15,00/07" ) // CURSOR CIANO    (CINZA CLARO)
      ENDIF

      SWGBox( 480, 260, 1040, 800, "Cores do Item", 15 )
      Mensagem( )

      oCores:=TBrowseNew( 10, 30, 20, 59 )
      oCores:AddColumn( tbcolumnnew( ,{|| aCores [nCorLin, 2] + Space( 65 ) } ) )
      oCores:AutoLite:=.f.
      oCores:GOTOPBLOCK:={|| nCorLin:= 1}
      oCores:GOBOTTOMBLOCK:={|| nCorLin:= Len( aCores ) }
      oCores:SKIPBLOCK:={|x| SkipPerArr( x,aCores,@nCorLin )}
      oCores:dehilite( )

      oCores:RefreshAll( )
      WHILE !oCores:Stabilize( )
      ENDDO

      CLEAR TYPEAHEAD

      WHILE .T.

         LoadcSet( 0, "VSYS14.PTX" )

         oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 1 }, { 2, 1 } )
         WHILE !oCores:Stabilize( )
         ENDDO

         Mensagem( aCores [nCorLin, 2] )

         nTecla:= Inkey( 0 )

         DO CASE
            CASE nTecla==K_ESC
               EXIT
            CASE nTecla==K_UP          ; oCores:up( )
            CASE nTecla==K_DOWN        ; oCores:down( )
            CASE nTecla==K_PGUP        ; oCores:pageup( )
            CASE nTecla==K_PGDN        ; oCores:pagedown( )
            CASE nTecla==K_CTRL_PGUP   ; oCores:gotop( )
            CASE nTecla==K_CTRL_PGDN   ; oCores:gobottom( )
            CASE nTecla==K_ENTER
                 nRegAtuEAN := EAN -> (RECNO ())
                 nCorRet := aCores[nCorLin, 1]
                 EXIT
            OTHERWISE                  ; Tone( 125 ); Tone( 300 )
         ENDCASE

         oCores:RefreshCurrent( )
         oCores:Stabilize( )

      ENDDO

      SWSnapPaste( 50, 100, nSaveCorEAN )
      SWSnapKill( @nSaveCorEAN )

      DBSelectAr( nArea )
      DBSetOrder( nOrdem )

      SetColor( cCorAnt )
      SetCursor( nCursor )

   Return (nCorRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fTamEAN (nCorEAN)

      Local cTamAnt:= SetColor( ), nCursor:= SetCursor( ), nArea:= Select(), ;
            nOrdem:= IndexOrd( )
      Local nSaveTamEAN, nTecla, oTamanhos, nTamLin := 1, nTamRet := 0, nTam,;
            nRegistro

      nRegAtuEAN := 0
      aTamanhos := 0
      aTamanhos := {}

      CLA -> (DBSetOrder (1)) // CODIGO

      cCodProAnt:= EAN->CODPRO
      nRegistro:= EAN->( RECNO() )
      WHILE (EAN -> (EOF ()) == .F. .AND. EAN -> CODPRO == cCodProAnt)
         IF (EAN -> PCPCOR == nCorEAN)
            IF (CLA -> (DBSeek (EAN -> PCPCLA)) = .T.)
               cTam := STRZERO (EAN -> PCPTAM, 2)
               IF ASCAN( aTamanhos, {|x| x[1] == EAN->PCPTAM } ) <= 0 .AND. EAN->PCPTAM > 0
                  AADD(aTamanhos, {EAN -> PCPTAM, CLA -> TAMA&cTam, EAN -> SALDO_})
               ENDIF
            ENDIF
         ENDIF
         EAN -> (DBSkip ())
      END
      EAN->( DBGoTo( nRegistro ) )

      IF Len( aTamanhos ) == 0
         DBSetOrder( nOrdem )
         Return 0
      ENDIF

      ASORT( aTamanhos,,, {|x,y| x[2] < y[2] } )

      nSaveTamEAN:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_TAME.$$$" )

      IF (CorPadrao == "CINZA")
         SetColor( "08/15,00/03" ) // CURSOR CIANO    (CINZA CLARO)
      ELSE
         SetColor( "08/15,00/07" ) // CURSOR CIANO    (CINZA CLARO)
      ENDIF

      SWGBox( 480, 260, 1040, 800, "Tamanhos do Item              Saldo", 15 )
      Mensagem( )

      oTamanhos:=TBrowseNew( 10, 30, 20, 59 )
      oTamanhos:AddColumn( tbcolumnnew( ,{|| aTamanhos[nTamLin, 2] + ;
         "          " + TRAN (aTamanhos[nTamLin, 3], "@E 99,999.999") + ;
         Space( 65 ) } ) )
      oTamanhos:AutoLite:=.F.
      oTamanhos:GOTOPBLOCK:={|| nTamLin:= 1}
      oTamanhos:GOBOTTOMBLOCK:={|| nTamLin:= Len( aTamanhos ) }
      oTamanhos:SKIPBLOCK:={|x| SkipPerArr( x,aTamanhos,@nTamLin )}
      oTamanhos:dehilite( )

      oTamanhos:RefreshAll( )
      WHILE !oTamanhos:Stabilize( )
      ENDDO

      CLEAR TYPEAHEAD

      WHILE .T.

         LoadcSet( 0, "VSYS14.PTX" )
         oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, 1 }, { 2, 1 } )
         WHILE !oTamanhos:Stabilize( )
         ENDDO

         Mensagem( aTamanhos [nTamLin, 2] )

         nTecla:= inkey( 0 )

         DO CASE
            CASE nTecla==K_ESC
               EXIT
            CASE nTecla==K_UP          ; oTamanhos:up( )
            CASE nTecla==K_DOWN        ; oTamanhos:down( )
            CASE nTecla==K_PGUP        ; oTamanhos:pageup( )
            CASE nTecla==K_PGDN        ; oTamanhos:pagedown( )
            CASE nTecla==K_CTRL_PGUP   ; oTamanhos:gotop( )
            CASE nTecla==K_CTRL_PGDN   ; oTamanhos:gobottom( )
            CASE nTecla==K_ENTER
                 nRegAtuEAN := EAN -> (RECNO ())
                 nTamRet := aTamanhos [nTamLin, 1]
                 EXIT
            OTHERWISE                  ; Tone( 125 ); Tone( 300 )
         ENDCASE

         oTamanhos:RefreshCurrent( )
         oTamanhos:Stabilize( )

      ENDDO

      SWSnapPaste( 50, 100, nSaveTamEAN )
      SWSnapKill( @nSaveTamEAN )

      DBSelectAr( nArea )
      DBSetOrder( nOrdem )

      SetColor( cTamAnt )
      SetCursor( nCursor )

   Return (nTamRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fVerLimCred( lLimCredAvis, nCliCodigo, nTotal, nSalLimCre )

      Local cTamAnt:= SetColor( ), nCursor:= SetCursor( ), nArea:= Select(), ;
            nOrdem:= IndexOrd( )
      Local lRet := .T.

      CLI->( DBSetOrder( 1 ) )
      IF ( CLI->( DBSeek( nCliCodigo ) ) )
         IF CLI->LIMCR_ > 0 .AND. !lLimCredAvis .AND. nTotal > nSalLimCre
            WHILE (.T.)
               SWGAviso( "LIMITE DE CREDITO",;
                       {{0, "   Este cliente esta com o limite de credito esgotado!"},;
                        {0, " "},;
                        {1, "      LIMITE DE CREDITO = R$  " + ALLTRIM( TRAN( CLI->LIMCR_, "@E 99,999,999.99" ))},;
                        {1, "                  SALDO = R$  " + ALLTRIM( TRAN( nSalLimCre,  "@E 99,999,999.99" ))},;
                        {0, " "},;
                        {0, " "}}, 7, 4, 300, 200, 800, 1220)
               IF (LASTKEY () == K_ENTER)
                  lLimCredAvis := .T.
                  EXIT
               ELSE
                  IF (LASTKEY () == K_ESC)
                     lRet := .F.
                     EXIT
                  ENDIF
               ENDIF
            ENDDO
         ELSEIF CLI->LIMCR_ > 0
            SWGAviso( "LIMITE DE CREDITO",;
                       {{0, "                                                      "},;
                        {0, " "},;
                        {1, "      LIMITE DE CREDITO = R$  " + ALLTRIM( TRAN( CLI->LIMCR_, "@E 99,999,999.99" ))},;
                        {1, "                  SALDO = R$  " + ALLTRIM( TRAN( CLI->SALDO_, "@E 99,999,999.99" ))},;
                        {0, " "},;
                        {0, " "}}, 7, 4, 300, 200, 800, 1220)
         ENDIF
      ENDIF

      SetColor( cTamAnt )
      SetCursor( nCursor )

   Return (lRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fVerSalEst (nQuantidade, nTamEAN, nCorEAN, nRegAtuEAN)

      Local cTamAnt:= SetColor( ), nCursor:= SetCursor( ), nArea:= Select(), ;
            nOrdem:= IndexOrd( )
      Local lRet := .T., nSaldo, lSemSaldo

      EAN -> (DBSetOrder (3)) // CODPRO ...

      IF (EAN -> (DBSeek (MPR -> INDICE + STR (MPR -> PCPCLA, 3) + ;
                          STR (nTamEAN, 2) + STR (nCorEAN, 2))) == .T.)
         nRegAtuEAN := EAN -> (RECNO ())
      ELSE
         nRegAtuEAN := 0
      ENDIF

      lSemSaldo := .F.

      IF (nRegAtuEAN <> 0)
         IF (nQuantidade > EAN -> SALDO_)
            lSemSaldo := .T.
            nSaldo    := EAN -> SALDO_
         ENDIF
      ELSEIF (nQuantidade > MPR -> SALDO_)
         lSemSaldo := .T.
         nSaldo    := MPR -> SALDO_
      ENDIF

      IF (lSemSaldo == .T.)
         WHILE (.T.)
            SWGAviso( "SALDO EM ESTOQUE",;
                    {{0, "   Este item esta com o saldo em estoque esgotado !"},;
                     {0, " "},;
                     {1, "      Saldo atual = " + ALLTRIM (TRAN (nSaldo, "@E 99,999,999.99999" ))} ,;
                     {1, "      Diferenca   = " + ALLTRIM (TRAN (nSaldo - nQuantidade, "@E 99,999,999.99999" ))} ,;
                     {0, " "},;
                     {0, "   Para confirmar a VENDA deste item, acione a tecla [ENTER]"},;
                     {0, " "},;
                     {0, "   Para NAO VENDER este item, acione a tecla [ESC]"},;
                     {0, " "}}, 7, 4, 300, 200, 800, 1220)
            IF (LASTKEY () == K_ENTER)
               EXIT
            ELSE
               IF (LASTKEY () == K_ESC)
                  lRet := .F.
                  EXIT
               ENDIF
            ENDIF
         END
      ENDIF

      DBSelectAr( nArea )
      DBSetOrder( nOrdem )

      SetColor( cTamAnt )
      SetCursor( nCursor )

   Return (lRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*
* Modulo      - SKIPPERARR
* Parametro   - NTOJUMP - Quantidade de registro
*               WMATRIZ - Matriz para trabalho
* Finalidade  - Controlar acesso ao primeiro e/ou ultimo registro
*             - Auxilio ao browse de matrizes
* Programador - Valmor Pereira Flores
* Data        - 02/Fevereiro/1994
* Atualizacao
*/
func skipperarr(NTOJUMP,WMATRIZ,nROW)
loca NJUMPED:=0
if nROW + NTOJUMP < 1
   NJUMPED:=-nROW + 1
   nROW:=1
elseif nROW + NTOJUMP > len(WMATRIZ)
   NJUMPED:=len(WMATRIZ) - nROW
   nROW:=len(WMATRIZ)
else
   NJUMPED:=NTOJUMP
   nROW+=NTOJUMP
endif
return NJUMPED

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function DispCupom( cProduto, nCor, lDupla )

      _VScroll( 778, 498, 1340, 840, 20, 15 )
       loadcSet( 0, "AGSYSA14.PTX" )
       IF lDupla == Nil
          Boxfill(  778, 498, 1, 18, 20, 8)
          Boxfill( 1335, 500, 1, 18, 20, 8)
       ENDIF

       IF !lDupla == Nil .AND. lDupla == .T.
          SayString( 778, 498, 4, 0, 0, cProduto )
          SayString( 780, 500, 4, 0, 0, cProduto )
       ELSE
          FOR nCt:=  1 TO LEN( cProduto )
             SayString( 800, 500, 4, 0, nCor, Substr( cProduto, 1, nCt ) )
          NEXT
          SayString( 800, 500, 4, 0, nCor, cProduto )
       ENDIF

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function DispValor( cValor, nCor )

       loadcSet( 0, "AGSYSA14.PTX" )
//     loadcSet( 0, "AGSYSD10.PTX" )
       SayString(1235, 500, 4, 0, nCor, cValor )

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function SWGBox( nCol1, nLin1, nCol2, nLin2, cTitulo, nCor, nTipo )

      Local nCt

      SetBkFill( nCor )
      SetRGBDAC( 62, 51, 153, 255 )

      IF nTipo==Nil
         nTipo:= 2
      ENDIF

      IF nTipo==1
         BoxFill( nCol1+6, nLin1-8, (nCol2-nCol1), (nLin2-nLin1), 3+32,  8)  //  1
         BoxFill( nCol1+4, nLin1-7, (nCol2-nCol1), (nLin2-nLin1), 3+32, 15)  //  2
         IF (CorPadrao == "CINZA")
            BoxFill( nCol1+4, nLin1-7, (nCol2-nCol1), (nLin2-nLin1), 3+32, 13)  //  2
            BoxFill( nCol1+1, nLin1-3, (nCol2-nCol1), (nLin2-nLin1), 3+32, 13)  //  4
            BoxFill( nCol1+1, nLin1,   (nCol2-nCol1), (nLin2-nLin1), 5+32, 13)  //  9
         ELSE
            BoxFill( nCol1+2, nLin1-5, (nCol2-nCol1), (nLin2-nLin1), 3+32,  8)  //  3
            BoxFill( nCol1+1, nLin1-1, (nCol2-nCol1), (nLin2-nLin1), 3+32,  8)  // 15
            BoxFill( nCol1+1, nLin1,   (nCol2-nCol1), (nLin2-nLin1), 6+32,  8)  //  9
         ENDIF
         BoxFill( nCol1+1, nLin1-3, (nCol2-nCol1), (nLin2-nLin1), 3+32, 15)  //  4
         BoxFill( nCol1+1, nLin1,   (nCol2-nCol1), (nLin2-nLin1), 5+32, 15)  //  9
         BoxFill( nCol1, nLin1, nCol2-nCol1, nLin2-nLin1, 64, nCor )
      ELSEIF nTipo==2

         BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 7 )
         FOR nCt:= 1 TO 2
            DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 15 )       /* SUPERIOR */
            DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 15 )       /* ESQUERDA */
            IF (CorPadrao == "CINZA")
               DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 15 )       /* SUPERIOR */
               DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 15 )       /* ESQUERDA */
            ELSE
               DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
               DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
            ENDIF
         NEXT
         IF (CorPadrao == "CINZA")
            BoxFill( nCol1+10, nLin2-43, (nCol2-nCol1)-20, 35, 128, 3 ) // CIANO
         ELSE
            BoxFill( nCol1+10, nLin2-43, (nCol2-nCol1)-20, 35, 128, 1 ) // CIANO
         ENDIF

         nCol1+=7
         nLin1+=57

         /* Box mensagem */
         BoxFill(  nCol1+5,  nLin1-50, (nCol2-nCol1)-20, 40, 64,   8 )
         DrawLine( nCol1+5,  nLin1-50, nCol2-15, nLin1-50, 0, 0,  15 )
         DrawLine( nCol2-15, nLin1-50, nCol2-15, nLin1-10, 0, 0,  15 )
      //#02-IF DrawLine( nCol1+5,  nLin1-50, nCol2-15, nLin1-50, 0, 0,  13 )
      //#02-IF DrawLine( nCol2-15, nLin1-50, nCol2-15, nLin1-10, 0, 0,  13 )

         UltimaTela( nCol1, nLin1-50 )
         nCol2-=7
         nLin2-=50

         BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 15 )
      //#02-I
      /*
         /* Fundo da Tela */
         IF !( nCor==Nil )
            BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 15 ) /* NCOR */
         ELSE
            BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 15 )
         ENDIF
      */
      //#02-F
         /* Profundidade Interna */
         FOR nCt:= 1 TO 4
             DrawLine( nCol1+nCt, nLin2-nCt, nCol2-nCt, nLin2-nCt, 0, 0, 177  )    /* Superior */
             DrawLine( nCol1+nCt, nLin1+nCt, nCol1+nCt, nLin2-nCt, 0, 0, 177  )    /* Esquerda */
             DrawLine( nCol1+nCt, nLin1+nCt, nCol2-nCt, nLin1+nCt, 0, 0, 7 )       /* Inferior */
             DrawLine( nCol2-nCt, nLin1+nCt, nCol2-nCt, nLin2-nCt, 0, 0, 7 )       /* Direita */
         NEXT
         IF !cTitulo==Nil
            LoadCSet( 000, "VSYS14.PTX" )
            SayString( nCol1+15, nLin2+5, 5, 0,  0, cTitulo ) // PRETO
            SayString( nCol1+12, nLin2+8, 5, 0, 14, cTitulo ) // AMARELO
         ENDIF
      ENDIF
      loadcSet( 0, "VSYS14.PTX" )

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWGAviso( cTitulo, aAviso, nCor, nCorTit, nLin1x, nCol1x, nLin2x, nCol2x )
//                            ³
//                            ÃÄÄÄÄ 1§ elemento = COR
//                            ÀÄÄÄÄ 2§ elemento = CARACTERES

   Local nCursor:= SetCursor( 0 )
   Local nTelaVal:= SWSnapCopy( 0, 0, 1250, 900, 0, "PDV_AVIS.$$$" )
   Local nCt

   nLin1:= IIF (nLin1x == NIL,  300, nLin1x)
   nCol1:= IIF (nCol1x == NIL,  200, nCol1x)
   nLin2:= IIF (nLin2x == NIL,  700, nLin2x)
   nCol2:= IIF (nCol2x == NIL, 1220, nCol2x)

   SetBkFill( 7 )
   SetRGBDAC( 62, 51, 153, 255 )
   BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, nCor )              // INTERNO SUPERIOR
   BoxFill( nCol1+10, nLin1+11, (nCol2-nCol1)-24, (nLin2-nLin1)-64, 64, 8 )      // INTERNO DIREITA
   BoxFill( nCol1+11, nLin1+10, (nCol2-nCol1)-24, (nLin2-nLin1)-64, 64, nCor+8 ) // INTERNO ESQUERDA
   BoxFill( nCol1+10, nLin1+10, nCol2-nCol1-24, 0, 64, 8 )                 // INTERNO INFERIOR

   FOR nCt:= 1 TO 2
       DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, nCor+8 )   /* SUPERIOR */
       DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, nCor+8 )   /* ESQUERDA */
       DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
       DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
   NEXT

   IIF (!CorPadrao == "CINZA" .AND. nCorTit == 3, nCorTit := 1, NIL)

   BoxFill( nCol1+10, nLin2-43, (nCol2-nCol1)-20, 35, 128, nCorTit ) // CIANO

   loadcSet( 0, "VSYS14.PTX" )

   IF !cTitulo==Nil
      SayString( nCol1+20, nLin2-45, 5, 0,  0, cTitulo )
      SayString( nCol1+18, nLin2-43, 5, 0, 14, cTitulo )
   ENDIF

   FOR nCt:= Len( aAviso ) TO 1 Step -1
       SayString( nCol1+30, (nLin2-50) - ( nCt * 50 ), 5, 0, aAviso[ nCt, 1 ], aAviso[ nCt, 2 ] )
       IF (LEFT (aAviso[ nCt, 2 ], 1) == "")
          SayString( nCol1+32, (nLin2-52) - ( nCt * 50 ), 5, 0,       0, "")
//        SayString( nCol1+30, (nLin2-50) - ( nCt * 50 ), 5, 0,       4, "")
          SayString( nCol1+30, (nLin2-50) - ( nCt * 50 ), 5, 0, nCorTit, "")
       ENDIF
   NEXT

   Inkey(0)

   r= SWSnapPaste( 0, 0, nTELAVAL )
   r= SWSnapKill( @nTELAVAL )
   SetCursor( nCursor )

Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function Efeito()
Local nCor

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

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
         Replace CODLAN With nCodLan,;
                 INDICE With MPR->( INDICE ),;
                 CODFAB With cCodFab,;
                 DESCRI With cProdut,;
                 UNIDAD With cUnidad,;
                 STATUS With " ",;
                 PRECOV With nPrecoV,;
                 QUANT_ With nQuant_,;
                 PRECOT With nPrecoT,;
                 DATA__ With DATE(),;
                 HORA__ With TIME(),;
                 ST____ With cSt,;
                 PCPCLA With MPR->PCPCLA,;
                 PCPTAM With nTamEAN,;
                 PCPCOR With nCorEAN,;
                 NUMCUP With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() )
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
              { "NUMCUP", "N", 09, 00 }}
      DBCreate( _ARQUIVO, aStr )

   ELSEIF xPar1 == _ABRIR
      DBSelectAr( _VENDAFILE )
      IF !Used()
         Use _ARQUIVO Alias VDA Exclusive
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
                    DATA__ With DATE(),;
                    HORA__ With TIME(),;
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

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function AnulaCupom( cCupom, nTotal )
Local nCt:= 0, lCancelado:= .F.
  DBSelectAr( _COD_CUPOM )
  IF !USED()
     Use _VPB_CUPOM Alias CUP Shared
     Set Index To &DiretoriodeDados\CUPIND01.IGD,;
                  &DiretoriodeDados\CUPIND02.IGD,;
                  &DiretoriodeDados\CUPIND03.IGD,;
                  &DiretoriodeDados\CUPIND04.IGD
  ENDIF
  DBSelectAr( _COD_CUPAUX )
  IF !USED()
     Use _VPB_CUPAUX Alias CPA Shared
     Set Index To &DiretoriodeDados\CAUIND01.IGD,;
               &DiretoriodeDados\CAUIND02.IGD,;
               &DiretoriodeDados\CAUIND03.IGD,;
               &DiretoriodeDados\CAUIND04.IGD,;
               &DiretoriodeDados\CAUIND05.IGD
  ENDIF
  DBSelectAr( _COD_CUPOM )
  DBGoBottom()
  WHILE nCt < 10
     ++nCt
     IF CUP->VLRTOT==nTotal .AND. CUP->FUNC__==CodigoCaixa .AND. CUP->DATAEM==DATE()
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
  CUP->( DBCloseArea() )
  DBSelectAr( _COD_MPRIMA )
  RetornaEstoque( Nil )
  Return .F.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ MENSAGEM
³ Finalidade  ³ Exibicao da mensagem na tela
³ Parametros  ³ cMensagem
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Static Function Mensagem( cMensagem )
Local nLin:= UltimaTela()[2], nCol:= UltimaTela()[1], nCursor:= SetCursor( )
Static nHUltTela
SetCursor( 0 )
IF !nLin==Nil
   IF nLin > 0
      IF nHUltTela==Nil .OR. cMensagem==Nil
         nHUltTela:= SWSnapCopy( 0, nLin, 1200, nLin+50, 0, "PDV_MENS.$$$" )
         IF cMensagem==Nil
            SetCursor( nCursor )
            Return .T.
         ENDIF
      ENDIF
      SWSnapPaste( 0, nLin, nHUltTela )
      loadcSet( 0, "VSYS14.PTX" )
      SayString( nCol+14, nLin+4, 4, 0, 8, cMensagem )
      SayString( nCol+12, nLin+6, 4, 0, 11, cMensagem )
      LoadcSet( 0, "VSYS14.PTX" )
   ENDIF
ENDIF
SetCursor( nCursor )
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function UltimaTela( nCol, nLin )
Static nUTLin, nUTCol
IF nCol==Nil
   Return { nUTCol, nUTLin }
ELSE
   nUTLin:= nLin
   nUTCol:= nCol
ENDIF
Return { nUTCol, nUTLin }

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ BuscaCli
³ Finalidade  ³ Apresentar relacao de clientes no PDV
³ Parametros  ³ cNome
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function BuscaCli( nCliCodigo, cCliDescri, cCliEndere,  cCliBairro,  cCliCidade,  cCliEstado,  cCliCodCep,  cCliCGCCPF, GetList )
Local cFontBrowse:= "VSYS14.PTX"
Local nCt:= 0
Local nArea:= Select(), oTb, nCursor:= SetCursor(), nColor := SetColor ()
Local nTelaC
Local cBusca:= "", nTecla
Local nRegiao, nBotao

   IF (CorPadrao == "CINZA")
      SetColor( "08/15,15/08,00/03,00/07" ) // CURSOR CIANO    (CINZA CLARO)
   ELSE
      SetColor( "08/15,15/08,00/07,00/07" ) // CURSOR CIANO    (CINZA CLARO)
   ENDIF

  //mCurOff()
  SetCursor( 0 )
  DBSelectAr( _COD_CLIENTE )
  DBSetOrder( 2 )
  DBGotop()
  IF !EMPTY( cCliDescri )
     DBSeek( PAD( cCliDescri, 45 ) )
     IF ALLTRIM( cCliDescri ) == ALLTRIM( DESCRI )
        nCliCodigo:= CODIGO
        cCliDescri:= DESCRI
        cCliCGCCPF:= IF( EMPTY( CGCMF_ ), CPF___, CGCMF_ )
        cCliBairro:= BAIRRO
        cCliCidade:= CIDADE
        cCliEndere:= ENDERE
        cCliEstado:= ESTADO
        cCliCodCep:= CODCEP
        FOR nCt:= 1 TO Len( GetList )
            GetList[ nCt ]:Display()
        NEXT
     ENDIF

     DBSelectAr( _COD_CLIENTE )

     DBSelectAr( nArea )
     SetCursor( nCursor )
     Return .T.
  ELSE
     nTelaC:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_BUCL.$$$" )
     loadcSet( 0, "VSYS14.PTX" )
     SWGBox( 220, 220, 1250, 800, "Pesquisa ao Cadastro de Clientes", 15 )
     Mensagem( )
     IF EMPTY( cCliDescri )

        oTb:= TBrowseDB( 10, 14, 23, 70 )
        oTb:addcolumn(tbcolumnnew(,{|| PAD( " " + Left( CLI->DESCRI, 39 ), 65 ) }))

        oTb:AUTOLITE:=.f.
        oTb:dehilite()
        WHILE .T.
            loadcSet( 0, cFontBrowse )
            oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
            WHILE nextkey()==0 .and. ! oTb:stabilize()
            ENDDO
            //mCurOff()
            IF !( cBusca == "" )
               Mensagem( "Pesquisa " + cBusca )
            ELSE
               Mensagem( CLI->CIDADE + " " + CLI->CGCMF_ + " " + CLI->CPF___ )
            ENDIF
            //mCurOn()
            WHILE ( nTecla:=Inkey() )==0
               nRegiao:= 1
               nBotao:= MStatus()
               IF MMotion() <> 0
                  //mCurOff()
                  //mCurOn()
               ENDIF
               IF nRegiao > 0
                  IF nBotao==1
                     Keyboard Chr( K_UP ) + Chr( 0 )
                  ELSEIF nBotao==2
                     Keyboard Chr( K_DOWN ) + Chr( 0 )
                  ENDIF
               ENDIF
            ENDDO
            //mCurOff()

            IF !( UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &" )
               cBusca:= ""
            ENDIF
            IF nTecla==K_ESC
               nCliCodigo:= 0
               cCliDescri:= Space( Len( DESCRI ) )
               cCliCGCCPF:= Space( 14 )
               cCliBairro:= Space( Len( BAIRRO ) )
               cCliCidade:= Space( Len( CIDADE ) )
               cCliEndere:= Space( Len( ENDERE ) )
               cCliEstado:= Space( 2 )
               cCliCodCep:= Space( 8 )
               Keyboard Chr( K_UP )
               EXIT
            ENDIF
            DO CASE
               CASE nTecla==K_UP         ;oTb:up()
               CASE nTecla==K_DOWN       ;oTb:down()
               CASE nTecla==K_LEFT
               CASE nTecla==K_RIGHT
               CASE nTecla==K_PGUP       ;oTb:pageup()
               CASE nTecla==K_CTRL_PGUP  ;oTb:gotop()
               CASE nTecla==K_PGDN       ;oTb:pagedown()
               CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom()
               CASE UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
                    cBusca:= cBusca + UPPER( Chr( nTecla ) )
                    DBSeek( UPPER( cBusca ), .T. )
                    oTb:RefreshAll()
                    WHILE !oTb:Stabilize()
                    ENDDO

               CASE nTecla==K_ENTER
                    nCliCodigo:= CODIGO
                    cCliDescri:= DESCRI
                    cCliCGCCPF:= IF( EMPTY( CGCMF_ ), CPF___, CGCMF_ )
                    cCliBairro:= BAIRRO
                    cCliCidade:= CIDADE
                    cCliEndere:= ENDERE
                    cCliEstado:= ESTADO
                    cCliCodCep:= CODCEP
                    IF ( fVerLimCred( .F., @nCliCodigo, 1, CLI->LIMCR_ ) == .T. )
                        EXIT
                    ENDIF
               OTHERWISE                ;tone(125); tone(300)
            ENDCASE
            loadcSet( 0, "VSYS14.PTX" )
            oTb:refreshcurrent()
            oTb:stabilize()
        ENDDO
     ENDIF

     /* Restauracao */
     SWSnapPaste( 50, 100, nTelaC )
     SWSnapKill( @nTelaC )

  ENDIF
  FOR nCt:= 1 TO Len( GetList )
      GetList[ nCt ]:Display()
  NEXT
  SetColor (nColor)
  DBSelectAr( nArea )
  SetCursor( nCursor )
  Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*====================================
Funcao       ACRDES
Finalidade   Acrescenta
Parametros   cAcrDes = Acrescimo/Desconto
             nPerAcrDes = % Acrescimo/Desconto s/ total
             nVlrAcrDes = Vlr Acrescimo/Desconto s/ total
             nValorPagar = Valor a pagar (Passado por @referencia)
             nTotal = Valor Total (Passado por @referencia)
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function AcrDes( cAcrDes, nPerAcrDes, nVlrAcrDes, nValorPagar, nTotal )
Local nCursor:= SetCursor( )
SetCursor( 0 )
IF cAcrDes == "A"
   IF nPerAcrDes > 0
      nValorPagar:= nTotal + ( ( nTotal * nPerAcrDes ) / 100 )
   ELSEIF nVlrAcrDes > 0
      nValorPagar:= nTotal + nVlrAcrDes
   ELSE
      nValorPagar:= nTotal
   ENDIF
ELSEIF cAcrDes == "D"
   IF nPerAcrDes > 0
      nValorPagar:= nTotal - ( ( nTotal * nPerAcrDes ) / 100 )
      nVlrAcrDes:= nTotal - nValorPagar
   ELSEIF nVlrAcrDes > 0
      nValorPagar:= nTotal - nVlrAcrDes
   ELSE
      nValorPagar:= nTotal
      nVlrAcrDes:= 0
   ENDIF
ENDIF
SetCursor( nCursor )
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function ExibeTotais( cTitulo, nValor )
   Return (.T.)

      loadcSet( 0, "VSYS14.PTX" )
      SayString( 35, 500, 4, 0, 0, cTitulo )

      LoadcSet( 0, "DGE1609.PTX" )
      SayString( 400, 500, 4, 0, 7, Alltrim( Tran( nValor, "@E 999,999.99" ) ) )
      SayString( 400, 502, 4, 0, 1, Alltrim( Tran( nValor, "@E 999,999.99" ) ) )

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*====================================
Funcao       PULA
Finalidade   Pula campos
Parametros   Nil
Programador  Valmor Pereira Flores
Data         15/07/98
Atualizacao  15/07/98
-------------------------------------*/
Function Pula()
Keyboard Chr( LastKey() )
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ BUSCAVENDEDOR
³ Finalidade  ³ Apresentar relacao de VENDEDORs no PDV
³ Parametros  ³ cNome
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function BuscaVENDEDOR( nCodigo )
Local nCursor:= SetCursor()
Local nArea:= Select()
   DBSelectAr( _COD_VENDEDOR )
   IF !Used()
      Use _VPB_VENDEDOR Alias VEN Shared
      Set Index To &DiretoriodeDados\VENIND01.IGD,;
                   &DiretoriodeDados\VENIND02.IGD
   ENDIF
   DBSetOrder( 1 )
   DBGotop()
   IF DBSeek( nCodigo )
      DBSelectAr( 34 )
      DBCloseArea()
      DBSelectAr( nArea )
      SetCursor( nCursor )
      Return .T.
   ELSEIF nCodigo==0
      DBSelectAr( 34 )
      DBCloseArea()
      DBSelectAr( nArea )
      SetCursor( nCursor )
      Return .T.
   ENDIF
   Return .F.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ FORMAPAGAMENTO
³ Finalidade  ³ Apresentacao das formas de pagamentos disponiveis
³ Parametros  ³ nLin1, nCol1, nLin2, nCol2, aParcelas
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Novembro/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function FormaPagamento( nLin1, nCol1, nLin2, nCol2, aParcelas, nValorPagar, nVezes, nForma, cForma )
Local nArea:= Select()
Local oTb, cBusca:= "", nColor := SetColor ()
Local nSaveFP:= SWSnapCopy( 50, 100, 1260, 900, 0, "PDV_FOPA.$$$" )

   IF (CorPadrao == "CINZA")
      SetColor( "08/15,01/15,00/03,00/07" ) // CURSOR CIANO    (CINZA CLARO)
   ELSE
      SetColor( "08/15,01/15,00/07,00/07" ) // CURSOR CIANO    (CINZA CLARO)
   ENDIF

   DBSelectAr( _COD_DUPAUX )
   Use &DiretoriodeDados\CDDUPAUX.VPB Alias DPA Shared
   IF File( DiretoriodeDados + "\DPAIND05.IGD" )
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD,;
                   &DiretoriodeDados\DPAIND05.IGD
   ELSE
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD
   ENDIF
   DBSetOrder( 2 )
   DBGotop()
   DBSelectAr( 11 )
   Use &DiretoriodeDados\CONDICAO.VPB Alias CND Shared
   Set Index To &DiretoriodeDados\CNDIND01.IGD,;
                &DiretoriodeDados\CNDIND02.IGD
   DBSetOrder( 1 )
   IF !DBSeek( nForma )
      DBGoTop()
   ENDIF
   DBSetOrder( 2 )
   //cCorPadrao:="07/15,15/04,,,15/00"
   //SetColor( cCorPadrao )
   SWGBox( 220, 220, 1250, 800, "Pesquisa as Condicoes de Pagamento", 15 )
   Mensagem()
   oTB:=TBrowseDB( nLin1, nCol1, nLin2, nCol2 )
   oTB:AddColumn( TBColumnNew(, {|| StrZero( CND->CODIGO, 3, 0 ) + " - " + Left( CND->DESCRI, 45 ) + Space( 30 ) } ) )
   oTB:AUTOLITE:=.f.
   oTB:DehiLite()
   /* Refaz o display */
   oTb:RefreshAll()
   WHILE !oTB:Stabilize()
   ENDDO
   /* Loop do Browse */
   WHILE .T.
       oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{3,1})
       WHILE !oTb:Stabilize()
       ENDDO

       IF !( cBusca == "" )
          Mensagem( "Pesquisa " + cBusca )
       ELSE
          Mensagem( CND->DESCRI )
       ENDIF
       nTecla:=inkey(0)

       IF !UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
          cBusca:= ""
       ENDIF
       If nTecla=K_ESC
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
          CASE UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
               IF Chr( nTecla ) $ "0123456789"
                  DBSetOrder( 1 )
               ELSE
                  DBSetOrder( 2 )
               ENDIF
               cBusca:= cBusca + UPPER( Chr( nTecla ) )
               IF IndexOrd()==2
                  DBSeek( UPPER( cBusca ), .T. )
               ELSE
                  DBSeek( VAL( cBusca ) )
               ENDIF
               oTb:RefreshAll()
               WHILE !oTb:Stabilize()
               ENDDO
          CASE nTecla==K_ENTER
               nVezes:= 0
               cForma := CND -> DESCRI
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

               oTb:RefreshAll()
               WHILE !oTB:stabilize()
               ENDDO
               lDisplay:= .F.
               nForma:= CODIGO
               Exit

          OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      oTB:refreshcurrent()
      oTB:stabilize()
   ENDDO
   DBSelectAr( 11 )
   DBCloseArea()
   DBSelectAr( _COD_DUPAUX )
   DBCloseArea()
   DBSelectAr( nArea )
   SWSnapPaste( 50, 100, nSaveFP )
   SWSnapKill( @nSaveFP )
   SetColor (nColor)
   Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CalcVenc
³ Finalidade  ³ Ajustar a data de vencimento cfe. a quantidade de dias
³ Parametros  ³ dDataBase, nDias, dVencimento
³ Retorno     ³ .T.
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function CalcVenc( dDataBase, nDias, dDataVencimento, nPercentual, nValorPagar )
   dDataVencimento:= dDataBase + nDias
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CalcParcela
³ Finalidade  ³ Calcula parcela
³ Parametros  ³ nValorPagar, nPercentual, nParcela
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function CalcParcela( nValorPagar, nPercentual, nParcela, lManual, nPercAnt )
IF !lManual
   IF (nPercentual == 0)
       nPercentual := nPercAnt
   ENDIF
   nParcela:= ( nValorPagar * nPercentual ) / 100
   SetColor( "01/15" )
   @ 09,31 SAY nPercentual Pict "999.99%"
   @ 11,31 SAY nParcela Pict "@E 9999,999.99"
   SetColor( "08/15,01/15" )
ENDIF
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function fCalcPerc (nPercentual, nValorPagar, nParcela )
   nPercentual := ( nParcela / nValorPagar ) * 100
   SetColor( "01/15" )
   @ 09,31 SAY nPercentual Pict "999.99%"
   SetColor( "08/15,01/15" )
Return .T.

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
Function LancaCupom( nCliCodigo, cCliDescri, cCliEndere, cCliBairro, cCliCidade, cCliEstado, nValorPagar, nVendedor )
Local nValorIcm:= 0, nValorIpi:= 0, nValorBase:= 0
  DBSelectAr( _COD_CUPOM )
  IF !USED()
     Use _VPB_CUPOM Alias CUP Shared
     Set Index To &DiretoriodeDados\CUPIND01.IGD,;
                  &DiretoriodeDados\CUPIND02.IGD,;
                  &DiretoriodeDados\CUPIND03.IGD,;
                  &DiretoriodeDados\CUPIND04.IGD
  ENDIF
  DBSelectAr( _COD_CUPAUX )
  IF !USED()
     Use _VPB_CUPAUX Alias CPA Shared
     Set Index To &DiretoriodeDados\CAUIND01.IGD,;
               &DiretoriodeDados\CAUIND02.IGD,;
               &DiretoriodeDados\CAUIND03.IGD,;
               &DiretoriodeDados\CAUIND04.IGD,;
               &DiretoriodeDados\CAUIND05.IGD
  ENDIF
  DBSelectAr( _VENDAFILE )
  DBGoTop()
  WHILE !EOF()
      IF MPR->( DBSeek( VDA->INDICE ) ) .AND. VDA->STATUS==" "
         CPA->( DBAppend() )
         IF CPA->( RLock() )
            Replace CPA->CODIGO With VDA->INDICE
            Replace CPA->CODRED With VDA->INDICE
            Replace CPA->CODIGO With VDA->INDICE
            Replace CPA->DESCRI With VDA->DESCRI
            Replace CPA->MPRIMA With MPR->MPRIMA
            Replace CPA->UNIDAD With VDA->UNIDAD
            Replace CPA->QUANT_ With VDA->QUANT_
            Replace CPA->PRECOV With VDA->PRECOV
            Replace CPA->DATA__ With DATE()
            Replace CPA->PRECOT With VDA->PRECOT
            Replace CPA->CODNF_ With VAL( Str( CodigoCaixa, 3, 0 ) + NumeroCupom() )
         ENDIF
         IF !( MPR->IPICOD==4 )
            nValorIcm:=  nValorIcm + ( CPA->PRECOT * Icm ) / 100
            nValorBase:= nValorIcm + ( CPA->PRECOT )
         ENDIF
         CPA->( DBUnlock() )
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
             CCIDAD With cCliCidade,;
             CESTAD With cCliEstado,;
             VLRNOT With nValorPagar,;
             VLRTOT With nValorPagar,;
             VLRICM With nValorIcm,;
             VLRIPI With nValorIPI,;
             BASICM With nValorBase,;
             FUNC__ With CodigoCaixa,;
             DATAEM With DATE(),;
             VENIN_ With nVendedor
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
  Set Index To &DiretoriodeDados\CX_IND01.IGD
  DBAppend()
  IF !NetErr()
     Replace DATAMV With DATE(),;
             VENDE_ With CodigoCaixa,;
             ENTSAI With "+",;
             MOTIVO With 00,;
             HISTOR With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom(),;
             VALOR_ With nRecebido,;
             HORAMV With TIME(),;
             CDUSER With 0
  ENDIF
  DBSelectAr( _COD_MPRIMA )
  Return Nil

Function CancelaCaixa( nRecebido )
  DBSelectAr( _COD_CAIXA )
  Use _VPB_CAIXA Alias CX Shared
  Set Index To &DiretoriodeDados\CX_IND01.IGD
  DBAppend()
  IF !NetErr()
     Replace DATAMV With DATE(),;
             VENDE_ With CodigoCaixa,;
             ENTSAI With "-",;
             MOTIVO With 00,;
             HISTOR With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + "-CANCELADO!",;
             VALOR_ With nRecebido,;
             HORAMV With TIME(),;
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

  IF (nRegAtuCli <> 0)
     CLI->( DBGoTo( nRegAtuCli ) )
  ENDIF

  DBSelectAr( _COD_ESTOQUE )
  Use _VPB_ESTOQUE Alias EST Shared
  Set Index To &DiretoriodeDados\ESTIND01.IGD,;
               &DiretoriodeDados\ESTIND02.IGD,;
               &DiretoriodeDados\ESTIND03.IGD,;
               &DiretoriodeDados\ESTIND04.IGD

  MPR->( DBSetOrder( 1 ) )
  DBSelectAr( _VENDAFILE )
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
                    EST->DOC___ With "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," "," C" ),;
                    EST->CODIGO With 0,;
                    EST->VLRSDO With 0,;
                    EST->VALOR_ With VDA->PRECOT,;
                    EST->DATAMV With Date(),;
                    EST->RESPON With 0,;
                    EST->PCPCLA With VDA->PCPCLA,;
                    EST->PCPTAM With VDA->PCPTAM,;
                    EST->PCPCOR With VDA->PCPCOR,;
                    EST->FILIAL With CodigoFilial
            IF !MPR->MPRIMA=="S"
               LancaMontagem( VDA->INDICE, IF( VDA->STATUS==" " .OR. VDA->STATUS=="X","-","+" ), VDA->QUANT_, "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," "," C" ) )
            ENDIF
         ENDIF
         DBUnlockAll()
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
    USE &DiretorioDeDados\MONTAGEM.VPB Alias ASM Shared
    SET INDEX TO &DiretorioDeDados\ASMIND01.IGD, &DiretorioDeDados\ASMIND02.IGD
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
           Repl EST->DATAMV With DATE()
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
  Set Index To &DiretoriodeDados\ESTIND01.IGD,;
               &DiretoriodeDados\ESTIND02.IGD,;
               &DiretoriodeDados\ESTIND03.IGD,;
               &DiretoriodeDados\ESTIND04.IGD
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
                    EST->DATAMV With Date(),;
                    EST->RESPON With 0,;
                    EST->PCPCLA With VDA->PCPCLA,;
                    EST->PCPTAM With VDA->PCPTAM,;
                    EST->PCPCOR With VDA->PCPCOR,;
                    EST->FILIAL With CodigoFilial
            IF !MPR->MPRIMA=="S"
               LancaMontagem( VDA->INDICE, "+", VDA->QUANT_, "CF: " + Str( CodigoCaixa, 3, 0 ) + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," "," CANCELA" ) )
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
   Function fFim ()

      aFile := DIRECTORY ("*.$$$")
      AEVAL (aFile, { | x | FERASE ( x [1])})
      SetText()

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fValorPago (nValorPago, nValorPagar)

      Local lRet := .T.

      IF (nValorPago >= nValorPagar * 2)

         WHILE (.T.)
            SWGAviso( "VALOR PAGO",;
                    {{0, " "},;
                     {0, "   O valor pago esta muito elevado !"},;
                     {0, " "},;
                     {1, "           R$ " + ;
                        ALLTRIM (TRAN (nValorPago, "@E 99,999,999.99" )) + ;
                        " paga R$ " + ;
                        ALLTRIM (TRAN (nValorPagar, "@E 99,999,999.99" )) + " ?"} ,;
                     {0, " "},;
                     {0, "   Para CONFIRMAR este valor, acione a tecla [ENTER]"},;
                     {0, " "},;
                     {0, "   Para REDIGITAR o valor correto, acione a tecla [ESC]"},;
                     {0, " "}}, 7, 4, 300, 200, 800, 1220)
            IF (LASTKEY () == K_ENTER)
               EXIT
            ELSE
               IF (LASTKEY () == K_ESC)
                  lRet := .F.
                  EXIT
               ENDIF
            ENDIF
         END

      ENDIF

   Return (lRet)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fAuxilio (cVersao)

      SWGAviso( "AUXILIO                                                              1 de 4",;
              {{0, "   Saida do PDV  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [ESC]"},;
               {0, "   Quantidade Diferenciada . . . . . . . . . . . . . . . . . . . . . . . . . [F1]"},;
               {0, "   Desconto  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  [F3]"},;
               {0, "   Cancelamento de Item  . . . . . . . . . . . . . . . . . . . . . . . . . . [F4]"},;
               {0, "   Venda . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [ENTER]"},;
               {0, "   Cliente . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [F8]"},;
               {0, "   Formas de Pagamento . . . . . . . . . . . . . . . . . . . . . . . . . . . [F7]"},;
               {0, "   Fechamento do Cupom . . . . . . . . . . . . . . . . . . . . . . . . . . . [F6]"},;
               {0, " "}}, 7, 1, 300, 200, 800, 1220)

      IF (LASTKEY () == K_ESC)
         RETURN (.T.)
      ENDIF

      SWGAviso( "AUXILIO                                                              2 de 4",;
              {{0, "   Observacoes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [F11]"},;
               {0, "   Anulacao de Cupom . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [F10]"},;
               {0, "   Limpeza do Buffer do Cupom  . . . . . . . . . . . . . . . .  [CTRL+F12]"},;
               {0, "   Autenticacao  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  [F9]"},;
               {0, "   Abertura de Gaveta  . . . . . . . . . . . . . . . . . . . . . . . . . . [F5]"},;
               {0, "   Numero do Cupom Atual . . . . . . . . . . . . . . . . . . . . .  [CTRL+F7]"},;
               {0, "   SubTotal na Impressora  . . . . .  . . . . . . . . . . . . .  [CTRL_F5]"},;
               {0, "   Consulta Itens . . . . . . . . . . . . . . . . . . . . . . . . . . . . [CTRL+F1]"},;
               {0, " "}}, 7, 1, 300, 200, 800, 1220)

      IF (LASTKEY () == K_ESC)
         RETURN (.T.)
      ENDIF

      SWGAviso( "AUXILIO                                                              3 de 4",;
              {{0, "   Selecao de tabela de preco. . . . . . . . . . . . . . . [CTRL+ENTER]"},;
               {0, "   Edicao de Produto . . [ENTER prod. com op. <EDITAR> no Nome]"},;
               {0, "   Retornar ao aplicativo que chamou . . . . . . . . . . . .  [TAB]"},;
               {0, " "}}, 7, 1, 300, 200, 800, 1220)

      IF (LASTKEY () == K_ESC)
         RETURN (.T.)
      ENDIF

      SWGAviso( "AUXILIO                                                              4 de 4",;
              {{0, "   Confirmacao de Preco . . . . . . . . . . . . . . . . . . . . . . . . . . [F12]"},;
               {0, "   Auxilio  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [HOME]"},;
               {0, "   Edicao da Configuracao do Sistema (PDV.INI)  . . . " + ;
                  " [CTRL+TAB]"},;
               {0, " "},;
               {0, "     Obs. : 1) As teclas [F10] e [CTRL+F10] sao identicas"},;
               {0, "            2) As teclas [HOME] e [CTRL+A] sao identicas"},;
               {0, " "},;
               {0, " "}}, 7, 1, 300, 200, 800, 1220)

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

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
   IF File( DiretoriodeDados + "\DPAIND05.IGD" )
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD,;
                   &DiretoriodeDados\DPAIND05.IGD
   ELSE
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD
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
                  DATAEM With DATE(),;
                  FUNC__ With CodigoCaixa,;
                  OBS___ With DTOC(DATE()) + "|" + TIME() + "/" + StrZero( CodigoCaixa, 3, 0 ),;
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
   IF File( DiretoriodeDados + "\DPAIND05.IGD" )
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD,;
                   &DiretoriodeDados\DPAIND05.IGD
   ELSE
      Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                   &DiretoriodeDados\DPAIND02.IGD,;
                   &DiretoriodeDados\DPAIND03.IGD,;
                   &DiretoriodeDados\DPAIND04.IGD
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
      IF File( DiretoriodeDados + "\DPAIND05.IGD" )
         Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                      &DiretoriodeDados\DPAIND02.IGD,;
                      &DiretoriodeDados\DPAIND03.IGD,;
                      &DiretoriodeDados\DPAIND04.IGD,;
                      &DiretoriodeDados\DPAIND05.IGD
      ELSE
         Set Index To &DiretoriodeDados\DPAIND01.IGD,;
                      &DiretoriodeDados\DPAIND02.IGD,;
                      &DiretoriodeDados\DPAIND03.IGD,;
                      &DiretoriodeDados\DPAIND04.IGD
      ENDIF
      DBSetOrder( 1 )

      FOR nCt := 1 TO LEN( aMoedas )
         IF aMoedas [ nCt ][ 2 ] > 0 // [ 1 ] = Codigo   [ 2 ] = Valor
            fGravaMoeda( aMoedas [ nCt ][ 1 ], ;
                         aMoedas [ nCt ][ 2 ], ;
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
                 DATAEM With DATE()                               ,;
                 FUNC__ With CodigoCaixa                          ,;
                 OBS___ With DTOC(DATE()) + "|" + TIME() + "/" + ;
                             StrZero( CodigoCaixa, 3, 0 ) + cTmp  ,;
                 CLIENT With nCliCodigo                           ,;
                 CDESCR With cCliDescri                           ,;
                 LOCAL_ With nCodigo
      ENDIF

   Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWSnapCopy( nX0, nY0, nX1, nY1, nModo, cFile )
Local nCursor:= SetCursor( 0 )
cFile:= IF( cFile==Nil, "PDV_RES.$$$", cFile )
PicWrite( nX0, nY0, nX1, nY1, 1, cFile )
SetCursor( nCursor )
Return cFile

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWSnapPaste( nX0, nY0, cImagem )
Local nCursor
IF File( cImagem )
   nCursor:= SetCursor( 0 )
   PicRead( nX0, nY0, 1, cImagem )
   SetCursor( nCursor )
ENDIF
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWSnapKill( nVariavel )
nVariavel:= 0
nVariavel:= Nil
Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fDepur (cArq, cTex, lNovo)

      IIF (lNovo == NIL, lNovo == .F., NIL)

      IF (FILE (cArq) == .F. .OR. lNovo == .T.)
         cTmp := ""
         cDat := DTOC (DATE ()) + " " + TIME ()
      ELSE
         cTmp := MEMOREAD (cArq)
         cDat := ""
      ENDIF

      cPro := Left (Alltrim (ProcName (1)) + Space (12), 12)
      cLin := Str (ProcLine (1), 6)

      MEMOWRIT (cArq, cTmp + cPro + " " + cLin + " : " + cTex + " " + cDat + ;
                CHR (13) + CHR (10))

   Return (.T.)

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ PrecoConvertido
   ³ Finalidade  ³ Retorna o preco convertido conforme a tabela de precos
   ³             ³ utiliada no momento
   ³ Parametros  ³ nPrecoBase= Condicional, frazendo a conversao do preco determinado
   ³ Retorno     ³ nPrecoFinal
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function PrecoConvertido( nPrecoBase )
   Local nPrecoPadrao, nPrecoFinal
   IF !nPrecoBase == Nil
      nPrecoPadrao:= nPrecoBase
   ELSE
      nPrecoPadrao:= MPR->PRECOV
      IF TabelaComposta()
         nPrecoPadrao:= PrecoTabela()
      ENDIF
   ENDIF
   nPrecoFinal:= nPrecoPadrao + ( ( nPrecoPadrao  * PRE->PERACR ) / 100 )
   nPrecoFinal:= nPrecoFinal  - ( ( nPrecoFinal   * PRE->PERDES ) / 100 )
   IF MPR->PERCDC > 0
      nPrecoFinal:= nPrecoFinal - ( ( nPrecoFinal * MPR->PERCDC ) / 100 )
   ENDIF
   //nPrecoFinal:= nPrecoFinal  + ( ( nPrecoFinal * CND->PERACR ) / 100 )
   //nPrecoFinal:= nPrecoFinal  - ( ( nPrecoFinal * CND->PERDES ) / 100 )
   Return nPrecoFinal

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ TabelaComposta()
   ³ Finalidade  ³ Retornar .T. se tabela selecionada for composta ou .F. caso contrario
   ³ Parametros  ³ Nil
   ³ Retorno     ³ Nil
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function TabelaComposta()
   TAX->( DBSetOrder( 1 ) )
   /* Se localiza em tabela auxiliar a tabela */
   IF TAX->( DBSeek( PRE->CODIGO ) )
      Return .T.
   ENDIF
   Return .F.

   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ PrecoTabela
   ³ Finalidade  ³ Retornar o preco Conforme a tabela que esta
   ³             ³ sendo utilizada no momento ou retornar o preco
   ³             ³ padrao do produto
   ³ Parametros  ³ Nil
   ³ Retorno     ³ Nil
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Function PrecoTabela()
   TAX->( DBSetOrder( 2 ) )
   IF TAX->( DBSeek( MPR->INDICE ) )
      /* Se localiza o produto na tabela de preco seleciona,
         retorna o valor PRECOV nela informado */
      WHILE TAX->CODPRO == MPR->INDICE
         IF TAX->CODIGO == PRE->CODIGO
            Return TAX->PRECOV
         ENDIF
         TAX->( DBSkip() )
      ENDDO
   ENDIF
   Return MPR->PRECOV


   Function MudaTabela()
   Local nArea:= Select()
   Local oTb, cBusca:= "", nColor := SetColor ()
   Local nSaveFP:= SWSnapCopy( 50, 100, 1260, 900, 0, "PDVPRECO.$$$" )

      IF (CorPadrao == "CINZA")
         SetColor( "08/15,01/15,00/03,00/07" ) // CURSOR CIANO    (CINZA CLARO)
      ELSE
         SetColor( "08/15,01/15,00/07,00/07" ) // CURSOR CIANO    (CINZA CLARO)
      ENDIF

      DBSelectAr( _COD_TABPRECO )
      DBSetOrder( 2 )
      DBGotop()
      SWGBox( 220, 220, 1250, 800, "Pesquisa as Tabelas de Preco", 15 )
      Mensagem()
      oTB:=TBrowseDB( 10, 15, 23, 70 )
      oTB:AddColumn( TBColumnNew(, {|| StrZero( pre->CODIGO, 3, 0 ) + " - " + Left( pre->DESCRI, 45 ) + Space( 30 ) } ) )
      oTB:AUTOLITE:=.f.
      oTB:DehiLite()
      /* Refaz o display */
      oTb:RefreshAll()
      WHILE !oTB:Stabilize()
      ENDDO
      /* Loop do Browse */
      WHILE .T.
          oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{3,1})
          WHILE !oTb:Stabilize()
          ENDDO

          IF !( cBusca == "" )
             Mensagem( "Pesquisa " + cBusca )
          ELSE
             Mensagem( pre->DESCRI )
          ENDIF
          nTecla:=inkey(0)

          IF !UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
             cBusca:= ""
          ENDIF
          If nTecla=K_ESC
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
             CASE UPPER( Chr( nTecla ) ) $ "<>ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
                  IF Chr( nTecla ) $ "0123456789"
                     DBSetOrder( 1 )
                  ELSE
                     DBSetOrder( 2 )
                  ENDIF
                  cBusca:= cBusca + UPPER( Chr( nTecla ) )
                  IF IndexOrd()==2
                     DBSeek( UPPER( cBusca ), .T. )
                  ELSE
                     DBSeek( VAL( cBusca ) )
                  ENDIF
                  oTb:RefreshAll()
                  WHILE !oTb:Stabilize()
                  ENDDO
             CASE nTecla==K_ENTER
                  TabelaDePreco:= CODIGO
                  Exit

             OTHERWISE                ;tone(125); tone(300)
         ENDCASE
         oTB:refreshcurrent()
         oTB:stabilize()
      ENDDO
      DBSelectAr( nArea )
      SWSnapPaste( 50, 100, nSaveFP )
      SWSnapKill( @nSaveFP )
      SetColor( nColor )
      Return .T.


Function AbreFile( nCodigoArquivo )
DO CASE
   CASE nCodigoArquivo==_COD_CLIENTE
       DBSelectAr( _COD_CLIENTE )
       IF !Used()
          Use _VPB_CLIENTE Alias CLI Shared
          IF !File( DiretorioDeDados-"\CLIIND01.IGD" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND02.IGD" ) .OR. ;
             !File( DiretorioDeDados-"\CLIIND03.IGD" )
             Index On CODIGO Tag CLIX1 ;
                     Eval {|| .T. } ;
                     To &DiretorioDeDados\CLIIND01.IGD
             Index On Upper(Descri) Tag CLIX2 ;
                     Eval {|| .T. } ;
                     To &DiretorioDeDados\CLIIND02.IGD
             Index On FANTAS Tag CLIX3 ;
                     Eval {|| .T. } ;
                     To &DiretorioDeDados\CLIIND03.IGD
          ENDIF
          Set Index To &DiretoriodeDados\CLIIND01.IGD,;
                       &DiretoriodeDados\CLIIND02.IGD,;
                       &DiretoriodeDados\CLIIND03.IGD,;
                       &DiretoriodeDados\CLIIND04.IGD
       ENDIF
ENDCASE

Function VerificaQuit( dPagamento, nLocal )
IF ( EMPTY( dPagamento ) .AND. nLocal>0 ) .OR.;
   ( !EMPTY( dPagamento ) .AND. nLocal==0 ) .OR.;
     nLocal>0 .OR. LastKey()==K_UP
   Return .T.
ELSE
   SWGAviso( "FORMA DE PAGAMENTO INVALIDA                                            ",;
             {{0, "                                                                "},;
              {0, "  Sempre que utilizar a Conta 0=Caixa no local de pagamento     "},;
              {0, "  significa que o cliente esta fazendo uma quitacao a vista     "},;
              {0, "  e portanto a data de pagamento nao pode ficar em branco.      "},;
              {0, "                                                                "},;
              {0, "  Preencha a data de pagamento ou informe o local de pagamento  "},;
              {0, "  corretamente.                                                 "},;
              {0, "                                                                "},;
              {0, " "}}, 7, 1, 300, 200, 800, 1220)

   Keyboard Chr( K_UP ) + Chr( K_UP ) + Chr( K_UP )
   Return .F.
ENDIF


