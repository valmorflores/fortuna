// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
FUNCTION PEstatistica() 
LOCAL cTELA:=zoom(13,24,19,52), cCOR:=setcolor(), nOPCAO:=0 
VPBOX( 13, 24, 19, 52 ) 
WHILE .T. 
   Mensagem("") 
   aadd(MENULIST,menunew(14,25," 1 Total Notas Fiscais    ",2,COR[11],; 
        "Total de Notas Fiscais.",,,COR[6],.T.)) 
 
   aadd(MENULIST,menunew(15,25," 2 Clientes (Individual)  ",2,COR[11],; 
        "Estat�sticas de clientes.",,,COR[6],.T.)) 
 
   aadd(MENULIST,MenuNew(16,25," 3 Clientes (Multiplos)   ",2,COR[11],; 
        "Estat�sticas de clientes <Multiplos>.",,,COR[6],.T.)) 

   aadd(MENULIST,MenuNew(17,25," 4 Atualizar Estatisticas ",2,COR[11],; 
        "Atualizar as estat�sticas dos clientes.",,,COR[6],.T.)) 

   aadd(MENULIST,menunew(18,25," 0 Retorna                ",2,COR[11],;
        "Retorna ao menu anterior.",,,COR[6],.T.)) 
   menumodal(MENULIST,@nOPCAO); MENULIST:={} 
   do case 
      case nOPCAO=0 .or. nOPCAO=5; exit 
      case nOPCAO=1; PEstat1() 
      case nOPCAO=2; PEstat2() 
      case nOPCAO=3; PEstat3()
      case nOpcao=4; PEstat4()
   endcase 
enddo 
unzoom(cTELA) 
setcolor(cCOR) 
return(nil) 
 
 
Function PEstat1 
LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
LOCAL dDataIni:= Date(), dDataFim:= Date() 
LOCAL lFlag:= .F. 
LOCAL nNulas:= 0, nTotalNf:= 0, nVlrNota:= 0, nVlrIcm:= 0, nVlrIPI:= 0 
LOCAL nProcessadas:= 0 
 
    VPBox( 04, 20, 07, 71, "Per�odo", _COR_GET_BOX ) 
    SetColor( _COR_GET_EDICAO ) 
    @ 05,21 Say "Inicial...:" Get dDataIni 
    @ 06,21 Say "Final.....:" Get dDataFim 
    Read 
 
    IF LastKey()==K_ESC 
       ScreenRest( cTela ) 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       Return Nil 
    ENDIF 
 
    IF !AbreGrupo( "NOTA_FISCAL" ) 
       SetColor( cCor ) 
       SetCursor( nCursor ) 
       ScreenRest( cTela ) 
       Return Nil 
    ENDIF 
 
    DBSelectAr( _COD_NFISCAL ) 
    DBGoTop() 
    WHILE ! EOF() 
       IF DATAEM >= dDataIni .AND. DATAEM <= dDataFim 
          IF NFNULA == Space( 1 ) 
             nTotalNf+= VLRNOT 
             nVlrNota+= VLRTOT 
             nVlrIcm+=  VLRICM 
             nVlrIPI+=  VLRIPI 
          ELSE 
             ++nNulas 
          ENDIF 
          ++nProcessadas 
       ENDIF 
       DBSkip() 
    ENDDO 
    VPBox( 08, 20, 20, 71, "Totais em notas de Venda e Outras Saidas", _COR_GET_BOX ) 
    @ 09,21 Say "Valor Nota          � " + Tran( nTotalNf, "@E 999,999,999.99" ) 
    @ 10,21 Say "��������������������������������������������������" 
    @ 11,21 Say "Valor Total         � " + Tran( nVlrNota, "@E 999,999,999.99" ) 
    @ 12,21 Say "��������������������������������������������������" 
    @ 13,21 Say "Valor Icm           � " + Tran( nVlrIcm, "@E 999,999,999.99" ) 
    @ 14,21 Say "��������������������������������������������������" 
    @ 15,21 Say "Valor IPI           � " + Tran( nVlrIpi, "@E 999,999,999.99" ) 
    @ 16,21 Say "��������������������������������������������������" 
    @ 17,21 Say "Notas Fiscais Nulas � " + StrZero( nNulas, 4 ) 
    @ 18,21 Say "��������������������������������������������������" 
    @ 19,21 Say "Processadas         � " + StrZero( nProcessadas, 4 ) 
    Mensagem( "Pressione ENTER para retornar..." ) 
    Ajuda( "[ENTER]Retorna" ) 
    Pausa() 
    FechaArquivos() 
    SetColor( cCor ) 
    SetCursor( nCursor ) 
    ScreenRest( cTela ) 
    Return Nil 
 
 
 
