// ## cl2hb.exe - converted
#include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC27000.PRG 
� Finalidade  � CADASTRO DE PRODUTOS - COMPLEMENTO 
� Parametros  � Nil 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
   Function ProCompl ( nTecla ) 
 
      LOCAL nGravar:= 0
      LOCAL cCor:= SetColor(), nCursor:= SetCursor(),;
            cTela:= ScreenSave( 0, 0, 24, 79 ), nTec:= 0, nPrecoF,;
             nCdForn, cDsForn, nVago, i

 
      DO CASE 
         CASE (nTecla == K_ENTER) 
            nTec:= 1 
         CASE (nTecla == K_F5) 
            nTec:= 2 
         CASE (nTecla == K_F6) 
            nTec:= 3 
         CASE (nTecla == K_F7) 
            nTec:= 4 
         CASE (nTecla == K_F9) 
            nTec:= 5 
         CASE (nTecla == K_F10) 
            nTec:= 6 
         CASE (nTecla == K_F11) // gelson 21-09-2004
            nTec:= 11
         CASE (nTecla == K_F12) 
            nTec:= 8 
         CASE (nTecla == K_CTRL_F2) 
            nTec:= 9 
 
      ENDCASE 
 
      IF (nTec == 1 .OR. nTec == 2) 
         IF SWSet( _PRO_DETALHE ) 
            aDetalhe:= DigitaDetalhe() 
            IF netrlock() 
               Replace DETAL1 With aDetalhe[1] 
               Replace DETAL2 With aDetalhe[2] 
               Replace DETAL3 With aDetalhe[3] 
            ENDIF 
         ENDIF 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 3) 
         dbselectar(_COD_MPRIMA) 
         IF SWSet( _PRO_FORNECEDORES ) 
            cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
            cCorRes:= SetColor() 
            VPBox( 03, 01, 21, 79, " Precos de Compra & Sin�nimos do Produto ", _COR_BROW_BOX, .F., .F. ) 
            SetColor( _COR_BROW_BOX ) 
            nLin:= 04 
            aForne:= 0 ; aForne:= {} 
            AADD( aForne, { FOR001, DES001, GetPrecoFornecedor( FOR001 ), CTOD("") } ) 
            AADD( aForne, { FOR002, DES002, GetPrecoFornecedor( FOR002 ), CTOD("") } ) 
            AADD( aForne, { FOR003, DES003, GetPrecoFornecedor( FOR003 ), CTOD("")  } ) 
            AADD( aForne, { FOR004, DES004, GetPrecoFornecedor( FOR004 ), CTOD("")  } ) 
            AADD( aForne, { FOR005, DES005, GetPrecoFornecedor( FOR005 ), CTOD("")  } ) 
            AADD( aForne, { FOR006, DES006, GetPrecoFornecedor( FOR006 ), CTOD("")  } ) 
            AADD( aForne, { FOR007, DES007, GetPrecoFornecedor( FOR007 ), CTOD("")  } ) 
            AADD( aForne, { FOR008, DES008, GetPrecoFornecedor( FOR008 ), CTOD("")  } ) 
            AADD( aForne, { FOR009, DES009, GetPrecoFornecedor( FOR009 ), CTOD("")  } ) 
            AADD( aForne, { FOR010, DES010, GetPrecoFornecedor( FOR010 ), CTOD("")  } ) 
            AADD( aForne, { FOR011, DES011, GetPrecoFornecedor( FOR011 ), CTOD("")  } ) 
            AADD( aForne, { FOR012, DES012, GetPrecoFornecedor( FOR012 ), CTOD("")  } ) 
            AADD( aForne, { FOR013, DES013, GetPrecoFornecedor( FOR013 ), CTOD("")  } ) 
            AADD( aForne, { FOR014, DES014, GetPrecoFornecedor( FOR014 ), CTOD("")  } ) 
            AADD( aForne, { FOR015, DES015, GetPrecoFornecedor( FOR015 ), CTOD("")  } )

            // Busca Fornecedores deste produto em PXF
            nVago:= 0
            FOR i:= 1 TO Len( aForne )
              IF aForne[i][1] == 0
                 nVago:= i
                 EXIT
              ENDIF
            NEXT
            PXF->( DBSetOrder( 1 ) )
            PXF->( DBSeek( MPR->INDICE ) )
            WHILE !PXF->( EOF() ) .AND. PXF->CPROD_ == MPR->INDICE
                 IF ( nPos:= ASCAN( aForne, {|x| x[1] == PXF->CODFOR } ) ) > 0
                 ELSE
                    IF nVago <> 0
                       aForne[nVago][1]:= PXF->CODFOR
                       aForne[nVago][3]:= PXF->VALOR_
                       aForne[nVago][4]:= PXF->DATA__
                       nVago:= nVago + 1
                       IF nVago > LEN( aForne )
                          nVago:= 0
                          EXIT
                       ENDIF
                    ENDIF
                 ENDIF
                 PXF->( DBSKIP() ) 
            ENDDO


            @ nLin, 02 SAY "Forn     Nome do Fornecedor      Cod.Fornecedor        Preco    Ult.Alt."
            nGravar:= 1

            // Exibe informacoes 
            FOR nCt:= 1 TO Len( aForne ) 
               nPrecoF:= aForne[ nCt ][ 3 ] 
               nCdForn:= aForne[ nCt ][ 1 ]
               cDsForn:= aForne[ nCt ][ 2 ]
               cData:=   DTOC( aForne[ nCt ][ 4 ] )
               IF nPrecoF == Nil
                  nPrecoF:= 0
               ENDIF
               @ nLin+nCt, 02 Say "[" + Tran( nCdForn, "999999" ) + "]"
               @ nLin+nCt, 33 Say "[" + left( cDsForn, 20 ) + "]"
               @ nLin+nCt, 56 Say "[" + Tran( nPrecoF, "@ez 999,999.999" ) + "]"
               @ nLin+nCt, 69 Say "[" + cData + "]"

               FOR->( DBSetOrder( 1 ))
               IF FOR->( DBSeek( nCdForn ) )
                  IF nCdForn == MPR->CODFOR
                     @ nLin+nCT,11 Say LEFT( FOR->DESCRI, 22 )  COLOR "15/"+ CorFundoAtual()
                  ELSE
                     @ nLin+nCT,11 Say LEFT( FOR->DESCRI, 22 )
                  ENDIF
               ENDIF
            NEXT

            FOR nCt:= 1 TO Len( aForne )
               nPrecoF:= aForne[ nCt ][ 3 ] 
               nCdForn:= aForne[ nCt ][ 1 ]
               cDsForn:= aForne[ nCt ][ 2 ] 
               @ nLin+nCt, 02 Get nCdForn Pict "999999" Valid IIF( nCdForn==0, .T., BuscaFor( @nCdForn, nLin+nCt ) ) When ; 
                 Mensagem( "Digite o codigo do fornecedor." ) 
               @ nLin+nCt, 33 Get cDsForn Pict "@S20" When; 
                 Mensagem( "Digite a nomenclatura destre produto usada por este fornecedor." )
               @ nLin+nCt, 56 Get nPrecoF Pict "@ez 999,999.999" When; 
                 Mensagem( "Digite o preco atual do produto deste fornecedor." )
               READ 
               IF LastKey() == K_ESC
                  nGravar:= 2
                  EXIT
               ENDIF
               aForne[ nCt ][ 1 ]:= nCdForn 
               aForne[ nCt ][ 2 ]:= cDsForn
               aForne[ nCt ][ 3 ]:= nPrecoF
               IF nCdForn == 0
                  nGravar:= SWAlerta( "<< CONFIRMA? >>; Deseja gravar as modificacoes nas ;tabelas de precos x fornecedores?", {"Gravar", "Cancelar"} )
                  EXIT
               ENDIF
            NEXT 
            IF netrlock()
               IF SWSet( _PRO_FORNECEDORES ) .AND. nGravar==1
                  FOR i:= 1 TO Len( aForne )
                      PutPrecoFornecedor( aForne[ i ][ 1 ], aForne[ i ][ 3 ] )
                  NEXT
                  Replace For001 With aForne[ 1][ 1 ], Des001 With aForne[ 1][ 2 ],;
                          For002 With aForne[ 2][ 1 ], Des002 With aForne[ 2][ 2 ],; 
                          For003 With aForne[ 3][ 1 ], Des003 With aForne[ 3][ 2 ],; 
                          For004 With aForne[ 4][ 1 ], Des004 With aForne[ 4][ 2 ],; 
                          For005 With aForne[ 5][ 1 ], Des005 With aForne[ 5][ 2 ],; 
                          For006 With aForne[ 6][ 1 ], Des006 With aForne[ 6][ 2 ],; 
                          For007 With aForne[ 7][ 1 ], Des007 With aForne[ 7][ 2 ],; 
                          For008 With aForne[ 8][ 1 ], Des008 With aForne[ 8][ 2 ],; 
                          For009 With aForne[ 9][ 1 ], Des009 With aForne[ 9][ 2 ],; 
                          For010 With aForne[10][ 1 ], Des010 With aForne[10][ 2 ],; 
                          For011 With aForne[11][ 1 ], Des011 With aForne[11][ 2 ],; 
                          For012 With aForne[12][ 1 ], Des012 With aForne[12][ 2 ],; 
                          For013 With aForne[13][ 1 ], Des013 With aForne[13][ 2 ],; 
                          For014 With aForne[14][ 1 ], Des014 With aForne[14][ 2 ],; 
                          For015 With aForne[15][ 1 ], Des015 With aForne[15][ 2 ] 
               ENDIF 
            ENDIF 
            ScreenRest( cTelaRes ) 
            SetColor( cCorRes )
            MPR->( DBUnlock() )
         ENDIF 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 4) 
         MoedaProduto() 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 5) 
         nTabObs:= TABOBS 
         NFObservacao( @nTabObs ) 
         IF netrlock() 
            Replace TABOBS With nTabObs 
         ENDIF 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 6) 
         nCla:= PCPCLA 
         nClaAnt:= nCla 
         ExiClasse( @nCla ) 
         IF netrlock() 
            Replace PCPCLA With nCla 
