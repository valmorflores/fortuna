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

 Ultimo  Passo : EXIBICAO DO QUADRO DE PARCELAS NO FECHAMENTO
 Pr쥅imo Passo : APOS F1 RESTAURAR QUANT PARA 1;

*/
#include "common.ch"
#include "inkey.ch"

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
#Define _VPB_VENDEDOR      &DiretorioDeDados\CDBANCOS.VPB

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

#define _COD_PDVEAN        20
#define _VPB_PDVEAN        &DiretoriodeDados\PDVEAN__.VPB

#define _COD_CORES         21
#define _VPB_CORES         &DiretoriodeDados\CORES___.VPB

#define _COD_CLASSES       22
#define _VPB_CLASSES       &DiretoriodeDados\CLASSES_.VPB

#Define _ABRIR             2
#Define _LIMPAR            3
#Define _EXCLUIR           4
#Define _ANULAR_ITEM       5
#Define _CRIAR             6
#Define _VENDA_ITEM        7
#Define _INFORMACOES_ITEM  8
#Define _BUSCAR_ITEM       9

   local Local1, Local2
   Private cCupom := NIL

   fDepur ("PDV_DEP.TXT", REPL ("�", 60))

   nMode:= 2

   Altd( 1 )

   SetCursor( 0 )
   SET DATE BRIT
   set scoreboard off
   SET DELETED ON
   clear screen
   Relatorio( "PDV.INI" )
   testvmodes()
   Local2:= {19, 257, 259, 261}
   Local1:= 1
   nMode:= 2
   SetBlink( .f. )

   setgmode(Local2[nMode])
   sethires(0)
   t_pie3d()
   Settext()
   RUN DEL *.$$$
   RUN MODE CO80
   __Quit ()

********************************
procedure TESTVMODES

   private amodes
   amodes:= {{19, "VGA       320x200 256 color"}, {257, ;
      "SVGA      640x480 256 color"}, {259, ;
      "SVGA      800x600 256 color"}, {261, ;
      "SVGA      1024x768 256 color"}}
   ? "Graphics Modes detected"
   ? "======================="
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
   return

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function T_PIE3D

   Local lFim := .F., lCupomPendente := .F.

   // Mensagem de cupom pendente - Inicio //
   IF File( _ARQUIVO )
      lCupomPendente := .T.
      !Del *.NTX
      VendaFile( _ABRIR )
   ENDIF
   // Mensagem de cupom pendente - Fim //

   setbkfill(0)
   boxfill(0, 0, 1350, 1000, 20, 0)
   i:= 1
   adirectory:= {}
   adirectory:= directory("*.BMP")
   boxfill(0, 0, 1350, 1000, 0, 0)
   IF File( _ARQUIVO )
      /* Arquivo ja existe 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
   ENDIF

   WHILE !LastKey()==K_ESC .AND. lFim == .F.
      IF !File( _ARQUIVO )
         VendaFile( _CRIAR )
      ENDIF
      VendaFile( _ABRIR )
      LoadCSet( 000, "VSYS14.PTX" )
      PicRead( 000, 000, 129, "FUNDO.BMP"    )
      PicRead( 782, 055, 001, "LOGOTIPO.BMP" )
      BoxFill( 5, 5, 1335, 30, 0, 03 )

      SayString(    2,  3, 4, 0, 15, "   [   ] Quant  [   ] Desc  [   ] Canc  [        ] Venda  [   ] Cliente  [   ] Pgto  [   ] Fecha")
//    Espacos a partir da cadeia -->      5            18          30          42                60             75          87

      SayString( 10 *  5 +   8,  4, 4, 0,  0, "F1" )
      SayString( 10 * 18 +  51,  4, 4, 0,  0, "F3" )
      SayString( 10 * 30 +  98,  4, 4, 0,  0, "F4" )
      SayString( 10 * 42 + 149,  4, 4, 0,  0, "ENTER" )
      SayString( 10 * 60 + 208,  4, 4, 0,  0, "F8" )
      SayString( 10 * 75 + 256,  4, 4, 0,  0, "F7" )
      SayString( 10 * 87 + 295,  4, 4, 0,  0, "F6" )

      SayString( 10 *  5 +   5,  3, 4, 0, 14, "F1" )
      SayString( 10 * 18 +  50,  3, 4, 0, 14, "F3" )
      SayString( 10 * 30 +  96,  3, 4, 0, 14, "F4" )
      SayString( 10 * 42 + 148,  3, 4, 0, 14, "ENTER" )
      SayString( 10 * 60 + 205,  3, 4, 0, 14, "F8" )
      SayString( 10 * 75 + 254,  3, 4, 0, 14, "F7" )
      SayString( 10 * 87 + 294,  3, 4, 0, 14, "F6" )

      Browse (@lFim, @lCupomPendente)

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
Function Browse(lFim, lCupomPendente)
  Local TECLA, nTotal:= 0, nHandProd, nHandDisp, cTelaRes, nSave,;
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
  Local cBusca:= "", lVerPreco := .F.
  Local lComEAN := .T., lInicio := .T., nSalLimCre:= 0, lLimCredAvis := .F.
  Local nTamEAN := 0, nCorEAN := 0, nRegAtuEAN := 0, ;
        nRegAtuCli := 0, lScanner := .F., cForma := ""

  IF MReset() > 0
     //mCurOff()
  ENDIF

  /* Ajusta a Cor Cinza Claro */
  SetRGBDac( 7,   192, 192, 192 )
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 15,  220, 220, 205 )
  SetRGBDac(  7,  192, 192, 192 )
  SetRGBDac( 73,  192, 192, 192 )

  /* CONFIGURACAO DE CORES - AZUL */
  SetRGBDac( 07,   0, 152, 248 )   /* Box */
  SetRGBDac( 73,   0, 152, 248 )   /* Complemento do Box - Imagem */
  SetRGBDac( 13,  18, 96, 200 )   /* Realse do Box */
  SetRGBDac( 15, 152, 200, 248 )  /* Fundo do Box */
  SetRGBDac( 88, 152, 200, 248 )  /* Fundo do Box - Imagem */

