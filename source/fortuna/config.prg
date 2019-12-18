// ## CL2HB.EXE - Converted
   #Include "VPF.CH"
   #Include "INKEY.CH" 
   /***** 
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
   ³ Funcao      ³ CONFIG 
   ³ Finalidade  ³ Configuracao de Diretorios 
   ³ Parametros  ³ Nil 
   ³ Retorno     ³ Nil 
   ³ Programador ³ Valmor Pereira Flores 
   ³ Data        ³ 23/02/1999 
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
   */ 
#ifdef HARBOUR
function config()
#endif

   Para nEmp
   local Local1:= screensave(0, 0, 24, 79), Local2:= ; 
      SetColor() 
 
   // Se nEmp estiver preenchido significa que deseja-se modificar o diretorio 
   // da empresa que se esta para a empresa destinada pela variavel nEMP 
   IF !nEmp==Nil 
      nArea:= Select() 
      Sele 123 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE vpceicfg.dat 
      xdiretorio:= unzipchr( GDIR__ ) 
      IF !nEmp==0 
         IF AT( _PATH_SEPARATOR - "0", xDiretorio ) > 0 
            cDir:= ALLTRIM( SubStr( xDiretorio, 1, AT( _PATH_SEPARATOR - "0", xDiretorio ) - 1 ) ) + _PATH_SEPARATOR - "0" + StrZero( nEmp, 3, 0 ) 
         ELSE 
            cDir:= Alltrim( xDiretorio ) + _PATH_SEPARATOR - "0" + StrZero( nEmp, 3, 0 ) 
         ENDIF 
      ELSE 
         IF AT( _PATH_SEPARATOR - "0", xDiretorio ) > 0 
            cDir:= ALLTRIM( SubStr( xDiretorio, 1, AT( _PATH_SEPARATOR - "0", xDiretorio ) - 1 ) ) 
         ELSE 
            cDir:= ALLTRIM( xDiretorio ) 
         ENDIF 
      ENDIF 
      Replace gdir__ with zipchr( PAD( cDir, LEN( GDIR__ ) ) ) 
      DBCloseArea() 
      DBSelectAr( nArea ) 
 
      // VALMOR: 22/04/2003 - Transporta o codigo do diretorio para o GDir principal 
      GDir:= cDir 
 
      // VALMOR: 22/04/2003 - Preenche a informacao de diretorio 
      // padrao com as informacoes de GDir. Sempre que for passado 0 como 
      // parametro a fun‡Æo SetDiretorioPadrao faz isso. 
      SetDiretorioPadrao( 0 ) 
 
      Return Nil 
   ENDIF 
   vpbox(0, 0, 24 - 2, 79, " Configuracao de Diret¢rios ", _COR_GET_BOX ) 
   sele 124 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   use vpceicfg.dat 
   xdiretorio:= unzipchr(gdir__) 
   set scoreboard (.F.) 
   setcolor( _COR_GET_EDICAO ) 
   mensagem("Digite o nome do diret¢rio de trabalho...") 
   desligamouse() 
   IF AT( _PATH_SEPARATOR - "0", xDiretorio ) > 0 
      cEmpresa:= ALLTRIM( SubStr( xDiretorio, AT( _PATH_SEPARATOR - "0", xDiretorio ) + 2 ) ) 
   ELSE 
      cEmpresa:= "000" 
   ENDIF 
   @ 08, 02 Say "Diretorio Atual....: [" + PAD( CURDIR(), 30 ) + "]" 
   @ 10, 02 Say "Diretorio de Dados.:" Get XDIRETORIO 
   @ 12, 02 Say "Diretorio Report...: [" + PAD( SWSet( _SYS_DIRREPORT ), 30 ) + "]" 
   @ 14, 02 Say "Empresa Selecionada: [" + cEmpresa + "]" 
   DesligaMouse() 
   READ 
   replace gdir__ with zipchr(xdiretorio) 
   gravaemdisco() 
   DBCloseArea() 
   set color to W/N 
   set color to (Local2) 
   screenrest(Local1) 
   return Nil 
 


