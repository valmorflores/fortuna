#Define COLMENSAGEM  12
#Define _MENSROL      "Soft&Ware Informatica Sistemas & Conultoria      [ Fone: 51xx-471.6600 / 51xx-9112.8364 ]"
#Define _MENSCOR      "W+/GR"

#Include "COMMON.CH"
#Include "INKEY.CH"
#Include "VPF.CH"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ MenuNew
³ Finalidade  ³ Acrescenta uma nova opcao no menu de opcoes
³ Parametros  ³ Linha, Coluna, Opcao, Posicao, CorDestaque, Mensagem, , , , CorMensagem, bExecuteWhen
³ Retorno     ³ aMenu
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function MenuNew( nLin, nCol, cOpcao, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, bExecuteWhen )

   Static nModulo
   local aMenu, cLetra, lAtivo:= .T.

   Arg5:=  IIF( ValType(Arg5)  == ValType(acolor()[2]) .AND. Arg5 != Nil, Arg5, acolor()[2])
   Arg9:=  IIF( ValType(Arg9)  == ValType(SetColor()) .AND. Arg9 != Nil, Arg9, SetColor())
   Arg8:=  IIF( ValType(Arg8)  == ValType(0) .AND. Arg8 != Nil, Arg8, 0)
   Arg6:=  IIF( ValType(Arg6)  == ValType("") .AND. Arg6 != Nil, Arg6, "")
   Arg11:= IIF( ValType(Arg11) == ValType({|| .F.}) .AND. Arg11 != Nil, Arg11, {|| .F.})
   bExecuteWhen:= IF( ValType( bExecuteWhen ) == ValType( {|| .F. } ), bExecuteWhen, {|| .F.} )
   IF ! MenuList == Nil
      IF Len( MenuList ) <= 0
         nModulo:= 0
      ENDIF
   ELSE
      nModulo:= 0
   ENDIF

   IF nModulo == NIL
      nModulo:= 0
   ENDIF

   If (ValType(Arg4) != "N")
      cLetra:= Left(alltrim(cOpcao), 1)
      Arg4:= At(cLetra, cOpcao)
   else
      cLetra:= SubStr(cOpcao, Arg4, 1)
   endif
   if (Arg10)
      Arg7:= iif(ValType(Arg7) == ValType(Set(_SET_MESSAGE)) .AND. Arg7 != Nil, Arg7, Set(_SET_MESSAGE))
      Arg8:= MaxCol() / 2 - Int(Len(Arg6) / 2)
   elseif (ISNIL(Arg7))
      Arg7:= iif(ValType(Arg7) == ValType(Set(_SET_MESSAGE)) .AND. Arg7 != Nil, Arg7, Set(_SET_MESSAGE))
      Arg8:= 0
   endif

   lAtivo:= Habilitado( ++nModulo )
   IF SWSet( _SYS_CONFIGSENHAS )
      lAtivo:= HabSenhas( nModulo )
   ENDIF
   aMenu:= { nLin, nCol, cOpcao, cLetra, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, bExecuteWhen, lAtivo }
   return aMenu

********************************
function MENUDISPLA(Arg1, Arg2)

   local nCt
   DesligaMouse()
   if (ValType(Arg1) = "A")
      Arg2:= iif(ValType(Arg2) == ValType(acolor()[1]) .AND. Arg2 != ;
         Nil, Arg2, acolor()[1])
      DispBegin()
      for nCt:= 1 to Len(Arg1)
         /* Testa se e p/ deixar ativo */
         IF Arg1[nCt][14] .OR. SWSet( _SYS_CONFIGSENHAS )
            @ Arg1[nCt][1], Arg1[nCt][2] say Arg1[nCt][3] color Arg2
            @ Arg1[nCt][1], Arg1[nCt][2] + Arg1[nCt][5] - 1 say Arg1[nCt][4] color Arg1[nCt][6]
         ELSE
            @ Arg1[nCt][1], Arg1[nCt][2] say Arg1[nCt][3] color "08" + SubStr( Arg2, 3 )
            @ Arg1[nCt][1], Arg1[nCt][2] + Arg1[nCt][5] - 1 say Arg1[nCt][4] color "08" + SubStr( Arg1[nCt][6], 3 )
         ENDIF
      next
      DispEnd()
   endif

   VPMENS( 02, 00, MenBarraRolagem, SWSet( _GER_BARRACOR ) )

   LigaMouse()
   return Nil

