// ## CL2HB.EXE - Converted
/* 
* 
*      Modulo - VPC14320 
*  Finalidade - Configurar os dados do usuario do sistema. 
* Parametros  - Nenhum 
* Programador - Valmor Pereira Flores 
* Data        - 13/Setembro/1994 
* 
*/ 
#include "VPF.CH" 
#include "INKEY.CH"

#ifdef HARBOUR
function vpc14320()
#endif

loca cCOR:=setcolor(), cTELA:=screensave(00,00,24,79),; 
     nCURSOR:=setcursor() 
loca WSTRU, WLINE01:=WLINE02:=WLINE03:=WLINE04:=WDESCRI:=spac(45) 
 
if ! file(_VPD_CONFIG) 
   WSTRU:={{"DESCRI","C",45,00},; 
           {"LINE01","C",45,00},; 
           {"LINE02","C",45,00},; 
           {"LINE03","C",45,00},; 
           {"LINE04","C",45,00},; 
           {"CORESV","C",60,00},; 
           {"SDIR__","C",40,00},; 
           {"GDIR__","C",40,00},; 
           {"CDRIVE","C",01,00},; 
           {"PARASN","C",05,00},; 
           {"MARGEM","N",02,00}} 
   dbcreate(_VPD_CONFIG,WSTRU) 
endif 
if !buscanet(15,{|| dbusearea(.f.,,_VPD_CONFIG,"CFG",.t.,.f.),!neterr()}) 
   screenrest(cTELA) 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   return nil 
endif 
if lastrec()=0 
   if !buscanet(15,{|| dbappend(),!neterr()}) 
      dbunlockall() 
      FechaArquivos() 
      screenrest(cTELA) 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      return nil 
   endif 
else 
   WDESCRI:=unzipchr(DESCRI) 
   WLINE01:=unzipchr(LINE01) 
   WLINE02:=unzipchr(LINE02) 
   WLINE03:=unzipchr(LINE03) 
   WLINE04:=unzipchr(LINE04) 
endif 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
vpbox(24/2-6,10,24/2+6,68,"Usuario",COR[16],.T.,.F.,COR[15]) 
setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
setcursor(1) 
@ 24/2-4,16 get WDESCRI when; 
  mensagem("Digite o nome da empresa para relatorios.") 
@ 24/2-2,16 get WLINE01 when; 
  mensagem("Digite o endereco para relatorios.") 
@ 24/2,16 get WLINE02 when; 
  mensagem("Digite o complemento (2) do endereco para relatorios.") 
@ 24/2+2,16 get WLINE03 when; 
  mensagem("Digite o complemento (3) do endereco para relatorios.") 
@ 24/2+4,16 get WLINE04 when; 
  mensagem("Digite o complemento (4) do endereco para relatorios.") 
read 
if buscanet(15,{|| flock(),!neterr()}) 
   repl DESCRI with zipchr(WDESCRI), LINE01 with zipchr(WLINE01),; 
        LINE02 with zipchr(WLINE02), LINE03 with zipchr(WLINE03),; 
        LINE04 with zipchr(WLINE04) 
endif 
dbunlockall() 
DBCloseArea() 
screenrest(cTELA) 
setcolor(cCOR) 
setcursor(nCURSOR) 
return nil 
