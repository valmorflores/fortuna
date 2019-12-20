// ## CL2HB.EXE - Converted
/*���������������������������� HEADER ���������������������������*/ 
#include "vpf.ch" 
#include "inkey.ch" 
#include "ptfuncs.ch" 
/*�������������������������� DEVELOPMENT ������������������������*/ 
/* 
����������������������������������������������������������������Ŀ 
� Modulo      � VPC22110                                         � 
� Finalidade  � Controlar o cadastro de PRODUTOS MONTADOS        � 
� Programador � Valmor Pereira Flores                            � 
� Data        � 10/Novembro/1994                                 � 
� Atualizacao � 15/Agosto/1995                                   � 
������������������������������������������������������������������ 
*/ 
FUNCTION AsmInclusao() 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
loca cORIGEM:=spac(3), cUNIDAD:=spac(2), nQTDPES:=0, nESTMIN:=0, nESTMAX:=0,; 
     nPRECOV:=0, nICMCOD:=0, nIPICOD:=0, nCLAFIS:=0, nCLASV_:=0,; 
     cFORNEC:="S", cINDICE:="", nCODFOR:=0, nIPI___:=0,; 
     cTELAR, cCORR, nQTDPRO:=0,; 
     nICM___:=0, nLin, nCol, aAssembly, GETLIST:={} 
loca oTAB, aPRECOS:={}, cSTRING, nTECLA, TECLA, xCOR, nCT, cCODFAB:=spac(12) 
loca cVARIAVEL, cMASCAR, nQUANT_, nDECIM_, nQUEST_, cVERIF_,; 
     dDATA__, cHORA__, nUSUAR_, cQUEST_ 
loca _cMRESER 
loca lFim:=.F. 
priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
priv cDESPRO:=spac(40), cCODFAB2:=spac(12) 
priv cCODIGO:=spac(12), cDESCRI:=spac(40), nORDEMG:=1, cMASCACOD 
priv aTELA1 
priv bMASCARA:="' '+tran(CODIGO,'@R '+M->cxMASCACOD)+'  '+CODFAB+' '+DESCRI+spac(6)" 
priv cxORIGEM, cxMASCACOD, cxMASCQUAN, cxMASCPREC, nROW:=1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen(); usermodulo(" Cadastro de Materia Prima ") 
if !file(_VPB_CONFIG) 
   createvpb(_COD_CONFIG) 
   mensagem("Criando arq. de <mascaras> com configuracao normal, aguarde...") 
   if !fdbusevpb(_COD_CONFIG,2) 
      aviso("ATENCAO! Verifique o arquivo "+; 
         alltrim(_VPB_CONFIG)+".",24/2) 
      mensagem("Erro na abertura do arquivo de configuracao,"+; 
               " tente novamente...") 
      pausa() 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      screenrest(cTELA) 
      return(NIL) 
   endif 
   for nCT:=1 to 5 
      cVARIAVEL:=cMASCAR:="" 
      nQUANT_:=nDECIM_:=0 
      nQUEST_:=cVERIF_:="" 
      dDATA__:=date() 
      cHORA__:="" 
      nUSUAR_:=0 
      cQUEST_:=" " 
      do case 
         case nCT=1 
              cVARIAVEL:="cMASCACOD" 
              cMASCAR:="GGG-NNNN" 
              cVERIF_:="S" 
         case nCT=2 
              cVARIAVEL:="cMASCQUAN" 
              cMASCAR:="999.999,99" 
         case nCT=3 
              cVARIAVEL:="cMASCPREC" 
              cMASCAR:="999.999.999,99" 
         case nCT=4 
              cVARIAVEL:="cORIGEM" 
              cQUEST_:="S" 
         case nCT=5 
              cVARIAVEL:="cASSOCIAR" 
              cQUEST_:="S" 
      endcase 
      dbgotop() 
      locate for alltrim(VARIAV)=cVARIAVEL 
      if eof() 
         if !buscanet(5,{|| dbappend(), !neterr()}) 
            mensagem("::: ERRO NA GRAVACAO DOS DADOS :::") 
            screenrest(cTELA) 
            setcolor(cCOR) 
            setcursor(nCURSOR) 
         endif 
      endif 
      * GRAVACAO DOS DADOS * 
      if netrlock() 
         repl VARIAV with cVARIAVEL, QUANT_ with nQUANT_,; 
              DECIM_ with nDECIM_,   MASCAR with cMASCAR,; 
              VERIF_ with cVERIF_,   DATA__ with date(),; 
              HORA__ with time(),    USUAR_ with nGCODUSER,; 
              QUEST_ with cQUEST_ 
      endif 
   next 
else 
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
endif 
 
 
/*���������������������������� CONFIGURACAO �����������������������*/ 
 
/*� Codigo do Produto �*/ 
LOCATE FOR Variav="cMASCACOD" 
cMascaCod:=Mascar 
cVerif_:=Verif_ 
 
/*� Quantidade ��������*/ 
locate for VARIAV="cMASCQUAN" 
cMASCQUAN:=MASCAR 
 
/*� Valores �����������*/ 
locate for VARIAV="cMASCPREC" 
cMASCPREC:=MASCAR 
 
/*� Origem? �����������*/ 
locate for VARIAV="cORIGEM" 
M->cxORIGEM:=QUEST_ 
 
locate for VARIAV="cASSOCIAR" 
cASSOCIAR:=QUEST_ 
 
 
/*����������������������� ABERTURA DE ARQUIVOS ��������������������*/ 
 
/*��������������������������������������Ŀ 
  � ORIGENS                              � 
  ����������������������������������������*/ 
 
  IF M->cxOrigem="S" 
     IF !FILE( _VPB_ORIGEM ) 
        Mensagem("Arquivo de origens nao encontrado. Pressione [ENTER] para continuar.") 
        Pausa() 
        lFim:= .T. 
     ELSEIF !FDBUseVpb( _COD_ORIGEM, 2 ) 
        Aviso("ATENCAO! Verifique o arquivo " + ALLTRIM( _VPB_ORIGEM ) + "." , 24/2) 
        mensagem("Arquivo de origens nao esta disponivel. Tente novamente...") 
        pausa() 
        lFim:= .T. 
     ENDIF 
  ENDIF 
 
