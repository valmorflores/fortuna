/*--------------------------------------------------------------------------+
|                                                                           |
|    Sistema.....: HELPd___________________________________HELP DINAMICO    |
|    Rotina......: Inc/Alt/Mostra HELPd________________________HELPd.PRG    |
|    Programador.: ____________________________________Aureo BITTENCOURT    |
|                                                                           |
+---------------------------------------------------------------------------+
|  Ver Data     Atualizacoes                                                |
|  1.0 25/10/89 Lancamento do HELPdinƒmico                                  |
|  2.0 09/01/92 Convers„o para Clipper 5.01                                 |
|  3.0 16/01/92 Inclus„o de acentua‡„o                                      |
|  3.1 27/06/92 Imprime HELPd que est  sendo mostrado atrav‚s ALT/P         |
|  3.2 28/06/92 Apos Inclus„o ou Altera‡„o permanece para outras rotinas    |
|  3.3 25/10/92 Inclus„o de SubHELPd para Prompt's                          |
+--------------------------------------------------------------------------*/

#Include "SoftBitt.ch"

*-------------------------
Function HELP(__r,__l,__v) //--> MOSTRA HELP PARA A ROTINA/VARIAVEL
*-------------------------
  Local __c, TemHELPd := .t., ValMenu

  Private __Rot:=PadR(__r,10), __Var:=PadR(__v,10), l__i, l__f, c__i, c__f, ;
          __alias, __sb, __fm, __xx, __yy, __cor, t__c, HELPdin := "HELPd", ;
          __psb:=.f., __id:="", __cursor, __insert, __Keys:={}, __SetKeys:={}

   __Entrada("V")

   ***> FIM DA DEMONSTRACAO?
    If EndDEMO()
       __Saida()
       Return(NIL)
    EndIF

  ***> DEFINICAO DA CHAMADA - SISTEMA OU USUARIO
   If LastKey()= -20         //--> HELPd - Usuario
      __Id := "U"
   ElseIF LastKey()=28       //--> HELPd - Sistema
      __Id := "S"
   EndIF

   ***> DEFINICAO DA CHAVE DE ACESSO
   If LastKey()=291          //--> HELPd - Manual
      __c := HELPdin+Space(5)+HELPdin+Space(5)+"H"
   Else
      __c := Left(__Rot+Space(10),10)+Left(__Var+Space(10),10)+__Id
   EndIF

   DbSeek(__c)                         // verifica existencia rotina/variavel

   ***> TEM REGISTRO PARA A FUNCAO x VARIAVEL
   If ! Found()
      TemHELPd := .f.

   ***> PROMPT?
   ElseIF Found() .and. HD_Campo9 = "S"
      TemHELPd := .f.
      ValMenu = &__Var.
      While HD_Campo1 = __Rot .and. HD_Campo2 = __Var .and. !Eof()

         ***> TEM HELPd PARA O OPCAO DO PROMPT
         If HD_Campo10 = ValMenu
            TemHELPd := .t.
            Exit
         EndIF

         DbSkip()

      EndDO

   EndIF

   If ! TemHELPd                        // nao existe help para rotina/var

      L__I := 9
      L__F := 13
      C__I := 25
      C__F := 53

      __Pbox()
      __Lbox()

      Say(11,31,"AJUDA INEXISTENTE","gr+/n")

      While LastKey() # _ESC
         InKey(0)                      // espera digitacao
      EndDO

      __Saida()                        // prepara para saida da rotina

      Return(NIL)                      // retorna para rotina da chamada
   EndIF                               // help rotina/variavel ja existe

   ***> CARREGA A POSICAO DO HELPd
   l__i := HD_Campo4                   // linha inicial do box de help
   l__f := HD_Campo5                   // linha final       "
   c__i := HD_Campo6                   // coluna inicial    "
   c__f := HD_Campo7                   // coluna final      "

   __Pbox()                            // Poe Box
   __Lbox()

   SetKey(16,{|| __ImprHELPd()})       // HotKey para impressao do Help
   SetColor("gr+/n")

   MemoEdit(HD_Campo8,l__i+1,c__i+1,l__f-1,c__f-1,.f.)

   SetKey(16,{})

   __Saida()                           // prepara para saida

Return(NIL)                            // retorna para rotina da chamada

*-------------------
Function __IMPRHELPd //--> IMPRIME HELP QUE ESTIVER SENDO MOSTRADO
*-------------------
   If IsPrinter()
      Set(_7Device,"PRINT")
      Say(PRow(),0,Chr(18) + "Rotina : " + Chr(14) + Trim(__Rot) + Chr(20) + ;
                   Space(5) + "Variavel : " + Chr(14) + Trim(__Var))
      Say(PRow()+1,0,Replicate("-",79))
      Say(PRow()+2,0,HD_Campo8)
      Say(PRow()+1,0,Replicate("-",79))
      Say(PRow()+2,0,Space(1))
      Set(_7Device,"SCREEN")
   EndIF
