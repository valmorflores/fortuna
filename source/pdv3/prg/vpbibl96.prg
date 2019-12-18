*************************************** VPBIBL96 *****************************************
*                 Biblioteca de Funcoes Para Aplicativos em Clipper 5.x                  *
*                            JANEIRO/1993(0) & OUTUBRO/1994                              *
*                           ULTIMAS ALTERACOES: SETEMBRO/1999                            *
****************************** Valmor Pereira Flores *************************************

#include "MOUSE.CH"
#include "VPF.CH"
#include "INKEY.CH"
#include "PTFUNCS.CH"
#include "BOX.CH"
#include "COMMON.CH"

#Define _FIL_ATIVADO       "ATIVADO.CTR"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ NOCORRECT
³ Finalidade  ³ Retornar verdadeiro caso haja algum arquivo de erro!
³ Parametros  ³ Nil
³ Retorno     ³ .T./.F.
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function NoCorrect()
Local aFiles:= {}
lOk:= .F.
!DIR *. >DIR.SYS
aFiles:= IOFillText( MemoRead( 'DIR.SYS' ) )
FOR nCt:= 1 To Len( aFiles )
    IF AT( ".", aFiles[ nCt ] ) > 0 .OR. lOk
       lOk:= .T.
       IF AT( "<DIR>", aFiles[ nCt ] ) <= 0 .AND.;
          !Left( aFiles[ nCt ], 4 ) == Space( 4 ) .AND. !SubStr( aFiles[ nCt ], 39, 2 )==Left( TIME(), 2 )
          Return .T.
       ENDIF
    ENDIF
NEXT
Return .F.

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ VPTERM
³ Finalidade  ³ Fazer um termometro
³ Parametros  ³ nPosicao, nTotal       VPTERM( .F. ) Desativa
³             ³                        VPTERM( .T. ) Forca montar a tela
³             ³                        VPTERM( nPos1, nPos2 ) Age normalmente
³ Retorno     ³ Nil
³ Programador ³ Valmor
³ Data        ³ 19/08/97
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION VPTerm( nPosicao, nTotal )
STATIC cTela
STATIC cCor
STATIC nCursor
STATIC lPrimeiraVez
STATIC nModoVisual
STATIC cHoraIni
IF cTela == NIL
   cTela:= ScreenSave( 18, 20, 24, 79 )
   cCor:= SetColor()
   nCursor:= SetCursor()
ENDIF
IF VALTYPE( nPosicao ) == "L"
   IF nPosicao
      lPrimeiraVez:= nPosicao
      cTela:= ScreenSave( 18, 20, 24, 79 )
      cCor:= SetColor()
      nCursor:= SetCursor()
      nModoVisual:= 1
      cHoraIni:= TIME()
   ELSE
      ScreenRest( cTela )
      SetCursor( 0 )
      SetColor( cCor )
      cTela:= NIL
      cHoraIni:= NIL
      lPrimeiraVez:= NIL
      Return Nil
   ENDIF
ENDIF
IF lPrimeiraVez == NIL
   lPrimeiraVez:= .T.
   nModoVisual:= 1
ENDIF
IF cHoraIni == NIL
   cHoraIni:= Time()
ENDIF
Inkey()
IF LastKey() == K_TAB
   lPrimeiraVez:= .T.
   IF nModoVisual == 1
      nModoVisual:= 2
      IF cHoraIni == NIL
         cHoraIni:= Time()
      ENDIF
   ELSE
      nModoVisual:= 1
   ENDIF
   Keyboard Chr( 0 )
ENDIF
IF lPrimeiraVez
   VPBox( 19, 20, 21, 77,  ,"15/04",  ,  ,"15/04"  )
   IF nModoVisual == 1
      SetColor( "01/15" )
      @ 18, 20 Say " Percentual Executado "
      SetColor( "01/07" )
      @ 18, 42 Say " Tempo de Execucao "
   ELSE
      SetColor( "01/07" )
      @ 18, 20 Say " Percentual Executado "
      SetColor( "01/15" )
      @ 18, 42 Say " Tempo de Execucao "
   ENDIF
   SetColor( "15/03" )
   lPrimeiraVez:= .F.
ELSE
   IF nModoVisual == 1
      SetColor( "15/05" )
      @ 20,21 Say Repl( "²", ( nPosicao / nTotal ) * 50 ) + " " + Alltrim( Str( ( nPosicao / nTotal ) * 100, 6, 2 ) ) + "%"
   ELSE
      SetColor( "15/04" )
      @ 20,21 Say " H.Inicio: " + cHoraIni
      @ 20,41 Say " H.Atual.: " + Time()
      SetColor( "14/04" )
      nHIni:=Val( StrTran( Right( cHoraIni, 5 ), ":", "." ) )
      nHAtu:=Val( StrTran( Right( Time(), 5 ), ":", "." ) )
      nC1:= Int( nHIni ) - nHIni
      nPass:= nHAtu - nHIni
      nInteiro:= Val( Left( StrZero( nPass, 5, 2 ), 2 ) )
      nSeg2:= nHAtu - Int( nHAtu )
      nSeg1:= nHIni - Int( nHIni )
      IF nPass - nInteiro > 0.59 .AND. nSeg2 >= nSeg1
         /* se os centavos forem maior que 60 */
         nPass:= ( nInteiro + 1 ) + ( ( nPass - nInteiro ) - 0.59 )
      ENDIF
      @ 20,61 Say " TPassado: " + StrZero( nPass, 5, 2 )
   ENDIF
ENDIF
SetColor( cCor )
SetCursor( nCursor )
Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Sombra2
³ Finalidade  ³ Fazer uma sombra em box
³ Parametros  ³ nLinIni=>Linha_Inicial / nColIni=>Coluna_Inicial
³             ³ nLinEnd=>Linha_Final / nColEnd=>Coluna_final
³ Retorno     ³ Nenhum
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 29/Novembro/1995
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Sombra2( nLinIni, nColIni, nLinEnd, nColEnd, cCor )
  Local cTela:= ScreenSave( 20, 70, 21, 72 )
  Local cCorFundo:= StrZero( Asc( SubStr( cTela, 5, 1 ) ), 2, 0 )
  IF !( cCor==Nil )
     cCorFundo:= cCor
  ENDIF
  SetColor( "00/" + cCorFundo )
  @ nLinEnd + 1, nColIni + 1 Say Repl( "ß", nColEnd - nColIni )
  @ nLinIni, nColEnd + 1 Say "Ü"
  For nCt:= nLinIni To nLinEnd - 1
      @ nCt + 1, nColEnd + 1 Say "Û"
  Next
  @ nLinEnd + 1, nColEnd + 1 Say "ß"
  Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ DesligaMouse
³ Finalidade  ³ Desligar o cursor do mouse.
³ Parametros  ³ Nenhum
³ Retorno     ³ Nenhum
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 29/Novembro/1995
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DesligaMouse()
   MouseStatus( .F. )
   //m_csroff()
Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ MouseStatus
³ Finalidade  ³ Desligar o cursor do mouse.
³ Parametros  ³ Nenhum
³ Retorno     ³ Nenhum
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 29/Novembro/1995
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function MouseStatus( lLigDesl )
Static lMouseStat
IF lLigDesl <> NIL
   lMouseStat:= lLigDesl
ENDIF
Return lMouseStat

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ LigaMouse()
³ Finalidade  ³ Ligar o cursor do mouse.
³ Parametros  ³ nenhum
³ Retorno     ³ nenhum
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 29/Novembro/1995
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function MLigaMouse( lMouse )
   IF lMouse == Nil
      m_csron()
      MouseStatus( .T. )
   ELSE
      IF lMouse
         m_csron()
         MouseStatus( .T. )
      ENDIF
   ENDIF
Return Nil

/*
* Funcao      - VPBOXSombra
* Finalidade  - Criacao de uma moldura
* Programador - Valmor Pereira Flores
* Data        - 11/Agosto/1993
* Atualizacao - 11/Novembro/1993
*/
Function VPBoxSombra( nLin1, nCol1, nLin2, nCol2, Txt, Color, CorFundo, Zoom, CorTitulo, lFecha, lEsquerda )
LOCAL cCor:= SetColor(), nCentral, lMouseStatus:= MouseStatus()
   DesligaMouse()
   SetColor( If( Color <> Nil, Color, Cor[10] ) )
   DispBox( nLin1, nCol1, nLin2, nCol2, _BOX_UM+" " )
   Sombra2( nLin1, nCol1, nLin2, nCol2, IF( VALTYPE( CorFundo )=="C", CorFundo, Nil ) )
   If !Empty( TXT )
      IF (lEsquerda = NIL, lEsquerda := .F., NIL)
      IF (lEsquerda = .F.)
         nCentral:=( ( nCol2 - nCol1 ) - LEN( Txt ) ) / 2
      ELSE
         nCentral:= 0
      ENDIF
      SetColor( if( CorTitulo <> nil, CorTitulo, Cor[9] ) )
      @ nLin1, nCol1 Say Space( ( nCol2 - nCol1 ) + 1 )
      @ nLin1, nCol1 + nCentral Say If( PCount()>=5, Txt, "" )
      If !Empty( lFecha )
         @ nLin1, nCol1 Say If( lFecha, _SIMB_CLOSE, "" )
      EndIf
   EndIf
   SetColor(cCor)
   LigaMouse( lMouseStatus )
   Return Nil


/*
* Funcao      - VPBOX
* Finalidade  - Criacao de uma moldura
* Programador - Valmor Pereira Flores
* Data        - 11/Agosto/1993
* Atualizacao - 11/Novembro/1993
*/
Function VPBox( nLin1, nCol1, nLin2, nCol2, Txt, Color, lSombra, Zoom, CorTitulo, lFecha )
LOCAL cCor:= SetColor(), nCentral, lMouseStatus:= MouseStatus()
   IF lFecha == NIL
      lFecha:= .T.
   ENDIF
   DesligaMouse()
   SetColor( If( Color <> Nil, Color, Cor[10] ) )
   IF lSombra==NIL
      VPSombra( nLin1 + 1, nCol1 + 2, nLin2 + 1, nCol2 + 2, 7 )
   ELSE
      IF lSombra
         VPSombra( nLin1 + 1, nCol1 + 2, nLin2 + 1, nCol2 + 2, 7 )
      ENDIF
   ENDIF
   DispBox( nLin1, nCol1, nLin2, nCol2, _BOX_UM+" " )
   If !Empty( TXT )
      nCentral:=( ( nCol2 - nCol1 ) - LEN( Txt ) ) / 2
      SetColor( if( CorTitulo <> nil, CorTitulo, Cor[9] ) )
      @ nLin1, nCol1 Say Space( ( nCol2 - nCol1 ) + 1 )
      @ nLin1, nCol1 + nCentral Say If( PCount()>=5, Txt, "" )
      If !Empty( lFecha )
         @ nLin1, nCol1 Say If( lFecha, _SIMB_CLOSE, "" )
      EndIf
   EndIf
   IF SWSet( _INT_EMATALHO ) == NIL
   ELSE
      IF SWSet( _INT_EMATALHO )
         SetColor( "14/04" )
         @ 00,53 Say " <<< Gerenciador Atalho >>>    "
      ENDIF
   ENDIF
   //if nCol2 - nCol1 < 30 .and. ( nCol2 - nCol1 ) > 15 .and. ( nLin2 - nLin1 ) > 5
      //@ nLin1 + 1, nCol1 + 1 Say " Aguarde..."
   //endif
   SetColor(cCor)
   LigaMouse( lMouseStatus )
   Return Nil

/*
* Funcao      - MENSAGEM
* Finalidade  - Exibicao de uma mensagem na linha 23 centralizado
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func mensagem(TXT,WTONE)
loca cCor:=setcolor(), nPosicao1, nPosicao2, cTexto
IF FILE( "VIDEO.256" )
   IF AT( "[ENTER]", TXT ) > 0
      cTxt:= TXT
      Run EXIBE 24 00 "&cTxt"
   ENDIF
ELSE
   setcolor(COR[6])
   scroll( 24-1, 0, 24- 1, MaxCol() )
   @ 24-1, Int( MaxCol() - Len( Txt ) ) / 2 Say TXT
   if( WTONE==1 .and. _COMSOM="S", tone(50), nil)
   /* Confirguracoes de teclas */
   WHILE At( "[", Txt ) > 0
      nPosicao1:= At( "[", Txt )
      nPosicao2:= At( "]", Txt )
      cTexto:= SubStr( Txt, nPosicao1 + 1,  ( nPosicao2 - nPosicao1 ) - 1 )
      SetColor( "14/01" )
      @ 23, ( Int( MaxCol() - Len( Txt ) ) / 2 ) + nPosicao1 Say cTexto
      Txt:= StrTran( txt, "[", "0", 1, 1 )
      Txt:= StrTran( txt, "]", "0", 1, 1 )
   ENDDO
ENDIF
setcolor(cCor)
return(.t.)

/*
* Funcao      - TITULO
* Finalidade  - Exibicao de uma mensagem na linha 02 centralizado
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func titulo(TXT)
loca cCor:=setcolor()
setcolor(COR[3])
@ 01,01 Say TXT
setcolor(cCor)
return nil

/*
* Funcao      - AVISO
* Finalidade  - Exibicao de uma mensagem com moldura
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 05/Outubro/1995
*/
Function Aviso( cTxt )
loca cCor:= SetColor(), nCol1, nCol2
Local cFundo:= "09"
Local nLin:= 14
   DesligaMouse()
   nCol1:= Int( 78 - Len(cTxt) ) / 2
   nCol2:= Int( nCol1 + 3 + Len( cTxt ) )
   SetColor( "15/15" )
   Scroll( nLin - 2, nCol1, nLin - 2, nCol2 )
   SetColor( "00/15" )
   @ nLin - 2, nCol1 Say PADC( "Aviso", nCol2 - nCol1 )
   VPSombra( nLin, nCol1 + 2, nLin + 5, nCol2 + 2 )
   SetColor( "15/" + cFundo )
   Scroll( nLin - 1, nCol1, nLin + 4, nCol2 )
   @ nLin, nCol1 + 2 Say cTxt
   DispBox( nLin - 1, nCol1, nLin + 4, nCol2, _BOX_UM )
   SetColor( "00/" + cFundo )

   SWBotao( nLin +2, 35, "  OK  ", cFundo )

   LigaMouse()
   SetColor( cCor )
Return(.t.)

/*
* Funcao      - TERMOH
* Finalidade  - Termometro horizontal com indicacao da posicao no arquivo
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func termoh(LIN,COL,VALOR)
loca cCor:=setcolor()
if VALOR<=1
   setcolor(COR[23])
   shadow(LIN,COL,LIN+6,COL+57)
   @   LIN,COL say chr(201)+repl(chr(205),56)+chr(187)
   @ ++LIN,COL say chr(186)+spac(13)+"PERCENTUAL DA TAREFA EXECUTADO"+spac(13)+chr(186)
   @ ++LIN,COL say chr(204)+repl(chr(205),05)+chr(187)+repl(repl(chr(196),4)+chr(194),9)+repl(chr(196),5)+chr(182)
   @ ++LIN,COL say chr(186)+" <%> "+chr(186)+" 10 "+chr(179)+" 20 "+chr(179)+" 30 "+chr(179)+" 40 "+chr(179)+" 50 "+chr(179)+" 60 "+chr(179)+" 70 "+chr(179)+" 80 "+chr(179)+" 90 "+chr(179)+" 100 "+chr(186)
   @ ++LIN,COL say chr(204)+repl(chr(205),05)+chr(185)+repl(repl(chr(196),4)+chr(193),9)+repl(chr(196),5)+chr(182)
   @ ++LIN,COL say chr(186)+" Ind "+chr(186)+repl(chr(250),50)+chr(186)
   @ ++LIN,COL say chr(200)+repl(chr(205),05)+chr(202)+repl(chr(205),50)+chr(188)
else
   setcolor(COR[26])
   @ LIN+5,COL+07 say repl(chr(176),VALOR/2)
endif
setcolor(cCor)
return(.t.)

/*
* Funcao      - PAUSA
* Finalidade  - Efetua uma pausa esperando pela tecla enter
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func pausa
whil .t.
  if inkey()=13
     exit
  endif
end
return nil

/*
* Funcao      - MES
* Finalidade  - Retorna o mes por extenso correspondente a data
* Programador - Valmor Pereira Flores
* Data        - 12/Agosto/1993
*/
func mes( MES )
loca M:={"Janeiro","Fevereiro","Marco","Abril","Maio","Junho","Julho","Agosto",;
         "Setembro","Outubro","Novembro","Dezembro"}
