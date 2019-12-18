// ## CL2HB.EXE - Converted
 
#include "vpf.ch"
#Include "Directry.Ch"

#ifdef HARBOUR
function conta()
#endif


DBCreate( "ARQUIVO", {{"PROGRAMA","C",200,0}} ) 
 
lFlagCreate:= .F. 
aArquivos:= Directory( "*.PRG" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
Use ARQUIVO.DBF EXCLUSIVE 
ZAP 
For nCt:= 1 To Len( aArquivos ) 
 
    /* Arquivo VPB */ 
    cArquivo:= aArquivos[ nCt ][ F_NAME ] 
 
    Append From &cArquivo SDF 
    @ 01,01 say LastRec() 
 
Next 