Return(NIL)

*----------------------------------
Function __HELPd(__r,__l,__v)  //--> MONTA HELP P/ROTINAS/VARIAVEIS
*----------------------------------
   Local _TN, _TS, __DtI, __DtF, _L1f, _L2f, _L3f, __c, TemHELPd:=.f.

   Private __Rot:=PadR(__r,10), __Var:= PadR(__v,10), ;
           l__i, l__f, c__i, c__f, ;
           i__a, t__h, t__c, __sb, __fm, tx__h, __xx, __yy,;
           __Cor, __Id, __pSB:=.t., __t, __pw, ;
           __Alias,__Cursor,__Insert,__SetKeys:={}, __Keys:={}, ;
           OpMenu := "N", ValMenu := 0, HELPdin := "HELPd"

   __Entrada("C")                      // PREPARA ENTRADA NA ROTINA

   ***> FIM DA DEMONSTRACAO?
   If EndDEMO()
      __Saida()
      Return(NIL)
   EndIF

   ***> DEFINICAO DO HELPD, SISTEMA OU DO USUARIO?
   __M24(">   Criar/Alterar HELP do [S]istema ou [U]su rio?")

   SetCursor(1)
   SetColor("n/w")

   __id := Space(01)

   While ! __id $"SU"
      Say(24,00,">")                   // prompt de espera
      __id := Upper(Chr(InKey(0)))     // espera digitacao/tecla digitada

      ***> ABANDONAR?
      If LastKey() = 27
         __Saida()
         Return(NIL)
      EndIF

   EndDO

   SetCursor(0)
   SetColor("w/n")

   ***> SE HELPD DO SISTEMA, PEDE A SENHA
   If __id = "S"
      __M24(" Entre com a Senha [        ]")

      SetColor("n/w")

      ***> SENHA INCORRETA?
      If Upper(Senha(24,20,8)) # __pw
         __M24(" Senha INCORRETA!!! Acesso NEGADO")
         __TecleEnter(.t.)
         __Saida()
         Return(NIL)
      EndIF

      ***> VARIAVEL NUMERICA COM VALOR INFERIOR A 30
      If Type("&__Var.") = "N" .and. &__Var. > 0 .and. &__Var. <= 30
         ***> DEFINICAO DE PROMPT DE MENU
         __M24(">   Estado de Espera ‚ Prompt de Menu [S]im ou [N]„o?")

         SetCursor(1)
         SetColor("n/w")

         OpMenu := " "

         While ! OpMenu $"SN"
            Say(24,00,">")                     // prompt de espera
            OpMenu := Upper(Chr(InKey(0)))     // espera digitacao/tecla digitada

            ***> ABANDONAR?
            If LastKey() = _ESC
               __Saida()
               Return(NIL)
            EndIF

         EndDO

         SetCursor(0)
         SetColor("w/n")

      EndIF

   EndIF

   ***> PROMPT?
   If OpMenu = "S"
      ValMenu := &__Var.
   EndIF

   ***> CHAVE DE CHAMADA
   __c := __Rot + __Var + __Id

   DbSeek(__c)                         // verifica existencia rotina/variavel

   ***> ALTERACAO/EXCLUIR HELP, ALTERAR/MOVER BOX
   If Found()                          // help rotina/variavel ja existe

      ***> PROMPT DE MENU?
      If OpMenu = "N"
         TemHELPd := .t.
         i__a := "a"                      // inc__alt = alt

      ***> PROMPT DE MENU
      Else

         While HD_Campo1 = __Rot .and. HD_Campo2 = __Var .and. ! Eof()

            ***> TEM HELPd PARA O OPCAO DO PROMPT
            If HD_Campo10 = ValMenu
               TemHELPd := .t.
               i__a := "a"                      // inc__alt = alt
               Exit
            EndIF

            DbSkip(1)

         EndDO

      EndIF

   EndIF

   ***> ALTERACAO DE HELPD EXISTENTE?
   If TemHELPd

      ***> COORDENADAS E TEXTO DO HELPd DO ARQUIVO
      l__i := HD_Campo4                 // linha inicial do box de help
      l__f := HD_Campo5                 // linha final       "
      c__i := HD_Campo6                 // coluna inicial    "
      c__f := HD_Campo7                 // coluna final      "
      tx__h:= HD_Campo8                 // texto de help

      __Pbox()
      __Lbox()

      KeyBoard( Chr(27) )

      SetColor("gr+/n")

      MemoEdit(tx__h,l__i+1,c__i+1,l__f-1,c__f-1,.f.)

   ***> INCLUSAO DE HELPd
   Else
      i__a := "i"                      // inc__alt = incluir
      Def__Box()                       // define box para help
      __Pbox()
      __Lbox()
      __Altera()
   EndIF

   ***> CONTROLE DE EXIBICAO DO HELPd
   If i__a="a"
      While .t.

         __M24(">   [E]xcluirHelp    [A]lterarHelp    Alterar[B]ox    [M]overBox    [F]inalizar")

         __t := __define("EABMF")

         ***> EXCLUIR HELP
         If __t = "E"
            __M24(" Excluindo a AJUDA. Aguarde...")
            DbDelete()
            Pack
            Exit

         ***> ALTERAR HELP
         ElseIF __t="A"
            __Altera()

         ***> ALTERAR BOX
         ElseIF __t="B"
            __AlteraBox()
            __Pbox()
            __Lbox()
            __Altera()

         ***> MOVER BOX
         ElseIF __t="M"
            __MoveBox()

         ***> FINALIZAR
         ElseIF __t="F"
            Exit
         EndIF

      EndDO
   EndIF

   __Saida()                           // prepara a saida da rotina