return IF( MES>=1 .AND. MES<=12, M[ MES ], "ERRO!" )

/*
* Funcao             - SEMANA
* Finalidade         - Retorna o dia da semana por extenso
* Programador        - Valmor Pereira Flores
* Data               - 12/Agosto/1993
*/
func semana( dDATA )
aDIA:={"Domingo",;
       "Segunda-feira",;
       "Terca-feira",;
       "Quarta-feira",;
       "Quinta-feira",;
       "Sexta-feira",;
       "Sabado"}
return IF( dow( dDATA )<>0, aDIA[ dow( dDATA ) ], "" )

/*
* Funcao      - BOX
* Finalidade  - Retorna uma moldura conforme parametros indicados
* Programador - Valmor Pereira Flores
* Data        - 12/Agosto/1993
*/
func box(LIN1,COL1,Lin2,COL2,TIPO,CHR,PSOMBRA)
loca WBORDA
if TIPO=1        ;WBORDA=chr(218)+chr(196)+chr(191)+chr(179)+chr(217)+chr(196)+chr(192)+chr(179)
elseif TIPO=2    ;WBORDA=chr(201)+chr(205)+chr(187)+chr(186)+chr(188)+chr(205)+chr(200)+chr(186)
elseif TIPO=3    ;WBORDA=chr(214)+chr(196)+chr(183)+chr(186)+chr(189)+chr(196)+chr(211)+chr(186)
elseif TIPO=4    ;WBORDA=chr(213)+chr(205)+chr(184)+chr(179)+chr(190)+chr(205)+chr(212)+chr(179)
endif
WBORDA=WBORDA+if(pcount()>5,CHR,space(0))
IF PSOMBRA<>NIL
   IF PSOMBRA
      VPSombra( LIN1 + 1, COL1 + 2, LIN2 + 1, COL2 + 1 )
   ENDIF
ENDIF
dispbox(LIN1,COL1,LIN2,COL2,WBORDA)

return nil

/*
* Funcao      - LASTDAY
* Objetivo    - Retorna o numero do ultimo dia do mes para data.
* Programador - Valmor Pereira Flores
* Data        - 16/Agosto/1993
* Atualizacao -
*/
func lastday(DATA1)
loca ULTDIA, NMES, NDIAS
NMES  = MONTH(DATA1)
NDIAS = 31
do case
    case NMES=4 .or. NMES=6 .or. NMES=9 .or. NMES=11
         NDIAS = 30
    case NMES  = 2
         if year(DATA1) % 4 = 0 .and. ;
             year(DATA1) % 100 != 0
             // Se o ano for divisivel por 4, mas nao por 100, trata-se de um ano bissexto.
             NDIAS = 29
         elseif year(DATA1) % 100 = 0 .and. ;
                year(DATA1) % 400 = 0
             // Se o ano for divisivel por 100, precisa ser divisivel por 400 p/ ser ano bissexto.
             NDIAS = 29
         else
             // Do contrario, este nao e' um ano bissexto.
             NDIAS = 28
         endif
endcase
return(NDIAS)

/*
* Funcao      - SHADOW
* Finalidade  - Colocacao de sombreado
* Programador - Valmor Pereira Flores
* Data        - 11/Agosto/1993
* Atualizacao - 24/Agosto/1993
*/
func shadow(LIN1,COL1,LIN2,COL2,ATRIB)
loca POINT:=CNT:=WLEN:=0, SHADOW, TELA[2]
LIN2++; COL2++
if _COMSOMBRA="N"
   return nil
endif
ATRIB=if(pcount()>4, ATRIB, val(substr(COR[14],1,2)))
TELA[1]:=savescreen(LIN2,COL1+1,LIN2,COL2+1)
TELA[2]:=savescreen(LIN1+1,COL2,LIN2,COL2+1)
for CNT = 1 to 2
    SHADOW:=space(4)+TELA[CNT]
    WLEN=len(SHADOW)
    for POINT = 6 to WLEN step 2
        SHADOW=stuff(SHADOW, POINT, 1, chr(ATRIB))
    next
    if(CNT=1,restscreen(LIN2,COL1+1,LIN2,COL2+1,substr(SHADOW,5)),;
             restscreen(LIN1+1,COL2,LIN2,COL2+1,substr(SHADOW,5)))
next
return nil

/*
* Funcao      - VPTELA
* Finalidade  - Elaboracao da tela principal dos sistemas
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 01/Setembro/1993
*/
func vptela
loca cCor:=setcolor(), XCURSOR:=setcursor(), lMouseStatus:= MouseStatus()
   DesligaMouse()
   IF !File( "C:\MSBIOS.SYS" )
      SetColor( "15/00" )
      Cls
      Aviso( " ®INSTALACAO NAO AUTORIZADA¯ " )
      Pausa()
      Cls
      Quit
   ENDIF
   nMAXLIN:=24
   nMAXCOL:=maxcol()
   scroll(00,00,24,MAXCOL())
   setcolor(COR[4])
   VPFundoFraze( 00, 00, 24, 79, ScreenBack )
   @ 01,00 Say Space(80) Color COR[3]
   Fortuna()
   @ 24-1,00 Say Space(80) Color Cor[6]
   @ 24,00 Say Space(80) Color Cor[8]
   setcolor(cCor)
   setcursor(XCURSOR)
   LigaMouse( lMouseStatus )
   return nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Fortuna
³ Finalidade  ³ Apresenta o topo do sistema
³ Parametros  ³
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Fortuna()
Loca cCor:= SetColor()
setcolor(COR[2])
@ 00,00 Say Space(80)
//@ 00,00 Say PADC(  ALLTRIM( _SIS ) , 80 )
@ 00,00 Say PADC (_VER + " - " + ALLTRIM( _SIS ), 80 - 8)
@ 00,69 say " "+DTOC( date() )+" "
SetColor( cCor )
Return Nil

/*
* Funcao      - FIM
* Finalidade  - Exibicao da tela de finalizacao do programa
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func fim
loca WCT:=0
setcolor("07/00")
setcursor(0)
for WCT=0 to 24-8
    scroll(03,00,24,79,1)
    inkey(0.1)
next
setcolor("07/00")
@ 08,00 say space(0)
dbunlockall()
FechaArquivos()
setcursor(1)
Ferase( _FIL_ATIVADO )
Ferase( "SUPORTE.CTR" )
Finaliza()

Function Finaliza( nOpcao )
If !SWSet( _SYS_COMPUTADOR ) == Nil
   Ferase( GDIR - "\INICIAR." + StrZero( SWSet( _SYS_COMPUTADOR ), 3, 0 ) )
EndIf
IF !Empty( nOpcao )
ENDIF
Quit


/*
* Funcao      - CONFIRMA
* Finalidade  - Solicitacao de confirmacao
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 02/Setembro/1993
*/
FUNCTION Confirma( nLin, nCol, cConfirma, cMensagem, cSimNao, V1, V2, nLin2, nCol2 )
   LOCAL GetList:= {}
   LOCAL cValidade:= If( PCount() > 4, cSimNao, " " )
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(1)
   LOCAL cTela1, cTela2
   LOCAL lMouseStatus:= MouseStatus()
   DesligaMouse()
   nCol:= ( 80 - Len( cConfirma ) ) / 2
   nLin:= 17
   IIF( !nLin2 == Nil, nLin := nLin2, Nil )
   IIF( !nCol2 == Nil, nCol := nCol2, Nil )
   cTela1:= ScreenSave( nLin - 3, nCol - 5, nLin + 5, nCol + Len( cConfirma ) + 9 )
   cTela2:= ScreenSave( 24 - 1, 0, 24, MaxCol() )
   SetColor("14/04,15/04")
   DispBegin()
    VPBox( nLin - 2, nCol - 5, nLin + 1, nCol + Len( cConfirma ) + 7, " Atencao ", "15/04", .T., .T., "00/15" )
    @ nLin,nCol Say Space( Len( cConfirma ) + 4 )
    Mensagem( If( cMensagem <> Nil, cMensagem, "Digite [S] para confirmar ou [N] p/ cancelar." ) )
    Ajuda("[S]Excluir [N][ESC]Cancelar")
    @ nLin,nCol Say cConfirma Get cValidade Pict "!" Valid cValidade$"SN"
   DispEnd()
   Read
   Guardiao( "<QUEST> " + cConfirma + " [" + cValidade + "]"  )
   SetColor(cCor)
   SetCursor(nCursor)
   ScreenRest( cTela1 )
   ScreenRest( cTela2 )
   LigaMouse( lMouseStatus )
Return( If( cValidade="S".AND. LastKey() <> 27, .T., .F. ) )

/*
* Funcao      - PROTECAO
* Finalidade  - Proteger os sistemas
* Programador - Valmor Pereira Flores
* Data        - 26/Novembro/1993
* Atualizacao -
MSDATA()  - TheBest
MSDATA1() - Brasil
*/
func protecao(MOD)
loca VPDADOS:=strzero(250,5,0)-strzero(257,5,0), WCT:=0, cCor:=setcolor(), XCURSOR:=setcursor(),;
     VPTESTE:=spac(0), WSENHA:="*", WNOME:="<<< Valmor Pereira Flores >>>",;
     WCOL:=0, WTESTE:="", ARQ, WEXE:="* * * ESTE SISTEMA FOI CORROMPIDO * * *",;
     GETLIST:={}, WOPCAO:=1, WTELA1:={},;
     VPSENHA:=strzero(int(59283045/3),8,0)   // Senha = 19761015
priv WSENHAG:=spac(0)
setcursor(0)
if ! file("VPCONFIG.DAT")
   if MOD==NIL
//      WTELA1:=zoom(10,10,20,70)
      vpbox(10,10,20,70," INSTALACAO ")
      setcolor(COR[15])
      @ 12,12 say "Programa  "+_VPF
      @ 13,12 say "Descricao "+_SIS
      @ 14,12 say "Empresa   "+_EMP
      @ 16,12 say "Senha.: [********]"
      @ 18,int(80-len(WNOME))/2 say WNOME
      set(_SET_CONFIRM,.f.)
      set(_SET_DELIMITERS,.f.)
      set(_SET_ESCAPE,.f.)
      setcolor(COR[17]+","+COR[18])
      @ 16,21 get WSENHA valid asterisco(@WSENHA)
      @ 16,22 get WSENHA valid asterisco(@WSENHA)
      @ 16,23 get WSENHA valid asterisco(@WSENHA)
      @ 16,24 get WSENHA valid asterisco(@WSENHA)
      @ 16,25 get WSENHA valid asterisco(@WSENHA)
      @ 16,26 get WSENHA valid asterisco(@WSENHA)
      @ 16,27 get WSENHA valid asterisco(@WSENHA)
      @ 16,28 get WSENHA valid asterisco(@WSENHA)
      read
      set(_SET_CONFIRM,.t.)
      set(_SET_DELIMITERS,.t.)
      set(_SET_ESCAPE,.t.)
      if alltrim(WSENHAG) <> alltrim(VPSENHA)
         aviso("Atencao! Senha invalida, instalacao nao autorizadada.",12)
         whil .t.
            tone(100,2)
            @ row(),col() say spac(0)
            tone(320,1)
         enddo
      endif
      if MOD==NIL
         setcolor(COR[12]+","+COR[13])
         scroll(11,11,19,69)
         @ 12,12 say "Monitor"
         @ 12,21 prompt " 1 Colorido       "
         @ 13,21 prompt " 2 Monocromatico  "
         menu to WOPCAO
         _VP2=if(WOPCAO=1,.t.,.f.)
      endif
   endif
   aviso("Aguarde instalacao do sistema...",10)
   _VP1=zipchr(VPDADOS)
   save all like _VP* to VPCONFIG.DAT
//   if(MOD==NIL,unzoom(WTELA1),NIL)
else
   rest from VPCONFIG.DAT additive
   VPTESTE=_VP1
   if VPDADOS # unzipchr(VPTESTE)
      for WCT=1 to 8
          WTELA:=savescreen(00,WCOL,24,69)
          inkey(.1)
          WCOL+=10
          scroll(00,00,24,79)
          restscreen(00,WCOL,24,79,WTELA)
      next
      scroll(00,00,24,79)
      WTELA:=savescreen(00,00,24,79)
      aviso("*** Nao e permitida a instalacao indevida deste sistema ***",12)
      frename("VPSAC.VPD",_ARQ)
      whil .t.
         tone(330,1)
         tone(220,2)
         @ row(),col() say spac(0)
         tone(430,1)
      enddo
   endif
endif
setcursor(XCURSOR)
setcolor(cCor)
return(.t.)

/*
* Funcao      - ASTERISCO
* Finalidade  - Retornar asteriscos para a senha da funcao protecao
* Programador - Valmor Pereira Flores
* Data        - 29/Novembro/1993
* Atualizacao -
*/
func asterisco(ACOD)
loca WTECLA:=lastkey()
if WTECLA=K_UP .or. WTECLA=K_DOWN .or. WTECLA=K_ESC
   return(.f.)
else
   WSENHAG:=WSENHAG+ACOD
   ACOD="*"
endif
return(.t.)

/*
* Modulo      - CANCELA
* Finalidade  - Cancelar a impressao do relatorio
* Programador - Valmor Pereira Flores
* Data        - 10/Agosto/1993
* Atualizacao - 30/Novembro/1993
*/
func cancela()
loca GETLIST:={}, WOPCAO:=0, WTELA, XTELA:=savescreen(00,00,24,79),;
     cCor:=setcolor()
set(_SET_PRINTER,.f.)
set(_SET_DEVICE,"SCREEN")
LIMPA
setcolor(COR[12]+","+COR[13])
ajuda("Selecione CANCELAR ou CONTINUAR a impressao")
mensagem("[Cancelar]Cancela a impressao, [Continuar]Retorna a impressao...")
WTELA:=zoom(10,20,14,60)
vpbox(10,20,14,60,"IMPRESSAO",COR[10])
vpbox(11,27,13,39,"",COR[10],.f.)
vpbox(11,43,13,55,"",COR[10],.f.)
whil .t.
   @ 12,28 prompt " Cancelar  "
   @ 12,44 prompt " Continuar "
   menu to WOPCAO
   if WOPCAO<>0
      exit
   endif
enddo
unzoom(WTELA)
setcolor(cCor)
restscreen(00,00,24,79,XTELA)
set(_SET_DEVICE,"PRINT")
set(_SET_PRINTER,.t.)
return(if(WOPCAO=1,.t.,.f.))

/*
* Funcao      - ALTC
* Finalidade  - Tirar o poder de finalizacao das teclas ALT-C.
* Programador - Valmor Pereira Flores
* Data        - 01/Fevereiro/1994
* Atualizacao -
*/
func altc
loca WMENS[3], XTELA:=savescreen(00,00,24,79), cCor:=setcolor(), XCURSOR:=setcursor(),;
     WTELA, GETLIST:={}
