#include "inkey.ch"

/*

   MENUMAN

      Menu Manager
      Permite que se facam menus a partir de um arquivo de configuracoes
      Exemplo:

      ---------------------- FileMenu.Sys

              
            000                   [ Iniciar ]
            000.01              ÚÄ[ 1 Utilitarios   ]                         <C¢pias, reindexa‡„o e configura‡„o do sistema.
            000.02              ÃÄ[ 2 Cadastro      ]                         <Cadastro geral do sistema.
            000.02.01           ³    ÃÄ[ 1 Clientes             ]             <Inclus„o, altera‡„o e exclus„o de clientes.                            
            000.02.01.01        ³    ³    ÃÄ[ 1 Especial         ]            <Inclus„o, altera‡„o e exclus„o de materia-prima.
            000.02.01.01.01     ³    ³    ³    ÃÄ[ 1 abc         ]            <Inclusao de produtos.
            000.02.01.01.01.01  ³    ³    ³    ³    ÃÄ[ 2 ssssssss    ]       <Alteracao de produtos.
            000.02.01.01.02     ³    ³    ³    ÃÄ[ 2 def         ]            <Alteracao de produtos.
            000.02.01.01.03     ³    ³    ³    ÃÄ[ 3 ggghhhhh    ]            <Exclusao de produtos.                                        DEVOUT( "TESTE ESPECIAL" )
            000.02.01.01.04     ³    ³    ³    ÃÄ[ 4 iiiiiiiiijj ]            <Verificacao de produtos.
            000.02.01.02        ³    ³    ÃÄ[ 2 Simples          ]            <Composicao (Monstagem) de um produto final com base nos demais.
            000.02.01.03        ³    ³    ÃÄ[ 3 Comum            ]            <Diversas opcoes conforme necessario
            000.02.02           ³    ÃÄ[ 2 Fornecedores         ]             <Inclus„o, altera‡„o e exclus„o de fornecedores.
            Coordenadas <000>                            = [ 04, 04 ] Menu Principal do Sistema
            Coordenadas <000.02>                         = [ 15, 50 ] Cadastro
            Coordenadas <000.02.01>                      = [ 06, 06 ] Clientes 
            Coordenadas <000.02.01.01>                   = [ 07, 07 ] Especial    
            Coordenadas <000.02.01.01.01>                = [ 08, 08 ] Simples  
            Coordenadas <000.02.03>                      = [ 09, 09 ] Cadastro de Produtos

   ---------------------- EOF  

   Elaborado em 21/06/1997

   Ultima atualizacao realizada em 20/09/2003

   Por Valmor Pereira Flores
   Todos os direitos reservados ao autor

*/

// #Define SWMENU
// #Define SWBIBLREQUEST

// Acoes =====================================
#Define acGravar  1
#Define acMover   2
#Define acNil     3

// Diretivas de Tratamento do Menu ===========
#Define MENU              Upper( AllTrim( aMenu[ nCt ] ) )
#Define MENUNORMAL        aMenu[ nCt ]
#Define MENUVARIAVEIS     Alltrim( Left( MENU, At( "=", MENU ) - 1 ) )
#Define MENUCOORDENADAS   UPPER( Left( MENU, 11 ) )
#Define MENUPOSICAO       Alltrim( Left( MENUNORMAL, 20 ) )
#Define MENUOPCAO         SubStr( MENUNORMAL, At( "[", MENUNORMAL ) + 1, At( "]", MENUNORMAL ) - At( "[", MENUNORMAL ) - 1 )
#Define MENUMENSAGEM      PADC( Alltrim( SubStr( MENUNORMAL, At( "<", MENUNORMAL ) + 1, 64 ) ), 80 )
#Define MENUESPACO        Len( AllTrim( MENUPOSICAO ) )
#Define MENUFUNCAO        Substr( MENUNORMAL, 140 )

Function MainMenuMan()

Local cCor:= "15/01", cCorRealse:= "14/01"

   cls

   set message to 23 center
   MenuSys( "filemenu.sys", cCor, cCorRealse )


