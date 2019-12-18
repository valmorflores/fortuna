// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/* 
* Modulo      - VPC12600 
* Descricao   - Limpeza de informacoes 
* Programador - Valmor Pereira Flores 
* Data        - 10/Outubro/1994 
* Atualizacao - 
*/ 
Function MenuLimpa() 
Local cTELA:=zoom( 17, 24, 21, 44 ), cCOR:=setcolor(), nOPCAO:=0 
VPBox( 17, 24, 21, 44 ) 
WHILE .T. 
   mensagem("") 
   aadd(MENULIST,menunew(18,25," 1 Cotacoes       ",2,COR[11],; 
        "Exclusao de informacoes referentes a cotacoes & movimentos de treinamento.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(19,25," 2 Financeiro     ",2,COR[11],; 
        "Exclusao de contas de financeiro que tenham sido quitadas.",,,COR[6],.T.)) 
   aadd(MENULIST,menunew(20,25,; 
         IIF( EliminaIndices(), " 0 Fechar Sistema ",; 
                                " 0 Retornar       " ),2,COR[11],"Retorna ao menu anterior.",,,COR[6],.T.)) 
   MenuModal( MENULIST, @nOPCAO ); MENULIST:={} 
 
   // Selecoes de menu 
   do case 
      case nOPCAO=0 .or. nOPCAO=3 
           IF EliminaIndices() 
              VPTela() 
              VPBox( 02, 18, 21, 59, "ATUALIZACAO DE INDICES" ,"15/09" ) 
              VPObsBox( .T., 4, 20, ,; 
                   { "                                    ",; 
                     " Como foram eliminados alguns dados ",; 
                     "                                    ",; 
                     " dados do sistema, o mesmo esta fa- ",; 
                     "                                    ",; 
                     " zendo a recriacao de algumas infor ",; 
                     "                                    ",; 
                     " macoes necessarias ao uso do mesmo ",; 
                     "                                    ",; 
                     " Aguarde at‚ que esta operacao seja ",; 
                     "                                    ",; 
                     " finalizada e logo abra  o  sistema ",; 
                     "                                    ",; 
                     " neste computador antes dos demais. ",; 
                     "                                    " }, "15/00", .F. ) 
              Mensagem( "Refazendo conexoes do sistema FORTUNA aguarde..." ) 
              Inkey( 5 ) 
              dbCloseAll() 
              AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
              Fim() 
           ELSE 
              EXIT 
           ENDIF 
 
      case nOpcao==1 
           LimpaCotacoes() 
 
      case nOpcao==2 
           LimpaFinanceiro() 
 
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
 
 
Function LimpaCotacoes() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodOperador:= 0, cCodProduto:= "0000000" 
Local dDataBase, cNaoFaturado:= "2", cOperadorElimina:= "N", cProdutoElimina:= "N" 
Local bInfo:= {|| .T. } 
 
   VPBox( 00, 00, 22, 79, " EXCLUSAO MULTIPLA DE INFORMACOES ", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
 
   JanelaAuxiliar() 
 
   dDataBase:= CTOD( "01/" + StrZero( MONTH( DATE() ), 2, 0 ) + "/" + Right( StrZero( YEAR( DATE() ), 4, 0 ), 2 ) ) 
 
   @ 02,02 Say "Cotacoes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "15/" + CorFundoAtual() 
   @ 03,02 Say "Eliminar Cotacoes anteriores a " Get dDataBase 
   @ 04,02 Say "Eliminar Cotacoes [1]Faturados [2]Nao Faturados [ ]Todos?" Get cNaoFaturado Valid cNaoFaturado $ "12 " 
 
   @ 06,02 Say "Movimentacoes Por Operador Em Treinamento ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "15/" + CorFundoAtual() 
   @ 07,02 Say "Eliminar Registros de Treinamento?" Get cOperadorElimina Pict "!" Valid cOperadorElimina $ "SN" 
   @ 08,02 Say "               Codigo do Operador?" Get nCodOperador Pict "999" 
 
   @ 10,02 Say "Movimentacoes Por Produto Que Estao em Desuso (Fora de linha)ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "15/" + CorFundoAtual() 
   @ 11,02 Say "Eliminar Registros de Algum Produto Especifico?" Get cProdutoElimina 
   @ 12,02 Say "             Codigo do Produto:"      Get cCodProduto Pict "@R 999-9999" 
 
   READ 
 
   IF LastKey()==K_ESC 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return Nil 
   ENDIF 
 
   IF SWAlerta( " << EXCLUIR >>; Eliminar conforme especificacoes?", { " Eliminar ", " Nao Eliminar " } )==2 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return Nil 
   ENDIF 
   lConfirmado:= .T. 
 
   VPBox( 00, 00, 22, 79, " ...PROCESSANDO... ", _COR_GET_BOX ) 
 
   Set Deleted Off 
   dbCloseAll() 
   aeval(directory(GDIR+"\PED*.NTX"),{|ARQ|FileDel( GDIR+"\"+ARQ[1] ) }) 
   aeval(directory(GDIR+"\PXP*.NTX"),{|ARQ|FileDel( GDIR+"\"+ARQ[1] ) }) 
 
   DBSelectAr( 1 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/pedidos_.dbf" alias ped  
   #else 
     Use "&GDir\PEDIDOS_.DBF" Alias Ped  
   #endif
   DBGoTop() 
 
   DBSelectAr( 2 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/pedprod_.dbf" alias aux  
   #else 
     Use "&Gdir\PEDPROD_.DBF" Alias Aux  
   #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On CODIGO TO IN002 
   DBGoTop() 
 
   IF cNaoFaturado="2" 
      bInfo:= {|| PED->CODNF_ <= 0 } 
   ELSEIF cNaoFaturado="1" 
      bInfo:= {|| PED->CODNF_ > 0 } 
   ELSE 
      bInfo:= {|| .T. } 
   ENDIF 
 
   DBSelectAr( 1 ) 
   WHILE !EOF() 
        IF PED->DATA__ < dDataBase .and. eval( bInfo ) 
           Scroll( 03, 02, 20, 78, 1 ) 
           @ 20,02 Say PED->CODIGO + " " + PED->DESCRI 
           DBSelectAr( 2 ) 
           IF DBSeek( Ped->CODIGO ) 
              WHILE Aux->CODIGO==Ped->CODIGO 
                  IF RLock() 
                     Dele 
                  ENDIF 
                  Aux->( DBSkip() ) 
              ENDDO 
           ENDIF 
           IF Ped->( RLock() ) 
              Ped->( DBDelete() ) 
           ENDIF 
        ENDIF 
        DBSelectAr( 1 ) 
        DBSkip() 
        Inkey() 
        If LastKey()==K_ESC .OR. NextKey()==K_ESC 
           EXIT 
        ENDIF 
   ENDDO 
 
   DBSelectAr( 1 ) 
   PACK 
 
   DBSelectAr( 2 ) 
   PACK 
 
   EliminaIndices( lConfirmado ) 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Set Deleted On 
   dbCloseAll() 
   Return Nil 
 
 
Static Function EliminaIndices( lConfirma ) 
Static lEliminado 
   IF lConfirma==Nil 
      IF lEliminado <> Nil 
         Return lEliminado 
      ENDIF 
   ELSEIF lConfirma 
      lEliminado:= .T. 
      DBCloseAll() 
      aeval( directory(GDIR+"\*.NTX"),{|ARQ|FileDel( GDIR+"\"+ARQ[1] ) } ) 
      SWAlerta( "Operacao Concluida! Quando sair do menu de exclusoes o; sistema sera finalizado e os indices ;" +; 
                "serao atualizados na proxima execucao.", { " OK " } ) 
   ENDIF 
   Return .F. 
 
 
 
Static Function JanelaAuxiliar() 
Local cCor:= SetColor() 
   VPBox( 16, 00, 22, 79, " ATENCAO ", _COR_GET_BOX, .F., .F. ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 17,01 Say "° A eliminacao de qualquer informacao  deve  ser  gerada  somente  com  este °" 
   @ 18,01 Say "° este terminal acessando informacoes do Sistema.                            °" 
   @ 19,01 Say "° Certifique-se de que os demais usuarios estejam desconectados.             °" 
   @ 20,01 Say "° Perda de Informacoes pelo uso indevido deste modulo nao serao de responsa- °" Color "14/" + CorFundoAtual() 
   @ 21,01 Say "° bilidade da FORTUNA Automacao Comercial.                   C U I D A D O ! °" Color "14/" + CorFundoAtual() 
   Ajuda( "Em caso de duvidas na utilizacao deste modulo contacte o suporte tecnico." ) 
   SetColor( cCor ) 
   return Nil 
 
 
 
Function LimpaFinanceiro() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local dDtPagar:= dDtReceber:= CTOD( "" ), cPagSituacao:= cRecSituacao:= "1" 
Local cClienteElimina:= "N", nCodCli:= 0 
Local bPagarInfo:= {|| .T. }, bReceberInfo:= {|| .T. } 
 
   VPBox( 00, 00, 22, 79, " EXCLUSAO MULTIPLA DE INFORMACOES ", _COR_GET_BOX ) 
   SetColor( _COR_GET_EDICAO ) 
 
   JanelaAuxiliar() 
 
   dDataBase:= CTOD( "01/" + StrZero( MONTH( DATE() ), 2, 0 ) + "/" + Right( StrZero( YEAR( DATE() ), 4, 0 ), 2 ) ) 
 
   @ 02,02 Say "Contas a Pagar ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "15/" + CorFundoAtual() 
   @ 03,02 Say "Eliminar titulos anteriores a " Get dDtPagar 
   @ 04,02 Say "Eliminar titulos [1]Quitados [2]Pendentes [ ]Todos?" Get cPagSituacao Valid cPagSituacao $ "12 " 
 
 
   @ 06,02 Say "Contas a Receber ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" Color "15/" + CorFundoAtual() 
   @ 07,02 Say "Eliminar titulos anteriores a " Get dDtReceber 
   @ 08,02 Say "Eliminar titulos [1]Quitados [2]Pendentes [ ]Todos?" Get cRecSituacao Valid cRecSituacao $ "12 " 
   @ 09,02 Say "Eliminar Registros de Algum Cliente Especifico?" Get cClienteElimina 
   @ 10,02 Say "             Codigo do Cliente:"      Get nCodCli Pict "@R 999999" Valid IIF( cClienteElimina=="N", .T., PesqCli( @nCodCli ) ) 
 
 
   READ 
 
   IF LastKey()==K_ESC 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return Nil 
   ENDIF 
 
   IF SWAlerta( " << EXCLUIR >>; Eliminar conforme especificacoes?", { " Eliminar ", " Nao Eliminar " } )==2 
      ScreenRest( cTela ) 
      SetColor( cCor ) 
      Return Nil 
   ENDIF 
   lConfirmado:= .T. 
 
   VPBox( 00, 00, 22, 79, " ...PROCESSANDO... ", _COR_GET_BOX ) 
 
   Set Deleted Off 
   dbCloseAll() 
   aeval(directory(GDIR+"\DPA*.NTX"),{|ARQ|FileDel( GDIR+"\"+ARQ[1] ) }) 
   aeval(directory(GDIR+"\PAG*.NTX"),{|ARQ|FileDel( GDIR+"\"+ARQ[1] ) }) 
 
   DBSelectAr( 1 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/cddupaux.dbf" alias dpa  
   #else 
     Use "&GDir\CDDUPAUX.DBF" Alias DPA  
   #endif
   DBGoTop() 
 
   DBSelectAr( 2 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/ctapagar.dbf" alias pag  
   #else 
     Use "&Gdir\CTAPAGAR.DBF" Alias PAG  
   #endif
   DBGoTop() 
 
   IF cRecSituacao="2" 
      bReceberInfo:= {|| EMPTY( DPA->DTQT__ ) } 
   ELSEIF cRecSituacao="1" 
      bReceberInfo:= {|| !EMPTY( DPA->DTQT__ ) } 
   ELSE 
      bReceberInfo:= {|| .T. } 
   ENDIF 
 
   IF cPagSituacao="2"      /* Nao Quitadas */ 
      bPagarInfo:= {|| EMPTY( PAG->DATAPG ) } 
   ELSEIF cPagSituacao="1"  /* Quitadas */ 
      bPagarInfo:= {|| !EMPTY( PAG->DATAPG ) } 
   ELSE                     /* Todas */ 
      bPagarInfo:= {|| .T. } 
   ENDIF 
 
   DBSelectAr( 1 ) 
   DBGoTop() 
   WHILE !EOF() 
 
        /* Verificacao das condicoes */ 
        IF DPA->DATAEM < dDtReceber .and. eval( bReceberInfo ) .AND.; 
                 IIF( cClienteElimina=="S", CLIENT==nCodCli, .T. ) 
 
           Scroll( 03, 02, 20, 78, 1 ) 
           @ 20,02 Say Str( DPA->CLIENT ) + " " + DPA->CDESCR 
           IF DPA->( RLock() ) 
              DPA->( DBDelete() ) 
           ENDIF 
 
        ENDIF 
 
        DBSkip() 
        Inkey() 
        If LastKey()==K_ESC .OR. NextKey()==K_ESC 
           EXIT 
        ENDIF 
   ENDDO 
 
   DBSelectAr( 2 ) 
   DBGoTop() 
   WHILE !EOF() 
        IF PAG->EMISS_ < dDtPagar .and. EVAL( bPagarInfo ) 
           Scroll( 03, 02, 20, 78, 1 ) 
           @ 20,02 Say Str( PAG->CODIGO ) + " " + PAG->OBSERV 
           IF PAG->( RLock() ) 
              PAG->( DBDelete() ) 
           ENDIF 
        ENDIF 
        DBSkip() 
        Inkey() 
        If LastKey()==K_ESC .OR. NextKey()==K_ESC 
           EXIT 
        ENDIF 
   ENDDO 
 
   DBSelectAr( 1 ) 
   PACK 
 
   DBSelectAr( 2 ) 
   PACK 
 
   EliminaIndices( lConfirmado ) 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Set Deleted On 
   Return Nil 
 
 
