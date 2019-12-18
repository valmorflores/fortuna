// ## CL2HB.EXE - Converted
#Include "VPF.CH" 
#Include "Formatos.Ch" 
 
/* 
*      Funcao - IMPRIMENF 
*  Finalidade - Imprimir nota fiscal. 
*  Parametros - Nenhum 
*     Retorno - Nenhum 
*        Data - 27/Dezembro/1994 
* Atualizacao - 01/Marco/2000 
*/ 
func imprimeNF() 
 
  set(_SET_DEVICE,"PRINT") 
 
  nLIN:=prow() + 8 
 
  //* CANCELA O SALTO DO PICOTE *// 
  @ prow(),00 say chr(27)+"O" 
  @ prow(),00 say chr(27)+"@"+chr(18) 
  @ prow(),00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
  //* DADOS DO CLIENTE *// 
  @ nLIN+=1,08 say cDESCRI+" <"+strzero(nCLIENT,4,0)+">" 
  @ nLIN+=2,08 say alltrim(cENDERE)+if(cBAIRRO<>spac(25)," - "+cBAIRRO,"") 
  @ nLIN+=1,65 say strzero(nNUMERO,6,0) 
  @ nLIN+=1,08 say cCIDADE 
  @ nLIN,52 say cESTADO 
 
  @ nLIN,00 say chr(27)+"@"+chr(15)+chr(27)+"0" 
  @ nLIN+=1,125 say nNATOPE pict "9.99" 
  @ nLIN,00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
  @ nLIN+=1,08 say cCOBRAN 
  @ nLIN,52 say cCODCEP pict if(cCODCEP=space(8),"","@R 99.999-999") 
 
  @ nLIN,00 say chr(27)+"@"+chr(15)+chr(27)+"0" 
  @ nLIN+=1,123 say cVIATRA 
  @ nLIN,00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
  @ nLIN,00 say "  " 
  @ nLIN,08 say cCGCMF_ pict "@R 99.999.999/9999-99" 
  @ nLIN,48 say cINSCRI 
 
  //* CONDENSADO *// 
  @ nLIN,00 say chr(27)+"@"+chr(15)+chr(27)+"0" 
 
  //* IMPRESSAO DE ITENS *// 
  @ prow()+2,01 say "" 
  for nCT:=1 to len(aPRODUTOS) 
      @ prow()+1,01 say strzero(aPRODUTOS[nCT][2],_QTCODIG,0) 
      @ prow(),07 say aPRODUTOS[nCT][8] pict "@E 999999.99" 
      @ prow(),18 say aPRODUTOS[nCT][4] 
      @ prow(),21 say aPRODUTOS[nCT][3] 
      @ prow(),65 say aPRODUTOS[nCT][5] pict "9" 
      @ prow(),68 say aPRODUTOS[nCT][6] pict "9" 
      @ prow(),71 say aPRODUTOS[nCT][1] pict "99" 
      @ prow(),75 say aPRODUTOS[nCT][9] pict "@E 999,999,999,999.999"     && Vlr. Unitario 
      @ prow(),97 say aPRODUTOS[nCT][10] pict "@E 9,999,999,999,999.99"   && Vlr. total 
      @ prow(),119 say aPRODUTOS[nCT][11] pict "99"                       && Perc. IPI 
      @ prow(),122 say aPRODUTOS[nCT][12] pict "@E 999,999,999.99"        && Vlr. IPI 
  next 
 
  //* OBSERVACOES *// 
  @ nLIN+=15,01 say chr(27)+"!"+chr(72)+chr(27)+"0" 
  @ ++nLIN,10 say cOBSER1 
  @ ++nLIN,10 say cOBSER2 
  @ ++nLIN,10 say cOBSER3 
  @ ++nLIN,10 say cOBSER4 
  @ ++nLIN,10 say cOBSER5 
  @ ++nLIN,01 say chr(27)+"!"+chr(4)+chr(27)+"0" 
 
  if nNVEZES>1 .OR. nPRAZ_A>0 
     If nPRAZ_B=0 
        @ nLIN+=2,01 say "Pagto."+if(cCHEQ_A<>spac(15),; 
               " c/ ch. "+alltrim(cCHEQ_A)+" p/"," em ")+strzero(nPRAZ_A,2,0)+" dias." 
     Else 
        If nNVEZES=2 .AND. nPRAZ_A=0 .AND. nPRAZ_B<>0 
           @ nLIN+=2,01 Say "Pgto. em 2 parcelas (a vista e "+StrZero(nPRAZ_B,2,0)+" dias)." 
        Else 
           @ nLIN+=2,01 say "Pgto. em "+strzero(nNVEZES,1,0)+" parcelas ("+; 
             if(nPRAZ_A<>0,strzero(nPRAZ_A,2,0)+if(nPRAZ_B<>0,",","")," ")+; 
             if(nPRAZ_B<>0,strzero(nPRAZ_B,2,0)+if(nPRAZ_C<>0,",","")," ")+; 
             if(nPRAZ_C<>0,strzero(nPRAZ_C,2,0)+if(nPRAZ_D<>0,",","")," ")+; 
             if(nPRAZ_D<>0,strzero(nPRAZ_D,2,0),"")+" dias)." 
        Endif 
     EndIf 
  elseif nNVEZES=1 .AND. nPRAZ_A=0 
     if cCHEQ_A<>spac(15) 
        if alltrim(cCHEQ_A)="DINHEIRO" 
           @ nLIN+=2,01 say "Pagamento a vista em dinheiro." 
        else 
           @ nLIN+=2,01 say "Pgto. a vista c/ ch."+alltrim(cCHEQ_A)+; 
                            ", banco "+strzero(nBANC_A,3,0)+"." 
        endif 
     else 
        @ nLIN+=2,01 say "Pagamento a vista." 
     endif 
  else 
     nLIN+=2 
  endif 
  @ nLIN,52 say if(len(aPRODUTOS)>=1,aPRODUTOS[1][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=7,aPRODUTOS[7][13],"") 
 
  @ nLIN+=1,52 say if(len(aPRODUTOS)>=2,aPRODUTOS[2][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=8,aPRODUTOS[8][13],"") 
 
  @ nLIN,91 say nFRETE_ pict "@E 999,999,999.99"             && Frete 
  @ nLIN,115 say nVLRNOT pict "@E 99,999,999,999,999.99"     && Total mercadorias 
 
  //* CONDICOES DE PAGAMENTO *// 
  @ nLIN+=1,01 say tran(strzero(nDUPL_A,8,0),"@R 999999-99")+"/A =>  R$" 
  @ nLIN,12 say nVLR__A pict "@E 999,999,999,999.99" 
  @ nLIN,32 say dVENC_A 
  If dDTQT_A<>ctod("  /  /  ") 
     @ nLIN,40 say "-Quitada" 
  Endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=3,aPRODUTOS[3][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=9,aPRODUTOS[9][13],"") 
 
  //* CONDICOES DE PAGAMENTO *// 
  if nNVEZES>1 
     @ nLIN+=1,01 say tran(strzero(nDUPL_B,8,0),"@R 999999-99")+"/B =>  R$" 
     @ nLIN,12 say nVLR__B pict "@E 999,999,999,999.99" 
     @ nLIN,32 say dVENC_B 
     If dDTQT_B<>ctod("  /  /  ") 
        @ nLIN,40 say "-Quitada" 
     Endif 
  else 
     nLIN+=1 
  endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=4,aPRODUTOS[4][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=10,aPRODUTOS[10][13],"") 
 
  @ nLIN,91 say nSEGURO pict "@E 999,999,999.99"             && Seguro 
  @ nLIN,115 say nVLRIPI pict "@E 99,999,999,999,999.99"        && Total IPI 
 
  //* CONDICOES DE PAGAMENTO *// 
  if nNVEZES>2 
     @ nLIN+=1,01 say tran(strzero(nDUPL_C,8,0),"@R 999999-99")+"/C =>  R$" 
     @ nLIN,12 say nVLR__C pict "@E 999,999,999,999.99" 
     @ nLIN,32 say dVENC_C 
     If dDTQT_C<>ctod("  /  /  ") 
        @ nLIN,40 Say "-Quitada" 
     EndIf 
  else 
     nLIN+=1 
  endif 
 
  //* PAGAMENTO A VISTA *// 
  if nNVEZES=1 .AND. (nPRAZ_A=0 .OR. (cCHEQ_A<>spac(15))) 
     @ nLIN,01 say "Recebido em "+dtoc(dDTQT_A)+ " _________________________" 
  endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=5,aPRODUTOS[5][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=11,aPRODUTOS[11][13],"") 
 
  //* CONDICOES DE PAGAMENTO *// 
  if nNVEZES>3 
     @ nLIN+=1,01 say tran(strzero(nDUPL_D,8,0),"@R 999999-99")+"/D =>  R$" 
     @ nLIN,12 say nVLR__D pict "@E 999,999,999,999.99" 
     @ nLIN,32 say dVENC_D 
     If dDTQT_D<>ctod("  /  /  ") 
        @ nLIN,40 say "-Quitada" 
     Endif 
  else 
    nLIN+=1 
  endif 
 
  //* NOME DA EMPRESA ABAIXO DO TRACO (Recebido em dd/mm/aa ____) *// 
  if nNVEZES=1 .AND. (nPRAZ_A=0 .OR. (cCHEQ_A<>spac(15))) 
     @ nLIN,01 say "                              Conecsul        " 
  endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=6,aPRODUTOS[6][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=12,aPRODUTOS[12][13],"") 
 
 
  @ nLIN,91 say nFRETE_+nSEGURO pict "@E 999,999,999.99"             && Total 
  @ nLIN,115 say nVLRTOT pict "@E 99,999,999,999,999.99"        && Total Nota fiscal 
 
  @ nLIN+=2,33 say aORDEMC[1]+" | "+aORDEMC[2]  && Ordem de compra 
  @ nLIN,58 say "V.I."+strzero(nVENIN_,4,0)+"-Pedido:"+strzero(nPEDIDO,6,0) 
  @ nLIN,93 say cTDESCR 
  @ nLIN,117 say cTFONE_ pict "@R 999-999.99.99" 
 
  @ nLIN+=1,33 say aORDEMC[3]+" | "+aORDEMC[4]  && OC 
  @ nLIN+=1,33 say aORDEMC[5]+" | "+aORDEMC[6]  && OC 
  @ nLIN,58 say "V.E."+strzero(nVENEX_,4,0) 
  @ nLIN+=2,01 say dDATAEM 
  @ nLIN,52 say cCGCMF_ pict "@R 99.999.999/9999-99" 
  @ nLIN,74 say cINSCRI 
  @ nLIN,90 say cESTADO 
  @ nLIN,99 say cMARCA_ 
  @ nLIN,108 say "    " 
  @ nLIN,125 say cQUANT_ 
  @ nLIN+=2,01 say " U " 
  @ nLIN,06 say strzero(nNUMERO,6,0) 
  @ nLIN,11 say nVLRIPI pict "@E 999,999,999,999.99" 
  @ nLIN,30 say nBASICM pict "@E 999,999,999,999.99" 
  @ nLIN,50 say nICMPER pict "999.99" 
  @ nLIN,58 say if(cCONREV="C","S/T","") 
  @ nLIN,56 say nVLRICM pict "@E 999,999,999,999.99" 
  @ nLIN,77 say if(dDATAS_<>ctod("  /  /  "),dDATAS_,"") 
  if cHORA__<>spac(6) 
     @ nLIN,85 say "-"+tran(substr(cHORA__,1,4),"@R 99:99") 
  endif 
  @ nLIN,99 say cESPEC_ 
  @ nLIN,117 say nPESOLI 
  @ nLIN,128 say nPESOBR 
 
  @ nLIN+=5,05 say chr(27)+"!"+chr(80)+chr(27)+"0" 
  @ nLIN,05 say strzero(nNUMERO,6,0) 
 
  @ prow(),00 say chr(27)+"O" 
  @ prow(),00 say chr(27)+"!"+chr(80) 
 
  //* TESTE *// 
  @ prow(),00 say chr(27)+"3"+chr(3)+chr(27)+"D"+chr(10)+"0"+; 
                  chr(27)+"^"+chr(1)+chr(27)+"D"+chr(21) 
 
  @ prow(),00 say chr(27)+"O" 
  @ prow(),00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
  @ prow()+1,00 say "" 
  @ prow()+1,00 say "" 
  @ prow()+1,00 say "" 
  @ prow()+1,00 say "" 
  @ prow()+1,00 say "" 
  @ prow()+1,00 say "" 
  @ prow()+1,00 say "" 
  //* END TESTE *// 
 
  @ nLIN+=10,00 say "" 
set(_SET_DEVICE,"SCREEN") 
 
 
#Define NS     CHR(27)+CHR(69) 
#Define NN     CHR(27)+CHR(70) 
#Define ES     CHR(27)+CHR(14) 
#Define EN     CHR(27)+CHR(20) 
#Define CS     CHR(27)+CHR(15) 
#Define CN     CHR(27)+CHR(18) 
#Define NORMAL CHR(27)+CHR(18) 
 
/* 
** Funcao      - IMPRIMEOC 
** Finalidade  - Imprimir Ordem de Compra 
** Parametros  - Nenhum 
** Retorno     - Nenhum 
** Autor       - Valmor Pereira Flores 
**             - CopyRight(C)1994/1995 - VPComp Informatica ltda. 
** Data        - 
** Atualizacao - 
*/ 
Func imprimeOC(cORDCMP,dDATAEM,cLOCALC,cLOCALE,nTAXAF_,nTFRETE,; 
               cREAJUS,cDESFOR,cENDERE,cCIDADE,cESTADO,cFAX___,; 
               cFONE__,cCONTAT,cDESTRA,cFONTRA,nSUBTOT,cOBICM1,; 
               cOBICM2,nPERICM,cOBSER1,cOBSER2,cOBSER3,cOBSER4,; 
               nTOTALG,nFRETE_,cCOMPRA,cRESP__,cNOTA__,cCONDIC,; 
               aPRODUTOS,nTOTIPI,cREPDES,cREPCON,cREPFON) 
 
Local nOrdem:= IndexOrd(), nArea:= Select() 
 
If !Confirma( 0, 0, "Confirma a Impresso desta Ordem de Compra?" ) 
   Return Nil 
EndIf 
 
//Sele CFG 
DBSelectAr( 99 ) 
IF Used() 
ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Use _VPD_CONFIG Shared 
ENDIF 
 
//set printer to teste.txt 
 
SelecaoImpressora( .F. ) 
 
set device to print 
 
@ Prow(),00 Say Condensado( .T. ) 
@ Prow(),00 say   "ฺ"+repl("ฤ",47)+"ฟ ฺ"+repl("ฤ",85)+"ฟ" 
@ Prow()+1,00 say "ณ " 
for nCT:=1 to 3 
    @ prow(),2 say unzipchr(DESCRI) 
next 
@ Prow(),pcol() Say " ณ ณ" 
@ Prow(),pcol() Say Expandido(.T.)+" ORDEM DE COMPRA "+Expandido(.F.) 
@ Prow(),pcol() Say Condensado(.T.) 
@ Prow(),pcol() + 10 Say " ณ N: "+cORDCMP 
@ Prow(),pcol() Say "      ณ " 
@ Prow(),pcol() Say dtoc(dDATAEM) 
@ Prow(),pcol() + 14 Say "ณ" 
@ Prow()+1,00 Say "ณ "+unzipchr(LINE01)+" ณ ภ"+repl("ฤ",85)+"*" 
@ Prow()+1,00 Say "ณ "+unzipchr(LINE02)+" ณ ฺฤInformacoesฤ" + Repl("ฤ",72)          +"ฟ" 
@ Prow()+1,00 Say "ณ "+unzipchr(LINE03)+" ณ ณ Local de cobranca   "+cLOCALC+spac(14)+"ณ" 
@ Prow()+1,00 Say "ณ "+unzipchr(LINE04)+" ณ ณ Local de Entrega    "+cLOCALE+spac(14)+"ณ" 
@ Prow()+1,00 Say "ภ"+repl("ฤ",47)+      "ู ณ Taxa financeira     "+tran(nTAXAF_,"@E 999,999,999,999.99")+spac(46)+"ณ" 
@ Prow()+1,00 Say "ฺฤFORNECEDORฤ"+repl("ฤ",35)+"ฟ ณ Tipo de frete       "+if(nTFRETE=1,"<CIF> FOB","CIF <FOB>")+spac(55)+"ณ" 
@ Prow()+1,00 Say "ณ "+cDESFOR+" ณ ณ Reajuste            "+cREAJUS+spac(31)+"ณ" 
@ Prow()+1,00 Say "ณ "+cENDERE+spac(10)+" ณ ณ"+repl("ฤ",85)+"ณ" 
@ Prow()+1,00 Say "ณ "+cCIDADE+" - "+cESTADO+spac(10)+" ณ ณ Rep: "+cREPDES+ "Cont: "+SUBSTR( cREPCON, 1, 25 )+ "Fone: "+cREPFON+" ณ" 
@ Prow()+1,00 Say "ณ FAX: "+tran(cFAX___,"@R (9999)-999.99.99")+"  FONE:"+tran(cFONE__,"@R (9999)-999.99.99")+spac(01)+" ณ ณ Transportadora      " + Left( cDesTra, 20 ) + Space( 44 ) + "ณ" 
@ Prow()+1,00 Say "ณ Contato:" + cContat + Spac( 7 ) + " ณ ณ Fone                " + Tran( cFonTra, "@R (999)-999.99.99" ) + Spac( 49 ) + "ณ" 
@ Prow()+1,00 Say "ภ" + Repl( "ฤ", 47 ) + "ู ภ" + Repl( "ฤ", 85 ) + "ู" 
@ Prow()+1,00 Say Negrito(.T.) + "Solicitamos o fornecimento do material abaixo relacionado:" + Negrito( .F. ) 
@ Prow(),00   Say Condensado(.T.) 
@ Prow()+1,00 say "ฺฤRgอ*อCodigoอ*อDescricaoออออออออออออออออออออออออออออ"+; 
                  "*อUnอ*อQuantidadeอ*อValorอUnitarioอ*อValorอTotalอ"+; 
                  "*ICM*อ%IPIอ*อValorอIPIอ*อEntregaฤฤฟ" 
nCT:=0 
for nCT:=1 to 25 
    if nCT<=len(aPRODUTOS) 
       If SubStr(aPRODUTOS[nCT][1],1,7)<>"0000000" .AND. aPRODUTOS[nCT][2]<>spac(36) 
          @ prow()+1,00 say "ณ "+strzero(nCT,2,0)+" ณ "+SubStr( aPRODUTOS[nCT][1], 4, 4 )+spac(2)+" ณ "+LEFT( aPRODUTOS[nCT][2], 36 ) +; 
                           " ณ "+aPRODUTOS[nCT][3]+" ณ "+tran(aPRODUTOS[nCT][6],"@E 999999.999")+; 
                           " ณ "+tran(aPRODUTOS[nCT][4],"@E 9999999999.999")+; 
                           " ณ "+tran(aPRODUTOS[nCT][7],"@E 9999999.999")+; 
                           " ณ "+strzero(aPRODUTOS[nCT][5],1,0)+" ณ "+strzero(aPRODUTOS[nCT][8],5,2)+; 
                            "ณ "+tran(aPRODUTOS[nCT][9],"@E 999999.99")+" ณ "+; 
                     if(dDATAEM=aPRODUTOS[nCT][10],"IMEDIATA",dtoc(aPRODUTOS[nCT][10]))+" ณ" 
       else 
          @ prow()+1,00 say "ณ "+strzero(nCT,2,0)+" ณ "+spac(6)+" ณ "+spac(36)+" ณ "+spac(2)+" ณ "+spac(10)+; 
            " ณ "+spac(14)+" ณ "+spac(11)+" ณ "+spac(1)+" ณ "+spac(4)+; 
            " ณ "+spac(9)+" ณ "+spac(8)+ " ณ" 
       endif 
    else 
       @ prow()+1,00 say "ณ "+strzero(nCT,2,0)+" ณ "+spac(6)+" ณ "+spac(36)+" ณ "+spac(2)+" ณ "+spac(10)+; 
         " ณ "+spac(14)+" ณ "+spac(11)+" ณ "+spac(1)+" ณ "+spac(4)+; 
         " ณ "+spac(9)+" ณ "+spac(8)+ " ณ" 
    endif 
next 
@ prow()+1,00 say "รฤออออออออฤยฤออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฤู" 
@ prow()+1,00 say "ณ   ICMs   ณ"+spac(57)+"  ณ ณ Sub-Total    ณ"+tran(nSUBTOT,"@E 999999999.99")+" ณ ฺฤCondicoesฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ" 
@ prow(),00 say   "             1 => "+strtran(cOBICM1,"#VICM",str(nPERICM,5,2)) 
@ prow()+1,00 say "ณ          ณ"+spac(57)+"  ณ ณ DESCONTO     ณ"+tran(0,"@E 999999999.99")+" ณ ณ                               ณ" 
@ prow(),00 say   "             2 => "+strtran(cOBICM2,"#VICM",str(nPERICM,5,2)) 
@ prow()+1,00 Say "ภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ณ IPI          ณ"+tran(nTOTIPI,"@E 999999999.99")+" ณ ณ                               ณ" 
@ prow()+1,00 Say "ฺฤฤฤOBSฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ณ Frete        ณ"+tran(nFRETE_,"@E 999999999.99")+" ณ ณ "+spac(7)+cCONDIC+spac(7)+" ณ" 
@ prow()+1,00 Say "ณ"+cOBSER1+"ณ ณ--------------ณ-------------ณ ณ                               ณ" 
@ prow()+1,00 Say "ณ"+cOBSER2+"ณ ณ Total        ณ"+tran(nTOTALG,"@E 999999999.99")+" ณ ณ                               ณ" 
@ prow()+1,00 Say "ณ"+cOBSER3+"ณ ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤู ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด" 
@ prow()+1,00 Say "ณ"+cOBSER4+"ณ"+spac(64)+"ณ" 
@ prow(),  00 Say " "+spac(70)+"  "+"Porto Alegre, "+alltrim(str(day(dDATAEM),2,0))+" de "+mes(month(dDATAEM))+" de "+strzero(year(dDATAEM),4,0)+" " 
@ prow()+1,00 Say "ร"+repl("ฤ",70)+"ม"+repl("ฤ",64)+"ด" 
@ prow()+1,00 Say "ณ    COMPRADOR:                           RESP.P/EMISSAO:              " + Spac( 64 ) + " ณ" 
@ prow()+1,00 Say "ณ"+spac(135)+"ณ" 
@ prow()+1,00 Say "ณ    ____________________________          ____________________________ " + Space( 64 ) + "ณ" 
@ prow()+1,00 Say "ณ    "+cCOMPRA+"          " + Left( cResp__, 45 ) + Space( 48 ) + "ณ" 
@ prow()+1,00 Say "ณ"+spac(135)+"ณ" 
@ prow()+1,00 Say "ภ"+repl("ฤ",135)+"ู" 
@ prow()+1,00 Say cNOTA__ 
@ prow()+1,00 Say Condensado( .F. ) 
 
set(_SET_DEVICE,"SCREEN") 
 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
 
