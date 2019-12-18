#Include "Inkey.Ch"
#Include "VPF.Ch"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Pesquisa
³ Finalidade  ³ Pesquisar dados no arquivo
³ Parametros  ³
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 06/Janeiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DBPesquisa( nTecla, Obj, cDescricao )
   Local GetList:= {}
   Local cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, MaxCol() ),;
         cCodigo, cCampo:= &( IndexKey( 0 ) ),;
         lDelimiters:= Set( _SET_DELIMITERS, .F. )

  If nTecla==K_F1
     DisplayStatusDBF()
     Set( _SET_DELIMITERS, lDelimiters )
     Return( .T. )
  ElseIf nTecla == K_F6
     TabelaCondicoes()
     Set( _SET_DELIMITERS, lDelimiters )
     Return( .T. )
  ElseIf nTecla == K_F7
     TabelaPreco()
     Set( _SET_DELIMITERS, lDelimiters )
     Return( .T. )
  ElseIf nTecla == K_F12
     Calculador()
     Set( _SET_DELIMITERS, lDelimiters )
     Return( .T. )
  EndIf

  If nTecla < 40 .OR. nTecla > 122 .AND. !nTecla == ASC( "_" )
     Set( _SET_DELIMITERS, lDelimiters )
     Return( .F. )
  EndIf

  //If Chr( nTecla ) == "9"
  //   nTecla:= Asc( "" )
  //   Keyboard "9"
  //Endif

  If ValType( &( IndexKey( 0 ) ) ) == "N"       ; nTipo:= 1
  ElseIf ValType( &( IndexKey( 0 ) ) ) == "C"   ; nTipo:= 2
  ElseIf ValType( &( IndexKey( 0 ) ) ) == "D"   ; nTipo:= 4
  EndIf

  /* se a tecla for um numero e o tipo do campo for caractere */
  IF nTecla < 58 .AND. nTipo == 2
     nTipo:= 3
  ENDIF

  IF nTipo==4            /* Se tipo for data */
     cDescricao:= CTOD( Chr( nTecla ) + "0/" + SubStr( DTOC( DATE() ), 4 ) )
  ELSEIF nTecla==ASC( "_" )
     cDescricao:= Space( Len( If( nTipo==1, Str( cCampo ), cCampo ) ) )
  ELSE
     cDescricao:= Chr( nTecla ) + Space( Len( If( nTipo==1, Str( cCampo ), cCampo ) ) - 1 )
  ENDIF

  /* Se for campo data, busca o tamanho de forma diferente */
  IF nTipo == 4
     nColuna:= Len( DTOC( cDescricao ) ) + 17
  ELSE
     nColuna:= Len( cDescricao ) + 17
  ENDIF

  IF !nTecla==ASC( "_" )
     keyboard Chr( K_RIGHT )
  ENDIF
  VPBox( 20, 01, 22, nColuna,, _COR_ALERTA_BOX, .T., .T., _COR_ALERTA_TITULO )
  SetColor( _COR_GET_EDICAO )
  SetColor( _COR_ALERTA_LETRA )
  SetCursor( 1 )
  IF nTipo == 4
     @ 21, 02 Say " Pesquisa... " Get cDescricao
  ELSE
     @ 21, 02 Say " Pesquisa... " Get cDescricao Pict "@!"
  ENDIF
  Read
  IF !( nTipo == 4 )
     IF AT( "+", cDescricao ) > 0 .OR.;
        AT( "*", cDescricao ) > 0 .OR.;
        AT( "/", cDescricao ) > 0
        IF PesquisaAvancada( @cDescricao )
           SetColor( cCor )
           SetCursor( nCursor )
           ScreenRest( cTela )
           IF !Obj==Nil
              Obj:RefreshAll()
              Whil !Obj:Stabilize()
              EndDo
           ENDIF
           Set( _SET_DELIMITERS, lDelimiters )
           Return .T.
        ENDIF
     ENDIF
  ENDIF
  IF !Obj==Nil
     Obj:GoTop()
  ENDIF
  IF AT( "CODFAB", UPPER( IndexKey(0) ) ) > 0 .OR.;
     AT( "INDICE", UPPER( IndexKey(0) ) ) > 0 .OR.;
     AT( "DESCRI", UPPER( IndexKey(0) ) ) > 0 .OR.;
     AT( "DOC___", UPPER( IndexKey(0) ) ) > 0 .OR.;
     AT( "CDESCR", UPPER( IndexKey(0) ) ) > 0
     nTipo:= 2
  ENDIF
  If nTipo==1
     DBSeek( Val( cDescricao ), .T. )
  ElseIf nTipo==2
     DBSeek( cDescricao, .T. )
  ElseIf nTipo==3
     cDescricao:= StrZero( Val( cDescricao ), Len( &( IndexKey( 0 ) ) ), 0 )
     DBSeek( cDescricao, .T. )
  ElseIf nTipo==4
     DBSeek( cDescricao, .T. )
  EndIf
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  IF !Obj==Nil
     Obj:RefreshAll()
     Whil !Obj:Stabilize()
     EndDo
  ENDIF
  Set( _SET_DELIMITERS, lDelimiters )
  Return(.T.)





