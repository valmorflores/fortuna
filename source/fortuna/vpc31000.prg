// ## CL2HB.EXE - Converted
/* 
* Modulo      - VPC41000 
* Finalidade  - Cadastro de fornecedores 
* Programador - Valmor Pereira Flores 
* Data        - 20/Outubro/1994 
* Atualizacao - 
*/ 
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH" 

#ifdef HARBOUR
function vpc31000()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
  DBSelectAr( _COD_FORNECEDOR ) 
 
  SetColor( _COR_BROWSE ) 
  VPBox( 00, 00, 14, 79, " FORNECEDORES ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  VPBox( 15, 00, 22, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  SetCursor( 0 ) 
  DBLeOrdem() 
  Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui [TAB]Etiqueta" ) 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3/F4]Ordem [ESC]Retorna") 
  ForExibStr() 
  oTab:=tbrowsedb(16,01, 24-3, 79-1) 
  oTab:addcolumn(tbcolumnnew(,{|| "  " + StrZero(CODIGO,4,0)+" => "+; 
                                         DESCRI+"  "+Space( 30 ) })) 
  oTab:AUTOLITE:=.f. 
  oTab:dehilite() 
  WHILE .T. 
     oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
     WHILE nextkey()=0 .and.! oTab:stabilize() 
     ENDDO 
     ForMostra() 
     nTecla:=inkey(0) 
     if nTecla=K_ESC 
        exit 
     endif 
     do case 
        case nTecla==K_UP         ;oTab:up() 
        case nTecla==K_LEFT       ;oTab:up() 
        case nTecla==K_RIGHT      ;oTab:down() 
        case nTecla==K_DOWN       ;oTab:down() 
        case nTecla==K_PGUP       ;oTab:pageup() 
        case nTecla==K_PGDN       ;oTab:pagedown() 
        case nTecla==K_HOME       ;oTab:gotop() 
        case nTecla==K_END        ;oTab:gobottom() 
        case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
        case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
        case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
        case nTecla==K_TAB 
             IF SWAlerta( "<< ETIQUETA >>;Confirma impressao da etiqueta?", {"Imprimir", "Cancelar"} )==1 
                Relatorio( "FORMALA.REP" ) 
             ENDIF 
        case DBPesquisa( nTecla, oTab ) 
        case nTecla==K_INS 
             forInclusao( oTab ) 
        case nTecla==K_DEL 
             Exclui( oTab ) 
             oTab:RefreshAll() 
             WHILE !oTab:Stabilize() 
             ENDDO 
        case nTecla==K_ENTER 
             forAlteracao( oTab ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab:refreshcurrent() 
     oTab:stabilize() 
  enddo 
  dbunlockall() 
  SetCursor( nCursor ) 
  SetColor( cCor ) 
  ScreenRest( cTela ) 
Return Nil 
 
func forinclusao( oTb ) 
** variaveis ref. ao modulo anterior ** 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
** variaveis ref. ao cadastro de fornecedores ** 
loca cENDERE:=spac(35), cBAIRRO:=spac(25),; 
     cCIDADE:=spac(30), cESTADO:=spac(2), cCODCEP:=spac(8), cTELEX_:=cFAX___:=spac(12),; 
     cCGCMF_:=spac(14), cINSCRI:=spac(12), cVENDED:=cRESPON:=spac(40),; 
     cSELECT:="Nao", cANTPOS:=" ", cPais:=spac(20), cEmail:=spac(55),; 
     cREPDES:=SPAC(30), cREPFON:=SPAC(12), cREPCON:=SPAC(20),;  //* REPRESENTANTE 
     cTELA0 
** variaveis gerais do modulo ** 
** variaveis privadas, para todos os modulos deste arquivo ** 
priv nCODIGO:=0, cDESCRI:=spac(45), nORDEMG:=1, nFONEN_:=0, aFONE:={spac(12),spac(12),spac(12)} 
priv aTELA1, aTELA 
** inicio ** 
SetColor( _COR_GET_EDICAO ) 
ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
DBSetOrder( 3 ) 
dbgobottom() 
nCODIGO:=CODIGO 
dbSetOrder( 1 ) 
dbgotop() 
++nCODIGO 
   setcolor(_COR_GET_EDICAO) 
   SetCursor( 1 ) 
   @ 02,03 say "Codigo.....:" get nCODIGO pict "9999" valid pesqcodigo(nCODIGO) when; 
     mensagem("Digite o codigo do fornecedor que sera cadastrado.") 
   @ 03,03 say "Nome.......:" get cDESCRI pict "@!"  valid pesqdescri(cDESCRI) when; 
     mensagem("Digite o nome do fornecedor.") 
   @ 04,03 say "Endereco...:" get cENDERE pict "@X" when; 
     mensagem("Digite o endereco do fornecedor.") 
   @ 05,03 say "Bairro.....:" get cBAIRRO pict "@S20" when; 
     mensagem("Digite o bairro.") 
   @ 06,03 say "Cidade.....:" get cCIDADE pict "@S30" when; 
     mensagem("Digite a cidade.") 
   @ 06,49 say "-" get cESTADO pict "@XX" valid veruf(@cESTADO) when; 
     mensagem("Digite o estado.") 
   @ 07,03 Say "Pa¡s.......:" get cPais  pict "@X" 
   @ 08,03 Say "E-Mail.....:" get cEmail pict "@X" 
   @ 09,03 say "Cep........:" get cCODCEP pict "@R 99.999-999" valid pesqcep(cCODCEP) when; 
     mensagem("Digite o cep.") 
   @ 09,44 say "Telefone(s):" get nFONEN_ pict "9" valid telefone(aFone,nFONEN_,09,57,"=>") when; 
     mensagem("Digite o numero de telefones que o fornecedor possui.") 
   @ 10,03 say "Telex......:" get cTELEX_ pict "@R XXXX-XXXX.XXXX" when; 
     mensagem("Digite o numero do TELEX do fornecedor se possuir.") 
   @ 10,44 say "Fax........:" get cFAX___ pict "@R XXXX-XXXX.XXXX" when; 
     mensagem("Digite o numero do FAX.") 
   @ 11,03 say "CGCMF......:" get cCGCMF_ pict "@R 99.999.999/9999-99" valid cgcmf(cCGCMF_) when; 
     mensagem("Digite o numero do CGCMF para inclusao.") 
   @ 11,44 say "Insc.Est...:" get cINSCRI pict "@9" when; 
     mensagem("Digite o numero da inscricao estadual do fornecedor.") 
   @ 12,03 say "Vendedores.:" get cVENDED pict "@X" when; 
     mensagem("Nome do responsavel pelas vendas.") 
   @ 13,03 say "Responsavel:" get cRESPON pict "@X" when; 
     mensagem("Digite o nome do responsavel pela empresa.") 
   @ 13,60 Say "Pagamento..:" get cANTPOS pict "@!" when; 
     mensagem("Pagamento em caso de feriado: [A]Anterior, [P]Posterior."); 
     valid cANTPOS$"AP " 
   read 
   cTELA0:=ScreenSave( 00, 00, 24, 79 ) 
   IF LASTKEY()<>27 
      VPBOX( 11, 10, 15, 69, "Representante" ) 
      @ 12, 11 SAY "Representante:" GET cREPDES 
      @ 13, 11 SAY "Contato......:" GET cREPCON 
      @ 14, 11 SAY "Fone.........:" GET cREPFON PICT "@R XXXX-XXXX.XXXX" 
      READ 
   ENDIF 
   if confirma(15,55,"Confirma?",; 
      "Digite [S] para confirmar o cadastramento do fornecedor.","S",COR[16]+","+COR[18]+",,,"+COR[17]); 
      .AND. buscanet(5,{|| dbappend(), !neterr()}) 
      ** Gravacao dos dados ** 
      repl CODIGO with nCODIGO, DESCRI with cDESCRI, ENDERE with cENDERE,; 
           BAIRRO with cBAIRRO, CIDADE with cCIDADE, ESTADO with cESTADO,; 
           CODCEP with cCODCEP, FONEN_ with nFONEN_, FONE1_ with aFONE[1],; 
           FONE2_ with aFONE[2], FONE3_ with aFONE[3], TELEX_ with cTELEX_,; 
           FAX___ with cFAX___, CGCMF_ with cCGCMF_, INSCRI with cINSCRI,; 
           VENDED with cVENDED, RESPON with cRESPON, PAIS__ with cPais,; 
           SELECT with cSELECT, TIPO__ with "1", E_MAIL with cEmail,; 
           ANTPOS With cANTPOS, REPDES with cREPDES,; 
           REPCON with cREPCON, REPFON with cREPFON 
      setcolor(COR[21]) 
      ** limpeza das variaveis ** 
      cDESCRI:=spac(45) 
      cENDERE:=spac(35) 
      cBAIRRO:=spac(25) 
      cCIDADE:=spac(30) 
      cESTADO:=spac(2) 
      cCODCEP:=spac(8) 
      cTELEX_:=cFAX___:= Spac( 12 ) 
      cCGCMF_:=spac(14) 
      cINSCRI:=spac(12) 
      cVENDED:=cRESPON:= Space( 40 ) 
      dDATACD:=date() 
      cSELECT:="Nao" 
      cREPDES:=SPAC(30) 
      cREPCON:=SPAC(30) 
      cREPFON:=SPAC(11) 
      cPais:=Space( 20 ) 
      cEMail:=Space( 55 ) 
      nFoneN_:=0 
      aFone:={ Space( 12 ), Space( 12 ), Space( 12 ) } 
   endif 
   SCREENREST( cTELA0 ) 
dbunlockall() 
/* Fecha arquivos de fornecedor e despesas, 
   para corrigir um defeito detectado no 
   cliente PONTOSUL Relogios, onde toda a vez 
   que fosse cadastrado novo fornecedor o 
   arquivo de indice ficava baguncado */ 
DBSelectAr( _COD_FORNECEDOR ) 
DBCloseArea() 
DBSelectAr( _COD_DESPESAS ) 
DBCloseArea() 
Ferase( GDir - "\DESIND01.NTX" ) 
Ferase( GDir - "\DESIND02.NTX" ) 
Ferase( GDir - "\FORIND01.NTX" ) 
Ferase( GDir - "\FORIND02.NTX" ) 
FdbUsevpb( _COD_FORNECEDOR, 2 ) 
FdbUsevpb( _COD_DESPESAS, 2 ) 
screenrest(cTELA) 
setcursor(nCURSOR) 
setcolor(cCOR) 
oTb:RefreshAll() 
WHILE !oTb:Stabilize() 
ENDDO 
set key K_TAB to 
return nil 
 
/* 
* Funcao      - PESQDESCRI 
* Finalidade  - Pesquisa no banco de dados atravez da descricao. 
* Programador - Valmor Pereira Flores 
* Data        - 14/Setembro/1993 
* Atualizacao - 
*/ 
stat func pesqdescri(cPDESCRI,nPMOD1) 
loca cTELA:=screensave(24-2,00,24-1,79), nREGISTRO:=recno() 
if cPDESCRI=spac(45) 
   return(.f.) 
endif 
dbsetorder(2) 
if dbseek(cPDESCRI) 
   if nPMOD1<>NIL .AND. nCODIGO=FOR->CODIGO 
      screenrest(cTELA) 
      dbgoto(nREGISTRO) 
      dbsetorder(nORDEMG) 
      return(.t.) 
   endif 
   ajuda("[TAB]Altera [ESC]Cancela") 
   mensagem("Fornecedor ja cadastrado. Pressione [TAB] para continuar...",1) 
   nTECLA:=inkey(0) 
   screenrest(cTELA) 
   dbgoto(nREGISTRO) 
   dbsetorder(nORDEMG) 
   return(.f.) 
endif 
dbgoto(nREGISTRO) 
dbsetorder(nORDEMG) 
return(.t.) 
 
/* 
* Funcao      - PESQCODIGO 
* Finalidade  - Pesquisa no banco de dados atravez do codigo de controle. 
* Programador - Valmor Pereira Flores 
* Data        - 14/Setembro/1993 
* Atualizacao - 01/Fevereiro/1994 
*/ 
stat func pesqcodigo(nPCODIGO) 
loca cTELA:=screensave(24-1,00,24,79), nREGISTRO:=recno() 
if nPCODIGO=0; return(.f.); endif 
dbsetorder(1) 
if dbseek(nPCODIGO) 
   ajuda("[ENTER]Altera [ESC]Cancela") 
   mensagem("Fornecedor ja cadastrado. Pressione [TAB] para alterar...",1) 
   nTECLA:=inkey(0) 
   screenrest(cTELA) 
   dbgoto(nREGISTRO) 
   dbsetorder(nORDEMG) 
   return(.f.) 
endif 
dbgoto(nREGISTRO) 
dbsetorder(nORDEMG) 
return(.t.) 
 
/* 
Funcao       - FOREXIBSTR 
Finalidade   - Exibir a estrutura do cadastro na tela 
Programador  - VPF 
Data         - 
Atualizacao  - 
*/ 
func forexibstr() 
Local cCor:= setcolor( _COR_GET_LETRA ) 
@ 02,03 say "Codigo.....: ["+strzero(CODIGO,4,0)+"]" 
@ 03,03 say "Nome.......: ["+space(45)+"]" 
@ 04,03 say "Endereco...: ["+space(35)+"]" 
@ 05,03 say "Bairro.....: ["+space(20)+"]" 
@ 06,03 say "Cidade.....: ["+space(30)+"]" 
@ 06,49 say "- [  ]" 
@ 07,03 Say "Pa¡s.......: ["+space(20)+"]" 
@ 08,03 Say "E-Mail.....: ["+space(55)+"]" 
@ 09,03 say "Cep........: [  .   -   ]" 
@ 09,44 say "Telefone(s): [ ] [XXXX-XXXX.XXXX]" 
@ 10,03 say "Fone (2)...: [XXXX-XXXX.XXXX]" 
@ 10,44 say "Fax........: [XXXX-XXXX.XXXX]" 
@ 11,03 say "CGCMF......: [  .   .   /    -  ]" 
@ 11,44 say "Insc.Est...: [            ]" 
@ 12,03 say "Vendedor...: ["+spac(40)+"]" 
@ 13,03 say "Responsavel: ["+spac(40)+"]" 
@ 13,60 say "Pagamento..: [*]" 
SetColor( cCor ) 
return nil 
 
/* 
* Funcao      - FORMOSTRA 
* Finalidade  - Exibir os dados dos fornecedores na tela do sistema 
* Programador - VPF 
* Data        - 
* Atualizacao - 
*/ 
func formostra() 
loca cCOR:=setcolor() 
setcolor( _COR_GET_CURSOR ) 
@ 02,17 say strzero(CODIGO,4,0) 
@ 03,17 say DESCRI 
@ 04,17 say ENDERE 
@ 05,17 say substr(BAIRRO,1,20) 
@ 06,17 say CIDADE 
@ 06,52 say ESTADO 
@ 07,17 Say PAIS__ 
@ 08,17 Say E_MAIL 
@ 09,17 say CODCEP pict "@R 99.999-999" 
@ 09,58 say FONEN_ 
@ 09,62 say FONE1_ pict "@R XXXX-XXXX.XXXX" 
@ 10,17 say FONE2_ pict "@R XXXX-XXXX.XXXX" 
@ 10,58 say FAX___ pict "@R XXXX-XXXX.XXXX" 
@ 11,17 say CGCMF_ pict "@R 99.999.999/9999-99" 
@ 11,58 say INSCRI 
@ 12,17 say VENDED 
@ 13,17 say RESPON 
@ 13,74 say ANTPOS 
setcolor(cCOR) 
return nil 
 
/* 
* Funcao      - FORALTERACAO 
* Finalidade  - Alterar os dados dos fornecedores. 
* Parametros  - Nenhum 
* Programador - VPF 
* Data        - 
* Atualizacao - 
*/ 
func foralteracao( oTb ) 
loca GETLIST:={}, cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
loca cCONFIRMA:="S", cENDERE:=ENDERE,; 
     cBAIRRO:=BAIRRO, cCIDADE:=CIDADE, cESTADO:=ESTADO,; 
     cCODCEP:=CODCEP, nFONEN_:=FONEN_, cTELEX_:=TELEX_,; 
     cFAX___:=FAX___, cCGCMF_:=CGCMF_, cINSCRI:=INSCRI,; 
     cVENDED:=VENDED, cRESPON:=RESPON, cSELECT:=SELECT,; 
     cANTPOS:=ANTPOS, cREPDES:=REPDES, cREPCON:=REPCON,; 
     cREPFON:=REPFON, cTELA0, cPais:=PAIS__, cEmail:=E_MAIL 
loca aTELA2 
set key K_TAB to 
nCODIGO:=CODIGO 
cDESCRI:=DESCRI 
aFONE:={FONE1_,FONE2_,FONE3_} 
VPBox( 0, 0, 14, 79, " Alteracao de Fornecedores ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
SetColor( _COR_GET_EDICAO ) 
SetCursor( 1 ) 
@ 02,03 say "Codigo.....: ["+strzero(nCODIGO,4,0)+"]" 
@ 03,03 say "Nome.......:" get cDESCRI pict "@!" when; 
  mensagem("Digite o nome do fornecedor.") 
@ 04,03 say "Endereco...:" get cENDERE pict "@X" when; 
  mensagem("Digite o endereco do fornecedor.") 
@ 05,03 say "Bairro.....:" get cBAIRRO pict "@S20" when; 
  mensagem("Digite o bairro.") 
@ 06,03 say "Cidade.....:" get cCIDADE pict "@S30" when; 
  mensagem("Digite a cidade.") 
@ 06,49 say "-" get cESTADO pict "@XX" valid veruf(@cESTADO) when; 
  mensagem("Digite o estado.") 
@ 07,03 Say "Pa¡s.......:" get cPais  pict "@X" 
@ 08,03 Say "E-Mail.....:" get cEmail pict "@X" 
@ 09,03 say "Cep........:" get cCODCEP pict "@R 99.999-999" valid pesqcep(cCODCEP) when; 
  mensagem("Digite o cep.") 
@ 09,44 say "Telefone(s):" get nFONEN_ pict "9" valid telefone(aFone,nFONEN_,09,57,"=>") when; 
  mensagem("Digite o numero de telefones que o fornecedor possui.") 
@ 10,03 say "Telex......:" get cTELEX_ pict "@R XXXX-XXXX.XXXX" when; 
  mensagem("Digite o numero do TELEX do fornecedor se possuir.") 
@ 10,44 say "Fax........:" get cFAX___ pict "@R XXXX-XXXX.XXXX" when; 
  mensagem("Digite o numero do FAX.") 
@ 11,03 say "CGCMF......:" get cCGCMF_ pict "@R 99.999.999/9999-99" valid cgcmf(cCGCMF_) when; 
  mensagem("Digite o numero do CGCMF para inclusao.") 
@ 11,44 say "Insc.Est...:" get cINSCRI pict "@9" when; 
  mensagem("Digite o numero da inscricao estadual do fornecedor.") 
@ 12,03 say "Vendedor...:" get cVENDED pict "@X" when; 
  mensagem("Digite o nome do responsavel pelas vendas.") 
@ 13,03 say "Responsavel:" get cRESPON pict "@X" when; 
  mensagem("Digite o nome do responsavel pela empresa.") 
@ 13,60 Say "Pagamento..:" get cANTPOS pict "@!" when; 
  mensagem("Pagamento em caso de feriado: [A]Anterior, [P]Posterior."); 
  valid cANTPOS$"AP " 
read 
cTELA0:=ScreenSave( 00, 00, 24, 79 ) 
IF LASTKEY()<>27 
   VPBox( 11, 10, 15, 69, "Representante", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
   @ 12, 11 SAY "Representante:" GET cREPDES 
   @ 13, 11 SAY "Contato......:" GET cREPCON 
   @ 14, 11 SAY "Fone.........:" GET cREPFON PICT "@R XXXX-XXXX.XXXX" 
   READ 
ENDIF 
If Confirma( 15, 55, "Confirma?", "Confirma a alteracao deste registro...", "S" ) 
   cConfirma:= "S" 
Else 
   cConfirma:= "N" 
EndIf 
ScreenRest( cTELA0 ) 
if cCONFIRMA="S" .AND. netrlock() 
   ** Gravacao dos dados ** 
   repl CODIGO with nCODIGO, DESCRI with cDESCRI, ENDERE with cENDERE,; 
        BAIRRO with cBAIRRO, CIDADE with cCIDADE, ESTADO with cESTADO,; 
        CODCEP with cCODCEP, FONEN_ with nFONEN_, FONE1_ with aFONE[1],; 
        FONE2_ with aFONE[2], FONE3_ with aFONE[3], TELEX_ with cTELEX_,; 
        FAX___ with cFAX___, CGCMF_ with cCGCMF_, INSCRI with cINSCRI,; 
        VENDED with cVENDED, RESPON with cRESPON, SELECT with cSELECT,; 
        REPDES with cREPDES, REPCON with cREPCON, REPFON with cREPFON,; 
        PAIS__ with cPais  , E_MAIL with cEmail,  ANTPOS With cAntPos 
   setcolor(COR[21]) 
endif 
setcolor(cCOR) 
setcursor(nCURSOR) 
set key K_TAB to pesquisadbf() 
screenrest(cTELA) 
oTb:RefreshAll() 
WHILE !oTb:Stabilize() 
ENDDO 
return nil 
 
/* 
* Funcao      - FORVER 
* Finalidade  - Viasualizacao do banco de dados dos fornecedores 
* Programador - Valmor Pereira Flores 
* Data        - 
* Atualizacao - 
*/ 
func forver() 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor(), oFOR, TECLA 
priv nORDEMG:=1, nCODIGO:=0, nDESCRI:=space(45), aTELA1, nFLAGFOR:=1 
priv aTELA 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
if !file(_VPB_FORNECEDOR) 
   aviso(" Arquivo de fornecedores inexistente! ",24/2) 
   ajuda("[ENTER]Retorna") 
   mensagem("Pressione [ENTER] para retornar...",1) 
   pausa() 
   screenrest(cTELA) 
   return nil 
endif 
if !fdbusevpb(_COD_FORNECEDOR,1) 
   aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_FORNECEDOR)+".",24/2) 
   mensagem("Erro na abertura do arquivo de fornecedores, tente novamente...") 
   pausa() 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
   return(NIL) 
endif 
//Set Filter To TIPO__="1" 
dbgotop() 
VPBox( 0, 0, 24-2, 79, " Verificacao de Fornecedores ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
ForExibStr() 
SetCursor( 0 ) 
SetColor( _COR_BROWSE ) 
VPBox( 15, 00, 24-2, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
mensagem("Pressione [ESC] para finalizar a verificacao.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [F2]Pesquisa [F3]Codigo [F4]Nome [ESC]Retorna") 
oFOR:=tbrowsedb( 13, 01, 24-3, 78 ) 
oFOR:addcolumn(tbcolumnnew(,{|| "  "+strzero(CODIGO,4,0)+" => "+DESCRI+" "+; 
          if(CGCMF_<>space(14),tran(CGCMF_,"@R 99.999.999/9999-99"),spac(18))+"  "})) 
oFOR:AUTOLITE:=.f. 
oFOR:dehilite() 
whil .t. 
   oFOR:colorrect({oFOR:ROWPOS,1,oFOR:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oFOR:stabilize() 
   enddo 
   formostra() 
   nCODIGO=CODIGO 
   TECLA:=inkey(0) 
   if TECLA=K_ESC 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oFOR:up() 
      case TECLA==K_LEFT       ;oFOR:up() 
      case TECLA==K_RIGHT      ;oFOR:down() 
      case TECLA==K_DOWN       ;oFOR:down() 
      case TECLA==K_PGUP       ;oFOR:pageup() 
      case TECLA==K_PGDN       ;oFOR:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oFOR:gotop() 
      case TECLA==K_CTRL_PGDN  ;oFOR:gobottom() 
      case TECLA==K_F3         ;organiza(oFOR,1) 
      case TECLA==K_F4         ;organiza(oFOR,2) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oFOR:refreshcurrent() 
   oFOR:stabilize() 
enddo 
//set filter to 
set key K_TAB to 
dbunlockall() 
FechaArquivos() 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return nil 
 
/* 
* Funcao      - FORSELECIONA 
* Finalidade  - Selecao de vendadores a partir de outros modulos. 
* Programador - Valmor Pereira Flores 
* Data        - 
* Atualizacao - 
*/ 
Func ForSeleciona( FORCOD ) 
Loca GetList:= {} 
loca nAREA:=select(), nORDEM:=indexord() 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor(), oFOR, TECLA 
loca mBUSCA 
/* 
if FORCOD=0 
   return(.T.) 
endif 
*/ 
dbselectar(_COD_FORNECEDOR) 
dbSetOrder( 3 ) 
if forcod <> 0 .AND. dbseek( FORCOD ) 
   cxFORNECED:= DESCRI 
   dbselectar(nAREA) 
   return(.T.) 
endif 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
usermodulo(" Selecao de fornecedores ") 
dbgotop() 
setcursor(0) 
setcolor( _COR_BROWSE ) 
vpbox( 11, 15, 24-4, 76, " FORNECEDORES ", _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
mensagem("Para selecionar pressione [ENTER] com o cursor sobre o fornecedor.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3]Codigo [F4]Nome [ESC]Retorna") 
DBLeOrdem() 
oFOR:=tbrowsedb(12,16,24-5,75) 
oFOR:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" => "+DESCRI+"       "})) 
oFOR:AUTOLITE:=.f. 
oFOR:dehilite() 
whil .t. 
   oFOR:colorrect({oFOR:ROWPOS,1,oFOR:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oFOR:stabilize() 
   enddo 
   TECLA:=inkey(0) 
   if TECLA=K_ESC 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oFOR:up() 
      case TECLA==K_LEFT       ;oFOR:up() 
      case TECLA==K_RIGHT      ;oFOR:down() 
      case TECLA==K_DOWN       ;oFOR:down() 
      case TECLA==K_PGUP       ;oFOR:pageup() 
      case TECLA==K_PGDN       ;oFOR:pagedown() 
      case TECLA==K_END        ;oFOR:gotop() 
      case TECLA==K_HOME       ;oFOR:gobottom() 
      case DBPesquisa( TECLA, oFor ) 
      case TECLA==K_F3         ;DBMudaOrdem( 3, oFOR ) 
      case TECLA==K_F4         ;DBMudaOrdem( 4, oFOR ) 
      case TECLA==K_ENTER 
           FORCOD:=CODIGO 
           cxFORNECED:=DESCRI 
           exit 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oFOR:refreshcurrent() 
   oFOR:stabilize() 
enddo 
dbselectar(nAREA) 
IF Used() 
   dbsetorder(nORDEM) 
ENDIF 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(if(TECLA==K_ENTER,.T.,.F.)) 
 
