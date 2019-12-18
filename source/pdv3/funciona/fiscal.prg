


#include "fileio.ch"

#define ST1_BIT_0 "n£mero de parÉmetros de CMD inv†lido"
#define ST1_BIT_1 "cupom aberto"
#define ST1_BIT_2 "comando inexistente"
#define ST1_BIT_3 "primeiro dado de CMD n∆o foi ESC (1Bh)"
#define ST1_BIT_4 "impressora em erro"
#define ST1_BIT_5 "erro no rel¢gio"
#define ST1_BIT_6 "pouco papel"
#define ST1_BIT_7 "fim de papel"

#define ST2_BIT_0 "comando n∆o executado"
#define ST2_BIT_1 "CGC/IE do propriet†rio n∆o programados"
#define ST2_BIT_2 "cancelamento n∆o permitido"
#define ST2_BIT_3 "capacidade de al°quotas program†veis lotada"
#define ST2_BIT_4 "al°quota n∆o programada"
#define ST2_BIT_5 "erro na Mem¢ria RAM CMOS n∆o vol†til"
#define ST2_BIT_6 "Mem¢ria fiscal lotada"
#define ST2_BIT_7 "tipo de parÉmetro de CMD inv†lido"






/* global executou_sn := .t.*/

set wrap on
set score off
set status off
clear

qout("Um momento, abrindo porta serial (COM2)...")

numero_abertura_porta := fopen("COM2", FO_READWRITE + FO_COMPAT)

if ferror () != 0
   qout("Problemas de comunicacao. Pressione qualquer tecla.")
   return
endif


while .t.


 clear
 set color to w*/b
 @ 0,0 clear to 0,80

 @ 0,1 say "Tecle ESC para sair"
 @ 24,0 clear to 24,80
 set color to w/b
 @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
 set color to n/bg
 @ 1,0 clear to 23,80
 set color to
 @  1,1 to 21,36 double
 vn_menu := 0
 @  2,2 prompt "Cupom Fiscal                      "
 @  3,2 prompt "Cupom N∆o Fiscal                  "
 @  4,2 prompt "Flags                             "
 @  5,2 prompt "Relatorios                        "
 @  6,2 prompt "Entra em hor†rio de ver∆o         "
 @  7,2 prompt "Sai do hor†rio de ver∆o           "
 @  8,2 prompt "Truncamento/Arredondamento        "
 @  9,2 prompt "Nomeia Totalizadores Parciais     "
 @ 10,2 prompt "Simbolo da Moeda Corrente         "
 @ 11,2 prompt "Datas                             "
 @ 12,2 prompt "Informaá‰es Variadas              "
 @ 13,2 prompt "Al°quota Tribut†ria               "
 @ 14,2 prompt "Recebimentos NÑo sujeitos ao ICMS "
 @ 15,2 prompt "Autenticaá∆o                      "
 @ 16,2 prompt "Acionamento de Gaveta             "
 @ 17,2 prompt "Imprime cheque                    "
 @ 18,2 prompt "Dados Da Ultima Reduá∆o           "
 @ 19,2 prompt "Leitura X Pela Serial             "
 @ 20,2 prompt "Leitura das Formas de Pagamento   "

 set color to

 menu to vn_menu

 tamanho_de_retorno := 0
 vc_buffer := inicio_protocolo := chr(27) + chr(251)         /* abertura   protocolo */
 fim_protocolo_driver := "|"+ chr(27)    /* fechamento protocolo */

