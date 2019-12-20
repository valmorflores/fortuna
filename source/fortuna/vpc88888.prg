// ## CL2HB.EXE - Converted
 
/* 
** Modulo      - VPC88700 
** Descricao   - Modulo de pedidos / Cotacoes 
** Programador - Valmor Pereira Flores 
** Data        - 30/Novembro/1995 
** Atualizacao - 
*/ 
#Define DESCRI_TAMANHO  43 
#INCLUDE "formatos.ch" 
#include "vpf.ch" 
#include "inkey.ch" 



#ifdef HARBOUR
function vpc88888()
#endif



Cupom()
Return Nil 
 
/* 
**      Funcao - Cotacoes 
**  Finalidade - Consultar os dados de Cotacoes/Pedidos 
** Programador - Valmor Pereira Flores 
**  Parametros - Nenhum 
**     Retorno - Nenhum 
**        Data - 03/Maio/1995 
** Atualizacao - 29/Maio/1995 
*/ 
Static Function Cupom() 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(), cCOR:=SetColor() 
Loca oTb, oCLIE, nTECLA, nTELA:=1 
Loca nCODCLI, nCODPRO, cTELA0, aBOX[2], cDESCLI, cDESPRO 
Loca lFLAG:=.F., lALTERAPOS:=.T. 
Loca GETLIST:={} 
Loca aProdutos:= {}, cCodigoDele 
Loca nPosicao:= 0, nPrecoInicial, nPerDesconto, nPrecoFinal, nQuantidade,; 
     cCliente, aPedido:= {}, lAltera:= .F., nOpcao:= 1 
If !AbreGrupo( "PEDIDOS" ) 
   Return Nil 
EndIf 
VPBox( 18, 24, 21, 52 ) 
@ 19,25 Prompt " 1 Venda                  " 
@ 20,25 Prompt " 2 Verificacao de Pedidos " 
Menu To nOpcao 
IF ! LastKey() == K_ESC 
   IF nOpcao == 2 
      Cotacoes() 
   ELSE 
      /* Set a opcao de finalizacao por gravacao */ 
      SWSet( 5000, .T. ) 
      ListaPreco() 
   ENDIF 
ENDIF 
SetCursor(0) 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
DBUnLockAll() 
FechaArquivos() 
return(.T.) 
 
 
***************************************************************************** 
 
/* 
* Modulo       - CalculoDesconto 
* Finalidade   - Calcular o desconto. 
* Programador  - Valmor Pereira Flores 
* Data         - 26/Outubro/1995 
* Atualizacao  - 
*/ 
Static Function CalculaDesconto( oGet, ListaGet, nPosInicial, nPosFinal ) 
   /* Calcula o desconto */ 
   ListaGet[ nPosFinal ]:VarPut( ( ListaGet[ nPosInicial ]:VarGet() ) - ( ( Val( oGet:Buffer ) * ListaGet[ nPosInicial ]:VarGet() ) / 100 ) ) 
   /* Apresenta o resultado */ 
   ListaGet[ nPosFinal ]:Display() 
   DisplayIPI( ListaGet[ nPosFinal ]:VarGet() ) 
   Return( .T. ) 
 
 
Static Function DisplayIPI( nPrecoFinal ) 
Local nValorIpi:= ( ( nPrecoFinal * MPr->IPI___ ) / 100 ) 
   @ 16,12 Say "% IPI......: [" + Tran( MPr->IPI___, "@E 999.99" ) + "]" 
   @ 17,12 Say "Valor IPI..: [" + Tran( nValorIpi, "@E 999,999.99" ) + "]" 
   Return nValorIpi 
 
 
 
/* 
* Modulo      - VisualizaCotacoes 
* Parametro   - Nenhum 
* Finalidade  - Verificacao/Manutencao de Cotacoes para gerar pedidos. 
* Programador - Valmor Pereira Flores 
* Data        - 26/Outubro/1995 
* Atualizacao - 
*/ 
Static Func VisualizaCotacoes( oTBrowse ) 
Loca oTb, cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 ),; 
     nRow:=1, aCotacoes:= {}, aPedido:= {},; 
     nCursor:= SetCursor(), nArea:= Select(), nOrdem:= IndexOrd(),; 
     cCodPed 
 
//   DBSelectar( _COD_PEDIDO ) 
//   @ 01,01 say CODIGO 
//   PAUSA() 
 
//   If DBSeek( "Sim" ) 
//      While Select=="Sim" 
         AAdd( aCotacoes, { Ped->Codigo, Ped->CodCli, Ped->Descri } ) 
