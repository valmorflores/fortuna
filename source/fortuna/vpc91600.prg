// ## CL2HB.EXE - Converted
#include "INKEY.CH" 
#include "VPF.CH" 
/* 
*      Funcao - VPC916000 
*  Finalidade - Exibir menu de CONTAS A PAGAR & CONTAS A RECEBER. 
*        Data - 
* Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc91600()
#endif

  loca cTELA:=zoom(15,34,21,62), cCOR:=setcolor(), nOPCAO:=0
  vpbox(15,34,21,62) 
  whil .t. 
     mensagem("") 
     aadd(MENULIST,menunew(16,35," 1 Bloquetos              ",2,COR[11],; 
          "Inclusao, alteracao, verificacao e exclusao de bloquetos.",,,    COR[6],.T.)) 
     aadd(MENULIST,menunew(17,35," 2 Bloquetos Programados  ",2,COR[11],; 
          "Alteracao, verificacao e exclusao de bloquetos programados.",,,  COR[6],.T.)) 
     aadd(MENULIST,menunew(18,35," 3 Gerar Automaticamente  ",2,COR[11],; 
          "Gerar bloquetos a partir do cadastro de Contas a Receber.",,,          COR[6],.T.)) 
     aadd(MENULIST,menunew(19,35," 4 Pesquisas              ",2,COR[11],; 
          "Consultar os bloquetos ativos e pendentes.",,,                   COR[6],.T.)) 
     aadd(MENULIST,menunew(20,35," 0 Retorna                ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
     menumodal(MENULIST,@nOPCAO); MENULIST:={} 
     do case 
        case nOpcao=5 .OR. lastkey()=K_ESC ; exit 
        case nOpcao==1 ; Bloquetos() 
        case nOpcao==2 ; BloquetosProg() 
        case nOpcao==3 ; GerarDocDuplicata() 
        case nOpcao==4 ; PesquisaBloquetos() 
     endcase 
  enddo 
  unzoom(cTELA) 
  setcolor(cCOR) 
return nil 
 
 STATIC FUNCTION PesquisaBloquetos() 
  loca cTELA:=zoom(11,53,17,77), cCOR:=setcolor(), nOPCAO:=0 
  vpbox(11,53,17,77) 
  whil .t. 
     mensagem("") 
     aadd(MENULIST,menunew(12,54," 1 Bloq. por Clientes ",2,COR[11],; 
          "Consulta bloquetos por clientes.",,,    COR[6],.T.)) 
     aadd(MENULIST,menunew(13,54," 2 Bloq. por Vencto.  ",2,COR[11],; 
          "Consulta bloquetos por intervalo de vencimento.",,,  COR[6],.T.)) 
     aadd(MENULIST,menunew(14,54," 3 Bloq. por periodo  ",2,COR[11],; 
          "Consulta bloquetos por periodo de emissao.",,,          COR[6],.T.)) 
     aadd(MENULIST,menunew(15,54," 4 Bloq. por historico",2,COR[11],; 
          "Consulta bloquetos por historicos.",,,                   COR[6],.T.)) 
     aadd(MENULIST,menunew(16,54," 0 Retorna            ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
 
     menumodal(MENULIST,@nOPCAO); MENULIST:={} 
     do case 
        case nOpcao=5 .OR. lastkey()=K_ESC ; exit 
        case nOpcao=1; BloqCliente() 
        case nOpcao=2; BloqVencim() 
        case nOpcao=3; BloqPeriodo() 
        case nOpcao=4; BloqHistorico() 
     endcase 
  enddo 
  unzoom(cTELA) 
  setcolor(cCOR) 
return nil 
 
STATIC FUNCTION BloqCliente() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCliente:= 0, dDataIni:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ),; 
      dDataFim:= Date(), nSoma1:= nSoma2:= nSoma3:= nSoma4:= 0, aMatriz:= {}, nRow:= 1, oTab, nTecla,; 
      nDevice:= 1, cCliente:= Space( 40 ) 
 
   DBSelectAr( _COD_BLOQUETO ) 
   VPBox( 10, 10, 21, 77, "Pesquisa" ) 
   DispBox( 11,11,13,47 ) 
   DispBox( 14,11,16,47 ) 
   DispBox( 11,48,16,76 ) 
   @ 11,20 Say " Periodo de Vencimento " 
   @ 14,25 Say " Cliente " 
   @ 11,53 Say " Apresentacao " 
   @ 13,53 Say "    Monitor   " 
   @ 12,14 Say "De:" Get dDataIni When; 
     Mensagem( "Digite a data de inicio para pesquisa." ) 
   @ 12,30 Say "At‚:" Get dDataFim When; 
     Mensagem( "Digite a data de termino para pesquisa." ) 
   @ 15,20 Say "Numero:" Get nCliente Pict "999999" Valid PesqCli( @nCliente ) When; 
     Mensagem( "Digite o nome do cliente." ) 
   READ 
   IF LastKey() <> K_ESC 
      DBSelectAr( _COD_BLOQUETO ) 
      DBSetOrder( 1 ) 
      DBSeek( dDataIni, .T. ) 
      WHILE !EOF() 
          IF CodCli==nCliente .AND. VENC__ >= dDataIni .AND.; 
                                    VENC__ <= dDataFim 
             cCliente:= DESCRI 
             Mensagem( "Procesando a duplicata#" + Duplic + ", aguarde..." ) 
             AAdd( aMatriz, { TIPTIT, DUPLIC, BANCO_, AGENCI, CONTA_, GERAR_, EMISS_, VALOR_, VENC__, DTQUIT, JUROS_, CTAPGT } ) 
             IF !Empty( DTQUIT ) 
                nSoma1+= Valor_ 
                nSoma4+= Juros_ 
             ELSE 
                nSoma2+= Valor_ 
             ENDIF 
             nSoma3+= Valor_ 
          ENDIF 
          DBSkip() 
      ENDDO 
 
      IF nDevice == 1 
         AAdd( aMatriz, { "ÄÄÄ", "QUITADAS  ", 0, 0, 0, 0, Space(8), nSoma1, Space(8), Space(8), nSoma4, 0 } ) 
         AAdd( aMatriz, { "ÄÄÄ", "PENDENTES ", 0, 0, 0, 0, Space(8), nSoma2, Space(8), Space(8), 0, 0 } ) 
         AAdd( aMatriz, { "ÄÄÄ", "TOTAL     ", 0, 0, 0, 0, Space(8), nSoma3, Space(8), Space(8), 0, 0 } ) 
         vpbox(0,0,22,79,"Bloquetos de Cobranca",COR[20],.T.,.T.,COR[19]) 
         @ 01,01 Say cCliente 
         @ 01,45 Say "Periodo de " + DTOC( dDataIni ) + " ate " + DTOC( dDataFim ) + "." 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "Tipo Duplicata bco Agc Cta Gr Emissao  Vlr. Total  Vencimen Dt.Quit.  Juros    Conta " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowsenew(03,01,21,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 1 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 2 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 3 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 4 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 5 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 6 ], 2, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 7 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 8 ], "@e 9999,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 9 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 10 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 11 ], "@e 99,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 12 ], 3, 0 ) })) 
         oTAB:AUTOLITE:=.f. 
         oTAB:GOTOPBLOCK :={|| nROW:=1} 
         oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aMatriz )} 
         oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nROW ) } 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,12},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ENDIF 
   ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
STATIC FUNCTION BloqVencim() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCliente:= 0, dDataIni:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ),; 
      dDataFim:= Date(), nSoma1:= nSoma2:= nSoma3:= nSoma4:= 0, aMatriz:= {}, nRow:= 1, oTab, nTecla,; 
      nDevice:= 1, cCliente:= Space( 40 ) 
 
   DBSelectAr( _COD_BLOQUETO ) 
   VPBox( 10, 10, 21, 77, "Pesquisa" ) 
   DispBox( 11,11,13,47 ) 
   DispBox( 14,11,16,47 ) 
   DispBox( 11,48,16,76 ) 
   @ 11,20 Say " Periodo de Vencimento " 
   @ 11,53 Say " Apresentacao " 
   @ 13,53 Say "    Monitor   " 
   @ 12,14 Say "De:" Get dDataIni When; 
     Mensagem( "Digite a data de inicio para pesquisa." ) 
   @ 12,30 Say "At‚:" Get dDataFim When; 
     Mensagem( "Digite a data de termino para pesquisa." ) 
   //@ 15,20 Say "Numero:" Get nCliente Pict "999999" Valid PesqCli( @nCliente ) When; 
   //  Mensagem( "Digite o nome do cliente." ) 
   READ 
   IF LastKey() <> K_ESC 
      DBSelectAr( _COD_BLOQUETO ) 
      DBSetOrder( 1 ) 
      DBSeek( dDataIni, .T. ) 
      WHILE !EOF() 
          IF VENC__ >= dDataIni .AND. VENC__ <= dDataFim 
             Mensagem( "Procesando a duplicata#" + Duplic + ", aguarde..." ) 
             AAdd( aMatriz, { TIPTIT, DUPLIC, BANCO_, AGENCI, CONTA_, GERAR_, EMISS_, VALOR_, VENC__, DTQUIT, JUROS_, CTAPGT, DESCRI } ) 
             IF !Empty( DTQUIT ) 
                nSoma1+= Valor_ 
                nSoma4+= Juros_ 
             ELSE 
                nSoma2+= Valor_ 
             ENDIF 
             nSoma3+= Valor_ 
          ENDIF 
          DBSkip() 
      ENDDO 
 
      IF nDevice == 1 
         AAdd( aMatriz, { "ÄÄÄ", "QUITADAS  ", 0, 0, 0, 0, Space(8), nSoma1, Space(8), Space(8), nSoma4, 0, "TOTAL" + SPACE( 40 ) } ) 
         AAdd( aMatriz, { "ÄÄÄ", "PENDENTES ", 0, 0, 0, 0, Space(8), nSoma2, Space(8), Space(8), 0, 0, "TOTAL" + SPACE( 40 ) } ) 
         AAdd( aMatriz, { "ÄÄÄ", "TOTAL     ", 0, 0, 0, 0, Space(8), nSoma3, Space(8), Space(8), 0, 0, "TOTAL" + SPACE( 40 ) } ) 
         vpbox(0,0,22,79,"Bloquetos de Cobranca",COR[20],.T.,.T.,COR[19]) 
         @ 01,45 Say "Periodo de " + DTOC( dDataIni ) + " ate " + DTOC( dDataFim ) + "." 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "Tipo Duplicata bco Agc Cta Gr Emissao  Vlr. Total  Vencimen Dt.Quit.  Juros    Conta " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowsenew(03,01,21,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 1 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 2 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 3 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 4 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 5 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 6 ], 2, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 7 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 8 ], "@e 9999,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 9 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 10 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 11 ], "@e 99,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 12 ], 3, 0 ) })) 
         oTAB:AUTOLITE:=.f. 
         oTAB:GOTOPBLOCK :={|| nROW:=1} 
         oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aMatriz )} 
         oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nROW ) } 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,12},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            @ 01,01 Say aMatriz[ nRow ][ 13 ] 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ENDIF 
   ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
STATIC FUNCTION BloqPeriodo() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCliente:= 0, dDataIni:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ),; 
      dDataFim:= Date(), nSoma1:= nSoma2:= nSoma3:= nSoma4:= 0, aMatriz:= {}, nRow:= 1, oTab, nTecla,; 
      nDevice:= 1, cCliente:= Space( 40 ) 
 
   DBSelectAr( _COD_BLOQUETO ) 
   VPBox( 10, 10, 21, 77, "Pesquisa" ) 
   DispBox( 11,11,13,47 ) 
   DispBox( 14,11,16,47 ) 
   DispBox( 11,48,16,76 ) 
   @ 11,20 Say " Periodo de Vencimento " 
   @ 11,53 Say " Apresentacao " 
   @ 13,53 Say "    Monitor   " 
   @ 12,14 Say "De:" Get dDataIni When; 
     Mensagem( "Digite a data de inicio para pesquisa." ) 
   @ 12,30 Say "At‚:" Get dDataFim When; 
     Mensagem( "Digite a data de termino para pesquisa." ) 
   //@ 15,20 Say "Numero:" Get nCliente Pict "999999" Valid PesqCli( @nCliente ) When; 
   //  Mensagem( "Digite o nome do cliente." ) 
   READ 
   IF LastKey() <> K_ESC 
      DBSelectAr( _COD_BLOQUETO ) 
      DBSetOrder( 1 ) 
      DBGoTop() 
      WHILE !EOF() 
          IF EMISS_ >= dDataIni .AND. EMISS_ <= dDataFim 
             Mensagem( "Procesando a duplicata#" + Duplic + ", aguarde..." ) 
             AAdd( aMatriz, { TIPTIT, DUPLIC, BANCO_, AGENCI, CONTA_, GERAR_, EMISS_, VALOR_, VENC__, DTQUIT, JUROS_, CTAPGT, DESCRI } ) 
             IF !Empty( DTQUIT ) 
                nSoma1+= Valor_ 
                nSoma4+= Juros_ 
             ELSE 
                nSoma2+= Valor_ 
             ENDIF 
             nSoma3+= Valor_ 
          ENDIF 
          DBSkip() 
      ENDDO 
 
      IF nDevice == 1 
         AAdd( aMatriz, { "ÄÄÄ", "QUITADAS  ", 0, 0, 0, 0, Space(8), nSoma1, Space(8), Space(8), nSoma4, 0, "TOTAL" + SPACE( 40 ) } ) 
         AAdd( aMatriz, { "ÄÄÄ", "PENDENTES ", 0, 0, 0, 0, Space(8), nSoma2, Space(8), Space(8), 0, 0, "TOTAL" + SPACE( 40 ) } ) 
         AAdd( aMatriz, { "ÄÄÄ", "TOTAL     ", 0, 0, 0, 0, Space(8), nSoma3, Space(8), Space(8), 0, 0, "TOTAL" + SPACE( 40 ) } ) 
         vpbox(0,0,22,79,"Bloquetos de Cobranca",COR[20],.T.,.T.,COR[19]) 
         @ 01,45 Say "Periodo de " + DTOC( dDataIni ) + " ate " + DTOC( dDataFim ) + "." 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "Tipo Duplicata bco Agc Cta Gr Emissao  Vlr. Total  Vencimen Dt.Quit.  Juros    Conta " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowsenew(03,01,21,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 1 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 2 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 3 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 4 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 5 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 6 ], 2, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 7 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 8 ], "@e 9999,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 9 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 10 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 11 ], "@e 99,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 12 ], 3, 0 ) })) 
         oTAB:AUTOLITE:=.f. 
         oTAB:GOTOPBLOCK :={|| nROW:=1} 
         oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aMatriz )} 
         oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nROW ) } 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,12},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            @ 01,01 Say aMatriz[ nRow ][ 13 ] 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ENDIF 
   ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
STATIC FUNCTION BloqHistorico() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nHistor:= 0, dDataIni:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ),; 
      dDataFim:= Date(), nSoma1:= nSoma2:= nSoma3:= nSoma4:= 0, aMatriz:= {}, nRow:= 1, oTab, nTecla,; 
      nDevice:= 1, cHistor:= Space( 40 ) 
 
   DBSelectAr( _COD_BLOQUETO ) 
   VPBox( 10, 10, 21, 77, "Pesquisa" ) 
   DispBox( 11,11,13,47 ) 
   DispBox( 14,11,16,47 ) 
   DispBox( 11,48,16,76 ) 
   @ 11,20 Say " Periodo de Vencimento " 
   @ 11,53 Say " Apresentacao " 
   @ 13,53 Say "    Monitor   " 
   @ 12,14 Say "De:" Get dDataIni When; 
     Mensagem( "Digite a data de inicio para pesquisa." ) 
   @ 12,30 Say "At‚:" Get dDataFim When; 
     Mensagem( "Digite a data de termino para pesquisa." ) 
   @ 15,20 Say "Numero:" Get nHistor Pict "999999" Valid PesqHis2( @nHistor ) When; 
     Mensagem( "Digite o codigo do historico." ) 
   READ 
   IF nHistor == 900 
      cHistor:= "REF. COMERCIO DE MERCADORIAS  " 
   ELSE 
      cHistor:= HIS->DESCRI 
   ENDIF 
   IF LastKey() <> K_ESC 
      DBSelectAr( _COD_BLOQUETO ) 
      DBSetOrder( 1 ) 
      DBSeek( dDataIni, .T. ) 
      WHILE !EOF() 
          IF VENC__ >= dDataIni .AND. VENC__ <= dDataFim .AND. ( CODH01 == nHistor .OR.; 
                                                                 CODH02 == nHistor .OR.; 
                                                                 CODH03 == nHistor .OR.; 
                                                                 CODH04 == nHistor .OR.; 
                                                                 CODH05 == nHistor ) 
             Mensagem( "Procesando a duplicata#" + Duplic + ", aguarde..." ) 
             AAdd( aMatriz, { TIPTIT, DUPLIC, BANCO_, AGENCI, CONTA_, GERAR_, EMISS_, VALOR_, VENC__, DTQUIT, JUROS_, CTAPGT, DESCRI } ) 
             @ 20,79 Say cHistor 
             IF !Empty( DTQUIT ) 
                nSoma1+= Valor_ 
                nSoma4+= Juros_ 
             ELSE 
                nSoma2+= Valor_ 
             ENDIF 
             nSoma3+= Valor_ 
          ENDIF 
          DBSkip() 
      ENDDO 
 
      IF nDevice == 1 
         AAdd( aMatriz, { "ÄÄÄ", "QUITADAS  ", 0, 0, 0, 0, Space(8), nSoma1, Space(8), Space(8), nSoma4, 0, "TOTAL" + SPACE( 40 ) } ) 
         AAdd( aMatriz, { "ÄÄÄ", "PENDENTES ", 0, 0, 0, 0, Space(8), nSoma2, Space(8), Space(8), 0, 0, "TOTAL" + SPACE( 40 ) } ) 
         AAdd( aMatriz, { "ÄÄÄ", "TOTAL     ", 0, 0, 0, 0, Space(8), nSoma3, Space(8), Space(8), 0, 0, "TOTAL" + SPACE( 40 ) } ) 
         vpbox(0,0,22,79,"Bloquetos de Cobranca",COR[20],.T.,.T.,COR[19]) 
         @ 22,33 Say " Historico: " + cHistor + "    " 
         @ 01,45 Say "Periodo de " + DTOC( dDataIni ) + " ate " + DTOC( dDataFim ) + "." 
         SetColor( "W+/BG" ) 
         @ 02,01 Say "Tipo Duplicata bco Agc Cta Gr Emissao  Vlr. Total  Vencimen Dt.Quit.  Juros    Conta " 
         SetColor( "W+/N" ) 
         oTAB:=tbrowsenew(03,01,21,78) 
         oTAB:addcolumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 1 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 2 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 3 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 4 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 5 ], 3, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 6 ], 2, 0 ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 7 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 8 ], "@e 9999,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 9 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| aMatriz[ nRow ][ 10 ] })) 
         oTab:addColumn(tbcolumnnew(,{|| Tran( aMatriz[ nRow ][ 11 ], "@e 99,999.99" ) })) 
         oTab:addColumn(tbcolumnnew(,{|| StrZero( aMatriz[ nRow ][ 12 ], 3, 0 ) })) 
         oTAB:AUTOLITE:=.f. 
         oTAB:GOTOPBLOCK :={|| nROW:=1} 
         oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aMatriz )} 
         oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aMatriz, @nROW ) } 
         oTAB:dehilite() 
         whil .t. 
            oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,12},{2,1}) 
            whil nextkey()==0 .and. ! oTAB:stabilize() 
            end 
            @ 01,01 Say aMatriz[ nRow ][ 13 ] 
            nTecla:=inkey(0) 
            if nTecla==K_ESC   ;exit   ;endif 
            do case 
               case nTecla==K_UP         ;oTAB:up() 
               case nTecla==K_DOWN       ;oTAB:down() 
               case nTecla==K_LEFT       ;oTAB:up() 
               case nTecla==K_RIGHT      ;oTAB:down() 
               case nTecla==K_PGUP       ;oTAB:pageup() 
               case nTecla==K_CTRL_PGUP  ;oTAB:gotop() 
               case nTecla==K_PGDN       ;oTAB:pagedown() 
               case nTecla==K_CTRL_PGDN  ;oTAB:gobottom() 
               otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent() 
           oTAB:stabilize() 
         enddo 
      ENDIF 
   ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ BLOQUETOS 
³ Finalidade  ³ Modulo responsavbel pela emissao de bloquetos 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
STATIC FUNCTION Bloquetos 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      oVer, Tecla 
DBSelectAr( _COD_BLOQUETO ) 
IF !Used() 
   IF !Abregrupo( "BLOQUETO" ) 
      Return Nil 
   ENDIF 
ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
SetColor(COR[16]) 
GeraDOCAutomatico() 
VPBox( 1, 1, 10, 77, "Display de Bloquetos", _COR_GET_BOX ) 
setcursor(0) 
DBSetOrder( 2 ) 
setcolor( _COR_BROWSE ) 
WHILE !EOF() 
   Mensagem( "Buscando duplicata " + StrZero( SEQUE_, 4, 0 ) + " Aguarde..." ) 
   IF Marca_== "+" 
      EXIT 
   ENDIF 
   DBSkip() 
ENDDO 
VPBox( 10, 1, 21, 77, "Relacao de Bloquetos", _COR_BROWSE ) 
Mensagem( "[INS]Novo [ENTER]Altera [DEL]Apaga [ESP]Quita [TAB]Imprime") 
ajuda("[+]Marca/Desmarca [BackSpace]DesmarcaAcima [F2][F3]Ordem [A..Z]Pesquisa ["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
oVER:=tbrowsedb( 11, 02, 20, 76 ) 
oVER:addcolumn(tbcolumnnew(,{|| DTOC( VENC__ ) + " " + StrZero( CODCLI, 6, 0 ) + " " + DESCRI + " " + Tran( VALOR_, "@E 9999,999.99" ) + IF( EMPTY( DTQUIT ), " " + MARCA_, " Q" ) })) 
oVER:AUTOLITE:=.f. 
oVER:dehilite() 
whil .t. 
   oVER:colorrect({oVER:ROWPOS,1,oVER:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oVER:stabilize() 
   enddo 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,03 Say "Duplicata......: " + DOCUM_ 
   @ 03,03 Say "Codigo.........: " + StrZero( CODCLI, 6, 0 ) 
   @ 04,03 Say "Nome Cliente...: " + DESCRI 
   @ 05,03 Say "Emissao........: " + DTOC( EMISS_ ) 
   @ 06,03 Say "Vencimento.....: " + DTOC( VENC__ ) 
   @ 07,03 Say "Valor Total....: " + Tran( VALOR_, "@E 999,999,999.99" ) 
   @ 08,03 Say "Tipo...........: " + IF( GERAR_ <> 0, "DOC.PROGRAMADO     ",; 
                                                      "NORMAL             " ) +; 
                                     IF( MANUAL <> 0, "<Lancamento Manual>     ", "<Lancamento Autom tico> " ) +; 
                                     IF( !Empty( Duplic ), "D:" + Duplic, Space( 12 ) ) 
   SetColor( _COR_BROWSE ) 
   TECLA:=inkey(0) 
   If TECLA=K_ESC 
      exit 
   EndIf 
   do case 
      case Chr( TECLA ) == "+" 
           IF !EMPTY( DTQUIT ) 
              QuitaDoc( oVer ) 
              oVer:Down() 
           ELSE 
              IF RLock() 
                 IF Marca_ == "E" 
                    Replace MARCA_ With "+" 
                 ELSE 
                    Replace MARCA_ With IF( EMPTY( MARCA_ ), "+", " " ) 
                 ENDIF 
              ENDIF 
              DBUnlockAll() 
              oVer:down() 
           ENDIF 
      case TECLA==K_UP         ;oVER:up() 
      case TECLA==K_LEFT       ;oVER:up() 
      case TECLA==K_RIGHT      ;oVER:down() 
      case TECLA==K_DOWN       ;oVER:down() 
      case TECLA==K_PGUP       ;oVER:pageup() 
      case TECLA==K_PGDN       ;oVER:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oVER:gotop() 
      case TECLA==K_CTRL_PGDN  ;oVER:gobottom() 
      case TECLA==K_INS        ;IncluiDOC( oVer ) 
      case TECLA==K_DEL        ;Exclui( oVer ) 
      case TECLA==K_ENTER      ;AlteraDOC( oVer ) 
      case TECLA==K_SPACE      ;QuitaDOC( oVer ) 
      case TECLA==K_TAB        ;ImpDoc( oVer ) 
      case TECLA==K_BS 
           nRegistro:= RECNO() 
           cTelaRes:= ScreenSave( 20, 0, 24, 79 ) 
           WHILE !BOF() 
              Mensagem( "Buscando duplicata " + StrZero( SEQUE_, 4, 0 ) + ", aguarde..." ) 
              IF Marca_== " " 
                 EXIT 
              ELSE 
                 IF NetRLock() 
                    Replace MARCA_ With Space( 1 ) 
                 ENDIF 
              ENDIF 
              DBSkip( -1 ) 
           ENDDO 
           ScreenRest( cTelaRes ) 
           DBGoTo( nRegistro ) 
           oVer:RefreshAll() 
           WHILE !oVer:Stabilize() 
           ENDDO 
      case DBPesquisa( TECLA, oVer ) 
      case TECLA==K_F2         ;DBMudaOrdem( 2, oVer ) 
      case TECLA==K_F3         ;DBMudaOrdem( 1, oVer ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oVER:refreshcurrent() 
   oVER:stabilize() 
enddo 
dbunlockall() 
FechaArquivos() 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return nil 
 
STATIC FUNCTION BloquetosProg 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      oVer, Tecla 
 
DBSelectAr( _COD_BLOPROG ) 
IF !Used() 
   IF !Abregrupo( "BLOQUETO" ) 
      Return Nil 
   ENDIF 
ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
SetColor(COR[16]) 
VPBox( 1, 1, 10, 77, "Display de Bloquetos Programados", _COR_GET_BOX ) 
setcursor(0) 
setcolor( _COR_BROWSE ) 
VPBox( 10, 1, 20, 77, "Relacao de Bloquetos Programados", _COR_BROWSE ) 
Mensagem( "[INS]Novo [ENTER]Altera [DEL]Apaga [ESC]Finaliza.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
oVER:=tbrowsedb( 11, 02, 19, 76 ) 
oVER:addcolumn(tbcolumnnew(,{|| DTOC( VENC__ ) + " " + StrZero( CODCLI, 6, 0 ) + " " + DESCRI + " " + Tran( VALOR_, "@E 99,999,999.99" ) })) 
oVER:AUTOLITE:=.f. 
oVER:dehilite() 
whil .t. 
   oVER:colorrect({oVER:ROWPOS,1,oVER:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oVER:stabilize() 
   enddo 
   SetColor( _COR_GET_EDICAO ) 
   @ 02,03 Say "Duplicata......: " + DOCUM_ 
   @ 03,03 Say "Codigo.........: " + StrZero( CODCLI, 6, 0 ) 
   @ 04,03 Say "Nome Cliente...: " + DESCRI 
   @ 05,03 Say "Emissao........: " + DTOC( EMISS_ ) 
   @ 06,03 Say "Vencimento.....: " + DTOC( VENC__ ) 
   @ 07,03 Say "Valor Total....: " + Tran( VALOR_, "@E 999,999,999.99" ) 
   SetColor( _COR_BROWSE ) 
   TECLA:=inkey(0) 
   If TECLA=K_ESC 
      exit 
   EndIf 
   do case 
      case TECLA==K_UP         ;oVER:up() 
      case TECLA==K_LEFT       ;oVER:up() 
      case TECLA==K_RIGHT      ;oVER:down() 
      case TECLA==K_DOWN       ;oVER:down() 
      case TECLA==K_PGUP       ;oVER:pageup() 
      case TECLA==K_PGDN       ;oVER:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oVER:gotop() 
      case TECLA==K_CTRL_PGDN  ;oVER:gobottom() 
      case TECLA==K_INS        ;IncluiDOCProg( oVer ) 
      case TECLA==K_DEL        ;Exclui( oVer ) 
      case TECLA==K_ENTER      ;AlteraDOCProg( oVer ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oVER:refreshcurrent() 
   oVER:stabilize() 
enddo 
dbunlockall() 
FechaArquivos() 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return nil 
 
STATIC FUNCTION QuitaDOC( oVer ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCtaPgt:= Conta_, nJuros_:= 0, dDtQuit:= Date(), nRegistro:= 0,; 
      cCheque:= Space( 10 ), cMarca_ 
    SetCursor( 1 ) 
    IF !Empty( DTQUIT ) 
       VPBox( 09,10,17,70, "Bloqueto Quitado" ) 
       @ 10,11 Say "Data de Emissao.....: ["+DTOC( Emiss_ )+"]" 
       @ 11,11 Say "Data de Vencimento..: ["+DTOC( Venc__ )+"]" 
       @ 12,11 Say "Valor...............: ["+Tran( Valor_, "@E 999,999,999.99" ) + "]" 
       @ 13,11 Say Repl( "Ä", 58 ) 
       @ 14,11 Say "Juros...............: ["+Tran( Juros_, "@E 999,999,999.99" ) + "]" 
       @ 15,11 Say "Data Quitacao.......: ["+DTOC( DtQuit )+"]" 
       @ 16,11 Say "Conta...............: ["+StrZero( CtaPgt, 3, 0 ) +"]" 
       Mensagem( "Pressione [ENTER]Estornar ou [Qualquer Tecla] para continuar." ) 
       Inkey(0) 
       IF LastKey() == K_ENTER 
          IF Confirma( 00,00, "Deseja desfazer esta quitacao?", ,"N" ) 
             IF NetRLock() 
                REPLACE JUROS_ With 0,; 
                        DTQuit With CTOD( "  /  /  " ),; 
                        CtaPgt With 0,; 
                        Marca_ With "E",; 
                        Cheque With Space( 10 ) 
             ENDIF 
          ENDIF 
          DBUnlockAll() 
       ENDIF 
    ELSE 
       VPBox( 09,10,18,70, "Quitacao de Bloqueto" ) 
       @ 10,11 Say "Data de Emissao.....: ["+DTOC( Emiss_ )+"]" 
       @ 11,11 Say "Data de Vencimento..: ["+DTOC( Venc__ )+"]" 
       @ 12,11 Say "Valor...............: ["+Tran( Valor_, "@E 999,999,999.99" ) + "]" 
       @ 13,11 Say Repl( "Ä", 58 ) 
       @ 14,11 Say "Juros...............:" Get nJuros_ Pict "@E 999,999,999.99" 
       @ 15,11 Say "Data Quitacao.......:" Get dDtQuit 
       @ 16,11 Say "Conta...............:" Get nCtaPgt Pict "999" 
       @ 17,11 Say "Cheque No...........:" Get cCheque Pict "@!" 
       READ 
       cMarca_:= MARCA_ 
       IF LastKey() <> K_ESC 
          IF NetRLock() 
             REPLACE JUROS_ With nJuros_,; 
                     DTQuit With dDtQuit,; 
                     CtaPgt With nCtaPgt,; 
                     Cheque With cCheque,; 
                     Marca_ With " " 
             IF !Empty( Duplic ) 
                QuitaDuplicata( Duplic, Venc__, DtQuit, Cheque  ) 
             ENDIF 
          ENDIF 
          DBUnlockAll() 
          nRegistro:= Recno() 
          IF cMarca_ == "+" 
             IF Confirma( 00,00, "Deseja quitar todos os bloquetos marcados?", ,"N" ) 
                DBGoTop() 
                WHILE !EOF() 
                    IF MARCA_ == "+" 
                       IF NetRLock() 
                          Replace JUROS_ With nJuros_,; 
                                  DTQuit With dDtQuit,; 
                                  CtaPgt With nCtaPgt,; 
                                  Marca_ With " " 
                          IF !Empty( Duplic ) 
                              QuitaDuplicata( Duplic, Venc__, DtQuit, Cheque  ) 
                          ENDIF 
                       ENDIF 
                       DBUnlockAll() 
                    ENDIF 
                    DBSkip() 
                ENDDO 
             ENDIF 
          ENDIF 
          dbGoto( nRegistro ) 
       ENDIF 
    ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oVer:RefreshAll() 
WHILE !oVer:Stabilize() 
ENDDO 
Return Nil 
 
 
 
 
STATIC FUNCTION IncluiDOC( oVer ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      CTIPTIT:= Space(03), CDOCUM_:= Space(10), NBANCO_:= 0, NAGENCI:= 0,; 
      NCONTA_:= 0, cCtaNum:= Space( 20 ), NCODCLI:= 0, CDESCRI:= Space(45), DULTEMI:= CTOD( "  /  /  " ),; 
      cDesAge:= Space( 20 ), cDesBco:= Space( 20 ),; 
      DULTVCT:= CTOD( "  /  /  " ), NGERAR_:= 0, NVALOR_:= 0, NREAJUS:= 0,; 
      NCODH01:= 0, CHIST01:= Space(30), NVLR_01:= 0, NCODH02:= 0, CHIST02:= Space(30),; 
      NVLR_02:= 0, NCODH03:= 0, CHIST03:= Space(30), NVLR_03:= 0, NCODH04:= 0,; 
      CHIST04:= Space(30), NVLR_04:= 0, NCODH05:= 0, CHIST05:= Space(30), NVLR_05:= 0,; 
      NCODH06:= 0, CHIST06:= Space(30), NVLR_06:= 0,; 
      NCODH07:= 0, CHIST07:= Space(30), NVLR_07:= 0,; 
      NCODH08:= 0, CHIST08:= Space(30), NVLR_08:= 0,; 
      NCODH09:= 0, CHIST09:= Space(30), NVLR_09:= 0,; 
      NCODH10:= 0, CHIST10:= Space(30), NVLR_10:= 0,; 
      DEMISS_:= CTOD( "  /  /  " ), DVENC__:= CTOD( "  /  /  " ), CDUPLIC:= Space(10),; 
      CNOSSON:= Space(25), CCODCED:= Space(20), DDTQUIT:= CTOD( "  /  /  " ),; 
      CCHEQUE:= Space(10), CLOCAL_:= Space(25), NLOCPGT:= 0, cFavor_:= Space( 20 ) 
 
VPBox( 1, 1, 10, 77, "Inclusao de Bloquetos" ) 
setcursor(1) 
setcolor( _COR_BROWSE ) 
@ 03,03 Say "Tipo de Titulo:" Get cTipTit Pict "!!!" When; 
  Mensagem( "Digite o tipo de Titulo (Ex. DOC)." ) 
@ 03,27 Say "Referente Documento:" Get cDocum_ When; 
  Mensagem( "Digite o documento que se refere este DOC." ) 
@ 03,62 Say "Tipo: [Manual]" 
VPBox( 04, 02, 08, 76, , ,.F.,.F. ) 
@ 05,03 Say "Cliente:" Get nCodCli Pict "@E 999999" Valid PesqCli( @nCodCli ) When; 
  Mensagem( "Digite o codigo do cliente ou [99999] para ver na lista." ) 
@ 06,03 Say "Emissao:" Get dEmiss_ When; 
  Mensagem( "Digite a data de emissao deste DOC." ) 
@ 07,03 Say "Vencto.:" Get dVenc__ When; 
  Mensagem( "Digite a data de vencimento deste DOC." ) 
@ 06,36 Say "Valor Total............: [*************]" 
@ 07,36 Say "Programacao deste DOC..:" Get nGerar_ Pict "@E 99" Valid PesqGerar( @nGerar_ ) When; 
  Mensagem( "Digite conforme a tabela." ) 
VPBox( 10, 1, 21, 77, "Relacao de Historicos", _COR_BROWSE ) 
 
@ 12,02 Get nCODH01 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 1 ) 
@ 12,08 Get CHIST01 
@ 12,41 Get NVLR_01 Pict "@E 9,999,999.99" 
 
@ 14,02 Get nCODH02 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 2 ) 
@ 14,08 Get CHIST02 
@ 14,41 Get NVLR_02 Pict "@E 9,999,999.99" 
 
@ 16,02 Get nCODH03 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 3 ) 
@ 16,08 Get CHIST03 
@ 16,41 Get NVLR_03 Pict "@E 9,999,999.99" 
 
@ 18,02 Get nCODH04 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 4 ) 
@ 18,08 Get CHIST04 
@ 18,41 Get NVLR_04 Pict "@E 9,999,999.99" 
 
@ 20,02 Get nCODH05 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 5 ) 
@ 20,08 Get CHIST05 
@ 20,41 Get NVLR_05 Pict "@E 9,999,999.99" 
 
@ 14,60 Say "Conta.:" Get nConta_ Pict "999" 
 
READ 
 
IF LastKey() == K_ESC 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
 
nValor_:= nVlr_01 + nVlr_02 + nVlr_03 + nVlr_04 + nVlr_05 
 
DBSelectAr( _COD_CLIENTE ) 
IF DBSeek( nCodCli ) 
   cDescri:= Descri 
ENDIF 
 
DBSelectAr( _COD_CONTA ) 
IF DBSeek( nConta_ ) 
   nAgenci:= AGENC_ 
   cFavor_:= DESCRI 
   cCtaNum:= CONTA_ 
   cCodCed:= CodCed 
ENDIF 
DBSelectAr( _COD_AGENCIA ) 
IF DBSeek( nAgenci ) 
   nBanco_:= BANCO_ 
   cDesAge:= DESCRI 
ENDIF 
DBSelectAr( _COD_BANCO ) 
IF DBSeek( nBanco_ ) 
   cDesBco:= DESCRI 
ENDIF 
 
VPBOX( 11, 20, 16, 70, " Conta Corrente ", "15/02", , ,"00/15" ) 
SetColor( "15/02" ) 
@ 12,21 Say "No........: [" + cCtaNum + "]" 
@ 13,21 Say "Agencia...: [" + StrZero( nAgenci, 3, 0 ) + "][" + Left( cDesAge, 30 ) + "]" 
@ 14,21 Say "Banco.....: [" + StrZero( nBanco_, 3, 0 ) + "][" + Left( cDesBco, 30 ) + "]" 
@ 15,21 Say "Favorecido: [" + Left( cFavor_, 30 ) + "]" 
Inkey( 0 ) 
IF Confirma( 0,0, "Gravar?", , "S" ) 
   DBSelectAr( _COD_BLOQUETO ) 
   DBAppend() 
   Replace tipTit With cTipTit,; 
           Docum_ With cDocum_,; 
           Banco_ With nBanco_,; 
           Agenci With nAgenci,; 
           Conta_ With nConta_,; 
           CodCli With nCodCli,; 
           Descri With cDescri,; 
           Ultemi With dEmiss_,; 
           UltVct With dVenc__,; 
           Gerar_ With nGerar_,; 
           Valor_ With nValor_,; 
           Reajus With nReajus,; 
           Emiss_ With dEmiss_,; 
           Venc__ With dVenc__,; 
           CodCed With cCodCed,; 
           Local_ With cLocal_,; 
           Hist01 With cHist01,; 
           CodH01 With nCodH01,; 
           Vlr_01 With nVlr_01,; 
           Hist02 With cHist02,; 
           CodH02 With nCodH02,; 
           Vlr_02 With nVlr_02,; 
           Hist03 With cHist03,; 
           CodH03 With nCodH03,; 
           Vlr_03 With nVlr_03,; 
           Hist04 With cHist04,; 
           CodH04 With nCodH04,; 
           Vlr_04 With nVlr_04,; 
           Hist05 With cHist05,; 
           CodH05 With nCodH05,; 
           Vlr_05 With nVlr_05,; 
           Manual With 1 
     IF Gerar_ <> 0 
        IF Confirma( 0, 0, "Gravar Programacao deste DOC?", ,"S" ) 
           DBSelectAr( _COD_BLOPROG ) 
           DBAppend() 
           Replace tipTit With cTipTit,; 
                   Docum_ With cDocum_,; 
                   Banco_ With nBanco_,; 
                   Agenci With nAgenci,; 
                   Conta_ With nConta_,; 
                   CodCli With nCodCli,; 
                   Descri With cDescri,; 
                   Ultemi With dEmiss_,; 
                   UltVct With dVenc__,; 
                   Gerar_ With nGerar_,; 
                   Valor_ With nValor_,; 
                   Reajus With nReajus,; 
                   Emiss_ With dEmiss_,; 
                   Venc__ With dVenc__,; 
                   CodCed With cCodCed,; 
                   Local_ With cLocal_,; 
                   Hist01 With cHist01,; 
                   CodH01 With nCodH01,; 
                   Vlr_01 With nVlr_01,; 
                   Hist02 With cHist02,; 
                   CodH02 With nCodH02,; 
                   Vlr_02 With nVlr_02,; 
                   Hist03 With cHist03,; 
                   CodH03 With nCodH03,; 
                   Vlr_03 With nVlr_03,; 
                   Hist04 With cHist04,; 
                   CodH04 With nCodH04,; 
                   Vlr_04 With nVlr_04,; 
                   Hist05 With cHist05,; 
                   CodH05 With nCodH05,; 
                   Vlr_05 With nVlr_05 
        ENDIF 
     ENDIF 
ENDIF 
DBSelectar( _COD_BLOQUETO ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oVER:refreshAll() 
WHILE !oVER:stabilize() 
ENDDO 
Return Nil 
 
STATIC FUNCTION QuitaDuplicata( Duplic, dVenc__, DtQuit, Cheque  ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local nNotaFiscal:= Val( Left( Duplic, 8 ) ), nMes:= Val( Right( Duplic, 2 ) ) 
DBSelectAr( _COD_DUPAUX ) 
DBSetOrder( 1 ) 
IF DBSeek( nNotaFiscal ) 
   IF VENC__ == dVenc__ .AND.; 
      Empty( DTQT__ ) .AND.; 
      Month( VENC__ ) == nMes 
      IF NetRLock() 
         REPLACE DTQT__ With DtQuit,; 
                 CHEQ__ With Cheque,; 
                 QUIT__ With "S" 
      ENDIF 
      BaixaReceber( Nil, .T. ) 
   ELSE 
      Mensagem( "Duplicata " + Duplic + " nao pode ser quitada. Verifique Contas a receber." ) 
      Pausa() 
   ENDIF 
ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
Return Nil 
 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ALTERADOC 
³ Finalidade  ³ Alteracao dos DOCs de cobranca 
³ Parametros  ³ NIL 
³ Retorno     ³ NIL 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ NIL 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
STATIC FUNCTION AlteraDOC( oVer ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local CTIPTIT:= TipTit, CDOCUM_:= Docum_, NBANCO_:= Banco_, NAGENCI:= Agenci,; 
      NCONTA_:= Conta_, cCtaNum:= Space( 20 ), NCODCLI:= CodCli,; 
      CDESCRI:= Descri, DULTEMI:= UltEmi, cDesAge:= Space( 20 ),; 
      cDesBco:= Space( 20 ), DULTVCT:= UltVct, NGERAR_:= Gerar_,; 
      NVALOR_:= Valor_, NREAJUS:= Reajus,; 
      NCODH01:= CodH01, CHIST01:= Hist01, NVLR_01:= Vlr_01,; 
      NCODH02:= CodH02, CHIST02:= Hist02, NVLR_02:= Vlr_02,; 
      NCODH03:= CodH03, CHIST03:= Hist03, NVLR_03:= Vlr_03,; 
      NCODH04:= CodH04, CHIST04:= Hist04, NVLR_04:= Vlr_04,; 
      NCODH05:= CodH05, CHIST05:= Hist05, NVLR_05:= Vlr_05,; 
      DEMISS_:= Emiss_, DVENC__:= Venc__, CDUPLIC:= Duplic,; 
      CNOSSON:= Nosson, CCODCED:= CodCed, DDTQUIT:= DTQuit,; 
      CCHEQUE:= Cheque, CLOCAL_:= Local_, NLOCPGT:= LocPgt,; 
      cFavor_:= Space( 30 ) 
 
IF !Empty( DTQUIT ) 
   SetColor( _COR_GET_BOX ) 
   @ 03,03 Say "Tipo de Titulo: [" + cTipTit + "]" 
   @ 03,27 Say "Referente Documento: [" + cDocum_ + "]" 
   @ 03,62 Say "Tipo: [Manual]" 
   VPBox( 04, 02, 08, 76, , _COR_GET_BOX,.F.,.F. ) 
   @ 05,03 Say "Cliente: [" + StrZero( nCodCli, 6, 0 ) + "]" 
   @ 06,03 Say "Emissao: [" + DTOC( dEmiss_ ) + "]" 
   @ 07,03 Say "Vencto.: [" + DTOC( dVenc__ ) + "]" 
   @ 06,36 Say "Valor Total............: [" + Tran( Valor_, "@E 99,999,999.99" ) + "]" 
   VPBox( 10, 1, 21, 77, "Relacao de Historicos", _COR_BROWSE ) 
   @ 12,02 Say nCODH01 Pict "999" 
   @ 12,08 Say CHIST01 
   @ 12,41 Say NVLR_01 Pict "@E 9,999,999.99" 
   @ 14,02 Say nCODH02 Pict "999" 
   @ 14,08 Say CHIST02 
   @ 14,41 Say NVLR_02 Pict "@E 9,999,999.99" 
   @ 16,02 Say nCODH03 Pict "999" 
   @ 16,08 Say CHIST03 
   @ 16,41 Say NVLR_03 Pict "@E 9,999,999.99" 
   @ 18,02 Say nCODH04 Pict "999" 
   @ 18,08 Say CHIST04 
   @ 18,41 Say NVLR_04 Pict "@E 9,999,999.99" 
   @ 20,02 Say nCODH05 Pict "999" 
   @ 20,08 Say CHIST05 
   @ 20,41 Say NVLR_05 Pict "@E 9,999,999.99" 
   @ 14,60 Say "Conta.: [" + StrZero( nConta_, 3, 0 ) + "]" 
   Mensagem( "Pressione [QUALQUER TECLA] para continuar..." ) 
   Inkey(5) 
 
   DBSelectAr( _COD_CONTA ) 
   IF DBSeek( nConta_ ) 
      nAgenci:= AGENC_ 
      cFavor_:= DESCRI 
      cCtaNum:= CONTA_ 
      cCodCed:= CodCed 
   ENDIF 
   DBSelectAr( _COD_AGENCIA ) 
   IF DBSeek( nAgenci ) 
      nBanco_:= BANCO_ 
      cDesAge:= DESCRI 
   ENDIF 
   DBSelectAr( _COD_BANCO ) 
   IF DBSeek( nBanco_ ) 
      cDesBco:= DESCRI 
   ENDIF 
 
   VPBOX( 11, 20, 16, 70, " Conta Corrente ", _COR_GET_BOX, , ,"00/15" ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 12,21 Say "No........: [" + cCtaNum + "]" 
   @ 13,21 Say "Agencia...: [" + StrZero( nAgenci, 3, 0 ) + "][" + Left( cDesAge, 30 ) + "]" 
   @ 14,21 Say "Banco.....: [" + StrZero( nBanco_, 3, 0 ) + "][" + Left( cDesBco, 30 ) + "]" 
   @ 15,21 Say "Favorecido: [" + Left( cFavor_, 30 ) + "]" 
   Mensagem( "Pressione [QUALQUER TECLA] para continuar..." ) 
   Inkey(0) 
 
   DBSelectAr( _COD_BLOQUETO ) 
 
ELSE 
   VPBox( 1, 1, 10, 77, "Alteracao de Bloquetos", _COR_GET_BOX ) 
   setcursor(1) 
   setcolor( _COR_GET_EDICAO ) 
   @ 03,03 Say "Tipo de Titulo:" Get cTipTit Pict "!!!" When; 
     Mensagem( "Digite o tipo de Titulo (Ex. DOC)." ) 
   @ 03,27 Say "Referente Documento:" Get cDocum_ When; 
     Mensagem( "Digite o documento que se refere este DOC." ) 
   @ 03,62 Say "Tipo: [Manual]" 
   VPBox( 04, 02, 08, 76, , _COR_GET_BOX ,.F.,.F. ) 
   @ 05,03 Say "Cliente:" Get nCodCli Pict "@E 999999" Valid PesqCli( @nCodCli ) When; 
     Mensagem( "Digite o codigo do cliente ou [99999] para ver na lista." ) 
   @ 06,03 Say "Emissao:" Get dEmiss_ When; 
     Mensagem( "Digite a data de emissao deste DOC." ) 
   @ 07,03 Say "Vencto.:" Get dVenc__ When; 
     Mensagem( "Digite a data de vencimento deste DOC." ) 
   @ 06,36 Say "Valor Total............: [*************]" 
 
   SetColor( _COR_BROWSE ) 
   VPBox( 10, 1, 21, 77, "Relacao de Historicos", _COR_BROWSE ) 
 
   @ 12,02 Get nCODH01 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                                 @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                                 @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 1 ) 
   @ 12,08 Get CHIST01 
   @ 12,41 Get NVLR_01 Pict "@E 9,999,999.99" 
 
   @ 14,02 Get nCODH02 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                                 @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                                 @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 2 ) 
   @ 14,08 Get CHIST02 
   @ 14,41 Get NVLR_02 Pict "@E 9,999,999.99" 
 
   @ 16,02 Get nCODH03 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                                 @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                                 @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 3 ) 
   @ 16,08 Get CHIST03 
   @ 16,41 Get NVLR_03 Pict "@E 9,999,999.99" 
 
   @ 18,02 Get nCODH04 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                                 @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                                 @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 4 ) 
   @ 18,08 Get CHIST04 
   @ 18,41 Get NVLR_04 Pict "@E 9,999,999.99" 
 
   @ 20,02 Get nCODH05 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                                 @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                                 @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 5 ) 
   @ 20,08 Get CHIST05 
   @ 20,41 Get NVLR_05 Pict "@E 9,999,999.99" 
 
   @ 14,60 Say "Conta.:" Get nConta_ Pict "999" 
 
   READ 
 
   IF LastKey() == K_ESC 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
 
   nValor_:= nVlr_01 + nVlr_02 + nVlr_03 + nVlr_04 + nVlr_05 
 
   DBSelectAr( _COD_CLIENTE ) 
   IF DBSeek( nCodCli ) 
      cDescri:= Descri 
   ENDIF 
 
   DBSelectAr( _COD_CONTA ) 
   IF DBSeek( nConta_ ) 
      nAgenci:= AGENC_ 
      cFavor_:= DESCRI 
      cCtaNum:= CONTA_ 
      cCodCed:= CodCed 
   ENDIF 
   DBSelectAr( _COD_AGENCIA ) 
   IF DBSeek( nAgenci ) 
      nBanco_:= BANCO_ 
      cDesAge:= DESCRI 
   ENDIF 
   DBSelectAr( _COD_BANCO ) 
   IF DBSeek( nBanco_ ) 
      cDesBco:= DESCRI 
   ENDIF 
 
   VPBox( 11, 20, 16, 70, " Conta Corrente ", _COR_GET_BOX, , ,"00/15" ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 12,21 Say "No........: [" + cCtaNum + "]" 
   @ 13,21 Say "Agencia...: [" + StrZero( nAgenci, 3, 0 ) + "][" + Left( cDesAge, 30 ) + "]" 
   @ 14,21 Say "Banco.....: [" + StrZero( nBanco_, 3, 0 ) + "][" + Left( cDesBco, 30 ) + "]" 
   @ 15,21 Say "Favorecido: [" + Left( cFavor_, 30 ) + "]" 
   Inkey( 0 ) 
   IF Confirma( 0,0, "Gravar?", ,"S" ) 
      DBSelectAr( _COD_BLOQUETO ) 
      IF RLock() 
         Repl tipTit With cTipTit,; 
              Docum_ With cDocum_,; 
              Banco_ With nBanco_,; 
              Agenci With nAgenci,; 
              Conta_ With nConta_,; 
              CodCli With nCodCli,; 
              Descri With cDescri,; 
              Ultemi With dEmiss_,; 
              UltVct With dVenc__,; 
              Gerar_ With nGerar_,; 
              Valor_ With nValor_,; 
              Reajus With nReajus,; 
              Emiss_ With dEmiss_,; 
              Venc__ With dVenc__,; 
              CodCed With cCodCed,; 
              Local_ With cLocal_,; 
              Hist01 With cHist01,; 
              CodH01 With nCodH01,; 
              Vlr_01 With nVlr_01,; 
              Hist02 With cHist02,; 
              CodH02 With nCodH02,; 
              Vlr_02 With nVlr_02,; 
              Hist03 With cHist03,; 
              CodH03 With nCodH03,; 
              Vlr_03 With nVlr_03,; 
              Hist04 With cHist04,; 
              CodH04 With nCodH04,; 
              Vlr_04 With nVlr_04,; 
              Hist05 With cHist05,; 
              CodH05 With nCodH05,; 
              Vlr_05 With nVlr_05 
        ENDIF 
        DBUnlockALL() 
   ENDIF 
ENDIF 
DBSelectar( _COD_BLOQUETO ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oVER:refreshAll() 
WHILE !oVER:stabilize() 
ENDDO 
Return Nil 
 
STATIC FUNCTION GerarDocDuplicata( oVer ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nConta_:= 0, nHistor:= 900, cHistor:= "REF. OMERCIO DE MERCADORIAS",; 
      cDocum_:= Space( 10 ), cDuplic,; 
      dData1_:= CTOD( "01" + SubStr( DTOC( Date() ), 3 ) ),; 
      dData2_:= Date(), nBanco_:= 0, nAgenci:= 0, nSoma:= 0, nValorL:= 999999999.99,; 
      nDocs:= 0, lGerado:= .F., nSeque_:= 0 
 
 DBSelectAr( _COD_BLOQUETO ) 
 DBSetOrder( 2 ) 
 VPObsBox( .T., 12, 45,  "Bloquetos Automaticos",; 
                       { " ** Esta rotina gera DOCs ",; 
                         " automaticamente com base ",; 
                         " nas contas que estiverem ",; 
                         " em aberto no  modulo  de ",; 
                         " contas a receber         " } ) 
 Mensagem( "Pressione [ENTER] para continuar..." ) 
 Pausa() 
 DBSelectAr( _COD_BLOQUETO ) 
 DBSetOrder( 3 ) 
 DBGoBottom() 
 nSeque_:= SEQUE_ + 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
 UserScreen() 
 VPBox( 01, 02, 20, 77, "Geracao de Bloquetos a partir de duplicatas" ) 
 VPBox( 10, 02, 20, 77, "Display de execucao" ) 
 dData1_:= DATE() + 1 
 dData2_:= DATE() + 365 
 @ 02,03 Say "Periodo (Vencimentos) Inicial:" Get dData1_ 
 @ 03,03 Say "                        Final:" Get dData2_ 
 @ 04,03 Say "Valor Limite.................:" Get nValorL Pict "@R 999,999,999.99" 
 @ 05,03 Say "Conta Corrente...............:" Get nConta_ Pict "999" Valid PesqCtaCorrente( @nConta_ ) 
 @ 06,03 Say "No. Documento................:" Get cDocum_ Pict "@!" 
 @ 07,03 Say "Tipo de geracao..............: [Autom tica]" 
 @ 08,03 Say "Hist¢rico....................:" Get nHistor Pict "999" Valid PesqHistorico( nHistor, @cHistor ) 
 @ 09,03 Say "Sequencia/Duplicata..........:" Get nSeque_ Pict "99999999" 
 READ 
 DBGoBottom() 
 WHILE !BOF() 
     IF Marca_ == "+" 
        IF NetRLock() 
           Replace MARCA_ With Space( 1 ) 
        ENDIF 
     ENDIF 
     DBSkip(-1) 
 ENDDO 
 SWGravar( 600 ) 
 IF LastKey() <> K_ESC 
    IF Confirma( 00,00, "Confirma a geracao autom tica de bloquetos?", , "N" ) 
       DBSelectAr( _COD_DUPAUX ) 
       DBGoTop() 
       WHILE !EOF() 
          DBSelectAr( _COD_DUPAUX ) 
          IF Venc__ >= dData1_ .AND. Venc__ <= dData2_ .AND.; 
             EMPTY( DTQT__ ) .AND. !Empty( VLR___ ) .AND.; 
             LOCAL_ == 0 .AND. EMPTY( CHEQ__ ) .AND. NFNULA == SPACE( 1 ) 
             IF !SITU__ == "*" .AND. SEQUE_ == 0 
                DBSelectAr( _COD_AGENCIA ) 
                DBSetOrder( 1 ) 
                DBSeek( CON->AGENC_ ) 
                DBSelectAR( _COD_DUPAUX ) 
                IF NetRLock() 
                   Replace LOCAL_ With AGE->BANCO_,; 
                           SITU__ With "*",; 
                           SEQUE_ With nSeque_ 
                ENDIF 
                nBanco_:= AGE->BANCO_ 
                nAgenci:= CON->AGENC_ 
                DBSelectAr( _COD_BLOQUETO ) 
                DBAppend() 
                IF !NetErr() 
                   lGerado:= .T. 
                   NF_->( DBSetOrder( 1 ) ) 
                   /* Busca o codigo do cliente origin rio, nao matriz */ 
                   IF NF_->( DBSeek( DPA->CODNF_ ) ) 
                      nCodCliente:= NF_->CLIENT 
                   ELSE 
                      nCodCliente:= DPA->CLIENT 
                   ENDIF 
                   Replace TipTit With "DOC",; 
                           Docum_ With cDocum_,; 
                           Banco_ With nBanco_,; 
                           Agenci With nAgenci,; 
                           Conta_ With nConta_,; 
                           CodCli With nCodCliente,; 
                           Descri With DPA->CDESCR,; 
                           Valor_ With DPA->VLR___,; 
                           Emiss_ With DPA->DATAEM,; 
                           Venc__ With DPA->VENC__,; 
                           Hist01 With cHistor,; 
                           CodH01 With nHistor,; 
                           Vlr_01 With DPA->VLR___,; 
                           Duplic With StrZero( DPA->CODNF_, 9, 0 ) + DPA->LETRA_,; 
                           Seque_ With nSeque_,; 
                           Marca_ With "+" 
                ENDIF 
                DBSelectAr( _COD_DUPAUX ) 
                nSeque_:= nSeque_ + 1 
             ENDIF 
          ENDIF 
          IF lGerado 
             @ 06,50 Say "Docs: " + StrZero( ++nDocs, 6, 0 ) 
             @ 07,50 Say "Soma: " + Tran( nSoma+= BLO->Valor_, "@E 999,999,999.99" ) 
             @ 19,03 Say Left( DPA->CDESCR, 30 ) + Tran( DPA->VLR___, "@E 999,999.99" ) 
             Scroll( 11, 03, 19, 76, 1 ) 
             lGerado:= .F. 
          ELSE 
             Mensagem( "Processando a Nota Fiscal Numero " + StrZero( CODNF_, 6, 0 ) + ", aguarde..." ) 
          ENDIF 
          DBSkip() 
          IF nSoma >= nValorL 
             EXIT 
          ENDIF 
       ENDDO 
       Aviso( "Operacao Finalizada!" ) 
       Mensagem( "Pressione [ENTER] para finalizar..." ) 
       Pausa() 
    ENDIF 
 ENDIF 
 SWGravar( 5 ) 
