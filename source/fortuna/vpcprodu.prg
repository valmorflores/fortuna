// ## CL2HB.EXE - Converted

/* 
* Modulo      - VPCPRODU 
* Descricao   - Controle de estoque. (Entradas/Saidas) 
* Programador - Valmor Pereira Flores 
* Data        - 27/Marco/1995 
* Atualizacao - 
*/ 
#Include "vpf.ch" 
#Include "inkey.ch" 

#ifdef HARBOUR
function vpcprodu()
#endif


   LOCAL cTELA:=zoom(11,14,18,37), cCOR:=setcolor(), nOPCAO:=0 
   VpBox(11,14,18,37) 
Whil .t. 
   Mensagem("") 
   Aadd(MENULIST,MenuNew(12,15," 1 Ficha Atendimento ",2,COR[11],; 
        "Trafego de materia prima entre setores.",,,COR[6],.T.)) 
   Aadd(MENULIST,MenuNew(13,15," 2 Producao          ",2,COR[11],; 
        "Selecao dos itens para inicio da producao.",,,COR[6],.T.)) 
   @ 14,15 Say "����������������������" Color COR[11] 
   Aadd(MENULIST,MenuNew(15,15," 3 Movimentacao      ",2,COR[11],; 
        "Trafego de materia prima entre setores.",,,COR[6],.T.)) 
   Aadd(MENULIST,MenuNew(16,15," 4 Pesquisas         ",2,COR[11],; 
        "Busca informacoes sobre o andamento da producao.",,,COR[6],.T.)) 
   Aadd(MENULIST,MenuNew(17,15," 0 Retorna           ",2,COR[11],; 
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   MenuModal(MENULIST,@nOPCAO); MENULIST:={} 
   Do Case 
      Case nOpcao=0 .or. nOpcao=5; Exit 
      Case nOpcao=1; VPC57400() 
      Case nOpcao=2; MnuProducao() 
      Case nOpcao=4; MnuPesquisa() 
   EndCase 
EndDo 
DBSelectAr( _COD_ESTOQUE ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/estind01.ntx","&gdir/estind02.ntx","&gdir/estind03.ntx","&gdir/estind04.ntx"     
#else 
  Set Index To "&GDIR\ESTIND01.NTX","&GDIR\ESTIND02.NTX","&GDIR\ESTIND03.NTX","&GDir\ESTIND04.NTX"     
#endif
UnZoom(cTELA) 
SetColor(cCOR) 
Return(nil) 
 
 
Function MnuPesquisa() 
Local nOpcao:= 1 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
 
  FechaGrupo( "ESTOQUE" ) 
  AbreGrupo( "ATENDIMENTO" ) 
  VPBox( 16, 34, 20, 71 ) 
  WHILE .T. 
     Mensagem("") 
     Aadd(MENULIST,MenuNew(17,35," 1 Consulta Atend. Periodo/Setor   ",2,COR[11],; 
          "Relacao de Atendimentos por Setor",,,COR[6],.T.)) 
     Aadd(MENULIST,MenuNew(18,35," 2 Estatistica Atend Por Situacao  ",2,COR[11],; 
          "Estatistica de Atendimento por Situacao.",,,COR[6],.T.)) 
     Aadd(MENULIST,MenuNew(19,35," 0 Retorna                         ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
     MenuModal(MENULIST,@nOPCAO); MENULIST:={} 
     DO CASE 
        CASE nOPCAO=0 .or. nOPCAO=3; Exit 
        CASE nOpcao=1 ;PesqAtd()   // No Programa VPC57500.PRG 
        CASE nOpcao=2 ;PesqAtdEstatistica() 
     ENDCASE 
  ENDDO 
  FechaGrupo( "ATENDIMENTO" ) 
  AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  Return Nil 
 
Function MnuProducao() 
Local nOpcao:= 1 
Local cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
      nCursor:= SetCursor() 
 
  VPBox( 16, 34, 20, 58 ) 
  WHILE .T. 
     Mensagem("") 
     Aadd(MENULIST,MenuNew(17,35," 1 Inicio de Producao ",2,COR[11],; 
          "Ordem de Producao de um produto composto cadastrado.",,,COR[6],.T.)) 
     Aadd(MENULIST,MenuNew(18,35," 2 N�o Vinculada      ",2,COR[11],; 
          "Ordem avulsa, chamado tecnico ou ficha de atendimento.",,,COR[6],.T.)) 
     Aadd(MENULIST,MenuNew(19,35," 0 Retorna            ",2,COR[11],; 
          "Retorna ao menu anterior.",,,COR[6],.T.)) 
     MenuModal(MENULIST,@nOPCAO); MENULIST:={} 
     DO CASE 
        CASE nOPCAO=0 .or. nOPCAO=3; Exit 
        CASE nOpcao=1 
        CASE nOpcao=2 
             //VPC57400() 
     ENDCASE 
  ENDDO 
  ScreenRest( cTela ) 
  SetColor( cCor ) 
  Return Nil 
 
 