//  SetRGBDac( 0,  0, 152, 200 )    /* teste valmor */

  SetRGBDac( 177,  0, 48, 96 )    /* Sombra do Box */
  SetRGBDac( 08,   0, 48, 96 )    /* Sombras Diversas */
  SetRGBDac( 63,   0, 48, 96 )    /* Sombras - Imagem */

  SetRGBDac( 01,   48, 0, 152 )   /* Titulo */
  SetRGBDac( 03, 040, 192, 208 )  /* Barra Selecao */

  SetColor( "00/07, 07/08" )

   // Abertura do arquivo de Correspondencias de codigos EAN
   IF (PortaScanner <> "NAO")
      IF File( DiretorioDeDados-"\PDVEAN__.VPB" )
          DBSelectAr( _COD_PDVEAN )
          Use _VPB_PDVEAN Alias EAN Shared
          IF !File( DiretorioDeDados-"\EANIND01.IGD" ) .OR. !File( DiretorioDeDados-"\EANIND02.IGD" )
             Index On CODIGO Tag EANX1 ;
                     Eval {|| .T. } ;
                     To &DiretorioDeDados\EANIND01.IGD
             Index On CODEAN + CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                     STR (PCPCOR, 2) Tag EANX2 ;
                     Eval {|| .T. } ;
                     To &DiretorioDeDados\EANIND02.IGD
             Index On CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                     STR (PCPCOR, 2) Tag EANX3 ;
                     Eval {|| .T. } ;
                     To &DiretorioDeDados\EANIND03.IGD
          ENDIF
          Set Index To &DiretorioDeDados\EANIND01.IGD,;
                       &DiretorioDeDados\EANIND02.IGD,;
                       &DiretorioDeDados\EANIND03.IGD
      ELSE
          PortaScanner := "NAO"
          lComEAN := .F.
      ENDIF
   ENDIF

   // Abertura do arquivo de Cores
   IF (PortaScanner <> "NAO")
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
   ENDIF

   // Abertura do arquivo de CLASSES
   IF (PortaScanner <> "NAO")
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
   ENDIF

   // Abertura do arquivo de CLIENTES
   IF File( DiretorioDeDados-"\CLIENTES.VPB" )
       DBSelectAr( _COD_CLIENTE )
       Use _VPB_CLIENTE Alias CLI Shared
       IF !File( DiretorioDeDados-"\CLIIND01.IGD" )
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
                    &DiretoriodeDados\CLIIND03.IGD
   ENDIF

  IF File( DiretorioDeDados-"\CDMPRIMA.VPB" )
      DBSelectAr( _COD_MPRIMA )
      /* Abertura do arquivo de Materia-Prima - Produtos */
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
               {0, "   Inclua o arquivo CDMPRIMA.VPB no diretorio de dados do Fortuna"},;
               {0, " "},;
               {0, "   Acione qualquer tecla para encerrar o PDV"}, ;
               {0, " "}}, 7, 4)
      Settext()
      __QUIT ()
  ENDIF

  /* Verifica se tabela de Preco � Diferente da padr�o */
  IF TabelaDePreco > 0

  ENDIF
  nHandProd:= SnapCopy( 20, 900, 1300, 980, 0 )
  nHandDisp:= SnapCopy( 400, 500, 740, 880, 0 )
  nHandInfo:= SnapCopy( 220,  75, 740, 250, 0 )

  PicWrite( 0, 0, 740, 900, 1, "LEFT.BMP" )
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
            DispCupom( " ", 0)
        NEXT
     ENDIF
     DBGoTop()
     WHILE !EOF()
        IF STATUS==" "
           nTotal:= nTotal + PRECOT
           DispCupom( DESCRI, 4 )
        ELSEIF STATUS=="E"
           nTotal:= nTotal - PRECOT
           DispCupom( DESCRI, 5 )
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
         cBusca:= ""
         BoxFill( 35, 446, 700, 4, 0, 7 )
         oTab:RefreshAll()
         WHILE !oTab:Stabilize()
         ENDDO
      ELSEIF !UPPER( Chr( LastKey() ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW& - 0123456789+* /"
         cBusca:= ""
      ELSE
         SnapPaste( 220,  75, nHandInfo )
         SayString( 250, 125, 4, 0, 1, PAD( Alltrim( STR( MPR->( INDEXORD() ) ) ), 20 ) )
         SayString( 250, 100, 4, 0, 1, PAD( cBusca, 30 ) )
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

         //BoxFill( 25, 910, 1298,  72, 128, 3 )
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
         SayString( 250, 100, 4, 0, 1, PAD( cBusca, 30 ) )
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

      // Mensagem de EAN Inexistente - Inicio //
      IF (lComEan == .F.)
         lComEan := .T.
         WHILE (.T.)
             SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
                     {{0, " "},;
                      {0, "   O arquivo de Correspondencias EAN nao consta no diretorio !"},;
                      {0, " "},;
                      {0, "   O PDV vai trabalhar sem considerar o codigo EAN !"},;
                      {0, " "},;
                      {0, "   Para continuar a rotina normal, acione qualquer tecla"}, ;
                      {0, " "}}, 7, 4)
            IF (LASTKEY () <> K_ESC)
               EXIT
            ENDIF
         END
      ENDIF
      // Mensagem de EAN Inexistente - Fim //

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
                        {0, "   Para confirmar, acione a tecla [ENTER]"},;
                        {0, " "},;
                        {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                        {0, " "}}, 7, 4)
               IF (LASTKEY () == K_ENTER)
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
         CASE nTecla==K_UP         ;oTAB:up()
         CASE nTecla==K_DOWN       ;oTAB:down()
         CASE nTecla==K_LEFT
         CASE nTecla==K_RIGHT
         CASE nTecla==K_PGUP       ;oTAB:pageup()
         CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop()
         CASE nTecla==K_PGDN       ;oTAB:pagedown()
         CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom()
         CASE nTecla==K_CTRL_F7
              cCupom := IIF (cCupom == NIL .OR. cCupom == "", ImpCupomAtual(), "")
              DispCupom( "Cupom Fiscal No. " + cCupom , 0 )
         CASE nTecla==K_ENTER // #01

               IF nStatus==1 .OR. nStatus==2 .OR. nStatus==8 .OR. nStatus==9
                  IF nStatus == 1
                     FOR nCt:= 1 TO 10
                         DispCupom( " ", 0)
                     NEXT
                  ENDIF

                  LoadcSet( 0, "VSYS14.PTX" )

                  IF (fVerLimCred (@lLimCredAvis, @nCliCodigo, @nTotal, ;
                                   @nSalLimCre) == .F.)
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
                     lScanner := .F.
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
                     lScanner := .F.
                     LOOP
                  ENDIF

                  IF (cVerifSaldoEst == "SIM")
                     IF (fVerSalEst (@nQuantidade, @nTamEAN, @nCorEAN, ;
                         @nRegAtuEAN) == .F.)
                        lScanner := .F.
                        LOOP
                     ENDIF
                  ENDIF

                  lScanner := .F.

                  /* Se Estiver habilitado o F12 ou se PrecoVenda==0 */
                  IF nStatus==8 .OR. MPR->PRECOV <= 0

                     nPreco:= MPR->PRECOV
                     cCorRes:= SetColor( "08/15,14/01" )

                     nSaveF2:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F2__.$$$" )
                     loadcSet( 0, "VSYS14.PTX" )
                     SWGBox( 220, 490, 670, 720, "Preco do Item" , 15 )
                     swboxfill( 400, 590, 210, 40, 20 + 32, 0 )
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
                        LOOP
                     ENDIF
                  ELSE
                     nPreco:= MPR->PRECOV
                  ENDIF

                  cTabela:= STPadrao

                  IF MPR->TABRED == "  "
                     IF MPR->IPICOD == 4                             /* ISENTO */
                        cTabela:= STIsento
                     ELSEIF MPR->IPICOD == 1 .OR. MPR->IPICOD == 3   /* SUBSTITUICAO TRIBUTARIA */
                        cTabela:= STSubstituicao
                     ELSE                                            /* PADRAO */
                        cTabela:= STPadrao
                     ENDIF
                  ENDIF
                  IF nStatus == 1
                     IF lPrinter
                        ImpAbreCupom()
                     ENDIF
                     NumeroCupom( "000000" )
                     DispCupom( "VENDA INICIADA AS " + TIME() + "Hs.", 0 )
                     cCupom := IIF (cCupom == NIL .OR. cCupom == "", ImpCupomAtual(), "")
                     DispCupom( "Cupom Fiscal No. " + cCupom , 0 )
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
                  IF lRetorno .OR. Impressora=="Nenhuma"
                     VendaFile( _VENDA_ITEM, nPrecoFinal, nQuantidade, ;
                                cTabela, @nTamEAN, @nCorEAN )
                     lCancelaItem:= .F.
                     nDescPercentual:= 0
                     nDescValor:= 0
                     DispCupom( MPR->DESCRI, 4 )
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
               nQuantidade:= 1
               lSubTotal:= .T.
               IF !nStatus==10
                  nStatus:= 2
               ENDIF
               LoadcSet( 0, cFontBrowse )

         CASE nTecla==K_F4
              IF nStatus == 2 .OR. nStatus == 4
                 lCancelaItem:= IF( lCancelaItem, .F., .T. )
                 nStatus:= IF( lCancelaItem, 4, 2 )
                 lSubTotal:= .T.
              ENDIF

         CASE nTecla==K_F12
              IF nStatus == 2 .OR. nStatus == 1 .OR. nStatus == 8
                 IF !( nStatus==8 )
                    nStatusAnt:= nStatus
                 ENDIF
                 nStatus:= IF( nStatus==8, nStatusAnt, 8 )
                 lSubTotal:= .T.
              ENDIF

         CASE nTecla==K_F8 .AND. nStatus==2
              //mCurOff()
              nSaveF8:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F8__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )
              SWGBox( 220, 220, 1250, 800, "Cadastro de Clientes", 15 )

              swboxfill( 415, 680, 770, 40, 20 + 32, 0 )
              swboxfill( 415, 622, 620, 40, 20 + 32, 0 )
              swboxfill( 415, 562, 450, 40, 20 + 32, 0 )
              swboxfill( 415, 505, 520, 40, 20 + 32, 0 )
              swboxfill( 415, 445, 050, 40, 20 + 32, 0 )
              swboxfill( 415, 387, 150, 40, 20 + 32, 0 )
              swboxfill( 415, 327, 315, 40, 20 + 32, 0 )

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
                 nSalLimCre := CLI -> SALDO_ - nTotal
                 DispCupom( "Cliente ATIVADO !", 2 )
                 nRegAtuCli := CLI -> (RECNO ())
              ELSEIF !( LastKey()==K_ESC )
                 SWGAviso( "ARQUIVO DE MATERIAS PRIMAS",;
                           {{0, " "},;
                            {0, "   O Cliente Digitado nao consta no cadastro!"},;
                            {0, "   TAB - Incluir No Cadastro de Clientes" },;
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
                 ELSE
                    nCliCodigo:= 0
                    nRegAtuCli := 0
                 ENDIF
              ENDIF

         CASE nTecla==K_F11

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
              IF lPrinter
                 impSubTotCupom()
              ENDIF

         CASE (nTecla == K_F10 .OR. nTecla == K_CTRL_F10) .AND. nStatus==2

              SWGAviso( "ANULACAO DO CUPOM FISCAL",;
                      {{0, " "},;
                       {0, "   O Cupom Fiscal sera ANULADO !"},;
                       {0, " "},;
                       {0, "   Para confirmar, acione as teclas [Ctrl+F10]"},;
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
                 EXIT
              ENDIF

         CASE nTecla == K_CTRL_F12 .AND. nStatus==2

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
              nPreco:= MPR->PRECOV
              nSaveF3:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F3__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )

              SWGBox( 220, 475, 660, 740, "Desconto Percentual/Valor" , 15 )
              swboxfill( 460, 620, 170, 40, 20 + 32, 0 )
              swboxfill( 460, 560, 170, 40, 20 + 32, 0 )

              cCorRes:= SetColor( "08/15,01/15" )
              nDescPercentual:= 0
              nDescValor:= 0
              @ 12,15 Say "Desconto(%)"
              @ 14,15 Say "Valor      "

              Mensagem()
              @ 12,28 Get nDescPercentual Pict "   99.99%" ;
                When Mensagem( "Digite o % de desconto" )
              @ 14,28 Get nDescValor      Pict "@E 9,999.99" ;
                When Mensagem( "Digite o Valor do desconto" )

              SetCursor( 1 )
              READ
              SetCursor( 0 )

              SetColor( cCorRes )
              SWSnapPaste( 50, 100, nSaveF3 )
              SWSnapKill( nSaveF3 )
              nStatus:= 9
              lSubTotal:= .T.

         CASE nTecla == K_F1
              nSaveF1:= SWSnapCopy( 50, 100, 1280, 950, 0, "PDV_F1__.$$$" )
              loadcSet( 0, "VSYS14.PTX" )

              SWGBox( 221, 489, 671, 720, "Quantidade" , 15 )
              swboxfill( 450, 590, 190, 40, 20 + 32, 0 )
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

              swboxfill( 605, 680,  50, 40, 20 + 32, 0 )
              swboxfill( 605, 622, 145, 40, 20 + 32, 0 )
              swboxfill( 605, 562, 350, 40, 20 + 32, 0 )
              swboxfill( 605, 505, 350, 40, 20 + 32, 0 )
              swboxfill( 605, 445, 100, 40, 20 + 32, 0 )

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
              swboxfill( 740, 590,  70, 40, 20 + 32, 0 )

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
                  swboxfill( 510, 707, 142, 40, 20 + 32, 0 )
                  swboxfill( 510, 649, 210, 40, 20 + 32, 0 )
                  swboxfill( 510, 591,  80, 40, 20 + 32, 0 )
                  swboxfill( 510, 533, 160, 40, 20 + 32, 0 )
                  swboxfill( 510, 475, 160, 40, 20 + 32, 0 )
                  swboxfill( 510, 417,  80, 40, 20 + 32, 0 )
                  swboxfill( 510, 357, 280, 40, 20 + 32, 0 )
                  swboxfill( 510, 297,  80, 40, 20 + 32, 0 )
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

              nValorPago:= 0
              nValorPagar:= 0
              nVezes:= 0
              cAcrDes:= "D"

              loadcSet( 0, "VSYS14.PTX" )
              nSaveF6:= SWSnapCopy( 50, 100, 1320, 950, 0, "PDV_F6__.$$$" )

              IF Len( aParcelas ) > 0
                 AcrDes( cAcrDes, nPerAcrDes, @nVlrAcrDes, @nValorPagar, nTotal )
              ELSEIF Len( aParcelas ) <= 0

                 WHILE (.T.)

                    SWGBox( 220, 289,  950, 800, "Fechamento da Venda", 15 )

                    swboxfill( 555, 680,  65, 40, 20 + 32, 0 )
                    swboxfill( 555, 622, 145, 40, 20 + 32, 0 )
                    swboxfill( 555, 562, 365, 40, 20 + 32, 0 )
                    swboxfill( 555, 505, 365, 40, 20 + 32, 0 )
                    swboxfill( 555, 445, 365, 40, 20 + 32, 0 )
                    swboxfill( 555, 385, 115, 40, 20 + 32, 0 )

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
                            When Pula() .AND. Mensagem( "Digite o Valor a Pagar" )
                    @ 18,33 Get nValorPago ;
                            Pict "@R    99,999,999,999.99" ;
                            When Mensagem( "Digite o Valor Pago" ) ;
                            Valid ( nValorPago >= nValorPagar ) .OR. ;
                            LastKey() == K_UP
                    @ 20,33 Get nVendedor ;
                            Pict "@R   999" ;
                            When Mensagem( "Digite o Codigo do Vendedor" ) ;
                            Valid BuscaVendedor( @nVendedor )

                    SetCursor( 1 )
                    READ
                    SetCursor( 0 )

                    IF (cVerifValorPago == "SIM")
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

              IF !LastKey() == K_ESC

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
                    SWGAviso( "CONDICOES DE PAGAMENTO", aAviso, 7, 3 )
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
                 ENDIF
                 IF nPerAcrDes > 0 .AND. nVlrAcrDes==0
                    nVlrAcrDes:= ROUND( ( nTotal * nPerAcrDes ) / 100, 2 )
                    nPerAcrDes:= 0
                 ENDIF

                 IF lPrinter
                     IF (Impressora == "BEMATECH-MP20FI-II")
                        ImpFechaCom (cAcrDes, nPerAcrDes, nVlrAcrDes, ;
                                     nValorPago, cForma, cMensagem)
                     ELSE
                        ImpFechaSem(cAcrDes, nPerAcrDes, nVlrAcrDes, nTotal, nValorPago, cMensagem, "CGCCPF" )
                     ENDIF
                 ENDIF

                 LancaEstoque(@nRegAtuCli, @nRegAtuEAN)

                 LancaCupom( nCliCodigo, cCliDescri, cCliEndere, cCliBairro, ;
                             cCliCidade, cCliEstado, nValorPagar, nVendedor)

                 IF lPrinter
                    ImpAbreGaveta()
                 ENDIF

                 IF (Len( aParcelas ) == 0)

                    nTroco := nValorPago - nValorPagar

                    WHILE (.T.)

                       IF (nTroco == 0)

                          SWGAviso( "FIM DO CUPOM FISCAL",;
                                  {{0, " "},;
                                   {0, "   O Cupom Fiscal foi finalizado !"},;
                                   {0, " "},;
                                   {0, "   Para anular o Cupom, acione as teclas [Ctrl+F10]"},;
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
                                   {0, "   Para anular o Cupom, acione as teclas [Ctrl+F10]"},;
                                   {0, " "},;
                                   {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                                   {0, " "}}, 7, 3, 300, 200, 800, 1220)

                       ENDIF

                        IF (LASTKEY () <> K_ESC)
                           KeyBoard (CHR (LASTKEY ()))
                           EXIT
                        ENDIF
                    END

                 ENDIF

                  IF (LASTKEY () == K_ENTER)
                     CLEAR TYPEAHEAD
                  ENDIF

                 IF LastKey() == K_F10 .OR. LastKey() == K_CTRL_F10
                    AnulaCupom( impCupomAtual() )
                    IF lPrinter
                       ImpCancCupom()
                    ENDIF
                    LancaEstoque(@nRegAtuCli, @nRegAtuEAN)
                    VendaFile( _EXCLUIR )
                    VendaFile( _CRIAR )
                    VendaFile( _ABRIR )
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
                    LancaReceber( aParcelas, nCliCodigo, cCliDescri )
                    LancaEmCaixa( nValorPagar )
                    VendaFile( _EXCLUIR )
                    VendaFile( _CRIAR )
                    VendaFile( _ABRIR )
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
              Autentica( 0 )

         CASE nTecla == K_CTRL_F5 // Era K_F10
              IF lPrinter
                 ImpAbreGaveta()
              ENDIF

         CASE UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVWXY&Z012345667890 -+*/"
              loadcSet( 0, "VSYS14.PTX" )
              cBusca:= cBusca + CHR( nTecla )
              IF Len( ALLTRIM( cBusca ) ) <= 1
                 IF Alltrim( cBusca ) $ "01234567890"
                    IF (PortaScanner == "NAO")
                       MPR->( DBSetOrder( 4 ) ) // upper( CodFab )
                       lDigitos := .F.
                    ELSE
                       MPR->( DBSetOrder( 2 ) ) // upper( Descri )
                       lDigitos := .T.
                    ENDIF
                 ELSE
                    MPR->( DBSetOrder( 2 ) ) // upper( Descri )
                    lDigitos := .F.
                 ENDIF
              ENDIF
              IF (PortaScanner == "NAO" .OR. lDigitos == .F.)
                 nReg:= RECNO()
                 DBSeek( UPPER( cBusca ), .F. )
                 IF EOF()
                    DBGoTo( nReg )
                 ENDIF
              ELSE
                 IF (CHR (nTecla) $ "ABCDEFGHIJKLMNOPQRSTUVWXY&Z -+*/" == .T.)
                    lDigitos := .F.
                 ENDIF
                 IF (LEN (cBusca) == 13 .AND. lDigitos == .T.)
                    fCodigoEAN (@cBusca, @lScanner, @nRegAtuEAN)
                 ENDIF
                 MPR->( DBSetOrder( 2 ) ) // upper( Descri )
              ENDIF
              oTab:RefreshAll()
              WHILE !oTab:Stabilize()
              ENDDO

         CASE nTecla == K_CTRL_F1 // Verificacao de Preco
              IF (nStatus == 10)
                 nStatus:= nStatusAnt
              ELSE
                 nStatusAnt:= nStatus
                 nStatus:= 10
              ENDIF

         CASE nTecla == K_CTRL_A // Auxilio
              fAuxilio ()

         OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      loadcSet( 0, cFontBrowse )
      oTAB:refreshcurrent()
      oTAB:stabilize()
   ENDDO
   //mCurOff()

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fCodigoEAN (cBusca, lScanner, nRegAtuEAN)

      Local lCodEANInt := .F., lTemEAN := .F.

      IF (ScannerTemEnter == "SIM")
         INKEY (0)
      ENDIF

      EAN -> (DBSetOrder (1)) // CODIGO (Codigo EAN Interno)

      IF (EAN -> (DBSeek (cBusca)) = .F.)
         EAN -> (DBSetOrder (2)) // CODEAN (Codigo EAN Fabrica)
         IF (EAN -> (DBSeek (cBusca)) = .F.)
            SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
                    {{0, " "},;
                     {0, "   O codigo EAN Interno e/ou Fabrica nao consta no arquivo !"},;
                     {0, " "},;
                     {0, "   Inclua-os a partir do arquivo de Materias Primas do Fortuna"},;
                     {0, " "},;
                     {0, "   Para continuar a rotina normal, acione qualquer tecla"}, ;
                     {0, " "}}, 7, 4)
         ELSE
            lTemEAN := .T.
            lCodEANInt := .F. // Nao tem Codigo EAN Interno
         ENDIF
      ELSE
         lTemEAN := .T.
         lCodEANInt := .T. // Tem Codigo EAN Interno
      ENDIF

      cBusca:= ""

      IF (lTemEAN == .T.)
         nReg:= RECNO()
         MPR -> (DBSetOrder (1)) // CODIGO
         IF (MPR -> (DBSeek (EAN -> CODPRO)) = .F.)
             SWGAviso( "ACESSO POR CODIGO DE BARRAS EAN",;
                     {{0, " "},;
                      {0, "   O codigo do ITEM nao consta no arquivo de Materias Primas !"},;
                      {0, " "},;
                      {0, "   Verifique o arquivo de Materias Primas do Fortuna"},;
                      {0, " "},;
                      {0, "   Para continuar a rotina normal, acione qualquer tecla"},;
                      {0, " "}}, 7, 4)
             MPR -> (DBGoTo (nReg))
         ELSE
             // Ax� u 죜ein !
             KEYBOARD (CHR (K_ENTER))
         ENDIF
         lScanner := .T.
      ELSE
         lScanner := .F.
      ENDIF

   Return (.T.)

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

      SetColor( "08/15,00/03" ) // CURSOR CIANO    (VERDE CLARO)
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

      SetColor( "08/15,00/03" ) // CURSOR CIANO    (VERDE CLARO)
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

   Function fVerLimCred (lLimCredAvis, nCliCodigo, nTotal, nSalLimCre)

      Local cTamAnt:= SetColor( ), nCursor:= SetCursor( ), nArea:= Select(), ;
            nOrdem:= IndexOrd( )
      Local lRet := .T.

      CLI -> (DBSetOrder (1)) // CODIGO
      IF (CLI -> (DBSeek (nCliCodigo)) = .T.)
         IF (EMPTY (nCliCodigo) == .F. .AND. CLI -> LIMCR_ > 0 .AND. ;
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

      IF (EAN -> (DBSeek (MPR -> INDICE + STR (MPR -> PCPCLA) + ;
                          STR (nTamEAN) + STR (nCorEAN))) == .T.)
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

   Function DispCupom( cProduto, nCor )

      _VScroll( 780, 500, 1340, 840, 35, 15 )
       loadcSet( 0, "AGSYSA14.PTX" )
       SayString( 780, 500, 4, 0, nCor, cProduto )

   Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
   BoxFill( nCol1+10, nLin1+10      , nCol2-nCol1-24, 0, 64, 8 )                 // INTERNO INFERIOR

   FOR nCt:= 1 TO 2
       DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, nCor+8 )   /* SUPERIOR */
       DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, nCor+8 )   /* ESQUERDA */
       DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
       DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
   NEXT

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
                 PCPCOR With nCorEAN
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
              { "PCPCOR", "N", 02, 00 }}
      DBCreate( _ARQUIVO, aStr )
   ELSEIF xPar1 == _ABRIR
      DBSelectAr( _VENDAFILE )
      IF !Used()
         Use _ARQUIVO Alias VDA Exclusive
         Index On INDICE To VENDA1
         Index On CODLAN To VENDA2
         Set Index To VENDA1, VENDA2
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
   ENDIF
   DBSelectAr( nArea )
   Return xRetornar

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function NumeroCupom( cNumero )
Static cCupom
IF cNumero==Nil
   Return IF( cCupom == Nil .OR. cCupom == "", "NAO INFORMADO", cCupom )
ELSEIF cNumero=="<Buscar>"
   IF ( cCupom:= ImpCupomAtual() )== Nil
      Return ""
   ELSE
      Return cCupom
   ENDIF
ENDIF
Return ""

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

  SetColor( "08/15,01/15,00/03,00/07" ) // CURSOR CIANO    (VERDE CLARO)
  //mCurOff()
  SetCursor( 0 )
  DBSelectAr( _COD_CLIENTE )
  /*
  IF !Used()
     Use _VPB_CLIENTE Alias CLI Shared
     Set Index To &DiretoriodeDados\CLIIND01.IGD,;
                  &DiretoriodeDados\CLIIND02.IGD,;
                  &DiretoriodeDados\CLIIND03.IGD
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
                    DBSeek( cBusca, .T. )
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
   SetColor( "08/15,01/15,00/03,00/07" ) // CURSOR CIANO    (VERDE CLARO)
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
                  DBSeek( cBusca, .T. )
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
      IF MPR->( DBSeek( VDA->INDICE ) )
         CPA->( DBAppend() )
         CPA->( RLock() )
         IF !CPA->( NetErr() )
            Replace CPA->CODIGO With VDA->INDICE,;
                    CPA->CODRED With VDA->INDICE,;
                    CPA->CODIGO With VDA->INDICE,;
                    CPA->DESCRI With VDA->DESCRI,;
                    CPA->MPRIMA With MPR->MPRIMA,;
                    CPA->UNIDAD With VDA->UNIDAD,;
                    CPA->QUANT_ With VDA->QUANT_,;
                    CPA->PRECOV With VDA->PRECOV,;
                    CPA->PRECOT With VDA->PRECOT,;
                    CPA->CODNF_ With Val( NumeroCupom() )
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
  Set Index To &DiretoriodeDados\CX_IND01.IGD
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
  Set Index To &DiretoriodeDados\ESTIND01.IGD,;
               &DiretoriodeDados\ESTIND02.IGD,;
               &DiretoriodeDados\ESTIND03.IGD,;
               &DiretoriodeDados\ESTIND04.IGD

  MPR->( DBSetOrder( 1 ) )
  DBSelectAr( _VENDAFILE )
  DBGoTop()
  WHILE !EOF()
      IF STATUS==" " .OR. STATUS=="E"
         IF MPR->( DBSeek( VDA->INDICE ) )
            MPR->( RLock() )
            IF !MPR->( NetErr() )
                Replace MPR->SALDO_ With MPR->SALDO_ - VDA->QUANT_
            ENDIF
            MPR->( DBUnlock() )
         ENDIF
         EST->( DBAppend() )
         IF !EST->( NetErr() )
            Replace EST->CPROD_ With VDA->INDICE,;
                    EST->CODRED With VDA->INDICE,;
                    EST->ENTSAI With IF( VDA->STATUS==" ","+","-" ),;
                    EST->QUANT_ With VDA->QUANT_,;
                    EST->DOC___ With "CF: " + NumeroCupom() + IF( VDA->STATUS==" "," ","C" ),;
                    EST->CODIGO With 0,;
                    EST->VLRSDO With 0,;
                    EST->VALOR_ With VDA->PRECOT,;
                    EST->DATAMV With Date(),;
                    EST->RESPON With 0
         ENDIF
      ENDIF
//AQUI
// *** SALDO NO PDVEAN
      EAN -> (DBSetOrder (3)) // CODPRO ...

      IF (EAN -> (DBSeek (VDA -> INDICE + STR (VDA -> PCPCLA) + ;
                          STR (VDA -> PCPTAM) + STR (VDA -> PCPCOR))) == .T.)
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

   Function fDepur (cArq, cTex)

      IF (FILE (cArq) == .T.)
         cTmp := MEMOREAD (cArq)
      ELSE
//       cTmp := REPL ("�", 80) + CHR (13) + CHR (10)
         cTmp := ""
      ENDIF

      MEMOWRIT (cArq, cTmp + DTOC (DATE ()) + " " + TIME () + " : " + ;
                cTex + CHR (13) + CHR (10))

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

   Function fAuxilio ()

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
               {0, "   Limpeza do Buffer do Cupom  . . . . . . . . . . . . . . . . . . [CTRL+F12]"},;
               {0, "   Autenticacao  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  [F9]"},;
               {0, "   Abertura de Gaveta  . . . . . . . . . . . . . . . . . . . . . . . [CTRL+F5]"},;
               {0, "   Numero do Cupom Atual . . . . . . . . . . . . . . . . . . . . .  [CTRL+F7]"},;
               {0, "   SubTotal no Video . . . . . . . . . . . . . . . . . . . . . . . . . [CTRL+F2]"},;
               {0, "   SubTotal na Impressora  . . . . . . . . . . . . . . . . . . . . . . . . [F5]"},;
               {0, " "}}, 7, 1, 300, 200, 800, 1220)

      IF (LASTKEY () == K_ESC)
         RETURN (.T.)
      ENDIF

      SWGAviso( "AUXILIO                                                              3 de 3",;
              {{0, "   Consulta Itens . . . . . . . . . . . . . . . . . . . . . . . . . . . . [CTRL+F1]"},;
               {0, "   Confirmacao de Preco . . . . . . . . . . . . . . . . . . . . . . . . . . [F12]"},;
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
// fDepur ("PDV_DEP.TXT", "OK 100000 = "
   FOR nCt:= 1 TO Len( aParcelas )
       fDepur ("PDV_DEP.TXT", "OK 100000 = " + STRZERO (MPR->SALDO_, 15, 5))
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

Function SWSnapCopy( nX0, nY0, nX1, nY1, nModo, cFile )
cFile:= IF( cFile==Nil, "RESERVA.BMP", cFile )
PicWrite( nX0, nY0, nX1, nY1, 1, cFile )
Return cFile

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function SWSnapPaste( nX0, nY0, cImagem )
PicRead( nX0, nY0, 1, cImagem )
Return .T.

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Function SWSnapKill()
Return Nil
/*
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/







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
Function SBrowse()
  Local TECLA, nTotal:= 0, nHandProd, nHandDisp, cTelaRes, nSave,;
        lSubTotal:= .F., nUltReg:= -1
  Local cObserv1:= Space( 60 ), cObserv2:= Space( 60 )
  Local lCancelaItem:= .F., nDescPercentual:= 0, nDescValor:= 0, nQuantidade:= 1
  Local cFontBrowse:= "VSYS14.PTX"
  Local lProtecao:= .F.
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
  Local cBusca:= "", lVerPreco := .F.
  Local lCupomPendente := .F., lComEAN := .T., lInicio := .T., lLimCredAvis := .F.
  Local nSalLimCre:= 0

  IF MReset() > 0
     MCurOff()
  ENDIF

   // Abertura do arquivo de CLIENTES
   IF File( DiretorioDeDados-"\CLIENTES.VPB" )
       DBSelectAr( _COD_CLIENTE )
       Use _VPB_CLIENTE Alias CLI Shared
       IF !File( DiretorioDeDados-"\CLIIND01.IGD" )
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
                    &DiretoriodeDados\CLIIND03.IGD
   ENDIF

  /* Ajusta a Cor Cinza Claro */
  SetRGBDac( 7,   192, 192, 192 )
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 15,  220, 220, 205 )
  SetRGBDac(  7,  192, 192, 192 )
  SetRGBDac( 73,  192, 192, 192 )

  SetColor( "00/07, 07/08" )

  /* NOVO */
  aBotoes:= { { 100, 050, " Novo      " },;
              { 100, 250, " Pesquisar " },;
              { 100, 450, " Empresa   " } }

  lEmpresa:= .F.
  MSetWin( 10, 10, 1340, 990 )
  MCurOn()
  loadcSet( 0, "vsys14.PTX" )
  SWGBox( 0, 0, 1350, 1000, "FORTUNA - Controle de Eventos" , 15 )

  PicRead( 13, 68, 1, "PAPEL.BMP" )

  /* Ajusta a Cor Cinza Claro */
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 15,  220, 220, 205 )
  SetRGBDac(  7,  192, 192, 192 )
  SetRGBDac( 73,  192, 192, 192 )



  /* CONFIGURACAO DE CORES - VERMELHO */
  SetRGBDac( 7,   168, 0,   0 )    /* Box */
  SetRGBDac( 13,  228, 44,  24 )   /* Realse do Box */
  SetRGBDac( 15,  255, 126, 112 )  /* Fundo do Box */
  SetRGBDac( 73,  192, 192, 192 )
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 177, 143, 28,  16 )    /* Sombra do Box */
  SetRGBDac( 08,  143, 28,  16 )    /* Sombras Diversas */
  SetRGBDac( 01,  143, 28,  16 )    /* Titulo */

  /* CONFIGURACAO DE CORES - VERDE */
  SetRGBDac( 7,   0, 116,   52 )   /* Box */
  SetRGBDac( 13,  40, 196,  116 )   /* Realse do Box */
  SetRGBDac( 15,  152, 200, 152 )  /* Fundo do Box */
  SetRGBDac( 73,  192, 192, 192 )
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 177, 0, 96, 96 )    /* Sombra do Box */
  SetRGBDac( 08,  0, 96, 96 )    /* Sombras Diversas */
  SetRGBDac( 01,  48, 96, 96 )    /* Titulo */

  /* CONFIGURACAO DE CORES - CIAN */
  SetRGBDac( 7,   0, 152,   248 )     /* Box */
  SetRGBDac( 13,  48, 248,  248 )     /* Realse do Box */
  SetRGBDac( 15,  0, 200,  200 )      /* Fundo do Box */
  SetRGBDac( 73,  192, 192, 192 )
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 177, 20,  80, 152 )      /* Sombra do Box */
  SetRGBDac( 08,  20,  80, 152 )      /* Sombras Diversas */
  SetRGBDac( 01,  48, 96, 248 )       /* Titulo */

  /* CONFIGURACAO DE CORES - AZUL */
  SetRGBDac( 7,   4, 80, 140 )    /* Box */
  SetRGBDac( 13,  18, 96, 200 )   /* Realse do Box */
  SetRGBDac( 15,  96, 152, 200 )  /* Fundo do Box */
  SetRGBDac( 73,  192, 192, 192 )
  SetRGBDac( 88,  220, 220, 205 )
  SetRGBDac( 177,  0, 48, 96 )    /* Sombra do Box */
  SetRGBDac( 08,   0, 48, 96 )    /* Sombras Diversas */
  SetRGBDac( 01,   48, 0, 152 )    /* Titulo */

  SetRGBDac( 03, 040, 192, 208 )   /* Barra Selecao */

  SWGBoxSimples( 15, 850, 1320, 02 )

  aIcones:= { "CHAVE.ICO",;
              "MAPIF1L.ICO",;
              "ALPHABET.ICO",;
              "MAPIF5L.ICO",;
              "MODEM18.ICO",;
              "CPRMPT02.ICO",;
              "CA_LOGO.ICO",;
              "MAPIF2L.ICO",;
              "LIGHT1.ICO",;
              "EXIT02.ICO" }

  FOR nCt:= 1 TO Len( aIcones )
      LoadIcon( aIcones[ nCt ] )
      DrawIcon( 100 * nCt, 900, 256,   0, 8 )
      SWMSetHot( 10+nCt, ( 100*nCt )-32, 860, 80, 80 )
  NEXT

  loadcSet( 0, "AGSYSE20.PTX" )

  loadcSet( 0, "VSYS14.PTX" )
