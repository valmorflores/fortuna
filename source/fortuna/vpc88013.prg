// ## CL2HB.EXE - Converted
 
#Include "vpf.ch" 
#Include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC88013 
� Finalidade  � Pesquisa Lancamento de pedidos por midia 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � Maio/2001 
��������������� 
*/ 
#ifdef HARBOUR
function vpc88013()
#endif

    Local nVenIni:= 0, nVenFim:= 999, nTraIni:= 0, nTraFim:= 999
    Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
          nCursor:= SetCursor() 
 
    Local cFormato:= "  " 
    Local dDataIni:= CTOD( "  /  /  " ), dDataFim:= DATE() 
    Local dDataEmIni:= CTOD( "  /  /  " ), dDataEmFim:= DATE() 
    Local cRelEst:= "R" 
 
    WHILE .T. 
 
       VPBox( 04, 08, 22, 76, "RELACAO DE PEDIDOS POR PERIODO & MIDIA", _COR_GET_BOX  ) 
 
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
                          DATAEM >= dDataEmIni .AND. DATAEM <= dDataEmFim  .AND.; 
                      ( IF( cFormato <> "99", cFormato == TIPO__, .T. ) )  .AND.; 
                      ( ( VENIN1 >= nVenIni  .AND. VENIN1 <= nVenFim )     .OR.; 
                        ( VENEX1 >= nVenIni  .AND. VENEX1 <= nVenFim ) )   .AND.; 
                        ( TRANSP >= nTraIni  .AND. TRANSP <= nTraFim ) EVAL {|| Processo() } 
 
       CLI->( DBSetOrder( 1 ) ) 
       MID->( DBSetOrder( 1 ) ) 
 
       /* Relacionamentos */ 
       DBSelectAr( _COD_CLIENTE ) 
       Set Relation To MIDIA_ Into MID 
 
       DBSelectAr( _COD_PEDIDO ) 
       Set Relation To CODCLI Into CLI 
 
 
       IF cRelEst=="E" 
          aMidias:= {} 
          WHILE !EOF() 
              IF ( nPos:= ASCAN( CLI->MIDIA_,  ) ) 
 
              ENDIF 
 
              DBSkip() 
          ENDDO 
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
                {|| CODIGO + " " + CODPED + " " + LEFT( DESCRI, 30 ) + " " + IF( CODNF_ > 0, StrZero( CODNF_, 6, 0 ), Space( 6 ) ) + " " + MID->DESCRI + SPACE( 30 ) })) 
          oTab:AUTOLITE:=.f. 
          oTab:dehilite() 
          DispEnd() 
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
                Case DBPesquisa( nTecla, oTab ) 
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
 
       /* Fim de Relacionamentos */ 
       DBSelectAr( _COD_CLIENTE ) 
       Set Relation To 
 
       DBSelectAr( _COD_PEDIDO ) 
       Set Relation To 
 
    ENDDO 
    ScreenRest( cTela ) 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    Return Nil 
 