WMENS[1]:=_SIS
WMENS[2]:=_EMP
WMENS[3]:=_REG
setcursor(0)
setcolor(COR[25])
vpbox(00,00,24,79," FINALIZACAO DO SISTEMA ",COR[24])
@ 02,02 say "Programa: " + _SIS
@ 03,02 say "Empresa.: " + _EMP
@ 04,02 say "Registro: " + _REG
Inkey(2)
setcolor( "15/00" )
setcursor(XCURSOR)
Cls
Quit

/*
* Modulo      - VERUF
* Parametro   - <WPAR1>UF p/ verificacao de integridade.
* Finalidade  - Pesquisa existencia do estado digitado.
* Programador - Valmor Pereira Flores
* Data        - 01/Fevereiro/1994
* Atualizacao -
*/
func veruf(WPAR1)
LOCA nArea:= Select(), nOrdem:= IndexOrd(), nRegistro:= Recno()
loca oTAB,cCor:=setcolor(),XTELA:=savescreen(00,00,24,79), mUF:= {},;
     WTELA, aVAR, nROW:=1, nCt:= 0, GetList:= {}, cTelaRes, cEstado

AbreGrupo( "ESTADOS" )
DBSelectAr( _COD_ESTADO )
DBGOTOP()
WHILE !EOF()
    AAdd( mUF, { ESTADO, DESCRI + SPACE( 30 ) } )
    DBSkip()
ENDDO
if ASCAN( mUF, {|aVAR| aVAR[1] = upper( WPAR1 ) } ) > 0
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )
   DBGoTo( nRegistro )
   Return(.t.)
endif
setcolor(COR[21]+","+COR[22])
setcursor(0)
mensagem("Pressione ENTER para selecionar ou ESC para retornar.")
WTELA:=zoom(03,01,19,58)
vpbox(03,01,19,58,"Unidades de Federacao",COR[20],.T.,.T.,COR[19])
oTAB:=tbrowseDB(04,02,18,57)
oTAB:addcolumn(tbcolumnnew(,{|| ESTADO + " " + DESCRI + SPACE( 30 ) }))
oTAB:AUTOLITE:=.f.
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
      case TECLA==K_ENTER      ;WPAR1=ESTADO ;exit
      case UPPER( Chr( TECLA ) ) $ "ABCDEFGHIJKLMNOPQRSTUVXYZW"
           cTelaRes:= ScreenSave( 0, 0, 24, 79 )
           VPBOX( 18, 02, 20, 58, , _COR_GET_BOX )
           SetColor( _COR_GET_EDICAO )
           Keyboard Chr( Tecla )
           cEstado:= Space( 50 )
           @ 19,04 Get cEstado Pict "@!"
           READ
           ScreenRest( cTelaRes )
           SetColor( _COR_BROWSE )
           DBSetOrder( 2 )
           DBSeek( ALLTRIM( cEstado ), .T. )
           oTab:RefreshAll()
           WHILE !oTab:Stabilize()
           ENDDO
      otherwise                ;tone(125); tone(300)
   endcase
   oTAB:refreshcurrent()
   oTAB:stabilize()
end
setcursor(1)
setcolor(cCor)
unzoom(WTELA)
restscreen(00,00,24,79,XTELA)
DBSelectAr( nArea )
DBSetOrder( nOrdem )
DBGoTo( nRegistro )
return(if(TECLA=27,.f.,.t.))

/*
FUNCTION DevOut( cDevice, cCor )
Local cCorRes:= SetColor(), lMouseStatus:= .F.
Static nPosicao
IF nPosicao == Nil
   nPosicao:= 0
ENDIF
IF ++nPosicao >= 5
   nPosicao:= 0
   Guardiao()
ENDIF
IF cCor <> Nil
   cCorRes:= SetColor()
   SetColor( cCor )
ENDIF
IF MouseStatus()
   lMouseStatus:= .T.
   DesligaMouse()
ENDIF
IF Set( _SET_DEVICE ) == "SCREEN"
   DISPOUT( cDevice )
ELSE
   DEVOUTPICT( cDevice, "@X" )
ENDIF
LigaMouse( lMouseStatus )
SetColor( cCorRes )
*/

/*
* Modulo      - SKIPPERARR
* Parametro   - NTOJUMP - Quantidade de registro
*               WMATRIZ - Matriz para trabalho
* Finalidade  - Controlar acesso ao primeiro e/ou ultimo registro
*             - Auxilio ao browse de matrizes
* Programador - Valmor Pereira Flores
* Data        - 02/Fevereiro/1994
* Atualizacao
*/
func skipperarr(NTOJUMP,WMATRIZ,nROW)
loca NJUMPED:=0
if nROW + NTOJUMP < 1
   NJUMPED:=-nROW + 1
   nROW:=1
elseif nROW + NTOJUMP > len( WMATRIZ )
   NJUMPED:=len(WMATRIZ) - nROW
   nROW:=len(WMATRIZ)
else
   NJUMPED:=NTOJUMP
   nROW+=NTOJUMP
endif
return NJUMPED

/*
* Funcao      - AJUDA
* Finlidade   - Exibir uma mensagem de ajuda ao usuario na linha 24 da tela.
* Programador - Valmor Pereira Flores
* Data        -
* Atualizacao - 02/Outubro/1995
*/
Function Ajuda( cTxt )
  Local cCor:=SetColor()
  cTxt:= StrTran( cTxt, "[ENTER]", "[" + _ENTER + "]" )
  cTxt:= StrTran( cTxt, "[ESC]",   "[" + _ESC   + "]" )
  cTxt:= StrTran( cTxt, "[TAB]",   "[" + _TAB   + "]" )
  If cTxt <> Nil
     SetColor( Cor[8] )
     Scroll( 24, 0, 24, 77 )
     @ 24,Int( MaxCol()-Len( cTxt ) ) / 2 Say cTxt
  Else
     SetColor( Cor[8] )
     Scroll( 24, 0, 24, 77 )
  EndIf
  SetColor( cCor )
  return(.t.)

/*
* Funcao      - VPOBSBOX
* Finalidade  - Criacao de uma janela para observacoes
* Parametros  - TPDIR,LIN,COL,TIT,OBS,COR
* Programador - Valmor Pereira Flores
* Data        - 23/Marco/1994
*/
func vpobsbox( TPDIR, LIN, COL, TIT, OBS, PCOR, PSOMBRA )
loca cCor:=setcolor(), WTELA
IF( TPDIR, DispBegin(), Nil )
setcolor(if(PCOR<>nil,PCOR,COR[25]))
vpbox(LIN,COL,LIN+len(OBS)+1,COL+len(OBS[1])+1,TIT,;
   if(PCOR<>nil,PCOR,COR[25]),if(PSOMBRA<>nil,PSOMBRA,.T.))
++LIN
for N=1 to len(OBS)
    for N1=1 to len(OBS[N])
        N1=if(TPDIR,len(OBS[N]),N1)
        @ LIN,COL+1 say substr(OBS[N],1,N1)
        if ! TPDIR
           for N2=1 to 20
               @ 00,00 say spac(0)
               @ 00,79 say spac(0)
               @ 24,00 say spac(0)
               @ 24,79 say spac(0)
           next
        endif
    next
    ++LIN
next
IF( TPDir, DispEnd(), NIL )
setcolor(cCor)
return(WTELA)

/*
* Funcao      - CGCMF
* Finalidade  - Verificar a validade do CGC digitado.
* Programador - Valmor Pereira Flores
* Data        - 20/Setembro/1993
* Atualizacao -
*/
func cgcmf(CGC)
loca D[12],WCT,DF[2],RES[2],DIG[2],XTELA:=savescreen(00,00,24,79),XCURSOR:=setcursor()
if lastkey()=K_UP
   return(.t.)
endif
setcursor(0)
for WCT=1 to 12
  D[WCT]=val(subs(CGC,WCT,1))
next
for WCT=1 to 2
    DF[1]:=if( WCT=1, 5*D[1]+4*D[2]+3*D[3]+2*D[4]+9*D[5]+8*D[6]+7*D[7]+6*D[8]+5*D[9]+4*D[10]+3*D[11]+2*D[12],;
                      6*D[1]+5*D[2]+4*D[3]+3*D[4]+2*D[5]+9*D[6]+8*D[7]+7*D[8]+6*D[9]+5*D[10]+4*D[11]+3*D[12]+2*DIG[1] )
    DF[2]:=int(DF[1]/11)*11
    RES[WCT]:=DF[1]-DF[2]
    DIG[WCT]:=if(RES[WCT]=0 .or. RES[WCT]=1,0,11-RES[WCT])
next
if DIG[1]<>val(subs(CGC,13,1)) .or. DIG[2]<>val(subs(CGC,14,1))
   aviso("Digito CGCMF invalido.",5)     ;pausa()
   restscreen(00,00,24,79,XTELA)
endif
setcursor(XCURSOR)
return(.T.)

/*
* Funcao
* Finalidade  - Verificar a integridade do CPF
* Programador - Valmor Pereira Flores
* Data        -
* Atualizacao -
*/
Function CPF( cCpf )
Local cTela
Local nDigito1 := nDigito2 := 0
Local nCt := 1, nResto, nDigito

    If cCpf = "00000000000" .OR. cCpf = "11111111111" .OR.;
       cCpf = "22222222222" .OR. cCpf = "33333333333" .OR.;
       cCpf = "44444444444" .OR. cCpf = "55555555555" .OR.;
       cCpf = "66666666666" .OR. cCpf = "77777777777" .OR.;
       cCpf = "88888888888" .OR. cCpf = "99999999999" .OR.;
       cCpf = "12345678909"
       Return(.F.)
    EndIf
    FOR nCt:= 1 To Len( cCpf ) - 2
        nDigito1 := nDigito1+(11-nCt)*Val(Subs(cCpf,nCt,1))
        nDigito2 := nDigito2+(12-nCt)*Val(Subs(cCpf,nCt,1))
    NEXT
    nResto:=  nDigito1-(Int(nDigito1/11)*11)
    nDigito:= If( nResto < 2, 0, 11-nResto )
    nDigito2:= nDigito2 + 2 * nDigito
    nResto:= nDigito2 - (Int(nDigito2/11)*11)
    nDigito:= Val(Str(nDigito,1)+Str(If(nResto<2,0,11-nResto),1))
    If nDigito <> Val(Subs(cCpf,Len(cCpf)-1,2))
        cTela:= ScreenSave( 0, 0, 24, 79 )
        Aviso("Digito CPF invalido.",5)
        Pausa()
        ScreenRest( cTela )
    EndIf
    Return .T.

/*
* Funcao      - ZIPCHR
* Finalidade  - Transformar uma string alfabetica para codigo de maquina (ASC)
* Parametro   - STRING>dado a ser encriptado
* Retorno     - WSTR>String encriptada
* Programador - Valmor Pereira Flores
* Data        -
* Atualizacao -
*/
func zipchr(STRING)
loca WCT, WSTR:=""
for WCT:=1 to len(STRING)
    WSTR:= WSTR + chr( asc( substr( STRING, WCT, 1 ) ) + 50 + WCT )
next
return(WSTR)

/*
* Funcao      - UNZIPCHR
* Finalidade  - Fazer a operacao inversa a ZIPCHR
* Data        -
* Atualizacao -
*/
func unzipchr(STRING)
loca WCT, WSTR:=""
for WCT:=1 to len(STRING)
    WSTR=WSTR+chr(asc(substr(STRING,WCT,1))-50-WCT)
next
return(WSTR)

/*
* Funcao      - UNZOOM
* Finalidade  - Criacao de um unzoom.
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func unzoom(TELA)
loca CONT, XCURSOR:=setcursor()
if SWSet( _SYS_TEMPOZOOM ) < 0
   screenrest(TELA[1])
   return nil
endif
CONT:=len(TELA)+1
setcursor(0)
whil CONT>1
   screenrest(TELA[--CONT])
   for nCt:=1 to SWSet( _SYS_TEMPOZOOM )
   next
enddo
setcursor(XCURSOR)
return nil

/*
* Funcao      - ZOOM
* Finalidade  - Criacao de um zoom do centro para as coordenadas.
* Programador - Valmor Pereira Flores
* Data        - 01/Janeiro/1993
* Atualizacao - 11/Agosto/1993
*/
func zoom(LIN1,COL1,LIN2,COL2)
loca CONT:=0,;
     VLIN1:=VLIN2:=int(LIN1+((LIN2-LIN1)/2)), VCOL1:=VCOL2:=COL1+int(((COL2-COL1)/2)),;
     XCURSOR:=setcursor(), cCor:=setcolor(), TELA:={}
IF SWSet( _SYS_TEMPOZOOM ) < 0
   aadd(TELA,screensave(03,00,22,79))
   return(TELA)
ENDIF
aadd(TELA,screensave(0,0,24,79))
setcursor(0)
setcolor( "00/07")
whil VLIN2<LIN2 .or. VCOL2<COL2 .or. VLIN1>LIN1 .or. VCOL1>COL1
   VLIN2=if(VLIN2>=LIN2,LIN2,VLIN2)
   VCOL2=if(VCOL2>=COL2,COL2,VCOL2)
   VLIN1=if(VLIN1<=LIN1,LIN1,VLIN1)
   VCOL1=if(VCOL1<=COL1,COL1,VCOL1)
   /* Temporizador */
   for nCt:=1 to SWSet( _SYS_TEMPOZOOM )
   next
   aadd(TELA,screensave(VLIN1,VCOL1,VLIN2,VCOL2))
   dispbox(VLIN1,VCOL1,VLIN2,VCOL2, _BOX_UM + " " )
   --VLIN1
   ++VLIN2
   VCOL2=VCOL2+2
   VCOL1=VCOL1-2
   ++CONT
enddo
aadd(TELA,screensave(LIN1,COL1,LIN2+2,COL2+4))
dispbox(LIN1,COL1,LIN2,COL2, _BOX_UM + " " )
setcursor(XCURSOR)
setcolor(cCor)
return(TELA)

/*
* Modulo      - SCREENSAVE
* Finalidade  - Gravar parte da tela e suas coordenadas na variavel caracter.
* Parametros  - LIN1,COL1,LIN2,COL2=>Coordenadas.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screensave(LIN1,COL1,LIN2,COL2)
Local cTela, lMouseStatus:= MouseStatus()
DesligaMouse()
cTela:=chr(LIN1)+CHR(COL1)+CHR(LIN2)+CHR(COL2)+savescreen(LIN1,COL1,LIN2,COL2)
LigaMouse( lMouseStatus )
return(cTela)

/*
* Modulo      - SCREENREST
* Finalidade  - Carregar a tela a partir da variavel criada por SCREENSAVE()
*               Recupera as coordenadas originais da tela
* Parametros  - TELA=>Variavel que contem a tela.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screenrest(TELA)
Local lMouseStatus:= MouseStatus()
DesligaMouse()
restscreen( asc(substr(TELA,1,1)),asc(substr(TELA,2,1) ),;
            asc(substr(TELA,3,1)),asc(substr(TELA,4,1)),substr(TELA,5) )
LigaMouse( lMouseStatus )
return nil

/*
Modulo      - VPMODULO
Finalidade  - Pesquisar os modulos que a senha tem direito ao uso
Parametros  - ACESSO>Numero da posicao do modulo na variavel de autorizacao
Programador - Valmor Pereira Flores
Data        - 03/Agosto/1993
Atualizacao -
*/
func vpmodulo(ACESSO)
if substr(cPODER,ACESSO,1)=substr(WSIMNAO,ACESSO,1)
   return .t.
