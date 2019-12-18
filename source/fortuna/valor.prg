// ## CL2HB.EXE - Converted
************************************************************************ 
* COMANDO            -  funcao de usuario                              * 
* FUNCAO             -  Div_Ext                                        * 
* PARAMENTROS        - <str_ext  - valor alfa-numerico - recebe uma va-* 
*                       riavel string, a qual sera dividida em duas str* 
*                       ings conf. i1 e i2.                            * 
*                      <i1       - valor numerico, tamanho a ser dividi* 
*                       da a string 1.                                 * 
*                      <i2       - valor numerico, tamanho total da str* 
*                       ing 1 mais string 2.                           * 
* DATA DE CRIACAO    -  19/11/90                                       * 
* ULTIMA MODIFICACAO -                                                 * 
* UTILIZACAO         -  Ajustar uma string p/ ser dividida em duas par-* 
*                       tes                                            * 
*                       por extenso                                    * 
* CRIADOR            -  Marcos R. de B. Ramires                        * 
************************************************************************ 
FUNCTION DivExt(STR_EXT,I1,I2) 
subs_ext = " " 
subs_ext1 = " " 
subs_ext2 = " " 
subs_ext3 = " " 
subs_ext4 = " " 
loc_spc = 0 
inc_spc = " " 
inc_ast = " " 
tstr_ext = 0 
str_ext = RTRIM(LTRIM(str_ext)) 
tstr_ext = LEN(str_ext) 
subs_ext = SUBSTR(str_ext,1,I1) 
loc_spc =  (i1+1)-RAT(" ",subs_ext) 
IF tstr_ext > i1 
   inc_spc = REPLICATE("*",loc_spc) 
   subs_ext1 = inc_spc + subs_ext 
   subs_ext2 = LTRIM(SUBST(str_ext,(i1+1))) 
   subs_ext3 = RTRIM(subs_ext1) + subs_ext2 
   tsubs_ext3 = LEN(subs_ext3) 
   inc_ast = REPLICATE("*",i2-tsubs_ext3) 
   subs_ext4 = subs_ext3 + inc_ast 
ELSE 
   inc_ast = REPLICATE("*",i2-tstr_ext+1) 
   subs_ext4 = str_ext + inc_ast 
ENDIF 
RETURN (subs_ext4) 
************************************************************************ 
* COMANDO            -  funcao de usuario                              * 
* FUNCAO             -  Val_ext                                        * 
* PARAMENTROS        -  V_ext  - tipo valor-numerico                   * 
* DATA DE CRIACAO    -  19/11/90                                       * 
* ULTIMA MODIFICACAO -                                                 * 
* UTILIZACAO         -  Transformacao de valores numericos, em valores * 
*                       por extenso                                    * 
* CRIADOR            -  Marcos R. de B. Ramires                        * 
************************************************************************ 
FUNCTION ValExt( v_ext ) 
SET DECIMALS TO 2 
PRIVATE CENTENA[10], DEZENA[20], UNIDADE[10] 
PRIVATE valor1 
 
IF v_ext <= 0 
   Return "" 
ENDIF 
 
