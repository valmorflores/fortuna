// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC35100 
� Finalidade  � Ajuste de Precos de Venda 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
#ifdef HARBOUR
function vpc35100()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), oTab,; 
      cTela2, dData1:= dData2:= Date(), cTela0 
Local cComis_:= Space( 1 ) 
Local bBlock
Local dData
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
 
/* Ajuste arquivo */ 
dbSelectAr( _COD_MPRIMA ) 
dbSetOrder( 2 ) 
dbGoTop() 
 
/* Ajuste de tela */ 
SetCursor(1) 
VPBOX( 00, 00, 22, 79," TABELA DE PRECOS PADRAO ", _COR_BROW_BOX, .F., .F. ) 
SetColor( _COR_BROWSE ) 
Mensagem( "Pressione [ENTER] mudar preco de compra." ) 
ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta [F6]Precos de Compra.") 
 
DBLeOrdem() 
 
/*------------------------------------------------------------------------------ 
BROWSE 
--------------------------------------------------------------------------------*/
PXF->( dbSetOrder( 1 ) )

bBlock:= {|| Tran( INDICE, "@R 9999999" ) + " " + CODFAB + " " + PAD( DESCRI, 33 ) + " " + ORIGEM + Tran( MPR->PRECOV, "@e 999999.99" ) + " " + DTOC( DataPrecoCompra() ) + SPACE( 30 ) } 
nTecla:= Nil 
 
WHILE !( nTecla==K_ESC )   

    //// Tabela de precos
    oTab:= Browse( 00, 00, 22, 79, "Codigo  Cod.Fabrica   Descricao                         Fab    Preco  Ult.Alt.", bBlock, "LISTA DE PRECOS", @nTecla, .F. )
 
    DO CASE 
       case nTecla == K_F6
           ProCompl( K_F6 )

       case nTecla == K_ENTER
 
           /* Salva a tela */ 
           cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
           SetCursor( 1 ) 
 
           /* Formata a variavel */ 
           IF !BuscaPrecoCompra()
              IF SWAlerta( "Falha na localizacao de preco.;" + "Verifique o cadastro do produto " + trim( MPR->INDICE ) + ".", {"Sair", "Continuar"} )==1
                 EXIT
              ENDIF
           ENDIF

           nMargem:= PERCPV 
           nPrecoV:= PRECOV 
           nPercDc:= PERCDC
           dData:= DATE()
           dUltima:= PXF->DATA__
           nPrecoCompra:= PxF->Valor_

           /* Display tela */ 
           VPBox( 06, 04, 20, 75, " AJUSTE DE PRECOS ", _COR_GET_BOX ) 
           SetColor( _COR_GET_EDICAO )
 
           /* Edicao */
           FOR->( DBSetOrder( 1 ) )
           IF FOR->( DBSeek( MPR->CODFOR ) )
              @ 07,05 Say " Fornecedor.: [" + STRZERO( MPR->CODFOR, 6, 0 ) + "]"
              @ 08,05 Say " Nome.......: [" + FOR->DESCRI + "]"
              @ 09,05 Say " Fone.......: [" + FOR->FONE1_ + "]       Localizacao Interna: [" + STRZERO( PXF->( RECNO() ), 6, 0 ) + "]"
              @ 10,05 Say "----------------------------------------------------------------------"
           ENDIF
           @ 11,05 Say " Cod.Fabrica: [" + CODFAB + "]"
           @ 12,05 Say " Descricao..: [" + LEFT( DESCRI, 50 ) + "]" 
           @ 13,05 Say " Unidade....: [" + UNIDAD + "]" 
           @ 14,05 Say " Pr. Compra.:" Get nPrecoCompra Pict "@E 999,999,999.999" Valid PrecoFinal( @nPrecoCompra, @nMargem, @nPrecov, 2, getList ) 
           @ 15,05 Say " Margem.....:" Get nMargem Pict "@E 999.999" Valid PrecoFinal( @nPrecoCompra, @nMargem, @nPrecov, 1, getList ) 
           @ 16,05 Say " Pr. Venda..:" Get nPrecoV Pict "@E 999,999,999.999" Valid PrecoFinal( @nPrecoCompra, @nMargem, @nPrecov, 3, getList ) 
           @ 17,05 Say " % Desconto.:" Get nPercDC Pict "@E 999.999"
           @ 18,05 Say " Ult.Atualiz: [" + DTOC( dUltima ) + "]"
           @ 19,05 Say " Atualizacao:" Get dData
           READ 
 
           cCodigo:= MPR->CODIGO 
           nCodFor:= MPR->CODFOR 
 
           /* Gravacao */ 
           IF ! LastKey() == K_ESC 
              IF netrlock() 
                 Replace Precov With nPrecov,; 
                         PercPv With nMargem,; 
                         PercDc With nPercDc 
 
              ENDIF 
              IF PXF->( netrlock(5) ) 
                 IF PXF->CPROD_ <> cCodigo 
                    PXF->( dbAppend() ) 
                 ENDIF 
                 Replace PXF->CPROD_ With cCodigo,;
                         PXF->PVELHO With PXF->VALOR_,;
                         PXF->VALOR_ With nPrecoCompra,;
                         PXF->CODFOR With nCodFor,;
                         PXF->DATA__ With dData
                 PXF->( dbunlock() ) 
              ENDIF
           ENDIF 
           DBUnlockAll() 
 
           /* Restaura situacao */ 
           ScreenRest( cTelaRes ) 
           SetColor( _COR_BROWSE ) 
           SetCursor( 0 ) 
 
      case DBPesquisa( nTecla, oTab ) 
      case nTecla == K_F2; DBMudaOrdem( 1, oTab ) 
      case nTecla == K_F3; DBMudaOrdem( 2, oTab ) 
      case nTecla == K_F4; DBMudaOrdem( 4, oTab ) 
   endcase 
ENDDO 
dbunlockall() 
FechaArquivos() 
screenrest(cTELA) 
setcolor(cCOR) 
setcursor(nCURSOR) 
return nil 

Function DataPrecoCompra()
   IF BuscaPrecoCompra()
      Return PXF->DATA__
   ELSE
      Return CTOD("")
   ENDIF

Function BuscaPrecoCompra()
   PxF->( dbSetOrder( 1 ) ) 
   // Localizou o produto na tabela de preco de compra?
   IF PxF->( DBSeek( MPR->INDICE ) )
      WHILE !PXF->( EOF() ) .AND. PXF->CPROD_ == MPR->INDICE
            IF PXF->CODFOR == MPR->CODFOR
               Return .T.
            ENDIF
            PXF->( DBSkip() )
      ENDDO
   ENDIF
   // Se fornecedor estiver diferente ou for EOF, busca
   // Cria o fornecedor na lista de preco com preco 0
   IF PXF->CODFOR == MPR->CODFOR
      PXF->( DBAppend() )
      IF PXF->( netrlock() )
         Replace PXF->CPROD_ With MPR->INDICE
         Replace PXF->CODFOR With MPR->CODFOR
         PXF->( DBUnlock() )
         Return .T.
      ELSE
         Return .F.
      ENDIF
   ELSE
      Return .T.
   ENDIF


