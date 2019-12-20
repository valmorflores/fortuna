// ## CL2HB.EXE - Converted
#include "inkey.ch" 
#Include "vpf.ch" 

#ifdef HARBOUR
function maximo()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
cArquivo:= MEMOREAD( cFile:= SeekFile() ) 
aArquivo:= StartEdicao( cArquivo ) 
Edit( aArquivo, 0, 0, 22, 79, cFile ) 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � StartEdicao 
� Finalidade  � Inicializa a variavel para a edicao 
� Parametros  � cArquivo = Texto 
� Retorno     � aArquivo = Array 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function StartEdicao( cArquivo ) 
Local aArquivo:= IOFillText( cArquivo ) 
Return aArquivo 
 
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
FUNCTION Edit( aArquivo, nLin1, nCol1, nLin2, nCol2, cNomeFile ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
SetCursor( 0 ) 
 
/* Transforma em particulas de texto */ 
aTexto:= {} 
FOR nLin:= 1 TO Len( aArquivo ) 
    AAdd( aTexto, {} ) 
    nPos:= Len( aTexto ) 
    FOR nCol:= 1 TO Len( aArquivo[ nLin ] ) 
        AAdd( aTexto[ nPos ], SubStr( aArquivo[ nLin ], nCol, 1 ) ) 
    NEXT 
    IF ( nTotal:= Len( aTexto[ nPos ] ) ) < 170 
       FOR nCt2:= 1 To 170 - nTotal 
           AAdd( aTexto[ nPos ], " " ) 
       NEXT 
    ENDIF 
    IF ( AT( "(", aArquivo[ nLin ] ) > 0 .OR.; 
         AT( "/*", aArquivo[ nLin ] ) > 0 .OR.; 
         AT( ":=", aArquivo[ nLin ] ) > 0 ) .AND.; 
           !AT( "�", aArquivo[ nLin ] ) > 0 
         /* Texto que nao devera ser alterado, ou marcado */ 
         aTexto[ nPos ][ 160 ]:= "�" 
         IF AT( "/*", aArquivo[ nLin ] ) > 0 
            aTexto[ nPos ][ 160 ]:= "�"   /* COR AMARELA */ 
         ENDIF 
    ENDIF 
NEXT 
 
  aT:= aTexto 
  x:= 1 
 
  SET DELIMITERS OFF 
  VPBox( nLin1, nCol1, nLin2, nCol2, "SISTEMA GERADOR DE RELATORIOS - EDICAO", _COR_BROW_BOX ) 
  @ nLin2-1,nLin1+1 Say Left( cNomeFile, ( nCol2 - nCol1 ) - 2 ) 
  SetColor( "15/" + SubStr( SetColor(), At( "/", SetColor() ) + 1, 2 ) ) 
  @ nLin2-2,nLin1+1 Say Left( "������������������������������������������������������������������������������", ( nCol2 - nCol1 ) - 2 ) 
  SetColor( "04/15" ) 
  @ nLin2-2,nCol2-30 Say " Soft&Ware Edit System Report " 
  SetColor( COR[8] ) 
  @ 24,00 Say Space( 80 ) 
  Ajuda( "[ESC]Finaliza [Enter]Confirma [F12]Calculadora" ) 
  SetColor( _COR_BROWSE ) 
  aBrowse:= SWBrowseNew( nLin1+1, nCol1+1, nLin2-3, nCol2-1, aT ) 
  AAddColunas( @aBrowse, {|| aT[x][01] } ) 
  AAddColunas( @aBrowse, {|| aT[x][02] } ) 
  AAddColunas( @aBrowse, {|| aT[x][03] } ) 
  AAddColunas( @aBrowse, {|| aT[x][04] } ) 
  AAddColunas( @aBrowse, {|| aT[x][05] } ) 
  AAddColunas( @aBrowse, {|| aT[x][06] } ) 
  AAddColunas( @aBrowse, {|| aT[x][07] } ) 
  AAddColunas( @aBrowse, {|| aT[x][08] } ) 
  AAddColunas( @aBrowse, {|| aT[x][09] } ) 
  AAddColunas( @aBrowse, {|| aT[x][10] } ) 
  AAddColunas( @aBrowse, {|| aT[x][11] } ) 
  AAddColunas( @aBrowse, {|| aT[x][12] } ) 
  AAddColunas( @aBrowse, {|| aT[x][13] } ) 
  AAddColunas( @aBrowse, {|| aT[x][14] } ) 
  AAddColunas( @aBrowse, {|| aT[x][15] } ) 
  AAddColunas( @aBrowse, {|| aT[x][16] } ) 
  AAddColunas( @aBrowse, {|| aT[x][17] } ) 
  AAddColunas( @aBrowse, {|| aT[x][18] } ) 
  AAddColunas( @aBrowse, {|| aT[x][19] } ) 
  AAddColunas( @aBrowse, {|| aT[x][20] } ) 
  AAddColunas( @aBrowse, {|| aT[x][21] } ) 
  AAddColunas( @aBrowse, {|| aT[x][22] } ) 
  AAddColunas( @aBrowse, {|| aT[x][23] } ) 
  AAddColunas( @aBrowse, {|| aT[x][24] } ) 
  AAddColunas( @aBrowse, {|| aT[x][25] } ) 
  AAddColunas( @aBrowse, {|| aT[x][26] } ) 
  AAddColunas( @aBrowse, {|| aT[x][27] } ) 
  AAddColunas( @aBrowse, {|| aT[x][28] } ) 
  AAddColunas( @aBrowse, {|| aT[x][29] } ) 
  AAddColunas( @aBrowse, {|| aT[x][30] } ) 
  AAddColunas( @aBrowse, {|| aT[x][31] } ) 
  AAddColunas( @aBrowse, {|| aT[x][32] } ) 
  AAddColunas( @aBrowse, {|| aT[x][33] } ) 
  AAddColunas( @aBrowse, {|| aT[x][34] } ) 
  AAddColunas( @aBrowse, {|| aT[x][35] } ) 
  AAddColunas( @aBrowse, {|| aT[x][36] } ) 
  AAddColunas( @aBrowse, {|| aT[x][37] } ) 
  AAddColunas( @aBrowse, {|| aT[x][38] } ) 
  AAddColunas( @aBrowse, {|| aT[x][39] } ) 
  AAddColunas( @aBrowse, {|| aT[x][40] } ) 
  AAddColunas( @aBrowse, {|| aT[x][41] } ) 
  AAddColunas( @aBrowse, {|| aT[x][42] } ) 
  AAddColunas( @aBrowse, {|| aT[x][43] } ) 
  AAddColunas( @aBrowse, {|| aT[x][44] } ) 
  AAddColunas( @aBrowse, {|| aT[x][45] } ) 
  AAddColunas( @aBrowse, {|| aT[x][46] } ) 
  AAddColunas( @aBrowse, {|| aT[x][47] } ) 
  AAddColunas( @aBrowse, {|| aT[x][48] } ) 
  AAddColunas( @aBrowse, {|| aT[x][49] } ) 
  AAddColunas( @aBrowse, {|| aT[x][50] } ) 
  AAddColunas( @aBrowse, {|| aT[x][51] } ) 
  AAddColunas( @aBrowse, {|| aT[x][52] } ) 
  AAddColunas( @aBrowse, {|| aT[x][53] } ) 
  AAddColunas( @aBrowse, {|| aT[x][54] } ) 
  AAddColunas( @aBrowse, {|| aT[x][55] } ) 
  AAddColunas( @aBrowse, {|| aT[x][56] } ) 
  AAddColunas( @aBrowse, {|| aT[x][57] } ) 
  AAddColunas( @aBrowse, {|| aT[x][58] } ) 
  AAddColunas( @aBrowse, {|| aT[x][59] } ) 
  AAddColunas( @aBrowse, {|| aT[x][60] } ) 
  AAddColunas( @aBrowse, {|| aT[x][61] } ) 
  AAddColunas( @aBrowse, {|| aT[x][62] } ) 
  AAddColunas( @aBrowse, {|| aT[x][63] } ) 
  AAddColunas( @aBrowse, {|| aT[x][64] } ) 
  AAddColunas( @aBrowse, {|| aT[x][65] } ) 
  AAddColunas( @aBrowse, {|| aT[x][66] } ) 
  AAddColunas( @aBrowse, {|| aT[x][67] } ) 
  AAddColunas( @aBrowse, {|| aT[x][68] } ) 
  AAddColunas( @aBrowse, {|| aT[x][69] } ) 
  AAddColunas( @aBrowse, {|| aT[x][70] } ) 
  AAddColunas( @aBrowse, {|| aT[x][71] } ) 
  AAddColunas( @aBrowse, {|| aT[x][72] } ) 
  AAddColunas( @aBrowse, {|| aT[x][73] } ) 
  AAddColunas( @aBrowse, {|| aT[x][74] } ) 
  AAddColunas( @aBrowse, {|| aT[x][75] } ) 
  AAddColunas( @aBrowse, {|| aT[x][76] } ) 
  AAddColunas( @aBrowse, {|| aT[x][77] } ) 
  AAddColunas( @aBrowse, {|| aT[x][78] } ) 
  AAddColunas( @aBrowse, {|| aT[x][79] } ) 
  AAddColunas( @aBrowse, {|| aT[x][80] } ) 
  AAddColunas( @aBrowse, {|| aT[x][81] } ) 
  AAddColunas( @aBrowse, {|| aT[x][82] } ) 
  AAddColunas( @aBrowse, {|| aT[x][83] } ) 
  AAddColunas( @aBrowse, {|| aT[x][84] } ) 
  AAddColunas( @aBrowse, {|| aT[x][85] } ) 
  AAddColunas( @aBrowse, {|| aT[x][86] } ) 
  AAddColunas( @aBrowse, {|| aT[x][87] } ) 
  AAddColunas( @aBrowse, {|| aT[x][88] } ) 
  AAddColunas( @aBrowse, {|| aT[x][89] } ) 
  AAddColunas( @aBrowse, {|| aT[x][90] } ) 
  AAddColunas( @aBrowse, {|| aT[x][91] } ) 
  AAddColunas( @aBrowse, {|| aT[x][92] } ) 
  AAddColunas( @aBrowse, {|| aT[x][93] } ) 
  AAddColunas( @aBrowse, {|| aT[x][94] } ) 
  AAddColunas( @aBrowse, {|| aT[x][95] } ) 
  AAddColunas( @aBrowse, {|| aT[x][96] } ) 
  AAddColunas( @aBrowse, {|| aT[x][97] } ) 
  AAddColunas( @aBrowse, {|| aT[x][98] } ) 
  AAddColunas( @aBrowse, {|| aT[x][99] } ) 
  AAddColunas( @aBrowse, {|| aT[x][100] } ) 
  AAddColunas( @aBrowse, {|| aT[x][101] } ) 
  AAddColunas( @aBrowse, {|| aT[x][102] } ) 
  AAddColunas( @aBrowse, {|| aT[x][103] } ) 
  AAddColunas( @aBrowse, {|| aT[x][104] } ) 
  AAddColunas( @aBrowse, {|| aT[x][105] } ) 
  AAddColunas( @aBrowse, {|| aT[x][106] } ) 
  AAddColunas( @aBrowse, {|| aT[x][107] } ) 
  AAddColunas( @aBrowse, {|| aT[x][108] } ) 
  AAddColunas( @aBrowse, {|| aT[x][109] } ) 
  AAddColunas( @aBrowse, {|| aT[x][110] } ) 
  AAddColunas( @aBrowse, {|| aT[x][111] } ) 
  AAddColunas( @aBrowse, {|| aT[x][112] } ) 
  AAddColunas( @aBrowse, {|| aT[x][113] } ) 
  AAddColunas( @aBrowse, {|| aT[x][114] } ) 
  AAddColunas( @aBrowse, {|| aT[x][115] } ) 
  AAddColunas( @aBrowse, {|| aT[x][116] } ) 
  AAddColunas( @aBrowse, {|| aT[x][117] } ) 
  AAddColunas( @aBrowse, {|| aT[x][118] } ) 
  AAddColunas( @aBrowse, {|| aT[x][119] } ) 
  AAddColunas( @aBrowse, {|| aT[x][120] } ) 
  AAddColunas( @aBrowse, {|| aT[x][121] } ) 
  AAddColunas( @aBrowse, {|| aT[x][122] } ) 
  AAddColunas( @aBrowse, {|| aT[x][123] } ) 
  AAddColunas( @aBrowse, {|| aT[x][124] } ) 
  AAddColunas( @aBrowse, {|| aT[x][125] } ) 
  AAddColunas( @aBrowse, {|| aT[x][126] } ) 
  AAddColunas( @aBrowse, {|| aT[x][127] } ) 
  AAddColunas( @aBrowse, {|| aT[x][128] } ) 
  AAddColunas( @aBrowse, {|| aT[x][129] } ) 
  AAddColunas( @aBrowse, {|| aT[x][130] } ) 
  AAddColunas( @aBrowse, {|| aT[x][131] } ) 
  AAddColunas( @aBrowse, {|| aT[x][132] } ) 
  AAddColunas( @aBrowse, {|| aT[x][133] } ) 
  AAddColunas( @aBrowse, {|| aT[x][134] } ) 
  AAddColunas( @aBrowse, {|| aT[x][135] } ) 
  AAddColunas( @aBrowse, {|| aT[x][136] } ) 
  AAddColunas( @aBrowse, {|| aT[x][137] } ) 
  AAddColunas( @aBrowse, {|| aT[x][138] } ) 
  AAddColunas( @aBrowse, {|| aT[x][139] } ) 
  AAddColunas( @aBrowse, {|| aT[x][140] } ) 
  AAddColunas( @aBrowse, {|| aT[x][141] } ) 
  AAddColunas( @aBrowse, {|| aT[x][142] } ) 
  AAddColunas( @aBrowse, {|| aT[x][143] } ) 
  AAddColunas( @aBrowse, {|| aT[x][144] } ) 
  AAddColunas( @aBrowse, {|| aT[x][145] } ) 
  AAddColunas( @aBrowse, {|| aT[x][146] } ) 
  AAddColunas( @aBrowse, {|| aT[x][147] } ) 
  AAddColunas( @aBrowse, {|| aT[x][148] } ) 
  AAddColunas( @aBrowse, {|| aT[x][149] } ) 
  AAddColunas( @aBrowse, {|| aT[x][150] } ) 
  AAddColunas( @aBrowse, {|| aT[x][151] } ) 
  AAddColunas( @aBrowse, {|| aT[x][152] } ) 
  AAddColunas( @aBrowse, {|| aT[x][153] } ) 
  AAddColunas( @aBrowse, {|| aT[x][154] } ) 
  AAddColunas( @aBrowse, {|| aT[x][155] } ) 
  AAddColunas( @aBrowse, {|| aT[x][156] } ) 
  AAddColunas( @aBrowse, {|| aT[x][157] } ) 
  AAddColunas( @aBrowse, {|| aT[x][158] } ) 
  AAddColunas( @aBrowse, {|| aT[x][159] } ) 
  AAddColunas( @aBrowse, {|| aT[x][160] } ) 
  Restart( aBrowse, @x ) 
  WHILE .T. 
       DisplayCurrent( aBrowse ) 
       IF ( nTecla:= Inkey(0) ) == K_ESC 
          IF SalvarArquivo( aT, cNomeFile ) 
             Exit 
          ENDIF 
       ENDIF 
 
       DesfazCurrent( aBrowse ) 
       DO CASE 
          CASE nTecla == K_RIGHT 
               SWRight( aBrowse, @x ) 
 
          CASE nTecla == K_LEFT 
               SWLeft( aBrowse, @x ) 
 
          CASE nTecla == K_UP 
               SWUp( aBrowse, @x ) 
 
          CASE nTecla == K_DOWN 
               SWDown( aBrowse, @x ) 
 
          CASE nTecla == K_PGDN 
               SWPgDn( aBrowse, @x ) 
 
          CASE Upper( Chr( nTecla ) ) $ "+><��0123456789!@#$%^&*()_+|\=-0`~/.,M:?;'ABCDEFGHIJKLMNOPQRSTUVXYZW{}[] ���/*-+" .or.;  
               Chr( nTecla ) == '"' 
 
               IF aT[ x ][ ColPos( aBrowse ) ] $ "��" .OR.; 
                  aT[ x ][ 160 ] == "�" .OR.; 
                  aT[ x ][ 1 ] == ":" 
               ELSE 
                  cTecla:= Chr( nTecla ) 
                  Keyboard Chr( K_ENTER ) 
                  @ Row(), Col() - 1 Get cTecla 
                  READ 
                  aT[ x ][ ColPos( aBrowse ) ]:= cTecla 
                  SWRight( aBrowse, @x ) 
               ENDIF 
 
          CASE nTecla == K_BS 
               SWLeft( aBrowse, @x ) 
               aT[ x ][ ColPos( aBrowse ) ]:= " " 
               DesfazCurrent( aBrowse ) 
 
          CASE nTecla == K_F12 
               Calculador() 
 
          CASE nTecla == K_ENTER 
               SWDown( aBrowse, @x ) 
               SWInsert( aT, aBrowse, @x ) 
               SWHomeLine( aBrowse, @x ) 
 
          CASE nTecla == K_PGUP 
               SWPgUp( aBrowse, @x ) 
 
          CASE nTecla == K_CTRL_LEFT 
               DesfazCurrent( aBrowse ) 
               SWLeft( aBrowse ) 
               IF aT[ x ][ ColPos( aBrowse ) ] == " " 
                  WHILE aT[ x ][ ColPos( aBrowse ) ] == " " .AND.; 
                      ColPos( aBrowse ) > 1 
                      SWLeft( aBrowse, @x ) 
                  ENDDO 
               ELSE 
                  WHILE !aT[ x ][ ColPos( aBrowse ) ] == " " .AND.; 
                      ColPos( aBrowse ) > 1 
                      SWLeft( aBrowse, @x ) 
                  ENDDO 
               ENDIF 
               DisplayCurrent( aBrowse ) 
 
          CASE nTecla == K_HOME 
               SWHomeLine( aBrowse, @x ) 
 
          CASE nTecla == K_CTRL_Y 
               SWDelete( aT, aBrowse, @x ) 
 
          CASE nTecla == K_F4 
               SWEscreve( aBrowse, VisualVariaveis(), @x, aT ) 
 
          CASE nTecla == K_F5 
               Desenhos( aT, aBrowse, @x ) 
 
          CASE nTecla == K_F10 
               ViewComandos( aT ) 
 
          CASE nTecla == K_F9 
               Preview( aT ) 
 
          CASE nTecla == K_CTRL_U 
               SWUndo( aT, aBrowse, @x ) 
 
          CASE nTecla == K_DEL 
               SWDeleChar( aT, aBrowse, @x ) 
 
          CASE nTecla == K_END 
               SWEndLine( aBrowse, @x ) 
 
          CASE nTecla == K_CTRL_RIGHT 
               DesfazCurrent( aBrowse ) 
               IF ColPos( aBrowse ) < Len( aT[ x ] ) - 30 
                  SWRight( aBrowse, @x ) 
               ENDIF 
               IF aT[ x ][ ColPos( aBrowse ) ] == " " 
                  WHILE aT[ x ][ ColPos( aBrowse ) ] == " " .AND.; 
                      ColPos( aBrowse ) < Len( aT[ x ] ) - 30 
                      SWRight( aBrowse, @x ) 
                  ENDDO 
               ELSE 
                  WHILE !aT[ x ][ ColPos( aBrowse ) ] == " " .AND.; 
                      ColPos( aBrowse ) < Len( aT[ x ] ) - 30 
                      SWRight( aBrowse, @x ) 
                  ENDDO 
               ENDIF 
               DisplayCurrent( aBrowse ) 
 
       ENDCASE 
       IF aT[ x ][ ColPos( aBrowse ) ] $ "�" .OR.; 
          aT[ x ][ 1 ] == ":" .OR.; 
          aT[ x ][ 1 ] + aT[ x ][ 2 ] == "/*" 
 
          DesfazCurrent( aBrowse ) 
          IF aT[ x ][ 1 ]=="/" 
             SetColor( "14/01" ) 
             nPos:= ColPos( aBrowse ) 
          ELSEIF aT[ x ][ 1 ] == ":" 
             SetColor( "15/04" ) 
             nPos:= 1 
             @ Row(), ColIni( aBrowse ) + 1 Say Space(0) 
          ELSE 
             SetColor( "01/15" ) 
             nPos:= ColPos( aBrowse ) 
          ENDIF 
          cString:= "" 
          WHILE ! aT[ x ][ nPos ] == "�" 
             cString:= cString + aT[ x ][ nPos ] 
             ++nPos 
             IF nPos > Len( aT[ x ] ) 
                --nPos 
                EXIT 
             ENDIF 
          ENDDO 
          cString:= cString + "�" 
          @ ( nRowRes:= Row() ), ( nColRes:= Col()-1 ) Say Left( cString, ColFim( aBrowse ) - nColRes + 1 ) 
          SetColor( "15/01" ) 
          Inkey(0) 
          IF LastKey() == K_DEL .AND.; 
             !aT[ x ][ 1 ] == ":" 
             SWEscreve( aBrowse, Space( Len( cString ) ), @x, aT ) 
          ELSEIF LastKey() == K_ENTER .AND.; 
             !aT[ x ][ 1 ] == ":" 
             MoveString( aBrowse, cString, @x, aT ) 
          ELSE 
             Keyboard Chr( LastKey() ) 
             @ Row(), nColRes Say Left( cString, ColFim( aBrowse ) - nColRes + 1 ) 
          ENDIF 
       ENDIF 
  ENDDO 
  SET DELIMITERS ON 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
Function SWBrowseNew( nLin1, nCol1, nLin2, nCol2, aMatriz ) 
LinhaScroll( 1 ) 
ColunaScroll( 1 ) 
SetColor( "15/01" ) 
Scroll( nLin1, nCol1, nLin2, nCol2 ) 
@ nLin1, nCol1 Say Space(0) 
Return aArray:= { nLin1, nCol1, nLin2, nCol2, Row(), Col(), {}, 0, 0, Len( aMatriz ) } 
 
Function AAddColunas( aBrowse, aColunas ) 
AAdd( aBrowse[7], aColunas ) 
 
Function DisplayBrowse( aBrowse, nRow ) 
Local nRowInicial:= nRow 
Local x, nLin:= aBrowse[1], nCol:= aBrowse[2] 
//nRow:= aBrowse[8] 
DispBegin() 
Scroll( aBrowse[1], aBrowse[2], aBrowse[3], aBrowse[4] ) 
nRow:= LinhaScroll() 
nIniColuna:= ColunaScroll() 
FOR nCt2:= 1 TO aBrowse[3] 
   If nRow <= aBrowse[10] 
      IF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "11/01" ) 
      ELSEIF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "14/01" ) 
      ELSE 
         SetColor( "15/01" ) 
      ENDIF 
   Endif 
   FOR nCt:= nIniColuna TO Len( aBrowse[7] ) 
       IF nRow <= aBrowse[ 10 ] 
          x:= Eval( aBrowse[7][ nCt ] ) 
          IF nLin > aBrowse[3] 
             Exit 
          ENDIF 
          @ nLin, nCol Say x 
          IF ++nCol >= aBrowse[4] .OR. nCol >= Len( aBrowse[7] ) 
             nRow:=  nRow + 1 
             nLin:=  nLin + 1 
             nCol:=  aBrowse[2] 
             Exit 
          ENDIF 
       ENDIF 
   NEXT 
