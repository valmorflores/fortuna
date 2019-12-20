// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
#include "ptfuncs.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VENDEDORES 
� Finalidade  � Cadastro de Vendedores 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/

#ifdef HARBOUR
function vpc51100()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  IF !file(_VPB_VENDEDOR) 
     Aviso(" Arquivo de vendedores inexistente! ",nMAXLIN/2) 
     Ajuda("[ENTER]Retorna") 
     Mensagem("Pressione [ENTER] para retornar...",1) 
     Pausa() 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
 
  DBSelectAr( _COD_VENDEDOR ) 
  dbGoTop() 
 
  SetColor( _COR_BROWSE ) 
  VPBox( 00, 00, 13, 79, " VENDEDORES ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  VPBox( 14, 00, 22, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
  ExibeStr() 
  SetCursor( 0 ) 
  DBLeOrdem() 
  Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui [ESC]Finaliza [TAB]Etiqueta" ) 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [A..Z]Pesquisa [F3/F4]Ordem [ESC]Retorna") 
  oTab:=tbrowsedb(15,01, 24-3, 79-1) 
  oTab:addcolumn(tbcolumnnew(,{|| "  " + StrZero(CODIGO,4,0)+" => "+; 
                                         DESCRI+"  "+SIGLA_+"     "+; 
                                if(TIPO__="E","Externo  ","Interno  ") + Space( 20 ) })) 
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
        case nTecla==K_TAB 
 
             IF SWAlerta( "<< ETIQUETAS >>;Deseja imprimir etiquetas?", { "Confirma", "Cancela" } )==1 
                Relatorio( "VENETQ.REP" ) 
             ENDIF 
 
        case DBPesquisa( nTecla, oTab ) 
        case nTecla==K_INS 
             VenInclusao( oTab ) 
        case nTecla==K_DEL 
             Exclui( oTab ) 
        case nTecla==K_ENTER 
             VenAlteracao( oTab ) 
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
�������������Ŀ 
� Funcao      � venInclusao 
� Finalidade  � Inclusao de Vendedores 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function VenInclusao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cSIGLA_:=spac(2), cTIPO__:=spac(1),; 
      cSELECT:="Nao", nCodigo:=0, cDescri:= Spac(45),; 
      cEndere:= Space( 40 ), cBairro:= Space( 30 ),; 
      cCidade:= Space( 20 ), cEstado:= Space( 2 ),; 
      cCodCep:= Space( 8 ),  cCgcMF_:= Space( 14 ),; 
      cCPF___:= Space( 11 ), cFone__:= Space( 12 ),; 
      cE_Mail:= Space( 60 ), nForm01:= 0,; 
      nForm02:= 0, nForm03:= 0, nForm04:= 0, nForm05:= 0, nForm06:= 0,; 
      nForm07:= 0, nForm08:= 0, nForm09:= 0, nForm10:= 0,; 
      nMIni01:= 01, nMFim01:= 12,; 
      nMIni02:= 01, nMFim02:= 12,; 
      nMIni03:= 01, nMFim03:= 12,; 
      nMIni04:= 01, nMFim04:= 12,; 
      nMIni05:= 01, nMFim05:= 12,; 
      nMIni06:= 01, nMFim06:= 12,; 
      nMIni07:= 01, nMFim07:= 12,; 
      nMIni08:= 01, nMFim08:= 12,; 
      nMIni09:= 01, nMFim09:= 12,; 
      nMIni10:= 01, nMFim10:= 12 
 
