#include "vpf.ch"
#include "inkey.ch"
#include "formatos.ch"

/*****
�������������Ŀ
� Funcao      � CLIENTES
� Finalidade  � Cadastramento de Clientes
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
���������������
*/
Function Clientes()
Local cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),;
   nCURSOR:=setcursor(), oTB, nTecla, lFlag:=.F.,;
   nArea:= Select(), nOrdem:= IndexOrd(),;
   GetList:= {}, nOrd:= IndexOrd(), nReg, nCodigo

Local nTela:= 1   // Controle da Tela de Edicao Atual


   DBSelectAr( _COD_CLIENTE )
   DBLeOrdem()
   VPBox( 0, 0, 16, 79, " CADASTRO DE CLIENTES ", _COR_GET_BOX )
   VPBox( 17, 0, 22, 79, , _COR_BROW_BOX )

   Mensagem( "[INS]Incluir [ENTER]Alterar [DEL]Excluir [TAB]Etiqueta [CTRL+P]Pedido" )
   Ajuda( "[" + Chr( 27 ) + Chr( 26 ) + "]Janelas  [F9]Tela Principal [F8]Informacoes [F11]Tela Resumida [ESC]Sair" )

   SetColor( _COR_BROWSE )
   oTB:= TBrowseDB( 18, 01, 21, 78 )
   oTB:AddColumn(tbcolumnnew(,{|| STRZERO( Codigo, 6, 0) + " " +  Descri + IF( !EMPTY( CGCMF_ ), Tran( CGCMF_, "@R 99.999.999/9999-99" ) + IF( !cgcmf( CGCMF_, .T. ), "* ", "  " ), Tran( CPF___, "@R XXX.XXX.XXX-XX" ) + Space( 8 ) ) + Space( 18 ) }))
   oTB:AutoLite:=.F.
   oTB:Dehilite()
   CliExibeStr()
   WHILE .T.
      oTb:ForceStable()
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
      SetColor( _COR_BROWSE )
      DO CASE
         CASE nTela==1
              CliExibeDados()
         CASE nTela==2
              CliComplDados()
         CASE nTela==3
              CredDados( 1 )
         CASE nTela==4
              CredDados( 2 )
         CASE nTela==5
              CredDados( 3 )
         CASE nTela==6
              CredDados( 4 )
         CASE nTela==7
              CliFisicaDados()
      ENDCASE
      nTecla:=inkey(0)
      If nTecla=K_ESC
         nCodigo=0
         exit
      EndIf
      DO CASE
         CASE nTecla==K_UP         ;oTB:up()
         CASE Acesso( nTecla )
         CASE nTecla==K_LEFT

              Mensagem( "[INS]Incluir [ENTER]Alterar [DEL]Excluir [TAB]Etiqueta" )
              Ajuda( "[" + Chr( 27 ) + Chr( 26 ) + "]Janelas  [F9]Tela Principal  [F11]Tela Resumida [ESC]Sair" )

              IF nTela==2
                 VPBox( 0, 0, 16, 79, " CADASTRO DE CLIENTES ", _COR_GET_BOX, .F., .F. )
                 CliExibeStr()
                 CliExibeDados()
                 nTela:= 1
              ELSEIF nTela==3
                 CliComplLayOut()
                 oTb:RefreshAll()
                 WHILE !oTb:Stabilize()
                 ENDDO
                 nTela:= 2
              ELSEIF nTela==4
                 CredLayOut( 1 )
                 nTela:= 3
              ELSEIF nTela==5
                 CredLayOut( 2 )
                 nTela:= 4
              ELSEIF nTela==6
                 CredLayOut( 3 )
                 nTela:= 5
              ELSEIF nTela==7
                 CredLayOut( 4 )
                 nTela:= 6
              ENDIF

         CASE nTecla==K_RIGHT

              Mensagem( "[INS]Incluir [ENTER]Alterar [DEL]Excluir [TAB]Etiqueta" )
              Ajuda( "[" + Chr( 27 ) + Chr( 26 ) + "]Janelas  [F9]Tela Principal  [F11]Tela Resumida [ESC]Sair" )

              IF nTela==1
                 CliComplLayOut()
                 oTb:RefreshAll()
                 WHILE !oTb:Stabilize()
                 ENDDO
                 nTela:= 2
              ELSEIF nTela==2
                 CredLayOut( 1 )
                 nTela:= 3
              ELSEIF nTela==3
                 CredLayOut( 2 )
                 nTela:= 4
              ELSEIF nTela==4
                 CredLayOut( 3 )
                 nTela:= 5
              ELSEIF nTela==5
                 CredLayOut( 4 )
                 nTela:= 6
              ELSEIF nTela==6
                 CliFisicaLayOut()
                 nTela:= 7
              ELSEIF nTela==7
                 VPBox( 0, 0, 16, 79, " CADASTRO DE CLIENTES ", _COR_GET_BOX, .F., .F. )
                 CliExibeStr()
                 CliExibeDados()
                 nTela:= 1
              ENDIF

         CASE nTecla==K_CTRL_P
              Keyboard Chr( K_INS ) + Chr( K_ENTER )
              nReg:= RECNO()
              VPC88700( CLI->CODIGO )
              DBGoTo( nReg )

         CASE nTecla==K_DOWN       ;oTB:down()
         CASE nTecla==K_PGUP       ;oTB:pageup()
         CASE nTecla==K_PGDN       ;oTB:pagedown()
         CASE nTecla==K_CTRL_PGUP  ;oTB:gotop()
         CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom()
         CASE nTecla==K_F8
              VPC41234( CLI->CODIGO )

         CASE nTecla==K_INS
              VPBox( 0, 0, 16, 79, " CADASTRO DE CLIENTES ", _COR_GET_BOX, .F., .F. )
              CliExibeStr()
              CliExibeDados()
              nTela:= 1
              CliEdicao( 1, oTb )
              oTb:RefreshAll()
              WHILE !oTb:Stabilize()
              ENDDO

         CASE nTecla==K_ENTER
              IF nTela==1
                 CliEdicao( 2 )
                 oTb:RefreshAll()
                 WHILE !oTb:Stabilize()
                 ENDDO
              ELSEIF nTela==2
                 CliComplEdicao()
              ELSEIF nTela==3
                 CredEdit( 1 )
              ELSEIF nTela==4
                 CredEdit( 2 )
              ELSEIF nTela==5
                 CredEdit( 3 )
              ELSEIF nTela==6
                 CredEdit( 4 )
              ELSEIF nTela==7
                 CliFisicaEdit()
              ENDIF

         CASE nTecla==K_DEL
              nCodigo:= CLI->CODIGO
              IF Exclui( oTb )
                 CCR->( DBSetOrder( 1 ) )
                 IF CCR->( DBSeek( nCodigo ) )
                    IF CCR->( netrlock() )
                       CCR->( DBDelete() )
                    ENDIF
                 ENDIF
                 dbUnlockAll()
              ENDIF
              oTb:RefreshAll()
              WHILE !oTb:Stabilize()
              ENDDO

         CASE nTecla==K_TAB
              IF SWAlerta( "<< ETIQUETA >>;Confirma impressao da etiqueta?", {"Imprimir", "Cancelar"} )==1
                 Relatorio( "CLIETQ.REP" )
              ENDIF

         CASE DBPesquisa( nTecla, oTb )

         CASE nTecla==K_F2
              DBMudaOrdem( 1, oTb )

         CASE nTecla==K_F3
              DBMudaOrdem( 2, oTb )

         CASE nTecla==K_F4
              DBMudaOrdem( 3, oTb )

         CASE nTecla==K_F5
              DBMudaOrdem( 6, oTb )

         CASE nTecla==K_F9
              VPBox( 0, 0, 16, 79, " CADASTRO DE CLIENTES ", _COR_GET_BOX, .F., .F. )
              CliExibeStr()
              CliExibeDados()
              nTela:= 1

         CASE nTecla==K_F11
              CliFisicaLayOut()
              nTela:= 7

         OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      oTB:refreshcurrent()
//      oTB:stabilize()
   enddo
   Set( _SET_DELIMITERS, .T. )
   IF !nArea==0 .AND. !( nOrdem==0 )
      IF nOrdem <> Nil
         DBSelectAr( nArea )
         DBSetOrder( nOrdem )
      ENDIF
   ENDIF
   dbUnLockAll()
   Setcolor(cCOR)
   Setcursor(nCURSOR)
   Screenrest(cTELA)
   DBSelectAR( _COD_CLIENTE )

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to "&gdir/cliind01.ntx", "&gdir/cliind02.ntx", "&gdir/cliind03.ntx", "&gdir/cliind04.ntx", "&gdir/cliind05.ntx", "&gdir/cliind06.ntx", "&gdir/cliind07.ntx"
   #else
     Set Index To "&GDir\CliInd01.NTX", "&GDir\CliInd02.NTX", "&GDir\CliInd03.NTX", "&GDir\CliInd04.NTX", "&GDir\CliInd05.NTX", "&GDir\CliInd06.NTX", "&GDir\CliInd07.NTX"
   #endif
   Return Nil


Function CliEdicao( nOperacao, oTab )
local cTELA:= ScreenSave( 00, 00, 24, 79 ), cCOR:=setcolor(),;
      nCURSOR:=setcursor()
