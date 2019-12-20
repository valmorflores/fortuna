// ## CL2HB.EXE - Converted
/* 
*      Funcao - VPC910000 
*  Finalidade - Movimentar Caixa 
*        Data - 
* Atualizacao - 
* Programador - VALMOR PEREIRA FLORES 
*/ 
function vpc92000()

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, cDescri, cTelaRes, nTotal:= 0 
Local dData 

Private nCodigo:= 1 
 
   IF !AbreGrupo( "CAIXA" ) 
      Return Nil 
   ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   WHILE .T. 
      DBSelectAr( _COD_CAIXAAUX ) 
      SetCursor( 1 ) 
      SetColor( _COR_GET_EDICAO ) 
      /* Seleciona o caixa operador para fazer a manutencao de dinheiro */ 
      VPBox( 00, 00, 22, 79, "Fluxo de Caixa (PDV/Operador)", _COR_GET_BOX ) 
      @ 02, 02 Say "Caixa Operador:" Get nCodigo Pict "999" When Mensagem( "Digite o codigo do operador." ) 
      READ 
      IF LastKey() == K_ESC 
         Exit 
      ENDIF 
 
 
      DBSelectAr( _COD_DUPAUX ) 
      DBGoTop() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON CODNF_ TO IND9292 FOR ( DATAEM == dData .AND. DTQT__ == CTOD( "" ) ) .OR.; 
                                     ( DATAEM <> dData .AND. DTQT__ == dData ) 
 
 
      VPBox( 00, 00, 17, 79," LANCAMENTOS ", _COR_GET_BOX, .F., .F., ,.F. ) 
 
      SetColor( _COR_BROWSE ) 
 
      /* Inicializacao do objeto browse */ 
      oTb:=TBrowseDB( 20, 01, 21, 78 ) 
      oTb:addcolumn( tbcolumnnew( ,{|| StrZero( DPA->CODNF_, 9, 0 ) + Space( 1 ) + CDESCR  + Tran( VLR___, "@e 9,999,999.99" ) })) 
 
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
         nPrecoCompra:= PxF->Valor_ 
      ELSE 
         nPrecoCompra:= 0 
      ENDIF 
      nPrecoD:= Precov - ( PrecoV * PercDC / 100 ) 
 
      /* Display das informacoes */ 
      SetColor( _COR_GET_EDICAO ) 
 
      /// CUSTO MEDIO -------------- //// 
      /// COMPRA ===> 1.420,00 ----- 1.300,00 /// 
      @ 02,40 Say PAD( IF( MPRIMA=="N", "<< PRODUTO COMPOSTO >>", "" ), 25 ) 
      @ 02,03 Say "C�digo..............: [" + SUBSTR( INDICE, 1, 3 ) + "]-[" + SUBSTR( INDICE, 4, 4 ) + "]" 
      @ 03,03 Say "C�digo de F�brica...: [" + CODFAB                                                + "]" 
      @ 04,03 Say "Descri��o do produto: [" + DESCRI                                                + "]" 
      @ 05,03 Say "Origem/Fabricante...: [" + ORIGEM                                                + "]" 
      @ 06,03 Say "Unidade de Medida...: [" + UNIDAD                                                + "]" 
      @ 07,03 Say "Medida Unit�ria.....: [" + TRAN( QTDPES, "@E 99,999.9999" )                     + "]" 
         @ 07,40 SAY "[" + Segura + "]" 
      @ 08,03 Say "Medida M�nima.......: [" + TRAN( QTDMIN, "@E 99,999.9999" )                     + "]" 
      @ 09,03 Say "Estoque m�nimo......: [" + TRAN( ESTMIN, "@E 99,999.999" )                       + "]" 
      @ 10,03 Say "Estoque m�ximo......: [" + TRAN( ESTMAX, "@E 99,999.999" )                       + "]" 
      @ 11,03 Say "Peso L�quido...(Kg).: [" + TRAN( PesoLi, "@E 99,999.999" )                  + "]" 
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
            @ 16,41 Say "ICM=(%) de MVA..: " + Str( MVAPER, 7, 3 ) + "%" + Space( 5 ) Color "12/" + CorFundoAtual() 
         ELSEIF MVAVLR > 0 
            @ 16,41 Say "ICM=Vlr.de Venda: " + Str( MVAVLR, 12, 3 ) Color "13/" + CorFundoAtual() 
         ELSE 
            @ 16,41 Say Space( 35 ) 
         ENDIF 
      ELSE 
         @ 16,40 Say Space( 35 ) 
      ENDIF 
 
      @ 14,03 Say "Classifica��o fiscal: [" + STR( CLAFIS, 3 )                                      + "]" 
      @ 15,03 Say "% p/ c�lculo do IPI.: [" + TRAN( IPI___, "999.99")                            + "]" 
      @ 16,03 Say "% p/ c�lculo do ICMs: [" + TRAN( ICM___, "999.99" )                           + "]" 
      @ 17,03 Say "Fornecedor..........: [" + STR( CODFOR, 3 )                                      + "]" 
 
      @ 11,41 Say "De Compra.......: [" + TRAN( nPrecoCompra, "@E 999,999,999.999")               + "]" Color "10/" + _COR_GET_FUNDO 
      @ 12,41 Say "% Margem Lucro..:       [" + TRAN( PERCPV      , "@E 9,999.999")               + "]" 
      @ 13,41 Say "Venda Padrao....: [" + TRAN( PRECOV      , "@E 999,999,999.999")               + "]" Color "14/" + _COR_GET_FUNDO 
      @ 14,41 Say "% Desconto......:       [" + TRAN( PercDC      , "@e 9,999.999")               + "]" 
      @ 15,41 SAY "Pre�o Final.....: [" + Tran( nPrecoD     , "@e 999,999,999.999")               + "]" 
 
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
              IF netrlock() .AND. AVISO_ > 0 
                 Replace AVISO_ With AVISO_ - 1 
              ENDIF 
              DBUnlockAll() 
 
         CASE nTecla==K_CTRL_RIGHT 
              IF netrlock() .AND. AVISO_ < 16 
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
//         CASE nTecla==K_F11        ;ProCompl(nTecla) 
         CASE nTecla==K_F12        ;ProCompl(nTecla) 
         CASE nTecla==K_CTRL_F2    ;ProCompl(nTecla) 
         CASE nTecla==K_CTRL_F12 
              ctelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              MPR->( DBGoTop() ) 
              Mensagem( "Verificando possiveis problemas no cadastro, aguarde..." ) 
              WHILE !MPR->( EOF() ) 
                 IF EMPTY( MPR->( CODFAB ) ) 
                    Aviso( "Codigo de F�brica inexistente!" ) 
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
                 IF AT( "�", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "�", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( ",", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "�", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "�", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
                    AT( "�", Lower( MPR->DESCRI+MPR->CODFAB+MPR->UNIDAD ) ) > 0 .OR.; 
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
 
