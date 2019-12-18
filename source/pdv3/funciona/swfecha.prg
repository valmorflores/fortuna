/*
旼컴컴컴컴컴컴컴컴컴컴컴�    Soft&Ware Inform쟴ica    컴컴컴컴컴컴컴컴컴컴컴커
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

                         旼컴컴컴커 旼컴컴�   旼�    旼�
                         � 旼컴커 � � 旼� 읕� � �    � �
                         � �    � � � � 읕� � � �    � �
        旼컴컴컴컴�      � 읕컴켸 � � �   � � � 읏  粕 �     旼컴컴컴컴�
        읕컴컴컴컴�      � 旼컴컴켸 � �   � � 읏 읏粕 粕     읕컴컴컴컴�
                         � �        � � 旼� �  읏 잎 粕
                         � �        � 읕� 旼�   읏  粕
                         읕�        읕컴컴�      읕켸

旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
 Ultimo  Passo : PAGAMENTO EM DIVERSAS MOEDAS NA TELA
 Pr쥅imo Passo : PAGAMENTO EM DIVERSAS MOEDAS NA IMPRESSORA
*/

#include "common.ch"
#include "inkey.ch"

#Define _COD_MPRIMA        10
#Define _VPB_MPRIMA        &DiretorioDeDados\CDMPRIMA.DBF

#Define _COD_PRECOAUX      11
#Define _VPB_PRECOAUX      &DiretorioDeDados\TABAUX__.DBF

#Define _COD_ESTOQUE       12
#Define _VPB_ESTOQUE       &DiretorioDeDados\CESTOQUE.DBF

#Define _COD_CLIENTE       13
#Define _VPB_CLIENTE       &DiretorioDeDados\CLIENTES.DBF

#Define _COD_BANCO         14
#Define _VPB_BANCO         &DiretorioDeDados\CDBANCOS.DBF

#Define _COD_VENDEDOR      15
#Define _VPB_VENDEDOR      &DiretorioDeDados\VENDEDOR.DBF

#Define _COD_CAIXA         16
#Define _VPB_CAIXA         &DiretorioDeDadis\CAIXA___.DBF

#Define _COD_DUPAUX        17
#Define _VPB_DUPAUX        &DiretoriodeDados\CDDUPAUX.DBF

#Define _COD_CUPOM         18
#Define _VPB_CUPOM         &DiretoriodeDados\CUPOM___.DBF

#Define _COD_CUPAUX        19
#Define _VPB_CUPAUX        &DiretoriodeDados\CUPOMAUX.DBF

#Define _ARQUIVO           "PDV_PEND.DBF"
#Define _VENDAFILE         123

#define _COD_PDVEAN        20
#define _VPB_PDVEAN        &DiretoriodeDados\PDVEAN__.DBF

#define _COD_CORES         21
#define _VPB_CORES         &DiretoriodeDados\CORES___.DBF

#define _COD_CLASSES       22
#define _VPB_CLASSES       &DiretoriodeDados\CLASSES_.DBF

#Define _ABRIR             2
#Define _LIMPAR            3
#Define _EXCLUIR           4
#Define _ANULAR_ITEM       5
#Define _CRIAR             6
#Define _VENDA_ITEM        7
#Define _INFORMACOES_ITEM  8
#Define _BUSCAR_ITEM       9
#Define _ULTIMOREGISTRO    10

   Local Local1, Local2
   Local cVersao := "SWPDV v2.0-12"
   Private ModoDeVideo:= 2

   nMode:= 2
   Altd( 1 )
   SetCursor( 0 )
   SET EPOCH TO 1980
   SET DATE BRITISH
   SET SCOREBOARD OFF
   SET DELETED ON

   Cls
   Relatorio( "PDV.INI" )
   TestVModes()
   Local2:= {19, 257, 259, 261}
   Local1:= 1
   nMode:= ModoDeVideo
   SetBlink( .f. )

   fProForPag () // Programacao das Formas de Pagamento

   SetGMode( Local2[nMode] )
   SetHires(0)
   Sistema(@cVersao)
   Settext()
   fFim()
   Return Nil


********************************
procedure TESTVMODES

   private amodes
   amodes:= {{19, "VGA       320x200 256 color"}, {257, ;
      "SVGA      640x480 256 color"}, {259, ;
      "SVGA      800x600 256 color"}, {261, ;
      "SVGA      1024x768 256 color"}}
   ? "Modo Grafico Detectado"
   ? "======================"
   ?
   for i:= 1 to Len(amodes)
      if (getgmode(amodes[i][1]) != 0)
         ? Str(i, 2) + "  "
         ?? amodes[i][2]
      endif
   next
   ?
   ? "Para Suporte ao modo SuperVGA sera necessario uma  placa"
   ? "Compativel ou um driver VESA residente em mem줿ia para a"
   ? "Utilizacao deste aplicativo"
   return Nil

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function Sistema(cVersao)

   Local lFim := .F., lCupomPendente := .F., lVersaoConflito:= .F.
   Priv nHandProd, nHandDisp, nHandInfo, nHandLogo

   // Mensagem de cupom pendente - Inicio //
   IF File( _ARQUIVO )
      lCupomPendente := .T.
      !Del *.NTX
      VendaFile( _ABRIR )
   ENDIF
   // Mensagem de cupom pendente - Fim //

   MReset()
   MSetWin( 10, 10, 1340, 990 )
   MCurOn()

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

      Browse (@lFim, @lCupomPendente, @lVersaoConflito, @cVersao)

      DBCloseAll()

   ENDDO

   Return 0


// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � BROWSE
� Finalidade  � Apresentacao da Tela do Browse
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
*/
Function Browse(lFim, lCupomPendente, lVersaoConflito, cVersao)
  Local TECLA, nTotal:= 0, cTelaRes, nSave,;
        lSubTotal:= .F., nUltReg:= -1
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
        cCliCGCCPF:= Space( 18 )
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
  IF File( DiretorioDeDados-"\PDVEAN__.DBF" )
      DBSelectAr( _COD_PDVEAN )
      Use _VPB_PDVEAN Alias EAN Shared
      IF !File( DiretorioDeDados-"\EANIND01.NTX" ) .OR. ;
         !File( DiretorioDeDados-"\EANIND02.NTX" )
         !File( DiretorioDeDados-"\EANIND03.NTX" )
         Index On CODIGO Tag EANX1 ;
                 Eval {|| .T. } ;
                 To &DiretorioDeDados\EANIND01.NTX
         Index On CODEAN + CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                 STR (PCPCOR, 2) Tag EANX2 ;
                 Eval {|| .T. } ;
                 To &DiretorioDeDados\EANIND02.NTX
         Index On CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                 STR (PCPCOR, 2) Tag EANX3 ;
                 Eval {|| .T. } ;
                 To &DiretorioDeDados\EANIND03.NTX
      ENDIF
      Set Index To &DiretorioDeDados\EANIND01.NTX,;
                   &DiretorioDeDados\EANIND02.NTX,;
                   &DiretorioDeDados\EANIND03.NTX
   ELSE
       SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
               {{0, " "},;
                {0, "   O arquivo de Correspondencias EAN nao consta no diretorio !"},;
                {0, " "},;
                {0, "   Inclua o arquivo PDVEAN__.DBF no diretorio de dados do"},;
                {0, "        Fortuna"},;
                {0, "   Acione qualquer tecla para encerrar o PDV"}, ;
                {0, " "}}, 7, 4)
       Settext()
       fFim ()
       __QUIT ()
   ENDIF

   // Abertura do arquivo de Cores
   IF File( DiretorioDeDados-"\CORES___.DBF" )
       DBSelectAr( _COD_CORES )
       Use _VPB_CORES Alias COR Shared
       IF !File( DiretorioDeDados-"\CORIND01.NTX" )
          Index On CODIGO Tag CORX1 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CORIND01.NTX
       ENDIF
       Set Index To &DiretorioDeDados\CORIND01.NTX
   ENDIF

   // Abertura do arquivo de CLASSES
   IF File( DiretorioDeDados-"\CLASSES_.DBF" )
       DBSelectAr( _COD_CLASSES )
       Use _VPB_CLASSES Alias CLA Shared
       IF !File( DiretorioDeDados-"\CLAIND01.NTX" )
          Index On CODIGO Tag CLAX1 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CLAIND01.NTX
       ENDIF
       Set Index To &DiretorioDeDados\CLAIND01.NTX
   ENDIF

   // Abertura do arquivo de CLIENTES
   IF File( DiretorioDeDados-"\CLIENTES.DBF" )
       DBSelectAr( _COD_CLIENTE )
       Use _VPB_CLIENTE Alias CLI Shared
       IF !File( DiretorioDeDados-"\CLIIND01.NTX" ) .OR. ;
          !File( DiretorioDeDados-"\CLIIND02.NTX" ) .OR. ;
          !File( DiretorioDeDados-"\CLIIND03.NTX" )
          Index On CODIGO Tag CLIX1 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CLIIND01.NTX
          Index On Upper(Descri) Tag CLIX2 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CLIIND02.NTX
          Index On FANTAS Tag CLIX3 ;
                  Eval {|| .T. } ;
                  To &DiretorioDeDados\CLIIND03.NTX
       ENDIF
       Set Index To &DiretoriodeDados\CLIIND01.NTX,;
                    &DiretoriodeDados\CLIIND02.NTX,;
                    &DiretoriodeDados\CLIIND03.NTX
   ENDIF

  // Abertura do arquivo de Materia-Prima - Produtos
  IF File( DiretorioDeDados-"\CDMPRIMA.DBF" )
      DBSelectAr( _COD_MPRIMA )
      Use _VPB_MPRIMA Alias MPR Shared
      IF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" ) .AND.;
         File( DiretorioDeDados-"\MPRIND03.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND04.NTX" ) .AND.;
         File( DiretorioDeDados-"\MPRIND05.NTX" )
         Set Index To &DiretorioDeDados\MPRIND01.NTX,&DiretorioDeDados\MPRIND02.NTX,;
                      &DiretorioDeDados\MPRIND03.NTX,&DiretorioDeDados\MPRIND04.NTX,&DiretorioDeDados\MPRIND05.NTX
      ELSEIF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" ) .AND.;
             File( DiretorioDeDados-"\MPRIND03.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND04.NTX" )
         Set Index To &DiretorioDeDados\MPRIND01.NTX,&DiretorioDeDados\MPRIND02.NTX,&DiretorioDeDados\MPRIND03.NTX,&DiretorioDeDados\MPRIND04.NTX
      ELSEIF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" ) .AND.;
             File( DiretorioDeDados-"\MPRIND03.NTX" )
         Set Index To &DiretorioDeDados\MPRIND01.NTX,&DiretorioDeDados\MPRIND02.NTX,&DiretorioDeDados\MPRIND03.NTX
      ELSEIF File( DiretorioDeDados-"\MPRIND01.NTX" ) .AND. File( DiretorioDeDados-"\MPRIND02.NTX" )
         Set Index To &DiretorioDeDados\MPRIND01.NTX,&DiretorioDeDados\MPRIND02.NTX
      ENDIF
  ELSE
      SWGAviso( "ARQUIVO DE MATERIAS PRIMAS",;
              {{0, " "},;
               {0, "   O arquivo de Materias Primas nao consta no diretorio !"},;
               {0, " "},;
               {0, "   Inclua o arquivo CDMPRIMA.DBF no diretorio de dados do"},;
               {0, "        Fortuna"},;
               {0, "   Acione qualquer tecla para encerrar o PDV"}, ;
               {0, " "}}, 7, 4)
      Settext()
      fFim ()
      __QUIT ()
  ENDIF

  /* Verifica se tabela de Preco � Diferente da padr�o */
