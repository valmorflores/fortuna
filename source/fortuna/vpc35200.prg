// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
/// #include "ptfuncs.ch" 
/// #include "ptverbs.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � TABELA DIFERENCIADA DE PRECOS 
� Finalidade  � Lancamento de Tabela Diferenciada de Precos 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/ 
#ifdef HARBOUR
function vpc35200()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   DBSelectAr( _COD_TABPRECO ) 
   Set( _SET_DELIMITERS, .T. ) 
   DispBegin() 
   VPBox( 00, 00, 13, 79, "TABELAS DIFERENCIADAS DE PRECOS", _COR_GET_BOX,.F.,.F.  ) 
   VPBox( 13, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   ExibeStr() 
   DBLeOrdem() 
   Mensagem( "[+]Produtos [INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 14, 01, 21, 78 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                                            %Acr   %Des ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                               PAD( DESCRI, 50 ) +" "+; 
                                         Tran( PERACR, "@EZ 999.99" ) + " " +; 
                                         Tran( PERDES, "@EZ 999.99" ) + " " + SELECT + Space( 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      MostraDados() 
      nTecla:=inkey(0) 
      if nTecla=K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:PanLeft() 
         case nTecla==K_RIGHT      ;oTab:PanRight() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case Chr( nTecla ) == "+" 
              IF CODIGO == 0 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Tabela Padrao nao poder� sofrer alteracoes." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 IF !( PERACR + PERDES ) == 0 
                    cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                    Aviso( "Esta tabela trabalha com percentual s/ tabela padrao." ) 
                    Pausa() 
                    ScreenRest( cTelaRes ) 
                 ELSE 
                    MontaTabela( oTab ) 
                 ENDIF 
              ENDIF 
         case nTecla==K_INS        ;IncluiPreco( oTab ) 
         case nTecla==K_ENTER 
              IF CODIGO == 0 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Aviso( "Tabela Padrao nao poder� sofrer alteracoes." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
              ELSE 
                 AlteraPreco( oTab ) 
              ENDIF 
         Case nTecla==K_DEL 
              IF !CODIGO == 0 
                 Exclui( oTab ) 
              ENDIF 
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         Case nTecla==K_SPACE 
              nRegistro:= Recno() 
              DBGoTop() 
              WHILE !EOF() 
                  IF netrlock() 
                     IF Recno() == nRegistro 
                        Replace SELECT With "*" 
                     ELSE 
                        Replace SELECT With " " 
                     ENDIF 
                  ENDIF 
                  dbUnLock() 
                  DBSkip() 
              ENDDO 
              DBGoTo( nRegistro ) 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
         Case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Static Function ExibeStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.....: [    ]" 
  @ 03,02 Say "Descricao..: [                                        ]" 
  @ 04,02 Say "% Acrescimo: [      ]" 
  @ 05,02 Say "% Desconto.: [      ]" 
  @ 06,02 Say "Condicoes..: [00] [00] [00] [00] [00]" 
  SetColor( cCor ) 
  Return nil 
 
Static Function MostraDados(cTELA) 
  cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,16 Say strzero(CODIGO,4,0) 
  @ 03,16 Say DESCRI 
  @ 04,16 Say Tran( PERACR, "@e 999.99" ) 
  @ 05,16 Say Tran( PERDES, "@E 999.99" ) 
  @ 06,16 Say StrZero( CND001, 2, 0 ) 
  @ 06,21 Say StrZero( CND002, 2, 0 ) 
  @ 06,26 Say StrZero( CND003, 2, 0 ) 
  @ 06,31 Say StrZero( CND004, 2, 0 ) 
  @ 06,36 Say StrZero( CND005, 2, 0 ) 
  SetColor( cCor ) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � MONTATABELA 
� Finalidade  � Monta tabela 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function MontaTabela( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local oTab1, oTab2, nTecla, nTela:= 1 
  nCodigo:= PRE->CODIGO 
  DBSelectAr( _COD_TABAUX ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Index On CODPRO To INDRES02.TMP For CODIGO = nCodigo Eval {|| Processo() } 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to indres02.tmp, "&gdir/taxind01.ntx", "&gdir/taxind02.ntx" 
  #else 
    Set Index To INDRES02.TMP, "&GDir\TAXIND01.NTX", "&GDir\TAXIND02.NTX" 
  #endif
  VPBox( 00, 00, 11, 79, "PRODUTOS SELECIONADOS", _COR_BROW_BOX, .F., .F.  ) 
  VPBox( 12, 00, 22, 79, "LISTA GERAL DE PRODUTOS", _COR_BROW_BOX, .F., .F. ) 
  mensagem( "[TAB]Troca Janela, [ENTER]Seleciona, [CTRL][INS]Insere todos, [ESC]Sair" ) 
 
  SetColor( _COR_BROWSE ) 
  DBLeOrdem() 
  DBGoTop() 
  oTab1:=tbrowsedb( 01, 01, 10, 78 ) 
  oTab1:addcolumn(tbcolumnnew("Codigo   Cod.Fabrica   Produto                                     Preco Venda",; 
                                      {|| Tran( TAX->CODPRO, "@R 999-9999" ) + " " + Left( TAX->CODFAB, 13 ) + " " +; 
                                              PAD( TAX->DESCRI, 35 ) +" "+; 
                                        Tran( TAX->PRECOV, "@E 99,999,999,999.9999" ) + Space( 20 ) })) 
  oTab1:AUTOLITE:=.f. 
  oTab1:dehilite() 
  DBSelectAr( _COD_MPRIMA ) 
  DBLeOrdem() 
  oTab2:=tbrowsedb( 13, 01, 21, 78 ) 
  oTab2:addcolumn(tbcolumnnew("Codigo   Cod.Fabrica   Produto                                            Preco",; 
                                      {|| Tran( MPR->INDICE, "@R 999-9999" ) + " "+; 
                                 MPR->CODFAB + " " + PAD( MPR->DESCRI, 45 ) +" "+; 
                           Tran( MPR->PRECOV, "@E 99999.9999" ) + MPR->MARCA_ + Space( 20 ) })) 
  oTab2:AUTOLITE:=.f. 
  oTab2:dehilite() 
  DBSelectAr( _COD_TABAUX ) 
  WHILE .T. 
     IF nTela == 1 
        oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
        whil nextkey()=0 .and.! oTab1:stabilize() 
        enddo 
     ELSE 
        oTab2:colorrect({oTab2:ROWPOS,1,oTab2:ROWPOS,oTab2:COLCOUNT},{2,1}) 
        whil nextkey()=0 .and.! oTab2:stabilize() 
        enddo 
     ENDIF 
     nTecla:=inkey(0) 
     IF nTecla=K_ESC 
        EXIT 
     ELSEIF nTecla == K_TAB 
        IF nTela == 1 
           oTab1:RefreshAll() 
           WHILE !oTab1:Stabilize() 
           ENDDO 
           DBSelectAr( _COD_MPRIMA ) 
           oTab2:colorrect({oTab2:ROWPOS,1,oTab2:ROWPOS,oTab2:COLCOUNT},{2,1}) 
           whil nextkey()=0 .and.! oTab2:stabilize() 
           enddo 
           ++nTela 
        ELSE 
           nTela:= 1 
           oTab2:RefreshAll() 
           WHILE !oTab2:Stabilize() 
           ENDDO 
           DBSelectAr( _COD_TABAUX ) 
           oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
           whil nextkey()=0 .and.! oTab1:stabilize() 
           enddo 
        ENDIF 
     ENDIF 
     IF nTela == 1 
        do case 
           case nTecla==K_UP         ;oTab1:up() 
           case nTecla==K_LEFT       ;oTab1:PanLeft() 
           case nTecla==K_RIGHT      ;oTab1:PanRight() 
           case nTecla==K_DOWN       ;oTab1:down() 
           case nTecla==K_PGUP       ;oTab1:pageup() 
           case nTecla==K_PGDN       ;oTab1:pagedown() 
           case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
           case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
           case nTecla==K_DEL 
                Exclui( oTab1 ) 
           case nTecla==K_ENTER 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                PXF->( DBSetOrder( 1 ) ) 
                PXF->( DBSeek( TAX->CODPRO ) ) 
                nPrecoC:= PXF->VALOR_ 
                nMargem:= MPR->PERCPV 
                DBSelectAr( _COD_TABAUX ) 
                nPerAcr:= PERACR 
                nPerDes:= PERDES 
                nPrecov:= PRECOV 
                nMargem:= MARGEM 
                VPBox( 07, 10, 15, 78, "Selecao de Produto", _COR_GET_BOX ) 
                SetColor( _COR_GET_EDICAO ) 
                @ 08,11 Say "Produto.....: [" + DESCRI + "]" 
                @ 09,11 Say "Cod.Fabrica.: [" + CODFAB + "]" 
                @ 10,11 Say "Preco Custo.: [" + Tran( nPrecoC, "@E 999,999,999.999" ) + "]" 
                @ 11,11 Say "Margem......:" Get nMargem Pict "@E 999.999" Valid Margem( nPrecoC, nMargem, @nPrecoV ) 
                @ 12,11 Say "Preco.......:" Get nPrecov Pict "@E 9,999,999.9999" 
                READ 
                IF netrlock() 
                   Replace CODIGO With nCodigo,; 
                           PERACR With nPerAcr,; 
                           PERDES With nPerDes,; 
                           PRECOV With nPrecoV,; 
                           MARGEM With nMargem 
                ENDIF 
                ScreenRest( cTelaRes ) 
                SetColor( _COR_BROWSE ) 
                DBSelectAr( _COD_TABAUX ) 
                oTab1:RefreshAll() 
                WHILE !oTab1:Stabilize() 
                ENDDO 
        endcase 
        oTab1:refreshcurrent() 
        oTab1:stabilize() 
     ELSE 
        do case 
           case nTecla==K_UP         ;oTab2:up() 
           case nTecla==K_LEFT       ;oTab2:PanLeft() 
           case nTecla==K_RIGHT      ;oTab2:PanRight() 
           case nTecla==K_DOWN       ;oTab2:down() 
           case nTecla==K_PGUP       ;oTab2:pageup() 
           case nTecla==K_PGDN       ;oTab2:pagedown() 
           case nTecla==K_CTRL_PGUP  ;oTab2:gotop() 
           case nTecla==K_CTRL_PGDN  ;oTab2:gobottom() 
           case DBPesquisa( nTecla, oTab2 ) 
           case nTecla==K_F2 
                DBMudaOrdem( 1, oTab2 ) 
           case nTecla==K_F3 
                DBMudaOrdem( 2, oTab2 ) 
           case nTecla==K_F4 
                DBMudaOrdem( 3, oTab2 ) 
           case nTecla==K_F5 
                DBMudaOrdem( 4, oTab2 ) 
           case nTecla==K_CTRL_INS 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                VPBox( 03, 10, 19, 78, "Selecao de Produto", _COR_GET_BOX ) 
                SetColor( _COR_GET_EDICAO ) 
                cMudarSelecionados:= "N" 
                nMargem:= 0 
                nPrecoC:= PXF->VALOR_ 
                nMargem:= MPR->PERCPV 
                DBSelectAr( _COD_TABAUX ) 
                nPerAcr:= PERACR 
                nPerDes:= PERDES 
                nPrecov:= PRECOV 
                nMargem:= MARGEM 
                @ 04,11 Say "Esta funcao aplica uma margem aos itens, selecionando todos  os que" 
                @ 05,11 Say "estejam disponiveis na listagem geral de produtos." 
                @ 06,11 Say "Antes de continuar, esteja certo de que realmente � isto que deseja" 
                @ 07,11 Say "pois esta atividade e irreversivel." 
                @ 08,11 Say "�������������������������������������������������������������������" 
                @ 09,11 Say "Margem que deseja aplicar ao preco de compra:"  Get nMargem Pict "@E 999.999" 
                @ 10,11 Say "Modificar informacoes % de �tens j� selecionados?" Get cMudarSelecionados 
                @ 14,11 Say "�������������������������������������������������������������������" Color "15/" + CorFundoAtual() 
 
                READ 
                IF IIF( LastKey()==K_ESC, .F., Confirma( 0, 0, "Confirma a gravacao de todos os produtos nesta tabela?", "S" ) ) 
                   DBSelectAr( _COD_TABAUX ) 
                   MPR->( DBGoTop() ) 
                   WHILE !MPR->( EOF() ) 
                      PXF->( DBSetOrder( 1 ) ) 
                      IF PXF->( DBSeek( MPR->INDICE ) ) 
                         nPrecoC:= PXF->VALOR_ 
                         nPerAcr:= 0 
                         nPerDes:= 0 
                         nPrecov:= ROUND( ( nPrecoC + ( nPrecoC * ( nMargem / 100 ) ) ), 2 ) 
                         IF TAX->( DBSeek( MPR->INDICE ) ) 
                            IF cMudarSelecionados=="S" 
                               @ 12,11 Say "Ja Selecionado, modificando percentual..." 
                            ELSE 
                               @ 12,11 Say "Ja Selecionado, sem modificacoes...      " 
                            ENDIF 
                            lNovo:= .F. 
                         ELSE 
                            @ 12,11 Say "Add: " + MPR->DESCRI 
                            DBAppend() 
                            lNovo:= .T. 
                         ENDIF 
                         IF lNovo .OR. cMudarSelecionados=="S" 
                            @ 15,11 Say "Preco de Compra:" + Tran( nPrecoC, "@E 999,999,999.99" ) 
                            @ 16,11 Say "Margen (%).....:" + Tran( nMargem, "@E 999,999,999.99" ) 
                            @ 17,11 Say "Preco de Venda.:" + Tran( nPrecoV, "@E 999,999,999.99" ) 
                            IF netrlock() 
                               Repl CODIGO With nCodigo,; 
                                    CODPRO With MPR->INDICE,; 
                                    CODFAB With MPR->CODFAB,; 
                                    DESCRI With MPR->DESCRI,; 
                                    PERACR With nPerAcr,; 
                                    PERDES With nPerDes,; 
                                    PRECOV With nPrecoV,; 
                                    MARGEM With nMargem 
                            ENDIF 
                         ENDIF 
                      ENDIF 
                      Inkey() 
                      IF LastKey()==K_ESC .OR. LastKey()==K_ESC 
                         IF SWAlerta( "Deseja abandonar esta operacao?", { "Sim", "Nao" } )==1 
                            EXIT 
                         ENDIF 
                      ENDIF 
                      MPR->( DBSkip() ) 
                   ENDDO 
                ENDIF 
                ScreenRest( cTelaRes ) 
                SetColor( _COR_BROWSE ) 
                DBSelectAr( _COD_TABAUX ) 
                oTab1:RefreshAll() 
                WHILE !oTab1:Stabilize() 
                ENDDO 
                DBSelectAr( _COD_MPRIMA ) 
                oTab2:RefreshAll() 
                WHILE !oTab2:Stabilize() 
                ENDDO 
 
           case nTecla==K_ENTER 
                cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                DBSelectAr( _COD_TABAUX ) 
                IF TAX->( DBSeek( MPR->INDICE ) ) 
                   Aviso( "Produto j� esta selecionado!" ) 
                   Pausa() 
                ELSE 
                   PXF->( DBSetOrder( 1 ) ) 
                   PXF->( DBSeek( MPR->INDICE ) ) 
                   nPrecoC:= PXF->VALOR_ 
                   nMargem:= MPR->PERCPV 
                   nPerAcr:= 0 
                   nPerDes:= 0 
                   nPrecov:= MPR->PRECOV 
                   VPBox( 07, 10, 13, 78, "Selecao de Produto", _COR_GET_BOX ) 
                   SetColor( _COR_GET_EDICAO ) 
                   @ 08,11 Say "Produto.....: [" + MPR->DESCRI + "]" 
                   @ 09,11 Say "Cod.Fabrica.: [" + MPR->CODFAB + "]" 
                   @ 10,11 Say "Preco Custo.: [" + Tran( nPrecoC, "@E 999,999,999.999" ) + "]" 
                   @ 11,11 Say "Margem......:" Get nMargem Pict "@E 999.999" Valid Margem( nPrecoC, nMargem, @nPrecoV ) 
                   @ 12,11 Say "Preco.......:" Get nPrecov Pict "@E 9,999,999.9999" 
                   READ 
                   DBAppend() 
                   IF netrlock() 
                      Replace CODIGO With nCodigo,; 
                              CODPRO With MPR->INDICE,; 
                              CODFAB With MPR->CODFAB,; 
                              DESCRI With MPR->DESCRI,; 
                              PERACR With nPerAcr,; 
                              PERDES With nPerDes,; 
                              PRECOV With nPrecoV,; 
                              MARGEM With nMargem 
                   ENDIF 
                ENDIF 
                ScreenRest( cTelaRes ) 
                SetColor( _COR_BROWSE ) 
                DBSelectAr( _COD_TABAUX ) 
                oTab1:RefreshAll() 
                WHILE !oTab1:Stabilize() 
                ENDDO 
                DBSelectAr( _COD_MPRIMA ) 
        endcase 
        oTab2:refreshcurrent() 
        oTab2:stabilize() 
     ENDIF 
  ENDDO 
  DBSelectAR( _COD_TABAUX ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/taxind01.ntx", "&gdir/taxind02.ntx" 
  #else 
    Set Index To "&GDir\TAXIND01.NTX", "&GDir\TAXIND02.NTX" 
  #endif
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � Selecao da Tabela de Preco 
� Finalidade  � 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TabelaPreco() 
  Local nArea:= Select() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_TABPRECO ) 
   DispBegin() 
   VPBox( 05, 10, 18, 72, "TABELAS DIFERENCIADAS DE PRECOS", _COR_BROW_BOX, .T., .T.  ) 
   SetColor( _COR_BROWSE ) 
   DBLeOrdem() 
   DBGoTop() 
   WHILE !CODIGO == SWSet( _INT_TABPRECO ) 
      DBSkip() 
      IF EOF() 
         EXIT 
      ENDIF 
   ENDDO 
   Mensagem( "[ENTER]Seleciona" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 06, 11, 15, 71 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                                  %Acr   %Des ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                               PAD( DESCRI, 40 ) +" "+; 
                                         Tran( PERACR, "@E 999.99" ) + " " +; 
                                         Tran( PERDES, "@E 999.99" ) + " " + SELECT + Space( 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      SetColor( "15/02" ) 
      //IF !PERACR == 0 
      //   nPreco:= MPR->PRECOV + ( ( MPR->PRECOV * PERACR ) / 100 ) 
      //ELSE 
      //   nPreco:= MPR->PRECOV - ( ( MPR->PRECOV * PERDES ) / 100 ) 
      //ENDIF 
      Scroll( 16, 11, 17, 71 ) 
      @ 16,11 Say "Produto.........: " + LEFT( MPR->DESCRI, 40 ) 
      @ 17,11 Say "Preco Convertido: " + TRAN( PrecoConvertido(), "@E 999,999,999.99" ) + "      Diferenca: " + TRAN( PrecoConvertido() - MPR->PRECOV, "@E 9,999.9999" ) 
      SetColor( _COR_BROWSE ) 
      nTecla:=inkey(0) 
      if nTecla=K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:PanLeft() 
         case nTecla==K_RIGHT      ;oTab:PanRight() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_F8 .OR. nTecla==K_ENTER 
              SWSet( _INT_TABPRECO,  CODIGO ) 
              SWSet( _INT_ACRESCIMO, PERACR ) 
              SWSet( _INT_DESCONTO,  PERDES ) 
              EXIT 
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         Case nTecla==K_SPACE 
              nRegistro:= Recno() 
              DBGoTop() 
              WHILE !EOF() 
                  IF netrlock() 
                     IF Recno() == nRegistro 
                        Replace SELECT With "*" 
                     ELSE 
                        Replace SELECT With " " 
                     ENDIF 
                  ENDIF 
                  dbUnLock() 
                  DBSkip() 
              ENDDO 
              DBGoTo( nRegistro ) 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
         Case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiPreco 
� Finalidade  � Inclusao de registros em Contas a Pagar 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Func IncluiPreco( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40), nPerAcr:= 0, nPerDes:= 0,; 
        nCnd001:= 0, nCnd002:= 0, nCnd003:= 0, nCnd004:= 0, nCnd005:= 0 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 12, 79, "TABELA DE PRECOS (INCLUSAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr(_COD_TABPRECO) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCodigo:= Codigo + 1 
  IF nCodigo == 1 
     IF !DBSeek( 0 ) 
        DBAppend() 
        IF netrlock() 
           Replace CODIGO With 0,; 
                   DESCRI With "TABELA PADRAO" 
        ENDIF 
     ENDIF 
  ENDIF 
  dbgotop() 
  WHILE .T. 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,02 Say "Codigo.....: ["+strzero(nCODIGO,6,0)+"]" 
     @ 03,02 Say "Descricao..:" Get cDescri when Mensagem("Descricao da tabela de precos.") 
     @ 04,02 Say "% Acrescimo:" Get nPerAcr pict "@E 999.99" When Mensagem("Percentual de Acrescimo.") 
     @ 05,02 Say "% Desconto.:" Get nPerDes pict "@E 999.99" When Mensagem("Percentual de Desconto.") 
     @ 06,02 Say "Operacoes..:" 
     @ 06,15 Get nCnd001 Pict "99" 
     @ 06,20 Get nCnd002 Pict "99" 
     @ 06,25 Get nCnd003 Pict "99" 
     @ 06,30 Get nCnd004 Pict "99" 
     @ 06,35 Get nCnd005 Pict "99" 
     READ 
     IF !LastKey() == K_ESC 
        If confirma(12,63,"Confirma?",; 
           "Digite [S] para confirmar o cadastramento.","S",; 
           COR[16]+","+COR[18]+",,,"+COR[17]) 
           IF DBSeek( nCodigo ) 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Codigo de lancamento ser� substituido" ) 
              Pausa() 
              ScreenRest( cTelaRes ) 
              DBGoBottom() 
              nCodigo:= nCodigo + 1 
           ENDIF 
           If buscanet(5,{|| dbappend(), !neterr()}) .AND.; 
             nCODIGO <> 0 
               repl CODIGO with nCODIGO, DESCRI With cDescri,; 
                    PERACR with nPerAcr, PERDES With nPerDes,; 
                    CND001 With nCnd001, CND002 With nCnd002,; 
                    CND003 With nCnd003, CND004 With nCnd004,; 
                    CND005 With nCnd005 
           EndIf 
           /* Limpa as variaveis */ 
           cDESCRI:= Space( 40 ) 
           nPerAcr:= 0 
           nPerDes:= 0 
           oTab:PageUp() 
           oTab:Down() 
           oTab:RefreshAll() 
           WHILE !oTab:Stabilize() 
           ENDDO 
           ++nCodigo 
           dbUnlockAll() 
        EndIf 
     ELSE 
        Exit 
     ENDIF 
  Enddo 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  SetColor(cCOR) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � ALTERAPRECO 
� Finalidade  � Alteracao de Precos 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraPreco( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40), nPerAcr:= 0, nPerDes:= 0 
  Local nCnd001, nCnd002, nCnd003, nCnd004, nCnd005 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 12, 79, "TABELA DE PRECOS (ALTERACAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  nCodigo:= Codigo 
  cDescri:= DESCRI 
  nPerAcr:= PERACR 
  nPerDes:= PERDES 
  nCnd001:= CND001 
  nCnd002:= CND002 
  nCnd003:= CND003 
  nCnd004:= CND004 
  nCnd005:= CND005 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.....: ["+strzero(nCODIGO,6,0)+"]" 
  @ 03,02 Say "Descricao..:" Get cDescri when Mensagem("Digite a descricao da tabela de precos.") 
  @ 04,02 Say "% Acrescimo:" Get nPerAcr pict "@E 999.99" When Mensagem("Digite o percentual de acrescimo.") 
  @ 05,02 Say "% Desconto.:" Get nPerDes pict "@E 999.99" When Mensagem("Digite o percentual de desconto.") 
  @ 06,02 Say "Operacoes..:" 
  @ 06,15 Get nCnd001 Pict "99" 
  @ 06,20 Get nCnd002 Pict "99" 
  @ 06,25 Get nCnd003 Pict "99" 
  @ 06,30 Get nCnd004 Pict "99" 
  @ 06,35 Get nCnd005 Pict "99" 
  READ 
  IF !LastKey() == K_ESC 
     If confirma(12,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        If netrlock() 
           repl DESCRI With cDescri,; 
                PERACR with nPerAcr, PERDES With nPerDes,; 
                CND001 With nCnd001, CND002 With nCnd002,; 
                CND003 With nCnd003, CND004 With nCnd004,; 
                CND005 With nCnd005 
        EndIf 
        dbUnlockAll() 
     EndIf 
  ENDIF 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  SetColor(cCOR) 
 
 
/***** 
�������������Ŀ 
� Funcao      � MARGEM 
� Finalidade  � Calcula preco final com base numa margem de lucro 
� Parametros  � Nil 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function Margem( nPrecoPadrao, nMargem, nPrecoFinal ) 
IF nMargem > 0 
   nPrecoFinal:= ROUND( nPrecoPadrao + ( ( nPrecoPadrao * nMargem ) / 100 ), SWSet( 1998 ) ) 
ENDIF 
Return .T. 
 