/*��������������������������������������Ŀ 
  � FORNECEDORES                         � 
  ����������������������������������������*/ 
 
  IF !lFim 
     IF !FILE( _VPB_FORNECEDOR ) 
        Mensagem("Arquivo de fornecedores nao encontrado, pressione [ENTER] para continuar...") 
        Pausa() 
        lFim:= .T. 
     ENDIF 
     IF !FdbuseVpb( _COD_FORNECEDOR ) 
        Aviso("ATENCAO! Verifique o arquivo " + ALLTRIM( _VPB_FORNECEDOR ) + ".", 24 / 2 ) 
        Mensagem("Arquivo de fornecedores nao esta disponiovel, tente novamente...") 
        Pausa() 
        lFim:= .T. 
     ENDIF 
  ENDIF 
 
/*��������������������������������������Ŀ 
  � PRECOS POR FORNECEDOR                � 
  ����������������������������������������*/ 
 
  IF !lFim 
     IF !FILE( _VPB_PRECOXFORN ) 
        Mensagem( "Criando arquivo de precos x fornecedores, aguarde..." ) 
        createvpb( _COD_PRECOXFORN ) 
     ENDIF 
     IF !FdbUseVpb( _COD_PRECOXFORN, 2 ) 
        Aviso( "ATENCAO! Verifique o arquivo " + ALLTRIM( _VPB_FORNECEDOR )+".", 24 / 2 ) 
        Mensagem("Arquivo de Precos x Fornecedores nao esta disponivel...") 
        Pausa() 
        lFim:= .T. 
     ENDIF 
  ENDIF 
 
/*��������������������������������������Ŀ 
  � CLASSIFICACAO FISCAL                 � 
  ����������������������������������������*/ 
 
  IF !lFim 
     IF !FILE( _VPB_CLASFISCAL ) 
        Mensagem("Arquivo de clas. fiscal nao encontrado, pressione [ENTER] p/ continuar...") 
        Pausa() 
        lFim:=.T. 
     ELSEIF !FdbUseVpb( _COD_CLASFISCAL, 2 ) 
        Aviso("ATENCAO! Verifique o arquivo " + ALLTRIM( _VPB_CLASFISCAL ) + ".", 24 / 2 ) 
        Mensagem("Arquivo de classificacao fiscal nao disponivel...") 
        Pausa() 
        lFim:= .T. 
     ENDIF 
  ENDIF 
 
/*��������������������������������������Ŀ 
  � MATERIA-PRIMA                        � 
  ����������������������������������������*/ 
  IF !lFim 
     IF !FILE( _VPB_MPRIMA ) 
         CreateVpb( _COD_MPRIMA ) 
     ENDIF 
     IF !FdbUseVpb( _COD_MPRIMA ) 
        Aviso("ATENCAO! Verifique o arquivo " + ALLTRIM( _VPB_MPRIMA ) + ".", 24 / 2 ) 
        Mensagem("Arquivo de produtos nao disponivel, tente novamente...") 
        Pausa() 
     ENDIF 
  ENDIF 
 
/*��������������������������������������Ŀ 
  � ARQUIVO DE ASSEMBLY                  � 
  ����������������������������������������*/ 
  IF !lFim 
     IF !FILE( _VPB_ASSEMBLER ) 
        CreateVpb( _COD_ASSEMBLER ) 
     ENDIF 
     IF !FdbUseVpb( _COD_ASSEMBLER ) 
        Aviso("ATENCAO! Verifique o arquivo " + ALLTRIM( _VPB_ASSEMBLER ) + ".", 24 / 2 ) 
        Mensagem("Aquivo de montagem nao disponivel, tente novamente...") 
        Pausa() 
        lFim:= .T. 
     ENDIF 
  ENDIF 
 
  IF lFim 
     ScreenRest( cTela ) 
     Mensagem("Aguarde, fechando arquivos de dados...",1) 
     DBUNLOCKALL() 
     FechaArquivos() 
     SETCOLOR( cCor ) 
     SETCURSOR( nCursor ) 
     RETURN Nil 
  ENDIF 
 