Function MenuSys( cArquivo, Cor, CorRealse )
   Local cOpcao:= "000."
   Local aPosicao:= { 0 }
   Local cCor:= SetColor(), nCursor:= SetCursor()
   Local nPosAntiga:= 1
   Local nCt:= 1, aMenu, nPos:= 0, aMenuGeral:= {}, aMenuPosicao:= {},;
         nRowIni:= 0, nColIni:= 0, aTela:= { Nil }

   #ifdef SWBIBLREQUEST
    Ajuda("["+_SETAS+"]Movimenta [ENTER]Executa")
   #endif

   set key K_HOME to __swMover()
   set key K_END  to __swGravar()

   /* Ler dados de arquivo */
   aMenu:= FileArray( cArquivo )

   For nCt:= 1 To Len( aMenu )

       If MENUCOORDENADAS == "COORDENADAS"

          /* Adiciona na matriz de posicoes */
          AAdd( aMenuPosicao, { Posicao( MENUNORMAL, MENU, 1 ),;
                                Posicao( MENUNORMAL, MENU, 2 ),;
                                SubStr( MENUVARIAVEIS, At( "<", MENUVARIAVEIS ) + 1,;
                            At( ">", MENUVARIAVEIS ) - At( "<", MENUVARIAVEIS ) - 1 ) } )

       Else
          AAdd( aMenuGeral, { MENUPOSICAO, MENUOPCAO, MENUMENSAGEM, MENUESPACO, MENUFUNCAO } )
       EndIf

   Next

   //cls

   nMenu:= 0
   nCol:= 0

   While .T.

      nLin:= 1
      aList:={}
      For nCt:= 1 To Len( aMenuGeral )

          /* Se for o primeiro menu */
          If nMenu == 0

             /* Pega as posicoes: Coordenadas do menu principal do sistema */
             If aMenuGeral[ nCt ][ 4 ] == 6

                If nRowIni == 0
                   nRowIni:= aMenuPosicao[ AScan( aMenuPosicao, {|x| Alltrim( x[3] ) == Left( AllTrim( aMenuGeral[ nCt ][ 1 ] ), Len( Alltrim( aMenuGeral[ nCt ][ 1 ] ) ) - 3 ) } ) ][ 1 ]
                   nColIni:= aMenuPosicao[ AScan( aMenuPosicao, {|x| Alltrim( x[3] ) == Left( AllTrim( aMenuGeral[ nCt ][ 1 ] ), Len( AllTrim( aMenuGeral[ nCt ][ 1 ] ) ) - 3 ) } ) ][ 2 ]
                   nLin:= nRowIni
                   nCol:= nColIni
                EndIf


                /* Adiciona no Array de menu principal */
                AAdd( aList, { nLin++, nCol, MENUOPCAO, MENUMENSAGEM, MENUFUNCAO } )

                nLenMenu:= Len( MENUOPCAO )

             EndIf


          /* Se forem os demais menus */
          ElseIf nMenu >0

             // Se cOpcao (000.
             IF cOpcao == Left( aMenuGeral[ nCt ][ 1 ], len( cOpcao ) ) .AND.;
                trim( SubStr( aMenuGeral[ nCt ][ 1 ], len( cOpcao ) + 3, 2 ) ) == ""

                // .AND. Val( SubStr( aMenuGeral[ nCt ][ 1 ], 2 + ( nMenu * 3 ), 2 ) ) == nPos .AND. ;
                //                 6 + ( nMenu * 3 ) == aMenuGeral[ nCt ][ 4 ]

                // nPosAntiga:= nPos
                /* Pega as posicoes: Coordenadas */
                If nRowIni == 0
                   nRowIni:= aMenuPosicao[ AScan( aMenuPosicao, {|x| Alltrim( x[3] ) == Left( AllTrim( aMenuGeral[ nCt ][ 1 ] ), Len( Alltrim( aMenuGeral[ nCt ][ 1 ] ) ) - 3 ) } ) ][ 1 ]
                   nColIni:= aMenuPosicao[ AScan( aMenuPosicao, {|x| Alltrim( x[3] ) == Left( AllTrim( aMenuGeral[ nCt ][ 1 ] ), Len( AllTrim( aMenuGeral[ nCt ][ 1 ] ) ) - 3 ) } ) ][ 2 ]
                   nLin:= nRowIni
                   nCol:= nColIni
                EndIf

                /* Adiciona no Array de menu */
                AAdd( aList, { nLin++, nCol, MENUOPCAO, MENUMENSAGEM, MENUFUNCAO } )

                nLenMenu:= Len( MENUOPCAO )

             Endif

          EndIf

      Next

      IF Len( aList ) > 0
         IF nMenu > 0
            /* Adiciona o menu "0> Retorna      " no Array de sub-menus */
            AAdd( aList, { nLin++, nCol, PAD( " 0" + Chr( 16 ) + " Retorna", nLenMenu ) , "Retorna a opcao anterior", "" } )
         ELSE
            /* Adiciona o menu "0> Encerramento " no Array de menu principal */
            AAdd( aList, { nLin++, nCol, PAD( " 0" + Chr( 16 ) + " Encerramento", nLenMenu ) , "Finaliza o sistema", "" } )
         ENDIF
      ENDIF        

      // Somente para depuracao 
      //@ 00,10 Say "Menu     " + Str( nMenu )
      //@ 01,10 Say "Opcao    " + Pad( cOpcao, 20 )
      //@ 02,10 Say "aLista    " + Str( Len( aList ) )
      //@ 03,10 Say "Pos      " + Str( nPos )

      If Empty( aList )
         @ 23,00 Say PADC( "Este modulo ainda nao esta disponivel.", 80 )
         inkey(0)
         nMenu:= ( nMenu - 1 )
         cOpcao:= Left( cOpcao, Len( cOpcao )-3 )
         Loop
      ELSE
         IF LEN( aList ) <= 0
            QUIT
         ENDIF
      EndIf

      /* Determina as coordenadas inferiores */
      nRowEnd:= nRowIni + Len( aList ) + 1
      nColEnd:= nColIni + Len( aList[ 1 ][ 3 ] ) + 1

      DispBegin()

      /* Exibicao do box */
      // Scroll( nRowIni, nColIni, nRowEnd, nColEnd  )
      // DispBox( nRowIni, nColIni, nRowEnd, nColEnd )
      SetColor( Cor )
      Scroll( nRowIni, nColIni, nRowEnd, nColEnd  )
      @ nRowIni, nColIni TO nRowEnd, nColEnd

      If nMenu == 0
         aTela[ 1 ]:= SaveScreen( 0, 0, 24, MaxCol() )
      Else
         If nMenu + 1 > Len( aTela )
            AAdd( aTela, SaveScreen( 0, 0, 24, MaxCol() ) )
         Else
            aTela[ nMenu + 1 ]:= SaveScreen( 0, 0, 24, MaxCol() )
         Endif
      EndIf

      DispEnd()

      /* Rotina para menu */
      nPos:= 1 
      MenuList:= {} 
      For nCt:=1 To Len( aList )

         #ifdef SWMENU

         /**** PROMPT especial da biblioteca swmenu 
                - Fortuna Automacao Comercial - *****/

         /* Criacao do menu de dados */
         AAdd( MenuList, MenuNew( aList[ nCt ][ 1 ] + 1, aList[ nCt ][ 2 ] + 1,;
                                  aList[ nCt ][ 3 ], 2, Cor,;
                                  aList[ nCt ][ 4 ],,, CorRealse, .F. ) )


         #else

            /**** PROMPT convencional do clipper *****/

            AAdd( MenuList, {  aList[ nCt ][ 1 ] + 1, aList[ nCt ][ 2 ] + 1,;
                               aList[ nCt ][ 3 ], 2, Cor,;
                               aList[ nCt ][ 4 ],,, CorRealse, .F. } )

            @ aList[ nCt ][ 1 ] + 1, aList[ nCt ][ 2 ] + 1 PROMPT aList[ nCt ][ 3 ] MESSAGE aList[ nCt ][ 4 ]

         #endif

      Next

      #ifdef SWMENU
        /* Aguarda pela opcao selecionada pelo usu rio */
        MenuModal( MenuList, @nPos)
      #else
        Menu to nPos
      #endif

      IF __swAcao() <> acNil
         IF __swAcao() == acMover
            IF nMenu > 0
                RestScreen( 0, 0, 24, MaxCol(), aTela[ nMenu+1 ] )
            ENDIF
            SWMenuMover( aList, aMenuPosicao, cOpcao )
            nRowIni:= 0
            Loop
         ENDIF
      ELSE
          If nPos==0 .OR. nPos==Len( MenuList )
             If nMenu == 0
                Quit
             Endif
             nRowIni:= 0
             nPos:= nPosAntiga //- 1
             /* Restaura a tela anterior */
             RestScreen( 0, 0, 24, MaxCol(), aTela[ nMenu ] )
             // Retrocede em um nivel o menu
             --nMenu
             IF nMenu == 0
                cOpcao:= "000."
             ELSE
                cOpcao:= Left( cOpcao, Len( cOpcao )-3 )
             ENDIF
             nRowIni:= 0  /// valmor
             Loop
          EndIf
          /* Localiza o menu na aLista geral */

          /* Se tiver o que executar, ser  executado */
          If !Empty( aList[ nPos ][ 5 ] )
             If( LastKey() <> 27, Execute( aList[ nPos ][ 5 ] ), Nil )
             nRowIni:= 0
             nPosAntiga:= nPos
          Else
             nRowIni:= 0
             ++nMenu
             cOpcao:= cOpcao + StrZero( nPos, 2, 0 ) + "."
             nPosAntiga:= nPos
          Endif
      ENDIF

   EndDo

   Return Nil


