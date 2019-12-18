#include "common.ch"
#include "inkey.ch"

   parametro:= ""
   set scoreboard off
   set date british
   set wrap on
   set confirm on
   private zpm_erro[127]
   zpm_erro[1]:= "Comando Invalido para o Device. Erro Interno!"
   zpm_erro[2]:= "Impressora esta fora de linha, desligada ou desconectada"
   zpm_erro[3]:= "Device Driver ocupado. Erro Interno!"
   zpm_erro[4]:= "Comando nao implementado. Erro Interno!"
   zpm_erro[5]:= "Erro de Sintaxe em comando. Erro Interno!"
   zpm_erro[6]:= "Tempo para execucao do comando esgotado. Timeout"
   zpm_erro[7]:= "Parametro invalido passado para a LIB"
   zpm_erro[8]:= "LIB ja esta ativa"
   zpm_erro[9]:= "LIB nao esta ativa"
   zpm_erro[10]:= "Device Driver nao instalado"
   for i:= 11 to 32
      zpm_erro[i]:= "Resposta nao documentada " + Str(i, 2)
   next
   zpm_erro[33]:= "Retorno Ok!"
   zpm_erro[34]:= "Cancelamento invalido"
   zpm_erro[35]:= "Abertura do dia invalida"
   zpm_erro[36]:= "Aliquota nao carregada"
   zpm_erro[37]:= "Erro na gravacao da memoria fiscal"
   zpm_erro[38]:= "Numero Maximo de Troca de Estabelecimento alcancado"
   zpm_erro[39]:= "Erro no Byte Verificador da Memoria Fiscal"
   zpm_erro[40]:= "Impressora em intervencao tecnica"
   zpm_erro[41]:= "Memoria Fiscal desconectada"
   zpm_erro[42]:= "Indice da Aliquota invalido"
   zpm_erro[43]:= "Nao houve desconto anterior"
   zpm_erro[44]:= "Desconto invalido"
   zpm_erro[45]:= "Nao houve acrescimo no subtotal"
   zpm_erro[46]:= "Retorno desconhecido 46"
   zpm_erro[47]:= "Perda da memoria RAM"
   zpm_erro[48]:= "Comando aceito apenas em intervencao tecnica"
   zpm_erro[49]:= "Memoria Fiscal ja inicializada"
   zpm_erro[50]:= "Fechamento nao realizado"
   zpm_erro[51]:= "Fechamento ja realizado"
   zpm_erro[52]:= "Comando fora de sequencia"
   zpm_erro[53]:= "Nao comecou a venda"
   zpm_erro[54]:= "Nao houve pagamento"
   zpm_erro[55]:= "Cupom ja totalizado"
   zpm_erro[56]:= "Comando inexistente"
   zpm_erro[57]:= "Impressora retornou timeout RX"
   zpm_erro[58]:= "Retorno desconhecido 58"
   zpm_erro[59]:= "Nao houve desconto no subtotal"
   zpm_erro[60]:= "Retorno desconhecido 60"
   zpm_erro[61]:= "Valor de desconto invalido"
   zpm_erro[62]:= "Retorno desconhecido 62"
   zpm_erro[63]:= "Cancelamento de cupom invalido"
   zpm_erro[64]:= "Retorno desconhecido 64"
   zpm_erro[65]:= "Retorno desconhecido 65"
   zpm_erro[66]:= "Aliquota indisponivel"
   zpm_erro[67]:= "Troca de proprietario apenas apos fechamento"
   zpm_erro[68]:= "Retorno desconhecido 68"
   zpm_erro[69]:= "Memoria fiscal cheia"
   zpm_erro[70]:= "Troca de situacao tributaria apenas apos fechamento"
   zpm_erro[71]:= "Codigo de mercadoria invalida"
   zpm_erro[72]:= "Limite de valor do item ultrapassado"
   zpm_erro[73]:= "Cabecalho ja impresso"
   zpm_erro[74]:= "Acerto de horario de verao somente apos fechamento"
   zpm_erro[75]:= "Acerto de horario de verao permitido somente 1 vez ao dia"
   zpm_erro[76]:= "Relogio inconsistente"
   zpm_erro[77]:= "Data nao pode ser menor que a data da ultima reducao gravada na MF"
   zpm_erro[78]:= "Registrador indisponivel"
   zpm_erro[79]:= "Retorno desconhecido 79"
   zpm_erro[80]:= "Registrador invalido"
   zpm_erro[81]:= "Nro. maximo de troca de simbolo da moeda alcancado"
   zpm_erro[82]:= "Falta papel para autenticacao"
   zpm_erro[83]:= "Nao ha item a descontar"
   zpm_erro[84]:= "Transacao inexistente"
   zpm_erro[85]:= "Transacao ja cancelada"
   zpm_erro[86]:= "Memoria fiscal nao apagada"
   zpm_erro[87]:= "Faltou papel/impressora nao pronta para imprimir"
   zpm_erro[88]:= "Acrescimo no subtotal invalido"
   zpm_erro[89]:= "Desconto no subtotal invalido"
   zpm_erro[90]:= "Valor do relogio invalido"
   zpm_erro[91]:= "Montante da operacao igual a 0 (zero)"
   zpm_erro[92]:= "Reducao nao permitida em intervencao tecnica"
   zpm_erro[93]:= "Indice de forma de pagamento invalido"
   zpm_erro[94]:= "Forma de pagamento indisponivel"
   zpm_erro[95]:= "Troca de forma de pagamento apenas apos fechamento"
   zpm_erro[96]:= "Limite de autenticacao alcancado"
   zpm_erro[97]:= "Finalizadora nao habilitada"
   zpm_erro[98]:= "Valor unitario invalido"
   zpm_erro[99]:= "Quantidade invalida"
   zpm_erro[100]:= "Taxa invalida"
   zpm_erro[101]:= "Formas de pagamento nao cadastradas"
   zpm_erro[102]:= "Indice nao vinculado invalido"
   zpm_erro[103]:= "Documento indisponivel"
   zpm_erro[104]:= "Troca de documento apenas apos fechamento"
   zpm_erro[105]:= "Vinculado nao encontrado"
   zpm_erro[106]:= "Valor da aliquota invalido"
   zpm_erro[107]:= "Inscricao Estadual ou CGC invalido"
   zpm_erro[108]:= "Operacao invalida"
   zpm_erro[109]:= "Numero de vinculados por cupom excedido"
   zpm_erro[110]:= "Vinculado cheio"
   zpm_erro[111]:= "Acrescimo financeiro nao habilitado"
   zpm_erro[112]:= "Erro desconhecido "
   zpm_erro[113]:= "Impressora retornou caracter desconhecido "
   for i:= 114 to 116
      zpm_erro[i]:= "Resposta nao documentada " + Str(i, 2)
   next
   zpm_erro[117]:= "Intervencao Tecnica"
   zpm_erro[118]:= "Em periodo de venda"
   zpm_erro[119]:= "Em venda de item"
   zpm_erro[120]:= "Em Pagamento"
   zpm_erro[121]:= "Em Comercial"
   zpm_erro[122]:= "Estado desconhecido 122"
   zpm_erro[123]:= "Estado desconhecido 123"
   zpm_erro[124]:= "Dia Fechado"
   zpm_erro[125]:= "Em nao vinculado"
   zpm_erro[126]:= "Em relatorio gerencial"
   zpm_erro[127]:= "Em documento vinculado"
   private device_err[6]
   device_err[1]:= "COMANDO INVALIDO"
   device_err[2]:= "IMPRESSORA FORA DE LINHA"
   device_err[3]:= "OCUPADO"
   device_err[4]:= "COMANDO NAO IMPLEMENTADO"
   device_err[5]:= "ERRO DE SINTAXE EM COMANDO P/ O DD"
   device_err[6]:= "ERRO DESCONHECIDO "
   public resp_ok
   resp_ok:= 33
   clear screen
   clear gets
   retorno:= initcomm()
   if (retorno != 0)
      ? "Erro ao acessar a biblioteca: [" + zpm_erro[retorno] + "]"
      quit
   endif
   if (looptest() == 1)
      clear screen
      clear gets
      ? "Cabo serial possui 'loop' CTS<->RTS. Verifique especificacao correta no manual."
      endcomm()
      quit
   endif

   ? "Esta funcionando."

   esc:= 27






















