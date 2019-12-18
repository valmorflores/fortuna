// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH" 
#include "PTVERBS.CH" 
 
/* 
* Funcao       - VPC21410 
* Finalidade   - Configuracao do arquivo de produtos. 
* Programador  - Valmor Pereira Flores 
* Data         - 01/Novembro/1994 
* Atualizacao  - 
*/ 

#ifdef HARBOUR
function vpc21410()
#endif


loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor()
loca cMASCACOD:=spac(12), cMASCQUAN:=spac(12), cMASCPREC:=spac(16),; 
     cORIGEM:="S", cASSOCIAR:="S" 
priv nCMOD:=0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    usermodulo(" PRODUTOS - Configuracao de arquivo ") 
    setcolor(COR[16]) 
    scroll(01,01,22,78) 
    setcolor(COR[20]+","+COR[18]+",,,"+COR[17]) 
    vpbox(01,01,13,45," Dados de configuracao ",COR[20],.T.,.F.,COR[20]) 
    @ 03,03 say "Mascara p/ codigo....:" get cMASCACOD pict "@!" valid mascaravale(cMASCACOD,2) when informacoes(1) 
    @ 05,03 say "Mascara p/ quantidade:" get cMASCQUAN pict "@!" valid mascaravale(cMASCQUAN,1) when informacoes(2) 
    @ 07,03 say "Mascara para valores.:" get cMASCPREC pict "@!" valid mascaravale(cMASCPREC,1) when informacoes(3) 
    @ 09,03 say "Utilizar Origens.....:" get cORIGEM pict "@!" valid cORIGEM$"SN" when informacoes(4) 
 
    @ 11,03 say "Assoc. (Quant.x Est.):" get cASSOCIAR pict "@!" valid cASSOCIAR$"SN" when informacoes(5) 
    read 
    screenrest(cTELA) 
    setcolor(cCOR) 
    setcursor(nCURSOR) 
return nil 
 
stat func informacoes(MOD) 
    if MOD=nCMOD 
       return(.t.) 
    endif 
    nCMOD=MOD 
    do case 
       case MOD=1 
            vpobsbox(.T.,10,42," Informacoes ",{"   Crie uma mascara utilizando   ",; 
                                                "   os seguintes caracteres:      ",; 
                                                "   G => Grupo                    ",; 
                                                "   N => Codigo                   ",; 
                                                "   V => Digito verificador       ",; 
                                                "   - ou . => Separadores         ",; 
                                                "   Sendo que devera haver  so-   ",; 
                                                "   mente 1 (um) digito verifi-   ",; 
                                                "   cador.                        ",; 
                                                "   Ex. [GGG-NNNN.V  ]            "},COR[18]) 
            mensagem("Crie uma mascara para apresentacao do codigo do produto.") 
       case MOD=2 
            vpobsbox(.T.,10,42," Informacoes ",{"   Crie uma mascara utilizando   ",; 
                                                "   os seguintes caracteres:      ",; 
                                                "   9 => Valor ÄÄÄÄÄÄÄÄÄÄÄÄ¿      ",; 
                                                "   . => Decimal ÄÄÄÄÄÄÄÄ¿ ³      ",; 
                                                "   , => Separador ÄÄ¿   ³ ³      ",; 
                                                "   Exemplo      [999.999,99  ]   ",; 
                                                "   Sendo que nao podera  haver   ",; 
                                                "   casos em que o usuario con-   ",; 
                                                "   figure com uma virgula apos   ",; 
                                                "   a outra. ex [999,,99    ]     "},COR[18]) 
            mensagem("Crie uma mascara p/ apresentacao da quantidade de produtos.") 
       case MOD=3 
            vpobsbox(.T.,10,42," Informacoes ",{"   Crie uma mascara utilizando   ",; 
                                                "   os seguintes caracteres:      ",; 
                                                "   9 => Valor ÄÄÄÄÄÄÄÄÄÄÄÄ¿      ",; 
                                                "   , => Decimal ÄÄÄÄÄÄÄÄ¿ ³      ",; 
                                                "   . => Separador ÄÄ¿   ³ ³      ",; 
                                                "   Exemplo  [999.999.999,99  ]   ",; 
                                                "   Sendo que nao podera  haver   ",; 
                                                "   casos em que o usuario con-   ",; 
                                                "   figure c/ um separador apos   ",; 
                                                "   o outro. ex [999.999,,99  ]   "},COR[18]) 
            mensagem("Crie uma mascara p/ apresentacao dos valores que se referem a produtos.") 
       case MOD=4 
            vpobsbox(.T.,10,42," Informacoes ",{"   Este item faz a  integracao   ",; 
                                                "   do modulo de origens (fabri   ",; 
                                                "   cantes) ao modulo de produ-   ",; 
                                                "   tos.                          ",; 
                                                "                                 ",; 
                                                "                                 ",; 
                                                "                                 ",; 
                                                "                                 ",; 
                                                "                                 ",; 
                                                "                                 "},COR[18]) 
            mensagem("Deseja Integrar o modulo de cadastro de origem aos produtos?") 
       case MOD=5 
            vpobsbox(.T.,10,42," Informacoes ",{"   *Este item faz a integracao   ",; 
                                                "   entre os modulos de QUANTIA   ",; 
                                                "   e ESTOQUE (MIN e MAX), per-   ",; 
                                                "   mitindo que o usuario  faca   ",; 
                                                "   uma previa em quantia, como   ",; 
                                                "   por exemplo em KILOS,  caso   ",; 
                                                "   um material possua 10000Kg,   ",; 
                                                "   voce podera averiguar  qual   ",; 
                                                "   o seu estoque minimo e maxi   ",; 
                                                "   mo em quilos.                 "},COR[18]) 
            mensagem("Digite [S] para confirmar a integracao entre modulos.") 
    endcase 
