 *********************************************************************************
** Arquivo ..........: Sig2_cmd.prg : Programa teste p/ driver Sig2000
** Funcao............: Comandos para impressora fiscal : Sigtron FS345
** Complemento.......: Utiliza o programa PSig2000 (Escrito em Delphi)
** Nota..............: O driver sig2000 serve para qualquer tipo de comunicacao
** Serial , desde que a sincronia entre ele e a aplicacao seja respeitada !
** Empresa...........: Logicbox
** Programador.......: Marcio Scherer
** Ultima atualizacao: 08/11/2000
*******************************************************************************
//------------------------------------------------------------------------------------------------------------------------------
#include "Fileio.ch"
// AQUI COMECA SUA PROGRAMACAO
 Set message to 24 center
 Set wrap on
 Do while .t.
 ERRO := 0 // Sem erro
 // MONTA A TELA
 set color to w/b
 Clear screen
 set color to W+/u
 @ 04,29 say "COMANDOS PRINCIPAIS"
 set color to b+/W
 @ 05,29 clear to 19,47
 @ 05,29 to 19,47 double
 set color to w+/w
 @ 00,00 say "PROGRAMA TESTE DRIVER SIG2000 - LOGICBOX AUTOMACAO          POR MARCIO SCHERER   "
 @ 01,00 SAY REPLICATE("Û",80)
 @ 23,00 SAY REPLICATE("Û",80)
 @ 24,00 say "                                                                                 "
 SET COLOR TO W+/G
 @ 22,33 say " LIBERADO "
 set color to w+/W,W+/R
  @ 06,30 prompt "ABRE CUPOM FISCAL" Messa "ABRE O CUPOM FISCAL."
  @ 08,30 prompt "  ENVIO DE ITEM  " Messa "ENVIA ITEM FORMATO 225."
  @ 10,30 prompt "     TOTALIZA    " Messa "TOTALIZA O CUPOM FISCAL."
  @ 12,30 prompt "    PAGAMENTO    " Messa "DEFINE A FORMA DE PAGAMENTO."
  @ 14,30 prompt "   FECHA CUPOM   " Messa "FECHA O CUPOM FISCAL"
  @ 16,30 prompt "   VENDA GERAL   " Messa "ABRE CUPOM,ENVIA 3 ITENS,TOTALIZA,DEFINE FORMA DE PAGAMENTO , FECHA O CUPOM."
  @ 18,30 prompt "      SAIR       " Messa "SAI DO PROGRAMA DE TESTE SIG2"

  Menu to op
  do case
   CASE LASTKEY()=27 // ESC
   set color to w
   cls
   quit
   case op=1 // ABRE CUPOM FISCAL
    Abrecupom()
    CriaReady()
    Trataresp()
   case op=2 // ENVIA ITEM


    /// enviaItem("TA","0000000000123","000000010","01,000","Un","Descricao (Produto de texto PSig2000)")


    /// SIGTRON FS300
    enviaItem("TA","0000000000123","000000010","01,000","Un","Descricao (Produto de texto PSig2000)")




    CriaReady()
    Trataresp()
   case op=3 // TOTALIZA CUPOM
    Totaliza()
    CriaReady()
    Trataresp()
   case op=4 // DEFINE FORMA DE PAGAMENTO
    FormaPagamento("A","000000001000")
    CriaReady()
    Trataresp()
   case op=5 // FECHA CUPOM
    FechaCupom("Linhas de mensagem","ate 8 linhas de mensagens","encerradas por FF","","","","","")
    CriaReady()
    Trataresp()
   case op=6 // OBSERVE O TRATAMENTO DE ERROS
    Abrecupom()
    CriaReady()
    Trataresp()
    If ERRO<> 1 // NAO DEU ERRO
     enviaItem("TA","0000000000123","000000010","01,000","Un","Descricao (Produto de texto PSig2000)")
     CriaReady()
     Trataresp()
    ENDIF
    If ERRO <> 1 // NAO DEU ERRO
     enviaItem("TA","0000000000123","000000010","01,000","Un","Descricao (Produto de texto PSig2000)")
     CriaReady()
     Trataresp()
    Endif
    If ERRO<> 1 // NAO DEU ERRO
     enviaItem("TA","0000000000123","000000010","01,000","Un","Descricao (Produto de texto PSig2000)")
     CriaReady()
     Trataresp()
    Endif
    If ERRO<> 1 // NAO DEU ERRO
     Totaliza()
     CriaReady()
     Trataresp()
    Endif
    If ERRO<> 1 // NAO DEU ERRO
     FormaPagamento("A","000000001000")
     CriaReady()
     Trataresp()
    Endif
    If ERRO<> 1 // NAO DEU ERRO
     FechaCupom("Linhas de mensagem","ate 8 linhas de mensagens","encerradas por FF","","","","","")
     CriaReady()
     Trataresp()
    Endif
    case op=7
    set color to w
    cls
    quit
  Endcase