DBSelectAr( _COD_BLOQUETO ) 
DBSetOrder( 1 ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
FUNCTION Pesqhistorico( nCodHis, cHistorico ) 
HIS->( DBSetOrder( 1 ) ) 
HIS->( DBSeek( nCodHis ) ) 
cHistorico:= HIS->DESCRI 
Return .T. 
 
 
STATIC FUNCTION IncluiDOCProg( oVer ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ),; 
      CTIPTIT:= Space(03), CDOCUM_:= Space(10), NBANCO_:= 0, NAGENCI:= 0,; 
      NCONTA_:= 0, cCtaNum:= Space( 20 ), NCODCLI:= 0, CDESCRI:= Space(45), DULTEMI:= CTOD( "  /  /  " ),; 
      cDesAge:= Space( 20 ), cDesBco:= Space( 20 ),; 
      DULTVCT:= CTOD( "  /  /  " ), NGERAR_:= 0, NVALOR_:= 0, NREAJUS:= 0,; 
      NCODH01:= 0, CHIST01:= Space(30), NVLR_01:= 0, NCODH02:= 0, CHIST02:= Space(30),; 
      NVLR_02:= 0, NCODH03:= 0, CHIST03:= Space(30), NVLR_03:= 0, NCODH04:= 0,; 
      CHIST04:= Space(30), NVLR_04:= 0, NCODH05:= 0, CHIST05:= Space(30), NVLR_05:= 0,; 
      NCODH06:= 0, CHIST06:= Space(30), NVLR_06:= 0,; 
      NCODH07:= 0, CHIST07:= Space(30), NVLR_07:= 0,; 
      NCODH08:= 0, CHIST08:= Space(30), NVLR_08:= 0,; 
      NCODH09:= 0, CHIST09:= Space(30), NVLR_09:= 0,; 
      NCODH10:= 0, CHIST10:= Space(30), NVLR_10:= 0,; 
      DEMISS_:= CTOD( "  /  /  " ), DVENC__:= CTOD( "  /  /  " ), CDUPLIC:= Space(10),; 
      CNOSSON:= Space(25), CCODCED:= Space(20), DDTQUIT:= CTOD( "  /  /  " ),; 
      CCHEQUE:= Space(10), CLOCAL_:= Space(25), NLOCPGT:= 0, cFavor_:= Space( 20 ) 
 
VPBox( 1, 1, 10, 77, "Inclusao de Bloquetos" ) 
setcursor(1) 
setcolor( _COR_BROWSE ) 
@ 03,03 Say "Tipo de Titulo:" Get cTipTit Pict "!!!" When; 
  Mensagem( "Digite o tipo de Titulo (Ex. DOC)." ) 
@ 03,27 Say "Referente Documento:" Get cDocum_ When; 
  Mensagem( "Digite o documento que se refere este DOC." ) 
@ 03,62 Say "Tipo: [Manual]" 
VPBox( 04, 02, 08, 76, , ,.F.,.F. ) 
@ 05,03 Say "Cliente:" Get nCodCli Pict "@E 999999" Valid PesqCli( @nCodCli ) When; 
  Mensagem( "Digite o codigo do cliente ou [99999] para ver na lista." ) 
@ 06,03 Say "Emissao:" Get dEmiss_ When; 
  Mensagem( "Digite a data de emissao deste DOC." ) 
@ 07,03 Say "Vencto.:" Get dVenc__ When; 
  Mensagem( "Digite a data de vencimento deste DOC." ) 
@ 06,36 Say "Valor Total............: [*************]" 
@ 07,36 Say "Programacao deste DOC..:" Get nGerar_ Pict "@E 99" Valid PesqGerar( @nGerar_ ) When; 
  Mensagem( "Digite conforme a tabela." ) 
VPBox( 10, 1, 21, 77, "Relacao de Historicos", _COR_BROWSE ) 
 
@ 12,02 Get nCODH01 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 1 ) 
@ 12,08 Get CHIST01 
@ 12,41 Get NVLR_01 Pict "@E 9,999,999.99" 
 
