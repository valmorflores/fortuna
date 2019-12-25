// ## CL2HB.EXE - Converted
/* 
** Modulo      - VPC79999 
** Descricao   - Menu de Precos de venda 
** Programador - Valmor Pereira Flores 
** Data        - 29/Maio/1995 
** Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 
#include "formatos.ch" 

#ifdef HARBOUR
function vpc98700()
#endif



Loca cTELA:=zoom(14,24,20,66), cCOR:=setcolor(), nOPCAO:=0
vpbox(14,24,20,66) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(15,25," 1 Tabela Padrao                        ",2,M->Cor[11],; 
        "Alteracao de precos de vendas Tabela padrao.",,,M->Cor[6],.F.)) 
   aadd(MENULIST,swmenunew(16,25," 2 Tabela por Fornecedor                ",2,M->Cor[11],; 
        "Alteracao menual de precos de vendas por fornecedor.",,,M->Cor[6],.F.)) 
   aadd(MENULIST,swmenunew(17,25," 3 Tabela Diferenciada                  ",2,M->Cor[11],; 
        "Alteracao de precos de vendas Tabelas diferenciadas.",,,M->Cor[6],.F.)) 
   aadd(MENULIST,swmenunew(18,25," 4 Ajuste Automatico (Tab.Padrao)       ",2,M->Cor[11],; 
        "Alteracao de precos de vendas.",,,M->Cor[6],.F.)) 
   aadd(MENULIST,swmenunew(19,25," 0 Retorna                              ",2,M->Cor[11],; 
        "Retorna ao menu anterior.",,,M->Cor[6],.F.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOpcao=0 .or. nOpcao=5; exit 
      case nOpcao=1 ;VPC35100() 
      case nOpcao=2 ;PRODFOR() 
      case nOpcao=3 ;VPC35200() 
      case nOpcao=4 ;PRODPERC() 
   endcase 
enddo 
Unzoom(cTELA) 
setcolor(cCOR) 
return 
 
 
Function ProdDif() 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � PRODFOR 
� Finalidade  � Visalizacao e alteracao de Precos por Fornecedor <Manual> 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 22/Outubro/1998 
��������������� 
*/ 
Static Function ProdFor() 
  Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
        nCursor:= SetCursor() 
  Local nArquivo:= 0, nValor_:= 0 
  loca oTab1, oTab2, nTecla 
 
  DBSelectAr( _COD_FORNECEDOR ) 
  DbGoTop() 
 
  lAlteraPos:= .T. 
 
  dbSelectAr(_COD_MPRIMA) 
  dbSetOrder( 5 ) 
 
  dbgotop() 
  SetCursor(0) 
  SetColor( _COR_BROWSE ) 
  VPBox( 0, 41, 24-6, 79,  "Produtos",     _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  VPbox( 0, 0,  24-6, 40,        "Fornecedores", _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  VPBox( 24-5, 0, 24-2, 79,"Informacoes",  _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB][ENTER]Arquivo [Nome]Pesquisa [ESC]Cancela") 
  oTab1:=tbrowsedb( 01, 42, 24 - 7, 79 - 1 ) 
  oTab1:addcolumn(tbcolumnnew(,{|| substr( MPR->INDICE, 1, 7 )+"=>"+; 
                                   substr( MPR->CODFAB, 1, 11 )+; 
                                     Tran( MPR->PRECOV, "@E 999,999,999.999" ) + Space( 5 ) } ) ) 
  oTab2:=tbrowsedb( 01, 01, 24 - 7, 40 ) 
  oTab2:addcolumn(tbcolumnnew(,{|| StrZero( FOR->CODIGO, 4, 0 )+"=>"+; 
                                    SubStr( FOR->DESCRI, 1, 32 ) + Space( 5 ) } ) ) 
  oTab1:AUTOLITE:=.F. 
  oTab1:dehilite() 
  oTab2:AUTOLITE:=.F. 
  oTab2:dehilite() 
  oTab2:GoTop() 
  WHILE .T. 
      if nARQUIVO=0 
         if lALTERAPOS 
             dbselectar(_COD_FORNECEDOR) 
             oTab2:Refreshall() 
             Whil ! oTab2:Stabilize() 
             EndDo 
             mensagem("Pressione [TAB] para selecionar fornecedor...") 
             ajuda("["+_SETAS+"][PgDn][PgUp]Move [Nome/Codigo]Pesquisa [TAB]Produtos [ESC]Fim") 
             lALTERAPOS:=.F. 
         endif 
         oTab2:colorrect({oTab2:ROWPOS,1,oTab2:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTab2:stabilize() 
         enddo 
      elseif nARQUIVO=1 
         dbselectar(_COD_MPRIMA) 
         if lAlteraPos 
            lAlteraPos:= .F. 
            mensagem("Digite o valor com o cursor sobre o produto...") 
            ajuda("["+_SETAS+"][PgDn][PgUp]Move [Nome]Pesquisa [1234567890]Preco [TAB]Forn. [ESC]Fim") 
         endif 
         oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTab1:stabilize() 
         enddo 
         nCODPRO=val(MPR->CODRED) 
         if MPR->SALDO_< MPR->ESTMIN 
            @ 20,02 Say "Produto: "+MPR->CODFAB + "  <" + MPR->DESCRI + ">" 
            @ 21,02 say "                                      " 
            @ 21,02 say "Prod. abaixo do estoque m�nimo: " + alltrim(str(MPR->SALDO_,5,0)) 
         else 
            @ 20,02 Say "Produto: "+MPR->CODFAB + "  <" + MPR->DESCRI + ">" 
            @ 21,02 say "                                        " 
            @ 21,02 say "Saldo do produto: "+alltrim(str(MPR->SALDO_,5,0)) 
         endif 
      endif 
      nTECLA:=inkey(0) 
      If nTECLA=K_ESC; exit; endif 
      do case 
         case nTECLA==K_UP         ;if(nARQUIVO=0,oTab2:up(),oTab1:up()) 
         case nTECLA==K_DOWN       ;if(nARQUIVO=0,oTab2:down(),oTab1:down()) 
         case nTECLA==K_PGUP       ;if(nARQUIVO=0,oTab2:pageup(),oTab1:pageup()) 
         case nTECLA==K_PGDN       ;if(nARQUIVO=0,oTab2:pagedown(),oTab1:pagedown()) 
         case nTECLA==K_HOME       ;if(nARQUIVO=0,oTab2:gotop(),oTab1:gotop()) 
         case nTECLA==K_END        ;if(nARQUIVO=0,oTab2:gobottom(),oTab1:gobottom()) 
         case Chr( nTecla ) $ "0123456789" .OR.; 
                   nTecla == K_ENTER 
              IF nArquivo == 1 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 nPrecoVenda:= MPR->PRECOV 
                 IF !nTecla==K_ENTER 
                    Keyboard Chr( nTecla ) 
                 ENDIF 
                 SetCursor( 1 ) 
                 VPBox( 10, 32, 12, 70, , _COR_GET_BOX,,,_COR_GET_TITULO ) 
                 SetColor( _COR_GET_EDICAO ) 
                 @ 11, 36 Say "Preco Venda:" Get nPrecoVenda Pict "@E 999,999,999.999" 
                 READ 
                 IF netrlock() 
                    Replace PRECOV With nPrecoVenda, DATA__ With Date() 
                 ENDIF 
                 DBUnlockAll() 
                 ScreenRest( cTelaRes ) 
              ENDIF 
         case DBPesquisa( nTecla, IF( nArquivo==0, oTab2, oTab1 ) ) 
         case nTecla==K_F2 
              IF nArquivo == 0 
                 DBMudaOrdem( 1, oTab1 ) 
              ELSE 
                 DBMudaOrdem( 1, oTab2 ) 
              ENDIF 
         case nTecla==K_F3 
              IF nArquivo == 0 
                 DBMudaOrdem( 2, oTab1 ) 
              ELSE 
                 DBMudaOrdem( 2, oTab2 ) 
              ENDIF 
         case nTecla==K_F4 
              IF nArquivo == 1 
                 DBMudaOrdem( 3, oTab1 ) 
              ENDIF 
         case nTECLA=K_TAB .OR. nTECLA=K_ENTER 
              if nARQUIVO=0 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 nCODFOR=FOR->CODIGO 
                 dbselectar( _COD_MPRIMA ) 
                 cCODIND:= StrZero(nCODFOR,3,0) 
                 cINDICE1:="&GDIR\MPRIND01."+cCODIND 
                 cINDICE2:="&GDIR\MPRIND02."+cCODIND 
                 cINDICE3:="&GDIR\MPRIND03."+cCODIND 
                 cINDICE4:="&GDIR\MPRIND04."+cCODIND 
                 cINDICE5:="&GDIR\MPRIND05."+cCODIND 
                 nContador:= 1 
                 nTotal:= Lastrec() * 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On INDICE        To &cINDICE1 For CODFOR=nCODFOR Eval {|| Processo( , nTotal, ++nContador ) } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On Upper(DESCRI) To &cINDICE2 For CODFOR=nCODFOR Eval {|| Processo( , nTotal, ++nContador ) } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Index On Upper(CODFAB) To &cINDICE3 For CODFOR=nCODFOR Eval {|| Processo( , nTotal, ++nContador ) } 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 Set Index To &cINDICE1, &cINDICE2, &cINDICE3 
                 //DBSetOrder( 3 ) 
                 ScreenRest( cTelaRes ) 
                 oTab1:GoTop() 
                 oTab1:RefreshAll() 
                 While !oTab1:Stabilize() 
                 EndDo 
              endif 
              nArquivo:= IF( nArquivo==0, 1, 0 ) 
              lAlteraPos:= .T. 
         otherwise                ;tone(125); tone(300) 
      endcase 
      if nARQUIVO=0 
         nCODFOR=FOR->CODIGO 
         oTab2:refreshcurrent() 
         WHILE !oTab2:stabilize() 
         ENDDO 
      elseif nARQUIVO=1 
         oTab1:refreshcurrent() 
         WHILE !oTab1:stabilize() 
         ENDDO 
      endif 
  enddo 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
  dbselectar(_COD_MPRIMA) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/mprind01.ntx", "&gdir/mprind02.ntx", "&gdir/mprind03.ntx", "&gdir/mprind04.ntx", "&gdir/mprind05.ntx"      
  #else 
    Set Index To "&GDir\MPRIND01.NTX", "&GDir\MPRIND02.NTX", "&GDir\MPRIND03.NTX", "&GDir\MPRIND04.NTX", "&GDir\MPRIND05.NTX"      
  #endif
  return(.T.) 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
#Define LIN    5 
#Define COL    38 
 
Stat Func PRODPERC 
LOCA cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
LOCA nCODFOR:=0, nPERCEN:=0 
LOCA nTipo:=2, nPreco:= 0 
If !File(_VPB_MPRIMA) .OR. !File(_VPB_PRECOXFORN) 
   MENSAGEM("Arquivo de precos (Compra/Venda) inexistente...") 
   PAUSA() 
   ScreenRest(cTELA) 
   RETURN NIL 
endif 
/* PRECO DE FORNECEDOR */ 
if !fdbusevpb(_COD_PRECOXFORN,2) 
   aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_PRECOXFORN)+".",24/2) 
   mensagem("... Problema na abertura do arquivo de precos ...") 
   pausa() 
   SetColor(cCOR) 
   SetCursor(nCURSOR) 
   ScreenRest(cTELA) 
   Return(NIL) 
endif 
if !fdbusevpb(_COD_MPRIMA,2) 
   aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_MPRIMA)+".",24/2) 
   mensagem("... Problema na abertura do arquivo de produtos ...") 
   pausa() 
   SetColor(cCOR) 
   SetCursor(nCURSOR) 
   ScreenRest(cTELA) 
   Return(NIL) 