// ## CL2HB.EXE - Converted
/* 
* Modulo      - CONFIG 
* Finalidade  - Configurar o sistema apartir de dados definidos pelo 
*             - usuario. 
* Parametros  - Nenhum 
* Variaveis   - _VPD_CONFIG => Nome do arquivo BD. 
*             - WSTRU       => Matriz com a estrutura do arquivo 
*             - XTELA       => Variavel c/ tela do modulo anterior salva 
*             - XCURSOR     => Variavel c/ modo anterior do cursor 
*             - XCOR        => Variavel c/ a cor definida no modulo anterior 
*             - WEMPRESA    => Variavel c/ Nome da empresa usuaria 
*             - WLINE01     => Variavel c/ endereco da empresa 
*             - WLINE02     => Variavel c/ qualquer outro dado da empresa 
*             - WGDIR       => Variavel c/ diretorio principal 
*             - WSDIR       => Variavel c/ diretorio secundario 
*             - WCOPDRIVE   => Drive p/ copia de seguranca 
*             - WPSENHA     => Utilizar Senhas? 
*             - WPDATA      => Solicitar Data? 
*             - WPSOMBRA    => Exibir sombras? 
*             - WPSOM       => Emitir Aviso sonoro? 
*             - WPZOOM      => Utilizar zoom? 
*             - WMARGEM     => Qual a Margem p/relat.? 
* Programador - Valmor Pereira Flores 
* Data        - 13/Setembro/1994 
*/ 

Function ceconfig()


loca XCOR:=setcolor(), XTELA:=savescreen(00,00,24,79), XCURSOR:=setcursor() 
loca WSTRU, WLINE01:=WLINE02:=WDESCRI:=spac(45), WGDIR:=WSDIR:=spac(40),; 
     WCOPDRIVE:=" ", WPSENHA:=WPDATA:=WPSOMBRA:=WPSOM:=WPZOOM:=" ", WMARGEM:=0,; 
     WCORESV:="", cTELA 
priv CORPADRAO:={"1100","0701","0300","0107","1200","0701","0500",; 
                 "1200","1107","0107","1507","0407","1401","0808",; 
                 "0107","0907","1501","1000","0103","0403","0903",; 
                 "1504","0306","0107","0507","1504"} 
if ! file(_VPD_CONFIG) 
   WSTRU:={{"DESCRI","C",45,00},; 
           {"LINE01","C",45,00},; 
           {"LINE02","C",45,00},; 
           {"CORESV","C",60,00},; 
           {"SDIR__","C",40,00},; 
           {"GDIR__","C",40,00},; 
           {"CDRIVE","C",01,00},; 
           {"PARASN","C",05,00},; 
           {"MARGEM","N",02,00}} 
   dbcreate(_VPD_CONFIG,WSTRU) 
endif 
if !NetUse( _VPD_CONFIG, .F., 1, "CFG", .f. ) 
   restscreen(00,00,24,79,XTELA) 
   setcolor(XCOR) 
   setcursor(XCURSOR) 
   return nil 
endif 
if lastrec()=0 
   if !buscanet(15,{|| dbappend(),!neterr()}) 
      dbunlockall() 
      FechaArquivos() 
      restscreen(00,00,24,79,XTELA) 
      setcolor(XCOR) 
      setcursor(XCURSOR) 
      return nil 
   endif 
else 
   WDESCRI:=unzipchr(DESCRI) 
   WLINE01:=unzipchr(LINE01) 
   WLINE02:=unzipchr(LINE02) 
   WSDIR:=unzipchr(SDIR__) 
   WGDIR:=unzipchr(GDIR__) 
   WCOPDRIVE:=CDRIVE 
   WPSENHA:=substr(PARASN,1,1) 
   WPDATA:=substr(PARASN,2,1) 
   WPSOMBRA:=substr(PARASN,3,1) 
   WPSOM:=substr(PARASN,4,1) 
   WPZOOM:=substr(PARASN,5,1) 
   WMARGEM:=MARGEM 
   for WCT:=1 to len(CORESV) 
       aadd(COR,restbyte(substr(CORESV,WCT,2))) 
       WCT=WCT+1 
   next 
endif 
setcolor(COR[21]) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
cTELA:=zoom(03,01,21,78) 
vpbox(03,01,21,78,"",COR[16],.f.,,COR[16]) 
 
/* Geracao dos boxes */ 
vpbox(04,02,08,48,"Usuario",COR[16],.f.,,COR[16]) 
vpbox(09,02,18,26,"Parametros",COR[16],.f.,,COR[16]) 
vpbox(04,49,18,77,"Modulos & Cores",COR[16],.f.,,COR[16]) 
vpbox(09,27,18,48,"Diretorios",COR[16],.f.,,COR[16]) 
 
