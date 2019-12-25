// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC35140 
* Descricao   - Verificacao de Garantia 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 
 
#ifdef HARBOUR
function vpc35140()
#endif

   Loca cTELA:=zoom( 15, 34, 21, 55 ), cCOR:=setcolor(), nOPCAO:=0
   VPBox( 15, 34, 21, 55 ) 
   whil .t. 
      Mensagem("") 
      aadd( MENULIST, swmenunew( 16, 35," 1 Por Nota        ",2,COR[11],; 
            "Lancamentos por Produto.",,,COR[6],.T.)) 
      aadd( MENULIST, swmenunew( 17, 35," 2 Por Produto     ",2,COR[11],; 
            "Lancamentos por Produto.",,,COR[6],.T.)) 
      aadd( MENULIST, swmenunew( 18, 35," 3 Todas Series    ",2,COR[11],; 
            "Visualizacao de Todas as Series.",,,COR[6],.T.)) 
      aadd( MENULIST, swmenunew( 19, 35," 4 Series Vendidas ",2,COR[11],; 
            "Visualizacao de Series Vendidas.",,,COR[6],.T.)) 
      aadd( MENULIST, swmenunew( 20, 35," 0 Retorna         ",2,COR[11],; 
            "Retorna ao menu anterior.",,,COR[6],.T.)) 
      swMenu(MENULIST,@nOPCAO); MENULIST:={} 
      do case 
         case nOpcao == 0 .OR. nOpcao == 5 
              exit 
         case nOpcao==1;  VerPorNota() 
         case nOpcao==2;  VerPorProduto() 
         case nOpcao==3;  VerSeries( .F. ) 
         case nOpcao==4;  VerSeries( .T. ) 
      endcase 
   enddo 
   Limpavar() 
   unzoom(cTELA) 
   setcolor(cCOR) 
   return(nil) 
 
 
 
 