local GetList:= {}
Local nOrdem:= IndexOrd()
Local nCodigo:= 0
local cENDERE:=spac(35), cBAIRRO:=spac(25),;
      cCIDADE:=spac(30), cESTADO:=spac(2), cCODCEP:=spac(8),;
      cTELEX_:=cFAX___:=spac(12), cE_MAIL:= SPACE( 55 ),;
      cCGCMF_:=spac(14), cINSCRI:=spac(15), cCOBRAN:=spac(30), nTRANSP:=0,;
      nVENIN1:=nVENIN2:=nVENIN3:=0, nVENEX1:=nVENEX2:=nVENEX3:=0,;
      cCOMPRA:=cRESPON:=spac(40),;
      dDATACD:=date(), cCLIENT:="N", cSELECT:="Nao",;
      cCONIND:=" ", nCodAtv:= 0, cCPF___:= Space( 11 ), nCodFil,;
      cDESCRI:=spac(45), nFONEN_:=0, aFONE:={spac(12),spac(12),spac(12)},;
      nORDEMG:=1, cFantas:= Space( 45 )

   VPBox( 0, 0, 16, 79, "INCLUSAO DE CLIENTES", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
   Ajuda("["+_SETAS+"][PgDn][PgUp]Move [TAB]Arquivo [ENTER]Confirma [ESC]Cancela")

   IF nOperacao==1      // INCLUSAO
      DBSetOrder( 1 )

      oTab:RefreshAll()
      WHILE !oTab:Stabilize()
      ENDDO

      /* Busca o ultimo numero gravado */
      DBSeek( 999999 )
      dbSkip( -1 )
      nCodigo:= CODIGO + 1

      DBAppend()
      IF netrlock()
         Replace CODIGO With nCodigo
         DBUnlockAll()
         nRegistro:= RECNO()
      ENDIF

      DBSelectAr( "VEN" )
      DBSelectAr( "CLI" )
      DBSetOrder( 1 )

      /* Pular o campo codigo */
      KeyBoard Chr( K_ENTER )

      IF DBSeek( nCodigo )
         IF RECNO() <> nRegistro
            Inkey(0)
            Aviso( "Registro j� existe, reinicie esta ficha cadastral.", .T. )
            Keyboard Chr( K_ESC )
         ENDIF
      ELSE
         Inkey(0)
         Aviso( "Registro nao gravado, reinicie esta ficha cadastral.", .T. )
         Keyboard Chr( K_ESC )
      ENDIF



   ELSE
      nCodigo:= CODIGO
      Keyboard Chr( K_ENTER )
   ENDIF

   //* CARREGAMENTO DAS VARIAVEIS *//
   cDESCRI:= DESCRI
   cFANTAS:= FANTAS
   cENDERE:= ENDERE
   cBAIRRO:= BAIRRO
   cCIDADE:= CIDADE
   cESTADO:= ESTADO
   cCODCEP:= CODCEP
   cTELEX_:= TELEX_
   cFAX___:= FAX___
   aFone:={  FONE1_, FONE2_, FONE3_ }
   cCGCMF_:= CGCMF_
   cCPF___:= CPF___
   cINSCRI:= INSCRI
   cCOBRAN:= COBRAN
   nTRANSP:= TRANSP
   nVENIN:= { VENIN1, VENIN2, VENIN3 }
   nVENEX:= { VENEX1, VENEX2, VENEX3 }


   // OLEZZO@TERRA.COM.BR

   nVenIn1:= VENIN1
   nVenEx1:= VENEX1


   cCOMPRA:= COMPRA
   cRESPON:= RESPON
   dDATACD:= DATACD
   nMidia_:= MIDIA_
   cCLIENT:= CLIENT
   cSELECT:= SELECT
   cE_MAIL:= E_MAIL
   nCodAtv:= CODATV
   nFoneN_:= FONEN_
   nCodFil:= CODFIL
   cConInd:= CONIND

   SetCursor( 1 )
   SetColor( _COR_GET_EDICAO )
   @ 01,02 say "Codigo......:" get nCODIGO pict "999999" when;
     mensagem("Digite o codigo do cliente que sera cadastrado.")
   @ 01,48 Say "Codigo Principal: [000-000000]"
   @ 02,02 say "Nome........:" get cDESCRI pict "@!" when;
     mensagem("Digite o nome do cliente.") Valid IF( nOperacao==1, PesqCliDes( cDescri ), .T. )
   @ 03,02 Say "N.Fantasia..:" get cFANTAS pict "@!" when;
     Mensagem( "Digite o nome fantasia do cliente." )
   @ 04,02 say "Endereco....:" get cENDERE pict "@X" when;
     mensagem("Digite o endereco do cliente.")
   @ 05,02 say "Bairro......:" get cBAIRRO pict "@S20" when;
     mensagem("Digite o bairro.")
   @ 06,02 say "Cidade......:" get cCIDADE pict "@S30" when;
     mensagem("Digite a cidade.")
   @ 06,49 say "-" get cESTADO pict "@XX" valid veruf(@cESTADO) when;
     mensagem("Digite o estado.")
   @ 07,02 say "Cep.........:" get cCODCEP pict "@R 99.999-999" valid pesqcep(cCODCEP) when;
     mensagem("Digite o cep.")
   @ 07,44 say "Telefone(s):" get nFONEN_ pict "9" valid telefone(aFone,nFONEN_,07,57,"=>") when;
     mensagem("Digite o numero de telefones que o cliente possui.")
   @ 08,02 say "C.Atividade.:" get nCodAtv pict "9999" valid LocalizaAtv(@nCodAtv) when;
     mensagem("Digite o codigo da atividade ou [9999][Enter] para ver tabela.")
   @ 08,44 say "Fax........:" get cFAX___ pict "@R XXXX-XXXX.XXXX" when;
     mensagem("Digite o numero do Fax.")
   @ 09,02 say "CGCMF.......:" get cCGCMF_ pict "@R 99.999.999/9999-99" valid cgcmf( cCGCMF_ ) when;
     mensagem("Digite o numero do CGCMF para inclusao.") .AND. CGCCPF( cCGCMF_, cCPF___, 1 )
   @ 09,44 say "Insc.Est...:" get cINSCRI when;
     mensagem("Digite o numero da inscricao estadual do cliente.") .AND. IEstadual() Valid ;
     IEstadual( cEstado )
   @ 10,02 Say "C.P.F.......:" Get cCpf___ Pict "@R 999.999.999-99" Valid CPF( cCpf___ ) when;
     CGCCPF( cCGCMF_, cCPF___, 2 ) .AND. Mensagem( "Digite o CPF do cliente." )
   @ 10,44 say "Transp.....:" get nTRANSP pict "9999" valid;
     transeleciona(@nTRANSP) when;
     mensagem("Digite o codigo da transportadora.")
   @ 11,02 say "Cobranca....:" get cCOBRAN  Pict "@S22" when;
     mensagem("Digite o endereco de cobranca.")
   @ 11,44 Say "Contato/Mid:" Get nMidia_ Pict "@R 999" Valid TabelaMidia( @nMidia_ ) When;
     Mensagem( "Digite a forma/tipo de midia ou contato." )
   @ 12,02 SAY "Interno(s)..:" get nVENIN1 pict "9999" valid VenSeleciona(@nVENIN1,1) when;
     mensagem("Digite o codigo do vendedor interno (1).")
   @ 12,44 say "Externo(s).:" get nVENEX1 pict "9999" valid VenSeleciona(@nVENEX1,2) when;
     mensagem("Digite o codigo do vendedor externo (1).")
   @ 13,02 say "Comprador...:" get cCOMPRA pict "@S30" when;
     mensagem("Digite o nome do responsavel pelas compras.")
   @ 13,50 say "[C]onsumo/[I]ndustria:" get cCONIND pict "!" valid cCONIND$"ciCI" when;
     mensagem("Digite [C] para consumo ou [I] para industria ou revenda.")
   @ 14,02 say "Responsavel.:" get cRESPON pict "@X" when;
     mensagem("Digite o nome do responsavel pela empresa.")
   @ 14,64 say "Cliente?" get cCLIENT pict "!" valid cCLIENT$"SN" when;
     mensagem("Digite [S] para clientes e [N] para nao clientes.")
   @ 15,02 Say "E-Mail......:" Get cE_MAIL
   ReadModal( GetList, 1, , , ); GetList:= {}

   IF LastKey() <> K_ESC
      IF Confirma( 15, 63, "Confirma?", ;
         "Digite [S] para confirmar as informacoes.","S",COR[16]+","+COR[18]+",,,"+COR[17])

         nRegAtual:= RECNO()

         IF nOperacao==1
            /* Busca Codigo Filiais */
            DBSetOrder( 4 )
            DBSeek( StrZero( SWSet( _GER_EMPRESA ) + 1, 03, 00 ) + "000000", .T. )
            DBSkip( -1 )
            nCodFil:= CLI->CODFIL + 1
            DBSetOrder( 1 )
         ENDIF

         DBGoTo( nRegAtual )
         DBSelectAr( _COD_CLIENTE )

         IF netrlock()
            //* GRAVACAO DOS DADOS *//
            Replace CODFIL With nCodFil, FILIAL With SWSet( _GER_EMPRESA )
            repl CODIGO with nCODIGO, DESCRI with cDESCRI, ENDERE with cENDERE,;
                 BAIRRO with cBAIRRO, CIDADE with cCIDADE, ESTADO with cESTADO,;
                 CODCEP with cCODCEP, FONEN_ with nFONEN_, FONE1_ with aFONE[1],;
                 FONE2_ with aFONE[2], FONE3_ with aFONE[3], TELEX_ with cTELEX_,;
                 FAX___ with cFAX___, CGCMF_ with cCGCMF_, INSCRI with cINSCRI,;
                 COBRAN with cCOBRAN, TRANSP with nTRANSP,;
                 VENIN1 with nVENIN1, VENIN2 with nVENIN2, VENIN3 with nVENIN3,;
                 VENEX1 with nVENEX1, VENEX2 with nVENEX2, VENEX3 with nVENEX3,;
                 COMPRA with cCOMPRA, RESPON with cRESPON, DATACD with dDATACD,;
                 CLIENT with cCLIENT, SELECT with cSELECT, CONIND with cCONIND,;
                 CodAtv WITH nCodAtv, FANTAS With cFANTAS, CPF___ With cCPF___,;
                 E_MAIL With cE_MAIL, MIDIA_ With nMidia_

            @ 07,44 say "Telefone(s): [0]                 "
            @ 08,44 say "Fax........: [    -    .    ]"

         ENDIF
      ELSE
         IF nOperacao==1
            IF netrlock()
               Dele
            ENDIF
         ENDIF
      ENDIF
   ELSE
      IF nOperacao==1
         IF netrlock()
            Dele
         ENDIF
      ENDIF
   ENDIF
   dbunlockall()
   FechaArquivos()
   screenrest(cTELA)
   setcursor(nCURSOR)
   setcolor(cCOR)
   DBLeOrdem()
   return nil

Function CliFisicaLayOut()
   VPBox( 0, 0, 16, 79, " Cadastro Pessoa Fisica ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
   Mensagem( "[ESC] Retorna a consulta ao cadastro de clientes" )
   Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela")
   Return Nil

Function CliFisicaDados()
local cTELA:= ScreenSave( 00, 00, 24, 79 ), cCOR:=setcolor(),;
      nCURSOR:=setcursor()
local GetList:= {}
Local nOrdem:= IndexOrd()

   DispBegin()

//   VPBox( 0, 0, 16, 79, " Cadastro Pessoa Fisica ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
   //* CARREGAMENTO DAS VARIAVEIS *//
   nCodigo:= CODIGO
   cDESCRI:= DESCRI
   cFANTAS:= FANTAS
   cENDERE:= ENDERE
   cBAIRRO:= BAIRRO
   cCIDADE:= CIDADE
   cESTADO:= ESTADO
   cCODCEP:= CODCEP
   cTELEX_:= TELEX_
   cFAX___:= FAX___
   cFone1_:= FONE1_
   cFone2_:= FONE2_
   cFone3_:= FONE3_
   cCGCMF_:= CGCMF_
   cCPF___:= CPF___
   cINSCRI:= INSCRI
   cCOBRAN:= COBRAN
   nTRANSP:= TRANSP
   cCOMPRA:= COMPRA
   cRESPON:= RESPON
   dDATACD:= DATACD
   cCLIENT:= CLIENT
   cSELECT:= SELECT
   cE_MAIL:= E_MAIL
   nCodAtv:= CODATV
   nFoneN_:= FONEN_
   nCodFil:= CODFIL
   dNascim:= NASCIM
   cObser1:= OBSER1
   cObser2:= OBSER2
   cObser3:= OBSER3
   cObser4:= OBSER4

   CCR->( DBSetOrder( 1 ))
   IF !CCR->( DBSeek( CLI->CODIGO ) )
      CCR->( DBAppend() )
      Replace CCR->CODIGO With nCodigo,;
              CCR->DESCRI With cDescri
   ENDIF
   SetColor( _COR_GET_EDICAO )

   cRG____:= CCR->CI____
   cOrgao_:= CCR->ORGAO_
   cEstCiv:= CCR->ESTCIV
   nDepend:= CCR->NDEPEN
   cConjug:= CCR->CONJUG
   dAdmiss:= CCR->ADMISS
   cCargo_:= CCR->CARGO_
   nSalar_:= CCR->SALAR_
   cEmpres:= CCR->EMPTRA
   dConNas:= CCR->CONNAS
   cEmpCon:= CCR->EMPCON
   dConAdm:= CCR->CONDTA
   nConSal:= CCR->CONSAL
   cConCar:= CCR->CONCAR
   nSPCEst:= CCR->SPCEST

   cCont:= Repl( "�", 40 ) + "�" + "�" + "�"
   cCorPad:= "08/11"

   @ 01,01 SAY PADC( " " + ALLTRIM( CLI->DESCRI ) + " ", 78, "�" ) Color "14/" + CorFundoAtual()

   Set Delimiters Off

   @ 02,02 Say "Fone.......:" Get cFone1_ Pict "@R XXXX-XXXX.XXXX"
   @ 02,30 Say ""             Get cFone2_ Pict "@R XXXX-XXXX.XXXX"
   @ 02,47 Say ""             Get cFone3_ Pict "@R XXXX-XXXX.XXXX"
   @ 03,02 Say "Endereco...:" Get cEndere
   @ 04,02 Say "Bairro.....:" Get cBairro
   @ 05,02 Say "Cidade/UF..:" Get cCidade
   @ 05,47 Get cEstado
   @ 05,51 Get cCodCep Pict "@r 99999-999"
   @ 06,02 Say "C.P.F......:" Get cCPF___
   @ 07,02 Say "RG/Orgao...:" Get cRG____ Pict "@S12"
   @ 07,29 Say "-" Get cOrgao_
   @ 08,02 Say "Nascimento.:" Get dNascim
   @ 09,02 Say "Empresa....:" Get cEmpres
   @ 10,02 Say "Admissao...:" Get dAdmiss
   @ 10,25 Say "Cargo" Get cCargo_
   @ 10,57 Say "Salario"  Get nSalar_ Pict "@E 9,999,999.99"
   @ 11,02 Say "Estado Civil" Get cEstCiv
   @ 12,02 Say "Conjuge....:" Get cConjug
   @ 12,51 Say "N.Dependentes" Get nDepend Pict "99"

   @ 13,02 Say "Nascimento.:" Get dConNas
   @ 14,02 Say "Empresa....:" Get cEmpCon
   @ 15,02 Say "Admissao...:" Get dConAdm
   @ 15,25 Say "Cargo" Get cConCar
   @ 15,57 Say "Salario"  Get nConSal Pict "@E 9,999,999.99"

//   @ 17,02 Say "      e-mail" Get cE_Mail

/*
   nCustoCarta:= 0
   @ 19,01 Say Repl( "�", 78 )
   @ 20,02 Say "Situacao/Avisos" Get nSpcEst Pict "9" Valid;
              ( ( nCustoCarta:= ( nSpcEst * 0.50 ) ) >= 0 )
   @ 20,21 Say "(0)-Nenhuma (1)-1�Aviso (2)-2�Aviso (3)-3�Aviso (4)-SPC"
   @ 21,02 Say "Custo em Operacoes de Cobranca" Get nCustoCarta Pict "@E 999,999.99"
*/
   DispEnd()
   Keyboard Chr( Inkey(0) )
   Set Delimiters On
   SetColor( cCor )
   SetCursor( nCursor )
   Return Nil


Function CliFisicaEdit()
local cTELA:= ScreenSave( 00, 00, 24, 79 ), cCOR:=setcolor(),;
      nCURSOR:=setcursor()
local GetList:= {}
Local nOrdem:= IndexOrd()

//   VPBox( 0, 0, 22, 79, " Cadastro Pessoa Fisica ", _COR_GET_BOX, .F., .F., _COR_GET_TITULO, .T. )
//   Mensagem( "[ESC] Retorna a consulta ao cadastro de clientes" )
//   Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ENTER]Confirma [ESC]Cancela")

   SetCursor( 1 )
   //* CARREGAMENTO DAS VARIAVEIS *//
   nCodigo:= CODIGO
   cDESCRI:= DESCRI
   cFANTAS:= FANTAS
   cENDERE:= ENDERE
   cBAIRRO:= BAIRRO
   cCIDADE:= CIDADE
   cESTADO:= ESTADO
   cCODCEP:= CODCEP
   cTELEX_:= TELEX_
   cFAX___:= FAX___
   cFone1_:= FONE1_
   cFone2_:= FONE2_
   cFone3_:= FONE3_
   cCGCMF_:= CGCMF_
   cCPF___:= CPF___
   cINSCRI:= INSCRI
   cCOBRAN:= COBRAN
   nTRANSP:= TRANSP
   cCOMPRA:= COMPRA
   cRESPON:= RESPON
   dDATACD:= DATACD
   cCLIENT:= CLIENT
   cSELECT:= SELECT
   cE_MAIL:= E_MAIL
   nCodAtv:= CODATV
   nFoneN_:= FONEN_
   nCodFil:= CODFIL
   dNascim:= NASCIM
   cObser1:= OBSER1
   cObser2:= OBSER2
   cObser3:= OBSER3
   cObser4:= OBSER4

   CCR->( DBSetOrder( 1 ))
   IF !CCR->( DBSeek( CLI->CODIGO ) )
      CCR->( DBAppend() )
      Replace CCR->CODIGO With nCodigo,;
              CCR->DESCRI With cDescri
   ENDIF
   SetColor( _COR_GET_EDICAO )

   cRG____:= CCR->CI____
   cOrgao_:= CCR->ORGAO_
   cEstCiv:= CCR->ESTCIV
   nDepend:= CCR->NDEPEN
   cConjug:= CCR->CONJUG
   dAdmiss:= CCR->ADMISS
   cCargo_:= CCR->CARGO_
   nSalar_:= CCR->SALAR_
   cEmpres:= CCR->EMPTRA
   dConNas:= CCR->CONNAS
   cEmpCon:= CCR->EMPCON
   dConAdm:= CCR->CONDTA
   nConSal:= CCR->CONSAL
   cConCar:= CCR->CONCAR
   nSPCEst:= CCR->SPCEST

   cCont:= Repl( "�", 40 ) + "�" + "�" + "�"
   cCorPad:= "08/11"


   @ 01,01 SAY PADC( " " + ALLTRIM( CLI->DESCRI ) + " ", 78, "�" ) Color "14/" + CorFundoAtual()

   Set Delimiters Off

   @ 02,02 Say "Fone.......:"   Get cFone1_ Pict "@R XXXX-XXXX.XXXX"
   @ 02,30 Say ""               Get cFone2_ Pict "@R XXXX-XXXX.XXXX"
   @ 02,47 Say ""               Get cFone3_ Pict "@R XXXX-XXXX.XXXX"
   @ 03,02 Say "Endereco...:"   Get cEndere
   @ 04,02 Say "Bairro.....:"   Get cBairro
   @ 05,02 Say "Cidade/UF..:"   Get cCidade
   @ 05,47                      Get cEstado
   @ 05,51                      Get cCodCep Pict "@r 99999-999"
   @ 06,02 Say "C.P.F......:"   Get cCPF___
   @ 07,02 Say "RG/Orgao...:"   Get cRG____ Pict "@S12"
   @ 07,29 Say "-" Get cOrgao_
   @ 08,02 Say "Nascimento.:"   Get dNascim
   @ 09,02 Say "Empresa....:"   Get cEmpres
   @ 10,02 Say "Admissao...:"   Get dAdmiss
   @ 10,25 Say "Cargo"          Get cCargo_
   @ 10,57 Say "Salario"        Get nSalar_ Pict "@E 9,999,999.99"
   @ 11,02 Say "Estado Civil"   Get cEstCiv
   @ 12,02 Say "Conjuge....:"   Get cConjug
   @ 12,51 Say "N.Dependentes"  Get nDepend Pict "99"

   @ 13,02 Say "Nascimento.:"   Get dConNas
   @ 14,02 Say "Empresa....:"   Get cEmpCon
   @ 15,02 Say "Admissao...:"   Get dConAdm
   @ 15,25 Say "Cargo"          Get cConCar
   @ 15,57 Say "Salario"        Get nConSal Pict "@E 9,999,999.99"
   READ

   ////////////////// CREDIARIO /////////////////
   IF CCR->( netrlock() )
      Replace CCR->CI____ With cRG____,;
              CCR->ORGAO_ With cOrgao_,;
              CCR->ESTCIV With cEstCiv,;
              CCR->NDEPEN With nDepend,;
              CCR->CONJUG With cConjug,;
              CCR->ADMISS With dAdmiss,;
              CCR->CARGO_ With cCargo_,;
              CCR->SALAR_ With nSalar_,;
              CCR->EMPTRA With cEmpres,;
              CCR->CONNAS With dConNas,;
              CCR->EMPCON With cEmpCon,;
              CCR->CONDTA With dConAdm,;
              CCR->CONSAL With nConSal,;
              CCR->CONCAR With cConCar,;
              CCR->SPCEST With nSPCEst
   ENDIF

   ////////// CADASTRO DE CLIENTES //////////
   IF CLI->( netrlock() )
      Replace CLI->DESCRI With cDESCRI,;
              CLI->FANTAS With cFANTAS,;
              CLI->ENDERE With cENDERE,;
              CLI->BAIRRO With cBAIRRO,;
              CLI->CIDADE With cCIDADE,;
              CLI->ESTADO With cESTADO,;
              CLI->CODCEP With cCODCEP,;
              CLI->TELEX_ With cTELEX_,;
              CLI->FAX___ With cFAX___,;
              CLI->FONE1_ With cFone1_,;
              CLI->FONE2_ With cFone2_,;
              CLI->FONE3_ With cFone3_,;
              CLI->CGCMF_ With cCGCMF_,;
              CLI->CPF___ With cCPF___,;
              CLI->INSCRI With cINSCRI,;
              CLI->COBRAN With cCOBRAN,;
              CLI->TRANSP With nTRANSP,;
              CLI->COMPRA With cCOMPRA,;
              CLI->RESPON With cRESPON,;
              CLI->DATACD With dDATACD,;
              CLI->CLIENT With cCLIENT,;
              CLI->SELECT With cSELECT,;
              CLI->E_MAIL With cE_MAIL,;
              CLI->CODATV With nCodAtv,;
              CLI->FONEN_ With nFoneN_,;
              CLI->CODFIL With nCodFil,;
              CLI->NASCIM With dNascim,;
              CLI->OBSER1 With cObser1,;
              CLI->OBSER2 With cObser2,;
              CLI->OBSER3 With cObser3,;
              CLI->OBSER4 With cObser4
   ENDIF

   Set Delimiters On
   ScreenRest( cTela )
   SetColor( cCor )
   SetCursor( nCursor )
   Return Nil



FUNCTION CGCCPF( cCGC, cCpf, nPosicao )
/*
IF !Empty( IF( nPosicao==2, cCgc, cCpf ) )
   IF LastKey() == K_UP
      Keyboard Chr( K_UP )
   ELSE
      Keyboard Chr( K_DOWN )
   ENDIF
ENDIF
*/
RETURN .T.

/*
��������������Ŀ
� Funcao       � CLIEXIBESTR
� Finalidade   � Exibir a estrutura do cadastro na tela
� Programador  � VPF
� Data         �
� Atualizacao  �
����������������
*/
Static Function CliExibeStr()
LOCAL cCor:= Setcolor( _COR_GET_EDICAO )
@ 01,02 say "Codigo......: ["+strzero(0,6,0)+"]"
@ 02,02 say "Nome........: ["+space(45)+"]"
@ 03,02 Say "N.Fantasia..: ["+Space(45)+"]"
@ 04,02 say "Endereco....: ["+space(35)+"]"
@ 05,02 say "Bairro......: ["+space(20)+"]"
@ 06,02 say "Cidade......: ["+space(30)+"]"
@ 06,49 say "- [  ]"
@ 07,02 say "Cep.........: [  .   -   ]"
@ 07,44 say "Telefone(s): [ ] [    -   .  .   ]"
@ 08,02 say "C.Atividade.: [0000]"
@ 08,44 say "Fax........: [   -   .  .  ]"
@ 09,02 say "CGCMF.......: [  .   .   /    -  ]"
@ 09,44 say "Insc.Est...: [               ]"
@ 10,02 say "C.P.F.......: [   .   .   -  ]"
@ 10,44 say "Transp.....: [  0]"
@ 11,02 say "Cobranca....: [                      ]"
@ 11,44 Say "Contato/Mid: [  0]                ]"
@ 12,02 say "Interno(s)..: [   0]"
@ 12,44 say "Externo(s).: [   0]"
@ 13,02 say "Comprador...: ["+spac(30)+"]"
@ 13,50 say "[C]onsumo/[I]ndustria: [ ]"
@ 14,02 say "Responsavel.: ["+spac(40)+"]"
@ 14,64 say "Cliente? [X]"
@ 15,02 Say "E-Mail......: ["+space(45)+"]"
SetColor( cCor )
return nil

/*
�������������Ŀ
� Funcao      � CLIEXIBEDADOS
� Finalidade  � Exibir os dados dos clientes na tela do sistema
� Programador � VPF
� Data        �
� Atualizacao �
���������������
*/
func CliExibeDados()
loca cCOR:=setcolor()
setcolor( COR[17] )
@ 01,48 Say "Codigo Principal: ["+StrZero( FILIAL, 3, 0 ) + "-" + StrZero( CODFIL, 6, 0 ) + "]" Color _COR_GET_BOX
@ 01,17 say strzero(CODIGO,6,0)
@ 02,17 Say DESCRI
@ 03,17 say FANTAS
@ 04,17 say ENDERE
@ 05,17 say substr(BAIRRO,1,20)
@ 06,17 say CIDADE
@ 06,52 say ESTADO
@ 07,17 say CODCEP pict "@R 99.999-999"
@ 07,58 say FONEN_
@ 07,62 say FONE1_ pict "@R !!!!-!!!!.!!!!"
@ 08,17 say STRZERO(CODATV,4,0)
@ 08,58 say FAX___ pict "@R !!!!-!!!!.!!!!"
@ 09,17 say CGCMF_ pict "@R 99.999.999/9999-99"
@ 09,36 Say IF( !cgcmf( CGCMF_, .T. ), "* ", "  " ) Color _COR_GET_BOX
@ 09,58 say INSCRI
@ 10,17 Say Cpf___ Pict "@R 999.999.999-99"
@ 11,17 say LEFT( COBRAN, 22 )

/* Busca Midia -----------------------------------------------------------*/
IF CLI->MIDIA_ > 0
   MID->( DBSetOrder( 1 ) )
   MID->( DBSeek( CLI->MIDIA_ ) )
   @ 11,44 Say "Contato/Mid: [                    ]" Color _COR_GET_EDICAO
   @ 11,58 Say StrZero( CLI->MIDIA_, 3, 0 ) + "-" + LEFT( MID->DESCRI, 16 )
ELSE
   @ 11,44 Say "Contato/Mid: [  0]                 " Color _COR_GET_EDICAO
   @ 11,58 Say StrZero( 0, 3, 0 )
ENDIF

@ 10,58 say StrZero( TRANSP, 3, 0 )
@ 12,17 say StrZero( VENIN1, 4, 0 )
@ 12,58 say StrZero( VENEX1, 4, 0 )
@ 13,17 say SubStr(  COMPRA, 1, 30 )
@ 13,74 say CONIND
@ 14,17 say RESPON
@ 14,74 say CLIENT
@ 15,17 Say E_MAIL
setcolor(cCOR)
return nil

/*****
�������������Ŀ
� Funcao      � CLICOMPLEMENTO
� Finalidade  � Complemento a Clientes
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
���������������
*/
Function CliComplemento()
loca cTELA:=screensave( 0, 0, 24, 79 ), cCOR:=setcolor(),;
     nCURSOR:=setcursor(), oTB, nTecla, lFlag:=.F.,;
     aPos:={ 17, 0, 22, 79 }, nArea:= Select(), nOrdem:= IndexOrd(),;
     GetList:= {}, nOrd:= IndexOrd()
Local cDigVer
Local nRegistro
Loca cObser1, cObser2, cObser3, cObser4, cObser5, nValorCred, dValid_
Loca dDatInf, nCodEmpresa:= 0, cCodigoFolha:= Space( 15 )

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
   nRegistro:= CLI->( RECNO() )
   nPreReg:= PRE->( RECNO() )
   PRE->( DBSetOrder( 1 ) )
   nOrd:= IndexOrd()

   CliComplLayOut()

   DPA->( DBSetOrder( 5 ) )
   NF_->( DBSetOrder( 1 ) )
   SetCursor(0)
   SetColor( _COR_BROWSE )
   Mensagem( "Pressione [ESC] para finalizar a verIficacao.")
   ajuda("["+_SETAS+"][PgUp][PgDn]Move [ESC]Retorna")
   DBLeOrdem()
   DBGoTo( nRegistro )
   oTB:=tbrowsedb( aPos[1]+1, aPos[2]+1, aPos[3]-1, aPos[4]-1 )
   oTB:addcolumn(tbcolumnnew(,{|| STRZERO( Codigo, 6, 0) + " " +  Descri + IF( !EMPTY( CGCMF_ ), Tran( CGCMF_, "@R 99.999.999/9999-99" ), Tran( CPF___, "@R XXX.XXX.XXX-XX" ) + Space( 8 ) ) + Space( 18 ) }))
   oTB:AUTOLITE:=.f.
   oTB:dehilite()
   cAviso:= "Data limite de credito expirada! Renove!"
   whil .t.
      oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
      whil nextkey()=0 .and.! oTB:stabilize()
      enddo

      CliComplDados()
      nTecla:=inkey(0)
      If nTecla=K_ESC
         nCodigo=0
         exit
      EndIf
      DO CASE
         CASE nTecla==K_UP         ;oTB:up()
         CASE nTecla==K_LEFT       ;oTB:up()
         CASE nTecla==K_RIGHT      ;oTB:down()
         CASE nTecla==K_DOWN       ;oTB:down()
         CASE nTecla==K_PGUP       ;oTB:pageup()
         CASE nTecla==K_PGDN       ;oTB:pagedown()
         CASE nTecla==K_CTRL_PGUP  ;oTB:gotop()
         CASE nTecla==K_CTRL_PGDN  ;oTB:gobottom()
         CASE nTecla==K_F8
              Keyboard Repl( Chr( K_ENTER ), 19 )
         CASE nTecla==K_TAB
              IF Confirma( 0, 0, "Imprimir Barras p/ Cliente?", "S", "S" )
                 Relatorio( "CLIBARRA.REP" )
              ENDIF
         CASE nTecla==K_ENTER
              CliComplEdicao()
         CASE DBPesquisa( nTecla, oTb )
         CASE nTecla==K_F2
              DBMudaOrdem( 1, oTb )
         CASE nTecla==K_F3
              DBMudaOrdem( 2, oTb )
         OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      oTB:refreshcurrent()
      oTB:stabilize()
   enddo
   PRE->( DBGoto( nPreReg ) )
   CLI->( DBGoto( nRegistro ) )
   DBSelectar( _COD_CLIENTE )
   DBSetOrder( 1 )
   If lFlag
      CLI->( DBUnlock() )
      CLI->( DBCloseArea() )
   EndIf
   Set( _SET_DELIMITERS, .T. )
   IF !nArea==0 .AND. !nOrdem==0
      DBSelectAr( nArea )
      DBSetOrder( nOrdem )
   ENDIF
   dbUnLockAll()
   Setcolor(cCOR)
   Setcursor(nCURSOR)
   Screenrest(cTELA)
   Return(.T.)


Function CliComplLayOut()
Local cCor:= SetColor()
   SetColor( _COR_GET_EDICAO )
   VPBox( 0, 0, 16, 79, " Informacoes Complementares ", _COR_GET_BOX, .F., .F. )
   VPBox( 17, 00, 22, 79, "Clientes", _COR_BROW_BOX, .F., .F. )
   @ 02,02 Say "INFORMACOES DIVERSAS                         Operacao Principal.: ���    "
   @ 03,02 Say "                                             Condicao Pagamento.: ���    "
   @ 04,02 Say "                                             Optante Simples....: �      "
   @ 05,02 Say "                                             Nascimento / Fundacao       "
   @ 06,02 Say "                                             ��������"
   @ 07,02 Say "                                             Debito em Conta Automatizado"
   @ 08,02 Say "Notas Fiscais M1    Data           Valor     ����������������������������"
   @ 09,02 Say "1a.Compra       �������� ���������������     Banco   ���"
   @ 10,02 Say "Maior Compra    �������� ���������������     Agencia ����"
   @ 11,02 Say "Ultima Compra   �������� ���������������     C/C     ���������-�"
   @ 12,02 Say "Limite Credito  �������� ���������������     Identif ��������������������"
   @ 13,02 Say "Saldo Credito ���������> ���������������     Dias p/Novo Vcto ���"
   @ 14,02 Say "Tabela de Preco     ���� ���������������     Cartao Afinidade �������������"
   @ 15,02 Say "Informacao      ��������                     Folha: >������-���������������"
   SetColor( cCor )
   Return Nil


Function CliComplDados()
Local cAviso:= "Data limite de credito expirada! Renove!"
Local cCor:= SetColor(), cSimpl_

      cSimpl_:= SIMPL_
      cObser1:= OBSER1
      cObser2:= OBSER2
      cObser3:= OBSER3
      cObser4:= OBSER4
      cObser5:= OBSER5
      nValorCred:= LIMCR_
      dValid_:= VALID_
      dDatInf:= DATINF
      nTabCnd:= TABCND
      nTabOpe:= TABOPE

      SetColor( _COR_GET_CURSOR )
      @ 03,02 Say cObser1
      @ 04,02 Say cObser2
      @ 05,02 Say cObser3
      @ 06,02 Say cObser4
      @ 07,02 Say cObser5
      @ 06,47 Say NASCIM

      @ 02,68 Say nTabOpe Pict "999"
      @ 03,68 Say nTabCnd Pict "999"
      @ 04,68 Say cSimpl_ Pict "!"

      DPA->( DBSeek( CLI->CODIGO ) )
      WHILE !( DPA->NFNULA==" " ) .AND. CLI->CODIGO==DPA->CLIENT
         DPA->( DBSkip() )
      ENDDO
      IF DPA->CLIENT==CLI->CODIGO
         IF NF_->( DBSeek( DPA->CODNF_ ) )
            @ 09,18 Say NF_->( DATAEM )
            @ 09,27 Say Tran( NF_->VLRTOT, "@E 9999,999,999.99" )
         ENDIF
      ELSE
         @ 09,18 Say "  /  /  "
         @ 09,27 Say Tran( 0, "@E 9999,999,999.99" )
         NF_->( DBSeek( 999999999 ) )
      ENDIF
      @ 10,18 Say MAICMP
      @ 10,27 Say Tran( MAIVLR, "@E 9999,999,999.99" )
      @ 11,18 Say ULTCMP
      @ 11,27 Say Tran( ULTVLR, "@E 9999,999,999.99" )
      @ 12,18 Say VALID_
      @ 12,27 Say Tran( LIMCR_, "@E 9999,999,999.99" )
      @ 13,27 Say Tran( SALDO_, "@E 9999,999,999.99" )
      @ 14,22 Say Tran( TABPRE, "9999" )

      @ 09,55 Say Tran( BANCO_, "999" )
      @ 10,55 Say AGENCI
      @ 11,55 Say Tran( CONTAC, "999999999" )
      @ 11,65 Say DIGVER
      @ 12,55 Say LEFT( IDENTI, 20 )
      @ 13,64 Say NOVVEN Pict "999"

      PRE->( DBSeek( CLI->TABPRE ) )
      @ 14,27 Say Left( PRE->DESCRI, 16 )
      @ 15,18 Say DATINF

      @ 15,55 Say Str( FOLEMP, 6 )
      @ 15,62 Say FOLCOD

      // CODIGO DE BARRAS
      IF CODBAR==Space( 13 )
         IF netrlock()
            Replace CODBAR With StrZero( CODIGO, 12, 0 ) + AllTrim( twCalcDig( StrZero( CODIGO, 12, 0 ) ) )
         ENDIF
         DBUnlock()
      ENDIF
      @ 14,64 Say CODBAR

      IF ! VALID_ == CTOD( "  /  /  " )
         IF VALID_ < Date()
            IF ! Alltrim( OBSER5 ) == cAviso
               IF netrlock()
                  Replace Obser5 With cAviso
               ENDIF
            ENDIF
         ELSE
            IF Alltrim( OBSER5 ) == cAviso
               IF netrlock()
                  Replace Obser5 With Space( Len( Obser5 ) )
               ENDIF
            ENDIF
         ENDIF
         DBUnlockAll()
      ENDIF
      SetColor( cCor )
      Return Nil


Function CliComplEdicao()
Local nCursor:= SetCursor()
Local cCor:= SetColor(),;
      lDelimiters:= Set( _SET_DELIMITERS, .F. )
Local GetList:= {}
Local cObser1:= OBSER1, cObser2:= OBSER2, cObser3:= OBSER3, cObser4:= OBSER4,;
      cObser5:= OBSER5, nValorCred:= LIMCR_, dValid_:= VALID_, dDatInf:= DATINF,;
      nTabPre:= TABPRE, cPai___:= PAI___, cMae___:= MAE___, dNascim:= NASCIM,;
      nBANCO_:= BANCO_, cAGENCI:= AGENCI, nCONTAC:= CONTAC, cDigVer:= DIGVER,;
      cIDENTI:= IDENTI, nNOVVEN:= NOVVEN, nSaldo:=  SALDO_, nFolEmp:= FOLEMP,;
      cSimpl_:= SIMPL_,;
      cFolCod:= FOLCOD, cCodbar:= CODBAR, nTabOpe:= TABOPE, nTabCnd:= TABCND

    SetColor( _COR_GET_EDICAO )
    SetCursor( 1 )
    @ 03,02 Get cObser1 Pict "@!"
    @ 04,02 Get cObser2 Pict "@!"
    @ 05,02 Get cObser3 Pict "@!"
    @ 06,02 Get cObser4 Pict "@!"

    @ 12,18 Get dValid_

    @ 12,27 Get nValorCred Pict "@EZ 9999,999,999.99" Valid CalcSaldoCred( nValorCred, @nSaldo )
    @ 13,27 Get nSaldo     Pict "@EZ 9999,999,999.99"
    @ 14,22 Get nTabPre Pict "9999"

    @ 15,18 Say dDatInf

    @ 02,68 Get nTabOpe Pict "@R 999"
    @ 03,68 Get nTabCnd Pict "@R 999"
    @ 04,68 Get cSimpl_ Pict "!"

    @ 06,47 Get dNascim

    @ 09,55 Get nBANCO_ Pict "999" Valid PesqBco( @nBanco_ )
    @ 10,55 Get cAGENCI
    @ 11,55 Get nContac Pict "999999999" ;
       Valid fContaCorr( @nContac, @cDigVer, GetList )
    @ 11,65 Get cDigVer
    @ 12,55 Get cIDENTI Pict "@S20"
    @ 13,64 Get nNOVVEN Pict "999"

    @ 14,64 Get cCodBar

    @ 15,55 Get nFolEmp Pict "@R 999999"
    @ 15,62 Get cFolCod
    READ

    IF netrlock()
       dDatInf:= DATE()
       Replace SALDO_ With ( SALDO_ - LIMCR_ + nValorCred )
       Replace CODBAR With cCodBar
       Replace OBSER1 With cObser1,;
               OBSER2 With cObser2,;
               OBSER3 With cObser3,;
               OBSER4 With cObser4,;
               DATINF With dDatInf,;
               LIMCR_ With nValorCred,;
               VALID_ With dValid_,;
               PAI___ With cPai___,;
               MAE___ With cMae___,;
               TABPRE With nTabPre,;
               NASCIM With dNascim,;
               BANCO_ With nBANCO_,;
               AGENCI With cAGENCI,;
               CONTAC With nCONTAC,;
               IDENTI With cIDENTI,;
               NOVVEN With nNOVVEN,;
               DIGVER With cDigVer,;
               SALDO_ With nSaldo,;
               FOLCOD With cFolCod,;
               FOLEMP With nFolEmp,;
               TABOPE With nTabOpe,;
               SIMPL_ With cSimpl_,;
               TABCND With nTabCnd
    ENDIF

    Set( _SET_DELIMITERS, lDelimiters )
    SetCursor( nCursor )
    SetColor( cCor )
    dbUnlockAll()
    Return Nil


Function CalcSaldoCred( nValorCred, nSaldo )
Local nVlrDevedor:= 0
   nOrdemDPA:= DPA->( IndexOrd() )
   DPA->( DBSetOrder( 5 ) )
   DPA->( DBSeek( CLI->CODIGO ) )
   WHILE DPA->CLIENT==CLI->CODIGO .AND. !DPA->( EOF() )
       IF EMPTY( DPA->DTQT__ ) .AND. DPA->NFNULA==" "
          nVlrDevedor:= nVlrDevedor + DPA->VLR___
       ENDIF
       DPA->( DBSkip() )
   ENDDO
   nSaldo:= nValorCred - nVlrDevedor
   DPA->( DBSetOrder( nOrdemDPA ) )
   Return .T.




/*****
�������������Ŀ
� Funcao      � CLIPESQUISA
� Finalidade  � Pesquisa diferenciada ao cadastro de clientes
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        � 19/Fevereiro/98
���������������
*/
Function CliPesquisa()
Local cCNPJ__:= Space( 14 )
Local GetList:= {}
Local nArea:= Select(), nOrdem:= IndexOrd()
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local cDescri:= Space( 45 ), cFantas:= Space( 45 ),;
      cEndere:= Space( 35 ), cCidade:= Space( 30 ), cEstado:= Space( 2 ),;
      cFone1_:= Space( 12 ), cFax___:= Space( 12 )
IF !AbreGrupo( "CLIENTES" )
   Return Nil
ENDIF
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
UserScreen()
WHILE LastKey() <> 27
     DBSelectAr( _COD_CLIENTE )

     /* Tela pra Get pesquisa */
     VPBox( 00, 08, 20, 74, "Pesquisa ao cadastro de clientes", _COR_GET_BOX )
     SetColor( _COR_GET_EDICAO )

     cDescri:= Space( 45 )
     cFantas:= Space( 45 )
     cEndere:= Space( 35 )
     cCidade:= Space( 30 )
     cEstado:= Space( 2 )
     cFone1_:= Space( 12 )
     cFax___:= Space( 12 )
     cCNPJ__:= Space( 14 )
     @ 02,09 Say " CNPJ..........: " Get cCNPJ__ Pict "@R 99.999.999/9999-99"
     @ 04,09 Say " Razao Social..: " Get cDescri Pict "@!"
     @ 06,09 Say " Nome Fantasia.: " Get cFantas Pict "@!"
     @ 08,09 Say "�����������������������������������������������������������������"
     //@ 08,09 Say " Endereco......: " Get cEndere
     @ 10,09 Say " Cidade........: " Get cCidade Pict "@!"
     @ 12,09 Say " Estado........: " Get cEstado Pict "@!"
     @ 14,09 Say " Fone..........: " Get cFone1_ Pict "@R XXXX-XXXX.XXXX"
     @ 16,09 Say " FAX...........: " Get cFax___ Pict "@R XXXX-XXXX.XXXX"
     READ
     IF LastKEy() == K_ESC
        EXIT
     ENDIF
     IF !Empty( cCNPJ__ )
        Index On CGCMF_ To CLRES001.TMP
        DBSeek( cCNPJ__, .T. )
        DisplayCliente()
     ELSEIF !Empty( cDescri )
        Index On Descri To CLRES001.TMP
        DBSeek( cDescri, .T. )
        cDescri:= DESCRI
        IF !Empty( cCidade )
           WHILE Descri == cDescri
              IF cCidade == CIDADE
                 EXIT
              ENDIF
              DBSkip()
           ENDDO
           IF Descri==cDescri .AND. Cidade == cCidade
              Mensagem( "Cliente localizado com sucesso." )
              DisplayCliente()
           ELSE
              Mensagem( "Nao foi possivel localizar o cliente nesta cidade." )
           ENDIF
        ELSE
           DisplayCliente()
        ENDIF
     ELSEIF !EMPTY( cFantas )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        Index On Fantas To CLRES002.TMP
        DBSeek( cFantas, .T. )
        cFantas:= Fantas
        IF !Empty( cCidade )
           WHILE Fantas == cFantas
              IF cCidade == CIDADE
                 EXIT
              ENDIF
              DBSkip()
           ENDDO
           IF Fantas==cFantas .AND. Cidade == cCidade
              Mensagem( "Cliente localizado com sucesso." )
              DisplayCliente()
           ELSE
              Mensagem( "Nao foi possivel localizar o cliente nesta cidade." )
           ENDIF
        ELSE
           DisplayCliente()
        ENDIF
     ELSEIF !EMPTY( cFone1_ ) .OR. !EMPTY( cFax___ )
        Mensagem( "Aguarde, procurando o cliente pelo fone/fax..." )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON FONE1_ TO CLRES001.TMP
        IF !Empty( cFone1_ )
           IF DBSeek( cFone1_ )
              DisplayCliente()
           ELSE
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              INDEX ON FONE2_ TO CLRES001.TMP
              IF DBSeek( cFone1_ )
                 DisplayCliente()
              ELSE
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                 INDEX ON FONE3_ TO CLRES001.TMP
                 IF DBSeek( cFone1_ )
                    DisplayCliente()
                 ELSE
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                    INDEX ON FONE4_ TO CLRES001.TMP
                    IF DBSeek( cFone1_ )
                       DisplayCliente()
                    ELSE
                       Mensagem( "Cliente nao foi localizado com este fone..." )
                    ENDIF
                 ENDIF
              ENDIF
           ENDIF
        ELSE
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           INDEX ON FAX___ TO CLRES001.TMP
           IF DBSeek( cFax___ )
              DisplayCliente()
           ELSE
              Mensagem( "Fax nao localizado..." )
           ENDIF
        ENDIF
     ELSEIF !EMPTY( cCidade )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON DESCRI TO CLRES003.TMP FOR CIDADE==cCidade
        DisplayCliente()
     ELSEIF !EMPTY( cEstado )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
        INDEX ON DESCRI TO CLRES003.TMP FOR ESTADO==cEstado
        DisplayCliente()
     ENDIF
ENDDO

/* restaura indices do cliente */
DBSelectAr( _COD_CLIENTE )

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  set index to "&gdir/cliind01.ntx", "&gdir/cliind02.ntx", "&gdir/cliind03.ntx", "&gdir/cliind04.ntx", "&gdir/cliind05.ntx", "&gdir/cliind06.ntx", "&gdir/cliind07.ntx"
#else
  Set Index To "&GDir\CliInd01.NTX", "&GDir\CliInd02.NTX", "&GDir\CliInd03.NTX", "&GDir\CliInd04.NTX", "&GDir\CliInd05.NTX", "&GDir\CliInd06.NTX", "&GDir\CliInd07.NTX"
#endif

/* seleciona a area anterior */
IF nArea > 0
   DBSelectAr( nArea )
   IF nOrdem > 0
      DBSetOrder( nOrdem )
   ENDIF
ENDIF

/* finalizacao do programa */
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil

/*****
�������������Ŀ
� Funcao      � DisplayCliente <STATIC>
� Finalidade  � Apresentar os dados cadastrais do cliente (Aux. a CliPesquisa())
� Parametros  � Nil
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        � 18/02/98
���������������
*/
Static Function DisplayCliente
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 ), cTecla
VPBox( 02, 08, 22, 75, "Pesquisa ao cadastro de clientes", "15/07" )
SetColor( "15/07" )
Mensagem( "[]Movimenta [ENTER/ESC]Retorna" )
WHILE .T.
   @ 04,09 Say " Codigo........: " + StrZero( Codigo, 6, 0 )
   @ 06,09 Say " Razao Social..: " + Descri
   @ 08,09 Say " Nome Fantasia.: " + Fantas
   @ 10,09 Say " Endereco......: " + Endere
   @ 12,09 Say " Cidade........: " + Cidade
   @ 14,09 Say " Estado........: " + Estado
   @ 16,09 Say " Fone(s) 1/2/3.: " + Fone1_ + " / " + Fone2_ + " / " + Fone3_
   @ 18,09 Say " Fax...........: " + Fax___
   @ 20,09 Say " Comprador.....: " + Compra
   nTecla:= Inkey(0)
   DO CASE
      CASE nTecla==K_ENTER .OR. nTecla==K_ESC
           EXIT
      CASE nTecla==K_RIGHT .OR. nTecla==K_DOWN
           DBSkip()
      CASE nTecla==K_LEFT .OR. nTecla==K_UP
           DBSkip(-1)
   ENDCASE
ENDDO
SetColor( cCor )
SetCursor( nCursor )
ScreenRest( cTela )
Return Nil


/*****
�������������Ŀ
� Funcao      � CLIINFO
� Finalidade  � Dar Manutencao ao Cadastro de Clientes
�             � Exemplos de utilizacao
� Uso         � CliInfo( 100 )                                        => Retorna o saldo de credito do cliente
�             � CliInfo( 100, 1250.30, "+", CTOD( "15/03/00" ), 189 ) => Joga informacoes de credito inclusive
�             � CliInfo( 100, 1470.30, "+" )                          => Inclui informacoes de credito s/ atualizacao de Credito
�             � CliInfo( 100, 350.30, "-" )                           => Retira Informacoes
� Data        �
� Atualizacao �
���������������
*/
Function CliInfo( nCliente, nValor, cEntSai, dDataEmissao, nNotaFiscal, nValorNota )
Local nArea:= Select(), nOrdem

   DBSelectAr( _COD_CLIENTE )
   nOrdem:= CLI->( IndexOrd() )
   CLI->( DBSetOrder( 1 ) )
   IF CLI->( DBSeek( nCliente ) )
      IF CLI->( netrlock() )
         IF nValor==Nil .AND. nValorNota==Nil
            /* Se ambos os valores de atualizacao estiverem em branco ��������*/
            CLI->( DBSetOrder( nOrdem ) )
            DBUnlockAll()
         ELSE
            IF cEntSai=="+" .AND. !( nValor==Nil )
               Replace CLI->SALDO_ With CLI->SALDO_ + nValor
            ELSE
               IF !nValor==Nil
                  Replace CLI->SALDO_ With IF( nValor <= CLI->SALDO_, CLI->SALDO_ - nValor, 0 )
               ENDIF
               /* Informacoes de Maior Venda p/ Cliente e Ultima Venda */
               IF !( nNotaFiscal == Nil ) .AND. !( nValorNota == Nil )
                  IF nValorNota > CLI->MAIVLR
                     IF netrlock()
                        Replace MAICMP With dDataEmissao,;
                                MAIVLR With nValorNota
                     ENDIF
                  ENDIF
                  IF netrlock()
                     Replace ULTCMP With dDataEmissao,;
                             ULTVLR With nValorNota
                  ENDIF
               ENDIF
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   CLI->( DBSetOrder( nOrdem ) )
   IF nArea > 0
      DBSelectAr( nArea )
   ENDIF
   Return IF( CLI->LIMCR_ == 0, 999999.99, CLI->SALDO_ )


/*****
�������������Ŀ
� Funcao      � LancaCliente
� Finalidade  �
� Parametros  � nCodCli, nValorEntrada, nValorSaida
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
���������������
*/
Function LancaCliente( nCodCli, nValorQuitacao, nValorFatura )
Local nArea:= Select(), nOrdem:= IndexOrd(),;
      nOrdCli:= CLI->( IndexOrd() ), nCliReg:= CLI->( RECNO() )
   DBSelectAr( _COD_CLIENTE )
   DBSetOrder( 1 )
   IF DBSeek( nCodCli )
      IF netrlock()
         IF !nValorQuitacao == 0
            CliInfo( nCodCli, nValorQuitacao, "+" )
         ELSE
            IF CliInfo( nCodCli, nValorfatura, "-" ) <= 0
               cTelaRes:= ScreenSave( 0, 0, 24, 79 )
               Aviso( "O limite de Credito deste cliente foi excedido." )
               Pausa()
               ScreenRest( cTelaRes )
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   DBGoTo( nCliReg )
   DBSetOrder( nOrdCli )
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )
   Return Nil

