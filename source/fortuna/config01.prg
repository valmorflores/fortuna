// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
#ifdef HARBOUR
function config01()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      nRow:= 1, oTab, cOldBack:= "",; 
      lDelimiters:= Set(_SET_DELIMITERS,.F.), cCampo 
 
      cCampo:= MemoRead( "MENSAGEM.SYS" ) 
      aMatrizPrincipal:= IOFillText( cCampo ) 
 
      aMatriz:= {} 
      FOR nCt:= 1 TO Len( aMatrizPrincipal ) 
          AADD( aMatriz, { SubStr( aMatrizPrincipal[ nCt ], 1, 30 ), SubStr( aMatrizPrincipal[ nCt ], 31 ) + Space( 30 ) } ) 
      NEXT 
      SetColor( COR[20] ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      UserScreen() 
      vpbox(01,01,21,77,"Configuracao de Mensagens",COR[20],.T.,.T.,COR[19]) 
      oTAB:=tbrowsenew(02,02,20,76) 
      oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[nROW][1]+" "+aMatriz[nROW][2]})) 
      oTAB:AUTOLITE:=.f. 
      oTAB:GOTOPBLOCK :={|| nROW:=1} 
      oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aMatriz)} 
      oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aMatriz,@nROW)} 
      oTAB:dehilite() 
      Ajuda("[ESC]Retorna") 
      whil .t. 
         Mensagem( "[" + _SETAS + "]Move [DEL]Apaga [INS]Nova [Enter]Altera [ESC]Finaliza" ) 
         oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
         whil nextkey()==0 .and. ! oTAB:stabilize() 
         end 
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
            case TECLA==K_DEL 
                 aMatriz[ nRow ][ 1 ]:= "EXCLUIDA" 
                 aMatriz[ nRow ][ 2 ]:= Space( 40 ) 
            case TECLA==K_INS 
                 AAdd( aMatriz, { Space( 30 ), Space( 70 ) } ) 
                 oTab:GoBottom() 
                 oTAB:refreshcurrent() 
                 oTAB:stabilize() 
                 oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
                 WHILE nextkey()==0 .and. ! oTAB:stabilize() 
                 ENDDO 
                 @ oTab:RowPos + 1, 2 Get aMatriz[ nRow ][ 1 ] When Mensagem( "Digite o titulo para a mensagem." ) 
                 @ oTab:RowPos + 1, 33 Get aMatriz[ nRow ][ 2 ] Pict "@S44" When Mensagem( "Digite a mensagem." ) 
                 Read 
            case TECLA==K_ENTER 
                 @ oTab:RowPos + 1, 2 Get aMatriz[ nRow ][ 1 ] When Mensagem( "Digite o titulo para a mensagem." ) 
                 @ oTab:RowPos + 1, 33 Get aMatriz[ nRow ][ 2 ] Pict "@S44" When Mensagem( "Digite a mensagem." ) 
                 Read 
            otherwise                ;tone(125); tone(300) 
         endcase 
         oTAB:refreshcurrent() 
         oTAB:stabilize() 
      end 
      Set( 24, "MENSAGEM.SYS" ) 
      Set( _SET_DEVICE, "PRINTER" ) 
      Set( _SET_PRINTER, .T. ) 
      For nCt:= 1 TO Len( aMatriz ) 
         IF aMatriz[ nCt ][ 1 ] <> "EXCLUIDA" 
            @ Prow(),00 Say aMatriz[ nCt ][ 1 ] + aMatriz[ nCt ][ 2 ] 
            @ Prow()+1,00 Say "" 
         ENDIF 
      Next 
      Set Device To Screen 
      Set( 24, "LPT1" ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Set(_SET_DELIMITERS, lDelimiters ) 
      Return Nil 