else
//   mensagem("Acesso n†o permitido, pressione [ENTER] para continuar.",1)
//   pausa()
   return .T.
endif

/*
*
*      Funcao - USERSCREEN
*  Finalidade - Exibir uma tela para edicao de dados, diferente da padrao.
* Programador - VALMOR
*        Data -
* Atualizacao -
*
*/
func userscreen
loca cCOR:=setcolor()
setcolor( COR[4] )
VPFundoFraze( 0, 0, 3, 79, ScreenBack )
SetColor( cCor )
return nil

/*
*
*      Funcao - USERMODULO()
*  Finalidade - Escrever no topo da tela gerada por userscreen() o nome do modulo.
* Programador - VALMOR
*        Data -
* Atualizacao -
*
*/
func usermodulo( Txt )
loca cCOR:=setcolor(), nCentral:= ( ( 80 ) - LEN( Txt ) ) / 2
SetColor( Cor[9] )
@ 0,0 Say Space(80)
@ 0,nCentral Say Txt
@ 0,0 Say _SIMB_CLOSE
SetColor(cCOR)
Return Nil

/*
*
*      Funcao - BOXSAVE
*  Finalidade - Salvar um box cfe. parametros.
* Programador - VALMOR
*        Data -
* Atualizacao -
*
*/
func boxsave(nPLIN1,nPCOL1,nPLIN2,nPCOL2)
/*
loca aTELA:={}
   aadd(aTELA,screensave(nPLIN1,nPCOL1,nPLIN1,nPCOL2))
   aadd(aTELA,screensave(nPLIN1,nPCOL2,nPLIN2,nPCOL2))
   aadd(aTELA,screensave(nPLIN2,nPCOL1,nPLIN2,nPCOL2))
   aadd(aTELA,screensave(nPLIN1,nPCOL1,nPLIN2,nPCOL1))
return(aTELA)
*/

/*
*
*      Funcao - BOXREST
*  Finalidade - Restaurar um box salvo por boxsave
* Programador - VALMOR
*        Data -
* Atualizacao -
*
*/
Function BoxRest( aTela )
/*
If !Empty( aTela )
   If aTela[1]<>Nil
      ScreenRest( aTela[1] )
      If aTela[2]<>Nil
         ScreenRest( aTela[2] )
         If aTela[3]<>Nil
            ScreenRest( aTela[3] )
            If aTela[4]<>Nil
               ScreenRest( aTela[4] )
            EndIf
         EndIf
      EndIf
   EndIf
EndIf
*/
Return Nil

/*
*
*     Funcao - ADMINISTRA
* Finalidade - Verificar se e' o administrador que esta tentando acesso
*              a algum modulo.
* Programador - VALMOR
*        Data -
* Atualizacao -
*
*/
func administra()
loca cTELA:=screensave(23,00,24,79)
if nGCODUSER<>0  // Codigo do presente usuario
   ajuda("[ENTER]Retorna")
   mensagem("ATENCAO! Somente o ADMINISTRADOR DO SISTEMA tem acesso a este modulo...",1)
   pausa()
   screenrest(cTELA)
   return(.F.)
endif
return(.T.)

/*
*
* Funcao      - VPMENU() - nOpcao
* Finalidade  - Criar um menu de opcoes a partir de uma matriz.
* Parametro   - nLIN1,nCOL1,nLIN2,nCOL2 => Coordenadas.
*               aPOPCOES => Matriz contendo as opcoes.
*               nPPOSICAO => Posicao inicial do cursor na matriz.
*               aPCOROPCOES => Matriz paralela a aPOPCOES, com cores p/ opcoes.
*               cAPONTA1 => Chr do apontador da esquerda.
*               cAPONTA2 => Chr do apontador da direita.
*               cCORAPONTADOR => Cor para apontadores.
* Retorno     - Numero da opcao selecionada (0-Nenhuma)
* Programador - VPFlores
* Data        - 31/Agosto/1994
* Atualizacao - 18/Novembro/1994
*
*/
func vpmenu(nLIN1,nCOL1,nLIN2,nCOL2,;
          aPOPCOES,nPPOSICAO,aPCOROPCOES,cAPONTA1,cAPONTA2,cCORAPONTADOR)
loca cCOR:=setcolor()
loca nCT, nTLIN, nTECLA, nPOSICAO:=0, nCURSOR:=0

nTLIN:=nLIN2-nLIN1                        && Numero total de linhas.
nTCOL:=nCOL2-nCOL1                        && Numero total de colunas.
nTSTR:=len(aPOPCOES[1])                   && Tamanho da String de opcao.
nTAM_:=len(aPOPCOES)                      && Quantidade de opcoes.


nPOSICAO:=nPPOSICAO
nCURSOR:=0                                && Posicao inicial do cursor na tela.


if nTLIN>nTAM_
   nTLIN:=nTAM_-1
endif

//* VERIFICA SE NAO ESTA NO FIM DA TELA *//
nPOSTELA:=nTAM_-nPPOSICAO
if nTLIN>nPOSTELA                         && Se Sobra espaco na tela?
   nQUANT:=nTLIN-nPOSTELA                 && Calcula quantas linhas sobram.
   nPOSICAO:=nPPOSICAO-nQUANT             && Ajusta a posicao inicial
   nCURSOR:=nCURSOR+nQUANT                && Ajusta o cursor
endif


if nPOSICAO<=0
   nPOSICAO:=1
endif

nCTLIN:=-1
//* APRESENTA AS PRIMEIRAS OPCOES DA LISTA NA TELA *//
for nCT:=nPOSICAO to nTAM_
    if aPCOROPCOES<>NIL
       setcolor(aPCOROPCOES[nCT])
    endif
    @ nLIN1+(++nCTLIN),nCOL1+1 say substr(aPOPCOES[nCT],1,nTCOL-1)
    if nCTLIN>=nTLIN
       exit
    endif
next

nPOSICAO:=nPPOSICAO

//* APONTADOR DA OPCAO *//
setcolor(cCORAPONTADOR)
@ nLIN1+nCURSOR,nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"")
@ nLIN1+nCURSOR,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"")

whil nTECLA<>K_ESC

   //* ESPERA PELA TECLA *//
   nTECLA:=inkey(0)

   //* COVERTER AS TECLAS (LEFTxRIGHT) POR (UPxDOWN) *//
   nTECLA=if(nTECLA=K_LEFT,K_UP,nTECLA)
   nTECLA=if(nTECLA=K_RIGHT,K_DOWN,nTECLA)

   //* TESTAR A TECLA *//
   do case
      case nTECLA=K_DOWN .AND. nPOSICAO<nTAM_  //* SETA PARA BAIXO *//
           ++nPOSICAO
           if nCURSOR>=nTLIN        //-1
              scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,1)
              //* COR DE OPCOES *//
              if aPCOROPCOES<>NIL
                 setcolor(aPCOROPCOES[nPOSICAO])
              else
                 setcolor(cCOR)
              endif
              @ nLIN2,nCOL1+1 say substr(aPOPCOES[nPOSICAO],1,nTCOL-1)
           elseif nCURSOR<nTLIN
              //* MUDAR PARA COR DO APONTADOR *//
              if cCORAPONTADOR<>NIL
                 setcolor(cCORAPONTADOR)
              endif
              @ nLIN1+nCURSOR,nCOL1 say " "
              @ nLIN1+nCURSOR,nCOL2 say " "
              @ nLIN1+(++nCURSOR),nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"")
              @ nLIN1+nCURSOR,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"")
           endif
      case nTECLA=K_UP .AND. nPOSICAO>1        //* SETA PARA CIMA *//
           --nPOSICAO
           if nCURSOR=0    // <=1
              //* COR DE OPCOES *//
              if aPCOROPCOES<>NIL
                 setcolor(aPCOROPCOES[nPOSICAO])
              else
                 setcolor(cCOR)
              endif
              scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,-1)
              @ nLIN1,nCOL1+1 say substr(aPOPCOES[nPOSICAO],1,nTCOL-1)
           elseif nCURSOR>0  // >1
              //* MUDAR PARA COR DO APONTADOR *//
              if cCORAPONTADOR<>NIL
                 setcolor(cCORAPONTADOR)
              endif
              @ nLIN1+nCURSOR,nCOL1 say " "
              @ nLIN1+nCURSOR,nCOL2 say " "
              @ nLIN1+(--nCURSOR),nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"")
              @ nLIN1+nCURSOR,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"")
           endif
      case nTECLA==K_PGDN                      //* PAGE DOWN *//
           if nPOSICAO+nTLIN<=nTAM_
              nPOSICAO=nPOSICAO+nTLIN
           else
              //* MUDAR PARA COR DO APONTADOR *//
              if cCORAPONTADOR<>NIL
                 setcolor(cCORAPONTADOR)
              endif
              @ nLIN1+nCURSOR,nCOL1 say " "
              @ nLIN1+nCURSOR,nCOL2 say " "
              @ nLIN1,nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"")
              @ nLIN1,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"")
              nPOSICAO:=nTAM_
              nCURSOR:=0
           endif
           setcolor(cCOR)
           scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,0)
           nCTLIN:=-1
           for nCT:=nPOSICAO to nTAM_
               if aPCOROPCOES<>NIL
                  setcolor(aPCOROPCOES[nCT])
               endif
               @ nLIN1+(++nCTLIN),nCOL1+1 say substr(aPOPCOES[nCT],1,nTCOL-1)
               if nCTLIN>=nTLIN
                   exit
               endif
           next
      case nTECLA==K_PGUP                      //* PAGE UP *//
           if nPOSICAO-nTLIN>=nLIN1
              nPOSICAO=nPOSICAO-nTLIN
           else
              //* MUDAR PARA COR DO APONTADOR *//
              if cCORAPONTADOR<>NIL
                 setcolor(cCORAPONTADOR)
              endif
              @ nLIN1+nCURSOR,nCOL1 say " "
              @ nLIN1+nCURSOR,nCOL2 say " "
              @ nLIN1,nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"")
              @ nLIN1,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"")
              nPOSICAO:=1
              nCURSOR:=0
           endif
           setcolor(cCOR)
           scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,0)
           nCTLIN:=-1
           for nCT:=nPOSICAO to nTAM_
               if aPCOROPCOES<>NIL
                  setcolor(aPCOROPCOES[nCT])
               endif
               @ nLIN1+(++nCTLIN),nCOL1+1 say substr(aPOPCOES[nCT],1,nTCOL-1)
               if nCTLIN>=nTLIN
                   exit
               endif
           next
      case nTECLA=K_ENTER .OR. nTECLA=K_TAB    //* TAB ou ENTER *//
           setcolor(cCOR)
           return(nPOSICAO)
      endcase
enddo
setcolor(cCOR)
return(0)

/*
*      Funcao - STRVERQUANT
*  Finalidade - Verificar quantas vezes aparece uma substring em outra.
*  Parametros - <SUBSTRING>,<STRING>
*     Retorno - Numero de vezes
*        Data - 25/Novembro/1994.
* Atualizacao -
* Programador - Valmor Pereira Flores
*/
func strvezes(SUBSTRING,STRING)
loca nCT, nQUANT:=0
for nCT:=1 to len(STRING)
    if SUBSTRING=substr(STRING,nCT,len(SUBSTRING))
       ++nQUANT
    endif
next
return(nQUANT)

/*
** Funcao      - ESCREVER
** Finalidade  - Escrever mensagem c/ os caracteres que estiveren c/ (~),
**               em destaque conforme cor determinada.
** Programador - Valmor Pereira Flores.
** Data        - 01/Dezembro/1994.
** Atualizacao - 11/Janeiro/1995.
*/
func escrever(pnLIN1,pnCOL1,pcMENS,pcCOR)
loca nCT, cCORR:=setcolor(), nPOS:=0
@ pnLIN1,pnCOL1 say strtran(pcMENS,"~","")
for nCT:=1 to len(pcMENS)
    ++nPOS
    if substr(pcMENS,nCT,1)="~"
       --nPOS
       setcolor(COR[10])
       @ pnLIN1,pnCOL1+nPOS say substr(pcMENS,nCT+1,1)
       setcolor(cCORR)
    endif
next
return(.T.)

func vperro(lERR)
lERRO:=lERR
return(.T.)

/*
**
**
**
**
**
**
*/
Func EspacoEmDisco(DRIVE,ESPACOMINIMO)
  Loca nESPACO:=0, nOPCAO:=0, cCOR:=setcolor(),;
       cTELA:=ScreenSave(00,00,24,MaxCol()),;
       nCURSOR:=SetCursor()
  If (nESPACO:=DiskSpace(DRIVE))<ESPACOMINIMO
     SetCursor(0)
     Tone(100);Tone(640,2);Tone(320,3)
     VpBox(10,19,21,62," ATENCAO ","GR+/R",.T.,.T.)
     SetColor("W+/R")
     @ 12,20 Say "    Espaco em disco nao e' suficiente     "
     @ 13,20 Say " p/ garantir uma perfeita execucao, sera  "
     @ 14,20 Say " necessario que o usuario livre no minimo "
     @ 16,20 Say "      "+tran(ESPACOMINIMO-nESPACO,"@E 999,999,999,999")+" Bytes"
     @ 17,20 Say "    excluindo arquivos desnecessarios.    "
     SetColor("W+/R,R+/GR+")
     Mensagem("Selecione [S]air do sistema ou [C]ontinuar...",1)
     Whil nOPCAO=0
        @ 19,30 prompt "    Sair     "
        @ 19,45 prompt "  Continuar  "
        Menu To nOPCAO
     EndDo
     ScreenRest(cTELA)
     SetCursor(nCURSOR)
  EndIf
  Return(If(nOPCAO=1,.F.,.T.))


** Funcao      - System()
** 20/04/1995  - 19:57hs.
func System
loca nBOTOES, aMOUSE:={}, nKEY, nCT:=0
For nCT:=1 to MOUSE_NUM_
    aadd(aMOUSE,NIL)
Next
If !IniMouse(@nBOTOES)
   //   Mensagem("Aguarde, iniciando modulos do sistema . . .",1)
   Return(.F.)
Endif
LigaMouse()

** Funcao      - LimpaVar
** Finalidade  -
func LimpaVar
release all like c* //*Caracter*//
release all like n* //*Numerica*//
release all like l* //*Logica*//
release all like d* //*Data*//

/*
** Funcao      - NtoC
** Finalidade  - Converter qualquer tipo de variavel em uma string
** Parametros  - cString=> String a ser convertida.
** Retorno     - cString=> String apos conversao
** Data        - 16/Agosto/1995
** Programador - Valmor Pereira Flores
*/
FUNCTION NtoC( cString )
IF VALTYPE( cString )=="D";      cString:= DTOC( cString )
ELSEIF VALTYPE( cString )=="N";  cString:= STR( cString )
ELSEIF VALTYPE( cString )=="L";  cString:= "Logico"
ELSEIF VALTYPE( cString )=="M";  cString:= " * Memo * "
ENDIF
RETURN( cString )