// sequencia_retorno  := ""

 do case
    case vn_menu = 0
         fclose(numero_abertura_porta) /* fecha porta COMx: */
         clear
         exit
    case vn_menu = 1

         outro_04_menu()
    case vn_menu = 2
         outro_05_menu()
    case vn_menu = 3
         outro_03_menu()
    case vn_menu = 4
         outro_02_menu()
    case vn_menu = 5
         vc_buffer += "18" + fim_protocolo_driver
         comunica_com_impressora(vc_buffer,tamanho_de_retorno)
    case vn_menu = 6
         vc_buffer += "18" + fim_protocolo_driver
         comunica_com_impressora(vc_buffer,tamanho_de_retorno)

    case vn_menu = 7
         resp := space(1)
         set color to n/bg

         @ 18,10 say "Vocà deseja Truncar ou Arredondar? (T/A):" get resp pict "@!"
         set color to
         read
         if resp = "T"
	   tamanho_de_retorno := 0
  	   prepara_string := inicio_protocolo + "39|0" + fim_protocolo_driver
           comunica_com_impressora(prepara_string,tamanho_de_retorno)
         endif
         if resp = "A"
	   tamanho_de_retorno := 0
           prepara_string := inicio_protocolo + "39|1" + fim_protocolo_driver
           comunica_com_impressora(prepara_string,tamanho_de_retorno)
         endif

    case vn_menu = 8
         vc_buffer := chr(27) + chr(251)+"40|#1|Conta da Xuxa      " + fim_protocolo_driver
         tamanho_de_retorno := 0
         prepara_string := NIL
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)

    case vn_menu = 9
         tamanho_de_retorno := 2
         prepara_string := NIL
         prepara_string := vc_buffer + "35|16" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)

         @ 11,30 say "Simbolo de moeda atual ˛" + string_devolvida + "˛"
         altera_sn := string_devolvida
         @ 11,54 get altera_sn
         read
         if altera_sn # string_devolvida
            prepara_string := NIL
            prepara_string := vc_buffer + "01|"+ altera_sn + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
         endif

    case vn_menu = 10

         tamanho_de_retorno := 12
         prepara_string := chr(27) + chr(251)+ + "35|23" + fim_protocolo_driver
         comunica_com_impressora(prepara_string,tamanho_de_retorno)




    case vn_menu = 11
         outro_01_menu()
    case vn_menu = 12
         outro_06_menu()
    case vn_menu = 13
         outro_07_menu()
    case vn_menu = 14
	 set color to r*/bg
	 @ 20,02 say "Insira o Documento a ser autenticado e pressione, <ENTER>!"
	 Wait""
	 if lastkey() = 13
 	    set color to
 	    tamanho_de_retorno := 0
            prepara_string := NIL
 	    prepara_string := inicio_protocolo + "16" + fim_protocolo_driver
	    string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
	 endif
/* Acionamento da Gaveta */

    case vn_menu = 15
	 tamanho_de_retorno := 0
         prepara_string := NIL
         prepara_string := inicio_protocolo + "22|" + chr(255) + fim_protocolo_driver
	 string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)

    case vn_menu = 16
         tamanho_de_retorno := 0
         prepara_string := NIL
         prepara_string := inicio_protocolo +"57|001|00000000010055|Jefferson Wendhausen Mendes Ltda.            |                   Curitiba|10| Fevereiro|  98|Test eTes teTes teTesteT" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)

    case vn_menu = 17
         tamanho_de_retorno := 308
         prepara_string := NIL
         prepara_string := inicio_protocolo +"62|55" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
    case vn_menu = 18
         tamanho_de_retorno := 2500
         prepara_string := NIL
         prepara_string := inicio_protocolo +"69" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
    case vn_menu = 19
         tamanho_de_retorno := 1550
         prepara_string := NIL
         prepara_string := inicio_protocolo +"35|34" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)


 endcase



end

return

static function nomeia_totalizadores(linhas_totalizadores)

 for contador1 := 1 to 9
     totalizadores[contador1][1] := substr(linhas_totalizadores,((contador1*19)-18),19)
     totalizadores[contador1][2] := "#"+str(contador1,1,0)
 next contador1
 for contador1 := 1 to 9
     @ 10+contador1,30 say totalizadores[contador1][2] get totalizadores[contador1][1]
 next contador1
 read

return NIL

static function Decodifica_Retorno(ACK,ST1,ST2)

   Bit_st1:=Bit_st2:=Bit_ack:=0
   Bit_ack=Val(ACK)
   Bit_st1=Val(ST1)
   Bit_st2=Val(ST2)

//Tratamento do Ack ou NAk
  if Bit_ack # 6
   ? "Problemas ao Enviar o Comando a Impressora Devolveu 21"
  end if

