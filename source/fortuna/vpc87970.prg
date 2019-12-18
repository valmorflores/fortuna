// ## CL2HB.EXE - Converted
 
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao 	  ³ VPC87970.PRG 
³ Finalidade  ³ Inclusao / Alteracao / Exclusao de tabela de Garantia 
³ Parametros  ³ Nil 
³ Retorno	  ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data		  ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 

#ifdef HARBOUR
function vpc87970()
#endif

	LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
			cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
	DBSelectAr( _COD_GARANTIA ) 
 
	/* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	UserScreen() 
	VPBox( 00, 00, 08, 79,"TABELA DE GARANTIA/VALIDADE", _COR_GET_BOX, .F., .F. ) 
	VPBox( 09, 00, 22, 79," Display de Informa‡”es ", _COR_BROW_BOX, .F., .F., ,.F. ) 
 
	DBLeOrdem() 
	DBGoTop() 
 
	/* Ajuste de mensagens */ 
   Mensagem("[INS]Incluir [ENTER]Alterar [DEL]Excluir [+]Produtos ou [ESC]Finalizar") 
	Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
	SetColor( _COR_BROWSE ) 
	/* Inicializacao do objeto browse */ 
	oTb:=TBrowseDB( 11, 01, 21, 78 ) 
	oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI + " " + LEFT( OBSERV, 33 ) })) 
	/* Variaveis do objeto browse */ 
	oTb:AutoLite:=.f. 
	oTb:dehilite() 
	WHILE .T. 
		/* Ajuste sa barra de selecao */ 
		oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
		WHILE NextKey()=0 .AND. !oTb:Stabilize() 
		ENDDO 
		/* Display das informacoes */ 
		SetColor( _COR_GET_EDICAO ) 
		@ 02, 03 Say "C¢digo ........ [" + STR( CODIGO, 3 ) + "]" 
		@ 03, 03 Say "Descri‡„o ..... [" + DESCRI           + "]" 
		@ 04, 03 Say "Observa‡”es ... [" + OBSERV           + "]" 
		@ 05, 03 Say "Garantia Dias.. [" + STR( GARANT, 6 ) + "]" 
		@ 06, 03 Say "Validade Dias.. [" + STR( VALIDA, 6 ) + "]" 
		nTecla:=inkey(0) 
		IF nTecla=K_ESC 
			EXIT 
		ENDIF 
		/* Teste da tecla pressionadas */ 
		DO CASE 
			CASE nTecla==K_UP 		  ;oTb:up() 
			CASE nTecla==K_LEFT		  ;oTb:PanLeft() 
			CASE nTecla==K_RIGHT 	  ;oTb:PanRight() 
			CASE nTecla==K_DOWN		  ;oTb:down() 
			CASE nTecla==K_PGUP		  ;oTb:pageup() 
			CASE nTecla==K_PGDN		  ;oTb:pagedown() 
			CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
			CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
			CASE CHR( nTecla ) $ "+" 
              GarantiaEdita( oTb ) 
			CASE DBPesquisa( nTecla, oTb ) 
			CASE nTecla==K_F2 		  ;DBMudaOrdem( 1, oTb ) 
			CASE nTecla==K_F3 		  ;DBMudaOrdem( 2, oTb ) 
			CASE nTecla==K_INS		  ;GarIncluir( oTb ) 
			CASE nTecla==K_DEL		  ;Exclui( oTb ) 
			CASE nTecla==K_ENTER 	  ;GarAlterar( oTb ) 
			OTHERWISE					  ;Tone(125); Tone(300) 
	  ENDCASE 
	  oTb:RefreshCurrent() 
	  oTb:Stabilize() 
	ENDDO 
	SetColor( cCor ) 
	SetCursor( nCursor ) 
	ScreenRest( cTela ) 
	Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao 	  ³ GarIncluir 
