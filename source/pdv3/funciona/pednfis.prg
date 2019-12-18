#Define P_PEDIDOS            1
#Define P_CLIENTE            2
#Define   CLI_CODIGO         1
#Define   CLI_DESCRICAO      2
#Define   CLI_ENDERECO       3
#Define   CLI_BAIRRO         4
#Define   CLI_CIDADE         5
#Define   CLI_ESTADO         6
#Define   CLI_CEP            7
#Define   CLI_CGC            8
#Define   CLI_INSCRICAO      9
#Define   CLI_COBRANCA       10
#Define   CLI_CONSIND        11
#Define   CLI_CPF            12
#Define   CLI_FONE           13
#Define P_CABECALHO          3
#Define   CAB_NOTAFISCAL     1
#Define   CAB_NATOPERACAO    2
#Define       NAT_CODIGO     1
#Define       NAT_DESCRICAO  2
#Define   CAB_DATAEMISSAO    3
#Define   CAB_ENTRADASAIDA   4
#Define   CAB_VIATRANSP      5
#Define   CAB_ORDEMCOMPRA    6
#Define P_TRANSPORTE         4
#Define   TRA_CODIGO         1
#Define   TRA_DESCRICAO      2
#Define   TRA_ENDERECO       3
#Define   TRA_BAIRRO         4
#Define   TRA_CIDADE         5
#Define   TRA_ESTADO         6
#Define   TRA_CEP            7
#Define   TRA_CGC            8
#Define   TRA_INSCRICAO      9
#Define   TRA_FONE           10
#Define P_PRODUTOS           5
#Define   PRO_CODIGO         1
#Define   PRO_DESCRICAO      2
#Define   PRO_UNIDADE        3
#Define   PRO_PRECOVENDA     4
#Define   PRO_PRECOTOTAL     5
#Define   PRO_CODTABELAA     6
#Define   PRO_CODTABELAB     7
#Define   PRO_CLAFISCAL      8
#Define   PRO_QUANTIDADE     9
#Define   PRO_VALORIPI       10
#Define   PRO_PERCENTUALIPI  11
#Define   PRO_PERCENTUALICM  12
#Define   PRO_MATERIAPRIMA   13
#Define   PRO_CODIGOFISCAL   14
#Define   PRO_CODFABRICA     15
#Define   PRO_QTDPADRAO      16
#Define   PRO_BASEICM        17
#Define   PRO_PERREDUCAO     18
#Define   PRO_VLRREDUCAO     19
#Define   PRO_ORIGEM         20
#Define P_COMISSOES          6
#Define   COM_INTERNO        1
#Define       INT_CODIGO     1
#Define       INT_AVISTA     2
#Define       INT_APRAZO     3
#Define       INT_RECEBIDAS  4
#Define       INT_STOTAL     5
#Define       INT_VAVISTA    7
#Define       INT_VAPRAZO    8
#Define       INT_VRECEBIDAS 9
#Define       INT_VSTOTAL    10
#Define       INT_DESCRICAO  11
#Define   COM_EXTERNO        2
#Define       EXT_CODIGO     1
#Define       EXT_AVISTA     2
#Define       EXT_APRAZO     3
#Define       EXT_RECEBIDAS  4
#Define       EXT_STOTAL     5
#Define       EXT_VAVISTA    7
#Define       EXT_VAPRAZO    8
#Define       EXT_VRECEBIDAS 9
#Define       EXT_VSTOTAL    10
#Define       EXT_DESCRICAO  11
#Define P_IMPOSTOS           7
#Define   IMP_VALORTOTAL     1
#Define   IMP_VALORIPI       2
#Define   IMP_VALORNOTA      3
#Define   IMP_VALORBASEICM   4
#Define   IMP_VALORICM       5
#Define   IMP_VALORSERVICOS  6
#Define   IMP_PERISSQN       7
#Define   IMP_VLRISSQN       8
#Define   IMP_PERIRRF        9
#Define   IMP_VLRIRRF       10
#Define P_DIVERSOS           8
#Define   DIV_QUANTIDADE     1
#Define   DIV_ESPECIE        2
#Define   DIV_PESOBRUTO      3
#Define   DIV_PESOLIQUIDO    4
#Define   DIV_DATASAIDA      5
#Define   DIV_HORASAIDA      6
#Define   DIV_TIPOFRETE      7
#Define   DIV_VALORFRETE     8
#Define   DIV_VALORSEGURO    9
#Define   DIV_OBSERVACOES    10
#Define       OBS_LINHA1     1
#Define       OBS_LINHA2     2
#Define       OBS_LINHA3     3
#Define       OBS_LINHA4     4
#Define       OBS_LINHA5     5
#Define   DIV_FATURA         11
#Define   DIV_CONDICOES      12
#Define P_FATURA             9
#Define   FAT_PARCELA        1
#Define   FAT_PERCENTUAL     2
#Define   FAT_VALOR          3
#Define   FAT_DIAS           4
#Define   FAT_BANCO          5
#Define   FAT_VENCIMENTO     6
#Define   FAT_TIPO           7
#Define   FAT_PAGAMENTO      8
#Define   FAT_CHEQUE         9
#Define   FAT_NUMERO        10
#Define P_TESTE             10
#Define   TES_OK             1
#Define   TES_ERROS          2
#Define P_NUMERO            11
#Define   NUM_PEDIDO         1
#Define P_SERVICOS          12
#Define   SER_CODIGO         1
#Define   SER_DESCRICAO      2
#Define   SER_UNITARIO       3
#Define   SER_TOTAL          4
#Define   SER_QUANTIDADE     5

/*
* Modulo      - nFiscal
* Descricao   - Cadastro de Notas Fiscais
* Programador - Valmor Pereira Flores
* Data        - 10/Outubro/1994
* Atualizacao -
*/
#include "FORMATOS.CH"
#include "VPF.CH"
#include "INKEY.CH"
#include "BOX.CH"
loca cTELA:=zoom(11,34,13,51), cCOR:=setcolor(), nOPCAO:=0
vpbox(11,34,13,51)
whil .t.
   mensagem("")
   @ 12,35 Say " 1 Emissao...  "
   NFInc()
   Exit
enddo
limpavar()
unzoom(cTELA)
setcolor(cCOR)
return(nil)


/*
* Modulo      - NFINCLUSAO
* Finalidade  - Efetuar a inclusao de notas fiscais com base nos pedidos.
* Programador - Valmor Pereira Flores.
* Data        - 20/Outubro/1994.
* Atualizacao -
*/
Function NotaFiscal( cCodPed )
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, MaxCol() )
  LOCAL aNFiscal:= { "", {}, {}, {}, {}, {}, {}, {}, {}, {,{}}, {}, {}, {} }
  LOCAL nRow, oTab, nTecla, lRefaz:= .F.
  Local cVerMon:="N", cTipoNf:="U", nNUMERO:=0, lFLAGC:=.T.,;
        lObservacoes:=.F., lFLAGM:=.F., nCLIENT:=0, cDESCRI:=spac(45),;
        cEndere:=spac(35), cBairro:=spac(25), cCOBRAN:=spac(30),;
        cCIDADE:=spac(30), cESTADO:=spac(2), cCODCEP:=spac(8),;
        cCGCMF_:=spac(14), cINSCRI:=spac(12), nPEDIDO:=0, nVltPro:= 0,;
        dDATAEM:=date(), nVENIN_:=0, nVENEX_:=0, nMONTA_:=0, nVLRNOT:=0,;
        nVLRTOT:=0, nBASICM:=0, nVLRIPI:=0, nVLRICM:=0, nNVEZES:=0,;
        cCONDIC:="S", cCONREV:="I", nFRETE_:=0, nSEGURO:=0, nDESTOT:=0,;
        cPRODIG:="S", cORDEMC:="S", nNATOPE:=0,;
        aORDEMC:= { spac(10), spac(10), spac(10), spac(10), spac(10), spac(10) },;
        nTRANSP:=0, cTDESCR:=spac(20), cTFONE_:=spac(10),;
        cVIATRA:="Rodoviario          ", nPESOLI:=0,;
        nPESOBR:=0, aProdutos:={}, cUNIDAD:=spac(2), nICMCOD:=0, nIPICOD:=0,;
        nCLAFIS:=0, nQTDPRO:=0, nVLRPRO:=0, nPERIPI:=0,;
        nICMPER:=0, nVLPIPI:=0, cCLASSE:="", cMARCA_:=spac(8),;
        cQUANT_:=spac(10), cHORA__:=spac(6), cESPEC_:=spac(8),;
        cOBSER1:=spac(60), cOBSER2:=spac(60),;
        cOBSER3:=spac(60), cOBSER4:=spac(60), cOBSER5:=spac(60),;
        dDATAS_:=ctod("  /  /  "), nITEM:=0, cDESPRO:=spac(40),;
        cCODFAB:=spac(12), cTELAG, nCOMIVT:=0, nCOMIVR:=0, nCOMIVP:=0,;
        nCOMIVV:=0, lFLAG10:=.T., cDP:="",;
        nDupl_A:=nDUPL_B:=nDUPL_C:=nDUPL_D:=0,;
        nPERC_A:=nPERC_B:=nPERC_C:=nPERC_D:=0,;
        nVLR__A:=nVLR__B:=nVLR__C:=nVLR__D:=0,;
        nPRAZ_A:=nPRAZ_B:=nPRAZ_C:=nPRAZ_D:=0,;
        dDTQT_A:=dDTQT_B:=dDTQT_C:=dDTQT_D:=ctod("  /  /  "),;
        dVENC_A:=dVENC_B:=dVENC_C:=dVENC_D:=date(),;
        cQUIT_A:=cQUIT_B:=cQUIT_C:=cQUIT_D:=spac(1),;
        nBANC_A:=nBANC_B:=nBANC_C:=nBANC_D:=0,;
        cCHEQ_A:=cCHEQ_B:=cCHEQ_C:=cCHEQ_D:=spac(15),;
        cOBS__A:=cOBS__B:=cOBS__C:=cOBS__D:=spac(30),;
        cMPRIMA:="*", cISIGLA:=cESIGLA:=cMSIGLA:=spac(2),;
        nICVV__:=0, nECVV__:=0, nMCVV__:=0, nICVP__:=0, nECVP__:=0,;
        nMCVP__:=0, nIBASEV:=0, nEBASEV:=0, nMBASEV:=0, nIBASEP:=0,;
        nEBASEP:=0, nMBASEP:=0, nIVLRVV:=0, nEVLRVV:=0, nMVLRVV:=0,;
        nIVLRVP:=0, nEVLRVP:=0, nMVLRVP:=0, cCODIGO:=spac(12),;
        cDESCOD:=spac(40), nORDEMG:=1, nCODPRO:=0,;
        nCODIGO:=0, aTELA1, aTELA,;
        cPedido:= Spac( 25 )

  UserScreen()
  UserModulo(" Nota Fiscal Por Pedido ")

  IF !AbreGrupo( "NOTA_FISCAL" )
     RETURN NIL
  ENDIF


  SetCursor( 1 )
  setcolor(COR[16])
  scroll(01,01,24-2,MaxCol()-1)
  VPBox( 1, 0, 24 - 2, MaxCol(),, Cor[16], .F., .F., Cor[15] )
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move "+;
        "[ENTER]Opcao [ESC]Cancela")
  dbselectar(_COD_NFISCAL)
  dbseek(999999)
  dbskip(-1)
  nNUMERO:=NUMERO + 1
  SetCursor( 1 )

  setcolor(COR[16]+","+COR[18]+",,,"+COR[17])
  dbselectar(_COD_NFISCAL)

  aOpcoes:= { { " Dados do Cliente          ", 2 },;
              { " Grava                     ", 10 },;
              { " Informacoes diversas      ", 8 } }

  lOk:= .F.
  nRow:= 1
  nOpcao:= 1
  SetColor( "15/04, 00/14" )
  VPBoxSombra( 02, 01, 19, 29,, "15/04", "00/04" )
  oTAB:=tbrowsenew(03,02,18,28)
  oTAB:addcolumn(tbcolumnnew(,{|| aOpcoes[nROW][1] }))
  oTAB:AUTOLITE:=.f.
  oTAB:GOTOPBLOCK :={|| nROW:=1}
  oTAB:GOBOTTOMBLOCK:={|| nROW:=len(aOpcoes)}
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aOpcoes,@nROW)}
  oTAB:dehilite()
  lDelimiters:= Set( _SET_DELIMITERS, .F. )
  WHILE .T.
     WHILE .T.
      oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1})
      WHILE nextkey()==0 .and. ! oTAB:stabilize()
      ENDDO

      IF lOk

         lMouseStatus:= MouseStatus()
         DesligaMouse()

         /* Numero da Nota Fiscal */
         aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ]:= nNumero

         CALCULO( aNFiscal )

         DisplayDados( aNFiscal, aOpcoes[ nRow ][ 2 ] )
         LigaMouse( lMouseStatus )


      ENDIF

      TECLA:= Inkey(0)
      IF TECLA==K_ESC
         nOpcao:= 0
         exit
      ENDIF

      CTELAG:= SCREENSAVE( 0, 0, 24, MAXCOL() )

      DO CASE
         CASE TECLA==K_UP         ;oTAB:up()
         CASE TECLA==K_DOWN       ;oTAB:down()
         CASE TECLA==K_LEFT       ;oTAB:up()
         CASE TECLA==K_RIGHT      ;oTAB:down()
         CASE TECLA==K_PGUP       ;oTAB:pageup()
         CASE TECLA==K_CTRL_PGUP  ;oTAB:gotop()
         CASE TECLA==K_PGDN       ;oTAB:pagedown()
         CASE TECLA==K_CTRL_PGDN  ;oTAB:gobottom()
         CASE TECLA==K_ENTER
              IF !lOk
                 oTab:GoTop()
                 oTab:RefreshAll()
                 WHILE !oTab:Stabilize()
                 ENDDO
                 nOpcao:= 1
              ELSE
                 nOpcao:= IF( !lOk, 1, aOpcoes[ nRow ][ 2 ] )
              ENDIF
              EXIT
         OTHERWISE                ;tone(125); tone(300)
      ENDCASE
      oTAB:refreshcurrent()
      oTAB:stabilize()
   ENDDO
      cTela100:= ScreenSave( 0,0, 24, MaxCol() )
     DO CASE
        CASE nOpcao==1
             VPBoxSombra( 02, 31, 04, 77,, "15/04", "00/04" )
             lEditar:= .T.
             IF cPedido <> SPACE( 20 )
                VPBoxSombra( 02, 31, 06, 77,, "15/04", "00/04" )
                @ 03,33 SAY "Este dado j  foi informado caso vocˆ  altere"
                @ 04,33 SAY "esta informa‡„o os dados da N. Fiscal  ser„o"
                @ 05,33 SAY "Duplicados.                                 "
                INKEY(0)
                Scroll( 02, 31, 06, 77 )
                IF LastKey()==K_ENTER
                   lEditar:= .T.
                ELSE
                   lEditar:= .F.
                ENDIF
             ENDIF
             IF lEditar

                cPedido:= cCodPed + Space( 20 )
                Keyboard Chr( K_ENTER )
                @ 03,33 Say "Pedido(s):" Get cPedido Valid ;
                  SelectPedido( aNFiscal, cPedido )
                READ
                lOk:= PedidoAceito()
                IF Lastkey() == K_ESC
                   lOk:= .F.
                ELSE
                   //oTab:DBGoBottom()
                ENDIF
             ENDIF
        CASE nOpcao==2;             EditDados( aNFiscal, 2 )
        CASE nOpcao==3;             EditDados( aNFiscal, 3 )
        CASE nOpcao==4;             EditDados( aNFiscal, 4 )
        CASE nOpcao==5;             EditDados( aNFiscal, 5 )
        CASE nOpcao==8;             EditDados( aNFiscal, 8 )
        CASE nOpcao==9;             EditDados( aNFiscal, 9 )
        CASE nOpcao==10
             IF Gravacao( aNFiscal )
                AAdd( aOpcoes, { "  ÀÄImpressao da N. Fiscal ", 14 } )
                lRefaz:= .T.
                oTab:Down()
                oTab:Down()
             ENDIF
        CASE nOpcao==14
             Relatorio( "NFISCAL.REP" )
             lRefaz:= .T.
             oTab:Down()
             Keyboard Chr( K_ESC )
        CASE nOpcao==15
             VPCDoc()
             lRefaz:= .T.
             oTab:Down()
        CASE nOpcao==16

             /* Selecao de rodutos para Romaneio */
             aProdSelec:= {{Space(12),Space(13)," "}}
             FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] )

                 cCodPro:= StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 )
                 VisualRomaneio( cCodPro, aProdSelec, aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ] )

             NEXT

             /* Confirma a impressao */
             IF Confirma( 0, 0, "Confirma?", "Confirma a impressao do romaneio?", "S" )

                /* Romaneio */
                DBSelectAr( _COD_ROMANEIO )
                DBSetOrder( 3 )

                /* Impressao */
                Relatorio( "ROMANEIO.REP" )

                /* Nota Fiscal */
                DBSelectAr( _COD_NFISCAL )

             ENDIF

             lRefaz:= .T.

        CASE nOpcao==0
             EXIT
     ENDCASE
     ScreenRest( cTela100 )
     IF lRefaz
        oTab:RefreshAll()
        WHILE !oTab:Stabilize()
        ENDDO
        lRefaz:= .F.
     ENDIF

     IF nOpcao < 10
        ++nOpcao
     ELSE
        nOpcao:= 0
     ENDIF
  ENDDO
  Set( _SET_DELIMITERS, lDelimiters )
  dbunlockall()
  FechaArquivos()
  ScreenRest(cTELA)
  setcursor(nCURSOR)
  setcolor(cCOR)
