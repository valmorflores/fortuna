#include "\dev\include\vpf.ch"

para cArquivo
Priv cDirEmp
priv XCONFIG:=.T.
priv WPESQSN:=WSIMNAO:="", GDIR2SUB:= "DADOS", _VP2:=.t., WHELP:=.f.
priv COR:={"15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01",;
           "15/01","15/01","15/01","15/01","15/01","15/01","15/01"}

Priv _EMP, _END, _END1, _END2, _CD, _COMSENHA, _COMDATA, _COMSOM, _MARGEM
priv _COMSOMBRA, _COMZOOM, nMAXLIN:=24, nMAXCOL:=79
priv _VIDEO_LIN:=25, _VIDEO_COL:=80
priv cPODER, nGCODUSER:= 0, cUserGrupo:= "000", nCodUser:= 0
priv AbreArquivosInicio:= .T.

Public lERRO:=.F.

GDIR:= "DADOS"

ModoVGA( .F. )

// Relatorio
Relatorio( cArquivo, "\" + curdir() )