//  ShowBotoes( aBotoes )

  /* Inibicao da Exibicao dos Botoes na Tela */
  aBotoes:= 0
  aBotoes:= {}

  nTelaRes:= SWSnapCopy( 630, 0, 1340, 990, "XYSAVED.BMP" )



  //SWSnapPaste( 630, 0, nTelaRes )

  nInicio:= SECONDS()
  nOpcao:=  0
  lProtecao:= .F.
  cFundoSaved:= SWSnapCopy( 0, 0, 1350, 1000, 0, "SAVE_FN.BMP" )
  WHILE .T.
     IF MMotion() <= 0
        IF !( nOpcao == 0 )
           nInicio:= SECONDS()
        ENDIF
        IF SECONDS() - nInicio > 60 * 3  /*( No.DeSegundos * Qtd.Minutos )*/
           lProtecao:= .T.
           Magnifico()
        ENDIF
     ELSE
        IF lProtecao
           SWSnapPaste( 0, 0, cFundoSaved )
           lProtecao:= .F.
        ENDIF
        nInicio:= SECONDS()
     ENDIF
     nOpcao:= TesteBotoes( aBotoes, aIcones )
     DO CASE
        CASE nOpcao==-10
             SetText()
             SetColor( "15/00" )
             Cls
             Quit
        CASE nOpcao==-2
             GetVisitante()
        CASE nOpcao==-1
             Pesquisa( lEmpresa )
        CASE nOpcao==3
             SWSnapPaste( 630, 0, nTelaRes )
             IF lEmpresa
                lEmpresa:= .F.
             ELSE
                lEmpresa:= .T.
                SWGBoxInfo( 670, 75, 1325, 840, "INFORMACOES DA EMPRESA", 15 )
             ENDIF
     ENDCASE
  ENDDO
  MCurOff()
