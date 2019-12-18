// ## CL2HB.EXE - Converted
#Include "Inkey.Ch" 
#Include "VPF.Ch" 
 
#ifdef HARBOUR
function montagem()
#endif


   Local cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local aImpressao:= {}, aMatriz[100], nCont:= 1,; 
         cCodigo:= "0000000     ", aProd:= {}, nAbertura:= 10,; 
         nRow:= 1, oTab 
 
 
   Local aCont[100], nGrau:= 1, aProdutos[100][1] 
//   ALTD(1) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   /* Enquanto nao pegar um produto com valores nao sai daqui */ 
   WHILE .T. 
      VPSet( 2, .T. ) 
      SetColor( _COR_GET_EDICAO ) 
      DBSelectAr( _COD_MPRIMA ) 
      VisualProdutos() 
      cCodigo:= MPR->INDICE 
      If LastKey()==K_ESC 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      Endif 
      FdbuseVPB( _COD_MPRIMA ) 
      FdbuseVPB( _COD_ASSEMBLER ) 
      nLin:= 0 
      aProdutos:= BuscaASM( cCodigo )[ 1 ] 
      If ValType( aProdutos ) == "C" 
         If aProdutos <> "VAZIO" 
            Exit 
         Else 
            cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
            Aviso( " Selecione apenas produtos com composicao! " ) 
            Inkey(5) 
            ScreenRest( cTelaRes ) 
         Endif 
      Else 
         Exit 
      Endif 
   ENDDO 
   aCt:= {1,1,1,1,1,1,1,1,1,1} 
   aProd:= {} 
 
   aCt:= {1,1,1,1,1,1,1,1,1} 
   nLin:= 0 
   nCont:= 0 
   nGrupo:= 1 
   aProdutos:= BuscaASM( cCodigo ) 
   For nCt:= 1 To Len( aProdutos ) 
       nRecNo:= Recno() 
       AAdd( aImpressao, "" + Tran( aProdutos[ nCt ][ 1 ], "@r 999-9999" )  + Tran( aProdutos[ nCt ][ 2 ], "@E *,***,***.****" ) + Space( 70 ) ) 
       If DBSeek( aProdutos[ nCt ][ 1 ] ) .AND. nAbertura > 1 
          aProd:= BuscaASM( aProdutos[ nCt ][ 1 ] ) 
          For nCt2:= 1 To len( aProd ) 
              AAdd( aImpressao, Space( 3 ) + "" + Tran( aProd[ nCt2 ][ 1 ], "@r 999-9999" )  + Tran( aProd[ nCt2 ][ 2 ], "@E *,***,***.****" ) + Space( 67 ) ) 
              If DBSeek( aProd[ nCt2 ][ 1 ] ) .AND. nAbertura > 2 
                 aProd1:= BuscaASM( aProd[ nCt2 ][ 1 ] ) 
                 For nCt3:= 1 To len( aProd1 ) 
                     AAdd( aImpressao, Space( 6 ) + "" + Tran( aProd1[ nCt3 ][ 1 ], "@r 999-9999" )  + Tran( aProd1[ nCt3 ][ 2 ], "@E *,***,***.****" ) + Space( 64 ) ) 
                     If DBSeek( aProd1[ nCt3 ][ 1 ] ) .AND. nAbertura > 3 
                        aProd2:= BuscaASM( aProd1[ nCt3 ][ 1 ] ) 
                        For nCt4:= 1 To len( aProd2 ) 
                            AAdd( aImpressao, Space( 9 ) + "" + Tran( aProd2[ nCt4 ][ 1 ], "@r 999-9999" )  + Tran( aProd2[ nCt4 ][ 2 ], "@E *,***,***.****" ) + Space( 61 ) ) 
                            If DBSeek( aProd2[ nCt4 ][ 1 ] ) .AND. nAbertura > 4 
                               aProd3:= BuscaASM( aProd2[ nCt4 ][ 1 ] ) 
                               For nCt5:= 1 To len( aProd3 ) 
                                   AAdd( aImpressao, Space( 12 ) + "" + Tran( aProd3[ nCt5 ][ 1 ], "@r 999-9999" )  + Tran( aProd3[ nCt5 ][ 2 ], "@E *,***,***.****" ) + Space( 58 ) ) 
                                   If DBSeek( aProd3[ nCt5 ][ 1 ] ) .AND. nAbertura > 5 
                                      aProd4:= BuscaASM( aProd3[ nCt5 ][ 1 ] ) 
                                      For nCt6:= 1 To len( aProd4 ) 
                                          AAdd( aImpressao, Space( 15 ) + "" + Tran( aProd4[ nCt5 ][ 1 ], "@r 999-9999" )  + Tran( aProd4[ nCt5 ][ 2 ], "@E *,***,***.****" ) + Space( 55 ) ) 
                                      Next 
                                   Endif 
                               Next 
                            Endif 
                        Next 
                     EndIf 
                 Next 
              EndIf 
          Next 
       EndIf 
       DBGoto( nRecNo ) 
   Next 
   If Empty( aImpressao ) 
      FechaArquivos() 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   EndIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 2, 3, 24 - 3, 79 - 3, "Montagem (Abertura)", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   DBSelectArea( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   DBSeek( cCodigo ) 
   @ 3, 4 Say cCodigo + " = " + MPr->Descri 
   For nCt:= 1 To Len( aImpressao ) 
       cCodres:= Alltrim( aImpressao[ nCt ] ) 
       IF DBSeek( SubStr( cCodRes, 2, 3 ) + SubStr( cCodRes, 6, 4 ) ) 
          aImpressao[ nCt ]:= RTrim( aImpressao[ nCt ] ) + " -¯ "+ DESCRI 
       ENDIF 
   Next 
   DBSelectArea( _COD_ASSEMBLER ) 
   SetColor( _COR_BROWSE ) 
   SetCursor( 0 ) 
   Mensagem( "Pressione ENTER para selecionar ou ESC para retornar." ) 
   oTAB:=tbrowsenew( 4, 4, 24 - 4, 79 - 4 ) 
   oTAB:addcolumn(tbcolumnnew(,{|| aImpressao[ nRow ] })) 
   oTAB:AUTOLITE:=.f. 
   oTAB:GOTOPBLOCK :={|| nROW:=1} 
   oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aImpressao)} 
   oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aImpressao,@nROW)} 
   oTAB:dehilite() 
   whil .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1}) 
      whil nextkey()==0 .and. ! oTAB:stabilize() 
      end 
      TECLA:=inkey(0) 
      if TECLA==K_ESC   ;exit   ;endif 
      do case 
         case TECLA==K_UP         ;oTAB:up() 
         case TECLA==K_DOWN       ;oTAB:down() 
         case TECLA==K_LEFT       ;oTAB:up() 
         case TECLA==K_RIGHT      ;oTAB:down() 
         case TECLA==K_PGUP       ;oTAB:pageup() 
         case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
         case TECLA==K_PGDN       ;oTAB:pagedown() 
         case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   end 
   FechaArquivos() 
   setcursor(1) 
   setcolor(cCor) 
   ScreenRest( cTela ) 
 
Static Function BuscaASM( cCodigo ) 
   Local nOrdem:= IndexOrd(), aProdutos:= {} 
   DBSetOrder( 1 ) 
   If DBSeek( cCodigo ) 
      While CodPrd == cCodigo 
          AAdd( aProdutos, { CodMpr, Quant_ } ) 
          DBSkip() 
      EndDo 
   EndIf 
   IF Len( aProdutos ) < 1 
      Return { "VAZIO", "VAZIO" } 
   ENDIF 
   Return( aProdutos ) 
 
 
 
 