//IF TabelaDePreco > 0
//ENDIF

  PicWrite( 0, 0, 740, 900, 1, "PDV_LEF.$$$" )
  LoadcSet( 0, cFontBrowse )
  SetColor( "08/07,00/07" )

  DBSelectAr( _COD_MPRIMA )
  oTAB:=tbrowseDB(19,02,24,43)
  oTAB:addcolumn(tbcolumnnew(,{|| PAD( " " + Left( MPR->DESCRI, 39 ), 45 ) }))
  oTAB:AUTOLITE:=.f.
  oTAB:dehilite()
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
     DBGoTop()
     DispCupom( "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\", 0, .T.)
     DispCupom( " ", 0)
     DispCupom( "  . . .  C O N T I N U A C A O", 0)
     DispCupom( " ", 0)
     DispCupom( "VENDA FOI INICIADA AS " + VDA->HORA__ + "Hs.", 0 )
     DispCupom( "Cupom Fiscal No. " + StrZero( VDA->NUMCUP, 6), 0 )
     DispCupom( "Produto                                               Preco", 5)
     DispCupom( "======================================= ==========", 0)
     WHILE !EOF()
        IF STATUS==" "
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
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1})
      WHILE nextkey()==0 .and. ! oTAB:stabilize()
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
         SayString( 250, 075, 4, 0, 1, PAD( ALLTRIM( MPR->INDICE ) + "-" + ALLTRIM( STR( PRECOV ) ) + "00", 40 ) )

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
            SayString( 400, 500, 4, 0, 08, Alltrim( Tran( MPR->PRECOV, "@E 999,999.99" ) ) )
            SayString( 400, 502, 4, 0, 03, Alltrim( Tran( MPR->PRECOV, "@E 999,999.99" ) ) )
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
/*
      // Mensagem de cupom pendente - Inicio //
      IF (lCupomPendente = .T.)
         lCupomPendente := .F.
         SWGAviso( "                      CUPOM FISCAL NAO FINALIZADO", ;
                 {{0, " "},;
                  {0, " "},;
                  {0, "                   Existe um Cupom pendente no PDV !"},;
                  {0, " "},;
                  {0, "                  Acione qualquer tecla para continuar"}, ;
                  {0, " "}}, 7, 4)
      ENDIF
      // Mensagem de cupom pendente - Fim //
*/
      WHILE ( nTecla:=Inkey() )==0 // #01
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
         CASE nTecla==K_BS .OR. nTecla==K_LEFT .OR. nTecla==K_RIGHT
            IF (EMPTY (cBusca) == .F.)
               cBusca := LEFT (cBusca, LEN (cBusca) - 1)
               LoadcSet( 0, "VSYS14.PTX" )
               SayString( 250, 100, 4, 0, 1, PAD( cBusca, 29 ) )
            ENDIF
         CASE nTecla==K_UP         ;oTAB:up();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_DOWN       ;oTAB:down();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_PGUP       ;oTAB:pageup();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop() ;cBusca:= ""; lAchou := .T.
         CASE nTecla==K_PGDN       ;oTAB:pagedown();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom();cBusca:= ""; lAchou := .T.
         CASE nTecla==K_CTRL_F7;cBusca:= ""; lAchou := .T.
              DispCupom( "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\", 0, .T.)
              DispCupom( " ", 0)
              DispCupom( " ", 0)
              DispCupom( "Cupom Fiscal No. " + NumeroCupom( ), 0 )
              DispCupom( "Produto                                               Preco", 5)
              DispCupom( "======================================= ==========", 0)

         CASE nTecla==K_ENTER // #01

               IF (fVerifBusca (@cBusca, @nRegAtuEAN, @oTab) == .F.)
                  CLEAR TYPEAHEAD
                  LOOP
               ENDIF

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

                  /* Se Estiver habilitado o F12 ou se PrecoVenda==0 */
                  IF nStatus==8 .OR. MPR->PRECOV <= 0

                     nPreco:= MPR->PRECOV
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
                     SWSnapKill( nSaveF2 )
                     IF (LASTKEY () = K_ESC)
                        IF !nStatus==10
                           nStatus:= 2
                        ENDIF
                        LOOP
                     ENDIF
                  ELSE
                     nPreco:= MPR->PRECOV
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
                  ENDIF
                  IF nStatus == 1 .OR. VendaFile( _ULTIMOREGISTRO ) <= 0
                     IF lPrinter
                        ImpAbreCupom()
                     ENDIF
                     NumeroCupom( "000000" )
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
                     lRetorno:= impVendeProduto( MPR->CODFAB,;
                                  Left( MPR->DESCRI, 30 ),;
                                  cTabela,;
                                  nQuantidade,;
                                  nPreco,;
                                  IF( nStatus==9, nDescPercentual, 0 ),;
                                  IF( nStatus==9, nDescValor, 0 ),;
                                  VDA->( LastRec() ),;
                                  MPR->UNIDAD )
                  ENDIF
                  IF lRetorno .OR. ( Impressora $ "Nenhuma-Treinamento" )
                     VendaFile( _VENDA_ITEM, nPrecoFinal, nQuantidade, ;
                                cTabela, @nTamEAN, @nCorEAN )
                     lCancelaItem:= .F.
                     nDescPercentual:= 0
                     nDescValor:= 0
                     DispCupom( Left( MPR->DESCRI, 31), 4 )
                     DispValor( Tran( nPrecoFinal, "@E 999,999.99"), 4 )
                     nTotal:= nTotal + nPrecoFinal
                     IF Alltrim( CLI->DESCRI )==Alltrim( cCliDescri )
                        nSalLimCre -= nPrecoFinal
                     ENDIF
                  ELSE
                     DispCupom( "**** FALHA NA VENDA DESTE PRODUTO ****", 13 )
                  ENDIF
               ELSEIF nStatus==4
                  IF VendaFile( _ANULAR_ITEM, MPR->INDICE )
                     nPrecoFinal:= VendaFile( _INFORMACOES_ITEM )[ 9 ]
                     VendaFile( _BUSCAR_ITEM, MPR->INDICE )
                     IF lPrinter
                        impCancItem( VendaFile( _INFORMACOES_ITEM )[ 1 ] )
                     ENDIF
                     nTotal-= nPrecoFinal
                     IF Alltrim( CLI->DESCRI )==Alltrim( cCliDescri )
                        nSalLimCre += nPrecoFinal
                     ENDIF
                     DispCupom( MPR->DESCRI, 5 )
                     lCancelaItem:= .F.
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
              cBusca:= ""; lAchou := .T.
              IF nStatus == 2 .OR. nStatus == 4
                 lCancelaItem:= IF( lCancelaItem, .F., .T. )
                 nStatus:= IF( lCancelaItem, 4, 2 )
                 lSubTotal:= .T.
              ENDIF

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
              @ 20, 15 Say "CEP      " Get cCliCodCep ;
                 When Mensagem( "Digite o Cep do cliente" )
              @ 22, 15 Say "CGC/CPF  " Get cCliCgcCpf ;
                 When Mensagem( "Digite o CFG/CPF do cliente" )

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SetColor( cCorRes )
              SWSnapPaste( 50, 100, nSaveF8 )
              SWSnapKill( nSaveF8 )
              //mCurOn()

              IF Alltrim( CLI->DESCRI )==Alltrim( cCliDescri ) .AND. !EMPTY( cCliDescri )
                 nCliCodigo:= CLI->CODIGO
                 nSalLimCre := CLI->SALDO_ - nTotal
                 DispCupom( "Cliente ATIVADO !", 2 )
                 nRegAtuCli := CLI -> (RECNO ())
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
                        IF Len( Alltrim( cCliCGCCPF ) )==11
                           Replace CLI->CPF___ With cCliCgcCpf
                        ELSE
                           Replace CLI->CGCMF_ With cCliCgcCpf
                        ENDIF
                    ENDIF
                    DBSetOrder( nOrdRes )
                    DispCupom( "Cliente ATIVADO !", 2 )
                    nRegAtuCli := CLI -> (RECNO ())
                 ELSE
                    nCliCodigo:= 0
                    nRegAtuCli:= 0
                    DispCupom( "Cliente Nao Cadastrado!", 2 )
                 ENDIF
              ENDIF

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
              SWSnapKill( nSaveF11 )
              oTab:RefreshAll()
              WHILE !oTab:Stabilize()
              ENDDO

         CASE nTecla == K_F5
              cBusca:= ""; lAchou := .T.
              IF lPrinter
                 impSubTotCupom()
              ENDIF

         CASE (nTecla == K_F10 .OR. nTecla == K_CTRL_F10)
              cBusca:= ""; lAchou := .T.
              SWGAviso( "ANULACAO DO CUPOM FISCAL",;
                      {{0, " "},;
                       {0, "   O Cupom Fiscal sera ANULADO !"},;
                       {0, " "},;
                       {0, "   Para confirmar, acione a tecla [F10]"},;
                       {0, " "},;
                       {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                       {0, " "}}, 7, 4)

              IF (LASTKEY () == K_F10 .OR. LASTKEY () == K_CTRL_F10)
                 AnulaCupom( impCupomAtual() )
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
              nPreco:= MPR->PRECOV
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
              SWSnapKill( nSaveF3 )

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
              SWSnapKill( nSaveF1 )
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
              SWSnapKill( nSaveF7 )

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
                 SWSnapKill( nSaveF7 )
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
                     Valid !LastKey()==K_ESC

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
              SWSnapKill( nSaveF7 )
              DBSelectAr( _COD_MPRIMA )
              oTab:RefreshAll()
              WHILE !oTaB:stabilize()
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
              cAcrDes:= "D"
              nPerAcrDes:= 0
              nVlrAcrDes:= 0

              loadcSet( 0, "VSYS14.PTX" )
              nSaveF6:= SWSnapCopy( 50, 100, 1320, 950, 0, "PDV_F6__.$$$" )

              IF Len( aParcelas ) > 0
                 AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )
                 IF fVerLimCred( @lLimCredAvis, @nCliCodigo, @nTotal, @nSalLimCre )
                 ENDIF

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
                               Valid nValorPago >= nValorPagar .OR. ;
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
                                    .AND. fTroco (@nValorPagar, @nValorPago)
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

                 cCrediario:= "Pagamento: A VISTA"
                 nCol:= 1
                 IF Len( aParcelas ) > 0 .AND. CarneInterno
                    cCrediario:= "       F O R M A   D E   P A G A M E N T O     " + Chr( 13 ) + Chr( 10 )
                    cCrediario:= cCrediario + "Pr---Vencim--Valor------Pr---Vencim--Valor-----" + Chr( 13 ) + Chr( 10 )
                    FOR nCt:= 1 TO Len( aParcelas )
                        cVlr:= Tran( aParcelas[ nCt ][ 3 ], "@E 999,999.99" )
                        cVenc:= DTOC( aParcelas[ nCt ][ 4 ] )
                        cP:= Str( aParcelas[ nCt ][ 2 ], 3, 0 )
                        cCrediario:= cCrediario + cP + " " + cVenc + " " + cVlr
                        IF nCol==2 .OR. nCt == Len( aParcelas )
                           cCrediario:= cCrediario + Chr( 13 ) + Chr( 10 )
                           nCol:= 0
                        ENDIF
                        nCol:= nCol + 1
                        nCliCodigo:= 0
                        nRegAtuCli := 0
                    NEXT
                    cCrediario:= cCrediario + "***-----------------*** ***-----------------***" + Chr( 13 ) + Chr( 10 )
                    cMensagem:= cMensagem + cCrediario
                 ELSEIF !CarneInterno
                    cCrediario:= ""
                    cCrediario:= cCrediario + "Pr---Vencim--------------------------VALOR-----" + Chr( 13 ) + Chr( 10 )
                    FOR nCt:= 1 TO Len( aParcelas )
                        cVlr:= Tran( aParcelas[ nCt ][ 3 ], "@E 999,999.99" )
                        cVenc:= DTOC( aParcelas[ nCt ][ 4 ] )
                        cP:= Str( aParcelas[ nCt ][ 2 ], 3, 0 )
                        cCrediario:= cCrediario + cP + " " + cVenc + "......................... " + cVlr + Chr( 13 ) + Chr( 10 )
                        FOR nLin:= 1 TO 5
                            cCrediario:= cCrediario + " " + Chr( 13 ) + Chr( 10 )
                        NEXT
                        nCol:= nCol + 1
                        nCliCodigo:= 0
                        nRegAtuCli := 0
                    NEXT
//                  Inkey(0)
                 ENDIF
                 IF nPerAcrDes > 0 .AND. nVlrAcrDes==0
                    nVlrAcrDes:= ROUND( ( nTotal * nPerAcrDes ) / 100, 2 )
                    nPerAcrDes:= 0
                 ENDIF

                 IF lPrinter
                     IF (Impressora == "BEMATECH-MP20FI-II")
                        IF (MoedasEspecificas == "SIM")
                           fImpMoeda (nPgtDin, nPgtTic, nPgtChq, nPgtCar, nPgtPra, nPgtOut) // aqui
                        ENDIF
                        ImpFechaCom (cAcrDes, nPerAcrDes, nVlrAcrDes, ;
                                     nValorPago, cForma, cMensagem)
                     ELSE
                        ImpFechaSem(cAcrDes, nPerAcrDes, nVlrAcrDes, nTotal, nValorPago, cMensagem, "CGCCPF" )
                     ENDIF
                 ENDIF

                 LancaEstoque(@nRegAtuCli, @nRegAtuEAN)

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
                       AnulaCupom( impCupomAtual() )
                       IF lPrinter
                          ImpCancCupom()
                       ENDIF
                       LancaEstoque(@nRegAtuCli, @nRegAtuEAN)
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
                                      Tran( cCliCgcCpf, "@R 999.999.999-99" ) ) )
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
                    LancaEmCaixa( nValorPagar )
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
              SWSnapKill( nSaveF6 )

         CASE nTecla == K_F9
              cBusca:= ""; lAchou := .T.
              Autentica( 0 )

         CASE nTecla == K_CTRL_F5 // Era K_F10
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

         CASE UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ01234566789 -+*/"
              LoadcSet( 0, "VSYS14.PTX" )
              cBusca:= cBusca + CHR( nTecla )
              SayString( 250, 100, 4, 0, 1, PAD( cBusca, 28 ) )

              IF (UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ-/")
                 nReg:= MPR -> (RECNO())
                 MPR -> (DBSetOrder (2)) // upper( Descri )
                 IF (MPR -> (DBSeek (UPPER( cBusca ))) = .T.)
                    nReg:= MPR -> (RECNO())
                    MPR -> (DBGoTo (nReg))
                    MPR -> (DBSetOrder (2)) // upper( Descri )
                    LoadcSet( 0, "VSYS14.PTX" )
                    oTab:RefreshAll()
                    WHILE !oTab:Stabilize()
                    ENDDO
                    lAchou := .T.
                 ELSE
                    MPR -> (DBGoTo (nReg))
                    lAchou := .F.
                 ENDIF
              ENDIF

         OTHERWISE                ;tone(125); tone(300)
//AQUI
      ENDCASE

      loadcSet( 0, cFontBrowse )
      oTAB:refreshcurrent()
      oTAB:stabilize()

   ENDDO
   //mCurOff()

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

      FOR nCt:= 1 TO Len( GetList )
          GetList[ nCt ]:Display()
      NEXT

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fExiForNum( cFormula, nPgtXXX, GetList )
   Private cFor:= cFormula

      IF EMPTY( cFormula )
         cFormula:= PAD( Alltrim( Str( nPgtXXX, 14, 2 ) ), 40 )
      ELSEIF !( nPgtXXX == &cFor )
         cFormula:= PAD( Alltrim( Str( nPgtXXX, 14, 2 ) ), 40 )
      ENDIF
      Release cFor

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fPgtDin (nValorPagar, GetList )

      nPgtDin := nValorPagar - nPgtTic - nPgtChq - nPgtCar - nPgtOut

      IF nPgtDin < 0
         nPgtDin := 0
      ENDIF

      cPgtDin := PAD( Alltrim( Str( nPgtDin, 14, 2 ) ), 40 )

      fTroco (nValorPagar, nValorPago )

      FOR nCt:= 1 TO Len( GetList )
          GetList[ nCt ]:Display()
      NEXT

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fTroco (nValorPagar, nValorPago )

      nValorPago := nPgtDin + nPgtTic + nPgtChq + nPgtCar + nPgtOut

      @ 22,37 Say nValorPago - nValorPagar Pict "@R 99,999,999,999.99" ;
         Color "04/15"

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fVerifBusca (cBusca, nRegAtuEAN, oTab)

      Local lRet := .T.

      IF (EMPTY (cBusca) == .F.)
         IF (SUBSTR (cBusca, 1, 1) $ "0123456789" .AND. ;
             SUBSTR (cBusca, 2, 1) $ "0123456789" .AND. ;
             SUBSTR (cBusca, 3, 1) $ "0123456789")
            IF (fCodigoEAN (@cBusca, @nRegAtuEAN) == .F.)
               lRet := .F.
            ELSE
               nReg:= MPR -> (RECNO())
            ENDIF
         ENDIF
      ENDIF

      cBusca:= ""

      MPR -> (DBSetOrder (2)) // upper( Descri )

//    LoadcSet( 0, "VSYS14.PTX" )
//    oTab:RefreshAll()
//    oTAB:stabilize()

   Return (lRet)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fCodigoEAN (cBusca, nRegAtuEAN)

      Local lRet := .T.

      EAN -> (DBSetOrder (1)) // CODIGO (Codigo EAN Interno)
      IF (EAN -> (DBSeek (UPPER( cBusca ))) = .F.)

         EAN -> (DBSetOrder (2)) // CODEAN (Codigo EAN Fabrica)
         IF (EAN -> (DBSeek (UPPER( cBusca ))) = .F.)

            nReg:= MPR -> (RECNO())
            MPR->( DBSetOrder( 4 ) )
            IF (MPR -> (DBSeek (UPPER( cBusca ))) = .F.)

                SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
                        {{0, " "},;
                         {0, "   O codigo EAN Interno e/ou Fabrica nao consta no arquivo !"},;
                         {0, " "},;
                         {0, "   Verifique o arquivo de Materias Primas do Fortuna"},;
                         {0, " "},;
                         {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                         {0, " "}}, 7, 4)

                MPR -> (DBGoTo (nReg))

                lRet := .F.

            ENDIF

         ENDIF

      ENDIF

   Return (lRet)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

         nTecla:=inkey( 0 )

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
      SWSnapKill( nSaveCorEAN )

      DBSelectAr( nArea )
      DBSetOrder( nOrdem )

      SetColor( cCorAnt )
      SetCursor( nCursor )

   Return (nCorRet)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

         nTecla:=inkey( 0 )

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
      SWSnapKill( nSaveTamEAN )

      DBSelectAr( nArea )
      DBSetOrder( nOrdem )

      SetColor( cTamAnt )
      SetCursor( nCursor )

   Return (nTamRet)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fVerLimCred( lLimCredAvis, nCliCodigo, nTotal, nSalLimCre)

      Local cTamAnt:= SetColor( ), nCursor:= SetCursor( ), nArea:= Select(), ;
            nOrdem:= IndexOrd( )
      Local lRet := .T.

      CLI->( DBSetOrder( 1 ) )
      IF CLI->( DBSeek( nCliCodigo ) )
         IF CLI->LIMCR_ > 0 .AND. ;
            lLimCredAvis == .F. .AND. nTotal > nSalLimCre)
            WHILE (.T.)
               SWGAviso( "LIMITE DE CREDITO",;
                       {{0, "   Este cliente esta com o limite de credito esgotado !"},;
                        {0, " "},;
                        {1, "      Limite de Credito = R$  "   + ALLTRIM (TRAN (CLI -> LIMCR_, "@E 99,999,999.99" ))} ,;
                        {1, "                    Saldo = R$  " + ALLTRIM (TRAN (nSalLimCre,    "@E 99,999,999.99" ))} ,;
                        {0, " "},;
                        {0, "   Para confirmar a VENDA deste item, acione a tecla [ENTER]"},;
                        {0, " "},;
                        {0, "   Para NAO VENDER este item, acione a tecla [ESC]"},;
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
            END
         ENDIF
      ENDIF
      SetColor( cTamAnt )
      SetCursor( nCursor )

   Return (lRet)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function DispCupom( cProduto, nCor, lDupla )

      _VScroll( 778, 498, 1340, 840, 20, 15 )
       loadcSet( 0, "AGSYSA14.PTX" )
//AQUI
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
             FOR nCt2:= 1 TO 1599  /* GASTA TEMPO HA!HA!HA!-TESTE */
             NEXT
          NEXT
          SayString( 800, 500, 4, 0, nCor, cProduto )
       ENDIF

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function DispValor( cValor, nCor )

       loadcSet( 0, "AGSYSA14.PTX" )
//     loadcSet( 0, "AGSYSD10.PTX" )
       SayString(1235, 500, 4, 0, nCor, cValor )

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function SWGAviso( cTitulo, aAviso, nCor, nCorTit, nLin1x, nCol1x, nLin2x, nCol2x )
//                            �
//                            쳐컴� 1� elemento = COR
//                            읕컴� 2� elemento = CARACTERES

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
   r= SWSnapKill( nTELAVAL )

Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function Efeito()
Local nCor

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � VendaFILE
� Finalidade  � Tratamento de Informacoes p/ arquivo de seguranca
�             � com Informacoes sobre a venda.
� Parametros  � xPar1..xPar4
� Retorno     � xRetorno- Conforme o parametro de chamada
� Programador � Valmor Pereira Flores
� Data        � 03/07/1999
읕컴컴컴컴컴컴�
*/
Function VendaFile( xPar1, xPar2, xPar3, xPar4, nTamEAN, nCorEAN)
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
         nPrecoV:= MPR->PRECOV
         nPrecoT:= xPar2
         nQuant_:= xPar3
         cSt:=     xPar4
         DBAppend()
         Replace CODLAN With nCodLan,;
                 INDICE With MPR->( INDICE ),;
                 CODFAB With MPR->CODFAB,;
                 DESCRI With MPR->DESCRI,;
                 UNIDAD With MPR->UNIDAD,;
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
                 NUMCUP With VAL (NumeroCupom())
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
              { "PCPCOR", "N", 02, 00 },;
              { "NUMCUP", "N", 06, 00 }}
      DBCreate( _ARQUIVO, aStr )
   ELSEIF xPar1 == _ABRIR
      DBSelectAr( _VENDAFILE )
      IF !Used()
         Use _ARQUIVO Alias VDA Exclusive
         Index On INDICE To PDV_PEND.NT1
         Index On CODLAN To PDV_PEND.NT2
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
         IF BOF()
            xRetornar:= .F.
         ENDIF
      ENDIF

   ELSEIF xPar1 == _ANULAR_ITEM
      DBSelectAr( _VENDAFILE )
      IF Used()
         DBSetOrder( 1 )
         IF VendaFile( _BUSCAR_ITEM, xPar2 )
            nPrecoV:= PRECOV
            nPrecoT:= PRECOT
            nQuant_:= QUANT_
            cSt:=     ST____
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function NumeroCupom( cNumero )

      Static cCupom

      IF !cNumero==Nil
         IF( cCupom == Nil .OR. cCupom == "")
            Return "NAO INFORMADO"
         ENDIF
      ELSEIF cNumero=="<Buscar>"
         IF ( cCupom:= ImpCupomAtual() )== Nil
            Return ""
         ENDIF
      ELSE
         cCupom:= ImpCupomAtual()
      ENDIF

   Return cCupom

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function AnulaCupom( cCupom )
Return .F.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � MENSAGEM
� Finalidade  � Exibicao da mensagem na tela
� Parametros  � cMensagem
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function UltimaTela( nCol, nLin )
Static nUTLin, nUTCol
IF nCol==Nil
   Return { nUTCol, nUTLin }
ELSE
   nUTLin:= nLin
   nUTCol:= nCol
ENDIF
Return { nUTCol, nUTLin }

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � BuscaCli
� Finalidade  � Apresentar relacao de clientes no PDV
� Parametros  � cNome
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
*/
Function BuscaCli( nCliCodigo, cCliDescri, cCliEndere,  cCliBairro,  cCliCidade,  cCliEstado,  cCliCodCep,  cCliCGCCPF, GetList )
Local cFontBrowse:= "VSYS14.PTX"
Local nCt:= 0
Local nArea:= Select(), oTb, nCursor:= SetCursor(), nColor := SetColor ()
Local nTelaC
Local cBusca:= "", nTecla
Local nRegiao, nBotao

   IF (CorPadrao == "CINZA")
      SetColor( "08/15,01/15,00/03,00/07" ) // CURSOR CIANO    (CINZA CLARO)
   ELSE
      SetColor( "08/15,01/15,00/07,00/07" ) // CURSOR CIANO    (CINZA CLARO)
   ENDIF

  //mCurOff()
  SetCursor( 0 )
  DBSelectAr( _COD_CLIENTE )
  /*
  IF !Used()
     Use _VPB_CLIENTE Alias CLI Shared
     Set Index To &DiretoriodeDados\CLIIND01.NTX,;
                  &DiretoriodeDados\CLIIND02.NTX,;
                  &DiretoriodeDados\CLIIND03.NTX
  ENDIF
  */
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
/*
     DBSelectAr( _COD_CLIENTE )
     DBCloseArea()
*/
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
            oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{3,1})
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

            IF !( UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &" )
               cBusca:= ""
            ENDIF
            IF nTecla==K_ESC
               nCliCodigo:= 0
               cCliDescri:= Space( Len( DESCRI ) )
               cCliCGCCPF:= Space( 18 )
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
               CASE UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
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
                    EXIT
               OTHERWISE                ;tone(125); tone(300)
            ENDCASE
            loadcSet( 0, "VSYS14.PTX" )
            oTb:refreshcurrent()
            oTb:stabilize()
        ENDDO
     ENDIF

     /* Restauracao */
     SWSnapPaste( 50, 100, nTelaC )
     SWSnapKill( nTelaC )

  ENDIF
  FOR nCt:= 1 TO Len( GetList )
      GetList[ nCt ]:Display()
  NEXT
  SetColor (nColor)
  DBSelectAr( nArea )
  SetCursor( nCursor )
  Return .T.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function ExibeTotais( cTitulo, nValor )
   Return (.T.)

      loadcSet( 0, "VSYS14.PTX" )
      SayString( 35, 500, 4, 0, 0, cTitulo )

      LoadcSet( 0, "DGE1609.PTX" )
      SayString( 400, 500, 4, 0, 7, Alltrim( Tran( nValor, "@E 999,999.99" ) ) )
      SayString( 400, 502, 4, 0, 1, Alltrim( Tran( nValor, "@E 999,999.99" ) ) )

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � BUSCAVENDEDOR
� Finalidade  � Apresentar relacao de VENDEDORs no PDV
� Parametros  � cNome
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
*/
Function BuscaVENDEDOR( nCodigo )
Local nCursor:= SetCursor()
Local nArea:= Select()
   DBSelectAr( _COD_VENDEDOR )
   IF !Used()
      Use _VPB_VENDEDOR Alias VEN Shared
      Set Index To &DiretoriodeDados\VENIND01.NTX,;
                   &DiretoriodeDados\VENIND02.NTX
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � FORMAPAGAMENTO
� Finalidade  � Apresentacao das formas de pagamentos disponiveis
� Parametros  � nLin1, nCol1, nLin2, nCol2, aParcelas
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        � Novembro/1998
읕컴컴컴컴컴컴�
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

       IF !UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
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
          CASE UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
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
   SWSnapKill( nSaveFP )
   SetColor (nColor)
   Return .T.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � CalcVenc
� Finalidade  � Ajustar a data de vencimento cfe. a quantidade de dias
� Parametros  � dDataBase, nDias, dVencimento
� Retorno     � .T.
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
*/
Function CalcVenc( dDataBase, nDias, dDataVencimento, nPercentual, nValorPagar )
   dDataVencimento:= dDataBase + nDias
Return .T.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � CalcParcela
� Finalidade  � Calcula parcela
� Parametros  � nValorPagar, nPercentual, nParcela
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function fCalcPerc (nPercentual, nValorPagar, nParcela )
   nPercentual := ( nParcela / nValorPagar ) * 100
   SetColor( "01/15" )
   @ 09,31 SAY nPercentual Pict "999.99%"
   SetColor( "08/15,01/15" )
Return .T.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
     Set Index To &DiretoriodeDados\CUPIND01.NTX,;
                  &DiretoriodeDados\CUPIND02.NTX,;
                  &DiretoriodeDados\CUPIND03.NTX,;
                  &DiretoriodeDados\CUPIND04.NTX
  ENDIF
  DBSelectAr( _COD_CUPAUX )
  IF !USED()
     Use _VPB_CUPAUX Alias CPA Shared
     Set Index To &DiretoriodeDados\CAUIND01.NTX,;
               &DiretoriodeDados\CAUIND02.NTX,;
               &DiretoriodeDados\CAUIND03.NTX,;
               &DiretoriodeDados\CAUIND04.NTX,;
               &DiretoriodeDados\CAUIND05.NTX
  ENDIF
  DBSelectAr( _VENDAFILE )
  DBGoTop()
  WHILE !EOF()
      IF MPR->( DBSeek( VDA->INDICE ) )
         CPA->( DBAppend() )
         CPA->( RLock() )
         IF !CPA->( NetErr() )
            Replace CPA->CODIGO With VDA->INDICE
            Replace CPA->CODRED With VDA->INDICE
            Replace CPA->CODIGO With VDA->INDICE
            Replace CPA->DESCRI With VDA->DESCRI
            Replace CPA->MPRIMA With MPR->MPRIMA
            Replace CPA->UNIDAD With VDA->UNIDAD
            Replace CPA->QUANT_ With VDA->QUANT_
            Replace CPA->PRECOV With VDA->PRECOV
            Replace CPA->PRECOT With VDA->PRECOT
            Replace CPA->CODNF_ With VAL (NumeroCupom())
         ENDIF
         IF !( MPR->IPICOD==4 )
            nValorIcm:= nValorIcm + ( CPA->PRECOT * Icm ) / 100
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
             NUMERO With Val( NumeroCupom() ),;
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


// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
  Set Index To &DiretoriodeDados\CX_IND01.NTX
  DBAppend()
  IF !NetErr()
     Replace DATAMV With DATE(),;
             VENDE_ With CodigoCaixa,;
             ENTSAI With "+",;
             MOTIVO With 00,;
             HISTOR With "CF: " + NumeroCupom(),;
             VALOR_ With nRecebido,;
             HORAMV With TIME(),;
             CDUSER With 0
  ENDIF
  DBSelectAr( _COD_MPRIMA )
  Return Nil



// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
     CLI -> (DBGoTo (nRegAtuCli))
  ENDIF

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
      IF STATUS==" " .OR. STATUS=="E" .OR. STATUS=="X"
         IF MPR->( DBSeek( VDA->INDICE ) )
            IF MPR->( RLock() )
               Replace MPR->SALDO_ With MPR->SALDO_ - VDA->QUANT_
            ENDIF
            DBUnlockAll()
         ENDIF
         EST->( DBAppend() )
         IF EST->( RLock() )
            Replace EST->CPROD_ With VDA->INDICE,;
                    EST->CODRED With VDA->INDICE,;
                    EST->ENTSAI With IF( VDA->STATUS==" " .OR. VDA->STATUS=="X","-","+" ),;
                    EST->QUANT_ With VDA->QUANT_,;
                    EST->DOC___ With "CF: " + NumeroCupom() + IF( VDA->STATUS==" " .OR. VDA->STATUS=="X"," ","C" ),;
                    EST->CODIGO With 0,;
                    EST->VLRSDO With 0,;
                    EST->VALOR_ With VDA->PRECOT,;
                    EST->DATAMV With Date(),;
                    EST->RESPON With 0,;
                    EST->PCPCLA With VDA->PCPCLA,;
                    EST->PCPTAM With VDA->PCPTAM,;
                    EST->PCPCOR With VDA->PCPCOR
         ENDIF
      ENDIF
      DBUnlockAll()
      // *** SALDO NO PDVEAN
      EAN -> (DBSetOrder (3)) // CODPRO ...

      IF (EAN -> (DBSeek (VDA -> INDICE + STR (VDA -> PCPCLA, 3) + ;
                      STR (VDA -> PCPTAM, 2) + STR (VDA -> PCPCOR, 2))) == .T.)
         EAN->( Rlock() )
         IF !EAN->( NetErr() )
            EAN -> SALDO_ -= VDA->QUANT_
         ENDIF
         EAN->( DBUnlock() )
      ENDIF

// *** SALDO NO CLIENTES
      IF (nRegAtuCli <> 0)
         CLI->( Rlock() )
         IF !CLI->( NetErr() )
            CLI -> SALDO_ -= VDA->PRECOT
         ENDIF
         CLI->( DBUnlock() )
      ENDIF

      VDA->( DBSkip() )

  ENDDO
  DBSelectAr( _COD_MPRIMA )
  DBSetOrder( 1 )

  Return Nil

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fFim ()

      aFile := DIRECTORY ("*.$$$")
      AEVAL (aFile, { | x | FERASE ( x [1])})
      SetText()

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fAuxilio (cVersao)

      SWGAviso( "AUXILIO                                                              1 de 3",;
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

      SWGAviso( "AUXILIO                                                              2 de 3",;
              {{0, "   Observacoes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [F11]"},;
               {0, "   Anulacao de Cupom . . . . . . . . . . . . . . . . . . . . . . . . . . . . . [F10]"},;
               {0, "   Limpeza do Buffer do Cupom  . . . . . . . . . . . . . . . .  [CTRL+F12]"},;
               {0, "   Autenticacao  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  [F9]"},;
               {0, "   Abertura de Gaveta  . . . . . . . . . . . . . . . . . . . . . . . [CTRL+F5]"},;
               {0, "   Numero do Cupom Atual . . . . . . . . . . . . . . . . . . . . .  [CTRL+F7]"},;
               {0, "   SubTotal na Impressora  . . . . . . . . . . . . . . . . . . . . . . . .  [F5]"},;
               {0, "   Consulta Itens . . . . . . . . . . . . . . . . . . . . . . . . . . . . [CTRL+F1]"},;
               {0, " "}}, 7, 1, 300, 200, 800, 1220)

      IF (LASTKEY () == K_ESC)
         RETURN (.T.)
      ENDIF

      SWGAviso( "AUXILIO                                                              3 de 3",;
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*****
旼컴컴컴컴컴컴�
� Funcao      � LancaReceber
� Finalidade  � Lanca Contas a Receber
� Parametros  � aParcelas
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
읕컴컴컴컴컴컴�
*/
Function LancaReceber( aParcelas, nCliCodigo, cCliDescri )
   DBSelectAr( _COD_DUPAUX )
   Use _VPB_DUPAUX Alias DPA Shared
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
   DBSetOrder( 1 )
   FOR nCt:= 1 TO Len( aParcelas )
       DBAppend()
       IF RLock()
          nCodCli:= 0
          Replace CODNF_ With VAL( NumeroCupom() ),;
                  DUPL__ With VAL( NumeroCupom() ),;
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function LanRecMoeDiv( aMoedas, nCliCodigo, cCliDescri, nPerAcrDes, ;
                          cAcrDes  )

      DBSelectAr( _COD_DUPAUX )
      Use _VPB_DUPAUX Alias DPA Shared
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
         Replace CODNF_ With VAL( NumeroCupom() )                 ,;
                 DUPL__ With VAL( NumeroCupom() )                 ,;
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

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function SWSnapCopy( nX0, nY0, nX1, nY1, nModo, cFile )
cFile:= IF( cFile==Nil, "PDV_RES.$$$", cFile )
PicWrite( nX0, nY0, nX1, nY1, 1, cFile )
Return cFile

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function SWSnapPaste( nX0, nY0, cImagem )
PicRead( nX0, nY0, 1, cImagem )
Return .T.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function SWSnapKill()
Return Nil

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
/*
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