NEXT 
DispEnd() 
nRow:= nRowInicial 
 
Function DisplayColuna( aBrowse, nRow, nColuna ) 
Local nRowInicial:= nRow 
Local x, nLin:= aBrowse[1], nCol:= nColuna 
//nRow:= aBrowse[8] 
DispBegin() 
nRow:= LinhaScroll() 
FOR nCt2:= 1 TO aBrowse[3] 
   If nRow <= aBrowse[10] 
      IF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "11/01" ) 
      ELSEIF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "14/01" ) 
      ELSE 
         SetColor( "15/01" ) 
      ENDIF 
   Endif 
   IF nRow <= aBrowse[ 10 ] 
      x:= Eval( aBrowse[7][ ColPos( aBrowse ) ] ) 
      IF nLin > aBrowse[3] 
         Exit 
      ENDIF 
      @ nLin, nCol Say x 
      nRow:=  nRow + 1 
      nLin:= nLin + 1 
   ENDIF 
NEXT 
DispEnd() 
nRow:= nRowInicial 
 
 
 
 
Function DisplayLinha( aBrowse, nRow ) 
Local nRowInicial:= nRow 
Local x, nLin:= Row(), nCol:= aBrowse[2] 
DispBegin() 
Scroll( nLin, aBrowse[2], nLin, aBrowse[4] ) 
//nRow:= LinhaScroll() 
nIniColuna:= ColunaScroll() 
   If nRow <= aBrowse[10] 
      IF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "11/01" ) 
      ELSEIF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "14/01" ) 
      ELSE 
         SetColor( "15/01" ) 
      ENDIF 
   Endif 
   FOR nCt:= nIniColuna TO Len( aBrowse[7] ) 
       IF nRow <= aBrowse[ 10 ] 
          x:= Eval( aBrowse[7][ nCt ] ) 
          @ nLin, nCol Say x 
          IF ++nCol >= aBrowse[4] .OR. nCol >= Len( aBrowse[7] ) 
             Exit 
          ENDIF 
       ENDIF 
   NEXT 
