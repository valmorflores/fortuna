// ## CL2HB.EXE - Converted
#include "VPF.CH" 
#include "INKEY.CH" 
#include "PTFUNCS.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TRANSPORTADORAS 
³ Finalidade  ³ Cadastro de Transportadoras 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Airan Machado 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/
#ifdef HARBOUR
function vpc26000()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  IF !file(_VPB_TRANSPORTE) 
     Aviso(" Arquivo de transportadoras inexistente! ",nMAXLIN/2) 
     Ajuda("[ENTER]Retorna") 
     Mensagem("Pressione [ENTER] para retornar...",1) 
     Pausa() 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  DBSelectAr( _COD_TRANSPORTE ) 
  dbGoTop() 
 
  SetColor( _COR_BROWSE ) 
  VPBox( 00, 00, 12, 79, " TRANSPORTADORAS ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  VPBox( 13, 00, 22, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  ExibeStr() 
  SetCursor( 0 ) 
  DBLeOrdem() 
  Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui [ESC]Finaliza" ) 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3/F4]Ordem [ESC]Retorna") 
  oTab:=tbrowsedb(14,01, 24-3, 79-1) 
  oTab:addcolumn(tbcolumnnew(,{|| "  " + StrZero(CODIGO,4,0)+" => "+; 
                                         DESCRI+"  "+Space( 30 ) })) 
  oTab:AUTOLITE:=.f. 
  oTab:dehilite() 
  WHILE .T. 
     oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
     WHILE nextkey()=0 .and.! oTab:stabilize() 
     ENDDO 
     ExibeDados() 
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
        case nTecla==K_END        ;oTab:gotop() 
        case nTecla==K_HOME       ;oTab:gobottom() 
        case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
        case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
        case DBPesquisa( nTecla, oTab ) 
        case nTecla==K_INS 
             TraInclusao( oTab ) 
        case nTecla==K_DEL 
             Exclui( oTab ) 
        case nTecla==K_ENTER 
             TraAlteracao( oTab ) 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab:refreshcurrent() 
     oTab:stabilize() 
  enddo 
  dbunlockall() 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
  return nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TRANSPORTADORAS 
