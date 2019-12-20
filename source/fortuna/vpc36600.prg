// ## CL2HB.EXE - Converted
#include "vpf.ch" 
#include "inkey.ch" 
#include "ptfuncs.ch" 
#include "ptverbs.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � COPIA TABELA DIFERENCIADA DE PRECOS 
� Finalidade  � Copia itens da tabela diferenciada 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 10/09/1998 
��������������� 
*/
#ifdef HARBOUR
function vpc36600()
#endif

Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local lFlag:= .F. 
Local nTabela1:= 0, nTabela2:= 0 
 
   DBSelectAr( _COD_TABPRECO ) 
   Set( _SET_DELIMITERS, .T. ) 
   VPBox( 00, 00, 24, 79, "TABELAS DIFERENCIADAS DE PRECOS", _COR_GET_BOX,.F.,.F.  ) 
   SetColor( _COR_GET_EDICAO ) 
   @ 10,01 Say "���������������������������������������������������������Ŀ" 
   @ 11,01 Say "�   Modulo responsavel pela copia de informacoes entre  �" 
   @ 12,01 Say "�  de uma tabela de precos para outra mantendo os mesmos  �" 
   @ 13,01 Say "�  percentuais da tabela origin�ria.                      �" 
   @ 14,01 Say "�����������������������������������������������������������" 
   @ 01,01 Say "Tabela a Copiar (Origem):" Get nTabela1 Pict "999" 
   @ 02,01 Say "Tabela Destino..........:" Get nTabela2 Pict "999" 
   READ 
   DBSetOrder( 1 ) 
   DBSeek( nTabela1 ) 
   TAX->( DBSetOrder( 1 ) ) 
   IF TAX->( DBSeek( nTabela2 ) ) 
      ctelaRes:= ScreenSave( 0, 0, 24, 79 ) 
      Aviso( "Precos atuais da tabela destino ser�o excluidos." ) 
      Inkey(0) 
      ScreenRest( cTelaRes ) 
      IF LastKey() == K_ESC 
         SetColor( cCor ) 
         SetCursor( nCursor ) 
         ScreenRest( cTela ) 
         Return Nil 
      ELSE 
         WHILE TAX->CODIGO == nTabela2 .AND. !EOF() 
            IF TAX->( netrlock() ) 
               TAX->( DBDelete() ) 
            ENDIF 
            TAX->( DBSkip() ) 
         ENDDO 
      ENDIF 
   ENDIF 
   IF !PRE->CODIGO == 0 
      IF !PRE->( PERACR + PERDES ) == 0 
         cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
         Aviso( "Esta tabela trabalha com percentual s/ tabela padrao." ) 
         Pausa() 
         ScreenRest( cTelaRes ) 
      ELSE 
         CopiaTabela( nTabela2 ) 
      ENDIF 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
 
Static Function ExibeStr() 
  Local cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,02 Say "Codigo.....: [    ]" 
  @ 03,02 Say "Descricao..: [                                        ]" 
  @ 04,02 Say "% Acrescimo: [      ]" 
  @ 05,02 Say "% Desconto.: [      ]" 
  SetColor( cCor ) 
  Return nil 
 
Static Function MostraDados(cTELA) 
  cCor:= SetColor() 
  SetColor( _COR_GET_EDICAO ) 
  @ 02,16 Say strzero(CODIGO,4,0) 
  @ 03,16 Say DESCRI 
  @ 04,16 Say Tran( PERACR, "@e 999.99" ) 
  @ 05,16 Say Tran( PERDES, "@E 999.99" ) 
  SetColor( cCor ) 
  Return nil 
 
