// ## CL2HB.EXE - Converted
#include "FORMATOS.CH" 
#Include "INKEY.CH" 
#Include "VPF.CH" 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPCINITC.PRG 
³ Finalidade  ³ PCP INICIO DE PRODUCAO - Tamanho e Cor 
³ Parametros  ³ Nil 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
// Func PCPIniTam( aProRel, nProLin, nCodigo ) //#01-I 
   Func PCPIniTam( aProRel, nProLin, nCodigo, nCorCod, nTamCod, cRot ) //#01-F 
 
      Local cCor:= SetColor( ), nCursor:= SetCursor( ),; 
            cTela:= ScreenSave( 0, 0, 24, MaxCol( ) ), cQuadro:= "COR" 
      Local aTamanhos:= {}, nTamLin:= 1, nArea:= Select( ), ; 
            nOrdem:= IndexOrd( ), lCorTopo:= .T. 
 
      IF ( cRot == Nil, cRot:= "XXX", Nil ) 
 
      nClasse:= aProRel[ nProLin ][ 5 ] 
      cTemCor:= aProRel[ nProLin ][ 6 ] 
 
      SetCursor( 1 ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
      IF (nCorCod <> 0 .OR. cTemCor == "S") //#01 
 
         VPBox (02, 08, 13, 39, "Cores", _COR_BROW_BOX, .F., .F., , , .T.) 
 
         SetColor( _COR_BROW_BARRA ) 
         @ 03, 09 SAY "<Nenhuma Cor>                 " 
 
         SetColor( _COR_BROWSE ) 
         Ajuda( "["+_SETAS+"][PgUp][PgDn]Move" ) 
 
         IF (nCorCod <> 0 .OR. cTemCor == "S") //#01 
            DBSelectAr( _COD_CORES ) 
            COR->( DbGoTop( ) ) 
            oCores:=TBrowseDB( 04, 09, 12, 38 ) 
            oCores:AddColumn( tbcolumnnew( ,{|| COR->DESCRI + SPACE( 65 ) } ) ) 
         ELSE 
            oCores:=TBrowseNew( 04, 09, 12, 38 ) 
            oCores:AddColumn( tbcolumnnew( ,{|| SPACE( 90 ) } ) ) 
         ENDIF 
 
         oCores:AutoLite:=.f. 
         oCores:dehilite( ) 
 
         oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 3 }, { 2, 1 } ) 
         WHILE !oCores:Stabilize( ) 
         ENDDO 
 
      ENDIF //#01 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
//    IF (nClasse <> 0 .OR. nTamCod <> 0) //#01-IF 
 
         SetColor( _COR_BROWSE ) 
 
         VPBox (02, 43, 13, 72, "   Tamanhos        Quantidade", _COR_BROW_BOX, .F., .F., , , .T.) 
 
         fTamanhos( @aProRel, @aTamanhos, @nTamLin, @nProLin, @nCodigo, ; 
                    @lCorTopo, nClasse, nTamCod ) 
         oTamanhos:=TBrowseNew (03, 44, 12, 71) 
         oTamanhos:AddColumn( tbcolumnnew( ,; 
            {|| aTamanhos [nTamLin, 1] + "    " + ; 
            TRAN( aTamanhos [nTamLin, 2], "@E 99,999,999.999" ) + Space( 65 ) } ) ) 
         oTamanhos:AutoLite:=.f. 
         oTamanhos:GOTOPBLOCK:={|| nTamLin:= 1} 
         oTamanhos:GOBOTTOMBLOCK:={|| nTamLin:= Len( aTamanhos ) } 
         oTamanhos:SKIPBLOCK:={|x| skipperarr( x,aTamanhos,@nTamLin )} 
         oTamanhos:dehilite( ) 
 
