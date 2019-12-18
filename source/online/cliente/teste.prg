#include "windows.ch"
#include "guilib.ch"
 
STATIC lEnabled := .t.


Function Main
        Local oBitmap := HBitmap():AddResource("TESTE")

        Local MainForm
        
        INIT WINDOW MainForm MAIN TITLE "Teste" BACKGROUND BITMAP oBitmap  
       
        MainForm:Activate()

Return nil
 
