// ## CL2HB.EXE - Converted
/* 
* Modulo      - VPC20000 
* Descricao   - COMPRAS 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 10/Abril/1995 
*/ 
#include "VPF.CH" 
#include "INKEY.CH" 

#ifdef HARBOUR
function vpc50000()
#endif


loca cTELA:=zoom(14,14,20,38), cCOR:=setcolor(), nOPCAO:=0
vpbox(14,14,20,38) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(15,15," 1 Ordem Compra       ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de Ordens de compra.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew(16,15," 2 Preco Compra       ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de precos de compra.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew(17,15," 3 Nota Fiscal        ",2,COR[11],; 
        "Inclusao, alteracao, verificacao e exclusao de Notas de Entrada/Compra.",,,; 
        COR[6],.T.))
   aadd(MENULIST,menunew(18,15," 4 Cotacao de Precos  ",2,COR[11],; 
        "Cotacao de precos de compra x fornecedor com base nas tabelas de precos.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew(19,15," 0 Retorna            ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOPCAO=1; do VPC51999 
      case nOPCAO=2; Precos() 
      case nOpcao==3; vpc95300()
      case nOpcao==4; CompraCotacao()
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
/* 
** PRECOS 
** Menu de Atualizacao de Precos 
** Valmor Pereira Flores 
** 08/Fevereiro/1995 
*/ 
stat func Precos 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), nOPCAO:=nOPCAO1:=0 
vpbox(11,24,16,42) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(12,25," 1 Manual       ",2,COR[11],; 
        "Atualizacao manual de preco por fornecedor.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew(13,25," 2 Percentual   ",2,COR[11],; 
        "Atualiza‡„o autom tica de pre‡o por fornecedor.",,,; 
        COR[6],.T.))
   aadd(MENULIST,menunew(14,25," 3 Especial     ",2,COR[11],; 
        "Atualiza‡„o autom tica de pre‡o por fornecedor.",,,; 
        COR[6],.T.)) 
   aadd(MENULIST,menunew(15,25," 0 Retorna      ",2,COR[11],; 
        "Retorna ao menu anterior.",,,; 
        COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   if nOPCAO=0 .OR. nOPCAO=4 ;exit ;endif 
   cTELA1:=screensave(00,00,24,79) 
   do case 
      case nOPCAO=1; Atualiza(2) 
      case nOPCAO=2; Atualiza(3)
      case nOpcao==3; Atualiza(4)
   endcase 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return nil 
 
stat func Atualiza(nFORMA) 
loca cTELA:=screensave(00,00,24,79),; 
     cCOR:=setcolor(), nCURSOR:=setcursor() 
do case 
   case nFORMA=2 ;Produtos() 
   case nFORMA=3 ;ProdPerc()
   case nForma==4; ProdVenda()
endcase 
return nil 
 
stat func Produtos() 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor() 
  loca nARQUIVO:=0, FLAG:=.T. 
  loca nVALOR_:=0 
  loca oTP, oTF, aFORNECEDOR:={}, aPRODUTO:={}, nTECLA 
  loca cVARIAVEL, cMASCAR, nQUANT_, nDECIM_, nQUEST_, cVERIF_,; 
       dDATA__, cHORA__, nUSUAR_, cQUEST_ 
  // nAREA:=select(), nORDEM:=indexord() 
  //* VARIAVEIS P/ TRATAMENTO DO CODIGO DE PRODUTO *// 
  loca _cMRESER 
  Priv _PIGRUPO,_QTGRUPO,_PICODIG,_QTCODIG 
  Priv nORDEMG:=1 
  priv cMASCACOD, cxMASCACOD, cxMASCPREC 
  priv nORDEMG:=1 
  if !file(_VPB_CONFIG) 
     createvpb(_COD_CONFIG) 
     mensagem("Criando arq. de <mascaras> com configuracao normal, aguarde...") 
     if !fdbusevpb(_COD_CONFIG,2) 
        aviso("ATENCAO! Verifique o arquivo "+; 
           alltrim(_VPB_CONFIG)+".",24/2) 
        mensagem("Erro na abertura do arquivo de configuracao,"+; 
                 " tente novamente...") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     endif 
     for nCT:=1 to 5 
        cVARIAVEL:=cMASCAR:="" 
        nQUANT_:=nDECIM_:=0 
        nQUEST_:=cVERIF_:="" 
        dDATA__:=date() 
        cHORA__:="" 
        nUSUAR_:=0 
        cQUEST_:=" " 
        do case 
           case nCT=1 
                cVARIAVEL:="cMASCACOD" 
                cMASCAR:="GGG-NNNN.V" 
                cVERIF_:="S" 
           case nCT=2 
                cVARIAVEL:="cMASCQUAN" 
                cMASCAR:="999.999,99" 
           case nCT=3 
                cVARIAVEL:="cMASCPREC" 
                cMASCAR:="999.999.999,99" 
           case nCT=4 
                cVARIAVEL:="cORIGEM" 
                cQUEST_:="S" 
           case nCT=5 
                cVARIAVEL:="cASSOCIAR" 
                cQUEST_:="S" 
        endcase 
        dbgotop() 
        locate for alltrim(VARIAV)=cVARIAVEL 
        if eof() 
           if !buscanet(5,{|| dbappend(), !neterr()}) 
              mensagem("::: ERRO NA GRAVACAO DOS DADOS :::") 
              screenrest(cTELA) 
              setcolor(cCOR) 
              setcursor(nCURSOR) 
           endif 
        endif 
        * GRAVACAO DOS DADOS * 
        if netrlock() 
           repl VARIAV with cVARIAVEL, QUANT_ with nQUANT_,; 
                DECIM_ with nDECIM_,   MASCAR with cMASCAR,; 
                VERIF_ with cVERIF_,   DATA__ with date(),; 
                HORA__ with time(),    USUAR_ with nGCODUSER,; 
                QUEST_ with cQUEST_ 
        endif 
     next 
  else 
     if !fdbusevpb(_COD_CONFIG,2) 
        aviso("ATENCAO! Verifique o arquivo "+; 
             alltrim(_VPB_CONFIG)+".",24/2) 
        mensagem("Erro na abertura do arq. de configuracao, tente novamente.") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     endif 
  endif 
  //* MASCARA P/ CODIGO DO PRODUTO *// 
  locate for VARIAV="cMASCACOD" 
  cMASCACOD:=MASCAR 
  cVERIF_:=VERIF_ 
  //* MASCARA P/ VALORES (PRECOS) *// 
  locate for VARIAV="cMASCPREC" 
  cMASCPREC:=MASCAR 
  //* ABERTURA DO ARQUIVO DE FORNECEDORES *// 
  if !file(_VPB_FORNECEDOR) 
     mensagem("Arquivo de fornecedores nao encontrado,"+; 
              " pressione ENTER para continuar...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !fdbusevpb(_COD_FORNECEDOR,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de fornecedores, tente novamente...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  //  set filter to TIPO__="1" 
  //* ABERTURA DO ARQUIVO DE PRECOS X FORNECEDORES *// 
  if !file(_VPB_PRECOXFORN) 
     mensagem("Criando arquivo de precos x fornecedores, aguarde...") 
     createvpb(_COD_PRECOXFORN) 
  endif 
  if !fdbusevpb(_COD_PRECOXFORN,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de precos x fornecedores...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  //* ABERTURA DO ARQUIVO DE MATERIA PRIMA *// 
  if ! file(_VPB_MPRIMA) 
     createvpb(_COD_MPRIMA) 
  endif 
  if !fdbusevpb(_COD_MPRIMA) 
     aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_MPRIMA)+".",24/2) 
     mensagem("Erro na abertura do arq. de MATERIA PRIMA, tente novamente...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  _cMRESER:=strtran(cMASCACOD,".","") 
  _cMRESER:=strtran(_cMRESER,"-","") 
  _cMRESER:=alltrim(_cMRESER) 
  _PIGRUPO:=at("G",_cMRESER) 
  _QTGRUPO:=StrVezes("G",_cMRESER) 
  _PICODIG:=at("N",_cMRESER) 
  _QTCODIG:=StrVezes("N",_cMRESER) 
  //* MONTAGEM DAS VARIAVEIS (MASCARAS) *// 
  cxMASCACOD:=mascstr(cMASCACOD,1) 
  //cxMASCQUAN:=mascstr(cMASCQUAN,2) 
  cxMASCPREC:=mascstr(cMASCPREC,2) 
  cCODIGO:=strtran(cxMASCACOD,".","") 
  cCODIGO:=strtran(cCODIGO,"-","") 
  cCODIGO:=alltrim(cCODIGO) 
  cCODIGO:=strtran(cCODIGO,"9"," ") 
  cINDICE:=substr(cCODIGO,_PIGRUPO,_QTGRUPO)+; 
           substr(cCODIGO,_PICODIG,_QTCODIG) 
  cCODRED:=substr(cCODIGO,_PICODIG,_QTCODIG) 
  dbselectar(_COD_FORNECEDOR) 
  DbGoTop() 
  dbselectar(_COD_PRECOXFORN) 
  dbgotop() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
 
  dbselectar(_COD_MPRIMA) 
  dbsetorder(5) 
  set relation to INDICE into PXF, CODFOR into FOR 
  lALTERAPOS:=.T. 
  dbgotop() 
  setcursor(0) 
  setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
  vpbox(0,41,24-6,79,"Produtos",COR[21],.F.,.F.) 
  vpbox(0,0,24-6,40,"Fornecedores",COR[21],.F.,.F.) 
  vpbox(24-5, 0, 24-2,79,"Informacoes",COR[21],.F.,.F.) 
  cBOXR2:=boxsave(01,41,24-6,79-1) 
  cBOXR1:=boxsave(01,01,24-6,40) 
 
  nCODFOR=FOR->CODIGO 
  ajuda("["+_SETAS+"][PgDn][PgUp]Move [Tab][Enter]Arquivo [Nome]Pesquisa [ESC]Cancela") 
  oTP:=tbrowsedb(01,42,24-7,79-1) 
  oTP:addcolumn(tbcolumnnew(,{|| substr(MPR->INDICE,1,7)+"=>"+; 
      substr(MPR->CODFAB,1,12)+; 
      if( MPR->CODFOR==nCODFOR,; 
          tran(PXF->VALOR_,"@E 999,999,999.999"),; 
          "<Sem Produtos> ")+; 
      BUSCA_})) 
  oTF:=tbrowsedb(01,01,24-7,39) 
  oTF:addcolumn(tbcolumnnew(,{|| strzero(FOR->CODIGO,4,0)+"=>"+; 
                                  substr(FOR->DESCRI,1,33)})) 
  oTP:AUTOLITE:=.F. 
  oTP:dehilite() 
  oTF:AUTOLITE:=.F. 
  oTF:dehilite() 
  oTF:GoTop() 
 
  DBSelectAr( _COD_FORNECEDOR ) 
  DBGotop() 
  oTF:Up() 
  oTF:RefreshAll() 
  WHILE !oTF:Stabilize() 
  ENDDO 
 
  whil .t. 
      if nARQUIVO=0 
         if lALTERAPOS 
             dbselectar(_COD_FORNECEDOR) 
             oTF:Refreshall() 
             Whil ! oTF:Stabilize() 
             EndDo 
             mensagem("Pressione [TAB] para selecionar fornecedor...") 
             ajuda("["+_SETAS+"][PgDn][PgUp]Move [Nome/Codigo]Pesquisa [TAB]Produtos [ESC]Fim") 
             lALTERAPOS:=.F. 
         endif 
         oTF:colorrect({oTF:ROWPOS,1,oTF:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTF:stabilize() 
         enddo 
      elseif nARQUIVO=1 
         dbselectar(_COD_MPRIMA) 
         if lALTERAPOS 
            set relation to INDICE into PXF, CODFOR into FOR 
            lALTERAPOS:=.F. 
            mensagem("Digite o valor com o cursor sobre o produto...") 
            ajuda("["+_SETAS+"][PgDn][PgUp]Move [Nome]Pesquisa [1234567890]Preco [TAB]Forn. [ESC]Fim") 
         endif 
         oTP:colorrect({oTP:ROWPOS,1,oTP:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTP:stabilize() 
         enddo 
         nCODPRO=val(MPR->CODRED) 
         @ 24-4,02 Say "Produto: "+MPR->DESCRI 
         if MPR->SALDO_< MPR->ESTMIN 
            @ 24-3,42 say "                                   " 
            @ 24-3,42 say "Prod. abaixo do estoque m¡nimo: " + alltrim(str(MPR->SALDO_,5,0)) 
         else 
            @ 24-3,42 say "                                   " 
            @ 24-3,42 say "Saldo do produto: "+alltrim(str(MPR->SALDO_,5,0)) 
         endif 
      endif 
      nTECLA:=inkey(0) 
      If nTECLA=K_ESC; exit; endif 
      do case 
         case nTECLA==K_UP         ;if(nARQUIVO=0,oTF:up(),oTP:up()) 
         case nTECLA==K_DOWN       ;if(nARQUIVO=0,oTF:down(),oTP:down()) 
         case nTECLA==K_PGUP       ;if(nARQUIVO=0,oTF:pageup(),oTP:pageup()) 
         case nTECLA==K_PGDN       ;if(nARQUIVO=0,oTF:pagedown(),oTP:pagedown()) 
         case nTECLA==K_HOME       ;if(nARQUIVO=0,oTF:gotop(),oTP:gotop()) 
         case nTECLA==K_END        ;if(nARQUIVO=0,oTF:gobottom(),oTP:gobottom()) 
         case upper(chr(nTECLA))$"ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*))_+|" 
              If nARQUIVO=0 
                 cDESFOR:=Spac(45) 
                 cTELA0:=ScreenSave(00,00,24,79) 
                 VpBox(18,03,20,65) 
                 keyboard chr(nTECLA) 
                 mensagem("Digite o nome do fornecedor para pesquisa.") 
                 @ 19,04 Say "Fornecedor:" Get cDESFOR Pict "@!" 
                 Read 
                 aviso("Aguarde. Pesquisando...",24/2) 
                 mensagem("Aguarde a procura do fornecedor...") 
                 Set(_SET_SOFTSEEK,.T.) 
                 DbSetOrder(2) 
                 oTF:GoTop() 
                 DbSeek(cDESFOR) 
                 Set(_SET_SOFTSEEK,.F.) 
                 ScreenRest(cTELA0) 
                 oTF:RefreshAll() 
                 Whil ! oTF:Stabilize() 
                 EndDo 
              ElseIf nARQUIVO=1 
                 cTELA0:=ScreenSave(00,00,24,79) 
                 VpBox(18,40,20,75) 
                 cDESPRO:=Spac(15) 
                 keyboard chr(nTECLA) 
                 mensagem("Digite o codigo de fabrica do produto para pesquisa.") 
                 @ 19,42 Say "Produto:" Get cDESPRO Pict "@!" 
                 Read 
                 aviso("Aguarde. Pesquisando...",24/2) 
                 mensagem("Aguarde a procura do produto...") 
                 Set(_SET_SOFTSEEK,.T.) 
                 DbSetOrder(4) 
                 oTP:GoTop() 
                 DbSeek(cDESPRO) 
                 Set(_SET_SOFTSEEK,.F.) 
                 ScreenRest(cTELA0) 
                 oTP:RefreshAll() 
                 Whil ! oTP:Stabilize() 
                 EndDo 
              Endif 
         case chr(nTECLA)$"1234567890.," 
              If nARQUIVO=0 
                 nCODFOR:=0 
                 cTELA0:=ScreenSave(00,00,24,79) 
                 VpBox(18,03,20,25) 
                 keyboard chr(nTECLA) 
                 mensagem("Digite o codigo do fornecedor para pesquisa.") 
                 @ 19,04 Say "Codigo:" Get nCODFOR Pict "@!" 
                 Read 
                 aviso("Aguarde. Pesquisando...",24/2) 
                 mensagem("Aguarde a busca ao fornecedor...") 
                 Set(_SET_SOFTSEEK,.T.) 
                 DbSetOrder(1) 
                 oTF:GoTop() 
                 DbSeek(nCODFOR) 
                 Set(_SET_SOFTSEEK,.F.) 
                 ScreenRest(cTELA0) 
                 oTF:RefreshAll() 
                 Whil ! oTF:Stabilize() 
                 EndDo 
              ElseIf nARQUIVO=1 
                 cTELA0:=ScreenSave(00,00,24,79) 
                 cINDICE:=INDICE 
                 If nTECLA<>K_ENTER 
                    keyboard chr(nTECLA) 
                 EndIf 
                 set(_SET_DELIMITERS,.F.) 
                 mensagem("Digite o preco cobrado pelo fornecedor para este produto.") 
                 @ (oTP:ROWPOS),63 get nVALOR_ pict "@E 999,999,999.999" 
                 read 
                 aviso("Atualizando arquivo de precos, aguarde...",24/2) 
                 set(_SET_DELIMITERS,.T.) 
                 nAREA:=select() 
                 dbselectar(_COD_PRECOXFORN) 
                 nOrd:=INDEXORD() 
 
                 /* Procura codigo */ 
                 DBSetOrder( 1 ) 
                 IF !DBSeek( MPr->Indice ) 
                    DBAppend() 
                 ENDIF 
                 IF NetRLock(5) 
                    repl CPROD_ with cINDICE,; 
                         CODFOR with nCODFOR,; 
                         PVELHO With VALOR_,; 
                         VALOR_ with nVALOR_,; 
                         DATA__ With Date() 
                 ENDIF 
 
                 DBSetOrder( nOrd ) 
                 dbselectar(nAREA) 
                 nREGISTRO:=recno() 
                 dbgobottom() 
                 nULTIMO:=recno() 
                 dbgoto(nREGISTRO) 
 
                 /* esta parte estava desabilitada */ 
                 //set relation to INDICE into PXF, CODFOR into FOR 
 
                 ScreenRest(cTELA0) 
                 oTP:down() 
                 oTP:refreshcurrent() 
                 whil ! oTP:stabilize() 
                 enddo 
              endif 
         case nTECLA=K_TAB .OR. nTECLA=K_ENTER 
              if nARQUIVO=0 
                 cTELAR1:=screensave(24-7,00,24,79) 
                 aviso("Pesquisando produtos p/ fornecedores...",24-5) 
                 mensagem("Aguarde pesquisa de dados ou pressione [ESC] para sair...",1) 
                 nCODFOR=CODIGO 
                 @ 21,02 say "Fornecedor#"+strzero(nCODFOR,4,0) 
                 dbselectar(_COD_MPRIMA) 
                 cCODIND:=StrZero(nCODFOR,3,0) 
                 //If(file(GDIR-"\MPRIND01."+cCODIND,FErase(GDIR-"\MPRIND01."+cCODIND),NIL) 
                 //If(file(GDIR-"\MPRIND02."+cCODIND,FErase(GDIR-"\MPRIND02."+cCODIND),NIL) 
                 //If(file(GDIR-"\MPRIND03."+cCODIND,FErase(GDIR-"\MPRIND03."+cCODIND),NIL) 
                 //If(file(GDIR-"\MPRIND04."+cCODIND,FErase(GDIR-"\MPRIND04."+cCODIND),NIL) 
                 //If(file(GDIR-"\MPRIND05."+cCODIND,FErase(GDIR-"\MPRIND05."+cCODIND),NIL) 
                 cINDICE1:="&GDIR\MPRIND01."+cCODIND 
                 cINDICE2:="&GDIR\MPRIND02."+cCODIND 
                 cINDICE3:="&GDIR\MPRIND03."+cCODIND 
                 cINDICE4:="&GDIR\MPRIND04."+cCODIND 
                 cINDICE5:="&GDIR\MPRIND05."+cCODIND 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On INDICE        To &cINDICE1 For CODFOR=nCODFOR 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On Upper(DESCRI) To &cINDICE2 For CODFOR=nCODFOR 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On CODRED        To &cINDICE3 For CODFOR=nCODFOR 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On Upper(CODFAB) To &cINDICE4 For CODFOR=nCODFOR 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On CODFOR        To &cINDICE5 For CODFOR=nCODFOR 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Set Index To &cINDICE1, &cINDICE2, &cINDICE3, &cINDICE4, &cINDICE5 
                 Set Relation To INDICE Into PXF, CODFOR Into FOR 
                 ScreenRest(cTELAR1) 
                 oTP:GoTop() 
                 oTP:RefreshAll() 
                 Whil ! oTP:Stabilize() 
                 EndDo 
              endif 
              if nARQUIVO=0 
                 boxrest(cBOXR1) 
                 vpbox(0,41,24-6,79,"Produtos",COR[20],.F.,.F.,COR[19]) 
                 oTP:RefreshAll() 
                 nARQUIVO:=1 
              elseif nARQUIVO=1 
                 boxrest(cBOXR2) 
                 vpbox(0,0,24-6,40,"Fornecedores",COR[20],.F.,.F.,COR[19]) 
                 oTF:RefreshAll() 
                 nARQUIVO:=0 
              endif 
              lALTERAPOS:=.T. 
         otherwise                ;tone(125); tone(300) 
      endcase 
      if nARQUIVO=0 
         nCODFOR=FOR->CODIGO 
         @ 21,02 say "Fornecedor#"+strzero(nCODFOR,4,0) 
         oTF:refreshcurrent() 
         oTF:stabilize() 
      elseif nARQUIVO=1 
         oTP:refreshcurrent() 
         oTP:stabilize() 
      endif 
  enddo 
  DBSelectAr( _COD_MPRIMA ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/mprind01.ntx", "&gdir/mprind02.ntx", "&gdir/mprind03.ntx", "&gdir/mprind04.ntx", "&gdir/mprind05.ntx"      
  #else 
    Set Index To "&GDir\MPRIND01.NTX", "&GDir\MPRIND02.NTX", "&GDir\MPRIND03.NTX", "&GDir\MPRIND04.NTX", "&GDir\MPRIND05.NTX"      
  #endif
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
  return(.T.) 
 
 
 
stat func PRODPERC 
 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cAlteraVenda:= "S" 
 
Loca nCODFOR:=0, nPERCEN:=0 
If !file(_VPB_PRECOXFORN) 
   MENSAGEM("Arquivo de precos inexistente...") 
   PAUSA() 
   screenrest(cTELA) 
   RETURN NIL 
endif 
if !fdbusevpb(_COD_PRECOXFORN,2) 
   aviso("ATENCAO! Verifique o arquivo "+; 
   alltrim(_VPB_FORNECEDOR)+".",24/2) 
   mensagem("Erro na abertura do arq. de precos x fornecedores...") 
   pausa() 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
   return(NIL) 
endif 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERMODULO("ATUALIZACAO DE PRECOS DE COMPRA (Por fornecedor)") 
VPBOX(03,35,13,73,"Atualizacao de Precos") 
@ 04,36 Say "Fornecedor.....:" get nCODFOR Pict "9999" 
@ 05,36 Say "Percentual.....:" get nPERCEN Pict "9999.99" 
 
@ 06,36 Say "Alterar preco de venda c/base" 
@ 07,36 Say "na margem dos produtos?" Get cAlteraVenda Pict "!" valid cAlteraVenda $ "SN" 
 
@ 08,36 Say Repl("Í",37) 
@ 09,36 Say "Registro.......: 0000" 
@ 10,36 Say "Codigo Produto.: 000.000-0" 
@ 11,36 Say "Preco Anterior.:" 
@ 12,36 Say "Preco Atual....:" 
read 
If LastKey() == K_ESC .OR. nCodFor == 0 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
EndIf 
   MPR->( DBSetOrder( 1 )) 
   Set Filter To CodFor = nCodFor 
   DBGOTOP() 
   AVISO("Aguarde...",24-5) 
   WHILE !EOF() 
      @ 09,53 Say StrZero(Recno(),4,0) 
      @ 10,53 Say Tran(CPROD_,"@R XXX.XXX-X") 
      @ 11,53 Say Tran(VALOR_,"@E ***,***,***,***.***") 
      @ 12,53 Say Tran(VALOR_+((VALOR_*nPERCEN)/100),"@E ***,***,***,***.***") 
      IF NetRLOCK() 
         REPL PVELHO WITH VALOR_,; 
              VALOR_ with VALOR_+((VALOR_*nPERCEN)/100) 
         IF cAlteraVenda=="S" 
            IF MPR->( DBSeek( pad( PXF->CPROD_, 12 ) ) ) 
               IF MPR->( NetRLock() ) 
                  Replace MPR->PRECOV With PXF->VALOR_ + ((PXF->VALOR_*MPR->PERCPV)/100) 
               ENDIF 
            ENDIF 
         ENDIF 
      ENDIF 
      DBUnlock() 
      DBSkip() 
   ENDDO 
   AVISO("Operacao finalizada.",24-5) 
   MENSAGEM("Pressione [ENTER] p/ continuar...") 
   SET FILTER TO 
   PAUSA() 
   DBUNLOCKALL() 
   FechaArquivos() 
   SCREENREST(cTELA) 
   RETURN NIL 






Function CompraCotacao()
Local oTab, Tecla
Local cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 )
Local nPreco_, nCodFor, nTabela, dDataBase:= ctod("  /  /  ")

  VPBox( 00, 00, 22, 79, "COTACAO DE PRECOS", _COR_GET_BOX )
  IF SWAlerta( "<< GERAR COTACAO >>; Deseja gerar cotacoes com melhores precos e fornecedores?", {"Sim","Nao"} )==1

     nTabela:= SWAlerta( "<< TABELA DE PRECOS >>; Usar somente fornecedores com os ;precos de compra atualizados no prazo maximo de ", { "30 dias", "90 dias", "120 dias", "Todas as listas" } )
     IF nTabela==1
        dDataBase:= DATE() - 30
     ELSEIF nTabela==2
        dDataBase:= DATE() - 90
     ELSEIF nTabela==3
        dDataBase:= DATE() - 120
     ELSEIF nTabela==4
        dDataBase:= ctod("  /  /  ")
     ENDIF
     DBSelectAr( 123 )
     aStr:= {{"INDICE", "C", 12, 00 },;
             {"CODFAB", "C", 13, 00 },;
             {"CODFOR", "N", 06, 00 },;
             {"DESCRI", "C", 50, 00 },;
             {"UNIDAD", "C", 02, 00 },;
             {"QUANT_", "N", 16, 02 },;
             {"PRECO_", "N", 16, 02 }}

     DBCreate( "TEMP.TMP", aStr )
     USE TEMP.TMP ALIAS TMP
     INDEX ON CODFOR TO INDIEIU3

     MPR->( DBGoTop() )
     PXF->( DBSetOrder( 1 ) )
     WHILE !MPR->( EOF() )
        IF MPR->SALDO_ < MPR->ESTMIN
           @ 21,01 SAY MPR->DESCRI
           Scroll( 1, 1, 21, 79, 1 )
           nCodFor:= 999999
           nPreco_:= 999999999999
           IF PXF->( DBSeek( MPR->INDICE ) )
              WHILE PXF->CPROD_ == MPR->INDICE .AND. !PXF->( EOF() )
                 IF PXF->VALOR_ < nPreco_
                    IF PXF->DATA__ >= dDataBase
                       nPreco_:= PXF->VALOR_
                       nCodFor:= PXF->CODFOR
                    ENDIF
                 ENDIF
                 PXF->( DBSkip() )
              ENDDO
           ENDIF
           IF nPreco_ < 999999999999
              IF !TMP->( DBSeek( nCodFor ) )
                 FOR->( DBSetOrder( 1 ) )
                 FOR->( DBSeek( nCodFor ) )
                 TMP->( DBAppend() )
                 Replace TMP->DESCRI With "---------------------------------------------------------",;
                         TMP->CODFOR With nCodFor
                 TMP->( DBAppend() )
                 Replace TMP->DESCRI With FOR->DESCRI,;
                         TMP->CODFOR With nCodFor
              ENDIF
              TMP->( DBAppend() )
              Replace TMP->INDICE With MPR->INDICE,;
                      TMP->CODFAB With MPR->CODFAB,;
                      TMP->DESCRI With MPR->DESCRI,;
                      TMP->UNIDAD With MPR->UNIDAD,;
                      TMP->QUANT_ With MPR->ESTMIN - MPR->SALDO_,;
                      TMP->PRECO_ With nPreco_,;
                      TMP->CODFOR With nCodFor
           ENDIF
        ENDIF
        MPR->( DBSkip() )
     ENDDO

     // TOTAIS POR FORNECEDOR
     nTotal_:= 0
     TMP->( DBGOTOP() )
     WHILE !TMP->( EOF() )
          nCodFor:= TMP->CODFOR
          nTotal_:= nTotal_ + ( TMP->PRECO_ * TMP->QUANT_ )
          TMP->( DBSkip() )
          IF TMP->CODFOR <> nCodFor .OR. TMP->( EOF() )
             TMP->( DBAppend() )
             // Total
             Replace TMP->CODFOR With nCodFor,;
                     TMP->PRECO_ With nTotal_,;
                     TMP->DESCRI With "T O T A L   C O T A C A O . . . . . . ."
             // linha em branco
             TMP->( DBAppend() )
             Replace TMP->CODFOR With nCodFor,;
                     TMP->PRECO_ With 0,;
                     TMP->DESCRI With ""
             nTotal_:= 0
             TMP->( DBSkip() )
             IF TMP->( EOF() )
                EXIT
             ENDIF
          ENDIF
     ENDDO
     dbselectAr( 123 )
     DBGoTop()

     Aviso( "Montagem de planilha de melhores precos concluida com sucesso!" )
     inkey(0)

     Scroll( 1, 1, 04, 78, 0 )
     @ 03,03 Say "Cotacao baseada em produtos com saldo em estoque abaixo do m¡nimo."

     bBlock:= {|| STRZERO( CODFOR, 6, 0 ) + " " + LEFT( INDICE, 7 ) + " " + LEFT( DESCRI, 40 ) + Tran( QUANT_, "@eZ 9,999.999" ) + " " + Tran( PRECO_, "@eZ 999,999.999" ) + " " }
     Tecla := NIL 
     do while Tecla <> K_ESC 
          SetColor( _COR_BROWSE ) 
          oTAB:= Browse( 05, 00, 22, 79, ; 
                "Forn.  Indice  Descricao                                   Quant.     Preco", bBlock,; 
                " COTACAO DE PRECOS ", @Tecla ) 
          do case 
             case TECLA==K_DEL 
                 lDELETE:=.T. ;if(netrlock(5),exclui(oTAB),nil) 
                 dbUnlockAll() 
             case DBPesquisa( Tecla, oTab ) 
         endcase 
     enddo
     TMP->( DBCloseArea() )
  ENDIF
  ScreenRest( cTela )
  SetColor( cCor )



Function ProdVenda()
Local cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 )
Local nFator:= 0
   VPBOX( 0, 0, 22, 79, "PRECO DE COMPRA" , _COR_GET_BOX )
   IF SWAlerta( "<< ATUALIZAR PRECO >>; Atualizar preco de compra com base no; preco de venda e margem de lucro?", { "Sim", "Nao" } ) == 1
      DBSelectAr( _COD_MPRIMA )
      WHILE !MPR->( EOF() )
           IF BuscaPrecoCompra()
              IF PXF->( NETRLOCK( 5 ) )
                 nPrecoFicticio:= ( 1 + ( 1 * ( MPR->PERCPV / 100 ) ) )
                 nFator:= ( 1 / nPrecoFicticio ) * 100
                 nPreco:= ( MPR->PRECOV * ( nFator / 100 ) )
                 IF !( PXF->VALOR_ == nPreco )
                    Replace PXF->PVELHO With PXF->VALOR_,;
                            PXF->DATA__ With DATE(),;
                            PXF->VALOR_ With ROUND( nPreco, 2 )
                 ENDIF
                 @ 21,02 SAY MPR->DESCRI + Tran( nPreco, "@E 9,999,999.99" ) + " " + Tran( nFator, "@E 99,999.9999" )
                 Scroll( 01, 01, 21, 78, 1 )
              ENDIF
           ENDIF
           MPR->( DBSkip() )
      ENDDO
   ENDIF
   ScreenRest( cTela )
   SetColor( cCor )
   Return Nil






                 // AVISO( "COMPRA = " + Tran( nPreco, "@E 9,999,999.99" ) + "   MARGEM " + STR( MPR->PERCPV ) + "VENDA=" + Tran( MPR->PRECOV, "@e 9,999,999.99" ) + "FATOR=" + STR( nFator ) )
                 // PAUSA()

