

// ## CL2HB.EXE - Converted
*************************************** VPBIBCEI ****************************************
*                 Biblioteca de funcoes para o Sistema VPCEI Versao 1.0                  *
********************************* Valmor Pereira Flores **********************************
#include "VPF.CH"
#include "INKEY.CH"
#include "formatos.ch"
#include "box.ch"



/*
*      Funcao - CREATEVPB
*  Finalidade - Criacao de arquivos de banco de dados.
*  Parametros - Numero de classIficacao do banco de dados.
* Programador - Valmor Pereira Flores
*        Data - 01/Fevereiro/1994
* Atualizacao -
*/
func createvpb(nDBF)
loca aStrut
do case
   case nDBF==_COD_MOEDAS
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",30,00},;
                 {"SIGLA_","C",10,00},;
                 {"INDICE","N",16,04},;
                 {"PADRAO","C",01,00}}
        dbCreate( _VPB_MOEDAS, aStrut )
   case nDBF==_COD_VARIACOES
        aStrut:={{"CODIGO","N",03,00},;
                 {"INDICE","N",16,04},;
                 {"DATA__","D",08,00}}
        dbCreate( _VPB_VARIACOES, aStrut )
   case nDBF==_COD_DETALHE
        aStrut:={{"CODPED","C",08,00},;
                 {"ORDEM_","N",03,00},;
                 {"INDICE","C",12,00},;
                 {"DETAL1","C",65,00},;
                 {"DETAL2","C",65,00},;
                 {"DETAL3","C",65,00}}
        dbCreate( _VPB_DETALHE, aStrut )
   case nDBF==_COD_DETNOTA
        aStrut:={{"CODNF_","N",09,00},;
                 {"ORDEM_","N",03,00},;
                 {"INDICE","C",12,00},;
                 {"DETAL1","C",65,00},;
                 {"DETAL2","C",65,00},;
                 {"DETAL3","C",65,00}}
        dbCreate( _VPB_DETNOTA, aStrut )
   case nDBF==_COD_MIDIA
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",30,00}}
        dbCreate( _VPB_MIDIA, aStrut )
   case nDBF==_COD_ATEND
        Mensagem( "Criando arquivo, aguarde...")
        aStrut:={{"CODIGO","N",08,00},;
                 {"CODCFE","C",10,00},;
                 {"SETOR_","N",03,00},;
                 {"DESCRI","C",45,00},;
                 {"DATAEM","D",08,00},;
                 {"DATFIM","D",08,00},;
                 {"ATEND_","C",30,00},;
                 {"STATUS","N",02,00},;
                 {"COBRAN","N",02,00},;
                 {"HORA__","C",08,00},;
                 {"VALOR_","N",14,02}}
        dbcreate( _VPB_ATEND, aStrut )
   case nDBF==_COD_ATENDAUX
        aStrut:={{"CODIGO","N",08,00},;
                 {"CODCFE","C",10,00},;
                 {"INDICE","C",12,00},;
                 {"INFORM","C",50,00},;
                 {"HISTO1","C",40,00},;
                 {"HISTO2","C",40,00},;
                 {"HISTO3","C",40,00},;
                 {"HISTO4","C",40,00},;
                 {"HISTO5","C",40,00},;
                 {"ATEND_","C",30,00},;
                 {"DATA__","D",08,00},;
                 {"CODREG","N",02,00},;
                 {"STATUS","N",02,00}}
        dbcreate( _VPB_ATENDAUX, aStrut )
   case nDBF==_COD_INFOCLI
        Mensagem( "Criando arquivo, aguarde...")
        aStrut:={{"CODIGO","N",06,00},;
                 {"DESCRI","C",45,00},;
                 {"INFO01","C",60,00},;
                 {"COMP01","C",20,00},;
                 {"SUBC01","C",20,00},;
                 {"INFO02","C",60,00},;
                 {"COMP02","C",20,00},;
                 {"SUBC02","C",20,00},;
                 {"INFO03","C",60,00},;
                 {"COMP03","C",20,00},;
                 {"SUBC03","C",20,00},;
                 {"INFO04","C",60,00},;
                 {"COMP04","C",20,00},;
                 {"SUBC04","C",20,00},;
                 {"INFO05","C",60,00},;
                 {"COMP05","C",20,00},;
                 {"SUBC05","C",20,00},;
                 {"INFO06","C",60,00},;
                 {"COMP06","C",20,00},;
                 {"SUBC06","C",20,00},;
                 {"INFO07","C",60,00},;
                 {"COMP07","C",20,00},;
                 {"SUBC07","C",20,00},;
                 {"INFO08","C",60,00},;
                 {"COMP08","C",20,00},;
                 {"SUBC08","C",20,00},;
                 {"INFO09","C",60,00},;
                 {"COMP09","C",20,00},;
                 {"SUBC09","C",20,00},;
                 {"INFO10","C",60,00},;
                 {"COMP10","C",20,00},;
                 {"SUBC10","C",20,00},;
                 {"INFO11","C",60,00},;
                 {"COMP11","C",20,00},;
                 {"SUBC11","C",20,00},;
                 {"INFO12","C",60,00},;
                 {"COMP12","C",20,00},;
                 {"SUBC12","C",20,00},;
                 {"INFO13","C",60,00},;
                 {"COMP13","C",20,00},;
                 {"SUBC13","C",20,00},;
                 {"INFO14","C",60,00},;
                 {"COMP14","C",20,00},;
                 {"SUBC14","C",20,00},;
                 {"INFO15","C",60,00},;
                 {"COMP15","C",20,00},;
                 {"SUBC15","C",20,00}}
                 dbcreate( _VPB_INFOCLI, aStrut )
   case nDBF==_COD_CREDIARIO
        Mensagem( "Criando arquivo, aguarde...")
        aStrut:={{"CODIGO","N",06,00},;
                 {"DESCRI","C",45,00},;
                 {"ESTCIV","C",01,00},;
                 {"NDEPEN","N",02,00},;
                 {"CI____","C",20,00},;
                 {"ORGAO_","C",10,00},;
                 {"ENDMAE","C",55,00},;
                 {"ENDPAI","C",55,00},;
                 {"EMPTRA","C",55,00},;
                 {"ENDTRA","C",55,00},;
                 {"ADMISS","D",08,00},;
                 {"FONTRA","C",13,00},;
                 {"SALAR_","N",16,02},;
                 {"CARGO_","C",25,00},;
                 {"SECAO_","C",25,00},;
                 {"OUTROS","N",16,02},;
                 {"OROUTR","C",25,00},;
                 {"EMPANT","C",55,00},;
                 {"CONJUG","C",35,00},;
                 {"CONNAS","D",08,00},;
                 {"CONCI_","C",20,00},;
                 {"CONMAE","C",35,00},;
                 {"CONPAI","C",35,00},;
                 {"EMPCON","C",55,00},;
                 {"FEMCON","C",13,00},;
                 {"CONOUT","N",16,02},;
                 {"CONDTA","D",08,00},;
                 {"EEMCON","C",55,00},;
                 {"CONSAL","N",16,02},;
                 {"CONCAR","C",25,00},;
                 {"CONSEC","C",25,00},;
                 {"CONORI","C",25,00},;
                 {"CEMANT","C",35,00},;
                 {"RESID_","N",02,00},;
                 {"RESTEM","N",03,00},;
                 {"RESVLR","N",16,02},;
                 {"RESNOM","C",35,00},;
                 {"RESANT","C",55,00},;
                 {"AVALIS","C",55,00},;
                 {"RCOME1","C",60,00},;
                 {"RCOME2","C",60,00},;
                 {"RCOME3","C",60,00},;
                 {"RCOME4","C",60,00},;
                 {"RPESS1","C",60,00},;
                 {"RPESS2","C",60,00},;
                 {"SPCEST","N",01,00},;
                 {"SPCOB1","C",60,00},;
                 {"SPCOB2","C",60,00},;
                 {"SPCOB3","C",60,00},;
                 {"DATA__","D",08,00}}
                 dbcreate(_VPB_CREDIARIO,aStrut)
   case nDBF==_COD_CLIENTE
        Mensagem( "Criando arquivo para cadastro de clientes, aguarde...")
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODIGO","N",06,00},;
                 {"DESCRI","C",45,00},;
                 {"FANTAS","C",45,00},;
                 {"ENDERE","C",35,00},;
                 {"BAIRRO","C",25,00},;
                 {"CIDADE","C",30,00},;
                 {"ESTADO","C",02,00},;
                 {"CODCEP","C",08,00},;
                 {"FONEN_","N",01,00},;
                 {"FONE1_","C",12,00},;
                 {"FONE2_","C",12,00},;
                 {"FONE3_","C",12,00},;
                 {"FONE4_","C",12,00},;
                 {"TELEX_","C",12,00},;
                 {"FAX___","C",12,00},;
                 {"CGCMF_","C",14,00},;
                 {"CPF___","C",11,00},;
                 {"INSCRI","C",15,00},;
                 {"VENIN1","N",04,00},;
                 {"VENIN2","N",04,00},;
                 {"VENIN3","N",04,00},;
                 {"VENEX1","N",04,00},;
                 {"VENEX2","N",04,00},;
                 {"VENEX3","N",04,00},;
                 {"COBRAN","C",30,00},;
                 {"TRANSP","N",03,00},;
                 {"COMPRA","C",40,00},;
                 {"RESPON","C",40,00},;
                 {"DATACD","D",08,00},;
                 {"CLIENT","C",01,00},;
                 {"CONIND","C",01,00},;
                 {"SELECT","C",03,00},;
                 {"SITUA_","C",01,00},;
                 {"DATA__","D",08,00},;
                 {"PEND__","N",10,00},;
                 {"QUIT__","N",10,00},;
                 {"INAD__","N",10,00},;
                 {"ATRA__","N",10,00},;
                 {"ATRA_D","N",10,00},;
                 {"LIMCR_","N",16,02},;
                 {"SALDO_","N",16,02},;
                 {"VALID_","D",08,00},;
                 {"CODATV","N",04,00},;
                 {"OBSER1","C",40,00},;
                 {"OBSER2","C",40,00},;
                 {"OBSER3","C",40,00},;
                 {"OBSER4","C",40,00},;
                 {"OBSER5","C",40,00},;
                 {"DATINF","D",08,00},;
                 {"ULTCMP","D",08,00},;
                 {"ULTVLR","N",16,02},;
                 {"MAICMP","D",08,00},;
                 {"MAIVLR","N",16,02},;
                 {"E_MAIL","C",55,00},;
                 {"TABPRE","N",04,00},;
                 {"PAI___","C",30,00},;
                 {"MAE___","C",30,00},;
                 {"NASCIM","D",08,00},;
                 {"BANCO_","N",03,00},;
                 {"AGENCI","C",04,00},;
                 {"CONTAC","N",10,00},;
                 {"DIGVER","C",01,00},;
                 {"IDENTI","C",25,00},;
                 {"NOVVEN","N",03,00},;
                 {"FOLEMP","N",06,00},;
                 {"FOLCOD","C",15,00},;
                 {"CODBAR","C",13,00},;
                 {"PERDCD","N",03,00},; //PERIODICIDADE DE VISITAS
                 {"PRXVST","D",08,00},; // PROXIMA VISITA (AGENDA)
                 {"MIDIA_","N",03,00}}
        /* Por compatibilizacao Verifica a n∆o existencia de um arquivo de no CLIENTES.DBF */
        IF !File( StrTran( _VPB_CLIENTE, ".DBF", ".DBF" ) )
           dbcreate( _VPB_CLIENTE, aStrut )
        ENDIF
   case nDBF==_COD_OPERACOES
        Mensagem( "Criando arquivo para cadastro de operacoes com produtos, aguarde...")
        aStrut:={{"CODIGO","N",02,00},;
                 {"DESCRI","C",45,00},;
                 {"ENTSAI","C",01,00},;
                 {"BLOQ__","C",01,00},;
                 {"NATOPE","N",06,03},;
                 {"NATEST","N",06,03},;
                 {"NATFOR","N",06,03},;
                 {"CALICM","C",01,00},;
                 {"DEBCRE","C",01,00},;
                 {"FRETE_","C",01,00},;
                 {"ENTSAI","C",01,00},;
                 {"TABPRE","N",04,00},;
                 {"TABCND","N",03,00},;
                 {"COMISS","C",01,00},;
                 {"OBSERV","C",40,00},;
                 {"CLIFOR","C",01,00},;
                 {"TIPDOC","N",03,00}}
        dbcreate(_VPB_OPERACOES,aStrut)
   case nDBF==_COD_ATALHO
        aStrut:={{"LINHA_","N",03,00},;
                 {"COLUNA","N",03,00},;
                 {"DESCRI","C",20,00},;
                 {"ICONE_","C",02,00},;
                 {"MODULO","C",15,00}}
        dbCreate( _VPB_ATALHO, aStrut )
   case nDBF==_COD_SIMILAR
        aStrut:={{"CODIG1","C",12,00},;
                 {"DESCR1","C",25,00},;
                 {"CODIG2","C",12,00},;
                 {"DESCR2","C",25,00},;
                 {"COMP01","C",14,00},;
                 {"COMP02","C",14,00},;
                 {"SIMNAO","C",01,00}}
        dbCreate( _VPB_SIMILAR, aStrut )
   case nDBF==_COD_PEDIDO
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODIGO","C",08,00},;
                 {"CODPED","C",08,00},;
                 {"SERIE_","C",01,00},;
                 {"CODCLI","N",06,00},;
                 {"CONIND","C",01,00},;
                 {"DESCRI","C",45,00},;
                 {"FANTAS","C",45,00},;
                 {"ENDERE","C",35,00},;
                 {"BAIRRO","C",25,00},;
                 {"CIDADE","C",30,00},;
                 {"ESTADO","C",02,00},;
                 {"CODCEP","C",08,00},;
                 {"FONFAX","C",30,00},;
                 {"CGCMF_","C",14,00},;
                 {"INSCRI","C",15,00},;
                 {"VENIN1","N",04,00},;
                 {"VENEX1","N",04,00},;
                 {"COBRAN","C",30,00},;
                 {"TRANSP","N",03,00},;
                 {"COMPRA","C",40,00},;
                 {"CODNF_","N",09,00},;
                 {"DATANF","D",08,00},;
                 {"DATA__","D",08,00},;
                 {"DTATU_","D",08,00},;
                 {"CODFUN","N",04,00},;
                 {"SELECT","C",03,00},;
                 {"SITUA_","C",03,00},; && CAMPO P/ COTACAO-PEDIDO "PED"
                 {"PERACR","N",06,02},;
                 {"PERDIF","C",40,00},;
                 {"CONDI_","C",15,00},;
                 {"PRAZO_","C",10,00},;
                 {"VALID_","N",10,00},;
                 {"FRETE_","C",15,00},;
                 {"OBSER1","C",76,00},;
                 {"OBSER2","C",76,00},;
                 {"VENDE1","C",12,00},;
                 {"VENDE2","C",12,00},;
                 {"VENIN_","N",03,00},;
                 {"VENEX_","N",03,00},;
                 {"OC__01","C",06,00},;
                 {"QTD_01","N",06,00},;
                 {"ENT_01","C",06,00},;
                 {"OC__02","C",06,00},;
                 {"QTD_02","N",06,00},;
                 {"ENT_02","C",06,00},;
                 {"OC__03","C",06,00},;
                 {"QTD_03","N",06,00},;
                 {"ENT_03","C",06,00},;
                 {"OC__04","C",06,00},;
                 {"QTD_04","N",06,00},;
                 {"ENT_04","C",06,00},;
                 {"OC__05","C",06,00},;
                 {"QTD_05","N",06,00},;
                 {"ENT_05","C",06,00},;
                 {"OC__06","C",06,00},;
                 {"QTD_06","N",06,00},;
                 {"ENT_06","C",06,00},;
                 {"OC__07","C",06,00},;
                 {"QTD_07","N",06,00},;
                 {"ENT_07","C",06,00},;
                 {"OC__08","C",06,00},;
                 {"QTD_08","N",06,00},;
                 {"ENT_08","C",06,00},;
                 {"OC__09","C",06,00},;
                 {"QTD_09","N",06,00},;
                 {"ENT_09","C",06,00},;
                 {"OC__10","C",06,00},;
                 {"QTD_10","N",06,00},;
                 {"ENT_10","C",06,00},;
                 {"OC__11","C",06,00},;
                 {"QTD_11","N",06,00},;
                 {"ENT_11","C",06,00},;
                 {"OC__12","C",06,00},;
                 {"QTD_12","N",06,00},;
                 {"ENT_12","C",06,00},;
                 {"OC__13","C",06,00},;
                 {"QTD_13","N",06,00},;
                 {"ENT_13","C",06,00},;
                 {"OC__14","C",06,00},;
                 {"QTD_14","N",06,00},;
                 {"ENT_14","C",06,00},;
                 {"OC__15","C",06,00},;
                 {"QTD_15","N",06,00},;
                 {"ENT_15","C",06,00},;
                 {"OC__16","C",06,00},;
                 {"QTD_16","N",06,00},;
                 {"ENT_16","C",06,00},;
                 {"OC__17","C",06,00},;
                 {"QTD_17","N",06,00},;
                 {"ENT_17","C",06,00}}
           AAdd( aStrut, { "OC__18", "C", 06, 00 } )
           AAdd( aStrut, { "QTD_18", "N", 06, 00 } )
           AAdd( aStrut, { "ENT_18", "C", 06, 00 } )
           AAdd( aStrut, { "VLRTOT", "N", 16, 02 } )
           AAdd( aStrut, { "TABCND", "N", 04, 00 } )
           AAdd( aStrut, { "TABOPE", "N", 03, 00 } )
           AAdd( aStrut, { "OBSNF1", "C", 40, 00 } )
           AAdd( aStrut, { "OBSNF2", "C", 40, 00 } )
           AAdd( aStrut, { "OBSNF3", "C", 40, 00 } )
           AAdd( aStrut, { "OBSNF4", "C", 40, 00 } )
           AAdd( aStrut, { "BANCO_", "N", 01, 00 } )
           AAdd( aStrut, { "VLRFRE", "N", 16, 02 } )
           AAdd( aStrut, { "STATUS", "N", 01, 00 } )
           AAdd( aStrut, { "GARANT", "C", 15, 00 } )
           AAdd( aStrut, { "OPC1__", "N", 16, 02 } )
           AAdd( aStrut, { "OPC2__", "N", 16, 02 } )
           AAdd( aStrut, { "OPC3__", "N", 16, 02 } )
           AAdd( aStrut, { "MOBRA_", "N", 16, 04 } )
           AAdd( aStrut, { "DATAEM", "D", 08, 00 } )
           AAdd( aStrut, { "TIPO__", "C", 02, 00 } )
           AAdd( aStrut, { "PERDES", "N", 10, 02 } )
           AAdd( aStrut, { "DATAEM", "D", 08, 00 } )
           AAdd( aStrut, { "IDENT_", "C", 10, 00 } )
           AAdd( aStrut, { "IMPRES", "C", 01, 00 } )
           AAdd( aStrut, { "FILIAL", "N", 03, 00 } )
        DBCreate( _VPB_PEDIDO, aStrut )
   Case nDBF==_COD_PEDPROD
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODIGO","C",08,00},;
                 {"SERIE_","C",01,00},;
                 {"CODPRO","N",10,00},;
                 {"CODFAB","C",15,00},;
                 {"DESCRI","C",50,00},;
                 {"UNIDAD","C",02,00},;
                 {"QUANT_","N",16,04},;
                 {"VLRINI","N",16,04},;
                 {"PERDES","N",06,02},;
                 {"VLRUNI","N",16,04},;
                 {"IPI___","N",06,02},;
                 {"ICM___","N",06,02},;
                 {"ENTREG","D",08,00},;
                 {"SELECT","C",03,00},;
                 {"CODPED","C",08,00},;
                 {"DATSEL","D",08,00},;
                 {"ORIGEM","C",15,00},;
                 {"PRECO1","N",16,04},;
                 {"PRECO2","N",16,04},;
                 {"TABPRE","N",04,00},;
                 {"DESPRE","C",40,00},;
                 {"TABCND","N",03,00},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},;
                 {"EXIBIR","C",01,00},;
                 {"PCPCOR","N",03,00},;
                 {"DTENTR","C",08,00}}
        DBCreate( _VPB_PEDPROD, aStrut )
   Case nDBF==_COD_PEDBAIXA
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODNF_","N",09,00},;
                 {"CODIGO","C",08,00},;
                 {"CODCLI","N",06,00},;
                 {"SERIE_","C",01,00},;
                 {"CODPRO","C",12,00},;
                 {"CODFAB","C",15,00},;
                 {"DESCRI","C",50,00},;
                 {"UNIDAD","C",02,00},;
                 {"QUANT_","N",16,04},;
                 {"VLRINI","N",16,04},;
                 {"PERDES","N",06,02},;
                 {"VLRUNI","N",16,04},;
                 {"IPI___","N",06,02},;
                 {"ICM___","N",06,02},;
                 {"ENTREG","D",08,00},;
                 {"CODPED","C",08,00},;
                 {"DATSEL","D",08,00},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},;
                 {"PCPCOR","N",03,00}}
        DBCreate( _VPB_PEDBAIXA, aStrut )
   Case nDBF==_COD_ATIVIDADES
        aStrut:={{ "CODIGO", "N", 04, 00 },;
                 { "DESCRI", "C", 40, 00 } }
        dbcreate( _VPB_ATIVIDADES, aStrut )
   Case nDBF==_COD_RECEITAS
        aStrut:={{ "CODIGO", "N", 04, 00 },;
                 { "DESCRI", "C", 40, 00 },;
                 { "SALDO_", "N", 16, 02 } }
        dbcreate( _VPB_RECEITAS, aStrut )
   Case nDBF==_COD_MOVIMENTO
        aStrut:={{ "DATA__", "D", 08, 00 },;
                 { "NCONTA", "N", 04, 00 },;
                 { "TCONTA", "C", 01, 00 },;
                 { "DCONTA", "C", 30, 00 },;
                 { "HISTO1", "C", 30, 00 },;
                 { "HISTO2", "C", 30, 00 },;
                 { "DEBITO", "N", 16, 02 },;
                 { "CREDIT", "N", 16, 02 } }
        dbcreate(_VPB_MOVIMENTO, aStrut )
   case nDBF == _COD_TABPRECO
        aStrut:={{ "CODIGO", "N", 04, 00 },;
                 { "DESCRI", "C", 40, 00 },;
                 { "PERACR", "N", 12, 03 },;
                 { "PERDES", "N", 12, 03 },;
                 { "ARRED_", "C", 01, 00 },;
                 { "MARGEM", "N", 12, 03 },;
                 { "SELECT", "C", 01, 00 },;
                 { "CND001", "N", 02, 00 },;
                 { "CND002", "N", 02, 00 },;
                 { "CND003", "N", 02, 00 },;
                 { "CND004", "N", 02, 00 },;
                 { "CND005", "N", 02, 00 } }
        dbcreate( _VPB_TABPRECO, aStrut )
   case nDBF==_COD_TABAUX
        aStrut:={{ "CODIGO", "N", 04, 00 },;
                 { "CODPRO", "C", 12, 00 },;
                 { "CODFAB", "C", 15, 00 },;
                 { "DESCRI", "C", 40, 00 },;
                 { "PERACR", "N", 06, 02 },;
                 { "PERDES", "N", 06, 02 },;
                 { "PRECOV", "N", 16, 04 },;
                 { "MARGEM", "N", 16, 02 },;
                 { "DATA__", "D", 08, 00 }}
        dbcreate( _VPB_TABAUX, aStrut )
   case nDBF==_COD_CONDICOES
        aStrut:={{"CODIGO","N", 04, 00 },;
                 {"DESCRI","C", 40, 00 },;
                 {"PERACD","N", 12, 06 },;
                 {"PERACR","N", 09, 03 },;
                 {"PERDES","N", 09, 03 },;
                 {"PARCA_","N", 03, 00 },;
                 {"PARCB_","N", 03, 00 },;
                 {"PARCC_","N", 03, 00 },;
                 {"PARCD_","N", 03, 00 },;
                 {"PARCE_","N", 03, 00 },;
                 {"PARCF_","N", 03, 00 },;
                 {"PARCG_","N", 03, 00 },;
                 {"PARCH_","N", 03, 00 },;
                 {"PARCI_","N", 03, 00 },;
                 {"PARCJ_","N", 03, 00 },;
                 {"PARCK_","N", 03, 00 },;
                 {"PARCL_","N", 03, 00 },;
                 {"PARCM_","N", 03, 00 },;
                 {"PARCN_","N", 03, 00 },;
                 {"PARCO_","N", 03, 00 },;
                 {"PARCP_","N", 03, 00 },;
                 {"PARCQ_","N", 03, 00 },;
                 {"PARCR_","N", 03, 00 },;
                 {"PARCS_","N", 03, 00 },;
                 {"PARCT_","N", 03, 00 },;
                 {"PARCU_","N", 03, 00 },;
                 {"PARCV_","N", 03, 00 },;
                 {"PARCW_","N", 03, 00 },;
                 {"PARCX_","N", 03, 00 },;
                 {"PARCY_","N", 03, 00 },;
                 {"PARCZ_","N", 03, 00 },;
                 {"TAXA__","N", 10, 00 },;
                 {"JUROS_","N", 09, 03 },;
                 {"MULTA_","N", 09, 03 },;
                 {"TOLERA","N", 06, 00 },;
                 {"PERCA_","N", 09, 03 },;
                 {"SELECT","C", 01, 00 }}
        dbcreate( _VPB_CONDICOES, aStrut )
   case nDBF==_COD_MPRIMA
        aStrut:={{"INDICE","C",12,00},;
                 {"CODRED","C",12,00},;
                 {"CLASSE","C",01,00},;
                 {"CODIGO","C",12,00},;
                 {"CODFAB","C",13,00},;
                 {"DESCRI","C",_ESP_DESCRICAO,00},;
                 {"MPRIMA","C",01,00},;
                 {"ORIGEM","C",03,00},;
                 {"UNIDAD","C",02,00},;
                 {"ASSOC_","C",01,00},;
                 {"QTDPES","N",16,05},;
                 {"SDOINI","N",16,05},;
                 {"RESERV","N",16,05},;
                 {"SALDO_","N",16,05},;
                 {"ESTMIN","N",16,05},;
                 {"ESTMAX","N",16,05},;
                 {"PERCNV","N",04,02},;
                 {"PRECOV","N",16,04},;
                 {"ICMCOD","N",01,00},;
                 {"IPICOD","N",01,00},;
                 {"CLAFIS","N",03,00},;
                 {"CLASV_","N",01,00},;
                 {"IPI___","N",06,02},;
                 {"ICM___","N",06,02},;
                 {"CODFOR","N",03,00},;
                 {"MONTA_","N",03,00},;
                 {"BUSCA_","C",01,00},;
                 {"PRECOD","N",16,04},;
                 {"PERCDC","N",12,03},;
                 {"PERCPV","N",12,03},;
                 {"PRECO_","N",16,04},;
                 {"TABPRE","N",04,00},;
                 {"DATA__","D",08,00},;
                 {"MARCA_","C",01,00},;
                 {"PERRED","N",12,04},;
                 {"FOR001","N",03,00},;
                 {"DES001","C",40,00},;
                 {"FOR002","N",03,00},;
                 {"DES002","C",40,00},;
                 {"FOR003","N",03,00},;
                 {"DES003","C",40,00},;
                 {"FOR004","N",03,00},;
                 {"DES004","C",40,00},;
                 {"FOR005","N",03,00},;
                 {"DES005","C",40,00},;
                 {"FOR006","N",03,00},;
                 {"DES006","C",40,00},;
                 {"FOR007","N",03,00},;
                 {"DES007","C",40,00},;
                 {"FOR008","N",03,00},;
                 {"DES008","C",40,00},;
                 {"FOR009","N",03,00},;
                 {"DES009","C",40,00},;
                 {"FOR010","N",03,00},;
                 {"DES010","C",40,00},;
                 {"FOR011","N",03,00},;
                 {"DES011","C",40,00},;
                 {"FOR012","N",03,00},;
                 {"DES012","C",40,00},;
                 {"FOR013","N",03,00},;
                 {"DES013","C",40,00} }
                 AAdd( aStrut,{"FOR014","N",03,00} )
                 AAdd( aStrut,{"DES014","C",40,00} )
                 AAdd( aStrut,{"FOR015","N",03,00} )
                 AAdd( aStrut,{"DES015","C",40,00} )
                 AAdd( aStrut,{"TABRED","C",02,00} )
                 AAdd( aStrut,{"PESOLI","N",16,04} )
                 AAdd( aStrut,{"PESOBR","N",16,04} )
                 AAdd( aStrut,{"OCOMP_","N",16,05} )
                 AAdd( aStrut,{"DETAL1","C",65,00} )
                 AAdd( aStrut,{"DETAL2","C",65,00} )
                 AAdd( aStrut,{"DETAL3","C",65,00} )
                 AAdd( aStrut,{"COMIS_","C",01,00} )
                 AAdd( aStrut,{"MOEDA_","C",03,00} )
                 AAdd( aStrut,{"MOBRAP","N",06,02} )
                 AAdd( aStrut,{"MOBRAV","N",16,02} )
                 AAdd( aStrut,{"CUSMED","N",16,03} )
                 AAdd( aStrut,{"ENTQTD","N",16,04} )
                 AAdd( aStrut,{"SAIQTD","N",16,04} )
                 AAdd( aStrut,{"DTULTS","D",08,00} )
                 AAdd( aStrut,{"DTULTE","D",08,00} )
                 AAdd( aStrut,{"QTULTS","N",16,04} )
                 AAdd( aStrut,{"QTULTE","N",16,04} )
                 AAdd( aStrut,{"SDOVLR","N",16,02} )
                 AAdd( aStrut,{"SEGURA","C",01,00} )
                 AAdd( aStrut,{"TABOBS","N",04,00} )
                 AAdd( aStrut,{"QTDMIN","N",16,02} )
                 AAdd( aStrut,{"CUSATU","N",16,04} )
                 AAdd( aStrut,{"CODIF_","C",20,00} )
                 AAdd( aStrut,{"INGATV","C",20,00} )
                 AAdd( aStrut,{"CLATOX","N",03,00} )
                 AAdd( aStrut,{"PCPCLA","N",03,00} )
                 AAdd( aStrut,{"PCPTAM","N",02,00} ) // <-- NAO ESTA SENDO USADO
                 AAdd( aStrut,{"PCPCOR","N",03,00} ) // <-- OBSOLETO
                 AAdd( aStrut,{"PCPCSN","C",01,00} )
                 AAdd( aStrut,{"ENTVLR","N",16,02} )
                 AAdd( aStrut,{"AREA__","N",16,02} )
                 AAdd( aStrut,{"GARVAL","N",03,00} )
                 AAdd( aStrut,{"AVISO_","N",02,00} )
                 AAdd( aStrut,{"SELECT","C",03,00} )
                 AAdd( aStrut,{"SITT01","N",01,00} )
                 AAdd( aStrut, {"SITT02","N",02,00} )

                 AAdd( aStrut, {"MVA___","N",10,02} )
                 AAdd( aStrut, {"MVAPER","N",10,04} )
                 AAdd( aStrut, {"MVAVLR","N",16,02} )
                 AAdd( aStrut, {"CLASSE","C",01,00} )
                 AAdd( aStrut, {"IPICMP","N",06,02} )

        dbcreate(_VPB_MPRIMA,aStrut)
   case nDBF==_COD_ASSEMBLER
        aStrut:={{"CODPRD","C",12,00},;
                 {"CODMPR","C",12,00},;
                 {"QUANT_","N",15,05},;
                 {"CUSUNI","N",16,02},;
                 {"CUSTOT","N",16,03},;
                 {"DESCRI","C",50,00},;
                 {"CODFAB","C",15,00},;
                 {"UNIDAD","C",02,00},;
                 {"PERIPI","N",05,00},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},;
                 {"PCPCOR","N",03,00},;
                 {"PCPQUA","N",12,02}}
        dbcreate(_VPB_ASSEMBLER,aStrut)
   case nDBF==_COD_PRECOXFORN
        aStrut:={{"CPROD_","C",12,00},;
                 {"CODFOR","N",04,00},;
                 {"VALOR_","N",16,04},;
                 {"PVELHO","N",16,04},;
                 {"DATA__","D",08,00}}
        dbcreate(_VPB_PRECOXFORN,aStrut)

   case nDBF==_COD_CONFIG
        aStrut:={{"VARIAV","C",10,00},;
                 {"QUANT_","N",02,00},;
                 {"DECIM_","N",02,00},;
                 {"MASCAR","C",16,00},;
                 {"VERIf_","C",01,00},;
                 {"DATA__","D",08,00},;
                 {"USUAR_","N",03,00},;
                 {"HORA__","C",08,00},;
                 {"QUEST_","C",01,00}}
        dbcreate(_VPB_CONFIG,aStrut)
   case nDBF==_COD_ESTOQUE
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CPROD_","C",12,00},;
                 {"CODRED","C",12,00},;
                 {"ENTSAI","C",01,00},;
                 {"QUANT_","N",12,03},;
                 {"DOC___","C",15,00},;
                 {"CODIGO","N",06,00},;
                 {"VLRSDO","N",16,02},;
                 {"VLRSAI","N",16,02},;
                 {"VLRICM","N",16,02},;
                 {"VALOR_","N",16,02},;
                 {"TOTAL_","N",16,02},;
                 {"DATAMV","D",08,00},;
                 {"RESPON","N",03,00},;
                 {"ANULAR","C",01,00},;
                 {"PERICM","N",06,02},;
                 {"PERIPI","N",06,02},;
                 {"VLRIPI","N",16,02},;
                 {"VLRFRE","N",16,02},;
                 {"NATOPE","N",06,03},;
                 {"CUSMED","N",16,04},;
                 {"CODMV_","N",03,00},;
                 {"CUSATU","N",16,04},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},;
                 {"PCPCOR","N",03,00},;
                 {"PCPQUA","N",12,02},;
                 {"VLRDES","N",12,02},;
                 {"OUTDES","N",12,02},;
                 {"OUTACR","N",12,02},;
                 {"CUSTO_","N",12,04}}
                 /* Valor ICMs mercadoria ref. neg. */
                 /* Valor desta entrada/saida */
                 /* Valor + ICMs */
                 /* Data de lancamento */
                 /* OUTACR - Outros acrescimos */
                 /* OUTDES - Outros descontos */
                 /* CUSTO_ - Custo */
        dbcreate(_VPB_ESTOQUE,aStrut)
   case nDBF==_COD_PRODNF
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODNF_","N",09,00},;
                 {"CODRED","C",12,00},;
                 {"CODIGO","C",12,00},;
                 {"ORIGEM","C",03,00},;
                 {"DESCRI","C",_ESP_DESCRICAO,00},;
                 {"MPRIMA","C",01,00},;
                 {"UNIDAD","C",02,00},;
                 {"ASSOC_","C",01,00},;
                 {"QTDPES","N",16,05},;
                 {"QUANT_","N",12,03},;
                 {"PRECOV","N",16,04},;
                 {"PRECOT","N",16,04},;
                 {"ICMCOD","N",01,00},;
                 {"IPICOD","N",01,00},;
                 {"CLAFIS","N",03,00},;
                 {"PERIPI","N",06,03},;
                 {"IPI___","N",16,03},;
                 {"BASICM","N",16,02},;
                 {"PERRED","N",12,04},;
                 {"VLRRED","N",16,02},;
                 {"PERICM","N",06,02},;
                 {"VLRICM","N",16,02},;
                 {"CODFOR","N",03,00},;
                 {"CODFIS","C",10,00},;
                 {"NFNULA","C",01,00},;
                 {"CLIENT","N",06,00},;
                 {"DATA__","D",08,00},;
                 {"ECVV__","N",06,02},;
                 {"ECVP__","N",06,02},;
                 {"ICVV__","N",06,02},;
                 {"ICVP__","N",06,02},;
                 {"VENIN_","N",03,00},;
                 {"ORIGEM","C",03,00},;
                 {"VENEX_","N",03,00},;
                 {"PRECO1","N",16,04},;
                 {"PRECO2","N",16,04},;
                 {"TABPRE","N",04,00},;
                 {"DESPRE","C",40,00},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},;
                 {"PCPCOR","N",03,00},;
                 {"TABOPE","N",03,00},;
                 {"FILIAL","N",03,00},;
                 {"SITT01","N",01,00},;
                 {"SITT02","N",02,00}}
        dbcreate(_VPB_PRODNF,aStrut)
   case nDBF==_COD_NFISCAL
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"TIPONF","C",01,00},;
                 {"NUMERO","N",09,00},;
		 {"NATOPE","N",05,03},;
                 {"CLIENT","N",06,00},;
                 {"CDESCR","C",45,00},;
                 {"CENDER","C",35,00},;
                 {"CBAIRR","C",25,00},;
                 {"CCIDAD","C",30,00},;
                 {"CESTAD","C",02,00},;
                 {"CCDCEP","C",08,00},;
                 {"CCGCMF","C",14,00},;
                 {"CCPF__","C",11,00},;
                 {"CINSCR","C",12,00},;
                 {"CCOBRA","C",30,00},;
                 {"CFONE2","C",12,00},;
                 {"TRANSP","N",03,00},;
                 {"TDESCR","C",20,00},;
                 {"TENDER","C",35,00},;
                 {"TCIDAD","C",20,00},;
                 {"TESTAD","C",02,00},;
                 {"TCGCMF","C",14,00},;
                 {"TINSCR","C",15,00},;
                 {"TFONE_","C",12,00},;
                 {"PEDIDO","N",08,00},;
                 {"ORDEMC","C",60,00},;
                 {"CONREV","C",01,00},;
                 {"DATAEM","D",08,00},;
                 {"VENIN_","N",04,00},;
                 {"VENEX_","N",04,00},;
                 {"PERICM","N",06,02},;
                 {"SEGURO","N",16,04},;
                 {"FRETE_","N",16,04},;
                 {"VLRNOT","N",16,04},;
                 {"VLRTOT","N",16,04},;
                 {"BASSUB","N",16,04},;
                 {"ICMSUB","N",16,04},;
                 {"BASICM","N",16,04},;
                 {"VLRIPI","N",16,04},;
                 {"VLRICM","N",16,04},;
                 {"ICMPER","N",06,02},;
                 {"VIATRA","C",20,00},;
                 {"ESPEC_","C",18,00},;
                 {"QUANT_","C",10,00},;
                 {"PESOLI","N",16,02},;
                 {"PESOBR","N",16,02},;
                 {"SAIDAT","D",08,00},;
                 {"SAIHOR","C",06,00},;
                 {"OBSER1","C",60,00},;
                 {"OBSER2","C",60,00},;
                 {"OBSER3","C",60,00},;
                 {"OBSER4","C",60,00},;
                 {"OBSER5","C",60,00},;
                 {"NVEZES","N",02,00},;
                 {"FUNC__","N",03,00},;
                 {"NFNULA","C",01,00},;
                 {"FPC12_","C",01,00},;
                 {"ENTSAI","C",01,00},;
                 {"PERACR","N",06,02},;
                 {"VLRACR","N",14,02},;
                 {"PERDES","N",06,02},;
                 {"VLRDES","N",14,02},;
                 {"ISSQNP","N",06,02},;
                 {"ISSQNV","N",14,02},;
                 {"ISSQNB","N",14,02},;
                 {"IRRF_P","N",06,02},;
                 {"IRRF_V","N",14,02},;
                 {"IRRF_B","N",14,02},;
                 {"TABCND","N",04,00},;
                 {"SELECT","C",03,00},;
                 {"PRAZOA","N",04,00},;
                 {"IMPRES","C",03,00},;
                 {"TABCND","N",03,00},;
                 {"PERSRV","N",06,02},;
                 {"VLRSRV","N",16,02},;
                 {"TABOPE","N",03,00},;
                 {"PLACA_","C",08,00},;
                 {"DESPES","N",14,02},;
                 {"COFINV","N",14,02},;
                 {"COFINP","N",14,02}}
        dbcreate(_VPB_NFISCAL,aStrut)
   case nDBF==_COD_CUPOM
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"TIPONF","C",01,00},;
                 {"NUMERO","N",09,00},;
                 {"NATOPE","N",05,03},;
                 {"CLIENT","N",06,00},;
                 {"CDESCR","C",45,00},;
                 {"CENDER","C",35,00},;
                 {"CBAIRR","C",25,00},;
                 {"CCIDAD","C",30,00},;
                 {"CESTAD","C",02,00},;
                 {"CCDCEP","C",08,00},;
                 {"CCGCMF","C",14,00},;
                 {"CCPF__","C",11,00},;
                 {"CINSCR","C",12,00},;
                 {"CCOBRA","C",30,00},;
                 {"CFONE2","C",12,00},;
                 {"TRANSP","N",03,00},;
                 {"TDESCR","C",20,00},;
                 {"TENDER","C",35,00},;
                 {"TCIDAD","C",20,00},;
                 {"TESTAD","C",02,00},;
                 {"TCGCMF","C",14,00},;
                 {"TINSCR","C",15,00},;
                 {"TFONE_","C",12,00},;
                 {"PEDIDO","N",06,00},;
                 {"ORDEMC","C",60,00},;
                 {"CONREV","C",01,00},;
                 {"DATAEM","D",08,00},;
                 {"VENIN_","N",04,00},;
                 {"VENEX_","N",04,00},;
                 {"SEGURO","N",16,04},;
                 {"FRETE_","N",16,04},;
                 {"VLRNOT","N",16,04},;
                 {"VLRTOT","N",16,04},;
                 {"BASICM","N",16,04},;
                 {"VLRIPI","N",16,04},;
                 {"VLRICM","N",16,04},;
                 {"ICMPER","N",06,02},;
                 {"VIATRA","C",20,00},;
                 {"ESPEC_","C",18,00},;
                 {"QUANT_","C",10,00},;
                 {"PESOLI","N",16,02},;
                 {"PESOBR","N",16,02},;
                 {"SAIDAT","D",08,00},;
                 {"SAIHOR","C",06,00},;
                 {"OBSER1","C",60,00},;
                 {"OBSER2","C",60,00},;
                 {"OBSER3","C",60,00},;
                 {"OBSER4","C",60,00},;
                 {"OBSER5","C",60,00},;
                 {"NVEZES","N",02,00},;
                 {"FUNC__","N",03,00},;
                 {"NFNULA","C",01,00},;
                 {"FPC12_","C",01,00},;
                 {"ENTSAI","C",01,00},;
                 {"PERACR","N",06,02},;
                 {"VLRACR","N",14,02},;
                 {"PERDES","N",06,02},;
                 {"VLRDES","N",14,02},;
                 {"ISSQNP","N",06,02},;
                 {"ISSQNV","N",14,02},;
                 {"ISSQNB","N",14,02},;
                 {"IRRF_P","N",06,02},;
                 {"IRRF_V","N",14,02},;
                 {"IRRF_B","N",14,02},;
                 {"TABCND","N",04,00},;
                 {"TABOPE","N",03,00}}
        dbcreate(_VPB_CUPOM,aStrut)
   case nDBF==_COD_CUPOMAUX
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODNF_","N",09,00},;
                 {"CODRED","C",12,00},;
                 {"CODIGO","C",12,00},;
                 {"DESCRI","C",40,00},;
                 {"MPRIMA","C",01,00},;
                 {"UNIDAD","C",02,00},;
                 {"ASSOC_","C",01,00},;
                 {"QTDPES","N",16,05},;
                 {"QUANT_","N",12,03},;
                 {"PRECOV","N",16,04},;
                 {"PRECOT","N",16,04},;
                 {"ICMCOD","N",01,00},;
                 {"IPICOD","N",01,00},;
                 {"CLAFIS","N",03,00},;
                 {"PERIPI","N",06,03},;
                 {"IPI___","N",16,03},;
                 {"BASICM","N",16,02},;
                 {"PERRED","N",12,04},;
                 {"VLRRED","N",16,02},;
                 {"PERICM","N",06,02},;
                 {"VLRICM","N",16,02},;
                 {"CODFOR","N",03,00},;
                 {"CODFIS","C",10,00},;
                 {"NFNULA","C",01,00},;
                 {"CLIENT","N",06,00},;
                 {"DATA__","D",08,00},;
                 {"ECVV__","N",06,02},;
                 {"ECVP__","N",06,02},;
                 {"ICVV__","N",06,02},;
                 {"ICVP__","N",06,02},;
                 {"VENIN_","N",03,00},;
                 {"VENEX_","N",03,00},;
                 {"TABPRE","N",03,00},;
                 {"TABCND","N",03,00},;
                 {"TABOPE","N",03,00}}
        dbcreate( _VPB_CUPOMAUX, aStrut )
   case nDBF==_COD_DUPAUX
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODNF_","N",09,00},;
                 {"SEQUE_","N",08,00},;
                 {"CODIGO","N",10,00},;
                 {"CLIENT","N",06,00},;
                 {"CDESCR","C",45,00},;
                 {"DUPL__","N",12,00},;
                 {"LETRA_","C",01,00},;
                 {"PERC__","N",06,02},;
                 {"VLRPAD","N",16,02},;
                 {"VLR___","N",16,03},;
                 {"JUROS_","N",16,03},;
                 {"VLRDES","N",16,02},;
                 {"PRAZ__","N",03,00},;
                 {"VENC__","D",08,00},;
                 {"QUIT__","C",01,00},;
                 {"DTQT__","D",08,00},;
                 {"BANC__","N",03,00},;
                 {"CHEQ__","C",15,00},;
                 {"OBS___","C",30,00},;
                 {"DADO__","C",03,00},;
                 {"SITU__","C",01,00},;
                 {"DATAEM","D",08,00},;
                 {"FUNC__","N",03,00},;
                 {"TIPO__","C",02,00},;
                 {"VLRICM","N",16,02},;
                 {"VLRIPI","N",16,02},;
                 {"VLRISS","N",16,02},;
                 {"VLRIRR","N",16,02},;
                 {"NFNULA","C",01,00},;
                 {"SITUAC","C",45,00},; // Situacao da Cobranca (Remessa/Retorno)
                 {"LOCAL_","N",03,00}}
        dbcreate(_VPB_DUPAUX,aStrut)
   case nDBF==_COD_OBSERVACOES
        aStrut:={{"CODIGO","N",10,00},;
                 {"DESCRI","C",30,00},;
                 {"OBSERV","C",40,00}}
        dbcreate(_VPB_OBSERVACOES,aStrut)
   case nDBF==_COD_PAGAR
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODIGO","N",05,00},;
                 {"DOC___","C",10,00},;
                 {"CODFOR","N",06,00},;
                 {"BANCO_","N",03,00},;
                 {"VENCIM","D",08,00},;
                 {"VALOR_","N",16,04},;
                 {"DATAPG","D",08,00},;
                 {"OBSERV","C",40,00},;
                 {"EMISS_","D",08,00},;
                 {"JUROS_","N",16,04},;
                 {"VLRIPI","N",16,04},;
                 {"VLRICM","N",16,04},;
                 {"QUITAD","C",01,00},;
                 {"CHEQUE","C",15,04},;
                 {"NFISC_","N",06,00},;
                 {"TABOPE","N",03,00},;
                 {"LOCAL_","N",03,00},;
                 {"DENTRA","D",08,00}}
        dbcreate(_VPB_PAGAR,aStrut)
   case nDBF==_COD_CLASFISCAL
        aStrut:={{"CODIGO","N",03,00},;
                 {"CODFIS","C",10,00},;
                 {"OBSERV","C",30,00},;
                 {"OBSNOT","C",60,00}}
        dbcreate(_VPB_CLASFISCAL,aStrut)
   case nDBF==_COD_CAIXA
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"DATAMV","D",08,00},;
                 {"VENDE_","N",03,00},;
                 {"ENTSAI","C",01,00},;
                 {"MOTIVO","N",02,00},;
                 {"HISTOR","C",40,00},;
                 {"VALOR_","N",16,02},;
                 {"HORAMV","C",08,00},;
                 {"CDUSER","N",03,00}}
        dbcreate(_VPB_CAIXA,aStrut)
   case nDBF==_COD_CAIXAAUX
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"DATAMV","D",08,00},;
                 {"VENDE_","N",03,00},;
                 {"ENTSAI","C",01,00},;
                 {"MOTIVO","N",02,00},;
                 {"HISTOR","C",40,00},;
                 {"VALOR_","N",16,02},;
                 {"HORAMV","C",08,00},;
                 {"CDUSER","N",03,00}}
        dbcreate(_VPB_CAIXAAUX,aStrut)
   case nDBF==_COD_BANCO
        aStrut:={{"CODIGO","N",03,00},;
                 {"CODPES","C",04,00},;
                 {"DESCRI","C",45,00},;
                 {"SELECT","C",03,00},;
                 {"SALDO_","N",16,02}}
        dbcreate(_VPB_BANCO,aStrut)
   case nDBF==_COD_TRANSPORTE
        Mensagem( "Criando arquivo de cadastro de transportadoras, aguarde...")
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",45,00},;
                 {"ENDERE","C",40,00},;
                 {"BAIRRO","C",30,00},;
                 {"CIDADE","C",20,00},;
                 {"ESTADO","C",02,00},;
                 {"CODCEP","C",08,00},;
                 {"CGCMF_","C",14,00},;
                 {"CPF___","C",11,00},;
                 {"INSCRI","C",15,00},;
                 {"FONE__","C",12,00},;
                 {"E_MAIL","C",60,00}}
        dbcreate(_VPB_TRANSPORTE,aStrut)
   case nDBF==_COD_ORIGEM
        Mensagem( "Criando arquivo de cadastro de origens, aguarde...")
        aStrut:={{"CODIGO","N",03,00},;
                 {"CODABR","C",03,00},;
                 {"DESCRI","C",45,00},;
                 {"SELECT","C",03,00}}
        dbcreate(_VPB_ORIGEM,aStrut)
   case nDBF==_COD_NATOPERA
        Mensagem( "Criando arquivo de natureza da oprecao, aguarde...")
        aStrut:={{"CODIGO","N",05,03},;
                 {"DESCRI","C",40,00},;
                 {"ENTSAI","C",03,00}}
        dbcreate( _VPB_NATOPERA, aStrut )
   case nDBF==_COD_VENDEDOR
        Mensagem( "Criando arquivo de cadastro de vendedores, aguarde...")
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODIGO","N",03,00},;
                 {"SIGLA_","C",02,00},;
                 {"DESCRI","C",45,00},;
                 {"ENDERE","C",40,00},;
                 {"E_MAIL","C",40,00},;
                 {"INSCRI","C",12,00},;
                 {"BAIRRO","C",30,00},;
                 {"CIDADE","C",20,00},;
                 {"ESTADO","C",02,00},;
                 {"CODCEP","C",08,00},;
                 {"FORM01","N",02,00},;
                 {"FORM02","N",02,00},;
                 {"FORM03","N",02,00},;
                 {"FORM04","N",02,00},;
                 {"FORM05","N",02,00},;
                 {"FORM06","N",02,00},;
                 {"FORM07","N",02,00},;
                 {"FORM08","N",02,00},;
                 {"FORM09","N",02,00},;
                 {"FORM10","N",02,00},;
                 {"CGCMF_","C",14,00},;
                 {"CPF___","C",11,00},;
                 {"FONE__","C",12,00},;
                 {"E_MAIL","C",60,00},;
                 {"COMIVV","N",05,02},;
                 {"COMIVP","N",05,02},;
                 {"COMIVR","N",05,02},;
                 {"COMIVT","N",05,02},;
                 {"TIPO__","C",01,00},;
                 {"SELECT","C",03,00}}
        dbcreate(_VPB_VENDEDOR,aStrut)
   case nDBF==_COD_COMPER
        Mensagem( "Criando arquivo de % de comissoes, aguarde...")
        aStrut:={{"CODIGO","N",02,00},;
                 {"DESCRI","C",20,00},;
                 {"PERC__","N",06,02},;
                 {"VLR___","N",16,02}}
        dbcreate(_VPB_COMPER,aStrut)
   case nDBF==_COD_COMFORMULA
        Mensagem( "Criando arquivo de Formulas de comissoes, aguarde...")
        aStrut:={{"CODIGO","N",02,00},;
                 {"DESCRI","C",20,00}}
        dbcreate(_VPB_COMFORMULA,aStrut)
   case nDBF==_COD_COMFAUX
        Mensagem( "Criando arquivo de Formulas de comissoes, aguarde...")
        aStrut:={{"CODIGO","N",02,00},;
                 {"DESCRI","C",20,00},;
                 {"GRUPO_","N",03,00},;
                 {"PRECO_","N",03,00},;
                 {"FORMA_","N",04,00},;
                 {"INTERN","N",02,00},;
                 {"FORMAI","C",02,00},;
                 {"EXTERN","N",02,00},;
                 {"FORMAE","C",02,00},;
                 {"BASESB","C",02,00},;
                 {"DATA__","D",08,00}}
        dbcreate(_VPB_COMFAUX,aStrut)
   case nDBF==_COD_COMISSAO
        Mensagem( "Criando arquivo de comissoes de vendedores, aguarde...")
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODNF_","N",09,00},;
                 {"VENDE_","N",04,00},;
                 {"CODMV_","N",04,00},;
                 {"DESCRI","C",40,00},;
                 {"FORMUL","N",03,00},;
                 {"TABCND","N",03,00},;
                 {"SITUA_","C",10,00},;
                 {"DTDISP","D",08,00},;
                 {"DTQUIT","D",08,00},;
                 {"DTBAIX","D",08,00},;
                 {"VALOR_","N",16,02},;
                 {"VLRBAS","N",16,02},;
                 {"VLRDSP","N",16,02},;
                 {"VLRPAG","N",16,02},;
                 {"VLRPAR","N",16,02},;
                 {"VLRPEN","N",16,02},;
                 {"PERC__","N",06,03},;
                 {"FORMUL","N",02,00},;
                 {"TABCND","N",04,00},;
                 {"NFNULA","C",01,00},;
                 {"CODDUP","N",10,00},;
                 {"TOTAL_","N",16,02},;
                 {"PGTO__","C",03,00},;
                 {"PEDIDO","N",16,00},;
                 {"VENCIM","D",08,00}}
        dbcreate(_VPB_COMISSAO,aStrut)
   case nDBF==_COD_COMISAUX
        Mensagem( "Criando arquivo de auxiliar de comissoes, aguarde..." )
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODNF_","N",09,00},;
                 {"VENDE_","N",04,00},;
                 {"CODPRO","C",12,00},;
                 {"VLRBAS","N",16,02},;
                 {"PRCMVV","N",06,02},;
                 {"PRCMVP","N",06,02},;
                 {"VALOR_","N",16,02},;
                 {"DESCRI","C",45,00}}
        DBCreate( _VPB_COMISAUX, aStrut )
   case nDBF==_COD_OC
        Mensagem( "Criando arquivo de ordem de compra, aguarde...")
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"ORDCMP","C",05,00},;
                 {"PAGINA","C",04,00},;
                 {"CONTR_","C",01,00},;
                 {"SITUAC","C",30,00},;
                 {"DATAEM","D",08,00},;
                 {"RESP__","C",45,00},;
                 {"COMPRA","C",28,00},;
                 {"CODFOR","N",04,00},;
                 {"DESFOR","C",45,00},;
                 {"ENDERE","C",35,00},;
                 {"CODCEP","C",08,00},;
                 {"CIDADE","C",30,00},;
                 {"ESTADO","C",02,00},;
                 {"FONE__","C",12,00},;
                 {"FAX___","C",12,00},;
                 {"CONTAT","C",30,00},;
                 {"CODTRA","N",03,00},;
                 {"DESTRA","C",20,00},;
                 {"FONTRA","C",12,00},;
                 {"CONDIC","C",15,00},;
                 {"REAJUS","C",33,00},;
                 {"TFRETE","C",01,00},;
                 {"PERICM","N",06,02},;
                 {"SUBTOT","N",16,02},;
                 {"VLRFRE","N",16,02},;
                 {"VLRIPI","N",16,02},;
                 {"TOTAL_","N",16,02},;
                 {"OBSER1","C",70,00},;
                 {"OBSER2","C",70,00},;
                 {"OBSER3","C",70,00},;
                 {"OBSER4","C",70,00},;
                 {"NOTA__","C",90,00},;
                 {"OBICM1","C",50,00},;
                 {"OBICM2","C",50,00},;
                 {"TAXAF_","N",16,02},;
                 {"LOCALE","C",50,00},;
                 {"LOCALC","C",50,00},;
                 {"NFIS01","N",06,00},;
                 {"NFIS02","N",06,00},;
                 {"NFIS03","N",06,00},;
                 {"NFIS04","N",06,00},;
                 {"NFIS05","N",06,00},;
                 {"NFIS06","N",06,00},;
                 {"NFIS07","N",06,00},;
                 {"NFIS08","N",06,00},;
                 {"NFIS09","N",06,00},;
                 {"NFIS10","N",06,00},;
                 {"NFIS11","N",06,00},;
                 {"NFIS12","N",06,00},;
                 {"NFIS13","N",06,00},;
                 {"NFIS14","N",06,00},;
                 {"NFIS15","N",06,00},;
                 {"NFIS16","N",06,00},;
                 {"NFIS17","N",06,00},;
                 {"NFIS18","N",06,00},;
                 {"NFIS19","N",06,00},;
                 {"NFIS20","N",06,00},;
                 {"OK____","C",01,00},;
                 {"REPDES","C",30,00},;
                 {"REPCON","C",30,00},;
                 {"REPFON","C",12,00}}
       dbcreate(_VPB_OC,aStrut)
   case nDBF==_COD_OC_AUXILIA
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"ORDCMP","C",05,00},;
                 {"PAGINA","C",04,00},;
                 {"ITEM__","N",03,00},;
                 {"CODPRO","C",12,00},;
                 {"DESPRO","C",40,00},;
                 {"UNIDAD","C",02,00},;
                 {"PRECOU","N",16,03},;
                 {"CODICM","N",01,00},;
                 {"QUANT_","N",12,03},;
                 {"TOTAL_","N",16,03},;
                 {"PERIPI","N",06,02},;
                 {"VLRIPI","N",16,02},;
                 {"BASICM","N",16,02},;
                 {"PERICM","N",06,02},;
                 {"VLRICM","N",16,02},;
                 {"TABELA","N",01,00},;
                 {"TABELB","N",01,00},;
                 {"RECEBI","N",12,03},;
                 {"SDOREC","N",12,03},;
                 {"ENTREG","D",08,00},;
                 {"OK____","C",01,00},;
                 {"URECEB","D",08,00},;
                 {"CLAFIS","N",03,00}}
        dbcreate(_VPB_OC_AUXILIA,aStrut)
   case nDBF==_COD_FORNECEDOR
        Mensagem( "Criando arquivo para cadastro de Fornecedores, aguarde...")
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODIGO","N",04,00},;
                 {"DESCRI","C",45,00},;
                 {"ENDERE","C",35,00},;
                 {"BAIRRO","C",25,00},;
                 {"CIDADE","C",30,00},;
                 {"ESTADO","C",02,00},;
                 {"CODCEP","C",08,00},;
                 {"PAIS__","C",20,00},;
                 {"E_MAIL","C",55,00},;
                 {"FONEN_","N",01,00},;
                 {"FONE1_","C",12,00},;
                 {"FONE2_","C",12,00},;
                 {"FONE3_","C",12,00},;
                 {"FONE4_","C",12,00},;
                 {"TELEX_","C",12,00},;
                 {"FAX___","C",12,00},;
                 {"CGCMF_","C",14,00},;
                 {"INSCRI","C",12,00},;
                 {"VENDED","C",40,00},;
                 {"RESPON","C",40,00},;
                 {"DATACD","D",08,00},;
                 {"SELECT","C",03,00},;
                 {"TIPO__","C",01,00},;
                 {"ANTPOS","C",01,00},;
                 {"REPDES","C",30,00},;
                 {"REPCON","C",30,00},;
                 {"REPFON","C",12,00},;
                 {"SALDO_","N",16,02}}
        dbcreate(_VPB_FORNECEDOR,aStrut)
   case nDBF==_COD_FERIADOS
        aStrut:={{"DIA___","C",02,00},;
                 {"MES___","C",02,00},;
                 {"DESCRI","C",40,00}}
        DbCreate(_VPB_FERIADOS,aStrut)
   case nDBF==_COD_ESTADO
        aStrut:={{"ESTADO","C",02,00},;
                 {"DESCRI","C",30,03},;
                 {"PERCON","N",06,02},;
                 {"PERIND","N",06,02}}
        DbCreate(_VPB_ESTADO,aStrut)
   case nDBF==_COD_HISTORICO
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",30,00},;
                 {"VALORP","N",16,02},;
                 {"VALORT","N",16,02},;
                 {"NLANC_","N",06,00}}
        DBCreate(_VPB_HISTORICO,aStrut)
   case nDBF==_COD_AGENCIA
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",30,00},;
                 {"GERADM","C",30,00},;
                 {"GERFIN","C",30,00},;
                 {"FONES_","C",30,00},;
                 {"CONTAT","C",30,00},;
                 {"BANCO_","N",03,00},;
                 {"ENDERE","C",35,00},;
                 {"CIDADE","C",30,00},;
                 {"ESTADO","C",02,00},;
                 {"CODCEP","C",08,00},;
                 {"NUMERO","C",10,00}}
        DBCreate(_VPB_AGENCIA,aStrut)
   case nDBF==_COD_CONTA
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",30,00},;
                 {"AGENC_","N",03,00},;
                 {"DATA__","D",08,00},;
                 {"CONTA_","C",20,00},;
                 {"CODCED","C",20,00}}
        DBCreate(_VPB_CONTA,aStrut)
   case nDBF==_COD_GRUPO
        aStrut:={{"CODIGO","C",03,00},;
                 {"DESCRI","C",100,00},;
                 {"DESMAX","N",16,03},;
                 {"DATA__","D",08,00},;
                 {"MAXIMO","N",06,00},;
                 {"MARG_A","N",10,03},;
                 {"MARG_B","N",10,03},;
                 {"MARG_C","N",10,03},;
                 {"MARG_D","N",10,03},;
                 {"SELECT","C",03,00}}
        DBCreate(_VPB_GRUPO,aStrut)
   case nDBF==_COD_REDUCAO
        aStrut:={{"CODIGO","C",02,00},;
                 {"DESCRI","C",30,00},;
                 {"OBSERV","C",40,00},;
                 {"PERRED","N",12,04}}
        DBCreate(_VPB_REDUCAO,aStrut)
   case nDBF==_COD_REDAUX
        aStrut:={{"CODIGO","C",02,00},;
                 {"PERICM","N",06,02},;
                 {"ECF__C","C",02,00},;
                 {"ECF__I","C",02,00},;
                 {"PERRDc","N",12,04},;
                 {"PERRDi","N",12,04},;
                 {"OBSERV","C",40,00}}
        DBCreate(_VPB_REDAUX,aStrut)
   case nDBF==_COD_SETORES
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"OBSERV","C",55,00},;
                 {"CODFOR","N",04,00},;
                 {"CODCLI","N",06,00},;
                 {"CODEMP","N",03,00},;
                 {"TIPTAB","N",02,00},;
                 {"BSCCLI","C",01,00},;
                 {"BSCFOR","C",01,00},;
                 {"BSCEMP","C",01,00}}
        DBCreate(_VPB_SETORES,aStrut)
   case nDBF==_COD_CORES
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",30,00}}
        DBCreate(_VPB_CORES,aStrut)
   case nDBF==_COD_CLASSES
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"TAMA00","C",10,00},;
                 {"TAMA01","C",10,00},;
                 {"TAMA02","C",10,00},;
                 {"TAMA03","C",10,00},;
                 {"TAMA04","C",10,00},;
                 {"TAMA05","C",10,00},;
                 {"TAMA06","C",10,00},;
                 {"TAMA07","C",10,00},;
                 {"TAMA08","C",10,00},;
                 {"TAMA09","C",10,00},;
                 {"TAMA10","C",10,00},;
                 {"TAMA10","C",10,00},;
                 {"TAMA11","C",10,00},;
                 {"TAMA12","C",10,00},;
                 {"TAMA13","C",10,00},;
                 {"TAMA14","C",10,00},;
                 {"TAMA15","C",10,00},;
                 {"TAMA16","C",10,00},;
                 {"TAMA17","C",10,00},;
                 {"TAMA18","C",10,00},;
                 {"TAMA19","C",10,00},;
                 {"TAMA20","C",10,00},;
                 {"CODAUX","N",03,00}}
        DBCreate(_VPB_CLASSES,aStrut)
   case nDBF==_COD_PCPESTO
        aStrut:={{"CPROD_","C",12,00},;
                 {"CODRED","C",12,00},;
                 {"ENTSAI","C",01,00},;
                 {"QUANT_","N",12,03},;
                 {"DOC___","C",15,00},;
                 {"CODIGO","N",06,00},;
                 {"VLRSDO","N",16,02},;
                 {"VLRSAI","N",16,02},;
                 {"VLRICM","N",16,02},;
                 {"VALOR_","N",16,02},;
                 {"TOTAL_","N",16,02},;
                 {"DATAMV","D",08,00},;
                 {"RESPON","N",03,00},;
                 {"ANULAR","C",01,00},;
                 {"PERICM","N",06,02},;
                 {"PERIPI","N",06,02},;
                 {"VLRIPI","N",16,02},;
                 {"VLRFRE","N",16,02},;
                 {"NATOPE","N",06,03},;
                 {"CUSMED","N",16,04},;
                 {"CODMV_","N",03,00},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},;
                 {"PCPCOR","N",03,00},;
                 {"TRASET","C",01,00},; // Transferencia entre setores (S/N)
                 {"CODSET","N",03,00},; // Transferencia entre setores (Codigo)
                 {"CUSATU","N",16,04}}
                  /* Valor ICMs mercadoria ref. neg. */
                  /* Valor desta entrada/saida */
                  /* Valor + ICMs */
                  /* Data de lancamento */
        dbcreate(_VPB_PCPESTO,aStrut)
   case nDBF==_COD_PCPMOVI
        aStrut:={{"CODIGO","N",006,00},;
                 {"DESCRI","C",_ESP_DESCRICAO,00},;
                 {"SITPER","N",003,00},;
                 {"DATINI","D",008,00},;
                 {"DATFIN","D",008,00},;
                 {"EMITEN","C",020,00},;
                 {"ENCARR","C",020,00},;
                 {"OBSERV","C",120,00},;
                 {"CODPED","C",008,00},;
                 {"CODCLI","N",006,00},;
                 {"DESCLI","C",040,00}}
        dbcreate(_VPB_PCPMOVI,aStrut)
   case nDBF==_COD_PCPRELA
        aStrut:={{"CODIGO","N",06,00},;
                 {"CODPRO","C",12,00},;
                 {"CODCOR","N",03,00},;
                 {"QUAT00","N",12,03},;
                 {"QUAT01","N",12,03},;
                 {"QUAT02","N",12,03},;
                 {"QUAT03","N",12,03},;
                 {"QUAT04","N",12,03},;
                 {"QUAT05","N",12,03},;
                 {"QUAT06","N",12,03},;
                 {"QUAT07","N",12,03},;
                 {"QUAT08","N",12,03},;
                 {"QUAT09","N",12,03},;
                 {"QUAT10","N",12,03},;
                 {"QUAT10","N",12,03},;
                 {"QUAT11","N",12,03},;
                 {"QUAT12","N",12,03},;
                 {"QUAT13","N",12,03},;
                 {"QUAT14","N",12,03},;
                 {"QUAT15","N",12,03},;
                 {"QUAT16","N",12,03},;
                 {"QUAT17","N",12,03},;
                 {"QUAT18","N",12,03},;
                 {"QUAT19","N",12,03},;
                 {"QUAT20","N",12,03}}
        dbcreate(_VPB_PCPRELA,aStrut)
   case nDBF==_COD_PDVEAN
        aStrut:={{"CODIGO","C",13,00},; // Codigo EAN Interno
                 {"CODPRO","C",12,00},; // Codigo Produto
                 {"PCPCLA","N",03,00},; // Codigo Classificacao
                 {"PCPTAM","N",02,00},; // Codigo Tamanho
                 {"PCPCOR","N",03,00},; // Codigo Cor
                 {"CODEAN","C",13,00},; // Codigo EAN Fabrica
                 {"SALDO_","N",16,05},; // Saldo Fisico de Estoque
                 {"EMBAL_","N",16,05},; // Embalagem Padrao
                 {"QTDMIN","N",16,05},; // Quantidade Minima
                 {"QTDMAX","N",16,05}}  // Quantidade Maxima
        dbcreate(_VPB_PDVEAN,aStrut)
   case nDBF==_COD_CTRLBANC
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"CODCON","N",05,00},; // Codigo de Convenio
                 {"NOMEMP","C",20,00},; // Nome da Empresa
                 {"CODBAN","N",03,00},; // Codigo do Banco
                 {"NOMBAN","C",20,00},; // Nome do Banco
                 {"IDECLI","C",25,00},; // Identificao do Cliente na Empresa
                 {"CONTAC","N",10,00},; // Conta Corrente
                 {"DATOPC","D",08,00},; // Data da Opcao
                 {"CODMOE","C",02,00},; // Codigo da Moeda
                 {"CODRET","C",02,00},; // Codigo de Retorno
                 {"TIPCOD","C",01,00},; // 1=CGC  2=CPF
                 {"CGCCPF","C",14,00},; // CGC ou CPF
                 {"IDECON","C",25,00},; // Identificao do Consumidor na Empresa
                 {"NOMCON","C",40,00},; // Nome do Consumidor
                 {"CIDCON","C",30,00},; // Cidade do Consumidor
                 {"ESTCON","C",02,00},; // Estado do Consumidor
                 {"ENDAGE","C",30,00},; // Endereco da Agencia
                 {"NUMAGE","C",05,00},; // Numero da Agencia
                 {"CEPAGE","C",05,00},; // CEP da Agencia
                 {"SUFCEP","C",03,00},; // Sufixo do CEP da Agencia
                 {"CIDAGE","C",20,00},; // Cidade da Agencia
                 {"ESTAGE","C",02,00},; // Estado da Agencia
                 {"SITAGE","C",01,00},; // Situacao da Agencia
                 {"NUMDUP","N",10,00},; // Numero da Duplicata
                 {"SEQDUP","C",01,00},; // Sequencia da Duplicata
                 {"DATVEN","D",08,00},; // Data do Vencimento
                 {"VALDEB","N",15,02},; // Valor do Debito Original/Parcela
                 {"VALORI","N",15,02},; // Valor do Debito Somente Original
                 {"MULTA_","N",06,02},; // %Multa
                 {"CORMON","N",06,02},; // %Correcao Monetaria
                 {"VALPAR","N",15,02},; // Valor Maximo para Parcela
                 {"CODCLI","N",06,00},; // Codigo do Cliente
                 {"CTAREC","N",03,00},; // Codigo da Conta Corrente de Receptacao
                 {"CODMOV","N",01,00},; // Codigo do Movimento
                 {"CODREG","C",01,00},; // Codigo do Registro
                 {"CADTIP","C",01,00},; // Tipo do Cadastramento (2=INCLUSAO 1=EXCLUSAO)
                 {"SITRET","C",02,00},; // Situacao (Criada na Importacao cfe. Codigo Retorno)
                 {"SITUAC","C",45,00},; // Situacao da Cobranca (Remessa/Retorno)
                 {"SELEC_","C",03,00},; // ("Nao"=NAO VAI) ("Sim"=VAI SIM)
                 {"CODIGO","C",10,00},; // Codigo de Identificacao da Duplicata
                 {"SUBCOD","C",02,00},; // Sub-Codigo (Indica a Divisao de parcelas Ex 01,02,03,04,...)
                 {"JAENVI","C",03,00}}  // ("Nao"=NAO FOI) ("Sim"=JA FOI)
        dbcreate(_VPB_CTRLBANC,aStrut)
   case nDBF==_COD_GUARDIAO
        aStrut:={{"MODULO","C",100,00},;
                 {"DATA__","D",08,00},;
                 {"TIME__","C",08,00},;
                 {"USERN_","N",03,00}}
        DBCreate(_VPB_GUARDIAO,aStrut)
   case nDBF==_COD_TELA
        aStrut:={{"TELA__","M",10,00},;
                 {"USERN_","N",03,00}}
        DBCreate(_VPB_TELA,aStrut)
   case nDBF==_COD_BLOQUETO
        aStrut:={{"FILIAL","N",03,00},;
                 {"CODFIL","N",06,00},;
                 {"SEQUE_","N",08,00},;
                 {"TIPTIT","C",03,00},;
                 {"DOCUM_","C",10,00},;
                 {"BANCO_","N",03,00},;
                 {"AGENCI","N",03,00},;
                 {"CONTA_","N",03,00},;
                 {"CODCLI","N",06,00},;
                 {"DESCRI","C",45,00},;
                 {"ULTEMI","D",08,00},;
                 {"ULTVCT","D",08,00},;
                 {"GERAR_","N",02,00},;
                 {"VALOR_","N",16,02},;
                 {"REAJUS","N",10,03},;
                 {"CODH01","N",03,00},;
                 {"HIST01","C",30,00},;
                 {"VLR_01","N",12,02},;
                 {"CODH02","N",03,00},;
                 {"HIST02","C",30,00},;
                 {"VLR_02","N",12,02},;
                 {"CODH03","N",03,00},;
                 {"HIST03","C",30,00},;
                 {"VLR_03","N",12,02},;
                 {"CODH04","N",03,00},;
                 {"HIST04","C",30,00},;
                 {"VLR_04","N",12,02},;
                 {"CODH05","N",03,00},;
                 {"HIST05","C",30,00},;
                 {"VLR_05","N",12,02},;
                 {"CODH06","N",03,00},;
                 {"HIST06","C",30,00},;
                 {"VLR_06","N",12,02},;
                 {"CODH07","N",03,00},;
                 {"HIST07","C",30,00},;
                 {"VLR_07","N",12,02},;
                 {"CODH08","N",03,00},;
                 {"HIST08","C",30,00},;
                 {"VLR_08","N",12,02},;
                 {"CODH09","N",03,00},;
                 {"HIST09","C",30,00},;
                 {"VLR_09","N",12,02},;
                 {"CODH10","N",03,00},;
                 {"HIST10","C",30,00},;
                 {"VLR_10","N",12,02},;
                 {"EMISS_","D",08,00},;
                 {"VENC__","D",08,00},;
                 {"DUPLIC","C",10,00},;
                 {"NOSSON","C",25,00},;
                 {"CODCED","C",20,00},;
                 {"JUROS_","N",16,02},;
                 {"CTAPGT","N",03,00},;
                 {"DTQUIT","D",08,00},;
                 {"CHEQUE","C",10,00},;
                 {"LOCAL_","C",25,00},;
                 {"LOCPGT","N",03,00},;
                 {"MANUAL","N",01,00},;
                 {"MARCA_","C",01,00}}
        DBCreate(_VPB_BLOQUETO,aStrut)
   case nDBF==_COD_BLOPROG
        aStrut:={{"TIPTIT","C",03,00},;
                 {"DOCUM_","C",10,00},;
                 {"BANCO_","N",03,00},;
                 {"AGENCI","N",03,00},;
                 {"CONTA_","N",03,00},;
                 {"CODCLI","N",06,00},;
                 {"DESCRI","C",45,00},;
                 {"ULTEMI","D",08,00},;
                 {"ULTVCT","D",08,00},;
                 {"GERAR_","N",02,00},;
                 {"VALOR_","N",16,02},;
                 {"REAJUS","N",10,03},;
                 {"CODH01","N",03,00},;
                 {"HIST01","C",25,00},;
                 {"VLR_01","N",12,02},;
                 {"CODH02","N",03,00},;
                 {"HIST02","C",25,00},;
                 {"VLR_02","N",12,02},;
                 {"CODH03","N",03,00},;
                 {"HIST03","C",25,00},;
                 {"VLR_03","N",12,02},;
                 {"CODH04","N",03,00},;
                 {"HIST04","C",25,00},;
                 {"VLR_04","N",12,02},;
                 {"CODH05","N",03,00},;
                 {"HIST05","C",25,00},;
                 {"VLR_05","N",12,02},;
                 {"CODH06","N",03,00},;
                 {"HIST06","C",25,00},;
                 {"VLR_06","N",12,02},;
                 {"CODH07","N",03,00},;
                 {"HIST07","C",25,00},;
                 {"VLR_07","N",12,02},;
                 {"CODH08","N",03,00},;
                 {"HIST08","C",25,00},;
                 {"VLR_08","N",12,02},;
                 {"CODH09","N",03,00},;
                 {"HIST09","C",25,00},;
                 {"VLR_09","N",12,02},;
                 {"CODH10","N",03,00},;
                 {"HIST10","C",25,00},;
                 {"VLR_10","N",12,02},;
                 {"EMISS_","D",08,00},;
                 {"VENC__","D",08,00},;
                 {"DUPLIC","C",10,00},;
                 {"NOSSON","C",25,00},;
                 {"CODCED","C",20,00},;
                 {"DTQUIT","D",08,00},;
                 {"CHEQUE","C",10,00},;
                 {"LOCAL_","C",25,00},;
                 {"LOCPGT","N",03,00}}
        DBCreate(_VPB_BLOPROG,aStrut)
   case nDBF==_COD_FLUXOCAIXA
        aStrut:={{"DATAPG","D",08,00},;
                 {"VENCIM","D",08,00},;
                 {"CLIFOR","C",40,00},;
                 {"HISTOR","C",50,00},;
                 {"DEBCRE","C",01,00},;
                 {"VALOR_","N",16,02},;
                 {"JUROS_","N",16,02}}
        DBCreate( _VPB_FLUXOCAIXA, aStrut )
   case nDBF==_COD_SERVICO
        aStrut:={{"CODIGO","C",12,00},;
                 {"DESCRI","C",40,00},;
                 {"SUBCTA","C",04,00},;
                 {"VALORP","N",16,02},;
                 {"SALDOA","N",16,02},;
                 {"DEBITO","N",16,02},;
                 {"CREDIT","N",16,02},;
                 {"SALDO_","N",16,02},;
                 {"CUSEXE","N",16,02}}
        DBCreate(_VPB_SERVICO,aStrut)
   case nDBF==_COD_CRITERIO
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"V____A","N",10,00},;
                 {"V____B","N",10,00},;
                 {"V____C","N",10,00},;
                 {"V____D","N",10,00},;
                 {"V____E","N",10,00},;
                 {"V_DATA","D",08,00},;
                 {"Q____A","N",10,00},;
                 {"Q____B","N",10,00},;
                 {"Q____C","N",10,00},;
                 {"Q____D","N",10,00},;
                 {"Q____E","N",10,00},;
                 {"Q_DATA","D",08,00},;
                 {"F____A","N",10,00},;
                 {"F____B","N",10,00},;
                 {"F____C","N",10,00},;
                 {"F____D","N",10,00},;
                 {"F____E","N",10,00},;
                 {"F_DATA","D",08,00},;
                 {"T____A","N",10,00},;
                 {"T____B","N",10,00},;
                 {"T____C","N",10,00},;
                 {"T____D","N",10,00},;
                 {"T____E","N",10,00},;
                 {"T_DATA","D",08,00},;
                 {"P____A","N",10,00},;
                 {"P____B","N",10,00},;
                 {"P____C","N",10,00},;
                 {"P____D","N",10,00},;
                 {"P____E","N",10,00},;
                 {"P_DATA","D",08,00}}
        DBCreate( _VPB_CRITERIO, aStrut )

   case nDBF==_COD_GARANTIA
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"OBSERV","C",55,00},;
                 {"GARANT","N",06,00},;
                 {"VALIDA","N",06,00}}
        DBCreate( _VPB_GARANTIA, aStrut )

   case nDBf==_COD_ROMANEIO
        aStrut:={{"CODPRO","C",12,00},;
                 {"ROMANE","C",100,00},;
                 {"INTEXT","C",01,00},;
                 {"DATSAI","D",08,00},;
                 {"DATENT","D",08,00},;
                 {"SELECT","C",01,00},;
                 {"CODNF_","N",09,00},;
                 {"CODCUP","N",09,00}}
        DBCreate( _VPB_ROMANEIO, aStrut )
                 /* Romaneio de Entrada/Saida de produtos */
                 /* IntExt=I/E Codificacao Interna ou Externa */
                 /* DatEnt=Data de Entrada */
                 /* DatSai=Empty()=>Nao Saiu */
                 /* Select=Trata a selecao do item */

   OTHERWISE
