// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC550000 
* Descricao   - Cadastro de ORDEM DE COMPRA 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function vpc51999()
#endif

loca cTELA:=zoom(11,24,19,41), cCOR:=setcolor(), nOPCAO:=0
vpbox(11,24,19,41) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(12,25," 1 Inclusao    ",2,COR[11],; 
        "Lancamento manual de Ordem de compra.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(13,25," 2 Alteracao   ",2,COR[11],; 
        "Alteracao de Ordem de compra.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(14,25," 3 Verificacao ",2,COR[11],; 
        "Verificacao do cadastro de Ordem de Compra.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(15,25," 4 Exclusao    ",2,COR[11],; 
        "Exclusao de Ordem de Compra.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(16,25," 5 Baixa       ",2,COR[11],; 
        "Baixa de Ordens de Compra.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(17,25," 6 Pesquisas   ",2,COR[11],; 
        "Verificacao de O. C. pendentes por fornecedor.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(18,25," 0 Retorna     ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=7; exit 
      case nOPCAO=1; do VPC59999 
      case nOPCAO=2; alteraOC()       // VPC59999 
      case nOPCAO=3; verificaOC()     // VPC59999 
      case nOPCAO=4; excluiOC()       // VPC59999 
      case nOPCAO=5; baixaOC()        // VPC59999 
      case nOpcao=6; MenuPesqOc() 
 
   endcase 
enddo 
Limpavar() 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function MenuPesqOc() 
loca cTELA:=zoom(13,34,21,73), cCOR:=setcolor(), nOPCAO:=0 
vpbox(13,34,21,73) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(14,35," 1 O.C. Pendentes                  ",2,COR[11], "",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(15,35," 2 Preco Por Produto x Fornecedor  ",2,COR[11], "",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(16,35," 3 O.C. Por Produto                ",2,COR[11], "",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(17,35," 4 O.C. Por Fornecedor             ",2,COR[11], "",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(18,35," 5 O.C. Emitidas Por Periodo       ",2,COR[11], "",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(19,35," 6 O.C. x Pedidos                  ",2,COR[11], "",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(20,35," 0 Retorna                         ",2,COR[11], "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=7; exit 
      case nOPCAO=1; IMPOrdemCompra() // IMPOC 
      case nOpcao=2; PrecoPFor() 
      case nOpcao=3; OcProdPer() 
      case nOpcao=4; OcFornec() 
      Case nOpcao=5; OcPeriodo() 
      Case nOpcao=6; OCxPed() 
   endcase 
enddo 
Limpavar() 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
/***** 
�������������Ŀ 
� Funcao      � PrecoPFor 
� Finalidade  � Fazer a busca das informacoes no banco de dados da O.C. 
� Parametros  � nCodigo == Tipo de informacao cfe. menu 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 06/Novembro/1996 
��������������� 
*/ 
FUNCTION PrecoPFor() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodFor:= 0, cCodigo:= "0000", cGrupo_:= "000", cCorRes 
Local aMatriz:= {}, aMatrizLimpa:= {}, lLoop 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo( " Ordem de Compra " ) 
 
   IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
      Return Nil 
   ENDIF 
 
   VPBox( 01, 0, 22, 79 ) 
 
   @ 02,02 Say "��������������������������������������������������������������������������Ŀ" 
   @ 03,02 Say "� Fornec.: [00000]       �                                                 �" 
   @ 04,02 Say "��������������������������������������������������������������������������Ĵ" 
   @ 05,02 Say "� Produto: [000]-[0000]  �                                                 �" 
   @ 06,02 Say "����������������������������������������������������������������������������" 
 
   WHILE LastKey() <> K_ESC 
 
      DBSelectAr( _COD_MPRIMA ) 
      ASize( aMatriz, 1 ) 
      aMatriz:= 0 
      aMatriz:= { } 
      lLoop:= .F. 
 
      @ 03,13 Get nCodFor Pict "99999" Valid BuscaFornecedor( @nCodFor, 1 )  When; 
               Mensagem( "Digite o c�digo do fornecedor.") 
 
      @ 05,13 Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo ) When; 
               Mensagem( "Digite o grupo do produto." ) 
 
      @ 05,19 Get cCodigo Pict "9999" Valid VerCodigo( @cCodigo, GetList ) When; 
               Mensagem("Digite o c�digo do produto.") 
 
      READ 
 
      IF LASTKey() == K_ESC 
         DBUnlockAll() 
         FechaArquivos() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
 
      DBSelectAr( _COD_OC ) 
      DBSetOrder( 3 ) 
 
      DBSelectAr( _COD_OC_AUXILIA ) 
      DBSetOrder( 2 ) 
      Set Relation To ORDCMP Into OC 
 
 
      DBSeek( cGrupo_ + cCodigo + Spac( 5 ) ) 
      WHILE Alltrim( CODPRO ) == Alltrim( cGrupo_ + cCodigo ) 
           Mensagem( "Buscando Ordem de Compra n� " + ORDCMP + ", aguarde..." ) 
           IF OC->CODFOR == nCodFor 
              AAdd( aMatriz, { Val( ORDCMP ), UNIDAD, QUANT_, PRECOU, TOTAL_, URECEB, RECEBI } ) 
           ENDIF 
           DBSkip() 
           if eof() 
              exit 
           endif 
      ENDDO 
      IF Len( aMatriz ) <> 0 
 
         nLinha:= 8 
 
         @ 07, 02 Say "�O.Comp�Un�Quant������VALOR �������REC ����Ŀ" 
 
         FOR nCt:= 1 TO Len( aMatriz ) 
             @ nLinha, 02 Say "�" + StrZero( aMatriz[ nCt ][ 1 ], 6, 0 ) + "�" + ; 
                              aMatriz[ nCt ][ 2 ] + "�" +; 
                              Tran( aMatriz[ nCt ][ 3 ], "@E 99999.999" ) + "�" + ; 
                              Tran( aMatriz[ nCt ][ 4 ], "@E 9999,999.999" ) + "�" + ; 
                              Tran( aMatriz[ nCt ][ 7 ], "@E 99,999.999" ) + "�" 
             ++nLinha 
             IF nLinha > 20 
                @ nLinha,02 Say "���������������������������������������������" 
                SetColor( "W+/R" ) 
                @ nLinha,55 Say " [Enter]Continuar... " 
                SetColor( cCorRes ) 
                Mensagem( "Digite o nome do produto ou pressione [ENTER] para ver proxima tela..." ) 
                nTecla:= INKEY(0) 
                DO CASE 
                   CASE Upper( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZ " 
                        lLoop:= .T. 
                        EXIT 
                   CASE nTecla == K_ESC 
                        lLoop:= .F. 
                        EXIT 
                ENDCASE 
                Scroll( 08, 02, 21, 78 ) 
                nLinha:= 8 
             ENDIF 
             cCorRes:= SetColor() 
             SetColor( "G+/B" ) 
             Scroll( 08, 51, 20, 76 ) 
             DispBox( 07, 50, 21, 77, 1 ) 
             IF ( nUltima:= Len( aMatriz ) ) > 0 
                @ 08,51 Say "Vlr.Ult.Cmp: " + Tran( aMatriz[ nUltima ][ 4 ], "@E 9,999,999.999" ) 
                @ 10,51 Say "Quant/Unid.: " + Tran( aMatriz[ nUltima ][ 3 ], "@E 999,999.99" ) + " " + aMatriz[ nUltima ][ 2 ] 
                @ 12,51 Say "Dt. Ult.Rec: " + DTOC( aMatriz[ nUltima ][ 6 ] ) 
                @ 14,51 Say "Ultima Oc..: " + StrZero( aMatriz[ nUltima ][ 1 ], 6, 0 ) 
                @ 16,51 Say "Perc.IPI...: " + Tran( MPR->IPI___, "@E 999.99" ) + "%" 
                @ 18,51 Say "Estoque....: " + Tran( MPR->SALDO_, "@E 999,999.99" ) 
             ENDIF 
             SetColor( "15/" + CorFundoAtual() ) 
             @ 09,51 Say "��������������������������" 
             @ 11,51 Say "��������������������������" 
             @ 13,51 Say "��������������������������" 
             @ 15,51 Say "��������������������������" 
             @ 17,51 Say "��������������������������" 
             @ 19,51 Say "��������������������������" 
             SetColor( cCorRes ) 
             @ nLinha,02 Say "���������������������������������������������" 
          NEXT 
      ENDIF 
      IF !lLoop 
         Mensagem( "Digite o nome do produto ou [ENTER] para mudar de fornecedor...", 1 ) 
         nTecla:= INKEY(0) 
         Scroll( 07, 02, 21, 78 ) 
         DO CASE 
            CASE Upper( Chr( nTecla ) ) $ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ " 
                 lLoop:= .T. 
            CASE nTecla == K_ESC 
                 lLoop:= .F. 
         ENDCASE 
      ENDIF 
 
      IF lLoop 
         /* Isto far� com que o passe pelo campo de codigo e chame a funcao 
            de abertura de lista OK!, quando voltar p/ cima, na parte da 
            edicao */ 
         Scroll( 07, 02, 21, 78 ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( nTecla ) 
         cGrupo_:= "999" 
         cCodigo:= "9999" 
         LOOP 
      ENDIF 
   ENDDO 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerGrupo 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerGrupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      Return( .T. ) 
   EndIf 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 ) 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
/***** 
�������������Ŀ 
� Funcao      � VerCodigo 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerCodigo( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 2 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
 
   /* Testa se grupo + codigo esta com zeros */ 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      Return( .T. ) 
   EndIf 
 
   /* Pesquisa produto na base de dados */ 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Aguarde a montagem da lista..." ) 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[2]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[3]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   @ 05,29 Say Space( 43 ) 
   @ 05,29 Say Alltrim( MPr->Descri ) 
   SetColor( "15/03" ) 
   @ 06,45 Say " Codigo fabrica -> " + Mpr->CodFab + " " 
   SetColor( cCor ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � VerGrupo2 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerGrupo2( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      Return( .T. ) 
   EndIf 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 ) 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
/***** 
�������������Ŀ 
� Funcao      � VerCodigo2 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerCodigo2( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 3 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
 
   /* Testa se grupo + codigo esta com zeros */ 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      Return( .T. ) 
   EndIf 
 
   /* Pesquisa produto na base de dados */ 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Aguarde a montagem da lista..." ) 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[3]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[4]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   @ 05,29 Say Space( 42 ) 
   @ 05,29 Say Alltrim( MPr->Descri ) 
   SetColor( "15/03" ) 
   @ 06,45 Say " Codigo fabrica -> " + Mpr->CodFab + " " 
   SetColor( cCor ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � FAZER APRESENTACAO DO fornecedor PARA A ROTINA NFBUSCA 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
  Static Function Buscafornecedor( nCodigo, nCod ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  FOR->( DBSetOrder( 1 ) ) 
  IF ! FOR->( DBSeek( nCodigo ) ) 
     ForSeleciona( @nCodigo ) 
  ENDIF 
  If nCodigo <= 0 
     Return .F. 
  Endif 
  IF nCod==1 
     @ 03,29 Say FOR->DESCRI 
  ELSE 
     @ 20,15 Say FOR->DESCRI 
  ENDIF 
  Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
FUNCTION ocprodPer() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cCodigo:= "0000", cGrupo_:= "000", cCorRes 
Local aMatriz:= {}, aMatrizLimpa:= {}, lLoop 
Local dPerIni:= CTOD( "01/01/91" ), dPerFim:= Date() 
Local nPrecoMedio:= 0, nSomaTotal:= 0, nSomaQuant:= 0 
Local nLinha:= 8 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo(" COMPRAS POR PRODUTO ") 
 
   IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
      RETURN NIL 
   ENDIF 
   VPBox( 01, 0, 22, 79 ) 
 
   @ 02,02 Say "��������������������������������������������������������������������������Ŀ" 
   @ 03,02 Say "� Periodo: [dd/mm/aa] Ate [dd/mm/aa]                                       �" 
   @ 04,02 Say "��������������������������������������������������������������������������Ĵ" 
   @ 05,02 Say "� Produto: [000]-[0000]  �                                                 �" 
   @ 06,02 Say "����������������������������������������������������������������������������" 
 
   WHILE LastKey() <> K_ESC 
 
      DBSelectAr( _COD_MPRIMA ) 
      ASize( aMatriz, 1 ) 
      aMatriz:= 0 
      aMatriz:= { } 
      lLoop:= .F. 
 
      @ 03,13 Get dPerIni When; 
              Mensagem( "Digite o periodo inicial." ) 
 
      @ 03,28 GeT dPerFim When Mensagem( "Digite o periodo final." ) 
 
      @ 05,13 Get cGrupo_ Pict "999" Valid VerGrupo2( cGrupo_, @cCodigo ) When; 
               Mensagem( "Digite o grupo do produto." ) 
 
      @ 05,19 Get cCodigo Pict "9999" Valid VerCodigo2( @cCodigo, GetList ) When; 
               Mensagem("Digite o c�digo do produto.") 
      READ 
 
      IF LASTKey() == K_ESC 
         DBUnlockAll() 
         FechaArquivos() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
 
      DBSelectAr( _COD_OC ) 
      DBSetOrder( 3 ) 
 
      DBSelectAr( _COD_OC_AUXILIA ) 
      DBSetOrder( 2 ) 
      Set Relation To ORDCMP Into OC 
 
      nSomaTotal:= 0 
      nSomaQuant:= 0 
      nPrecoMedio:= 0 
      DBSeek( cGrupo_ + cCodigo + Spac( 5 ) ) 
      WHILE Alltrim( CODPRO ) == Alltrim( cGrupo_ + cCodigo ) 
           Mensagem( "Verificando Nota Fiscal N� " + ORDCMP + ", aguarde..." ) 
           IF OC->DataEM >= dPerIni .AND. OC->DataEM <= dPerFim 
              nSomaTotal+= ( PRECOU * QUANT_ ) 
              nSomaQuant+= QUANT_ 
              AAdd( aMatriz, { OC->DATAEM, VAL( ORDCMP ), OC->DESFOR, QUANT_, PRECOU, UNIDAD } ) 
           ENDIF 
           DBSkip() 
      ENDDO 
 
      nPrecoMedio:= nSomaTotal / nSomaQuant 
 
      IF Len( aMatriz ) <> 0 
         nLinha:= 8 
         @ 07, 02 Say "�Data�����O.COMP�Fornecedor���������������������������Quantidad�Valor Unit.�" 
         FOR nCt:= 1 TO Len( aMatriz ) 
             @ nLinha, 02 Say "�" + DTOC( aMatriz[ nCt ][ 1 ] ) + "�" +; 
                                    StrZero( aMatriz[ nCt ][ 2 ], 6, 0 ) + "�" + ; 
                                    Left( aMatriz[ nCt ][ 3 ], 33 ) + "�" +; 
                                    aMatriz[ nCt ][ 6 ] + "�" +; 
                                    Tran( aMatriz[ nCt ][ 4 ], "@E 9,999.999" ) + "�" + ; 
                                    Tran( aMatriz[ nCt ][ 5 ], "@E 999,999.999" ) + "�" 
             ++nLinha 
             IF nLinha > 20 
                @ nLinha,02 Say "����������������������������������������������������������������������������" 
                cCorRes:= SetColor() 
                SetColor( "15/05" ) 
                @ nLinha, 03 Say " CUSTO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 999,999.999" ) + " " 
                SetColor( "W+/R" ) 
                @ nLinha,55 Say " [Enter]Continuar... " 
                SetColor( cCorRes ) 
                Mensagem( "Digite o nome do produto ou pressione [ENTER] para ver proxima tela..." ) 
                nTecla:= INKEY(0) 
                DO CASE 
                   CASE Upper( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZ " 
                        lLoop:= .T. 
                        EXIT 
                   CASE nTecla == K_ESC 
                        lLoop:= .F. 
                        EXIT 
                ENDCASE 
                Scroll( 08, 02, 21, 78 ) 
                nLinha:= 8 
             ENDIF 
             @ nLinha, 02 Say "����������������������������������������������������������������������������" 
          NEXT 
      ENDIF 
      IF !lLoop 
         cCorRes:= SetColor() 
         SetColor( "15/05" ) 
         @ nLinha, 03 Say " CUSTO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 999,999.999" ) + " " 
         SetColor( cCorRes ) 
         Mensagem( "Digite o nome do produto ou [ENTER] para mudar de periodo...", 1 ) 
         nTecla:= INKEY(0) 
         Scroll( 07, 02, 21, 78 ) 
         DO CASE 
            CASE Upper( Chr( nTecla ) ) $ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ " 
                 lLoop:= .T. 
            CASE nTecla == K_ESC 
                 lLoop:= .F. 
         ENDCASE 
      ENDIF 
 
      IF lLoop 
         /* Isto far� com que o passe pelo campo de codigo e chame a funcao 
            de abertura de lista OK!, quando voltar p/ cima, na parte da 
            edicao */ 
         Scroll( 07, 02, 21, 78 ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( nTecla ) 
         cGrupo_:= "999" 
         cCodigo:= "9999" 
         LOOP 
      ENDIF 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � OCxPED 
� Finalidade  � Ordem de Compra x Pedidos 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
FUNCTION OCxPED() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cCodigo:= "0000", cGrupo_:= "000", cCorRes 
Local aMatriz:= {}, aMatrizLimpa:= {}, lLoop 
Local dPerIni:= CTOD( "01/01/91" ), dPerFim:= Date() 
Local nPrecoMedio:= 0, nSomaTotal:= 0, nSomaQuant:= 0 
Local nLinha:= 8 
Local nRow:= 1 
Local nRowPed:= 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo(" COMPRAS POR PRODUTO ") 
 
   IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
      RETURN NIL 
   ENDIF 
   VPBox( 01, 0, 22, 79 ) 
 
   @ 02,02 Say "��������������������������������������������������������������������������Ŀ" 
   @ 03,02 Say "� Periodo: [dd/mm/aa] Ate [dd/mm/aa]                                       �" 
   @ 04,02 Say "��������������������������������������������������������������������������Ĵ" 
   @ 05,02 Say "� Produto: [000]-[0000]  �                                                 �" 
   @ 06,02 Say "����������������������������������������������������������������������������" 
 
   WHILE LastKey() <> K_ESC 
 
      DBSelectAr( _COD_MPRIMA ) 
      ASize( aMatriz, 1 ) 
      aMatriz:= 0 
      aMatriz:= { } 
      lLoop:= .F. 
 
      @ 03,13 Get dPerIni When; 
              Mensagem( "Digite o periodo inicial." ) 
 
      @ 03,28 GeT dPerFim When Mensagem( "Digite o periodo final." ) 
 
      @ 05,13 Get cGrupo_ Pict "999" Valid VerGrupo2( cGrupo_, @cCodigo ) When; 
               Mensagem( "Digite o grupo do produto." ) 
 
      @ 05,19 Get cCodigo Pict "9999" Valid VerCodigo2( @cCodigo, GetList ) When; 
               Mensagem("Digite o c�digo do produto.") 
      READ 
 
      IF LASTKey() == K_ESC 
         DBUnlockAll() 
         FechaArquivos() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
 
      DBSelectAr( _COD_OC ) 
      DBSetOrder( 3 ) 
 
      DBSelectAr( _COD_OC_AUXILIA ) 
      DBSetOrder( 2 ) 
      Set Relation To ORDCMP Into OC 
 
      nSomaTotal:= 0 
      nSomaQuant:= 0 
      nPrecoMedio:= 0 
      DBGoTop() 
      DBSeek( cGrupo_ + cCodigo + Spac( 5 ) ) 
      WHILE Alltrim( CODPRO ) == Alltrim( cGrupo_ + cCodigo ) 
           Mensagem( "Verificando OC N� " + ORDCMP + ", aguarde..." ) 
           IF OC->DataEM >= dPerIni .AND. OC->DataEM <= dPerFim 
              nSomaTotal+= ( PRECOU * SDOREC ) 
              nSomaQuant+= SDOREC 
              AAdd( aMatriz, { OC->DATAEM, VAL( ORDCMP ), OC->DESFOR, QUANT_, PRECOU, UNIDAD, SDOREC, ENTREG  } ) 
           ENDIF 
           DBSkip() 
      ENDDO 
 
      IF Len( aMatriz ) == 0 
         AAdd( aMatriz, { CTOD( "  /  /  " ), 0, SPACE( 29 ), 0, 0, "  ", 0, CTOD( "  /  /  " ) } ) 
      ENDIF 
 
      PED->( DBSetOrder( 1 ) ) 
      DBSelectAr( _COD_PEDPROD ) 
      DBSetOrder( 3 ) 
      DBGoTop() 
      DBSeek( VAL( PAD( cGrupo_ + cCodigo, 12 ) ) ) 
      nCt:= 0 
      aPedidos:= {} 
      nUltimoCodigoCotacao:= CODIGO 
      WHILE CODPRO == VAL( cGrupo_ + cCodigo ) 
           PED->( DBSeek( PXP->CODIGO ) ) 
           IF VAL( CODPED ) > 0 
              IF nUltimoCodigoCotacao == CODIGO 
                 ++nCt 
              ELSE 
                 nCt:= 1 
                 nUltimoCodigoCotacao:=  CODIGO 
              ENDIF 
              cEntrega:= Space( 6 ) 
              nQtd:= 0 
              DO CASE 
                 CASE nCt == 1 
                      nQtd:= PED->QTD_01 
                      cEntrega:= PED->ENT_01 
                 CASE nCt == 2 
                      nQtd:= PED->QTD_02 
                      cEntrega:= PED->ENT_02 
                 CASE nCt == 3 
                      nQtd:= PED->QTD_03 
                      cEntrega:= PED->ENT_03 
                 CASE nCt == 4 
                      nQtd:= PED->QTD_04 
                      cEntrega:= PED->ENT_04 
                 CASE nCt == 5 
                      nQtd:= PED->QTD_05 
                      cEntrega:= PED->ENT_05 
                 CASE nCt == 6 
                      nQtd:= PED->QTD_06 
                      cEntrega:= PED->ENT_06 
                 CASE nCt == 7 
                      nQtd:= PED->QTD_07 
                      cEntrega:= PED->ENT_07 
              ENDCASE 
              AAdd(aPedidos, { SPACE( 8 ), 0, 0, 0, 0, "  ", 0, Space( 08 ), Space( 8 ) } ) 
              AAdd(aPedidos, { Entreg, val( PED->CODPED ), 0, 0, 0, Unidad, Quant_, cEntrega, PED->CODPED } ) 
 
              /* Relaciona o arquivos de Nota Fiscal com o produto */ 
              DBSelectAr( _COD_PRODNF ) 
              DBSetOrder( 5 ) 
              DBSelectAr( _COD_NFISCAL ) 
              DBSetOrder( 4 ) 
              Set Relation to NUMERO Into PNF 
              /* Busca o Pedido na Lista de Notas Fiscais */ 
              IF DBSeek( Val( PED->CODPED ) ) 
                 DBSelectAr( _COD_NFISCAL ) 
                 Set Relation to NUMERO Into PNF 
                 /* Pega todas as entregas j� efetuadas */ 
                 aEntregas:= 0 
                 aEntregas:= {} 
                 WHILE PEDIDO == Val( PED->CODPED ) 
                    DBSelectAr( _COD_PRODNF ) 
                    WHILE PNF->CODNF_ == NF_->NUMERO 
                        IF PNF->CODIGO == PAD( StrZero( PXP->CODPRO, 7, 0 ), 12 ) 
                           AAdd( aEntregas, { DATE(), 0, 0, 0, 0, PNF->UNIDAD, PNF->QUANT_ * (-1), "<NF>", Space( 08 ) } ) 
                        ENDIF 
                        DBSkip() 
                        IF EOF() 
                           Exit 
                        ENDIF 
                    ENDDO 
                    DBSelectAr( _COD_NFISCAL ) 
                    Set Relation to NUMERO Into PNF 
                    DBSkip() 
                    IF EOF() 
                       Exit 
                    ENDIF 
                 ENDDO 
                 nTotalEntregue:= 0 
                 FOR nCt:= 1 TO Len( aEntregas ) 
                     nTotalEntregue:= nTotalEntregue + aEntregas[ nCt ][ 7 ] 
                 NEXT 
                 /* Se o total entregue for maior que o total solicitado */ 
                 IF ( nTotalEntregue ) * (-1) >= aPedidos[ Len( aPedidos ) ][ 7 ] 
                    ADel( aPedidos, Len( aPedidos ) ) 
                    ASize( aPedidos, Len( aPedidos ) - 1 ) 
                    ADel( aPedidos, Len( aPedidos ) ) 
                    ASize( aPedidos, Len( aPedidos ) - 1 ) 
                 ELSE 
                    AAdd( aPedidos, { DATE(), 0, 0, 0, 0, "  ", nTotalEntregue, "<NF>", Space( 08 ) } ) 
                 ENDIF 
 
 
              ENDIF 
          ENDIF 
          DBSelectAr( _COD_PEDPROD ) 
          DBSkip() 
 
      ENDDO 
      nPrecoMedio:= nSomaTotal / nSomaQuant 
 
       IF Len( aPedidos ) == 0 
          AAdd( aPedidos, { CTOD( "  /  /  " ), 0, 0, 0, 0, "  ", 0, "        ", Space( 8 ) } ) 
       ENDIF 
 
       nSomaPedidos:= 0 
       FOR nCt:= 1 TO LEN( aPedidos ) 
          nSomaPedidos:= nSomaPedidos + aPedidos[ nCt ][ 7 ] 
       NEXT 
 
       nSomaOComp:= 0 
       nVlrSomaOc:= 0 
       FOR nCt:= 1 TO LEN( aMatriz ) 
           nSomaOComp:= nSomaOComp + aMatriz[ nCt ][ 7 ] 
           nVlrSomaOc:= nVlrSomaOc + ( aMatriz[ nCt ][ 5 ] * aMatriz[ nCt ][ 7 ] ) 
       NEXT 
 
 
       /* Verificacao de Ordem de Compra */ 
       Mensagem( "[TAB]Muda_Janela [ENTER Sobre o Pedido]Detalhe [ESC]Sair" ) 
       Ajuda( "[" + _SETAS + "]Movimenta [ESC]Sair" ) 
       VPBox( 0, 0, 22, 79, "ORDEM DE COMPRA x PEDIDOS", "15/02", .F., .F. ) 
       VPBox( 03, 01, 18, 39, "ORDEM DE COMPRA", _COR_BROW_BOX, .F., .F. ) 
       VPBox( 03, 40, 18, 78, "PEDIDOS", _COR_BROW_BOX, .F., .F. ) 
       SetColor( "15/08" ) 
       Scroll( 19, 01, 21, 78 ) 
       @ 02, 01 Say " Produto: " + MPR->CODFAB + " - " + MPR->DESCRI + Space( 2 ) 
       @ 19, 01 Say " Saldo Atual.........: " + Tran( MPR->SALDO_, "@E 999,999.999" ) + " " + MPR->UNIDAD 
       @ 20, 01 Say "  A Receber..........: " + Tran( nSomaOComp,                 "@E 999,999.999" ) 
       @ 21, 01 Say "          R$.........: " + Tran( nVlrSomaOC,               "@E 999,999.99" ) 
       @ 20, 41 Say "  A Entregar.........: " + Tran( nSomaPedidos,               "@E 999,999.999" ) 
       @ 21, 41 Say "          R$.........: " + Tran( MPR->PRECOV * nSomaPedidos, "@E 999,999.99" ) 
       SetColor( _COR_BROWSE ) 
       oTb:= TbrowseNew( 04, 02, 17, 38 ) 
       oTb:AddColumn( tbcolumnNew( "N�        Quantidade    Previsao",; 
              {|| StrZero( aMatriz[ nRow ][ 2 ], 8, 0 ) + " " +; 
                     Tran( aMatriz[ nRow ][ 7 ], "@E 999,999.999" ) + ; 
                     " " + aMatriz[ nRow ][ 6 ] + " " + ; 
                     DTOC( aMatriz[ nRow ][ 1 ] ) + SPACE( 6 ) } ) ) 
       oTb:AutoLite:= .F. 
       oTb:Dehilite() 
       oTb:GoTopBlock:= {|| nRow:= 1 } 
       oTb:GoBottomBlock:= {|| nRow:= Len( aMatriz ) } 
       oTb:SkipBlock:= {|x| SkipperArr( x, aMatriz, @nRow ) } 
       nJanela:= 1 
 
       oTbPed:= TbrowseNew( 04, 41, 17, 77 ) 
       oTbPed:AddColumn( tbColumnNew("N�        Quantidade Un Previsao" , {|| ; 
              IF( Alltrim( aPedidos[ nRowPed ][ 8 ] )=="<NF>", " Entregue", ; 
                           aPedidos[ nRowPed ][ 9 ] ) + " " + ; 
                     Tran( aPedidos[ nRowPed ][ 7 ], "@EZ 999,999.999" ) + " " + ; 
                           aPedidos[ nRowPed ][ 6 ] + " " + ; 
                           aPedidos[ nRowPed ][ 8 ] + Space( 20 ) } ) ) 
       oTbPed:AutoLite:= .F. 
       oTbPed:Dehilite() 
       oTbPed:GoTopBlock:= {|| nRowPed:= 1 } 
       oTbPed:GoBottomBlock:= {|| nRowPed:= Len( aPedidos ) } 
       oTbPed:SkipBlock:= {|x| SkipperArr( x, aPedidos, @nRowPed ) } 
 
       oTbPed:RefreshAll() 
       WHILE !oTbPed:Stabilize() 
       ENDDO 
 
       oTb:RefreshAll() 
       WHILE !oTb:Stabilize() 
       ENDDO 
 
       cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
       WHILE .T. 
           IF nJanela == 1 
              oTb:ColorRect( { oTb:RowPos, 1, oTb:RowPos, 1 }, { 2, 1 } ) 
              WHILE !NextKey()=0 .AND. !oTb:Stabilize() 
              ENDDO 
           ELSE 
              oTbPed:ColorRect( { oTbPed:RowPos, 1, oTbPed:RowPos, 1 }, { 2, 1 } ) 
              WHILE !NextKey()=0 .AND. !oTbPed:Stabilize() 
              ENDDO 
              DBSelectAr( _COD_PEDIDO ) 
              DBSetOrder( 6 ) 
              DispBegin() 
              oTbPed:RefreshAll() 
              WHILE !oTbPed:Stabilize() 
              ENDDO 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              oTbPed:ColorRect( { oTbPed:RowPos, 1, oTbPed:RowPos, 1 }, { 2, 1 } ) 
              IF VAL( aPedidos[ nRowPed ][ 9 ] ) > 0 .AND. DBSeek( aPedidos[ nRowPed ][ 9 ] ) 
                 cCorRes:= SetColor() 
                 VPBox( 01, 03, 05, 77, " VISUALIZACAO DO PEDIDO ", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 03,04 Say " Codigo......: " + StrZero( CODCLI, 6, 0 ) 
                 @ 04,04 Say " Nome........: " + DESCRI 
              ENDIF 
              DispEnd() 
           ENDIF 
           IF ( nTecla:= Inkey( 0 ) ) == K_ESC 
              Exit 
           ENDIF 
           IF !nTecla == K_ENTER 
              ScreenRest( cTelaRes ) 
           ENDIF 
           IF nJanela == 1 
              DO CASE 
                 CASE nTecla == K_UP     ;oTb:Up() 
                 CASE nTecla == K_DOWN   ;oTb:Down() 
                 CASE nTecla == K_RIGHT  ;oTb:Down() 
                 CASE nTecla == K_LEFT   ;oTb:Up() 
                 CASE nTecla == K_PGDN   ;oTb:PageDown() 
                 CASE nTecla == K_PGUP   ;oTb:PageUp() 
                 CASE nTecla == K_TAB    ;nJanela:= 2 
              ENDCASE 
              oTb:RefreshCurrent() 
              oTb:Stabilize() 
           ELSE 
              DO CASE 
                 CASE nTecla == K_UP     ;oTbPed:Up() 
                 CASE nTecla == K_DOWN   ;oTbPed:Down() 
                 CASE nTecla == K_RIGHT  ;oTbPed:Down() 
                 CASE nTecla == K_LEFT   ;oTbPed:Up() 
                 CASE nTecla == K_PGDN   ;oTbPed:PageDown() 
                 CASE nTecla == K_PGUP   ;oTbPed:PageUp() 
                 CASE nTecla == K_TAB    ;nJanela:= 1 
                 CASE nTecla == K_ENTER 
                      IF aPedidos[ nRowPed ][ 7 ] == 0 .OR.; 
                         VAL( aPedidos[ nRowPed ][ 9 ] ) == 0 
                         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                         Aviso( "Sem informacoes complementares." ) 
                         Mensagem( "Pressione [ENTER] para continuar." ) 
                         Pausa() 
                         ScreenRest( cTelaRes ) 
                      ELSE 
                         /* Localiza o pedido */ 
                         DBSelectAr( _COD_PEDIDO ) 
                         DBSetOrder( 6 ) 
                         oTbPed:RefreshAll() 
                         WHILE !oTbPed:Stabilize() 
                         ENDDO 
                         aArray:= 0 
                         aArray:= {} 
                         AAdd( aArray, "   " ) 
                         AAdd( aArray, "   " ) 
                         AAdd( aArray, "   " ) 
                         AAdd( aArray, "   " ) 
                         AAdd( aArray, " Endereco....: " + ENDERE ) 
                         AAdd( aArray, " Bairro......: " + BAIRRO ) 
                         AAdd( aArray, " Cidade......: " + CIDADE ) 
                         AAdd( aArray, " Estado......: " + ESTADO ) 
                         AAdd( aArray, " Fone/Fax....: " + FONFAX ) 
                         AAdd( aArray, " Contato.....: " + COMPRA ) 
                         AAdd( aArray, Repl( "�", 73 ) ) 
                         AAdd( aArray, " Vendedores..: " + VENDE1 + " / " + VENDE2 ) 
                         AAdd( aArray, " Observacoes.: " + LEFT( OBSER1, 57 ) ) 
                         AAdd( aArray, "               " + LEFT( OBSER2, 57 ) ) 
                         AAdd( aArray, " Prazo.......: " + PRAZO_ ) 
                         AAdd( aArray, " Data........: " + dtoc( DATA__ ) ) 
                         For nCt:= 5 TO 17 
                             DispBegin() 
                             VPBox( 01, 03, nCt + 1, 77, " VISUALIZACAO DO PEDIDO ", _COR_GET_BOX ) 
                             @ 03,04 Say " Codigo......: " + StrZero( CODCLI, 6, 0 ) 
                             @ 04,04 Say " Nome........: " + DESCRI 
                             For nCt2:= 5 TO nCt 
                                 IF nCt2 <= Len( aArray ) 
                                    @ nCt2,04 Say aArray[ nCt2 ] 
                                 ENDIF 
                             Next 
                             DispEnd() 
                             Inkey(.01) 
                         Next 
                         DispBegin() 
                         IF VAL( aPedidos[ nRowPed ][ 9 ] ) > 0 .AND. DBSeek( aPedidos[ nRowPed ][ 9 ] ) 
                            DispBegin() 
                            //cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                            cCorRes:= SetColor() 
                            VPBox( 01, 03, 18, 77, " VISUALIZACAO DO PEDIDO ", _COR_GET_BOX ) 
                            SetColor( _COR_GET_EDICAO ) 
                            @ 03,04 Say " Codigo......: " + StrZero( CODCLI, 6, 0 ) 
                            @ 04,04 Say " Nome........: " + DESCRI 
                            @ 05,04 Say " Endereco....: " + ENDERE 
                            @ 06,04 Say " Bairro......: " + BAIRRO 
                            @ 07,04 Say " Cidade......: " + CIDADE 
                            @ 08,04 Say " Estado......: " + ESTADO 
                            @ 09,04 Say " Fone/Fax....: " + FONFAX 
                            @ 10,04 Say " Contato.....: " + COMPRA 
                            @ 11,04 Say Repl( "�", 73 ) 
                            @ 12,04 Say " Vendedores..: " + VENDE1 + " / " + VENDE2 
                            @ 13,04 Say " Observacoes.: " + LEFT( OBSER1, 57 ) 
                            @ 14,04 Say "               " + LEFT( OBSER2, 57 ) 
                            @ 15,04 Say " Prazo.......: " + PRAZO_ 
                            @ 16,04 Say " Data........: " + dtoc( DATA__ ) 
                            DispEnd() 
                            DispEnd() 
                            INKEY(0) 
                            DispBegin() 
                            ScreenRest( cTelaRes ) 
                            SetColor( cCorRes ) 
                         ENDIF 
                         DispEnd() 
                      ENDIF 
              ENDCASE 
              oTbPed:RefreshCurrent() 
              oTbPed:Stabilize() 
           ENDIF 
       ENDDO 
 
      IF lLoop 
         /* Isto far� com que o passe pelo campo de codigo e chame a funcao 
            de abertura de lista OK!, quando voltar p/ cima, na parte da 
            edicao */ 
         Scroll( 07, 02, 21, 78 ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( nTecla ) 
         cGrupo_:= "999" 
         cCodigo:= "9999" 
         LOOP 
      ENDIF 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � ocPeriodo 
� Finalidade  � Notas Fiscais Emitidas no periodo 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
��������������� 
*/ 
FUNCTION ocPeriodo() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniOC:= 0, nFimOC:= 99999999, nOrdem:= 1, nDevice:= 1, nSoma1:= 0, nSoma2:= 0,; 
      nTecla, nRow:= 1, nSoma3:= 0, nSoma4:= 0, nSomaMes:= 0, aGrafico:= {} 
Local cArquivo:= "BOBAO" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
usermodulo(" Ordem de Compra ") 
IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
nLin:= 08 
nCol:= 11 
VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de ORDENS DE COMPRA Emitidas" ) 
@ nLin+02, nCol + 2 Say "��������������������������������Ŀ �����������������������Ŀ" 
@ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � �                       �" 
@ nLin+04, nCol + 2 Say "��������������������������������Ĵ �                       �" 
@ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � �                       �" 
@ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
@ nLin+08, nCol + 2 Say "�   Intervalo de Ordem de Comp.  � �                       �" 
@ nLin+09, nCol + 2 Say "��������������������������������Ĵ �  Monitor  Impressora  �" 
@ nLin+10, nCol + 2 Say "� De: [99999999] At�: [99999999] � �                       �" 
@ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
 
@ nLin + 05, nCol + 08 Get dIniEmissao 
@ nLin + 05, nCol + 24 Get dFimEmissao 
@ nLin + 10, nCol + 09 Say nIniOc Pict "@E 99999999" 
@ nLin + 10, nCol + 25 Say nFimOc Pict "@E 99999999" 
READ 
@ nLin + 09, nCol + 40 Prompt "Monitor" 
@ nLin + 09, nCol + 49 Prompt "Impressora" 
MENU TO nDevice 
 
WHILE LastKey() <> K_ESC 
      aMatriz:= { } 
      DBSelectAr( _COD_OC ) 
      dIEmiss:= dIniEmissao 
      dFEmiss:= dFimEmissao 
      cArquivo:= "NFPESQ00.NTX" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON DATAEM TO &cArquivo EVAL {|| Processo() } ; 
               FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss 
      DBSetOrder( 1 ) 
      DBGoTop() 
      Mensagem( "Somando as Ordens de Compra, aguarde..." ) 
      cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
      WHILE ! EOF() 
          IF LastKey() == K_ESC 
             EXIT 
          ENDIF 
          nSomaMes+= Total_ 
          nSoma1+= SubTot 
          nSoma2+= Total_ 
          nSoma3+= Vlrfre 
          nSoma4+= VlrIpi 
          DBSkip() 
          cMesAno:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
          IF ! cMesAno == cMesAnoAnt .OR. EOF() 
               AAdd( aGrafico, { cMesAnoAnt, nSomaMes, 0 } ) 
               cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
               nSomaMes:= 0 
          ENDIF 
      ENDDO 
      DBGoTop() 
      IF nDevice == 1 
         vpbox(0,0,22,79,"ORDEM DE COMPRA",COR[20],.T.,.T.,COR[19]) 
         @ 19,01 Say Repl( "�", 78 ) 
         @ 20,03 Say "Total de Frete..:" + TRAN( nSoma3, "@R 999,999,999.99" ) 
         @ 21,03 Say "Total de IPI....:" + TRAN( nSoma4, "@R 999,999,999.99" ) 
         @ 20,43 Say "Sub-Total.......:" + TRAN( nSoma1, "@R 999,999,999.99" ) 
         @ 21,43 Say "Total...........:" + TRAN( nSoma2, "@R 999,999,999.99" ) 
         @ 01,02 Say "Relacao de Ordem de Compra Por periodo." 
         Mensagem( "Pressione [G] para visualizar um grafico de comparacao mensal." ) 
         @ 01,45 Say "Periodo de " + DTOC( dIniEmissao ) + " ate " + DTOC( dFimEmissao ) + "." 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "O.COMPRA Fornecedor                     Emissao      SubTotal      Vlr.Total  " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowseDB(03,01,18,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| ORDCMP })) 
         oTab:addColumn(tbcolumnnew(,{|| Left( DESFOR, 30 ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| DATAEM } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( SUBTOT, "@e 99,999,999.99" ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( TOTAL_, "@e 99,999,999.99" ) } )) 
         oTAB:AUTOLITE:=.f. 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,5},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               case Chr( nTecla ) $ "Gg" 
                    Grafico( aGrafico ) 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ELSEIF nDevice == 2 
         // Set Printer To Arquivo.Txt 
         Set Device To Print 
         nLinI:= 0 
         nMatriz4:= 0 
         nMatriz5:= 0 
         nMatriz6:= 0 
         nMatriz7:= 0 
         cOrdem:= "Ordem de Compra" 
         nPagina:= 0 
         @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "             RELACAO DE ORDEM DE COMPRA EM " + DTOC( Date() ) 
         @ ++nLinI,01 Say cOrdem + "        =>  Ordem de Compra " + Alltrim( Str( nIniOc, 8, 0 ) ) + " ate " + Alltrim( Str( nFimOc, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         @ ++nLinI,01 Say "O.Compra Fornecedor                   Emissao       Sub-Total     Total                    Valor IPI                Valor ICMs" 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         DBGOTop() 
         WHILE !EOF() 
             @ ++nLinI,01 Say StrZero( NUMERO, 6, 0 ) 
             @ nLinI,08  Say Left( CDESCR, 30 ) 
             @ nLinI,38  Say DATAEM 
             @ nLinI,48  Say Tran( VLRSUB, "@e 999,999,999.99" ) 
             @ nLinI,71  Say Tran( TOTAL_, "@e 999,999,999.99" ) 
             @ nLinI,90  Say Tran( VLRIPI, "@e 999,999,999.99" ) 
             @ nLinI,118 Say Tran( 0, "@e 999,999,999.99" ) 
             If nLinI >= 60 
                nLinI:= 0 
                @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "             RELACAO DE ORDEM DE COMPRA EM " + DTOC( Date() ) 
                @ ++nLinI,01 Say cOrdem + "        =>  Ordem de Compra " + Alltrim( Str( nIniOc, 8, 0 ) ) + " ate " + Alltrim( Str( nFimOc, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
                @ ++nLinI,01 Say "O.Compra Fornecedor                   Emissao       Sub-Total     Total                    Valor IPI                Valor ICMs" 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
             Endif 
             DBSkip() 
         ENDDO 
         @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
         @ ++nLinI, 05 Say "******..........:" + TRAN( nSoma3, "@R 999,999,999.99" ) 
         @ nLinI,   40 Say "**********......:" + TRAN( nSoma2, "@R 999,999,999.99" ) 
         @ ++nLinI, 05 Say "************....:" + TRAN( nSoma1, "@R 999,999,999.99" ) 
         @ nLinI,   40 Say "Total...........:" + TRAN( nSoma4, "@R 999,999,999.99" ) 
         @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
      ENDIF 
      Set Device To Screen 
      IF LastKey() <> K_ESC 
         Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
         Inkey(0) 
         Scroll( 07, 02, 21, 78 ) 
         Exit 
      ENDIF 
ENDDO 
DBSelectAr( _COD_OC ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/ocxind01.ntx", "&gdir/ocxind02.ntx", "&gdir/ocxind03.ntx"    
#else 
  Set Index To "&GDir\OCXIND01.NTX", "&GDir\OCXIND02.NTX", "&GDir\OCXIND03.NTX"    
#endif
IF File( cArquivo ) 
   FErase( cArquivo ) 
ENDIF 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
FUNCTION Grafico( aGrafico ) 
LOCAL cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor() 
LOCAL nSoma:= 0, nMaior:= 0, nDivide:= 1, nMes:= 0 
LOCAL aMes:= { "J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D" } 
FOR nCt:= 1 TO Len( aGrafico ) 
    nSoma+= aGrafico[ nCt ][ 2 ] 
NEXT 
FOR nCt:= 1 TO Len( aGrafico ) 
    aGrafico[ nCt ][ 3 ]:= ( aGrafico[ nCt ][ 2 ] / nSoma ) * 100 
    IF aGrafico[ nCt ][ 3 ] > nMaior 
       nMaior:= aGrafico[ nCt ][ 3 ] 
    ENDIF 
NEXT 
 
IF nMaior >= 20 
   nDivide:= 3 
ELSEIF nMaior >= 60 
   nDivide:= 4 
ELSEIF nMaior >= 80 
   nDivide:= 5 
ELSEIF nMaior >= 100 
   nDivide:= 6 
ELSE 
   nDivide:= 1 
ENDIF 
 
/* APRESENTA O GRAFICO */ 
VPBOX( 00, 00, 19, 79, "GRAFICO DE MOVIMENTO MENSAL", "15/00", .F., .F., "00/15" ) 
SetColor( "15/00" ) 
nLinDisp:= 19 
nColDisp:= 70 
FOR nCt1:= 1 TO Len( aGrafico ) 
    nLin:= 19 
    SetColor( "15/" + CorFundoAtual() ) 
    nMes:= Val( Left( aGrafico[ nCt1 ][ 1 ], 2 ) ) 
    IF nMes > 0 .AND. nMes < 13 
       @ --nLin, nCt1 * 2 Say aMes[ nMes ] 
    ENDIF 
    SetColor( StrZero( nCt1, 2, 0 ) + "/" + CorFundoAtual() ) 
    FOR nCt:= ( aGrafico[ nCt1 ][ 3 ] / nDivide ) TO 0 Step -1 
        IF nCt1 * 2 < 65 
           @ --nLin, nCt1 * 2 Say "�" 
        ENDIF 
    NEXT 
    @ --nLinDisp, nColDisp Say "�" + Tran( aGrafico[nCt1][1], "@R 99-9999" ) 
    IF nLinDisp < 2 
       nLinDisp:= 19 
       nColDisp:= 60 
    ENDIF 
NEXT 
Mensagem( "Digite [V] para visualizar valores por mes." ) 
IF Chr( Inkey(0) ) $ "Vv" 
   VPBOX( 00, 00, 19, 79, "VALORES DE MOVIMENTO MENSAL", "15/00", .F., .F., "00/15" ) 
   SetColor( "15/00" ) 
   nLinDisp:= 19 
   nColDisp:= 70 
   FOR nCt1:= 1 TO Len( aGrafico ) 
       nLin:= 19 
       SetColor( StrZero( nCt1, 2, 0 ) + "/" + CorFundoAtual() ) 
       @ --nLinDisp, nColDisp Say "�" + Tran( aGrafico[nCt1][1], "@R 99-9999" ) 
       SETColor( "14/00" ) 
       @ nLinDisp, nColDisp - 15 Say Tran( aGrafico[ nCt1 ][ 2 ], "@E 999,999,999.99" ) 
       IF nLinDisp < 2 
          nLinDisp:= 19 
          nColDisp:= 40 
       ENDIF 
   NEXT 
   Mensagem( "Pressione [ENTER] para finalizar grafico de verificacao." ) 
   Pausa() 
ENDIF 
SetColor( cCor ) 
ScreenRest( cTela ) 
 
/***** 
�������������Ŀ 
� Funcao      � OCFornec 
� Finalidade  � ORDEM DE COMPRA 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
��������������� 
*/ 
FUNCTION OCFornec() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodfor:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniOc:= 0, nFimOc:= 99999999, nOrdem:= 1, nDevice:= 1, nRow:= 1, nTecla,; 
      nSoma1:= 0, nSoma2:= 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
IF !AbreGrupo( "NOTA_FISCAL" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
nLin:= 08 
nCol:= 11 
VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de Ordens de Compra Emitidas P/ Fornecedor " ) 
@ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Ordem ���������������Ŀ" 
@ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � �                       �" 
@ nLin+04, nCol + 2 Say "��������������������������������Ĵ �                       �" 
@ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � �                       �" 
@ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
@ nLin+08, nCol + 2 Say "�       Codigo do Fornecedor     � �                       �" 
@ nLin+09, nCol + 2 Say "��������������������������������Ĵ �  Monitor  Impressora  �" 
@ nLin+10, nCol + 2 Say "�           [99999999]           � �                       �" 
@ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin + 05, nCol + 08 Get dIniEmissao 
@ nLin + 05, nCol + 24 Get dFimEmissao 
DBSelectAr( _COD_FORNECEDOR ) 
DBSetOrder( 1 ) 
@ nLin + 10, nCol + 14 Get nIniOc Pict "@E 99999999" VALID ( nIniOc==0 .OR. BuscaFornecedor( @nIniOc, 2 ) ) 
READ 
nFimOc:= nIniOc 
nOrdem = 3 
@ nLin + 09, nCol + 40 Prompt "Monitor" 
@ nLin + 09, nCol + 49 Prompt "Impressora" 
MENU TO nDevice 
 
WHILE LastKey() <> K_ESC 
 
      aMatriz:= { } 
      DBSelectAr( _COD_OC ) 
      DBSetOrder( nOrdem ) 
      DBGoTop() 
 
      WHILE ! EOF() 
          IF DATAEM >= dIniEmissao .AND. DATAEM <= dFimEmissao .AND.; 
             CODFOR >= nIniOc .AND. CODFOR <= nFimOc 
             AAdd( aMatriz, { ORDCMP, DESFOR, DATAEM, SUBTOT, TOTAL_, VLRIPI, 0 } ) 
             nSoma1+= SUBTOT 
             nSoma2+= TOTAL_ 
          ENDIF 
          Mensagem( "Procesando a Nota Fiscal #" + ORDCMP + ", aguarde..." ) 
          DBSkip() 
          IF Inkey() == K_ESC 
             Exit 
          ENDIF 
      ENDDO 
      IF nDevice == 1 
         AAdd( aMatriz, { 0, "���������������������������������������", "���������", 0, 0, 0, 0 } ) 
         AAdd( aMatriz, { 0, "TOTAL GERAL                            ", DATE(), nSoma1, nSoma2, 0, 0 } ) 
         vpbox(0,0,22,79,"ORDEM DE COMPRA",COR[20],.T.,.T.,COR[19]) 
         @ 01,01 Say "Per�odo de: " + DTOC( dIniEmissao ) + " At� " + DTOC( dFimEmissao ) 
         @ 01,55 Say "Fornec. n� " + StrZero( nIniOc, 6, 0 ) 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "O.COMPRA Fornecedor                     Emissao      Valor         Total      " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowsenew(03,01,21,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 1 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Left( aMatriz[ nRow ][ 2 ], 30 ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 3 ] } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 4 ], "@e 99,999,999.99" ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 5 ], "@e 99,999,999.99" ) } )) 
         oTAB:AUTOLITE:=.f. 
         oTAB:GOTOPBLOCK :={|| nROW:=1} 
         oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aMatriz )} 
         oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nROW ) } 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,5},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ELSEIF nDevice == 2 
         // Set Printer To Arquivo.Txt 
         Set Device To Print 
         nLinI:= 0 
         nMatriz4:= 0 
         nMatriz5:= 0 
         nMatriz6:= 0 
         nMatriz7:= 0 
         cOrdem:= "ORDEM NORMAL" 
         nPagina:= 0 
         @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "           RELACAO DE ORDEM DE COMPRA EM " + DTOC( Date() ) 
         @ ++nLinI,01 Say cOrdem + "        => ORDEM DE COMPRA de " + Alltrim( Str( nIniOc, 8, 0 ) ) + " ate " + Alltrim( Str( nFimOc, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         @ ++nLinI,01 Say "O.Compra Fornecedor                   Emissao       Valor         Total                    Valor IPI               Valor Frete" 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         For nCt:= 1 TO LEN( aMatriz ) 
             @ ++nLinI,01 Say StrZero( aMatriz[ nCt ][ 1 ], 6, 0 ) 
             @ nLinI,08  Say Left( aMatriz[ nCt ][ 2 ], 30 ) 
             @ nLinI,38  Say aMatriz[ nCt ][ 3 ] 
             @ nLinI,48  Say Tran( aMatriz[ nCt ][ 4 ], "@e 999,999,999.99" ) 
             @ nLinI,71  Say Tran( aMatriz[ nCt ][ 5 ], "@e 999,999,999.99" ) 
             @ nLinI,90  Say Tran( aMatriz[ nCt ][ 6 ], "@e 999,999,999.99" ) 
             @ nLinI,118 Say Tran( aMatriz[ nCt ][ 7 ], "@e 999,999,999.99" ) 
             If nLinI >= 60 
                nLinI:= 0 
                @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "        RELACAO DE ORDEM DE COMPRA EM " + DTOC( Date() ) 
                @ ++nLinI,01 Say cOrdem + "        => Ordem Compra de " + Alltrim( Str( nIniOc, 8, 0 ) ) + " ate " + Alltrim( Str( nFimOc, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
                @ ++nLinI,01 Say "O.Compra Fornecedor                   Emissao       Valor         Total                    Valor IPI               Valor Frete" 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
             Endif 
             nMatriz4:= nMatriz4 + aMatriz[ nCt ][ 4 ] 
             nMatriz5:= nMatriz5 + aMatriz[ nCt ][ 5 ] 
             nMatriz6:= nMatriz6 + aMatriz[ nCt ][ 6 ] 
             nMatriz7:= nMatriz7 + aMatriz[ nCt ][ 7 ] 
         Next 
         @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
         @ ++nLinI, 01 Say "SOMA:" 
         @ nLinI,48  Say Tran( nmatriz4, "@e 999,999,999.99" ) 
         @ nLinI,71  Say Tran( nMatriz5, "@e 999,999,999.99" ) 
         @ nLinI,90  Say Tran( nMatriz6, "@e 999,999,999.99" ) 
         @ nLinI,118 Say Tran( nMatriz7, "@e 999,999,999.99" ) 
      ENDIF 
      Set Device To Screen 
      IF LastKey() <> K_ESC 
         Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
         Inkey(0) 
         Scroll( 07, 02, 21, 78 ) 
         Exit 
      ENDIF 
 
ENDDO 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
