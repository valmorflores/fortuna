## CL2HB.EXE - Converted
#Include "INKEY.CH" 
#Include "VPF.CH" 
 
/***** 
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
³ Funcao      ³ VPC12300 
³ Finalidade  ³ 
³ Parametros  ³ 
³ Retorno     ³ 
³ Programador ³ 
³ Data        ³ 
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
*/

#ifdef HARBOUR
function vpc12300()
#endif


Local cCor:= SetColor(), nCursor:= SetCursor(),; 
      cTela:= ScreenSave( 0, 0, 24, 79 ) 
Local cContaT:= cContaR:= cContaD:= cCaixa:= "N" 
// ## CL2HB-ERRO - Talvez estas linhas ainda necessitem de correcoes, verifique
  UserScreen() 
  VPBox( 00, 00, 22, 79, "Zeramento de saldos - Contas", _COR_GET_BOX ) 
  SetColor( _COR_GET_EDICAO ) 
  @ 03,02 Say "Zeramento de contas?                " Get cContaT 
  @ 04,02 Say "Zeramento de lancamentos em Caixa?  " Get cCaixa 
  @ 05,02 Say "Zeramento de Contas a Pagar?        " 
  @ 06,02 Say "Zeramento de Contas a Receber?      " 
  READ 
 
  IF !LastKey()==K_ESC 
     IF cCaixa $ "Ss" 
        DBSelectAr( _COD_MOVIMENTO ) 
        DBGoTop() 
        WHILE !EOF() 
            IF NetRlock() 
               Dele 
            ENDIF 
            DBSkip() 
        ENDDO 
     ENDIF 
     DBSelectAr( _COD_BANCO ) 
     IF cContaT $ "Ss" 
        DBGoTop() 
        WHILE !EOF() 
           IF NetRLock() 
              Replace SALDO_ With 0 
           ENDIF 
           DBSkip() 
        ENDDO 
     ENDIF 
     DBSelectAr( _COD_DESPESAS ) 
     IF cContaT $ "Ss" 
        DBGoTop() 
        WHILE !EOF() 
           IF NetRLock() 
              Replace SALDO_ With 0 
           ENDIF 
           DBSkip() 
        ENDDO 
     ENDIF 
     DBSelectAr( _COD_RECEITAS ) 
     IF cContaT $ "Ss" 
        DBGoTop() 
        WHILE !EOF() 
           IF NetRLock() 
              Replace SALDO_ With 0 
           ENDIF 
           DBSkip() 
        ENDDO 
     ENDIF 
  ENDIF 
  SetColor( cCor ) 
  SetCursor( nCursor ) 
  ScreenRest( cTela ) 
  Return Nil 