/*****
�������������Ŀ
� Funcao      � SALDOCLIENTE
� Finalidade  � Verifica o saldo do cliente
� Parametros  � nCodCli, nValor=Valor a comparar com o saldo
� Retorno     � Nil
� Programador � Valmor Pereira Flores
� Data        �
���������������
*/
Function SaldoCliente( nCodCli, nValor )
Local cCor:= SetColor(), nCursor:= SetCursor(),;
      cTela:= ScreenSave( 0, 0, 24, 79 )
Local nArea:= Select(), nOrdem:= IndexOrd(),;
      nOrdCli:= CLI->( IndexOrd() ), nCliReg:= CLI->( RECNO() )

   DBSelectAr( _COD_CLIENTE )
   DBSetOrder( 1 )
   IF DBSeek( nCodCli )
      IF LIMCR_ > 0
         IF nValor == Nil
            IF CliInfo( nCodCli ) < 0
               Aviso( "Limite de credito do cliente esta excedido!" )
               Pausa()
            ELSE
               IF CliInfo( nCodCli ) < 999999.99
                  Aviso( "Saldo de credito do cliente � " + Alltrim( Tran( CliInfo( nCodCli ), "@E 999,999.99" ) ) )
                  Pausa()
               ENDIF
            ENDIF
         ELSEIF CliInfo( nCodCli ) < nValor
            Aviso( "Saldo de credito insuficiente p/ esta operacao!" )
            Pausa()
         ENDIF
      ENDIF
   ENDIF
   DBGoTo( nCliReg )
   DBSetOrder( nOrdCli )
   DBSelectAr( nArea )
   DBSetOrder( nOrdem )
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   Return Nil


