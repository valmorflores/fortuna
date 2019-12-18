// ## CL2HB.EXE - Converted
function imprime()


set(_SET_DEVICE,"PRINT") 
nLIN:=0 
@ nLIN,00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
@ nLIN+=1,08 say "0000 - VALMOR PEREIRA FLORES" 
@ nLIN+=2,08 say "AV. Ipiranga, 8797 cj. 201" 
@ nLIN+=2,08 say "PORTO ALEGRE" 
@ nLIN,52 say "RS" 
 
@ nLIN,00 say chr(27)+"@"+chr(15)+chr(27)+"0" 
@ nLIN+=1,125 say "5.12" 
@ nLIN,00 say chr(27)+"!"+chr(80)+chr(27)+"0" 
 
@ nLIN+=1,08 say "PORTO ALEGRE" 
@ nLIN,52 say "91.500-001" 
@ nLIN+=2,08 say "91.300.232/0001-12" 
@ nLIN,48 say "096/00000000" 
 
@ nLIN,00 say chr(27)+"@"+chr(15)+chr(27)+"0" 
@ nLIN,115 say "Rodoviario" 
 
@ prow()+2,01 say "" 
for nCT:=1 to 12 
   @ prow()+1,01 say "0000" 
   @ prow(),06 say "    12,023" 
   @ prow(),17 say "PC" 
   @ prow(),21 say "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 
   @ prow(),64 say "01" 
   @ prow(),67 say "02" 
   @ prow(),70 say "01" 
   @ prow(),74 say "9.999.999.999.999,99"       && Vlr. Unitario 
   @ prow(),97 say "9.999.999.999.999,99"       && Vlr. total 
   @ prow(),119 say "10"                        && Perc. IPI 
   @ prow(),122 say "999,999.999,99"            && Vlr. IPI 
next 
 
@ prow(),01 say chr(27)+"!"+chr(72)+chr(27)+"0" 
@ prow()+2,10 say "********************** OBSERVACAO ***********************" 
@ prow()+1,10 say "Neste espaco o usuario podera colocar qualquer observacao" 
@ prow()+1,10 say "que se refira a esta nota fiscal.                        " 
@ prow()+1,10 say "                                   Valmor Pereira Flores " 
@ prow()+1,10 say "*********************************************************" 
@ prow(),01 say chr(27)+"!"+chr(4)+chr(27)+"0" 
 
@ nLIN+=23,01 say " 1 x de 122.132.323,98"  && Cond. pagamentos 
@ nLIN,52 say "0000002034"                 && Clas. fiscal 
@ nLIN,72 say "0000002034"                 && 
 
@ nLIN+=1,01 say " 2 x de 122.132.323,98"  && Cond. pagamentos 
@ nLIN,52 say "0023239330" 
@ nLIN,72 say "0023402034"                 && 
@ nLIN,92 say "999.999.999,99"             && Frete 
@ nLIN,115 say "99.999.999.999.999,99"        && Total mercadorias 
 
@ nLIN+=1,01 say " 3 x de 122.132.323,98"  && Cond. pagamentos 
@ nLIN,52 say "0023239330" 
@ nLIN,72 say "0023402034"                 && 
 
@ nLIN+=1,01 say " 4 x de 154.345.354.98"  && Cond. pagamentos 
@ nLIN,52 say "0023239330" 
@ nLIN,72 say "0023402034"                 && 
@ nLIN,92 say "999.999.999,99"             && Seguro 
@ nLIN,115 say "99.999.999.999.999,99"        && Total IPI 
 
@ nLIN+=1,01 say " 5 x de 122.132.323,98"  && Cond. pagamentos 
@ nLIN,52 say "0023239330" 
@ nLIN,72 say "0023402034"                 && 
 
@ nLIN+=1,01 say " 6 x de 13123452312398"  && Cond. pagamentos 
@ nLIN,52 say "0024243330" 
@ nLIN,72 say "0900988004"                 && 
@ nLIN,92 say "999.999.999,99"             && Total 
@ nLIN,115 say "99.999.999.999.999,99"        && Total Nota fiscal 
 
@ nLIN+=2,32 say "0000000000 | 0000000000"  && Origens 
@ nLIN,58 say "00000-Pedido:00000" 
@ nLIN,92 say "XXXXXXXXXXXXXXXXXXXX" 
@ nLIN,116 say "999-999.99.99" 
 
@ nLIN+=1,32 say "0000000000 | 0000000000"  && Origens 
@ nLIN+=1,32 say "0000000000 | 0000000000"  && Origens 
@ nLIN+=2,01 say "DD/MM/AA" 
@ nLIN,52 say "91.300.999/00001-99" 
@ nLIN,74 say "096/00000000" 
@ nLIN,90 say "RS" 
@ nLIN,98 say "XX MARCA XX" 
@ nLIN,108 say "** NUMERO **" 
@ nLIN,120 say "** QUANTIA **" 
@ nLIN+=2,01 say "000" 
@ nLIN,06 say "00000000" 
@ nLIN,16 say "999.999.999.999,99" 
@ nLIN,36 say "999.999.999.999,99" 
@ nLIN,52 say "99" 
@ nLIN,55 say "999.999.999.999,99" 
@ nLIN,75 say "DD/MM/AA - 13:00HS." 
@ nLIN,85 say "ESPECIE" 
@ nLIN,100 say "peso 000" 
@ nLIN,110 say "12301230" 
 
@ nLIN+=5,05 say chr(27)+"!"+chr(80)+chr(27)+"0" 
@ nLIN,05 say "00000010" 