return nil

Function CALCULO( aNFiscal )
LOCAL nTotalNf:= nTotalIpi:= nBaseIcm:= nBaseIcmTotal:= nTotalIcm:= 0,;
      nIcm:= 0, cTabelaB, nTotalServicos:= 0, nPercISSQN:= SWSet( _GER_PERCISSQN ), ;
      nPercIRRF:= SWSet( _GER_PERCIRRF )
nIcm:= BuscaPerIcm( aNFiscal[ P_CLIENTE ][ CLI_ESTADO ],;
                    aNFiscal[ P_CLIENTE ][ CLI_CONSIND ],;
                    nIcm )
FOR nCt:= 1 To Len( aNFiscal[ P_PRODUTOS ] )
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ]:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ] *;
                                                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ]
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ]:= ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALIPI ] *;
                                                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] ) / 100
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ]

    cTabelaB:= StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAB ], 1, 0 )

        //  @ 06,33 Say "Base ICMs: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ], "@E 99,999,999.99" )
        //  @ 07,33 Say "Vlr.ICMs.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],     "@E 99,999,999.99" )

    DO CASE
       CASE cTabelaB == "0"
            nIcm:= nIcm
       CASE cTabelaB == "3"
            nIcm:= 0
       CASE cTabelaB == "2"

            IF !aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERREDUCAO ] == 0

               /* Cacula o valor de reducao */
               aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VLRREDUCAO ]:= ;
                  ( ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] * ;
                      aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERREDUCAO ] ) / 100 )

               /* Calcula a base de icm com reducao */
               aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ]:= ;
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ] - ;
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VLRREDUCAO ]
            ENDIF
       OTHERWISE
    ENDCASE
    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ]:= nIcm
    nTotalNf+= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ]
    nTotalIpi+= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ]

    /* Se for consumo (Base para ICMs) ser  sobre o ( TOTAL + IPI ) */
    IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] == "C"
       nBaseIcm:= ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ] +;
                    aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ] )
    ELSE
       nBaseIcm:= ( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_BASEICM ] )
    ENDIF
    nBaseIcmTotal+= nBaseIcm
    nTotalIcm+= ( nBaseIcm * aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ] ) / 100
NEXT

FOR nCt:= 1 TO Len( aNFiscal[ P_SERVICOS ] )
    nTotalServicos+= aNFiscal[ P_SERVICOS ][ nCt ][ SER_TOTAL ]
NEXT

aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ]:= nTotalServicos
aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ]:= nPercISSQN
aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ]:= ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] * aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ] ) / 100
aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ]:= nPercIRRF
aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ]:= ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ] ) / 100

aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ]:= nBaseIcmTotal
aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA    ]:= nTotalNf
aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI     ]:= nTotalIpi
aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM     ]:= nTotalIcm
aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL   ]:= nTotalNf + nTotalIpi + nTotalServicos

/* CLACULO DE COMISSOES */
aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAVISTA ]:= ;
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_AVISTA ] ) / 100
aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAPRAZO ]:= ;
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_APRAZO ] ) / 100
aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAVISTA ]:= ;
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_AVISTA ] ) / 100
aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAPRAZO ]:= ;
         ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_APRAZO ] ) / 100



Return .T.


*********************************************************************

STAT Function SelectPedidos( aNFiscal, cPedido )

   //Local nClient, nTransp, dDataEm,;
   //                     nVenIn_, nVenEx_, cConRev )
   Local cTelaReserva
   Local cCor:= SetColor(), nCursor:= SetCursor(),;
         cTela:= ScreenSave( 0, 0, 24, MaxCol() )
   Local nArea:= Select(), nOrdem:= IndexOrd()
   Local aPedidos:= {}, nCt:= 1, cCodigo:= "", aClientes:= {},;
         nPrimeiroCliente:= 0
   Local nValorTotal:= 0,;
         nValorIPI:= 0,;
         nBaseIcm:= 0
   Local nOrdemRes:= 0

   If File( _VPB_PEDIDO ) .AND. File( _VPB_PEDPROD )
      If !FDBUseVpb( _COD_PEDIDO )
         Mensagem("Arquivo de pedidos nao esta disponivel neste momento...")
         Pausa()
         SetColor( cCor )
         SetCursor( nCursor )
         ScreenRest( cTela )
         DBSelectAr( nArea )
         DBSetOrder( nOrdem )
         Return( .F. )
      EndIf
      If !FDBUseVpb( _COD_PEDPROD )
         Mensagem("Arquivo de produtos por pedido nao esta disponivel neste momento...")
         Pausa()
         SetColor( cCor )
         SetCursor( nCursor )
         ScreenRest( cTela )
         DBSelectAr( nArea )
         DBSetOrder( nOrdem )
         PedidoAceito( .F. )
         Return( .F. )
      EndIf
   Else
      Mensagem( "Arquivo de Pedidos nao encontrado..." )
      Pausa()
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      PedidoAceito( .F. )
      Return .F.
   EndIf

   aNFiscal[ P_PEDIDOS ]:= cPedido

   PedidoAceito( .T. )

   DBSelectAr( _COD_PEDIDO )
   DBSetOrder( 6 ) /* Ordem de Numero de pedido */
   For nCt:= 1 To Len( cPedido )
       If SubStr( cPedido, nCt, 1 ) $ ".,;-/*+ "
          If !DBSeek( StrZero( Val( cCodigo ), 8, 0 ) )
             If Val( cCodigo ) <> 0
                cTelaReserva:= ScreenSave( 0, 0, 24, MaxCol() )
                Aviso( "Nao consta o pedido n§ " + cCodigo + " na lista de dispon¡veis...", 12 )
                Mensagem( "Pressione ENTER para continuar...", 1 )
                Pausa()
                ScreenRest( cTelaReserva )
             Endif
          Else
             AAdd( aPedidos, StrZero( Val( cCodigo ), 8, 0 ) )
             AAdd( aClientes, DESCRI )
          Endif
          cCodigo:= ""
       Else
          cCodigo:= cCodigo + SubStr( cPedido, nCt, 1 )
       EndIf
   Next
   IF Len( aPedidos ) = 0
      SetColor( cCor )
      SetCursor( nCursor )
      ScreenRest( cTela )
      PedidoAceito( .F. )
      Return( .F. )
   ELSE
      PedidoAceito( .T. )
   ENDIF

   VpBox( 10, 10, 20, 70, "Pedido(s) selecionado(s)", _COR_GET_BOX,  ,  ,  , .F. )
   FOR nCt:= 1 To Len( aPedidos )
       @ 01,00 SAY NCT
       If ! aPedidos[ nCt ] == "00000000"
          SetColor( _COR_GET_EDICAO )
          @ 11+nCt, 11 Say aPedidos[ nCt ] + " - " + aClientes[ nCt ]

          DBSelectAr( _COD_PEDPROD )
          DBSetOrder( 1 )
          DBSelectAr( _COD_PEDIDO )
          DBSetOrder( 6 ) /* Ordem de Numero de pedido */
          IF DBSeek( aPedidos[ nCt ] )
             If nCt == 1
                nPrimeiroCliente:= CodCli

                /* Dados do Cliente */
                IF Empty( aNFiscal[ P_CLIENTE ] )
                   DBSelectAr( _COD_CLIENTE )
                   nOrdemRes:= indexOrd()
                   DBSetOrder( 1 )
                   DBSelectAr( _COD_PEDIDO )
                   Set Relation To CodCli Into Cli
                   AAdd( aNFiscal[ P_NUMERO ], Val( aPedidos[ 1 ] ) )
                   AAdd( aNFiscal[ P_CLIENTE ], CodCli )
                   AAdd( aNFiscal[ P_CLIENTE ], Descri )
                   AAdd( aNFiscal[ P_CLIENTE ], Endere )
                   AAdd( aNFiscal[ P_CLIENTE ], Bairro )
                   AAdd( aNFiscal[ P_CLIENTE ], SWSet( _CL__CIDADE ) )
                   AAdd( aNFiscal[ P_CLIENTE ], SWSet( _CL__ESTADO ) )
                   AAdd( aNFiscal[ P_CLIENTE ], CodCep )
                   AAdd( aNFiscal[ P_CLIENTE ], CGCMF_ )
                   AAdd( aNFiscal[ P_CLIENTE ], Inscri )
                   AAdd( aNFiscal[ P_CLIENTE ], Cobran )
                   AAdd( aNFiscal[ P_CLIENTE ], SWSet( _CL__CONSIND ) )
                   AAdd( aNFiscal[ P_CLIENTE ], Cli->CPF___ )
                   AAdd( aNFiscal[ P_CLIENTE ], Cli->Fone1_ )
                   DBSelectAr( _COD_CLIENTE )
                   IF ! nOrdemRes == 0
                      DBSetOrder( nOrdemRes )
                   ENDIF
                   DBSelectAr( _COD_PEDIDO )

                   /* Dados da transportadora */
                   AAdd( aNFiscal[ P_TRANSPORTE ], Transp )
                   TRA->( DBSetOrder( 1 ) )
                   TRA->( DBSeek( PED->Transp ) )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Descri )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Endere )
                   AAdd( aNFiscal[ P_TRANSPORTE ], SPACE( 20 ) )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Cidade )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Estado )
                   AAdd( aNFiscal[ P_TRANSPORTE ], SPACE( 08 ) )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->CGCMF_ )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Inscri )
                   AAdd( aNFiscal[ P_TRANSPORTE ], TRA->Fone__ )

                   /* Dados das commissoes */
                   AAdd( aNFiscal[ P_COMISSOES ], { VenIn1, Perc( VenIn1, 1 ), Perc( VenIn1, 2 ), Perc( VenIn1, 3 ), Perc( VenIn1, 4 ), 0, 0, 0, 0, 0, Vende1 } )
                   AAdd( aNFiscal[ P_COMISSOES ], { VenEx1, Perc( VenEx1, 1 ), Perc( VenEx1, 2 ), Perc( VenEx1, 3 ), Perc( VenEx1, 4 ), 0, 0, 0, 0, 0, Vende2 } )

                   /* Dados do Cabecalho da N. Fiscal */
                   AAdd( aNFiscal[ P_CABECALHO ], 0 )
                   AAdd( aNFiscal[ P_CABECALHO ], { SWSet( _NFA_NATOPERA ), PegaNatOpera( SWSet( _NFA_NATOPERA ) ) } )
                   AAdd( aNFiscal[ P_CABECALHO ], Date() )
                   AAdd( aNFiscal[ P_CABECALHO ], SWSet( _NFA_RAZAO ) )
                   AAdd( aNFiscal[ P_CABECALHO ], SWSet( _NFA_VIATRANSP ) )
                   AAdd( aNfiscal[ P_CABECALHO ], PAD( PED->OC__01, 10 ) +;
                                                  PAD( PED->OC__02, 10 ) +;
                                                  PAD( PED->OC__03, 10 ) +;
                                                  PAD( PED->OC__04, 10 ) +;
                                                  PAD( PED->OC__05, 10 ) +;
                                                  PAD( PED->OC__06, 10 ) )

                ENDIF
             ENDIF
             DBSelectAr( _COD_MPRIMA )
             nOrdemRes:= IndexOrd()
             DBSetOrder( 1 )
             /* Dados dos produtos */
             DBSelectAr( _COD_PEDPROD )
             Set Relation To StrZero( CodPro, 7, 0 ) + Space( 5 ) Into MPR
             cCotacao:= PED->Codigo
             DBSetOrder( 1 )
             IF DBSeek( cCotacao )
                WHILE Codigo == cCotacao
                     IF Left( StrZero( CODPRO, 7, 0 ), 3 ) == GrupoServicos
                        AAdd( aNFiscal[ P_SERVICOS ], { CodPro, Descri, VlrUni, VlrUni * Quant_, Quant_ } )
                     ELSE
                        cDescricao:= Descri
                        #ifdef CONECSUL
                            cDescricao:= CodFab + " - " + Descri
                        #endif
                        AAdd( aNFiscal[ P_PRODUTOS ], { CodPro,;
                                                        cDescricao,;
                                                        Unidad,;
                                                        VlrUni,;
                                                        VlrUni * Quant_,;
                                                        MPR->ICMCOD,;
                                                        MPR->IPICOD,;
                                                        MPR->CLAFIS,;
                                                        Quant_,;
                                                        0,;
                                                        IPI___,;
                                                        ICM___,;
                                                        MPR->MPrima,;
                                                        PegaCodFiscal( MPR->ClaFis ),;
                                                        CodFab,;
                                                        Quant_,;
                                                        ( Quant_ * VlrUni ),;
                                                        MPR->PerRed,;
                                                        0,;
                                                        ORIGEM } )

                     ENDIF
                     DBSKip()
                ENDDO
             ENDIF
             IF Len( aNFiscal[ P_PRODUTOS ] ) <= 0
                      AAdd( aNFiscal[ P_PRODUTOS ], { 0, Space( 50 ), Space( 2 ),;
                                                      0, 0,;
                                                      0, 0, 0, 0,;
                                                      0, 0, 0, " ",;
                                                      "          ",;
                                                      Space( 15 ), 0, 0, 0, 0,;
                                                      Space( 15 ) } )
             ENDIF
             Set Relation To
             DBSelectAr( _COD_MPRIMA )
             IF ! nOrdemRes == 0
                DBSetOrder( nOrdemRes )
             ENDIF
             DBSelectAr( _COD_PEDPROD )
             AAdd( aNFiscal[ P_DIVERSOS ], "          " )
             AAdd( aNFiscal[ P_DIVERSOS ], "          " )
             AAdd( aNFiscal[ P_DIVERSOS ], 0 )
             AAdd( aNFiscal[ P_DIVERSOS ], 0 )
             AAdd( aNFiscal[ P_DIVERSOS ], Date() )
             AAdd( aNFiscal[ P_DIVERSOS ], Left( Time(), 2 ) + SubStr( Time(), 4, 2 ) )
             AAdd( aNFiscal[ P_DIVERSOS ], Left( PED->FRETE_, 1 ) )
             AAdd( aNFiscal[ P_DIVERSOS ], 0 )
             AAdd( aNFiscal[ P_DIVERSOS ], 0 )
             AAdd( aNFiscal[ P_DIVERSOS ], { Space(60),;
                                             Space(60),;
                                             Space(60),;
                                             Space(60),;
                                             Space(60),;
                                             } )
             AAdd( aNFiscal[ P_DIVERSOS ], 0 )
             AAdd( aNFiscal[ P_DIVERSOS ], PED->CONDI_ )
             FOR nCt2:= 1 To LEN( aNFiscal[ P_PRODUTOS ] )
                 nValorTotal+= aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_PRECOTOTAL ]
                 nValorIPI+= aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_VALORIPI ]
                 #ifdef CONECSUL
                  IF aNFiscal[ P_PRODUTOS ][ nCt2 ][ PRO_CLAFISCAL ] == 7
                     aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ]:= "CLAS.FISC.85364100 ISENTO DE IPI MED.PROV.1508-16 18/04/97"
                  ENDIF
                 #endif
             NEXT
             IF aNFiscal[ P_CLIENTE ][ CLI_CONSIND ] <> "C"
                nBaseIcm:= nValorTotal + nValorIPI
             ENDIF
             AAdd( aNFiscal[ P_IMPOSTOS ], nValorTotal )             /* IMP_VALORTOTAL   */
             AAdd( aNFiscal[ P_IMPOSTOS ], nValorIpi )               /* IMP_VALORIPI     */
             AAdd( aNFiscal[ P_IMPOSTOS ], nValorTotal + nValorIpi ) /* IMP_VALORNOTA    */
             AAdd( aNFiscal[ P_IMPOSTOS ], nBaseIcm )                /* IMP_VALORBASEICM */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* IMP_VALORICM     */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* servicos */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* issqn */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* valor imposto issqn */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* IRRF */
             AAdd( aNFiscal[ P_IMPOSTOS ], 0 )                       /* valor imposto IRRF */
          ELSE
             DBSelectAr( _COD_CLIENTE )
             nOrdemRes:= indexOrd()
             DBSetOrder( 1 )
             DBSelectAr( _COD_PEDIDO )
             Set Relation To CodCli Into Cli
             aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:= CodCli
             aNfiscal[ P_CLIENTE ][ CLI_DESCRICAO ]:= Space( 40 )
             aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ]:=  Space( 35 )
             aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ]:= Bairro
             aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]:= SWSet( _CL__CIDADE )
             aNFiscal[ P_CLIENTE ][ CLI_ESTADO ]:= SWSet( _CL__ESTADO )
             aNFiscal[ P_CLIENTE ][ CLI_CEP ]:= CodCep
             aNFiscal[ P_CLIENTE ][ CLI_CGC ]:= CGCMF_
             aNfiscal[ P_CLIENTE ][ CLI_INSCRICAO ]:= Inscri
             aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ]:= Cobran
             aNFiscal[ P_CLIENTE ][ CLI_CONSIND ]:=  SWSet( _CL__CONSIND )
             aNFiscal[ P_CLIENTE ][ CLI_CPF ]:= Space( 11 )
             aNFiscal[ P_CLIENTE ][ CLI_FONE ]:= Cli->FONE1_
             DBSelectAr( _COD_CLIENTE )
             IF ! nOrdemRes == 0
                  DBSetOrder( nOrdemRes )
             ENDIF
             DBSelectAr( _COD_PEDIDO )
          ENDIF
       ENDIF
   NEXT
   SetColor( cCor )
   SetCursor( nCursor )
   ScreenRest( cTela )
   DBCloseArea()
   DBSelectAr( _COD_PEDPROD )
   DBCloseArea()
   DBSelectAr( nArea )
   IF Used()
      DBSetOrder( nOrdem )
   ENDIF
   RETURN .T.