Local nOrdem:= IndexOrd() 
 
  VPBox( 00, 00, 13, 79, " INCLUSAO DE VENDEDORES / REPRESENTANTES ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
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
       mensagem("Digite o codigo do vendedor que sera cadastrado.") 
     @ 03,03 say "Nome.......:" Get cDESCRI pict "@!"  valid pesqdescri(cDESCRI) when; 
       mensagem("Digite o nome do vendedor.") 
     @ 04,03 say "Sigla......:" Get cSIGLA_ pict "@!" when; 
       mensagem("Digite a sigla do vendedor.") 
     @ 05,03 Say "Endereco...:" Get cEndere 
     @ 06,03 Say "Bairro.....:" Get cBairro 
     @ 07,03 Say "Cidade.....:" Get cCidade 
     @ 07,45 Say "Estado:" Get cEstado 
     @ 08,03 Say "Cep........:" Get cCodCep Pict "@R 99999-999" 
     @ 08,45 Say "Fone..:" Get cFone__ Pict "@R XXXX-XXXX.XXXX" 
     @ 09,03 Say "CGC/MF.....:" Get cCgcMf_ Pict "@R 99.999.999/9999-99" Valid Cgcmf( @cCgcMf_ ) 
     @ 10,03 Say "CPF........:" Get cCPF___ Pict "@R 999.999.999-99" 
     @ 11,03 say "Tipo.......:" get cTIPO__ pict "@!" valid cTIPO__$"IE" when; 
       mensagem("Digite o tipo de vendedor: (I)nterno ou (E)xterno.") 
     @ 12,03 Say "E-Mail.....:" get cE_Mail 
     read 
     IF !LastKey() == K_ESC 
        cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
        Scroll( 03, 01, 12, 78, 0 ) 
        @ 03,03 Say "Formula Principal:" Get nForm01 Pict "99" 
        @ 03,29 Get nMIni01 Pict "99" 
        @ 03,36 Get nMFim01 Pict "99" 
        @ 04,03 Say "      2a. Formula:" Get nForm02 Pict "99" 
        @ 04,29 Get nMIni02 Pict "99" 
        @ 04,36 Get nMFim02 Pict "99" 
        @ 05,03 Say "      3a. Formula:" Get nForm03 Pict "99" 
        @ 05,29 Get nMIni03 Pict "99" 
        @ 05,36 Get nMFim03 Pict "99" 
        @ 06,03 Say "      4a. Formula:" Get nForm04 Pict "99" 
        @ 06,29 Get nMIni04 Pict "99" 
        @ 06,36 Get nMFim04 Pict "99" 
        @ 07,03 Say "      5a. Formula:" Get nForm05 Pict "99" 
        @ 07,29 Get nMIni05 Pict "99" 
        @ 07,36 Get nMFim05 Pict "99" 
        @ 08,03 Say "      6a. Formula:" Get nForm06 Pict "99" 
        @ 08,29 Get nMIni06 Pict "99" 
        @ 08,36 Get nMFim06 Pict "99" 
        @ 09,03 Say "      7a. Formula:" Get nForm07 Pict "99" 
        @ 09,29 Get nMIni07 Pict "99" 
        @ 09,36 Get nMFim07 Pict "99" 
        @ 10,03 Say "      8a. Formula:" Get nForm08 Pict "99" 
        @ 10,29 Get nMIni08 Pict "99" 
        @ 10,36 Get nMFim08 Pict "99" 
        @ 11,03 Say "      9a. Formula:" Get nForm09 Pict "99" 
        @ 11,29 Get nMIni09 Pict "99" 
        @ 11,36 Get nMFim09 Pict "99" 
        @ 12,03 Say "     10a. Formula:" Get nForm10 Pict "99" 
        @ 12,29 Get nMIni10 Pict "99" 
        @ 12,36 Get nMFim10 Pict "99" 
        READ 
        ScreenRest( cTelaRes ) 
     ENDIF 
     IF lastkey()=K_ESC 
        exit 
     ENDIF 
     IF Confirma( 0, 0, "Confirma?",; 
        "Digite [S] para confirmar o cadastramento do vendedor.","S") 
        IF BuscaNet( 5, {|| dbappend(), !neterr() } ) 
           Replace CODIGO with nCODIGO,; 
                   DESCRI with cDESCRI,; 
                   SIGLA_ with cSIGLA_,; 
                   TIPO__ with cTIPO__,; 
                   SELECT with cSELECT,; 
                   ENDERE With cEndere,; 
                   BAIRRO With cbairro,; 
                   ESTADO With cEstado,; 
                   CIDADE With cCidade,; 
                   FONE__ With cFone__,; 
                   E_MAIL With cE_Mail,; 
                   CGCMF_ With cCgcMf_,; 
                   CPF___ With cCPF___,; 
                   CODCEP With cCodCep,; 
                   FORM01 With nForm01,; 
                   FORM02 With nForm02,; 
                   FORM03 With nForm03,; 
                   FORM04 With nForm04,; 
                   FORM05 With nForm05,; 
                   FORM06 With nForm06,; 
                   FORM07 With nForm07,; 
                   FORM08 With nForm08,; 
                   FORM09 With nForm09,; 
                   FORM10 With nForm10,; 
                   MINI01 With nMIni01,; 
                   MINI02 With nMIni02,; 
                   MINI03 With nMIni03,; 
                   MINI04 With nMIni04,; 
                   MINI05 With nMIni05,; 
                   MINI06 With nMIni06,; 
                   MINI07 With nMIni07,; 
                   MINI08 With nMIni08,; 
                   MINI09 With nMIni09,; 
                   MINI10 With nMIni10,; 
                   MFIM01 With nMFIM01,; 
                   MFIM02 With nMFIM02,; 
                   MFIM03 With nMFIM03,; 
                   MFIM04 With nMFIM04,; 
                   MFIM05 With nMFIM05,; 
                   MFIM06 With nMFIM06,; 
                   MFIM07 With nMFIM07,; 
                   MFIM08 With nMFIM08,; 
                   MFIM09 With nMFIM09,; 
                   MFIM10 With nMFIM10 
           cDESCRI:= Space( 45 ) 
           nCOMIVT:= 0 
           cTIPO__:= " " 
           cSIGLA_:= "  " 
           cSELECT:= "Nao" 
           cEndere:= Space( 40 ) 
           cBairro:= Space( 30 ) 
           cCidade:= Space( 20 ) 
           cEstado:= Space( 2 ) 
           cCodCep:= Space( 8 ) 
           cCgcMF_:= Space( 14 ) 
           cCPF___:= Space( 11 ) 
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
�������������Ŀ 
� Funcao      � venAlteracao 
� Finalidade  � Inclusao de Vendedores 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function VenAlteracao( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cSIGLA_:= SIGLA_, cTIPO__:= TIPO__,; 
      cSELECT:= SELECT, nCodigo:= CODIGO, cDescri:= DESCRI,; 
      cEndere:= ENDERE, cBairro:= BAIRRO,; 
      cCidade:= CIDADE, cEstado:= ESTADO,; 
      cCodCep:= CODCEP, cCgcMF_:= CGCMF_,; 
      cCPF___:= CPF___, cFone__:= FONE__, cE_Mail:= E_MAIL,; 
      nForm01:= FORM01, nForm02:= FORM02, nForm03:= FORM03,; 
      nForm04:= FORM04, nForm05:= FORM05, nForm06:= FORM06,; 
      nForm07:= FORM07, nForm08:= FORM08, nForm09:= FORM09, nForm10:= FORM10 
Local nOrdem:= IndexOrd() 
 
Priv  nMIni01:=MINI01, nMIni02:=MINI02, nMIni03:=MINI03, nMIni04:=MINI04,; 
      nMIni05:=MINI05, nMIni06:=MINI06, nMIni07:=MINI07, nMIni08:=MINI08,; 
      nMIni09:=MINI09, nMIni10:=MINI10, nMFIM01:=MFIM01, nMFIM02:=MFIM02,; 
      nMFIM03:=MFIM03, nMFIM04:=MFIM04, nMFIM05:=MFIM05, nMFIM06:=MFIM06,; 
      nMFIM07:=MFIM07, nMFIM08:=MFIM08, nMFIM09:=MFIM09, nMFIM10:=MFIM10 
 
 
  VPBox( 00, 00, 13, 79, " ALTERACAO DE VENDEDORES / REPRESENTANTES ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
  setcolor( _COR_GET_EDICAO ) 
  SetCursor( 1 ) 
  @ 02,03 Say "Codigo.....: [" + StrZero( CODIGO, 3, 0 ) + "]" 
  @ 03,03 say "Nome.......:" Get cDESCRI pict "@!"  when; 
    mensagem("Digite o nome do vendedor.") 
  @ 04,03 say "Sigla......:" Get cSIGLA_ pict "@!" when; 
    mensagem("Digite a sigla do vendedor.") 
  @ 05,03 Say "Endereco...:" Get cEndere 
  @ 06,03 Say "Bairro.....:" Get cBairro 
  @ 07,03 Say "Cidade.....:" Get cCidade 
  @ 07,45 Say "Estado:" Get cEstado 
  @ 08,03 Say "Cep........:" Get cCodCep Pict "@R 99999-999" 
  @ 08,45 Say "Fone..:" Get cFone__ Pict "@R XXXX-XXXX.XXXX" 
  @ 09,03 Say "CGC/MF.....:" Get cCgcMf_ Pict "@R 99.999.999/9999-99" Valid Cgcmf( @cCgcMf_ ) 
  @ 10,03 Say "CPF........:" Get cCPF___ Pict "@R 999.999.999-99" 
  @ 11,03 say "Tipo.......:" get cTIPO__ pict "@!" valid cTIPO__$"IE" when; 
    mensagem("Digite o tipo de vendedor: (I)nterno ou (E)xterno.") 
  @ 12,03 Say "E-Mail.....:" get cE_Mail 
  read 
  IF !LastKey() == K_ESC 
     cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
     Scroll( 01, 01, 12, 78 ) 
 
     @ 01,23 Say "           Validade em Periodo (Mes)" 
     @ 02,23 Say "Form       Inicial        Final     " 
 
     nLin:= 3 
     nCol1:= 35 
     nCol2:= 52 
     FOR nCt:= 1 TO 10 
        cVar1:= "nMIni" + StrZero( nCt, 2, 0 ) 
        cVar2:= "nMFim" + StrZero( nCt, 2, 0 ) 
        ExibeMes( &cVar1, nLin, nCol1 ) 
        ExibeMes( &cVar2, nLin, nCol2 ) 
        ++nLin 
     NEXT 
 
     @ 03,03 Say "Formula Principal:" Get nForm01 Pict "99" 
     @ 03,34 Get nMIni01 Pict "99" Valid ExibeMes( nMIni01, 03, 35 ) 
     @ 03,50 Get nMFim01 Pict "99" Valid ExibeMes( nMFim01, 03, 52 ) 
     @ 04,03 Say "      2a. Formula:" Get nForm02 Pict "99" 
     @ 04,34 Get nMIni02 Pict "99" Valid ExibeMes( nMIni02, 04, 35  ) 
     @ 04,50 Get nMFim02 Pict "99" Valid ExibeMes( nMFim02, 04, 52  ) 
     @ 05,03 Say "      3a. Formula:" Get nForm03 Pict "99" 
     @ 05,34 Get nMIni03 Pict "99" Valid ExibeMes( nMIni03, 05, 35  ) 
     @ 05,50 Get nMFim03 Pict "99" Valid ExibeMes( nMFim03, 05, 52  ) 
     @ 06,03 Say "      4a. Formula:" Get nForm04 Pict "99" 
     @ 06,34 Get nMIni04 Pict "99" Valid ExibeMes( nMIni04, 06, 35  ) 
     @ 06,50 Get nMFim04 Pict "99" Valid ExibeMes( nMFim04, 06, 52  ) 
     @ 07,03 Say "      5a. Formula:" Get nForm05 Pict "99" 
     @ 07,34 Get nMIni05 Pict "99" Valid ExibeMes( nMIni05, 07, 35  ) 
     @ 07,50 Get nMFim05 Pict "99" Valid ExibeMes( nMFim05, 07, 52  ) 
     @ 08,03 Say "      6a. Formula:" Get nForm06 Pict "99" 
     @ 08,34 Get nMIni06 Pict "99" Valid ExibeMes( nMIni06, 08, 35  ) 
     @ 08,50 Get nMFim06 Pict "99" Valid ExibeMes( nMFim06, 08, 52  ) 
     @ 09,03 Say "      7a. Formula:" Get nForm07 Pict "99" 
     @ 09,34 Get nMIni07 Pict "99" Valid ExibeMes( nMIni07, 09, 35  ) 
     @ 09,50 Get nMFim07 Pict "99" Valid ExibeMes( nMFim07, 09, 52  ) 
     @ 10,03 Say "      8a. Formula:" Get nForm08 Pict "99" 
     @ 10,34 Get nMIni08 Pict "99" Valid ExibeMes( nMIni08, 10, 35  ) 
     @ 10,50 Get nMFim08 Pict "99" Valid ExibeMes( nMFim08, 10, 52  ) 
     @ 11,03 Say "      9a. Formula:" Get nForm09 Pict "99" 
     @ 11,34 Get nMIni09 Pict "99" Valid ExibeMes( nMIni09, 11, 35  ) 
     @ 11,50 Get nMFim09 Pict "99" Valid ExibeMes( nMFim09, 11, 52  ) 
     @ 12,03 Say "     10a. Formula:" Get nForm10 Pict "99" 
     @ 12,34 Get nMIni10 Pict "99" Valid ExibeMes( nMIni10, 12, 35  ) 
     @ 12,50 Get nMFim10 Pict "99" Valid ExibeMes( nMFim10, 12, 52  ) 
     READ 
     ScreenRest( cTelaRes ) 
  ENDIF 
  IF Confirma( 0, 0, "Confirma?",; 
     "Digite [S] para confirmar o cadastramento do vendedor.","S") 
     IF netrlock() 
        Replace DESCRI with cDESCRI,; 
                SIGLA_ with cSIGLA_,; 
                TIPO__ with cTIPO__,; 
                SELECT with cSELECT,; 
                ENDERE With cEndere,; 
                BAIRRO With cbairro,; 
                ESTADO With cEstado,; 
                CIDADE With cCidade,; 
                FONE__ With cFone__,; 
                E_MAIL With cE_Mail,; 
                CGCMF_ With cCgcMf_,; 
                CPF___ With cCPF___,; 
                CODCEP With cCodCep,; 
                FORM01 With nForm01,; 
                FORM02 With nForm02,; 
                FORM03 With nForm03,; 
                FORM04 With nForm04,; 
                FORM05 With nForm05,; 
                FORM06 With nForm06,; 
                FORM07 With nForm07,; 
                FORM08 With nForm08,; 
                FORM09 With nForm09,; 
                FORM10 With nForm10,; 
                MINI01 With nMIni01,; 
                MINI02 With nMIni02,; 
                MINI03 With nMIni03,; 
                MINI04 With nMIni04,; 
                MINI05 With nMIni05,; 
                MINI06 With nMIni06,; 
                MINI07 With nMIni07,; 
                MINI08 With nMIni08,; 
                MINI09 With nMIni09,; 
                MINI10 With nMIni10,; 
                MFIM01 With nMFIM01,; 
                MFIM02 With nMFIM02,; 
                MFIM03 With nMFIM03,; 
                MFIM04 With nMFIM04,; 
                MFIM05 With nMFIM05,; 
                MFIM06 With nMFIM06,; 
                MFIM07 With nMFIM07,; 
                MFIM08 With nMFIM08,; 
                MFIM09 With nMFIM09,; 
                MFIM10 With nMFIM10 
        cDESCRI:= Space( 45 ) 
        nCOMIVT:= 0 
        cTIPO__:= " " 
        cSIGLA_:= "  " 
        cSELECT:= "Nao" 
        cEndere:= Space( 40 ) 
        cBairro:= Space( 30 ) 
        cCidade:= Space( 20 ) 
        cEstado:= Space( 2 ) 
        cCodCep:= Space( 8 ) 
        cCgcMF_:= Space( 14 ) 
        cCPF___:= Space( 11 ) 
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
 
Static Function ExibeFormula( nFormula, nLin, nCol ) 
 
 
 
 
Static Function ExibeMes( nMes, nLin, nCol ) 
    IF nMes > 0 .AND. nMes <= 12 
       @ nLin, nCol + 5 Say PAD( Mes( nMes ), 10 ) 
    ELSE 
       @ nLin, nCol + 5 Say Space( 10 ) 
       IF nMes <> 0 
          Return .F. 
       ENDIF 
    ENDIF 
    Return .T. 
 
 
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
   mensagem("Vendedor ja cadastrado. Pressione [ENTER] para continuar...",1) 
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
   mensagem("Vendedor ja cadastrado. Pressione qualquer tecla p/ continuar...",1) 
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
@ 04,03 say "Sigla......: [  ]" 
@ 05,03 Say "Endereco...: [" + Space( Len( ENDERE ) ) + "]" 
@ 06,03 Say "Bairro.....: [" + Space( Len( BAIRRO ) ) + "]" 
@ 07,03 Say "Cidade.....: [" + Space( Len( CIDADE ) ) + "]" 
@ 07,45 Say "Estado: [  ]" 
@ 08,03 Say "Cep........: [     -   ]" 
@ 08,45 Say "Fone..: [    -    .    ]" 
@ 09,03 Say "CGC/MF.....: [  .   .   /    -  ]" 
@ 10,03 Say "CPF........: [   .   .   -  ]" 
@ 11,03 say "Tipo.......: [ ]" 
@ 12,03 Say "E-Mail.....: [" + Space( LEN( E_Mail ) ) + "]" 
SetColor( cCor ) 
return nil 
 
Static Function ExibeDados() 
local cCor:= SetColor() 
setcolor( _COR_GET_CURSOR ) 
@ 02,17 say StrZero( CODIGO, 3, 0 ) 
@ 03,17 say DESCRI 
@ 04,17 say SIGLA_ 
@ 05,17 Say ENDERE 
@ 06,17 Say BAIRRO 
@ 07,17 Say CIDADE 
@ 07,54 Say ESTADO 
@ 08,17 Say Tran( CODCEP, "@R 99999-999" ) 
@ 08,54 Say Tran( FONE__, "@R 9999-9999.9999" ) 
@ 09,17 Say Tran( CGCMF_, "@R 99.999.999/9999-99" ) 
@ 10,17 Say Tran( CPF___, "@R 999.999.999-99" ) 
@ 11,17 Say TIPO__ 
@ 12,17 Say E_Mail 
SetColor( cCor ) 
Return Nil 
 
/* 
* Funcao      - VENSELECIONA 
* Finalidade  - Selecao de vendadores a partir de outros modulos. 
* Programador - Valmor Pereira Flores 
* Data        - 
* Atualizacao - 
*/ 
func VenSeleciona( VENCOD, TIPO, cVendedor ) 
loca nAREA:=select(), nORDEM:=indexord() 
loca cTELA:=screensave(00,00,nMAXLIN,nMAXCOL), cCOR:=setcolor(), nCURSOR:=setcursor(), oVEN, TECLA 
loca mBUSCA 
priv nORDEMG:=1 
dbselectar(_COD_VENDEDOR) 
if TIPO=1 
   set filter to TIPO__="I"   // Somente vendedores internos. 
elseif TIPO=2 
   set filter to TIPO__="E"   // Somente vendedores externos. 
elseif TIPO=0 
   set filter to              // Todos os vendedores. 
endif 
if dbseek(VENCOD) .OR. VENCOD=0 
   if TIPO=1              && ***** INTERNO ****** 
      cISIGLA:=SIGLA_ 
      nICVV__:=COMIVV     // Comissao s/ vendas a vista. 
      nICVP__:=COMIVP     // Comissao s/ vendas a prazo. 
   elseif TIPO=2          && ***** EXTERNO ****** 
      cESIGLA:=SIGLA_ 
      nECVV__:=COMIVV     // Comissao s/ vendas a vista. 
      nECVP__:=COMIVP     // Comissao s/ vendas a prazo. 
   elseif TIPO=0          && ***** PRODUCAO ***** 
      cMSIGLA:=SIGLA_ 
      nMCVV__:=COMIVV     // Comissao s/ vendas a vista. 
      nMCVP__:=COMIVP     // Comissao s/ vendas a prazo. 
   endif 
   IF VenCod == 0 
      Aviso( "Campo vendedor nao foi preenchido.", 24 / 2 ) 
      Inkey(3) 
      ScreenRest( cTela ) 
   ENDIF 
   cVendedor:= PAD( LEFT( DESCRI, AT( " ", DESCRI ) ), 20 ) 
   dbselectar(nAREA) 
   dbSetorder( nOrdem ) 
   return(.t.) 
endif 
dbgotop() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
usermodulo(" Selecao de vendedores ") 
setcursor(0) 
setcolor( _COR_BROWSE ) 
vpbox(05,15,20,76," Vendedores ", _COR_BROW_BOX ) 
mensagem("Para selecionar pressione [ENTER] com o cursor sobre o vendedor.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [F2]Pesquisa [F3]Codigo [F4]Nome [ESC]Retorna") 
DBLeOrdem() 
oVEN:=tbrowsedb(06,16,19,75) 
oVEN:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" => "+DESCRI+"  "+SIGLA_+" "+if(TIPO__="E","Externo  ","Interno  ")})) 
oVEN:AUTOLITE:=.f. 
oVEN:dehilite() 
whil .t. 
   oVEN:colorrect({oVEN:ROWPOS,1,oVEN:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oVEN:stabilize() 
   enddo 
   TECLA:=inkey(0) 
   if TECLA=K_ESC 
      Set Filter To 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oVEN:up() 
      case TECLA==K_LEFT       ;oVEN:up() 
      case TECLA==K_RIGHT      ;oVEN:down() 
      case TECLA==K_DOWN       ;oVEN:down() 
      case TECLA==K_PGUP       ;oVEN:pageup() 
      case TECLA==K_PGDN       ;oVEN:pagedown() 
      case TECLA==K_END        ;oVEN:gotop() 
      case TECLA==K_HOME       ;oVEN:gobottom() 
      case TECLA==K_F2         ;DBMudaOrdem( 1, oVen ) 
      case TECLA==K_F3         ;DBMudaOrdem( 2, oVen ) 
      case DBPesquisa( TECLA, oVen ) 
      case TECLA==K_ENTER      ;VENCOD:=CODIGO 
           if TIPO=1              && ***** INTERNO ****** 
              cISIGLA:=SIGLA_ 
              nICVV__:=COMIVV     // Comissao s/ vendas a vista. 
              nICVP__:=COMIVP     // Comissao s/ vendas a prazo. 
           elseif TIPO=2          && ***** EXTERNO ****** 
              cISIGLA:=SIGLA_ 
              nECVV__:=COMIVV     // Comissao s/ vendas a vista. 
              nECVP__:=COMIVP     // Comissao s/ vendas a prazo. 
           elseif TIPO=0          && ***** PRODUCAO ***** 
              cMSIGLA:=SIGLA_ 
              nMCVV__:=COMIVV     // Comissao s/ vendas a vista. 
              nMCVP__:=COMIVP     // Comissao s/ vendas a prazo. 
           endif 
           cVendedor:= PAD( LEFT( DESCRI, AT( " ", DESCRI ) ), 20 ) 
           Set Filter To 
           exit 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oVEN:refreshcurrent() 
   oVEN:stabilize() 
enddo 
dbselectar(nAREA) 
dbsetorder(nORDEM) 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(if(TECLA==K_ENTER,.T.,.F.)) 
 
 
