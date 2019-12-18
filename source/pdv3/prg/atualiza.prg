#Include "VPF.CH"

***********************
Func AtualizaClientes()
Loca cTELA:= SCREENSAVE(00,00,24,79), cCor:= SetColor(), nCursor:= SetCursor()
loca nCODCLI
Loca nPEND__:=0, nQUIT__:=0, nINAD__:=0, nATRA__:=0, nCODIGO:=0
Loca lALTERA:=.F., aDADOS:={},;
     nLIN:=5, nCt:=1, nPosicao:= 0, nFim:= 0

MENSAGEM("Aguarde a atualizacao do arquivo de clientes...")
DbSelectar( _COD_CLIENTE )
IF !Used()
   AbreGrupo( "NOTA_FISCAL" )
   DBSelectAr( _COD_CLIENTE )
ENDIF
IF !Used()
   Return .F.
ELSEIF CLI->DATA__ == Date()        /* Ja esta atualizado */
   Return .T.
ENDIF

DbGoTop()
//Whil ! eof()
//   aDADOS[CODIGO]:={0,0,0,0,0}
   /* (1)Atrasado
      (2)Inadimplente
      (3)Pendente
      (4)Quitada
   */
//   DBSKIP()
//EndDo

VPBOX(03,27,16,75)
VPBOX(17,27,19,75)
DevPos(04,28);DevOut("Aguarde...")
DevPos(05,28);DevOut("Atualizando arquivo de clientes...")

DbSelectAr( _COD_CLIENTE )
nFim:= LastRec()
DbSelectar( _COD_DUPAUX )
Set Index To
DbGoTop()
nFim:= nFim + LastRec()
nPosicao:= 0
Whil ! eof()
   /* Verificacao de pressionamento de ESC */
   If Inkey()==27 .OR. LastKey()==27
      ScreenRest( cTela )
      SetColor( cCor )
      SetCursor( nCursor )
      FechaArquivos()
      Return .F.
   EndIf
   IF ( nPOS:= ascan( aDADOS, {|aVAL| aVAL[5]==CLIENT } ) ) == 0
      aadd(aDADOS,{0,0,0,0,CLIENT})
      nPOS:= Len(aDADOS)
   ENDIF
   IF !( VENC__ == Ctod("  /  /  ")) .AND. NFNULA <> "*"
      DO CASE
         CASE VENC__ < DTQT__ .AND.  DTQT__ == CTOD( "  /  /  " ) 
              //* Pagamento em atraso *//
              ++aDADOS[nPOS][1]
         CASE !( DTQT__==CTOD( "  /  /  " ) )
              //* Quitada NORMAL *//
              ++aDADOS[nPOS][4]
         CASE VENC__ < ( DATE() - 45 ) .AND. DTQT__==CTOD( "  /  /  " )
              //* Inadimplente (+DE 45 DIAS) *//
              ++aDADOS[nPOS][2]
         CASE DTQT__==CTOD( "  /  /  " ) .AND. VENC__ < DATE()
              //* Vlr. Pendente At‚ a data atual *//
              ++aDADOS[nPOS][3]
      ENDCASE
   ENDIF
   DevPos(04,28);DevOut("Lendo arquivo de duplicatas...    ")
   Scroll(05,28,15,74,1)
   @ 15,28 Say CDESCR
   @ 18,28 Say CDESCR
   @ 16,54 Say "#Duplicata:"+StrZero(Recno(),5,0)
   VPTerm( ++nPosicao, nFim )
   DbSkip()
EndDo

DbSelectAr(_COD_CLIENTE)
DbGOtOP()

WHILE ! EOF()
    /* Verificacao de pressionamento de ESC */
    If Inkey()==27 .OR. LastKey()==27
       ScreenRest( cTela )
       SetColor( cCor )
       SetCursor( nCursor )
       FechaArquivos()
       Return .F.
    EndIf
    Rlock()
    Repl DATA__ With Date()
    DBUnlockAll()
    If ( nPOS := ascan( aDADOS, {|aVAL| aVAL[5]==CODIGO } ) ) > 0
       If NetRlock()
          Repl DATA__ With Date(),;
               ATRA__ With aDADOS[nPOS][1],;
               INAD__ With aDADOS[nPOS][2],;
               PEND__ With aDADOS[nPOS][3],;
               QUIT__ With aDADOS[nPOS][4]
       Endif
       DBUnlockAll()
    Endif
    DevPos(04,28);DevOut("Atualizando arquivo de clientes...")
    @ 16,28 Say "#Cliente:"+StrZero(Recno(),5,0)
    @ 17,28 Say StrZero(CODIGO,5,0)
    SETCOLOR("14/" + CorFundoAtual() )
    SCROLL(05,28,15,74,1)


    /* Aqui eu testo se a matriz contem dados */
    IF Len( aDados ) = 0

       /* Se nao contem eu exibo a seguinte mensagem */
       VPObsBox(.T.,10,30, "Atencao",;
              {"Informa‡äes na Base de dados",;
               "sÆo insuficientes para gerar",;
               "esta estat¡stica...         "},"15/04" )

       /* aguardando a tecla ENTER */
       Mensagem( "Pressione ENTER para continuar..." )
       Ajuda( "[ENTER]Retorna" )
       Pausa()
       ScreenRest( cTela )

       /* retorno ao programa anterior */
       Return(.F.)

    ELSE
       IF Len( aDados[1] ) = 0
          VPObsBox(.T.,10,30, "AtencÆo",;
                 {"Informa‡äes na Base de dados",;
                  "sÆo insuficientes para gerar",;
                  "esta estat¡stica...         "},"15/04" )
          Mensagem( "Pressione ENTER para continuar..." )
          Ajuda( "[ENTER]Retorna" )
          Pausa()
          ScreenRest( cTela )
          Return(.F.)
       ENDIF
    ENDIF
    IF nPos > 0
       IF aDADOS[nPos][1] >0                  // Atrazado
          SETCOLOR("GR+/" + CorFundoAtual() )
       ELSEIF aDADOS[nPos][2] >0              // Inadimplente
          SETCOLOR("R+/"  + CorFundoAtual() )
       ELSEIF aDADOS[nPos][3] >0              // Pendente
          SETCOLOR("BG+/" + CorFundoAtual() )
       ELSEIF aDADOS[nPos][4] >0              // Quitada
          SETCOLOR("W+/"  + CorFundoAtual() )
       ENDIF
    ENDIF
    @ 15,28 Say DESCRI
    SetColor( "W/" + CorFundoAtual() )
    @ 18,28 Say DESCRI
    DBSkip()
    VPTerm( ++nPosicao, nFim )
ENDDO
VPTerm( .F. )
SCREENREST(cTELA)
Return(.T.)