Return (.T.)

// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

/*------------------------------------------------------*/
Function SWGBox( nCol1, nLin1, nCol2, nLin2, cTitulo, nCor, nTipo )
 Local nCt
 SetBkFill( nCor )
 SetRGBDAC( 62, 51, 153, 255 )
 IF nTipo==Nil
    nTipo:= 2
 ENDIF
 IF nTipo==1
    BoxFill( nCol1+6, nLin1-8, (nCol2-nCol1), (nLin2-nLin1), 3+32,  8)  //  1
    BoxFill( nCol1+4, nLin1-7, (nCol2-nCol1), (nLin2-nLin1), 3+32, 13)  //  2
    BoxFill( nCol1+2, nLin1-5, (nCol2-nCol1), (nLin2-nLin1), 3+32,  8)  //  3
    BoxFill( nCol1+1, nLin1-3, (nCol2-nCol1), (nLin2-nLin1), 3+32, 13)  //  4
    BoxFill( nCol1+1, nLin1-1, (nCol2-nCol1), (nLin2-nLin1), 3+32,  8)  // 15
    BoxFill( nCol1+1, nLin1,   (nCol2-nCol1), (nLin2-nLin1), 5+32, 13)  //  9
    BoxFill( nCol1+1, nLin1,   (nCol2-nCol1), (nLin2-nLin1), 6+32,  8)  //  9
    BoxFill( nCol1, nLin1, nCol2-nCol1, nLin2-nLin1, 64, nCor )
 ELSEIF nTipo==2

    BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 7 )

    FOR nCt:= 1 TO 2
        DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 13 )       /* SUPERIOR */
        DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 13 )       /* ESQUERDA */
        DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
        DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
    NEXT

    BoxFill( nCol1+10, nLin2-43, (nCol2-nCol1)-20, 35, 128, 1 ) // TITULO

    nCol1+=7
    nLin1+=57

    /* Box mensagem */
    BoxFill(  nCol1+5,  nLin1-50, (nCol2-nCol1)-20, 40, 64,   8 )
    DrawLine( nCol1+5,  nLin1-50, nCol2-15, nLin1-50, 0, 0,  13 )
    DrawLine( nCol2-15, nLin1-50, nCol2-15, nLin1-10, 0, 0,  13 )

    UltimaTela( nCol1, nLin1-50 )
    nCol2-=7
    nLin2-=50

    /* Fundo da Tela */
    IF !( nCor==Nil )
       BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 15 ) /* NCOR */
    ELSE
       BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 15 )
    ENDIF

    /* Profundidade Interna */
    FOR nCt:= 1 TO 4
        DrawLine( nCol1+nCt, nLin2-nCt, nCol2-nCt, nLin2-nCt, 0, 0, 177  )    /* Superior */
        DrawLine( nCol1+nCt, nLin1+nCt, nCol1+nCt, nLin2-nCt, 0, 0, 177  )    /* Esquerda */
        DrawLine( nCol1+nCt, nLin1+nCt, nCol2-nCt, nLin1+nCt, 0, 0, 7 )       /* Inferior */
        DrawLine( nCol2-nCt, nLin1+nCt, nCol2-nCt, nLin2-nCt, 0, 0, 7 )       /* Direita */
    NEXT
    IF !cTitulo==Nil
       loadcSet( 0, "RMN1608.PTX" )
       SayString( nCol1+15, nLin2+5, 5, 0,  0, cTitulo ) // PRETO
       SayString( nCol1+12, nLin2+8, 5, 0, 14, cTitulo ) // AMARELO
    ENDIF
 ENDIF
 loadcSet( 0, "VSYS14.PTX" )

