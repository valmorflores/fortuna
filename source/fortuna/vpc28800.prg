// ## CL2HB.EXE - Converted
 
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC28800 
� Finalidade  � Cadastro de Condicoes de Pagamento 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/
#ifdef HARBOUR
function vpc28800()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla 
 
SetColor( _COR_BROWSE ) 
SetCursor(0) 
Mensagem("[Tab]Janela [A..Z]Pesquisa [ENTER]Seleciona") 
Ajuda("["+_SETAS+"][PgUp][PgDn]Movimenta") 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen() 
VPBOX( 00, 00, 15, 79, " Condicoes de Pagamento ", _COR_GET_BOX, .F., .F. ) 
VPBOX( 16, 00, 22, 79, " Display ", _COR_BROW_BOX, .F., .F. ) 
 
SetColor( _COR_GET_EDICAO ) 
@ 02, 02 Say "Codigo..............: [    ]" 
@ 03, 02 Say "Descricao...........: [                                        ]" 
@ 04, 02 Say "% 1� Parcela........: [      ]" 
@ 05, 02 Say "Condicoes (Em dias).: [  0] [  0] [  0] [  0] [  0] [  0] [  0] [  0] [  0]" 
@ 06, 02 Say "                      [  0] [  0] [  0] [  0] [  0] [  0] [  0] [  0] [  0]" 
@ 07, 02 Say "                      [  0] [  0] [  0] [  0] [  0] [  0] [  0] [  0]      " 
@ 08, 02 Say "Taxa Financiamento..: [     0.00]" 
@ 09, 02 Say "Acrescimo p/ dia....: [   0.0000]" 
@ 10, 02 Say "Acrescimo s/ tabela.: [  0.00]" 
@ 11, 02 Say "Desconto s/ tabela..: [  0.00]" 
@ 12, 02 Say "        � Multa.....: [  0.00]" 
@ 13, 02 Say " ATRASO � Juros.....: [  0.00]" 
@ 14, 02 Say "        � Tolerancia: [  0]" 
SetColor( _COR_BROWSE ) 
DBSelectAr( _COD_CONDICOES ) 
 
DBLeOrdem() 
oTab:=tbrowsedb( 17, 01, 21, 78 ) 
oTab:addcolumn(tbcolumnnew(,{|| StrZero( CODIGO, 4, 0 )+" "+DESCRI + Space( 40 ) } ) ) 
oTab:AUTOLITE:=.F. 
oTab:dehilite() 
WHILE .T. 
 
   oTab:RefreshCurrent() 
   WHILE !oTab:Stabilize() 
   ENDDO 
 
   oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
   whil nextkey()==0 .and.! oTab:stabilize() 
   enddo 
 
   SetColor( _COR_GET_CURSOR ) 
   @ 02, 25 Say StrZero( CODIGO, 4, 0 ) 
   @ 03, 25 Say DESCRI 
   @ 04, 25 Say Tran( PERCA_, "@e 999.99" ) 
   @ 05, 25 Say Tran( PARCA_, "999" ) 
   @ 05, 31 Say Tran( PARCB_, "999" ) 
   @ 05, 37 Say Tran( PARCC_, "999" ) 
   @ 05, 43 Say Tran( PARCD_, "999" ) 
   @ 05, 49 Say Tran( PARCE_, "999" ) 
   @ 05, 55 Say Tran( PARCF_, "999" ) 
   @ 05, 61 Say Tran( PARCG_, "999" ) 
   @ 05, 67 Say Tran( PARCH_, "999" ) 
   @ 05, 73 Say Tran( PARCI_, "999" ) 
   @ 06, 25 Say Tran( PARCJ_, "999" ) 
   @ 06, 31 Say Tran( PARCK_, "999" ) 
   @ 06, 37 Say Tran( PARCL_, "999" ) 
   @ 06, 43 Say Tran( PARCM_, "999" ) 
   @ 06, 49 Say Tran( PARCN_, "999" ) 
   @ 06, 55 Say Tran( PARCO_, "999" ) 
   @ 06, 61 Say Tran( PARCP_, "999" ) 
   @ 06, 67 Say Tran( PARCQ_, "999" ) 
   @ 06, 73 Say Tran( PARCR_, "999" ) 
   @ 07, 25 Say Tran( PARCS_, "999" ) 
   @ 07, 31 Say Tran( PARCT_, "999" ) 
   @ 07, 37 Say Tran( PARCU_, "999" ) 
   @ 07, 43 Say Tran( PARCV_, "999" ) 
   @ 07, 49 Say Tran( PARCW_, "999" ) 
   @ 07, 55 Say Tran( PARCX_, "999" ) 
   @ 07, 61 Say Tran( PARCY_, "999" ) 
   @ 07, 67 Say Tran( PARCZ_, "999" ) 
   @ 08, 25 Say Tran( TAXA__, "@E 99,999.99" ) 
   @ 09, 25 Say Tran( PERACD, "@E 9999.9999" ) 
   @ 10, 25 Say Tran( PERACR, "@E 999.99" ) 
   @ 11, 25 Say Tran( PERDES, "@E 999.99" ) 
   @ 12, 25 Say Tran( MULTA_, "@E 999.99" ) 
   @ 13, 25 Say Tran( JUROS_, "@E 999.99" ) 
   @ 14, 25 Say Tran( TOLERA, "999" ) 
   SetColor( _COR_BROWSE ) 
 
   IF ( nTecla:=inkey(0) )==K_ESC 
      EXIT 
   ENDIF 
 
   do case 
      case nTecla==K_UP         ;oTab:up() 
      case nTecla==K_LEFT       ;oTab:up() 
      case nTecla==K_RIGHT      ;oTab:down() 
      case nTecla==K_DOWN       ;oTab:down() 
      case nTecla==K_PGUP       ;oTab:pageup() 
      case nTecla==K_PGDN       ;oTab:pagedown() 
      case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
      case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
      case nTecla==K_ENTER 
           AlteraCondicoes( oTab ) 
      case nTecla==K_INS 
           IncluiCondicoes( oTab ) 
      case nTecla==K_DEL 
           Exclui( oTab ) 
      case nTecla == K_F2 
           DBMudaOrdem( 1, oTab ) 
      case nTecla == K_F3 
           DBMudaOrdem( 2, oTab ) 
      case DBPesquisa( nTecla, oTab ) 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTab:refreshcurrent() 
   oTab:stabilize() 
 
