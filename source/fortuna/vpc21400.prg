// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC21000 
* Descricao   - Produtos (Manutencao) 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 09/Novembro/1994 
*/ 
#include "VPF.CH" 
#include "INKEY.CH" 

#ifdef HARBOUR
function vpc21400()
#endif


loca cTELA:=zoom(04,34,10,52), cCOR:=setcolor(), nOPCAO:=0
vpbox(04,34,10,52,"    Manutencao   ") 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(06,35," 1 Configuracao ",2,COR[11],; 
        "Configurar os campos para arquivo de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(07,35," 2 Critica      ",2,COR[11],; 
        "Verificacao de erros no arquivo de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(08,35," 3 Excluidos    ",2,COR[11],; 
        "Verificacao dos registros excluidos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(09,35," 0 Retorna      ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=4; exit 
      case nOPCAO=1; do VPC21410 
      case nOPCAO=2 
      case nOPCAO=3 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
