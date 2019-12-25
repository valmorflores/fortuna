// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function vpc91300()
#endif


loca cTELA:=zoom(15,24,21,50), cCOR:=setcolor(), nOPCAO:=0 
vpbox(15,24,21,50) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(16,25," 1 Integracao de Contas ",2,COR[11],; 
        "Integracao de contas a pagar x contas a receber.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(17,25," 2 Consulta             ",2,COR[11],; 
        "Consulta ao cadastro de contas a pagar e contas a receber.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(18,25," 3 Transferencias       ",2,COR[11],; 
        "Transfere valores entre contas.",,,COR[6],.T.)) 
 
   aadd(MENULIST,swmenunew(19,25," 4 Fluxo Mensal         ",2,COR[11],; 
        "Transfere valores entre contas.",,,COR[6],.T.)) 
 
   aadd(MENULIST,swmenunew(20,25," 0 Retorna              ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOPCAO=1; integracao() 
      case nOPCAO=2; vpc91800() 
      case nOpcao=3; VPC91900() 
      case nOpcao=4; Fluxo() 
 
   endcase 
enddo 
limpavar() 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
*********** 
** VPC91300 
** Integracao de Contas a Pagar x Contas a Receber. 
** Valmor Pereira Flores 
** 06/Fevereiro/1995 
*/ 
  Stat Func INTEGRACAO 
 
  loca cTELA:=screensave(00,00,nMAXLIN,nMAXCOL), cCOR:=setcolor() 
  loca nCURSOR:=setcursor(),; 
       dDATA1:= DATE(),; 
       dDATA2:= DATE(),; 
       aCTAPAGAR:= {},; 
       aCTARECEB:= {},; 
       aRESULTADO:= {},; 
       nARECEB:= 0,; 
       nAPAGAR:= 0,; 
       nCREIPI:= 0,; 
       nCREICM:= 0,; 
       nDEBICM:= 0,; 
       nDEBIPI:= 0,; 
       nCT:= 0,; 
       nPOS:= 0,; 
       oTAB, TECLA,; 
       nROW:= 1,; 
       nAcumulado:= 0 
 
  set(_SET_DELIMITERS,.F.) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
  if !file(_VPB_PAGAR) 
     set(_SET_DELIMITERS,.T.) 
     mensagem("Atencao, arq. de cta. a pagar inexistente, pres. [ENTER] p/ continuar...") 
     pausa() 
     screenrest(cTELA) 
     return nil 
  else 
     if !fdbusevpb(_COD_PAGAR) 
         set(_SET_DELIMITERS,.T.) 
         mensagem("Acesso as contas a pagar nao permitido...") 
         pausa() 
         screenrest(cTELA) 
         return nil 
     endif 
  endif 
  if !file(_VPB_NFISCAL) 
     set(_SET_DELIMITERS,.T.) 
     mensagem("Atencao, arq. de NF inexistente, pres. [ENTER] p/ continuar...") 
     pausa() 
     screenrest(cTELA) 
     return nil 
  else 
     if !fdbusevpb(_COD_NFISCAL) 
         set(_SET_DELIMITERS,.T.) 
         mensagem("Acesso as notas fiscais nao permitido, pressione [ENTER] p/ continuar...") 
         pausa() 
         screenrest(cTELA) 
         return nil 
     endif 
  endif 
  if !file(_VPB_DUPAUX) 
     set(_SET_DELIMITERS,.T.) 
     mensagem("Atencao, arq. de dupl. inexistente, pres. [ENTER] p/ continuar...") 
     pausa() 
     screenrest(cTELA) 
 
     return nil 
  else 
     if !fdbusevpb(_COD_DUPAUX) 
         set(_SET_DELIMITERS,.T.) 
         mensagem("Acesso as duplicatas nao permitido, pressione [ENTER] p/ continuar...") 
         pausa() 
         screenrest(cTELA) 
         return nil 
     endif 
  endif 
  VpBox( 04, 31, 11, 73, "RECEBER & PAGAR", _COR_GET_BOX, .T., .T., _COR_ALERTA_TITULO ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 05,32 SAY "Itervalo: " GET dDATA1 
  @ 05,52 SAY "ate" GET dDATA2 
  @ 06,32 SAY "���������������� ATENCAO ����������������" 
  @ 07,32 SAY "Este m�dulo � respons�vel pela compara��o" 
  @ 08,32 SAY "entre CONTAS A PAGAR e CONTAS  A RECEBER," 
  @ 09,32 SAY "dando como resultado a soma diaria de ca-" 
  @ 10,32 SAY "da uma delas.                            " 
  READ 
  IF LastKey()==K_ESC 
     ScreenRest( cTela ) 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     Return Nil 
  ENDIF 
 
  SETCOLOR( Cor[24] ) 
  DBSELECTAR( _COD_NFISCAL ) 
  DBGOTOP() 
  Mensagem( "Gravando registro. Aguarde..." ) 
  WHILE ! EOF() 
     IF DATAEM >= dData1 .AND. DATAEM <= dData2 .AND. NFNULA == SPAC(1) 
        Mensagem( "ICM/IPI: Registro #" + STRZERO( RECNO(), 4, 0 )+" = DEBITO." ) 
        IF ( VlrIpi + VlrIcm ) > 0 
           IF ENTSAI=="S" .OR. ENTSAI==" " 
              /* Debito de ICMs */ 
              nDEBIPI+= VLRIPI 
              nDEBICM+= VLRICM 
           ELSEIF ENTSAI=="E" 
              /* Credito de ICM */ 
              nCREIPI+= VLRIPI          //* Soma Credito de IPI *// 
              nCREICM+= VLRICM 
           ENDIF 
        ENDIF 
     ENDIF 
     DBSKIP() 
  ENDDO 
  DBSELECTAR( _COD_PAGAR ) 
  DBGOTOP() 
  WHILE ! EOF() 
     IF ( VlrIpi + VlrIcm ) > 0 
        Mensagem( "ICM/IPI: Registro #" + STRZERO( RECNO(), 4, 0 )+" = CREDITO." ) 
        IF DENTRA >= dData1 .AND.; 
           DENTRA <= dData2 
           Mensagem( "Gravando registro. Aguarde..." ) 
           nCREIPI+= VlrIpi 
           nCREICM+= VlrIcm 
        ENDIF 
     ENDIF 
     DBSKIP() 
  ENDDO 
  DBSELECTAR(_COD_DUPAUX) 
  DBGOTOP() 
  WHILE ! EOF() 
     IF LastKey() == K_ESC .OR. NextKey() == K_ESC 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        Set( _SET_DELIMITERS, .T. ) 
        Return Nil 
     ENDIF 
     Mensagem("Processando registro #"+strzero(recno(),4,0)+", aguarde....") 
     IF DTQT__ == CTOD("  /  /  ") 
        IF !VLR___ == 0 .AND. VENC__ < dDATA1 .AND. NFNULA == " " 
           nAcumulado+= VLR___ 
        ENDIF 
        IF VLR___ <> 0 .AND.; 
           VENC__ >= dDATA1 .AND. VENC__ <= dDATA2 .AND.; 
           NFNULA == " " 
           AADD( aCTARECEB, { VLR___, VENC__ } ) 
        ENDIF 
     ENDIF 
     DBSKIP() 
  ENDDO 
  DBSELECTAR( _COD_PAGAR ) 
  DBGOTOP() 
  WHILE ! EOF() 
       IF LastKey() == K_ESC .OR. NextKey() == K_ESC 
          SetColor( cCor ) 
          SetCursor( nCursor ) 
          ScreenRest( cTela ) 
          set(_SET_DELIMITERS,.T.) 
          Return Nil 
       ENDIF 
     IF _FIELD->DATAPG == CTOD( "  /  /  " ) 
 
        /* Acumulado at� a data inicial */ 
        IF _FIELD->VENCIM < dData1 .AND.; 
           _FIELD->VALOR_ <> 0 
           nAcumulado-= _FIELD->VALOR_ 
        ENDIF 
 
        /* Captacao dos dados */ 
        IF _FIELD->VENCIM >= dDATA1 .AND.; 
           _FIELD->VENCIM <= dDATA2 .AND.; 
           _FIELD->VALOR_ <> 0 
           AADD( aCTAPAGAR, { _FIELD->VALOR_,; 
                              _FIELD->VENCIM } ) 
        ENDIF 
     ENDIF 
     DBSKIP() 
  ENDDO 
 
  /* CONTAS A PAGAR */ 
  FOR nCT:= 1 TO LEN( aCTAPAGAR ) 
        IF LastKey() == K_ESC .OR. NextKey() == K_ESC 
           SetColor( cCor ) 
           SetCursor( nCursor ) 
           ScreenRest( cTela ) 
           Set(_SET_DELIMITERS,.T.) 
           Return Nil 
        ENDIF 
      Mensagem("CONTAS A PAGAR: Processando registro #"+strzero(nCT,4,0)+", aguarde...") 
      /* Somat�rio de ctas. a pagar p/ vencimento */ 
      IF ( nPOS:= ASCAN( aRESULTADO, {|MATRIZ| MATRIZ[5]=aCTAPAGAR[nCT][2] } ) ) > 0 
         aRESULTADO[nPOS][3]+= aCTAPAGAR[nCT][1] 
         aRESULTADO[nPOS][4]= aRESULTADO[nPOS][2] - aRESULTADO[nPOS][3] 
      ELSE 
         AADD( aRESULTADO,; 
             { Semana( aCTAPAGAR[nCT][2] ) + ", " + ; 
               ALLTRIM( STR( DAY( aCTAPAGAR[nCT][2] ) ) ) + " de " + ; 
               Mes( MONTH( aCTAPAGAR[nCT][2] ) ) + " de " + ; 
               STRZERO( YEAR( aCTAPAGAR[nCT][2] ), 4, 0 ), ; //* Dia *// 
               0,;                                           //* Receber *// 
               aCTAPAGAR[nCT][1],;                           //* Pagar *// 
               0,;                                           //* Receber + Pagar *// 
               aCTAPAGAR[nCT][2],;                           //* Data *// 
               0 } ) 
      ENDIF 
  NEXT 
 
  /* CONTAS A RECEBER */ 
  FOR nCT:= 1 TO LEN( aCTARECEB ) 
        IF LastKey() == K_ESC .OR. NextKey() == K_ESC 
           SetColor( cCor ) 
           SetCursor( nCursor ) 
           ScreenRest( cTela ) 
           Set(_SET_DELIMITERS,.T.) 
           Return Nil 
        ENDIF 
      Mensagem("CONTAS A RECEBER: Processando registro #"+strzero(nCT,4,0)+", aguarde...") 
      /* Somat�rio de ctas. a receber p/ vencimento */ 
      IF ( nPOS:= ASCAN( aRESULTADO, {|MATRIZ| MATRIZ[5]=aCTARECEB[nCT][2] } ) ) > 0 
         aRESULTADO[nPOS][2]+=aCTARECEB[nCT][1] 
         aRESULTADO[nPOS][4]= aRESULTADO[nPOS][2] - aRESULTADO[nPOS][3] 
      ELSE 
         AADD( aRESULTADO,; 
             { Semana( aCTARECEB[nCT][2] ) + ", " + ; 
               ALLTRIM( STR( DAY( aCTARECEB[nCT][2] ) ) ) + " de " + ; 
               Mes( MONTH( aCTARECEB[nCT][2] ) ) + " de " + ; 
               STRZERO( YEAR( aCTARECEB[nCT][2] ), 4, 0 ), ; //* Dia *// 
               aCTARECEB[nCT][1],;                           //* Receber *// 
               0,;                                           //* Pagar *// 
               0,;                                           //* Receber + Pagar *// 
               aCTARECEB[nCT][2],;                           //* Data *// 
               0 } ) 
      ENDIF 
  NEXT 
  //* Organizacao da matriz aRESULTADO *// 
  aRESULTADO:= ASORT( aRESULTADO, , ,{|x,y| x[5] < y[5] } ) 
 
  //* Soma das contas *// 
  FOR nCT:=1 TO LEN( aRESULTADO ) 
      nARECEB+= aRESULTADO[nCT][2]   //* Soma CONTAS A RECEBER *// 
      nAPAGAR+= aRESULTADO[nCT][3]   //* Soma CONTAS A PAGAR *// 
 
      /* Resultado diario */ 
      aResultado[ nCt ][4]= aResultado[ nCt ][ 2 ] - aResultado[ nCt ][ 3 ] 
 
      /* Fazendo lancamento no campo acumulado */ 
      aResultado[ nCt ][6]= nAcumulado + aResultado[ nCt ][ 4 ] 
      nAcumulado:= aResultado[ nCt ][ 6 ] 
  NEXT 
 
  VPBOX( 02, 04, 20, 73, "Verificacao", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
  SetColor( _COR_BROWSE ) 
  DISPBOX( 12, 05, 12, 72, 1 ) 
  DISPBOX( 16, 05, 16, 72, 1 ) 
  @ 13,05 SAY "Total a Receber: "+Tran( nARECEB, "@E 999,999,999.99" ) 
  @ 14,05 SAY "Total a Pagar..: "+Tran( nAPAGAR, "@E 999,999,999.99" ) 
  @ 15,05 SAY "Saldo..........: "+Tran( nARECEB-nAPAGAR, "@E 999,999,999.99" ) 
  @ 16,32 SAY "<< IPI >>������������<< ICMs >>" 
  @ 17,05 SAY "Cr�dito........: "+; 
                     Tran( nCREIPI, "@E 999,999,999.99" ) + SPAC( 6 ) + ; 
                     Tran( nCREICM, "@E 999,999,999.99" ) 
  @ 18,05 SAY "Debito.........: "+; 
                     Tran( nDEBIPI, "@E 999,999,999.99" ) + SPAC( 6 ) + ; 
                     Tran( nDEBICM, "@E 999,999,999.99" ) 
  @ 19,05 SAY "Saldo..........: "+; 
                     Tran( nCREIPI - nDEBIPI, "@EXC 999,999,999.99" ) + SPAC( 3 ) + ; 
                     Tran( nCREICM - nDEBICM, "@EXC 999,999,999.99" ) 
 
 
  if Len( aResultado ) = 0 
     SetColor( "15/03" ) 
     VPObsBox( .T., 07, 15, "Atencao", { " Nao existe movimento de contas a pagar  ou " ,; 
                                         " contas a receber durante o periodo que foi " ,; 
                                         " selecionado." } ) 
     Pausa() 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     FechaArquivos() 
     Set(_SET_DELIMITERS,.T.) 
     Return Nil 
  Endif 
  Mensagem( "[TAB]Imprimir [G]Gr�fico. Pressione ESC para sair..." ) 
  oTAB:=TBROWSENEW( 03, 05, 11, 72) 
  oTAB:ADDCOLUMN( TBCOLUMNNEW("Data",      {|| aRESULTADO[nROW][5] } ) ) 
  oTAB:ADDCOLUMN( TBCOLUMNNEW("A Receber", {|| Tran( aRESULTADO[nROW][2], "@E 999,999,999.99" ) } ) ) 
  oTAB:ADDCOLUMN( TBCOLUMNNEW("A Pagar",   {|| Tran( aRESULTADO[nROW][3], "@E 999,999,999.99" ) } ) ) 
  oTAB:ADDCOLUMN( TBCOLUMNNEW("Resultado", {|| Tran( aRESULTADO[nROW][4], "@E 999,999,999.99" ) } ) ) 
  oTAB:ADDCOLUMN( TBCOLUMNNEW("Acumulado", {|| Tran( aRESULTADO[nROW][6], "@E 999,999,999.99" ) } ) ) 
  oTAB:AUTOLITE:= .F. 
  oTAB:GOTOPBLOCK:= {|| nROW:=1 } 
  oTAB:GOBOTTOMBLOCK:= {|| nROW:= len( aRESULTADO ) } 
 
  oTAB:SKIPBLOCK:= {|oMOVE| skipperarr( oMOVE, aRESULTADO, @nROW ) } 
  oTAB:DEHILITE() 
  whil .t. 
     oTAB:COLORRECT( { oTAB:ROWPOS, 1, oTAB:ROWPOS, 4 }, { 2, 1 } ) 
     whil nextkey()==0 .and. ! oTAB:stabilize() 
     end 
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
        case TECLA==K_TAB 
             IF Confirma( 0, 0, "Confirma a Impressao do Resumo?", "[S]Imprime [ESC][N]Cancela.", "S" ) 
                aRes:= aResultado 
                Relatorio( "PAGREC.REP" ) 
                Release aRes 
             ENDIF 
        case CHR( TECLA ) $ "Gg" 
             cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
             cCorRes:= SetColor() 
             VPBox( 10, 09, 18, 62, "Gr�fico de Compara�ao no dia " + DTOC( aResultado[ nRow ][ 5 ] ), "15/01", .T., .T., "00/15" ) 
             nIndice:= aResultado[ nRow ][ 2 ] + aResultado[ nRow ][ 3 ] 
             nGrafico1:= ( aResultado[ nRow ][ 2 ] / nIndice ) * 50 
             nGrafico2:= ( aResultado[ nRow ][ 3 ] / nIndice ) * 50 
             SetColor( "BG+/B" ) 
             @ 12,11 Say "Contas a Receber + " + Tran( aResultado[ nRow ][ 2 ], "@e ***,***,***.**" ) + " " + Str( nGrafico1 * 2, 3, 0 ) + "%" 
             @ 13,11 Say "Contas a Pagar   - " + Tran( aResultado[ nRow ][ 3 ], "@e ***,***,***.**" ) + " " + Str( nGrafico2 * 2, 3, 0 ) + "%" 
             @ 14,11 Say "Resultado        = " + Tran( aResultado[ nRow ][ 4 ], "@e ***,***,***.**" ) 
 
             @ 15,11 Say Repl( "�", 50 ) 
             @ 16,11 Say "Representacao grafica" 
             SetColor( "G" ) 
             @ 12,57 Say Replicate( "�", 3 ) 
             @ 17,11 Say Replicate( "�", nGrafico1 ) 
             SetColor( "R+" ) 
             @ Row(), Col() Say Replicate( "�", nGrafico2 ) 
             @ 13,57 Say Replicate( "�", 3 ) 
             SetCursor( 0 ) 
             keyboard Chr( Inkey(0) ) 
             SetColor( cCorRes ) 
             ScreenRest( cTelaRes ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  end 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Set(_SET_DELIMITERS,.T.) 
  Return Nil 
  FechaArquivos() 
  return nil 
 