Static Function Execute( cFuncao )
Local Rt
Private cFun:= cFuncao
   If !Empty( cFuncao )
      Rt:= Eval( {|| &cFun }  )
   Endif
   Release cFun
   Return Rt


Static Function Posicao( cStringNormal, cString, nPos )
Local nPosicao
   If nPos == 1        ; nPosicao:= Val( SubStr( cStringNormal, At( "[", cString ) + 1, At( ",", cString ) - At( "[", cString ) - 1 ) )
   ElseIf nPos == 2    ; nPosicao:= Val( SubStr( cStringNormal, At( ",", cString ) + 1, At( "]", cString ) - At( ",", cString ) - 1 ) )
   EndIf
Return( nPosicao )

Function FileArray( cFile )
#define CRLF   CHR(13)+CHR(10)
Local lFlag:=.t., cTexto, aTexto:= {}, FinalLinha
   cTexto:= MemoRead( cFile )
   While lFlag
      FinalLinha := AT( CRLF, cTEXTO )
      AAdd( aTexto, SubStr( cTexto, 1 , FinalLinha-1 ) )
      cTexto:= Substr( cTexto, FinalLinha+2 )
      If Empty( cTexto )
         lFlag := .f.
      Endif
   EndDo
Return( aTexto )


// Efetuar a movimentacao do menu com setas de direcao
Function SWMenuMover( aList, aMenuPosicao, cOpcao )
Local i, cTela:= saveScreen( 0, 0, 24, 79 )
Local nRow:= 0, nCol:= 0, nPosicao:= 0
Local nRowIni, nColIni, nRowEnd, nColEnd


    FOR i:= 1 TO LEN( aMenuPosicao )
        IF aMenuPosicao[ i ][ 3 ] == cOpcao .OR.;
           aMenuPosicao[ i ][ 3 ] == Left( cOpcao, Len( cOpcao )-1 ) // Descartando o ponto
           nPosicao:= i
        ENDIF
    NEXT
    @ 24,00 say " >>>> Menu <<<< "
    WHILE .T.

       DispBegin()
       RestScreen( 0, 0, 24, 79, cTela )

       IF nPosicao > 0
          @ 24,00 say "Coordenadas: [" +  StrZero( aMenuPosicao[ nPosicao ][ 1 ], 04, 00 ) + "," + ;
                                          StrZero( aMenuPosicao[ nPosicao ][ 2 ], 04, 00 ) + "]"
       ENDIF

       nRowIni:= aList[1][1]
       nColIni:= aList[1][2]
       nRowEnd:= nRowIni + Len( aList ) + 1
       nColEnd:= nColIni + Len( aList[ 1 ][ 3 ] ) + 1

       Scroll( nRowIni, nColIni, nRowEnd, nColEnd  )
       @ nRowIni, nColIni TO nRowEnd, nColEnd

       FOR i:= 1 TO LEN( aList )
          @ aList[i][1]+1, aList[i][2]+1 Say aList[i][3]
       NEXT 
       DispEnd()
       inkey(0)

       nRow:= 0
       nCol:= 0
       IF LastKey() == K_LEFT
          nCol:= -1
       ELSEIF LastKey() == K_RIGHT
          nCol:= +1
       ELSEIF LastKey() == K_UP
          nRow:= -1
       ELSEIF LastKey() == K_DOWN
          nRow:= +1
       ELSEIF LastKey() == K_HOME
          __swAcao( "" )
          @ 00,00 say "                                "
          Return Nil
       ENDIF
       IF aList <> Nil
          FOR i:= 1 TO LEN( aList )
             aList[i][1]:= aList[i][1]+nRow
             aList[i][2]:= aList[i][2]+nCol
          NEXT
       ENDIF

       //
       // Se posicao esta ok, troca as coordenadas incrementando
       //
       IF nPosicao > 0
          aMenuPosicao[ nPosicao ][ 1 ]:= aMenuPosicao[ nPosicao ][ 1 ] + nRow
          aMenuPosicao[ nPosicao ][ 2 ]:= aMenuPosicao[ nPosicao ][ 2 ] + nCol
       ENDIF

    ENDDO
    Return Nil



Function SWMenuOpcaoEdita( aMenu, aMenuGeral )

Function SWMenuGravar( aMenu, aMenuGeral )




// Ativar a flag de movimentacao
Static Function __swMover()
   __swAcao( "MOVER" )

// Ativar a flag de gravacao
Static Function __swGravar()
   __swAcao( "GRAVAR" )

// Ativar a flag de nil
Static Function __swNil()
   __swAcao( "" )

// Testar a acao 
Static Function __swAcao( cAcao )
Static AcaoMover
Static AcaoGravar
if cAcao == nil
   if AcaoMover <> Nil
      if AcaoMover
         Return acMover
      endif
   endif
   if AcaoGravar <> Nil
      if AcaoGravar
         Return acGravar
      endif
   endif 
else
   if cAcao == ""
      AcaoMover:= Nil
      AcaoGravar:= Nil
   else
      if cAcao == "MOVER"
         AcaoMover:= .T.
         AcaoGravar:= .F.
      endif
      if cAcao == "GRAVAR"
         AcaoGravar:= .T.
         AcaoMover:= .F.
      endif
      keyboard chr( K_ENTER )
   endif
endif
Return acNil