/* 
**      Funcao - 
**  Finalidade - Consultar os dados estatisticos de clientes 
** Programador - Valmor Pereira Flores 
**  Parametros - Nenhum 
**     Retorno - Nenhum 
**        Data - 03/Maio/1995 
** Atualizacao - 10/Junho/1995 
*/ 
Function PESTAT2 
Loca cTELA:=SCREENSAVE(00,00,24,79), nCURSOR:=SetCursor(), cCOR:=SetColor() 
Loca oPROD, oCLIE, nTECLA, nTELA:=1 
Loca nCODCLI, nCODPRO, cTELA0, aBOX[2], cDESCLI, cDESPRO 
Loca lFLAG:=.F., lALTERAPOS:=.T. 
Loca GETLIST:= {} 
Loca nReg 
IF !AbreGrupo( "NOTA_FISCAL" ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil 
ENDIF 
DBSelectar( _COD_CLIENTE ) 
DBGoTop() 
IF CLI->DATA__ <> Date() 
   IF !AtualizaClientes() 
      FechaArquivos() 
      Return Nil 
   ENDIF 
ENDIF 
SetCursor(0) 
DispBegin() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
USERSCREEN() 
VPBOX(02,10,12,45,"Clientes", _COR_BROW_BOX ,.T.,.F., _COR_BROW_TITULO ) 
VPBOX(02,46,12,75,"Dados p/ estatistica", _COR_BROW_BOX ,.T.,.F., _COR_BROW_TITULO ) 
VPBOX(13,10,21,75,"Display-Clientes", _COR_BROW_BOX ,.T.,.F., _COR_BROW_TITULO ) 
SetColor( _COR_BROWSE ) 
** Dados dos clientes ** 
DevPos(03,11);DevOut("Codigo..:") 
DevPos(04,11);DevOut("Nome....:") 
DevPos(05,11);DevOut("Endereco:") 
DevPos(06,11);DevOut("Bairro..:") 
DevPos(07,11);DevOut("Cidade..:") 
DevPos(08,11);DevOut("Fone....:") 
DevPos(09,11);DevOut("Contato.:") 
DevPos(10,11);DevOut("Transpor:") 
DevPos(11,11);DevOut("Data....:") 
DispEnd() 
 
AJUDA("["+_SETAS+"][PgDn][PgUp]Move "+; 
      "[ENTER]Seleciona [A..Z]Pesquisa [F10]Atualiza") 
MENSAGEM("Selecione o produto ou cliente desejado ou pressione [ESC] para sair...") 
 
DbSelectAr(_COD_CLIENTE) 
DBLeOrdem() 
DbGoTop() 
//DbSelectAr(_COD_MPRIMA) 
oCLIE:=TBrowseDb(14,11,20,74) 
oCLIE:AddColumn(TbColumnNew(,{|| StrZero(CLI->CODIGO,4,0)+" "+; 
                                 CLI->DESCRI+" "+; 
                            TRAN(CLI->CGCMF_, "@R 99.999.999/9999-99") })) 
oCLIE:AUTOLITE:=.F.; oCLIE:dehilite() 
oCLIE:GoTop() 
While .T. 
   oCLIE:ColorRect({oCLIE:ROWPOS,1,oCLIE:ROWPOS,1},{2,1}) 
   Whil NextKey()=0 .and.! oCLIE:Stabilize() 
   enddo 
   DispBegin() 
   DevPos(03,21);DevOut(CLI->CODIGO) 
   DevPos(04,21);DevOut(SubStr(CLI->DESCRI,1,24)) 
   DevPos(05,21);DevOut(SubStr(CLI->ENDERE,1,24)) 
   DevPos(06,21);DevOut(SubStr(CLI->BAIRRO,1,24)) 
   DevPos(07,21);DevOut(SubStr(CLI->CIDADE,1,24)) 
   DevPos(08,21);DevOut(CLI->FONE1_) 
   DevPos(09,21);DevOut(SubStr(CLI->COMPRA,1,24)) 
   DevPos(10,21);DevOut(StrZero(CLI->TRANSP,3,0)) 
   DevPos(11,21);DevOut(CLI->DATACD) 
   //Estatistica() 
   DispEnd() 
   nTECLA:=inkey(0) 
   If nTECLA=K_ESC; exit; endif 
   do case 
      case nTECLA==K_UP         ;oCLIE:up() 
      case nTECLA==K_DOWN       ;oCLIE:down() 
      case nTECLA==K_PGUP       ;oCLIE:pageup() 
      case nTECLA==K_PGDN       ;oCLIE:pagedown() 
      case nTECLA==K_HOME       ;oCLIE:gotop() 
      case nTECLA==K_END        ;oCLIE:gobottom() 
      case nTecla==K_F5 
      case DBPesquisa( nTecla, oClie ) 
      case nTecla==K_F2 
           DBMudaOrdem( 1, oClie ) 
      case nTecla==K_F3 
           DBMudaOrdem( 2, oClie ) 
      case nTecla==K_F4 
           DBMudaOrdem( 3, oClie ) 
      case nTecla==K_F5 
           DBMudaOrdem( 4, oClie ) 
      case nTecla==K_F10 
           AtualizaClientes() 
      case nTECLA==K_ENTER 
           nReg:= RECNO() 
           Estatistica() 
           DBGoTo( nReg ) 
           oClie:RefreshAll() 
           WHILE !oClie:Stabilize() 
           ENDDO 
 
      otherwise                ;tone(125); tone(300) 
   endcase 
   oCLIE:refreshcurrent() 
   oCLIE:stabilize() 
enddo 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(.T.) 
 
 
/* 
** 
** 
** 
**         ESTA FUNCAO � CHAMADA PELA PESTATISTICA() 
** 
** 
** 
*/ 
Function ESTATISTICA 
Loca cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Loca nAREA:=Select(), nORDEM:=IndexOrd() 
Loca dULTIMA, nMAIORV:=0, nULTVLR, nULTNF_, nQUANT_:=0 
Loca dDATAMV:=ctod("  /  /  "),; 
     nQUANTNF:=0, nQUANTITEM:=0, nPosicao:=0, nFim:= 0 
DBSelectAr(_COD_NFISCAL) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
set index to 
nFim:= LastRec() 
DbSelectAr(_COD_PRODNF) 
nFim:= nFim + LastRec() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
set index to 
DbGoTop() 
Mensagem( "Pesquisando dados na tabela de produtos por nota fiscal..." ) 
 
Whil ! eof() 
 
    /* Testa se foi pressionada a tecla ESC */ 
    If Inkey()==27 .OR. LastKey()==27 
       ScreenRest( cTela ) 
       FechaArquivos() 
       Return Nil 
    Endif 
 
    SetColor( "11/" + CorFundoAtual() ) 
 
    /* Se o cliente for o selecionado */ 
    IF Client=CLI->Codigo 
       SetColor( "R+/" + CorFundoAtual() ) 
       nQuant_+=Quant_ 
       ++nQuantItem 
    Endif 
 
    /* Apresenta informacoes do produto comprado pelo cliente */ 
    Scroll( 3, 47, 11, 74, 1 ) 
    @ 11, 47 Say alltrim( CodRed ) + " " + CodFis + " " + Tran( PrecoT, "@E ******.**" ) 
    @ 12, 47 Say "Itens: " + StrZero( nQuantItem, 5, 0 ) 
    DbSkip() 
    VPTerm( ++nPosicao, nFim ) 
 
EndDo 
 
Mensagem( "Pesquisando ultima Venda p/ Cliente, aguarde...." ) 
DBSelectar( _COD_NFISCAL ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Set Index To 
DbGoBottom() 
dUltima:= CToD( "  /  /  " ) 
nUltNf_:= 0 
nUltVlr:= 0 
While .T. 
   @ 12, 47 Say "Data: " + DToC( DATAEM ) 
   If Client == Cli->Codigo 
      dUltima:= Dataem 
      nUltNf_:= Numero 
      nUltVlr:= VlrTot 
      Exit 
   EndIf 
   If Bof(); Exit; EndIf 
   DbSkip(-1) 
EndDo 
DbSelectar(_COD_NFISCAL) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Set index to 
 
DbGoTop() 
Mensagem( "Pesquisando maior Venda p/ Cliente..." ) 
 
Whil ! Eof() 
 
    If Inkey()==27 .OR. LastKey()==27 
       ScreenRest( cTela ) 
       DBSelectAr( nArea ) 
       DBSetOrder( nOrdem ) 
       Return Nil 
    Endif 
 
    /* Exibe dados dos clientes */ 
    Scroll( 3, 47, 11, 74, 1 ) 
    cCor1:= "13/" + CorFundoAtual() 
    cCor2:= "15/" + CorFundoAtual() 
    @ 11, 47 Say StrZero( CLIENT, 4, 0 ) + " " + SUBSTR( CDESCR, 1, 23 ) Color If( Client = Cli->Codigo, cCor1, cCor2 ) 
 
    If CLIENT=CLI->CODIGO 
 
       /* Verifica se esta � a maior nota */ 
       If VlrNot > nMaiorV 
          SetColor( "R+/" + CorFundoAtual() ) 
          nMaiorV:= VlrTot 
          dDataMv:= DataEm 
       Endif 
 
       /* Soma na quantidade total de notas */ 
       ++nQuantNf 
 
    endif 
 
    /* Exibe a quantidade de notas fiscais */ 
    @ 12, 62 Say "Notas: " + StrZero( nQuantNf, 5, 0 ) 
    DbSkip() 
    VPTerm( ++nPosicao, nFim ) 
EndDo 
 
VPTerm( .F. ) 
DispBegin() 
VPBox( 05, 13, 20, 75, "Dados estat�sticos do cliente", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
SetColor( _COR_GET_EDICAO ) 
@ 06, 14 Say "Qtd.Dupl.Pendentes (-45 dias): "+StrZero(CLI->PEND__ , 5, 0 ) 
@ 07, 14 Say "Qtd.Dupl.Pendentes (+45 dias): "+StrZero(CLI->INAD__,5,0) 
@ 08, 14 Say "Qtd.Dupl.Quitadas no vencto..: "+StrZero(CLI->QUIT__,5,0) 
@ 09, 14 Say "Qtd.Dupl.Pagas com atraso....: "+StrZero(CLI->ATRA__,5,0) 
@ 10, 14 Say Repl( "�", 61 ) 
@ 11, 14 Say "Data da Ultima Compra........: "+dtoc(dULTIMA) 
@ 12, 14 Say "Numero da Nota Fiscal........: "+StrZero(nULTNF_,6,0) 
@ 13, 14 Say "Valor da Ultima compra.......: "+Tran(nULTVLR,"@E ***,***,***.**") 
@ 14, 14 Say "Data da maior compra.........: "+dTOc(dDATAMV) 
@ 15, 14 Say "Valor da maior compra........: "+Tran(nMAIORV,"@E ***,***,***.**") 
@ 16, 14 Say Repl( "�", 61 ) 
@ 17, 14 Say "Situacao atual...............: " 
DO CASE 
   CASE ( CLI->INAD__ + CLI->PEND__ + CLI->ATRA__ ) > CLI->QUIT__ 
        Devout( "P�ssima        " ) 
   CASE ( CLI->INAD__ ) > CLI->QUIT__ 
        Devout( "Ruim           " ) 
   CASE ( CLI->PEND__ ) > 0 
        Devout( "Devedora       " ) 
   CASE ( CLI->INAD__ + CLI->PEND__ + CLI->ATRA__ ) = 0 .AND. CLI->QUIT__ > 0 
        Devout( "Perfeita - Cliente Ideal " ) 
   CASE ( CLI->QUIT__ ) > ( 20 * CLI->INAD__ ) 
        Devout( "Otima          " ) 
   CASE ( CLI->QUIT__ ) > ( 5 * CLI->INAD__ ) .OR.; 
        ( CLI->PEND__ + CLI->ATRA__ ) > ( CLI->QUIT__ / 3 ) 
        Devout( "Razo�vel       " ) 
   OTHERWISE 
        Devout( "Analisar" ) 
ENDCASE 
@ 18, 14 Say "Limite de Credito............: " + Tran( CLI->LIMCR_, "@E 999,999,999.99" ) + " Val:" + DTOC( CLI->VALID_ ) 
@ 19, 14 Say "Saldo de Credito.............: " + Tran( CLI->SALDO_, "@E 999,999,999.99" ) 
DispEnd() 
Mensagem( "Pressione [ENTER] para continuar..." ) 
Pausa() 
VPBox( 08, 16, 16, 65, " OBSERVACOES ", _COR_GET_BOX, .T., .T., _COR_GET_TITULO ) 
@ 09,18 Say CLI->OBSER1 
@ 10,18 Say CLI->OBSER2 
@ 11,18 Say CLI->OBSER3 
@ 12,18 Say CLI->OBSER4 
@ 13,18 Say CLI->OBSER5 
@ 14,17 Say "�����������������������������������������������" 
@ 15,17 Say "Data de Informacao: " + DTOC( CLI->DATINF ) 
Mensagem( "Pressione [ENTER] para retornar..." ) 
Pausa() 
 
DBSelectAr( _COD_NFISCAL ) 
DBCloseArea() 
DBSelectAr( _COD_PRODNF ) 
DBCloseArea() 
AbreGrupo( "NOTA_FISCAL" ) 
 
SetColor( cCor ) 
SetCursor( nCursor ) 
ScreenRest( cTela ) 
DbSelectar(nAREA) 
DbSetOrder(nORDEM) 
Return(.T.) 
 
 
 
 
 
 
 
 
 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � Pesquisa Multipla / Clientes 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function PEstat3() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cOrdemCmp:= "" 
Local nRow:= 1 
Priv aClientes:= {} 
      AAdd( aClientes, { 0,; 
                         Space( 45 ),; 
                         " ",; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         0,; 
                         Space( 3 ),; 
                         Recno(),; 
                         0,; 
                         0,; 
                         0,; 
                         Space( 40 ),; 
                         0,; 
                         "Sim" } ) 
 
      SetColor( _COR_BROWSE ) 
      VPBox( 00, 00, 03, 79, "ANALISE FINANCEIRA DE MULTIPLOS CLIENTES", _COR_GET_BOX, .F., .F. ) 
      VPBox( 04, 00, 22, 79, "Lista de Clientes", _COR_BROW_BOX, .F., .F., _COR_BROW_TITULO ) 
      oTb:=TBrowseNew( 05, 1, 21, 78 ) 
      oTb:addcolumn(tbcolumnnew("Codigo",    {|| StrZero( aClientes[ nRow ][ 1 ], 6, 0 ) } )) 
      oTb:addcolumn(tbcolumnnew("Cliente",   {|| Left( aClientes[ nRow ][ 2 ], 35 ) } )) 
      oTb:addcolumn(tbcolumnnew("Atrasado",  {|| Tran( aClientes[ nRow ][ 7 ], "@E 999,999.99" ) } )) 
      oTb:addcolumn(tbcolumnnew("Recebido",  {|| Tran( aClientes[ nRow ][ 8 ], "@E 999,999.99" ) } )) 
      oTb:addcolumn(tbcolumnnew("Cancelado", {|| Tran( aClientes[ nRow ][ 9 ], "@E 999,999.99" ) } )) 
      oTb:addcolumn(tbcolumnnew("Sel",       {|| aClientes[ nRow ][ 19 ] })) 
      oTb:AUTOLITE:=.f. 
      oTb:GOTOPBLOCK :={|| nRow:= 1} 
      oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aClientes ) } 
      oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aClientes,@nRow)} 
      oTb:dehilite() 
      Keyboard Chr( K_INS ) 
      whil .t. 
         oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,7},{2,1}) 
         whil nextkey()==0 .and. ! oTb:stabilize() 
         end 
         nTecla:=inkey(0) 
         if nTecla==K_ESC 
            exit 
         endif 
         do case 
            case Chr( nTecla ) $ "0123456789" 
            case nTecla==K_INS 
                 IF aClientes[ 1 ][ 1 ] > 0 
                    AAdd( aClientes, { 0,; 
                          Space( 45 ),; 
                          Space( 45 ),; 
                          0,; 
                          0,; 
                          0,; 
                          0,; 
                          0,; 
                          0,; 
                          0,; 
                          0,; 
                          Space( 3 ),; 
                          Recno(),; 
                          0,; 
                          0,; 
                          0,; 
                          Space( 40 ),; 
                          0,; 
                          "Sim" } ) 
                 ENDIF 
                 oTb:GoBottom() 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
                 nLin:= Row() 
                 nCodCli:= 0 
                 nQuantidade:= 0 
                 nPreco:= 0 
                 nPreco1:= 0 
                 nPreco2:= 0 
                 Set( _SET_DELIMITERS, .F. ) 
                 @ nLin, 01 Get nCodCli Pict "999999" Valid PesqCli( @nCodCli ) 
                 READ 
                 aClientes[ nRow ][ 1 ]:=  nCodCli 
                 aClientes[ nRow ][ 7 ]:=  0 
                 aClientes[ nRow ][ 4 ]:=  0 
                 aClientes[ nRow ][ 5 ]:=  0 
                 aClientes[ nRow ][ 6 ]:=  0 
                 aClientes[ nRow ][ 11 ]:= nCodCli 
                 CLI->( DBSetOrder( 1 ) ) 
                 IF CLI->( DBSeek( nCodCli ) ) 
                    aClientes[ nRow ][ 2 ]:= PAD( CLI->DESCRI, 45 ) 
                    DPA->( DBSetOrder( 5 ) ) 
                    IF DPA->( DBSeek( nCodCli ) ) 
                       WHILE DPA->CLIENT == CLI->CODIGO .AND. !DPA->( EOF() ) 
                           IF DPA->NFNULA=="*" 
                              aClientes[ nRow ][ 9 ]:= aClientes[ nRow ][ 9 ] + DPA->VLR___ 
                           ELSE 
                              IF EMPTY( DPA->DTQT__ ) 
                                 IF DPA->VENC__ <= DATE() 
                                    aClientes[ nRow ][ 7 ]:= aClientes[ nRow ][ 7 ] + DPA->VLR___ 
                                 ENDIF 
                              ELSE 
                                 aClientes[ nRow ][ 8 ]:= aClientes[ nRow ][ 7 ] + DPA->VLR___ 
                              ENDIF 
                           ENDIF 
                           DPA->( DBSkip() ) 
                       ENDDO 
                    ENDIF 
                 ENDIF 
                 Set( _SET_DELIMITERS, .T. ) 
                 IF !LastKey() == K_ESC 
                    Keyboard Chr( K_INS ) 
                 ELSE 
                    IF Len( aClientes ) > 1 
                       ASize( aClientes, Len( aClientes ) - 1 ) 
                    ENDIF 
                    oTb:RefreshAll() 
                    WHILE !oTb:Stabilize() 
                    ENDDO 
                 ENDIF 
            case nTecla==K_F12        ;Calculador() 
            case nTecla==K_UP         ;oTb:up() 
            case nTecla==K_DOWN       ;oTb:down() 
            case nTecla==K_LEFT       ;oTb:up() 
            case nTecla==K_RIGHT      ;oTb:down() 
            case nTecla==K_PGUP       ;oTb:pageup() 
            case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
            case nTecla==K_PGDN       ;oTb:pagedown() 
            case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
            case nTecla==K_TAB 
                 IF Confirma( 0, 0, "Confirma a Impressao?", "Confirma a impressao da relacao?", "S" ) 
                    Relatorio( "POSICAOF.REP" ) 
                 ENDIF 
            case nTecla==K_SPACE 
                 aClientes[ nRow ][ 19 ]:= If( aClientes[ nRow ][ 19 ]=="Sim", "Nao", "Sim" ) 
         otherwise                ;tone(125); tone(300) 
         endcase 
         oTb:refreshcurrent() 
         oTb:stabilize() 
      ENDDO 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   Return Nil




