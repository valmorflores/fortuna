// ## CL2HB.EXE - Converted
/* 
* Modulo      - VPC660000
* Descricao   - PESQUISAS NO Cadastro de Notas Fiscais 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch"

#ifdef HARBOUR
function vpc66000()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
loca nOPCAO:=0 
VPBox( 06, 34, 20, 76 )
whil .t. 
   mensagem("") 
   AAdd(MENULIST,swmenunew( 07, 35, " 1 Pre�os Por Produto x Cliente         ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 08, 35, " 2 Vendas Por Produto                   ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 09, 35, " 3 Notas Por Cliente                    ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 10, 35, " 4 Quantidade de Vendas de Cada Produto ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 11, 35, " 5 Notas de Venda Emitidas no Periodo   ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 12, 35, " 6 Cupons Fiscais Por Cliente           ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 13, 35, " 7 Cupons Fiscais Emitidos Por Periodo  ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 14, 35, " 8 Lucratividade (Cupons x Preco Compra)", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 15, 35, " 9 Produtos x Cupons Fiscais            ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 16, 35, " A Lucratividade (Notas x Preco Compra) ", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 17, 35, " B Preco medio de venda x produtos x cup", 2, COR[11], "",,,COR[6],.T.)) 
   AAdd(MENULIST,swmenunew( 18, 35, " C Vendas x Estoque (Cupons Fiscais)    ", 2, COR[11], "",,,COR[6],.T.))
   AAdd(MENULIST,swmenunew( 19, 35, " 0 Retorna                              ", 2, COR[11], "Retorna ao menu anterior.",,,COR[6],.T.))
   swMenu( MenuList, @nOPCAO ); MenuList:= {} 
   do case 
      case nOPCAO=0 .or. nOPCAO=13
           EXIT 
      case nOPCAO=1; NFBusca(1) 
           //; SetOpcao( {}, 0 ) 
      case nOpcao=2; NFProdPer() 
           //; SetOpcao( {}, 0 ) 
      case nOpcao=3; NFCliente() 
           //; SetOpcao( {}, 0 ) 
      case nOpcao=4; NFProdutos() 
           //; SetOpcao( {}, 0 ) 
      case nOpcao=5; NFPeriodo() 
           //; SetOpcao( {}, 0 ) 
      case nOpcao=6; CFCliente() 
      case nOpcao=7; CFPeriodo() 
      case nOpcao=8 
           Lucratividade() 
      case nOpcao=9 
           ProdxCupom() 
      case nOpcao=10 
           LucroNotas()
      case nOpcao=11
           PrecoMedio()
      case nOpcao=12
           VendEstoq()
   endcase 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
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
FUNCTION ProdxCupom() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cCodigo:= "0000", cGrupo_:= "000", cCorRes 
Local aMatriz:= {}, aMatrizLimpa:= {}, lLoop 
Local dPerIni:= CTOD( "01/"+right(dtoc(date()),5)), dPerFim:= Date() 
Local nPrecoMedio:= 0, nSomaTotal:= 0, nSomaQuant:= 0 
Local nLinha:= 8 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo(" Produto x Cupons ") 
 
   VPBox( 01, 0, 22, 79 ) 
 
   @ 02,02 Say "��������������������������������������������������������������������������Ŀ" 
   @ 03,02 Say "� Periodo: [dd/mm/aa] Ate [dd/mm/aa]                                       �" 
   @ 04,02 Say "��������������������������������������������������������������������������Ĵ" 
   @ 05,02 Say "� Produto: [000]-[0000]  �                                                 �" 
   @ 06,02 Say "����������������������������������������������������������������������������" 
 
   WHILE LastKey() <> K_ESC 
 
      DBSelectAr( _COD_MPRIMA ) 
      ASize( aMatriz, 1 ) 
      aMatriz:= 0 
      aMatriz:= { } 
      lLoop:= .F. 
 
      @ 03,13 Get dPerIni When; 
              Mensagem( "Digite o periodo inicial." ) 
 
      @ 03,28 GeT dPerFim When Mensagem( "Digite o periodo final." ) 
 
      @ 05,13 Get cGrupo_ Pict "999" Valid VerGrupo2( cGrupo_, @cCodigo ) When; 
               Mensagem( "Digite o grupo do produto." ) 
 
      @ 05,19 Get cCodigo Pict "9999" Valid VerCodigo2( @cCodigo, GetList ) When; 
               Mensagem("Digite o c�digo do produto.") 
      READ 
 
      IF LastKey() == K_ESC 
         DBUnlockAll() 
         FechaArquivos() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
 
      DBSelectAr( _COD_CUPOM ) 
      DBSetOrder( 1 ) 
 
      DBSelectAr( _COD_CUPOMAUX ) 
      DBSetOrder( 3 ) 
      Set Relation To CODNF_ Into CUP 
 
      nSomaTotal:= 0 
      nSomaQuant:= 0 
      nPrecoMedio:= 0 
      DBSeek( cGrupo_ + cCodigo + Spac( 5 ) ) 
      WHILE Alltrim( CodRed ) == Alltrim( cGrupo_ + cCodigo ) 
           Mensagem( "Verificando Cupom Fiscal n� " + StrZero( CODNF_, 6, 0 ) + ", aguarde..." ) 
           IF CUP->DataEm >= dPerIni .AND. CUP->DataEm <= dPerFim .AND. CUP->NFNULA==" " 
              nSomaTotal+= ( PRECOV * QUANT_ ) 
              nSomaQuant+= QUANT_ 
              AAdd( aMatriz, { CUP->DATAEM, VAL( SUBSTR( STR( CODNF_, 9 ), 4 ) ), CUP->CDESCR, QUANT_, PRECOV, UNIDAD } ) 
           ENDIF 
           DBSkip() 
      ENDDO 
 
      nPrecoMedio:= nSomaTotal / nSomaQuant 
      nOpcao:= 1 
      @ 07,05 Prompt " 1> Tela       " 
      @ 07,26 Prompt " 2> Impressora " 
      menu to nOpcao 
      IF Len( aMatriz ) <> 0 
         DO CASE 
            CASE nOpcao == 1 
                 nLinha:= 8 
                 @ 07, 02 Say "�Data�����N.Fisc�Cliente������������������������������Quantidad�Valor�����Ŀ" 
                 FOR nCt:= 1 TO Len( aMatriz ) 
                     @ nLinha, 02 Say "�" + DTOC( aMatriz[ nCt ][ 1 ] ) + "�" +; 
                                    StrZero( aMatriz[ nCt ][ 2 ], 6, 0 ) + "�" + ; 
                                    Left( aMatriz[ nCt ][ 3 ], 33 ) + "�" +; 
                                    aMatriz[ nCt ][ 6 ] + "�" +; 
                                    Tran( aMatriz[ nCt ][ 4 ], "@E 9,999.999" ) + "�" + ; 
                                    Tran( aMatriz[ nCt ][ 5 ], "@E 999,999.999" ) + "�" 
                    ++nLinha 
                    IF nLinha > 20 
                       @ nLinha,02 Say "����������������������������������������������������������������������������" 
                       cCorRes:= SetColor() 
                       SetColor( "15/05" ) 
                       @ nLinha, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 9,999.999" ) + "           TOTAIS: " + Tran( nSomaQuant, "99999.999" )+" "+Tran( nSomaTotal, "@E 999,999.999" ) 
                       SetColor( "W+/R" ) 
                       @ nLinha,55 Say " [Enter]Continuar... " 
                       SetColor( cCorRes ) 
                       Mensagem( "Digite o nome do produto ou pressione [ENTER] para ver proxima tela..." ) 
                       nTecla:= INKEY(0) 
                       DO CASE 
                          CASE Upper( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZ " 
                              lLoop:= .T. 
                              EXIT 
                          CASE nTecla == K_ESC 
                              lLoop:= .F. 
                              EXIT 
                       ENDCASE 
                       Scroll( 08, 02, 21, 78 ) 
                       nLinha:= 8 
                    ENDIF 
                    @ nLinha, 02 Say "����������������������������������������������������������������������������" 
                 NEXT 
             CASE nOpcao == 2 
                  aProd:= aMatriz 
                  Relatorio( "VENPROD.REP" ) 
                  Release aProd 
         ENDCASE 
      ENDIF 
 
      IF !lLoop 
         cCorRes:= SetColor() 
         SetColor( "15/05" ) 
         @ nLinha, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 9,999.999" ) + "           TOTAIS: " + Tran( nSomaQuant, "99999.999" )+" "+Tran( nSomaTotal, "@E 999,999.999" ) 
* Alberto 30/04/01 @ nLinha, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 999,999.999" ) + " " 
         SetColor( cCorRes ) 
         Mensagem( "Digite o nome do produto ou [ENTER] para mudar de periodo...", 1 ) 
         nTecla:= INKEY(0) 
         Scroll( 07, 02, 21, 78 ) 
         DO CASE 
            CASE Upper( Chr( nTecla ) ) $ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ " 
                 lLoop:= .T. 
            CASE nTecla == K_ESC 
                 lLoop:= .F. 
         ENDCASE 
      ENDIF 
 
      IF lLoop 
         /* Isto far� com que o passe pelo campo de codigo e chame a funcao 
            de abertura de lista OK!, quando voltar p/ cima, na parte da 
            edicao */ 
         Scroll( 07, 02, 21, 78 ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( nTecla ) 
         cGrupo_:= "999" 
         cCodigo:= "9999" 
         LOOP 
      ENDIF 
   ENDDO 
   DBSelectAr( _COD_CUPOMAUX ) 
   DBSetOrder( 3 ) 
   Set Relation To 
 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � NFBusca 
� Finalidade  � Fazer a busca das informacoes no banco de dados da Nota Fiscal 
� Parametros  � nCodigo == Tipo de informacao cfe. menu 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 06/Novembro/1996 
��������������� 
*/ 
FUNCTION NFBusca( nCodigo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000", cCorRes 
Local aMatriz:= {}, aMatrizLimpa:= {}, lLoop 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
usermodulo(" Nota Fiscal ") 
 
IF !AbreGrupo( "NOTA_FISCAL" ) 
   RETURN NIL 
ENDIF 
DO CASE 
   CASE nCodigo==1 
   VPBox( 01, 0, 22, 79 ) 
 
   @ 02,02 Say "��������������������������������������������������������������������������Ŀ" 
   @ 03,02 Say "� Cliente: [000000]      �                                                 �" 
   @ 04,02 Say "��������������������������������������������������������������������������Ĵ" 
   @ 05,02 Say "� Produto: [000]-[0000]  �                                                 �" 
   @ 06,02 Say "����������������������������������������������������������������������������" 
 
   WHILE LastKey() <> K_ESC 
 
      DBSelectAr( _COD_MPRIMA ) 
      ASize( aMatriz, 1 ) 
      aMatriz:= 0 
      aMatriz:= { } 
      lLoop:= .F. 
 
      @ 03,13 Get nCodCli Pict "999999" Valid BuscaCliente( @nCodCli, 1 ) When; 
               Mensagem( "Digite o c�digo do cliente.") 
 
      @ 05,13 Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo ) When; 
               Mensagem( "Digite o grupo do produto." ) 
 
      @ 05,19 Get cCodigo Pict "9999" Valid VerCodigo( @cCodigo, GetList ) When; 
               Mensagem("Digite o c�digo do produto.") 
 
      READ 
 
      IF LASTKey() == K_ESC 
         DBUnlockAll() 
         FechaArquivos() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
 
      DBSelectAr( _COD_NFISCAL ) 
      DBSetOrder( 1 ) 
 
      DBSelectAr( _COD_PRODNF ) 
      DBSetOrder( 3 ) 
      Set Relation To CODNF_ Into NF_ 
 
      DBSeek( cGrupo_ + cCodigo + Spac( 5 ) ) 
      WHILE Alltrim( CodRed ) == Alltrim( cGrupo_ + cCodigo ) 
           Mensagem( "Buscando Nota Fiscal n� " + StrZero( CODNF_, 6, 0 ) + ", aguarde..." ) 
           IF NF_->Client == nCodCli 
              AAdd( aMatriz, { CODNF_, UNIDAD, QUANT_, PRECOV, PRECOT, DATA__ } ) 
           ENDIF 
           DBSkip() 
      ENDDO 
      nOpcao:= 1 
      @ 07,05 Prompt " 1> Tela       " 
      @ 07,26 Prompt " 2> Impressora " 
      menu to nOpcao 
      IF Len( aMatriz ) <> 0 
         DO CASE 
            CASE nOpcao == 1 
                nLinha:= 8 
                @ 07, 02 Say "�N.Fisc�Un�Quantidade��Valor�����������Data���Ŀ��������������������������Ŀ" 
                FOR nCt:= 1 TO Len( aMatriz ) 
                    @ nLinha, 02 Say "�" + StrZero( aMatriz[ nCt ][ 1 ], 6, 0 ) + "�" + ; 
                              aMatriz[ nCt ][ 2 ] + "�" +; 
                              Tran( aMatriz[ nCt ][ 3 ], "@E 999,999.999" ) + "�" + ; 
                              Tran( aMatriz[ nCt ][ 4 ], "@E 999,999,999.999" ) + "�" +; 
                              Dtoc( aMatriz[ nCt ][ 6 ] ) + "�" 
                    ++nLinha 
                    IF nLinha > 20 
                       @ nLinha,02 Say "������������������������������������������������" 
                       SetColor( "W+/R" ) 
                       @ nLinha,55 Say " [Enter]Continuar... " 
                       SetColor( cCorRes ) 
                       Mensagem( "Digite o nome do produto ou pressione [ENTER] para ver proxima tela..." ) 
                       nTecla:= INKEY(0) 
                       DO CASE 
                          CASE Upper( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZ " 
                               lLoop:= .T. 
                               EXIT 
                          CASE nTecla == K_ESC 
                               lLoop:= .F. 
                               EXIT 
                       ENDCASE 
                       Scroll( 08, 02, 21, 78 ) 
                       nLinha:= 8 
 
                    ENDIF 
                    cCorRes:= SetColor() 
                    SetColor( "G+/B" ) 
                    Scroll( 08, 51, 20, 76 ) 
                    DispBox( 07, 50, 21, 77, 1 ) 
                    IF ( nUltima:= Len( aMatriz ) ) > 0 
                       @ 08,51 Say "Vlr.Ult.Vnd: " + Tran( aMatriz[ nUltima ][ 4 ], "@E 9,999,999.999" ) 
                       @ 10,51 Say "Quant/Unid.: " + Tran( aMatriz[ nUltima ][ 3 ], "@E 999,999.99" ) + " " + aMatriz[ nUltima ][ 2 ] 
                       @ 12,51 Say "Dt. Ult.Ven: " + DTOC( aMatriz[ nUltima ][ 6 ] ) 
                       @ 14,51 Say "Ultima Nota: " + StrZero( aMatriz[ nUltima ][ 1 ], 6, 0 ) 
                       @ 16,51 Say "Perc.IPI...: " + Tran( MPR->IPI___, "@E 999.99" ) + "%" 
                       @ 18,51 Say "Pre�o Tab..: " + Tran( MPR->PRECOV, "@E 999,999.99" ) + " " + MPR->UNIDAD 
                       @ 20,51 Say "Estoque....: " + Tran( MPR->SALDO_, "@E 999,999.99" ) 
                    ENDIF 
                    SetColor( "15/" + CorFundoAtual() ) 
                    @ 09,51 Say "��������������������������" 
                    @ 11,51 Say "��������������������������" 
                    @ 13,51 Say "��������������������������" 
                    @ 15,51 Say "��������������������������" 
                    @ 17,51 Say "��������������������������" 
                    @ 19,51 Say "��������������������������" 
                    SetColor( cCorRes ) 
                    @ nLinha, 02 Say "������������������������������������������������" 
                NEXT 
            CASE nOpcao == 2 
                aProd:= aMatriz 
                Relatorio( "PRODCLI.REP" ) 
                Release aProd 
                lLoop:= .F. 
         ENDCASE 
      ENDIF 
      IF !lLoop 
         Mensagem( "Digite o nome do produto ou [ENTER] para mudar de cliente...", 1 ) 
         nTecla:= INKEY(0) 
         Scroll( 07, 02, 21, 78 ) 
         DO CASE 
            CASE Upper( Chr( nTecla ) ) $ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ " 
                 lLoop:= .T. 
            CASE nTecla == K_ESC 
                 lLoop:= .F. 
         ENDCASE 
      ENDIF 
 
      IF lLoop 
         /* Isto far� com que o passe pelo campo de codigo e chame a funcao 
            de abertura de lista OK!, quando voltar p/ cima, na parte da 
            edicao */ 
         Scroll( 07, 02, 21, 78 ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( nTecla ) 
         cGrupo_:= "999" 
         cCodigo:= "9999" 
         LOOP 
      ENDIF 
   ENDDO 
   DBSelectAr( _COD_PRODNF ) 
   DBSetOrder( 3 ) 
   Set Relation To 
 
ENDCASE 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
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
FUNCTION NFProdPer() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cCodigo:= "0000", cGrupo_:= "000", cCorRes 
Local aMatriz:= {}, aMatrizLimpa:= {}, lLoop 
Local dPerIni:= CTOD( "01/"+right(dtoc(date()),5)), dPerFim:= Date() 
Local nPrecoMedio:= 0, nSomaTotal:= 0, nSomaQuant:= 0 
Local nLinha:= 8, cTpvenda:= "V", Getlist:= {} 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserModulo(" Vendas Por Produto ") 
 
   IF !AbreGrupo( "NOTA_FISCAL" ) 
      RETURN NIL 
   ENDIF 
 
*   WHILE LastKey() <> K_ESC 
   WHILE .T. 
      VPBox( 01, 0, 22, 79 ) 
      @ 02,02 Say "��������������������������������������������������������������������������Ŀ" 
      @ 03,02 Say "� Periodo: [dd/mm/aa] Ate [dd/mm/aa]  (V)endas (O)utras (T)odas: [ ]       �" 
      @ 04,02 Say "��������������������������������������������������������������������������Ĵ" 
      @ 05,02 Say "� Produto: [000]-[0000]  �                                                 �" 
      @ 06,02 Say "����������������������������������������������������������������������������" 
 
      DBSelectAr( _COD_MPRIMA ) 
      ASize( aMatriz, 1 ) 
      aMatriz:= 0 
      aMatriz:= { } 
      lLoop:= .F. 
 
      @ 03,13 Get dPerIni When; 
              Mensagem( "Digite o periodo inicial." ) 
 
      @ 03,28 GeT dPerFim When Mensagem( "Digite o periodo final." ) 
 
      @ 05,13 Get cGrupo_ Pict "999" Valid VerGrupo2( cGrupo_, @cCodigo ) When; 
               Mensagem( "Digite o grupo do produto." ) 
 
      @ 05,19 Get cCodigo Pict "9999" Valid VerCodigo2( @cCodigo, GetList ) When; 
               Mensagem("Digite o c�digo do produto.") 
 
      @ 03,67 GeT cTpvenda pict "@!" valid cTpvenda $ "VOT" When ; 
               Mensagem( "Digite o tipo de venda para a consulta." ) 
 
      READ 
 
      IF LASTKey() == K_ESC 
         DBUnlockAll() 
         FechaArquivos() 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
      aEstrutura:= { {"DATAEM","D", 08,00},; 
                     {"CODNF_","N", 09,00},; 
                     {"CDESCR","C", 45,04},; 
                     {"QUANT_","N", 09,02},; 
                     {"PRECOV","N", 09,02},; 
                     {"UNIDAD","C", 02,00} } 
      DBSelectAr( 123 ) 
      DBCloseArea() 
      DBCREATE( "RESERVA.TMP", aEstrutura ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE RESERVA.TMP Alias RES 
 
      DBSelectAr( _COD_NFISCAL ) 
      DBSetOrder( 1 ) 
 
      DBSelectAr( _COD_PRODNF ) 
      DBSetOrder( 3 ) 
      Set Relation To CODNF_ Into NF_ 
 
      nSomaTotal:= 0 
      nSomaQuant:= 0 
      nPrecoMedio:= 0 
      DBSeek( cGrupo_ + cCodigo + Spac( 5 ) ) 
      WHILE Alltrim( CodRed ) == Alltrim( cGrupo_ + cCodigo ) 
           Mensagem( "Verificando Nota Fiscal N� " + StrZero( CODNF_, 6, 0 ) + ", aguarde..." ) 
           IF NF_->DataEm >= dPerIni .AND. NF_->DataEm <= dPerFim .AND. NF_->NFNULA==" " 
              IF (cTpvenda == "V" .and. ( ( NF_->NATOPE >= 5.120 .AND. NF_->NATOPE <= 5.129 ) .OR. ( NF_->NATOPE >= 6.120 .AND. NF_->NATOPE <= 6.129 ) ) ).or. ;
                 (cTpvenda == "V" .and. ( ( NF_->NATOPE >= 5.101 .AND. NF_->NATOPE <= 5.109 ) .OR. ( NF_->NATOPE >= 6.101 .AND. NF_->NATOPE <= 6.109 ) ) ).or. ; 
                 (cTpvenda == "O" .and. ( ( NF_->NATOPE <  5.120 .OR.  NF_->NATOPE > 5.129 ) .AND. ( NF_->NATOPE <  6.120 .OR.  NF_->NATOPE > 6.129 ) ) ).or. ;
                 (cTpvenda == "O" .and. ( ( NF_->NATOPE <  5.100 .OR.  NF_->NATOPE > 5.109 ) .AND. ( NF_->NATOPE <  6.100 .OR.  NF_->NATOPE > 6.109 ) ) ).or. ; 
                 (cTpvenda == "T") 
                 nSomaTotal+= ( PRECOV * QUANT_ ) 
                 nSomaQuant+= QUANT_ 
                 RES->( DBAppend() ) 
                 RES->( netrlock() ) 
                 replace RES->DATAEM with NF_->DATAEM, ; 
                         RES->CODNF_ with CODNF_ ,; 
                         RES->CDESCR with NF_->CDESCR, ; 
                         RES->QUANT_ with QUANT_, ; 
                         RES->PRECOV with PRECOV, ; 
                         RES->UNIDAD with UNIDAD 
                 RES->( Dbunlock() ) 
                 AAdd( aMatriz, { NF_->DATAEM, CODNF_, NF_->CDESCR, QUANT_, PRECOV, UNIDAD } ) 
              ENDIF 
           ENDIF 
           DBSkip() 
      ENDDO 
 
      nPrecoMedio:= nSomaTotal / nSomaQuant 
      nOpcao:= 1 
      Mensagem( "Escolha a Saida do Relatorio." ) 
      @ 07,05 Prompt " 1> Tela       " 
      @ 07,26 Prompt " 2> Impressora " 
      menu to nOpcao 
      IF Len( aMatriz ) <> 0 
         DO CASE 
            CASE nOpcao == 1 
                 DBselectar( "RES" ) 
                 DBgotop() 
                 ccab := "Data   N.Fiscal Cliente                            Qtdade.  V.Unit.  V.Total" 
*12.12.12 123456 123456789.123456789.123456789.123 999999.99 9,999.99 99,999.99 
                 cdados := { || dtoc(DATAEM)+" "+strzero(CODNF_,6)+" "+pad( CDESCR ,33) + ; 
                           transf( QUANT_, "999999.99")+" "+transf( PRECOV,"@e 9,999.99")+ ; 
                           transf( (QUANT_*PRECOV), "@e 99,999.99") } 
                 @ 21, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 9,999.999" ) + "           TOTAIS: " + Tran( nSomaQuant, "999999.999" )+" "+Tran( nSomaTotal, "@E 999,999.99" ) 
                 nTecla := Nil 
                 Mensagem("Pressione [ESC] para retornar.") 
                 do while nTecla <> K_ESC 
                    Browse(07,01,20,78,ccab,cdados,,@Ntecla, .f.) 
                 enddo 
                 lLoop:= .T. 
 
/* 
                 nLinha:= 8 
                 @ 07, 02 Say "�Data�����N.Fisc�Cliente������������������������������Quantidad�Valor�����Ŀ" 
                 FOR nCt:= 1 TO Len( aMatriz ) 
                     @ nLinha, 02 Say "�" + DTOC( aMatriz[ nCt ][ 1 ] ) + "�" +; 
                                    StrZero( aMatriz[ nCt ][ 2 ], 6, 0 ) + "�" + ; 
                                    Left( aMatriz[ nCt ][ 3 ], 33 ) + "�" +; 
                                    aMatriz[ nCt ][ 6 ] + "�" +; 
                                    Tran( aMatriz[ nCt ][ 4 ], "@E 9,999.999" ) + "�" + ; 
                                    Tran( aMatriz[ nCt ][ 5 ], "@E 999,999.999" ) + "�" 
                    ++nLinha 
                    IF nLinha > 20 
                       @ nLinha,02 Say "����������������������������������������������������������������������������" 
                       cCorRes:= SetColor() 
                       SetColor( "15/05" ) 
                       @ nLinha, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 9,999.999" ) + "           TOTAIS: " + Tran( nSomaQuant, "99999.999" )+" "+Tran( nSomaTotal, "@E 999,999.999" ) 
                       SetColor( "W+/R" ) 
                       @ nLinha,55 Say " [Enter]Continuar... " 
                       SetColor( cCorRes ) 
                       Mensagem( "Digite o nome do produto ou pressione [ENTER] para ver proxima tela..." ) 
                       nTecla:= INKEY(0) 
                       DO CASE 
                          CASE Upper( Chr( nTecla ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZ " 
                              lLoop:= .T. 
                              EXIT 
                          CASE nTecla == K_ESC 
                              lLoop:= .F. 
                              EXIT 
                       ENDCASE 
                       Scroll( 08, 02, 21, 78 ) 
                       nLinha:= 8 
                    ENDIF 
                    @ nLinha, 02 Say "����������������������������������������������������������������������������" 
                 NEXT 
*/ 
             CASE nOpcao == 2 
                  aProd:= aMatriz 
                  Relatorio( "VENPROD2.REP" ) 
                  Release aProd 
         ENDCASE 
      ENDIF 
 
/* 
      IF !lLoop 
         cCorRes:= SetColor() 
         SetColor( "15/05" ) 
         @ nLinha, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 9,999.999" ) + "           TOTAIS: " + Tran( nSomaQuant, "99999.999" )+" "+Tran( nSomaTotal, "@E 999,999.999" ) 
* Alberto 30/04/01 @ nLinha, 03 Say " PRECO MEDIO DO PRODUTO: " + Tran( nPrecoMedio, "@E 999,999.999" ) + " " 
         SetColor( cCorRes ) 
         Mensagem( "Digite o nome do produto ou [ENTER] para mudar de periodo...", 1 ) 
         nTecla:= INKEY(0) 
         Scroll( 07, 02, 21, 78 ) 
         DO CASE 
            CASE Upper( Chr( nTecla ) ) $ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ " 
                 lLoop:= .T. 
            CASE nTecla == K_ESC 
                 lLoop:= .F. 
         ENDCASE 
      ENDIF 
      IF lLoop 
         Isto far� com que o passe pelo campo de codigo e chame a funcao 
            de abertura de lista OK!, quando voltar p/ cima, na parte da 
            edicao 
         Scroll( 07, 02, 21, 78 ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) 
         KeyBoard CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( K_ENTER ) + CHR( nTecla ) 
         cGrupo_:= "999" 
         cCodigo:= "9999" 
         LOOP 
      ENDIF 
*/ 
   ENDDO 
   DBSelectAr( _COD_PRODNF ) 
   DBSetOrder( 3 ) 
   Set Relation To 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � NFPeriodo 
� Finalidade  � Notas Fiscais Emitidas no periodo 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
� Modificacao � 22 de Julho de 1999 - Atualizacao permitindo que as notas fiscais 
�             �                       sejm exibidas c/ codigo 5.12..5.129 ou 6.12..6.129 
�             � 
�             � 
�             � 
��������������� 
*/ 
FUNCTION NFPeriodo() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nSoma1:= 0, nSoma2:= 0,; 
      nTecla, nRow:= 1, nSoma3:= 0, nSoma4:= 0, nSomaMes:= 0, aGrafico:= {},; 
      nIniDia:= 1, nFimDia:= 31 
Local cArquivo:= "NFPESQ00.NTX" 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
usermodulo(" Nota Fiscal ") 
 
*DBCloseAll()   /// ALBERTO Mon  03-06-02 
*IF !AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
*   SetColor( cCor ) 
*   SetCursor( nCursor ) 
*   ScreenRest( cTela ) 
*   Return Nil 
*ENDIF 
 
WHILE .T. 
 
      nSoma1:= 0 
      nSoma2:= 0 
      nRow:= 1 
      nSoma3:= 0 
      nSoma4:= 0 
      nSomaMes:= 0 
      aGrafico:= {} 
 
      ScreenRest( cTela ) 
      nLin:= 08 
      nCol:= 11 
      VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de Notas Fiscais Emitidas", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Ordem ���������������Ŀ" 
      @ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � � 1-Numero Nota Fiscal  �" 
      @ nLin+04, nCol + 2 Say "��������������������������������Ĵ � 2-Nome do Cliente     �" 
      @ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � � 3-Data de Emissao     �" 
      @ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
      @ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
      @ nLin+08, nCol + 2 Say "�      Periodo dentro do Mes     � �                       �" 
      @ nLin+09, nCol + 2 Say "��������������������������������Ĵ �  Monitor  Impressora  �" 
      @ nLin+10, nCol + 2 Say "�       Do Dia: [01] a [31]      � �                       �" 
      @ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
 
      @ nLin + 05, nCol + 08 Get dIniEmissao 
      @ nLin + 05, nCol + 24 Get dFimEmissao 
      @ nLin + 10, nCol + 18 Get nIniDia Pict "@E 99" 
      @ nLin + 10, nCol + 25 Get nFimDia Pict "@E 99" 
      READ 
      IF LastKey() == K_ESC 
         EXIT 
      ENDIF 
 
      @ nLin + 03, nCol + 39 Prompt "1-Numero Nota Fiscal " 
      @ nLin + 04, nCol + 39 Prompt "2-Nome do Cliente    " 
      @ nLin + 05, nCol + 39 Prompt "3-Data de Emissao    " 
      MENU TO nOrdem 
      @ nLin + 09, nCol + 40 Prompt "Monitor" 
      @ nLin + 09, nCol + 49 Prompt "Impressora" 
      MENU TO nDevice 
      IF LastKey() == K_ESC 
         EXIT 
      ENDIF 
 
      aMatriz:= { } 
      DBSelectAr( _COD_NFISCAL ) 
      dIEmiss:= dIniEmissao 
      dFEmiss:= dFimEmissao 
      cArquivo:= "NFPESQ00.NTX" 
      IF nOrdem == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON NUMERO TO &cArquivo EVAL {|| Processo() } ; 
                  FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                      DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                      NFNULA == " " .AND.; 
                  ( ( NATOPE >= 5.11 .AND. NATOPE <= 5.129 ) .OR.; 
                    ( NATOPE >= 5.100 .AND. NATOPE <= 5.102 ) .OR.; 
                    ( NATOPE >= 6.12 .AND. NATOPE <= 6.129 ) .OR.; 
                    ( NATOPE >= 6.100 .AND. NATOPE <= 6.102 ) .OR. NATOPE=0.00 ) 
      ELSEIF nOrdem == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON CDESCR TO &cArquivo EVAL {|| Processo() } ; 
                  FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                      DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                      NFNULA == " " .AND.; 
                  ( ( NATOPE >= 5.11 .AND. NATOPE <= 5.129 ) .OR.; 
                    ( NATOPE >= 5.100 .AND. NATOPE <= 5.102 ) .OR.; 
                    ( NATOPE >= 6.12 .AND. NATOPE <= 6.129 ) .OR.; 
                    ( NATOPE >= 6.100 .AND. NATOPE <= 6.102 ) .OR. NATOPE=0.00 ) 
      ELSEIF nOrdem == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON DATAEM TO &cArquivo EVAL {|| Processo() } ; 
                  FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                      DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                      NFNULA == " " .AND.; 
                  ( ( NATOPE >= 5.11 .AND. NATOPE <= 5.129 ) .OR.; 
                    ( NATOPE >= 5.100 .AND. NATOPE <= 5.102 ) .OR.; 
                    ( NATOPE >= 6.12 .AND. NATOPE <= 6.129 ) .OR.; 
                    ( NATOPE >= 6.100 .AND. NATOPE <= 6.102 ) .OR. NATOPE=0.00 ) 
      ENDIF 
      DBSetOrder( 1 ) 
      DBGoTop() 
      Mensagem( "Somando as Notas Fiscais, aguarde..." ) 
      cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
      WHILE ! EOF() 
          IF LastKey() == K_ESC 
             EXIT 
          ENDIF 
          nSomaMes+= VlrTot 
          nSoma1+= VlrNot 
          nSoma2+= VlrTot 
          nSoma3+= VlrIcm 
          nSoma4+= VlrIpi 
          DBSkip() 
          cMesAno:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
          IF ! cMesAno == cMesAnoAnt .OR. EOF() 
               AAdd( aGrafico, { cMesAnoAnt, nSomaMes, 0 } ) 
               cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
               nSomaMes:= 0 
          ENDIF 
      ENDDO 
      DBGoTop() 
      IF nDevice == 1 
         vpbox( 00, 00, 22, 79, "NOTAS FISCAIS", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
         SetColor( _COR_BROWSE ) 
         @ 19,01 Say Repl( "�", 78 ) 
         @ 20,03 Say "Total de ICMs...:" + TRAN( nSoma3, "@R 999,999,999.99" ) 
         @ 21,03 Say "Total de IPI....:" + TRAN( nSoma4, "@R 999,999,999.99" ) 
         @ 20,43 Say "Total Nota......:" + TRAN( nSoma1, "@R 999,999,999.99" ) 
         @ 21,43 Say "Total+Serv+IPI..:" + TRAN( nSoma2, "@R 999,999,999.99" ) 
         IF nOrdem == 1 
            @ 01,02 Say "Relacao em ordem de numero de nota fiscal." 
         ELSEIF nOrdem == 2 
            @ 01,02 Say "Relacao em ordem de cliente." 
         ELSEIF nOrdem == 3 
            @ 01,02 Say "Relacao em ordem de data de emissao." 
         ENDIF 
         Mensagem( "Pressione [G] para visualizar um grafico de comparacao mensal." ) 
         @ 01,45 Say "Periodo de " + DTOC( dIniEmissao ) + " ate " + DTOC( dFimEmissao ) + "." 
         SetColor( "W+/R" ) 
         @ 02,01 Say "N.Fiscal Cliente                        Dt.Emis.     Valor NF      Vlr.Total  " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowseDB(03,01,18,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| StrZero( NUMERO, 8, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| Left( CDESCR, 30 ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| DATAEM } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( VLRNOT, "@e 99,999,999.99" ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( VLRTOT, "@e 99,999,999.99" ) } )) 
         oTAB:AUTOLITE:=.f. 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,5},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               case Chr( nTecla ) $ "Gg" 
                    Grafico( aGrafico ) 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ELSEIF nDevice == 2 
         SelecaoImpressora(.F.) 
         // Set Printer To Arquivo.Txt 
         Set Device To Print 
         nLinI:= 0 
         nMatriz4:= 0 
         nMatriz5:= 0 
         nMatriz6:= 0 
         nMatriz7:= 0 
         IF nOrdem == 1 
            cOrdem:= "Ordem de Emissao" 
         ELSEIF nOrdem == 2 
            cOrdem:= "Ordem de Numero da Nota Fiscal" 
         ELSE 
            cOrdem:= "Ordem de Nome do Cliente" 
         ENDIF 
         nPagina:= 0 
         @ ++nLinI,01 Say Condensado( .T. ) 
         @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "             RELACAO DE NOTAS FISCAIS EM " + DTOC( Date() ) 
         @ ++nLinI,01 Say cOrdem + "        =>  Notas Fiscais de " + Alltrim( Str( nIniNf, 8, 0 ) ) + " ate " + Alltrim( Str( nFimNf, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         @ ++nLinI,01 Say "N.Fiscal Cliente                      Dt.Emis.      Valor NF      Vlr.Total                Valor IPI                Valor ICMs" 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         DBGOTop() 
         WHILE !EOF() 
             @ ++nLinI,01 Say StrZero( NUMERO, 6, 0 ) 
             @ nLinI,08  Say Left( CDESCR, 30 ) 
             @ nLinI,38  Say DATAEM 
             @ nLinI,48  Say Tran( VLRNOT, "@e 999,999,999.99" ) 
             @ nLinI,71  Say Tran( VLRTOT, "@e 999,999,999.99" ) 
             @ nLinI,90  Say Tran( VLRIPI, "@e 999,999,999.99" ) 
             @ nLinI,118 Say Tran( VLRICM, "@e 999,999,999.99" ) 
             IF nLinI >= 54 
                nLinI:= 0 
                @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "             RELACAO DE NOTAS FISCAIS EM " + DTOC( Date() ) 
                @ ++nLinI,01 Say cOrdem + "        =>  Notas Fiscais de " + Alltrim( Str( nIniNf, 8, 0 ) ) + " ate " + Alltrim( Str( nFimNf, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
                @ ++nLinI,01 Say "N.Fiscal Cliente                      Dt.Emis.      Valor NF      Vlr.Total                Valor IPI                Valor ICMs" 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
             ENDIF 
             DBSkip() 
         ENDDO 
         @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
         @ ++nLinI, 05 Say "Total de ICMs...:" + TRAN( nSoma3, "@R 999,999,999.99" )   //3 
         @ nLinI,   40 Say "Total Nota......:" + TRAN( nSoma1, "@R 999,999,999.99" )   //2 
         @ ++nLinI, 05 Say "Total de IPI....:" + TRAN( nSoma4, "@R 999,999,999.99" )   //1 
         @ nLinI,   40 Say "Total+Serv+IPI..:" + TRAN( nSoma2, "@R 999,999,999.99" )   //4 
         @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
         @ ++nLinI, 01 Say Condensado(.F.) 
      ENDIF 
      Set Device To Screen 
      IF LastKey() <> K_ESC 
         Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
         Inkey(0) 
         Scroll( 07, 02, 21, 78 ) 
         Exit 
      ENDIF 
ENDDO 
DBSelectAr( _COD_NFISCAL ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/nfmind01.ntx", "&gdir/nfmind02.ntx", "&gdir/nfmind03.ntx", "&gdir/nfmind04.ntx", "&gdir/nfmind05.ntx"      
#else 
  Set Index To "&GDir\NFMIND01.NTX", "&GDir\NFMIND02.NTX", "&GDir\NFMIND03.NTX", "&GDir\NFMIND04.NTX", "&GDir\NFMIND05.NTX"      
#endif
IF File( cArquivo ) 
   FErase( cArquivo ) 
ENDIF 
*FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
Function LucroNotas() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nSoma1:= 0, nSoma2:= 0,; 
      nIniDia:= 1, nFimDia:= 31,; 
      nTecla, nRow:= 1, nSoma3:= 0, nSoma4:= 0, nSomaMes:= 0, aGrafico:= {} 
Local cArquivo:= "CUPESQ00.NTX" 
 
Local aStr:= {{ "INDICE", "C", 12, 00 },; 
              { "DESCRI", "C", 45, 00 },; 
              { "UNIDAD", "C", 02, 00 },; 
              { "DATAEM", "D", 08, 00 },; 
              { "COMPRA", "N", 16, 02 },; 
              { "VENDA_", "N", 16, 02 },; 
              { "QUANT_", "N", 16, 02 }} 
 
Priv nVenda:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
 
   WHILE .T. 
 
      DBSelectAr( _COD_PRODNF ) 
      dbSetOrder( 1 ) 
      DBGoTop() 
 
      DBSelectAr( 123 ) 
      DBCreate( "TEMP.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE TEMP.TMP Alias TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON INDICE TO IND22233 
 
      nSoma1:= 0 
      nSoma2:= 0 
      nRow:= 1 
      nSoma3:= 0 
      nSoma4:= 0 
      nSomaMes:= 0 
      aGrafico:= {} 
      aMatriz:= {} 
      aMatrizLimpa:= {} 
      nLin:= 08 
      nCol:= 11 
      VPBox( nLin, nCol, nLin + 13, nCol + 64, "LUCRATIVIDADE POR PERIODO", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Ordem ���������������Ŀ" 
      @ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � � 1-Numero Nota Fiscal  �" 
      @ nLin+04, nCol + 2 Say "��������������������������������Ĵ � 2-Nome do Cliente     �" 
      @ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � � 3-Data de Emissao     �" 
      @ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
      @ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
      @ nLin+08, nCol + 2 Say "�     Periodo dentro do mes      � �                       �" 
      @ nLin+09, nCol + 2 Say "��������������������������������Ĵ �        MONITOR        �" 
      @ nLin+10, nCol + 2 Say "�       Do Dia [00] a [00]       � �                       �" 
      @ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
 
      @ nLin + 05, nCol + 08 Get dIniEmissao 
      @ nLin + 05, nCol + 24 Get dFimEmissao 
      @ nLin + 10, nCol + 17 Get nIniDia Pict "@E 99" 
      @ nLin + 10, nCol + 24 Get nFimDia Pict "@E 99" 
      READ 
 
      IF LastKey()==K_ESC 
         EXIT 
      ENDIF 
 
      /* Ordenacao */ 
      @ nLin + 03, nCol + 39 Prompt "1-Numero Nota Fiscal " 
      @ nLin + 04, nCol + 39 Prompt "2-Nome do Cliente    " 
      @ nLin + 05, nCol + 39 Prompt "3-Data de Emissao    " 
      MENU TO nOrdem 
 
      nDevice:= 1 
 
      WHILE LastKey() <> K_ESC 
            aMatriz:= { } 
            DBSelectAr( _COD_NFISCAL ) 
            dIEmiss:= dIniEmissao 
            dFEmiss:= dFimEmissao 
            cArquivo:= "CUPESQ00.NTX" 
            IF nOrdem == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON NUMERO TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ELSEIF nOrdem == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON CDESCR TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ELSEIF nOrdem == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON DATAEM TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ENDIF 
            DBSetOrder( 1 ) 
            DBGoTop() 
            Mensagem( "Somando as Notas Fiscais, aguarde..." ) 
            cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
            WHILE ! EOF() 
                IF LastKey() == K_ESC 
                   EXIT 
                ENDIF 
                nSomaMes+= VlrTot 
                nSoma1+= VlrNot 
                nSoma2+= VlrTot 
                nSoma3+= VlrIcm 
                nSoma4+= VlrIpi 
                DBSkip() 
                cMesAno:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
                IF ! cMesAno == cMesAnoAnt .OR. EOF() 
//                     AAdd( aGrafico, { cMesAnoAnt, nSomaMes, 0 } ) 
                     cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
                     nSomaMes:= 0 
                ENDIF 
            ENDDO 
            MPR->( DBSetOrder( 1 ) ) 
            PNF->( DBSetOrder( 5 ) ) 
            NF_->( DBGoTop() ) 
            nVenda:= 0 
            WHILE !NF_->( EOF() ) 
                nVenda:= nVenda + NF_->VLRTOT 
                IF PNF->( DBSeek( NF_->NUMERO ) ) 
                   WHILE PNF->CODNF_ == NF_->NUMERO 
                      IF MPR->( DBSeek( PNF->CODIGO ) ) 
                         PXF->( DBSeek( PNF->CODIGO ) ) 
                         IF !TMP->( DBSeek( PNF->CODIGO ) ) 
                            TMP->( DBAppend() ) 
                         ENDIF 
 
                         IF PXF->VALOR_ <= 0 
                            IF MPR->PERCPV > 0 
                               nIndice:= ( ( 1 * MPR->PERCPV ) / 100 ) + 1 
                               nIndice:= 100 - ( ( 1 / nIndice ) * 100 ) 
                               nPrecoCompra:= MPR->PRECOV - ( ( MPR->PRECOV * nIndice ) / 100 ) 
                               VPBox( 01, 01, 09, 50, " PRODUTO / CONFERENCIA DE PRECOS ", _COR_GET_EDICAO ) 
                               @ 03,02 Say MPR->DESCRI 
                               @ 04,02 SAY "Preco de venda...........: " + Tran( MPR->PRECOV, "@e 999,999.99" ) 
                               @ 05,02 SAY "Margem Padrao............: " + Tran( MPR->PERCPV, "@e 9999.99" ) + "%" 
                               @ 06,02 SAY "Preco de Compra Calculado: " + Tran( nPrecoCompra, "@e 999,999.99" ) 
                               @ 07,02 Say "Indice Inverso...........: " + Tran( nIndice, "@E 999,999.99" ) 
                           ELSE 
                               IF SWAlerta( "Verifique os precos do produto: " + AllTrim( MPR->INDICE ) + ";" + ; 
                                         "Preco de Compra R$ " + Tran( PXF->VALOR_, "@E 999,999.99" )   + ";" + ; 
                                         "Margem de Lucro % "  + Tran( MPR->PERCPV, "@e 99999.99" )     + ";" + ; 
                                         "Preco de Venda  R$ " + Tran( MPR->PRECOV, "@e 99999.99" ), { " Ignorar ", " Cancelar " } ) == 2 
                                  DBCloseAll() 
                                  AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
                                  ScreenRest( cTela ) 
                                  SetColor( cCor ) 
                                  Return Nil 
                               ELSE 
                                  nPrecoCompra:= 0 
                               ENDIF 
                           ENDIF 
                         ELSE 
                            nPrecoCompra:= PXF->VALOR_ 
                         ENDIF 
                         IF TMP->( netrlock() ) 
                            Replace TMP->INDICE  With PNF->CODIGO,; 
                                    TMP->DESCRI  With PNF->DESCRI,; 
                                    TMP->UNIDAD  With PNF->UNIDAD,; 
                                    TMP->COMPRA  With TMP->COMPRA + ( PNF->QUANT_ * nPrecoCompra ),; 
                                    TMP->VENDA_  With TMP->VENDA_ + PNF->PRECOT,; 
                                    TMP->QUANT_  With TMP->QUANT_ + PNF->QUANT_ 
                         ENDIF 
                      ENDIF 
                      PNF->( DBSkip() ) 
                   ENDDO 
                ENDIF 
                NF_->( DBSkip() ) 
            ENDDO 
            DBSelectAr( 123 ) 
            DBGoTop() 
            nVendaBruta:= 0 
            nCompra:= 0 
            WHILE !EOF() 
                nCompra:= nCompra + COMPRA 
                nVendaBruta:= nVendaBruta + VENDA_ 
                DBSkip() 
            ENDDO 
 
            /////// AQUI /////// 
            DBSelectAr( 123 ) 
            DBGoTop() 
            VPBox( 0, 0, 22, 79, "LUCRATIVIDADE", _COR_GET_EDICAO ) 
            Mensagem( "" ) 
 
            /* RESUMO DE OPERACOES */ 
            @ 16,01 Say "��� RESUMO ��" + Repl( "�", 65 ) 
 
            /* TOTAL */ 
            @ 17,01 Say "Vendas a preco de Compra:" + Tran( nCompra, "@E 999,999,999.99" ) 
            @ 18,01 Say "Venda Bruta.............:" + Tran( nVendaBruta, "@E 999,999,999.99" ) 
            @ 19,01 Say "Acrescimos/Descontos....:" + Tran( nVenda - nVendaBruta, "@E 999,999,999.99" ) 
            @ 20,01 Say "VENDAS A PRECO REAL.....:" + Tran( nVenda,  "@E 999,999,999.99" ) 
 
            @ 17,41 Say "Lucro Bruto (R$)........:" + Tran( nVenda - nCompra,  "@E 999,999.99" ) 
            @ 18,41 Say "�����������������������Ŀ" 
            @ 19,41 Say "� LUCRATIVIDADE LIQUIDA �" + Tran( ( ( nVenda - nCompra ) / nVenda ) * 100,  "@E 99999.99" ) + "%" 
            @ 20,41 Say "�������������������������" 
 
            SetColor( _COR_GET_EDICAO ) 
            oTAB:=tbrowseDB( 01, 01, 14, 78) 
            oTAB:addcolumn( tbcolumnnew( "Produto                                  Quantidade"+; 
                                   "  Compra V E N D A      %",; 
                                          {|| alltrim( INDICE ) + " " +; 
                                             LEFT( DESCRI, 34 ) +; 
                                             Tran( QUANT_, "@E 99,999.99" ) +; 
                                             Tran( COMPRA, "@e 99,999.99" ) +; 
                                             Tran( VENDA_, "@e 99,999.99" ) +; 
                                             Tran( ( ( VENDA_ - COMPRA ) / VENDA_ ) * 100, "@E 9,999.99" ) + "%" } )) 
            oTAB:AUTOLITE:=.F. 
            oTAB:dehilite() 
            WHILE .T. 
               oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
               whil nextkey()==0 .and. ! oTAB:stabilize() 
               end 
               MPR->( DBSeek( TMP->INDICE ) ) 
               @ 21,01 Say "Margem da Tabela de Precos:" + Tran( MPR->PERCPV, "@E 9999.99" ) + "%" 
               nTecla:=inkey( 0 ) 
               if nTecla==K_ESC 
                  exit 
               endif 
               do case 
                  case nTecla==K_UP         ;oTAB:up() 
                  case nTecla==K_DOWN       ;oTAB:down() 
                  case nTecla==K_LEFT       ;oTAB:left() 
                  case nTecla==K_RIGHT      ;oTAB:right() 
                  case nTecla==K_PGUP       ;oTAB:pageup() 
                  case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
                  case nTecla==K_PGDN       ;oTAB:pagedown() 
                  case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
                  case nTecla==K_TAB 
                       IF Confirma( 0, 0, "Imprimir relatorio de lucratividade?","[S]", "S" ) 
                          Relatorio( "LUCRO.REP" ) 
                          IF UPPER( LEFT( Set( 24 ), 3 ) ) <> "LPT" 
                             ViewFile( ALLTRIM( Set( 24 ) ) ) 
                             Set( 24, "LPT1" ) 
                          ENDIF 
                       ENDIF 
                       DBGoTop() 
                       oTab:RefreshAll() 
                       WHILE !oTab:Stabilize() 
                       ENDDO 
                  otherwise                ;tone(125); tone(300) 
              endcase 
              oTAB:refreshcurrent() 
              oTAB:stabilize() 
            ENDDO 
      ENDDO 
      DBSelectAr( 123 ) 
      DBCloseArea() 
      DBCloseAll() 
      AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
      ScreenRest( cTela ) 
   ENDDO 
   DBCloseAll() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � LUCRATIVIDADE 
� Finalidade  � Relacao de Lucrativiade 
� Retorno     � 
� Programador � 
� Data        � 
� Modificacao � 
��������������� 
*/ 
Function Lucratividade() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nSoma1:= 0, nSoma2:= 0,; 
      nIniDia:= 1, nFimDia:= 31,; 
      nTecla, nRow:= 1, nSoma3:= 0, nSoma4:= 0, nSomaMes:= 0, aGrafico:= {} 
Local cArquivo:= "CUPESQ00.NTX", nNaData, lNaData
 
Local aStr:= {{ "INDICE", "C", 12, 00 },; 
              { "DESCRI", "C", 45, 00 },; 
              { "UNIDAD", "C", 02, 00 },; 
              { "DATAEM", "D", 08, 00 },; 
              { "COMPRA", "N", 16, 02 },; 
              { "VENDA_", "N", 16, 02 },; 
              { "QUANT_", "N", 16, 02 }} 
 
Priv nVenda:= 0 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
 
   WHILE .T. 
 
      DBSelectAr( _COD_CUPOMAUX ) 
      dbSetOrder( 1 ) 
      DBGoTop() 
 
      DBSelectAr( 123 ) 
      DBCreate( "TEMP.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE TEMP.TMP Alias TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON INDICE TO IND22233 
 
      nSoma1:= 0 
      nSoma2:= 0 
      nRow:= 1 
      nSoma3:= 0 
      nSoma4:= 0 
      nSomaMes:= 0 
      aGrafico:= {} 
      aMatriz:= {} 
      aMatrizLimpa:= {} 
      nLin:= 08 
      nCol:= 11 
      VPBox( nLin, nCol, nLin + 13, nCol + 64, "LUCRATIVIDADE POR PERIODO", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Ordem ���������������Ŀ"
      @ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � � 1-Numero Cupom Fiscal �"
      @ nLin+04, nCol + 2 Say "��������������������������������Ĵ � 2-Nome do Cliente     �"
      @ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � � 3-Data de Emissao     �"
      @ nLin+06, nCol + 2 Say "���������������������������������� �������������������������"
      @ nLin+07, nCol + 2 Say "��������������������������������Ŀ �����������������������Ŀ"
      @ nLin+08, nCol + 2 Say "�     Periodo dentro do mes      � � Preco de Custo        �"
      @ nLin+09, nCol + 2 Say "��������������������������������Ĵ �����������������������Ĵ"
      @ nLin+10, nCol + 2 Say "�       Do Dia [00] a [00]       � � ATUAL      NA DATA    �"
      @ nLin+11, nCol + 2 Say "���������������������������������� �������������������������"
 
      @ nLin + 05, nCol + 08 Get dIniEmissao 
      @ nLin + 05, nCol + 24 Get dFimEmissao 
      @ nLin + 10, nCol + 17 Get nIniDia Pict "@E 99" 
      @ nLin + 10, nCol + 24 Get nFimDia Pict "@E 99" 
      READ 
 
      IF LastKey()==K_ESC 
         EXIT 
      ENDIF 
 
      /* Ordenacao */ 
      @ nLin + 03, nCol + 39 Prompt "1-Numero Cupom Fiscal" 
      @ nLin + 04, nCol + 39 Prompt "2-Nome do Cliente    " 
      @ nLin + 05, nCol + 39 Prompt "3-Data de Emissao    " 
      MENU TO nOrdem

      nNaData:= 1     // gelson      16-11-2004
      @ nLin+10, nCol+39 Prompt "ATUAL"
      @ nLin+10, nCol+50 Prompt "NA DATA"
      Menu to nNaData
      If nNaData==1
         lNaData:= .F.
      Else
         lNaData:= .T.
      EndIf
 
      nDevice:= 1 
 
      WHILE LastKey() <> K_ESC 
            aMatriz:= { } 
            DBSelectAr( _COD_CUPOM ) 
            dIEmiss:= dIniEmissao 
            dFEmiss:= dFimEmissao 
            cArquivo:= "CUPESQ00.NTX" 
            IF nOrdem == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON NUMERO TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ELSEIF nOrdem == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON CDESCR TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ELSEIF nOrdem == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON DATAEM TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ENDIF 
            DBSetOrder( 1 ) 
            DBGoTop() 
            Mensagem( "Somando as Notas Fiscais, aguarde..." ) 
            cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
            WHILE ! EOF() 
                IF LastKey() == K_ESC 
                   EXIT 
                ENDIF 
                nSomaMes+= VLRTOT
                nSoma1+= VLRNOT
                nSoma2+= VLRTOT
                nSoma3+= VLRICM
                nSoma4+= VLRIPI
                DBSkip() 
                cMesAno:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
                IF ! cMesAno == cMesAnoAnt .OR. EOF() 
//                     AAdd( aGrafico, { cMesAnoAnt, nSomaMes, 0 } ) 
                     cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
                     nSomaMes:= 0 
                ENDIF 
            ENDDO 
            MPR->( DBSetOrder( 1 ) ) 
            CAU->( DBSetOrder( 5 ) ) 
            CUP->( DBGoTop() ) 
            nVenda:= 0 
            WHILE !CUP->( EOF() ) 
                nVenda:= nVenda + CUP->VLRTOT 
                IF CAU->( DBSeek( CUP->NUMERO ) ) 
                   WHILE CAU->CODNF_ == CUP->NUMERO 
                      // 
                      // BUG FIX: 06/06/2002: IF MPR->( DBSeek( CAU->CODIGO ) ) 
                      // Correcao para evitar que pegue �tens de outro periodo, 
                      // pelo fato de ter o mesmo n�mero de Pedido. 
                      // 
                      IF MPR->( DBSeek( CAU->CODIGO ) ) .AND. CAU->DATA__ == CUP->DATAEM 
                         PXF->( DBSeek( CAU->CODIGO ) ) 
                         IF !TMP->( DBSeek( CAU->CODIGO ) ) 
                            TMP->( DBAppend() ) 
                         ENDIF 
 
                         IF PXF->VALOR_ <= 0 
                            IF MPR->PERCPV > 0 
                               nIndice:= ( ( 1 * MPR->PERCPV ) / 100 ) + 1 
                               nIndice:= 100 - ( ( 1 / nIndice ) * 100 ) 
                               nPrecoCompra:= MPR->PRECOV - ( ( MPR->PRECOV * nIndice ) / 100 ) 
                               VPBox( 01, 01, 09, 50, " PRODUTO / CONFERENCIA DE PRECOS ", _COR_GET_EDICAO ) 
                               @ 03,02 Say MPR->DESCRI 
                               @ 04,02 SAY "Preco de venda...........: " + Tran( MPR->PRECOV, "@e 999,999.99" ) 
                               @ 05,02 SAY "Margem Padrao............: " + Tran( MPR->PERCPV, "@e 9999.99" ) + "%" 
                               @ 06,02 SAY "Preco de Compra Calculado: " + Tran( nPrecoCompra, "@e 999,999.99" ) 
                               @ 07,02 Say "Indice Inverso...........: " + Tran( nIndice, "@E 999,999.99" ) 
                           ELSE 
                               IF SWAlerta( "Verifique os precos do produto: " + AllTrim( MPR->INDICE ) + ";" + ; 
                                         "Preco de Compra R$ " + Tran( PXF->VALOR_, "@E 999,999.99" )   + ";" + ; 
                                         "Margem de Lucro % "  + Tran( MPR->PERCPV, "@e 99999.99" )     + ";" + ; 
                                         "Preco de Venda  R$ " + Tran( MPR->PRECOV, "@e 99999.99" ), { " Ignorar ", " Cancelar " } ) == 2 
                                  DBCloseAll() 
                                  AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
                                  ScreenRest( cTela ) 
                                  SetColor( cCor ) 
                                  Return Nil 
                               ELSE 
                                  nPrecoCompra:= 0 
                               ENDIF 
                           ENDIF 
                         ELSE 
                           //               lNaData    gelson 16-11-2004
                           IF ( nCompra:= PrecoNaData( CAU->CODIGO, CAU->DATA__ ) ) > 0 .and. lNaData
                              nPrecoCompra:= nCompra
                           ELSE
                              nPrecoCompra:= PXF->VALOR_
                           ENDIF
                         ENDIF 
 
 
                         // IF ALLTRIM( TMP->INDICE ) $ "5083012-5083019-5060037" 
                         //    @ 00,00 SAY "OLHA AQUI CORNO!" 
                         //    @ 01,01 SAY CAU->CODNF_ 
                         //    INKEY(0) 
                         // ENDIF 
 
 
                         IF TMP->( netrlock() ) 
                            Replace TMP->INDICE  With CAU->CODIGO,; 
                                    TMP->DESCRI  With CAU->DESCRI,; 
                                    TMP->UNIDAD  With CAU->UNIDAD,; 
                                    TMP->COMPRA  With TMP->COMPRA + ( CAU->QUANT_ * nPrecoCompra ),; 
                                    TMP->VENDA_  With TMP->VENDA_ + CAU->PRECOT,; 
                                    TMP->QUANT_  With TMP->QUANT_ + CAU->QUANT_ 
                         ENDIF 
                      ENDIF 
                      CAU->( DBSkip() ) 
                   ENDDO 
                ENDIF 
                CUP->( DBSkip() ) 
            ENDDO 
            DBSelectAr( 123 ) 
            DBGoTop() 
            nVendaBruta:= 0 
            nCompra:= 0 
            WHILE !EOF() 
                nCompra:= nCompra + COMPRA 
                nVendaBruta:= nVendaBruta + VENDA_ 
                DBSkip() 
            ENDDO 
 
            /////// AQUI /////// 
            DBSelectAr( 123 ) 
            DBGoTop() 
            VPBox( 0, 0, 22, 79, "LUCRATIVIDADE", _COR_GET_EDICAO ) 
            Mensagem( "" ) 
 
            /* RESUMO DE OPERACOES */ 
            @ 16,01 Say "��� RESUMO ��" + Repl( "�", 65 ) 
 
            /* TOTAL */ 
            @ 17,01 Say "Vendas a preco de Compra:" + Tran( nCompra, "@E 999,999,999.99" ) 
            @ 18,01 Say "Venda Bruta.............:" + Tran( nVendaBruta, "@E 999,999,999.99" ) 
            @ 19,01 Say "Acrescimos/Descontos....:" + Tran( nVenda - nVendaBruta, "@E 999,999,999.99" ) 
            @ 20,01 Say "VENDAS A PRECO REAL.....:" + Tran( nVenda,  "@E 999,999,999.99" ) 
 
            @ 17,41 Say "Lucro Bruto (R$)........:" + Tran( nVenda - nCompra,  "@E 999,999.99" ) 
            @ 18,41 Say "�����������������������Ŀ" 
            @ 19,41 Say "� LUCRATIVIDADE LIQUIDA �" + Tran( ( ( nVenda - nCompra ) / nVenda ) * 100,  "@E 99999.99" ) + "%" 
            @ 20,41 Say "�������������������������" 
 
            SetColor( _COR_GET_EDICAO ) 
            oTAB:=tbrowseDB( 01, 01, 14, 78) 
            oTAB:addcolumn( tbcolumnnew( "Produto                                  Quantidade"+; 
                                   "  Compra V E N D A      %",; 
                                          {|| alltrim( INDICE ) + " " +; 
                                             LEFT( DESCRI, 34 ) +; 
                                             Tran( QUANT_, "@E 99,999.99" ) +; 
                                             Tran( COMPRA, "@e 99,999.99" ) +; 
                                             Tran( VENDA_, "@e 99,999.99" ) +; 
                                             Tran( ( ( VENDA_ - COMPRA ) / VENDA_ ) * 100, "@E 9,999.99" ) + "%" } )) 
            oTAB:AUTOLITE:=.F. 
            oTAB:dehilite() 
            WHILE .T. 
               oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
               whil nextkey()==0 .and. ! oTAB:stabilize() 
               end 
               MPR->( DBSeek( TMP->INDICE ) ) 
               @ 21,01 Say "Margem da Tabela de Precos:" + Tran( MPR->PERCPV, "@E 9999.99" ) + "%" 
               nTecla:=inkey( 0 ) 
               if nTecla==K_ESC 
                  exit 
               endif 
               do case 
                  case nTecla==K_UP         ;oTAB:up() 
                  case nTecla==K_DOWN       ;oTAB:down() 
                  case nTecla==K_LEFT       ;oTAB:left() 
                  case nTecla==K_RIGHT      ;oTAB:right() 
                  case nTecla==K_PGUP       ;oTAB:pageup() 
                  case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
                  case nTecla==K_PGDN       ;oTAB:pagedown() 
                  case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
                  case nTecla==K_TAB 
                       IF Confirma( 0, 0, "Imprimir relatorio de lucratividade?","[S]", "S" ) 
                          Relatorio( "LUCRO.REP" ) 
                          IF UPPER( LEFT( Set( 24 ), 3 ) ) <> "LPT" 
                             ViewFile( ALLTRIM( Set( 24 ) ) ) 
                             Set( 24, "LPT1" ) 
                          ENDIF 
                       ENDIF 
                       DBGoTop() 
                       oTab:RefreshAll() 
                       WHILE !oTab:Stabilize() 
                       ENDDO 
                  otherwise                ;tone(125); tone(300) 
              endcase 
              oTAB:refreshcurrent() 
              oTAB:stabilize() 
            ENDDO 
      ENDDO 
      DBSelectAr( 123 ) 
      DBCloseArea() 
      DBCloseAll() 
      AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
      ScreenRest( cTela ) 
   ENDDO 
   DBCloseAll() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 


 
 
 
/***** 
�������������Ŀ 
� Funcao      � CFPeriodo 
� Finalidade  � CUPONS FISCAIS Emitidos no periodo 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
��������������� 
*/ 
FUNCTION cfPeriodo() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nSoma1:= 0, nSoma2:= 0,; 
      nIniDia:= 1, nFimDia:= 31,; 
      nTecla, nRow:= 1, nSoma3:= 0, nSoma4:= 0, nSomaMes:= 0, aGrafico:= {} 
Local cArquivo:= "NFPESQ00.NTX" 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
 
   WHILE .T. 
      nSoma1:= 0 
      nSoma2:= 0 
      nRow:= 1 
      nSoma3:= 0 
      nSoma4:= 0 
      nSomaMes:= 0 
      aGrafico:= {} 
      aMatriz:= {} 
      aMatrizLimpa:= {} 
      nLin:= 08 
      nCol:= 11 
      VPBox( nLin, nCol, nLin + 13, nCol + 64, "RELACAO DE CUPONS FISCAIS EMITIDOS", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Ordem ���������������Ŀ" 
      @ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � � 1-Numero Cupom Fiscal �" 
      @ nLin+04, nCol + 2 Say "��������������������������������Ĵ � 2-Nome do Cliente     �" 
      @ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � � 3-Data de Emissao     �" 
      @ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
      @ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
      @ nLin+08, nCol + 2 Say "�     Periodo dentro do mes      � �                       �" 
      @ nLin+09, nCol + 2 Say "��������������������������������Ĵ �  Monitor  Impressora  �" 
      @ nLin+10, nCol + 2 Say "�       Do Dia [00] a [00]       � �                       �" 
      @ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
 
      @ nLin + 05, nCol + 08 Get dIniEmissao 
      @ nLin + 05, nCol + 24 Get dFimEmissao 
      @ nLin + 10, nCol + 17 Get nIniDia Pict "@E 99" 
      @ nLin + 10, nCol + 24 Get nFimDia Pict "@E 99" 
      READ 
 
      IF LastKey()==K_ESC 
         EXIT 
      ENDIF 
 
      /* Ordenacao */ 
      @ nLin + 03, nCol + 39 Prompt "1-Numero Cupom Fiscal" 
      @ nLin + 04, nCol + 39 Prompt "2-Nome do Cliente    " 
      @ nLin + 05, nCol + 39 Prompt "3-Data de Emissao    " 
      MENU TO nOrdem 
 
      @ nLin + 09, nCol + 40 Prompt "Monitor" 
      @ nLin + 09, nCol + 49 Prompt "Impressora" 
      MENU TO nDevice 
 
      WHILE LastKey() <> K_ESC 
            aMatriz:= { } 
            DBSelectAr( _COD_CUPOM ) 
            dIEmiss:= dIniEmissao 
            dFEmiss:= dFimEmissao 
            cArquivo:= "NFPESQ00.NTX" 
            IF nOrdem == 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON NUMERO TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ELSEIF nOrdem == 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON CDESCR TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ELSEIF nOrdem == 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
               INDEX ON DATAEM TO &cArquivo EVAL {|| Processo() } ; 
                        FOR DATAEM >= dIEmiss .AND. DATAEM <= dFEmiss .AND.; 
                            DAY( DATAEM ) >= nIniDia .AND. DAY( DATAEM ) <= nFimDia .AND.; 
                            NFNULA == " " 
            ENDIF 
            DBSetOrder( 1 ) 
            DBGoTop() 
            Mensagem( "Somando as Notas Fiscais, aguarde..." ) 
            cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
            WHILE ! EOF() 
                IF LastKey() == K_ESC 
                   EXIT 
                ENDIF 
                nSomaMes+= VlrTot 
                nSoma1+= VlrNot 
                nSoma2+= VlrTot 
                nSoma3+= VlrIcm 
                nSoma4+= VlrIpi 
                DBSkip() 
                cMesAno:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
                IF ! cMesAno == cMesAnoAnt .OR. EOF() 
                     AAdd( aGrafico, { cMesAnoAnt, nSomaMes, 0 } ) 
                     cMesAnoAnt:= StrZero( Month( DATAEM ), 2, 0 ) + StrZero( Year( DATAEM ), 4, 0 ) 
                     nSomaMes:= 0 
                ENDIF 
            ENDDO 
            DBGoTop() 
            IF nDevice == 1 
               vpbox( 00, 00, 22, 79, "CUPONS FISCAIS", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
               SetColor( _COR_BROWSE ) 
               @ 19,01 Say Repl( "�", 78 ) 
               @ 20,03 Say "Total de ICMs...:" + TRAN( nSoma3, "@R 999,999,999.99" ) 
               @ 21,03 Say "Total de IPI....:" + TRAN( nSoma4, "@R 999,999,999.99" ) 
               @ 20,43 Say "Total Cupom.....:" + TRAN( nSoma1, "@R 999,999,999.99" ) 
               @ 21,43 Say "Total...........:" + TRAN( nSoma2, "@R 999,999,999.99" ) 
               IF nOrdem == 1 
                  @ 01,02 Say "Relacao em ordem de numero de Cupom Fiscal." 
               ELSEIF nOrdem == 2 
                  @ 01,02 Say "Relacao em ordem de cliente." 
               ELSEIF nOrdem == 3 
                  @ 01,02 Say "Relacao em ordem de data de emissao." 
               ENDIF 
               Mensagem( "Pressione [G] para visualizar um grafico de comparacao mensal." ) 
               @ 01,45 Say "Periodo de " + DTOC( dIniEmissao ) + " ate " + DTOC( dFimEmissao ) + "." 
               SetColor( "W+/R" ) 
               @ 02,01 Say "  C.Fiscal   Cliente                        Dt.Emis.     Valor CF  Vlr.Total  " 
               SetColor( "W+/N" ) 
               oTAB:=tbrowseDB(03,01,18,78) 
               oTAB:addcolumn(tbcolumnnew(,{|| Tran( StrZero( NUMERO, 9, 0 ), "@R 999-999999" ) })) 
               oTab:addColumn(tbcolumnnew(,{|| Left( CDESCR, 30 ) } )) 
               oTab:addColumn(tbcolumnnew(,{|| DATAEM } )) 
               oTab:addColumn(tbcolumnnew(,{|| Tran( VLRNOT, "@e 9999,999.99" ) } )) 
               oTab:addColumn(tbcolumnnew(,{|| Tran( VLRTOT, "@e 9999,999.99" ) } )) 
               oTAB:AUTOLITE:=.f. 
               oTAB:dehilite() 
               whil .t. 
                  oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,5},{2,1}) 
                  whil nextkey()==0 .and. ! oTAB:stabilize() 
                  end 
                  nTecla:=inkey(0) 
                  if nTecla==K_ESC   ;exit   ;endif 
                  do case 
                     case nTecla==K_UP         ;oTAB:up() 
                     case nTecla==K_DOWN       ;oTAB:down() 
                     case nTecla==K_LEFT       ;oTAB:up() 
                     case nTecla==K_RIGHT      ;oTAB:down() 
                     case nTecla==K_PGUP       ;oTAB:pageup() 
                     case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
                     case nTecla==K_PGDN       ;oTAB:pagedown() 
                     case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
                     case Chr( nTecla ) $ "Gg" 
                          Grafico( aGrafico ) 
                     otherwise                ;tone(125); tone(300) 
                 endcase 
                 oTAB:refreshcurrent() 
                 oTAB:stabilize() 
               enddo 
            ELSEIF nDevice == 2 
               // Set Printer To Arquivo.Txt 
               Set Device To Print 
               nLinI:= 0 
               nMatriz4:= 0 
               nMatriz5:= 0 
               nMatriz6:= 0 
               nMatriz7:= 0 
               IF nOrdem == 1 
                  cOrdem:= "Ordem de Emissao" 
               ELSEIF nOrdem == 2 
                  cOrdem:= "Ordem de Numero da Cupom Fiscal" 
               ELSE 
                  cOrdem:= "Ordem de Nome do Cliente" 
               ENDIF 
               nPagina:= 0 
               @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "             RELACAO DE CUPONS FISCAIS EM " + DTOC( Date() ) 
               @ ++nLinI,01 Say cOrdem + "        => Cupons Fiscais de " + Alltrim( Str( nIniNf, 8, 0 ) ) + " ate " + Alltrim( Str( nFimNf, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
               @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
               @ ++nLinI,01 Say "N.Fiscal Cliente                      Dt.Emis.      Valor CF      Vlr.Total                Valor IPI                Valor ICMs" 
               @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
               DBGOTop() 
               WHILE !EOF() 
                   @ ++nLinI,01 Say StrZero( NUMERO, 10, 0 ) 
                   @ nLinI,12  Say Left( CDESCR, 30 ) 
                   @ nLinI,42  Say DATAEM 
                   @ nLinI,52  Say Tran( VLRNOT, "@e 999,999,999.99" ) 
                   @ nLinI,75  Say Tran( VLRTOT, "@e 999,999,999.99" ) 
                   @ nLinI,94  Say Tran( VLRIPI, "@e 999,999,999.99" ) 
                   @ nLinI,118 Say Tran( VLRICM, "@e 999,999,999.99" ) 
                   If nLinI >= 54 
                      nLinI:= 0 
                      @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "            RELACAO DE CUPONS FISCAIS EM " + DTOC( Date() ) 
                      @ ++nLinI,01 Say cOrdem + "        => Cupons Fiscais de " + Alltrim( Str( nIniNf, 8, 0 ) ) + " ate " + Alltrim( Str( nFimNf, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
                      @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
                      @ ++nLinI,01 Say "N.Fiscal Cliente                      Dt.Emis.      Valor NF      Vlr.Total                Valor IPI                Valor ICMs" 
                      @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
                   Endif 
                   DBSkip() 
               ENDDO 
               @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
               @ ++nLinI, 05 Say "Total de ICMs...:" + TRAN( nSoma3, "@R 999,999,999.99" ) 
               @ nLinI,   40 Say "Total Cupom.....:" + TRAN( nSoma2, "@R 999,999,999.99" ) 
               @ ++nLinI, 05 Say "Total de IPI....:" + TRAN( nSoma1, "@R 999,999,999.99" ) 
               @ nLinI,   40 Say "Total + IPI.....:" + TRAN( nSoma4, "@R 999,999,999.99" ) 
               @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
            ENDIF 
            Set Device To Screen 
            IF LastKey() <> K_ESC 
               Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
               Inkey(0) 
               Scroll( 07, 02, 21, 78 ) 
               Exit 
            ENDIF 
      ENDDO 
      ScreenRest( cTela ) 
   ENDDO 
   DBSelectAr( _COD_CUPOM ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/cupind01.ntx", "&gdir/cupind02.ntx", "&gdir/cupind03.ntx", "&gdir/cupind04.ntx", "&gdir/cupind05.ntx"      
   #else 
     Set Index To "&GDir\CUPIND01.NTX", "&GDir\CUPIND02.NTX", "&GDir\CUPIND03.NTX", "&GDir\CUPIND04.NTX", "&GDir\CUPIND05.NTX"      
   #endif
   IF File( cArquivo ) 
      FErase( cArquivo ) 
   ENDIF 
   FechaArquivos() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
   IF File( cArquivo ) 
      FErase( cArquivo ) 
   ENDIF 
   FechaArquivos() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � NFCliente 
� Finalidade  � Notas Fiscais Emitidas Por cliente 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
��������������� 
*/ 
FUNCTION NFCliente() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {},; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nRow:= 1, nTecla,; 
      nSoma1:= 0, nSoma2:= 0, cTpvenda:= "V", cDetresu := "R" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
IF !AbreGrupo( "NOTA_FISCAL" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
nLin:= 08 
nCol:= 11 
VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de Notas Fiscais Emitidos Por Cliente" ) 
@ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Tipo das Notas ������Ŀ" 
@ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � � (V)enda               �" 
@ nLin+04, nCol + 2 Say "��������������������������������Ĵ � (O)utras              �" 
@ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � � (T)odas     [ ]       �" 
@ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Tipo do Relatorio ���Ŀ" 
@ nLin+08, nCol + 2 Say "�       Codigo do Cliente        � �                       �" 
@ nLin+09, nCol + 2 Say "��������������������������������Ĵ � (D)etalhado           �" 
@ nLin+10, nCol + 2 Say "�           [9999999]            � � (R)esumido  [ ]       �" 
@ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
DBSelectAr( _COD_CLIENTE ) 
DBSetOrder( 1 ) 
dIniEmissao:= Date() 
dFimEmissao:= Date() 
@ nLin + 05, nCol + 08 Get dIniEmissao 
@ nLin + 05, nCol + 24 Get dFimEmissao 
@ nLin + 05, nCol + 51 Get cTpvenda pict "@!" valid cTpvenda $ "VOT" 
@ nLin + 10, nCol + 14 Get nIniNF Pict "@E 9999999" VALID ( nIniNf==0 .OR. BuscaCliente( @nIniNF, 2 ) ) 
@ nLin + 10, nCol + 51 Get cDetresu pict "@!"  valid cDetresu $ "DR" 
READ 
 
nFimNf:= nIniNf 
nOrdem = 3 
*@ nLin + 09, nCol + 40 Prompt "Monitor" 
*@ nLin + 09, nCol + 49 Prompt "Impressora" 
*MENU TO nDevice 
 
WHILE LastKey() <> K_ESC 
 
      aMatriz:= {} 
      aStr:= {{"CODNF_","N",08,00},; 
              {"CODCLI","N",06,00},; 
              {"SERIE_","C",01,00},; 
              {"DATAEM","D",08,00},; 
              {"NATOPE","N",06,03},; 
              {"VLRTOT","N",16,02},; 
              {"VLRICM","N",16,02} } 
      DBSelectAr( 123 ) 
      DBclosearea() 
      DBCreate( "RESERVA.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE RESERVA.TMP ALIAS RES 
 
      IF Diretorio( "TEMP" ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           index on codnf_ to temp/indres 
         #else 
           INDEX ON CODNF_ TO TEMP\INDRES 
         #endif
      ENDIF 
 
      DBSelectAr( _COD_NFISCAL ) 
      DBSetOrder( 3 ) 
      Dbseek( dIniEmissao , .t.) 
 
      WHILE ! EOF() .AND. DATAEM <= dFimEmissao 
          Mensagem( "Procesando a Nota Fiscal #" + StrZero( NUMERO, 6, 0 ) + ", aguarde..." ) 
          IF CLIENT = nIniNF 
             IF (cTpvenda == "V" .and. ( ( NF_->NATOPE >= 5.100 .AND. NF_->NATOPE <= 5.129 ) .OR. ( NF_->NATOPE >= 6.100 .AND. NF_->NATOPE <= 6.129 ) ) ).or. ; 
                (cTpvenda == "O" .and. ( ( NF_->NATOPE <  5.100 .OR.  NF_->NATOPE > 5.129 ) .AND. ( NF_->NATOPE <  6.100 .OR.  NF_->NATOPE > 6.129 ) ) ).or. ; 
                (cTpvenda == "T") 
                RES->( DBAppend() ) 
                Replace RES->CODNF_ With NF_->NUMERO,; 
                        RES->CODCLI With NF_->CLIENT,; 
                        RES->DATAEM With NF_->DATAEM,; 
                        RES->NATOPE With NF_->NATOPE,; 
                        RES->VLRTOT With NF_->VLRTOT,; 
                        RES->VLRICM With NF_->VLRICM 
                        nSoma1+= NF_->VLRTOT 
                        nSoma2+= NF_->VLRICM 
             endif 
          ENDIF 
          DBSkip() 
          IF Inkey() == K_ESC 
             Exit 
          ENDIF 
      ENDDO 
      IF cDetresu == "R" 
         DBselectar( "RES" ) 
         DBgotop() 
         ccab := "Data       N.Fiscal   Nat.Oper.    Vlr.Nota        Vlr.ICMS " 
*         12.11.12   123456     1.123      999,999.99      999,999.99 
         cdados := { || dtoc(DATAEM)+"   "+strzero(CODNF_,6)+"     "+transf(NATOPE, "@r 9.999")+"      "+ ; 
                   transf( VLRTOT,"@e 999,999.99")+"      "+transf( VLRICM,"@e 999,999.99") } 
         @ 20, 14 Say "TOTAL DO CLIENTE NO PERIODO:       " + Tran( nSoma1, "@E 999,999.99" ) + "    "+Tran( nSoma2, "@E 999,999.99" ) 
         nTecla := Nil 
         Mensagem("Pressione [ESC] para retornar.") 
         do while nTecla <> K_ESC 
            //CLI->( DBSeek( RES->CODCLI ) ) 
            //@ 1,0 SAY CLI->DESCRI 
            Browse(05,11,19,76,ccab,cdados,trim(CLI->DESCRI),@Ntecla, .f.) 
         enddo 
      endif 
      IF cDetresu == "D" 
         DBselectar( "RES" ) 
         DBgotop() 
         aMatriz:= {} 
         Aadd( aStr,{"LINHA" ,"C",80,00} ) 
         DBSelectAr( 125 ) 
         DBclosearea() 
         DBCreate( "TEXTO.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         USE TEXTO.TMP ALIAS RES2 
         DBSelectAr( "PNF" ) 
         DBsetorder( 5 ) 
         dbSelectar( "RES" ) 
         DbgoTOP() 
         do while .not. eof() 
            mlin := dtoc(DATAEM)+"   Nota: "+strzero(CODNF_,6)+"     "+transf(NATOPE, "@r 9.999") 
            RES2->( DBAppend() ) 
            replace RES2->LINHA with mlin 
            PNF->( dbseek( RES->CODNF_ ) ) 
            do while !PNF->( eof() ) .and. PNF->CODNF_ = RES->CODNF_ 
               mlin := transf( PNF->CODIGO, "@R 999-9999" )+" "+subst(  PNF->DESCRI, 1, 43 ) + ; 
                      transf( PNF->PRECOV, "@E 9999.99" )+" "+transf( PNF->QUANT_, "99999.99" )+ ; 
                      transf( PNF->PRECOT, "@E 999,999.99" ) 
               RES2->( DBAppend() ) 
               replace RES2->LINHA with mlin 
               PNF->( DBskip() ) 
            enddo 
            RES2->( DBAppend() ) 
            replace RES2->LINHA with space(68)+"----------" 
            RES2->( DBAppend() ) 
            replace RES2->LINHA with space(37)+"Valor Liquido da Nota Fiscal: "+transf(RES->VLRTOT, "@E 9999,999.99") 
            RES2->( DBAppend() ) 
            skip 
         enddo 
         RES2->( DBAppend() ) 
         replace RES2->LINHA with "TOTAL DO CLIENTE NO PERIODO: "+Tran( nSoma1, "@E 9999,999.99" ) 
*122-2222 123456789.123456789.123456789.123456789.123 9999.99 99999.99 999,999.99 
*12/12/12  123456   5.123 
         DBselectar( "RES2" ) 
         DBgotop() 
         ccab := "Codigo   Produto                                   Vl.Unit. Quantid. Sub-Total" 
         cdados := { || LINHA } 
         nTecla := Nil 
         Mensagem("Pressione [ESC] para retornar ou [TAB] para imprimir.") 
         do while nTecla <> K_ESC 
            Browse(00,00,22,79,ccab,cdados,trim(CLI->DESCRI),@Ntecla, .f.) 
            do case 
               case nTECLA==K_TAB 
                  IF Confirma( 0, 0, "Confirma a Impressao do Relatorio?","[S]", "S" ) 
                     Relatorio( "NFCLIENT.REP" ) 
                  endif 
            endcase 
         enddo 
      endif 
      Set Device To Screen 
      IF LastKey() <> K_ESC 
         Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
         Inkey(0) 
         Scroll( 07, 02, 21, 78 ) 
         Exit 
      ENDIF 
 
ENDDO 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � CFCliente 
� Finalidade  � Cupons Fiscais Emitidas Por cliente 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
��������������� 
*/ 
FUNCTION CFCliente() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local aMatriz:= {}, aMatrizLimpa:= {}, dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nRow:= 1, nTecla,; 
      nSoma1:= 0, nSoma2:= 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
nLin:= 08 
nCol:= 11 
VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de Cupons Fiscais Emitidas Por Cliente" ) 
@ nLin+02, nCol + 2 Say "��������������������������������Ŀ � Ordem ���������������Ŀ" 
@ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � �                       �" 
@ nLin+04, nCol + 2 Say "��������������������������������Ĵ �     Nome do Cliente   �" 
@ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � �                       �" 
@ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
@ nLin+08, nCol + 2 Say "�       Codigo do Cliente        � �                       �" 
@ nLin+09, nCol + 2 Say "��������������������������������Ĵ �  Monitor  Impressora  �" 
@ nLin+10, nCol + 2 Say "�  [12345678]  At�:  [12345678]  � �                       �" 
@ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin + 05, nCol + 08 Get dIniEmissao14 
@ nLin + 05, nCol + 24 Get dFimEmissao 
DBSelectAr( _COD_CLIENTE ) 
DBSetOrder( 1 ) 
@ nLin + 10, nCol + 05 Get nIniNF Pict "@E 99999999" VALID ( nIniNf==0 .OR. BuscaCliente( @nIniNF, 2 ) ) 
@ nLin + 10, nCol + 23 Get nFimNF Pict "@E 99999999" VALID ( (nFimNf==0 .or. nFimNf==99999999) .OR. BuscaCliente( @nFimNF, 2 ) ) 
READ 
* nFimNf:= nIniNf 
nOrdem = 3 
@ nLin + 09, nCol + 40 Prompt "Monitor" 
@ nLin + 09, nCol + 49 Prompt "Impressora" 
MENU TO nDevice 
WHILE LastKey() <> K_ESC 
      aMatriz:= { } 
      DBSelectAr( _COD_CUPOM ) 
      DBSetOrder( nOrdem ) 
      DBGoTop() 
 
      WHILE ! EOF() 
          IF DATAEM >= dIniEmissao .AND. DATAEM <= dFimEmissao .AND.; 
             CLIENT >= nIniNF .AND. CLIENT <= nFimNF .AND. NFNULA == " " 
             AAdd( aMatriz, { NUMERO, CDESCR, DATAEM, VLRNOT, VLRTOT, VLRIPI, VLRICM } ) 
             nSoma1+= VlrNot 
             nSoma2+= VlrTot 
          ENDIF 
          Mensagem( "Procesando Cupom Fiscal #" + StrZero( NUMERO, 6, 0 ) + ", aguarde..." ) 
          DBSkip() 
          IF Inkey() == K_ESC 
             Exit 
          ENDIF 
      ENDDO 
      IF nDevice == 1 
         AAdd( aMatriz, { 0, "���������������������������������������", "���������", 0, 0, 0, 0 } ) 
         AAdd( aMatriz, { 0, "TOTAL GERAL                            ", DATE(), nSoma1, nSoma2, 0, 0 } ) 
         vpbox(0,0,22,79,"CUPONS FISCAIS",COR[20],.T.,.T.,COR[19]) 
         @ 01,01 Say "Per�odo de: " + DTOC( dIniEmissao ) + " At� " + DTOC( dFimEmissao ) 
         @ 01,55 Say "Cliente n� " + StrZero( nIniNF, 6, 0 ) 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "N.Fiscal Cliente                        Dt.Emis.     Valor NF      Vlr.Total  " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowsenew(03,01,21,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 1 ], 6, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| Left( aMatriz[ nRow ][ 2 ], 30 ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 3 ] } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 4 ], "@e 99,999,999.99" ) } )) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 5 ], "@e 99,999,999.99" ) } )) 
         oTAB:AUTOLITE:=.f. 
         oTAB:GOTOPBLOCK :={|| nROW:=1} 
         oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aMatriz )} 
         oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nROW ) } 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,5},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ELSEIF nDevice == 2 
             DBSelectAr( _COD_CUPOMAUX ) 
             DBSetOrder( 5 ) 
 
             DBSelectAr( _COD_CUPOM )       // gelson 
             DBSetOrder( 1 ) 
 
         // Set Printer To Arquivo.Txt 
         Set Device To Print 
         nLinI:= 0 
         nMatriz4:= 0 
         nMatriz5:= 0 
         nMatriz6:= 0 
         nMatriz7:= 0 
nTotal  :=0 
nTotno  :=0 
         IF nOrdem == 1 
            cOrdem:= "Ordem de Emissao" 
         ELSEIF nOrdem == 2 
            cOrdem:= "Ordem de Numero da Cupom Fiscal" 
         ELSE 
            cOrdem:= "Ordem de Nome do Cliente" 
         ENDIF 
         nPagina:= 0 
             SelecaoImpressora( .T. ) 
             @ Prow(), 01 Say Condensado( .T. ) 
         @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "            RELACAO DE CUPONS FISCAIS EM " + DTOC( Date() ) 
         @ ++nLinI,01 Say cOrdem + "   =>  Cupons Fiscais de " + Alltrim( Str( nIniNf, 8, 0 ) ) + " ate " + Alltrim( Str( nFimNf, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
             @ Prow(), 01 Say Negrito( .T. ) // GELSON 
         @ ++nLinI,01 Say "N.Fiscal Cliente                      Dt.Emis.       Valor NF              Vlr.Total          Valor IPI                  Valor ICMs" 
             @ Prow(), 01 Say Negrito( .F. ) // GELSON 
         @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
         For nCt:= 1 TO LEN( aMatriz ) 
             @ Prow(), 01 Say Negrito( .T. ) // GELSON 
 
             @ ++nLinI,01 Say StrZero( aMatriz[ nCt ][ 1 ], 6, 0 ) 
             @ nLinI,08  Say Left( aMatriz[ nCt ][ 2 ], 30 ) 
             @ nLinI,38  Say aMatriz[ nCt ][ 3 ] 
             @ nLinI,48  Say Tran( aMatriz[ nCt ][ 4 ], "@e 999,999,999.99" ) 
             @ nLinI,71  Say Tran( aMatriz[ nCt ][ 5 ], "@e 999,999,999.99" ) 
             @ nLinI,90  Say Tran( aMatriz[ nCt ][ 6 ], "@e 999,999,999.99" ) 
             @ nLinI,118 Say Tran( aMatriz[ nCt ][ 7 ], "@e 999,999,999.99" ) 
 
             @ Prow(), 01 Say Negrito( .F. )  // GELSON 
     // APRESENTA PRODUTOS DO CUPOM // GELSON 23.07.2002 
     CAU->(DBSeek(aMatriz[ nCt ][ 1 ])) 
     nLinI++ 
     @ nLinI++,52 say "--------------------------------------------------------------------------------" 
     @ nLinI++,52 say "Produto                                                 Qtd   Vl.Unit.  Vl.Total" 
     @ nLinI++,52 say "--------------------------------------------------------------------------------" 
     Do While aMatriz[ nCt ][ 1 ]=CAU->CODNF_ 
           cpro    := transf( CAU->CODIGO, "@R 999-9999" ) 
           cNompro := subst( CAU->DESCRI, 1, 45 ) 
           nQtd := transf( CAU->QUANT_, "999999.99" ) 
           nVal := transf( CAU->PRECOV, "@E 999,999.99" ) 
           nTotp := transf( CAU->PRECOT, "@E 999,999.99" ) 
           nTotal  := nTotal + CAU->PRECOT 
           nTotno  := nTotno + CAU->PRECOT 
           @ nLinI,52 say cPro 
           @ nLinI,62 say cNompro 
           @ nLinI,102 say nQtd 
           @ nLinI,112 say nVal 
           @ nLinI++,122 say nTotp 
           CAU->(DBSkip()) 
     EndDo 
     @ nLinI++,52 say "--------------------------------------------------------------------------------" 
             If nLinI >= 54 
                nLinI:= 0 
                @ ++nLinI,01 Say "Pagina: " + StrZero( ++nPagina, 4, 0 ) + "            RELACAO DE CUPONS FISCAIS EM " + DTOC( Date() ) 
                @ ++nLinI,01 Say cOrdem + "       =>  Cupons Fiscais de " + Alltrim( Str( nIniNf, 8, 0 ) ) + " ate " + Alltrim( Str( nFimNf, 8, 0 ) ) + " emitidas no periodo de " + DTOC( dIniEmissao ) + " a " + DTOC( dFimEmissao ) + "." 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
                @ ++nLinI,01 Say "N.Fiscal Cliente                      Dt.Emis.       Valor NF              Vlr.Total          Valor IPI                  Valor ICMs" 
                @ ++nLinI,01 Say "*" + Repl( "-", 130 ) + "*" 
             Endif 
             nMatriz4:= nMatriz4 + aMatriz[ nCt ][ 4 ] 
             nMatriz5:= nMatriz5 + aMatriz[ nCt ][ 5 ] 
             nMatriz6:= nMatriz6 + aMatriz[ nCt ][ 6 ] 
             nMatriz7:= nMatriz7 + aMatriz[ nCt ][ 7 ] 
         Next 
         @ ++nLinI, 01 Say "*" + Repl( "=", 130 ) + "*" 
             @ Prow(), 01 Say Negrito( .T. ) // GELSON 
         @ ++nLinI, 01 Say "SOMA:" 
         @ nLinI,48  Say Tran( nmatriz4, "@e 999,999,999.99" ) 
         @ nLinI,71  Say Tran( nMatriz5, "@e 999,999,999.99" ) 
         @ nLinI,90  Say Tran( nMatriz6, "@e 999,999,999.99" ) 
         @ nLinI,118 Say Tran( nMatriz7, "@e 999,999,999.99" ) 
             @ Prow(), 01 Say Condensado( .F. ) 
             @ Prow(), 01 Say Negrito( .F. ) 
             Eject 
      ENDIF 
      Set Device To Screen 
      IF LastKey() <> K_ESC 
         Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
         Inkey(0) 
         Scroll( 07, 02, 21, 78 ) 
         Exit 
      ENDIF 
 
ENDDO 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � NFPRODUTOS 
� Finalidade  � Notas Fiscais Emitidas Por cliente 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 12/Junho/1997 
��������������� 
*/ 
Static Function NFProdutos() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodCli:= 0, cCodigo:= "0000", cGrupo_:= "000" 
Local bBlock 
Local aMatriz:= {}, aMatrizLimpa:= {},; 
      dIniEmissao:= Date(), dFimEmissao:= Date(),; 
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, aEstrutura:= {},; 
      oTab, nTecla, cDescri, cTelaRes 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      UserScreen() 
 
      IF !AbreGrupo( "NOTA_FISCAL" ) 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ENDIF 
 
      DBSelectAR( 123 ) 
      DBCloseArea() 
 
      /* Exclusao do arquivo RESERVA1.TMP */ 
      IF File( "RESERVA1.TMP" ) 
         FErase( "RESERVA1.TMP" ) 
      ENDIF 
 
      aEstrutura:= { {"CODIGO","C", 12,00},; 
                     {"ORIGEM","C", 03,00},; 
                     {"DESCRI","C", 40,00},; 
                     {"QUANT_","N", 15,04},; 
                     {"UNIDAD","C", 02,00},; 
                     {"VENDAS","N", 15,00} } 
 
      DBCREATE( "RESERVA1.TMP", aEstrutura ) 
 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE RESERVA1.TMP ALIAS RES1 EXCLUSIVE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON CODIGO TO INDICE01.TMP Eval {|| Processo() } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON DESCRI TO INDICE02.TMP Eval {|| Processo() } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      INDEX ON ORIGEM TO INDICE03.TMP Eval {|| Processo() } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      SET INDEX TO INDICE01.TMP, INDICE02.TMP, INDICE03.TMP 
      DBSetOrder( 1 ) 
 
      nLin:= 08 
      nCol:= 11 
      VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de Vendas de Produtos" ) 
      @ nLin+02, nCol + 2 Say "�� Utilizacao ��������������������������������������������Ŀ" 
      @ nLin+03, nCol + 2 Say "�  Esta rotina emite uma listagem de todos os  produtos  e �" 
      @ nLin+04, nCol + 2 Say "�  as respectivas saidas de cada um deles, fazendo um com- �" 
      @ nLin+05, nCol + 2 Say "�  parativo entre os mesmos.                               �" 
      @ nLin+06, nCol + 2 Say "������������������������������������������������������������" 
      @ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
      @ nLin+08, nCol + 2 Say "�      Periodo de Emissao        � �                       �" 
      @ nLin+09, nCol + 2 Say "��������������������������������Ĵ �        Monitor        �" 
      @ nLin+10, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � �                       �" 
      @ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
 
      @ nLin + 10, nCol + 08 Get dIniEmissao 
      @ nLin + 10, nCol + 24 Get dFimEmissao 
      READ 
      IF LastKey()==K_ESC 
         ScreenRest( cTela ) 
         SetColor( cCor ) 
         Return Nil 
      ENDIF 
 
      aMatriz:= { } 
      DBSelectAr( _COD_NFISCAL ) 
      DBSetOrder( 1 ) 
 
      DBSelectAr( _COD_PRODNF ) 
      DBSetOrder( 3 ) 
      Set Relation To CODNF_ Into NF_ 
      DBGoTop() 
 
      Sele 123 
      DbSetOrder( 1 ) 
 
      nTotal:= 0 
      cVelhoCodigo:= "" 
      WHILE ! PNF->( EOF() ) 
          @ nLin + 12 , nCol + 2 SAY PNF->DESCRI 
          IF NF_->DATAEM >= dIniEmissao .AND. NF_->DATAEM <= dFimEmissao .AND.; 
             NF_->NFNULA==" " .AND.; 
                  ( ( NF_->NATOPE >= 5.11  .AND. NF_->NATOPE <= 5.129 ) .OR.; 
                    ( NF_->NATOPE >= 5.100 .AND. NF_->NATOPE <= 5.102 ) .OR.; 
                    ( NF_->NATOPE >= 6.12  .AND. NF_->NATOPE <= 6.129 ) .OR.; 
                    ( NF_->NATOPE >= 6.100 .AND. NF_->NATOPE <= 6.102 ) .OR. NF_->NATOPE=0.00 ) 
 
             IF !( PNF->( CODRED ) == cVelhoCodigo ) 
                Mensagem( "Gravando produto " + Tran( PNF->CODRED, "@R 999-9999" ) + ", aguarde..." ) 
                MPR->( DBSetOrder( 1 ) ) 
                MPR->( DBSeek( PNF->CODRED ) ) 
                DBAppend() 
                Replace CODIGO With PNF->CODRED,; 
                        DESCRI With PNF->DESCRI,; 
                        QUANT_ With PNF->QUANT_,; 
                        VENDAS With 1,; 
                        UNIDAD With UPPER( PNF->UNIDAD ),; 
                        ORIGEM With MPR->ORIGEM 
                IF AllTrim( CODIGO ) == "0000000" 
                   Replace DESCRI With "<< NAO CODIFICADOS >>" 
                ENDIF 
                nTotal:= nTotal + PNF->QUANT_ 
                cVelhoCodigo:= PNF->CODRED 
             ELSE 
                Replace VENDAS With VENDAS + 1,; 
                        QUANT_ With QUANT_ + PNF->QUANT_ 
                nTotal:= nTotal + PNF->QUANT_ 
             ENDIF 
          ENDIF 
          PNF->( DBSkip() ) 
      ENDDO 
      DBGoTop() 
 
      /* CUPONS FISCAIS EMITIDOS POR PERIODO */ 
      aMatriz:= {} 
      DBSelectAr( _COD_CUPOM ) 
      DBSetOrder( 1 ) 
 
      DBSelectAr( _COD_CUPOMAUX ) 
      DBSetOrder( 3 ) 
      Set Relation To CODNF_ Into CUP 
      DBGoTop() 
 
      Sele 123 
      DbSetOrder( 1 ) 
 
      WHILE ! CAU->( EOF() ) 
          @ nLin + 12 , nCol + 2 SAY CAU->DESCRI 
          IF CUP->DATAEM >= dIniEmissao .AND. CUP->DATAEM <= dFimEmissao .AND. CUP->NFNULA==" " .AND.; 
             ( ( CUP->NATOPE >= 5.110 .AND. CUP->NATOPE <= 5.129 ) .OR. ( CUP->NATOPE >= 6.110 .AND. CUP->NATOPE <= 6.129 ) ) 
             IF !RES1->( DBSeek( CAU->CODRED  ) ) 
                Mensagem( "Gravando produto " + Tran( CAU->CODIGO, "@R 999-9999" ) + ", aguarde..." ) 
                MPR->( DBSetOrder( 1 ) ) 
                MPR->( DBSeek( CAU->CODRED ) ) 
                DBAppend() 
                Replace CODIGO With CAU->CODRED,; 
                        DESCRI With CAU->DESCRI,; 
                        QUANT_ With CAU->QUANT_,; 
                        VENDAS With 1,; 
                        UNIDAD With UPPER( CAU->UNIDAD ),; 
                        ORIGEM With MPR->ORIGEM 
                IF AllTrim( CODIGO ) == "0000000" 
                   Replace DESCRI With "<< NAO CODIFICADOS >>" 
                ENDIF 
                nTotal:= nTotal + CAU->QUANT_ 
             ELSE 
                Replace VENDAS With VENDAS + 1,; 
                        QUANT_ With QUANT_ + CAU->QUANT_ 
                nTotal:= nTotal + CAU->QUANT_ 
             ENDIF 
          ENDIF 
          CAU->( DBSkip() ) 
      ENDDO 
      DBGoTop() 
 
      /* Estatistica */ 
      nLin:= 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Index On QUANT_ To INDICE Eval {|| Processo() } DESCENDING 
      DBGoTop() 
 
      VPBox( 00, 00, 22, 79, "GRAFICO DOS 10 PRODUTOS DE MAIOR ROTATIVIDADE", _COR_GET_BOX ) 
      nCor:= 1 
      nCt:= 0 
      nBase:= 50 
 
      nCalculo:= ( ( QUANT_ / nTotal ) * 100 ) / 2 
      nMulti:= 40 / nCalculo 
 
      WHILE !EOF() .AND. nCt < 10 
         SetColor( _COR_GET_EDICAO ) 
         cCorFundo:= CorFundoAtual() 
 
         ++nCt 
         nCalculo:= ( QUANT_ / nTotal ) * 100 
         @ nLin+=2,70 Say Tran( nCalculo, "@E 99.99" ) + "%" 
         @ nLin, 01 Say IF( ALLTRIM( CODIGO ) == "0000000", "<< NAO CODIFICADOS >>", Left( DESCRI, 25 ) ) 
         SetColor( StrZero( ++nCor, 2, 0 ) ) 
         nPosicoes:= nCalculo / 2 
         @ nLin, 28 Say Repl( "�", nPosicoes * nMulti ) 
         SetColor( "N/" + cCorFundo ) 
         @ nLin+1, 29 Say Repl( "�", nPosicoes * nMulti ) 
         @ nLin, 28 + nPosicoes * nMulti Say "�" 
         DBSkip() 
 
      ENDDO 
 
      Mensagem( "Pressione [ENTER] para continuar." ) 
      Pausa() 
 
      DBSelectAr( "RES1" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Set index To INDICE, INDICE01.TMP, INDICE02.TMP, INDICE03.TMP 
      VPBox( 03, 03, 20, 75, "RELACAO DE QUANTIDADES VENDIDAS", _COR_BROW_BOX, .T., .F., _COR_BROW_TITULO ) 
 
      Mensagem( "Pressione [TAB] para imprimir relacao" ) 
      Ajuda( "[F2..F5]Ordem" ) 
      SetColor( _COR_BROWSE ) 
 
      /*========================================================== 
         BROWSE 
      -----------------------------------------------------------*/ 
 
      bBlock:= {|| Tran( CODIGO, "@r XXX-XXXX" ) + " " + ; 
                   DESCRI + " " + ; 
                   ORIGEM + " " + ; 
                   UNIDAD + " " + ; 
                   StrZero( VENDAS, 7, 0 ) + " "+ ; 
                   tran( QUANT_, "@E 999,999.99") + " " +; 
                   UNIDAD } 
 
      nTecla:= Nil 
      WHILE !( nTecla==K_ESC ) 
           oTab:= Browse( 00, 00, 22, 79, Nil, bBlock, "RELACAO DE PRODUTOS & VENDAS EM QUANTIDADE", @nTecla , .F. ) 
           DO CASE 
              CASE nTecla==K_F2 ;DBMudaOrdem( 3, oTab ) 
              CASE nTecla==K_F3 ;DBMudaOrdem( 2, oTab ) 
              CASE nTecla==K_F4 ;DBMudaOrdem( 1, oTab ) 
              CASE nTecla==K_F5 ;DBMudaOrdem( 4, oTab ) 
              CASE DBPesquisa( nTecla, oTab ) 
              CASE nTecla==K_TAB 
                   cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                   VPBox( 5, 5, 12, 69, "FILTRO", _COR_GET_BOX ) 
                   nQuant1:= 0 
                   nQuant2:= 99999999 
                   SetColor( _COR_GET_EDICAO ) 
                   @ 07,08 Say "Com Quantidade acima de" Get nQuant1 Pict "99999999" 
                   @ 08,08 Say "            e abaixo de" Get nQuant2 Pict "99999999" 
                   READ 
                   ScreenRest( cTelaRes ) 
                   SetColor( _COR_BROWSE ) 
                   nReg:= RECNO() 
                   IF Confirma( 0, 0, "Confirma a impressao deste relatorio?", "[ENTER]Confirma", "S" ) 
                      Set Filter To QUANT_ >= nQuant1 .AND. QUANT_ <= nQuant2 
                      DBGoTop() 
                      Relatorio( "RELMPRO.REP" ) 
                      Set Filter To 
                   ENDIF 
                   DBGoTo( nReg ) 
           ENDCASE 
      ENDDO 
 
      DBSelectAr( _COD_PRODNF ) 
      DBSetOrder( 3 ) 
      Set Relation To 
      Sele 123 
      FechaArea() 
      FechaArquivos() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
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
   LOCAL cGrupo_:= GetList[ 2 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
 
   /* Testa se grupo + codigo esta com zeros */ 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      Return( .T. ) 
   EndIf 
 
   /* Pesquisa produto na base de dados */ 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Aguarde a montagem da lista..." ) 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[2]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[3]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   @ 05,29 Say Space( 43 ) 
   @ 05,29 Say Alltrim( MPr->Descri ) 
   SetColor( "15/03" ) 
   @ 06,45 Say " Codigo fabrica -> " + Mpr->CodFab + " " 
   SetColor( cCor ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � VerGrupo2 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerGrupo2( cGrupo_, cCodigo ) 
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
� Funcao      � VerCodigo2 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerCodigo2( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 3 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
 
   /* Testa se grupo + codigo esta com zeros */ 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      Return( .T. ) 
   EndIf 
 
   /* Pesquisa produto na base de dados */ 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Aguarde a montagem da lista..." ) 
      VisualProdutos( cGrupo_ + cCodigo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[3]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[4]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   @ 05,29 Say Space( 42 ) 
   @ 05,29 Say Alltrim( MPr->Descri ) 
   SetColor( "15/03" ) 
   @ 06,45 Say " Codigo fabrica -> " + Mpr->CodFab + " " 
   SetColor( cCor ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � FAZER APRESENTACAO DO CLIENTE PARA A ROTINA NFBUSCA 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
  Static Function BuscaCliente( nCodigo, nCod ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  PesqCli( @nCodigo ) 
  If nCodigo <= 0 
     Return .F. 
  Endif 
  IF nCod==1 
     @ 03,29 Say CLI->DESCRI 
  ELSE 
     @ 20,15 Say Cli->DESCRI 
  ENDIF 
  Return .T. 


/*****
�������������Ŀ 
� Funcao      � VendEstoq
� Finalidade  � Levantamento de Vendas X Estoque
� Retorno     � Nil
� Programador � Gelson Oliveira
� Data        � 18/Out/2004
��������������� 
*/ 
FUNCTION VendEstoq()
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 )

Local cCodigo:= "0000", cGrupoI:= "000", cGrupoF:= "999", cFabric:= "   "
 
Local aMatriz:= {}, aMatrizLimpa:= {}, nTecla, cAgrup:= "F",;
      nIniNF:= 0, nFimNF:= 99999999, nOrdem:= 1, nDevice:= 1, nRow:= 1,;
      nSoma1:= 0, nSoma2:= 0, cTpvenda:= "V", cDetresu := "R", aCursor[4], nC:=1

dIniEmissao:= Date()
dFimEmissao:= Date() 

// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
IF !AbreGrupo( "NOTA_FISCAL" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF
 
nLin:= 08 
nCol:= 11 
VPBox( nLin, nCol, nLin + 13, nCol + 64, "Mapa de Vendas X Fabricantes" )
@ nLin+02, nCol + 2 Say "��������������������������������Ŀ �����������������������Ŀ"
@ nLin+03, nCol + 2 Say "�        Periodo de Emissao      � � Agrupado por: [ ]     �"
@ nLin+04, nCol + 2 Say "��������������������������������Ĵ �����������������������Ĵ"
@ nLin+05, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � � [G]rupo  [F]abricante �"
@ nLin+06, nCol + 2 Say "���������������������������������� �������������������������" 
@ nLin+07, nCol + 2 Say "��������������������������������Ŀ �����������������������Ŀ"
@ nLin+08, nCol + 2 Say "� Grupo..:  de [000]  ate [999]  � �         Saida         �"
@ nLin+09, nCol + 2 Say "��������������������������������Ĵ �����������������������Ĵ"
@ nLin+10, nCol + 2 Say "� Fabricante:  [   ]             � �        MONITOR        �"
@ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
// ???? DBSelectAr( _COD_CLIENTE )
// ???? DBSetOrder( 1 )
@ nLin + 05, nCol + 08 Get dIniEmissao
@ nLin + 05, nCol + 24 Get dFimEmissao
@ nLin + 08, nCol + 17 Get cGrupoI Pict "999"
@ nLin + 08, nCol + 28 Get cGrupoF Pict "999"
@ nLin + 10, nCol + 17 Get cFabric pict "!!!"
@ nLin + 03, nCol + 53 Get cAgrup  pict "!" Valid cAgrup$"GF"
READ 

aCursor[1]:="-"
aCursor[2]:="\"
aCursor[3]:="|"
aCursor[4]:="/"

nFimNf:= nIniNf 
nOrdem = 3 
*@ nLin + 09, nCol + 40 Prompt "Monitor" 
*@ nLin + 09, nCol + 49 Prompt "Impressora" 
*MENU TO nDevice 
 
WHILE LastKey() <> K_ESC 
 
//      aMatriz:= {}
      aStr:= {{"CODRED","C",12,00},;
              {"DESCRI","C",30,00},;
              {"QUANT_","N",12,03},;
              {"PRECOT","N",18,04},;
              {"PRECOC","N",18,04},;
              {"DATA__","D",08,00},;
              {"MARCA_","C",30,00},;
              {"GRUPO_","C",30,00},;
              {"ESTPC_","N",12,03},;
              {"ESTVL_","N",18,04},;
              {"FABRIC","C",03,00},;
              {"ORIGEM","C",03,00} }      // gelson
      DBSelectAr( 123 ) 
      DBclosearea() 
      DBCreate( "RESERVA.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE RESERVA.TMP ALIAS RES 
      index on left( codred, 3 )+origem to indres
//    Use reserva.tmp Index indres Alias RES
 
      MPR->( DBSetOrder( 1 ) )
      ORG->( DBSetOrder( 3 ) )
      GR0->( DBSetOrder( 1 ) )

      CAU->( DBSetOrder( 4 ) )
      CAU->( Dbseek( dIniEmissao, .t.) )
      WHILE !CAU->( EOF() ) .AND. CAU->DATA__<=dFimEmissao
          nC++
          nC:= If( nC=5, 1, nC )

          Mensagem( "Procesando o Dia #" + DtoC( CAU->DATA__ ) + ", aguarde... "+aCursor[nC] )
          MPR->( DBSeek( CAU->CODRED ) )
          GR0->( DBSeek( Left( CAU->CODRED, 3 ) ) )
          ORG->( DBSeek( MPR->ORIGEM ) )
          IF Left( CAU->CODRED, 3 )>=cGrupoI .And.;
             Left( CAU->CODRED, 3 )<=cGrupoF .And.;
             If( !Empty( cFabric ), MPR->ORIGEM=cFabric, .T. )
             RES->( DBSeek( Left( CAU->CODRED, 3 )+MPR->ORIGEM, .f. ) )
             If !RES->( Found() )
                RES->( DBAppend() )
                REPL RES->CODRED With CAU->CODRED
                REPL RES->DESCRI With CAU->DESCRI
                REPL RES->QUANT_ With CAU->QUANT_
                REPL RES->PRECOT With CAU->PRECOT
                REPL RES->DATA__ With CAU->DATA__
                REPL RES->MARCA_ With ORG->DESCRI
                REPL RES->GRUPO_ With GR0->DESCRI
                REPL RES->ESTPC_ With RES->ESTPC_+MPR->SALDO_
                REPL RES->ESTVL_ With RES->ESTVL_+( MPR->SALDO_*MPR->PRECOV )
                REPL RES->ORIGEM With MPR->ORIGEM
                REPL RES->FABRIC With cFabric
                REPL RES->PRECOC With ( ( 100*MPR->PRECOV )/;
                                      ( 100+MPR->PERCPV ) )*CAU->QUANT_
                PrecoNaData( CAU->CODRED, CAU->DATA__ )
             Else
                REPL RES->CODRED With CAU->CODRED
                REPL RES->DESCRI With CAU->DESCRI
                REPL RES->QUANT_ With RES->QUANT_+CAU->QUANT_
                REPL RES->PRECOT With RES->PRECOT+CAU->PRECOT
                REPL RES->DATA__ With CAU->DATA__
                REPL RES->MARCA_ With ORG->DESCRI
                REPL RES->GRUPO_ With GR0->DESCRI
/*
                If RES->CODRED<>CAU->CODRED
                   REPL RES->ESTPC_ With RES->ESTPC_+MPR->SALDO_
                   REPL RES->ESTVL_ With RES->ESTVL_+( MPR->SALDO_*MPR->PRECOV )
                EndIf
*/
                REPL RES->ORIGEM With MPR->ORIGEM
                REPL RES->FABRIC With cFabric
                REPL RES->PRECOC With RES->PRECOC+( ( ( 100*MPR->PRECOV )/;
                                      ( 100+MPR->PERCPV ) )*CAU->QUANT_ )
             EndIf
          ENDIF 
          CAU->( DBSkip() )
          IF Inkey() == K_ESC 
             Exit 
          ENDIF 
      ENDDO 

      RES->( DBGoTop() )
      While !RES->( Eof() )
         nSaldo:= nValor:= 0
         SaldoGrupo( Left( RES->CODRED, 3 ), RES->FABRIC, @nSaldo, @nValor )
         Repl RES->ESTPC_ With nSaldo
         Repl RES->ESTVL_ With nValor
         RES->( DBSkip() )
      EndDo

      If cAgrup="F"
         Relatorio( "gVenEst.rep" )
      Else
         Relatorio( "gVenEst1.rep" )
      EndIf

      Set Device To Screen 
      IF LastKey() <> K_ESC 
         Mensagem( "Fim da Pesquisa. Pressione [ENTER] para sair...", 1 ) 
//         Inkey(0)
         Scroll( 07, 02, 21, 78 ) 
         Exit 
      ENDIF 
 
ENDDO 
FechaArquivos() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil


Static Function PrecoMedio()
Local nSoma:= 0
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(), nCursor:= SetCursor()
Local nPreco:= 0, nTotalVenda, nPercentual:= 0
Local dIniEmissao:= DATE(), dFimEmissao:= DATE()
Local nUltimo:= 0
      nLin:= 08
      nCol:= 11 
      VPBox( nLin, nCol, nLin + 13, nCol + 64, "Relacao de Vendas ( Preco Medio x Cupom )" ) 
      @ nLin+02, nCol + 2 Say "�� Utilizacao ��������������������������������������������Ŀ" 
      @ nLin+03, nCol + 2 Say "�  Esta rotina emite uma listagem de todos os  produtos  e �" 
      @ nLin+04, nCol + 2 Say "�  as respectivas saidas de cada um deles, fazendo um com- �" 
      @ nLin+05, nCol + 2 Say "�  parativo de preco medio de venda entre os mesmos.       �" 
      @ nLin+06, nCol + 2 Say "������������������������������������������������������������" 
      @ nLin+07, nCol + 2 Say "��������������������������������Ŀ � Saida ���������������Ŀ" 
      @ nLin+08, nCol + 2 Say "�      Periodo de Emissao        � �                       �" 
      @ nLin+09, nCol + 2 Say "��������������������������������Ĵ �        Monitor        �" 
      @ nLin+10, nCol + 2 Say "� De: [DD/MM/AA] At�: [DD/MM/AA] � �                       �" 
      @ nLin+11, nCol + 2 Say "���������������������������������� �������������������������" 
 
      @ nLin + 10, nCol + 08 Get dIniEmissao 
      @ nLin + 10, nCol + 24 Get dFimEmissao 
      READ 
      IF LastKey()==K_ESC 
         ScreenRest( cTela ) 
         SetColor( cCor ) 
         Return Nil 
      ENDIF 



      aEstrutura:= { {"INDICE","C", 12,00},;
                     {"DESCRI","C", 45,00},; 
                     {"UNIDAD","C", 02,00},;
                     {"QUANT_","N", 12,02},;
                     {"PRECOV","N", 12,02},;
                     {"TOTAL_","N", 12,02},;
                     {"TOTDES","N", 12,02}}

      IF Diretorio( "TEMP" )
         DBCREATE( "TEMP\RESERVA.TMP", aEstrutura )
         DBSelectAr( 123 )
         DBCloseArea()
         USE TEMP\RESERVA.TMP Alias TMP
         INDEX ON INDICE TO TEMP\IND002.TMP
      ELSE
         DBCREATE( "RESERVA.TMP", aEstrutura )
         DBSelectAr( 123 )
         DBCloseArea()
         USE RESERVA.TMP Alias TMP
         INDEX ON INDICE TO IND002.TMP
      ENDIF

      DPA->( DBSetOrder( 1 ) )
      MPR->( DBSetOrder( 1 ) )
      CAU->( DBSetOrder( 5 ) )
      CUP->( DBGoTop() )
      WHILE !CUP->( EOF() )

          // A cada 17 �tens exibir uma mensagem
          IF ++nUltimo >= 17
             nUltimo:= 0
             Mensagem( "Processando cupom n� " + TRIM( STR( CUP->NUMERO ) ) )
          ENDIF

          IF DPA->( DBSeek( CUP->NUMERO ) ) .AND.;
                 CUP->DATAEM >= dIniEmissao .AND. CUP->DATAEM <= dFimEmissao

             nTotalFinanceiro:= DPA->( VLR___ )
             nTotalCupom:= CUP->BASICM
             nDesconto:= ( ( ( nTotalCupom - nTotalFinanceiro ) / nTotalCupom ) * 100 )
             IF CAU->( DBSeek( CUP->NUMERO ) ) 
                WHILE CAU->CODNF_ == CUP->NUMERO
                     IF MPR->( DBSeek( CAU->CODIGO ) ) .and. CUP->NFNULA == " "
                        IF !TMP->( DBSeek( CAU->CODIGO ) )
                            TMP->( DBAppend() )
                        ENDIF
                        IF TMP->( RLOCK() )
                           Replace TMP->INDICE With MPR->INDICE,;
                                   TMP->DESCRI With MPR->DESCRI,;
                                   TMP->UNIDAD With MPR->UNIDAD,;
                                   TMP->QUANT_ With TMP->QUANT_ + CAU->QUANT_,;
                                   TMP->TOTAL_ With TMP->TOTAL_ + ( CAU->PRECOT - ( ( CAU->PRECOT * nDesconto ) / 100 ) ),;
                                   TMP->TOTDES With TMP->TOTDES + ( ( ( CAU->PRECOT * nDesconto ) / 100 ) )

                           // Preco de Venda Medio
                           Replace TMP->PRECOV With TMP->TOTAL_ / QUANT_
                        ENDIF
                     ENDIF
                     CAU->( DBSkip() )
                ENDDO
             ENDIF
          ENDIF
          CUP->( DBSkip() )
      ENDDO

         DBSelectAr( "TMP" )
         DBGoTop()
         nSoma:= 0
         WHILE !EOF()
            nSoma:= nSoma + TOTAL_
            DBSkip()
         ENDDO
         DBGoTop()
         vpbox( 00, 00, 22, 79, "RELACAO DE PRECOS DE VENDA MEDIO X CUPONS FISCAIS", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO )
         @ 02,01 Say "Produto  Descricao                        Un Quantidade  Preco Total  Pr.Medio"
         SetColor( _COR_BROWSE )
         oTAB:=tbrowseDB(03,01,18,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| Left( INDICE, 07 ) + " " + ;
                                               LEFT( DESCRI, 36 ) + " " + ;
                                               UNIDAD + ;
                                         Tran( QUANT_, "@e 999,999.99" ) + ;
                                         Tran( TOTAL_, "@e 9999,999.99" ) + ;
                                         Tran( PRECOV, "@e 99,999.99" ) } ) )
         oTAB:AUTOLITE:=.f. 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end

            @ 19,34 Say "T O T A L  G E R A L  ==> " + Tran( nSoma, "@e 9,999,999.99" )
            @ 19,01 Say "Total p.venda  =" + Tran( TOTAL_ + TOTDES, "@e 9,999,999.99" )
            @ 20,01 Say "Total descontos=" + Tran( TOTDES         , "@e 9,999,999.99" ) + "*"
            @ 21,01 Say "Total liquido  =" + Tran( TOTAL_,          "@e 9,999,999.99" )
            @ 20,34 Say "(*) Em caso do valor aparecer negativo (-)  "
            @ 21,34 Say "    significa que foram efetuados acrescimos"
                         
            nTecla:=inkey(0)
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom()
               case nTecla==K_TAB
                    IF Confirma( 0,0, "Confirma a impressao deste relatorio?", "S" )
                       Relatorio( "CPREMED.REP" )
                    ENDIF
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 

ScreenRest( cTela )
SetColor( cCor )
SetCursor( nCursor )
return nil


/*


*/
Function PrecoNaData( cProduto, dData )
Local nPrecoCompra
  nPrecoCompra:= 0

  PXF->( DBSetOrder( 1 ) )
  If PXF->( DBSeek( pad( cProduto, 12 ) ) )
     nPrecoCompra:= PXF->VALOR_
  EndIf

  DBSelectAr( _COD_ESTOQUE )
  DBSetOrder( 1 )

  // Com base no estoque
  If DBSeek( pad( cProduto, 12 ) )       // gelson 07122004
     WHILE DATAMV<=dData .and. !Eof() .and. AllTrim( cProduto )=AllTrim( CPROD_ )
        IF ( ENTSAI == "+" ) .AND. ( AT( ":", DOC___ ) <= 0 ) .and. ( AT( "***", DOC___ ) <= 0 )
           nPrecoCompra:= ( VALOR_ / QUANT_ )
        ENDIF
        DBSkip()
     ENDDO

  else

     // Com base no preco x fornecedores
     While AllTrim( cProduto )=AllTrim( PXF->CPROD_ ) .and. PXF->DATA__<=dData .and. !PXF->( Eof() )
        nPrecoCompra:= PXF->VALOR_
        PXF->( DBSkip() )
     EndDo

  EndIf
  Return nPrecoCompra


/*
Busca os produtos relativos ao Fabricante e Grupo
Retorno o saldo e valor total do Grupo
By Gelson Oliveira 05/11/2004
*/
Function SaldoGrupo( cGrupo, cFabric, nSaldo, nValor )
Local aCursor[4], nC:= 0

aCursor[1]:="-"
aCursor[2]:="\"
aCursor[3]:="|"
aCursor[4]:="/"

  If cFabric==Nil
     cFabric:= ""
  Else
     cFabric:= AllTrim( cFabric )
  EndIf
  MPR->( DBSetOrder( 1 ) )
  MPR->( DBSeek( cGrupo ) )

  While Left( MPR->INDICE, 3 )==cGrupo .And. If( !Empty( cFabric ),;
        MPR->ORIGEM==cFabric, .T. )  .And. !MPR->( Eof() )
      nC++
      nC:= If( nC=5, 1, nC )
      Mensagem( "Procesando: "+AllTrim( RES->CODRED )+" "+AllTrim( cGrupo );
      +" "+AllTrim( cFabric )+ ", aguarde... "+aCursor[nC] )
      nSaldo:= nSaldo+MPR->SALDO_
      nValor:= nValor+( MPR->SALDO_*MPR->PRECOV )
      MPR->( DBSkip() )
  EndDo
  Return [nSaldo, nValor]


