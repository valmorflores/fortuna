// ## CL2HB.EXE - Converted
#Define QUANT_FILE    26 
#include "VPF.CH" 
#include "INKEY.CH" 
 
/* 
 Programa    - VPC15000.prg 
 Finalidade  - Reindexar os dados do sistema 
 Programador - Valmor Pereira Flores 
 Data        - 12/Novembro/1993 
 Atualizacao - 05/Abril/2003 
*/ 
#ifdef HARBOUR
function vpc15000()
#endif


Local cDirDados:= GDir, nRegistro, cEmpresa
Local nTipoReindexacao:= 1 
 
loca cTELA:=screensave(00,00,nMAXLIN,nMAXCOL),; 
     cCOR:=setcolor(), nCURSOR:=setcursor(), ARQ 
Private nTotalFile:= Len( Directory( GDIR + "\*.NTX" ) ), nCont:= 0 
 
DispBegin() 
setcolor( _COR_GET_BOX ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
userscreen() 
vpobsbox(.T.,01,23," ATENCAO ",; 
               {"                                                ",; 
                " Esta  e uma operacao que podera ser demorada e ",; 
                " necessaria caso tenha ocorrido falta de  ener- ",; 
                " gia durante a operacao, portanto, sera preciso ",; 
                " que as tarefas sejam suspensas nos demais ter- ",; 
                " minais caso o usuario trabalhe em rede.        ",; 
                "                                                " }) 
vpobsbox(.T.,10,23," Sobre: Reindexacao ",; 
               {"                                                ",; 
                " Este modulo efetua a criacao de novos arquivos ",; 
                " de indices,boqueando temporariamente os demais ",; 
                " arquivos do sistema.                           ",; 
                " Caso haja uma falha em qualquer modulo do sis- ",; 
                " tema, como, aparecimento de codigos  repitidos ",; 
                " e anormalidades vocˆ dever  execut -lo.        ",; 
                "                                                ",; 
                "                                                "}) 
 
DispEnd() 
@ 19,25 Prompt "  Empresa Atual  " 
@ 19,43 Prompt " Todas as Empresas " 
@ 19,63 Prompt "  Sair  " 
menu to nTipoReindexacao 
 
mensagem("Pressione [ENTER] para iniciar ou [ESC] para cancelar.",1) 
if LastKey()==K_ESC .OR. nTipoReindexacao == 3 
   screenrest(cTELA) 
   setcursor(nCURSOR) 
   setcolor(cCOR) 
   return nil 
endif 
mensagem("Excluindo os arquivos de indices invalidos, aguarde...",1) 
dbunlockall() 
DBCloseAll() 
 
/* Abre empresa na area tempor ria 124 */ 
DBSelectAr( 124 ) 
cDirEmp:= SWSet( _SYS_DIRREPORT ) + "\EMPRESAS.DBF" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Use &cDirEmp Alias EMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Index On CODIGO To INDICE0_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Index On DESCRI To INDICE1_.NTX 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Set Index To INDICE0_.NTX, INDICE1_.NTX 
DBGoTop() 
nRegistro:= EMP->( RECNO() ) 
WHILE !EMP->( EOF() ) 
    IF nTipoReindexacao == 1 
       cEmpresa:= _EMP 
       IF AT( "\0", AllTrim( GDir ) ) > 0 
          nEmpresa:= VAL( SubStr( Alltrim( GDir ), AT( "\0", Alltrim( GDir ) ) + 1, 4 ) ) 
       ELSE 
          nEmpresa:= 0 
       ENDIF 
    ELSE 
       cEmpresa:= EMP->DESCRI 
       // Posiciona no diretorio da empresa 
       nEmpresa:= EMP->CODIGO 
       IF AT( "\0", Alltrim( GDir ) ) - 1 > 0 
          GDir:= Left( GDir, AT( "\0", Alltrim( GDir ) ) - 1 ) + "\0" + StrZero( nEmpresa, 3 ) 
       ELSE 
          GDir:= Alltrim( GDir ) + "\0" + StrZero( nEmpresa, 3 ) 
       ENDIF 
       // Se a empresa ‚ 0 nÆo deve ter \0000 no diretorio 
       IF nEmpresa==0 
          IF AT( "\0000", GDir ) > 0 
             GDir:= StrTran( GDir, "\0000", "" ) 
          ENDIF 
       ENDIF 
    ENDIF 
    // Deleta os arquivos de indice 
    aeval( directory( GDIR+"\*.NTX" ), {|ARQ| FileDel( GDIR+"\"+ARQ[1] ) } ) 
    IF Len( Directory( GDIR+"\*.NTX" ) ) > 0 
       Aviso( "Existem arquivos do sistema abertos. Impossivel reindexar." ) 
       Mensagem( "Pressione [ENTER] para continuar..." ) 
       Pausa() 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
       Return Nil 
    ENDIF 
 
    // Monta display 
    VPBox( 01, 23, 07, 75,, _COR_GET_BOX ) 
    VPBox( 08, 23, 15, 75,, _COR_GET_BOX ) 
    VPBox( 16, 23, 22, 75,, _COR_GET_BOX ) 
    IndexTerm( 0 ) 
    @ 09,25 Say "Diretorio  -" 
    @ 10,25 say "Posicao    -" 
    @ 11,25 say "Indice     -" 
    @ 12,25 say "Arquivo    -" 
    @ 13,25 say "Grupo      -" 
    @ 14,25 say "Empresa    -" 
    setcolor( _COR_GET_EDICAO ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    UseDBFGrupo() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
    INDEX ON AREA To IND002 
 
    FOR nFiles:= 1 TO 255 
        IF nFiles <> 70 
           DBSelectAr( nFiles ) 
           IF Used() 
              DBCloseArea() 
           ENDIF 
           GRP->( DBSeek( nFiles ) ) 
           cArquivo:= AllTrim( GRP->ARQUIVO ) 
           cModulo:=  AllTrim( GRP->GRUPO   ) 
           // Filtra arquivos de empresas que sÆo genericos 
           // para que nÆo execute reindex duas vezes nos arquivos. 
           IF ( nEmpresa == 0 ) .OR.; 
              ( GRP->GENERICO == "N" .AND. nEmpresa <> 0 ) 
              IF nFiles <> 21  .AND. nFiles <> 22 .AND.; 
                 nFiles <> 132 .AND. nFiles <> 101 .AND.; 
                 nFiles <> 124 
                 VPReindex( nFiles, PAD( "" + StrZero( nFiles, 03, 0 ) + "-" + cArquivo + "", 35 ), PAD( "" + cModulo + "", 35 ), cEmpresa ) 
              ENDIF 
              DBCloseArea() 
           ENDIF 
        ENDIF 
    NEXT 
    IF nTipoReindexacao==2 
       // Reposiciona o arquivo das empresas 
       DBSelectAr( 124 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       Use &cDirEmp Alias EMP 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
       Set Index To INDICE0_.NTX, INDICE1_.NTX 
       DBGoTo( nRegistro ) 
       EMP->( DBSkip() ) 
       nRegistro:= EMP->( RECNO() ) 
    ELSE 
       EXIT 
    ENDIF 
ENDDO 
// Restaura diretorio de dados 24/04/2003 
GDir:= cDirDados 
DBCloseAll() 
AbreGrupo( "TODOS_OS_ARQUIVOS" ) 
FechaArquivos() 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return NIL 
 
/* 
Funcao      - VPREINDEX 
Finalidade  - Reorganizar os dados 
Parametros  - COD=Codigo do arquivo 
              ARQUIVO=Nome do arquivo de indice a ser exibido 
              MENS=Mensagem a ser exibida no momento da reindexacao 
Retorno     - Nenhum 
Programador - Valmor Pereira Flores 
Data        - 12/Junho/1994 
Atualizacao - 25/Junho/1994 
*/ 
func vpreindex(COD,ARQUIVO,MENS,EMPRESA) 
Local GDirRes 
LOCAL cArquivo:= IF( LEN( Arquivo ) > 43, "..." + Right( ARQUIVO, 30 ), ARQUIVO ) 
//if file(ARQUIVO) 
   SetColor( _COR_GET_EDICAO ) 
   Scroll( 02, 24, 06, 74, 1 ) 
   @ 06,24 Say cArquivo 
   SetColor( _COR_GET_BOX ) 
   @ 12,39 say cArquivo 
   @ 13,39 say spac(30) 
   @ 13,39 say MENS 
 
  /// VALMOR: Posiciona-se no diretorio do arquivo atual 
   DBSelectAr( COD ) 
   // VALMOR: Guarda o GDir numa variavel interna para restaurar em seguida 
   GDirRes:= GDir 
   // VALMOR: Esta linha For‡a o posicionamento no diretorio do arquivo atual 
   SetDiretorioPadrao( COD ) 
  //// VALMOR: Fim do reposicionamento, embora continue reposicionado 
 
   ////AVISO( STRZERO( COD, 3, 0 ) + " " + GDIR ) 
   ///PAUSA() 
   @ 09,39 Say PAD( GDir, 33 ) Color "15/" + CorFundoAtual() 
   @ 14,39 Say PAD( Empresa, 33 ) Color "14/" + CorFundoAtual() 
   DBCloseArea() 
   If fdbusevpb( COD, 1, 1 ) 
      Mensagem( "Salvando informacoes importantes, aguarde..." ) 
      Pack 
      dbunlockall() 
      FechaArquivos() 
   endif 
 
   // Reposiciona o GDir Na marra, pois na biblioteca VPBIBAUX ‚ usado SET INDEX 
   // o que faz com que seja incocada a funcao SetDirPadrao que salva novamente o 
   // Gdir na sua variavel interna. Esta funcao abaixo elimina este salvamento 
   // para que o reposicionamento seja restaurado corretamente. 
   // NAO REMOVA AS DUAS LINHAS A SEGUIR. 
   // ELAS SÇO FUNDAMENTAIS PARA O BOM FUNCIONAMENTO DA REINDEXACAO 
   // Por VALMOR em 23/04/2003 
   GDir:= GDirRes 
   SetDiretorioPadrao( 0 ) 
 
   // Restaura a posicao original p/ GDir 
   RestDiretorioPadrao() 
 
//endif 
return nil 
 
 
******************************************************************************* 
func TERMOM() 
loca cCOR:=setcolor() 
loca nVLR:=recno()/reccount()*100 
setcolor( _COR_GET_EDICAO ) 
Roller( 11, 48 ) 
@ 11,39 say alltrim(str(nVLR))+" % " 
if nVLR<=1/reccount()*100 
   @ 10,39 say space(35) 
endif 
nVlr:= INT( nVlr / 3 ) 
@ 10,39 say "Û" + Repl( "°", nVlr ) Color "15/" + CorFundoAtual() 
@ ROW(), COL() Say Repl( "Û", 35 - nVlr ) Color "14/" + CorFundoAtual() 
setcolor(cCOR) 
return(.t.) 
 
 
*************************************** 
Function FileDel( cArquivo ) 
mensagem( "Aguarde, excluindo arquivo "+cArquivo+"..." ) 
ferase( cArquivo ) 
Return(.t.) 
