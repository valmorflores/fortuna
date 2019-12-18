 /*

 By Mario Loureiro
 Analista de Suporte Bematech
 Last Update 02/04/98

 nao esque�a de carregar o driver residente ( MP20DRV.EXE )

*/

#include "fileio.ch"

#define ST1_BIT_0 "n�mero de par�metros de CMD inv�lido"
#define ST1_BIT_1 "cupom aberto"
#define ST1_BIT_2 "comando inexistente"
#define ST1_BIT_3 "primeiro dado de CMD n�o foi ESC (1Bh)"
#define ST1_BIT_4 "impressora em erro"
#define ST1_BIT_5 "erro no rel�gio"
#define ST1_BIT_6 "pouco papel"
#define ST1_BIT_7 "fim de papel"

#define ST2_BIT_0 "comando n�o executado"
#define ST2_BIT_1 "CGC/IE do propriet�rio n�o programados"
#define ST2_BIT_2 "cancelamento n�o permitido"
#define ST2_BIT_3 "capacidade de al�quotas program�veis lotada"
#define ST2_BIT_4 "al�quota n�o programada"
#define ST2_BIT_5 "erro na Mem�ria RAM CMOS n�o vol�til"
#define ST2_BIT_6 "Mem�ria fiscal lotada"
#define ST2_BIT_7 "tipo de par�metro de CMD inv�lido"

/* global executou_sn := .t.
*/

set wrap on


clear

qout("Um momento, abrindo porta serial (COM1:)...")

numero_abertura_porta := fopen("COM1", FO_READWRITE + FO_COMPAT)

if ferror () != 0
   qout("Problemas de comunicacao. Pressione qualquer tecla.")
   return
endif

while .t.

 clear

 @ 0,0 say "Tecle ESC para sair"

 vn_menu := 0
 @  2,0 prompt "Cupom Fiscal                      "
 @  3,0 prompt "Cupom Nao Fiscal                  "
 @  4,0 prompt "Flags                             "
 @  5,0 prompt "Relatorios                        "
 @  6,0 prompt "Entra em hor�rio de verao         "
 @  7,0 prompt "Sai do hor�rio de verao           "
 @  8,0 prompt "Truncamento/Arredondamento        "
 @  9,0 prompt "Nomeia Totalizadores Parciais     "
 @ 10,0 prompt "Simbolo da Moeda Corrente         "
 @ 11,0 prompt "Datas                             "
 @ 12,0 prompt "Informa��es Variadas              "
 @ 13,0 prompt "Al�quota Tribut�ria               "
 @ 14,0 prompt "Recebimentos N�o sujeitos ao ICMS "

 menu to vn_menu

 tamanho_de_retorno := 0
 vc_buffer := inicio_protocolo := chr(27) + chr(251)         /* abertura   protocolo */
 fim_protocolo_driver := "|"+ chr(27)    /* fechamento protocolo */

// sequencia_retorno  := ""

 do case
    case vn_menu = 0
         fclose(numero_abertura_porta) /* fecha porta COMx: */
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
    case vn_menu = 8
//         vc_buffer := chr(27) + chr(251)+"40|#2|Conta da Xuxa      " + fim_protocolo_driver
         tamanho_de_retorno := 171
         prepara_string := NIL
         prepara_string := vc_buffer + "35|25" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)

         declare totalizadores[9][2]
         nomeia_totalizadores(string_devolvida)
         for incre1 := 1 to 9
             prepara_string := NIL
             prepara_string := vc_buffer + "40|"+totalizadores[incre1][2]+"|"+totalizadores[incre1][1] + fim_protocolo_driver
             comunica_com_impressora(prepara_string,tamanho_de_retorno)
         next
    case vn_menu = 9
         tamanho_de_retorno := 2
         prepara_string := NIL
         prepara_string := vc_buffer + "35|16" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)

         @ 11,30 say "Simbolo de moeda atual �" + string_devolvida + "�"
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
         prepara_string := NIL
         prepara_string := vc_buffer + "35|23" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
         @ 10,30      say "Data e Hora Atual �"
         @ 10,col()+1 say string_devolvida picture "@r 99/99/99 99:99:99"
         wait ""
         @ 10,00 say space(80)
         wait ""


         tamanho_de_retorno := 20
         prepara_string := NIL
         prepara_string := vc_buffer + "35|26" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
         @ 10,30      say "Data e Hora Ultima Redu��o �"
         @ 10,col()+1 say string_devolvida picture "@r 99/99/99 99:99:99"
         wait ""
         @ 10,00 say space(80)
         wait ""

         tamanho_de_retorno := 06
         prepara_string := NIL
         prepara_string := vc_buffer + "35|27" + fim_protocolo_driver
         string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
         @ 10,30      say "Data do Movimento �"
         @ 10,col()+1 say string_devolvida picture "@r 99/99/99"
         wait ""
         @ 10,00 say space(80)
         wait ""
    case vn_menu = 11
         outro_01_menu()
    case vn_menu = 12
         outro_06_menu()
    case vn_menu = 13
         outro_07_menu()

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
        case contador1 = 3
             st2 := transform(asc(retorno_impressora),"999")
     endcase

 next contador1

 /* pega sequencia de retorno caso necess�rio */

 sequencia_retorno := ""
 for contador2 := 1 to tam_a_ser_ret
    fread(numero_abertura_porta, @retorno_impressora, 1)
    sequencia_retorno += retorno_impressora
 next contador2

 if asc(retorno_impressora) # 21

    clear
    ?
    ? "ACK = [" + ack + "]   ST1 = [" + st1 + "]   ST2 = ["+ st2 + "]"
    ? "Retorno = [" + sequencia_retorno + "]"
    ?
    ?
    wait "Tecle algo para retornar"

 endif

