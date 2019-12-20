// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � TABELA DE OPERACOES COM PRODUTOS 
� Finalidade  � Lancamento de Tabela 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/
#ifdef HARBOUR
function vpc35400()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
 
   DBSelectAr( _COD_OPERACOES ) 
   Set( _SET_DELIMITERS, .T. ) 
 
   VPBox( 00, 00, 16, 79, "TABELAS DE OPERACOES COM PRODUTOS", _COR_GET_BOX,.F.,.F.  ) 
   VPBox( 17, 00, 22, 79, "Lancamentos", _COR_BROW_BOX ) 
   SetColor( _COR_BROWSE ) 
   ExibeStr() 
   DBLeOrdem() 
   Mensagem( "[INS]Inclui [ENTER]Altera [DEL]Exclui" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
 
   bBlock:= {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                    PAD( DESCRI, 50 ) +" "+; 
                   Tran( NATOPE, "@E 9.999" ) + " " +; 
                   Tran( ENTSAI, "!" ) + Space( 20 ) } 
 
   nTecla:= Nil 
   while !( nTecla == K_ESC ) 
       MostraDados() 
       oTab:= Browse( 17, 00, 22, 79, Nil, bBlock, , @nTecla, .F. ) 
       DO CASE 
          case nTecla==K_INS        ;IncluiOperacao( oTab ) 
          case nTecla==K_ENTER      ;AlteraOperacao( oTab ) 
          Case nTecla==K_DEL 
               IF BLOQ__ == "*" 
                  Aviso( "Este registro nao podera ser excluido." ) 
                  Pausa() 
               ELSE 
                  IF !CODIGO == 0 
                     Exclui( oTab ) 
                  ENDIF 
               ENDIF 
          Case nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
          Case nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
          Case DBPesquisa( nTecla, oTab ) 
       ENDCASE 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
 
Static Function ExibeStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.......: [  ]" 
  @ 03,02 Say "Descricao....: [" + SPACE( LEN( DESCRI ) ) + "]" 
  @ 04,02 Say "Nat.Op.n/Est.: [ .   ]" 
  @ 05,02 Say "Nat.Op.f/Est.: [ .   ]" 
  @ 06,02 Say "Calcula ICMs.: [ ]" 
  @ 06,23 Say "Deb/Cr: [ ]" 
  @ 07,02 Say "Documento....: [000]" 
  @ 08,02 Say "Frete Cf/Fb..: [ ]" 
  @ 09,02 Say "Estoque E/S..: [ ]" 
  @ 10,02 Say "Tabela Preco.: [   ]" 
  @ 11,02 Say "Cond.Pgto....: [   ]" 
  @ 12,02 Say "Gera Comissao: [ ]" 
  @ 13,02 Say "Observacao NF: [" + SPACE( LEN( OBSERV ) ) + "]" 
  @ 14,02 Say "Cliente/Forn.: [ ] C-Cliente  F-Fornecedor" 
  @ 15,02 Say "Mv.Financeiro: [ ] S-Sim      N-Nao       " 
  SetColor( cCor ) 
  Return nil 
 
Static Function MostraDados(cTELA) 
  cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,18 Say StrZero(CODIGO,2,0) 
  @ 03,18 Say DESCRI 
  @ 04,18 Say Tran( NATOPE, "@R 9.999" ) 
  @ 05,18 Say Tran( NATFOR, "@R 9.999" ) 
  @ 06,18 Say CALICM 
  @ 07,18 Say DEBCRE 
  @ 08,18 Say FRETE_ 
  @ 09,18 Say ENTSAI 
  @ 10,18 Say Tran( TABPRE, "999" ) 
  @ 11,18 Say Tran( TABCND, "999" ) 
  @ 12,18 Say COMISS 
  @ 13,18 Say OBSERV 
  @ 14,18 Say CLIFOR 
  @ 15,18 Say MOVFIN 
  SetColor( cCor ) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � Selecao 
� Finalidade  � 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function TabelaOperacoes( nCodigo ) 
  Local getlist:={}, ntecla 
  Local bBlock 
  Local nArea:= Select() 
  Local oTab 
  Local cCor:= SetColor(), nCursor:= SetCursor() 
  Local cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   DBSelectAr( _COD_OPERACOES ) 
   DBSetOrder( 1 ) 
   DBGoTop() 
   IF nCodigo <= 99 
      IF DBSeek( nCodigo ) 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         DBSelectAr( nArea ) 
         Return .T. 
      ENDIF 
   ENDIF 
   VPBox( 05, 10, 18, 72, "TABELA DE OPERACOES COM ESTOQUE", _COR_BROW_BOX, .T., .T.  ) 
   SetColor( _COR_BROWSE ) 
   Clear Typeahead 
   DBLeOrdem() 
   DBGoTop() 
   Mensagem( "[ENTER]Seleciona" ) 
   Ajuda( "["+_SETAS+"]Movimenta [F2/F3]Ordem [A..Z]Pesquisa" ) 
 
   /*---------------------------------------------------------------------- 
   BROWSE 
   ----------------------------------------------------------------------*/ 
   bBlock:=  {|| StrZero( CODIGO, 4, 0 ) + " "+; 
                          DESCRI +" "+; 
                    TRAN( ENTSAI, "!" ) + Space( 20 ) } 
   nTecla:= Nil 
   while !( nTecla == K_ESC ) 
       oTab:= Browse( 06, 11, 17, 71, Nil, bBlock, , @nTecla, .F. ) 
       DO CASE 
          CASE nTecla==K_ENTER 
               nCodigo:= CODIGO 
               // Importante! 
               // 
               // Browse( 0 ) = Elimina referencias do browse, pois neste 
               // ponto o programa far� um fechamento de uma janela da funcao 
               // browse() sem ser pelo modo convencional que seria com base 
               // no presionamento da tecla K_ESC 
               // 
               Browse( 0 ) 
               SetColor( cCor ) 
               SetCursor( nCursor ) 
               ScreenRest( cTela ) 
               DBSelectAr( nArea ) 
               Return .T. 
          CASE nTecla==K_F2         ;DBMudaOrdem( 1, oTab ) 
          CASE nTecla==K_F3         ;DBMudaOrdem( 2, oTab ) 
          CASE DBPesquisa( nTecla, oTab ) 
       ENDCASE 
   enddo 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   Return .F. 
 
 
/***** 
�������������Ŀ 
� Funcao      � IncluiOperacao 
� Finalidade  � Inclusao de registros 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Func IncluiOperacao( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40), nNatOpe:= 0, cEntSai:=" ",; 
        nTipDoc:= 0,;
        nNatFor:= 0, cDebCre:= " ", cCalIcm:= "S", cFrete_:= "1",;
        nTabPre:= 0, nTabCnd:= 0, cComiss:= "S", cObserv:= Space( 40 ),; 
        cCliFor:= " ", cMovFin:= "S" 
  SetColor( _COR_GET_EDICAO ) 
  VPBox( 00, 00, 16, 79, "TABELA DE OPERACOES (INCLUSAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  dbSelectAr( _COD_OPERACOES ) 
  dbSetOrder( 1 ) 
  dbGoBottom() 
  nCodigo:= Codigo + 1 
  dbgotop() 
  SetCursor( 1 ) 
  WHILE .T. 
     SetColor( _COR_GET_EDICAO ) 
     @ 02,02 Say "Codigo.......:" Get nCODIGO Pict "99" When DispInfo() 
     @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Descricao da Operacao - Ex.[COMPRA DE MERCADORIAS].") .AND. DispInfo( , GetList ) 
     @ 04,02 Say "Nat.Op.n/Est.:" Get nNatOpe pict "@R 9.999" When Mensagem("Digite a natureza de operacao p/ movimentacoes no estado.")         .AND. DispInfo( , GetList ) 
     @ 05,02 Say "Nat.Op.f/Est.:" Get nNatFor Pict "@R 9.999" When Mensagem("Digite a natureza de operacao p/ movimentacoes interestaduais." )   .AND. DispInfo( , GetList ) 
     @ 06,02 Say "Calcula ICMs.:" Get cCalIcm Pict "!"        When Mensagem("Digite [S] ou [N] para incidencia de ICMs s/ movimentos nesta operacao." ) .AND. DispInfo( 2 ) 
     @ 06,23 Say "Deb/Cr:" Get cDebCre Pict "!"        When Mensagem("[C]Credito [D]Debito." ) .AND. DispInfo( 3 )
     @ 07,02 Say "Documento....:" Get nTipDoc Pict "@R 999"  when mensagem( "Tipo de documento fiscal" ) .AND. DispInfo( 7 ) Valid TipoDocumento( @nTipDoc )
     @ 08,02 Say "Frete Cf/Fb..:" Get cFrete_                 When Mensagem("[C]CIF [F]FOB." ) .AND. DispInfo(,GetList) 
     @ 09,02 Say "Estoque E/S..:" Get cEntSai pict "!"        When Mensagem("Entrada/Saida/Outras.") .AND. DispInfo( 1 ) 
     @ 10,02 Say "Tabela Preco.:" Get ntabPre Pict "999"      When Mensagem("Tabela de Precos." ) .AND. DispInfo(,GetList) 
     @ 11,02 Say "Cond.Pgto....:" Get nTabCnd Pict "999"      When Mensagem("Tabela de Condicoes de Pagamento." ) .AND. DispInfo(,GetList) 
     @ 12,02 Say "Gera Comissao:" Get cComiss Pict "!"        When Mensagem("Digite [S] para gerar comissao sobre notas com esta movimentacao." ) .AND. DispInfo(,GetList) 
     @ 13,02 Say "Observacao NF:" Get cObserv                 When Mensagem("Digite Observacoes." ) .AND. DispInfo(,GetList) 
     @ 14,02 Say "Cliente/Forn.:" Get cCliFor Pict "!" Valid cCliFor $ "CF" When DispInfo( 4 ) 
     @ 15,02 Say "Mv.Financeiro:" Get cMovFin Pict "!" Valid cMovFin $ "SN" When DispInfo( 5 ) 
     READ 
     IF !LastKey() == K_ESC 
        If confirma(12,63,"Confirma?",; 
           "Digite [S] para confirmar o cadastramento.","S",; 
           COR[16]+","+COR[18]+",,,"+COR[17]) 
           IF DBSeek( nCodigo ) 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              Aviso( "Codigo de lancamento ser� substituido" ) 
              Pausa() 
              ScreenRest( cTelaRes ) 
              DBGoBottom() 
              nCodigo:= nCodigo + 1 
           ENDIF 
           If buscanet(5,{|| dbappend(), !neterr()}) .AND.; 
              nCODIGO <> 0 
              repl CODIGO with nCODIGO,; 
                   DESCRI With cDescri,; 
                   NATOPE with nNatOpe,; 
                   ENTSAI With cEntSai,; 
                   NATFOR With nNatFor,; 
                   DEBCRE With cDebCre,; 
                   CALICM With cCalIcm,; 
                   FRETE_ With cFrete_,; 
                   TABPRE With nTabPre,; 
                   TABCND With nTabCnd,; 
                   COMISS With cComiss,; 
                   CLIFOR With cCliFor,; 
                   MOVFIN With cMovFin,;
                   TIPDOC With nTipDoc
           EndIf 
           /* Limpa as variaveis */ 
           cDESCRI:= Space( 40 ) 
           cEntSai:= " " 
           nNatOpe:= 0 
           oTab:PageUp() 
           oTab:Down() 
           oTab:RefreshAll() 
           WHILE !oTab:Stabilize() 
           ENDDO 
           ++nCodigo 
           dbUnlockAll() 
        EndIf 
     ELSE 
        Exit 
     ENDIF 
  Enddo 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  SetColor(cCOR) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � ALTERAPRECO 
� Finalidade  � Alteracao de Precos 
� Parametros  � oTab 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function AlteraOperacao( oTab ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local GETLIST:={} 
  Local nCodigo:=0, cDescri:= Spac(40), nNatOpe:= 0, cEntSai:= 0, cMovFin, nTipDoc 
  SetColor( _COR_GET_EDICAO ) 
  SetCursor( 1 ) 
  VPBox( 00, 00, 16, 79, "TABELA DE OPERACOES COM ESTOQUE (ALTERACAO)", _COR_GET_EDICAO, .F., .F. ) 
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela") 
  nTipDoc:= TIPDOC
  nCodigo:= CODIGO
  cDescri:= DESCRI 
  nNatOpe:= NATOPE 
  cEntSai:= ENTSAI 
  nNatFor:= NATFOR 
  cCalIcm:= CALICM 
  cDebCre:= DEBCRE 
  cFrete_:= FRETE_ 
  cEntSai:= ENTSAI 
  nTabPre:= TABPRE 
  nTabCnd:= TABCND 
  cComiss:= COMISS 
  cObserv:= OBSERV 
  cCliFor:= CLIFOR 
  cMovFin:= MOVFIN 
  SetColor( _COR_GET_EDICAO ) 
  Keyboard Chr( K_ENTER ) 
  @ 02,02 Say "Codigo.......: ["+strzero(nCODIGO,3,0)+"]" 
  @ 03,02 Say "Descricao....:" Get cDescri when Mensagem("Descricao da Operacao - Ex.[COMPRA DE MERCADORIAS].") .AND. DispInfo() 
  @ 04,02 Say "Nat.Op.n/Est.:" Get nNatOpe pict "@R 9.999" When Mensagem("Digite a natureza de operacao p/ movimentacoes no estado.")         .AND. DispInfo( , GetList ) 
  @ 05,02 Say "Nat.Op.f/Est.:" Get nNatFor Pict "@R 9.999" When Mensagem("Digite a natureza de operacao p/ movimentacoes interestaduais." )   .AND. DispInfo( , GetList ) 
  @ 06,02 Say "Calcula ICMs.:" Get cCalIcm Pict "!"        When Mensagem("Digite [S] ou [N] para incidencia de ICMs s/ movimentos nesta operacao." ) .AND. DispInfo( 2 ) 
  @ 06,23 Say "Deb/Cr:" Get cDebCre Pict "!"        When Mensagem("[C]Credito [D]Debito." ) .AND. DispInfo( 3 )
  @ 07,02 Say "Documento....:" Get nTipDoc Pict "@R 999"   when mensagem( "Tipo de documento fiscal" ) .AND. DispInfo( 7 ) Valid TipoDocumento( @nTipDoc )
  @ 08,02 Say "Frete Cf/Fb..:" Get cFrete_                 When Mensagem("[C]CIF [F]FOB." ) .AND. DispInfo(,GetList) 
  @ 09,02 Say "Estoque E/S..:" Get cEntSai pict "!"        When Mensagem("Entrada/Saida/Outras.") .AND. DispInfo( 1 ) 
  @ 10,02 Say "Tabela Preco.:" Get ntabPre Pict "999"      When Mensagem("Tabela de Precos." ) .AND. DispInfo(,GetList) 
  @ 11,02 Say "Cond.Pgto....:" Get nTabCnd Pict "999"      When Mensagem("Tabela de Condicoes de Pagamento." ) .AND. DispInfo(,GetList) 
  @ 12,02 Say "Gera Comissao:" Get cComiss Pict "!"        When Mensagem("Digite [S] para gerar comissao sobre notas com esta movimentacao." ) .AND. DispInfo(,GetList) 
  @ 13,02 Say "Observacao NF:" Get cObserv                 When Mensagem("Digite Observacoes." ) .AND. DispInfo(,GetList) 
  @ 14,02 Say "Cliente/Forn.:" Get cCliFor Pict "!" Valid cCliFor $ "CF" When DispInfo( 4 ) 
  @ 15,02 Say "Mv.Financeiro:" Get cMovFin Pict "!" Valid cMovFin $ "SN" When DispInfo( 5 ) 
  READ 
  IF !LastKey() == K_ESC 
     If confirma(12,63,"Confirma?",; 
        "Digite [S] para confirmar o cadastramento.","S",; 
        COR[16]+","+COR[18]+",,,"+COR[17]) 
        If netrlock() 
           repl DESCRI With cDescri,; 
                ENTSAI with cEntSai,; 
                NATOPE With nNatOpe,; 
                NATFOR With nNatFor,; 
                DEBCRE With cDebCre,; 
                CALICM With cCalIcm,; 
                FRETE_ With cFrete_,; 
                TABPRE With nTabPre,; 
                TABCND With nTabCnd,; 
                COMISS With cComiss,; 
                OBSERV With cObserv,; 
                CLIFOR With cCliFor,; 
                MOVFIN With cMovFin,;
                TIPDOC With nTipDoc
        EndIf 
        dbUnlockAll() 
     EndIf 
  ENDIF 
  dbunlockall() 
  FechaArquivos() 
  ScreenRest(cTELA) 
  SetCursor(nCURSOR) 
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  oTab:RefreshAll() 
  WHILE !oTab:Stabilize() 
  ENDDO 
  SetColor(cCOR) 
 
 
 
Static Function DispInfo( nCodigo, GetList ) 
Local cCor:= SetColor(), cTitulo:= "" 
Static cTela 
 
   IF nCodigo==Nil 
      IF cTela <> Nil 
         ScreenRest( cTela ) 
      ELSE 
         IF GetList==Nil 
            cTela:= ScreenSave( 3, 3, 15, 79 ) 
         ENDIF 
      ENDIF 
      IF !( GetList==Nil ) 
         FOR nCt:= 1 TO Len( GetList ) 
             GetList[nCt]:Display() 
         NEXT 
      ENDIF 
      Return .T. 
   ENDIF 
 
 
   SetColor( _COR_BROWSE ) 
   VPBOX( 03, 33, 15, 77, ,_COR_BROW_BOX, .F., .F. ) 
   DO CASE 
      CASE nCodigo==1 
          cTitulo:= " E S T O Q U E " 
          @ 05,34 Say " ENTRADAS                                " 
          @ 06,34 Say " E - Produto Final & Materia-Prima      " 
          @ 07,34 Say " 1 - Materia-prima de um Produto Final  " 
          @ 08,34 Say " 2 - Produto Final (Sem Materia-prima)  " 
          @ 10,34 Say " SAIDAS                                  " 
          @ 11,34 Say " S - Produto Final & Materia-Prima      " 
          @ 12,34 Say " 3 - Materia-prima de um Produto Final  " 
          @ 13,34 Say " 4 - Produto Final (Sem Materia-prima)  " 
          @ 14,34 Say " SEM CONTROLE DE ESTOQUE (*)             " 
      CASE nCodigo==2 
          cTitulo:= " INCIDENCIA DE ICMs " 
          @ 05,34 Say " S - Caso esta operacao seja destinada  " 
          @ 06,34 Say "      a Comercializacao de Mercadorias   " 
          @ 08,34 Say " N - Caso esta operacao seja destinada  " 
          @ 09,34 Say "      a Operacoes Internas com Mercadoria" 
          @ 10,34 Say "      bem como, correcoes de Estoque     " 
      CASE nCodigo==4 
          cTitulo:= " CLIENTE / FORNECEDOR " 
          @ 05,34 Say " ��� Para movimentacoes de estoque deve-" 
          @ 06,34 Say "      se informar qual dos cadastros dese" 
          @ 07,34 Say "      ja que seja exibido no momento da  " 
          @ 08,34 Say "      consulta?                          " 
          @ 10,34 Say "      [C]Cliente ou [F]Fornecedor        " 
      CASE nCodigo==3 
          cTitulo:= " ICMs - DEBITO / CREDITO " 
          @ 05,34 Say " C - Toda a vez que for utilizada esta  " 
          @ 06,34 Say "      operacao para emissao de Notas sera" 
          @ 07,34 Say "      gerado um CREDITO de ICMs          " 
          @ 09,34 Say " D - Gera um DEBITO a cada nota que uti-" 
          @ 10,34 Say "      zar esta Operacao.                 " 
      CASE nCodigo==5 
          cTitulo:= " MOVIMENTACOES FINANCEIRAS " 
          @ 05,34 Say " ��� Informe SIM ou NAO para que o sis- " 
          @ 06,34 Say "      tema solicite informacoes fimancei-" 
          @ 07,34 Say "      ras caso esta Operacao se destine  " 
          @ 08,34 Say "      ao processamento de Notas Fiscais  " 
          @ 09,34 Say "      de Entrada de Mercadoria.          "
      CASE nCodigo==7
          cTitulo:= " TIPO DE DOCUMENTO FISCAL " 
          @ 05,34 Say " ��� 001 = Nota Fiscal Modelo I         " 
          @ 06,34 Say "      002 = Nota Fiscal Modelo I - Manual" 
          @ 07,34 Say "      003 = Nota Fiscal Balcao           " 
          @ 08,34 Say "      004 = Nota Fiscal Balcao D1        " 
          @ 09,34 Say "      005 = Cupom Fiscal                 "
          @ 10,34 Say "      999 = Outros documentos            "
   ENDCASE 
 
   @ 04,34 Say PADC( cTitulo, 41 ) Color "14/" + CorFundoAtual() 
   SetColor( cCor ) 
   Return .T. 
 
 
 
 
Function TipoDocumento( nTipDoc )
Local cCor:= SetColor(), cTela:= ScreenSave( 0, 0, 24, 79 )
Local nTipDocMax:= 6

    IF ( nTipDoc >= 0 .AND. nTipDoc <= nTipDocMax ) .OR. nTipDoc == 998
       Return .T.
    ELSE
       VPBOX( 01, 29, 10, 70, "Tipos de Documentos", _COR_MENU_BOX )
       @ 02,30 prompt " 000 = Nota Fiscal Modelo I           " 
       @ 03,30 prompt " 001 = Nota Fiscal Modelo I - Manual  " 
       @ 04,30 prompt " 002 = Nota Fiscal Balcao             " 
       @ 05,30 prompt " 003 = Nota Fiscal Balcao D1          " 
       @ 06,30 prompt " 004 = Cupom Fiscal                   "
       @ 07,30 prompt " 005 = Cupom Nao Fiscal               "
       @ 08,30 prompt " 006 = Nota Fiscal de Transporte      "
       @ 09,30 prompt " 998 = Outro                          "
       menu to nTipDoc

       if nTipDoc == 8
          nTipDoc:= 099
       else
          nTipDoc:= nTipDoc - 1 
       endif
    ENDIF

    ScreenRest( cTela )
    SetColor( cCor )

Return .T.
 
 
 
