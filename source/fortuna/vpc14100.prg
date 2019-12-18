// ## CL2HB.EXE - Converted
 
#Define BOX_DUPLO      ( CHR(176) + CHR(176) + CHR(176) + CHR(176) + ; 
                         CHR(176) + CHR(176) + CHR(176) + CHR(176) ) 
 
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH" 
#include "PTVERBS.CH" 
/* 
* 
*      Modulo - VPC14330 
*  Finalidade - Configurar Cores para o sistema 
* Programador - Valmor Pereira Flores 
*        Data - 01/Novembro/1994 
* Atualizacao - 
* 
*/

#ifdef HARBOUR
function vpc14100()
#endif


  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor() 
  loca oTAB, cTELAR, cCORESV:="" 
  loca cBOXR0, cBOXR1, cBOXR2, aMODULO:={}, aCORES1:={}, aCORES2:={},; 
       aCORX1:={}, aCORX2:={}, nCT 
 
  priv nOP1:=nOP0:=nOP2:=1, MCR, MGT, nMOD:=0 
 
  //* TABELA DE CORES PADRAO DO SISTEMA *// 
  priv CORPADRAO:={"1100","0701","0300","0107","1200","0701","0500",; 
                   "1200","1107","0107","1507","0407","1401","0808",; 
                   "0107","0907","1501","1000","0103","0403","0903",; 
                   "1504","0306","0107","0507","1504"} 
 
  //* CRIAR ARQUIVO DE CONFIGURACAO, CASO NAO EXISTA E COLOCA-LO EM USO *// 
  if ! file(_VPD_CONFIG) 
     WSTRU:={{"DESCRI","C",45,00},; 
             {"LINE01","C",45,00},; 
             {"LINE02","C",45,00},; 
             {"LINE03","C",45,00},; 
             {"LINE04","C",45,00},; 
             {"LINE05","C",45,00},; 
             {"CORESV","C",60,00},; 
             {"SDIR__","C",40,00},; 
             {"GDIR__","C",40,00},; 
             {"CDRIVE","C",01,00},; 
             {"PARASN","C",05,00},; 
             {"MARGEM","N",02,00}} 
     dbcreate(_VPD_CONFIG,WSTRU) 
  endif 
  if !buscanet(15,{|| dbusearea(.f.,,_VPD_CONFIG,"CFG",.t.,.f.),!neterr()}) 
     restscreen(00,00,24,79,XTELA) 
     setcolor(XCOR) 
     setcursor(XCURSOR) 
     return nil 
  endif 
  for WCT:=1 to len(CORESV) 
      aadd(COR,restbyte(substr(CORESV,WCT,2))) 
      WCT=WCT+1 
  next 
 
  //* MATRIZ DE UTILIZACAO NA APRESENTACAO DAS INFORMACOES *// 
  MGT:={{ strtran(COR[1],"/",""), " AMBIENTE  - Linha externa          ",01 },; 
        { strtran(COR[2],"/",""), " AMBIENTE  - Titulo do sistema      ",02 },; 
        { strtran(COR[3],"/",""), " AMBIENTE  - Titulo/Mensagem/VPCOMP ",03 },; 
        { strtran(COR[4],"/",""), " AMBIENTE  - Fundo da tela          ",04 },; 
        { strtran(COR[5],"/",""), " AMBIENTE  - Usuario                ",05 },; 
        { strtran(COR[6],"/",""), " AMBIENTE  - Mensagem               ",06 },; 
        { strtran(COR[7],"/",""), " AJUDA     - Descricao              ",07 },; 
        { strtran(COR[8],"/",""), " AJUDA     - Mensagem               ",08 },; 
        { strtran(COR[9],"/",""), " MENU      - Titulo                 ",09 },; 
        { strtran(COR[10],"/","")," MENU      - Box                    ",10 },; 
        { strtran(COR[11],"/","")," MENU      - Letra realce           ",11 },; 
        { strtran(COR[12],"/","")," MENU      - Opcoes                 ",12 },; 
        { strtran(COR[13],"/","")," MENU      - Barra de selecao       ",13 },; 
        { strtran(COR[14],"/","")," SOMBRA    - Atributo               ",14 },; 
        { strtran(COR[15],"/","")," ENT.DADOS - Titulo                 ",15 },; 
        { strtran(COR[16],"/","")," ENT.DADOS - Box                    ",16 },; 
        { strtran(COR[17],"/","")," ENT.DADOS - Barra Inativa          ",17 },; 
        { strtran(COR[18],"/","")," ENT.DADOS - Barra Ativa            ",18 },; 
        { strtran(COR[19],"/","")," SEL.DADOS - Titulo                 ",19 },; 
        { strtran(COR[20],"/","")," SEL.DADOS - Box                    ",20 },; 
        { strtran(COR[21],"/","")," SEL.DADOS - Letra                  ",21 },; 
        { strtran(COR[22],"/","")," SEL.DADOS - Barra de selecao       ",22 },; 
        { strtran(COR[23],"/","")," INFORM.   - Titulo                 ",23 },; 
        { strtran(COR[24],"/","")," INFORM.   - Box                    ",24 },; 
        { strtran(COR[25],"/","")," INFORM.   - Letra                  ",25 },; 
        { strtran(COR[26],"/","")," GENERICO  - ALERTA                 ",26 } } 
 
  MCR:={{ "00", " Preto             ", " Preto             " },; 
        { "01", " Azul              ", " Azul              " },; 
        { "02", " Verde             ", " Verde             " },; 
        { "03", " Ciano             ", " Ciano             " },; 
        { "04", " Vermelho          ", " Vermelho          " },; 
        { "05", " Magenta           ", " Magenta           " },; 
        { "06", " Marrom            ", " Marrom            " },; 
        { "07", " Branco            ", " Branco            " },; 
        { "08", " Cinza             ", " Cinza             " },; 
        { "09", " Azul luminoso     ", " Azul Luminoso     " },; 
        { "10", " Verde luminoso    ", " Verde Luminoso    " },; 
        { "11", " Ciano luminoso    ", " Ciano Luminoso    " },; 
        { "12", " Vermelho luminoso ", " Vermelho Luminoso " },; 
        { "13", " Rosa              ", " Rosa Luminoso     " },; 
        { "14", " Amarelo           ", " Amarelo           " },; 
        { "15", " Branco luminoso   ", " Branco Luminoso   " }} 
 
  //* FORMATACAO DA TELA *// 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
