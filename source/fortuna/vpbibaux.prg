// ## CL2HB.EXE - Converted
*************************************** VPBIBAUX ***************************************** 
*                                                                                        * 
*                    Biblioteca de funcoes para o Sistema FORTUNA                        * 
*                                                                                        * 
********************************* Valmor Pereira Flores ********************************** 
#include "vpf.ch" 
#include "inkey.ch" 
//#include "formatos.ch" 
//#include "box.ch" 
 
 
Function BuscaEmpresa( nCodigo ) 
Local nArea:= Select(), nOrdem:= IndexOrd() 
Local cCor:= SetColor(), nCursor:= SetCursor(), cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local Tecla, oTab 
priv cDiretorio 
 
 
   cDiretorio:= SWSet( _SYS_DIRREPORT ) 
   DBSelectAr( 123 ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&cdiretorio/empresas.dbf" alias emp shared 
   #else 
     USE "&cDiretorio\EMPRESAS.DBF" Alias EMP Shared 
   #endif
   DBGoTop() 
   VPBox( 05, 05, 20, 60, " VISUALIZACAO - SELECAO DE EMPRESA ", _COR_BROW_BOX ) 
 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   DBLeOrdem() 
   DBGoTop() 
 
   oTab:= tbrowsedb( 06, 06, 19, 59 ) 
   oTab:addcolumn(tbcolumnnew("Codigo Empresa",{|| STRZERO( Codigo, 4, 0) +" "+ Descri + Space( 20 ) })) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   whil .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTab:stabilize() 
      enddo 
      TECLA:=inkey(0) 
      If TECLA=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case TECLA==K_UP         ;oTab:up() 
         case TECLA==K_LEFT       ;oTab:up() 
         case TECLA==K_RIGHT      ;oTab:down() 
         case TECLA==K_DOWN       ;oTab:down() 
         case TECLA==K_PGUP       ;oTab:pageup() 
         case TECLA==K_PGDN       ;oTab:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTab:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTab:gobottom() 
         case TECLA==K_ENTER      ;nCodigo:= Codigo; Exit 
         case DBPesquisa( TECLA, oTab ) 
         case TECLA==K_F2 
              DBMudaOrdem( 1, oTab ) 
         case TECLA==K_F3 
              DBMudaOrdem( 2, oTab ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   DBSelectAr( nArea ) 
   DBSetOrder( nOrdem ) 
   Setcolor(   cCOR  ) 
   Setcursor(  nCURSOR ) 
   Screenrest( cTELA ) 
   Return( .T. ) 
 
 
 
Function TransfereCliente( nCodCli, nEmpresa ) 
local nArea:= Select() 
Local nNumeroCliente:= 0, i 
Priv cDiretorio 
   cli->( DBSetOrder( 1 )) 
   if cli->( DBSeek( nCodCli ) ) 
      if AT( "\0", GDir ) > 0 
         cDiretorio:= Left( GDir, AT( "\0", GDir ) -1 ) 
      else 
         cDiretorio:= Gdir 
      endif 
      if nEmpresa > 0 
         cDiretorio:= cDiretorio + "\" + StrZero( nEmpresa, 4, 0 ) 
      endif 
 
      // Abre area tmp com a base de clientes 
      DBSelectAr( 123 ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        use "&cdiretorio/clientes.dbf" alias tmp 
      #else 
        use "&cDiretorio\CLIENTES.DBF" Alias TMP 
      #endif

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&cdiretorio/cliind01.ntx", "&cdiretorio/cliind02.ntx",; 
                     "&cdiretorio/cliind03.ntx", "&cdiretorio/cliind04.ntx",; 
                     "&cdiretorio/cliind05.ntx" 
      #else
        set index to "&cDiretorio\CLIIND01.NTX", "&cDiretorio\CLIIND02.NTX",; 
                     "&cDiretorio\CLIIND03.NTX", "&cDiretorio\CLIIND04.NTX",; 
                     "&cDiretorio\CLIIND05.NTX" 

      #endif
 
 
      DBSetOrder( 2 ) 
 
      IF DBSeek( tmp->descri ) 
         nNumeroCliente:= tmp->codigo 
      ELSE 
 
         // Busca numero do cliente 
         dbgobottom() 
         nNumeroCliente:= tmp->codigo + 1 
 
         // Append 
         tmp->( DBAppend() ) 
 
 
         // Replace dos campos 
         aFields:= tmp->( DBStruct() ) 
         FOR i:= 1 TO Len( aFields ) 
             cCampo:= aFields[i][1] 
             Replace tmp->&cCampo with cli->&cCampo 
         NEXT 
 
         // Grava numero do cliente 
         Replace tmp->codigo with nNumeroCliente 
 
      ENDIF 
 
   endif 
   DBSelectAr( nArea ) 
   return nNumeroCliente 
 
 
Function GeraPedido( nEmpresa, nCodCli, aProdutos ) 
local cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select() 
 Priv cDiretorio 
 
      // Diretorio 
      IF AT( "\0", GDir ) > 0 
         cDiretorio:= Left( GDir, AT( "\0", GDir ) -1 ) 
      ELSE 
         cDiretorio:= Gdir 
      ENDIF 
      IF nEmpresa > 0 
         cDiretorio:= cDiretorio + "\" + StrZero( nEmpresa, 4, 0 ) 
      ENDIF 
 
      // Fecha Area de Caixa 
      DBSelectAr( _COD_CAIXAAUX ) 
      DBCloseArea() 
 
      // Abre area tmp com a base de clientes 
      DBSelectAr( 123 ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        use "&cdiretorio/clientes.dbf" alias tmp 
      #else 
        use "&cDiretorio\CLIENTES.DBF" Alias TMP 
      #endif

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&cdiretorio/cliind01.ntx", "&cdiretorio/cliind02.ntx",; 
                     "&cdiretorio/cliind03.ntx", "&cdiretorio/cliind04.ntx",; 
                     "&cdiretorio/cliind05.ntx" 
      #else
        set index to "&cDiretorio\CLIIND01.NTX", "&cDiretorio\CLIIND02.NTX",; 
                     "&cDiretorio\CLIIND03.NTX", "&cDiretorio\CLIIND04.NTX",; 
                     "&cDiretorio\CLIIND05.NTX" 

      #endif
 
      // Abre area tmp com a base de clientes 
      DBSelectAr( 124 ) 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        use "&cdiretorio/pedidos_.dbf" alias tped 
      #else 
        use "&cDiretorio\PEDIDOS_.DBF" Alias TPED 
      #endif

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&cdiretorio/pedind01.ntx", "&cdiretorio/pedind02.ntx",; 
                     "&cdiretorio/pedind03.ntx", "&cdiretorio/pedind04.ntx",; 
                     "&cdiretorio/pedind05.ntx", "&cdiretorio/pedind06.ntx", "&cdiretorio/pedind07.ntx" 
      #else
        set index to "&cDiretorio\PEDIND01.NTX", "&cDiretorio\PEDIND02.NTX",; 
                     "&cDiretorio\PEDIND03.NTX", "&cDiretorio\PEDIND04.NTX",; 
                     "&cDiretorio\PEDIND05.NTX", "&cDiretorio\PEDIND06.NTX", "&cDiretorio\PEDIND07.NTX" 

      #endif
 
      TMP->( DBSetOrder( 1 ) ) 
      IF TMP->( DBSeek( nCodCli ) ) 
         TPED->( DBSetOrder( 1 ) ) 
         TPED->( DBGoBottom() ) 
         nCotacao:= VAL( TPED->( CODIGO ) ) 
         DBSetOrder( 6 ) 
         TPED->( DBGoBottom() ) 
 
         nPedido:=  VAL( TPED->CODPED ) 
 
         // Grava o Pedido 
         TPED->( DBAppend() ) 
         Replace TPED->DESCRI With CUP->CDESCR,; 
                 TPED->ENDERE With CUP->CENDER,; 
                 TPED->BAIRRO With CUP->CBAIRR,; 
                 TPED->CIDADE With CUP->CCIDAD,; 
                 TPED->ESTADO With CUP->CESTAD,; 
                 TPED->CODCLI With CUP->CLIENT,; 
                 TPED->VLRTOT With CUP->VLRTOT,; 
                 TPED->DATAEM With CUP->DATAEM,; 
                 TPED->DATA__ With CUP->DATAEM,; 
                 TPED->CODIGO With StrZero( nCotacao+1, 8, 0 ),; 
                 TPED->CODPED With StrZero( nPedido+1, 8, 0 ) 
 
 
          // Fecha areas temporarias para abrir espaco em 256 files 
          DBSelectAr( 124 ) 
          DBCloseArea() 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&cdiretorio/pedprod_.dbf" alias tpxp 
          #else 
            use "&cDiretorio\PEDPROD_.DBF" Alias TPXP 
          #endif

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            set index to "&cdiretorio/ppdind01.ntx", "&cdiretorio/ppdind02.ntx",; 
                         "&cdiretorio/ppdind03.ntx", "&cdiretorio/ppdind04.ntx",; 
                         "&cdiretorio/ppdind05.ntx" 
          #else
            set index to "&cDiretorio\PPDIND01.NTX", "&cDiretorio\PPDIND02.NTX",; 
                         "&cDiretorio\PPDIND03.NTX", "&cDiretorio\PPDIND04.NTX",; 
                         "&cDiretorio\PPDIND05.NTX" 

          #endif
 
          // Itens por pedido 
          VPBox( 02, 04, 18, 60, " ITENS DO PEDIDO ", _COR_GET_EDICAO ) 
          FOR i:= 1 TO LEN( aProdutos ) 
              @ 03+I,06 say str( i, 4, 0 ) + " " + aProdutos[ i ][ 2 ] Color IIF( VAL( aProdutos[ i ][ 1 ] )==0, "07/" + CorFundoAtual(), "15/" + CorFundoAtual() ) 
              TPXP->( DBAppend() ) 
              //AADD( aProdutos, { CAU->CODPRO, CAU->CDESCR, CAU->UNIDAD, CAU->VLRUNI, CAU->QUANT_ } ) 
              Replace TPXP->CODPED With StrZero( nPedido+1, 8, 0 ),; 
                      TPXP->CODIGO With StrZero( nCotacao+1, 8, 0 ),; 
                      TPXP->CODPRO With VAL( aProdutos[ i ][ 1 ] ),; 
                      TPXP->DESCRI With aProdutos[ i ][ 2 ],; 
                      TPXP->UNIDAD With aProdutos[ i ][ 3 ],; 
                      TPXP->VLRUNI With aProdutos[ i ][ 4 ],; 
                      TPXP->VLRINI With aProdutos[ i ][ 4 ],; 
                      TPXP->QUANT_ With aProdutos[ i ][ 5 ],; 
                      TPXP->SELECT With "Sim",; 
                      TPXP->TABCND With 0 
          NEXT 
          Inkey(0) 
 
      ELSE 
         Aviso( "Cliente nao foi localizado na base de dados da empresa." ) 
         Pausa() 
         DBSelectAr( nArea ) 
         Return Nil 
      ENDIF 
 
      DBSelectAr( 123 ) 
      DBCloseArea() 
 
      DBSelectAr( 124 ) 
      DBCloseArea() 
 
      DBSelectAr( nArea ) 
ScreenRest( cTela ) 
Return Nil 
 
 
 
 
 
/* 
* Funcao      - EXIBEDBF 
* Finalidade  - Executar a exibicao dos dados do arquivo 
* Programador - Valmor Pereira Flores 
* Data        - 20/Outubro/1994 
* Atualizacao - 
*/ 
func exibedbf() 
loca nLIN:= smPG[1], nREGISTROS:= smPG[2], bMASCARA:= smPG[7] 
loca cCOR:= SetColor(), nCOL:=0, nCT 
 
Mensagem( " Exibindo display de descricao, aguarde... " ) 
nREGISTROS:=24-(nLIN+5) 
Mensagem( "Localizando o topo do arquivo, aguarde..." ) 
If nCodigo=0 
   if nOrdemG == 1 
      DBSeek( 1, .T. ) 
   endif 
else 
   Mensagem( "Procurando o registro, aguarde..." ) 
   If nORDEMG=1 
      dbseek(nCodigo)  // Pesquisa Codigo 
   ElseIf nORDEMG=2 
      dbseek(cDescri)  // Pesquisa nome 
   EndIf 
EndIf 
Mensagem( "Localizacao efetuada corretamente. REG#" + StrZero( nRegistros, 4, 0 ) ) 
IF nOrdemG == 1 
   DBSeek( CODIGO - nRegistros, .T. ) 
ENDIF 
Mensagem( "SKIPUP Completo..." ) 
SetColor( _COR_BROW_LETRA ) 
VPBox( nLIN+=1, nCOL, 24-2, 79, , _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
for nCT:=0 to nREGISTROS 
    Mensagem( "Montando exibicao do registro #" + StrZero( nRegistros, 6, 0 ) + ", aguarde..." ) 
    If nORDEMG=1 
       setcolor( If( Codigo= nCodigo, _COR_ALERTA_LETRA, _COR_BROW_LETRA ) ) 
    ElseIf nORDEMG=2 
       setcolor( If( Descri= cDescri, _COR_ALERTA_LETRA, _COR_BROW_LETRA ) ) 
    EndIf 
    @ ++nLin,nCol+1 Say Space( 78 ) 
    @ nLin,nCol+1 Say Left( &bMASCARA, 78 ) 
    dbskip(+1) 
    If eof() 
       exit 
    EndIf 
next 
Mensagem( "Fim da exibicao do display..." ) 
setcolor(cCOR) 
return(.t.) 
 
/* 
* Funcao      - PESQUISADBF 
* Finalidade  - Executar a rolagem dentro do arquivo de clientes 
* Programador - Valmor Pereira Flores 
* Data        - 
* Atualizacao - 
*/ 
func pesquisadbf(nPMOD) 
loca GETLIST:={} 
loca nCURSOR:=setcursor(), cCOR:=setcolor(), oTB,; 
     cTELA:=screensave(24-1,00,24,79) 
loca nLIN:=smPG[1],; 
     nREGISTROS:=smPG[2],; 
     aMODULOS:={smPG[3],smPG[4]},; 
     MODCHAMA:=smPG[5],; 
     MODMOSTRA:=smPG[6],; 
     cMASCARA:=smPG[7] 
priv aTELA 
aTELA:=screensave(00,00,24,79) 
aviso(" Aguarde... ",24/2) 
If nCodigo=0 
   DBGoTop() 
else 
   If nORDEMG=1 
      dbseek(nCodigo) 
      dbskip(-nREGISTROS) 
   ElseIf nORDEMG=2 
      dbseek(cDescri) 
   EndIf 
EndIf 
ScreenRest(aTELA) 
SetColor( _COR_BROWSE ) 
Scroll( nLin, 0, 24-2, 79 ) 
DispBox( nLIN, 0, 24-2, 79, _BOX_UM ) 
If ValType(nPMOD)=="C" 
   nPMOD=If(nPMOD=aMODULOS[1] .OR. nPMOD=aMODULOS[2],1,nPMOD) 
EndIf 
if npmod==1 .or. npmod==2 
   mensagem(If(nPMOD=1,"Pressione [TAB] ou [ENTER] para efetuar alteracoes.",; 
                       "Pressione [TAB] ou [ENTER] para excluir.")) 
else 
   mensagem( "Pressione ESC para sair..." ) 
endif 
DBLeOrdem() 
ajuda("["+_SETAS+"][PgUp][PgDn]Move "+; 
      "[Nome/Codigo]Pesquisa [TAB]Executa") 
oTB:=tbrowsedb(nLIN+1,02,24-3,79-2) 
oTB:addcolumn(tbcolumnnew(,{|| &cMASCARA })) 
oTB:AUTOLITE:=.f. 
oTB:dehilite() 
IF nPMod == 1 .OR. nPMod == 2 
   oTb:GoBottom() 
ENDIF 
WHILE .T. 
   oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oTB:stabilize() 
   enddo 
   If(MODMOSTRA<>NIL,&MODMOSTRA,NIL) 
   nCodigo=Codigo 
   TECLA:=inkey(0) 
   nPMOD:=If(nPMOD=NIL,1,nPMOD) 
   If valtype(nPMOD)=="C" 
      nPMOD=If(nPMOD=aMODULOS[1] .OR. nPMOD=aMODULOS[2],1,nPMOD) 
   EndIf 
   If TECLA=K_ESC 
      exit 
   EndIf 
   do case 
      case TECLA==K_UP         ;oTB:up() 
      case TECLA==K_LEFT       ;oTB:up() 
      case TECLA==K_RIGHT      ;oTB:down() 
      case TECLA==K_DOWN       ;oTB:down() 
      case TECLA==K_PGUP       ;oTB:pageup() 
      case TECLA==K_PGDN       ;oTB:pagedown() 
      case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
      case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
      case DBPesquisa( TECLA, oTb ) 
      case TECLA==K_F2         ;DBMudaOrdem( 1, oTb ) 
      case TECLA==K_F3         ;DBMudaOrdem( 2, oTb ) 
      case TECLA==K_F4         ;DBMudaOrdem( 3, oTb ) 
      case TECLA==K_TAB .OR. TECLA==K_ENTER 
           If nPMOD=1 
              ScreenRest(cTELA) 
              If(lastrec()>0 .AND. Codigo<>0,&MODCHAMA,nil) 
           ElseIf nPMOD==2 
              If(lastrec()>0 .AND. Codigo<>0,exclui(oTB),nil) 
           EndIf 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oTB:refreshcurrent() 
   oTB:stabilize() 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return nil 
 
/* 
* Modulo      - PESQUISA 
* Parametros  - Elemento objeto 
* Finalidade  - Pesquisa pelo Codigo ou Descricao 
* Programador - Valmor Pereira Flores 
* Data        - 15/Junho/1993 
* Atualizacao - 03/Fevereiro/1994 
*/ 
/* 
func pesquisa(oPOBJ) 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(),; 
     nOPCAO:=0, nCOD:=0, cDESC:=space(45), GETLIST:={} 
ajuda("[ESC]Finaliza") 
Mensagem( "Selecione sua opcao conforme o menu acima.") 
If lastrec()=0 
   Mensagem( "Cadastro vazio, [ENTER] para continuar.") 
   pausa() 
   return NIL 
EndIf 
setcursor(1) 
set(_SET_SOFTSEEK,.t.) 
Mensagem( "") 
ajuda("["+_SETAS+"]Movimenta [ENTER]Executa") 
vpbox(12,45,16,69," Pesquisa ",COR[20],.T.,.F.,COR[19]) 
setcolor(COR[21]+","+COR[22]) 
aadd(MENULIST,menunew(13,46,smBUSCA[1][1],2,COR[19],smBUSCA[1][2],,,COR[6],.T.)) 
aadd(MENULIST,menunew(14,46,smBUSCA[2][1],2,COR[19],smBUSCA[2][2],,,COR[6],.T.)) 
aadd(MENULIST,menunew(15,46," 0 Encerramento       ",2,COR[19],; 
   "Executa a finalizacao da rotina de pesquisa.",,,COR[6],.T.)) 
menumodal(MENULIST,@nOPCAO); MENULIST:={} 
ajuda("["+_SETAS+"]Movimenta [ENTER]Confirma [ESC]Cancela") 
oPOBJ:gotop() 
do case 
   case nOPCAO=1 
        vpbox(11,25,13,48,"",COR[20],.T.,.F.,COR[19]) 
        @ 12,26 say "C�digo " get nCOD pict "999999" when Mensagem( "Digite o c�digo para pesquisa.") 
        read 
        Mensagem( "Executando a pesquisa pelo Codigo, aguarde...") 
        dbsetorder(1) 
        dbseek(nCOD) 
   case nOPCAO=2 
        vpbox(11,16,13,63,"",COR[20],.T.,.F.,COR[19]) 
        @ 12,17 say "Nome " get cDESC pict "@S35" when Mensagem( "Digite o nome para pesquisa.") 
        read 
        Mensagem( "Executando a pesquisa pela Descricao, aguarde...") 
        dbsetorder(2) 
        dbseek(upper(cDESC)) 
   otherwise 
endcase 
set(_SET_SOFTSEEK,.f.) 
dbsetorder(nORDEMG) 
setcursor(0) 
setcolor(cCOR) 
screenrest(cTELA) 
oPOBJ:refreshall() 
whil ! oPOBJ:stabilize() 
enddo 
return nil 
*/ 
 
 
/* 
* Modulo      - ORGANIZA 
* Parametros  - Elemento objeto 
*               Tipo p/ ordenacao do arquivo 
* Finalidade  - Organizacao pelo Codigo ou Descricao da empresa 
* Programador - Valmor Pereira Flores 
* Data        - 15/Junho/1993 
* Atualizacao - 03/Janeiro/1993 
*/ 
func organiza(oPOBJ,nPTIP) 
dbsetorder(nPTIP) 
oPOBJ:refreshall() 
whil ! oPOBJ:stabilize() 
enddo 
nORDEMG:=nPTIP 
return nil 
 
 
/* 
* Funcao      - PESQCEP 
* Finalidade  - VerIficar se a digitacao do campo CEP esta completa 
* Programador - Valmor Pereira Flores 
* Data        - 
*/ 
func pesqcep(cPCEP) 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor() 
If cPCEP=spac(8) .and. lastkey()<>K_UP 
   setcursor(0) 
   aviso("Cep ausente.",06) 
   pausa() 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
EndIf 
return(.t.) 
 
 
 
Func PesqCli(nCodigo) 
loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), oTB, TECLA, lFlag:=.F.,; 
     aPos:={ 05, 10, 20, 64 }, nArea:= Select(), nOrdem:= IndexOrd(),; 
     GetList:= {}, nOrd:= IndexOrd() 
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
nOrd:= IndexOrd() 
DBSetOrder( 1 ) 
IF nCodigo <> Nil 
   DBSeek(nCodigo) 
ENDIF 
If LastKey()<>K_UP 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "Clientes", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   Clear Typeahead 
   DBLeOrdem() 
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew("Codigo Nome",{|| STRZERO( Codigo, 6, 0) +" "+ Descri })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      TECLA:=inkey(0) 
      If TECLA=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case TECLA==K_UP         ;oTB:up() 
         case TECLA==K_LEFT       ;oTB:up() 
         case TECLA==K_RIGHT      ;oTB:down() 
         case TECLA==K_DOWN       ;oTB:down() 
         case TECLA==K_PGUP       ;oTB:pageup() 
         case TECLA==K_PGDN       ;oTB:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
         case TECLA==K_ENTER      ;nCodigo:= Codigo; Exit 
         case DBPesquisa( Tecla, oTb ) 
         case Tecla == K_F2 ;DBMudaOrdem( 1, oTb ) 
         case Tecla == K_F3 ;DBMudaOrdem( 2, oTb ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
EndIf 
DBSelectar( _COD_CLIENTE ) 
DBSetOrder( 1 ) 
IF nArea > 0 
   DBSelectAr( nArea ) 
   IF nOrdem > 0 
      DBSetOrder( nOrdem ) 
   ENDIF 
ENDIF 
Setcolor(cCOR) 
Setcursor(nCURSOR) 
Screenrest(cTELA) 
Return(.T.) 
 
 
 
Func PesqBco( nCodigo, lInformar ) 
Loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), oTB, TECLA, lFlag:=.F.,; 
     aPos:={ 05, 10, 19, 58 }, nArea:= Select(), nOrdem:= IndexOrd() 
 
IF lInformar==Nil 
   lInformar:= .F. 
ENDIF 
 
DBSelectAr( _COD_BANCO) 
If !Used() 
   lFlag:=.T. 
   If !file(_VPB_BANCO) 
      aviso(" Arquivo de bancos inexistente! ",24/2) 
      ajuda("[ENTER]Retorna") 
      Mensagem( "Pressione [ENTER] para retornar...",1) 
      pausa() 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
   If !fdbusevpb(_COD_BANCO) 
      aviso("ATENCAO! Verifique o arquivo "+_VPB_BANCO+".",24/2) 
      Mensagem( "Erro na abertura do arquivo de bancos, tente novamente...") 
      pausa() 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
EndIf 
DBSetOrder( 1 ) 
 
/*................ Tenta buscar o banco informado e caso n�o 
                   consiga exibe lista de bancos ...................*/ 
 
If !DBSeek( nCodigo ) .AND. LastKey()<>K_UP 
   IF lInformar 
      SWAlerta( "<< MOVIMENTO FINANCEIRO >>; O Sistema n�o pode encontrar o banco que; foi informado para esta movimentacao,; favor escolher novamente conforme tabela a seguir.", { " OK " } ) 
   ENDIF 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "Bancos", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   DBLeOrdem() 
   DBGoTop() 
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew("Cod�Nome",{|| STRZERO( Codigo, 3, 0) +"�"+ Descri })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      TECLA:=inkey(0) 
      If TECLA=K_ESC 
         nCodigo:= 0 
         exit 
      EndIf 
      do case 
         case TECLA==K_UP         ;oTB:up() 
         case TECLA==K_LEFT       ;oTB:up() 
         case TECLA==K_RIGHT      ;oTB:down() 
         case TECLA==K_DOWN       ;oTB:down() 
         case TECLA==K_PGUP       ;oTB:pageup() 
         case TECLA==K_PGDN       ;oTB:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
         case TECLA==K_ENTER      ;nCodigo:= Codigo; Exit 
         case DBPesquisa( TECLA, oTb ) 
         case TECLA==K_F2 
              DBMudaOrdem( 1, oTb ) 
         case TECLA==K_F3 
              DBMudaOrdem( 2, oTb ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
ENDIF 
If lFlag 
   BAN->( DBUnlock() ) 
   BAN->( DBCloseArea() ) 
EndIf 
DBSelectAr( nArea) 
DBSetOrder(nOrdem) 
Setcolor(cCOR) 
Setcursor(nCURSOR) 
Screenrest(cTELA) 
Return(.T.) 
 
 
Func PesqCtaCorrente(nCodigo) 
loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), oTB, TECLA, lFlag:=.F.,; 
     aPos:={ 05, 10, 19, 58 }, nArea:= Select(), nOrdem:= IndexOrd() 
DBSelectAr( _COD_CONTA) 
If !Used() 
   lFlag:=.T. 
   If !file(_VPB_CONTA) 
      aviso(" Arquivo de contas inexistente! ",24/2) 
      ajuda("[ENTER]Retorna") 
      Mensagem( "Pressione [ENTER] para retornar...",1) 
      pausa() 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
   If !fdbusevpb(_COD_CONTA) 
      aviso("ATENCAO! Verifique o arquivo "+_VPB_CONTA+".",24/2) 
      Mensagem( "Erro na abertura do arquivo de conta, tente novamente...") 
      pausa() 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
EndIf 
DBSetOrder( 1 ) 
If !DBSeek(nCodigo) .AND. LastKey()<>K_UP 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "CONTA CORRENTE", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   DBLeOrdem() 
   DBGoTop() 
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew("Cod Correntista",{|| STRZERO( Codigo, 3, 0) +" "+ Descri + Space( 20 ) })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      TECLA:=inkey(0) 
      If TECLA=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case TECLA==K_UP         ;oTB:up() 
         case TECLA==K_LEFT       ;oTB:up() 
         case TECLA==K_RIGHT      ;oTB:down() 
         case TECLA==K_DOWN       ;oTB:down() 
         case TECLA==K_PGUP       ;oTB:pageup() 
         case TECLA==K_PGDN       ;oTB:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
         case TECLA==K_ENTER      ;nCodigo:= Codigo; Exit 
         case DBPesquisa( TECLA, oTb ) 
         case TECLA==K_F2 
              DBMudaOrdem( 1, oTb ) 
         case TECLA==K_F3 
              DBMudaOrdem( 2, oTb ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
EndIf 
CON->( DBUnlock() ) 
DBSelectAr( nArea) 
DBSetOrder(nOrdem) 
Setcolor(cCOR) 
Setcursor(nCURSOR) 
Screenrest(cTELA) 
Return(.T.) 
 
Func PesqAgencia(nCodigo) 
loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),; 
     nCURSOR:=setcursor(), oTB, TECLA, lFlag:=.F.,; 
     aPos:={ 05, 10, 19, 58 }, nArea:= Select(), nOrdem:= IndexOrd() 
DBSelectAr( _COD_AGENCIA) 
If !Used() 
   lFlag:=.T. 
   If !file(_VPB_AGENCIA) 
      aviso(" Arquivo de Agencias inexistente! ",24/2) 
      ajuda("[ENTER]Retorna") 
      Mensagem( "Pressione [ENTER] para retornar...",1) 
      pausa() 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
   If !fdbusevpb(_COD_AGENCIA) 
      aviso("ATENCAO! Verifique o arquivo "+_VPB_AGENCIA+".",24/2) 
      Mensagem( "Erro na abertura do arquivo de agencia, tente novamente...") 
      pausa() 
      setcolor(cCOR) 
      setcursor(nCURSOR) 
      screenrest(cTELA) 
      return(.t.) 
   EndIf 
EndIf 
DBSetOrder( 1 ) 
If !DBSeek(nCodigo) .AND. LastKey()<>K_UP 
   VPBox( aPos[1], aPos[2], aPos[3], aPos[4], "AGENCIA", _COR_BROW_BOX ) 
   SetCursor(0) 
   SetColor( _COR_BROWSE ) 
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.") 
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna") 
   DBLeOrdem() 
   DBGoTop() 
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 ) 
   oTB:addcolumn(tbcolumnnew("Cod�Nome",{|| STRZERO( Codigo, 3, 0) +"�"+ Descri })) 
   oTB:AUTOLITE:=.f. 
   oTB:dehilite() 
   whil .t. 
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTB:stabilize() 
      enddo 
      TECLA:=inkey(0) 
      If TECLA=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case TECLA==K_UP         ;oTB:up() 
         case TECLA==K_LEFT       ;oTB:up() 
         case TECLA==K_RIGHT      ;oTB:down() 
         case TECLA==K_DOWN       ;oTB:down() 
         case TECLA==K_PGUP       ;oTB:pageup() 
         case TECLA==K_PGDN       ;oTB:pagedown() 
         case TECLA==K_CTRL_PGUP  ;oTB:gotop() 
         case TECLA==K_CTRL_PGDN  ;oTB:gobottom() 
         case TECLA==K_ENTER      ;nCodigo:= Codigo; Exit 
         case DBPesquisa( TECLA, oTb ) 
         case TECLA==K_F2 
              DBMudaOrdem( 1, oTb ) 
         case TECLA==K_F3 
              DBMudaOrdem( 2, oTb ) 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTB:refreshcurrent() 
      oTB:stabilize() 
   enddo 
EndIf 
If lFlag 
   AGE->( DBUnlock() ) 
   AGE->( DBCloseArea() ) 
EndIf 
DBSelectAr( nArea) 
DBSetOrder(nOrdem) 
Setcolor(cCOR) 
Setcursor(nCURSOR) 
Screenrest(cTELA) 
Return(.T.) 
 
/***** 
�������������Ŀ 
� Funcao      � EXCLUI 
� Finalidade  � Solicitar a confirmacao e excluir registros de um DBF. 
� Parametros  � oObj 
� Retorno     � Set foi excluido 
� Programador � Valmor Pereira Flores 
� Data        � 12/Novembro/1995 
� Atualizacao � 20/Janeiro/1996 
��������������� 
*/ 
Function Exclui(oObj) 
   LOCAL cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
         nCursor:= SetCursor(), lExcluido:= .F. 
   SetColor( "W/N" ) 
   Tone( 320, 2 ); Tone( 640, 3 ) 
   Ajuda("EXCLUSAO...") 
   IF Confirma(24,10,"Confirma a exclusao do lancamento?",; 
      "Digite [S] para excluir ou [N] para cancelar a exclusao do lancamento.","N") 
      If(netrlock(5),DBDelete(),nil) 
      lExcluido:= .T. 
   ENDIF 
   SetCursor( nCursor ) 
   SetColor( cCor ) 
   ScreenRest( cTela ) 
   oObj:RefreshAll() 
   WHILE !oObj:Stabilize() 
   ENDDO 
   Return lExcluido 
 
 
 
/* 
Funcao - PesqTranportadora 
 
         Valmor 
 
*/ 
Function PesqTransportadora( nCodigo ) 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL oTab, nTecla, nArea:= Select(), nOrdem:= IndexOrd() 
   LOCAL nRegistro, lFilter:= .F. 
 
   DBSelectAr( _COD_TRANSPORTE ) 
   DBSetOrder( 1 ) 
 
   IF nCodigo <> 999 
      DBSeek( nCodigo, .T. ) 
   ELSE 
      DBGOTOP() 
   ENDIF 
 
   SetCursor( 0 ) 
   SetColor( _COR_BROW_LETRA ) 
 
   VPBox( 1, 3, 4, 79 - 3 , "Selecao de Transportadoras" , _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   VPBox( 4, 3, 24 - 5, 79 - 3, , _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   VPBox( 24 - 5, 3, 24 - 3, 79 - 3, , M->Cor[21], .T., .T. ) 
   VPBox( 24 - 5, 58, 24 - 3, 79 - 3, , "11/09" ) 
 
   Mensagem("Pressione [ENTER] para selecionar ou [ESC] para cancelar...") 
   Ajuda("["+_SETAS+"][PgUp][PgDn][End][Home]Move [F3]Codigo [F4]Nome") 
 
   DBLeOrdem() 
   oTab:=TBrowseDb( 5, 4, 24 - 6, 79 - 4 ) 
   oTab:AddColumn( TbcolumnNew(, {|| StrZero( Codigo, 6, 0 ) + " => " + Descri + FONE__ } ) ) 
   oTab:AutoLite:=.f. 
   oTab:DeHiLite() 
   IF IndexOrd() == 1 
      @ 03,4 say "Ordem: Codigo de acesso interno.    " 
   ELSEIF IndexOrd() == 2 
      @ 03,4 say "Ordem: Descricao da Transportadora. " 
   ENDIF 
   WHILE .T. 
        oTab:ColorRect( { oTab:ROWPOS, 1, oTab:ROWPOS, 1 }, { 2, 1 } ) 
        While NextKey() == 0 .AND. !oTab:Stabilize() 
        ENDDo 
        nCodigo:= Codigo 
        cCorReserva:= SetColor() 
        nTecla:=inkey(0) 
        IF nTecla=K_ESC 
           exit 
        ENDIF 
        DO CASE 
           CASE nTecla ==K_UP         ;oTab:up() 
           CASE nTecla ==K_LEFT       ;oTab:up() 
           CASE nTecla ==K_RIGHT      ;oTab:down() 
           CASE nTecla ==K_DOWN       ;oTab:down() 
           CASE nTecla ==K_PGUP       ;oTab:pageup() 
           CASE nTecla ==K_PGDN       ;oTab:pagedown() 
           CASE nTecla ==K_HOME       ;oTab:gotop() 
           CASE nTecla ==K_END        ;oTab:gobottom() 
           CASE nTecla==K_F3 
                DBMudaOrdem( 1, oTab ) 
                @ 03,4 say "Ordem: Codigo de acesso interno.    " 
           CASE nTecla==K_F4 
                DBMudaOrdem( 2, oTab ) 
                @ 03,4 say "Ordem: Descricao da Transportadora. " 
           CASE DBPesquisa( nTecla, oTab ) 
           CASE nTecla==K_ENTER 
                exit 
           otherwise                ;tone(125); tone(300) 
        ENDCASE 
        oTab:refreshcurrent() 
        oTab:stabilize() 
   ENDDO 
   IF LastKey()==K_ESC 
      nCodigo:= 0 
   ENDIF 
   dbselectar(nAREA) 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
   return(.T.) 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � VisualProdutos() 
� Finalidade  � Apresentar uma lista de produtos para o usuario escolher. 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 14/Dezembro/1995 
� Atualizacao � 05/Marco/1998 
�             � 20/Agosto/1999       Visualizacao de Saldos p/ Cor & Tamanho 
��������������� 
*/ 
Function VisualProdutos() 
 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL oProd, nTecla, nArea:= Select(), nOrdem:= IndexOrd() 
   LOCAL nLinha 
   LOCAL nRegistro
   LOCAL nRefreshTimer
   STATIC lCompra 
 
   IF lCompra==Nil 
      lCompra:= .F. 
   ENDIF 
 
   DBSelectAr( _COD_MPRIMA ) 
   IF ! GrupoDeProdutos == "999" 
      Set Filter To left( indice, 03 ) == GrupoDeProdutos 
   ENDIF 
 
   nRegistro:= Recno() 
   DBGoTop() 
   SetCursor( 0 ) 
   SetColor( _COR_BROW_LETRA ) 
 
   /* Ajuste de tela */ 
   VPBox( 1, 0, 4, 79, " Selecao de Produtos" , _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   VPBox( 4, 0, 24 - 5, 79, , _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   VPBox( 24 - 5, 0, 24 - 3, 79, , M->Cor[21], .T., .T. ) 
   VPBox( 24 - 5, 58, 24 - 3, 79, , "11/09" ) 
 
   /* Display mensagem */ 
   Mensagem("Pressione [ENTER] para selecionar [CTRL ENTER]Detalhes...") 
   Ajuda("["+_SETAS+"][PgUp][PgDn][End][Home]Move [F3]Codigo [F4]C.Fab [F5]Nome [ALT+I]Informacoes") 
 
   /* Leitura de ordem */ 
   DBLeOrdem() 
   DBGoTop() 
 
   /* Montagem do Browse */ 
   oProd:=TBrowseDb( 5, 1, 24 - 6, 78 ) 
   oProd:AddColumn( TbcolumnNew(, {|| IF( AVISO_ > 0, StrZero( MPR->AVISO_, 2, 0 ), Space( 2 ) ) + IF( MPR->MPRIMA=="S", " ", "!" ) + Tran( AllTrim( Codigo ), "@R 999-9999" ) + " " + CodFab + " " + SubStr( Descri, 1, 40 ) + " " + unidad + " " + Tran( PrecoConvertido(), "@E 99999.99" ) + Space( 20 ) } ) ) 
   oProd:AutoLite:=.f. 
   oProd:DeHiLite() 
   IF IndexOrd() == 1 
      @ 03,4 say "Ordem: Codigo de acesso interno.     FABRICANTE: " + ORIGEM 
   ELSEIF IndexOrd() == 4 
      @ 03,4 say "Ordem: Codigo de fabrica do produto. FABRICANTE: " + ORIGEM 
   ELSEIF IndexOrd() == 2 
      @ 03,4 say "Ordem: Descricao do produto.         FABRICANTE: " + ORIGEM 
   ENDIF 
   KeyBoard Chr( K_RIGHT ) 
   PXF->( DBSetOrder( 1 ) ) 
   cTracob:=SaveScreen(20,00,20,79) 
   cTraco1:=SaveScreen(21,00,21,79) 
   cTraco2:=ScreenSave(22,00,22,79) 
 
   WHILE .T. 
        oProd:ColorRect( { oProd:ROWPOS, 1, oProd:ROWPOS, 1 }, { 2, 1 } ) 
        While NextKey() == 0 .AND. !oProd:Stabilize() 
        ENDDo 

        nRefreshTimer:= SECONDS()

        ProVisualRefresh( oProd, cTraco1, cTraco2, cTracoB, lCompra )
        WHILE (( nTecla:= INKEY()) == 0 )
            //OL_Yield()
            nRefreshTimer := IF( nRefreshTimer==Nil, SECONDS(), nRefreshTimer ) 
            IF (( nRefreshTimer + 2 ) < SECONDS() )    /* 2 = Tempo em segundos */ 
                DISPBEGIN() 
                anCursPos := { ROW(), COL() } 
                FreshOrder( oProd ) 
                SETPOS( anCursPos[1], anCursPos[2] ) 
                oProd:ColorRect({oProd:ROWPOS,1,oProd:ROWPOS,1},{2,1}) 
                DISPEND() 
                nRefreshTimer:= SECONDS()
                ProVisualRefresh( oProd, cTraco1, cTraco2, cTracoB, lCompra )
            ENDIF 
        ENDDO 

        IF nTecla=K_ESC 
           DBGoto( nRegistro ) 
           exit 
        ENDIF 
        DO CASE 
           CASE Acesso( nTecla ) 
           CASE nTecla ==K_UP         ;oProd:up() 
           CASE nTecla ==K_LEFT       ;oProd:up() 
           CASE nTecla ==K_RIGHT      ;oProd:down() 
           CASE nTecla ==K_DOWN       ;oProd:down() 
           CASE nTecla ==K_PGUP       ;oProd:pageup() 
           CASE nTecla ==K_PGDN       ;oProd:pagedown() 
           CASE nTecla ==K_HOME       ;oProd:gotop() 
           CASE nTecla ==K_END        ;oProd:gobottom() 
           CASE nTecla ==K_CTRL_INS 
                // Carrega janela de edicao de produtos 
                VPC21110() 
                oProd:RefreshAll() 
                WHILE !oProd:Stabilize() 
                ENDDO 
 
           CASE nTecla ==K_ALT_I 
                lCompra:= IF( lCompra, .F., .T. ) 
 
           CASE nTecla==K_F3 
                DBMudaOrdem( 1, oProd ) 
                @ 03,4 say "Ordem: Codigo de acesso interno.    " 
           CASE nTecla==K_F4 
                DBMudaOrdem( 4, oProd ) 
                @ 03,4 say "Ordem: Codigo de fabrica do produto." 
           CASE nTecla==K_F5 
                DBMudaOrdem( 2, oProd ) 
                @ 03,4 say "Ordem: Descricao do produto.        " 
           CASE DBPesquisa( nTecla, oProd ) 
 
           CASE nTecla==K_CTRL_ENTER 
                ProVisualDetalhe() 
 
           CASE nTecla==K_ENTER 
                exit 
           otherwise                ;tone(125); tone(300) 
        ENDCASE 
        oProd:refreshcurrent() 
        oProd:stabilize() 
   ENDDO 
   Set Filter To 
   dbselectar(nAREA) 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
   return(.T.) 
 

function ProVisualRefresh( oProd, cTraco1, cTraco2, cTracoB, lCompra )
Local nLinha, nCodPro

        nLinha:= ROW()
        IF MPR->AVISO_ > 0 
           @ nLinha,33 Say Left( MPR->DESCRI, 40 ) Color "15/" + StrZero( MPR->AVISO_, 2, 0 ) 
        ENDIF 
 
        nCodPro = val( CODRED ) 
        cCorReserva:= SetColor() 
        SetColor( "11/09" ) 
        IF PERCDC = 0 
           ScreenRest(cTraco2) 
           restscreen(21,00,21,79,ctraco1) 
           restscreen(22,00,22,79,ctraco2) 
           @ 24-4,59 say "Preco: " + Tran( PRECOV, "@E 99,999.999" ) 
        ELSE 
           restscreen(22,00,22,79,ctraco1) 
           restscreen(21,00,21,79,ctracob) 
           @ 20,59 say "Preco: " + Tran( PRECOV, "@E 99,999.999" ) 
           @ 21,59 say "C/Des: " + Tran( PRECOD, "@E 99,999.999" ) 
        ENDIF 
        SetColor( "14/04" ) 
        @ oProd:ROWPOS + 4, 62 say " " + ORIGEM + " " 
        SetColor( cCorReserva ) 
 
        @ 24-4,1 say spac(55) 
        IF ( ESTMIN + ESTMAX ) <> 0 
           IF SALDO_ < ESTMIN 
              @ 24-4,1 say "Abaixo do minimo (" + AllTrim( Tran( SALDO_, "@E 9,999,999.999" ) ) + ")" 
           ELSEIF SALDO_ > ESTMAX 
              @ 24-4,1 say "Acima do maximo  (" + AllTrim( Tran( SALDO_, "@E 9,999,999.999" ) ) + ")" 
           ELSE 
              @ 24-4,1 say "Saldo       (" + Alltrim( Tran( SALDO_, "@E 9,999,999.999" ) ) + ")" 
           ENDIF 
 
           IF SWSet( _PED_CONTROLERESERVA ) 
               @ 24-4,30 say    "(" + Alltrim( Tran( RESERV, "@E 9,999,999.999" ) ) + ")" COLOR "04/" + CorFundoAtual()    // GELSON 
           EndIf 
        ELSE 
           @ 24-4,1 say    "Saldo       (" + Alltrim( Tran( SALDO_, "@E 9,999,999.999" ) ) + ")" 
           IF SWSet( _PED_CONTROLERESERVA ) 
               @ 24-4,30 say    "(" + Alltrim( Tran( RESERV, "@E 9,999,999.999" ) ) + ")" COLOR "04/" + CorFundoAtual()    // GELSON 
           EndIf 
        ENDIF 
 
        // Preco c/ tabela diferenciada 
        IF PRE->CODIGO <> 0 
           @ 24-2,00 Say PAD( " PRECO  " + ALLTRIM( PRE->DESCRI ) + " = " + Tran( PrecoConvertido(), "@E 9,999.99" ) + " ", 50 ) Color "00/" + CorFundoAtual() 
        ELSE 
           @ 24-2,00 Say PAD( " PRECO  TABELA PADRAO", 50 ) 
        ENDIF 
 
        /* Preco de Compra */ 
        IF lCompra 
           @ 02,04 Say "<Informacoes Visiveis>" 
           PXF->( DBSeek( MPR->INDICE ) ) 
           IF PXF->( VALOR_ ) > 0 
              @ 20,32 Say " Preco de Compra: " + alltrim( Tran( PXF->VALOR_, "@e 999,999.99" ) ) + " " COLOR "15/05" 
           ELSE 
*              @ 20,32 Say Space( 24 ) 
           ENDIF 
        ELSE 
           @ 02,04 Say "                      " 
*           @ 20,32 Say Space( 24 ) 
        ENDIF 

Return Nil





Function ProVisualDetalhe()
Loca cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),; 
     nCursor:= SetCursor(), nArea:= Select(), nOrdem:= IndexOrd(),; 
     nTecla, oTb1, oTb2 
 
   VPBox( 05, 05, 20, 75, " DETALHAMENTO DE SALDOS ", _COR_GET_REALSE ) 
   CLA->( DBSetOrder( 1 ) ) 
   CLA->( DBSeek( MPR->PCPCLA ) ) 
   SetColor( _COR_BROWSE ) 
   @ 06,06 Say MPR->CODFAB 
   @ 07,06 Say MPR->DESCRI 
   @ 08,06 Say CLA->DESCRI 
   VPBox( 10, 06, 19, 38, " CORES ", _COR_GET_EDICAO, .F., .F.  ) 
   VPBox( 10, 39, 19, 74, " SALDOS POR TAMANHO ", _COR_GET_EDICAO, .F., .F.  ) 
   WHILE .T. 
      IF ( nTecla:= Inkey(0) )==K_ESC 
         EXIT 
      ENDIF 
      DO CASE 
 
 
      ENDCASE 
   ENDDO 
   SetColor(cCOR) 
   SetCursor(nCURSOR) 
   ScreenRest(cTELA) 
 
Return Nil 
 
 
/***** 
�������������Ŀ 
� Funcao      � VisualClientes() 
� Finalidade  � Apresentar uma lista de Clientes para o usuario escolher. 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 14/Dezembro/1995 
��������������� 
*/ 
Function VisualClientes() 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL oProd, nTecla, nArea:= Select(), nOrdem:= IndexOrd() 
   LOCAL nRegistro, lFilter:= .F. 
 
   DBSelectAr( _COD_CLIENTE ) 
   nRegistro:= Recno() 
   DBGoTop() 
   SetCursor( 0 ) 
   SetColor( _COR_BROW_LETRA ) 
 
   VPBox( 1, 3, 4, 79 - 3 , "Selecao de Clientes" , _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   VPBox( 4, 3, 24 - 5, 79 - 3, , _COR_BROW_BOX, .T., .T., _COR_BROW_TITULO ) 
   VPBox( 24 - 5, 3, 24 - 3, 79 - 3, , M->Cor[21], .T., .T. ) 
   VPBox( 24 - 5, 58, 24 - 3, 79 - 3, , "11/09" ) 
 
   Mensagem("Pressione [ENTER] para selecionar ou [ESC] para cancelar...") 
   Ajuda("["+_SETAS+"][PgUp][PgDn][End][Home]Move [F3]Codigo [F4]Nome") 
 
   DBLeOrdem() 
   DBGoTop() 
   oProd:=TBrowseDb( 5, 4, 24 - 6, 79 - 4 ) 
   oProd:AddColumn( TbcolumnNew(, {|| StrZero( Codigo, 6, 0 ) + " => " + Descri + FONE1_ + COMPRA } ) ) 
   oProd:AutoLite:=.f. 
   oProd:DeHiLite() 
   IF IndexOrd() == 1 
      @ 03,4 say "Ordem: Codigo de acesso interno.    " 
   ELSEIF IndexOrd() == 2 
      @ 03,4 say "Ordem: Descricao do cliente.        " 
   ENDIF 
   WHILE .T. 
        oProd:ColorRect( { oProd:ROWPOS, 1, oProd:ROWPOS, 1 }, { 2, 1 } ) 
        While NextKey() == 0 .AND. !oProd:Stabilize() 
        ENDDo 
        nCodCli:= Codigo 
        cCorReserva:= SetColor() 
        nTecla:=inkey(0) 
        IF nTecla=K_ESC 
           DBGoto( nRegistro ) 
           exit 
        ENDIF 
        DO CASE 
           CASE nTecla ==K_UP         ;oProd:up() 
           CASE nTecla ==K_LEFT       ;oProd:up() 
           CASE nTecla ==K_RIGHT      ;oProd:down() 
           CASE nTecla ==K_DOWN       ;oProd:down() 
           CASE nTecla ==K_PGUP       ;oProd:pageup() 
           CASE nTecla ==K_PGDN       ;oProd:pagedown() 
           CASE nTecla ==K_HOME       ;oProd:gotop() 
           CASE nTecla ==K_END        ;oProd:gobottom() 
           CASE nTecla==K_F3 
                DBMudaOrdem( 1, oProd ) 
                @ 03,4 say "Ordem: Codigo de acesso interno.    " 
           CASE nTecla==K_F4 
                DBMudaOrdem( 2, oProd ) 
                @ 03,4 say "Ordem: Descricao do Cliente.        " 
           CASE DBPesquisa( nTecla, oProd ) 
           CASE nTecla==K_ENTER 
                exit 
           otherwise                ;tone(125); tone(300) 
        ENDCASE 
        oProd:refreshcurrent() 
        oProd:stabilize() 
   ENDDO 
   IF lFilter 
      Set Filter To 
   ENDIF 
   dbselectar(nAREA) 
   setcolor(cCOR) 
   setcursor(nCURSOR) 
   screenrest(cTELA) 
   return(.T.) 
 
   /***** 
   �������������Ŀ 
   � Funcao      � BUSCAPERICM 
   � Finalidade  � Buscar percentuais de ICMs por estado 
   � Parametros  � cEstado / [C]onsumo[I]ndustria / Percentual de Icms 
   � Retorno     � Percentual de Icms 
   � Programador � Valmor Pereira Flores 
   � Data        � 12/novembro/1997 
   ��������������� 
   */ 
   Function BuscaPerIcm( cEstado, cPCR, nPerIcm ) 
   Local cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   Local nArea:= Select(), nOrdem:= IndexOrd() 
   DBSelectAr( 29 ) 
   If !Used() 
      AbreGrupo( "ESTADOS" ) 
   Endif 
   DBSelectAr( 29 ) 
   IF DBSeek( cEstado ) 
      IF cPCR == "C" 
         nPerIcm:= PERCON 
      ELSE 
         nPerIcm:= PERIND 
      ENDIF 
   ENDIF 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   IF ! nArea == 0  .AND. ! nOrdem == 0 
      DBSelectAr( nArea ) 
      DBSetOrder( nOrdem ) 
   ENDIF 
   Return nPerIcm 
 
// FUNCAO CRIADA PARA CALCULAR O ICMS SOBRE CADA PRODUTO - ALBERTO 
Function calculos2 
nVLRICM := 0 
for i = 1 to len(aprodutos) 
   nVLRICM += aProdutos[i,16] 
next 
retu .t. 
 
 
 
 
 
 
 
 
 
 
 
 
/* 
* Funcao      - DespesaSeleciona 
* Finalidade  - Selecao de vendadores a partir de outros modulos. 
* Programador - Valmor Pereira Flores 
* Data        - 11/Setembro/1998 
* Atualizacao - 11/Setembro/1998 
*/ 
Function DespesaSeleciona( FORCOD ) 
loca GETLIST:={} 
loca nAREA:=select(), nORDEM:=indexord() 
loca cTELA:=screensave(00,00,24,79), cCOR:=setcolor(), nCURSOR:=setcursor(), oFOR, TECLA 
loca mBUSCA, nCODIGO:=0, cDESCRI:=Spac(45) 
if FORCOD=0 
   return(.T.) 
endif 
dbselectar(_COD_DESPESAS) 
if dbseek(FORCOD) 
   cxFORNECED:=DESCRI 
   dbselectar(nAREA) 
   return(.T.) 
endif 
dbgotop() 
setcursor(0) 
setcolor( _COR_BROWSE ) 
vpbox(11,15,24-4,76,"DESPESAS DIVERSAS & FORNECEDORES", _COR_BROW_BOX ) 
mensagem("Para selecionar pressione [ENTER] com o cursor sobre o fornecedor.") 
ajuda("["+_SETAS+"][PgUp][PgDn]Move [Nome/Codigo]Pesquisa [F3]Cod. [F4]Nome [ESC]Retorna") 
oFOR:=tbrowsedb(12,16,24-5,75) 
oFOR:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" => "+DESCRI+"       "})) 
oFOR:AUTOLITE:=.f. 
oFOR:dehilite() 
whil .t. 
   oFOR:colorrect({oFOR:ROWPOS,1,oFOR:ROWPOS,1},{2,1}) 
   whil nextkey()=0 .and.! oFOR:stabilize() 
   enddo 
   TECLA:=inkey(0) 
   if TECLA=K_ESC 
      exit 
   endif 
   do case 
      case TECLA==K_UP         ;oFOR:up() 
      case TECLA==K_LEFT       ;oFOR:up() 
      case TECLA==K_RIGHT      ;oFOR:down() 
      case TECLA==K_DOWN       ;oFOR:down() 
      case TECLA==K_PGUP       ;oFOR:pageup() 
      case TECLA==K_PGDN       ;oFOR:pagedown() 
      case TECLA==K_END        ;oFOR:gotop() 
      case TECLA==K_HOME       ;oFOR:gobottom() 
      case upper(chr(TECLA))$"ABCDEFGHIJKLMNOPQRSTUWVXYZ" 
           Set(_SET_SOFTSEEK,.T.) 
           cDESCRI:=Spac(45) 
           cTELA0:=ScreenSave(20,01,24,64) 
           vpbox(20,01,22,62,"Pesquisa") 
           keyboard chr(TECLA) 
           @ 21,02 say " Nome - " get cDESCRI pict "@!" when; 
             Mensagem("Digite o nome do fornecedor para pesquisa.") 
           read 
           oFOR:gotop() 
           dbsetorder(2) 
           dbseek(cDESCRI) 
           screenrest(cTELA0) 
           oFOR:refreshall() 
           whil !oFOR:stabilize() 
           enddo 
           Set(_SET_SOFTSEEK,.F.) 
      case chr(TECLA)$"1234567890" 
           Set(_SET_SOFTSEEK,.T.) 
           nCODIGO:=0 
           cTELA0:=screensave(20,01,24,20) 
           vpbox(20,01,22,18,"Pesquisa") 
           keyboard chr(TECLA) 
           @ 21,02 say " Cod: " get nCODIGO pict "9999" when; 
             mensagem("Digite o codigo do fornecedor para pesquisa.") 
           read 
           oFOR:gotop() 
           dbsetorder(1) 
           dbseek(nCODIGO) 
           screenrest(cTELA0) 
           oFOR:refreshall() 
           whil !oFOR:stabilize() 
           enddo 
           Set(_SET_SOFTSEEK,.F.) 
      case TECLA==K_F3         ;organiza(oFOR,1) 
      case TECLA==K_F4         ;organiza(oFOR,2) 
      case TECLA==K_ENTER 
           FORCOD:=CODIGO 
           cxFORNECED:=DESCRI 
           exit 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oFOR:refreshcurrent() 
   oFOR:stabilize() 
enddo 
dbselectar(nAREA) 
dbsetorder(nORDEM) 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(if(TECLA==K_ENTER,.T.,.F.)) 
 
 
/*** 
* 
*   FreshOrder() 
* 
*   Refresh respecting any change in index order 
*/ 
 
Static Func FreshOrder(oB) 
 
local nRec 
 
   nRec := Recno() 
   oB:refreshAll() 
 
   /* stabilize to see if TBrowse moves the record pointer */ 
   oB:forceStable() 
 
   if ( nRec != LastRec() + 1 ) 
      /* record pointer may move if bof is on screen */ 
      while ( Recno() != nRec .and. !ob:hitTop ) 
         /* falls through unless record is closer to bof than before */ 
         oB:up():forceStable() 
      end 
   end 
 
return (NIL) 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
