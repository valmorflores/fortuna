// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
 
/* 
Funcao     - PEDIDOBAIXADO 
Finalidade - Retornar .T. se pedido esta baixado e .F. se 
             pedido n�o esta baixado. 
Data 
*/ 
Function PedidoBaixado() 
Local lPedBaixado:= .F., cDocumento:= "" 
   cDocumento:= PAD( "PD: " + StrZero( PED->CODNF_, 9, 0 ), LEN( EST->DOC___ ) ) 
   DPA->( DBSetOrder( 1 ) ) 
   EST->( DBSetOrder( 3 ) ) 
   lPedBaixado:= EST->( DBSeek( cDocumento ) ) 
   IF !lPedBaixado 
      IF PED->CODNF_ >= 900000000 
         IF DPA->( DBSeek( PED->CODNF_ ) ) 
            lPedBaixado:= .T. 
         ENDIF 
      ENDIF 
   ENDIF 
 
Return lPedBaixado 
 
 
/* 
Funcao     - PEDIDOPROCESSA 
Finalidade - Processar o pedido, gravando informacoes de Financeiro e Estoque 
Data       - 
*/ 
Function PedidoProcessa() 
local cDocumento:= PAD( "PD: " + StrZero( PED->CODNF_, 9, 0 ), LEN( EST->DOC___ ) ) 
local lDesfez:= .T. 
   EST->( DBSetOrder( 1 ) ) 
   lDesfez:= .T. 
   IF PedidoBaixado() 
      Aviso( "Pedido j� esta processado. Desfazendo, aguarde..." ) 
      lDesfez:= PedidoDesfazProcessamento() 
   ENDIF 
   DBSelectAr( "PED" ) 
   IF lDesfez 
      IF !Empty( PED->CODPED ) 
          Set Relation To 
          /* 
             Remete as informacoes de gravacao acrescentando a 
             letra <E> de automatico com execucao especial 
             ---> Gravacao de 9nnnnnnn onde nnnnnn=Numero do Pedido 
          */ 
          NFiscal( "E" + PED->CODPED ) 
          NF_->( DBSetOrder( 4 ) ) 
          DBSelectar( _COD_PEDIDO ) 
          Set Relation To Val( CodPed ) Into NF_, TRANSP into TRA 
          //IF oTb <> NIL 
          //   oTb:RefreshAll() 
          //   WHILE !oTb:Stabilize() 
          //   ENDDO 
          //ENDIF 
      ELSE 
          cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
          Aviso( "Pedido n�o foi gravado, impossivel processar informacoes." ) 
          Pausa() 
          ScreenRest( cTelaRes ) 
      ENDIF 
   ENDIF 
Return Nil 
 
 
 
 
Function PedidoDesfazProcessamento() 
Local cDocumento:= PAD( "PD: " + StrZero( PED->CODNF_, 9, 0 ), LEN( EST->DOC___ ) ),; 
      cIndice:= "" 
 
// PROCESSADOS EM ESTOQUE 
VPBox( 00, 00, 22, 79, " PRODUTOS PRE-PROCESSADOS ( DESFAZ )", _COR_GET_BOX ) 
SetColor( _COR_GET_BOX ) 
 
@ 01,01 Say "Itens Processados (Desfazer)" 
@ 01,40 Say "Novos itens" 
 
MPR->( DBSetOrder( 1 ) ) 
EST->( DBSetOrder( 3 ) ) 
EST->( DBSeek( cDocumento ) ) 
WHILE !EST->( EOF() ) .AND. EST->( DOC___ ) = cDocumento 
    SetColor( "12/" + corfundoAtual() ) 
    @ 21,01 Say SUBSTR( EST->CPROD_, 1, 7 ) + " " 
    IF MPR->( DBSeek( SubStr( EST->CPROD_, 1, 7 ) ) ) 
       @ 21,09 Say left( MPR->DESCRI, 25 ) 
    ELSE 
       @ 21,09 Say pad( "<< PRODUTO INDEFINIDO >>", 25 ) 
    ENDIF 
    Scroll( 2, 1, 21, 35, 1 ) 
    EST->( DBSkip() ) 
ENDDO 
 
// pxp A PROCESSAR 
PXP->( DBSetOrder( 1 ) ) 
pxp->( DBSeek( PED->CODIGO ) ) 
WHILE left( PED->CODIGO, 8 ) == Left( PxP->Codigo, 8 ) 
    SetColor( "11/" + corfundoAtual() ) 
    @ 21,40 Say StrZero( pxp->CODPRO, 7, 0 ) + " " 
    @ 21,49 say left( pxp->DESCRI, 25 ) 
    Scroll( 2, 40, 21, 78, 1 ) 
    pxp->( DBSkip() ) 
ENDDO 
 
mensagem( "Pressione [qualquer tecla] para continuar desfazendo ou [ESC] para sair" ) 
INKEY() 
 
