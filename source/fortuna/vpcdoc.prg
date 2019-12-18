// ## CL2HB.EXE - Converted
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPCDOC 
³ Finalidade  ³ Impressao de DOCs Bancarios 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ Nil 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
 
#include "INKEY.CH" 
#include "VPF.CH" 


#ifdef HARBOUR
function vpcdoc()
#endif


Parameters nNotaFiscal 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:=select(), nOrdem:= IndexOrd(), dData:=date(), nQuant:=1,; 
      aHistorico:= {}, cDevice:= SWSet( _PRN_BLOQUETOS ), cArquivoInst:= "            " 
Local cTelaRes 
Local cBanco:= "01" 
 
   Ajuda("[ENTER]Confirma") 
   VPBox(03,28,10,73,"Impressao de Bloquetos",COR[12]) 
   setcolor(COR[12]) 
   SetCursor( 1 ) 
   @ 04,30 Say "Formato do Bloqueto.:" Get cBanco Pict "XX" Valid BuscaFormato( @cBanco, @cArquivoInst, GetList ) 
   @ 05,30 say "Quantidade de copias:" get nQuant pict "99" 
   @ 06,30 say "Data de emissao.....:" get dData 
   @ 07,30 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
   @ 08,30 Say "Porta Impressao.....:" Get cDevice 
   @ 09,30 Say "Arquivo Report......:" Get cArquivoInst 
   read 
 
   IF LastKey() == K_ESC .OR.; 
      !Confirma(07,60,"Confirma?","Confirma a impressao dos dados.","S") 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   Set( 24, cDevice ) 
 
   IF nNotaFiscal==Nil 
      DBSelectAr( _COD_NFISCAL ) 
      DBSetOrder( 1 ) 
      IF !( DBSeek( DPA->CODNF_ ) ) 
         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         Mensagem( "Nao acessou a nota.", 10 ) 
         ScreenRest( cTelaRes ) 
      ENDIF 
   ENDIF 
   DBSelectAr( _COD_DUPAUX ) 
   IF nNotaFiscal <> Nil 
      DPA->( DBSetOrder( 1 ) ) 
      WHILE DPA->CODNF_ == nNotaFiscal 
         cLocal:=     Space( 30 ) 
         cEspDoc:=    "DM" 
         aHistorico:= IOFillText( MemoRead( cArquivoInst ) ) 
         FOR nCt1:= 1 TO nQuant 
             IF DPA->DTQT__ == CTOD("  /  /  ") .AND. DPA->VLR___ <> 0 .AND. DPA->NFNULA == " " 
                nCodigo:=   DPA->SEQUE_ 
                dDataVenc:= DPA->VENC__ 
                nValor_:=   DPA->VLR___ 
                Nf:=        DPA->CODNF_ 
                Relatorio( cArquivoInst ) 
             ENDIF 
         NEXT 
         DPA->( DBSkip() ) 
      ENDDO 
   ELSE 
      cLocal:= Space( 30 ) 
      cEspDoc:= "DM" 
      aHistorico:= IOFillText( MEMOREAD( cArquivoInst ) ) 
      DBSelectAr( _COD_DUPAUX ) 
      FOR nCt1=1 to nQuant 
          IF DTQT__ == CTOD("  /  /  ") .AND. VLR___ <> 0 .AND. NFNULA == " " 
             nCodigo:=   SEQUE_ 
             dDataVenc:= VENC__ 
             nValor_:=   VLR___ 
             Nf:=        CODNF_ 
             Relatorio( cArquivoInst ) 
          ENDIF 
      NEXT 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ BuscaFormato 
³ Finalidade  ³ Exibicao e retorno dos formatos de Bloquetos Bancarios 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 17/Setembro/1999 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Static Function BuscaFormato( cFormato, cArquivoInst, GetList ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCt, nRow:= 1, nTecla, oTab 
Local aFormatos:= { { "01", " BANRISUL            ", "DOC041.REP"},; // 041 
                    { "04", " BANCO DO BRASIL     ", "DOC001.REP"},; // 001 
                    { "11", " BANDEIRANTES        ", "DOC230.REP"},; // 230 
                    { "02", " BRADESCO            ", "DOC349.REP"},; // 349 
                    { "06", " CAIXA               ", "DOC010.REP"},; // 010 
                    { "07", " HSBC                ", "DOC399.REP"},; // 399 
                    { "08", " ITAU                ", "DOC341.REP"},; // 341 
                    { "05", " MERIDIONAL          ", "DOCnnn.REP"},; // 
                    { "09", " REAL                ", "DOC237.REP"},; // 237 
                    { "12", " SUDAMERIS           ", "DOCnnn.REP"},; // 
                    { "10", " UNIBANCO            ", "DOC409.REP"}}  // 409 
 
   SetColor( _COR_BROWSE ) 
 
   VPBOX( 10, 09, 10 + Len( aFormatos ) + 1, 40, " Formato do Bloqueto ", _COR_BROW_BOX ) 
 
   oTab:=tbrowsenew(11, 10, 11 + Len( aFormatos ) - 1, 39) 
   oTab:addcolumn(tbcolumnnew(,{|| aFormatos[ nRow ][ 1 ] + " - " + aFormatos[ nRow ][ 2 ] + Space( 20 ) })) 
   oTab:AUTOLITE:=.F. 
   oTab:GOTOPBLOCK :={|| nROW:=1} 
   oTab:GOBOTTOMBLOCK:={|| nROW:=len(aFormatos)} 
   oTab:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aFormatos,@nROW)} 
   oTab:dehilite() 
 
   oTab:GoTop() 
   oTab:RefreshAll() 
   IF !( aFormatos[ nRow ][ 1 ]==cFormato ) 
      FOR nCt:= 1 TO Len( aFormatos ) 
         oTab:Down() 
         oTab:RefreshAll() 
         WHILE !oTab:Stabilize(); ENDDO 
         IF aFormatos[ nRow ][ 1 ] == cFormato 
            EXIT 
         ENDIF 
      NEXT 
   ENDIF 
   WHILE !oTab:Stabilize() 
   ENDDO 
 
   WHILE .T. 
       oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
       WHILE nextkey()==0 .and. ! oTab:stabilize() 
       ENDDO 
       nTecla:= Inkey(0) 
       IF nTecla==K_ESC 
          EXIT 
       ENDIF 
       DO CASE 
          CASE nTecla==K_UP         ;oTab:up() 
          CASE nTecla==K_DOWN       ;oTab:down() 
          CASE nTecla==K_LEFT       ;oTab:up() 
          CASE nTecla==K_RIGHT      ;oTab:down() 
          CASE nTecla==K_PGUP       ;oTab:pageup() 
          CASE nTecla==K_CTRL_PGUP  ;oTab:gotop() 
          CASE nTecla==K_PGDN       ;oTab:pagedown() 
          CASE nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
          CASE nTecla==K_F12        ;Calculador() 
          CASE nTecla==K_ENTER 
               cFormato:= aFormatos[ nRow ][ 1 ] 
               cArquivoInst:= aFormatos[ nRow ][ 3 ] 
               EXIT 
          OTHERWISE                ;tone(125); tone(300) 
       ENDCASE 
       oTab:refreshcurrent() 
       oTab:stabilize() 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   FOR nCt:= 1 TO Len( GetList ) 
       GetList[ nCt ]:Display() 
   NEXT 
   Return .T. 
 
