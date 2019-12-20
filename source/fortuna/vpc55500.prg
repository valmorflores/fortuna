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
function vpc55500()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
loca nOPCAO:=0 
 
Public smPG:={15,(nMAXLIN-19),"NFINCLUSA","NFALTERA","alteranf()","nfmostra()",; 
  "'  '+strzero(CODIGO,4,0) + ' => ' + DESCRI+' '+"+; 
  "if(CGCMF_<>space(14),tran(CGCMF_,'@R 99.999.999/9999-99'),spac(18))+'  '"} 
 
Public smBUSCA:={{" 1 Codigo da N.Fiscal ","Pesquisa p/ codigo da Nota Fiscal."},; 
                 {" 2 Nome do cliente    ","Pesquisa p/ nome do cliente."}} 
VPBox( 10, 24, 20, 49 ) 
whil .t. 
   Mensagem("") 
   AAdd(MENULIST,menunew(11,25," 1 Autom�tico          ",2,COR[11],; 
        "Lancamento autom�tico de notas fiscal.",,,COR[6],.T.)) 
   AAdd(MENULIST,menunew(12,25," 2 Manual              ",2,COR[11],; 
        "Lancamento manual de notas fiscais.",,,COR[6],.T.)) 
   AAdd(MENULIST,menunew(13,25," 3 Multi-Processamento ",2,COR[11],; 
        "Processamento de multiplas notas fiscais.",,,COR[6],.T.)) 
   @ 14,25 Say "������������������������" Color COR[ 11 ] 
   AAdd(MENULIST,menunew(15,25," 4 Cupom Fiscal        ",2,COR[11],; 
        "Verificacao de Cupons Fiscais Emitidos.",,,COR[6],.T.)) 
   @ 16,25 Say "������������������������" Color COR[ 11 ] 
   AAdd(MENULIST,menunew(17,25," 5 Pesquisas           ",2,COR[11],; 
        "Pesquisas com base em Notas Fiscais.",,,COR[6],.T.)) 
   @ 18,25 Say "������������������������" Color COR[ 11 ] 
   AAdd(MENULIST,menunew(19,25," 0 Retorna             ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=6; exit 
      case nOpcao==1; NFISCAL() 
      case nOpcao==2; NFMANUAL() 
      case nOpcao==3; MultiRota() 
      case nOpcao==4; VPC56000() 
      case nOpcao==5; VPC66000() 
   endcase 
enddo 
limpavar() 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