DispEnd() 
nRow:= nRowInicial 
 
 
Function LinhaScroll( nLinha ) 
Static nScroll 
IF nLinha <> Nil 
   nScroll:= nLinha 
ELSE 
   Return nScroll 
ENDIF 
 
 
Function ColunaScroll( nColuna ) 
Static nScrollCol 
IF nColuna <> Nil 
   nScrollCol:= nColuna 
ELSE 
   Return nScrollCol 
ENDIF 
 
Function Restart( aBrowse, nRow ) 
aBrowse[8]:= 1 
aBrowse[9]:= 1 
nRow:= 1 
DisplayBrowse( aBrowse, @x ) 
 
 
Function DisplayCurrent( aBrowse ) 
Local cCor:= SetColor() 
Local x 
  IF aBrowse[9] + ColunaScroll() <= Len( aBrowse[7] ) 
     x:= Eval( aBrowse[7][ aBrowse[9] + ColunaScroll() ] ) 
     SetColor( "01/15" ) 
     @ aBrowse[1] + aBrowse[8] - 1, aBrowse[2] + aBrowse[9] Say x 
     SetColor( cCor ) 
  ENDIF 
  Return Nil 
 
 
Function DesfazCurrent( aBrowse ) 
Local cCor:= SetColor() 
Local x 
  IF aBrowse[9] + ColunaScroll() <= Len( aBrowse[7] ) 
     x:= Eval( aBrowse[7][ aBrowse[9] + ColunaScroll() ] ) 
     IF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
        SetColor( "11/01" ) 
     ELSEIF Eval( aBrowse[ 7 ][ 160 ] ) == "�" 
         SetColor( "14/01" ) 
     ELSE 
        SetColor( "15/01" ) 
     ENDIF 
     @ aBrowse[1] + aBrowse[8] - 1, aBrowse[2] + aBrowse[9] Say x 
  ENDIF 
  Return Nil 
 