Return(NIL)                            // retorna para rotina da chamada

*------------------
Function DEF__BOX() //--> DEFINE BOX PARA INCLUSAO DO HELP
*------------------
   Private  __cm,__m

   ***> INCLUSAO?
   If i__a="i"
      l__i:=1                          // linha inicial - minimo
      l__f:=23                         // linha final - maximo
      c__i:=0                          // coluna inicial - minimo
      c__f:=79                         // coluna final - maximo
   EndIF

   ***> DEFINICAO DO CANTO SUPERIOR DO BOX
   __m:=" Posicione o Canto SUPERIOR do BOX com "+Chr(24)+", "+Chr(25)+","+;
        Chr(27)+" ou "+Chr(26)+" e Tecle ENTER"
   __M24(__m)

   t__h := SaveScreen(00,00,24,79)     // salva tela help

   SetColor("w/n")                     // cor neutra para montagem do box

   __t:=0                              // zera tecla digitada

   While __t # 13                      // enquanto nao For digitado ENTER
      RestScreen(00,00,24,79,t__h)     // restaura tela help

      __pbox()                         // poe box de acordo com coordenadas
      Say(l__i,c__i,Chr(218),"w+*/n")  // coloca canto superior piscante

      __t:=InKey(0)                    // espera digitacao/tecla digitada

      If __t=5                         // seta para cima
         --l__i                        // decrementa linha inicial
         If l__i < 1                   // menor que o minimo
            l__i:=1                    // valor minimo da linha inicial
            Tone(200,1)                // beep de alerta
         EndIF
      ElseIF __t=24                    // seta para baixo
         ++l__i                        // incrementa linha inicial
         If l__f - l__i = 1            // box sem espaco para help
            --l__i                     // retorna ao valor anterior da linha
            Tone(200,1)                // beep de alerta
         EndIF
      ElseIF __t=19                    // seta para esquerda
         --c__i                        // decrementa coluna
         If c__i < 0                   // menor que valor minimo
            c__i:=0                    // valor minimo da coluna inicial
            Tone(200,1)                // beep de alerta
         EndIF
      ElseIF __t=4                     // seta para direita
         ++c__i                        // incrementa coluna inicial
         If c__f - c__i < len(__sb)+3 .or. c__f - c__i < len(__fm)+3
            --c__i                     // retorna ao valor anterior da coluna
            Tone(200,1)                // beep de alerta
         EndIF
      EndIF                            // fim do teste da tecla digitada
   EndDO                               // fim enquanto __t diferente de 13

   ***> DEFINICAO DO CANTO INFERIOR DO BOX
   RestScreen(00,00,24,79,t__h)        // restaura tela da chamada

   __M24(SubStr(__m,1,19)+"INF"+SubStr(__m,23))

   t__h:=SaveScreen(00,00,24,79)       // salva tela help

   __t:=0                              // zera tecla digitada

   While __t # 13                      // enquanto nao For digitado ENTER
      RestScreen(00,00,24,79,t__h)     // restaura tela help

      __pbox()
      Say(l__f,c__f,Chr(217),"w+*/n")  // coloca canto inferior piscante

      __t:=InKey(0)                    // espera digitacao/tecla digitada

      If __t=5                         // seta para cima
         --l__f                        // decrementa linha final
         If l__f - l__i = 1            // box sem espaco help
            ++l__f                     // retorna ao valor anterior da linha
            Tone(200,1)                // beep de alerta
         EndIF
      ElseIF __t=24                    // seta para baixo
         ++l__f                        // incrementa linha final
         If l__f > 23                  // maior que valor maximo
            l__f:=23                   // valor maximo para linha final
            Tone(200,1)                // beep de alerta
         EndIF
      ElseIF __t=19                    // seta para esquerda
         --c__f                        // decrementa coluna final
         If c__f - c__i < len(__sb)+3  // largura minima da mensagem
            ++c__f                     // retorna ao valor anterior da coluna
            Tone(200,1)                // beep de alerta
         EndIF
      ElseIF __t=4                     // seta para direita
         ++c__f                        // incrementa coluna final
         If c__f > 79                  // maior que valor maximo
            c__f:=79                   // valor maximo para coluna final
            Tone(200,1)                // beep de alerta
         EndIF
      EndIF                            // fim do teste da tecla digitada
   EndDO                               // fim enquanto __t diferente de 13