/* Impressao da tabela de cores */ 
setcolor("7/0") 
scroll(19,21,20,70) 
@ 19,3 say " Tabela de Cores " 
setcolor(COR[16]) 
for WCT:=0 to 7 
    setcolor(strzero(WCT,2,0)) 
    @ 19,22+(WCT*7) say strzero(WCT,2,0)+"=>"+repl(chr(219),2) 
    setcolor(strzero(WCT+8,2,0)) 
    @ 20,22+(WCT*7) say strzero(WCT+8,2,0)+"=>"+repl(chr(219),2) 
    if WCT=0 
       setcolor("07/00") 
       @ 19,22 say "00=>" 
    endif 
next 
setcolor(COR[16]) 
/* Solicitacao dos dados */ 
@ 11,3 say "Utilizar Senhas?" 
@ 12,3 say "Solicitar Data?" 
@ 13,3 say "Exibir sombras?" 
@ 14,3 say "Aviso sonoro?" 
@ 15,3 say "Zoom?" 
@ 16,3 say "Margem p/relat. =>" 
@ 11,28 say "Principal" 
@ 13,28 say "Secundario" 
@ 15,28 say "Copias" 
@ 16,29 say ":" 
set(_SET_DELIMITERS,.f.) 
setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
setcursor(1) 
@ 05,03 get WDESCRI when mensagem("Digite o nome da empresa para relatorios.") 
@ 06,03 get WLINE01 when mensagem("Digite o endereco para relatorios.") 
@ 07,03 get WLINE02 when mensagem("Digite o complemento do endereco para relatorios.") 
@ 11,21 get WPSENHA pict "!" valid simnao(WPSENHA) when mensagem("Digite [S] para utilizar o controle de senhas.") 
@ 12,21 get WPDATA pict "!" valid simnao(WPDATA) when mensagem("Digite [S] para solicitacao da data do sistema.") 
@ 13,21 get WPSOMBRA pict "!" valid simnao(WPSOMBRA) when mensagem("Digite [S] para utilizar sombra.") 
@ 14,21 get WPSOM pict "!" valid simnao(WPSOM) when mensagem("Digite [S] para emitir aviso sonoro.") 
@ 15,21 get WPZOOM pict "!" valid simnao(WPZOOM) when mensagem("Digite  [S] para gerar zoom nos boxes.") 
@ 16,22 get WMARGEM pict "99" valid WMARGEM<12 when mensagem("Digite a margem para relatorios.") 
@ 12,28 get WGDIR pict "@S20" when mensagem("Digite o nome do diretorio principal.") 
@ 14,28 get WSDIR pict "@S20" when mensagem("Digite o nome do diretorio secundario.") 
@ 16,28 get WCOPDRIVE pict "@!" valid WCOPDRIVE$"AB" when mensagem("Digite o drive para copias de seguranca.") 
read 
set(_SET_DELIMITERS,.t.) 
cores() 
for WCT:=1 to len(COR) 
    WCORESV:=WCORESV+tranbyte(COR[WCT]) 
next 
XCONFIG=.T.         /* (.T.)Reconfigurar o sistema VPCOMP */ 
if buscanet(15,{|| flock(),!neterr()}) 
   repl DESCRI with zipchr(WDESCRI), LINE01 with zipchr(WLINE01),; 
        LINE02 with zipchr(WLINE02), SDIR__ with zipchr(WSDIR),; 
        GDIR__ with zipchr(WGDIR), PARASN with WPSENHA+WPDATA+WPSOMBRA+WPSOM+WPZOOM,; 
        MARGEM with WMARGEM, CDRIVE with WCOPDRIVE,; 
        CORESV with WCORESV 
endif 
setconfig() 
dbunlockall() 
FechaArquivos() 
unzoom(cTELA) 
restscreen(00,00,24,79,XTELA) 
setcursor(XCURSOR) 
setcolor(XCOR) 
return nil 
 
/* 
Funcao        - SIMNAO 
Finalidade    - Escrever SIM ou NAO na tela 
Parametros    - WSN => S ou N 
Retorno       - Sim/Nao na tela 
*/ 
stat func simnao(WSN) 
if WSN$"SN" 
   @ row(),col()-1 say if(WSN="S","Sim","Nao") 
   return(.t.) 