Function SWDown( aBrowse, nRow ) 
  IF nRow + 1 <= aBrowse[10] 
     aBrowse[8]:= aBrowse[8] + 1 
     nRow:= nRow + 1 
     IF aBrowse[8] + aBrowse[1] > aBrowse[3] + 1 
        LinhaScroll( LinhaScroll() + 1 ) 
        aBrowse[8]:= aBrowse[8] - 1 
        Scroll( aBrowse[1], aBrowse[2], aBrowse[3], aBrowse[4], 1 ) 
        DisplayLinha( aBrowse, @nRow ) 
     ENDIF 
  ENDIF 
 
Function SWLeft( aBrowse, nRow ) 
   IF aBrowse[9] > 0 
      aBrowse[9]:= aBrowse[9] - 1 
   ELSEIF ColunaScroll() > 1 
         ColunaScroll( ColunaScroll() - 1 ) 
         DesfazCurrent( aBrowse ) 
         Scroll( aBrowse[1], aBrowse[2], aBrowse[3], aBrowse[4], , -1 ) 
         DisplayColuna( aBrowse, @nRow, ColIni( aBrowse ) ) 
         aBrowse[9]:= aBrowse[9] + 1 
   ENDIF 
 
 
Function SWRight( aBrowse, nRow ) 
  IF aBrowse[9] + ColunaScroll() + 1 < 160 
     aBrowse[9]:= aBrowse[9] + 1 
     IF aBrowse[9] + aBrowse[2] > aBrowse[4] 
        ColunaScroll( ColunaScroll() + 1 ) 
        aBrowse[9]:= aBrowse[9] - 1 
        Scroll( aBrowse[1], aBrowse[2], aBrowse[3], aBrowse[4], , 1 ) 
        DisplayColuna( aBrowse, @nRow, ColFim( aBrowse ) ) 
     ENDIF 
  ENDIF 
 
 
Function SWUp( aBrowse, nRow ) 
  IF nRow > 1 
     aBrowse[8]:= aBrowse[8] - 1 
     nRow:= nRow - 1 
     IF aBrowse[8] + aBrowse[1] <= aBrowse[1] 
        LinhaScroll( LinhaScroll() - 1 ) 
        aBrowse[8]:= aBrowse[8] + 1 
        Scroll( aBrowse[1], aBrowse[2], aBrowse[3], aBrowse[4], -1 ) 
        DisplayLinha( aBrowse, @nRow ) 
     ENDIF 
  ENDIF 
 
