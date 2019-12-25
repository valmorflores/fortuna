// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC21000 
* Descricao   - Produtos (Materia Prima) 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 09/Novembro/1994 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function vpc22100()
#endif

loca cTELA:=zoom(04,44,09,62), cCOR:=setcolor(), nOPCAO:=0
 
Public smPG:={14,nMAXLIN-(14+4),"MPRINCLUSA","MPRALTERA","mpraltera()","mprmostra()",; 
       "'  '+CODIGO+' => '+DESCRI+'          '"} 
 
Public smBUSCA:={{" 1 Cod. produto       ","Pesquisa pelo codigo da materia prima."},; 
                 {" 2 Nome do produto    ","Pesquisa pelo nome da materia prima."}} 
 
vpbox(04,44,09,62) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(05,45," 1 Inclusao     ",2,COR[11],; 
        "Inclusao de Produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(06,45," 2 Alteracao    ",2,COR[11],; 
        "Alteracao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(07,45," 3 Exclusao     ",2,COR[11],; 
        "Exclusao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(08,45," 0 Retorna      ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=4; exit 
      case nOPCAO=1; asminclusao() 
      case nOPCAO=2; asmalteracao() 
      case nOPCAO=3; asmexclusao() 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
