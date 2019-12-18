//fDepur ("SWPDV.DEP", REPL ("�", 60), .T.)
//fDepur ("SWPDV.DEP", "SWPDV.PRG : 1 : cFormula = [" + cFormula + "]")
//fDepur ("SWPDV.DEP", "SWPDV.PRG : 2 : cFormula = [" + Str (&cFormula, 10) + "]")
// 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   Function fDepur (cArq, cTex, lNovo)

      IIF (lNovo == NIL, lNovo == .F., NIL)

      IF (FILE (cArq) == .F. .OR. lNovo == .T.)
         cTmp := ""
         cDat := DTOC (DATE ()) + " " + TIME ()
      ELSE
         cTmp := MEMOREAD (cArq)
         cDat := ""
      ENDIF

      cPro := Left (Alltrim (ProcName (1)) + Space (12), 12)
      cLin := Str (ProcLine (1), 6)

      MEMOWRIT (cArq, cTmp + cPro + " " + cLin + " : " + cTex + " " + cDat + ;
                CHR (13) + CHR (10))

   Return (.T.)
fDepur ("SWPDV.DEP", "SWPDV.PRG : 1 : cFormula  = [" + cFormula + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 2 : EcFormula = [" + Str (&cFormula, 10) + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 3 : nPgtXXX   = [" +      nPgtXXX        + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 4 : EnPgtXXX  = [" + Str (&nPgtXXX , 10) + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 5 : cFormula  = [" + cFormula + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 6 : EcFormula = [" + Str (&cFormula, 10) + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 7 : nPgtXXX   = [" +      nPgtXXX        + "]")
fDepur ("SWPDV.DEP", "SWPDV.PRG : 8 : EnPgtXXX  = [" + Str (&nPgtXXX , 10) + "]")