// As proximas linhas fazem com que alterando-se a classificacao zera-se o 
// tamanho especifico do produto e solicita-se um novo codigo de tamanho 
/* 
            IF !nCla == nClaAnt 
               Replace PCPTAM With 0 
               nTec:= 7 
            ENDIF 
*/ 
         ENDIF 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 7) 
         nTam:= ExiTamanhos( PCPCLA, PCPTAM ) 
         IF netrlock() 
            Replace PCPTAM With nTam 
         ENDIF 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 8) 
//       nCor:= PCPCOR 
//       ExiCores( @nCor ) 
         lCor := Confirma( 0, 0, "Este produto possui Cores?", ; 
           "Digite 'S' se este produto POSSUI tratamento de CORES !", PCPCSN ) 
         IF netrlock() 
//          Replace PCPCOR With nCor 
            Replace PCPCSN With IIF (lCor = .T., "S", "N") 
         ENDIF 
      ENDIF 
 
      IF nTec==1 .OR. nTec==9 
         InfoPorClasse() 
      ENDIF 
 
      IF (nTec == 1 .OR. nTec == 11)
         nSitCompra:= STCompra()
         IF netrlock()
            Replace SITT03 With nSitCompra // gelson 21-09-2004
         ENDIF
      ENDIF 
 
   Return .T. 
 

