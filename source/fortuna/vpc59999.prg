// ## CL2HB.EXE - Converted
/* 
** Modulo      - VPC5999999 
** Finalidade  - Ordem de Compra 
** Data        - 03/Marco/1995 
** Atualizacao - 
** Programador - Valmor Pereira Flores 
*/ 
#include "vpf.ch" 
#Include "box.ch" 
#Include "inkey.ch" 
#Include "formatos.ch"

#ifdef HARBOUR
function vpc59999()
#endif



Loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
Loca GETLIST:={} 
Loca nCODFOR:=0,; 
     cDESFOR:= Spac(45),; 
     cENDERE:= Spac(35),; 
     cCODCEP:= Spac(8),; 
     cBAIRRO:= Spac(20),; 
     cCIDADE:= Spac(30),; 
     cESTADO:= Spac(2),; 
     cLOCALE:= "O MESMO"+Spac(43),; 
     cLOCALC:= "O MESMO"+Spac(43),; 
     cREPDES:= Spac(30),; 
     cREPCON:= Spac(30),; 
     cREPFON:= Spac(11),; 
     nTAXAF_:= 0,; 
     cFAX___:= Spac(11),; 
     cFONE__:= Spac(11),; 
     dDATAEM:= date(),; 
     cCOMPRA:= PAD( SWSet( _OC__COMPRADOR ), 30 ),; 
     cRESP__:= WUSUARIO,; 
     cCONTAT:= Spac(30),; 
     cORDCMP:= Spac(5),; 
     cREAJUS:= Spac(33),; 
     nPERICM:= 12,; 
     cCONDIC:= Spac(15),; 
     cOBSER1:= Spac(70),; 
     cOBSER2:= Spac(70),; 
     cOBSER3:= Spac(70),; 
     cOBSER4:= Spac(70),; 
     nCT:= 1,; 
     lFIM:= .F.,; 
     nITEM:= 1,; 
     nPAGINA:= 1,; 
     cTELAR1,; 
     cNOTA__:= "*** Favor mencionar o numero desta ordem de compra em sua(s) nota(s) fiscal(is). ***",; 
     cOBICM1:= "Destinado a Comercializacao.                     ",; 
     cOBICM2:= "ICMs de #VICM% incluso no preco do produto.      ",; 
     nSEQUEN:= 0,; 
     nFRETE_:= 0,; 
     nTOTALG:= 0,; 
     nTOTIPI:= 0,; 
     nSUBTOT:= 0,; 
     nTFRETE:= 1,; 
     nCODTRA:= 0,; 
     cDESTRA:= Spac(20),; 
     cFONTRA:= Spac(11),; 
     aPRODUTOS:={},; 
     nFLAG:=0,; 
     cSEQUEN,; 
     cTELA0,; 
     cCOR0,; 
     lCONFIRMA,; 
     lDELIMITERS,; 
     aPROD:={},; 
     nCodTabA,; 
     nCodTabB,; 
     nClassif 
 
inicfgcampos(1) 
IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
   RETURN NIL 
ENDIF 
DBSelectAr( _COD_FORNECEDOR ) 
Set filter to TIPO__="1" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserModulo("ORDEM DE COMPRA - Inclusao") 
SetColor( _COR_GET_BOX ) 
DbSelectAr(_COD_OC) 
DBSetOrder( 1 ) 
DbGoBottom() 
cORDCMP:=strzero(val(ORDCMP)+1,5,0) 
DbGoTop() 
whil lastkey()<>K_ESC 
   nCt:=1 
   aProd:= {} 
   aProdutos:= {} 
   SetColor( _COR_GET_EDICAO ) 
   Scroll( 00, 00, 22, 79 ) 
   DispBox( 00, 00, 22, 79, _BOX_UM ) 
   nPAGINA:=1 
   @ 01,02 say "Numero: < 00000 > Sequencia: 01" 
   set(_SET_DELIMITERS,.F.) 
   @ 01,12 get cORDCMP pict "99999" 
   read 
   If LastKey()=K_ESC 
      Exit 
   EndIf 
   SetColor( _COR_GET_EDICAO ) 
   set(_SET_DELIMITERS,.T.) 
   @ 02,02 say "Fornecedor.......:" get nCODFOR pict "9999" when mensagem("Digite o codigo do fornecedor.") valid; 
     {|oGET|SelFornecedor(oGET,GETLIST,@cREPDES,@cREPCON,cREPFON)} 
   @ 03,02 say "Nome.............:" get cDESFOR when mensagem("Digite o nome do fornecedor.") valid; 
     {|oGET|SelFornecedor(oGET,GETLIST,@cREPDES,@cREPCON,@cREPFON)} 
   @ 04,02 say "Endereco.........:" get cENDERE 
   @ 05,02 say "CEP..............:" get cCODCEP pict "@r 99.999-999" 
   @ 06,02 say "Cidade...........:" get cCIDADE 
   @ 07,02 say "UF...............:" get cESTADO valid veruf(@cESTADO) 
   @ 08,02 say "Contato..........:" get cCONTAT 
   @ 09,02 say "Fone.............:" get cFONE__ pict "@R 9999-999.99.99" 
   @ 10,02 say "FAX..............:" get cFAX___ pict "@R 9999-999.99.99" 
   @ 11,02 say "Local de Entrega.:" get cLOCALE 
   @ 12,02 say "Local de Cobranca:" get cLOCALC 
   @ 13,02 say "Taxa Financeira..:" get nTAXAF_ pict "@E 999,999,999,999.99" 
   @ 14,02 say "Condicoes........:" get cCONDIC 
   @ 15,02 say "Reajuste.........:" get cREAJUS 
   @ 16,02 say "Transportadora...:" get nCODTRA pict "999" valid {|oGET|edittransp(oGET,GETLIST,@cDESTRA,@cFONTRA)} 
   @ 17,02 say "Total do frete...:" get nFRETE_ pict "@E 999,999,999,999.99" 
   @ 18,02 say "Tipo de frete....:" get nTFRETE pict "9" valid frete(@nTFRETE,18) 
//   @ 19,02 say "Percentual de ICM:" get nPERICM pict "@E 999.99" 
   @ 20,02 say "Data.............:" get dDATAEM 
   @ 21,02 say "Comprador........:" get cCOMPRA 
   Read 
 
   IF LastKey()==K_ESC 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      Aviso( "Pressione [ESC] para abandonar ou [Qualquer tecla] para continuar.", 12 ) 
      Mensagem( "Pressione [ESC] para abandonar." ) 
      Inkey(0) 
      ScreenRest( cTelaRes ) 
      IF LastKey() == K_ESC 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ELSE 
         Loop 
         Keyboard Chr( K_ENTER ) 
      ENDIF 
   ENDIF 
 
   cTela001:= ScreenSave( 0, 0, 24, 79 ) 
 
   QTD:= 20 
   VPBox( 04, 10, 20, 69, "Dados dos Produtos", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
   WHILE .T. 
       IF LastKey()==K_ESC 
          EXIT 
       ENDIF 
       IF len(aPROD) <= nCT 
          aadd( aPROD,; 
               { "0000000",;  // Codigo 
                 SPAC(36),; // Descricao 
                 SPAC(2),;  // Unidade 
                 0,;        // Valor Unitario 
                 2,;        // Codigo ICMs 
                 0,;        // Quantidade 
                 0,;        // Valor Total 
                 0,;        // Percentual IPI 
                 0,;        // Valor IPI 
                 DATE(),;   // Data de entrega 
                 nCT,; 
                 0,; 
                 0,; 
                 0,; 
                 0 } )    // Posicao (1..7) 
      endif 
      cGrupo_:= Left( aProd[nCt][1], 3 ) 
      cCodigo:= Right( aProd[nCt][1], 4 ) 
      nCodTabA:= aProd[ nCt ][ 5 ] 
      nCodTabB:= aProd[ nCt ][ 12 ] 
      nClassif:= aProd[ nCt ][ 13 ] 
      @ 05,12 Say "Item..........: [" + StrZero( nCt, 3, 0 ) + "]" 
      @ 06,12 Say "Produto.......:" Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo ) 
      @ 06,33 Say "-" 
      @ 06,34 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList ) when mensagem("Digite o c�digo do produto.") 
      @ 07,12 Say "Descricao.....:" Get aProd[nCT][2]  Pict "@S35" 
      @ 08,12 Say "Unidade.......:" Get aProd[nCT][3] 
      @ 09,12 Say "C. Fiscal.....:" Get nClassif  Pict "999" Valid VerClasse( @nClassif ) 
      @ 10,12 Say "Cd.Tabela 01..:" Get nCodTabA  Pict "9"   Valid ClassTrib( @nCodTabA, 1 ) 
      @ 11,12 Say "Cd.Tabela 02..:" Get nCodTabB  Pict "9"   Valid ClassTrib( @nCodTabB, 2 ) 
      @ 12,12 Say "Quantidade....:" Get aProd[nCT][6]  Pict "999999.999" 
      @ 13,12 Say "Valor Unitario:" Get aProd[nCT][4]  Pict "999999.999"     Valid { |oGET| Calculos( oGet, GetList, 1 ) } 
      @ 14,12 Say "Valor Total...:" Get aProd[nCT][7]  Pict "999999999.999" 
      @ 15,12 Say "% IPI.........:" Get aProd[nCT][8]  Pict "99.99"          Valid { |oGET| Calculos( oGet, GetList, 2 ) } 
      @ 16,12 Say "Valor IPI.....:" Get aProd[nCT][9]  Pict "999999.99" 
      @ 17,12 Say "% ICMs........:" Get aProd[nCt][14] Pict "99.99"          Valid { |oGET| Calculos( oGet, GetList, 3 ) } 
      @ 18,12 Say "Valor ICMs....:" Get aProd[nCt][15] Pict "999999.99" 
      @ 19,12 Say "Data Entrega..:" Get aProd[nCT][10] 
      Read 
      aPROD[nCT][1]:= cGrupo_ + cCodigo 
      aProd[ nCt ][ 5 ] := nCodTabA 
      aProd[ nCt ][ 12 ]:= nCodTabB 
      aProd[ nCt ][ 13 ]:= nClassif 
      IF LastKey()==K_ESC 
         EXIT 
      ENDIF 
      IF LastKey()==K_ENTER .OR. LastKey()==K_PGDN 
         nCt++ 
      ENDIF 
      IF LastKey()==K_PGUP 
         IF nCt>1 
            nCt-=1 
         ELSE 
            nCt:=1 
         ENDIF 
      ENDIF 
      IF nCt > 125 
         nCt:= 125 
      ENDIF 
   ENDDO 
   FOR nCT:=1 to Len( aProd ) 
       aadd( aPRODUTOS, { aPROD[nCT][1],; 
                          aPROD[nCT][2],; 
                          aPROD[nCT][3],; 
                          aPROD[nCT][4],; 
                          aPROD[nCT][12],; 
                          aPROD[nCT][6],; 
                          aPROD[nCT][7],; 
                          aPROD[nCT][8],; 
                          aPROD[nCT][9],; 
                          aPROD[nCT][10],; 
                          aProd[nCt][11],; 
                          aProd[nCt][12],; 
                          aProd[nCt][13],; 
                          aProd[nCt][14],; 
                          aProd[nCt][15] } ) 
   NEXT 
   ScreenRest( cTela001 ) 
   cTELA0:=screensave( 00, 00, 24, 79 ) 
   if cDESFOR<>spac(45) 
 
      /* observacoes diversas */ 
      lCONFIRMA:=set(_SET_CONFIRM,.F.) 
      SetCursor(1) 
      lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
      VPBOX( 07, 04, 18, 75, "Observacoes", _COR_ALERTA_BOX, .T., .T., _COR_ALERTA_TITULO ) 
      SetColor( _COR_ALERTA_LETRA ) 
      @ 09,05 get cOBSER1 
      @ 10,05 get cOBSER2 
      @ 11,05 get cOBSER3 
      @ 12,05 get cOBSER4 
      DispBox(13,05,13,74, _BOX_UM ) 
      DispBox(15,05,15,74, _BOX_UM ) 
      @ 14,05 say "Notificacao" get cNOTA__ pict "@S58" 
      @ 16,05 say "ICMs:  1 =>" get cOBICM1 
      @ 17,05 say "       2 =>" get cOBICM2 
      read 
      Set( _SET_DELIMITERS, lDelimiters ) 
      SetColor( _COR_GET_EDICAO ) 
      set(_SET_CONFIRM,lCONFIRMA) 
 
      /* somatorio */ 
      nSUBTOT:=nTOTIPI:=0 
      for nCT:=1 to len(aPRODUTOS) 
          nSUBTOT:=nSUBTOT+aPRODUTOS[nCT][7] 
          nTOTIPI:=nTOTIPI+aPRODUTOS[nCT][9] 
      next 
      nTOTALG:=nSUBTOT+nTOTIPI+nFRETE_ 
 
   endif 
 
   /* solicita a confirmacao */ 
   if confirma(24-2,65,"Confirma?",; 
      "Digite [S] para Salvar ou [N] para abandonar...","S") 
 
      /* Restaura a tela que foi salva anteriormente */ 
      ScreenRest( cTela001 ) 
 
      /* Solicita o nome do responsavel */ 
      VPBox( 18, 15, 21, 65, "Responsavel", "15/01", .T., .T., "00/15" ) 
      SetColor( "14/01" ) 
      @ 20,17 get cRESP__ 
      Read 
 
      /* grava os dados no arquivo de ordem de compra */ 
      dbselectar(_COD_OC) 
      if buscanet(5,{|| dbappend(), !neterr()}) 
         repl OC->FILIAL With SWSet( _GER_EMPRESA ),; 
              OC->ORDCMP with cORDCMP,; 
              OC->PAGINA with strzero(nPAGINA,4,0),; 
              OC->CODFOR with nCODFOR,; 
              OC->DESFOR with cDESFOR,; 
              OC->ENDERE with cENDERE,; 
              OC->CODCEP with cCODCEP,; 
              OC->CIDADE with cCIDADE,; 
              OC->ESTADO with cESTADO,; 
              OC->CONTAT with cCONTAT,; 
              OC->REPDES with cREPDES,; 
              OC->REPCON with cREPCON,; 
              OC->REPFON with cREPFON,; 
              OC->CODTRA with nCODTRA,; 
              OC->DESTRA with cDESTRA,; 
              OC->FONTRA with cFONTRA,; 
              OC->FAX___ with cFAX___,; 
              OC->FONE__ with cFONE__,; 
              OC->LOCALE with cLOCALE,; 
              OC->LOCALC with cLOCALC,; 
              OC->TAXAF_ with nTAXAF_,; 
              OC->COMPRA with cCOMPRA,; 
              OC->RESP__ with cRESP__,; 
              OC->REAJUS with cREAJUS,; 
              OC->PERICM with nPERICM,; 
              OC->CONDIC with cCONDIC,; 
              OC->OBSER1 with cOBSER1,; 
              OC->OBSER2 with cOBSER2,; 
              OC->OBSER3 with cOBSER3,; 
              OC->OBSER4 with cOBSER4,; 
              OC->NOTA__ with cNOTA__,; 
              OC->OBICM1 with cOBICM1,; 
              OC->OBICM2 with cOBICM2,; 
              OC->DATAEM with dDATAEM,; 
              OC->SUBTOT with nSUBTOT,; 
              OC->VLRFRE with nFRETE_,; 
              OC->VLRIPI with nTOTIPI,; 
              OC->TOTAL_ with nTOTALG,; 
              OC->TFRETE with StrZero(nTFRETE,1,0) 
         dbselectar(_COD_OC_AUXILIA) 
         for nCT:=1 to len(aPRODUTOS) 
             If aPRODUTOS[nCT][2]<>Spac(36) 
                if buscanet(5,{|| dbappend(), !neterr()}) 
                   repl ORDCMP With cORDCMP,; 
                        PAGINA With strzero(nPAGINA,04,00),; 
                        ITEM__ With nCT,; 
                        CODPRO With aPRODUTOS[nCT][1],; 
                        DESPRO With aPRODUTOS[nCT][2],; 
                        UNIDAD With aPRODUTOS[nCT][3],; 
                        PRECOU With aPRODUTOS[nCT][4],; 
                        CODICM With aPRODUTOS[nCT][5],; 
                        QUANT_ With aPRODUTOS[nCT][6],; 
                        TOTAL_ With aPRODUTOS[nCT][7],; 
                        PERIPI With aPRODUTOS[nCT][8],; 
                        VLRIPI With aPRODUTOS[nCT][9],; 
                        RECEBI With 0,; 
                        SDOREC With QUANT_ - RECEBI,; 
                        ENTREG With aPRODUTOS[nCT][10],; 
                        PERICM With aPRODUTOS[nCt][14],; 
                        VLRICM With aPRODUTOS[nCt][15],; 
                        TABELA With aPRODUTOS[nCt][5],; 
                        TABELB With aPRODUTOS[nCt][12],; 
                        CLAFIS With aPRODUTOS[nCt][13] 
                EndIf 
             EndIf 
         next 
 
         /* solicita a confirmacao da impressao */ 
         IF Confirma(24-2,65,"Imprimir?",; 
            "Digite [S] para Imprimir ou [N] para abandonar...","S") 
 
            Relatorio( "OC.REP" ) 
 
            //ImprimeOC(cORDCMP,dDATAEM,cLOCALC,cLOCALE,nTAXAF_,nTFRETE,; 
            //   cREAJUS,cDESFOR,cENDERE,cCIDADE,cESTADO,cFAX___,; 
            //   cFONE__,cCONTAT,cDESTRA,cFONTRA,nSUBTOT,cOBICM1,; 
            //   cOBICM2,nPERICM,cOBSER1,cOBSER2,cOBSER3,cOBSER4,; 
            //   nTOTALG,nFRETE_,cCOMPRA,cRESP__,cNOTA__,cCONDIC,aPRODUTOS,; 
            //   nTOTIPI,cREPDES,cREPCON,cREPFON) 
 
         ENDIF 
         nCODFOR:=0 
         cDESFOR:=spac(45) 
         cENDERE:=spac(35) 
         cCODCEP:=spac(8) 
         cBAIRRO:=spac(20) 
         cCIDADE:=spac(30) 
         cESTADO:=spac(2) 
         cREPDES:=SPAC(30) 
         cREPCON:=SPAC(30) 
         cREPFON:=SPAC(11) 
         nTAXAF_:=0 
         cFAX___:=spac(11) 
         cFONE__:=spac(11) 
         dDATAEM:=date() 
         cCOMPRA:=PAD( SWSet( _OC__COMPRADOR ), 30 ) 
         cCONTAT:=spac(30) 
         cORDCMP:=StrZero(Val(cORDCMP)+1,5,0) 
         cREAJUS:=spac(33) 
         nCODTRA:=0 
         cDESTRA:=spac(20) 
         cFONTRA:=spac(11) 
         nPERICM:=12 
         cCONDIC:=spac(15) 
         cOBSER1:=spac(70) 
         cOBSER2:=spac(70) 
         cOBSER3:=spac(70) 
         cOBSER4:=spac(70) 
         nCT:=0 
         lFIM:=.F. 
         nITEM:=1 
         nPAGINA:=1 
         cTELAR1:="" 
         nSEQUEN:=0 
         nFRETE_:=0 
         nTOTALG:=0 
         nTOTIPI:=0 
         nSUBTOT:=0 
         aPRODUTOS:={} 
      endif 
   endif 
   ScreenRest( cTela0 ) 
