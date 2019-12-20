// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC36000 
� Finalidade  � Cadastro de Similaridades 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc36000
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      oTab 
 
   VPBox( 0, 0, 22, 79, " CADASTRO DE SIMILARIDADE ", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   dbSelectAr( _COD_SIMILAR ) 
   dbgotop() 
   SetCursor(1) 
   MENSAGEM("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
   VPBox( 09, 00, 23, 79, " Descricao ", _COR_BROW_BOX, .F., .F. ) 
   SetColor( _COR_BROWSE ) 
   oTab:=tbrowsedb( 10, 01, 22, 78 ) 
   oTab:addcolumn(tbcolumnnew(,{|| CODIG1 + " " + DESCR1 + " " + CODIG2 + " " + DESCR2 + SIMNAO })) 
   oTab:AUTOLITE:=.F. 
   oTab:dehilite() 
   WHILE .T. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab:stabilize() 
      enddo 
      ExibeInfo() 
      if ( TECLA:=inkey(0) )==K_ESC 
         exit 
      endif 
      do case 
         case TECLA==K_UP         ;oTab:up() 
         case TECLA==K_LEFT       ;oTab:up() 
         case TECLA==K_RIGHT      ;oTab:down() 
         case TECLA==K_DOWN       ;oTab:down() 
         case TECLA==K_PGUP       ;oTab:pageup() 
         case TECLA==K_PGDN       ;oTab:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
         case TECLA==K_F3         ;DBMudaOrdem( 2, oTab ) 
         case TECLA==K_F2         ;DBMudaOrdem( 1, oTab ) 
         case TECLA==K_F4         ;DBMudaOrdem( 3, oTab ) 
         case DBPesquisa( TECLA, oTab ) 
         case TECLA==K_INS        ;IncluiSimilar( oTab ) 
         case TECLA==K_DEL 
              lDELETE:=.T. 
              if(netrlock(5),exclui(oTab),nil) 
              dbUnlockAll() 
         case TECLA==K_ENTER 
      otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � incluiSimilar 
� Finalidade  � Cadastramento de Contas Similares 
� Parametros  � oTab 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function IncluiSimilar( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   cGrupo1:= "000" 
   cGrupo2:= "000" 
   cCodig1:= "0000000" 
   cCodig2:= "0000000" 
   cDescri1:= " " 
   cDescri2:= " " 
   cSimNao:= "S" 
   cSNCad_:= "N" 
   VPBox( 00, 00, 09, 79, "INCLUSAO DE SIMILARIDADE", _COR_GET_BOX, .F., .F. ) 
   VPBox( 02, 50, 08, 78, "Relacao de Selecao", _COR_GET_BOX, .F., .F. ) 
   SetColor( _COR_GET_EDICAO ) 
   WHILE .T. 
       Keyboard Chr( K_ENTER ) 
       /* Principal */ 
       @ 02,02 Say "Produto Principal:" Get cCodig1 Pict "@R 999-9999" Valid BuscaProdutos( @cCodig1, @cDescri1 ) 
       @ 03,02 Say "Produto Similar..:" Get cCodig2 Pict "@R 999-9999" Valid BuscaProdutos( @cCodig2, @cDescri2 ) 
       @ 04,02 Say "Reciprocidade....:" Get cSimNao  Pict "!" Valid cSimNao $ "SN" When; 
         mensagem( "Digite [S] caso haja reciprocidade de similaridade entre os produtos." ) 
       @ 05,02 Say "Cadeia Similar...:" Get cSNCad_ Pict "!" Valid cSimNao $ "SN" When; 
         Mensagem( "Digite [S] p/ o sist.localize a cadeia de similaridade do produto similar." ) 
       READ 
       IF !( LastKey() == K_ESC ) 
          DBSetOrder( 3 ) 
          IF cCodig1==cCodig2 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             Aviso( "Atencao! Produto principal e similar sao identicos." ) 
             Pausa() 
             ScreenRest( cTelaRes ) 
             Loop 
          ELSEIF DBSeek( cCodig1 + cCodig2 ) .OR. DBSeek( cCodig2 + cCodig1 ) 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             Aviso( "Atencao! J� existe esta similaridade." ) 
             Pausa() 
             ScreenRest( cTelaRes ) 
             Loop 
          ELSE 
             DBSetOrder( 4 ) 
             IF DBSeek( cCodig2 + cCodig1 ) .OR. DBSeek( cCodig1 + cCodig2 ) 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                Aviso( "Atencao! J� existe esta similaridade." ) 
                Pausa() 
                ScreenRest( cTelaRes ) 
                Loop 
             ENDIF 
          ENDIF 
       ENDIF 
       IF LastKey() <> K_ESC 
          Scroll( 03, 51, 07, 77, 1 ) 
          @ 07,51 Say Tran( cCodig1, "@R 999-9999" ) + IF( cSimNao=="S", " <�> ", " ��> " )+ ; 
                      Tran( cCodig2, "@R 999-9999" ) + cSimNao 
          DBAppend() 
          Replace CODIG1 With cCodig1,; 
                  CODIG2 With cCodig2,; 
                  DESCR1 With cDescri1,; 
                  DESCR2 With cDescri2,; 
                  COMP01 With cCodig1+cCodig2,; 
                  COMP02 With IF( cSimNao=="S", cCodig2+cCodig1, " " ),; 
                  SIMNAO With cSimNao 
          IF cSNCad_=="S" 
             MPR->( DBSetOrder( 1 ) ) 
             DBSelectAr( _COD_SIMILAR ) 
             DBSetOrder( 1 ) 
             SIM->( DBSetOrder( 1 ) ) 
             SIM->( DBSeek( cCodig2 ) ) 
             cIndice:= cCodig2 
             aSimilar:= 0 
             aSimilar:= {} 
             WHILE !SIM->( EOF() ) 
                IF ALLTRIM( SIM->CODIG1 ) == Alltrim( cIndice ) 
                   IF MPR->( DBSeek( SIM->CODIG2 ) ) 
                      AAdd( aSimilar, { MPR->INDICE, Left( MPR->DESCRI, 30 ), MPR->SALDO_, MPR->PRECOV, MPR->ORIGEM } ) 
                   ENDIF 
                ELSE 
                   EXIT 
                ENDIF 
                DBSkip() 
             ENDDO 
             SIM->( DBSetOrder( 2 ) ) 
             SIM->( DBSeek( cCodig2 ) ) 
             WHILE !SIM->( EOF() ) 
                 IF ALLTRIM( SIM->CODIG2 ) == Alltrim( cCodig2 ) .AND. SIM->SIMNAO=="S" 
                    IF MPR->( DBSeek( SIM->CODIG1 ) ) 
                       AAdd( aSimilar, { MPR->INDICE, Left( MPR->DESCRI, 30 ), MPR->SALDO_, MPR->PRECOV, MPR->ORIGEM } ) 
                    ENDIF 
                 ELSE 
                    EXIT 
                 ENDIF 
                 DBSkip() 
             ENDDO 
             lGravar:= .T. 
             FOR nCt:=1 TO Len( aSimilar ) 
                 cCodig2:= alltrim( aSimilar[ nCt ][ 1 ] ) 
                 cDescri2:= aSimilar[ nCt ][ 2 ] 
                 IF !( LastKey() == K_ESC ) 
                    DBSetOrder( 3 ) 
                    IF cCodig1==cCodig2 
                       lGravar:= .F. 
                    ELSEIF DBSeek( cCodig1 + cCodig2 ) .OR. DBSeek( cCodig2 + cCodig1 ) 
                       lGravar:= .F. 
                    ENDIF 
                 ELSE 
                    DBSetOrder( 4 ) 
                    IF DBSeek( cCodig2 + cCodig1 ) .OR. DBSeek( cCodig1 + cCodig2 ) 
                       lGravar:= .F. 
                    ENDIF 
                 ENDIF 
                 IF lGravar 
                    Scroll( 03, 51, 07, 77, 1 ) 
                    @ 07,51 Say Tran( cCodig1, "@R 999-9999" ) + IF( cSimNao=="S", " <�> ", " ��> " )+ ; 
                                Tran( cCodig2, "@R 999-9999" ) + cSimNao 
 
                    DBAppend() 
                    Replace CODIG1 With cCodig1,; 
                            CODIG2 With cCodig2,; 
                            DESCR1 With cDescri1,; 
                            DESCR2 With cDescri2,; 
                            COMP01 With cCodig1+cCodig2,; 
                            COMP02 With IF( cSimNao=="S", cCodig2+cCodig1, " " ),; 
                            SIMNAO With cSimNao 
                 ENDIF 
             NEXT 
          ENDIF 
          cCodig2:= "0000000" 
       ELSE 
          EXIT 
       ENDIF 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � ExibeInfo 
� Finalidade  � Exibicao de Informacoes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
   Function ExibeInfo() 
   Local cCor:= SetColor() 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,02 Say "Produto Principal: [" + Tran( CODIG1, "@R 999-9999" ) + "] " + DESCR1 
   @ 03,02 Say "Produto Similar..: [" + Tran( CODIG2, "@R 999-9999" ) + "] " + DESCR2 
   @ 04,02 Say "Reciprocidade....: [" + SIMNAO + "]" 
   SetColor( cCor ) 
   Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � BUSCAPRODUTOS 
� Finalidade  � Fazer pesquisa de um produto en uma tabela de produtos 
� Parametros  � cCodigo 
� Retorno     � .T./.F. 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function BuscaProdutos( cCodigo, cDescri ) 
MPR->( DBSetOrder( 1 ) ) 
IF !MPR->( DBSeek( cCodigo ) ) 
   VisualProdutos( cCodigo ) 
   cCodigo:= SubStr( MPR->INDICE, 1, 7 ) 
   cDescri:= MPR->DESCRI 
ENDIF 
Return IF( !LastKey()==K_ESC, .T., .F. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � SIMILARIDADE 
� Finalidade  � Lancar os produtos similares em uma tela 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 28/Abril/1999 
��������������� 
*/ 
Function Similaridade( oTbR ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aSimilar, nArea:= Select(), nOrdem:= MPR->( IndexOrd() ) 
Local cDigito:= "NIL" 
   nRegistro:= MPR->( RECNO() ) 
   VPBox( 0, 0, 22, 79, " PRODUTOS COM SIMILARIDADE ", _COR_GET_BOX ) 
   cProduto:= MPR->DESCRI 
   cDetal1:=  MPR->DETAL1 
   cDetal2:=  MPR->DETAL2 
   cDetal3:=  MPR->DETAL3 
   cIndice:=  MPR->INDICE 
   DBSelectAr( _COD_SIMILAR ) 
   DBSetOrder( 1 ) 
   MPR->( DBSetOrder( 1 ) ) 
   SIM->( DBSetOrder( 1 ) ) 
   SIM->( DBSeek( MPR->INDICE ) ) 
   aSimilar:= {} 
   WHILE !SIM->( EOF() ) 
       IF ALLTRIM( SIM->CODIG1 ) == Alltrim( cIndice ) 
          IF MPR->( DBSeek( SIM->CODIG2 ) ) 
             AAdd( aSimilar, { MPR->INDICE, Left( MPR->DESCRI, 30 ), MPR->SALDO_, MPR->PRECOV, MPR->ORIGEM } ) 
          ENDIF 
       ELSE 
          EXIT 
       ENDIF 
       DBSkip() 
   ENDDO 
   SIM->( DBSetOrder( 2 ) ) 
   SIM->( DBSeek( cIndice ) ) 
   WHILE !SIM->( EOF() ) 
       IF ALLTRIM( SIM->CODIG2 ) == Alltrim( cIndice ) .AND. SIM->SIMNAO=="S" 
          IF MPR->( DBSeek( SIM->CODIG1 ) ) 
             AAdd( aSimilar, { MPR->INDICE, Left( MPR->DESCRI, 30 ), MPR->SALDO_, MPR->PRECOV, MPR->ORIGEM } ) 
          ENDIF 
       ELSE 
          EXIT 
       ENDIF 
       DBSkip() 
   ENDDO 
   SetColor( _COR_GET_EDICAO ) 
   dbSelectAr( _COD_SIMILAR ) 
   dbgotop() 
   SetCursor(1) 
   mensagem("[INS]Inclui [ENTER]Altera [DEL]Exclui e [Nome]Pesquisa") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
   VPBox( 00, 00, 06, 79, " PRODUTO PRINCIPAL ", _COR_GET_BOX, .F., .F. ) 
   @ 01,01 Say cProduto Color "15/01" 
   @ 03,01 Say cDetal1  Color "15/01" 
   @ 04,01 Say cDetal2  Color "15/01" 
   @ 05,01 Say cDetal3  Color "15/01" 
   VPBox( 07, 00, 22, 79, " PRODUTOS SIMILARES ", _COR_BROW_BOX, .F., .F. ) 
   SetColor( _COR_BROWSE ) 
   if len( aSimilar ) <= 0 
      AAdd( aSimilar, { Space( 12 ), Space( 45 ), 0, 0, Space( 3 ) } ) 
   endif 
   nRow:= 1 
   oTab:=tbrowseNew( 08, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew(,{|| aSimilar[ nRow ][ 1 ] + " " + aSimilar[ nRow ][ 2 ] + " " + Tran( aSimilar[ nRow ][ 3 ], "@E 9,999,999.99" ) + " " + Tran( aSimilar[ nRow ][ 4 ], "@E 9,999,999.99" ) + " " + aSimilar[ nRow ][ 5 ] })) 
   oTab:GoTopBlock:= {|| nRow:= 1 } 
   oTab:GoBottomBlock:= {|| nRow:= Len( aSimilar ) } 
   oTab:SkipBlock:= {|x| SkipperArr( x, aSimilar, @nRow ) } 
   oTab:AUTOLITE:=.F. 
   oTab:dehilite() 
   WHILE .T. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab:stabilize() 
      enddo 
      if ( TECLA:=inkey(0) )==K_ESC 
         exit 
      endif 
      do case 
         case TECLA==K_UP         ;oTab:up() 
         case TECLA==K_LEFT       ;oTab:up() 
         case TECLA==K_RIGHT      ;oTab:down() 
         case TECLA==K_DOWN       ;oTab:down() 
         case TECLA==K_PGUP       ;oTab:pageup() 
         case TECLA==K_PGDN       ;oTab:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
         case TECLA==K_ENTER 
              cDigito:= aSimilar[ nRow ][ 1 ] 
              EXIT 
      otherwise                   ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   dbSelectAr( nArea ) 
   MPR->( DBGoTo( nRegistro ) ) 
   IF !cDigito=="NIL" 
      MPR->( DBSeek( cDigito ) ) 
   ENDIF 
   MPR->( DBSetOrder( nOrdem ) ) 
   oTbR:RefreshAll() 
   WHILE !oTbR:Stabilize() 
   ENDDO 
   Return .T. 
 
