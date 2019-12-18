// ## CL2HB.EXE - Converted
#include "vpf.ch"

#ifdef HARBOUR
function vpc8800()
#endif

if .t.
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
 
 
/*様様様様様様様様様様様様様様 CONFIGURACAO 様様様様様様様様様様様�*/ 
 
/*� Codigo do Produto �*/ 
LOCATE FOR Variav="cMASCACOD" 
cMascaCod:=Mascar 
cVerif_:=Verif_ 
 
/*� Quantidade 様様様様*/ 
locate for VARIAV="cMASCQUAN" 
cMASCQUAN:=MASCAR 
 
/*� Valores 様様様様様�*/ 
locate for VARIAV="cMASCPREC" 
cMASCPREC:=MASCAR 
 
/*� Origem? 様様様様様�*/ 
locate for VARIAV="cORIGEM" 
M->cxORIGEM:=QUEST_ 
 
locate for VARIAV="cASSOCIAR" 
cASSOCIAR:=QUEST_ 
 
 
/*様様様様様様様様様様様� ABERTURA DE ARQUIVOS 様様様様様様様様様様*/ 
 
/*敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕 
  � ORIGENS                              � 
  青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰*/ 
 
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
 
/*敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕 
  � FORNECEDORES                         � 
  青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰*/ 
 
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
 
/*敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕 
  � PRECOS POR FORNECEDOR                � 
  青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰*/ 
 
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
 
/*敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕 
  � CLASSIFICACAO FISCAL                 � 
  青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰*/ 
 
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
 
/*敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕 
  � MATERIA-PRIMA                        � 
  青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰*/ 
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
 
/*敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕 
  � ARQUIVO DE ASSEMBLY                  � 
  青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰*/ 
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
 
/*様様様様様様様様様様様� FORMULARIO DE ENTRADA 様様様様様様様様様�*/ 
 
  VPBOX( 1, 0, 24 - 2, 79,, _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
 
/*様様様様様様様様様様様� VARIAVEIS DE MASCARA 様様様様様様様様様様*/ 
 
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