endcase
return NIL

/*
Funcao      - FDBUSEVPB
Parametros  - nDBF => Codigo do banco de dados a ser aberto.
            - nMODO => 2>Multi-usuario, 1>Mono-usuario
              nIndexMod => Modo de reindexacao
              lIndexForce => Forca uma reindexacao
Finalidade  - Abertura de um arquivo de banco de dados.
Programador - Valmor Pereira Flores
Data        - 01/Fevereiro/1994
Atualizacao - 18/Outubro/1994
*/
FUNCTION fdbusevpb( nDBF, nMODO, nIndexMod, lIndexForce )
Local cRDDDefault:= RDDSetDefault()

Static nNumero
nModo:= IF( nModo==Nil, 2, nModo )
nNumero:= IF( nNumero==Nil, 0, nNumero+1 )
lIndexForce:= IF( lIndexForce == Nil, .F., lIndexForce )
IF nNumero==0
   cCorRes:= SetColor( "15/01" )
   Scroll( 24, 15, 24, 79 )
   SetColor( cCorRes )
ELSEIF nNumero >= 65
   nNumero:= -1
ELSE
   @ 24,00 Say "∞∞±±±≤≤≤≤≤≤≤≤≤≤" Color "15/01"
   @ 24,15 Say Repl( "∞", nNumero ) + "  " + Repl( "€", 63 - nNumero ) Color "07/03"
