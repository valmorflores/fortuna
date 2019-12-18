// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ 
³ Finalidade  ³ 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function InsertMensagem() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      nRow:= 1, oTab, cOldBack:= "",; 
      lDelimiters:= Set(_SET_DELIMITERS,.F.), cCampo, aMatriz, aMatrizSecundaria,; 
      aMatrizPrincipal, nPosicaoDoTitulo, nInicio, nFim, lOk, nOpcao, nCt, cMatrizFinal:= Space( 0 ),; 
      nPosicao:= 0 
 
      cCampo:= MemoRead( "MENSAGEM.SYS" ) 
      aMatrizPrincipal:= IOFillText( cCampo ) 
 
      aMatriz:= {} 
      aMatrizSecundaria:= {} 
      nPosicaoDoTitulo:= 0 
      nInicio:= 0 
      nFim:= 0 
 
      /* Transfere informacoes p/ matriz secundaria */ 
      FOR nCt:= 1 TO Len( aMatrizPrincipal ) 
          AADD( aMatrizSecundaria, { Left( aMatrizPrincipal[ nCt ], 30 ), SubStr( aMatrizPrincipal[ nCt ], 31 ), 0, 0 } ) 
      NEXT 
 
      /* Verifica onde comeca e onde termina cada mensagem */ 
      FOR nCt:= 1 TO Len( aMatrizSecundaria ) 
         IF aMatrizSecundaria[ nCt ][ 1 ] <> Space( 30 ) .OR. nCt == Len( aMatrizSecundaria ) 
            IF nPosicaoDoTitulo <> 0 
               nFim:= nCt - 1 
               aMatrizSecunadria[ nPosicaoDoTitulo ][ 3 ]:= nInicio 
               aMatrizSecundaria[ nPosicaoDoTitulo ][ 4 ]:= nFim 
               /* da 2§ em diante */ 
               nPosicaoDoTitulo:= nCt 
               nInicio:= nCt 
            ELSE 
               nPosicaoDoTitulo:= nCt 
               nInicio:= nCt 
            ENDIF 
         ENDIF 
      NEXT 
 
      FOR nCt:= 1 TO Len( aMatrizSecundaria ) 
          IF aMatrizSecundaria[ nCt ][ 1 ] <> Space( 30 ) 
             AAdd( aMatriz, { aMatrizSecundaria[ nCt ][ 1 ], aMatrizSecundaria[ nCt ][ 3 ], aMatrizSecundaria[ nCt ][ 4 ] } ) 
          ENDIF 
      NEXT 
 
      IF Len( aMatriz ) == 0 
         quit 
      ENDIF 
      Ajuda( "[" + _SETAS + "]Move [ENTER]Seleciona [ESC]Finaliza" ) 
      Mensagem( "Pressione ENTER sobre a mensagem selecionada." ) 
      SetColor( "W+/R" ) 
      vpbox(05,20,18,67,"Mensagem - Macros Internas","W+/R",.T.,.T.,"12/15") 
      oTAB:=tbrowsenew(06,21,17,66) 
      oTAB:addcolumn( tbcolumnnew(,{|| aMatriz[ nRow ][ 1 ]+" "+; 
                                     StrZero( aMatriz[nRow][2], 5, 0 ) + " " +; 
                                     StrZero( aMatriz[nRow][3], 5, 0 ) } ) ) 
      oTAB:AUTOLITE:=.f. 
      oTAB:GOTOPBLOCK :={|| nROW:=1} 
      oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aMatriz)} 
      oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aMatriz,@nROW)} 
      oTAB:dehilite() 
      Ajuda("[ESC]Retorna") 
      whil .t. 
 
         oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
         whil nextkey()==0 .and. ! oTAB:stabilize() 
         end 
         lOk:= .F. 
         nOpcao:= 0 
         TECLA:=inkey(0) 
         if TECLA==K_ESC   ;exit   ;endif 
         do case 
            case TECLA==K_UP         ;oTAB:up() 
            case TECLA==K_DOWN       ;oTAB:down() 
            case TECLA==K_LEFT       ;oTAB:up() 
            case TECLA==K_RIGHT      ;oTAB:down() 
            case TECLA==K_PGUP       ;oTAB:pageup() 
            case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
            case TECLA==K_PGDN       ;oTAB:pagedown() 
            case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
            case TECLA==K_ENTER 
                 lOk:= .T. 
                 nOpcao:= nRow 
                 EXIT 
            otherwise                ;tone(125); tone(300) 
         endcase 
         oTAB:refreshcurrent() 
         oTAB:stabilize() 
      end 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Set(_SET_DELIMITERS, lDelimiters ) 
      /* Efetua a Operaca */ 
      IF lOk 
         IF aMatriz[ nOpcao ][ 2 ] <> 0 .AND. aMatriz[ nOpcao ][ 3 ] <> 0 
            FOR nCt:= aMatriz[ nOpcao ][ 2 ] To aMatriz[ nOpcao ][ 3 ] 
                IF ( nPosicao:= AT( "<@>", aMatrizSecundaria[ nCt ][ 2 ] ) ) > 0 
                   cString1:= Alltrim( Left( aMatrizSecundaria[ nCt ][ 2 ], nPosicao - 1 ) ) 
                   cString2:= Alltrim( SubStr( aMatrizSecundaria[ nCt ][ 2 ], nPosicao + 3 ) ) 
                   Keyboard cString1 + CHR( K_ENTER ) + cString2 + CHR( K_ENTER ) 
                ELSE 
                   Keyboard Alltrim( aMatrizSecundaria[ nCt ][ 2 ] ) + CHR( K_ENTER ) 
                ENDIF 
            NEXT 
         ENDIF 
      ENDIF 
      Return Nil 
 
Function Busca99 
    Keyboard "9999999" 
