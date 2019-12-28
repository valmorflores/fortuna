// ## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � ABREGRUPO 
� Finalidade  � Abrir arquivos em grupo 
� Parametros  � Nome do grupo 
� Retorno     � Se conseguiu 
� Programador � Valmor Pereira Flores 
� Data        � 20/Janeiro/1996 
��������������� 
*/ 
Function AbreGrupo( cGrupo ) 
   LOCAL GetList:= {} 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
   LOCAL lAbriu:= .T., nArea:= 0 
   LOCAL GDirRes:= GDir, cFalta, aArqNom := {} 
 
   FDBUseVPB( _COD_CLIENTE, 2 )
   cFalta := "# fortuna automacao comercial - Ocorrencias na Abertura/Conversao do FORTURNA" + _CRLF  
   cFalta += _CRLF 
   cFalta += ". Situa��o   Arquivo (" + DTOC (DATE ()) + " - " + TIME () + " h)" + _CRLF 
   cFalta += "  ���������� �������������������������������������������������������������������" + _CRLF 
   cGrupo:= PAD( cGrupo, 20 ) 
   IF UseDBFGrupo() 
      GRP->( DBSetOrder( 1 ) ) 
      GRP->( DBGoTop() )

      IF DBSeek( cGrupo ) 

//         aviso( GRP->GRUPO + " <> " + cGrupo )
//         Pausa()

         WHILE ALLTRIM( GRP->Grupo ) == ALLTRIM( cGrupo ) 
 
            //// Generico ou Por Empresa 
            IF GRP->GENERICO=="S" 
               IF AT( _PATH_SEPARATOR - "0", GDir ) > 0 
                 GDir:= SubStr( GDir, 1, AT( _PATH_SEPARATOR - "0", Gdir ) - 1 ) 
               ENDIF 
            ENDIF 
 
            cGRPArquivo:= M->GDIR - _PATH_SEPARATOR - alltrim( lower( GRP->ARQUIVO ) )