@ 14,02 Get nCODH02 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 2 ) 
@ 14,08 Get CHIST02 
@ 14,41 Get NVLR_02 Pict "@E 9,999,999.99" 
 
@ 16,02 Get nCODH03 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 3 ) 
@ 16,08 Get CHIST03 
@ 16,41 Get NVLR_03 Pict "@E 9,999,999.99" 
 
@ 18,02 Get nCODH04 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 4 ) 
@ 18,08 Get CHIST04 
@ 18,41 Get NVLR_04 Pict "@E 9,999,999.99" 
 
@ 20,02 Get nCODH05 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 5 ) 
@ 20,08 Get CHIST05 
@ 20,41 Get NVLR_05 Pict "@E 9,999,999.99" 
 
@ 14,60 Say "Conta.:" Get nConta_ Pict "999" 
 
READ 
 
nValor_:= nVlr_01 + nVlr_02 + nVlr_03 + nVlr_04 + nVlr_05 
 
DBSelectAr( _COD_CLIENTE ) 
IF DBSeek( nCodCli ) 
   cDescri:= Descri 
ENDIF 
 
DBSelectAr( _COD_CONTA ) 
IF DBSeek( nConta_ ) 
   nAgenci:= AGENC_ 
   cFavor_:= DESCRI 
   cCtaNum:= CONTA_ 
   cCodCed:= CodCed 
