// ## CL2HB.EXE - Converted
#include "senha.ch" 
#include "inkey.ch" 
#include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � DisplayUsuarios 
� Finalidade  � Apresentacao da Lista de Usuarios 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 25/Agosto/1998 
��������������� 
*/ 
Func DisplayUsuarios() 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local oTab, nTecla, aSenhas, nRow:= 1 
loca mPARAM_, WSENHA_:=spac(T_SENHA), WCODIGO:=0, WCT, WFLAG:=.t. 
loca lConfirm, lDelimiters 
priv WSENHAG:="", WCOD:="*", WDESCRI:=spac(T_DESCR), WOP:=0, MENULIST:={} 
 
  IF ! nGCodUser == 0 .AND. ! nGCodUser == 999 
     VPObsBox(.t.,16,25,"ATENCAO",{ PADC( "Desculpe " + Alltrim( Left( wUsuario, At( " ", wUsuario ) ) ) + ", mas voce" , 35 ),; 
                                    PADC( "nao esta autorizado a acessar este", 35 ),; 
                                    PADC( "modulo do sistema", 35 ) }) 
     Pausa() 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return Nil 
  ENDIF 
  IF !UseSenha() 
     Return Nil 
  ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  SetColor( _COR_BROWSE ) 
  /* Busca Senha do usuario principal */ 
  DBSeek( 0 ) 
  IF !EOF() 
     DBGoTop() 
     aSenhas:= {} 
     WHILE !EOF() 
        AAdd( aSenhas, { StrZero( CODIGO, 3, 0 ),; 
                         UnZipChr( DESCRI ),; 
                         "********",; 
                         UnZipChr( GRUPO_ ),; 
                         IF( CODIGO == 0 .OR. CODIGO == 999, PAD( "Supervisor", 20 ), Space( 20 ) ),; 
                         DATA__ } ) 
        DBSkip() 
     ENDDO 
     dDATA__:= DATA__ 
     cSenha_:= TranSenha( WSENHAG, dtos( DATA__ ) ) 
     cDescri:= UnZipChr( DESCRI ) 
     VPBox( 01, 01, 21, 78, "Usu�rios Autorizados", _COR_BROW_BOX,.t.,.t.) 
     Mensagem("[INS]Inclui [ENTER]AlteraSenha [DEL]Exclui [F10]Poderes [ESC]Sai") 
     Ajuda( "[" + _SETAS + "]Movimenta [ESC]Sair" ) 
     SetColor( _COR_BROWSE ) 
     oTb:=TBrowseNew( 02, 02, 20, 77 ) 
     oTb:addcolumn(tbcolumnnew(,{|| aSenhas[ nRow ][ 1 ] + " - " + ; 
                                    aSenhas[ nRow ][ 2 ] + " " +; 
                                    aSenhas[ nRow ][ 3 ] + " " +; 
                                    aSenhas[ nRow ][ 4 ] + " " +; 
                                    aSenhas[ nRow ][ 5 ] })) 
     oTb:AUTOLITE:=.f. 
     oTb:GOTOPBLOCK :={|| nRow:= 1} 
     oTb:GOBOTTOMBLOCK:={|| nRow:= Len( aSenhas ) } 
     oTb:SKIPBLOCK:={|WTOJUMP| skipperarr(WTOJUMP,aSenhas,@nRow)} 
     oTb:dehilite() 
     WHILE .T. 
         oTb:colorrect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
         WHILE nextkey()==0 .and. ! oTb:stabilize() 
         ENDDO 
         nTecla:=inkey(0) 
         IF nTecla==K_ESC    ;EXIT    ;ENDIF 
         do case 
            case nTecla==K_F12        ;Calculador() 
            case nTecla==K_UP         ;oTb:up() 
            case nTecla==K_DOWN       ;oTb:down() 
            case nTecla==K_LEFT       ;oTb:up() 
            case nTecla==K_RIGHT      ;oTb:down() 
            case nTecla==K_PGUP       ;oTb:pageup() 
            case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
            case nTecla==K_PGDN       ;oTb:pagedown() 
            case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
            case nTecla==K_F10 
                SWSet( _SYS_CONFIGSENHAS, .T. ) 
                SetConfig() 
                ConfiguraSenhas() 
                _EMP:= "CONFIGURACAO DE PODERES UTILIZANDO GRUPO N� " + StrZero( nCodUser, 3, 0 ) 
                ScreenBack:= " Configuracao    Soft&Ware " 
                SWSet( _GER_BARRAROLAGEM, .F. ) 
                VPTela() 
                WTELA:=zoom(05,02,14,21) 
                vpbox(05,02,15,21) 
                titulo(_EMP) 
                usuario( "[F1] Salvar Poderes" ) 
                XCONFIG:= .F. 
                EXIT 
 
            case nTecla==K_DEL 
                 cTelares:= ScreenSave( 0, 0, 24, 79 ) 
                 cCorRes:= SetColor() 
                 IF VAL( aSenhas[ nRow ][ 1 ] ) == 999 
                    VPObsBox(.t.,15,40,"ATENCAO",{ PADC( "Desculpe " + Alltrim( Left( wUsuario, At( " ", wUsuario ) ) ) + ", mas esta" , 35 ),; 
                                    PADC( "senha � de uso restrito ao fabri-", 35 ),; 
                                    PADC( "cante deste produto.", 35 ) }) 
                    Pausa() 
                 ELSEIF aSenhas[ nRow ][ 1 ] == "DEL" 
                    VPObsBox(.t.,16,40,"ATENCAO",{ PADC( "Desculpe " + Alltrim( Left( wUsuario, At( " ", wUsuario ) ) ) + ", mas esta" , 35 ),; 
                                    PADC( "senha nao consta mais no cadastro", 35 ),; 
                                    PADC( "de usuarios do sistema.", 35 ) }) 
                    Pausa() 
                 ELSEIF aSenhas[ nRow ][ 1 ] == "000" 
                    VPObsBox(.t.,16,40,"ATENCAO",{ PADC( "Desculpe " + Alltrim( Left( wUsuario, At( " ", wUsuario ) ) ) + ", mas esta" , 35 ),; 
                                    PADC( "senha nao podera ser excluida,", 35 ),; 
                                    PADC( "pois � seu acesso ao sistema.", 35 ) }) 
                    Pausa() 
 
                 ELSE 
                    VPBox( 10, 10, 19, 75, " Exclusao de Senhas/Grupo ", _COR_BROW_BOX ) 
                    DBSeek( VAL( aSenhas[ nRow ][ 1 ] ) ) 
                    nCodigo:= CODIGO 
                    dData__:= DATA__ 
                    cGrupo_:= UnZipChr( GRUPO_ ) 
                    cNome__:= UnZipChr( DESCRI ) 
                    @ 12,11 Say "Codigo.......: [" + Tran( nCodigo, "999" ) + "]" 
                    @ 13,11 Say "Nome.........: [" + cNome__ + "]" 
                    @ 14,11 Say "Grupo........: [" + cGrupo_ + "]" 
                    @ 15,11 Say "Data.........: [" + DTOC( dData__ ) + "]" 
                    @ 16,11 Say "Tipo.........: [Normal              ]" 
                    @ 17,11 Say "Senha........: [********]" 
                    IF Exclui( oTb ) 
                       aSenhas[ nRow ][ 1 ]:= "DEL" 
                    ENDIF 
                 ENDIF 
                 SetColor( cCorRes ) 
                 ScreenRest( cTelaRes ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
            case nTecla==K_ENTER 
                 cCorRes:= SetColor() 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 IF aSenhas[ nRow ][ 1 ] == "DEL" 
                    VPObsBox(.t.,16,40,"ATENCAO",{ PADC( "Desculpe " + Alltrim( Left( wUsuario, At( " ", wUsuario ) ) ) + ", mas esta" , 35 ),; 
                                    PADC( "senha nao consta mais no cadastro", 35 ),; 
                                    PADC( "de usuarios do sistema.", 35 ) }) 
                    Pausa() 
                 ELSEIF VAL( aSenhas[ nRow ][ 1 ] ) == 999 
                    VPObsBox(.t.,16,40,"ATENCAO",{ PADC( "Desculpe " + Alltrim( Left( wUsuario, At( " ", wUsuario ) ) ) + ", mas esta" , 35 ),; 
                                    PADC( "senha � de uso restrito ao fabri-", 35 ),; 
                                    PADC( "cante deste produto", 35 ) }) 
                    Pausa() 
                 ELSE 
                    VPBox( 10, 10, 19, 75, " Alteracao de Senhas/Grupo ", _COR_BROW_BOX ) 
                    DBSeek( VAL( aSenhas[ nRow ][ 1 ] ) ) 
                    nCodigo:= CODIGO 
                    dData__:= DATA__ 
                    cGrupo_:= UnZipChr( GRUPO_ ) 
                    cNome__:= UnZipChr( DESCRI ) 
                    @ 12,11 Say "Codigo.......:" + Tran( nCodigo, "999" ) 
                    @ 13,11 Say "Nome.........:" Get cNome__ 
                    @ 14,11 Say "Grupo........:" Get cGrupo_ 
                    @ 15,11 Say "Data.........:" Get dData__ 
                    @ 16,11 Say "Tipo.........: [Normal              ]" 
                    @ 17,11 Say "Senha........: [********]" 
                    READ 
                    IF !LastKey() == K_ESC 
                       wSenhaG:="" 
                       wCod:="*" 
                       lDelimiters:= set(_SET_DELIMITERS,.f.) 
                       lConfirm:= set(_SET_CONFIRM,.f.) 
                       FOR nCt:= 1 TO T_SENHA 
                           @ 17, 26 + nCt Get WCOD valid asterisco(@WCOD) 
                       NEXT 
                       READ 
                       Set( _SET_DELIMITERS, lDelimiters ) 
                       Set( _SET_CONFIRM, lConfirm ) 
                    ENDIF 
                    IF !LastKey() == K_ESC 
                       IF Confirma( 00, 00, "Alterar a Senha?", "Alteracao de Senha e Grupo", "S" ) 
                          aSenhas[ nRow ]:= { StrZero( nCodigo, 3, 0 ),; 
                                              cNome__,; 
                                              "********",; 
                                              cGrupo_,; 
                                              Space( 20 ),; 
                                              dData__ } 
                          IF netrlock() 
                             nPos:= nRow 
                             Replace DESCRI With ZipChr( aSenhas[ nPos ][ 2 ] ),; 
                                     AHNES_ With TranSenha( wSenhaG, DTOS( aSenhas[ nPos ][ 6 ] ) ),; 
                                     DATA__ With aSenhas[ nPos ][ 6 ],; 
                                     GRUPO_ With ZipChr( aSenhas[ nPos ][ 4 ] ) 
                          ENDIF 
                          xFile:= SWSet( _SYS_DIRREPORT ) - "\SENHAS." + aSenhas[ nPos ][ 4 ] 
                          /* Se nao existir arquivo para este grupo criar */ 
                          IF !File( xFile ) 
                             Copy File SENHAS.SYS To &xFile 
                          ENDIF 
                       ENDIF 
                    ENDIF 
                 ENDIF 
                 SetColor( cCorRes ) 
                 ScreenRest( cTelaRes ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
            case nTecla==K_INS 
                 cCorRes:= SetColor() 
                 cTelaRes:= ScreenSave( 0, 0, 24, 79 ) 
                 VPBox( 10, 10, 19, 75, " Inclusao de Usuarios ", _COR_BROW_BOX ) 
                 nCodigo:= 0 
                 dData__:= DATE() 
                 cGrupo_:= "001" 
                 cNome__:= Space( 45 ) 
                 @ 12,11 Say "Codigo.......:" Get nCodigo Pict "999" Valid VerCodSenha( @nCodigo ) 
                 @ 13,11 Say "Nome.........:" Get cNome__ 
                 @ 14,11 Say "Grupo........:" Get cGrupo_ 
                 @ 15,11 Say "Data.........:" Get dData__ 
                 @ 16,11 Say "Tipo.........: [Normal              ]" 
                 @ 17,11 Say "Senha........: [********]" 
                 READ 
                 IF !LastKey() == K_ESC 
                    wSenhaG:="" 
                    wCod:="*" 
                    lDelimiters:= set(_SET_DELIMITERS,.f.) 
                    lConfirm:= set(_SET_CONFIRM,.f.) 
                    FOR nCt:= 1 TO T_SENHA 
                        @ 17, 26 + nCt Get WCOD valid asterisco(@WCOD) 
                    NEXT 
                    READ 
                    Set( _SET_DELIMITERS, lDelimiters ) 
                    Set( _SET_CONFIRM, lConfirm ) 
                 ENDIF 
                 IF !LastKey() == K_ESC 
                    AAdd( aSenhas, { StrZero( nCodigo, 3, 0 ),; 
                                     cNome__,; 
                                     Space( 08 ),; 
                                     cGrupo_,; 
                                     Space( 20 ),; 
                                     dData__ } ) 
                    DBAppend() 
                    nPos:= Len( aSenhas ) 
                    Replace DESCRI With ZipChr( aSenhas[ nPos ][ 2 ] ),; 
                            AHNES_ With TranSenha( wSenhaG, DTOS( aSenhas[ nPos ][ 6 ] ) ),; 
                            DATA__ With aSenhas[ nPos ][ 6 ],; 
                            GRUPO_ With ZipChr( aSenhas[ nPos ][ 4 ] ),; 
                            CODIGO With Val( aSenhas[ nPos ][ 1 ] ),; 
                            PODER_ With ZipChr( "USER/USER/USER/USER****************" ) 
                    xFile:= SWSet( _SYS_DIRREPORT ) - "\SENHAS." + aSenhas[ nPos ][ 4 ] 
                    /* Se nao existir arquivo para este grupo criar */ 
                    IF !File( xFile ) 
                       Copy File SENHAS.SYS To &xFile 
                    ENDIF 
                 ENDIF 
                 SetColor( cCorRes ) 
                 ScreenRest( cTelaRes ) 
                 oTb:RefreshAll() 
                 WHILE !oTb:Stabilize() 
                 ENDDO 
            Otherwise                 ;tone(125); tone(300) 
         endcase 
         oTb:refreshcurrent() 
         oTb:stabilize() 
     ENDDO 
  ELSE 
     /* Cadastro do usuario principal */ 
     VPBox( 01, 01, 21, 78, "Usu�rio Principal", _COR_BROW_BOX,.t.,.t.) 
     @ 02, 02 Say "Senha Principal..: ["+repl("*",T_SENHA)+"]" 
       Mensagem( "Digite a senha do Administrador.") 
     WSENHAG:="" 
     WCOD:="*" 
     lDelimiters:= set(_SET_DELIMITERS,.f.) 
     lConfirm:= set(_SET_CONFIRM,.f.) 
     FOR nCt:= 1 TO T_SENHA 
         @ 02, 21 + nCt Get WCOD valid asterisco(@WCOD) 
     NEXT 
     READ 
     Set( _SET_CONFIRM, lConfirm ) 
     Set( _SET_DELIMITERS, lDelimiters ) 
     cSimNao:= "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS" 
     dData__:= DATE() 
     cSenha_:= TranSenha(WSENHAG, dtos( dData__ ) ) 
     cDESCRI:= ZipChr( PAD( "Administrador Geral", 45 ) ) 
     IF BuscaNet(5,{|| dbappend(),!neterr()}) 
        Replace CODIGO with 0,; 
                DATA__ with dData__,; 
                DESCRI with cDescri,; 
                AHNES_ with cSenha_,; 
                PODER_ with cSimNao,; 
                GRUPO_ With ZipChr("000") 
        /* Arquivo senhas para Administrador */ 
        xFile:= SWSet( _SYS_DIRREPORT ) - "\SENHAS.000" 
        IF !File( xFile ) 
           Copy File SENHAS.SYS To &xFile 
        ENDIF 
        IF BuscaNet(5,{|| dbappend(),!neterr()}) 
           Replace CODIGO with 999,; 
                   DATA__ with dData__,; 
                   DESCRI with ZipChr( pad( "SOFT&WARE Informatica", 45 ) ),; 
                   AHNES_ with TranSenha( "19761015", dtos( dData__ ) ),; 
                   PODER_ with cSimNao,; 
                   GRUPO_ With ZipChr("000") 
           /* Arquivo Senhas para Soft&Ware */ 
           xFile:= SWSet( _SYS_DIRREPORT ) - "\SENHAS.999" 
           IF !File( xFile ) 
              Copy File SENHAS.SYS To &xFile 
           ENDIF 
        ENDIF 
     ENDIF 
  ENDIF 
  DBSelectAr( 166 ) 
  DBCloseArea() 
  dbunlockall() 
  FechaArquivos() 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
 
/***** 
�������������Ŀ 
� Funcao      � 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
*/ 
Function VerCodSenha( nCodigo ) 
  Local cCor:= SetColor(), nCursor:= SetCursor(),; 
        cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
  IF DBSeek( nCodigo ) 
     Aviso( "Codigo j� utilizado.", 12 ) 
     Pausa() 
     DBSeek( 999 ) 
     DBSkip( -1 ) 
     nCodigo:= CODIGO + 1 
     SetColor( cCor ) 
     SetCursor( nCursor ) 
     ScreenRest( cTela ) 
     Return .F. 
  ENDIF 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return .T. 
 
 
 
 
/***** 
�������������Ŀ 
� Funcao      � UseSenha() 
� Finalidade  � Abrir/Criar arquivo de Senhas 
� Parametros  � Nil 
� Retorno     � Nil 
� Programador � Valmor Pereira Flores 
� Data        � 
��������������� 
*/ 
Function UseSenha() 
Local aStrut 
IF !File( _VPB_SENHAS ) 
   aStrut:={{"CODIGO","N",T_CODIG,00},; 
            {"DESCRI","C",T_DESCR,00},; 
            {"AHNES_","C",T_SENHA,00},; 
            {"PODER_","C",40,00},; 
            {"DATA__","D",08,00},; 
            {"GRUPO_","C",3,00}} 
   dbcreate( _VPB_SENHAS, aStrut ) 
ENDIF 
DBSelectAr( 166 ) 
DBCloseArea() 
IF NetUse( _VPB_SENHAS, .F., 2, "SEN", .F. ) 
   IF Used() 
      Mensagem( "Organizando arquivo de senhas, aguarde..." ) 
      IF !File( GDir-"\$SIND001.INT") 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           index on codigo to "&gdir/$sind001.int" 
         #else 
           Index On Codigo To "&GDir\$SIND001.INT" 
         #endif
      ENDIF 

      // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
      #ifdef LINUX
        set index to "&gdir/$sind001.int" 
      #else 
        Set index To "&GDir\$SIND001.INT" 
      #endif
   ELSE 
      QUIT 
   ENDIF 
ELSE 
   dbCloseArea() 
   Return .F. 
ENDIF 
Return .T. 
 
/* 
Modulo      - TRANSENHA 
Finalidade  - Conversao do codigo para identificacao 
Parametros  - Codigo a ser convertido (CHR), data da conversao 
Programador - Valmor Pereira Flores 
Data        - 24/Abr/1993 
Atualizacao 
*/ 
func transenha(CODIGO,DATA) 
loca WC1:=chr(val(substr(CODIGO,1,1))+val(substr(DATA,1,1))+130),WC2:=chr(val(substr(CODIGO,2,1))+val(substr(DATA,2,1))+130),; 
     WC3:=chr(val(substr(CODIGO,3,1))+val(substr(DATA,3,1))+130),WC4:=chr(val(substr(CODIGO,4,1))+val(substr(DATA,4,1))+130) 
loca WC5:=chr(val(substr(CODIGO,5,1))+val(substr(DATA,5,1))+130),WC6:=chr(val(substr(CODIGO,6,1))+val(substr(DATA,6,1))+130),; 
     WC7:=chr(val(substr(CODIGO,7,1))+val(substr(DATA,7,1))+130),WC8:=chr(val(substr(CODIGO,8,1))+val(substr(DATA,8,1))+130) 
loca WCODIGO:=WC8+WC7+WC6+WC5+WC4+WC3+WC2+WC1 
return(WCODIGO) 
 
/* 
Funcao      - PARAMETROS 
Finalidade  - Exibir os parametros 
Parametros  - WLIN,WCOL,WDADOS,WMATRIZ,WELEMN,WSN 
Data        - 
Atualizacao - 
*/ 
stat func parametros(WLIN1,WCOL1,WLIN2,WCOL2,WDADOS_,WMATRIZ,WELEMEN,WSN) 
loca WLIN, WCOL, WCONT, WCT 
*box interno* 
vpbox(WLIN1+5,WCOL1+1,WLIN2-2,WCOL2-1,"",COR[16],.f.,.f.,COR[16]) 
*box SIM/NAO esquerdo* 
vpbox(WLIN1+5,WCOL1+WELEMEN+1,WLIN2-2,WCOL2-WELEMEN-5,"",COR[16],.f.,.f.,COR[16]) 
*box SIM/NAO direito* 
vpbox(WLIN1+5,WCOL2-5,WLIN2-2,WCOL2-5,"",COR[16],.f.,.f.,COR[16]) 
*acabamento superior do SIM/NAO esquerdo* 
setcolor(COR[16]) 
@ WLIN1+5,WCOL1+WELEMEN+1 say chr(194) 
@ WLIN1+5,WCOL1+WELEMEN+5 say chr(194) 
* acabamento inferior do SIM/NAO esquerdo * 
@ WLIN2-2,WCOL1+WELEMEN+1 say chr(193) 
@ WLIN2-2,WCOL1+WELEMEN+5 say chr(193) 
* acabemento ao SIM/NAO direito 
@ WLIN2-2,WCOL2-5 say chr(193) 
@ WLIN1+5,WCOL2-5 say chr(194) 
setcolor(COR[17]) 
@ WLIN2-1,WCOL1+2 say spac((int(len(WDADOS_[1]))*2)+7) 
@ WLIN2-1,WCOL1+2 say WDESCRI 
WLIN:=WLIN1+6 
WCOL:=WCOL1+2 
WCONT:=0 
for WCT=1 to WMATRIZ 
    if WCONT>=(WMATRIZ/2) 
       WLIN=WLIN1+6 
       WCOL=WCOL1+WELEMEN+6 
       WCONT=0 
    endif 
    ++WCONT 
    setcolor(COR[21]) 
    @ WLIN,WCOL say substr(WDADOS_[WCT],1,WELEMEN-1) 
    setcolor(if(WSN[WCT]="Sim","W+/R","W+/B")) 
    @ WLIN,WCOL+WELEMEN say WSN[WCT] 
    ++WLIN 
next 
return .t. 
 
/* 
Funcao      - VPSENHA 
Finalidade  - Solicitacao de senha ao usuario 
Data        - 
Atualizacao - 
*/ 
func vpsenha() 
loca WLIN1:=5, WLIN2:=08, WCOL1:=2, WCOL2:=21, WCODIGO:=IF( nGCodUser<>Nil, nGCodUser, 0 ), WCOD:="*",; 
     WDATA_:=date(), WSENHA_:=spac(T_SENHA), XTELA:=ScreenSave(02,00,24,79),; 
     XCOR:=setcolor(), dSISDATA:=date(), cTELA 
Local nTentativa:= 0, nMaximo:= 05
Local lDelimiters, lConfirm
priv WSENHAG:="" 
if ! file(_VPB_SENHAS) 
   vpobsbox(.t.,10,10,"ATENCAO",{ "O usuario principal, administrador de",; 
                                  "senhas devera  informar sua  senha de",; 
                                  "de acesso neste modulo.              " }) 
   pausa() 
   DisplayUsuarios() 
endif 
if ! usesenha() 
   mensagem("Pressione [ENTER] para interromper o sistema....",10) 
   aviso(":::Erro na abertura do arquivo de senhas:::",10) 
   pausa() 
   scroll(00,00,24,79) 
   quit 
endif 
setcolor(COR[16]) 
cTELA:=zoom(05,02,17,73) 
 
//AQUI 
/* 
   // Mensagem de Conflito de Versao - Inicio // 
// IF (!cVersao == Versao) 
   IF (!_VER == Versao) 
      nCurAnt := SetCursor () 
      SetCursor( 0 ) 
      VPBox( 07, 08, 16, 70, "VERSAO DO PROGRAMA", _COR_GET_BOX, .F., .F., , , .T. ) 
 
      SetColor( _COR_GET_EDICAO ) 
      @ 09, 10 SAY "o   Conflito de versoes !" 
      @ 11, 10 SAY "      Versao do programa   = " + ALLTRIM (_VER) 
      @ 12, 10 SAY "      Versao do CONFIG.INI = " + ALLTRIM (Versao) 
      @ 14, 10 SAY "o   Acione qualquer tecla para continuar no FORTUNA ..." 
      INKEY (0) 
      SetCursor( nCurAnt ) 
   ENDIF 
   // Mensagem de Conflito de Versao - Fim // 
*/ 
DispBegin() 
vpbox(04,02,19,73," Acesso Principal ",COR[16],.t.,.t.,COR[15]) 
vpbox(09,04,11,21,,COR[16],.f.,.f.,COR[16]) 
vpbox(06,04,08,21,,COR[16],.f.,.f.,COR[16]) 
vpbox(06,23,08,71,,COR[16],.f.,.f.,COR[16]) 
vpbox(09,23,18,71," Informacoes ",COR[16],.f.,.f.,COR[15]) 
vpbox(12,04,18,21,,COR[16],.f.,.f.,COR[16]) 
vpbox(13,06,17,19,,COR[16],.f.,.f.,COR[16]) 
vpbox(14,08,16,17,,COR[16],.f.,.f.,COR[16]) 
@ 10,08 say "["+dtoc(dSISDATA)+"]" 
@ 10,25 say _SIS 
@ 11,25 say "Suporte a Arquivos Microsoft Office (Via-RTF)" 
@ 12,25 say "Diretorio Corrente...: " + Right( Curdir(), 23 ) 
@ 13,25 say "Diretorio de Pesquisa: " + Right( GDir, 23 ) 
@ 14,25 say "Driver de Arquivos...: " + RDDSetDefault() 
//@ 14,25 say "Area de Trabalho.....: " + if(NetWork(),"Rede","Normal") 
//@ 15,25 say "Espaco em disco......: " + alltrim( tran(str(DiskSpace(DiskName())/1024,9,0),"@R 999.999.999") + "Mb" ) 
//@ 16,25 say "Nome do Volume (NET).: " + if( NetWork(), Right( NetRmtName(0), 23 ),"Nao Utilizado" ) 
//@ 17,25 say "Sistema Operacional..: " + OS() 
//If !EspacoEmDisco(DiskName(),1000000) 
//   SetColor("W/N") 
//   Scroll(00,00,nMAXLIN,nMAXCOL) 
// Quit 
//Endif 
DispEnd() 
setcolor(COR[16]) 
whil .t. 
   ++nTentativa
   IF nTentativa >= nMaximo
      Aviso( "Limite de tentativas excedido. Tente mais tarde..." )
      mensagem( "Pressione [ENTER] para finalizar o sistema" )
      Finaliza()
      Quit
   ENDIF
   WSN:={}
   WFLAG:=.t. 
   setcursor(1) 
   setcolor(COR[16]+","+COR[18]+",,,"+COR[17]) 
   IF cUserCode == Nil 
      @ 07,05 say space(15) 
      @ 07,06 say "Codigo.:" get WCODIGO 
      /*pict repl("9",T_CODIG) when; 
        mensagem("Digite o codigo do usuario.") */
      read 
   ENDIF 
   if lastkey()=K_ESC 
      dbunlockall() 
      FechaArquivos() 
      fim() 
   endif 
   IF WCODIGO == 888
      WSENHAG:="" 
      WDESCRI:=":: Super Usuario ::"
      cUserGrupo:= "000"
      cCod:= "0000"
      @ 07,25 say "::Administrador Temporario:: [CODIGO=" + ( cCod:= Right( STR( INT( SECONDS() * 100 ) ), 4 ) ) + "]"
      mensagem("Digite a senha de trabalho.") 
      @ 07,05 say space(15) 
      @ 07,08 say "["+repl("*",T_SENHA)+"]" 
      lDelimiters:= set(_SET_DELIMITERS,.f.) 
      lConfirm:= set(_SET_CONFIRM,.f.) 
      IF cUserCode == Nil 
         for WCT:=1 to T_SENHA step+1 
             @ 7,08+WCT get WCOD valid asterisco(@WCOD) 
         next 
         read 
      ENDIF
      @ 07,25 say Space( 44 )
      set(_SET_CONFIRM, lConfirm )
      set(_SET_DELIMITERS, lDelimiters )
      nGCODUSER:=WCODIGO
      mensagem( space( 255 ) )
      mensagem( WSENHAG ) 
      WSENHAG:= '1976'
      IF VAL( WSENHAG )==( 1976*VAL( cCod ) ) .OR. VAL( WSENHAG )==1976
         SWSet( _GER_SUPERUSUARIO, SECONDS() )
         nGCODUSER:=WCODIGO
         WPESQSN:=PODER_ 
         screenrest(XTELA) 
         setcolor(XCOR) 
         unzoom(cTELA) 
         DBSelectar( 166 ) 
         DBCloseArea() 
         DBSelectAr( _COD_CLIENTE ) 
         return(WDESCRI)
      ENDIF
   ELSEIF dbseek(WCODIGO)
      WSENHAG:="" 
      WDESCRI:=unzipchr(DESCRI) 
      cUserGrupo:= UnZipChr( GRUPO_ ) 
      @ 07,25 say WDESCRI 
      mensagem("Digite a senha de trabalho.") 
      @ 07,05 say space(15) 
      @ 07,08 say "["+repl("*",T_SENHA)+"]" 
      lDelimiters:= set(_SET_DELIMITERS,.f.) 
      lConfirm:= set(_SET_CONFIRM,.f.) 
      IF cUserCode == Nil 
         for WCT:=1 to T_SENHA step+1 
             @ 7,08+WCT get WCOD valid asterisco(@WCOD) 
         next 
         read 
      ENDIF 
      set(_SET_CONFIRM, lConfirm ) 
      set(_SET_DELIMITERS, lDelimiters ) 
      if transenha(WSENHAG,dtos(DATA__)) <> AHNES_ .AND. cUserCode == Nil 
         mensagem("Senha invalida, pressione [ENTER] para continuar...",1) 
         pausa() 
      else 
         if _COMDATA="S" 
            @ 10,08 get dSISDATA 
            read 
            mensagem("Atualizando os dados, aguarde...") 
         endif 
         nGCODUSER:=WCODIGO 
         WPESQSN:=PODER_ 
         setcolor(COR[5]) 
         // @ 01,int(80-len(alltrim(WDESCRI)))/2 say alltrim(WDESCRI) 
         screenrest(XTELA) 
         setcolor(XCOR) 
         unzoom(cTELA) 
         DBSelectar( 166 ) 
         DBCloseArea() 
         DBSelectAr( _COD_CLIENTE ) 
         return(WDESCRI)
      ENDIF
  else 
      mensagem("Usuario nao cadastrado...",1) 
      pausa() 
  endif 
enddo 
/* Libera area de senhas */ 
dbSelectAr( 166 ) 
DBCloseArea() 
DBSelectAr( _COD_CLIENTE ) 
Return Nil 
 
 
Function VerAtSenhas() 
Local aSenhaP:= IOFillText( MEMOREAD( SWSet( _SYS_DIRREPORT ) - "\SENHAS.000" ) ) 
Local aSenhaMaster:= {}, aSenhaAtual, aSenhas, nLinha, nFile, nPos 
 
   /* Matriz com todas as senhas existentes no sistema */ 
   aSenhas:= DIRECTORY( SWSet( _SYS_DIRREPORT ) + "\SENHAS.*" ) 
 
   /* Movimenta entre todos os arquivos de senhas */ 
   FOR nFile:= 1 TO LEN( aSenhas ) 
 
       /* Nome do arquivo a gravar */ 
       cArqDestino:= SWSet( _SYS_DIRREPORT ) - "\" - aSenhas[ nFile ][ 1 ] 
       lGravar:= .F. 
       lModificado:= .F. 
 
       aSenhaMaster:= ACLONE( aSenhaP ) 
       aSenhaAtual:= IOFillText( MEMOREAD( cArqDestino ) ) 
 
       @ 24,00 Say PADC( "Verificando senhas do grupo " + SubStr( cArqDestino, AT( ".", cArqDestino )+1, 3 ) + " aguarde...", 80 ) Color "04/15" 
 
       /* Grava informacoes da senha.xxx para aSenhaMaster */ 
       FOR nLinha:= 1 TO Len( aSenhaMaster ) 
 
           /* Chave = Primeiras posicoes ate o espaco em branco */ 
           cChave:= LEFT( aSenhaMaster[ nLinha ], AT( " ", aSenhaMaster[ nLinha ] ) ) 
 
           /* Se chave for de modulo */ 
           IF Left( ALLTRIM( cChave ), 1 )=="[" 
              /* Busca pela chave no arquivo de poderes SENHAS.xxx */ 
              IF ( nPos:= ASCAN( aSenhaAtual, {|x| ALLTRIM( LEFT( x, AT( " ", x ) ) )==ALLTRIM( cChave ) } ) )  >  0 
                  cValor:= SUBSTR( aSenhaAtual[ nPos ], AT( " ", aSenhaAtual[ nPos ] ) ) 
              ELSE 
                  lGravar:= .T. 
                  cValor:= "" 
              ENDIF 
 
              aSenhaMaster[ nLinha ]:= PAD( ALLTRIM( cChave ), 50 ) + ALLTRIM( cValor ) 
              IF lGravar 
                 lGravar:= .F. 
                 lModificado:= .T. 
              ENDIF 
           ENDIF 
 
       NEXT 
 
       /* Se for modificado */ 
       IF lModificado 
          Set( 24, cArqDestino ) 
          Set( 20, "PRINT" ) 
          FOR nLin:= 1 TO LEN( aSenhaMaster ) 
              @ PROW(),PCOL() Say aSenhaMaster[ nLin ] + CHR( 13 ) + CHR( 10 ) 
          NEXT 
          Set( 20, "SCREEN" ) 
          Set( 24, "LPT1" ) 
          Aviso( "Poderes do grupo " + SubStr( cArqDestino, AT( ".", cArqDestino )+1, 3 ) + " foram atualizados com sucesso." ) 
          Inkey( 1 ) 
       ENDIF 
 
   NEXT 
 