Function SWPgDn( aBrowse, nRow ) 
     nDown:= ( aBrowse[3] - aBrowse[1] ) 
     IF nRow + nDown < aBrowse[10] 
        IF LinhaScroll() + nDown > aBrowse[10] 
           nRow:= aBrowse[10] 
           LinhaScroll( aBrowse[10] - nDown ) 
           DisplayBrowse( aBrowse, @nRow ) 
        ELSE 
           aBrowse[8]:= aBrowse[8] 
           nRow:= nRow + nDown 
           LinhaScroll( LinhaScroll() + nDown ) 
           DisplayBrowse( aBrowse, @nRow ) 
        ENDIF 
     ENDIF 
 
 
Function SWPgUp( aBrowse, nRow ) 
     nUp:= ( aBrowse[3] - aBrowse[1] ) 
     IF nRow > 1 
        IF nRow - nUp <= 1 
           nRow:= 1 
           aBrowse[8]:= 1 
           LinhaScroll( 1 ) 
           DisplayBrowse( aBrowse, @nRow ) 
        ELSE 
           aBrowse[8]:= aBrowse[8] 
           nRow:= nRow - nUp 
           LinhaScroll( LinhaScroll() - nUp ) 
           If LinhaScroll() < 1 
              LinhaScroll( 1 ) 
              aBrowse[8]:= 1 
              nRow:= 1 
           Endif 
           DisplayBrowse( aBrowse, @nRow ) 
        ENDIF 
     ENDIF 
 
Function ColPos( aBrowse ) 
   Return aBrowse[9] + ColunaScroll() 
 
Function SWHomeLine( aBrowse, nRow ) 
   aBrowse[9]:= 0 
   IF ColunaScroll() > 1 
      ColunaScroll( 1 ) 
      DisplayBrowse( aBrowse, @nRow ) 
   ENDIF 
 
Function ColFim( aBrowse ) 
Return aBrowse[4] 
 
Function ColIni( aBrowse ) 
Return aBrowse[2] 
 
Function SWInsert( aArray, aBrowse, nRow ) 
/* Adiciona um elemento Nil ao final */ 
AAdd( aArray, {} ) 
AIns( aArray, nRow ) 
aArray[nRow]:= {} 
For nCt:= 1 To 170 
    AAdd( aArray[nRow], " " ) 
Next 
aBrowse[10]:= aBrowse[10] + 1 
DisplayBrowse( aBrowse, @nRow ) 
Return Nil 
 
Function SWDelete( aArray, aBrowse, nRow ) 
IF aBrowse[10] > 1 
   /* Adiciona um elemento Nil ao final */ 
   SWUndo( aArray, aBrowse, @nRow, aArray[ nRow ] ) 
   ADel( aArray, nRow ) 
   ASize( aArray, Len( aArray ) - 1 ) 
   aBrowse[10]:= aBrowse[10] - 1 
   IF nRow > aBrowse[10] 
      SWUp( aBrowse, @nRow ) 
   ENDIF 
   DisplayBrowse( aBrowse, @nRow ) 
ENDIF 
Return Nil 
 
Function SWUndo( aArray, aBrowse, nRow, aArrayUndo ) 
Static aUndo 
IF aArrayUndo == Nil 
   IF !aUndo == Nil 
      SWInsert( aArray, aBrowse, @nRow ) 
      aArray[ nRow ]:= aUndo 
      DisplayBrowse( aBrowse, @nRow ) 
   ENDIF 
ELSE 
   aUndo:= aArrayUndo 
ENDIF 
 
 
Function SWDeleChar( aArray, aBrowse, nRow ) 
ADel( aArray[nRow], ColPos( aBrowse ) ) 
aArray[nRow][ Len( aArray[ nRow ] ) ]:= " " 
DisplayBrowse( aBrowse, @nRow ) 
 
 
Function SWEndLine( aBrowse, nRow ) 
   aBrowse[9]:= aBrowse[9] + 20 
   IF aBrowse[2] + aBrowse[9] > aBrowse[4] 
      nDif:= aBrowse[2] + aBrowse[9] - aBrowse[4] 
      aBrowse[9]:= aBrowse[4] - aBrowse[2] 
      ColunaScroll( nDif ) 
      DisplayBrowse( aBrowse, @nRow ) 
   ENDIF 
 
 
Function SWEscreve( aBrowse, cString, nRow, aArray ) 
Local nCont:= 0 
   IF !cString == Nil 
      IF Len( cString ) == 1 
         aArray[ nRow ][ ColPos( aBrowse ) ]:= cString 
      ELSE 
         FOR nCt:= ColPos( aBRowse ) TO ColPos( aBrowse ) + Len( cString ) 
             IF nCt <= Len( aArray[ nRow ] ) .AND. nCt >= 1 
                aArray[ nRow ][ nCt ]:= SubStr( cString, ++nCont, 1 ) 
             ENDIF 
         NEXT 
      ENDIF 
   ENDIF 
   DisplayLinha( aBrowse, @nRow ) 
 
 
/* nPosInicial - Posicao inicial da string a ser movimentada */ 
/* cString - String a movimentar */ 
Function MoveString( aBrowse, cString, nRow, aArray ) 
Local nTeclaRes, cOldString:= Nil 
 
  WHILE .T. 
     IF ( nTeclaRes:= Inkey(0) ) == K_ENTER 
        Exit 
     ENDIF 
 
     SetColor( "15/01" ) 
     /* Limpa o local atual */ 
     nCont:= 0 
     FOR nCt:= ColPos( aBRowse ) TO ColPos( aBrowse ) + Len( cString ) 
         IF cOldString == Nil 
            //.OR. cOldString == cString 
            aT[ nRow ][ nCt ]:= " " 
         ELSE 
            aT[ nRow ][ nCt ]:= SubStr( cOldString, ++nCont, 1 ) 
         ENDIF 
     NEXT 
     DO CASE 
         CASE nTeclaRes == K_UP 
              SWUp( aBrowse, @nRow ) 
         CASE nTeclaRes == K_DOWN 
              SWDown( aBrowse, @nRow ) 
         CASE nTeclaRes == K_LEFT 
              SWLeft( aBrowse, @nRow ) 
         CASE nTeclaRes == K_RIGHT 
              SWRight( aBrowse, @nRow ) 
         CASE nTeclaRes == K_PGDN 
              SWPgDn( aBrowse, @nRow ) 
         CASE nTeclaRes == K_PGUP 
              SWPgUp( aBrowse, @nRow ) 
      ENDCASE 
      nCont:= 0 
      cOldString:= "" 
      FOR nCt:= ColPos( aBRowse ) TO ColPos( aBrowse ) + Len( cString ) 
          cOldString:= cOldString + aT[ nRow ][ nCt ] 
          aT[ nRow ][ nCt ]:= SubStr( cString, ++nCont, 1 ) 
      NEXT 
      DisplayBrowse( aBrowse, @nRow ) 
   ENDDO 
 
