// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC88011 
³ Finalidade  ³ Pesquisa aproveitamento dos pedidos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 01/07/2000 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 

#ifdef HARBOUR
function vpc88011()
#endif


    Local nVenIni:= 1, nVenFim:= 999, nTraIni:= 0, nTraFim:= 999
    Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
          nCursor:= SetCursor() 
 
    Local dDataIni:= CTOD( "  /  /  " ), dDataFim:= DATE() 
    Local dDataEmIni:= CTOD( "  /  /  " ), dDataEmFim:= DATE() 
 
    WHILE .T. 
 
       VPBox( 08, 08, 19, 76, "ESTATISTICA DE APROVEITAMENTO DE PEDIDOS POR PERIODO", _COR_GET_BOX  ) 
 
       /* ESTATISTICA */ 
       SetColor( _COR_GET_EDICAO ) 
       @ 10,10 Say "Periodo Entre" 
       @ 11,10 Get dDataIni 
       @ 11,25 Get dDataFim 
 
       @ 10,40 Say "Gravacao entre" 
       @ 11,40 Get dDataEmIni 
       @ 11,55 Get dDataEmFim 
 
       @ 13,10 Say "Vendedor Entre" 
       @ 14,10 Get nVenIni Pict "999" 
       @ 14,25 Get nVenFim Pict "999" 
 
       @ 16,10 Say "Transportadora Entre" 
       @ 17,10 Get nTraIni Pict "999" 
       @ 17,25 Get nTraFim Pict "999" 
       READ 
 
       IF LastKey()==K_ESC 
          EXIT 
       ENDIF 
 
       DBSelectAr( _COD_PEDPROD ) 
 
       DBSelectAr( _COD_PEDIDO ) 
       DBGOTOP() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       INDEX ON Str( CODNF_ ) + CODPED + DTOS( DATA__ ) TO INPED21 ; 
                  FOR     DATA__ >= dDataini .AND. DATA__ <= dDataFim    .AND.; 
                          DATAEM >= dDataEmIni .AND. DATAEM <= dDataEmFim .AND.; 
                      ( ( VENIN1 >= nVenIni  .AND. VENIN1 <= nVenFim )   .OR.; 
                        ( VENEX1 >= nVenIni  .AND. VENEX1 <= nVenFim ) ) .AND.; 
                        ( TRANSP >= nTraIni  .AND. TRANSP <= nTraFim ) EVAL {|| Processo() } 
 
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
 
 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
