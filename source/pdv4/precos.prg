aStruct:= {{"ORIGEM","C",100,00}}
DBCreate( "RESERVA.DBF", aStruct )
Sele A
Use DADOS\CDMPRIMA.DBF
Index On DESCRI To RESERVA.NTX
Sele B
Use RESERVA.DBF
ZAP
Append From A:ESTQM.DAT SDF
Append From A:ESTQP.DAT SDF
DBGotop()
WHILE !B->( EOF() )
   cGrupo:= StrZero( Val( SubStr( b->ORIGEM, 39, 02 ) ), 3, 0 )
   cDescricao:= SubStr( B->ORIGEM, 7, 32 ) + " - " + Left( B->ORIGEM, 6 )
   nPrecoC:= Val( SubStr( B->ORIGEM, 41, 11 ) )
   nPrecoV:= Val( Tran( SubStr( B->ORIGEM, 41, 15 ), "@R XXXXXXXXXXXXX.XX" ) )
   cCML___:= SubStr( B->ORIGEM, 56, 1 )
   A->( DBSeek( cDescricao, .T. ) )
   IF AllTrim( cDescricao ) == AllTrim( A->DESCRI )
      A->( RLock() )
      IF !A->( NetErr() )
         REPLACE A->CODRED With SubStr( A->INDICE, 4 )
         REPLACE A->CODIGO With A->INDICE
         REPLACE A->PRECOV With nPrecoV
      ENDIF
      DBUnlock()
   ENDIF
   B->( DBSkip() )
ENDDO


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ VERCodigo
³ Finalidade  ³ Verifica se codigo
³ Parametros  ³
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION VerCodigo( cGrupo )
LOCAL cCodigo:= "0000", nCodigo:= 0
    DBSeek( cGrupo + "0000", .F. )
    WHILE Left( Indice, 3 ) == cGrupo
       ++nCodigo
       DBSkip()
    ENDDO
    cCodigo:= StrZero( nCodigo, 4, 0 )
Return cCodigo