*******************************************************************************
Static Function tiponf( cPVAR, nPMODULO, cTelaG )
Local cTELA:=ScreenSave(00,00,24,79), nCURSOR:=setcursor(), cCOR:=setcolor()
if nPMODULO=1
   ScreenRest( cTelaG )
   Mensagem("Digite o tipo de nota fiscal...")
   setcolor( Cor[ 25 ] )
   vpbox(02,39,07,59,,COR[24],.F.,.F.,COR[23])
   @ 03,40 say " U = Serie Unica   "
   @ 04,40 say " B = Balcao        "
   @ 05,40 say " S = Servico       "
   @ 06,40 say " P = Pedido        "
endif
setcolor(cCOR)
return(.T.)

*******************************************************************************
Static Function EditCliente( cPVAR, nPMODULO, ALTERA,;
       cCGCMF_, cINSCRI, cDESCRI, cENDERE, cBAIRRO, cCODCEP,;
       cCIDADE, cESTADO, cCOBRAN, cCONREV, cTelaG )
Local cTELA:=ScreenSave(00,00,24,79), nCURSOR:=setcursor(), cCOR:=setcolor(),;
     nAREA:=select(), nORDEM:=indexord(), oTB, TECLA, GETLIST:={}
if teclainativa()
   return(.F.)
endif
dbselectar(_COD_CLIENTE)
dbsetorder(1)
ScreenRest(cTELAG)
if nPMODULO=1
   if lastkey()=K_UP .OR. lastkey()=K_DOWN
      dbselectar(nAREA)
      dbsetorder(nORDEM)
      setcolor(cCOR)
      return(.T.)
   endif
   setcolor(COR[25])
   vpbox(02,39,12,77,"Cliente",COR[24],.F.,.F.,COR[23])
   if cPVAR=0
      set(_SET_DELIMITERS,.F.)
      set(_SET_ESCAPE,.F.)
      @ 03,40 say "" get cDESCRI pict "@S35"
      @ 04,40 say "CPF.....:" get cCPF___ pict "@R 999.999.999-99"
      @ 05,40 say "End.....:" get cENDERE pict "@S26"
      @ 06,40 say "Cidade..: [" + cCIDADE + "]"
      @ 07,40 say "Estado..: [" + cESTADO + "]"
      @ 08,40 say "Cobranca: [O MESMO                           ]"
      read
      if cESTADO="RS"
         nNATOPE=5.12
      else
         nNATOPE=6.12
      endif
      set(_SET_DELIMITERS,.T.)
      set(_SET_ESCAPE,.T.)
      dbselectar(nAREA)
      dbsetorder(nORDEM)
      setcolor(cCOR)
      return(.T.)
   endif
   if dbseek(cPVAR)
      cCGCMF_:=CGCMF_
      cINSCRI:=INSCRI
      cDESCRI:=DESCRI
      cENDERE:=ENDERE
      cBAIRRO:=BAIRRO
      cCODCEP:=CODCEP
      cCIDADE:=CIDADE
      cESTADO:=ESTADO
      cCOBRAN:=COBRAN
      cCONREV:=CONIND
      set(_SET_DELIMITERS,.F.)
      set(_SET_ESCAPE,.F.)
      @ 03,40 say "" get cDESCRI pict "@S35"
      @ 04,40 say "CGC.....:" get cCGCMF_ pict "@R 99.999.999/9999-99" valid cgcmf(cCGCMF_)
      @ 05,40 say "Insc.Est:" get cINSCRI
      @ 06,40 say "End.....:" get cENDERE pict "@S26"
      @ 07,40 say "Bairro..:" get cBAIRRO
      @ 08,40 say "CEP.....:" get cCODCEP pict "@R 99-999.999"
      @ 09,40 say "Cidade..:" get cCIDADE pict "@S26"
      @ 10,40 say "Estado..:" get cESTADO pict "XX" valid veruf(@cESTADO)
      read
      if updated()
         nCLIENT:=0
      endif
      @ 11,40 say "Cobranca:" get cCOBRAN pict "@S26"
      read
      if ALTERA=NIL
         nTRANSP:=TRANSP
         nVENIN_:=VENIN1
         nVENEX_:=VENEX2
      endif
      if cESTADO="RS"
         nNATOPE=5.12
      else
         nNATOPE=6.12
      endif
      set(_SET_ESCAPE,.T.)
      set(_SET_DELIMITERS,.T.)
   else
      vpbox(02,39,12,77,"Cliente",COR[24],.F.,.F.,COR[23])
      vpbox(12,39,20,77,"Selecao de Cliente",COR[24],.F.,.F.,COR[23])
      dbgotop()
      setcursor(0)
      setcolor(COR[25]+","+COR[22]+",,,"+COR[17])
      Mensagem("Pressione [ENTER] p/ selecionar.")
      ajuda("["+_SETAS+"][PgUp][PgDn]Move "+;
            "[F2]Pesquisa [F3]Codigo [F4]Nome")
     oTB:=tbrowsedb(13,40,19,76)
     oTB:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" -> "+DESCRI }))
     oTB:AUTOLITE:=.f.
     oTB:dehilite()
     whil .t.
         oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
         whil nextkey()=0 .and.! oTB:stabilize()
         enddo
         setcolor(COR[25])
         @ 03,40 say " "+substr(DESCRI,1,35)
         @ 04,40 say "CGC.....: "+tran(CGCMF_,"@R 99.999.999/9999-99")
         @ 05,40 say "Insc.Est: "+INSCRI
         @ 06,40 say "End.....: "+substr(ENDERE,1,26)
         @ 07,40 say "Bairro..: "+BAIRRO
         @ 08,40 say "CEP.....: "+tran(CODCEP,"@R 99-999.999")
         @ 09,40 say "Cidade..: "+substr(CIDADE,1,26)
         @ 10,40 say "Estado..: "+ESTADO
         @ 11,40 say "Cobranca: "+substr(COBRAN,1,26)
         nCLIENT=CODIGO
         TECLA:=inkey(0)
         if TECLA=K_ESC
            nCLIENT=0
            set(_SET_ESCAPE,.F.)
            set(_SET_DELIMITERS,.F.)
            @ 03,40 say "" get cDESCRI pict "@S35"
            @ 04,40 say "CGC.....:" get cCGCMF_ pict "@R 99.999.999/9999-99" valid cgcmf(cCGCMF_)
            @ 05,40 say "Insc.Est:" get cINSCRI
            @ 06,40 say "End.....:" get cENDERE pict "@S26"
            @ 07,40 say "Bairro..:" get cBAIRRO
            @ 08,40 say "CEP.....:" get cCODCEP pict "@R 99-999.999"
            @ 09,40 say "Cidade..:" get cCIDADE pict "@S26"
            @ 10,40 say "Estado..:" get cESTADO valid veruf(@cESTADO)
            @ 11,40 say "Cobranca:" get cCOBRAN pict "@S26"
            read
            set(_SET_DELIMITERS,.T.)
            set(_SET_ESCAPE,.T.)
            exit
         endif
         do case
            case TECLA==K_UP         ;oTB:up()
            case TECLA==K_LEFT       ;oTB:up()
            case TECLA==K_RIGHT      ;oTB:down()
            case TECLA==K_DOWN       ;oTB:down()
            case TECLA==K_PGUP       ;oTB:pageup()
            case TECLA==K_PGDN       ;oTB:pagedown()
            case TECLA==K_CTRL_PGUP  ;oTB:gotop()
            case TECLA==K_CTRL_PGDN  ;oTB:gobottom()
            case TECLA==K_F2
            case chr(TECLA)$"1234567890"
                 cTELAR0:=ScreenSave(10,00,24,79)
                 Set(_SET_SOFTSEEK,.T.)
                 nCOD:=0
                 Keyboard chr(TECLA)
                 vpbox(11,25,13,48,"",COR[20],.T.,.F.,COR[19])
                 @ 12,26 say "C¢digo " get nCOD pict "999999" when mensagem("Digite o c¢digo para pesquisa.")
                 read
                 mensagem("Executando a pesquisa pelo codigo, aguarde...")
                 dbsetorder(1)
                 dbseek(nCOD)
                 Set(_SET_SOFTSEEK,.F.)
                 ScreenRest(cTELAR0)
                 oTB:RefreshAll()
                 Whil ! oTB:Stabilize()
                 EndDo
                 nORDEMG=1
            case Upper(chr(TECLA))$"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                 cTELAR0:=ScreenSave(10,00,24,79)
                 Set(_SET_SOFTSEEK,.T.)
                 cDESC:=Spac(45)
                 Keyboard upper(chr(TECLA))
                 vpbox(11,16,13,63,"",COR[20],.T.,.F.,COR[19])
                 @ 12,17 say "Nome " get cDESC pict "@S35" when mensagem("Digite o nome para pesquisa.")
                 read
                 mensagem("Executando a pesquisa pela descricao, aguarde...")
                 dbsetorder(2)
                 dbseek(upper(cDESC),.T.)
                 ScreenRest(cTELAR0)
                 oTB:RefreshAll()
                 Whil ! oTB:Stabilize()
                 EndDo
                 nORDEMG=2
            case TECLA==K_F3         ;organiza(oTB,1)
            case TECLA==K_F4         ;organiza(oTB,2)
            case TECLA==K_ENTER .OR. TECLA=K_TAB
                 cCGCMF_:=CGCMF_
                 cINSCRI:=INSCRI
                 cDESCRI:=DESCRI
                 cENDERE:=ENDERE
                 cBAIRRO:=BAIRRO
                 cCODCEP:=CODCEP
                 cCIDADE:=CIDADE
                 cESTADO:=ESTADO
                 cCOBRAN:=COBRAN
                 cCONREV:=CONIND
                 set(_SET_DELIMITERS,.F.)
                 set(_SET_ESCAPE,.F.)
                 @ 03,40 say "" get cDESCRI pict "@S35"
                 @ 04,40 say "CGC.....:" get cCGCMF_ pict "@R 99.999.999/9999-99" valid cgcmf(cCGCMF_)
                 @ 05,40 say "Insc.Est:" get cINSCRI
                 @ 06,40 say "End.....:" get cENDERE pict "@S26"
                 @ 07,40 say "Bairro..:" get cBAIRRO
                 @ 08,40 say "CEP.....:" get cCODCEP pict "@R 99-999.999"
                 @ 09,40 say "Cidade..:" get cCIDADE pict "@S26"
                 @ 10,40 say "Estado..:" get cESTADO valid veruf(@cESTADO)
                 read
                 if updated()
                    nCLIENT:=0
                 endif
                 @ 11,40 say "Cobranca:" get cCOBRAN pict "@S26"
                 read
                 nTRANSP:=TRANSP
                 nVENIN_:=VENIN1
                 nVENEX_:=VENEX2
                 if cESTADO="RS"
                    nNATOPE=5.12
                 else
                    nNATOPE=6.12
                 endif
                 set(_SET_ESCAPE,.T.)
                 set(_SET_DELIMITERS,.T.)
                 exit
            otherwise                ;tone(125); tone(300)
         endcase
         oTB:refreshcurrent()
         oTB:stabilize()
     enddo
     setcursor(nCURSOR)
   endif
else
   if lastkey()=K_UP .OR. lastkey()=K_DOWN
      ScreenRest(cTELAG)
      setcolor(COR[25])
      vpbox(02,39,12,77,"Cliente",COR[24],.F.,.F.,COR[23])
      @ 03,40 say " "+substr(cDESCRI,1,35)
      @ 04,40 say "CGC.....: "+tran(cCGCMF_,"@R 99.999.999/9999-99")
      @ 05,40 say "Insc.Est: "+cINSCRI
      @ 06,40 say "End.....: "+substr(cENDERE,1,26)
      @ 07,40 say "Bairro..: "+cBAIRRO
      @ 08,40 say "CEP.....: "+tran(cCODCEP,"@R 99-999.999")
      @ 09,40 say "Cidade..: "+substr(cCIDADE,1,26)
      @ 10,40 say "Estado..: "+cESTADO
      @ 11,40 say "Cobranca: "+substr(cCOBRAN,1,26)
      dbselectar(nAREA)
      dbsetorder(nORDEM)
      setcolor(cCOR)
      return(.T.)
   endif
endif
dbselectar(nAREA)
dbsetorder(nORDEM)
setcolor(cCOR)
return(.T.)

*******************************************************************************
Static Function edittransp( cPVAR, nPMODULO, cTDescr, cTFone_, cTelaG )
Local cTELA:=ScreenSave(00,00,24,79), nCURSOR:=setcursor(), cCOR:=setcolor(),;
     nAREA:=select(), oTB, TECLA, GETLIST:={}
if teclainativa()
   return(.F.)