Function PEstat4()
Local cTELA:=ScreenSave( 0, 0, 24, 79 ), cCOR:=setcolor(), nOPCAO:=0 
Local i, nRegistros:= 0
   IF SWAlerta( "<< ESTATISTICAS >>;Deseja atualizar as estatisticas de compra;na ficha cadastral de cada cliente com base;nas informacoes gerenciais do sistema?",{"Sim","Nao"})==1
      VPBox( 04, 04, 22, 70, "ATUALIZANDO INFORMACOES", _COR_GET_BOX )
      SetColor( _COR_GET_EDICAO )
      DBSelectAR( "cli" )
      DBGOTOP()
      WHILE !EOF()
         if rlock()
            replace maicmp  with ctod( "" ),;
                    ultcmp  with ctod( "" ),;
                    maivlr  with 0,;
                    ultvlr  With 0,;
                    saldo_  with LIMCR_ 
         ENDIF
         @ 21,05 SAY StrZero( ++nRegistros, 8, 0 ) + "/" + StrZero( Lastrec(), 8, 0 )
         DBSkip() 
      ENDDO

      FOR i:= 1 TO 2
          IF i == 1
             DBSelectAr( "NF_" )
             INDEX ON DATAEM TO INDICE00
             NF_->( DBGoTop() )
          ELSEIF i == 2
             DBSelectAr( "CUP" )
             INDEX ON DATAEM TO INDICE00
             CUP->( DBGoTop() )
          ENDIF

          WHILE !EOF()
             IF ( NATOPE == 5.101 .OR. NATOPE == 5.110 ) .OR.;
                ( NATOPE == 5.102 .OR. NATOPE == 5.120 ) .OR.;
                ( NATOPE == 6.101 .OR. NATOPE == 6.110 ) .OR.;
                ( NATOPE == 6.102 .OR. NATOPE == 6.120 )
                IF CLIENT > 0
                   IF CLI->( DBSeek( IIF( i==1, NF_->CLIENT, CUP->CLIENT ) ) )
                      @ 21,05 say cli->descri
                      Scroll( 05, 05, 21, 69, 1 )
                      IF CLI->( RLOCK() )
                         IF DATAEM > CLI->ULTCMP
                            Replace CLI->ULTCMP With DATAEM,;
                                    CLI->ULTVLR With VLRTOT
                         ENDIF
                         IF VLRTOT > CLI->MAIVLR
                            Replace CLI->MAICMP With DATAEM,;
                                    CLI->MAIVLR With VLRTOT
                         ENDIF
                         // Se saldo estiver completo, calcular o saldo
                         IF CLI->SALDO_ == CLI->LIMCR_ .AND. CLI->LIMCR_ > 0
                            DPA->( DBSetOrder( 5 ) )
                            DPA->( DBSeek( CLI->CODIGO ) )
                            WHILE !DPA->( EOF() ) .AND. ( DPA->CLIENT == CLI->CODIGO )
                                IF EMPTY( DPA->DTQT__ ) 
                                   Replace CLI->SALDO_ With CLI->SALDO_ - DPA->VLR___
                                ENDIF
                                DPA->( DBSkip() )
                            ENDDO
                         ENDIF
                      ENDIF
                   ENDIF
                ENDIF
             ENDIF
             DBSkip()
          ENDDO
      NEXT
   ENDIF
   SetColor( cCor )
   ScreenRest( cTela )
   Return Nil










 
 