Return(NIL)                            // retorna a rotina de chamada

*-----------------
Function __MOVEBOX //--> MOVE BOX NA TELA
*-----------------
   Local l__ia,l__fa,c__ia,c__fa,__box,;
         l__it,l__ft,c__it,c__ft,__boxT

   ***> SALVA COORDENADAS ATUAIS DO BOX
   l__ia := l__it := l__i
   l__fa := l__ft := l__f
   c__ia := c__it := c__i
   c__fa := c__ft := c__f

   __box:=SaveScreen(l__i,c__i,l__f,c__f)

   ***> INICIA MONTAGEM DE TELA VIRTUAL
   DispBegin()
      RestScreen(00,00,24,79,t__c)
      __boxT := SaveScreen(l__i,c__i,l__f,c__f)
      __M24(" Mova o BOX com "+Chr(24)+", "+Chr(25)+", "+Chr(27)+" ou "+Chr(26)+;
            " e Tecle ENTER")
   ***> ENCERRA MONTAGEM DA TELA VIRTUAL E APRESENTA
   DispEnd()

   __t := 0

   While __t # 13

      DispBegin()

      RestScreen(l__it,c__it,l__ft,c__ft,__boxT)
      l__it  := l__ia
      l__ft  := l__fa
      c__it  := c__ia
      c__ft  := c__fa
      __boxT := SaveScreen(l__it,c__it,l__ft,c__ft)

      RestScreen(l__ia,c__ia,l__fa,c__fa,__box)

      DispEnd()

      __t:=InKey(0)

      If __t=5
         If l__ia # 1
            --l__ia
            --l__fa
         Else
            Tone(200,1)
         EndIF
      ElseIF __t=24
         If l__fa # 23
            ++l__ia
            ++l__fa
         Else
            Tone(200,1)
         EndIF
      ElseIF __t=19
         If c__ia # 0
            --c__ia
            --c__fa
         Else
            Tone(200,1)
         EndIF
      ElseIF __t=4
         If c__fa # 79
            ++c__ia
            ++c__fa
         Else
            Tone(200,1)
         EndIF
      EndIF
   EndDO

   __M24(">  Confirma Nova posi‡„o do Box?  [S]im  [N]„o")

   If __define("SN")="S"
      ***> SALVA NOVA POSICAO DO BOX
      HELPd->HD_Campo4 := l__ia
      HELPd->HD_Campo5 := l__fa
      HELPd->HD_Campo6 := c__ia
      HELPd->HD_Campo7 := c__fa
      ***> ATUALIZA VARIAVEIS DE MEMORIA COM A NOVA POSICAO
      l__i := l__ia
      l__f := l__fa
      c__i := c__ia
      c__f := c__fa
   Else
      RestScreen(00,00,24,79,t__c)
      RestScreen(l__i,c__i,l__f,c__f,__box)
      __M24(" Box na posi‡„o original.")
      __TecleEnter(.t.)
   EndIF

Return(NIL)

*---------------------
Function __ALTERABOX() //--> REDIMENSIONA O BOX
*---------------------
   Private l__ia,l__fa,c__ia,c__fa,__box

   ***> SALVA COORDENADAS ATUAIS DO BOX
   l__ia := l__i
   l__fa := l__f
   c__ia := c__i
   c__fa := c__f

   __box := SaveScreen(l__i,c__i,l__f,c__f)

   RestScreen(00,00,24,79,t__c)
   RestScreen(l__i,c__i,l__f,c__f,__box)

   def__box()

   RestScreen(00,00,24,79,t__c)

Return(NIL)