return sequencia_retorno /* executou_sn */



static function outro_01_menu()

 while .t.

    clear

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu2 := 0
    @  2,0 prompt "N�mero de S�rie                  "
    @  3,0 prompt "Vers�o do Firmware               "
    @  4,0 prompt "CGC/IE                           "
    @  5,0 prompt "Grande Total                     "
    @  6,0 prompt "N�mero de Cancelamentos          "
    @  7,0 prompt "N�mero de Descontos              "
    @  8,0 prompt "Contador Sequ�ncial              "
    @  9,0 prompt "N�mero de Opera��es N�o Fiscais  "
    @ 10,0 prompt "N�mero de Cupons Cancelados      "
    @ 11,0 prompt "N�mero de redu��es               "
    @ 12,0 prompt "N�mero de interven��es           "
    @ 13,0 prompt "N�mero de Substitui��es de Prop. "
    @ 14,0 prompt "N�mero do Ultimo Iten Vendido    "
    @ 15,0 prompt "Clich� do Propiet�rio            "
    menu to vn_menu2

    prepara_string := NIL

    do case
       case vn_menu2 = 0
            exit
       case vn_menu2 = 1
            tamanho_de_retorno := 14
            prepara_string := inicio_protocolo + "35|00" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("N�mero de S�rio",string_devolvida)
       case vn_menu2 = 2
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|01" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Vers�o do Firmware",string_devolvida)
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
            mostra_informacao("Opera��es n�o Fiscais",string_devolvida)
       case vn_menu2 = 9
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|08" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Cupons Cancelados",string_devolvida)
       case vn_menu2 = 10
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|09" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Redu��es",string_devolvida)
       case vn_menu2 = 11
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|10" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Interven��es",string_devolvida)
       case vn_menu2 = 12
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|11" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("Subst.Propriet�rio",string_devolvida)
       case vn_menu2 = 13
            tamanho_de_retorno := 4
            prepara_string := inicio_protocolo + "35|12" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("�ltimo item vendido",string_devolvida)
       case vn_menu2 = 14
            tamanho_de_retorno := 144
            prepara_string := inicio_protocolo + "35|13" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            mostra_informacao("�ltimo item vendido",string_devolvida)

    endcase

 enddo

return NIL



static function outro_02_menu()

 while .t.

    clear

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu3 := 0
    @  2,0 prompt "Letura X                              "
    @  3,0 prompt "Redu��o Z                             "
    @  4,0 prompt "Leitura da Mem�ria Fiscal - Datas     "
    @  5,0 prompt "Leitura da Mem�ria Fiscal - Intervalo "
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
            @ 15,00 say "Redu��o Inicio " get ini_inter picture "9999"
            @ 16,00 say "Redu��o fim    " get fim_inter picture "9999"
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

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu4 := 0
    @  2,0 prompt "Interven��o T�cnica                   "
    @  3,0 prompt "Eprom Conectada                       "
    @  4,0 prompt "Truncamento                           "
    @  5,0 prompt "Vincula��o ao ISS                     "
    menu to vn_menu4

    prepara_string := NIL
    tamanho_de_retorno := 1

    do case
       case vn_menu4 = 0
            exit
       case vn_menu4 = 1
            prepara_string := inicio_protocolo + "35|20" + fim_protocolo_driver
            string_devolvida := comunica_com_impressora(prepara_string,tamanho_de_retorno)
            string_devolvida := if(string_devolvida = "U","MODO NORMAL","MODO INTERVEN��O T�CNICA")
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
       case vn_menu4 = 4

    endcase

 enddo

return NIL


static function outro_05_menu()

 while .t.

    clear

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu6 := 0
    @  2,0 prompt "Abre Cupom N�o Fiscal                 "
    @  3,0 prompt "Fecha Cupom N�o Fiscal                "
    @  4,0 prompt "Imprime Mensagem                      "
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
            prepara_string := inicio_protocolo + "21" + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu6 = 3
            clear
            mensagem := space(48)
            @ 0,0 say "Entre com a mensagem" get mensagem
            read

            mensagem := alltrim(mensagem) + chr(10) // � obrigat�rio usar

            prepara_string := inicio_protocolo + "20|" + mensagem + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)




    endcase

 enddo