func usuario(Txt)
loca cCor:= SetColor()
setcolor(COR[5])
@ 01,78 - len( alltrim( Txt ) ) Say AllTrim( Txt ) + IF( ExisteMensagem(), "*", " " )
setcolor(cCor)
return nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ ALERTA
³ Finalidade  ³ Exibir um box de alerta.
³ Parametros  ³ aMensagem => Array com mensagens.
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 5/Outubro/1995
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Alerta( aMensagem )
   Static cScreen
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt:= 0,;
         nColSpace:= 0, nLinSpace:= 0
   cScreen:= If( Empty( cScreen ), ScreenSave( 0, 0, 24, MaxCol() ), cScreen )
   SetColor( _COR_ALERTA_LETRA )
   If !Empty( aMensagem )
      For nCt:= 1 To Len( aMensagem )
          nColSpace:= If( Len( aMensagem[nCt] ) >= nColSpace, Len( aMensagem[nCt] ), nColSpace )
      Next
      nLinSpace:= Len( aMensagem )
      nLin1:= Int( 25 - nLinSpace ) / 2
      nCol1:= ( Int( 80 - nColSpace ) / 2 ) - 4
      nLin2:= nLin1 + nLinSpace
      nCol2:= nCol1 + nColSpace
      VPBox( nLin1, nCol1, nLin2, nCol2, "Atencao", _COR_ALERTA_BOX, .F., .F., _COR_ALERTA_TITULO )
      For nCt:=1 to Len( aMensagem )
          @ nLin1 + nCt, ( 80 - Len( aMensagem[nCt] ) ) /2 Say aMensagem[nCt]
      Next
   Else
      ScreenRest( cScreen )
   EndIf
   SetCursor( nCursor )
   SetColor( cCor )
   Return Nil


Function ModoVGA( lModo )
Static lModoInt
lModoInt:= IIF( lModo <> Nil, lModo, lModoInt )
Return lModoInt


#Define DESIGN_ROLLER "|/-\"

Function Roller( nLin, nCol )
Static cDesign
IF cDesign==NIL
   cDesign:= Left( DESIGN_ROLLER, 1 )
ENDIF
DO CASE
   CASE cDesign==SubStr( DESIGN_ROLLER, 1, 1 ); cDesign:= SubStr( DESIGN_ROLLER, 2, 1 )
   CASE cDesign==SubStr( DESIGN_ROLLER, 2, 1 ); cDesign:= SubStr( DESIGN_ROLLER, 3, 1 )
   CASE cDesign==SubStr( DESIGN_ROLLER, 3, 1 ); cDesign:= SubStr( DESIGN_ROLLER, 4, 1 )
   CASE cDesign==SubStr( DESIGN_ROLLER, 4, 1 ); cDesign:= SubStr( DESIGN_ROLLER, 1, 1 )
ENDCASE
@ nLin, nCol Say cDesign
Return Nil

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
Function VPFundoFraze( nLin1, nCol1, nLin2, nCol2, cTexto )
LOCAL nStr:= 1, nTamanho:= 4, nCt
FOR nCt:= 1 To 5
    cTexto:= cTexto + "  " + cTexto
    IF Len( cTexto ) >= 180
       EXIT
    ENDIF
NEXT
WHILE .T.
  @ nLin1++, nCol1 Say SUBSTR( cTexto, nStr, ( nCol2 - nCol1 ) + 1 )
  nStr+= nTamanho
  IF nLin1 > nLin2
     EXIT
  ENDIF
ENDDO
Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ VPMENS
³ Finalidade  ³
³ Parametros  ³
³ Retorno     ³
³ Programador ³
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function VPMens( nLin, nCol, cMensagem, cCorMens )
Local cCor:= SetColor()
Local cPedaco, cStringCompleta

Static cTime, nCont1, nQuant
Static cTela
Static cTimeProtT

IF !SWSet( _GER_BARRAROLAGEM )
   Return Nil
ENDIF

IF nLin==NIL
   ScreenRest( cTela )
ENDIF

IF cTela== NIL
   cTela:= ScreenSave( nLin, nCol, nLin, nCol + Len( cCorMens ) )
ENDIF


SetColor( cCorMens )
IF cTime==Nil
   cTime:= "0"
   cTimeProtT:= Right( Time(), 2 )
   @ nLin, nCol Say cMensagem
ENDIF

//IF ABS( VAL( Right( Time(), 2 ) ) - VAL( cTimeProtT ) ) = 20 .AND. Inkey() == 0
 //  ProtecaoTela()
 //  cTineProtT:= Right( Time(), 2 )
//ENDIF

IF VAL( Right( Time(), 1 ) ) <> VAL( cTime )

   cTime:= Right( Time(), 1 )

   IF nQuant == NIL .AND. nCont1 == NIL
      nCont1:= 0
      nQuant:= Len( cMensagem )
   ENDIF
   SetCursor( 0 )
   ++nCont1
   nQuant:= Len( cMensagem ) - nCont1
   cPedaco:= SubStr( cMensagem, nCont1, nQuant )
   cStringCompleta:= cPedaco + ;
         SubStr( cMensagem, 1, Len( cMensagem ) - Len( cPedaco ) )

   @ nLin, nCol Say cStringCompleta

   IF nCont1 = Len ( cMensagem )
      nCont1:= 0
      nQuant:= Len ( cMensagem )
   ENDIF

ENDIF
SetColor( cCor )
Return Nil



#Define LIMITE_LINHA1       SWSet( _SYS_PROTELA )[1]
#Define LIMITE_LINHA2       SWSet( _SYS_PROTELA )[3]
#Define LIMITE_COLUNA1      SWSet( _SYS_PROTELA )[2]
#Define LIMITE_COLUNA2      SWSet( _SYS_PROTELA )[4]

#Define ATRAS_CIMA          1
#Define ATRAS_BAIXO         2
#Define FRENTE_CIMA         3
#Define FRENTE_BAIXO        4
#Define ACIMA               1
#Define BAIXO               2

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ PROTECAOTELA
³ Finalidade  ³ Ativar-se quando nao esta sendo digitado absolutamente nada
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 07/11/96 - 21:40hs.
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ProtecaoTela()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() ),;
      nCursorRow:= Row(), nCursorCol:= Col(),;
      nQuantidade:= 2, nMovimento:= 0

      //nMouseCol:= m_col(), nMouseRow:= m_row(),

SetCursor(0)
nB1Lin1:= Row()
nB1Col1:= Col()
nB1OldLin1:= nB1Lin1
nB1OldCol1:= nB1Col1

cTexto1:= SWSet( _SYS_PROT1 )[1]
cTexto2:= SWSet( _SYS_PROT2 )[1]
cTexto:= cTexto2
nTexto:= 2
nCt:= 0

nB1Direcao:= ATRAS_CIMA
WHILE .T.

     IF ++nCt > 20
        IF nTexto == 1
           cTexto:= cTexto2
           nTexto:= 2
        ELSE
           cTexto:= cTexto1
           nTexto:= 1
        ENDIF
        nCt:= 0
     ENDIF
     @ nB1OldLin1, nB1OldCol1 Say Space( Len( cTexto ) )
     IF nTexto == 1
        SetColor( SWSet( _SYS_PROT1 )[2] )
     ELSE
        SetColor( SWSet( _SYS_PROT2 )[2] )
     ENDIF
     @ nB1Lin1, nB1Col1 Say cTexto
     SetColor( "W/N" )
     nB1OldLin1:= nB1Lin1
     nB1OldCol1:= nB1Col1
     IF ++nMovimento > 150
        ScreenRest( cTela )
        nMovimento:= 0
     ENDIF

     DO CASE
        CASE nB1Direcao == FRENTE_BAIXO
             nB1Lin1+= nQuantidade
             nB1Col1+= nQuantidade
        CASE nB1Direcao == FRENTE_CIMA
             nB1Lin1-= nQuantidade
             nB1Col1+= nQuantidade
        CASE nB1Direcao == ATRAS_BAIXO
             nB1Col1-= nQuantidade
             nB1Lin1+= nQuantidade
        CASE nB1Direcao == ATRAS_CIMA
             nB1Col1-= nQuantidade
             nB1Lin1-= nQuantidade
     ENDCASE
     IF nB1Lin1 < LIMITE_LINHA1
        ++nB1Lin1
        IF nB1Col1 < LIMITE_COLUNA1
           nB1Col1+= 2
           nB1Direcao:= FRENTE_BAIXO
        ELSE
           IF nB1Direcao == FRENTE_CIMA
              nB1Direcao:= FRENTE_BAIXO
           ELSE
              nB1Direcao:= ATRAS_BAIXO
           ENDIF
        ENDIF
     ENDIF

     IF nB1Col1 < LIMITE_COLUNA1
        ++nB1Col1
        IF nB1Direcao == ATRAS_CIMA
           nB1Direcao := FRENTE_CIMA
        ELSE
           nB1Direcao := FRENTE_BAIXO
        ENDIF
     ENDIF

     IF nB1Lin1 > LIMITE_LINHA2
        --nB1Lin1
        IF nB1Direcao == FRENTE_BAIXO
           nB1Direcao:= FRENTE_CIMA
        ELSE
           nB1Direcao:= ATRAS_CIMA
        ENDIF
     ENDIF
     nB1Col2:= nB1Col1 + Len( cTexto )
     IF nB1Col2 > LIMITE_COLUNA2
        IF nB1Direcao == FRENTE_BAIXO
           nB1Direcao:= ATRAS_BAIXO
        ELSE
           nB1Direcao:= ATRAS_CIMA
        ENDIF
     ENDIF
     IF ! INKEY(.10) == 0
        //.OR. ;
        //! ( m_row() == nMouseRow ) .OR. ! ( m_col() == nMouseCol )
        EXIT
     ENDIF
ENDDO
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
@ nCursorRow, nCursorCol Say Space(0)
Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ EXECUTEEXTERNAL
³ Finalidade  ³ Execucao external
³ Parametros  ³
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function ExecuteExternal()
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor()
Local GetList:= {}, nCursor:= SetCursor()
Private cComando:= Space( 80 )
lDelimiters:= Set( _SET_DELIMITERS, .F. )
Mensagem(" ")
SetColor( "15/00,14/00" )
Ajuda( " " )
Mensagem( " " )
cComRes:= PAD( "EDIT TELA0000.TMP", 80 )
WHILE .T.
   SetCursor( 2 )
   IF LASTKEY() == K_PGUP
      cComando:= cComRes
   ELSE
      cComRes:= cComando
      cComando:= Space( 80 )
      Scroll( 00, 00, 24, 79, 3 )
   ENDIF
   cComando:= PAD( cComando, 120 )
   @ 23,00 Say "Comando: "
   @ 24,00 Get cComando Pict "@S80"
   READ
   IF !LASTKEY() == K_PGUP .AND. EMPTY( cComando )
      EXIT
   ENDIF
   cComando:= Alltrim( cComando )
   RUN &cComando
   SetBlink( .F. )
ENDDO
!MVIDEO.EXE
Set( _SET_DELIMITERS, lDelimiters )
ScreenRest( cTela )
SetColor( cCor )
SetCursor( nCursor )
Return .T.


/*
Function _ProtecaoTela()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() )
#DEFINE _IMAGEM           "IO.PCX"
#DEFINE _IMAGEM_FUNDO     "FUNDO.PCX"
#DEFINE _MODO
LOCAL nCt:= 0, nArquivo
BC_INIC( _MODO )
IF BC_CNCOR() != 256
   BC_FIM()
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Return Nil
ENDIF
nArquivo:= BC_ARQME( _IMAGEM )
BC_DESCALA( 3, 3 )
BC_ARQVD( 0, 0, _IMAGEM_FUNDO, 1 )
INKEY(0.5)
BC_DESCALA( 1, 1 )
SRand(100000)
WHILE NEXTKEY()==0
   FOR nCt:=0.01 TO 1 Step 0.01
       nTempo:= VAL( RIGHT( TIME(), 1 ) )
       nCt1:= ( Rand()/100000 ) * 2
       nCt2:= ( Rand()/100000 ) * 2
       BC_MEMVD( nCt1, nCt2, nArquivo, 1 )
       IF INKEY(.10)<>0
          EXIT
       ENDIF
   NEXT
ENDDO
BC_FIM()
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil
*/


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ IOFillText()
³ Finalidade  ³ Preencher um array com informacoes de um arquivo texto
³ Parametros  ³ cCampo - Variavel c/ o campo: Ex. IOFilltext( MEMOREAD( "COPIA.REP" ) )
³ Retorno     ³ aArray
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function IOFillText( cCampoMemo )
LOCAL aTexto:= {}, nFinalLinha
WHILE .T.
    nFinalLinha:= AT( CHR( 13 ) + CHR( 10 ), cCampoMemo )
    AADD( aTexto,  SubStr( cCampoMemo, 1 , nFinalLinha - 1 ) )
    cCampoMemo:= SubStr( cCampoMemo, nFinalLinha + 2 )
    IF Empty( cCampoMemo )
       Exit
    ENDIF
ENDDO
RETURN aTexto

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ SETMouseSeta
³ Finalidade  ³ Coloca o mouse no formato de seta
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function SetMouseSeta
Local cOldChars, aMouseCursor

   /* Reseta o mouse (FUNCkyII) */
   m_reset()

   /* Guarda os caractesres originais usados pelo mouse (FUNCkyII) */
   cOldChars := m_getchars()

   /* Seta novos caracteres para uso do mouse gr fico (FUNCkyII) */
   m_SetChars( Chr( 200 ) + Chr( 201 ) + Chr( 202 )+ Chr( 203 ) + ;
               Chr( 204 ) + Chr( 206 ) + Chr( 207 )+ Chr( 208 ) + Chr( 209 ) )

   /* instala fonte para mouse grafico (FUNCkyII) */
   m_install(1)

   /***
   * Coloca em (aMouseCursor) os valores decimais corespondentes ao cursor tipo
   * Seta
   ***/
   aMouseCursor:= { 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 511, 511, 4351, 28927,;
                 63615, 63615, 63615, 0, 16384, 24576, 28672, 30720, 31744, 32256, 32512,;
                 32640, 31744, 27648, 17920, 1536, 768, 768, 0 }


   /* Instala o Cursor do mouse (Tipo seta) - (FUNCkyII) */
   m_SetCursor( 1, 1, aMouseCursor )
   LigaMouse()

Return( cOldChars )


Function SWRola()
Local nCol:= 0, cTela
   nCol:= 0
   FOR nCt=1 TO 8
       cTela:=savescreen(00,nCol,24,69)
       Inkey(.1)
       nCol+=10
       Scroll(00,00,24,79)
       RestScreen(00,nCol,24,79,cTela)
   NEXT

Function FechaArea()
DBCloseArea()
RETURN Nil

Function FechaArquivos()
IF !AbreArquivosInicio
   DBCloseAll()
ENDIF
RETURN Nil


Function Efeito( cFile )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() )
Local aScreen, nCt
aScreen:= IOFillText( MemoRead( cFile ) )
FOR nCt:= 1 To Len( aScreen )
    @ nCt,00 Say aScreen[ nCt ]
NEXT
Ajuda( "Pressione [ENTER] para continuar..." )
Pausa()
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ VIEWFILE
³ Finalidade  ³ Visualizador de arquivos no formato .TXT .PRN .LST
³ Parametros  ³ Nome do Arquivo
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION ViewFile( cFile, nLin1, nCol1, nLin2, nCol2 )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() )
Local oTab, Tecla
Local nArea:= Select()
Local aStruct:= {}
Private cArquivo:= cFile
IF nLin1==Nil
   Mensagem( "Abrindo arquivo para visualizacao, aguarde..." )
ENDIF
IF FILE( "TEXT0000.TMP" )
   FErase( "TEXT0000.TMP" )
ENDIF
aStruct:= {{"ORIGE1","C",78,00},;
           {"ORIGE2","C",69,00},;
           {"ORIGEM","C",147,00},;
           {"LINHA_","C",08,00}}
