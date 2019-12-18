#include "common.ch"
#include "inkey.ch"

static Static1:= ""
static Static2, Static3:= .F., Static4, Static5, Static6, Static7, ;
   Static8, Static9, Static10, Static11


   clear screen
   clear gets
   set scoreboard off
   set date british
   private he[40], esc[40], s20[40]
   name:= "IFSWEDA"
   finaliza:= "}"
   esc[1]:= ".01"
   esc[2]:= ".02"
   esc[3]:= ".03"
   esc[4]:= ".04"
   esc[5]:= ".05"
   esc[6]:= ".06"
   esc[7]:= ".07"
   esc[8]:= ".08"
   esc[9]:= ".09"
   esc[10]:= ".10"
   esc[11]:= ".11"
   esc[12]:= ".12"
   esc[13]:= ".13"
   esc[14]:= ".14"
   esc[15]:= ".15"
   esc[16]:= ".16"
   esc[17]:= ".17"
   esc[18]:= ".18"
   esc[19]:= ".19"
   esc[20]:= ".21"
   esc[21]:= ".22"
   esc[22]:= ".23"
   esc[23]:= ".24"
   esc[24]:= ".25"
   esc[25]:= ".26"
   esc[26]:= ".27"
   esc[27]:= ".28"
   esc[28]:= ".29"
   esc[29]:= ".30"
   esc[30]:= ".31"
   esc[31]:= ".33"
   esc[32]:= ".35"
   esc[33]:= ".36"
   esc[34]:= ".38"
   esc[35]:= ".39"
   esc[36]:= ".40"
   esc[37]:= ".41"
   esc[38]:= ".42"
   esc[39]:= ".43"
   esc[40]:= ".50"
   crlf:= Chr(13) + Chr(10)
   he[1]:= "ESC1  = Registrar item vendido"
   he[2]:= "ESC2  = Desconto sobre item anterior"
   he[3]:= "ESC3  = Desconto sobre cupom"
   he[4]:= "ESC4  = Cancelar item anterior"
   he[5]:= "ESC5  = Cancelar cupom anterior"
   he[6]:= "ESC6  = Impress„o do CPF/CGC/IE do consumidor"
   he[7]:= "ESC7  = Somar em acumulador n„o-fiscal"
   he[8]:= "ESC8  = Impress„o de texto n„o-fiscal"
   he[9]:= "ESC9  = Impress„o de indicadores"
   he[10]:= "ESC10 = Totalizar cupom"
   he[11]:= "ESC11 = Lan‡amento de acr‚scimo"
   he[12]:= "ESC12 = Fechar cupom"
   he[13]:= "ESC13 = LEITURA 'X'"
   he[14]:= "ESC14 = REDU€ŽO 'Z'"
   he[15]:= "ESC15 = LEITURA DA MEM¢RIA FISCAL-REDU€ŽO"
   he[16]:= "ESC16 = LEITURA DA MEM¢RIA FISCAL-DATA"
   he[17]:= "ESC17 = Abrir cupom fiscal"
   he[18]:= "ESC18 = Imprimir parƒmetros do ECF"
   he[19]:= "ESC19 = Abrir cupom n„o-fiscal"
   he[20]:= "ESC21 = Abrir gaveta"
   he[21]:= "ESC22 = Status da gaveta"
   he[22]:= "ESC23 = Status da impressora"
   he[23]:= "ESC24 = Impress„o de cheque"
   he[24]:= "ESC25 = Fechar impress„o em folha solta"
   he[25]:= "ESC26 = Autentica‡„o"
   he[26]:= "ESC27 = Leitura dos totais"
   he[27]:= "ESC28 = Status de transa‡„o"
   he[28]:= "ESC29 = Leitura de tabelas"
   he[29]:= "ESC30 = Programar parƒmetros de venda"
   he[30]:= "ESC31 = Programar cabe‡alho"
   he[31]:= "ESC33 = Programar tabela de taxas"
   he[32]:= "ESC35 = Programar rel¢gio"
   he[33]:= "ESC36 = Programar hor rio de ver„o"
   he[34]:= "ESC38 = Programar legenda de opera‡„o n„o-fiscal"
   he[35]:= "ESC39 = Programar legenda de modalidade pagamento"
   he[36]:= "ESC40 = Logotipo do lojista na autentica‡„o"
   he[37]:= "ESC41 = Confirmar comando/Interromper leitura"
   he[38]:= "ESC42 = Abrir gaveta acoplada ao ECF"
   he[39]:= "ESC43 = Status da gaveta acoplada ao ECF"
   he[40]:= "ESC50 = Parƒmetros n„o fiscais"
   s20[1]:= "E01-LANCA ITEM  "
   s20[2]:= "E02-DESCONT ITEM"
   s20[3]:= "E03-DESCON CUPOM"
   s20[4]:= "E04-CANCELA ITEM"
   s20[5]:= "E05-CANCEL CUPOM"
   s20[6]:= "E06-CPF/IE CONSU"
   s20[7]:= "E07-SOMAR N FISC"
   s20[8]:= "E08-IMPR NAO FIS"
   s20[9]:= "E09-IMPR INDICAD"
   s20[10]:= "E10-TOT  CUPOM  "
   s20[11]:= "E11-ACRESCIMO   "
   s20[12]:= "E12-FECHA CUPOM "
   s20[13]:= "E13-LEITURA X   "
   s20[14]:= "E14-REDUCAO Z   "
   s20[15]:= "E15-LT MF-REDUC "
   s20[16]:= "E16-LT MF-DATA  "
   s20[17]:= "E17-ABRE CUP FIS"
   s20[18]:= "E18-IMPR PARAMET"
   s20[19]:= "E19-ABRE C.N.F. "
   s20[20]:= "E21-ABRE GAVETA "
   s20[21]:= "E22-STATUS GAV  "
   s20[22]:= "E23-STATUS IMPR "
   s20[23]:= "E24-IMP CHEQUE  "
   s20[24]:= "E25-FECA FL SOLT"
   s20[25]:= "E26-AUTENTICA   "
   s20[26]:= "E27-LEIT  TOTAIS"
   s20[27]:= "E28-STATUS TRANS"
   s20[28]:= "E29-LEIT  TABELA"
   s20[29]:= "E30-PROG PARAMET"
   s20[30]:= "E31-PROG CABECAL"
   s20[31]:= "E33-PROGR  TAXAS"
   s20[32]:= "E35-PR HORA/DATA"
   s20[33]:= "E36-PR HOR VERAO"
   s20[34]:= "E38-PROG NAO FIS"
   s20[35]:= "E39-PROG MODALID"
   s20[36]:= "E40-PROG LOGOTIP"
   s20[37]:= "E41-CONF COMANDO"
   s20[38]:= "E42-ABRE GAV IMP"
   s20[39]:= "E43-STAT GAV IMP"
   s20[40]:= "E50-PARAM NAO FI"
   private tipo[10], identifica[40], mvalor[10], atributo[8], linha[8]
   private lnfis[30], tri[15], aliq[15], saliq[15], leg[15]
   afill(atributo, " ")
   afill(tipo, Space(2))
   afill(identifica, Space(40))
   afill(mvalor, 0)
   afill(aliq, 0)
   afill(saliq, 0)
   afill(tri, Space(3))
   afill(leg, Space(5))
   afill(lnfis, Space(15))
   afill(linha, Space(40))
   tipo2:= Space(1)
   data1:= data2:= CToD("  /  /  ")
   modo:= centa:= sec:= gui:= Space(1)
   contador:= Space(2)
   hora:= Space(6)
   matricula:= Space(8)
   texto:= Space(10)
   texto6:= Space(30)
   codigo:= Space(13)
   ie:= Space(21)
   cgc:= Space(22)
   descricao:= Space(24)
   nome2:= Space(40)
   textov:= Space(48)
   textol:= Space(88)
   unitario:= valor:= qtde:= caixa:= perc:= 0
   linun:= "N"
   tipo6:= Space(2)
   lanc:= Space(3)
   unica:= Space(2)
   reduc1:= reduc2:= Space(4)
   logos:= Space(200)
   do while (.T.)
      s2050_disp(" SWEDA ECF - V03", 0)
      setcursor(0)
      set color to w+/b
      clear screen
      clear gets
      set color to b/w
      @  0,  0 say ;
         "  Utilit rio para testes de comandos - SWEDA ECF-S7000 96/97.  vs. 4.00         "
      set color to w+/b
      @  2,  1 say "Este utilit rio foi escrito em CLIPPER 5"
      set color to GR+/b
      @  4,  1 say "Observa‡”es: "
      set color to w+/b
      @  5,  1 say ;
         "             1) A todo comando enviado para  o Impressor Fiscal IFS-7000  ser "
      @  6,  1 say ;
         "retornado um status. Para acessar o IFS-7000, redirecione a impressora para  o"
      @  7,  1 say ;
         "dispositivo IFSWEDA e fa‡a a impress„o. O status ser  retornado no arquivo:   "
      @  8,  1 say "IFSWEDA.PRN. "
      @ 10,  1 say ;
         "             2) Para acessar o dispositivo (IFSWEDA), acrescente no CONFIG.SYS"
      @ 11,  1 say "a linha:"
      @ 12,  1 say "           DEVICE=C:\SERSWEDA.SYS /Tnnnn /COMn"
      @ 13,  1 say ;
         "                                     ³     ³                                  "
      @ 14,  1 say ;
         "                                     ³     ÀÄÄ COM1, COM2, COM4"
      @ 15,  1 say "                                     ÀÄÄ Time-out"
      @ 17,  1 say ;
         "             3) O Impressor Fiscal dever  ser conectado …  sa¡da  serial  COMn"
      @ 18,  1 say "do equipamento."
      set color to g+/b
      @ 22,  1 say "Pressione uma tecla para continuar, ou"
      @ 23,  1 say "[ESC] - Para Sair do programa."
      set color to W/b
      tecla:= InKey(0)
      if (tecla == 27)
         exit
      endif
      executa()
   enddo
   s2050_curs()
   setcursor(1)
   set color to
   clear screen
   clear gets

