// ## CL2HB.EXE - Converted
/* PreparaCompFeira */ 
#include "INKEY.CH" 
 
Function PCF 
 
 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
 
Priv GDir1, GDir2 
 
     Scroll( 0, 0, 24, 79 ) 
     @ 02,02 Say "Quando preparado, as informacoes existentes na pasta do FORTUNA-FEIRA sera" 
     @ 03,02 Say "limpa, ficando apenas os cadastros atualizados pelo servidor.             " 
 
   @ 05,02 Say "Execute esta operacao preferencialmente no sistema da feira" 
 
   if Confirma( 0, 0, "Prepara computador quer ser  levado a feira?" ) 
 
      GDir1:= "\\SERVIDOR\C\FORTUNA\DADOS" 
      GDir2:= "\\FEIRA\C\FORTUN~1\DADOS" 
 
      DBCloseAll() 
 
      GDir1:= GDir1 + Space( 30 ) 
      GDir2:= GDir2 + Space( 30 ) 
 
      Scroll( 01, 01, 22, 78 ) 
 
      @ 02,01 Say "Diretorio Servidor:" Get Gdir1 
      @ 03,01 Say "Diretorio Feira...:" Get GDir2 
      READ 
 
      GDir1:= AllTrim( Gdir1 ) 
      GDir2:= AllTrim( Gdir2 ) 
 
      if !( LastKey()==K_ESC ) 
 
         Aviso( "Aguarde, transferindo dados do servidor..." ) 
         !COPY "&GDir1\*.DBF" "&GDir2\."   
 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir2/pedidos_.dbf" alias ped exclusive 
         #else 
           USE "&GDir2\PEDIDOS_.DBF" ALIAS PED EXCLUSIVE 
         #endif
         ZAP 
 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir2/pedprod_.dbf" alias pxp exclusive 
         #else 
           USE "&GDir2\PEDPROD_.DBF" ALIAS PXP EXCLUSIVE 
         #endif
         ZAP 
 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir2/pedbaixa.dbf" alias pb_ exclusive 
         #else 
           USE "&GDir2\PEDBAIXA.DBF" ALIAS PB_ EXCLUSIVE 
         #endif
         ZAP 
 
      endif 
 
      DBCloseAll() 
      Scroll( 0, 0, 22, 79 ) 
        VPC15000() 
 
   endif 
 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return 
 
 
 
 