Return (.T.)


Function SWGBoxInfo( nCol1, nLin1, nCol2, nLin2, cTitulo, nCor )
 Local nCt
 SetBkFill( nCor )
 SetRGBDAC( 62, 51, 153, 255 )

 FOR nCt:= nCol2 TO nCol1 Step -40
     /* Box Principal */
     BoxFill( nCt, nLin1, (nCol2-nCt), (nLin2-nLin1), 128, 7 )
 NEXT

 /* Box Principal */
 BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 7 )

 /* Box Interno */
 BoxFill( nCol1+10, nLin1+10, (nCol2-nCol1)-20, (nLin2-nLin1)-50, 64, 177 )
 BoxFill( nCol1+12, nLin1+8, (nCol2-nCol1)-20, (nLin2-nLin1)-50, 64, 15 )

 FOR nCt:= 1 TO 2
    DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 15 )       /* SUPERIOR */
    DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 15 )       /* ESQUERDA */
    DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
    DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
 NEXT
 IF !cTitulo==Nil
    loadcSet( 0, "RMN1608.PTX" )
    SayString( nCol1+15, nLin2-42, 5, 0, 177, cTitulo ) // PRETO
    SayString( nCol1+12, nLin2-40, 5, 0,  07, cTitulo ) // AMARELO
 ENDIF
 loadcSet( 0, "VSYS14.PTX" )
 Return Nil









