// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC351200 
³ Finalidade  ³ Relacao de Produtos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function vpc35120()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      oTab 
 
   VPBox( 0, 0, 22, 79, " PRODUTOS ", _COR_BROW_BOX ) 
   SetColor( "00/03" ) 
   Scroll( 19, 01, 21, 78 ) 
   VPBox( 19, 00, 22, 79, , "15/03" ) 
 
   dbSelectAr( _COD_MPRIMA ) 
   DBLeOrdem() 
   dbgotop() 
 
   SetCursor( 1 ) 
   MENSAGEM("[Alt+I]Informacoes [Enter]Pesquisa [ESC]Finaliza") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
   SetColor( _COR_BROWSE ) 
   oTab:=tbrowsedb( 01, 01, 18, 78 ) 
   oTab:addcolumn(tbcolumnnew( "   Indice   Descricao                               Un     Saldo     Preco Org",; 
   {|| if( aviso_ > 0, StrZero( AVISO_, 2, 0 ), "  " ) + " " + PAD( ALLTRIM( INDICE ), 7 ) + " " + PAD( Alltrim( CODFAB  ) + " " + DESCRI, 40 ) + " " + UNIDAD + " " + Tran( SALDO_, "@E 9,999.999" ) + " " + Tran( PRECOV, "@E 99,999.99" ) + " " + ORIGEM + Space( 10 ) })) 
   oTab:HeadSep:= "º" 
   oTab:AUTOLITE:=.F. 
   oTab:dehilite() 
   ORG->( DBSetOrder( 3 ) ) 
   WHILE .T. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTab:stabilize() 
      enddo 
      ORG->( DBSeek( MPR->ORIGEM ) ) 
 
      nLinha:= ROW() 
      IF MPR->AVISO_ > 0 
         @ nLinha,12 Say PAD( Alltrim( CODFAB  ) + " " + DESCRI, 40 )  Color "15/" + StrZero( MPR->AVISO_, 2, 0 ) 
      ENDIF 
 
      IF oTab:nBottom == 18 
         SetColor( "00/03" ) 
         @ 20,03 Say ORG->CODABR + "-" + ORG->DESCRI 
         @ 21,03 Say MPR->DETAL1 
      ELSE 
         SetColor( "00/03" ) 
         @ 16,03 Say ORG->CODABR + "-" + ORG->DESCRI 
         @ 17,03 Say MPR->DETAL1 
         @ 18,03 Say MPR->DETAL2 
         @ 19,03 Say MPR->DETAL3 
         @ 20,03 Say MPR->DETAL4 
         @ 21,03 Say MPR->DETAL5 
      ENDIF 
      SetColor( _COR_BROWSE ) 
      if ( TECLA:=inkey(0) )==K_ESC 
         exit 
      endif 
      do case 
         case Acesso( TECLA ) 
         case TECLA==K_UP         ;oTab:up() 
         case TECLA==K_LEFT       ;oTab:up() 
         case TECLA==K_RIGHT      ;oTab:down() 
         case TECLA==K_DOWN       ;oTab:down() 
         case TECLA==K_PGUP       ;oTab:pageup() 
         case TECLA==K_PGDN       ;oTab:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
         case TECLA==K_ALT_I 
              IF oTab:nBottom==18 
                 FOR nCt:= 19 TO 15 Step -1 
                     VPBox( nCt, 00, 22, 79, , "15/03", .f., .f. ) 
                     FOR x:= 1 TO 5000 
                         ++x 
                     NEXT 
                 NEXT 
                 VPBox( 15, 00, 22, 79, , "15/03", .f., .f. ) 
                 oTab:nBottom:= 14 
              ELSE 
                 FOR nCt:= 15 TO 19 Step +1 
                     @ nCt-1,00 Say "¼" Color  _COR_BROW_BOX 
                     @ nCt-1,79 Say "½" Color  _COR_BROW_BOX 
                     VPBox( nCt, 00, 22, 79, , "15/03", .f., .f. ) 
                     FOR x:= 1 TO 5000 
                         ++x 
                     NEXT 
                     oTab:nBottom:= nCt-1 
                     oTab:RefreshAll() 
                     WHILE !oTab:Stabilize() 
                     ENDDO 
                 NEXT 
                 VPBox( 19, 00, 22, 79, , "15/03", .f., .f. ) 
                 oTab:nBottom:= 18 
              ENDIF 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
         case TECLA==K_ENTER .OR. TECLA==K_F9 
              Similaridade( oTab ) 
         case TECLA==K_F3         ;DBMudaOrdem( 2, oTab ) 
         case TECLA==K_F2         ;DBMudaOrdem( 1, oTab ) 
         case TECLA==K_F4         ;DBMudaOrdem( 3, oTab ) 
         case DBPesquisa( TECLA, oTab ) 
         case TECLA==K_INS 
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
 
