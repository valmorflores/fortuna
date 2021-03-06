// ## CL2HB.EXE - Converted
/*============================================================================= 
 
                                            PROCESSAMENTO DE NOTA FISCAL MANUAL 
 
==============================================================================*/ 
 
#include "formatos.ch" 
#include "vpf.ch" 
#include "inkey.ch" 
#include "box.ch" 
#Include "NF.CH" 

#ifdef HARBOUR
function nfmanual()
#endif


 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
Local lDelimiters:= Set( _SET_DELIMITERS ) 
 
Local cTelaRes 
Local oTab, nTecla 
Local bBlock 
Local cCorRes
 
   DBSelectAr( _COD_NFISCAL ) 
   DBSetOrder( 1 ) 
   DBGoBottom() 
 
 
   SetColor( _COR_BROWSE ) 
   Mensagem( "[INS]Nova [DEL]Excluir [TAB]Imprimir [ENTER]Verificar [*]Anular [F8]Ultima" ) 
   Ajuda( "[" + _SETAS + "]Movimenta [F2..F4]Ordem" ) 
   VPBox( 0, 0, 22, 79, "NOTAS FISCAIS", _COR_GET_BOX, .f. ) 
 
   bBlock:= {|| NF_->NFNULA + StrZero( NF_->NUMERO, 9, 0 ) + " " + NF_->CDESCR + " " + Tran( NF_->VLRTOT, "@E 999,999.99" ) + " " + DTOC( DATAEM ) } 
   WHILE .T. 
 
         ExibeDados() 
 
         /// Browse 
         oTab:= Browse( 19, 0, 22, 79, Nil, bBlock, Nil, @nTecla, .F. ) 
 
         DO CASE 

            CASE nTecla==K_F9
                cCorRes:= SetColor()
                cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                nNatOpe:= NF_->NATOPE
                VPBox( 10, 10, 16, 70, " Dados do Cabecalho ", _COR_GET_EDICAO )
                SetColor( _COR_GET_EDICAO )
                SetCursor( 1 )
                @ 12,12 Say "N.Fiscal: [" + STRZERO( NF_->NUMERO, 10, 0 ) + "]"
                @ 13,12 Say "Nat.Oper:" Get nNatOpe Pict "@R 9.999"
                @ 14,12 Say "Cliente.: [" + NF_->CDESCR + "]"
                READ
                SetCursor( 0 )
                NF_->( RLOCK() )
                REPLACE NF_->NATOPE With nNatOpe
                NF_->( DBUnlockAll() )
                ScreenRest( cTelaRes )
                SetColor( cCor )

            CASE nTecla==K_ESC
                 EXIT 
 
            CASE nTecla==K_ENTER 
                 VerificarNota() 
 
            CASE nTecla==K_DEL 
                 ExcluirNota( oTab ) 
                 dbselectar(_COD_NFISCAL) 
                 oTab:RefreshAll() 
                 WHILE !oTab:Stabilize() 
                 ENDDO 
 
 
            CASE CHR( nTecla ) == "*" 
                 cTelaRes:=ScreenSave(00,00,24,79) 
                 Aviso( "Aguarde, alterando situacao da nota fiscal...." ) 
                 dbselectar(_COD_NFISCAL) 
                 if netrlock(5) 
                    repl NFNULA with if(NFNULA="*"," ","*") 
                 endif 
                 DBUnlock() 
 
                 /* Atualizando arquivos de estoque */ 
                 dbselectar(_COD_ESTOQUE) 
                 DBSetOrder( 3 ) 
                 DBSeek( pad( "NF: " + StrZero( NF_->NUMERO, 9, 0 ), LEN( DOC___ ) ) )
                 WHILE ALLTRIM( "NF: " + StrZero( NF_->NUMERO, 9, 0 ) ) $ DOC___
                    IF netrlock(5) 
                       Replace ANULAR with if(ANULAR="*"," ","*")
                    ENDIF 
                    DBUnlockAll() 
                    DBSkip() 
                 ENDDO 
 
                 Mensagem( "Aguarde, atualizando duplicatas..." ) 
                 DBSelectAr( _COD_DUPAUX ) 
                 DBSetOrder( 1 ) 
                 IF dbseek( NF_->NUMERO ) 
                    WHILE CODNF_ == NF_->NUMERO 
                       IF netrlock( 5 ) 
                          /* Se a duplicata tiver em aberto */ 
                          IF EMPTY( DPA->DTQT__ ) 
                             IF NF_->NFNULA=="*" 
                                /* Se for anular, devolve o dinheiro ao credito do cliente */ 
                                CliInfo( DPA->CLIENT, DPA->VLR___, "+" ) 
                             ELSE 
                                /* Se for desanular, tira novamente o dinheiro 
                                   do saldo de credito do cliente, pois a duplicata ficara vigorando */ 
                                CliInfo( DPA->CLIENT, DPA->VLR___, "-" ) 
                             ENDIF 
                          ENDIF 
                          Replace NFNULA with NF_->NFNULA 
                       ENDIF 
                       DBUnlock() 
                       DBSkip() 
                    ENDDO 
                 ENDIF 
                 Mensagem( "Aguarde, atualizando produtos por nota fiscal...") 
                 dbselectar(_COD_PRODNF) 
                 DBSetOrder( 5 ) 
                 DBSeek( NF_->NUMERO ) 
                 WHILE CODNF_ == NF_->NUMERO 
                    IF netrlock(5) 
                       Repl NFNULA with if(NFNULA="*"," ","*") 
                       OPE->( DBSetOrder( 1 ) ) 
                       OPE->( DBSeek( NF_->TABOPE ) ) 
                       IF OPE->ENTSAI <> "*" 
                          IF NFNULA == "*" 
                             IF OPE->ENTSAI $ "S/3/4" 
                                PoeNoEstoque( CODRED, QUANT_ ) 
                             ELSE 
                                TiraDoEstoque( CODRED, QUANT_ ) 
                             ENDIF 
                             // Controle de Reserva 
                             ControleDeReserva( "+", Pad( CODRED, 12 ), QUANT_ ) 
                          ELSE 
                             IF OPE->ENTSAI $ "S/3/4" 
                                TiraDoEstoque( CODRED, QUANT_ ) 
                             ELSE 
                                PoeNoEstoque( CODRED, QUANT_ ) 
                             ENDIF 
                             // Controle de Reserva 
                             ControleDeReserva( "-", Pad( CODRED, 12 ), QUANT_ ) 
                          ENDIF 
                       ENDIF 
                    ENDIF 
 
 
                    DBUnlock() 
                    DBSkip() 
                    IF EOF() 
                       EXIT 
                    ENDIF 
                 ENDDO 
                 ScreenRest(cTelaRes) 
                 dbselectar(_COD_NFISCAL) 
                 oTab:RefreshAll() 
                 WHILE !oTab:Stabilize() 
                 ENDDO 
 
            CASE nTecla==K_INS 
                 IncluirNota( oTab )

            CASE nTecla==K_CTRL_TAB
                 Relatorio( "ROMANEIO.REP" )
 
            CASE nTecla==K_TAB 
                 DBSetOrder( 1 ) 
                 if confirma(24-2,63,"Imprimir?",; 
                    "Digite [S] p/ imprimir a nota fiscal.","S",; 
                    COR[16]+","+COR[18]+",,,"+COR[17]) 
                    Mensagem("Imprimindo a nota fiscal, aguarde...") 
                    Relatorio( "NFiscal.Rep" ) 
                    whil confirma(24-2,58,"Imprimir mais?",; 
                       "Digite [S] p/ imprimir mais vias da nota fiscal.","N",; 
                       COR[16]+","+COR[18]+",,,"+COR[17]) 
                       Mensagem("Imprimindo a nota fiscal, aguarde...") 
                       Relatorio( "NFiscal.Rep" ) 
                    enddo 
                 endif 
                 dbselectar(_COD_NFISCAL) 
 
            CASE DBPesquisa( nTecla, oTaB ) 
                 IF IndexOrd() == 2 
                    BuscaUltima( oTab ) 
                 ENDIF 
 
            CASE nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
 
            CASE nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
 
            CASE nTecla==K_F4         ;DBMudaOrdem( 3, oTab ) 
 
            CASE nTecla==K_F8         ;BuscaUltima( oTab ) 
 
         ENDCASE 
 
   ENDDO 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Set( _SET_DELIMITERS, lDelimiters ) 
   Return Nil 
 