Function PesquisaAvancada( cDescricao )
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor()
Local oTb, aStr:= {}
Local nArea:= Select(), nTecla:= 0
Local cStrPadrao:= "±±± Nao Informado ±±±"
Local nCont:= 0, nLen:= Len( cDescricao )
Local cTipo:= Nil

   aString:= { cStrPadrao, cStrPadrao, cStrPadrao, cStrPadrao, cStrPadrao, cStrPadrao, cStrPadrao }

   cCampos:= ""
   aStrPadrao:= dbStruct()
   FOR nCt:= 1 TO LEN( aStrPadrao )
       IF nCt > 15
          EXIT
       ELSE
          IF aStrPadrao[ nCt ][ 2 ]=="C"
             cCampos:= cCampos + "+" + aStrPadrao[ nCt ][ 1 ]
          ELSEIF aStrPadrao[ nCt ][ 2 ]=="D"
             cCampos:= cCampos + "+" + "DTOC(" + aStrPadrao[ nCt ][ 1 ] + ")"
          ELSEIF aStrPadrao[ nCt ][ 2 ]=="N"
             cCampos:= cCampos + "+" + "STR(" + aStrPadrao[ nCt ][ 1 ] + ")"
          ENDIF
       ENDIF
   NEXT

   aStr:= { { "DESCRI", "C", 300, 00 },;
            { "RECNO_", "C", 10, 00 } }
   DBCreate( "TEMP.TTT", aStr )

   DBSelectAr( 123 )
   Use TEMP.TTT Alias TMP Exclusive
   DBSelectAr( nArea )
   DBGoTop()

   cString:= ""
   cDescricao:= Alltrim( cDescricao )

   /* Composicao da String a Buscar */
   FOR nCt:= 1 TO Len( cDescricao )
       IF nCont == 5
          EXIT
       ELSE
          IF SubStr( cDescricao, nCt, 1 ) $ "+*/" .OR. SubStr( cDescricao, nCt, 1 )=="/"
             aString[ ++nCont ]:= cString
             cString:= ""
             IF SubStr( cDescricao, nCt, 1 ) $ "*/"  .OR. SubStr( cDescricao, nCt, 1 )=="/"
                IF cTipo==Nil
                   cTipo:= "OU"
                ELSEIF cTipo==Nil
                   cTipo:= "E"
                ENDIF
             ELSE
                cTipo:= IF( cTipo==Nil, "E", cTipo )
             ENDIF
          ELSE
             cString:= cString + SubStr( cDescricao, nCt, 1 )
          ENDIF
       ENDIF
   NEXT

   IF !Alltrim( cString ) == ""
       FOR nCt:= 1 TO Len( aString )
           IF aString[ nCt ] == cStrPadrao
              aString[ nCt ]:= Alltrim( cString )
              EXIT
           ENDIF
       NEXT
   ENDIF

   VPBox( 00, 04, 23, 67, " SEGMENTO DE BUSCA ", _COR_BROW_BOX )
   @ 01,05 Say aString[ 1 ] + " " + cTipo Color _COR_BROW_BOX
   @ 02,05 Say aString[ 2 ] + " " + cTipo Color _COR_BROW_BOX
   @ 03,05 Say aString[ 3 ] + " " + cTipo + " " + aString[ 4 ] Color _COR_BROW_BOX

   IF cTipo=="OU"
      Locate All For AT( aString[ 1 ], &cCampos ) > 0 .OR.;
                 AT( aString[ 2 ], &cCampos ) > 0 .OR.;
                 AT( aString[ 3 ], &cCampos ) > 0 .OR.;
                 AT( aString[ 4 ], &cCampos ) > 0
   ELSEIF cTipo=="E"
       FOR nCt:= 1 TO Len( aString )
           IF aString[ nCt ]==cStrPadrao
              aString[ nCt ]:= " "
           ENDIF
       NEXT
       Locate All For AT( aString[ 1 ], &cCampos ) > 0 .AND.;
                  AT( aString[ 2 ], &cCampos ) > 0 .AND.;
                  AT( aString[ 3 ], &cCampos ) > 0 .AND.;
                  AT( aString[ 4 ], &cCampos ) > 0
   ENDIF

   SetColor( _COR_BROWSE )
   VPBox( 05, 04, 23, 67, " INFORMACOES DA PESQUISA AVANCADA ", _COR_BROW_BOX )
   DBSelectAr( 123 )
   oTb:= TBrowseDB( 06, 05, 22, 66 )
   oTB:addcolumn( tbcolumnnew(, {||   LEFT( DESCRI,  50 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI,  51, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI,  61, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI,  71, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI,  81, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI,  91, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI, 101, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI, 111, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI, 121, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI, 131, 10 ) } ) )
   oTB:addcolumn( tbcolumnnew(, {|| SubStr( DESCRI, 151, 10 ) } ) )
   oTB:AUTOLITE:=.f.
   oTb:ColSep:= "°"
   oTB:dehilite()
   DBSelectAr( nArea )
   IF FOUND()
      WHILE !EOF() .AND. !Inkey()==K_ESC .AND. !LastKey()==K_ESC .AND. !NextKey()==K_ESC
         TMP->( DBAppend() )
         Replace TMP->DESCRI With &cCampos,;
                 TMP->RECNO_ With Str( RECNO() )
         DBSelectAr( 123 )
         oTb:RefreshAll()
         WHILE !oTb:Stabilize()
         ENDDO
         DBSelectAr( nArea )
         Continue
      ENDDO
   ENDIF
   DBSelectAr( 123 )
   IF LastRec()==1
      Keyboard Chr( K_ENTER )
   ENDIF
   dbGoTop()
   oTb:RefreshAll()
   WHILE !oTb:Stabilize()
   ENDDO
   WHILE .T.
       oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,oTB:COLCOUNT},{2,1})
       whil nextkey()=0 .and.! oTB:stabilize()
       enddo
       nTecla:=inkey(0)
       if nTecla=K_ESC
          exit
       endif
       do case
          case nTecla==K_UP         ;oTB:up()
          case nTecla==K_LEFT       ;oTB:Left()
          case nTecla==K_RIGHT      ;oTB:Right()
          case nTecla==K_DOWN       ;oTB:down()
          case nTecla==K_PGUP       ;oTB:pageup()
          case nTecla==K_PGDN       ;oTB:pagedown()
          case nTecla==K_CTRL_PGUP  ;oTB:gotop()
          case nTecla==K_CTRL_PGDN  ;oTB:gobottom()
          case nTecla==K_ENTER
               DBSelectAr( nArea )
               DBGoTo( VAL( TMP->RECNO_ ) )
               TMP->( DBCloseArea() )
               ScreenRest( cTela )
               SetColor( cCor )
               Return .T.
          otherwise                ;tone(125); tone(300)
       endcase
       oTB:refreshcurrent()
       oTB:stabilize()
   enddo
   DBCloseArea()
   DBSelectAr( nArea )
   ScreenRest( cTela )
   SetColor( cCor )
   Return .F.