Enddo .t.
//----------------------------------------------------------------------------------------------------------------------------
//             PRINCIPAIS FUNCOES DA IMPRESSORA EM ORDEM BASICA
//---------------------------------------------------------------------------------
Function  ReducaoZ()
// REDUCAO Z (FINAL DO DIA)
 Arq = fopen("Param.txt",2)
 fwrite(Arq,chr(27)+chr(208)+Data()+Hora(),14)
 fclose(Arq)
//---------------------------------------------------------------------------------
Function LeituraX()
// LEITURA X (INICIO DO DIA)
 Arq = fopen("Param.txt",2)
 fwrite(Arq,chr(27)+chr(207),2)
 fclose(Arq)
//---------------------------------------------------------------------------------
Function AbreCupom()
// ABERTURA DE CUPOM FISCAL
 CriaParam()
 arq = fopen("Param.txt",2)
 fwrite(arq,chr(27)+chr(200),2)
 fclose(arq)
 close all
//---------------------------------------------------------------------------------
Function EnviaItem(ss,cc,pp,qq,un,dd)
// ENVIO DE ITEM 6 CASAS PARA QUANTIDADE E 3 DECIMAIS PARA PRECO (225)
 CriaParam()
 ** ss = situacao tributaria TA,TB,TC,TD....
 ** cc = codigo do produto
 ** pp = pre‡o do produto
 ** qq = quantidade
 ** un = unidade cx kg...
 ** dd = descri‡Æo do produto

 Do while Len(pp)<9; pp:="0"+pp; Enddo
 Do while Len(qq)<6; qq:="0"+qq; Enddo
 Do while Len(cc)<13; cc:="0"+cc; Enddo

 Vp1:=ss+cc+'00000000'+pp+qq+un+dd
 Arq=Fopen("Param.txt",2)
 Var="F 00000000000120000000000000010001,000UNdescricao"

 /* comando FORTUNA */
 cIcm:= "F "
 Var:=   cIcm + PAD( "0", 13 ) + "0000" + "0000"+ "000000100" +;
                         "00001" + "un" + PAD( "PRODUTO TESTE", 30 )

 Fwrite(Arq,Chr(27)+chr(215)+Var+Chr(255),Len(Var)+3)
 Fclose(Arq)

//---------------------------------------------------------------------------------





Function Totaliza()
// TOTALIZACAO DE CUPOM FISCAL
 CriaParam()
 Arq = fopen("Param.txt",2)
 fwrite(Arq,chr(27)+chr(241)+"0000000000000"+chr(255),16)
 fclose(Arq)
//---------------------------------------------------------------------------------
Function FormaPagamento(Fpag,Vpag)
// DESCRICAO DAS FORMAS DE PAGAMENTO
 CriaParam()
 Do while Len(Vpag)<12;  Vpag:="0"+Vpag; Enddo
 Arq = fopen("Param.txt",2)
 fwrite(Arq,chr(27)+chr(242)+Fpag+Vpag+chr(255),16)
 fclose(Arq)
