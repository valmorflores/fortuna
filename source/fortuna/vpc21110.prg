// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC21110.PRG 
³ Finalidade  ³ CADASTRO DE PRODUTOS 
³             ³ BROWSE *====> [ Inclusao / Alteracao / Exclusao ] 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 

#ifdef HARBOUR
function vpc21110()
#endif


   LOCAL nArea:= Select()
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nLinha, oTb, nTecla, GetList:= {} 
   LOCAL lDelimiters:= SET( _SET_DELIMITERS ) 
 
   SetCursor( 1 ) 
   SET( _SET_DELIMITERS, .T. ) 
   cVERIF_:= .F. 
   cMASCQUAN:=SWSet( _PRO_MASCQUAN ) 
   cMASCPREC:=SWSet( _PRO_MASCPREC ) 
   cxORIGEM:= IF( SWSet( _PRO_ORIGEM ), "S", "N" ) 
   cASSOCIAR:= IF( SWSet( _PRO_ASSOCIAR ), "S", "N" ) 
   cMASCACOD:=SWSet( _PRO_MASCACOD ) 
   _cMRESER:=strtran(cMASCACOD,".","") 
   _cMRESER:=strtran(_cMRESER,"-","") 
   _cMRESER:=alltrim(_cMRESER) 
   _PIGRUPO:=at("G",_cMRESER) 
   _QTGRUPO:=StrVezes("G",_cMRESER) 
   _PICODIG:=at("N",_cMRESER) 
   _QTCODIG:=StrVezes("N",_cMRESER) 
 
   Para cCompl 
 
   DBSelectAr( _COD_ORIGEM ) 
   DBSetOrder( 3 ) 
 
   DBSelectAr( _COD_MPRIMA ) 
   DBLeOrdem() 
   Set Relation To ORIGEM Into ORG 
 
   /* Ajuste da tela */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 00, 00, 18, 79,"CADASTRO DE PRODUTOS", _COR_GET_BOX, .F., .F. ) 
   VPBox( 19, 00, 22, 79,"", _COR_BROW_BOX, .F., .F., ,.F. ) 
   VPBox( 09, 43, 17, 77," P R E C O S ", _COR_GET_BOX, .F., .F., ,.F. ) 
 
   /* Ajuste de mensagens */ 
   IF EMPTY (cCompl) 
      Mensagem("[INS]Inclus„o [ENTER]Altera‡„o [DEL]Exclus„o [F8]Verif [ESC]Sair") 
   ELSE 
      Mensagem("[ENTER]Todos [ESC]Sair") 
   ENDIF 
   Ajuda("[Ctrl+F1]Info [F5]Detal [F6]Preco [F7]Moeda [F9]Observ [F12]Cores") 
 
   SetColor( _COR_BROWSE ) 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseDB( 20, 01, 21, 78 ) 
   oTb:addcolumn( tbcolumnnew( ,{|| IF( MPR->AVISO_ > 0, StrZero( MPR->AVISO_, 2, 0 ), Space( 2 ) ) + ' ' + SUBSTR( INDICE, 1, 3) + '' + SUBSTR( INDICE, 4, 4) +' '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 ) })) 
 
   /* Variaveis do objeto browse */ 
   oTb:AutoLite:=.f. 
   oTb:dehilite() 
 
   WHILE .T. 
 
      /* Ajuste sa barra de selecao */ 
      oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
      WHILE NextKey()=0 .AND. !oTb:Stabilize() 
      ENDDO 
 
      nLinha:= ROW() 
      PxF->( DBSetOrder( 1 ) ) 
      IF PxF->( DBSeek( MPr->Indice ) )
         nPrecoCompra:= 0
         WHILE !PXF->( EOF() ) .AND. PXF->CPROD_ == MPR->INDICE
             IF MPR->CODFOR == PXF->CODFOR
                nPrecoCompra:= PxF->Valor_
                EXIT
             ENDIF
             PXF->( DBSkip() )
         ENDDO
         nPrecoCompra:= PxF->Valor_ 
      ELSE 
         nPrecoCompra:= 0 
      ENDIF 
      nPrecoD:= Precov - ( PrecoV * PercDC / 100 ) 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
 
      /// CUSTO MEDIO -------------- //// 
      /// COMPRA ===> 1.420,00 ----- 1.300,00 /// 
      @ 01,40 Say PAD( IF( MPRIMA=="N", "<< PRODUTO COMPOSTO >>", "" ), 25 ) 
      @ 02,03 Say "C¢digo..............: [" + SUBSTR( INDICE, 1, 3 ) + "]-[" + SUBSTR( INDICE, 4, 4 ) + "]"
      IF TRIM( MPR->CLASSE ) <> " "
         @ 02,50 Say "Classe/Giro: [" + CLASSE + "]"
      ENDIF
      @ 03,03 Say "C¢digo de F brica...: [" + CODFAB                                                + "]" 
      @ 04,03 Say "Descri‡„o do produto: [" + DESCRI                                                + "]" 
      @ 05,03 Say "Origem/Fabricante...: [" + ORIGEM                                                + "]" 
      @ 06,03 Say "Unidade de Medida...: [" + UNIDAD                                                + "]" 
      @ 07,03 Say "Medida Unit ria.....: [" + TRAN( QTDPES, "@E 99,999.9999" )                     + "]" 
         @ 07,40 SAY "[" + Segura + "]" 
      @ 08,03 Say "Medida M¡nima.......: [" + TRAN( QTDMIN, "@E 99,999.9999" )                     + "]" 
      @ 09,03 Say "Estoque m¡nimo......: [" + TRAN( ESTMIN, "@E 99,999.999" )                       + "]" 
      @ 10,03 Say "Estoque m ximo......: [" + TRAN( ESTMAX, "@E 99,999.999" )                       + "]" 
      @ 11,03 Say "Peso L¡quido...(Kg).: [" + TRAN( PesoLi, "@E 99,999.999" )                  + "]" 
      @ 12,03 Say "Peso Bruto.....(Kg).: [" + TRAN( PesoBr, "@E 99,999.999" )                  + "]" 
 
      @ 13,03 Say "Situacao Tributaria.: [" + STR( SITT01, 1 )                                      + "]" 
         @ 13,28 Say "[" + STR( SITT02, 2 ) + "]  " 
 
      // SE POSSUI TABRED 
      IF !( ALLTRIM( TABRED ) == "" ) 
         @ ROW(),COL() Say "[" + TABRED + "]" Color "11/" + CorFundoAtual() 
      ELSE 
         @ ROW(),COL() Say "    " 
      ENDIF 
 
      // SE POSSUI MVA 
      IF ( MVAPER <> 0 .OR. MVAVLR <> 0 ) .AND.; 
         ( SITT02==70 .OR. SITT02==60 ) 
         IF MVAPER > 0 
            @ 16,45 Say "ICM=(%) MVA..: " + Str( MVAPER, 7, 3 ) + "%" + Space( 5 ) Color "12/" + CorFundoAtual() 
         ELSEIF MVAVLR > 0 
            @ 16,45 Say "ICM=Vlr Venda: " + Str( MVAVLR, 12, 3 ) Color "13/" + CorFundoAtual() 
         ELSE 
            @ 16,45 Say Space( 30 ) 
         ENDIF 
      ELSE 
         @ 16,45 Say Space( 30 ) 
      ENDIF 
 
      @ 14,03 Say "Classifica‡„o fiscal: [" + STR( CLAFIS, 3 )                                      + "]" 
      @ 15,03 Say "% IPI (Venda/Compra): [" + TRAN( IPI___, "999.99")  + "] [" + TRAN( IPICMP, "999.99")  + "]" 
      @ 16,03 Say "% p/ c lculo do ICMs: [" + TRAN( ICM___, "999.99" )                           + "]" 
      @ 17,03 Say "Fornecedor..........: [" + STR( CODFOR, 6 )                                      + "]" 
 
      @ 11,45 Say "De Compra....: [" + TRAN( nPrecoCompra, "@E 999,999,999.999")               + "]" Color "10/" + _COR_GET_FUNDO 
      @ 12,45 Say "% Marg.Lucro.:       [" + TRAN( PERCPV      , "@E 9,999.999")               + "]" 
      @ 13,45 Say "Venda Padrao.: [" + TRAN( PRECOV      , "@E 999,999,999.999")               + "]" Color "14/" + _COR_GET_FUNDO 
      @ 14,45 Say "% Desconto...:       [" + TRAN( PercDC      , "@e 9,999.999")               + "]" 
      @ 15,45 SAY "Pre‡o Final..: [" + Tran( nPrecoD     , "@e 999,999,999.999")               + "]" 
 
      /* Exibir o nome do produto com cores */ 
      IF MPR->AVISO_ > 0 
         @ nLinha,27 Say MPR->DESCRI Color "15/" + StrZero( MPR->AVISO_, 2, 0 ) 
      ENDIF 
 
 
      nTecla:=inkey(0) 
      IF nTecla=K_ESC 
         EXIT 
      ENDIF 
 
      Set Relation To 
      /* Teste da tecla pressionadas */ 
      DO CASE 
         CASE nTecla==K_UP         ;oTb:up() 
         CASE nTecla==K_LEFT       ;oTb:PanLeft() 
         CASE nTecla==K_RIGHT      ;oTb:PanRight() 
         CASE nTecla==K_DOWN       ;oTb:down() 
         CASE nTecla==K_PGUP       ;oTb:pageup() 
         CASE nTecla==K_PGDN       ;oTb:pagedown() 
 
         CASE nTecla==K_CTRL_LEFT 
              IF NetRLock() .AND. AVISO_ > 0 
                 Replace AVISO_ With AVISO_ - 1 
              ENDIF 
              DBUnlockAll() 
 
         CASE nTecla==K_CTRL_RIGHT 
              IF NetRLock() .AND. AVISO_ < 16 
                 Replace AVISO_ With AVISO_ + 1 
              ENDIF 
              DBUnlockAll() 
 
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         CASE nTecla==K_CTRL_F1    ;DisplayInfProd() 
         CASE nTecla==K_INS        ;IF( EMPTY( cCompl ), mprinclusao(), NIL ) 
         CASE nTecla==K_DEL        ;IF( EMPTY( cCompl ), Exclui( oTb ), NIL ) 
         CASE nTecla==K_F8         ;IF( EMPTY( cCompl ), mprverifica(), NIL ) 
         CASE nTecla==K_ENTER      ;IF( EMPTY( cCompl ), mpraltera(INDICE), ProCompl(nTecla)) 
         CASE nTecla==K_F2         ;IF( EMPTY( cCompl ), DBMudaOrdem( 1, oTb ) , NIL ) 
         CASE nTecla==K_F3         ;IF( EMPTY( cCompl ), DBMudaOrdem( 4, oTb ) , NIL ) 
         CASE nTecla==K_F4         ;IF( EMPTY( cCompl ), DBMudaOrdem( 2, oTb ) , NIL ) 
         CASE nTecla==K_F5         ;ProCompl(nTecla) 
         CASE nTecla==K_F6         ;ProCompl(nTecla) 
         CASE nTecla==K_F7         ;ProCompl(nTecla) 
         CASE nTecla==K_F9         ;ProCompl(nTecla) 
         CASE nTecla==K_F10        ;ProCompl(nTecla) 
         CASE nTecla==K_F11        ;ProCompl(nTecla)
         CASE nTecla==K_F12        ;ProCompl(nTecla) 
         CASE nTecla==K_CTRL_F2    ;ProCompl(nTecla) 
         CASE nTecla==K_CTRL_F12 
              ctelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              MPR->( DBGoTop() ) 
              Mensagem( "Verificando possiveis problemas no cadastro, aguarde..." ) 
              WHILE !MPR->( EOF() ) 
                 IF EMPTY( MPR->( CODFAB ) ) 
                    Aviso( "Codigo de F brica inexistente!" ) 
                    Pausa() 
                    exit 
                 ENDIF 
                 IF EMPTY( MPR->( DESCRI ) ) 
                    Aviso( "Descricao do produto inexistente!" ) 
                    Pausa() 
                    exit 
                 ENDIF 
                 IF EMPTY( MPR->( UNIDAD ) ) 
                    Aviso( "Unidade do produto inexistente!" ) 
                    Pausa() 
                    exit 
                 ENDIF 
                 IF EMPTY( MPR->( PRECOV ) ) 
                    Aviso( "Preco do produto invalido!" ) 
                    Pausa() 
                    exit 
                 ENDIF 
                 IF AT( "‡", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "Æ", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( ",", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "“", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "ä", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( '"', Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 
                    Aviso( "Informacoes com acento nao sao aceitas pela impressora fiscal." ) 
                    Pausa() 
                    Exit 
                 ENDIF 
                 MPR->( DBSkip() ) 
              ENDDO 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
 
         CASE EMPTY( cCompl ) 
            IF !DBPesquisa( nTecla, oTb ) 
               IF nTecla==K_TAB 
                  If( TYPE( "nModo" ) == "U", nModo := 1, Nil ) 
                  If nModo == 1 
                     If LastRec()>0 .AND. MPr->Codigo <> Space( 12 ) 
                        MPRAltera() 
                     EndIf 
                  ElseIf nModo == 2 
                     if(lastrec()>0 .AND. val(CODIGO)<>0,exclui(oTb),nil) 
                  EndIf 
              EndIf 
           EndIf 
         OTHERWISE                 ;Tone(125); Tone(300) 
     ENDCASE 
     ORG->( DBSetOrder( 3 ) ) 
     Set Relation To ORIGEM Into ORG 
 
     oTb:RefreshCurrent() 
     oTb:Stabilize() 
 
   ENDDO 
   IF nArea > 0 
      DBSelectAr( nArea ) 
   ENDIF 
   SET( _SET_DELIMITERS, lDelimiters ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Set Relation To 
   Return Nil 
 
