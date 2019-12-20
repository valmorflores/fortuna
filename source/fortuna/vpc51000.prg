// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC51000 
* Descricao   - Cadastro de Vendedores 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function vpc51000()
#endif



loca cTELA:=zoom(06,24,12,41), cCOR:=setcolor(), nOPCAO:=0
 
Public smPG:={10,10,"VENINCLUSA","VENALTERA","venaltera()","venmostra()",; 
       "'  '+strzero(CODIGO,4,0)+' => '+DESCRI+'  '+SIGLA_+' '+str(COMIVT,5,2)+'% '"+; 
       "+if(TIPO__='E','Externo  ','Interno  ')"} 
 
Public smBUSCA:={{" 1 Codigo do vendedor ","Pesquisa pelo codigo do vendedor."},; 
                 {" 2 Nome do vendedor   ","Pesquisa pelo nome do vendedor."}} 
 
vpbox(06,24,12,41) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(07,25," 1 Inclusao    ",2,COR[11],; 
        "Inclusao de vendedores.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(08,25," 2 Alteracao   ",2,COR[11],; 
        "Alteracao dos dados de vendedores.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(09,25," 3 Verificacao ",2,COR[11],; 
        "Verificacao dos dados cadastrais dos vendedores.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(10,25," 4 Exclusao    ",2,COR[11],; 
        "Exclusao dos dados dos vendedores.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(11,25," 0 Retorna     ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOPCAO=1; VenInclusao() 
      case nOPCAO=2; VenAlteracao() 
      case nOPCAO=3; VenVer() 
      case nOPCAO=4; VenExclusao() 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