Function GetPrecoFornecedor( nFornecedor )
  PXF->( DBSetOrder( 1 ) )
  IF PXF->( DBSeek( MPR->INDICE ) )
     WHILE PXF->CPROD_ == MPR->INDICE .AND. !PXF->( EOF() )
         IF PXF->CODFOR == nFornecedor
            Return PXF->VALOR_
         ENDIF
         PXF->( DBSkip() )
     ENDDO
     Return 0
  ENDIF

Function PutPrecoFornecedor( nFornecedor, nPreco )
  IF nPreco + nFornecedor > 0
     PXF->( DBSetOrder( 1 ) )
     IF PXF->( DBSeek( MPR->INDICE ) )
        WHILE PXF->CPROD_ == MPR->INDICE .AND. !PXF->( EOF() )
           IF PXF->CODFOR == nFornecedor 
              IF PXF->( RLOCK() )
                  IF nPreco <> PXF->VALOR_
                     Replace PXF->PVELHO With PXF->VALOR_
                  ENDIF
                  Replace PXF->DATA__ With DATE() 
                  Replace PXF->VALOR_ With nPreco
                  PXF->( DBUNLOCK() )
                  Return .T.
              ENDIF
           ENDIF
           PXF->( DBSkip() )
        ENDDO
        // Se chegar neste ponto significa que nao encontrou nenhum fornecedor,
        // portanto insere a informacao 
        PXF->( DBAppend() )
        Replace PXF->CODFOR With nFornecedor,;
                PXF->CPROD_ With MPR->INDICE,;
                PXF->VALOR_ With nPreco,;
                PXF->DATA__ With DATE()
        Return .T.
     ENDIF
     Return .F.
  ENDIF
  Return .F.

Static Function BuscaFor( nCdForn, nLinha )
  IF ForSeleciona( @nCdForn ) 
      IF Lastkey() <> K_ESC
         IF nCdForn == MPR->CODFOR
            @ nLinha,11 Say LEFT( FOR->DESCRI, 22 ) COLOR "14/" + CorFundoAtual()
         ELSE
            @ nLinha,11 Say LEFT( FOR->DESCRI, 22 )
         ENDIF
         Return .T.
      ELSE
          Return .F.
      ENDIF
  ELSE
      Return .F.
  ENDIF



