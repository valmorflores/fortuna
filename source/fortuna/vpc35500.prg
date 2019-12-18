// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TABELA DIFERENCIADA / PRECOSxTABELA 
³ Finalidade  ³ Precos x Tabela Diferenciada 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 10/09/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/
#ifdef HARBOUR
function vpc35500()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   DBSelectAr( _COD_TABPRECO ) 
   Set( _SET_DELIMITERS, .T. ) 
   DispBegin() 
 
   DBSelectAr( _COD_MPRIMA ) 
   DBLeOrdem() 
 
 
   VPBox( 00, 00, 22, 79, "LISTA DE PRODUTOS", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   oTab:=tbrowsedb( 01, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew("Codigo   Cod.Fabrica   Produto                                                         ",; 
                                       {|| Tran( MPR->INDICE, "@R 999-9999" ) + " "+; 
                                                 MPR->CODFAB + " " +; 
                                            PAD( MPR->DESCRI, 45 ) + Space( 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   WHILE .T. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      IF nTecla=K_ESC 
         EXIT 
      ENDIF 
      DO CASE 
         CASE nTecla==K_UP         ;oTab:up() 
         CASE nTecla==K_LEFT       ;oTab:PanLeft() 
         CASE nTecla==K_RIGHT      ;oTab:PanRight() 
         CASE nTecla==K_DOWN       ;oTab:down() 
         CASE nTecla==K_PGUP       ;oTab:pageup() 
         CASE nTecla==K_PGDN       ;oTab:pagedown() 
         CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         CASE nTecla==K_ENTER 
              TabelasProduto() 
 
         CASE DBPesquisa( nTecla, oTab ) 
 
         CASE nTecla==K_F2 
              DBMudaOrdem( 2, oTab ) 
 
         CASE nTecla==K_F3 
              DBMudaOrdem( 3, oTab ) 
 
         CASE nTecla==K_F4 
              DBMudaOrdem( 4, oTab ) 
 
      ENDCASE 
      oTab:refreshcurrent() 
      oTab:stabilize() 
  ENDDO 
  DBSelectAR( _COD_TABAUX ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/taxind01.ntx", "&gdir/taxind02.ntx"   
  #else 
    Set Index To "&GDir\TAXIND01.NTX", "&GDir\TAXIND02.NTX"   
  #endif
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TABELASPRODUTO 
³ Finalidade  ³ Apresentacao de tabela de Precos cfe. produtos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function TabelasProduto() 
Local nArea:= Select() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lEncontrado:= .F. 
Local aTabelas:= {} 
  PRE->( DBSetOrder( 1 ) ) 
  DBSelectAr( _COD_TABPRECO ) 
  DBSetOrder( 2 ) 
  DBGoTop() 
  aTabelas:= {} 
  WHILE !EOF() 
     AAdd( aTabelas, { PRE->CODIGO, PRE->DESCRI, 0, 0, 0, 0 } ) 
     DBSkip() 
  ENDDO 
  DBSelectAr( _COD_TABAUX ) 
  DBSetOrder( 2 ) 
  IF DBSeek( MPR->INDICE ) 
     WHILE CODPRO == MPR->INDICE 
         FOR nCt:= 1 TO Len( aTabelas ) 
             IF aTabelas[ nCt ][ 1 ] == TAX->CODIGO 
                aTabelas[ nCt ][ 3 ]:= PERACR 
                aTabelas[ nCt ][ 4 ]:= PERDES 
                aTabelas[ nCt ][ 6 ]:= MARGEM 
                lEncontrado:= .T. 
             ENDIF 
         NEXT 
         DBSkip() 
     ENDDO 
  ENDIF 
  VPBox( 05, 05, 20, 78, "Tabelas de Preco", _COR_GET_EDICAO ) 
  SetColor( _COR_GET_EDICAO ) 
  nLin:= 05 
  FOR nCt:= 1 TO Len( aTabelas ) 
      @ ++nLin, 06 Say aTabelas[ nCt ][ 2 ] 
      @ nLin, 40 Say Tran( aTabelas[ nCt ][ 6 ], "@E 99,999.99" ) 
      IF aTabelas[ nCt ][ 6 ] <= 0 
         PRE->( DBSetOrder( 1 ) ) 
         PRE->( DBSeek( aTabelas[ nCt ][ 1 ] ) ) 
         IF PRE->PERDES > 0 
            @ nLin, 40 Say Tran( PRE->PERDES * (-1), "@E 99,999.99" ) 
         ELSE 
            @ nLin, 40 Say Tran( PRE->PERACR, "@E 99,999.99" ) 
         ENDIF 
         @ nLin, 55 Say "<Generico>" 
      ELSE 
         @ nLin, 40 Get aTabelas[ nCt ][ 6 ] Pict "@E 99,999.99" 
      ENDIF 
  NEXT 
  READ 
 
  IF lEncontrado 
     PXF->( DBSetOrder( 1 ) ) 
     DBSelectAr( _COD_TABAUX ) 
     DBSetOrder( 2 ) 
     IF DBSeek( MPR->INDICE ) 
        WHILE CODPRO == MPR->INDICE 
           FOR nCt:= 1 TO Len( aTabelas ) 
                IF aTabelas[ nCt ][ 1 ] == TAX->CODIGO 
                   PXF->( DBSeek( TAX->CODPRO ) ) 
                   nPrecoC:= PXF->VALOR_ 
                   nPrecoV:= PRECOV 
                   nMargem:= aTabelas[ nCt ][ 6 ] 
                   Margem( nPrecoC, nMargem, @nPrecoV ) 
                   IF NetRLock() 
                      Replace MARGEM With aTabelas[ nCt ][ 6 ],; 
                              PRECOV With nPrecoV 
                   ENDIF 
                ENDIF 
            NEXT 
            DBSkip() 
        ENDDO 
     ENDIF 
  ELSE 
     Mensagem( "Pressione [ENTER] para continuar..." ) 
     Pausa() 
  ENDIF 
  DBSelectAr( nArea ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