return(.t.) 
 
stat func associar 
 
return(.T.) 
 
 
 
 
/* 
*      Funcao - MASCARAVALE 
*   Finlidade - Testar se a mascara digitada pelo usuario e' valida 
*  Parametros - MASCARA=>Variavel com a mascara digitada pelo usuario 
*             - MOD=>(1)-Teste atribuido a variaveis numericas. 
*             -      (2)-Teste especifico ao codigo de produtos. 
* Programador - ValmorPF 
*        Data - 10/Novembro/1994 
* Atualizacao - 10/Novembro/1994 
*/ 
stat func mascaravale(MASCARA,MOD) 
loca cMP:={}, cMA:="", nCT, cMASCARA:=alltrim(MASCARA), FIM:=0 
    if MOD=1 // Valores 
       for nCT=1 to len(cMASCARA) 
           aadd(cMP,substr(cMASCARA,nCT,1)) 
           if cMP[nCT]<>"9" .AND. cMP[nCT]<>"," .AND. cMP[nCT]<>"." 
              mensagem("ERRO: Um dos caracteres digitado e' imcompativel com os permitidos.",1) 
              pausa() 
              return(.F.) 
           endif 
           if cMP[nCT]="." .OR. cMP[nCT]="," 
              if cMP[nCT]=","  ;++FIM 
              elseif FIM=1 
                  mensagem("ERRO: Nao pode ser digitado caracter separador apos a <,> decimal.") 
                  pausa() 
                  return(.F.) 
              endif 
           endif 
           if(nCT>1,cMA:=cMP[nCT-1],nil) 
           if cMA="," .OR. cMA="." 
              if cMA=cMP[nCT] .OR. (cMA+cMP[nCT]=".,") .OR. (cMA+cMP[nCT]=",.") 
                 mensagem("ERRO: Conhecidencia de separadores ou <.> e <,> seguidos.",1) 
                 pausa() 
                 return(.F.) 
              endif 
           endif 
       next 
    elseif MOD=2 // Codigo de produto 
       for nCT=1 to len(cMASCARA) 
           aadd(cMP,substr(cMASCARA,nCT,1)) 
           if !cMP[nCT]$"G-N.V" 
              mensagem("ERRO: Um dos caracteres digitado e' imcompativel com os permitidos.",1) 
              pausa() 
              return(.F.) 
           endif 
           if(nCT>1,cMA:=cMP[nCT-1],nil) 
           if cMA="-" .OR. cMA="." 
              if cMA=cMP[nCT] .OR. (cMA+cMP[nCT]="-.") .OR. (cMA+cMP[nCT]=".-") 
                 mensagem("ERRO: Conhecidencia de separadores ou <.> e <-> seguidos.",1) 
                 pausa() 
                 return(.F.) 
              endif 
           endif 
       next 
    endif 
return(.T.) 