//#valmor:	    
//  aviso( cGRPArquivo )
//  Pausa()
  
            IF !File( cGRPArquivo ) 
               IF GRP->AREA == _COD_CLIENTE 
                  /* Verifica se existe o arquivo como .dbf */ 
                  IF File( StrTran( cGRPArquivo, ".dbf", ".dbf" ) ) 
                     cGRPArquivo:= StrTran( cGRPArquivo, ".dbf", ".dbf" ) 
                  ENDIF 
               ENDIF 
            ENDIF 
 
            IF !File( cGRPArquivo ) 
               IF GRP->Criar 
                  CreateVPB( GRP->Area ) 
               ELSE 
                  Aviso( "Arquivo " + cGRPArquivo + " n�o foi encontrado...", 24 / 2 ) 
                  Pausa() 
                  lAbriu:= .F. 
                  EXIT 
               ENDIF 
            ENDIF 
            Mensagem( "Abrindo arquivo " + cGRPArquivo + " aguarde..." ) 
	    
            IF !( ALLTRIM( Pad( cGRPArquivo, 76 ) + " " + GRP->GENERICO ) == "" ) 
               Debug( Pad( cGRPArquivo, 76 ) + " " + GRP->GENERICO ) 
            ENDIF 
 
            DBSelectAr( GRP->Area ) 
            IF !Used() 
 
               // ARQUIVOS DESNECESSARIOS AO SISTEMA 
               IF AT( "cdduplic.dbf", cGRPArquivo ) > 0 .OR. ; 
                  AT( "movestoq.dbf", cGRPArquivo ) > 0 
 
               // ARQUIVO NORMAL 
               ELSEIF File( cGRPArquivo ) 
                  fConv_VPB( cGRPArquivo, @cFalta, @aArqNom) // AQUI 
                  IF !FDBUseVPB( GRP->Area, GRP->Modo ) 
                     Aviso( "Atencao! Nao foi possivel abrir o arquivo " + cGRPArquivo + "...", 24 / 2 ) 
                     Mensagem( "Pressione [ENTER] para continuar..." ) 
                     Pausa() 
                     lAbriu:= .F. 
                     EXIT 
                  ELSE 
                     DBSelectAr( GRP->Area ) 
                     Set Filter To 
                     DBGotop() 
                  ENDIF 
               ELSE 
		  Aviso( "Nao foi possivel criar e nem abrir o arquivo " + cGrpArquivo )
		  Pausa()	         
	          lAbriu:= .F. 
                  //valmor: comentario temporario
		  ////EXIT 
               ENDIF 
            ELSE 
               DBSelectAr( GRP->Area ) 
               Set Filter To 
               DBGotop() 
            ENDIF 
            GDir:= GDirRes 
            DBSelectAr( 70 ) 
            DBSkip() 
         ENDDO 
         GDir:= GDirRes 
      ELSE 
         Aviso( "Grupo de arquivos " + trim( cGrupo ) + " nao foi localizado." ) 
         Pausa() 
         lAbriu:= .F. 
      ENDIF 
   ELSE 
      lAbriu:= .F. 
   ENDIF 
   IF !lAbriu 
      DBUnLockAll() 
      DBCloseArea() 
      DBSelectar( 70 ) 
      DBCloseArea() 
 
      DBSelectAr( nArea ) 
      //IF Used() 
         //DBSetOrder( 1 ) 
         //DBGoTop() 
      //ENDIF 
 
   ELSE 
      nArea:= GRP->Area 
      DBSelectar( 70 ) 
      DBCloseArea() 
      DBSelectAr( nArea ) 
      IF Used() 
         DBSetOrder( 1 ) 
         DBGoTop() 
      ENDIF 
   ENDIF 
 
   // Salvamento do arquivo LOG de ABERTURA 
   nCnt := 0 
   WHILE (.T.) 
      nCnt ++ 
      IF (nCnt > 99)
          #ifdef LINUX
          #else
            IF Diretorio( "TEMP" ) 
               RUN COPY TEMP\CONV_VPB.T?? TEMP\CONV_VPB.SWL > NUL 
               RUN DEL  TEMP\CONV_VPB.T?? > NUL
            ELSE 
               RUN COPY CONV_VPB.T?? CONV_VPB.SWL > NUL 
               RUN DEL  CONV_VPB.T?? > NUL 
            ENDIF
          #endif
          nCnt := 1 
      ENDIF 
      cCnt := STRZERO (nCnt, 2) 
 
      /* Testa a existencia do diretorio TEMPORARIO */
      cArqTmp:= "conv_vpb.t"+cCnt
      IF Diretorio( "temp" ) 
         IF FILE( "temp" + _PATH_SEPARATOR + cArqTmp )
            LOOP 
         ENDIF 
         MEMOWRIT( "temp" + _PATH_SEPARATOR + cArqTmp, cFalta ) 
      ELSE 
         IF FILE( cArqTmp )  
            LOOP 
         ENDIF 
         MEMOWRIT( cArqTmp, cFalta) 
      ENDIF 
      EXIT 
   ENDDO 
 
   GDir:= GDirRes 
 
   ScreenRest( cTela ) 
   Return lAbriu 
 
 
Function FechaGrupo( cGrupo ) 
   LOCAL cCor:= SetColor(), nCursor:= SetCursor(),; 
         cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
   cGrupo:= cGrupo + Space( 20 - Len( cGrupo ) ) 
   IF UseDBFGrupo() 
      IF DBSeek( cGrupo ) 
         WHILE GRP->Grupo == cGrupo 
            Mensagem( "Fechando o arquivo " + GRP->Arquivo + " aguarde..." ) 
            DBSelectAr( GRP->AREA ) 
            IF Used() 
               DBCloseArea() 
            ENDIF 
            DBSelectAr( 70 ) 
            DBSkip() 
         ENDDO 
      ENDIF 
   ENDIF 
   DBSelectar( 70 ) 
   DBCloseArea() 
   ScreenRest( cTela ) 
   Return .T. 
 