Static Function Buscando()
@ 03, 55 Say RECNO()
Return .T.



/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ DBLeOrdem
³ Finalidade  ³ Ler a ultima ordem colocada no arquivo
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 07/Janeiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DBLeOrdem()
  Local nArea:= Select(), cArquivo:= DBF(), nOrdem:= IndexOrd(),;
        nNovaOrdem:= IndexOrd()
  DBSelectAr( 80 )
  If UseDBFInfo()
     If DBSeek( cArquivo )
        nNovaOrdem:= DBF->ORDEM_
     Else
        nNovaOrdem:= nOrdem
     EndIf
     DBSelectAr( 80 )
     DBCloseArea()
  EndIf
  DBSelectAr( nArea )
  DBSetOrder( nNovaOrdem )
  Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ DBGuardaOrdem
³ Finalidade  ³ Guardar as ordem setadas pelos usuarios do sistema
³ Parametros  ³ Nil
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 07/Janeiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DBGuardaOrdem()
  Local nArea:= Select(), cArquivo:= DBF(), nOrdem:= IndexOrd()
  If UseDBFInfo()
     If !DBSeek( cArquivo )
        DBAppend()
        If NetRLock()
           Replace DBF->Arquiv With cArquivo, DBF->Ordem_ With nOrdem,;
                   DBF->UseNam With WUsuario, DBF->Data__ With Date(),;
                   DBF->Hora__ With Time()
        EndIf
     Else
        If NetRLock()
           Replace DBF->Ordem_ With nOrdem,;
                   DBF->UseNam With WUsuario, DBF->Data__ With Date(),;
                   DBF->Hora__ With Time()
        EndIf
     EndIf
  EndIf
  DBSelectAr( nArea )
  DBSetOrder( nOrdem )
  Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ DBMudaOrdem
