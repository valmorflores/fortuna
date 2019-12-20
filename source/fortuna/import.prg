// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/* 
Convenio: 00272 
          DEBITO AUTOMATICO 
Data: 
*/ 
 
/***** 
�������������Ŀ 
� Funcao      � Preco Panarello 
� Finalidade  � Importacao de Precos Panarello 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Flores 
� Data        � 
��������������� 
*/ 
Function IPrecoPanarello() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "LISTA DE PRECOS PANARELLO", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "LISTA.TXT   " + Space( 25 ) 
   @ 02,02 Say "Arquivo de Importacao:" Get cArquivo 
   READ 
   IF LastKey() == K_ESC .OR. !File( cArquivo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   aStr:= {{"ORIGEM","C",200,0}} 
   DBSelectAr( 124 ) 
   DBCreate( "PRECO.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use PRECO.TMP Alias TMP Shared 
   Append From &cArquivo SDF 
   DBGoTop() 
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   WHILE !TMP->( EOF() ) 
      cTipo:= SubStr( TMP->ORIGEM, 1, 2 ) 
      nPreco:= 0 
      IF cTipo=="01" 
         dData:= SubStr( TMP->ORIGEM, 3, 6 ) 
      ELSEIF cTipo=="02" 
         cCodFab:= SubStr( TMP->ORIGEM, 9, 13 ) 
         cCodigo:= SubStr( TMP->ORIGEM, 3, 6 ) 
         cDescricao:= SubStr( TMP->ORIGEM, 22, 32 ) 
         cUnidade:= "  " 
         cOrigem:= SubStr( TMP->ORIGEM, 54, 3 ) 
         nPreco:= VAL( TRAN( SubStr( TMP->ORIGEM, 69, 11 ), "@R XXXXXXXXX.XX" ) ) 
      ENDIF 
      IF cTipo=="02" 
         IF MPR->( DBSeek( PAD( cCodigo + "0", 12 ) ) ) 
            IF MPR->( netrlock() ) 
               Replace MPR->ORIGEM With cOrigem 
               Replace MPR->CODFAB With cCodFab 
               Replace MPR->PRECOV With nPreco,; 
                       MPR->PRECOD With nPreco 
            ENDIF 
         ELSE 
            MPR->( DBAppend() ) 
            IF MPR->( netrlock() ) 
               Replace MPR->ORIGEM With cOrigem 
               Replace MPR->DESCRI With cDescricao,; 
                       MPR->CODFAB With cCodFab,; 
                       MPR->INDICE With cCodigo + "0",; 
                       MPR->CODIGO With cCodigo + "0",; 
                       MPR->CODRED With SubStr( cCodigo + "0", 4 ),; 
                       MPR->UNIDAD With cUnidade,; 
                       MPR->PRECOV With nPreco,; 
                       MPR->PRECOD With nPreco 
            ENDIF 
         ENDIF 
      ENDIF 
      @ 20,02 Say cCodigo 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say cDescricao 
      Scroll( 02,02, 20, 78, 1 ) 
      TMP->( DBSkip() ) 
   ENDDO 
 
   /*��<< FIM DA OPERACAO DE IMPORTACAO DE PRODUTOS / PRECOS >>��*/ 
   DiarioComunicacao( "Importacao de Lista de Precos", "PANARELLO" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � IPRODABAFAR 
� Finalidade  � Importacao de Informacoes da Abafarma 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
FUNCTION IProdAbafar() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cArquivo:= "C:\ABFP1\PRODUTOS.DBF            ",; 
      nMargem:= 42.86, cAtual:= "N", nCodFor:= 0,; 
      cMudaMargem:= "S", cAdicionarNovos:= "S" 
 
   FOR->( DBGoTop() ) 
   WHILE !FOR->( EOF() ) 
      IF AT( "ABAFARMA", FOR->DESCRI ) > 0 
         nCodFor:= FOR->CODIGO 
      ENDIF 
      FOR->( DBSkip() ) 
   ENDDO 
   SetColor( _COR_GET_EDICAO ) 
   VPBox( 0, 0, 22, 79, "LISTA DE PRECOS - ABAFARMA", _COR_GET_EDICAO ) 
   @ 02,01 Say "Produtos:" Get cArquivo 
   @ 03,01 Say "Margem de Lucro s/ Produtos n�o Controlados:" Get nMargem Pict "@E 999.99" 
   @ 04,01 Say "Atualizar base de dados de produtos j� cadastrados?" Get cAtual Valid cAtual $"SN" 
   @ 05,01 Say "Codigo da ABAFARMA no cadastro de fornecedores:" Get nCodFor Pict "9999" 
   @ 06,01 Say "Modificar a mergem de preco dos produtos?" Get cMudaMargem Pict "!" 
   @ 07,01 Say "Adicionar:" Get cAdicionarNovos Pict "!" 
   READ 
   cArquivo:= ALLTRIM( cArquivo ) 
   IF !File( cArquivo ) 
      Aviso( "Arquivo " + cArquivo + " nao encontrado..." ) 
      Mensagem( "Pressione [ENTER] para continuar..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   VPBox( 0, 0, 22, 79, "LISTA DE PRECOS - ABAFARMA", _COR_GET_EDICAO ) 
   Sele 123 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cArquivo Alias TMP 
   DBGoTop() 
   nTotal:= LASTREC() 
   IF nTotal > (17*60) 
      @ 20,62 Say "  = " + Alltrim( Str( INT( nTotal / ( 17 * 60 ) ) ) ) + " Reg." Color "15/01" 
   ELSE 
      @ 20,62 Say "  = 1 Reg." Color "15/01" 
   ENDIF 
   MPR->( DBSetOrder( 1 ) ) 
   WHILE !EOF() 
      lNovo:= .F. 
      IF Inkey()==K_ESC .OR. LastKey()==K_ESC .OR. NextKey()==K_ESC 
         EXIT 
      ENDIF 
      DisplayScan( RECNO(), nTotal, 17, 2, 2 ) 
      @ 21,02 Say ALLTRIM( NOMEPROD ) + " " + UPPER( APRESENTA ) 
      @ 17,62 Say "�Importacao�����" 
      @ 18,62 Say Str( ( Recno() / nTotal ) * 100, 6, 2 ) + "%" 
      @ 19,62 Say Str( Recno(), 6, 0 ) + "/" + Str( nTotal, 6, 0 ) 
      IF !MPR->( DBSeek( ALLTRIM( TMP->CODPROD ) + "0" ) ) 
         IF ( cAdicionarNovos $ "sS" ) 
            MPR->( DBAppend() ) 
            lNovo:= .T. 
         ELSE 
            DBSkip() 
            LOOP 
         ENDIF 
      ELSEIF cAtual=="N" 
         DBSkip() 
         LOOP 
      ENDIF 
      IF MPR->( netrlock() ) 
         Repl MPR->CODRED With Alltrim( SubStr( CODPROD, 4 ) ) + "0",; 
              MPR->CODIGO With ALLTRIM( CODPROD ) + "0",; 
              MPR->INDICE With ALLTRIM( CODPROD ) + "0",; 
              MPR->DESCRI With ALLTRIM( NOMEPROD ) + " - " + ALLTRIM( UPPER( APRESENTA ) ),; 
              MPR->CODFAB With IF( lNovo, CODBARRAS, MPR->CODFAB ),; 
              MPR->CODIF_ With CODPROD,; 
              MPR->PRECOV With PRVENDA,; 
              MPR->ORIGEM With LEFT( NOMELAB, 3 ),; 
              MPR->CODFOR With nCodFor,; 
              MPR->PERCPV With IF( cMudaMargem=="S" .OR. MPR->PERCPV <= 0, nMargem, MPR->PERCPV ) 
      ENDIF 
      PXF->( DBSeek( MPR->INDICE ) ) 
      WHILE MPR->INDICE==PXF->CPROD_ 
          IF PXF->CODFOR==nCodFor .AND. MPR->INDICE==PXF->CPROD_ 
             EXIT 
          ENDIF 
          PXF->( DBSkip() ) 
      ENDDO 
      IF !( PXF->CPROD_==MPR->INDICE ) 
         PXF->( DBAppend() ) 
      ENDIF 
      IF PXF->( netrlock() ) 
         Replace PXF->PVELHO With PXF->VALOR_ 
         Replace PXF->CPROD_ With MPR->INDICE,; 
                 PXF->VALOR_ With PRFABRIC,; 
                 PXF->DATA__ With DATE() 
      ENDIF 
      IF PRVENDA==0 
         IF MPR->( netrlock() ) 
            Replace MPR->PRECOV With PXF->VALOR_ + ( ( PXF->VALOR_ * MPR->PERCPV ) / 100 ) 
         ENDIF 
      ENDIF 
      DBSkip() 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBCloseAll() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � IPROPREABAFAR 
� Finalidade  � Importar precos / abafar 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
FUNCTION IProdPreAbafar() 
 
 
 
 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � IFABABAFAR 
� Finalidade  � Importacao da tabela de fabricantes da abafarma 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
FUNCTION IFabAbafar() 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � Nota Panarello 
� Finalidade  � Importacao de Nota Fiscal (Panarello) 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function INFPanarello() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "NOTA FISCAL PANARELLO", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "NFISCAL.TXT " + Space( 25 ) 
   nCodFor:= 0 
   dDataMv:= Date() 
   @ 02,02 Say "Arquivo de Importacao:" Get cArquivo 
   @ 04,02 Say "Codigo PANARELLO.....:" Get nCodFor Pict "999999" 
   @ 06,02 Say "Data Mov. Estoque....:" Get dDataMv 
   READ 
   IF LastKey() == K_ESC .OR. !File( cArquivo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   aStr:= {{"ORIGEM","C",200,0}} 
   DBSelectAr( 124 ) 
   DBCreate( "NOTAS.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use NOTAS.TMP Alias TMP Shared 
   Append From &cArquivo SDF 
   DBGoTop() 
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   WHILE !TMP->( EOF() ) 
      cTipo:= SubStr( TMP->ORIGEM, 1, 1 ) 
      IF cTipo=="I" 
         cNotaFiscal:= Alltrim( Str( Val( SubStr( TMP->ORIGEM, 8, 6 ) ), 8, 0 ) ) 
         cCodigo:= SubStr( TMP->ORIGEM, 14, 6 ) 
         nQuantidade:= VAL( TRAN( SubStr( TMP->ORIGEM, 20, 5 ), "@R XXXXX" ) ) 
         nPreco:= VAL( TRAN( SubStr( TMP->ORIGEM, 55, 9 ), "@R XXXXXXX.XX" ) ) 
         nPrecoFinal:= VAL( TRAN( SubStr( TMP->ORIGEM, 64, 9 ), "@R XXXXXXX.XX" ) ) 
      ELSEIF cTipo=="N"         /* Final da Nota Fiscal */ 
         dData:= SubStr( TMP->ORIGEM, 3, 6 ) 
      ENDIF 
      /* Grava informacoes - Nota Fiscal */ 
      IF cTipo=="I" 
         IF MPR->( DBSeek( PAD( cCodigo + "0", 12 ) ) ) 
         ENDIF 
      ENDIF 
      @ 20,02 Say cCodigo 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say cDescricao 
      Scroll( 02,02, 20, 78, 1 ) 
      TMP->( DBSkip() ) 
   ENDDO 
   DiarioComunicacao( "Importacao de Nota Fiscal - Espelho", "PANARELLO" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � Export SoftWare - Estoque 
� Finalidade  � Importacao de Estoque - SoftWare 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function ISWEstoque() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "EXPORTACAO DE ESTOQUE - Soft&Ware Informatica", _COR_GET_BOX ) 
   DBSelectAr( _COD_ESTOQUE ) 
   DBGoTop() 
   cArquivo:= "ESTOQUE.TXT" 
   Set( 24, cArquivo ) 
   Set Device To Print 
   @ PRow(),01 Say "01******ESTOQUE******/Soft&Ware Informatica" 
   nQtd:= 1 
   WHILE !EOF() 
      ++nQtd 
      Set Device To Screen 
      @ 21,02 Say CPROD_ + DOC___ + DTOC( DATAMV ) 
      Scroll( 02, 02, 21, 78, 1 ) 
      Set Device To Print 
      @ PRow()+1,01 Say "02"+CPROD_+ENTSAI+Tran( QUANT_, "99999999.9999" )+; 
                        DOC___+Str( CODIGO )+Tran( VLRSAI, "9999999999.9999" ) +; 
                        DTOC( DATAMV ) + Str( CODMV_ ) + ANULAR + Tran( NATOPE, "9.999" ) 
      DBSkip() 
   ENDDO 
   @ Prow()+1,01 Say "03" + StrZero( ++nQtd, 08, 0 ) 
   Set Device To Screen 
   Set( 24, "LPT1" ) 
   DiarioComunicacao( "Exportacao de Estoque", "SOFTWARE" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � Importar SoftWare - Produtos 
� Finalidade  � Importacao de Produtos - SoftWare 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function ISWProduto( ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aStr 
 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "RELACAO DE PRODUTOS - DO FORMATO SOFT&WARE", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "PRODUTOS.TXT" + Space( 25 ) 
   @ 02,02 Say "Arquivo de Importacao:" Get cArquivo 
   READ 
   IF LastKey() == K_ESC .OR. !File( cArquivo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   cArquivo:= Alltrim( cArquivo ) 
   aStr:= {{"ORIGEM","C",200,00}} 
   DBCreate( "IMPORTAR.TMP", aStr ) 
   Sele 123 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use IMPORTAR.TMP Alias TMP 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "IMPORTACAO DE PRODUTO - Soft&Ware Informatica", _COR_GET_BOX ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSelectAr( 123 ) 
   APPEND FROM &cArquivo SDF 
   nQtd:= 1 
   DBGoTop() 
   WHILE !EOF() 
 
       cCodigo:= "0000000" 
       cDescri:= SubStr( TMP->ORIGEM, 1, 50 ) 
 
       /* Codigo do Produto */ 
       nCt:= 1 
       cCodigo:= SubStr( TMP->ORIGEM, 1, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )-1 ) 
       cCodigo:= SubStr( cCodigo, 2, 3 ) + SubStr( cCodigo, 6, 4 ) 
 
       /* EAN */ 
       nCt:= 1 
       cEAN___:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Descricao */ 
       ++nCt 
       cDescri:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Fabricante */ 
       ++nCt 
       cOrigem:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Preco */ 
       ++nCt 
       nPreco:= Val( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Fornecedor */ 
       ++nCt 
       nFornec:= Val( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Cd.Tributario */ 
       ++nCt 
       nCodTri:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Unidade */ 
       ++nCt 
       cUnidad:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Cd.ICMSubst */ 
       ++nCt 
       nICMSub:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
 
       /* Cd.IPI */ 
       ++nCt 
       nIPI:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
 
       /* PesoBruto */ 
       ++nCt 
       nPesoBr:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Liquido */ 
       ++nCt 
       nPesoLq:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       cSt____:= "000" 
       /* Atual Venda */ 
       ++nCt 
       nPreco:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Clas.Fiscal */ 
       ++nCt 
       nClaFis:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       MPR->( DBSetOrder( 4 ) ) 
       IF !MPR->( DBSeek( cEAN___ ) ) 
          MPR->( DBAppend() ) 
          Repl MPR->INDICE With cCodigo,; 
               MPR->CODIGO With cCodigo,; 
               MPR->CODRED With SubStr( cCodigo, 4 ),; 
               MPR->CODFAB With cEAN___,; 
               MPR->DESCRI With cDescri,; 
               MPR->UNIDAD With cUnidad,; 
               MPR->PRECOV With nPreco,; 
               MPR->ICMCOD With VAL( Left( cST____, 1 ) ),; 
               MPR->IPICOD With VAL( Right( cST____, 1 ) ),; 
               MPR->CLAFIS With nClaFis 
       ELSE 
          IF MPR->( netrlock() ) 
             Repl MPR->DESCRI With cDescri,; 
                  MPR->UNIDAD With cUnidad,; 
                  MPR->ICMCOD With VAL( Left( cST____, 1 ) ),; 
                  MPR->IPICOD With VAL( Right( cST____, 1 ) ),; 
                  MPR->CLAFIS With nClaFis 
          ENDIF 
       ENDIF 
       ++nQtd 
       Set Device To Screen 
       @ 21,02 Say MPR->INDICE + MPR->DESCRI 
       Scroll( 02, 02, 21, 78, 1 ) 
       DBSkip() 
   ENDDO 
   @ Prow()+1,01 Say "03" + StrZero( ++nQtd, 08, 0 ) 
   Set Device To Screen 
   Set( 24, "LPT1" ) 
   DiarioComunicacao( "Exportacao de Estoque", "SOFTWARE" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Function ISWCliente( ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aStr 
 
   DBSelectAr( _COD_CLIENTE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "RELACAO DE CLIENTES - DO FORMATO SOFT&WARE", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "CLIENTES.TXT" + Space( 25 ) 
   @ 02,02 Say "Arquivo de Importacao:" Get cArquivo 
   READ 
   IF LastKey() == K_ESC .OR. !File( cArquivo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   cArquivo:= Alltrim( cArquivo ) 
   aStr:= {{"ORIGEM","C",250,00}} 
   DBCreate( "IMPORTAR.TMP", aStr ) 
   Sele 123 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use IMPORTAR.TMP Alias TMP 
   DBSelectAr( _COD_CLIENTE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "IMPORTACAO DE CLIENTES - Soft&Ware Informatica", _COR_GET_BOX ) 
   DBSelectAr( _COD_CLIENTE ) 
   DBSelectAr( 123 ) 
   APPEND FROM &cArquivo SDF 
   nQtd:= 1 
   DBGoTop() 
   WHILE !EOF() 
 
       cCodigo:= "0000000" 
       cDescri:= SubStr( TMP->ORIGEM, 1, 50 ) 
 
       /* Agencia */ 
       nCt:= 1 
       nAgencia:= SubStr( TMP->ORIGEM, 1, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )-1 ) 
 
       /* Nome */ 
       cDescri:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Endereco */ 
       ++nCt 
       cEnder:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Numero */ 
       ++nCt 
       cNumero:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Complemento */ 
       ++nCt 
       cCompl:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Bairro */ 
       ++nCt 
       cBairro:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Cidade */ 
       ++nCt 
       cCidade:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Conta */ 
       ++nCt 
       cConta:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
       cConta:= Left( cConta, 9 ) 
       cDigVer:= Right( ALLTRIM( cConta ), 1 ) 
 
       /* CPF */ 
       ++nCt 
       cCPF:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Data Cadastramento */ 
       ++nCt 
       dDatCad:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Data Ultima Alteracao? */ 
       ++nCt 
       dDatUlt:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* ECIV? */ 
       ++nCt 
       cECIV:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Fone */ 
       ++nCt 
       cFone:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Matricula ? */ 
       ++nCt 
       cMat:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Nacionalidade */ 
       ++nCt 
       cNacion:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Profissao */ 
       ++nCt 
       cProf:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Registro Geral */ 
       ++nCt 
       cRegGer:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Subunidade do Registro Geral */ 
       ++nCt 
       cSubUni:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Estado */ 
       ++nCt 
       cEstado:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Unidade */ 
       ++nCt 
       cUnidade:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Codigo do Banco */ 
       ++nCt 
       cCodBan:= Val( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* CEP */ 
       ++nCt 
       cCEP:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Data Alteracao */ 
       ++nCt 
       dDatAlt:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Data Inclusao */ 
       ++nCt 
       dDatInc:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Codigo do Associado */ 
       ++nCt 
       nCodigo:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       FContaCorr( Val( cConta ), @cDigVer, Nil ) 
       CLI->( DBSetOrder( 2 ) ) 
       IF !( CLI->( DBSeek( PAD( Modifica( cDescri ), LEN( CLI->DESCRI ) ) ) ) ) 
          CLI->( DBAppend() ) 
       ENDIF 
       IF CLI->( netrlock() ) 
          Repl CLI->CODIGO With nCodigo,; 
               CLI->DESCRI With Modifica( cDescri ),; 
               CLI->ENDERE With Modifica( ALLTRIM( cEnder ) + ", " + cNumero + " " + cCompl ),; 
               CLI->BAIRRO With Modifica( cBairro ),; 
               CLI->CIDADE With Modifica( cCidade ),; 
               CLI->ESTADO With cEstado,; 
               CLI->CODCEP With cCEP,; 
               CLI->FONE1_ With IF( EMPTY( cFone ), "", "51" + Space( 3 ) + cFone ),; 
               CLI->FONEN_ With IF( EMPTY( cFone ), 0, 1 ),; 
               CLI->CPF___ With cCPF,; 
               CLI->DATACD With dDatCad,; 
               CLI->OBSER1 With Modifica( "Matricula: " + Alltrim( cMat ) ),; 
               CLI->OBSER2 With Modifica( Alltrim( cProf ) ),; 
               CLI->OBSER3 With Modifica( "Unidade: " + Alltrim( cUnidade ) + ; 
                                " - " + Alltrim( cSubUni ) ),; 
               CLI->BANCO_ With cCodBan,; 
               CLI->AGENCI With nAgencia,; 
               CLI->CONTAC With Val( cConta ),; 
               CLI->DIGVER With cDigVer,; 
               CLI->CONIND With "C",; 
               CLI->CLIENT With "S" 
       ENDIF 
       ++nQtd 
       Set Device To Screen 
       @ 21,02 Say Str( nCodigo ) + " " + CLI->DESCRI + STR ( CLI->CONTAC ) 
       Scroll( 02, 02, 21, 78, 1 ) 
       DBSkip() 
   ENDDO 
   @ Prow()+1,01 Say "03" + StrZero( ++nQtd, 08, 0 ) 
   Set Device To Screen 
   Set( 24, "LPT1" ) 
   DiarioComunicacao( "Importacao de Clientes", "SOFTWARE" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   DBSelectAr( 123 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Function ESWCliente( ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aStr, nCodigo1:= 0, nCodigo2:= 999999, cCidade1:= Space( 30 ),; 
      nAtividade:= 0 
 
   DBSelectAr( _COD_CLIENTE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "RELACAO DE CLIENTES - DO FORMATO SOFT&WARE", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "CLIENTES.TXT" + Space( 25 ) 
   @ 02,02 Say "Arquivo de Exportacao:" Get cArquivo 
   @ 02,02 Say "��������������������������������������������������������������������������" 
   @ 03,02 Say "Do Codigo:" Get nCodigo1 
   @ 03,32 Say "Ate" Get nCodigo2 
   @ 04,02 Say "Da Cidade:" Get cCidade1 
   @ 05,02 Say "Com Atividade:" Get nAtividade 
   READ 
   IF LastKey() == K_ESC .OR. !File( cArquivo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   DBSelectAr( _COD_CLIENTE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On DESCRI TO CLIET02.NTX FOR CODIGO >= nCodigo1 .AND. CODIGO <= nCodigo2 .AND.; 
                                      IF( EMPTY( cCidade1 ), .T., Alltrim( cCidade1 ) $ CIDADE ) .AND.; 
                                      IF( nAtividade > 0, CODATV==nAtividade, .T. ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "EXPORTACAO DE CLIENTES - Soft&Ware Informatica", _COR_GET_BOX ) 
   DBSelectAr( _COD_CLIENTE ) 
   cArquivo:= Alltrim( cArquivo ) 
   Set( 24, cArquivo ) 
   Set Device To Print 
   nQtd:= 1 
   DBGoTop() 
   WHILE !EOF() 
 
       cStr:= StrZero( CLI->CODIGO, 6, 0 ) 
       cStr:= cStr + Chr( 9 ) + ALLTRIM( SubStr( CLI->DESCRI, 1, 50 ) ) 
       cStr:= cStr + Chr( 9 ) + CLI->AGENCI 
       cStr:= cStr + Chr( 9 ) + ALLTRIM( DESCRI ) 
       cStr:= cStr + Chr( 9 ) + ALLTRIM( ENDERE ) 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + ALLTRIM( BAIRRO ) 
       cStr:= cStr + Chr( 9 ) + ALLTRIM( CIDADE ) 
       cStr:= cStr + Chr( 9 ) + StrZero( CONTAC, 10, 0 ) 
       cStr:= cStr + Chr( 9 ) + CPF___ 
       cStr:= cStr + Chr( 9 ) + DTOC( DATACD ) 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + FONE1_ 
       cStr:= cStr + Chr( 9 ) + ALLTRIM( OBSER1 ) 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "RG" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + Str( BANCO_ ) 
       cStr:= cStr + Chr( 9 ) + CODCEP 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       cStr:= cStr + Chr( 9 ) + "" 
       ++nQtd 
       @ PROW(),00 Say cStr + " " 
 
       Set Device To Screen 
       @ 21,02 Say Str( CLI->CODIGO ) + " " + CLI->DESCRI + STR ( CLI->CONTAC ) 
       Scroll( 02, 02, 21, 78, 1 ) 
       Set Device To Print 
 
       DBSkip() 
   ENDDO 
   @ Prow()+1,01 Say "03" + StrZero( ++nQtd, 08, 0 ) 
   Set Device To Screen 
   Set( 24, "LPT1" ) 
   DiarioComunicacao( "Exportacao de Clientes", "SOFTWARE" ) 
   Aviso( "Operacao Finalizada! " + StrZero( ++nQtd, 08, 0 ) + " Registros Copiados." ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   DBSelectAr( 123 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
 
Function ISWBaseCobranca( ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aStr 
 
   DBSelectAr( _COD_CLIENTE ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "RELACAO DE TITULOS A RECEBER/RECEBIDOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "BASECOB.TXT" + Space( 25 ) 
   @ 02,02 Say "Arquivo de Importacao:" Get cArquivo 
   READ 
   IF LastKey() == K_ESC .OR. !File( cArquivo ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   cArquivo:= Alltrim( cArquivo ) 
   aStr:= {{"ORIGEM","C",250,00}} 
   DBCreate( "IMPORTAR.TMP", aStr ) 
   Sele 123 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use IMPORTAR.TMP Alias TMP 
   DBSelectAr( _COD_CLIENTE ) 
   DBSetOrder( 1 ) 
   DBSelectAr( _COD_DUPAUX ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "IMPORTACAO DE TITUTLOS - Soft&Ware Informatica", _COR_GET_BOX ) 
   DBSelectAr( 123 ) 
   APPEND FROM &cArquivo SDF 
   nQtd:= 1 
   DBGoTop() 
   WHILE !EOF() 
 
       cCodigo:= "0000000" 
       cDescri:= SubStr( TMP->ORIGEM, 1, 50 ) 
 
       /* Cliente */ 
       nCt:= 1 
       nClient:= VAL( SubStr( TMP->ORIGEM, 1, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )-1 ) ) 
 
       /* bcod-nao sei o que e' */ 
       nBaiCod:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Bai Loc = Banco Baixa */ 
       ++nCt 
       nBaiLoc:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Data Alteracao */ 
       ++nCt 
       dDatAlt:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Data Inclusao */ 
       ++nCt 
       dDatInc:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Codigo Debito */ 
       ++nCt 
       nCodLan:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Codigo Baixa */ 
       ++nCt 
       nCodBaixa:= SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) 
 
       /* Data Quitacao */ 
       ++nCt 
       dDtQt:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Data Emprestimo */ 
       ++nCt 
       dDtEmissao:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Data Vencimento */ 
       ++nCt 
       dDtVenc:= CTOD( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Taxa Debito */ 
       ++nCt 
       nTaxa:= VAL( StrTran( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ), ",", "." ) ) 
 
       /* Emprestimo */ 
       ++nCt 
       nValor:= VAL( StrTran( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ), ",", "." ) ) 
 
       /* Recebido */ 
       ++nCt 
       nVlrRecebido:= VAL( StrTran( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ), ",", "." ) ) 
 
       /* Repeticao do ultimo */ 
       ++nCt 
 
       /* Codigo Envio */ 
       ++nCt 
       nCodEnvio:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       /* Usuario */ 
       ++nCt 
       nCodUsuario:= VAL( SUBSTR( TMP->ORIGEM, Ocorrencia( nCt, Chr(9), TMP->ORIGEM )+1, Ocorrencia( nCt+1, Chr(9), TMP->ORIGEM ) - Ocorrencia( nCt, Chr(9), TMP->ORIGEM ) -1 ) ) 
 
       CLI->( DBSetOrder( 1 ) ) 
       CLI->( DBSeek( nClient ) ) 
 
       nJuros:= 0 
       IF nVlrRecebido > nValor 
          nJuros:= nVlrRecebido - nValor 
       ENDIF 
       nPrazo:= ( dDtVenc - dDtEmissao ) 
 
       DPA->( DBSetOrder( 3 ) ) 
       IF !( DPA->( DBSeek( nCodLan ) ) ) 
          DPA->( DBAppend() ) 
       ENDIF 
       IF DPA->( netrlock() ) 
          Repl DPA->CODNF_ With 1,; 
               DPA->CODIGO With nCodLan,; 
               DPA->CLIENT With nClient,; 
               DPA->CDESCR With CLI->DESCRI,; 
               DPA->VLR___ With nValor,; 
               DPA->PRAZ__ With nPrazo,; 
               DPA->JUROS_ With nJuros,; 
               DPA->OBS___ With "**IMPORTADO**",; 
               DPA->DTQT__ With IF( nBaiCod == 0, dDtQt, CTOD( "  /  /  " ) ),; 
               DPA->VENC__ With dDtVenc,; 
               DPA->DATAEM With dDtEmissao,; 
               DPA->LOCAL_ With nBaiLoc,; 
               DPA->TIPO__ With "02" 
       ENDIF 
       ++nQtd 
       Set Device To Screen 
       @ 21,02 Say Str( nCodLan ) + " " + CLI->DESCRI + STR ( CLI->CONTAC ) 
       Scroll( 02, 02, 21, 78, 1 ) 
       DBSkip() 
   ENDDO 
   @ Prow()+1,01 Say "03" + StrZero( ++nQtd, 08, 0 ) 
   Set Device To Screen 
   Set( 24, "LPT1" ) 
   DiarioComunicacao( "Importacao de Base Duplicatas", "SOFTWARE" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   DBSelectAr( 123 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
  Static Function Modifica( cString ) 
  cString:= StrTran( cString, "�", "C" ) 
  cString:= StrTran( cString, "�", "A" ) 
  cString:= StrTran( cString, "�", "A" ) 
  cString:= StrTran( cString, "�", "O" ) 
  cString:= StrTran( cString, "�", "I" ) 
  cString:= StrTran( cString, "�", "A" ) 
  cString:= StrTran( cString, "�", "U" ) 
  cString:= StrTran( cString, "�", "E" ) 
  Return cString 
 
 
/***** 
�������������Ŀ 
� Funcao      � DiarioComunicacao 
� Finalidade  � Armazenar informacoes de acesso ao modulo de comunicacao 
� Parametros  � cInformacao 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function DiarioComunicacao( cInformacao, cInfo2 ) 
Local nArea:= Select() 
Local aStr:= {} 
DBSelectAr( _COD_DIARIO ) 
IF !Used() 
   IF !File( _VPB_DIARIO ) 
      aStr:= {{"DATA__","D",08,00},; 
              {"HORA__","C",08,00},; 
              {"DESCRI","C",60,00},; 
              {"RESPON","N",03,00},; 
              {"TIPO__","C",01,00}} 
      DBCreate( _VPB_DIARIO, aStr ) 
   ENDIF 
   NetUse( _VPB_DIARIO, .F., 1, "DC", .F. ) 
   IF !File( GDir-"\DIARIO.NTX" ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        index on data__ to "&gdir/diario.ntx" 
      #else 
        Index On DATA__ To "&GDir\DIARIO.NTX" 
      #endif
   ENDIF 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/diario.ntx" 
   #else 
     Set index To "&Gdir\DIARIO.NTX" 
   #endif
ENDIF 
DBGoBottom() 
IF BOF() 
   DBAppend() 
ENDIF 
IF netrlock() 
   Repl DATA__ With Date(),; 
        HORA__ With time(),; 
        DESCRI With cInformacao,; 
        RESPON With nGCodUser,; 
        TIPO__ With Space( 1 ) 
ENDIF 
 
DBAppend() 
Replace DATA__ With DATE(),; 
        HORA__ With TIME(),; 
        TIPO__ With "*",; 
        DESCRI With cInfo2,; 
        RESPON With nGCodUser 
 
DBAppend() 
Replace DATA__ With DATE(),; 
        TIPO__ With "*",; 
        DESCRI With Repl( "�", 60 ) 
 
DBAppend() 
Replace DATA__ With DATE(),; 
        TIPO__ With "*" 
 
DBCloseArea() 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � VisualComunicacao 
� Finalidade  � Visualizacao da comunicacao 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function VisualComunicacao() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_DIARIO ) 
   IF !Used() 
      IF !File( _VPB_DIARIO ) 
         aStr:= {{"DATA__","D",08,00},; 
                 {"HORA__","C",08,00},; 
                 {"DESCRI","C",60,00},; 
                 {"RESPON","N",03,00},; 
                 {"TIPO__","C",01,00}} 
         DBCreate( _VPB_DIARIO, aStr ) 
      ENDIF 
      NetUse( _VPB_DIARIO, .F., 1, "DC", .F. ) 
      IF !File( GDir-"\DIARIO.NTX" ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           index on data__ to "&gdir/diario.ntx" 
         #else 
           Index On DATA__ To "&GDir\DIARIO.NTX" 
         #endif
      ENDIF 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&gdir/diario.ntx" 
      #else 
        Set index To "&Gdir\DIARIO.NTX" 
      #endif
   ENDIF 
   DBGoBottom() 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "DIARIO DE COMUNICACAO", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   Mensagem("Pressione [ENTER] p/ selecionar.") 
   Ajuda("["+_SETAS+"][PgUp][PgDn]Move") 
   SetColor( _COR_BROWSE ) 
   oTB:=tbrowsedb( 01,01,21,78 ) 
   oTB:addcolumn(tbcolumnnew(,{|| IF( !TIPO__=="*", DTOC( DATA__ ) + " " + HORA__, Space( 17 ) ) + " " + Left( DESCRI, 53 ) + " " + IF( !TIPO__=="*", Str( RESPON, 3, 0 ), "   " ) })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   SetCursor(0) 
   whil .t. 
       oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS+1,1},{2,1}) 
       whil nextkey()=0 .and.! oTB:stabilize() 
       enddo 
       IF Row()+1 < 22 
          @ Row()+1,01 Say Space( 18 ) 
       ENDIF 
       nTecla:=inkey(0) 
       if nTecla=K_ESC 
          exit 
       endif 
       //Dispbegin() 
       do case 
          case nTecla==K_UP 
               oTB:up() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:up(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:up(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          case nTecla==K_LEFT 
               oTB:up() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:up(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:up(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          case nTecla==K_RIGHT 
               oTB:down() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Down(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Down(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          case nTecla==K_DOWN 
               oTB:down() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Down(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Down(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          case nTecla==K_PGUP       ;oTB:pageup() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Up(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Up(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          case nTecla==K_PGDN       ;oTB:pagedown() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Down(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
               IF( !EMPTY( TIPO__ ), oTb:Down(), Nil ) 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
          case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
          otherwise                ;tone(125); tone(300) 
       endcase 
       oTB:refreshAll() 
       oTB:stabilize() 
       //DispEnd() 
   enddo 
   DBCloseArea() 
   DBSelectAr( _COD_CLIENTE ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � iACSBase 
� Finalidade  � Importacao de Base de dados ACS 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Flores 
� Data        � 
��������������� 
*/ 
Function IACSBase() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "ACS/CORAL - BASE DE DADOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cDiretorio:= "C:\ACS\E001" + Space( 25 ) 
   @ 02,02 Say "Diretorio do Sistema (Base de Dados):" Get cDiretorio 
   READ 
   IF !File( cDiretorio + "\COMPONEN.DBF" ) .OR.; 
      !File( cDiretorio + "\PRODUTOS.DBF" ) 
      Aviso( "Diretorio informado n�o possui dados necessarios..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   DBSelectAr( 124 ) 
   DBCloseArea() 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&cdiretorio/componen.dbf" alias cmp shared  
   #else 
     Use "&cDiretorio\COMPONEN.DBF" Alias CMP Shared  
   #endif
   MPR->( DBSetOrder( 4 ) ) 
   nCodigo:= 8000001 
   WHILE !CMP->( EOF() ) 
       cCodigo:= StrZero( nCodigo, 7, 0 ) 
       IF !MPR->( DBSeek( PAD( CMP->COMPONENT, Len( MPR->CODFAB ) ) ) ) 
          MPR->( DBAppend() ) 
          Replace MPR->CODIGO With cCodigo,; 
                  MPR->DESCRI With CMP->DESCRICAO,; 
                  MPR->INDICE With cCodigo,; 
                  MPR->CODFAB With CMP->COMPONENT,; 
                  MPR->ORIGEM With "COR" 
          nCodigo:= nCodigo + 1 
       ENDIF 
       CMP->( DBSkip() ) 
   ENDDO 
   DBSelectAr( 124 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&cdiretorio/produtos.dbf" alias pro shared  
   #else 
     Use "&cDiretorio\PRODUTOS.DBF" Alias PRO Shared  
   #endif
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   WHILE !PRO->( EOF() ) 
      cCodigo:= SubStr( PRO->CODPRO, 6, 3 ) + SubStr( PRO->CODPRO, 1, 4 ) 
      cDescricao:= ALLTRIM( Left( PRO->DESCOR, 25 ) ) + " " + ALLTRIM( PRO->CMONT ) + " " + Left( PRO->DESPRO, 10 ) + " " + PRO->STAYEA + "/" + PRO->ENDYEA + " " 
      cDetal1:= PRO->CMONT 
      cDetal2:= PRO->VEHICL + " " + PRO->DESRED 
      cDetal3:= PRO->VARIANTE + "      Ano: " + PRO->STAYEA + " " + PRO->ENDYEA 
      lMPrima:= EMPTY( PRO->FCOMPON1 ) 
      IF MPR->( DBSeek( PAD( cCodigo, 12 ) ) ) 
         IF MPR->( netrlock() ) 
            Replace MPR->DESCRI With cDescricao 
         ENDIF 
      ELSE 
         MPR->( DBAppend() ) 
         IF MPR->( netrlock() ) 
            Replace MPR->DETAL1 With Alltrim( cDetal1 ),; 
                    MPR->DETAL2 With Alltrim( cDetal2 ),; 
                    MPR->DETAL3 With Alltrim( cDetal3 ),; 
                    MPR->DESCRI With cDescricao,; 
                    MPR->INDICE With cCodigo,; 
                    MPR->CODIGO With cCodigo,; 
                    MPR->CODRED With SubStr( cCodigo, 4 ),; 
                    MPR->MPRIMA With IF( lMPrima, "S", "N" ) 
            IF !lMPrima 
               nRegistro:= MPR->( RECNO() ) 
               MPR->( DBSetOrder( 4 ) ) 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON1, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN1 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON2, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN2 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON3, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN3 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON4, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN4 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON5, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN5 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON6, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN6 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON7, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN7 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON8, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN8 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON9, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN9 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON10, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN10 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON11, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN11 
               ENDIF 
               IF MPR->( DBSeek( PAD( PRO->FCOMPON12, 13 ) ) ) 
                  ASM->( DBAppend() ) 
                  Repl ASM->CODPRD With cCodigo,; 
                       ASM->DESCRI With MPR->DESCRI,; 
                       ASM->CODMPR With MPR->INDICE,; 
                       ASM->QUANT_ With PRO->FPERCEN12 
               ENDIF 
               MPR->( DBSetOrder( 1 ) ) 
            ENDIF 
         ENDIF 
      ENDIF 
      @ 20,02 Say cCodigo 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say cDescricao 
      Scroll( 02,02, 20, 78, 1 ) 
      PRO->( DBSkip() ) 
   ENDDO 
   DBSelectAr( _COD_ASSEMBLER ) 
   DBGoTop() 
   @ 20,02 Say "Limpando informacoes desnecessarias, aguarde..." 
   WHILE !EOF() 
       @ ROW(),COL() Say Recno() 
       IF QUANT_ == 0 
          IF netrlock() 
             Dele 
          ENDIF 
       ENDIF 
       DBSkip() 
   ENDDO 
   DiarioComunicacao( "Importacao da Base de dados", "A.C.S.-CORAL" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � iACSPreco 
� Finalidade  � Importacao de Precos ACS 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Flores 
� Data        � 
��������������� 
*/ 
Function IACSPreco() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "ACS/CORAL - LISTA DE PRECOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cDiretorio:= "C:\ACS\E001" + Space( 25 ) 
   @ 02,02 Say "Diretorio do Sistema (Base de Dados):" Get cDiretorio 
   READ 
   IF !File( cDiretorio + "\LISTAPRE.DBF" ) 
      Aviso( "Diretorio informado n�o possui dados necessarios..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   DBSelectAr( 124 ) 
   DBCloseArea() 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&cdiretorio/listapre.dbf" alias im shared  
   #else 
     Use "&cDiretorio\LISTAPRE.DBF" Alias IM Shared  
   #endif
   IM->( DBGoTop() ) 
   WHILE .T. 
      cCodigo:= SubStr( IM->CODPRO, 6, 3 ) + SubStr( IM->CODPRO, 1, 4 ) 
      IF IM->PREACSM == 0 
         nPreco:= IM->PREGALM 
      ELSE 
         nPreco:= IM->PREACSM 
      ENDIF 
      IF MPR->( DBSeek( PAD( cCodigo, 12 ) ) ) 
         IF MPR->( netrlock() ) 
            Replace MPR->PRECOV With nPreco,; 
                    MPR->PRECOD With nPreco,; 
                    MPR->ORIGEM With "COR" 
         ENDIF 
      ENDIF 
      @ 20,02 Say MPR->CODIGO 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say MPR->DESCRI + IF( !EOF(), " OK! ", "Buscando Informacoes." ) 
      Scroll( 02,02, 20, 78, 1 ) 
      IM->( DBSkip() ) 
      IF IM->( EOF() ) 
         EXIT 
      ENDIF 
   ENDDO 
   **************/ 
   DiarioComunicacao( "Importacao de Lista de Precos", "A.C.S.-CORAL" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � iGlasBase 
� Finalidade  � Importacao de Precos FORMIX 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Flores 
� Data        � 
��������������� 
*/ 
Function iGlasBase() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "FORMIX/GLASURIT - LISTA DE PRECOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "C:\FORMIX\BAS.TXT" + Space( 25 ) 
   cGrupo:= "300" 
   @ 02,02 Say "Arquivo c/ Informacoes:" Get cArquivo 
   @ 03,02 Say "Grupo de Produtos.....:" Get cGrupo 
   READ 
   IF !File( cArquivo ) 
      Aviso( "Diretorio informado n�o possui dados necessarios..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   aStr:= {{"ORIGEM","C",200,0}} 
   DBSelectAr( 124 ) 
   DBCreate( "PRECO.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use PRECO.TMP Alias TMP Shared 
   Append From &cArquivo SDF 
   DBGoTop() 
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   MPR->( DBSetOrder( 1 ) ) 
   IF !MPR->( DBSeek( PAD( cGrupo + "0000", 12 ) ) ) 
      MPR->( DBAppend() ) 
      Replace MPR->CODIGO With cGrupo + "0000",; 
              MPR->INDICE With cGrupo + "0000",; 
              MPR->DESCRI With "--GRUPO GLASURIT--------------------------",; 
              MPR->ORIGEM With "GLS" 
   ENDIF 
   MPR->( DBSetOrder( 4 ) ) 
   WHILE !TMP->( EOF() ) 
      cCodFab:= PAD( SubStr( TMP->ORIGEM, 1, 8 ), 13 ) 
      cDescri:= SubStr( TMP->ORIGEM, 9, 43 ) 
      nPreco:= VAL( SubStr( TMP->ORIGEM, 56, 10 ) ) 
      IF MPR->( DBSeek( PAD( cCodFab, 13 ) ) ) 
         IF MPR->( netrlock() ) 
            Replace MPR->PRECOV With nPreco,; 
                    MPR->PRECOD With nPreco,; 
                    MPR->ORIGEM With "GLS" 
         ENDIF 
      ELSE 
         MPR->( DBSetOrder( 1 ) ) 
         MPR->( DBSeek( PAD( cGrupo + "0001", 12 ), .T. ) ) 
         IF cGrupo==LEFT( MPR->INDICE, 3 ) 
            WHILE cGrupo==Left( MPR->INDICE, 3 ) 
                MPR->( DBSkip() ) 
                IF MPR->( EOF() ) 
                   EXIT 
                ENDIF 
            ENDDO 
            MPR->( DBSkip( -1 ) ) 
            cIndice:= cGrupo + SubStr( StrZero( Val( MPR->INDICE ) + 1, 7, 0 ), 4 ) 
         ELSE 
            cIndice:= cGrupo + "0001" 
         ENDIF 
         cCodigo:= cIndice 
         MPR->( DBSetOrder( 4 ) ) 
         MPR->( DBAppend() ) 
         Replace MPR->DESCRI With cDescri,; 
                 MPR->CODFAB With cCodFab,; 
                 MPR->PRECOV With nPreco,; 
                 MPR->PRECOD With nPreco,; 
                 MPR->INDICE With cIndice,; 
                 MPR->CODIGO With cCodigo,; 
                 MPR->CODRED With SubStr( cCodigo, 4 ),; 
                 MPR->ORIGEM With "GLS" 
      ENDIF 
      @ 20,02 Say MPR->INDICE 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say MPR->DESCRI 
      Scroll( 02,02, 20, 78, 1 ) 
      TMP->( DBSkip() ) 
   ENDDO 
   DiarioComunicacao( "Importacao de Lista de Precos", "PANARELLO" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Function iCGlasPro() 
local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "COMBILUX/GLASURIT - LISTA DE PRECOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "C:\COMBILUX\PRECOMIX.PRN" + Space( 25 ) 
   cGrupo:= "300" 
   @ 02,02 Say "Arquivo c/ Informacoes:" Get cArquivo 
   @ 03,02 Say "Grupo de Produtos.....:" Get cGrupo 
   READ 
   IF !File( cArquivo ) 
      Aviso( "Diretorio informado n�o possui dados necessarios..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   aStr:= {{"ORIGEM","C",200,0}} 
   DBSelectAr( 124 ) 
   DBCreate( "PRECO.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use PRECO.TMP Alias TMP Shared 
   Append From &cArquivo SDF 
   DBGoTop() 
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   MPR->( DBSetOrder( 1 ) ) 
   IF !MPR->( DBSeek( PAD( cGrupo + "0000", 12 ) ) ) 
      MPR->( DBAppend() ) 
      Replace MPR->CODIGO With cGrupo + "0000",; 
              MPR->INDICE With cGrupo + "0000",; 
              MPR->DESCRI With "--GRUPO GLASURIT--------------------------",; 
              MPR->ORIGEM With "GLS" 
   ENDIF 
   MPR->( DBSetOrder( 4 ) ) 
   WHILE !TMP->( EOF() ) 
      cCodFab:= PAD( SubStr( TMP->ORIGEM, 39, 08 ) + SubStr( TMP->ORIGEM, 115, 3 ) , 13 ) 
      cDescri:= ALLTRIM( SubStr( TMP->ORIGEM, 52, 40 ) ) + " " + SubStr( TMP->ORIGEM, 02, 15 ) + " " +  SubStr( TMP->ORIGEM, 128, 4 ) 
      nPreco:= VAL( StrTran( SubStr( TMP->ORIGEM, 96, 16 ), ",", "." ) ) 
      IF nPreco > 0 
         IF MPR->( DBSeek( PAD( cCodFab, 13 ) ) ) 
            IF MPR->( netrlock() ) 
               Replace MPR->PRECOV With nPreco,; 
                       MPR->PRECOD With nPreco,; 
                       MPR->ORIGEM With "GLS" 
            ENDIF 
         ELSE 
            MPR->( DBSetOrder( 1 ) ) 
            MPR->( DBSeek( PAD( cGrupo + "0001", 12 ), .T. ) ) 
            IF cGrupo==LEFT( MPR->INDICE, 3 ) 
               WHILE cGrupo==Left( MPR->INDICE, 3 ) 
                   MPR->( DBSkip() ) 
                   IF MPR->( EOF() ) 
                      EXIT 
                   ENDIF 
               ENDDO 
               MPR->( DBSkip( -1 ) ) 
               cIndice:= cGrupo + SubStr( StrZero( Val( MPR->INDICE ) + 1, 7, 0 ), 4 ) 
            ELSE 
               cIndice:= cGrupo + "0001" 
            ENDIF 
            cCodigo:= cIndice 
            MPR->( DBSetOrder( 4 ) ) 
            MPR->( DBAppend() ) 
            Replace MPR->DESCRI With cDescri,; 
                    MPR->CODFAB With cCodFab,; 
                    MPR->PRECOV With nPreco,; 
                    MPR->PRECOD With nPreco,; 
                    MPR->INDICE With cIndice,; 
                    MPR->CODIGO With cCodigo,; 
                    MPR->CODRED With SubStr( cCodigo, 4 ),; 
                    MPR->ORIGEM With "GLS" 
         ENDIF 
      ENDIF 
      @ 20,02 Say MPR->INDICE 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say MPR->DESCRI 
      Scroll( 02,02, 20, 78, 1 ) 
      TMP->( DBSkip() ) 
   ENDDO 
   DiarioComunicacao( "Importacao de Lista de Precos", "COMBILUX" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � iGlasFormula 
� Finalidade  � Importacao de Precos FORMIX/GLASURIT 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Flores 
� Data        � 
��������������� 
*/ 
Function iGlasFormula() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "FORMIX/GLASURIT - FORMULAS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo:= "C:\FORMIX\FOR.TXT" + Space( 25 ) 
   cGrupo:= "301" 
   @ 02,02 Say "Arquivo c/ Informacoes:" Get cArquivo 
   @ 03,02 Say "Grupo de Produtos.....:" Get cGrupo 
   READ 
   IF !File( cArquivo ) 
      Aviso( "Diretorio informado n�o possui dados necessarios..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   aStr:= {{"ORIGEM","C",200,0}} 
   DBSelectAr( 124 ) 
   DBCreate( "PRECO.TMP", aStr ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use PRECO.TMP Alias TMP Shared 
   Append From &cArquivo SDF 
   DBGoTop() 
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   MPR->( DBSetOrder( 1 ) ) 
   IF !MPR->( DBSeek( PAD( cGrupo + "0000", 12 ) ) ) 
      MPR->( DBAppend() ) 
      Replace MPR->CODIGO With cGrupo + "0000",; 
              MPR->INDICE With cGrupo + "0000",; 
              MPR->DESCRI With "--GRUPO GLASURIT--------------------------",; 
              MPR->ORIGEM With "GLS" 
   ENDIF 
   MPR->( DBSetOrder( 4 ) ) 
   WHILE !TMP->( EOF() ) 
      cCodFab:= PAD( SubStr( TMP->ORIGEM, 44, 6 ) + "-" + SubStr( TMP->ORIGEM, 116, 4 ), 13 ) 
      cDescri:= AllTrim( SubStr( TMP->ORIGEM, 48, 43 ) ) 
      nPreco:=  VAL( SubStr( TMP->ORIGEM, 100, 13 ) ) 
      IF MPR->( DBSeek( PAD( cCodFab, 13 ) ) ) 
         IF MPR->( netrlock() ) 
            Replace MPR->PRECOV With nPreco,; 
                    MPR->ORIGEM With "GLS" 
         ENDIF 
      ELSE 
         MPR->( DBSetOrder( 1 ) ) 
         MPR->( DBSeek( PAD( cGrupo + "0001", 12 ), .T. ) ) 
         IF cGrupo==LEFT( MPR->INDICE, 3 ) 
            WHILE cGrupo==Left( MPR->INDICE, 3 ) 
                MPR->( DBSkip() ) 
                IF MPR->( EOF() ) 
                   EXIT 
                ENDIF 
            ENDDO 
            MPR->( DBSkip( -1 ) ) 
            cIndice:= cGrupo + SubStr( StrZero( Val( MPR->INDICE ) + 1, 7, 0 ), 4 ) 
         ELSE 
            cIndice:= cGrupo + "0001" 
         ENDIF 
         cCodigo:= cIndice 
         MPR->( DBSetOrder( 4 ) ) 
         MPR->( DBAppend() ) 
         Replace MPR->DESCRI With cDescri,; 
                 MPR->CODFAB With cCodFab,; 
                 MPR->PRECOV With nPreco,; 
                 MPR->PRECOD With nPreco,; 
                 MPR->INDICE With cIndice,; 
                 MPR->CODIGO With cCodigo,; 
                 MPR->CODRED With SubStr( cCodigo, 4 ),; 
                 MPR->ORIGEM With "GLS" 
      ENDIF 
      @ 20,02 Say MPR->INDICE 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say MPR->DESCRI 
      Scroll( 02,02, 20, 78, 1 ) 
      TMP->( DBSkip() ) 
   ENDDO 
   DiarioComunicacao( "Importacao de Lista de Precos", "GLASURIT" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � RennerPreco 
� Finalidade  � Importacao de Precos Renner Dupont 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Flores 
� Data        � 
��������������� 
*/ 
Function RennerPreco() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cGrupo:= "401", cGrupoMateria:= "402" 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "RENNER - LISTA DE PRECOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   cArquivo1:= "C:\MAUTO\MAC010.DBF" + Space( 25 ) 
   cArquivo:=  "C:\MAUTO\MAD010.DBF" + Space( 25 ) 
   cFormulas:= "C:\MAUTO\MAF010.DBF" + Space( 25 ) 
   cArquivo2:= "C:\MAUTO\MAT010.DBF" + Space( 25 ) 
   cArquivo3:= "C:\MAUTO\MAT020.DBF" + Space( 25 ) 
   @ 02,02 Say "Base de Dados.........:" Get cArquivo 
   @ 03,02 Say "Base de Dados (Precos):" Get cArquivo1 
   @ 04,02 Say "Formulas..............:" Get cFormulas 
   @ 05,02 Say "Montadoras............:" Get cArquivo2 
   @ 06,02 Say "Grupo de Produtos.....:" Get cGrupo 
   @ 07,02 Say "Grupo de Referencias..:" Get cArquivo3 
   @ 08,02 Say "Grupo de Materia-Prima:" Get cGrupoMateria 
   @ 09,02 Say "Imp.Somente Composicao:" Get cSoComposicao 
   READ 
   IF !File( cArquivo ) 
      Aviso( "Diretorio informado nao possui dados necessarios..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   MPR->( DBSetOrder( 1 ) ) 
   cDescricao:= "NIL" 
   cCodigo:= 0 
   ASM->( DBSetOrder( 1 ) ) 
 
   MPR->( DBSetOrder( 1 ) ) 
   IF !MPR->( DBSeek( PAD( cGrupo + "0000", 12 ) ) ) 
      MPR->( DBAppend() ) 
      Replace MPR->CODIGO With cGrupo + "0000",; 
              MPR->INDICE With cGrupo + "0000",; 
              MPR->DESCRI With "��GRUPO RENNER����������������������������",; 
              MPR->ORIGEM With "REN" 
   ENDIF 
 
   MPR->( DBSetOrder( 4 ) ) 
   DBSelectAr( 125 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cArquivo3 Alias REF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODDESCR To Ind9393 
 
   DBSelectAr( 121 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cArquivo2 Alias MT 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODMARCA To IND9123 
 
   DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cArquivo1 Alias TMP Shared 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On PROD To Indice 
 
   DBSelectAr( 124 ) 
   DBCloseArea() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cArquivo Alias IM Shared 
 
   DBSelectAr( 122 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cFormulas Alias TP Shared 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODPROD + CORALT To IND9203 
   Set Relation To Prod Into TMP 
 
   TMP->( DBGoTop() ) 
   nCont:= 0 
   WHILE !TMP->( EOF() ) 
      MPR->( DBSetOrder( 4 ) ) 
      IF !MPR->( DBSeek( PAD( TMP->PROD, 13 ) ) ) 
         MPR->( DBAppend() ) 
         Replace MPR->CODIGO With cGrupoMateria + StrZero( ++nCont, 4, 0 ),; 
                 MPR->INDICE With cGrupoMateria + StrZero( nCont, 4, 0 ),; 
                 MPR->CODRED With StrZero( nCont, 4, 0 ),; 
                 MPR->CODFAB With TMP->PROD,; 
                 MPR->DESCRI With TMP->PROD + TMP->TIPO,; 
                 MPR->PRECOV With TMP->VLR14,; 
                 MPR->ORIGEM With "REN",; 
                 MPR->MPRIMA With "S" 
      ENDIF 
      TMP->( DBSkip() ) 
   ENDDO 
   MPR->( DBSetOrder( 4 ) ) 
 
 
   DBSelectAr( 124 ) 
   IM->( DBGoTop() ) 
   WHILE !IM->( EOF() ) 
      IF Inkey()==K_ESC .OR. NextKey()==K_ESC .OR. LastKey()==K_ESC 
         EXIT 
      ENDIF 
      MT->(  DBSeek( IM->CODMARCA ) ) 
      REF->( DBSeek( IM->CODDESCR ) ) 
      cRef:= Abreviatura( REF->DESCR, 3 ) 
      cCodFab:= Pad( CODPROD+CORALT, 13 ) 
      cDescri:= Left( COR, 25 ) + PAD( cRef, 12 ) + " " + ANO + MT->MARCA 
      nQuant:=  0 
      nPreco:= 0 
      /* Busca e compoe virtualmente o produto */ 
      IF TP->( DBSeek( SubStr( cCodFab, 1, 12 ) ) ) 
         WHILE SubStr( cCodFab, 1, 12 ) == TP->CODPROD + TP->CORALT 
              nQuant:= nQuant + TP->QTD 
              nPreco:= nPreco + ROUND( ( TP->QTD * TMP->VLR14 * 0.50 ) / 1000, 2 ) 
              ASM->( DBAppend() ) 
              Replace ASM->CODPRD With MPR->INDICE,; 
                      ASM->QUANT_ With TP->QTD,; 
                      ASM->CODMPR With CodMpr( TP->PROD ),; 
                      ASM->CUSTOT With nPreco,; 
                      ASM->CUSUNI With nPreco / nQuant 
              TP->( DBSkip() ) 
         ENDDO 
      ENDIF 
      IF MPR->( DBSeek( PAD( cCodFab, 13 ) ) ) 
         IF MPR->( netrlock() ) 
            Replace MPR->DESCRI With cDescri 
            Replace MPR->PESOLI With nQuant,; 
                    MPR->PESOBR With nQuant 
            Replace MPR->PRECOV With nPreco,; 
                    MPR->PRECOD With nPreco,; 
                    MPR->ORIGEM With "REN",; 
                    MPR->MPRIMA With "N" 
         ENDIF 
      ELSE 
         MPR->( DBSetOrder( 1 ) ) 
         MPR->( DBSeek( PAD( cGrupo + "0001", 12 ), .T. ) ) 
         IF cGrupo==LEFT( MPR->INDICE, 3 ) 
            WHILE cGrupo==Left( MPR->INDICE, 3 ) 
                MPR->( DBSkip() ) 
                IF MPR->( EOF() ) 
                   EXIT 
                ENDIF 
            ENDDO 
            MPR->( DBSkip( -1 ) ) 
            cIndice:= cGrupo + SubStr( StrZero( Val( MPR->INDICE ) + 1, 7, 0 ), 4 ) 
         ELSE 
            cIndice:= cGrupo + "0001" 
         ENDIF 
         cCodigo:= cIndice 
         MPR->( DBSetOrder( 4 ) ) 
         MPR->( DBAppend() ) 
         Replace MPR->DESCRI With cDescri,; 
                 MPR->CODFAB With cCodFab,; 
                 MPR->PRECOV With nPreco,; 
                 MPR->PRECOD With nPreco,; 
                 MPR->INDICE With cIndice,; 
                 MPR->CODIGO With cCodigo,; 
                 MPR->CODRED With SubStr( cCodigo, 4 ),; 
                 MPR->ORIGEM With "REN",; 
                 MPR->PESOLI With nQuant,; 
                 MPR->PESOBR With nQuant 
      ENDIF 
      @ 20,02 Say MPR->INDICE 
      Scroll( 02,02, 20, 78, 1 ) 
      @ 20,02 Say MPR->DESCRI 
      Scroll( 02,02, 20, 78, 1 ) 
      IM->( DBSkip() ) 
   ENDDO 
   DiarioComunicacao( "Importacao de Lista de Precos", "RENNER" ) 
   Aviso( "Operacao Finalizada!" ) 
   Pausa() 
   DBSelectAr( 125 ) 
   DBCloseArea() 
   DBSelectAr( 123 ) 
   DBCloseArea() 
   DBSelectAr( 124 ) 
   DBCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Static Function CodMpr( cCodigo ) 
Loca nRegistro:= MPR->( RECNO() ),; 
   nOrdem:= MPR->( IndexOrd() ), cCodMpr:= Space( 12 ) 
 
   MPR->( DBSetOrder( 4 ) ) 
   MPR->( DBSeek( pad( cCodigo, 13 ) ) ) 
   cCodMPR:= MPR->INDICE 
 
   MPR->( DBSetOrder( nOrdem ) ) 
   MPR->( DBGoTo( nRegistro ) ) 
 
   Return cCodMpr 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � PRODBARROS 
� Finalidade  � Importacao de Precos Barros 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function IPRODBarros() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "BARROS - CADASTRO DE PRODUTOS", _COR_GET_BOX ) 
   nCodFor:= 0 
   cMesma:= "S" 
   cAtual:= "N" 
   cGrupo:= "   " 
   cArquivo:= "BARROS.TXT           " 
   @ 02,03 Say "Arquivo com Informacoes.....................:" Get cArquivo 
   @ 03,03 Say "Codigo do Fornecedor........................:" Get nCodFor Pict "999999" 
   @ 04,03 Say "Utilizar a mesma Divis�o de Grupos da Barros:" Get cMesma Pict "!" 
   @ 05,03 Say "  ����� Se a Informacao for [N] Qual Grupo.:" Get cGrupo Pict "   " 
   @ 06,03 Say "Atualizar os Produtos j� Gravados...........:" Get cAtual Pict "!" 
   READ 
   IF LastKey()==K_ESC 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   cArquivo:= Alltrim( cArquivo ) 
   IF !File( cArquivo ) 
      Aviso( "Atencao! Arquivo " + cArquivo + " esta faltando." ) 
      Mensagem( "Pressione [ENTER] para finalizar..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   SWGravar( 600 ) 
   Ajuda( "Organizando produtos: Codigo fabricante + Fornecedor" ) 
   Mensagem( "Organizando os produtos, aguarde..."  ) 
   SetColor( _COR_GET_EDICAO ) 
   DBSelectAr( _COD_MPRIMA ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODIF_ + STR( CODFOR, 6, 0 ) TO INRES02 EVal {|| Processo() } 
   Ajuda( "Organizando produtos: Codigo do Produto" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On INDICE To INRES01                       Eval {|| Processo() } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Set Index To INRES02, INRES01 
 
   MPR->( DBSetOrder( 1 ) ) 
   aStr:= {{ "ORIGEM", "C", 200, 00 }} 
   DBCreate( "RESORI.TMP", aStr ) 
   Sele 123 
   Ajuda( "Convertendo informacoes..." ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use RESORI.TMP Alias TMP 
   Append From &cArquivo SDF 
   DBGoTop() 
   Ajuda( "Gravando arquivo de produtos..." ) 
   nTotal:= LASTREC() 
   WHILE !tmp->( EOF() ) 
       IF Inkey()==K_ESC .OR. LastKey()==K_ESC .OR. NextKey()==K_ESC 
          EXIT 
       ENDIF 
       IF !MPR->( DBSeek( PAD( SubStr( TMP->ORIGEM, 1, 10 ), 20 ) + STR( nCodFor, 6, 0 ) ) ) .OR. cAtual=="S" 
          cIndice:= MPR->INDICE 
          IF !( ALLTRIM( SubStr( tmp->ORIGEM, 1, 10 ) )==ALLTRIM( MPR->CODIF_ ) ) 
             IF cMesma=="S" 
                cGrupo_:= SubStr( tmp->ORIGEM, 1, 3 ) 
             ELSE 
                cGrupo_:= cGrupo 
             ENDIF 
             MPR->( DBSetOrder( 2 ) ) 
             MPR->( DBSeek( PAD( cGrupo_ + "9999", 12 ), .T. ) ) 
             MPR->( DBSkip( -1 ) ) 
             MPR->( DBSetOrder( 1 ) ) 
             IF SUBSTR( MPR->INDICE, 1, 3 )==cGrupo_ 
                cIndice:= cGrupo_ + StrZero( VAL( SubStr( MPR->INDICE, 4 ) ) + 1, 4 ) 
             ELSE 
                cIndice:= cGrupo_ + "0001" 
             ENDIF 
             MPR->( DBAppend() ) 
          ENDIF 
          IF MPR->( RLOCK() ) 
             Replace MPR->CODIF_ With SubStr( tmp->ORIGEM, 1,  10 ),; 
                     MPR->CODFAB With SubStr( tmp->ORIGEM, 11, 13 ),; 
                     MPR->DESCRI With SubStr( tmp->ORIGEM, 27, 30 ),; 
                     MPR->UNIDAD With SubStr( tmp->ORIGEM, 117, 2 ),; 
                     MPR->PRECOV With Val( SubStr( tmp->ORIGEM, 119, 15 ) ),; 
                     MPR->CODFOR With nCodFor,; 
                     MPR->ORIGEM With SubStr( tmp->ORIGEM, 1, 3 ),; 
                     MPR->INDICE With cIndice,; 
                     MPR->CODRED With SubStr( cIndice, 4 ),; 
                     MPR->CODIGO With cIndice,; 
                     MPR->DETAL1 With SubStr( tmp->ORIGEM, 57, 60 ) 
          ENDIF 
       ENDIF 
       DisplayScan( RECNO(), nTotal, 17, 2, 2 ) 
       Processo() 
       @ 17,62 Say "�Importacao�����" 
       @ 18,62 Say Str( ( Recno() / nTotal ) * 100, 6, 2 ) + "%" 
       @ 19,62 Say Str( Recno(), 6, 0 ) + "/" + Str( nTotal, 6, 0 ) 
       TMP->( DBSkip() ) 
   ENDDO 
   SWGravar( 5 ) 
   DBCloseAll() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   dbSelectAr( _COD_MPRIMA ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � FABBARROS 
� Finalidade  � Importacao de Fabricantes Barros 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function IFabBarros() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 0, 0, 22, 79, "BARROS - CADASTRO DE FABRICANTES", _COR_GET_BOX ) 
   nCodFor:= 0 
   cMesma:= "S" 
   cAtual:= "N" 
   cGrupo:= "   " 
   cArquivo:= "ATUFOR.DBF           " 
   @ 02,03 Say "Arquivo com Informacoes.....................:" Get cArquivo 
   @ 03,03 Say "Codigo do Fornecedor........................:" Get nCodFor Pict "999999" 
   READ 
   IF LastKey()==K_ESC 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   cArquivo:= Alltrim( cArquivo ) 
   IF !File( cArquivo ) 
      Aviso( "Atencao! Arquivo " + cArquivo + " esta faltando." ) 
      Mensagem( "Pressione [ENTER] para finalizar..." ) 
      Pausa() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   SWGravar( 600 ) 
   Ajuda( "Organizando fabricantes/Origem..." ) 
   SetColor( _COR_GET_EDICAO ) 
   Sele 123 
   Ajuda( "Convertendo informacoes..." ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use &cArquivo Alias TMP 
   DBGoTop() 
   Ajuda( "Gravando arquivo de origem/fabricantes..." ) 
   nTotal:= LASTREC() 
   WHILE !tmp->( EOF() ) 
       IF Inkey()==K_ESC .OR. LastKey()==K_ESC .OR. NextKey()==K_ESC 
          EXIT 
       ENDIF 
       ORG->( DBSetOrder( 3 ) ) 
       IF !ORG->( DBSeek( Left( TMP->FORBAP, 3 ) ) ) 
          ORG->( DBAppend() ) 
          Replace ORG->CODIGO With VAL( Left( TMP->FORBAP, 3 ) ),; 
                  ORG->DESCRI With tmp->FORNOM,; 
                  ORG->CODABR With Left( TMP->FORBAP, 3 ) 
       ENDIF 
       DisplayScan( RECNO(), nTotal, 17, 2, 2 ) 
       Processo() 
       @ 17,62 Say "�Importacao�����" 
       @ 18,62 Say Str( ( Recno() / nTotal ) * 100, 6, 2 ) + "%" 
       @ 19,62 Say Str( Recno(), 6, 0 ) + "/" + Str( nTotal, 6, 0 ) 
       TMP->( DBSkip() ) 
   ENDDO 
   SWGravar( 5 ) 
   DBCloseAll() 
   AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
   dbSelectAr( _COD_MPRIMA ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
