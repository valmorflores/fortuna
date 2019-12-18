// ## CL2HB.EXE - Converted
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ TROCAFONTE 
³ Finalidade  ³ 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ Valmor Pereira Flores 
³ Data        ³ 
³             ³ 
³ Atualizacao ³ Abril/1996 - Criacao de Fontes no Formato Peter Norton 
³             ³ Abril/1998 - Criacao de logotipos SOFT&WARE Inform tica. 
³             ³ Jun/1998   - Melhoria no tratamento permitindo que sejam desenhados 
³             ³              caracteres ao inves de colocado o numero binario 
³             ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/ 
 
/****************************** 
* Function Name: TrocaFonte 
* Purpose: Trocar os caracteres de tela 
* Parameters: lFlag 
* Programador:Luciano Rosa 
* Data: Domingo, 10 de setembro de 1995 …s 03:29 horas 
**********/ 
FUNCTION TrocaFonte( lFlag ) 
** 
 
LOCAL cCanto1 
LOCAL cCanto2 
LOCAL cCanto3 
LOCAL cCanto4 
LOCAL cHoriz1 
LOCAL cHoriz2 
LOCAL cVert1 
LOCAL cVert2 
LOCAL cClose1 
LOCAL cClose2 
LOCAL cSeta11 
LOCAL cSeta12 
LOCAL cSeta21 
LOCAL cSeta22 
 
STATIC cCanto1Old 
STATIC cCanto2Old 
STATIC cCanto3Old 
STATIC cCanto4Old 
STATIC cHoriz1Old 
STATIC cHoriz2Old 
STATIC cVert1Old 
STATIC cVert2Old 
 
STATIC cClose1Old 
STATIC cClose2Old 
STATIC cSeta11Old 
STATIC cSeta12Old 
STATIC cSeta21Old 
STATIC cSeta22Old 
 
 
 
 
lFlag := IF(EMPTY( lFlag) , .t., lFlag ) 
 
