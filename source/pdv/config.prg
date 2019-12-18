   #Include "VPF.CH"
   #Include "INKEY.CH"
   /*****
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ Funcao      ³ CONFIG
   ³ Finalidade  ³ Configuracao de Diretorios
   ³ Parametros  ³ Nil
   ³ Retorno     ³ Nil
   ³ Programador ³ Valmor Pereira Flores
   ³ Data        ³ 23/02/1999
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   */
   Para nEmp
   local Local1:= screensave(0, 0, 24, MaxCol()), Local2:= ;
      SetColor()
   IF !nEmp==Nil
      nArea:= Select()
      Sele 123
      USE VPCEICFG.DAT
      xdiretorio:= unzipchr( GDIR__ )
      IF !nEmp==0
         IF AT( "\0", xDiretorio ) > 0
            cDir:= ALLTRIM( SubStr( xDiretorio, 1, AT( "\0", xDiretorio ) - 1 ) ) + "\0" + StrZero( nEmp, 3, 0 )
         ELSE
            cDir:= Alltrim( xDiretorio ) + "\0" + StrZero( nEmp, 3, 0 )
         ENDIF
      ELSE
         IF AT( "\0", xDiretorio ) > 0
            cDir:= ALLTRIM( SubStr( xDiretorio, 1, AT( "\0", xDiretorio ) - 1 ) )
         ELSE
            cDir:= ALLTRIM( xDiretorio )
         ENDIF
      ENDIF
      Replace gdir__ with zipchr( PAD( cDir, LEN( GDIR__ ) ) )
      DBCloseArea()
      DBSelectAr( nArea )
      Return Nil
   ENDIF
   vpbox(0, 0, 24 - 2, MaxCol(), " Configuracao de Diret¢rios ", _COR_GET_BOX )
   sele 124
   use VPCEICFG.DAT
   xdiretorio:= unzipchr(gdir__)
   set scoreboard (.F.)
   setcolor( _COR_GET_EDICAO )
   mensagem("Digite o nome do diret¢rio de trabalho...")
   desligamou()
   IF AT( "\0", xDiretorio ) > 0
      cEmpresa:= ALLTRIM( SubStr( xDiretorio, AT( "\0", xDiretorio ) + 2 ) )
   ELSE
      cEmpresa:= "000"
   ENDIF
   @ 08, 02 Say "Diretorio Atual....: [" + PAD( CURDIR(), 30 ) + "]"
   @ 10, 02 Say "Diretorio de Dados.:" Get XDIRETORIO
   @ 12, 02 Say "Diretorio Report...: [" + PAD( SWSet( _SYS_DIRREPORT ), 30 ) + "]"
   @ 14, 02 Say "Empresa Selecionada: [" + cEmpresa + "]"
   DesligaMouse()
   READ
   replace gdir__ with zipchr(xdiretorio)
   gravaemdis()
   DBCloseArea()
   set color to W/N
   set color to (Local2)
   screenrest(Local1)
   return Nil

