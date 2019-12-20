// ## CL2HB.EXE - Converted
 
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � PesqDupPendentes 
� Finalidade  � Buscar as duplicatas pendentes a mais de <n> dias 
� Parametros  � nDias 
� Retorno     � Nil 
� Programador � VALMOR PEREIRA FLORES 
� Data        � 19/08/1997 
��������������� 
*/ 
Function PesqDupPendentes( nDias ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
LOCAL aPendente:= {}, nPendente:= 0, nPosicao:= 0, nFim:= 0, oTab, nTecla, nRow:= 1 
 
   IF !AbreGrupo( "DUPLICATAS" ) 
      Return Nil 
   ENDIF 
   DBSelectAr( 14 ) 
   nFim:= LastRec() 
   DBGOTOP() 
   WHILE !EOF() 
      IF ! ( NFNULA == "*" ) 
         IF VENC_A <> CTOD( "  /  /  " ) 
            IF VENC_A <= ( DATE() - nDias ) .AND. DTQT_A == CTOD( "  /  /  " ) 
               ++nPendente 
               AADD( aPendente, { DUPL_A, CDESCR, VLR__A, VENC_A } ) 
            ENDIF 
         ENDIF 
         IF VENC_B <> CTOD( "  /  /  " ) 
            IF VENC_B <= ( DATE() - nDias ) .AND. DTQT_B == CTOD( "  /  /  " ) 
               ++nPendente 
               AADD( aPendente, { DUPL_B, CDESCR, VLR__B, VENC_B } ) 
            ENDIF 
         ENDIF 
         IF VENC_C <> CTOD( "  /  /  " ) 
            IF VENC_C <= ( DATE() - nDias ) .AND. DTQT_C == CTOD( "  /  /  " ) 
               ++nPendente 
               AADD( aPendente, { DUPL_C, CDESCR, VLR__C, VENC_C } ) 
            ENDIF 
         ENDIF 
         IF VENC_D <> CTOD( "  /  /  " ) 
            IF VENC_D <= ( DATE() - nDias ) .AND. DTQT_D == CTOD( "  /  /  " ) 
               ++nPendente 
               AADD( aPendente, { DUPL_D, CDESCR, VLR__D, VENC_D } ) 
            ENDIF 
         ENDIF 
      ENDIF 
      DBSkip() 
      VPTerm( ++nPosicao, nFim ) 
      Mensagem( "Analisando a duplicata " + StrZero( DUPL_A, 6, 0 ) + " no sistema, aguarde..." ) 
   ENDDO 
   VPTerm( .F. ) 
   IF nPendente > 0 
      VPTerm( .F. ) 
      VPBox( 10,10,14,40, " ATENCAO ", "W+/R",  ,  , "00/15" ) 
      SetColor( "GR+/R" ) 
      @ 11,12 Say "Existe(m) " + Alltrim( Str( nPendente, 10, 0 ) ) + " duplicata(s)" 
      @ 12,12 Say "pendente(s) a mais de " 
      @ 13,12 Say Alltrim( Str( nDias, 3, 0 ) ) + " dia(s) no sistema..." 
      Mensagem( "Pressione TAB para ver a lista ou ENTER para continuar..." ) 
      Ajuda( "[TAB]Lista [ENTER]Continua" ) 
      Inkey(0) 
      IF LastKey() == K_TAB 
         SetColor(COR[16]) 
         VPBox( 03, 06, 21, 78, "Duplicata(s) Pendente(s) a mais de " + Alltrim( Str( nDias, 3, 0 ) ) + " dia(s) " ) 
         SetCursor(0) 
         SetColor( COR[21] + "," + COR[22] + ",,," + COR[17] ) 
         Mensagem( "Pressione ESC para sair.") 
         ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
         oTab:=tbrowseNew( 04, 07, 20, 77 ) 
         oTab:addcolumn(tbcolumnnew("Duplic",{|| STRZERO( aPendente[ nRow ][ 1 ], 6, 0) })) 
         oTab:addcolumn(tbcolumnnew("Nome", {|| aPendente[ nRow ][ 2 ] } )) 
         oTab:addcolumn(tbcolumnnew("Valor", {|| Tran( aPendente[ nRow ][ 3 ], "@E 99,999.99" ) } )) 
         oTab:addcolumn(tbcolumnnew("Vencto.", {|| Tran( aPendente[ nRow ][ 4 ], "@E 99,999.99" ) } )) 
         oTab:AUTOLITE:=.f. 
         oTab:GOTOPBLOCK :={|| nRow:=1} 
         oTab:GOBOTTOMBLOCK:={|| nRow:=len( aPendente )} 
         oTab:SKIPBLOCK:={|WTOJUMP| SkipperArr(WTOJUMP, aPendente,@nRow)} 
         oTab:dehilite() 
         whil .t. 
            oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,4},{2,1}) 
            whil nextkey()=0 .and.! oTab:stabilize() 
            enddo 
            nTecla:=inkey(0) 
            If nTecla=K_ESC 
               exit 
            EndIf 
            do case 
               case nTecla==K_UP        ;oTab:up() 
               case nTecla==K_DOWN      ;oTab:down() 
               case nTecla==K_HOME      ;oTab:gotop() 
               case nTecla==K_END       ;oTab:gobottom() 
               otherwise                ;tone(125); tone(300) 
            endcase 
            oTab:refreshcurrent() 
            oTab:stabilize() 
         enddo 
      ENDIF 
   ENDIF 
   FechaArquivos() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