if LastKey() <> K_ESC 
 
   // Estoque 
   EST->( DBSetOrder( 3 ) ) 
   WHILE EST->( DBSeek( cDocumento ) ) 
      OPE->( DBSetOrder( 1 ) ) 
      OPE->( DBSeek( est->CODMV_ ) ) 
      cIndice:= SubStr( est->CPROD_, 1, 7 ) 
      IF OPE->ENTSAI <> "*" 
         IF OPE->ENTSAI $ "S/3/4" 
            PoeNoEstoque( cIndice, est->QUANT_ ) 
         ELSE 
            TiraDoEstoque( cIndice, est->QUANT_ ) 
         ENDIF 
         EST->( RLock() ) 
         EST->( DBDelete() ) 
      ENDIF 
      EST->( DBSkip() ) 
   ENDDO 
 
   // Duplicatas
   DPA->( DBSetOrder( 1 ) )
   DPA->( DBGoTop() ) 
   WHILE DPA->( DBSeek( PED->CODNF_ )  ) .AND. !DPA->( EOF() ) 
      IF DPA->( RLOCK() ) 
        DPA->( DBdelete() ) 
      ENDIF 
   ENDDO 
 
   // 0 Pedido
   IF !PED->( EOF() )
      PED->( RLOCK() ) 
      Replace PED->CODNF_ With 0 
      PED->( dbUnlockAll() )
   ENDIF
 
   Return .T. 
 
ENDIF 
Return .F. 
 
 
Function PedidoConsistencia() 
 


Function PedVerificaCustos( oTb )
Local oTab
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),;
      aProdutos:= {}, nRow:= 1, i
Local nCustoTotal:= 0, nVendaTotal:= 0, nLucroTotal:= 0, nLucroMargem:= 0

   VPBOX( 0, 0, 22, 79, "PRODUTOS DE PEDIDOS X PRECO DE CUSTO - LUCRATIVIDADE", _COR_GET_BOX )
   SetColor( _COR_GET_EDICAO )
   @ 01,01 Say "Cliente.....: [" + PED->DESCRI + "]"
   @ 02,01 Say Replicate( Chr( 205 ), 78 )

   PXP->( DBSetOrder( 1 ) )
   PXP->( DBSeek( ped->codigo ) )
   WHILE PXP->CODIGO == PED->CODIGO
       IF LEFT( STRZERO( PXP->CODPRO, 7, 0 ), 3 ) <> SWSet( _GER_GRUPOSERVICOS )
          PXF->( DBSeek( PAD( StrZero( PXP->CODPRO, 7, 0 ), 12 ) ) )
          AAdd( aProdutos, { StrZero( PXP->CODPRO, 7, 0 ),;
                          PXP->DESCRI,;
                          PXP->VLRUNI,;
                          PXP->QUANT_,;
                          PXF->VALOR_,;
                          PXF->VALOR_ * PXP->QUANT_,;
                          PXP->VLRUNI * PXP->QUANT_,;
                          ( PXP->VLRUNI * PXP->QUANT_ ) - ( PXF->VALOR_ * PXP->QUANT_ ),;
                          0 } )
          aProdutos[ Len( aProdutos ) ][ 9 ]:=(  aProdutos[ Len( aProdutos ) ][ 8 ] / ;
                                                 aProdutos[ Len( aProdutos ) ][ 6 ] ) * 100
       ENDIF
       PXP->( DBSkip() )
       IF PXP->( EOF() )
          EXIT
       ENDIF
   ENDDO


   // Se produtos <= 0
   IF LEN( aProdutos ) <= 0
      Aviso( "Nao existem produtos neste pedido ou pedido nao esta gravado." )
      Pausa()
      ScreenRest( cTela )
      SetColor( cCor )
      Return nil
   ENDIF


   nCustoTotal:= 0
   nVendaTotal:= 0
   nLucroTotal:= 0
   nLucroMargem:= 0
   FOR i:= 1 to Len( aProdutos )
       nCustoTotal:= nCustoTotal + aProdutos[ i ][ 6 ]
       nVendaTotal:= nVendaTotal + aProdutos[ i ][ 7 ]
   NEXT
   nLucroTotal:= nVendaTotal - nCustoTotal
   @ 18,01 Say "Custo total............" + Tran( nCustoTotal, "@e 9,999,999.99" )
   @ 19,01 Say "Venda Total............" + Tran( nVendaTotal, "@E 9,999,999.99" )
   @ 20,01 Say "L U C R O ............." + Tran( nLucroTotal, "@E 9,999,999.99" )
   @ 20,40 Say "Lucratividade:" + Tran( ( nLucroTotal / nCustoTotal ) * 100, "@E 9,999.999" ) + "%"
   nRow:= 1
   oTab:=TBrowseNew( 03, 1, 17, 78 )
   oTab:addcolumn(tbcolumnnew( "Codigo"+Space(3)+"Descricao"+Space(10)+"Custo",;
                               {|| aProdutos[ nRow ][ 1 ] + " " + ;
                                 LEFT( aProdutos[ nRow ][ 2 ], 27 ) + ; 
                                 Tran( aProdutos[ nRow ][ 6 ], "@E 9,999,999.99" ) + " " +; 
                                 Tran( aProdutos[ nRow ][ 7 ], "@E 9,999,999.99" ) + ;
                                 Tran( aProdutos[ nRow ][ 8 ], "@E 999,999.99" ) + " " + ;
                                 Tran( aProdutos[ nRow ][ 9 ], "@E 9999.99" ) }))
   oTab:AUTOLITE:=.f. 
   oTab:GOTOPBLOCK :={|| nRow:= 1} 
   oTab:GOBOTTOMBLOCK:={|| nRow:= Len( aProdutos ) } 
   oTab:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aProdutos,@nRow)} 
   oTab:dehilite() 
   WHILE .T. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTab:stabilize() 
      end 
      nTecla:= inkey(0) 
      if nTecla==K_ESC   ;exit   ;endif 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   ENDDO 
   SetColor( cCor )
   ScreenRest( cTela )
   Return Nil