/*����������������������� FORMULARIO DE ENTRADA �������������������*/ 
 
  VPBOX( 1, 0, 24 - 2, 79,, _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
 
/*����������������������� VARIAVEIS DE MASCARA ��������������������*/ 
 
  M->_cMRESER:=STRTRAN( M->cMASCACOD, ".", "" ) 
  M->_cMRESER:=STRTRAN( M->_cMRESER, "-", "" ) 
  M->_cMRESER:=ALLTRIM( M->_cMRESER ) 
 
  M->_PIGRUPO:=AT( "G", M->_cMRESER );  M->_QTGRUPO:= StrVezes("G", M->_cMRESER) 
  M->_PICODIG:=AT( "N", M->_cMRESER );  M->_QTCODIG:= StrVezes("N", M->_cMRESER) 
 
 
  M->cxMASCACOD:=mascstr(M->cMASCACOD,1) 
  M->cxMASCQUAN:=mascstr(M->cMASCQUAN,2) 
  M->cxMASCPREC:=mascstr(M->cMASCPREC,2) 
  M->cCODIGO:=strtran(M->cxMASCACOD,".","") 
  M->cCODIGO:=strtran(M->cCODIGO,"-","") 
  M->cCODIGO:=alltrim(M->cCODIGO) 
  M->cCODIGO:=strtran(M->cCODIGO,"9"," ") 
 
  IF LEN( cCODIGO ) < 1 
     Mensagem("Problema na configuracao de mascaras. Verifique no modulo (143M).",1) 
     Pausa() 
     ScreenRest( cTela ) 
     SETCOLOR( cCor ) 
     SETCURSOR( nCursor ) 
     RETURN Nil 
  ENDIF 
 
/*���������������������������� MAIN MODULE ������������������������*/ 
 
  WHILE .T. 
 
     DBSELECTAR(_COD_MPRIMA) 
     SETCOLOR( _COR_GET_EDICAO ) 
     nLin:=2 
     nCol:=3 
 
             /*������������������ͻ 
     ���������͹ ENTRADA DE DADOS ����������� 
               ������������������ͼ*/ 
 
     @ nLin++, nCol say "Codigo..............:" get cCODIGO pict "@R "+M->cxMASCACOD valid digitover(@cCODIGO,cMASCACOD) when mensagem("Digite o codigo para produto.") 
     @ nLin++, nCol say "Codigo Fab..........:" get cCODFAB when mensagem("Digite o codigo de fabrica do produto.") 
     @ nLin++, nCol say "Descricao...........:" get cDESCRI pict "@!" when mensagem("Digite a descricao do produto.") 
     @ nLin++, nCol say "Unidade de Medida...:" get cUNIDAD when mensagem("Digite a unidade de medida do produto.") 
     IF M->cxOrigem=="S" 
        @ nLin++, nCol say "Origem/Fabricante...:" get cORIGEM pict "@!" valid oseleciona(@cORIGEM) when mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
     ENDIF 
     IF cAssociar=="S" 
        @ nLin++, nCol say "Medida Unitaria.....:" get nQTDPES pict "@E 999,999.9999" when mensagem("Digite o peso, tamanho ou quantidade de pecas do produto.") 
     ENDIF 
     @ nLin++, nCol say "Preco venda.........:" get nPRECOV pict "@E 999,999,999.999" when Mensagem("Digite o preco de venda do produto.") 
     @ nLin++, nCol say "Cod.Tributavel (ICM):" get nICMCOD pict "9" valid classtrib(@nICMCOD,1) when Mensagem("Digite o codigo tributavel do produto para ICMs.") 
     @ nLin++, nCol say "Cod.Tributavel (IPI):" get nIPICOD pict "9" valid classtrib(@nIPICOD,2) when Mensagem("Digite o codigo de tributacao do IPI.") 
     @ nLin++, nCol say "Classificacao fiscal:" get nCLAFIS pict "999" valid verclasse(@nCLAFIS) when Mensagem("Digite o codigo de classificacao fiscal do produto.") 
     @ nLin++, nCol say "Classif.de vendas...:" get nCLASV_ pict "9" when Mensagem("Digite [1] para controlar baixa estoque ou [0] cancelar controle.") 
     @ nLin++, nCol say "Estoque minimo......:" get nESTMIN pict "@E "+M->cxMASCQUAN when Mensagem("Digite a quantidade permitida para estoque minimo.") 
     @ nLin++, nCol say "Estoque maximo......:" get nESTMAX pict "@E "+M->cxMASCQUAN when Mensagem("Digite a quantidade valida para estoque maximo.") 
     @ nLin++, nCol say "% p/ calculo do IPI.:" get nIPI___ pict "999.99" when Mensagem("Digite o percentual para calculo do IPI.") 
     @ nLin++, nCol say "% p/ calculo do ICMs:" get nICM___ pict "999.99" when Mensagem("Digite o percentual para calculo do ICMs.") 
     READ 
     IF LASTKEY()=K_ESC; EXIT; ENDIF 
 
                /*������������������ͻ 
     ������������͹ INPUT - PRODUTOS ������������� 
                  ������������������ͼ*/ 
 
     cTela3:= ScreenSave( 00, 00, 24, 79 ) 
     VPBox( 05, 10, 24 - 3, 79 - 3, "Produtos", _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
     nPRECO_:=0 
     nQUANT0:=0 
     @ 06,11 Say "Produto...: " + cCODFAB + " - " + Left( cDESCRI, 40 ) 
     @ 07,11 Say "Preco Comp: " + TRAN( nPRECOV, "@E 99,999,999.9999" ) + TRAN( nPRECO_, "@E 99,999,999.9999" ) 
     @ 08,11 Say "Quantidade: " + TRAN( nQUANT0, "@E 9,999.9999" ) 
     @ 09,11 Say Repl("�",65) 
     @ 10,11 Say " Codigo  Quantidade     Descricao" 
     cCODIGO_:=REPL( " ", LEN( cCodigo ) ) 
     cCODRES:=cCODIGO_ 
     aASSEMBLY:={} 
     nLIN:=10 
     WHILE .T. 
         dbselectar(_COD_MPRIMA) 
         dbsetorder(3) 
         nCODPRO:=0 
         nQTDPRO:=0 
         @ ++nLIN,12 get nCODPRO pict "9999" valid pesquisadados(@nCODPRO) when mensagem("Digite o c�digo do produto.") 
         @ nLIN,20 get nQTDPRO pict "@E 9,999.999" when mensagem("Digite a quantidade de produtos.") 
         read 
         If LastKey() == K_ESC 
            exit 
         Else 
            @ nLIN,35 say substr(cDESPRO,1,38) 
            nPRECO_+= ( nQTDPRO * PRECOV ) 
            nQUANT0+= nQTDPRO 
            @ 07,23 Say TRAN( nPRECOV, "@E 99,999,999.9999" ) + TRAN( nPRECO_, "@E 99,999,999.9999" ) 
            @ 08,23 Say TRAN( nQUANT0, "@E 9,999.9999" ) 
         EndIf 
         IF nLin==24-4 
            scroll(11,11,24-4,79-4,1) 
            --nLIN 
         ENDIF 
         AADD( aASSEMBLY, { STRZERO( nCODPRO, 8, 0 ), cCODIGO_, nQTDPRO } ) 
     ENDDO 
 
     IF Confirma( 24-3, 63, "Confirma?", "Digite [S] para confirmar o cadastramento do produto.","S", M->Cor[16]+","+M->Cor[18]+",,,"+M->Cor[17]) 
 
        ScreenRest( cTela3 ) 
        cTELAR:=ScreenSave(00,00,24,79) 
        Aviso(" Aguarde! Gravando... ",24/2) 
        Mensagem("Gravando arquivo de produtos...",1) 
        cIndice:= SUBSTR( cCODIGO, M->_PIGRUPO, M->_QtGRUPO ) + SUBSTR( cCODIGO, M->_PICODIG, M->_QtCODIG ) 
        cCodRed:= SUBSTR( cCODIGO, M->_PICODIG, M->_QtCODIG) 
 
                  /*���������������������ͻ 
        �����������͹ GRAVACAO EM ARQUIVO �������������� 
                    ���������������������ͼ*/ 
 
        IF BuscaNet( 5, {|| DBAPPEND(), !NETERR() } ) 
 
           Mensagem("Gravando arquivo de produtos...",1) 
 
           REPLACE Codigo WITH cCodigo, CodFab WITH cCodFab,; 
                   Descri WITH cDescri, Indice WITH cIndice,; 
                   MPrima WITH "N",     Unidad WITH cUnidad,; 
                   QtdPes WITH nQtdPes, EstMin WITH nEstMin,; 
                   EstMax WITH nEstMax, PrecoV WITH nPrecoV,; 
                   IcmCod WITH nIcmCod, IpiCod WITH nIpiCod,; 
                   ClaFis WITH NClaFis, ClasV_ WITH nClasV_,; 
                   Origem WITH cOrigem, Assoc_ WITH cAssociar,; 
                   CodRed WITH cCodRed, Ipi___ WITH nIpi___,; 
                   CodFor WITH nCodFor, Icm___ WITH nIcm___ 
 
           Mensagem("Gravando arquivo de montagem...",1) 
 
           DBSELECTAR( _COD_ASSEMBLER ) 
 
           FOR nCt:=1 TO LEN( aAssembly ) 
               IF BuscaNet( 5, {|| DBAPPEND(), !NETERR() } ) 
                  REPLACE CodPrd WITH aAssembly[nCt][1],; 
                          CodMpr WITH aAssembly[nCt][2],; 
                          Quant_ WITH aAssembly[nCT][3] 
               ENDIF 
               ++nCt 
           NEXT 
 
           DBUNLOCKALL() 
 
           cORIGEM=spac(3) 
           cUNIDAD=spac(2) 
           nQTDPES=0 
           nESTMIN=0 
           nESTMAX=0 
           nPRECOV=0 
           nICMCOD=0 
           nCLAFIS=0 
           nCLASV_=0 
           cFORNEC="S" 
           cINDICE="" 
           screenrest(cTELAR) 
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
  @ 13,03 say "% p/ calculo do IPI.:" 
  @ 14,03 say "Fornecedor..........:" 
  @ 15,03 say "Preco x Fornecedor..:" 
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
//* 
stat func mascstr(VDM,nCOD) 
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
*// 
 
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
func asmmostra() 
loca cCOR:=setcolor() 
  setcolor(M->Cor[10]) 
  @ 02,26 say CODIGO pict "@R "+M->cxMASCACOD 
  @ 02,54 say CODFAB 
  @ 03,26 say DESCRI pict "@!" 
  if cxORIGEM="S" 
     @ 04,26 say ORIGEM 
  else 
     @ 04,25 say "Nao utilizada" 
  endif 
  @ 05,26 say UNIDAD 
  if cASSOCIAR="S" 
     @ 06,26 say QTDPES pict "@E 999,999.9999" 
  else 
     @ 06,25 say "Nao utilizada" 
  endif 
  @ 07,26 say PRECOV pict "@E 999,999,999.999" 
  @ 08,32 say ICMCOD pict "9" 
  @ 08,41 say IPICOD pict "9" 
  @ 09,26 say CLAFIS pict "999" 
  @ 10,26 say CLASV_ pict "9" 
  @ 11,26 say ESTMIN pict "@E "+cxMASCQUAN 
  @ 12,26 say ESTMAX pict "@E "+cxMASCQUAN 
  @ 13,26 say IPI___ pict "999.99" 
  @ 14,26 say CODFOR pict "999" 
  @ 15,26 say "*" 
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
stat func exibedbf(cPCODIGO) 
loca nLIN:=16, nREGISTROS 
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
setcolor(M->Cor[21]) 
scroll(nLIN+1,nCOL,24-2,79-2) 
for nCT:=0 to nREGISTROS 
    if nORDEMG=1 
       if cPCODIGO<>NIL 
          setcolor(if(alltrim(CODRED)=alltrim(cPCODIGO),M->Cor[22],M->Cor[21])) 
       endif 
    elseif nORDEMG=2 
       setcolor(if(DESCRI=cDESCRI,M->Cor[22],M->Cor[21])) 
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
*C 
*/ 
stat func pesquisadbf(nPMOD) 
  loca nCURSOR:=setcursor(), cCOR:=setcolor(), oTB,; 
       cTELA:=screensave(24-1,00,24,79) 
  loca nLIN:=16 
  loca nREGISTROS:=24-(nLIN+4) 
  loca aTELA 
  loca cCODPESQ 
  dbselectar(_COD_MPRIMA) 
  if alltrim(cCODIGO)="" 
     dbgotop() 
  else 
     cCODPESQ:=substr(cCODIGO,M->_PIGRUPO,M->_QtGRUPO)+; 
               substr(cCODIGO,M->_PICODIG,M->_QtCODIG) 
     if nORDEMG=1 
        locate for alltrim(INDICE)=alltrim(cCODPESQ) 
        dbskip(-nREGISTROS) 
     elseif nORDEMG=2 
        locate for DESCRI=cDESCRI 
     endif 
  endif 
  aTELA:=boxsave(01,01,24-2,79-1) 
  setcursor(0) 
  setcolor(M->Cor[21]+","+M->Cor[22]+",,,"+M->Cor[17]) 
  boxrest(aTELA1) 
  dispbox(nLIN,01,24-2,79-1,2) 
  if valtype(nPMOD)=="C" 
     nPMOD=if(nPMOD="MPRINCLUSA" .OR. nPMOD="MPRALTERA",1,nPMOD) 
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
     asmmostra() 
     cCODIGO=alltrim(CODIGO) 
     TECLA:=inkey(0) 
     nPMOD:=if(nPMOD=NIL,1,nPMOD) 
     if valtype(nPMOD)=="C" 
        nPMOD=if(nPMOD="MPRINCLUSA" .OR. nPMOD="MPRALTERA",1,nPMOD) 
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
                if lastrec()>0 .AND. CODIGO<>spac(12) 
                   @ 01,01 say "Alteracao" 
                   asmaltera() 
                   @ 01,01 say "Inclusao" 
                endif 
             elseif nPMOD==2 
                if(lastrec()>0 .AND. val(CODIGO)<>0,exclui(oTB),nil) 
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
*      Modulo - MPRALTERA 
*  Finalidade - Alteracao de materia prima (Produtos). 
* Programador - Valmor Pereira Flores 
*        Data - 15/Junho/1993 
* Atualizacao - 30/Novembro/1994 
* 
*/ 
func asmaltera() 
loca nCURSOR:=setcursor() 
loca cTELA:=screensave(00,00,24,79) 
loca cCOR:=setcolor() 
loca GETLIST:={} 
loca cCODIGO:=CODIGO,; 
     cDESCRI:=DESCRI,; 
     cCODFAB:=CODFAB,; 
     cORIGEM:=ORIGEM,; 
     cUNIDAD:=UNIDAD,; 
     nQTDPES:=QTDPES,; 
     nPRECOV:=PRECOV,; 
     nICMCOD:=ICMCOD,; 
     nIPICOD:=IPICOD,; 
     nCLAFIS:=CLAFIS,; 
     nCLASV_:=CLASV_,; 
     nESTMIN:=ESTMIN,; 
     nESTMAX:=ESTMAX,; 
     nIPI___:=IPI___,; 
     nCODFOR:=CODFOR,; 
     cFORNEC:="S",; 
     aPRECOS:={},; 
     cSTRING:="",; 
     nROW:=1 
 
  @ 02,03 say "Codigo..............: "+tran(cCODIGO,"@R "+cxMASCACOD) 
  @ 02,40 say "Codigo Fab.:" get cCODFAB when; 
    mensagem("Digite o codigo de fabrica do produto.") 
  @ 03,03 say "Descricao...........:" get cDESCRI pict "@!" when; 
    mensagem("Digite a descricao do produto.") 
  @ 04,03 say "Origem/Fabricante...:" 
    if cxORIGEM="S" 
       @ 04,25 get cORIGEM pict "@!" valid oseleciona(@cORIGEM) when; 
         mensagem("Digite a abreveatura da origem ou [999] p/ ver na lista.") 
    else 
       @ 04,25 say "Nao utilizada" 
    endif 
  @ 05,03 say "Unidade de Medida...:" get cUNIDAD when; 
    mensagem("Digite a unidade de medida do produto.") 
  @ 06,03 say "Medida Unitaria.....:" 
  if cASSOCIAR="S" 
     @ 06,25 get nQTDPES pict "@E 999,999.9999" when; 
      mensagem("Digite o peso, tamanho ou quantidade de pecas do produto.") 
  else 
     @ 06,25 say "Nao utilizada" 
  endif 
  @ 07,03 say "Preco venda.........:" get nPRECOV pict "@E 999,999,999.999"; 
    when mensagem("Digite o preco de venda do produto.") 
  @ 08,03 say "Cod. Tributavel.....: ICMs:" get nICMCOD pict "9"; 
    valid classtrib(@nICMCOD,1) when; 
    mensagem("Digite o codigo tributavel do produto p/ ICMs.") 
  @ 08,35 say "IPI:" get nIPICOD pict "9"; 
    valid classtrib(@nIPICOD,2) when; 
    mensagem("Digite o codigo de tributacao do IPI.") 
  @ 09,03 say "Classificacao fiscal:" get nCLAFIS pict "999" valid; 
    verclasse(@nCLAFIS) when; 
    mensagem("Digite o codigo de classificacao fiscal do produto.") 
  @ 10,03 say "Classif.de vendas...:" get nCLASV_ pict "9" when; 
    mensagem("Digite [1] p/ controlar baixa estoque ou [0] cancelar controle.") 
  @ 11,03 say "Estoque minimo......:" get nESTMIN pict "@E "+cxMASCQUAN when; 
    mensagem("Digite a quantidade permitida para estoque minimo.") 
  @ 12,03 say "Estoque maximo......:" get nESTMAX pict "@E "+cxMASCQUAN when; 
    mensagem("Digite a quantidade valida para estoque maximo.") 
  @ 13,03 say "% p/ calculo do IPI.:" get nIPI___ pict "999.99" when; 
    mensagem("Digite o percentual p/ calculo do IPI.") 
  @ 14,03 say "Fornecedor..........:" get nCODFOR pict "999" valid; 
    forseleciona(@nCODFOR) when; 
    mensagem("Digite o codigo do fornecedor.") 
  @ 15,03 say "Preco x Fornecedor..:" get cFORNEC pict "!" ; 
    valid cFORNEC$"SN" when; 
    mensagem("Digite [S] p/incluir (precos x fornec.) ou [N] p/ cancelar.") 
  read 
  if lastkey()<>K_ESC 
     if cFORNEC="S" 
        //* PRECOS POR FORNECEDOR *// 
        mensagem("Aguarde, pesquisando a tabela geral de precos.",1) 
        dbselectar(_COD_FORNECEDOR) 
        dbgotop() 
        aPRECOS:={} 
        whil ! eof() 
           aadd(aPRECOS,{CODIGO,DESCRI,0.00}) 
           dbskip() 
        enddo 
        dbselectar(_COD_PRECOXFORN) 
        dbsetorder(2) 
        cINDICE:=substr(cCODIGO,M->_PIGRUPO,M->_QtGRUPO)+; 
                 substr(cCODIGO,M->_PICODIG,M->_QtCODIG) 
        set filter to CPROD_=cINDICE 
        for nCT:=1 to len(aPRECOS) 
            mensagem("Pesquisando na tabela de precos do fornecedor "+; 
                     alltrim(str(nCT))+", aguarde...") 
            dbgotop() 
            if dbseek(aPRECOS[nCT][1]) 
               aPRECOS[nCT][3]=VALOR_ 
            endif 
        next 
        set filter to 
        //* nROW:=if(nCODFOR<>0 .AND. nCODFOR<=len(aPRECOS),nCODFOR,1) *// 
        //* SALVAR STATUS ANTERIOR *// 
        cCORR:=setcolor() 
        cTELAR:=screensave(00,00,24,79) 
        //* FORMATAR TELA *// 
        setcolor(M->Cor[21]+","+M->Cor[22]) 
        setcursor(0) 
        ajuda("["+_SETAS+"][PgDn][PgUp]Move "+; 
              "[ENTER][.0123456789]Edita [ESC]Retorna") 
        mensagem("Pressione ENTER, digite VALOR ou pressione ESC para retornar.") 
        vpbox(03,06,24-8,75,"PRECOS na memoria",M->Cor[20],.T.,.T.,M->Cor[19]) 
        //* EXIBIR DADOS *// 
        oTAB:=tbrowsenew(04,07,24-9,74) 
        oTAB:addcolumn(tbcolumnnew(,{|| aPRECOS[nROW][1]})) 
        oTAB:addcolumn(tbcolumnnew(,{|| substr(aPRECOS[nROW][2],1,40)})) 
        oTAB:addcolumn(tbcolumnnew(,{|| tran(aPRECOS[nROW][3],"@E 999,999,999.999")})) 
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
                   setcolor(M->Cor[20]+","+M->Cor[17]) 
                   @ oTAB:ROWPOS+3,56 get aPRECOS[nROW][3]; 
                     pict "@E 999,999,999.999" 
                   read 
                   setcolor(xCOR) 
                   oTAB:down() 
                   set(_SET_DELIMITERS,.T.) 
              case chr(TECLA)$"1234567890" 
                   setcolor(M->Cor[17]) 
                   cSTRING:=chr(TECLA) 
                   @ oTAB:ROWPOS+3,56 say cSTRING+spac(15-len(cSTRING)) 
                   for nCT:=1 to 15 
                       nTECLA:=inkey(0) 
                       if nTECLA=K_BS 
                          cSTRING:=substr(cSTRING,1,len(cSTRING)-1) 
                       endif 
                       if chr(nTECLA)$"1234567890." 
                          cSTRING:=cSTRING+chr(nTECLA) 
                       else 
                          --nCT 
                       endif 
                       @ oTAB:ROWPOS+3,56 say cSTRING+spac(15-len(cSTRING)) 
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
        Setcolor(cCORR) 
     endif 
     dbselectar(_COD_MPRIMA) 
     if confirma(16,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento do produto.","S",; 
        M->Cor[16]+","+M->Cor[18]+",,,"+M->Cor[17]) 
        cTELAR:=screensave(00,00,24,79) 
        aviso(" Aguarde! Gravando... ",24/2) 
        mensagem("Gravando arquivo de produtos...",1) 
        if netrlock(5) 
           cINDICE:=substr(cCODIGO,M->_PIGRUPO,M->_QtGRUPO)+; 
                    substr(cCODIGO,M->_PICODIG,M->_QtCODIG) 
           cCODRED:=substr(cCODIGO,M->_PICODIG,M->_QtCODIG) 
           repl CODIGO with cCODIGO, CODFAB with cCODFAB,; 
                DESCRI with cDESCRI, INDICE with cINDICE,; 
                MPRIMA with "S",     UNIDAD with cUNIDAD,; 
                QTDPES with nQTDPES, ESTMIN with nESTMIN,; 
                ESTMAX with nESTMAX,; 
                PRECOV with nPRECOV, ICMCOD with nICMCOD,; 
                IPICOD with nIPICOD, CLAFIS with nCLAFIS,; 
                CLASV_ with nCLASV_, ORIGEM with cORIGEM,; 
                ASSOC_ with cASSOCIAR,; 
                CODRED with cCODRED, IPI___ with nIPI___, CODFOR with nCODFOR 
           mensagem("Gravando arquivo de precos x fornecedores...",1) 
           dbselectar(_COD_PRECOXFORN) 
           dbsetorder(2) 
           set filter to CPROD_=cINDICE 
           if netrlock(5) 
              dele all 
              for nCT:=1 to len(aPRECOS) 
                 if aPRECOS[nCT][3]<>0 
                    repl CPROD_ with cINDICE, CODFOR with aPRECOS[nCT][1],; 
                         VALOR_ with aPRECOS[nCT][3] 
                 endif 
              next 
           endif 
           dbunlock() 
           setcolor(M->Cor[21]) 
           dispbox(16,58,16,77,2)            && Refaz parte detonada p/confirma 
           mensagem("Limpando os dados inutilizaveis, aguarde...",1) 
           dbselectar(_COD_MPRIMA) 
           //screenrest(cTELAR) 
        endif 
     endif 
  endif 
  set key K_TAB to pesquisadbf(2) 
  screenrest(cTELA) 
  setcursor(nCURSOR) 
  setcolor(cCOR) 
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
  vpbox(12,45,16,69," Pesquisa ",M->Cor[20],.T.,.F.,M->Cor[19]) 
  setcolor(M->Cor[21]+","+M->Cor[22]) 
  aadd(MENULIST,; 
  menunew(13,46,smBUSCA[1][1],2,M->Cor[19],smBUSCA[1][2],,,M->Cor[6],.T.)) 
  aadd(MENULIST,; 
  menunew(14,46,smBUSCA[2][1],2,M->Cor[19],smBUSCA[2][2],,,M->Cor[6],.T.)) 
  aadd(MENULIST,; 
  menunew(15,46," 0 Encerramento       ",2,M->Cor[19],; 
     "Executa a finalizacao da rotina de pesquisa.",,,M->Cor[6],.T.)) 
  menumodal(MENULIST,@nOPCAO); MENULIST:={} 
  ajuda("["+_SETAS+"]Movimenta [ENTER]Confirma [ESC]Cancela") 
  oPOBJ:gotop() 
  do case 
     case nOPCAO=1 
          cCOD:=strtran(cxMASCACOD,".","") 
          cCOD:=strtran(cCOD,"-","") 
          cCOD:=alltrim(cCOD) 
          cCOD:=strtran(cCOD,"9"," ") 
          vpbox(11,25,13,48,"",M->Cor[20],.T.,.F.,M->Cor[19]) 
          @ 12,26 say "C�digo " get cCOD pict "@R "+cxMASCACOD when; 
            mensagem("Digite o c�digo para pesquisa.") 
          read 
          mensagem("Executando a pesquisa pelo codigo, aguarde...") 
          cINDICE:=substr(cCOD,M->_PIGRUPO,M->_QtGRUPO)+; 
                   substr(cCOD,M->_PICODIG,M->_QtCODIG) 
          cINDICE:=cINDICE+space(12-len(cINDICE)) 
          dbsetorder(1) 
          dbseek(cINDICE) 
     case nOPCAO=2 
          vpbox(11,16,13,63,"",M->Cor[20],.T.,.F.,M->Cor[19]) 
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
func asmalteracao 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca _cMRESER 
  priv aTELA1, aTELA 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  priv cCODIGO:=spac(12), cDESCRI:=spac(40), nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
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
        mensagem("Arq. de origens nao encontrado, press [ENTER] para continuar.") 
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
              " pressione [ENTER] para continuar...") 
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
  if !file(_VPB_CLASFISCAL) 
     mensagem("Arquivo de clas. fiscal nao encontrado,"+; 
              " pressione [ENTER] p/ continuar...") 
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
  setcolor(M->Cor[16]) 
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
     exibestru() 
     pesquisadbf(1) 
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
func asmexclusao 
  loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
  loca _cMRESER 
  priv aTELA1, aTELA 
  priv _PIGRUPO, _QTGRUPO, _PICODIG, _QTCODIG 
  priv cCODIGO:=spac(12), cDESCRI:=spac(40), nORDEMG:=1                         && Var c/ ordem geral do arquivo. 
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
        mensagem("Arq. de origens nao encontrado, press [ENTER] para continuar.") 
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
              " pressione [ENTER] para continuar...") 
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
  if !file(_VPB_CLASFISCAL) 
     mensagem("Arquivo de clas. fiscal nao encontrado,"+; 
              " pressione [ENTER] p/ continuar...") 
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
  setcolor(M->Cor[16]) 
  scroll(01,01,24-2,79-1) 
  vpbox(10,01,10,79-1," Arquivo ",M->Cor[16],.F.,.F.,M->Cor[16]) 
  aTELA1:=boxsave(01,01,10,79-1) 
  whil lastkey()<>K_ESC 
     ajuda("["+_SETAS+"][PgDn][PgUp]Movimenta [TAB]Exclui [ESC]Cancela") 
     exibestru() 
     pesquisadbf(2) 
  enddo 
  set key K_TAB to 
  dbunlockall() 
  FechaArquivos() 
  setcolor(cCOR) 
  setcursor(nCURSOR) 
  screenrest(cTELA) 