³ Finalidade  ³ Cadastro de Transportadoras 
³ Parametros  ³ Nil 
³ Retorno     ³ Nil 
³ Programador ³ Airan Machado 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function TranSeleciona( nCodigo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, nArea:= Select() 
 
  DBSelectAr( _COD_TRANSPORTE ) 
  dbGoTop() 
 
  DBSetOrder( 1 ) 
  DBSeek( nCodigo, .T. ) 
 
  SetColor( _COR_BROWSE ) 
  VPBox( 10, 35, 20, 77, " TRANSPORTADORAS ", _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  SetCursor( 0 ) 
  DBLeOrdem() 
  Mensagem( "[ENTER]Seleciona [ESC]Finaliza" ) 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3/F4]Ordem [ESC]Retorna") 
  oTab:=tbrowsedb( 11, 36, 19, 76 ) 
  oTab:addcolumn( tbcolumnnew(,{|| "  " + StrZero(CODIGO,4,0)+" => "+; 
                                          DESCRI+"  "+Space( 30 ) })) 
  oTab:AUTOLITE:=.f. 
  WHILE .T. 
     oTab:ForceStable()
     oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
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
        case nTecla==K_END        ;oTab:gotop() 
        case nTecla==K_HOME       ;oTab:gobottom() 
        case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
        case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
        case DBPesquisa( nTecla, oTab ) 
        case nTecla==K_ENTER 
             nCodigo:= CODIGO 
             EXIT 
        otherwise                ;tone(125); tone(300) 
     endcase 
     oTab:refreshcurrent() 
  enddo 
  dbunlockall() 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
  DBSelectAr( nArea ) 
  return .T. 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TraInclusao 
³ Finalidade  ³ Inclusao de transportadoras 
³ Parametros  ³ oTab 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function TraInclusao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:=0, cDescri:= Spac(45),; 
      cEndere:= Space( 40 ), cBairro:= Space( 30 ),; 
      cCidade:= Space( 20 ), cEstado:= Space( 2 ),; 
      cCodCep:= Space( 8 ),  cCgcMF_:= Space( 14 ),; 
      cCPF___:= Space( 11 ), cFone__:= Space( 12 ),; 
      cE_Mail:= Space( 60 ), cINS___:= Space( 15 ) 
 
Local nOrdem:= IndexOrd() 
 
  VPBox( 00, 00, 12, 79, " INCLUSAO DE TRANSPORTADORA", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
  DBSetOrder( 1 ) 
  dbgobottom() 
  nCODIGO:=CODIGO 
  dbgotop() 
  WHILE .T. 
     ++nCODIGO 
     setcolor( _COR_GET_EDICAO ) 
     SetCursor( 1 ) 
     @ 02,03 say "Codigo.....:" Get nCODIGO pict "999" valid PesqCodigo(nCODIGO) when; 
       mensagem("Digite o codigo do transportadora que sera cadastrado.") 
     @ 03,03 say "Nome.......:" Get cDESCRI pict "@!"  valid pesqdescri(cDESCRI) when; 
       mensagem("Digite o nome do transportadora.") 
     @ 04,03 Say "Endereco...:" Get cEndere 
     @ 05,03 Say "Bairro.....:" Get cBairro 
     @ 06,03 Say "Cidade.....:" Get cCidade 
     @ 06,45 Say "Estado:" Get cEstado 
     @ 07,03 Say "Cep........:" Get cCodCep Pict "@R 99999-999" 
     @ 07,45 Say "Fone..:" Get cFone__ Pict "@R XXXX-XXXX.XXXX" 
     @ 08,03 Say "CGC/MF.....:" Get cCgcMf_ Pict "@R 99.999.999/9999-99" Valid Cgcmf( @cCgcMf_ ) 
     @ 09,03 Say "CPF........:" Get cCPF___ Pict "@R 999.999.999-99" Valid Cpf( cCPF___ ) 
     @ 10,03 Say "Inscr.Est..:" Get cINS___ 
     @ 11,03 Say "E-Mail.....:" get cE_Mail 
     read 
     IF lastkey()=K_ESC 
        exit 
     ENDIF 
     IF Confirma( 0, 0, "Confirma?",; 
        "Digite [S] para confirmar o cadastramento do transportadora.","S") 
        IF BuscaNet( 5, {|| dbappend(), !neterr() } ) 
           Replace CODIGO with nCODIGO,; 
                   DESCRI with cDESCRI,; 
                   ENDERE With cEndere,; 
                   BAIRRO With cbairro,; 
                   ESTADO With cEstado,; 
                   CIDADE With cCidade,; 
                   FONE__ With cFone__,; 
                   E_MAIL With cE_Mail,; 
                   CGCMF_ With cCgcMf_,; 
                   CPF___ With cCPF___,; 
                   INSCRI With cINS___,; 
                   CODCEP With cCodCep 
           cDESCRI:= Space( 45 ) 
           cEndere:= Space( 40 ) 
           cBairro:= Space( 30 ) 
           cCidade:= Space( 20 ) 
           cEstado:= Space( 2 ) 
           cCodCep:= Space( 8 ) 
           cCgcMF_:= Space( 14 ) 
           cCPF___:= Space( 11 ) 
           cINS___:= Space( 15 ) 
           cFone__:= Space( 12 ) 
           cE_Mail:= Space( 60 ) 
        ENDIF 
     ENDIF 
  ENDDO 
  dbunlockall() 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TraAlteracao 
³ Finalidade  ³ Inclusao de transportadoras 
³ Parametros  ³ oTab 
³ Retorno     ³ Nil 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function TraAlteracao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= CODIGO, cDescri:= DESCRI,; 
      cEndere:= ENDERE, cBairro:= BAIRRO,; 
      cCidade:= CIDADE, cEstado:= ESTADO,; 
      cCodCep:= CODCEP, cCgcMF_:= CGCMF_,; 
      cINS___:= INSCRI, ; 
      cCPF___:= CPF___, cFone__:= FONE__, cE_Mail:= E_MAIL 
 
Local nOrdem:= IndexOrd() 
 
  VPBox( 00, 00, 12, 79, " ALTERACAO DE TRANSPORTADORAS ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
  setcolor( _COR_GET_EDICAO ) 
  SetCursor( 1 ) 
  @ 02,03 Say "Codigo.....: [" + StrZero( CODIGO, 3, 0 ) + "]" 
  @ 03,03 say "Nome.......:" Get cDESCRI pict "@!"  when; 
    mensagem("Digite o nome do transportadora.") 
  @ 04,03 Say "Endereco...:" Get cEndere 
  @ 05,03 Say "Bairro.....:" Get cBairro 
  @ 06,03 Say "Cidade.....:" Get cCidade 
  @ 06,45 Say "Estado:" Get cEstado 
  @ 07,03 Say "Cep........:" Get cCodCep Pict "@R 99999-999" 
  @ 07,45 Say "Fone..:" Get cFone__ Pict "@R XXXX-XXXX.XXXX" 
  @ 08,03 Say "CGC/MF.....:" Get cCgcMf_ Pict "@R 99.999.999/9999-99" Valid Cgcmf( @cCgcMf_ ) 
  @ 09,03 Say "CPF........:" Get cCPF___ Pict "@R 999.999.999-99" Valid CPF( cCPF___ ) 
  @ 10,03 Say "Inscr.Est..:" Get cINS___ 
  @ 11,03 Say "E-Mail.....:" get cE_Mail 
  read 
  IF Confirma( 0, 0, "Confirma?",; 
     "Digite [S] para confirmar o cadastramento da transportadora.","S") 
     IF NetRLock() 
        Replace DESCRI with cDESCRI,; 
                ENDERE With cEndere,; 
                BAIRRO With cbairro,; 
                ESTADO With cEstado,; 
                CIDADE With cCidade,; 
                FONE__ With cFone__,; 
                E_MAIL With cE_Mail,; 
                CGCMF_ With cCgcMf_,; 
                CPF___ With cCPF___,; 
                INSCRI With cINS___,; 
                CODCEP With cCodCep 
        cDESCRI:= Space( 45 ) 
        cEndere:= Space( 40 ) 
        cBairro:= Space( 30 ) 
        cCidade:= Space( 20 ) 
        cEstado:= Space( 2 ) 
        cCodCep:= Space( 8 ) 
        cCgcMF_:= Space( 14 ) 
        cCPF___:= Space( 11 ) 
        cINS___:= Space( 15 ) 
        cFone__:= Space( 12 ) 
        cE_Mail:= Space( 60 ) 
     ENDIF 
     oTab:RefreshAll() 
     WHILE !oTab:Stabilize() 
     ENDDO 
  ENDIF 
  dbunlockall() 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
/* 
* Funcao      - PESQDESCRI 
* Finalidade  - Pesquisa no banco de dados atravez da descricao. 
* Programador - Valmor Pereira Flores 
* Data        - 14/Setembro/1993 
* Atualizacao - 
*/ 
stat func pesqdescri(cPDESCRI,nPMOD1) 
loca cTELA:=screensave(nMAXLIN-2,00,23,nMAXCOL), nREGISTRO:=recno() 
if cPDESCRI=spac(45) 
   return(.f.) 
endif 
dbsetorder(2) 
if dbseek(cPDESCRI) 
   if nPMOD1<>NIL .AND. nCODIGO=VEN->CODIGO 
      screenrest(cTELA) 
      dbgoto(nREGISTRO) 
      return(.t.) 
   endif 
   ajuda("[ESC]Cancela") 
   mensagem("transportadora ja cadastrado. Pressione [ENTER] para continuar...",1) 
   nTECLA:=inkey(0) 
   screenrest(cTELA) 
   dbgoto(nREGISTRO) 
   return(.f.) 
endif 
dbgoto(nREGISTRO) 
return(.t.) 
 
/* 
* Funcao      - PESQCODIGO 
* Finalidade  - Pesquisa no banco de dados atravez do codigo de controle. 
* Programador - Valmor Pereira Flores 
* Data        - 14/Setembro/1993 
* Atualizacao - 01/Fevereiro/1994 
*/ 
stat func pesqcodigo(nPCODIGO) 
loca cTELA:=screensave(23,00,nMAXLIN,nMAXCOL), nREGISTRO:=recno() 
if nPCODIGO=0; return(.f.); endif 
dbsetorder(1) 
If dbseek(nPCODIGO) 
   ajuda("[TAB]Altera [ESC]Cancela") 
   mensagem("transportadora ja cadastrado. Pressione qualquer tecla p/ continuar...",1) 
   nTECLA:=inkey(0) 
   screenrest(cTELA) 
   dbgoto(nREGISTRO) 
   return(.f.) 
Endif 
Return(.t.) 
 
 
/* 
Funcao       - EXIBESTRU 
Finalidade   - Exibir a estrutura do cadastro na tela 
Programador  - VPF 
Data         - 
Atualizacao  - 
*/ 
stat func ExibeStr() 
local cCor:= SetColor() 
setcolor( _COR_GET_LETRA ) 
@ 02,03 say "Codigo.....: [   ]" 
@ 03,03 say "Nome.......: [" + Space( 40 ) + "]" 
@ 04,03 Say "Endereco...: [" + Space( Len( ENDERE ) ) + "]" 
@ 05,03 Say "Bairro.....: [" + Space( Len( BAIRRO ) ) + "]" 
@ 06,03 Say "Cidade.....: [" + Space( Len( CIDADE ) ) + "]" 
@ 06,45 Say "Estado: [  ]" 
@ 07,03 Say "Cep........: [     -   ]" 
@ 07,45 Say "Fone..: [    -    .    ]" 
@ 08,03 Say "CGC/MF.....: [  .   .   /    -  ]" 
@ 09,03 Say "CPF........: [   .   .   -  ]" 
@ 10,03 Say "Inscr.Est..: [" + Space( 15 ) + "]" 
@ 11,03 Say "E-Mail.....: [" + Space( LEN( E_Mail ) ) + "]" 
SetColor( cCor ) 
return nil 
 
Function ExibeDados() 
local cCor:= SetColor() 
setcolor( _COR_GET_CURSOR ) 
@ 02,17 say StrZero( CODIGO, 3, 0 ) 
@ 03,17 say DESCRI 
@ 04,17 Say ENDERE 
@ 05,17 Say BAIRRO 
@ 06,17 Say CIDADE 
@ 06,54 Say ESTADO 
@ 07,17 Say Tran( CODCEP, "@R 99999-999" ) 
@ 07,54 Say Tran( FONE__, "@R 9999-9999.9999" ) 
@ 08,17 Say Tran( CGCMF_, "@R 99.999.999/9999-99" ) 
@ 09,17 Say Tran( CPF___, "@R 999.999.999-99" ) 
@ 10,17 Say INSCRI 
@ 11,17 Say E_Mail 
SetColor( cCor ) 
Return Nil 
 
