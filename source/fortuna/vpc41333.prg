// ## CL2HB.EXE - Converted
/* 
���������������������������������������������������������������������������Ŀ 
� RG: XXXXXXXXXXXXXXXXXXXX                                                  � 
� Estado Civil: [X]  (1)Casado (2)Solteiro (3)Divorciado (4)                � 
� N�Dependentes: XX                                                         � 
� Filiacao                             Endereco dos mesmos:                 � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� Empresa Onde Trabalha                                                     � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                      � 
� Endereco                             Cargo              Secao             � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXX � 
� Salario             XXXXXXXXXXXXXXXX Origem                               � 
� Outros Rendimentos  XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� Total Ganhos        XXXXXXXXXXXXXXXX                                      � 
� Emprego Anterior    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                   � 
����������������������������������������������������������������������������� 
���������������������������������������������������������������������������Ŀ 
� Conjuge                          (35) Nascim.  RG                         � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX/XX/XX XXXXXXXXXXXXXXXXXXXXXXXXXX � 
� Filiacao                                                                  � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                      � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                      � 
� Empresa Onde Trabalha                XXXXXXXXXXXXXXXXXXXXXXXXXX XX        � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                      � 
� Endereco                             Cargo              Secao             � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXX � 
� Salario             XXXXXXXXXXXXXXXX Origem                               � 
� Outros Rendimentos  XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� Total Ganhos        XXXXXXXXXXXXXXXX                                      � 
� Emprego Anterior    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                   � 
����������������������������������������������������������������������������� 
���������������������������������������������������������������������������Ŀ 
� Residencia (Ha Quanto Tempo Reside no Local): XXX                         � 
� Casa.: [x] (1)Propria  (2)Alugada  (3)Pensao  (4) Casa de Parentes        � 
� Valor: XXXXXXXXXXXX                                                       � 
� Complementos: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                        � 
� Residencia Anterior: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� Avalista - Nome: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   Conta: XXXXXXXX � 
� Referencias                                                               � 
� Comerciais:                                                               � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� Pessoais:                                                                 � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
����������������������������������������������������������������������������� 
���������������������������������������������������������������������������Ŀ 
� SPC                                                                       � 
� Estagio: [3]                                                              � 
� Observacoes                                                               � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
� XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX � 
�                                                                           � 
���������������������������������������������������������������������������Ĵ 
�                                                                           � 
� Data de Informacoes: [DD/MM/AA]                                           � 
�                                                                           � 
����������������������������������������������������������������������������� 
*/ 
 
#include "vpf.ch" 
#include "inkey.ch" 
 
#ifdef HARBOUR
function vpc41333()
#endif



loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),;
     nCURSOR:=setcursor(), oTB, nTecla, lFlag:=.F.,; 
     aPos:={ 17, 0, 22, 79 }, nArea:= Select(), nOrdem:= IndexOrd(),; 
     GetList:= {}, nOrd:= IndexOrd() 
Loca cObser1, cObser2, cObser3, cObser4, cObser5, nValorCred, dValid_ 
Local nTela:= 1 
Loca dDatInf 
DBSelectAr( _COD_CLIENTE) 
If !Used() 
   lFlag:=.T. 
   If !file(_VPB_CLIENTE) 
      aviso(" Arquivo de Clientes inexistente! ",24/2) 
      ajuda("[ENTER]Retorna") 
      Mensagem( "Pressione [ENTER] para retornar...",1) 
      pausa() 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
   If !fdbusevpb(_COD_CLIENTE) 
      aviso("ATENCAO! VerIfique o arquivo "+_VPB_CLIENTE+".",24/2) 
      Mensagem( "Erro na abertura do arquivo de Clientes, tente novamente...") 
      pausa() 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
