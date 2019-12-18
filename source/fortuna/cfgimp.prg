// ## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ Impressora 
³ Finalidade  ³ Selecionar Configuracao de Impressora 
³ Parametros  ³ nCodigo = Codigo de caracteres 
³ Retorno     ³ String com configuracao 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function Impressora( nCodigo ) 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nArea:= Select() 
Local nTecla, oTab 
 
   Sele 222 

   // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
   #ifdef LINUX
     use "&gdir/cfgimp.dbf" 
   #else 
     USE "&Gdir\CFGIMP.DBF" 
   #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
   Index On NOME TO Impres 
   Locate For SELECT=="*" 
 
   VPBox( 06, 20, 16, 72, " IMPRESSORAS ", "15/01" ) 
   SetColor( "15/01,15/09" ) 
   oTab:=tbrowsedb(07,21,15,71) 
   oTab:addcolumn(tbcolumnnew("Impressora",{|| NOME + SPACE( 35 ) })) 
   oTab:addcolumn(tbcolumnnew("M",{|| SELECT})) 
   oTab:AUTOLITE:=.f. 
   oTab:dehilite() 
   mensagem("[ENTER]Seleciona") 
   ajuda("[PGUP][PGDN]["+chr(24)+chr(27)+chr(25)+chr(26)+"]Movimenta‡†o [ESC]Retorna") 
   setcursor(0) 
   while .t. 
      oTab:colorrect({oTab:ROWPOS,1,oTab:ROWPOS,oTab:COLCOUNT},{2,1}) 
      while nextkey()==0 .and. ! oTab:stabilize() 
      enddo 
      nTecla:=inkey(0) 
      do case 
         case nTecla==K_UP         ;oTab:up() 
         case nTecla==K_DOWN       ;oTab:down() 
         case nTecla==K_LEFT       ;oTab:up() 
         case nTecla==K_RIGHT      ;oTab:down() 
         case nTecla==K_PGUP       ;oTab:pageup() 
         case nTecla==K_CTRL_PGUP  ;oTab:gotop() 
         case nTecla==K_PGDN       ;oTab:pagedown() 
         case nTecla==K_CTRL_PGDN  ;oTab:gobottom() 
         case nTecla==32 
              nRecno:= RECNO() 
              DBGoTop() 
              Locate For SELECT=="*" 
              Rlock() 
              Replace SELECT With " " 
              DBGoTo( nRecno ) 
              RLock() 
              Replace SELECT With "*" 
              DBUnlockAll() 
         case nTecla==K_ENTER 
              DO CASE 
                 CASE nCodigo == 1 
                      cString:= Comp0 
                 CASE nCodigo == 2 
                      cString:= Comp1 
                 CASE nCodigo == 3 
                      cString:= Comp2 
                 CASE nCodigo == 4 
                      cString:= Comp3 
                 CASE nCodigo == 5 
                      cString:= Comp4 
                 CASE nCodigo == 6 
                      cString:= Comp5 
                 CASE nCodigo == 7 
                      cString:= Expl 
                 CASE nCodigo == 8 
                      cString:= Expd 
                 CASE nCodigo == 9 
                      cString:= Neg 
                 CASE nCodigo == 10 
                      cString:= Norm 
                 CASE nCodigo == 11 
                      cString:= Cartl 
                 CASE nCodigo == 12 
                      cString:= CartD 
                 CASE nCodigo == 13 
                      cString:= LPP6 
                 CASE nCodigo == 14 
                      cString:= LPP8 
                 CASE nCodigo == 15 
                      cString:= COMPRIMENT 
                 CASE nCodigo == 16 
                      cString:= PORTRAIT 
                 CASE nCodigo == 17 
                      cString:= PCOMPR 
                 CASE nCodigo == 18 
                      cString:= LANDSCAPE 
                 CASE nCodigo == 19 
                      cString:= LCOMPR 
                 CASE nCodigo == 20 
                      cString:= PORTA 
              ENDCASE 
              Exit 
         otherwise 
         tone(125); tone(300) 
      endcase 
      oTab:refreshcurrent() 
      oTab:stabilize() 
   enddo 
   dbCloseArea() 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   ScreenRest( cTela ) 
   DBSelectAr( nArea ) 
   cString:= EVAL( &( "{|| "+cString+" }" ) ) 
   Return cString 
 