********************************
function S2050_MOST

   parameters par1
   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   fwrite(nhandle, "" + par1, 1 + Len(par1))
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.

********************************
function S2050_ACEN

   parameters pos, carac
   num:= 127 + pos
   num2:= 159 + pos
   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   fwrite(nhandle, "" + Chr(num) + carac, 2 + Len(carac))
   fwrite(nhandle, "" + Chr(num2) + carac, 2 + Len(carac))
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.


********************************
procedure EXECUTA

   opcao:= 1
   do while (.T.)
      clear screen
      clear gets
      @  0,  0, 24, 79 box "ÉÍ»º¼ÍÈº"
      @  2,  0, 24, 79 box "ÌÍ¹º¼ÍÈº"
      opt:= opcao
      set color to gR+/b
      @ 24, 65 say " ECF V03 "
      set color to bg+/b
      @  1,  2 say ;
         "Utilit rio: Executa comando gen‚rico.          vs.04.00"
      set color to w+/b
      s2050_disp(s20[opcao], 0)
      opcao:= achoice(3, 2, 23, 77, he, .T., "salva", opcao)
      do case
      case LastKey() == K_ESC
         return
      case LastKey() = K_PGDN .OR. LastKey() = K_PGUP .OR. LastKey() ;
            = K_CTRL_PGUP .OR. LastKey() = K_CTRL_PGDN .OR. ;
            LastKey() = K_CTRL_END .OR. LastKey() = K_CTRL_HOME
         loop
      case LastKey() == 1
         opcao:= 1
         loop
      case LastKey() == K_END
         opcao:= Len(he)
         loop
      case LastKey() == K_ENTER
      otherwise
         opcao:= 1
         loop
      endcase
      clear screen
      clear gets
      set color to W/b
      @  0,  0, 24, 79 box "ÉÍ»º¼ÍÈº"
      @  2,  0, 24, 79 box "ÌÍ¹º¼ÍÈº"
      set color to gR+/b
      @ 24, 65 say " ECF V03 "
      set color to BG+/B
      @  1,  1 say "COMANDO: "
      @  1, 10 say he[opcao]
      set color to gr+/B
      @ 16,  2 say "Formato enviado ao IFS-7000:"
      @ 20,  2 say "Status:"
      set confirm on
      setcursor(1)
      set color to gr+/B
      comple:= ""
      do case
      case opcao = 1
         @  3,  1 say ;
            "ESC.01 [C¢digo] [Qtde] [Prunitario] [Prtotal] [Nome] [TTT] [EXT ou Nome2]"
         set color to w/B
         s2050_mezz("CD ", "0545")
         @  5,  1 say "C¢digo         - com 13 posi‡”es           " ;
            get CODIGO picture "XXXXXXXXXXXXX" valid valp("CD ", ;
            "QTDE     ", 1, "0545", "0645")
         @  6,  1 say "Quantidade     - com  7 posi‡”es           " ;
            get QTDE picture "@E 9999.999" valid valp("CD ", ;
            "UNIT   ", 2, "0545", "0745")
         @  7,  1 say "Pre‡o Unit rio - com  9 posi‡”es           " ;
            get UNITARIO picture "@E 9999999.99" valid ;
            valp("QTDE     ", "TOT ", 3, "0645", "0845")
         @  8,  1 say "Pre‡o total    - com 12 posi‡”es           " ;
            get VALOR picture "@E 9999999999.99" valid ;
            valp("UNIT   ", "NOME ", 4, "0745", "0945")
         @  9,  1 say "Nome           - com 24 posi‡”es           " ;
            get DESCRICAO picture "@XS11" valid valp("TOT ", ;
            "TRIB         ", 5, "0845", "1045")
         @ 10,  1 say "TTT=tributa‡„o - com  3 posi‡”es           " ;
            get TRI[1] picture "XXX" valid valp("NOME ", ;
            "EXTENSAO      ", 6, "0945", "1145")
         @ 11,  1 say "EXT            = extens„o do c¢digo        " ;
            get UNICA picture "99" valid valp("TRIB         ", ;
            "NOME2 ", 7, "1045", "1245")
         @ 11, 60 say "(OPCIONAL)"
         @ 12,  1 say "Nome2          - com 40 posi‡”es           " ;
            get NOME2 picture "@XS11" valid valp("EXTENSAO      ", ;
            "NOME2 ", 8, "1145", "1345")
         @ 12, 60 say "(OPCIONAL)"
         read
         s2050_mout()
         setcursor(0)
         if (!Empty(unica))
            unic:= unica
         else
            unic:= ""
         endif
         if (!Empty(nome2))
            nomop:= nome2
            unic:= ""
         else
            nomop:= ""
         endif
         comple:= codigo + strtran(strtran(Str(qtde, 8, 3), ".", ;
            ""), " ", "0") + strtran(strtran(Str(unitario, 10, 2), ;
            ".", ""), " ", "0") + strtran(strtran(Str(valor, 13, 2), ;
            ".", ""), " ", "0") + descricao + tri[1] + unic + nomop
      case opcao = 2
         @  3,  1 say "ESC.02 [Texto] [Valor]"
         set color to w/B
         s2050_mezz("TEXTO ", "0560")
         @  5,  1 say ;
            "Texto = texto a ser impresso depois da legenda            " ;
            get Texto picture "XXXXXXXXXX" valid valp("TEXTO ", ;
            "VLR ", 1, "0560", "0760")
         @  6,  1 say "        'DESC:' com 10 posi‡”es"
         @  7,  1 say ;
            "Valor = valor do desconto - com 12 posi‡”es               " ;
            get VALOR picture "@E 9999999999.99" valid ;
            valp("TEXTO ", "VLR ", 2, "0560", "0760")
         setcursor(1)
         read
         s2050_mout()
         setcursor(0)
         comple:= texto + strtran(strtran(Str(valor, 13, 2), ".", ;
            ""), " ", "0")
      case opcao = 3
         @  3,  1 say "ESC.03 [Texto] [Valor]"
         set color to w/B
         s2050_mezz("TEXTO ", "0560")
         @  5,  1 say ;
            "Texto = texto a ser impresso depois da legenda            " ;
            get Texto picture "XXXXXXXXXX" valid valp("TEXTO ", ;
            "VLR ", 1, "0560", "0760")
         @  6,  1 say "        'DESCT:' com 10 posi‡”es"
         @  7,  1 say ;
            "Valor = valor do desconto - com 12 posi‡”es               " ;
            get VALOR picture "@E 9999999999.99" valid ;
            valp("TEXTO ", "VLR ", 2, "0560", "0760")
         read
         s2050_mout()
         setcursor(0)
         comple:= texto + strtran(strtran(Str(valor, 13, 2), ".", ;
            ""), " ", "0")
      case opcao = 4
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.04              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 5
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.05              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 6
         comp:= ""
         @  3,  1 say "ESC.06 [Atributo] [Tipo] [Ident]"
         set color to w/B
         @  4, 10 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 10 say ;
            "³ Atributo ³ IFS-I  ³IFS-IE/IEE³ IFS-II ³ IFS-III           ³"
         @  6, 10 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 10 say ;
            "³     0    ³   48   ³   40     ³   40   ³   40   carac/linha³"
         @  8, 10 say ;
            "³     1    ³   48   ³   33     ³   33   ³   30              ³"
         @  9, 10 say ;
            "³     2    ³   24   ³   20     ³   20   ³   20              ³"
         @ 10, 10 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         setcursor(1)
         s2050_mezz("ATRIBUTO       ", "1113")
         @ 11,  1 say "Atributo = " get ATRIBUTO[1] picture "9" ;
            valid valp("ATRIBUTO       ", "TIPO  ", 1, "1113", "1237")
         @ 12,  1 say "Tipo = n£mero da mensagem (01 a 03)" get ;
            TIPO6 picture "99" valid valp("TIPO        ", "TEXTO ", ;
            2, "1113", "1401")
         @ 13,  1 say ;
            "Ident = texto a ser impresso (o tamanho varia conforme o atributo)"
         @ 14,  1 get TEXTO6 picture "@XS30" valid ;
            valp("ATRIBUTO       ", "TEXTO ", 3, "1237", "1401")
         read
         s2050_mout()
         setcursor(0)
         comple:= atributo[1] + tipo6 + texto6
      case opcao = 7
         @  3,  1 say "ESC.07 [C¢digo] [Valor]"
         set color to w/B
         s2050_mezz("CODIGO        ", "0560")
         @  5,  1 say ;
            "C¢digo = n£mero do contador/totalizador - com 2 posi‡”es  " ;
            get CONTADOR picture "99" valid valp("CODIGO        ", ;
            "VLR ", 1, "0560", "0660")
         @  6,  1 say ;
            "Valor = valor da opera‡„o - com 12 posi‡”es               " ;
            get VALOR picture "@E 9999999999.99" valid ;
            valp("CODIGO        ", "VLR ", 2, "0560", "0660")
         read
         s2050_mout()
         setcursor(0)
         comple:= contador + strtran(strtran(Str(valor, 13, 2), ".", ;
            ""), " ", "0")
      case opcao = 8
         @  3,  1 say "ESC.08 [Atributo] [Modo] [Texto]"
         set color to w/B
         @  4, 10 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 10 say ;
            "³ Atributo ³ IFS-I  ³IFS-IE/IEE³ IFS-II ³ IFS-III           ³"
         @  6, 10 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 10 say ;
            "³     0    ³   48   ³   40     ³   40   ³   40   carac/linha³"
         @  8, 10 say ;
            "³     1    ³   48   ³   33     ³   33   ³   30              ³"
         @  9, 10 say ;
            "³     2    ³   24   ³   20     ³   20   ³   20              ³"
         @ 10, 10 say ;
            "ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @ 11, 10 say ;
            "³     9    ³  1¦ posi‡„o de [Texto] para n£mero de avan‡os  ³"
         @ 12, 10 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         s2050_mezz("ATRIBUTO       ", "1313")
         @ 13,  1 say "Atributo = " get ATRIBUTO[1] picture "9" ;
            valid valp("ATRIBUTO       ", "TEXTO ", 2, "1313", "1501")
         @ 14,  1 say ;
            "Texto = texto a ser impresso (o tamanho varia conforme o atributo)"
         @ 15,  1 get TEXTOV picture "@XS10" valid ;
            valp("ATRIBUTO       ", "TEXTO ", 2, "1313", "1501")
         read
         s2050_mout()
         setcursor(0)
         comple:= atributo[1] + "D" + textov
      case opcao = 9
         comp:= ""
         @  3,  1 say ;
            "ESC.09 [Atributo] [Tipo1] [Ident1]...[Tipo5] [Ident5]"
         set color to w/B
         atributo[1]:= " "
         afill(tipo, Space(2))
         afill(identifica, Space(40))
         @  4, 10 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 10 say ;
            "³ Atributo ³ IFS-I  ³IFS-IE/IEE³ IFS-II ³ IFS-III           ³"
         @  6, 10 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 10 say ;
            "³     0    ³   48   ³   40     ³   40   ³   40   carac/linha³"
         @  8, 10 say ;
            "³     1    ³   48   ³   33     ³   33   ³   30              ³"
         @  9, 10 say ;
            "³     2    ³   24   ³   20     ³   20   ³   20              ³"
         @ 10, 10 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         s2050_mezz("ATRIBUTO       ", "1132")
         @ 11,  1 say "Atributo (modo de impress„o) =" get ;
            ATRIBUTO[1] picture "9" valid valp("ATRIBUTO       ", ;
            "TIPO01        ", 1, "1132", "1518")
         @ 12,  1 say "Tipo = n£mero da mensagem (00 a 29)"
         @ 13,  1 say ;
            "Ident = identifica‡„o do elemento, aceita at‚ 39 d¡gitos e s¡mbolos."
         read
         s2050_mout()
         for i:= 1 to 5
            setcursor(1)
            set color to W+/b
            s2050_mezz("TIPO" + strzero(i, 2) + "        ", "1517")
            @ 14,  2 say Str(i, 2) + ;
               "§ Indicador                            [PgDn] - executa"
            set color to W/b
            @ 15,  2 say "Tipo:         " get TIPO[i] picture "99" ;
               valid valp("TIPO" + strzero(i, 2) + "        ", ;
               "Ident ", 3, "1517", "1535")
            @ 15, 20 say "Identifica‡„o:" get IDENTIFICA[i] picture ;
               "@XS10" valid valp("TIPO" + strzero(i, 2) + ;
               "        ", "Ident ", 3, "1517", "1535")
            read
            s2050_mout()
            if (i = 1 .AND. atributo[1] != Space(1))
               comp:= "|" + atributo[1] + "|"
            endif
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            if (Empty(identifica[i]))
               identifica[i]:= "|"
            else
               identifica[i]:= Trim(identifica[i]) + "|"
            endif
            comp:= comp + tipo[i] + SubStr(identifica[i], 1, At("|", ;
               identifica[i]))
         next
         comple:= comp
      case opcao = 10
         comp:= ""
         @  3,  1 say "ESC.10 [Tipo1] [Valor1]...[Tipo10] [Valor10]"
         set color to w/B
         @  5,  1 say ;
            "Tipo  = c¢digo da modalidade, com 2 posi‡”es (de 01 a 10)"
         @  6,  1 say "Valor = valor da modalidade, com 12 posi‡”es"
         afill(tipo, Space(2))
         afill(mvalor, 0)
         for i:= 1 to 10
            setcursor(1)
            set color to W+/b
            @ 10,  2 say Str(i, 2) + ;
               "§ Indicador                            [PgDn] - executa"
            set color to W/b
            s2050_mezz("MODALIDADE" + strzero(i, 2) + "  ", "1115")
            @ 11,  2 say "Modalidade: " get TIPO[i] picture "99" ;
               valid valp("MODALIDADE" + strzero(i, 2) + "  ", ;
               "VLR ", 1, "1115", "1215")
            @ 12,  2 say "Valor     : " get mVALOR[i] picture ;
               "@E 9999999999.99" valid valp("MODALIDADE" + ;
               strzero(i, 2) + "  ", "VLR ", 2, "1115", "1215")
            read
            s2050_mout()
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            comp:= comp + tipo[i] + strtran(strtran(Str(mvalor[i], ;
               13, 2), ".", ""), " ", "0")
         next
         comple:= comp
      case opcao = 11
         afill(tri, Space(3))
         valor:= perc:= 0
         lanc:= Space(3)
         contador:= Space(2)
         linun:= "N"
         @  3,  1 say "ESC.11 [C¢digo] [Perc] [Acres] [TTT] [Subt]"
         set color to w/B
         s2050_mezz("CODIGO       ", "0544")
         @  5,  1 say "C¢digo da legenda        ( 51 a 54 )       " ;
            get CONTADOR picture "99" valid valp("CODIGO       ", ;
            "% ACRES    ", 1, "0544", "0644")
         @  6,  1 say "Percentual          2 inteiros & 2 decimais" ;
            get PERC picture "@E 99.99" valid valp("CODIGO       ", ;
            "VLR ", 2, "0544", "0744")
         @  7,  1 say "Acr‚scimo          11 posi‡”es             " ;
            get VALOR picture "@E 999999999.99" valid ;
            valp("% ACRES    ", "TRIB        ", 3, "0644", "0844")
         @  8,  1 say "TTT=tributa‡„o      3 posi‡”es             " ;
            get TRI[1] picture "XXX" valid valp("VLR ", ;
            "SUBTOTAL      ", 4, "0744", "0944")
         @  9,  1 say "Subt = imprime Subtotal  1 posi‡„o         " ;
            get LINUN picture "!" valid (linun = "S" .OR. linun = ;
            "N") .AND. valp("TRIB        ", "SUBTOTAL      ", 5, ;
            "0844", "0944")
         read
         s2050_mout()
         setcursor(0)
         if (linun = "S")
            unic:= "S"
         else
            unic:= "N"
         endif
         comple:= contador + strtran(strtran(Str(perc, 5, 2), ".", ;
            ""), " ", "0") + strtran(strtran(Str(valor, 12, 2), ".", ;
            ""), " ", "0") + tri[1] + unic
      case opcao = 12
         comp:= ""
         scup:= " "
         @  3,  1 say ;
            "ESC.12 [Atributo1] [Linha1]...[Atributo8] [Linha8]"
         set color to w/B
         @  4, 10 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 10 say ;
            "³ Atributo ³ IFS-I  ³IFS-IE/IEE³ IFS-II ³ IFS-III           ³"
         @  6, 10 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 10 say ;
            "³     0    ³   40   ³   40     ³   40   ³   40   carac/linha³"
         @  8, 10 say ;
            "³     1    ³   40   ³   33     ³   33   ³   30              ³"
         @  9, 10 say ;
            "³     2    ³   20   ³   20     ³   20   ³   20              ³"
         @ 10, 10 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         @ 11,  1 say ;
            "Linha = mensagem de cortesia. Tamanho Fixo em 40 posi‡”es."
         s2050_mezz("Segundo Cupom :", "1231")
         @ 12,  1 say "Impress„o do Segundo Cupom : " get scup ;
            picture "!" valid scup = "|" .OR. scup = " "
         read
         for i:= 1 to 8
            set color to W+/b
            @ 13,  2 say Str(i, 2) + "§ Linha  "
            @ 13, 50 say "[PgDn] - executa"
            set color to W/b
            setcursor(1)
            s2050_mezz("ATRIBUTO" + Str(i, 1) + "      ", "1325")
            @ 13, 15 say "Atributo:" get ATRIBUTO[i] picture "9" ;
               valid valp("ATRIBUTO" + Str(i, 1) + "      ", "L" + ;
               Str(i, 1) + " ", 1, "1325", "1426")
            @ 14, 15 say "Linha   :" get linha[i] picture "@XS13" ;
               valid valp("ATRIBUTO" + Str(i, 1) + "      ", "L" + ;
               Str(i, 1) + " ", 2, "1325", "1426")
            read
            s2050_mout()
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            if (Empty(linha[i]))
               loop
            endif
            comp:= comp + atributo[i] + linha[i]
         next
         if (LastKey() != K_ESC)
            if (!Empty(scup))
               comple:= scup + comp
            else
               comple:= comp
            endif
         endif
      case opcao = 13
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.13              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 14
         @  3,  1 say "ESC.14 [Data]"
         set color to w/B
         data1:= CToD("  /  /  ")
         s2050_mezz("DT HOJE ", "0532")
         @  5,  1 say "Data = data de hoje -OPCIONAL " get data1 ;
            picture "99/99/99"
         setcursor(1)
         read
         s2050_mout()
         setcursor(0)
         comple:= Trim(strtran(DToC(data1), "/", ""))
      case opcao = 15
         @  3,  1 say "ESC.15 [Redu‡„o1] [Redu‡„o2]"
         set color to w/B
         s2050_mezz("REDUCAO INI ", "0556")
         @  5,  1 say ;
            "Redu‡„o1 = redu‡„o inicial para impress„o do relat¢rio" ;
            get REDUC1 picture "9999" valid valp("REDUCAO INI ", ;
            "REDUCAO FIN ", 1, "0556", "0656")
         @  6,  1 say ;
            "Redu‡„o2 = redu‡„o final para impress„o do relat¢rio  " ;
            get REDUC2 picture "9999" valid valp("REDUCAO INI ", ;
            "REDUCAO FIN ", 2, "0556", "0656")
         setcursor(1)
         read
         s2050_mout()
         setcursor(0)
         comple:= reduc1 + reduc2
      case opcao = 16
         @  3,  1 say "ESC.16 [Data1] [Data2]"
         set color to w/B
         s2050_mezz("DT INI  ", "0550")
         @  5,  1 say ;
            "Data1 = data inicial para impress„o do relat¢rio" get ;
            data1 picture "99/99/99" valid valp("DT INI ", ;
            "DT FIN  ", 1, "0550", "0650")
         @  6,  1 say ;
            "Data2 = data final para impress„o do relat¢rio  " get ;
            data2 picture "99/99/99" valid valp("DT INI ", ;
            "DT FIN  ", 2, "0550", "0650")
         setcursor(1)
         read
         s2050_mout()
         setcursor(0)
         comple:= strtran(DToC(data1), "/", "") + ;
            strtran(DToC(data2), "/", "")
      case opcao = 17
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.17              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 18
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.18              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 19
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.19              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 20
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.21              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 21
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.22              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 22
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.23              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 23
         @  3,  1 say "ESC.24 [Atributo] [Texto]"
         set color to w/B
         @  4, 15 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 15 say ;
            "³ Atributo ³   IFS-I   ³    IFS-II   ³    IFS-III            ³"
         @  6, 15 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 15 say ;
            "³     0    ³  n„o h    ³     77      ³       88   carac/linha³"
         @  8, 15 say ;
            "³     1    ³  n„o h    ³     77      ³       66              ³"
         @  9, 15 say ;
            "³     2    ³  n„o h    ³     37      ³       44              ³"
         @ 10, 15 say ;
            "³          ³           ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
         @ 11, 15 say ;
            "³     8    ³  n„o h    ³ 1¦ pos.de [Texto]= n£mero de meio-lf³"
         @ 12, 15 say ;
            "³     9    ³  n„o h    ³ 1¦ pos de [Texto]= n£mero de      lf³"
         @ 13, 15 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         s2050_mezz("ATRIBUTO       ", "1312")
         @ 13,  1 say "Atributo= " get ATRIBUTO[1] picture "9" valid ;
            valp("ATRIBUTO       ", "TEXTO ", 1, "1312", "1501")
         @ 14,  1 say ;
            "Texto = texto a ser impresso (o tamanho varia conforme o atributo)"
         setcursor(1)
         @ 15,  1 get TEXTOL picture "@XS10" valid ;
            valp("ATRIBUTO       ", "TEXTO ", 2, "1312", "1501")
         read
         s2050_mout()
         setcursor(0)
         comple:= atributo[1] + textol
      case opcao = 24
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.25              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 25
         @  3,  1 say "ESC.26 [Atributo] [Texto]"
         set color to w/B
         @  4, 10 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  5, 10 say ;
            "³ Atributo ³ IFS-I  ³ IFS-IE ³ IFS-IEE³ IFS-II ³ IFS-III       ³"
         @  6, 10 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @  7, 10 say ;
            "³     0    ³   48   ³   40   ³ n„o h  ³   40   ³   80 car/linha³"
         @  8, 10 say ;
            "³     1    ³   48   ³   33   ³ n„o h  ³   33   ³   60          ³"
         @  9, 10 say ;
            "³     2    ³   24   ³   20   ³ n„o h  ³   20   ³   40          ³"
         @ 10, 10 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         s2050_mezz("ATRIBUTO       ", "1133")
         @ 11,  1 say "Atributo (modo de impress„o) = " get ;
            ATRIBUTO[1] picture "9" valid valp("ATRIBUTO       ", ;
            "TEXTO ", 1, "1133", "1301")
         @ 12,  1 say ;
            "Texto = texto a ser impresso (o tamanho varia conforme o atributo)"
         setcursor(1)
         @ 13,  1 get TEXTOL picture "@XS10" valid ;
            valp("ATRIBUTO       ", "TEXTO ", 2, "1133", "1301")
         read
         s2050_mout()
         setcursor(0)
         comple:= atributo[1] + textol
      case opcao = 26
         @  3,  1 say "ESC.27 [Tipo]"
         set color to w/B
         s2050_mezz("TIPO          ", "0559")
         @  5,  1 say ;
            "Tipo = tipo de resposta desejada com 1 posi‡„o (de 1 a 9) " ;
            get TIPO2 picture "9"
         read
         s2050_mout()
         setcursor(0)
         comple:= tipo2
      case opcao = 27
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.28              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 28
         @  3,  1 say "ESC.29 [Tipo]"
         set color to w/B
         s2050_mezz("TIPO          ", "0559")
         @  5,  1 say ;
            "Tipo = tipo de resposta desejada com 1 posi‡„o (de 1 a C) " ;
            get TIPO2 picture "!"
         read
         s2050_mout()
         setcursor(0)
         comple:= tipo2
      case opcao = 29
         @  3,  1 say "ESC.30 [Centavos] [Caixa]"
         set color to w/B
         s2050_mezz("CENTAVOS      ", "0559")
         @  5,  1 say ;
            "Centavos = 'S' para ter centavos ou 'N' para nao ter      " ;
            get CENTA picture "X" valid valp("CENTAVOS      ", ;
            "NUM CAIXA   ", 1, "0559", "0659")
         @  6,  1 say ;
            "Caixa = n£mero do caixa com 3 posi‡”es                    " ;
            get CAIXA picture "999" valid valp("CENTAVOS      ", ;
            "NUM CAIXA   ", 2, "0559", "0659")
         read
         s2050_mout()
         setcursor(0)
         comple:= centa + strzero(caixa, 3)
      case opcao = 30
         comp:= ""
         @  3,  1 say ;
            "ESC.31 [Jor] [Sec] [Seg] [Atributo1] [Linha1]...[Atributo5] [Linha5]"
         set color to w/B
         s2050_mezz("SALTOS CUPONS ", "0564")
         centa:= "S"
         @  5,  1 say ;
            "Sec = n§ de linhas a saltar entre os cupons - 1 posi‡„o        " ;
            get sec picture "9" valid valp("SALTOS CUPONS ", ;
            "SEG CUPOM ?   ", 1, "0564", "0641")
         @  6,  1 say "Seg = Imprime Segundo Cupom (S ou N) ? " get ;
            gui picture "X" valid valp("SALTOS CUPONS ", ;
            "ATRIBUTO1      ", 2, "0564", "1512")
         @  7, 10 say ;
            "ÕÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸"
         @  8, 10 say ;
            "³ Atributo ³ IFS-I  ³IFS-IE/IEE³ IFS-II ³ IFS-III           ³"
         @  9, 10 say ;
            "ÆÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ"
         @ 10, 10 say ;
            "³     0    ³   40   ³   40     ³   40   ³   40   carac/linha³"
         @ 11, 10 say ;
            "³     1    ³   40   ³   33     ³   33   ³   30              ³"
         @ 12, 10 say ;
            "³     2    ³   20   ³   20     ³   20   ³   20              ³"
         @ 13, 10 say ;
            "ÔÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾"
         @ 14,  1 say "linha = texto para cabecalho."
         read
         s2050_mout()
         for i:= 1 to 5
            set color to W+/b
            @ 14, 50 say "[PgDn]-executa"
            set color to W/b
            setcursor(1)
            s2050_mezz("ATRIBUTO" + Str(i, 1) + "      ", "1512")
            @ 15,  1 say "Atributo :" get ATRIBUTO[i] picture "9" ;
               valid valp("ATRIBUTO" + Str(i, 1) + "      ", "L" + ;
               Str(i, 1) + " ", 1, "1512", "1526")
            @ 15, 15 say Str(i, 2) + "§ Linha:" get linha[i] picture ;
               "@XS13" valid valp("ATRIBUTO" + Str(i, 1) + "      ", ;
               "L" + Str(i, 1) + " ", 2, "1512", "1526")
            read
            s2050_mout()
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            comp:= comp + atributo[i] + linha[i]
         next
         comple:= centa + sec + gui + comp
      case opcao = 31
         comp:= ""
         @  3,  1 say "ESC.33 [TRIB1]...[TRIB15]"
         set color to w/B
         @  5,  1 say "TRIBn = T T T L L L L L P P P P 0 0 0 0"
         @  7,  1 say "TTT = c¢digo da tributa‡„o - 3 posi‡”es"
         @  8,  1 say "LLLLL = legenda da tributa‡„o - 5 posi‡”es"
         @  9,  1 say "PPPP = al¡quota principal - 4 posi‡”es"
         for i:= 1 to 15
            set color to W+/b
            @ 12,  2 say Str(i, 2) + ;
               "§ Tributa‡„o                           [PgDn] - executa"
            set color to W/b
            setcursor(1)
            s2050_mezz("TRIB" + strzero(i, 2) + "       ", "1408")
            @ 14,  1 say "Trib.:" get tri[i] picture "XXX" valid ;
               valp("TRIB" + strzero(i, 2) + "       ", ;
               "LEGENDA    ", 1, "1408", "1421")
            @ 14, 12 say "Legenda:" get leg[i] picture "XXXXX" valid ;
               valp("TRIB" + strzero(i, 2) + "       ", ;
               "TAXA        ", 2, "1408", "1433")
            @ 14, 27 say "Taxa:" get aliq[i] picture "@e 99.99" ;
               valid valp("LEGENDA    ", "TAXA        ", 3, "1421", ;
               "1433")
            read
            s2050_mout()
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            comp:= comp + tri[i] + leg[i] + strtran(strzero(aliq[i], ;
               5, 2), ".", "") + "0000"
         next
         comple:= comp
      case opcao = 32
         @  3,  1 say "ESC.35 [Hora] [Data]"
         set color to w/B
         s2050_mezz("HORA      ", "0518")
         @  5,  1 say "Hora = HHMMSS   " get hora picture "999999" ;
            valid valp("HORA      ", "DATA    ", 1, "0518", "0618")
         @  6,  1 say "Data = DDMMAA   " get data1 picture ;
            "99/99/99" valid valp("HORA      ", "DATA    ", 2, ;
            "0518", "0618")
         read
         s2050_mout()
         comple:= hora + strtran(DToC(data1), "/", "")
      case opcao = 33
         @  3,  1 say "ESC.36 [Modo]"
         set color to w/B
         s2050_mezz("MODO VERAO     ", "0539")
         @  5,  1 say "Modo = 'S' - entrar Hor rio de Ver„o " get ;
            centa picture "X"
         @  6,  1 say "     = 'N' - sair Hor rio de Ver„o   "
         read
         s2050_mout()
         comple:= centa
      case opcao = 34
         comp:= ""
         @  3,  1 say "ESC.38 [Legenda18]...[Legenda30]"
         set color to w/B
         @  5,  1 say "Legenda18..30 = nome com 15 caracteres"
         for i:= 1 to 13
            set color to W+/b
            @  7,  2 say Str(i, 2) + ;
               "§ Legenda                           [PgDn] - executa"
            set color to W/b
            setcursor(1)
            s2050_mezz("LEG" + strzero(17 + i, 2) + " ", "0814")
            @  8,  2 say "Legenda" + Str(i + 17, 2) + " :" get ;
               lnfis[i] picture "@xS10"
            read
            s2050_mout()
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            comp:= comp + lnfis[i]
         next
         comple:= comp
      case opcao = 35
         comp:= ""
         @  3,  1 say "ESC.39 [Legenda1]...[Legenda10]"
         set color to w/B
         @  5,  1 say "Legenda1..10 = nome com 15 caracteres"
         for i:= 1 to 10
            set color to W+/b
            @  7,  2 say Str(i, 2) + ;
               "§ Legenda                           [PgDn] - executa"
            set color to w/b
            setcursor(1)
            s2050_mezz("LEG" + strzero(i, 2) + " ", "0814")
            @  8,  2 say "Legenda" + Str(i, 2) + " :" get lnfis[i] ;
               picture "@XS10"
            read
            s2050_mout()
            setcursor(0)
            if (LastKey() == K_ESC)
               exit
            endif
            if (LastKey() == K_PGDN)
               exit
            endif
            comp:= comp + lnfis[i]
         next
         comple:= comp
      case opcao = 36
         afill(linha, Space(40))
         @  3,  1 say "ESC.40 [Tamanho] [Logotipo]"
         set color to w/B
         s2050_mezz("TAMANHO      ", "0511")
         @  5,  1 say "Tamanho :" get LANC picture "999" valid ;
            valp("TAMANHO      ", "LOGO ", 1, "0511", "0611")
         @  6,  1 say "LOGOTIPO:" get LOGOS picture "@XS10" valid ;
            valp("TAMANHO      ", "LOGO ", 2, "0511", "0611")
         read
         s2050_mout()
         comple:= lanc + logos
      case opcao = 37
         @  3,  1 say "ESC.41 [Op‡„o]"
         set color to w/B
         s2050_mezz("CONFIRMA COMAN ", "0550")
         @  5,  1 say ;
            "Op‡„o = 'S' - confirma execu‡„o comando anterior" get ;
            centa picture "X"
         @  6,  1 say "      = 'N' - cancelar comando anterior"
         read
         s2050_mout()
         comple:= centa
      case opcao = 38
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.42              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 39
         s2050_disp(" SEM PARAMETROS ", 0)
         @  3,  1 say "ESC.43              (sem parƒmetro adicional)"
         set color to w/B
         @  6,  2 say ;
            "Pressione [ESC] para cancelar ou outra tecla para executar"
         InKey(0)
      case opcao = 40
         @  3,  1 say "ESC.50"
         set color to w/B
         @  5,  1 say "Controle de papel:"
         s2050_mezz("IMP APOS COMAN?", "0678")
         @  5, 20 say ;
            "Op‡„o = 'S' - imprime ap¢s receber comando '(ESC.41S)'."
         @  6, 20 say ;
            "      = 'N' - imprime ap¢s ter papel com a tampa fechada." ;
            get tipo2 picture "X" valid valp("IMP APOS COMAN?", ;
            "COM VISOR ?    ", 1, "0678", "0732")
         @  7,  1 say "Exibe erro em visor (S ou N) ?" get centa ;
            picture "X" valid valp("IMP APOS COMAN?", ;
            "IMP CHQ RAPIDO?", 2, "0678", "0839")
         @  8,  1 say "Impress„o r pida de cheque (S ou N) ?" get ;
            gui picture "X" valid valp("COM VISOR ?    ", ;
            "IMP CHQ RAPIDO?", 3, "0732", "0839")
         read
         s2050_mout()
         comple:= tipo2 + centa + gui
      endcase
      if (LastKey() != K_ESC)
         if (Len(comple) != 0)
            comando:= esc[opcao] + comple + finaliza
         else
            comando:= esc[opcao] + finaliza
         endif
         set color to g+/B
         if (Len(comando) > 78)
            resto:= mod(Len(comando), 78)
            vez:= (Len(comando) - resto) / 78
            nline:= 17
            ini:= 1
            fim:= 78
            for i:= 0 to vez
               @ nline,  1 say SubStr(comando, ini, 78)
               nline:= nline + 1
               ini:= fim + 1
               fim:= fim + 75
            next
         else
            @ 17,  1 say comando
         endif
         s2050_disp("AGUARDE ... ", 0)
         set device to printer
         set printer to (name)
         @ PRow(), PCol() say comando
         set device to screen
         resp:= Space(128)
         set color to gr+/B
         @ 20,  2 say "Status:"
         hand:= fopen("IFSWEDA.PRN", 2)
         resp:= freadstr(hand, 128)
         fclose(hand)
         set color to g+/b
         s2050_most("2101")
         setcursor(1)
         if (SubStr(resp, 2, 1) = "-")
            tone(400, 2)
            if (Len(resp) == 7)
               if (SubStr(resp, 6, 1) = "2")
                  @ 23,  2 say ;
                     "Time-Out de Transmiss„o. Verifique a conex„o PC/Impressor ou FIM DE PAPEL !"
               elseif (SubStr(resp, 6, 1) = "6")
                  @ 23,  2 say ;
                     "Time-Out de Recep‡„o. Verifique a conex„o PC/Impressor ou FIM DE PAPEL !"
               endif
            endif
         elseif (SubStr(resp, 2, 1) = "+")
         endif
         set color to g+/b
         aut:= SubStr(resp, 4, 1)
         slip:= SubStr(resp, 5, 1)
         bob:= SubStr(resp, 6, 1)
         if (SubStr(resp, 3, 1) = "P")
            if (Len(Trim(resp)) > 10)
               do case
               case aut = "0"
                  @ 21, 45 say "AUT : H  documento para autenticar"
               case aut = "1"
                  @ 21, 45 say "AUT : Impressora  off-line        "
               case aut = "2"
                  @ 21, 45 say "AUT : Time-out de Transmissao     "
               case aut = "5"
                  @ 21, 45 say "AUT :Sem documento para autenticar"
               case aut = "6"
                  @ 21, 45 say "AUT : Time-out de recepcao        "
               endcase
               do case
               case slip = "0"
                  @ 22, 45 say "SLIP: H  folha presente      "
               case slip = "1"
                  @ 22, 45 say "SLIP: Impressora  off-line    "
               case slip = "2"
                  @ 22, 45 say "SLIP: Time-out de Transmissao "
               case slip = "5"
                  @ 22, 45 say "SLIP: Sem folha solta presente"
               case slip = "6"
                  @ 22, 45 say "SLIP: Time-out de recepcao    "
               endcase
               do case
               case bob = "0"
                  @ 23, 45 say "BOBINA: Impressora tem papel"
               case bob = "1"
                  @ 23, 45 say "BOBINA:Impressora off-line"
               case bob = "2"
                  @ 23, 45 say "BOBINA:Time-out de Transmissao"
               case bob = "3"
                  @ 23, 45 say "BOBINA:Sem papel, lado Jornal"
               case bob = "4"
                  @ 23, 45 say "BOBINA:Sem papel, lado cupom"
               case bob = "5"
                  @ 23, 45 say "BOBINA:Sem papel, cupom e jornal"
               case bob = "6"
                  @ 23, 45 say "BOBINA:Time-out de recepcao"
               endcase
            endif
         elseif (SubStr(resp, 3, 1) = "G")
            if (SubStr(resp, 6, 1) = "0")
               @ 23, 45 say "Gaveta Aberta"
            elseif (SubStr(resp, 6, 1) = "1")
               @ 23, 45 say "Gaveta Fechada"
            endif
         endif
         s2050_most("2101")
         set color to n/w
         @ 24,  2 say " [ESC] - SAI "
         setcursor(1)
         memoedit(resp, 21, 1, 21, 16, .F., "", 128)
         setcursor(0)
         set color to W/b
         @ 24,  2 say "ÍÍÍÍÍÍÍÍÍÍÍÍÍ"
         set color to W+/b
         @ 21,  1 clear to 23, 78
         @ 23,  1 say "Pressione qualquer tecla para retornar ao menu"
         set color to n/w
         s2050_disp("PRESSIONE  ENTER", 0)
         @ 21,  1 say SubStr(resp, 1, 78)
         @ 22,  1 say SubStr(resp, 79, 50)
         set color to w+/b
         InKey(0)
      endif
   enddo