DBCREATE("TEXT0000.TMP", aStruct)
DBSelectAr( 233 )
USE TEXT0000.TMP
APPEND FROM &cArquivo FIELDS Origem SDF
DBGotop()
WHILE !EOF()
   Mensagem( "Reg#" + StrZero( Recno(), 6, 0 ) + " - Montando arquivo p/ visualizacao, aguarde..." )
   Replace ORIGE1 With SubStr( ORIGEM, 1, 78 ),;
           ORIGE2 With SubStr( ORIGEM, 79 ),;
           LINHA_ With StrZero( Recno(), 8, 0 )
   DBSkip()
ENDDO
DBGoTop()
IF nLin1 == Nil
   VPBox( 00,00,23,79, "S&W Visualizador (" + cFile + ")", "15/01", .T., .T., "01/15" )
   Ajuda( "[PgUp][PgDn][TAB][" + _SETAS + "]Movimenta [ESC]Finaliza" )
   SetColor( "14/01" )
   oTAB:=TBROWSEDB( 01, 01, 22, 78 )
ELSE
   oTAB:=TBROWSEDB( nLin1, nCol1, nLin2, nCol2 )
ENDIF
oTAB:addcolumn(tbcolumnnew(,{|| ORIGE1 }))
oTAB:addcolumn(tbcolumnnew(,{|| ORIGE2 }))
oTAB:addcolumn(tbcolumnnew(,{|| LINHA_ }))
IF nLin1==Nil
   oTAB:ColorSpec:="14/01,15/00,03/15"
ENDIF
oTAB:AUTOLITE:=.f.
oTAB:dehilite()
whil .t.
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,2},{2,1})
   oTab:colorRect({0,3,24,3},{3,3})
   whil nextkey()==0 .and. ! oTAB:stabilize()
   end
   TECLA:=inkey(0)
   if TECLA==K_ESC   ;exit   ;endif
   do case
      case TECLA==K_UP         ;oTAB:up()
      case TECLA==K_DOWN       ;oTAB:down()
      case TECLA==K_LEFT       ;oTAB:left()
      case TECLA==K_RIGHT      ;oTAB:right()
      case TECLA==K_PGUP       ;oTAB:pageup()
      case TECLA==K_CTRL_PGUP  ;oTAB:gotop()
      case TECLA==K_PGDN       ;oTAB:pagedown()
      case TECLA==K_CTRL_PGDN  ;oTAB:gobottom()
      case TECLA==K_CTRL_ENTER ;ExecuteExternal()
      otherwise                ;tone(125); tone(300)
   endcase
   oTAB:refreshcurrent()
   oTAB:stabilize()
enddo
IF nLin1==Nil
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
ENDIF
DBCloseArea()
DBSelectAr( nArea )
Return Nil

FUNCTION Guardiao( cModulo )
  LOCAL nArea:= Select(), nOrdem:= IndexOrd()
  LOCAL cTela:= ScreenSave( 1, 0, 23, 79 ), cCor:= SetColor()

 /*
  IF cModulo <> NIL
     SWGravar( 10000 )
     IF !Empty( cModulo ) .OR. cModulo == " "
        cModulo:= Alltrim( cModulo )
        cModulo+= IF( Used(), " <" + StrZero( RECNO(), 8, 0 ) +;
                        " " + StrZero( nArea, 3, 0 ) +;
                        " " + StrZero( nOrdem, 3, 0 ) + ">", "<Normal>" )
        DBSelectAr( _COD_GUARDIAO )
        IF Used()
           DBAppend()
           IF !NetErr()
              Replace MODULO With ZipChr( cModulo ),;
                      DATA__ With Date(),;
                      TIME__ With ZipChr( Time() ),;
                      USERN_ With IF( nGCodUser <> NIL, nGCodUser, 0 )
           ENDIF
        ENDIF
     ENDIF
     SWGravar( 5 )
  ENDIF
 */
/*  DbSelectAr( _COD_TELA )
  IF Used()
     IF nGCodUser <> NIL
        IF USERN_ <> nGCodUser
           IF !DBSeek( nGCodUser )
              DBAppend()
           ENDIF
        ENDIF
        Rlock()
        IF !NetErr()
           Replace TELA__ With cTela,;
                   USERN_ With nGCodUser
           DBUnlock()
        ENDIF
        DBUnlockAll()
     ENDIF
  ENDIF
  */
  IF lGuardiao
     SET EXCLUSIVE OFF
     SELE 112
     xTela:= SaveScreen( 0, 0, 24, 79 )
     IF !USED()
        USE GERAL.DBF SHARED ALIAS GER
        DBAPPEND()
        RLOCK()
        REPLACE MEMORIA WITH xTela
        DBUNLOCK()
     ENDIF
     DBCLOSEAREA()
  ENDIF
  DBSelectAr( nArea )
  IF nOrdem <> 0
     DBSetOrder( nOrdem )
  ENDIF
  RETURN .T.

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ CorFundoAtual
³ Finalidade  ³ Retorna a cor utilizada
³ Parametros  ³ Nil
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION CorFundoAtual()
Local cCor:= SetColor(), cCorAtual
   cCorAtual:= SubStr( cCor, At( "/", cCor ) + 1 )
   cCorAtual:= SubStr( cCorAtual, 1, At( ",", cCorAtual ) - 1 )
   Return cCorAtual


FUNCTION ASMEXCLUSAO

FUNCTION BACKUP

FUNCTION BROWSEMAKE

FUNCTION OPENFILES

FUNCTION PESQUISAPR

FUNCTION RESPMONTAGEM

FUNCTION VERGRUPO

FUNCTION VERCODIGO

FUNCTION TempoMouse( nTempo )
Static nTempoMouse
IF nTempo == NIL
   Return nTempoMouse
ELSE
   nTempoMouse:= nTempo
ENDIF

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Retorna o tempo definido de protecao
³ Finalidade  ³
³ Parametros  ³
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION TempoProtecao()
Return SWSet( _SYS_TEMPOPROT )


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³
³ Finalidade  ³ Apresentar um termometro com o processamento
³ Parametros  ³ nPosicao = Posicao na base de dados
³ Retorno     ³
³ Programador ³ Valmor P. Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION Processo( nPosicao, nTotal, nRegistro )
  LOCAL cProcesso:= Str( ( Recno() / LastRec() ) * 100, 3, 0 ), cMensagem,;
        nBarra, cBarra
  STATIC cTelaAnterior, cCor, lMouse

  IF !nTotal == Nil
     cProcesso:= Str( ( nRegistro / nTotal ) * 100, 3, 0 )
  ENDIF

  IF cTelaAnterior == NIL .AND. VAL( cProcesso ) < 100
      cTelaAnterior:= ScreenSave( 10, 0, 24, 79 )
      cCor:= SetColor()
      lMouse:= MouseStatus()
      DesligaMouse()
      SetColor( COR[6] )
      @ 23, 00 Say Space( 80 )
      Aviso( "Buscando Informacoes, aguarde...", 12 )
   ENDIF
   nBarra:= INT( Val( cProcesso ) / 3 )
   cBarra:= Repl( "Û", nBarra ) + Repl( "°", 33 - nBarra )
   IF nPosicao == NIL
      cMensagem:= "Pesquisa " + cProcesso + "% completa...      " + cBarra
   ELSE
      cMensagem:= "Pesquisa (" + StrZero( nPosicao, 1, 0 ) + "), " + cProcesso + "% completa... " + cBarra
   ENDIF
   @ 23,INT( ( 80-Len( cMensagem ) ) / 2 ) Say cMensagem
   IF VAL( cProcesso ) > 99 .AND. !cTelaAnterior == NIL
      ScreenRest( cTelaAnterior )
      SetColor( cCor )
      LigaMouse( lMouse )
      cTelaAnterior:= Nil
   ENDIF
   Return .T.


FUNCTION DevicePadrao()
Set( 24, "LPT1" )
Return .T.


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³
³ Finalidade  ³ Desviar para um arquivo, retornando o nome a cada chamada
³             ³
³ Parametros  ³ DeviceFile( .T. ) -> Apaga o nome do arquivo que esta como
³             ³                      device no momento. (FIM do device)
³             ³
³ OBSERVACAO  ³ Isto devera ser inicado com DEVICEFILE() e finalizado com
³             ³ DEVICEFILE( [<.F./.T.>] )
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION DeviceFile( lArquivo )
Static cArquivoNome
IF lArquivo <> NIL
   IF lArquivo .AND. ! EMPTY( cArquivoNome )
      cDevice:= Set( 24, "SCREEN" )
      ViewFile( cArquivoNome )
      Set( 24, cDevice )
      cArquivoNome:= Nil
      DevicePadrao()
   ELSE
      cArquivoNome:= Nil
      DevicePadrao()
   ENDIF
   Return Nil
ENDIF
IF cArquivoNome == NIL
   FOR nCt:= 1 TO 99
       IF !File( "VISUAL" + StrZero( nCt, 2 ) + ".PRN" )
          EXIT
       ENDIF
   NEXT
   Mensagem( "Limpando arquivos temporarios, aguarde..." )
   IF nCt == 99
      FOR nCt:= 1 TO 99
          FErase( "VISUAL" + StrZero( nCt, 2 ) + ".PRN" )
      NEXT
      nCt:= 1
   ENDIF
   cArquivoNome:= "VISUAL" + StrZero( nCt, 2 ) + ".PRN"
   Set( 24, cArquivoNome )
ENDIF
Return cArquivoNome


FUNCTION SWSet( nCodigo, cConteudo )
LOCAL nPosicao
Static aSWSet
IF aSWSet == NIL
   IF cConteudo <> NIL
      aSWSet:= {}
      AAdd( aSWSet, { nCodigo, cConteudo } )
   ENDIF
ELSE
   nPosicao:= ASCAN( aSWSet, {|x| x[1] == nCodigo } )
   IF cConteudo == NIL
      IF ! nPosicao==0
         Return aSWSet[ nPosicao ][ 2 ]
      ELSE
         Return Nil
      ENDIF
   ELSE
      IF nPosicao == 0
         AAdd( aSWSet, { nCodigo, cConteudo } )
      ELSE
         aSWSet[ nPosicao ][ 2 ]:= cConteudo
      ENDIF
   ENDIF
ENDIF


FUNCTION DetectaFalha()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() )

IF File( GDIR - "\S&W.CTR" )
   VPObsBox( .T., 10, 10, " Atencao ", { "Voce devera aguardar at‚ que o",;
                                         "usu rio principal  complete  a",;
                                         "indexacao." } )
   WHILE LastKey() <> K_ESC
      IF !File( GDIR + "\S&W.CTR" )
         Exit
      ENDIF
   ENDDO
ELSE
   IF File( GDIR - "\INICIAR." + StrZero( SWSet( _SYS_COMPUTADOR ), 3, 0 ) )
      IF File( _FIL_ATIVADO )
         Aviso( "Sistema j  esta sendo executado ou houve queda de luz...", 12 )
         Aviso( "********** FACA URGENTEMENTE UMA REINDEXACAO ***********", 15 )
         Guardiao( " INFORMACAO DE ABORT SYSTEM " )
         PAUSA(0)
         IF LastKey() == K_ENTER
            FErase( _FIL_ATIVADO )
            FErase( GDIR - "\INICIAR." + StrZero( SWSet( _SYS_COMPUTADOR ), 3, 0 ) )
            FErase( GDIR - "\S&W.CTR" )
            Return Nil
         ENDIF
         SetColor( cCor )
         SetCursor( nCursor )
         ScreenRest( cTela )
         Cls
         Quit
      ELSE
         MontaArquivo( _FIL_ATIVADO )
      ENDIF
      MontaArquivo( GDIR - "\S&W.CTR" )
      VPObsBox( .T., 10, 10, " Atencao ", { "Houve  falha  na  ultima  finalizacao  e",;
                                         "por este motivo o sistema far  uma reor-",;
                                         "ganizacao geral nos seus arquivos, para ",;
                                         "que nÆo haja nenhum problema de perda de",;
                                         "informacoes em virtude deste problema.  ",;
                                         "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",;
                                         "solicite que todos os usuarios  saiam do",;
                                         "sistema                                 " } )
      Pausa()
      VPC15000()
      DBCloseAll()
      FErase( GDIR + "\S&W.CTR" )
   ELSE
      MontaArquivo( GDIR - "\INICIAR." + StrZero( SWSet( _SYS_COMPUTADOR ), 3, 0 ) )
   ENDIF
ENDIF
IF File( _FIL_ATIVADO ) .AND. File( GDIR + "\S&W.CTR" )
   Aviso( "Sistema j  esta sendo executado...", 12 )
   Inkey(0)
   IF LastKey() == K_ENTER
      FErase( _FIL_ATIVADO )
      Return Nil
   ENDIF
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Cls
   Quit
ELSE
   MontaArquivo( _FIL_ATIVADO )
ENDIF

FUNCTION MontaArquivo( cArquivo )
Local cDevice:= Set( 24 )
Set( 24, cArquivo )
Set( 20, "PRINT" )
DevPos( 01, 01 )
DevOut( " Sistema de controle de acesso. ( S&W Suport System Acess ) " )
Set( 20, "SCREEN" )
Set( 24, cDevice )
Return .T.

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ iniciais
³ Finalidade  ³ Retornar as iniciais de uma String
³ Parametros  ³ String
³ Retorno     ³ Iniciais
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 24/01/1998    -> 5 min
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
FUNCTION Iniciais( cDescricao )
Local cIniciais:= "", cString:= cDescricao
cIniciais:= Left( Alltrim( cString ), 1 )
FOR nCt:= 1 TO LEN( cDescricao )
    cIniciais:= cIniciais + SubStr( cString, At( " ", cString ) + 1, 1 )
    cString:= SubStr( cString, At( " ", cString ) + 2 )
    IF Alltrim( cString + "A" ) == "A"
       EXIT
    ENDIF
NEXT
RETURN AllTrim( cIniciais )


FUNCTION LimpaDegrade()
SetColor( "15/00" )
FOR nCt:= 5 TO 0 Step -2
   nLin:= 0
   FOR nCt2:= 0 TO 24 / nCt
       @ nLin += nCt, 0 Say Space( 80 )
   NEXT
   Inkey( .10 )
NEXT

#Define _COR_NUMERO          "00/10"
#Define _COR_CALC_TECLAS     "15/02"
#Define _COR_CALC_BOX        "15/02"
#Define _COR_CALC_DISPLAY    "13/02"

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ Calculador
³ Finalidade  ³ Apresentar uma calculadora na tela e retornar o resultado
³ Parametros  ³ Nil
³ Retorno     ³ nValor
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Marco/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Procedure Calculador( cProc, nLinha, xVariavel )
Local GetList:= {}
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, MaxCol() )
Local nNumero:= Nil
Local nLinGet:= 5, nColGet:= 50, lMove:= .T.
Local calcula:= 0, calcula2:= 0, calcula3:= 0, contu:= 0, tecla:= 0,;
      janela:= '', teclachr2:= ' ', lMovimenta:= .F.
Local nLin:= Row(), nCol:= Col()

lDelimiters:= Set( _SET_DELIMITERS, .F. )