ENDIF 
DBSelectAr( _COD_AGENCIA ) 
IF DBSeek( nAgenci ) 
   nBanco_:= BANCO_ 
   cDesAge:= DESCRI 
ENDIF 
DBSelectAr( _COD_BANCO ) 
IF DBSeek( nBanco_ ) 
   cDesBco:= DESCRI 
ENDIF 
 
VPBOX( 11, 20, 16, 70, " Conta Corrente ", "15/02", , ,"00/15" ) 
SetColor( "15/02" ) 
@ 12,21 Say "No........: [" + cCtaNum + "]" 
@ 13,21 Say "Agencia...: [" + StrZero( nAgenci, 3, 0 ) + "][" + Left( cDesAge, 30 ) + "]" 
@ 14,21 Say "Banco.....: [" + StrZero( nBanco_, 3, 0 ) + "][" + Left( cDesBco, 30 ) + "]" 
@ 15,21 Say "Favorecido: [" + Left( cFavor_, 30 ) + "]" 
Inkey( 0 ) 
DBSelectAr( _COD_BLOPROG ) 
IF Confirma( 0,0, "Gravar?", ,"S" ) 
   IF Gerar_ <> 0 
      DBSelectAr( _COD_BLOPROG ) 
      DBAppend() 
      Repl tipTit With cTipTit,; 
           Docum_ With cDocum_,; 
           Banco_ With nBanco_,; 
           Agenci With nAgenci,; 
           Conta_ With nConta_,; 
           CodCli With nCodCli,; 
           Descri With cDescri,; 
           Ultemi With dEmiss_,; 
           UltVct With dVenc__,; 
           Gerar_ With nGerar_,; 
           Valor_ With nValor_,; 
           Reajus With nReajus,; 
           Emiss_ With dEmiss_,; 
           Venc__ With dVenc__,; 
           CodCed With cCodCed,; 
           Local_ With cLocal_,; 
           Hist01 With cHist01,; 
           CodH01 With nCodH01,; 
           Vlr_01 With nVlr_01,; 
           Hist02 With cHist02,; 
           CodH02 With nCodH02,; 
           Vlr_02 With nVlr_02,; 
           Hist03 With cHist03,; 
           CodH03 With nCodH03,; 
           Vlr_03 With nVlr_03,; 
           Hist04 With cHist04,; 
           CodH04 With nCodH04,; 
           Vlr_04 With nVlr_04,; 
           Hist05 With cHist05,; 
           CodH05 With nCodH05,; 
           Vlr_05 With nVlr_05 
   ENDIF 
   IF Confirma( 0, 0, "Gerar agora este DOC no movimento de Bloquetos?", ,"N" ) 
      DBSelectAr( _COD_BLOQUETO ) 
      DBAppend() 
      Replace tipTit With cTipTit,; 
              Docum_ With cDocum_,; 
              Banco_ With nBanco_,; 
              Agenci With nAgenci,; 
              Conta_ With nConta_,; 
              CodCli With nCodCli,; 
              Descri With cDescri,; 
              Ultemi With dEmiss_,; 
              UltVct With dVenc__,; 
              Gerar_ With nGerar_,; 
              Valor_ With nValor_,; 
              Reajus With nReajus,; 
              Emiss_ With dEmiss_,; 
              Venc__ With dVenc__,; 
              CodCed With cCodCed,; 
              Local_ With cLocal_,; 
              Hist01 With cHist01,; 
              CodH01 With nCodH01,; 
              Vlr_01 With nVlr_01,; 
              Hist02 With cHist02,; 
              CodH02 With nCodH02,; 
              Vlr_02 With nVlr_02,; 
              Hist03 With cHist03,; 
              CodH03 With nCodH03,; 
              Vlr_03 With nVlr_03,; 
              Hist04 With cHist04,; 
              CodH04 With nCodH04,; 
              Vlr_04 With nVlr_04,; 
              Hist05 With cHist05,; 
              CodH05 With nCodH05,; 
              Vlr_05 With nVlr_05,; 
              Manual With 0 
   ENDIF 
