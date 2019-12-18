// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC21000 
* Descricao   - Produtos (Materia Prima) 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 09/Novembro/1994 
*/ 
#include "VPF.CH" 
#include "INKEY.CH" 

#ifdef HARBOUR
function vpc21100()
#endif


loca cTELA:=zoom(04,44,10,62), cCOR:=setcolor(), nOPCAO:=0
 
Public smPG:={18,nMAXLIN-(18+3),"MPRINCLUSA","MPRALTERA","mpraltera()","mprmostra()",; 
       "'  '+CODIGO+' => '+DESCRI+'          '"} 
 
Public smBUSCA:={{" 1 Cod. Mat. Prima    ","Pesquisa pelo codigo da materia prima."},; 
                 {" 2 Nome Materia Prima ","Pesquisa pelo nome da materia prima."}} 
 
vpbox(04,44,10,62) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(05,45," 1 Inclusao     ",2,COR[11],; 
        "Inclusao de Produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(06,45," 2 Alteracao    ",2,COR[11],; 
        "Alteracao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(07,45," 3 Exclusao     ",2,COR[11],; 
        "Exclusao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(08,45," 4 Verificacao  ",2,COR[11],; 
        "Verificacao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(09,45," 0 Retorna      ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOPCAO=1; mprinclusao() 
      case nOPCAO=2; mpralteracao() 
      case nOPCAO=3; mprexclusao() 
      case nOPCAO=4; mprverifica() 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
