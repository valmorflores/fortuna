// ## CL2HB.EXE - Converted
#include "common.ch" 
#include "inkey.ch" 
#include "vpf.ch"

#ifdef HARBOUR
function reltela
#endif

VerArquivo() 
 
Function VerArquivo( cArquivo, nLin1, nCol1, nLin2, nCol2 ) 
 
   visualarq( cArquivo, nLin1, nCol1, nLin2, nCol2 ) 
 
******************************** 
function MSGC 
 
   parameters mensagem 
//   @ 24,  0 
//   @ 24, 40 - Len(mensagem) / 2 say mensagem 
   return .T. 
 
******************************** 
function VISUALARQ(Arg1, nLin1, nCol1, nLin2, nCol2 ) 
 
   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ; 
      Local8 
   Local3:= .F. 
   Local7:= {} 
   cFile:= Arg1 
   cPortaImpressao:= "LPT1" 
   begin sequence 
      Local8:= SaveScreen(Nil, Nil, Nil, Nil) 
      set scoreboard off 
      if (ISNIL(Arg1) .OR. !file(Arg1)) 
         msgc("Arquivo inexistente.", 5) 
         break 
      endif 
      if ((Local1:= fbrowsenew()) != Nil) 
         fbrowseope(Local1, Arg1) 
         Local1:ntop(    nLin1 ) 
         Local1:nleft(   nCol1 ) 
         Local1:nbottom( nLin2 ) 
         Local1:nright(  nCol2 ) 
         Local2:= tbcolumnnew(Nil, {|| SubStr(Local1:cargo()[2], ; 
            Local1:cargo()[3])}) 
         Local2:width(80) 
         Local1:addcolumn(Local2) 
         do while (!Local3) 
            do while (!Local1:stabilize()) 
            enddo 
            Local6:= InKey(0) 
            do case 
            case local6 == K_TAB 
                IF ( nOpcaoImpressao:= SWAlerta( "<< IMPRESSAO DE INFORMACOES >>; Selecione conforme opcoes de impressao:", { "Todo documento", "Cancelar" } ) )==2 
                ELSEIF nOpcaoImpressao==1 
                   SelecaoDevice() 
                   cPortaImpressao:= Set( 24 ) 
                   !TYPE &cFile >&cPortaImpressao 
                   Set( 24, "LPT1" ) 
                   Set( 24, "LPT2" ) 
                   Set( 24, cPortaImpressao ) 
                ENDIF 
            case Local6 == K_CTRL_ENTER ;ExecuteExternal() 
            case Local6 == 27 
               Local3:= .T. 
            case Local6 == 19 
               if (Local1:cargo()[3] > 1) 
                  Local1:cargo()[3]-- 
                  Local1:refreshall() 
               endif 
            case Local6 == 4 
               if (Local1:cargo()[3] < Len(Local1:cargo()[2])) 
                  Local1:cargo()[3]++ 
                  Local1:refreshall() 
               endif 
            case Local6 == 1 
               Local1:cargo()[3]:= 1 
               Local1:refreshall() 
            case Local6 == 6 
               Local1:cargo()[3]:= Max(1, Len(Local1:cargo()[2]) - ; 
                  Local2:width() + 1) 
               Local1:refreshall() 
            case Local6 == 9 
               if (Local1:cargo()[3] <= Len(Local1:cargo()[2]) - 10) 
                  Local1:cargo()[3]:= Local1:cargo()[3] + 10 
                  Local1:refreshall() 
               endif 
 
            case Local6 == 271 
               Local1:cargo()[3]:= Max(1, Local1:cargo()[3] - 10) 
               Local1:refreshall() 
            otherwise 
               if (stdmeth(Local1, Local6)) 
               else 
               endif 
            endcase 
         enddo 
      endif 
   end sequence 
   RestScreen(Nil, Nil, Nil, Nil, Local8) 
   FClose( Local1:Cargo()[1] ) 
   return Nil 
 
******************************** 
static function FILEPOS(Arg1) 
 
   return fseek(Arg1:cargo()[1], 0, 1) 
 
******************************** 
function FBROWSENEW 
 
   local oTb 
   oTb:= tbrowsenew() 
   oTb:Cargo:= array( 3 ) 
   oTb:cargo()[3]:= 1 
   oTb:gotopblock:= {|| filegofirs(oTb)} 
   oTb:gobottomblock:= {|| filegolast(oTb) } 
   oTb:skipblock:= {|_1| fileskip(_1, oTb)} 
   return oTb 
 
******************************** 
function FBROWSEOPE(Arg1, Arg2) 
 
   local Local1 
   Local1:= fopen(Arg2) 
   if (Local1 >= 0) 
      Arg1:cargo()[1]:= Local1 
      filegofirs(Arg1) 
   endif 
   return Local1 > 0 
 
******************************** 
procedure FILEBROWSE(Arg1) 
 
   fclose(Arg1:cargo()[1]) 
   return 
 
******************************** 
static procedure FILEGOFIRS(Arg1) 
 
   local Local1, Local2 
   Local2:= Arg1:cargo()[1] 
   fseek(Local2, 0, 0) 
   freadln(Local2, @Local1, 256) 
   Arg1:cargo()[2]:= Local1 
   fseek(Local2, 0, 0) 
   return 
 
******************************** 
static procedure FILEGOLAST(Arg1) 
 
   fseek(Arg1:cargo()[1], 0, 2) 
   goprevln(Arg1) 
   return 
 
******************************** 
static function FILESKIP(Arg1, Arg2) 
 
   local Local1 
   Local1:= 0 
   if (Arg1 > 0) 
      do while (Local1 != Arg1 .AND. gonextln(Arg2)) 
         Local1++ 
      enddo 
   else 
      do while (Local1 != Arg1 .AND. goprevln(Arg2)) 
         Local1-- 
      enddo 
   endif 
   return Local1 
 