//  usermodulo("Configuracao-CORES") 
  vpbox(01,01,24-2,79-1,"",COR[16],.F.,.F.,COR[19]) 
  setcolor( "15/00" ) 
  setcursor(0) 
 
  VPbox(01,01,24-02,38,,"15/00",.F.,.F.,COR[23]) 
  VPbox(01,39,24-10,58,,"15/00",.F.,.F.,COR[23]) 
  VPbox(01,59,24-10,78,,"15/00",.F.,.F.,COR[23]) 
 
  cBOXR0:=boxsave(01,01,24-2,38) 
  cBOXR1:=boxsave(01,39,24-10,58) 
  cBOXR2:=boxsave(01,59,24-10,78) 
 
  for nCT:=1 to len(MGT) 
      aadd(aMODULO,MGT[nCT][2]) 
  next 
  for nCT:=1 to len(MCR) 
      aadd(aCORES1,MCR[nCT][2]) 
      aadd(aCORX1,MCR[nCT][1]) 
      //if nCT<9 
         aadd(aCORES2,MCR[nCT][3]) 
         aadd(aCORX2,"15"+"/"+MCR[nCT][1]) 
      //endif 
  next 
 
  //* MOD1 - APRESENTACAO DE OPCOES *// 
  whil .T. 
     if nMOD=0 
        boxrest(cBOXR1) 
        boxrest(cBOXR2) 
        VPbox(01,01,24-2,38,,"15/00",.F.,.F.,COR[22]) 
        DispBox( 01, 01, 24-2, 38, BOX_DUPLO ) 
        nOP0:=vpmenu(02,02,24-3,37,aMODULO,nOP0,,,, "14/00" ) 
        if lastkey()==K_TAB 
           nMOD=1 
        endif 
     endif 
     if nOP0=0 
        exit 
     endif 
     if nMOD=1 .OR. nMOD=2 
        setcolor( "15/00" ) 
        if nMOD=1 
           nPOSICAO:= val( substr( MGT[ nOP0 ][ 1 ], 1, 2 ) ) + 1 
           boxrest(cBOXR0) 
           boxrest(cBOXR2) 
 
           VPbox(01,39,24-10,58,,"15/00",.F.,.F.,COR[22]) 
           DispBox( 01, 39, 24-10, 58, BOX_DUPLO ) 
           nOP1:=vpmenu( 02, 40, 24-11, 57, aCORES1, nPOSICAO, aCORX1,,, "14/00" ) 
 
        else 
 
           nPOSICAO:= val( substr( MGT[ nOP0 ][ 1 ], 3, 2 ) ) + 1 
           boxrest(cBOXR0) 
           boxrest(cBOXR1) 
 
           VPbox( 01, 59, 24-10, 78,,"15/00",.F.,.F.,COR[22]) 
           DispBox( 01, 59, 24-10, 78, BOX_DUPLO ) 
 
           //aCORX2:={} 
           for nCT:=1 to 15 
               //9 
               aadd(aCORX2,aCORX1[nOP1]+"/"+MCR[nCT][1]) 
           next 
           nOP2:=vpmenu(02,60,24-11,77,aCORES2,nPOSICAO,aCORX2,,,"14/00" ) 
           if nOP1<>0 .AND. nOP2<>0 
              MGT[nOP0]:={MCR[nOP1][1]+MCR[nOP2][1],MGT[nOP0][2],MGT[nOP0][3]} 
           endif 
        endif 
        if lastkey()=K_ESC 
           nMOD=0 
        else 
           if nOP0=0 
              exit 
           endif 
           if lastkey()=K_TAB 
              if nMOD=1 
                 nMOD:=2 
              else 
                 nMOD:=0 
              endif 
           endif 
        endif 
     endif 
  enddo 
  XCONFIG:=.T. 
  for nCT:=1 to len(MGT) 
      cCORESV:=cCORESV+tranbyte(MGT[nCT][1]) 
  next 
  if buscanet(15,{|| flock(),!neterr()}) 
     repl CORESV with cCORESV 
  endif 
 
  DBCloseArea() 
  screenrest(cTELA) 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
