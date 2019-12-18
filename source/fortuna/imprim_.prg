// ## CL2HB.EXE - Converted
 
/* 
*      Funcao - IMPRIMENF 
*  Finalidade - Imprimir nota fiscal. 
*  Parametros - Nenhum 
*     Retorno - Nenhum 
*        Data - 27/Dezembro/1994 
* Atualizacao - 
*/ 
func imprimenf() 
 
  set(_SET_DEVICE,"PRINT") 
 
  nLIN:=prow()+3 
 
  //* CANCELA O SALTO DO PICOTE *// 
  @ prow(),00 say chr(27)+"O" 
  @ prow(),00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
  //* DADOS DO CLIENTE *// 
  @ nLIN+=1,08 say cDESCRI+" <"+strzero(nCLIENT,4,0)+">" 
  @ nLIN+=2,08 say alltrim(cENDERE)+if(cBAIRRO<>spac(25)," - "+cBAIRRO,"") 
  @ nLIN+=2,08 say cCIDADE 
  @ nLIN,52 say cESTADO 
  @ nLIN,65 say strzero(nNUMERO,6,0) 
 
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
     @ prow(),08 say aPRODUTOS[nCT][8] pict "99999999" 
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
 
  //* CONDICOES DE PAGAMENTO *// 
  @ nLIN+=2,01 say nDUPL_A pict "@R 999999-99"+"/A" 
  @ nLIN,12 say nVLR__A pict "@E 999,999,999,999.99" 
  @ nLIN,32 say dVENC_A 
 
  @ nLIN,52 say if(aPRODUTOS[1][13]<>NIL,aPRODUTOS[1][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=7,aPRODUTOS[7][13],"") 
 
  //* CONDICOES DE PAGAMENTO *// 
  if nNVEZES>1 
     @ nLIN+=1,01 say nDUPL_B pict "@R 999999-99"+"/B" 
     @ nLIN,12 say nVLR__B pict "@E 999,999,999,999.99" 
     @ nLIN,32 say dVENC_B 
  else 
     nLIN+=1 
  endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=2,aPRODUTOS[2][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=8,aPRODUTOS[8][13],"") 
  @ nLIN,91 say nFRETE_ pict "@E 999,999,999.99"             && Frete 
  @ nLIN,115 say nVLRNOT pict "@E 99,999,999,999,999.99"        && Total mercadorias 
 
  //* CONDICOES DE PAGAMENTO *// 
  if nNVEZES>2 
     @ nLIN+=1,01 say nDUPL_C pict "@R 999999-99"+"/C" 
     @ nLIN,12 say nVLR__C pict "@E 999,999,999,999.99" 
     @ nLIN,32 say dVENC_C 
  else 
     nLIN+=1 
  endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=3,aPRODUTOS[3][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=9,aPRODUTOS[9][13],"") 
 
  //* CONDICOES DE PAGAMENTO *// 
  if nNVEZES>3 
     @ nLIN+=1,01 say nDUPL_D pict "@R 999999-99"+"/D" 
     @ nLIN,12 say nVLR__D pict "@E 999,999,999,999.99" 
     @ nLIN,32 say dVENC_D 
  else 
    nLIN+=1 
  endif 
 
  @ nLIN,52 say if(len(aPRODUTOS)>=4,aPRODUTOS[4][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=10,aPRODUTOS[10][13],"") 
 
  @ nLIN,91 say nSEGURO pict "@E 999,999,999.99"             && Seguro 
  @ nLIN,115 say nVLRIPI pict "@E 99,999,999,999,999.99"        && Total IPI 
 
  @ nLIN+=1,52 say if(len(aPRODUTOS)>=5,aPRODUTOS[5][13],"") 
  @ nLIN,72 say if(len(aPRODUTOS)>=11,aPRODUTOS[11][13],"") 
 
  @ nLIN+=1,52 say if(len(aPRODUTOS)>=6,aPRODUTOS[6][13],"") 
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
  @ nLIN,125 say strzero(nQUANT_,5,0) 
  @ nLIN+=2,01 say "000" 
  @ nLIN,06 say strzero(nNUMERO,6,0) 
  @ nLIN,11 say nVLRIPI pict "@E 999,999,999,999.99" 
  @ nLIN,30 say nBASICM pict "@E 999,999,999,999.99" 
  @ nLIN,50 say nICMPER pict "999.99" 
  @ nLIN,55 say nVLRICM pict "@E 999,999,999,999.99" 
  @ nLIN,75 say if(dDATAS_<>ctod("  /  /  "),dDATAS_,"") 
  if cHORA__<>spac(6) 
     @ nLIN,85 say cHORA__ pict "@R 99:99" 
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
 
