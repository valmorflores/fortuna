## CL2HB.EXE - Converted
#Include "inkey.ch" 
#Include "vpf.ch" 
 
/***** 
�������������Ŀ 
� Funcao      � VPC12300 
� Finalidade  � 
� Parametros  � 
� Retorno     � 
� Programador � 
� Data        � 
��������������� 
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
            IF netrlock() 
               Dele 
            ENDIF 
            DBSkip() 
        ENDDO 
     ENDIF 
     DBSelectAr( _COD_BANCO ) 
     IF cContaT $ "Ss" 
        DBGoTop() 
        WHILE !EOF() 
           IF netrlock() 
              Replace SALDO_ With 0 
           ENDIF 
           DBSkip() 
        ENDDO 
     ENDIF 
     DBSelectAr( _COD_DESPESAS ) 
     IF cContaT $ "Ss" 
        DBGoTop() 
        WHILE !EOF() 
           IF netrlock() 
              Replace SALDO_ With 0 
           ENDIF 
           DBSkip() 
        ENDDO 
     ENDIF 
     DBSelectAr( _COD_RECEITAS ) 
     IF cContaT $ "Ss" 
        DBGoTop() 
        WHILE !EOF() 
           IF netrlock() 
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