********************************
function SALVA

   parameters modo
   if (modo = 0 .OR. modo = 3)
      do case
      case LastKey() == K_ESC
         return 0
      case LastKey() == K_ENTER
         return 1
      case LastKey() == K_DOWN
         opcao++
         if (opcao > Len(he))
            opcao--
         endif
         s2050_disp(s20[opcao], 0)
         return 2
      case LastKey() == K_UP
         opcao--
         if (opcao < 1)
            opcao++
         endif
         s2050_disp(s20[opcao], 0)
         return 2
      case LastKey() = K_PGDN .OR. LastKey() = K_PGUP .OR. LastKey() ;
            = K_CTRL_PGDN .OR. LastKey() = K_CTRL_PGUP .OR. ;
            LastKey() = K_CTRL_END .OR. LastKey() = K_CTRL_HOME
         return 1
      case LastKey() = 1 .OR. LastKey() = K_END
         return 1
      endcase
      s2050_disp(s20[opcao], 0)
      return 2
   elseif (modo = 1 .OR. modo = 2)
      s2050_disp(s20[opcao], 0)
      return 2
   endif
   s2050_disp(s20[opcao], 0)
   if (LastKey() == K_ESC)
      return 0
   elseif (LastKey() == K_ENTER)
      return 1
   endif