³ Finalidade  ³ Incluir itens na tabela de GARANTIA/VALIDADE 
³ Parametros  ³ Nil 
³ Retorno	  ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data		  ³ 05/Fevereiro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
FUNCTION GarIncluir( oTb ) 
	Local cCor:= SetColor(), nCursor:= SetCursor(),; 
			cTela:= ScreenSave( 0, 0, 24, 79 ) 
	Local nCodigo:= 0, cDescri:= Space( 40 ), nGarant:= 0, nValida:= 0,; 
			cObserv:= Space( 55 ) 
 
	DBSelectAr( _COD_GARANTIA ) 
	DBSetOrder( 1 ) 
	WHILE ! LastKey() == K_ESC 
		dbGoBottom() 
		nCodigo:= CODIGO + 1 
		dbGoTop() 
		KeyBoard( CHR (K_ENTER) ) 
 
		/* Display das informacoes */ 
		SetColor( _COR_GET_EDICAO ) 
		@ 02, 03 Say "C¢digo ........" Get nCodigo Pict "999" When; 
			Mensagem("Digite o C¢digo da Garantia/Validade") VALID !DBSeek( nCodigo ) 
		@ 03, 03 Say "Descri‡„o ....." Get cDescri When; 
			Mensagem("Digite a Descri‡„o da Garantia/Validade") 
		@ 04, 03 Say "Observa‡”es ..." Get cObserv When; 
			Mensagem("Digite as Observa‡”es da Garantia/Validade" ) 
		@ 05, 03 Say "Garantia Dias.." Get nGarant Pict "999999" When; 
			Mensagem("Digite a Garantia em dias") 
		@ 06, 03 Say "Validade Dias.." Get nValida Pict "999999" When; 
			Mensagem("Digite a Validade p/ produto em dias.") 
		READ 
 
		IF DBSeek( nCodigo ) 
			cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
			Aviso( "Aten‡„o! O C¢digo da Garantia/Validade j  est  cadastrado !", 12 ) 
			Pausa() 
			ScreenRest( cTelaRes ) 
 
		ELSEIF ! LastKey() == K_ESC 
 
			 /* Gravacao de dados */ 
			 IF Confirma( 0, 0, "Confirma?", "Confirma a grava‡„o dos dados [S/N]?", "S" ) 
 
				 DBAppend() 
				 IF NetRLock() 
					 Repl CODIGO With nCodigo,; 
							DESCRI With cDESCRI,; 
							OBSERV With cObserv,; 
							GARANT With nGarant,; 
							VALIDA With nValida 
				 ENDIF 
				 Exit 
			 ENDIF 
		ENDIF 
	ENDDO 
	SetColor( cCor ) 
	SetCursor( nCursor ) 
	ScreenRest( cTela ) 
	/* Refaz o Browse */ 
	oTb:RefreshAll() 
	WHILE !oTb:Stabilize() 
	ENDDO 
	Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao 	  ³ GarAlterar 
³ Finalidade  ³ Alterar itens na tabela de Garantia/Validade 
³ Parametros  ³ Nil 
³ Retorno	  ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data		  ³ 05/Fevereiro/1998 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
STATIC FUNCTION GarAlterar( oTb ) 
	Local cCor:= SetColor(), nCursor:= SetCursor(),; 
			cTela:= ScreenSave( 0, 0, 24, 79 ) 
	Local nCodigo:= CODIGO, cDescri:= DESCRI, nGarant:= GARANT, ; 
			nValida:= VALIDA, cObserv:= OBSERV 
	DBSelectAr( _COD_GARANTIA ) 
	/* Display das informacoes */ 
	SetColor( _COR_GET_EDICAO ) 
	@ 03, 03 Say "Descri‡„o ....." Get cDescri When; 
		Mensagem("Digite a Descri‡„o da Garantia/Validade.") 
	@ 04, 03 Say "Observa‡”es ..." Get cObserv When; 
		Mensagem("Digite as Observa‡”es da Garantia/Validade.") 
	@ 05, 03 Say "Garantia Dias.." Get nGarant Pict "999999" When; 
		Mensagem("Digite o Numero de Dias da Garantia do produto. ") 
	@ 06, 03 Say "Validade Dias.." Get nValida Pict "999999" When; 
		Mensagem("Digite o Numero de Dias da Validade") 
	READ 
	IF DBSeek( nCodigo ) .AND. ! LastKey() == K_ESC 
		/* Gravacao de dados */ 
		IF Confirma( 0, 0, "Confirma?", "Confirma a grava‡„o dos dados [S/N]?", "S" ) 
			IF NetRLock() 
				Repl CODIGO With nCodigo,; 
					  DESCRI With cDESCRI,; 
					  OBSERV With cObserv,; 
					  GARANT With nGarant,; 
					  VALIDA With nValida 
			ENDIF 
		ENDIF 
	ENDIF 
	SetColor( cCor ) 
	SetCursor( nCursor ) 
	ScreenRest( cTela ) 
	/* Refaz o Browse */ 
	oTb:RefreshAll() 
	WHILE !oTb:Stabilize() 
	ENDDO 
	Return Nil 
 
 