/*
�������������Ŀ
� Funcao      � TELEFONE
� Finalidade  � Executar a edicao de telefones do cliente.
� Programador � Valmor Pereira Flores
� Data        � 21/Setembro/1993
� Atualizacao � 01/Fevereiro/1994 - 02/Outubro/2000
���������������
*/
func telefone(aFONE,nPQTD,nPLIN,nPCOL,cPTXT)
loca nCT:=1, cTELA:=screensave(15,00,15,79), GETLIST:={}
If lastkey()=K_UP .or. nPQTD=0; return(.t.); end
If nPQTD>3; return(.f.); end
@ nPLIN,nPCOL say spac(20)
for nCT=1 to nPQTD
    @ nPLIN,nPCOL say alltrim(str(nCT))+cPTXT get aFONE[nCT] pict "@R XXXX-XXXX.XXXX" when;
      Mensagem( "Digite o(s) telefone(s) do cliente.")
    read
next
screenrest(cTELA)
return(.t.)

/*
�������������Ŀ
� Modulo      � VPC41000
� Funcao      � PesqCliDes
� Finalidade  � Busca Clientes pelo nome e retorna .T. / .F.
� Data        � Novembro/2000
� Programador � Valmor Pereira Flores
�             �
���������������
*/
Function PesqCliDes( cDescri )
Local nOrdem:= CLI->( IndexOrd() ), nRecno:= CLI->( RECNO() )
Local cTela:= ScreenSave( 0, 0, 24, 79 )
CLI->( DBSetOrder( 2 ) )
IF CLI->( DBSeek( PAD( cDescri, LEN( CLI->DESCRI ) ) ) )
   Aviso( "Cliente ja consta na base de dados..." )
   Pausa()
   ScreenRest( cTela )
   CLI->( DBSetOrder( nOrdem ) )
   CLI->( DBGoTo( nRecno ) )
   Return .F.
