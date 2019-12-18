// ## CL2HB.EXE - Converted
 
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC88014 
³ Finalidade  ³ Pesquisa Reservas & Pedidos respectivos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Maio/2001 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function vpc88014()
#endif

    Local GetList:= {}
    Local nVenIni:= 0, nVenFim:= 999, nTraIni:= 0, nTraFim:= 999 
    Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
          nCursor:= SetCursor() 
 
    Local oTab, nTecla, lFocaliza:= .F. 
    Local cFormato:= "  " 
    Local dDataIni:= CTOD( "  /  /  " ), dDataFim:= DATE() 
    Local dDataEmIni:= CTOD( "  /  /  " ), dDataEmFim:= DATE() 
    Local cRelEst:= "R", cProduto:= Space( 7 ) 
 
    WHILE .T. 
       VPBox( 04, 08, 22, 76, "RELACAO DE PEDIDOS - RESERVA ", _COR_GET_BOX  ) 
 
       /* ESTATISTICA */ 
       SetColor( _COR_GET_EDICAO ) 
       cRelEst:= "R" 
       //** @ 06,10 Say "[R]Relacao " Get cRelEst Pict "!" Valid cRelEst $ "E-R" 
 
       @ 06,10 Say "Produto    " Get cProduto Pict "@R 999-9999" Valid BuscaProduto( @cProduto ) 
 
       @ 11,10 Say "Periodo Entre" 
       @ 12,10 Get dDataIni 
       @ 12,25 Get dDataFim 
 
       @ 17,10 Say "Formato/Tipo:     (  /01/02/03/04/05/06/07 ou 99-Todos)" 
       @ 17,24 Get cFormato Pict "99" 
 
       READ 
 
       IF LastKey()==K_ESC 
          EXIT 
       ENDIF 
 
 
       DBSelectAr( _COD_PEDIDO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       INDEX ON  CODIGO TO INPED21 ; 
                  FOR     DATA__ >= dDataini .AND. DATA__ <= dDataFim      .AND.; 
                      ( IF( cFormato <> "99", cFormato == TIPO__, .T. ) )  ; 
                        EVAL {|| Processo() } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       SET INDEX TO INPED21 
 
       DBSelectAr( _COD_PEDPROD ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       INDEX ON CODIGO TO IND0203 FOR CODPRO==Val( cProduto ) DESCENDING 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       SET INDEX TO IND0203 
       SET RELATION TO CODIGO INTO PED 
 
       DBSelectAr( 123 ) 
       DBCloseArea() 
       DBCreate( "RESERVA.TMP", { { "PEDIDO", "C", 08, 00 },; 
                                  { "INFO__", "C", 37, 00 },; 
                                  { "DATAEM", "D", 08, 00 },; 
                                  { "QUANT_", "N", 16, 04 },; 
                                  { "VALOR_", "N", 16, 02 },; 
                                  { "RECNO_", "N", 10, 00 },; 
                                  { "CLIENT", "N", 06, 00 } } ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       USE RESERVA.TMP Alias TMP 
 
       // Zera a Quantidade 
       nQuantidade:= 0 
 
       DBSelectAr( _COD_PEDPROD ) 
       DBGoTop() 
       WHILE .T. 
           // Gravacao de Informacoes 
           NF_->( DBSetOrder( 4 ) ) 
           IF !( PED->( EOF() ) ) 
              IF !( NF_->( DBSeek( PED->CODPED ) ) ) 
                 TMP->( DBAppend() ) 
                 IF TMP->( RLOCK() ) 
                    Repl TMP->PEDIDO  With PED->CODPED,; 
                         TMP->DATAEM  With PED->DATA__,; 
                         TMP->QUANT_  WITH PXP->QUANT_,; 
                         TMP->VALOR_  With PXP->VLRUNI,; 
                         TMP->CLIENT  With PED->CODCLI,; 
                         TMP->INFO__  With PED->DESCRI,; 
                         TMP->RECNO_  With PED->( RECNO() ) 
                 ENDIF 
                 // Se for pedido 
                 IF !( ALLTRIM( TMP->( PEDIDO ) ) == "" ) 
                    // Soma de Quantidades 
                    nQuantidade:= nQuantidade + PXP->QUANT_ 
                 ELSE 
                    Replace TMP->PEDIDO With "Cotacao" 
                 ENDIF 
              ELSE 
                 // Exibe como informacao 
                 TMP->( DBAppend() ) 
                 Replace TMP->INFO__ With "< NF"  + StrZero( NF_->NUMERO, 8, 0 ) + NF_->NFNULA + ">"  + ; 
                                          PED->DESCRI,; 
                         TMP->DATAEM  With PED->DATA__,; 
                         TMP->PEDIDO With PED->CODPED,; 
                         TMP->QUANT_ With PXP->QUANT_,; 
                         TMP->RECNO_ With PED->( RECNO() ) 
                 IF NF_->NFNULA == "*" 
                    nQuantidade:= nQuantidade + PXP->QUANT_ 
                 ENDIF 
              ENDIF 
           ENDIF 
           // Proximo registro 
           DBSkip() 
           // Se quantidade atingiu limite estabelecida pela reserva 
           IF nQuantidade > MPR->RESERV .OR. PXP->( EOF() ) 
              EXIT 
           ENDIF 
       ENDDO 
       // Fim da gravacao 
 
       IF cRelEst=="R" 
          DBSelectAr( "TMP" ) 
          DBGoTop() 
 
          VPBox( 0, 00, 03, 79, "PRODUTO COM RESERVA DE " + alltrim( Tran( MPR->RESERV, "@E 99,999,999.9999" ) ) + " " + MPR->UNIDAD, _COR_GET_BOX ) 
          @ 02,01 Say Tran( MPR->INDICE, "@R 999-9999" ) + " " + MPR->DESCRI Color _COR_GET_BOX 
          VPBox( 04, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
          @ 22,02 Say " Total relacionado no display = " + Alltrim( Tran( nQuantidade, "@E 999,999,999.9999" ) ) + " " Color "15/00" 
          SetColor( _COR_BROWSE ) 
          DBLeOrdem() 
          Mensagem( "[ESC]Sair" ) 
          Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
          oTab:=tbrowsedb( 05, 01, 21, 78 ) 
          oTab:addcolumn(tbcolumnnew("                                                           ",; 
                {|| PEDIDO + " " + DTOC( DATAEM ) + " " + INFO__ + " " +  "      " +  Tran( QUANT_, "@e 999,999,999.9999" ) + " " + Tran( VALOR_, "@e 9,999,999.99" ) + Space( 30 ) })) 
          oTab:AUTOLITE:=.f. 
          oTab:dehilite() 
          WHILE .T. 
             oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
             whil nextkey()=0 .and.! oTab:stabilize() 
             enddo 
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
                case nTecla==K_ENTER 
                     lFocaliza:= .T. 
                     // Exibe conteudo do pedido 
                     IF lFocaliza 
                        RestoreAll() 
                        DBSelectAr( _COD_PEDIDO ) 
                        DBGoTo( TMP->( RECNO_ ) ) 
                        cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                        cCorRes:= SetColor() 
                        VPBox( 01, 02, 22, 78, "INFORMACOES RELATIVAS AO PEDIDO", _COR_GET_BOX ) 
                        SetColor( _COR_GET_EDICAO ) 
                        @ 02,04 SAY "Cotacao / Pedido [ Numeros ] " Color "14/" + CorFundoAtual() 
                        @ 03,04 Say "    " + PED->CODIGO + "/" + PED->CODPED 
                        @ 04,04 Say "Informacoes do Cliente" Color "14/" + CorFundoAtual() 
                        @ 05,04 Say "    " + PED->DESCRI 
                        @ 06,04 Say "    " + PED->ENDERE 
                        @ 07,04 Say "    " + PED->BAIRRO 
                        @ 08,04 Say "    " + PED->CIDADE + "-" + PED->ESTADO 
                        @ 09,04 Say "    " + PED->FONFAX 
                        @ 10,04 Say "Observacoes" Color "14/" + CorFundoAtual() 
                        @ 11,04 Say "    " + LEFT( ped->OBSER1, 65 ) 
                        @ 12,04 Say "    " + LEFT( ped->OBSER2, 65 ) 
                        @ 13,04 Say "    Previsao " + DTOC( ped->DATAEM ) 
                        @ 14,04 Say "    Gravacao " + DTOC( ped->DATA__ ) 
                        @ 15,04 Say "    " 
                        @ 16,04 Say "    Tipo     " + ped->TIPO__ 
                        @ 17,04 Say "Informacoes Financeiras" Color "14/" + CorFundoAtual() 
                        @ 18,04 Say "    Total do Pedido: " + Tran( VLRTOT, "@e 99,999,999.99" ) 
                        @ 19,04 Say "    " 
                        @ 20,04 Say "    " 
                        @ 21,04 Say "    " 
                        INKEY(0) 
 
                        SetColor( cCorRes ) 
                        //VPC88700() 
                        ScreenRest( cTelaRes ) 
 
                        DBSelectAr( 123 ) 
                     ENDIF 
                otherwise                ;tone(125); tone(300) 
             endcase 
             oTab:refreshcurrent() 
             oTab:stabilize() 
          ENDDO 
       ENDIF 
 
 
    ENDDO 
    RestoreAll() 
    // Arquivo Temporario 
    DBSelectAr( 123 ) 
    IF Used() 
       DBCloseArea() 
    ENDIF 
    DBSelectAr( "PED" ) 
    // Restaura 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
 
Static Function RestoreAll() 
 
    // Pedidos 
    DBSelectAr( _COD_PEDIDO ) 
    DBCloseArea() 
    FDBUseVpb( _COD_PEDIDO, 2 ) 
    SET RELATION TO 
 
    // Produtos x Pedidos 
    DBSelectAr( _COD_PEDPROD ) 
    DBCloseArea() 
    FDBUseVpb( _COD_PEDPROD, 2 ) 
    SET RELATION TO 
 
    Return Nil 
 
Stat Function BuscaProduto( cCodigo ) 
   MPR->( DBSetOrder( 1 ) ) 
   IF MPR->( DBSeek( cCodigo ) ) 
      Return .T. 
   ELSE 
       VisualProdutos( cCodigo ) 
       IF LastKey()==K_ENTER 
          cCodigo:= MPR->INDICE 
          Return .T. 
       ELSE 
          Return .F. 
       ENDIF 
   ENDIF 
   Return .T. 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