*--------------
Function __PBOX //--> POE BOX ATUALIZADO
*--------------
   DispBox(l__i,c__i,l__f,c__f,1,"w/n")            // box definido para help
   If __psb
      Say(l__i,c__i+2,__sb,"w+/b")                 // Alteracao, poe SoftBitt
      Say(l__f,c__f-(len(__fm)+1),__fm,"w+/b")     // TEMPORARIO PARA A MITSU
   EndIF
*  Say(l__f,c__f-(len(__fm)+1),__fm,"w+/n")        // nome da empresa
Return(NIL)

*--------------
Function __LBOX //--> LIMPA BOX PARA HELP
*--------------
   SetColor("w/n")
   Scroll(l__i+1, c__i+1, l__f-1, c__f-1)
Return(NIL)

*----------------
Function __ALTERA //--> ALTERA EFETIVAMENTE O TEXTO DE HELP
*----------------
   Local tx__hA := tx__h

   __M24(" [ESC]=Encerra  [Ctrl/Y]=Del_Lin  [Ctrl/N]=Ins_"+;
         "Lin  ["+Chr(24)+Chr(25)+Chr(27)+Chr(26)+" PgUp PgDn]=Navega‡„o")

   ReadInsert(.f.)
   SetColor("gr+/n")
   SetCursor(1)
   SetKey(_ESC,{|| Hd_EscToCtrlW()})

   tx__h := MemoEdit(tx__h,l__i+1,c__i+1,l__f-1,c__f-1,.t.,"__acentuar")

   SetKey(_ESC,{})
   SetCursor(0)

   __M24(If(i__a="a",">   [G]ravarAltera‡„o  [D]esfazerAltera‡„o",;
                     ">   [G]ravarHelp  [D]esfazerHelp"))

   If __define("GD")="G"
      If i__a = "i"
         i__a := "a"
         DbAppend()
      EndIF
      HELPd->HD_Campo1 := __rot
      HELPd->HD_Campo2 := __var
      HELPd->HD_Campo3 := __id
      HELPd->HD_Campo4 := l__i
      HELPd->HD_Campo5 := l__f
      HELPd->HD_Campo6 := c__i
      HELPd->HD_Campo7 := c__f
      HELPd->HD_Campo8 := tx__h
      HELPd->HD_Campo9 := OpMenu
      HELPd->HD_Campo10:= ValMenu
   Else
      tx__h := tx__hA
      If i__a="a"
         KeyBoard Chr(27)
         SetColor("gr+/n")
         MemoEdit(tx__h,l__i+1,c__i+1,l__f-1,c__f-1,.f.)
      EndIF
   EndIF

Return(NIL)

*---------------------
Function Hd_EscToCtrlW //--> TRANSFORMA ESC PARA CTRL/W NA EDICAO DO HELP
*---------------------
   KeyBoard Chr(23)
Return(NIL)

*--------------------
Function __M24(__Msg) //--> LIMPA E MOSTRA MENSAGEM NA LINHA 24
*--------------------
   Say(24,00,PadR(__Msg,80),"n/w")
Return(NIL)

*--------------------------
Function __DEFINE(__opcoes) //--> PROMPT E DEFINICAO DE OPCAO
*--------------------------
   Local __Tecla:=" "

   SetCursor(1)
   SetColor("n/w")

   While ! __Tecla $(__opcoes)
      Say(24,00,">")                   // prompt de espera
      __Tecla := Upper(Chr(InKey(0)))  // espera digitacao/tecla digitada
   EndDO

   SetCursor(0)
   SetColor("w/n")

Return(__Tecla)

*---------------------------
Function __ENTRADA(VerCriar) //--> ENTRADA NA ROTINA
*---------------------------
   Private L_24 := SaveScreen(24,0,24,79)

   ***> SALVA O AMBIENTE DE CHAMADA
   __Alias := Alias()                  // salva area em uso da chamada
   __Cor   := SetColor()               // salva cor da rotina de chamada
   __Cursor:= SetCursor()              // salva tipo de cursor utilizado
   __Insert:= Set(27)                  // salva estado de insercao
   __xx    := Row()                    // salva linha do cursor
   __yy    := Col()                    // salva coluna do cursor
   t__c    := SaveScreen(00,00,24,79)  // salva tela da chamada

   Say(24,73,Space(1)+HELPdin+Space(1),If(VerCriar="V","w+*/n","n*/w"))

   SetCursor(0)

   ***> DESLIGA TECLAS DE CHAMADA DO HELP
   SetKey( 28,{})                      // desabilita HELPd
   SetKey(-20,{})                      // desabilita HELPd - usuario
   SetKey(-30,{})                      // desabilita HELPd - criar/alterar
   SetKey(291,{})                      // desabilita HELPd - Manual

   ***> SALVA E DESLIGA OUTRAS HOTKEYS
   For _x := -47 to 406
      If SetKey(_x) # NIL
         Aadd(__Keys,_x)
         Aadd(__SetKeys,SetKey(_x))
         SetKey(_x,{})
      EndIF
   Next

   __mvb()                             // monta variaveis basicas

   ***> ABRE O ARQUIVO DE HELPd
   If LastKey()=28          // ABRE ARQUIVO DE HELPd (SHARE)
      Use   (HELPdin) New ;
      Index (HELPdin)     ;
      Alias  HELPd
   Else                     // ABRE ARQUIVO DE HELPd (EXCLUSIVE)
      Use   (HELPdin) New ;
      Index (HELPdin)     ;
      Alias  HELPd        ;
      EXCLUSIVE
   EndIF

   SetColor("w/n")

   RestScreen(24,0,24,79,L_24)