ENDIF
CLI->( DBSetOrder( nOrdem ) )
CLI->( DBGoTo( nRecno ) )
Return .T.





Function ClientesInclusao( nCodCli, oTab, nRegNovoCliente )
Loca cTela:= ScreenSave( 0, 0, 24, 79 ), cCor:= SetColor(),;
     nOrdemRes:= IndexOrd(), nCursor:= SetCursor(), nArea:= Select()
Local cDescri, cEndere, cCidade, cEstado, cFone1_, cFone2_, cFax___,;
      cCompra, cCGCMf_, cCPF___, cInscri, cCodCep, dDataCd, cBairro,;
      cFantas, nCodFil, nMidia_
Local lAppend:= .F.
   SetCursor( 1 )
   DBSelectAr( _COD_CLIENTE )
   DBSetOrder( 1 )
   IF nCodCli == Nil
      nCodCli:= 0
      nCodFil:= 0
   ENDIF
   IF nCodCli == 0
      cDescri:= Space( Len( CLI->DESCRI ) )
      cFantas:= Space( Len( CLI->FANTAS ) )
      cEndere:= Space( Len( CLI->ENDERE ) )
      cCidade:= Space( Len( CLI->CIDADE ) )
      cBairro:= Space( Len( CLI->BAIRRO ) )
      cEstado:= Space( 02 )
      cFone1_:= Space( 12 )
      cFone2_:= Space( 12 )
      cFax___:= Space( 12 )
      cCompra:= Space( Len( CLI->COMPRA ) )
      cCGCMf_:= Space( 14 )
      cCPF___:= Space( 11 )
      cInscri:= Space( Len( CLI->INSCRI ) )
      cCodCep:= Space( 8 )
      nVenIn_:= 0
      nVenEx_:= 0
      dDataCd:= Date()
      nMidia_:= 0
      lAppend:= .T.
   ELSE
      lAppend:= .F.
      DBSelectAr( _COD_CLIENTE )
      nOrdemRes:= IndexOrd()
      DBSetOrder( 1 )
      IF DBSeek( nCodCli )
         nCodFil:= CLI->CODFIL
         cDescri:= CLI->DESCRI
         cFantas:= CLI->FANTAS
         cEndere:= CLI->ENDERE
         cBairro:= CLI->BAIRRO
         cCidade:= CLI->CIDADE
         cEstado:= CLI->ESTADO
         cFone1_:= CLI->FONE1_
         cFone2_:= CLI->FONE2_
         cFax___:= CLI->FAX___
         cCompra:= CLI->COMPRA
         cCGCMf_:= CLI->CGCMF_
         cInscri:= CLI->INSCRI
         cCodCep:= CLI->CODCEP
         cCPF___:= CLI->CPF___
         dDataCd:= Date()
         nMidia_:= CLI->MIDIA_
         nVenIn_:= CLI->VENIN1
         nVenEx_:= CLI->VENEX1
      ELSE
         SetCursor( 0 )
         Return .F.
      ENDIF
      DBSetOrder( nOrdemRes )
      IF !oTab==Nil
         oTab:Gotop()
         oTab:RefreshAll()
         WHILE !oTab:Stabilize()
         ENDDO
      ENDIF
      lAppend:= .F.
   ENDIF
   Ajuda( "["+_SETAS+"]Move [ESC]Cancela" )
   IF nCodCli == 0
      DbSetOrder( 1 )
      DBGoBottom()
      nCodCli:= ( CODIGO + 1 )
   ENDIF
   IF !SWSet( _PED_CADCLIENTE )
      nOpcao:= SWAlerta( "ATENCAO! Cliente nao sera cadastrado na base de dados....;"+;
                "Portanto nao sera possivel extrair ou armazenar;"+;
                "informacoes Financeiras ou de venda sobre este cliente caso seja;"+;
                "emitida uma nota fiscal ou qualquer outro procedimento;" +;
                "que sejam baseados na codificacao do mesmo!", { "     OK    ", " Cancelar Lancamento " } )
      IF nOpcao==2
         nOpcao:= 0
         Keyboard Chr( K_ESC )
      ENDIF
      nCodCli:= 0
      lAppend:= .T.
   ENDIF
   /* Edicao do Cadastro de Clientes
      a partir do modulo de pedidos */
   cCorRes:= SetColor()
   SetColor( _COR_GET_EDICAO )
   IF lAppend
      DBAppend()
      IF netrlock()
         Replace CODIGO With nCodCli
      ENDIF
      DBUnlock()
   ENDIF
   VPBox( 03, 05, 21, 75, " Cadastro Resumido de Clientes ", _COR_GET_BOX, .T., .T., _COR_GET_TITULO )
   @ 04,07 Say "Codigo......: [" + IF( nCodCli==0, "Nao Identificado", StrZero( nCodCli, 6, 0 ) ) + "]"
   @ 05,07 Say "Nome........:" Get cDescri When Mensagem( "Digite o nome do cliente." )
   //Valid BuscaCliente( cDescri, nCodCli )
   @ 06,07 Say "N.Fantasia..:" Get cFantas When Mensagem( "Digite o nome fantasia do cliente." )
   @ 07,07 Say "Endereco....:" Get cEndere When Mensagem( "Digite o endereco do cliente." )
   @ 08,07 Say "Bairro......:" Get cBairro When Mensagem( "Digite o bairro do cliente." )
   @ 09,07 Say "Cidade......:" Get cCidade When Mensagem( "Digite a cidade do cliente." )
   @ 10,07 Say "Estado......:" Get cEstado Valid Veruf( @cEstado ) When Mensagem( "Digite a sigla do estado." )
   @ 11,07 Say "Cep.........:" Get cCodCep Pict "@R 99.999-999" When Mensagem( "Digite o codigo enderecamento postal." )
   @ 12,07 Say "Fone(s).....:" Get cFone1_ Pict "@R XXXX-XXXX.XXXX" When Mensagem( "Digite o fone para contato." )
   @ 13,07 Say "            :" Get cFone2_ Pict "@R XXXX-XXXX.XXXX" When Mensagem( "Digite o fone para contato." )
   @ 14,07 Say "Fax.........:" Get cFax___ Pict "@R XXXX-XXXX.XXXX" When Mensagem( "Digite o fax. " )
   @ 15,07 Say "Comprador...:" Get cCompra When Mensagem( "Digite o nome do(a) comprador(a)." )
   @ 16,07 Say "CGCMf.......:" Get cCGCMf_ Pict "@R 99.999.999/9999-99" Valid CGCMF( cCgcMf_ ) When Mensagem( "Digite o CGC do cliente:" )
   @ 17,07 Say "CPF.........:" Get cCPF___ Pict "@R 999.999.999-99" Valid CPF( cCPF___ ) When Mensagem( "Digite o CPF do cliente." )
   @ 18,07 Say "I.E.........:" Get cInscri When Mensagem( "Digite o n� da inscricao estadual." )
   @ 19,07 Say "Data........:" Get dDataCd
   @ 19,40 Say "Contato/Midia:" Get nMidia_ Pict "999" Valid TabelaMidia( @nMidia_ )
   @ 20,07 Say "Vend.Interno:" Get nVenIn_ Pict "999"
   @ 20,40 Say "Vend.Externo.:" Get nVenEx_ Pict "999"
   READ
   SetColor( cCorRes )
   ScreenRest( cTela )
   Aviso( "Armazenando cliente no Fortuna, aguarde..." )
   IF LastKey() == K_ESC
      SetCursor( 0 )
      ScreenRest( cTela )
      DBSetOrder( 1 )
      DBSeek( nCodCli )
      IF netrlock()
         DBDelete()
      ENDIF
      DBUnlock()
      DBSetOrder( 1 )
      DBSetOrder( nOrdemRes )
      IF !oTab==Nil
         oTab:RefreshAll()
         WHILE !oTab:Stabilize()
         ENDDO
      ENDIF
      nCodCli:= 0
      DBSelectAr( nArea )
      Return .F.
   ENDIF
   DBSelectAr( _COD_CLIENTE )

   /* Busca Codigo Filiais */
   DBSetOrder( 4 )
   DBSeek( StrZero( SWSet( _GER_EMPRESA ) + 1, 03, 00 ) + "000000", .T. )
   DBSkip( -1 )

   nCodFil:= CLI->CODFIL + 1
   DBSetOrder( 1 )
   CLI->( DBSetOrder( 1 ) )
   CLI->( DBSeek( nCodCli ) )
   IF CLI->( netrlock() ) .AND. !EOF()
      Replace CodFil With nCodFil,;
              Bairro With cBairro,;
              Fantas With cFantas,;
              Descri With cDescri,;
              Endere With cEndere,;
              Cidade With cCidade,;
              Estado With cEstado,;
              Compra With cCompra,;
              CGCMf_ With cCGCMf_,;
              Fone1_ With cFone1_,;
              Fone2_ With cFone2_,;
              Fax___ With cFax___,;
              CPF___ With cCpf___,;
              Inscri With cInscri,;
              CodCep With cCodCep,;
              VENIN1 With nVenIn_,;
              VENEX1 With nVenEx_

      nRegNovoCliente:= CLI->( RECNO() )
   ENDIF
   CLI->( DBUnlock() )

   ScreenRest( cTela )
   SetCursor( 0 )
   DBSetOrder( 1 )
   DBSeek( nCodCli )
   DBSetOrder( nOrdemRes )
   DBSelectAr( nArea )
   IF !oTab==Nil
      oTab:RefreshAll()
      WHILE !oTab:Stabilize()
      ENDDO
   ENDIF
   Return .T.