********************************
FUNCTION MenuModal( MenuList, nOpcao, Arg3, Arg4 )

   LOCAL nTecla:= 0, Local2, Local3, Local4, Local5[Len(MenuList)], Local6, Local7, ;
         Local8, Local9, Local10, aExecuteWhen:= {}
   LOCAL lMouse:= SWSet( _SYS_MOUSE ), lMouseStatus, bBlock
   LOCAL lMoveCMouse:=.F., lPresMouse:=.F., lOkMouse:=.F., nTEMPO:= TempoMouse()
   LOCAL nCt:=0, nCT2:=0, nANTARG2, RESARG2, lMuda:= .T.
   local nContagem:= 0, nPs, nXRow, nXCol

   Local7:= setcursor(0)
   Local8:= acolor()[2]
   Local9:= acolor()[1]
   Local10:= {|_1, _2| (DevPos((DevPos(MenuList[nOpcao][1],;
          MenuList[nOpcao][2]), DevOut(MenuList[nOpcao][3], _1), MenuList[nOpcao][1]),;
          MenuList[nOpcao][2] + MenuList[nOpcao][5] - 1), DevOut(MenuList[nOpcao][4],  iif(_2, MenuList[nOpcao][6], _1)))}



   MenuList:= iif(ValType(MenuList) == ValType({}) .AND. MenuList != Nil, MenuList, {})
   Arg3:= iif(ValType(Arg3) == ValType({0, 0, ""}) .AND. Arg3 != Nil, Arg3, {0, 0, ""})
   Arg4:= iif(ValType(Arg4) == ValType("") .AND. Arg4 != Nil, Arg4, "")


   Local4:= {|| ( DevPos( 24-1, Int( MaxCol() - Len( MenuList[nOpcao][7] ) ) / 2 ), DevOut( MenuList[nOpcao][7], MenuList[nOpcao][10] ) ) }

   nMovRow:= MouseRow()
   nMovCol:= MouseCol()

   Keyboard Chr( 0 )

   IF nOpcao==0 .OR. nOpcao > Len( MenuList )
      nOpcao:=1
   ENDIF

   FOR nCt:= 1 TO Len( MenuList )
       AAdd( aExecuteWhen, MenuList[ nCt ][ 12 ] )
   NEXT

   readvar(Arg4)
   if (ValType(nOpcao) != "N")
      nOpcao:= 1
   endif
   if (!Empty(MenuList))
      if (nOpcao > Len(MenuList))
         nOpcao:= Len(MenuList)
      endif
      if (nOpcao < 1)
         nOpcao:= 1
      endif
      menudispla(MenuList, Local9)

      do while (.T.)

         Local5[nOpcao]:= iif( Empty( MenuList[nOpcao][7] ), ;
            ScreenSave( 24-1, 0, 24-1, MaxCol() ), ;
            ScreenSave( MenuList[nOpcao][8], MenuList[nOpcao][9], MenuList[nOpcao][8], MaxCol() ) )

         lMouseStatus:= MouseStatus()
         DesligaMouse()
         DEVPOS( 00,00 )
         IF SWSet( _SYS_CONFIGSENHAS ) .AND. lMuda
            DispBegin()
            VPBox( MenuList[ 1 ][ 1 ] - 1, MenuList[ 1 ][ 2 ] + LEN( MenuList[ 1 ][ 3 ] ) + 2,;
                   MenuList[ Len( MenuList ) ][ 1 ] + 1, MenuList[ 1 ][ 2 ] + LEN( MenuList[ 1 ][ 3 ] ) + 6 )
            FOR nPs:= 1 TO Len( MenuList )
                DevPos( MenuList[nPs][1], MenuList[nPs][2] + LEN( MenuList[nPs][3] ) + 3 )
                DevOut( IF( MenuList[ nPs ][14], "SIM", "NAO" ), IF( MenuList[ nPs ][14], "15/02", "15/01" ) )
            NEXT
            DispEnd()
         ENDIF
         LigaMouse( lMouseStatus )

         /* FAZ PULAR OS MUDULOS QUE ESTAO DESABILITADOS */
         nContagem:= 0
         FOR nCt:= 1 TO LEN( MenuList )
             IF !MenuList[ nOpcao ][ 14 ] .AND. !SWSet( _SYS_CONFIGSENHAS )
                IF nTecla == K_DOWN .OR. nTecla == 0 .OR. nTecla == K_RIGHT
                   ++nOpcao
                   IF nOpcao > Len( MenuList )
                      nOpcao:= 1
                   ENDIF
                ELSEIF nTecla == K_UP .OR. nTecla == K_LEFT
                   --nOpcao
                   IF nOpcao < 1
                      nOpcao:= Len( MenuList )
                   ENDIF
                ENDIF
             ENDIF
             IF MenuList[ nOpcao ][ 14 ] .OR. SWSet( _SYS_CONFIGSENHAS )
                EXIT
             ENDIF
         NEXT

         lMouseStatus:= MouseStatus()
         DesligaMouse()
         dispBegin()
         eval( Local10, Local8, .F. )
         Eval( {|| DevPos( 23, 00 ), DevOut( Space( 80 ), MenuList[ nOpcao ][ 10 ] ) } )
         eval( Local4 )
         dispEnd()
         Eval( aExecuteWhen[ nOpcao ] )
         LigaMouse( lMouseStatus )
         nTecla:= 0
         nANTARG2:=nOpcao
         do while (.T.)
            lMoveCMouse:= .F.
            Relogio( 00, 63 )
            SetPos( Arg3[1], Arg3[2] )
            DevOut( iif( ISBLOCK( Arg3[3] ), eval( Arg3[3] ), Arg3[3] ) )
            lPresMouse:= if( MouseBOff(1)==1, .t., .f. )
            if lMouse .AND. lPresMouse
               For nCT:=1 to Len(MenuList)
                   If MouseRow()=MenuList[nCT][1] .AND.;
                      MouseCol()>=MenuList[nCT][2] .AND.;
                      MouseCol()<=MenuList[nCT][2]+;
                      Len(MenuList[nCT][3])-1 .AND.;
                      MenuList[ nCT ][ 14 ]
                      If lPresMouse
                         lPresMouse:= .T.
                         lOkMouse:= .T.
                         nOpcao:= nCt
                         MouseBOff( 1 )
                         lPresMouse:= .F.
                         lOkMouse:= .F.
                         Keyboard Chr( 13 )
                         Exit
                      Else
                         nCT:=nOpcao
                         nCT2:=0
                         lPresMouse:= .F.
                         lOkMouse:= .F.
                      Endif
                   Else
                      nOpcao:= nANTARG2
                   Endif
               Next
            Else
               lPresMouse:= .F.
               lMoveCMouse:= .F.
               nRESnTecla:=nTecla
               if lMouse
                  For nCT:=1 to Len(MenuList)
                      If MouseRow()=MenuList[nCT][1] .AND.;
                         MouseCol()>=MenuList[nCT][2] .AND.;
                         MouseCol()<=MenuList[nCT][2]+Len(MenuList[nCT][3])-1 .AND. MenuList[ nCt ][ 14 ]
                         IF !( nMovRow == MouseRow() ) .OR. !( nMovCol == MouseCol() )
                            lOkMouse:=.F.
                            nOpcao:=nCT
                            Exit
                         ENDIF
                      Endif
                   Next
                   If nOpcao<>nAntArg2
                      lPresMouse:=.T.
                   Else
                      lPresMouse:=.F.
                   Endif
                Endif
            Endif

            IF ( !Empty( nTecla:= InKey() ) )

               /* Se o mouse nao se movimentar */
               IF MouseCol() == nMovCol .AND. MouseRow() == nMovRow
                  lMoveCMouse:= .F.
               ELSE
                  lMoveCMouse:= .T.
               ENDIF
               nMovRow:= MouseRow()
               nMovCol:= MouseCol()

               IF lMoveCMouse
                  nTecla:=nResnTecla
               ELSE
                  EXIT
               ENDIF
            ELSEIF lPresMouse
               EXIT
            ENDIF

            /* Botao direito do Mouse */
            cCorBest:= "15/05"
            IF lMouse
               For nCT:=1 to Len(MenuList)
                   If MouseRow()=MenuList[nCT][1] .AND.;
                      MouseCol()>=MenuList[nCT][2] .AND.;
                      MouseCol()<=MenuList[nCT][2]+Len(MenuList[nCT][3])-1 .AND. MenuList[ nCT ][ 14 ]
                      IF MouseBOff(2)==2
                         nMCol:= M_Col()
                         nMRow:= M_Row()
                         cTelaRS2:= ScreenSave( 0, 0, 24, 79 )
                         cCorRS2:= SetColor()
                         SetColor( cCorBest )
                         lMouseStatus:= MouseStatus()
                         DesligaMouse()
                         VPBox( nMRow - 1, nMCol - 1, nMRow + 3, nMCol + 26, , cCorBest )
                         @ nMRow, nMCol Say " <?> " + PAD( Left( MenuList[ nCt ][ 7 ], 20 ) + " ", 20 )
                         IF Len( Alltrim( PAD( SubStr( MenuList[ nCt ][ 7 ], 20, 20 ), 20 ) ) ) > 0
                           @ nMRow+1, nMCol + 5 Say PAD( SubStr( MenuList[ nCt ][ 7 ], 21, 20 ) + " ", 20 )
                           IF Len( Alltrim( PAD( SubStr( MenuList[ nCt ][ 7 ], 41, 20 ), 20 ) ) ) > 0
                              @ nMRow+2, nMCol + 5 Say PAD( SubStr( MenuList[ nCt ][ 7 ], 41, 20 ), 20 )
                           ENDIF
                         ENDIF
                         WHILE MouseCol() == nMCol .AND. MouseRow() == nMRow
                         ENDDO
                         ScreenRest( cTelaRS2 )
                         SetColor( cCorRS2 )
                         LigaMouse( lMouse )
                         Exit
                      ENDIF
                      Exit
                   ENDIF
               NEXT
            ENDIF

            /* Se mouse estiver ativo */
            IF lMouse .AND. MouseBOff(2)==2
               nMCol:= MouseCol()
               nMRow:= MouseRow()
               cTelaRS2:= ScreenSave( 0, 0, 24, 79 )
               cCorRS2:= SetColor()
               SetColor( cCorBest )
               lMouseStatus:= MouseStatus()
               DesligaMouse()
               DO CASE
                  CASE MouseRow()==2
                     nXCol:= 12
                     VPBox( nMRow - 1, nXCol - 1, nMRow + 15, nXCol + 56, , cCorBest )
                     @ nMRow, nXCol Say " S&W - Informa‡äes                                 "
                     @ nMRow+2, nXCol + 5 Say " Os profissionais respons veis  pela Soft&Ware "
                     @ nMRow+3, nXCol + 5 Say " Inform tica atuam no mercado  de  desenvolvi- "
                     @ nMRow+4, nXCol + 5 Say " mento de sistemas desde 1992, trasendo em sua "
                     @ nMRow+5, nXCol + 5 Say " bagagem uma gama composta por mais de 150 cli "
                     @ nMRow+6, nXCol + 5 Say " clientes at‚ o ano de 1999.                   "
                     @ nMRow+7, nXCol + 5 Say " "
                  CASE MouseRow() == 0
                     nXCol:= 12
                     nXRow:= 3
                     VPBox( nXRow - 1, nXCol - 1, nXRow + 15, nXCol + 56, , cCorBest )
                     @ nXRow, nXCol Say " INFORMACOES SOBRE O SISTEMA                       "
                     @ nXRow+2, nXCol + 5 Say "                                               "
                     @ nXRow+3, nXCol + 5 Say "                                               "
                     @ nXRow+4, nXCol + 5 Say "                                               "
                     @ nXRow+5, nXCol + 5 Say "                                               "
                     @ nXRow+6, nXCol + 5 Say "                                               "
                     @ nXRow+7, nXCol + 5 Say " "
                  CASE MouseRow() == 23
                     nXRow:= MouseRow()
                     nXCol:= MouseCol()
                     VPBox( nXRow - 1, nXCol - 1, nXRow + 2, nXCol + 56, , cCorBest )
                     @ nXRow, nXCol Say " Mensagem de auxilio aos modulos do sistema "
                  CASE MouseRow() == 24
                     nXRow:= MouseRow()
                     nXCol:= MouseCol()
                     VPBox( nXRow - 2, nXCol - 2, nXRow + 1, nXCol + 56, , cCorBest )
                     @ nXRow - 1, nXCol Say " Ajuda as teclas ativas a utilizacao "
               ENDCASE
               WHILE MouseCol() == nMCol .AND. MouseRow() == nMRow
               ENDDO
               ScreenRest( cTelaRS2 )
               SetColor( cCorRS2 )
               LigaMouse( lMouse )
            ENDIF
         ENDDO
         If lPresMouse
            lMouseStatus:= MouseStatus()
            DesligaMouse()
            nRESARG2:=nOpcao
            nOpcao:=nANTARG2
            eval(Local10, Local9, .T.)
            nOpcao:=nRESARG2
            eval(Local10, Local8, .F.)
            LigaMouse( lMouseStatus )
         Endif
         if (Local5[nANTARG2] != Nil)
            DesligaMouse()
            ScreenRest( Local5[nANTARG2] )
            LigaMouse( lMouseStatus )
         endif

         If !lPresMouse
            lMouseStatus:= MouseStatus()
            DesligaMouse()
            eval(Local10, Local9, .T.)
            LigaMouse( lMouseStatus )
         Endif
            if (Set(_SET_EXACT))
               if (ascan(MenuList, {|_1| _1[4] == Chr(nTecla)}, nOpcao) == ;
                    nOpcao)
                  if (Empty(Local3:= ascan(MenuList, {|_1| _1[4] == ;
                        Chr(nTecla)}, nOpcao + 1)))
                     Local3:= ascan(MenuList, {|_1| _1[4] == Chr(nTecla)})
                  endif
               else
                  Local3:= ascan(MenuList, {|_1| _1[4] == Chr(nTecla)}, 1)
               endif
            elseif (ascan(MenuList, {|_1| Upper(_1[4]) == ;
                  Upper(Chr(nTecla))}, nOpcao) == nOpcao)
               if (Empty(Local3:= ascan(MenuList, {|_1| Upper(_1[4]) == ;
                     Upper(Chr(nTecla))}, nOpcao + 1)))
                  Local3:= ascan(MenuList, {|_1| Upper(_1[4]) == ;
                     Upper(Chr(nTecla))})
               endif
            else
               Local3:= ascan(MenuList, {|_1| Upper(_1[4]) == ;
                  Upper(Chr(nTecla))}, 1)
            endif
            if lOkMouse
               Local3:=nOpcao
               IF ModuloExiste( nOpcao, MenuList )
                  SetOpcao( MenuList, nOpcao )
               ENDIF
            endif
            do case
            case !Empty(Local3)
               nOpcao:= Local3
               IF !MenuList[ nOpcao ][ 14 ] .AND. !SWSet( _SYS_CONFIGSENHAS )
                  FOR nCt:= 1 TO LEN( MenuList )
                     IF !MenuList[ nOpcao ][ 14 ]
                         ++nOpcao
                         IF nOpcao > Len( MenuList )
                            nOpcao:= 1
                         ENDIF
                      ENDIF
                      IF MenuList[ nOpcao ][ 14 ] .OR. SWSet( _SYS_CONFIGSENHAS )
                         EXIT
                      ENDIF
                  NEXT
               ELSE
                  if (!Set(_SET_CONFIRM)) .OR. lPresMouse
                     If !lPresMouse
                        lMouseStatus:= MouseStatus()
                        DesligaMouse()
                        eval(Local10, Local8, .F.)
                        LigaMouse( lMouseStatus )
                     Endif
                     Local6:= eval(MenuList[nOpcao][12], MenuList, @nOpcao, nTecla)
                     Local6:= iif(ValType(Local6) == ValType(.F.) .AND. ;
                        Local6 != Nil, Local6, .F.)

                     if (!Local6)
                        Keyboard chr( 13 )
                        //nTecla:= 13Chr( K_ENTER )
                        //exit
                     elseif (nOpcao < 1 .OR. nOpcao > Len(MenuList))
                        nOpcao:= 1
                     endif
                  endif
               ENDIF
            case nTecla == 27
               IF nOpcao <> 0
                  Guardiao( MenuList[nOpcao][3] )
               ELSE
                  Guardiao( "Saida de Menu" )
               ENDIF
               nOpcao:= 0
               SetOpcao( MenuList, nOpcao )
               exit

            case nTecla == K_TAB
                ExecutePDV()

            case nTecla == 5 .OR. nTecla == 19
               if (--nOpcao < 1)
                  nOpcao:= iif(Set(_SET_WRAP), Len(MenuList), 1)
               endif

            case nTecla == 24 .OR. nTecla == 4
               if (++nOpcao > Len(MenuList))
                  nOpcao:= iif(Set(_SET_WRAP), 1, Len(MenuList))
               endif
            case nTecla == 13
               DesligaMouse()
               IF ModuloExiste( nOpcao, MenuList )
                  AddSenhas( MenuList )
                  AddPoderes( .T. )
                  SetOpcao( MenuList, nOpcao )
                  //GravaSenhas()
               ENDIF
               Guardiao( MenuList[nOpcao][3] )
               eval(Local10, Local8, .F.)
               Local6:= eval(MenuList[nOpcao][12], nTecla, MenuList, @nOpcao)
               Local6:= iif(ValType(Local6) == ValType(.F.) .AND. ;
                  Local6 != Nil, Local6, .F.)
               LigaMouse( lMouseStatus )
               if (!Local6)
                  exit
               elseif (nOpcao < 1 .OR. nOpcao > Len(MenuList))
                  nOpcao:= 1
               endif
            case nTecla == 1
               nOpcao:= 1
            case nTecla == 6
               nOpcao:= Len(MenuList)
            Case nTecla == K_SPACE
               IF SWSet( _SYS_CONFIGSENHAS )
                  MenuList[ nOpcao ][ 14 ]:= IF( MenuList[ nOpcao ][ 14 ], .f., .t. )
                  lMuda:= .T.
                  //AddSenhas( MenuList )
               ENDIF
            Case nTecla == K_F1
               IF SWSet( _SYS_CONFIGSENHAS )
                  //MenuList[ nOpcao ][ 14 ]:= IF( MenuList[ nOpcao ][ 14 ], .f., .t. )
                  AddSenhas( MenuList )
                  AddPoderes( .T. )
                  GravaSenhas()
               ENDIF

            Case !( bBlock:= SETKEY( nTecla - 256 ) ) == NIL .OR.;
                 !( bBlock:= SETKEY( nTecla ) ) == NIL
                 Eval( bBlock )

            endcase
      enddo
   endif
   setcursor(Local7)
   return IIF( Empty(MenuList), .F., LastKey() != K_ESC )


