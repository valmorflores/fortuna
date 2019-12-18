// ## CL2HB.EXE - Converted
 
#include "INKEY.CH" 
#include "VPF.CH" 
 
Function ImportaPedidos 
Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local nCodUltimo:= 0, aStr, cCodNovo, cPedNovo, cPedvelho 
Priv GDir1, GDir2 
 
   if Confirma( 0, 0, "Importacao de pedidos e clientes novos?", "*", "*" ) 
      GDir1:= "\\SERVIDOR\C\FORTUNA\DADOS" 
      GDir2:= "\\FEIRA\C\FORTUN~1\DADOS" 
 
      DBCloseAll() 
 
      Scroll( 01, 01, 22, 78 ) 
      aStrProd:= { {"INDIC1", "C", 12, 00},; 
                   {"INDIC2", "C", 12, 00},; 
                   {"DESCRI", "C", 50, 00},; 
                   {"SERVER", "C", 50, 00},; 
                   {"NOVIND", "C", 12, 00},; 
                   {"SELECT", "C", 03, 00} } 
 
      DBCreate( "PRODUTOS.TMP", aStrProd ) 
      DBSelectAr( 123 ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      USE PRODUTOS.TMP Alias PTMP 
 
      GDir1:= PAD( GDir1, 50 ) 
      GDir2:= PAD( GDir2, 50 ) 
 
      cPedidos:= "S" 
      cClientes:= "S" 
 
      nSoma:= 0 
 
      Scroll( 01, 01, 22, 78 ) 
      @ 02,01 say "Fazer Backup......Fazer backup.......                " 
      @ 03,01 say "     Fazer Backup......Fazer backup.......           " 
      @ 04,01 say "           Fazer Backup......Fazer backup.......     " 
      @ 05,01 say " CASO OCORRA QUALQUER FALHA EXISTE POSSIBILIDADE DE PERDA DE INFORMACOES " 
 
      @ 07,01 Say "Diretorio Servidor:" Get Gdir1 
      @ 08,01 Say "Diretorio Feira...:" Get GDir2 
 
      @ 12,01 Say "Importar Pedidos Feira..:" Get cPedidos 
      @ 13,01 Say "Importar Clientes Novos.:" Get cClientes 
 
      @ 15,01 say "Digito Default (Somar): " Get nSoma 
      Read 
 
      READ 
 
      IF LastKey()==K_ESC 
         Return Nil 
      ENDIF 
      GDir1:= AllTrim( GDir1 ) 
      GDir2:= AllTrim( GDir2 ) 
      CLS 
      @ 01,01 Say "Buscando informacoes e fazendo comparacoes de arquivos....." 
 
 
      IF UPPER( cPedidos )=="S" 
 
          /* Arquivos no Servidor */ 
          DBSelectAr( 11 ) 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&gdir1/cdmprima.dbf" alias mpr1 
          #else 
            USE "&GDir1\CDMPRIMA.DBF" Alias MPR1 
          #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON DESCRI + INDICE TO MPRIND11 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON INDICE TO MPRIND12 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          Set Index To MPRIND11, MPRIND12 
 
          DBSelectAr( 12 ) 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&gdir1/pedidos_.dbf" alias ped1 
          #else 
            USE "&GDir1\PEDIDOS_.DBF" Alias PED1 
          #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON CODIGO TO PEDIND11 
 
          DBSelectAr( 13 ) 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&gdir1/pedprod_.dbf" alias pxp1 
          #else 
            USE "&GDir1\PEDPROD_.DBF" Alias PXP1 
          #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON CODPRO TO PXPIND11 
 
 
          /* Arquivos na Feira */ 
          DBSelectAr( 21 ) 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&gdir2/cdmprima.dbf" alias mpr2 
          #else 
            USE "&GDir2\CDMPRIMA.DBF" Alias MPR2 
          #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON DESCRI + INDICE TO MPRIND21 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON INDICE TO MPRIND22 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          Set Index To MPRIND21, MPRIND22 
 
          DBSelectAr( 22 ) 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&gdir2/pedidos_.dbf" alias ped2 
          #else 
            USE "&GDir2\PEDIDOS_.DBF" Alias PED2 
          #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON CODIGO TO PEDIND21 
 
          DBSelectAr( 23 ) 

          // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
          #ifdef LINUX
            use "&gdir2/pedprod_.dbf" alias pxp2 
          #else 
            USE "&GDir2\PEDPROD_.DBF" Alias PXP2 
          #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON CODPRO TO PXPIND21 
 
          MPR2->( DBGoTop() ) 
          WHILE !MPR2->( EOF() ) 
              PTMP->( DBAppend() ) 
              MPR1->( DBSeek( MPR2->DESCRI + MPR2->INDICE ) ) 
              Replace PTMP->INDIC1 With MPR1->INDICE 
              Replace PTMP->INDIC2 With MPR2->INDICE 
              Replace PTMP->DESCRI With MPR2->DESCRI 
              IF MPR1->INDICE <> MPR2->INDICE .AND. !EMPTY( MPR1->INDICE ) 
                 Replace PTMP->SELECT With "###" 
              ELSE 
                 IF !MPR1->( DBSeek( MPR2->DESCRI + MPR2->INDICE ) ) 
                    MPR1->( DBSetOrder( 2 ) ) 
                    IF MPR1->( DBSeek( MPR2->INDICE ) ) 
                       Replace PTMP->SELECT With "..." 
                       Replace PTMP->SERVER With MPR1->DESCRI 
                    ELSE 
                       Replace PTMP->SELECT With "NEW" 
                    ENDIF 
                    MPR1->( DBSetOrder( 1 ) ) 
                 ELSE 
                    Replace PTMP->SELECT With "OK " 
                 ENDIF 
              ENDIF 
              MPR2->( DBSkip() ) 
          ENDDO 
 
 
          DBSelectAr( "PTMP" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
          INDEX ON DESCRI TO IND0202 FOR SELECT <> "OK " 
          CLS 
          @ 0,0 SAY "PROGRAMA DE IMPORTACAO DE INFORMACOES DE FEIRA" 
          @ 1,0 Say "Í Informacoes "+Repl( "Í", 80 ) 
          @ 2,0 Say "AUT=Inclusao com nova codificacao automatica no cadastro do FORTUNA" 
          @ 3,0 Say "...=Codificacao especifica, pois, j  existe no fortuna com outro codigo " 
          @ 4,0 Say "AC =Codigo esta correto embora a descricao nao seja absolutamente igual " 
          @ 5,0 Say "NEW=Codigo e produto nao foram encontrados no FORTUNA e serao cadastrados." 
          @ 6,0 Say Repl( "Í", 80 ) 
 
          @ 21,00 Say " [G] GRAVA INFORMACOES DEFINITIVAMENTE, CUIDADO!!!!!!!                            " Color "15/04" 
          oTB:= TBrowseDB( 07, 01, 20, 78 ) 
          oTB:AddColumn(tbcolumnnew( "Servidor  Feira Nome", {|| ALLTRIM( IF( EMPTY( INDIC1 ), ">>>>>>>", INDIC1 ) ) + " " + ALLTRIM( INDIC2 ) + " " + DESCRI + " " + SELECT })) 
          oTB:Autolite:= .F. 
          oTB:Dehilite() 
          WHILE .T. 
             oTB:colorrect( { oTB:ROWPOS, 1, oTB:ROWPOS, 1 }, { 2, 1 } ) 
             WHILE !oTB:stabilize() 
             ENDDO 
             @ 22,01 Say Repl( "Í", 80 ) 
             @ 23,05 Say DESCRI 
             @ 24,05 Say SERVER + " >>> " + NOVIND 
             nTecla:= Inkey( 0 ) 
             If nTecla=K_ESC 
                exit 
             EndIf 
             do case 
                case nTecla==K_UP         ;oTB:up() 
                case nTecla==K_RIGHT      ;oTB:right() 
                case nTecla==K_DOWN       ;oTB:down() 
                case nTecla==K_PGUP       ;oTB:pageup() 
                case nTecla==K_PGDN       ;oTB:pagedown() 
                case nTecla==K_CTRL_PGUP  ;oTB:gotop() 
                case nTecla==K_CTRL_PGDN  ;oTB:gobottom() 
                case nTecla==K_TAB 
                     Set( 24, "ARQUIVO.TXT" ) 
                     Set( 20, "PRINT" ) 
                     DBGoTop() 
                     WHILE !EOF() 
                        @ PROW(),PCOL() Say IF( EMPTY( INDIC1 ), ">>>>>>>     ", INDIC1 ) + INDIC2 + DESCRI + " " + SERVER + " " + SELECT + Chr( 13 ) + Chr( 10 ) 
                        DBSkip() 
                     ENDDO 
                     Set( 20, "SCREEN" ) 
 
                case nTecla==K_ENTER 
                     IF PTMP->SELECT=="..." 
                        cNovInd:= NOVIND 
                        @ 24,60 Get cNovInd 
                        READ 
                        IF PTMP->( RLOCK() ) 
                           Replace PTMP->NOVIND With cNovInd 
                        ENDIF 
                     ENDIF 
 
                case nTecla==K_SPACE 
                     IF PTMP->( RLOCK() ) 
                        IF PTMP->SELECT $ "AC -...-AUT" 
                           IF PTMP->SELECT=="AC " 
                              Replace PTMP->SELECT With "AUT" 
                           ELSEIF PTMP->SELECT=="AUT" 
                              Replace PTMP->SELECT With "..." 
                           ELSEIF PTMP->SELECT=="..." 
                              Replace PTMP->SELECT With "AC " 
                           ENDIF 
                        ENDIF 
                     ENDIF 
                     DBUnlockAll() 
                case CHR( nTecla ) $ "Gg" 
 
 
                     /* Grava os Novos registros */ 
                     PTMP->( DBGoTop() ) 
                     WHILE !PTMP->( EOF() ) 
 
                         @ 24,00 SAY PTMP->DESCRI 
                         /* Se for NEW ou AUTomatico */ 
                         IF PTMP->SELECT=="NEW" .OR. PTMP->SELECT=="AUT" 
 
                            /* Ordem de Codigo */ 
                            MPR1->( DBSetOrder( 2 ) ) 
 
                            IF PTMP->SELECT=="AUT" 
                               /* Busca o primeiro produto do proximo grupo */ 
                               cGrupo:= StrZero( VAL( LEFT( PTMP->INDIC2, 3 ) ) + 1, 3, 0 ) 
                               cProxProd:= cGrupo + "0000" 
                               IF !MPR1->( DBSeek( PAD( cProxProd, 12 ) ) ) 
                                  MPR1->( DBSeek( PAD( cProxProd, 12 ), .T. ) ) 
                               ENDIF 
 
                               /* Skip-1 que correspondera a voltar ao ultimo produto do grupo chave */ 
                               MPR1->( DBSkip( -1 ) ) 
 
                               /* Localiza o proximo codigo disponivel na base do servidor */ 
                               cCodigo:= StrZero( VAL( MPR1->INDICE )+1, 07, 0 ) 
                            ELSE 
                               cCodigo:= PTMP->INDIC2 
                            ENDIF 
                            DBSelectAr( "MPR2" ) 
                            COPY TO TEMP.TMP 
 
                            DBSelectAr( "MPR1" ) 
 
                            /* Acrescenta o produto na base de dados do servidor */ 
                            Append From TEMP.TMP for INDICE = PTMP->INDIC2 
 
                            IF MPR1->( DBSeek( PTMP->INDIC2 ) ) 
                               IF MPR1->( RLOCK() ) 
                                  Replace MPR1->INDICE With cCodigo 
                               ENDIF 
                            ENDIF 
 
                            /* Grava o codigo no campo de gravacao de digitos */ 
                            DBSelectAr( "PTMP" ) 
                            IF RLOCK() 
                               Replace NOVIND With cCodigo 
                            ENDIF 
                         ELSEIF SELECT=="AC " 
                            /* Grava a descricao na materia prima */ 
                            MPR1->( DBSetOrder( 2 ) ) 
                            MPR1->( DBSeek( PTMP->INDIC2 ) ) 
                            IF MPR1->( RLOCK() ) 
                               Replace MPR1->DESCRI With PTMP->DESCRI 
                            ENDIF 
                         ENDIF 
                         PTMP->( DBSkip() ) 
                     ENDDO 
 
                     /* Muda os codigos em PXP da feira */ 
                     PTMP->( DBGoTop() ) 
                     WHILE !PTMP->( EOF() ) 
                         @ 24,00 Say PTMP->DESCRI 
                         IF PTMP->SELECT=="..." .OR. PTMP->SELECT=="AUT" 
                            IF PXP2->( DBSeek( VAL( PTMP->INDIC2 ) ) ) 
                               @ 24,00 SAY PXP2->DESCRI 
                               IF PXP2->( RLOCK() ) 
                                  IF !EMPTY( PTMP->NOVIND ) 
                                     @ 24,70 SAY PXP2->CODPRO 
                                     Replace PXP2->CODPRO With VAL( PTMP->NOVIND ) 
                                  ENDIF 
                               ENDIF 
                            ENDIF 
                         ENDIF 
                         PTMP->( DBSkip() ) 
                     ENDDO 
 
 
                     /// Corrige numeracao de pedidos 
                     DBSelectAr( "PXP1" ) 
                     DBSelectAr( "PED1" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     INDEX ON CODIGO TO INDI22.TMP 
                     DBGoBottom() 
                     nCodigo:= VAL( CODIGO ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     INDEX ON CODIGO TO INDI.TMP 
                     DBGoBottom() 
                     nCodigo:= VAL( CODIGO ) 
 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     INDEX ON CODPED TO INDI.TMP 
                     DBGoBottom() 
                     nPedido:= VAL( CODPED ) 
 
                     DBSelectAr( "PED2" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     SET INDEX TO 
 
                     DBSelectAr( "PXP2" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
                     INDEX ON CODPED TO ID3233.TMP 
 
                     //// MUDANCA DOS NUMEROS DE PEDIDOS /// 
 
 
                     /* INICIO DA ATUALIZACAO */ 
                     DBSelectAr( "PED2" ) 
                     set inde to 
                     mult := reccount() 
                     DbGoTop() 
                     mNum := 0 
                     IF NSOMA > 0 
                        NPEDIDO := 0 
                        NCODIGO := 0 
                     ENDIF 
 
                     do while .not. eof() 
                        mnum++ 
                        mensagem("Aguarde Importando Pedidos: "+str(mnum,5)+"/"+strzero(mult,5)) 
                        IF PED2->( RLOCK() ) 
                           Replace COMPRA with "P"+alltrim(str(val(PED2->CODPED),8))+" "+COMPRA 
                           Replace PED2->CODPED With strzero(nSoma+val(PED2->CODPED)+nPedido,8),; 
                                   PED2->CODIGO With strZero(nSoma+val(PED2->CODIGO)+nCodigo,8) 
                        ENDIF 
                        DBSKip() 
                     Enddo 
 
                     DBSelectAr( "PXP2" ) 
                     set inde to 
                     mult := reccount() 
                     DbGoTop() 
                     mnum := 0 
                     do while .not. eof() 
                        mnum++ 
                        mensagem("Aguarde Importando Produtos: "+str(mnum,5)+"/"+strzero(mult,5)) 
                        IF PXP2->( RLOCK() ) 
                           Replace PXP2->CODPED With strzero(nSoma+val(PXP2->CODPED)+nPedido,8),; 
                                   PXP2->CODIGO With strZero(nSoma+val(PXP2->CODIGO)+nCodigo,8) 
                        ENDIF 
                        DBSKip() 
                     Enddo 
 
/* 
                     PED2->( DBGoTop() ) 
                     WHILE !PED2->( EOF() ) 
                         DBSelectAr( "PED2" ) 
                         cPedVelho:= PED2->CODPED 
                         cPedNovo:= StrZero( ++nPedido, 8, 0 ) 
                         cCodNovo:= StrZero( ++nCodigo, 8, 0 ) 
                         IF PED2->( RLOCK() ) 
                            Replace PED2->CODPED With PED2->cPedNovo,; 
                                    PED2->CODIGO With cCodNovo 
                         ENDIF 
                         DBSelectar( "PXP2" ) 
                         WHILE DBSeek( cPedVelho ) 
                             IF RLOCK() 
                                Replace CODPED With cPedNovo,; 
                                        CODIGO With cCodNovo 
                             ENDIF 
                         ENDDO 
                         PED2->( DBSkip() ) 
                     ENDDO 
*/ 
                     /* FIM DA ATUALIZACAO */ 
 
                     PXP2->( DBCloseArea() ) 
                     PED2->( DBCloseArea() ) 
 
                     /* Append no PXP do servidor com os dados do PXP da feira */ 
                     DBSelectAr( "PXP1" ) 
                     FLock() 
                     Append from "&GDir2\PEDPROD_.DBF" 
 
                     /* Append no PED do servidor com os dados do PED da feira */ 
                     DBSelectAr( "PED1" ) 
                     FLock() 
                     Append from "&GDir2\PEDIDOS_.DBF" 
                     Exit 
 
                otherwise                ;tone(125); tone(300) 
             endcase 
             oTB:refreshcurrent() 
             oTB:stabilize() 
          enddo 
 
      ENDIF 
 
 
 
      ///////// IMPORTACAO DE CLIENTES //////// 
 
      DBCloseAll() 
 
      IF upper( cClientes )=="S" 
 
         /* Arquivos no Servidor */ 
         DBSelectAr( 0 ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir1/clientes.dbf" alias cliserv  
         #else 
           USE "&GDir1\CLIENTES.DBF" Alias CLISERV  
         #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON CODIGO TO CLIIND11 
 
         DBSelectAr( 0 ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir1/pedidos_.dbf" alias pedserv  
         #else 
           USE "&GDir1\PEDIDOS_.DBF" Alias PEDSERV  
         #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON CODCLI TO PEDIND11 
 
          /* Arquivos na Feira */ 
         DBSelectAr( 0 ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir2/pedidos_.dbf" alias pedfeira  
         #else 
           USE "&GDir2\PEDIDOS_.DBF" Alias PEDFEIRA  
         #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON CODCLI TO PEDIND11 
 
         DBSelectAr( 0 ) 

         // Linhas corrigidas pelo programa de correcao cl2hb.exe em 19/08/2003
         #ifdef LINUX
           use "&gdir2/clientes.dbf" alias clifeira  
         #else 
           USE "&GDir2\CLIENTES.DBF" Alias CLIFEIRA  
         #endif
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON CODIGO TO CLIIND21 
 
 
         sele CLISERV 
         DBgobottom() 
         mcliatu := CODIGO + 1   // Pega o ultimo cliente do servidor + 1 
                                 // o primeiro da feira vai ser esse 
 
         DBSelectAr( "PEDFEIRA" ) 
         dbGoTop() 
         WHILE !EOF() 
 
             lLocalizado:= .F. 
             IF CLISERV->( DBSeek( PEDFEIRA->CODCLI ) ) 
                IF CLISERV->DESCRI == PEDFEIRA->DESCRI 
                   lLocalizado:= .T. 
                ELSE 
                   lLocalizado:= .F. 
                ENDIF 
             ELSE 
                lLocalizado:= .F. 
             ENDIF 
 
             IF !lLocalizado 
                IF CLIFEIRA->( DBSeek( PEDFEIRA->CODCLI ) ) 
                   CLISERV->( DBGoBottom() ) 
                   nCodUltimo:= CLISERV->CODIGO 
                   CLISERV->( DBAppend() ) 
                   aStr:= CLISERV->( dbStruct() ) 
                   FOR nCt:= 1 TO LEN( aStr ) 
                       IF NetRLock() 
                          cCampo:= aStr[ nCt ][ 1 ] 
                          Replace CLISERV->&cCampo With CLIFEIRA->&cCampo 
                       ENDIF 
                       Replace CLISERV->CODIGO With nCodUltimo+1 
                   NEXT 
                ENDIF 
             ENDIF 
             DBSkip() 
 
         ENDDO 
 
         DBSelectAr( "PEDSERV" ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         INDEX ON DESCRI TO INDXYX 
 
         DBSelectAr( "CLISERV" ) 
         DBGoTop() 
         WHILE !EOF() 
            IF PEDSERV->( DBSeek( CLISERV->DESCRI ) ) 
               WHILE PEDSERV->DESCRI == CLISERV->DESCRI 
                  IF PEDSERV->( RLOCK() ) 
                     Replace PEDSERV->CODCLI With CLISERV->CODIGO 
                  ENDIF 
                  PEDSERV->( DBSkip() ) 
               ENDDO 
            ENDIF 
            DBSkip() 
         ENDDO 
      ENDIF 
   ENDIF 
   DBCloseAll() 
   VPC15000() 
   ScreenRest( cTela ) 
   SetColor( cCor ) 
   SetCursor( nCursor ) 
   Return Nil 
 
 
 