return(NIL) 
 
/* 
* Funcao      - TRANBYTE 
* Finalidade  - Transformar uma string numerica COR de 4 bytes em 1 byte 
*             - e retornar o mesmo. 
* Parametros  - STRING => String contendo 4 bytes. 
* Variaveis   - Nenhuma 
* Programador - Valmor Pereira Flores 
* Data        - 12/Setembro/1994 
* Atualizacao - 15/Setembro/1994 
*/ 
STAT func tranbyte(STRING) 
return(chr(val(substr(STRING,1,2))+150)+chr(val(substr(STRING,3,2))+150)) 
 
/* 
* Funcao      - RESTBYTE 
* Finalidade  - Retornar os 4 bytes da string gerada pela funcao TRANBYTE 
* Parametros  - BYTE => Byte a restaurar 
* Variaveis   - Nenhuma 
* Programador - Valmor Pereira Flores 
* Data        - 12/Setembro/1994 
* Atualizacao - 
*/ 
STAT func restbyte(BYTE) 
return(strzero((asc(substr(BYTE,1,1)))-150,2,0)+; 
       strzero((asc(substr(BYTE,2,1)))-150,2,0)) 
 
 
/* 
******************************************************************************* 
* 
* OSERVACAO: Esta e' a mesma funcao que se encontra na biblioteca VPBIBL95, 
*            mas que possui adaptacoes exclusivas para o modulo de configuracao 
*            de CORES. 
* 
******************************************************************************* 
* 
* Funcao      - VPMENU() - nOpcao 
* Finalidade  - Criar um menu de opcoes a partir de uma matriz. 
* Parametro   - nLIN1,nCOL1,nLIN2,nCOL2 => Coordenadas. 
*               aPOPCOES => Matriz contendo as opcoes. 
*               nPPOSICAO => Posicao inicial do cursor na matriz. 
*               aPCOROPCOES => Matriz paralela a aPOPCOES, com cores p/ opcoes. 
*               cAPONTA1 => Chr do apontador da esquerda. 
*               cAPONTA2 => Chr do apontador da direita. 
*               cCORAPONTADOR => Cor para apontadores. 
* Retorno     - Numero da opcao selecionada (0-Nenhuma) 
* Programador - VPFlores 
* Data        - 31/Agosto/1994 
* Atualizacao - 18/Novembro/1994 
* 
*/ 
stat func vpmenu(nLIN1,nCOL1,nLIN2,nCOL2,; 
          aPOPCOES,nPPOSICAO,aPCOROPCOES,cAPONTA1,cAPONTA2,cCORAPONTADOR) 