else 
   return(.f.) 
endif 
 
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
func tranbyte(STRING) 
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
func restbyte(BYTE) 
return(strzero((asc(substr(BYTE,1,1)))-150,2,0)+; 
       strzero((asc(substr(BYTE,2,1)))-150,2,0)) 
 
/* 
* Modulo      - CORES 
* Parametro   - Selecionar CORES na configuracao. 
* Finalidade  - Pesquisa existencia do estad digitado. 
* Variaveis   - oTAB        => Objeto para o tbrowse() 
*             - XCURSOR     => Variavel c/ modo anterior doX cursor 
*             - XCOR        => Variavel c/ a cor definida no modulo anterior 
*             - MT          => Matriz contendo dados COR e descricao do modulo 
*             - COR         => Matriz contendo dados COR (Criada na SETCONFIG() como private e 
*                              Utilizada em todos os modulos do sistema atravez do setcolor 
*                              do clipper com a seguinte syntaxe setcolor(COR[nn])). 
*             - WROW        => Variavel c/ a posicao do cursor na matriz MT. 
*             - WTOJUMP     => Variavel com incremento produzido por SKIPPERARR() 
*             - WTELA       => Salva tela na esdicao. 
* Programador - Valmor Pereira Flores 
* Data        - 01/Fevereiro/1994 
* Atualizacao - 
*/ 
func CORES() 
loca oTAB, XCOR:=setcolor(), MT[28][2], WTELA 
loca WROW:=1 
MT:={{ strtran(COR[1],"/",""), "01-Linha externa     " },; 
     { strtran(COR[2],"/",""), "02-Titulo do sistema " },; 
     { strtran(COR[3],"/",""), "03-Tit/Mens/VPCOMP   " },; 
     { strtran(COR[4],"/",""), "04-Fundo da tela     " },; 
     { strtran(COR[5],"/",""), "05-Usuario           " },; 
     { strtran(COR[6],"/",""), "06-Mensagem          " },; 
     { strtran(COR[7],"/",""), "07-Ajuda             " },; 
     { strtran(COR[8],"/",""), "08-Mensagem de ajuda " },; 
     { strtran(COR[9],"/",""), "09-Titulo menu       " },; 
     { strtran(COR[10],"/",""),"10-Box do menu       " },; 
     { strtran(COR[11],"/",""),"11-Letra realse menu " },; 
     { strtran(COR[12],"/",""),"12-Opcoes do menu    " },; 
     { strtran(COR[13],"/",""),"13-Barra de selecao  " },; 
     { strtran(COR[14],"/",""),"14-Atributo de sombra" },; 
     { strtran(COR[15],"/",""),"15-Titulo ent. dados " },; 
     { strtran(COR[16],"/",""),"16-Box ent. de dados " },; 
     { strtran(COR[17],"/",""),"17-Barra dig. Inativa" },; 
     { strtran(COR[18],"/",""),"18-Barra dig. Ativa  " },; 
     { strtran(COR[19],"/",""),"19-Titulo selecao BD " },; 
     { strtran(COR[20],"/",""),"20-Box sel. a BD     " },; 
     { strtran(COR[21],"/",""),"21-Letras de BD      " },; 
     { strtran(COR[22],"/",""),"22-Barra de selecao  " },; 
     { strtran(COR[23],"/",""),"23-Titulo observacoes" },; 
     { strtran(COR[24],"/",""),"24-Box de observacoes" },; 
     { strtran(COR[25],"/",""),"25-Letra de observ.  " },; 
     { strtran(COR[26],"/",""),"26-Alerta            " } } 
