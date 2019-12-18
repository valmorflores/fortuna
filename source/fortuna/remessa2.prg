// ## CL2HB.EXE - Converted
#include "Common.Ch" 
#include "Inkey.Ch" 
#Include "VPF.Ch" 
 
/* 
* Funcao      - REMESSA 
* Finalidade  - Enviar DOCs ao banrisul 
* Programador - Valmor Pereira Flores 
* Data        - 6/Novembro/1995 
* Atualizacao - 
*/ 
Function Remessa() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), nCursor:= SetCursor(),; 
      cCor:= SetColor() 
Local cCodCed:="065018154085", cTipCar:="3", cTipoDoc:="06",; 
      cSacador:= Space( 25 ), nTaxa:= 12.00, cStatus:= "C",; 
      nJuros:= 0, nTotalGeral:= 0, dData1:= CtoD("  /  /  "),; 
      dData2:= Date(), nBanco:= 0, cNomCed:= Left( M->_EMP, 35 ) 
 
  cSacador:="Pagavel prefer. no Banrisul        " 
 
  IF !Abregrupo( "NOTA_FISCAL" ) 
     Return nil 
  ENDIF 
 
  DBSelectAr( _COD_DUPLICATA ) 
 
 
  /* Abre arquivos */ 
  //If !FDBuseVpb( _COD_NFISCAL ); Return Nil ;EndIf 
  //If !FDBUseVpb( _COD_DUPLICATA ); Return Nil ;EndIf 
 
  VPBOX( 3, 2, 13, 76, "Gerador de Arquivo de Cobranca On-Line", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
  VPBox( 14, 2, 20, 76, "Area de Selecao", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 4, 3 Say "Banco.............:" Get nBanco Pict "999" 
  @ 5, 3 Say "Cod.Cedente.......:" Get cCodCed 
  @ 6, 3 Say "Sacador...........:" Get cSacador 
  @ 7, 3 Say "Favorecido........:" Get cNomCed 
  @ 8, 3 Say "Tipo Carteira.....:" Get cTipCar 
  @ 9, 3 Say "Tipo DOC..........:" Get cTipoDoc 
  @ 10, 3 Say "Taxa..............:" Get nTaxa Pict "999.99" 
  @ 11, 3 Say "Data Inicial......:" Get dData1 
  @ 12, 3 Say "Data Final........:" Get dData2 
  Read 
  If LastKey() == K_ESC 
     DBUnlockAll() 
     FechaArquivos() 
     ScreenRest( cTela ) 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     Return Nil 
  EndIf 
 
  /* 
  * Geracao de um arquivo £nico de dup. com um 
  * registro por cada duplicata. 
  */ 
  Mensagem("Transferindo dados entre arquivos, aguarde...",1) 
  If File( "ARECEBER.TMP" ) 
     FErase( "ARECEBER.TMP" ) 
     FErase( "ARECIND1.TMP" ) 
     FErase( "ARECIND2.TMP" ) 
  EndIf 
 
  /* Estrutura para cria‡„o do arquivo £nico. */ 
  aStruct:= { { "NomCed", "C", 35, 00 },; 
              { "CodCed", "C", 12, 00 },; 
              { "TipCar", "C", 01, 00 },; 
              { "CgcCpf", "C", 14, 00 },; 
              { "DataEm", "D", 03, 00 },; 
              { "Dupl__", "C", 10, 00 },; 
              { "Vlr___", "N", 16, 03 },; 
              { "Venc__", "C", 08, 00 },; 
              { "Limite", "D", 08, 00 },; 
              { "VlrDes", "N", 16, 02 },; 
              { "NomSac", "C", 35, 00 },; 
              { "EndSac", "C", 35, 00 },; 
              { "CepSac", "C", 08, 00 },; 
              { "CidSac", "C", 20, 00 },; 
              { "UF_Sac", "C", 02, 00 },; 
              { "Sacad_", "C", 35, 00 },; 
              { "IndTit", "C", 25, 00 },; 
              { "Taxa__", "N", 05, 02 },; 
              { "Juros_", "N", 16, 02 },; 
              { "Descon", "N", 16, 02 },; 
              { "Protes", "C", 02, 00 },; 
              { "Devol_", "C", 02, 00 },; 
              { "TipDoc", "C", 02, 00 },; 
              { "Status", "C", 01, 00 },; 
              { "CodNf_", "N", 10, 00 },; 
              { "Select", "C", 03, 00 } } 
 
  /* Criacao do arquivo tempor rio */ 
  DBCreate( "ARECEBER.TMP", aStruct ) 
 
  /* Area tempor ria de trabalho */ 
  DBSelectar( 50 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Use ARECEBER.TMP Alias TMP Shared 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  index on CODNF_ to ARECIND1.TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  index on VENC__ to ARECIND2.TMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  index on NomSac to ARECIND3.TMP 
 
  /* Area de Duplicatas */ 
  dbselectar( _COD_DUPLICATA ) 
  DbSetOrder( 2 ) 
  Set Relation To CodNf_ Into NF_ 
 
  /* Transferencia entre arquivos */ 
  DBGotop() 
  While !EOF() 
 
      Mensagem("Lendo o registro #"+strzero(recno(),4,0)+", aguarde....") 
 
      /* Teste da 1a. duplicata */ 
      If Dup->Vlr__A<>0 .AND. Dup->Venc_A>=dData1 .AND. Dup->Venc_A<=dData2 .AND.; 
         Dup->NFNula=" " .AND.; 
         ( NF_->NatOpe= 5.12 .OR. NF_->NatOpe=6.12 .OR.; 
           NF_->NatOpe= 5.11 .OR. NF_->NatOpe=6.11 .OR.; 
           NF_->NatOpe= 5.22 .OR. NF_->Numero=0 .OR. NF_->NatOpe=0.00 ) .AND. Dup->Quit_A $ "N " .AND.; 
           Dup->Banc_A = nBanco .AND. ( Dup->Situ_A == " " .OR. Situ_A == "0" ) 
 
         Mensagem( "Gravando o registro, aguarde..." ) 
         Scroll(15, 3, 19, 75, 1 ) 
         @ 19, 3 Say Tmp->NomSac 
 
         DBSelectAr( 50 ) 
         DBSetOrder( 2 ) 
 
         /* Abertura de um registro */ 
         DBAppend() 
         Replace NomCed With _EMP,; 
                 CodCed With cCodCed,; 
                 TipCar With cTipCar,; 
                 CgcCpf With NF_->CCGCMF,; 
                 DataEm With Dup->DataEm,; 
                 Dupl__ With StrZero( Dup->Dupl_A, 8, 0 ) + "/A",; 
                 Vlr___ With Dup->Vlr__A,; 
                 Venc__ With DTOC( Dup->Venc_A ),; 
                 Limite With Dup->Venc_A,; 
                 CodNf_ With Dup->CodNf_,; 
                 NomSac With Dup->CDescr,; 
                 EndSac With NF_->CEnder,; 
                 CepSac With NF_->CCdCep,; 
                 CidSac With NF_->CCidad,; 
                 Uf_Sac With NF_->CEstad,; 
                 Sacad_ With cSacador,; 
                 Taxa__ With nTaxa,; 
                 Juros_ With nJuros,; 
                 Protes With "",; 
                 Devol_ With "",; 
                 TipDoc With cTipoDoc,; 
                 Status With cStatus,; 
                 Select With "Sim" 
 
      EndIf 
 
 
      /* Teste da 2a. duplicata */ 
      If Dup->Vlr__B<>0 .AND. Dup->Venc_B>=dData1 .AND. Dup->Venc_B<=dData2 .AND.; 
         Dup->NFNula=" " .AND.; 
         ( NF_->NatOpe= 5.12 .OR. NF_->NatOpe=6.12 .OR.; 
           NF_->NatOpe= 5.11 .OR. NF_->NatOpe=6.11 .OR.; 
           NF_->NatOpe= 5.22 .OR. NF_->Numero=0 .OR. NF_->NatOpe=0.00 ) .AND. Dup->Quit_B $ "N " .AND.; 
           Dup->Banc_B = nBanco .AND. ( Dup->Situ_B == " " .or. Dup->Situ_B == "0" ) 
 
         Scroll(15, 3, 19, 75, 1 ) 
         @ 19, 3 Say Tmp->NomSac 
 
         DBSelectAr( 50 ) 
         DBSetOrder( 2 ) 
 
         /* Abertura de um registro */ 
         DBAppend() 
         Replace NomCed With _EMP,; 
                 CodCed With cCodCed,; 
                 TipCar With cTipCar,; 
                 CgcCpf With NF_->CCGCMF,; 
                 DataEm With Dup->DataEm,; 
                 Dupl__ With StrZero( Dup->Dupl_B, 8, 0 ) + "/A",; 
                 Vlr___ With Dup->Vlr__B,; 
                 Venc__ With DTOC( Dup->Venc_B ),; 
                 Limite With Dup->Venc_B,; 
                 CodNf_ With Dup->CodNf_,; 
                 NomSac With Dup->CDescr,; 
                 EndSac With NF_->CEnder,; 
                 CepSac With NF_->CCdCep,; 
                 CidSac With NF_->CCidad,; 
                 Uf_Sac With NF_->CEstad,; 
                 Sacad_ With cSacador,; 
                 Taxa__ With nTaxa,; 
                 Juros_ With nJuros,; 
                 Protes With "",; 
                 Devol_ With "",; 
                 TipDoc With cTipoDoc,; 
                 Status With cStatus,; 
                 Select With "Sim" 
 
      EndIf 
 
      /* Teste da 2a. duplicata */ 
      If Dup->Vlr__C<>0 .AND. Dup->Venc_C>=dData1 .AND. Dup->Venc_C<=dData2 .AND.; 
         Dup->NFNula=" " .AND.; 
         ( NF_->NatOpe= 5.12 .OR. NF_->NatOpe=6.12 .OR.; 
           NF_->NatOpe= 5.11 .OR. NF_->NatOpe=6.11 .OR.; 
           NF_->NatOpe= 5.22 .OR. NF_->Numero=0 .or. NF_->NATOPE=0.00 ) .AND. Dup->Quit_C $ "N " .AND.; 
           Dup->Banc_C = nBanco .AND. ( Dup->Situ_C == " " .OR. Situ_C == "0" ) 
 
         Scroll(15, 3, 19, 75, 1 ) 
         @ 19, 3 Say Tmp->NomSac 
 
         DBSelectAr( 50 ) 
         DBSetOrder( 2 ) 
 
         /* Abertura de um registro */ 
         DBAppend() 
         Replace NomCed With _EMP,; 
                 CodCed With cCodCed,; 
                 TipCar With cTipCar,; 
                 CgcCpf With NF_->CCGCMF,; 
                 DataEm With Dup->DataEm,; 
                 Dupl__ With StrZero( Dup->Dupl_C, 8, 0 ) + "/A",; 
                 Vlr___ With Dup->Vlr__C,; 
                 Venc__ With DTOC( Dup->Venc_C ),; 
                 Limite With Dup->Venc_C,; 
                 CodNf_ With Dup->CodNf_,; 
                 NomSac With Dup->CDescr,; 
                 EndSac With NF_->CEnder,; 
                 CepSac With NF_->CCdCep,; 
                 CidSac With NF_->CCidad,; 
                 Uf_Sac With NF_->CEstad,; 
                 Sacad_ With cSacador,; 
                 Taxa__ With nTaxa,; 
                 Juros_ With nJuros,; 
                 Protes With "",; 
                 Devol_ With "",; 
                 TipDoc With cTipoDoc,; 
                 Status With cStatus,; 
                 Select With "Sim" 
 
      EndIf 
 
 
      /* Teste da 2a. duplicata */ 
      If Dup->Vlr__D<>0 .AND. Dup->Venc_D>=dData1 .AND. Dup->Venc_D<=dData2 .AND.; 
         Dup->NFNula=" " .AND.; 
         ( NF_->NatOpe= 5.12 .OR. NF_->NatOpe=6.12 .OR.; 
           NF_->NatOpe= 5.11 .OR. NF_->NatOpe=6.11 .OR.; 
           NF_->NatOpe= 5.22 .OR. NF_->Numero=0 .OR. NF_->NatOpe=0.0 ) .AND. Dup->Quit_D $ "N " .AND.; 
           Dup->Banc_D = nBanco .AND. ( Dup->Situ_D == " " .OR. Situ_D == "0" ) 
 
         Scroll(15, 3, 19, 75, 1 ) 
         @ 19, 3 Say Tmp->NomSac 
 
         DBSelectAr( 50 ) 
         DBSetOrder( 2 ) 
 
         /* Abertura de um registro */ 
         DBAppend() 
         Replace NomCed With _EMP,; 
                 CodCed With cCodCed,; 
                 TipCar With cTipCar,; 
                 CgcCpf With NF_->CCGCMF,; 
                 DataEm With Dup->DataEm,; 
                 Dupl__ With StrZero( Dup->Dupl_D, 8, 0 ) + "/A",; 
                 Vlr___ With Dup->Vlr__D,; 
                 Venc__ With DTOC( Dup->Venc_D ),; 
                 Limite With Dup->Venc_D,; 
                 CodNf_ With Dup->CodNf_,; 
                 NomSac With Dup->CDescr,; 
                 EndSac With NF_->CEnder,; 
                 CepSac With NF_->CCdCep,; 
                 CidSac With NF_->CCidad,; 
                 Uf_Sac With NF_->CEstad,; 
                 Sacad_ With cSacador,; 
                 Taxa__ With nTaxa,; 
                 Juros_ With nJuros,; 
                 Protes With "",; 
                 Devol_ With "",; 
                 TipDoc With cTipoDoc,; 
                 Status With cStatus,; 
                 Select With "Sim" 
 
      EndIf 
 
 
 
      dbselectar(_COD_DUPLICATA) 
      dbskip() 
 
  enddo 
 
 
  DBSelectAr( 50 ) 
  DBSetOrder( 2 ) 
 
  Mensagem("Pressione [Espaco] para selecionar ou [ESC] para finalizar.") 
  Ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
  oTB:=tbrowsedb( 15, 3, 19, 75 ) 
  oTB:addcolumn( tbcolumnnew(,{|| Dupl__ + " " + NomSac + " " + Tran( Vlr___, "@E 999,999,999.99" ) + " " + Select })) 
  oTB:AUTOLITE:=.f. 
  oTB:dehilite() 
  whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      TECLA:=inkey(0) 
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
         case TECLA==K_SPACE 
              RLock() 
              If !NetErr() 
                 Replace Select With If( Select=="Sim", "Nao", "Sim" ) 
              EndIf 
              DBUnlock() 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
  enddo 
 
  SetCursor(0) 
 
  // 
  DBSelectar( 1 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  use bdlvkc0 alias CEDENTE index bdlvkc1 
  // 
 
           if (LastRec() == 0) 
              ?? "" 
              Mensagem("Impossivel gravar Movimento, Arquivo BDLVKC0 esta vazio. Pressione uma tecla" ) 
              InKey(0) 
              close databases 
              programa_p:= "BDLP00B" 
           else 
              //@ 11, 10 say "Aguarde gravando arquivos..." 
              nTotalGeral:= 0 
              confirma:= drive:= tipcar:= " " 
              gdcod:=  Tmp->CodCed 
              gdnome:= Tmp->NomCed 
              nTotalGeral:= 0 
              DBEval( {|| nTotalGeral:= nTotalGeral + Tmp->Vlr___ }, Nil, Nil, Nil, Nil, .F. ) 
              nTotalGeral:= nTotalGeral * 100 
              nTotalGeral:= LTrim(Str(nTotalGeral, 13)) 
              nTotalGeral:= Replicate("0", 13 - Len(nTotalGeral)) + nTotalGeral 
 
              //use bdlvkc0 alias CEDENTE index bdlvkc1 
 
              /* Cabecalho Principal */ 
              /* Rotina de preenchimento */ 
              select 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use BDLHEAD alias HEADER Exclusiv 
              zap 
              Append Blank 
              Replace h_Const1  With "01REMESSA",; 
                      h_Branco1 With Space(17),; 
                      h_CodCed  With cCodCed,; 
                      h_Branco2 With Space(8),; 
                      h_NomCed  With Left( M->_EMP, 30 ),; 
                      h_Const2  With "041BANRISUL",; 
                      h_Branco3 With Space(7),; 
                      h_DTGrav  With SubStr( DToC( Date() ), 1, 2 ) + SubStr( DToC( Date() ), 4, 2 ) + SubStr( DToC( Date() ), 7, 2 ),; 
                      h_densi   With Space(8),; 
                      h_branco4 With Space(286),; 
                      h_const3  With "000001" 
 
              select 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use BDLMOVI alias MOVIMENTO Exclusiv 
              Flock() 
              If NetErr() 
                 Aviso("N„o foi poss¡vel bloquear o arquivo...") 
                 Pausa() 
                 ScreenRest( cTela ) 
                 SetCursor( nCursor ) 
                 SetColor( cCor ) 
                 Return Nil 
              Endif 
              zap 
              ctcedente:= 1 
 
              DBSelectar( 50 ) 
              DBGotop() 
 
              do while !Tmp->( EOF()) 
 
                 If Tmp->Select=="Sim" 
                    ctcedente:= ctcedente + 1 
                    numero:= LTrim(Str(ctcedente, 6)) 
                    numero:= Replicate("0", 6 - Len(numero)) + numero 
                    if (Tmp->Protes != " ") 
                        instrucao1:= "09" 
                    else 
                        instrucao1:= "  " 
                    endif 
                    instrucao2:= if( Tmp->Devol_ = "10", "10", "" ) 
                    instrucao2:= if( Tmp->Devol_ = "15", "02", instrucao2 ) 
                    instrucao2:= if( Tmp->Devol_ = "30", "03", instrucao2 ) 
                    instrucao2:= if( Tmp->Devol_ = "  ", "  ", instrucao2 ) 
                    gdcodced:= Tmp->CodCed 
                    gdident:=  Tmp->IndTit 
                    gdtipcar:= Tmp->TipCar 
                    do case 
                       Case Tmp->TipCar = "1";   gdespec:= "805076" 
                       Case Tmp->TipCar = "3";   gdespec:= "815055" 
                       Case Tmp->TipCar = "5";   gdespec:= "835501" 
                       Case Tmp->TipCar = "7";   gdespec:= "825786" 
                       Case Tmp->TipCar = "4";   gdespec:= "845094" 
                       Case Tmp->TipCar = "V";   gdespec:= "825948" 
                       Case Tmp->TipCar = "U";   gdespec:= "825298" 
                       Case Tmp->TipCar = "A";   gdespec:= "825522" 
                       Case Tmp->TipCar = "B";   gdespec:= "825603" 
                    endcase 
                    gdseunum:= Tmp->Dupl__ 
                    if ( SubStr( Tmp->Venc__, 1, 1 ) = "A" ) 
                       gddtvenc:= SubStr( Tmp->Venc__, 1, 6 ) 
                    else 
                       gddtvenc:= SubStr( Tmp->Venc__, 1, 2 ) + SubStr( Tmp->Venc__, 4, 2 ) + SubStr( Tmp->Venc__, 7, 2 ) 
                    endif 
                    gdvaltit:= Tmp->Vlr___ * 100 
                    gdvaltit:= LTrim(Str(gdvaltit, 13)) 
                    gdvaltit:= Replicate("0", 13 - Len(gdvaltit)) + gdvaltit 
                    gdtipdoc:= Tmp->TipDoc 
                    gddtemis:= SubStr( DToC( Tmp->DataEm ), 1, 2) + SubStr( DToC( Tmp->DataEm ), 4, 2 ) + SubStr( DToC( Tmp->DataEm ), 7, 2 ) 
                    gdnomesac:= SubStr( Tmp->Sacad_, 1, 32 ) 
                    gdjumora:= "0" 
 
                    if ( Tmp->TipCar $ "UVAB" .AND. Tmp->Taxa__ != 0) 
                       gdjumora:= "1" 
                       gdvaljur:= Tmp->Taxa__ * 100 
                    else 
                       gdvaljur:= Tmp->Juros_ * 100 
                    endif 
 
                    gdvaldesc:=  Tmp->Descon * 100 
                    gdvaldesc:=  LTrim(Str(gdvaldesc, 13)) 
                    gdvaldesc:=  Replicate("0", 13 - Len(gdvaldesc)) + gdvaldesc 
                    gdvaljur:=   LTrim(Str(gdvaljur, 12)) 
                    gdvaljur:=   Replicate("0", 12 - Len(gdvaljur)) + gdvaljur 
                    gddtdesc:=   SubStr( DToC( Tmp->Limite ), 1, 2 ) + SubStr( DToC( Tmp->Limite ), 4, 2) + SubStr( DToC( Tmp->Limite ), 7, 2 ) 
                    gdcgccpf:=   Tmp->CgcCpf 
                    gdnomsac:=   Tmp->NomSac 
                    gdendsac:=   Tmp->EndSac 
                    gdcep:=      Replicate(" ", 8 - Len(alltrim( Tmp->CepSac ))) + alltrim( Tmp->CepSac ) 
                    gdcidade:=   SubStr( Tmp->CidSac, 1, 15) 
                    gduf:=       Tmp->UF_Sac 
                    gdprotesto:= Tmp->Protes 
 
                    /* Movimento Geral */ 
                    select MOVIMENTO 
                    Append Blank 
                    Replace m_const1   with "1",; 
                            m_branco1  with Space(16),; 
                            m_codced   with gdcodced,; 
                            m_const2   with gdespec,; 
                            m_branco2  with Space(2),; 
                            m_ident    with gdident,; 
                            m_nosnum   with Space(10),; 
                            m_sacaval  with gdnomesac,; 
                            m_branco3  with Space(3),; 
                            m_const3   with gdtipcar,; 
                            m_codocor  with "01",; 
                            m_seunum   with gdseunum,; 
                            m_dtvenc   with gddtvenc,; 
                            m_valtit   with gdvaltit,; 
                            m_const4   with "041",; 
                            m_branco4  with Space(5),; 
                            m_tipdoc   with gdtipdoc,; 
                            m_aceite   with "N",; 
                            m_dtemis   with gddtemis,; 
                            m_instru1  with instrucao1,; 
                            m_instru2  with instrucao2,; 
                            m_valjur   with gdjumora + gdvaljur,; 
                            m_dtdesc   with gddtdesc,; 
                            m_valdesc  with gdvaldesc,; 
                            m_valiof   with "0000000000000",; 
                            m_valabat  with "0000000000000",; 
                            m_tipins   with "02",; 
                            m_cgccpf   with gdcgccpf,; 
                            m_nomsac   with gdnomsac,; 
                            m_endsac   with gdendsac,; 
                            m_compen   with Space(12),; 
                            m_cep      with gdcep,; 
                            m_cidade   with gdcidade,; 
                            m_uf       with gduf,; 
                            m_taxa     with "00000",; 
                            m_calcdesc with Space(13),; 
                            m_protesto with gdprotesto,; 
                            m_branco5  with Space(23),; 
                            m_numseq   with numero 
                 EndIf 
 
                 DBSelectAr( 50 ) 
                 DBSkip() 
 
              enddo 
 
              /* Somat¢rio */ 
              select 4 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use BDLTRAI alias TRAILER Exclusiv 
              FLock() 
              If NetErr() 
                 Aviso("N„o foi poss¡vel bloquear o arquivo...") 
                 Pausa() 
                 ScreenRest( cTela ) 
                 SetCursor( nCursor ) 
                 SetColor( cCor ) 
                 Return Nil 
              Endif 
              zap 
              ctcedente:= ctcedente + 1 
              numero:= LTrim(Str(ctcedente, 6)) 
              numero:= Replicate("0", 6 - Len(numero)) + numero 
              append blank 
              replace t_const1 with "9" 
              replace t_totpra with "0000000000000" 
              replace t_totint with nTotalGeral 
              replace t_TotGer with nTotalGeral 
              replace t_branco with Space(354) 
              replace t_numseq with numero 
              close databases 
              select 1 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use BDLMOVI alias MOVIMENTO 
              copy to texto2 sdf all 
              //for Tmp->Select="Sim" 
              select 3 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use BDLTRAI alias TRAILER 
              copy to texto3 sdf all 
              select 2 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use BDLHEAD alias HEADER 
              copy to temp all 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              use TEMP 
              copy to _REMESSA sdf all 
              close databases 
              !Copy _Remessa.txt + Texto2.txt + Texto3.Txt REMESSA.TXT >Nul 
              Erase texto2.txt 
              Erase texto3.txt 
              Aviso( " Gravacao concluida com sucesso... ", 24 / 2 ) 
              Mensagem( "Pressione [ENTER] para retornar...") 
              Pausa() 
           endif 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