/***** 
�������������Ŀ 
� Funcao      � COPIATABELA 
� Finalidade  � Monta tabela 
� Parametros  � nTabela2 - Tabela Destino 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Static Function CopiaTabela( nTabela2 ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  Local nArea:= Select(), nOrdem:= IndexOrd() 
  Local oTab1, nTecla, nTela:= 1 
  nCodigo:= PRE->CODIGO 
  IF nTabela2 == nCodigo 
     Aviso( "Tabelas nao podem ser iguais." ) 
     Pausa() 
     SetColor( cCor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  DBSelectAr( _COD_TABAUX ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  Index On CODPRO To INDRES02.TMP For CODIGO = nCodigo Eval {|| Processo() } 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to indres02.tmp, "&gdir/taxind01.ntx", "&gdir/taxind02.ntx"   
  #else 
    Set Index To INDRES02.TMP, "&GDir\TAXIND01.NTX", "&GDir\TAXIND02.NTX"   
  #endif
  VPBox( 00, 00, 22, 79, "PRODUTOS SELECIONADOS", _COR_BROW_BOX, .F., .F.  ) 
  SetColor( _COR_BROWSE ) 
  DBLeOrdem() 
  DBGoTop() 
  oTab1:=tbrowsedb( 01, 01, 21, 78 ) 
  oTab1:addcolumn(tbcolumnnew("Codigo   Cod.Fabrica   Produto                                     Preco Venda",; 
                                      {|| Tran( TAX->CODPRO, "@R 999-9999" ) + " " + Left( TAX->CODFAB, 13 ) + " " +; 
                                              PAD( TAX->DESCRI, 35 ) +" "+; 
                                        Tran( TAX->PRECOV, "@E 99,999,999,999.9999" ) + Space( 20 ) })) 
  oTab1:AUTOLITE:=.f. 
  oTab1:dehilite() 
  cProduto:= "XX" 
  WHILE .T. 
     oTab1:colorrect({oTab1:ROWPOS,1,oTab1:ROWPOS,oTab1:COLCOUNT},{2,1}) 
     whil nextkey()=0 .and.! oTab1:stabilize() 
     enddo 
     nTecla:= INKEY() 
     IF EOF() .OR. cProduto == CODPRO + DESCRI 
        Tone( 233, 2 ) 
        Aviso( "Transferencia Concluida." ) 
        Pausa() 
        SetColor( cCor ) 
        SetCursor( nCursor ) 
        ScreenRest( cTela ) 
        EXIT 
     ENDIF 
     IF nTecla=K_ESC 
        EXIT 
     ENDIF 
     do case 
        case nTecla==K_UP         ;oTab1:up() 
        case nTecla==K_LEFT       ;oTab1:PanLeft() 
        case nTecla==K_RIGHT      ;oTab1:PanRight() 
        case nTecla==K_DOWN       ;oTab1:down() 
        case nTecla==K_PGUP       ;oTab1:pageup() 
        case nTecla==K_PGDN       ;oTab1:pagedown() 
        case nTecla==K_CTRL_PGUP  ;oTab1:gotop() 
        case nTecla==K_CTRL_PGDN  ;oTab1:gobottom() 
     endcase 
     nRegistro:= RECNO() 
     cProduto:= CODPRO + DESCRI 
     cCodPro:= CODPRO 
     cDesPro:= DESCRI 
     cCodFab:= CODFAB 
     nMargem:= MARGEM 
     nPerAcr:= PERACR 
     nPerDes:= PERDES 
     nPrecov:= PRECOV 
     nMargem:= MARGEM 
     DBAppend() 
     IF netrlock() 
        Replace CODPRO With cCodPro,; 
                DESCRI With cDesPro,; 
                CODFAB With cCodFab,; 
                CODIGO With nTabela2,; 
                PERACR With nPerAcr,; 
                PERDES With nPerDes,; 
                PRECOV With nPrecoV,; 
                MARGEM With nMargem 
     ENDIF 
     SetColor( _COR_BROWSE ) 
     DBGoto( nRegistro ) 
     oTab1:Down() 
     oTab1:RefreshCurrent() 
     oTab1:stabilize() 
  ENDDO 
  DBSelectAR( _COD_TABAUX ) 

  // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
  #ifdef LINUX
    set index to "&gdir/taxind01.ntx", "&gdir/taxind02.ntx"   
  #else 
    Set Index To "&GDir\TAXIND01.NTX", "&GDir\TAXIND02.NTX"   
  #endif
  DBSelectAr( nArea ) 
  DBSetOrder( nOrdem ) 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
