// ## CL2HB.EXE - Converted
/* 
** Funcao      - IMPOrdemCompra 
** Finalidade  - Imprimir Ordem de Compra Pendente 
** Parametros  - Nenhum 
** Retorno     - Nenhum 
** Autor       - Valmor Pereira Flores 
**             - CopyRight(C)1994/1995 - VPComp Informatica ltda. 
** Data        - 
** Atualizacao - 
*/ 
#INCLUDE 'vpf.ch' 
#INCLUDE 'inkey.ch' 
FUNCTION ImpOrdemCompra() 
//* Variaveis com informacoes do modulo anterior *// 
LOCAL cTELA:= ScreenSave( 00, 00, 24, 79 ),; 
      cCOR:= SETCOLOR(),; 
      nCURSOR:= SETCURSOR() 
LOCAL lGeral:= .F. 
 
//* Variaveis de dados *// 
LOCAL nCODFOR:= 0,; 
      cDESFOR:= SPAC(30),; 
      cSAIDA:= SPACE( 1 ),; 
      nLINHA:= 0,; 
      nMAXLINHA:= 0,; 
      aSOMA:= {0,0,0},; 
      nRECEBIDO:= 0,; 
      nARECEBER:= 0,; 
      nQUANT:= 0,; 
      nOPCAO:= 0,; 
      dDATA:= DATE() 
//* Variaveis para browse *// 
LOCAL oTAB, nROW:=1, TECLA 
 
PRIVATE aOC:= {} 
 
//* Abertura dos arquivos *// 
IF !FdbUseVpb( _COD_FORNECEDOR ) 
   Mensagem( 'Pressione [ENTER] para continuar....' ) 
   Aviso( 'Falha ao acessar arquivo: ' + ALLTRIM( _VPB_FORNECEDOR ), 24 / 2 ) 
   Pausa() 
   ScreenRest( cTELA ) 
   RETURN NIL 
ENDIF 
IF !FdbuseVpb( _COD_OC ) 
   Mensagem( 'Erro na abertura do arquivo...' ) 
   Pausa() 
   ScreenRest( cTELA ) 
   RETURN NIL 
ENDIF 
IF !FdbUseVpb( _COD_OC_AUXILIA ) 
   Mensagem( 'Pressione [ENTER] para continuar....' ) 
   Aviso( 'Falha ao acessar arquivo: ' + ALLTRIM( _VPB_OC_AUXILIA ), 24 / 2 ) 
   Pausa() 
   ScreenRest( cTELA ) 
   RETURN NIL 
ENDIF 
//* Montagem da tela *// 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserModulo( 'Impressao de Ordens de Compra pendentes' ) 
 
//* Solicitacao dos dados *// 
SET( _SET_DELIMITERS, .F. ) 
VpBox( 13, 35, 16, 55, "Pendentes:" ) 
@ 14, 36 PROMPT " 1> At� "+DTOC( DATE() )+"   " 
@ 15, 36 PROMPT " 2> Proje��o       " 
MENU TO nOPCAO 
DO CASE 
   CASE nOPCAO == 1 
        VpBox( 15, 30, 19, 63, 'Fornecedor' ) 
        @ 16, 32 SAY 'O.C. pendentes at� '+DTOC( DATE() ) 
        @ 17, 32 GET cDESFOR WHEN; 
        Mensagem( 'Digite o nome do fornecedor.' ) 
        READ 
   CASE nOPCAO == 2 
        VpBox( 15, 30, 19, 63, 'Fornecedor' ) 
        @ 16, 32 GET dDATA WHEN; 
          Mensagem( 'Digite a data limite para a projecao.' ) 
        @ 17, 32 GET cDESFOR WHEN; 
          Mensagem( 'Digite o nome do fornecedor.' ) 
        READ 
ENDCASE 
SET( _SET_DELIMITERS, .T. ) 
IF LASTKEY() == K_ESC 
   SETCOLOR( cCOR ) 
   ScreenRest( cTELA ) 
   RETURN NIL 
ENDIF 
 
/* Se estiver em branco o fornecedor considerar geral */ 
IF "a" + AllTrim( cDesFor ) == "a" 
   lGeral:= .T. 
ELSE 
   lGeral:= .F. 
ENDIF 
 
Mensagem( 'Aguarde, pesquisando ordem de compra...' ) 
DBSELECTAR( _COD_FORNECEDOR ) 
DBSETORDER( 2 ) 
DBSEEK( cDESFOR, .T. ) 
cDESFOR:= FOR->DESCRI 
nCODFOR:= FOR->CODIGO 
@ 18,32 SAY Substr( cDESFOR, 1, 30 ) 
VpBox( 14, 55, 17, 65 ) 
DBSELECTAR( _COD_OC ) 
DBGOTOP() 
IF lGeral 
   cDesFor:= "Geral - Todos os fornecedores" 