//Aqui Ç Feito o Tratamento do St1 subtraindo  o Byte anterior pelo Seguinte
  if Bit_st1 >= 128;? ST1_BIT_7 ;Bit_st1=Bit_st1-128 ;end if
  if Bit_st1 >= 64 ;? ST1_BIT_6 ;Bit_st1=Bit_st1-64  ;end if
  if Bit_st1 >= 32 ;? ST1_BIT_5 ;Bit_st1=Bit_st1-32  ;end if
  if Bit_st1 >= 16 ;? ST1_BIT_4 ;Bit_st1=Bit_st1-16  ;end if
  if Bit_st1 >= 8  ;? ST1_BIT_3 ;Bit_st1=Bit_st1-8   ;end if
  if Bit_st1 >= 4  ;? ST1_BIT_2 ;Bit_st1=Bit_st1-4   ;end if
  if Bit_st1 >= 2  ;? ST1_BIT_1 ;Bit_st1=Bit_st1-2   ;end if
  if Bit_st1 >= 1  ;? ST1_BIT_0                      ;end if
//Aqui Ç Feito o Tratamento do St2 subtraindo  o Byte anterior pelo Seguinte
  if Bit_st2 >= 128;? ST2_BIT_7 ;Bit_st2=Bit_st2-128 ;end if
  if Bit_st2 >= 64 ;? ST2_BIT_6 ;Bit_st2=Bit_st2-64  ;end if
  if Bit_st2 >= 32 ;? ST2_BIT_5 ;Bit_st2=Bit_st2-32  ;end if
  if Bit_st2 >= 16 ;? ST2_BIT_4 ;Bit_st2=Bit_st2-16  ;end if
  if Bit_st2 >= 8  ;? ST2_BIT_3 ;Bit_st2=Bit_st2-8   ;end if
  if Bit_st2 >= 4  ;? ST2_BIT_2 ;Bit_st2=Bit_st2-4   ;end if
  if Bit_st2 >= 2  ;? ST2_BIT_1 ;Bit_st2=Bit_st2-2   ;end if
  if Bit_st2 >= 1  ;? ST1_BIT_0                      ;end if

return NIL



static function comunica_com_impressora(buffer_a_ser_enviado,tam_a_ser_ret)

 /* evia sequencia de bytes para impressora */

 fwrite(numero_abertura_porta, @buffer_a_ser_enviado, len(buffer_a_ser_enviado))

 /* pega o retorno da impressora NAK/ACK ST1 ST2 */

 retorno_impressora := ack := nak := st1 := st2 := space(1)

 for contador1 := 1 to 3

     fread(numero_abertura_porta,@retorno_impressora,1)

     do case
        case contador1 = 1
             do case
                case asc(retorno_impressora) = 21 /* retorno em caracter 21d=15h=NAK */
                     clear
                     ?
                     ? "Atencao... a impressora retornou 21d=15h=NAK"
                     ?
                     ? "NAK"
                     ?
                     ? "Programa abortado!"
                     ?
//                    fclose(numero_abertura_porta)
//                     quit
//                     executou_sn := .f.
                case asc(retorno_impressora) = 06
                     ack := transform(asc(retorno_impressora),"99")
                otherwise
                     clear
                     ?
                     ? "Atencao... provavelmente o driver nao foi carregado !"
                     ? "Programa abortado!"

                     ?
                     fclose(numero_abertura_porta)
                     quit
//                     executou_sn := .f.
             endcase
        case contador1 = 2
             st1 := transform(asc(retorno_impressora),"999")
             //  st1 := asc(retorno_impressora)
        case contador1 = 3
             st2 := transform(asc(retorno_impressora),"999")
             //st2 := asc(retorno_impressora)
     endcase

 next contador1

 /* pega sequencia de retorno caso necess†rio */

 sequencia_retorno := ""
 for contador2 := 1 to tam_a_ser_ret
    fread(numero_abertura_porta, @retorno_impressora, 1)
    sequencia_retorno += retorno_impressora
 next contador2
 clear


 Decodifica_Retorno(ack,st1,st2)

 if asc(retorno_impressora) # 21


    ?
    ? "ACK = [" + ack + "]   ST1 = [" + st1 + "]   ST2 = ["+ st2 + "]"
    ? "Retorno = [" + sequencia_retorno + "]"
    ?
    ?
    wait "Tecle algo para continuar"

 endif