Function SWBotao( nLin, nCol, cDescricao, nLargura )
Local nLin1:= nLin, nCol1:= nCol, nLin2:= nLin + 50, nCol2:= nCol + ( 16 * Len( cDescricao ) )

  IF !nLargura==Nil
     nCol2:= nCol + nLargura
  ENDIF
  BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 7 )
  FOR nCt:= 1 TO 2
      DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 15 )       /* SUPERIOR */
      DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 15 )       /* ESQUERDA */
      DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
      DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
  NEXT

  IF !cDescricao==Nil
     loadcSet( 0, "RMN1608.PTX" )
     SayString( nCol1+15, nLin1+5, 5, 0,  8, cDescricao ) // PRETO
     SayString( nCol1+12, nLin1+8, 5, 0, 14, cDescricao ) // AMARELO
 ENDIF
 loadcSet( 0, "VSYS14.PTX" )



Function SWGBoxSimples( nCol, nLin, nLargura, nAltura )
Local nLin1:= nLin, nCol1:= nCol, nLin2:= nLin + 50
Local nCt

  IF !nLargura==Nil
     nCol2:= nCol1 + nLargura
     nLin2:= nLin1 + nAltura
  ENDIF
  BoxFill( nCol1, nLin1, nLargura, nAltura, 128, 7 )
  FOR nCt:= 1 TO 1
      DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 15 )       /* SUPERIOR */
      DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 15 )       /* ESQUERDA */
      DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 08 )       /* INFERIOR */
      DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* DIREITA */
  NEXT