function ACOLOR( aCor )

   local aCorSingle, cCorSg, nPos, nCt
   aCorSingle:= {}
   cCorSg:= ""
   aCor:= iif( ValType(aCor) == ValType(SetColor()) .AND. ;
               aCor != Nil, aCor, SetColor())
   for nCt:= 1 to 5
      nPos:= At(",", aCor)
      cCorSg:= Left(aCor, nPos - 1)
      aCor:= SubStr(aCor, nPos + 1)
      if (nCt == 5 .AND. Empty(cCorSg))
         AAdd(aCorSingle, aCorSingle[2])
      else
         AAdd(aCorSingle, cCorSg)
      endif
      cCorSg:= ""
   next
   return aCorSingle

* EOF
function Relogio(LIN,COL,cCOR)
Local nLin:= 0, nCol:= 70
@ nLin,nCol Say Time() Color Cor[2]
VPMENS( 02, 00, MenBarraRolagem, SWSet( _GER_BARRACOR ) )
Return(.T.)


Function SetOpcao( MenuList, nOpcao )
Static cOpcao
IF MenuList == NIL
   IF cOpcao == Nil
      cOpcao:= ""
   ENDIF
   Return cOpcao
ELSE
   IF nOpcao == Len( MenuList ) .OR. nOpcao == 0
      IF cOpcao == NIL
         cOpcao:= ""
      ELSE
         cOpcao:= Left( cOpcao, Len( cOpcao ) - 3 )
      ENDIF
   ELSE
      IF cOpcao == NIL
         cOpcao:= StrZero( nOpcao, 2, 0 )
      ENDIF
      cOpcao:= cOpcao +  StrZero( nOpcao, 2, 0 ) + "."
   ENDIF
