// ## CL2HB.EXE - Converted
//#include "Dbstruct.ch" 
#include "vpf.ch" 
/* 
   Programador - Valmor P.Flores 
 
   Basicamente esta fun��o faz ... 
 
      SETORES_.VPB ---> SETORES_.nnn 
      SETORES_.NOV <--- NOVA ESTRUTURA 
      SETORES_.NOV <--- SETORES_.nnn 
      SETORES_.NOV ---> SETORES_.VPB 
 
      Obs. Esta rotina � necess�ria, ao inv�s da outra, para o fato de o 
           usu�rio entrar diversas vezes no sistema quando houver um poss�vel 
           erro na convers�o, n�o perder os dados originais do cliente ! 
*/ 
   Function fConv_VPB (cArq, cFalta, aArqNom) 
 
      cArqVPB := ALLTRIM (cArq) 
      cArqUPD := LEFT (ALLTRIM (cArq), LEN (ALLTRIM (cArq)) - 4) + ".UPD" 
      cArqUPD := RIGHT (cArqUPD, LEN (cArqUPD) - RAT ("\", cArqUPD)) 
 
      IF (aScan (aArqNom, { | x | x [1] == cArqVPB}) = 0) 
         AAdd (aArqNom, {cArqVPB}) 
      ELSE 
         Return Nil 
      ENDIF 
 
      IF !File( cArqUPD ) 
         cFalta += "  NAO EXISTE " + cArqUPD + _CRLF 
         Return Nil 
      ENDIF 
 
      IF !File( cArqVPB ) 
         cFalta += "  NAO EXISTE " + cArqVPB + _CRLF 
         Return Nil 
      ENDIF 
 
      cFalta += "  OK         " + cArqVPB + _CRLF 
 
      DBSelectArea( _COD_CONVVPB ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Use &cArqVPB Alias VPB Shared 
      IF !Used() 
         Aviso( "Existe algum arquivo do sistema aberto por outro aplicativo!" ) 
         Pausa() 
         Return Nil 
      ENDIF 
      aStrVPB := VPB->( DBSTRUCT() ) 
      lAbeVPB := VPB->( FLOCK() ) 
 
      DBSelectArea( _COD_CONVUPD ) 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
      Use &cArqUPD Alias UPD Shared 
      IF !Used() 
         !Mode CO80 
         Aviso( "Existe algum arquivo do sistema aberto por outro aplicativo!" ) 
         Pausa() 
         Quit 
      ENDIF 
      aStrUPD := UPD->( DBSTRUCT() ) 
      lAbeUPD := UPD->( FLOCK() ) 
 
      lFlagCreate := .F. 
 
      FOR J:= 1 TO LEN (aStrUPD) 
 
         IF ( nPosicao:= ASCAN( aStrVPB, { | x | x[1] == aStrUPD[ J, 1 ] } ) ) == 0 
               AAdd( aStrVPB, { aStrUPD[ J, 1 ],; 
                                aStrUPD[ J, 2 ],; 
                                aStrUPD[ J, 3 ],; 
                                aStrUPD[ J, 4 ] } ) 
               lFlagCreate:= .T. 
 
         ELSEIF aStrVPB[ nPosicao ][ 2 ] <> aStrUPD[ J ][ 2 ]
             SWAlerta( "Arquivo " + cArqVPB + " c/ diferencas; no campo " + aStrVPB[ nPosicao ][ 1 ] + ".; Formato tem que ser " + aStrUPD[ nPosicao ][ 2 ] + ".",  { " OK " } ) 
             Quit
         // Aumenta campos caso necessario
         ELSEIF aStrVPB[ nPosicao ][ 3 ] < aStrUPD[ J ][ 3 ]
             aStrVPB[ nPosicao ][ 3 ]:= aStrUPD[ J, 3 ]
             lFlagCreate:= .T. 
         ENDIF 
 
      NEXT J 
 
      VPB ->( DBCloseArea() ) 
      UPD ->( DBCloseArea() ) 
 
      IF (lFlagCreate = .T.) 
 
         /** Caso nao conseguiu Abrir c/ exclusividade **/ 
         IF ( lAbeVPB == .F. .OR. lAbeUPD == .F. ) 
            SetColor( "15/00" ) 
            CLS 
            VPBox( 01, 18, 20, 59, "ATUALIZACAO DO SISTEMA" ,"15/09" ) 
            VPObsBox( .T., 3, 20, ,; 
                               { "                                    ",; 
                                 " Voc� est� rodando uma vers�o  mais ",; 
                                 "                                    ",; 
                                 " atual do sistema, portanto, alguns ",; 
                                 "                                    ",; 
                                 " arquivos necessitam serem  conver- ",; 
                                 "                                    ",; 
                                 " tidos.                             ",; 
                                 "                                    ",; 
                                 " Feche o sistema nas outros  termi- ",; 
                                 "                                    ",; 
                                 " nais caso esteja em rede e apos re ",; 
                                 "                                    ",; 
                                 " inicie o mesmo.                    ",; 
                                 "                                    " }, "15/00", .F. ) 
            Pausa() 
            DBCLoseAll() 
            Cls 
            Quit 
         ENDIF 
 
         Mensagem( "Convertendo " + cArqVPB + " ..." ) 
         // Salvamento do arquivo ATUAL para ANTERIOR ( ... *.001, *.002, ...) 
         nCnt := 0 
         WHILE (.T.) 
            nCnt ++ 
            cCnt := STRZERO (nCnt, 3) 
            cArqANT := LEFT (ALLTRIM (cArq), LEN (ALLTRIM (cArq)) - 4) 
            IF (FILE (cArqANT + ".&cCnt") = .T.) 
               LOOP 
            ENDIF 
            FRENAME (cArqVPB, cArqANT + ".&cCnt") 
            cArqNNN := cArqANT + ".&cCnt" 
            EXIT 
         END 
 
         // Criacao do arquivo NOVO com a nova estrutura 
         cArqNOV := LEFT (ALLTRIM (cArq), LEN (ALLTRIM (cArq)) - 4) + ".NOV" 
         DBSelectAr( _COD_CONVARQ ) 
         DBCreate( "&cArqNOV", aStrVPB ) 
 
         // Incorporacao do arquivo ANTERIOR no arquivo NOVO 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
         Use &cArqNOV Alias NOV 
         Append From &cArqNNN 
         NOV -> (DBCloseArea ()) 
 
         // Restauracao no nome do arquivo ANTERIOR 
         FRENAME (cArqNOV, cArqVPB) 
 
      ENDIF 
 
   Return Nil 
 