centena[1]= "CENTO" 
centena[2]= "DUZENTOS" 
centena[3]= "TREZENTOS" 
centena[4]= "QUATROCENTOS" 
centena[5]= "QUINHENTOS" 
centena[6]= "SEISCENTOS" 
centena[7]= "SETECENTOS" 
centena[8]= "OITOCENTOS" 
centena[9]= "NOVECENTOS" 
dezena[1]= "DEZ" 
dezena[2]= "VINTE" 
dezena[3]= "TRINTA" 
dezena[4]= "QUARENTA" 
dezena[5]= "CINQUENTA" 
dezena[6]= "SESSENTA" 
dezena[7]= "SETENTA" 
dezena[8]= "OITENTA" 
dezena[9]= "NOVENTA" 
dezena[10]= "DEZ" 
dezena[11]= "ONZE" 
dezena[12]= "DOZE" 
dezena[13]= "TREZE" 
dezena[14]= "QUATORZE" 
dezena[15]= "QUINZE" 
dezena[16]= "DEZESSEIS" 
dezena[17]= "DEZESSETE" 
dezena[18]= "DEZOITO" 
dezena[19]= "DEZENOVE" 
unidade[1]= "UM" 
unidade[2]= "DOIS" 
unidade[3]= "TRES" 
unidade[4]= "QUATRO" 
unidade[5]= "CINCO" 
unidade[6]= "SEIS" 
unidade[7]= "SETE" 
unidade[8]= "OITO" 
unidade[9]= "NOVE" 
STORE 0 TO a,b,c,d,e,f,g,h,i,l,m 
milh_ext = " " 
valor1 = STRZERO(v_ext,12,2) 
quant_alg = LEN(valor1) 
a = VAL(SUBSTR(valor1,1,1)) 
b = VAL(SUBSTR(valor1,2,1)) 
c = VAL(SUBSTR(valor1,3,1)) 
d = VAL(SUBSTR(valor1,4,1)) 
e = VAL(SUBSTR(valor1,5,1)) 
f = VAL(SUBSTR(valor1,6,1)) 
g = VAL(SUBSTR(valor1,7,1)) 
h = VAL(SUBSTR(valor1,8,1)) 
i = VAL(SUBSTR(valor1,9,1)) 
j = VAL(SUBSTR(valor1,10,1)) 
l = VAL(SUBSTR(valor1,11,1)) 
m = VAL(SUBSTR(valor1,12,1)) 
abc_ext = SUBSTR(valor1,1,3) 
IF abc_ext # "000" 
   IF quant_alg <= 12 .OR. quant_alg > 9 
      wbc_ext = SUBSTR(valor1,2,2) 
      vbc_ext = VAL(wbc_ext) 
      IF abc_ext = "100" 
         milh_ext = milh_ext + "CEM" 
      ELSE 
         IF a # 0 
            milh_ext = milh_ext + centena[a] 
            IF vbc_ext < 10 .OR. vbc_ext > 19 
               IF b # 0 
                  milh_ext = milh_ext + " E " + dezena[b] 
               ENDIF 
               IF  c # 0 
                   milh_ext = milh_ext + " E " + unidade[c] 
               ENDIF 
            ELSE 
               IF vbc_ext # 0 
                  milh_ext = milh_ext + " E " + dezena[vbc_ext] 
               ENDIF 
            ENDIF 
         ELSE 
            IF vbc_ext < 10 .OR. vbc_ext > 19 
               IF b # 0 
                  milh_ext = milh_ext + dezena[b] 
                  IF c # 0 
                     milh_ext = milh_ext + " E " + unidade[c] 
                  ENDIF 
               ELSE 
                  IF c # 0 
                     milh_ext = milh_ext + unidade[c] 
                  ENDIF 
               ENDIF 
            ELSE 
               IF vbc_ext # 0 
                  milh_ext = milh_ext + dezena [vbc_ext] 
               ENDIF 
            ENDIF 
         ENDIF 
      ENDIF 
      IF a # 0 .OR. b # 0 .OR. c # 1 
         milh_ext = milh_ext + " MILHOES" 
      ELSE 
         milh_ext = milh_ext + " MILHAO" 
      ENDIF 
   ENDIF 
ENDIF 
def_ext = SUBSTR(valor1,4,3) 
IF def_ext # "000" 
   IF abc_ext # "000" 
      milh_ext = milh_ext + ", " 
   ENDIF 
   IF quant_alg <= 12 .OR. quant_alg > 6 
      wef_ext = SUBSTR(valor1,5,2) 
      vef_ext = VAL(wef_ext) 
      IF def_ext = "100" 
         milh_ext = milh_ext + "CEM" 
      ELSE 
         IF d # 0 
            milh_ext = milh_ext + centena[d] 
            IF vef_ext < 10 .OR. vef_ext > 19 
               IF e # 0 
                  milh_ext = milh_ext + " E " + dezena[e] 
               ENDIF 
               IF f # 0 
                  milh_ext = milh_ext + " E " + unidade[f] 
               ENDIF 
            ELSE 
               IF vef_ext # 0 
                  milh_ext = milh_ext + " E " + dezena[vef_ext] 
               ENDIF 
            ENDIF 
         ELSE 
            IF vef_ext <= 10 .OR. vef_ext > 19 
               IF e # 0 
                  milh_ext = milh_ext + dezena[e] 
                  IF f # 0 
                     milh_ext = milh_ext + " E " + unidade[f] 
                  ENDIF 
               ELSE 
                  IF f # 0 
                     milh_ext = milh_ext + unidade[f] 
                  ENDIF 
               ENDIF 
            ELSE 
               IF vef_ext # 0 
                  milh_ext = milh_ext + dezena[vef_ext] 
               ENDIF 
            ENDIF 
         ENDIF 
      ENDIF 
      milh_ext = milh_ext + " MIL" 
   ENDIF 
