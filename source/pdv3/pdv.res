Versao:= "SWPDV v2.0-XX"
DiretoriodeDados:= "\DEVELOP\FORTUNA\DADOS"
CodigoFilial:= 3
CodigoCaixa:=  1
FormatodeImpressao:= 1
Usuario:= "EMPRESA DEMONSTRACAO"
ModoDeVideo:=  2
ProtecaoTela:= 100

NaoImprimeCarne:= { 600 }
Impressora:= "Nenhuma"
PortaImpressao:= "COM2"

SSCode:=          Chr( 49 ) + Chr( 50 ) + Chr( 57 ) + Chr( 56 ) + Chr( 49 ) + Chr( 50 )
AvisaSaldoEst     := "NAO"
AvisaValorPago    := "SIM"
CorPadrao         := "CINZA"
CorBoxA           := 9
CorBoxB           := 9

MoedasEspecificas := "NAO"
ForPagDinheiro    := "A"
ForPagTickets     := "A"
ForPagCheque      := "A"
ForPagCartao      := "A"
ForPagAPrazo      := "B"
ForPagOutros      := "A"
ForPagAVista      := "A"

ForPagPagamento   := "A"
ImpPagPagamento   := "A"

** ATENCAO! ===================== IMPRESSORA SWEDA ========================
** Parametro de Fechamento Preencher com "SIM" se for SWEDA e necessitar
** que imprima as informacoes de cliente ao final do cupom senao Coloque
** Fechamento= ""
**-------------------------------------------------------------------------
Fechamento:= "SIM"

MensPagamento:= "Recebido n/ data o valor referido neste cupom"
                     
**--------------------------------------------------------------------------**
** Parametros SIGTRON =  ForPagAPrazo= "B"
**                       ForPagAVista= "A"
** ..........................................................................
** Passos para configuracao na Impressora fiscal SIGTRON-FS345
** Logo apos uma Reducao Z voce deve seguir os seguintes passos:
** PROGRAMA: APLITEC.EXE / APLIUSU.EXE
**
** CONFIGURACAO DE FORMAS DE PAGAMENTO / CREDIARIO
**           Conf.&Leitura - Criacao de Comprovante Nao Fiscal Vinculado
**              V      <ENTER>
**              CARNE  <ENTER>                      ///RETORNO = CNFVA 
**
**           Conf.&Leitura - Personalizacao de Mensagens - Formas de Pagamento
**              PGVAA VISTA
**              PGVBCREDIARIO
**              PGVCCHEQUE
**              PGVDCARTAO DE CREDITO               ///RETORNO = [CR]
**
** CONFIGURACAO PARA AUTENTICACAO
**           Conf.&Leitura - 3-Criacao de Comprovante Nao Fiscal Vinculado
**              +        <ENTER>
**              QUITACAO <ENTER>                    ///RETORNO = CNF+A
**--------------------------------------------------------------------------**
** Parametros BEMATECH = ForPagAPrazo= "05"
**                       ForPagAVista= "01"
** A configuracao da BEMATECH ‚ automatica, baseada na tabela [ForPagXXXXXXXX]
**--------------------------------------------------------------------------**
** Parametro SCHALTER
** Utilizar o programa DEMO_ECF.EXE
** PROGRAMACAO DE DADOS---->FORMAS DE PAGAMENTO
**   00 - A VISTA
**   01 - CREDIARIO
**   02 - CHEQUE
**   03 - CARTAO DE CREDITO
** DOCUMENTOS NAO FISCAIS (INDIVIDUAL)                   ®("")¯
**   QUITACAO        00 N N N S S 
**--------------------------------------------------------------------------**

cAbreGaveta:= "128"+Chr(27)

Cliche1:= " SOFT&WARE Informatica                   "
Cliche2:= " Av. Alberto Bins, 278 - Parque Brasilia "
Cliche3:= " Cachoeirinha-RS                         "
Cliche4:= "                   " + DTOC( DATE() )
cObserv1:= Space( 40 )
cObserv2:= PAD( "", 40 )
cObserv3:= Space( 40 )
Cidade:= "                    "
Propaganda:= " "
CorPropaganda:= "15/01"
CarneInterno:= .F.
TabelaDePreco:= 0
Icm:= 17
STPadrao:= "TA"
STIsento:= "I  "
STSubstituicao:= "F "
STServico:= "TD"
GrupoServico:= "999"

** FS300
** Ordenador do Cadastro de Produtos / Principal Campo de busca
** 1 Indice   MPRIND01.IGD
** 2 Descri   MPRIND02.IGD
** 3 CodRed   MPRIND03.IGD
** 4 CodFab   MPRIND04.IGD
** 5 CodFor   MPRIND05.IGD

OrdemProduto:= 5
Protegido:= .F.
$FIM