Function VisualVariaveis() 
LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local GetList:={}, nRowRes:= Row(), nColRes:=Col() 
Local oTb4, oTb, nRow:= 1, aVariaveis 
Local cDiretorio:= "" 
Local cFile:= "" 
 
   VPBox( 05, 13, 21, 72, " VARIAVEIS DISPONIVEIS PARA UTILIZACAO ", _COR_GET_BOX ) 
 
   SetColor( _COR_GET_BOX ) 
   @ 07,15 Say "Nome.....:" 
   @ 08,15 Say "Display..:" 
   @ 09,15 Say "          " 
 
   SetColor( _COR_BROWSE ) 
   @ 07,26 Say PAD( " ", 45 ) 
   @ 08,26 Say PAD( " ", 45 ) 
   @ 09,26 Say PAD( " ", 45 ) 
 
   aVariaveis:= { { " Cliente - Nome                                          ", [�(CLI->DESCRI)�] },; 
                  { " Cliente - Endereco                                      ", [�(CLI->ENDERE)�] },; 
                  { " Cliente - Bairro                                        ", [�(CLI->BAIRRO)�] },; 
                  { " Cliente - Cep                                           ", [�Tran(CLI->CODCEP,"@R 99.999-999")�] },; 
                  { " Cliente - Estado                                        ", [�(CLI->ESTADO)�] },; 
                  { " Cliente - Data Nascimento                               ", [�DTOC(CLI->NASCIM)�] },; 
                  { " Cliente - Fone                                          ", [�Tran( CLI->FONE__, "@R 9999-9999.9999")�] },; 
                  { " Cliente - Filiacao Partidaria                           ", [�ALLTRIM( CLI->PARTID )�] },; 
                  { " ������������������������������������������������������� ", [] },; 
                  { " Nome do Candidato                                       ", [�Alltrim( _EMP )�] },; 
                  { " Data Atual                                              ", [�DTOC( DATE() )�] },; 
                  { " Hora Atual                                              ", [�TIME()�] },; 
                  { " ������������������������������������������������������� ", [Soft&Ware Informatica] },; 
                  { " #VARIAVEL - Nom                                         ", [Nom:= CLI->DESCRI] },; 
                  { " #VARIAVEL - End                                         ", [End:= CLI->ENDERE] },; 
                  { " #VARIAVEL - Bai                                         ", [Bai:= CLI->BAIRRO] },; 
                  { " #VARIAVEL - Cid                                         ", [Cid:= CLI->CIDADE] },; 
                  { " #VARIAVEL - UF                                          ", [UF:=  CLI->ESTADO] },; 
                  { " #VARIAVEL - Cep                                         ", [Cep:= Tran( CLI->CODCEP, "@R 99.999-999" )] },; 
                  { " ������������������������������������������������������� ", [] },; 
                  { " #COMANDO  - Linha Salto Automatico                      ", [LinhaOn()] },; 
                  { " #COMANDO  - Linha Desliga Salto                         ", [LinhaOff()] },; 
                  { " #COMANDO  - Pagina Salto                                ", [__Eject()] },; 
                  { " #COMANDO  - Finalizacao Relatorio                       ", [$Fim] },; 
                  { " #COMANDO  - Device To Print                             ", [Set( 20, "PRINT" )] },; 
                  { " #COMANDO  - Device To Screen                            ", [Set( 20, "SCREEN" )] },; 
                  { " #COMANDO  - Inicio do Arquivo .DBF                      ", [DBGoTop()] },; 
                  { " #COMANDO  - End Of File                                 ", [EOF()] },; 
                  { " #COMANDO  - Proximo Registro                            ", [DBSkip()] },; 
                  { " #COMANDO  - VaiPara Condicional                         ", [VaiPara( .T., break1, break2 )] },; 
                  { " #COMANDO  - VaiPara()                                   ", [VaiPara( break )] },; 
                  { " ������������������������������������������������������� ", [] },; 
                  { " #BREAK    - Iniciar                                     ", [:Iniciar] },; 
                  { " #BREAK    - Cabecalho                                   ", [:Cabecalho] },; 
                  { " #BREAK    - Relatorio                                   ", [:Relatorio] },; 
                  { " #BREAK    - Skip                                        ", [:Skip] },; 
                  { " #BREAK    - SaltaPagina                                 ", [:SaltaPagina] },; 
                  { " #BREAK    - Variaveis                                   ", [:Variaveis] },; 
                  { " #BREAK    - Fim                                         ", [:Fim] }} 
 
 
   if len(aVariaveis) > 0 
 
      /* Ajuste de mensagens */ 
      Mensagem("[ENTER]Seleciona.") 
      Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
      SetColor( _COR_BROWSE ) 
 
      /* Inicializacao do objeto browse */ 
      oTb:=TBrowseNew( 11, 15, 20, 70 ) 
      oTb:AddColumn( tbcolumnnew( , {|| aVariaveis[ nRow ][ 1 ] + SPACE( 40 ) } )) 
 
      /* Movimentacao no browse */ 
      oTb:GoTopBlock:= {|| nRow:= 1 } 
      oTb:GoBottomBlock:= {|| nRow:= Len( aVariaveis ) } 
      oTb:SkipBlock:= {|x| SkipperArr( x, aVariaveis, @nRow ) } 
 
      /* Variaveis do objeto browse */ 
      oTb:AutoLite:=.F. 
      oTb:dehilite()              /* Nao  - Sim */ 
      oTb:ColorSpec:= SetColor() + ",10/02,14/09" 
 
      WHILE .T. 
 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
 
         /* Stabilize */ 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         SetColor( "00/03" ) 
         @ 07,26 Say Pad( LTrim( aVariaveis[ nRow ][ 1 ] ), 45 ) 
         @ 08,26 Say Pad( left( aVariaveis[ nRow ][ 2 ], 45 ), 45 ) 
         @ 09,26 Say Pad( SubStr( aVariaveis[ nRow ][ 2 ], 46 ), 45 ) 
 
         nTecla:= Inkey(0) 
 
         IF nTecla==K_ESC 
            cFile:= Nil 
            EXIT 
         ENDIF 
 
         /* Teste da tecla pressionadas */ 
         DO CASE 
 
            CASE nTecla==K_UP         ; oTb:up() 
 
            CASE nTecla==K_LEFT       ; oTb:PanLeft() 
 
            CASE nTecla==K_RIGHT      ; oTb:PanRight() 
 
            CASE nTecla==K_DOWN       ; oTb:down() 
 
            CASE nTecla==K_PGUP       ; oTb:pageup() 
 
            CASE nTecla==K_PGDN       ; oTb:pagedown() 
 
            CASE nTecla==K_CTRL_PGUP  ; oTb:gotop() 
 
            CASE nTecla==K_CTRL_PGDN  ; oTb:gobottom() 
 
            CASE nTecla==K_ENTER 
                 cFile:= aVariaveis[ nRow ][ 2 ] 
                 Exit 
 
            OTHERWISE                 ; Tone(125); Tone(300) 
 
         ENDCASE 
 
         oTb:RefreshAll() 
         oTb:Stabilize() 
      ENDDO 
   EndIf 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DevPos( nRowRes, nColRes ) 
   Return cFile 
 
 
 
