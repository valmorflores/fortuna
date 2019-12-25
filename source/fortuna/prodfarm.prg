// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
#include "formatos.ch" 
 
/* 
* Modulo      - PRODFARM 
* Descricao   - Produtos (Materia Prima) 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 09/Novembro/1994 
*/ 
#ifdef HARBOUR
  function prodfarm()
#endif

loca cTELA:=zoom(04,44,09,62), cCOR:=setcolor(), nOPCAO:=0 
 
Public smPG:={18,nMAXLIN-(18+3),"MPRINCLUSA","MPRALTERA","mpraltera()","mprmostra()",; 
       "'  '+CODIGO+' => '+DESCRI+'          '"} 
 
Public smBUSCA:={{" 1 Cod. Mat. Prima    ","Pesquisa pelo codigo da materia prima."},; 
                 {" 2 Nome Materia Prima ","Pesquisa pelo nome da materia prima."}} 
 
vpbox(04,44,09,62) 
whil .t. 
   mensagem("") 
   aadd(MENULIST,swmenunew(05,45," 1 Inclusao     ",2,COR[11],; 
        "Inclusao de Produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(06,45," 2 Alteracao    ",2,COR[11],; 
        "Alteracao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(07,45," 3 Exclusao     ",2,COR[11],; 
        "Exclusao de produtos.",,,COR[6],.T.)) 
   aadd(MENULIST,swmenunew(08,45," 0 Retorna      ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   swMenu(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=4; exit 
      case nOPCAO=1; mprinclusao() 
      case nOPCAO=2; mpralteracao() 
      case nOPCAO=3; mprexclusao() 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
/* 
* 
*      Modulo - VPC21110 
*  Finalidade - MATERIA PRIMA 
* Programador - Valmor Pereira Flores 
*        Data - 10/Novembro/1994 
* Atualizacao - 05/Dezembro/1995 
* 
*/ 
STATIC FUNC mprinclusao() 
 
  //* VARIAVEIS REFERENTES AO MODULO ANTERIOR *// 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor() 
 
  //* VARIAVEIS REFERENTES AO BANCO DE DADOS *// 
  Local cGrupo_:= Space( 3 ), nReg:= 0 
  loca cORIGEM:=spac(3)                   && Origem 
  loca cUNIDAD:=spac(2)                   && Unidade 
  loca nQTDPES:=0                         && Quantidade (Peso p/ unidade) 
  loca nESTMIN:=0                         && Estoque minimo 
  loca nESTMAX:=0                         && Estoque maximo 
  loca nPRECOV:=0                         && Preco 
  loca nICMCOD:=0                         && Codigo tributo ICMs 
  loca nIPICOD:=0                         &&    "      "    IPI 
  loca nCLAFIS:=0                         && Classificacao fiscal 
  loca nCLASV_:=0                         && Classificacao de venda 
  loca cFORNEC:="N"                       && Conf. de uso p/ PRECOS x FORN. 
  loca cINDICE:=""                        && Codigo p/ organizacao 
  loca nCODFOR:=0                         && Fornecedor 
  loca nIPI___:=0                         && Vlr. p/ calculo do IPI. 
  loca cTELAR, cCORR 
  loca cCODFAB:=spac(13) 
  LOCA nROW:=1 
  loca nPercPV:=0 
  LOCA nPercDC:=0 
  LOCA nPrecoD:=0 
  LOCA nPosFor:=0 
  LOCA nICM___:=0, nSaldo_:= 0 
 
  //* PRECOSxFORNECEDOR *// 
  loca oTAB                               && Objeto tbrowse. 
  loca aPRECOS:={}                        && {Cod.Fornec,Nome,Preco}. 
  loca cSTRING                            && Var. utilizada no browse precos. 
  loca nTECLA                             && Var. contr. teclado no GET. 
  loca TECLA                              && Var. contr. teclado no BROWSE. 
  loca xCOR, nCT 
  loca nPrecoCompra:= 0 
 
  Local cCODIGO:=spac(12)                  && Codigo do produto. 
  Local cDESCRI:=spac(_ESP_DESCRICAO) 
 
  priv nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
  priv aTELA1                             && Var c/a tela limpa p/ PESQUISADBF. 
 
  //* MASCARA C/ INFORMACOES P/ APRESENTACAO DE PRODUTO *// 
  Priv bMASCARA:="' ' + Tran( Codigo, '@R XXX-XXXX' )+'  '+ CodFab + ' ' + Descri + Space( 6 ) " 
 
  VPSet( 1, .T. ) 
 
  //* ABERTURA DO ARQUIVO DE ORIGENS *// 
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
  if !fdbusevpb(_COD_PRECOXFORN) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de precos x fornecedores...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
 
  //* ABERTURA DO ARQUIVO DE CLASSIFICACAO FISCAL *// 
  if !file(_VPB_CLASFISCAL) 
     mensagem("Arquivo de clas. fiscal nao encontrado,"+; 
              " pressione ENTER p/ continuar...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !fdbusevpb(_COD_CLASFISCAL,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_CLASFISCAL)+".",24/2) 
     mensagem("Erro na abertura do arq. de classificacao fiscal...") 
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
 
  /* Modulo de usu�rio */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo(" Cadastro de Materia Prima ") 
 
  /* Box do browse */ 
  VPBox( 1, 0, 24 - 2, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
 
  /* Box da Edicao */ 
  VPbox( 1, 0, 18, 79, , _COR_GET_BOX, .F., .F., _COR_GET_TITULO  ) 
 
 
 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
 
  whil .T. 
 
     dbselectar(_COD_MPRIMA) 
 
     cCodigo:="0000" 
     cGrupo_:=Space( 3 ) 
 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,03 Say "Codigo..............:" Get cGrupo_ Pict "999" Valid Grupo( cGrupo_, @cCodigo ) 
     @ 02,30 Say "-" 
     @ 02,31                             Get cCodigo Pict "9999" Valid Codigo( @cCodigo, GetList ) when mensagem("Digite o codigo para produto.") 
     @ 03,03 Say "Codigo de Fabrica...:" Get cCodFab VALID VerCodFab( cCodFab )                                              when mensagem("Digite o codigo de fabrica do produto.") 
     @ 04,03 Say "Descri��o do produto:" Get cDescri pict "@!"                                     when mensagem("Digite a descricao do produto.") 
     @ 05,03 Say "Origem/Fabricante...:" Get cOrigem pict "@!" valid oseleciona(@cORIGEM)          when mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
     @ 06,03 Say "Unidade de Medida...:" Get cUnidad Pict "!!" 
     @ 07,03 Say "Preco de venda......:" Get nPrecoV pict "@E 999,999,999.999"                     when mensagem("Digite o preco de venda do produto.") 
     @ 08,03 Say "���������������������������������������Ŀ" 
     @ 09,03 Say "� SALDO ATUAL       �                   �" 
     @ 10,03 Say "�����������������������������������������" 
     @ 09,25 Get nSaldo_ Pict "@R 9,999,999.999" 
     @ 11,03 Say "Percentual Desconto.:" Get nPercDC Pict "@e 9,999.999"                           when Mensagem("Digite o percentual de desconto.") 
     @ 12,03 Say "% p/ c�lculo do ICMs:" Get nICM___ pict "999.99"                                 when mensagem("Digite o percentual p/ calculo do ICMs.") 
     Read 
     IF LastKey() == K_ESC 
        EXIT 
     ENDIF 
     dbselectar(_COD_MPRIMA) 
     cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
     if confirma(16,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento do produto.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        Aviso(" Aguarde! Gravando... ", 24 / 2 ) 
        Mensagem("Gravando arquivo de produtos...",1) 
        if buscanet(5,{|| dbappend(), !neterr()}) 
           cIndice:= cGrupo_ + cCodigo 
           cCodRed:= cCodigo 
           cCodigo:= cIndice 
           repl CODIGO with cCODIGO, CODFAB with cCODFAB,; 
                DESCRI with cDESCRI, INDICE with cINDICE,; 
                MPRIMA with "S",     UNIDAD with cUNIDAD,; 
                QTDPES with nQTDPES, ESTMIN with nESTMIN,; 
                ESTMAX with nESTMAX,; 
                PRECOV with nPRECOV, ICMCOD with nICMCOD,; 
                IPICOD with nIPICOD, CLAFIS with nCLAFIS,; 
                CLASV_ with nCLASV_, ORIGEM with cORIGEM,; 
                ASSOC_ with "S",; 
                CODRED with cCODRED, IPI___ with nIPI___,; 
                CODFOR with nCODFOR, PERCPV with nPercPV,; 
                ICM___ with nICM___, PERCDC with nPercDC,; 
                PRECOD with nPRECOD,; 
                SALDO_ With nSaldo_ 
 
           mensagem("Gravando arquivo de precos x fornecedores...",1) 
           dbselectar(_COD_PRECOXFORN) 
 
           if buscanet(5,{|| dbappend(), !neterr()}) 
              repl CPROD_ with cINDICE, CODFOR with nCodFor,; 
                   VALOR_ with nPrecoCompra 
           endif 
 
           /* estoque */ 
           DBSelectAr( _COD_ESTOQUE ) 
           DBAppend() 
           Replace CPROD_ With cIndice,; 
                   CODIGO With 0,; 
                   ENTSAI With "+",; 
                   QUANT_ With nSaldo_,; 
                   DOC___ With "SALDO INICIAL",; 
                   DATAMV With Date(),; 
                   RESPON With nGCodUser 
 
 
           Mensagem("Limpando os dados inutiliz�veis, aguarde...",1) 
 
           /* limpeza das variaveis para a reutiliza��o */ 
           cCodFab:= Space( 13 ) 
           cDescri:= Space( _ESP_DESCRICAO ) 
           cUnidad:= Space( 2 ) 
           nIPI___:= 0 
           nQtdPes:= 0 
           nEstMin:= 0 
           nEstMax:= 0 
           nPrecov:= 0 
           nClaFis:= 0 
           cINDICE:= "" 
           cCodigo:= StrZero( Val( cCodRed ) + 1, 4, 0 ) 
           nSaldo_:= 0 
 
 
           DBSELECTAR( _COD_MPRIMA ) 
 
           IF ++nReg >= 2 
              DBCloseArea() 
              FDBUseVpb( _COD_MPRIMA, 2 ) 
              nReg:= 0 
           ENDIF 
 
        endif 
 
     endif 
     ScreenRest( cTelaReserva ) 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  screenrest(cTELA) 
  setcursor(nCURSOR) 
  setcolor(cCOR) 
  //set key K_TAB to 
return nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � Grupo 
� Finalidade  � Pesquisar um grupo especifico. 
� Parametros  � cGrupo_ => Codigo do grupo 
� Retorno     � cCodigo => Codigo do produto a ser retornado. 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
STATIC FUNCtion Grupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt 
   DBSetOrder( 1 ) 
   DBSeek( cGrupo_, .T. ) 
   SetColor( _COR_BROW_LETRA ) 
   Scroll( 24 - 5, 1, 24 - 2, 79 - 1 ) 
   If cGrupo_ == Left( MPr->Indice, 3 ) 
      While cGrupo_ == Left( MPr->Indice, 3 ) 
         DBSkip() 
         IF EOF() 
            Exit 
         ENDIF 
      EndDo 
      DBSkip( -1 ) 
      cCodigo:= StrZero( Val( MPr->CodRed ) + 1, 4, 0 ) 
      For nCt:= 24 - 2 To 24 - 5 Step -1 
          If !Bof() 
             @ nCt,1 Say &bMascara 
             DBSkip( -1 ) 
          EndIf 
      Next 
   Else 
      cCodigo:= "0001" 
   EndIf 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � Codigo 
� Finalidade  � Pesquisar a existencia de um codigo igual ao digitado 
� Parametros  � cCodigo=> Codigo digitado pelo usu�rio 
� Retorno     � 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
STATIC FUNCtion Codigo( cCodigo, GetList ) 
   Local cGrupo_:= GetList[ 1 ]:VarGet() 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nOrdem:= IndexOrd() 
   DBSetOrder( 1 ) 
   If DBSeek( cGrupo_ + cCodigo ) 
      Ajuda("[Enter]Continua") 
      Aviso( "C�digo j� existente neste grupo...", 24 / 2 ) 
      Mensagem( "Pressione [Enter] para continuar a execucao..." ) 
      Pausa() 
      cCodigo:= StrZero( Val( MPr->CodRed ) + 1, 4, 0 ) 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Return( .F. ) 
   EndIf 
   DBSetOrder( nOrdem ) 
   Return( .T. ) 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � MPrExibeStru 
� Finalidade  � Exibir a extrutura dos dados na tela 
� Parametros  � Nenhum 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
STATIC FUNCtion MPrExibeStru() 
   Local cCor:= SetColor() 
   SetColor( _COR_GET_LETRA ) 
   @ 02,03 say "Codigo..............:" 
   @ 03,03 say "Codigo de Fabrica...:" 
   @ 04,03 say "Descri��o do produto:" 
   @ 05,03 say "Origem/Fabricante...:" 
   @ 06,03 say "Unidade de Medida...:" 
   @ 07,03 say "Medida Unit�ria.....:" 
   @ 08,03 say "Codigo cfe tabela A.:" 
   @ 09,03 say "Codigo cfe tabela B.:" 
   @ 10,03 say "Classifica��o fiscal:" 
   @ 11,03 say "Estoque m�nimo......:" 
   @ 12,03 say "Estoque m�ximo......:" 
   @ 13,03 say "% p/ c�lculo do IPI.:" 
   @ 14,03 say "% p/ c�lculo do ICMs:" 
   @ 15,03 say "Fornecedor..........:" 
   @ 16,03 say "% s/ pre�o Compra...:" 
   @ 17,03 say "Pre�o de Compra.....:" 
   @ 14,40 say "Preco de venda......:" 
   @ 15,40 SAY "Percentual Desconto.:" 
   @ 16,40 SAY "Preco Liquido.......:" 
   SetColor( cCor ) 
Return( .T. ) 
 
/***** 
�������������Ŀ 
� Funcao      � MPRMostra 
� Finalidade  � Exibir os dados dos produtos 
� Parametros  � Nenhum 
� Retorno     � Nenhum 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
STATIC FUNCtion MPRMostra() 
   Local cCor:= SetColor() 
   SetColor( _COR_GET_LETRA ) 
   @ 02,25 Say "[" + Left( MPr->Indice, 3 ) + "]-[" + AllTrim( MPr->CodRed ) + "]" 
   @ 03,25 Say "[" + MPr->CodFab + "]" 
   @ 04,25 Say "[" + MPr->Descri + "]" 
   @ 05,25 Say "[" + MPr->Origem + "]" 
   @ 06,25 Say "[" + MPr->Unidad + "]" 
   @ 07,25 Say "[" + Tran( MPr->QtdPes, "@E 999,999.9999" ) + "]" 
   @ 08,25 Say "[" + Str( MPr->IcmCod, 1, 0 ) + "]" 
   @ 09,25 Say "[" + Str( MPr->IPICod, 1, 0 ) + "]" 
   @ 10,25 Say "[" + Tran( MPr->ClaFis, "999" ) + "]" 
   @ 11,25 Say "[" + Tran( MPr->EstMin, "@E 99,999.999" ) + "]" 
   @ 12,25 Say "[" + Tran( MPr->EstMax, "@E 99,999.999" ) + "]" 
   @ 13,25 Say "[" + Tran( MPr->IPI___, "999.99" ) + "]" 
   @ 14,25 Say "[" + Tran( MPr->ICM___, "999.99" ) + "]" 
   @ 15,25 Say "[" + Tran( MPr->CodFor, "999" ) + "]" 
   @ 16,25 Say "[" + Tran( MPr->PercPv, "@E 9,999.999" ) + "]" 
   @ 14,62 Say "[" + Tran( MPr->Precov, "@E 99,999,999.999" ) + "]" 
   @ 15,62 Say "[" + Tran( MPr->PercDc, "@E 99,999.99" ) + "]" 
   @ 16,62 Say "[" + Tran( MPr->PrecoD, "@E 99,999,999.999" ) + "]" 
   /* Preco de compra */ 
   PxF->( DBSetOrder( 1 ) ); PxF->( DBSeek( Mpr->Indice ) ) 
   @ 17,25 Say "[" + Tran( PxF->Valor_, "@E 999,999,999.999" ) + "]" 
   setcolor(cCOR) 
return(.t.) 
 
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
STATIC FUNC mascstr(VDM,nCOD) 
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
STATIC FUNC digitover(VDM,MASCARA) 
  loca cTELA:=screensave(00,00,24,79) 
  Loca cCor:= SetColor() 
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
 
//  if at("V",MASCARA)=0                    && Ret. .T. se usuario nao usa 
//     return(.T.)                          && digito verificador no codigo. 
//  endif 
 
  //* PESQUISA PARA LOCALIZAR ESPACOS EM BRANCO NA DIGITACAO *// 
  for nCT:=1 to len(VDM) 
      if substr(VDM,nCT,1)=" " .AND. nCT<len(VDM)-1 
         mensagem("Atencao este dado devera ser completo.",1) 
         pausa() 
         SetColor( cCor ) 
         screenrest(cTELA) 
         return(.F.) 
      endif 
  next 
 
  cINDICE:=substr(VDM,_PIGRUPO,_QTGRUPO)+; 
           substr(VDM,_PICODIG,_QTCODIG)  && 
                                          && Retorna a String de pesquisa. 
  cINDICE:=cINDICE+space(12-len(cINDICE)) && 
 
  cCODRED:=substr(VDM,_PICODIG,_QTCODIG)  && Codigo reduzido 
 
  cCODRED:=cCODRED+space(12-len(cCODRED)) && Codigo reduzido 
 
  dbSelectAr( _COD_MPRIMA ) 
  dbSetOrder( 2 )                         && Ordem de indice (Codigo-Geral) 
 
  If DBSeek( cIndice ) 
     Mensagem( "Atencao, ja existe produto com este numero neste grupo.", 1 ) 
     DBSetOrder( 1 ) 
     ExibeDbf( cCodRed ) 
     Pausa() 
     SetColor( cCor ) 
     ScreenRest(cTELA) 
     Return(.F.) 
  EndIf 
 
  dbsetorder(1) 
 
// VDM:=substr(VDM,1,len(VDM)-1) 
// Livra var. VDM do ultimo digito. 
 
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
//  nVERIFICADOR+=val(cGRUPO)               && Soma digito verificador+grupo. 
  cVERIFICADOR:=right(strzero(nVERIFICADOR,20,00),1) 
 
  //* PREPARA VDM PARA RETORNO *// 
  //VDM:=alltrim(VDM+cVERIFICADOR) 
 
  //* APRESENTACAO DAS INFORMACOES SOBRE O CODIGO DO PRODUTO *// 
  vpbox( 5, 44, 10, 75, "Informacoes", _COR_ALERTA_BOX, .T., .F., _COR_ALERTA_TITULO ) 
  SetColor( _COR_ALERTA_LETRA ) 
  @ 06,45 say "Codigo Principal > "+alltrim(VDM) 
  @ 07,45 say "Grupo ===========> "+cGRUPO 
  @ 08,45 say "Numero ==========> "+cCODIG 
  @ 09,45 say "Digito Verif. ===> "+cVERIFICADOR 
 
  SetColor( cCor ) 
 
return(.T.) 
 
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
stat func exibedbf( cPCODIGO ) 
loca nLIN:=18, nREGISTROS 
loca cCOR:=setcolor(), nCOL:=2, nCT 
nREGISTROS:=24-(nLIN+4) 
if cCODIGO="            " 
   dbgotop() 
else 
   dbgotop() 
   if nORDEMG=1 
      dbseek(alltrim(cCODIGO)) 
   elseif nORDEMG=2 
      dbseek(cDESCRI) 
   endif 
endif 
dbskip(-nREGISTROS) 
setcolor( COR[21] ) 
scroll( nLIN+1, nCOL, 24-2, 79-2 ) 
for nCT:=0 to nREGISTROS 
    If nORDEMG=1 
       if cPCODIGO<>NIL 
          setcolor(if(alltrim(CODRED)=alltrim(cPCODIGO),COR[22],COR[21])) 
       endif 
    ElseIf nORDEMG=2 
       SetColor( if( Descri = cDescri, Cor[22], Cor[21] ) ) 
    EndIf 
    @ ++nLin, nCol Say Space( 75 ) 
    @ nLin, nCol Say &bMascara 
    DBSkip( +1 ) 
    If EOF(); Exit; EndIf 
next 
setcolor(cCOR) 
return(.t.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � PesquisaDBF 
� Finalidade  � Browse de produtos para altera��o ou exclus�o. 
� Parametros  � nModo=> Modo: 1=> Altera��o / 2=> Exclus�o 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 04/Dezembro/1995 
��������������� 
*/ 
Static Function PesquisaDBF( nModo ) 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local oTb, nLin:= 18 
   Local nRegistros:= 24 - ( nLIN + 4 ) 
   Local aTela, cCodPesq, nTecla 
   DBSelectAr( _COD_MPRIMA ) 
   If AllTrim( cCODIGO ) == "" 
      DBGoTop() 
   Else 
      cCodPesq:= SubStr( cCodigo, _PIGRUPO, _QTGRUPO ) + ; 
                 SubStr( cCodigo, _PICODIG, _QTCODIG ) 
      if nOrdemG==1 
         Locate for alltrim(INDICE)=alltrim(cCODPESQ) 
         DBSkip( -nRegistros ) 
      elseif nORDEMG=2 
         locate for DESCRI=cDESCRI 
      endif 
   Endif 
   SetCursor( 0 ) 
   Setcolor( _COR_BROWSE ) 
   VPBox( nLin, 0, 24-2, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
   VPBox( 1, 0, nLin, 79, , _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
   MPRExibeStru() 
 
   DBLeOrdem() 
 
   If ValType( nModo )=="C" 
      nModo:= if( nModo=="MPRINCLUSA" .OR. nModo=="MPRALTERA", 1, nModo ) 
   EndIf 
   Mensagem( if( nModo==1, "Pressione [TAB] para efetuar alteracoes.",; 
                           "Pressione [TAB] para excluir." ) ) 
   Ajuda( "["+_SETAS+"][PgUp][PgDn]Move [Digitos]Pesquisa [F3]Codigo [F4]Nome [F5]C.Fabrica [TAB]Executa") 
   oTb:=tbrowsedb(nLin + 1, 1, 24 - 3, 79 - 1 ) 
   oTb:addcolumn(tbcolumnnew(,{|| &bMASCARA })) 
   oTb:AUTOLITE:=.f. 
   oTb:dehilite() 
   whil .t. 
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTb:stabilize() 
      enddo 
      mprmostra() 
      cCODIGO=alltrim(CODIGO) 
      nTecla:=inkey(0) 
      nModo:=if(nModo=NIL,1,nModo) 
      if valtype(nModo)=="C" 
         nModo=if(nModo="MPRINCLUSA" .OR. nModo="MPRALTERA",1,nModo) 
      endif 
      if nTecla=K_ESC 
         exit 
      endif 
      DO CASE 
         CASE nTecla==K_UP         ;oTb:up() 
         CASE nTecla==K_LEFT       ;oTb:up() 
         CASE nTecla==K_RIGHT      ;oTb:down() 
         CASE nTecla==K_DOWN       ;oTb:down() 
         CASE nTecla==K_PGUP       ;oTb:pageup() 
         CASE nTecla==K_PGDN       ;oTb:pagedown() 
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         CASE nTecla==K_F3         ;DBMudaOrdem( 1, oTb ) 
         CASE nTecla==K_F4         ;DBMudaOrdem( 4, oTb ) 
         CASE nTecla==K_F5         ;DBMudaOrdem( 2, oTb ) 
         CASE DBPesquisa( nTecla, oTb ) 
         CASE nTecla==K_TAB 
              If nModo == 1 
                 If LastRec()>0 .AND. MPr->Codigo <> Space( 12 ) 
                    MPRAltera() 
                 EndIf 
              ElseIf nModo == 2 
                 if(lastrec()>0 .AND. val(CODIGO)<>0,exclui(oTb),nil) 
              EndIf 
         OtherWise                ;tone(125); tone(300) 
      ENDCASE 
      oTb:refreshcurrent() 
      oTb:stabilize() 
   enddo 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
return nil 
 
/***** 
�������������Ŀ 
� Funcao      � MPRAltera 
� Finalidade  � Alterar o cadastro de materia-prima 
� Parametros  � Nenhum 
� Retorno     � Nenhum 
� Programador � Valmor Pereira Flores 
� Data        � 05/Dezembro/1995 
��������������� 
*/ 
Static Function MPRAltera() 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local GetList:= {} 
   Local cCodigo:= MPr->Codigo, cDescri:= MPr->Descri,; 
         cCodFab:= MPr->CodFab, cOrigem:= MPr->Origem,; 
         cUnidad:= MPr->Unidad, nQtdPes:= MPr->QtdPes,; 
         nPrecov:= MPr->Precov, nICMCod:= MPr->IcmCod,; 
         nIPICod:= MPr->IpiCod, nClaFis:= MPr->ClaFis,; 
         nClasV_:= MPr->Clasv_, nEstMin:= MPr->EstMin,; 
         nEstMax:= MPr->EstMax, nIPI___:= MPr->ipi___,; 
         nCodFor:= MPr->CodFor, nPercpv:= MPr->PercPv,; 
         nPercdc:= MPr->PercDc, nIcm___:= MPr->Icm___,; 
         nPerRed:= MPr->PerRed 
 
   SetCursor( 1 ) 
   SetColor( _COR_GET_EDICAO ) 
 
   @ 03,03 say "Codigo de Fabrica...:" get cCODFAB                                         when mensagem("Digite o codigo de fabrica do produto.") 
   @ 04,03 say "Descri��o do produto:" get cDESCRI pict "@!"                               when mensagem("Digite a descricao do produto.") 
   @ 05,03 say "Origem/Fabricante...:" get cORIGEM pict "@!" valid oseleciona(@cORIGEM)    when mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
   @ 06,03 say "Unidade de Medida...:" get cUNIDAD                                         when mensagem("Digite a unidade de medida do produto.") 
   @ 07,03 say "Medida Unit�ria.....:" get nQTDPES pict "@E 999,999.9999"                  when mensagem("Digite o peso, tamanho ou quantidade de pecas do produto.") 
   @ 08,03 say "Codigo cfe tabela A.:" get nICMCOD pict "9" valid classtrib(@nICMCOD,1)    when mensagem("Digite o codigo tributavel do produto p/ ICMs.") 
   @ 09,03 say "Codigo cfe tabela B.:" get nIPICOD pict "9" valid classtrib(@nIPICOD,2)    when mensagem("Digite o codigo de tributacao do IPI.") 
   @ 10,03 say "Classifica��o fiscal:" get nCLAFIS pict "999" valid verclasse(@nCLAFIS)    when mensagem("Digite o codigo de classificacao fiscal do produto.") 
   @ 11,03 say "Estoque m�nimo......:" get nESTMIN pict "@E 99,999.999"                    when mensagem("Digite a quantidade permitida para estoque minimo.") 
   @ 12,03 say "Estoque m�ximo......:" get nESTMAX pict "@E 99,999.999"                    when mensagem("Digite a quantidade valida para estoque maximo.") 
   @ 13,03 say "% p/ c�lculo do IPI.:" get nIPI___ pict "999.99"                           when mensagem("Digite o percentual p/ calculo do IPI.") 
   @ 14,03 say "% p/ c�lculo do ICMs:" get nICM___ pict "999.99"                           when mensagem("Digite o percentual p/ calculo do ICMs.") 
   @ 15,03 say "Fornecedor..........:" get nCODFOR pict "999" valid forseleciona(@nCODFOR) when mensagem("Digite o codigo do fornecedor.") 
   @ 16,03 say "% s/ pre�o Compra...:" get nPERCPV pict "@E 9,999.999"                     when mensagem("Digite o percentual p/ venda sobre o preco de compra.") 
   Read 
   if LastKey() <> K_ESC 
      nPerRed:= IcmReducao( nIpiCod ) 
      PxF->( DBSetOrder( 1 ) ) 
      PxF->( DBSeek( MPr->Indice ) ) 
      nPrecoCompra:= PxF->Valor_ 
      @ 17,03 say "Pre�o de Compra.....:" Get nPrecoCompra Pict "@E 999,999,999.999" 
      Read 
      if nPercPv <> 0 
         nPrecov:= nPrecoCompra + ( ( nPrecoCompra * nPercpv ) / 100 ) 
      endif 
      @ 14,40 say "Preco de venda......:" get nPRECOV pict "@E 999,999,999.999" when mensagem("Digite o preco de venda do produto.") 
      @ 15,40 SAY "Percentual Desconto.:" get nPercDC Pict "@e 9,999.999" when Mensagem("Digite o percentual de desconto.") 
      Read 
      nPrecoD:= nPrecov - ( nPrecoV * nPercDC / 100 ) 
      @ 16,40 SAY "Preco Liquido.......:" + Tran( nPrecoD, "@e 9,999,999,999.999" ) 
      DBSelectAr(_COD_MPRIMA) 
      if confirma(16,63,"Confirma?",; 
         "Digite [S] para confirmar o cadastramento do produto.","S",; 
         COR[16]+","+COR[18]+",,,"+COR[17]) 
         cTELAR:=screensave(00,00,24,79) 
         aviso(" Aguarde! Gravando... ",24/2) 
         mensagem("Gravando arquivo de produtos...",1) 
         if netrlock(5) 
            cINDICE:=substr(cCODIGO,_PIGRUPO,_QTGRUPO)+; 
                     substr(cCODIGO,_PICODIG,_QTCODIG) 
            cCODRED:=substr(cCODIGO,_PICODIG,_QTCODIG) 
            repl CODFAB with cCODFAB,; 
                 DESCRI with cDESCRI,; 
                 MPRIMA with "S",     UNIDAD with cUNIDAD,; 
                 QTDPES with nQTDPES, ESTMIN with nESTMIN,; 
                 ESTMAX with nESTMAX,; 
                 PRECOV with nPRECOV, ICMCOD with nICMCOD,; 
                 IPICOD with nIPICOD, CLAFIS with nCLAFIS,; 
                 CLASV_ with nCLASV_, ORIGEM with cORIGEM,; 
                 ASSOC_ with cASSOCIAR,; 
                 IPI___ with nIPI___,; 
                 ICM___ with nICM___, CODFOR with nCODFOR,; 
                 PERCPV with nPercPV, PERCDC with nPercDC,; 
                 PRECOD with nPRECOD, PERRED With nPerRed 
            setcolor(COR[21]) 
            mensagem("Limpando os dados inutilizaveis, aguarde...",1) 
            dbselectar(_COD_MPRIMA) 
            mensagem("Gravando arquivo de precos, aguarde...") 
            If PXF->( netrlock(5) ) 
               IF PXF->CPROD_ <> cCodigo 
                  PXF->( DBAppend() ) 
               ENDIF 
               REPLACE PXF->CProd_ with cCodigo,; 
                       PXF->VALOR_ with nPrecoCompra,; 
                       PXF->CODFOR with nCodFor,; 
                       PXF->PVELHO with PXF->VALOR_,; 
                       PXF->DATA__ with DATE() 
            Endif 
            DBUnlockAll() 
         Endif 
      Endif 
   Endif 
   ScreenRest( cTela ) 
   SetCursor( nCursor ) 
   SetColor( cCor ) 
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
  //set key K_TAB to 
  setcursor(1) 
  set(_SET_SOFTSEEK,.t.) 
  mensagem("") 
  ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
  vpbox(12,45,16,69," Pesquisa ",COR[20],.T.,.F.,COR[19]) 
  setcolor(COR[21]+","+COR[22]) 
  aadd(MENULIST,; 
  swmenunew(13,46,smBUSCA[1][1],2,COR[19],smBUSCA[1][2],,,COR[6],.T.)) 
  aadd(MENULIST,; 
  swmenunew(14,46,smBUSCA[2][1],2,COR[19],smBUSCA[2][2],,,COR[6],.T.)) 
  aadd(MENULIST,; 
  swmenunew(15,46," 0 Encerramento       ",2,COR[19],; 
     "Executa a finalizacao da rotina de pesquisa.",,,COR[6],.T.)) 
  swMenu(MENULIST,@nOPCAO); MENULIST:={} 
  ajuda("["+_SETAS+"]Movimenta [ENTER]Confirma [ESC]Cancela") 
  oPOBJ:gotop() 
  do case 
     case nOPCAO=1 
          cCOD:=strtran(cxMASCACOD,".","") 
          cCOD:=strtran(cCOD,"-","") 
          cCOD:=alltrim(cCOD) 
          cCOD:=strtran(cCOD,"9"," ") 
          vpbox(11,25,13,48,"",COR[20],.T.,.F.,COR[19]) 
          @ 12,26 say "C�digo " get cCOD pict "@R "+cxMASCACOD when; 
            mensagem("Digite o c�digo para pesquisa.") 
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
  //set key K_TAB to pesquisadbf(1) 
return nil 
 
/* 
* Funcao      - MPRALTERACAO 
* Finalidade  - Alteracao de dados dos produtos. 
* Data        - 
* Atualizacao - 
*/ 
STATIC FUNC mpralteracao 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca _cMRESER 
  priv aTELA1, aTELA 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  priv cCODIGO:=spac(12), cDESCRI:=SPACE( _ESP_DESCRICAO ), nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
  priv cMASCACOD 
  priv bMASCARA:="' '+tran(CODIGO,'@R '+cxMASCACOD)+'  '+CODFAB+' '+DESCRI+spac(6)" 
  priv cxORIGEM, cxMASCACOD, cxMASCQUAN, cxMASCPREC, nROW:=1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  usermodulo(" Alteracao de Produtos ") 
  if !file(_VPB_CONFIG) 
     mensagem("Arquivo de conf. inexistente, pressione [ENTER] p/ continuar.") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  else 
     if !fdbusevpb(_COD_CONFIG,2) 
        aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_CONFIG)+".",24/2) 
        mensagem("Erro na abertura do arquivo de configuracao...") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     endif 
  endif 
  locate for VARIAV="cMASCACOD" 
  cMASCACOD:=MASCAR 
  cVERIF_:=VERIF_ 
  locate for VARIAV="cMASCQUAN" 
  cMASCQUAN:=MASCAR 
  locate for VARIAV="cMASCPREC" 
  cMASCPREC:=MASCAR 
  locate for VARIAV="cORIGEM" 
  cxORIGEM:=QUEST_ 
  locate for VARIAV="cASSOCIAR" 
  cASSOCIAR:=QUEST_ 
  _cMRESER:=strtran(cMASCACOD,".","") 
  _cMRESER:=strtran(_cMRESER,"-","") 
  _cMRESER:=alltrim(_cMRESER) 
  _PIGRUPO:=at("G",_cMRESER) 
  _QTGRUPO:=StrVezes("G",_cMRESER) 
  _PICODIG:=at("N",_cMRESER) 
  _QTCODIG:=StrVezes("N",_cMRESER) 
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
  if !file(_VPB_PRECOXFORN) 
     mensagem("Criando arquivo de precos x fornecedores, aguarde...") 
     createvpb(_COD_PRECOXFORN) 
  endif 
  if !fdbusevpb(_COD_PRECOXFORN) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de precos x fornecedores...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !file(_VPB_CLASFISCAL) 
     mensagem("Arquivo de clas. fiscal nao encontrado,"+; 
              " pressione ENTER p/ continuar...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !fdbusevpb(_COD_CLASFISCAL,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_CLASFISCAL)+".",24/2) 
     mensagem("Erro na abertura do arq. de classificacao fiscal...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
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
  setcolor(COR[16]) 
  scroll(01,01,24-2,79-1) 
  aTELA1:=boxsave(01,01,10,79-1) 
  aTELA:=boxsave(01,01,24-2,79-1) 
  dbselectar(_COD_MPRIMA) 
  //* MONTAGEM DAS VARIAVEIS (MASCARAS) *// 
  cxMASCACOD:=mascstr(cMASCACOD,1) 
  cxMASCQUAN:=mascstr(cMASCQUAN,2) 
  cxMASCPREC:=mascstr(cMASCPREC,2) 
  cCODIGO:=strtran(cxMASCACOD,".","") 
  cCODIGO:=strtran(cCODIGO,"-","") 
  cCODIGO:=alltrim(cCODIGO) 
  cCODIGO:=strtran(cCODIGO,"9"," ") 
  whil lastkey()<>K_ESC 
     MPrExibeStru() 
     PesquisaDBF( 1 ) 
  enddo 
  //set key K_TAB to 
  dbunlockall() 
  FechaArquivos() 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
return nil 
 
/* 
* Funcao       - MPREXCLUSAO 
* Finalidade   - Executar a excluisao de produtos. 
* Programador  - Valmor Pereira Flores 
* Data         - 01/Novembro/1994 
* Atualizacao  - 
*/ 
STATIC FUNC mprexclusao 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca _cMRESER 
  priv aTELA1, aTELA 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  priv cCODIGO:=spac(12), cDESCRI:=spac( _ESP_DESCRICAO ), nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
  priv cMASCACOD 
  priv bMASCARA:="' '+tran(CODIGO,'@R '+cxMASCACOD)+'  '+CODFAB+' '+DESCRI+spac(6)" 
  priv cxORIGEM, cxMASCACOD, cxMASCQUAN, cxMASCPREC, nROW:=1 
  priv nORDEMG:=1, nCODIGO:=0, nDESCRI:=space(45), aTELA1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  usermodulo(" Exclusao de produtos ") 
  if !file(_VPB_CONFIG) 
     mensagem("Arquivo de conf. inexistente, pressione [ENTER] p/ continuar.") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  else 
     if !fdbusevpb(_COD_CONFIG,2) 
        aviso("ATENCAO! Verifique o arquivo "+alltrim(_VPB_CONFIG)+".",24/2) 
        mensagem("Erro na abertura do arquivo de configuracao...") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     endif 
  endif 
  locate for VARIAV="cMASCACOD" 
  cMASCACOD:=MASCAR 
  cVERIF_:=VERIF_ 
  locate for VARIAV="cMASCQUAN" 
  cMASCQUAN:=MASCAR 
  locate for VARIAV="cMASCPREC" 
  cMASCPREC:=MASCAR 
  locate for VARIAV="cORIGEM" 
  cxORIGEM:=QUEST_ 
  locate for VARIAV="cASSOCIAR" 
  cASSOCIAR:=QUEST_ 
  _cMRESER:=strtran(cMASCACOD,".","") 
  _cMRESER:=strtran(_cMRESER,"-","") 
  _cMRESER:=alltrim(_cMRESER) 
  _PIGRUPO:=at("G",_cMRESER) 
  _QTGRUPO:=StrVezes("G",_cMRESER) 
  _PICODIG:=at("N",_cMRESER) 
  _QTCODIG:=StrVezes("N",_cMRESER) 
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
  if !file(_VPB_PRECOXFORN) 
     mensagem("Criando arquivo de precos x fornecedores, aguarde...") 
     createvpb(_COD_PRECOXFORN) 
  endif 
  if !fdbusevpb(_COD_PRECOXFORN) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_FORNECEDOR)+".",24/2) 
     mensagem("Erro na abertura do arq. de precos x fornecedores...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !file(_VPB_CLASFISCAL) 
     mensagem("Arquivo de clas. fiscal nao encontrado,"+; 
              " pressione ENTER p/ continuar...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
  if !fdbusevpb(_COD_CLASFISCAL,2) 
     aviso("ATENCAO! Verifique o arquivo "+; 
     alltrim(_VPB_CLASFISCAL)+".",24/2) 
     mensagem("Erro na abertura do arq. de classificacao fiscal...") 
     pausa() 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
     return(NIL) 
  endif 
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
  //* MONTAGEM DAS VARIAVEIS (MASCARAS) *// 
  cxMASCACOD:=mascstr(cMASCACOD,1) 
  cxMASCQUAN:=mascstr(cMASCQUAN,2) 
  cxMASCPREC:=mascstr(cMASCPREC,2) 
  cCODIGO:=strtran(cxMASCACOD,".","") 
  cCODIGO:=strtran(cCODIGO,"-","") 
  cCODIGO:=alltrim(cCODIGO) 
  cCODIGO:=strtran(cCODIGO,"9"," ") 
  setcolor(COR[16]) 
  scroll(01,01,24-2,79-1) 
  aTELA1:=boxsave(01,01,10,79-1) 
  whil lastkey()<>K_ESC 
     ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [TAB]Exclui [ESC]Cancela") 
     MPrExibeStru() 
     pesquisadbf(2) 
  enddo 
  //set key K_TAB to 
  dbunlockall() 
  FechaArquivos() 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
return nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � ICMReducao 
� Finalidade  � Pegar o percentual de reducao na base de calculo do icms. 
� Parametros  � nCodigoTabelaB 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 08/Janeiro/1996 
��������������� 
*/ 
Static Function ICMReducao( nCodigoTabelaB ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nPerRed:= 0 
  If nCodigoTabelaB==1 
     VPBox( 10, 29, 14, 69, "Reducao de imposto", _COR_ALERTA_BOX, .T., .T., _COR_ALERTA_TITULO ) 
     SetColor( _COR_ALERTA_LETRA ) 
     @ 12, 32 Say "Percentual de Reducao:" Get nPerRed Pict "@E 999.99" When; 
       Mensagem("Digite o percentual de reducao de calculo do ICMs..." ) 
     Read 
  EndIf 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return( nPerRed ) 
 
FUNCTION VerCodFab( cCodFab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOrdem:= IndexOrd(), nArea:= Select() 
DBSelectAr( _COD_MPRIMA ) 
DBSetOrder( 4 ) 
IF DBSeek( cCodFab ) 
   IF ! VAL( cCodFab ) == 0 
        Aviso( "Ja existe produto cadastrado com este codigo... ", 12 ) 
        Pausa() 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        DBSelectAr( nArea ) 
        DBSetOrder( nOrdem ) 
        Return .F. 
   ENDIF 
ENDIF 
DBSelectAr( nArea ) 
DBSetOrder( nOrdem ) 
Return .T. 
