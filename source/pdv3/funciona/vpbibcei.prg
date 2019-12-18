*************************************** VPBIBCEI ****************************************
*                 Biblioteca de funcoes para o Sistema VPCEI Versao 1.0                  *
********************************* Valmor Pereira Flores **********************************
#include "VPF.CH"
#include "INKEY.CH"
#include "FORMATOS.CH"
#include "BOX.CH"

/*
*      Funcao - CREATEVPB
*  Finalidade - Criacao de arquivos de banco de dados.
*  Parametros - Numero de classIficacao do banco de dados.
* Programador - Valmor Pereira Flores
*        Data - 01/Fevereiro/1994
* Atualizacao -
*/
func createvpb(nDBF)
loca aSTRUT
do case
   case nDBF==_COD_INFOCLI
        Mensagem( "Criando arquivo, aguarde...")
        aSTRUT:={{"CODIGO","N",06,00},;
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
                 dbcreate( _VPB_INFOCLI, aSTRUT )
   case nDBF==_COD_CREDIARIO
        Mensagem( "Criando arquivo, aguarde...")
        aSTRUT:={{"CODIGO","N",06,00},;
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
                 dbcreate(_VPB_CREDIARIO,aSTRUT)
   case nDBF==_COD_CLIENTE
        Mensagem( "Criando arquivo para cadastro de clientes, aguarde...")
        aSTRUT:={{"FILIAL","N",03,00},;
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
                 {"LIMCR_","N",18,02},;
                 {"SALDO_","N",18,02},;
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
                 {"NOVVEN","N",03,00}}  // Dias para Novo Vencimento
        dbcreate(_VPB_CLIENTE,aSTRUT)
   case nDBF==_COD_OPERACOES
        Mensagem( "Criando arquivo para cadastro de operacoes com produtos, aguarde...")
        aSTRUT:={{"CODIGO","N",02,00},;
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
                 {"CLIFOR","C",01,00}}
        dbcreate(_VPB_OPERACOES,aSTRUT)
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
        aStrut:={{"CODIGO","C",08,00},;
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
                 {"CODNF_","N",08,00},;
                 {"DATANF","D",08,00},;
                 {"DATA__","D",08,00},;
                 {"DTATU_","D",08,00},;
                 {"CODFUN","N",04,00},;
                 {"SELECT","C",03,00},;
                 {"SITUA_","C",03,00},;
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
        DBCreate( _VPB_PEDIDO, aStrut )
   Case nDBF==_COD_PEDPROD
        aStrut:={{"CODIGO","C",08,00},;
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
                 {"PCPCOR","N",03,00}}
        DBCreate( _VPB_PEDPROD, aStrut )
   Case nDBF==_COD_PEDBAIXA
        aStrut:={{"CODNF_","N",06,00},;
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
        aStrut:={ { "CODIGO", "N", 04, 00 },;
                  { "DESCRI", "C", 40, 00 } }
        dbcreate( _VPB_ATIVIDADES, aStrut )
   Case nDBF==_COD_RECEITAS
        aStrut:={ { "CODIGO", "N", 04, 00 },;
                  { "DESCRI", "C", 40, 00 },;
                  { "SALDO_", "N", 16, 02 } }
        dbcreate( _VPB_RECEITAS, aStrut )
   Case nDBF==_COD_MOVIMENTO
        aStrut:={ { "DATA__", "D", 08, 00 },;
                  { "NCONTA", "N", 04, 00 },;
                  { "TCONTA", "C", 01, 00 },;
                  { "DCONTA", "C", 30, 00 },;
                  { "HISTO1", "C", 30, 00 },;
                  { "HISTO2", "C", 30, 00 },;
                  { "DEBITO", "N", 16, 02 },;
                  { "CREDIT", "N", 16, 02 } }
        dbcreate( _VPB_MOVIMENTO, aStrut )
   case nDBF == _COD_TABPRECO
        aStrut:={ { "CODIGO", "N", 04, 00 },;
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
                  { "CND005", "N", 02, 00 },;
                  { "DATA__", "D", 08, 00 } }
        dbcreate( _VPB_TABPRECO, aStrut )
   case nDBF==_COD_TABAUX
        aStrut:={{ "CODIGO", "N", 04, 00 },;
                 { "CODPRO", "C", 12, 00 },;
                 { "CODFAB", "C", 15, 00 },;
                 { "DESCRI", "C", 40, 00 },;
                 { "PERACR", "N", 06, 02 },;
                 { "PERDES", "N", 06, 02 },;
                 { "PRECOV", "N", 16, 04 },;
                 { "MARGEM", "N", 16, 02 }}
        dbcreate( _VPB_TABAUX, aStrut )
   case nDBF==_COD_CONDICOES
        aStrut:={ { "CODIGO", "N", 04, 00 },;
                  { "DESCRI", "C", 40, 00 },;
                  { "PERACD", "N", 12, 06 },;
                  { "PERACR", "N", 09, 03 },;
                  { "PERDES", "N", 09, 03 },;
                  { "PARCA_", "N", 03, 00 },;
                  { "PARCB_", "N", 03, 00 },;
                  { "PARCC_", "N", 03, 00 },;
                  { "PARCD_", "N", 03, 00 },;
                  { "PARCE_", "N", 03, 00 },;
                  { "PARCF_", "N", 03, 00 },;
                  { "PARCG_", "N", 03, 00 },;
                  { "PARCH_", "N", 03, 00 },;
                  { "PARCI_", "N", 03, 00 },;
                  { "PARCJ_", "N", 03, 00 },;
                  { "PARCK_", "N", 03, 00 },;
                  { "PARCL_", "N", 03, 00 },;
                  { "PARCM_", "N", 03, 00 },;
                  { "PARCN_", "N", 03, 00 },;
                  { "PARCO_", "N", 03, 00 },;
                  { "PARCP_", "N", 03, 00 },;
                  { "PARCQ_", "N", 03, 00 },;
                  { "PARCR_", "N", 03, 00 },;
                  { "PARCS_", "N", 03, 00 },;
                  { "PARCT_", "N", 03, 00 },;
                  { "PARCU_", "N", 03, 00 },;
                  { "PARCV_", "N", 03, 00 },;
                  { "PARCW_", "N", 03, 00 },;
                  { "PARCX_", "N", 03, 00 },;
                  { "PARCY_", "N", 03, 00 },;
                  { "PARCZ_", "N", 03, 00 },;
                  { "TAXA__", "N", 10, 00 },;
                  { "JUROS_", "N", 09, 03 },;
                  { "MULTA_", "N", 09, 03 },;
                  { "TOLERA", "N", 06, 00 },;
                  { "PERCA_", "N", 09, 03 },;
                  { "SELECT", "C", 01, 00 }}
        dbcreate( _VPB_CONDICOES, aStrut )
   case nDBF==_COD_MPRIMA
        aSTRUT:={{"INDICE","C",12,00},;
                 {"CODRED","C",12,00},;
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
                 {"SALDO_","N",18,05},;
                 {"ESTMIN","N",16,05},;
                 {"ESTMAX","N",16,05},;
                 {"PERCNV","N",04,02},;
                 {"PRECOV","N",18,04},;
                 {"ICMCOD","N",01,00},;
                 {"IPICOD","N",01,00},;
                 {"CLAFIS","N",03,00},;
                 {"CLASV_","N",01,00},;
                 {"IPI___","N",06,02},;
                 {"ICM___","N",06,02},;
                 {"CODFOR","N",03,00},;
                 {"MONTA_","N",03,00},;
                 {"BUSCA_","C",01,00},;
                 {"PRECOD","N",18,04},;
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
                 {"DES013","C",40,00},;
                 {"FOR014","N",03,00},;
                 {"DES014","C",40,00},;
                 {"FOR015","N",03,00},;
                 {"DES015","C",40,00},;
                 {"TABRED","C",02,00},;
                 {"PESOLI","N",16,04},;
                 {"PESOBR","N",16,04},;
                 {"OCOMP_","N",16,05},;
                 {"DETAL1","C",65,00},;
                 {"DETAL2","C",65,00},;
                 {"DETAL3","C",65,00},;
                 {"DETAL4","C",65,00},;
                 {"DETAL5","C",65,00},;
                 {"COMIS_","C",01,00},;
                 {"MOEDA_","C",03,00},;
                 {"MOBRAP","N",06,02},;
                 {"MOBRAV","N",16,02},;
                 {"CUSMED","N",16,03},;
                 {"ENTQTD","N",16,04},;
                 {"SAIQTD","N",16,04},;
                 {"DTULTS","D",08,00},;
                 {"DTULTE","D",08,00},;
                 {"QTULTS","N",16,04},;
                 {"QTULTE","N",16,04},;
                 {"SDOVLR","N",16,02},;
                 {"SEGURA","C",01,00},;
                 {"TABOBS","N",04,00},;
                 {"QTDMIN","N",16,02},;
                 {"CUSATU","N",16,04},;
                 {"CODIF_","C",20,00},;
                 {"INGATV","C",20,00},;
                 {"CLATOX","N",03,00},;
                 {"PCPCLA","N",03,00},;
                 {"PCPTAM","N",02,00},; // <-- NAO ESTA SENDO USADO
                 {"PCPCOR","N",03,00},; // <-- OBSOLETO
                 {"PCPCSN","C",01,00},;
                 {"AREA__","N",16,02},;
                 {"GARVAL","N",03,00},;
                 {"SELECT","C",03,00}}
        dbcreate(_VPB_MPRIMA,aSTRUT)
   case nDBF==_COD_ASSEMBLER
        aSTRUT:={{"CODPRD","C",12,00},;
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
        dbcreate(_VPB_ASSEMBLER,aSTRUT)
   case nDBF==_COD_PRECOXFORN
        aSTRUT:={{"CPROD_","C",12,00},;
                 {"CODFOR","N",04,00},;
                 {"VALOR_","N",18,04},;
                 {"PVELHO","N",18,04},;
                 {"DATA__","D",08,00}}
        dbcreate(_VPB_PRECOXFORN,aSTRUT)
   case nDBF==_COD_CONFIG
        aSTRUT:={{"VARIAV","C",10,00},;
                 {"QUANT_","N",02,00},;
                 {"DECIM_","N",02,00},;
                 {"MASCAR","C",16,00},;
                 {"VERIf_","C",01,00},;
                 {"DATA__","D",08,00},;
                 {"USUAR_","N",03,00},;
                 {"HORA__","C",08,00},;
                 {"QUEST_","C",01,00}}
        dbcreate(_VPB_CONFIG,aSTRUT)
   case nDBF==_COD_ESTOQUE
        aSTRUT:={{"CPROD_","C",12,00},;
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
                 {"PCPQUA","N",12,02}}
                  /* Valor ICMs mercadoria ref. neg. */
                  /* Valor desta entrada/saida */
                  /* Valor + ICMs */
                  /* Data de lancamento */
        dbcreate(_VPB_ESTOQUE,aSTRUT)
   case nDBF==_COD_PRODNF
        aSTRUT:={{"CODNF_","N",06,00},;
                 {"CODRED","C",12,00},;
                 {"CODIGO","C",12,00},;
                 {"ORIGEM","C",03,00},;
                 {"DESCRI","C",_ESP_DESCRICAO,00},;
                 {"MPRIMA","C",01,00},;
                 {"UNIDAD","C",02,00},;
                 {"ASSOC_","C",01,00},;
                 {"QTDPES","N",16,05},;
                 {"QUANT_","N",12,03},;
                 {"PRECOV","N",18,04},;
                 {"PRECOT","N",18,04},;
                 {"ICMCOD","N",01,00},;
                 {"IPICOD","N",01,00},;
                 {"CLAFIS","N",03,00},;
                 {"PERIPI","N",06,03},;
                 {"IPI___","N",18,03},;
                 {"BASICM","N",18,02},;
                 {"PERRED","N",12,04},;
                 {"VLRRED","N",18,02},;
                 {"PERICM","N",06,02},;
                 {"VLRICM","N",18,02},;
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
                 {"TABOPE","N",03,00}}
        dbcreate(_VPB_PRODNF,aSTRUT)
   case nDBF==_COD_NFISCAL
        aSTRUT:={{"TIPONF","C",01,00},;
                 {"NUMERO","N",06,00},;
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
                 {"VLRNOT","N",18,04},;
                 {"VLRTOT","N",18,04},;
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
                 {"TABOPE","N",03,00}}
        dbcreate(_VPB_NFISCAL,aSTRUT)
   case nDBF==_COD_CUPOM
        aSTRUT:={{"TIPONF","C",01,00},;
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
                 {"VLRNOT","N",18,04},;
                 {"VLRTOT","N",18,04},;
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
                 {"TABOPE","N",03,00},;
                 {"PRAZOA","N",04,00},;
                 {"IMPRES","C",03,00},;
                 {"SELECT","C",03,00},;
                 {"PRICMP","C",01,00}}
        dbcreate(_VPB_CUPOM,aSTRUT)
   case nDBF==_COD_CUPOMAUX
        aSTRUT:={{"CODNF_","N",09,00},;
                 {"CODRED","C",12,00},;
                 {"CODIGO","C",12,00},;
                 {"DESCRI","C",40,00},;
                 {"MPRIMA","C",01,00},;
                 {"UNIDAD","C",02,00},;
                 {"ASSOC_","C",01,00},;
                 {"QTDPES","N",16,05},;
                 {"QUANT_","N",12,03},;
                 {"PRECOV","N",18,04},;
                 {"PRECOT","N",18,04},;
                 {"ICMCOD","N",01,00},;
                 {"IPICOD","N",01,00},;
                 {"CLAFIS","N",03,00},;
                 {"PERIPI","N",06,03},;
                 {"IPI___","N",18,03},;
                 {"BASICM","N",18,02},;
                 {"PERRED","N",12,04},;
                 {"VLRRED","N",18,02},;
                 {"PERICM","N",06,02},;
                 {"VLRICM","N",18,02},;
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
        dbcreate( _VPB_CUPOMAUX, aSTRUT )
   case nDBF==_COD_DUPAUX
        aSTRUT:={{"CODNF_","N",06,00},;
                 {"SEQUE_","N",08,00},;
                 {"CODIGO","N",10,00},;
                 {"CLIENT","N",06,00},;
                 {"CDESCR","C",45,00},;
                 {"DUPL__","N",10,00},;
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
                 {"LOCAL_","N",03,00}}
        dbcreate(_VPB_DUPAUX,aSTRUT)
   case nDBF==_COD_OBSERVACOES
        aSTRUT:={{"CODIGO","N",10,00},;
                 {"DESCRI","C",30,00},;
                 {"OBSERV","C",40,00}}
        dbcreate(_VPB_OBSERVACOES,aSTRUT)
   case nDBF==_COD_DUPLICATA
        aSTRUT:={{"CODIGO","N",10,00},;
                 {"CODNF_","N",06,00},;
                 {"CLIENT","N",06,00},;
                 {"CDESCR","C",45,00},;
                 {"DUPL_A","N",10,00},;
                 {"DUPL_B","N",10,00},;
                 {"DUPL_C","N",10,00},;
                 {"DUPL_D","N",10,00},;
                 {"PERC_A","N",06,02},;
                 {"PERC_B","N",06,02},;
                 {"PERC_C","N",06,02},;
                 {"PERC_D","N",06,02},;
                 {"VLR__A","N",16,03},;
                 {"VLR__B","N",16,03},;
                 {"VLR__C","N",16,03},;
                 {"VLR__D","N",16,03},;
                 {"PRAZ_A","N",03,00},;
                 {"PRAZ_B","N",03,00},;
                 {"PRAZ_C","N",03,00},;
                 {"PRAZ_D","N",03,00},;
                 {"VENC_A","D",08,00},;
                 {"VENC_B","D",08,00},;
                 {"VENC_C","D",08,00},;
                 {"VENC_D","D",08,00},;
                 {"QUIT_A","C",01,00},;
                 {"QUIT_B","C",01,00},;
                 {"QUIT_C","C",01,00},;
                 {"QUIT_D","C",01,00},;
                 {"DTQT_A","D",08,00},;
                 {"DTQT_B","D",08,00},;
                 {"DTQT_C","D",08,00},;
                 {"DTQT_D","D",08,00},;
                 {"BANC_A","N",03,00},;
                 {"BANC_B","N",03,00},;
                 {"BANC_C","N",03,00},;
                 {"BANC_D","N",03,00},;
                 {"CHEQ_A","C",15,00},;
                 {"CHEQ_B","C",15,00},;
                 {"CHEQ_C","C",15,00},;
                 {"CHEQ_D","C",15,00},;
                 {"OBS__A","C",30,00},;
                 {"OBS__B","C",30,00},;
                 {"OBS__C","C",30,00},;
                 {"OBS__D","C",30,00},;
                 {"DADO_A","C",03,00},;
                 {"DADO_B","C",03,00},;
                 {"DADO_C","C",03,00},;
                 {"DADO_D","C",03,00},;
                 {"SITU_A","C",01,00},;
                 {"SITU_B","C",01,00},;
                 {"SITU_C","C",01,00},;
                 {"SITU_D","C",01,00},;
                 {"DATAEM","D",03,00},;
                 {"NVEZES","N",02,00},;
                 {"VALOR_","N",18,04},;
                 {"FUNC__","N",03,00},;
                 {"NFNULA","C",01,00},;
                 {"TIPO__","C",02,00}}
        dbcreate(_VPB_DUPLICATA,aSTRUT)
   case nDBF==_COD_PAGAR
        aSTRUT:={{"CODIGO","N",05,00},;
                 {"DOC___","C",10,00},;
                 {"CODFOR","N",04,00},;
                 {"BANCO_","N",03,00},;
                 {"VENCIM","D",08,00},;
                 {"VALOR_","N",18,04},;
                 {"DATAPG","D",08,00},;
                 {"OBSERV","C",40,00},;
                 {"EMISS_","D",08,00},;
                 {"JUROS_","N",18,04},;
                 {"VLRIPI","N",18,04},;
                 {"VLRICM","N",18,04},;
                 {"QUITAD","C",01,00},;
                 {"CHEQUE","C",15,04},;
                 {"NFISC_","N",06,00},;
                 {"DENTRA","D",08,00}}
        dbcreate(_VPB_PAGAR,aSTRUT)
   case nDBF==_COD_CLASFISCAL
        aSTRUT:={{"CODIGO","N",03,00},;
                 {"CODFIS","C",10,00},;
                 {"OBSERV","C",30,00},;
                 {"OBSNOT","C",60,00}}
        dbcreate(_VPB_CLASFISCAL,aSTRUT)
   case nDBF==_COD_CAIXA
        aStrut:={{"DATAMV","D",08,00},;
                 {"VENDE_","N",03,00},;
                 {"ENTSAI","C",01,00},;
                 {"MOTIVO","N",02,00},;
                 {"HISTOR","C",40,00},;
                 {"VALOR_","N",16,02},;
                 {"HORAMV","C",08,00},;
                 {"CDUSER","N",03,00}}
        dbcreate(_VPB_CAIXA,aStrut)
   case nDBF==_COD_CAIXAAUX
        aStrut:={{"DATAMV","D",08,00},;
                 {"VENDE_","N",03,00},;
                 {"ENTSAI","C",01,00},;
                 {"MOTIVO","N",02,00},;
                 {"HISTOR","C",40,00},;
                 {"VALOR_","N",16,02},;
                 {"HORAMV","C",08,00},;
                 {"CDUSER","N",03,00}}
        dbcreate(_VPB_CAIXAAUX,aStrut)
   case nDBF==_COD_BANCO
        aSTRUT:={{"CODIGO","N",03,00},;
                 {"CODPES","C",04,00},;
                 {"DESCRI","C",45,00},;
                 {"SELECT","C",03,00},;
                 {"SALDO_","N",16,02}}
        dbcreate(_VPB_BANCO,aSTRUT)
   case nDBF==_COD_TRANSPORTE
        Mensagem( "Criando arquivo de cadastro de transportadoras, aguarde...")
        aSTRUT:={{"CODIGO","N",03,00},;
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
        dbcreate(_VPB_TRANSPORTE,aSTRUT)
   case nDBF==_COD_ORIGEM
        Mensagem( "Criando arquivo de cadastro de origens, aguarde...")
        aSTRUT:={{"CODIGO","N",03,00},;
                 {"CODABR","C",03,00},;
                 {"DESCRI","C",45,00},;
                 {"SELECT","C",03,00}}
        dbcreate(_VPB_ORIGEM,aSTRUT)
   case nDBF==_COD_NATOPERA
        Mensagem( "Criando arquivo de natureza da oprecao, aguarde...")
        aSTRUT:={{"CODIGO","N",05,03},;
                 {"DESCRI","C",40,00},;
                 {"ENTSAI","C",03,00}}
        dbcreate( _VPB_NATOPERA, aSTRUT )
   case nDBF==_COD_VENDEDOR
        Mensagem( "Criando arquivo de cadastro de vendedores, aguarde...")
        aSTRUT:={{"CODIGO","N",03,00},;
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
        dbcreate(_VPB_VENDEDOR,aSTRUT)
   case nDBF==_COD_COMPER
        Mensagem( "Criando arquivo de % de comissoes, aguarde...")
        aSTRUT:={{"CODIGO","N",02,00},;
                 {"DESCRI","C",20,00},;
                 {"PERC__","N",06,02},;
                 {"VLR___","N",16,02}}
        dbcreate(_VPB_COMPER,aSTRUT)
   case nDBF==_COD_COMFORMULA
        Mensagem( "Criando arquivo de Formulas de comissoes, aguarde...")
        aSTRUT:={{"CODIGO","N",02,00},;
                 {"DESCRI","C",20,00}}
        dbcreate(_VPB_COMFORMULA,aSTRUT)
   case nDBF==_COD_COMFAUX
        Mensagem( "Criando arquivo de Formulas de comissoes, aguarde...")
        aSTRUT:={{"CODIGO","N",02,00},;
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
        dbcreate(_VPB_COMFAUX,aSTRUT)
   case nDBF==_COD_COMISSAO
        Mensagem( "Criando arquivo de comissoes de vendedores, aguarde...")
        aSTRUT:={{"CODNF_","N",06,00},;
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
        dbcreate(_VPB_COMISSAO,aSTRUT)
   case nDBF==_COD_COMISAUX
        Mensagem( "Criando arquivo de auxiliar de comissoes, aguarde..." )
        aStrut:={{"CODNF_","N",06,00},;
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
        aSTRUT:={{"ORDCMP","C",05,00},;
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
       dbcreate(_VPB_OC,aSTRUT)
   case nDBF==_COD_OC_AUXILIA
        aSTRUT:={{"ORDCMP","C",05,00},;
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
        dbcreate(_VPB_OC_AUXILIA,aSTRUT)
   case nDBF==_COD_FORNECEDOR
        Mensagem( "Criando arquivo para cadastro de Fornecedores, aguarde...")
        aSTRUT:={{"CODIGO","N",04,00},;
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
        dbcreate(_VPB_FORNECEDOR,aSTRUT)
   case nDBF==_COD_ETIQUETA
        aSTRUT:={{"DESCRI","C",08,00},;
                 {"MENS01","C",40,00},;
                 {"MENS02","C",40,00},;
                 {"MENS03","C",40,00},;
                 {"MENS04","C",40,00},;
                 {"MENS05","C",40,00},;
                 {"MENS06","C",40,00},;
                 {"MENS07","C",40,00},;
                 {"MENS08","C",40,00},;
                 {"MENS09","C",40,00},;
                 {"MENS10","C",40,00},;
                 {"COLUNA","N",02,00},;
                 {"MARGEM","N",02,00}}
        dbcreate(_VPB_ETIQUETA,aSTRUT)
   case nDBF==_COD_FERIADOS
        aSTRUT:={{"DIA___","C",02,00},;
                 {"MES___","C",02,00},;
                 {"DESCRI","C",40,00}}
        DbCreate(_VPB_FERIADOS,aSTRUT)
   case nDBF==_COD_PAGXREC
        aSTRUT:={{"DIA___","C",30,00},;
                 {"ARECEB","N",20,03},;
                 {"APAGAR","N",20,03},;
                 {"SALDO_","N",20,03},;
                 {"DATAMV","D",08,00}}
        DbCreate(_VPB_PAGXREC,aSTRUT)
   case nDBF==_COD_ESTADO
        aSTRUT:={{"ESTADO","C",02,00},;
                 {"DESCRI","C",30,03},;
                 {"PERCON","N",06,02},;
                 {"PERIND","N",06,02}}
        DbCreate(_VPB_ESTADO,aSTRUT)
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
                 {"DESCRI","C",_ESP_DESCRICAO,00},;
                 {"DATA__","D",08,00},;
                 {"MAXIMO","N",06,00}}
        DBCreate(_VPB_GRUPO,aStrut)
   case nDBF==_COD_REDUCAO
        aStrut:={{"CODIGO","C",02,00},;
                 {"DESCRI","C",30,00},;
                 {"OBSERV","C",40,00},;
                 {"PERRED","N",12,04}}
        DBCreate(_VPB_REDUCAO,aStrut)
   case nDBF==_COD_SETORES
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"OBSERV","C",55,00},;
                 {"CODFOR","N",04,00},;
                 {"CODCLI","N",06,00},;
                 {"CODEMP","N",04,00}}
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
        aSTRUT:={{"CPROD_","C",12,00},;
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
        dbcreate(_VPB_PCPESTO,aSTRUT)
   case nDBF==_COD_PCPMOVI
        aSTRUT:={{"CODIGO","N",006,00},;
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
        dbcreate(_VPB_PCPMOVI,aSTRUT)
   case nDBF==_COD_PCPRELA
        aSTRUT:={{"CODIGO","N",06,00},;
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
        dbcreate(_VPB_PCPRELA,aSTRUT)
   case nDBF==_COD_PDVEAN
        aSTRUT:={{"CODIGO","C",13,00},; // Codigo EAN Interno
                 {"CODPRO","C",12,00},; // Codigo Produto
                 {"PCPCLA","N",03,00},; // Codigo Classificacao
                 {"PCPTAM","N",02,00},; // Codigo Tamanho
                 {"PCPCOR","N",03,00},; // Codigo Cor
                 {"CODEAN","C",13,00},; // Codigo EAN Fabrica
                 {"SALDO_","N",18,05},; // Saldo Fisico de Estoque
                 {"EMBAL_","N",18,05},; // Embalagem Padrao
                 {"QTDMIN","N",18,05},; // Quantidade Minima
                 {"QTDMAX","N",18,05}}  // Quantidade Maxima
        dbcreate(_VPB_PDVEAN,aSTRUT)
   case nDBF==_COD_CTRLBANC
        aSTRUT:={{"CODCON","N",05,00},; // Codigo de Convenio
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
                 {"SITUAC","C",20,00},; // Situacao da Cobranca (Remessa/Retorno)
                 {"SELEC_","C",03,00},; // ("Nao"=NAO VAI) ("Sim"=VAI SIM)
                 {"CODIGO","C",10,00},; // Codigo de Identificacao da Duplicata
                 {"SUBCOD","C",02,00},; // Sub-Codigo (Indica a Divisao de parcelas Ex 01,02,03,04,...)
                 {"JAENVI","C",03,00}}  // ("Nao"=NAO FOI) ("Sim"=JA FOI)
        dbcreate(_VPB_CTRLBANC,aSTRUT)
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
        aStrut:={{"SEQUE_","N",08,00},;
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
   case nDBF==_COD_MOVESTOQUE
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"INTERN","C",01,00},;
                 {"ENTSAI","C",03,00},;
                 {"NATOPE","N",05,00},;
                 {"COMICM","C",01,00}}
        DBCreate( _VPB_MOVESTOQUE, aStrut )
   case nDBF==_COD_GARANTIA
        aStrut:={{"CODIGO","N",03,00},;
                 {"DESCRI","C",40,00},;
                 {"OBSERV","C",55,00},;
                 {"GARANT","N",06,00},;
                 {"VALIDA","N",06,00}}
        DBCreate( _VPB_GARANTIA, aStrut )
   case nDBf==_COD_ROMANEIO
        aStrut:={{"CODPRO","C",12,00},;
                 {"ROMANE","C",13,00},;
                 {"INTEXT","C",01,00},;
                 {"DATSAI","D",08,00},;
                 {"DATENT","D",08,00},;
                 {"SELECT","C",01,00},;
                 {"CODNF_","N",06,00}}
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
Static nNumero
nNumero:= IF( nNumero==Nil, 0, nNumero+1 )
IF nNumero==0
   cCorRes:= SetColor( "15/01" )
   Scroll( 24, 15, 24, 79 )
   SetColor( cCorRes )
ELSEIF nNumero >= 65
   nNumero:= -1
ELSE
   @ 24,00 Say "°°±±±²²²²²²²²²²" Color "15/01"
   @ 24,15 Say Repl( "°", nNumero ) + "  " + Repl( "Û", 63 - nNumero ) Color "07/03"
ENDIF
/* Seleciona Area que foi passada como parametro */
DBSelectAr( nDBF )
IF Used()
   DBSetOrder( 1 )
   DBGoTop()
   Return .T.
ENDIF

/* Coloca um parametro na indexacao */
IF lIndexForce == Nil
   lIndexForce:= .F.
ENDIF

/* Abertura dos arquivos */
do case
   case nDBF==_COD_OPERACOES
        If NetUse( _VPB_OPERACOES, ( nModo==1 ), 1, "OPE", .F. )
           Mensagem( "Organizando arquivo de Operacoes de Movimento de Estoque..." )
           If !File( M->GDir-"\OPEIND01.NTX" ) .OR. !File( M->GDir-"\OPEIND02.NTX" )
              Index On CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\OPEIND01.NTX
              Index On DESCRI Tag SR2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\OPEIND02.NTX
           EndIf
           Set Index To &GDir\OPEIND01.NTX, &GDIR\OPEIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_GARANTIA
        If NetUse( _VPB_GARANTIA, ( nModo==1 ), 1, "GAR", .F. )
           Mensagem( "Organizando arquivo de Garantia/Validade..." )
           If !File( M->GDir-"\GARIND01.NTX" ) .OR. !File( M->GDir-"\GARIND02.NTX" )
              Index On CODIGO Tag GR1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\GARIND01.NTX
              Index On DESCRI Tag GR2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\GARIND02.NTX
           EndIf
           Set Index To &GDir\GARIND01.NTX, &GDIR\GARIND02.NTX
        Else
           DBCloseArea()
        EndIf
    case nDbf==_COD_MOVESTOQUE
        If NetUse( _VPB_MOVESTOQUE, ( nModo==1 ), 1, "MES", .F. )
           Mensagem( "Organizando arquivo de Movimento de Estoque..." )
           If !File( M->GDir-"\MESIND01.NTX" ) .OR. !File( M->GDir-"\MESIND02.NTX" )
              Index On CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\MESIND01.NTX
              Index On DESCRI Tag SR2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\MESIND02.NTX
           EndIf
           Set Index To &GDir\MESIND01.NTX, &GDIR\MESIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CONDICOES
        If NetUse( _VPB_CONDICOES, ( nModo==1 ), 1, "CND", .F. )
           Mensagem( "Organizando arquivo de Tabela de Condicoes..." )
           If !File( M->GDir-"\CNDIND01.NTX" ) .OR. !File( M->GDir-"\CNDIND02.NTX" )
              Index On CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CNDIND01.NTX
              Index On DESCRI Tag SR2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CNDIND02.NTX
           EndIf
           Set Index To &GDir\CNDIND01.NTX, &GDIR\CNDIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_SERVICO
        If NetUse( _VPB_SERVICO, ( nModo==1 ), 1, "SER", .F. )
           Mensagem( "Organizando arquivo de servicos, aguarde..." )
           If !File( M->GDir-"\SERIND01.NTX" ) .OR. !File( M->GDir-"\SERIND02.NTX" )
              Index On SUBCTA + CODIGO Tag SR1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SERIND01.NTX
              Index On CODIGO Tag SR2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SERIND02.NTX
           EndIf
           Set Index To &GDir\SERIND01.NTX, &GDIR\SERIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ROMANEIO
        IF NetUse( _VPB_ROMANEIO, ( nModo==1 ), 1, "ROM", .F. )
           IF !File( M->GDir-"\ROMIND01.NTX" ) .OR.;
              !File( m->GDir-"\ROMIND02.NTX" ) .OR.;
              !File( m->GDir-"\ROMIND03.NTX" )
              Index On CODPRO Tag RO1 Eval {|| IF( nIndexMod <> Nil, Termom(), .T. ) } To &GDir\ROMIND01.Igd
              Index On ROMANE Tag RO2 Eval {|| IF( nIndexMod <> Nil, Termom(), .T. ) } To &GDir\ROMIND02.Igd
              Index On CODNF_ Tag RO3 Eval {|| IF( nIndexMod <> Nil, Termom(), .T. ) } To &GDir\ROMIND03.Igd
           ENDIF
           Set Index to &GDir\ROMIND01.Igd, &GDir\ROMIND02.Igd, &GDir\ROMIND03.Igd
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
           Mensagem( "Organizando arquivo de bloquetos, aguarde..." )
           If !File( M->GDir-"\BLOIND01.NTX" ) .OR. !File( M->GDir-"\BLOIND02.NTX" ) .OR.;
              !File( M->GDir-"\BLOIND03.NTX" ) .OR. !File( M->GDir-"\BLOIND04.NTX" )
              Index On VENC__ Tag At1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\BLOIND01.NTX
              Index On DUPLIC Tag At2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\BLOIND02.NTX
              Index On SEQUE_ Tag At3 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\BLOIND03.NTX
              Index On MARCA_ Tag At4 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\BLOIND04.NTX
           EndIf
           Set Index To &GDir\BLOIND01.NTX, &GDIR\BLOIND02.NTX, &GDIR\BLOIND03.NTX, &GDIR\BLOIND04.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_FLUXOCAIXA
        If NetUse( _VPB_FLUXOCAIXA, ( nModo==1 ), 1, "FLU", .F. )
           Mensagem( "Organizando arquivo de bloquetos, aguarde..." )
           If !File( M->GDir-"\FLUIND01.NTX" ) .OR. !File( M->GDir-"\FLUIND02.NTX" )
              Index On DATAPG Tag FL1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\FLUIND01.NTX
              Index On VENCIM Tag FL2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\FLUIND02.NTX
           EndIf
           Set Index To &GDir\FLUIND01.NTX, &GDIR\FLUIND02.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_COMPER
        If NetUse( _VPB_COMPER, ( nModo==1 ), 1, "CP_", .F. )
           Mensagem( "Organizando de % comissoes, aguarde..." )
           If !File( M->GDir-"\CP_IND01.NTX" ) .OR. !File( M->GDir-"\CP_IND02.NTX" )
              Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CP_IND01.NTX
              Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CP_IND02.NTX
           EndIf
           Set Index To &GDir\CP_IND01.NTX, &GDIR\CP_IND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMFORMULA
        If NetUse( _VPB_COMFORMULA, ( nModo==1 ), 1, "FML", .F. )
           Mensagem( "Organizando de % comissoes, aguarde..." )
           If !File( M->GDir-"\CF_IND01.NTX" ) .OR. !File( M->GDir-"\CF_IND02.NTX" )
              Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CF_IND01.NTX
              Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CF_IND02.NTX
           EndIf
           Set Index To &GDir\CF_IND01.NTX, &GDIR\CF_IND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMFAUX
        If NetUse( _VPB_COMFAUX, ( nModo==1 ), 1, "CA_", .F. )
           Mensagem( "Organizando de % comissoes, aguarde..." )
           If !File( M->GDir-"\CA_IND01.NTX" ) .OR. !File( M->GDir-"\CA_IND02.NTX" )
              Index On CODIGO Tag FL1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CA_IND01.NTX
              Index On DESCRI Tag FL2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CA_IND02.NTX
           EndIf
           Set Index To &GDir\CA_IND01.NTX, &GDIR\CA_IND02.NTX
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
           Mensagem( "Organizando arquivo de REDUCAO DE ICMs, aguarde..." )
           If !File( M->GDir-"\REDIND01.NTX" )
              Index On Codigo Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\REDIND01.NTX
           EndIf
           Set Index To &GDir\REDIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_SETORES
        If NetUse( _VPB_SETORES, ( nModo==1 ), 1, "SET", .F. )
           Mensagem( "Organizando o arquivo de SETORES, aguarde ..." )
           If !File( M->GDir-"\SETIND01.NTX" )
              Index On Codigo Tag ST Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SETIND01.NTX
           EndIf
           Set Index To &GDir\SETIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CORES
        If NetUse( _VPB_CORES, ( nModo==1 ), 1, "COR", .F. )
           Mensagem( "Organizando o arquivo de CORES, aguarde ..." )
           If !File( M->GDir-"\CORIND01.NTX" )
              Index On Codigo Tag ST Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CORIND01.NTX
           EndIf
           Set Index To &GDir\CORIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CLASSES
        If NetUse( _VPB_CLASSES, ( nModo==1 ), 1, "CLA", .F. )
           Mensagem( "Organizando o arquivo de CLASSES, aguarde ..." )
           If !File( M->GDir-"\CLAIND01.NTX" )
              Index On Codigo Tag ST Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CLAIND01.NTX
           EndIf
           Set Index To &GDir\CLAIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PCPESTO
        If NetUse( _VPB_PCPESTO, ( nModo==1 ), 1, "PCE", .F. )
           Mensagem( "Organizando arquivo de controle de ESTOQUE PCP, aguarde...")
           If !File( M->GDir-"\PCEIND01.NTX") .OR. !File( M->GDir-"\PCEIND02.NTX") .OR.;
              !File( M->GDir-"\PCEIND03.NTX") .OR. !File( M->GDir-"\PCEIND04.NTX")
              Index On CPROD_ Tag PE1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} To &GDir\PCEIND01.NTX
              Index On DATAMV Tag PE2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} To &GDir\PCEIND02.NTX
              Index On DOC___ Tag PE3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} To &GDIR\PCEIND03.NTX
              Index On DOC___ + Str( CODMV_, 2, 0 ) + Str( CODIGO, 6, 0 ) + ENTSAI  To &GDIR\PCEIND04.NTX
           EndIf
           Set Index To &GDir\PCEIND01.NTX, &GDir\PCEIND02.NTX, &GDir\PCEIND03.NTX, &GDIR\PCEIND04.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PCPMOVI
        If NetUse( _VPB_PCPMOVI, ( nModo==1 ), 1, "PCM", .F. )
           Mensagem( "Organizando o arquivo de Movimento PCP, aguarde ..." )
           If !File( M->GDir-"\PCMIND01.NTX" ) .OR. ;
              !File( M->GDir-"\PCMIND02.NTX" )
              Index On CODIGO Tag PC1 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\PCMIND01.NTX
              Index On DESCRI Tag PC2 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\PCMIND02.NTX
           EndIf
           Set Index To &GDir\PCMIND01.NTX, &GDir\PCMIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PCPRELA
        If NetUse( _VPB_PCPRELA, ( nModo==1 ), 1, "PCL", .F. )
           Mensagem( "Organizando o arquivo de Produtos Relacionados PCP, aguarde ..." )
           If !File( M->GDir-"\PCLIND01.NTX" ) .OR. ;
              !File( M->GDir-"\PCLIND02.NTX" ) .OR. ;
              !File( M->GDir-"\PCLIND03.NTX" )
              Index On CODIGO Tag PCLX1 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\PCLIND01.NTX
              Index On STR (CODIGO, 6) + CODPRO + STR (CODCOR, 2) Tag PCLX2 ;
                 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To ;
                 &GDir\PCLIND02.NTX
              Index On CODPRO + STR (CODIGO, 6) + STR (CODCOR, 2) Tag PCLX3 ;
                 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To ;
                 &GDir\PCLIND03.NTX
           EndIf
           Set Index To &GDir\PCLIND01.NTX, &GDir\PCLIND02.NTX, ;
                        &GDir\PCLIND03.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_PDVEAN
        If NetUse( _VPB_PDVEAN, ( nModo==1 ), 1, "EAN", .F. )
           Mensagem( "Organizando o arquivo de Correspondencias EAN, aguarde ..." )
           If !File( M->GDir-"\EANIND01.NTX" ) .OR. ;
              !File( M->GDir-"\EANIND02.NTX" )
              Index On CODIGO Tag EANX1 ;
                 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } ;
                 To &GDir\EANIND01.NTX
              Index On CODEAN + CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                       STR (PCPCOR, 3) Tag EANX2 ;
                 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } ;
                 To &GDir\EANIND02.NTX
              Index On CODPRO + STR (PCPCLA, 3) + STR (PCPTAM, 2) + ;
                       STR (PCPCOR, 3) Tag EANX1 ;
                 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } ;
                 To &GDir\EANIND03.NTX
           EndIf
           Set Index To &GDir\EANIND01.NTX, &GDir\EANIND02.NTX, ;
                        &GDir\EANIND03.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CTRLBANC
        If NetUse( _VPB_CTRLBANC, ( nModo==1 ), 1, "CTB", .F. )
           Mensagem( "Organizando o Arquivo de Controle Bancario, aguarde ..." )
           If !File( M->GDir-"\CTBIND01.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND02.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND03.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND04.NTX" ) .OR. ;
              !File( M->GDir-"\CTBIND05.NTX" )
              Index On IDECLI Tag CTBX1 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\CTBIND01.NTX
              Index On DATVEN Tag CTBX2 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\CTBIND02.NTX
              Index On SITUAC Tag CTBX3 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\CTBIND03.NTX
              Index On JAENVI Tag CTBX4 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\CTBIND04.NTX
              Index On CODIGO Tag CTBX5 Eval {|| If( nIndexMod <> NIL, ;
                 Termom(), .T.) } To &GDir\CTBIND05.NTX
           EndIf
           Set Index To &GDir\CTBIND01.NTX, &GDir\CTBIND02.NTX, ;
                        &GDir\CTBIND03.NTX, &GDir\CTBIND04.NTX, ;
                        &GDir\CTBIND05.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_SIMILAR
        IF NetUse( _VPB_SIMILAR, ( nModo==1 ), 1, "SIM", .F. )
           Mensagem( "Organizando arquivo de Similaridade, aguarde..." )
           If !File( M->GDir-"\SIMIND01.NTX" ) .OR. !File( M->GDir-"\SIMIND02.NTX" ) .OR.;
              !File( M->GDir-"\SIMIND03.NTX" ) .OR. !File( M->GDir-"\SIMIND04.NTX" )
              Index On Codig1 Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SIMIND01.NTX
              Index On Codig2 Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SIMIND02.NTX
              Index On COMP01 Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SIMIND03.NTX
              Index On COMP02 Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\SIMIND04.NTX
           EndIf
           Set Index To &GDir\SIMIND01.NTX, &GDir\SIMIND02.NTX, &GDir\SIMIND03.NTX, &GDir\SIMIND04.NTX
        ELSE
           DBCloseArea()
        ENDIF
   case nDBF==_COD_TELA
        If NetUse( _VPB_TELA, ( nModo==1 ), 1, "VPT", .F. )
           Mensagem( "Organizando arquivo de telas, aguarde..." )
           If !File( M->GDir-"\TELIND01.NTX" )
              Index On USERN_ Tag TL1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\TELIND01.NTX
           EndIf
           Set Index To &GDir\TELIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDbf==_COD_CAIXA
        If NetUse( _VPB_CAIXA, ( nModo==1 ), 1, "CX_", .F. )
           Mensagem( "Organizando arquivo de fluxo de caixa, aguarde..." )
           If !File( M->GDir-"\CX_IND01.NTX" )
              Index On DATAMV Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CX_IND01.NTX
           EndIf
           Set Index To &GDir\CX_IND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TABPRECO
        If NetUse( _VPB_TABPRECO, ( nModo==1 ), 1, "PRE", .F. )
           Mensagem( "Organizando arquivo de Precos diferenciados, aguarde..." )
           If !File( M->GDir-"\TPRIND01.NTX" ) .AND. !File( M->GDir-"\TPRIND02.NTX" )
              Index On CODIGO Tag TP Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\TPRIND01.NTX
              Index On DESCRI Tag TP Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\TPRIND02.NTX
           EndIf
           Set Index To &GDir\TPRIND01.NTX, &GDir\TPRIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TABROTAS
        If NetUse( _VPB_TABROTAS, ( nModo==1 ), 1, "ROT", .F. )
           Mensagem( "Organizando arquivo de Rotas, aguarde..." )
           If !File( M->GDir-"\ROTIND01.NTX" ) .AND. !File( M->GDir-"\ROTIND02.NTX" )
              Index On CODIGO Tag TP Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\ROTIND01.NTX
              Index On DESCRI Tag TP Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\ROTIND02.NTX
           EndIf
           Set Index To &GDir\ROTIND01.NTX, &GDir\ROTIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TABAUX
        If NetUse( _VPB_TABAUX, ( nModo==1 ), 1, "TAX", .F. )
           Mensagem( "Organizando arquivo de Precos diferenciados (AUXILIAR), aguarde..." )
           If !File( M->GDir-"\TAXIND01.NTX" ) .AND. !File( M->GDir-"\TAXIND02.NTX" )
              Index On CODIGO Tag TP Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\TAXIND01.NTX
              Index On CODPRO Tag TP Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\TAXIND02.NTX
           EndIf
           Set Index To &GDir\TAXIND01.NTX, &GDir\TAXIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_MOVIMENTO
        If NetUse( _VPB_MOVIMENTO, ( nModo==1 ), 1, "MOV", .F. )
           Mensagem( "Organizando arquivo de movimento financeiro, aguarde..." )
           If !File( M->GDir-"\MOVIND01.NTX" ) .AND. !File( M->GDir-"\MOVIND02.NTX" )
              Index On DATA__ Tag MV Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\MOVIND01.NTX
              Index On NCONTA Tag MV Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\MOVIND02.NTX
           EndIf
           Set Index To &GDir\MOVIND01.NTX, &GDir\MOVIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDbf==_COD_CAIXAAUX
        If NetUse( _VPB_CAIXAAUX, ( nModo==1 ), 1, "CXA", .F. )
           Mensagem( "Organizando arquivo de fluxo de caixa (auxiliar), aguarde..." )
           If !File( M->GDir-"\CXAIND01.NTX" )
              Index On DATAMV Tag CX Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CXAIND01.NTX
           EndIf
           Set Index To &GDir\CXAIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_GRUPO
        If NetUse( _VPB_GRUPO, ( nModo==1 ), 1, "GR0", .F. )
           Mensagem( "Organizando arquivo de grupo de produtos, aguarde..." )
           If !File( M->GDir-"\GR0IND01.NTX" ) .OR. !File( M->GDir-"\GR0IND02.NTX" )
              Index On CODIGO Tag GR1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\GR0IND01.NTX
              Index On DESCRI Tag GR2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\GR0IND02.NTX
           EndIf
           Set Index To &GDir\GR0IND01.NTX, &GDIR\GR0IND02.NTX
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
           Mensagem( "Organizando arquivo de agencias, aguarde..." )
           If !File( M->GDir-"\AGEIND01.NTX" ) .OR. !File( M->GDir-"\AGEIND02.NTX" )
              Index On Codigo Tag AG1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\AGEIND01.NTX
              Index On Descri Tag AG2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\AGEIND02.NTX
           EndIf
           Set Index To &GDir\AGEIND01.NTX, &GDir\AGEIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CONTA
        If NetUse( _VPB_CONTA, ( nModo==1 ), 1, "CON", .F. )
           Mensagem( "Organizando arquivo de contas, aguarde..." )
           If !File( M->GDir-"\CONIND01.NTX" ) .OR. !File( M->GDir-"\CONIND02.NTX" )
              Index On Codigo Tag CTC1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CONIND01.NTX
              Index On Descri Tag CTC2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CONIND02.NTX
           EndIf
           Set Index To &GDir\CONIND01.NTX, &GDir\CONIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_HISTORICO
        If NetUse( _VPB_HISTORICO, ( nModo==1 ), 1, "His", .F. )
           Mensagem( "Organizando arquivo de hist¢ricos, aguarde..." )
           If !File( M->GDir-"\HISIND01.NTX" ) .OR. !File( M->GDir-"\HISIND02.NTX" )
              Index On Codigo Tag HS1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\HISIND01.NTX
              Index On Descri Tag HS2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\HISIND02.NTX
           EndIf
           Set Index To &GDir\HISIND01.NTX, &GDir\HISIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ASSEMBLER
        If NetUse( _VPB_ASSEMBLER, ( nModo==1 ), 1, "Asm", .F. )
           Mensagem( "Organizando arquivo de montagem, aguarde..." )
           If !File( M->GDir-"\ASMIND01.NTX" ) .OR. !File( M->GDir-"\ASMIND02.NTX" )
              Index On CodPrd Tag MP1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\ASMIND01.NTX
              Index On CodMpr Tag MP2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\ASMIND02.NTX
           EndIf
           Set Index To &GDir\ASMIND01.NTX, &GDir\ASMIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_NATOPERA
        If NetUse( _VPB_NATOPERA, ( nModo==1 ), 1, "CFO", .F. )
           Mensagem( "Organizando arquivo de Natureza da Operacao, aguarde..." )
           If !File( M->GDir-"\CFOIND01.NTX" ) .OR. !File( M->GDir-"\CFOIND02.NTX" )
              Index On Codigo Tag NO1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CFOIND01.NTX
              Index On Descri Tag NO2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\CFOIND02.NTX
           EndIf
           Set Index To &GDir\CFOIND01.NTX, &GDir\CFOIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ATIVIDADES
        If NetUse( _VPB_ATIVIDADES, ( nModo==1 ), 1, "Atv", .F. )
           Mensagem( "Organizando arquivo de codigos de atividades, aguarde..." )
           If !File( M->GDir-"\AtvIND01.NTX" ) .OR. !File( M->GDir-"\AtvIND02.NTX" )
              Index On Codigo Tag TT1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\AtvIND01.NTX
              Index On Descri Tag TT2 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\AtvIND02.NTX
           EndIf
           Set Index To &GDir\ATVIND01.NTX, &GDir\ATVIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ETIQUETA
        If NetUse( _VPB_ETIQUETA, ( nModo==1 ), 1, "Etq", .F. )
           Mensagem( "Organizando arquivo de etiquetas, aguarde..." )
           If !File( M->GDir-"\EtqIND01.NTX" )
              Index On Codigo Tag ET1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\EtqIND01.NTX
           EndIf
           Set Index To &GDir\EtqIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ORIGEM
        If NetUse( _VPB_ORIGEM, ( nModo==1 ), 1, "Org", .F. )
           Mensagem( "Organizando arquivo de origens, aguarde..." )
           If !File( M->GDir-"\ORIGEM01.NTX") .or.;
              !File( M->GDir-"\ORIGEM02.NTX") .or.;
              !File( M->GDir-"\ORIGEM03.NTX")
              Index On Codigo Tag OR1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\ORIGEM01.NTX
              Index On upper(Descri) Tag OR2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\ORIGEM02.NTX
              Index On CODABR Tag OR3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\ORIGEM03.NTX
           EndIF
           Set Index To &GDir\ORIGEM01.NTX, &GDir\ORIGEM02.NTX, &GDir\ORIGEM03.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ESTADO
        If NetUse( _VPB_ESTADO, ( nModo==1 ), 1, "UF", .F. )
           Mensagem( "Organizando arquivo de estados, aguarde..." )
           If !File( "ESTADO01.NTX") .OR. !File( "ESTADO02.NTX" )
              Index On ESTADO Tag ES1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to ESTADO01.NTX
              Index On UPPER( DESCRI ) Tag ES2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to ESTADO02.NTX
           EndIF
           Set Index To ESTADO01.NTX, ESTADO02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CREDIARIO
        If NetUse( _VPB_CREDIARIO, ( nModo==1 ), 1, "CCR", .F. )
           Mensagem( "Organizando arquivo de CREDIARIOS, aguarde..." )
           If !File( M->GDir-"\CCRIND01.NTX" )
              Index On Codigo Tag CR1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CCRIND01.NTX
           EndIf
           Set Index To &GDir\CCRIND01.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_CLIENTE
        If NetUse( _VPB_CLIENTE, ( nModo==1 ), 1, "Cli", .F. )
           Mensagem( "Organizando arquivo de clientes, aguarde..." )
           If !File( M->GDir-"\CLIIND01.NTX" ) .or. !File( M->GDir-"\CLIIND02.NTX" ) .or. ;
              !File( M->GDir-"\CLIIND03.NTX" ) .or. !File( M->GDir-"\CLIIND04.NTX" )
              Index On Codigo Tag CL1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CLIIND01.NTX
              Index On upper(Descri) Tag CL2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CLIIND02.NTX
              Index On Fantas Tag CL3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CLIIND03.NTX
              Index On StrZero( FILIAL, 03, 00 ) + StrZero( CODFIL, 06, 00 ) Tag CL4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CLIIND04.NTX
           EndIf
           Set Index To &GDir\CLIIND01.NTX, &GDir\CLIIND02.NTX, &GDir\CLIIND03.NTX, &GDir\CLIIND04.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_CONFIG
        If NetUse( _VPB_CONFIG, ( nModo==1 ), 1, "Cf1", .F. )
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_VENDEDOR
        If NetUse( _VPB_VENDEDOR, ( nModo==1 ), 1, "Ven", .F. )
           Mensagem( "Organizando arquivo de vendedores, aguarde..." )
           If !File( M->GDir-"\VENIND01.NTX") .or. !File( M->GDir-"\VENIND02.NTX")
              Index On Codigo Tag VN1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\VENIND01.NTX
              Index On upper(Descri) Tag VN2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\VENIND02.NTX
           EndIf
           Set Index To &GDir\VENIND01.NTX, &GDir\VENIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMISSAO
        If NetUse( _VPB_COMISSAO, ( nModo==1 ), 1, "Com", .F. )
           Mensagem( "Organizando arquivo de comissao, aguarde..." )
           If !File( M->GDir-"\CM_IND01.NTX") .or. !File( M->GDir-"\CM_IND02.NTX") .OR.;
              !File( M->GDir-"\CM_IND03.NTX") .or. !File( M->GDir-"\CM_IND04.NTX") .OR.;
              !File( M->GDir-"\CM_IND05.NTX")
              Index On VENDE_ Tag CM1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM_IND01.NTX
              Index On CODNF_ Tag CM2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM_IND02.NTX
              Index On DTDISP Tag CM3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM_IND03.NTX
              Index On DTQUIT Tag CM4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM_IND04.NTX
              Index On VENCIM Tag CM5 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM_IND05.NTX
           EndIf
           Set Index To &GDir\CM_IND01.NTX, &GDir\CM_IND02.NTX, &GDir\CM_IND03.NTX, &GDir\CM_IND04.NTX, &GDir\CM_IND05.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_COMISAUX
        If NetUse( _VPB_COMISAUX, ( nModo==1 ), 1, "Cm1", .F. )
           Mensagem( "Organizando arquivo de comissao, aguarde..." )
           If !File( M->GDir-"\CM1IND01.NTX") .or. !File( M->GDir-"\CM1IND02.NTX")
              Index On VENDE_ Tag C21 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM1IND01.NTX
              Index On CODNF_ Tag C22 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CM1IND02.NTX
           EndIf
           Set Index To &GDir\CM1IND01.NTX, &GDir\CM1IND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_RECEITAS
        If NetUse( _VPB_RECEITAS, ( nModo==1 ), 1, "REC", .F. )
           Mensagem( "Organizando arquivo de fornecedores, aguarde..." )
           If !File( M->GDir-"\RECIND01.NTX") .or. !File( M->GDir-"\RECIND02.NTX")
              Index On Codigo Tag DS1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\RECIND01.NTX
              Index On upper(Descri) Tag DS2 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } To &GDir\RECIND02.NTX
           EndIf
           Set Index To &GDir\RECIND01.NTX, &GDir\RECIND02.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_DESPESAS
        If NetUse( _VPB_DESPESAS, ( nModo==1 ), 1, "Des", .F. )
           Mensagem( "Organizando arquivo de fornecedores, aguarde..." )
           If !File( M->GDir-"\DESIND01.NTX") .or. !File( M->GDir-"\DESIND02.NTX") .OR.;
              lIndexForce
              Index On Codigo Tag DS1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\DESIND01.NTX
              Index On upper(Descri) Tag DS2 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } To &GDir\DESIND02.NTX
              Index On Codigo to &GDir\FORIND01.NTX For TIPO__="1"
              Index On Upper(Descri) to &GDir\FORIND02.NTX For TIPO__="1"
           EndIf
           Set Index To &GDir\DESIND01.NTX, &GDir\DESIND02.NTX, &GDir\FORIND01.NTX, &GDir\FORIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_FORNECEDOR
        If NetUse( _VPB_FORNECEDOR, ( nModo==1 ), 1, "For", .F. )
           Mensagem( "Organizando arquivo de fornecedores, aguarde...")
           If !File( M->GDir-"\FORIND01.NTX") .or. !File( M->GDir-"\FORIND02.NTX")
              Index On Codigo to &GDir\FORIND01.NTX For TIPO__="1"
              Index On Upper(Descri) to &GDir\FORIND02.NTX For TIPO__="1"
              Index On Codigo Tag DS1 Eval {|| If( nIndexMod <> NIL, Termom(), .T.) } To &GDir\DESIND01.NTX
              Index On upper(Descri) Tag DS2 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } To &GDir\DESIND02.NTX
           EndIf
           Set Index To &GDir\FORIND01.NTX, &GDir\FORIND02.NTX, &GDir\DESIND01.NTX, &GDir\DESIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_MPRIMA
        If NetUse( _VPB_MPRIMA, ( nModo==1 ), 1, "MPr", .F. )
           Mensagem( "Organizando arquivo de materia prima, aguarde..." )
           If !File( M->GDir-"\MPRIND01.NTX") .OR. !File( M->GDir-"\MPRIND02.NTX") .OR.;
              !File( M->GDir-"\MPRIND03.NTX") .OR. !File( M->GDir-"\MPRIND04.NTX") .OR.;
              !File( M->GDir-"\MPRIND05.NTX")
              Index On Indice          Tag MP1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\MPRIND01.NTX
              Index On upper( Descri ) Tag MP2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\MPRIND02.NTX
              Index On CodRed          Tag MP3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\MPRIND03.NTX
              Index On upper( CodFab ) Tag MP4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\MPRIND04.NTX
              Index On CodFor          Tag MP5 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\MPRIND05.NTX
           EndIf
           Set Index To &GDir\MPRIND01.NTX, &GDir\MPRIND02.NTX, &GDir\MPRIND03.NTX, &GDir\MPRIND04.NTX, &GDir\MPRIND05.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PRODNF
        If NetUse( _VPB_PRODNF, ( nModo==1 ), 1, "Pnf", .F. )
           Mensagem( "Organizando arquivo de PRODUTOS X NOTA FISCAL, aguarde..." )
           If !File( M->GDir-"\PNFIND01.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND02.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND03.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND04.NTX" ) .OR.;
              !File( M->GDir-"\PNFIND05.NTX" )
              Index On Codigo        Tag P1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PNFIND01.NTX
              Index On upper(Descri) Tag P2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PNFIND02.NTX
              Index On CODRED        Tag P3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PNFIND03.NTX
              Index On DATA__        Tag P4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PNFIND04.NTX
              Index On CODNF_        Tag P5 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PNFIND05.NTX
           EndIf
           Set Index To &GDir\PNFIND01.NTX,;
                        &GDir\PNFIND02.NTX,;
                        &GDir\PNFIND03.NTX,;
                        &GDir\PNFIND04.NTX,;
                        &GDir\PNFIND05.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PRECOXFORN
        If NetUse( _VPB_PRECOXFORN, ( nModo==1 ), 1, "PXF", .F. )
           Mensagem( "Organizando arquivo de precos x fornecedores, aguarde...")
           If !File( M->GDir-"\PXFIND01.NTX") .OR. !File( M->GDir-"\PXFIND02.NTX") .OR. !File(  M->GDir-"\PXFIND03.NTX")
              Index On CPROD_             Tag PF1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PXFIND01.NTX
              Index On CODFOR             Tag PF2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PXFIND02.NTX
              Index On STR(CODFOR)+CPROD_ Tag PF3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PXFIND03.NTX
           EndIf
           Set Index To &GDir\PXFIND01.NTX, &GDir\PXFIND02.NTX, &GDir\PXFIND03.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PAGAR
        If NetUse( _VPB_PAGAR, ( nModo==1 ), 1, "PAG", .F. )
           Mensagem( "Organizando arquivo de contas a pagar, aguarde...")
           If !File( M->GDir-"\PAGIND01.NTX") .OR. !File( M->GDir-"\PAGIND02.NTX") .OR.;
              !File( M->GDir-"\PAGIND03.NTX") .OR. !File( M->GDir-"\PAGIND04.NTX")
              Index On CODIGO Tag PG1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PAGIND01.NTX
              Index On DOC___ Tag PG2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PAGIND02.NTX
              Index On VENCIM Tag PG3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PAGIND03.NTX
              Index On CODFOR Tag PG4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\PAGIND04.NTX
           EndIf
           Set Index To &GDir\PAGIND01.NTX, &GDir\PAGIND02.NTX, &GDir\PAGIND03.NTX, &GDir\PAGIND04.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_DUPLICATA
        If NetUse( _VPB_DUPLICATA, ( nModo==1 ), 1, "Dup", .F. )
           Mensagem( "Organizando arquivo de duplicatas, aguarde..." )
           If !File( M->GDir-"\DUPIND01.NTX") .OR. !File( M->GDir-"\DUPIND02.NTX") .OR. !File( M->GDir-"\DUPIND03.NTX")
              Index On CODNF_           Tag DP1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DUPIND01.NTX
              Index On upper(CDESCR)    Tag DP2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DUPIND02.NTX
              Index On CODIGO           Tag DP4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DUPIND03.NTX
           EndIf
           Set Index To &GDir\DUPIND01.NTX, &GDir\DUPIND02.NTX, &GDir\DUPIND03.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_OBSERVACOES
        If NetUse( _VPB_OBSERVACOES, ( nModo==1 ), 1, "OBS", .F. )
           Mensagem( "Organizando arquivo de Observacoes NF, aguarde..." )
           If !File( M->GDir-"\OBSIND01.NTX") .OR. !File( M->GDir-"\OBSIND02.NTX")
              Index On CODIGO           Tag DP1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OBSIND01.NTX
              Index On upper(DESCRI)    Tag DP2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OBSIND02.NTX
           EndIf
           Set Index To &GDir\OBSIND01.NTX, &GDir\OBSIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_DUPAUX
        If NetUse( _VPB_DUPAUX, ( nModo==1 ), 1, "DPA", .F. )
           Mensagem( "Organizando arquivo de duplicatas auxiliar, aguarde..." )
           If !File( M->GDir-"\DPAIND01.NTX") .OR. !File( M->GDir-"\DPAIND02.NTX") .OR.;
              !File( M->GDir-"\DPAIND03.NTX")  .OR. !File( M->GDir-"\DPAIND04.NTX") .OR.;
              !File( M->GDir-"\DPAIND05.NTX")
              Index On CODNF_ Tag DPA1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DPAIND01.NTX
              Index On VENC__ Tag DPA2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DPAIND02.NTX
              Index On CODIGO Tag DPA3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DPAIND03.NTX
              Index On CDESCR Tag DPA4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DPAIND04.NTX
              Index On CLIENT Tag DPA5 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\DPAIND05.NTX
           EndIf
           Set Index To &GDir\DPAIND01.NTX, &GDir\DPAIND02.NTX, &GDir\DPAIND03.NTX, &GDir\DPAIND04.NTX, &GDir\DPAIND05.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_NFISCAL
        If NetUse( _VPB_NFISCAL, ( nModo==1 ), 1, "NF_", .F. )
           Mensagem( "Organizando arquivo de notas fiscais, aguarde...")
           If !File( M->GDir-"\NFMIND01.NTX") .OR. !File( M->GDir-"\NFMIND02.NTX") .OR.;
              !File( M->GDir-"\NFMIND03.NTX") .OR. !File( M->GDir-"\NFMIND04.NTX") .OR.;
              !File( M->GDir-"\NFMIND05.NTX")
              Index On NUMERO Tag NF1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\NFMIND01.NTX
              Index On CDESCR Tag NF2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\NFMIND02.NTX
              Index On DATAEM Tag NF3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\NFMIND03.NTX
              Index On PEDIDO Tag NF4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\NFMIND04.NTX
              Index On SELECT Tag NF5 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\NFMIND05.NTX
           EndIf
           Set Index To &GDir\NFMIND01.NTX, &GDir\NFMIND02.NTX, &GDir\NFMIND03.NTX,;
                        &GDir\NFMIND04.NTX, &GDir\NFMIND05.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CUPOM
        If NetUse( _VPB_CUPOM, ( nModo==1 ), 1, "CUP", .F. )
           Mensagem( "Organizando arquivo de Cupons Fiscais, aguarde...")
           If !File( M->GDir-"\CUPIND01.NTX") .OR. !File( M->GDir-"\CUPIND02.NTX") .OR.;
              !File( M->GDir-"\CUPIND03.NTX") .OR. !File( M->GDir-"\CUPIND04.NTX")
              Index On NUMERO Tag CF1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CUPIND01.NTX
              Index On CDESCR Tag CF2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CUPIND02.NTX
              Index On DATAEM Tag CF3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CUPIND03.NTX
              Index On Pedido Tag CF4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CUPIND04.NTX
           EndIf
           Set Index To &GDir\CUPIND01.NTX, &GDir\CUPIND02.NTX, &GDir\CUPIND03.NTX, &GDir\CUPIND04.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_CUPOMAUX
        If NetUse( _VPB_CUPOMAUX, ( nModo==1 ), 1, "CAU", .F. )
           Mensagem( "Organizando arquivo de Produtos x Cupom Fiscal, aguarde..." )
           If !File( M->GDir-"\CAUIND01.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND02.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND03.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND04.NTX" ) .OR.;
              !File( M->GDir-"\CAUIND05.NTX" )
              Index On Codigo        Tag CAUX1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CAUIND01.NTX
              Index On upper(Descri) Tag CAUX2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CAUIND02.NTX
              Index On CODRED        Tag CAUX3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CAUIND03.NTX
              Index On DATA__        Tag CAUX4 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CAUIND04.NTX
              Index On CODNF_        Tag CAUX5 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CAUIND05.NTX
           EndIf
           Set Index To &GDir\CAUIND01.NTX,;
                        &GDir\CAUIND02.NTX,;
                        &GDir\CAUIND03.NTX,;
                        &GDir\CAUIND04.NTX,;
                        &GDir\CAUIND05.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_CLASFISCAL
        If NetUse( _VPB_CLASFISCAL, ( nModo==1 ), 1, "CF_", .F. )
           Mensagem( "Organizando arquivo de classIficacao fiscal, aguarde..." )
           If !File( M->GDir-"\CFMIND01.NTX") .OR. !File( M->GDir-"\CFMIND02.NTX")
              Index On Codigo Tag CF1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CFMIND01.NTX
              Index On CODFIS Tag CF2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\CFMIND02.NTX
           EndIf
           Set Index To &GDir\CFMIND01.NTX, &GDir\CFMIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_TRANSPORTE
        If NetUse( _VPB_TRANSPORTE, ( nModo==1 ), 1, "TRA", .F. )
           Mensagem( "Organizando arquivo de transportadora, aguarde..." )
           If !File( M->GDir-"\TRAIND01.NTX") .OR. !File( M->GDir-"\TRAIND02.NTX")
              Index On Codigo        Tag TR1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\TRAIND01.NTX
              Index On upper(Descri) Tag TR2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\TRAIND02.NTX
           EndIf
           Set Index To &GDir\TRAIND01.NTX, &GDir\TRAIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_OC
        If NetUse( _VPB_OC, ( nModo==1 ), 1, "OC", .F. )
           Mensagem( "Organizando arquivo de ordem de compra, aguarde...")
           If !File( M->GDir-"\OCXIND01.NTX") .OR. !File( M->GDir-"\OCXIND02.NTX")
              Index On ORDCMP+PAGINA    Tag OC1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OCXIND01.NTX
              Index On DESFOR           Tag OC2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OCXIND02.NTX
              Index On ORDCMP           Tag OC3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OCXIND03.NTX
           EndIf
           Set Index To &GDir\OCXIND01.NTX, &GDir\OCXIND02.NTX, &GDir\OCXIND03.NTX
        Else
           DBCloseArea()
        EndIf

   case nDBF==_COD_OC_AUXILIA
        If NetUse( _VPB_OC_AUXILIA, ( nModo==1 ), 1, "OCA", .F. )
           Mensagem( "Organizando arquivo de ordem de compra (AUXILIAR), aguarde...")
           If !File( M->GDir-"\OCAIND01.NTX") .OR. !File( M->GDir-"\OCAIND02.NTX" )
              Index On ORDCMP Tag OCA1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OCAIND01.NTX
              Index On CODPRO Tag OCA2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\OCAIND02.NTX
           EndIf
           Set Index To &GDir\OCAIND01.NTX, &GDir\OCAIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_ESTOQUE
        If NetUse( _VPB_ESTOQUE, ( nModo==1 ), 1, "EST", .F. )
           Mensagem( "Organizando arquivo de controle de estoque, aguarde...")
           If !File( M->GDir-"\ESTIND01.NTX") .OR. !File( M->GDir-"\ESTIND02.NTX") .OR.;
              !File( M->GDir-"\ESTIND03.NTX") .OR. !File( M->GDir-"\ESTIND04.NTX")
              Index On CPROD_ Tag ES1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} To &GDir\ESTIND01.NTX
              Index On DATAMV Tag ES2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} To &GDir\ESTIND02.NTX
              Index On DOC___ Tag ES3 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} To &GDIR\ESTIND03.NTX
              Index On DOC___ + Str( CODMV_, 2, 0 ) + Str( CODIGO, 6, 0 ) + ENTSAI  To &GDIR\ESTIND04.NTX
           EndIf
           Set Index To &GDir\ESTIND01.NTX, &GDir\ESTIND02.NTX, &GDir\ESTIND03.NTX, &GDIR\ESTIND04.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_FERIADOS
        If NetUse( _VPB_FERIADOS, ( nModo==1 ), 1, "Fer", .F. )
           Mensagem( "Organizando arquivo de feriados, aguarde...")
           If !File( M->GDir-"\FERIND01.NTX") .OR. !File( M->GDir-"\FERIND02.NTX")
              Index On MES___+DIA___    Tag FR1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\FERIND01.NTX
              Index On Descri           Tag FR2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\FERIND02.NTX
           EndIf
           Set Index To &GDir\FERIND01.NTX, &GDir\FERIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_BANCO
        If NetUse( _VPB_BANCO, ( nModo==1 ), 1, "Ban", .F. )
           Mensagem( "Organizando arquivo de bancos, aguarde...")
           If !File( M->GDir-"\BANIND01.NTX") .OR. !File( M->GDir-"\BANIND02.NTX")
              Index On Codigo           Tag BN1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\BANIND01.NTX
              Index On upper(Descri)    Tag BN2 Eval {|| If( nIndexMod <>NIL, Termom() ,.T.)} to &GDir\BANIND02.NTX
           EndIf
           Set Index To &GDir\BANIND01.NTX, &GDir\BANIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PAGXREC
        If NetUse( _VPB_PAGXREC, ( nModo==1 ), 1, "PxR", .F. )
           Mensagem( "Organizando arquivo de ctas. a pagar x ctas. a receber, aguarde..." )
           If !File( M->GDir-"\PXRIND01.NTX" )
              Index On DATAMV Tag PR1 Eval {|| If( nIndexMod <>NIL, Termom() ,.T. ) } To &GDir\PXRIND01.NTX
           EndIf
           Set Index To &GDir\PXRIND01.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PEDIDO
        If NetUse( _VPB_PEDIDO, ( nModo==1 ), 1, "Ped", .F. )
           Mensagem( "Organizando arquivo de COTACOES/PEDIDOS, aguarde..." )
           If !File( M->GDir-"\PEDIND01.NTX" ) .OR. !File( M->GDir-"\PEDIND02.NTX" ) .OR.;
              !File( M->GDir-"\PEDIND03.NTX" ) .OR. !File( M->GDir-"\PEDIND04.NTX" ) .OR.;
              !File( M->GDir-"\PEDIND05.NTX" ) .OR. !File( M->GDir-"\PEDIND06.NTX" ) .OR.;
              !File( M->GDir-"\PEDIND07.NTX" )
              Index On Codigo                 Tag PD1 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND01.NTX
              Index On Serie_                 Tag PD2 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND02.NTX
              Index On CodCli                 Tag PD3 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND03.NTX
              Index On Descri                 Tag PD4 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND04.NTX
              Index On CodNf_                 Tag PD5 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND05.NTX
              Index On CodPed                 Tag PD6 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND06.NTX
              Index On Str( CodNf_ ) + CodPed Tag PD7 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PEDIND07.NTX
           EndIf
           Set Index To &GDir\PEDIND01.NTX, &GDir\PEDIND02.NTX, &GDir\PEDIND03.NTX,;
                        &GDir\PEDIND04.NTX, &GDir\PEDIND05.NTX, &GDir\PEDIND06.NTX, &GDir\PEDIND07.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PEDBAIXA
        If NetUse( _VPB_PEDBAIXA, ( nModo==1 ), 1, "PBX", .F. )
           Mensagem( "Organizando arquivo de baixa de pedidos, aguarde..." )
           If !File( M->GDir-"\PB_IND01.NTX" ) .OR.;
              !File( M->GDir-"\PB_IND02.NTX" ) .OR.;
              !File( M->GDir-"\PB_IND03.NTX" )
              Index On CodNf_          Tag PD1 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PB_IND01.NTX
              Index On Codigo          Tag PD2 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PB_IND02.NTX
              Index On CodCli          Tag PD3 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\PB_IND03.NTX
           EndIf
           Set Index To &GDir\PB_IND01.NTX, &GDir\PB_IND02.NTX, &GDir\PB_IND03.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_INFOCLI
        If NetUse( _VPB_INFOCLI, ( nModo==1 ), 1, "CLF", .F. )
           Mensagem( "Organizando arquivo de Informacoes de clientes..." )
           If !File( M->GDir-"\INFIND01.NTX" ) .OR.;
              !File( M->GDir-"\INFIND02.NTX" )
              Index On CODIGO          Tag PD1 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\INFIND01.NTX
              Index On DESCRI          Tag PD1 Eval {|| If( nIndexMod <> Nil, Termom(), .T. ) } to &GDir\INFIND02.NTX
           EndIf
           Set Index To &GDir\INFIND01.NTX, &GDir\INFIND02.NTX
        Else
           DBCloseArea()
        EndIf
   case nDBF==_COD_PEDPROD
        If NetUse( _VPB_PEDPROD, ( nModo==1 ), 1, "PXP", .F. )
           Mensagem( "Organizando arquivo de COTACOES/PEDIDOS auxiliar, aguarde...")
           IF !File( M->GDir-"\PPDIND01.NTX") .OR.;
              !File( M->GDir-"\PPDIND02.NTX") .OR.;
              !File( M->GDir-"\PPDIND03.NTX") .OR.;
              !File( M->GDir-"\PPDIND04.NTX") .OR.;
              !File( M->GDir-"\PPDIND05.NTX")
              Index On CODIGO          Tag PP1 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } to &GDir\PPDIND01.NTX
              Index On CODIGO+SERIE_   Tag PP2 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } to &GDir\PPDIND02.NTX
              Index On CODPRO          Tag PP3 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } to &GDir\PPDIND03.NTX
              Index On CODFAB+DESCRI   Tag PP4 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } to &GDir\PPDIND04.NTX
              Index On CODPED          Tag PP5 Eval {|| If( nIndexMod <> NIL, Termom(), .T. ) } to &GDir\PPDIND05.NTX
           ENDIF
           Set Index To &GDir\PPDIND01.NTX, &GDir\PPDIND02.NTX, &GDir\PPDIND03.NTX, &GDir\PPDIND04.NTX, &GDir\PPDIND05.NTX
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