return sequencia_retorno /* executou_sn */

static function outro_01_menu()

 while .t.
    clear
    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 17,35 double
    vn_menu2 := 0
    @  2,2 prompt "N£mero de SÇrie                  "
    @  3,2 prompt "Vers∆o do Firmware               "
    @  4,2 prompt "CGC/IE                           "
    @  5,2 prompt "Grande Total                     "
    @  6,2 prompt "N£mero de Cancelamentos          "
    @  7,2 prompt "N£mero de Descontos              "
    @  8,2 prompt "Contador Sequàncial              "
    @  9,2 prompt "N£mero de Operaá‰es N∆o Fiscais  "
    @ 10,2 prompt "N£mero de Cupons Cancelados      "
    @ 11,2 prompt "N£mero de reduá‰es               "
    @ 12,2 prompt "N£mero de intervená‰es           "
    @ 13,2 prompt "N£mero de Substituiá‰es de Prop. "
    @ 14,2 prompt "N£mero do Ultimo Iten Vendido    "
    @ 15,2 prompt "Clichà do Propriet†rio           "
    @ 16,2 prompt "Retorna Byte de Vinculaá∆o ISS   "
    menu to vn_menu2

    prepara_string := NIL

    do case
       case vn_menu2 = 0
            exit
       case vn_menu2 = 1
            tamanho_de_retorno := 14
            prepara_string := inicio_protocolo + "35|00" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("N£mero de SÇrio",string_devolvida)
       case vn_menu2 = 2
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|01" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Vers∆o do Firmware",string_devolvida)
       case vn_menu2 = 3
            tamanho_de_retorno := 33
            prepara_string := inicio_protocolo + "35|02" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("CGC/IE",string_devolvida)
       case vn_menu2 = 4
            tamanho_de_retorno := 18
            prepara_string := inicio_protocolo + "35|03" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Grande Total",string_devolvida)
       case vn_menu2 = 5
            tamanho_de_retorno := 14
            prepara_string := inicio_protocolo + "35|04" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Cancelamentos",string_devolvida)
       case vn_menu2 = 6

            tamanho_de_retorno := 14
            prepara_string := inicio_protocolo + "35|05" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Descontos",string_devolvida)
       case vn_menu2 = 7
            tamanho_de_retorno := 6
            prepara_string := inicio_protocolo + "35|06" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Contador Sequencial",string_devolvida)
       case vn_menu2 = 8
            tamanho_de_retorno := 6
            prepara_string := inicio_protocolo + "35|07" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Operaá‰es n∆o Fiscais",string_devolvida)
       case vn_menu2 = 9
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|08" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Cupons Cancelados",string_devolvida)
       case vn_menu2 = 10
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|09" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Reduá‰es",string_devolvida)
       case vn_menu2 = 11
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|10" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Intervená‰es",string_devolvida)
       case vn_menu2 = 12
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|11" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Subst.Propriet†rio",string_devolvida)
       case vn_menu2 = 13
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|12" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Èltimo item vendido",string_devolvida)
       case vn_menu2 = 14
            tamanho_de_retorno := 144
            prepara_string := inicio_protocolo + "35|13" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Èltimo item vendido",string_devolvida)
       case vn_menu2 = 15
            tamanho_de_retorno := 2
            prepara_string := inicio_protocolo + "35|29" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            x=Transform(Asc(string_devolvida),"999")
            mostra_informacao("Èltimo item vendido",x)

    endcase

 enddo

return NIL



