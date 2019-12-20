// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 

#ifdef HARBOUR
function parcela()
#endif


aFormaPag:= {} 
FOR nCt:= 1 to 5 
    AAdd( aFormaPag, { 100,; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         CTOD( "  /  /  " ),; 
                         SPACE( 4 ) } ) 
NEXT 
Parcelamento( 12550, aFormaPag ) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � Parcelamento 
� Finalidade  � Processar parcelamento de dividas 
� Parametros  � nValorTotal - Valor Total do Item a parcelar 
� Retorno     � aParcelado - Array multi-dimencional com parcelamento 
�             �              e forma de pagamento. 
�             � aFormaPag  - Forma de pagamento 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function Parcelamento( nValorTotal, aFormaPag ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lRecalcular:= .T., lParcelas:= .F. 
Local nRow:= 1 
Local nArea:= Select(), nOrdem:= IndexOrd() 
 
Local nDemaisParcelas:= 20, nParcelas:= 12 
 
   IF aFormaPag == Nil 
      aFormaPag:= {} 
   ENDIF 
 
   Set( _SET_DATEFORMAT, "DD/MM/YYYY" ) 
 
   VPBox( 10, 10, 19, 69, " Forma de Pagamento ", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 11,12 Say " Valor Total    " + Tran( nValorTotal, "@E 999,999,999.99" ) 
   @ 12,12 Say "���������������������������������������������������������" 
   @ 13,12 Say "    %    Prz Pr  % Acr           Valor 1� Vencim. Tipo  " 
 
   IF Len( aFormaPag ) <= 1 
      AAdd( aFormaPag, { 100,; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         CTOD( "  /  /  " ),; 
                         SPACE( 4 ) } ) 
      nParcelas:= 1 
      nPercentual:= 100 / nParcelas 
      nDemaisParcelas:= nPercentual 
      nParcela1:= nPercentual 
      IF ! INT( nPercentual ) == nPercentual 
         nParcela1:= INT( nPercentual ) + 1 
         nDemaisParcelas:= ( 100 - nParcela1 ) / ( nParcelas - 1 ) 
      ENDIF 
   ENDIF 
   oTb:= TbrowseNew( 14, 12, 18, 68 ) 
   oTb:Addcolumn( tbcolumnnew(,{|| Tran( aFormaPag[ nRow ][ 1 ], "@E 999.99" ) } ) ) 
   oTb:Addcolumn( tbcolumnnew(,{|| Tran( aFormaPag[ nRow ][ 2 ], "@E 999" ) } ) ) 
   oTb:Addcolumn( tbcolumnnew(,{|| Tran( aFormaPag[ nRow ][ 3 ], "@E 99" ) } ) ) 
   oTb:Addcolumn( tbcolumnnew(,{|| Tran( aFormaPag[ nRow ][ 4 ], "@E 999.99" ) } ) ) 
   oTb:Addcolumn( tbcolumnnew(,{|| Tran( aFormaPag[ nRow ][ 5 ], "@E 9999,999,999.99" ) } ) ) 
   oTb:Addcolumn( tbcolumnnew(,{|| DTOC( aFormaPag[ nRow ][ 6 ] ) } ) ) 
   oTb:Addcolumn( tbcolumnnew(,{|| aFormaPag[ nRow ][ 7 ] } ) ) 
   oTb:GoBottomBlock:= {|| nRow:= Len( aFormaPag ) } 
   oTb:GoBottomBlock:= {|| nRow:= 1 } 
   oTb:SkipBlock:= {|x| SkipperArr( x, aFormaPag, @nRow ) } 
   oTb:AUTOLITE:=.F. 
   oTb:dehilite() 
   oTb:ColorSpec:= SetColor() + "," + _COR_GET_REALSE + "," + _COR_GET_CURSOR 
 
   /* Refaz o browse */ 
   oTb:RefreshAll() 
   WHILE !oTb:Stabilize() 
   ENDDO 
 
   WHILE .T. 
 
      oTb:ColorRect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 6, 1 } ) 
      oTb:ColorRect( { oTb:ROWPOS, oTb:COLPOS, oTb:ROWPOS, oTb:COLPOS }, { 7, 1 } ) 
 
      WHILE NextKey()=0 .OR.! oTb:Stabilize() 
      ENDDO 
 
      IF ( nTecla:= InKey( 0 ) ) == K_ESC 
         Exit 
      ENDIF 
 
      DO CASE 
 
         CASE nTecla==K_UP         ;oTb:up() 
 
         CASE nTecla==K_LEFT       ;oTb:Left() 
 
         CASE nTecla==K_RIGHT      ;oTb:Right() 
 
         CASE nTecla==K_DOWN       ;oTb:down() 
 
         CASE nTecla==K_PGUP       ;oTb:pageup() 
 
         CASE nTecla==K_PGDN       ;oTb:pagedown() 
 
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
 
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
 
         CASE nTecla==K_INS 
              AAdd( aFormaPag, { 0,; 
                        0,; 
                        0,; 
                        0,; 
                        0,; 
                        CTOD( "  /  /  " ),; 
                        SPACE( 4 ) } ) 
              oTb:Down() 
              ++nParcelas 
              lRecalcular:= .T. 
 
         CASE nTecla==K_ENTER .OR. nTecla == K_F9 .OR.; 
              Upper( Chr( nTecla ) ) $ "01234567890ABCDEFGHIJKLMNOPQRSTUVXYZW" 
 
              lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
              IF Upper( Chr( nTecla ) ) $ "01234567890ABCDEFGHIJKLMNOPQRSTUVXYZW" 
                 Keyboard Chr( nTecla ) 
              ENDIF 
 
              xEdicao:= aFormaPag[ nRow ][ oTb:ColPos ] 
 
              IF oTb:ColPos == 1 
                 @ Row(), Col() Get xEdicao Pict "@E 999.99" 
                 lParcelas:= .T. 
              ELSEIF oTb:ColPos == 2 
                 @ Row(), Col() Get xEdicao Pict "@E 999" 
              ELSEIF oTb:ColPos == 3 
                 @ Row(), Col() Get xEdicao Pict "@E 99" 
              ELSEIF oTb:ColPos == 4 
                 @ Row(), Col() Get xEdicao Pict "@E 999.99" 
              ELSEIF oTb:ColPos == 5 
                 @ Row(), Col() Get xEdicao Pict "@E 9999,999,999.99" 
              ELSE 
                 @ Row(), Col() Get xEdicao 
              ENDIF 
              READ 
 
              IF LastKey() <> K_ESC 
 
                 aFormaPag[ nRow ][ oTb:ColPos ]:= xEdicao 
 
                 IF oTb:ColPos < 7 
                    oTb:Right() 
                 ELSEIF oTb:ColPos == 7 
                    oTb:Down() 
                    oTb:Left() 
                    oTb:Left() 
                    oTb:Left() 
                    oTb:Left() 
                    oTb:Left() 
                    oTb:Left() 
                    oTb:Left() 
                 ENDIF 
                 Keyboard Chr( LastKey() ) 
 
              ENDIF 
              Set( _SET_DELIMITERS, lDelimiters ) 
              lRecalcular:= .T. 
 
         OTHERWISE              ;tone(125); tone(300) 
 
     ENDCASE 
 
     IF lRecalcular 
        nPercentuais:= 0 
        nPercPadrao:= nDemaisParcelas 
        FOR nCt:= 1 TO Len( aFormaPag ) 
 
            IF lParcelas 
               IF nCt == nRow 
                  nPercentuais:= nPercentuais + aFormaPag[ nCt ][ 1 ] 
                  nPercPadrao:= ( 100 - nPercentuais ) / ( nParcelas - nRow ) 
 
 
               ELSEIF nCt > nRow 
                  aFormaPag[ nCt ][ 1 ]:= nPercPadrao 
               ELSEIF nCt < nRow 
                  nPercentuais:= nPercentuais + aFormaPag[ nCt ][ 1 ] 
               ENDIF 
            ENDIF 
 
            /* Valor fatia */ 
            nValorFatia:= ( nValorTotal * aFormaPag[ nCt ][ 1 ] ) / 100 
 
            /* Valor da Parcela */ 
            nValorParcela:= nValorFatia / aFormaPag[ nCt ][ 2 ] 
 
            /* Valor do Juros s/ parcela */ 
            IF aFormaPag[ nCt ][ 6 ] > DATE() 
               nMeses:= ( aFormaPag[ nCt ][ 6 ] - Date() ) / 30 
               nValorJuros:= ( nValorParcela * ( aFormaPag[ nCt ][ 4 ] + nMeses ) ) / 100 
            ELSE 
               nValorJuros:= ( nValorParcela * aFormaPag[ nCt ][ 4 ] ) / 100 
            ENDIF 
 
            aFormaPag[ nCt ][ 5 ]:= nValorParcela + nValorJuros 
 
        NEXT 
        oTb:RefreshAll() 
        WHILE !oTb:Stabilize() 
        ENDDO 
 
        // Consistencia das Parcelas = 100% 
        IF lParcelas 
           nSomaPerc:= 0 
           lNegativo:= .F. 
           FOR nCt:= 1 TO Len( aFormaPag ) 
               nSomaPerc:= nSomaPerc + aFormaPag[ nCt ][ 1 ] 
               IF aFormaPag[ nCt ][ 1 ] < 0 
                  lNegativo:= .T. 
               ENDIF 
           NEXT 
           IF ! nSomaPerc == 100 .OR. lNegativo 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Percentuais estao incorretos.", 12 ) 
              Mensagem( "Pressione [ENTER] para continuar..." ) 
              Pausa() 
              ScreenRest( cTelaRes ) 
           ENDIF 
        ENDIF 
 
        lRecalcular:= .F. 
        lParcelas:= .F. 
     ENDIF 
 
     oTb:Refreshcurrent() 
     oTb:Stabilize() 
 
  ENDDO 
 
  Set( _SET_DATEFORMAT, "DD/MM/YY" ) 
 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  Return Nil 
 
  /* 
  �����������������������������Ŀ 
  � TOTAL     �        1.250,00 � 
  �������������������������������������������������������Ŀ 
  �  %  �Parc.� Pr � % Acr �      Valor � 1� Venc. � Tipo � 
  � 050 � 03  � 01 � 10.50 �     125.00 � 15/01/98 � DUP  � 
  � 050 � 03  � 01 � 10.50 �     135.00 � 15/04/98 � CCV  � 
  �     �     �    �       �            �          �      � 
  �     �     �    �       �            �          �      � 
  �     �     �    �       �            �          �      � 
  �������������������������������������������������������Ĵ 
  � VALOR     �                  � DIF  �                 � 
  ��������������������������������������������������������� 
  */ 
 
 