ENDIF 
WHILE !OC->( EOF() ) 
   IF _FIELD->CODFOR == nCODFOR .OR. lGeral 
      cORDEM:= _FIELD->ORDCMP 
      DBSELECTAR( _COD_OC_AUXILIA ) 
      DBSEEK( cORDEM ) 
      WHIL OCA->ORDCMP == cORDEM 
           DO CASE 
              CASE nOPCAO == 1 
                   IF OCA->SDOREC > 0 .AND. OCA->ENTREG <= DATE() 
                      AADD( aOC, { OCA->ORDCMP,; 
                                   OCA->DESPRO,; 
                                   OCA->QUANT_,; 
                                   OCA->PRECOU,; 
                                   OCA->RECEBI,; 
                                   OCA->SDOREC,; 
                                   OCA->ENTREG } ) 
                       aSOMA[1]+=( OCA->SDOREC * OCA->PRECOU ) 
                       aSOMA[2]+=( ( ( OCA->SDOREC * OCA->PRECOU ) * OCA->PERIPI ) / 100 ) 
                       aSOMA[3]+=OCA->QUANT_ 
                   ENDIF 
              CASE nOPCAO == 2 
                   IF OCA->SDOREC > 0 .AND.; 
                      OCA->ENTREG <= dDATA 
                      AADD( aOC, { OCA->ORDCMP,; 
                                   OCA->DESPRO,; 
                                   OCA->QUANT_,; 
                                   OCA->PRECOU,; 
                                   OCA->RECEBI,; 
                                   OCA->SDOREC,; 
                                   OCA->ENTREG } ) 
                       aSOMA[1]+=( OCA->SDOREC * OCA->PRECOU ) 
                       aSOMA[2]+=( ( ( OCA->SDOREC * OCA->PRECOU ) * OCA->PERIPI ) / 100 ) 
                       aSOMA[3]+=OCA->QUANT_ 
                   ENDIF 
           ENDCASE 
           @ 15,58 SAY STRZERO( RECNO(), 5, 0 ) 
           IF Len( aOC ) > 800 
              AADD( aOC, { "     ",; 
                           "Limite Maximo Excedido * IMPOSSIVEL EXIBIR MAIS!",; 
                           0,; 
                           0,; 
                           0,; 
                           0,; 
                           DATE() } ) 
              EXIT 
           ENDIF 
           DBSKIP() 
      ENDDO 
   ENDIF 
   DBSELECTAR( _COD_OC ) 
   @ 16,58 SAY STRZERO( RECNO(), 5, 0 ) 
   DBSKIP() 
ENDDO 
IF LEN( aOC )<1 
   aOC:={{'Vazio ',; 
          '************',; 
          '************',; 
          '************',; 
          '************',; 
          '************',; 
          '********'}} 
ENDIF 
//* Box Superior *// 
VPBOX( 0, 0, 03, 79, "ORDENS DE COMPRA PENDENTES", COR[20], .T., .T., COR[19] ) 
//* Box Central *// 
VPBox( 04, 00, 17, 79,; 
     IF( nOPCAO == 1, "Situacao at� "+DTOC( DATE() ),; 
                      "Projecao at� "+DTOC( dDATA ) ),; 
                      COR[20], .T., .T., COR[19] ) 
//* Box Inferior *// 
VPBOX( 18, 00, 22, 79, , COR[20], .F., .F., COR[19], .F. ) 
 
SETCURSOR( 0 ) 
SetColor( COR[20] ) 
//* Total *// 
@ 19,03 SAY "Sub-Total.: "+Tran( aSOMA[1], "@E 99,999,999.999" ) 
@ 20,03 SAY "IPI.......: "+Tran( aSOMA[2], "@E 99,999,999.999" ) 
@ 21,03 SAY "Total.....: "+Tran( aSOMA[1]+aSOMA[2], "@E 99,999,999.999" ) 
@ 02,03 SAY cDESFOR 
Mensagem("Pressione [I][TAB] para imprimir ou [ESC] para finalizar...") 
oTAB:=TBROWSENEW( 05, 01, 16, 78 ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW("OC", {|| aOC[nROW][1] } ) ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW("Produto", {|| PAD( aOC[nROW][2], 26 ) } ) ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW("Pendente", {|| Tran( aOC[nROW][6], "@E 9999.999" ) } ) ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW("Recebido", {|| Tran( aOC[nROW][5],   "@E 9999.999" ) } ) ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW(" Qtd. OC", {|| Tran( aOC[nROW][3], "@E 9999.999" ) } ) ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW("   Preco", {|| Tran( aOC[nROW][4], "@E 9,999.999" ) } ) ) 
oTAB:ADDCOLUMN( TBCOLUMNNEW("Previsao", {|| aOC[nROW][7] } ) ) 
oTAB:AUTOLITE:= .F. 
oTAB:GOTOPBLOCK:= {|| nROW:=1 } 
oTAB:GOBOTTOMBLOCK:= {|| nROW:= len( aOC ) } 
oTAB:SKIPBLOCK:= {|oMOVE| skipperarr( oMOVE, aOC, @nROW ) } 
oTAB:DEHILITE() 
OC->( dbSetOrder( 1 ) ) 
whil .t. 
   oTAB:COLORRECT( { oTAB:ROWPOS, 1, oTAB:ROWPOS, 7 }, { 2, 1 } ) 
   whil nextkey()==0 .and. ! oTAB:stabilize() 
   end 
 
   /* Busca Informacoes de Ordens de Compra */ 
   IF OC->( DBSeek( aOC[ nRow ][ 1 ] ) ) 
      @ 02,61 Say PAD( " Empresa: " + StrZero( OC->FILIAL, 03, 0 ), 15 ) 
   ELSE 
      @ 02,61 Say PAD( " Ordem s/informacoes ", 15 ) 
   ENDIF 
 
 
   TECLA:=inkey(0) 
   if TECLA==K_ESC   ;exit   ;endif 
   do case 
      case TECLA==K_UP         ;oTAB:up() 
      case TECLA==K_DOWN       ;oTAB:down() 
      case TECLA==K_LEFT       ;oTAB:PanLeft() 
      case TECLA==K_RIGHT      ;oTAB:PanRight() 
      case TECLA==K_PGUP       ;oTAB:pageup() 
      case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
      case TECLA==K_PGDN       ;oTAB:pagedown() 
      case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
      case CHR( Tecla ) $ "Ii" .OR. Tecla==K_TAB 
           Relatorio( "OCPENDEN.REP" ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
end 
FechaArquivos() 
SETCURSOR( 1 ) 
SETCOLOR( cCOR ) 
ScreenRest( cTELA ) 
RETURN NIL 
 
