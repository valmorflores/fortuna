#include "VPF.CH"


#ifdef HARBOUR
function impprod()
#endif


// ## CL2HB.EXE - Converted
DBSelectAr( 1 ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  use dados/cdmprima.dbf alias mpr exclusive 
#else 
  USE DADOS\CDMPRIMA.DBF ALIAS MPR EXCLUSIVE 
#endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
INDEX ON INDICE TO INDRES 
DBSelectAr( 2 ) 

// Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
#ifdef LINUX
  use dados/produtos.dbf alias pro 
#else 
  USE DADOS\PRODUTOS.DBF Alias PRO 
#endif
DBGoTop() 
WHILE !EOF() 
   IF ! MPR->( DBSeek( PRO->INDICE ) ) 
      SetColor( "15/00" ) 
      ? DESCRI 
      DBSelectAr( 1 ) 
      dbAppend() 
      FOR nCt:= 1 TO LEN( DBStruct() ) 
          cCampo:= DBStruct()[ nCt ][ 1 ] 
          Replace MPR->&cCampo With PRO->&cCampo 
      NEXT 
      DBSelectAr( 2 ) 
   ELSE 
      SetColor( "15/01" ) 
      ? DESCRI 
      Replace MPR->DESCRI With PRO->DESCRI,; 
              MPR->UNIDAD With PRO->UNIDAD,; 
              MPR->PRECOV With PRO->PRECOV 
   ENDIF 
   DBSkip() 
ENDDO 
