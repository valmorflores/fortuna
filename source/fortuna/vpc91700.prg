// ## CL2HB.EXE - Converted
#include "INKEY.CH" 
#Include "VPF.CH" 
/* 
*      Funcao - VPC910000 
*  Finalidade - Movimentar Caixa 
*        Data - 
* Atualizacao - 
* Programador - VALMOR PEREIRA FLORES 
*/

#ifdef HARBOUR
function vpc91700()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, cDescri, cTelaRes, nTotal:= 0 
Private nCodigo:= 1 
 
   IF !AbreGrupo( "CAIXA" ) 
      Return Nil 
   ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   WHILE .T. 
      DBSelectAr( _COD_CAIXAAUX ) 
      SetCursor( 1 ) 
      SetColor( _COR_GET_EDICAO ) 
      /* Seleciona o caixa operador para fazer a manutencao de dinheiro */ 
      VPBox( 00, 00, 22, 79, "Fluxo de Caixa (PDV/Operador)", _COR_GET_BOX ) 
      @ 02, 02 Say "Caixa Operador:" Get nCodigo Pict "999" When Mensagem( "Digite o codigo do operador." ) 
      READ 
      IF LastKey() == K_ESC 
         Exit 
      ENDIF 
      IF nCodigo > 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On DATAMV To INDICE93.TMP For VENDE_ == nCodigo 
         //Eval {|| Processo() } 
      ELSE 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Index On DATAMV To INDICE93.TMP 
         //Eval {|| Processo() } 
      ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Set Index To INDICE93.TMP 
      DBGoTop() 
      nTotal:= 0 
      While !Eof() 
          IF EntSai == "+" 
             nTotal+= VALOR_ 
          ELSE 
             nTotal-= VALOR_ 
          ENDIF 
          DBSkip() 
      Enddo 
      SetColor( _COR_BROWSE ) 
      VPBox( 00, 00, 21, 79, "FLUXO DE CAIXA POR FECHAMENTO", _COR_BROW_BOX ) 
      SetCursor(0) 
      Mensagem( "" ) 
      ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
      DBLeOrdem() 
      oTab:=tbrowsedb( 01, 01, 20, 78 ) 
      oTab:AddColumn( TbColumnNew( ,{|| "(" + DTOC( DATAMV ) + "-" + HORAMV + ") " + StrZero( VENDE_, 3, 0 ) + " " + DispMotivo( MOTIVO ) + ; 
                      " " + LEFT( IF( ALLTRIM( HISTOR )=="VENDA AO CONSUMIDOR", Space( 30 ), HISTOR ), 18 ) + " " + Tran( VALOR_, "@E 999,999,999.99" ) + IF( ENTSAI=="+", " ", "-" ) })) 
      oTab:AUTOLITE:=.f. 
      oTab:dehilite() 
      oTab:PageUp() 
      whil .t. 
         oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
         whil nextkey()=0 .and.! oTab:stabilize() 
         enddo 
         nTecla:=inkey(0) 
         If nTecla=K_ESC 
            exit 
         EndIf 
         do case 
            case nTecla==K_UP         ;oTab:up() 
            case nTecla==K_LEFT       ;oTab:up() 
            case nTecla==K_RIGHT      ;oTab:down() 
            case nTecla==K_DOWN       ;oTab:down() 
            case nTecla==K_PGUP       ;oTab:pageup() 
            case nTecla==K_PGDN       ;oTab:pagedown() 
            case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
            case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
            case nTecla==K_TAB 
                 IF Confirma( 0, 0, "Imprimir?", "Imprimir o caixa?", "S" ) 
                    Relatorio( "PEQCAIXA.REP" ) 
                 ENDIF 
            case nTecla==K_ENTER 
 
            Case DBPesquisa( nTecla, oTab ) 
 
            Case nTecla == K_F2 
                 DBMudaOrdem( 1, oTab ) 
 
            Otherwise                ;tone(125); tone(300) 
         endcase 
         oTab:refreshcurrent() 
         oTab:stabilize() 
      enddo 
   ENDDO 
   FechaArquivos() 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/cx_ind01.ntx" 
   #else 
     Set Index To "&GDir\CX_IND01.NTX" 
   #endif
   Release nCodigo 
   Return(.T.) 
 