ENDIF 
ghi_ext = SUBSTR(valor1,7,3) 
IF ghi_ext # "000" 
   IF def_ext # "000" .OR. abc_ext # "000" 
      milh_ext = milh_ext + ", " 
   ENDIF 
   IF quant_alg <= 12 .OR. quant_alg > 6 
      whi_ext = SUBSTR(valor1,8,2) 
      vhi_ext = VAL(whi_ext) 
      IF ghi_ext = "100" 
         milh_ext = milh_ext + "CEM" 
      ELSE 
         IF g # 0 
            milh_ext = milh_ext + centena[g] 
            IF vhi_ext < 10 .OR. vhi_ext > 19 
               IF h # 0 
                  milh_ext = milh_ext + " E " + dezena[h] 
               ENDIF 
               IF i # 0 
                  milh_ext = milh_ext + " E " + unidade[i] 
               ENDIF 
            ELSE 
               IF vhi_ext # 0 
                  milh_ext = milh_ext + " E " + dezena[vhi_ext] 
               ENDIF 
            ENDIF 
         ELSE 
            IF vhi_ext < 10 .OR. vhi_ext > 19 
               IF h # 0 
                  milh_ext = milh_ext + dezena[h] 
                  IF i # 0 
                     milh_ext = milh_ext + " E " + unidade[i] 
                  ENDIF 
               ELSE 
                  IF i # 0 
                     milh_ext = milh_ext + unidade[i] 
                  ENDIF 
               ENDIF 
            ELSE 
               IF vhi_ext # 0 
                  milh_ext = milh_ext + dezena[vhi_ext] 
               ENDIF 
            ENDIF 
         ENDIF 
      ENDIF 
   ENDIF 
ENDIF 
IF def_ext # "000" .OR. val(ghi_ext) > 1 
   milh_ext = milh_ext + " REAIS" 
ELSEIF abc_ext = "000" .AND. def_ext = "000" .and. ghi_ext = "001" 
   milh_ext = milh_ext + " REAL" 
ELSE 
   milh_ext = milh_ext + " DE REAIS" 
ENDIF 
wlm_ext = SUBSTR(valor1,11,2) 
IF wlm_ext # "00" 
   IF quant_alg <= 12 .AND. quant_alg > 3 
      milh_ext = milh_ext + ", " 
   ENDIF 
   IF quant_alg <= 12 .OR. quant_alg > 0 
      vlm_ext = VAL(wlm_ext) 
      IF vlm_ext < 10 .OR. vlm_ext > 19 
         IF l # 0 
            milh_ext = milh_ext + dezena[l] 
         ENDIF 
         IF l # 0 .AND. m # 0 
            milh_ext = milh_ext + " E " + unidade[m] 
         ENDIF 
         IF L = 0 .AND. M # 0 
            milh_ext = milh_ext + unidade[m] 
         ENDIF 
      ELSE 
         IF vlm_ext # 0 
            milh_ext = milh_ext + dezena[vlm_ext] 
         ENDIF 
      ENDIF 
   ENDIF 
   IF vlm_ext > 1 
      milh_ext = milh_ext + " CENTAVOS" 
   ELSE 
      milh_ext = milh_ext + " CENTAVO" 
   ENDIF 
ENDIF 
RETURN (MILH_EXT) 
 