return nil 
 
******************************************************************************* 
Static Function PesquisaDados( Produto ) 
  Local cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
        nCURSOR:=setcursor(), oPROD, TECLA, nAREA:=select() 
  Private nORDEMG:=1, nCODIGO:=0, nDESCRI:=space(45), aTELA1, nFLAGVEN:=1 
  nORDEM:=indexord() 
  dbsetorder(3) 
  if dbseek(strzero(PRODUTO,_QTCODIG,0)) 
     cDESPRO:=CODFAB+" - "+DESCRI 
     cCODFAB2:=CODFAB 
     dbsetorder(nORDEM) 
  else 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
     usermodulo(" Verificacao do Arquivo de Produtos ") 
     dbselectar( _COD_MPRIMA ) 
     dbgotop() 
     setcursor(0) 
     setcolor( _COR_BROWSE ) 
     vpbox( 2, 11, 4, 79 - 10 , , _COR_BROWSE_BOX, .F., .F., _COR_BROWSE_TITULO ) 
     vpbox( 5, 11, 24 - 5, 79 - 10, , _COR_BROWSE_BOX, .F., .F., _COR_BROWSE_TITULO ) 
     Mensagem("Pressione [ENTER] para selecionar ou [ESC] para cancelar...") 
     ajuda("["+_SETAS+"][PgUp][PgDn]Move [F2]Pesq [F3]Codigo [F4]Fabrica [F5]Nome") 
 
     oPROD:=TBrowseDb( 6, 12, 24 - 6, 79 - 11 ) 
     oPROD:AddColumn( TbcolumnNew(, {|| AllTrim( CODRED ) + " => " + CODFAB + " " + DESCRI + Space(11) })) 
     oPROD:AUTOLITE:=.f. 
     oPROD:dehilite() 
     VPBox( 24 - 4, 11, 24 - 2, 79 - 10, , M->Cor[21], .F., .F. ) 
     if nORDEMG=1 
        @ 03,12 say "Ordem: Codigo de acesso interno.    " 
     elseif nORDEMG=4 
        @ 03,12 say "Ordem: Codigo de fabrica do produto." 
     elseif nORDEMG=2 
        @ 03,12 say "Ordem: Descricao do produto.        " 
     endif 
     whil .t. 
        oPROD:colorrect({oPROD:ROWPOS,1,oPROD:ROWPOS,1},{2,1}) 
        whil nextkey()=0 .and.! oPROD:stabilize() 
        enddo 
        nCODPRO=val(CODRED) 
        @ 24-3,12 say spac(44) 
        if SALDO_<ESTMIN 
           @ 24-3,12 say "Produto abaixo do estoque m�nimo: " + alltrim(str(SALDO_,5,0)) 
        else 
           @ 24-3,12 say "Saldo do produto: "+alltrim(str(SALDO_,5,0)) 
        endif 
        TECLA:=inkey(0) 
        if TECLA=K_ESC 
           exit 
        endif 
        do case 
           case TECLA==K_UP         ;oPROD:up() 
           case TECLA==K_LEFT       ;oPROD:up() 
           case TECLA==K_RIGHT      ;oPROD:down() 
           case TECLA==K_DOWN       ;oPROD:down() 
           case TECLA==K_PGUP       ;oPROD:pageup() 
           case TECLA==K_PGDN       ;oPROD:pagedown() 
           case TECLA==K_END        ;oPROD:gotop() 
           case TECLA==K_HOME       ;oPROD:gobottom() 
           case TECLA==K_F2         ;pesquisaproduto(oPROD,; 
                     {{" 1 Cod. fabrica       ",; 
                       "Pesquisa pelo codigo de fabrica do produto."},; 
                      {" 2 Nome do produto    ",; 
                       "Pesquisa pelo nome do produto."},; 
                      {" 3 Codigo do produto  ",; 
                       "Pesquisa pelo codigo de cadastro do produto."}}) 
           case TECLA==K_F3 
                       @ 03,12 say "Ordem: Codigo de acesso interno.    " 
                       organiza(oPROD,1) 
           case TECLA==K_F4 
                       @ 03,12 say "Ordem: Codigo de fabrica do produto." 
                       organiza(oPROD,4) 
           case TECLA==K_F5 
                       @ 03,12 say "Ordem: Descricao do produto.        " 
                       organiza(oPROD,2) 
           case TECLA==K_ENTER 
                cDESPRO:=CODFAB+" - "+DESCRI 
                cCODFAB2:=CODFAB 
                exit 
           otherwise                ;tone(125); tone(300) 
        endcase 
        oPROD:refreshcurrent() 
        oPROD:stabilize() 
     enddo 
     dbselectar(nAREA) 
     setcolor(cCOR) 
     setcursor(nCURSOR) 
     screenrest(cTELA) 
  endif 