endif
dbselectar(_COD_TRANSPORTE)
if nPMODULO=1
   if lastkey()=K_UP .OR. lastkey()=K_DOWN
      dbselectar(nAREA)
      setcolor(cCOR)
      return(.T.)
   endif
   ScreenRest(cTELAG)
   setcolor(COR[25])
   vpbox(02,39,05,77,"Transportadora",COR[24],.F.,.F.,COR[23])
   if cPVAR=0
      set(_SET_DELIMITERS,.F.)
      set(_SET_ESCAPE,.F.)
      @ 03,40 say "Transp..:" get cTDESCR pict "@S20"
      @ 04,40 say "Fone....:" get cTFONE_ pict "@R 999-999.99.99"
      read
      set(_SET_DELIMITERS,.T.)
      set(_SET_ESCAPE,.T.)
      dbselectar(nAREA)
      setcolor(cCOR)
      return(.T.)
   endif
   if dbseek(cPVAR)
      cTDESCR:=DESCRI
      cTFONE_:=FONE__
      set(_SET_DELIMITERS,.F.)
      set(_SET_ESCAPE,.F.)
      @ 03,40 say "Transp..:" get cTDESCR pict "@S20"
      @ 04,40 say "Fone....:" get cTFONE_ pict "@R 999-999.99.99"
      read
      set(_SET_ESCAPE,.T.)
      set(_SET_DELIMITERS,.T.)
   else
      vpbox(02,39,05,77,"Transportadora",COR[24],.F.,.F.,COR[23])
      vpbox(06,39,20,77,"Selecao de Transportadora",COR[24],.F.,.F.,COR[23])
      dbgotop()
      setcursor(0)
      setcolor(COR[25]+","+COR[22]+",,,"+COR[17])
      Mensagem("Pressione [ENTER] p/ selecionar.")
      ajuda("["+_SETAS+"][PgUp][PgDn]Move "+;
            "[F2]Pesquisa [F3]Codigo [F4]Nome")
     oTB:=tbrowsedb(07,40,19,76)
     oTB:addcolumn(tbcolumnnew(,{|| strzero(CODIGO,4,0)+" -> "+DESCRI }))
     oTB:AUTOLITE:=.f.
     oTB:dehilite()
     whil .t.
         oTB:colorrect({oTB:ROWPOS,1,oTB:ROWPOS,1},{2,1})
         whil nextkey()=0 .and.! oTB:stabilize()
         enddo
         setcolor(COR[25])
         @ 03,40 say "Transp..: "+substr(DESCRI,1,26)
         @ 04,40 say "Fone....: "+tran(FONE__,"@R 999-999.99.99")
         nTRANSP=CODIGO
         TECLA:=inkey(0)
         if TECLA=K_ESC
            nCLIENT=0
            set(_SET_ESCAPE,.F.)
            set(_SET_DELIMITERS,.F.)
            @ 03,40 say "Transp..:" get cTDESCR pict "@S20"
            @ 04,40 say "Fone....:" get cTFONE_ pict "@R 999-999.99.99"
            read
            set(_SET_DELIMITERS,.T.)
            set(_SET_ESCAPE,.T.)
            exit
         endif
         do case
            case TECLA==K_UP         ;oTB:up()
            case TECLA==K_LEFT       ;oTB:up()
            case TECLA==K_RIGHT      ;oTB:down()
            case TECLA==K_DOWN       ;oTB:down()
            case TECLA==K_PGUP       ;oTB:pageup()
            case TECLA==K_PGDN       ;oTB:pagedown()
            case TECLA==K_CTRL_PGUP  ;oTB:gotop()
            case TECLA==K_CTRL_PGDN  ;oTB:gobottom()
            case TECLA==K_F2
                 mBUSCA:=smBUSCA
                 smBUSCA:={{" 1 Codigo de transp.   ",;
                            "Pesquisa pelo codigo da transportadora."},;
                           {" 2 Nome da transp.     ",;
                            "Pesquisa pelo nome da transportadora."}}
                 pesquisa(oTB)
                 smBUSCA:=mBUSCA
            case TECLA==K_F3         ;organiza(oTB,1)
            case TECLA==K_F4         ;organiza(oTB,2)
            case TECLA==K_ENTER .OR. TECLA=K_TAB
                 cTDESCR:=DESCRI
                 cTFONE_:=FONE__
                 set(_SET_DELIMITERS,.F.)
                 set(_SET_ESCAPE,.F.)
                 @ 03,40 say "Transp..:" get cTDESCR pict "@S20"
                 @ 04,40 say "Fone....:" get cTFONE_ pict "@R 999-999.99.99"
                 read
                 set(_SET_ESCAPE,.T.)
                 set(_SET_DELIMITERS,.T.)
                 exit
            otherwise                ;tone(125); tone(300)
         endcase
         oTB:refreshcurrent()
         oTB:stabilize()
     enddo
     setcursor(nCURSOR)
   endif
else
   ScreenRest(cTELAG)
   SetColor( COR[25] )
   VPBox(02,39,05,77,"Transportadora",COR[24],.F.,.F.,COR[23])
   @ 03,40 say "Transp..: " + cTDESCR
   @ 04,40 say "Fone....: " + Tran( cTFONE_, "@R 999-999.99.99" )
endif
dbselectar(nAREA)
setcolor(cCOR)
return(.T.)


************************************************************************
Static Function pesquisanf(CODIGO)
Local cTELA:=ScreenSave(00,00,24,79)
if dbseek(CODIGO)
   aviso("Codigo j  cadastrado...",24/2)
   Mensagem("Esta nota fiscal j  existe, pressione [ENTER] p/ continuar...",1)
   Pausa()
   ScreenRest(cTELA)
   return(.F.)
endif
return(.T.)

************************************************************************
Static Function teclainativa()
if lastkey()=K_PGUP .OR. lastkey()=K_PGDN
   Mensagem("ATENCAO! Nao ‚ poss¡vel finalizar a ent. dados c/ [PgDn/PgUp].",1)
   Pausa()
   return(.T.)
endif
return(.F.)

************************************************************************
Static Function dataemissao( dDATA, lFlag10 )
Local cTELA:=ScreenSave(00,00,24,MaxCol())
Local nORDEM:=indexord(), cCOR:=setcolor()
if lFLAG10
   dbsetorder(3)
   set filter to NFNULA<>"*"
   dbgobottom()
   lFLAG10:=.F.
   if (dDATA>DATAEM)
      vpbox(07,39,12,75,"Aten‡ao","15/04",.T.,.F.,"04/15")
      setcolor("15/04")
      @ 08,40 say "      Esta nota est  com data      "
      @ 09,40 say " maior que a ultima data existente "
      @ 10,40 say "       úúùÍÍÍÍÍ * ÍÍÍÍÍùúú         "
      @ 11,40 say "                                   "
      @ 11,40 say "      DIFERENCA DE "+alltrim(str(dDATA-DATAEM,3,0))+" DIA(S)."
      setcolor(cCOR)
   elseif (dDATA<DATAEM)
      aviso("Data de emissao est  MENOR que ultima data.",(24/2)-1)
      aviso("        DATA DIGITADA SERA ALTERADA        ",(24/2)+2)
      Mensagem("Pressione [ENTER] para continuar a digitacao...")
      Pausa()
      dDATA=DATAEM
      dbsetorder(nORDEM)
      ScreenRest(cTELA)
      return(.F.)
   endif
   set filter to
endif
return(.T.)

Static Function Calculos( cPCR, nPMOD, lATIVAPROD, nAlteracao, ;
            cEstado, nBasIcm, nIcmPer, nVlrIcm, nVlrNot, nVltPro,;
            nQtdPro, nVlrPro, nVlpIpi, npBaIcm, nVlrRed, nPerRed,;
            nVluIcm )
Local GetList:= {}
If ( cPCR<>"C" .AND. cPCR<>"I" ) .OR. teclainativa()
   return(.F.)
endif
if cESTADO="RS"                           && ICMs no estado!
   IF nPerIcm == 0
      nPerIcm:=17.00
      nIcmPer:=17.00
   ENDIF
else                                      && ICMs fora do estado!
   IF nPerIcm == 0
      nPerIcm:=12.00
      nIcmPer:=12.00
   ENDIF
endif
do case
   case nPMOD=1
        /* Esta linha de comando estava desabilitada */
        nVLRICM:=(nBASICM*nICMPER)/100
        if lATIVAPROD
           If nAlteracao <> Nil
              produtosAltera()
           Else
              Produtos()
           EndIf
           diversos()
        endif
   case nPMOD=2
        nVLRTOT:=nVLRIPI+nVLRNOT          && Valor total da NF.
   case nPMOD=3

   case nPMOD=4

        nVltPro:= nQtdPro * nVlrPro

   case nPMOD=5
        If nPerIpi<>0
           nVlpIpi:= ( nVltPro * nPerIpi ) / 100
        Else
           nVlpIpi:= 0
        Endif
   case nPMOD=6
        If cConRev=="C"
           nPBaIcm:= nVltPro + nVlpIpi
        Else
           nPBaIcm:= nVltPro
        EndIf
        nVlrRed:= 0
        nPerRed:= MPr->PerRed
        If nIpiCod == 2
           cTelaRes:= ScreenSave( 0, 0, 24, MaxCol() )
           VPBox( 09, 10, 14, 52, "Reducao de ICMs", _COR_ALERTA_BOX, .T., .T., _COR_ALERTA_TITULO )
           SetColor( _COR_ALERTA_LETRA )
           @ 10,11 Say "Base de Calculo ICMs.:" + Tran( nPBaIcm, "@E 999,999,999.99" )
           @ 11,11 Say "Percentual de Reducao:" Get nPerRed Pict "@E 999.99"
           @ 12,11 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
           Read
           nVlrRed:= ( nPBaIcm * nPerRed ) / 100
           @ 13,11 Say "Valor Base de Calculo:" + Tran( nPBaIcm:= nVltPro - nVlrRed, "@E 999,999,999.99" )
           Mensagem( "Pressione [ENTER] para continuar..." )
           Pausa(0)
           ScreenRest( cTelaRes )
           SetColor( _COR_GET_EDICAO )
        EndIf
        If nIpiCod <> 4
           nVlUIcm:= ( nPBaIcm * nPerIcm ) / 100
        Else
           nVlUIcm:= 0
        Endif
endcase
return(.T.)