//         DBSkip() 
//      EndDo 
//   Else 
//      Aviso( "Nenhuma cota��o foi selecionada...", 24 /2 ) 
//      Pausa() 
//      SetColor( cCor ) 
//      SetCursor( nCursor ) 
//      ScreenRest( cTela ) 
//      DBSelectAr( nArea ) 
//      DBSetOrder( nOrdem ) 
//      Return Nil 
//   EndIf 
   DBSetOrder( 1 ) 
 
   /* Coloca em ordem default */ 
   DBSetOrder( 1 ) 
 
   /* Apaga o arquivo de indice provis�rio */ 
   FErase( "IndiceRes.Ntx" ) 
 
   DBSelectar( _COD_PEDPROD ) 
   DBSetOrder( 1 ) 
   For nCt:= 1 To Len( aCotacoes ) 
       If DBSeek( aCotacoes[ nCt ][ 1 ] ) 
          While aCotacoes[ nCt ][ 1 ] == PxP->Codigo 
              AAdd( aPedido, { PxP->CodFab,; 
                               PxP->Descri,; 
                               PxP->VlrIni,; 
                               PxP->PerDes,; 
                               PxP->VlrUni,; 
                               PxP->Quant_,; 
                               PxP->Unidad,; 
                               PxP->IPI___,; 
                               PxP->Icm___,; 
                               PxP->Select,; 
                               PxP->CodPro } ) 
              DBSkip() 
          EndDo 
       EndIf 
   Next 
   If Empty( aCotacoes ) .OR. Empty( aPedido ) 
      Mensagem( "Arquivo de Pedidos / Cotacoes vazio. Pressione ENTER para continuar." ) 
      Tone( 300, 3 ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
      Return Nil 
   EndIf 
 
   DispBegin() 
   SetColor( _COR_BROWSE ) 
   VPBox( 0, 0, 22, 79, " Cotacao", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. ) 
   @ 1, 1 Say "Pedido.....: " + Ped->Codigo 
   @ 2, 1 Say "Codigo.....: " + StrZero( Ped->CodCli, 4, 0 ) 
   @ 3, 1 Say "Cliente....: " + Ped->Descri 
   @ 4, 1 Say "Endere�o...: " + Ped->Endere 
   @ 5, 1 Say "Cidade.....: " + Ped->Cidade 
   @ 6, 1 Say "Contato....: " + Ped->Compra 
   @ 7, 1 Say "Fone/Fax...: " + Ped->FonFax 
   @ 8, 1 Say "Transportad: " + StrZero( Ped->Transp, 3, 0 ) 
   SetColor( _COR_BROW_TITULO ) 
   Scroll( 9, 0, 9, 79 ) 
   @ 09, 01 Say "Produto" 
   @ 09, 33 Say "Un" 
   @ 09, 37 Say "Quantidade" 
   @ 09, 53 Say "Preco Unit�rio" 
   @ 09, 68 Say "%IPI" 
   DispEnd() 
   DBSelectar( _COD_PEDPROD ) 
 
   CalculoGeral( aPedido ) 
   SetCursor( 0 ) 
   Mensagem("[ESPACO]Seleciona, [ENTER]Altera_Dados [G]Gerar_Pedido e [ESC]Sai") 
 
   SetColor( _COR_BROWSE ) 
   oTb:=TBrowseNew( 10, 1, 20, 78 ) 
   oTb:addcolumn(tbcolumnnew(,{|| Left( aPedido[ nRow ][ 1 ] + "-" + ; 
                                     aPedido[ nRow ][ 2 ], 30 ) + ; 
                                " � " + aPedido[ nRow ][ 7 ] + " � " +; 
                                  Tran( aPedido[ nRow ][ 6 ], "@E 9,999,999.99" ) + " � " +; 
                                  Tran( aPedido[ nRow ][ 5 ], "@E 9999,999.999" ) + " � " +; 
                                  Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )       +  " �" + aPedido[ nRow ][ 10 ] })) 
   oTb:AUTOLITE:=.f. 
   oTb:GOTOPBLOCK :={|| nRow:= 1} 
   oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aPedido ) } 
   oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPedido,@nRow)} 
   oTb:dehilite() 
   whil .t. 
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTb:stabilize() 
      end 
      SetColor( "W+/G" ) 
      @ 21,33 Say PadC( Alltrim( aPedido[ nRow ][ 2 ] ), 45, " " ) 
      SetColor( _COR_BROWSE ) 
      nTecla:=inkey(0) 
      if nTecla==K_ESC   ;exit   ;endif 
      do case 
         case nTecla==K_UP         ;oTb:up() 
         case nTecla==K_DOWN       ;oTb:down() 
         case nTecla==K_LEFT       ;oTb:up() 
         case nTecla==K_RIGHT      ;oTb:down() 
         case nTecla==K_PGUP       ;oTb:pageup() 
         case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         case nTecla==K_PGDN       ;oTb:pagedown() 
         case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         case Chr( nTecla ) $ "Gg" 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              DBSelectar( _COD_PEDIDO ) 
              DBSetOrder( 1 ) 
              DBSeek( aCotacoes[ 1 ][ 1 ] ) 
              IF Empty( CODPED ) 
                 Aviso("Gerando Pedido...", 24 / 2 ) 
                 Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...") 
                 DBSelectar( _COD_PEDIDO ) 
                 cCodCot:= Codigo 
                 DBSetOrder( 6 ) 
                 DBGoBottom() 
                 cCodPed:= StrZero( Val( CodPed ) + 1, 8, 0 ) 
                 DBSetOrder( 1 ) 
                 For nCt:= 1 To Len( aCotacoes ) 
                     If DBSeek( aCotacoes[ nCt ][ 1 ] ) 
                        Rlock() 
                        If !NetErr() 
                           Replace Situa_ With "PED",; 
                                   Select With "Nao",; 
                                   CodPed With cCodPed 
                        EndIf 
                        DBUnLock() 
                     Else 
                        Aviso( " Cotacao n� " + aCotacoes[ nCt ][ 1 ] + " nao foi encontrada...", 24 / 2 ) 
                        Pausa() 
                     EndIf 
                 Next 
                 Aviso( "Atualizando os produtos...", 24 / 2 ) 
                 Mensagem( "Gravando arquivo de produtos por PEDIDOS, aguarde..." ) 
                 DBSelectar( _COD_PEDPROD ) 
                 DBSetOrder( 1 ) 
                 nCt:= 0 
                 If DBSeek( cCodCot ) 
                    While left( cCodCot, 8 ) == Left( PxP->Codigo, 8 ) 
                        RLock() 
                        Replace CodPed With cCodPed 
                        IF ( nPosicao:= AScan( aPedido, {|x| Alltrim( x[1] ) == Alltrim( PXP->CODFAB ) .AND.; 
                                                             Alltrim( x[2] ) == Alltrim( PXP->DESCRI ) } ) ) > 0 
                           IF aPedido[ nPosicao ][ 10 ] == "Nao" 
                              Dele 
                           ENDIF 
                        ENDIF 
                        DBUnlockAll() 
                        DBSkip() 
                    EndDo 
                 EndIf 
                 Aviso( "Foi gerado o pedido de N� " + cCodPed + "...", 24 / 2 ) 
                 Mensagem( "Pressione [ENTER] para continuar..." ) 
                 Pausa() 
 
                 /* Set a opcao de finalizacao por gravacao */ 
                 SWSet( 5000, .F. ) 
 
              ELSE 
                 Aviso( "Esta  Cotacao ja esta gravada como pedido.", 24 / 2 ) 
                 Mensagem( "Pressione [ENTER] para continuar..." ) 
                 Pausa() 
                 ScreenRest( cTelaReserva ) 
              ENDIF 
         case nTecla==K_F2 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 10, 10, 20, 70, "INCLUSAO DE ITEM", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              SetColor( _COR_GET_EDICAO ) 
              AAdd( aPedido, { Space( 15 ),; 
                               Space( 50 ),; 
                               0.00,; 
                               0.00,; 
                               0.00,; 
                               0.00,; 
                               Spac( 2 ),; 
                               0.00,; 
                               0.00,; 
                               Space( 3 ),; 
                               SPACE( 12 ) } ) 
              nRow:= Len( aPedido ) 
              cCodigo:= "9999" 
              cGrupo_:= "999" 
              nPrecoInicial:= aPedido[ nRow ][ 3 ] 
              nPerDesconto:= aPedido[ nRow ][ 4 ] 
              nPrecoFinal:= aPedido[ nRow ][ 5 ] 
              nQuantidade:= aPedido[ nRow ][ 6 ] 
              SetCursor(1) 
              @ 11,12 Say "Produto....:" Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo ) 
              @ 11,30 Say "-" 
              @ 11,31 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList ) when mensagem("Digite o c�digo do produto.") 
              @ 12,12 Say "Descri��o..: [" + LEFT( aPedido[ nRow ][ 2 ], DESCRI_TAMANHO ) + "]" 
              @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid {|oGet| CalculaDesconto( oGet, GetList, 3, 5 ) } 
              @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" 
              VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              DisplayIPI( nPrecoFinal ) 
              Read 
              If LastKey() <> K_ESC 
                 aPedido[ nRow ][ 1 ]:= MPr->CodFab 
                 aPedido[ nRow ][ 2 ]:= MPr->Descri 
                 aPedido[ nRow ][ 10 ]:= "Sim" 
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial 
                 aPedido[ nRow ][ 4 ]:= nPerDesconto 
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal 
                 aPedido[ nRow ][ 6 ]:= nQuantidade 
              Else 
                 --nRow 
                 ADEL( aPedido, nRow ) 
              EndIf 
              ScreenRest( cTelaReserva ) 
              SetColor( _COR_BROWSE ) 
              CalculoGeral( aPedido ) 
              oTb:RefreshAll() 
              WHILE !oTb:stabilize() 
              ENDDO 
         Case nTecla==K_SPACE 
              aPedido[ nRow ][ 10 ]:= If( aPedido[ nRow ][ 10 ]=="Sim", "Nao", "Sim" ) 
              CalculoGeral( aPedido ) 
         Case nTecla==K_ENTER 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 10, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              SetColor( _COR_GET_EDICAO ) 
              nPrecoInicial:= aPedido[ nRow ][ 3 ] 
              nPerDesconto:= aPedido[ nRow ][ 4 ] 
              nPrecoFinal:= aPedido[ nRow ][ 5 ] 
              nQuantidade:= aPedido[ nRow ][ 6 ] 
              SetCursor(1) 
              @ 11,12 Say "Produto....: [" + aPedido[ nRow ][ 1 ] + "]" 
              @ 12,12 Say "Descri��o..: [" + LEFT( aPedido[ nRow ][ 2 ], DESCRI_TAMANHO ) + "]" 
              @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99" Valid {|oGet| CalculaDesconto( oGet, GetList, 1, 3 ) } 
              @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" 
              VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              DisplayIPI( nPrecoFinal ) 
              Read 
              If LastKey() <> K_ESC 
                 aPedido[ nRow ][ 10 ]:= "Sim" 
                 aPedido[ nRow ][ 3 ]:= nPrecoInicial 
                 aPedido[ nRow ][ 4 ]:= nPerDesconto 
                 aPedido[ nRow ][ 5 ]:= nPrecoFinal 
                 aPedido[ nRow ][ 6 ]:= nQuantidade 
              EndIf 
              ScreenRest( cTelaReserva ) 
              SetColor( _COR_BROWSE ) 
              CalculoGeral( aPedido ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:refreshcurrent() 
      oTb:stabilize() 
   enddo 
   setcursor(1) 
   setcolor(cCor) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   oTBrowse:RefreshAll() 
   While !oTBrowse:Stabilize() 
   EndDo 
   return(if(nTecla=27,.f.,.t.)) 
 
/* 
* Modulo      - Cotacao 
* Parametro   - Nenhum 
* Finalidade  - Verificacao/Manutencao de  Cotacao. 
* Programador - Valmor Pereira Flores 
* Data        - 26/Outubro/1995 
* Atualizacao - 
*/ 
Static Func  Cotacao( aPedido ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Loca oTb, cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 ),; 
     nRow:=1,; 
     nSubTotal:= 0, nTotal:= 0, nIPI:= 0, nCt:= 0 
 
DBSelectAR( _COD_PEDIDO ) 
DBSetOrder( 1 ) 
DBGoBottom() 
cCodigo:= StrZero( Val( CODIGO ) + 1, 8, 0 ) 
 
DispBegin() 
SetColor( _COR_BROWSE ) 
VPBox( 0, 0, 22, 79, " Cotacao", _COR_BROW_BOX , .F., .F., _COR_BROW_TITULO, .F. ) 
@ 1, 1 Say "Pedido.....: " 
@ 2, 1 Say "Codigo.....: " + StrZero( CLI->Codigo, 4, 0 ) 
@ 3, 1 Say "Cliente....: " + Cli->Descri 
@ 4, 1 Say "Endere�o...: " + Cli->Endere 
@ 5, 1 Say "Cidade.....: " + Cli->Cidade 
@ 6, 1 Say "Contato....: " + Cli->Compra 
@ 7, 1 Say "Fone/Fax...: " + Cli->Fone1_ + " / " + Cli->Fax___ 
@ 8, 1 Say "Transportad: " + StrZero( Cli->Transp, 3, 0 ) 
SetColor( _COR_BROW_TITULO ) 
Scroll( 9, 0, 9, 79 ) 
@ 09, 01 Say "Produto" 
@ 09, 33 Say "Un" 
@ 09, 37 Say "Quantidade" 
@ 09, 53 Say "Preco Unit�rio" 
@ 09, 68 Say "%IPI" 
DispEnd() 
CalculoGeral( aPedido ) 
SetCursor( 0 ) 
Mensagem("[ESPACO]Seleciona, [ENTER]Altera_Dados [G]Gerar_ Cotacao e [ESC]Sai") 
SetColor( _COR_BROWSE ) 
oTb:=TBrowseNew( 10, 1, 20, 78 ) 
oTb:addcolumn(tbcolumnnew(,{|| Left( aPedido[ nRow ][ 1 ] + "-" + ; 
                                     aPedido[ nRow ][ 2 ], 30 ) + ; 
                                " � " + aPedido[ nRow ][ 7 ] + " � " +; 
                                  Tran( aPedido[ nRow ][ 6 ], "@E 9,999,999.99" ) + " � " +; 
                                  Tran( aPedido[ nRow ][ 5 ], "@E 9999,999.999" ) + " � " +; 
                                  Tran( aPedido[ nRow ][ 8 ], "@E 99.99" )       +  " �" + aPedido[ nRow ][ 10 ] })) 
oTb:AUTOLITE:=.f. 
oTb:GOTOPBLOCK :={|| nRow:= 1} 
oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aPedido ) } 
oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPedido,@nRow)} 
oTb:dehilite() 
whil .t. 
   oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
   whil nextkey()==0 .and. ! oTb:stabilize() 
   end 
   nTecla:=inkey(0) 
   if nTecla==K_ESC   ;exit   ;endif 
   do case 
      case nTecla==K_UP         ;oTb:up() 
      case nTecla==K_DOWN       ;oTb:down() 
      case nTecla==K_LEFT       ;oTb:up() 
      case nTecla==K_RIGHT      ;oTb:down() 
      case nTecla==K_PGUP       ;oTb:pageup() 
      case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
      case nTecla==K_PGDN       ;oTb:pagedown() 
      case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
      case Chr( nTecla ) $ "Gg" .OR. nTecla == K_TAB 
           cTelaRes1:= ScreenSave( 0, 0, 24, 79 ) 
           cCorRes:= SetColor() 
           nArea:= Select() 
           nVendedor:= 0 
           nValor:= 0 
           nDesconto:= 0 
           nPago:= 0 
           nApagar:= 0 
           nTroco:= 0 
           nSubTotal:= 0 
           nIpi:= 0 
           For nCt:= 1 To Len( aPedido ) 
               If aPedido[ nCt ][ 10 ] == "Sim" 
                  nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] 
                  nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
               EndIf 
           Next 
           nValor:= nSubTotal + nIPI 
           VPBox( 10, 10, 18, 69, " Fechamento de Valores ", _COR_GET_BOX ) 
           SetColor( _COR_GET_EDICAO ) 
 
           @ 11,11 Say " Vendedor(a)..........:" Get nVendedor Pict "@E 9999" VALID VenSeleciona( @nVendedor, 1 ) When; 
             Mensagem( "Digite o codigo do vendedor." ) 
           @ 12,11 Say " ����������������������������������������İ۰۰�" 
           @ 13,11 Say " VALOR TOTAL......... �" + Tran( nValor, "@E 99,999,999,999.99" ) 
           @ 14,11 Say " Desconto (%)........ �" Get nDesconto Pict "@E 99.99" Valid Desconto( nValor, @nDesconto, @nApagar ) When; 
             Mensagem( "Digite o percentual de desconto." ) 
           @ 15,11 Say " TOTAL A PAGAR....... �" + Tran( nAPagar, "@E 999,999,999,999.99" ) 
           @ 16,11 Say " Pago................ �"  Get nPago Pict "@E 999,999,999,999.99" Valid nPago >= nApagar WHEN; 
             DisplayNumero( nAPagar, " Total a Pagar " ) .AND. Mensagem( "Digite o valor pago pelo cliente." ) 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           READ 
           IF LastKey() == K_ESC 
              ScreenRest( cTelaRes1 ) 
              Loop 
           ENDIF 
 
           IF ! nPago == 0 
              nTroco:= nPago - nApagar 
           ELSE 
              nTroco:= 0 
           ENDIF 
           @ 17,11 Say " Troco������������-" + Tran( nTroco, "@E 999,999,999,999.99" ) 
           DisplayNumero( nTroco, "Troco R$" ) 
           Inkey( 3 ) 
           ScreenRest( cTelaRes ) 
           IF Confirma( 00, 00,; 
              "DESEJA GRAVAR ESTE PEDIDO?",; 
              "Digite [S] para confirmar ou [N] p/ cancelar.", "S" ) 
 
              Aviso("Gerando  Cotacao...", 24 / 2 ) 
              Mensagem("Gravando arquivo de PEDIDOS/COTACOES, aguarde...") 
 
              DBSelectar( _COD_PEDIDO ) 
              DBSetOrder( 1 ) 
 
              RLock() 
              If !NetErr() 
                 Replace Codigo With cCodigo,; 
                         CodCli With 0,; 
                         Descri With Cli->Descri,; 
                         Endere With Cli->Endere,; 
                         Bairro With Cli->Bairro,; 
                         Cidade With Cli->Cidade,; 
                         Estado With Cli->Estado,; 
                         Compra With Cli->Compra,; 
                         Cobran With Cli->Cobran,; 
                         CGCMf_ With Cli->CGCMf_,; 
                         Inscri With Cli->Inscri,; 
                         Transp With Cli->Transp,; 
                         FonFax With Cli->Fone1_ + " / " + Cli->Fax___,; 
                         CodCep With Cli->CodCep,; 
                         VenIn1 With nVendedor,; 
                         Select With "Nao",; 
                         Data__ With Date(),; 
                         Situa_ With "COT",; 
                         VlrTot With nAPagar 
              EndIf 
              Mensagem( "Gravando arquivo de produtos por PEDIDOS/COTACOES, aguarde..." ) 
              LancCaixa( "+", nVendedor, "VENDA AO CONSUMIDOR", nApagar, Date(), 0 ) 
              DBSelectar( _COD_PEDPROD ) 
              DBSeek( cCodigo ) 
              WHILE Codigo == cCodigo 
                  RLock() 
                  IF !NetErr() 
                    dele 
                     DBSkip() 
                  ENDIF 
                  DBUnlock() 
              ENDDO 
              For nCt:= 1 To Len( aPedido ) 
                 DBAppend() 
                 RLock() 
                 IF nDesconto > 0 
                    nVlrUnitario:= aPedido[ nCt ][ 3 ] - ( ( aPedido[ nCt ][ 5 ] * nDesconto ) / 100 ) 
                 ELSE 
                    nVlrUnitario:= aPedido[ nCt ][ 3 ] 
                 ENDIF 
                 If !NetErr() 
                    Repl Codigo With cCodigo,; 
                         CodFab With aPedido[ nCt ][ 1 ],; 
                         CodPro With aPedido[ nCt ][ 11 ],; 
                         Descri With aPedido[ nCt ][ 2 ],; 
                         VlrIni With aPedido[ nCt ][ 3 ],; 
                         PerDes With nDesconto,; 
                         VlrUni With nVlrUnitario,; 
                         Quant_ With aPedido[ nCt ][ 6 ],; 
                         Unidad With aPedido[ nCt ][ 7 ] 
                 EndIf 
                 DBUnlock() 
              Next 
              IF SWSet( _PED_TIRADOESTOQUE ) 
                 FOR nCt:= 1 TO LEN( aPedido ) 
                     LancEstoque( StrZero( aPedido[ nCt ][ 11 ], 7, 0 ),; 
                                  StrZero( aPedido[ nCt ][ 11 ], 7, 0 ),; 
                                  "-", "RES: " + cCodigo, 0, 0,; 
                                  aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ],; 
                                 aPedido[ nCt ][ 6 ], nGCodUser, DATE() ) 
                 NEXT 
              ENDIF 
              Keyboard Chr( K_ENTER ) + "G" + Chr( K_ESC ) 
              Cotacoes() 
              Inkey() 
              Keyboard Chr( 0 ) 
              IF Confirma( 00, 00,; 
                 "Venda Concretizada?",; 
                 "Digite [S] para confirmar ou [N] p/ cancelar.", SWSet( _PED_IMPRIMEPEDIDO ) ) 
                 /* Se for programado para emitir CUPOM */ 
                 IF !SWSet( _PED_NOTAFISCAL ) 
                    IF !Empty( CODPED ) 
                        Relatorio( "PEDIDOS.REP" ) 
                    ELSE 
                        Private Troco:= nTroco, Pago:= nPago, Desconto:= nDesconto 
                        Relatorio( "Cotacao.REP" ) 
                    ENDIF 
                 ENDIF 
              ENDIF 
              Mensagem("Desmarcando produtos, aguarde...") 
              LimpaMarcas( aPedido ) 
              Guardiao( "<SYS> " + ZipChr( "ARQ: " + cCodigo + " RGS: " + TRAN( nApagar, "@E 999,999.99" ) + " SUPORT: " + STRZERO( nVendedor, 4, 0 ) ) ) 
              DBCloseAll() 
              IF !AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
                 Finaliza() 
              ENDIF 
              CLI->( DbSeek( 9999999999999999999999 ) ) 
 
              DBSelectar( nArea ) 
              KEYBOARD Chr( K_ESC ) + Chr( K_ESC ) 
 
              /* Limpa aPedido */ 
              /* Set a opcao de finalizacao por gravacao */ 
              SWSet( 5000, .F. ) 
 
           ELSE 
              ScreenRest( cTelaRes1 ) 
              SetColor( cCorRes ) 
 
              /* Seleciona como verdadeiro */ 
              SWSet( 5000, .T. ) 
 
           ENDIF 
      case nTecla==K_SPACE 
           aPedido[ nRow ][ 10 ]:= If( aPedido[ nRow ][ 10 ]=="Sim", "Nao", "Sim" ) 
           CalculoGeral( aPedido ) 
      case nTecla==K_ENTER 
           cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
           VPBox( 09, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
           SetColor( _COR_GET_EDICAO ) 
           nPrecoInicial:= aPedido[ nRow ][ 3 ] 
           nPerDesconto:= aPedido[ nRow ][ 4 ] 
           nPrecoFinal:= nPrecoInicial 
           nQuantidade:= aPedido[ nRow ][ 6 ] 
           cOrigem:= aPedido[ nRow ][ 9 ] 
           SetCursor(1) 
           @ 10,12 Say "Produto....: [" + aPedido[ nRow ][ 1 ] + "]" 
           @ 11,12 Say "Descri��o..: [" + LEFT( aPedido[ nRow ][ 2 ], DESCRI_TAMANHO ) + "]" 
           @ 12,12 Say "Fabricante.: [" + cOrigem + "]" 
           @ 13,12 Say "Pre�o......: [" + Tran( nPrecoInicial, "@E 999,999,999.999" ) + "]" 
           VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
           @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
           DisplayIPI( nPrecoFinal ) 
           Read 
           If LastKey() <> K_ESC 
              aPedido[ nRow ][ 10 ]:= "Sim" 
              aPedido[ nRow ][ 3 ]:= nPrecoInicial 
              aPedido[ nRow ][ 4 ]:= nPerDesconto 
              aPedido[ nRow ][ 5 ]:= nPrecoFinal 
              aPedido[ nRow ][ 6 ]:= nQuantidade 
              aPedido[ nRow ][ 9 ]:= cOrigem 
           EndIf 
           ScreenRest( cTelaReserva ) 
           SetColor( _COR_BROWSE ) 
           CalculoGeral( aPedido ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTb:refreshcurrent() 
   oTb:stabilize() 
enddo 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
setcursor(1) 
setcolor(cCor) 
ScreenRest( cTela ) 
return(if(nTecla=27,.f.,.t.)) 
 
 
/***** 
�������������Ŀ 
� Funcao      � DESCONTO 
� Finalidade  � Processar descontos 
� Parametros  � nValor / nDesconto / nApagar 
� Retorno     � Nil 
� Programador � Valmor P. Flores 
� Data        � 
��������������� 
*/ 
Function Desconto( nValor, nDesconto, nApagar ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
LOCAL nValorDesc:= 0 
IF nDesconto > SWSet( _PED_MAXDESCONTO ) 
   Aviso( " Desconto nao devera ser maior que " + StrZero( SWSet( _PED_MAXDESCONTO ), 2, 0 ) + "%...", 12 ) 
   Mensagem( "Pressione [ENTER] para continuar..." ) 
   Pausa() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   RETURN .F. 
ENDIF 
IF ! nDesconto == 0 
   nValorDesc:= ( nValor * nDesconto ) / 100 
ENDIF 
nAPagar:= nValor - nValorDesc 
@ 15,11 SAY " TOTAL A PAGAR....... �" + Tran( nAPagar, "@E 999,999,999,999.99" ) 
Return .T. 
 
 
/* 
* Modulo      - CalculoGeral 
* Finalidade  - Apresentar no rodap� o calculo total do pedido 
* Programador - Valmor Pereira Flores 
* Data        - 26/Outubro/1995 
* Atualizacao - 
*/ 
Static Function CalculoGeral( aPedido ) 
Local cCor:= SetColor() 
Local nSubTotal:= 0, nIPI:= 0, nTotal:= 0 
   DispBegin() 
   SetColor( "W+/G" ) 
   Scroll( 21, 1, 22, 78 ) 
   For nCt:= 1 To Len( aPedido ) 
       If aPedido[ nCt ][ 10 ] == "Sim" 
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] 
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
       EndIf 
   Next 
   nTotal:= nSubTotal + nIPI 
   @ 21, 01 Say "Sub-Total..: " + Tran( nSubTotal, "@E 999,999,999,999.99" ) 
   @ 22, 01 Say "Valor IPI..: " + Tran( nIPI,      "@E 999,999,999,999.99" ) 
   @ 22, 47 Say "Total Geral: " + Tran( nTotal,    "@E 999,999,999,999.99" ) 
   SetColor( cCor ) 
   DispEnd() 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerGrupo 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerGrupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      Return( .T. ) 
   EndIf 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 ) 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerCodigo 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerCodigo( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 1 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
      GetList[3]:VarPut( Space( Len( MPr->Descri ) ) ) 
      GetList[4]:VarPut( Space( Len( MPr->Unidad ) ) ) 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      Return( .T. ) 
   EndIf 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Pressione [Enter] para ver lista..." ) 
      Pausa() 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[1]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   GetList[3]:VarPut( IF( MPr->PrecoD<>0, MPr->PrecoD, MPr->PrecoV ) ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
#Define _PEDIDOS_FILE    M->GDIR-"\PEDIDOS.VPM" 
 
/* 
**      Funcao - listaPreco() 
**  Finalidade - Consultar os dados de Produtos p/ pedidos 
** Programador - Valmor Pereira Flores 
**  Parametros - Nenhum 
**     Retorno - Nenhum 
**        Data - 03/Maio/1995 
** Atualizacao - 29/Maio/1995 
*/ 
Static Function ListaPreco() 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(), cCOR:=SetColor() 
Loca oPROD, oClie, nTECLA, nTELA:=1 
Loca nCODCLI, nCODPRO, cTELA0, aBOX[2], cDESCLI, cDESPRO 
Loca lFLAG:=.F., lALTERAPOS:=.T. 
Loca nOrdem:= IndexOrd(), nArea:= Select() 
Loca GETLIST:={}, lNovoCliente:= .F. 
Loca nCodigo, cDescri, cEndere, cCidade, cEstado, cFone1_, cFax___,; 
     cCompra, cCGCMf_, dDataCd, lAppend:= .T., cCodigo:= "00000000" 
 
/* Variaveis para pedido */ 
Local nPosicao:= 0, nPrecoInicial, nPerDesconto, nPrecoFinal, nQuantidade,; 
      cCliente, aPedido:= {}, lAltera:= .F., lFechaFiles:= .F. 
 
Private CodigoReserva 
 
DBSelectAr( _COD_PEDIDO ) 
IF Used() 
   lFechaFiles:= .F. 
ELSEIF !Used() 
   IF !AbreGrupo( "PEDIDOS" ) 
      Return Nil 
   ENDIF 
   lFechaFiles:= .T. 
ENDIF 
 
SetCursor(0) 
DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX( 02, 01, 12, 76, "Clientes", _COR_BROW_BOX , .T., .F., _COR_BROW_TITULO, .T. ) 
VPBOX( 13, 01, 21, 76, "Display-Clientes", _COR_BROW_BOX , .T., .F., _COR_BROW_TITULO, .F. ) 
aBOX[1]:=BOXSAVE(13,01,21,45) 
aBOX[2]:=BOXSAVE(13,46,21,76) 
SetColor( "15/05" ) 
SetColor( _COR_BROW_LETRA ) 
DevPos(03,02);DevOut("Codigo........:") 
DevPos(04,02);DevOut("Nome..........:") 
DevPos(05,02);DevOut("Endereco......:") 
DevPos(06,02);DevOut("Cidade........:") 
DevPos(07,02);DevOut("Fone(s).......:") 
DevPos(08,02);DevOut("FAX...........:") 
DevPos(09,02);DevOut("Contato.......:") 
DevPos(10,02);DevOut("Transportadora:") 
DevPos(11,02);DevOut("Data..........:") 
DispEnd() 
Ajuda( "["+_SETAS+"]Move [INS]Outro_Cliente [F2][F3]Ordem [TAB]Janela [Nome/Codigo]Pesquisa") 
MENSAGEM("Pressione [TAB] para trocar de janela ou [ESC] para sair...") 
DBSelectAr(_COD_MPRIMA) 
DbSelectAr(_COD_CLIENTE) 
DBLeOrdem() 
DBGoTop() 
SetColor( _COR_BROWSE ) 
oClie:=TBrowseDb(14,02,20,75) 
oClie:AddColumn(TbColumnNew(,{|| StrZero(CLI->CODIGO,4,0)+"�"+; 
                                         CLI->DESCRI + "�"+; 
                                         Tran( CLI->CGCMF_, "@R XX.XXX.XXX/XXXX-XX" ) + IF( Cli->Client=="S", "�JCP ", "�NCP " ) })) 
oClie:AUTOLITE:=.F.; oClie:dehilite() 
oClie:GoTop() 
While .T. 
   IF nTELA=1 
      IF lALTERAPOS 
         DbSelectAr(_COD_CLIENTE) 
         oClie:RefreshAll() 
         While ! oClie:Stabilize() 
         EndDo 
         lAlteraPos:= .F. 
      ENDIF 
      oClie:ColorRect( { oClie:ROWPOS, 1, oClie:ROWPOS, 1 }, { 2, 1 } ) 
      Whil NextKey()=0 .and.! oClie:Stabilize() 
      enddo 
      Janela( 2 ) 
      DispBegin() 
      SetColor( _COR_BROW_LETRA ) 
      DevPos(03,18);DevOut( StrZero( CLI->CODIGO, 4, 0 ) ) 
      DevPos(04,18);DevOut( CLI->DESCRI ) 
      DevPos(05,18);DevOut( CLI->ENDERE ) 
      DevPos(06,18);DevOut( CLI->CIDADE ) 
      DevPos(07,18);DevOut( CLI->FONE1_ + "  " + CLI->Fone2_ + "  " + CLI->Fone3_  + "  " + CLI->Fone4_ ) 
      DevPos(08,18);DevOut( CLI->FAX___ ) 
      DevPos(09,18);DevOut( CLI->COMPRA ) 
      DevPos(10,18);DevOut( StrZero(CLI->TRANSP,3,0) ) 
      DevPos(11,18);DevOut( CLI->DATACD ) 
      DispEnd() 
      SetColor( _COR_BROWSE ) 
   ELSEIF nTELA=2 
      IF lALTERAPOS 
         oClie:Refreshall() 
         WHILE ! oClie:Stabilize() 
         ENDDO 
         DbSelectAr(_COD_MPRIMA) 
         lALTERAPOS:=.F. 
      ENDIF 
   ENDIF 
   nTECLA:=inkey(0) 
   IF nTECLA=K_ESC 
      DBSelectAr( _COD_PEDIDO ) 
      DBSetOrder( 1 ) 
      DBSeek( cCodigo ) 
      IF Alltrim( DESCRI ) == Alltrim( _RESERVADO ) 
         RLock() 
         IF !NetErr() 
            Dele 
         ENDIF 
      ENDIF 
      LimpaMarcas( aPedido ) 
      Aviso( "Limpando registros marcados. Aguarde...", 24 /2 ) 
      DBSelectar( _COD_MPRIMA ) 
      DBSetOrder( 6 ) 
      DBGoTop() 
      DBSeek( "*" ) 
      //While MPr->Marca_ == "*" 
      //    Mensagem( StrZero( Mpr->( Recno() ), 5, 0 ) + " => Limpando..." ) 
      //    MPr->( RLock() ) 
      //    IF !MPr->( NetErr() ) 
      //       Replace MPr->Marca_ WIth " " 
      //    ELSE 
      //       Mensagem( "Nao foi poss�vel desmarcar todos os produtos...", 1 ) 
      //    ENDIF 
      //    MPr->( DBSkip() ) 
      //EndDo 
      Exit 
   ENDIF 
   do Case 
      Case nTecla==K_INS 
           SetCursor( 1 ) 
           cTelaRes:= ScreenSave( 00, 00, 24, 79 ) 
           nOrdemRes:= IndexOrd() 
           IF !lNovoCliente 
              nCodigo:= 0 
              cDescri:= Space( Len( CLI->DESCRI ) ) 
              cEndere:= Space( Len( CLI->ENDERE ) ) 
              cCidade:= Space( Len( CLI->CIDADE ) ) 
              cEstado:= Space( 02 ) 
              cFone1_:= Space( 11 ) 
              cFax___:= Space( 11 ) 
              cCompra:= Space( Len( CLI->COMPRA ) ) 
              cCGCMf_:= Space( 14 ) 
              cInscri:= Space( Len( CLI->INSCRI ) ) 
              cCodCep:= Space( 8 ) 
              dDataCd:= Date() 
              lAppend:= .T. 
           ELSE 
              DBSelectAr( _COD_CLIENTE ) 
              nOrdemRes:= IndexOrd() 
              DBSetOrder( 1 ) 
              IF DBSeek( 0 ) 
                 cDescri:= CLI->DESCRI 
                 cEndere:= CLI->ENDERE 
                 cCidade:= CLI->CIDADE 
                 cEstado:= CLI->ESTADO 
                 cFone1_:= CLI->FONE1_ 
                 cFax___:= CLI->FAX___ 
                 cCompra:= CLI->COMPRA 
                 cCGCMf_:= CLI->CGCMF_ 
                 cInscri:= CLI->INSCRI 
                 cCodCep:= CLI->CODCEP 
                 dDataCd:= Date() 
              ELSE 
                 SetCursor( 0 ) 
                 Loop 
              ENDIF 
              DBSetOrder( nOrdemRes ) 
              oClie:Gotop() 
              oClie:RefreshAll() 
              WHILE !oClie:Stabilize() 
              ENDDO 
              lAppend:= .F. 
           ENDIF 
           Ajuda( "["+_SETAS+"]Move [ESC]Cancela" ) 
           @ 03,18 Say "INTERNO" 
           @ 04,18 Get cDescri When Mensagem( "Digite o nome do cliente." ) 
           @ 05,18 Get cEndere When Mensagem( "Digite o endereco do cliente." ) 
           @ 06,18 Get cCidade When Mensagem( "Digite a cidade do cliente." ) 
           @ 06,60 Say "Estado:" Get cEstado Valid Veruf( @cEstado ) When Mensagem( "Digite a sigla do estado." ) 
           @ 07,02 Say "Cep...........:" Get cCodCep Pict "@R 99.999-999" When Mensagem( "Digite o codigo enderecamento postal." ) 
           @ 08,02 Say "Fone..........:" Get cFone1_ When Mensagem( "Digite o fone para contato." ) 
           @ 08,40 Say "Fax.:" Get cFax___ When Mensagem( "Digite o fax. " ) 
           @ 09,18 Get cCompra When Mensagem( "Digite o nome do(a) comprador(a)." ) 
           @ 10,02 Say "CGCMf.........:" Get cCGCMf_ Pict "@R 99.999.999/9999-99" Valid CGCMF( cCgcMf_ ) When; 
                  Mensagem( "Digite o CGC do cliente:" ) 
           @ 10,40 Say "I.E.:" Get cInscri When Mensagem( "Digite o n� da inscricao estadual." ) 
           @ 11,18 Get dDataCd 
           READ 
           IF LastKey() == K_ESC 
              SetCursor( 0 ) 
              ScreenRest( cTelaRes ) 
              Loop 
           ENDIF 
           IF lAppend 
              DBAppend() 
              RLock() 
              IF !NetErr() 
                 Replace Codigo With nCodigo 
              ENDIF 
              DBUnlock() 
           ENDIF 
           RLock() 
           IF !NetErr() 
              Replace Codigo With nCodigo,; 
                      Descri With cDescri,; 
                      Endere With cEndere,; 
                      Cidade With cCidade,; 
                      Estado With cEstado,; 
                      Compra With cCompra,; 
                      CGCMf_ With cCGCMf_,; 
                      Fone1_ With cFone1_,; 
                      Inscri With cInscri,; 
                      CodCep With cCodCep 
           ENDIF 
           DBUnlock() 
           lNovoCliente:= .T. 
           ScreenRest( cTelaRes ) 
           SetCursor( 0 ) 
           oClie:Gotop() 
           DBSetOrder( 1 ) 
           DBSeek( 0 ) 
           DBSetOrder( nOrdemRes ) 
           oClie:RefreshAll() 
           WHILE !oClie:Stabilize() 
           ENDDO 
      Case nTecla==K_UP         ;oClie:up() 
      Case nTecla==K_DOWN       ;oClie:down() 
      Case nTecla==K_PGUP       ;oClie:pageup() 
      Case nTecla==K_PGDN       ;oClie:pagedown() 
      Case nTecla==K_HOME       ;oClie:gotop() 
      Case nTecla==K_END        ;oClie:gobottom() 
      Case DBPesquisa( nTecla, oClie ) 
      Case nTecla==K_F2         ;DBMudaOrdem( 1, oClie ) 
      Case nTecla==K_F3         ;DBMudaOrdem( 2, oClie ) 
      Case nTecla==K_TAB .OR. nTecla==K_ENTER 
           DBSelectAr( _COD_PEDIDO ) 
           DBSetOrder( 1 ) 
           Tone( 750, 2 ) 
 
           /* Pegar o ultimo codigo */ 
           DBGoBottom() 
 
           cCodigo:= StrZero( Val( Codigo ) + 1, 8, 0 ) 
           CodigoReserva:= cCodigo 
 
           DBAppend() 
           IF !NetErr() 
               Replace CODIGO With cCodigo, DESCRI With _RESERVADO 
           ELSE 
               Mensagem( "Nao foi possivel gravar o registro..." ) 
               Pausa() 
           ENDIF 
           cCodigo2:= cCodigo 
           DBSelectAR( _COD_PEDIDO ) 
           FechaArea() 
           Mensagem( "Reabrindo arquivo de pedidos, aguarde..." ) 
           IF !FDBUseVpb( _COD_PEDIDO, 2 ) 
              Return Nil 
           ENDIF 
           DBSelectAr( _COD_PEDIDO ) 
           DBSetOrder( 1 ) 
           DBGoBottom() 
           DisplayMPR() 
           lAlteraPos:= .T. 
           IF lNovoCliente 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Aguarde, limpando informacoes do cliente.", 24 / 2 ) 
              DBSelectAr( _COD_CLIENTE ) 
              nOrdemRes:= IndexOrd() 
              DBSetOrder( 1 ) 
              IF DBSeek( 0 ) 
                 Tone( 50, 2 ) 
                 Mensagem( "Limpando registro, aguarde..." ) 
                 RLock() 
                 Dele 
                 IF DBSeek( 0 ) 
                    Tone( 20, 1 ) 
                    RLock() 
                    Dele 
                 ENDIF 
                 DBUnlockAll() 
              ENDIF 
              lNovoCliente:= .F. 
              DBSetOrder( nOrdemRes ) 
              ScreenRest( cTelaRes ) 
           ENDIF 
      OtherWise                ;tone(125); tone(300) 
      endcase 
      oClie:Refreshcurrent() 
      oClie:Stabilize() 
  enddo 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
  IF lFechaFiles 
     //DBUnlockAll() 
     FechaArquivos() 
  ENDIF 
  return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � displayMPR 
� Finalidade  � Display de Materia-Prima 
� Parametros  � Nenhum 
� Retorno     � Nenhum 
� Programador � Valmor Pereira Flores 
� Data        � 05/Fevereiro/1996 
��������������� 
*/ 
Static Function DisplayMPR() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ), cTelaRes, cCorRes 
   LOCAL lAlteraPos:= .T., nTela:= 2, aPedido:= {}, cBusca:= " ",; 
         lQuantidade:= .F. 
   DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo( "Cliente:" + Cli->Descri ) 
   VPBox( 02, 01, 12, 76, "Produtos", _COR_BROW_BOX , .T., .F., _COR_BROW_TITULO, .T. ) 
   VPBox( 13, 01, 21, 76, "Display-Produtos", _COR_BROW_BOX , .T., .F., _COR_BROW_TITULO, .F. ) 
   DevPos( 03, 02 ); DevOut( "Numero........:" ) 
   DevPos( 04, 02 ); DevOut( "Codigo Fabrica:" ) 
   DevPos( 05, 02 ); DevOut( "Descricao.....:" ) 
   DevPos( 06, 02 ); DevOut( "Fornecedor....:" ) 
   DevPos( 07, 02 ); DevOut( "% IPI.........:" ) 
   DevPos( 08, 02 ); DevOut( "% ICM.........:" ) 
   DevPos( 09, 02 ); DevOut( "Saldo.........:" ) 
   DevPos( 10, 02 ); DevOut( "Preco.........:" ) 
   DevPos( 11, 02 ); DevOut( "Data..........:" ) 
   Janela( 3 ) 
   DispEnd() 
   Ajuda( "["+_SETAS+"]Move [Tab] Cotacao [F2][F3][F4]Ordem [A..Z]Pesquisa [ESC]Cancela" ) 
   Mensagem( "Pressione [ENTER] p/ selecionar o produto ou [TAB] para ver a  Cotacao." ) 
 
   DbSelectAr(_COD_MPRIMA) 
   DBLeOrdem() 
 
   DBSelectAr( _COD_MPRIMA ) 
   SetColor( _COR_BROWSE ) 
   oPROD:=TBrowseDb(14,02,20,75) 
   oPROD:AddColumn( TbColumnNew(,{|| MPR->MARCA_ + "�"+ Tran( MPR->Indice, "@R XXX-XXXX" ) + "�" + MPR->CodFab + "�" + LEFT( MPR->Descri, 35 ) + "�" + MPR->ORIGEM + "�" + Tran(MPR->PRECOV,"@E **,***.***") })) 
   oPROD:AUTOLITE:=.F. 
   oPROD:dehilite() 
   While .T. 
      oPROD:colorrect({oPROD:ROWPOS,1,oPROD:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oPROD:stabilize() 
      enddo 
      SetColor( _COR_BROW_LETRA ) 
      DispBegin() 
      cCorRes:= SetColor() 
 
      SetColor( cCorRes ) 
      /* relacao de produtos no pedido */ 
      cCorRes:= SetColor() 
      VPBox( 06, 35, 12, 76, "Relacao de Produtos do seu pedido", "15/00",.F.,.F. ) 
      SetColor( "15/00" ) 
      FOR nCt:= 1 TO Len( aPedido ) 
          IF AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) == nCt 
             SetColor( "15/04" ) 
          ELSE 
             SetColor( "15/00" ) 
          ENDIF 
          @ nCt + 6, 36 Say Tran( StrZero( aPedido[ nCt ][ 11 ], 7, 0 ), "@R 999-9999" ) + ; 
                      " => " + aPedido[ nCt ][ 1 ] + " � Qtd:" +; 
                      Tran( aPedido[ nCt ][ 6 ], "@E 9,999.999" ) 
          IF nCt >= 5 
             EXIT 
          ENDIF 
      NEXT 
      IF mpr->Marca_ == "*" 
         IF AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) > 0 
            SetColor( "15/00" ) 
            @ 12,36 SAY "����������������������������������������" 
         ELSE 
            SetColor( "15/04" ) 
            @ 12,36 SAY " ESTE PRODUTO NAO FOI MARCADO POR VOCE  " 
         ENDIF 
      ENDIF 
 
      SetColor( cCorRes ) 
 
      DevPos(03,18); DevOut( MPR->INDICE, "@R 999-9999" ) 
      DevPos(04,18); DevOut( MPR->CODFAB ) 
      DevPos(05,18); DevOut( MPR->DESCRI ) 
      DevPos(06,18); DevOut( StrZero( MPR->CODFOR, 4, 0 ) ) 
      DevPos(07,18); DevOut( StrZero( MPR->IPI___, 6, 2 ) ) 
      DevPos(08,18); DevOut( StrZero( MPR->ICM___, 6, 2 ) ) 
      DevPos(09,18); DevOut(Tran(MPR->SALDO_,"@E ****,***.***")) 
      DevPos(10,18); DevOut(Tran(MPR->PRECOV,"@E ****,***.***")) 
      DevPos(11,18); DevOut( MPR->DATA__ ) 
      DispEnd() 
      SetColor( _COR_BROWSE ) 
      IF ( nTECLA:=inkey(0) ) == K_ESC 
         IF ! ( PED->CODCLI == CLI->CODIGO ) .AND. !Empty( aPedido ) .AND. SWSet( 5000 ) 
            cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
            Aviso( "Atencao! Este pedido nao foi gravado. [ENTER]Grava [C]Cancela.", 24 / 2 ) 
            WHILE .T. 
               nTeclaRes:= Inkey(0) 
               IF nTeclaRes == K_ENTER 
                  Keyboard "G" 
                  Cotacao( aPedido ) 
                  //Cli->( DBGoTop() ) 
                  Inkey() 
                  Keyboard Chr( K_ESC ) 
                  Exit 
               ELSEIF Chr( nTeclaRes ) $ "Cc" 
                  Exit 
               ENDIF 
            ENDDO 
            ScreenRest( cTelaRes ) 
         ENDIF 
         LimpaMarcas( aPedido ) 
         LimpaArquivo() 
         Exit 
      ENDIF 
      do case 
         case nTECLA==K_UP         ;oProd:up() 
         case nTECLA==K_DOWN       ;oProd:down() 
         case nTECLA==K_PGUP       ;oProd:pageup() 
         case nTECLA==K_PGDN       ;oProd:pagedown() 
         case nTECLA==K_HOME       ;oProd:gotop() 
         case nTECLA==K_END        ;oProd:gobottom() 
         case Chr( nTecla ) $ " 0123456789ABCDEFGHIJKLMNOPQRSTUVXYZ" 
              IF nTecla >= 48 .AND. nTecla <= 57 
                 IF !IndexOrd() == 4 
                    DBSetOrder( 4 ) 
                    Keyboard Chr( LastKey() ) 
                 ENDIF 
                 DBPesquisa( nTecla, oProd, @cBusca ) 
                 IF !IndexOrd() == 4 
                    DBMudaOrdem( 4, oProd ) 
                 ENDIF 
                 IF IndexOrd() == 4 
                    TONE( 200, 1 ) 
                    IF AllTrim( cBusca ) == ALLTRIM( MPR->CODFAB ) 
                       lQuantidade:= .T. 
 
                       IF ( nPosicao:= AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) ) > 0 
                          nQuantidade:= aPedido[ nPosicao ][ 6 ] 
                          aPedido[ nPosicao ][ 6 ]:= aPedido[ nPosicao ][ 6 ] + 1 
                       ELSE 
                          nQuantidade:= 0 
                       ENDIF 
 
                       nQuantidade:= nQuantidade + 1 
                       KEYBOARD CHR( K_ENTER ) + CHR( K_ENTER ) 
                    ENDIF 
                 ENDIF 
                 cBusca:= "" 
              ELSEIF nTecla >= 65 .AND. nTecla <= 122 
                 IF !IndexOrd() == 2 
                    DBSetOrder( 2 ) 
                    Keyboard Chr( LastKey() ) 
                 ENDIF 
                 DBPesquisa( nTecla, oProd ) 
                 IF !IndexOrd() == 4 
                    DBMudaOrdem( 2, oProd ) 
                 ENDIF 
              ENDIF 
         case nTecla=K_F2; DBMudaOrdem( 1, oProd ) 
         case nTecla=K_F3; DBMudaOrdem( 4, oProd ) 
         case nTecla=K_F4; DBMudaOrdem( 2, oProd ) 
         case nTECLA=K_TAB 
              IF !Empty( aPedido ) 
                 Cotacao( aPedido ) 
                 //Cli->( DBGoTop() ) 
              ELSE 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 Tone( 300, 3 ) 
                 Aviso( "Selecione os produtos p/ poder ver a  Cotacao.", 24 / 2 ) 
                 Mensagem( "Pressione ENTER para continuar..." ) 
                 Pausa() 
                 ScreenRest( cTelaRes ) 
                 cTelaRes:= Nil 
              ENDIF 
         case nTECLA=K_ENTER 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 08, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              SetColor( _COR_GET_EDICAO ) 
              IF ! MPR->Marca_ == Space( 1 ) 
                 nPosicao:= AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) 
                 IF PedidoProdutos== _TBI_MAIS_VEZES 
                    nPosicao:= 0 
                 ENDIF 
                 IF nPosicao == 0 
                    nPrecoInicial:= MPr->PrecoV 
                    nPerDesconto:=  MPr->PercDc 
                    nPrecoFinal:= 0.00 
                    IF lQuantidade 
                       nQuantidade:= nQuantidade 
                       lQuantidade:= .F. 
                    ELSE 
                       nQuantidade:= 0 
                    ENDIF 
                    cOrigem:= MPr->Origem + Space( 11 ) 
                    lAltera:= .F. 
                 ELSE 
                    nPrecoInicial:= aPedido[ nPosicao ][ 3 ] 
                    nPerDesconto:= aPedido[ nPosicao ][ 4 ] 
                    nPrecoFinal:= aPedido[ nPosicao ][ 5 ] 
                    nQuantidade:= aPedido[ nPosicao ][ 6 ] 
                    cOrigem:= aPedido[ nPosicao ][ 9 ] 
                    lAltera:= .T. 
                 ENDIF 
              ELSE 
                 nPrecoInicial:= MPr->PrecoV 
                 nPerDesconto:=  MPr->PercDc 
                 nPrecoFinal:= nPrecoInicial 
                 IF lQuantidade 
                    nQuantidade:= nQuantidade 
                    lQuantidade:= .F. 
                 ELSE 
                    nQuantidade:= 0 
                 ENDIF 
                 cOrigem:= MPr->Origem + Space( 11 ) 
                 lAltera:= .F. 
              ENDIF 
              SetCursor(1) 
              @ 10,12 Say "Produto....: [" + MPR->CodFab + "]" 
              @ 11,12 Say "Descri��o..: [" + Alltrim( MPR->Descri ) + "]" 
              @ 12,12 Say "Fabricante.: [" + cOrigem + "]" 
              @ 13,12 Say "Pre�o......: [" + Tran( nPrecoInicial, "@E 999,999,999.999" ) + "]" 
              VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              DisplayIPI( nPrecoFinal ) 
              Read 
              IF LastKey() <> K_ESC 
                 IF lAltera 
                    aPedido[ nPosicao ][ 3 ]:= nPrecoInicial 
                    aPedido[ nPosicao ][ 4 ]:= nPerDesconto 
                    aPedido[ nPosicao ][ 5 ]:= nPrecoFinal 
                    aPedido[ nPosicao ][ 6 ]:= nQuantidade 
                    aPedido[ nPosicao ][ 9 ]:= cOrigem 
                    lAltera:= .F. 
                 ELSE 
                    RLock() 
                    IF !NetErr() 
                       IF !( MPR->Marca_ == "*" ) 
                          Replace MPR->Marca_ With "*" 
                       ENDIF 
                       nPosicao:= 0 
                       IF ( nPosicao:= ( AScan( aPedido, {|x| x[11] == Val( MPr->Indice ) .AND. ! ( x[11] == 0 ) } ) ) ) <= 0 .OR.; 
                          PedidoProdutos== _TBI_MAIS_VEZES 
                          AAdd( aPedido, { MPR->CodFab, ; 
                                           MPR->Descri, ; 
                                           nPrecoInicial, ; 
                                           nPerDesconto, ; 
                                           nPrecoFinal, ; 
                                           nQuantidade, ; 
                                           MPR->Unidad, ; 
                                           MPr->IPI___, ; 
                                           MPR->ORIGEM + "           ",; 
                                           "Sim",; 
                                           Val( MPR->INDICE ) } ) 
                       ELSEIF nPosicao > 0 
                          aPedido[ nPosicao ][ 3 ]:= nPrecoInicial 
                          aPedido[ nPosicao ][ 4 ]:= nPerDesconto 
                          aPedido[ nPosicao ][ 5 ]:= nPrecoFinal 
                          aPedido[ nPosicao ][ 6 ]:= nQuantidade 
                          aPedido[ nPosicao ][ 9 ]:= cOrigem 
                       ENDIF 
                    ENDIF 
                    DBUnlockAll() 
                 ENDIF 
                 DBUnlock() 
              ENDIF 
              ScreenRest( cTelaReserva ) 
         case nTECLA=K_INS 
              cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 08, 10, 20, 70, "Dados do Produto Selecionado", _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              SetColor( _COR_GET_EDICAO ) 
              nPrecoInicial:= 0 
              nPerDesconto:=  0 
              nPrecoFinal:= 0.00 
              nQuantidade:= 0 
              cOrigem:= Space( 14 ) 
              cCodFab:= Space( Len( MPR->CodFab ) ) 
              cDescricao:= Space( _ESP_DESCRICAO ) 
              cUnidade:= Space( 2 ) 
              nPerIpi:= 0 
              lAltera:= .F. 
              SetCursor(1) 
              @ 10,12 Say "Produto....:" Get cCodFab Pict "@!" 
              @ 11,12 Say "Descri��o..:" Get cDescricao Pict "@!" 
              @ 12,12 Say "Fabricante.:" Get cOrigem Pict "XXXXXXXXXXXXXX" 
              @ 13,12 Say "Pre�o......:" Get nPrecoInicial Pict "@E 999,999,999.999" 
              @ 14,12 Say "% Desconto.:" Get nPerDesconto  Pict "@E 999.99"          Valid {|oGet| CalculaDesconto( oGet, GetList, 4, 6 ) } 
              @ 15,12 Say "Pre�o Final:" Get nPrecoFinal   Pict "@E 999,999,999.999" 
              VPBox( 18, 10, 20, 70,, _COR_GET_BOX, .T., .F., _COR_GET_TITULO ) 
              @ 19,12 Say "Quantidade.:" Get nQuantidade   Pict "@E 999,999.999" 
              DisplayIPI( nPrecoFinal ) 
              Read 
              IF LastKey() <> K_ESC 
                 IF !NetErr() 
                     AAdd( aPedido, { cCodFab, ; 
                                      cDescricao, ; 
                                      nPrecoInicial, ; 
                                      nPerDesconto, ; 
                                      nPrecoFinal, ; 
                                      nQuantidade, ; 
                                      cUnidade, ; 
                                      nPerIpi, ; 
                                      cOrigem,; 
                                      "Sim",; 
                                      0 } ) 
                 ENDIF 
              ENDIF 
              ScreenRest( cTelaReserva ) 
         otherwise                ;tone(125); tone(300) 
         endcase 
         oProd:Refreshcurrent() 
         oProd:Stabilize() 
     enddo 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return( .T. ) 
 