static function outro_02_menu()

 while .t.

    clear
    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 6,40 double

    vn_menu3 := 0
    @  2,2 prompt "Leitura X                             "
    @  3,2 prompt "Reduá∆o Z                             "
    @  4,2 prompt "Leitura da Mem¢ria Fiscal - Datas     "
    @  5,2 prompt "Leitura da Mem¢ria Fiscal - Intervalo "
    menu to vn_menu3

    prepara_string := NIL

    do case
       case vn_menu3 = 0
            exit
       case vn_menu3 = 1
            prepara_string := inicio_protocolo + "06" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu3 = 2
            prepara_string := inicio_protocolo + "05" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu3 = 3
            dta_inicio := dta_fim := ctod("  /  /  ")
            @ 15,00 say "Data de inicio " get dta_inicio
            @ 16,00 say "Data de fim    " get dta_fim
            read

            dta_inicio := strtran(dtoc(dta_inicio),"/")
            dta_fim    := strtran(dtoc(dta_fim),"/")

            prepara_string := inicio_protocolo + "08|"+dta_inicio+"|"+dta_fim+"|I|"+fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu3 = 4
            ini_inter := fim_inter := 0
            @ 15,00 say "Reduá∆o Inicio " get ini_inter picture "9999"
            @ 16,00 say "Reduá∆o fim    " get fim_inter picture "9999"
            read

/*            prepara_string := inicio_protocolo + "08|"+chr(30)+chr(30)+"|"+;
                            strzero(ini_inter,4,0)+"|"+chr(30)+chr(30)+"|"+;
                            strzero(fim_inter,4,0)+"|I|"+fim_protocolo_driver
*/
            prepara_string := inicio_protocolo + "08|00|"+;
                            strzero(ini_inter,4,0)+"|00|"+;
                            strzero(fim_inter,4,0)+"|I|"+fim_protocolo_driver


            comunica_com_impressora(prepara_string,tamanho_de_retorno)

    endcase

 enddo

return NIL



static function outro_03_menu()

 while .t.

    clear

    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 6,39 double
    vn_menu4 := 0
    @  2,2 prompt "Intervená∆o TÇcnica                  "
    @  3,2 prompt "Eprom Conectada                      "
    @  4,2 prompt "Truncamento                          "
    @  5,2 prompt "Vinculaá∆o ao ISS                    "
    menu to vn_menu4

    prepara_string := NIL
    tamanho_de_retorno := 1

    do case
       case vn_menu4 = 0
            exit
       case vn_menu4 = 1
            prepara_string := inicio_protocolo + "35|20" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            string_devolvida := if(string_devolvida = "U","MODO NORMAL","MODO INTERVENÄ«O TêCNICA")
            mostra_informacao("Estado da Impressora",string_devolvida)
       case vn_menu4 = 2
            prepara_string := inicio_protocolo + "35|21" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            string_devolvida := if(string_devolvida = "U","EPROM CONECTADA","EPROM DESCONECTADA")
            mostra_informacao("Estado da Impressora",string_devolvida)
       case vn_menu4 = 3
            prepara_string := inicio_protocolo + "35|28" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            string_devolvida := if(string_devolvida = CHR(255),"ARREDONDAMENTO","TRUNCAMENTO")
            mostra_informacao("Estado da Impressora",string_devolvida)

/* Vinculando ao ISS */

       case vn_menu4 = 4
            tamanho_de_retorno := 06
            prepara_string := inicio_protocolo + "35|23" + fim_protocolo_driver
            string_dev := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            prepara_string := NIL
            tamanho_de_retorno := 06
            prepara_string := vc_buffer + "35|27" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
                do case
                   case string_devolvida = string_dev
                      set color to g*/n
                      @ 10,02 say "Obs.: Esta opá∆o n∆o pode ser utilizada, pois j† houve movimentaá∆o no dia..."
                      set color to
                      @ 12,02 say "Pressione qualquer tecla para continuar..."
                      Wait""
                    exit
                endcase
            qual_tot := 0
            @ 07,05 say "Qual totalizador (01/16) deseja vincular ao ISS ?" get qual_tot pict "99"
            read
            do case
                case qual_tot = 01
                    tamanho_de_retorno := 0
		    prepara_string := inicio_protocolo + "38|1000000000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 02
                    prepara_string := inicio_protocolo + "38|0100000000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 03
                    prepara_string := inicio_protocolo + "38|0010000000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 04
                    prepara_string := inicio_protocolo + "38|0001000000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 05
                    prepara_string := inicio_protocolo + "38|0000100000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 06
                    prepara_string := inicio_protocolo + "38|0000010000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 07
                    prepara_string := inicio_protocolo + "38|0000001000000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 08
                    prepara_string := inicio_protocolo + "38|0000000100000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 09
                    prepara_string := inicio_protocolo + "38|0000000010000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 10
                    prepara_string := inicio_protocolo + "38|0000000001000000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 11
                    prepara_string := inicio_protocolo + "38|0000000000100000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 12
                    prepara_string := inicio_protocolo + "38|0000000000010000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 13
                    prepara_string := inicio_protocolo + "38|0000000000001000" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 14
                    prepara_string := inicio_protocolo + "38|0000000000000100" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 15
                    prepara_string := inicio_protocolo + "38|0000000000000010" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
                case qual_tot = 16
                    prepara_string := inicio_protocolo + "38|0000000000000001" + fim_protocolo_driver
                    comunica_com_impressora(prepara_string,tamanho_de_retorno)
            endcase
    endcase
 enddo

