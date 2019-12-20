// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � CONVERSOR 
� Finalidade  � Conversor de Moedas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function ConversorMoedas( cModulo, cVariavel, cOutros, cDiversos ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local nLin1:= 4, nCol1:= 20, lDisplay:= .T. 
Local GetList:= {} 
Local aMoedas:= {}, dDataOrigem:= DATE(), nValor:= PrecoConvertido(),; 
      dDataDestino:= DATE(), nValorConvertido:= 0,; 
      nArea:= Select() 
 
   IF !File( _VPB_VARIACOES ) 
      CreateVpb( _COD_VARIACOES ) 
   ENDIF 
 
   IF !File( _VPB_MOEDAS ) 
      CreateVpb( _COD_MOEDAS ) 
   ENDIF 
 
   DBSelectAr( _COD_VARIACOES ) 
   IF !USED() 
      FDBUseVpb( _COD_VARIACOES, 2 ) 
   ENDIF 
   DBSelectAr( _COD_MOEDAS ) 
   IF !USED() 
      FDBUseVpb( _COD_MOEDAS, 2 ) 
   ENDIF 
   DBSetOrder( 1 ) 
   DBGoTop() 
   WHILE !EOF() 
       AAdd( aMoedas, { CODIGO, SIGLA_, INDICE } ) 
       DBSkip() 
   ENDDO 
 
 
   IF len( aMoedas ) < 2 
      Aviso( "A quantidade de moedas disponiveis � insuficiente." ) 
      Pausa() 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      IF nArea > 0 
         DBSelectAr( nArea ) 
      ENDIF 
      Return Nil 
   ENDIF 
 
 
   nOrigem:= 2 
   nDestino:= 1 
   DBSelectAr( _COD_VARIACOES ) 
   DBSetOrder( 2 ) 
   Set Filter To CODIGO==nDestino .OR. CODIGO==nOrigem 
   dData:= DATE() 
   nIndice:= 0 
   IF !DBSeek( DATE() ) 
      VPBox( 10, 10, 13, 60, " Dolar - Hoje: (" + DTOC( DATE() ) + ")", _COR_GET_EDICAO ) 
      SetColor( _COR_GET_EDICAO ) 
      SetCursor( 1 ) 
      @ 12, 15 Get dData 
      @ 12, 25 Get nIndice Pict "@E 999,999.9999" 
      READ 
      IF nIndice > 0 .AND. LastKey()<>K_ESC 
         DBAppend() 
         Replace INDICE With nIndice,; 
                 DATA__ With dData,; 
                 CODIGO With 2 
      ENDIF 
      SetCursor( 0 ) 
      ScreenRest( cTela ) 
   ENDIF 
   DBGoBottom() 
 
   lCalcular:= .T. 
   SetColor( _COR_BROWSE ) 
   SetColor( _COR_ALERTA_BOX ) 
   oTAB:=tbrowseDB( nLin1 + 5, nCol1 + 15, nLin1 + 9, nCol1 + 35 ) 
   oTAB:addcolumn(tbcolumnnew(,{|| DTOC( DATA__ ) + " " + Tran( INDICE, "@E 999,999.9999" ) })) 
   oTAB:AUTOLITE:=.f. 
   oTAB:dehilite() 
   oTab:Up() 
   oTab:Up() 
   oTab:Up() 
   oTab:Up() 
   whil .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTAB:Stabilize() 
      end 
      IF lDisplay 
          DispBegin() 
          Mensagem( "[Seta Esquerda]Origem [Seta Direita]Destino [����]Move [Enter]Valor [����]Sair" ) 
          VPBox( nLin1, nCol1, nLin1 + 15, nCol1 + 50, " CONVERSAO DE MOEDAS ", _COR_ALERTA_BOX ) 
          SetColor( _COR_ALERTA_BOX ) 
          @ nLin1 + 1, nCol1 + 1 Say " Origem     �       VARIACOES       � Destino    " 
          @ nLin1 + 2, nCol1 + 1 Say "�������������������������������������������������" 
          @ nLin1 + 3, nCol1 + 1 Say "            �     <<<�������>>>     �            " 
          @ nLin1 + 4, nCol1 + 1 Say "�������������������������������������������������" 
          @ nLin1 + 5, nCol1 + 1 Say "            �                       �            " 
          @ nLin1 + 6, nCol1 + 1 Say "            �                       �            " 
          @ nLin1 + 7, nCol1 + 1 Say "            �                       �            " 
          @ nLin1 + 8, nCol1 + 1 Say "�����������Ĵ                       �������������" 
          @ nLin1 + 9, nCol1 + 1 Say "            �                       �            " 
          @ nLin1 +10, nCol1 + 1 Say "�������������������������������������������������" 
          @ nLin1 +11, nCol1 + 1 Say " Valor Base            999.999.9999              " 
          @ nLin1 +12, nCol1 + 1 Say " Data Inicial          DD/MM/AA                  " 
          @ nLin1 +13, nCol1 + 1 Say " Data Correcao         DD/MM/AA                  " 
          @ nLin1 +14, nCol1 + 1 Say " Valor Corrigido       999.999.9999  [%-      ]  " 
          lDisplay:= .F. 
          @ nLin1+11,nCol1+24 Say nValor Pict "@E 999,999.9999" 
          @ nLin1+12,nCol1+24 Say dDataOrigem 
          @ nLin1+13,nCol1+24 Say dDataDestino 
          @ nLin1+14,nCol1+24 Say Tran( nValorConvertido, "@E 999,999.9999" ) 
          @ nLin1+14,nCol1+40 Say Tran( ( ( nValorConvertido / nValor ) * 100 ) - 100, "@E 999.99" ) 
          @ nLin1 + 3, nCol1 + 1 Say aMoedas[ nOrigem ][ 2 ] 
          //@ nLin1 + 5, nCol1 + 1 Say aMoedas[ nDestino ][ 2 ] 
          @ nLin1 + 3, nCol1 + 38 Say aMoedas[ nDestino ][ 2 ] 
          //@ nLin1 + 5, nCol1 + 38 Say aMoedas[ nOrigem ][ 2 ] 
          /* Re-apresentacao das moedas */ 
          //FOR nCt:= 1 TO Len( aMoedas ) 
          //   nLin:= nLin1 + 5 
          //   IF !( nCt == nOrigem .OR. nCt == nDestino ) 
          //      @ nLin+=2,nCol1 + 1 Say aMoedas[ nCt ][ 2 ] 
          //      @ nLin,nCol1 + 38 Say aMoedas[ nCt ][ 2 ] 
          //   ENDIF 
          //   IF nLin==9 
          //      EXIT 
          //   ENDIF 
          //NEXT 
 
          IF lCalcular 
              DBSeek( dDataOrigem, .T. ) 
              IF DATA__ > dDataOrigem .OR. EOF() 
                 DBSkip( -1 ) 
              ENDIF 
              nValorOriginal:= INDICE 
              DBSeek( dDataDestino, .T. ) 
              IF DATA__ > dDataDestino .OR. EOF() 
                 DBSkip( -1 ) 
              ENDIF 
              nValorFinal:= INDICE 
              nValorConvertido:= ( nValor / nValorOriginal ) * nValorFinal 
              IF nOrigem==1 
                 @ nLin1+9,nCol1+38 Say Tran( nValor / nValorFinal, "@E 999,999.999" ) 
                 @ nLin1+9,nCol1+1 Say Tran( nValor, "@E 999,999.999" ) 
              ELSEIF nDestino==1 
                 @ nLin1+9,nCol1+38 Say Tran( nValor * nValorFinal, "@E 999,999.999" ) 
                 @ nLin1+9,nCol1+1  Say Tran( nValor, "@E 999,999.999" ) 
              ENDIF 
              @ nLin1+14,nCol1+24 Say Tran( nValorConvertido, "@E 999,999.9999" ) 
              @ nLin1+14,nCol1+40 Say Tran( ( ( nValorConvertido / nValor ) * 100 ) - 100, "@E 999.99" ) 
 
              SetCursor( 0 ) 
              Set(_SET_DELIMITERS,.T.) 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
              lCalcular:= .F. 
          ENDIF 
 
 
          SetColor( _COR_BROW_BOX ) 
          oTab:RefreshAll() 
          WHILE !oTab:Stabilize() 
          ENDDO 
          DispEnd() 
      ENDIF 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_SPACE 
              DispBegin() 
              cTelaRes:= SaveScreen( nLin1, nCol1, nLin1+15, nCol1+50 ) 
              nTeclaRes:= Inkey(0) 
              IF nTeclaRes == K_UP 
                 IF nLin1 > 0 
                    nLin1:= nLin1 - 1 
                    oTab:nTop:= oTab:nTop - 1 
                    oTab:nBottom:= oTab:nBottom - 1 
                 ENDIF 
              ELSEIF nTeclaRes == K_DOWN 
                 IF nLin1+15 < 24 
                    nLin1:= nLin1 + 1 
                    oTab:nTop:= oTab:nTop + 1 
                    oTab:nBottom:= oTab:nBottom + 1 
                 ENDIF 
              ELSEIF nTeclaRes == K_RIGHT 
                 IF nCol1 +50 < 79 
                    nCol1:= nCol1 + 1 
                    oTab:nRight:= oTab:nRight + 1 
                    oTab:nLeft:= oTab:nLeft + 1 
                 ENDIF 
              ELSEIF nTeclaRes == K_LEFT 
                 IF nCol1 > 0 
                    nCol1:= nCol1 - 1 
                    oTab:nRight:= oTab:nRight - 1 
                    oTab:nLeft:=  oTab:nLeft - 1 
                 ENDIF 
              ENDIF 
              ScreenRest( cTela ) 
              VPBox( nLin1, nCol1, nLin1+15, nCol1+50, "CONVERSAO DE MOEDAS", _COR_ALERTA_BOX ) 
              RestScreen( nLin1, nCol1, nLin1+15, nCol1+50, cTelaRes ) 
              IF !LastKey() == K_SPACE 
                 Keyboard Chr( K_SPACE ) 
              ELSE 
                 lDisplay:= .T. 
              ENDIF 
              DispEnd() 
 
         case TECLA==K_ENTER 
 
              SetCursor( 1 ) 
              Set(_SET_DELIMITERS,.F.) 
 
              @ nLin1+11,nCol1+24 Get nValor Pict "@E 999,999.9999" 
              @ nLin1+12,nCol1+24 Get dDataOrigem 
              @ nLin1+13,nCol1+24 Get dDataDestino 
              READ 
 
              lCalcular:= .T. 
 
              DBSeek( dDataOrigem, .T. ) 
              IF DATA__ > dDataOrigem .OR. EOF() 
                 DBSkip( -1 ) 
              ENDIF 
              nValorOriginal:= INDICE 
              DBSeek( dDataDestino, .T. ) 
              IF DATA__ > dDataDestino .OR. EOF() 
                 DBSkip( -1 ) 
              ENDIF 
              nValorFinal:= INDICE 
              nValorConvertido:= ( nValor / nValorOriginal ) * nValorFinal 
              IF nOrigem==1 
                 @ nLin1+9,nCol1+38 Say Tran( nValor / nValorFinal, "@E 999,999.999" ) 
                 @ nLin1+9,nCol1+1 Say Tran( nValor, "@E 999,999.999" ) 
              ELSEIF nDestino==1 
                 @ nLin1+9,nCol1+38 Say Tran( nValor * nValorFinal, "@E 999,999.999" ) 
                 @ nLin1+9,nCol1+1  Say Tran( nValor, "@E 999,999.999" ) 
              ENDIF 
              @ nLin1+14,nCol1+24 Say Tran( nValorConvertido, "@E 999,999.9999" ) 
              @ nLin1+14,nCol1+40 Say Tran( ( ( nValorConvertido / nValor ) * 100 ) - 100, "@E 999.99" ) 
 
         case TECLA==K_UP         ;oTAB:up() 
         case TECLA==K_DOWN       ;oTAB:down() 
         case TECLA==K_LEFT 
              nOrigem:= IF( nOrigem  > 1, nOrigem - 1, Len( aMoedas ) ) 
              IF Len( aMoedas ) <= 2 
                 IF nOrigem == 1 
                    nDestino:= 2 
                 ELSE 
                    nDestino:= 1 
                 ENDIF 
              ENDIF 
              Keyboard Chr( K_ENTER ) + Chr( K_PGDN ) 
              lDisplay:= .T. 
         case DBPesquisa( Tecla, oTab ) 
         case TECLA==K_RIGHT 
              nDestino:= IF( nDestino > 1, nDestino - 1, Len( aMoedas ) ) 
              IF Len( aMoedas ) <= 2 
                 IF nDestino == 1 
                    nOrigem:= 2 
                 ELSE 
                    nOrigem:= 1 
                 ENDIF 
              ENDIF 
              lDisplay:= .T. 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
              Keyboard Chr( K_ENTER ) + Chr( K_PGDN ) 
         case TECLA==K_PGUP       ;oTAB:pageup() 
         case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
         case TECLA==K_PGDN       ;oTAB:pagedown() 
         case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTAB:refreshcurrent() 
      oTAB:Stabilize() 
   ENDDO 
   Set Filter To 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   DBSelectAr( nArea ) 
   Return Nil 
 
 