********************************
procedure DEMO1EF

   parameters parametro
   if (PCount() == 0)
      parametro:= ""
   endif
   set scoreboard off
   set date british
   set wrap on
   set confirm on
   private zpm_erro[127]
   zpm_erro[1]:= "Comando Invalido para o Device. Erro Interno!"
   zpm_erro[2]:= ;
      "Impressora esta fora de linha, desligada ou desconectada"
   zpm_erro[3]:= "Device Driver ocupado. Erro Interno!"
   zpm_erro[4]:= "Comando nao implementado. Erro Interno!"
   zpm_erro[5]:= "Erro de Sintaxe em comando. Erro Interno!"
   zpm_erro[6]:= "Tempo para execucao do comando esgotado. Timeout"
   zpm_erro[7]:= "Parametro invalido passado para a LIB"
   zpm_erro[8]:= "LIB ja esta ativa"
   zpm_erro[9]:= "LIB nao esta ativa"
   zpm_erro[10]:= "Device Driver nao instalado"
   for i:= 11 to 32
      zpm_erro[i]:= "Resposta nao documentada " + Str(i, 2)
   next
   zpm_erro[33]:= "Retorno Ok!"
   zpm_erro[34]:= "Cancelamento invalido"
   zpm_erro[35]:= "Abertura do dia invalida"
   zpm_erro[36]:= "Aliquota nao carregada"
   zpm_erro[37]:= "Erro na gravacao da memoria fiscal"
   zpm_erro[38]:= ;
      "Numero Maximo de Troca de Estabelecimento alcancado"
   zpm_erro[39]:= "Erro no Byte Verificador da Memoria Fiscal"
   zpm_erro[40]:= "Impressora em intervencao tecnica"
   zpm_erro[41]:= "Memoria Fiscal desconectada"
   zpm_erro[42]:= "Indice da Aliquota invalido"
   zpm_erro[43]:= "Nao houve desconto anterior"
   zpm_erro[44]:= "Desconto invalido"
   zpm_erro[45]:= "Nao houve acrescimo no subtotal"
   zpm_erro[46]:= "Retorno desconhecido 46"
   zpm_erro[47]:= "Perda da memoria RAM"
   zpm_erro[48]:= "Comando aceito apenas em intervencao tecnica"
   zpm_erro[49]:= "Memoria Fiscal ja inicializada"
   zpm_erro[50]:= "Fechamento nao realizado"
   zpm_erro[51]:= "Fechamento ja realizado"
   zpm_erro[52]:= "Comando fora de sequencia"
   zpm_erro[53]:= "Nao comecou a venda"
   zpm_erro[54]:= "Nao houve pagamento"
   zpm_erro[55]:= "Cupom ja totalizado"
   zpm_erro[56]:= "Comando inexistente"
   zpm_erro[57]:= "Impressora retornou timeout RX"
   zpm_erro[58]:= "Retorno desconhecido 58"
   zpm_erro[59]:= "Nao houve desconto no subtotal"
   zpm_erro[60]:= "Retorno desconhecido 60"
   zpm_erro[61]:= "Valor de desconto invalido"
   zpm_erro[62]:= "Retorno desconhecido 62"
   zpm_erro[63]:= "Cancelamento de cupom invalido"
   zpm_erro[64]:= "Retorno desconhecido 64"
   zpm_erro[65]:= "Retorno desconhecido 65"
   zpm_erro[66]:= "Aliquota indisponivel"
   zpm_erro[67]:= "Troca de proprietario apenas apos fechamento"
   zpm_erro[68]:= "Retorno desconhecido 68"
   zpm_erro[69]:= "Memoria fiscal cheia"
   zpm_erro[70]:= ;
      "Troca de situacao tributaria apenas apos fechamento"
   zpm_erro[71]:= "Codigo de mercadoria invalida"
   zpm_erro[72]:= "Limite de valor do item ultrapassado"
   zpm_erro[73]:= "Cabecalho ja impresso"
   zpm_erro[74]:= "Acerto de horario de verao somente apos fechamento"
   zpm_erro[75]:= ;
      "Acerto de horario de verao permitido somente 1 vez ao dia"
   zpm_erro[76]:= "Relogio inconsistente"
   zpm_erro[77]:= ;
      "Data nao pode ser menor que a data da ultima reducao gravada na MF"
   zpm_erro[78]:= "Registrador indisponivel"
   zpm_erro[79]:= "Retorno desconhecido 79"
   zpm_erro[80]:= "Registrador invalido"
   zpm_erro[81]:= "Nro. maximo de troca de simbolo da moeda alcancado"
   zpm_erro[82]:= "Falta papel para autenticacao"
   zpm_erro[83]:= "Nao ha item a descontar"
   zpm_erro[84]:= "Transacao inexistente"
   zpm_erro[85]:= "Transacao ja cancelada"
   zpm_erro[86]:= "Memoria fiscal nao apagada"
   zpm_erro[87]:= "Faltou papel/impressora nao pronta para imprimir"
   zpm_erro[88]:= "Acrescimo no subtotal invalido"
   zpm_erro[89]:= "Desconto no subtotal invalido"
   zpm_erro[90]:= "Valor do relogio invalido"
   zpm_erro[91]:= "Montante da operacao igual a 0 (zero)"
   zpm_erro[92]:= "Reducao nao permitida em intervencao tecnica"
   zpm_erro[93]:= "Indice de forma de pagamento invalido"
   zpm_erro[94]:= "Forma de pagamento indisponivel"
   zpm_erro[95]:= "Troca de forma de pagamento apenas apos fechamento"
   zpm_erro[96]:= "Limite de autenticacao alcancado"
   zpm_erro[97]:= "Finalizadora nao habilitada"
   zpm_erro[98]:= "Valor unitario invalido"
   zpm_erro[99]:= "Quantidade invalida"
   zpm_erro[100]:= "Taxa invalida"
   zpm_erro[101]:= "Formas de pagamento nao cadastradas"
   zpm_erro[102]:= "Indice nao vinculado invalido"
   zpm_erro[103]:= "Documento indisponivel"
   zpm_erro[104]:= "Troca de documento apenas apos fechamento"
   zpm_erro[105]:= "Vinculado nao encontrado"
   zpm_erro[106]:= "Valor da aliquota invalido"
   zpm_erro[107]:= "Inscricao Estadual ou CGC invalido"
   zpm_erro[108]:= "Operacao invalida"
   zpm_erro[109]:= "Numero de vinculados por cupom excedido"
   zpm_erro[110]:= "Vinculado cheio"
   zpm_erro[111]:= "Acrescimo financeiro nao habilitado"
   zpm_erro[112]:= "Erro desconhecido "
   zpm_erro[113]:= "Impressora retornou caracter desconhecido "
   for i:= 114 to 116
      zpm_erro[i]:= "Resposta nao documentada " + Str(i, 2)
   next
   zpm_erro[117]:= "Intervencao Tecnica"
   zpm_erro[118]:= "Em periodo de venda"
   zpm_erro[119]:= "Em venda de item"
   zpm_erro[120]:= "Em Pagamento"
   zpm_erro[121]:= "Em Comercial"
   zpm_erro[122]:= "Estado desconhecido 122"
   zpm_erro[123]:= "Estado desconhecido 123"
   zpm_erro[124]:= "Dia Fechado"
   zpm_erro[125]:= "Em nao vinculado"
   zpm_erro[126]:= "Em relatorio gerencial"
   zpm_erro[127]:= "Em documento vinculado"
   private device_err[6]
   device_err[1]:= "COMANDO INVALIDO"
   device_err[2]:= "IMPRESSORA FORA DE LINHA"
   device_err[3]:= "OCUPADO"
   device_err[4]:= "COMANDO NAO IMPLEMENTADO"
   device_err[5]:= "ERRO DE SINTAXE EM COMANDO P/ O DD"
   device_err[6]:= "ERRO DESCONHECIDO "
   public resp_ok
   resp_ok:= 33
   clear screen
   clear gets
   retorno:= initcomm()
   if (retorno != 0)
      erromsg("Erro ao acessar a biblioteca: [" + zpm_erro[retorno] ;
         + "]")
      quit
   endif
   if (looptest() == 1)
      clear screen
      clear gets
      erromsg("Cabo serial possui 'loop' CTS<->RTS. Verifique especificacao correta no manual.")
      endcomm()
      quit
   endif
   esc:= 27



   pg_up:= 18
   pg_dn:= 3
   public codigo, descricao, valor, quant, taxa, unidade, formato
   public aliquota
   public operador
   public registrado
   public desc_canc
   public acres_canc
   public textonf
   public linhas
   public linha
   public transacao
   public tipo
   public dinic, dfim
   public redinic, redfim
   public textoprop
   public sensor
   public tipochar, linha1
   public linha2, linha3, loja
   public sequencia, cgc, inscest
   public datarel, horarel, tiporel
   public consiste
   public nome, cpfcgc
   public endereco, entrega
   public simbolo
   public dadoscab
   public acc, forma, coo, seqpag
   public flag
   public forma2
   set color to W+/B
   do while (.T.)
      clear typeahead
      clear screen
      clear gets
      @  0,  0 to 22, 79 double
      set color to N+/W+
      @  0, 24 say " *--- Comandos P/ ZPM/1EF  ---* "
      @ 21, 60 say " Versao 1.00 "
      set color to W+/B
      @ 21, 32 say "<ESC> Sai"
      @  1,  3 to 20, 75
      @  2,  5 prompt "0 - Imprime Cabecalho        "
      @  3,  5 prompt "1 - Venda de Item            "
      @  4,  5 prompt "2 - Cancela Item             "
      @  5,  5 prompt "3 - Desconto de Item         "
      @  6,  5 prompt "4 - Pagamento                "
      @  7,  5 prompt "5 - Finaliza Venda           "
      @  8,  5 prompt "6 - Imprime Linhas Livres    "
      @  9,  5 prompt "7 - Cancela Venda            "
      @ 10,  5 prompt "8 - Cancela Cupom            "
      @ 11,  5 prompt "9 - Acrescimo                "
      @ 12,  5 prompt "A - Desconto Subtotal        "
      @ 13,  5 prompt "B - Relatorio X/Z            "
      @ 14,  5 prompt "C - Finaliza Relat gerencial "
      @ 15,  5 prompt "D - Carr Tab Aliquotas       "
      @ 16,  5 prompt "E - Carr Dados Cabecalho     "
      @ 17,  5 prompt "F - Le Memoria Fiscal        "
      @ 18,  5 prompt "G - Propaganda               "
      @  2, 45 prompt "H - Programa Relogio         "
      @  3, 45 prompt "I - Abre Gaveta              "
      @  4, 45 prompt "J - Avanca Linha             "
      @  5, 45 prompt "K - Carrega Doc Nao Vinculado"
      @  6, 45 prompt "L - Imprime Doc Nao Vinculado"
      @  7, 45 prompt "M - Estado Impressora        "
      @  8, 45 prompt "N - Le Registrador           "
      @  9, 45 prompt "O - Autentica Documento      "
      @ 10, 45 prompt "P - Le Sensor                "
      @ 11, 45 prompt "Q - Identificacao Comprador  "
      @ 12, 45 prompt "R - Cupom Adicional          "
      @ 13, 45 prompt "S - Simbolo da Moeda Corrente"
      @ 14, 45 prompt "T - Habilita Doc Vinculado   "
      @ 15, 45 prompt "U - Emite Doc Vinculado      "
      @ 16, 45 prompt "V - Cadastra Formas Pagamento"
      @ 17, 45 prompt "X - Transferencia Financeira "
      @ 18, 45 prompt "Y - Habilita Acresc Financ.  "
      menu to opcao
      if (LastKey() == pg_dn .OR. LastKey() == pg_up)
         loop
      endif
      if (LastKey() == esc)
         exit
      endif
      @  1,  2 clear to 20, 78
      retorno:= -1
      do case
      case opcao == 1
         retorno:= printheade()
      case opcao == 2
         if (qualitemve() == 0)
            retorno:= saleitem(codigo, descricao, quant, valor, ;
               taxa, unidade, formato)
         endif
      case opcao == 3
         if (qualitemca() == 0)
            retorno:= cancelitem(descricao, transacao)
         endif
      case opcao == 4
         if (qualitemde() == 0)
            retorno:= discountit(desc_canc, descricao, valor)
         endif
      case opcao == 5
         if (pagamento() == 0)
            retorno:= payment(forma, descricao, valor, acc)
         endif
      case opcao == 6
         if (lefimvenda() == 0)
            retorno:= endsale("0", operador)
         endif
      case opcao == 7
         if (lelinhasli() == 0)
            retorno:= freelines(textonf)
         endif
      case opcao == 8
         if (leoperador() == 0)
            retorno:= cancelsale(operador)
         endif
      case opcao == 9
         if (letipocanc() == 0)
            retorno:= cancelvouc(operador, tipo)
         endif
      case opcao == 10
         if (leacrescim() == 0)
            retorno:= upliftsubt(acres_canc, descricao, valor)
         endif
      case opcao == 11
         if (ledesconto() == 0)
            retorno:= discountsu(desc_canc, descricao, valor)
         endif
      case opcao == 12
         if (letipo() == 0)
            retorno:= reportxz(tipo)
         endif
      case opcao == 13
         if (leoperador() == 0)
            retorno:= endreport(operador)
         endif
      case opcao == 14
         if (lealiquota() == 0)
            retorno:= loadtablet(aliquota, valor)
         endif
      case opcao == 15
         if (lecabecalh() == 0)
            retorno:= loadheader(tipochar, linha1, linha2, linha3, ;
               loja, sequencia, cgc, inscest, dadoscab)
         endif
      case opcao == 16
         if (lememfisca() == 0)
            retorno:= readfiscal(tipo, dinic, dfim, redinic, redfim)
         endif
      case opcao == 17
         if (lemensagem() == 0)
            retorno:= comercialt(tipo, textoprop)
         endif
      case opcao == 18
         if (lerelogio() == 0)
            retorno:= programclo(tiporel, datarel, horarel)
         endif
      case opcao == 19
         retorno:= opencash()
      case opcao == 20
         if (quantaslin() == 0)
            retorno:= advancelin("0", linhas)
         endif
      case opcao == 21
         if (carganvinc() == 0)
            retorno:= loadunlink(codigo, descricao)
         endif
      case opcao == 22
         if (imprimenvi() == 0)
            retorno:= printunlin(forma, descricao, valor)
         endif
      case opcao == 23
         retorno:= statusprin()
      case opcao == 24
         if (leregistra() == 0)
            valor:= Space(30)
            retorno:= readregist(registrado, @valor)
         else
            loop
         endif
      case opcao == 25
         retorno:= autentic()
      case opcao == 26
         lesensor()
         loop
      case opcao == 27
         if (buyerid() == 0)
            retorno:= buyerident(nome, tipo, cpfcgc, endereco, ;
               entrega)
         endif
      case opcao == 28
         if (leoperador() == 0)
            retorno:= stubvouche(operador)
         endif
      case opcao == 29
         if (lesimbolom() == 0)
            retorno:= moneysymbo(simbolo)
         endif
      case opcao == 30
         if (lehabilita() == 0)
            retorno:= enablenseq(flag)
         endif
      case opcao == 31
         if (levinculad() == 0)
            retorno:= linkvouche(coo, seqpag)
         endif
      case opcao == 32
         if (leformapag() == 0)
            retorno:= loadpaymen(forma, descricao)
         endif
      case opcao == 33
         if (transferef() == 0)
            retorno:= transferpa(valor, forma, forma2)
         endif
      case opcao == 34
         if (acrescfina() == 0)
            retorno:= upliftconf(flag)
         endif
      otherwise
         @ 10,  5 say "Comando nao implementado!"
         InKey(10)
      endcase
      if (retorno == -1)
         loop
      endif
      do case
      case opcao == 23
         if (retorno > 0)
            if (retorno < 11)
               erromsg("ERRO: [" + zpm_erro[retorno] + "]")
            else
               if (retorno > 127)
                  @ 19,  5 say "ERRO: " + zpm_erro[112] + "[" + ;
                     alltrim(Str(retorno)) + "]"
               else
                  @ 19,  5 say zpm_erro[retorno]
               endif
               InKey(20)
            endif
         else
            @ 19,  5 say "ERRO: " + zpm_erro[112] + "[" + ;
               alltrim(Str(retorno)) + "]"
            InKey(20)
         endif
      case opcao == 24
         if (retorno == resp_ok)
            @ 19,  5 say "Registrador (" + alltrim(registrado) + ;
               "): [" + valor + "]"
         else
            tone(900, 3)
            if (retorno < 0 .OR. retorno > 111)
               @ 19,  5 say "ERRO: " + zpm_erro[112] + "[" + ;
                  alltrim(Str(retorno)) + "]"
            else
               @ 19,  5 say "ERRO: " + zpm_erro[retorno]
            endif
         endif
         InKey(20)
      case opcao == 26
         if (retorno == 35)
            @ 19,  5 say "Sensor DESLIGADO!"
            InKey(20)
         elseif (retorno == 36)
            @ 19,  5 say "Sensor LIGADO!"
            InKey(20)
         elseif (retorno != resp_ok)
            tone(900, 3)
            if (retorno < 0 .OR. retorno > 111)
               @ 19,  5 say "ERRO: " + zpm_erro[112] + "[" + ;
                  alltrim(Str(retorno)) + "]"
            else
               @ 19,  5 say "ERRO: " + zpm_erro[retorno]
            endif
            InKey(20)
         endif
      case retorno > 111
         erromsg("ERRO: [" + zpm_erro[112] + "] [" + ;
            alltrim(Str(retorno)) + "]")
      case retorno == resp_ok
         @ 19,  5 say "Retorno OK!"
         InKey(20)
      case retorno == 0
         @ 19,  5 say "Retorno desconhecido 0"
      otherwise
         erromsg("ERRO: [" + zpm_erro[retorno] + "]")
      endcase
   enddo
   set color to 
   endcomm()
   clear screen
   clear gets
   quit

* EOF