//---------------------------------------------------------------------------------
Function FechaCupom(Linha1,Linha2,Linha3,Linha4,Linha5,Linha6,Linha7,Linha8)
// FECHAMENTO DE CUPOM
CriaParam()
** inicializando variaveis locais p/ mensagens
 if Len(Linha1) <> 0
  Linha1:=Substr(Linha1,1,48)+Chr(10)
 Else
  Linha1:=""
 Endif

 if Len(Linha2) <> 0
  Linha2:=Substr(Linha2,1,48)+Chr(10)
 Else
  Linha2:=""
 Endif

 if Len(Linha3) <> 0
  Linha3:=Substr(Linha3,1,48)+Chr(10)
 Else
  Linha3:=""
 Endif

 if Len(Linha4) <> 0
  Linha4:=Substr(Linha4,1,48)+Chr(10)
 Else
  Linha4:=""
 Endif

 if Len(Linha5) <> 0
  Linha5:=Substr(Linha5,1,48)+Chr(10)
 Else
  Linha5:=""
 Endif

 if Len(Linha6) <> 0
  Linha6:=Substr(Linha6,1,48)+Chr(10)
 Else
  Linha6:=""
 Endif

 if Len(Linha7) <> 0
  Linha7:=Substr(Linha7,1,48)+Chr(10)
 Else
  Linha7:=""
 Endif

 if Len(Linha8) <> 0
  Linha8:=Substr(Linha8,1,48)+Chr(10)
 Else
  Linha8:=""
 Endif

 Arq = fopen("Param.txt",2)
 fwrite(Arq,chr(27)+chr(243)+linha1+linha2+linha3+linha4+linha5+linha6+linha7+linha8+chr(255),Len(Linha1)+Len(Linha2)+Len(Linha3)+Len(Linha4)+Len(Linha5)+Len(Linha6)+Len(Linha7)+Len(Linha8)+3)
 fclose(arq)
//---------------------------------------------------------------------------------
//                             FUNCOES AUXILIARES
//---------------------------------------------------------------------------------
Function Hora()
Hora2:=TIME()
Hora:=SUBSTR(HORA2,1,2)+SUBSTR(HORA2,4,2)+SUBSTR(HORA2,7,2)
//---------------------------------------------------------------------------------
Function Data()
Data2:=DTOC(DATE())
Data:=SUBSTR(Data2,1,2)+SUBSTR(Data2,4,2)+SUBSTR(Data2,7,2)
//---------------------------------------------------------------------------------
//          FUNCOES REFERENTES AO CONTROLE DO DRIVER SIG2
//---------------------------------------------------------------------------------
Function CriaParam()
 // No momento da criacao do parametro do comando e nescessario apagar
 // o arquivo de resposta da operacao anterior
 Start:=SECONDS()
  While file("OK.ctl")
   End:=SECONDS()             // TIME-OUT de 3 segundos
    If (End)>(Start+5.0)
     Exit
    Endif
   erase OK.ctl
  enddo
  // E importante a construcao do laco para garantir que este arquivo
  // realmente sera apagado, um time-out para nao trancar o sistem tambem

Arq=FCreate("Param.txt",FC_NORMAL) // Criando o arquivo de parametros
Fclose(Arq)                        // do proximo comando
//---------------------------------------------------------------------------------
Function CriaReady()
// No momento que este arquivo eh criado, O driver entende que o arquivo
// de parametros esta pronto e pode ser enviado para a impressora
Arq=FCreate("Ready.ctl",FC_NORMAL)
Fclose(Arq)
//---------------------------------------------------------------------------------
Function Trataresp() // Controle de resposta , deve ser feito pela aplicacao

 ////////////////////////////////////////////////////////////////////////////////
 // IMPORTANTE : Esta funcao eh indispensavel para uma boa comunicacao
 // os passos abaixo devem ser seguidos rigorosamente, independendo
 // da linguagem utilizada !!!
 ////////////////////////////////////////////////////////////////////////////////

 SET COLOR TO W+*/R
 @ 22,33 say "AGUARDE..."
 Start:=SECONDS()
 Do While !file("Ok.ctl") // agarde enquanto o driver nao enviar o OK..
    End:=SECONDS()
    If (End)>(Start+5.0)    // TIME-OUT de 5 segundos
       SET COLOR TO W+/R
       @ 22,00 say "              ERRO DE TIME-OUT(O RETORNO EXCEDEU 5 SEGUNDOS)                       "
       INKEY(2)
       ERRO :=1
       Return
    Endif
 Enddo
 // enviou ... A resposta ja esta no arquivo de retorno,e a operacao liberada
 Ret:=Space(2)
 ArqRet:=Fopen("Retorno.txt")
 Fread(arqRet,@ret,2)
 if ret=":E" // O comando foi enviado , mas a impressora retornou um erro !
    ERRO := 1 // DEU ERRO
    SET COLOR TO W+/R
    @ 22,00 say "           ERRO NO COMANDO ENVIADO... A OPERACAO SERA ABORTADA !                   "
    INKEY(2)
 ELSE
    @ 01,01 SAY RET
    INKEY(0)
 endif
 fclose(arqRET)

//---------------------------------------------------------------------------------
//                              FINAL DE ARQUIVO
//---------------------------------------------------------------------------------
