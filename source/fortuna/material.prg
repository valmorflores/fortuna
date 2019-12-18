// ## CL2HB.EXE - Converted
#Include "VPF.Ch" 
 
#Define STR            Upper( AllTrim( aEstrutura[ nCt ] ) ) 
#Define STRNORMAL      aEstrutura[ nCt ] 
#Define STRVARIAVEIS   Alltrim( Left( STR, At( "=>", STR ) - 1 ) ) 
#Define STRDISPLAY     Alltrim( Left( aEstrutura[ nCtDisplay ], At( "[", aEstrutura[ nCtDisplay ] ) - 1 ) ) 
 
Function DisplayView( cArquivo ) 
   Local cCor:= SetColor(), nCursor:= SetCursor() 
   Local nCt:= 1, aEstrutura 
   Local nPos:= 0 
   Local nRow:= 1, nBRowIni, nBColIni, nBRowEnd, nBColEnd,; 
                   nERowIni, nEColIni, nERowEnd, nEColEnd,; 
                   nRowIni,  nColIni, nEndDisplay:= 0, nCtDisplay:= 0 
 
 
   Mensagem( "Montando o display, aguarde..." ) 
 
   /* Ler dados de arquivo */ 
   aEstrutura:= FileArray( cArquivo ) 
 
   DispBegin() 
   For nCt:= 1 To Len( aEstrutura ) 
       If STRVARIAVEIS == "TITULO"                        ;nPos:= 1 
       ElseIf STRVARIAVEIS == "POSICAO DADOS"             ;nPos:= 2 
       ElseIf STRVARIAVEIS == "POSICAO INICIAL EDICAO"    ;nPos:= 3 
       ElseIf STRVARIAVEIS == "POSICAO FINAL EDICAO"      ;nPos:= 4 
       ElseIf STRVARIAVEIS == "POSICAO INICIAL BROWSE"    ;nPos:= 5 
       ElseIf STRVARIAVEIS == "POSICAO FINAL BROWSE"      ;nPos:= 6 
       ElseIf STR ==          "INICIA DISPLAY"            ;nPos:= 7 
       EndIf 
       Do Case 
          Case nPos == 1 
               cTitulo:= SubStr( STRNORMAL, At( "[", STR ) + 1, At( "]", STR ) - At( "[", STR ) - 1 ) 
          Case nPos == 2 
               nRowIni:= Posicao( STRNORMAL, STR, 1 ) 
               nColIni:= Posicao( STRNORMAL, STR, 2 ) 
          Case nPos == 3 
               nERowIni:= Posicao( STRNORMAL, STR, 1 ) 
               nEColIni:= Posicao( STRNORMAL, STR, 2 ) 
          Case nPos == 4 
               nERowEnd:= Posicao( STRNORMAL, STR, 1 ) 
               nEColEnd:= Posicao( STRNORMAL, STR, 2 ) 
               VPBox( nERowIni, nEColIni, nERowEnd, nEColEnd, cTitulo, _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
          Case nPos == 5 
               nBRowIni:= Posicao( STRNORMAL, STR, 1 ) 
               nBColIni:= Posicao( STRNORMAL, STR, 2 ) 
          Case nPos == 6 
               nBRowEnd:= Posicao( STRNORMAL, STR, 1 ) 
               nBColEnd:= Posicao( STRNORMAL, STR, 2 ) 
               VPBox( nBRowIni, nBColIni, nBRowEnd, nBColEnd, ,_COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
          Case nPos == 7 
               nEndDisplay:= ASCAN( aEstrutura, {|x| Alltrim( Upper( x ) ) == "FINALIZA DISPLAY" } ) - 1 
               If nEndDisplay < 1 
                  @ 01,00 Say "Erro!" 
                  Quit 
               EndIf 
               SetColor( _COR_GET_EDICAO ) 
               For nCtDisplay:= nCt + 1 To nEndDisplay 
                   @ nRowIni++, nColIni Say STRDISPLAY 
               Next 
               SetColor( cCor ) 
       EndCase 
       nPos:= 0 
   Next 
   Dispend() 
   Return Nil 
 
 
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
 