ENDIF
IF cOpcao == Nil
   Return ( cOpcao:= "" )
ENDIF


Function HabSenhas( nModulo )
Local aFile:= {}, lVerifica:= .T.,;
      aSenhas, cOpcao:= SetOpcao() + Repl( "00.", 20 ), cString,;
      nCt
aSenhas:= ADDPoderes( .F. )
FOR nCt:= 1 To Len( aSenhas )
    cString:= "[" + PAD( Alltrim( aSenhas[ nCt ][ 1 ] ) + Repl( "00.", 20 ), 30 ) + Space( 8 ) + PAD( aSenhas[ nCt ][ 2 ], 80 )
    AAdd( aFile, cString )
NEXT
GuardaPoderes( aFile )
FOR nCt:= 1 TO Len( aFile )
   IF PAD( cOpcao, 29 ) == SubStr( aFile[ nCt ], 2, 29 )
      lVerifica:= IF( At( StrZero( nModulo, 2, 0 ), SubStr( aFile[ nCt ], 40 ) ) > 0, .F., .T. )
   ENDIF
NEXT
Return lVerifica


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Guardapoderes
³ Finalidade  ³
³ Parametros  ³
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function GuardaPoderes( aPoderes )
Static aPod
IF !aPoderes == Nil
   IF Len( aPoderes ) <= 0
      aPod:= Nil  /* forca a funcao habilita a recolocar informacoes no array */
   ELSE
      aPod:= aPoderes
   ENDIF
