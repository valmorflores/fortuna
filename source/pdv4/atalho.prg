#Include "Inkey.Ch"
#Include "VPF.Ch"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ ATALHO
³ Finalidade  ³ Apresentar um atalho e permitir que o usuario acesse
³             ³ o modulo a partir deste, podendo tambem definir atalhos
³             ³ especificos
³ Parametros  ³
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ (  <-: )
*/
Function Atalho( cAtalho )
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, MaxCol() )
   LOCAL GetList:= {}
   LOCAL nArea:= Select(), nOrdem:= IndexOrd()
   LOCAL lNovo:= .F.

   LOCAL nLinha:= Row(), nColuna:= Col(), cIcone:= Space( 2 )
   LOCAL nCt:= 1
   LOCAL nOpcao:= 1
   LOCAL cCorRes, cTelaRes, nLin, nCol
   LOCAL cDescricao:= Space( 20 ), cModulo:= Space( 15 ), aNovo:= {}
   LOCAL aAtalhos:= {}

   // Formacao da matriz principal
   // aAtalhos:= { { nLin, nCol, cDescricao, cIcon, cLocalDestino } }

   // Exemplo de matriz
   // { { 03, 02, "Clientes", "ìí", "CliInclusao()" },;
   // { 05, 02, "Materia-Prima", "ðñ", "MprInclusao()" } }

   DBSelectAr( _COD_ATALHO )
   DBGoTop()
   WHILE !EOF()
       AAdd( aAtalhos, { ATL->LINHA_, ATL->COLUNA, Alltrim( ATL->DESCRI ), Alltrim( ATL->ICONE_ ), ATL->MODULO } )
       DBSkip()
   ENDDO

   /* Colocacao de informacoes internas */
   AAdd( aAtalhos, { 23, 02, "[ Criar Atalho p/ este m¢dulo ]", " ", "GERENCIAL", 1 } )

   /* Montagem da tela e cor */
   VPBOX( 0, 0, 24, 79, " GERENCIAMENTO DE ATALHOS ", "15/00", .T., .T., "01/15" )
   SetColor( "15/00,14/01" )

   /* Montagem de atalhos na tela */
   FOR nCt:= 1 TO Len( aAtalhos )

       @ aAtalhos[ nCt ][ 1 ], aAtalhos[ nCt ][ 2 ] ;
                 Say aAtalhos[ nCt ][ 4 ] + " - "

       @ aAtalhos[ nCt ][ 1 ], aAtalhos[ nCt ][ 2 ] + Len( aAtalhos[ nCt ][ 4 ] ) + 1 ;
                 Prompt aAtalhos[ nCt ][ 3 ]

   NEXT
   Menu To nOpcao

   IF !( nOpcao == 0 )
      M->Variavel:= aAtalhos[ nOpcao ][ 5 ]

      /* se a informacao for gerencial, executa neste m¢dulo mesmo. */
      IF m->Variavel == "GERENCIAL"

         /* Salva a tela atual */
         cTelaRes:= ScreenSave( 0, 0, 24, 79 )
         cCorRes:= SetColor()
         DO CASE
            CASE aAtalhos[ nOpcao ][ 6 ] == 1   /* Inclusao de atalho */
                 VPBox( 10, 10, 16, 70, " Inclusao de Atalho ", "15/01" )
                 SetColor( "15/01,01/15" )
                 cModulo:= PAD( ProcName( 4 ) + "()", 20 )
                 @ 11,12 Say "Descricao do Atalho:" Get cDescricao
                 @ 12,12 Say "Modulo (destino)...:" Get cModulo
                 @ 13,12 Say "Icone..............:" Get cIcone
                 @ 14,12 Say "Posicao na tela....: [Automatica]"
                 @ 15,12 Say "Cor de Atalho......: [Automatica]"
                 READ
                 IF ! LastKey() == K_ESC .AND. ! Empty( cModulo ) .AND.;
                    ! Empty( cDescricao )
                    lNovo:= .T.
                 ENDIF

                 IF Len( aAtalhos ) > 1
                    nLin:= aAtalhos[ Len( aAtalhos ) - 1 ][ 1 ] + 2
                    nCol:= aAtalhos[ Len( aAtalhos ) - 1 ][ 2 ]
                    IF nLin > 22
                       nLin:= 02
                       nCol:= nCol + 25
                    ENDIF
                 ELSE
                    nLin:= 02
                    nCol:= 02
                 ENDIF

                 /* Adiciona na matriz aNovo */
                 AAdd( aNovo, { nLin, nCol, cDescricao, cIcone, cModulo } )

         ENDCASE
         SetColor( cCorRes )
         ScreenRest( cTelaRes )

      ELSE  // Executa o modulo de atalho

         VPTela()

         SWSet( _INT_EMATALHO, .T. )

         EVAL( &( "{|| " + M->Variavel + "}" ) )

         SWSet( _INT_EMATALHO, .F. )

      ENDIF

   ENDIF

   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   @ nLinha, nColuna Say Space(0)

   /* Caso tenha sido acrescentado um novo registro */
   IF lNovo
      FOR nCt:= 1 TO LEN( aNovo )
          DBAppend()
          IF NetRLock()
             Replace ATL->LINHA_ With aNovo[ nCt ][ 1 ],;
                     ATL->COLUNA With aNovo[ nCt ][ 2 ],;
                     ATL->DESCRI With aNovo[ nCt ][ 3 ],;
                     ATL->ICONE_ With aNovo[ nCt ][ 4 ],;
                     ATL->MODULO With aNovo[ nCt ][ 5 ]
          ENDIF
      NEXT
   ENDIF

   /* Restaura a area de trabalho */
   IF nArea <> 0
      DBSelectAr( nArea )

      IF ! nOrdem == 0
         DBSetOrder( nOrdem )
      ENDIF

   ENDIF

   Return Nil


/*
-----------------------
EXEMPLO DE APRESENTACAO
----------------------------------------->>>

             SISTEMA GERENCIADOR DE ATALHOS
 µºººººººººººººººººººººººººººººººººººººººººººººººººººººººº¶
 ¼                               ¼ Definicoes de Usuarios ½
 ¼ ÔÕ Clientes                   ¼                        ½
 ¼                               ¼                        ½
 ¼ àá Lista Telefonica           ¼                        ½
 ¼                               ¼                        ½
 ¼ êë Almoxarifado               ¼                        ½
 ¼                               ¼                        ½
 ¼ ìí Fechamento Mensal          ¼                        ½
 ¼                               ¼                        ½
 ¼                               ¼                        ½
 ¼                               ¼                        ½
 ¼                               ¼                        ½
 ¸»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»¹

*/





