
#Define _GMATRIX    0

#Define _BEMATECH   1
#Define _SIGTRON    2
#Define _SWEDA      3
#Define _SCHALTER   4
#Define _URANO      5

#Define _SYS_DIRREPORT     523



/*
* Modulo      - vpf.ch
* Finalidade  - Armazenamento da variaveis p/ sistema.
* Programador - Valmor Pereira Flores
*/
#command REPLACE [ <f1> WITH <x1> [, <fn> WITH <xn>] ]                    ;
         [FOR <for>]                                                      ;
         [WHILE <while>]                                                  ;
         [NEXT <next>]                                                    ;
         [RECORD <rec>]                                                   ;
         [<rest:REST>]                                                    ;
         [ALL]                                                            ;
                                                                          ;
      => DBEval(                                                          ;
                 {|| _FIELD-><f1> := <x1> [, _FIELD-><fn> := <xn>]},      ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.> )            ;
                 ;DBCommit()                                              ;
                 ;IIF( FIELDPOS( "FILIAL" ) > 0, IF( _FIELD->FILIAL==0, _FIELD->FILIAL:= CodigoFilial, Nil ), Nil ) ;

#command REPLACE <f1> WITH <v1> [, <fN> WITH <vN> ]                       ;
      => _FIELD-><f1> := <v1> [; _FIELD-><fN> := <vN>]                    ;
         ;IIF( FIELDPOS( "FILIAL" ) > 0, IF( _FIELD->FILIAL==0, _FIELD->FILIAL:= CodigoFilial, Nil ), Nil ) ;

#command USE <(db)>                                                     ;
             [VIA <rdd>]                                                ;
             [ALIAS <a>]                                                ;
             [<new: NEW>]                                               ;
             [<ex: EXCLUSIVE>]                                          ;
             [<sh: SHARED>]                                             ;
             [<ro: READONLY>]                                           ;
             [INDEX <(index1)> [, <(indexn)>]]                          ;
                                                                        ;
      => dbUseArea(                                                     ;
                    <.new.>, RDDSetDefault(), <(db)>, <(a)>,                      ;
                    if(<.sh.> .or. <.ex.>, !<.ex.>, NIL), <.ro.>        ;
                  )                                                     ;
                                                                        ;
      [; dbSetIndex( <(index1)> )]                                      ;
      [; dbSetIndex( <(indexn)> )]



/// ARQUIVOS

#Define _COD_MPRIMA        10
#Define _VPB_MPRIMA        "&DiretorioDeDados\CDMPRIMA.DBF"

#Define _COD_PRECOAUX      11
#Define _VPB_PRECOAUX      "&DiretorioDeDados\TABAUX__.DBF"

#Define _COD_ESTOQUE       12
#Define _VPB_ESTOQUE       "&DiretorioDeDados\CESTOQUE.DBF"

#Define _COD_CLIENTE       13
#Define _VPB_CLIENTE       "&DiretorioDeDados\CLIENTES.DBF"

#Define _COD_BANCO         14
#Define _VPB_BANCO         "&DiretorioDeDados\CDBANCOS.DBF"

#Define _COD_VENDEDOR      15
#Define _VPB_VENDEDOR      "&DiretorioDeDados\VENDEDOR.DBF"

#Define _COD_CAIXA         16
#Define _VPB_CAIXA         "&DiretorioDeDadis\CAIXA___.DBF"

#Define _COD_DUPAUX        17
#Define _VPB_DUPAUX        "&DiretoriodeDados\CDDUPAUX.DBF"

#Define _COD_CUPOM         18
#Define _VPB_CUPOM         "&DiretoriodeDados\CUPOM___.DBF"

#Define _COD_CUPAUX        19
#Define _VPB_CUPAUX        "&DiretoriodeDados\CUPOMAUX.DBF"

#Define _ARQUIVO           "PDV_PEND.DBF"
#Define _VENDAFILE         123

#Define _BACKUP            "BAKUPULT.DBF"

#define _COD_PDVEAN        20
#define _VPB_PDVEAN        "&DiretoriodeDados\PDVEAN__.DBF"

#define _COD_CORES         21
#define _VPB_CORES         "&DiretoriodeDados\CORES___.DBF"

#define _COD_CLASSES       22
#define _VPB_CLASSES       "&DiretoriodeDados\CLASSES_.DBF"

#Define _COD_ASSEMBLER     23
#define _VPB_ASSEMBLER     "&DiretoriodeDados\MONTAGEM.DBF"

#Define _COD_CONDICOES     24
#Define _VPB_CONDICOES     "&DiretorioDeDados\CONDICAO.DBF"

#Define _COD_TABPRECO      25
#Define _VPB_TABPRECO      "&DiretorioDeDados\TABPRECO.DBF"

#Define _COD_TABAUX        26
#Define _VPB_TABAUX        "&DiretorioDeDados\TABAUX__.DBF"

#Define _COD_GRUPO         27
#Define _VPB_GRUPO         "&DiretorioDeDados\GRUPOPRO.DBF"


// VendaFile
#Define _ABRIR              2
#Define _LIMPAR             3
#Define _EXCLUIR            4
#Define _ANULAR_ITEM        5
#Define _CRIAR              6
#Define _VENDA_ITEM         7
#Define _INFORMACOES_ITEM   8
#Define _BUSCAR_ITEM        9
#Define _ULTIMOREGISTRO     10
#Define _ARMAZENAR          11
#Define _RESTAURAR          12
#Define _ENVIAR_PARA_MATRIZ 13




#Define _VER "Fortuna v5.0"