do while .t.

   /* Movimentacao de tela da calculadora */
   IF lMove
      IF !lMovimenta
         Keyboard Chr( K_SPACE )
      ENDIF
      WHILE .T.
          /* Display da calculadora */
          DispBegin()
          ScreenRest( cTela )
          Mensagem( "[Espaco]Movimenta [+-*/]Calcula [C]Limpa [F12]Retorna [ESC]Abandona" )
          Ajuda( "SWCalc - Calculadora Matem tica" )
          VPBox( nLinGet - 2, nColGet - 1, nLinGet + 10, nColGet + 24, "Calculadora", _COR_CALC_BOX )
          SetColor( "14/08" )
          @ nLinGet, nColGet + 1 Say         "<< Movimenta‡Æo  >>"
          SetColor( _COR_CALC_TECLAS )
          SetCursor( 0 )
          @ nLinGet + 1, nColGet + 1 Say "ÚÄÄÄÂÄÄÄÂÄÄÄ¿ÚÄÄÄÂÄÄÄ¿"
          @ nLinGet + 2, nColGet + 1 Say "³ 7 ³ 8 ³ 9 ³³ + ³ - ³"
          @ nLinGet + 3, nColGet + 1 Say "ÃÄÄÄÅÄÄÄÅÄÄÄ´ÃÄÄÄÅÄÄÄ´"
          @ nLinGet + 4, nColGet + 1 Say "³ 4 ³ 5 ³ 6 ³³ / ³ * ³"
          @ nLinGet + 5, nColGet + 1 Say "ÃÄÄÄÅÄÄÄÅÄÄÄ´ÃÄÄÄÁÄÄÄ´"
          @ nLinGet + 6, nColGet + 1 Say "³ 1 ³ 2 ³ 3 ³³ Igual ³"
          @ nLinGet + 7, nColGet + 1 Say "ÃÄÄÄÁÄÄÄÅÄÄÄ´ÃÄÄÄÄÄÄÄ´"
          @ nLinGet + 8, nColGet + 1 Say "³   0   ³ . ³³  Ce   ³"
          @ nLinGet + 9, nColGet + 1 Say "ÀÄÄÄÄÄÄÄÁÄÄÄÙÀÄÄÄÄÄÄÄÙ"

          /* Display do numero digitado */
          SetColor( _COR_NUMERO )
          DO CASE
             CASE nNumero == Nil
                nNumero:= Nil
             CASE nNumero == "1"
                @ nLinGet + 6, nColGet + 2  Say " 1 "
             CASE nNumero == "2"
                @ nLinGet + 6, nColGet + 6  Say " 2 "
             CASE nNumero == "3"
                @ nLinGet + 6, nColGet + 10 Say " 3 "
             CASE nNumero == "4"
                @ nLinGet + 4, nColGet + 2  Say " 4 "
             CASE nNumero == "5"
                @ nLinGet + 4, nColGet + 6  Say " 5 "
             CASE nNumero == "6"
                @ nLinGet + 4, nColGet + 10 Say " 6 "
             CASE nNumero == "7"
                @ nLinGet + 2, nColGet + 2  Say " 7 "
             CASE nNumero == "8"
                @ nLinGet + 2, nColGet + 6  Say " 8 "
             CASE nNumero == "9"
                @ nLinGet + 2, nColGet + 10 Say " 9 "
             CASE nNumero == "0"
                @ nLinGet + 8, nColGet + 2 Say "   0   "
             CASE nNumero == "+"
                 @ nLinGet + 2, nColGet + 15  Say " + "
             CASE nNumero == "-"
                 @ nLinGet + 2, nColGet + 19  Say " - "
             CASE nNumero == "/"
                 @ nLinGet + 4, nColGet + 15  Say " / "
             CASE nNumero == "*"
                 @ nLinGet + 4, nColGet + 19  Say " * "
             CASE nNumero == "C"
                 @ nLinGet + 8, nColGet + 15  Say "  Ce   "
             CASE nNumero == Chr( K_ENTER )
                 @ nLinGet + 6, nColGet + 15  Say " Igual "
          ENDCASE
          nNumero:= Nil
          DispEnd()
          /* Teste de movimentacao de tela */
          nTecla:= Inkey(0)
          DO CASE
             CASE nTecla == K_RIGHT
                 ++nColGet
             CASE nTecla == K_LEFT
                 --nColGet
             CASE nTecla == K_UP
                  --nLinGet
             CASE nTecla == K_DOWN
                 ++nLinGet
             CASE nTecla == K_SPACE
                 Exit
          ENDCASE
      ENDDO
      lMove:= .F.
      lMovimenta:= .F.
   ENDIF

   /* Get do valor calculado */
   SetColor( _COR_CALC_DISPLAY )
   @ nLinGet, nColGet say '' get calcula picture '@e 99999,999,999,999.9999'
   inkey (0)
   tecla = lastkey ()
   teclachr = chr (tecla)
   if tecla = 27
      exit
   endif
   If Tecla == K_SPACE
      lMovimenta:= .T.
      lMove:= .T.
   EndIf

   If tecla == K_F12
      ScreenRest( cTela )
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      Set( _SET_DELIMITERS, lDelimiters )
      Clear TypeAHead
      KeyBoard Tran( Calcula, '@R 99999999.99' ) + Chr( K_ENTER )
      @ nLin, nCol Say Space(0)
      Return Nil
   EndIf
   if tecla = 67 .or. tecla = 99
      janela = ''
      calcula = 0
      calcula2 = 0
      calcula3 = 0
      contu = 0
      calcula3 = 0
      @ nLinGet, nColGet say '' get calcula picture '@e 99999,999,999,999.9999'
      loop
   endif

   if teclachr != '+' .and. teclachr != '-' .and. teclachr != '*' .and. teclachr != '/' .and. tab_tecla (tecla) != ' ' .and. tecla != 13
      janela = janela + tab_tecla (tecla)
      calcula = val (janela)
      contu = 0
      lMove:= .T.
   endif
   nNumero:= Chr( tecla )

   if teclachr = '+' .or. teclachr = '-' .or. teclachr = '*' .or. teclachr = '/' .or. tecla = 13
      lMove:= .T.
      contu = contu + 1
      if contu = 1
         if calcula2 = 0
            teclachr2 = teclachr
            if teclachr = '*'
               calcula2 = 1
            endif
         endif
         calcula3 = calc (teclachr2, calcula2, calcula)
         if teclachr = '/'
            calcula3 = calcula
         endif
         janela = ''
         calcula2 = calcula3
         calcula = calcula2
      endif
      if tecla != 13
         teclachr2 = teclachr
      endif
   endif
enddo
Set( _SET_DELIMITERS, lDelimiters )
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
@ nLin, nCol Say Space(0)
Return

function tab_tecla
parameters tec
tec = val (alltrim (str (tec)))
do case
   case tec = 49
      tec2 = '1'
   case tec = 50
      tec2 = '2'
   case tec = 51
      tec2 = '3'
   case tec = 52
      tec2 = '4'
   case tec = 53
      tec2 = '5'
   case tec = 54
      tec2 = '6'
   case tec = 55
      tec2 = '7'
   case tec = 56
      tec2 = '8'
   case tec = 57
      tec2 = '9'
   case tec = 48
      tec2 = '0'
   case tec = 46
      tec2 = '.'
   otherwise
      tec2 = ' '
endcase
return tec2
function calc
parameters sinal, val1, val2
do case
   case sinal = '+'
      val3 = val1 + val2
   case sinal = '-'
      val3 = val1 - val2
   case sinal = '*'
      val3 = val1 * val2
   case sinal = '/'
      if val2 != 0
         val3 = val1 / val2
      else
         val3 = 0
      endif
   otherwise
      val3 = 0
endcase
return val3

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ SWGravar
³ Finalidade  ³ Retornar/setar de quanto em quanto tempo dever  gravar
³ Parametros  ³ nQuant
³ Retorno     ³ nQuantGuardada
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function SWGravar( nQtd )
Local nVelhaQtd
Static nQuantidade
IF nQtd == Nil
   IF nQuantidade == Nil
      nQuantidade:= 5
   ENDIF
   Return nQuantidade
ELSE
   nVelhaQtd:= nQuantidade
   nQuantidade:= nQtd
   Return nQtd
ENDIF


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ GravaEmDisco()
³ Finalidade  ³ Grava as informacoes em disco (REDE)
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function GravaEmDisco()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
            cTela:= ScreenSave( 20, 0, 23, MaxCol() )
Local nQtdVezes:= SWGravar()
Static nVezes
   /* Display */
   IF nVezes == Nil
      nVezes:= 0
   ENDIF
   SetColor("01/15")
   @ 24,78 Say "³" + Str( nVezes, 1 )
   /* Gravacao de informacoes */
   IF ++nVezes > SWGravar()
      Mensagem( "S&W! [" + StrZero( RECNO(), 6, 0 ) + "] Gravando informacoes em disco, aguarde..." )
      DBCommit()
      nVezes:= 0
   ENDIF
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil


Function Box10( nLin1, nCol1, nLin2, nCol2 )
nColMax:= 80
WHILE .T.
   cTelaRes:= SaveScreen( 0, 0, 24, 79 )
   nColMax:= nColMax -2
   @ nLin2, nColMax Say Space( nCol2 - nCol1 )
   Timer()
   RestScreen( 0, 0, 24, 79, cTelaRes )
   IF nColMax <= nCol1
      FOR nCt:= nLin2 TO nLin1 Step -1
          Scroll( nCt, nCol1, nLin2, nCol2 )
          DispBox( nCt, nCol1, nLin2, nCol2, _BOX_UM+" "  )
          Timer()
      NEXT
      EXIT
   ENDIF
ENDDO

Function Timer()
Local nCt
FOR nCt:= 1 To 200
   @ 25,0 SAY ""
NEXT


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ JurosSimples
³ Finalidade  ³ Calcular o juros simples c/ base em n§ de dias em atrazo
³ Parametros  ³ nValorBase, dDataVencimento, dDataBase
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function JurosSimples( nValorBase, dDataVencimento, dDataBase )
nPercentual:= SWSet( _GER_JUROSAOMES )
IF dDataBase == Nil
   dDataBase:= DATE()
ELSE
   IF EMPTY( dDataBase )
      dDataBase:= DATE()
   ENDIF
ENDIF
nJurosAoDia:= nPercentual / SWSet( _GER_DIASNOMES )
nDias:= ( dDataBase - dDataVencimento ) - 1
IF nDias <= 0
   Return 0
ENDIF
nPercentJuros:= nJurosAoDia * nDias
nValorFinal:= ( nValorBase * nPercentJuros ) / 100
Return nValorFinal

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ JurosFuturos
³ Finalidade  ³ Calcular o juros c/ base em n§ de dias futuros
³ Parametros  ³ nValorBase, nDataVencimento, dDataBase, nPercentualMes
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function JurosFuturos( nValorBase, dDataVencimento, dDataBase, nPercentualMes )
IF nPercentualMes == Nil
   nPercentual:= SWSet( _GER_JUROSAOMES )
ELSE
   nPercentual:= nPercentualMes
ENDIF
IF dDataBase == Nil
   dDataBase:= DATE()
ELSE
   IF EMPTY( dDataBase )
      dDataBase:= DATE()
   ENDIF
ENDIF
nJurosAoDia:= nPercentual / SWSet( _GER_DIASNOMES )
nDias:= dDataVencimento - dDataBase
IF nDias <= 0
   Return 0
ENDIF
nPercentJuros:= nJurosAoDia * nDias
nValorFinal:= ( nValorBase * nPercentJuros ) / 100
Return nValorFinal


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ SELECAODEVICE
³ Finalidade  ³ Selecao de uma saida de impressao
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Outubro/1998
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function SelecaoDevice()
 Local cCor:= SetColor(), nCursor:= SetCursor(),;
       cTela:= ScreenSave( 0, 0, 24, MaxCol() )

 Static nOpcao
 IF nOpcao==Nil
    nOpcao:= 1
 ENDIF
 SetColor( "15/01,01/15" )
 VPBox( 14, 35, 22, 72, "Dispositivo de Saida", "15/01" )
 @ 15,36 Prompt " Impressora em LPT1                 "
 @ 16,36 Prompt " Impressora em LPT2                 "
 @ 17,36 Prompt " Impressora em LPT3                 "
 @ 18,36 Prompt " Impressora em LPT4 (Rede)          "
 @ 19,36 Prompt " Arquivo IMP.PRN                    "
 @ 20,36 Prompt " Editor de Textos                   "
 @ 21,36 Prompt " Visualizador Soft&Ware             "
 Menu To nOpcao
 IF LastKey() == K_ESC
    SetColor( cCor )
    SetCursor( nCursor )
    ScreenRest( cTela )
    Return Nil
 ENDIF
 DO CASE
    CASE nOpcao == 1
         Set( 24, "LPT1" )
         DispositivoAtual( "LPT1" )
    CASE nOpcao == 2
         Set( 24, "LPT2" )
         DispositivoAtual( "LPT2" )
    CASE nOpcao == 3
         Set( 24, "LPT3" )
         DispositivoAtual( "LPT3" )
    CASE nOpcao == 4
         Set( 24, "LPT4" )
         DispositivoAtual( "LPT4" )
    CASE nOpcao == 5
         Set( 24, "IMP.PRN" )
         DispositivoAtual( "IMP.PRN" )
    CASE nOpcao == 6
         Set( 24, "EDIT.PRN" )
         DispositivoAtual( "EDIT.PRN" )
    CASE nOpcao == 7
         Set( 24, "TELA0000.PRN" )
         DispositivoAtual( "TELA0000.PRN" )
 ENDCASE
 SetColor( cCor )
 SetCursor( nCursor )
 ScreenRest( cTela )
 Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ FimDevice
³ Finalidade  ³ Finalizacao do desvio p/ dispositivo
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function EndDevice()
   Local cDevice:=  DispositivoAtual()
   Set( 20, "SCREEN" )
   Set( 24, "LPT1" )
   IF cDevice == "EDIT.PRN"
      !Edit EDIT.PRN
   ELSEIF cDevice == "TELA0000.PRN"
      ViewFile( "TELA0000.PRN" )
   ENDIF
   SetBlink(.F.)
   Return Nil

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ DispositivoAtual
³ Finalidade  ³ Guardar o dispositivo atual
³ Parametros  ³ cDispositivo
³ Retorno     ³ cDevice
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DispositivoAtual( cDispositivo )
STATIC cDevice
IF !cDispositivo == Nil
   cDevice:= cDispositivo
ENDIF
Return cDevice

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ ABREVIATURA
³ Finalidade  ³
³ Parametros  ³
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function Abreviatura( cDescricao, nQuantidade )
Local cAbreviatura:= ""
cDescricao:= Alltrim( cDescricao )
cAbreviatura:= SubStr( cDescricao, 1, nQuantidade )
cDescricao:= SubStr( cDescricao, nQuantidade + 1 )
FOR nCt:= 1 TO Len( cDescricao )
    cAbreviatura:= cAbreviatura + SubStr( cDescricao, (nPos:= AT( " ", cDescricao )+1), nQuantidade )
    cDescricao:= Alltrim( SubStr( cDescricao, nPos + nQuantidade ) )
NEXT
Return cAbreviatura


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ displayScan
³ Finalidade  ³ Apresenta um percentual no formato ScanDisk
³ Parametros  ³ Nil
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ 25/05/99
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function DisplayScan( nUsado, nTotal, nLinhas, nLin, nCol )
LOCAL nCt, nColunas:= 60
   nLinhas:= IF( nLinhas==Nil, 17, nLinhas)
   IF nColunas==Nil
      nColunas:= ( nTotal / nLinhas ) + 1
      IF nColunas < 60 .OR. nColunas > 60
         nColunas:= 60
      ENDIF
   ENDIF
   D( nUsado, nTotal, nLinhas, nColunas, nLin, nCol )
   Return Nil


/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ D
³ Finalidade  ³ Auxiliar a Rotina DisplayScan
³ Parametros  ³ nUsado/nTotal/nLinhas/nColunas
³ Retorno     ³ Nil
³ Programador ³ Valmor Pereira Flores
³ Data        ³ Maio/1999
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function D( nUsado, nTotal, nLinhas, nColunas, nLin, nCol )
Local nCt
nLin:= IF( nLin==Nil, 3, nLin )
nCol:= IF( nCol==Nil, 4, nCol )