ELSEIF aPoderes == NIL
   Return aPod
ENDIF

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ HABILITADO
³ Finalidade  ³ Verifica se o modulo esta habilitado ao uso
³ Parametros  ³ nModulo
³ Retorno     ³ .T.;.F.
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Habilitado( nModulo )
Local aFile:= {}, lDisponivel:= .T.,;
      cOpcao:= SetOpcao() + Repl( "00.", 20 ),;
      nCt
IF GuardaPoderes() == NIL
   aFile:= IOFillText( MEMOREAD( "SENHAS.SYS" ) )
   GuardaPoderes( aFile )
ELSE
   aFile:= GuardaPoderes()
ENDIF
FOR nCt:= 1 TO Len( aFile )
   IF pad( cOpcao, 29 ) == SubStr( aFile[ nCt ], 2, 29 )
      lDisponivel:= IF( At( StrZero( nModulo, 2, 0 ), SubStr( aFile[ nCt ], 40 ) ) > 0, .F., .T. )
      IF !lDisponivel
         Exit
      ENDIF
   ENDIF
NEXT
Return lDisponivel


Function ModuloExiste( nOpcao, MenuList )
Local aFile:= {}, nCt:= 0, lExiste:= .F.
Local cOpcao
IF GuardaPoderes() == NIL
   aFile:= IOFillText( MEMOREAD( "SENHAS.SYS" ) )
   GuardaPoderes( aFile )