ENDIF 
DBSelectar( _COD_BLOPROG ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oVER:refreshAll() 
WHILE !oVER:stabilize() 
ENDDO 
Return Nil 
 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ ALTERADOC 
³ Finalidade  ³ Alteracao dos DOCs de cobranca 
³ Parametros  ³ NIL 
³ Retorno     ³ NIL 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ NIL 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
STATIC FUNCTION AlteraDOCProg( oVer ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local CTIPTIT:= TipTit, CDOCUM_:= Docum_, NBANCO_:= Banco_, NAGENCI:= Agenci,; 
      NCONTA_:= Conta_, cCtaNum:= Space( 20 ), NCODCLI:= CodCli,; 
      CDESCRI:= Descri, DULTEMI:= UltEmi, cDesAge:= Space( 20 ),; 
      cDesBco:= Space( 20 ), DULTVCT:= UltVct, NGERAR_:= Gerar_,; 
      NVALOR_:= Valor_, NREAJUS:= Reajus,; 
      NCODH01:= CodH01, CHIST01:= Hist01, NVLR_01:= Vlr_01,; 
      NCODH02:= CodH02, CHIST02:= Hist02, NVLR_02:= Vlr_02,; 
      NCODH03:= CodH03, CHIST03:= Hist03, NVLR_03:= Vlr_03,; 
      NCODH04:= CodH04, CHIST04:= Hist04, NVLR_04:= Vlr_04,; 
      NCODH05:= CodH05, CHIST05:= Hist05, NVLR_05:= Vlr_05,; 
      DEMISS_:= Emiss_, DVENC__:= Venc__, CDUPLIC:= Duplic,; 
      CNOSSON:= Nosson, CCODCED:= CodCed, DDTQUIT:= DTQuit,; 
      CCHEQUE:= Cheque, CLOCAL_:= Local_, NLOCPGT:= LocPgt,; 
      cFavor_:= Space( 30 ) 
 
VPBox( 1, 1, 10, 77, "Alteracao de Bloquetos" ) 
setcursor(1) 
setcolor( _COR_BROWSE ) 
@ 03,03 Say "Tipo de Titulo:" Get cTipTit Pict "!!!" When; 
  Mensagem( "Digite o tipo de Titulo (Ex. DOC)." ) 
@ 03,27 Say "Referente Documento:" Get cDocum_ When; 
  Mensagem( "Digite o documento que se refere este DOC." ) 
@ 03,62 Say "Tipo: [Manual]" 
VPBox( 04, 02, 08, 76, , ,.F.,.F. ) 
@ 05,03 Say "Cliente:" Get nCodCli Pict "@E 999999" Valid PesqCli( @nCodCli ) When; 
  Mensagem( "Digite o codigo do cliente ou [99999] para ver na lista." ) 
@ 06,03 Say "Emissao:" Get dEmiss_ When; 
  Mensagem( "Digite a data de emissao deste DOC." ) 
@ 07,03 Say "Vencto.:" Get dVenc__ When; 
  Mensagem( "Digite a data de vencimento deste DOC." ) 
@ 06,36 Say "Valor Total............: [*************]" 
@ 07,36 Say "Programacao deste DOC..:" Get nGerar_ Pict "@E 99" Valid PesqGerar( @nGerar_ ) When; 
  Mensagem( "Digite conforme a tabela." ) 
VPBox( 10, 1, 21, 77, "Relacao de Historicos", _COR_BROWSE ) 
 
@ 12,02 Get nCODH01 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 1 ) 
@ 12,08 Get CHIST01 
@ 12,41 Get NVLR_01 Pict "@E 9,999,999.99" 
 
@ 14,02 Get nCODH02 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 2 ) 
@ 14,08 Get CHIST02 
@ 14,41 Get NVLR_02 Pict "@E 9,999,999.99" 
 