nAreaTotal:= nColunas * nLinhas
Dispbegin()
FOR nCt:= 1 TO nLinhas
    @ nLin+nCt,nCol Say Repl( "°", nColunas )
NEXT
nPonto:= nAreaTotal / nTotal
IF nPonto > 1
   nPonto:= 1
ENDIF
nLinhasPreencher:= INT( ( nPonto * nUsado ) / nColunas )
nColunasResto:=     ( ( ( nPonto * nUsado ) / nColunas ) - INT( ( nPonto * nUsado ) / nColunas ) ) * nColunas
/* Espaco a Preencher */
IF nPonto <= 1
   nLinhasEspaco:= INT( ( nPonto * nTotal ) / nColunas )
   nColunasEspaco:= ( ( ( nPonto * nTotal ) / nColunas ) - INT( ( nPonto * nTotal ) / nColunas ) ) * nColunas
ENDIF
/* Desenha grade */
FOR nCt:= 1 TO nLinhas
    @ nLin+nCt,nCol Say Repl( "°", nColunas ) Color "15/01"
NEXT
nLinhaAtual:= nLin
/* Desenha Linhas e colunas a serem preenchidos */
FOR nCt:= 1 TO nLinhasEspaco
    @ nLin+nCt,nCol Say Repl( "", nColunas ) Color "15/01"
    nLinhaAtual:= nLin+nCt
NEXT
IF nColunasEspaco > 0
   @ nLinhaAtual+1, nCol Say Repl( "", nColunasEspaco ) Color "15/01"
ENDIF
nPosicao:= 0
nLinhaAtual:= nLin
/* Monta Box Preenchido */
FOR nCt:= 1 TO nLinhasPreencher
    FOR nCt2:= 0 TO nColunas-1
        ++nPosicao
        @ nLin+nCt,nCol+nCt2 Say "Û" Color "09/00"
    NEXT
    nLinhaAtual:= nLin+nCt
NEXT
/* Preenche colunas J  atingidas */
IF nLinhasPreencher==0
   FOR nCt2:= 0 TO nColunasResto - 1
       ++nPosicao
       @ nLinhaAtual+1, nCol+nCt2 Say "Û" Color "09/00"
   NEXT
ELSE
   FOR nCt2:= 0 TO nColunasResto - 1
       ++nPosicao
       @ nLinhaAtual+1, nCol+nCt2 Say "Û" Color "09/00"
   NEXT
ENDIF
DispEnd()
Return Nil

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fDepur (cArq, cTex, lNovo)

      IIF (lNovo == NIL, lNovo == .F., NIL)

      IF (FILE (cArq) == .F. .OR. lNovo == .T.)
         cTmp := ""
         cDat := DTOC (DATE ()) + " " + TIME ()
      ELSE
         cTmp := MEMOREAD (cArq)
         cDat := ""
      ENDIF

      cPro := Left (Alltrim (ProcName (1)) + Space (12), 12)
      cLin := Str (ProcLine (1), 6)

      MEMOWRIT (cArq, cTmp + cPro + " " + cLin + " : " + cTex + " " + cDat + ;
                CHR (13) + CHR (10))

   Return (.T.)

// ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

   Function fContaCorr( nContac, cDigVer, GetList )

      Local aBase, cContac, nSoma, nCt1, nResto, nDigito

      aBase  := { 3, 2, 4, 7, 6, 5, 4, 3, 2}
      cContac := StrZero( nContac, 9 )
      nSoma  := 0

      For nCt1 := 1 To 9
         nSoma += aBase [ nCt1 ] * Val( SubStr( cContac, nCt1, 1 ) )
      Next

      nResto := Mod( nSoma, 11 )

      IF nResto == 0
         nDigito := 0
      ELSEIF nResto == 1
         nDigito := 6
      ELSE
         nDigito := 11 - nResto
      ENDIF

      nContac := nContac
      cDigVer:= Str( nDigito, 1, 0 )

      IF ! GetList == Nil
         For nCt:=1 To Len( GetList )
             GetList[ nCt ]:Display()
         Next
      ENDIF

   Return( .T. )


Function Arquivos( cMascara, cDiretorio )
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),;
      nCursor:= SetCursor(), lDelimiters:= Set( _SET_DELIMITERS, .F. )
Local aFiles:= { Space( 30 ) }, cArquivos, nRow:= 1, oTab
Local cCorFundo

  cFile:= ""
  VPBox( 01, 05, 21, 71, "ABERTURA DE ARQUIVOS", _COR_BROW_BOX )
  VPBox( 03, 07, 06, 36, "Arquivo" , _COR_BROW_BOX, .F., .F.,,.F. )
  VPBox( 03, 37, 06, 69, "Na Pasta", _COR_BROW_BOX, .F., .F.,,.F. )
  SetColor( _COR_BROW_BOX )
  IF cDiretorio==Nil
     cDiretorio:= CURDIR()
  ENDIF
  cDiretorio:= PAD( cDiretorio, 60 )
  cCorFundo:= CorFundoAtual()
  cMascara:= PAD( cMascara, 60 )
  Keyboard Chr( K_ENTER ) + Chr( K_ENTER )
  WHILE .T.
     SetCursor( 3 )
     SetColor( _COR_GET_EDICAO )
     @ 05,08 Get cMascara   Pict "@S28"
     @ 05,38 Get cDiretorio Pict "@S31"
     READ
     nRow:= 1
     IF LastKey()==K_ESC
        EXIT
     ENDIF
     IF cDiretorio==Nil
        cArquivos:= ALLTRIM( cMascara )
     ELSE
        IF RIGHT( ALLTRIM( cDiretorio ), 1 )=="\"
           cArquivos:= ALLTRIM( ALLTRIM( cDiretorio ) + cMascara )
        ELSE
           cArquivos:= ALLTRIM( ALLTRIM( cDiretorio ) + "\" + cMascara )
        ENDIF
     ENDIF
     aFiles:= Directory( cArquivos )
     IF aFiles==Nil
     ELSEIF Len( aFiles ) <= 0
     ELSE
        SetCursor( 0 )
        SetColor( "15/01, 00/14" )
        VPBoxSombra( 08, 07, 19, 40, "Arquivos Selecionados", "15/01", "00/" + cCorFundo )
        oTAB:=tbrowsenew( 10, 08, 18, 39 )
        oTAB:addcolumn(tbcolumnnew(,{|| PAD( aFiles[nRow][1], 30 ) }))
        oTAB:AUTOLITE:=.f.
        oTAB:GOTOPBLOCK :={|| nROW:=1}
        oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aFiles)}
        oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aFiles,@nROW)}
        oTAB:dehilite()
        lDelimiters:= Set( _SET_DELIMITERS, .F. )
        WHILE .T.
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1})
            WHILE nextkey()==0 .and. ! oTAB:stabilize()
            ENDDO
            @ 08,45 Say "Nome         " Color "10/" + cCorFundo
            @ 10,45 Say "Data         " Color "10/" + cCorFundo
            @ 12,45 Say "Hora         " Color "10/" + cCorFundo
            @ 14,45 Say "Bytes        " Color "10/" + cCorFundo
            @ 09,45 Say PAD( aFiles[ nRow ][ 1 ], 15 )         Color "15/" + cCorFundo
            @ 11,45 Say Dtoc( aFiles[ nRow ][ 3 ] ) Color "15/" + cCorFundo
            @ 13,45 Say aFiles[ nRow ][ 4 ]         Color "15/" + cCorFundo
            @ 15,45 Say PAD( Alltrim( Tran( aFiles[ nRow ][ 2 ], "@E 999,999,999" ) ), 15 ) Color "15/" + cCorFundo
            nTecla:= Inkey(0)
            IF nTecla==K_ESC .OR. nTecla==K_TAB
               cFile:= Nil
               exit
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
                    cFile:= aFiles[ nRow ][ 1 ]
                    EXIT
               OTHERWISE                ;tone(125); tone(300)
            ENDCASE
            oTAB:refreshcurrent()
            oTAB:stabilize()
        ENDDO
        IF nTecla==K_ENTER
           EXIT
        ENDIF
     ENDIF
  ENDDO
  /* Se arquivo foi selecionado */
  IF !cFile==Nil
     IF RIGHT( ALLTRIM( cDiretorio ), 1 )=="\"
        cFile:= ALLTRIM( ALLTRIM( cDiretorio ) + cFile )
     ELSE
        cFile:= ALLTRIM( ALLTRIM( cDiretorio ) + "\" + cFile )
     ENDIF
  ENDIF
  Set( _SET_DELIMITERS, lDelimiters )
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return IF( !cFile==Nil, Alltrim( cFile ), Nil )



Function SWAlerta( cTxt, aOpcoes )
Local cTela:= ScreenSave( 0, 0, 24, 79 )
loca cCor:= SetColor(), nCol1, nCol2
Local cFundo:= "09"
Local nCursor:= SetCursor()
Local nLin:= 14, nOpcao:= 1

   DesligaMouse()
   SetColor( "15/" + cFundo )

   cTxtRes:= cTxt + ";"
   nCont:= StrVezes( ";", cTxtRes )
   nLinTxt:= nLin - nCont

   aString:= {}

   IF AT( ";", cTxt ) > 0
      FOR nCt:= 1 TO nCont
          AAdd( aString, ALLTRIM( Left( cTxtRes, AT( ";", cTxtRes ) ) ) )
          cTxtRes:= SubStr( cTxtRes, AT( ";", cTxtRes ) + 1 )
      NEXT
   ELSE
      aString:= { cTxt, " " }
      nCont:= nCont + 1
   ENDIF

   nMaiorString:= 0
   FOR nCt:= 1 TO Len( aString )
       aString[ nCt ]:= StrTran( aString[ nCt ], ";", "" )
       IF Len( Alltrim( aString[ nCt ] ) ) > nMaiorString
          nMaiorString:= Len( aString[ nCt ] )
       ENDIF
   NEXT
   cStringOpcoes:= ""
   FOR nCt:= 1 TO Len( aOpcoes )
       cStringOpcoes+= aOpcoes[ nCt ]
   NEXT

   IF Len( cStringOpcoes ) > nMaiorString
      nMaiorString:= Len( cStringOpcoes )
   ENDIF

   nCol1:= Int( 80 - nMaiorString ) / 2
   nCol2:= Int( nCol1 + 4 + nMaiorString )

   nCol2:= nCol1 + nMaiorString + 2

   /* p/ ajustar a coluna inicial */
   cBotoes:= ""
   FOR nCt:= 1 TO Len( aOpcoes )
       cBotoes:= cBotoes + aOpcoes[ nCt ] + Space( 6 )
   NEXT

   DispBegin()
   IF LEN( cBotoes ) > nMaiorString       /* Se botoes for maior que stringmaior */
      VPBox( nLin - nCont, (80-Len(cBotoes))/2, nLin + nCont + 3, ( ( 80 - Len( cBotoes ) ) / 2 ) + Len( cBotoes ) + 4,, "15/" + cFundo )
   ELSE
      VPBox( nLin - nCont, nCol1, nLin + nCont + 3, nCol2 + 4,, "15/" + cFundo )
   ENDIF
   DispEnd()

   FOR nCt:= 1 TO Len( aString )
       @ nLinTxt + nCt + 1, nCol1 + 2 Say PADC( Alltrim( aString[ nCt ] ), nCol2 - nCol1 ) Color "15/" + cFundo
   NEXT

   /* p/ armazenar a posicao inicial de cada botao em um array */
   nCol1:= nCol1 + ( ( ( nCol2 - nCol1 ) - Len( cBotoes ) ) / 2 )
   aColuna:= { nCol1 + 2 }
   FOR nCT:= 1 TO Len( aOpcoes )
       IF nCt > 1
          AAdd( aColuna, aColuna[ nCt-1 ] + Len( aOpcoes[ nCt-1 ] ) + 6 )
       ENDIF
   NEXT

   nTecla:= 0
   nOpcao:= 1
   SetCursor( 0 )
   WHILE !( nTecla==K_ENTER )
       //DispBegin()
       FOR nCt:= 1 TO Len( aOpcoes )
          IF nCt==nOpcao
             SetColor( "12/" + cFundo )
             cCorBotao:= "14/04"
          ELSE
             SetColor( "00/" + cFundo )
             cCorBotao:= "15/01"
          ENDIF
          SWBotao( nLin + Len( aString ) + 1, aColuna[ nCt ], aOpcoes[ nCt ], cFundo,  cCorBotao )
       NEXT
       //DispEnd()

       nTecla:= INKEY( 0 )
       DO CASE
          CASE nTecla==K_LEFT
               --nOpcao
          CASE nTecla==K_RIGHT
               ++nOpcao
          CASE nTecla==K_ENTER
          CASE nTecla==K_ESC
               nOpcao:= Len( aOpcoes )
               EXIT
       ENDCASE
       /* Consistencia da Opcao x aOpcoes */
       IF nOpcao > Len( aOpcoes )
          nOpcao:= 1
       ELSEIF nOpcao <= 0
          nOpcao:= Len( aOpcoes )
       ENDIF
   ENDDO
   LigaMouse()
   SetCursor( nCursor )
   SetColor( cCor )
   ScreenRest( cTela )
   Return nOpcao

  /*****
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Funcao      ³ OCORRENCIA
  ³ Finalidade  ³ Buscar a Posicao do cChr, nOcorrencia(1..9999) na
  ³             ³ cString (A..Z)
  ³ Parametros  ³ nOcorrencia, cChr, cString
  ³ Retorno     ³ nPosicao
  ³ Programador ³ Valmor P. Flores
  ³ Data        ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  */
  Function Ocorrencia( nOcorrencia, cChr, cString )
  nPosicao:= RAT( cChr, StrTran( cString, cChr, "±", nOcorrencia + 1 ) )
  Return nPosicao

  /*****
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Funcao      ³ PULACAMPO
  ³ Finalidade  ³ Pular campos em um Get
  ³ Parametros  ³ Nil
  ³ Retorno     ³ .T.
  ³ Programador ³ Valmor P. Flores
  ³ Data        ³ Outubro/1999
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  */
  Function PulaCampo()
  IF LastKey()==K_UP
     Keyboard Chr( K_UP )
  ELSEIF LastKey()==K_DOWN .OR. LastKey()==K_ENTER
     Keyboard Chr( K_ENTER )
  ENDIF
  Return .T.

  /*****
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Funcao      ³ DIRETORIO
  ³ Finalidade  ³ Verifica a existencia de um diretorio a partir da tentativa de
  ³             ³ gravacao de um arquivo no mesmo...
  ³ Parametros  ³ cDiretorio = Nome do diretorio a localizar
  ³ Retorno     ³ .T. / .F.
  ³ Programador ³ Valmor P. Flores
  ³ Data        ³ Dezembro/1999
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  */
  Function Diretorio( cDiretorio )
  MemoWrit( Alltrim( cDiretorio ) + "\X.TMP", "..." )
  IF !File( Alltrim( cDiretorio ) + "\X.TMP" )
     Return .F.
  ELSE
     Ferase( Alltrim( cDiretorio ) + "\X.TMP" )
     Return .T.
  ENDIF


  Function ExecutePDV()
  Local cComando
  Local cTela:= ScreenSave( 0, 0, 24, 79 )
  IF File( "REPORT\PDVRUN.INI" )
     CLS
     DBCloseAll()
     !COPY REPORT\PDVRUN.INI EXECUTAR.BAT >NUL
     !MVIDEO
     QUIT
  ENDIF
  ScreenRest( cTela )
  AbreGrupo( "TODOS_OS_ARQUIVOS" )
  Return Nil


