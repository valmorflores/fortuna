// ## CL2HB.EXE - Converted
// VPCEI1U2.EXE
#Include "vpf.ch" 
#Include "inkey.ch" 
 
Function Le_serial() 
 
     Local cSerial, nLines, aPedSerial, nCliatu,; 
           nVenIn1:= nVenEx1:= 0, cVende1:= cVende2:= Space( 15 ),nOrdcli := CLI->( Indexord() ),; 
           cAreaatu := select(), ctelaSerial := ScreenSave( 0, 0, 24, 79 ) 
     Local aFalta, lGravar:= .T.
     Begin Sequence 
 
     IF !File( "SERIAL.TXT" )
        BREAK
     ENDIF
     IF SWAlerta( "Deseja Importar Informacoes do Coletor de Dados", { "Confirma", "Cancela" } )==2
        break 
     endif 

     DBSelectAr(_COD_CLIENTE)
     DBSetOrder( 1 ) 
 
     cSerial:= memoread("SERIAL.TXT") 
     nLines:= mlcount(cSerial) 
     aPedSerial:= {} 
     DBSelectAr(_COD_MPRIMA) 
     DBSetOrder( 4 ) 
 
     Aviso( "Abrindo serial, aguarde...." ) 
     /* Transferencia de informacoes p/ matriz aPedSerial */ 
     for i = 1 to nLines 
         cLinha:= memoline(cSerial,79,i) 
         if i = 1 .and. !( subst(cLinha,1,3) $ "222-111" ) 
            nCliatu := 100000001 
         elseif subst(cLinha,1,3) == "222"      /* CARTAO TEMPORARIO */ 
            nCliatu:= val(subst(cLinha,1,at(",",cLinha)-1)) 
         elseif subst(cLinha,1,3) == "111"      /* VIP-CARTAO PERMANENTE */ 
            nCliatu:= val(subst(cLinha,5,6)) 
         else
            if !(MPR->( DBSeek( PAD( subst(cLinha,1,(at(",",cLinha)-1)), 13 ) ) )) 
 
               /* Se � EAN com 12 digitos - Codigo de Barras no Fortuna � gerado com um 0 ao final */ 
               /*                           que deve ser disconsiderado nesta pesquisa com Seek    */ 
               IF !( MPR->( DBSeek( PAD( subst(cLinha,1,(at(",",cLinha)-2)), 13 ) ) )) 
                  Aviso( "Produto nao Cadastrado "+subst(cLinha,1,(at(",",cLinha)-1)), .t.) 
               ELSE 
                  /* EAN12 Digitos */ 
                  aadd( aPedSerial, { nCliatu, PAD( subst(cLinha,1,(at(",",cLinha)-2)), 13 ), val(subst(cLinha,at(",",cLinha)+1,79)) }) 
               ENDIF 
 
            else 
 
               /* EAN13 Digitos */ 
               aadd( aPedSerial, { nCliatu, subst(cLinha,1,(at(",",cLinha)-1)), val(subst(cLinha,at(",",cLinha)+1,79)) }) 
 
            endif 
         endif 
     next 
 
     DBSelectAr( _COD_MPRIMA ) 
     DBSetOrder( 4 ) 
 
 
     DBSelectar( _COD_PEDPROD ) 
     DBSetOrder( 1 ) 
 
     DBSelectAr( _COD_PEDIDO ) 
     DBSetOrder( 1 ) 
 
     nCliatu:= 0 
     nTotped:= 0

     aFalta:= {}
     for i = 1 to Len( aPedSerial )
         IF MPR->( DBSeek( PAD( aPedSerial[ i, 2 ], 13 ) ) )
            IF ( MPR->SALDO_ - aPedSerial[ i, 3 ] ) < 0
               AAdd( aFalta, { aPedSerial[ i, 2 ], LEFT( MPR->DESCRI, 30 ), MPR->SALDO_, aPedSerial[ i, 3 ] } )
            ENDIF
         ENDIF
     next

     lGravar:= .T.
     IF LEN( aFalta  ) > 0
        nRow:= 1
        VPBox( 02, 02, 19, 79, "ITENS EM FALTA", _COR_GET_BOX )
        //           1234567890123 12345678901234567890123456789012 123456789 123456789
        //        @ 03,05 Say "Produto       Descricao                            Saldo Q.Pedido "
        @ 03,03 Say "Quantidades insuficientes para "  + AllTrim( Str( Len( aFalta ) ) ) + " produto(s) no seu pedido"
        @ 04,03 Say "Favor informar o cliente e verificar junto ao responsavel pelo estoque"
        @ 05,03 Say "para evitar o fornecimento de materiais indispon�veis.                " 
        @ 06,03 Say "----------------------------------------------------------------------"
        SetCursor( 1 ) 
        oTAB:=tbrowsenew( 07, 03, 18, 78 )
        oTAB:addcolumn(tbcolumnnew("Produto",{|| aFalta[ nRow ][ 1 ] }))
        oTAB:addcolumn(tbcolumnnew("Descricao",{|| aFalta[ nRow ][ 2 ] }))
        oTAB:addcolumn(tbcolumnnew("---Maximo",{|| Tran( aFalta[ nRow ][ 3 ], "@E 9,999.99" ) }))
        oTAB:addcolumn(tbcolumnnew("Qt.Pedido",{|| Tran( aFalta[ nRow ][ 4 ], "@E 9,999.99" ) }))
        oTAB:AUTOLITE:=.f.
        oTAB:GOTOPBLOCK :={|| nROW:=1}
        oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aFalta)}
        oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aFalta,@nROW)}
        oTAB:dehilite()
        lDelimiters:= Set( _SET_DELIMITERS, .F. )
        WHILE .T.
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{1,2})
            WHILE nextkey()==0 .and. ! oTAB:stabilize()
            ENDDO
            nTecla:= Inkey(0)
            IF Chr( nTecla ) $ "Gg"
               exit
            ELSEIF nTecla == K_ESC
               lGravar:= .F.
               ScreenRest( cTelaSerial )
               select( cAreaatu ) 
               EXIT
            ENDIF
            DO CASE
               CASE nTecla==K_UP         ;oTAB:up()
               CASE nTecla==K_DOWN       ;oTAB:down()
               CASE nTecla==K_LEFT       ;oTAB:up()
               CASE nTecla==K_RIGHT      ;oTAB:down()
               CASE nTecla==K_PGUP       ;oTAB:pageup()
               CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop()
               CASE nTecla==K_PGDN       ;oTAB:pagedown()
               CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom()
               CASE nTecla==K_F12        ;Calculador()
               CASE nTecla==K_ENTER
                    nQuantidade:= aFalta[ nRow ][ 4 ]
                    @ ROW(),50 SAY "Quantidade: " GET nQuantidade
                    READ
                    lOk:= .F.
                    FOR i:= 1 TO Len( aPedSerial )
                       aFalta[ nRow ][ 4 ]:= nQuantidade
                       IF aPedSerial[ i ][ 2 ] == aFalta[ nRow ][ 1 ]
                          IF lOk
                             Aviso( "Produto esta duplicado na tabela." )
                             aPedSerial[ i ][ 3 ]:= 0
                          ELSE
                             aPedSerial[ i ][ 3 ]:= nQuantidade
                             lOk:= .t.
                          ENDIF
                       ENDIF
                    NEXT
               OTHERWISE                ;tone(125); tone(300)
            ENDCASE
            oTAB:refreshcurrent()
            oTAB:stabilize()
        ENDDO
     ENDIF

     IF lGravar
         for i = 1 to len( aPedSerial )

             /* Verifica se houve troca de cliente */
             if nCliatu <> aPedSerial[i,1]
                nCliatu := aPedSerial[i,1]
                DBSelectAr( _COD_PEDIDO )
                /* Verifica se j� existe soma em nTotPed */
                IF nTotped <> 0
                   IF netrlock()
                      Replace VLRTOT With nTotped
                      DBunlock()
                   ENDIF
                   nTotPed:= 0
                ENDIF

                lTemcota := .f.
                DBSetOrder( 4 )
                if LEN( ALLTRIM( STR( aPedSerial[ i, 1 ] ) ) ) <= 6     &&& Cliente VIP
                   CLI->(Dbseek(nCliatu))
                   cBuscacli := CLI->DESCRI
                else
                   cBuscacli := Alltrim( str( nCliatu ) ) + " - CONSUMIDOR"
                endif
                DBseek( cBuscacli )
                do while !eof() .and. alltrim(DESCRI) == alltrim(cBuscacli)
                   if SITUA_ == "COT"
                      cCodigo  := CODIGO
                      nTotPed  := VLRTOT
                      lTemcota := .t.
                      exit
                   endif
                   skip
                enddo
                DBSetOrder( 1 )
                if !lTemcota
                   DBGoBottom()
                   cCodigo:= StrZero( Val( Codigo ) + 1, 8, 0 )
                   DBAppend()
                   IF netrlock()
                      Replace CODIGO With cCodigo, DESCRI With _RESERVADO
                      Dbunlock()
                   endif
                   CLI->(Dbseek(nCliatu))
                   IF netrlock()
                      if LEN( ALLTRIM( STR( aPedSerial[ i, 1 ] ) ) ) <= 6     &&& Cliente VIP
                         Replace CODCLI With CLI->CODIGO,;
                                 DESCRI With CLI->DESCRI
                      else
                         Replace CODCLI With 0,;      &&& Cliente Temporario
                                 DESCRI With Alltrim(Str( nCliatu )) + " - CONSUMIDOR"
                      endif
                      Replace VENIN1 With nVenIn1,;
                              VENEX1 With nVenEx1,;
                              SELECT With "Nao",;
                              DATA__ With Date(),;
                              SITUA_ With "COT",;
                              VENDE1 With cVende1,;
                              VENDE2 with cVende2
           *                  TABCND With nTabCnd,;
           *                  TABOPE With nTabOpe
                      DBunlock()
                   ENDIF
                ENDIF
             ENDIF

             DBSelectar( _COD_PEDPROD )
             MPR->( DBSeek( PAD( aPedSerial[ i, 2 ], 13 ) ) )
             DBSelectar( _COD_PEDPROD )
             DBAppend()
             IF netrlock()
                Repl CODIGO With cCodigo,;
                     CODPRO With VAL( ALLTRIM( MPR->INDICE ) ),;
                     CODFAB With MPR->CODFAB,;
                     DESCRI With MPR->DESCRI,;
                     VLRINI With iif( MPR->PRECOD=0, MPR->PRECOV, MPR->PRECOD ),;
                     PERDES With MPR->PERCDC,;
                     VLRUNI With iif( MPR->PRECOD=0, MPR->PRECOV, MPR->PRECOD ),;
                     QUANT_ With aPedSerial[i,3],;
                     UNIDAD With MPR->UNIDAD,;
                     ORIGEM With MPR->ORIGEM + SPACE( 11 ),;
                     IPI___ With MPR->IPI___,;
                     PRECO1 With MPR->PRECOV,;
                     PRECO2 With PXP->VLRUNI,;
                     SELECT With "Sim",;
                     EXIBIR With "S"

        /* Prever detalhamento de produto */

        *            TABPRE With aPedido[ nCt ][ 14 ],;
        *            DESPRE With aPedido[ nCt ][ 15 ],;
        *            TABCND With aPedido[ nCt ][ 16 ],;

                /* Soma do nTotPed */
                DBunlock()
                nTotped+= ( PXP->VLRUNI * PXP->QUANT_ )
             endif
         next

         Aviso( "Finalizando rotina de importacao..." )
         /* Verifica se j� existe soma em nTotPed */
         IF nTotped <> 0
            IF PED->( netrlock() )
               Replace PED->VLRTOT With nTotped
               PED->( DBunlock() )
             ENDIF
         ENDIF

         IF File( "SERIAL.TXT" )
            !COPY SERIAL.TXT + ANTERIOR. LEITOR.TXT >NUL
            !COPY LEITOR.TXT ANTERIOR. >NUL
            FErase( "SERIAL.TXT" )
         ENDIF

     ENDIF
 
     End Sequence 
 
     DBSelectAr(_COD_CLIENTE) 
     DBSetOrder( nOrdcli ) 
     screenrest(ctelaSerial) 
     select(cAreaatu) 
     keyb chr(31)+chr(30) 
 
Return NIL 