/***** 
�������������Ŀ 
� Funcao      � UseDbfGrupo 
� Finalidade  � Abrir arquivo que contem informacoes sobre grupo de DBF's 
�             � utilizados pelo sistema 
� Parametros  � Nil 
� Retorno     � Se Utilizado (.T.) 
� Programador � Valmor Pereira Flores 
� Data        � 07/Janeiro/1996 
��������������� 
*/ 
Function UseDBFGrupo() 
  Private DirGrupo:= Alltrim( SWSet( _SYS_DIRREPORT ) ) + _PATH_SEPARATOR 
  CriaDBFGrupo() 
  DBSelectAr( 70 ) 
  If !Used() 
     cFileOpen:= DirGrupo - + _PATH_SEPARATOR + "grupodbf.dbf" 
     Use &cFileOpen Alias GRP Shared 
     IF !FILE( "grupodbf.ntx" ) .OR. !FILE( "grupodb1.ntx" ) 
        Index On Grupo To grupodbf.ntx 
        Index On Area  To grupodb1.ntx
     ENDIF 
     ordListClear() 
     ordListAdd( "grupodbf.ntx" ) 
     ordListAdd( "grupodb1.ntx" ) 
     DBSetOrder( 1 ) 
  EndIf 
  Return( Used() ) 
 
/***** 
�������������Ŀ 
� Funcao      � CriaDbfGrupo 
� Finalidade  � 
�             � 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 07/Janeiro/1996 
��������������� 
*/ 
Static Function CriaDBFGrupo() 
  LOCAL aStruct:= { { "Grupo",     "C", 20, 00 },; 
                    { "Arquivo",   "C", 12, 00 },; 
                    { "Modo",      "N", 02, 00 },; 
                    { "Area",      "N", 03, 00 },; 
                    { "Criar",     "L", 01, 00 },; 
                    { "Diretorio", "C", 40, 00 },; 
                    { "Generico",  "C", 01, 00 } } 
  IF !File( Alltrim( SWSet( _SYS_DIRREPORT ) ) +  _PATH_SEPARATOR + "grupodbf.dbf" ) 
     DBCreate( Alltrim( SWSet( _SYS_DIRREPORT ) ) + _PATH_SEPARATOR + "grupodbf.dbf", aStruct ) 
     IF !File( Alltrim( SWSet( _SYS_DIRREPORT ) ) + _PATH_SEPARATOR + "grupodbf.dbf" ) 
        Aviso( "Arquivo " + Alltrim( SWSet( _SYS_DIRREPORT ) ) + _PATH_SEPARATOR + "grupodbf.dbf, nao foi localizado.", 12 ) 
        Pausa() 
     ENDIF 
  ENDIF 
  Return Nil 
 
Function BuscaArea( cArquivo ) 
  Local nArea:= 0 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UseDbfGrupo() 
  DBGoTop() 
  WHILE !EOF() 
      IF Alltrim( ARQUIVO )==Alltrim( cArquivo ) 
         nArea:= AREA 
         EXIT 
      ENDIF 
      DBSkip() 
  ENDDO 
  DBCloseArea() 
  Return nArea 
 
 
Function SetDiretorioPadrao( nArea ) 
Local nAreaRes:= Select() 
Static GDirRes 
   IF nArea <> Nil 
      GDirRes:= GDir 
      IF ( nArea > 0 .AND. nArea <= 122 .AND. nArea <> 70 ) .OR.; 
         nArea > 130 
         DBSelectAr( 70 ) 
         if .not. Used() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
            UseDBFGrupo() 
         endif 
         nReg:= RECNO() 
         DBSetOrder( 2 ) 
         IF DBSeek( nArea ) 
            IF GRP->GENERICO=="S" 
               IF AT( _PATH_SEPARATOR - "0", GDir ) > 0 
                  GDir:= SubStr( GDir, 1, AT( _PATH_SEPARATOR - "0", Gdir ) - 1 ) 
               ENDIF 
            ENDIF 
            DBGoTo( nReg ) 
            DBSetOrder( 1 ) 
         ENDIF 
         DBSelectAr( nAreaRes ) 
      ELSEIF nArea <= 0 
         GDirRes:= GDir 
      ENDIF 
   ENDIF 
   Return GDirRes 
 
 
 
Function RestDiretorioPadrao() 
   GDir:= SetDiretorioPadrao() 
   Return Nil 
 
 
Function AbreTabela( _cod, _file, _alias )
   
   DBSelectAr( _cod )
   fdbusevpb( _cod, 2 )
   //USE &_file ALIAS &_alias