/* Selecao de Tempo de Garantia */ 
Function SelGarantia( nCodigo ) 
	Local nArea:= Select(), nOrdem:= IndexOrd() 
	LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
			cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
	DBSelectAr( _COD_GARANTIA ) 
 
	/* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	UserScreen() 
	VPBox( 10, 10, 12, 69,"TABELA DE GARANTIA/VALIDADE", _COR_GET_BOX, .F., .F. ) 
	/* Ajuste de mensagens */ 
	Mensagem("Pressione [ENTER] para Selecionar." ) 
	Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ENTER]Seleciona [ESC]Retorna") 
 
	SetColor( _COR_BROWSE ) 
 
	DBLeOrdem() 
	DBGoTop() 
 
	/* Inicializacao do objeto browse */ 
	oTb:=TBrowseDB( 11, 01, 21, 78 ) 
	oTb:AddColumn( tbcolumnnew( ,{|| STR( CODIGO, 3 ) + " " + DESCRI })) 
 
	/* Variaveis do objeto browse */ 
	oTb:AutoLite:=.f. 
	oTb:dehilite() 
 
	WHILE .T. 
 
		/* Ajuste sa barra de selecao */ 
		oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
		WHILE NextKey()=0 .AND. !oTb:Stabilize() 
		ENDDO 
 
		nTecla:=inkey(0) 
		IF nTecla=K_ESC 
			EXIT 
		ENDIF 
 
		/* Teste da tecla pressionadas */ 
		DO CASE 
			CASE nTecla==K_UP 		  ;oTb:up() 
			CASE nTecla==K_LEFT		  ;oTb:PanLeft() 
			CASE nTecla==K_RIGHT 	  ;oTb:PanRight() 
			CASE nTecla==K_DOWN		  ;oTb:down() 
			CASE nTecla==K_PGUP		  ;oTb:pageup() 
			CASE nTecla==K_PGDN		  ;oTb:pagedown() 
			CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
			CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
			CASE nTecla==K_F2 		  ;DBMudaOrdem( 1, oTb ) 
			CASE nTecla==K_F3 		  ;DBMudaOrdem( 2, oTb ) 
			CASE DBPesquisa( nTecla, oTb ) 
			CASE nTecla==K_ENTER 
				  nCodigo:= CODIGO 
				  EXIT 
			OTHERWISE					  ;Tone(125); Tone(300) 
	  ENDCASE 
	  oTb:RefreshCurrent() 
	  oTb:Stabilize() 
	ENDDO 
	SetColor( cCor ) 
	SetCursor( nCursor ) 
	ScreenRest( cTela ) 
	IF nArea > 0 
		DBSelectAr( nArea ) 
		DBSetOrder( nOrdem ) 
   ENDIF 
   Return .T. 
 
 