loca cCOR:=setcolor() 
loca nCT, nTLIN, nTECLA, nPOSICAO:=0, nCURSOR:=0 
 
nTLIN:=nLIN2-nLIN1                        && Numero total de linhas. 
nTCOL:=nCOL2-nCOL1                        && Numero total de colunas. 
nTSTR:=len(aPOPCOES[1])                   && Tamanho da String de opcao. 
nTAM_:=len(aPOPCOES)                      && Quantidade de opcoes. 
 
 
nPOSICAO:=nPPOSICAO 
nCURSOR:=0                                && Posicao inicial do cursor na tela. 
 
 
if nTLIN>nTAM_ 
   nTLIN:=nTAM_-1 
endif 
 
//* VERIFICA SE NAO ESTA NO FIM DA TELA *// 
nPOSTELA:=nTAM_-nPPOSICAO 
if nTLIN>nPOSTELA                         && Se Sobra espaco na tela? 
   nQUANT:=nTLIN-nPOSTELA                 && Calcula quantas linhas sobram. 
   nPOSICAO:=nPPOSICAO-nQUANT             && Ajusta a posicao inicial 
   nCURSOR:=nCURSOR+nQUANT                && Ajusta o cursor 
endif 
 
 
if nPOSICAO<=0 
   nPOSICAO:=1 
elseif nPOSICAO > 15 
   nPOSICAO:=15 
endif 
 
 
nCTLIN:=-1 
//* APRESENTA AS PRIMEIRAS OPCOES DA LISTA NA TELA *// 
for nCT:=nPOSICAO to nTAM_ 
    if aPCOROPCOES<>NIL 
       setcolor(aPCOROPCOES[nCT]) 
    endif 
    @ nLIN1+(++nCTLIN),nCOL1+1 say substr(aPOPCOES[nCT],1,nTCOL-1) 
    if nCTLIN>=nTLIN 
       exit 
    endif 
next 
 
nPOSICAO:=nPPOSICAO 
 
//* APONTADOR DA OPCAO *// 
@ nLIN1+nCURSOR,nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"Û") Color cCorApontador 
@ nLIN1+nCURSOR,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"Û") Color cCorApontador 
 
