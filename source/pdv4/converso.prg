#Include "Directry.Ch"

Para lCriar
lFlagCreate:= .F.
aArquivos:= Directory( "*.UPD" )
For nCt:= 1 To Len( aArquivos )

    Use (aArquivos[ nCt ][ F_NAME ]) Alias Arq1 Exclusive
    aStruct1:= DBStruct()
    ZAP

    /* Arquivo VPB */
    cArquivoVPB:= "DADOS\" + Left( aArquivos[ nCt ][ F_NAME ],;
                               AT( ".", aArquivos[ nCt ][ F_NAME ] ) ) + "VPB"

    SetColor( "R+/N" )
    @ 00,00 Say "Arquivo " + cArquivoVPB + " sendo convertido, aguarde..."

    IF File( cArquivoVPB )

       /* Abertura do arquivo VPB */
       Use (cArquivoVPB) Alias Arq2

       aStruct2:= DBStruct()
       For nCt2:= 1 To Len( aStruct1 )

           /* Se tiver um elemento diferente na matriz adiciona na estrutura */
           IF ! ( aScan( aStruct2, {|x| x[ 1 ] == aStruct1[ nCt2 ][ 1 ] } ) > 0 )
              AAdd( aStruct2, { aStruct1[ nCt2 ][ 1 ],;
                                aStruct1[ nCt2 ][ 2 ],;
                                aStruct1[ nCt2 ][ 3 ],;
                                aStruct1[ nCt2 ][ 4 ] } )
              lFlagCreate:= .T.
              SetColor( "W+/R" )
           ELSE
              SetColor( "W+/B" )
           ENDIF

           @ nCt2, 00 Say aStruct1[ nCt2 ][ 1 ]

       Next
       IF lFlagCreate .OR. !( lCriar == Nil )
          DBCreate( "RESERVA.VPF", aStruct2 )
          DBCloseAll()
          DBSelectAr( 50 )
          Use Reserva.VPF Alias Arq3
          Append From &cArquivoVPB
          @ 24,01 Say LastRec()
          Inkey(1.10)
          DBCloseArea()
          !Copy RESERVA.VPF &cArquivoVPB
          lFlagCreate:= .F.
       ENDIF
       DBCloseAll()
    ENDIF
    Cls
Next
