// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
#include "ptfuncs.ch" 
#include "formatos.ch" 
 
///////////////----------------------------------------------//////////////* 
*                                                                          * 
*               ATENCAO: MODULO PRINCIPAL E' VPC21110.PRG                  * 
*  Aqui estao contidas todas as funcoes de Inclusao / Exclusao / Alteracao * 
*     embora a rotina principal, de exibi��o de informacoes no browse      * 
*            esteja localizada no fonte principal VPC21110.prg             * 
*               ------------------------------------------                 * 
*                        VALMOR PEREIRA FLORES                             * 
*                                                                          * 
*////////////-----------------------------------------------//////////////// 
 
/* 
* 
*      Modulo - VPC21110 
*  Finalidade - MATERIA PRIMA 
* Programador - Valmor Pereira Flores 
*        Data - 10/Novembro/1994 
* Atualizacao - 05/Dezembro/1995 
*               29/Agosto/1999    - Pesquisa de duplicidade de EAN / Descricao 
*/ 
func mprinclusao() 
 
  //* VARIAVEIS REFERENTES AO MODULO ANTERIOR *// 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
       nCURSOR:=setcursor() 
 
  Local GetList:= {} 
 
  //* VARIAVEIS REFERENTES AO BANCO DE DADOS *// 
  Local aTabRed 
  Local cTabRed:= Space( 2 ) 
  Local cGrupo_:= Space( 3 ) 
  loca cORIGEM:=spac(3)                   && Origem 
  loca cUNIDAD:=spac(2)                   && Unidade 
  loca nQTDPES:=0                         && Quantidade (Peso p/ unidade) 
  loca nESTMIN:=0                         && Estoque minimo 
  loca nESTMAX:=0                         && Estoque maximo 
  loca nPRECOV:=0                         && Preco 
  loca nICMCOD:=0                         && Codigo tributo ICMs 
  loca nIPICOD:=0                         &&    "      "    IPI 
  loca nCLAFIS:=0                         && Classificacao fiscal 
  Local nMVAPer:= 0, nMVAVlr:= 0 
 
 
  //// Nova lei de situacao tributaria (09/08/2001) 
  Loca nSitT01:= 0 
  Loca nSitT02:= 0 

  Local nIPICMP:= 0
 
  loca nCLASV_:=0                         && Classificacao de venda 
  loca cFORNEC:="N"                       && Conf. de uso p/ PRECOS x FORN. 
  loca cINDICE:=""                        && Codigo p/ organizacao 
  loca nCODFOR:=0                         && Fornecedor 
  loca nIPI___:=0                         && Vlr. p/ calculo do IPI.
  local cClasse:= " "
  loca cTELAR, cCORR 
  loca cCODFAB:=spac(13) 
  LOCA nROW:=1 
  Local nQtdMin:= 0 
  Loca aDetalhe:= { Space(65), Space(65), Space(65) } 
  LOCA nPesoLi:= 0 
  LOCA nPesoBr:= 0 
  loca nPercPV:=0 
  LOCA nPercDC:=0 
  LOCA nPrecoD:=0 
  LOCA nPosFor:=0 
  LOCA nICM___:=0 
 
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
 
// ����������������������������������������������������������������������������� 
/* 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  cMASCACOD:=SWSet( _PRO_MASCACOD ) 
  _cMRESER:=strtran(cMASCACOD,".","") 
  _cMRESER:=strtran(_cMRESER,"-","") 
  _cMRESER:=alltrim(_cMRESER) 
  _PIGRUPO:=at("G",_cMRESER) 
  _QTGRUPO:=StrVezes("G",_cMRESER) 
  _PICODIG:=at("N",_cMRESER) 
  _QTCODIG:=StrVezes("N",_cMRESER) 
*/ 
// ����������������������������������������������������������������������������� 
 
  //* MASCARA C/ INFORMACOES P/ APRESENTACAO DE PRODUTO *// 
