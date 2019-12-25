// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC40000 
* Descricao   - Cadastro de Clientes 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function vpc40000()
#endif

loca cTELA:=zoom( 11, 34, 21, 54 ), cCOR:=setcolor(), nOPCAO:=0

DBSelectAr( _COD_CLIENTE) 
If !Used() 
   lFlag:=.T. 
   If !file(_VPB_CLIENTE) 
      aviso(" Arquivo de Clientes inexistente! ")
      createvpb( _COD_CLIENTE )
   end
end
AbreTabela( _COD_CLIENTE, _VPB_CLIENTE, 'CLI' )
vpbox( 11, 34, 21, 54 ) 
whil .t. 
   Mensagem("") 
   aadd( MENULIST, swmenunew( 12,35," 1 Edicao         ", 2, COR[11], "Inclusao de clientes.",,, COR[6],.T.)) 
                        @ 13,35 Say "-------------------"   Color COR[11] 
   aadd( MenuList, swmenunew( 14,35," 2 Pesquisa       ", 2, COR[11], "Pesquisa interativa de clientes.",,, COR[6],.T.)) 
   aadd( MENULIST, swmenunew( 15,35," 3 Complementos   ", 2, COR[11], "Informacoes complementares de clientes.",,, COR[6],.T.)) 
   aadd( MENULIST, swmenunew( 16,35," 4 Crediario      ", 2, COR[11], "Informacoes complementares de clientes.",,, COR[6],.T.)) 
   aadd( MENULIST, swmenunew( 17,35," 5 Informacoes    ", 2, COR[11], "Mais Informacoes complementares de clientes.",,, COR[6],.T.)) 
   aadd( MENULIST, swmenunew( 18,35," 6 Agenda         ", 2, COR[11], "Agenda do Cliente.",,, COR[6],.T.))
   aadd( MENULIST, swmenunew( 19,35," 7 Etiquetas      ", 2, COR[11], "Emissao de etiquetas para clientes.",,, COR[6],.T.)) 
   aadd( MENULIST, swmenunew( 20,35," 0 Retorna        ", 2, COR[11], "Retorna ao menu anterior.",,, COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO= 8; exit 
      case nOPCAO=1; Clientes() 
      case nOPCAO=2; CliPesquisa() 
      case nOpcao=3; CliComplemento() 
      case nOpcao=4; VPC41333() 
      case nOpcao=5; VPC41234() 
      case nOpcao=6; AgendaCliente()
      case nOpcao=7; VPC41235()
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return( nil ) 
 
Function AgendaCliente 
loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), oTB, nTecla, lFlag:=.F.,; 
     aPos:={ 08, 0, 22, 79 }, nArea:= Select(), nOrdem:= IndexOrd(),; 
     GetList:= {}, nOrd:= IndexOrd() 
Loca cObser1, cObser2, cObser3, cObser4, cObser5, nValorCred, dValid_ 
Local nTela:= 5 
Loca dDatInf 
DBSelectAr( _COD_CLIENTE) 
If !Used() 
   lFlag:=.T. 
   If !file(_VPB_CLIENTE) 
      aviso(" Arquivo de Clientes inexistente! ",24/2) 
      ajuda("[ENTER]Retorna") 
      Mensagem( "Pressione [ENTER] para retornar...",1) 
      pausa() 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
   If !fdbusevpb(_COD_CLIENTE) 
      aviso("ATENCAO! VerIfique o arquivo "+_VPB_CLIENTE+".",24/2) 
      Mensagem( "Erro na abertura do arquivo de Clientes, tente novamente...") 
      pausa() 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
EndIf 
 
   nRegistro:= CLI->( RECNO() ) 
   nPreReg:= PRE->( RECNO() ) 
   PRE->( DBSetOrder( 1 ) ) 
   nOrd:= IndexOrd() 
   setcolor(COR[16]) 
   VPBox( 0, 0, aPos[1]-1, 79, "AGENDA DE CLIENTES", _COR_GET_BOX, .F., .F. ) 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "Clientes", _COR_BROW_BOX, .F., .F. ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   CredLayOut( 5 ) 
   Mensagem( "[ESC]Retorna [ENTER]Alterar Agenda [TAB]Imprime Agenda") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna [F2..F5]Ordem") 
   DBLeOrdem() 
   DBGoTo( nRegistro ) 
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew(,{|| STRZERO( Codigo, 6, 0) + " " +  left(Descri,30) + " " +ENDERE+space(20)})) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   cAviso:= "Data limite de credito expirada! Renove!" 
   lRedisplay:= .T. 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
 
      CredDados( nTela ) 
 
      SetColor( _COR_BROWSE ) 
      nTecla:= inkey(0) 
      If nTecla=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTB:up() 
         case nTecla==K_DOWN       ;oTB:down() 
         case nTecla==K_PGUP       ;oTB:pageup() 
         case nTecla==K_PGDN       ;oTB:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
 
         case nTecla==K_TAB 
              F_GetDiaagenda() 
         case nTecla==K_ENTER 
              CredEdit( nTela ) 
 
         case DBPesquisa( nTecla, oTb ) 
         case nTecla==K_F2 
              DBMudaOrdem( 1, oTb ) 
         case nTecla==K_F3 
              DBMudaOrdem( 2, oTb ) 
         case nTecla==K_F4 
              DBMudaOrdem( 3, oTb ) 
         case nTecla==K_F5 
              DBMudaOrdem( 6, oTb ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
   PRE->( DBGoto( nPreReg ) ) 
DBSelectar( _COD_CLIENTE ) 
DBSetOrder( 1 ) 
If lFlag 
   CLI->( DBUnlock() ) 
   CLI->( DBCloseArea() ) 
EndIf 
Set( _SET_DELIMITERS, .T. ) 
IF !nArea==0 .AND. !nOrdem==0 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
ENDIF 
CLI->( DBGoTo( nRegistro ) ) 
Setcolor(cCOR) 
Setcursor(nCURSOR) 
Screenrest(cTELA) 
Return(.T.) 
 
Static Function F_GetDiaagenda() 
nReg:= RECNO() 
cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
cCorRes:= SetColor() 
nCursor:= SetCursor() 
dDataAge:= DATE() 
SetCursor( 1 ) 
VPBox( 06, 05, 09, 44, "Impressao da Agenda", _COR_GET_BOX ) 
SetColor( _COR_GET_EDICAO ) 
cSaida := "V" 
@ 07,06 Say "Data da Agenda: " Get dDataAge 
@ 08,06 Say "Saida          (V)ideo (I)mpressora" 
@ 08,18 get cSaida pict "@!" valid cSaida $ "VI" 
READ 
IF LastKey() <> K_ESC 
   if cSaida == "V" 
      Set( 24, "TELA0000.TMP" ) 
   else 
      Set( 24, "LPT1" ) 
   endif 
   Relatorio( "AGENDA.REP" ) 
   if cSaida == "V" 
      VerArquivo( "TELA0000.TMP" ) 
   endif 
   Set( 24, "LPT1" ) 
ENDIF 
DBGoTo( nReg ) 
ScreenRest( cTelaRes ) 
SetColor( cCorRes ) 
SetCursor( nCursor ) 
retu NIL 
*oTb:RefreshAll() 
*WHILE !oTb:Stabilize() 
*ENDDO 