/* 
* Modulo       - CalculoDesconto 
* Finalidade   - Calcular o desconto. 
* Programador  - Valmor Pereira Flores 
* Data         - 26/Outubro/1995 
* Atualizacao  - 
*/ 
/* 
Static Function CalculaDesconto( oGet, ListaGet, nPosInicial, nPosFinal ) 
   /* Calcula o desconto */ 
   ListaGet[ nPosFinal ]:VarPut( ( ListaGet[ nPosInicial ]:VarGet() ) - ( ( Val( oGet:Buffer ) * ListaGet[ nPosInicial ]:VarGet() ) / 100 ) ) 
   /* Apresenta o resultado */ 
   ListaGet[ nPosFinal ]:Display() 
   DisplayIPI( ListaGet[ nPosFinal ]:VarGet() ) 
   Return( .T. ) 
*/ 
 
/* 
* Modulo       - LimpaMarcas 
* Finalidade   - Limpar as marcas dos produtos 
* Programador  - Valmor Pereira Flores 
* Data         - 26/Outubro/1995 
* Atualizacao  - 
*/ 
Static Function LimpaMarcas( aPedidos ) 
Local nCt, nOrdem:= Mpr->( IndexOrd() ), aPrBloqueados:= {}, nRegistro:= MPr->( Recno() ),; 
      nArea:= Select() 
