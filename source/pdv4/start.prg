#Include "INKEY.CH"
#Define _BOX_UM      "µº¶½¹»¸¼"

Para lFinaliza
lAtivado:= .F.
IF Empty( lFinaliza )
   SetColor( "00/00" )
   ScanLines( 350, 0 )
   if !FontDefine(1,1)
   Else
      TrocaFonte(.T.)
   Endif
   SetBlink( .F. )
   SetColor( "15/09" )
ENDIF

IF !lFinaliza==Nil
   IF UPPER( ALLTRIM( lFinaliza ) )=="RESTAURAMODO"
      SetColor( "00/00" )
      ScanLines( 350, 0 )
      if !FontDefine(1,1)
      Else
         TrocaFonte(.T.)
      Endif
      Quit
   ENDIF
ENDIF

IF ( File( "SUPORTE.CTR" ) ) .AND. EMPTY( lFinaliza )
   SetCursor( 0 )
   SetColor( "14/01" )
   Scroll( 05, 10, 18, 70 )
   @ 05, 10 TO 18, 70
   SetColor( "15/01" )
   !Dir >COMERRO.TMP
   @ 08,12 Say PADC( "O sistema nÆo foi finalizado corretamente durante", 58 )
   @ 10,12 Say PADC( "a ultima execucao nesta maquina!", 58 )
   @ 12,12 Say PADC( "Transmita esta informacao ao respons vel pelo CPD", 58 )
   @ 14,12 Say PADC( "ou ligue para Soft&Ware Informatica.", 58 )
   @ 16,12 Say PADC( "F: (051) 471.6600 / (051) 911.28364", 58 )
   WHILE .T.
      /* ÛÛÛÛÛ [°°°°°°°°°TAB-Obrigatorio°°°°°°°°] ÛÛÛÛÛ */
      Inkey( 0.05 )
      nTecla:= K_TAB
      DO CASE
         CASE nTecla==K_ENTER
              Cls
              !DIR >FIM.TMP
              Quit
         CASE nTecla==K_DEL
              cTelaRes1:= ScreenSave( 0, 0, 24, 79 )
              IF File( "ULTIMA.TMP" )
                 Restore From ULTIMA.TMP Additive
                 ScreenRest( cTelaX )
                 Inkey(0)
              ENDIF
              ScreenRest( cTelaRes1 )
         CASE nTecla==K_TAB
              FErase( "*." )
              EXIT
      ENDCASE
   ENDDO
ENDIF

IF !EMPTY( lFinaliza )
   IF !File( "COMERRO.TMP" )
      cTelaX:= ScreenSave( 0, 0, 24, 79 )
      Save To ULTIMA.TMP
   ENDIF
   ferase( "VPCEI1U2.EXE" )
   Quit
ENDIF
_COMSOMBRA:= "S"
Sele 0
Use VPCEICFG.DAT
GDir:= UnZipChr( GDIR__ )
DBCloseArea()
IF File( GDir - "\GUARDIAO.SYS" )
   Sele 0
   Use &GDir\GUARDIAO.SYS Exclusive
   IF Used()
      IF LastRec() > 30000
         DBGoTop()
         FLock()
         IF !NetErr()
            WHILE !EOF()
               Dele
               DBSkip()
               IF Recno() == 15000
                  EXIT
               ENDIF
            ENDDO
         ENDIF
      ENDIF
      //DBPack()
   ENDIF
ENDIF

IF File( "SUPORTE.CTR" )
   Scroll( 05, 10, 18, 70 )
   DispBox( 05, 10, 18, 70, _BOX_UM )
   SetColor( "14/09" )
   Scroll( 06, 11, 17, 69 )
   SetColor( "14/09" )
   @ 07,11 Say "               MODO DE SEGURANCA DO SISTEMA                "
   @ 09,11 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 10,11 Say " Ajustando parametros do sistema, aguarde..."
   Inkey(.50)
   @ 11,11 Say " Limpando arquivos temporarios..."
   aeval(directory("*.TMP"),{|ARQ|FileDel( CURDIR() + "\"+ARQ[1] ) })
   Inkey(.50)
   @ 12,11 Say " Limpando arquivos de indice locais desatualizados..."
   aeval(directory("*.NTX"),{|ARQ|FileDel( CURDIR() + "\"+ARQ[1] ) })
   Inkey(.50)
   @ 13,11 Say " Limpando buffers..."
   Inkey(.50)
   FileDel( "SUPORTE.CTR" )
   Scroll( 06, 11, 17, 69 )
   SetColor( "14/09" )
// @ 06,11 Say " Carregando sistema em modo de execucao normal... "
   @ 06,11 Say " Inicializando o Sistema ... "
   IF !File( "VPCEI.000" )
      FCompress( "VPCEI1U2.EXE", "VPCEI.000" )
   ENDIF
   FErase( "VPCEI1U2.EXE" )
ENDIF
Run DIR >VIDEO.256
SetGmode( 257 )
SetHires(0)
PicRead( 0, 0, 1, "FUNDO.BMP" )
LoadCSet( 0, "VSYS14.PTX" )
SayString( 2, 03, 4, 0, 3, "", 1, 0 )
IF !File( "VPCEI.000" )
   FCompress( "VPCEI1U2.EXE", "VPCEI.000" )
ENDIF
IF !File( "VPCEI1U2.EXE" )
   FDCompress( "VPCEI.000", "VPCEI1U2.EXE" )
ENDIF
Quit

***************************************
Static Function FileDel( cArquivo )
Ferase( cArquivo )
Return(.t.)

/*****
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Funcao      ³ SAY
³ Finalidade  ³ Identico a rotina Say do Clipper
³ Parametros  ³
³ Retorno     ³
³ Programador ³ Valmor Pereira Flores
³ Data        ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Function SWSAY( nLin, nCol, cFileFonte, cTexto, nCorFrente, nCorFundo )
//cFonte:= BC_FONTEM( cFileFonte )
//BC_DTEXTM( nCorFrente, -1, -1, "", cFonte, nCorFundo )
nPropV:= ( 95 / 25 ) / 100
nLin:=   ( 25 - nLin ) * nPropV
nPropH:= ( 100 / 80 ) / 100
nCol:=   ( nCol ) * nPropH
//BC_TEXTM( nCol, nLin, cTexto )
//BC_LIBFM( cFonte )
Return Nil



FUNCTION DESLIGAMOUSE

FUNCTION LIGAMOUSE

/*
* Modulo      - SCREENSAVE
* Finalidade  - Gravar parte da tela e suas coordenadas na variavel caracter.
* Parametros  - LIN1,COL1,LIN2,COL2=>Coordenadas.
* Programador - Valmor Pereira Flores
* Data        - 31/Agosto/94
* Atualizacao -
*/
func screensave(LIN1,COL1,LIN2,COL2)
Local cTela
DesligaMouse()
cTela:=chr(LIN1)+CHR(COL1)+CHR(LIN2)+CHR(COL2)+savescreen(LIN1,COL1,LIN2,COL2)
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
DesligaMouse()
restscreen( asc(substr(TELA,1,1)),asc(substr(TELA,2,1) ),;
            asc(substr(TELA,3,1)),asc(substr(TELA,4,1)),substr(TELA,5) )
return nil


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


