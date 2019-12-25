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
function config00()


Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      nRow:= 1, oTab, cOldBack:= "",; 
      lDelimiters:= Set(_SET_DELIMITERS,.F.), cCampo 
 
      cCampo:= MemoRead( "FUNDO.SYS" ) 
      aMatrizPrincipal:= IOFillText( cCampo ) 
 
      aMatriz:= {} 
      FOR nCt:= 1 TO Len( aMatrizPrincipal ) 
          AADD( aMatriz, {  SubStr( aMatrizPrincipal[ nCt ], 1, 24 ), SubStr( aMatrizPrincipal[ nCt ], 25 ) } ) 
      NEXT 
 
SetColor( COR[20] ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
vpbox(01,01,15,77,"Configura��o do Papel de Parede",COR[20],.T.,.T.,COR[19]) 
vpbox(16,01,21,77,"Exibi��o",COR[20],.T.,.T.,COR[19]) 
oTAB:=tbrowsenew(02,02,14,76) 
oTAB:addcolumn(tbcolumnnew(,{|| PAD( aMatriz[nROW][1], 24 )+" "+PAD( aMatriz[nROW][2],60 )})) 
oTAB:AUTOLITE:=.f. 
oTAB:GOTOPBLOCK :={|| nROW:=1} 
oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aMatriz)} 
oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aMatriz,@nROW)} 
oTAB:dehilite() 
Ajuda("[ESC]Retorna") 
whil .t. 
   Mensagem( "[" + _SETAS + "]Move [DEL]Apaga [INS]Nova [ENTER]Seleciona [ESC]Finaliza" ) 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
   whil nextkey()==0 .and. ! oTAB:stabilize() 
   end 
   VPFundoFrase( 17, 02, 20, 76, ALLTRIM( aMatriz[nRow][2] ) ) 
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
           AAdd( aMatriz, { Space( 24 ), Space( 50 ) } ) 
           oTab:GoBottom() 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
           oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
           WHILE nextkey()==0 .and. ! oTAB:stabilize() 
           ENDDO 
           @ oTab:RowPos + 1, 3 Get aMatriz[ nRow ][ 1 ] When Mensagem( "Digite o titulo para o fundo" ) 
           @ oTab:RowPos + 1, 27 Get aMatriz[ nRow ][ 2 ] Pict "@S30" When Mensagem( "Digite o fundo" ) 
           Read 
           aMatriz[ nRow ][ 1 ]:= Space( 1 ) + aMatriz[ nRow ][ 1 ] 
      case TECLA==K_ENTER 
           SCREENBACK:= Alltrim( aMatriz[nROW][2] ) 
           cCampo:= MEMOREAD( "REPORT\CONFIG.INI" ) 
           aMatriz2:= IOFillText( cCampo ) 
           Set( 24, "REPORT\CONFIG.INI" ) 
           Set( _SET_DEVICE, "PRINTER" ) 
           Set( _SET_PRINTER, .T. ) 
           FOR nCt:= 1 TO Len( aMatriz2 ) 
               IF At( "SCREENBACK", UPPER( aMatriz2[nCt] ) ) > 0 
                  aMatriz2[ nCt ]:= [ScreenBack:= "]+Alltrim( aMatriz[nRow][2] ) + ["] 
               ENDIF 
               @ Prow(),Pcol() Say aMatriz2[ nCt ] + Chr( 13 ) + Chr( 10 ) 
           NEXT 
           XConfig:= .T. 
           Set Device To Screen 
           Set( 24, "LPT1" ) 
           EXIT 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
end 
Set( 24, "FUNDO.SYS" ) 
Set( _SET_DEVICE, "PRINTER" ) 
Set( _SET_PRINTER, .T. ) 
FOR nCt:= 1 TO Len( aMatriz ) 
   IF aMatriz[ nCt ][ 1 ] <> "EXCLUIDA" 
      @ Prow(),Pcol() Say aMatriz[ nCt ][ 1 ] + aMatriz[ nCt ][ 2 ] + Chr( 13 ) + Chr( 10 ) 
   ENDIF 
NEXT 
Set Device To Screen 
Set( 24, "LPT1" ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Set(_SET_DELIMITERS, lDelimiters ) 
Return Nil 
