// ## CL2HB.EXE - Converted
//------------------------ 
// RAFAEL 3374.3899 
// Auxiliar de Compras 
// Software Atual = Microsiga 
// BCM - AUTOMACAO PREDIAL 
//====================================== 
 
// 
// POEBARRA 
// Multi-empresa 
// Deve ser instalado no servidor 
// 
#INCLUDE "INKEY.CH" 
Local nOpcoes, nEmpresa 
Priv  GDir:= "DADOS" 
CLS 
nEmpresa:= 1 
@ 01,01 Prompt " 0> 0000 - EMPRESA PADRAO           " 
@ 02,01 Prompt " 1> 0001 - EMPRESA 1                " 
@ 03,01 Prompt " 2> 0002 - EMPRESA 2                " 
@ 04,01 Prompt " 3> 0003 - EMPRESA 3                " 
@ 05,01 Prompt " 4> 0004 - EMPRESA 4                " 
@ 06,01 Prompt " 5> 0005 - EMPRESA 5                " 
@ 07,01 Prompt " 6> 0006 - EMPRESA 6                " 
Menu to nEmpresa 
CLS 
IF nEmpresa == 1 
   GDir:= "DADOS" 
ELSE 
   GDir:= "DADOS\" + StrZero( nEmpresa-1, 4, 0 ) 
ENDIF 
IF File( GDir + "\CDMPRIMA.DBF" ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/cdmprima.dbf" alias mpr shared  
   #else 
     USE "&GDir\CDMPRIMA.DBF" ALIAS MPR SHARED  
   #endif
ELSE 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/cdmprima.vpb" alias mpr shared  
   #else 
     USE "&GDir\CDMPRIMA.VPB" ALIAS MPR SHARED  
   #endif
ENDIF 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
INDEX ON CODIGO TO INDICE 
IF File( GDir + "\CDMPRIMA.DBF" ) 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to indice, "&gdir/mprind01.ntx", "&gdir/mprind02.ntx", "&gdir/mprind03.ntx", "&gdir/mprind04.ntx", "&gdir/mprind05.ntx"      
   #else 
     SET INDEX TO INDICE, "&GDir\MPRIND01.NTX", "&GDir\MPRIND02.NTX", "&GDir\MPRIND03.NTX", "&GDir\MPRIND04.NTX", "&GDir\MPRIND05.NTX"      
   #endif
ELSE 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     set index to indice, "&gdir/mprind01.igd", "&gdir/mprind02.igd", "&gdir/mprind03.igd", "&gdir/mprind04.igd", "&gdir/mprind05.igd"      
   #else 
     SET INDEX TO INDICE, "&GDir\MPRIND01.IGD", "&GDir\MPRIND02.IGD", "&GDir\MPRIND03.IGD", "&GDir\MPRIND04.IGD", "&GDir\MPRIND05.IGD"      
   #endif
ENDIF 
@ 01,01 Prompt " 1> Barras convencional             " 
@ 02,01 Prompt " 2> Barras c/ Grupo+CodFor+Indice   " 
@ 03,01 Prompt " 0> Finaliza                        " 
Menu To nOpcoes 
DBGOTOP() 
matrix:={"|","/","-","\"} 
contnum:=matrixnum:=0 
setcursor(0) 
WHILE ! EOF() 
    matrixnum++ 
    @24,30 say strzero(contnum++)+"/"+strzero(lastrec(),9) 
    if matrixnum>4 
       matrixnum:=1 
    endif 
    @24,01 say matrix[matrixnum] 
    @24,78 say matrix[matrixnum] 
    DO CASE 
       CASE nOpcoes==1 
            IF EMPTY( CodFab ) 
               cCodigo:= StrZero( VAL( INDICE ), 12, 0 ) 
               cCodigo:= cCodigo + TWCalcDig( cCodigo ) 
               IF RLock() 
                   REPLACE CODFAB With cCodigo 
               ENDIF 
            ENDIF 
       CASE nOpcoes==2 
            IF EMPTY( CodFab ) 
               cCodigo:= PAD( Left( INDICE, 3 ) + StrZero( CODFOR, 4, 0 ) +; 
                         StrZero( VAL( SubStr( INDICE, 4, 4 ) ), 4, 0 ) + "0", 12 ) 
               cCodigo:= cCodigo + TWCalcDig( cCodigo ) 
               IF RLock() 
                  REPLACE CODFAB With cCodigo 
               ENDIF 
            ENDIF 
    ENDCASE 
    DBSkip() 
ENDDO 