/*
**
** PRODUTOS_aLTERA
**
*/
Static Function ProdutosAltera( aOrdemC )
  Local GetList:= {}
  Local oTab
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, MaxCol() )
  Local nArea:= Select(), nOrdem:= IndexOrd()
  If LastKey()=K_UP .or. lastkey()=K_DOWN; Return(.T.)
  EndIf
  Ajuda("["+_SETAS+"][PgDn][PgUp]Move [ESC]Retorna")
  Mensagem("Pressione [ESC] para retornar.")
  VPBox( 01, 06, 24 - 3, 71, "Ordem de Compra", _COR_GET_BOX, .T., .T., _COR_GET_TITULO )
  VPBox( 04, 07, 17, 70, "Produtos", _COR_GET_BOX, .F., .F., _COR_GET_TITULO )
  DBSelectAr(_COD_MPRIMA)
  DBSetOrder( 1 )
  @ 02,08 Say "Ordens de Compra:" get aORDEMC[1]
  @ 02,38 Get aORDEMC[2]
  @ 02,50 Get aORDEMC[3]
  @ 03,09 Say "                " get aORDEMC[4]
  @ 03,38 Get aORDEMC[5]
  @ 03,50 Get aORDEMC[6]
  Read

  cGrupo_:= "000"
  cCodigo:= "0000"

  DBSelectAr( _COD_PRODNF )
  DBSetOrder( 5 )
  DBSeek( Nf_->Numero )
  aProd:= {}
  nItem:= 0
  Mensagem( "Pesquisando produtos, Aguarde..." )
  While Pnf->CodNf_== nf_->Numero
      AAdd( aProd, { ++nItem, CodRed, Descri, Unidad, IcmCod,;
                      IpiCod, ClaFis, Quant_, Precov, Precot,;
                      PerIpi, IPI___,       , Mprima, PerIcm,;
                      VlrIcm, BasIcm, PerRed, VlrRed } )
      DBSkip()
  EndDo

  Mensagem( "Pressione [ENTER] para alterar ou [ESC] para sair..." )
  Ajuda( "[PgUp][PgDn][" + _SETAS + "]Movimenta, [F2]Inclui, [ENTER]Altera..." )
  nRow:= 1
  cTelaReserva:= ScreenSave( 0, 0, 24, MaxCol() )
  SetColor( _COR_BROWSE )
  vpbox( 17, 07, 24 - 4, 70, "Produtos desta nota fiscal", COR[20], .F., .F., COR[19] )
  oTAB:=tbrowsenew( 18, 08, 24 - 5, 69 )
  oTAB:addcolumn(tbcolumnnew(,{|| StrZero( aProd[ nRow ][1], 2, 0 ) + " "+ ;
                                  Tran( aProd[ nRow ][2], "@R XXX-XXXX" ) + " " +;
                                  aProd[ nRow ][ 3 ] + " " + ;
                                  Tran( aProd[ nRow ][ 8 ], "@E 999,999.999" ) } ) )
  oTAB:AUTOLITE:=.f.
  oTAB:GOTOPBLOCK :={|| nRow:= 1 }
  oTAB:GOBOTTOMBLOCK:={|| nRow:= len( aProd ) }
  oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr( WTOJUMP, aProd, @nROW ) }
  oTAB:dehilite()
  whil .t.
     oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1})
     whil nextkey()==0 .and. ! oTAB:stabilize()
     end
     SetColor( _COR_GET_LETRA )
     nItem:= aProd[ nRow ][ 1 ]
     @ 05,08 Say "Item....: "+strzero(nItem,2,0)
     @ 06,08 Say "Produto.: [" + Left( aProd[ nItem ][ 2 ], 3 ) + "]-[" + SubStr( aProd[ nItem ][ 2 ], 4, 4 ) + "]"
     @ 07,08 Say "Descr...: [" + aProd[ nItem ][ 3 ] + "]"
     @ 08,08 Say "Unidade.: [" + aProd[ nItem ][ 4 ] + "]"
     @ 09,08 Say "C.Fiscal: [" + StrZero( aProd[ nItem ][ 5 ], 3, 0 ) + "]"
     @ 10,08 Say "CD.TB01.: [" + Str( aProd[ nItem ][ 6 ], 1, 0 ) + "]"
     @ 11,08 Say "CD.TB02.: [" + Str( aProd[ nItem ][ 7 ], 1, 0 ) + "]"
     @ 12,08 Say "Quantia.: [" + Tran( aProd[ nItem ][ 8 ], "@E 999,999.999" ) + "]"
     @ 13,08 Say "Vlr.Unit: [" + Tran( aProd[ nItem ][ 9 ], "@E 999,999,999.999" ) + "]"
     @ 14,08 Say "Vl.Total: [" + Tran( aProd[ nItem ][ 10 ], "@E 999,999,999.999" ) + "]"
     @ 15,08 Say "% IPI...: [" + Tran( aProd[ nItem ][ 11 ], "999.99" ) + "]"
     @ 16,08 Say "Vlr.IPI.: [" + Tran( aProd[ nItem ][ 12 ], "@E 999,999,999.99" ) + "]"
     /* Calculo do ICMs */
     @ 15,40 Say "% ICMs..: [" + Tran( aProd[ nItem ][ 15 ], "999.99" ) + "]"
     @ 16,40 Say "Vlr.ICMs: [" + Tran( aProd[ nItem ][ 16 ], "@E 999,999,999.99" ) + "]"
     SetColor( _COR_BROWSE )
     TECLA:=inkey(0)
     if TECLA==K_ESC   ;exit   ;endif
     do case
        case TECLA==K_UP         ;oTAB:up()
        case TECLA==K_DOWN       ;oTAB:down()
        case TECLA==K_LEFT       ;oTAB:up()
        case TECLA==K_RIGHT      ;oTAB:down()
        case TECLA==K_PGUP       ;oTAB:pageup()
        case TECLA==K_CTRL_PGUP  ;oTAB:gotop()
        case TECLA==K_PGDN       ;oTAB:pagedown()
        case TECLA==K_CTRL_PGDN  ;oTAB:gobottom()
        Case TECLA==K_ENTER .OR.;
             TECLA==K_F3
             cCorRes2:= SetColor()
             cTelaRes2:= ScreenSave( 0, 0, 24, MaxCol() )
             SetCursor(1)
             ScreenRest( cTelaReserva )
             SetColor( _COR_GET_EDICAO )
             nItem:= aProd[ nRow ][ 1 ]
             nCODPRO:= aProd[ nItem ][2]
             cDESPRO:= aProd[ nItem ][3]
             cUNIDAD:= aProd[ nItem ][4]
             nICMCOD:= aProd[ nItem ][5]
             nIPICOD:= aProd[ nItem ][6]
             nCLAFIS:= aProd[ nItem ][7]
             nQTDPRO:= aProd[ nItem ][8]
             nVLRPRO:= aProd[ nItem ][9]
             nVLTPRO:= aProd[ nItem ][10]
             nPERIPI:= aProd[ nItem ][11]
             nVLPIPI:= aProd[ nItem ][12]
             cCLASSE:= aProd[ nItem ][13]
             cMPRIMA:= aProd[ nItem ][14]
             nPerIcm:= aProd[ nItem ][15]
             nVlUIcm:= aProd[ nItem ][16]
             cGrupo_:= LEFT( aProd[ nItem ][ 2 ], 3 )
             cCodigo:= SubStr( aProd[ nItem ][ 2 ], 4, 4 )
             @ 05,08 Say "Item....: "+strzero(nItem,2,0)
             @ 06,08 Say "Produto.:" Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo )
             @ 06,23 Say "-"
             @ 06,24 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList ) when mensagem("Digite o c¢digo do produto.")
             @ 07,08 Say "Descr...:" Get cDesPro Pict "@S30" Valid VerDescricao( cDesPro, GetList ) When Mensagem("Digite a descricao do produto.")
             @ 08,08 Say "Unidade.:" Get cUnidad Pict "@!" When Mensagem("Digite a unidade do produto.")
             @ 09,08 Say "C.Fiscal:" Get nClaFis Pict "999" valid VerClasse( @nClaFIs ) When Mensagem("Digite a classificacao.")
             @ 10,08 Say "Cd.TB01.:" Get nIcmCod Pict "9" Valid ClassTrib( @nIcmCod, 1 ) When Mensagem("Digite o codigo tribut vel do produto.")
             @ 11,08 Say "Cd.TB02.:" Get nIpiCod Pict "9" Valid ClassTrib( @nIpiCod, 2 ) When Mensagem("Digite o codigo do IPI.")
             @ 12,08 Say "Quantia.:" Get nQtdPro Pict "@E 999,999.999" Valid Calculos( cConRev, 4 ) When Mensagem( "Digite a quantidade de produtos solicitada." )
             @ 13,08 Say "Vlr.Unit:" Get nVlrPro Pict "@E 999,999,999.999" Valid Calculos( cConRev, 4 )
             @ 14,08 Say "Vl.Total:" Get nVltPro Pict "@E 999,999,999.999"
             @ 15,08 Say "% IPI...:" Get nPerIpi Pict "999.99" valid Calculos( cConRev, 5 )
             @ 16,08 Say "Vlr.IPI.:" Get nVlpIpi Pict "@E 999,999,999.99"
             /* Calculo do ICMs */
             @ 15,40 Say "% ICMs..:" Get nPerIcm Pict "999.99" Valid Calculos( cConRev, 6 )
             @ 16,40 Say "Vlr.ICMs:" Get nVlUIcm Pict "@E 999,999,999.99"
             Read

             If cDesPro <> cDP
                nCodPro:= 0
             Endif
             if nClaFis = 7 .AND. !lFLAGM
                lOBSERVACOES:=.T.
             endif
             nAREA:= Select()
             DBSelectAr( _COD_CLASFISCAL )
             DBSeek( nClaFis )
             cClasse:= CodFis
             DBSelectAr( nArea )
             nItem:= aProd[ nRow ][ 1 ]
             if nITEM<=12 .AND. lastkey()<>K_ESC
                aPRODUTOS[nITEM][2]:= cGrupo_ + cCodigo
                aPRODUTOS[nITEM][3]:= cDESPRO
                aPRODUTOS[nITEM][4]:= cUNIDAD
                aPRODUTOS[nITEM][5]:= nICMCOD
                aPRODUTOS[nITEM][6]:= nIPICOD
                aPRODUTOS[nITEM][7]:= nCLAFIS
                aPRODUTOS[nITEM][8]:= nQTDPRO
                aPRODUTOS[nITEM][9]:= nVLRPRO
                aPRODUTOS[nITEM][10]:= nVLTPRO
                aPRODUTOS[nITEM][11]:= nPERIPI
                aPRODUTOS[nITEM][12]:= nVLPIPI
                aPRODUTOS[nITEM][13]:= cCLASSE
                aPRODUTOS[nITEM][14]:= cMPRIMA
                aProdutos[ nItem ][ 15 ]:= nPerIcm
                aProdutos[ nItem ][ 16 ]:= nVlUIcm
                aProdutos[ nItem ][ 17 ]:= nPBaIcm
                aProdutos[ nItem ][ 18 ]:= nPerRed
                aProdutos[ nItem ][ 19 ]:= nVlrRed
                aPROD[nITEM][2]:= cGrupo_ + cCodigo
                aPROD[nITEM][3]:=cDESPRO
                aPROD[nITEM][4]:=cUNIDAD
                aPROD[nITEM][5]:=nICMCOD
                aPROD[nITEM][6]:=nIPICOD
                aPROD[nITEM][7]:=nCLAFIS
                aPROD[nITEM][8]:=nQTDPRO
                aPROD[nITEM][9]:=nVLRPRO
                aPROD[nITEM][10]:=nVLTPRO
                aPROD[nITEM][11]:=nPERIPI
                aPROD[nITEM][12]:=nVLPIPI
                aPROD[nITEM][13]:=cCLASSE
                aPROD[nITEM][14]:=cMPRIMA
                aProd[ nItem ][ 15 ]:= nPerIcm
                aProd[ nItem ][ 16 ]:= nVlUIcm
                aProd[ nItem ][ 17 ]:= nPBaIcm
                aProd[ nItem ][ 18 ]:= nPerRed
                aProd[ nItem ][ 19 ]:= nVlrRed
             elseif lastkey()=K_ESC .OR. nITEM>=12
                --nITEM
             endif
             lFLAGC:=.T.
             nVLRNOT=0
             nVLRIPI=0
             nBASICM=0
             for nCT:=1 to len( aProdutos )
                nVLRNOT+=aPRODUTOS[nCT][10]
                nVLRIPI+=aPRODUTOS[nCT][12]
                if aPRODUTOS[nCT][5]<>2 .AND. aPRODUTOS[nCT][5]<>3;
                    .AND. aPRODUTOS[nCT][5]<>7 .AND. aPRODUTOS[nCT][5]<>8 && ICM Codigo
                   nBASICM+=aPRODUTOS[nCT][10]
                endif
             next
             if cCONREV="C"
               nVLRTOT:=nVLRNOT+nVLRIPI
               nBASICM:=nBASICM+nVLRIPI
               lFLAGC:=.F.
             else
               nVLRTOT:=nVLRNOT
             endif
             nVLRICM:=(nBASICM*nICMPER)/100

             //* LIMPEZA DAS VARIAVEIS *//
             nVLPIPI=0
             nCODPRO=0
             nQTDPRO=0
             nVLRPRO=0
             nVLTPRO=0
             SetColor( cCorRes2 )
             ScreenRest( cTelaRes2 )
             oTab:RefreshAll()
             While !oTab:Stabilize()
             EndDo

        Case TECLA==K_F2
             cCorRes2:= SetColor()
             cTelaRes2:= ScreenSave( 0, 0, 24, MaxCol() )
             ScreenRest( cTelaReserva )
             ++nITEM
             if nITEM>=13
                Alerta( { " Nao ser  permitida a inclus„o ",;
                          " de mais itens, pois cabe no ",;
                          " m ximo 12 itens na nota fiscal. " } )
                Inkey(0)
             else
                SetColor( _COR_GET_EDICAO )
                SetCursor(1)
                @ 05,08 Say "Item....: "+strzero(nITEM,2,0)
                @ 06,08 Say "Produto.:" Get cGrupo_ Pict "999" Valid VerGrupo( cGrupo_, @cCodigo )
                @ 06,23 Say "-"
                @ 06,24 Get cCodigo Pict "9999" Valid VerCodigo( cCodigo, GetList ) when mensagem("Digite o c¢digo do produto.")
                @ 07,08 Say "Descr...:" Get cDesPro Pict "@S30" Valid VerDescricao( cDesPro, GetList ) When Mensagem("Digite a descricao do produto.")
                @ 08,08 Say "Unidade.:" Get cUnidad Pict "@!" When Mensagem("Digite a unidade do produto.")
                @ 09,08 Say "C.Fiscal:" Get nClaFis Pict "999" valid VerClasse( @nClaFIs ) When Mensagem("Digite a classificacao.")
                @ 10,08 Say "CD.TB01.:" Get nIcmCod Pict "9" Valid ClassTrib( @nIcmCod, 1 ) When Mensagem("Digite o codigo tribut vel do produto.")
                @ 11,08 Say "CD.TB02.:" Get nIpiCod Pict "9" Valid ClassTrib( @nIpiCod, 2 ) When Mensagem("Digite o codigo do IPI.")
                @ 12,08 Say "Quantia.:" Get nQtdPro Pict "@E 999,999.999" Valid Calculos( cConRev, 4 ) When Mensagem( "Digite a quantidade de produtos solicitada." )
                @ 13,08 Say "Vlr.Unit:" Get nVlrPro Pict "@E 999,999,999.999" Valid Calculos( cConRev, 4 )
                @ 14,08 Say "Vl.Total:" Get nVltPro Pict "@E 999,999,999.999"
                @ 15,08 Say "% IPI...:" Get nPerIpi Pict "999.99" valid Calculos( cConRev, 5 )
                @ 16,08 Say "Vlr.IPI.:" Get nVlpIpi Pict "@E 999,999,999.99"
                /* Calculo do ICMs */
                @ 15,40 Say "% ICMs..:" Get nPerIcm Pict "999.99" Valid Calculos( cConRev, 6 )
                @ 16,40 Say "Vlr.ICMs:" Get nVlUIcm Pict "@E 999,999,999.99"

                Read
                If cDesPro <> cDP
                   nCodPro:= 0
                Endif
                if nClaFis = 7 .AND. !lFLAGM
                   lOBSERVACOES:=.T.
                endif
                if cMPRIMA="N" .AND. lastkey()<>K_ESC
                   @ ++nLIN,08 say "Ver.Mont:" get cVERMON pict "!" valid cVERMON$"SN";
                     when Mensagem("Digite [S] p/ selecinar comissionados por montagem.")
                   read
                  if cVERMON="S"
                     nAREA:=select()
                     dbselectar(_COD_VENDEDOR)
                     if netrlock(5)
                        repl all SELECT with "Sim" for TIPO__="M"
                        respmontagem()
                        Mensagem("Funcion rios selecionados, pres. [ENTER] p/ continuar.",1)
                        inkey(0)
                        DBUnlock()
                      endif
                      dbselectar(nAREA)
                   endif
                   nMBASEV+=(nVLTPRO+nVLPIPI)    // Base de calculo p/ v. a vista (mont.)
                endif
                nAREA:= Select()
                DBSelectAr( _COD_CLASFISCAL )
                DBSeek( nClaFis )
                cClasse:= CodFis
                DBSelectAr( nArea )
                if nITEM<=12 .AND. lastkey()<>K_ESC
                   aadd(aPRODUTOS,{nITEM, , , , , , , , , , , , , , , , , , })
                   aPRODUTOS[nITEM][2]:= cGrupo_ + cCodigo
                   aPRODUTOS[nITEM][3]:= cDESPRO
                   aPRODUTOS[nITEM][4]:= cUNIDAD
                   aPRODUTOS[nITEM][5]:= nICMCOD
                   aPRODUTOS[nITEM][6]:= nIPICOD
                   aPRODUTOS[nITEM][7]:= nCLAFIS
                   aPRODUTOS[nITEM][8]:= nQTDPRO
                   aPRODUTOS[nITEM][9]:= nVLRPRO
                   aPRODUTOS[nITEM][10]:= nVLTPRO
                   aPRODUTOS[nITEM][11]:= nPERIPI
                   aPRODUTOS[nITEM][12]:= nVLPIPI
                   aPRODUTOS[nITEM][13]:= cCLASSE
                   aPRODUTOS[nITEM][14]:= cMPRIMA
                   aProdutos[ nItem ][ 15 ]:= nPerIcm
                   aProdutos[ nItem ][ 16 ]:= nVlUIcm
                   aProdutos[ nItem ][ 17 ]:= nPBaIcm
                   aProdutos[ nItem ][ 18 ]:= nPerRed
                   aProdutos[ nItem ][ 19 ]:= nVlrRed
                   aadd(aPROD,{ nITEM, , , , , , , , , , , , , , , , , , })
                   aPROD[nITEM][2]:= cGrupo_ + cCodigo
                   aPROD[nITEM][3]:= cDESPRO
                   aPROD[nITEM][4]:= cUNIDAD
                   aPROD[nITEM][5]:= nICMCOD
                   aPROD[nITEM][6]:= nIPICOD
                   aPROD[nITEM][7]:= nCLAFIS
                   aPROD[nITEM][8]:= nQTDPRO
                   aPROD[nITEM][9]:= nVLRPRO
                   aPROD[nITEM][10]:= nVLTPRO
                   aPROD[nITEM][11]:= nPERIPI
                   aPROD[nITEM][12]:= nVLPIPI
                   aPROD[nITEM][13]:= cCLASSE
                   aPROD[nITEM][14]:= cMPRIMA
                   aProd[ nItem ][ 15 ]:= nPerIcm
                   aProd[ nItem ][ 16 ]:= nVlUIcm
                   aProd[ nItem ][ 17 ]:= nPBaIcm
                   aProd[ nItem ][ 18 ]:= nPerRed
                   aProd[ nItem ][ 19 ]:= nVlrRed
                elseif lastkey()=K_ESC .OR. nITEM>=12
                   --nITEM
                endif
                lFLAGC:=.T.
                nVLRNOT=0
                nVLRIPI=0
                nBASICM=0
                for nCT:=1 to len(aPRODUTOS)
                   nVLRNOT+=aPRODUTOS[nCT][10]
                   nVLRIPI+=aPRODUTOS[nCT][12]
                   if aPRODUTOS[nCT][5]<>2 .AND. aPRODUTOS[nCT][5]<>3;
                       .AND. aPRODUTOS[nCT][5]<>7 .AND. aPRODUTOS[nCT][5]<>8 && ICM Codigo
                      nBASICM+=aPRODUTOS[nCT][10]
                   endif
                next
                if cCONREV="C"
                  nVLRTOT:=nVLRNOT+nVLRIPI
                  nBASICM:=nBASICM+nVLRIPI
                  lFLAGC:=.F.
                else
                  nVLRTOT:=nVLRNOT
                endif
                nVLRICM:=(nBASICM*nICMPER)/100

                //* LIMPEZA DAS VARIAVEIS *//
                nVLPIPI=0
                nCODPRO=0
                nQTDPRO=0
                nVLRPRO=0
                nVLTPRO=0
             EndIf
             SetColor( cCorRes2 )
             ScreenRest( cTelaRes2 )
             oTab:RefreshAll()
             While !oTab:Stabilize()
             EndDo



        otherwise                ;tone(125); tone(300)
     endcase
     oTAB:refreshcurrent()
     oTAB:stabilize()
  end
  setcursor(1)
  DBSelectAr( nArea )
  DBSetOrder( nOrdem )
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return( .T. )


  STAT FUNCTION DisplayDados( aNFiscal, nRow )
  LOCAL cCor:= SetColor(), nCt:= 1, lMouseStatus:= MouseStatus()
  DesligaMouse()
  DispBegin()
  SetColor( Cor[16] )
  Scroll( 02, 31, 21, 78 )
  SetColor( "15/01" )
  DO CASE
     CASE nRow==1
          VPBoxSombra( 02, 31, 04, 77, , "15/01", "00/04" )
          @ 03,33 Say "Pedido(s): " + aNFiscal[ P_PEDIDOS ]
     CASE nRow==2
          VPBoxSombra( 02, 31, 14, 77, , "15/01", "00/04" )
          @ 03,33 Say "C¢digo...: " + StrZero( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ], 4, 0 )
          @ 04,33 Say "Nome.....: " + Left( aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ], 33 )
          @ 05,33 Say "CPF......: " + Tran( aNFiscal[ P_CLIENTE ][ CLI_CPF ], "@R 999.999.999-99" )
          @ 06,33 Say "Cidade...: " + aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]
          @ 07,33 Say "Estado...: " + aNFIscal[ P_CLIENTE ][ CLI_ESTADO ]
          @ 08,33 Say "Cons/Ind.: C"
     CASE nRow==3
          nArea:= DBSelectAr()
          DBSelectAr( _COD_NATOPERA )
          IF DBSeek( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] )
             aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= Left( Descri, 27 )
          ELSE
             aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= Space( 27 )
          ENDIF
          DBSelectAr( nArea )
          VPBoxSombra( 02, 31, 08, 77, , "15/01", "00/04" )
          @ 03,33 Say "Raz„o....: " + aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ]
          @ 04,33 Say "NF Numero: " + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 5, 0 )
          @ 05,33 Say "Nat.Oper.: " + Tran( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ], "@E 9.999" ) +;
                                            " - " + Left( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ], 25 )
          @ 06,33 Say "Emissao..: " + DTOC( aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ] )
          @ 07,33 Say "V.Transp.: " + aNFiscal[ P_CABECALHO ][ CAB_VIATRANSP ]
     CASE nRow==4
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/04" )
          @ 03,33 Say "Codigo...: " + StrZero( aNFIscal[ P_TRANSPORTE ][ TRA_CODIGO ], 3, 0 )
          @ 04,33 Say "Nome.....: " + Left( aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ], 33 )
          @ 05,33 Say "CGC......: " + TRAN( aNFiscal[ P_TRANSPORTE ][ TRA_CGC ], "@R 99.999.999/9999-99" )
          @ 06,33 Say "Inscri‡„o: " + aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ]
          @ 07,33 Say "Endere‡o.: " + Left( aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ], 33 )
          @ 08,33 Say "Bairro...: " + aNFiscal[ P_TRANSPORTE ][ TRA_BAIRRO ]
          @ 09,33 Say "Cidade...: " + aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ]
          @ 10,33 Say "Estado...: " + aNFIscal[ P_TRANSPORTE ][ TRA_ESTADO ]
          @ 11,33 Say "CEP......: " + Tran( aNFiscal[ P_TRANSPORTE ][ TRA_CEP ], "@R 99999-999" )
          @ 12,33 Say "Fone.....: " + Tran( aNFiscal[ P_TRANSPORTE ][ TRA_FONE ], "@R XXXX-XXXX.XXXX" )
     CASE nRow==5
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/04" )
          @ 03,33 Say "Codigo...: " + Tran( StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" )
          @ 04,33 Say "Descricao: " + Left( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_DESCRICAO ], 33 )
          @ 05,33 Say "Unidade..: " + aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_UNIDADE ]
          @ 06,33 Say "Tabela A.: " + StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CODTABELAA ], 1, 0 )
          @ 07,33 Say "Tabela B.: " + StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CODTABELAB ], 1, 0 )
          @ 08,33 Say "Clas.Fisc: " + StrZero( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_CLAFISCAL ], 3, 0 )
          @ 09,33 Say "Preco Un.: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PRECOVENDA ], "@E 999,999.999" )
          @ 10,33 Say "Quantia..: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_QUANTIDADE ], "@E 999,999.99" )
          @ 11,33 Say "Total....: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PRECOTOTAL ], "@E 999,999,999.999" )
          @ 12,33 Say "% IPI....: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PERCENTUALIPI ], "@E 999,999,999.99" )
          @ 13,33 Say "Valor IPI: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_VALORIPI ], "@E 999,999,999.99" )
          @ 13,60 Say "% Red.ICM: " + TRAN( aNFiscal[ P_PRODUTOS ][ 1 ][ PRO_PERREDUCAO ], "@E 99.99" )
          @ 14,33 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ BROWSE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
          @ 15,33 Say "Codigo   Descri‡ao                         "
          nFinal:= IF( Len( aNFiscal[ P_PRODUTOS ] ) > 4, 4, Len( aNFiscal[ P_PRODUTOS ] ) )
          FOR nCt:= 1 TO nFinal
              @ 15 + nCt, 33 Say Tran( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" )
              @ 15 + nCt, 42 Say Left( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ], 35 )
          NEXT
     CASE nRow==11
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/04" )
          IF Len( aNFiscal[ P_SERVICOS ] ) > 0
             @ 03,33 Say "Codigo.....: " + Tran( StrZero( aNFiscal[ P_SERVICOS ][ 1 ][ SER_CODIGO ], 7, 0 ), "@R XXX-XXXX" )
             @ 04,33 Say "Descricao..: " + Left( aNFiscal[ P_SERVICOS ][ 1 ][ SER_DESCRICAO ], 31 )
             @ 05,33 Say "Preco......: " + Tran( aNFiscal[ P_SERVICOS ][ 1 ][ SER_UNITARIO ], "@E 999,999,999.99" )
             @ 06,33 Say "Quantidade.: " + Tran( aNFiscal[ P_SERVICOS ][ 1 ][ SER_QUANTIDADE ], "@E 999,999.99" )
             @ 07,33 Say "Valor Total: " + Tran( aNFiscal[ P_SERVICOS ][ 1 ][ SER_TOTAL ], "@E 999,999,999.99" )
             @ 08,33 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Browse Servicos ÄÄÄÄÄÄÄÄÄÄÄÄ"
             @ 09,33 Say "Codigo   Descricao                         "
             nFinal:= IF( Len( aNFiscal[ P_SERVICOS ] ) > 8, 4, Len( aNFiscal[ P_SERVICOS ] ) )
             FOR nCt:= 1 TO nFinal
                 @ 09 + nCt, 33 Say Tran( StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ), "@R XXX-XXXX" )
                 @ 09 + nCt, 42 Say Left( aNFiscal[ P_SERVICOS ][ nCt ][ SER_DESCRICAO ], 35 )
             NEXT
          ENDIF
     CASE nRow==6
          VPBoxSombra( 02, 31, 16, 77, ,"15/01", "00/04" )
          @ 03,32 Say "C lculo Geral de Comiss”es"
          @ 04,32 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿"
          @ 05,32 Say "³ Vendedor.. ³³0000³ INTERNO ³0000³ EXTERNO ³"
          @ 06,32 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÁÄÄÄÄÄÄÄÄÄÅÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´"
          @ 07,32 Say "³ Nome       ³³              ³              ³"
          @ 08,32 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÂÄÄÄÄÄÄÄÄÄÅÄÄÄÄÂÄÄÄÄÄÄÄÄÄ´"
          @ 09,32 Say "³ A Vista... ³³    ³         ³    ³         ³"
          @ 10,32 Say "³ A Prazo... ³³    ³         ³    ³         ³"
          @ 11,32 Say "³ Recebidas. ³³    ³         ³    ³         ³"
          @ 12,32 Say "³ Tot.Venda. ³³    ³         ³    ³         ³"
          @ 13,32 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÁÄÄÄÄÄÄÄÄÄÅÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´"
          @ 14,32 Say "³ TOTAL      ³³              ³              ³"
          @ 15,32 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
          @ 05,47 Say StrZero( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_CODIGO ], 4, 0 )
          @ 05,62 Say StrZero( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_CODIGO ], 4, 0 )
          @ 07,48 Say aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_DESCRICAO ]
          @ 07,63 Say aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_DESCRICAO ]

          @ 09,47 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_AVISTA ], "@E 99.9" )
          @ 10,47 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_APRAZO ], "@E 99.9" )

          @ 09,52 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAVISTA ], "@E 99,999.99" )
          @ 10,52 Say Tran( aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_VAPRAZO ], "@E 99,999.99" )

          @ 09,62 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_AVISTA ], "@E 99.9" )
          @ 10,62 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_APRAZO ], "@E 99.9" )

          @ 09,67 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAVISTA ], "@E 99,999.99" )
          @ 10,67 Say Tran( aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_VAPRAZO ], "@E 99,999.99" )

     CASE nRow==7
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/04" )
          @ 03,33 Say "Vlr.Total: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],   "@E 99,999,999.99" )
          @ 04,33 Say "Vlr.IPI..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],     "@E 99,999,999.99" )
          @ 05,33 Say "Vlr.Nota.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],    "@E 99,999,999.99" )
          @ 06,33 Say "Base ICMs: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ], "@E 99,999,999.99" )
          @ 07,33 Say "Vlr.ICMs.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],     "@E 99,999,999.99" )
          @ 08,33 Say "Tot.Serv.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ],"@E 99,999,999.99" )
          @ 09,33 Say "% ISSQN..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ],     "@E 99.99" )
          @ 10,33 Say "Vlr ISSQN: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ],     "@E 99,999,999.99" )
          @ 11,33 Say "% IRRF ..: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ],     "@E 99.99" )
          @ 12,33 Say "Vlr IRRF : " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ],     "@E 99,999,999.99" )
          VPBoxSombra( 12, 31, 16, 77, , "15/01", "00/04" )
          @ 15,33 Say "Total NF.: " + Tran( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] + aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ],"@E 99,999,999.99" )
     CASE nRow==8
          VPBoxSombra( 02, 31, 18, 77, , "15/01", "00/04" )
          @ 03,33 Say "Valor Seguro: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ], "@E 999,999,999.99" )
          @ 04,33 Say "Valor Frete.: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE  ], "@E 999,999,999.99" )
          @ 05,33 Say "Tp.Frete....: " + aNFiscal[ P_DIVERSOS ][ DIV_TIPOFRETE ]
          @ 06,33 Say "Quantidade..: " + aNFiscal[ P_DIVERSOS ][ DIV_QUANTIDADE ]
          @ 07,33 Say "Especie.....: " + aNFiscal[ P_DIVERSOS ][ DIV_ESPECIE ]
          @ 08,33 Say "Peso Bruto..: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ], "@E 999,999.999" ) + "Kg"
          @ 09,33 Say "Peso Liquido: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ], "@E 999,999.999" ) + "Kg"
          @ 10,33 Say "Data Saida..: " + DTOC( aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ] )
          @ 11,33 Say "Hora Saida..: " + Tran( aNFiscal[ P_DIVERSOS ][ DIV_HORASAIDA ], "@R 99:99" ) + "hs."
          @ 12,32 Say "µººººººººººººººººººººººººººººººººººººººººººº¶"
          @ 13,32 Say "¼                                           ½"
          @ 14,32 Say "¼                                           ½"
          @ 15,32 Say "¼                                           ½"
          @ 16,32 Say "¼                                           ½"
          @ 17,32 Say "¸»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»¹"
          @ 13,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA1 ], 43 )
          @ 14,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA2 ], 43 )
          @ 15,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA3 ], 43 )
          @ 16,33 Say Left( aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ], 43 )
     CASE nRow==9
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/04" )
          @ 03,32 Say "Pr Perc Valor     Dias Ban Dt.Venc   Dt.Pgto "
          nLin:= 3
          nCont:= 0
          nSoma:= 0
          IF !Empty( aNFiscal[ P_FATURA ] )
             FOR nCt:= 1 To LEN( aNFiscal[ P_FATURA ] )
                @ ++nLin, 32 Say StrZero( ++nCont, 1, 0 )
                @ nLin, 34 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] Pict "@E 999.99"
                @ nLin, 41 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ] Pict "@E 999,999.99"
                @ nLin, 52 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ] Pict "@E 999"
                @ nLin, 56 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ] Pict "@E 999"
                @ nLin, 60 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ]
                @ nLin, 69 Say aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ]
                nSoma:= nSoma + aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ]
             NEXT
             @ ++nLin, 34 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
             @ ++nLin, 38 Say "Total da Fatura: " + Tran( nSoma, "@E 999,999,999.99" )
             @ ++nLin, 38 Say "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
             @ ++nLin, 38 Say "³ Esta Nota Fiscal      ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
             @ ++nLin, 38 Say "³ esta pronta para ser     ÄÄÄÄÄÄÄÄÄÄÄ´"
             @ ++nLin, 38 Say "³ gravada.                     ÄÄÄÄÄÄÄ´"
             @ ++nLin, 38 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
          ENDIF
  ENDCASE
  DispEnd()
  LigaMouse( lMouseStatus )
  SetColor( cCor )



  Static Function EditDados( aNfiscal, nRow )
  LOCAL nArea, nParcelas, nClasFis
  SetColor( Cor[16] )
  Scroll( 02, 31, 21, 78 )
  SetColor( "15/01" )
  DO CASE
     CASE nRow==3
          VPBoxSombra( 02, 31, 08, 77, , "15/01", "00/04" )
          @ 03,33 Say "Raz„o....: " + aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ]
          @ 04,33 Say "NF Numero: " + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 5, 0 )
          @ 05,33 Say "Nat.Oper.:" Get aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] Pict "@R 9.999"
          @ 06,33 Say "Emissao..:" Get aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ]
          @ 07,33 Say "V.Transp.:" Get aNFiscal[ P_CABECALHO ][ CAB_VIATRANSP ]
          READ

          nArea:= DBSelectAr()
          DBSelectAr( _COD_NATOPERA )
          IF DBSeek( aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ] )
             aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_DESCRICAO ]:= Left( Descri, 27 )
          ENDIF
          DBSelectAr( nArea )

     CASE nRow==2
          VPBoxSombra( 02, 31, 14, 77, , "15/01", "00/04" )
          @ 03,33 Say "C¢digo...: " + StrZero( aNFiscal[ P_CLIENTE ][ CLI_CODIGO ], 4, 0 )
          @ 04,33 Say "Nome.....:" Get aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ] Pict "@S33"
          @ 05,33 Say "CPF......:" Get aNFiscal[ P_CLIENTE ][ CLI_CPF ] Pict "@R 999.999.999-99"
          @ 06,33 Say "Cidade...: " + aNFiscal[ P_CLIENTE ][ CLI_CIDADE ]
          @ 07,33 Say "Estado...: " + aNFIscal[ P_CLIENTE ][ CLI_ESTADO ]
          @ 08,33 Say "Cons/Ind.: C"
          READ
          IF UpDated()
             aNFiscal[ P_CLIENTE ][ CLI_CODIGO ]:= 0
          ENDIF
     CASE nRow==4
          VPBoxSombra( 02, 31, 13, 77, , "15/01", "00/04" )
          @ 03,33 Say "Codigo...: " + StrZero( aNFIscal[ P_TRANSPORTE ][ TRA_CODIGO ], 3, 0 )
          @ 04,33 Say "Nome.....:" Get aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ] Pict "@S33"
          @ 05,33 Say "CGC......:" Get aNFiscal[ P_TRANSPORTE ][ TRA_CGC ] Pict "@R 99.999.999/9999-99"
          @ 06,33 Say "Inscri‡„o:" Get aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ]
          @ 07,33 Say "Endere‡o.:" Get aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ] Pict "@S33"
          @ 08,33 Say "Bairro...:" Get aNFiscal[ P_TRANSPORTE ][ TRA_BAIRRO ]
          @ 09,33 Say "Cidade...:" Get aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ]
          @ 10,33 Say "Estado...:" Get aNFIscal[ P_TRANSPORTE ][ TRA_ESTADO ]
          @ 11,33 Say "CEP......:" Get aNFiscal[ P_TRANSPORTE ][ TRA_CEP ] Pict "@R 99999-999"
          @ 12,33 Say "Fone.....:" Get aNFiscal[ P_TRANSPORTE ][ TRA_FONE ] Pict "@R XXXX-XXXX.XXXX"
          READ
          IF UpDated()
             aNFIscal[ P_TRANSPORTE ][ TRA_CODIGO ]:= 0
          ENDIF
     CASE nRow==5
          /* BROWSE PARA PRODUTOS */
          nRow:= 1
          nTecla:= 0
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/04" )
          oTAB:=tbrowsenew(16,33,19,76)
          oTAB:addcolumn(tbcolumnnew(,{|| Tran( StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) + " " + aNFiscal[ 5 ][ nRow ][ PRO_DESCRICAO ] }))
          oTAB:AUTOLITE:=.f.
          oTAB:GOTOPBLOCK :={|| nROW:=1}
          oTAB:GOBOTTOMBLOCK:={|| nROW:=len( aNFiscal[ 5 ] )}
          oTAB:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aNFiscal[ 5 ],@nROW)}
          oTAB:dehilite()
          lDelimiters:= Set( _SET_DELIMITERS, .F. )
          WHILE .T.
              oTAB:colorrect({oTAB:ROWPOS,1,oTAB:ROWPOS,1},{2,1})
              WHILE nextkey()==0 .and. ! oTAB:stabilize()
              ENDDO
              @ 03,33 Say "Codigo...: " + Tran( StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODIGO ], 7, 0 ), "@R XXX-XXXX" ) + "  "
              @ 04,33 Say "Descricao: " + Left( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_DESCRICAO ], 33 )
              @ 05,33 Say "Unidade..: " + aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_UNIDADE ]
              @ 06,33 Say "Tabela A.: " + StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAA ], 1, 0 )
              @ 07,33 Say "Tabela B.: " + StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CODTABELAB ], 1, 0 )
              @ 08,33 Say "Clas.Fisc: " + StrZero( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CLAFISCAL ], 3, 0 )
              @ 09,33 Say "Preco Un.: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOVENDA ], "@E 999,999.999" )
              @ 10,33 Say "Quantia..: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_QUANTIDADE ], "@E 999,999.99" )
              @ 11,33 Say "Total....: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOTOTAL ], "@E 999,999,999.999" )
              @ 12,33 Say "% IPI....: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERCENTUALIPI ], "@E 999,999,999.99" )
              @ 13,33 Say "Valor IPI: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_VALORIPI ], "@E 999,999,999.99" )
              @ 13,60 Say "% Red.ICM: " + TRAN( aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERREDUCAO ], "@E 99.99" )
              @ 14,33 Say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ BROWSE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
              @ 15,33 Say "Codigo   Descri‡ao                         "
              nTecla:= Inkey(0)
              IF nTecla==K_ESC
                 nOpcao:= 0
                 exit
              ENDIF
              DO CASE
                 CASE nTecla==K_UP         ;oTAB:up()
                 CASE nTecla==K_DOWN       ;oTAB:down()
                 CASE nTecla==K_LEFT       ;oTAB:up()
                 CASE nTecla==K_RIGHT      ;oTAB:down()
                 CASE nTecla==K_PGUP       ;oTAB:pageup()
                 CASE nTecla==K_CTRL_PGUP  ;oTAB:gotop()
                 CASE nTecla==K_PGDN       ;oTAB:pagedown()
                 CASE nTecla==K_CTRL_PGDN  ;oTAB:gobottom()
                 CASE nTecla==K_ENTER
                      nClasFis:= 0
                      nClasFis:= aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CLAFISCAL ]
                      @ 08,33 Say "Clas.Fisc:" Get nClasFis Pict "@R 999"  valid verClasse( @nClasFis )
                      @ 09,33 Say "Preco Un.:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOVENDA ]    Pict "@E 999,999.999"     valid Calculo( aNFiscal )
                      @ 10,33 Say "Quantia..:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_QUANTIDADE ]    Pict "@E 999,999.99"      valid Calculo( aNFiscal )
                      @ 11,33 Say "Total....:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PRECOTOTAL ]    Pict "@E 999,999,999.999" valid Calculo( aNFiscal )
                      @ 12,33 Say "% IPI....:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_PERCENTUALIPI ] Pict "@E 999,999,999.99"  valid Calculo( aNFiscal )
                      @ 13,33 Say "Valor IPI:" Get aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_VALORIPI ]      Pict "@E 999,999,999.99"  valid Calculo( aNFiscal )
                      Read
                      aNFiscal[ P_PRODUTOS ][ nRow ][ PRO_CLAFISCAL ]:= nClasFis
                      oTab:RefreshAll()
                      WHILE !oTab:Stabilize()
                      ENDDO
                 OTHERWISE                ;tone(125); tone(300)
              ENDCASE
              oTAB:refreshcurrent()
              oTAB:stabilize()
          ENDDO
          /* FIM BROWSE PARA PRODUTOS */
     CASE nRow==8
          VPBoxSombra( 02, 31, 18, 77, , "15/01", "00/04" )
          @ 03,33 Say "Valor Seguro:" Get aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ] Pict "@E 999,999,999.99"
          @ 04,33 Say "Valor Frete.:" Get aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE  ] Pict "@E 999,999,999.99"
          @ 05,33 Say "Tp.Frete....:" Get aNFiscal[ P_DIVERSOS ][ DIV_TIPOFRETE ]   Pict "9"
          @ 06,33 Say "Quantidade..:" Get aNFiscal[ P_DIVERSOS ][ DIV_QUANTIDADE ]
          @ 07,33 Say "Especie.....:" Get aNFiscal[ P_DIVERSOS ][ DIV_ESPECIE ]
          @ 08,33 Say "Peso Bruto..:" Get aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ] Pict "@E 999,999.999"
          @ 09,33 Say "Peso Liquido:" Get aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ] Pict "@E 999,999.999"
          @ 10,33 Say "Data Saida..:" Get aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ]
          @ 11,33 Say "Hora Saida..:" Get aNFiscal[ P_DIVERSOS ][ DIV_HORASAIDA ] Pict "@R 99:99"
          @ 12,32 Say "µººººººººººººººººººººººººººººººººººººººººººº¶"
          @ 13,32 Say "¼                                           ½"
          @ 14,32 Say "¼                                           ½"
          @ 15,32 Say "¼                                           ½"
          @ 16,32 Say "¼                                           ½"
          @ 17,32 Say "¸»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»¹"
          #ifndef CONECSUL
             @ 13,33 Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA1 ] Pict "@S43"
             @ 14,33 Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA2 ] Pict "@S43"
          #endif
          @ 15,33 Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA3 ] Pict "@S43"
          @ 16,33 Get aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ] Pict "@S43"
          Read
     CASE nRow==9
          nLin:= 3
          nCont:= 0
          VPBoxSombra( 02, 31, 20, 77, , "15/01", "00/04" )

          aDias:= {}
          cString:= aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] + "/"
          nPos:= 0
          IF Empty( aDias )
             FOR nCt:= 1 TO Len( aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] )
                 AAdd( aDias, Val( SubStr( cString, 1, At( "/", cString ) - 1 ) ) )
                 cString:= SubStr( cString, At( "/", cString ) + 1 )
             NEXT
          ENDIF

          aNFiscal[ P_DIVERSOS ][ DIV_FATURA ]:= StrVezes( "/", aNFiscal[ P_DIVERSOS ][ DIV_CONDICOES ] ) + 1

          @ 03,32 Say "Qt. parcelas p/ fatura desta nota?" Get aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] Pict "99" valid ;
                      aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] > 0
          READ
          IF Len( aNFiscal[ P_FATURA ] ) < aNFiscal[ P_DIVERSOS ][ DIV_FATURA ]
             nParcelas:= aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] - Len( aNFiscal[ P_FATURA ] )
             FOR nCt:= 1 TO nParcelas
                 AAdd( aNFiscal[ P_FATURA ], { 0, 0, 0, 0, 0, Date(), " ", CTOD( "  /  /  " ), Space( 10 ), 0 } )
             NEXT
          ENDIF
          DO CASE
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 1
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 100
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 2
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 50
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 50
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 3
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 34
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 33
                  aNFiscal[ P_FATURA ][3][ FAT_PERCENTUAL ]:= 33
             CASE aNFiscal[ P_DIVERSOS ][ DIV_FATURA ] == 4
                  aNFiscal[ P_FATURA ][1][ FAT_PERCENTUAL ]:= 25
                  aNFiscal[ P_FATURA ][2][ FAT_PERCENTUAL ]:= 25
                  aNFiscal[ P_FATURA ][3][ FAT_PERCENTUAL ]:= 25
                  aNFiscal[ P_FATURA ][4][ FAT_PERCENTUAL ]:= 25
          ENDCASE
          @ 03,32 Say "Pr Perc Valor     Dias Ban Dt.Venc   Dt.Pgto "
          WHILE LastKey() <> K_ESC
               //IF Len( aNFiscal[ P_FATURA ] ) <= nCont
               //   AAdd( aNFiscal[ P_FATURA ], { 0, 0, 0, 0, 0, Date(), " ", CTOD( "  /  /  " ), Space( 10 ) } )
               //ENDIF
               @ ++nLin, 32 Say StrZero( ++nCont, 1, 0 )
               IF Len( aDias ) >= nCont
                  aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ]:= aDias[ nCont ]
               ENDIF
               @ nLin, 34 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_PERCENTUAL ] Pict "@E 999.99" Valid VerPercentual( aNFiscal )
               @ nLin, 41 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_VALOR ] Pict "@E 999,999.99"
               @ nLin, 52 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_DIAS ] Pict "@E 999" Valid VerDias( aNFiscal )
               @ nLin, 56 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_BANCO ] Pict "@E 999"
               @ nLin, 60 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_VENCIMENTO ]
               // @ nLin, 75 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_TIPO ]
               @ nLin, 69 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_PAGAMENTO ]
               READ
               IF !Empty( aNFiscal[ P_FATURA ][ nCont ][ FAT_PAGAMENTO ] ) .AND. LastKey() <> K_ESC
                  cTelaRes:= ScreenSave( 0, 0, 24, 79 )
                  VPBOX( nLin, 50, nLin + 3, 75 )
                  @ nLin+1, 51 Say "Pagamento em cheque n§:"
                  @ nLin+2, 60 Get aNFiscal[ P_FATURA ][ nCont ][ FAT_CHEQUE ]
                  READ
                  ScreenRest( cTelaRes )
               ENDIF
               IF nCont + 1 > Len( aNfiscal[ P_FATURA ] )
                  EXIT
               ENDIF
          ENDDO
  ENDCASE
  RETURN Nil




  STAT Function verPercentual( aNFiscal )
     FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] )
         aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ]:= ( aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] * aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ] ) / 100
     NEXT
  Return .t.


  Function verDias( aNFiscal )
     FOR nCt:= 1 TO LEN( aNFiscal[ P_FATURA ] )
         aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ]:= Date() + aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ]
     NEXT
  Return .T.




  /*

    PEDIDO ACEITO
    Guardar o Status de Pedido

  */
  function pedidoaceito( lOk )
  Static lGuardar
  If lOk <> Nil
     lGuardar:= lOk
  Endif
  Return lGuardar


  /*****
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Funcao      ³ GRAVACAO
  ³ Finalidade  ³ Verificar integridade de dados e efetuar a gravacao dos mesmos
  ³ Parametros  ³ Nil
  ³ Retorno     ³ Nil
  ³ Programador ³ Valmor Pereira Flores
  ³ Data        ³ 12/06/97
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  */
  Static Function Gravacao( aNFiscal )
  Local cCor:= SetColor(), nCursor:= SetCursor(),;
        cTela:= ScreenSave( 0, 0, 24, MaxCol() )
  Local nCt:= 0, nLin:= 5, nCol:= 20, lOk:= .F.,;
        lErro1:= .F., lErro2:= .F., lErro3:= .F., lErro4:= .F.,;
        lErro5:= .F., lErro6:= .F., nNumero:= 0, lMouse:= MouseStatus(),;
        nQuantidade:= 0, nQtdPermitida:= 0

  DesligaMouse()
  SetColor( COR[ 24 ] )
  aNFiscal[ P_TESTE ][ TES_ERROS ]:= 0   /* Limpa a matriz */
  aNFiscal[ P_TESTE ][ TES_ERROS ]:= {}  /* Refaz a matriz */

  VPBox( nLin, nCol, nLin+15, nCol + 47, "TESTE PRE-GRAVACAO", _COR_BROW_BOX )
  SetColor( _COR_BROW_BOX )
  ++nLin
  @ nLin+01, nCol+1 Say "Ú Testes de dados ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿Ú Sit Ä¿"
  @ nLin+02, nCol+1 Say "³                                   ³³   0% ³"
  @ nLin+03, nCol+1 Say "³  [ ] Integridade de Cadastros     ³³  10% ³"
  @ nLin+04, nCol+1 Say "³  [ ] Verificacao de CGC / CPF     ³³  20% ³"
  @ nLin+05, nCol+1 Say "³  [ ] Integridade de Calculos      ³³  30% ³"
  @ nLin+06, nCol+1 Say "³  [ ] Integridade de Pedidos       ³³  40% ³"
  @ nLin+07, nCol+1 Say "³  [ ] Diferencas entre arquivos    ³³  50% ³"
  @ nLin+08, nCol+1 Say "³  [ ] Integridade de datas         ³³  60% ³"
  @ nLin+09, nCol+1 Say "³                                   ³³  70% ³"
  @ nLin+10, nCol+1 Say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´³  80% ³"
  @ nLin+11, nCol+1 Say "³  Numero da Nota fiscal:           ³³  90% ³"
  @ nLin+12, nCol+1 Say "³  Data de Emissao......:           ³³ 100% ³"
  @ nLin+13, nCol+1 Say "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÙ"

  Mensagem( "Dados Cadastrais: CLIENTES ******************" )
  /* CADASTRO DE CLIENTES */
  IF aNFiscal[ P_CLIENTE ][ CLI_CGC ] == Space( 14 )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta CGC no cadastro do cliente." )
  ENDIF
  IF aNfiscal[ P_CLIENTE ][ CLI_CONSIND ] == Space( 1 )
     AAdd( aNFIscal[ P_TESTE ][ TES_ERROS ], "Falta informar no cliente se e' [C]ONSUMO OU [I]NDUSTRIA..." )
  ENDIF
  IF aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ] == Space( 45 )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta razao social do cliente." )
  ENDIF
  IF aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ] == Space( 35 )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta Endereco do cliente." )
  ENDIF
  IF aNFiscal[ P_CLIENTE ][ CLI_CEP ] == Space( 8 )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta o cep do cliente." )
  ENDIF
  IF aNFiscal[ P_CLIENTE ][ CLI_ESTADO ] == Space( 2 )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta o estado do cliente." )
  ENDIF

  Mensagem( "Dados Cadastrais: TRANSPORTADORA ************" )
  IF aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ] == Space( 20 )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Falta o nome da transportadora." )
  ENDIF

  IF Len( aNFiscal[ P_TESTE ][ TES_ERROS ] ) == 0
     lErro1:= .F.
     @ nLin + 03, nCol + 05 Say "X"
  ELSE
     lErro1:= .T.
     @ nLin + 03, nCol + 05 Say "!"
  ENDIF

  Mensagem( "Verificando a integridade de CGC / CPF, aguarde..." )
  Inkey( .10 )
  @ nLin + 04, nCol + 05 Say "X"
  Mensagem( "Verificando a integridade dos calculos, aguarde..." )
  Inkey( .10 )
  @ nLin + 05, nCol + 05 Say "X"
  Mensagem( "Verificando a integridade dos pedidos, aguarde..." )


  Mensagem( "Integridade de Calculo: VERIFICACAO DA FATURA" )
  IF Empty( aNFiscal[ P_FATURA ] )
     AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "Fatura nao foi lancada." )
     lErro4:= .T.
  ENDIF
  Inkey( .10 )

  @ nLin + 06, nCol + 05 Say "X"
  Mensagem( "Verificando alteracoes efetuadas nas informacoes, aguarde..." )

  /* verificacao de entregas x saldos */
  DBSelectAr( _COD_PEDBAIXA )
  Set Index To
  cNumeroPedido:= StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 )
  index On CODPRO TO INDICE29.NTX ;
                  EVAL {|| Processo() } FOR CODIGO == cNumeroPedido
  Set Index To INDICE29.NTX
  DBGOTOP()
  FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] )
      nQuantidade:= 0
      DBSeek( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) + "     ", .T. )
      WHILE StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) + "     " == CODPRO
          nQuantidade:= nQuantidade + QUANT_
          DBSkip()
          IF EOF()
             EXIT
          ENDIF
      ENDDO
      IF ( nQuantidade + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] ) > aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QTDPADRAO ]
         nQtdPermitida:= aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QTDPADRAO ] - nQuantidade
         IF nQtdPermitida < 0
            nQtdPermitida:= 0
         ENDIF
         AAdd( aNFiscal[ P_TESTE ][ TES_ERROS ], "No produto " + StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ) + " foi excedida a qtd. solicitada. Use " + AllTrim( Tran( nQtdPermitida, "@E 999,999.999"  ) ) + " na qtd."  )
         lErro2:= .T.
      ENDIF
  NEXT
  Set Index To &GDIR\PB_IND01.NTX
  /* FIM DE VERIFICACAO DE ENTREGAS */

  Inkey( .10 )
  @ nLin + 07, nCol + 05 Say "X"
  Mensagem( "Verificando alteracoes efetuadas nas informacoes, aguarde..." )
  Inkey( .10 )
  @ nLin + 08, nCol + 05 Say "X"

  @ nLin + 03, nCol + 05 Say IF( lErro1, "!", "X" )
  @ nLin + 04, nCol + 05 Say IF( lErro2, "!", "X" )
  @ nLin + 05, nCol + 05 Say IF( lErro3, "!", "X" )
  @ nLin + 06, nCol + 05 Say IF( lErro4, "!", "X" )
  @ nLin + 07, nCol + 05 Say IF( lErro5, "!", "X" )
  @ nLin + 08, nCol + 05 Say IF( lErro6, "!", "X" )

  Mensagem( "Verificacoes efetuadas. Pressione ENTER para continuar." )
  VPBOX( 0, 0, 22, 79, " Relacao de Arquivo LOG ", _COR_BROW_BOX )
  SetColor( _COR_BROW_BOX )
  FOR nCt:= 1 To Len( aNFiscal[ P_TESTE ][ TES_ERROS ] )
      @ nCt, 02 Say aNFiscal[ P_TESTE ][ TES_ERROS ][ nCt ]
  NEXT
  IF Len( aNFiscal[ P_TESTE ][ TES_ERROS ] ) == 0
     @ 02,02 Say "Nenhum erro foi encontrado nos dados analisados..."
     @ 03,02 Say "O arquivo j  pode ser gravado com seguranca.      "
     nOpcao:= 1
  ELSE
     nOpcao:= 2
  ENDIF

  DispBox( 17, 49, 21, 75 )
  nOpcao:= 1
  Keyboard Chr( K_ENTER )
  @ 18,50 Say "Voce deseja"
  @ 19,50 Prompt                 " 1. Gravar               "
  @ 20,50 Prompt IF( nOpcao = 2, " 2. Corrigir Erros       ",;
                                 " 2. Retornar ao Cadastro " )
  Menu To nOpcao
  IF nOpcao == 1
     Gravando( "GRAVANDO! Aguarde..." )
     Gravando( "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" )
     For nCt:= 2 To Len( aNFiscal )
         For nCt2:= 1 To Len( aNFiscal[ nCt ] )
             Gravando( aNFiscal[ nCt ][ nCt2 ] )
         Next
     Next
     Gravando( "Atualizando arquivo de notas fiscais, aguarde... " )
     DBSelectAr( _COD_NFISCAL )
     DBSetOrder( 1 )
     DBGoBottom()
     nNumero:= NUMERO + 1
     aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ]:= nNumero
     DBAppend()
     Gravando( "Cabecalho da Nota Fiscal" )
     Replace NUMERO With nNumero,;
             NATOPE With aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ],;
             DATAEM With aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ],;
             TIPONF With aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ],;
             VIATRA With aNFiscal[ P_CABECALHO ][ CAB_VIATRANSP ],;
             ENTSAI With aNFiscal[ P_CABECALHO ][ CAB_ENTRADASAIDA ],;
             ORDEMC With aNFiscal[ P_CABECALHO ][ CAB_ORDEMCOMPRA ]
     Gravando( "Cadastro do Cliente." )
     Replace CLIENT With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],;
             CDESCR With aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ],;
             CENDER With aNFiscal[ P_CLIENTE ][ CLI_ENDERECO ],;
             CBAIRR With aNFiscal[ P_CLIENTE ][ CLI_BAIRRO ],;
             CCIDAD With aNFiscal[ P_CLIENTE ][ CLI_CIDADE ],;
             CESTAD With aNFiscal[ P_CLIENTE ][ CLI_ESTADO ],;
             CCDCEP With aNFiscal[ P_CLIENTE ][ CLI_CEP ],;
             CCGCMF With aNFiscal[ P_CLIENTE ][ CLI_CGC ],;
             CINSCR With aNFiscal[ P_CLIENTE ][ CLI_INSCRICAO ],;
             CCOBRA With aNFiscal[ P_CLIENTE ][ CLI_COBRANCA ],;
             CONREV With aNFiscal[ P_CLIENTE ][ CLI_CONSIND ],;
             CCPF__ With aNFiscal[ P_CLIENTE ][ CLI_CPF ],;
             CFONE2 With aNFiscal[ P_CLIENTE ][ CLI_FONE ]
     Gravando( "Dados da transportadora." )
     Replace TRANSP With aNFiscal[ P_TRANSPORTE ][ TRA_CODIGO ],;
             TDESCR With aNFiscal[ P_TRANSPORTE ][ TRA_DESCRICAO ],;
             TFONE_ With aNFiscal[ P_TRANSPORTE ][ TRA_FONE ],;
             TENDER With aNFiscal[ P_TRANSPORTE ][ TRA_ENDERECO ],;
             TCIDAD With aNFiscal[ P_TRANSPORTE ][ TRA_CIDADE ],;
             TESTAD With aNFiscal[ P_TRANSPORTE ][ TRA_ESTADO ],;
             TCGCMF With aNFiscal[ P_TRANSPORTE ][ TRA_CGC ],;
             TINSCR With aNFiscal[ P_TRANSPORTE ][ TRA_INSCRICAO ]
     Gravando( "Informacao de vendedores..." )
     Replace VENIN_ With aNFiscal[ P_COMISSOES ][ COM_INTERNO ][ INT_CODIGO ],;
             VENEX_ With aNFiscal[ P_COMISSOES ][ COM_EXTERNO ][ EXT_CODIGO ]
     Gravando( "Calculo de impostos..." )
     Replace VLRTOT With aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],;
             VLRNOT With aNFiscal[ P_IMPOSTOS ][ IMP_VALORNOTA ],;
             VLRICM With aNFiscal[ P_IMPOSTOS ][ IMP_VALORICM ],;
             VLRIPI With aNFiscal[ P_IMPOSTOS ][ IMP_VALORIPI ],;
             BASICM With aNFiscal[ P_IMPOSTOS ][ IMP_VALORBASEICM ]
     Gravando( "Servicos Imposto sobre servicos (ISSQN)..." )
     IF aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ] > 0
        Replace ISSQNB With aNFiscal[ P_IMPOSTOS ][ IMP_VALORSERVICOS ],;
                ISSQNV With aNFiscal[ P_IMPOSTOS ][ IMP_VLRISSQN ],;
                ISSQNP With aNFiscal[ P_IMPOSTOS ][ IMP_PERISSQN ]
     ENDIF

     Gravando( "Servicos Imposto sobre servicos (IRRF)..." )
     IF aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ] > 0
        Replace IRRF_B With aNFiscal[ P_IMPOSTOS ][ IMP_VALORTOTAL ],;
                IRRF_V With aNFiscal[ P_IMPOSTOS ][ IMP_VLRIRRF ],;
                IRRF_P With aNFiscal[ P_IMPOSTOS ][ IMP_PERIRRF ]
     ENDIF

     Gravando( "Informacoes do pedido - Numero -->>> " + StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ) )
     Replace PEDIDO With aNFiscal[ P_NUMERO ][ NUM_PEDIDO ]

     Gravando( "Observacoes, quantidade de volume e embalagem..." )
     Replace QUANT_ With aNFiscal[ P_DIVERSOS ][ DIV_QUANTIDADE ],;
             ESPEC_ With aNFiscal[ P_DIVERSOS ][ DIV_ESPECIE ],;
             PESOBR With aNFiscal[ P_DIVERSOS ][ DIV_PESOBRUTO ],;
             PESOLI With aNFiscal[ P_DIVERSOS ][ DIV_PESOLIQUIDO ],;
             SAIDAT With aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ],;
             SAIHOR With aNFiscal[ P_DIVERSOS ][ DIV_HORASAIDA ],;
             FPC12_ With aNFiscal[ P_DIVERSOS ][ DIV_TIPOFRETE ],;
             FRETE_ With aNFiscal[ P_DIVERSOS ][ DIV_VALORFRETE ],;
             SEGURO With aNFiscal[ P_DIVERSOS ][ DIV_VALORSEGURO ],;
             OBSER1 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA1 ],;
             OBSER2 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA2 ],;
             OBSER3 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA3 ],;
             OBSER4 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA4 ],;
             OBSER5 With aNFiscal[ P_DIVERSOS ][ DIV_OBSERVACOES ][ OBS_LINHA5 ],;
             NVEZES With aNFiscal[ P_DIVERSOS ][ DIV_FATURA ]

     Gravando( "Produtos..." )
     DBSelectAr( _COD_PRODNF )
     FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] )
        Gravando( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] )
        IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0 .AND.;
           aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ] > 0
           DBAppend()
           Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],;
                CODRED With StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),;
                CODIGO With StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),;
                DESCRI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ],;
                UNIDAD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_UNIDADE ],;
                PRECOV With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ],;
                PRECOT With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ],;
                ICMCOD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAA ],;
                IPICOD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODTABELAB ],;
                CLAFIS With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CLAFISCAL ],;
                QUANT_ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],;
                IPI___ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_VALORIPI ],;
                PERIPI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALIPI ],;
                PERICM With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ],;
                MPRIMA With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_MATERIAPRIMA ],;
                CODFIS With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGOFISCAL ],;
                ORIGEM With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_ORIGEM ]

           IF SWSet( _GER_ESTOQUENF )
              DBSelectAr( _COD_ESTOQUE )
              LancEstoque( StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),;
                     StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),;
                     "-", "NF: " + StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 6, 0 ),;
                     aNFiscal[ P_CLIENTE ][ CLI_CODIGO ], 0,;
                     aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOTOTAL ],;
                     aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],;
                     nGCodUser, aNFiscal[ P_CABECALHO ][ CAB_DATAEMISSAO ] )
           ENDIF
           DBSelectAr( _COD_PRODNF )
        ENDIF
     NEXT
     FOR nCt:= 1 TO Len( aNFiscal[ P_SERVICOS ] )
        Gravando( aNFiscal[ P_SERVICOS ][ nCt ][ SER_DESCRICAO ] )
        IF aNFiscal[ P_SERVICOS ][ nCt ][ SER_QUANTIDADE ] > 0
           DBAppend()
           Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],;
                CODRED With StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ),;
                CODIGO With StrZero( aNFiscal[ P_SERVICOS ][ nCt ][ SER_CODIGO ], 7, 0 ),;
                DESCRI With aNFiscal[ P_SERVICOS ][ nCt ][ SER_DESCRICAO ],;
                PRECOV With aNFiscal[ P_SERVICOS ][ nCt ][ SER_UNITARIO ],;
                PRECOT With aNFiscal[ P_SERVICOS ][ nCt ][ SER_TOTAL ],;
                QUANT_ With aNFiscal[ P_SERVICOS ][ nCt ][ SER_QUANTIDADE ],;
                MPRIMA With "S"
           DBSelectAr( _COD_PRODNF )
        ENDIF
     NEXT
     Gravando( "Duplicatas..." )
     DBSelectAr( _COD_DUPLICATA )
     DBAppend()
     FOR nCt:= 1 TO Len( aNFiscal[ P_FATURA ] )
         aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ]:= ;
            VAL( StrZero( aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ], 6, 0 ) + ;
            StrZero( Month( aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ] ), 2, 0 ) )

         DO CASE
            CASE nCt == 1
                 Replace CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],;
                         CDESCR With aNFiscal[ P_CLIENTE ][ CLI_DESCRICAO ],;
                         CLIENT With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],;
                         DUPL_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ],;
                         VLR__A With aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ],;
                         VENC_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ],;
                         DTQT_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ],;
                         PERC_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ],;
                         PRAZ_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ],;
                         BANC_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],;
                         CHEQ_A With aNFiscal[ P_FATURA ][ nCt ][ FAT_CHEQUE ]
           CASE nCt == 2
                Replace  VLR__B With aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ],;
                         DUPL_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ],;
                         VENC_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ],;
                         DTQT_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ],;
                         PERC_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ],;
                         PRAZ_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ],;
                         BANC_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],;
                         CHEQ_B With aNFiscal[ P_FATURA ][ nCt ][ FAT_CHEQUE ]
           CASE nCt == 3
                Replace  DUPL_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ],;
                         VLR__C With aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ],;
                         VENC_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ],;
                         DTQT_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ],;
                         PERC_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ],;
                         PRAZ_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ],;
                         BANC_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],;
                         CHEQ_C With aNFiscal[ P_FATURA ][ nCt ][ FAT_CHEQUE ]
           CASE nCt == 4
                Replace  DUPL_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_NUMERO ],;
                         VLR__D With aNFiscal[ P_FATURA ][ nCt ][ FAT_VALOR ],;
                         VENC_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_VENCIMENTO ],;
                         DTQT_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_PAGAMENTO ],;
                         PERC_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_PERCENTUAL ],;
                         PRAZ_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_DIAS ],;
                         BANC_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_BANCO ],;
                         CHEQ_D With aNFiscal[ P_FATURA ][ nCt ][ FAT_CHEQUE ]
         ENDCASE
         nVezes:= nCt
         Replace NVezes With nVezes
     NEXT
     DBSelectAr( _COD_NFISCAL )
     Replace NVEZES With nVezes

     DBSelectAr( _COD_PEDBAIXA )
     FOR nCt:= 1 TO Len( aNFiscal[ P_PRODUTOS ] )
        Gravando( "Controle: " + aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ] )
        IF aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ] > 0
           DBAppend()
           Repl CODNF_ With aNFiscal[ P_CABECALHO ][ CAB_NOTAFISCAL ],;
                CODIGO With StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ),;
                CODCLI With aNFiscal[ P_CLIENTE ][ CLI_CODIGO ],;
                SERIE_ With "A",;
                CODPRO With StrZero( aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODIGO ], 7, 0 ),;
                CODFAB With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_CODFABRICA ],;
                DESCRI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_DESCRICAO ],;
                UNIDAD With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_UNIDADE ],;
                QUANT_ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_QUANTIDADE ],;
                VLRINI With 0,;
                PERDES With 0,;
                VLRUNI With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PRECOVENDA ],;
                IPI___ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALIPI ],;
                ICM___ With aNFiscal[ P_PRODUTOS ][ nCt ][ PRO_PERCENTUALICM ],;
                ENTREG With aNFiscal[ P_DIVERSOS ][ DIV_DATASAIDA ],;
                CODPED With StrZero( aNFiscal[ P_NUMERO ][ NUM_PEDIDO ], 8, 0 ),;
                DATSEL With Date()
        ENDIF
     NEXT
     Gravando( "Comissoes, aguarde..." )
     IF aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ]==5.22 .OR.;
        aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ]==5.12 .OR.;
        aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ]==6.12 .OR.;
        aNFiscal[ P_CABECALHO ][ CAB_NATOPERACAO ][ NAT_CODIGO ]==0.00
     //   GravaComissoes( nNumero )
     ENDIF

     /* FIM DA GRAVACAO */
     Gravando( " * * * * * * GRAVACAO FINALIZADA * * * * * * " )
     Aviso( " Gravada Nota Fiscal No. " + StrZero( nNumero, 6, 0 ) + " com sucesso.", 12 )
     Pausa()
     lOk:= .T.
  ENDIF
  LigaMouse( lMouse )
  SetColor( cCor )
  SetCursor( nCursor )
  ScreenRest( cTela )
  Return lOk

  Static Function Gravando( cDados )
  Scroll( 01, 01, 21, 78, 1 )
  @ 21,02 Say cDados
  Return Nil

  Static Function PegaCodFiscal( nCodigo )
  Local nOrdem:= IndexOrd(), nArea:= Select()
  DBSelectAr( _COD_CLASFISCAL )
  DBSetOrder( 1 )
  IF DBSeek( nCodigo )
     IF !nArea == 0
        DBSelectAr( nArea )
        DBSetOrder( nOrdem )
     ENDIF
     Return CF_->CodFis
  ELSE
     IF !nArea == 0
        DBSelectAr( nArea )
        DBSetOrder( nOrdem )
     ENDIF
     Return Space( 10 )
  ENDIF


  Static Function PegaNatOpera( nCodigo )
  Local nOrdem:= IndexOrd(), nArea:= Select()
  DBSelectAr( _COD_NATOPERA )
  DBSetOrder( 1 )
  IF DBSeek( nCodigo )
     IF !nArea == 0
        DBSelectAr( nArea )
        DBSetOrder( nOrdem )
     ENDIF
     Return CFO->DESCRI
  ELSE
     IF !nArea == 0
        DBSelectAr( nArea )
        DBSetOrder( nOrdem )
     ENDIF
     Return Space( 40 )
  ENDIF


  Static Function Perc( nVendedor, nTipoVenda )
  Local nPercentual:= 0
  Local nOrdem:= IndexOrd(), nArea:= Select()
  DBSelectAr( _COD_VENDEDOR )
  Set Filter To
  DBSetOrder( 1 )
  IF DBSeek( nVendedor )
     DO CASE
        CASE nTipoVenda == 1     /* A VISTA */
             nPercentual:= COMIVV
        CASE nTipoVenda == 2     /* A PRAZO */
             nPercentual:= COMIVP
        CASE nTipoVenda == 3     /* VENDAS RECEBIDAS */
             nPercentual:= COMIVR
        CASE nTipoVenda == 4     /* VENDA TOTAL */
             nPercentual:= COMIVT
     ENDCASE
  ENDIF
  IF ! nArea == 0
     DBSelectAr( nArea )
     DBSetOrder( nOrdem )
  ENDIF
  Return nPercentual