setcolor(COR[21]+","+COR[22]) 
setcursor(0) 
mensagem("Pressione ENTER para selecionar ou ESC para retornar.") 
ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [ENTER]Altera [F2]Padrao [F3]CpVPC") 
oTAB:=tbrowsenew(05,50,17,76) 
oTAB:addcolumn(tbcolumnnew(,{|| MT[WROW][2]})) 
oTAB:addcolumn(tbcolumnnew(,{|| tran(MT[WROW][1],"@R 99/99")})) 
oTAB:AUTOLITE:=.f. 
oTAB:GOTOPBLOCK :={|| WROW:=1} 
oTAB:GOBOTTOMBLOCK:={|| WROW:=len(MT)} 
oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,MT,@WROW)} 
oTAB:dehilite() 
whil .t. 
   oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and. ! oTAB:stabilize() 
   end 
   TECLA:=inkey(0) 
   if TECLA==K_ESC   ;exit   ;endif 
   do case 
      case TECLA==K_UP         ;oTAB:up() 
      case TECLA==K_DOWN       ;oTAB:down() 
      case TECLA==K_LEFT       ;oTAB:up() 
      case TECLA==K_RIGHT      ;oTAB:down() 
      case TECLA==K_PGUP       ;oTAB:pageup() 
      case TECLA==K_CTRL_PGUP  ;oTAB:gotop() 
      case TECLA==K_PGDN       ;oTAB:pagedown() 
      case TECLA==K_CTRL_PGDN  ;oTAB:gobottom() 
      case TECLA==K_F2         ;MT[WROW][1]=CORPADRAO[WROW] 
      case TECLA==K_F3 
           for WCT=1 to len(MT) 
               MT[WCT][1]=CORPADRAO[WCT] 
           next 
           oTAB:refreshall() 
           whil ! oTAB:stabilize(); enddo 
      case TECLA==K_ENTER 
           WTELA:=savescreen(05,50,17,76) 
           WCOR:=setcolor() 
           setcursor(1) 
           set(_SET_DELIMITERS,.f.) 
           setcolor("W/N,W+/N+") 
           WCOREDIT:=MT[WROW][1] 
           @ row(),col()+22 get WCOREDIT pict "@R 99/99" valid selecor(@WCOREDIT) when; 
              ajuda("[00/00]Tabela [ENTER]Confirma [ESC]Cancela") 
           read 
           ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [ENTER]Altera [F2]Padrao [F3]CpVPC") 
           MT[WROW][1]:=WCOREDIT 
           setcolor(tran(MT[WROW][1],"@R XX/XX")) 
           @ 20,03 say " *** EXEMPLO *** " 
           setcolor(WCOR) 
           setcursor(0) 
           set(_SET_DELIMITERS,.t.) 
           restscreen(05,50,17,76,WTELA) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTAB:refreshcurrent() 
   oTAB:stabilize() 
end 
COR:={} 
for WCT:=1 to len(MT) 
    aadd(COR,MT[WCT][1]) 
next 
setcursor(1) 
setcolor(XCOR) 
return nil 
 
/* 
Funcao     - VERCOR 
Finalidade - Verificar se a cor digitada e' valida 
Retorno    - .f. ou .f. 
*/ 
stat func vercor(COR_) 
if val(substr(COR_,1,2))>15 .OR. val(substr(COR_,2,2))<0 .OR. ; 
   val(substr(COR_,3,2))>15 .OR. val(substr(COR_,3,2))<0 
   aviso("Atencao, utilize apenas numeros da tabela",10) 
   mensagem("Pressione [ENTER] para continuar ou [ESC] para cancelar...",1) 
   pausa() 
   return(.f.) 
endif 
return(.t.) 
 
 
/* 
* Funcao      - SELECOR 
* Finalidade  - Selecionar a cor apartir de um menu de cores 
* Parametro   - PCOR        => Valor da cor digitada pelo usuario 
* Variaveis   - WLIN        => Coordenada linha da telao 
*             - WCOL        => Coordenada coluna da tela p/ iniciar o menu 
*             - WTECLA      => Verificar a tecla pressionada pelo usuario 
*             - WCFUNDO     => Cor de fundo a ser passada p/ matriz 
*             - WCCHR       => Cor de frente a ser passada p/ matriz 
*             - WCURSOR     => Posicao do cursor no menu de cores 
*             - WCORBASICA  => Cor que sera comparada ao parametro 
*             - WMTCOR      => Matriz contendo todas as cores possiveis 
* Retorno     - (.t./.f.) 
* Programador - VPFlores 
* Data        - 31/Agosto/1994 
*/ 
stat func selecor(PCOR) 
loca WTECLA:=0, WCOR:=1, WLIN:=5, WCOL:=25, WCFUNDO:=WCCHR:=0, WCURSOR:=0 
loca WCORBASICA:="", WMTCOR:={},; 
     XTELA:=savescreen(00,00,24,79), XCURSOR:=setcursor(), XCOR:=setcolor() 