/*============================================================ 
      ROTINAS ASSOCIADAS A NOTA FISCAL DE USO INTERNO 
=============================================================*/ 
Function IncluirNota( oTab ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
 
  NFInc( Nil, .T. ) 
 
  SetColor( cCor ) 
  ScreenRest( cTela ) 
  SetCursor( nCursor ) 
  DBSelectAr( _COD_NFISCAL ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  Return Nil 
 
 
 
/* 
VERIFICARNOTA 
Verificacao de Notas Fiscais 
*/ 
Function VerificarNota() 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
 
/* variaveis de tratamento de tela */ 
Local cTelaR:= {}, nLin 
 
/* variaveis da nota */ 
Local cConRev:= CONREV, nBasIcm:= BASICM, nVlrTot:= VLRTOT, nVlrNot:= VLRNOT,; 
      nVlrIpi:= VLRIPI, nNumero:= NUMERO, aProdutos 
 
 
   cTELAR:= { NIL, NIL, NIL, NIL } 
   cTELAR[1]:=ScreenSave( 00, 00, 24, 79 ) 
 
   cCORRES:=setcolor() 
   dbselectar(_COD_PRODNF) 
   dbgotop() 
   setcolor( _COR_ALERTA_LETRA ) 
   nLIN=3 
   Mensagem("Lendo arquivo de produtos, aguarde...") 
   DBSetOrder( 5 ) 
   DBSeek( nNumero ) 
   aProdutos:= 0 
   aProdutos:= {} 
   whil CODNF_ == nNumero 
      Mensagem("Pesquisando registro #"+strzero(recno(),4,0)+", aguarde...") 
      AAdd( aProdutos, { Tran( CodRed, "@R 999-9999" ),; 
                         SubStr( Descri, 1, 23 ),; 
                         StrZero( SitT01, 1, 0 ),; 
                         StrZero( SitT02, 2, 0 ),; 
                         Tran( Quant_, "@E 99999.99" ),; 
                         Tran( Precov, "@E 99999.999" ),; 
                         Tran( PrecoT, "@E 999,999.999" ),; 
                         Tran( PerIcm, "@E 999.99" ) } ) 
      DBSkip() 
   enddo 
   ExibeProdLista( aProdutos ) 
   cTELAR[2]:=ScreenSave(00,00,24-2,79) 
   if lastkey()<>K_ESC 
      dbselectar(_COD_NFISCAL) 
      vpbox( 03, 02, 20, 75, "Diversos", _COR_ALERTA_BOX, .T., .F., _COR_ALERTA_TITULO ) 
      SetColor( _COR_ALERTA_LETRA ) 
      @ 04,4 say "Frete.......:"+tran(FRETE_,"@E 999,999,999.99") 
      @ 05,4 say "Seguro......:"+tran(SEGURO,"@E 999,999,999.99") 
      @ 06,4 say "Marca.......: Nao utilizado" 
      @ 07,4 say "Numero......: Nao utilizado" 
      @ 08,4 say "Quantidade..:"+QUANT_ 
      @ 09,4 say "Data Saida..:"+dtoc(SAIDAT) 
      @ 10,4 say "Hora Saida..:"+tran(SAIHOR,"@R XX:XX.XX") 
      @ 11,4 say "Especie.....:"+ESPEC_ 
      @ 12,4 say "Peso liquido:"+tran( PESOLI, "999,999.99" ) 
      @ 13,4 say "Peso Bruto..:"+tran( PESOBR, "999,999.99" ) 
      @ 14,4 say "Obs:"+OBSER1 
      @ 15,4 say "   :"+OBSER2 
      @ 16,4 say "   :"+OBSER3 
      @ 17,4 say "   :"+OBSER4 
      @ 18,4 say "   :"+OBSER5 
      VPBox( 05, 56, 15, 73, "O.COMPRA", _COR_ALERTA_BOX, .F., .F., _COR_ALERTA_TITULO, .F.  ) 
      @ 07,58 Say SubStr( ORDEMC, 1,  10 ) 
      @ 08,58 Say SubStr( ORDEMC, 11, 10 ) 
      @ 09,58 Say SubStr( ORDEMC, 21, 10 ) 
      @ 10,58 Say SubStr( ORDEMC, 31, 10 ) 
      @ 11,58 Say SubStr( ORDEMC, 41, 10 ) 
      @ 12,58 Say SubStr( ORDEMC, 51, 10 ) 
      VPBox( 16, 56, 19, 73, " PEDIDO ", _COR_ALERTA_BOX, .F., .F., _COR_ALERTA_TITULO, .F.  ) 
      @ 18,58 Say StrZero( PEDIDO, 8, 0 ) 
      cTELAR[3]:=ScreenSave(00,00,24-2,79) 
   endif 
   inkey(0) 
   if lastkey()<>K_ESC 
      dbselectar(_COD_DUPAUX) 
      dbsetorder(1) 
      dbseek(nNUMERO) 
      aDuplicatas:= 0 
      aDuplicatas:= {} 
      WHILE CODNF_ == nNumero 
          IF TIPO__ == SPACE( 2 ) 
             AAdd( aDuplicatas, { Str( DUPL__, 10, 0 ),; 
                                  LETRA_,; 
                                  Tran( PERC__, "@E 999.99" ),; 
                                  Tran( VLR___, "@E 9,999,999.99" ),; 
                                  DTOC( VENC__ ),; 
                                  DTOC( DTQT__ ),; 
                                  StrZero( BANC__, 3, 0 ),; 
                                  CHEQ__,; 
                                  StrZero( LOCAL_, 3, 0 ) } ) 
 
          ENDIF 
          DBSkip() 
      ENDDO 
      ExibeDupLista( aDuplicatas ) 
      cTELAR[4]:=ScreenSave(00,00,24-2,79) 
      nMOD:=4 
      ajuda("["+_SETAS+"]Movimenta [ESC]Retorna") 
      Mensagem("Utilize as teclas ["+_SETAS+"] p/ movimentar entre telas.") 
      whil inkey(0)<>K_ESC 
         if lastkey()=K_DOWN .OR. lastkey()=K_RIGHT 
            if nMOD=2 
               exit 
            endif 
            if nMOD>2 
               --nMOD 
            endif 
         elseif lastkey()=K_UP .OR. lastkey()=K_LEFT 
            if nMOD<4 
               ++nMOD 
            endif 
         endif 
         If !Empty( cTelar ) 
            If Len( cTelar ) >= nMod 
               If cTelaR[nMod] <> Nil 
                  ScreenRest( cTELAR[nMOD] ) 
               EndIf 
            Endif 
         Endif 
      enddo 
   endif 
   dbselectar(_COD_NFISCAL) 
   ScreenRest(cTELAR[1]) 
   setcolor(cCORRES) 
   Return Nil 
 
 
/* 
�������������Ŀ 
� Funcao      � ExibeDupLista 
� Finalidade  � Exibir a lista de produtos da nota fiscal 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function ExibeDupLista( aDuplicatas ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, nRow:= 1 
 
   IF Len( aDuplicatas ) <= 0 
      Return Nil 
   ENDIF 
 
   VPBox( 01, 01, 16, 71, "DUPLICATAS", _COR_ALERTA_LETRA ) 
   SetColor( _COR_BROWSE ) 
   SetColor( _COR_ALERTA_LETRA ) 
   oTab:=tbrowseNew( 02, 02, 15, 70 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| aDuplicatas[ nRow ][ 1 ] })) 
   oTab:addcolumn(tbcolumnnew("L",{|| aDuplicatas[ nRow ][ 2 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 3 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 4 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 5 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 6 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aDuplicatas[ nRow ][ 7 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| Left( aDuplicatas[ nRow ][ 8 ], 13 ) })) 
   oTab:GoTopBlock:= {|| nRow:= 1 } 
   oTab:GoBottomBlock:= {|| nRow:= Len( aDuplicatas ) } 
   oTab:SkipBlock:= {|x| SkipperArr( x, aDuplicatas, @nRow ) } 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
       oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
       whil nextkey()=0 .and.! oTab:stabilize() 
       enddo 
       setcolor(COR[25]) 
       TECLA:=inkey(0) 
       if TECLA=K_ESC 
          exit 
       endif 
       do case 
          case TECLA==K_UP         ;oTab:up() 
          case TECLA==K_LEFT       ;oTab:up() 
          case TECLA==K_RIGHT      ;oTab:down() 
          case TECLA==K_DOWN       ;oTab:down() 
          case TECLA==K_PGUP       ;oTab:pageup() 
          case TECLA==K_PGDN       ;oTab:pagedown() 
          case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
          case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
          case TECLA==K_ENTER .OR. TECLA=K_TAB 
               exit 
          otherwise                ;tone(125); tone(300) 
       endcase 
       oTab:refreshcurrent() 
       oTab:stabilize() 
   enddo 
   setcursor(nCURSOR) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
/*======================================================================== 
EXCLUIRNOTA 
Parametro    - oTb 
             - Rotina de Exclusao de Notas Fiscais 
             - Valmor P. Flores 
=========================================================================*/ 
Static Function ExcluirNota( oTb ) 
Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nNumero:= NUMERO 
 
    IF NFNULA == "*" 
       Aviso( "Nota Fiscal anulada! Impossivel Excluir." ) 
       Pausa() 
       ScreenRest( cTela ) 
       Return Nil 
    ENDIF 
    If Confirma( , , "Confirma?", , "N" ) 
       Mensagem( "Aguarde, excluindo nota fiscal...." ) 
       aviso("Aguarde, limpando arquivos...",24/2) 
       IF netrlock() 
          DBDelete() 
       EndIf 
       DBUnlock() 
       Mensagem( "Aguarde, excluindo as duplicatas desta nota fiscal..." ) 
       DBSelectAr( _COD_DUPAUX ) 
       DBSetOrder( 1 ) 
       IF DBSeek( nNumero ) 
          WHILE !EOF() 
             nBanco:= LOCAL_ 
             PesqBco( @nBanco ) 
             cBancoDescri:= BAN->DESCRI 
             IF TIPO__ == "  " .AND. nNumero == CODNF_ 
                IF !Empty( DTQT__ ) 
                   LancaMovimento( DATE(), nBanco, cBancoDescri, "T", "ESTORNO P/ EXCLUSAO NF", "", VLR___, 0 ) 
                   LancaSaldos( nBanco, cBancoDescri, "T", VLR___, 0 ) 
                   IF JUROS_ > 0 
                      LancaMovimento( DATE(), nBanco, cBancoDescri, "T", "ESTORNO JUROS P/ EXCLUSAO", "NOTA FISCAL", JUROS_, 0 ) 
                      LancaSaldos( nBanco, cBancoDescri, "T", JUROS_, 0 ) 
                   ENDIF 
                ELSE 
                   CliInfo( DPA->CLIENT, DPA->VLR___, "+" ) 
                ENDIF 
 
                IF netrlock() 
                   DBDelete() 
                ELSE 
                   Aviso( "Falha na exclusao do arquivo!" ) 
                   Pausa() 
                ENDIF 
 
             ELSE 
                IF !CODNF_ == nNumero 
                   Exit 
                ENDIF 
             ENDIF 
             DBSkip() 
          ENDDO 
       ENDIF 
       Mensagem( "Aguarde, excluindo produtos da nota fiscal..." ) 
       DBSelectar( _COD_PRODNF ) 
       DBSetOrder( 5 ) 
       IF DBSeek( nNumero ) 
          OPE->( DBSetOrder( 1 ) ) 
          OPE->( DBSeek( NF_->TABOPE ) ) 
          WHILE CodNf_ == nNumero 
              IF PRECOV > 0 
                 IF OPE->ENTSAI <> "*" 
                    IF OPE->ENTSAI $ "S/3/4" 
                       PoeNoEstoque( CODRED, QUANT_ ) 
                    ELSE 
                       TiraDoEstoque( CODRED, QUANT_ ) 
                    ENDIF 
                 ENDIF 
              ENDIF 
              // Controle de Reserva 
              ControleDeReserva( "+", Pad( CODRED, 12 ), QUANT_ ) 
              IF netrlock() 
                 DBDelete() 
              Endif 
              DBUnlockAll() 
              DBSkip() 
          ENDDO 
       ENDIF 
       DBSetOrder( 1 ) 
       Set Filter To 
       Mensagem( "Atualizando a tela principal..." ) 
       DBSelectAr( _COD_NFISCAL ) 
       Set Filter To 
 
       DBSelectAr( _COD_ESTOQUE ) 
       DBSetOrder( 3 ) 
 
       cNumero:= "NF: " + STRZERO( nNumero, 9, 0 ) 
       IF DBSeek( cNumero, .T. ) 
          WHILE cNumero == LEFT( DOC___, 12 ) 
             IF netrlock() 
                DELE 
             ENDIF 
             DBUnlockAll() 
             DBSkip() 
          ENDDO 
       ELSE 
          // AT� A VERSAO 2.9-05 O PROGRAMA DE NOTA FISCAL GRAVAVA 
          // A INFORMACAO COM APENAS 8 DIGITOS. EM 23/JULHO/2003 FOI 
          // FEITA A MODIFICACAO PARA ACEITACAO COM NOVE DIGITOS E ENTAO 
          // FOI FEITO ESTE TESTE 
          cNumero:= "NF: " + STRZERO( nNumero, 8, 0 ) 
          IF DBSeek( cNumero, .T. ) 
             WHILE cNumero == LEFT( DOC___, 12 ) 
                IF netrlock() 
                   DELE 
                ENDIF 
                DBUnlockAll() 
                DBSkip() 
             ENDDO 
          ENDIF 
       ENDIF 
       DBSetOrder( 1 ) 
       DBSelectAr( _COD_NFISCAL ) 
    Endif 
    ScreenRest( cTela ) 
    DBSelectAr( _COD_NFISCAL ) 
    Return Nil 
 
 
 
 
Static Function ExibeDados() 
Local cCor:= SetColor() 
  DispBegin() 
  SetColor( _COR_GET_BOX ) 
  @ 01,03 Say "Empresa..........: ["+STRZERO( FILIAL, 3 ) + "]" 
  @ 02,03 Say "Razao............: ["+TIPONF+"]" 
  @ 03,03 Say "[ Numero da NF ]= ["+strzero(NUMERO,8,0)+"]" 
  @ 04,03 Say "Cliente..........: ["+strzero(CLIENT,6,0)+"]" 
  @ 05,03 Say "Nat. Operacao....: ["+tran(NATOPE,"9.999")+"]" 
  @ 06,03 Say "Via transporte...: ["+ LEFT( VIATRA, 14 ) + "]" 
  @ 07,03 Say "Transportadora...: ["+strzero(TRANSP,3,0)+"]" 
  @ 08,03 Say "Emissao..........: ["+dtoc(DATAEM)+"]" 
  @ 09,03 Say "Vend. Interno....: ["+strzero(VENIN_,4,0)+"]" 
  @ 10,03 Say "Vend. Externo....: ["+strzero(VENEX_,4,0)+"]" 
  @ 11,03 Say "Consumo/Industria: ["+CONREV+"]" 
  @ 12,03 Say "Total Mercadorias: ["+tran(VLRNOT,"@E 999,999,999.99")+"]" 
  @ 13,03 Say "Valor IPI total..: ["+tran(VLRIPI,"@E 999,999,999.99")+"]" 
  @ 14,03 Say "Vlr. total da NF.: ["+tran(VLRTOT,"@E 999,999,999.99")+"]" 
  @ 15,03 Say "Base de calc. ICM: ["+tran(BASICM,"@E 999,999,999.99")+"]" 
  @ 12,43 Say "Base ISSQN....: [" + Tran( ISSQNB, "@E 999,999,999.99" ) + "]" 
  @ 13,43 Say "Aliquota ISSQN: [" + Tran( ISSQNP, "@E 999,999,999.99" ) + "]" 
  @ 14,43 Say "Valor ISSQN...: [" + Tran( ISSQNV, "@E 999,999,999.99" ) + "]" 
  @ 16,03 Say "��������������������������������������������" 
  @ 17,03 Say "Valor ICMs.......: ["+tran(VLRICM,"@E 999,999,999.99")+"]" 
  @ 18,03 Say "Condicoes=1,2,3,4: ["+tran(NVEZES,"9")+"]" 
  @ 15,43 Say "%Imp s/Revenda: [" + Tran( PERSRV, "@E 999.99" ) + "]" 
  @ 16,43 Say "Vlr.Imp.s/Rev.: [" + Tran( VLRSRV, "@E 999,999,999.99" ) + "]" 
  @ 17,43 Say "Desconto NF...: [" + Tran( VLRDES, "@E 999,999,999.99" ) + "]" 
  @ 18,43 Say "Valor COFINS .: [" + Tran( COFINV, "@E 999,999,999.99" ) + "]"
  OPE->( DBSetOrder( 1 ) ) 
  OPE->( DBSeek( NF_->TABOPE ) ) 
  CND->( DbSetOrder( 1 ) ) 
  CND->( DBSeek( NF_->TABCND ) ) 
  PNF->( DBSetOrder( 1 ) ) 
  PNF->( DBSeek( NF_->NUMERO ) ) 
  PRE->( DbSetOrder( 1 ) ) 
  PRE->( DBSeek( PNF->TABPRE ) ) 
  VPBox( 02, 35, 09, 77, "Informacoes Complementares", _COR_GET_BOX, .F., .F. ) 
  @ 03,36 Say "T.Operacao: " + StrZero( OPE->CODIGO, 3, 0 ) + " - " + PAD( OPE->DESCRI, 21 ) 
  @ 04,36 Say "F.Pagto...: " + StrZero( CND->CODIGO, 3, 0 ) + " - " + PAD( CND->DESCRI, 21 ) 
  @ 05,36 Say "T.Preco...: " + StrZero( PRE->CODIGO, 3, 0 ) + " - " + PAD( PRE->DESCRI, 21 ) 
  @ 06,36 Say "�����������������������������������������" 
  @ 07,36 Say "Saida.....: " + DTOC( NF_->SAIDAT ) + " - " + Tran( NF_->SAIHOR, "@R 99:99" ) 
  @ 08,36 Say "Status....: " + IF( nf_->NFNULA==" ", "Ativa     ", "Anulada   " ) 
  DispEnd() 
  SetColor( cCor ) 
  Return(.T.) 
 
 
/***** 
�������������Ŀ 
� Funcao      � BUSCAULTIMA 
� Finalidade  � Buscar ultima nota de um determinado cliente 
� Parametros  � 
� Retorno     � Nil 
� Programador � Valmor P. Flores 
� Data        � Agosto/2001 
��������������� 
*/ 
FUNCTION BuscaUltima( oTb ) 
Local cTela:= ScreenSave( 23, 00, 24, 79 ) 
Local cDescri, cDesRes 
 
   Mensagem( "Pesquisando a ultima nota fiscal, aguarde..." ) 
   IF !( IndexOrd() == 2 ) 
      ScreenRest( cTela ) 
      Return Nil 
   ENDIF 
   cDescri:= CDESCR 
   cDesRes:= CDESCR 
   oTb:GoTop() 
   DBSeek( cDescri, .T. ) 
   WHILE !EOF() 
      Mensagem( "Buscando nota fiscal numero: " + StrZero( Numero, 6, 0 ) + ", aguarde..." ) 
      IF CDESCR == cDescri 
         DBSkip() 
      ELSE 
         DBSkip( -1 ) 
         EXIT 
      ENDIF 
   ENDDO 
   IF EOF() .OR. BOF() 
      DBSeek( cDesRes, .T. ) 
   ENDIF 
   ScreenRest( cTela ) 
   oTb:RefreshAll() 
   WHILE !oTb:Stabilize() 
   ENDDO 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � ExibeProdLista 
� Finalidade  � Exibir a lista de produtos da nota fiscal 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function ExibeProdLista( aProdutos ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cTelaRes 
Local oTab, nTecla, nRow:= 1 
 
   IF Len( aProdutos ) <= 0 
      Return Nil 
   ENDIF 
 
   VPBox( 01, 01, 21, 77, "PRODUTOS / SERVICOS", _COR_ALERTA_LETRA ) 
   SetColor( _COR_BROWSE ) 
   SetColor( _COR_ALERTA_LETRA ) 
   oTab:=tbrowseNew( 02, 02, 16, 76 ) 
   oTab:addcolumn(tbcolumnnew("Codigo",{|| aProdutos[ nRow ][ 1 ] })) 
   oTab:addcolumn(tbcolumnnew("Descricao",{|| aProdutos[ nRow ][ 2 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 3 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 4 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 5 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 6 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 7 ] })) 
   oTab:addcolumn(tbcolumnnew(,{|| aProdutos[ nRow ][ 8 ] })) 
   oTab:GoTopBlock:= {|| nRow:= 1 } 
   oTab:GoBottomBlock:= {|| nRow:= Len( aProdutos ) } 
   oTab:SkipBlock:= {|x| SkipperArr( x, aProdutos, @nRow ) } 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
       oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
       whil nextkey()=0 .and.! oTab:stabilize() 
       enddo 
       SetColor( COR[25] ) 
       IF cTelaRes <> Nil 
          ScreenRest( cTelaRes ) 
       ENDIF 
       IF D_N->( DBSeek( Str( NF_->NUMERO, 6, 0 ) + PAD( STRTRAN( aProdutos[ nRow ][ 1 ], "-", "" ), 12 ) + Str( nRow, 3 ) ) ) 
          cTelaRes:= ScreenSave( 17, 0, 21, 79 ) 
          VPBox( 17, 01, 21, 77,, _COR_GET_BOX ) 
          @ 17,01 Say " Detalhamento " Color "00/15" 
          @ 18,08 Say D_N->DETAL1 
          @ 19,08 Say D_N->DETAL2 
          @ 20,08 Say D_N->DETAL3 
       ELSE 
          cTelaRes:= Nil 
       ENDIF 
       TECLA:= Inkey( 0 ) 
       if TECLA=K_ESC 
          exit 
       endif 
       do case 
          case TECLA==K_UP         ;oTab:up() 
          case TECLA==K_LEFT       ;oTab:up() 
          case TECLA==K_RIGHT      ;oTab:down() 
          case TECLA==K_DOWN       ;oTab:down() 
          case TECLA==K_PGUP       ;oTab:pageup() 
          case TECLA==K_PGDN       ;oTab:pagedown() 
          case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
          case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
          case TECLA==K_ENTER .OR. TECLA=K_TAB 
               exit 
          otherwise                ;tone(125); tone(300) 
       endcase 
       oTab:refreshcurrent() 
       oTab:stabilize() 
   enddo 
   setcursor(nCURSOR) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
 
