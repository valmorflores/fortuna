// ## CL2HB.EXE - Converted
 
/* 
* Modulo      - VPC1430000 
* Descricao   - Configuracoes de ambiente 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
#include "vpf.ch" 
#include "inkey.ch"

#ifdef HARBOUR
function vpc14300()
#endif


loca cTELA:=zoom(11,26,21,52), cCOR:=setcolor(), nOpcao:= 1 
    vpbox(11,26,21,52) 
    whil .t. 
       mensagem("") 
       aadd(MENULIST,menunew(12,27," 1 Parametros           ",2,COR[11], "Configuracao de parametros do sistema.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(13,27," 2 Cores                ",2,COR[11], "Configuracao de parametros do sistema.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(14,27," 3 Impressoras          ",2,COR[11], "Configuracao de parametros do sistema.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(15,27," 4 Mensagens            ",2,COR[11], "Remessa de t�tulos ao banco.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(16,27," 5 Papel de Parede      ",2,COR[11], "Retorna ao menu anterior.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(17,27," 6 Dados da Empresa     ",2,COR[11], "Configuracao de Informacoes sobre a empresa.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(18,27," 7 Diret�rios           ",2,COR[11], "Reorganizacao dos arquivos.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(19,27," 8 Sistema de Arquivos  ",2,COR[11], "Sistema de Abertura de Arquivos.",,,COR[6],.T.)) 
       aadd(MENULIST,menunew(20,27," 0 Retorna              ",2,COR[11], "Retorna ao menu anterior.",,,COR[6],.T.)) 
       menumodal(MENULIST,@nOPCAO); MENULIST:={} 
       do case 
          case nOpcao=0 .OR. nOpcao=9; exit 
          case nOpcao=1; cfgmasc() 
          case nOPCAO=2; TELACFG() 
          case nOpcao=3; IMPCFG() 
          case nOpcao=4; Config01() 
          case nOpcao=5; Config00() 
          case nOpcao=6; VPC14320() 
          case nOpcao=7; Config() 
          case nOpcao=8; SistFile() 
       endcase 
    enddo 
    unzoom(cTELA) 
    setcolor(cCOR) 
return(nil) 
 