return NIL


static function outro_05_menu()

 while .t.

    clear
    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 5,39 double
    vn_menu6 := 0
    @  2,2 prompt "Abre Cupom N∆o Fiscal                "
    @  3,2 prompt "Imprime Mensagem                     "
    @  4,2 prompt "Fecha Cupom N∆o Fiscal               "
    menu to vn_menu6

    prepara_string := NIL
    tamanho_de_retorno := 0

    do case
       case vn_menu6 = 0
            exit
       case vn_menu6 = 1
            prepara_string := inicio_protocolo + "20" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu6 = 2
            clear
            mensagem := space(48)
            @ 0,0 say "Entre com a mensagem" get mensagem
            read

            mensagem := alltrim(mensagem) + chr(10) // Ç obrigat¢rio usar

/* inicia negrito*/

            prepara_string := inicio_protocolo + "20|\" + chr(27) + chr(69) + mensagem + "\" + chr(27) + chr(70) + mensagem + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)

       case vn_menu6 = 3

/* fecha negrito*/

            prepara_string := inicio_protocolo + "21" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
    endcase
 enddo
return NIL

static function outro_04_menu()

 while .t.

    clear
    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 14,46 double
    vn_menu5 := 0
    @  2,2 prompt "Abre Cupom Fiscal                           "
    @  3,2 prompt "Cancela Cupom Fiscal - Sem Vendas Efetuadas "
    @  4,2 prompt "Cancela Cupom Fiscal - Com Vendas Efetuadas "
    @  5,2 prompt "Vende Item / Gasolina                       "
    @  6,2 prompt "Vende Item / Normal                         "
    @  7,2 prompt "Vende Item / Configuravel                   "
    @  8,2 prompt "Cancela Ultimo Item Vendido                 "
    @  9,2 prompt "Cancela Item GenÇrico                       "
    @ 10,2 prompt "Fecha Cupom Fiscal sem Formas de Pagamento  "
    @ 11,2 prompt "Fecha Cupom Fiscal com Formas de Pagamento  "
    @ 12,2 prompt "Retorna o Subtotal                          "
    @ 13,2 prompt "N£mero do Cupom                             "