#Define _PRODUTOS 	  1 
#Define _SELECIONADOS  2 
 
 
/* Edita Garantia x Produtos */ 
Function GarantiaEdita() 
	Local nArea:= Select(), nOrdem:= IndexOrd() 
	LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
			cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local cTelaRes 
   Local oTb, oTb1, oTb2, nJanela 
 
	DBSelectAR( _COD_MPRIMA ) 
 
	/* Arquivo temporario p/ Exibicao de dados */ 
	Aviso( "Transferindo informacoes, aguarde...." ) 
	Copy To TMPPROD.TMP 
 
	DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	Use TMPPROD.TMP Alias TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	INDEX ON INDICE TO INDX001 FOR GARVAL==GAR->CODIGO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   INDEX ON DESCRI TO INDX002 FOR GARVAL==GAR->CODIGO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	INDEX ON INDICE TO INDX003 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	Set Index To INDX001, INDX002, INDX003 
 
	DBSetOrder( 1 ) 
 
	DBSelectAr( _COD_MPRIMA ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
	UserModulo( GAR->DESCRI ) 
 
	SetColor( _COR_BROWSE ) 
 
	/* Ajuste de mensagens */ 
   Mensagem("Pressione [ENTER]Edita. [TAB/INSERT] para ver tabela de produtos [DEL]Exclui" ) 
	Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ENTER]Seleciona [ESC]Retorna") 
 
	DBLeOrdem() 
	DBGoTop() 
 
   // Seleciona qual janela abrir primeiro 
   nJanela:= _SELECIONADOS 
 
   /* Inicio de verificacao da janela atual */ 
   IF nJanela==_PRODUTOS 
      VPBox( 00, 00, 22, 79,,_COR_BROW_BOX ) 
   ELSE 
      VPBox( 00, 00, 22, 79,,_COR_BROW_BOX,.f.,.f. ) 
      VPBox( 00, 00, 09, 79,,_COR_GET_BOX,.f.,.f. ) 
   ENDIF 
 
   SetCursor( 0 ) 
 
	/* Inicializacao do objeto browse */ 
	oTb1:= TBrowseDB( 01, 01, 21, 78 ) 
	oTb1:AddColumn( tbcolumnnew( ,{|| INDICE + " " + DESCRI + STR( GARVAL ) + Space( 30 ) } ) ) 
	oTb1:AutoLite:=.f. 
	oTb1:dehilite() 
 
	oTb2:= TBrowseDB( 11, 01, 21, 78 ) 
	oTb2:AddColumn( tbcolumnnew( ,{|| INDICE + " " + DESCRI + str( GARVAL ) + Space( 30 ) } ) ) 
	oTb2:AutoLite:=.f. 
	oTb2:dehilite() 
 
   /* Selecao de janela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo( if( nJanela == _PRODUTOS, "CADASTRO DE PRODUTOS", "ITENS SELECIONADOS" ) ) 
   DBSelectAr( if( nJanela == _PRODUTOS, _COD_MPRIMA, 123 ) ) 
   oTb:= IF( nJanela == _PRODUTOS, oTb1, oTb2 ) 
 
	WHILE .T. 
 
		/* Ajuste sa barra de selecao */ 
		oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
		WHILE NextKey()=0 .AND. !oTb:Stabilize() 
		ENDDO 
 
		IF nJanela == _SELECIONADOS 
			@ 02,02 Say "Produto......:" + INDICE Color _COR_GET_EDICAO 
			@ 03,02 Say "Cod.fabrica  :" + CODFAB Color _COR_GET_EDICAO 
			@ 04,02 Say "Descricao    :" + DESCRI Color _COR_GET_EDICAO 
		ENDIF 
 
		nTecla:=inkey( 0 ) 
		IF nTecla=K_ESC 
			EXIT 
      ELSEIF nTecla == K_TAB .OR.; 
           ( nTecla==K_INS .and. nJanela==_SELECIONADOS ) 
			IF nJanela == _PRODUTOS 
				VPBox( 00, 00, 22, 79,,_COR_BROW_BOX,.f.,.f. ) 
				VPBox( 00, 00, 09, 79,,_COR_GET_BOX,.f.,.f. ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
				UserModulo( "ITENS SELECIONADOS" ) 
            Mensagem("Pressione [ENTER]Edita. [TAB/INSERT] para ver tabela de produtos [DEL]Exclui" ) 
				nJanela:=  _SELECIONADOS 
				DBSelectAR( 123 ) 
				DBLeOrdem() 
				oTb:= oTb2 
			ELSE 
				VPBox( 00, 00, 22, 79,,_COR_BROW_BOX,.f.,.f. ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
				UserModulo( "CADASTRO DE PRODUTOS" ) 
            Mensagem("Pressione [ENTER]Seleciona [TAB]Visualiza Selecionados" ) 
				nJanela:=  _PRODUTOS 
				DBSelectAR( _COD_MPRIMA ) 
				DBLeOrdem() 
				oTb:= oTb1 
			ENDIF 
			oTb:RefreshAll() 
			While !oTb:Stabilize() 
			Enddo 
		ENDIF 
		/* Teste da tecla pressionadas */ 
		DO CASE 
			CASE nTecla==K_TAB 
			CASE nTecla==K_UP 		  ;oTb:up() 
			CASE nTecla==K_LEFT		  ;oTb:PanLeft() 
			CASE nTecla==K_RIGHT 	  ;oTb:PanRight() 
			CASE nTecla==K_DOWN		  ;oTb:down() 
			CASE nTecla==K_PGUP		  ;oTb:pageup() 
			CASE nTecla==K_PGDN		  ;oTb:pagedown() 
			CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
			CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
			CASE nTecla==K_F2 		  ;DBMudaOrdem( 1, oTb ) 
			CASE nTecla==K_F3 		  ;DBMudaOrdem( 2, oTb ) 
			CASE DBPesquisa( nTecla, oTb ) 
         CASE nTecla==K_DEL 
              IF nJanela==_PRODUTOS 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Voce nao pode excluir um produto nesta janela." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 nMprOrdem:= MPR->( IndexOrd() ) 
                 MPR->( DBSetOrder( 1 ) ) 
                 IF MPR->( DBSeek( TMP->INDICE ) ) 
                    IF MPR->( NetRLock() ) 
                       Replace MPR->GARVAL With 0 
                       IF TMP->( NetRLock() ) 
                          Replace TMP->GARVAL With 0 
                       ENDIF 
                    ELSE 
                       SWAlerta( "Impossivel Atualizar este produto na tabela.;" +; 
                                 "Possivelmente alguem esta utilizando um processo com o mesmo;" + ; 
                                 "produto em outra area de trabalho ou desktop.", { "OK" } ) 
                    ENDIF 
                 ENDIF 
                 MPR->( DBSetOrder( nMprOrdem ) ) 
              ENDIF 
              DBUnlockAll() 
 
         CASE nTecla==K_ENTER 
				  IF nJanela == _PRODUTOS 
					  nTmp:= TMP->( IndexOrd() ) 
					  TMP->( DBSetOrder( 3 ) ) 
					  IF TMP->( DBSeek( MPR->INDICE ) ) 
						  IF TMP->( NetRLock() ) 
							  Replace TMP->GARVAL With GAR->CODIGO 
							  IF MPR->( NetRLock() ) 
								  /* Atualiza Produtos */ 
								  Replace MPR->GARVAL With GAR->CODIGO 
							  ELSE 
								  /* Desfaz TMP */ 
								  Replace TMP->GARVAL With MPR->GARVAL 
							  ENDIF 
						  ENDIF 
					  ENDIF 
					  TMP->( DBSetOrder( nTmp ) ) 
				  ELSE 
					  IF ( nOpcao:= SWAlerta( "Este produto esta selecionado!; O que voce deseja fazer?", { "Editar Codigos", "Desmarcar", "Continuar" } ) )==1 
                    VerNumerosSerie( TMP->INDICE ) 
                 ELSEIF nOpcao==2 
                 ENDIF 
				  ENDIF 
              DBUnlockAll() 
			OTHERWISE					  ;Tone(125); Tone(300) 
	  ENDCASE 
	  oTb:RefreshCurrent() 
	  oTb:Stabilize() 
	  IF nJanela == _PRODUTOS 
		  oTb1:= oTb 
	  ELSE 
		  oTb2:= oTb 
	  ENDIF 
	ENDDO 
	SetColor( cCor ) 
	SetCursor( nCursor ) 
	ScreenRest( cTela ) 
	DBSelectAr( 123 ) 
	DBCloseArea() 
	IF nArea > 0 
		DBSelectAr( nArea ) 
		DBSetOrder( nOrdem ) 
	ENDIF 
	Return Nil 
 
 
Function VerNumerosSerie( cProduto, nNotaFiscal ) 
   Local GetList:= {} 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
	Local cCor:= SetColor(), nCursor:= SetCursor(),; 
			cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nQuantidade:= 1, nNota:= 0, nCodFor:= 0 
   Local nReg 
   Local cRomane, nNotaSaida, nDataEntrada, nDataSaida, nCupomSaida 
   Local lPorNota:= .F. 
 
   Local oTb, nTecla, nLocal 
   Local cTelaRes 
 
   Priv cProd:= cProduto 
 
 
   DBSelectAr( _COD_ROMANEIO ) 
   Aviso( "Filtrando informacoes, aguarde..." ) 
 
   IF EOF() 
      DBGoTop() 
   ENDIF 
 
   /* Verifica Busca = Produto ou Nota/Cupom */ 
   IF nNotaFiscal == Nil .AND. cProd <> Nil 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON ROMANE TO IN9203 FOR CODPRO==cProd 
   ELSEIF nNotaFiscal <> Nil 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON ROMANE TO IN9203 FOR CODNF_==nNotaFiscal 
      lPorNota:= .T. 
   ELSE 
      Aviso( "Parametro incorreto... Impossivel executar operacao!" ) 
      Pausa() 
      DBSelectAr( nArea ) 
      Return Nil 
   ENDIF 
 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to in9203,"&gdir/romind01.ntx","&gdir/romind02.ntx","&gdir/romind03.ntx"    
   #else 
     Set Index To IN9203,"&GDir\ROMIND01.NTX","&GDir\ROMIND02.NTX","&GDir\ROMIND03.NTX"    
   #endif
   DBSetOrder( 1 ) 
   DBGoTop() 
 
   VPBox( 0, 00, 04, 79, "NUMEROS DE SERIE - GARANTIA / VALIDADE", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,02 Say MPR->DESCRI 
   @ 03,02 Say GAR->DESCRI 
   VPBox( 5, 00, 22, 79, "RELACAO DE NUMEROS", _COR_BROW_BOX ) 
 
   Mensagem( "Produtos & Cod.fab./Garantia - Pressione [ENTER] p/mudar informacoes." ) 
	Ajuda( "[INS]Novo [DEL]Exclui [ENTER]Visualiza" ) 
 
   SetColor( _COR_BROWSE ) 
 
 
   /* inicializacao do objeto browse */ 
   @ 06,01 Say "                                         ENTRADA/COMPRA  SAIDA/VENDA              " 
   @ 07,01 Say "Numero de Serie                       DATA   Garantia  Data Garantia  T N.Fiscal " 
 
   oTb:=tbrowsedb( 08, 01, 21, 78 ) 
   oTb:addcolumn( tbcolumnnew(,{|| LEFT( ROMANE, 35 ) + " " + DTOC( DATENT ) + Str( GAR->GARANT-( DATE()-DATENT ), 5 ) + " " + DTOC( DATSAI ) + Str( if( EMPTY( DATSAI ), 0, GAR->GARANT - ( DATE()-DATSAI ) ), 5 )+" " + INTEXT + " " + StrZero( CODNF_, 8, 0 ) })) 
 
	/* variaveis do objeto browse */ 
	otb:autolite:=.f. 
	otb:dehilite() 
 
	while .t. 
 
      /* ajuste sa barra de selecao */ 
		otb:colorrect( { otb:rowpos, 1, otb:rowpos, otb:colcount }, { 2, 1 } ) 
      while nextkey()=0 .and. !otb:stabilize() 
		enddo 
 
      IF lPorNota 
         MPR->( DBSetOrder( 1 ) ) 
         MPR->( DBSeek( ROM->CODPRO ) ) 
         @ 02,02 Say MPR->DESCRI 
      ENDIF 
 
      nTecla:= inkey(0) 
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
              IF Confirma( 0, 0, "Deseja excluir este registro (N§ de serie)?", "", "S" ) 
                 IF NetRLock() 
                    DBDelete() 
                 ENDIF 
              ENDIF 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
 
         case nTecla==K_ENTER 
 
              IF cProd <> Nil 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 SetCursor( 1 ) 
                 MPR->( DBSetOrder( 1 ) ) 
                 IF MPR->( DBSeek( cProd ) ) 
                    VPBox( 09, 01, 16, 75, "INFORMACOES", _COR_GET_BOX ) 
                    cRomane:=      ROMANE 
                    nNotaSaida:=   CODNF_ 
                    dDataEntrada:= DATENT 
                    dDataSaida:=   DATSAI 
                    nCupomSaida:= CODCUP 
                    SetColor( _COR_GET_EDICAO ) 
                    @ 11,02 Say "Produto...........: [" + MPR->DESCRI + "]" 
                    @ 12,02 Say "Codigo de garantia:" Get cRomane 
                    @ 13,02 Say "Entrada/Data......:" Get dDataEntrada 
                    @ 14,02 Say "Saida/Data........:" Get dDataSaida 
                    @ 15,02 Say "Saida-Nota Fiscal.:" Get nNotaSaida  Pict "@RZ 999999" 
                    @ 15,42 Say "Saida-Cupom Fiscal:" Get nCupomSaida Pict "@RZ 999999999" 
                    READ 
                    SetColor( _COR_BROWSE ) 
                    nReg:= RECNO() 
                    IF LastKey() <> K_ESC 
                       DBSelectAr( _COD_ROMANEIO ) 
                       DBGoTo( nReg ) 
                       IF NetRLock() 
                          Replace ROMANE With cRomane,; 
                                  CODNF_ With nNotasaida,; 
                                  DATSAI With dDataSaida,; 
                                  DATENT With dDataEntrada,; 
                                  CODCUP With nCupomSaida 
                       ENDIF 
                    ENDIF 
                    DBGoTo( nReg ) 
                 ENDIF 
                 ScreenRest( cTelaRes ) 
                 SetCursor( 0 ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
              ENDIF 
 
         case nTecla==K_INS 
              IF cProd <> Nil 
                 SetCursor( 1 ) 
                 cTelares:= ScreenSave( 0, 0, 24, 79 ) 
                 nMprOrdem:= MPR->( IndexOrd() ) 
                 nLocal:= MPR->( RECNO() ) 
                 SetCursor( 1 ) 
                 MPR->( DBSetOrder( 1 ) ) 
                 IF MPR->( DBSeek( cProd ) ) 
                    VPBox( 09, 01, 16, 75, "INFORMACOES P/ CODIGO", _COR_GET_BOX ) 
                    SetColor( _COR_GET_EDICAO ) 
                    @ 11,02 Say "Produto...........: [" + MPR->DESCRI + "]" 
                    @ 12,02 Say "Quantidade........:" Get nQuantidade Pict "@R 99999" When Mensagem("Digite a quantidade de codigos que deseja acrescentar." ) 
                    @ 13,02 Say "Nota Fiscal/Compra:" Get nNota       Pict "@R 99999999" When Mensagem("Digite o numero da Nota fiscal" ) 
                    @ 14,02 Say "Fornecedor........:" Get nCodFor     Pict "@R 999999" Valid BuscaFornecedor( @nCodFor ) When Mensagem( "Digite o codigo do fornecedor ou [99999] para ver lista." ) 
                    READ 
                    SetColor( _COR_BROWSE ) 
                    IF LastKey() <> K_ESC 
                       DBSelectAr( _COD_ROMANEIO ) 
                       DBGoTop() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                       Set Index To 

                       // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
                       #ifdef LINUX
                         set index to "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"    
                       #else 
                         Set Index to "&GDir\ROMIND01.NTX", "&GDir\ROMIND02.NTX", "&GDir\ROMIND03.NTX"    
                       #endif
                       Romaneio( Nil, Nil, nQuantidade, nCodFor, nNota ) 
                       DBSelectAr( _COD_ROMANEIO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                       Set Index To 
                       /* Verifica Busca = Produto ou Nota/Cupom */ 
                       IF nNotaFiscal == Nil .AND. cProd <> Nil 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                          INDEX ON ROMANE TO IN9203 FOR CODPRO=cProd 
                       ELSEIF nNotaFiscal <> Nil 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                          INDEX ON ROMANE TO IN9203 FOR CODNF_=nNotaFiscal 
                       ENDIF 

                       // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
                       #ifdef LINUX
                         set index to in9203, "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"    
                       #else 
                         Set Index To IN9203, "&GDir\ROMIND01.NTX", "&GDir\ROMIND02.NTX", "&GDir\ROMIND03.NTX"    
                       #endif
                    ENDIF 
                 ENDIF 
                 MPR->( DBSetOrder( nMprOrdem ) ) 
                 MPR->( DBGoTo( nLocal ) ) 
                 SetCursor( 0 ) 
                 ScreenRest( cTelaRes ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
                 SetCursor( 0 ) 
              ENDIF 
         case nTecla==K_ENTER 
 
         case DBPesquisa( nTecla, otb ) 
			otherwise					  ;tone(125); tone(300) 
	  endcase 
	  otb:refreshcurrent() 
	  otb:stabilize() 
	enddo 
	setcolor( ccor ) 
	setcursor( ncursor ) 
	screenrest( ctela ) 
   DBSelectAr( _COD_ROMANEIO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"    
   #else 
     Set Index to "&GDir\ROMIND01.NTX", "&GDir\ROMIND02.NTX", "&GDir\ROMIND03.NTX"    
   #endif
   IF nArea > 0 
		dbselectar( narea ) 
      IF nOrdem > 0 
         dbsetorder( nordem ) 
      ENDIF 
   ENDIF 
	Return Nil 
 
 
/* Busca fornecedores */ 
  Static Function Buscafornecedor( nCodigo ) 
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
 
 
 
 
 