Function Desenhos( aT, aBrowse, x ) 
LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local GetList:={} 
Local oTb4, oTb, nRow:= 1, aMolduras 
Local cDiretorio:= "" 
Local cFile:= "" 
 
   VPBox( 05, 13, 21, 72, " MOLDURAS DISPONIVEIS ", _COR_GET_BOX ) 
 
   SetColor( _COR_GET_BOX ) 
   @ 07,15 Say " ����Ŀ   +----+    ������ " 
   @ 08,15 Say " �    �   |    |    �    � " 
   @ 09,15 Say " ������   +----+    ������ " 
 
   SetColor( _COR_BROWSE ) 
 
   aMolduras:= { { " Simples             " },; 
                  { " Relatorios R�pidos  " },; 
                  { " Dupla-Densidade     " } } 
 
   if len(aMolduras) > 0 
 
      /* Ajuste de mensagens */ 
      Mensagem("[ENTER]Seleciona.") 
      Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
      SetColor( _COR_BROWSE ) 
 
      /* Inicializacao do objeto browse */ 
      oTb:=TBrowseNew( 11, 15, 20, 70 ) 
      oTb:AddColumn( tbcolumnnew( , {|| aMolduras[ nRow ][ 1 ] + SPACE( 40 ) } )) 
 
      /* Movimentacao no browse */ 
      oTb:GoTopBlock:= {|| nRow:= 1 } 
      oTb:GoBottomBlock:= {|| nRow:= Len( aMolduras ) } 
      oTb:SkipBlock:= {|x| SkipperArr( x, aMolduras, @nRow ) } 
 
      /* Variaveis do objeto browse */ 
      oTb:AutoLite:=.F. 
      oTb:dehilite()              /* Nao  - Sim */ 
      oTb:ColorSpec:= SetColor() + ",10/02,14/09" 
 
      WHILE .T. 
 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
 
         /* Stabilize */ 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         nTecla:= Inkey(0) 
 
         IF nTecla==K_ESC 
            EXIT 
         ENDIF 
 
         /* Teste da tecla pressionadas */ 
         DO CASE 
 
            CASE nTecla==K_UP         ; oTb:up() 
 
            CASE nTecla==K_LEFT       ; oTb:PanLeft() 
 
            CASE nTecla==K_RIGHT      ; oTb:PanRight() 
 
            CASE nTecla==K_DOWN       ; oTb:down() 
 
            CASE nTecla==K_PGUP       ; oTb:pageup() 
 
            CASE nTecla==K_PGDN       ; oTb:pagedown() 
 
            CASE nTecla==K_CTRL_PGUP  ; oTb:gotop() 
 
            CASE nTecla==K_CTRL_PGDN  ; oTb:gobottom() 
 
            CASE nTecla==K_ENTER 
 
                 aTabChar:= { "�", "�", "�", "�", "�", "�", "�", "�" } 
 
                 SetColor( cCor ) 
                 ScreenRest( cTela ) 
 
                 /* Inicializa */ 
                 cChar:= aTabChar[2] 
                 cOldChar:= cChar 
                 nOldTecla:= K_LEFT 
 
                 WHILE .T. 
                     DisplayCurrent( aBrowse ) 
                     nTecla:= Inkey(0) 
                     DesfazCurrent( aBrowse ) 
                     DO CASE 
                        CASE nTecla == K_LEFT 
                             IF nOldTecla == K_UP 
                                cChar:= aTabChar[3] 
                             ELSEIF nOldTecla == K_DOWN 
                                cChar:= aTabChar[8] 
                             ELSE 
                                cChar:= aTabChar[7] 
                             ENDIF 
                        CASE nTecla == K_UP 
                             IF nOldTecla == K_LEFT 
                                cChar:= aTabChar[6] 
                             ELSEIF nOldTecla == K_RIGHT 
                                cChar:= aTabChar[8] 
                             ELSE 
                                cChar:= aTabChar[4] 
                             ENDIF 
                        CASE nTecla == K_DOWN 
                             IF nOldTecla == K_LEFT 
                                cChar:= aTabChar[1] 
                             ELSEIF nOldTecla == K_RIGHT 
                                cChar:= aTabChar[3] 
                             ELSE 
                                cChar:= aTabChar[5] 
                             ENDIF 
                        CASE nTecla == K_RIGHT 
                             IF nOldTecla == K_UP 
                                cChar:= aTabChar[1] 
                             ELSEIF nOldTecla == K_DOWN 
                                cChar:= aTabChar[6] 
                             ELSE 
                                cChar:= aTabChar[2] 
                             ENDIF 
                         OTHERWISE 
                             Exit 
 
                     ENDCASE 
                     nOldTecla:= nTecla 
                     SWEscreve( aBrowse, cChar, @x, aT ) 
                     IF nOldTecla == K_RIGHT 
                        SWRight( aBrowse, @x ) 
                     ELSEIF nOldTecla == K_LEFT 
                        SWLeft( aBrowse, @x ) 
                     ELSEIF nOldTecla == K_UP 
                        SWUp( aBrowse, @x ) 
                     ELSEIF nOldTecla == K_DOWN 
                        SWDown( aBrowse, @x ) 
                     ENDIF 
 
                 ENDDO 
                 Return Nil 
 
            OTHERWISE                 ; Tone(125); Tone(300) 
 
         ENDCASE 
 
         oTb:RefreshAll() 
         oTb:Stabilize() 
      ENDDO 
   EndIf 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Function SeekFile() 
LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local GetList:={} 
Local oTb4, oTb, nRow:= 1, aFiles 
Local cDiretorio:= "" 
Local cFile:= "" 
 
   VPBox( 05, 13, 21, 77, " SELECAO DE ARQUIVOS ", _COR_GET_BOX ) 
   VPBox( 11, 15, 20, 28, " Arquivos ", _COR_BROW_BOX, .f., .f., ,.f. ) 
   VPBox( 11, 30, 20, 45, " Diretorios ", _COR_BROW_BOX, .F., .F., , .F. ) 
   VPBox( 11, 47, 20, 55, " Drive ", _COR_BROW_BOX, .F., .F., , .F. ) 
   VPBox( 07, 57, 20, 75, , "15/03", .F., .F., , .F. ) 
 
   SetColor( _COR_GET_BOX ) 
   @ 07,15 Say "Arquivo..:" 
   @ 08,15 Say "Diret�rio:" 
   @ 09,15 Say "Formato..:" 
 
 
   SetColor( _COR_BROWSE ) 
   @ 07,26 Say PAD( " ", 30 ) 
   @ 08,26 Say PAD( ( cDiretorio:= SWSet( _SYS_DIRREPORT ) ), 30 ) 
   @ 09,26 Say PAD( "*.REP", 30 ) 
 
   /* busca dados dos arquivos de remessa disponiveis no drive */ 
   aFiles:= directory( SWSet( _SYS_DIRREPORT ) + "\*.REP" ) 
   if len(aFiles) > 0 
      For nCt:= 1 TO Len( aFiles ) 
         AAdd( aFiles[ nCt ], aFiles[ nCt ][ 1 ] ) 
      Next 
 
      /* Ajuste de mensagens */ 
      Mensagem("[ENTER]Seleciona.") 
      Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
 
      SetColor( _COR_BROWSE ) 
 
      ASort( aFiles,,, { |x,y| x[1] < y[1] } ) 
 
      /* Inicializacao do objeto browse */ 
      oTb:=TBrowseNew( 12, 16, 19, 27 ) 
      oTb:AddColumn( tbcolumnnew( , {|| PAD( aFiles[ nRow ][ 1 ], 12 ) + SPACE( 20 ) } )) 
 
      /* Movimentacao no browse */ 
      oTb:GoTopBlock:= {|| nRow:= 1 } 
      oTb:GoBottomBlock:= {|| nRow:= Len( aFiles ) } 
      oTb:SkipBlock:= {|x| SkipperArr( x, aFiles, @nRow ) } 
 
      /* Variaveis do objeto browse */ 
      oTb:AutoLite:=.F. 
      oTb:dehilite()              /* Nao  - Sim */ 
      oTb:ColorSpec:= SetColor() + ",10/02,14/09" 
 
      WHILE .T. 
 
         oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, 1 }, { 2, 1 } ) 
 
         /* Stabilize */ 
         WHILE NextKey()=0 .AND. !oTb:Stabilize() 
         ENDDO 
 
         SetColor( "00/03" ) 
         @ 08,58 Say "Data...: " + Dtoc( aFiles[ nRow ][ 3 ] ) 
         @ 09,58 Say "Hora...: " + aFiles[ nRow ][ 4 ] 
         @ 10,58 Say "Tamanho: " + Str( aFiles[ nRow ][ 2 ], 8 ) 
         @ 11,58 Say "Nome...: " + Left( aFiles[ nRow ][ 1 ], AT( ".", aFiles[ nRow ][ 1 ] ) -1 ) 
         @ 12,58 Say "Extens.: " + SubStr( aFiles[ nRow ][ 1 ], AT( ".", aFiles[ nRow ][ 1 ] ) + 1 ) 
 
         SetColor( _COR_BROWSE ) 
         @ 07,26 Say PAD( aFiles[ nRow ][ 1 ], 30 ) 
         nTecla:= Inkey(0) 
 
         IF nTecla==K_ESC 
            cFile:= "TESTE" 
            EXIT 
         ENDIF 
 
         /* Teste da tecla pressionadas */ 
         DO CASE 
 
            CASE nTecla==K_UP         ; oTb:up() 
 
            CASE nTecla==K_LEFT       ; oTb:PanLeft() 
 
            CASE nTecla==K_RIGHT      ; oTb:PanRight() 
 
            CASE nTecla==K_DOWN       ; oTb:down() 
 
            CASE nTecla==K_PGUP       ; oTb:pageup() 
 
            CASE nTecla==K_PGDN       ; oTb:pagedown() 
 
            CASE nTecla==K_CTRL_PGUP  ; oTb:gotop() 
 
            CASE nTecla==K_CTRL_PGDN  ; oTb:gobottom() 
 
            CASE nTecla==K_ENTER 
                 cFile:= cDiretorio + "\" + aFiles[ nRow ][ 1 ] 
                 Exit 
 
            OTHERWISE                 ; Tone(125); Tone(300) 
 
         ENDCASE 
 
         oTb:RefreshAll() 
         oTb:Stabilize() 
      ENDDO 
   EndIf 
 
   Return cFile 
 
 
 
 
 
 
