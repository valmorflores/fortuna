// ## CL2HB.EXE - Converted
#Include "VPF.Ch" 
 
/* 
* 
*      Modulo - PRODUTOS 
*  Finalidade - Neste modulo existem funcoes que se referem aos produtos. 
* Programador - VPFlores 
*        Data - 
* Atualizacao - 
* 
*/ 
func Classtrib( nSituacaoTributaria, nTabela) 
loca cCOR:=setcolor(), nCURSOR:=setcursor(), cTELA:= ScreenSave( 00, 00, 24, 79 ) 
loca nLIN:=07, nCOL:=4, nOPCAO:=0, lFLAG:=.T. 
loca aTabela 
IF nTabela==1 
   aTabela:={ "  0 - Nacional                              ",; 
              "  1 - Estrangeira - Importacao direta       ",; 
              "  2 - Estrangeira - Adquirida Merc. Interno " } 
ELSEIF nTabela==2 
   aTabela:={ " 00 - Tributada integralmente                                        ",; 
              " 10 - Tributada e com cobranca do ICMS por substituicao tributaria   ",; 
              " 20 - Com reducao de base de calculo                                 ",; 
              " 30 - Isenta ou nao tributada e c/cob. ICMS por subst.tributaria     ",; 
              " 40 - Isenta                                                         ",; 
              " 41 - Nao tributada                                                  ",; 
              " 50 - Suspensao                                                      ",; 
              " 51 - Diferimento                                                    ",; 
              " 60 - ICMS cobrado anteriormente p/ substituicao tributaria          ",; 
              " 70 - Com reducao de base de calculo e cob.ICMS por subst.tributaria ",; 
              " 90 - Outras                                                         " } 
ENDIF 
for nCT:=1 to len( aTabela ) 
   if nSituacaoTributaria==val( alltrim( substr( aTabela[ nCT ], 2, 2 ) ) ) 
      lFlag:=.F. 
   endif 
next 
IF lFlag 
   SetColor( _COR_BROWSE ) 
   vpbox( nLIN, nCOL, nLIN+len(aTabela)+1, nCOL+len(aTabela[1])+1, , _COR_BROW_BOX, .T., .T., ) 
   whil nOPCAO=0 
      nOPCAO:=achoice(nLIN+1,nCOL+1,nLIN+len(aTabela),nCOL+len(aTabela[1]),aTabela) 
   enddo 
   IF nOpcao > 0 
      nSituacaoTributaria:= VAL( SubStr( aTabela[ nOPCAO ], 2, 2 ) ) 
   ENDIF 
ENDIF 
setcolor(cCOR) 
setcursor(nCURSOR) 
screenrest(cTELA) 
return(.T.) 
 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPSet 
³ Finalidade  ³ 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 08/Dezembro/1995 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
Function VPSet( nCodigo, Set ) 
Static VPSet 
   VPSet:= If( VPSet==Nil, { .F., .F. }, VPSet ) 
   If Empty( Set ) 
      Return( VPSet[ nCodigo ] ) 
   Else 
      VPSet[ nCodigo ]:= Set 
   EndIf 
   Return Nil 
 
