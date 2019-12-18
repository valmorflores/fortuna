// ## CL2HB.EXE - Converted
#include "inkey.ch"
#include "vpf.ch" 
/* 
*      Funcao - VPC910000 
*  Finalidade - Exibir menu de CONTAS A PAGAR & CONTAS A RECEBER. 
*        Data - 
* Atualizacao - 
*/ 
#ifdef HARBOUR
function vpc91000()
#endif


  loca cTELA:=zoom( 09, 14, 19, 38), cCOR:=setcolor(), nOPCAO:=0
  vpbox( 09, 14, 19, 38 ) 
  whil .t. 
     mensagem("") 
     aadd(MENULIST,menunew(10,15," 1 Contas a Pagar     ",2,COR[11],; 
          "Inclusao, alteracao, verificacao e exclusao de ctas. a pagar.",,,    COR[6],.T.)) 
     aadd(MENULIST,menunew(11,15," 2 Contas a Receber   ",2,COR[11],; 
          "Inclusao, alteracao, verificacao e exclusao de ctas. a receber.",,,  COR[6],.T.)) 
     aadd(MENULIST,menunew(12,15," 3 Integracao         ",2,COR[11],; 
          "Modulo de verificacao (Contas a pagar x Contas a receber).",,,       COR[6],.T.)) 
     aadd(MENULIST,menunew(13,15," 4 Comissoes          ",2,COR[11],; 
          "Modulo de manutencao de comissoes.",,,                               COR[6],.T.)) 
     aadd(MENULIST,menunew(14,15," 5 Caixa (PDV)        ",2,COR[11],; 
          "Abertura, verificacao e fechamento de Caixa Operador.",,,            COR[6],.T.)) 
     aadd(MENULIST,menunew(15,15," 6 Bloquetos Cobranca ",2,COR[11],; 
          "Emissao de bloquetos e controle de recebimentos.",,,                 COR[6],.T.)) 
     aadd(MENULIST,menunew(16,15," 7 Avisos de Cobranca ",2,COR[11],; 
          "Cartas de Cobranca.",,,                                              COR[6],.T.)) 
     aadd(MENULIST,menunew(17,15," 8 Cobranca bancaria  ",2,COR[11],; 
          "Controle Bancario.",,,                                               COR[6],.T.)) 
     aadd(MENULIST,menunew(18,15," 0 Retorna            ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
     menumodal(MENULIST,@nOPCAO); MENULIST:={} 
     do case 
        case nOPCAO=9 .OR. lastkey()=K_ESC ; exit 
        case nOPCAO=1 ; VPC91100() 
        case nOPCAO=2 ; VPC91200() 
        case nOPCAO=3 ; VPC91300() 
        case nOPCAO=4 ; VPC91400() 
        case nOpcao=6 ; VPC91600() 
        CASE nOpcao=5 ; VPCCaixa() 
        CASE nOpcao=7 ; VPC92200() 
        CASE nOpcao=8 ; fCtrlBanc() 
     endcase 
  enddo 
  unzoom(cTELA) 
  setcolor(cCOR) 
return nil 
 
/* 
*      Funcao - VPCCAIXA_ 
*  Finalidade - Exibir menu de CONTAS A PAGAR & CONTAS A RECEBER. 
*        Data - 
* Atualizacao - 
*/ 
  Function VPCCaixa() 
  Local nOpcao:= 1 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
  vpbox( 16, 30, 21, 54 ) 
  whil .t. 
     mensagem("") 
     aadd(MENULIST,menunew(17,31," 1 Movimento Atual    ",2,COR[11],; 
          "Verifica o movimento atual dos caixas operadores.",,,COR[6],.T.)) 
     aadd(MENULIST,menunew(18,31," 2 Saldo Acumulado    ",2,COR[11],; 
          "Verifica saldos diarios.",,,COR[6],.T.)) 
     aadd(MENULIST,menunew(19,31," 3 Resumo Diario      ",2,COR[11],; 
          "Resumo diario de movimentacoes.",,,COR[6],.T.)) 
     aadd(MENULIST,menunew(20,31," 0 Retorna            ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
     menumodal(MENULIST,@nOPCAO); MENULIST:={} 
     do case 
        case nOpcao=4 .OR. Lastkey()=K_ESC ; EXIT 
        CASE nOpcao=1 ; VPC91500() 
        CASE nOpcao=2 ; VPC91700() 
        CASE nOpcao=3 
     endcase 
  enddo 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 
 
   Function fCtrlBanc() 
 
      Local nOpcao:= 1 
      Local cCor:= SetColor(), nCursor:= SetCursor(),; 
            cTela:= ScreenSave( 0, 0, 24, 79 ) 
      vpbox(06,30,20,60) 
      whil .t. 
         mensagem("") 
         aadd(MENULIST,menunew(07,31," 1 Sele뇙o das Duplicatas   ",2,COR[11],; 
              "Sele뇙o das duplicatas para remessa.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(08,31," 2 Consulta 꿺 Selecionadas ",2,COR[11],; 
              "Visualiza뇙o das duplicatas selecionadas.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(09,31," 3 Consulta Todas           ",2,COR[11],; 
              "Visualizacao de todos os lancamentos gerados ate hoje.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(10,31," 4 Desfazer/Recuperar       ",2,COR[11],; 
              "Desfazer Arquivo de Remessa Gerado.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(11,31," 5 Gera뇙o Arquivo Remessa  ",2,COR[11],; 
              "Grava뇙o do arquivo para a remessa ao banco.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(12,31," 6 Importa뇙o do Retorno    ",2,COR[11],; 
              "Atualiza뇙o das informa뇯es do sistema com base no arquivo de retorno.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(13,31," 7 Pesquisas                ",2,COR[11],; 
              "Pesquisas baseadas em remessas e retornos.",,,COR[6],.T.)) 
         @ 14, 31 SAY REPL( "�", 29 ) 
         aadd(MENULIST,menunew(15,31," 8 Arquivos Remetidos       ",2,COR[11],; 
              "Visualiza뇙o dos arquivos remetidos ao banco.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(16,31," 9 Arquivos Retornados      ",2,COR[11],; 
              "Visualiza뇙o dos arquivos retornados do banco.",,,COR[6],.T.)) 
         @ 17, 31 SAY REPL( "�", 29 ) 
         aadd(MENULIST,menunew(18,31," A Bloqueados p/ Selecao    ",2,COR[11],; 
              "Visualiza뇙o dos arquivos retornados do banco.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(19,31," 0 Retorna                  ",2,COR[11],; 
              "Retorna ao menu anterior.",,,COR[6],.T.)) 
         menumodal(MENULIST,@nOPCAO); MENULIST:={} 
         do case 
            case nOpcao=11 .OR. Lastkey()=K_ESC ; EXIT 
            CASE nOpcao=1 ; fSelecDup() // VPCCTRLB.PRG 
            CASE nOpcao=2 ; fConsSelec( 1 ) // VPCCTRLB.PRG 
            CASE nOpcao=3 ; fConsSelec( 2 ) // VPCCTRLB.PRG 
            CASE nOpcao=4 ; fArqRemet( "EXC" ) 
            CASE nOpcao=5 ; EscolheLayout()  // VPCCTRLB.PRG 
            CASE nOpcao=6 ; fImportRet() // VPCCTRLB.PRG 
            CASE nOpcao=7 ; PesquisaReceber() // VPCCTRLB.PRG 
            CASE nOpcao=8 ; fArqRemet("REM") // VPCCTRLB.PRG 
            CASE nOpcao=9 ; fArqRemet("RET") // VPCCTRLB.PRG 
            CASE nOpcao=10; BloquearNaSelecao() 
         endcase 
      enddo 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
 
   Return Nil 
 
 
   Function EscolheLayOut( lOpcao ) 
   Local nOpcao:= 1 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
      vpbox( 12, 43, 22, 77 )
      whil .t. 
         mensagem("") 
         aadd(MENULIST,menunew(13,44," 1 BANRISUL   - DEBITO EM CONTA",2,COR[11],; 
              "Sele뇙o das duplicatas para remessa / Debito em Conta.",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(14,44," 2 BANRISUL   - COBRANCA       ",2,COR[11],; 
              "Arquivo de Simples remessa",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(15,44," 3 REAL       - COBRANCA       ",2,COR[11],; 
              "Arquivo de Simples remessa",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(16,44," 4 UNIBANCO   - COBRANCA       ",2,COR[11],; 
              "Arquivo de Simples remessa",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(17,44," 5 BRADESCO   - COBRANCA       ",2,COR[11],; 
              "Arquivo de Simples remessa",,,COR[6],.T.))
         // bradesco = gelson outubro/2002
         aadd(MENULIST,menunew(18,44," 6 BANKBOSTON - COBRANCA       ",2,COR[11],; 
              "Arquivo de Simples remessa",,,COR[6],.T.)) 
         aadd(MENULIST,menunew(19,44," 7 B.BRASIL   - COBRANCA       ",2,COR[11],; 
              "Arquivo de Simples remessa",,,COR[6],.T.))
         aadd(MENULIST,menunew(20,44," 8 SANTANDER  - COBRANCA       ",2,COR[11],;
              "Arquivo de Simples remessa",,,COR[6],.T.))
         // santander = gelson 04/03/2004
         aadd(MENULIST,menunew(21,44," 0 Retorna                     ",2,COR[11],;
              "Retorna ao menu anterior.",,,COR[6],.T.)) 
         menumodal(MENULIST,@nOPCAO); MENULIST:={} 
         IF lOpcao <> Nil 
            Exit 
         ELSE 
            DO CASE 
               CASE nOpcao=9 .OR. Lastkey()==K_ESC ; EXIT
               CASE nOpcao=1 ; fGeracLay() 
               CASE nOpcao=2 ; fGeraLCob(41) 
               CASE nOpcao=3 ; fGeraLCob(275) 
               CASE nOpcao=4 ; fGeraLCob(409) 
               CASE nOpcao=5 ; fGeraLCob(237) 
               CASE nOpcao=6 ; fGeraLCob(479) 
               CASE nOpcao=7 ; fGeraLCob(1) 
               CASE nOpcao=8 ; fGeraLCob(8)
            endcase 
         ENDIF 
      enddo 
      SetColor( cCor ) 
      SetCursor( nCursor ) 
      ScreenRest( cTela ) 
      Retu nOpcao 
 