********************************
procedure DD


********************************
function S2050_MOUT

   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   fwrite(nhandle, "", 1)
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.


********************************
function VALP

   parameters me, me2, ll, cont, cont2
   if (LastKey() == K_UP)
      do case
      case ll == 1
         s2050_mezz(me, cont)
         return .F.
      case ll == 2
         s2050_mezz(me, cont)
      case ll == 3
         s2050_mezz(me, cont)
      case ll == 4
         s2050_mezz(me, cont)
      case ll == 5
         s2050_mezz(me, cont)
      case ll == 6
         s2050_mezz(me, cont)
      case ll == 7
         s2050_mezz(me, cont)
      case ll == 8
         s2050_mezz(me, cont)
      endcase
   elseif (LastKey() == K_DOWN)
      do case
      case ll == 1
         s2050_mezz(me2, cont2)
      case ll == 2
         s2050_mezz(me2, cont2)
      case ll == 3
         s2050_mezz(me2, cont2)
      case ll == 4
         s2050_mezz(me2, cont2)
      case ll == 5
         s2050_mezz(me2, cont2)
      case ll == 6
         s2050_mezz(me2, cont2)
      case ll == 7
         s2050_mezz(me2, cont2)
      case ll == 8
         return .F.
      endcase
   elseif (LastKey() == K_ENTER)
      do case
      case ll == 1
         s2050_mezz(me2, cont2)
      case ll == 2
         s2050_mezz(me2, cont2)
      case ll == 3
         s2050_mezz(me2, cont2)
      case ll == 4
         s2050_mezz(me2, cont2)
      case ll == 5
         s2050_mezz(me2, cont2)
      case ll == 6
         s2050_mezz(me2, cont2)
      case ll == 7
         s2050_mezz(me2, cont2)
      endcase
   endif
   return .T.