return(.T.) 
 
/* 
* Modulo      - PESQUISA 
* Parametros  - Elemento objeto 
* Finalidade  - Pesquisa pelo codigo ou descricao 
* Programador - Valmor Pereira Flores 
* Data        - 15/Junho/1993 
* Atualizacao - 03/Fevereiro/1994 
*/ 
stat func pesquisaproduto(oPOBJ,cOPCOES) 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nOPCAO:=0, nCOD:=0, cCDFAB:=spac(13), cDESC:=space(45),; 
     GETLIST:={}, nORDEM:=indexord() 
ajuda("[ESC]Finaliza") 
mensagem("Selecione sua opcao conforme o menu acima.") 
if lastrec()=0 
   mensagem("Cadastro vazio, [ENTER] para continuar.") 
   pausa() 
   return NIL 
endif 
setcursor(1) 
set(_SET_SOFTSEEK,.t.) 
mensagem("") 
ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
vpbox(12,45,17,69," Pesquisa ",M->Cor[20],.T.,.F.,M->Cor[19]) 
setcolor(M->Cor[21]+","+M->Cor[22]) 
aadd(MENULIST,menunew(13,46,cOPCOES[1][1],2,M->Cor[19],cOPCOES[1][2],,,M->Cor[6],.T.)) 
aadd(MENULIST,menunew(14,46,cOPCOES[2][1],2,M->Cor[19],cOPCOES[2][2],,,M->Cor[6],.T.)) 
aadd(MENULIST,menunew(15,46,cOPCOES[3][1],2,M->Cor[19],cOPCOES[3][2],,,M->Cor[6],.T.)) 
aadd(MENULIST,menunew(16,46," 0 Encerramento       ",2,M->Cor[19],; 
   "Executa a finalizacao da rotina de pesquisa.",,,M->Cor[6],.T.)) 
