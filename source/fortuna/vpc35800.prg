// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ MOEDAS 
³ Finalidade  ³ Cadastramento de Moedas 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/
#ifdef HARBOUR
function vpc35800
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
   DBSelectAr( _COD_MOEDAS ) 
 
   VPBox( 00, 00, 22, 46, " M O E D A S ", _COR_BROW_BOX ) 
   VPBox( 00, 47, 22, 79, " Variacoes ", _COR_GET_BOX ) 
   Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   SetColor( _COR_BROWSE ) 
   oTAB:=tbrowseDB(01,01,18,45) 
   oTAB:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 03, 00 ) + " " + SIGLA_ + " " + DESCRI })) 
   oTAB:AUTOLITE:=.f. 
   oTAB:dehilite() 
   whil .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTAB:Stabilize() 
      end 
      DisplayVariacoes() 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_ENTER      ;EditaVariacao( oTab ) 
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
      oTAB:Stabilize() 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
Static Function DisplayVariacoes() 
Local cCor:= SetColor() 
Local nLin:= 1 
   DBSelectAr( _COD_VARIACOES ) 
   DBSetOrder( 2 ) 
   DBGoTop() 
   SetColor( _COR_GET_EDICAO ) 
   Scroll( 02, 48, 21, 78 ) 
   SetColor( _COR_ALERTA_BOX ) 
   WHILE .T. 
       IF MOE->CODIGO == VAR->CODIGO 
          @ ++nLin,51 Say VAR->DATA__ 
          @ nLin,60 Say Tran( VAR->INDICE, "@E 9,999,999.9999" ) 
       ENDIF 
       DBSkip() 
       IF VAR->( EOF() ) .OR. nLin==20 
          EXIT 
       ENDIF 
   ENDDO 
   SetColor( "00/14" ) 
   @ ++nLin,51 Say "  HOJE  " 
   @ nLin,60 Say Tran( MOE->INDICE, "@E 9,999,999.9999" ) 
   SetColor( cCor ) 
   DBSelectAr( _COD_MOEDAS ) 
   Return Nil 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ EditaVariacao 
³ Finalidade  ³ Alterar a variacao cambial 
³ Parametros  ³ oTab 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function EditaVariacao( oTab ) 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local oTb 
   DBSelectAr( _COD_VARIACOES ) 
   DBSetOrder( 2 ) 
   Set Filter To CODIGO==MOE->CODIGO 
   DBGoTop() 
   VPBox( 00, 47, 22, 79, " Variacoes ", _COR_BROW_BOX ) 
   Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   SetColor( _COR_BROWSE ) 
   oTb:=tbrowseDB(02,50,21,74) 
   oTb:addcolumn(tbcolumnnew(,{|| DTOC( DATA__ ) + " " + Tran( INDICE, "@E 9,999,999.9999"  ) })) 
   oTb:AUTOLITE:=.f. 
   oTb:dehilite() 
   whil .t. 
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTb:Stabilize() 
      end 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_INS        ;IncluiVariacao(oTb) 
         case TECLA==K_ENTER      ;AlteraVariacao(oTb) 
         case TECLA==K_DEL        ;Exclui(oTb) 
         case TECLA==K_UP         ;oTb:up() 
         case TECLA==K_DOWN       ;oTb:down() 
         case TECLA==K_LEFT       ;oTb:up() 
         case TECLA==K_RIGHT      ;oTb:down() 
         case TECLA==K_PGUP       ;oTb:pageup() 
         case TECLA==K_CTRL_PGUP  ;oTb:gotop() 
         case TECLA==K_PGDN       ;oTb:pagedown() 
         case TECLA==K_CTRL_PGDN  ;oTb:gobottom() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:refreshcurrent() 
      oTb:Stabilize() 
   ENDDO 
   Set Filter To 
   DBSelectAr( _COD_MOEDAS ) 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ IncluiVariacao 
³ Finalidade  ³ Inclusao de uma nova variacao na base de dados 
³ Parametros  ³ oTab 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function IncluiVariacao( oTab ) 
   Local cCor:= SetColor( cCor ), cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local dData:= Date(), nIndice:= INDICE 
   SetCursor( 1 ) 
   nCodigo:= CODIGO + 1 
   SetColor( _COR_GET_EDICAO ) 
   Set( _SET_DELIMITERS, .F. ) 
   @ 02,51 Get dData 
   @ 02,60 Get nIndice Pict "@E 9,999,999.9999" 
   READ 
   IF !LastKey() == K_ESC 
      DBAppend() 
      Replace CODIGO With MOE->CODIGO,; 
              DATA__ With dData,; 
              INDICE With nIndice 
   ENDIF 
   DBGoBottom() 
   IF MOE->( NetRLock() ) 
      Replace MOE->INDICE With VAR->INDICE 
   ENDIF 
   Set( _SET_DELIMITERS, .T. ) 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( 0 ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ AlteraVariacao 
³ Finalidade  ³ Alteracao da variacao 
³ Parametros  ³ oTab 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function AlteraVariacao( oTab ) 
   Local cCor:= SetColor( cCor ), cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local dData:= DATA__, nIndice:= INDICE 
   SetCursor( 1 ) 
   nCodigo:= CODIGO + 1 
   SetColor( _COR_GET_EDICAO ) 
   Set( _SET_DELIMITERS, .F. ) 
   @ Row(),51 Get dData 
   @ Row(),60 Get nIndice Pict "@E 9,999,999.9999" 
   READ 
   IF !LastKey() == K_ESC 
      IF NetRlock() 
         Repl DATA__ With dData,; 
              INDICE With nIndice 
      ENDIF 
   ENDIF 
   IF MOE->( NetRLock() ) 
      Replace MOE->INDICE With VAR->INDICE 
   ENDIF 
   Set( _SET_DELIMITERS, .T. ) 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( 0 ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
