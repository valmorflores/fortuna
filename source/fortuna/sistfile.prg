// ## CL2HB.EXE - Converted
#Include "vpf.ch" 
#Include "inkey.ch" 
 
#ifdef HARBOUR
function sistfile()
#endif


/*****
�������������Ŀ 
� Funcao      � SISTFILE 
� Finalidade  � Definicao do Sistema de Arquivos - Generico / Por Empresa 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nTela:= 1 
 
   IF UseDBFGrupo() 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Index On ARQUIVO TO INDRES 
   ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   UserScreen() 
   SetColor( _COR_GET_EDICAO ) 
   VPBox( 00, 00, 22, 79, " SISTEMA DE ARQUIVOS ", _COR_GET_EDICAO ) 
   VPBox( 03, 02, 20, 60, " A C E S S O ", _COR_GET_EDICAO, .F., .F. ) 
   oTb:= TBrowseDb( 04, 03, 19, 59 ) 
   oTb:addcolumn(tbcolumnnew(,{|| " " + ARQUIVO + Str( AREA, 4, 0 ) + " * " + IF( GENERICO=="S", "Geral       ", "Por Empresa" ) + " " + GRUPO + Space( 30 ) })) 
   oTb:AUTOLITE:=.f. 
   oTb:dehilite() 
   WHILE .T. 
      oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
      whil nextkey()=0 .and.! oTb:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      If nTecla=K_ESC 
         nCodigo=0 
         exit 
      EndIf 
      do case 
         case nTecla==K_UP         ;oTb:up() 
         case nTecla==K_LEFT       ;oTb:up() 
         case nTecla==K_RIGHT      ;oTb:down() 
         case nTecla==K_DOWN       ;oTb:down() 
         case nTecla==K_PGUP       ;oTb:pageup() 
         case nTecla==K_PGDN       ;oTb:pagedown() 
         case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
         case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
         case nTecla==K_DEL 
              IF Exclui( oTb ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
              ENDIF 
         case nTecla==K_INS 
              DBAppend() 
              DBGoTop() 
              oTb:GoTop() 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
              Keyboard Chr( K_ENTER ) 
         case nTecla==K_ENTER 
              cArquivo:=  ARQUIVO 
              nAreaFile:= AREA 
              nModo:=     MODO 
              cCriar:=    IF( CRIAR, "S", "N" ) 
              cGrupo:=    GRUPO 
              cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
              VPBox( 05, 11, 18, 54, " INFORMACOES DE ABERTURA ", _COR_GET_EDICAO ) 
              @ 07,13 Say "Arquivo......: " Get cArquivo 
              @ 09,13 Say "Area.........: " Get nAreaFile Pict "999" 
              @ 11,13 Say "Grupo........: " Get cGrupo 
              @ 13,13 Say "Modo Abertura: " Get nModo 
              @ 15,13 Say "Criar........: " Get cCriar 
              READ 
              IF netrlock() 
                 Replace CRIAR With ( cCriar=="S" ),; 
                         MODO  With nModo,; 
                         GRUPO With cGrupo,; 
                         AREA  With nAreaFile,; 
                       ARQUIVO With cArquivo 
              ENDIF 
              DBUnlock() 
              ScreenRest( cTelaRes ) 
              oTb:RefreshAll() 
              WHILE !oTb:Stabilize() 
              ENDDO 
         case nTecla==K_SPACE 
              IF netrlock() 
                 nReg:= RECNO() 
                 cFile:= ARQUIVO 
                 cSimNao:= IF( GENERICO=="S", "N", "S" ) 
                 DBGoTop() 
                 WHILE !EOF() 
                     IF ARQUIVO==cFile 
                        IF netrlock() 
                           Replace GENERICO With cSimNao 
                        ENDIF 
                     ENDIF 
                     DBSkip() 
                 ENDDO 
                 DBUnlockAll() 
                 DBGoTo( nReg ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
              ENDIF 
         otherwise                ;tone(125); tone(300) 
      endcase 
      oTb:refreshcurrent() 
      oTb:stabilize() 
   ENDDO 
   DBCloseArea() 
   DBSelectAr( _COD_CLIENTE ) 
   Setcolor(cCOR) 
   Setcursor(nCURSOR) 
   Screenrest(cTELA) 
   Return(.T.) 
 