Return(NIL)

*---------------
Function __SAIDA //--> SAIDA DA ROTINA
*---------------
   Local _x

   ***> RESTAURA O AMBIENTE DE CHAMADA
   RestScreen(00,00,24,79,t__c)        // restaura tela da chamada
   SetColor(__Cor)                     // restaura cor da chamada
   SetCursor(__Cursor)                 // restaura cursor da chamada
   Set(27,__Insert)                    // restaura estado de insercao
   SetPos(__xx,__yy)                   // restaura posicao cursor da chamada
   DbCloseArea()                       // fecha arquivo de help

   If ! Empty(__alias)
      DbSelectArea(__alias)            // restaura area da chamada
   EndIF

   ***> LIGA TECLAS DE CHAMADA DO HELPd
   SetKey( 28,{|p,l,v| Help(p,l,v)})       // habilita HELPd
   SetKey(-20,{|p,l,v| Help(p,l,v)})       // habilita HELPd usuario
   SetKey(291,{|p,l,v| Help(p,l,v)})       // habilita HELPd Manual
   SetKey(-30,{|p,l,v| __HELPd(p,l,v)})    // habilita HELPd Criar/Alterar

   ***> LIGA EVENTUAIS HOTKEYS
   For _x := 1 to Len(__Keys)
      SetKey(__Keys[_x],__SetKeys[_x])
   Next

Return(NIL)

*-------------
Function __MVB //--> MONTA VARIAVEIS BASICAS
*-------------
   Local __1,__2,__3,__4,__sbb,__fmb,__pwb,__x
   __sb := __fm := __pw := ""
   __1 := 177234217
   __2 := 246147226
   __3 := 249250
   __sbb :=Str(__1,9,0)+Str(__2,9,0)+Str(__3,6,0)     // SoftBitt
   __1 := 179166177
   __2 := 168175142
   __3 := 169182161
   __4 := 170
   __fmb:= Str(__1,9,0)+Str(__2,9,0)+Str(__3,9,0)+Str(__4,3,0)   // VOTORANTIM
   __1 := 052051050
   __2 := 049049050
   __3 := 051052
   __pwb := StrZero(__1,9)+StrZero(__2,9)+StrZero(__3,6)    // 43211234
   For __x:=1 to 12
      If __x <= len(__pwb)/3
         __pw += Chr(val(SubStr(__pwb,(__x-1)*3+1,3)))
      EndIF
      If __x <= len(__fmb)/3
         __fm += Chr((val(SubStr(__fmb,(__x-1)*3+1,3)) - ( __x +  6 ))/2)
      EndIF
      If __x <= len(__sbb)/3
         __sb += Chr((val(SubStr(__sbb,(__x-1)*3+1,3)) - ( __x + 10 ))/2)
      EndIF
   Next

   ***> PARA O TADEU...
   __fm := Space(1)+__sb+Space(1)
   __sb := Space(1)+HELPdin+Space(1)
*  __sb := Chr(40)+StrZero(41,3)+Chr(41)+Str(377,3)+Chr(45)+Str(1961,4)

Return(NIL)

*----------------------------
Function __TecleEnter(PoeMsg) //--> ESPERA PELA TECLA [ENTER]
*----------------------------
   Local __k:=0

   If PoeMsg
      Say(24,68,"Tecle ENTER","n*/w")
   EndIF

   Tone(440,0.2)
   Tone(493,0.2)

   SetCursor(0)

   While __k # 13
      __k := InKey(0)
   EndDO

Return(NIL)