Function SWPressBotao( nLin, nCol, cDescricao, nLargura )
Local nCt
Local nLin1:= nLin, nCol1:= nCol, nLin2:= nLin + 50, nCol2:= nCol + ( 16 * Len( cDescricao ) )

  IF !nLargura==Nil
     nCol2:= nCol + nLargura
  ENDIF
  BoxFill( nCol1, nLin1, (nCol2-nCol1), (nLin2-nLin1), 128, 7 )
  FOR nCt:= 1 TO 2
      DrawLine( nCol1-nCt, nLin2+nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 08 )       /* SUPERIOR */
      DrawLine( nCol1-nCt, nLin2+nCt, nCol1-nCt,  nLin1-nCt, 0, 0, 08 )       /* ESQUERDA */
      DrawLine( nCol1-nCt, nLin1-nCt, nCol2+nCt,  nLin1-nCt, 0, 0, 15 )       /* INFERIOR */
      DrawLine( nCol2+nCt, nLin1-nCt, nCol2+nCt,  nLin2+nCt, 0, 0, 15 )       /* DIREITA */
  NEXT

  IF !cDescricao==Nil
     loadcSet( 0, "RMN1608.PTX" )
     SayString(   nCol1+17, nLin1+5, 5, 0,  8, cDescricao ) // PRETO
     SayString( nCol1+14, nLin1+8, 5, 0, 14, cDescricao ) // AMARELO
  ENDIF
  loadcSet( 0, "VSYS14.PTX" )

 Function ShowBotoes( aBotoes )
 Local nCt:= 1
 FOR nCt:=1 TO LEN( aBotoes )
     SWBotao( aBotoes[ nCt ][ 1 ], aBotoes[ nCt ][ 2 ], aBotoes[ nCt ][ 3 ] )
 NEXT



 /*****
 旼컴컴컴컴컴컴�
 � Funcao      � TESTEBOTOES
 � Finalidade  � Testa o pressionamento de um botao ou icone e retorna
 �             � o numero da ocorrencia sendo que devera ser positivo+ p/
 �             � botoes e negativo- p/ icones
 � Parametros  � aBotoes, aIcones
 � Retorno     � nBotao
 � Programador � Valmor Pereira Flores
 � Data        �
 읕컴컴컴컴컴컴�
 */
 Function TesteBotoes( aBotoes, aIcones )
 Local nBotao, nCt
 Static nUltimoBotao, nUltimoIcone
 IF nUltimoBotao==Nil
    nUltimoBotao:= MStatus()
 ENDIF
 FOR nCt:= 1 TO LEN( aBotoes )
     MSetHot( nCt, aBotoes[ nCt ][ 2 ], aBotoes[ nCt ][ 1 ], ( 16 * Len( aBotoes[ nCt ][ 3 ] ) ), 50 )
 NEXT
     nBotao:= MStatus()
     IF MMotion() <> 0 .OR. nBotao <> 0 .OR. nBotao==0
        IF !( nBotao==nUltimoBotao )
           MCurOFF()
           IF nBotao==1
              FOR nCt:= 1 TO Len( aBotoes )
                  IF mGetHot() == nCt
                     SWPressBotao( aBotoes[ nCt ][ 1 ], aBotoes[ nCt ][ 2 ], aBotoes[ nCt ][ 3 ] )
                     nUltimoBotao:= 1
                     Return nCt
                  ENDIF
              NEXT
           ELSE
              IF nBotao <> nUltimoBotao
                 FOR nCt:= 1 TO Len( aBotoes )
                     IF MGetHot()==nCt
                        SWBotao( aBotoes[ nCt ][ 1 ], aBotoes[ nCt ][ 2 ], aBotoes[ nCt ][ 3 ] )
                     ENDIF
                 NEXT
                 nUltimoBotao:= 0
              ENDIF
           ENDIF
           MCurOn()
        ENDIF
        nBotao:= MStatus()
        IF nUltimoIcone==Nil
           nUltimoIcone:= 0
        ENDIF
        lRefaz:= .F.
        FOR nCt:= 1 TO Len( aIcones )
           IF SWmGetHot() == ( 10 + nCt ) .AND. !( nUltimoIcone == nCt )
              // Limpa e desenha contorno-box
              BoxFill( (100*nCt)-36, 860, 80, 80, 32, 15 )
              BoxFill( (100*nCt)-36, 860, 80, 80, 64, 177 )
              LoadIcon( aIcones[ nCt ] )
              DrawIcon( (100*nCt)+5, 905, 256, 0, 8  )
              lRefaz:= .T.
              nIcone:= nUltimoIcone
              nUltimoIcone:= nCt
           ENDIF
        NEXT
        IF lRefaz
           FOR nCt:= 1 TO Len( aIcones )
              IF nCt==nIcone
                 BoxFill( (100*nCt)-36, 860, 80, 80, 32, 15 )
                 LoadIcon( aIcones[ nIcone ] )
                 DrawIcon( (100*nCt), 900, 256, 0, 8  )
             ENDIF
           NEXT
        ENDIF
        IF nBotao==1
           Return nUltimoIcone * (-1)
        ENDIF
     ENDIF
   Return 0