menumodal(MENULIST,@nOPCAO); MENULIST:={} 
ajuda("["+_SETAS+"]Movimenta [ENTER]Confirma [ESC]Cancela") 
oPOBJ:gotop() 
do case 
   case nOPCAO=3 
        vpbox(11,25,13,48,"",M->Cor[20],.T.,.F.,M->Cor[19]) 
        @ 12,26 say "C�digo " get nCOD pict "9999" when; 
          mensagem("Digite o c�digo para pesquisa.") 
        read 
        mensagem("Executando a pesquisa pelo codigo, aguarde...") 
        dbsetorder(3) 
        dbseek(strzero(nCOD,_QTCODIG,0)) 
   case nOPCAO=2 
        vpbox(11,16,13,63,"",M->Cor[20],.T.,.F.,M->Cor[19]) 
        @ 12,17 say "Nome " get cDESC pict "@S35" when; 
          mensagem("Digite o nome para pesquisa.") 
        read 
        mensagem("Executando a pesquisa pela descricao, aguarde...") 
        dbsetorder(2) 
        dbseek(upper(cDESC)) 
   case nOPCAO=1 
        vpbox(11,16,13,63,"",M->Cor[20],.T.,.F.,M->Cor[19]) 
        @ 12,17 say "Cod. Fabrica " get cCDFAB when; 
          mensagem("Digite o codigo de fabrica p/ pesquisa.") 
        read 
        mensagem("Executando a pesquisa p/ codigo de fabrica, aguarde...") 
        dbsetorder(4) 
        dbseek(upper(cCDFAB)) 
   otherwise 
endcase 
set(_SET_SOFTSEEK,.f.) 
dbsetorder(nORDEM) 
setcursor(0) 
setcolor(cCOR) 
screenrest(cTELA) 
oPOBJ:refreshall() 
whil ! oPOBJ:stabilize() 
enddo 
return nil 
 
 
 