//    @  8,0 prompt "Fecha Cupom Fiscal                          "
    menu to vn_menu5

    prepara_string := NIL
    tamanho_de_retorno := 0

    do case
       case vn_menu5 = 0
            exit
       case vn_menu5 = 1
            prepara_string := inicio_protocolo + "00" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 2
            prepara_string := inicio_protocolo + "10|0000|00000000000000|A" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 3
            prepara_string := inicio_protocolo + "10|0000|00000000000000|A" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
            prepara_string := inicio_protocolo + "14" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 4
            prepara_string := inicio_protocolo + "56|0000000000001|GASOLINA 01234567890123456789|FF|0001000|00000788|0000" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 5
            prepara_string := inicio_protocolo + "09|0000000000002|Bala de Goma Xuxa            |FF|0001|00000005|0000" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 6
            declare venda_item[2][6]
            venda_item[1][1] := space(13) ; venda_item[2][1] := "C¢digo"
            venda_item[1][2] := space(29) ; venda_item[2][2] := "Descriá∆o"
            venda_item[1][3] := space(2)  ; venda_item[2][3] := "Al°quota"
            venda_item[1][4] := 0         ; venda_item[2][4] := "Quantidade"
            venda_item[1][5] := 0         ; venda_item[2][5] := "Valor Unit†rio"
            venda_item[1][6] := 0         ; venda_item[2][6] := "Desconto"

            clear

            @ 0,0 say "Informe os dados para venda"
            @ 2,0 say venda_item[2][1] + space(3) get venda_item[1][1]
            @ 3,0 say venda_item[2][2]            get venda_item[1][2]
            @ 4,0 say venda_item[2][3] + space(1) get venda_item[1][3] picture "@!"
            read

            @ 6,0 say "Escolha as opá‰es a baixo - Use as setas direcionais <- ->, ENTER Seleciona"
            @ 8,0 say "Quantidade - [Inteira] Fracionaria"
            escolha_quantidade := escolha_desconto := .t.
            fraciona_valor := .f.
            setcursor(0)
            do while .t.
               tecla := inkey(0)
               do case
                  case tecla == 4
                       @ 8,0 say "Quantidade -  Inteira [Fracionaria]"
                       escolha_quantidade := .f.
                  case tecla == 19
                       @ 8,0 say "Quantidade - [Inteira] Fracionaria "
                       escolha_quantidade := .t.
                  case tecla == 13
                       exit
               endcase
            enddo
            @ 9,0 say "Desconto - [Por Percentual] Por Valor"
            do while .t.
               tecla := inkey(0)
               do case
                  case tecla == 4
                       @ 9,0 say "Desconto -  Por Percentual [Por Valor]"
                       escolha_desconto := .f.
                  case tecla == 19
                       @ 9,0 say "Desconto - [Por Percentual] Por Valor "
                       escolha_desconto := .t.
                  case tecla == 13
                       exit
               endcase
            enddo
            @ 10,0 say "Fraciona valor -  Sim [N∆o]"
            do while .t.
               tecla := inkey(0)
               do case
                  case tecla == 4
                       @ 10,0 say "Fraciona valor -  Sim [N∆o]"
                       fraciona_valor := .f.
                  case tecla == 19
                       @ 10,0 say "Fraciona valor - [Sim] N∆o "
                       fraciona_valor := .t.
                  case tecla == 13
                       exit
               endcase
            enddo
            setcursor(1)
            @ 11,0 say venda_item[2][4] + " " + if(escolha_quantidade,"Inteira","Fracionaria")    get venda_item[1][4] picture if(escolha_quantidade,"9999","9999,999")
            @ 12,0 say venda_item[2][5] + " " get venda_item[1][5] picture if(fraciona_valor,"99999,999","999999,99")
            @ 13,0 say venda_item[2][6] + " " + if(escolha_desconto,"por Percentual","por Valor") get venda_item[1][6] picture if(escolha_desconto,"99,99","999999,99")
            read

            if isdigit(substr(venda_item[1][1],1,1))
               venda_item[1][1] := strzero(val(venda_item[1][1]),13,0)
            endif

            venda_item[1][4] := if(escolha_quantidade,strzero(venda_item[1][4],4,0),strzero(venda_item[1][4],7,0))

            venda_item[1][5] := strzero(venda_item[1][5],8,0)

            if fraciona_valor
               prepara_string := inicio_protocolo + "56|" + venda_item[1][1] +"|"+venda_item[1][2] +"|"+venda_item[1][3]+"|"+venda_item[1][4]+"|"+venda_item[1][5]+"|0000" + fim_protocolo_driver
               comunica_com_impressora(prepara_string,tamanho_de_retorno)
            else
               prepara_string := inicio_protocolo + "09|" + venda_item[1][1] +"|"+venda_item[1][2] +"|"+venda_item[1][3]+"|"+venda_item[1][4]+"|"+venda_item[1][5]+"|0000" + fim_protocolo_driver
               comunica_com_impressora(prepara_string,tamanho_de_retorno)
            endif
       case vn_menu5 = 7
            prepara_string := inicio_protocolo + "13" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 8
            item_a_ser_cancelado := space(4)
            @ 20,0 say "N£mero do item a ser cancelado" get item_a_ser_cancelado picture "9999"
            read

            item_a_ser_cancelado := strzero(val(item_a_ser_cancelado))

            prepara_string := inicio_protocolo + "31|"+ item_a_ser_cancelado + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 9

            prepara_string := inicio_protocolo + "10|0000|00000000001000|A|Esta Ç a mensagem promocional...Hoje Ç sexta-feira..traga mais cerveja!!!!!!" + chr(10) +  fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)

       case vn_menu5 = 10
            /* Inicia Fechamento de Cupom com Formas de Pagamento */
            prepara_string := inicio_protocolo + "32|A|0000" +  fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
            /* Efetua Forma de Pagamento */       /* 1234567890123456789012        12345678901234*/
            prepara_string := inicio_protocolo + "33|Cartao                |00000000000015" +  fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
	    prepara_string := inicio_protocolo + "34|Volte sempre" + chr(13) + chr(10) + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 11
            tamanho_de_retorno := 14
            prepara_string := inicio_protocolo + "29" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Subtotal" ,string_devolvida)
       case vn_menu5 = 12
            tamanho_de_retorno := 6
            prepara_string := inicio_protocolo + "30" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("N£mero do Cupom Aberto" ,string_devolvida)

    endcase

 enddo

