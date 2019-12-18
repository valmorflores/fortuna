// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/* 
* Modulo      - VPC21500 
* Descricao   - Impressao de Etiquetas / Codigo de Barras 
* Programador - Valmor Pereira Flores 
* Data        - Fevereiro/2001 
* Atualizacao - Fevereiro/2001 
*/ 

#ifdef HARBOUR
function vpc21500()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), oTab,; 
      cTela2, dData1:= dData2:= Date(), cTela0 
Local nRegistro, nMaximo 
Priv nZerar 
 
   dbSelectAr( _COD_MPRIMA ) 
   dbGoTop() 
   SetCursor( 1 ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   VPBox( 02, 02, 20, 76, " Relacao de Produtos ", _COR_BROW_BOX, .T., .T. ) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "[-]Limpa Todos [ENTER]Quantidade [ESPACO]Desmarca [TAB]Imprime" ) 
   Ajuda( "["+_SETAS+"][PgUp][PgDn]Movimenta" ) 
 
   DBLeOrdem() 
   oTAB:=tbrowsedb( 03, 03, 19, 75 ) 
   oTAB:addcolumn(tbcolumnnew(,{|| Tran( INDICE, "@R 999-9999" ) + " " + CODFAB + " " + LEFT( DESCRI, 35 ) + " " + UNIDAD + " " + SELECT + Tran( QTDIMP, "@R 999999" ) })) 
   oTAB:AUTOLITE:=.F. 
   oTAB:dehilite() 
   whil .t. 
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
      whil nextkey()==0 .and.! oTAB:stabilize() 
      enddo 
      if ( nTecla:=inkey(0) )==K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_UP         ;oTAB:up() 
         case nTecla==K_LEFT       ;oTAB:up() 
         case nTecla==K_RIGHT      ;oTAB:down() 
         case nTecla==K_DOWN       ;oTAB:down() 
         case nTecla==K_PGUP       ;oTAB:pageup() 
         case nTecla==K_PGDN       ;oTAB:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
         case nTecla==K_F2 
              DBMudaOrdem( 1, oTab ) 
         case nTecla==K_F3 
              DBMudaOrdem( 2, oTab ) 
         case nTecla==K_F4 
              DBMudaOrdem( 3, oTab ) 
         case nTecla==K_F5 
              DBMudaOrdem( 4, oTab ) 
 
         case Chr( nTecla ) $ "-" 
              cCorRes:= SetColor() 
              dbGoTop() 
              Aviso( "Buscando itens selecionados..." ) 
 
              nRegistro:= 0 
              nMaximo:= MPR->( LastRec() ) 
              Processo( 0, nMaximo, 0 ) 
 
              WHILE !EOF() 
                 IF QTDIMP > 0 .OR. SELECT=="Sim" 
                    IF NetRLock() 
                       nCol1:= Int( 78 - Len( ALLTRIM( DESCRI ) ) ) / 2 
                       SetColor( "15/15" ) 
                       SetColor( "00/15" ) 
                       @ 12, 15         Say PADC( "Desmarcando selecao do produto", LEN( DESCRI ) ) 
                       @ 14, 15         Say Space( LEN( DESCRI ) ) Color "15/09" 
                       @ 14, nCol1 + 2  Say ALLTRIM( DESCRI ) Color "15/09" 
                       Replace QTDIMP With 0,; 
                               SELECT With "Nao" 
                    ENDIF 
                    DBUnlock() 
                 ENDIF 
                 Processo( ++nRegistro, nMaximo, nRegistro ) 
                 DBSkip() 
              ENDDO 
              DBUnlockAll() 
              SetColor( cCorRes ) 
              DBGoTop() 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
         case nTecla==K_SPACE 
              IF NetRLock() 
                 Replace QTDIMP With 0,; 
                         SELECT With "Nao" 
              ENDIF 
              DBUnlock() 
 
         case nTecla==K_ENTER 
              cCorRes:= SetColor( _COR_GET_EDICAO ) 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              nQtdImp:= IF( QTDIMP==0, SALDO_, QTDIMP ) 
              VPBox( 05, 05, 09, 60, "Quantidade de Etiquetas", _COR_GET_BOX ) 
              @ 07,07 Say "" Get nQtdImp Pict "@E 999,999,999" 
              READ 
              IF LastKey()==K_ENTER 
                 IF NetRLock() 
                    Replace SELECT With IF( nQtdImp > 0, "Sim", "Nao" ) 
                    Replace QTDIMP With nQtdImp 
                 ENDIF 
                 DBUnlock() 
              ENDIF 
              DBUnlockAll() 
              SetColor( cCorRes ) 
              ScreenRest( cTelaRes ) 
 
         case nTecla==K_TAB 
              nIndice:= IndexOrd() 
              cIndice:= IndexKey( IndexOrd() ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              INDEX ON &cIndice TO TMPIND.TMP FOR SELECT=="Sim" 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
              nOpcao:= SWAlerta( "<< ETIQUETAS / PRODUTOS >>; Qual formato deseja imprimir?", { "A", "B", "C", "D", "E", "Nenhum" } ) 
 
              nZerar:= 0 
              //IF nOpcao <> 6 
              //   nZerar:= SWAlerta( "<< ZERAR INFORMACOES DE QUANTIDADES IMPRESSAS >>; Deseja limpar as informacoes de quantidade; apos imprimir as informacoes?", { "Sim", "Nao" } ) 
              //ENDIF 
 
              do case 
                 case nOpcao == 1 
                      Relatorio( "ETQBAR1.REP" ) 
                 case nOpcao == 2 
                      Relatorio( "ETQBAR2.REP" ) 
                 case nOpcao == 3 
                      Relatorio( "ETQBAR3.REP" ) 
                 case nOpcao == 4 
                      Relatorio( "ETQBAR4.REP" ) 
                 case nOpcao == 5 
                      Relatorio( "ETQBAR5.REP" ) 
              endcase 
 

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                set index to "&gdir/mprind01.ntx", "&gdir/mprind02.ntx", "&gdir/mprind03.ntx", "&gdir/mprind04.ntx", "&gdir/mprind05.ntx"      
              #else 
                Set Index To "&GDir\MPRIND01.NTX", "&GDir\MPRIND02.NTX", "&GDir\MPRIND03.NTX", "&GDir\MPRIND04.NTX", "&GDir\MPRIND05.NTX"      
              #endif
              DBSetOrder( nIndice ) 
 
              /// Zerar Informacoes 
              IF nZerar == 1 
                 Aviso( "Ajustando quantidades, aguarde...." ) 
                 DBSetOrder( 1 ) 
                 DBGoTop() 
                 WHILE !EOF() 
                     IF SELECT=="Sim" .AND. QTDIMP <= 0 
                        IF NetRLock() 
                           Replace SELECT With "Nao",; 
                                   QTDIMP With 0 
                        ENDIF 
                        DBUnlock() 
                     ENDIF 
                     DBSkip() 
                  ENDDO 
                  DBUnlock() 
              ENDIF 
 
 
              DBGoTop() 
              oTab:RefreshAll() 
              WHILE !oTab:Stabilize() 
              ENDDO 
 
 
         case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTAB:refreshcurrent() 
      oTAB:stabilize() 
   enddo 
   dbunlockall() 
   FechaArquivos() 
   ScreenRest(cTELA) 
   SetColor(cCOR) 
   SetCursor(nCURSOR) 
   Return Nil 
 
Function ZeraQtdEtiqueta( nQEtiqueta ) 
 IF nZerar==1 
    IF MPR->( NetRLock() ) 
       IF MPR->QTDIMP > 0 
          Replace MPR->QTDIMP With MPR->QTDIMP - nQEtiqueta 
          IF MPR->QTDIMP <= 0 
             Replace MPR->QTDIMP With 0,; 
                     MPR->SELECT With "Sim" 
          ENDIF 
       ELSE 
          Replace MPR->QTDIMP With 0,; 
                  MPR->SELECT With "Sim" 
       ENDIF 
    ENDIF 
    DBUnlock() 
 ENDIF 
