#include "windows.ch"
#include "guilib.ch"
 
STATIC lEnabled := .t.

Function Main
        Local MainForm
        
        INIT WINDOW MainForm MAIN TITLE "Teste" //ON Init {|| Teste() }

        MENU OF MainForm
           MENU TITLE "&Teste"
              MENUITEM "&Teste" ACTION Teste()
              SEPARATOR
              MENUITEM "&Sair" ACTION EndWindow()
           ENDMENU
        ENDMENU

        MainForm:Activate()

Return nil
 
 
Function Teste()
        Local oForm1, o1, o2, o3, o4
        Private x1 := 0
        Private x2 := Space(10)
        Private x3 := 1
        Private x4 := CtoD("")        
        Private x5 := .t.

        INIT DIALOG oForm1 CLIPPER NOEXIT  TITLE "teste" SIZE 696, 423 
            @ 8,8 TAB oTab ITEMS {} SIZE 673,345

            BEGIN PAGE 'Pedido' of oTab
        
                @ 24, 100 GET o1 VAR x1 SIZE  100,22 ID 2001
                @ 24, 150 GET o2 VAR x2 SIZE  100,22 ID 2002
                @ 24, 200 GET o3 VAR x3 SIZE  100,22 ID 2003
                @ 24, 250 GET o4 VAR x4 SIZE  100,22 ID 2004
                
                @ 24, 300 CHECKBOX x5 SIZE 100,22 ID 2005
            END PAGE of oTab
                 
                @ 528, 360 BUTTON 'Teste1' OF oForm1 SIZE 75,25 ON CLICK {|| Teste1() } 
                @ 608, 360 BUTTON 'Teste2' OF oForm1 SIZE 75,25 ON CLICK {|| Teste2() } 

        oForm1:Activate()                
        
        RETURN Nil
        
Function Teste1()
        
        EndDialog(getmodalhandle())
        
        return nil
        
        
Function Teste2()
        
//        msginfo(str(getdlgitem(getmodalhandle(), 2001)))
        MsgInfo(str(x1))
        return nil               