FUNCTION SalvarArquivo( aTexto, cArquivo ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ),; 
        nOpcao:= 0, lRetorno:= .F. 
 
 
 
   VPBox( 10, 21, 19, 56, " Salvar Arquivo ", _COR_GET_BOX ) 
   SetColor( _COR_GET_BOX ) 
   @ 12,22 Say PADC( Alltrim( "O arquivo " + cArquivo ), 34 ) 
   @ 13,22 Say PADC( "ainda n�o foi salvo.",             34 ) 
   SetColor( _COR_BROW_BOX ) 
   SetColor( "00/03,15/00" ) 
   @ 15,22 Prompt "              Salvar              " 
   @ 16,22 Prompt "           Gravar como            " 
   @ 17,22 Prompt "        Retornar a edicao         " 
   @ 18,22 Prompt "            Abandonar             " 
   Menu To nOpcao 
   DO CASE 
      CASE nOpcao == 2 
           VPBox( 18, 40, 20, 65, " Salvar Como ", _COR_GET_BOX ) 
           SetColor( _COR_GET_EDICAO ) 
           cArquivo:= Space( 8 ) 
           @ 19,58 Say ".Rep" 
           @ 19,42 Say "Report " Get cArquivo 
           READ 
           Set( 24, SWSet( _SYS_DIRREPORT ) - "\" - cArquivo - ".REP" ) 
           Set( 20, "PRINT" ) 
 
           FOR nLin:= 1 TO Len( aTexto ) 
               FOR nCol:= 1 TO Len( aTexto[ nLin ] ) 
                   IF nCol > 158 
                      Exit 
                   Endif 
                   @ PROW(), PCol() Say aTexto[ nLin ][ nCol ] 
               NEXT 
               // Salto de linha 
               @ PROW(),PCOL() Say Chr( 13 ) + Chr( 10 ) 
           NEXT 
           Set( 24, "LPT1" ) 
           Set( 20, "SCREEN" ) 
           lRetorno:=  .T. 
 
      CASE nOpcao == 4 
           lRetorno:= .T. 
 
      CASE nOpcao == 1 
           Set( 24, cArquivo ) 
           Set( 20, "PRINT" ) 
           FOR nLin:= 1 TO Len( aTexto ) 
               FOR nCol:= 1 TO Len( aTexto[ nLin ] ) 
                   IF nCol > 158 
                      Exit 
                   Endif 
                   @ PROW(), PCol() Say aTexto[ nLin ][ nCol ] 
               NEXT 
               @ PROW(), PCOL() Say Chr( 13 ) + Chr( 10 ) 
           NEXT 
           Set( 24, "LPT1" ) 
           Set( 20, "SCREEN" ) 
           lRetorno:=  .T. 
   ENDCASE 
   IF lRetorno 
      aFileTxt:= IOFillText( MEMOREAD( cArquivo ) ) 
      IF aFileTxt <> Nil 
         Set( 24, cArquivo ) 
         Set( 20, "PRINT" ) 
         FOR nCt:= 1 TO Len( aFileTxt ) 
             @ PROW(), PCOL() Say RTrim( aFileTxt[ nCt ] ) + CHR( 13 ) + CHR( 10 ) 
         NEXT 
         Set( 24, "LPT1" ) 
         Set( 20, "SCREEN" ) 
      ENDIF 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return lRetorno 
 
 
Function Preview( aTexto ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Set( 24, "PREVISAO.TMP" ) 
   Set( 20, "PRINT" ) 
   FOR nLin:= 1 TO Len( aTexto ) 
       IF !( aTexto[ nLin ][ 160 ] $ "��" ) .AND.; 
          !( aTexto[ nLin ][ 1 ]==":" ) .AND.; 
          !( aTexto[ nLin ][ 1 ]=="$" ) .AND.; 
          !( aTexto[ nLin ][ 1 ]=="*" ) 
          FOR nCol:= 1 TO Len( aTexto[ nLin ] ) 
              IF nCol > 158 
                 Exit 
              Endif 
              @ PROW(), PCol() Say aTexto[ nLin ][ nCol ] 
          NEXT 
          @ PROW(), PCOL() Say Chr( 13 ) + Chr( 10 ) 
       ENDIF 
   NEXT 
   Set( 24, "LPT1" ) 
   Set( 20, "SCREEN" ) 
   ViewFile( "PREVISAO.TMP" ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
Function ViewComandos( aTexto ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Set( 24, "COMANDOS.TMP" ) 
   Set( 20, "PRINT" ) 
   FOR nLin:= 1 TO Len( aTexto ) 
       IF ( aTexto[ nLin ][ 160 ] $ "��" ) .OR.; 
          ( aTexto[ nLin ][ 1 ]==":" ) .OR.; 
          ( aTexto[ nLin ][ 1 ]=="$" ) .AND.; 
          !( aTexto[ nLin ][ 1 ]=="*" ) 
          FOR nCol:= 1 TO Len( aTexto[ nLin ] ) 
              IF nCol > 158 
                 Exit 
              Endif 
              @ PROW(), PCol() Say aTexto[ nLin ][ nCol ] 
          NEXT 
          @ PROW(), PCOL() Say Chr( 13 ) + Chr( 10 ) 
       ENDIF 
   NEXT 
   Set( 24, "LPT1" ) 
   Set( 20, "SCREEN" ) 
   ViewFile( "COMANDOS.TMP" ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