//    ENDIF //#01 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
      IF ( nCorCod <> 0 .OR. cTemCor == "S" ) //#01-I 
          cQuadro:= "COR" 
      ELSE 
          cQuadro:= "TAM" 
      ENDIF                                   //#01-F 
 
      SetCursor( 0 ) 
 
      WHILE .T. 
 
         SetColor( _COR_GET_EDICAO ) 
 
         IF( cQuadro = "COR" ) 
 
            // Cores 
            Mensagem( "[ENTER]Selecionar Cor   [TAB, " + CHR( 27 ) + ", " + CHR( 26 ) + ; 
               "]Sem Cor   [ESC]Sair" ) 
            IF( lCorTopo = .F. ) 
               oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, oCores:COLCOUNT  }, { 2, 1 } ) 
               WHILE !oCores:Stabilize( ) 
               ENDDO 
            ENDIF 
 
//          IF (nClasse <> 0 .OR. nTamCod <> 0) //#01-IF 
 
               fTamanhos( @aProRel, @aTamanhos, @nTamLin, @nProLin, @nCodigo, ; 
                          @lCorTopo, nClasse, nTamCod ) 
               // Tamanhos 
               oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, 3 }, { 2, 1 } ) 
               oTamanhos:RefreshAll( ) 
               WHILE !oTamanhos:Stabilize( ) 
               ENDDO 
 
//          ENDIF //#01-IF 
 
         ELSE 
 
            // Tamanhos 
            Mensagem( "[ENTER]Quantidade   [TAB, " + CHR( 27 ) + ", " + CHR( 26 ) + ; 
               "]Voltar p/Cores   [ESC]Sair" ) 
            oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, oTamanhos:COLCOUNT  }, { 2, 1 } ) 
            WHILE !oTamanhos:Stabilize( ) 
            ENDDO 
 
         ENDIF 
 
         nTecla:=inkey( 0 ) 
 
         DO CASE 
            CASE nTecla==K_ESC 
               EXIT 
            CASE nTecla==K_UP 
               IF( cQuadro = "COR" ) 
                  oCores:up( ) 
                  oCores:RefreshAll( ) 
                  WHILE !oCores:Stabilize( ) 
                  ENDDO 
                  IF( oCores:HITTOP = .T. ) 
                     SetColor( _COR_BROW_BARRA ) 
                     @ 03, 09 SAY "<Nenhuma Cor>                 " 
                     SetColor( _COR_BROWSE ) 
                     oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 3 }, { 2, 1 } ) 
                     oCores:RefreshAll( ) 
                     WHILE !oCores:Stabilize( ) 
                     ENDDO 
                     lCorTopo:= .T. 
                  ENDIF 
               ELSE 
                  oTamanhos:up( ) 
               ENDIF 
            CASE nTecla==K_DOWN 
               IF( cQuadro = "COR" ) 
                  IF( lCorTopo = .T. ) 
                     SetColor( _COR_BROWSE ) 
                     @ 03, 09 SAY "<Nenhuma Cor>                 " 
//                   IF (nClasse <> 0 .OR. nTamCod <> 0) //#01-IF 
                        oTamanhos:colorrect( { oTamanhos:ROWPOS, 1, oTamanhos:ROWPOS, oTamanhos:COLCOUNT  }, { 2, 1 } ) 
                        WHILE !oTamanhos:Stabilize( ) 
                        ENDDO 
//                   ENDIF //#01-IF 
                     lCorTopo:= .F. 
                  ELSE 
                     oCores:down( ) 
                  ENDIF 
               ELSE 
                  oTamanhos:down( ) 
               ENDIF 
            CASE nTecla==K_PGUP 
               IF( cQuadro = "COR", oCores:pageup( )  , oTamanhos:pageup( ) ) 
            CASE nTecla==K_PGDN 
               IF( cQuadro = "COR", oCores:pagedown( ), oTamanhos:pagedown( ) ) 
            CASE nTecla==K_CTRL_PGUP 
               IF( cQuadro = "COR", oCores:gotop( )   , oTamanhos:gotop( ) ) 
            CASE nTecla==K_CTRL_PGDN 
               IF( cQuadro = "COR", oCores:gobottom( ), oTamanhos:gobottom( ) ) 
            CASE nTecla==K_ENTER 
               IF( cQuadro = "COR" ) 