********************************
function S2050_DISP

   parameters mensagem, pos
   if (Empty(pos))
      pos:= 0
   endif
   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   if (pos == 0)
      fwrite(nhandle, "", 1)
   elseif (pos == 1)
      fwrite(nhandle, ",", 3)
      fwrite(nhandle, "­,", 3)
   endif
   fwrite(nhandle, "" + Chr(0) + mensagem, 2 + Len(mensagem))
   fwrite(nhandle, " " + mensagem, 2 + Len(mensagem))
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.

********************************
function S2050_MEZZ

   parameters mensagem, par1, pos, carac
   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   if (!Empty(pos))
      num:= 127 + pos
      num2:= 159 + pos
   endif
   fwrite(nhandle, "" + Chr(Len(mensagem)), 2)
   fwrite(nhandle, "" + mensagem, 1 + Len(mensagem))
   if (!Empty(pos))
      fwrite(nhandle, "" + Chr(num) + carac, 2 + Len(carac))
      fwrite(nhandle, "" + Chr(num2) + carac, 2 + Len(carac))
   endif
   fwrite(nhandle, "" + par1, 1 + Len(par1))
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.

********************************
function S2050_APAG

   parameters pos
   num:= 127 + pos
   num2:= 159 + pos
   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   fwrite(nhandle, "" + Chr(num) + " ", 3)
   fwrite(nhandle, "" + Chr(num2) + " ", 3)
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.

********************************
function S2050_CURS

   if (!file("PDV"))
      nhandle:= fcreate("PDV", 0)
      if (ferror() == -1)
         return .F.
      endif
   endif
   nhandle:= fopen("PDV", 2)
   fwrite(nhandle, "", 1)
   if (ferror() == -1)
      return .F.
   endif
   fclose(nhandle)
   return .T.


