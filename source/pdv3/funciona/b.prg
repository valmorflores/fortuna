#include "COMMON.CH"
#include "INKEY.CH"
#include "DBINFO.CH"

#Define _COD_CLIENTE       13
#Define _VPB_CLIENTE       &DiretorioDeDados\CLIENTES.DBF


   local Local1, Local2
   nMode:= 2

   Altd( 1 )

   set scoreboard off
   SET DELETED ON
   SET DATE BRITISH
   SET CENTURY ON
   SET EPOCH TO 30
   clear screen
   Relatorio( "PDV.INI" )
   Local2:= {19, 257, 259, 261}
   Local1:= 1
   nMode:= 2
   SetBlink( .f. )

   setcursor(0)
   setgmode(Local2[nMode])
   sethires(0)

   Browse ()

   Settext()
   RUN MODE CO80
   __Quit ()


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
Function Browse()
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
   IF File( DiretorioDeDados-"\CLIENTES.DBF" )
       DBSelectAr( _COD_CLIENTE )
       Use _VPB_CLIENTE Alias CLI Shared
       IF !File( DiretorioDeDados-"\CLIIND01.NTX" )
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








// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWGAviso( cTitulo, aAviso, nCor, nCorTit, nLin1x, nCol1x, nLin2x, nCol2x )

   Local nTelaVal:= SWSnapCopy( 0, 0, 1250, 900, 0, "TMP_AVIS.BMP" )
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
       SayString( nCol1+30, (nLin2-50) - ( nCt * 50 ), 5, 0, 8, aAviso[ nCt ] )
   NEXT

   Inkey(0)

   r= SWSnapPaste( 0, 0, nTELAVAL )
   r= SWSnapKill( nTELAVAL )

Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function Efeito()
Local nCor
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
Local nCursor:= SetCursor( 0 ), nLin:= UltimaTela()[2], nCol:= UltimaTela()[1]
Static nHUltTela
IF !nLin==Nil
   IF nLin > 0
      IF nHUltTela==Nil .OR. cMensagem==Nil
         nHUltTela:= SWSnapCopy( 0, nLin, 1200, nLin+50, 0, "TMP_MENS.BMP" )
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
³ Funcao      ³ PESQUISA
³ Finalidade  ³ Apresentar relacao de EMPRESAS
³ Parametros  ³ cNome
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Pesquisa()
Local nCt:= 0
Local nArea:= Select(), oTb, nCursor:= SetCursor(), cColor := SetColor ()
Local nTelaC
Local cBusca:= "", nTecla:= 0

  SetColor( "08/15,01/03" ) // CURSOR CIANO    (VERDE CLARO)
  SetCursor( 0 )
  DBSelectAr( _COD_CLIENTE )
  IF !Used()
     Use _VPB_CLIENTE Alias CLI Shared
     Set Index To &DiretoriodeDados\CLIIND01.NTX,;
                  &DiretoriodeDados\CLIIND02.NTX,;
                  &DiretoriodeDados\CLIIND03.NTX
  ENDIF
  DBSetOrder( 2 )
  DBGotop()
  IF .T.
     nTelaC:= SWSnapCopy( 30, 80, 1280, 950, 0, "TMP_BUCL.BMP" )
     loadcSet( 0, "VSYS14.PTX" )
     SWGBox( 40, 220, 1250, 800, "Pesquisa ao Cadastro de Empresas", 15 )
     DisplayBar( 1240, 220, 1250, 800 )
     nTelaX:= SnapCopy( 1200, 220, 1250, 800, 0 )
     Mensagem( )
     IF .T.
        SetCursor( 0 )
        oTb:= TBrowseDB( 10, 04, 23, 70 )
        oTb:addcolumn(tbcolumnnew(,{|| PAD( " " + CLI->DESCRI + " " + Tran( CLI->CGCMF_, "@R 99.999.999/9999-99" ), 85 ) }))
        oTb:AUTOLITE:=.f.
        oTb:dehilite()
        nUltimoRegistro:= RECNO()
        MCurOn()
        WHILE .T.
            MCurOff()
            loadcSet( 0, "VSYS14.PTX" )
            oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
            WHILE nextkey()==0 .and. ! oTb:stabilize()
            ENDDO
            SnapPaste( 1200, 220, nTelaX )
            nPosicao:= DispBarPos( 1240, 220, 1250, 800 )
            IF !( cBusca == "" )
               Mensagem( "Pesquisa " + cBusca )
            ELSE
               Mensagem( CLI->CIDADE + " " + CLI->CGCMF_ + " " + CLI->CPF___ )
            ENDIF
            MCurOn()
            WHILE ( nTecla:=Inkey() )==0
                nRegiao:= 1
                nBotao:= MStatus()
                MSetHot( 2, 1210, 280, 20, 20 )
                MSetHot( 1, 1210, 720, 20, 20 )
                MSetHot( 3, 1210, 300, 20, 450 )
                IF MMotion() <> 0
                   MCurOFF()
                   MCurOn()
                ENDIF
                IF nBotao==1
                   IF MGetHot()==1
                      Keyboard Chr( K_UP ) + Chr( 0 )
                   ELSEIF MGetHot()==2
                      Keyboard Chr( K_DOWN ) + Chr( 0 )
                   ELSEIF MGetHot()==3
                      Keyboard Chr( K_PGDN ) + Chr( 0 )
                   ENDIF
                ENDIF
            ENDDO
            MCurOff()
            IF !( UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &" )
               cBusca:= ""
            ENDIF

            IF nTecla==K_ESC
               EXIT
            ENDIF

            DO CASE
               CASE nTecla==K_UP         ;oTb:up()
               CASE nTecla==K_DOWN       ;oTb:down()
               CASE nTecla==K_LEFT
               CASE nTecla==K_RIGHT
               CASE nTecla==K_PGUP       ;oTb:pageup()
               CASE nTecla==K_CTRL_PGUP  ;oTb:gotop()
               CASE nTecla==K_CTRL_ENTER
                    AltEmpresa( otb )
                    SetCursor(0)
                    MCurOff()
                    SWGBox( 40, 220, 1250, 800, "Pesquisa ao Cadastro de Empresas", 15 )
                    Mensagem()
                    oTb:RefreshAll()
                    WHILE !oTb:Stabilize()
                    ENDDO
                    MCurOn()

               CASE nTecla==K_INS
                    InsEmpresa( otb )
                    SetCursor(0)
                    MCurOff()
                    SWGBox( 40, 220, 1250, 800, "Pesquisa ao Cadastro de Empresas", 15 )
                    Mensagem()
                    oTb:RefreshAll()
                    WHILE !oTb:Stabilize()
                    ENDDO
                    MCurOn()
               CASE nTecla==K_PGDN       ;oTb:pagedown()
               CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom()
               CASE UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
                    cBusca:= cBusca + UPPER( Chr( nTecla ) )
                    DBSeek( cBusca, .T. )
                    IF !nUltimoRegistro==RECNO()
                       oTb:RefreshAll()
                       WHILE !oTb:Stabilize()
                       ENDDO
                       nUltimoRegistro:= RECNO()
                    ENDIF

               CASE nTecla==K_ENTER
                    EXIT
               OTHERWISE                ;tone(125); tone(300)
            ENDCASE
            loadcSet( 0, "VSYS14.PTX" )
            oTb:refreshcurrent()
            oTb:stabilize()
        ENDDO
     ENDIF

     /* Restauracao da tela */
     SWSnapPaste( 30, 80, nTelaC )
     SWSnapKill( nTelaC )
  ENDIF
  SetColor (cColor)
  IF nArea > 0
     DBSelectAr( nArea )
  ENDIF
  SetCursor( nCursor )
  MCurOn()
  Return .T.

Function SelVisitantes( cEmpresa )
Local nCt:= 0
Local nArea:= Select(), oTb, nCursor:= SetCursor(), cColor := SetColor ()
Local nTelaC
Local cBusca:= "", nTecla:= 0

  SetColor( "08/15,01/03" ) // CURSOR CIANO    (VERDE CLARO)
  SetCursor( 0 )
  DBSelectAr( _COD_CLIENTE )
  IF !Used()
     Use _VPB_CLIENTE Alias CLI Shared
     Set Index To &DiretoriodeDados\CLIIND01.NTX,;
                  &DiretoriodeDados\CLIIND02.NTX,;
                  &DiretoriodeDados\CLIIND03.NTX
  ENDIF
  DBSetOrder( 2 )
  DBGotop()
  IF .T.
     nTelaC:= SWSnapCopy( 30, 80, 1280, 950, 0, "TMP_BUCL.BMP" )
     loadcSet( 0, "VSYS14.PTX" )
     SWGBox( 40, 220, 1250, 800, "Pesquisa ao Cadastro de Empresas", 15 )
     DisplayBar( 1240, 220, 1250, 800 )
     nTelaX:= SnapCopy( 1200, 220, 1250, 800, 0 )
     Mensagem( )
     IF .T.
        SetCursor( 0 )
        oTb:= TBrowseDB( 10, 04, 23, 70 )
        oTb:addcolumn(tbcolumnnew(,{|| PAD( " " + CLI->DESCRI + " " + Tran( CLI->CGCMF_, "@R 99.999.999/9999-99" ), 85 ) }))
        oTb:AUTOLITE:=.f.
        oTb:dehilite()
        nUltimoRegistro:= RECNO()
        MCurOn()
        WHILE .T.
            MCurOff()
            loadcSet( 0, "VSYS14.PTX" )
            oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1})
            WHILE nextkey()==0 .and. ! oTb:stabilize()
            ENDDO
            SnapPaste( 1200, 220, nTelaX )
            nPosicao:= DispBarPos( 1240, 220, 1250, 800 )
            IF !( cBusca == "" )
               Mensagem( "Pesquisa " + cBusca )
            ELSE
               Mensagem( CLI->CIDADE + " " + CLI->CGCMF_ + " " + CLI->CPF___ )
            ENDIF
            MCurOn()
            WHILE ( nTecla:=Inkey() )==0
                nRegiao:= 1
                nBotao:= MStatus()
                MSetHot( 2, 1210, 280, 20, 20 )
                MSetHot( 1, 1210, 720, 20, 20 )
                MSetHot( 3, 1210, 300, 20, 450 )
                IF MMotion() <> 0
                   MCurOFF()
                   MCurOn()
                ENDIF
                IF nBotao==1
                   IF MGetHot()==1
                      Keyboard Chr( K_UP ) + Chr( 0 )
                   ELSEIF MGetHot()==2
                      Keyboard Chr( K_DOWN ) + Chr( 0 )
                   ELSEIF MGetHot()==3
                      Keyboard Chr( K_PGDN ) + Chr( 0 )
                   ENDIF
                ENDIF
            ENDDO
            MCurOff()
            IF !( UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &" )
               cBusca:= ""
            ENDIF

            IF nTecla==K_ESC
               EXIT
            ENDIF

            DO CASE
               CASE nTecla==K_UP         ;oTb:up()
               CASE nTecla==K_DOWN       ;oTb:down()
               CASE nTecla==K_LEFT
               CASE nTecla==K_RIGHT
               CASE nTecla==K_PGUP       ;oTb:pageup()
               CASE nTecla==K_CTRL_PGUP  ;oTb:gotop()
               CASE nTecla==K_INS
                    InsEmpresa( otb )
                    SetCursor(0)
                    MCurOff()
                    SWGBox( 40, 220, 1250, 800, "Pesquisa ao Cadastro de Empresas", 15 )
                    Mensagem()
                    oTb:RefreshAll()
                    WHILE !oTb:Stabilize()
                    ENDDO
                    MCurOn()
               CASE nTecla==K_PGDN       ;oTb:pagedown()
               CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom()
               CASE UPPER( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW0123456789 &"
                    cBusca:= cBusca + UPPER( Chr( nTecla ) )
                    DBSeek( cBusca, .T. )
                    IF !nUltimoRegistro==RECNO()
                       oTb:RefreshAll()
                       WHILE !oTb:Stabilize()
                       ENDDO
                       nUltimoRegistro:= RECNO()
                    ENDIF

               CASE nTecla==K_ENTER
                    EXIT
               OTHERWISE                ;tone(125); tone(300)
            ENDCASE
            loadcSet( 0, "VSYS14.PTX" )
            oTb:refreshcurrent()
            oTb:stabilize()
        ENDDO
     ENDIF

     /* Restauracao da tela */
     SWSnapPaste( 30, 80, nTelaC )
     SWSnapKill( nTelaC )

  ENDIF
  SetColor (cColor)
  IF nArea > 0
     DBSelectAr( nArea )
  ENDIF
  SetCursor( nCursor )
  MCurOn()
  Return .T.


// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
/* COMPLEMENTAR INFORMACOES NA BASE DE DADOS DA EMPRESA/CLIENTES              */
// -----------------------------------------------------------------------------
Function InsEmpresa()
Local cCor:= SetColor()
Local cTela:= SWSnapCopy( 30, 30, 1200, 980, "EMP_COP.BMP" )
Local nCodigo:= 0, cDescri:= Space( 50 ), cEndere:= Space( 45 ),;
      cBairro:= Space( 20 ), cCidade:= Space( 35 ), cEstado:= "RS",;
      cCodCep:= Space( 8 ),  cComple:= Space( 20 ), dFundac:= CTOD( "  /  /  " ),;
      nClass_:= 0, nCargo:= 0, cEmpres:= Space( 14 ), cFone__:= Space( 14 ),;
      cContat:= " ", cDesRaz:= Space( 50 ),;
      cE_Mail:= Space( 60 ), nNumFun:= 0, cSite__:= Space( 60 )
Local nCursor:= SetCursor()

   MCurOff()
   SWGBox( 141, 80, 1180, 930, "Inclusao de Empresa" )
   SWBoxFill( 330, 798, 325, 40, 20 + 32, 0 )
   SWBoxFill( 330, 737, 805, 40, 20 + 32, 0 )
   SWBoxFill( 330, 682, 805, 40, 20 + 32, 0 )
   SWBoxFill( 330, 622, 180, 40, 20 + 32, 0 )
   SWBoxFill( 330, 562, 480, 40, 20 + 32, 0 )
   SWBoxFill( 330, 505, 350, 40, 20 + 32, 0 )
SWBoxFill( 885, 562, 240, 40, 20 + 32, 0 )       /* Complemento */
   SWBoxFill( 330, 505, 450, 40, 20 + 32, 0 )    /* Bairro */
   SWBoxFill( 330, 445, 450, 40, 20 + 32, 0 )
SWBoxFill( 885, 445, 050, 40, 20 + 32, 0 )       /* Estado */
   SWBoxFill( 330, 387, 180, 40, 20 + 32, 0 )
SWBoxFill( 675, 387, 460, 40, 20 + 32, 0 )       /* E-Mail */
   SWBoxFill( 330, 327, 805, 40, 20 + 32, 0 )    /* Site */
   SWBoxFill( 330, 270, 090, 40, 20 + 32, 0 )    /* n.funcionarios */
SWBoxFill( 735, 270, 50, 40, 20 + 32, 0 )     /* classificacao */
   SetCursor( 1 )
   SetColor( "08/15,11/07" )
   @ 06,10 Say "CNPJ     " Get cEmpres Pict "@R 99.999.999/9999-99"
   @ 08,10 Say "Fantasia " Get cDescri Pict "@S47"
   @ 10,10 Say "R.Social " Get cDesRaz Pict "@S47"
   @ 12,10 Say "Fundacao " Get dFundac
   @ 14,10 Say "Endereco " Get cEndere Pict "@S26"
   @ 14,50 Say "No" Get cComple Pict "@S13"
   @ 16,10 Say "Bairro   " Get cBairro
   @ 18,10 Say "Cidade   " Get cCidade Pict "@S26"
   @ 18,50 Say "UF" Get cEstado
   @ 20,10 Say "Cod.Cep  " Get cCodCep Pict "@R 99.999-999"
   @ 20,33 Say "E-Mail" Get cE_Mail Pict "@S26"
   @ 22,10 Say "Site     " Get cSite__ Pict "@S45"
   @ 24,10 Say "No.Func. " Get nNumFun Pict "9999"
   @ 24,30 Say "Classificacao" Get nClass_ Pict "99"
   READ
   IF !LastKey()==K_ESC
      CLI->( DBAppend() )
      CLI->( RLock() )
      IF !CLI->( NetErr() )
         Replace CODIGO With nCodigo,;
                 CGCMF_ With cEmpres,;
                 DESCRI With cDesRaz,;
                 FANTAS With cDescri,;
                 ENDERE With cEndere,;
                 BAIRRO With cBairro,;
                 CIDADE With cCidade,;
                 ESTADO With cEstado,;
                 CODCEP With cCodCep,;
                 E_MAIL With cE_mail,;
                 CODATV With nClass_
      ENDIF
   ENDIF
   SetCursor( nCursor )
   SetColor( cCor )
   SWSnapPaste( 30, 30, cTela )
   MCurOn()
   Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
/* ALTERAR INFORMACOES NA BASE DE DADOS DA EMPRESA/CLIENTES                    */
// -----------------------------------------------------------------------------
Function AltEmpresa()
Local cCor:= SetColor()
Local cTela:= SWSnapCopy( 30, 30, 1200, 980, "EMP_COP.BMP" )
Local nCodigo:= 0, cDescri:= FANTAS, cEndere:= ENDERE,;
      cBairro:= BAIRRO, cCidade:= PAD( CIDADE, 35 ), cEstado:= ESTADO,;
      cCodCep:= CODCEP,  cComple:= Space( 20 ), dFundac:= CTOD( "  /  /  " ),;
      nClass_:= CODATV,  nCargo:= 0, cEmpres:= CGCMF_, cFone__:= Space( 14 ),;
      cContat:= " ", cDesRaz:= DESCRI,;
      cE_Mail:= Space( 60 ), nNumFun:= 0, cSite__:= Space( 60 )
Local nCursor:= SetCursor()

   MCurOff()
   SWGBox( 141, 80, 1180, 930, "Inclusao de Empresa" )
   SWBoxFill( 330, 798, 325, 40, 20 + 32, 0 )
   SWBoxFill( 330, 737, 805, 40, 20 + 32, 0 )
   SWBoxFill( 330, 682, 805, 40, 20 + 32, 0 )
   SWBoxFill( 330, 622, 180, 40, 20 + 32, 0 )
   SWBoxFill( 330, 562, 480, 40, 20 + 32, 0 )
     SWBoxFill( 885, 562, 240, 40, 20 + 32, 0 )       /* Complemento */
   SWBoxFill( 330, 505, 450, 40, 20 + 32, 0 )         /* Bairro */
   SWBoxFill( 330, 445, 450, 40, 20 + 32, 0 )
     SWBoxFill( 885, 445, 050, 40, 20 + 32, 0 )       /* Estado */
   SWBoxFill( 330, 387, 180, 40, 20 + 32, 0 )
     SWBoxFill( 675, 387, 460, 40, 20 + 32, 0 )       /* E-Mail */
   SWBoxFill( 330, 327, 805, 40, 20 + 32, 0 )         /* Site */
   SWBoxFill( 330, 270, 090, 40, 20 + 32, 0 )         /* N.Funcionarios */
     SWBoxFill( 735, 270, 50, 40, 20 + 32, 0 )        /* Classificacao */
   SetCursor( 1 )
   SetColor( "08/15,11/07" )
   @ 06,10 Say "CNPJ     " Get cEmpres Pict "@R 99.999.999/9999-99"
   @ 08,10 Say "Fantasia " Get cDescri Pict "@S47"
   @ 10,10 Say "R.Social " Get cDesRaz Pict "@S47"
   @ 12,10 Say "Fundacao " Get dFundac
   @ 14,10 Say "Endereco " Get cEndere Pict "@S26"
   @ 14,50 Say "No" Get cComple Pict "@S13"
   @ 16,10 Say "Bairro   " Get cBairro
   @ 18,10 Say "Cidade   " Get cCidade Pict "@S26"
   @ 18,50 Say "UF" Get cEstado
   @ 20,10 Say "Cod.Cep  " Get cCodCep Pict "@R 99.999-999"
   @ 20,33 Say "E-Mail" Get cE_Mail Pict "@S26"
   @ 22,10 Say "Site     " Get cSite__ Pict "@S45"
   @ 24,10 Say "No.Func. " Get nNumFun Pict "9999"
   @ 24,30 Say "Classificacao" Get nClass_ Pict "99"
   READ
   IF !LastKey()==K_ESC
      CLI->( RLock() )
      IF !CLI->( NetErr() )
         Replace CODIGO With nCodigo,;
                 CGCMF_ With cEmpres,;
                 DESCRI With cDesRaz,;
                 FANTAS With cDescri,;
                 ENDERE With cEndere,;
                 BAIRRO With cBairro,;
                 CIDADE With cCidade,;
                 ESTADO With cEstado,;
                 CODCEP With cCodCep,;
                 E_MAIL With cE_mail,;
                 CODATV With nClass_
      ENDIF
   ENDIF
   SetCursor( nCursor )
   SetColor( cCor )
   SWSnapPaste( 30, 30, cTela )
   MCurOn()
   Return Nil



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

Function SWSnapCopy( nX0, nY0, nX1, nY1, nModo, cFile )
cFile:= IF( cFile==Nil, "RESERVA.BMP", cFile )
PicWrite( nX0, nY0, nX1, nY1, 1, cFile )
Return cFile

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWSnapPaste( nX0, nY0, cImagem )
PicRead( nX0, nY0, 1, cImagem )
Return .T.

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Function SWSnapKill()
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
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Funcao      ³ TESTEBOTOES
 ³ Finalidade  ³ Testa o pressionamento de um botao ou icone e retorna
 ³             ³ o numero da ocorrencia sendo que devera ser positivo+ p/
 ³             ³ botoes e negativo- p/ icones
 ³ Parametros  ³ aBotoes, aIcones
 ³ Retorno     ³ nBotao
 ³ Programador ³ Valmor Pereira Flores
 ³ Data        ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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



/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ getVisitante
³ Finalidade  ³ Edicao dos dados do Visitante
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION getVisitante( lEmpresa )
Local cCor:= SetColor()
Local cTela:= SWSnapCopy( 30, 30, 900, 900, "VIS_COP.BMP" )
Local nCodigo:= 0, cDescri:= Space( 50 ), cEndere:= Space( 45 ),;
      cBairro:= Space( 20 ), cCidade:= Space( 35 ), cEstado:= "RS",;
      cCodCep:= Space( 8 ),  cComple:= Space( 20 ), dNascim:= CTOD( "  /  /  " ),;
      nClass_:= 0, nCargo:= 0, cEmpres:= Space( 14 ), cFone__:= Space( 14 ),;
      cContat:= " "
Local nCursor:= SetCursor()

   MCurOff()
   SWGBox( 40, 100, 800, 800, "Cadastro de Visitante" )
   SWBoxFill( 230, 678, 250, 40, 20 + 32, 0 )
   SWBoxFill( 230, 622, 540, 40, 20 + 32, 0 )
   SWBoxFill( 230, 562, 180, 40, 20 + 32, 0 )
   SWBoxFill( 230, 505, 330, 40, 20 + 32, 0 )
   SWBoxFill( 230, 445, 050, 40, 20 + 32, 0 )
   SWBoxFill( 230, 387, 030, 40, 20 + 32, 0 )
   SWBoxFill( 230, 327, 255, 40, 20 + 32, 0 )
   SetCursor( 1 )
   SetColor( "08/15,11/07" )
   @ 10,04 Say "Doc      " Get nCodigo Pict "@R 99999999999999"
   @ 12,04 Say "Nome     " Get cDescri Pict "@S31"
   @ 14,04 Say "Nascim   " Get dNascim
   @ 16,04 Say "Empresa  " Get cEmpres Pict "@R 99.999.999/9999-99"
   @ 18,04 Say "Classif  " Get nClass_ Pict "99"
   @ 20,04 Say "Contato  " Get cContat Pict "9"
   @ 22,04 Say "Fone     " Get cFone__ Pict "XXXX-XXXX.XXXX"
   READ
   SetCursor( nCursor )
   SetColor( cCor )
   SWSnapPaste( 30, 30, cTela )
   MCurOn()
   Return Nil


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