endif 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERMODULO("ATUALIZACAO DE PRECOS DE VENDA (Por fornecedor)") 
VPBOX(LIN,COL,LIN+9,COL+40,"Atualizacao de Precos",_COR_GET_BOX) 
SetColor( _COR_GET_EDICAO ) 
@ LIN+1,COL+1 Say "Fornecedor.....:" get nCODFOR Pict "9999" WHEN ; 
  Mensagem("Digite o codigo do fornecedor.") 
@ LIN+2,COL+1 Say "Percentual.....:" get nPERCEN Pict "9999.99" WHEN ; 
  Mensagem("Digite o percentual de reajuste.") 
@ LIN+3,COL+1 Say "Tipo...........:" get nTipo PICT "9" VALID nTipo>=1 .AND. nTipo<=2 When ; 
  Mensagem("Atualizacao do PRECO DE VENDA com base no preco: [1]De Compra / [2]Atual") 
@ LIN+4,COL+1 Say Repl("�",37) 
@ LIN+5,COL+1 Say "Registro.......: 0000" 
@ LIN+6,COL+1 Say "Codigo Produto.: 000.000-0" 
@ LIN+7,COL+1 Say "Preco Anterior.:" 
@ LIN+8,COL+1 Say "Preco Atual....:" 
read 
If LastKey() == K_ESC .OR. nCodFor == 0 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
EndIf 
DBSELECTAR(_COD_MPRIMA) 
SET FILTER TO CodFor=nCodFor 
SET RELATION TO INDICE INTO PXF //* Nova *// 
DBSELECTAR(_COD_PRECOXFORN) 
//SET RELATION TO CProd_ INTO MPR 
DBGOTOP() 
AVISO("Aguarde...",24-5) 
 
 
   WHILE !MPR->( EOF() ) 
      @ LIN+5,COL+17 Say StrZero(Recno(),4,0) 
      @ LIN+6,COL+17 Say Tran( SUBSTR( MPR->INDICE, 1, 7 ), "@R XXX.XXX-X" ) 
      @ LIN+7,COL+17 Say Tran( MPR->PRECOV, "@E ***,***,***,***.***" ) 
      nPreco:= IF( nTipo==1, PXF->VALOR_, MPR->PRECOV ) 
      nPreco:= nPreco + ( ( nPreco * nPERCEN ) / 100 ) 
      @ LIN+8,COL+17 Say Tran( nPreco, "@E ***,***,***,***.***" ) 
      IF MPR->( netrlock() ) 
         REPL MPR->PRECOV with nPreco 
      ENDIF 
      DBUnlock() 
      MPR->( DBSkip() ) 
   ENDDO 
Set Filter To 
Set Relation To 
DBUNLOCKALL() 
SCREENREST(cTELA) 
SetColor( cCor ) 
RETURN NIL 
