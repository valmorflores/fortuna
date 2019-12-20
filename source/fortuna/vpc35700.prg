// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � MOEDAS 
� Finalidade  � Cadastramento de Moedas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc35700()
#endif

Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
 
   IF !FILE( _VPB_MOEDAS ) 
      CreateVPB( _COD_MOEDAS ) 
   ENDIF 
   IF !FILE( _VPB_VARIACOES ) 
      CreateVPB( _COD_VARIACOES ) 
   ENDIF 
 
   DBSelectAr( _COD_VARIACOES ) 
   IF !Used() 
      FDBUseVpb( _COD_VARIACOES, 2 ) 
   ENDIF 
 
   DBSelectAr( _COD_MOEDAS ) 
   IF !Used() 
      FDBuseVpb( _COD_MOEDAS, 2 ) 
   ENDIF 
   VPBox( 00, 47, 22, 79, " Variacoes ", _COR_ALERTA_BOX, .F., .F. ) 
   VPBox( 00, 00, 08, 46, " M O E D A S ",  _COR_GET_BOX, .F., .F. ) 
   VPBox( 09, 00, 22, 46, " Display ", _COR_BROW_BOX, .F., .F. ) 
   Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   SetColor( _COR_BROWSE ) 
   oTAB:=tbrowseDB(10,01,18,45) 
   oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 03, 00 ) + " " + SIGLA_ + " " + DESCRI })) 
   oTAB:AUTOLITE:=.f. 
   oTAB:dehilite() 
   whil .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTAB:stabilize() 
      end 
      DisplayMoeda() 
      DisplayVariacoes() 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_INS        ;IncluiMoeda( oTab ) 
         case TECLA==K_ENTER      ;AlteraMoeda( oTab ) 
         case TECLA==K_DEL 
              Exclui( oTab ) 
         case TECLA==K_UP         ;oTAB:up() 
         case TECLA==K_DOWN       ;oTAB:down() 
         case TECLA==K_LEFT       ;oTAB:up() 
         case TECLA==K_RIGHT      ;oTAB:down() 
         case TECLA==K_PGUP       ;oTAB:pageup() 
         case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
         case TECLA==K_PGDN       ;oTAB:pagedown() 
         case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
Function DisplayVariacoes() 
Local cCor:= SetColor() 
Local nLin:= 1 
   DBSelectAr( _COD_VARIACOES ) 
   DBSetOrder( 2 ) 
   DBGoTop() 
   SetColor( _COR_ALERTA_BOX ) 
   Scroll( 01, 48, 21, 78 ) 
   WHILE .t. 
       IF MOE->CODIGO == VAR->CODIGO 
          @ ++nLin,50 Say VAR->DATA__ 
          @ nLin,60 Say Tran( VAR->INDICE, "@E 999,999,999.9999" ) 
       ENDIF 
       DBSkip() 
       IF VAR->( EOF() ) .OR. nLin==20 
          EXIT 
       ENDIF 
   ENDDO 
   SetColor( "00/14" ) 
   @ ++nLin,50 Say "  HOJE  " 
   @ nLin,60 Say Tran( MOE->INDICE, "@E 999,999,999.9999" ) 
   SetColor( cCor ) 
   DBSetOrder( 1 ) 
   DBSelectAr( _COD_MOEDAS ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiMoeda 
� Finalidade  � Inclusao de uma nova moeda na base de dados 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function IncluiMoeda( oTab ) 
   Local cCor:= SetColor( cCor ), cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nCodigo:= 0, cDescri:= Space( 30 ), nIndice:= 0, cSigla_:= Space( 10 ),; 
         cPadrao:= " " 
 
   DBSetOrder( 1 ) 
   DBSeek( 999 ) 
   DBSkip(-1) 
   SetCursor( 1 ) 
   nCodigo:= CODIGO + 1 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,02 Say "Codigo.......:" Get nCodigo Pict "999" 
   @ 03,02 Say "Descricao....:" Get cDescri Pict "@S20" 
   @ 04,02 Say "Sigla........:" Get cSigla_ 
   @ 05,02 Say "Indice Atual.:" Get nIndice Pict "@E 9,999,999.9999" 
   READ 
   IF !LastKey() == K_ESC 
      DBAppend() 
      Replace CODIGO With nCodigo,; 
              DESCRI With cDescri,; 
              SIGLA_ With cSigla_,; 
              INDICE With nIndice 
   ENDIF 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( 0 ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � AlteraMoeda 
� Finalidade  � Alteracao de uma moeda na base de dados 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraMoeda( oTab ) 
   Local cCor:= SetColor( cCor ), cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nCodigo:= CODIGO, cDescri:= DESCRI, nIndice:= INDICE, cSigla_:= SIGLA_,; 
         cPadrao:= PADRAO 
 
   SetCursor( 1 ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,02 Say "Codigo.......: ["+Str( nCodigo, 3, 0 ) + "]" 
   @ 03,02 Say "Descricao....:" Get cDescri Pict "@S20" 
   @ 04,02 Say "Sigla........:" Get cSigla_ 
   @ 05,02 Say "Indice Atual.:" Get nIndice Pict "@E 9,999,999.9999" 
   READ 
   IF !LastKey() == K_ESC 
      IF netrlock() 
         Repl CODIGO With nCodigo,; 
              DESCRI With cDescri,; 
              SIGLA_ With cSigla_,; 
              INDICE With nIndice 
      ENDIF 
   ENDIF 
   DBUnlockAll() 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( 0 ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
 
Function DisplayMoeda( oTab ) 
   Local cCor:= SetColor( cCor ) 
   Local nCodigo:= CODIGO, cDescri:= DESCRI, nIndice:= INDICE, cSigla_:= SIGLA_ 
         cPadrao:= PADRAO 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,02 Say "Codigo.......: [" + Str( CODIGO, 3, 0 ) + "]" 
   @ 03,02 Say "Descricao....: [" + Left( cDescri, 20 ) + "]" 
   @ 04,02 Say "Sigla........: [" + cSigla_ + "]" 
   @ 05,02 Say "Indice Atual.: [" + Tran( nIndice, "@E 9,999,999.9999" ) + "]" 
   READ 
   SetColor( cCor ) 
   Return Nil 
 
 
