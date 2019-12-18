// ## CL2HB.EXE - Converted
 
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC88012 
³ Finalidade  ³ Pesquisa Lancamento de pedidos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 01/07/2000 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
#ifdef HARBOUR
function vpc88012()
#endif


    Local nVenIni:= 0, nVenFim:= 999, nTraIni:= 0, nTraFim:= 999
    Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
          nCursor:= SetCursor() 
 
    Local cFormato:= "  " 
    Local dDataIni:= CTOD( "  /  /  " ), dDataFim:= DATE() 
    Local dDataEmIni:= CTOD( "  /  /  " ), dDataEmFim:= DATE() 
    Local cRelEst:= "R" 
 
    WHILE .T. 
 
       VPBox( 04, 08, 22, 76, "RELACAO DE PEDIDOS POR PERIODO", _COR_GET_BOX  ) 
 
       /* ESTATISTICA */ 
       SetColor( _COR_GET_EDICAO ) 
       @ 06,10 Say "[R]Relacao / [E]Estatistica" Get cRelEst Pict "!" Valid cRelEst $ "E-R" 
 
       @ 08,10 Say "Periodo Entre" 
       @ 09,10 Get dDataIni 
       @ 09,25 Get dDataFim 
 
       @ 08,40 Say "Gravacao entre" 
       @ 09,40 Get dDataEmIni 
       @ 09,55 Get dDataEmFim 
 
       @ 11,10 Say "Vendedor Entre" 
       @ 12,10 Get nVenIni Pict "999" 
       @ 12,25 Get nVenFim Pict "999" 
 
       @ 14,10 Say "Transportadora Entre" 
       @ 15,10 Get nTraIni Pict "999" 
       @ 15,25 Get nTraFim Pict "999" 
 
       @ 17,10 Say "Formato/Tipo:     (  /01/02/03/04/05/06/07 ou 99-Todos)" 
       @ 17,24 Get cFormato Pict "99" 
 
       READ 
 
       IF LastKey()==K_ESC 
          EXIT 
       ENDIF 
 
       DBSelectAr( _COD_PEDPROD ) 
 
       DBSelectAr( _COD_PEDIDO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       INDEX ON Str( CODNF_ ) + CODPED + DTOS( DATA__ ) TO INPED21 ; 
                  FOR     DATA__ >= dDataini .AND. DATA__ <= dDataFim      .AND.; 
                          DATAEM >= dDataEmIni .AND. DATAEM <= dDataEmFim   .AND.; 
                      ( IF( cFormato <> "99", cFormato == TIPO__, .T. ) )   .AND.; 
                      ( ( VENIN1 >= nVenIni  .AND. VENIN1 <= nVenFim )     .OR.; 
                        ( VENEX1 >= nVenIni  .AND. VENEX1 <= nVenFim ) )   .AND.; 
                        ( TRANSP >= nTraIni  .AND. TRANSP <= nTraFim ) EVAL {|| Processo() } 
 
       IF cRelEst=="E" 
          nQuantNota:=    0 
          nQuantPedido:=  0 
          nQuantCotacao:= 0 
          nQuantTotal:=   0 
 
          nValorNota:=    0 
          nValorPedido:=  0 
          nValorCotacao:= 0 
          nValorTotal:=   0 
 
          NF_->( DBSetOrder( 1 ) ) 
          DBGoTop() 
          WHILE !EOF() 
              IF CODNF_ > 0 
                 IF NF_->( DBSeek( PED->CODNF_ ) ) 
                    ++nQuantNota 
                    nValorNota:= nValorNota + NF_->VLRNOT 
                 ENDIF 
              ELSEIF CODNF_ == 0 .AND. LEFT( PED->SITUA_, 1 )=="C" 
                 ++nQuantCotacao 
                 nValorCotacao:= nValorCotacao + PED->VLRTOT 
              ELSEIF CODNF_ == 0 .AND. LEFT( PED->SITUA_, 1 )=="P" 
                 ++nQuantPedido 
                 nValorPedido:= nValorPedido + PED->VLRTOT 
              ENDIF 
              DBSkip() 
          ENDDO 
          nQuantTotal:= nQuantPedido + nQuantNota + nQuantCotacao 
          nValorTotal:= nValorPedido + nValorNota + nValorCotacao 
 
          VPBox( 0, 0, 22, 79, "GRAFICO DE MOVIMENTACOES (COTACOES / PEDIDOS / NOTAS)", _COR_GET_BOX ) 
          SetColor( _COR_GET_EDICAO ) 
          @ 02,01 Say "     ³ Cotacoes                                                             " 
          @ 03,01 Say " Qtd ³                                                                      " 
          @ 04,01 Say " Vlr ³                                                                      " 
          @ 05,01 Say "     ³                                                                      " 
          @ 06,01 Say "     ³ Pedidos Pendentes                                                    " 
          @ 07,01 Say " Qtd ³                                                                      " 
          @ 08,01 Say " Vlr ³                                                                      " 
          @ 09,01 Say "     ³                                                                      " 
          @ 10,01 Say "     ³ Notas Fiscais - Pedidos Processados                                  " 
          @ 11,01 Say " Qtd ³                                                                      " 
          @ 12,01 Say " Vlr ³                                                                      " 
          @ 13,01 Say "     ³                                                                      " 
          @ 14,01 Say "     ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂ " 
          @ 15,01 Say "                                                                            " 
 
          @ 17,01 Say " " 
          @ 18,01 Say " Cotacoes [00000][000000000000]" 
          @ 19,01 Say " Pedidos  [00000][000000000000]" 
          @ 20,01 Say " Notas    [00000][000000000000]" 
 
          cCor1:= "09" 
          cCor2:= "11" 
          @ 18,12 Say StrZero( nQuantCotacao, 05, 00 )         Color "00/" + cCor1 
          @ 18,19 Say Tran( nValorCotacao, "@E 99999,999.99" ) Color "00/" + cCor2 
 
          @ 19,12 Say StrZero( nQuantPedido, 05, 00 )          Color "00/" + cCor1 
          @ 19,19 Say Tran( nValorPedido, "@E 99999,999.99" )  Color "00/" + cCor2 
 
          @ 20,12 Say StrZero( nQuantNota, 05, 00 )            Color "00/" + cCor1 
          @ 20,19 Say Tran( nValorNota, "@E 99999,999.99" )    Color "00/" + cCor2 
 
          nPerc:= ( nQuantNota / nQuantTotal ) * 70 
          @ 11,07 Say Repl( "Û", nPerc ) Color cCor1 + "/" + CorFundoAtual() 
          nPerc:= ( nValorNota / nValorTotal ) * 70 
          @ 12,07 Say Repl( "Û", nPerc ) Color cCor2 + "/" + CorFundoAtual() 
 
          nPerc:= ( nQuantPedido / nQuantTotal ) * 70 
          @ 07,07 Say Repl( "Û", nPerc ) Color cCor1 + "/" + CorFundoAtual() 
          nPerc:= ( nValorPedido / nValorTotal ) * 70 
          @ 08,07 Say Repl( "Û", nPerc ) Color cCor2 + "/" + CorFundoAtual() 
 
          nPerc:= ( nQuantCotacao / nQuantTotal ) * 70 
          @ 03,07 Say Repl( "Û", nPerc ) Color cCor1 + "/" + CorFundoAtual() 
          nPerc:= ( nValorCotacao / nValorTotal ) * 70 
          @ 04,07 Say Repl( "Û", nPerc ) Color cCor2 + "/" + CorFundoAtual() 
 
          nValorUni:= nValorTotal / 7 
          nQuantUni:= nQuantTotal / 7 
          nVU:= 0 
          nQU:= 0 
          nLin:= 15 
          FOR nCt:= 1 TO 7 
              @ nLin,(nCt*10)-4 Say Tran( nVU+= nValorUni, "@e 999,999.99" ) 
              nLin:= if( nLin==15, 16, 15 ) 
          NEXT 
          Inkey( 0 ) 
       ELSE 
          DBSelectAr( _COD_PEDIDO ) 
          DBGoTop() 
          DispBegin() 
          VPBox( 00, 00, 06, 79, "RELACAO DE PEDIDOS", _COR_GET_BOX,.F.,.F.  ) 
          @ 01,03 Say "" 
          @ 02,03 Say "Pedidos emitidos entre " + DTOC( dDataIni ) + " e " + DTOC( dDataFim )             Color _COR_GET_EDICAO 
          @ 03,03 Say "Vendedores entre " + Str( nVenIni, 3, 0 ) + " e " + Str( nVenFim, 3, 0 )           Color _COR_GET_EDICAO 
          @ 04,03 Say "Transportadora entre " + Str( nTraIni, 3, 0 ) + " e " + Str( nTraFim, 3, 0 )       Color _COR_GET_EDICAO 
          @ 05,03 Say IF( cFormato <> "99", "Com status em " + cFormato, "Todos os formatos" )            Color _COR_GET_EDICAO 
          @ 06,03 Say "" 
          VPBox( 07, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
          SetColor( _COR_BROWSE ) 
          DBLeOrdem() 
          Mensagem( "[ESC]Sair" ) 
          Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
          oTab:=tbrowsedb( 08, 01, 21, 78 ) 
          oTab:addcolumn(tbcolumnnew("                                                           ",; 
                {|| CODIGO + " " + CODPED + " " + DESCRI + " " + IF( CODNF_ > 0, StrZero( CODNF_, 6, 0 ), Space( 6 ) ) + " " + TIPO__ + SPACE( 30 ) })) 
          oTab:AUTOLITE:=.f. 
          oTab:dehilite() 
          DispEnd() 
          WHILE .T. 
             oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
             whil nextkey()=0 .and.! oTab:stabilize() 
             enddo 
             nTecla:= inkey( 0 ) 
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
                Case DBPesquisa( nTecla, oTab ) 
                case nTecla=K_TAB 
                     Set( 24, "IMP.PRN" ) 
                     Relatorio( "RELPED.REP" ) 
                     ViewFile( "IMP.PRN" ) 
                otherwise                ;tone(125); tone(300) 
             endcase 
             oTab:refreshcurrent() 
             oTab:stabilize() 
          ENDDO 
       ENDIF 
 
       DBSelectAr( _COD_PEDIDO ) 
       DBCloseArea() 
       FDBUseVpb( _COD_PEDIDO ) 
 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