*----------------------------------
Function __ACENTUAR(status,lin,col) // ACENTUA CAMPOS MEMO
*----------------------------------
   Local __CurAnt, _k1, _k2, _k3

   ***> MUDA DE CURSOR SE INSERCAO SOLICITADA
   If LastKey()=22
      If ! ReadInsert()
         SetCursor(2)
      Else
         SetCursor(1)
      EndIF
   EndIF

   _k1 := LastKey()

   ***> NUNHUM CARACTERE DE ACENTUACAO
   If ! Str(_k1,3) $"126 96 94 44 39 95"
      Return(NIL)
   EndIF

   __CurAnt:=SetCursor()                // salva o cursor anterior

   SetPos(Row(),Col()-1)

   SetCursor(3)

   _k3 := 0

   If _k1=126          //--> ~  (TIL)
      _k2 := InKey(0)
      If _k2=65        //--> A
         _k3:=142      //--> Ž
      ElseIF _k2=97    //--> a
         _k3:=132      //--> „
      ElseIF _k2=79    //--> O
         _k3:=153      //--> ™
      ElseIF _k2=111   //--> o
         _k3:=148      //--> ”
      EndIF

   ElseIF _k1=94       //--> ^  (CIRCUNFLEXO)
      _k2:=InKey(0)
      If _k2=65        //--> A
         _k3:=143      //--> 
      ElseIF _k2=97    //--> a
         _k3:=131      //--> ƒ
      ElseIF _k2=69    //--> E
         _k3:=137      //--> ‰
      ElseIF _k2=101   //--> e
         _k3:=136      //--> ˆ
      ElseIF _k2=79    //--> O
         _k3:=152      //--> ˜
      ElseIF _k2=111   //--> o
         _k3:=147      //--> “
      EndIF

   ElseIF _k1=39       //--> '  (AGUDO)
      _k2:=InKey(0)
      If _k2=65        //--> A
         _k3:=134      //--> †
      ElseIF _k2=97    //--> a
         _k3:=160      //-->  
      ElseIF _k2=69    //--> E
         _k3:=144      //--> 
      ElseIF _k2=101   //--> e
         _k3:=130      //--> ‚
      ElseIF _k2=73    //--> I
         _k3:=141      //--> 
      ElseIF _k2=105   //--> i
         _k3:=161      //--> ¡
      ElseIF _k2=79    //--> O
         _k3:=149      //--> •
      ElseIF _k2=111   //--> o
         _k3:=162      //--> ¢
      ElseIF _k2=85    //--> U
         _k3:=151      //--> —
      ElseIF _k2=117   //--> u
         _k3:=163      //--> £
      EndIF

   ElseIF _k1=96       //--> `  (CRASE)
      _k2:=InKey(0)
      If _k2=65        //--> A
         _k3:=150      //--> –
      ElseIF _k2=97    //--> a
         _k3:=133      //--> …
      EndIF

   ElseIF _k1=44       //--> ,  (CEDILHA)
      _k2:=InKey(0)
      If _k2=99        //--> c
         _k3:=135      //--> ‡
      ElseIF _k2=67    //--> C
         _k3:=128      //--> €
      EndIF

   ElseIF _k1=95       //--> _  (SUBLINHADO)
      _k2:=InKey(0)
      If _k2=65 ;      //--> A
      .or. _k2=97      //--> a
         _k3:=166      //--> ¦
      ElseIF _k2=79 ;  //--> O
      .or. _k2=111     //--> o
         _k3:=167      //--> §
      EndIF
   EndIF

   If _k3 # 0
      KeyBoard Chr(If(__CurAnt=2,8,19))+Chr(_k3)
   Else
      KeyBoard Chr(_k2)
   EndIF

   SetCursor(__CurAnt)

Return(NIL)

*-----------------------------
Function SENHA(_Lin,_Col,_Tam) //--> ENTRADA DE SENHA PELO TECLADO
*-----------------------------
   Local _Chr, _Ind, CursorAnt:=SetCursor(), _Senha:=""

   ***> LIGA O CURSOR
   SetCursor(1)

   ***> ENTRADA DOS CARACTERES DA SENHA
   For _Ind := 1 to _Tam

      ***> POSICIONA O CURSOR
      SetPos(_Lin, (_Col-1 +_Ind))

      ***> AGUARDA A DIGITACAO
      _Chr := InKey(0)

      ***> BACKSPACE OU SETA PARA A ESQUERDA
      If _Chr = 8 .or. _Chr = 19

         if _Ind > 0

            ***> DECREMENTA LOOP
            _Ind -= If(_Ind=1,1,2)

            ***> RETIRA UM CARACTER DA SENHA
            _Senha := If(_Ind=0,"",Left(_Senha,_Ind))

            ***> APAGA * NA TELA DE ENTRADA
            Say(_Lin,_Col+_Ind," ")

         EndIF

         Loop

      ***> ABANDONAR ENTRADA
      ElseIF _Chr = _ESC
         Return("")

      ***> ENCERRAR ENTRADA
      ElseIF _Chr = _ENTER
         Exit

      EndIF

      ***> COLOCA * NO CARACTER ACEITO
      Say(_Lin, _Col-1+_Ind,"*")

      ***> INCREMENTA SENHA
      _Senha += Chr(_Chr)

   Next

   ***> REPOE CURSOR ANTIGO
   SetCursor(CursorAnt)

