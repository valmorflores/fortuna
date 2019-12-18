
Function EpsonArmazena( cFuncao, Parametro )
Local nTotal:= 0
Static aProdutos
IF aProdutos==Nil
   aProdutos:= {}
ENDIF
DO CASE
   CASE cFuncao=="CANCELA_ITEM"
        IF Parametro <= Len( aProdutos )
           IF aProdutos[ Parametro ][ 1 ] == "<EXCLUIDO>"
              Return .F.
           ELSE
              aProdutos[ Parametro ][ 1 ]:= "<EXCLUIDO>"
              Return .T.
           ENDIF
        ELSE
           Return .F.
        ENDIF

   CASE cFuncao=="ABRE_CUPOM"
        Return .T.

   CASE cFuncao=="VENDE_ITEM"
        AAdd( aProdutos, Parametro )
        Return .T.

   CASE cFuncao=="FINALIZA_CUPOM"
        aProdutos:= Nil
        Return .T.

   CASE cFuncao=="TOTAL_CUPOM" .OR. cFuncao=="SUBTOTAL_CUPOM"
        FOR nCt:= 1 TO LEN( aProdutos )
            IF ! aProdutos[ nCt ][ 1 ] == "<EXCLUIDO>"
               nTotal:= nTotal + ( aProdutos[ nCt ][ 4 ] * aProdutos[ nCt ][ 5 ] )
            ENDIF
        NEXT
        Return nTotal
   CASE cFuncao=="CANCELA_CUPOM"
        nTotal:= 0
        FOR nCt:= 1 TO LEN( aProdutos )
            IF ! aProdutos[ nCt ][ 1 ] == "<EXCLUIDO>"
               nTotal:= nTotal + ( aProdutos[ nCt ][ 4 ] * aProdutos[ nCt ][ 5 ] )
            ENDIF
        NEXT
        Return .T.

ENDCASE
Return Nil

Function EpsonAbre()
EpsonArmazena( "ABRE_CUPOM" )

Function EpsonVende( cCodigo, cDescricao, cUnidade, nQuantidade, nPreco )
Static nAcumulador
IF nAcumulador == Nil
   nAcumulador:= 0
ENDIF
IF nAcumulador == 7
   nAcumulador:= 0
ENDIF
nAcumulador:= nAcumulador + 1
EpsonArmazena( "VENDE_ITEM", { cCodigo, cDescricao, cUnidade, nQuantidade, nPreco } )
Return ( nAcumulador==7 )

Function EpsonFinaliza()
nTotal:= EpsonArmazena( "TOTAL_CUPOM" )
EpsonArmazena( "FINALIZA_CUPOM" )
Return nTotal

Function EpsonCancela( nPosicao )
Return EpsonArmazena( "CANCELA_ITEM", nPosicao )

Function EpsonCanCupom()
Return EpsonArmazena( "CANCELA_CUPOM" )

