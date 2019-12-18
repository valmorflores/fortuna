
#Define _GMATRIX    0

#Define _BEMATECH   1
#Define _SIGTRON    2
#Define _SWEDA      3
#Define _SCHALTER   4
#Define _URANO      5

/*
* Modulo      - VPF.CH
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