return NIL



static function outro_04_menu()

 while .t.

    clear

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu5 := 0
    @  2,0 prompt "Abre Cupom Fiscal                           "
    @  3,0 prompt "Cancela Cupom Fiscal - Sem Vendas Efetuadas "
    @  4,0 prompt "Cancela Cupom Fiscal - Com Vendas Efetuadas "
    @  5,0 prompt "Vende Item / Gasolina                       "
    @  6,0 prompt "Vende Item / Normal                         "
    @  7,0 prompt "Vende Item / Configuravel                   "
    @  8,0 prompt "Cancela Ultimo Item Vendido                 "
    @  9,0 prompt "Cancela Item Gen�rico                       "
    @ 10,0 prompt "Fecha Cupom Fiscal sem Formas de Pagamento  "
    @ 11,0 prompt "Fecha Cupom Fiscal com Formas de Pagamento  "
    @ 12,0 prompt "Retorna o Subtotal                          "
    @ 13,0 prompt "N�mero do Cupom                             "


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
            venda_item[1][1] := space(13) ; venda_item[2][1] := "C�digo"
            venda_item[1][2] := space(29) ; venda_item[2][2] := "Descri��o"
            venda_item[1][3] := space(2)  ; venda_item[2][3] := "Al�quota"
            venda_item[1][4] := 0         ; venda_item[2][4] := "Quantidade"
            venda_item[1][5] := 0         ; venda_item[2][5] := "Valor Unit�rio"
            venda_item[1][6] := 0         ; venda_item[2][6] := "Desconto"

            clear

            @ 0,0 say "Informe os dados para venda"
            @ 2,0 say venda_item[2][1] + space(3) get venda_item[1][1]
            @ 3,0 say venda_item[2][2]            get venda_item[1][2]
            @ 4,0 say venda_item[2][3] + space(1) get venda_item[1][3] picture "@!"
            read

            @ 6,0 say "Escolha as op��es a baixo - Use as setas direcionais <- ->, ENTER Seleciona"
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
            @ 10,0 say "Fraciona valor -  Sim [N�o]"
            do while .t.
               tecla := inkey(0)
               do case
                  case tecla == 4
                       @ 10,0 say "Fraciona valor -  Sim [N�o]"
                       fraciona_valor := .f.
                  case tecla == 19
                       @ 10,0 say "Fraciona valor - [Sim] N�o "
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
            @ 20,0 say "N�mero do item a ser cancelado" get item_a_ser_cancelado picture "9999"
            read

            item_a_ser_cancelado := strzero(val(item_a_ser_cancelado))

            prepara_string := inicio_protocolo + "31|"+ item_a_ser_cancelado + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
       case vn_menu5 = 9

            prepara_string := inicio_protocolo + "10|0000|00000000000000|A|Esta � a mensagem promocional...Hoje � sexta-feira..traga mais cerveja!!!!!!" + chr(10) +  fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)

       case vn_menu5 = 10
            /* Inicia Fechamento de Cupom com Formas de Pagamento */
            prepara_string := inicio_protocolo + "32|A|0000" +  fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
            /* Efetua Forma de Pagamento */       /* 1234567890123456789012        12345678901234*/
            prepara_string := inicio_protocolo + "33|Pagamento com vale transporte|00000000001000" +  fim_protocolo_driver
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
            mostra_informacao("N�mero do Cupom Aberto" ,string_devolvida)

    endcase

 enddo

return NIL

static function mostra_informacao( mensagem, conteudo )

 @ 20,0 say mensagem + " �" + conteudo + "�"
 @ 24,0 say "Tecle algo para retornar"
 inkey(0)

return NIL

static function outro_06_menu()

 while .t.

    clear

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu7 := 0
    @  2,0 prompt "Retorno de Al�quotas                        "
    @  3,0 prompt "Adi��o de Al�quota Tribut�ria               "
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
            @ 20,00 say "Informe o valor da al�quota a ser cadastrada" get aliquota_a_ser_incluida picture "9999"
            read
            prepara_string := inicio_protocolo + "07|"+ aliquota_a_ser_incluida + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
    endcase

 enddo

return NIL

static function outro_07_menu()

 while .t.

    clear

    @ 0,0 say "Tecle ESC para retornar"

    vn_menu7 := 0
    @  2,0 prompt "Sangria                               "
    @  3,0 prompt "Suprimento                            "
    @  4,0 prompt "Recebimento em Totalizador Parcial    "
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
            @ 09,0 say "N�mero do Totalizador, de 1 a 9" get qual_totalizador picture "9" valid qual_totalizador >= 1 .and. qual_totalizador <= 9
            @ 10,0 say "Informe o valor do recebimento " get valor_temp picture "9999999,99"
            read
            prepara_string := inicio_protocolo + "25|#"+str(qual_totalizador,1,0)+"|"+strzero(valor_temp,14,0) + fim_protocolo_driver
            comunica_com_impressora(prepara_string,tamanho_de_retorno)
    endcase

 enddo

return NIL