³ Finalidade  ³ Mudar a Ordem do arquivo atual ( Utilizada em browse )
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 07/Janeiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DBMudaOrdem( nNovaOrdem, oObj )
  If Used()
     DBSetOrder( nNovaOrdem )
     oObj:RefreshAll()
     While !oObj:Stabilize()
     EndDo
     DisplayStatusDBF()
     DBGuardaOrdem()
  EndIf
  Return Nil




/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³                              ³³ Funcoes para utilizacao pelas demais      ³
³       ROTINAS INTERNAS       ³³ rotinas desta biblioteca                  ³
³                              ³³ 07/Janeiro/1996                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ UseDbfInfo
³ Finalidade  ³ Abrir arquivo que contem informacoes sobre DBF's
³             ³ utilizados pelo sistema
³ Parametros  ³ Nil
³ Retorno     ³ Se Utilizado (.T.)
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 07/Janeiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Static Function UseDBFInfo()
  CriaDBFInfo()
  DBSelectAr( 80 )
  If !Used()
     Use DBF_INF Alias DBF Shared
     If !File( "DBFIndice.Ntx" )
        Index On Arquiv To DBFIndice
     Else
        Set Index To DBFIndice
     EndIf
  EndIf
  Return( Used() )

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CriaDbfInfo
³ Finalidade  ³ Criar arquivo que contem informacoes sobre DBF's
³             ³ utilizados pelo sistema
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 07/Janeiro/1996
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Static Function CriaDBFInfo()
  Local aStruct:= { { "Arquiv", "C", 12, 00 },;
                    { "Ordem_", "N", 03, 00 } }
  If !File( "DBF_INF.DBF" )
     DBCreate( "DBF_INF.DBF", aStruct )
  EndIf
  Return Nil

Static Function DisplayStatusDBF()
Local cTela:= ScreenSave( 0, 0, 24, MaxCol() )
Local cAlias:= DBF(), nArea:= Select(), cChave:= IndexKey()
  UseDbfInfo()
  DBSeek( cAlias )
  IF LastKey() == K_F1
     DO CASE
        CASE UPPER( Alltrim( cChave ) ) == "UPPER( DESCRI )" .or.;
             UPPER( Alltrim( cChave ) ) == "DESCRI" .OR.;
             AT( "DESCRI", UPPER( Alltrim( cChave ) ) ) > 0
             cChave:= cChave + " - DESCRICAO "
        CASE UPPER( Alltrim( cChave ) ) == "CODIGO" .OR.;
             UPPER( Alltrim( cChave ) ) == "INDICE"
             cChave:= cChave + " - CODIGO    "
        CASE AT( "CODFAB", UPPER( Alltrim( cChave ) ) ) > 0
             cChave:= cChave + " - CODIGO DE FABRICA"
     ENDCASE
  ENDIF
  VPObsBox( .T., 10, 10, "Informacoes sobre arquivo",;
                {" Nome (Alias): " + Arquiv + Space( 30 ),;
                 " Ordem.......: " + StrZero( Ordem_, 2, 0 ),;
                 " Chave.......: " + cChave,;
                 " Dt.Ult.Ordem: " + DTOC( Data__ ),;
                 " Hs.Ult.Ordem: " + Hora__,;
                 " Usuario.....: " + UseNam }, "W+/R" )
  IF LastKey() == K_F1
     Inkey( 2 )
  ENDIF
  Inkey( 0.3 )
  ScreenRest( cTela )
  DBSelectAr( 80 )
  DBCloseArea()
  DBSelectAr( nArea )