enddo 
DBSelectAr( _COD_FORNECEDOR ) 
Set Filter To 
ScreenRest(cTELA) 
SetColor(cCOR) 
DbunlockAll() 
FechaArquivos() 
Return Nil 
 
**** 
Stat Func frete(nCODIGO,LIN) 
If lastkey()=K_UP 
   Return(.T.) 
Elseif lastkey()=K_ENTER 
   If nCODIGO=1 
      @ LIN,27 say "<CIF>" 
   ElseIf nCODIGO=2 
      @ LIN,27 say "<FOB>" 
   Else 
      cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      VPBox( LIN-2, 25, LIN + 2, 55, " Tipo de Frete " ) 
      @ LIN-1,27 Prompt " <CIF>            " 
      @ LIN,  27 Prompt " <FOB>            " 
      Menu To nCodigo 
      ScreenRest( cTelaRes ) 
      If nCODIGO=1 
         @ LIN,27 say "<CIF>" 
      ElseIf nCODIGO=2 
         @ LIN,27 say "<FOB>" 
      ENDIF 
      IF nCodigo == 0 
         Return( .F. ) 
      ELSE 
         Return( .T. ) 
      ENDIF 
   Endif 
Endif 
Return(.T.) 
 
/* 
* Funcao      - SELFORNECEDOR 
* Finalidade  - Selecao de fornecedores a partir de outros modulos. 
* Programador - Valmor Pereira Flores 
* Data        - 12/Marco/1995 - 7:45hs. Conecsul 
* Atualizacao - 14/Marco/1995 - 8:43hs. Escoban 
*/ 
Stat Func SelFornecedor(oGET,LISTA,cREPDES,cREPCON,cREPFON) 
loca nAREA:=Select(),; 
     nORDEM:=indexord(),; 
     cTELA:=ScreenSave(07,05,24,79),; 
     cCOR:=SetColor(),; 
     nCURSOR:=Setcursor(),; 
     cCODIGO,;            //* Para pesquisa On-Line *// 
     cDESCRI              //* Para pesquisa On-Line *// 
loca nTECLA:=0,; 
     cTECLA,; 
     nCODIGO,; 
     cTELA0,; 
     cTELA1,; 
     nCT,; 
     oFOR,; 
     TECLA,; 
     nREGISTRO,; 
     GETLIST:={} 
If ValType(oGET:VarGet())=="N" 
   If oGET:VarGet()=0 
      Return(.T.) 
   Endif 
ElseIf oGET:Type=="C" 
   If oGET:VarGet()=Spac(45) 
      Return(.F.) 
   EndIf 
endif 
DbSelectAr(_COD_FORNECEDOR) 
DbSetOrder(If(ValType(oGET:VarGet())=="N",1,2)) 
If Dbseek(If(ValType(oGET:VarGet())=="N",Val(oGET:BUFFER),oGET:BUFFER),.T.) 
   If oGET:TYPE="N" 
      If LISTA[2]:VarGet()<>FOR->DESCRI 
         LISTA[2]:VarPut(FOR->DESCRI)  // Descricao 
         LISTA[3]:VarPut(FOR->ENDERE)  // Endereco 
         LISTA[4]:VarPut(FOR->CODCEP)  // Codigo do CEP 
         LISTA[5]:VarPut(FOR->CIDADE)  // Cidade 
         LISTA[6]:VarPut(FOR->ESTADO)  // Estado 
         LISTA[7]:VarPut(SubStr(FOR->VENDED,1,30))  // Contato 
         LISTA[8]:VarPut(FOR->FONE1_)  // Fone 
         LISTA[9]:VarPut(FOR->FAX___)  // FAX 
         cREPDES:=FOR->REPDES          // Representante 
         cREPCON:=FOR->REPCON          // Contato (REP) 
         cREPFON:=FOR->REPFON          // Fone Representante 
         //* Representante *// 
         cTELA1:= ScreenSave( 01, 01, 24, 79 ) 
         VPBOX( 12, 10, 16, 66, "Representante" ) 
         @ 13,11 say "Representante: "+cREPDES 
         @ 14,11 SAY "Contato......: "+cREPCON 
         @ 15,11 SAY "Fone.........: "+cREPFON 
         INKEY(0) 
         ScreenRest( cTELA1 ) 
      EndIf 
      For nCT:=2 to 5 
          LISTA[nCT]:Display() 
      Next 
   EndIf 
   DbSelectAr(_COD_PRECOXFORN) 
   Set Filter To CODFOR=FOR->CODIGO 
   DbGoTop() 
   DbSelectAr(nAREA) 
   DbSetOrder(nORDEM) 
   Return(.T.) 