EndIf 
 
   nRegistro:= CLI->( RECNO() ) 
   nPreReg:= PRE->( RECNO() ) 
   PRE->( DBSetOrder( 1 ) ) 
   nOrd:= IndexOrd() 
   setcolor(COR[16]) 
   VPBox( 0, 0, aPos[1]-1, 79, "FICHA DE CREDIARIO", _COR_GET_BOX, .F., .F. ) 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "Clientes", _COR_BROW_BOX, .F., .F. ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   CredLayOut( 1 ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   DBLeOrdem() 
   DBGoTo( nRegistro ) 
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew(,{|| STRZERO( Codigo, 6, 0) + " " +  Descri + IF( !EMPTY( CGCMF_ ), Tran( CGCMF_, "@R 99.999.999/9999-99" ), Tran( CPF___, "@R XXX.XXX.XXX-XX" ) + Space( 8 ) ) + Space( 18 ) })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   cAviso:= "Data limite de credito expirada! Renove!" 
   lRedisplay:= .T. 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
 
      CredDados( nTela ) 
 
      SetColor( _COR_BROWSE ) 
      nTecla:= inkey(0) 
      If nTecla=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTB:up() 
         case nTecla==K_DOWN       ;oTB:down() 
         case nTecla==K_PGUP       ;oTB:pageup() 
         case nTecla==K_PGDN       ;oTB:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
         case nTecla==K_LEFT 
              IF( nTela > 1, --nTela, Nil ) 
              CredLayOut( nTela ) 
 
         case nTecla==K_RIGHT 
              IF( nTela < 4, ++nTela, Nil ) 
              CredLayOut( nTela ) 
 
         case nTecla==K_ENTER 
              CredEdit( nTela ) 
 
         case DBPesquisa( nTecla, oTb ) 
         case nTecla==K_F2 
              DBMudaOrdem( 1, oTb ) 
         case nTecla==K_F3 
              DBMudaOrdem( 2, oTb ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
   PRE->( DBGoto( nPreReg ) ) 
DBSelectar( _COD_CLIENTE ) 
DBSetOrder( 1 ) 
If lFlag 
   CLI->( DBUnlock() ) 
   CLI->( DBCloseArea() ) 
EndIf 
Set( _SET_DELIMITERS, .T. ) 
IF !nArea==0 .AND. !nOrdem==0 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
ENDIF 
CLI->( DBGoTo( nRegistro ) ) 
Setcolor(cCOR) 
Setcursor(nCURSOR) 
Screenrest(cTELA) 
Return(.T.) 
 
 
Function CredLayout( nTela ) 
Local cCor:= SetColor(), nCursor:= SetCursor() 
   DispBegin() 
   SetColor( _COR_GET_EDICAO ) 
   @ 00,02 Say PADC( "FICHA DE CREDIARIO (" + Alltrim( Str( nTela ) ) + ")", 76 ) Color "00/15" 
   DO CASE 
      CASE nTela==1 
         Scroll( 01, 02, 15, 78 ) 
         @ 02,02 Say "RG...........: [��������������������]  Nascimento: [��/��/��]    " 
         @ 03,02 Say "Estado Civil.: [�]  (1)Casado (2)Solteiro (3)Divorciado (4)Viuvo " 
         @ 04,02 Say "N�Dependentes: [��]                                              " 
         @ 05,02 Say "Filiacao.....: [������������������������������]" 
         @ 06,02 Say "               [������������������������������]" 
         @ 07,02 Say "Endereco.....: [�������������������������������������������������������]" 
         @ 08,02 Say "Empresa......: [�������������������������������������������������������]" 
         @ 09,02 Say "End.Empresa..: [�������������������������������������������������������]" 
         @ 10,02 Say "Fone.........: [1234-1234.1234]" 
         @ 11,02 Say "Admissao.....: [��������]" 
         @ 12,02 Say "Cargo........: [������������������������] S: [�������������������������]" 
         @ 13,02 Say "Salario......: [��������������]" 
         @ 14,02 Say "Out.Rendimen.: [��������������]      Origem: [�������������������������]" 
         @ 15,02 Say "Emprego Ant..: [�������������������������������������������������������]" 
      CASE nTela==2 
         Scroll( 01, 02, 15, 78 ) 
         @ 02,02 Say "Conjuge......: [�����������������������������������]" 
         @ 03,02 Say "Nascimento...: [��������]" 
         @ 04,02 Say "RG...........: [��������������������]" 
         @ 05,02 Say "Filiacao.....: [�����������������������������������]" 
         @ 06,02 Say "               [�����������������������������������]" 
         @ 07,02 Say "Empresa......: [�������������������������������������������������������]" 
         @ 08,02 Say "End.Empresa..: [�������������������������������������������������������]" 
         @ 09,02 Say "Fone.........: [����-����.����]" 
         @ 10,02 Say "Admissao.....: [��������]" 
         @ 11,02 Say "Cargo........: [������������������������] S: [�������������������������]" 
         @ 12,02 Say "Salario......: [��������������]" 
         @ 13,02 Say "Out.Rendimen.: [��������������]      Origem: [�������������������������]" 
         @ 14,02 Say "Emprego Ant..: [�������������������������������������������������������]" 
      CASE nTela==3 
         Scroll( 01, 02, 15, 78 ) 
         @ 02,02 Say "Residencia...: [�] (1)Propria  (2)Alugada  (3)Pensao  (4)Casa Parentes" 
         @ 03,02 Say "Valor/Contrib: [��������������]" 
         @ 04,02 Say "Tempo (Meses): [����]     Nome...: [�����������������������������������]" 
         @ 05,02 Say "Res.Anterior.: [�������������������������������������������������������]" 
 
         @ 07,02 Say "Avalista.....: [�������������������������������������������������������]" 
 
         @ 09,02 Say "Referencias..: [COMERCIAIS]" 
         @ 10,02 Say "               [�������������������������������������������������������]" 
         @ 11,02 Say "               [�������������������������������������������������������]" 
         @ 12,02 Say "               [�������������������������������������������������������]" 
         @ 13,02 Say "               [�������������������������������������������������������]" 
         @ 14,02 Say "               [PESSOAIS]" 
         @ 15,02 Say "               [�������������������������������������������������������]" 
      CASE nTela==4 
         Scroll( 01, 02, 15, 78 ) 
         @ 02,02 Say "SPC������������[�] (0)S/Cartas (1)1�Aviso (2)2�Aviso (3)3�Aviso (4)Protesto" 
         @ 03,02 Say "Observacoes..: [�������������������������������������������������������]" 
         @ 04,02 Say "               [�������������������������������������������������������]" 
         @ 05,02 Say "               [�������������������������������������������������������]" 
         @ 07,02 Say "Data.........: [��������]" 
      CASE nTela==5 
         @ 02,02 Say "Periodicidade das Visitas: " 
         @ 03,02 Say "Proxima Visita...........: " 
    ENDCASE 
    SetColor( cCor ) 
    DispEnd() 
    Return Nil 
 
Function CredDados( nTela ) 
Local cCor:= SetColor() 
Local nNDEPEN, cMae___, cPai___, cCI____, cORGAO_, cENDMAE, cENDPAI,; 
      cEMPTRA, cENDTRA, dADMISS, cFONTRA, nSALAR_, cCARGO_, cSECAO_, nOUTROS,; 
      cOROUTR, cEMPANT, dCONDTA, cCONJUG, dCONNAS, cCONCI_, cCONMAE, cCONPAI,; 
      cEMPCON, cFEMCON, nCONOUT, cEEMCON, nCONSAL, cCONCAR, cCONSEC,; 
      cCONORI, cCEMANT, cRESID_, nRESTEM, nRESVLR, cRESNOM, cRESANT, cAVALIS,; 
      cRCOME1, cRCOME2, cRCOME3, cRCOME4, cRPESS1, cRPESS2, nSPCEST, cSPCOB1,; 
      cSPCOB2, cSPCOB3, cEstCiv, dNascim, dDATA__ 
 
   DispBegin() 
   CCR->( DBSetOrder( 1 ) ) 
   CCR->( DBSeek( CLI->CODIGO ) ) 
   nNDEPEN:= CCR-> NDEPEN 
   cMae___:= CLI->MAE___ 
   cPai___:= CLI->PAI___ 
   cCI____:= CCR->CI____ 
   cORGAO_:= CCR->ORGAO_ 
   cENDMAE:= CCR->ENDMAE 
   cENDPAI:= CCR->ENDPAI 
   cEMPTRA:= CCR->EMPTRA 
   cENDTRA:= CCR->ENDTRA 
   dADMISS:= CCR->ADMISS 
   cFONTRA:= CCR->FONTRA 
   nSALAR_:= CCR->SALAR_ 
   cCARGO_:= CCR->CARGO_ 
   cSECAO_:= CCR->SECAO_ 
   nOUTROS:= CCR->OUTROS 
   cOROUTR:= CCR->OROUTR 
   cEMPANT:= CCR->EMPANT 
   dCONDTA:= CCR->CONDTA 
   cCONJUG:= CCR->CONJUG 
   dCONNAS:= CCR->CONNAS 
   cCONCI_:= CCR->CONCI_ 
   cCONMAE:= CCR->CONMAE 
   cCONPAI:= CCR->CONPAI 
   cEMPCON:= CCR->EMPCON 
   cFEMCON:= CCR->FEMCON 
   nCONOUT:= CCR->CONOUT 
   cEEMCON:= CCR->EEMCON 
   nCONSAL:= CCR->CONSAL 
   cCONCAR:= CCR->CONCAR 
   cCONSEC:= CCR->CONSEC 
   cCONORI:= CCR->CONORI 
   cCEMANT:= CCR->CEMANT 
   cRESID_:= CCR->RESID_ 
   nRESTEM:= CCR->RESTEM 
   nRESVLR:= CCR->RESVLR 
   cRESNOM:= CCR->RESNOM 
   cRESANT:= CCR->RESANT 
   cAVALIS:= CCR->AVALIS 
   cRCOME1:= CCR->RCOME1 
   cRCOME2:= CCR->RCOME2 
   cRCOME3:= CCR->RCOME3 
   cRCOME4:= CCR->RCOME4 
   cRPESS1:= CCR->RPESS1 
   cRPESS2:= CCR->RPESS2 
   nSPCEST:= CCR->SPCEST 
   cSPCOB1:= CCR->SPCOB1 
   cSPCOB2:= CCR->SPCOB2 
   cSPCOB3:= CCR->SPCOB3 
   cEstCiv:= CCR->ESTCIV 
   dNascim:= CLI->NASCIM 
   dDATA__:= CCR->DATA__ 
 
   SetColor( _COR_GET_CURSOR ) 
   DO CASE 
      CASE nTela==1 
           @ 02,18 Say CCR->CI____ 
           @ 02,54 Say CLI->NASCIM 
           @ 03,18 Say CCR->ESTCIV 
           @ 04,18 Say CCR->NDEPEN Pict "99" 
           @ 05,18 Say CLI->MAE___ 
           @ 06,18 Say CLI->PAI___ 
           @ 07,18 Say CCR->ENDMAE 
           @ 08,18 Say CCR->EMPTRA 
           @ 09,18 Say CCR->ENDTRA 
           @ 10,18 Say Tran( CCR->FONTRA, "@R XXXX-XXXXXXXXX" ) 
           @ 11,18 Say CCR->ADMISS 
           @ 12,18 Say CCR->CARGO_ 
           @ 12,48 Say CCR->SECAO_ 
           @ 13,18 Say Tran( CCR->SALAR_, "@E 999,999,999.99" ) 
           @ 14,18 Say Tran( CCR->OUTROS, "@E 999,999,999.99" ) 
           @ 14,48 Say CCR->OROUTR 
           @ 15,18 Say CCR->EMPANT 
 
      CASE nTela==2 
           cDDDCon:= SubStr( cFEmCon, 1, 4 ) 
           nFone := Val( SubStr( cFEmCon, 5 ) ) 
           @ 02,18 Say cConjug 
           @ 03,18 Say dConNas 
           @ 04,18 Say cConCi_ 
           @ 05,18 Say cConMae 
           @ 06,18 Say cConPai 
           @ 07,18 Say cEmpCon 
           @ 08,18 Say cEEmCon 
           @ 09,18 Say cDDDCon Pict "@R 9999" 
           @ 09,23 Say nFone   Pict "@R 9999.9999" 
           @ 10,18 Say dCONDTA 
           @ 11,18 Say cCONCAR 
           @ 11,48 Say cCONSEC 
           @ 12,18 Say nConSal Pict "@E 999,999,999.99" 
           @ 13,18 Say nConOut Pict "@E 999,999,999.99" 
           @ 13,48 Say cConOri 
           @ 14,18 Say cEMPANT 
           cFEmCon:= cDDDCon + Str( nFone, 9, 4 ) 
 
      CASE nTela==3 
           @ 02,18 Say cRESID_ Pict "9" 
           @ 03,18 Say nRESVLR Pict "@E 999,999,999.99" 
           @ 04,18 Say nRESTEM Pict "9999" 
           @ 04,38 Say cRESNOM 
           @ 05,18 Say cRESANT 
           @ 07,18 Say cAVALIS 
           @ 10,18 Say cRCOME1 
           @ 11,18 Say cRCOME2 
           @ 12,18 Say cRCOME3 
           @ 13,18 Say cRCOME4 
           @ 15,18 Say cRPESS1 
 
      CASE nTela==4 
           @ 02,18 Say nSPCEst Pict "9" 
           @ 03,18 Say cSPCOB1 
           @ 04,18 Say cSPCOB2 
           @ 05,18 Say cSPCOB3 
           @ 07,18 Say dData__ 
 
      CASE nTela==5 
           @ 02,29 Say str(PERDCD,3) 
           @ 03,29 Say dtoc(PRXVST) 
   ENDCASE 
   SetColor( cCor ) 
   DispEnd() 
return Nil 
 
Function CredEdit( nTela ) 
Local cCor:= SetColor(), nCursor:= SetCursor() 
Local nNDEPEN, cMae___, cPai___, cCI____, cORGAO_, cENDMAE, cENDPAI,; 
      cEMPTRA, cENDTRA, dADMISS, cFONTRA, nSALAR_, cCARGO_, cSECAO_, nOUTROS,; 
      cOROUTR, cEMPANT, dCONDTA, cCONJUG, dCONNAS, cCONCI_, cCONMAE, cCONPAI,; 
      cEMPCON, cFEMCON, nCONOUT, cEEMCON, nCONSAL, cCONCAR, cCONSEC,; 
      cCONORI, cCEMANT, cRESID_, nRESTEM, nRESVLR, cRESNOM, cRESANT, cAVALIS,; 
      cRCOME1, cRCOME2, cRCOME3, cRCOME4, cRPESS1, cRPESS2, nSPCEST, cSPCOB1,; 
      cSPCOB2, cSPCOB3, cEstCiv, dNascim, dDATA__, nPERDCD, dPRXVST 
 
   SetCursor( 1 ) 
   CCR->( DBSetOrder( 1 ) ) 
   CCR->( DBSeek( CLI->CODIGO ) ) 
   nNDEPEN:= CCR-> NDEPEN 
   cMae___:= CLI->MAE___ 
   cPai___:= CLI->PAI___ 
   cCI____:= CCR->CI____ 
   cORGAO_:= CCR->ORGAO_ 
   cENDMAE:= CCR->ENDMAE 
   cENDPAI:= CCR->ENDPAI 
   cEMPTRA:= CCR->EMPTRA 
   cENDTRA:= CCR->ENDTRA 
   dADMISS:= CCR->ADMISS 
   cFONTRA:= CCR->FONTRA 
   nSALAR_:= CCR->SALAR_ 
   cCARGO_:= CCR->CARGO_ 
   cSECAO_:= CCR->SECAO_ 
   nOUTROS:= CCR->OUTROS 
   cOROUTR:= CCR->OROUTR 
   cEMPANT:= CCR->EMPANT 
   dCONDTA:= CCR->CONDTA 
   cCONJUG:= CCR->CONJUG 
   dCONNAS:= CCR->CONNAS 
   cCONCI_:= CCR->CONCI_ 
   cCONMAE:= CCR->CONMAE 
   cCONPAI:= CCR->CONPAI 
   cEMPCON:= CCR->EMPCON 
   cFEMCON:= CCR->FEMCON 
   nCONOUT:= CCR->CONOUT 
   cEEMCON:= CCR->EEMCON 
   nCONSAL:= CCR->CONSAL 
   cCONCAR:= CCR->CONCAR 
   cCONSEC:= CCR->CONSEC 
   cCONORI:= CCR->CONORI 
   cCEMANT:= CCR->CEMANT 
   cRESID_:= CCR->RESID_ 
   nRESTEM:= CCR->RESTEM 
   nRESVLR:= CCR->RESVLR 
   cRESNOM:= CCR->RESNOM 
   cRESANT:= CCR->RESANT 
   cAVALIS:= CCR->AVALIS 
   cRCOME1:= CCR->RCOME1 
   cRCOME2:= CCR->RCOME2 
   cRCOME3:= CCR->RCOME3 
   cRCOME4:= CCR->RCOME4 
   cRPESS1:= CCR->RPESS1 
   cRPESS2:= CCR->RPESS2 
   nSPCEST:= CCR->SPCEST 
   cSPCOB1:= CCR->SPCOB1 
   cSPCOB2:= CCR->SPCOB2 
   cSPCOB3:= CCR->SPCOB3 
   cEstCiv:= CCR->ESTCIV 
   dNascim:= CLI->NASCIM 
   dDATA__:= CCR->DATA__ 
   nPERDCD:= CLI->PERDCD 
   dPRXVST:= CLI->PRXVST 
   Set( _SET_DELIMITERS, .F. ) 
   SetColor( _COR_GET_CURSOR ) 
   DO CASE 
      CASE nTela==1 
           lDelimiters:= Set( _SET_DELIMITERS, .F. ) 
           SetColor( _COR_GET_EDICAO ) 
           SetCursor( 1 ) 
           cDDDTra:= SubStr( cFonTra, 1, 4 ) 
           nFone := Val( SubStr( cFonTra, 5 ) ) 
           @ 02,18 Get cCI____ 
           @ 02,54 Get dNascim 
           @ 03,18 Get cESTCIV 
           @ 04,18 Get nNDEPEN Pict "99" 
           @ 05,18 Get cMae___ 
           @ 06,18 Get cPai___ 
           @ 07,18 Get cENDMAE 
           @ 08,18 Get cEMPTRA 
           @ 09,18 Get cENDTRA 
           @ 10,18 Get cDDDTra Pict "@R 9999" 
           @ 10,23 Get nFone   Pict "@R 9999.9999" 
           @ 11,18 Get dADMISS 
           @ 12,18 Get cCARGO_ 
           @ 12,48 Get cSECAO_ 
           @ 13,18 Get nSALAR_ Pict "@E 999,999,999.99" 
           @ 14,18 Get nOUTROS Pict "@E 999,999,999.99" 
           @ 14,48 Get cOROUTR 
           @ 15,18 Get cEMPANT 
           READ 
           cFonTra:= cDDDTra + Str( nFone, 9, 4 ) 
 
      CASE nTela==2 
           cDDDCon:= SubStr( cFEmCon, 1, 4 ) 
           nFone := Val( SubStr( cFEmCon, 5 ) ) 
           @ 02,18 Get cConjug 
           @ 03,18 Get dConNas 
           @ 04,18 Get cConCi_ 
           @ 05,18 Get cConMae 
           @ 06,18 Get cConPai 
           @ 07,18 Get cEmpCon 
           @ 08,18 Get cEEmCon 
           @ 09,18 Get cDDDCon Pict "@R 9999" 
           @ 09,23 Get nFone   Pict "@R 9999.9999" 
           @ 10,18 Get dCONDTA 
           @ 11,18 Get cCONCAR 
           @ 11,48 Get cCONSEC 
           @ 12,18 Get nConSal Pict "@E 999,999,999.99" 
           @ 13,18 Get nConOut Pict "@E 999,999,999.99" 
           @ 13,48 Get cConOri 
           @ 14,18 Get cEMPANT 
           read 
           cFEmCon:= cDDDCon + Str( nFone, 9, 4 ) 
      CASE nTela==3 
           @ 02,18 Get cRESID_ Pict "9" 
           @ 03,18 Get nRESVLR Pict "@E 999,999,999.99" 
           @ 04,18 Get nRESTEM Pict "9999" 
           @ 04,38 Get cRESNOM 
           @ 05,18 Get cRESANT 
           @ 07,18 Get cAVALIS 
           @ 10,18 Get cRCOME1 
           @ 11,18 Get cRCOME2 
           @ 12,18 Get cRCOME3 
           @ 13,18 Get cRCOME4 
           @ 15,18 Get cRPESS1 
           READ 
 
      CASE nTela==4 
           @ 02,18 Get nSPCEst Pict "9" 
           @ 03,18 Get cSPCOB1 
           @ 04,18 Get cSPCOB2 
           @ 05,18 Get cSPCOB3 
           @ 07,18 Get dData__ 
           READ 
      CASE nTela==5 
           @ 02,29 get nPERDCD pict "999" 
           @ 03,29 get dPRXVST 
           READ 
   ENDCASE 
 
   IF nTela==5 
      IF CLI->( netrlock() ) 
         Replace CLI->PERDCD with nPERDCD,; 
                 CLI->PRXVST with dPRXVST 
      ENDIF 
   ELSE 
      IF CCR->( EOF() ) 
         CCR->( DBAppend() ) 
      ENDIF 
      IF CCR->( netrlock() ) 
         Replace CCR->CODIGO With CLI->CODIGO,; 
                 CCR->DESCRI With CLI->DESCRI 
         Replace CCR->CI____ With cCI____,; 
                 CCR->ESTCIV With cESTCIV,; 
                 CCR->NDEPEN With nNDEPEN,; 
                 CCR->ENDMAE With cENDMAE,; 
                 CCR->EMPTRA With cEMPTRA,; 
                 CCR->ENDTRA With cENDTRA,; 
                 CCR->FONTRA With cFONTRA,; 
                 CCR->ADMISS With dADMISS,; 
                 CCR->CARGO_ With cCARGO_,; 
                 CCR->SECAO_ With cSECAO_,; 
                 CCR->SALAR_ With nSALAR_,; 
                 CCR->OUTROS With nOUTROS,; 
                 CCR->OROUTR With cOROUTR,; 
                 CCR->EMPANT With cEMPANT,; 
                 CCR->CONJUG With cCONJUG,; 
                 CCR->CONNAS With dCONNAS,; 
                 CCR->CONCI_ With cCONCI_,; 
                 CCR->CONMAE With cCONMAE 
        Replace  CCR->CONPAI With cCONPAI,; 
                 CCR->EMPCON With cEMPCON,; 
                 CCR->FEMCON With cFEMCON,; 
                 CCR->CONOUT With nCONOUT,; 
                 CCR->CONDTA With dCONDTA,; 
                 CCR->EEMCON With cEEMCON,; 
                 CCR->CONSAL With nCONSAL,; 
                 CCR->CONCAR With cCONCAR,; 
                 CCR->CONSEC With cCONSEC,; 
                 CCR->CONORI With cCONORI,; 
                 CCR->CEMANT With cCEMANT,; 
                 CCR->RESID_ With cRESID_,; 
                 CCR->RESTEM With nRESTEM,; 
                 CCR->RESVLR With nRESVLR,; 
                 CCR->RESNOM With cRESNOM,; 
                 CCR->RESANT With cRESANT,; 
                 CCR->AVALIS With cAVALIS,; 
                 CCR->RCOME1 With cRCOME1,; 
                 CCR->RCOME2 With cRCOME2 
        Replace  CCR->RCOME3 With cRCOME3,; 
                 CCR->RCOME4 With cRCOME4,; 
                 CCR->RPESS1 With cRPESS1,; 
                 CCR->RPESS2 With cRPESS2,; 
                 CCR->SPCEST With nSPCEST,; 
                 CCR->SPCOB1 With cSPCOB1,; 
                 CCR->SPCOB2 With cSPCOB2,; 
                 CCR->SPCOB3 With cSPCOB3,; 
                 CCR->ESTCIV With cEstCiv,; 
                 CCR->DATA__ With dDATA__ 
 
 
         IF CLI->( netrlock() ) 
            Replace CLI->MAE___ With cMae___,; 
                    CLI->PAI___ With cPai___,; 
                    CLI->NASCIM With dNascim 
         ENDIF 
 
      ENDIF 
   ENDIF 
   Set( _SET_DELIMITERS, .T. ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