setcursor(0) 
for WCT=0 to 256 
    if WCCHR>15 
       WCCHR=0 
       ++WCFUNDO 
    else 
       ++WCCHR 
    endif 
    if WCFUNDO>15 
       WCFUNDO=0 
    endif 
    WCFUNDO=if(WCT=0,0,WCFUNDO) 
    WCORBASICA=strzero(WCCHR,2,0)+"/"+strzero(WCFUNDO,2,0) 
    if WCORBASICA=tran(PCOR,"@R XX/XX") 
       restscreen(00,00,24,79,XTELA) 
       setcursor(XCURSOR) 
       return(.t.) 
    endif 
    aadd(WMTCOR,WCORBASICA) 
next 
setcursor(0) 
vpbox(WLIN-1,WCOL-1,WLIN+8,WCOL+21,"Cores",,,,COR[16]) 
for WCOR=1 to 8 
    setcolor(WMTCOR[WCOR]) 
    @ WLIN+WCOR-1,WCOL+1 say "   *** "+WMTCOR[WCOR]+" ***   " 
next 
setcolor("W+/N") 
@ WCURSOR+WLIN,WCOL say "" 
@ WCURSOR+WLIN,WCOL+20 say "" 
WCOR:=1 
whil WTECLA<>K_ESC 
   WTECLA=inkey(0) 
   setcolor(WMTCOR[WCOR]) 
   /* Converter as teclas left e right para up e down */ 
   WTECLA=if(WTECLA=K_LEFT,K_UP,WTECLA) 
   WTECLA=if(WTECLA=K_RIGHT,K_DOWN,WTECLA) 
   /* Testar a tecla digitada */ 
   do case 
      case WTECLA=K_DOWN .AND. WCOR<254 
           ++WCOR 
           if WCURSOR>6 
              scroll(WLIN,WCOL+1,WLIN+7,WCOL+19,1) 
              @ WLIN+7,WCOL+1 say "   *** "+WMTCOR[WCOR]+" ***   " 
           elseif WCURSOR<7 
              setcolor("W+/N") 
              @ WCURSOR+WLIN,WCOL say " " 
              @ WCURSOR+WLIN,WCOL+20 say " " 
              @ ++WCURSOR+WLIN,WCOL say "" 
              @ WCURSOR+WLIN,WCOL+20 say "" 
           endif 
      case WTECLA=K_UP .AND. WCOR>1  // >0 
           --WCOR 
           if WCURSOR <1 
              scroll(WLIN,WCOL+1,WLIN+7,WCOL+19,-1) 
              @ WLIN,WCOL+1 say "   *** "+WMTCOR[WCOR]+" ***   " 
           elseif WCURSOR >=1 
              setcolor("W+/N") 
              @ WCURSOR+WLIN,WCOL say " " 
              @ WCURSOR+WLIN,WCOL+20 say " " 
              @ --WCURSOR+WLIN,WCOL say "" 
              @ WCURSOR+WLIN,WCOL+20 say "" 
           endif 
      case WTECLA=K_ENTER 
           PCOR:=strtran(WMTCOR[WCOR],"/","") 
           restscreen(00,00,24,79,XTELA) 
           setcursor(XCURSOR) 
           setcolor(XCOR) 
           return(.t.) 
   endcase 
enddo 
restscreen(00,00,24,79,XTELA) 
setcursor(XCURSOR) 
setcolor(XCOR) 
return(.f.) 
 
 
Function SetConfig() 
if ! file(_VPD_CONFIG) 
   do CECONFIG 
endif 
Sele 99 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Use _VPD_CONFIG Alias CFG Shared 
_EMP:=" "+alltrim(unzipchr(DESCRI))+" " 
_END:=unzipchr(LINE01) 
_END1:=unzipchr(LINE02) 
SDIR:=alltrim(unzipchr(SDIR__)) 
GDIR:=alltrim(unzipchr(GDIR__)) 
CD:=CDRIVE 
_COMSENHA:=substr(PARASN,1,1) 
_COMDATA:=substr(PARASN,2,1) 
_COMSOMBRA:=substr(PARASN,3,1) 
_COMSOM:=substr(PARASN,4,1) 
_COMZOOM:=substr(PARASN,5,1) 
_MARGEM:=MARGEM 
COR={} 
for WCT:=1 to len(CORESV) 
    aadd( COR,tran( restbyte(substr(CORESV,WCT,2)),"@R XX/XX" ) ) 
    ++WCT 
next 
DBCloseArea() 
//FechaArea() 
return(.t.) 
 
 
 
 
 



