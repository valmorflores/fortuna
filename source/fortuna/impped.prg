// ## CL2HB.EXE - Converted

#include "VPF.CH"

#ifdef HARBOUR
function impped()
#endif


  cArquivo:= "C:\FORTUNA\PEDIDOS.ZIP                              " 
  nRota:= 0 
  CLS 
  @ 10,10 Say "Arquivo que contem os pedidos" 
  @ 11,10 Get cArquivo 
  @ 13,10 Say "Rota" 
  READ 
 
  cArquivo:= ALLTRIM( cArquivo ) 
  IF File( cArquivo ) 
 
     !PKUNZIP &cArquivo C:\FORTUNA\. -O  
     DBSelectAr( 1 ) 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       use c:/fortuna/pedidos_.dbf alias pedimp exclusive 
     #else 
       USE C:\FORTUNA\PEDIDOS_.DBF Alias PEDIMP Exclusive 
     #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON CODIGO TO IndPedI 
     DBSelectAr( 2 ) 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       use c:/fortuna/pedprod_.dbf alias pxpimp exclusive 
     #else 
       USE C:\FORTUNA\PEDPROD_.DBF Alias PXPIMP Exclusive 
     #endif
     DBSelectAr( 3 ) 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       use c:/fortuna/dados/pedidos_.dbf alias ped exclusive 
     #else 
       USE C:\FORTUNA\DADOS\PEDIDOS_.DBF Alias PED Exclusive 
     #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     INDEX ON CODIGO TO IndPed 
     DBSelectAr( 4 ) 

     // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
     #ifdef LINUX
       use c:/fortuna/dados/pedprod_.dbf alias pxp exclusive 
     #else 
       USE C:\FORTUNA\DADOS\PEDPROD_.DBF Alias PXP Exclusive 
     #endif
 
     Set Date British 
     Set Epoch To 1980 
     Set Printer To InfoPed.Txt 
     Set Device  To Print 
     @ PROW(),PCOL() Say "Resumo de Pedidos Recusados na Importacao....." + Chr( 13 ) + Chr( 10 ) 
     @ PROW(),PCOL() Say dtoc( DATE() ) + " " + TIME() + Chr( 13 ) + Chr( 10 ) 
 
     aDeletar:= {} 
     dbSelectAr( 1 ) 
     PEDIMP->( dbGoTop() ) 
     WHILE !( PEDIMP->( EOF() ) ) 
        IF PED->( DBSeek( PEDIMP->CODIGO ) ) 
           Replace PEDIMP->TRANSP With 999 
           @ PROW(),PCOL() Say PEDIMP->CODIGO + "  " + PEDIMP->DESCRI + Chr( 13 ) + Chr( 10 ) 
        ELSE 
           //Replace PEDIMP->TRANSP With nRota 
        ENDIF 
        PEDIMP->( DBSkip() ) 
     ENDDO 
 
     DBSelectAr( 3 ) 
     Append From C:\FORTUNA\PEDIDOS_.DBF FOR PEDIMP->TRANSP <> 999 
 
     DBSelectAr( 4 ) 
     Set Relation To CODIGO Into PEDIMP 
     Append From C:\FORTUNA\PEDPROD_.DBF For PEDIMP->TRANSP <> 999 
 
     DBCloseAll() 
     !DEL C:\FORTUNA\DADOS\PED*.NTX 
     !DEL C:\FORTUNA\DADOS\PPD*.NTX 
 
  ENDIF 
  Set Device To Screen 
 
