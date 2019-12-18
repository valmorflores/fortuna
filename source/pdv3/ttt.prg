

      Clear
      nPar := ""
      cPgtTic := Space (40)

      While (LastKey () <> 27)
         @ 12, 30 Say "F¢rmula   :" GET cPgtTic
         READ
         @ 14, 30 Say "Resultado :" + Str (&cPgtTic)
      End

