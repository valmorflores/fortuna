// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH" 
/* 
* 
*      Modulo - VPC21110 
*  Finalidade - Controlar o cadastro de MATERIA PRIMA 
* Programador - Valmor Pereira Flores 
*        Data - 10/Novembro/1994 
* Atualizacao - 14/Novembro/1994 
* 
*/ 
func mprinclusao() 
 
  //* VARIAVEIS REFERENTES AO MODULO ANTERIOR *// 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor(),; 
       nROW:=1 
 
  //* VARIAVEIS REFERENTES AO BANCO DE DADOS *// 
  loca cORIGEM:=spac(3)                   && Origem 
  loca cUNIDAD:=spac(2)                   && Unidade 
  loca nQTDPES:=0                         && Quantidade (Peso p/ unidade) 
  loca nESTMIN:=0                         && Estoque minimo 
  loca nESTMAX:=0                         && Estoque maximo 
  loca nPRECOV:=0                         && Preco 
  loca nCODTRI:=0                         && Codigo tributo 
  loca nCLAFIS:=0                         && Classificacao fiscal 
  loca nCLASV_:=0                         && Classificacao de venda 
  loca cFORNEC:="S"                       && Conf. de uso p/ PRECOS x FORN. 
  loca cINDICE:=""                        && Codigo p/ organizacao 
  loca nFLAG:=0 
  loca cTELAR, cCORR 
 
  //* PRECOSxFORNECEDOR *// 
  loca oTAB                               && Objeto tbrowse. 
  loca aPRECOS:={}                        && {Cod.Fornec,Nome,Preco}. 
  loca cSTRING                            && Var. utilizada no browse precos. 
  loca nTECLA                             && Var. contr. teclado no GET. 
  loca TECLA                              && Var. contr. teclado no BROWSE. 
  loca xCOR, nCT 
 
  //* VARIAVEIS PARA MODULO DE CONFIGURACAO *// 
  loca cVARIAVEL, cMASCAR, nQUANT_, nDECIM_, nQUEST_, cVERIF_,; 
       dDATA__, cHORA__, nUSUAR_, cQUEST_ 
 
  //* VARIAVEIS P/ TRATAMENTO DO CODIGO DE PRODUTO *// 
  loca _cMRESER                           && Reserva p/ mascara. 
  priv _PIGRUPO                           && Posicao inicial de grupo 
  priv _QTGRUPO                           && Quantidade de caracteres grupo 
  priv _PICODIG                           && Posicao inicial de codigo 
  priv _QTCODIG                           && Quantidade de caracteres codigo 
 
  //* VARIAVEIS GERAL (PRIVADAS) *// 
  priv cCODIGO:=spac(12)                  && Codigo do produto. 
  priv cDESCRI:=spac(40)                  && Descricao do produto. 
  priv nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
 
  priv aTELA1                             && Var c/a tela limpa p/ PESQUISADBF. 
 
  //* MASCARA C/ INFORMACOES P/ APRESENTACAO DE PRODUTO *// 
  priv bMASCARA:="'  '+tran(CODIGO,'@R '+cxMASCACOD)+'  '+DESCRI+spac(20)" 
 
  priv cxORIGEM                           && Var. c/conf. da utiliz. de origens 
  priv cxMASCACOD                         && Mascara p/ codigo. 
  priv cxMASCQUAN                         && Mascara p/ quantidade. 
  priv cxMASCPREC                         && Mascara p/ valores. 
 
  //* ATRIBUI TECLA (K_TAB) PARA PESQUISA *// 
  set key K_TAB to pesquisadbf() 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen(); usermodulo(" Cadastro de Materia Prima ") 
 
  //* VERIFICANDO A EXISTENCIA DO ARQUIVO DE MASCARAS *// 
  if !file(_VPB_CONFIG) 
     mensagem("ATENCAO! Arquivo de mascaras nao encontrado. Utilize modulo (142M).",1) 
     Pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !fdbusevpb(_COD_CONFIG,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
         alltrim(_VPB_CONFIG)+".",24/2) 
     mensagem("Erro na abertura do arq. de configuracao, tente novamente.") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  ** Captacao dos valores configurados **************************************** 
 
  //* MASCARA P/ CODIGO DO PRODUTO *// 
  locate for VARIAV="cMASCACOD" 
  cMASCACOD:=MASCAR 
  cVERIF_:=VERIF_ 
  //* MASCARA P/ QUANTIDADE *// 
  locate for VARIAV="cMASCQUAN" 
  cMASCQUAN:=MASCAR 
  //* MASCARA P/ VALORES (PRECOS) *// 
  locate for VARIAV="cMASCPREC" 
  cMASCPREC:=MASCAR 
  //* UTILIZAR ORIGEM? *// 
  locate for VARIAV="cORIGEM" 
  cxORIGEM:=QUEST_ 
  //* FAZER ASSOCIACAO DE (QUANTIDADE POR PECA & ESTOQUE)? *// 
  locate for VARIAV="cASSOCIAR" 
  cASSOCIAR:=QUEST_ 
 
  ** Abertura dos banco de dados ********************************************** 
 
  //* ABERTURA DO ARQUIVO DE ORIGENS *// 
  if cxORIGEM="S"                         && Se utilizar arquivo de origens! 
     if !file(_VPB_ORIGEM) 
        mensagem("Arq. de origens nao encontrado, press ENTER para continuar.") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     endif 
     if !fdbusevpb(_COD_ORIGEM,2) 
        aviso("ATENCAO! Verifique o arquivo "+; 
          alltrim(_VPB_ORIGEM)+".",24/2) 
        mensagem("Erro na abertura do arquivo de origens, tente novamente...") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     endif 
  endif 
 
  //* ABERTURA DO ARQUIVO DE FORNECEDORES *// 
  if !file(_VPB_FORNECEDOR) 
     mensagem("Arquivo de fornecedores nao encontrado,"+; 
              " pressione ENTER para continuar...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !fdbusevpb(_COD_FORNECEDOR,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de fornecedores, tente novamente...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  //* ABERTURA DO ARQUIVO DE PRECOS X FORNECEDORES *// 
  if !file(_VPB_PRECOXFORN) 
     mensagem("Criando arquivo de precos x fornecedores, aguarde...") 
     createvpb(_COD_PRECOXFORN) 
  endif 
  if !fdbusevpb(_COD_PRECOXFORN,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de precos x fornecedores...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  //* ABERTURA DO ARQUIVO DE MATERIA PRIMA *// 
  if ! file(_VPB_MPRIMA) 
     createvpb(_COD_MPRIMA) 
  endif 
  if !fdbusevpb(_COD_MPRIMA) 
     aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_MPRIMA)+".",24/2) 
     mensagem("Erro na abertura do arq. de MATERIA PRIMA, tente novamente...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  //* FORMATACAO DA TELA *// 
  setcolor(COR[16]) 
  scroll(01,01,24-2,78) 
  aTELA1:=boxsave(01,01,14,78) 
  aTELA:=boxsave(01,01,24-2,79-1) 
  setcolor(COR[21]) 
  dispbox(01,01,14,79-1,2) 
  @ 14,02 say " Arquivo " 
  ajuda("["+_SETAS+"][PgDn][PgUp]Move "+; 
        "[TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
 
  _cMRESER:=strtran(cMASCACOD,".","") 
  _cMRESER:=strtran(_cMRESER,"-","") 
  _cMRESER:=alltrim(_cMRESER) 
 
  _PIGRUPO:=at("G",_cMRESER) 
  _QTGRUPO:=StrVezes("G",_cMRESER) 
  _PICODIG:=at("N",_cMRESER) 
  _QTCODIG:=StrVezes("N",_cMRESER) 
 
  whil .T. 
     dbselectar(_COD_MPRIMA) 
 
     //* MONTAGEM DAS VARIAVEIS (MASCARAS) *// 
     cxMASCACOD:=mascstr(cMASCACOD,1) 
     cxMASCQUAN:=mascstr(cMASCQUAN,2) 
     cxMASCPREC:=mascstr(cMASCPREC,2) 
     cCODIGO:=strtran(cxMASCACOD,".","") 
     cCODIGO:=strtran(cCODIGO,"-","") 
     cCODIGO:=alltrim(cCODIGO) 
     cCODIGO:=strtran(cCODIGO,"9"," ") 
 
     exibedbf() 
 
     setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
 
     if len(cCODIGO)<1 
        mensagem("Erro na configuracao de mascaras! Verif. modulo (143M).",1) 
        pausa() 
        exit 
     endif 
     @ 02,03 say "Codigo..............:" get cCODIGO pict "@R "+cxMASCACOD ; 
       valid digitover(@cCODIGO,cMASCACOD) when; 
       mensagem("Digite o codigo para produto.") 
     @ 03,03 say "Descricao...........:" get cDESCRI pict "@!" when; 
       mensagem("Digite a descricao do produto.") 
     @ 04,03 say "Origem/Fabricante...:" 
     if cxORIGEM="S" 
        @ 04,25 get cORIGEM valid oseleciona(@cORIGEM) when; 
          mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
     endif 
     @ 05,03 say "Unidade de Medida...:" get cUNIDAD when; 
       mensagem("Digite a unidade de medida do produto.") 
     @ 06,03 say "Medida Unitaria.....:" 
     if cASSOCIAR="S" 
        @ 06,25 get nQTDPES pict "@E "+cxMASCQUAN when; 
          mensagem("Digite a peso, tamanho ou quantidade unitaria do produto.") 
     endif 
     @ 07,03 say "Preco venda.........:" get nPRECOV pict "@E "+cxMASCPREC when; 
       mensagem("Digite o preco de venda do produto.") 
     @ 08,03 say "Cod. Tributavel.....:" get nCODTRI pict "9" when; 
       mensagem("Digite o codigo tributavel do produto.") 
     @ 09,03 say "Classificacao fiscal:" get nCLAFIS pict "9" when; 
       mensagem("Digite o codigo de classificacao fiscal do produto.") 
     @ 10,03 say "Classif.de vendas...:" get nCLASV_ pict "9" ; 
       valid classvenda(@nCLASV_) when; 
       mensagem("Digite o codigo de clas. para venda ou [0] p/ ver lista.") 
     @ 11,03 say "Estoque minimo......:" get nESTMIN pict "@E "+cxMASCQUAN when; 
       mensagem("Digite a quantidade permitida para estoque minimo.") 
     @ 12,03 say "Estoque maximo......:" get nESTMAX pict "@E "+cxMASCQUAN when; 
       mensagem("Digite a quantidade valida para estoque maximo.") 
     @ 13,03 say "Preco x Fornecedor..:" get cFORNEC pict "!" ; 
       valid cFORNEC$"SN" when; 
       mensagem("Digite [S] p/incluir (precos x fornec.) ou [N] p/ cancelar.") 
     read 
     if lastkey()=K_ESC 
        exit 
     endif 
 
     if cFORNEC="S" 
        //* PRECOS POR FORNECEDOR *// 
        dbselectar(_COD_FORNECEDOR) 
        dbgotop() 
        whil ! eof() .AND. nFLAG==0 
            aadd(aPRECOS,{CODIGO,DESCRI,0.00}) 
            dbskip() 
        enddo 
        nFLAG:=1 
        //* SALVAR STATUS ANTERIOR *// 
        cCORR:=setcolor() 
        cTELAR:=screensave(00,00,24,79) 
        //* FORMATAR TELA *// 
        setcolor(COR[21]+","+COR[22]) 
        setcursor(0) 
        mensagem("Pressione ENTER para alterar ou ESC para retornar.") 
        vpbox(03,06,24-8,60+len(cxMASCPREC),"PRECOS na memoria",COR[20],.T.,.T.,COR[19]) 
        //* EXIBIR DADOS *// 
        oTAB:=tbrowsenew(04,07,24-9,59+len(cxMASCPREC)) 
        oTAB:addcolumn(tbcolumnnew(,{|| aPRECOS[nROW][1]})) 
        oTAB:addcolumn(tbcolumnnew(,{|| aPRECOS[nROW][2]})) 
        oTAB:addcolumn(tbcolumnnew(,{|| tran(aPRECOS[nROW][3],"@E "+cxMASCPREC)})) 
        oTAB:AUTOLITE:=.f. 
        oTAB:GOTOPBLOCK:={|| nROW:=1} 
        oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aPRECOS)} 
        oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aPRECOS,@nROW)} 
        oTAB:dehilite() 
        whil .t. 
           oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,oTAB:COLCOUNT},{2,1}) 
           whil nextkey()==0 .and. ! oTAB:stabilize() 
           enddo 
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
              case TECLA==K_ENTER .OR. TECLA==K_TAB 
                   set(_SET_DELIMITERS,.F.) 
                   xCOR:=setcolor() 
                   setcolor(COR[20]+","+COR[17]) 
                   @ oTAB:ROWPOS+3,59 get aPRECOS[nROW][3]; 
                                      pict "@E "+cxMASCPREC 
                   read 
                   setcolor(xCOR) 
                   oTAB:down() 
                   set(_SET_DELIMITERS,.T.) 
              case chr(TECLA)$"1234567890" 
                   setcolor(COR[17]) 
                   cSTRING:=chr(TECLA) 
                   @ oTAB:ROWPOS+3,59 say cSTRING+; 
                          spac(len(cxMASCPREC)-len(cSTRING)) 
                   for nCT:=1 to len(cxMASCPREC) 
                       nTECLA:=inkey(0) 
                       if nTECLA=K_BS 
                          cSTRING:=substr(cSTRING,1,len(cSTRING)-1) 
                       endif 
                       if chr(nTECLA)$"1234567890." 
                          cSTRING:=cSTRING+chr(nTECLA) 
                       else 
                          --nCT 
                       endif 
                       @ oTAB:ROWPOS+3,59 say cSTRING+; 
                              spac(len(cxMASCPREC)-len(cSTRING)) 
                       if nTECLA=K_ENTER 
                          exit 
                       endif 
                   next 
                   aPRECOS[nROW][3]:=val(cSTRING) 
                   oTAB:down() 
              otherwise                ;tone(125); tone(300) 
           endcase 
           oTAB:refreshcurrent()	 
           oTAB:stabilize() 
        enddo 
        setcursor(1) 
        screenrest(cTELAR) 
        setcolor(cCORR) 
     endif 
 
     dbselectar(_COD_MPRIMA) 
 
     if confirma(14,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento do produto.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        if buscanet(5,{|| dbappend(), !neterr()}) 
 
           ** gravacao dos dados no arquivo de produtos *********************** 
 
           cINDICE:=substr(cCODIGO,_PIGRUPO,_QTGRUPO)+; 
                    substr(cCODIGO,_PICODIG,_QTCODIG) 
 
           repl CODIGO with cCODIGO, DESCRI with cDESCRI, INDICE with cINDICE,; 
                MPRIMA with "S", UNIDAD with cUNIDAD,; 
                QTDPES with nQTDPES, ESTMIN with nESTMIN, ESTMAX with nESTMAX,; 
                PRECOV with nPRECOV, CODTRI with nCODTRI, CLAFIS with nCLAFIS,; 
                CLASV_ with nCLASV_, ORIGEM with cORIGEM, ASSOC_ with cASSOCIAR 
 
           dbselectar(_COD_PRECOXFORN) 
           for nCT:=1 to len(aPRECOS) 
              if aPRECOS[nCT][3]<>0 
                 if buscanet(5,{|| dbappend(), !neterr()}) 
                    repl CPROD_ with cINDICE, CODFOR with aPRECOS[nCT][1],; 
                         VALOR_ with aPRECOS[nCT][3] 
                 endif 
              endif 
           next 
           setcolor(COR[21]) 
           dispbox(14,58,14,77,2)            && Refaz parte detonada p/confirma 
 
           //* LIMPEZA DAS VARIAVEIS *// 
           cORIGEM=spac(3) 
           cUNIDAD=spac(2) 
           nQTDPES=0 
           nESTMIN=0 
           nESTMAX=0 
           nPRECOV=0 
           nCODTRI=0 
           nCLAFIS=0 
           nCLASV_=0 
           cFORNEC="S" 
           cINDICE="" 
           nFLAG=0 
        endif 
     endif 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  screenrest(cTELA) 
  setcursor(nCURSOR) 
  setcolor(cCOR) 
  set key K_TAB to 
return nil 
 
/* 
* 
*      Funcao - EXIBESTRU 
*  Finalidade - Exibir os dados do arquivo 
* Programador - ValmorPF 
*        Data - 12/Novembro/1994 
* Atualizacao - 
* 
*/ 
stat func exibestru() 
  @ 02,03 say "Codigo..............:" 
  @ 03,03 say "Descricao...........:" 
  @ 04,03 say "Origem/Fabricante...:" 
  @ 05,03 say "Unidade de Medida...:" 
  @ 06,03 say "Medida Unitaria.....:" 
  @ 07,03 say "Preco venda.........:" 
  @ 08,03 say "Cod. Tributavel.....:" 
  @ 09,03 say "Classificacao fiscal:" 
  @ 10,03 say "Classif.de vendas...:" 
  @ 11,03 say "Estoque minimo......:" 
  @ 12,03 say "Estoque maximo......:" 
  @ 13,03 say "Preco x Fornecedor..:" 
return .T. 
 
/* 
* 
*      Funcao - MASCSTR = Extrai mascara 
*  Finalidade - Esta funcao retorna uma string  contendo  uma  mascara 
*               a ser usada para os GETs no caso de digitos referentes 
*               a produtos, como codigo, preco, quantidade etc. 
*  Parametros - VDM=>Veriavel contendo string a retornar a sua mascara. 
*     Retorno - MASCARA=>String 
* Programador - ValmorPF 
*        Data - 14/Novembro/1994 
* Atualizacao - 15/Novembro/1994 
* 
*/ 
func mascstr(VDM,nCOD) 
  loca nCT, cSTRING:="" 
  if nCOD=1 
     VDM:=strtran(VDM,"G","9") 
     VDM:=strtran(VDM,"V","9") 
     VDM:=strtran(VDM,"N","9") 
  elseif nCOD=2 
     for nCT:=1 to len(VDM) 
         cCHR:=substr(VDM,nCT,1) 
         if cCHR="." 
            cCHR="," 
         elseif cCHR="," 
            cCHR="." 
         endif 
         cSTRING:=cSTRING+cCHR 
     next 
     VDM:=cSTRING 
  endif 
return(alltrim(VDM)) 
 
/* 
* 
*      Funcao - DIGITOVER 
*  Finalidade - Esta funcao retorna a string passada como parametro, 
*               acrescentando na mesma um digito a mais (VERIF) 
*  Parametros - VDM=>Veriavel contendo string a retornar com dig. verif. 
*     Retorno - STRING=>Conteudo: STRING+DIGITO_VERIFICADOR 
* Programador - ValmorPF 
*        Data - 14/Novembro/1994 
* Atualizacao - 15/Novembro/1994 
* 
*/ 
func digitover(VDM,MASCARA) 
  loca cTELA:=screensave(00,00,24,79) 
  loca cCHR, nCTPRI 
  loca aDIGITOS:={".-NV",".-GV"}          && Dig. a serem excluidos da var. 
  loca cSTRING:=""                        && Var. c/ digitos da string MASCARA. 
  loca nPOSICAO                           && Aux. de verificacao de posicao. 
  loca cVERIFICADOR:=""                   && Var. p/ armazenar o digito verif. 
  loca nVERIFICADOR:=0                    && Complemento ao verificador. 
  loca cCODIG:=cGRUPO:=""                 && Var. c/ tamanho de cod. e grupo. 
  loca nCODIG:=nGRUPO:=0                  && Var. c/ valores de cod. e grupo. 
  loca D:={}                              && Aux. no calculo. 
  loca cINDICE                            && Indice de tratamento (Index). 
 
  if at("V",MASCARA)=0                    && Ret. .T. se usuario nao usa 
     return(.T.)                          && digito verificador no codigo. 
  endif 
 
  //* PESQUISA PARA LOCALIZAR ESPACOS EM BRANCO NA DIGITACAO *// 
  for nCT:=1 to len(VDM) 
      if substr(VDM,nCT,1)=" " .AND. nCT<len(VDM)-1 
         mensagem("Atencao este dado devera ser completo.",1) 
         pausa() 
         screenrest(cTELA) 
         return(.F.) 
      endif 
  next 
 
  cINDICE:=substr(VDM,_PIGRUPO,_QTGRUPO)+; 
           substr(VDM,_PICODIG,_QTCODIG)  && 
                                          && Retorna a String de pesquisa. 
  cINDICE:=cINDICE+space(12-len(cINDICE)) && 
 
  dbsetorder(1) 
  if dbseek(cINDICE) 
     mensagem("Atencao, ja existe produto com este numero.",1) 
     pausa() 
     screenrest(cTELA) 
     return(.F.) 
  endif 
 
  VDM:=substr(VDM,1,len(VDM)-1)           && Livra var. VDM do ultimo digito. 
 
  //* PESQUISA PARA ENCONTRAR O NUMERO DO GRUPO e DO CODIGO *// 
  for nCTPRI:=1 to 2 
      cSTRING:="" 
      for nCT:=1 to len(MASCARA) 
          cCHR:=substr(MASCARA,nCT,1) 
          if cCHR$aDIGITOS[nCTPRI] 
             cCHR="" 
          endif 
          cSTRING:=cSTRING+cCHR 
      next 
      if nCTPRI=1 
         cGRUPO:=cSTRING 
      else 
         cCODIG:=cSTRING 
      endif 
  next 
 
  //* LOCALIZA O GRUPO NA STRING (VDM) *// 
  nPOSICAO:=at("G",MASCARA) 
  cGRUPO:=substr(VDM,nPOSICAO,nPOSICAO+len(alltrim(cGRUPO))-1) 
 
  //* LOCALIZA O CODIGO NA STRING (VDM) *// 
  nPOSICAO:=at("N",MASCARA) 
  cCODIG:=substr(VDM,nPOSICAO-1,nPOSICAO+len(alltrim(cCODIG))-1) 
 
  //* CALCULO P/ RETORNAR O DIGITO VERIFICADOR *// 
  for nCT=1 to len(cCODIG) 
      aadd(D,val(subs(cCODIG,nCT,1))) 
      nVERIFICADOR+=(nCT+D[nCT]) 
  next 
  nVERIFICADOR+=val(cGRUPO)               && Soma digito verificador+grupo. 
  cVERIFICADOR:=right(strzero(nVERIFICADOR,20,00),1) 
 
  //* PREPARA VDM PARA RETORNO *// 
  VDM:=alltrim(VDM+cVERIFICADOR) 
 
  //* APRESENTACAO DAS INFORMACOES SOBRE O CODIGO DO PRODUTO *// 
  vpbox(05,44,10,75,"Informacoes",COR[20],.T.,.F.,COR[20]) 
  setcolor(COR[20]) 
  @ 06,45 say "Codigo Principal > "+alltrim(VDM) 
  @ 07,45 say "Grupo ===========> "+cGRUPO 
  @ 08,45 say "Numero ==========> "+cCODIG 
  @ 09,45 say "Digito Verif. ===> "+cVERIFICADOR 
return(.T.) 
 
/* 
* 
*      Modulo - MPRMOSTRA 
*  Finalidade - Exibir os dados do arquivo de materia prima 
* Programador - VALMOR PEREIRA FLORES 
*  Parametros - Nenhum 
*     Retorno - Nenhum 
*        Data - 
* Atualizacao - 
* 
*/ 
func mprmostra() 
loca cCOR:=setcolor() 
  setcolor(COR[10]) 
  @ 02,26 say CODIGO pict "@R "+cxMASCACOD 
  @ 03,26 say DESCRI pict "@!" 
  @ 04,26 say ORIGEM 
  @ 05,26 say UNIDAD 
  @ 06,26 say QTDPES pict "@E "+cxMASCQUAN 
  @ 07,26 say PRECOV pict "@E "+cxMASCPREC 
  @ 08,26 say CODTRI pict "9" 
  @ 09,26 say CLAFIS pict "9" 
  @ 10,26 say CLASV_ pict "9" 
  @ 11,26 say ESTMIN pict "@E "+cxMASCQUAN 
  @ 12,26 say ESTMAX pict "@E "+cxMASCQUAN 
  @ 13,26 say "*" 
  setcolor(cCOR) 
return(.t.) 
 
/**************************************************************************** 
| 
| OBSERVAR: Esta funcao tem a mesma finalidade da funcao EXIBEDBF(), que 
|           se encontra na biblioteca VPBIBCEI, mas, possui alteracoes 
|           exclusivas para o modulo de PRODUTOS. 
| 
**************************************[*]*/ 
 
/* 
* 
*      Funcao - EXIBEDBF 
*  Finalidade - Executar a exibicao dos dados do arquivo 
* Programador - Valmor Pereira Flores 
*        Data - 20/Outubro/1994 
* Atualizacao - 
* 
*/ 
stat func exibedbf() 
loca nLIN:=14, nREGISTROS 
loca cCOR:=setcolor(), nCOL:=2, nCT 
nREGISTROS:=24-(nLIN+4) 
if cCODIGO="            " 
   dbgotop() 
else 
   dbgotop() 
   if nORDEMG=1 
      locate for alltrim(CODIGO)=cCODIGO 
   elseif nORDEMG=2 
      locate for DESCRI=cDESCRI 
   endif 
endif 
dbskip(-nREGISTROS) 
setcolor(COR[21]) 
scroll(nLIN+1,nCOL,24-2,79-2) 
for nCT:=0 to nREGISTROS 
    if nORDEMG=1 
       setcolor(if(alltrim(CODIGO)=cCODIGO,COR[22],COR[21])) 
    elseif nORDEMG=2 
       setcolor(if(DESCRI=cDESCRI,COR[22],COR[21])) 
    endif 
    @ ++nLIN,nCOL say &bMASCARA 
    dbskip(+1) 
    if eof() 
       exit 
    endif 
next 
setcolor(cCOR) 
return(.t.) 
 
/* 
* 
*      Funcao - PESQUISADBF 
*  Finalidade - Executar a rolagem dentro do arquivo de clientes 
* Programador - Valmor Pereira Flores 
*        Data - 
* Atualizacao - 
* 
*/ 
stat func pesquisadbf(nPMOD) 
  loca nCURSOR:=setcursor(), cCOR:=setcolor(), oTB,; 
       cTELA:=screensave(24-1,00,24,79) 
  loca nLIN:=14,; 
       nREGISTROS:=smPG[2],; 
       aMODULOS:={smPG[3],smPG[4]},; 
       MODCHAMA:=smPG[5],; 
       MODMOSTRA:=smPG[6],; 
       cMASCARA:=smPG[7] 
  loca aTELA 
  dbselectar(_COD_MPRIMA) 
  if alltrim(cCODIGO)="" 
     dbgotop() 
  else 
     if nORDEMG=1 
        locate for alltrim(CODIGO)=cCODIGO 
        dbskip(-nREGISTROS) 
     elseif nORDEMG=2 
        locate for DESCRI=cDESCRI 
     endif 
  endif 
  aTELA:=boxsave(01,01,24-2,79-1) 
  setcursor(0) 
  setcolor(COR[21]+","+COR[22]+",,,"+COR[17]) 
  boxrest(aTELA1) 
  dispbox(nLIN,01,24-2,79-1,2) 
  if valtype(nPMOD)=="C" 
     nPMOD=if(nPMOD=aMODULOS[1] .OR. nPMOD=aMODULOS[2],1,nPMOD) 
  endif 
  mensagem(if(nPMOD=1,"Pressione [TAB] para efetuar alteracoes.",; 
                      "Pressione [TAB] para excluir.")) 
  ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
        "[F2]Pesquisa [F3]Codigo [F4]Nome [TAB]Executa") 
  oTB:=tbrowsedb(nLIN+1,02,24-3,79-2) 
  oTB:addcolumn(tbcolumnnew(,{|| &bMASCARA })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  whil .t. 
     oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
     whil nextkey()=0 .and.! oTB:stabilize() 
     enddo 
     mprmostra() 
     cCODIGO=alltrim(CODIGO) 
     TECLA:=inkey(0) 
     nPMOD:=if(nPMOD=NIL,1,nPMOD) 
     if valtype(nPMOD)=="C" 
        nPMOD=if(nPMOD=aMODULOS[1] .OR. nPMOD=aMODULOS[2],1,nPMOD) 
     endif 
     if TECLA=K_ESC 
        exit 
     endif 
     do case 
        case TECLA==K_UP         ;oTB:up() 
        case TECLA==K_LEFT       ;oTB:up() 
        case TECLA==K_RIGHT      ;oTB:down() 
        case TECLA==K_DOWN       ;oTB:down() 
        case TECLA==K_PGUP       ;oTB:pageup() 
        case TECLA==K_PGDN       ;oTB:pagedown() 
        case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
        case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
        case TECLA==K_F2         ;pesquisa(oTB) 
        case TECLA==K_F3         ;organiza(oTB,1) 
        case TECLA==K_F4         ;organiza(oTB,2) 
        case TECLA==K_TAB 
             if nPMOD=1 
                screenrest(cTELA) 
                if(lastrec()>0 .AND. CODIGO<>spac(12),mpraltera(),nil) 
             elseif nPMOD==2 
                if(lastrec()>0 .AND. CODIGO<>0,exclui(oTB),nil) 
             endif 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTB:refreshcurrent() 
     oTB:stabilize() 
  enddo 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  boxrest(aTELA) 
  screenrest(cTELA) 
return nil 
 
/* 
* 
*      Modulo - PESQUISA 
*  Parametros - Elemento objeto 
*  Finalidade - Pesquisa p/ codigo ou descricao. 
* Programador - Valmor Pereira Flores 
*        Data - 15/Junho/1993 
* Atualizacao - 30/Novembro/1994 
* 
*/ 
stat func pesquisa(oPOBJ) 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nOPCAO:=0, cCOD, cDESC:=space(45), GETLIST:={} 
  ajuda("[ESC]Finaliza") 
  mensagem("Selecione sua opcao conforme o menu acima.") 
  if lastrec()=0 
     mensagem("Cadastro vazio, [ENTER] para continuar.") 
     pausa() 
     return NIL 
  endif 
  set key K_TAB to 
  setcursor(1) 
  set(_SET_SOFTSEEK,.t.) 
  mensagem("") 
  ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
  vpbox(12,45,16,69," Pesquisa ",COR[20],.T.,.F.,COR[19]) 
  setcolor(COR[21]+","+COR[22]) 
  aadd(MENULIST,; 
  menunew(13,46,smBUSCA[1][1],2,COR[19],smBUSCA[1][2],,,COR[6],.T.)) 
  aadd(MENULIST,; 
  menunew(14,46,smBUSCA[2][1],2,COR[19],smBUSCA[2][2],,,COR[6],.T.)) 
  aadd(MENULIST,; 
  menunew(15,46," 0 Encerramento       ",2,COR[19],; 
     "Executa a finalizacao da rotina de pesquisa.",,,COR[6],.T.)) 
  menumodal(MENULIST,@nOPCAO); MENULIST:={} 
  ajuda("["+_SETAS+"]Movimenta [ENTER]Confirma [ESC]Cancela") 
  oPOBJ:gotop() 
  do case 
     case nOPCAO=1 
          cCOD:=strtran(cxMASCACOD,".","") 
          cCOD:=strtran(cCOD,"-","") 
          cCOD:=alltrim(cCOD) 
          cCOD:=strtran(cCOD,"9"," ") 
          vpbox(11,25,13,48,"",COR[20],.T.,.F.,COR[19]) 
          @ 12,26 say "C¢digo " get cCOD pict "@R "+cxMASCACOD when; 
            mensagem("Digite o c¢digo para pesquisa.") 
          read 
          mensagem("Executando a pesquisa pelo codigo, aguarde...") 
          cINDICE:=substr(cCOD,_PIGRUPO,_QTGRUPO)+; 
                   substr(cCOD,_PICODIG,_QTCODIG) 
          cINDICE:=cINDICE+space(12-len(cINDICE)) 
          dbsetorder(1) 
          dbseek(cINDICE) 
     case nOPCAO=2 
          vpbox(11,16,13,63,"",COR[20],.T.,.F.,COR[19]) 
          @ 12,17 say "Nome " get cDESC pict "@S35" when; 
            mensagem("Digite o nome para pesquisa.") 
          read 
          mensagem("Executando a pesquisa pela descricao, aguarde...") 
          dbsetorder(2) 
          dbseek(upper(cDESC)) 
     otherwise 
  endcase 
  set(_SET_SOFTSEEK,.f.) 
  dbsetorder(nORDEMG) 
  setcursor(0) 
  setcolor(cCOR) 
  screenrest(cTELA) 
  oPOBJ:refreshall() 
  whil ! oPOBJ:stabilize() 
  enddo 
  set key K_TAB to pesquisadbf() 
return nil 