@ 16,02 Get nCODH03 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 3 ) 
@ 16,08 Get CHIST03 
@ 16,41 Get NVLR_03 Pict "@E 9,999,999.99" 
 
@ 18,02 Get nCODH04 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 4 ) 
@ 18,08 Get CHIST04 
@ 18,41 Get NVLR_04 Pict "@E 9,999,999.99" 
 
@ 20,02 Get nCODH05 Pict "999" Valid PesqHis( @nCodH01, @nCodH02, @nCodH03, @nCodH04, @nCodH05,; 
                                              @cHist01, @cHist02, @cHist03, @cHist04, @cHist05,; 
                                              @nVlr_01, @nVlr_02, @nVlr_03, @nVlr_04, @nVlr_05, 5 ) 
@ 20,08 Get CHIST05 
@ 20,41 Get NVLR_05 Pict "@E 9,999,999.99" 
 
@ 14,60 Say "Conta.:" Get nConta_ Pict "999" 
 
READ 
 
nValor_:= nVlr_01 + nVlr_02 + nVlr_03 + nVlr_04 + nVlr_05 
 
DBSelectAr( _COD_CLIENTE ) 
IF DBSeek( nCodCli ) 
   cDescri:= Descri 
ENDIF 
 
DBSelectAr( _COD_CONTA ) 
IF DBSeek( nConta_ ) 
   nAgenci:= AGENC_ 
   cFavor_:= DESCRI 
   cCtaNum:= CONTA_ 
   cCodCed:= CodCed 
ENDIF 
DBSelectAr( _COD_AGENCIA ) 
IF DBSeek( nAgenci ) 
   nBanco_:= BANCO_ 
   cDesAge:= DESCRI 
ENDIF 
DBSelectAr( _COD_BANCO ) 
IF DBSeek( nBanco_ ) 
   cDesBco:= DESCRI 
ENDIF 
 
VPBOX( 11, 20, 16, 70, " Conta Corrente ", "15/02", , ,"00/15" ) 
SetColor( "15/02" ) 
@ 12,21 Say "No........: [" + cCtaNum + "]" 
@ 13,21 Say "Agencia...: [" + StrZero( nAgenci, 3, 0 ) + "][" + Left( cDesAge, 30 ) + "]" 
@ 14,21 Say "Banco.....: [" + StrZero( nBanco_, 3, 0 ) + "][" + Left( cDesBco, 30 ) + "]" 
@ 15,21 Say "Favorecido: [" + Left( cFavor_, 30 ) + "]" 
Inkey( 0 ) 
IF Confirma( 0,0, "Gravar?", ,"S" ) 
   DBSelectAr( _COD_BLOPROG ) 
   IF RLock() 
      Repl tipTit With cTipTit,; 
           Docum_ With cDocum_,; 
           Banco_ With nBanco_,; 
           Agenci With nAgenci,; 
           Conta_ With nConta_,; 
           CodCli With nCodCli,; 
           Descri With cDescri,; 
           Ultemi With dEmiss_,; 
           UltVct With dVenc__,; 
           Gerar_ With nGerar_,; 
           Valor_ With nValor_,; 
           Reajus With nReajus,; 
           Emiss_ With dEmiss_,; 
           Venc__ With dVenc__,; 
           CodCed With cCodCed,; 
           Local_ With cLocal_,; 
           Hist01 With cHist01,; 
           CodH01 With nCodH01,; 
           Vlr_01 With nVlr_01,; 
           Hist02 With cHist02,; 
           CodH02 With nCodH02,; 
           Vlr_02 With nVlr_02,; 
           Hist03 With cHist03,; 
           CodH03 With nCodH03,; 
           Vlr_03 With nVlr_03,; 
           Hist04 With cHist04,; 
           CodH04 With nCodH04,; 
           Vlr_04 With nVlr_04,; 
           Hist05 With cHist05,; 
           CodH05 With nCodH05,; 
           Vlr_05 With nVlr_05 
     ENDIF 
     DBUnlockALL() 
