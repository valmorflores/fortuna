// ## CL2HB.EXE - Converted
#include "inkey.ch" 
Function apagamov()

Local nTecla:= 0 


SET DELETED ON 
SET DATE BRITISH 
SET EPOCH TO 1980 
SET CENT ON 
SETBLINK( .F.) 
 
    SET COLOR TO "15/01,01/15" 
 
    cls 
 
@ 00,00 SAY PAD( " PROGRAMA DE MANUTENCAO EM LANCAMENTOS ", 80 ) COLOR "00/14" 
 

    // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
    #ifdef LINUX
      use dados/moviment.dbf alias mov 
    #else 
      USE DADOS\MOVIMENT.DBF ALIAS MOV 
    #endif

    // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
    #ifdef LINUX
      set index to dados/movind01.ntx,dados/movind02.ntx 
    #else 
      SET INDEX TO DADOS\MOVIND01.NTX,DADOS\MOVIND02.NTX 
    #endif
 
 
    @ 04,00 SAY REPL( "_", 80 ) 
 
 
   /* inicializacao do browse */ 
   oTb:=TBrowseDb( 05, 00, 24, 78 ) 
 
 
        aStrut:={{ "DATA__", "D", 08, 00 },; 
                 { "NCONTA", "N", 04, 00 },; 
                 { "TCONTA", "C", 01, 00 },; 
                 { "DCONTA", "C", 30, 00 },; 
                 { "HISTO1", "C", 30, 00 },; 
                 { "HISTO2", "C", 30, 00 },; 
                 { "DEBITO", "N", 16, 02 },; 
                 { "CREDIT", "N", 16, 02 } } 
 
 
   oTb:AddColumn( TbColumnNew("DATA   ",; 
                  {|| DTOC( DATA__ ) + " " + STRZERO( NCONTA, 4, 0 )+TCONTA + " " + HISTO1 + Tran( DEBITO, "@E 9999,999.99" ) + Tran( CREDIT, "@E 9999,999.99" ) ; 
                       } ) ) 
 
   oTb:AUTOLITE:=.F. 
   oTb:dehilite() 
   While .T. 
 
       oTb:ColorRect({oTb:ROWPOS,1,oTb:ROWPOS,1},{2,1}) 
       While !oTb:Stabilize() 
       enddo 
       @ 02,02 say HISTO1 
       @ 03,02 say HISTO2 
       nTecla:= inkey(0) 
       If nTecla=K_ESC 
          Exit 
       EndIf 
 
       do case 
          case nTecla==K_UP         ;oTb:up() 
          case nTecla==K_DOWN       ;oTb:down() 
          case nTecla==K_PGUP       ;oTb:pageup() 
          case nTecla==K_PGDN       ;oTb:pagedown() 
          case nTecla==K_CTRL_PGUP  ;oTb:gotop() 
          case nTecla==K_CTRL_PGDN  ;oTb:gobottom() 
          case nTecla==K_DEL 
               RLOCK() 
               DBDELETE() 
               DBUnLockAll() 
               oTb:RefreshAll() 
               WHILE !oTb:Stabilize() 
               ENDDO 
          otherwise                ;tone(125); tone(300) 
       endcase 
       oTb:Refreshcurrent() 
       oTb:Stabilize() 
   enddo 
   Return(.T.) 
 