Return(_Senha)

*---------------
Function EndDEMO //--> TESTA A VALIDADE DO HELPd
*---------------
   Local __dti := StrZero(070102,6), __dtf := StrZero(070104,6)

   ***> VERIFICA DATA DE VALIDADE DA DEMONSTRACAO
   DateFormat := Set(_7DateFormat)
   Set(_7DateFormat,"dd/mm/yy")

   __dti := CtoD(SubStr(__dti,1,2)+"/"+SubStr(__dti,3,2)+"/"+SubStr(__dti,5,2))
   __dtf := CtoD(SubStr(__dtf,1,2)+"/"+SubStr(__dtf,3,2)+"/"+SubStr(__dtf,5,2))

   If .f. // Date() > __dtf

   /*

                    2      3         4         5
                    34567890123456789012345678901234
                    6ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 6
                    7³ o                          o ³ 7
                    8³    HELPd com PROBLEMAS!!!    ³ 8
                    9³                              ³ 9
                   10³     entre em contato com     ³10
                    1³                              ³ 1
                    2³     SoftBitt Inform tica     ³ 2
                    3³                              ³ 3
                    4³        (041) 377-1961        ³ 4
                    5³                              ³ 5
                    6³ o       Tecle  ENTER       o ³ 6
                   17ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ17
                    34567890123456789012345678901234
                    2      3         4         5

   */

      ***> HELPd com PROBLEMAS!!!
      _TN:=072069076080
      _TS:=StrZero(_TN,12)
      _TN:=100032099111
      _TS+=StrZero(_TN,12)
      _TN:=109032080082
      _TS+=StrZero(_TN,12)
      _TN:=079066076069
      _TS+=StrZero(_TN,12)
      _TN:=077065083033
      _TS+=StrZero(_TN,12)
      _TN:=033033
      _TS+=StrZero(_TN,06)
      _L1:=_TS
      ***> entre em contato com
      _TN:=101110116114
      _TS:=StrZero(_TN,12)
      _TN:=101032101109
      _TS+=StrZero(_TN,12)
      _TN:=032099111110
      _TS+=StrZero(_TN,12)
      _TN:=116097116111
      _TS+=StrZero(_TN,12)
      _TN:=032099111109
      _TS+=StrZero(_TN,12)
      _L2:=StrZero(32,3) + _TS + StrZero(32,3)
      ***> Informatica
      _TN:=073110102111
      _TS:=StrZero(_TN,12)
      _TN:=114109097116
      _TS+=StrZero(_TN,12)
      _TN:=105099097
      _TS+=StrZero(_TN,09)
      _L3:=_TS

      _L1f := _L2f := _L3f := ""

      For __x:=1 to 22
         If __x <= Len(_L1)/3
            _L1f+=Chr(Val(SubStr(_L1,(__x-1)*3+1,3)))
         EndIF
         If __x <= Len(_L2)/3
            _L2f+=Chr(Val(SubStr(_L2,(__x-1)*3+1,3)))
         EndIF
         If __x <= len(_L3)/3
            _L3f+=Chr(Val(SubStr(_L3,(__x-1)*3+1,3)))
         EndIF
      Next

      DispBox(06,23,17,54,"ÚÄ¿³ÙÄÀ³ ","w+/b")
      Say(07,25,Chr(111),"w+/b")
      Say(07,52,Chr(111),"w+/b")
      Say(16,25,Chr(111),"w+/b")
      Say(16,52,Chr(111),"w+/b")
      SetColor("gr+/b")
      Say(08,28,_L1f,"gr+/b")
      Say(10,28,_L2f,"gr+/b")
      Say(12,28,__fm + _L3f,"gr+/b")
      Say(14,32,Chr(40) + StrZero(41,3) + Chr(41) + Space(1)+;
                  Str(377,3) + Chr(45) + Str(1961,4),"gr+/b")
      Say(16,33,"Tecle  ENTER","gr+*/b")
      __TecleEnter(.f.)
      Set(_7DateFormat,DateFormat)
      Return(.t.)
   EndIF

   Set(_7DateFormat,DateFormat)

Return(.f.)

*-------------------------------------------------------------------> HELPd.prg