enddo 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiCondicoes 
� Finalidade  � Inclusao de Percentual de Comissao na Tabela 
� Parametros  � Nil 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function IncluiCondicoes( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= CODIGO + 1, cDescri:= Space( 40 ),; 
      nPerc__:= 0, nValor:= 0,; 
      nPERCA_:= 0,; 
      nPARCA_:= 0, nPARCB_:= 0, nPARCC_:= 0, nPARCD_:= 0, nPARCE_:= 0,; 
      nPARCF_:= 0, nPARCG_:= 0, nPARCH_:= 0, nPARCI_:= 0, nPARCJ_:= 0,; 
      nPARCK_:= 0, nPARCL_:= 0, nPARCM_:= 0, nPARCN_:= 0, nPARCO_:= 0,; 
      nPARCP_:= 0, nPARCQ_:= 0, nPARCR_:= 0, nPARCS_:= 0, nPARCT_:= 0,; 
      nPARCU_:= 0, nPARCV_:= 0, nPARCW_:= 0, nPARCX_:= 0, nPARCY_:= 0,; 
      nPARCZ_:= 0, nTAXA__:= 0, nPERACD:= 0, nPERACR:= 0, nPERDES:= 0,; 
      nMULTA_:= 0, nJUROS_:= 0, nTOLERA:= 0 
 
  DBSetOrder( 1 ) 
  DBSeek( 99999 ) 
  DBSkip( -1 ) 
  WHILE !LastKey() == K_ESC 
      nCodigo:= CODIGO + 1 
      cDescri:= Space( 40 ) 
      nPerc__:= 0 
      nValor:= 0 
      SetColor( _COR_GET_EDICAO ) 
      SetCursor( 1 ) 
      Set( _SET_DELIMITERS, .F. ) 
      @ 02, 25 Say StrZero( CODIGO, 4, 0 ) 
      @ 03, 25 Get cDESCRI 
      @ 04, 25 Get nPERCA_ Pict "@e 999.99" 
      @ 05, 25 Get nPARCA_ Pict "999" 
      @ 05, 31 Get nPARCB_ Pict "999" 
      @ 05, 37 Get nPARCC_ Pict "999" 
      @ 05, 43 Get nPARCD_ Pict "999" 
      @ 05, 49 Get nPARCE_ Pict "999" 
      @ 05, 55 Get nPARCF_ Pict "999" 
      @ 05, 61 Get nPARCG_ Pict "999" 
      @ 05, 67 Get nPARCH_ Pict "999" 
      @ 05, 73 Get nPARCI_ Pict "999" 
      @ 06, 25 Get nPARCJ_ Pict "999" 
      @ 06, 31 Get nPARCK_ Pict "999" 
      @ 06, 37 Get nPARCL_ Pict "999" 
      @ 06, 43 Get nPARCM_ Pict "999" 
      @ 06, 49 Get nPARCN_ Pict "999" 
      @ 06, 55 Get nPARCO_ Pict "999" 
      @ 06, 61 Get nPARCP_ Pict "999" 
      @ 06, 67 Get nPARCQ_ Pict "999" 
      @ 06, 73 Get nPARCR_ Pict "999" 
      @ 07, 25 Get nPARCS_ Pict "999" 
      @ 07, 31 Get nPARCT_ Pict "999" 
      @ 07, 37 Get nPARCU_ Pict "999" 
      @ 07, 43 Get nPARCV_ Pict "999" 
      @ 07, 49 Get nPARCW_ Pict "999" 
      @ 07, 55 Get nPARCX_ Pict "999" 
      @ 07, 61 Get nPARCY_ Pict "999" 
      @ 07, 67 Get nPARCZ_ Pict "999" 
      @ 08, 25 Get nTAXA__ Pict "@E 99,999.99" 
      @ 09, 25 Get nPERACD Pict "@E 9999.9999" 
      @ 10, 25 Get nPERACR Pict "@E 999.99" 
      @ 11, 25 Get nPERDES Pict "@E 999.99" 
      @ 12, 25 Get nMULTA_ Pict "@E 999.99" 
      @ 13, 25 Get nJUROS_ Pict "@E 999.99" 
      @ 14, 25 Get nTOLERA Pict "999" 
      READ 
      Set( _SET_DELIMITERS, .T. ) 
      IF !LastKey() == K_ESC 
         IF Confirma( 0, 0, "Confirma?", "Confirma [S/N]?", "S" ) 
            IF DBSeek( nCodigo ) 
               DBSeek( 999 ) 
               DBSkip( -1 ) 
               nCodigo:= CODIGO + 1 
            ENDIF 
            DBAppend() 
            IF netrlock() 
               Replace CODIGO With nCodigo,; 
                       DESCRI With cDescri,; 
                       PERCA_ With nPERCA_,; 
                       PARCA_ With nPARCA_,; 
                       PARCB_ With nPARCB_,; 
                       PARCC_ With nPARCC_,; 
                       PARCD_ With nPARCD_,; 
                       PARCE_ With nPARCE_,; 
                       PARCF_ With nPARCF_,; 
                       PARCG_ With nPARCG_,; 
                       PARCH_ With nPARCH_,; 
                       PARCI_ With nPARCI_,; 
                       PARCJ_ With nPARCJ_,; 
                       PARCK_ With nPARCK_,; 
                       PARCL_ With nPARCL_,; 
                       PARCM_ With nPARCM_,; 
                       PARCN_ With nPARCN_,; 
                       PARCO_ With nPARCO_,; 
                       PARCP_ With nPARCP_,; 
                       PARCQ_ With nPARCQ_,; 
                       PARCR_ With nPARCR_,; 
                       PARCS_ With nPARCS_,; 
                       PARCT_ With nPARCT_,; 
                       PARCU_ With nPARCU_,; 
                       PARCV_ With nPARCV_,; 
                       PARCW_ With nPARCW_,; 
                       PARCX_ With nPARCX_,; 
                       PARCY_ With nPARCY_,; 
                       PARCZ_ With nPARCZ_,; 
                       TAXA__ With nTAXA__,; 
                       PERACD With nPERACD,; 
                       PERACR With nPERACR,; 
                       PERDES With nPERDES,; 
                       MULTA_ With nMULTA_,; 
                       JUROS_ With nJUROS_,; 
                       TOLERA With nTOLERA 
 
            ENDIF 
            SetColor( _COR_BROWSE ) 
            oTab:RefreshAll() 
            WHILE !oTab:Stabilize() 
            ENDDO 
         ENDIF 
      ENDIF 
  ENDDO 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
oTab:RefreshAll() 
WHILE !oTab:Stabilize() 
ENDDO 
Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � AlteraCondicoes 
� Finalidade  � Inclusao de Percentual de Comissao na Tabela 
� Parametros  � Nil 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Static Function AlteraCondicoes( oTab ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodigo:= CODIGO, cDescri:= DESCRI,; 
      nPERCA_:= PERCA_,; 
      nPARCA_:= PARCA_, nPARCB_:= PARCB_, nPARCC_:= PARCC_, nPARCD_:= PARCD_, nPARCE_:= PARCE_,; 
      nPARCF_:= PARCF_, nPARCG_:= PARCG_, nPARCH_:= PARCH_, nPARCI_:= PARCI_, nPARCJ_:= PARCJ_,; 
      nPARCK_:= PARCK_, nPARCL_:= PARCL_, nPARCM_:= PARCM_, nPARCN_:= PARCN_, nPARCO_:= PARCO_,; 
      nPARCP_:= PARCP_, nPARCQ_:= PARCQ_, nPARCR_:= PARCR_, nPARCS_:= PARCS_, nPARCT_:= PARCT_,; 
      nPARCU_:= PARCU_, nPARCV_:= PARCV_, nPARCW_:= PARCW_, nPARCX_:= PARCX_, nPARCY_:= PARCY_,; 
      nPARCZ_:= PARCZ_, nTAXA__:= TAXA__, nPERACD:= PERACD, nPERACR:= PERACR, nPERDES:= PERDES,; 
      nMULTA_:= MULTA_, nJUROS_:= JUROS_, nTOLERA:= TOLERA 
 
   SetColor( _COR_GET_EDICAO ) 
   SetCursor( 1 ) 
   Set( _SET_DELIMITERS, .F. ) 
   @ 02, 25 Say StrZero( CODIGO, 4, 0 ) 
   @ 03, 25 Get cDESCRI 
   @ 04, 25 Get nPERCA_ Pict "@e 999.99" 
   @ 05, 25 Get nPARCA_ Pict "999" 
   @ 05, 31 Get nPARCB_ Pict "999" 
   @ 05, 37 Get nPARCC_ Pict "999" 
   @ 05, 43 Get nPARCD_ Pict "999" 
   @ 05, 49 Get nPARCE_ Pict "999" 
   @ 05, 55 Get nPARCF_ Pict "999" 
   @ 05, 61 Get nPARCG_ Pict "999" 
   @ 05, 67 Get nPARCH_ Pict "999" 
   @ 05, 73 Get nPARCI_ Pict "999" 
   @ 06, 25 Get nPARCJ_ Pict "999" 
   @ 06, 31 Get nPARCK_ Pict "999" 
   @ 06, 37 Get nPARCL_ Pict "999" 
   @ 06, 43 Get nPARCM_ Pict "999" 
   @ 06, 49 Get nPARCN_ Pict "999" 
   @ 06, 55 Get nPARCO_ Pict "999" 
   @ 06, 61 Get nPARCP_ Pict "999" 
   @ 06, 67 Get nPARCQ_ Pict "999" 
   @ 06, 73 Get nPARCR_ Pict "999" 
   @ 07, 25 Get nPARCS_ Pict "999" 
   @ 07, 31 Get nPARCT_ Pict "999" 
   @ 07, 37 Get nPARCU_ Pict "999" 
   @ 07, 43 Get nPARCV_ Pict "999" 
   @ 07, 49 Get nPARCW_ Pict "999" 
   @ 07, 55 Get nPARCX_ Pict "999" 
   @ 07, 61 Get nPARCY_ Pict "999" 
   @ 07, 67 Get nPARCZ_ Pict "999" 
   @ 08, 25 Get nTAXA__ Pict "@E 99,999.99" 
   @ 09, 25 Get nPERACD Pict "@E 9999.9999" 
   @ 10, 25 Get nPERACR Pict "@E 999.99" 
   @ 11, 25 Get nPERDES Pict "@E 999.99" 
   @ 12, 25 Get nMULTA_ Pict "@E 999.99" 
   @ 13, 25 Get nJUROS_ Pict "@E 999.99" 
   @ 14, 25 Get nTOLERA Pict "999" 
   READ 
   IF !LastKey() == K_ESC 
      IF netrlock() 
         Replace DESCRI With cDescri,; 
                 PERCA_ With nPERCA_,; 
                 PARCA_ With nPARCA_,; 
                 PARCB_ With nPARCB_,; 
                 PARCC_ With nPARCC_,; 
                 PARCD_ With nPARCD_,; 
                 PARCE_ With nPARCE_,; 
                 PARCF_ With nPARCF_,; 
                 PARCG_ With nPARCG_,; 
                 PARCH_ With nPARCH_,; 
                 PARCI_ With nPARCI_,; 
                 PARCJ_ With nPARCJ_,; 
                 PARCK_ With nPARCK_,; 
                 PARCL_ With nPARCL_,; 
                 PARCM_ With nPARCM_,; 
                 PARCN_ With nPARCN_,; 
                 PARCO_ With nPARCO_,; 
                 PARCP_ With nPARCP_,; 
                 PARCQ_ With nPARCQ_,; 
                 PARCR_ With nPARCR_,; 
                 PARCS_ With nPARCS_,; 
                 PARCT_ With nPARCT_,; 
                 PARCU_ With nPARCU_,; 
                 PARCV_ With nPARCV_,; 
                 PARCW_ With nPARCW_,; 
                 PARCX_ With nPARCX_,; 
                 PARCY_ With nPARCY_,; 
                 PARCZ_ With nPARCZ_,; 
                 TAXA__ With nTAXA__,; 
                 PERACD With nPERACD,; 
                 PERACR With nPERACR,; 
                 PERDES With nPERDES,; 
                 MULTA_ With nMULTA_,; 
                 JUROS_ With nJUROS_,; 
                 TOLERA With nTOLERA 
      ENDIF 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   oTab:RefreshAll() 
   WHILE !oTab:Stabilize() 
   ENDDO 
   Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � Selecao da Tabela de Preco 
� Finalidade  � 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TabelaCondicoes( nValor ) 
  Local nArea:= Select() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
   DBSelectAr( _COD_CONDICOES ) 
   DispBegin() 
   VPBox( 05, 10, 20, 72, "TABELA DE CONDICOES DE PAGAMENTO", _COR_BROW_BOX, .T., .T.  ) 
   SetColor( _COR_BROWSE ) 
   DBLeOrdem() 
   DBGoTop() 
   WHILE !CODIGO == SWSet( _INT_CONDICOES ) 
      DBSkip() 
      IF EOF() 
         EXIT 
      ENDIF 
   ENDDO 
   Mensagem( "[ENTER]Seleciona" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
   oTab:=tbrowsedb( 06, 11, 15, 71 ) 
   oTab:addcolumn(tbcolumnnew("Cod. Descricao                                  %Acr   %Des ",; 
                                       {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                                               PAD( DESCRI, 40 ) +" "+; 
                                         Tran( PERACR, "@E 999.99" ) + " " +; 
                                         Tran( PERDES, "@E 999.99" ) + " " + Space( 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   DispEnd() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      SetColor( "15/02" ) 
      IF nValor == Nil 
         cDescricao:= "Produto.........: " + LEFT( MPR->DESCRI, 40 ) 
         nPrecoTabela:= PrecoConvertido() 
         /* Calcula ACRESCIMO/DESCONTO conforme a tabela de condicoes 
            utilizada no momento */ 
         nPreco:= nPrecoTabela + ( ( nPrecoTabela * CND->PERACR ) / 100 ) 
         nPreco:= nPreco - ( ( nPreco * CND->PERDES ) / 100 ) 
      ELSE 
         IF !VALTYPE( nValor ) == "N" 
            nValor:= 0 
         ENDIF 
         cDescricao:= "Formato.........: FATURA/PARCELAMENTO         " 
         nPrecoTabela:= nValor 
         nPreco:= nValor + ( ( nValor * CND->PERACR ) / 100 ) 
         nPreco:= nPreco - ( ( nValor * CND->PERDES ) / 100 ) 
      ENDIF 
      Scroll( 16, 11, 17, 71 ) 
      @ 16,11 Say cDescricao 
      @ 17,11 Say "Valor Convertido: " + TRAN( nPreco, "@E 999,999,999.99" ) + " Acrescimo/Desconto: " + TRAN( nPreco - nPrecoTabela, "@E 9,999.99" ) 
      @ 18,11 Say "Valor Original..: " + TRAN( nPrecoTabela, "@E 999,999,999.99" ) + " " + LEFT( PRE->DESCRI, 28 ) 
      @ 19,11 Say "Vlr.1a.Parcela..: " + TRAN( ( nPreco * PERCA_ ) / 100, "@E 999,999,999.99" ) + " " + StrZero( PERCA_, 6, 2 ) + "%" + Space( 22 ) 
      SetColor( _COR_BROWSE ) 
      nTecla:=inkey(0) 
      if nTecla=K_ESC 
         exit 
      endif 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_LEFT       ;oTab:PanLeft() 
         case nTecla==K_RIGHT      ;oTab:PanRight() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==K_F8 .OR. nTecla==K_ENTER 
              SWSet( _INT_CONDICOES, CODIGO ) 
              SWSet( _INT_CONDACRESCIMO, PERACR ) 
              SWSet( _INT_CONDDESCONTO,  PERDES ) 
              EXIT 
         Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
         Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
         Case DBPesquisa( nTecla, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
 