IF !Empty( aPedidos ) 
   Mensagem( "Aguarde, limpando os produtos marcados..." ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   For nCt:= 1 To Len( aPedidos ) 
       DBSeek( PAD( StrZero( aPedidos[ nCt ][ 11 ], 7, 0 ), 12 ) ) 
       IF !Eof() 
          IF RLock() 
             Replace MPr->Marca_ With " " 
          ELSE 
             Mensagem("Imposs�vel desmarcar o produto: " + PAD( StrZero( aPedidos[ nCt ][ 11 ], 7, 0 ), 12 ) + "..." ) 
             AAdd( aPrBloqueados, PAD( StrZero( aPedidos[ nCt ][ 11 ], 7, 0 ), 12 ) ) 
          ENDIF 
          DBUnlockAll() 
       ENDIF 
   Next 
   MPR->( DBSetOrder( nOrdem ) ) 
   MPR->( DBGoto( nRegistro ) ) 
   DBSelectAr( nArea ) 
ENDIF 
IF !Empty( aPrBloqueados ) 
   Mensagem( ">>>" + STRZero( Len( aPrBloquados ), 2, 0 ) + " do(s) " + STRZero( Len( aPedidos ), 2, 0 ) + " produto(s) n�o foram desmarcado(s)..." ) 
   Pausa() 
ENDIF 
/* Zera a Matriz de Produtos */ 
aPedidos:= {} 
Return Nil 
 
 
//Static Function DisplayIPI( nPrecoFinal ) 
//Local nValorIpi:= ( ( nPrecoFinal * MPr->IPI___ ) / 100 ) 
//   @ 16,12 Say "% IPI......: [" + Tran( MPr->IPI___, "@E 999.99" ) + "]" 
//   @ 17,12 Say "Valor IPI..: [" + Tran( nValorIpi, "@E 999,999.99" ) + "]" 
//   Return nValorIpi 
 
 
/* 
* Modulo      - CalculoGeral 
* Finalidade  - Apresentar no rodap� o calculo total do pedido 
* Programador - Valmor Pereira Flores 
* Data        - 26/Outubro/1995 
* Atualizacao - 
*/ 
/* 
Static Function CalculoGeral( aPedido ) 
Local cCor:= SetColor() 
Local nSubTotal:= 0, nIPI:= 0, nTotal:= 0 
   DispBegin() 
   SetColor( "W+/G" ) 
   Scroll( 21, 1, 22, 78 ) 
   For nCt:= 1 To Len( aPedido ) 
       IF aPedido[ nCt ][ 10 ] == "Sim" 
          nSubTotal+= aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] 
          nIPI+= ( ( aPedido[ nCt ][ 5 ] * aPedido[ nCt ][ 6 ] ) * aPedido[ nCt ][ 8 ] ) / 100 
       ENDIF 
   Next 
   nTotal:= nSubTotal + nIPI 
   @ 21, 01 Say "Sub-Total..: " + Tran( nSubTotal, "@E 999,999,999,999.99" ) 
   @ 22, 01 Say "Valor IPI..: " + Tran( nIPI,      "@E 999,999,999,999.99" ) 
   @ 22, 47 Say "Total Geral: " + Tran( nTotal,    "@E 999,999,999,999.99" ) 
   SetColor( cCor ) 
   DispEnd() 
Return Nil 
*/ 
 
/***** 
�������������Ŀ 
� Funcao      � LIMPAARQUIVO 
� Finalidade  � Limpar marcas do arquivpo de produtos 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 05/Fevereiro/1996 
��������������� 
*/ 
Static Function LimpaArquivo() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ),; 
         nArea:= Select(), nOrdem:= IndexOrd(), nRegistro 
   Aviso( "Limpando registros marcados. Aguarde...", 24 /2 ) 
   DBSelectar( _COD_MPRIMA ) 
   nRegistro:= Recno() 
   DBSetOrder( 6 ) 
   DBGoTop() 
   DBSeek( "*" ) 
   WHILE MPr->Marca_ == "*" 
       Mensagem( StrZero( Mpr->( Recno() ), 5, 0 ) + " => Limpando..." ) 
       RLock() 
       IF !NetErr() 
          Replace MPr->Marca_ WIth " " 
       ELSE 
          Mensagem( "Nao foi poss�vel desmarcar todos os produtos...", 1 ) 
       ENDIF 
       DBUnlockAll() 
       DBSkip() 
   ENDDO 
   DBGoTo( nRegistro ) 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
  Static Function Janela( nJanela ) 
  Local cCor:= SetColor() 
  SetColor( "15/12" ) 
  Scroll( 03, 70, 05, 75 ) 
  @ 04,72 Say StrZero( nJanela, 2, 0 ) 
  SetColor( cCor ) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
  Static Function BuscaTransport( nCodigo ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
 
  DBSelectAr( _COD_TRANSPORTE ) 
  DBSetOrder( 1 ) 
  IF !DBSeek( nCodigo ) 
     vpbox(11,39,20,77,"Selecao de Transportadora",COR[24],,,COR[23]) 
     dbgotop() 
     setcursor(0) 
     setcolor(COR[25]+","+COR[22]+",,,"+COR[17]) 
     Mensagem("Pressione [ENTER] para selecionar.") 
     ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Busca") 
     oTB:=tbrowsedb(12,40,19,76) 
     oTB:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" -> "+DESCRI + Space( 10 )})) 
     oTB:AUTOLITE:=.f. 
     oTB:dehilite() 
     whil .t. 
         oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTB:stabilize() 
         enddo 
         TECLA:=inkey(0) 
         if TECLA=K_ESC 
            exit 
         endif 
         do case 
            case TECLA==K_UP         ;oTB:up() 
            case TECLA==K_LEFT       ;oTB:up() 
            case TECLA==K_RIGHT      ;oTB:down() 
            case TECLA==K_DOWN       ;oTB:down() 
            case TECLA==K_PGUP       ;oTB:pageup() 
            case TECLA==K_PGDN       ;oTB:pagedown() 
            case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
            case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
            case TECLA==K_ENTER .OR. TECLA=K_TAB 
                 nCodigo:= CODIGO 
                 exit 
            case Chr( TECLA ) $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ " 
                 DBSetOrder( 2 ) 
                 oTb:GoTop() 
                 DBSeek( Chr( Tecla ), .T. ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
            otherwise                ;tone(125); tone(300) 
         endcase 
         oTB:refreshcurrent() 
         oTB:stabilize() 
     enddo 
     setcursor(nCURSOR) 
   endif 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
 
 
   FUNCTION DisplayNumero( nNumero, cTitulo ) 
   Local cCor:= SetColor(), nCursor:= SetCursor() 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   VPBOX( 02, 20, 09, 77, " Display " + cTitulo, "15/01" ) 
   SetColor( "14/01" ) 
   nCol:= 67 
   nPosicao:= 18 
   cNumero:= Tran( nNumero, "@R ***************.**" ) 
   FOR nCt:= 1 TO 21 
       DisplayNo( 04,nCol, SubStr( cNumero, nPosicao--, 1 ) ) 
       nCol:= nCol - 6 
   NEXT 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return .T. 
 
 
   FUNCTION DisplayNo( nLin, nCol, cNumero ) 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   /*aNumero:={ "       �� �������� �������� ��    �� �������� �������� �������� �������� �������� ��������",; 
                "       ��       ��       �� ��    �� ��       ��             �� ��    �� ��    �� �   ����",; 
                "       �� �������� �������� �������� �������� ��������       �� �������� �������� � ���� �",; 
                "       �� ��             ��       ��       �� ��    ��       �� ��    ��       �� ����   �",; 
                "       �� �������� ��������       �� �������� ��������       �� �������� �������� ��������" } 
    */ 
    aNumero:={ "    �� ����� ����� �   � ����� ����� ����� ����� ����� �����",; 
               "     �     �     � �   � �     �         � �   � �   � �   �",; 
               "     � �����  ���� ����� ����� �����     � ����� ����� �   �",; 
               "     � ����� �����     � ����� �����     � ����� ����� �����" } 
 
   IF cNumero == "*" 
      Return .T. 
   ENDIF 
   IF cNumero == "." 
      @ nLin+=4, nCol Say "  ��  " 
      Return .T. 
   ENDIF 
   nNumero:= VAL( cNumero ) 
   IF nNumero == 0 
      FOR nCt:= 1 TO 4 
          @ nLin++, nCol Say Right( aNumero[ nCt ], 6 ) 
      NEXT 
   ELSE 
      FOR nCt:= 1 TO 4 
          @ nLin++, nCol Say SubStr( aNumero[ nCt ], ( ( nNumero - 1 ) * 6 ) + 1, 6 ) 
      NEXT 
   ENDIF 
   Return .T. 
 