//                IF (nClasse <> 0 .OR. nTamCod <> 0) //#01-IF 
                     cQuadro:= "TAM" // EXCECAO 
//                ELSE 
//                   IF (lCorTopo = .F.) 
//                      nCorCod := COR -> CODIGO 
//                   ELSE 
//                      nCorCod := 0 
//                   ENDIF 
//                   EXIT 
//                ENDIF //#01-IF 
               ELSE 
                  CLEAR TYPEAHEAD 
                  fTamRecep( @aTamanhos, @nTamLin, @nTecla, @lCorTopo, ; 
                             @nCodigo, @aProRel, @nProLin, cRot ) 
//                EXIT 
               ENDIF 
            CASE nTecla==K_TAB .OR. nTecla==K_LEFT .OR. nTecla==K_RIGHT 
               IF( cQuadro = "COR" ) 
 
                  SetColor( _COR_BROW_BARRA ) 
                  @ 03, 09 SAY "<Nenhuma Cor>                 " 
                  lCorTopo:= .T. 
                  oCores:GoTop( ) 
 
                  oCores:colorrect( { oCores:ROWPOS, 1, oCores:ROWPOS, 3 }, { 2, 1 } ) 
                  oCores:RefreshAll( ) 
                  WHILE !oCores:Stabilize( ) 
                  ENDDO 
//                IF (nClasse <> 0 .OR. nTamCod <> 0) //#01-IF 
                     cQuadro:= "TAM" 
//                ENDIF //#01-IF 
               ELSE 
                  IF (nCorCod <> 0 .OR. cTemCor == "S") //#01-IF 
                     cQuadro:= "COR" 
                  ENDIF //#01-IF 
               ENDIF 
            CASE CHR( nTecla ) $ "0123456789.-" 
               IF( cQuadro = "TAM" ) 
                  KeyBoard( CHR( nTecla ) ) 
                  fTamRecep( @aTamanhos, @nTamLin, @nTecla, @lCorTopo, ; 
                             @nCodigo, @aProRel, @nProLin, cRot ) 
