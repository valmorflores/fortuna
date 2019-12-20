// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC550000 
* Descricao   - Cadastro de Notas Fiscais 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch" 

#ifdef HARBOUR
function VPC55000()
#endif


loca cTELA:=zoom(11,34,17,51), cCOR:=setcolor(), nOPCAO:=0
 
Public smPG:={15,(nMAXLIN-19),"NFINCLUSA","NFALTERA","alteranf()","nfmostra()",; 
  "'  '+strzero(CODIGO,4,0) + ' => ' + DESCRI+' '+"+; 
  "if(CGCMF_<>space(14),tran(CGCMF_,'@R 99.999.999/9999-99'),spac(18))+'  '"} 
 
Public smBUSCA:={{" 1 Codigo da N.Fiscal ","Pesquisa p/ codigo da Nota Fiscal."},; 
                 {" 2 Nome do cliente    ","Pesquisa p/ nome do cliente."}} 
vpbox(11,44,17,61) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,menunew(12,45," 1 Inclusao    ",2,COR[11], "Lancamento manual de notas fiscal.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(13,45," 2 Alteracao   ",2,COR[11], "Alteracao de notas fiscais.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(14,45," 3 Verificacao ",2,COR[11], "Verificacao do cadastro de notas fiscais.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(15,45," 4 Exclusao    ",2,COR[11], "Exclusao de notas fiscais.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(16,45," 0 Retorna     ",2,COR[11], "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO = 0 .or. nOPCAO=5; exit 
      case nOPCAO = 1; nfinclusao() 
      case nOPCAO = 2; alteranf() 
      case nOPCAO = 3; verificanf() 
      case nOPCAO = 4; excluinf() 
   endcase 
enddo 
limpavar() 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