return NIL

static function mostra_informacao( mensagem, conteudo )

 @ 20,0 say mensagem + " ˛" + conteudo + "˛"
 @ 24,0 say "Tecle algo para retornar"
 inkey(0)

return NIL

static function outro_06_menu()

 while .t.

    clear
    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 4,46 double
    vn_menu7 := 0
    @  2,2 prompt "Retorno de Al°quotas                        "
    @  3,2 prompt "Adiá∆o de Al°quota Tribut†ria               "
    menu to vn_menu7

    prepara_string := NIL
    tamanho_de_retorno := 0

    do case
       case vn_menu7 = 0
            exit
       case vn_menu7 = 1
            tamanho_de_retorno := 66
            prepara_string := inicio_protocolo + "26" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            declare aliquotas[2][16]

            clear
            for contador2 := 1 to 16
                ? "T"+strzero(contador2,2,0) + " - " + stuff(substr(string_devolvida,((contador2*4)-3)+2,4),3,0,",")
            next
            wait "Tecle algo para continuar"

       case vn_menu7 = 2
            aliquota_a_ser_incluida := space(4)
            @ 20,00 say "Informe o valor da al°quota a ser cadastrada" get aliquota_a_ser_incluida picture "9999"
            read
            prepara_string := inicio_protocolo + "07|"+ aliquota_a_ser_incluida + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
    endcase

 enddo

return NIL

static function outro_07_menu()

 while .t.

    clear
    set color to w*/b
    @ 0,0 clear to 0,80
    @ 0,1 say "Tecle ESC para sair"
    @ 24,0 clear to 24,80
    set color to w/b
    @ 24,1 say "BEMATECH, sempre presente nas melhores soluá‰es"
    set color to n/bg
    @ 1,0 clear to 23,80
    set color to
    @  1,1 to 5,40 double
    vn_menu7 := 0
    @  2,2 prompt "Sangria                               "
    @  3,2 prompt "Suprimento                            "
    @  4,2 prompt "Recebimento em Totalizador Parcial    "
    menu to vn_menu7

    prepara_string := NIL

    do case
       case vn_menu7 = 0
            exit
       case vn_menu7 = 1
            valor_temp := 0
            @ 10,0 say "Informe o valor da sangria" get valor_temp picture "9999999,99"
            read
            prepara_string := inicio_protocolo + "25|SA|"+strzero(valor_temp,14,0) + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu7 = 2
            valor_temp := 0
            @ 10,0 say "Informe o valor da suprimento" get valor_temp picture "9999999,99"
            read
            prepara_string := inicio_protocolo + "25|SU|"+strzero(valor_temp,14,0) + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu7 = 3
            qual_totalizador := valor_temp := 0
            @ 09,0 say "N£mero do Totalizador, de 1 a 9" get qual_totalizador picture "9" valid qual_totalizador >= 1 .and. qual_totalizador <= 9
            @ 10,0 say "Informe o valor do recebimento " get valor_temp picture "9999999,99"
            read
            prepara_string := inicio_protocolo + "25|#"+str(qual_totalizador,1,0)+"|"+strzero(valor_temp,14,0) + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
    endcase

 enddo

return NIL
