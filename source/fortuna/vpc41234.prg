// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "INKEY.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC41234 
³ Finalidade  ³ Outros Complemento a Clientes 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/

#ifdef HARBOUR
function vpc41234()
#endif

para nCodCliente 
loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), oTB, nTecla, lFlag:=.F.,; 
     aPos:={ 18, 0, 22, 79 }, nArea:= Select(), nOrdem:= IndexOrd(),; 
     GetList:= {}, nOrd:= IndexOrd() 
Loca cDigVer 
Loca nRegistro 
Loca cObser1, cObser2, cObser3, cObser4, cObser5, nValorCred, dValid_ 
Loca dDatInf 
 
   DBSelectAr( _COD_INFOCLI ) 
   If !Used() 
      lFlag:=.T. 
      If !file( _VPB_INFOCLI ) 
         CreateVPB( _COD_INFOCLI ) 
      EndIf 
      If !fdbusevpb( _COD_INFOCLI ) 
         aviso("ATENCAO! Verifique o arquivo " + _VPB_INFOCLI + ".",24/2) 
         Mensagem( "Erro na abertura do arquivo de Clientes, tente novamente...") 
         pausa() 
         setcolor(cCOR) 
         setcursor(nCURSOR) 
         screenrest(cTELA) 
         return(.t.) 
      EndIf 
   EndIf 
 
   /* Busca - Cliente */ 
   CLF->( DBSetOrder( 1 ) ) 
   IF nCodCliente <> Nil 
      CLF->( DBSeek( nCodCliente ) ) 
   ENDIF 
   nRegistro:= CLI->( RECNO() ) 
   nPreReg:= PRE->( RECNO() ) 
   PRE->( DBSetOrder( 1 ) ) 
   nOrd:= IndexOrd() 
   setcolor(COR[16]) 
   VPBox( 0, 0, aPos[1]-1, 79, " OUTRAS INFORMACOES DE CLIENTES ", _COR_GET_BOX, .F., .F. ) 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "CLIENTES", _COR_BROW_BOX, .F., .F. ) 
   SetCursor( 0 ) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [F8]BuscaInformacao [ESC]Retorna") 
   DBSelectAr( _COD_CLIENTE ) 
   DBLeOrdem() 
   DBGoTo( nRegistro ) 
   oTB:=tBrowseDb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew(,{|| StrZero( CLI->CODIGO, 6, 0 ) + " " + CLI->DESCRI + Space( 30 ) })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   cAviso:= "Data limite de credito expirada! Renove!" 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      CLF->( DBSetOrder( 1 ) ) 
      /* Codigo / Descri - Cliente */
      IF CLF->( CODIGO ) <> CLI->CODIGO
         CLF->( DBSeek( CLI->CODIGO ) ) 
         //IF !CLF->DESCRI==CLI->DESCRI 
         //   IF CLF->( NetRLock() ) .AND. !CLI->( EOF() ) 
         //      Replace CLF->DESCRI With CLI->DESCRI 
         //   ENDIF 
         //ENDIF 
      ENDIF 
      SetColor( _COR_GET_CURSOR )

      // ANTERIOR
      lAnterior:= .F.
      CLF->( DBSkip( -1 ) )
      IF !CLF->( BOF() )
         IF CLF->CODIGO == CLI->CODIGO
            lAnterior:= .T.
            @ 01,02 SAY "<<"
         ELSE
            lAnterior:= .F.
            @ 01,02 SAY "  "
         ENDIF
         CLF->( DBSkip( +1 ) )
      ENDIF

      // POSTERIOR
      lPosterior:= .F.
      CLF->( DBSkip( +1 ) )
      IF !CLF->( EOF() )
         IF CLF->CODIGO == CLI->CODIGO
            lPosterior:= .T.
            @ 01,06 SAY ">>"
         ELSE
            lPosterior:= .F.
            @ 01,06 SAY "  "
         ENDIF
         CLF->( DBSkip( -1 ) )
      ENDIF

      @ 02,02 Say LEFT( CLF->INFO01, 30 ) + " - " + LEFT( CLF->COMP01, 20 ) + " - " + LEFT( CLF->SUBC01, 20 ) 
      @ 03,02 Say LEFT( CLF->INFO02, 30 ) + " - " + LEFT( CLF->COMP02, 20 ) + " - " + LEFT( CLF->SUBC02, 20 ) 
      @ 04,02 Say LEFT( CLF->INFO03, 30 ) + " - " + LEFT( CLF->COMP03, 20 ) + " - " + LEFT( CLF->SUBC03, 20 ) 
      @ 05,02 Say LEFT( CLF->INFO04, 30 ) + " - " + LEFT( CLF->COMP04, 20 ) + " - " + LEFT( CLF->SUBC04, 20 ) 
      @ 06,02 Say LEFT( CLF->INFO05, 30 ) + " - " + LEFT( CLF->COMP05, 20 ) + " - " + LEFT( CLF->SUBC05, 20 ) 
      @ 07,02 Say LEFT( CLF->INFO06, 30 ) + " - " + LEFT( CLF->COMP06, 20 ) + " - " + LEFT( CLF->SUBC06, 20 ) 
      @ 08,02 Say LEFT( CLF->INFO07, 30 ) + " - " + LEFT( CLF->COMP07, 20 ) + " - " + LEFT( CLF->SUBC07, 20 ) 
      @ 09,02 Say LEFT( CLF->INFO08, 30 ) + " - " + LEFT( CLF->COMP08, 20 ) + " - " + LEFT( CLF->SUBC08, 20 ) 
      @ 10,02 Say LEFT( CLF->INFO09, 30 ) + " - " + LEFT( CLF->COMP09, 20 ) + " - " + LEFT( CLF->SUBC09, 20 ) 
      @ 11,02 Say LEFT( CLF->INFO10, 30 ) + " - " + LEFT( CLF->COMP10, 20 ) + " - " + LEFT( CLF->SUBC10, 20 ) 
      @ 12,02 Say LEFT( CLF->INFO11, 30 ) + " - " + LEFT( CLF->COMP11, 20 ) + " - " + LEFT( CLF->SUBC11, 20 ) 
      @ 13,02 Say LEFT( CLF->INFO12, 30 ) + " - " + LEFT( CLF->COMP12, 20 ) + " - " + LEFT( CLF->SUBC12, 20 ) 
      @ 14,02 Say LEFT( CLF->INFO13, 30 ) + " - " + LEFT( CLF->COMP13, 20 ) + " - " + LEFT( CLF->SUBC13, 20 ) 
      @ 15,02 Say LEFT( CLF->INFO14, 30 ) + " - " + LEFT( CLF->COMP14, 20 ) + " - " + LEFT( CLF->SUBC14, 20 ) 
      @ 16,02 Say LEFT( CLF->INFO15, 30 ) + " - " + LEFT( CLF->COMP15, 20 ) + " - " + LEFT( CLF->SUBC15, 20 ) 
      SetColor( _COR_BROWSE ) 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTB:up() 

         case nTecla==K_LEFT
              IF lAnterior
                 CLF->( DBSkip( -1 ) )
              ENDIF

         case nTecla==K_RIGHT      
              IF lPosterior
                 CLF->( DBSkip( +1 ) )
              ENDIF

         case nTecla==K_DOWN       ;oTB:down()
         case nTecla==K_PGUP       ;oTB:pageup() 
         case nTecla==K_PGDN       ;oTB:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
         case nTecla==K_ENTER 
              SetColor( _COR_GET_EDICAO ) 
              SetCursor( 1 ) 
              IF CLF->( EOF() ) 
                 CLF->( DBAppend() ) 
              ENDIF 
              IF CLF->( NetRLock() ) 
                 Replace CLF->CODIGO With CLI->CODIGO,; 
                         CLF->DESCRI With CLI->DESCRI 
                 cInfo01:= CLF->INFO01 
                 cComp01:= CLF->COMP01 
                 cSubC01:= CLF->SUBC01 
                 cInfo02:= CLF->INFO02 
                 cComp02:= CLF->COMP02 
                 cSubC02:= CLF->SUBC02 
                 cInfo03:= CLF->INFO03 
                 cComp03:= CLF->COMP03 
                 cSubC03:= CLF->SUBC03 
                 cInfo04:= CLF->INFO04 
                 cComp04:= CLF->COMP04 
                 cSubC04:= CLF->SUBC04 
                 cInfo05:= CLF->INFO05 
                 cComp05:= CLF->COMP05 
                 cSubC05:= CLF->SUBC05 
                 cInfo06:= CLF->INFO06 
                 cComp06:= CLF->COMP06 
                 cSubC06:= CLF->SUBC06 
                 cInfo07:= CLF->INFO07 
                 cComp07:= CLF->COMP07 
                 cSubC07:= CLF->SUBC07 
                 cInfo08:= CLF->INFO08 
                 cComp08:= CLF->COMP08 
                 cSubC08:= CLF->SUBC08 
                 cInfo09:= CLF->INFO09 
                 cComp09:= CLF->COMP09 
                 cSubC09:= CLF->SUBC09 
                 cInfo10:= CLF->INFO10 
                 cComp10:= CLF->COMP10 
                 cSubC10:= CLF->SUBC10 
                 cInfo11:= CLF->INFO11 
                 cComp11:= CLF->COMP11 
                 cSubC11:= CLF->SUBC11 
                 cInfo12:= CLF->INFO12 
                 cComp12:= CLF->COMP12 
                 cSubC12:= CLF->SUBC12 
                 cInfo13:= CLF->INFO13 
                 cComp13:= CLF->COMP13 
                 cSubC13:= CLF->SUBC13 
                 cInfo14:= CLF->INFO14 
                 cComp14:= CLF->COMP14 
                 cSubC14:= CLF->SUBC14 
                 cInfo15:= CLF->INFO15 
                 cComp15:= CLF->COMP15 
                 cSubC15:= CLF->SUBC15 
                 Set( _SET_DELIMITERS, .F. ) 
                 @ 02,02 Get cINFO01 Pict "@S30" 
                 @ 02,35 Get cCOMP01 Pict "@S20" 
                 @ 02,58 Get cSUBC01 Pict "@S20" 
 
                 @ 03,02 Get cINFO02 Pict "@S30" 
                 @ 03,35 Get cCOMP02 Pict "@S20" 
                 @ 03,58 Get cSUBC02 Pict "@S20" 
 
                 @ 04,02 Get cINFO03 Pict "@S30" 
                 @ 04,35 Get cCOMP03 Pict "@S20" 
                 @ 04,58 Get cSUBC03 Pict "@S20" 
 
                 @ 05,02 Get cINFO04 Pict "@S30" 
                 @ 05,35 Get cCOMP04 Pict "@S20" 
                 @ 05,58 Get cSUBC04 Pict "@S20" 
 
                 @ 06,02 Get cINFO05 Pict "@S30" 
                 @ 06,35 Get cCOMP05 Pict "@S20" 
                 @ 06,58 Get cSUBC05 Pict "@S20" 
 
                 @ 07,02 Get cINFO06 Pict "@S30" 
                 @ 07,35 Get cCOMP06 Pict "@S20" 
                 @ 07,58 Get cSUBC06 Pict "@S20" 
 
                 @ 08,02 Get cINFO07 Pict "@S30" 
                 @ 08,35 Get cCOMP07 Pict "@S20" 
                 @ 08,58 Get cSUBC07 Pict "@S20" 
 
                 @ 09,02 Get cINFO08 Pict "@S30" 
                 @ 09,35 Get cCOMP08 Pict "@S20" 
                 @ 09,58 Get cSUBC08 Pict "@S20" 
 
                 @ 10,02 Get cINFO09 Pict "@S30" 
                 @ 10,35 Get cCOMP09 Pict "@S20" 
                 @ 10,58 Get cSUBC09 Pict "@S20" 
 
                 @ 11,02 Get cINFO10 Pict "@S30" 
                 @ 11,35 Get cCOMP10 Pict "@S20" 
                 @ 11,58 Get cSUBC10 Pict "@S20" 
 
                 @ 12,02 Get cINFO11 Pict "@S30" 
                 @ 12,35 Get cComp11 Pict "@S20" 
                 @ 12,58 Get cSUBC11 Pict "@S20" 
 
                 @ 13,02 Get cINFO12 Pict "@S30" 
                 @ 13,35 Get cCOMP12 Pict "@S20" 
                 @ 13,58 Get cSUBC12 Pict "@S20" 
 
                 @ 14,02 Get cINFO13 Pict "@S30" 
                 @ 14,35 Get cCOMP13 Pict "@S20" 
                 @ 14,58 Get cSUBC13 Pict "@S20" 
 
                 @ 15,02 Get cINFO14 Pict "@S30" 
                 @ 15,35 Get cCOMP14 Pict "@S20" 
                 @ 15,58 Get cSUBC14 Pict "@S20" 
 
                 @ 16,02 Get cINFO15 Pict "@S30" 
                 @ 16,35 Get cCOMP15 Pict "@S20" 
                 @ 16,58 Get cSUBC15 Pict "@S20" 
                 READ 
                 IF !LastKey()==K_ESC 
                    Replace CLF->INFO01 With cInfo01,; 
                            CLF->COMP01 With cComp01,; 
                            CLF->SUBC01 With cSubC01,; 
                            CLF->INFO02 With cInfo02,; 
                            CLF->COMP02 With cComp02,; 
                            CLF->SUBC02 With cSubC02,; 
                            CLF->INFO03 With cInfo03,; 
                            CLF->COMP03 With cComp03,; 
                            CLF->SUBC03 With cSubC03,; 
                            CLF->INFO04 With cInfo04 
                    Replace CLF->COMP04 With cComp04,; 
                            CLF->SUBC04 With cSubC04,; 
                            CLF->INFO05 With cInfo05,; 
                            CLF->COMP05 With cComp05,; 
                            CLF->SUBC05 With cSubC05,; 
                            CLF->INFO06 With cInfo06,; 
                            CLF->COMP06 With cComp06,; 
                            CLF->SUBC06 With cSubC06,; 
                            CLF->INFO07 With cInfo07,; 
                            CLF->COMP07 With cComp07,; 
                            CLF->SUBC07 With cSubC07,; 
                            CLF->INFO08 With cInfo08,; 
                            CLF->COMP08 With cComp08 
                    Replace CLF->SUBC08 With cSubC08,; 
                            CLF->INFO09 With cInfo09,; 
                            CLF->COMP09 With cComp09,; 
                            CLF->SUBC09 With cSubC09,; 
                            CLF->INFO10 With cInfo10,; 
                            CLF->COMP10 With cComp10,; 
                            CLF->SUBC10 With cSubC10,; 
                            CLF->INFO11 With cInfo11,; 
                            CLF->COMP11 With cComp11,; 
                            CLF->SUBC11 With cSubC11,; 
                            CLF->INFO12 With cInfo12,; 
                            CLF->COMP12 With cComp12,; 
                            CLF->SUBC12 With cSubC12,; 
                            CLF->INFO13 With cInfo13,; 
                            CLF->COMP13 With cComp13 
                    Replace CLF->SUBC13 With cSubC13,; 
                            CLF->INFO14 With cInfo14,; 
                            CLF->COMP14 With cComp14,; 
                            CLF->SUBC14 With cSubC14,; 
                            CLF->INFO15 With cInfo15,; 
                            CLF->COMP15 With cComp15,; 
                            CLF->SUBC15 With cSubC15 

                    // Se ultimos campos forem preenchidos e  nÆo existia
                    // uma segunda p gina o sistema automaticamente cria a
                    // mesma para a inser‡Æo de novos dados
                    IF !lPosterior .AND. ALLTRIM( CLF->INFO15 ) <> ""
                       nCodigo:= CLF->CODIGO
                       CLF->( DBAppend() )
                       Replace CODIGO With nCodigo
                       lAnterior:= .T.
                    ENDIF

                 ENDIF
              ENDIF 
              Set( _SET_DELIMITERS, .T. ) 
              SetCursor(0) 
              dbUnlockAll() 
 
         case nTecla==K_F8 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              DispBegin() 
                VPBox( 12, 01, 17, 62, " INFORMACOES ", "15/01" ) 
                @ 14,04 Say " Digite uma string para efetuar uma busca de informacoes" Color "14/01" 
                @ 15,04 Say " no painel de parametros adicionais `a ficha do cliente." Color "14/01" 
                nTec:= ASC( "_" ) 
                CLF->( DBMudaOrdem( 2, oTb ) ) 
                Keyboard Chr( K_BS ) 
              DispEnd()
              CLF->( DBPesquisa( nTec ) ) 
              CLI->( DBSetOrder( 1 ) ) 
              CLI->( DBSeek( CLF->CODIGO ) ) 
              ScreenRest( cTelaRes ) 
              CLI->( DBLeOrdem() ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
              CLF->( DBSetOrder( 1 ) ) 
 
         case DBPesquisa( nTecla, oTb ) 
 
         case nTecla==K_F2 
              DBMudaOrdem( 1, oTb ) 
 
         case nTecla==K_F3 
              DBMudaOrdem( 2, oTb ) 
 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
   CLF->( DBCloseArea() ) 
   IF !nArea==0 .AND. !nOrdem==0 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
   ENDIF 
   dbUnLockAll() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 
   Return(.T.) 
 
 