//Priv bMASCARA:="' ' + Tran( Codigo, '@R XXX-XXXX' )+'  '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 ) " 
  Priv bMASCARA:="' ' + SUBSTR( INDICE, 1, 3) + '-' + SUBSTR( INDICE, 4, 4) +'  '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 ) " 
 
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
 
  DBSelectAr( _COD_ORIGEM ) 
  DBSetOrder( 3 ) 
 
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
 
  /* Relaciona com arquivo de origem/fabricante */ 
  Set Relation To ORIGEM Into ORG 
 
  /* Modulo de usu�rio */ 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserModulo("Cadastro de Materia Prima") 
 
  /* Box do browse */ 
  VPBox( 1, 0, 24 - 2, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
 
  /* Box da Edicao */ 
  VPbox( 1, 0, 18, 79, , _COR_GET_BOX, .F., .F., _COR_GET_TITULO  ) 
 
  VPBox( 09, 43, 17, 77," P R E C O S ", _COR_GET_BOX, .F., .F., ,.F. ) 
 
 
//Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
 
  whil .T. 
 
     dbselectar(_COD_MPRIMA) 
 
     cCodigo:="0000" 
     cGrupo_:=Space( 3 ) 
 
     cSegura:= Space( 1 ) 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,03 Say "C�digo..............:" Get cGrupo_ Pict "999" Valid Grupo( @cGrupo_, @cCodigo ) 
     @ 02,30 Say "-" 
     @ 02,31 Get cCodigo Pict "9999" Valid Codigo( @cCodigo, GetList )                       when mensagem("Digite o codigo para produto ou [ENTER] ara continuar.")
     @ 02,50 Say "Classe/Giro:" Get cClasse Valid ClasseMargem( cGrupo_, cClasse, @nPercPv ) when mensagem( "Digite a classe do produto quanto ao giro [ A / B / C / D ]" )
     @ 03,03 Say "C�digo de F�brica...:" Get cCODFAB Valid BuscaCodFab( @cCodFab, GetList )  when mensagem("Digite o C�digo de F�brica do produto.") 
     @ 04,03 Say "Descri��o do produto:" Get cDESCRI Valid BuscaDescri( @cDescri ) when mensagem("Digite a Descri��o do produto.") 
     @ 05,03 Say "Origem/Fabricante...:" Get cORIGEM pict "@!" valid oseleciona(@cORIGEM)    when mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
     @ 06,03 Say "Unidade de Medida...:" Get cUNIDAD                                         when mensagem("Digite a unidade de medida do produto.") 
     @ 07,03 Say "Medida Unit�ria.....:" Get nQTDPES pict "@E 99,999.9999"                  when mensagem("Digite o peso, tamanho ou quantidade de pecas do produto.") 
     @ 07,40 Get cSegura Pict "!" Valid ( cSegura=="*" .OR. cSegura == " " ) 
     @ 08,03 say "Medida M�nima.......:" Get nQTDMIN Pict "@E 99,999.9999" 
     @ 09,03 say "Estoque m�nimo......:" get nESTMIN pict "@E 99,999.999"                    when mensagem("Digite a quantidade permitida para estoque minimo.") 
     @ 10,03 say "Estoque m�ximo......:" get nESTMAX pict "@E 99,999.999"                    when mensagem("Digite a quantidade valida para estoque maximo.") 
     @ 11,03 Say "Peso L�quido...(Kg).:" Get nPesoLi Pict "@E 99,999.999" When Mensagem( "Digite o peso L�quido." ) 
     @ 12,03 Say "Peso Bruto.....(Kg).:" Get nPesoBr Pict "@E 99,999.999" Valid nPesoBr >= nPesoLi When Mensagem( "Digite o peso bruto." ) 
     @ 13,03 say "Situa��o Tribut�ria.:" Get nSITT01 pict "9" valid classtrib(@nSITT01,1)    when mensagem("Digite o codigo tributavel do produto p/ ICMs.") 
        @ 13,28 Get nSITT02 pict "99" valid classtrib(@nSITT02,2)    when mensagem("Digite o codigo de tributacao do IPI.") 
     @ 14,03 say "Classifica��o fiscal:" get nCLAFIS pict "999" valid verclasse(@nCLAFIS)    when mensagem("Digite o codigo de classificacao fiscal do produto.") 
     @ 15,03 say "% IPI (Venda/Compra):" get nIPI___ pict "999.99"                           when mensagem("Digite o percentual p/ calculo do IPI.")
     @ 15,33 say "" get nIPICMP pict "999.99"                           when mensagem("Digite o percentual p/ calculo do IPI nas compras.")
     @ 16,03 say "% p/ c�lculo do ICMs:" get nICM___ pict "999.99"                           when mensagem("Digite o percentual p/ calculo do ICMs.") 
     @ 17,03 say "Fornecedor..........:" get nCODFOR pict "999999" valid forseleciona(@nCODFOR) when mensagem("Digite o codigo do fornecedor.") 
 
       @ 11,45 say "De Compra....:" Get nPrecoCompra Pict "@E 999,999,999.999" Valid PrecoFinal( @nPrecoCompra, @nPercPv, @nPrecov, 2, GetList ) 
       @ 12,45 say "% Marg. Lucro:      " Get nPERCPV pict "@E 9,999.999" Valid PrecoFinal( @nPrecoCompra, @nPercPv, @nPrecov, 1, GetList ) when mensagem("Digite o percentual p/ venda sobre o Pre�o de compra.") 
       @ 13,45 say "Venda Padrao.:" get nPRECOV pict "@E 999,999,999.999" Valid PrecoFinal( @nPrecoCompra, @nPercPv, @nPrecov, 3, GetList ) when mensagem("Digite o Pre�o de venda do produto.") 
       @ 14,45 SAY "% Desconto...:      " get nPercDC Pict "@e 9,999.999" when Mensagem("Digite o percentual de desconto.") 
 
     Read 
     IF !LastKey() == K_ESC 
        aTabRed:= IcmReducao( nSitT02 ) 
        nPerRed:= aTabRed[1] 
        cTabRed:= aTabRed[2] 
        EditMVA( nSitT02, @nMVAPer, @nMVAVlr ) 
     ELSE 
        Exit 
     ENDIF 
 
 
 
     nPrecoD:= nPrecov - ( nPrecoV * nPercDC / 100 ) 
     @ 16,40 SAY "Pre�o Final.........:" + Tran( nPrecoD, "@e 99,999,999.999" ) 
 
     cTelaReserva:= ScreenSave( 0, 0, 24, 79 ) 
 
     if confirma(16,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento do produto.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
 
        Aviso(" Aguarde! Gravando... ",24/2) 
        mensagem("Gravando arquivo de produtos...",1) 
 
        // Buscando informacoes 
        MPR->( DBSetOrder( 1 ) ) 
        If MPR->( DBSeek( pad( cGrupo_+cCodigo, 12 ) ) ) 
           Aviso( "J� existe produto com este codigo. Corrigindo automaticamente, aguarde..." ) 
           GrupoG( cGrupo_+cCodigo, @cCodigo )        // by Gelson 
           mensagem("Gravando "  + trim( cGrupo_ + cCodigo ) + " no arquivo de produtos...",1) 
        Else 
        EndIf 
 
        if buscanet(5,{|| dbappend(), !neterr()}) 
 
           cIndice:= cGrupo_ + cCodigo 
           cCodRed:= cCodigo 
           cCodigo:= cIndice 
 
           repl CODIGO with cCODIGO, CODFAB with cCODFAB,; 
                DESCRI with cDESCRI, INDICE with cINDICE,; 
                MPRIMA with "S",     UNIDAD with cUNIDAD,; 
                QTDPES with nQTDPES, ESTMIN with nESTMIN,; 
                ESTMAX with nESTMAX,;
                CLASSE With cClasse,;
                PRECOV with nPRECOV, ICMCOD with nICMCOD,; 
                IPICOD with nIPICOD, CLAFIS with nCLAFIS,; 
                CLASV_ with nCLASV_, ORIGEM with cORIGEM,; 
                ASSOC_ with "S",; 
                CODRED with cCODRED, IPI___ with nIPI___, IPICMP With nIpiCmp,; 
                CODFOR with nCODFOR, PERCPV with nPercPV,; 
                ICM___ with nICM___, PERCDC with nPercDC,; 
                PRECOD with nPRECOD, SEGURA With cSegura,; 
                SITT01 With nSitT01,; 
                SITT02 With nSitT02,; 
                MVAPER With nMVAPer,; 
                MVAVLR With nMVAVlr 
 
 
           REPL PERRED With nPerRed,; 
                TABRED With cTabRed, PESOLI With nPesoLi,; 
                PESOBR With nPesoBr,; 
                QTDMIN With nQtdMin 
/* 
           Repl Detal1 With aDetalhe[1],; 
                Detal2 With aDetalhe[2],; 
                Detal3 With aDetalhe[3] 
 
           IF SWSet( _PRO_FORNECEDORES ) 
              Replace For001 With aForne[ 1][ 1 ], Des001 With aForne[ 1][ 2 ],; 
                      For002 With aForne[ 2][ 1 ], Des002 With aForne[ 2][ 2 ],; 
                      For003 With aForne[ 3][ 1 ], Des003 With aForne[ 3][ 2 ],; 
                      For004 With aForne[ 4][ 1 ], Des004 With aForne[ 4][ 2 ],; 
                      For005 With aForne[ 5][ 1 ], Des005 With aForne[ 5][ 2 ],; 
                      For006 With aForne[ 6][ 1 ], Des006 With aForne[ 6][ 2 ],; 
                      For007 With aForne[ 7][ 1 ], Des007 With aForne[ 7][ 2 ],; 
                      For008 With aForne[ 8][ 1 ], Des008 With aForne[ 8][ 2 ],; 
                      For009 With aForne[ 9][ 1 ], Des009 With aForne[ 9][ 2 ],; 
                      For010 With aForne[10][ 1 ], Des010 With aForne[10][ 2 ],; 
                      For011 With aForne[11][ 1 ], Des011 With aForne[11][ 2 ],; 
                      For012 With aForne[12][ 1 ], Des012 With aForne[12][ 2 ],; 
                      For013 With aForne[13][ 1 ], Des013 With aForne[13][ 2 ],; 
                      For014 With aForne[14][ 1 ], Des014 With aForne[14][ 2 ],; 
                      For015 With aForne[15][ 1 ], Des015 With aForne[15][ 2 ] 
           ENDIF 
*/ 
           mensagem("Gravando arquivo de precos x fornecedores...",1) 
           dbselectar(_COD_PRECOXFORN) 
 
           if buscanet(5,{|| dbappend(), !neterr()}) 
              repl CPROD_ with cINDICE, CODFOR with nCodFor,; 
                   VALOR_ with nPrecoCompra 
           endif 
 
           Mensagem("Limpando os dados inutiliz�veis, aguarde...",1) 
 
           /* limpeza das variaveis para a reutiliza��o */ 
           cCodFab:= Space( 13 ) 
           cDescri:= Space( _ESP_DESCRICAO ) 
           cUnidad:= Space( 2 ) 
           nIPI___:= 0
           nIpiCmp:= 0
           nQtdPes:= 0 
           nEstMin:= 0 
           nEstMax:= 0 
           nPrecov:= 0 
           nClaFis:= 0 
           cINDICE:= "           " 
           cCodigo:= StrZero( Val( cCodRed ) + 1, 4, 0 ) 
           nPERCPV:= 0 
           nPrecoCompra:= 0 
           nPesoLi:= 0 
           nPesoBr:= 0 
           nPRECOV:= 0 
           nQtdMin:= 0 
           nPercDC:= 0 
        endif 
        MPR->( DBCommitAll() ) 
     endif 
     ScreenRest( cTelaReserva ) 
  enddo 
  dbunlockall() 
  FechaArquivos() 
  screenrest(cTELA) 
  setcursor(nCURSOR) 
  setcolor(cCOR) 
  set key K_TAB to 
return nil 
 
/***** 
�������������Ŀ 
� Funcao      � BuscaCodFab 
� Finalidade  � Busca a existencia de codigo de fabrica igual 
� Parametros  � cCodFab 
� Retorno     � .T./.F. 
� Programador � Valmor Pereira Flores 
� Data        � Agosto de 1999 
��������������� 
*/ 
Function BuscaCodFab( cCodFab, GetList ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOrdem:= INDEXORD(), nArea:= Select(), nRegistro:= RECNO() 
Local nTecla 
 
  dbSelectAr( _COD_MPRIMA ) 
  dbSetOrder( 4 ) 
  IF DBSeek( cCodFab ) .AND. !( cCodFab== Space( LEN( CODFAB ) ) ) 
     Aviso( "Codigo Fabrica ja existe!" ) 
     Mensagem( "Pressione [ENTER] p/ modificar ou [TAB] p/ Ignorar aviso..." ) 
     nTecla:= INKEY(0) 
     DBSetOrder( nOrdem ) 
     DBGoTo( nRegistro ) 
     ScreenRest( cTela ) 
     Return IF( nTecla==K_TAB, .T., .F. ) 
  ELSE 
     DBSetOrder( nOrdem ) 
     DBGoTo( nRegistro ) 
     Return .T. 
  ENDIF 
  Return .F. 
 
/***** 
�������������Ŀ 
� Funcao      � BuscaDescri 
� Finalidade  � Busca a existencia de descricao do produto. 
� Parametros  � cDescri 
� Retorno     � .T./.F. 
� Programador � Valmor Pereira Flores 
� Data        � Agosto de 1999 
��������������� 
*/ 
Static Function BuscaDescri( cDescri, GetList ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nOrdem:= INDEXORD(), nArea:= Select() 
Local nTecla 
 
  dbSelectAr( _COD_MPRIMA ) 
  dbSetOrder( 2 ) 
  IF DBSeek( PAD( cDescri, LEN( DESCRI ) ) ) 
     Aviso( "Esta Descricao de Produto ja esta cadastrada!" ) 
     Mensagem( "Pressione [ENTER] p/ modificar ou [TAB] p/ Ignorar aviso..." ) 
     nTecla:= INKEY(0) 
     DBSetOrder( nOrdem ) 
     ScreenRest( cTela ) 
     Return IF( nTecla==K_TAB, .T., .F. ) 
  ELSE 
     DBSetOrder( nOrdem ) 
     Return .T. 
  ENDIF 
  Return .F. 
 
 
/***** 
�������������Ŀ 
� Funcao      � PrecoFinal 
� Finalidade  � Calculo do Preco Final do Produto 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function PrecoFinal( nPrecoCompra, nPercPv, nPrecov, nPosicao, GetList ) 
LOCAL nPercentual 
IF !nPrecov == 0 
   IF nPercPv <> ( nPercentual:= ( ( nPrecov / nPrecoCompra ) * 100 ) - 100 ) 
      IF nPosicao == 3 
         nPercPv:= nPercentual 
      ELSEIF nPosicao == 1 
         nPrecov:= ROUND( nPrecoCompra + ( ( nPrecoCompra * nPercpv ) / 100 ), SWSet( 1998 ) ) 
      ENDIF 
   ELSEIF !nPercPv==0 
      nPrecov:= ROUND( nPrecoCompra + ( ( nPrecoCompra * nPercpv ) / 100 ), SWSet( 1998 ) ) 
   ENDIF 
ELSE 
   if !nPercPv == 0 
      nPrecov:= ROUND( nPrecoCompra + ( ( nPrecoCompra * nPercpv ) / 100 ), SWSet( 1998 ) ) 
   endif 
ENDIF 
FOR nCt:= 1 TO Len( GetList ) 
   IF nCt > 10 
      GetList[ nCt ]:Display() 
   ENDIF 
NEXT 
Return .T. 

/*****
�������������Ŀ 
� Funcao      � STCompra
� Finalidade  � Digitacao da Situacao Tributaria para Compra
� Parametros  � Nil 
� Retorno     � nSitCompra =
� Programador � Gelson Oliveira da Silva
� Data        � 21/Setembro/2004
��������������� 
*/ 
Function STCompra( nSitC )
Local GetList:= {} 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nSitCompra:= Mpr->SITT03

VPBox( 10, 10, 14, 58, " TRIBUTACAO DE COMPRA ", _COR_GET_BOX )
SetColor( _COR_GET_BOX + "," + _COR_GET_BOX )
Set Delimiters Off
 
@ 12, 13 Say "Situacao Tributaria para Compra: " Get nSitCompra pict "99";
 valid classtrib(@nSitCompra,2)    when mensagem("Digite o codigo de tributacao da COMPRA.")
READ 
 
Set Delimiters On 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return nSitCompra
 
 
 

 
/***** 
�������������Ŀ 
� Funcao      � DigitaDetalhe 
� Finalidade  � Digitacao de detalhe 
� Parametros  � Nil 
� Retorno     � aDetalhe = Array com detalhamento 
� Programador � Valmor Pereira Flores 
� Data        � 13/Fevereiro/1998 
��������������� 
*/ 
Function DigitaDetalhe( aDetal ) 
Local GetList:= {} 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local aDetalhe:= { Mpr->detal1, MPr->Detal2, Mpr->Detal3 } 
 
IF !( aDetal == NIL ) 
   aDetalhe:= aDetal 
ENDIF 
 
/* Janela */ 
VPBox( 10, 10, 14, 78, " DETALHAMENTO DO PRODUTO ", _COR_GET_BOX ) 
 
SetColor( _COR_GET_BOX + "," + _COR_GET_BOX ) 
 
Set Delimiters Off 
 
/* GET */ 
@ 11, 11 Get aDetalhe[1] VALID IF (lastkey() == K_ESC, CLEARGETS (), .T.) 
@ 12, 11 Get aDetalhe[2] VALID IF (lastkey() == K_ESC, CLEARGETS (), .T.) 
@ 13, 11 Get aDetalhe[3] VALID IF (lastkey() == K_ESC, CLEARGETS (), .T.) 
READ 
 
Set Delimiters On 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return aDetalhe 
 
 
 
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
Function Grupo( cGrupo_, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt, cGrupoR:= "000" 
   DBSelectAr( _COD_GRUPO ) 
   DBSetOrder( 1 ) 
   IF DBSeek( cGrupo_ ) 
      cGrupo_:= CODIGO 
      cCodigo:= cGrupo_ + Right( cCodigo, 4 ) 
   ELSE 
      cGrupoR:= cGrupo_ 
      DBGoTop() 
      VerificaGrupo( @cGrupoR ) 
      cGrupo_:= cGrupoR 
      cCodigo:= cGrupo_ + Right( cCodigo, 4 ) 
   ENDIF 
   IF cGrupo_ == "999" 
      cGrupo_:= "000" 
   ENDIF 
   Mensagem( "Procurando o ultimo codigo utilizado pelo grupo: " + cGrupo_ + ", aguarde..." ) 
   DBSelectAr( _COD_MPRIMA ) 
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
 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return(.T.) 
 
 
/*****
by Gelson Oliveira da Silva
*/ 
Function GrupoG( cProduto, cCodigo ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   Local cCor:= SetColor(), nCursor:= SetCursor(), nCt, cGrupoR:= "000" 
 
   // VALMOR: Localiza o primeiro produto do proximo grupo 
   MPR->( DBSetOrder( 1 ) ) 
   MPR->( DBSeek( STRZERO( VAL( LEFT( cProduto, 3 ) ) + 1, 3, 0 ) + "0000", .T. ) ) 
   MPR->( DBSkip( -1 ) ) 
   cCodigo:= STRZERO( VAL( SUBSTR( MPR->INDICE, 4, 4 ) )+1, 04 ) 
 
   DBSelectAr( nArea ) 
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
Function Codigo( cCodigo, GetList ) 
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
Function MPrExibeStru() 
   Local cCor:= SetColor() 
   SetColor( _COR_GET_LETRA ) 
   @ 02,03 Say "C�digo..............:"
   @ 02,50 Say "Classe/Giro:"
//   Get cClasse Valid cClasse $ "ABCD" when mensagem( "Digite a classe do produto quanto ao giro [ A / B / C / D ]" )
   @ 03,03 Say "C�digo de F�brica...:" 
   @ 04,03 Say "Descri��o do produto:" 
   @ 05,03 Say "Origem/Fabricante...:" 
   @ 06,03 Say "Unidade de Medida...:" 
   @ 07,03 Say "Medida Unit�ria.....:" 
   @ 08,03 Say "Medida Minima.......:" 
   @ 09,03 Say "Situa��o Tribut�ria.:" 
   @ 10,03 Say "Classifica��o fiscal:" 
   @ 11,03 Say "Estoque m�nimo......:" 
   @ 12,03 Say "Estoque m�ximo......:" 
   @ 13,03 Say "% IPI (Venda/Compra):" 
   @ 14,03 Say "% p/ c�lculo do ICMs:" 
   @ 15,03 Say "Fornecedor..........:" 
   @ 16,03 Say "% s/ pre�o Compra...:" 
   @ 17,03 Say "Pre�o de Compra.....:" 
   @ 12,40 Say "Peso L�quido...(Kg).:" 
   @ 13,40 Say "Peso Bruto.....(Kg).:" 
   @ 14,40 Say "Pre�o de venda......:" 
   @ 15,40 Say "Percentual Desconto.:" 
   @ 16,40 Say "Preco Final.........:" 
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
Function MPRMostra() 
   Local cCor:= SetColor() 
   SetColor( _COR_GET_LETRA ) 
   @ 02,25 Say "[" + Left( MPr->Indice, 3 ) + "]-[" + AllTrim( MPr->CodRed ) + "]" 
   @ 02,62 Say "[" + mpr->classe + "]"
   @ 03,25 Say "[" + MPr->CodFab + "]"
   @ 04,25 Say "[" + MPr->Descri + "]" 
   @ 05,25 Say "[" + MPr->Origem + "]" 
   @ 06,25 Say "[" + MPr->Unidad + "]" 
   @ 07,25 Say "[" + Tran( MPr->QtdPes, "@E 999,999.9999" ) + "]" 
   @ 07,40 Say "[" + MPR->SEGURA + "]" 
   @ 08,25 Say "[" + Tran( MPr->QtdMin, "@E 999,999.9999" ) + "]" 
   @ 09,25 Say "[" + Str( MPr->SITT01, 1, 0 ) + "]" 
   @ 09,28 Say "[" + Str( MPr->SITT02, 2, 0 ) + "]" 
   @ 10,25 Say "[" + Tran( MPr->ClaFis, "999" ) + "]" 
   @ 11,25 Say "[" + Tran( MPr->EstMin, "@E 99,999.999" ) + "]" 
   @ 12,25 Say "[" + Tran( MPr->EstMax, "@E 99,999.999" ) + "]" 
   @ 13,25 Say "[" + Tran( MPr->IPI___, "999.99" ) + "]" 
   @ 14,25 Say "[" + Tran( MPr->ICM___, "999.99" ) + "]" 
   @ 15,25 Say "[" + Tran( MPr->CodFor, "999999" ) + "]" 
   @ 16,25 Say "[" + Tran( MPr->PercPv, "@E 9,999.999" ) + "]" 
   @ 12,62 Say "[" + Tran( MPR->PesoLi, "@E 999,999.9999" ) + "]" 
   @ 13,62 Say "[" + Tran( MPR->PesoBr, "@E 999,999.9999" ) + "]" 
   @ 14,62 Say "[" + Tran( MPr->Precov, "@E 99,999,999.999" ) + "]" 
   @ 15,62 Say "[" + Tran( MPr->PercDc, "@E 99,999.99" ) + "]" 
   @ 16,62 Say "[" + Tran( MPr->PrecoD, "@E 99,999,999.999" ) + "]" 
   /* Preco de compra */ 
   PxF->( DBSetOrder( 1 ) ); PxF->( DBSeek( Mpr->Indice ) )
   WHILE !PXF->( EOF() ) .AND. PXF->CPROD_ == MPR->INDICE
       IF MPR->CODFOR == PXF->CODFOR
          @ 17,25 Say "[" + Tran( PxF->Valor_, "@E 999,999,999.999" ) + "]"
          EXIT
       ENDIF
       PXF->( DBSkip() )
   ENDDO
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
|           se encontra na biblioteca VPBIBCEI, mas, possuialteracoes 
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
   Mensagem( if( nModo==1, "Pressione [TAB] ou [ENTER] para efetuar alteracoes.",; 
                           "Pressione [TAB] ou [ENTER] para excluir." ) ) 
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
         CASE nTecla==K_F2         ;DBMudaOrdem( 1, oTb ) 
         CASE nTecla==K_F3         ;DBMudaOrdem( 4, oTb ) 
         CASE nTecla==K_F4         ;DBMudaOrdem( 2, oTb ) 
         CASE DBPesquisa( nTecla, oTb ) 
         CASE nTecla==K_TAB .OR. nTecla == K_ENTER 
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
 
Function f_calprefim(nPercDC,nPrecov,nprecod,lprecod) 
if lPrecod 
   nPrecoD:= nPrecov - ( nPrecoV * nPercDC / 100 ) 
else 
   nPercDC:= val( str((((nPrecov-nPrecod)*100)/nPrecov),10,3)) 
endif 
retu .T. 
 
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
Function MPRAltera(cIndicex,oTb) 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local GetList:= {} 
   Local cCodigo:= MPr->Codigo, cDescri:= MPr->Descri,; 
         cClasse:= mpr->Classe,;
         cCodFabRes:= MPr->CodFab,;
         cOrigem:= MPr->Origem,; 
         cCodFab:= MPR->CODFAB,; 
         cUnidad:= MPr->Unidad, nQtdPes:= MPr->QtdPes,; 
         nPrecov:= MPr->Precov, nICMCod:= MPr->IcmCod, nPrecod:= MPr->Precod,; 
         nIPICod:= MPr->IpiCod, nClaFis:= MPr->ClaFis,; 
         nClasV_:= MPr->Clasv_, nEstMin:= MPr->EstMin,; 
         nEstMax:= MPr->EstMax, nIPI___:= MPr->ipi___, nIpiCmp:= MPR->IPICMP,; 
         nCodFor:= MPr->CodFor, nPercpv:= MPr->PercPv,; 
         nPercdc:= MPr->PercDc, nIcm___:= MPr->Icm___,; 
         nPerRed:= MPr->PerRed, cTabRed:= MPr->TabRed,; 
         nQtdMin:= Mpr->QTDMIN,; 
         nSitT01:= MPR->SITT01,; 
         nSitT02:= MPR->SITT02,; 
         nMVAPer:= MPR->MVAPER,; 
         nMVAVlr:= MPR->MVAVLR,; 
         aTabRed:= { MPr->PerRed, MPR->TabRed },; 
         aDetalhe:= { Mpr->detal1, MPr->Detal2, Mpr->Detal3 },; 
         nPesoLi:= MPR->PesoLi, nPesoBr:= MPR->PesoBr,; 
         cSegura:= MPr->SEGURA 
   Local nOrdMpr:= IndexOrd(), nReg:= MPR->( RECNO() ) 
 
 
   IF ( !EMPTY( cINDICEx ) ) 
      dbsetorder(1) 
      dbseek(cINDICEx) 
      IF oTb <> Nil 
         oTb:RefreshCurrent() 
         oTb:Stabilize() 
      ENDIF 
   ENDIF 
 
   SetCursor( 1 ) 
   SetColor( _COR_GET_EDICAO ) 
 
   IF MPR->( netrlock() ) 
      /* Limpa codigo de fabrica da base p/ fazer a consistencia via BuscaCodFab */ 
      Replace MPR->CODFAB With Space( 13 ) 
   ELSE 
      Aviso( "Registro sendo utilizado por outro modulo." ) 
      Pausa() 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return Nil 
   ENDIF 
 
   PxF->( DBSetOrder( 1 ) )
   PxF->( DBSeek( Mpr->Indice ) )
   nPrecoCompra:= 0
   WHILE !PXF->( EOF() ) .AND. PXF->CPROD_ == MPR->INDICE
       IF MPR->CODFOR == PXF->CODFOR
          nPrecoCompra:= PxF->Valor_
          EXIT
       ENDIF
       PXF->( DBSkip() )
   ENDDO
 
   @ 02,50 Say "Classe/Giro:" Get cClasse Valid cClasse $ " ABCD" when mensagem( "Digite a classe do produto quanto ao giro [ A / B / C / D ]" ) 
   @ 03,03 Say "C�digo de F�brica...:" get cCODFAB Valid BuscaCodFab( @cCodFab, GetList )  when mensagem("Digite o C�digo de F�brica do produto.") 
   @ 04,03 say "Descri��o do produto:" get cDESCRI                                         when mensagem("Digite a Descri��o do produto.") 
   @ 05,03 say "Origem/Fabricante...:" get cORIGEM pict "@!" valid oseleciona(@cORIGEM)    when mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
   @ 06,03 say "Unidade de Medida...:" get cUNIDAD                                         when mensagem("Digite a unidade de medida do produto.") 
   @ 07,03 say "Medida Unit�ria.....:" get nQTDPES pict "@E 99,999.9999"                  when mensagem("Digite o peso, tamanho ou quantidade de pecas do produto.") 
      @ 07,40 Get cSegura Pict "!" Valid ( cSegura=="*" .OR. cSegura == " " ) When; 
        Mensagem( "Digite [*] para que o sistema aceite somente quantidades validas" ) 
   @ 08,03 say "Medida M�nima.......:" Get nQTDMIN Pict "@E 99,999.9999" 
   @ 09,03 say "Estoque m�nimo......:" get nESTMIN pict "@E 99,999.999"                    when mensagem("Digite a quantidade permitida para estoque minimo.") 
   @ 10,03 say "Estoque m�ximo......:" get nESTMAX pict "@E 99,999.999"                    when mensagem("Digite a quantidade valida para estoque maximo.") 
   @ 11,03 Say "Peso L�quido...(Kg).:" Get nPesoLi Pict "@E 99,999.999" When Mensagem( "Digite o peso L�quido." ) 
   @ 12,03 Say "Peso Bruto.....(Kg).:" Get nPesoBr Pict "@E 99,999.999" Valid nPesoBr >= nPesoLi When Mensagem( "Digite o peso bruto." ) 
   @ 13,03 say "Situa��o Tribut�ria.:" Get nSITT01 pict "9" valid classtrib(@nSITT01,1)    when mensagem("Digite o codigo tributavel do produto p/ ICMs.") 
      @ 13,28 Get nSITT02 pict "99" valid classtrib( @nSITT02, 2 )    when mensagem("Digite o codigo de tributacao do IPI.") 
   @ 14,03 say "Classifica��o fiscal:" get nCLAFIS pict "999" valid verclasse(@nCLAFIS)    when mensagem("Digite o codigo de classificacao fiscal do produto.") 
   @ 15,03 say "% IPI (Venda/Compra):" get nIPI___ pict "999.99"                           when mensagem("Digite o percentual p/ calculo do IPI.")
   @ 15,33 Say "" Get nIpiCmp Pict "@E 999.99" when mensagem( "IPI na compra de mercadorias." )
   @ 16,03 say "% p/ c�lculo do ICMs:" get nICM___ pict "999.99"                           when mensagem("Digite o percentual p/ calculo do ICMs.") 
   @ 17,03 say "Fornecedor..........:" get nCODFOR pict "999999" valid forseleciona(@nCODFOR) when mensagem("Digite o codigo do fornecedor.") 
 
     @ 11,45 say "De Compra....:" Get nPrecoCompra Pict "@E 999,999,999.999" Valid iif(nPrecoCompra=0,.t.,PrecoFinal( @nPrecoCompra, @nPercPv, @nPrecov, 2, GetList )) 
     @ 12,45 say "% Marg.Lucro.:      " Get nPERCPV pict "@E 9,999.999" Valid iif(nPrecoCompra=0,.t.,PrecoFinal( @nPrecoCompra, @nPercPv, @nPrecov, 1, GetList )) when mensagem("Digite o percentual p/ venda sobre o Pre�o de compra.") 
     @ 13,45 say "Venda Padrao.:" get nPRECOV pict "@E 999,999,999.999" Valid iif(nPrecoCompra=0,.t.,PrecoFinal( @nPrecoCompra, @nPercPv, @nPrecov, 3, GetList )) when mensagem("Digite o Pre�o de venda do produto.") 
     @ 14,45 SAY "% Desconto...:      " Get nPercDC Pict "@e 9,999.999" Valid f_calprefim(nPercDC,nPrecov,@nprecod,.t.) when Mensagem("Digite o percentual de desconto.") 
     @ 15,45 SAY "Preco Final..:" get nPrecoD Pict "@e 999,999,999.999" Valid f_calprefim(@nPercDC,nPrecov,Nprecod,.f.) 
 
   Read 
 
   IF ! ( LastKey() == K_ESC ) 
      /* reducao de ICMs */ 
      aTabRed:= IcmReducao( nSitT02 ) 
      nPerRed:= aTabRed[1] 
      cTabRed:= aTabRed[2] 
      EditMVA( nSitT02, @nMVAPer, @nMVAVlr ) 
*      nPrecoD:= nPrecov - ( nPrecoV * nPercDC / 100 ) 
*      @ 15,41 SAY "Preco Final.....: [" + Tran( nPrecoD, "@e 999,999,999.999" ) + "]" 
   ENDIF 
 
   /* Restaura codigo de fabrica p/ base de dados */ 
   MPR->( DBGoTo( nReg ) ) 
   IF MPR->( netrlock() ) 
      Replace MPR->CODFAB With cCodFabRes 
   ENDIF 
 
   IF ! LASTKEY() == K_ESC 
    DBSelectAr(_COD_MPRIMA) 
    if confirma(16,63,"Confirma?",; 
       "Digite [S] para confirmar o cadastramento do produto.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        cTELAR:=screensave(00,00,24,79) 
        aviso(" Aguarde! Gravando... ",24/2) 
        mensagem("Gravando arquivo de produtos...",1) 
        if netrlock(5) 
//         nTabObs:= TABOBS 
//         NFObservacao( @nTabObs ) 
           cINDICE:=substr(cCODIGO,_PIGRUPO,_QTGRUPO)+; 
                    substr(cCODIGO,_PICODIG,_QTCODIG) 
           cCODRED:=substr(cCODIGO,_PICODIG,_QTCODIG) 
           Repl CODIGO with cCODIGO, CODFAB with cCODFAB,; 
                DESCRI with cDESCRI, INDICE with cINDICE,; 
                CLASSE With cClasse,;
                UNIDAD with cUNIDAD,;
                QTDPES with nQTDPES, ESTMIN with nESTMIN,; 
                ESTMAX with nESTMAX,; 
                PRECOV with nPRECOV, ICMCOD with nICMCOD,; 
                IPICOD with nIPICOD, CLAFIS with nCLAFIS,; 
                CLASV_ with nCLASV_, ORIGEM with cORIGEM,; 
                ASSOC_ with cASSOCIAR,; 
                CODRED with cCODRED, IPI___ with nIPI___,;
                IPICMP With nIpiCmp,;
                ICM___ with nICM___, CODFOR with nCODFOR,; 
                PERCPV with nPercPV, PERCDC with nPercDC,; 
                PRECOD with nPRECOD, PERRED With nPerRed,; 
                TABRED With cTabRed,; 
                PESOLI With nPesoLi, PesoBr With nPesoBr,; 
                SEGURA With cSegura,; 
                QTDMIN With nQtdMin,; 
                SITT01 With nSitT01,; 
                SITT02 With nSitT02,; 
                MVAPER With nMVAPer,; 
                MVAVLR With nMVAVlr 
/* 
                TABRED With cTabRed, DETAL1 With aDetalhe[1],; 
                DETAL2 With aDetalhe[2], DETAL3 With aDetalhe[3],; 
                SEGURA With cSegura, TABOBS With nTabObs,; 
 
            IF SWSet( _PRO_FORNECEDORES ) 
             Replace For001 With aForne[ 1][ 1 ], Des001 With aForne[ 1][ 2 ],; 
                     For002 With aForne[ 2][ 1 ], Des002 With aForne[ 2][ 2 ],; 
                     For003 With aForne[ 3][ 1 ], Des003 With aForne[ 3][ 2 ],; 
                     For004 With aForne[ 4][ 1 ], Des004 With aForne[ 4][ 2 ],; 
                     For005 With aForne[ 5][ 1 ], Des005 With aForne[ 5][ 2 ],; 
                     For006 With aForne[ 6][ 1 ], Des006 With aForne[ 6][ 2 ],; 
                     For007 With aForne[ 7][ 1 ], Des007 With aForne[ 7][ 2 ],; 
                     For008 With aForne[ 8][ 1 ], Des008 With aForne[ 8][ 2 ],; 
                     For009 With aForne[ 9][ 1 ], Des009 With aForne[ 9][ 2 ],; 
                     For010 With aForne[10][ 1 ], Des010 With aForne[10][ 2 ],; 
                     For011 With aForne[11][ 1 ], Des011 With aForne[11][ 2 ],; 
                     For012 With aForne[12][ 1 ], Des012 With aForne[12][ 2 ],; 
                     For013 With aForne[13][ 1 ], Des013 With aForne[13][ 2 ],; 
                     For014 With aForne[14][ 1 ], Des014 With aForne[14][ 2 ],; 
                     For015 With aForne[15][ 1 ], Des015 With aForne[15][ 2 ] 
           ENDIF 
*/ 
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
         AtualizaTabPreco( MPR->INDICE, MPR->DESCRI, MPR->CODFAB ) 
      Endif 
   Endif 
   ScreenRest( cTela ) 
   SetCursor( nCursor ) 
   SetColor( cCor ) 
   MPR->( DBSetOrder( nOrdMpr ) ) 
return nil 
 
 
 
 
Function AtualizaTabPreco( cCodigo, cDescri, cCodFab ) 
Local nArea:= Select() 
   /* Grava informacoes nas tabelas de precos caso exista */ 
   TAX->( DBSetOrder( 2 ) ) 
   IF TAX->( DBSeek( cCodigo ) ) 
      WHILE cCodigo==TAX->CODPRO 
          IF TAX->( netrlock() ) 
             Replace TAX->CODFAB With cCodFab,; 
                     TAX->DESCRI With cDescri 
          ENDIF 
          TAX->( DBUnLock() ) 
          TAX->( DBSkip() ) 
      ENDDO 
   ENDIF 
   IF nArea > 0 
      DBSelectAr( nArea ) 
   ENDIF 
   Return Nil 
 
 
 
 
 
 
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
  set key K_TAB to pesquisadbf(1) 
return nil 
 
/* 
* Funcao      - MPRALTERACAO 
* Finalidade  - Alteracao de dados dos produtos. 
* Data        - 
* Atualizacao - 
*/ 
func mpralteracao 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca _cMRESER 
  priv aTELA1, aTELA 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  priv cCODIGO:=spac(12), cDESCRI:=SPACE( _ESP_DESCRICAO ), nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
  priv cMASCACOD 
  priv bMASCARA:="' ' + Tran( Codigo, '@R XXX-XXXX' )+'  '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 ) " 
 
  priv cxORIGEM, cxMASCACOD, cxMASCQUAN, cxMASCPREC, nROW:=1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  userscreen() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  usermodulo(" Alteracao de Produtos ") 
  cMASCACOD:=SWSet( _PRO_MASCACOD ) 
  cVERIF_:= .F. 
  cMASCQUAN:=SWSet( _PRO_MASCQUAN ) 
  cMASCPREC:=SWSet( _PRO_MASCPREC ) 
  cxORIGEM:= IF( SWSet( _PRO_ORIGEM ), "S", "N" ) 
  cASSOCIAR:= IF( SWSet( _PRO_ASSOCIAR ), "S", "N" ) 
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
 
  DBSelectAr( _COD_ORIGEM ) 
  DBSetOrder( 3 ) 
 
  dbselectar(_COD_MPRIMA) 
  Set Relation To Origem Into ORG 
 
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
  set key K_TAB to 
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
func mprexclusao 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca _cMRESER 
  priv aTELA1, aTELA 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  priv cCODIGO:=spac(12), cDESCRI:=spac( _ESP_DESCRICAO ), nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
  priv cMASCACOD 
  Priv bMASCARA:="' ' + Tran( Codigo, '@R XXX-XXXX' )+'  '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 ) " 
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
  IF cxORIGEM="S"                         && Se utilizar arquivo de origens! 
     IF !file(_VPB_ORIGEM) 
        mensagem("Arq. de origens nao encontrado, press ENTER para continuar.") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     ENDIF 
     IF !fdbusevpb(_COD_ORIGEM,2) 
        aviso("ATENCAO! Verifique o arquivo "+; 
          alltrim(_VPB_ORIGEM)+".",24/2) 
        mensagem("Erro na abertura do arquivo de origens, tente novamente...") 
        pausa() 
        setcolor(cCOR) 
        setcursor(nCURSOR) 
        screenrest(cTELA) 
        return(NIL) 
     ENDIF 
  ENDIF 
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
 
  /* Seleciona Origem */ 
  DBSelectAr( _COD_ORIGEM ) 
  DBSetOrder( 3 ) 
 
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
 
  Set Relation To ORIGEM Into ORG 
 
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
     ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [TAB][ENTER]Exclui [ESC]Cancela") 
     MPrExibeStru() 
     pesquisadbf(2) 
  enddo 
  set key K_TAB to 
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
FUNCTION ICMReducao( nCodigoTabelaB ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local oTb, nTecla 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local nPerRed:= 0, cTabRed:= "  " 
 
  nPerRed:= MPR->PERRED 
 
  cTabRed:= MPR->TABRED 
 
  DBSelectAr( _COD_REDUCAO ) 
 
  IF !DBSeek( PAD( cTabRed, 2 ) ) 
     DBGoTop() 
  ENDIF 
 
  /* Montagem da tela */ 
  VPBox( 08, 35, 21, 78, " ALIQUOTAS & REDUCOES DE ICMs ", _COR_BROW_BOX, .T., .T., ) 
 
  SetColor( _COR_BROWSE ) 
  Mensagem( "Pressione [ENTER] p/Selecionar desejado." ) 
  Ajuda( "[ENTER]Confirma" ) 
 
  /* Objeto browse */ 
  oTB:=TBrowsedb( 11, 36, 20, 77 ) 
  oTB:addcolumn( tbcolumnnew( , {|| CODIGO + " " + DESCRI + " " + Tran( PERRED, "@E 999.9999" ) } ) ) 
 
  /* variaveis browse */ 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
 
 
  /* EXIBICAO DE INFORMACOES CASO SEJA NENHUMA */ 
  SetCursor( 0 ) 
  oTb:RefreshAll() 
  WHILE !oTb:Stabilize() 
  ENDDO 
  IF cTabRed==Space( 2 ) 
     @ 09,36 Say "   NENHUMA ALIQUOTA SELECIONADA          " Color "14/" + CorFundoAtual() 
     @ 10,36 Say "�����������������������������������������" 
     IF Inkey(0)==K_ENTER 
        ScreenRest( cTela ) 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        DBSelectAr( nArea ) 
        DBSetOrder( nOrdem ) 
        Return { 0, Space( 2 ) } 
     ENDIF 
  ENDIF 
  @ 09,36 Say    "                                         " Color "14/" + CorFundoAtual() 
  @ 10,36 Say    "�����������������������������������������" 
 
  WHILE .T. 
      oTB:ColorRect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      WHILE NextKey()=0 .AND. ! oTB:Stabilize() 
      ENDDO 
 
      @ 09,36 Say    "   Reducao em " + Tran( PERRED, "@e 999.9999" ) + "%" Color "14/" + CorFundoAtual() 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         exit 
      EndIf 
 
      do case 
 
         case nTecla==K_UP 
              oTB:up() 
 
         case nTecla==K_LEFT       ;oTB:up() 
 
         case nTecla==K_RIGHT      ;oTB:down() 
 
         case nTecla==K_DOWN       ;oTB:down() 
 
         case nTecla==K_PGUP       ;oTB:pageup() 
 
         case nTecla==K_PGDN       ;oTB:pagedown() 
 
         case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
 
         case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
 
         case nTecla==K_ENTER 
 
              nPerRed:= PERRED 
 
              cTabRed:= CODIGO 
 
              EXIT 
 
         otherwise                ;tone(125); tone(300) 
 
      endcase 
 
      oTB:refreshcurrent() 
      oTB:stabilize() 
 
  enddo 
 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return { nPerRed, cTabRed } 
 
 
/***** 
�������������Ŀ 
� Funcao      � NFObservacao 
� Finalidade  � Pegar a observacao p/ nota fiscal 
� Parametros  � nCodigoObservacao 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 08/Janeiro/1996 
��������������� 
*/ 
FUNCTION NFObservacao( nTabObs ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local oTb, nTecla 
 
  DBSelectAr( _COD_OBSERVACOES ) 
  DBSetOrder( 1 ) 
 
  IF !DBSeek( nTabObs, .T. ) 
     DBGoTop() 
  ENDIF 
 
  /* Montagem da tela */ 
  VPBox( 10, 35, 21, 78, "OBSERVACAO NA NOTA FISCAL", _COR_BROW_BOX, .T., .T., ) 
 
  SetColor( _COR_BROWSE ) 
 
  Mensagem( "Pressione [ENTER] sobre a Observacao." ) 
  Ajuda( "[ENTER]Confirma" ) 
 
  /* Objeto browse */ 
  oTB:=TBrowsedb( 11, 36, 20, 77 ) 
  oTB:addcolumn( tbcolumnnew( , {|| StrZero( CODIGO, 3, 0 ) + " " + DESCRI + Space( 20 ) } ) ) 
 
  /* variaveis browse */ 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
 
  WHILE .T. 
      oTB:ColorRect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      WHILE NextKey()=0 .AND. ! oTB:Stabilize() 
      ENDDO 
 
      SetColor( _COR_GET_BOX ) 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         nTabObs:= 0 
         exit 
      EndIf 
 
      do case 
 
         case nTecla==K_UP         ;oTB:up() 
 
         case nTecla==K_LEFT       ;oTB:up() 
 
         case nTecla==K_RIGHT      ;oTB:down() 
 
         case nTecla==K_DOWN       ;oTB:down() 
 
         case nTecla==K_PGUP       ;oTB:pageup() 
 
         case nTecla==K_PGDN       ;oTB:pagedown() 
 
         case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
 
         case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
 
         case nTecla==K_ENTER 
              nTabObs:= CODIGO 
              EXIT 
 
         otherwise                ;tone(125); tone(300) 
 
      endcase 
 
      oTB:refreshcurrent() 
      oTB:stabilize() 
  enddo 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return .T. 
 
 
 
Function MPRVerifica() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
/* origem */ 
DBSelectAr( _COD_ORIGEM ) 
DBSetOrder( 3 ) 
 
/* cad. materia-prima */ 
DBSelectAr( _COD_MPRIMA ) 
Set Relation To ORIGEM Into ORG, TABRED Into RED 
 
/* Apresentacao em tela */ 
//������������������������������������������������������������������������������ 
/* 
VPBox( 0, 0, 18, 79, " VERIFICACAO DE PRODUTOS ", _COR_GET_BOX ) 
VPBox( 18, 0, 22, 79, , _COR_BROW_BOX, .F., .F. ) 
SetColor( _COR_BROWSE ) 
oTB:=TBrowsedb( 19, 01, 21, 78 ) 
oTB:addcolumn( tbcolumnnew( , {|| ' ' + Tran( Codigo, '@R XXX-XXXX' )+'  '+ CodFab + ' ' + LEFT( Descri, 40 ) + ' ' + Left( ORG->DESCRI, 10 )  } ) ) 
oTB:AUTOLITE:=.f. 
oTB:dehilite() 
whil .t. 
   oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTB:stabilize() 
   enddo 
*/ 
//VPBox( 2, 2, 17, 77, " VERIFICACAO DE PRODUTOS ", _COR_GET_BOX ) 
VPBox( 0, 0, 18, 79, " VERIFICACAO DE PRODUTOS ", _COR_GET_BOX, .F. ) 
//������������������������������������������������������������������������������ 
   SetColor( _COR_GET_BOX ) 
   @ 01, 02 Say DESCRI 
   @ 02, 02 Say CODFAB 
   FOR->( DBSeek( MPR->FOR001 ) ) 
   @ 03, 02 Say StrZero( MPR->FOR001, 3, 0 ) + " " + LEFT( Des001, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR002 ) ) 
   @ 04, 02 Say StrZero( MPR->FOR002, 3, 0 ) + " " + LEFT( Des002, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR003 ) ) 
   @ 05, 02 Say StrZero( MPR->FOR003, 3, 0 ) + " " + LEFT( Des003, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR004 ) ) 
   @ 06, 02 Say StrZero( MPR->FOR004, 3, 0 ) + " " + LEFT( Des004, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR005 ) ) 
   @ 07, 02 Say StrZero( MPR->FOR005, 3, 0 ) + " " + LEFT( Des005, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR006 ) ) 
   @ 08, 02 Say StrZero( MPR->FOR006, 3, 0 ) + " " + LEFT( Des006, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR007 ) ) 
   @ 09, 02 Say StrZero( MPR->FOR007, 3, 0 ) + " " + LEFT( Des007, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR008 ) ) 
   @ 10, 02 Say StrZero( MPR->FOR008, 3, 0 ) + " " + LEFT( Des008, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR009 ) ) 
   @ 11, 02 Say StrZero( MPR->FOR009, 3, 0 ) + " " + LEFT( Des009, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR010 ) ) 
   @ 12, 02 Say StrZero( MPR->FOR010, 3, 0 ) + " " + LEFT( Des010, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR011 ) ) 
   @ 13, 02 Say StrZero( MPR->FOR011, 3, 0 ) + " " + LEFT( Des011, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR012 ) ) 
   @ 14, 02 Say StrZero( MPR->FOR012, 3, 0 ) + " " + LEFT( Des012, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR013 ) ) 
   @ 15, 02 Say StrZero( MPR->FOR013, 3, 0 ) + " " + LEFT( Des013, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR014 ) ) 
   @ 16, 02 Say StrZero( MPR->FOR014, 3, 0 ) + " " + LEFT( Des014, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   FOR->( DBSeek( MPR->FOR015 ) ) 
   @ 17, 02 Say StrZero( MPR->FOR015, 3, 0 ) + " " + LEFT( Des015, 35 ) + " " + LEFT( FOR->DESCRI, 35 ) 
   SetColor( _COR_BROW_BOX ) 
   nTecla:=inkey(0) 
/* 
   If nTecla=K_ESC 
      exit 
   EndIf 
   do case 
      case nTecla==K_UP         ;oTB:up() 
      case nTecla==K_LEFT       ;oTB:up() 
      case nTecla==K_RIGHT      ;oTB:down() 
      case nTecla==K_DOWN       ;oTB:down() 
      case nTecla==K_PGUP       ;oTB:pageup() 
      case nTecla==K_PGDN       ;oTB:pagedown() 
      case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
      case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
      case chr(nTecla)$"1234567890" 
           cTELAR0:=ScreenSave(10,00,24,79) 
           Set(_SET_SOFTSEEK,.T.) 
           nCOD:=0 
           Keyboard chr(nTecla) 
           vpbox(11,25,13,48,"",COR[20],.T.,.F.,COR[19]) 
           @ 12,26 say "C�digo " get nCOD pict "999999" when Mensagem( "Digite o c�digo para pesquisa.") 
           read 
           Mensagem( "Executando a pesquisa pelo Codigo, aguarde...") 
           dbsetorder(1) 
           dbseek(nCOD) 
           Set(_SET_SOFTSEEK,.F.) 
           ScreenRest(cTELAR0) 
           oTB:RefreshAll() 
           Whil ! oTB:Stabilize() 
           EndDo 
           nORDEMG=1 
      case Upper(chr(nTecla))$"ABCDEFGHIJKLMNOPQRSTUVWXYZ" 
           cTELAR0:=ScreenSave(10,00,24,79) 
           Set(_SET_SOFTSEEK,.T.) 
           cDESC:=Spac(45) 
           Keyboard upper(chr(nTecla)) 
           vpbox(11,16,13,63,"",COR[20],.T.,.F.,COR[19]) 
           @ 12,17 say "Nome " get cDESC pict "@S35" when Mensagem( "Digite o nome para pesquisa.") 
           read 
           Mensagem( "Executando a pesquisa pela Descricao, aguarde...") 
           dbsetorder(2) 
           dbseek(upper(cDESC)) 
           Set(_SET_SOFTSEEK,.F.) 
           ScreenRest(cTELAR0) 
           oTB:RefreshAll() 
           Whil ! oTB:Stabilize() 
           EndDo 
           nORDEMG=2 
      case nTecla==K_F2         ;organiza(oTB,1) 
      case nTecla==K_F3         ;organiza(oTB,2) 
      case nTecla==K_ENTER 
           DisplayInfProd() 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTB:refreshcurrent() 
   oTB:stabilize() 
enddo 
*/ 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
 
FUNCTION DisplayInfProd() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nLinha:= 2 
VPBox( 02, 02, 20, 78, "Dados Cadastrais do Produto", "15/05" ) 
SetColor( "15/05" ) 
@ ++nLinha, 03 Say "C�digo..............: [" + Tran( Codigo, "999-9999" ) + "]" 
@ ++nLinha, 03 Say "C�digo de F�brica...: [" + CODFAB + "]" 
@ ++nLinha, 03 Say "Descri��o...........: [" + DESCRI + "]" 
@ ++nLinha, 03 Say "Origem/Fabricante...: [" + ORIGEM + "]-[" + ORG->DESCRI + "]" 
@ ++nLinha, 03 Say "Unidade de Medida...: [" + UNIDAD + "]" 
@ ++nLinha, 03 Say "Medida Unit�ria.....: [" + Tran( QTDPES,"@E 999,999.9999" ) + "]" 
@ ++nLinha, 03 Say "Medida M�nima.......: [" + Tran( QTDMIN,"@E 999,999.9999" ) + "]" 
@ ++nLinha, 03 Say "Situa��o Tribut�ria.: [" + Tran( SITT01, "@E 9" ) + "]" 
@ nLinha,   28 Say "[" + Tran( SITT02, "@E 99" ) + "]" 
@ ++nLinha, 03 Say "Classifica��o fiscal: [" + StrZero( CLAFIS, 3, 0 ) + "]" 
@ ++nLinha, 03 Say "Estoque m�nimo......: [" + Tran( EstMin, "@E 99,999.999" ) + "]" 
@ ++nLinha, 03 Say "Estoque m�ximo......: [" + Tran( EstMax, "@E 99,999.999" ) + "]" 
@ ++nLinha, 03 Say "% IPI (Venda/Compra): [" + Tran( IPI___, "@E 999.99" ) + "] [" + Tran( IPICMP, "@E 999.99" ) + "]" 
@ ++nLinha, 03 Say "% p/ c�lculo do ICMs: [" + Tran( ICM___, "999.99" ) + "]" 
@ ++nLinha, 03 Say "Fornecedor..........: [" + StrZero( CodFor, 6, 0 ) + "]" 
@ ++nLinha, 03 Say "% s/ pre�o Compra...: [" + Tran( PERCPV, "@E 9,999.999" ) + "]" 
@ ++nLinha, 03 Say "Pre�o de Compra.....: [" + Tran( 0, "@E 999,999,999.999" ) + "]" 
nLinha:= 12 
@ ++nLinha, 38 Say "Peso L�quido...(Kg).: [" + Tran( PesoLi, "@E 999,999.9999" ) + "]" 
@ ++nLinha, 38 Say "Peso Bruto.....(Kg).: [" + Tran( PesoBr, "@E 999,999.9999" ) + "]" 
@ ++nLinha, 38 Say "Pre�o de venda......: [" + Tran( PRECOV, "@E 999,999,999.999" ) + "]" 
@ ++nLinha, 38 Say "Percentual Desconto.: [" + Tran( PERCDC, "@e 9,999.999" ) + "]" 
InKey(0) 
 
VPBox( 02, 02, 20, 78, " Informacoes Complementares ", "15/05" ) 
SetColor( "15/05" ) 
@ 03,05 Say "Cod.fab: [" + CODFAB + "]" 
@ 04,05 Say "Produto: [" + DESCRI + "]" 
@ 05,05 Say "���������������������������� Detalhamento �����������������������������" 
@ 06,05 Say "� " + DETAL1                                                    +"   �" 
@ 07,05 Say "� " + DETAL2                                                    +"   �" 
@ 08,05 Say "� " + DETAL3                                                    +"   �" 
@ 09,05 Say "����������������������� Reducao da Base p/ ICMs �����������������������" 
@ 10,05 Say "Tabela interna de Reducao.: [" + TABRED + "]-[" + RED->DESCRI + "]" 
@ 11,05 Say "Percentual................: [" + Tran( PERRED, "@E 99.9999" ) + "] %" 
@ 12,05 Say "Observacao na Nota Fiscal.: [" + RED->OBSERV + "]" 
@ 13,05 Say "������������������������� Situacao em Estoque �������������������������" 
@ 14,05 say "Saldo Atual...............: [" + Tran( MPR->SALDO_, "@E 9,999,999.9999" ) + "]" 
@ 15,05 Say "Reservado.................: [" + Tran( MPR->RESERV, "@E 9,999,999.9999" ) + "]" 
@ 16,05 Say "Ordens de Compra..........: [" + Tran( MPR->OCOMP_, "@E 9,999,999.9999" ) + "]" 
@ 17,05 Say "Saldo Dispon�vel p/ venda.: [" + Tran( MPR->SALDO_ - ( MPR->RESERV + MPR->OCOMP_ ), "@E 9,999,999.9999" ) + "]" 
@ 18,05 Say "�����������������������������������������������������������������������" 
SetColor( "14/05" ) 
@ 06,07 Say DETAL1 
@ 07,07 Say DETAL2 
@ 08,07 Say DETAL3 
Inkey( 0 ) 
 
VPBox( 01, 01, 24, 72, " Informacoes de Compra " ) 
IF !Empty( MPR->INDICE ) 
   SetColor( "15/05" ) 
   Scroll( 04, 51, 06, 70 ) 
   @ 04,51 Say "��������������������" 
   @ 05,51 Say "� Saldo: " + Tran( Saldo_, "@E 99,999.999" ) + "�" 
   @ 06,51 Say "��������������������" 
   SetColor( "15/00" ) 
   @ 03,02 Say " Custo Medio do Produto (s/ICMs)     " + Tran( nCustoMedio:= CustoMedio( INDICE ) - IcmMedio( INDICE ),   "@E 999,999.99" ) 
   @ 05,02 Say " Valor Medio de ICMs                 " + Tran( nIcmMedio:=   IcmMedio( INDICE ),     "@E 999,999.99" ) 
   @ 07,02 Say " Custo de Reposicao (C.Medio+ICMs)   " + Tran( nIcmMedio +   nCustoMedio,            "@E 999,999.99" ) 
   @ 09,02 Say " Ultimo Preco Compra Item            " + Tran( UltimoPreco( INDICE ),                "@E 999,999.99" ) 
   @ 11,02 Say " % s/ Pre�o de Custo (Margem Lucro)  " + Tran( PercPv, "@E 9,999.99" ) + " %" 
   @ 13,02 Say " Pre�o de Venda (Sugestivo)          " + Tran( ( ( ( nIcmMedio + nCustoMedio ) * PercPv ) / 100 ) + nIcmMedio + nCustoMedio, "@E 999,999.99" ) 
   SetColor( "14/05" ) 
   @ 15,02 Say "��������������������������������������������������������������������Ŀ" 
   @ 16,02 Say "� Qtd Pe�as em O.C.Pendentes        � " + Tran( OrdensPendentes( INDICE ),          "@R 99999999" ) + " �                     �" 
   @ 17,02 Say "��������������������������������������������������������������������Ĵ" 
   @ 18,02 Say "� Data        �          �          �          �          �          �" 
   @ 19,02 Say "��������������������������������������������������������������������Ĵ" 
   @ 20,02 Say "� Quantidade  �          �          �          �          �          �" 
   @ 21,02 Say "��������������������������������������������������������������������Ĵ" 
   @ 22,02 Say "� O. Compra   �          �          �          �          �          �" 
   @ 23,02 Say "����������������������������������������������������������������������" 
   DBSelectAr( _COD_OC_AUXILIA ) 
   DBSetOrder( 2 ) 
   DBSeek( MPR->INDICE ) 
   nLinData:= 18 
   nColData:= 07 
   nColQuant:= 07 
   nLinQuant:= 20 
   nLinOc:= 22 
   nColOc:= 07 
   WHILE CODPRO == MPR->Indice 
      IF Recebi < Quant_ 
         @ nLinData, nColData+=11 Say DTOC( Entreg ) 
         @ nLinQuant, nColQuant+= 11 Say Tran( Quant_ - Recebi, "@E 99999999" ) 
         @ nLinOc, nColOc+= 11 Say "   " + ORDCMP 
      ENDIF 
      IF nColData > 60 
         Exit 
      ENDIF 
      DBSkip() 
   ENDDO 
   DBSelectAr( _COD_MPRIMA ) 
   Inkey(0) 
ENDIF 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
Function CLEARGETS() 
 
   CLEAR GETS 
 
Return (.T.) 
 
 
Function InfoPorClasse() 
   Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(), nCursor:= SetCursor() 
   Local nArea:= Select(), nOrdem:= IndexOrd(), nTecla, oTb 
   Local aTabela:= {}, nCt, nRow:= 1, lDelimiters 
   Private cCt 
 
   /* Posicionamento nos Arquivos */ 
   CLA->( DBSetOrder( 1 ) ) 
   CLA->( DBSeek( MPR->PCPCLA ) ) 
 
   DBSelectAr( _COD_PDVEAN ) 
   DBSetOrder( 3 ) 
   FOR nCt:= 1 TO 20 
       IF DBSeek( MPR->INDICE + Str( MPR->PCPCLA, 03, 00 ) + Str( nCt, 2, 0 ) + "  0" ) 
          AAdd( aTabela, { PCPTAM, CODIGO, SALDO_, EMBAL_, QTDMIN, QTDMAX } ) 
       ELSE 
          cCt:= StrZero( nCt, 2, 0 ) 
          IF !EMPTY( CLA->TAMA&cCt ) 
             AAdd( aTabela, { nCt, Space( 13 ), 0, 0, 0, 0 } ) 
          ENDIF 
       ENDIF 
   NEXT 
 
   IF Len( aTabela ) <= 0 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      DBSelectAr( nArea ) 
      Return Nil 
   ENDIF 
 
   /* Montagem da Tela de Edicao */ 
   VPBox( 05, 06, 20, 77, " INFORMACOES POR CLASSE/TAMANHOS", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 06,08 Say "Produto " 
   @ 06,17 Say MPR->DESCRI Color _COR_GET_EDICAO 
   @ 07,08 Say "Classe  " 
   @ 07,17 Say CLA->DESCRI Color _COR_GET_EDICAO 
 
   VPBox( 09, 07, 18, 76, , _COR_BROW_BOX, .F., .F. ) 
   SetColor( _COR_BROWSE ) 
   @ 10,08 Say "           Codigo            SALDO   ��������� QUANTIDADE ��������Ŀ" 
   @ 11,08 Say "Tamanhos   Barra Interno     ATUAL   Embalagem     Minima     Maxima" 
   Mensagem( "[ENTER]Altera [G]Grava [ESC]Cancela" ) 
   Ajuda( "[" + _SETAS + "][PgUp][PgDn]Move [ESC]Finaliza" ) 
 
 
   /* Inicializacao do objeto browse */ 
   oTb:=TBrowseNew( 12, 08, 17, 75 ) 
   oTb:addcolumn( tbcolumnnew( ,{|| Tamanho( aTabela[ nRow ][ 1 ] ) + " " + aTabela[ nRow ][ 2 ] + " " + Tran( aTabela[ nRow ][ 3 ], "@e 9,999.9999" ) + " " + ; 
                                       Tran( aTabela[ nRow ][ 4 ], "@e 9,999.9999" ) + " " + Tran( aTabela[ nRow ][ 5 ], "@e 9,999.9999" ) + " " + ; 
                                       Tran( aTabela[ nRow ][ 6 ], "@e 9,999.9999" ) })) 
 
   /* Variaveis do objeto browse */ 
   oTb:GoTopBlock:= {|| nRow:= 1 } 
   oTb:GoBottomBlock:= {|| nRow:= Len( aTabela ) } 
   oTb:SkipBlock:= {|x| SkipperArr( x, aTabela, @nRow ) } 
   oTb:AutoLite:=.f. 
   oTb:dehilite() 
 
   WHILE .T. 
 
      /* Ajuste sa barra de selecao */ 
      oTb:colorrect( { oTb:ROWPOS, 1, oTb:ROWPOS, oTb:COLCOUNT }, { 2, 1 } ) 
      WHILE NextKey()=0 .AND. !oTb:Stabilize() 
      ENDDO 
 
      nTecla:=inkey(0) 
      IF nTecla=K_ESC 
         EXIT 
      ENDIF 
 
      /* Teste da tecla pressionadas */ 
      DO CASE 
         CASE nTecla==K_UP         ;oTb:up() 
         CASE nTecla==K_LEFT       ;oTb:PanLeft() 
         CASE nTecla==K_RIGHT      ;oTb:PanRight() 
         CASE nTecla==K_DOWN       ;oTb:down() 
         CASE nTecla==K_PGUP       ;oTb:pageup() 
         CASE nTecla==K_PGDN       ;oTb:pagedown() 
         CASE nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         CASE nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         CASE nTecla==K_ENTER 
 
              lDelimiters:= Set( _SET_DELIMITERS, .f. ) 
              SetColor( _COR_GET_EDICAO ) 
              @ Row(),19 Get aTabela[ nRow ][ 2 ] 
              @ Row(),33 Get aTabela[ nRow ][ 3 ] Pict "@E 9,999.9999" 
              @ Row(),44 Get aTabela[ nRow ][ 4 ] Pict "@E 9,999.9999" 
              @ Row(),55 Get aTabela[ nRow ][ 5 ] Pict "@E 9,999.9999" 
              @ Row(),66 Get aTabela[ nRow ][ 6 ] Pict "@E 9,999.9999" 
              READ 
              Set( _SET_DELIMITERS, lDelimiters ) 
              SetColor( _COR_BROWSE ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
 
         CASE Chr( nTecla ) $ "Gg" 
              DBSetOrder( 3 ) 
              FOR nCt:= 1 TO Len( aTabela ) 
                  IF !( DBSeek( MPR->INDICE + Str( MPR->PCPCLA, 3, 0 ) + Str( aTabela[ nCt ][ 1 ], 2, 0 ) + " 0" ) ) 
                     DBAppend() 
                  ENDIF 
                  IF netrlock() 
                     Repl CODIGO With aTabela[ nCt ][ 2 ],; 
                          CODPRO With MPR->INDICE,; 
                          PCPCLA With MPR->PCPCLA,; 
                          PCPTAM With aTabela[ nCt ][ 1 ],; 
                          PCPCOR With 0,; 
                          CODEAN With MPR->CODFAB,; 
                          SALDO_ With aTabela[ nCt ][ 3 ],; 
                          EMBAL_ With aTabela[ nCt ][ 4 ],; 
                          QTDMIN With aTabela[ nCt ][ 5 ],; 
                          QTDMAX With aTabela[ nCt ][ 6 ] 
                  ENDIF 
              NEXT 
              EXIT 
         OTHERWISE                 ;Tone(125); Tone(300) 
     ENDCASE 
     oTb:RefreshCurrent() 
     oTb:Stabilize() 
 
   ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   Return Nil 
 
 
Function EditMVA( nSitT02, nMVAPer, nMVAVlr ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cCor:= SetColor(), nCursor:= SetCursor() 
 
   IF nSitT02 == 70 .OR. nSitT02 == 60 
      SetCursor( 1 ) 
 
      VPBOX( 17, 20, 23, 66, " ICMs Substituicao ", _COR_GET_BOX ) 
      SetColor( _COR_GET_EDICAO ) 
      @ 19,22 Say "MVA.............:" Get nMVAPer Pict "@E 999,999.9999" 
      @ 21,22 Say "Valor Pre-fixado:" Get nMVAVlr 
      READ 
   ENDIF 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   Return .T. 

STATIC FuncTion ClasseMargem( cGrupo, cClasse,  nMargem )
Local nArea:= Select()
IF cClasse $ " ABCD"
   IF nMargem == 0
      DBSelectAr( _COD_GRUPO ) 
      IF cClasse=="A"
         nMargem:= MARG_A
      ELSEIF cClasse=="B"
         nMargem:= MARG_B
      ELSEIF cClasse=="C"
         nMargem:= MARG_C
      ELSEIF cClasse=="D"
         nMargem:= MARG_D
      ENDIF
   ENDIF
   DBSelectAr( nArea )
   Return .T.
ELSE
   Return .F.
ENDIF

 
Static Function Tamanho( nCodTamanho ) 
   Priv cTam:= StrZero( nCodTamanho, 2, 0 ) 
   Return CLA->TAMA&cTam 
 