IF lFlag 
   cCanto1 := CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") ) 
 
   cCanto2 := CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") ) 
 
   cCanto3 := CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("11111111") ) 
 
   cCanto4 := CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("11111111") ) 
 
 
   cHoriz1 := CHR( Bin2Num("11111111") )+;   // Horizontal de cima 
           CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") ) 
 
   cHoriz2 := CHR( Bin2Num("00000000") )+;  // Horizontal de baixo */ 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("00000000") )+; 
           CHR( Bin2Num("11111111") )+; 
           CHR( Bin2Num("11111111") ) 
 
   cVert1  := CHR( Bin2Num("11000000") )+;   //* Vertical da direita */ 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") )+; 
           CHR( Bin2Num("11000000") ) 
 
   cVert2  := CHR( Bin2Num("00000011") )+;   //* Vertical da Esquerda*/ 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") )+; 
           CHR( Bin2Num("00000011") ) 
 
 
  cClose1 :=  CHR( Bin2Num("00000000") )+;   //* Parte 1 do Sinal de fechamento */ 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01000000") )+; 
           CHR( Bin2Num("01000000") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("01111111") )+; 
           CHR( Bin2Num("00000000") ) 
 
  cClose2 :=  CHR( Bin2Num("00000000") )+;   //* Parte 2 do Sinal de fechamento */ 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("00001010") )+; 
           CHR( Bin2Num("00001010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("11111010") )+; 
           CHR( Bin2Num("00000010") ) 
 
cSeta11 := CHR( Bin2Num("11111111") )+;  //* Parte um da seta da barra de scroll 
           CHR( Bin2Num("10000000") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000111") )+; 
           CHR( Bin2Num("10001111") )+; 
           CHR( Bin2Num("10011111") )+; 
           CHR( Bin2Num("10111111") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000000") )+; 
           CHR( Bin2Num("11111111") ) 
 
cSeta12 := CHR( Bin2Num("11111111") )+;   //* Parte 2 da seta da barra de scroll 
           CHR( Bin2Num("00000001") )+; 
           CHR( Bin2Num("00000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("11000001") )+; 
           CHR( Bin2Num("11100001") )+; 
           CHR( Bin2Num("11110001") )+; 
           CHR( Bin2Num("11111001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("00000001") )+; 
           CHR( Bin2Num("11111111") ) 
 
cSeta21 := CHR( Bin2Num("11111111") )+;  //* Parte um da seta da barra de scroll 
           CHR( Bin2Num("10000000") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10111111") )+; 
           CHR( Bin2Num("10011111") )+; 
           CHR( Bin2Num("10001111") )+; 
           CHR( Bin2Num("10000111") )+; 
           CHR( Bin2Num("10000011") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000000") )+; 
           CHR( Bin2Num("11111111") ) 
 
cSeta22 := CHR( Bin2Num("11111111") )+;   //* Parte 2 da seta da barra de scroll 
           CHR( Bin2Num("00000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("11111001") )+; 
           CHR( Bin2Num("11110001") )+; 
           CHR( Bin2Num("11100001") )+; 
           CHR( Bin2Num("11000001") )+; 
           CHR( Bin2Num("10000001") )+; 
           CHR( Bin2Num("00000001") )+; 
           CHR( Bin2Num("00000001") )+; 
           CHR( Bin2Num("11111111") ) 
 
asw1:=     {"                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        "} 
aSW2:=     {"                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        ",; 
            "                                        "} 
 
 
aEnter:=   {"                                        ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            " °                                    ° ",; 
            " °                                    ° ",; 
            " °  °°°°° °°   ° °°°°° °°°°°° °°°°    ° ",; 
            " °  °     °°   °   °   °      °   °   ° ",; 
            " °  °°°°  ° °  °   °   °°°°°  °°°°    ° ",; 
            " °  °     °  ° °   °   °      °   °   ° ",; 
            " °  °°°°° °   °°   °   °°°°°° °    °  ° ",; 
            " °                                    ° ",; 
            " °                                    ° ",; 
            " °                                    ° ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            "                                        "} 
 
 
aEsc     :={"                                ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            " °                            ° ",; 
            " °                            ° ",; 
            " °    °°°°° °°°°°° °°°°°      ° ",; 
            " °    °     °      °          ° ",; 
            " °    °°°°  °°°°°° °          ° ",; 
            " °    °          ° °          ° ",; 
            " °    °°°°° °°°°°° °°°°°      ° ",; 
            " °                            ° ",; 
            " °                            ° ",; 
            " °                            ° ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            "                                "} 
 
aTab     :={"                                ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            " °                            ° ",; 
            " °                            ° ",; 
            " °    °°°°° °°°°°° °°°°°      ° ",; 
            " °      °   °    ° °   °      ° ",; 
            " °      °   °°°°°° °°°°       ° ",; 
            " °      °   °    ° °   °      ° ",; 
            " °      °   °    ° °°°°°      ° ",; 
            " °                            ° ",; 
            " °                            ° ",; 
            " °                            ° ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            "                                "} 
 
 
aSetas:=   {"                                ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            " °              °             ° ",; 
            " °      °       °      °      ° ",; 
            " °     °°°      °      °      ° ",; 
            " °    °°°°°     °      °      ° ",; 
            " °   °°°°°°°    °      °      ° ",; 
            " °      °       °   °°°°°°°   ° ",; 
            " °      °       °    °°°°°    ° ",; 
            " °      °       °     °°°     ° ",; 
            " °      °       °      °      ° ",; 
            " °              °             ° ",; 
            " °°°°°°°°°°°°°°°°°°°°°°°°°°°°°° ",; 
            "                                "} 
 
aCirculo:= {"                ",; 
            "     °°°°°°     ",; 
            "   °°      °°   ",; 
            "  °          °  ",; 
            "  °          °  ",; 
            " °            ° ",; 
            " °            ° ",; 
            " °            ° ",; 
            " °            ° ",; 
            "  °          °  ",; 
            "  °          °  ",; 
            "   °°      °°   ",; 
            "     °°°°°°     ",; 
            "                "} 
 
aNaoFume:= {"                ",; 
            "     °°°°°°     ",; 
            "   °°      °°   ",; 
            "  °        ° °  ",; 
            "  °       °  °  ",; 
            " °   °   °    ° ",; 
            " ° °°°  °     ° ",; 
            " °  °°°° °°°° ° ",; 
            " °    °       ° ",; 
            "  °  °       °  ",; 
            "  ° °        °  ",; 
            "   °°      °°   ",; 
            "     °°°°°°     ",; 
            "                "} 
aLateral:= {"        ",; 
            "°°°     ",; 
            "° °     ",; 
            "° °°°   ",; 
            "°   °   ",; 
            "°°  °°° ",; 
            " °    °°",; 
            " °    °°",; 
            "°°  °°° ",; 
            "°   °   ",; 
            "° °°°   ",; 
            "° °     ",; 
            "°°°     ",; 
            "        "} 
 
aChar135:= {"        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        ",; 
            "        "} 
 
 
 
aSW:=      {"                ",; 
            "                ",; 
            "                ",;
            "     °°°° °     ",; 
            "   °°°°    °°   ",; 
            " °°°°  °°°  °°° ",; 
            " °°°  °°°°°°°°° ",; 
            " °°°°     °°°°° ",;
            " °°°°°°°°  °°°° ",; 
            " °°°  °°°°  °°° ",; 
            "   °°      °°   ",; 
            "    °° °°°°     ",; 
            "                ",; 
            "                "}
 
 
aFone:=    {"                ",; 
            "     °°°°°°     ",; 
            "    °°°°°°°°    ",; 
            "   °°      °°   ",; 
            "  °°°°    °°°°  ",; 
            "                ",; 
            "     °°°°°°     ",; 
            "    °°°  °°°    ",; 
            "  °°°°    °°°°  ",; 
            "  °°°°    °°°°  ",; 
            "  °°°°°°°°°°°°  ",; 
            "                ",; 
            "                ",; 
            "                "} 
 
 
aMenos:=   {"                ",; 
            "                ",; 
            " °°°°°°°°°°°°°° ",; 
            " °            ° ",; 
            " °            ° ",; 
            " °            ° ",; 
            " ° °°°°°°°°°° ° ",; 
            " °            ° ",; 
            " °            ° ",; 
            " °            ° ",; 
            " °°°°°°°°°°°°°° ",; 
            "                ",; 
            "                ",; 
            "                "} 
aMais:=   {"                ",; 
            "                ",; 
            " °°°°°°°°°°°°°° ",; 
            " °            ° ",; 
            " °     °°     ° ",; 
            " °     °°     ° ",; 
            " ° °°°°°°°°°° ° ",; 
            " °     °°     ° ",; 
            " °     °°     ° ",; 
            " °            ° ",; 
            " °°°°°°°°°°°°°° ",; 
            "                ",; 
            "                ",; 
            "                "} 
 
aBot1:=    {"               °",; 
            "              °°",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                "} 
 
aBot2:=    {"                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "°°°°°°°°°°°°°°°°",; 
            "°°°°°°°°°°°°°°°°"} 
 
 
aBot3:=    {"                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "°               ",; 
            "°°              "} 
 
 
aBot4:=    {"°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              ",; 
            "°°              "} 
 
 
aBot5:=    {"°°              ",; 
            "°               ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                "} 
 
aBot6:=    {"°°°°°°°°°°°°°°°°",; 
            "°°°°°°°°°°°°°°°°",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                "} 
 
aBot7:=    {"              °°",; 
            "               °",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                ",; 
            "                "} 
 
aBot8:=    {"              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°",; 
            "              °°"} 
 
  AtivaFonte( aBot1,    2   ) 
  AtivaFonte( aBot2,    3   ) 
  AtivaFonte( aBot3,    4   ) 
  AtivaFonte( aBot4,    5   ) 
  AtivaFonte( aBot5,    6   ) 
  AtivaFonte( aBot6,    7   ) 
  AtivaFonte( aBot7,    8   ) 
  AtivaFonte( aBot8,    9   ) 
  AtivaFonte( aEsc,     252 ) 
  AtivaFonte( aEnter,   229 ) 
  AtivaFonte( aNaoFume, 234 ) 
  AtivaFonte( aCirculo, 236 ) 
  AtivaFonte( aSetas,   238 ) 
  AtivaFonte( aLateral, 16 ) 
  AtivaFonte( aSw,      212 ) 
  AtivaFonte( aTab,     244 ) 
  AtivaFonte( aFone,    224 ) 
  AtivaFonte( aMais,    250 ) 
  AtivaFonte( aMenos,   251 ) 
 
  /* Salva os caracteres para posterior recuperacao */ 
  FontGet(181,FontHeight(), 1, @cCanto1Old ) 
  FontGet(182,FontHeight(), 1, @cCanto2Old ) 
  FontGet(184,FontHeight(), 1, @cCanto3Old ) 
  FontGet(185,FontHeight(), 1, @cCanto4Old ) 
  FontGet(186,FontHeight(), 1, @cHoriz1Old ) 
  FontGet(187,FontHeight(), 1, @cHoriz2Old ) 
  FontGet(188,FontHeight(), 1, @cVert1Old  ) 
  FontGet(189,FontHeight(), 1, @cVert2Old  ) 
  FontGet(210,FontHeight(), 1, @cClose1Old ) 
  FontGet(211,FontHeight(), 1, @cClose2Old ) 
  FontGet(212,FontHeight(), 1, @cSeta11Old ) 
  FontGet(213,FontHeight(), 1, @cSeta12Old ) 
  FontGet(214,FontHeight(), 1, @cSeta21Old ) 
  FontGet(215,FontHeight(), 1, @cSeta22Old ) 
 
  /* Seta a nova fonte de caracteres */ 
  FontPut(181,14, 1, cCanto1 ) 
  FontPut(182,14, 1, cCanto2 ) 
  FontPut(184,14, 1, cCanto3 ) 
  FontPut(185,14, 1, cCanto4 ) 
  FontPut(186,14, 1, cHoriz1 ) 
  FontPut(187,14, 1, cHoriz2 ) 
  FontPut(188,14, 1, cVert1  ) 
  FontPut(189,14, 1, cVert2  ) 
  FontPut(210,14, 1, cClose1 ) 
  FontPut(211,14, 1, cClose2 ) 
  FontPut(13,14,  1, cSeta11 ) 
  FontPut(14,14,  1, cSeta12 ) 
  FontPut(214,14, 1, cSeta21 ) 
  FontPut(215,14, 1, cSeta22 ) 
 
ELSE 
 
  /* Restaura a fonte de caracteres */ 
  FontPut(181,14, 1, cCanto1o1Old ) 
  FontPut(182,14, 1, cCanto2Old ) 
  FontPut(184,14, 1, cCanto3Old ) 
  FontPut(185,14, 1, cCanto4Old ) 
  FontPut(186,14, 1, cHoriz1Old ) 
  FontPut(187,14, 1, cHoriz2Old ) 
  FontPut(188,14, 1, cVert1Old  ) 
  FontPut(189,14, 1, cVert2Old  ) 
  FontPut(210,14, 1, cClose1Old ) 
  FontPut(211,14, 1, cClose2Old ) 
  FontPut(212,14, 1, cSeta11Old ) 
  FontPut(213,14, 1, cSeta12Old ) 
  FontPut(214,14, 1, cSeta21Old ) 
  FontPut(215,14, 1, cSeta22Old ) 
ENDIF 
 
FUNCTION AtivaFonte( aDesenho, nPosicao ) 
Local cVariavel:= "", aMatriz:= {}, nCont, nCt, nCt2 
 
    FOR nCt:= 1 TO Len( aDesenho[1] ) / 8 
        AAdd( aMatriz, "" ) 
    NEXT 
 
    FOR nCt:= 1 TO Len( aDesenho ) 
        aDesenho[ nCt ]:= StrTran( aDesenho[ nCt ], " ", "0" ) 
        aDesenho[ nCt ]:= StrTran( aDesenho[ nCt ], "°", "1" ) 
    NEXT 
 
    FOR nCt2:= 1 To Len( aDesenho ) 
        nCont:= 0 
        FOR nCt:= 1 TO Len( aDesenho[1] ) Step 8 
            cVariavel:= SubStr( aDesenho[nCt2], nCt, 8 ) 
            ++nCont 
            aMatriz[ nCont ] := aMatriz[ nCont ] + Chr( Bin2Num( cVariavel ) ) 
        NEXT 
    NEXT 
    nPosicao:= nPosicao - 1 
    FOR nCt:= 1 To Len( aMatriz ) 
        FontPut( nPosicao + nCt, 14, 1, aMatriz[ nCt ] ) 
    NEXT 
 
