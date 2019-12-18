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
 
 
/*ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ CONFIGURACAO ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ*/ 
 
/*Í Codigo do Produto Í*/ 
LOCATE FOR Variav="cMASCACOD" 
cMascaCod:=Mascar 
cVerif_:=Verif_ 
 
/*Í Quantidade ÍÍÍÍÍÍÍÍ*/ 
locate for VARIAV="cMASCQUAN" 
cMASCQUAN:=MASCAR 
 
/*Í Valores ÍÍÍÍÍÍÍÍÍÍÍ*/ 
locate for VARIAV="cMASCPREC" 
cMASCPREC:=MASCAR 
 
/*Í Origem? ÍÍÍÍÍÍÍÍÍÍÍ*/ 
locate for VARIAV="cORIGEM" 
M->cxORIGEM:=QUEST_ 
 
locate for VARIAV="cASSOCIAR" 
cASSOCIAR:=QUEST_ 
 
 
/*ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ ABERTURA DE ARQUIVOS ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ*/ 
 
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
  ³ ORIGENS                              ³ 
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
 
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
 
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
  ³ FORNECEDORES                         ³ 
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
 
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
 
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
  ³ PRECOS POR FORNECEDOR                ³ 
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
 
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
 
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
  ³ CLASSIFICACAO FISCAL                 ³ 
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
 
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
 
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
  ³ MATERIA-PRIMA                        ³ 
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
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
 
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
  ³ ARQUIVO DE ASSEMBLY                  ³ 
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/ 
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
 
/*ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ FORMULARIO DE ENTRADA ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ*/ 
 
  VPBOX( 1, 0, 24 - 2, 79,, _COR_GET_BOX, .F., .F., _COR_GET_TITULO ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela") 
 
/*ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ VARIAVEIS DE MASCARA ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ*/ 
 
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