******************************** 
function GONEXTLN(Arg1) 
 
   local Local1, Local2, Local3:= "", Local4, ; 
      Local5 
   Local1:= Arg1:cargo()[1] 
   Local2:= fseek(Local1, 0, 1) 
   fseek(Local1, Len(Arg1:cargo()[2]) + 2, 1) 
   Local5:= fseek(Local1, 0, 1) 
   if (freadln(Local1, @Local3, 256)) 
      Local4:= .T. 
      Arg1:cargo()[2]:= Local3 
      fseek(Local1, Local5, 0) 
   else 
      Local4:= .F. 
      fseek(Local1, Local2, 0) 
   endif 
   return Local4 
 
******************************** 
function FRWDSRCH(Arg1, Arg2) 
 
   local Local1, Local2, Local3, Local4 
   Local1:= Arg1:cargo()[1] 
   Local2:= .F. 
   Local3:= fseek(Arg1:cargo()[1], 0, 1) 
   Local4:= Arg1:cargo()[2] 
   do while (!Local2 .AND. gonextln(Arg1)) 
      Local2:= Arg2 $ Arg1:cargo()[2] 
   enddo 
   if (!Local2) 
      fseek(Local1, Local3, 0) 
      Arg1:cargo()[2]:= Local4 
   endif 
   return Local2 
 
******************************** 
init procedure CLIPINIT 
 
   public getlist:= {} 
   errorsys() 
   return 
 
 
******************************** 
function GOPREVLN(Arg1) 
 
   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ; 
      Local8, Local9 
   Local1:= Arg1:cargo()[1] 
   Local2:= fseek(Local1, 0, 1) 
   if (Local2 == 0) 
      Local5:= .F. 
   else 
      Local5:= .T. 
      fseek(Local1, -2, 1) 
      Local9:= Space(2) 
      fread(Local1, @Local9, 2) 
      if (Local9 == Chr(13) + Chr(10)) 
         fseek(Local1, -2, 1) 
      endif 
      Local3:= Min(256, fseek(Local1, 0, 1)) 
      Local6:= Space(Local3) 
      Local4:= fseek(Local1, -Local3, 1) 
      fread(Local1, @Local6, Local3) 
      Local7:= rat(Chr(13) + Chr(10), Local6) 
      if (Local7 == 0) 
         Local8:= Local4 
         Arg1:cargo()[2]:= Local6 
      else 
         Local8:= Local4 + Local7 + 1 
         Arg1:cargo()[2]:= SubStr(Local6, Local7 + 2) 
      endif 
      fseek(Local1, Local8, 0) 
   endif 
   return Local5 
 
******************************** 
function BKWDSRCH(Arg1, Arg2) 
 
   local Local1, Local2, Local3, Local4 
   Local1:= .F. 
   Local2:= Arg1:cargo()[1] 
   Local3:= fseek(Local2, 0, 1) 
   Local4:= Arg1:cargo()[2] 
   do while (!Local1 .AND. goprevln(Arg1)) 
      Local1:= Arg2 $ Arg1:cargo()[2] 
   enddo 
   if (!Local1) 
      fseek(Local2, Local3, 0) 
      Arg1:cargo()[2]:= Local4 
   endif 
   return Local1 
 
******************************** 
procedure ADDALLFIEL(Arg1) 
 
   local Local1, Local2, Local3 
   Local3:= FCount() 
   for Local2:= 1 to Local3 
      if (ISMEMO(fieldget(Local2))) 
         Local1:= tbcolumnnew(FieldName(Local2), memoblock(Local2)) 
      else 
         Local1:= tbcolumnnew(FieldName(Local2), ; 
            fieldblock(FieldName(Local2))) 
      endif 
      Arg1:addcolumn(Local1) 
   next 
   return 
 
******************************** 
function MEMOBLOCK(Arg1) 
 
   return {|_1| iif(ISNIL(_1), "Memo", fieldblock(FieldName(Arg1)))} 

******************************** 
function STDMETH(Arg1, Arg2) 
 
   local Local1 
   Local1:= .T. 
   do case 
   case Arg2 == 24 
      Arg1:down() 
   case Arg2 == 5 
      Arg1:up() 
   case Arg2 == 3 
      Arg1:pagedown() 
   case Arg2 == 18 
      Arg1:pageup() 
   case Arg2 == 31 
      Arg1:gotop() 
   case Arg2 == 30 
      Arg1:gobottom() 
   case Arg2 == 4 
      Arg1:right() 
   case Arg2 == 19 
      Arg1:left() 
   case Arg2 == 1 
      Arg1:home() 
   case Arg2 == 6 
      Arg1:end() 
   case Arg2 == 26 
      Arg1:panleft() 
   case Arg2 == 2 
      Arg1:panright() 
   case Arg2 == 29 
      Arg1:panhome() 
   case Arg2 == 23 
      Arg1:panend() 
   otherwise 
      Local1:= .F. 
   endcase 
   return Local1 
 
******************************** 
function FREADLN(Arg1, Arg2, Arg3) 
 
   local Local1, Local2, Local3, Local4 
   Local1:= Space(Arg3) 
   Arg2:= "" 
   Local4:= fseek(Arg1, 0, 1) 
   Local3:= fread(Arg1, @Local1, Arg3) 
   if ((Local2:= At(Chr(13) + Chr(10), SubStr(Local1, 1, Local3))) ; 
         == 0) 
      Arg2:= Local1 
   else 
      Arg2:= SubStr(Local1, 1, Local2 - 1) 
      fseek(Arg1, Local4 + Local2 + 1, 0) 
   endif 
   return Local3 != 0 
 
 
 
 
 
 
 
 