ELSE
   aFile:= GuardaPoderes()
ENDIF
IF nOpcao == Len( MenuList )  /* Quando for 0>Retorna */
   lExiste:= .T.
ELSE
   FOR nCt:= 1 TO Len( aFile )
       cOpcao:= SetOpcao()
       IF cOpcao == NIL
          cOpcao:= ""
       ENDIF
       /* O PROBLEMA ESTA AQUI */
       IF "[" + cOpcao + StrZero( nOpcao, 2, 0 ) == ;
          Left( aFile[ nCt ], Len( cOpcao ) + 3 )
          lExiste:= .T.
       ENDIF
   NEXT
ENDIF
Return lExiste

/* guarda os poderes do usuario */
Function AddPoderes( lGrava, aPriPoderes )
Static aPoderes
IF ! aPriPoderes == Nil
   aPoderes:= aPriPoderes
   Return Nil
Endif
IF aPoderes == Nil
   aPoderes:= {}
ENDIF
IF !lGrava
   Return aPoderes
ENDIF
IF lGrava
   /* Verifica se ja existe poderes guardados para esta opcao */
//   @ 01,01 SAY PAD( SUBSTR( ALLTRIM( aPoderes[4][1] ) + REPL( "00.", 20 ), 1, 29 ) + ".", 30 )
//   @ 02,01 SAY PAD( SetOpcao() + REPL( "00.", 20 ), 30 )
//   INKEY(0)
   IF ( nPosicao:= ASCAN( aPoderes, {|x| PAD( SUBSTR( x[1] + REPL( "00.", 20 ), 1, 29 ) + ".", 30 ) == PAD( SetOpcao() + REPL( "00.", 20 ), 30 ) } ) ) > 0
       aPoderes[ nPosicao ][ 2 ]:= AddSenhas()
   ELSE
       /* Guarda os poderes */
       AAdd( aPoderes, { SetOpcao(), AddSenhas() } )
   ENDIF