ENDIF
/* Seleciona Area que foi passada como parametro */
DBSelectAr( nDBF )
IF Used()
   DBSetOrder( 1 )
   DBGoTop()
   Return .T.
ENDIF


/* Abertura dos arquivos */
do case
   case nDBF==_COD_ATEND
        If NetUse( _VPB_ATEND, ( nModo==1 ), 1, "ATD", .F. )
           Mensagem( "Conectando ao arquivo de Atendimento..." )
           If !File( M->GDir-"\ATDIND01.NTX" ) .OR. !File( M->GDir-"\ATDIND02.NTX" ) .OR.;
              !File( M->GDir-"\ATDIND03.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ad1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/atdind01.ntx"
              #else
                Index On CODIGO Tag AD1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\ATDIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codcfe tag ad2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/atdind02.ntx"
              #else
                Index On CODCFE Tag AD2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\ATDIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag ad3 eval {|| if( nindexmod <> nil, indexterm(,3), .t.) } to "&gdir/atdind03.ntx"
              #else
                Index On DESCRI Tag AD3 Eval {|| If( nIndexMod <> NIL, IndexTerm(,3), .T.) } To "&Gdir\ATDIND03.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/atdind01.ntx", "&gdir/atdind02.ntx", "&gdir/atdind03.ntx"
           #else
             Set Index To "&Gdir\ATDIND01.NTX", "&Gdir\ATDIND02.NTX", "&Gdir\ATDIND03.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_VARIACOES
        If NetUse( _VPB_VARIACOES, ( nModo==1 ), 1, "VAR", .F. )
           Mensagem( "Conectando ao arquivo de Variacoes de moedas/indices, aguarde..." )
           If !File( M->GDir-"\VARIND01.NTX" ) .OR. !File( M->GDir-"\VARIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag fl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/varind01.ntx"
              #else
                Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\VARIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on data__ tag fl2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/varind02.ntx"
              #else
                Index On DATA__ Tag FL2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\VARIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/varind01.ntx", "&gdir/varind02.ntx"
           #else
             Set Index To "&Gdir\VARIND01.NTX", "&Gdir\VARIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_CRITERIO
        If NetUse( _VPB_CRITERIO, ( nModo==1 ), 1, "CRI", .F. )
           Mensagem( "Conectando ao Arquivo de Criterios, aguarde..." )
           If !File( M->GDir-"\CRIIND01.NTX" ) .OR. !File( M->GDir-"\CRIIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag fl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/criind01.ntx"
              #else
                Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CRIIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag fl2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/criind02.ntx"
              #else
                Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CRIIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/criind01.ntx", "&gdir/criind02.ntx"
           #else
             Set Index To "&Gdir\CRIIND01.NTX", "&Gdir\CRIIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_MOEDAS
        If NetUse( _VPB_MOEDAS, ( nModo==1 ), 1, "MOE", .F. )
           Mensagem( "Conectando ao arquivo de moedas, aguarde..." )
           If !File( M->GDir-"\MOEIND01.NTX" ) .OR. !File( M->GDir-"\MOEIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag moe eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/moeind01.ntx"
              #else
                Index On CODIGO Tag MOE Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\MOEIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on sigla_ tag moe eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/moeind02.ntx"
              #else
                Index On SIGLA_ Tag MOE Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\MOEIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/moeind01.ntx", "&gdir/moeind02.ntx"
           #else
             Set Index To "&Gdir\MOEIND01.NTX", "&Gdir\MOEIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_ATENDAUX
        If NetUse( _VPB_ATENDAUX, ( nModo==1 ), 1, "ATA", .F. )
           Mensagem( "Conectando ao arquivo de Atendimento Auxiliar..." )
           If !File( M->GDir-"\ATAIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ata1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/ataind01.ntx"
              #else
                Index On CODIGO Tag ATA1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\ATAIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ataind01.ntx"
           #else
             Set Index To "&Gdir\ATAIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_OPERACOES
        If NetUse( _VPB_OPERACOES, ( nModo==1 ), 1, "OPE", .F. )
           Mensagem( "Conectando ao arquivo de Operacoes de Movimento de Estoque..." )
           If !File( M->GDir-"\OPEIND01.NTX" ) .OR. !File( M->GDir-"\OPEIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag sr1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/opeind01.ntx"
              #else
                Index On CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\OPEIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag sr2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/opeind02.ntx"
              #else
                Index On DESCRI Tag SR2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\OPEIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/opeind01.ntx", "&gdir/opeind02.ntx"
           #else
             Set Index To "&Gdir\OPEIND01.Ntx", "&Gdir\OPEIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_GARANTIA
        If NetUse( _VPB_GARANTIA, ( nModo==1 ), 1, "GAR", .F. )
           Mensagem( "Conectando ao arquivo de Garantia/Validade..." )
           If !File( M->GDir-"\GARIND01.NTX" ) .OR. !File( M->GDir-"\GARIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag gr1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/garind01.ntx"
              #else
                Index On CODIGO Tag GR1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\GARIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag gr2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/garind02.ntx"
              #else
                Index On DESCRI Tag GR2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\GARIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/garind01.ntx", "&gdir/garind02.ntx"
           #else
             Set Index To "&Gdir\GARIND01.Ntx", "&Gdir\GARIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CONDICOES
        If NetUse( _VPB_CONDICOES, ( nModo==1 ), 1, "CND", .F. )
           Mensagem( "Conectando ao arquivo de Tabela de Condicoes..." )
           If !File( M->GDir-"\CNDIND01.NTX" ) .OR. !File( M->GDir-"\CNDIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag sr1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/cndind01.ntx"
              #else
                Index On CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CNDIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag sr2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/cndind02.ntx"
              #else
                Index On DESCRI Tag SR2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CNDIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cndind01.ntx", "&gdir/cndind02.ntx"
           #else
             Set Index To "&Gdir\CNDIND01.Ntx", "&Gdir\CNDIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_DETALHE
        If NetUse( _VPB_DETALHE, ( nModo==1 ), 1, "DET", .F. )
           Mensagem( "Conectando ao arquivo de Tabela de Detalhes..." )
           If !File( M->GDir-"\DETIND01.NTX" ) .or. !File( M->GDir-"\DETIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codped + indice + str( ordem_, 3 )              tag dt1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/detind01.ntx"
              #else
                Index On CODPED + INDICE + STR( ORDEM_, 3 )              Tag DT1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\DETIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codped                                          tag dt2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/detind02.ntx"
              #else
                Index On CODPED                                          Tag DT2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\DETIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/detind01.ntx", "&gdir/detind02.ntx"
           #else
             Set Index To "&Gdir\DETIND01.Ntx", "&Gdir\DETIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_DETNOTA
        If NetUse( _VPB_DETNOTA, ( nModo==1 ), 1, "D_N", .F. )
           Mensagem( "Conectando ao arquivo de Tabela de Detalhes / Notas..." )
           If !File( M->GDir-"\D_NIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on str( codnf_, 6 ) + indice + str( ordem_, 3 )    tag dt1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/d_nind01.ntx"
              #else
                Index On STR( CODNF_, 6 ) + INDICE + STR( ORDEM_, 3 )    Tag DT1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\D_NIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/d_nind01.ntx"
           #else
             Set Index To "&Gdir\D_NIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_MIDIA
        If NetUse( _VPB_MIDIA, ( nModo==1 ), 1, "MID", .F. )
           Mensagem( "Conectando ao arquivo de Tabela de Midias/Tipos de Contatos.." )
           If !File( M->GDir-"\MIDIND01.NTX" ) .OR. !File( M->GDir-"\MIDIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag md1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/midind01.ntx"
              #else
                Index On CODIGO Tag MD1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\MIDIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag md2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/midind02.ntx"
              #else
                Index On DESCRI Tag MD2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\MIDIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/midind01.ntx", "&gdir/midind02.ntx"
           #else
             Set Index To "&Gdir\MIDIND01.Ntx", "&Gdir\MIDIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_SERVICO
        If NetUse( _VPB_SERVICO, ( nModo==1 ), 1, "SER", .F. )
           Mensagem( "Conectando ao arquivo de servicos, aguarde..." )
           If !File( M->GDir-"\SERIND01.NTX" ) .OR. !File( M->GDir-"\SERIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on subcta + codigo tag sr1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/serind01.ntx"
              #else
                Index On SUBCTA + CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\SERIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag sr2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/serind02.ntx"
              #else
                Index On CODIGO Tag SR2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\SERIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/serind01.ntx", "&gdir/serind02.ntx"
           #else
             Set Index To "&Gdir\SERIND01.Ntx", "&Gdir\SERIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ROMANEIO
        IF NetUse( _VPB_ROMANEIO, ( nModo==1 ), 1, "ROM", .F. )
           IF !File( M->GDir-"\ROMIND01.NTX" ) .OR.;
              !File( m->GDir-"\ROMIND02.NTX" ) .OR.;
              !File( m->GDir-"\ROMIND03.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codpro tag ro1 eval {|| if( nindexmod <> nil, indexterm(,1), .t. ) } to "&gdir/romind01.ntx"
              #else
                Index On CODPRO Tag RO1 Eval {|| IF( nIndexMod <> Nil, IndexTerm(,1), .T. ) } To "&Gdir\ROMIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on romane tag ro2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/romind02.ntx"
              #else
                Index On ROMANE Tag RO2 Eval {|| IF( nIndexMod <> Nil, IndexTerm(,2), .T. ) } To "&Gdir\ROMIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_ tag ro3 eval {|| if( nindexmod <> nil, indexterm(,3), .t. ) } to "&gdir/romind03.ntx"
              #else
                Index On CODNF_ Tag RO3 Eval {|| IF( nIndexMod <> Nil, IndexTerm(,3), .T. ) } To "&Gdir\ROMIND03.NTX"
              #endif
           ENDIF

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/romind01.ntx", "&gdir/romind02.ntx", "&gdir/romind03.ntx"
           #else
             Set Index to "&Gdir\ROMIND01.Ntx", "&Gdir\ROMIND02.Ntx", "&Gdir\ROMIND03.NTX"
           #endif
        ELSE
           DBCloseArea()
        ENDIF

   case nDBF==_COD_ATALHO
        IF NetUse( _VPB_ATALHO, ( nModo==1 ), 1, "ATL", .F. )

        ELSE

           DBCloseArea()

        EndIf

   case nDBF==_COD_BLOQUETO
        If NetUse( _VPB_BLOQUETO, ( nModo==1 ), 1, "BLO", .F. )
           Mensagem( "Conectando ao arquivo de bloquetos, aguarde..." )
           If !File( M->GDir-"\BLOIND01.NTX" ) .OR. !File( M->GDir-"\BLOIND02.NTX" ) .OR.;
              !File( M->GDir-"\BLOIND03.NTX" ) .OR. !File( M->GDir-"\BLOIND04.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on venc__ tag at1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/bloind01.ntx"
              #else
                Index On VENC__ Tag At1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\BLOIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on duplic tag at2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/bloind02.ntx"
              #else
                Index On DUPLIC Tag At2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\BLOIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on seque_ tag at3 eval {|| if( nindexmod <> nil, indexterm(,3), .t.) } to "&gdir/bloind03.ntx"
              #else
                Index On SEQUE_ Tag At3 Eval {|| If( nIndexMod <> NIL, IndexTerm(,3), .T.) } To "&Gdir\BLOIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on marca_ tag at4 eval {|| if( nindexmod <> nil, indexterm(,4), .t.) } to "&gdir/bloind04.ntx"
              #else
                Index On MARCA_ Tag At4 Eval {|| If( nIndexMod <> NIL, IndexTerm(,4), .T.) } To "&Gdir\BLOIND04.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/bloind01.ntx", "&gdir/bloind02.ntx", "&gdir/bloind03.ntx", "&gdir/bloind04.ntx"
           #else
             Set Index To "&Gdir\BLOIND01.Ntx", "&Gdir\BLOIND02.Ntx", "&Gdir\BLOIND03.Ntx", "&Gdir\BLOIND04.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_FLUXOCAIXA
        If NetUse( _VPB_FLUXOCAIXA, ( nModo==1 ), 1, "FLU", .F. )
           Mensagem( "Conectando ao arquivo de bloquetos, aguarde..." )
           If !File( M->GDir-"\FLUIND01.NTX" ) .OR. !File( M->GDir-"\FLUIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on datapg tag fl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/fluind01.ntx"
              #else
                Index On DATAPG Tag FL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\FLUIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on vencim tag fl2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/fluind02.ntx"
              #else
                Index On VENCIM Tag FL2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\FLUIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/fluind01.ntx", "&gdir/fluind02.ntx"
           #else
             Set Index To "&Gdir\FLUIND01.Ntx", "&Gdir\FLUIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_COMPER
        If NetUse( _VPB_COMPER, ( nModo==1 ), 1, "CP_", .F. )
           Mensagem( "Conectando ao  de % comissoes, aguarde..." )
           If !File( M->GDir-"\CP_IND01.NTX" ) .OR. !File( M->GDir-"\CP_IND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag fl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/cp_ind01.ntx"
              #else
                Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CP_IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag fl2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/cp_ind02.ntx"
              #else
                Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CP_IND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cp_ind01.ntx", "&gdir/cp_ind02.ntx"
           #else
             Set Index To "&Gdir\CP_IND01.Ntx", "&Gdir\CP_IND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMFORMULA
        If NetUse( _VPB_COMFORMULA, ( nModo==1 ), 1, "FML", .F. )
           Mensagem( "Conectando ao  de % comissoes, aguarde..." )
           If !File( M->GDir-"\CF_IND01.NTX" ) .OR. !File( M->GDir-"\CF_IND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag fl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/cf_ind01.ntx"
              #else
                Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CF_IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag fl2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/cf_ind02.ntx"
              #else
                Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CF_IND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cf_ind01.ntx", "&gdir/cf_ind02.ntx"
           #else
             Set Index To "&Gdir\CF_IND01.Ntx", "&Gdir\CF_IND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMFAUX
        If NetUse( _VPB_COMFAUX, ( nModo==1 ), 1, "CA_", .F. )
           Mensagem( "Conectando ao  de % comissoes, aguarde..." )
           If !File( M->GDir-"\CA_IND01.NTX" ) .OR. !File( M->GDir-"\CA_IND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag fl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/ca_ind01.ntx"
              #else
                Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CA_IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag fl2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/ca_ind02.ntx"
              #else
                Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CA_IND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ca_ind01.ntx", "&gdir/ca_ind02.ntx"
           #else
             Set Index To "&Gdir\CA_IND01.Ntx", "&Gdir\CA_IND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_GUARDIAO
        If NetUse( _VPB_GUARDIAO, ( nModo==1 ), 1, "VPF", .F. )
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_REDUCAO
        If NetUse( _VPB_REDUCAO, ( nModo==1 ), 1, "RED", .F. )
           Mensagem( "Conectando ao arquivo de REDUCAO DE ICMs, aguarde..." )
           If !File( M->GDir-"\REDIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag cx eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/redind01.ntx"
              #else
                Index On Codigo Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\REDIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/redind01.ntx"
           #else
             Set Index To "&Gdir\REDIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_REDAUX
        If NetUse( _VPB_REDAUX, ( nModo==1 ), 1, "RDA", .F. )
           Mensagem( "Conectando ao arquivo de REDUCAO DE ICMs (AUXILIAR), aguarde..." )
           If !File( M->GDir-"\RDAIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag cx eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/rdaind01.ntx"
              #else
                Index On Codigo Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\RDAIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/rdaind01.ntx"
           #else
             Set Index To "&Gdir\RDAIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_SETORES
        If NetUse( _VPB_SETORES, ( nModo==1 ), 1, "SET", .F. )
           Mensagem( "Conectando ao  o arquivo de SETORES, aguarde ..." )
           If !File( M->GDir-"\SETIND01.NTX" ) .OR. !File( M->GDir-"\SETIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag st eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/setind01.ntx"
              #else
                Index On CODIGO Tag ST Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\SETIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag st eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/setind02.ntx"
              #else
                Index On DESCRI Tag ST Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\SETIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/setind01.ntx", "&gdir/setind02.ntx"
           #else
             Set Index To "&Gdir\SETIND01.Ntx", "&Gdir\SETIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CORES
        If NetUse( _VPB_CORES, ( nModo==1 ), 1, "COR", .F. )
           Mensagem( "Conectando ao  o arquivo de CORES, aguarde ..." )
           If !File( M->GDir-"\CORIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag st eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/corind01.ntx"
              #else
                Index On Codigo Tag ST Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CORIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/corind01.ntx"
           #else
             Set Index To "&Gdir\CORIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CLASSES
        If NetUse( _VPB_CLASSES, ( nModo==1 ), 1, "CLA", .F. )
           Mensagem( "Conectando ao  o arquivo de CLASSES, aguarde ..." )
           If !File( M->GDir-"\CLAIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag st eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/claind01.ntx"
              #else
                Index On Codigo Tag ST Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CLAIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/claind01.ntx"
           #else
             Set Index To "&Gdir\CLAIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PCPESTO
        If NetUse( _VPB_PCPESTO, ( nModo==1 ), 1, "PCE", .F. )
           Mensagem( "Conectando ao arquivo de controle de ESTOQUE PCP, aguarde...")
           If !File( M->GDir-"\PCEIND01.NTX") .OR. !File( M->GDir-"\PCEIND02.NTX") .OR.;
              !File( M->GDir-"\PCEIND03.NTX") .OR. !File( M->GDir-"\PCEIND04.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cprod_ tag pe1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/pceind01.ntx"
              #else
                Index On CPROD_ Tag PE1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} To "&Gdir\PCEIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on datamv tag pe2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/pceind02.ntx"
              #else
                Index On DATAMV Tag PE2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} To "&Gdir\PCEIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on doc___ tag pe3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/pceind03.ntx"
              #else
                Index On DOC___ Tag PE3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} To "&Gdir\PCEIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on doc___ + str( codmv_, 2, 0 ) + str( codigo, 6, 0 ) + entsai  to "&gdir/pceind04.ntx"
              #else
                Index On DOC___ + Str( CODMV_, 2, 0 ) + Str( CODIGO, 6, 0 ) + ENTSAI  To "&Gdir\PCEIND04.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pceind01.ntx", "&gdir/pceind02.ntx", "&gdir/pceind03.ntx", "&gdir/pceind04.ntx"
           #else
             Set Index To "&Gdir\PCEIND01.Ntx", "&Gdir\PCEIND02.Ntx", "&Gdir\PCEIND03.Ntx", "&Gdir\PCEIND04.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PCPMOVI
        If NetUse( _VPB_PCPMOVI, ( nModo==1 ), 1, "PCM", .F. )
           Mensagem( "Conectando ao  o arquivo de Movimento PCP, aguarde ..." )
           If !File( M->GDir-"\PCMIND01.NTX" ) .OR. ;
              !File( M->GDir-"\PCMIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag pc1 eval {|| if( nindexmod <> nil, ;
                   indexterm(,1), .t.) } to "&gdir/pcmind01.ntx"
              #else
                Index On CODIGO Tag PC1 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,1), .T.) } To "&Gdir\PCMIND01.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag pc2 eval {|| if( nindexmod <> nil, ;
                   indexterm(,2), .t.) } to "&gdir/pcmind02.ntx"
              #else
                Index On DESCRI Tag PC2 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,2), .T.) } To "&Gdir\PCMIND02.NTX"

              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pcmind01.ntx", "&gdir/pcmind02.ntx"
           #else
             Set Index To "&Gdir\PCMIND01.Ntx", "&Gdir\PCMIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PCPRELA
        If NetUse( _VPB_PCPRELA, ( nModo==1 ), 1, "PCL", .F. )
           Mensagem( "Conectando ao  o arquivo de Produtos Relacionados PCP, aguarde ..." )
           If !File( M->GDir-"\PCLIND01.NTX" ) .OR. ;
              !File( M->GDir-"\PCLIND02.NTX" ) .OR. ;
              !File( M->GDir-"\PCLIND03.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag pclx1 eval {|| if( nindexmod <> nil, ;
                   indexterm(,1), .t.) } to "&gdir/pclind01.ntx"
              #else
                Index On CODIGO Tag PCLX1 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,1), .T.) } To "&Gdir\PCLIND01.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on str (codigo, 6) + codpro + str (codcor, 2) tag pclx2 ;
                   eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to ;
                   "&gdir/pclind02.ntx"
              #else
                Index On STR (CODIGO, 6) + CODPRO + STR (CODCOR, 2) Tag PCLX2 ;
                   Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To ;
                   "&Gdir\PCLIND02.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codpro + str (codigo, 6) + str (codcor, 2) tag pclx3 ;
                   eval {|| if( nindexmod <> nil, indexterm(,3), .t.) } to ;
                   "&gdir/pclind03.ntx"
              #else
                Index On CODPRO + STR (CODIGO, 6) + STR (CODCOR, 2) Tag PCLX3 ;
                   Eval {|| If( nIndexMod <> NIL, IndexTerm(,3), .T.) } To ;
                   "&Gdir\PCLIND03.NTX"

              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pclind01.ntx", "&gdir/pclind02.ntx", ;
                          "&gdir/pclind03.ntx"
           #else
             Set Index To "&Gdir\PCLIND01.Ntx", "&Gdir\PCLIND02.Ntx", ;
                          "&Gdir\PCLIND03.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_PDVEAN
        If NetUse( _VPB_PDVEAN, ( nModo==1 ), 1, "EAN", .F. )
           Mensagem( "Conectando ao  o arquivo de Correspondencias EAN, aguarde ..." )
           If !File( M->GDir-"\EANIND01.NTX" ) .OR. ;
              !File( M->GDir-"\EANIND02.NTX" ) .OR. ;
              !File( M->GDir-"\EANIND03.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag eanx1 ;
                   eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } ;
                   to "&gdir/eanind01.ntx"
              #else
                Index On CODIGO Tag EANX1 ;
                   Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } ;
                   To "&Gdir\EANIND01.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codean + codpro + str (pcpcla, 3) + str (pcptam, 2) + ;
                         str (pcpcor, 3) tag eanx2 ;
                   eval {|| if( nindexmod <> nil, indexterm(,2), .t.) }  to "&gdir/eanind02.ntx"
              #else
                Index On CODEAN + CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                         STR (PCPCOR, 3) Tag EANX2 ;
                   Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) }  To "&Gdir\EANIND02.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codpro + str (pcpcla, 3) + str (pcptam, 2) + ;
                         str (pcpcor, 3) tag eanx1 ;
                   eval {|| if( nindexmod <> nil, indexterm(,3), .t.) }  to "&gdir/eanind03.ntx"
              #else
                Index On CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                         STR (PCPCOR, 3) Tag EANX1 ;
                   Eval {|| If( nIndexMod <> NIL, IndexTerm(,3), .T.) }  To "&Gdir\EANIND03.NTX"

              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/eanind01.ntx", "&gdir/eanind02.ntx", ;
                          "&gdir/eanind03.ntx"
           #else
             Set Index To "&Gdir\EANIND01.Ntx", "&Gdir\EANIND02.Ntx", ;
                          "&Gdir\EANIND03.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CTRLBANC
        If NetUse( _VPB_CTRLBANC, ( nModo==1 ), 1, "CTB", .F. )
           Mensagem( "Conectando ao  o Arquivo de Controle Bancario, aguarde ..." )
           If !File( M->GDir-"\CTBIND01.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND02.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND03.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND04.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND05.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on idecli tag ctbx1 eval {|| if( nindexmod <> nil, ;
                   indexterm(,1), .t.) } to "&gdir/ctbind01.ntx"
              #else
                Index On IDECLI Tag CTBX1 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,1), .T.) } To "&Gdir\CTBIND01.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on datven tag ctbx2 eval {|| if( nindexmod <> nil, ;
                   indexterm(,2), .t.) } to "&gdir/ctbind02.ntx"
              #else
                Index On DATVEN Tag CTBX2 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,2), .T.) } To "&Gdir\CTBIND02.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on situac tag ctbx3 eval {|| if( nindexmod <> nil, ;
                   indexterm(,3), .t.) } to "&gdir/ctbind03.ntx"
              #else
                Index On SITUAC Tag CTBX3 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,3), .T.) } To "&Gdir\CTBIND03.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on jaenvi tag ctbx4 eval {|| if( nindexmod <> nil, ;
                   indexterm(,4), .t.) } to "&gdir/ctbind04.ntx"
              #else
                Index On JAENVI Tag CTBX4 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,4), .T.) } To "&Gdir\CTBIND04.NTX"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ctbx5 eval {|| if( nindexmod <> nil, ;
                   indexterm(,5), .t.) } to "&gdir/ctbind05.ntx"
              #else
                Index On CODIGO Tag CTBX5 Eval {|| If( nIndexMod <> NIL, ;
                   IndexTerm(,5), .T.) } To "&Gdir\CTBIND05.NTX"

              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ctbind01.ntx", "&gdir/ctbind02.ntx", ;
                          "&gdir/ctbind03.ntx", "&gdir/ctbind04.ntx", ;
                          "&gdir/ctbind05.ntx"
           #else
             Set Index To "&Gdir\CTBIND01.Ntx", "&Gdir\CTBIND02.Ntx", ;
                          "&Gdir\CTBIND03.Ntx", "&Gdir\CTBIND04.Ntx", ;
                          "&Gdir\CTBIND05.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_SIMILAR
        IF NetUse( _VPB_SIMILAR, ( nModo==1 ), 1, "SIM", .F. )
           Mensagem( "Conectando ao arquivo de Similaridade, aguarde..." )
           If !File( M->GDir-"\SIMIND01.NTX" ) .OR. !File( M->GDir-"\SIMIND02.NTX" ) .OR.;
              !File( M->GDir-"\SIMIND03.NTX" ) .OR. !File( M->GDir-"\SIMIND04.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codig1 tag cx eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/simind01.ntx"
              #else
                Index On Codig1 Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\SIMIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codig2 tag cx eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/simind02.ntx"
              #else
                Index On Codig2 Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\SIMIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on comp01 tag cx eval {|| if( nindexmod <> nil, indexterm(,3), .t.) } to "&gdir/simind03.ntx"
              #else
                Index On COMP01 Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,3), .T.) } To "&Gdir\SIMIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on comp02 tag cx eval {|| if( nindexmod <> nil, indexterm(,4), .t.) } to "&gdir/simind04.ntx"
              #else
                Index On COMP02 Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,4), .T.) } To "&Gdir\SIMIND04.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/simind01.ntx", "&gdir/simind02.ntx", "&gdir/simind03.ntx", "&gdir/simind04.ntx"
           #else
             Set Index To "&Gdir\SIMIND01.Ntx", "&Gdir\SIMIND02.Ntx", "&Gdir\SIMIND03.Ntx", "&Gdir\SIMIND04.NTX"
           #endif
        ELSE
           DBCloseArea()
        ENDIF
   case nDBF==_COD_TELA
        If NetUse( _VPB_TELA, ( nModo==1 ), 1, "VPT", .F. )
           Mensagem( "Conectando ao arquivo de telas, aguarde..." )
           If !File( M->GDir-"\TELIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on usern_ tag tl1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/telind01.ntx"
              #else
                Index On USERN_ Tag TL1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\TELIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/telind01.ntx"
           #else
             Set Index To "&Gdir\TELIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDbf==_COD_CAIXA
        If NetUse( _VPB_CAIXA, ( nModo==1 ), 1, "CX_", .F. )
           Mensagem( "Conectando ao arquivo de fluxo de caixa, aguarde..." )
           If !File( M->GDir-"\CX_IND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on datamv tag cx eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/cx_ind01.ntx"
              #else
                Index On DATAMV Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CX_IND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cx_ind01.ntx"
           #else
             Set Index To "&Gdir\CX_IND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TABPRECO
        If NetUse( _VPB_TABPRECO, ( nModo==1 ), 1, "PRE", .F. )
           Mensagem( "Conectando ao arquivo de Precos diferenciados, aguarde..." )
           If !File( M->GDir-"\TPRIND01.NTX" ) .AND. !File( M->GDir-"\TPRIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag tp eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/tprind01.ntx"
              #else
                Index On CODIGO Tag TP Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\TPRIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag tp eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/tprind02.ntx"
              #else
                Index On DESCRI Tag TP Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\TPRIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/tprind01.ntx", "&gdir/tprind02.ntx"
           #else
             Set Index To "&Gdir\TPRIND01.Ntx", "&Gdir\TPRIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TABROTAS
        If NetUse( _VPB_TABROTAS, ( nModo==1 ), 1, "ROT", .F. )
           Mensagem( "Conectando ao arquivo de Rotas, aguarde..." )
           If !File( M->GDir-"\ROTIND01.NTX" ) .AND. !File( M->GDir-"\ROTIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag tp eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/rotind01.ntx"
              #else
                Index On CODIGO Tag TP Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\ROTIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag tp eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/rotind02.ntx"
              #else
                Index On DESCRI Tag TP Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\ROTIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/rotind01.ntx", "&gdir/rotind02.ntx"
           #else
             Set Index To "&Gdir\ROTIND01.Ntx", "&Gdir\ROTIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TABAUX
        If NetUse( _VPB_TABAUX, ( nModo==1 ), 1, "TAX", .F. )
           Mensagem( "Conectando ao arquivo de Precos diferenciados (AUXILIAR), aguarde..." )
           If !File( M->GDir-"\TAXIND01.NTX" ) .AND. !File( M->GDir-"\TAXIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag tp eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/taxind01.ntx"
              #else
                Index On CODIGO Tag TP Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\TAXIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codpro tag tp eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/taxind02.ntx"
              #else
                Index On CODPRO Tag TP Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\TAXIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/taxind01.ntx", "&gdir/taxind02.ntx"
           #else
             Set Index To "&Gdir\TAXIND01.Ntx", "&Gdir\TAXIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_MOVIMENTO
        If NetUse( _VPB_MOVIMENTO, ( nModo==1 ), 1, "MOV", .F. )
           Mensagem( "Conectando ao arquivo de movimento financeiro, aguarde..." )
           If !File( M->GDir-"\MOVIND01.NTX" ) .AND. !File( M->GDir-"\MOVIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on data__ tag mv eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/movind01.ntx"
              #else
                Index On DATA__ Tag MV Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\MOVIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on nconta tag mv eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/movind02.ntx"
              #else
                Index On NCONTA Tag MV Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\MOVIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/movind01.ntx", "&gdir/movind02.ntx"
           #else
             Set Index To "&Gdir\MOVIND01.Ntx", "&Gdir\MOVIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDbf==_COD_CAIXAAUX
        If NetUse( _VPB_CAIXAAUX, ( nModo==1 ), 1, "CXA", .F. )
           Mensagem( "Conectando ao arquivo de fluxo de caixa (auxiliar), aguarde..." )
           If !File( M->GDir-"\CXAIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on datamv tag cx eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/cxaind01.ntx"
              #else
                Index On DATAMV Tag CX Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CXAIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cxaind01.ntx"
           #else
             Set Index To "&Gdir\CXAIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_GRUPO
        If NetUse( _VPB_GRUPO, ( nModo==1 ), 1, "GR0", .F. )
           Mensagem( "Conectando ao arquivo de grupo de produtos, aguarde..." )
           If !File( M->GDir-"\GR0IND01.NTX" ) .OR. !File( M->GDir-"\GR0IND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag gr1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/gr0ind01.ntx"
              #else
                Index On CODIGO Tag GR1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\GR0IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag gr2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/gr0ind02.ntx"
              #else
                Index On DESCRI Tag GR2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\GR0IND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/gr0ind01.ntx", "&gdir/gr0ind02.ntx"
           #else
             Set Index To "&Gdir\GR0IND01.Ntx", "&Gdir\GR0IND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_BLOPROG
        If NetUse( _VPB_BLOPROG, ( nModo==1 ), 1, "BLP", .F. )
           Mensagem( "AbrINDo arquivo de bloquetos programados, aguarde..." )
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_AGENCIA
        If NetUse( _VPB_AGENCIA, ( nModo==1 ), 1, "AGE", .F. )
           Mensagem( "Conectando ao arquivo de agencias, aguarde..." )
           If !File( M->GDir-"\AGEIND01.NTX" ) .OR. !File( M->GDir-"\AGEIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ag1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/ageind01.ntx"
              #else
                Index On Codigo Tag AG1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\AGEIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag ag2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/ageind02.ntx"
              #else
                Index On Descri Tag AG2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\AGEIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ageind01.ntx", "&gdir/ageind02.ntx"
           #else
             Set Index To "&Gdir\AGEIND01.Ntx", "&Gdir\AGEIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CONTA
        If NetUse( _VPB_CONTA, ( nModo==1 ), 1, "CON", .F. )
           Mensagem( "Conectando ao arquivo de contas, aguarde..." )
           If !File( M->GDir-"\CONIND01.NTX" ) .OR. !File( M->GDir-"\CONIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ctc1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/conind01.ntx"
              #else
                Index On Codigo Tag CTC1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CONIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag ctc2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/conind02.ntx"
              #else
                Index On Descri Tag CTC2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CONIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/conind01.ntx", "&gdir/conind02.ntx"
           #else
             Set Index To "&Gdir\CONIND01.Ntx", "&Gdir\CONIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_HISTORICO
        If NetUse( _VPB_HISTORICO, ( nModo==1 ), 1, "His", .F. )
           Mensagem( "Conectando ao arquivo de hist¢ricos, aguarde..." )
           If !File( M->GDir-"\HISIND01.NTX" ) .OR. !File( M->GDir-"\HISIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag hs1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/hisind01.ntx"
              #else
                Index On Codigo Tag HS1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\HISIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag hs2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/hisind02.ntx"
              #else
                Index On Descri Tag HS2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\HISIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/hisind01.ntx", "&gdir/hisind02.ntx"
           #else
             Set Index To "&Gdir\HISIND01.Ntx", "&Gdir\HISIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ASSEMBLER
        If NetUse( _VPB_ASSEMBLER, ( nModo==1 ), 1, "Asm", .F. )
           Mensagem( "Conectando ao arquivo de montagem, aguarde..." )
           If !File( M->GDir-"\ASMIND01.NTX" ) .OR. !File( M->GDir-"\ASMIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codprd tag mp1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/asmind01.ntx"
              #else
                Index On CodPrd Tag MP1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\ASMIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codmpr tag mp2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/asmind02.ntx"
              #else
                Index On CodMpr Tag MP2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\ASMIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/asmind01.ntx", "&gdir/asmind02.ntx"
           #else
             Set Index To "&Gdir\ASMIND01.Ntx", "&Gdir\ASMIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_NATOPERA
        If NetUse( _VPB_NATOPERA, ( nModo==1 ), 1, "CFO", .F. )
           Mensagem( "Conectando ao arquivo de Natureza da Operacao, aguarde..." )
           If !File( M->GDir-"\CFOIND01.NTX" ) .OR. !File( M->GDir-"\CFOIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag no1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/cfoind01.ntx"
              #else
                Index On Codigo Tag NO1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\CFOIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag no2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/cfoind02.ntx"
              #else
                Index On Descri Tag NO2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\CFOIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cfoind01.ntx", "&gdir/cfoind02.ntx"
           #else
             Set Index To "&Gdir\CFOIND01.Ntx", "&Gdir\CFOIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ATIVIDADES
        If NetUse( _VPB_ATIVIDADES, ( nModo==1 ), 1, "Atv", .F. )
           Mensagem( "Conectando ao arquivo de codigos de atividades, aguarde..." )
           If !File( M->GDir-"\AtvIND01.NTX" ) .OR. !File( M->GDir-"\AtvIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag tt1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/atvind01.ntx"
              #else
                Index On Codigo Tag TT1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\AtvIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri tag tt2 eval {|| if( nindexmod <> nil, indexterm(,2), .t.) } to "&gdir/atvind02.ntx"
              #else
                Index On Descri Tag TT2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T.) } To "&Gdir\AtvIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/atvind01.ntx", "&gdir/atvind02.ntx"
           #else
             Set Index To "&Gdir\ATVIND01.Ntx", "&Gdir\ATVIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ORIGEM
        If NetUse( _VPB_ORIGEM, ( nModo==1 ), 1, "Org", .F. )
           Mensagem( "Conectando ao arquivo de origens, aguarde..." )
           If !File( M->GDir-"\ORIGEM01.NTX") .or.;
              !File( M->GDir-"\ORIGEM02.NTX") .or.;
              !File( M->GDir-"\ORIGEM03.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag or1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir./origem01.ntx"
              #else
                Index On Codigo Tag OR1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir.\ORIGEM01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag or2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir./origem02.ntx"
              #else
                Index On upper(Descri) Tag OR2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir.\ORIGEM02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codabr tag or3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir./origem03.ntx"
              #else
                Index On CODABR Tag OR3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir.\ORIGEM03.NTX"
              #endif
           EndIF
           //ordListClear()
           //ordListAdd( m->GDir - "\ORIGEM01.ntx" )
           //ordListAdd( m->GDir - "\ORIGEM02.ntx" )
           //ordListAdd( m->GDir - "\ORIGEM03.ntx" )

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/origem01.ntx","&gdir/origem02.ntx","&gdir/origem03.ntx"
           #else
             set index to "&Gdir\ORIGEM01.Ntx","&Gdir\ORIGEM02.Ntx","&Gdir\ORIGEM03.ntx"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ESTADO
        If NetUse( _VPB_ESTADO, ( nModo==1 ), 1, "UF", .F. )
           Mensagem( "Conectando ao arquivo de estados, aguarde..." )
           If !File( "ESTADO01.NTX") .OR. !File( "ESTADO02.NTX" )
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Index On ESTADO Tag ES1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "ESTADO01.NTX"
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
              Index On UPPER( DESCRI ) Tag ES2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "ESTADO02.NTX"
           EndIF
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
           Set Index To "ESTADO01.NTX", "ESTADO02.NTX"
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CREDIARIO
        If NetUse( _VPB_CREDIARIO, ( nModo==1 ), 1, "CCR", .F. )
           Mensagem( "Conectando ao arquivo de CREDIARIOS, aguarde..." )
           If !File( M->GDir-"\CCRIND01.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag cr1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/ccrind01.ntx"
              #else
                Index On Codigo Tag CR1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CCRIND01.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ccrind01.ntx"
           #else
             Set Index To "&Gdir\CCRIND01.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_CLIENTE

        /* Verifica a existencia do arquivo CLIENTES.DBF p/ Compatibilizar com
           sistema controle feito em DELPHI */
        /* Caso exista, utiliza o mesmo                  */
        IF File( StrTran( _VPB_CLIENTE, ".DBF", ".DBF" ) )
           cCliente:= StrTran( _VPB_CLIENTE, ".DBF", ".DBF" )
        ELSE
           cCliente:= _VPB_CLIENTE
        ENDIF

        RDDSetDefault( "DBFNTX" )
        If NetUse( cCliente, ( nModo==1 ), 1, "Cli", .F. )
           Mensagem( "Conectando ao arquivo de clientes, aguarde..." )
           If !File( M->GDir-"\CLIIND01.NTX" ) .or. !File( M->GDir-"\CLIIND02.NTX" ) .OR. ;
              !File( M->GDir-"\CLIIND03.NTX" ) .or. !File( M->GDir-"\CLIIND04.NTX" ) .OR. ;
              !File( M->GDir-"\CLIIND05.NTX" ) .or. !File( M->GDir-"\CLIIND06.NTX" ) .OR.;
              !File( M->GDir-"\CLIIND07.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag cl1                  eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/cliind01"
              #else
                Index On Codigo Tag CL1                  Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CLIIND01"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag cl2           eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/cliind02"
              #else
                Index On upper(Descri) Tag CL2           Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\CLIIND02"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on fantas tag cl3                  eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/cliind03"
              #else
                Index On Fantas Tag CL3                  Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\CLIIND03"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on strzero( filial, 03, 00 ) +;
                         strzero( codfil, 06, 00 ) tag cl4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/cliind04"
              #else
                Index On StrZero( FILIAL, 03, 00 ) +;
                         StrZero( CODFIL, 06, 00 ) Tag CL4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\CLIIND04"

              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codbar tag cl5                  eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/cliind05"
              #else
                Index On CODBAR Tag CL5                  Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\CLIIND05"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on endere tag cl6                  eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/cliind06"
              #else
                Index On ENDERE Tag CL6                  Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\CLIIND06"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on fone1_ tag cl7                  eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/cliind07"
              #else
                Index On FONE1_ Tag CL7                  Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\CLIIND07"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cliind01", "&gdir/cliind02", "&gdir/cliind03", "&gdir/cliind04", "&gdir/cliind05", "&gdir/cliind06", "&gdir/cliind07"
           #else
             Set Index To "&Gdir\CLIIND01", "&Gdir\CLIIND02", "&Gdir\CLIIND03", "&Gdir\CLIIND04", "&Gdir\CLIIND05", "&Gdir\CLIIND06", "&Gdir\CLIIND07"
           #endif
        Else
           DBCloseArea()
        EndIf
        RDDSetDefault( cRDDDefault )

   case nDBF==_COD_CONFIG
        If NetUse( _VPB_CONFIG, ( nModo==1 ), 1, "Cf1", .F. )
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_VENDEDOR
        If NetUse( _VPB_VENDEDOR, ( nModo==1 ), 1, "Ven", .F. )
           Mensagem( "Conectando ao arquivo de vendedores, aguarde..." )
           If !File( M->GDir-"\VENIND01.NTX") .or. !File( M->GDir-"\VENIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag vn1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/venind01.ntx"
              #else
                Index On Codigo Tag VN1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\VENIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag vn2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/venind02.ntx"
              #else
                Index On upper(Descri) Tag VN2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\VENIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/venind01.ntx", "&gdir/venind02.ntx"
           #else
             Set Index To "&Gdir\VENIND01.Ntx", "&Gdir\VENIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMISSAO
        If NetUse( _VPB_COMISSAO, ( nModo==1 ), 1, "Com", .F. )
           Mensagem( "Conectando ao arquivo de comissao, aguarde..." )
           If !File( M->GDir-"\CM_IND01.NTX") .or. !File( M->GDir-"\CM_IND02.NTX") .OR.;
              !File( M->GDir-"\CM_IND03.NTX") .or. !File( M->GDir-"\CM_IND04.NTX") .OR.;
              !File( M->GDir-"\CM_IND05.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on vende_ tag cm1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/cm_ind01.ntx"
              #else
                Index On VENDE_ Tag CM1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CM_IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_ tag cm2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/cm_ind02.ntx"
              #else
                Index On CODNF_ Tag CM2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\CM_IND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on dtdisp tag cm3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/cm_ind03.ntx"
              #else
                Index On DTDISP Tag CM3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\CM_IND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on dtquit tag cm4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/cm_ind04.ntx"
              #else
                Index On DTQUIT Tag CM4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\CM_IND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on vencim tag cm5 eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/cm_ind05.ntx"
              #else
                Index On VENCIM Tag CM5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\CM_IND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cm_ind01.ntx", "&gdir/cm_ind02.ntx", "&gdir/cm_ind03.ntx", "&gdir/cm_ind04.ntx", "&gdir/cm_ind05.ntx"
           #else
             Set Index To "&Gdir\CM_IND01.Ntx", "&Gdir\CM_IND02.Ntx", "&Gdir\CM_IND03.Ntx", "&Gdir\CM_IND04.Ntx", "&Gdir\CM_IND05.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMISAUX
        If NetUse( _VPB_COMISAUX, ( nModo==1 ), 1, "Cm1", .F. )
           Mensagem( "Conectando ao arquivo de comissao, aguarde..." )
           If !File( M->GDir-"\CM1IND01.NTX") .or. !File( M->GDir-"\CM1IND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on vende_ tag c21 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/cm1ind01.ntx"
              #else
                Index On VENDE_ Tag C21 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CM1IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_ tag c22 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/cm1ind02.ntx"
              #else
                Index On CODNF_ Tag C22 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\CM1IND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cm1ind01.ntx", "&gdir/cm1ind02.ntx"
           #else
             Set Index To "&Gdir\CM1IND01.Ntx", "&Gdir\CM1IND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_RECEITAS
        If NetUse( _VPB_RECEITAS, ( nModo==1 ), 1, "REC", .F. )
           Mensagem( "Conectando ao arquivo de fornecedores, aguarde..." )
           If !File( M->GDir-"\RECIND01.NTX") .or. !File( M->GDir-"\RECIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ds1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/recind01.ntx"
              #else
                Index On Codigo Tag DS1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\RECIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag ds2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/recind02.ntx"
              #else
                Index On upper(Descri) Tag DS2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T. ) } To "&Gdir\RECIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/recind01.ntx", "&gdir/recind02.ntx"
           #else
             Set Index To "&Gdir\RECIND01.Ntx", "&Gdir\RECIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_DESPESAS
        If NetUse( _VPB_DESPESAS, ( nModo==1 ), 1, "Des", .F. )
           Mensagem( "Conectando ao arquivo de fornecedores, aguarde..." )
           If !File( M->GDir-"\DESIND01.NTX") .or. !File( M->GDir-"\DESIND02.NTX") .OR.;
              lIndexForce

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ds1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/desind01.ntx"
              #else
                Index On Codigo Tag DS1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\DESIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag ds2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/desind02.ntx"
              #else
                Index On upper(Descri) Tag DS2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T. ) } To "&Gdir\DESIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo to "&gdir/forind01.ntx" for tipo__="1"
              #else
                Index On Codigo to "&Gdir\FORIND01.Ntx" For TIPO__="1"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) to "&gdir/forind02.ntx" for tipo__="1"
              #else
                Index On Upper(Descri) to "&Gdir\FORIND02.Ntx" For TIPO__="1"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/desind01.ntx", "&gdir/desind02.ntx", "&gdir/forind01.ntx", "&gdir/forind02.ntx"
           #else
             Set Index To "&Gdir\DESIND01.Ntx", "&Gdir\DESIND02.Ntx", "&Gdir\FORIND01.Ntx", "&Gdir\FORIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_FORNECEDOR
        If NetUse( _VPB_FORNECEDOR, ( nModo==1 ), 1, "For", .F. )
           Mensagem( "Conectando ao arquivo de fornecedores, aguarde...")
           If !File( M->GDir-"\FORIND01.NTX") .or. !File( M->GDir-"\FORIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo to "&gdir/forind01.ntx" for tipo__="1"
              #else
                Index On Codigo to "&Gdir\FORIND01.Ntx" For TIPO__="1"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) to "&gdir/forind02.ntx" for tipo__="1"
              #else
                Index On Upper(Descri) to "&Gdir\FORIND02.Ntx" For TIPO__="1"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag ds1 eval {|| if( nindexmod <> nil, indexterm(,1), .t.) } to "&gdir/desind01.ntx"
              #else
                Index On Codigo Tag DS1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T.) } To "&Gdir\DESIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag ds2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/desind02.ntx"
              #else
                Index On upper(Descri) Tag DS2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T. ) } To "&Gdir\DESIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/forind01.ntx", "&gdir/forind02.ntx", "&gdir/desind01.ntx", "&gdir/desind02.ntx"
           #else
             Set Index To "&Gdir\FORIND01.Ntx", "&Gdir\FORIND02.Ntx", "&Gdir\DESIND01.Ntx", "&Gdir\DESIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_MPRIMA
        If NetUse( _VPB_MPRIMA, ( nModo==1 ), 1, "MPr", .F. )
           Mensagem( "Conectando ao arquivo de materia prima, aguarde..." )
           If !File( M->GDir-"\MPRIND01.NTX") .OR. !File( M->GDir-"\MPRIND02.NTX") .OR.;
              !File( M->GDir-"\MPRIND03.NTX") .OR. !File( M->GDir-"\MPRIND04.NTX") .OR.;
              !File( M->GDir-"\MPRIND05.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on indice          tag mp1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/mprind01.ntx"
              #else
                Index On Indice          Tag MP1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\MPRIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper( descri ) tag mp2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/mprind02.ntx"
              #else
                Index On upper( Descri ) Tag MP2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\MPRIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codred          tag mp3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/mprind03.ntx"
              #else
                Index On CodRed          Tag MP3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\MPRIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper( codfab ) tag mp4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/mprind04.ntx"
              #else
                Index On upper( CodFab ) Tag MP4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\MPRIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codfor          tag mp5 eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/mprind05.ntx"
              #else
                Index On CodFor          Tag MP5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\MPRIND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/mprind01.ntx", "&gdir/mprind02.ntx", "&gdir/mprind03.ntx", "&gdir/mprind04.ntx", "&gdir/mprind05.ntx"
           #else
             Set Index To "&Gdir\MPRIND01.NTX", "&Gdir\MPRIND02.NTX", "&Gdir\MPRIND03.NTX", "&Gdir\MPRIND04.NTX", "&Gdir\MPRIND05.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PRODNF
        If NetUse( _VPB_PRODNF, ( nModo==1 ), 1, "Pnf", .F. )
           Mensagem( "Conectando ao arquivo de PRODUTOS X NOTA FISCAL, aguarde..." )
           If !File( M->GDir-"\PNFIND01.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND02.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND03.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND04.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND05.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo        tag p1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/pnfind01.ntx"
              #else
                Index On Codigo        Tag P1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\PNFIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag p2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/pnfind02.ntx"
              #else
                Index On upper(Descri) Tag P2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\PNFIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codred        tag p3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/pnfind03.ntx"
              #else
                Index On CODRED        Tag P3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\PNFIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on data__        tag p4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/pnfind04.ntx"
              #else
                Index On DATA__        Tag P4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\PNFIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_        tag p5 eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/pnfind05.ntx"
              #else
                Index On CODNF_        Tag P5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\PNFIND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pnfind01.ntx",;
                          "&gdir/pnfind02.ntx",;
                          "&gdir/pnfind03.ntx",;
                          "&gdir/pnfind04.ntx",;
                          "&gdir/pnfind05.ntx"
           #else
             Set Index To "&Gdir\PNFIND01.Ntx",;
                          "&Gdir\PNFIND02.Ntx",;
                          "&Gdir\PNFIND03.Ntx",;
                          "&Gdir\PNFIND04.Ntx",;
                          "&Gdir\PNFIND05.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PRECOXFORN
        If NetUse( _VPB_PRECOXFORN, ( nModo==1 ), 1, "PXF", .F. )
           Mensagem( "Conectando ao arquivo de precos x fornecedores, aguarde...")
           If !File( M->GDir-"\PXFIND01.NTX") .OR. !File( M->GDir-"\PXFIND02.NTX") .OR. !File(  M->GDir-"\PXFIND03.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cprod_             tag pf1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/pxfind01.ntx"
              #else
                Index On CPROD_             Tag PF1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\PXFIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codfor             tag pf2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/pxfind02.ntx"
              #else
                Index On CODFOR             Tag PF2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\PXFIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on str(codfor)+cprod_ tag pf3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/pxfind03.ntx"
              #else
                Index On STR(CODFOR)+CPROD_ Tag PF3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\PXFIND03.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pxfind01.ntx", "&gdir/pxfind02.ntx", "&gdir/pxfind03.ntx"
           #else
             Set Index To "&Gdir\PXFIND01.Ntx", "&Gdir\PXFIND02.Ntx", "&Gdir\PXFIND03.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PAGAR
        If NetUse( _VPB_PAGAR, ( nModo==1 ), 1, "PAG", .F. )
           Mensagem( "Conectando ao arquivo de contas a pagar, aguarde...")
           If !File( M->GDir-"\PAGIND01.NTX") .OR. !File( M->GDir-"\PAGIND02.NTX") .OR.;
              !File( M->GDir-"\PAGIND03.NTX") .OR. !File( M->GDir-"\PAGIND04.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag pg1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/pagind01.ntx"
              #else
                Index On CODIGO Tag PG1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\PAGIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on doc___ tag pg2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/pagind02.ntx"
              #else
                Index On DOC___ Tag PG2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\PAGIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on vencim tag pg3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/pagind03.ntx"
              #else
                Index On VENCIM Tag PG3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\PAGIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codfor tag pg4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/pagind04.ntx"
              #else
                Index On CODFOR Tag PG4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\PAGIND04.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pagind01.ntx", "&gdir/pagind02.ntx", "&gdir/pagind03.ntx", "&gdir/pagind04.ntx"
           #else
             Set Index To "&Gdir\PAGIND01.Ntx", "&Gdir\PAGIND02.Ntx", "&Gdir\PAGIND03.Ntx", "&Gdir\PAGIND04.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_OBSERVACOES
        If NetUse( _VPB_OBSERVACOES, ( nModo==1 ), 1, "OBS", .F. )
           Mensagem( "Conectando ao arquivo de Observacoes NF, aguarde..." )
           If !File( M->GDir-"\OBSIND01.NTX") .OR. !File( M->GDir-"\OBSIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo           tag dp1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/obsind01.ntx"
              #else
                Index On CODIGO           Tag DP1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\OBSIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri)    tag dp2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/obsind02.ntx"
              #else
                Index On upper(DESCRI)    Tag DP2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\OBSIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/obsind01.ntx", "&gdir/obsind02.ntx"
           #else
             Set Index To "&Gdir\OBSIND01.Ntx", "&Gdir\OBSIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_DUPAUX
        If NetUse( _VPB_DUPAUX, ( nModo==1 ), 1, "DPA", .F. )
           Mensagem( "Conectando ao arquivo de duplicatas auxiliar, aguarde..." )
           If !File( M->GDir-"\DPAIND01.NTX") .OR. !File( M->GDir-"\DPAIND02.NTX") .OR.;
              !File( M->GDir-"\DPAIND03.NTX")  .OR. !File( M->GDir-"\DPAIND04.NTX") .OR.;
              !File( M->GDir-"\DPAIND05.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_ tag dpa1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/dpaind01.ntx"
              #else
                Index On CODNF_ Tag DPA1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\DPAIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on venc__ tag dpa2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/dpaind02.ntx"
              #else
                Index On VENC__ Tag DPA2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\DPAIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag dpa3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/dpaind03.ntx"
              #else
                Index On CODIGO Tag DPA3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\DPAIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cdescr tag dpa4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/dpaind04.ntx"
              #else
                Index On CDESCR Tag DPA4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\DPAIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on client tag dpa5 eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/dpaind05.ntx"
              #else
                Index On CLIENT Tag DPA5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\DPAIND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/dpaind01.ntx", "&gdir/dpaind02.ntx", "&gdir/dpaind03.ntx", "&gdir/dpaind04.ntx", "&gdir/dpaind05.ntx"
           #else
             Set Index To "&Gdir\DPAIND01.Ntx", "&Gdir\DPAIND02.Ntx", "&Gdir\DPAIND03.Ntx", "&Gdir\DPAIND04.Ntx", "&Gdir\DPAIND05.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_NFISCAL
        If NetUse( _VPB_NFISCAL, ( nModo==1 ), 1, "NF_", .F. )
           Mensagem( "Conectando ao arquivo de notas fiscais, aguarde...")
           If !File( M->GDir-"\NFMIND01.NTX") .OR. !File( M->GDir-"\NFMIND02.NTX") .OR.;
              !File( M->GDir-"\NFMIND03.NTX") .OR. !File( M->GDir-"\NFMIND04.NTX") .OR.;
              !File( M->GDir-"\NFMIND05.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on numero tag nf1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/nfmind01.ntx"
              #else
                Index On NUMERO Tag NF1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\NFMIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cdescr tag nf2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/nfmind02.ntx"
              #else
                Index On CDESCR Tag NF2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\NFMIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on dataem tag nf3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/nfmind03.ntx"
              #else
                Index On DATAEM Tag NF3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\NFMIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on pedido tag nf4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/nfmind04.ntx"
              #else
                Index On PEDIDO Tag NF4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\NFMIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on select tag nf5 eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/nfmind05.ntx"
              #else
                Index On SELECT Tag NF5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\NFMIND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/nfmind01.ntx", "&gdir/nfmind02.ntx", "&gdir/nfmind03.ntx",;
                          "&gdir/nfmind04.ntx", "&gdir/nfmind05.ntx"
           #else
             Set Index To "&Gdir\NFMIND01.Ntx", "&Gdir\NFMIND02.Ntx", "&Gdir\NFMIND03.Ntx",;
                          "&Gdir\NFMIND04.Ntx", "&Gdir\NFMIND05.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CUPOM
        If NetUse( _VPB_CUPOM, ( nModo==1 ), 1, "CUP", .F. )
           Mensagem( "Conectando ao arquivo de Cupons Fiscais, aguarde...")
           If !File( M->GDir-"\CUPIND01.NTX") .OR. !File( M->GDir-"\CUPIND02.NTX") .OR.;
              !File( M->GDir-"\CUPIND03.NTX") .OR. !File( M->GDir-"\CUPIND04.NTX") .OR. !File( M->GDir-"\CUPIND05.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on numero tag cf1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/cupind01.ntx"
              #else
                Index On NUMERO Tag CF1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CUPIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cdescr tag cf2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/cupind02.ntx"
              #else
                Index On CDESCR Tag CF2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\CUPIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on dataem tag cf3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/cupind03.ntx"
              #else
                Index On DATAEM Tag CF3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\CUPIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on client tag cf4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/cupind04.ntx"
              #else
                Index On CLIENT Tag CF4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\CUPIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cender tag cf5 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/cupind05.ntx"
              #else
                Index On CENDER Tag CF5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\CUPIND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cupind01.ntx", "&gdir/cupind02.ntx", "&gdir/cupind03.ntx", "&gdir/cupind04.ntx", "&gdir/cupind05.ntx"
           #else
             Set Index To "&Gdir\CUPIND01.Ntx", "&Gdir\CUPIND02.Ntx", "&Gdir\CUPIND03.Ntx", "&Gdir\CUPIND04.Ntx", "&Gdir\CUPIND05.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CUPOMAUX
        If NetUse( _VPB_CUPOMAUX, ( nModo==1 ), 1, "CAU", .F. )
           Mensagem( "Conectando ao arquivo de Produtos x Cupom Fiscal, aguarde..." )
           If !File( M->GDir-"\CAUIND01.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND02.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND03.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND04.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND05.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo        tag caux1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/cauind01.ntx"
              #else
                Index On Codigo        Tag CAUX1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CAUIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag caux2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/cauind02.ntx"
              #else
                Index On upper(Descri) Tag CAUX2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\CAUIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codred        tag caux3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/cauind03.ntx"
              #else
                Index On CODRED        Tag CAUX3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\CAUIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on data__        tag caux4 eval {|| if( nindexmod <>nil, indexterm(,4) ,.t.)} to "&gdir/cauind04.ntx"
              #else
                Index On DATA__        Tag CAUX4 Eval {|| If( nIndexMod <>NIL, IndexTerm(,4) ,.T.)} to "&Gdir\CAUIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_        tag caux5 eval {|| if( nindexmod <>nil, indexterm(,5) ,.t.)} to "&gdir/cauind05.ntx"
              #else
                Index On CODNF_        Tag CAUX5 Eval {|| If( nIndexMod <>NIL, IndexTerm(,5) ,.T.)} to "&Gdir\CAUIND05.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cauind01.ntx",;
                          "&gdir/cauind02.ntx",;
                          "&gdir/cauind03.ntx",;
                          "&gdir/cauind04.ntx",;
                          "&gdir/cauind05.ntx"
           #else
             Set Index To "&Gdir\CAUIND01.Ntx",;
                          "&Gdir\CAUIND02.Ntx",;
                          "&Gdir\CAUIND03.Ntx",;
                          "&Gdir\CAUIND04.Ntx",;
                          "&Gdir\CAUIND05.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_CLASFISCAL
        If NetUse( _VPB_CLASFISCAL, ( nModo==1 ), 1, "CF_", .F. )
           Mensagem( "Conectando ao arquivo de classIficacao fiscal, aguarde..." )
           If !File( M->GDir-"\CFMIND01.NTX") .OR. !File( M->GDir-"\CFMIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo tag cf1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/cfmind01.ntx"
              #else
                Index On Codigo Tag CF1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\CFMIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codfis tag cf2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/cfmind02.ntx"
              #else
                Index On CODFIS Tag CF2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\CFMIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/cfmind01.ntx", "&gdir/cfmind02.ntx"
           #else
             Set Index To "&Gdir\CFMIND01.Ntx", "&Gdir\CFMIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TRANSPORTE
        If NetUse( _VPB_TRANSPORTE, ( nModo==1 ), 1, "TRA", .F. )
           Mensagem( "Conectando ao arquivo de transportadora, aguarde..." )
           If !File( M->GDir-"\TRAIND01.NTX") .OR. !File( M->GDir-"\TRAIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo        tag tr1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/traind01.ntx"
              #else
                Index On Codigo        Tag TR1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\TRAIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri) tag tr2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/traind02.ntx"
              #else
                Index On upper(Descri) Tag TR2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\TRAIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/traind01.ntx", "&gdir/traind02.ntx"
           #else
             Set Index To "&Gdir\TRAIND01.Ntx", "&Gdir\TRAIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_OC
        If NetUse( _VPB_OC, ( nModo==1 ), 1, "OC", .F. )
           Mensagem( "Conectando ao arquivo de ordem de compra, aguarde...")
           If !File( M->GDir-"\OCXIND01.NTX") .OR. !File( M->GDir-"\OCXIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on ordcmp+pagina    tag oc1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/ocxind01.ntx"
              #else
                Index On ORDCMP+PAGINA    Tag OC1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\OCXIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on desfor           tag oc2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/ocxind02.ntx"
              #else
                Index On DESFOR           Tag OC2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\OCXIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on ordcmp           tag oc3 eval {|| if( nindexmod <>nil, indexterm(,3) ,.t.)} to "&gdir/ocxind03.ntx"
              #else
                Index On ORDCMP           Tag OC3 Eval {|| If( nIndexMod <>NIL, IndexTerm(,3) ,.T.)} to "&Gdir\OCXIND03.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ocxind01.ntx", "&gdir/ocxind02.ntx", "&gdir/ocxind03.ntx"
           #else
             Set Index To "&Gdir\OCXIND01.Ntx", "&Gdir\OCXIND02.Ntx", "&Gdir\OCXIND03.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_OC_AUXILIA
        If NetUse( _VPB_OC_AUXILIA, ( nModo==1 ), 1, "OCA", .F. )
           Mensagem( "Conectando ao arquivo de ordem de compra (AUXILIAR), aguarde...")
           If !File( M->GDir-"\OCAIND01.NTX") .OR. !File( M->GDir-"\OCAIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on ordcmp tag oca1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/ocaind01.ntx"
              #else
                Index On ORDCMP Tag OCA1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\OCAIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codpro tag oca2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/ocaind02.ntx"
              #else
                Index On CODPRO Tag OCA2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\OCAIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ocaind01.ntx", "&gdir/ocaind02.ntx"
           #else
             Set Index To "&Gdir\OCAIND01.Ntx", "&Gdir\OCAIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ESTOQUE
        If NetUse( _VPB_ESTOQUE, ( nModo==1 ), 1, "EST", .F. )
           Mensagem( "Conectando ao arquivo de controle de estoque, aguarde...")
           If !File( M->GDir-"\ESTIND01.NTX") .OR. !File( M->GDir-"\ESTIND02.NTX") .OR.;
              !File( M->GDir-"\ESTIND03.NTX") .OR. !File( M->GDir-"\ESTIND04.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on cprod_ tag es1 eval {|| if( nindexmod <> nil, indexterm(,1) ,.t.)} to "&gdir/estind01.ntx"
              #else
                Index On CPROD_ Tag ES1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1) ,.T.)} To "&Gdir\ESTIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on datamv tag es2 eval {|| if( nindexmod <> nil, indexterm(,2) ,.t.)} to "&gdir/estind02.ntx"
              #else
                Index On DATAMV Tag ES2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2) ,.T.)} To "&Gdir\ESTIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on doc___ tag es3 eval {|| if( nindexmod <> nil, indexterm(,3) ,.t.)} to "&gdir/estind03.ntx"
              #else
                Index On DOC___ Tag ES3 Eval {|| If( nIndexMod <> NIL, IndexTerm(,3) ,.T.)} To "&Gdir\ESTIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on doc___ + str( codmv_, 2, 0 ) + str( codigo, 6, 0 ) + entsai  ;
                                tag es4 eval {|| if( nindexmod <> nil, indexterm(,4) ,.t.)} to "&gdir/estind04.ntx"
              #else
                Index On DOC___ + Str( CODMV_, 2, 0 ) + Str( CODIGO, 6, 0 ) + ENTSAI  ;
                                Tag ES4 Eval {|| If( nIndexMod <> NIL, IndexTerm(,4) ,.T.)} To "&Gdir\ESTIND04.NTX"

              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/estind01.ntx", "&gdir/estind02.ntx", "&gdir/estind03.ntx", "&gdir/estind04.ntx"
           #else
             Set Index To "&Gdir\ESTIND01.Ntx", "&Gdir\ESTIND02.Ntx", "&Gdir\ESTIND03.Ntx", "&Gdir\ESTIND04.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_FERIADOS
        If NetUse( _VPB_FERIADOS, ( nModo==1 ), 1, "Fer", .F. )
           Mensagem( "Conectando ao arquivo de feriados, aguarde...")
           If !File( M->GDir-"\FERIND01.NTX") .OR. !File( M->GDir-"\FERIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on mes___+dia___    tag fr1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/ferind01.ntx"
              #else
                Index On MES___+DIA___    Tag FR1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\FERIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri           tag fr2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/ferind02.ntx"
              #else
                Index On Descri           Tag FR2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\FERIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ferind01.ntx", "&gdir/ferind02.ntx"
           #else
             Set Index To "&Gdir\FERIND01.Ntx", "&Gdir\FERIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_BANCO
        If NetUse( _VPB_BANCO, ( nModo==1 ), 1, "Ban", .F. )
           Mensagem( "Conectando ao arquivo de bancos, aguarde...")
           If !File( M->GDir-"\BANIND01.NTX") .OR. !File( M->GDir-"\BANIND02.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo           tag bn1 eval {|| if( nindexmod <>nil, indexterm(,1) ,.t.)} to "&gdir/banind01.ntx"
              #else
                Index On Codigo           Tag BN1 Eval {|| If( nIndexMod <>NIL, IndexTerm(,1) ,.T.)} to "&Gdir\BANIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on upper(descri)    tag bn2 eval {|| if( nindexmod <>nil, indexterm(,2) ,.t.)} to "&gdir/banind02.ntx"
              #else
                Index On upper(Descri)    Tag BN2 Eval {|| If( nIndexMod <>NIL, IndexTerm(,2) ,.T.)} to "&Gdir\BANIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/banind01.ntx", "&gdir/banind02.ntx"
           #else
             Set Index To "&Gdir\BANIND01.Ntx", "&Gdir\BANIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PEDIDO
        If NetUse( _VPB_PEDIDO, ( nModo==1 ), 1, "Ped", .F. )
           Mensagem( "Conectando ao arquivo de COTACOES/PEDIDOS, aguarde..." )
           If !File( M->GDir-"\PEDIND01.NTX" ) .OR. !File( M->GDir-"\PEDIND02.NTX" ) .OR.;
              !File( M->GDir-"\PEDIND03.NTX" ) .OR. !File( M->GDir-"\PEDIND04.NTX" ) .OR.;
              !File( M->GDir-"\PEDIND05.NTX" ) .OR. !File( M->GDir-"\PEDIND06.NTX" ) .OR.;
              !File( M->GDir-"\PEDIND07.NTX" ) .OR. !File( M->GDir-"\PEDIND08.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo                 tag pd1 eval {|| if( nindexmod <> nil, indexterm(,1), .t. ) } to "&gdir/pedind01.ntx"
              #else
                Index On Codigo                 Tag PD1 Eval {|| If( nIndexMod <> Nil, IndexTerm(,1), .T. ) } to "&Gdir\PEDIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on serie_                 tag pd2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/pedind02.ntx"
              #else
                Index On Serie_                 Tag PD2 Eval {|| If( nIndexMod <> Nil, IndexTerm(,2), .T. ) } to "&Gdir\PEDIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codcli                 tag pd3 eval {|| if( nindexmod <> nil, indexterm(,3), .t. ) } to "&gdir/pedind03.ntx"
              #else
                Index On CodCli                 Tag PD3 Eval {|| If( nIndexMod <> Nil, IndexTerm(,3), .T. ) } to "&Gdir\PEDIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri                 tag pd4 eval {|| if( nindexmod <> nil, indexterm(,4), .t. ) } to "&gdir/pedind04.ntx"
              #else
                Index On Descri                 Tag PD4 Eval {|| If( nIndexMod <> Nil, IndexTerm(,4), .T. ) } to "&Gdir\PEDIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_                 tag pd5 eval {|| if( nindexmod <> nil, indexterm(,5), .t. ) } to "&gdir/pedind05.ntx"
              #else
                Index On CodNf_                 Tag PD5 Eval {|| If( nIndexMod <> Nil, IndexTerm(,5), .T. ) } to "&Gdir\PEDIND05.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codped                 tag pd6 eval {|| if( nindexmod <> nil, indexterm(,6), .t. ) } to "&gdir/pedind06.ntx"
              #else
                Index On CodPed                 Tag PD6 Eval {|| If( nIndexMod <> Nil, IndexTerm(,6), .T. ) } to "&Gdir\PEDIND06.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on str( codnf_ ) + codped tag pd7 eval {|| if( nindexmod <> nil, indexterm(,7), .t. ) } to "&gdir/pedind07.ntx"
              #else
                Index On Str( CodNf_ ) + CodPed Tag PD7 Eval {|| If( nIndexMod <> Nil, IndexTerm(,7), .T. ) } to "&Gdir\PEDIND07.NTX"
              #endif

              #ifdef LINUX
                index on IDENT_ tag pd8 eval {|| if( nindexmod <> nil, indexterm(,7), .t. ) } to "&gdir/pedind08.ntx"
              #else
                Index On IDENT_ Tag PD8 Eval {|| If( nIndexMod <> Nil, IndexTerm(,7), .T. ) } to "&Gdir\PEDIND08.NTX"
              #endif


           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pedind01.ntx", "&gdir/pedind02.ntx", "&gdir/pedind03.ntx",;
                          "&gdir/pedind04.ntx", "&gdir/pedind05.ntx", "&gdir/pedind06.ntx", "&gdir/pedind07.ntx" , "&gdir/pedind08.ntx"
           #else
             Set Index To "&Gdir\PEDIND01.Ntx", "&Gdir\PEDIND02.Ntx", "&Gdir\PEDIND03.Ntx",;
                          "&Gdir\PEDIND04.Ntx", "&Gdir\PEDIND05.Ntx", "&Gdir\PEDIND06.Ntx", "&Gdir\PEDIND07.NTX", "&Gdir\PEDIND08.NTX"

           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PEDBAIXA
        If NetUse( _VPB_PEDBAIXA, ( nModo==1 ), 1, "PBX", .F. )
           Mensagem( "Conectando ao arquivo de baixa de pedidos, aguarde..." )
           If !File( M->GDir-"\PB_IND01.NTX" ) .OR.;
              !File( M->GDir-"\PB_IND02.NTX" ) .OR.;
              !File( M->GDir-"\PB_IND03.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codnf_          tag pd1 eval {|| if( nindexmod <> nil, indexterm(,1), .t. ) } to "&gdir/pb_ind01.ntx"
              #else
                Index On CodNf_          Tag PD1 Eval {|| If( nIndexMod <> Nil, IndexTerm(,1), .T. ) } to "&Gdir\PB_IND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo          tag pd2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/pb_ind02.ntx"
              #else
                Index On Codigo          Tag PD2 Eval {|| If( nIndexMod <> Nil, IndexTerm(,2), .T. ) } to "&Gdir\PB_IND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codcli          tag pd3 eval {|| if( nindexmod <> nil, indexterm(,3), .t. ) } to "&gdir/pb_ind03.ntx"
              #else
                Index On CodCli          Tag PD3 Eval {|| If( nIndexMod <> Nil, IndexTerm(,3), .T. ) } to "&Gdir\PB_IND03.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/pb_ind01.ntx", "&gdir/pb_ind02.ntx", "&gdir/pb_ind03.ntx"
           #else
             Set Index To "&Gdir\PB_IND01.Ntx", "&Gdir\PB_IND02.Ntx", "&Gdir\PB_IND03.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_INFOCLI
        If NetUse( _VPB_INFOCLI, ( nModo==1 ), 1, "CLF", .F. )
           Mensagem( "Conectando ao arquivo de Informacoes de clientes..." )
           If !File( M->GDir-"\INFIND01.NTX" ) .OR.;
              !File( M->GDir-"\INFIND02.NTX" )

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo          tag pd1 eval {|| if( nindexmod <> nil, indexterm(,1), .t. ) } to "&gdir/infind01.ntx"
              #else
                Index On CODIGO          Tag PD1 Eval {|| If( nIndexMod <> Nil, IndexTerm(,1), .T. ) } to "&Gdir\INFIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on descri          tag pd1 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/infind02.ntx"
              #else
                Index On DESCRI          Tag PD1 Eval {|| If( nIndexMod <> Nil, IndexTerm(,2), .T. ) } to "&Gdir\INFIND02.NTX"
              #endif
           EndIf

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/infind01.ntx", "&gdir/infind02.ntx"
           #else
             Set Index To "&Gdir\INFIND01.Ntx", "&Gdir\INFIND02.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PEDPROD
        If NetUse( _VPB_PEDPROD, ( nModo==1 ), 1, "PXP", .F. )
           Mensagem( "Conectando ao arquivo de COTACOES/PEDIDOS auxiliar, aguarde...")
           IF !File( M->GDir-"\PPDIND01.NTX") .OR.;
              !File( M->GDir-"\PPDIND02.NTX") .OR.;
              !File( M->GDir-"\PPDIND03.NTX") .OR.;
              !File( M->GDir-"\PPDIND04.NTX") .OR.;
              !File( M->GDir-"\PPDIND05.NTX")

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo          tag pp1 eval {|| if( nindexmod <> nil, indexterm(,1), .t. ) } to "&gdir/ppdind01.ntx"
              #else
                Index On CODIGO          Tag PP1 Eval {|| If( nIndexMod <> NIL, IndexTerm(,1), .T. ) } to "&Gdir\PPDIND01.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codigo+serie_   tag pp2 eval {|| if( nindexmod <> nil, indexterm(,2), .t. ) } to "&gdir/ppdind02.ntx"
              #else
                Index On CODIGO+SERIE_   Tag PP2 Eval {|| If( nIndexMod <> NIL, IndexTerm(,2), .T. ) } to "&Gdir\PPDIND02.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codpro          tag pp3 eval {|| if( nindexmod <> nil, indexterm(,3), .t. ) } to "&gdir/ppdind03.ntx"
              #else
                Index On CODPRO          Tag PP3 Eval {|| If( nIndexMod <> NIL, IndexTerm(,3), .T. ) } to "&Gdir\PPDIND03.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codfab+descri   tag pp4 eval {|| if( nindexmod <> nil, indexterm(,4), .t. ) } to "&gdir/ppdind04.ntx"
              #else
                Index On CODFAB+DESCRI   Tag PP4 Eval {|| If( nIndexMod <> NIL, IndexTerm(,4), .T. ) } to "&Gdir\PPDIND04.NTX"
              #endif

              // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
              #ifdef LINUX
                index on codped          tag pp5 eval {|| if( nindexmod <> nil, indexterm(,5), .t. ) } to "&gdir/ppdind05.ntx"
              #else
                Index On CODPED          Tag PP5 Eval {|| If( nIndexMod <> NIL, IndexTerm(,5), .T. ) } to "&Gdir\PPDIND05.NTX"
              #endif
           ENDIF

           // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
           #ifdef LINUX
             set index to "&gdir/ppdind01.ntx", "&gdir/ppdind02.ntx", "&gdir/ppdind03.ntx", "&gdir/ppdind04.ntx", "&gdir/ppdind05.ntx"
           #else
             Set Index To "&Gdir\PPDIND01.NTX", "&Gdir\PPDIND02.NTX", "&Gdir\PPDIND03.NTX", "&Gdir\PPDIND04.NTX", "&Gdir\PPDIND05.NTX"
           #endif
        Else
           DBCloseArea()
        EndIf
   otherwise
endcase
If !NetErr()
   return(used())
else
   return(.f.)
EndIf


Function AreaStatus()
  Local cTela:= ScreenSave( 0, 0, 24, 79 )
  Local cCor:= SetColor()
  Local nArea:= Select()

  Aviso(  "Aguarde, pesquisando status da base de dados & informacoes...." )
  Set( 24, "INFO.TXT" )
  Set( 20, "PRINT" )
  nLinha:= 0
  @ ++nLinha,02 Say "********* VISUALIZACAO DE STATUS DE REGISTROS EM RELACAO A BLOQUEIOS *********"
  @ ++nlinha,02 Say "           Data " + DTOC( DATE() )
  @ ++nlinha,02 Say "           Hora " + TIME()
  @ ++nLinha,02 Say "  Base de Dados 255                                                           "
  @ ++NliNHA,02 Say "    Verificacao NETRLOCK-LOCK-DBLOCK-UNLOCK                                   "
  @ ++nLinha,02 Say "        Empresa " + ALLTRIM( _EMP )
  @ ++nLinha,02 Say "         Versao " + ALLTRIM( _VER )
  @ ++nLinha,02 Say "******************************************************************************"
  FOR nCt:= 1 TO 255
     dbSelectAr( nCt )
     IF Used()
        DBGoTop()
        WHILE !EOF()
           IF RLock()
              Unlock
           ELSE
              @ ++nLinha,01 Say " " + Str( nCt, 3, 0 ) + " " + ALIAS() + " " + Str( RECNO() ) + " *** BLOQUEADO *** "
              IF FIELDPOS( "DESCRI" ) > 0 .AND.;
                 FIELDPOS( "INDICE" ) > 0
                 @ ++nLinha,01 Say "INDICE#" + INDICE + " ==> " + DESCRI
              ELSEIF FIELDPOS( "DESCRI" ) > 0 .AND.;
                 FIELDPOS( "CODIGO" ) > 0
                 @ ++nLinha,01 Say "      #" + STR( CODIGO ) + " ==> " + DESCRI
              ELSEIF FIELDPOS( "DESCRI" ) > 0
                 @ ++nLinha,01 Say " *** SEM CODIGO ==> " + DESCRI
              ENDIF
           ENDIF
           DBSkip()
        ENDDO
     ENDIF
  NEXT
  __EJECT()
  Set( 20, "SCREEN" )
  Set( 24, "LPT1" )
  ViewFile( "INFO.TXT" )
  SetColor( cCor )
  ScreenRest( cTela )
  DBSelectAr( nArea )
  Return .T.



Function IndexTerm( x, y )
Local nQuantidade:= 50
Static nArquivo
Static nPosicao
IF x <> Nil
   nArquivo:= 0
ENDIF
IF Used()
   @ 17,25 Say StrZero( RECNO(), 10, 0 ) + "/" + StrZero( Lastrec(), 10 )
   IF y <> Nil
      if y > 0
         aIndex:= { "INDICE PRIMARIO ", "INDICE(2)", "INDICE(3)", "INDICE(4)", "INDICE(5)", "INDICE(6)", "INDICE(7)", "INDICE(8)", "INDICE(9)" }
         @ 21,25 Say PAD( aIndex[ y ], 20 )
      ENDIF
    ENDIF
    @ 19,25 Say StrZero( ++nArquivo, 10, 0 )
ENDIF
Termom()
Return .T.