Static Function VerPorNota() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cTipo:= "NOTA FISCAL", nNumero:= 0 
  VPBox( 00, 00, 22, 79, "VISUALIZACAO DE NUMEROS DE SERIE POR DOCUMENTO FISCAL", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  WHILE .T. 
      @ 03,03 Say "Tipo de Documento:" Get cTipo Valid TipoDocumentos( @cTipo ) 
      @ 04,03 Say "Numero Documento.:" Get nNumero Pict "@R 999999" 
      READ 
      IF LastKey() == K_ESC 
         EXIT 
      ELSE 
         IF nNumero > 0 
            VerNumerosSerie( Nil, nNumero ) 
         ENDIF 
      ENDIF 
  ENDDO 
  DBSelectAr( _COD_ROMANEIO ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/romind01.ntx","&gdir/romind02.ntx","&gdir/romind03.ntx"    
  #else 
    Set Index To "&GDir\ROMIND01.NTX","&GDir\ROMIND02.NTX","&GDir\ROMIND03.NTX"    
  #endif
  DBSelectAr( _COD_CLIENTE ) 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  Return Nil 
 
 
Static Function VerSeries( lComNota ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nTecla, cTelaRes, cProduto, nReg, nLocal, nMprOrdem 
Local cRomane, nNotaSaida, dDataEntrada, dDataSaida 
 
  VPBox( 00, 00, 22, 79, "VISUALIZACAO DE TODOS OS NUMEROS DE SERIE", _COR_GET_BOX ) 
 
  DBSelectAr( _COD_ROMANEIO ) 
  IF lComNota 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON ROMANE TO IN0000 For CODNF_ > 0 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       set index to in0000, "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"    
     #else 
       Set Index To IN0000, "&GDir\ROMIND01.NTX", "&GDir\ROMIND02.NTX", "&GDir\ROMIND03.NTX"    
     #endif
  ELSE 
     DBLeOrdem() 
  ENDIF 
 
  SetColor( _COR_BROWSE ) 
 
  /* inicializacao do objeto browse */ 
  @ 01,01 Say "                                 ENTRADA/COMPRA     SAIDA/VENDA             " Color _COR_GET_EDICAO 
  @ 02,01 Say "Numero de Serie                  Data  Garantia    Data Garantia T N.Fiscal " Color _COR_GET_EDICAO 
 
  oTb:=tbrowsedb( 03, 01, 21, 78 ) 
  oTb:addcolumn( tbcolumnnew(,{|| LEFT( ROMANE, 35 ) + " " + DTOC( DATENT ) + Str( GAR->GARANT-( DATE()-DATENT ), 5 ) + " " + DTOC( DATSAI ) + Str( if( EMPTY( DATSAI ), 0, GAR->GARANT - ( DATE()-DATSAI ) ), 5 )+" " + INTEXT + " " + StrZero( CODNF_, 8, 0 ) })) 
 
  /* variaveis do objeto browse */ 
  otb:autolite:=.f. 
  otb:dehilite() 
 
  WHILE .t. 
 
      /* ajuste sa barra de selecao */ 
		otb:colorrect( { otb:rowpos, 1, otb:rowpos, otb:colcount }, { 2, 1 } ) 
		while nextkey()=0 .and. !otb:stabilize() 
		enddo 
 
      cProduto:= CODPRO 
 
      nTecla:= Inkey( 0 ) 
		if ntecla=K_ESC 
			exit 
		endif 
 
		/* teste da tecla pressionadas */ 
		do case 
			case nTecla==K_UP 		  ;otb:up() 
			case nTecla==K_LEFT		  ;otb:panleft() 
			case nTecla==K_RIGHT 	  ;otb:panright() 
			case nTecla==K_DOWN		  ;otb:down() 
			case nTecla==K_PGUP		  ;otb:pageup() 
			case nTecla==K_PGDN		  ;otb:pagedown() 
			case nTecla==K_CTRL_PGUP  ;otb:gotop() 
			case nTecla==K_CTRL_PGDN  ;otb:gobottom() 
			case nTecla==K_F2 		  ;dbmudaordem( 1, otb ) 
			case nTecla==K_F3 		  ;dbmudaordem( 2, otb ) 
         case nTecla==K_DEL 
              IF Confirma( 0, 0, "Deseja excluir este registro (N� de serie)?", "", "S" ) 
                 IF netrlock() 
                    DBDelete() 
                 ENDIF 
              ENDIF 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
 
         case nTecla==K_ENTER 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              MPR->( DBSetOrder( 1 ) ) 
              IF MPR->( DBSeek( cProduto ) ) 
                 VPBox( 09, 01, 16, 75, "INFORMACOES", _COR_GET_BOX ) 
                 cRomane:=      ROMANE 
                 nNotaSaida:=   CODNF_ 
                 dDataEntrada:= DATENT 
                 dDataSaida:=   DATSAI 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 11,02 Say "Produto...........: [" + MPR->DESCRI + "]" 
                 @ 12,02 Say "Codigo de garantia:" Get cRomane 
                 @ 13,02 Say "Entrada/Data......:" Get dDataEntrada 
                 @ 14,02 Say "Saida/Data........:" Get dDataSaida 
                 @ 15,02 Say "Saida/Nota........:" Get nNotaSaida  Pict "@R 999999" 
                 READ 
                 SetColor( _COR_BROWSE ) 
                 nReg:= RECNO() 
                 IF LastKey() <> K_ESC 
                    DBSelectAr( _COD_ROMANEIO ) 
                    DBGoTo( nReg ) 
                    IF netrlock() 
                       Replace ROMANE With cRomane,; 
                               CODNF_ With nNotasaida,; 
                               DATSAI With dDataSaida,; 
                               DATENT With dDataEntrada 
                    ENDIF 
                 ENDIF 
                 DBGoTo( nReg ) 
              ENDIF 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
 
         case nTecla==K_INS 
              SetCursor( 1 ) 
              cTelares:= ScreenSave( 0, 0, 24, 79 ) 
              nMprOrdem:= MPR->( IndexOrd() ) 
              nLocal:= MPR->( RECNO() ) 
              MPR->( DBSetOrder( 1 ) ) 
              IF MPR->( DBSeek( cProduto ) ) 
                 VPBox( 09, 01, 16, 75, "INFORMACOES P/ CODIGO", _COR_GET_BOX ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 11,02 Say "Produto...........: [" + MPR->DESCRI + "]" 
                 @ 12,02 Say "Quantidade........:" Get nQuantidade Pict "@R 99999" When Mensagem("Digite a quantidade de codigos que deseja acrescentar." ) 
                 @ 13,02 Say "Nota Fiscal/Compra:" Get nNota       Pict "@R 99999999" When Mensagem("Digite o numero da Nota fiscal" ) 
                 @ 14,02 Say "Fornecedor........:" Get nCodFor     Pict "@R 999999" Valid BuscaFornecedor( @nCodFor ) When Mensagem( "Digite o codigo do fornecedor ou [99999] para ver lista." ) 
                 READ 
                 SetColor( _COR_BROWSE ) 
                 IF LastKey() <> K_ESC 
                    Romaneio( Nil, Nil, nQuantidade, nCodFor, nNota ) 
                    DBSelectAr( _COD_ROMANEIO ) 
                 ENDIF 
              ENDIF 
              MPR->( DBSetOrder( nMprOrdem ) ) 
              MPR->( DBGoTo( nLocal ) ) 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
              SetCursor( 0 ) 
         case DBPesquisa( nTecla, otb ) 
			otherwise					  ;tone(125); tone(300) 
	  endcase 
	  otb:refreshcurrent() 
	  otb:stabilize() 
  enddo 
  setcolor( ccor ) 
  setcursor( ncursor ) 
  screenrest( ctela ) 
  IF nArea > 0 
     dbselectar( narea ) 
     IF nOrdem > 0 
        dbsetorder( nordem ) 
     ENDIF 
  ENDIF 
  Return Nil 
 
 
 
Function TipoDocumentos( cTipo ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor() 
Local nOpcao:= 1 
   VPBox( 03, 40, 06, 60,,_COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 04,41 Prompt " NOTA FISCAL  " 
   @ 05,41 Prompt " CUPOM FISCAL " 
   menu To nOpcao 
   ScreenRest( cTela ) 
   DO CASE 
      CASE nOpcao==1 
           cTipo:= "NOTA FISCAL" 
      CASE nOpcao==2 
           cTipo:= "CUPOM FISCAL" 
   ENDCASE 
   SetColor( cCor ) 
   ScreenRest( cTela ) 
   Return .T. 
 
 
Static Function VerPorProduto() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cProduto:= "0000000" 
 
  VPBox( 00, 00, 22, 79, "VISUALIZACAO DE NUMEROS DE SERIE POR PRODUTO", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  WHILE .T. 
       VisualProdutos( "BUSCAR" ) 
       IF LastKey() == K_ESC 
          EXIT 
       ELSE 
          cProduto:= MPR->INDICE 
          VerNumerosSerie( cProduto ) 
       ENDIF 
  ENDDO 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  Return Nil 
 
 
 
 
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
  Return .T. 
 
 
 
 
 
 
 
 
