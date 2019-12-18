SELE 1
USE DADOS\CDMPRIMA.VPB
INDEX ON INDICE TO IND001.NTX
SELE 2
USE DADOS\CESTOQUE.VPB
INDEX ON CPROD_ TO IND002.NTX

DBGOTOP()
WHILE !EOF()
   IF CPROD_==cVelhoProd
      IF EntSai=="+"
         nSaldo+=Quant_
      ELSE
         nSaldo-=Quant_
      ENDIF
   ELSE
      DBSelctAr( 1 )
      DBSeek(