ENDIF


/* Adiciona os poderes deste modulo */
Function AddSenhas( MenuList )
Local cMenuDes, nCt
Static cMenuDesabilita
IF MenuList == Nil
   cMenuDes:= cMenuDesabilita
   cMenuDesabilita:= NIL
   Return cMenuDes
ENDIF
cMenuDesabilita:= "["
/* pega a opcao atual */
FOR nCt:= 1 To Len( MenuList )
    IF !MenuList[ nCt ][ 14 ]
       cMenuDesabilita+= StrZero( nCt, 2, 0 ) + "."
    ENDIF
NEXT
cMenuDesabilita:= LEFT( cMenuDesabilita, Len( cMenuDesabilita ) - 1 ) + "]"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ GRAVASENHAS
³ Finalidade  ³ Gravar os poderes em disco
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function GravaSenhas()
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor()
Local nCt
VPBox( 08, 08, 12, 60, ,_COR_GET_BOX )
nCodigo:= M->nCodUser
SetColor( _COR_GET_EDICAO )
@ 10,10 Say " Salvar no Grupo N§: " get nCodigo Valid nCodigo > 0 .AND. nCodigo < 999
READ
xFile:= SWSet( _SYS_DIRREPORT ) + "\SENHAS." + StrZero( nCodigo, 3, 0 )
aMatriz:= AddPoderes( .F. )
Set Printer to &xFile
Set Device To Print
@ PROW(),PCOL() Say ZipChr( "SEGURANCA-GUARDIAO.SYS" ) + Chr( 13 ) + Chr( 10 )
@ PROW(),PCOL() Say "------ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-------ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" + Chr( 13 ) + Chr( 10 )
FOR nCt:= 1 TO Len( aMatriz )
    aMatriz[ nCt ][ 1 ]:= Alltrim( aMatriz[ nCt ][ 1 ] ) + REPL( "00.", 20 )
    @ PROW(), PCOL() Say "[" + pad( aMatriz[ nCt ][ 1 ], 29 ) + "]"
    IF AT( "[", aMatriz[ nCt ][ 2 ] ) == 0
       aMatriz[ nCt ][ 2 ]:= "[" + aMatriz[ nCt ][ 2 ]
    ENDIF
    IF AT( "]", aMatriz[ nCt ][ 2 ] ) == 0
       aMatriz[ nCt ][ 2 ]:= aMatriz[ nCt ][ 2 ] + "]"
    ENDIF
    @ PROW(), PCOL() Say "          " + pad( aMatriz[ nCt ][ 2 ], 80 ) + Chr( 13 ) + Chr( 10 )