//                EXIT 
               ENDIF 
            OTHERWISE 
               Tone( 125 ); Tone( 300 ) 
         ENDCASE 
 
         IF( cQuadro = "COR" ) 
            oCores:RefreshCurrent( ) 
            oCores:Stabilize( ) 
         ELSE 
            oTamanhos:RefreshCurrent( ) 
            oTamanhos:Stabilize( ) 
         ENDIF 
 
      ENDDO 
 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return Nil 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fTamanhos( aProRel, aTamanhos, nTamLin, nProLin, nCodigo, lCorTopo, ; 
                   nClasse, nTamCod ) 
 
      aTamanhos:= 0 
      aTamanhos:= {} 
 
      IF( lCorTopo = .F. ) 
         nCodCor:= COR->CODIGO 
      ELSE 
         nCodCor:= 0 
      ENDIF 
 
      MPR->( DBSetOrder( 1 ) ) 
      PCL->( DBSetOrder( 2 ) ) 
 
      IF( PCL->( DBSeek( STR( nCodigo, 6 ) + aProRel [nProLin, 1] + ; 
          STR( nCodCor, 2 ) ) ) = .T. ) 
         AADD( aTamanhos, {"<Nenhum>  ", PCL->QUAT00} ) 
         IF (nClasse <> 0 .OR. nTamCod <> 0) //#02 
            IF( MPR->( DBSeek( aProRel [nProLin, 1] ) ) = .T. ) 
               IF( CLA->( DBSeek( MPR->PCPCLA ) ) = .T. ) 
                  FOR nPos = 2 TO 21 
                     cPos:= STRZERO( nPos - 1, 2 ) 
                     IF( EMPTY( CLA->TAMA&cPos ) = .T. ) 
                        EXIT 
                     ENDIF 
                     AADD( aTamanhos, {CLA->TAMA&cPos, PCL->QUAT&cPos} ) 
                  NEXT nPos 
               ENDIF 
            ENDIF 
         ENDIF //#02 
      ELSE 
         AADD( aTamanhos, {"<Nenhum>  ", 0} ) 
         IF (nClasse <> 0 .OR. nTamCod <> 0) //#02 
            IF( MPR->( DBSeek( aProRel [nProLin, 1] ) ) = .T. ) 
               IF( CLA->( DBSeek( MPR->PCPCLA ) ) = .T. ) 
                  FOR nPos = 2 TO 21 
                     cPos:= STRZERO( nPos - 1, 2 ) 
                     IF( EMPTY( CLA->TAMA&cPos ) = .T. ) 
                        EXIT 
                     ENDIF 
                     AADD( aTamanhos, {CLA->TAMA&cPos, 0} ) 
                  NEXT nPos 
               ENDIF 
            ENDIF 
         ENDIF //#02 
      ENDIF 
 
      IF( Len( aTamanhos ) <= 0 ) 
         AADD( aTamanhos, {Space( 10 ), 0} ) 
      ENDIF 
 
      nTamLin:= 1 
 
   Return( .T. ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fTamRecep( aTamanhos, nTamLin, nTecla, lCorTopo, nCodigo, aProRel, ; 
        nProLin, cRot ) 
 
      Local cCor:= SetColor( ), nCursor:= SetCursor( ),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ), nTamAnt 
 
      VpBox ( 6, 47,  9, 66, " Quantidade", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .F.) 
 
      SetColor( _COR_GET_EDICAO ) 
 
      nTamAnt:= aTamanhos [nTamLin, 2] 
 
      @  8, 49 GET aTamanhos [nTamLin, 2] ; 
         PICT( "@E 99,999,999.999" ) VALID fKeyb_( @nTecla ) 
      SetCursor( 1 ) 
      READ 
 
      IF( aTamanhos [nTamLin, 2] <> nTamAnt ) 
         fGravaPCL( @aTamanhos, @lCorTopo, @nCodigo, @aProRel, @nProLin ) 
         aProRel [nProLin, 4] := "Sim" 
      ENDIF 
 
      IF( nTecla == 0 ) 
         nTecla:= K_TAB 
      ENDIF 
 
      IF cRot == "INI" 
         FOR nCnt:= 1 TO Len( aTamanhos ) 
            IF !nCnt == nTamLin 
               aTamanhos [nCnt][2]:= 0 
            ENDIF 
         NEXT 
      ENDIF 
 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return( .T. ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fKeyB_( nTecla ) 
 
      IF( LASTKEY( ) == K_TAB ) 
         nTecla:= 0 
         KeyBoard( CHR( K_ESC ) ) 
      ENDIF 
 
   Return( .T. ) 
 
// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
 
   Func fGravaPCL( aTamanhos, lCorTopo, nCodigo, aProRel, nProLin ) 
 
      IF( lCorTopo = .F. ) 
         nCodCor:= COR->CODIGO 
      ELSE 
         nCodCor:= 0 
      ENDIF 
 
      PCL->( DBSetOrder( 2 ) ) 
 
      IF( PCL->( DBSeek( STR( nCodigo, 6 ) + aProRel [nProLin, 1] + ; 
          STR( nCodCor, 2 ) ) ) = .F. ) 
          PCL->( DBAppend( ) ) 
          PCL->CODIGO:= nCodigo 
          PCL->CODPRO:= aProRel [nProLin, 1] 
      ENDIF 
 
      IF( PCL->( NetRLock( ) ) ) 
 
         PCL->CODCOR:= nCodCor 
         PCL->QUAT00:= aTamanhos [1, 2] 
 
         FOR nPos = 2 TO LEN( aTamanhos ) 
            cPos:= STRZERO( nPos - 1, 2 ) 
            PCL->QUAT&cPos:= aTamanhos [nPos, 2] 
         NEXT nPos 
 
      ENDIF 
 
   Return( .T. ) 
 