whil nTECLA<>K_ESC 
 
   //* APRESENTACAO DE EXEMPOS *// 
   if nMOD=0 
      cCORX_:=substr(MGT[nPOSICAO][1],1,2)+"/"+substr(MGT[nPOSICAO][1],3,2) 
   elseif nMOD=1 
      cCORX_:=MCR[nPOSICAO][1]+"/"+substr(MGT[nOP0][1],3,2) 
   elseif nMOD=2 
      cCORX_:=substr(MGT[nOP0][1],1,2)+"/"+MCR[nPOSICAO][1] 
   endif 
 
   Setcolor(cCORX_) 
   Scroll(24-9,39,24-2,79-1) 
   VPBox(24-9,39,24-2,79-1,cCORX_,.F.,.F.,cCORX_) 
   @ 24-7,43 say " *** EXEMPLO DE APRESENTACAO *** " 
   @ 24-5,43 say "        VPCOMP Informatica       " 
 
   nTECLA:=inkey(0) 
 
   //* COVERTER AS TECLAS (LEFTxRIGHT) POR (UPxDOWN) *// 
   nTECLA=if(nTECLA=K_LEFT,K_UP,nTECLA) 
   nTECLA=if(nTECLA=K_RIGHT,K_DOWN,nTECLA) 
 
   //* TESTAR A TECLA *// 
   do case 
      case nTECLA=K_DOWN .AND. nPOSICAO<nTAM_  //* SETA PARA BAIXO *// 
           ++nPOSICAO 
           if nCURSOR>=nTLIN        //-1 
              scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,1) 
              //* COR DE OPCOES *// 
              if aPCOROPCOES<>NIL 
                 setcolor(aPCOROPCOES[nPOSICAO]) 
              else 
                 setcolor(cCOR) 
              endif 
              @ nLIN2,nCOL1+1 say substr(aPOPCOES[nPOSICAO],1,nTCOL-1) 
           elseif nCURSOR<nTLIN 
              @ nLIN1+nCURSOR,nCOL1 say " " Color cCorApontador 
              @ nLIN1+nCURSOR,nCOL2 say " " Color cCorApontador 
              @ nLIN1+(++nCURSOR),nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"Û") Color cCorApontador 
              @ nLIN1+nCURSOR,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"Û")     Color cCorApontador 
           endif 
      case nTECLA=K_UP .AND. nPOSICAO>1        //* SETA PARA CIMA *// 
           --nPOSICAO 
           if nCURSOR=0    // <=1 
              //* COR DE OPCOES *// 
              if aPCOROPCOES<>NIL 
                 setcolor(aPCOROPCOES[nPOSICAO]) 
              else 
                 setcolor(cCOR) 
              endif 
              scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,-1) 
              @ nLIN1,nCOL1+1 say substr(aPOPCOES[nPOSICAO],1,nTCOL-1) 
           elseif nCURSOR>0  // >1 
              //* MUDAR PARA COR DO APONTADOR *// 
              @ nLIN1+nCURSOR,nCOL1 say " " Color cCorApontador 
              @ nLIN1+nCURSOR,nCOL2 say " " Color cCorApontador 
              @ nLIN1+(--nCURSOR),nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"Û") Color cCorApontador 
              @ nLIN1+nCURSOR,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"Û")     Color cCorApontador 
           endif 
      case nTECLA==K_PGDN                      //* PAGE DOWN *// 
           if nPOSICAO+nTLIN<=nTAM_ 
              nPOSICAO=nPOSICAO+nTLIN 
           else 
              //* MUDAR PARA COR DO APONTADOR *// 
              @ nLIN1+nCURSOR,nCOL1 say " " Color cCorApontador 
              @ nLIN1+nCURSOR,nCOL2 say " " Color cCorApontador 
              @ nLIN1,nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"Û") Color cCorApontador 
              @ nLIN1,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"Û") Color cCorApontador 
              nPOSICAO:=nTAM_ 
              nCURSOR:=0 
           endif 
           setcolor(cCOR) 
           scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,0) 
           nCTLIN:=-1 
           for nCT:=nPOSICAO to nTAM_ 
               if aPCOROPCOES<>NIL 
                  setcolor(aPCOROPCOES[nCT]) 
               endif 
               @ nLIN1+(++nCTLIN),nCOL1+1 say substr(aPOPCOES[nCT],1,nTCOL-1) 
               if nCTLIN>=nTLIN 
                   exit 
               endif 
           next 
      case nTECLA==K_PGUP                      //* PAGE UP *// 
           if nPOSICAO-nTLIN>=nLIN1 
              nPOSICAO=nPOSICAO-nTLIN 
           else 
              //* MUDAR PARA COR DO APONTADOR *// 
              @ nLIN1+nCURSOR,nCOL1 say " " Color cCorApontador 
              @ nLIN1+nCURSOR,nCOL2 say " " Color cCorApontador 
              @ nLIN1,nCOL1 say if(cAPONTA1<>NIL,cAPONTA1,"Û") Color cCorApontador 
              @ nLIN1,nCOL2 say if(cAPONTA2<>NIL,cAPONTA2,"Û") Color cCorApontador 
              nPOSICAO:=1 
              nCURSOR:=0 
           endif 
           setcolor(cCOR) 
           scroll(nLIN1,nCOL1+1,nLIN2,nCOL2-1,0) 
           nCTLIN:=-1 
           for nCT:=nPOSICAO to nTAM_ 
               if aPCOROPCOES<>NIL 
                  setcolor(aPCOROPCOES[nCT]) 
               endif 
               @ nLIN1+(++nCTLIN),nCOL1+1 say substr(aPOPCOES[nCT],1,nTCOL-1) 
               if nCTLIN>=nTLIN 
                   exit 
               endif 
           next 
      case nTECLA=K_ENTER .OR. nTECLA=K_TAB    //* TAB ou ENTER *// 
           setcolor(cCOR) 
           return(nPOSICAO) 
      endcase 
enddo 
SetColor(cCOR) 
return(0) 