NEXT
@ PROW(), PCOL() Say ZipChr( "--SISTEMA DE SENHAS [Quando conseguires desvendar este codigo sera tarde demais]--" ) + Chr( 13 ) + Chr( 10 )
@ PROW(), PCOL() Say ZipChr( "--FORTUNA Automacao Comercial - 1992 / 1999 - Todos Os Direitos Reservados (C)  --" ) + Chr( 13 ) + Chr( 10 )
@ PROW(), PCOL() Say ZipChr( "--by Valmor Pereira Flores--" ) + Chr( 13 ) + Chr( 10 )
Set Device to Screen
Set Printer to LPT1
SetColor( cCor )
ScreenRest( cTela )

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³
³ Finalidade  ³
³ Parametros  ³
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ConfiguraSenhas
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() )
Local xFile, aArray, aPoderes, nCt

  VPBox( 10, 10, 16, 78, " GRUPO & PODERES ", _COR_GET_BOX )
  @ 11,11 Say "Utilizar Grupo N§: " Get nCodUser Pict "999" Valid ( nCodUser > 0 .OR. nGCodUser==999 ) .AND. nCodUser < 999
  @ 12,11 Say "Voce deve definir o grupo de usuarios que deseja"
  @ 13,11 Say "configuarar podendo ser selecionado de 001 a 998"
  Read
  xFile:= SWSet( _SYS_DIRREPORT ) + "\SENHAS." + StrZero( nCodUser, 3, 0 )
  aArray:= IOFillText( MEMOREAD( xFile ) )
  aPoderes:= {}
  FOR nCt:= 1 TO Len( aArray )
      IF AT( "[", aArray[ nCt ] ) > 0
         AAdd( aPoderes, { SubStr( aArray[nCt], 2, 28 ), SubStr( aArray[nCt], 41 ) } )
      ENDIF
  NEXT
  AddPoderes( , aPoderes )
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ ACESSO
³ Finalidade  ³ Acessar Informacoes Sobre Modulos
³             ³ LReturn=.F. Indica que esta acessivel o modulo e .T.
³             ³             Indica que nÆo esta acessivel, pois ‚ p/
³             ³             utilizacao com um comando CASE Acesso( nTecla )
³             ³             acima das rotinas INS/DEL/ENTER
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Sexta, 26 de fevereiro de 1999 …s 10:19 horas
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Acesso( nTecla )
  Local lReturn:= .F.
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, MaxCol() ), nArea:= Select()
  Local cModulo
   IF !File( SWSet( _SYS_DIRREPORT ) + "\SENHACFG.DBF" )
      aStr:= {{"MODULO","C",30,00 },;
              {"TECLA_","N",03,00 },;
              {"SIMNAO","C",01,00 }}
      DBCreate( SWSet( _SYS_DIRREPORT ) + "\SENHACFG.DBF", aStr )
   ENDIF
   Sele 124
   IF Used()
      DBCloseArea()
   ENDIF
   IF !Used()
      cDirEmp:= SWSet( _SYS_DIRREPORT ) + "\SENHACFG.DBF"
      Use &cDirEmp Alias EMP
   ENDIF
   IF !Used()
      Return .F.
   ENDIF
   Index On MODULO To INDICE0X.NTX
   Set Index To INDICE0X.NTX
   /* Set estiver na configuracao de senhas */
   cModulo:= Trim( ProcName( 1 ) )
   IF SWSet( _SYS_CONFIGSENHAS ) .AND. !nTecla==NIL
      IF !DBSeek( cModulo + StrZero( nCodUser, 3, 0 ) + Str( nTecla, 4, 0 ) )
         DBAppend()
         Replace MODULO With cModulo + StrZero( nCodUser, 3, 0 ) + Str( nTecla, 4, 0 ),;
                 TECLA_ With nTecla,;
                 SIMNAO With "N"
         Aviso( "Tecla Desativada" )
         lReturn:= .T.
      ELSE
         IF NetRLock()
            Replace SIMNAO With IF( SIMNAO=="S", "N", "S" )
            IF SIMNAO == "S"
               Aviso( "Tecla Ativada" )
            ELSE
               Aviso( "Tecla Desativada" )
            ENDIF
            lReturn:= .T.
         ENDIF
      ENDIF
      Inkey(0.5)
   ELSEIF !SWSet( _SYS_CONFIGSENHAS )
      IF DBSeek( cModulo + cUserGrupo + Str( nTecla, 4, 0 ) )
         IF SIMNAO=="S"
            lReturn:= .F.
         ELSE
            Aviso( "Desulpe " + Alltrim( SubStr( M->wUsuario, 1, AT( " ", M->wUsuario ) ) )+ ", mas esta tecla nao esta acessivel." )
            Inkey(1)
            lReturn:= .T.
         ENDIF
      ELSE
         lReturn:= .F.
      ENDIF
   ENDIF
   DBGoTop()
   DBCloseArea()
   DBSelectAr( nArea )
   Setcolor(cCOR)
   Setcursor(nCURSOR)
   Screenrest(cTELA)
   Return lReturn

/* FUNCOES PARA RODAR COM EXOSPACE */

Static Function MouseRow()
return 0

Static Function MouseCol()
Return 0

Static Function M_Col()
Return 0

Static Function M_Row()
Return 0

Static Function MouseStatus()
Return .F.

Static Function MouseBOff()
Return 0