/* EXIBE A BARRA DE ROLAGEM NO BROWSE */
Function DisplayBar( nX0, nY0, nX1, nY1 )
Boxfill( nX0-30, nY0+60, (nX1-nX0)+17, (nY1-nY0)-115, 32, 177 )
Boxfill( nX0-28, nY0+62, (nX1-nX0)+12, (nY1-nY0)-120, 32, 7 )
nCol1:= nX0-26
nLin1:= nY0+62
nLin2:= nLin1 + 20
BoxFill( nCol1, nLin1, 18, 20, 32, 8 )
swgBoxSimples( nCol1, nLin1, 20, 20, 8 )
swgBoxSimples( nCol1, nY1-78, 20, 20, 8 )


/* EXIBE A BARRA DE ROLAGEM DO BROWSE */
Function DispBarPos( nX0, nY0, nX1, nY1 )
nPosicao:= DBRECORDINFO( DBRI_RECNO, RECNO() )
nTotal:=   LASTREC()
nLinhas:= ( 390 )
nPercentual:= ( nPosicao / nTotal ) * 100
nPosicaoNaTela:= ( nLinhas * nPercentual ) / 100
swgBoxSimples( nX0-25, (nY1-nPosicaoNaTela)-100, 20, 20, 8 )

/* ARMAZENA AS POSICOES QUE O MOUSE PODE CLICAR */
Function SWMSetHot( nPos, nCol1, nLin1, nLargura, nAltura )
Static aPosicoes
IF nPos==Nil
   Return aPosicoes
ENDIF
IF aPosicoes==Nil
   aPosicoes:= {}
ENDIF
lNova:= .T.
FOR nCt:= 1 TO LEN( aPosicoes )
    IF aPosicoes[ nCt ][ 1 ]==nPos
       aPosicoes[ nCt ]:= { nPos, nCol1, nLin1, nLargura, nAltura }
       lNova:= .F.
    ENDIF
NEXT
IF lNova
   AAdd( aPosicoes, { nPos, nCol1, nLin1, nLargura, nAltura } )
ENDIF


/* RETORNA A POSICAO ONDE ESTA POSIOCIONADO O MOUSE CASO ESTEJA RELACIONA P/
   SWMSetHot COMO SENDO DE UTILIZACAO */
Function SWMGetHot()
Local aPosicoes:= SWMSetHot()
MStatus()
FOR nCt:= 1 TO Len( aPosicoes )
   IF MGetX() >= aPosicoes[ nCt ][ 2 ] .AND.;
      MGetX() <= aPosicoes[ nCt ][ 2 ] + aPosicoes[ nCt ][ 4 ] .AND.;
      MGetY() >= aPosicoes[ nCt ][ 3 ] .AND.;
      MGetY() <= aPosicoes[ nCt ][ 3 ] + aPosicoes[ nCt ][ 5 ]
      Return aPosicoes[ nCt ][ 1 ]
   ENDIF
NEXT
Return 0

/* DESENHA UM BOX PREENCHIDO COM SOMBRA E TUDO MAIS - IGUAL A BOXFILL */
Function swBoxFill( nX0, nY0, nTamanho, nAltura )
SetBkFill( 177 )
SetRGBDAC( 62, 51, 153, 255 )
BoxFill( nX0+2, nY0-2, nTamanho, nAltura, 20, 177 )
SetBkFill( 7 )
BoxFill( nX0, nY0, nTamanho, nAltura, 20, 7 )
Return Nil

Function Magnifico()
Static Fase
Static Vezes
Static nSaved
IF Fase==Nil .OR. nSaved==Nil
   Fase:= 0
   Vezes:= 0
   nSaved:= SWSnapCopy( 55, 25, 1330, 840, 0, "EFEITO.BMP" )
ELSEIF Vezes==0
   SWGBoxSimples( 1145, 845, 200, 118 )
   PicRead( 1150, 850, 1+32, "FORT00.BMP" )
ENDIF
++Vezes
++Fase
DO CASE
   CASE Fase==1; SWSnapPaste( 13, 25, nSaved )
   CASE Fase==2; SWSnapPaste( 23, 25, nSaved )
   CASE Fase==3; SWSnapPaste( 33, 25, nSaved )
   CASE Fase==4; SWSnapPaste( 43, 25, nSaved )
   CASE Fase==5; SWSnapPaste( 33, 25, nSaved )
   CASE Fase==6; SWSnapPaste( 23, 25, nSaved )
   CASE Fase==7; SWSnapPaste( 13, 25, nSaved )
   CASE Fase==8
        Fase:= 0
ENDCASE
IF Vezes + Fase > 10
   IF Fase > 4
      nFort:= ( Fase * (-1) ) + 4
   ELSE
      nFort:= Fase
   ENDIF
   PicRead( 1150, 850, 1+32, "FORT" + StrZero( nFort, 2, 0 ) + ".BMP" )
   IF Fase==0
      Vezes:= 0
   ENDIF
ENDIF
Return Nil