ENDIF 
DBSelectar( _COD_BLOPROG ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oVER:refreshAll() 
WHILE !oVER:stabilize() 
ENDDO 
Return Nil 
 
 
 
 
 
FUNCTION PesqGerar( nOpcao ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  vpbox(05,44,15,76) 
  keyboard Chr( K_SPACE ) 
  IF nOpcao <> 0 
     nOpcao:= nOpcao + 1 
  ENDIF 
  whil .t. 
     @ 06,45 Prompt " 0 Nao Programado            " 
     @ 07,45 Prompt " 1 Semanal          (7 dias) " 
     @ 08,45 Prompt " 2 Quinzenal       (15 dias) " 
     @ 09,45 Prompt " 3 Mensal          (30 dias) " 
     @ 10,45 Prompt " 4 Bimestral       (60 dias) " 
     @ 11,45 Prompt " 5 Trimestral      (90 dias) " 
     @ 12,45 Prompt " 6 Quadrimestral  (120 dias) " 
     @ 13,45 Prompt " 7 Semestral      (180 dias) " 
     @ 14,45 Prompt " 8 Anual          (360 dias) " 
     menu to nOPCAO 
     nOpcao:= nOpcao - 1 
     IF nOpcao > -1 
        Exit 
     ENDIF 
  enddo 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return .T. 
 
 
Function PesqHis( nCodH01, nCodH02, nCodH03, nCodH04, nCodH05,; 
                  cHist01, cHist02, cHist03, cHist04, cHist05,; 
                  nVlr_01, nVlr_02, nVlr_03, nVlr_04, nVlr_05, nPosicao ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 07, 10, 19, 60 ) 
Local oTab 
Local nArea:= Select(), nOrdem:= IndexOrd() 
nTotal:=( NVLR_01 + NVLR_02 + NVLR_03 + NVLR_04 + NVLR_05 ) 
@ 06,61 Say Tran( nTotal, "@E 999,999,999.99" ) 
DBSelectAr( _COD_HISTORICO ) 
IF nPosicao == 1 
   IF nCodH01 >= 900 .AND. nCodH01 <= 950 .OR. nCodH01 == 0 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
   IF DBSeek( nCodH01 ) .OR. nCodH01 == 0 
      cHist01:= Descri 
      nVlr_01:= ValorP 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
ELSEIF nPosicao == 2 
   IF nCodH02 >= 900 .AND. nCodH02 <= 950 .OR. nCodH02 == 0 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
   IF DBSeek( nCodH02 ) .OR. nCodH02 == 0 
      cHist02:= Descri 
      nVlr_02:= ValorP 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
ELSEIF nPosicao == 3 
   IF nCodH03 >= 900 .AND. nCodH03 <= 950 .OR. nCodH03 == 0 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
   IF DBSeek( nCodH03 ) .OR. nCodH03 == 0 
      cHist03:= Descri 
      nVlr_03:= ValorP 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
ELSEIF nPosicao == 4 
   IF nCodH04 >= 900 .AND. nCodH04 <= 950 .OR. nCodH04 == 0 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
   IF DBSeek( nCodH04 ) .OR. nCodH04 == 0 
      cHist04:= Descri 
      nVlr_04:= ValorP 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
ELSEIF nPosicao == 5 
   IF nCodH05 >= 900 .AND. nCodH05 <= 950  .OR. nCodH05 == 0 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
   IF DBSeek( nCodH05 ) .OR. nCodH05 == 0 
      cHist05:= Descri 
      nVlr_05:= ValorP 
      DBSelectAr( nArea ) 
      Return .T. 
   ENDIF 
ENDIF 
DBGoTop() 
SetColor(COR[16]) 
VPBox( 07, 10, 18, 57, "Display de Historico" ) 
setcursor(0) 
setcolor( _COR_BROWSE ) 
Mensagem( "Pressione [Enter] para Selecionar.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
oTab:=tbrowsedb( 08, 11, 17, 56 ) 
oTab:addcolumn(tbcolumnnew(,{|| STRZero( CODIGO, 3, 0 ) + " " + DESCRI + " " + Tran( VALORP, "@E 999,999.99" ) })) 
oTab:AUTOLITE:=.f. 
oTab:dehilite() 
whil .t. 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTab:stabilize() 
   enddo 
   TECLA:=inkey(0) 
   If TECLA=K_ESC 
      exit 
   EndIf 
   do case 
      case TECLA==K_UP         ;oTab:up() 
      case TECLA==K_LEFT       ;oTab:up() 
      case TECLA==K_RIGHT      ;oTab:down() 
      case TECLA==K_DOWN       ;oTab:down() 
      case TECLA==K_PGUP       ;oTab:pageup() 
      case TECLA==K_PGDN       ;oTab:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
      case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
      case TECLA==K_ENTER 
           do case 
              case nPosicao == 1 
                   NCODH01:= CODIGO 
                   CHIST01:= DESCRI 
                   NVLR_01:= VALORP 
              case nPosicao == 2 
                   NCODH02:= CODIGO 
                   CHIST02:= DESCRI 
                   NVLR_02:= VALORP 
              case nPosicao == 3 
                   NCODH03:= CODIGO 
                   CHIST03:= DESCRI 
                   NVLR_03:= VALORP 
              case nPosicao == 4 
                   NCODH04:= CODIGO 
                   CHIST04:= DESCRI 
                   NVLR_04:= VALORP 
              case nPosicao == 5 
                   NCODH05:= CODIGO 
                   CHIST05:= DESCRI 
                   NVLR_05:= VALORP 
           endcase 
           nTotal:=( NVLR_01 + NVLR_02 + NVLR_03 + NVLR_04 + NVLR_05 ) 
           @ 06,61 Say Tran( nTotal, "@E 999,999,999.99" ) 
           exit 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTab:refreshcurrent() 
   oTab:stabilize() 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
Keyboard Chr( K_ENTER ) + Chr( K_UP ) 
return .t. 
 
 
Function PesqHis2( nCodHis ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 07, 10, 19, 60 ) 
Local oTab 
Local nArea:= Select(), nOrdem:= IndexOrd() 
DBSelectAr( _COD_HISTORICO ) 
IF nCodHis >= 900 .AND. nCodHis <= 950 .OR. nCodHis == 0 
   DBSelectAr( nArea ) 
   Return .T. 
ENDIF 
IF DBSeek( nCodHis ) .OR. nCodHis == 0 
   nCodHis:= CODIGO 
   DBSelectAr( nArea ) 
   Return .T. 
ENDIF 
DBGoTop() 
SetColor(COR[16]) 
VPBox( 07, 10, 18, 57, "Display de Historico" ) 
setcursor(0) 
setcolor( _COR_BROWSE ) 
Mensagem( "Pressione [Enter] para Selecionar.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
oTab:=tbrowsedb( 08, 11, 17, 56 ) 
oTab:addcolumn(tbcolumnnew(,{|| STRZero( CODIGO, 3, 0 ) + " " + DESCRI + " " + Tran( VALORP, "@E 999,999.99" ) })) 
oTab:AUTOLITE:=.f. 
oTab:dehilite() 
whil .t. 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTab:stabilize() 
   enddo 
   TECLA:=inkey(0) 
   If TECLA=K_ESC 
      exit 
   EndIf 
   do case 
      case TECLA==K_UP         ;oTab:up() 
      case TECLA==K_LEFT       ;oTab:up() 
      case TECLA==K_RIGHT      ;oTab:down() 
      case TECLA==K_DOWN       ;oTab:down() 
      case TECLA==K_PGUP       ;oTab:pageup() 
      case TECLA==K_PGDN       ;oTab:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
      case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
      case TECLA==K_ENTER      ;nCodHis:= CODIGO ;exit 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTab:refreshcurrent() 
   oTab:stabilize() 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
return .t. 
 
 
 
 
STATIC FUNCTION GeraDocAutomatico() 
Local nArea:= Select(), nOrdem:= IndexOrd(), nRegistro:= Recno() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nDias:= 0 
 
/* Arquivo de bloquetos programados */ 
DBSelectAr( _COD_BLOPROG ) 
DBGoTop() 
 
WHILE !EOF() 
   nDias:= 0 
   DO CASE 
      CASE Gerar_ == 1 
           nDias:= 7 
      CASE Gerar_ == 2 
           nDias:= 15 
      CASE Gerar_ == 3 
           nDias:= 30 
      CASE Gerar_ == 4 
           nDias:= 60 
      CASE Gerar_ == 5 
           nDias:= 90 
      CASE Gerar_ == 6 
           nDias:= 120 
      CASE Gerar_ == 7 
           nDias:= 180 
      CASE Gerar_ == 8 
           nDias:= 360 
   ENDCASE 
   IF Date() >= VENC__ + nDias .OR. Date() >=EMISS_ + nDias 
      DBSelectAr( _COD_BLOQUETO ) 
      DBAppend() 
      dDataVenc:= CTOD( StrZero( Day( BLP->VENC__ ), 2, 0 ) +; 
                  "/" + StrZero( Month( BLP->VENC__ + nDias ), 2, 0 ) +; 
                  "/" + Right( StrZero( Year( BLP->VENC__ + nDias ), 4, 0 ), 2 ) ) 
      dDataEmiss:= CTOD( StrZero( Day( BLP->EMISS_ ), 2, 0 ) +; 
                   "/" + StrZero( Month( BLP->EMISS_ + nDias ), 2, 0 ) +; 
                   "/" + Right( StrZero( Year( BLP->EMISS_ + nDias ), 4, 0 ), 2 ) ) 
 
      /* Replace Campos para nao ativar COMMIT */ 
      _FIELD->TIPTIT := BLP->TIPTIT 
      _FIELD->DOCUM_ := BLP->DOCUM_ 
      _FIELD->BANCO_ := BLP->BANCO_ 
      _FIELD->AGENCI := BLP->AGENCI 
      _FIELD->CONTA_ := BLP->CONTA_ 
      _FIELD->CODCLI := BLP->CODCLI 
      _FIELD->DESCRI := BLP->DESCRI 
      _FIELD->ULTEMI := BLP->ULTEMI 
      _FIELD->ULTVCT := BLP->ULTVCT 
      _FIELD->GERAR_ := BLP->GERAR_ 
      _FIELD->VALOR_ := BLP->VALOR_ 
      _FIELD->REAJUS := BLP->REAJUS 
      _FIELD->CODH01 := BLP->CODH01 
      _FIELD->HIST01 := BLP->HIST01 
      _FIELD->VLR_01 := BLP->VLR_01 
      _FIELD->CODH02 := BLP->CODH02 
      _FIELD->HIST02 := BLP->HIST02 
      _FIELD->VLR_02 := BLP->VLR_02 
      _FIELD->CODH03 := BLP->CODH03 
      _FIELD->HIST03 := BLP->HIST03 
      _FIELD->VLR_03 := BLP->VLR_03 
      _FIELD->CODH04 := BLP->CODH04 
      _FIELD->HIST04 := BLP->HIST04 
      _FIELD->VLR_04 := BLP->VLR_04 
      _FIELD->CODH05 := BLP->CODH05 
      _FIELD->HIST05 := BLP->HIST05 
      _FIELD->VLR_05 := BLP->VLR_05 
      _FIELD->EMISS_ := BLP->EMISS_ + nDias 
      _FIELD->VENC__ := dDataVenc 
      _FIELD->DUPLIC := BLP->DUPLIC 
      _FIELD->NOSSON := BLP->NOSSON 
      _FIELD->CODCED := BLP->CODCED 
      _FIELD->DTQUIT := BLP->DTQUIT 
      _FIELD->CHEQUE := BLP->CHEQUE 
      _FIELD->LOCAL_ := BLP->LOCAL_ 
      _FIELD->LOCPGT := BLP->LOCPGT 
 
       DBSelectAr( _COD_BLOPROG ) 
       IF RLock() 
          /* Replace */ 
          _FIELD->VENC__ := Venc__ + nDias 
          _FIELD->EMISS_ := Emiss_ + nDias 
       ENDIF 
       DBUnlockAll() 
       Mensagem( "Gravando DOCs autom ticos. aguarde..." ) 
   ELSE 
       DBSkip() 
   ENDIF 
ENDDO 
DBSelectAr( nArea ) 
DBSetORder( nOrdem ) 
DBGoTo( nRegistro ) 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
FUNCTION IMPDOC( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
LOCA nArea:=select(), nOrdem:= IndexOrd(),; 
     WEMPRESA:=_EMP+spac(int(50-len(_EMP))), dData:=date(), nQuant:=1,; 
     WCONTROLE:=0, WPARCELAI:=0, WPARCELAF:=1, WRESP:=.f.,; 
     WVALOR_:=WVLRDOC:=0, WCODIGO:=0,; 
     WHISTOR:= Spac(0), aHistorico:= {}, cDevice:= "LPT2    ", cArquivoInst:= "BANRISUL.SYS",; 
     nCt1:= 0, cLocal:= "                                                    " 
LOCA cBanco:= "03" 
 
 
ajuda("[ENTER]Confirma") 
vpbox(02,28,11,73,"Impressao de docs",COR[12]) 
setcolor(COR[12]) 
SetCursor( 1 ) 
cAceite:= " 02 " 
@ 03,30 Say "Local:" Get cLocal Pict "@S25" 
@ 04,30 Say "Aceite..............:" Get cAceite 
@ 05,30 Say "Formato do Bloqueto.:" Get cBanco Pict "XX" Valid BuscaFormato( @cBanco ) 
@ 06,30 say "Quantidade de copias:" get nQuant pict "99" 
@ 07,30 say "Data de emissao.....:" get dData 
@ 08,30 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" 
@ 09,30 Say "Porta Impressao.....:" Get cDevice 
@ 10,30 Say "Arquivo de Instrucao:" Get cArquivoInst 
read 
if LASTKEY() == K_ESC 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
Endif 
set( 24, Alltrim( cDevice ) ) 
if ! confirma(07,60,"Confirma?","Confirma a impressao dos dados.","S") 
   setcolor(cCor) 
   setcursor(nCursor) 
   screenRest(cTela) 
   return NIL 
endif 
whil ! isprinter() 
   ajuda("[ENTER]Imprimir [ESC]Finaliza") 
   mensagem("Verifique a impressora e pressione [ENTER] para continuar.",1) 
   inkey(0) 
   if lastkey()==K_ESC 
      setcursor(nCursor) 
      setcolor(cCor) 
      screenrest(cTela) 
      return NIL 
   elseif lastkey()==K_ENTER 
      exit 
   endif 
enddo 
 
NF_->( DBSetOrder( 1 )) 
DBSelectAr( _COD_CLIENTE ) 
DBSetOrder( 1 ) 
DBSelectAr( _COD_BLOQUETO ) 
SET RELATION TO CODCLI INTO CLI 
cEspDoc:= "DM" 
aHistorico:= IOFillText( MEMOREAD( cArquivoInst ) ) 
Set( _SET_DEVICE, "SCREEN" ) 
DBGoTop() 
WHILE !EOF() 
    mensagem("Imprimindo registro " + alltrim( str( Recno() ) ) + ", aguarde...") 
    IF LastKey() == K_ESC .OR. NextKey() == K_ESC 
       EXIT 
    ENDIF 
    set(_SET_DEVICE,"PRINT") 
    IF Empty( DTQUIT ) .AND. VALOR_ <> 0 .AND. MARCA_ == "+" 
       @ PRow(), 00 Say Chr( 15 ) 
       Set(_SET_DEVICE,"SCREEN") 
       Mensagem( "Buscando informacoes do banco..." ) 
       //cLocal:= LocalizaAg( CLI->CODCEP ) 
 
       Set(_SET_DEVICE,"PRINT" ) 
       nCodigo:= StrZero( SEQUE_, 8, 0 ) 
       dDataVenc:= VENC__ 
       nValor_:= VALOR_ 
       WLIN:=prow() 
       set(_SET_DEVICE,"PRINT") 
 
       DO CASE 
          CASE cBanco=="01" 
               @ WLIN+=2,10 say cLocal 
               @ WLIN,105 say dDataVenc 
               @ WLIN+=3,10 say dData 
               @ WLIN,28 say nCodigo 
               @ WLIN,50 say cEspDoc 
               @ ++WLIN,100 say tran( nValor_,"@E 999,999,999,999.99") 
               @ ++WLIN,10 Say StrZero( CodH01, 3, 0 ) + " " + Hist01 + tran( Vlr_01, "@E 9999,999.99" ) 
               @ ++WLIN,10 Say IF( Vlr_02 == 0, " ", StrZero( CodH02, 3, 0 ) + " " + Hist02 + tran( Vlr_02, "@E 9999,999.99" ) ) 
               @ ++WLIN,10 Say IF( Vlr_03 == 0, " ", StrZero( CodH03, 3, 0 ) + " " + Hist03 + tran( Vlr_03, "@E 9999,999.99" ) ) 
               @ ++WLIN,10 Say IF( Vlr_04 == 0, " ", StrZero( CodH04, 3, 0 ) + " " + Hist04 + tran( Vlr_04, "@E 9999,999.99" ) ) 
               @ ++WLIN,10 Say IF( Vlr_05 == 0, " ", StrZero( CodH05, 3, 0 ) + " " + Hist05 + tran( Vlr_05, "@E 9999,999.99" ) ) 
               nQuantMov:= 0 
               ++WLIN 
               FOR nCt2:= 1 TO Len( aHistorico ) 
                   IF nCt2==1 .or. nCt2==2 
                      @ ++WLIN,10 say aHistorico[ nCt2 ] 
                      ++nQuantMov 
                   ENDIF 
               NEXT 
               WLIN:= WLIN + ( 2 - nQuantMov ) 
               @ WLIN+=1,10 say CLI->DESCRI + SPACE(20) + TRAN( ALLTRIM( CLI->CGCMF_ ), "@R 99.999.999/9999-99" ) 
               @ ++WLIN,10 say CLI->ENDERE 
               @ WLIN,60 say CLI->BAIRRO 
               @ ++WLIN,10 say alltrim(CLI->CIDADE)+"-"+CLI->ESTADO 
               @ WLIN,60 say trans(CLI->CODCEP,if(CLI->CODCEP<>space(8),"@R 99.999-999","")) 
               @ WLIN+=7,06 say spac(0) 
          CASE cBanco == "02" 
               @ WLIN+=2,06 say cLocal 
               @ WLIN,102 say dDataVenc 
               @ WLIN+=3,06 say dData 
               @ WLIN,25 say nCodigo 
               @ WLIN,46 say cEspDoc 
               @ ++WLIN,93 say tran( nValor_, "@E 999,999,999,999.99" ) 
               WLIN+= 2 
               @ ++WLIN,30 Say "Nota Fiscal: " + StrZero( VAL( DUPLIC ), 8, 0 ) 
               WLN:=0 
               FOR nCt2:= 1 TO Len( aHistorico ) 
                   ++WLN 
                   @ ++WLIN,05 say aHistorico[ nCt2 ] 
               NEXT 
               WLIN:=WLIN+3-WLN 
               @ WLIN+=3,05 say CLI->DESCRI + SPACE(20) + TRAN( ALLTRIM( CLI->CGCMF_ ), "@R 99.999.999/9999-99" ) 
               @ ++WLIN,05 say CLI->ENDERE 
               @ WLIN,55 say CLI->BAIRRO 
               @ ++WLIN,05 say alltrim(CLI->CIDADE)+"-"+CLI->ESTADO 
               @ WLIN,50 say trans(CLI->CODCEP,if(CLI->CODCEP<>space(8),"@R 99.999-999","")) + Space( 10 ) + StrZero( CLI->CODIGO, 6, 0 ) 
               @ WLIN+=7,06 say spac(0) 
          CASE cBanco == "03" 
               @ PROW(),0 Say Chr( 18 ) + Space( 20 ) 
               @ WLIN+=1,50 say dDataVenc 
               @ PROW(),PCOL() Say Chr( 15 ) 
               @ WLIN+=1,01 say cLocal 
               @ PROW(),PCOL() SAY Chr( 18 ) 
               @ WLIN+=3,00 say dData 
               @ WLIN,12 say nCodigo 
               @ WLIN,23 say cEspDoc 
               @ WLIN,30 Say cAceite 
               @ ++WLIN,53 say tran( nValor_, "@E 999,999.99" ) 
                 ++WLIN 
               @ ++WLIN,27 Say tran( ( nValor_ * 0.20 ) / 100, "@E 9999.99" ) 
               @ WLIN+=2,02 Say "Nota Fiscal: " + StrZero( VAL( DUPLIC ), 8, 0 ) 
               WLN:=0 
               FOR nCt2:= 1 TO Len( aHistorico ) 
                   ++WLN 
                   @ ++WLIN,02 say aHistorico[ nCt2 ] 
               NEXT 
               WLIN:=WLIN+2-WLN 
               @ WLIN+=3,05 say left( CLI->DESCRI, 35 ) + " " 
               nCliente:= CLI->CODIGO 
               NF_->( DBSeek( Val( BLO->DUPLIC ) ) ) 
               nVendedor:= NF_->VENEX_ 
               IF LEFT( CLI->COBRAN, 4 ) == "CLI*" 
                  nCodCli:= VAL( SubStr( CLI->COBRAN, 5, 10 ) ) 
                  CLI->( DBSeek( nCodCli ) ) 
               ENDIF 
               @ WLIN,   43 SAY TRAN( ALLTRIM( CLI->CGCMF_ ), "@R 99.999.999/9999-99" ) 
               @ ++WLIN, 05 say CLI->ENDERE 
               @ WLIN,   43 say CLI->INSCRI 
               CLI->( DBSeek( nCliente ) ) 
               @ ++WLIN, 05 say alltrim(CLI->CIDADE)+"-"+CLI->ESTADO 
               @ WLIN,   30 say trans(CLI->CODCEP,if(CLI->CODCEP<>space(8),"@R 99.999-999","")) + Space( 10 ) + StrZero( CLI->CODIGO, 6, 0 ) + " VD: " + StrZero( nVendedor, 3, 0 ) 
               @ WLIN+=7,06 say spac(0) 
        OTHERWISE 
               Relatorio( "DOC001.REP" ) 
 
        ENDCASE 
        IF !WRESP 
           set(_SET_DEVICE,"SCREEN") 
           setcursor(1) 
           mensagem("",1) 
           WRESP:=confirma(23,20,"O formulario esta ajustado?",,"N") 
           IF lastkey()=K_ESC 
              exit 
           ENDIF 
        ELSE 
           DBSkip() 
        ENDIF 
    ELSE 
        DBSkip() 
    ENDIF 
    Set( _SET_DEVICE, "SCREEN" ) 
ENDDO 
IF !LastKey() == K_ESC 
   cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
   Aviso( " IMPRESSAO CONCLUIDA! " ) 
   Mensagem( "Pressine [ENTER] para continuar..." ) 
   Pausa() 
   ScreenRest( cTelaRes ) 
ENDIF 
IF !( Left( Alltrim( cDevice ), 3 ) == "LPT" ) 
   cDevice:= Alltrim( cDevice ) + ".PRN" 
   ViewFile( cDevice ) 
ENDIF 
DBSelectAr( _COD_BLOQUETO ) 
DBGoTop() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
oTab:refreshAll() 
WHILE !oTab:Stabilize() 
ENDDO 
Return Nil 
 
FUNCTION LocalizaAg( cCodCep ) 
LOCAL nArea:= Select(), cLocalBanco:= CLI->CIDADE 
DBSelectAr( 233 ) 
IF FILE( GDIR2SUB + "\BAGENCIA.DBF" ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir2sub/bagencia.dbf" shared  
   #else 
     USE "&GDIR2SUB\BAGENCIA.DBF" SHARED  
   #endif
   IF !FILE( GDIR2SUB + "\BAGENCIA.NTX" ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        index on cep to "&gdir2sub/bagencia.ntx" 
      #else 
        INDEX ON CEP TO "&GDIR2SUB\BAGENCIA.NTX" 
      #endif
   ENDIF 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir2sub/bagencia.ntx"
   #else 
     SET INDEX TO "&GDIR2SUB\BAGENCIA.NTX" 
   #endif
   
ELSE 
   DBCloseArea() 
   DBSelectAr( nArea ) 
   Return cLocalBanco 
ENDIF 

IF DBSeek( cCodCep ) 
   cLocalBanco:= CLI->CIDADE + " " + StrZero( Val( AGENCIA ), 4, 0 ) 
ENDIF 

DBSelectAr( nArea ) 
Return cLocalBanco 
 

 
Static Function BuscaFormato( cFormato ) 
Local nCt 
Local nOpcao:= Val( cFormato ) 
Local aFormatos:= { { "01", " BANRISUL                     " },; 
                    { "02", " BRADESCO (1)                 " },; 
                    { "03", " BRADESCO (2)                 " },; 
                    { "04", " BANCO DO BRASIL              " },; 
                    { "05", " MERIDIONAL                   " },; 
                    { "06", " CAIXA                        " },; 
                    { "07", " BAMERINDUS                   " },; 
                    { "08", " ITAU                         " },; 
                    { "09", " REAL                         " } } 
 
   VPBOX( 10, 09, 10 + Len( aFormatos ) + 1, 40, " Formato do Bloqueto " ) 
   FOR nCt:= 1 TO Len( aFormatos ) 
       @ 10+nCt, 10 Prompt aFormatos[ nCt ][ 2 ] 
   NEXT 
   Menu To nOpcao 
   IF nOpcao > 0 
      cFormato:= aFormatos[ nOpcao ][ 1 ] 
   ELSE 
      cFormato:= "01" 
   ENDIF 
   Return .T. 
 
 