EndIf 
//* Representante *// 
VPBOX( 07, 15, 11, 76, "Representante", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Usermodulo("Selecao de fornecedores") 
SetCursor(0) 
SetColor( _COR_BROWSE ) 
DBLeOrdem() 
vpbox( 12, 15, 24-4, 76, " FORNECEDORES ", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
mensagem("Para selecionar pressione [ENTER] ou [ESC] para cancelar.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [Nome/Codigo]Pesquisa [F3]Codigo [F4]Nome") 
oFOR:=tbrowsedb(13,16,24-5,75) 
oFOR:addcolumn(tbcolumnnew(,{|| StrZero(CODIGO,4,0)+" => "+DESCRI+"       "})) 
oFOR:AUTOLITE:=.f. 
oFOR:dehilite() 
whil .t. 
   oFOR:colorrect({oFOR:ROWPOS,1,oFOR:ROWPOS,1},{2,1}) 
   whil nextkey()==0 .and.! oFOR:stabilize() 
   enddo 
   LISTA[1]:VarPut(FOR->CODIGO) 
   SetColor( _COR_GET_EDICAO ) 
   If LISTA[2]:VarGet()<>FOR->DESCRI 
      LISTA[2]:VarPut(FOR->DESCRI)  // Descricao 
      LISTA[3]:VarPut(FOR->ENDERE)  // Endereco 
      LISTA[4]:VarPut(FOR->CODCEP)  // Codigo do CEP 
      LISTA[5]:VarPut(FOR->CIDADE)  // Cidade 
      LISTA[6]:VarPut(FOR->ESTADO)  // Estado 
      LISTA[7]:VarPut(SubStr(FOR->VENDED,1,30))  // Contato 
      LISTA[8]:VarPut(FOR->FONE1_)  // Fone 
      LISTA[9]:VarPut(FOR->FAX___)  // FAX 
      cREPDES:=FOR->REPDES          // Representante 
      cREPCON:=FOR->REPCON          // Contato (REP) 
      cREPFON:=FOR->REPFON          // Fone Representante 
      @ 08,17 say "Representante: "+cREPDES 
      @ 09,17 SAY "Contato......: "+cREPCON 
      @ 10,17 SAY "Fone.........: "+cREPFON 
   EndIf 
   For nCT:=2 to 5 
       LISTA[nCT]:Display() 
   Next 
   SetColor( _COR_BROWSE ) 
   if (nTECLA:=inkey(0))==K_ESC 
      exit 
   endif 
   do case 
      case nTECLA==K_UP         ;oFOR:up() 
      case nTECLA==K_LEFT       ;oFOR:up() 
      case nTECLA==K_RIGHT      ;oFOR:down() 
      case nTECLA==K_DOWN       ;oFOR:down() 
      case nTECLA==K_PGUP       ;oFOR:pageup() 
      case nTECLA==K_PGDN       ;oFOR:pagedown() 
      case nTECLA==K_CTRL_PGUP  ;oFOR:gotop() 
      case nTECLA==K_CTRL_PGDN  ;oFOR:gobottom() 
      case nTECLA==K_ENTER      ;exit 
      case nTecla==K_F2;   DBMudaOrdem( 1, oFor ) 
      case nTecla==K_F3;   DBMudaOrdem( 2, oFor ) 
      case DBPesquisa( nTecla, oFor ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oFOR:refreshcurrent() 
   oFOR:stabilize() 
enddo 
set(_SET_SOFTSEEK,.F.) 
screenrest(cTELA) 
if nTECLA<>K_ESC 
   dbselectar(_COD_PRECOXFORN) 
   set filter to CODFOR=FOR->CODIGO 
   dbgotop() 
endif 
dbselectar(nAREA) 
dbsetorder(nORDEM) 
setcolor(cCOR) 
setcursor(nCURSOR) 
For nCt:= 1 To Len( Lista ) 
    Lista[ nCt ]:Display() 
Next 
return(if(nTECLA==K_ENTER,.T.,.F.)) 
 
/* 
** Funcao      - EDITTRANSP 
** Finalidade  - Executar a edicao de transportadora 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
Stat Func edittransp(oGET,LISTA,cDESTRA,cFONTRA) 
loca cTELA:=screensave(00,00,24,79),; 
     nCURSOR:=setcursor(),; 
     cCOR:=setcolor(),; 
     nAREA:=select(),; 
     nORDEM:=indexord(),; 
     GETLIST:={} 
Loca oTB,; 
     cTELA0,; 
     TECLA,; 
     nTECLA,; 
     lDELIMITERS,; 
     nTRANSP,; 
     nCLIENT,; 
     cCODIGO,; 
     cDESCRI 
 
  dbselectar(_COD_TRANSPORTE) 
  if lastkey()=K_UP .OR. lastkey()=K_DOWN 
     dbselectar(nAREA) 
     setcolor(cCOR) 
     screenrest(cTELA) 
     return(.T.) 
  endif 
  setcolor(COR[25]) 
  vpbox(02,39,05,77,"Transportadora",COR[24],.F.,.F.,COR[23]) 
  if oGET:VarGet()=0 
     lDELIMITERS:=set(_SET_DELIMITERS,.F.) 
     set(_SET_ESCAPE,.F.) 
     @ 03,40 say "Transp..:" get cDESTRA pict "@S20" 
     @ 04,40 say "Fone....:" get cFONTRA pict "@R 999-999.99.99" 
     read 
     set(_SET_DELIMITERS,lDELIMITERS) 
     set(_SET_ESCAPE,.T.) 
     dbselectar(nAREA) 
     setcolor(cCOR) 
     screenrest(cTELA) 
     return(.T.) 
  endif 
  if dbseek(oGET:VarGet()) 
     cDESTRA:=DESCRI 
     cFONTRA:=FONE__ 
     lDELIMITERS:=set(_SET_DELIMITERS,.F.) 
     Set(_SET_ESCAPE,.F.) 
     @ 03,40 say "Transp..:" get cDESTRA pict "@S20" 
     @ 04,40 say "Fone....:" get cFONTRA pict "@R 999-999.99.99" 
     Read 
     oGET:VarPut(CODIGO) 
     Set(_SET_ESCAPE,.T.) 
     Set(_SET_DELIMITERS,lDELIMITERS) 
  else 
     VpBox(02,39,05,77,"Transportadora",COR[24],.F.,.F.,COR[23]) 
     VpBox(06,39,20,77,"Selecao de Transportadora",COR[24],.F.,.F.,COR[23]) 
     dbgotop() 
     setcursor(0) 
     setcolor(COR[25]+","+COR[22]+",,,"+COR[17]) 
     mensagem("Pressione [ENTER] p/ selecionar.") 
     ajuda("["+_SETAS+"][PgUp][PgDn]Move") 
     DBLeOrdem() 
     oTB:=tbrowsedb(07,40,19,76) 
     oTB:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" -> "+DESCRI+spac(20) })) 
     oTB:AUTOLITE:=.f. 
     oTB:dehilite() 
     whil .t. 
         oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTB:stabilize() 
         enddo 
         setcolor(COR[25]) 
         @ 03,40 say "Transp..: "+substr(DESCRI,1,27) 
         @ 04,40 say "Fone....: "+tran(FONE__,"@R 999-999.99.99") 
         nTRANSP=CODIGO 
         TECLA:=inkey(0) 
         if TECLA=K_ESC 
            nCLIENT=0 
            set(_SET_ESCAPE,.F.) 
            lDELIMITERS:=set(_SET_DELIMITERS,.F.) 
            @ 03,40 say "Transp..:" get cDESTRA pict "@S20" 
            @ 04,40 say "Fone....:" get cFONTRA pict "@R 999-999.99.99" 
            read 
            set(_SET_DELIMITERS,lDELIMITERS) 
            set(_SET_ESCAPE,.T.) 
            exit 
         endif 
         do case 
            case TECLA==K_UP         ;oTB:up() 
            case TECLA==K_LEFT       ;oTB:up() 
            case TECLA==K_RIGHT      ;oTB:down() 
            case TECLA==K_DOWN       ;oTB:down() 
            case TECLA==K_PGUP       ;oTB:pageup() 
            case TECLA==K_PGDN       ;oTB:pagedown() 
            case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
            case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
            case TECLA==K_F3         ;organiza(oTB,1);nORDEM:=indexord() 
            case TECLA==K_F4         ;organiza(oTB,2);nORDEM:=indexord() 
            case TECLA==K_ENTER .OR. TECLA=K_TAB 
                 cDESTRA:=DESCRI 
                 cFONTRA:=FONE__ 
                 lDELIMITERS:=set(_SET_DELIMITERS,.F.) 
                 set(_SET_ESCAPE,.F.) 
                 @ 03,40 say "Transp..:" get cDESTRA pict "@S20" 
                 @ 04,40 say "Fone....:" get cFONTRA pict "@R 999-999.99.99" 
                 read 
                 oGET:VarPut(CODIGO) 
                 set(_SET_ESCAPE,.T.) 
                 set(_SET_DELIMITERS,lDELIMITERS) 
                 exit 
            case Tecla==K_F2;   DBMudaOrdem( 1, oTb ) 
            case Tecla==K_F3;   DBMudaOrdem( 2, oTb ) 
            case Tecla==K_F4;   DBMudaOrdem( 3, oTb ) 
            case Tecla==K_F5;   DBMudaOrdem( 4, oTb ) 
            case DBPesquisa( Tecla, oTb ) 
            otherwise                ;tone(125); tone(300) 
         endcase 
         oTB:refreshcurrent() 
         oTB:stabilize() 
     enddo 
     setcursor(nCURSOR) 
   endif 
dbselectar(nAREA) 
setcolor(cCOR) 
screenrest(cTELA) 
return(.T.) 
 
******************************************************************************* 
func prodpesq( oGET, LISTA ) 
Loca cTELA:=screensave(00,00,24,79),; 
     cCOR:=setcolor(),; 
     nCURSOR:=setcursor(),; 
     nAREA:=select(),; 
     nORDEM:=indexord(),; 
     GETLIST:={},; 
     oPROD,; 
     cTELA0,; 
     TECLA,; 
     cCDFAB:=spac(15),; 
     nCODIGO:=0,; 
     cDESCRI:=space(45),; 
     aTELA1,; 
     nORDEMMV,; 
     nPOS,; 
     nCT,; 
     nCODPRO 
 
  /* Busca a posicao atual dentro da lista */ 
  nPOS:=ASCAN( LISTA, {|o| o:COL=oGET:COL .AND. o:ROW=oGET:ROW } ) 
 
  if lastkey() == K_UP .OR.; 
     lastkey() == K_DOWN 
     Return(.T.) 
  endif 
  if VAL( oGET:BUFFER ) == 0 
     //LISTA[nPOS]:VarPut(0)                Codigo 
     LISTA[nPOS+1]:VarPut( SPACE(36) )   // Descricao 
     LISTA[nPOS+2]:VarPut( SPACE(2) )    // Unidade 
     LISTA[nPOS+3]:VarPut( 0 )           // Preco unitario 
     LISTA[nPOS+4]:VarPut( 2 )           // Cod. ICMs. 
     LISTA[nPOS+5]:VarPut( 0 )           // Quantidade 
     LISTA[nPOS+6]:VarPut( 0 )           // Total 
     LISTA[nPOS+7]:VarPut( 0 )           // Percentual de IPI 
     LISTA[nPOS+8]:VarPut( 0 )           // Valor do IPI 
     LISTA[nPOS+9]:VarPut( DATE() )      // Data de entrega 
     For nCT:=nPOS to nPOS+9 
         LISTA[nCT]:Display() 
     Next 
     Return(.T.) 
  endif 
  dbselectar(_COD_MPRIMA) 
  dbsetorder(3) 
  nORDEMMV:=INDEXORD() 
  IF DBSEEK( STRZERO( VAL( oGET:BUFFER ), 4, 0 ) ) 
     //LISTA[nPOS]:VarPut( VAL( CODRED ) ) 
 
 
     LISTA[nPOS+1]:VarPut( DESCRI ) 
 
     #ifdef CONECSUL 
         LISTA[nPOS+1]:VarPut( SUBSTR( CODFAB + " - " + DESCRI, 1, 36 ) ) 
     #endif 
 
     LISTA[nPOS+2]:VarPut( UNIDAD ) 
     LISTA[nPOS+3]:VarPut( if( PXF->( dbseek( MPR->INDICE ) ), PXF->VALOR_, 0 ) ) 
     //LISTA[nPOS+4]:VarPut( 2 ) 
     //LISTA[nPOS+5]:VarPut( 0 ) 
     //LISTA[nPOS+6]:VarPut( 0 ) 
     //LISTA[nPOS+8]:VarPut( 0 ) 
     LISTA[nPOS+7]:VarPut( IPI___ ) 
     LISTA[nPOS+9]:VarPut( DATE() ) 
     For nCT:=nPOS to nPOS+9 
         LISTA[nCT]:Display() 
     Next 
  else 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     usermodulo(" Verificacao do Arquivo de Produtos ") 
     dbselectar(_COD_MPRIMA) 
     dbgotop() 
     setcursor(0) 
     setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
     vpbox(02,11,04,79-10) 
     vpbox(05,11,24-5,79-10,"Relacao de Produtos") 
     mensagem("Pressione [ENTER] p/ selecionar ou [ESC] p/ cancelar...") 
     ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
           "[F2]Pesquisa [F3]Codigo [F4]Cod.Fab. [F5]Nome") 
     DBLeOrdem() 
     oPROD:=tbrowsedb(06,12,24-6,79-11) 
     oPROD:addcolumn(tbcolumnnew(,{|| alltrim(CODRED)+" => "+; 
                                              CODFAB+" "+; 
                                              DESCRI+; 
                                                      "           "})) 
     oPROD:AUTOLITE:=.f. 
     oPROD:dehilite() 
     vpbox(24-4,11,24-2,79-10,"OBS",COR[21],.T.,.F.) 
     whil .t. 
        oPROD:colorrect({oPROD:ROWPOS,1,oPROD:ROWPOS,1},{2,1}) 
        whil nextkey()=0 .and.! oPROD:stabilize() 
        enddo 
        nCODPRO=val(CODRED) 
        @ 24-3,12 say spac(44) 
        if SALDO_ < ESTMIN 
           @ 24-3,12 say "Produto abaixo do estoque m�nimo: " + alltrim(str(SALDO_,5,0)) 
        else 
           @ 24-3,12 say "Saldo do produto: "+alltrim(str(SALDO_,5,0)) 
        endif 
        TECLA:=inkey(0) 
        if TECLA=K_ESC 
           exit 
        endif 
        do case 
           case TECLA==K_UP         ;oPROD:up() 
           case TECLA==K_LEFT       ;oPROD:up() 
           case TECLA==K_RIGHT      ;oPROD:down() 
           case TECLA==K_DOWN       ;oPROD:down() 
           case TECLA==K_PGUP       ;oPROD:pageup() 
           case TECLA==K_PGDN       ;oPROD:pagedown() 
           case TECLA==K_END        ;oPROD:gotop() 
           case TECLA==K_HOME       ;oPROD:gobottom() 
           case TECLA==K_ENTER 
                //* Coloca o numero no buffer *// 
                LISTA[nPOS]:VarPut( VAL( CODRED ) ) 
                //* Coloca os dados nos devidos campos *// 
                LISTA[nPOS+1]:VarPut( DESCRI ) 
                #ifdef CONECSUL 
                    LISTA[nPOS+1]:VarPut( substr(CODFAB+" - "+DESCRI,1,36) ) 
                #endif 
                LISTA[nPOS+2]:VarPut( UNIDAD ) 
                //* Pesquisa precos na tabela *// 
                LISTA[nPOS+3]:VarPut( If( PXF->( dbseek( MPR->INDICE ) ),; 
                                          PXF->VALOR_, 0 ) ) 
                //LISTA[nPOS+4]:VarPut( 2 ) 
                //LISTA[nPOS+5]:VarPut( 0 ) 
                //LISTA[nPOS+6]:VarPut( 0 ) 
                LISTA[nPOS+7]:VarPut( IPI___ ) 
                //LISTA[nPOS+8]:VarPut( 0 ) 
                LISTA[nPOS+9]:VarPut( DATE() ) 
                exit 
           case Tecla==K_F2;   DBMudaOrdem( 1, oProd ) 
           case Tecla==K_F3;   DBMudaOrdem( 2, oProd ) 
           case Tecla==K_F4;   DBMudaOrdem( 3, oProd ) 
           case Tecla==K_F5;   DBMudaOrdem( 4, oProd ) 
           case DBPesquisa( Tecla, oProd ) 
           otherwise                ;tone(125); tone(300) 
        endcase 
        oPROD:refreshcurrent() 
        oPROD:stabilize() 
     enddo 
     dbselectar(nAREA) 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
  endif 
  For nCT:=nPOS to nPOS+9 
      LISTA[nCT]:Display() 
  Next 
return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � CALCULOS 
� Finalidade  � Calcular ICMs e total de cada item na ordem de compra. 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 05/Junho/1995 
��������������� 
*/ 
Static Function Calculos( oGET, Lista, nLocalGet ) 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local GetList:= {}, oGETPR,; 
         nPos:=ASCAN( Lista, {|oGET_| oGET_:COL=oGET:COL .AND. oGET_:ROW=oGET:ROW } ) 
   Loca nPerRed, nVlrRed, nBaseIcm, nTabelaB:= 0 
 
   /* C�lculos Normais */ 
   DO CASE 
      CASE nLocalGet=1 
           Lista[nPos+1]:VarPut( VAL( oGET:BUFFER ) * Lista[nPos-1]:VarGet() ) 
      CASE nLocalGet=2 
           Lista[nPos+1]:VarPut( ( VAL( oGET:BUFFER ) * Lista[nPos-1]:VarGet() ) / 100 ) 
      CASE nLocalGet=3 
           Lista[nPos+1]:VarPut( ( VAL( oGET:BUFFER ) * Lista[nPos-3]:VarGet() ) / 100 ) 
   ENDCASE 
 
   /*����������������������� FORMAS DE CALCULO CFE ACIMA ��������������������� 
   1� Opcao => [Valor Total] = [Valor unitario] * [Quantidade] 
   2� Opcao => [Valor IPI] = ( [Percentual de IPI] * [Valor Total] ) / 100 
   3� Opcao => [Valor ICMs] = ( [Valor Total] * [Percentual de ICMs] ) / 100 
   ��Display de Gets �������������������������������������������������������Ŀ 
   � Quantidade....:                                                         � 
   � Valor Unitario: { |oGet| Calculos( oGet, GetList, 1 ) }                 � 
   � Valor Total...:                                                         � 
   � % IPI.........: { |oGet| Calculos( oGet, GetList, 2 ) }                 � 
   � Valor IPI.....:                                                         � 
   � % ICMs........: { |oGet| Calculos( oGet, GetList, 3 ) }                 � 
   � Valor ICMs....:                                                         � 
   ��������������������������������������������������������������������������� 
   */ 
 
   IF nLocalGet==3 
      nTabelaB:= Lista[ nPos-6 ]:VarGet() 
      DO Case 
         Case nTabelaB == 2          /* ICMs c/ reducao na base de calculo */ 
              nPerRed:= MPR->PerRed 
              nBaseICM:= Lista[ nPos-3 ]:VarGet() 
              nTotal:= Lista[ nPos-3 ]:VarGet() 
              VPBox( 09, 10, 14, 52, "Reducao de ICMs", _COR_ALERTA_BOX, .T., .T., _COR_ALERTA_TITULO ) 
              SetColor( _COR_ALERTA_LETRA ) 
              @ 10,11 Say "Base de Calculo ICMs.:" + Tran( nBaseIcm, "@E 999,999,999.99" ) 
              @ 11,11 Say "Percentual de Reducao:" Get nPerRed Pict "@E 999.999" 
              @ 12,11 Say "�����������������������������������������" 
              Read 
              nVlrRed:= ( nBaseIcm * nPerRed ) / 100 
              @ 13,11 Say "Valor Base de Calculo:" + Tran( nBaseIcm:= nTotal - nVlrRed, "@E 999,999,999.99" ) 
              Mensagem( "Pressione [ENTER] para continuar..." ) 
              Pausa(0) 
              Lista[nPos+1]:VarPut( nBaseIcm * Val( oGet:Buffer ) / 100 ) 
      ENDCASE 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   FOR nCt:=1 TO Len( Lista ) 
       Lista[ nCt ]:Display() 
   NEXT 
   Return .T. 
 
 
/* 
** Funcao      - BaixaOC 
** Finalidade  - Executar as baixas em Ordens de Compra 
** Programador - VALMOR PEREIRA FLORES 
** Data        - 
** Atualizacao - 
*/ 
func baixaOC() 
loca cTELA:=screensave(00,00,24,79),nCURSOR:= SetCursor(), cCOR:=SetColor() 
loca nCODIGO:=0,; 
     nCODFOR:=0,; 
     lCONTINUA:=.F.,; 
     oTAB,; 
     cTELA0,; 
     nTECLA:=0,; 
     oBROW,; 
     nCODLAN,; 
     TECLA,; 
     GETLIST:={},; 
     aDUP:={},; 
     cNFISC_,; 
     dEMISS_:=DATE(),; 
     dENTRA_:=DATE(),; 
     nCodLan2:= 0,; 
     nVALOR_:=0,; 
     nVLRICM:=0,; 
     nVLRIPI:=0,; 
     aAPAGAR:={},; 
     aPRODUTOS:={},; 
     nCT,; 
     nCT2,; 
     nLIN,; 
     cCAMPO,; 
     cORD,; 
     cDES,; 
     cTELA2 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  usermodulo("ORDEM DE COMPRA - Transf. de Prod. p/estoque") 
  inicfgcampos(1) 
  IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
     RETURN NIL 
  ENDIF 
  DBSelectAr( _COD_PAGAR ) 
  DbGoBottom() 
  nCODLAN:=CODIGO 
  nCodLan2:= CODIGO 
  DbGoTop() 
  DBSelectAr(_COD_OC) 
  setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
  DBGoBottom() 
  setcursor(0) 
  vpbox(16,00,24-2,79,"",_COR_BROW_BOX,.F.,.F.) 
  vpbox(00,00,15,79," Ordens de Compra ",_COR_GET_BOX,.F.,.F.) 
  setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
  mensagem("Teclas: [Enter][Espaco]Baixa [Nome/Codigo]Pesquisa ou [ESC]Retornar") 
  ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
  oTAB:=tbrowsedb(17,01,24-3,78) 
  oTAB:addcolumn(tbcolumnnew(,{|| OK____+; 
                                  ORDCMP + " => "+; 
                         strzero( CODFOR, 4, 0 )+; 
                          " - " + DESFOR + spac(19) } ) ) 
  oTAB:AUTOLITE:=.F. 
  oTAB:dehilite() 
 
  WHILE .T. 
 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and.! oTAB:stabilize() 
     enddo 
 
 
     SetColor( _COR_GET_BOX ) 
     @ 02,40 Say "Empresa............: " + STRZERO( FILIAL, 03, 0 )           Color "10/" + CorFundoAtual() 
     @ 02,02 say "No. Ordem de Compra: "+ORDCMP+"/"+PAGINA                    Color "15/" + CorFundoAtual() 
     @ 03,02 say "Data de Emissao....: "+dtoc(DATAEM)                         Color "10/" + CorFundoAtual() 
     @ 04,02 say "Codigo Fornecedor..: "+strzero(CODFOR,4,00)                 Color "15/" + CorFundoAtual() 
     nCODFOR:=CODFOR 
     @ 05,02 say "Nome do Fornecedor.: "+DESFOR                               Color "10/" + CorFundoAtual() 
     @ 06,02 say "Endereco...........: "+ENDERE                               Color "15/" + CorFundoAtual() 
     @ 07,02 say "Codigo do CEP......: "+tran(CODCEP,"@r 99.999-999")         Color "10/" + CorFundoAtual() 
     @ 08,02 say "Cidade.............: "+CIDADE+"-"+ESTADO                    Color "15/" + CorFundoAtual() 
     @ 09,02 say "Fone/Fax...........: "+tran(FONE__,"@R (9999)-999.99.99")+" / "+; 
                                         tran(FAX___,"@R (9999)-999.99.99")   Color "10/" + CorFundoAtual() 
     @ 10,02 say repl("�",76)                                                 Color "15/" + CorFundoAtual() 
     @ 11,02 say "Sub-Total..........: "+tran(SUBTOT,"@E ***,***,***.**")     Color "10/" + CorFundoAtual() 
     @ 12,02 say "Vlr. Frete.........: "+tran(VLRFRE,"@E ***,***,***.**")     Color "15/" + CorFundoAtual() 
     @ 13,02 say "Valor IPI..........: "+tran(VLRIPI,"@E ***,***,***.**")     Color "10/" + CorFundoAtual() 
     @ 14,02 say "Total Geral........: "+tran(TOTAL_,"@E ***,***,***.**")     Color "15/" + CorFundoAtual() 
     @ 13,40 say "RESP: "+SubStr(RESP__,1,30)                                 Color "10/" + CorFundoAtual() 
     @ 14,40 say "COMP: "+COMPRA                                              Color "15/" + CorFundoAtual() 
     setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
     if ( TECLA:=inkey(0) )==K_ESC 
        exit 
     endif 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_ENTER 
             /* Limpa variaveis aApagar / aDup */ 
             aDup:= 0 
             aApagar:= 0 
             aDup:={} 
             aApagar:= {} 
             IF OK____ = "*" 
                cTELA0:=SCREENSAVE(00,00,24,79) 
                Aviso("Este registro esta com marca de ordem de compra quitada.",13) 
                Mensagem("Pressione qualquer tecla para continuar...") 
                INKEY(0) 
                ScreenRest(cTELA0) 
             Else 
                nOperacao:= 0 
                SetCursor( 1 ) 
                cTELA0:=screensave(00,00,24,79) 
                lCONTINUA:=.F. 
                Whil lastkey()<>K_ESC 
                   DBSelectAr( _COD_OC ) 
                   IF CONTR_<>"*" .OR. lCONTINUA 
                      set(_SET_DELIMITERS,.F.) 
                      nCODIGO:=0 
                      cNFISC_:=spac(6) 
                      nVALOR_:=0 
                      dEMISS_:=date() 
                      dENTRA_:=DATE() 
                      nVLRICM:=0 
                      nVLRIPI:=0 
                      nVlrFre:= 0 
                      cConFre:= Space( 10 ) 
                      dVenFre:= CTOD( "  /  /  " ) 
                      /* Seleciona o codigo de lancamento */ 
                      DBSelectAr( _COD_PAGAR ) 
                      DBGoBottom() 
                      nCodLan:= CODIGO 
                      /* Prepara a tela para lancamento */ 
                      vpbox(03,03,17,76,"Contas a Pagar",setcolor(),.t.,.f.) 
 
                      @ 04,04 say "Codigo de lancamento:" 
                      @ 04,40 Say "Operacao:" get nOperacao Pict "999" Valid BuscaOperacao( @nOperacao ) 
                      @ 05,04 say "������������������������������������������������������������������������" 
                      @ 06,04 say "Nota Fiscal:" get cNFISC_ 
                      @ 07,04 say "Emissao....:" get dEMISS_ 
                      @ 08,04 say "Entrada....:" get dENTRA_ 
                      @ 05,04 say "Codigo Reg.: "+StrZero(++nCODLAN,4,0) 
                      @ 06,31 say "�Total:" get nVALOR_ pict "@E 999,999,999.99" 
                      @ 07,31 say "�ICMs.:" get nVLRICM pict "@E 999,999,999.99" 
                      @ 08,31 say "�IPI..:" get nVLRIPI pict "@E 999,999,999.99" 
                      @ 06,54 Say "Vlr. Frete:" Get nVlrFre Pict "@E 999,999.99" 
                      @ 07,54 Say "N� Conhec.:" Get cConFre 
                      @ 08,54 Say "Vencimento:" Get dVenFre 
                      @ 09,04 say "������������������������������������������������������������������������" 
                      @ 10,04 say "Dp�Duplicata �Valor        �Bco�Vencim. �Dat.Pgto�Cheque  �Observacoes  " 
                      @ 11,04 say "01�          �             �   �        �        �        �             " 
                      @ 12,04 say "02�          �             �   �        �        �        �             " 
                      @ 13,04 say "03�          �             �   �        �        �        �             " 
                      @ 14,04 say "04�          �             �   �        �        �        �             " 
                      @ 15,04 say "������������������������������������������������������������������������" 
                      @ 16,04 say "Total        �             �" 
                      nLIN:=10 
                      nCT:=0 
 
 
                      FOR nCT:=1 to 4 
                          aadd( aDUP, { strzero(nCT,1,0),;      // 1=Codigo 
                                             spac(10),;         // 2=Documento 
                                             0,;                // 3=Banco 
                                             date(),;           // 4=Vencimento 
                                             0,;                // 5=Valor 
                                             ctod("  /  /  "),; // 6=Data de pagamento 
                                             spac(40),;         // 7=Observacoes 
                                             0,;                // 8=Juros 
                                             spac(12),;         // 9=Cheque 
                                             0,;                // 0=Vlr. IPI 
                                             0 } )              // 1=Vlr. ICM 
 
                          @ ++nLIN,07 get aDUP[nCT][2] 
                          @ nLIN,18 get   aDUP[nCT][5] Pict "@E 9999999999.99" 
                          @ nLIN,32 get   aDUP[nCT][3] Pict "999" 
                          @ nLIN,36 get   aDUP[nCT][4] 
                          @ nLIN,45 get   aDUP[nCT][6] 
                          @ nLIN,54 get   aDUP[nCT][9] Pict "@S8" 
                          @ nLIN,63 get   aDUP[nCT][7] pict "@S13" 
                      next 
                      read 
 
                      // Lan�a Cabecalho da Nota Fiscal - Se for o caso 
                      IF LastKey() <> K_ESC 
                         IF !EMPTY( cNFisc_ ) 
                            EST->( DBAppend() ) 
                            Repl EST->CODIGO With nCodFor,; 
                                 EST->CODRED With "***<NOTA>***",; 
                                 EST->DOC___ With Alltrim( cNFisc_ ),; 
                                 EST->ENTSAI With "+",; 
                                 EST->NATOPE With OPE->( NATOPE ),; 
                                 EST->PERICM With 0,; 
                                 EST->CPROD_ With "***<NOTA>***",; 
                                 EST->QUANT_ With 0,; 
                                 EST->VLRSAI With nVALOR_,; 
                                 EST->VALOR_ With nVALOR_,; 
                                 EST->DATAMV With dENTRA_,; 
                                 EST->RESPON With nGCodUser,; 
                                 EST->CODMV_ With nOperacao,; 
                                 EST->VLRBAS With nVALOR_,; 
                                 EST->VLRICM With nVLRICM,; 
                                 EST->DATANF With dEMISS_,; 
                                 EST->VLRIPI With nVLRIPI 
                         ENDIF 
                         // Fim da gravacao da nota 
                      ENDIF 
 
                      For nCT:=1 to 4 
                          IF aDup[nCt][5] > 0 
                             aadd( aAPAGAR, { nCODLAN++,; 
                                              aDUP[nCT][2],; 
                                              aDUP[nCT][3],; 
                                              aDUP[nCT][4],; 
                                              aDUP[nCT][5],; 
                                              aDUP[nCT][6],; 
                                              aDUP[nCT][7],; 
                                              dEMISS_,; 
                                              aDUP[nCT][8],; 
                                              aDUP[nCT][10],; 
                                              aDUP[nCT][11],; 
                                              nVALOR_,;           // Valor 
                                              VAL( cNFISC_ ),;    // Nota 
                                              dENTRA_,; 
                                              nVlrIpi,; 
                                              nVlrIcm } ) 
                          ENDIF 
                      Next 
                      IF nVlrFre > 0 
                         /* Caso seja informado os dados de frete */ 
                         /* sera feito os lancamentos cfe. abaixo */ 
                         AAdd( aAPAGAR, { nCODLAN,; 
                                           "FRETE",; 
                                           0,; 
                                           dVenFre,; 
                                           nVlrFre,; 
                                           CTOD( "  /  /  " ),; 
                                           "FRETE NF " + Alltrim( cNFisc_ ) + ", CONHEC. " + cConFre + ".",; 
                                           dEMISS_,; 
                                           0,; 
                                           0,; 
                                           0,; 
                                           nVlrFre,;           // Valor 
                                           VAL( cNFISC_ ),;    // Nota 
                                           dENTRA_,; 
                                           0,; 
                                           0 } ) 
                      ENDIF 
                      if Lastkey() == K_ESC   .OR. ; 
                         LastKey() == K_PGDN  .OR. ; 
                         LastKey() == K_ENTER 
                         Inkey() 
                         if confirma(16,32,"Confirma a gravacao destes dados?",; 
                            "Digite [S] para Salvar ou [N] para abandonar...","S") 
                            DBSelectAr( _COD_OC ) 
                            If netrlock(5) 
                               repl CONTR_ with "*" 
                            endif 
                            DBUnlockAll() 
                            DbSelectAr(_COD_PAGAR) 
                            For nCT:=1 to Len(aAPAGAR) 
                                If aAPAGAR[nCT][5]<>0 
                                   DbAppend() 
                                   Replace CODIGO With aApagar[nCt][1],; 
                                           DOC___ With aAPagar[nCT][2],; 
                                           CODFOR With nCodFor,; 
                                           BANCO_ With aAPagar[nCT][3],; 
                                           VENCIM With aAPagar[nCT][4],; 
                                           VALOR_ With aAPagar[nCT][5],; 
                                           DATAPG With aAPagar[nCT][6],; 
                                           OBSERV With aAPagar[nCT][7],; 
                                           EMISS_ With dEmiss_,;         //aAPAGAR[nCT][8],; 
                                           JUROS_ With aAPagar[nCT][9],; 
                                           VLRIPI With aApagar[nCt][15],; 
                                           VLRICM With aApagar[nCt][16],; 
                                           NFISC_ With aAPagar[nCT][13],; 
                                           DENTRA With aAPagar[nCT][14],; 
                                           QUITAD With IF( aAPagar[ nCt ][ 6 ] == CTOD( "  /  /  " ), "N", "S" ),; 
                                           TABOPE With 2 
                                Endif 
                            Next 
                            DbSelectAr(_COD_OC) 
                            nCT2:=0 
                            For nCT:=1 to Len(aAPAGAR) Step +4 
                                cCAMPO:=StrZero(++nCT2,2,0) 
                                If nCT2<=20 
                                   If netrlock(5) 
                                      EVAL( FIELDBLOCK( "NFIS"+StrZero(nCT,2,0) ), aAPAGAR[nCT][13] ) 
                                   Endif 
                                   DBUnlockAll() 
                                Endif 
                            Next 
                            IF Confirma( 00,00, "Continuar lancando duplicatas?",,"S" ) 
                               /* Limpa variaveis aApagar / aDup */ 
                               aDup:= 0 
                               aApagar:= 0 
                               aDup:={} 
                               aApagar:= {} 
                               lCONTINUA:= .T. 
                            ELSE 
                               lCONTINUA:= .F. 
                               ScreenRest( cTela0 ) 
                               Exit 
                            ENDIF 
                         ELSE 
                            DbSelectAr(_COD_OC) 
                         endif 
                      endif 
                      ScreenRest(cTELA0) 
                   ELSE 
                      cTELA0:=screensave(00,00,24,79) 
                      vpbox(09,03,14,68,"Contas a Pagar",setcolor(),.t.,.f.) 
                      @ 10,04 say " OBS: Os dados de contas a pagar ja foram informados na primei- " 
                      @ 11,04 say " ra vez em que esta ordem de compra foi acionada. As  possiveis " 
                      @ 12,04 say " alteracoes ou quitacao de duplicatas deverao ser efetuadas  a- " 
                      @ 13,04 say " partir do modulo de contas a pagar.                            " 
                      IF Confirma(17,14,"Deseja Incluir mais contas a partir deste modulo?","","N") 
                         lCONTINUA:=.T. 
                         ScreenRest(cTELA0) 
                      ElSE 
                         ScreenRest(cTELA0) 
                         lCONTINUA:=.F. 
                         Exit 
                      ENDIF 
                      ScreenRest(cTELA0) 
                   ENDIF 
                ENDDO 
                SETCOLOR("W+/B");SCROLL(02,02,14,77) 
                ScreenRest(cTELA0) 
                DbSelectAr(_COD_OC) 
                ProdBaixa( oTAB, ORDCMP, IF( !Empty( cNFisc_ ), Val( cNFisc_ ), 0 ), nOperacao ) 
             ENDIF 
             SetCursor(0) 
        case Tecla==K_F2;   DBMudaOrdem( 1, oTab ) 
        case Tecla==K_F3;   DBMudaOrdem( 2, oTab ) 
        case Tecla==K_F4;   DBMudaOrdem( 3, oTab ) 
        case Tecla==K_F5;   DBMudaOrdem( 4, oTab ) 
        case DBPesquisa( Tecla, oTab ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  screenrest(cTELA) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  return nil 
 
/***** 
�������������Ŀ ************************************************************* 
� Funcao      � ProdBaixa() 
� Finalidade  � Baixa de produtos no estoque. 
� Parametros  � oTab=> Objeto Browse 
�             � CodOrdem=> Codigo indicador da ordem 
� Retorno     � NIL 
� Programador � Valmor Pereira Flores 
� Data        � 25/Setembro/1995 
��������������� ************************************************************* 
*/ 
Static Function ProdBaixa( oTB, CODORDEM, nNota, nOperacao ) 
  //* Define variaveis locais *// 
 LOCAL cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor(), GETLIST:={},; 
       nAREA:=select(), nORDEM:=indexord() 
 LOCAL cCPROD_:=spac(12),; 
       dDATAMV:=date(),; 
       cCODRED:=spac(12),; 
       cCODIGO:=spac(12),; 
       cENTSAI:="+",; 
       nQUANT_:=0,; 
       cRAZAO_:="1",; 
       cDOC___:=spac(15),; 
       nVLRSDO:=0,; 
       cVLRSAI:=0,; 
       nVENIN_:=0,; 
       nVENEX_:=0,; 
       nCODCLI:=0,; 
       CODFOR:=0,; 
       nRESPON:=0,; 
       cANULAR:=" ",; 
       cARQINDICE:="VPCOMP.TMP",; 
       nCT:=0,; 
       oTAB,; 
       nVlrIcm:= 0,; 
       nFLAG:=0,; 
       nAREA0,; 
       nORDEM0,; 
       cTELA0,; 
       TECLA,; 
       cTELA1,; 
       cCODPRO,; 
       nCODFOR 
  //* Seleciona arquivo auxiliar a ordem de compra *// 
  dbselectar(_COD_OC_AUXILIA) 
  //* Pesquisa se existe algum arquivo de indice criado por outro usuario *// 
  for nCT:=0 to 99 
      if !file("STATUS"+strzero(nCT,2,0)+".TMP") 
         cARQINDICE:="STATUS"+strzero(nCT,2,0)+".TMP" 
         nCT:=99 
      endif 
  next 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  index on ORDCMP to &cARQINDICE for ORDCMP == CodOrdem eval {|| Processo() } 
  scroll(02,40,14,77) 
 
  SetColor( _COR_BROWSE ) 
 
  //* Elabora o TBROWSE para apresentar os produtos pendentes *// 
  oTAB:=tbrowsedb(02,02,14,38) 
  oTAB:addcolumn(tbcolumnnew(,{|| OK____+; 
                          strzero(ITEM__,3,0)+"�"+; 
                          alltrim(CODPRO)+" - "+; 
                           substr(DESPRO,1,13)+spac(19) })) 
  oTAB:AUTOLITE:=.F. 
  oTAB:dehilite() 
 
  SETCOLOR( "W+/B" ) 
  SCROLL( 02,01,14,78 ) 
 
  whil .t. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and.! oTAB:stabilize() 
     enddo 
     //* Apresenta informacoes *// 
     setcolor("W+/B") 
     @ 02,40 say "Codigo................: "+alltrim(CODPRO) 
     cCODPRO:=CODPRO 
     nCODFOR:=OC->CODFOR 
     setcolor("BG/B") 
     @ 03,40 say "Nome..................: "+substr(DESPRO,1,12) 
     setcolor("W+/B") 
     @ 04,40 say "Preco Unitario........: "+tran(PRECOU,"@E *,***,***.***") 
     setcolor("BG/B") 
     @ 05,40 say "Preco total (Unit*Qtd): "+tran(TOTAL_,"@E *,***,***.***") 
     setcolor("W+/B") 
     @ 06,40 say "Qtd. Solicitada.......: "+str(QUANT_,13,3) 
     setcolor("BG/B") 
     @ 07,40 say "Qtd. Recebida.........: "+str(RECEBI,13,3) 
     setcolor("W+/B") 
     @ 08,40 say "Qtd. Pendente.........: "+str(SDOREC,13,3) 
     setcolor("BG/B") 
     @ 09,40 say "Qtd. Deste recebimento:             " 
     setcolor("W+/B") 
     @ 10,40 say "Data de Recebimento...:             " 
     setcolor("BG/B") 
     @ 11,40 say "Sdo. Atual em Estoque.: " 
     setcolor("W+/B") 
     @ 12,40 say "Data de Emissao de O.C: "+dtoc(OC->DATAEM) 
     setcolor("BG/B") 
     @ 13,40 say "Data limite p/ entrega: "+dtoc(ENTREG) 
     setcolor("W+/B") 
     @ 14,40 say "Fornecedor............: "+substr(OC->DESFOR,1,13) 
 
     //* Espera por uma tecla e testa se foi ESC(27) *// 
     if ( TECLA:=inkey(0) )==K_ESC 
        exit 
     endif 
 
     //* Testa a tecla pressionada *// 
     SetColor( _COR_BROWSE ) 
 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_ENTER 
             nORDEM0:=IndexOrd() 
             nAREA0:=select() 
             set(_SET_DELIMITERS,.F.) 
             nQUANT_:=0 
             nPrecoU:= PRECOU 
             nPerIcm:= PERICM 
             @ 04,40 Say "Preco Unitario........:" Get nPrecoU Pict "@E *,***,***.***" 
             @ 09,64 get nQUANT_ pict "@E 99999999.999" when; 
               mensagem("Digite a quantidade de itens a dar baixa.") 
             @ 10,64 get dDATAMV when; 
               mensagem("Digite a data para baixa no estoque.") 
             read 
 
             // VALMOR:AQUI! 
             IF LastKey() <> K_ESC 
                if netrlock(5) 
                   repl RECEBI with RECEBI+nQUANT_,; 
                        SDOREC with SDOREC-nQUANT_,; 
                        URECEB with dDATAMV 
                endif 
                AtualPrecoCompra( CODPRO, nPrecoU, nCodFor ) 
                dbUnlockAll() 
                dbselectar(_COD_ESTOQUE) 
                /* movimento de estoque */ 
                mensagem("Dando baixa no arquivo de estoque, aguarde....",1) 
                If dDataMv<>ctod("  /  /  ") .AND. nQuant_ > 0 
                   nVlrIcm:= ( ( nPrecoU * nQuant_ ) * nPerIcm ) / 100 
 
                   LancEstoque( cCodPro, cCodPro, "+", IF( nNota <> 0, Alltrim( Str( nNota ) ), "OC: " + CodOrdem ), nCodFor,; 
                               0, ( nPrecoU * nQuant_ ), nQuant_, nGCodUser, dDataMv, nVlrIcm, 0, 0, nOperacao ) 
 
                   Keyboard Chr( K_RIGHT ) 
                   IF SWAlerta( "<<< ROMANEIO DE ENTRADA >>>; Deseja registrar romaneio de entrada; para este item da Ordem de Compra?",  { "Sim", "Nao" } )==1 
                      Romaneio( CodOrdem, cCodPro, nQuant_, nCodFor, nNota ) 
                   ENDIF 
                EndIf 
             ENDIF 
             set(_SET_DELIMITERS,.T.) 
             dbselectar(nAREA0) 
             dbsetorder(nORDEM0) 
 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
enddo 
dbselectar(_COD_OC_AUXILIA) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/ocaind01.ntx" 
#else 
  set index to "&GDIR\OCAind01.NTX" 
#endif
dbselectar(nAREA) 
dbsetorder(nORDEM) 
if File(cARQINDICE) 
   Ferase(cARQINDICE) 
endif 
screenrest(cTELA) 
setcolor(cCOR) 
setcursor(nCURSOR) 
oTB:refreshall() 
whil ! oTB:stabilize() 
enddo 
return nil 
 
/* 
** Funcao      - ALTERAOC 
** Finalidade  - Executar Alteracoes em Ordens de Compra 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
func alteraOC() 
loca cTELAR:=screensave(00,00,24,79),nCURSOR:= SetCursor(), cCOR:=SetColor(), nTECLA:=0, oBROW 
LOCA cTELA:=cTELAR 
loca nCODIGO:=0, nCODFOR:=0, oTAB, oTB, TECLA,; 
     cDESFOR, cENDERE, cCODCEP, cBAIRRO, cCIDADE, cESTADO, cLOCALE,; 
     cLOCALC, nTAXAF_, cFAX___, dDATAEM, cCOMPRA, cRESP__, cCONTAT,; 
     cORDCMP, cREAJUS, nCODTRA, cDESTRA, cFONTRA, nPERICM, cCONDIC,; 
     cOBSER1, cOBSER2, cOBSER3, cOBSER4, nCT:=0, nPAGINA:=1,; 
     cNOTA__, cOBICM1, cOBICM2, nFRETE_, nTOTIPI, nSUBTOT,; 
     nTFRETE, cFONE__, nTOTALG, GETLIST:={},; 
     nLIN, nROW:=1, nCOL,; 
     cTELA2,; 
     cORD,; 
     cDES,; 
     aPRODUTOS:={},; 
     nCODLAN,; 
     cTELA0,; 
     cREPDES,; 
     cREPCON,; 
     cREPFON,; 
     CODORDEM:="00000" 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo("ORDEM DE COMPRA - Alteracao de dados") 
  IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
     RETURN NIL 
  ENDIF 
  inicfgcampos(1) 
  SETCURSOR(0) 
  DBSelectAr( _COD_PAGAR ) 
  DbGoBottom() 
  nCODLAN:=CODIGO 
  DbGoTop() 
  DBSelectAr(_COD_OC) 
  DBGoBottom() 
  setcursor(0) 
  vpbox(16,00,24-2,79,"Ordens de Compra (Banco de dados)",_COR_BROW_BOX,.F.,.F.) 
  vpbox(01,00,15,79,,_COR_GET_BOX,.F.,.F.) 
  setcolor( _COR_BROWSE ) 
  mensagem("Pressione [TAB] para imprimir ou [ENTER] para alterar.") 
  ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
  DBLeOrdem() 
  oTAB:=tbrowsedb(17,01,24-3,78) 
  oTAB:addcolumn( tbcolumnnew(, {|| OK____ +; 
                                    ORDCMP + " => "+; 
                            strzero(CODFOR,4,0) + " - "+; 
                                    DESFOR + spac(19); 
                                     } ) ) 
  oTAB:AUTOLITE:=.F. 
  oTAB:dehilite() 
  whil .t. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and.! oTAB:stabilize() 
     enddo 
 
     SetColor( _COR_GET_BOX ) 
     @ 02,40 Say "Empresa............: " + STRZERO( FILIAL, 03, 0 ) Color "10/" + CorFundoAtual() 
     @ 02,02 say "No. Ordem de Compra: "+ORDCMP+"/"+PAGINA          Color "15/" + CorFundoAtual() 
     @ 03,02 say "Data de Emissao....: "+dtoc(DATAEM)               Color "10/" + CorFundoAtual() 
     @ 04,02 say "Codigo Fornecedor..: "+strzero(CODFOR,4,00)       Color "15/" + CorFundoAtual() 
     nCODFOR:=CODFOR 
     @ 05,02 say "Nome do Fornecedor.: "+DESFOR                     Color "10/" + CorFundoAtual() 
     @ 06,02 say "Endereco...........: "+ENDERE                     Color "15/" + CorFundoAtual() 
     @ 07,02 say "Codigo do CEP......: "+tran(CODCEP,"@r 99.999-999") Color "10/" + CorFundoAtual() 
     @ 08,02 say "Cidade.............: "+CIDADE+"-"+ESTADO            Color "15/" + CorFundoAtual() 
     @ 09,02 say "Fone/Fax...........: "+tran(FONE__,"@R (9999)-999.99.99")+" / "+; 
                                         tran(FAX___,"@R (9999)-999.99.99")  Color "10/" + CorFundoAtual() 
     @ 10,02 say repl("�",76)                  Color "15/" + CorFundoAtual() 
     @ 11,02 say "Sub-Total..........: "+tran(SUBTOT,"@E ***,***,***.**") Color "10/" + CorFundoAtual() 
     @ 12,02 say "Vlr. Frete.........: "+tran(VLRFRE,"@E ***,***,***.**") Color "15/" + CorFundoAtual() 
     @ 13,02 say "Valor IPI..........: "+tran(VLRIPI,"@E ***,***,***.**") Color "10/" + CorFundoAtual() 
     @ 14,02 say "Total Geral........: "+tran(TOTAL_,"@E ***,***,***.**") Color "15/" + CorFundoAtual() 
     @ 13,40 say "RESP: "+SubStr(RESP__,1,30)                             Color "10/" + CorFundoAtual() 
     @ 14,40 say "COMP: "+COMPRA                                          Color "15/" + CorFundoAtual() 
 
     setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
     if ( TECLA:=inkey(0) )==K_ESC 
        exit 
     endif 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_SPACE .OR. TECLA == 32 
             RLOCK() 
             IF !NETERR() 
                REPL OK____ WITH IF( OK____="*", " ", "*" ) 
             ENDIF 
             DBUNLOCKAll() 
 
        case TECLA==K_TAB 
 
             IF Confirma( 0, 0, "Imprimir esta ordem de compra?", "Digite [S] para imprimir ou [N] para cancelar.", "N" ) 
 
                Relatorio( "OC.REP" ) 
 
             ENDIF 
 
        case TECLA==K_ENTER 
             IF OK____ = "*" 
                cTELA0:=SCREENSAVE(00,00,24,79) 
                Aviso("Este registro esta com marca de ordem de compra quitada.",13) 
                Mensagem("Pressione qualquer tecla para continuar...") 
                INKEY(0) 
                SCREENREST(cTELA0) 
             ELSE 
                cTELA0:=ScreenSave(00,00,24,79) 
                CODORDEM:=ORDCMP 
                nCODFOR:=CODFOR 
                cDESFOR:=DESFOR 
                cENDERE:=ENDERE 
                cCODCEP:=CODCEP 
                cBAIRRO:="" 
                cCIDADE:=CIDADE 
                cESTADO:=ESTADO 
                cREPDES:=REPDES 
                cREPCON:=REPCON 
                cREPFON:=REPFON 
                cLOCALE:=LOCALE 
                cLOCALC:=LOCALC 
                nTAXAF_:=TAXAF_ 
                cFAX___:=FAX___ 
                dDATAEM:=DATAEM 
                cCOMPRA:=COMPRA 
                cRESP__:=RESP__ 
                cCONTAT:=CONTAT 
                cORDCMP:=ORDCMP 
                cREAJUS:=REAJUS 
                nCODTRA:=CODTRA 
                cDESTRA:=DESTRA 
                cFONTRA:=FONTRA 
                nPERICM:=PERICM 
                cCONDIC:=CONDIC 
                cOBSER1:=OBSER1 
                cOBSER2:=OBSER2 
                cOBSER3:=OBSER3 
                cOBSER4:=OBSER4 
                nCT:=0 
                nPAGINA:=1 
                cNOTA__:=NOTA__ 
                cOBICM1:=OBICM1 
                cOBICM2:=OBICM2 
                nFRETE_:=VLRFRE 
                nTOTIPI:=VLRIPI 
                nSUBTOT:=SUBTOT 
                nTFRETE:=val(TFRETE) 
                cFONE__:=FONE__ 
                nTOTALG:=TOTAL_ 
                nSEQUEN:=0 
                dbselectar(_COD_OC_AUXILIA) 
                Set Filter To ORDCMP=CODORDEM 
                DBGOTOP() 
                aPRODUTOS:= {} 
                WHIL ! EOF() 
                    AADD( aPRODUTOS, {; 
                                                Left( CODPRO, 7 ),; 
                                                DESPRO,; 
                                                UNIDAD,; 
                                                PRECOU,; 
                                                CODICM,; 
                                                QUANT_,; 
                                                TOTAL_,; 
                                                PERIPI,; 
                                                VLRIPI,; 
                                                ENTREG,; 
                                                RECEBI,; 
                                                TABELB,; 
                                                CLAFIS,; 
                                                PERICM,; 
                                                VLRICM } ) 
                    DBSKIP() 
                ENDDO 
                nLIN:=20 
                If Len(aPRODUTOS)>0 
                   If Len(aPRODUTOS)<15 
                      nLIN:=08+Len(aPRODUTOS) 
                   EndIf 
                   nLIN:=nLIN 
                   nROW:=1 
                   vpbox(02,04,22,76,"Alteracao",COR[21]) 
                   setcolor(COR[21]+","+COR[22]) 
                   setcursor(0) 
                   SET(_SET_DELIMITERS,.T.) 
                   SETCURSOR(1) 
                   @ 03,05 say "Fornecedor.......:" get nCODFOR pict "9999" when; 
                     mensagem("Digite o codigo do fornecedor.") valid; 
                    {|oGET|selfornecedor(oGET,GETLIST,@cREPDES,@cREPCON,@cREPFON)} 
                   @ 04,05 say "Nome.............:" get cDESFOR pict "@S40" when; 
                     mensagem("Digite o nome do fornecedor.") valid; 
                     {|oGET|selfornecedor(oGET,GETLIST,@cREPDES,@cREPCON,@cREPFON)} 
                   @ 05,05 say "Endereco.........:" get cENDERE pict "@S30" 
                   @ 06,05 say "CEP..............:" get cCODCEP pict "@r 99.999-999" 
                   @ 07,05 say "Cidade...........:" get cCIDADE 
                   @ 08,05 say "UF...............:" get cESTADO valid veruf(@cESTADO) 
                   @ 09,05 say "Contato..........:" get cCONTAT 
                   @ 10,05 say "Fone.............:" get cFONE__ pict "@R 9999-999.99.99" 
                   @ 11,05 say "FAX..............:" get cFAX___ pict "@R 9999-999.99.99" 
                   @ 12,05 say "Local de Entrega.:" get cLOCALE 
                   @ 13,05 say "Local de Cobranca:" get cLOCALC 
                   @ 14,05 say "Taxa Financeira..:" get nTAXAF_ pict "@E 999,999,999,999.99" 
                   @ 15,05 say "Condicoes........:" get cCONDIC 
                   @ 16,05 say "Reajuste.........:" get cREAJUS 
                   @ 17,05 say "Transportadora...:" get nCODTRA pict "999" valid {|oGET|edittransp(oGET,GETLIST,@cDESTRA,@cFONTRA)} 
                   @ 18,05 say "Total do frete...:" get nFRETE_ pict "@E 999,999,999,999.99" 
                   @ 19,05 say "Tipo de frete....:" get nTFRETE pict "9" valid frete(@nTFRETE,19) 
                   @ 20,05 say "Percentual de ICM:" get nPERICM pict "@E 999.99" 
                   @ 21,05 say "Data.............:" get dDATAEM 
                   @ 21,35 say "Comp:" get cCOMPRA pict "@S15" 
                   @ 21,60 say "Resp:" get cRESP__ pict "@S08" 
                   READ 
                   SETCURSOR(0) 
                   SET(_SET_DELIMITERS,.F.) 
                   VPBox( 01, 04, 04, 79, " DESCRICAO DO ITEM ", COR[21] ) 
                   VpBox( 05, 04, nLIN+2, 79, "ITENS", COR[21] ) 
                   @ 06,05 Say "Cod.     �Produto     �Un�Valor Unitar� Quantidade "+; 
                                                   "� Vlr. Total �  Data  " 
                   @ 07,05 Say "��������ͳ�����������ͳ�ͳ�����������ͳ������������"+; 
                                                   "������������ͳ���������" 
 
                   Mensagem( "[INS]Inserir [DEL]Excluir [ENTER]Alterar" ) 
                   oTB:=tbrowsenew(08,05,nLIN+1,78) 
                   oTB:addcolumn( tbcolumnnew(,{|| Tran( aPRODUTOS[nROW][1], "@R 999-9999" ) } ) ) 
                   oTB:addcolumn( tbcolumnnew(, {|| SUBSTR( aPRODUTOS[nROW][2], 1, 12 ) } ) ) 
                   oTB:addcolumn( tbcolumnnew(, {|| aPRODUTOS[nROW][3] } ) ) 
                   oTB:addcolumn( tbcolumnnew(, {|| Tran( aPRODUTOS[nROW][4],"@E 9999999.9999" ) } ) ) 
                   oTB:addcolumn( tbcolumnnew(, {|| Tran( aPRODUTOS[nROW][6],"@E 9999999.9999" ) } ) ) 
                   oTB:addcolumn( tbcolumnnew(, {|| Tran( aPRODUTOS[nROW][7],"@E 9999999.9999" ) } ) ) 
                   oTB:addcolumn( tbcolumnnew(, {|| aPRODUTOS[nROW][10] } ) ) 
                   oTB:COLSEP:="�" 
                   oTB:AUTOLITE:=.f. 
                   oTB:GOTOPBLOCK :={|| nROW:=1} 
                   oTB:GOBOTTOMBLOCK:={|| nROW:=len(aPRODUTOS)} 
                   oTB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPRODUTOS,@nROW)} 
                   oTB:dehilite() 
                   whil .t. 
                       oTB:colorrect({oTB:ROWPOS,2,oTB:ROWPOS,2},{2,1}) 
                       whil nextkey()==0 .and. ! oTB:stabilize() 
                       end 
                       @ 02,06 Say aProdutos[nRow][1] 
                       @ 03,06 Say aProdutos[nRow][2] 
                       nTECLA:=inkey(0) 
                       if nTECLA==K_ESC   ;exit   ;endif 
                       do case 
                          case nTECLA==K_UP         ;oTB:up() 
                          case nTECLA==K_DOWN       ;oTB:down() 
                          case nTECLA==K_LEFT       ;oTB:up() 
                          case nTECLA==K_RIGHT      ;oTB:down() 
                          case nTECLA==K_PGUP       ;oTB:pageup() 
                          case nTECLA==K_CTRL_PGUP  ;oTB:gotop() 
                          case nTECLA==K_PGDN       ;oTB:pagedown() 
                          case nTECLA==K_CTRL_PGDN  ;oTB:gobottom() 
                          Case nTecla==K_DEL 
                               ADel( aProdutos, nRow ) 
                               ASize( aProdutos, Len( aProdutos ) - 1 ) 
                               oTb:refreshAll() 
                               WHILE !oTb:Stabilize() 
                               ENDDO 
                          Case nTECLA==K_INS 
                               VisualProdutos() 
                               AAdd( aProdutos, { MPR->INDICE,; 
                                                  MPR->DESCRI,; 
                                                  MPR->UNIDAD,; 
                                                  PXF->VALOR_,; 
                                                  MPR->ICMCOD,; 
                                                  1,; 
                                                  PXF->VALOR_,; 
                                                  0,; 
                                                  0,; 
                                                  CTOD( "  /  /  " ),; 
                                                  0,; 
                                                  0,; 
                                                  0,; 
                                                  0,; 
                                                  0 } ) 
                               #ifdef CONECSUL 
                                    aProdutos[ Len( aProdutos ) ][ 2 ]:= SUBSTR( MPR->CODFAB + " - " + MPR->DESCRI, 1, 36 ) 
                               #endif 
                               oTb:GoBottom() 
                               oTb:RefreshAll() 
                               WHILE !oTb:Stabilize() 
                               ENDDO 
                          case nTECLA==K_ENTER 
                               cTELA2:=SCREENSAVE(00,00,24,79) 
                               SET( _SET_DELIMITERS, .T. ) 
                               nLIN:=8; nCOL:=9 
                               VPBOX( nLIN, nCOL-1, nLIN+13, nCOL+65, "Edicao do Produto", _COR_GET_BOX ) 
                               SetColor( _COR_GET_EDICAO ) 
                               SetCursor( 1 ) 
                               @ ++nLin, nCol SAY "Codigo Produto......: [" + Tran( aProdutos[nRow][1], "@R 999-9999" ) + "]" 
                               @ ++nLin, nCol SAY "Descricao do Produto: ["+  aPRODUTOS[nROW][2] + "]" 
                               @ ++nLin, nCol SAY "Unidade de Medida...:" GET aPRODUTOS[nROW][3] 
                               @ ++nLin, nCol SAY "Codigo do ICMs......:" GET aPRODUTOS[nROW][5] PICT "9" 
                               @ ++nLin, nCol SAY "Quantidade..........:" GET aPRODUTOS[nROW][6] PICT "@E 999,999,999.999" 
                               @ ++nLin, nCol Say "Valor Unitario......:" Get aProdutos[nRow][4] Pict "999999.999"         Valid { |oGET| Calculos( oGet, GetList, 1 ) } 
                               @ ++nLin, nCol SAY "Valor Total.........:" GET aPRODUTOS[nROW][7] PICT "@E 999,999,999.999" 
                               @ ++nLin, nCol SAY "Percentual de IPI...:" GET aPRODUTOS[nROW][8] PICT "999.99"             Valid { |oGET| Calculos( oGet, GetList, 2 ) } 
                               @ ++nLin, nCol SAY "Total do IPI........:" GET aPRODUTOS[nROW][9] PICT "@E 999,999,999.99" 
                               @ ++nLin, nCol Say "% ICMs..............:" Get aProdutos[nRow][14] Pict "99.99"             Valid { |oGET| Calculos( oGet, GetList, 3 ) } 
                               @ ++nLin, nCol Say "Valor ICMs..........:" Get aProdutos[nRow][15] Pict "999999.99" 
                               @ ++nLin, nCol Say "Data Entrega........:" Get aProdutos[nRow][10] 
                               READ 
                               SCREENREST(cTELA2) 
                               SetCursor( 0 ) 
                               SetColor( _COR_BROWSE ) 
                          otherwise                 ;tone(125); tone(300) 
                       endcase 
                       oTB:refreshcurrent() 
                       oTB:stabilize() 
                   enddo 
                   setcursor(1) 
                   if cDESFOR<>spac(45) 
                      SET( _SET_DELIMITERS, .F. ) 
                      lCONFIRMA:=set(_SET_CONFIRM,.F.) 
                      vpbox(08,04,18,75,"Observacoes") 
                      @ 09,05 get cOBSER1 
                      @ 10,05 get cOBSER2 
                      @ 11,05 get cOBSER3 
                      @ 12,05 get cOBSER4 
                      cCOR0:=setcolor() 
                      setcolor("W/N") 
                      DispBox(13,05,13,74, _BOX_UM ) 
                      DispBox(15,05,15,74, _BOX_UM ) 
                      setcolor(cCOR0) 
                      @ 14,05 say "Notificacao" get cNOTA__ pict "@S58" 
                      @ 16,05 say "ICMs:  1 =>" get cOBICM1 
                      @ 17,05 say "       2 =>" get cOBICM2 
                      read 
                      set(_SET_CONFIRM,lCONFIRMA) 
                      nSUBTOT:=nTOTIPI:=0 
                      for nCT:=1 to len(aPRODUTOS) 
                        nSUBTOT:=nSUBTOT+aPRODUTOS[nCT][7] 
                        nTOTIPI:=nTOTIPI+aPRODUTOS[nCT][9] 
                      next 
                      nTOTALG:=nSUBTOT+nTOTIPI+nFRETE_ 
                      SET( _SET_DELIMITERS, .T. ) 
                   endif 
                   DBSELECTAR(_COD_OC) 
                   if confirma(24-2,65,"Confirma?",; 
                      "Digite [S] para Salvar ou [N] para abandonar...","S") 
                      dbselectar(_COD_OC) 
                      if BuscaNet( 05, {|| rlock(), !neterr() } ) 
                         repl ORDCMP with cORDCMP,; 
                              PAGINA with strzero(nPAGINA,4,0),; 
                              CODFOR with nCODFOR,; 
                              DESFOR with cDESFOR,; 
                              ENDERE with cENDERE,; 
                              CODCEP with cCODCEP,; 
                              CIDADE with cCIDADE,; 
                              ESTADO with cESTADO,; 
                              CONTAT with cCONTAT,; 
                              CODTRA with nCODTRA,; 
                              DESTRA with cDESTRA,; 
                              FONTRA with cFONTRA,; 
                              FAX___ with cFAX___,; 
                              FONE__ with cFONE__,; 
                              REPDES with cREPDES,; 
                              REPCON with cREPCON,; 
                              REPFON with cREPFON,; 
                              LOCALE with cLOCALE,; 
                              LOCALC with cLOCALC,; 
                              TAXAF_ with nTAXAF_,; 
                              COMPRA with cCOMPRA,; 
                              RESP__ with cRESP__,; 
                              REAJUS with cREAJUS,; 
                              PERICM with nPERICM,; 
                              CONDIC with cCONDIC,; 
                              OBSER1 with cOBSER1,; 
                              OBSER2 with cOBSER2,; 
                              OBSER3 with cOBSER3,; 
                              OBSER4 with cOBSER4,; 
                              NOTA__ with cNOTA__,; 
                              OBICM1 with cOBICM1,; 
                              OBICM2 with cOBICM2,; 
                              DATAEM with dDATAEM,; 
                              SUBTOT with nSUBTOT,; 
                              VLRFRE with nFRETE_,; 
                              VLRIPI with nTOTIPI,; 
                              TOTAL_ with nTOTALG,; 
                              TFRETE with StrZero(nTFRETE,1,0) 
                         dbunlockAll() 
                      else 
                         Tone(100,1) 
                         Aviso("ATENCAO! Nao foi possivel gravar o registro.",12) 
                         Pausa() 
                      endif 
                      dbselectar(_COD_OC_AUXILIA) 
                      Set Filter To OrdCmp == cOrdCmp 
 
                      DBGOTOP() 
                      WHILE !EOF() 
                         IF netrlock() 
                            Dele 
                         ELSE 
                            AVISO( ">>> ALTERACAO NAO FOI EFETUADA CORRETAMENTE <<<", 12 ) 
                            Mensagem( "Pressione [ENTER] para continuar..." ) 
                            Pausa() 
                         ENDIF 
                         DBUnlockAll() 
                         DBSkip() 
                      ENDDO 
                      Set Filter To 
                      DBUnLockAll() 
                      for nCT:=1 to len(aPRODUTOS) 
                          If BuscaNet(5,{|| dbappend(), !neterr()}) 
                             If aPRODUTOS[nCT][2]<>Spac(36) 
                                If !neterr() 
                                   Repl ORDCMP with cORDCMP,; 
                                        PAGINA with STRZERO(nPAGINA,04,00),; 
                                        ITEM__ with nCT,; 
                                        CODPRO With aProdutos[nCt][1],; 
                                        DESPRO With aProdutos[nCt][2],; 
                                        UNIDAD with aPRODUTOS[nCT][3],; 
                                        PRECOU with aPRODUTOS[nCT][4],; 
                                        CODICM with aPRODUTOS[nCT][5],; 
                                        QUANT_ with aPRODUTOS[nCT][6],; 
                                        TOTAL_ with aPRODUTOS[nCT][7],; 
                                        PERIPI with aPRODUTOS[nCT][8],; 
                                        VLRIPI with aPRODUTOS[nCT][9],; 
                                        RECEBI with aPRODUTOS[nCt][11],; 
                                        SDOREC with QUANT_ - RECEBI,; 
                                        ENTREG with aPRODUTOS[nCT][10],; 
                                        TABELB With aPRODUTOS[nCt][12],; 
                                        CLAFIS With aPRODUTOS[nCt][13],; 
                                        PERICM With aPRODUTOS[nCt][14],; 
                                        VLRICM With aPRODUTOS[nCt][15] 
                                Endif 
                             EndIf 
                          EndIf 
                      Next 
                      DBUnlockAll() 
                   endif 
                endif 
                ScreenRest(cTELA0) 
                DBSELECTAR(_COD_OC) 
                SETCURSOR(0) 
             ENDIF 
        case Tecla==K_F2;   DBMudaOrdem( 1, oTab ) 
        case Tecla==K_F3;   DBMudaOrdem( 2, oTab ) 
        case Tecla==K_F4;   DBMudaOrdem( 3, oTab ) 
        case Tecla==K_F5;   DBMudaOrdem( 4, oTab ) 
        case DBPesquisa( Tecla, oTab ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  //unzoom(cTELA) 
  screenrest(cTELAR) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  Return Nil 
 
/* 
** Funcao      - VERIFICAOC 
** Finalidade  - Executar verificacao de Ordens de Compra 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
Func VerificaOC() 
Loca cTELAR:=screensave(00,00,24,79),nCURSOR:= SetCursor(), cCOR:=SetColor(), nTECLA:=0, oBROW 
LOCA nROW:=1 
Loca nCODIGO:=00000, nCODFOR:=0, oTB, oTAB,; 
     cDESFOR, cENDERE, cCODCEP, cBAIRRO, cCIDADE, cESTADO, cLOCALE,; 
     cLOCALC, nTAXAF_, cFAX___, dDATAEM, cCOMPRA, cRESP__, cCONTAT,; 
     cORDCMP:="0", cREAJUS, nCODTRA, cDESTRA, cFONTRA, nPERICM, cCONDIC,; 
     cOBSER1, cOBSER2, cOBSER3, cOBSER4, nCT:=0, nPAGINA:=1,; 
     cNOTA__, cOBICM1, cOBICM2, nFRETE_, nTOTIPI, nSUBTOT:=0,; 
     nTFRETE, cFONE__, nTOTALG, GETLIST:={},; 
     aPRODUTOS:={}, cORD, cDES,; 
     cTELA30, nLIN, lFIM, nITEM,  nSEQUEN,; 
     TECLA, cTELA0, cTELA,; 
     cREPDES, cREPCON, cREPFON 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Usermodulo("ORDEM DE COMPRA - Transf. de Prod. p/estoque") 
  IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
     RETURN NIL 
  ENDIF 
  inicfgcampos(1) 
  SETCURSOR(0) 
  DBSelectAr( _COD_PAGAR ) 
  DbGoBottom() 
  nCODLAN:=CODIGO 
  DbGoTop() 
  DBSelectAr(_COD_OC) 
  DBGoBottom() 
  setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
  DBGoBottom() 
  setcursor(0) 
 
  VPBox( 16, 00, 24-2, 79, "" ,"15/01", .F., .F. ) 
  VPBox( 00, 00, 15, 79, " Ordens de Compra ", _COR_GET_BOX, .F., .F. ) 
 
  SetColor(COR[21]+","+COR[22]+",,,"+COR[17]) 
 
  mensagem("Pressione [TAB] para imprimir ou [ENTER] para ver detalhes.") 
  ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
  DBLeOrdem() 
  oTAB:=tbrowsedb(17,01,24-3,78) 
  oTAB:addcolumn(tbcolumnnew(,{|| OK____+; 
                                  ORDCMP+" => "+; 
                          strzero(CODFOR,4,0)+" - "+; 
                                  DESFOR+spac(19) })) 
  oTAB:AUTOLITE:=.F. 
  oTAB:dehilite() 
  WHILE .T. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and.! oTAB:stabilize() 
     enddo 
     SetColor( _COR_GET_EDICAO ) 
     nCODFOR:=CODFOR 
     @ 02,40 Say "Empresa............: " + STRZERO( FILIAL, 03, 0 )          Color "10/" + CorFundoAtual() 
     @ 02,02 say "No. Ordem de Compra: "+ORDCMP+"/"+PAGINA                   Color "15/" + CorFundoAtual() 
     @ 03,02 say "Data de Emissao....: "+dtoc(DATAEM)                        Color "10/" + CorFundoAtual() 
     @ 04,02 say "Codigo Fornecedor..: "+strzero(CODFOR,4,00)                Color "15/" + CorFundoAtual() 
     @ 05,02 say "Nome do Fornecedor.: "+DESFOR                              Color "10/" + CorFundoAtual() 
     @ 06,02 say "Endereco...........: "+ENDERE                              Color "15/" + CorFundoAtual() 
     @ 07,02 say "Codigo do CEP......: "+tran(CODCEP,"@r 99.999-999")        Color "10/" + CorFundoAtual() 
     @ 08,02 say "Cidade.............: "+CIDADE+"-"+ESTADO                   Color "15/" + CorFundoAtual() 
     @ 09,02 say "Fone/Fax...........: "+tran(FONE__,"@R (9999)-999.99.99")+" / "+; 
                                         tran(FAX___,"@R (9999)-999.99.99")  Color "10/" + CorFundoAtual() 
     @ 10,02 say repl("�",76)                                                Color "15/" + CorFundoAtual() 
     @ 11,02 say "Sub-Total..........: "+tran(SUBTOT,"@E ***,***,***.**")    Color "10/" + CorFundoAtual() 
     @ 12,02 say "Vlr. Frete.........: "+tran(VLRFRE,"@E ***,***,***.**")    Color "15/" + CorFundoAtual() 
     @ 13,02 say "Valor IPI..........: "+tran(VLRIPI,"@E ***,***,***.**")    Color "10/" + CorFundoAtual() 
     @ 14,02 say "Total Geral........: "+tran(TOTAL_,"@E ***,***,***.**")    Color "15/" + CorFundoAtual() 
     @ 13,40 say "RESP: "+SubStr(RESP__,1,30)                                Color "10/" + CorFundoAtual() 
     @ 14,40 say "COMP: "+COMPRA                                             Color "15/" + CorFundoAtual() 
     setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
     if ( TECLA:=inkey(0) )==K_ESC 
        exit 
     endif 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_ENTER .OR. TECLA==K_TAB 
             cTELA0:=ScreenSave(00,00,24,79) 
             lFIM:=.F. 
             nITEM:=1 
             nPAGINA:=1 
             cTELAR1:="" 
             nSEQUEN:=0 
             nFRETE_:=0 
             nTOTALG:=0 
             nTOTIPI:=0 
             nSUBTOT:=0 
             aPRODUTOS:={} 
             nSEQUEN:=0 
             nSUBTOT:=SUBTOT 
             nPERICM:=PERICM 
             cOBICM1:=OBICM1 
             cOBICM2:=OBICM2 
             CODORDEM:=ORDCMP 
             nCODFOR:=CODFOR 
             cDESFOR:=DESFOR 
             cENDERE:=ENDERE 
             cCODCEP:=CODCEP 
             cREPDES:=REPDES 
             cREPCON:=REPCON 
             cREPFON:=REPFON 
             cBAIRRO:="" 
             cCIDADE:=CIDADE 
             cESTADO:=ESTADO 
             cLOCALE:=LOCALE 
             cLOCALC:=LOCALC 
             nTAXAF_:=TAXAF_ 
             cFAX___:=FAX___ 
             dDATAEM:=DATAEM 
             cCOMPRA:=COMPRA 
             cRESP__:=RESP__ 
             cCONTAT:=CONTAT 
             cORDCMP:=ORDCMP 
             cREAJUS:=REAJUS 
             nCODTRA:=CODTRA 
             cDESTRA:=DESTRA 
             cFONTRA:=FONTRA 
             nPERICM:=PERICM 
             cCONDIC:=CONDIC 
             cOBSER1:=OBSER1 
             cOBSER2:=OBSER2 
             cOBSER3:=OBSER3 
             cOBSER4:=OBSER4 
             nCT:=0 
             nPAGINA:=1 
             cNOTA__:=NOTA__ 
             cOBICM1:=OBICM1 
             cOBICM2:=OBICM2 
             nFRETE_:=VLRFRE 
             nTOTIPI:=VLRIPI 
             nSUBTOT:=SUBTOT 
             nTFRETE:=val(TFRETE) 
             cFONE__:=FONE__ 
             nTOTALG:=TOTAL_ 
             nSEQUEN:=0 
             dbSelectAr(_COD_OC_AUXILIA) 
             Set Filter To ORDCMP=CODORDEM 
             DBGOTOP() 
             WHIL ! EOF() 
                 AADD(aPRODUTOS,{ Left( CODPRO, 7 ),; 
                                          DESPRO,; 
                                          UNIDAD,; 
                                          PRECOU,; 
                                          CODICM,; 
                                          QUANT_,; 
                                          TOTAL_,; 
                                          PERIPI,; 
                                          VLRIPI,; 
                                          ENTREG,; 
                                          RECEBI,; 
                                          SDOREC,; 
                                          URECEB } ) 
                 DBSKIP() 
             ENDDO 
             Set Filter To 
             if TECLA=K_TAB 
 
                Relatorio( "OC.REP" ) 
 
                // ImprimeOC(cORDCMP,dDATAEM,cLOCALC,cLOCALE,nTAXAF_,nTFRETE,; 
                //    cREAJUS,cDESFOR,cENDERE,cCIDADE,cESTADO,cFAX___,; 
                //    cFONE__,cCONTAT,cDESTRA,cFONTRA,nSUBTOT,cOBICM1,; 
                //    cOBICM2,nPERICM,cOBSER1,cOBSER2,cOBSER3,cOBSER4,; 
                //    nTOTALG,nFRETE_,cCOMPRA,cRESP__,cNOTA__,cCONDIC,aPRODUTOS,; 
                //    nTOTIPI,cREPDES,cREPCON,cREPFON) 
 
             ELSEIF Len(aPRODUTOS)>0 .AND. TECLA=K_ENTER 
                nLIN:=20 
                If Len(aPRODUTOS)<15 
                   nLIN:=5+Len(aPRODUTOS) 
                EndIf 
                nLIN:=nLIN 
                nROW:=1 
                vpbox(02,04,nLIN,78,"Verificacao",_COR_BROW_BOX ) 
                IF nLIN < 12 
                   VPBOX(12,09,17,70,"Detalhes", _COR_GET_BOX ) 
                   SetColor( _COR_GET_BOX ) 
                   @ 13,10 say "Produto............: " 
                   @ 14,10 Say "Recebido...........: " 
                   @ 15,10 Say "Quantidade Pendente: " 
                   @ 16,10 Say "Data (ultimo Receb): " 
                ENDIF 
                SetColor( _COR_BROWSE ) 
                setcursor(0) 
                @ 03,05 Say "Cod.    �Produto     �Un�Valor Unitar� Quantidade "+; 
                                                "� Vlr. Total �  Data  " 
                @ 04,05 Say "�������ͳ�����������ͳ�ͳ�����������ͳ������������"+; 
                                                "������������ͳ��������" 
                oTB:=tbrowsenew(05,05,nLIN-1,77) 
                oTB:addcolumn(tbcolumnnew(,{|| Tran( aPRODUTOS[nROW][1], "@R 999-9999" ) +; 
                    "�"+Substr(aPRODUTOS[nROW][2],1,12)+"�"+aPRODUTOS[nROW][3]+; 
                    "�"+Tran(aPRODUTOS[nROW][4],"@E 9999999.9999")+""+; 
                    "�"+Tran(aPRODUTOS[nROW][6],"@E 9999999.9999")+""+; 
                    "�"+Tran(aPRODUTOS[nROW][7],"@E 9999999.9999")+""+; 
                    "�"+Dtoc(aPRODUTOS[nROW][10])+" " })) 
                oTB:AUTOLITE:=.f. 
                oTB:GOTOPBLOCK :={|| nROW:=1} 
                oTB:GOBOTTOMBLOCK:={|| nROW:=len(aPRODUTOS)} 
                oTB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPRODUTOS,@nROW)} 
                oTB:dehilite() 
                whil .t. 
                    oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
                    whil nextkey()==0 .and. ! oTB:stabilize() 
                    end 
                    IF nLIN < 12 
                       SetColor( _COR_GET_BOX ) 
                       @ 13,31 say SubStr(aPRODUTOS[nROW][2],1,49) 
                       @ 14,31 Say Tran(aPRODUTOS[nROW][11],"@E ***,***,***.***") 
                       @ 15,31 Say Tran(aPRODUTOS[nROW][12],"@E ***,***,***.***") 
                       @ 16,31 Say DTOC( aPRODUTOS[nROW][13] ) 
                       SetColor( _COR_BROWSE ) 
                    ENDIF 
                    TECLA:=inkey(0) 
                    if TECLA==K_ESC   ;exit   ;endif 
                    do case 
                       case TECLA==K_UP         ;oTB:up() 
                       case TECLA==K_DOWN       ;oTB:down() 
                       case TECLA==K_LEFT       ;oTB:up() 
                       case TECLA==K_RIGHT      ;oTB:down() 
                       case TECLA==K_PGUP       ;oTB:pageup() 
                       case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
                       case TECLA==K_PGDN       ;oTB:pagedown() 
                       case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
                       case TECLA==K_ENTER 
                            cTELA30=SCREENSAVE(00,00,24,79) 
                            VPBOX(12,09,17,70,"Detalhes", _COR_GET_BOX ) 
                            SetColor( _COR_GET_BOX ) 
                            @ 13,10 say "Produto............: "+; 
                                    SubStr(aPRODUTOS[nROW][2],1,49) 
                            @ 14,10 Say "Recebido...........: "+; 
                                    Tran(aPRODUTOS[nROW][11],"@E ***,***,***.***") 
                            @ 15,10 Say "Quantidade Pendente: "+; 
                                    Tran(aPRODUTOS[nROW][12],"@E ***,***,***.***") 
                            @ 16,10 Say "Data (ultimo Receb): "+; 
                                    DTOC( aPRODUTOS[nROW][13] ) 
                            INKEY(5);SCREENREST(cTELA30) 
                            SetColor( _COR_BROWSE ) 
                       otherwise                ;tone(125); tone(300) 
                    endcase 
                    oTB:refreshcurrent() 
                    oTB:stabilize() 
                endDO 
                setcursor(1) 
             endif 
             ScreenRest(cTELA0) 
             DBSELECTAR(_COD_OC) 
        case Tecla==K_F2;   DBMudaOrdem( 1, oTab ) 
        case Tecla==K_F3;   DBMudaOrdem( 2, oTab ) 
        case Tecla==K_F4;   DBMudaOrdem( 3, oTab ) 
        case Tecla==K_F5;   DBMudaOrdem( 4, oTab ) 
        case DBPesquisa( Tecla, oTab ) 
        otherwise              ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  ENDDO 
  dbunlockall() 
  FechaArquivos() 
  screenrest(cTELAR) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  return nil 
 
stat func xprodbaixa(oTB,CODORDEM) 
  //* Define variaveis locais *// 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor(), GETLIST:={},; 
       nAREA:=select(), nORDEM:=indexord() 
 
  loca cCPROD_:=spac(12), dDATAMV:=date(),; 
       cCODRED:=spac(12), cCODIGO:=spac(12), cENTSAI:="+",; 
       nQUANT_:=0, cRAZAO_:="1", cDOC___:=spac(15),; 
       nVLRSDO:=0, cVLRSAI:=0, VENIN_:=nVENEX_:=nCODCLI:=CODFOR:=0,; 
       nRESPON:=0, cANULAR:=" ", cARQINDICE:="VPCOMP.TMP", nCT:=0,; 
       oTAB, nTECLA, nFLAG:=0 
  //* Seleciona arquivo auxiliar a ordem de compra *// 
  dbselectar(_COD_OC_AUXILIA) 
  //* Pesquisa se existe algum arquivo de indice criado por outro usuario *// 
  for nCT:=0 to 99 
      if !file("STATUS"+strzero(nCT,2,0)+".TMP") 
         cARQINDICE:="STATUS"+strzero(nCT,2,0)+".TMP" 
         nCT:=99 
      endif 
  next 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  index on ORDCMP to &cARQINDICE for ORDCMP=CODORDEM 
  scroll(02,40,14,77) 
  //* Elabora o TBROWSE para apresentar os produtos pendentes *// 
  oTAB:=tbrowsedb(02,02,14,38) 
  oTAB:addcolumn(tbcolumnnew(,{|| strzero(ITEM__,3,0)+"="+alltrim(CODPRO)+" - "+substr(DESPRO,1,13)+spac(20) })) 
  oTAB:AUTOLITE:=.F. 
  oTAB:dehilite() 
  whil .t. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and.! oTAB:stabilize() 
     enddo 
     //* Apresenta informacoes *// 
     setcolor("W+/B") 
     @ 02,40 say "Codigo................: "+alltrim(CODPRO) 
     cCODPRO:=CODPRO 
     nCODFOR:=OC->CODFOR 
     setcolor("BG/B") 
     @ 03,40 say "Nome..................: "+substr(DESPRO,1,12) 
     setcolor("W+/B") 
     @ 04,40 say "Preco Unitario........: "+tran(PRECOU,"@E *,***,***.***") 
     setcolor("BG/B") 
     @ 05,40 say "Preco total (Unit*Qtd): "+tran(TOTAL_,"@E *,***,***.***") 
     setcolor("W+/B") 
     @ 06,40 say "Qtd. Solicitada.......: "+str(QUANT_,13,3) 
     setcolor("BG/B") 
     @ 07,40 say "Qtd. Recebida.........: "+str(RECEBI,13,3) 
     setcolor("W+/B") 
     @ 08,40 say "Qtd. Pendente.........: "+str(SDOREC,13,3) 
     setcolor("BG/B") 
     @ 09,40 say "Qtd. Deste recebimento:             " 
     setcolor("W+/B") 
     @ 10,40 say "Data de Recebimento...:             " 
     setcolor("BG/B") 
     @ 11,40 say "Sdo. Atual em Estoque.: " 
     setcolor("W+/B") 
     @ 12,40 say "Data de Emissao de O.C: "+dtoc(OC->DATAEM) 
     setcolor("BG/B") 
     @ 13,40 say "Data limite p/ entrega: "+dtoc(ENTREG) 
     setcolor("W+/B") 
     @ 14,40 say "Fornecedor............: "+substr(OC->DESFOR,1,13) 
     if SDOREC=0 .AND. nFLAG<>1 
        nFLAG:=1 
        cTELA0:=screensave(15,00,18,79) 
        aviso("Emissao deste produto ja efetuada...",16) 
     endif 
     //* Espera por uma tecla e testa se foi ESC(27) *// 
     if ( TECLA:=inkey(0) )==K_ESC 
        exit 
     endif 
     //* Testa a tecla pressionada *// 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_ENTER 
             nORDEM0:=IndexOrd() 
             nAREA0:=select() 
             set(_SET_DELIMITERS,.F.) 
             nQUANT_:=0 
             @ 09,64 get nQUANT_ pict "@E 99999999.999" when; 
               mensagem("Digite a quantidade de itens a dar baixa.") 
             @ 10,64 get dDATAMV when; 
               mensagem("Digite a data para baixa no estoque.") 
             read 
             if netrlock(5) 
                repl RECEBI with RECEBI+nQUANT_,; 
                     SDOREC with SDOREC-nQUANT_ 
             endif 
             dbselectar(_COD_ESTOQUE) 
             mensagem("Dando baixa no arquivo de estoque, aguarde....",1) 
             If dDATAMV<>ctod("  /  /  ") 
                DbAppend() 
                If netrlock(5) 
                   Repl ENTSAI With "+",; 
                        QUANT_ With nQUANT_,; 
                        DOC___ With CODORDEM,; 
                        DATAMV With dDATAMV,; 
                        CPROD_ With cCODPRO,; 
                        CODRED With cCODPRO,; 
                        CODIGO With nCODFOR,; 
                        RESPON With nGCODUSER 
                EndIf 
             EndIf 
             Mensagem("Dando entrada de produtos no arquivo de M. Prima...") 
             dbselectar(_COD_MPRIMA) 
             dbsetorder(3) 
             If DbSeek(cCODPRO) 
                If netrlock(5) 
                   Repl SALDO_ with SALDO_+nQUANT_ 
                Endif 
             Else 
                Mensagem("Atencao! Produto nao foi localizado no cadastro....") 
                Pausa() 
             Endif 
             set(_SET_DELIMITERS,.T.) 
             dbselectar(nAREA0) 
             dbsetorder(nORDEM0) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
   if nFLAG=1 .AND. SDOREC<>0 
      nFLAG:=0 
      screenrest(cTELA0) 
   endif 
enddo 
dbselectar(_COD_OC_AUXILIA) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
set index to 
dbselectar(nAREA) 
dbsetorder(nORDEM) 
if file(cARQINDICE) 
   ferase(cARQINDICE) 
endif 
screenrest(cTELA) 
setcolor(cCOR) 
setcursor(nCURSOR) 
oTB:refreshall() 
whil ! oTB:stabilize() 
enddo 
return nil 
 
/* 
** Funcao      - EXCLUIOC 
** Finalidade  - Executar a exclusao de ordens de compra 
** Programador - Valmor Pereira Flores 
** Data        - 
** Atualizacao - 
*/ 
Func ExcluiOC() 
loca cTELAR:=screensave(00,00,24,79),nCURSOR:= SetCursor(),cCOR:=SetColor(), nTECLA:=0, oBROW 
LOCA cTELA:=cTELAR 
loca nCODIGO:=00000, nCODFOR:=0, oTB,; 
     cDESFOR, cENDERE, cCODCEP, cBAIRRO, cCIDADE, cESTADO, cLOCALE,; 
     cLOCALC, nTAXAF_, cFAX___, dDATAEM, cCOMPRA, cRESP__, cCONTAT,; 
     cORDCMP, cREAJUS, nCODTRA, cDESTRA, cFONTRA, nPERICM, cCONDIC,; 
     cOBSER1, cOBSER2, cOBSER3, cOBSER4, nCT:=0, nPAGINA:=1,; 
     cNOTA__, cOBICM1, cOBICM2, nFRETE_, nTOTIPI, nSUBTOT,; 
     nTFRETE, cFONE__, nTOTALG, GETLIST:={},; 
     oTAB, TECLA,; 
     cORD, cDES,; 
     cTELA2 
priv nROW:=1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo("ORDEM DE COMPRA - Alteracao de dados") 
  IF !AbreGrupo( "ORDEM_DE_COMPRA" ) 
     RETURN NIL 
  ENDIF 
  inicfgcampos(1) 
  SETCURSOR(0) 
  DBSelectAr( _COD_PAGAR ) 
  DbGoBottom() 
  nCODLAN:=CODIGO 
  DbGoTop() 
  DBSelectAr(_COD_OC) 
  DBGoBottom() 
  setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
  dbgotop() 
  setcursor(0) 
  vpbox( 16, 00, 24-2, 79,"","15/01",.F.,.F.) 
  vpbox( 00, 00, 15, 79, " Ordens de Compra ", _COR_GET_BOX, .F., .F. ) 
 
  setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
  mensagem("Pressione [ENTER] para efetuar a exclusao.") 
  ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
  DBLeOrdem() 
  oTAB:=tbrowsedb(17,01,24-3,78) 
  oTAB:addcolumn(tbcolumnnew(,{|| OK____+; 
                                  ORDCMP+" => "+; 
                          strzero(CODFOR,4,0)+" - "+; 
                                  DESFOR+spac(19) })) 
  oTAB:AUTOLITE:=.F. 
  oTAB:dehilite() 
  whil .t. 
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
     whil nextkey()==0 .and.! oTAB:stabilize() 
     enddo 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,40 Say "Empresa............: " + STRZERO( FILIAL, 03, 0 ) Color "10/" + CorFundoAtual() 
     @ 02,02 say "No. Ordem de Compra: "+ORDCMP+"/"+PAGINA          Color "15/" + CorFundoAtual() 
     @ 03,02 say "Data de Emissao....: "+dtoc(DATAEM)               Color "10/" + CorFundoAtual() 
     @ 04,02 say "Codigo Fornecedor..: "+strzero(CODFOR,4,00)       Color "15/" + CorFundoAtual() 
     nCODFOR:=CODFOR 
     @ 05,02 say "Nome do Fornecedor.: "+DESFOR                     Color "10/" + CorFundoAtual() 
     @ 06,02 say "Endereco...........: "+ENDERE                     Color "15/" + CorFundoAtual() 
     @ 07,02 say "Codigo do CEP......: "+tran(CODCEP,"@r 99.999-999")       Color "15/" + CorFundoAtual() 
     @ 08,02 say "Cidade.............: "+CIDADE+"-"+ESTADO                  Color "15/" + CorFundoAtual() 
     @ 09,02 say "Fone/Fax...........: "+tran(FONE__,"@R (9999)-999.99.99")+" / "+; 
                                         tran(FAX___,"@R (9999)-999.99.99") Color "15/" + CorFundoAtual() 
     @ 10,02 say repl("�",76)                                               Color "10/" + CorFundoAtual() 
     @ 11,02 say "Sub-Total..........: "+tran(SUBTOT,"@E ***,***,***.**")   Color "15/" + CorFundoAtual() 
     @ 12,02 say "Vlr. Frete.........: "+tran(VLRFRE,"@E ***,***,***.**")   Color "10/" + CorFundoAtual() 
     @ 13,02 say "Valor IPI..........: "+tran(VLRIPI,"@E ***,***,***.**")   Color "15/" + CorFundoAtual() 
     @ 14,02 say "Total Geral........: "+tran(TOTAL_,"@E ***,***,***.**")   Color "10/" + CorFundoAtual() 
     @ 13,40 say "RESP: "+SubStr(RESP__,1,30)                               Color "15/" + CorFundoAtual() 
     @ 14,40 say "COMP: "+COMPRA                                            Color "10/" + CorFundoAtual() 
     setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
     if ( TECLA:=inkey(0) )==K_ESC 
        exit 
     endif 
     do case 
        case TECLA==K_UP         ;oTAB:up() 
        case TECLA==K_LEFT       ;oTAB:up() 
        case TECLA==K_RIGHT      ;oTAB:down() 
        case TECLA==K_DOWN       ;oTAB:down() 
        case TECLA==K_PGUP       ;oTAB:pageup() 
        case TECLA==K_PGDN       ;oTAB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
        case TECLA==K_ENTER .OR. TECLA==K_TAB 
             cTELA0:=ScreenSave(22,00,24,79) 
             tone(100,2) 
             if Confirma(; 
                22,; 
                54,; 
                "Confirma a exclusao?",; 
                "Digite [S] p/ confirmar a exclusao desta ordem de compra.",; 
                "N"; 
                ) 
                nORDEM:=ORDCMP 
                If rlock() 
                   Dele 
                Endif 
                dbUnlockAll() 
                dbselectar(_COD_OC_AUXILIA) 
                Set Filter To OrdCmp == nOrdem 
                DBGoTop() 
                WHILE !EOF() 
                   If Rlock() 
                      Dele 
                   Endif 
                   DBSkip() 
                ENDDO 
                DBUNLOCKALL() 
                Set Filter To 
                DBSELECTAR(_COD_OC) 
                ScreenRest(cTELA0) 
                oTAB:RefreshAll() 
                Whil !oTAB:Stabilize() 
                EndDo 
             endif 
        case Tecla==K_F2;   DBMudaOrdem( 1, oTab ) 
        case Tecla==K_F3;   DBMudaOrdem( 2, oTab ) 
        case Tecla==K_F4;   DBMudaOrdem( 3, oTab ) 
        case Tecla==K_F5;   DBMudaOrdem( 4, oTab ) 
        case DBPesquisa( Tecla, oTab ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTAB:refreshcurrent() 
     oTAB:stabilize() 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  //unzoom(cTELA) 
  screenrest(cTELAR) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  return nil 
 
 
 
/* 
** Funcao      - INICFGCAMPOS 
** Finalidade  - Inicia configuracao de campos 
** Data        - 14/Marco/1995 
** Atualizacao - 05/Junho/1995 
** Programador - Valmor 
** Parametros  - MODULO => Numero representando modulo que deseja iniciar. 
**                      => 1 = Produtos 
*/ 
stat func inicfgcampos(MODULO,POSICAO) 
Static aCAMPOS:={} 
LOCA cTELA:=ScreenSave(00,00,24,79), cCOR:=SetColor(), nCURSOR:=SetCursor() 
IF POSICAO=NIL 
   //* CONFIGURACAO *// 
   if !file(_VPB_CONFIG) 
      aviso(" Arquivo de configuracao de produtos inexistente! ",24/2) 
      ajuda("[ENTER]Retorna") 
      mensagem("Pressione [ENTER] para retornar...",1) 
      pausa() 
      screenrest(cTELA) 
      return(.F.) 
   else 
      if !fdbusevpb(_COD_CONFIG,2) 
         Aviso("ATENCAO! Verifique o arquivo "+; 
           alltrim(_VPB_CONFIG)+".",24/2) 
         mensagem("Erro na abertura do arq. de configuracao, tente novamente.") 
         pausa() 
         setcolor(cCOR) 
         setcursor(nCURSOR) 
         screenrest(cTELA) 
         return(.F.) 
      endif 
   endif 
   if MODULO=1 
 
      /* Descricao dos campos 
         01=cMASCACOD 
         02=cVERIF_ 
         03=cMASCQUAN 
         04=cMASCPREC 
         05=cxORIGEM 
         06=cASSOCIAR 
         07=cMRESER 
         08=_PIGRUPO 
         09=_QTGRUPO 
         10=_PICODIGO 
         11=_QTCODIGO 
         12=cxMASCCOD 
         13=cxMASCQUAN 
         14=cxMASCPREC 
      ******/ 
      //* Mascara para codigo do produto *// 
      locate for VARIAV="cMASCACOD" 
      AADD(aCAMPOS,{ MASCAR,; 
                     VERIF_,; 
                     "", "", "", "", "", "", "", "", "", "", "",; 
                     "" } ) 
 
      //* Mascara para quantidade de itens *// 
      locate for VARIAV="cMASCQUAN" 
      aCAMPOS[1][3]:=MASCAR 
 
      //* Mascara para valores (Precos) *// 
      locate for VARIAV="cMASCPREC" 
      aCAMPOS[1][4]:=MASCAR 
 
      //* Utilizar Origem? *// 
      locate for VARIAV="cORIGEM" 
      aCAMPOS[1][5]:=QUEST_ 
 
      //* Associar (Quantidade por Peca & Estoque) ? *// 
      locate for VARIAV="cASSOCIAR" 
 
      //* Montando as variaveis *// 
      aCAMPOS[1][6]  := QUEST_ 
      aCAMPOS[1][7]  := strtran( aCAMPOS[1][1], ".", "" ) 
      aCAMPOS[1][7]  := strtran( aCAMPOS[1][7], "-", "" ) 
      aCAMPOS[1][7]  := alltrim( aCAMPOS[1][7] ) 
      aCAMPOS[1][8]  := at( "G", aCAMPOS[1][7] ) 
      aCAMPOS[1][9]  := StrVezes( "G", aCAMPOS[1][7] ) 
      aCAMPOS[1][10] := at( "N", aCAMPOS[1][7] ) 
      aCAMPOS[1][11] := StrVezes( "N", aCAMPOS[1][7] ) 
      aCAMPOS[1][12] := mascstr( aCAMPOS[1][1], 1 ) 
      aCAMPOS[1][13] := mascstr( aCAMPOS[1][2], 3 ) 
      aCAMPOS[1][14] := mascstr( aCAMPOS[1][4], 2 ) 
   endif 
   FechaArquivos() 
   Return(.T.) 
Else 
   Return( aCAMPOS[ MODULO ][ POSICAO ] ) 
Endif 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerGrupo 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerGrupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      Return( .T. ) 
   EndIf 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ), 4, 0 ) 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � VerCodigo 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function VerCodigo( cCodigo, GetList ) 
   LOCAL cGrupo_:= GetList[ 1 ]:VarGet() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL nArea:= Select() 
   LOCAL nOrdem:= IndexOrd(), nCt:= 0 
   If LastKey()==K_UP .OR. LastKey()==K_ESC .OR. ; 
      ( cGrupo_ + cCodigo ) == "0000000" 
      GetList[3]:VarPut( Space( Len( MPr->Descri ) ) ) 
      GetList[4]:VarPut( Space( Len( MPr->Unidad ) ) ) 
      For nCt:=1 To Len( GetList ) 
          GetList[ nCt ]:Display() 
      Next 
      Return( .T. ) 
   EndIf 
   DBSelectar( _COD_MPRIMA ) 
   DBSetOrder( 1 ) 
   If !DBSeek( cGrupo_ + cCodigo + Space( 5 ) ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo n�o existente neste grupo...", 24 / 2 ) 
      Mensagem( "Pressione [Enter] para ver lista..." ) 
      Pausa() 
      VisualProdutos( cGrupo_ + cCodigo ) 
      cCodigo:= SubStr( MPR->INDICE, 4, 4 ) 
      cGrupo_:= SubStr( MPR->INDICE, 1, 3 ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
   EndIf 
   If LastKey() == K_ESC 
      Return( .F. ) 
   EndIf 
   GetList[1]:VarPut( Left( MPr->Indice, 3 ) ) 
   GetList[2]:VarPut( SubStr( MPr->Indice, 4, 4 ) ) 
   GetList[3]:VarPut( MPr->Descri ) 
   #ifdef CONECSUL 
       GetList[3]:VarPut( MPr->CodFab + " - " + Left( MPr->Descri, 30 ) ) 
   #endif 
   PXF->( DBSetOrder( 1 ) ) 
   GetList[4]:VarPut( MPr->Unidad ) 
   GetList[5]:VarPut( MPr->ClaFis ) 
   GetList[6]:VarPut( MPr->IcmCod ) 
   GetList[7]:VarPut( MPr->IpiCod ) 
   GetList[9]:VarPut( if( PXF->( dbseek( Pad( cGrupo_ + cCodigo, 12 ) ) ), PXF->VALOR_, 0 ) ) 
   GetList[11]:VarPut( MPr->Ipi___ ) 
   GetList[13]:VarPut( MPr->Icm___ ) 
   For nCt:=1 To Len( GetList ) 
       GetList[ nCt ]:Display() 
   Next 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
 
 
