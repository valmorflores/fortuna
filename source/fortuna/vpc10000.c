/*
 * xHarbour Compiler, build 91.1 (SimpLex)
 * Generated C source code from </dev/source/fortuna/vpc10000.prg>
 */

#include "hbvmpub.h"
#include "hbpcode.h"
#include "hbinit.h"

#define __PRG_SOURCE__ "/dev/source/fortuna/vpc10000.prg"

HB_FUNC( VPC10000 );
HB_FUNC( MENUCOMUNICA );
HB_FUNC_STATIC( PANARELLO );
HB_FUNC_STATIC( BARROS );
HB_FUNC_STATIC( GLASURIT );
HB_FUNC_STATIC( CGLASURIT );
HB_FUNC_STATIC( RENNER );
HB_FUNC_STATIC( ACS );
HB_FUNC( ABAFARMA );
HB_FUNC_STATIC( SOFTWARE );
HB_FUNC( EMPRESA );
HB_FUNC( INCLUIEMP );
HB_FUNC( ALTERAEMP );
HB_FUNC( EXPTOLEDO );
HB_FUNC( DIGTOLEDO );
HB_FUNC( EXPWINLIVROS );
extern HB_FUNC( ZOOM );
extern HB_FUNC( SETCOLOR );
extern HB_FUNC( VPBOX );
extern HB_FUNC( MENSAGEM );
extern HB_FUNC( AADD );
extern HB_FUNC( swmenunew );
extern HB_FUNC( swMenu );
extern HB_FUNC( DISPLAYUSUARIOS );
extern HB_FUNC( VPC14300 );
extern HB_FUNC( VPC15000 );
extern HB_FUNC( TRANSFERENCIA );
extern HB_FUNC( MENULIMPA );
extern HB_FUNC( VIEWFILE );
extern HB_FUNC( UNZOOM );
extern HB_FUNC( SETCURSOR );
extern HB_FUNC( SCREENSAVE );
extern HB_FUNC( IMPORTAPEDIDOS );
extern HB_FUNC( PCF );
extern HB_FUNC( VISUALCOMUNICACAO );
extern HB_FUNC( VPBOXSOMBRA );
extern HB_FUNC( TBROWSENEW );
extern HB_FUNC( TBCOLUMNNEW );
extern HB_FUNC( LEN );
extern HB_FUNC( SKIPPERARR );
extern HB_FUNC( NEXTKEY );
extern HB_FUNC( INKEY );
extern HB_FUNC( CALCULADOR );
extern HB_FUNC( CALENDAR );
extern HB_FUNC( SWSET );
extern HB_FUNC( TONE );
extern HB_FUNC( SCREENREST );
extern HB_FUNC( IPRECOPANARELLO );
extern HB_FUNC( INFPANARELLO );
extern HB_FUNC( IPRODBARROS );
extern HB_FUNC( IFABBARROS );
extern HB_FUNC( IGLASBASE );
extern HB_FUNC( IGLASFORMULA );
extern HB_FUNC( ICGLASPRO );
extern HB_FUNC( RENNERPRECO );
extern HB_FUNC( IACSBASE );
extern HB_FUNC( IACSPRECO );
extern HB_FUNC( IPRODPREABAFAR );
extern HB_FUNC( IPRODABAFAR );
extern HB_FUNC( IFABABAFAR );
extern HB_FUNC( CURDIR );
extern HB_FUNC( AT );
extern HB_FUNC( __RUN );
extern HB_FUNC( DISPBEGIN );
extern HB_FUNC( MODOVGA );
extern HB_FUNC( DISPEND );
extern HB_FUNC( SETBLINK );
extern HB_FUNC( ISWESTOQUE );
extern HB_FUNC( ISWBASECOBRANCA );
extern HB_FUNC( ESWCLIENTE );
extern HB_FUNC( ISWCLIENTE );
extern HB_FUNC( ISWPRODUTO );
extern HB_FUNC( SAVESCREEN );
extern HB_FUNC( FILE );
extern HB_FUNC( DBCREATE );
extern HB_FUNC( DBSELECTAR );
extern HB_FUNC( DBUSEAREA );
extern HB_FUNC( DBCREATEINDEX );
extern HB_FUNC( ORDLISTCLEAR );
extern HB_FUNC( SETDIRETORIOPADRAO );
extern HB_FUNC( SELECT );
extern HB_FUNC( ORDLISTADD );
extern HB_FUNC( RESTDIRETORIOPADRAO );
extern HB_FUNC( DBGOTOP );
extern HB_FUNC( AJUDA );
extern HB_FUNC( DBLEORDEM );
extern HB_FUNC( TBROWSEDB );
extern HB_FUNC( STRZERO );
extern HB_FUNC( SPACE );
extern HB_FUNC( ALLTRIM );
extern HB_FUNC( VAL );
extern HB_FUNC( SUBSTR );
extern HB_FUNC( EOF );
extern HB_FUNC( CHR );
extern HB_FUNC( LEFT );
extern HB_FUNC( RECNO );
extern HB_FUNC( CONFIG );
extern HB_FUNC( SCROLL );
extern HB_FUNC( RESTSCREEN );
extern HB_FUNC( AVISO );
extern HB_FUNC( DBCLOSEALL );
extern HB_FUNC( ABREGRUPO );
extern HB_FUNC( DBSELECTAREA );
extern HB_FUNC( USED );
extern HB_FUNC( DBGOTO );
extern HB_FUNC( EXCLUI );
extern HB_FUNC( CONFIRMA );
extern HB_FUNC( DEVOUT );
extern HB_FUNC( ROW );
extern HB_FUNC( DBMUDAORDEM );
extern HB_FUNC( DBPESQUISA );
extern HB_FUNC( DBCLOSEAREA );
extern HB_FUNC( FECHAARQUIVOS );
extern HB_FUNC( LASTKEY );
extern HB_FUNC( PAD );
extern HB_FUNC( TITULO );
extern HB_FUNC( DATE );
extern HB_FUNC( INDEXORD );
extern HB_FUNC( SETPOS );
extern HB_FUNC( COL );
extern HB_FUNC( __GET );
extern HB_FUNC( READMODAL );
extern HB_FUNC( DBAPPEND );
extern HB_FUNC( FIELDPOS );
extern HB_FUNC( netrlock );
extern HB_FUNC( GRAVAEMDISCO );
extern HB_FUNC( DBSETORDER );
extern HB_FUNC( STR );
extern HB_FUNC( SET );
extern HB_FUNC( UPPER );
extern HB_FUNC( PROW );
extern HB_FUNC( PCOL );
extern HB_FUNC( DBSKIP );

#undef HB_PRG_PCODE_VER
#define HB_PRG_PCODE_VER 5

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_VPC10000 )
{ "VPC10000", HB_FS_PUBLIC | HB_FS_FIRST, HB_FUNCNAME( VPC10000 ), (PHB_DYNS) 1 },
{ "ZOOM", HB_FS_PUBLIC, HB_FUNCNAME( ZOOM ), NULL },
{ "SETCOLOR", HB_FS_PUBLIC, HB_FUNCNAME( SETCOLOR ), NULL },
{ "VPBOX", HB_FS_PUBLIC, HB_FUNCNAME( VPBOX ), NULL },
{ "MENSAGEM", HB_FS_PUBLIC, HB_FUNCNAME( MENSAGEM ), NULL },
{ "AADD", HB_FS_PUBLIC, HB_FUNCNAME( AADD ), NULL },
{ "MENULIST", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "swmenunew", HB_FS_PUBLIC, HB_FUNCNAME( swmenunew ), NULL },
{ "COR", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "swMenu", HB_FS_PUBLIC, HB_FUNCNAME( swMenu ), NULL },
{ "DISPLAYUSUARIOS", HB_FS_PUBLIC, HB_FUNCNAME( DISPLAYUSUARIOS ), NULL },
{ "VPC14300", HB_FS_PUBLIC, HB_FUNCNAME( VPC14300 ), NULL },
{ "VPC15000", HB_FS_PUBLIC, HB_FUNCNAME( VPC15000 ), NULL },
{ "MENUCOMUNICA", HB_FS_PUBLIC, HB_FUNCNAME( MENUCOMUNICA ), (PHB_DYNS) 1 },
{ "TRANSFERENCIA", HB_FS_PUBLIC, HB_FUNCNAME( TRANSFERENCIA ), NULL },
{ "EMPRESA", HB_FS_PUBLIC, HB_FUNCNAME( EMPRESA ), (PHB_DYNS) 1 },
{ "MENULIMPA", HB_FS_PUBLIC, HB_FUNCNAME( MENULIMPA ), NULL },
{ "VIEWFILE", HB_FS_PUBLIC, HB_FUNCNAME( VIEWFILE ), NULL },
{ "UNZOOM", HB_FS_PUBLIC, HB_FUNCNAME( UNZOOM ), NULL },
{ "SETCURSOR", HB_FS_PUBLIC, HB_FUNCNAME( SETCURSOR ), NULL },
{ "SCREENSAVE", HB_FS_PUBLIC, HB_FUNCNAME( SCREENSAVE ), NULL },
{ "IMPORTAPEDIDOS", HB_FS_PUBLIC, HB_FUNCNAME( IMPORTAPEDIDOS ), NULL },
{ "PCF", HB_FS_PUBLIC, HB_FUNCNAME( PCF ), NULL },
{ "ABAFARMA", HB_FS_PUBLIC, HB_FUNCNAME( ABAFARMA ), (PHB_DYNS) 1 },
{ "PANARELLO", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( PANARELLO ), (PHB_DYNS) 1 },
{ "BARROS", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( BARROS ), (PHB_DYNS) 1 },
{ "CGLASURIT", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( CGLASURIT ), (PHB_DYNS) 1 },
{ "GLASURIT", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( GLASURIT ), (PHB_DYNS) 1 },
{ "ACS", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( ACS ), (PHB_DYNS) 1 },
{ "RENNER", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( RENNER ), (PHB_DYNS) 1 },
{ "SOFTWARE", HB_FS_STATIC | HB_FS_PUBLIC, HB_FUNCNAME( SOFTWARE ), (PHB_DYNS) 1 },
{ "VISUALCOMUNICACAO", HB_FS_PUBLIC, HB_FUNCNAME( VISUALCOMUNICACAO ), NULL },
{ "EXPTOLEDO", HB_FS_PUBLIC, HB_FUNCNAME( EXPTOLEDO ), (PHB_DYNS) 1 },
{ "EXPWINLIVROS", HB_FS_PUBLIC, HB_FUNCNAME( EXPWINLIVROS ), (PHB_DYNS) 1 },
{ "AOPCOES", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "LOK", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "NROW", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "VPBOXSOMBRA", HB_FS_PUBLIC, HB_FUNCNAME( VPBOXSOMBRA ), NULL },
{ "TBROWSENEW", HB_FS_PUBLIC, HB_FUNCNAME( TBROWSENEW ), NULL },
{ "OTAB", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "ADDCOLUMN", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "TBCOLUMNNEW", HB_FS_PUBLIC, HB_FUNCNAME( TBCOLUMNNEW ), NULL },
{ "_AUTOLITE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "_GOTOPBLOCK", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "_GOBOTTOMBLOCK", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "LEN", HB_FS_PUBLIC, HB_FUNCNAME( LEN ), NULL },
{ "_SKIPBLOCK", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "SKIPPERARR", HB_FS_PUBLIC, HB_FUNCNAME( SKIPPERARR ), NULL },
{ "DEHILITE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "COLORRECT", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "ROWPOS", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "NEXTKEY", HB_FS_PUBLIC, HB_FUNCNAME( NEXTKEY ), NULL },
{ "STABILIZE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "INKEY", HB_FS_PUBLIC, HB_FUNCNAME( INKEY ), NULL },
{ "NTECLA", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CTELAG", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "UP", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "DOWN", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "PAGEUP", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "GOTOP", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "PAGEDOWN", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "GOBOTTOM", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CALCULADOR", HB_FS_PUBLIC, HB_FUNCNAME( CALCULADOR ), NULL },
{ "CALENDAR", HB_FS_PUBLIC, HB_FUNCNAME( CALENDAR ), NULL },
{ "SWSET", HB_FS_PUBLIC, HB_FUNCNAME( SWSET ), NULL },
{ "CCORRES", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "EVAL", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "TONE", HB_FS_PUBLIC, HB_FUNCNAME( TONE ), NULL },
{ "REFRESHCURRENT", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "SCREENREST", HB_FS_PUBLIC, HB_FUNCNAME( SCREENREST ), NULL },
{ "IPRECOPANARELLO", HB_FS_PUBLIC, HB_FUNCNAME( IPRECOPANARELLO ), NULL },
{ "INFPANARELLO", HB_FS_PUBLIC, HB_FUNCNAME( INFPANARELLO ), NULL },
{ "IPRODBARROS", HB_FS_PUBLIC, HB_FUNCNAME( IPRODBARROS ), NULL },
{ "IFABBARROS", HB_FS_PUBLIC, HB_FUNCNAME( IFABBARROS ), NULL },
{ "IGLASBASE", HB_FS_PUBLIC, HB_FUNCNAME( IGLASBASE ), NULL },
{ "IGLASFORMULA", HB_FS_PUBLIC, HB_FUNCNAME( IGLASFORMULA ), NULL },
{ "ICGLASPRO", HB_FS_PUBLIC, HB_FUNCNAME( ICGLASPRO ), NULL },
{ "RENNERPRECO", HB_FS_PUBLIC, HB_FUNCNAME( RENNERPRECO ), NULL },
{ "IACSBASE", HB_FS_PUBLIC, HB_FUNCNAME( IACSBASE ), NULL },
{ "IACSPRECO", HB_FS_PUBLIC, HB_FUNCNAME( IACSPRECO ), NULL },
{ "IPRODPREABAFAR", HB_FS_PUBLIC, HB_FUNCNAME( IPRODPREABAFAR ), NULL },
{ "IPRODABAFAR", HB_FS_PUBLIC, HB_FUNCNAME( IPRODABAFAR ), NULL },
{ "IFABABAFAR", HB_FS_PUBLIC, HB_FUNCNAME( IFABABAFAR ), NULL },
{ "CTELARES", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CURDIR", HB_FS_PUBLIC, HB_FUNCNAME( CURDIR ), NULL },
{ "CDIRETORIO", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CDRIVE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "AT", HB_FS_PUBLIC, HB_FUNCNAME( AT ), NULL },
{ "__RUN", HB_FS_PUBLIC, HB_FUNCNAME( __RUN ), NULL },
{ "DISPBEGIN", HB_FS_PUBLIC, HB_FUNCNAME( DISPBEGIN ), NULL },
{ "MODOVGA", HB_FS_PUBLIC, HB_FUNCNAME( MODOVGA ), NULL },
{ "DISPEND", HB_FS_PUBLIC, HB_FUNCNAME( DISPEND ), NULL },
{ "SETBLINK", HB_FS_PUBLIC, HB_FUNCNAME( SETBLINK ), NULL },
{ "ISWESTOQUE", HB_FS_PUBLIC, HB_FUNCNAME( ISWESTOQUE ), NULL },
{ "ISWBASECOBRANCA", HB_FS_PUBLIC, HB_FUNCNAME( ISWBASECOBRANCA ), NULL },
{ "ESWCLIENTE", HB_FS_PUBLIC, HB_FUNCNAME( ESWCLIENTE ), NULL },
{ "ISWCLIENTE", HB_FS_PUBLIC, HB_FUNCNAME( ISWCLIENTE ), NULL },
{ "ISWPRODUTO", HB_FS_PUBLIC, HB_FUNCNAME( ISWPRODUTO ), NULL },
{ "ATELAR2", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "NCOL", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "NCT", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "SAVESCREEN", HB_FS_PUBLIC, HB_FUNCNAME( SAVESCREEN ), NULL },
{ "NLIN", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "FILE", HB_FS_PUBLIC, HB_FUNCNAME( FILE ), NULL },
{ "ASTR", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "DBCREATE", HB_FS_PUBLIC, HB_FUNCNAME( DBCREATE ), NULL },
{ "DBSELECTAR", HB_FS_PUBLIC, HB_FUNCNAME( DBSELECTAR ), NULL },
{ "CDIREMP", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "DBUSEAREA", HB_FS_PUBLIC, HB_FUNCNAME( DBUSEAREA ), NULL },
{ "DBCREATEINDEX", HB_FS_PUBLIC, HB_FUNCNAME( DBCREATEINDEX ), NULL },
{ "CODIGO", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "DESCRI", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "ORDLISTCLEAR", HB_FS_PUBLIC, HB_FUNCNAME( ORDLISTCLEAR ), NULL },
{ "SETDIRETORIOPADRAO", HB_FS_PUBLIC, HB_FUNCNAME( SETDIRETORIOPADRAO ), NULL },
{ "SELECT", HB_FS_PUBLIC, HB_FUNCNAME( SELECT ), NULL },
{ "ORDLISTADD", HB_FS_PUBLIC, HB_FUNCNAME( ORDLISTADD ), NULL },
{ "RESTDIRETORIOPADRAO", HB_FS_PUBLIC, HB_FUNCNAME( RESTDIRETORIOPADRAO ), NULL },
{ "DBGOTOP", HB_FS_PUBLIC, HB_FUNCNAME( DBGOTOP ), NULL },
{ "AJUDA", HB_FS_PUBLIC, HB_FUNCNAME( AJUDA ), NULL },
{ "DBLEORDEM", HB_FS_PUBLIC, HB_FUNCNAME( DBLEORDEM ), NULL },
{ "TBROWSEDB", HB_FS_PUBLIC, HB_FUNCNAME( TBROWSEDB ), NULL },
{ "STRZERO", HB_FS_PUBLIC, HB_FUNCNAME( STRZERO ), NULL },
{ "SPACE", HB_FS_PUBLIC, HB_FUNCNAME( SPACE ), NULL },
{ "ALLTRIM", HB_FS_PUBLIC, HB_FUNCNAME( ALLTRIM ), NULL },
{ "GDIR", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "VAL", HB_FS_PUBLIC, HB_FUNCNAME( VAL ), NULL },
{ "SUBSTR", HB_FS_PUBLIC, HB_FUNCNAME( SUBSTR ), NULL },
{ "NCODIGO", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "NTENTATIVA", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "EOF", HB_FS_PUBLIC, HB_FUNCNAME( EOF ), NULL },
{ "REFRESHALL", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CHR", HB_FS_PUBLIC, HB_FUNCNAME( CHR ), NULL },
{ "ALTERAEMP", HB_FS_PUBLIC, HB_FUNCNAME( ALTERAEMP ), (PHB_DYNS) 1 },
{ "LEFT", HB_FS_PUBLIC, HB_FUNCNAME( LEFT ), NULL },
{ "RECNO", HB_FS_PUBLIC, HB_FUNCNAME( RECNO ), NULL },
{ "NRECNO", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CONFIG", HB_FS_PUBLIC, HB_FUNCNAME( CONFIG ), NULL },
{ "_EMP", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "NCT2", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "SCROLL", HB_FS_PUBLIC, HB_FUNCNAME( SCROLL ), NULL },
{ "RESTSCREEN", HB_FS_PUBLIC, HB_FUNCNAME( RESTSCREEN ), NULL },
{ "AVISO", HB_FS_PUBLIC, HB_FUNCNAME( AVISO ), NULL },
{ "DBCLOSEALL", HB_FS_PUBLIC, HB_FUNCNAME( DBCLOSEALL ), NULL },
{ "ABREGRUPO", HB_FS_PUBLIC, HB_FUNCNAME( ABREGRUPO ), NULL },
{ "DBSELECTAREA", HB_FS_PUBLIC, HB_FUNCNAME( DBSELECTAREA ), NULL },
{ "USED", HB_FS_PUBLIC, HB_FUNCNAME( USED ), NULL },
{ "DBGOTO", HB_FS_PUBLIC, HB_FUNCNAME( DBGOTO ), NULL },
{ "INCLUIEMP", HB_FS_PUBLIC, HB_FUNCNAME( INCLUIEMP ), (PHB_DYNS) 1 },
{ "EXCLUI", HB_FS_PUBLIC, HB_FUNCNAME( EXCLUI ), NULL },
{ "CONFIRMA", HB_FS_PUBLIC, HB_FUNCNAME( CONFIRMA ), NULL },
{ "GDIRRES", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "DEVOUT", HB_FS_PUBLIC, HB_FUNCNAME( DEVOUT ), NULL },
{ "ROW", HB_FS_PUBLIC, HB_FUNCNAME( ROW ), NULL },
{ "DBMUDAORDEM", HB_FS_PUBLIC, HB_FUNCNAME( DBMUDAORDEM ), NULL },
{ "DBPESQUISA", HB_FS_PUBLIC, HB_FUNCNAME( DBPESQUISA ), NULL },
{ "DBCLOSEAREA", HB_FS_PUBLIC, HB_FUNCNAME( DBCLOSEAREA ), NULL },
{ "FECHAARQUIVOS", HB_FS_PUBLIC, HB_FUNCNAME( FECHAARQUIVOS ), NULL },
{ "LASTKEY", HB_FS_PUBLIC, HB_FUNCNAME( LASTKEY ), NULL },
{ "PAD", HB_FS_PUBLIC, HB_FUNCNAME( PAD ), NULL },
{ "TITULO", HB_FS_PUBLIC, HB_FUNCNAME( TITULO ), NULL },
{ "DATE", HB_FS_PUBLIC, HB_FUNCNAME( DATE ), NULL },
{ "INDEXORD", HB_FS_PUBLIC, HB_FUNCNAME( INDEXORD ), NULL },
{ "SETPOS", HB_FS_PUBLIC, HB_FUNCNAME( SETPOS ), NULL },
{ "COL", HB_FS_PUBLIC, HB_FUNCNAME( COL ), NULL },
{ "GETLIST", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "__GET", HB_FS_PUBLIC, HB_FUNCNAME( __GET ), NULL },
{ "DISPLAY", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "READMODAL", HB_FS_PUBLIC, HB_FUNCNAME( READMODAL ), NULL },
{ "DBAPPEND", HB_FS_PUBLIC, HB_FUNCNAME( DBAPPEND ), NULL },
{ "ENDERE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "BAIRRO", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CIDADE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "ESTADO", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CODCEP", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CGCMF_", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "RESPON", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "DATA__", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "FIELDPOS", HB_FS_PUBLIC, HB_FUNCNAME( FIELDPOS ), NULL },
{ "netrlock", HB_FS_PUBLIC, HB_FUNCNAME( netrlock ), NULL },
{ "FILIAL", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "GRAVAEMDISCO", HB_FS_PUBLIC, HB_FUNCNAME( GRAVAEMDISCO ), NULL },
{ "DBSETORDER", HB_FS_PUBLIC, HB_FUNCNAME( DBSETORDER ), NULL },
{ "STR", HB_FS_PUBLIC, HB_FUNCNAME( STR ), NULL },
{ "SET", HB_FS_PUBLIC, HB_FUNCNAME( SET ), NULL },
{ "CPORTA", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "INDICE", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "CSTRING", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "UPPER", HB_FS_PUBLIC, HB_FUNCNAME( UPPER ), NULL },
{ "UNIDAD", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "PRECOD", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "PRECOV", HB_FS_PUBLIC | HB_FS_MEMVAR | HB_FS_MESSAGE, NULL, NULL },
{ "PROW", HB_FS_PUBLIC, HB_FUNCNAME( PROW ), NULL },
{ "PCOL", HB_FS_PUBLIC, HB_FUNCNAME( PCOL ), NULL },
{ "DBSKIP", HB_FS_PUBLIC, HB_FUNCNAME( DBSKIP ), NULL },
{ "DIGTOLEDO", HB_FS_PUBLIC, HB_FUNCNAME( DIGTOLEDO ), (PHB_DYNS) 1 }
HB_INIT_SYMBOLS_END( hb_vm_SymbolInit_VPC10000 )

#if defined(HB_STATIC_STARTUP)
   #pragma startup hb_vm_SymbolInit_VPC10000
#elif defined(_MSC_VER)
   #if _MSC_VER >= 1010
      #pragma data_seg( ".CRT$XIY" )
      #pragma comment( linker, "/Merge:.CRT=.data" )
   #else
      #pragma data_seg( "XIY" )
   #endif
   static HB_$INITSYM hb_vm_auto_SymbolInit_VPC10000 = hb_vm_SymbolInit_VPC10000;
   #pragma data_seg()
#elif ! defined(__GNUC__)
   #pragma startup hb_vm_SymbolInit_VPC10000
#endif

HB_FUNC( VPC10000 )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 3, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 18, 0,	/* 18 */
	HB_P_PUSHSYMNEAR, 1,	/* ZOOM */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_PUSHBYTE, 34,	/* 34 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 1,	/* CTELA */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* CCOR */
	HB_P_LOCALNEARSETINT, 3, 0, 0,	/* NOPCAO 0*/
/* 00032 */ HB_P_LINEOFFSET, 1,	/* 19 */
	HB_P_PUSHSYMNEAR, 3,	/* VPBOX */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_PUSHBYTE, 34,	/* 34 */
	HB_P_DOSHORT, 4,
/* 00047 */ HB_P_LINEOFFSET, 3,	/* 21 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00057 */ HB_P_LINEOFFSET, 5,	/* 23 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '1', 16, ' ', 'S', 'e', 'n', 'h', 'a', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 64,	/* 64 */
	'I', 'n', 'c', 'l', 'u', 's', 'a', 'o', ',', ' ', 'a', 'l', 't', 'e', 'r', 'a', 'c', 'a', 'o', ',', ' ', 'v', 'e', 'r', 'i', 'f', 'i', 'c', 'a', 'c', 'a', 'o', ' ', 'e', ' ', 'e', 'x', 'c', 'l', 'u', 's', 'a', 'o', ' ', 'd', 'e', ' ', 's', 'e', 'n', 'h', 'a', 's', '/', 'u', 's', 'u', 'a', 'r', 'i', 'o', 's', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00181 */ HB_P_LINEOFFSET, 7,	/* 25 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '2', 16, ' ', 'C', 'o', 'n', 'f', 'i', 'g', 'u', 'r', 'a', 'c', 'a', 'o', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 56,	/* 56 */
	'C', 'o', 'n', 'f', 'i', 'g', 'u', 'r', 'a', 'c', 'a', 'o', ' ', 'd', 'o', ' ', 'a', 'm', 'b', 'i', 'e', 'n', 't', 'e', ' ', 'd', 'e', ' ', 't', 'r', 'a', 'b', 'a', 'l', 'h', 'o', ',', ' ', 'c', 'o', 'r', 'e', 's', ',', ' ', 'z', 'o', 'o', 'm', ',', ' ', 'e', 't', 'c', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00297 */ HB_P_LINEOFFSET, 9,	/* 27 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '3', 16, ' ', 'R', 'e', 'i', 'n', 'd', 'e', 'x', 'a', 'c', 'a', 'o', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	'R', 'e', 'o', 'r', 'g', 'a', 'n', 'i', 'z', 'a', 'c', 'a', 'o', ' ', 'd', 'o', 's', ' ', 'a', 'r', 'q', 'u', 'i', 'v', 'o', 's', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00385 */ HB_P_LINEOFFSET, 11,	/* 29 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '4', 16, ' ', 'C', 'o', 'm', 'u', 'n', 'i', 'c', 'a', 'c', 'a', 'o', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 76,	/* 76 */
	'R', 'e', 'm', 'e', 's', 's', 'a', ' ', 'd', 'e', ' ', 'T', 161, 't', 'u', 'l', 'o', 's', ' ', 'a', 'o', ' ', 'B', 'a', 'n', 'c', 'o', ' ', '/', ' ', 'I', 'm', 'p', 'o', 'r', 't', 'a', 'r', ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'P', 'r', 'e', 'c', 'o', 's', ' ', '/', ' ', 'E', 'x', 'p', 'o', 'r', 't', 'a', 'r', ' ', 'A', 'r', 'q', 'u', 'i', 'v', 'o', 's', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00521 */ HB_P_LINEOFFSET, 13,	/* 31 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '5', 16, ' ', 'T', 'r', 'a', 'n', 's', 'f', 'e', 'r', 'e', 'n', 'c', 'i', 'a', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 21,	/* 21 */
	'C', 'o', 'p', 'i', 'a', 's', ' ', 'd', 'e', ' ', 's', 'e', 'g', 'u', 'r', 'a', 'n', 'c', 'a', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00602 */ HB_P_LINEOFFSET, 15,	/* 33 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '6', 16, ' ', 'E', 'm', 'p', 'r', 'e', 's', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 21,	/* 21 */
	'C', 'o', 'p', 'i', 'a', 's', ' ', 'd', 'e', ' ', 's', 'e', 'g', 'u', 'r', 'a', 'n', 'c', 'a', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00683 */ HB_P_LINEOFFSET, 17,	/* 35 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '7', 16, ' ', 'L', 'O', 'G', ' ', 'E', 'x', 'e', 'c', 'u', 'c', 'a', 'o', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00769 */ HB_P_LINEOFFSET, 19,	/* 37 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '8', 16, ' ', 'L', 'i', 'm', 'p', 'e', 'z', 'a', ' ', 'D', 'a', 'd', 'o', 's', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00855 */ HB_P_LINEOFFSET, 21,	/* 39 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00941 */ HB_P_LINEOFFSET, 22,	/* 40 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 3, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00960 */ HB_P_LINEOFFSET, 26,	/* 44 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00975) */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 8,	/* 8 (abs: 00983) */
	HB_P_JUMP, 152, 0,	/* 152 (abs: 01129) */
	HB_P_JUMP, 146, 0,	/* 146 (abs: 01126) */
/* 00983 */ HB_P_LINEOFFSET, 27,	/* 45 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 00999) */
	HB_P_PUSHSYMNEAR, 10,	/* DISPLAYUSUARIOS */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 130, 0,	/* 130 (abs: 01126) */
/* 00999 */ HB_P_LINEOFFSET, 28,	/* 46 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 01016) */
	HB_P_PUSHSYMNEAR, 11,	/* VPC14300 */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 113, 0,	/* 113 (abs: 01126) */
/* 01016 */ HB_P_LINEOFFSET, 29,	/* 47 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01032) */
	HB_P_PUSHSYMNEAR, 12,	/* VPC15000 */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 96,	/* 96 (abs: 01126) */
/* 01032 */ HB_P_LINEOFFSET, 30,	/* 48 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01048) */
	HB_P_PUSHSYMNEAR, 13,	/* MENUCOMUNICA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 80,	/* 80 (abs: 01126) */
/* 01048 */ HB_P_LINEOFFSET, 31,	/* 49 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01064) */
	HB_P_PUSHSYMNEAR, 14,	/* TRANSFERENCIA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 64,	/* 64 (abs: 01126) */
/* 01064 */ HB_P_LINEOFFSET, 32,	/* 50 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01080) */
	HB_P_PUSHSYMNEAR, 15,	/* EMPRESA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 48,	/* 48 (abs: 01126) */
/* 01080 */ HB_P_LINEOFFSET, 33,	/* 51 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01096) */
	HB_P_PUSHSYMNEAR, 16,	/* MENULIMPA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 32,	/* 32 (abs: 01126) */
/* 01096 */ HB_P_LINEOFFSET, 34,	/* 52 */
	HB_P_PUSHLOCALNEAR, 3,	/* NOPCAO */
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 23,	/* 23 (abs: 01126) */
/* 01105 */ HB_P_LINEOFFSET, 35,	/* 53 */
	HB_P_PUSHSYMNEAR, 17,	/* VIEWFILE */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'L', 'O', 'G', '.', 'T', 'X', 'T', 0, 
	HB_P_DOSHORT, 1,
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 01129) */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01126) */
	HB_P_JUMP, 201, 251,	/* -1079 (abs: 00047) */
/* 01129 */ HB_P_LINEOFFSET, 39,	/* 57 */
	HB_P_PUSHSYMNEAR, 18,	/* UNZOOM */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 01138 */ HB_P_LINEOFFSET, 40,	/* 58 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 01147 */ HB_P_LINEOFFSET, 41,	/* 59 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 01152 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( MENUCOMUNICA )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 85, 0,	/* 85 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 86 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 31,	/* 116 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'B', 'A', 'N', 'R', 'I', 'S', 'U', 'L', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_ONE,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', 'D', 'O', ' ', 'B', 'R', 'A', 'S', 'I', 'L', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'B', 'R', 'A', 'D', 'E', 'S', 'C', 'O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'B', 'A', 'M', 'E', 'R', 'I', 'N', 'D', 'U', 'S', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'I', 'T', 'A', 'U', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'B', 'A', 'N', 'C', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'R', 'E', 'A', 'L', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'F', 'E', 'I', 'R', 'A', 'S', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'I', 'M', 'P', 'O', 'R', 'T', 'A', 'C', 'A', 'O', ' ', 'D', 'E', ' ', 'P', 'E', 'D', 'I', 'D', 'O', 'S', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 47,	/* 47 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 21,	/* IMPORTAPEDIDOS */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'F', 'E', 'I', 'R', 'A', 'S', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'P', 'R', 'E', 'P', 'A', 'R', 'A', 'C', 'A', 'O', ' ', 'D', 'O', ' ', 'M', 'I', 'C', 'R', 'O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 48,	/* 48 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 22,	/* PCF */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'F', 'A', 'R', 'M', 'A', 'C', 'I', 'A', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'D', 'I', 'M', 'E', 'D', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'F', 'A', 'R', 'M', 'A', 'C', 'I', 'A', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'A', 'B', 'A', 'F', 'A', 'R', 'M', 'A', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 23,	/* ABAFARMA */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'F', 'A', 'R', 'M', 'A', 'C', 'I', 'A', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'P', 'A', 'N', 'A', 'R', 'E', 'L', 'L', 'O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 24,	/* PANARELLO */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'A', 'U', 'T', 'O', 'P', 'E', 'C', 'A', 'S', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'B', 'A', 'R', 'R', 'O', 'S', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 25,	/* BARROS */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'C', 'O', 'R', 'E', 'S', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'C', 'O', 'M', 'B', 'I', 'L', 'U', 'X', ' ', 'G', 'L', 'A', 'S', 'U', 'R', 'I', 'T', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 19,	/* 19 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 26,	/* CGLASURIT */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'C', 'O', 'R', 'E', 'S', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'M', 'I', 'X', 'I', 'N', 'G', ' ', 'G', 'L', 'A', 'S', 'U', 'R', 'I', 'T', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 27,	/* GLASURIT */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'C', 'O', 'R', 'E', 'S', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'A', '.', 'C', '.', 'S', '.', ' ', 'C', 'O', 'R', 'A', 'L', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 28,	/* ACS */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'C', 'O', 'R', 'E', 'S', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'R', 'E', 'N', 'N', 'E', 'R', ' ', 'A', 'U', 'T', 'O', 'M', 'O', 'T', 'I', 'V', 'O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 29,	/* RENNER */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'S', 'I', 'S', 'T', 'E', 'M', 'A', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'E', 'V', 'O', 'L', 'U', 'T', 'I', 'V', 'A', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 30,	/* SOFTWARE */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'S', 'I', 'S', 'T', 'E', 'M', 'A', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'A', 'T', 'U', 'A', 'L', 'I', 'Z', 'A', 'C', 'A', 'O', ' ', 'V', 'I', 'A', ' ', 'I', 'N', 'T', 'E', 'R', 'N', 'E', 'T', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'S', 'I', 'S', 'T', 'E', 'M', 'A', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'D', 'I', 'A', 'R', 'I', 'O', ' ', 'D', 'E', ' ', 'C', 'O', 'M', 'U', 'N', 'I', 'C', 'A', 'C', 'A', 'O', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 31,	/* VISUALCOMUNICACAO */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'M', 'E', 'R', 'C', 'A', 'D', 'O', 'S', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'B', 'A', 'L', 'A', 'N', 'C', 'A', 'S', ' ', 'T', 'O', 'L', 'E', 'D', 'O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 32,	/* EXPTOLEDO */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'L', 'I', 'V', 'R', 'O', 'S', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'W', 'i', 'n', 'L', 'I', 'V', 'R', 'O', 'S', ' ', '-', ' ', 'D', 'A', 'T', 'A', 'C', 'E', 'M', 'P', 'R', 'O', ' ', '(', 'R', ')', 0, 
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_PUSHSYMNEAR, 33,	/* EXPWINLIVROS */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 176, 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	' ', 'F', 'I', 'N', 'A', 'L', 'I', 'Z', 'A', ' ', ' ', 0, 
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', 'T', 'E', 'R', 'M', 'I', 'N', 'O', ' ', 'D', 'A', ' ', 'E', 'X', 'E', 'C', 'U', 'C', 'A', 'O', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_ZERO,
	HB_P_PUSHBLOCKSHORT, 4,	/* 4 */
	HB_P_PUSHNIL,
	HB_P_ENDBLOCK,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_ARRAYGEN, 30, 0,	/* 30 */
	HB_P_POPVARIABLE, 34, 0,	/* AOPCOES */
/* 01679 */ HB_P_LINEOFFSET, 32,	/* 117 */
	HB_P_PUSHSYMNEAR, 3,	/* VPBOX */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 22,	/* 22 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_PUSHSTRSHORT, 39,	/* 39 */
	' ', 'S', 'I', 'S', 'T', 'E', 'M', 'A', ' ', 'D', 'E', ' ', 'I', 'M', 'P', 'O', 'R', 'T', 'A', 'C', 'O', 'E', 'S', ' ', '/', ' ', 'E', 'X', 'P', 'O', 'R', 'T', 'A', 'C', 'O', 'E', 'S', ' ', 0, 
	HB_P_PUSHNIL,
	HB_P_FALSE,
	HB_P_FALSE,
	HB_P_DOSHORT, 8,
/* 01736 */ HB_P_LINEOFFSET, 33,	/* 118 */
	HB_P_FALSE,
	HB_P_POPVARIABLE, 35, 0,	/* LOK */
/* 01742 */ HB_P_LINEOFFSET, 34,	/* 119 */
	HB_P_ONE,
	HB_P_POPVARIABLE, 36, 0,	/* NROW */
/* 01748 */ HB_P_LINEOFFSET, 35,	/* 120 */
	HB_P_LOCALNEARSETINT, 4, 1, 0,	/* NOPCAO 1*/
/* 01754 */ HB_P_LINEOFFSET, 36,	/* 121 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'1', '5', '/', '0', '4', ',', ' ', '0', '0', '/', '1', '4', 0, 
	HB_P_DOSHORT, 1,
/* 01776 */ HB_P_LINEOFFSET, 37,	/* 122 */
	HB_P_PUSHSYMNEAR, 37,	/* VPBOXSOMBRA */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_ONE,
	HB_P_PUSHBYTE, 19,	/* 19 */
	HB_P_PUSHBYTE, 39,	/* 39 */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'1', '5', '/', '0', '4', 0, 
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'0', '0', '/', '0', '1', 0, 
	HB_P_DOSHORT, 7,
/* 01807 */ HB_P_LINEOFFSET, 38,	/* 123 */
	HB_P_PUSHSYMNEAR, 38,	/* TBROWSENEW */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_PUSHBYTE, 38,	/* 38 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPVARIABLE, 39, 0,	/* OTAB */
/* 01825 */ HB_P_LINEOFFSET, 39,	/* 124 */
	HB_P_MESSAGE, 40, 0,	/* ADDCOLUMN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_PUSHSYMNEAR, 41,	/* TBCOLUMNNEW */
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCKSHORT, 30,	/* 30 */
	HB_P_PUSHMEMVAR, 34, 0,	/* AOPCOES */
	HB_P_PUSHVARIABLE, 36, 0,	/* NROW */
	HB_P_ARRAYPUSH,
	HB_P_ONE,
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	' ', '-', ' ', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 34, 0,	/* AOPCOES */
	HB_P_PUSHVARIABLE, 36, 0,	/* NROW */
	HB_P_ARRAYPUSH,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_ENDBLOCK,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01872 */ HB_P_LINEOFFSET, 40,	/* 125 */
	HB_P_MESSAGE, 42, 0,	/* _AUTOLITE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_FALSE,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01884 */ HB_P_LINEOFFSET, 41,	/* 126 */
	HB_P_MESSAGE, 43, 0,	/* _GOTOPBLOCK */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_PUSHBLOCKSHORT, 8,	/* 8 */
	HB_P_ONE,
	HB_P_DUPLICATE,
	HB_P_POPVARIABLE, 36, 0,	/* NROW */
	HB_P_ENDBLOCK,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01903 */ HB_P_LINEOFFSET, 42,	/* 127 */
	HB_P_MESSAGE, 44, 0,	/* _GOBOTTOMBLOCK */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_PUSHBLOCKSHORT, 15,	/* 15 */
	HB_P_PUSHSYMNEAR, 45,	/* LEN */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 34, 0,	/* AOPCOES */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_DUPLICATE,
	HB_P_POPVARIABLE, 36, 0,	/* NROW */
	HB_P_ENDBLOCK,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01929 */ HB_P_LINEOFFSET, 43,	/* 128 */
	HB_P_MESSAGE, 46, 0,	/* _SKIPBLOCK */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_PUSHBLOCK, 21, 0,	/* 21 */
	1, 0,	/* number of local parameters (1) */
	0, 0,	/* number of local variables (0) */
	HB_P_PUSHSYMNEAR, 47,	/* SKIPPERARR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHVARIABLE, 34, 0,	/* AOPCOES */
	HB_P_PUSHMEMVARREF, 36, 0,	/* NROW */
	HB_P_FUNCTIONSHORT, 3,
	HB_P_ENDBLOCK,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01961 */ HB_P_LINEOFFSET, 44,	/* 129 */
	HB_P_MESSAGE, 48, 0,	/* DEHILITE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01972 */ HB_P_LINEOFFSET, 46,	/* 131 */
	HB_P_MESSAGE, 49, 0,	/* COLORRECT */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_MESSAGE, 50, 0,	/* ROWPOS */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_ONE,
	HB_P_MESSAGE, 50, 0,	/* ROWPOS */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_ONE,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_ONE,
	HB_P_ARRAYGEN, 2, 0,	/* 2 */
	HB_P_SENDSHORT, 2,
	HB_P_POP,
/* 02010 */ HB_P_LINEOFFSET, 47,	/* 132 */
	HB_P_PUSHSYMNEAR, 51,	/* NEXTKEY */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ZERO,
	HB_P_EXACTLYEQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPFALSENEAR, 12,	/* 12 (abs: 02032) */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_NOT,
	HB_P_AND,
	HB_P_JUMPFALSENEAR, 4,	/* 4 (abs: 02036) */
	HB_P_JUMPNEAR, 232,	/* -24 (abs: 02010) */
/* 02036 */ HB_P_LINEOFFSET, 49,	/* 134 */
	HB_P_PUSHSYMNEAR, 53,	/* INKEY */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPVARIABLE, 54, 0,	/* NTECLA */
/* 02047 */ HB_P_LINEOFFSET, 50,	/* 135 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 27,	/* 27 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 13,	/* 13 (abs: 02068) */
/* 02057 */ HB_P_LINEOFFSET, 51,	/* 136 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
	HB_P_JUMP, 117, 1,	/* 373 (abs: 02436) */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 02068) */
/* 02068 */ HB_P_LINEOFFSET, 54,	/* 139 */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPVARIABLE, 55, 0,	/* CTELAG */
/* 02084 */ HB_P_LINEOFFSET, 56,	/* 141 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02106) */
	HB_P_MESSAGE, 56, 0,	/* UP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 52, 1,	/* 308 (abs: 02411) */
/* 02106 */ HB_P_LINEOFFSET, 57,	/* 142 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02128) */
	HB_P_MESSAGE, 57, 0,	/* DOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 30, 1,	/* 286 (abs: 02411) */
/* 02128 */ HB_P_LINEOFFSET, 58,	/* 143 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 19,	/* 19 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02150) */
	HB_P_MESSAGE, 56, 0,	/* UP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 8, 1,	/* 264 (abs: 02411) */
/* 02150 */ HB_P_LINEOFFSET, 59,	/* 144 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02172) */
	HB_P_MESSAGE, 57, 0,	/* DOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 242, 0,	/* 242 (abs: 02411) */
/* 02172 */ HB_P_LINEOFFSET, 60,	/* 145 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02194) */
	HB_P_MESSAGE, 58, 0,	/* PAGEUP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 220, 0,	/* 220 (abs: 02411) */
/* 02194 */ HB_P_LINEOFFSET, 61,	/* 146 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 31,	/* 31 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02216) */
	HB_P_MESSAGE, 59, 0,	/* GOTOP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 198, 0,	/* 198 (abs: 02411) */
/* 02216 */ HB_P_LINEOFFSET, 62,	/* 147 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02238) */
	HB_P_MESSAGE, 60, 0,	/* PAGEDOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 176, 0,	/* 176 (abs: 02411) */
/* 02238 */ HB_P_LINEOFFSET, 63,	/* 148 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 30,	/* 30 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02260) */
	HB_P_MESSAGE, 61, 0,	/* GOBOTTOM */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 154, 0,	/* 154 (abs: 02411) */
/* 02260 */ HB_P_LINEOFFSET, 64,	/* 149 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 215,	/* -41 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 02278) */
	HB_P_PUSHSYMNEAR, 62,	/* CALCULADOR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 136, 0,	/* 136 (abs: 02411) */
/* 02278 */ HB_P_LINEOFFSET, 65,	/* 150 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 227,	/* -29 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 02296) */
	HB_P_PUSHSYMNEAR, 63,	/* CALENDAR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 118, 0,	/* 118 (abs: 02411) */
/* 02296 */ HB_P_LINEOFFSET, 66,	/* 151 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 92,	/* 92 (abs: 02396) */
/* 02306 */ HB_P_LINEOFFSET, 67,	/* 152 */
	HB_P_PUSHMEMVAR, 34, 0,	/* AOPCOES */
	HB_P_PUSHVARIABLE, 36, 0,	/* NROW */
	HB_P_ARRAYPUSH,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ARRAYPUSH,
	HB_P_ZERO,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 02326) */
	HB_P_JUMPNEAR, 114,	/* 114 (abs: 02436) */
	HB_P_JUMPNEAR, 70,	/* 70 (abs: 02394) */
/* 02326 */ HB_P_LINEOFFSET, 70,	/* 155 */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 188, 2,	/* 700 */
	HB_P_FALSE,
	HB_P_DOSHORT, 2,
/* 02337 */ HB_P_LINEOFFSET, 71,	/* 156 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'1', '5', '/', '0', '1', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPVARIABLE, 65, 0,	/* CCORRES */
/* 02355 */ HB_P_LINEOFFSET, 72,	/* 157 */
	HB_P_MESSAGE, 66, 0,	/* EVAL */
	HB_P_PUSHMEMVAR, 34, 0,	/* AOPCOES */
	HB_P_PUSHVARIABLE, 36, 0,	/* NROW */
	HB_P_ARRAYPUSH,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 02373 */ HB_P_LINEOFFSET, 73,	/* 158 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 65, 0,	/* CCORRES */
	HB_P_DOSHORT, 1,
/* 02383 */ HB_P_LINEOFFSET, 74,	/* 159 */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 188, 2,	/* 700 */
	HB_P_TRUE,
	HB_P_DOSHORT, 2,
	HB_P_JUMPNEAR, 17,	/* 17 (abs: 02411) */
	HB_P_PUSHSYMNEAR, 67,	/* TONE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 125,	/* 125 */
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 67,	/* TONE */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 44, 1,	/* 300 */
	HB_P_DOSHORT, 1,
/* 02411 */ HB_P_LINEOFFSET, 78,	/* 163 */
	HB_P_MESSAGE, 68, 0,	/* REFRESHCURRENT */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 02422 */ HB_P_LINEOFFSET, 79,	/* 164 */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 51, 254,	/* -461 (abs: 01972) */
/* 02436 */ HB_P_LINEOFFSET, 81,	/* 166 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 02445 */ HB_P_LINEOFFSET, 82,	/* 167 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 02454 */ HB_P_LINEOFFSET, 83,	/* 168 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 02463 */ HB_P_LINEOFFSET, 84,	/* 169 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 02468 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( PANARELLO )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 187, 0,	/* 187 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 188 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 190 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 192 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'P', 'r', 'e', 'c', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 194 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '2', 16, ' ', 'E', 's', 'p', 'e', 'l', 'h', 'o', ' ', 'd', 'e', ' ', 'N', 'o', 't', 'a', ' ', 'F', 'i', 's', 'c', 'a', 'l', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00187 */ HB_P_LINEOFFSET, 9,	/* 196 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '3', 16, ' ', 'O', '.', ' ', 'C', 'o', 'm', 'p', 'r', 'a', ' ', '-', ' ', 'R', 'e', 'm', 'e', 's', 's', 'a', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00256 */ HB_P_LINEOFFSET, 11,	/* 198 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '4', 16, ' ', 'O', '.', ' ', 'C', 'o', 'm', 'p', 'r', 'a', ' ', '-', ' ', 'R', 'e', 't', 'o', 'r', 'n', 'o', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00325 */ HB_P_LINEOFFSET, 13,	/* 200 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '5', 16, ' ', 'P', 'r', 'o', 'm', 'o', 'c', 'o', 'e', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00394 */ HB_P_LINEOFFSET, 15,	/* 202 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00488 */ HB_P_LINEOFFSET, 16,	/* 203 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00507 */ HB_P_LINEOFFSET, 18,	/* 205 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00522) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00528) */
	HB_P_JUMPNEAR, 38,	/* 38 (abs: 00562) */
	HB_P_JUMPNEAR, 33,	/* 33 (abs: 00559) */
/* 00528 */ HB_P_LINEOFFSET, 19,	/* 206 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00543) */
	HB_P_PUSHSYMNEAR, 70,	/* IPRECOPANARELLO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 18,	/* 18 (abs: 00559) */
/* 00543 */ HB_P_LINEOFFSET, 20,	/* 207 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00559) */
	HB_P_PUSHSYMNEAR, 71,	/* INFPANARELLO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00559) */
	HB_P_JUMP, 248, 253,	/* -520 (abs: 00039) */
/* 00562 */ HB_P_LINEOFFSET, 23,	/* 210 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00571 */ HB_P_LINEOFFSET, 24,	/* 211 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 00580 */ HB_P_LINEOFFSET, 25,	/* 212 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 00589 */ HB_P_LINEOFFSET, 26,	/* 213 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 00594 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( BARROS )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 228, 0,	/* 228 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 229 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 231 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 233 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'P', 'r', 'o', 'd', 'u', 't', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 235 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '2', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'F', 'a', 'b', 'r', 'i', 'c', 'a', 'n', 't', 'e', 's', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00187 */ HB_P_LINEOFFSET, 9,	/* 237 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00281 */ HB_P_LINEOFFSET, 10,	/* 238 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00300 */ HB_P_LINEOFFSET, 12,	/* 240 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00315) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00321) */
	HB_P_JUMPNEAR, 38,	/* 38 (abs: 00355) */
	HB_P_JUMPNEAR, 33,	/* 33 (abs: 00352) */
/* 00321 */ HB_P_LINEOFFSET, 13,	/* 241 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00336) */
	HB_P_PUSHSYMNEAR, 72,	/* IPRODBARROS */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 18,	/* 18 (abs: 00352) */
/* 00336 */ HB_P_LINEOFFSET, 14,	/* 242 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00352) */
	HB_P_PUSHSYMNEAR, 73,	/* IFABBARROS */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00352) */
	HB_P_JUMP, 199, 254,	/* -313 (abs: 00039) */
/* 00355 */ HB_P_LINEOFFSET, 17,	/* 245 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00364 */ HB_P_LINEOFFSET, 18,	/* 246 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 00373 */ HB_P_LINEOFFSET, 19,	/* 247 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 00382 */ HB_P_LINEOFFSET, 20,	/* 248 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 00387 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( GLASURIT )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 6, 1,	/* 262 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 263 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 265 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 267 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'B', 'a', 's', 'e', ' ', 'd', 'e', ' ', 'd', 'a', 'd', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 269 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '2', 16, ' ', 'F', 'o', 'r', 'm', 'u', 'l', 'a', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00187 */ HB_P_LINEOFFSET, 9,	/* 271 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00281 */ HB_P_LINEOFFSET, 10,	/* 272 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00300 */ HB_P_LINEOFFSET, 12,	/* 274 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00315) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00321) */
	HB_P_JUMPNEAR, 38,	/* 38 (abs: 00355) */
	HB_P_JUMPNEAR, 33,	/* 33 (abs: 00352) */
/* 00321 */ HB_P_LINEOFFSET, 13,	/* 275 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00336) */
	HB_P_PUSHSYMNEAR, 74,	/* IGLASBASE */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 18,	/* 18 (abs: 00352) */
/* 00336 */ HB_P_LINEOFFSET, 14,	/* 276 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00352) */
	HB_P_PUSHSYMNEAR, 75,	/* IGLASFORMULA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00352) */
	HB_P_JUMP, 199, 254,	/* -313 (abs: 00039) */
/* 00355 */ HB_P_LINEOFFSET, 17,	/* 279 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00364 */ HB_P_LINEOFFSET, 18,	/* 280 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 00373 */ HB_P_LINEOFFSET, 19,	/* 281 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
	HB_P_ENDPROC
/* 00383 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( CGLASURIT )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 40, 1,	/* 296 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 297 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 299 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 301 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'p', 'r', 'o', 'd', 'u', 't', 'o', 's', '/', 'p', 'r', 'e', 'c', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 303 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'r', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'r', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00212 */ HB_P_LINEOFFSET, 8,	/* 304 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00231 */ HB_P_LINEOFFSET, 10,	/* 306 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00246) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00252) */
	HB_P_JUMPNEAR, 22,	/* 22 (abs: 00270) */
	HB_P_JUMPNEAR, 17,	/* 17 (abs: 00267) */
/* 00252 */ HB_P_LINEOFFSET, 11,	/* 307 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00267) */
	HB_P_PUSHSYMNEAR, 76,	/* ICGLASPRO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00267) */
	HB_P_JUMP, 28, 255,	/* -228 (abs: 00039) */
/* 00270 */ HB_P_LINEOFFSET, 14,	/* 310 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00279 */ HB_P_LINEOFFSET, 15,	/* 311 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 00288 */ HB_P_LINEOFFSET, 16,	/* 312 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
	HB_P_ENDPROC
/* 00298 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( RENNER )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 72, 1,	/* 328 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 329 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 331 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 333 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'B', 'a', 's', 'e', ' ', 'd', 'e', ' ', 'd', 'a', 'd', 'o', 's', ' ', '/', ' ', 'P', 'r', 'e', 'c', 'o', 's', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 335 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00212 */ HB_P_LINEOFFSET, 8,	/* 336 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00231 */ HB_P_LINEOFFSET, 10,	/* 338 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00246) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00252) */
	HB_P_JUMPNEAR, 22,	/* 22 (abs: 00270) */
	HB_P_JUMPNEAR, 17,	/* 17 (abs: 00267) */
/* 00252 */ HB_P_LINEOFFSET, 11,	/* 339 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00267) */
	HB_P_PUSHSYMNEAR, 77,	/* RENNERPRECO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00267) */
	HB_P_JUMP, 28, 255,	/* -228 (abs: 00039) */
/* 00270 */ HB_P_LINEOFFSET, 14,	/* 342 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00279 */ HB_P_LINEOFFSET, 15,	/* 343 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 00288 */ HB_P_LINEOFFSET, 16,	/* 344 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
	HB_P_ENDPROC
/* 00298 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( ACS )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 102, 1,	/* 358 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 359 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 361 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 363 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'P', 'r', 'e', 'c', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 365 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '2', 16, ' ', 'B', 'a', 's', 'e', ' ', 'd', 'e', ' ', 'd', 'a', 'd', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00187 */ HB_P_LINEOFFSET, 9,	/* 367 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00281 */ HB_P_LINEOFFSET, 10,	/* 368 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00300 */ HB_P_LINEOFFSET, 12,	/* 370 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00315) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00321) */
	HB_P_JUMPNEAR, 38,	/* 38 (abs: 00355) */
	HB_P_JUMPNEAR, 33,	/* 33 (abs: 00352) */
/* 00321 */ HB_P_LINEOFFSET, 13,	/* 371 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00337) */
	HB_P_PUSHSYMNEAR, 78,	/* IACSBASE */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 17,	/* 17 (abs: 00352) */
/* 00337 */ HB_P_LINEOFFSET, 14,	/* 372 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00352) */
	HB_P_PUSHSYMNEAR, 79,	/* IACSPRECO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00352) */
	HB_P_JUMP, 199, 254,	/* -313 (abs: 00039) */
/* 00355 */ HB_P_LINEOFFSET, 17,	/* 375 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00364 */ HB_P_LINEOFFSET, 18,	/* 376 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 00373 */ HB_P_LINEOFFSET, 19,	/* 377 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 00382 */ HB_P_LINEOFFSET, 20,	/* 378 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 00387 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( ABAFARMA )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 136, 1,	/* 392 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 393 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 3,	/* 395 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00049 */ HB_P_LINEOFFSET, 5,	/* 397 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '1', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'P', 'r', 'e', 'c', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00118 */ HB_P_LINEOFFSET, 7,	/* 399 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '2', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'P', 'r', 'o', 'd', '.', ' ', 'N', 'o', 'v', 'o', 's', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00187 */ HB_P_LINEOFFSET, 9,	/* 401 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '3', 16, ' ', 'L', 'i', 's', 't', 'a', ' ', 'd', 'e', ' ', 'F', 'a', 'b', 'r', 'i', 'c', 'a', 'n', 't', 'e', 's', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00256 */ HB_P_LINEOFFSET, 11,	/* 403 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '4', 16, ' ', 'E', 'x', 'e', 'c', 'u', 't', 'a', 'r', ' ', 'A', 'B', 'F', 'C', 'O', 'N', 'S', '.', 'E', 'X', 'E', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 38,	/* 38 */
	'E', 'x', 'e', 'c', 'u', 't', 'a', ' ', 's', 'i', 's', 't', 'e', 'm', 'a', ' ', 'd', 'e', ' ', 'c', 'o', 'n', 's', 'u', 'l', 't', 'a', ' ', 'a', 'b', 'a', 'f', 'a', 'r', 'm', 'a', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00362 */ HB_P_LINEOFFSET, 13,	/* 405 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 28,	/* 28 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00456 */ HB_P_LINEOFFSET, 14,	/* 406 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00475 */ HB_P_LINEOFFSET, 16,	/* 408 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00490) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 8,	/* 8 (abs: 00498) */
	HB_P_JUMP, 19, 2,	/* 531 (abs: 01023) */
	HB_P_JUMP, 13, 2,	/* 525 (abs: 01020) */
/* 00498 */ HB_P_LINEOFFSET, 17,	/* 409 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 00514) */
	HB_P_PUSHSYMNEAR, 80,	/* IPRODPREABAFAR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 253, 1,	/* 509 (abs: 01020) */
/* 00514 */ HB_P_LINEOFFSET, 18,	/* 410 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 00531) */
	HB_P_PUSHSYMNEAR, 81,	/* IPRODABAFAR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 236, 1,	/* 492 (abs: 01020) */
/* 00531 */ HB_P_LINEOFFSET, 19,	/* 411 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 00548) */
	HB_P_PUSHSYMNEAR, 82,	/* IFABABAFAR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 219, 1,	/* 475 (abs: 01020) */
/* 00548 */ HB_P_LINEOFFSET, 20,	/* 412 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_EQUAL,
	HB_P_JUMPFALSE, 209, 1,	/* 465 (abs: 01020) */
/* 00558 */ HB_P_LINEOFFSET, 21,	/* 413 */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPVARIABLE, 83, 0,	/* CTELARES */
/* 00574 */ HB_P_LINEOFFSET, 22,	/* 414 */
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	92, 0, 
	HB_P_PUSHSYMNEAR, 84,	/* CURDIR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 85, 0,	/* CDIRETORIO */
/* 00589 */ HB_P_LINEOFFSET, 23,	/* 415 */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'C', ':', 0, 
	HB_P_POPVARIABLE, 86, 0,	/* CDRIVE */
/* 00599 */ HB_P_LINEOFFSET, 24,	/* 416 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'F', 'O', 'R', 'T', 'U', 'N', 'A', 0, 
	HB_P_PUSHSYMNEAR, 84,	/* CURDIR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 15,	/* 15 (abs: 00642) */
/* 00629 */ HB_P_LINEOFFSET, 25,	/* 417 */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'C', ':', 0, 
	HB_P_POPVARIABLE, 86, 0,	/* CDRIVE */
	HB_P_JUMP, 172, 0,	/* 172 (abs: 00811) */
/* 00642 */ HB_P_LINEOFFSET, 26,	/* 418 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'F', 'O', 'R', 'T', 'U', 'N', 'A', 0, 
	HB_P_PUSHSYMNEAR, 84,	/* CURDIR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'D', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 15,	/* 15 (abs: 00685) */
/* 00672 */ HB_P_LINEOFFSET, 27,	/* 419 */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'D', ':', 0, 
	HB_P_POPVARIABLE, 86, 0,	/* CDRIVE */
	HB_P_JUMP, 129, 0,	/* 129 (abs: 00811) */
/* 00685 */ HB_P_LINEOFFSET, 28,	/* 420 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'F', 'O', 'R', 'T', 'U', 'N', 'A', 0, 
	HB_P_PUSHSYMNEAR, 84,	/* CURDIR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'E', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 00727) */
/* 00715 */ HB_P_LINEOFFSET, 29,	/* 421 */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'E', ':', 0, 
	HB_P_POPVARIABLE, 86, 0,	/* CDRIVE */
	HB_P_JUMPNEAR, 86,	/* 86 (abs: 00811) */
/* 00727 */ HB_P_LINEOFFSET, 30,	/* 422 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'F', 'O', 'R', 'T', 'U', 'N', 'A', 0, 
	HB_P_PUSHSYMNEAR, 84,	/* CURDIR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'F', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 00769) */
/* 00757 */ HB_P_LINEOFFSET, 31,	/* 423 */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'F', ':', 0, 
	HB_P_POPVARIABLE, 86, 0,	/* CDRIVE */
	HB_P_JUMPNEAR, 44,	/* 44 (abs: 00811) */
/* 00769 */ HB_P_LINEOFFSET, 32,	/* 424 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'F', 'O', 'R', 'T', 'U', 'N', 'A', 0, 
	HB_P_PUSHSYMNEAR, 84,	/* CURDIR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'G', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 00811) */
/* 00799 */ HB_P_LINEOFFSET, 33,	/* 425 */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'G', ':', 0, 
	HB_P_POPVARIABLE, 86, 0,	/* CDRIVE */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00811) */
/* 00811 */ HB_P_LINEOFFSET, 36,	/* 428 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 15,	/* 15 */
	'M', 'O', 'D', 'E', ' ', 'C', 'O', '8', '0', ' ', '>', 'N', 'u', 'l', 0, 
	HB_P_DOSHORT, 1,
/* 00835 */ HB_P_LINEOFFSET, 37,	/* 429 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'C', ':', ' ', '>', 'N', 'u', 'l', 0, 
	HB_P_DOSHORT, 1,
/* 00852 */ HB_P_LINEOFFSET, 38,	/* 430 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 14,	/* 14 */
	'C', 'D', 92, 'A', 'B', 'F', 'P', '1', ' ', '>', 'N', 'u', 'l', 0, 
	HB_P_DOSHORT, 1,
/* 00875 */ HB_P_LINEOFFSET, 39,	/* 431 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'A', 'B', 'F', 'C', 'O', 'N', 'S', ' ', '>', 'N', 'u', 'l', 0, 
	HB_P_DOSHORT, 1,
/* 00897 */ HB_P_LINEOFFSET, 41,	/* 433 */
	HB_P_PUSHSYMNEAR, 89,	/* DISPBEGIN */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00904 */ HB_P_LINEOFFSET, 42,	/* 434 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'&', 'c', 'D', 'r', 'i', 'v', 'e', ' ', '>', 'N', 'u', 'l', 0, 
	HB_P_MACROTEXT,
	HB_P_DOSHORT, 1,
/* 00927 */ HB_P_LINEOFFSET, 43,	/* 435 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	'C', 'D', ' ', '&', 'c', 'D', 'i', 'r', 'e', 't', 'o', 'r', 'i', 'o', ' ', '>', 'N', 'u', 'l', 0, 
	HB_P_MACROTEXT,
	HB_P_DOSHORT, 1,
/* 00957 */ HB_P_LINEOFFSET, 44,	/* 436 */
	HB_P_PUSHSYMNEAR, 90,	/* MODOVGA */
	HB_P_PUSHNIL,
	HB_P_TRUE,
	HB_P_DOSHORT, 1,
/* 00965 */ HB_P_LINEOFFSET, 45,	/* 437 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 19,	/* 19 */
	'S', 'T', 'A', 'R', 'T', ' ', 'R', 'e', 's', 't', 'a', 'u', 'r', 'a', 'M', 'o', 'd', 'o', 0, 
	HB_P_DOSHORT, 1,
/* 00993 */ HB_P_LINEOFFSET, 46,	/* 438 */
	HB_P_PUSHSYMNEAR, 91,	/* DISPEND */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 01000 */ HB_P_LINEOFFSET, 47,	/* 439 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 83, 0,	/* CTELARES */
	HB_P_DOSHORT, 1,
/* 01010 */ HB_P_LINEOFFSET, 48,	/* 440 */
	HB_P_PUSHSYMNEAR, 92,	/* SETBLINK */
	HB_P_PUSHNIL,
	HB_P_FALSE,
	HB_P_DOSHORT, 1,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01020) */
	HB_P_JUMP, 43, 252,	/* -981 (abs: 00039) */
/* 01023 */ HB_P_LINEOFFSET, 52,	/* 444 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 01032 */ HB_P_LINEOFFSET, 53,	/* 445 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 01041 */ HB_P_LINEOFFSET, 54,	/* 446 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 01050 */ HB_P_LINEOFFSET, 55,	/* 447 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 01055 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC_STATIC( SOFTWARE )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 205, 1,	/* 461 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 462 */
	HB_P_LOCALNEARSETINT, 4, 0, 0,	/* NOPCAO 0*/
/* 00039 */ HB_P_LINEOFFSET, 2,	/* 463 */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 188, 2,	/* 700 */
	HB_P_FALSE,
	HB_P_DOSHORT, 2,
/* 00050 */ HB_P_LINEOFFSET, 4,	/* 465 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
/* 00060 */ HB_P_LINEOFFSET, 6,	/* 467 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '1', 16, ' ', 'E', 's', 't', 'o', 'q', 'u', 'e', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 'm', 'e', 's', 's', 'a', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00131 */ HB_P_LINEOFFSET, 8,	/* 469 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '2', 16, ' ', 'E', 's', 't', 'o', 'q', 'u', 'e', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 't', 'o', 'r', 'n', 'o', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00202 */ HB_P_LINEOFFSET, 10,	/* 471 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '3', 16, ' ', 'D', 'u', 'p', 'l', 'i', 'c', 'a', 't', 'a', 's', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 'm', 'e', 's', 's', 'a', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00273 */ HB_P_LINEOFFSET, 12,	/* 473 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '4', 16, ' ', 'D', 'u', 'p', 'l', 'i', 'c', 'a', 't', 'a', 's', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 't', 'o', 'r', 'n', 'o', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00344 */ HB_P_LINEOFFSET, 14,	/* 475 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '5', 16, ' ', 'C', 'l', 'i', 'e', 'n', 't', 'e', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 'm', 'e', 's', 's', 'a', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00415 */ HB_P_LINEOFFSET, 16,	/* 477 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '6', 16, ' ', 'C', 'l', 'i', 'e', 'n', 't', 'e', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 't', 'o', 'r', 'n', 'o', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00486 */ HB_P_LINEOFFSET, 18,	/* 479 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '7', 16, ' ', 'P', 'r', 'o', 'd', 'u', 't', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 'm', 'e', 's', 's', 'a', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00557 */ HB_P_LINEOFFSET, 20,	/* 481 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '8', 16, ' ', 'P', 'r', 'o', 'd', 'u', 't', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 't', 'o', 'r', 'n', 'o', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00628 */ HB_P_LINEOFFSET, 22,	/* 483 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '9', 16, ' ', 'P', 'e', 'd', 'i', 'd', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 'm', 'e', 's', 's', 'a', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00699 */ HB_P_LINEOFFSET, 24,	/* 485 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', 'A', 16, ' ', 'P', 'e', 'd', 'i', 'd', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'C', 'o', 'n', 's', 'u', 'l', 't', 'a', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00770 */ HB_P_LINEOFFSET, 26,	/* 487 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', 'B', 16, ' ', 'P', 'e', 'd', 'i', 'd', 'o', 's', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '-', ' ', 'R', 'e', 't', 'o', 'r', 'n', 'o', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00841 */ HB_P_LINEOFFSET, 28,	/* 489 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHSYMNEAR, 7,	/* swmenunew */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	' ', '0', 16, ' ', 'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'R', 'e', 't', 'o', 'r', 'n', 'a', ' ', 'a', 'o', ' ', 'm', 'e', 'n', 'u', ' ', 'a', 'n', 't', 'e', 'r', 'i', 'o', 'r', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ARRAYPUSH,
	HB_P_TRUE,
	HB_P_FUNCTIONSHORT, 10,
	HB_P_DOSHORT, 2,
/* 00937 */ HB_P_LINEOFFSET, 29,	/* 490 */
	HB_P_PUSHSYMNEAR, 9,	/* swMenu */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 6, 0,	/* MENULIST */
	HB_P_PUSHLOCALREF, 4, 0,	/* NOPCAO */
	HB_P_DOSHORT, 2,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 6, 0,	/* MENULIST */
/* 00956 */ HB_P_LINEOFFSET, 31,	/* 492 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 8,	/* 8 (abs: 00971) */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_EQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00977) */
	HB_P_JUMPNEAR, 86,	/* 86 (abs: 01059) */
	HB_P_JUMPNEAR, 81,	/* 81 (abs: 01056) */
/* 00977 */ HB_P_LINEOFFSET, 32,	/* 493 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_ONE,
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00992) */
	HB_P_PUSHSYMNEAR, 93,	/* ISWESTOQUE */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 66,	/* 66 (abs: 01056) */
/* 00992 */ HB_P_LINEOFFSET, 33,	/* 494 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01008) */
	HB_P_PUSHSYMNEAR, 94,	/* ISWBASECOBRANCA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 50,	/* 50 (abs: 01056) */
/* 01008 */ HB_P_LINEOFFSET, 34,	/* 495 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01024) */
	HB_P_PUSHSYMNEAR, 95,	/* ESWCLIENTE */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 34,	/* 34 (abs: 01056) */
/* 01024 */ HB_P_LINEOFFSET, 35,	/* 496 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01040) */
	HB_P_PUSHSYMNEAR, 96,	/* ISWCLIENTE */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 18,	/* 18 (abs: 01056) */
/* 01040 */ HB_P_LINEOFFSET, 36,	/* 497 */
	HB_P_PUSHLOCALNEAR, 4,	/* NOPCAO */
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 01056) */
	HB_P_PUSHSYMNEAR, 97,	/* ISWPRODUTO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01056) */
	HB_P_JUMP, 18, 252,	/* -1006 (abs: 00050) */
/* 01059 */ HB_P_LINEOFFSET, 39,	/* 500 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 01068 */ HB_P_LINEOFFSET, 40,	/* 501 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 01077 */ HB_P_LINEOFFSET, 41,	/* 502 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 01086 */ HB_P_LINEOFFSET, 42,	/* 503 */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 188, 2,	/* 700 */
	HB_P_FALSE,
	HB_P_DOSHORT, 2,
/* 01097 */ HB_P_LINEOFFSET, 43,	/* 504 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 01102 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( EMPRESA )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 5, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 6, 2,	/* 518 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 1,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 3,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 1,	/* 519 */
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPLOCALNEAR, 5,	/* ATELARES */
/* 00040 */ HB_P_LINEOFFSET, 2,	/* 520 */
	HB_P_LOCALNEARSETINT, 5, 0, 0,	/* ATELARES 0*/
/* 00046 */ HB_P_LINEOFFSET, 3,	/* 521 */
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPLOCALNEAR, 5,	/* ATELARES */
/* 00053 */ HB_P_LINEOFFSET, 4,	/* 522 */
	HB_P_ZERO,
	HB_P_POPVARIABLE, 98, 0,	/* ATELAR2 */
/* 00059 */ HB_P_LINEOFFSET, 5,	/* 523 */
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 98, 0,	/* ATELAR2 */
/* 00067 */ HB_P_LINEOFFSET, 6,	/* 524 */
	HB_P_PUSHBYTE, 80,	/* 80 */
	HB_P_POPVARIABLE, 99, 0,	/* NCOL */
/* 00074 */ HB_P_LINEOFFSET, 7,	/* 525 */
	HB_P_ONE,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_LESSEQUAL,
	HB_P_JUMPFALSENEAR, 68,	/* 68 (abs: 00154) */
/* 00088 */ HB_P_LINEOFFSET, 8,	/* 526 */
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_ADDINT, 246, 255,	/* -10*/
	HB_P_POPVARIABLE, 99, 0,	/* NCOL */
/* 00099 */ HB_P_LINEOFFSET, 9,	/* 527 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 5,	/* ATELARES */
	HB_P_PUSHSYMNEAR, 101,	/* SAVESCREEN */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_DOSHORT, 2,
/* 00120 */ HB_P_LINEOFFSET, 10,	/* 528 */
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 98, 0,	/* ATELAR2 */
	HB_P_PUSHSYMNEAR, 101,	/* SAVESCREEN */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_DOSHORT, 2,
/* 00143 */ HB_P_LINEOFFSET, 11,	/* 529 */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_INC,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_JUMPNEAR, 184,	/* -72 (abs: 00080) */
/* 00154 */ HB_P_LINEOFFSET, 12,	/* 530 */
	HB_P_PUSHBYTE, 176,	/* -80 */
	HB_P_POPVARIABLE, 99, 0,	/* NCOL */
/* 00161 */ HB_P_LINEOFFSET, 13,	/* 531 */
	HB_P_PUSHBYTE, 231,	/* -25 */
	HB_P_POPVARIABLE, 102, 0,	/* NLIN */
/* 00168 */ HB_P_LINEOFFSET, 14,	/* 532 */
	HB_P_ONE,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_LESSEQUAL,
	HB_P_JUMPFALSE, 153, 0,	/* 153 (abs: 00333) */
/* 00183 */ HB_P_LINEOFFSET, 15,	/* 533 */
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_ADDINT, 10, 0,	/* 10*/
	HB_P_POPVARIABLE, 99, 0,	/* NCOL */
/* 00194 */ HB_P_LINEOFFSET, 16,	/* 534 */
	HB_P_PUSHVARIABLE, 102, 0,	/* NLIN */
	HB_P_ADDINT, 3, 0,	/* 3*/
	HB_P_POPVARIABLE, 102, 0,	/* NLIN */
/* 00205 */ HB_P_LINEOFFSET, 17,	/* 535 */
	HB_P_PUSHSYMNEAR, 89,	/* DISPBEGIN */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00212 */ HB_P_LINEOFFSET, 18,	/* 536 */
	HB_P_PUSHSYMNEAR, 3,	/* VPBOX */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 102, 0,	/* NLIN */
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_PUSHVARIABLE, 102, 0,	/* NLIN */
	HB_P_ADDINT, 22, 0,	/* 22*/
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_ADDINT, 79, 0,	/* 79*/
	HB_P_PUSHSTRSHORT, 50,	/* 50 */
	' ', '<', ' ', 'M', 'u', 'l', 't', 'i', ' ', 'E', ' ', 'M', ' ', 'P', ' ', 'R', ' ', 'E', ' ', 'S', ' ', 'A', ' ', '>', ' ', '-', ' ', 'S', 'o', 'f', 't', '&', 'W', 'a', 'r', 'e', ' ', 'I', 'n', 'f', 'o', 'r', 'm', 160, 't', 'i', 'c', 'a', ' ', 0, 
	HB_P_MACROTEXT,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_ARRAYPUSH,
	HB_P_DOSHORT, 6,
/* 00296 */ HB_P_LINEOFFSET, 19,	/* 537 */
	HB_P_PUSHSYMNEAR, 53,	/* INKEY */
	HB_P_PUSHNIL,
	HB_P_PUSHDOUBLE, 154, 153, 153, 153, 153, 153, 185, 63, 0, 1,	/* 0, 0, 1 */
	HB_P_DOSHORT, 1,
/* 00314 */ HB_P_LINEOFFSET, 20,	/* 538 */
	HB_P_PUSHSYMNEAR, 91,	/* DISPEND */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00321 */ HB_P_LINEOFFSET, 21,	/* 539 */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_INC,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_JUMP, 100, 255,	/* -156 (abs: 00174) */
/* 00333 */ HB_P_LINEOFFSET, 23,	/* 541 */
	HB_P_PUSHSYMNEAR, 103,	/* FILE */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 11, 2,	/* 523 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 14,	/* 14 */
	92, 'E', 'M', 'P', 'R', 'E', 'S', 'A', 'S', '.', 'D', 'B', 'F', 0, 
	HB_P_PLUS,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_NOT,
	HB_P_JUMPFALSE, 238, 0,	/* 238 (abs: 00604) */
/* 00369 */ HB_P_LINEOFFSET, 33,	/* 551 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'C', 'O', 'D', 'I', 'G', 'O', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'N', 0, 
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'D', 'E', 'S', 'C', 'R', 'I', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'E', 'N', 'D', 'E', 'R', 'E', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 35,	/* 35 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'B', 'A', 'I', 'R', 'R', 'O', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 25,	/* 25 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'C', 'I', 'D', 'A', 'D', 'E', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'E', 'S', 'T', 'A', 'D', 'O', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'C', 'O', 'D', 'C', 'E', 'P', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'R', 'E', 'S', 'P', 'O', 'N', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'C', 'G', 'C', 'M', 'F', '_', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'C', 0, 
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'D', 'A', 'T', 'A', '_', '_', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'D', 0, 
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_ZERO,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_ARRAYGEN, 10, 0,	/* 10 */
	HB_P_POPVARIABLE, 104, 0,	/* ASTR */
/* 00567 */ HB_P_LINEOFFSET, 34,	/* 552 */
	HB_P_PUSHSYMNEAR, 105,	/* DBCREATE */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 11, 2,	/* 523 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 14,	/* 14 */
	92, 'E', 'M', 'P', 'R', 'E', 'S', 'A', 'S', '.', 'D', 'B', 'F', 0, 
	HB_P_PLUS,
	HB_P_PUSHVARIABLE, 104, 0,	/* ASTR */
	HB_P_DOSHORT, 2,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00604) */
/* 00604 */ HB_P_LINEOFFSET, 38,	/* 556 */
	HB_P_PUSHSYMNEAR, 106,	/* DBSELECTAR */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 124,	/* 124 */
	HB_P_DOSHORT, 1,
/* 00613 */ HB_P_LINEOFFSET, 39,	/* 557 */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 11, 2,	/* 523 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 14,	/* 14 */
	92, 'E', 'M', 'P', 'R', 'E', 'S', 'A', 'S', '.', 'D', 'B', 'F', 0, 
	HB_P_PLUS,
	HB_P_POPVARIABLE, 107, 0,	/* CDIREMP */
/* 00643 */ HB_P_LINEOFFSET, 41,	/* 559 */
	HB_P_PUSHSYMNEAR, 108,	/* DBUSEAREA */
	HB_P_PUSHNIL,
	HB_P_FALSE,
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 107, 0,	/* CDIREMP */
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	'E', 'M', 'P', 0, 
	HB_P_PUSHNIL,
	HB_P_FALSE,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 7,
/* 00664 */ HB_P_LINEOFFSET, 43,	/* 561 */
	HB_P_PUSHSYMNEAR, 109,	/* DBCREATEINDEX */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '0', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'C', 'O', 'D', 'I', 'G', 'O', 0, 
	HB_P_PUSHBLOCKSHORT, 6,	/* 6 */
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_ENDBLOCK,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 4,
/* 00702 */ HB_P_LINEOFFSET, 45,	/* 563 */
	HB_P_PUSHSYMNEAR, 109,	/* DBCREATEINDEX */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '1', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'D', 'E', 'S', 'C', 'R', 'I', 0, 
	HB_P_PUSHBLOCKSHORT, 6,	/* 6 */
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_ENDBLOCK,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 4,
/* 00740 */ HB_P_LINEOFFSET, 47,	/* 565 */
	HB_P_TRUE,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 00752) */
	HB_P_PUSHSYMNEAR, 112,	/* ORDLISTCLEAR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00752) */
	HB_P_PUSHSYMNEAR, 113,	/* SETDIRETORIOPADRAO */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 114,	/* SELECT */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 115,	/* ORDLISTADD */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '0', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 115,	/* ORDLISTADD */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '1', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 116,	/* RESTDIRETORIOPADRAO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00807 */ HB_P_LINEOFFSET, 48,	/* 566 */
	HB_P_PUSHSYMNEAR, 117,	/* DBGOTOP */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00814 */ HB_P_LINEOFFSET, 50,	/* 568 */
	HB_P_PUSHSYMNEAR, 89,	/* DISPBEGIN */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00821 */ HB_P_LINEOFFSET, 51,	/* 569 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_ARRAYPUSH,
	HB_P_DOSHORT, 1,
/* 00834 */ HB_P_LINEOFFSET, 52,	/* 570 */
	HB_P_PUSHSYMNEAR, 3,	/* VPBOX */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 22,	/* 22 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_PUSHSTRSHORT, 50,	/* 50 */
	' ', '<', ' ', 'M', 'u', 'l', 't', 'i', ' ', 'E', ' ', 'M', ' ', 'P', ' ', 'R', ' ', 'E', ' ', 'S', ' ', 'A', ' ', '>', ' ', '-', ' ', 'S', 'o', 'f', 't', '&', 'W', 'a', 'r', 'e', ' ', 'I', 'n', 'f', 'o', 'r', 'm', 160, 't', 'i', 'c', 'a', ' ', 0, 
	HB_P_MACROTEXT,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_ARRAYPUSH,
	HB_P_DOSHORT, 6,
/* 00906 */ HB_P_LINEOFFSET, 53,	/* 571 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_DOSHORT, 1,
/* 00914 */ HB_P_LINEOFFSET, 54,	/* 572 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 21,	/* 21 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	',', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 22,	/* 22 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	',', ',', ',', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_DOSHORT, 1,
/* 00953 */ HB_P_LINEOFFSET, 55,	/* 573 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 43,	/* 43 */
	'P', 'r', 'e', 's', 's', 'i', 'o', 'n', 'e', ' ', '[', 'E', 'N', 'T', 'E', 'R', ']', ' ', 'p', '/', ' ', 'S', 'e', 'l', 'e', 'c', 'i', 'o', 'n', 'a', 'r', ' ', 'a', ' ', 'E', 'm', 'p', 'r', 'e', 's', 'a', '.', 0, 
	HB_P_DOSHORT, 1,
/* 01005 */ HB_P_LINEOFFSET, 56,	/* 574 */
	HB_P_PUSHSYMNEAR, 118,	/* AJUDA */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'[', 0, 
	HB_P_PUSHSYMNEAR, 90,	/* MODOVGA */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_JUMPFALSENEAR, 11,	/* 11 (abs: 01030) */
	HB_P_PUSHSTRSHORT, 5,	/* 5 */
	238, 239, 240, 241, 0, 
	HB_P_JUMPNEAR, 10,	/* 10 (abs: 01038) */
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'S', 'e', 't', 'a', 's', 0, 
	HB_P_PLUS,
	HB_P_PUSHSTRSHORT, 73,	/* 73 */
	']', '[', 'P', 'g', 'U', 'p', ']', '[', 'P', 'g', 'D', 'n', ']', 'M', 'o', 'v', 'e', ' ', '[', 'I', 'N', 'S', ']', 'N', 'o', 'v', 'o', ' ', '[', 'D', 'E', 'L', ']', 'E', 'x', 'c', 'l', 'u', 'i', ' ', '[', '*', ']', 'A', 'l', 't', 'e', 'r', 'a', ' ', '[', 'E', 'N', 'T', 'E', 'R', ']', 'S', 'e', 'l', 'e', 'c', '.', ' ', '[', 'E', 'S', 'C', ']', 'S', 'a', 'i', 0, 
	HB_P_PLUS,
	HB_P_DOSHORT, 1,
/* 01117 */ HB_P_LINEOFFSET, 57,	/* 575 */
	HB_P_PUSHSYMNEAR, 119,	/* DBLEORDEM */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 01124 */ HB_P_LINEOFFSET, 58,	/* 576 */
	HB_P_PUSHSYMNEAR, 120,	/* TBROWSEDB */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_ONE,
	HB_P_PUSHBYTE, 21,	/* 21 */
	HB_P_PUSHBYTE, 78,	/* 78 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPVARIABLE, 39, 0,	/* OTAB */
/* 01140 */ HB_P_LINEOFFSET, 59,	/* 577 */
	HB_P_MESSAGE, 40, 0,	/* ADDCOLUMN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_PUSHSYMNEAR, 41,	/* TBCOLUMNNEW */
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCKSHORT, 31,	/* 31 */
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ZERO,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	' ', 0, 
	HB_P_PLUS,
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 30,	/* 30 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PLUS,
	HB_P_ENDBLOCK,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01188 */ HB_P_LINEOFFSET, 60,	/* 578 */
	HB_P_MESSAGE, 42, 0,	/* _AUTOLITE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_FALSE,
	HB_P_SENDSHORT, 1,
	HB_P_POP,
/* 01200 */ HB_P_LINEOFFSET, 61,	/* 579 */
	HB_P_MESSAGE, 48, 0,	/* DEHILITE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01211 */ HB_P_LINEOFFSET, 63,	/* 581 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSE, 146, 0,	/* 146 (abs: 01382) */
/* 01239 */ HB_P_LINEOFFSET, 64,	/* 582 */
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 2, 0,	/* 2*/
	HB_P_FUNCTIONSHORT, 2,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPVARIABLE, 127, 0,	/* NCODIGO */
/* 01283 */ HB_P_LINEOFFSET, 65,	/* 583 */
	HB_P_ZERO,
	HB_P_POPVARIABLE, 128, 0,	/* NTENTATIVA */
/* 01289 */ HB_P_LINEOFFSET, 66,	/* 584 */
	HB_P_PUSHSYMNEAR, 129,	/* EOF */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_NOT,
	HB_P_JUMPFALSENEAR, 83,	/* 83 (abs: 01380) */
/* 01299 */ HB_P_LINEOFFSET, 67,	/* 585 */
	HB_P_PUSHVARIABLE, 128, 0,	/* NTENTATIVA */
	HB_P_INC,
	HB_P_DUPLICATE,
	HB_P_POPVARIABLE, 128, 0,	/* NTENTATIVA */
	HB_P_PUSHBYTE, 100,	/* 100 */
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 13,	/* 13 (abs: 01325) */
/* 01314 */ HB_P_LINEOFFSET, 68,	/* 586 */
	HB_P_PUSHSYMNEAR, 117,	/* DBGOTOP */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 59,	/* 59 (abs: 01380) */
	HB_P_JUMPNEAR, 55,	/* 55 (abs: 01378) */
/* 01325 */ HB_P_LINEOFFSET, 70,	/* 588 */
	HB_P_PUSHVARIABLE, 127, 0,	/* NCODIGO */
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_EXACTLYEQUAL,
	HB_P_NOT,
	HB_P_JUMPFALSENEAR, 41,	/* 41 (abs: 01376) */
/* 01337 */ HB_P_LINEOFFSET, 71,	/* 589 */
	HB_P_MESSAGE, 57, 0,	/* DOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01348 */ HB_P_LINEOFFSET, 72,	/* 590 */
	HB_P_MESSAGE, 130, 0,	/* REFRESHALL */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01359 */ HB_P_LINEOFFSET, 73,	/* 591 */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_NOT,
	HB_P_JUMPFALSENEAR, 4,	/* 4 (abs: 01374) */
	HB_P_JUMPNEAR, 243,	/* -13 (abs: 01359) */
	HB_P_JUMPNEAR, 4,	/* 4 (abs: 01378) */
	HB_P_JUMPNEAR, 4,	/* 4 (abs: 01380) */
	HB_P_JUMPNEAR, 167,	/* -89 (abs: 01289) */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01382) */
/* 01382 */ HB_P_LINEOFFSET, 80,	/* 598 */
	HB_P_PUSHSYMNEAR, 91,	/* DISPEND */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 01389 */ HB_P_LINEOFFSET, 82,	/* 600 */
	HB_P_MESSAGE, 49, 0,	/* COLORRECT */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_MESSAGE, 50, 0,	/* ROWPOS */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_ONE,
	HB_P_MESSAGE, 50, 0,	/* ROWPOS */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_ONE,
	HB_P_ARRAYGEN, 4, 0,	/* 4 */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_ONE,
	HB_P_ARRAYGEN, 2, 0,	/* 2 */
	HB_P_SENDSHORT, 2,
	HB_P_POP,
/* 01427 */ HB_P_LINEOFFSET, 83,	/* 601 */
	HB_P_PUSHSYMNEAR, 51,	/* NEXTKEY */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ZERO,
	HB_P_EQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPFALSENEAR, 12,	/* 12 (abs: 01449) */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_NOT,
	HB_P_AND,
	HB_P_JUMPFALSENEAR, 4,	/* 4 (abs: 01453) */
	HB_P_JUMPNEAR, 232,	/* -24 (abs: 01427) */
/* 01453 */ HB_P_LINEOFFSET, 85,	/* 603 */
	HB_P_PUSHSYMNEAR, 53,	/* INKEY */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPVARIABLE, 54, 0,	/* NTECLA */
/* 01464 */ HB_P_LINEOFFSET, 86,	/* 604 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 27,	/* 27 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 7,	/* 7 (abs: 01479) */
	HB_P_JUMP, 208, 5,	/* 1488 (abs: 02962) */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01479) */
/* 01479 */ HB_P_LINEOFFSET, 90,	/* 608 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01501) */
	HB_P_MESSAGE, 56, 0,	/* UP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 159, 5,	/* 1439 (abs: 02937) */
/* 01501 */ HB_P_LINEOFFSET, 91,	/* 609 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 19,	/* 19 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01523) */
	HB_P_MESSAGE, 56, 0,	/* UP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 137, 5,	/* 1417 (abs: 02937) */
/* 01523 */ HB_P_LINEOFFSET, 92,	/* 610 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01545) */
	HB_P_MESSAGE, 57, 0,	/* DOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 115, 5,	/* 1395 (abs: 02937) */
/* 01545 */ HB_P_LINEOFFSET, 93,	/* 611 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01567) */
	HB_P_MESSAGE, 57, 0,	/* DOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 93, 5,	/* 1373 (abs: 02937) */
/* 01567 */ HB_P_LINEOFFSET, 94,	/* 612 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01589) */
	HB_P_MESSAGE, 58, 0,	/* PAGEUP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 71, 5,	/* 1351 (abs: 02937) */
/* 01589 */ HB_P_LINEOFFSET, 95,	/* 613 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01611) */
	HB_P_MESSAGE, 60, 0,	/* PAGEDOWN */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 49, 5,	/* 1329 (abs: 02937) */
/* 01611 */ HB_P_LINEOFFSET, 96,	/* 614 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 31,	/* 31 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01633) */
	HB_P_MESSAGE, 59, 0,	/* GOTOP */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 27, 5,	/* 1307 (abs: 02937) */
/* 01633 */ HB_P_LINEOFFSET, 97,	/* 615 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 30,	/* 30 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 01655) */
	HB_P_MESSAGE, 61, 0,	/* GOBOTTOM */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 5, 5,	/* 1285 (abs: 02937) */
/* 01655 */ HB_P_LINEOFFSET, 98,	/* 616 */
	HB_P_PUSHSYMNEAR, 131,	/* CHR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'*', 0, 
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 15,	/* 15 (abs: 01685) */
/* 01672 */ HB_P_LINEOFFSET, 99,	/* 617 */
	HB_P_PUSHSYMNEAR, 132,	/* ALTERAEMP */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_DOSHORT, 1,
	HB_P_JUMP, 231, 4,	/* 1255 (abs: 02937) */
/* 01685 */ HB_P_LINEOFFSET, 100,	/* 618 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSE, 42, 3,	/* 810 (abs: 02503) */
/* 01696 */ HB_P_LINEOFFSET, 101,	/* 619 */
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_ZERO,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 114,	/* 114 (abs: 01817) */
/* 01705 */ HB_P_LINEOFFSET, 102,	/* 620 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 38,	/* 38 (abs: 01768) */
/* 01732 */ HB_P_LINEOFFSET, 103,	/* 621 */
	HB_P_PUSHSYMNEAR, 133,	/* LEFT */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_FUNCTIONSHORT, 2,
	HB_P_POPVARIABLE, 124, 0,	/* GDIR */
	HB_P_JUMPNEAR, 15,	/* 15 (abs: 01781) */
/* 01768 */ HB_P_LINEOFFSET, 105,	/* 623 */
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPVARIABLE, 124, 0,	/* GDIR */
/* 01781 */ HB_P_LINEOFFSET, 107,	/* 625 */
	HB_P_PUSHSYMNEAR, 134,	/* RECNO */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPVARIABLE, 135, 0,	/* NRECNO */
/* 01791 */ HB_P_LINEOFFSET, 108,	/* 626 */
	HB_P_PUSHSYMNEAR, 136,	/* CONFIG */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_DOSHORT, 1,
/* 01799 */ HB_P_LINEOFFSET, 109,	/* 627 */
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	'*', '>', ' ', 0, 
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_PLUS,
	HB_P_POPVARIABLE, 137, 0,	/* _EMP */
	HB_P_JUMP, 120, 1,	/* 376 (abs: 02190) */
/* 01817 */ HB_P_LINEOFFSET, 111,	/* 629 */
	HB_P_PUSHSYMNEAR, 136,	/* CONFIG */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_DOSHORT, 1,
/* 01827 */ HB_P_LINEOFFSET, 112,	/* 630 */
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_POPVARIABLE, 137, 0,	/* _EMP */
/* 01835 */ HB_P_LINEOFFSET, 113,	/* 631 */
	HB_P_ZERO,
	HB_P_POPVARIABLE, 99, 0,	/* NCOL */
/* 01841 */ HB_P_LINEOFFSET, 114,	/* 632 */
	HB_P_ONE,
	HB_P_POPVARIABLE, 138, 0,	/* NCT2 */
/* 01847 */ HB_P_LINEOFFSET, 116,	/* 634 */
	HB_P_ONE,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_LESSEQUAL,
	HB_P_JUMPFALSE, 185, 0,	/* 185 (abs: 02044) */
/* 01862 */ HB_P_LINEOFFSET, 117,	/* 635 */
	HB_P_PUSHSYMNEAR, 101,	/* SAVESCREEN */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 69,	/* 69 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 4,	/* CTELARES */
/* 01879 */ HB_P_LINEOFFSET, 118,	/* 636 */
	HB_P_PUSHSYMNEAR, 89,	/* DISPBEGIN */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 01886 */ HB_P_LINEOFFSET, 119,	/* 637 */
	HB_P_PUSHSYMNEAR, 53,	/* INKEY */
	HB_P_PUSHNIL,
	HB_P_PUSHDOUBLE, 154, 153, 153, 153, 153, 153, 185, 63, 0, 1,	/* 0, 0, 1 */
	HB_P_DOSHORT, 1,
/* 01904 */ HB_P_LINEOFFSET, 120,	/* 638 */
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PLUS,
	HB_P_POPVARIABLE, 99, 0,	/* NCOL */
/* 01915 */ HB_P_LINEOFFSET, 121,	/* 639 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'1', '5', '/', '0', '0', 0, 
	HB_P_DOSHORT, 1,
/* 01930 */ HB_P_LINEOFFSET, 122,	/* 640 */
	HB_P_PUSHSYMNEAR, 139,	/* SCROLL */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_DOSHORT, 4,
/* 01943 */ HB_P_LINEOFFSET, 123,	/* 641 */
	HB_P_PUSHVARIABLE, 138, 0,	/* NCT2 */
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_DUPLICATE,
	HB_P_JUMPFALSENEAR, 15,	/* 15 (abs: 01966) */
	HB_P_PUSHVARIABLE, 138, 0,	/* NCT2 */
	HB_P_PUSHSYMNEAR, 45,	/* LEN */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 98, 0,	/* ATELAR2 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_LESS,
	HB_P_AND,
	HB_P_JUMPFALSENEAR, 39,	/* 39 (abs: 02005) */
/* 01968 */ HB_P_LINEOFFSET, 124,	/* 642 */
	HB_P_PUSHSYMNEAR, 140,	/* RESTSCREEN */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_PUSHMEMVAR, 98, 0,	/* ATELAR2 */
	HB_P_PUSHVARIABLE, 138, 0,	/* NCT2 */
	HB_P_ARRAYPUSH,
	HB_P_DOSHORT, 5,
/* 01992 */ HB_P_LINEOFFSET, 125,	/* 643 */
	HB_P_PUSHVARIABLE, 138, 0,	/* NCT2 */
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_POPVARIABLE, 138, 0,	/* NCT2 */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 02005) */
/* 02005 */ HB_P_LINEOFFSET, 129,	/* 647 */
	HB_P_PUSHSYMNEAR, 140,	/* RESTSCREEN */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_PUSHVARIABLE, 99, 0,	/* NCOL */
	HB_P_ADDINT, 2, 0,	/* 2*/
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 81,	/* 81 */
	HB_P_PUSHLOCALNEAR, 4,	/* CTELARES */
	HB_P_DOSHORT, 5,
/* 02025 */ HB_P_LINEOFFSET, 130,	/* 648 */
	HB_P_PUSHSYMNEAR, 91,	/* DISPEND */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 02032 */ HB_P_LINEOFFSET, 131,	/* 649 */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_INC,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_JUMP, 68, 255,	/* -188 (abs: 01853) */
/* 02044 */ HB_P_LINEOFFSET, 132,	/* 650 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 55,	/* 55 (abs: 02124) */
/* 02071 */ HB_P_LINEOFFSET, 133,	/* 651 */
	HB_P_PUSHSYMNEAR, 133,	/* LEFT */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 124, 0,	/* GDIR */
	HB_P_JUMPNEAR, 32,	/* 32 (abs: 02154) */
/* 02124 */ HB_P_LINEOFFSET, 135,	/* 653 */
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 124, 0,	/* GDIR */
/* 02154 */ HB_P_LINEOFFSET, 139,	/* 657 */
	HB_P_PUSHSYMNEAR, 113,	/* SETDIRETORIOPADRAO */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_DOSHORT, 1,
/* 02162 */ HB_P_LINEOFFSET, 141,	/* 659 */
	HB_P_PUSHSYMNEAR, 134,	/* RECNO */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPVARIABLE, 135, 0,	/* NRECNO */
/* 02172 */ HB_P_LINEOFFSET, 142,	/* 660 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 02181 */ HB_P_LINEOFFSET, 143,	/* 661 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 02190 */ HB_P_LINEOFFSET, 146,	/* 664 */
	HB_P_PUSHSYMNEAR, 141,	/* AVISO */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 35,	/* 35 */
	'A', 'g', 'u', 'a', 'r', 'd', 'e', ' ', 'a', ' ', 's', 'u', 'b', 's', 't', 'i', 't', 'u', 'i', 'c', 'a', 'o', ' ', 'd', 'a', ' ', 'e', 'm', 'p', 'r', 'e', 's', 'a', '!', 0, 
	HB_P_DOSHORT, 1,
/* 02234 */ HB_P_LINEOFFSET, 147,	/* 665 */
	HB_P_PUSHSYMNEAR, 142,	/* DBCLOSEALL */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 02241 */ HB_P_LINEOFFSET, 148,	/* 666 */
	HB_P_PUSHSYMNEAR, 143,	/* ABREGRUPO */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 18,	/* 18 */
	'T', 'O', 'D', 'O', 'S', '_', 'O', 'S', '_', 'A', 'R', 'Q', 'U', 'I', 'V', 'O', 'S', 0, 
	HB_P_DOSHORT, 1,
/* 02268 */ HB_P_LINEOFFSET, 151,	/* 669 */
	HB_P_PUSHSYMNEAR, 144,	/* DBSELECTAREA */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	'1', '2', '4', 0, 
	HB_P_DOSHORT, 1,
/* 02281 */ HB_P_LINEOFFSET, 152,	/* 670 */
	HB_P_PUSHSYMNEAR, 145,	/* USED */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_NOT,
	HB_P_JUMPFALSENEAR, 55,	/* 55 (abs: 02344) */
/* 02291 */ HB_P_LINEOFFSET, 153,	/* 671 */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 11, 2,	/* 523 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 14,	/* 14 */
	92, 'E', 'M', 'P', 'R', 'E', 'S', 'A', 'S', '.', 'D', 'B', 'F', 0, 
	HB_P_PLUS,
	HB_P_POPVARIABLE, 107, 0,	/* CDIREMP */
/* 02321 */ HB_P_LINEOFFSET, 155,	/* 673 */
	HB_P_PUSHSYMNEAR, 108,	/* DBUSEAREA */
	HB_P_PUSHNIL,
	HB_P_FALSE,
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 107, 0,	/* CDIREMP */
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	'E', 'M', 'P', 0, 
	HB_P_PUSHNIL,
	HB_P_FALSE,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 7,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 02344) */
/* 02344 */ HB_P_LINEOFFSET, 158,	/* 676 */
	HB_P_PUSHSYMNEAR, 109,	/* DBCREATEINDEX */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '0', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'C', 'O', 'D', 'I', 'G', 'O', 0, 
	HB_P_PUSHBLOCKSHORT, 6,	/* 6 */
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_ENDBLOCK,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 4,
/* 02382 */ HB_P_LINEOFFSET, 160,	/* 678 */
	HB_P_PUSHSYMNEAR, 109,	/* DBCREATEINDEX */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '1', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'D', 'E', 'S', 'C', 'R', 'I', 0, 
	HB_P_PUSHBLOCKSHORT, 6,	/* 6 */
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_ENDBLOCK,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 4,
/* 02420 */ HB_P_LINEOFFSET, 162,	/* 680 */
	HB_P_TRUE,
	HB_P_JUMPFALSENEAR, 9,	/* 9 (abs: 02432) */
	HB_P_PUSHSYMNEAR, 112,	/* ORDLISTCLEAR */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 02432) */
	HB_P_PUSHSYMNEAR, 113,	/* SETDIRETORIOPADRAO */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 114,	/* SELECT */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 115,	/* ORDLISTADD */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '0', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 115,	/* ORDLISTADD */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'I', 'N', 'D', 'I', 'C', 'E', '1', '_', '.', 'N', 'T', 'X', 0, 
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 116,	/* RESTDIRETORIOPADRAO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 02487 */ HB_P_LINEOFFSET, 164,	/* 682 */
	HB_P_PUSHSYMNEAR, 146,	/* DBGOTO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 135, 0,	/* NRECNO */
	HB_P_DOSHORT, 1,
	HB_P_JUMP, 209, 1,	/* 465 (abs: 02962) */
	HB_P_JUMP, 181, 1,	/* 437 (abs: 02937) */
/* 02503 */ HB_P_LINEOFFSET, 170,	/* 688 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 22,	/* 22 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 13,	/* 13 (abs: 02524) */
	HB_P_PUSHSYMNEAR, 147,	/* INCLUIEMP */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_DOSHORT, 1,
	HB_P_JUMP, 160, 1,	/* 416 (abs: 02937) */
/* 02524 */ HB_P_LINEOFFSET, 171,	/* 689 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSE, 74, 1,	/* 330 (abs: 02862) */
/* 02535 */ HB_P_LINEOFFSET, 172,	/* 690 */
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_POPVARIABLE, 127, 0,	/* NCODIGO */
/* 02543 */ HB_P_LINEOFFSET, 173,	/* 691 */
	HB_P_PUSHSYMNEAR, 148,	/* EXCLUI */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_DOSHORT, 1,
/* 02553 */ HB_P_LINEOFFSET, 174,	/* 692 */
	HB_P_PUSHSYMNEAR, 149,	/* CONFIRMA */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHSTRSHORT, 33,	/* 33 */
	'D', 'e', 's', 't', 'r', 'u', 'i', 'r', ' ', 'o', 's', ' ', 'd', 'a', 'd', 'o', 's', ' ', 'd', 'e', 's', 't', 'a', ' ', 'e', 'm', 'p', 'r', 'e', 's', 'a', '?', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'*', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'*', 0, 
	HB_P_FUNCTIONSHORT, 5,
	HB_P_JUMPFALSE, 255, 0,	/* 255 (abs: 02860) */
/* 02608 */ HB_P_LINEOFFSET, 175,	/* 693 */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 4,	/* CTELARES */
/* 02623 */ HB_P_LINEOFFSET, 176,	/* 694 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	' ', 0, 
	HB_P_DOSHORT, 1,
/* 02634 */ HB_P_LINEOFFSET, 177,	/* 695 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 55,	/* 55 (abs: 02714) */
/* 02661 */ HB_P_LINEOFFSET, 178,	/* 696 */
	HB_P_PUSHSYMNEAR, 133,	/* LEFT */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 127, 0,	/* NCODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 150, 0,	/* GDIRRES */
	HB_P_JUMPNEAR, 32,	/* 32 (abs: 02744) */
/* 02714 */ HB_P_LINEOFFSET, 180,	/* 698 */
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 127, 0,	/* NCODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 150, 0,	/* GDIRRES */
/* 02744 */ HB_P_LINEOFFSET, 182,	/* 700 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_DOSHORT, 4,
/* 02765 */ HB_P_LINEOFFSET, 183,	/* 701 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 20,	/* 20 */
	'D', 'e', 'l', 'T', 'r', 'e', 'e', ' ', '&', 'G', 'D', 'i', 'r', 'R', 'e', 's', ' ', '/', 'Y', 0, 
	HB_P_MACROTEXT,
	HB_P_DOSHORT, 1,
/* 02795 */ HB_P_LINEOFFSET, 184,	/* 702 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	'M', 'd', ' ', '&', 'G', 'D', 'i', 'r', 'R', 'e', 's', 0, 
	HB_P_MACROTEXT,
	HB_P_DOSHORT, 1,
/* 02817 */ HB_P_LINEOFFSET, 185,	/* 703 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	'R', 'd', ' ', '&', 'G', 'D', 'i', 'r', 'R', 'e', 's', 0, 
	HB_P_MACROTEXT,
	HB_P_DOSHORT, 1,
/* 02839 */ HB_P_LINEOFFSET, 186,	/* 704 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 4,	/* CTELARES */
	HB_P_DOSHORT, 1,
/* 02848 */ HB_P_LINEOFFSET, 187,	/* 705 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 1,	/* 1 */
	0, 
	HB_P_DOSHORT, 1,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 02860) */
	HB_P_JUMPNEAR, 77,	/* 77 (abs: 02937) */
/* 02862 */ HB_P_LINEOFFSET, 189,	/* 707 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 13,	/* 13 (abs: 02883) */
	HB_P_PUSHSYMNEAR, 153,	/* DBMUDAORDEM */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_DOSHORT, 2,
	HB_P_JUMPNEAR, 56,	/* 56 (abs: 02937) */
/* 02883 */ HB_P_LINEOFFSET, 190,	/* 708 */
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHBYTE, 254,	/* -2 */
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 14,	/* 14 (abs: 02905) */
	HB_P_PUSHSYMNEAR, 153,	/* DBMUDAORDEM */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_DOSHORT, 2,
	HB_P_JUMPNEAR, 34,	/* 34 (abs: 02937) */
/* 02905 */ HB_P_LINEOFFSET, 191,	/* 709 */
	HB_P_PUSHSYMNEAR, 154,	/* DBPESQUISA */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 54, 0,	/* NTECLA */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_JUMPFALSENEAR, 4,	/* 4 (abs: 02922) */
	HB_P_JUMPNEAR, 17,	/* 17 (abs: 02937) */
	HB_P_PUSHSYMNEAR, 67,	/* TONE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 125,	/* 125 */
	HB_P_DOSHORT, 1,
	HB_P_PUSHSYMNEAR, 67,	/* TONE */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 44, 1,	/* 300 */
	HB_P_DOSHORT, 1,
/* 02937 */ HB_P_LINEOFFSET, 194,	/* 712 */
	HB_P_MESSAGE, 68, 0,	/* REFRESHCURRENT */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 02948 */ HB_P_LINEOFFSET, 195,	/* 713 */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHVARIABLE, 39, 0,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
	HB_P_JUMP, 222, 249,	/* -1570 (abs: 01389) */
/* 02962 */ HB_P_LINEOFFSET, 198,	/* 716 */
	HB_P_PUSHSYMNEAR, 155,	/* DBCLOSEAREA */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 02969 */ HB_P_LINEOFFSET, 199,	/* 717 */
	HB_P_PUSHSYMNEAR, 106,	/* DBSELECTAR */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 40,	/* 40 */
	HB_P_DOSHORT, 1,
/* 02978 */ HB_P_LINEOFFSET, 200,	/* 718 */
	HB_P_PUSHSYMNEAR, 156,	/* FECHAARQUIVOS */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 02985 */ HB_P_LINEOFFSET, 201,	/* 719 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 02994 */ HB_P_LINEOFFSET, 202,	/* 720 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 03003 */ HB_P_LINEOFFSET, 203,	/* 721 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 03012 */ HB_P_LINEOFFSET, 204,	/* 722 */
	HB_P_PUSHSYMNEAR, 157,	/* LASTKEY */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHBYTE, 27,	/* 27 */
	HB_P_EXACTLYEQUAL,
	HB_P_NOT,
	HB_P_JUMPFALSE, 253, 0,	/* 253 (abs: 03276) */
/* 03026 */ HB_P_LINEOFFSET, 205,	/* 723 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'1', '5', '/', '0', '0', 0, 
	HB_P_DOSHORT, 1,
/* 03041 */ HB_P_LINEOFFSET, 206,	/* 724 */
	HB_P_PUSHSYMNEAR, 139,	/* SCROLL */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_ONE,
	HB_P_ONE,
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_DOSHORT, 6,
/* 03056 */ HB_P_LINEOFFSET, 207,	/* 725 */
	HB_P_ONE,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_LESSEQUAL,
	HB_P_JUMPFALSE, 180, 0,	/* 180 (abs: 03248) */
/* 03071 */ HB_P_LINEOFFSET, 208,	/* 726 */
	HB_P_PUSHSYMNEAR, 139,	/* SCROLL */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_ONE,
	HB_P_ONE,
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_DOSHORT, 6,
/* 03086 */ HB_P_LINEOFFSET, 209,	/* 727 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 158,	/* PAD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 137, 0,	/* _EMP */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_MINUS,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_ONE,
	HB_P_DOSHORT, 4,
/* 03117 */ HB_P_LINEOFFSET, 212,	/* 730 */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_ONE,
	HB_P_EXACTLYEQUAL,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03134) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03144) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03154) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03164) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03174) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 25,	/* 25 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03184) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 30,	/* 30 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03194) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 35,	/* 35 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03204) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 40,	/* 40 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_DUPLICATE,
	HB_P_JUMPTRUENEAR, 9,	/* 9 (abs: 03214) */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_EXACTLYEQUAL,
	HB_P_OR,
	HB_P_JUMPFALSENEAR, 22,	/* 22 (abs: 03236) */
/* 03216 */ HB_P_LINEOFFSET, 213,	/* 731 */
	HB_P_PUSHSYMNEAR, 53,	/* INKEY */
	HB_P_PUSHNIL,
	HB_P_PUSHDOUBLE, 123, 20, 174, 71, 225, 122, 132, 63, 1, 2,	/* 0.0, 1, 2 */
	HB_P_DOSHORT, 1,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 03236) */
/* 03236 */ HB_P_LINEOFFSET, 215,	/* 733 */
	HB_P_PUSHVARIABLE, 100, 0,	/* NCT */
	HB_P_INC,
	HB_P_POPVARIABLE, 100, 0,	/* NCT */
	HB_P_JUMP, 73, 255,	/* -183 (abs: 03062) */
/* 03248 */ HB_P_LINEOFFSET, 216,	/* 734 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 03257 */ HB_P_LINEOFFSET, 217,	/* 735 */
	HB_P_PUSHSYMNEAR, 159,	/* TITULO */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 158,	/* PAD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 137, 0,	/* _EMP */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_DOSHORT, 1,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 03276) */
/* 03276 */ HB_P_LINEOFFSET, 220,	/* 738 */
	HB_P_TRUE,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 03281 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( INCLUIEMP )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 14, 1,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 240, 2,	/* 752 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 3,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 4,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 4,	/* 756 */
	HB_P_LOCALNEARSETINT, 5, 0, 0,	/* NCODIGO 0*/
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 6,	/* CDESCRI */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 35,	/* 35 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 7,	/* CENDERE */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 25,	/* 25 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 8,	/* CBAIRRO */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 9,	/* CCIDADE */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 10,	/* CESTADO */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 11,	/* CCODCEP */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 12,	/* CRESPON */
	HB_P_PUSHSYMNEAR, 122,	/* SPACE */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPLOCALNEAR, 13,	/* CCGCMF_ */
	HB_P_PUSHSYMNEAR, 160,	/* DATE */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 14,	/* DDATA__ */
/* 00118 */ HB_P_LINEOFFSET, 5,	/* 757 */
	HB_P_PUSHSYMNEAR, 161,	/* INDEXORD */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 15,	/* NORDEM */
/* 00127 */ HB_P_LINEOFFSET, 6,	/* 758 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_DOSHORT, 1,
/* 00135 */ HB_P_LINEOFFSET, 7,	/* 759 */
	HB_P_PUSHSYMNEAR, 3,	/* VPBOX */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_PUSHBYTE, 75,	/* 75 */
	HB_P_PUSHSTRSHORT, 11,	/* 11 */
	' ', 'I', 'n', 'c', 'l', 'u', 's', 'a', 'o', ' ', 0, 
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_ARRAYPUSH,
	HB_P_DOSHORT, 6,
/* 00169 */ HB_P_LINEOFFSET, 8,	/* 760 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	',', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	',', ',', ',', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_DOSHORT, 1,
/* 00208 */ HB_P_LINEOFFSET, 9,	/* 761 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'o', 'd', 'i', 'g', 'o', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	5, 0,	/* NCODIGO */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00284) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00289) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'n', 'C', 'o', 'd', 'i', 'g', 'o', 0, 
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	'9', '9', '9', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00324 */ HB_P_LINEOFFSET, 10,	/* 762 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'N', 'o', 'm', 'e', '/', 'R', '.', ' ', 'S', 'o', 'c', 'i', 'a', 'l', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	6, 0,	/* CDESCRI */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00400) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00405) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'D', 'e', 's', 'c', 'r', 'i', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00435 */ HB_P_LINEOFFSET, 11,	/* 763 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'G', 'C', '/', 'M', 'F', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	13, 0,	/* CCGCMF_ */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00511) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00516) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'C', 'G', 'C', 'M', 'F', '_', 0, 
	HB_P_PUSHSTRSHORT, 22,	/* 22 */
	'@', 'R', ' ', '9', '9', '.', '9', '9', '9', '.', '9', '9', '9', '/', '9', '9', '9', '9', '-', '9', '9', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00569 */ HB_P_LINEOFFSET, 12,	/* 764 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'E', 'n', 'd', 'e', 'r', 'e', 'c', 'o', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	7, 0,	/* CENDERE */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00645) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00650) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'E', 'n', 'd', 'e', 'r', 'e', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00680 */ HB_P_LINEOFFSET, 13,	/* 765 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'B', 'a', 'i', 'r', 'r', 'o', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	8, 0,	/* CBAIRRO */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00756) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00761) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'B', 'a', 'i', 'r', 'r', 'o', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00791 */ HB_P_LINEOFFSET, 14,	/* 766 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'i', 'd', 'a', 'd', 'e', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	9, 0,	/* CCIDADE */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00867) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00872) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'C', 'i', 'd', 'a', 'd', 'e', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00902 */ HB_P_LINEOFFSET, 15,	/* 767 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'E', 's', 't', 'a', 'd', 'o', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	10, 0,	/* CESTADO */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00978) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00983) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'E', 's', 't', 'a', 'd', 'o', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01013 */ HB_P_LINEOFFSET, 16,	/* 768 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'e', 'p', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	11, 0,	/* CCODCEP */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 01089) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 01094) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'C', 'o', 'd', 'C', 'e', 'p', 0, 
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'@', 'R', ' ', '9', '9', '9', '9', '9', '-', '9', '9', '9', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01138 */ HB_P_LINEOFFSET, 17,	/* 769 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'R', 'e', 's', 'p', 'o', 'n', 's', 'a', 'v', 'e', 'l', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	12, 0,	/* CRESPON */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 01214) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 01219) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'R', 'e', 's', 'p', 'o', 'n', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01249 */ HB_P_LINEOFFSET, 18,	/* 770 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'D', 'a', 't', 'a', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	14, 0,	/* DDATA__ */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 01325) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 01330) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'd', 'D', 'a', 't', 'a', '_', '_', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01360 */ HB_P_LINEOFFSET, 19,	/* 771 */
	HB_P_PUSHSYMNEAR, 167,	/* READMODAL */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 7,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 164, 0,	/* GETLIST */
/* 01382 */ HB_P_LINEOFFSET, 20,	/* 772 */
	HB_P_PUSHSYMNEAR, 157,	/* LASTKEY */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHBYTE, 27,	/* 27 */
	HB_P_EXACTLYEQUAL,
	HB_P_NOT,
	HB_P_JUMPFALSE, 122, 0,	/* 122 (abs: 01515) */
/* 01396 */ HB_P_LINEOFFSET, 21,	/* 773 */
	HB_P_PUSHSYMNEAR, 168,	/* DBAPPEND */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 01403 */ HB_P_LINEOFFSET, 31,	/* 783 */
	HB_P_PUSHLOCALNEAR, 5,	/* NCODIGO */
	HB_P_POPFIELD, 110, 0,	/* CODIGO */
	HB_P_PUSHLOCALNEAR, 6,	/* CDESCRI */
	HB_P_POPFIELD, 111, 0,	/* DESCRI */
	HB_P_PUSHLOCALNEAR, 7,	/* CENDERE */
	HB_P_POPFIELD, 169, 0,	/* ENDERE */
	HB_P_PUSHLOCALNEAR, 8,	/* CBAIRRO */
	HB_P_POPFIELD, 170, 0,	/* BAIRRO */
	HB_P_PUSHLOCALNEAR, 9,	/* CCIDADE */
	HB_P_POPFIELD, 171, 0,	/* CIDADE */
	HB_P_PUSHLOCALNEAR, 10,	/* CESTADO */
	HB_P_POPFIELD, 172, 0,	/* ESTADO */
	HB_P_PUSHLOCALNEAR, 11,	/* CCODCEP */
	HB_P_POPFIELD, 173, 0,	/* CODCEP */
	HB_P_PUSHLOCALNEAR, 13,	/* CCGCMF_ */
	HB_P_POPFIELD, 174, 0,	/* CGCMF_ */
	HB_P_PUSHLOCALNEAR, 12,	/* CRESPON */
	HB_P_POPFIELD, 175, 0,	/* RESPON */
	HB_P_PUSHLOCALNEAR, 14,	/* DDATA__ */
	HB_P_POPFIELD, 176, 0,	/* DATA__ */
	HB_P_PUSHSYMNEAR, 177,	/* FIELDPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'F', 'I', 'L', 'I', 'A', 'L', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_DUPLICATE,
	HB_P_JUMPFALSENEAR, 8,	/* 8 (abs: 01480) */
	HB_P_PUSHSYMNEAR, 178,	/* netrlock */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_AND,
	HB_P_JUMPFALSENEAR, 26,	/* 26 (abs: 01506) */
	HB_P_PUSHFIELD, 179, 0,	/* FILIAL */
	HB_P_ZERO,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 16,	/* 16 (abs: 01503) */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 121, 2,	/* 633 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_DUPLICATE,
	HB_P_POPFIELD, 179, 0,	/* FILIAL */
	HB_P_JUMPNEAR, 3,	/* 3 (abs: 01504) */
	HB_P_PUSHNIL,
	HB_P_JUMPNEAR, 3,	/* 3 (abs: 01507) */
	HB_P_PUSHNIL,
	HB_P_POP,
	HB_P_PUSHSYMNEAR, 180,	/* GRAVAEMDISCO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01515) */
/* 01515 */ HB_P_LINEOFFSET, 33,	/* 785 */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_JUMPFALSENEAR, 54,	/* 54 (abs: 01594) */
/* 01542 */ HB_P_LINEOFFSET, 34,	/* 786 */
	HB_P_PUSHSYMNEAR, 133,	/* LEFT */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_PUSHSYMNEAR, 87,	/* AT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_ADDINT, 255, 255,	/* -1*/
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 5,	/* NCODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 150, 0,	/* GDIRRES */
	HB_P_JUMPNEAR, 31,	/* 31 (abs: 01623) */
/* 01594 */ HB_P_LINEOFFSET, 36,	/* 788 */
	HB_P_PUSHSYMNEAR, 123,	/* ALLTRIM */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 124, 0,	/* GDIR */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	92, '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 5,	/* NCODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 150, 0,	/* GDIRRES */
/* 01623 */ HB_P_LINEOFFSET, 38,	/* 790 */
	HB_P_PUSHSYMNEAR, 88,	/* __RUN */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 12,	/* 12 */
	'M', 'd', ' ', '&', 'G', 'D', 'i', 'r', 'R', 'e', 's', 0, 
	HB_P_MACROTEXT,
	HB_P_DOSHORT, 1,
/* 01645 */ HB_P_LINEOFFSET, 39,	/* 791 */
	HB_P_PUSHSYMNEAR, 181,	/* DBSETORDER */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 15,	/* NORDEM */
	HB_P_DOSHORT, 1,
/* 01654 */ HB_P_LINEOFFSET, 41,	/* 793 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 01663 */ HB_P_LINEOFFSET, 42,	/* 794 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 01672 */ HB_P_LINEOFFSET, 43,	/* 795 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 4,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 01681 */ HB_P_LINEOFFSET, 44,	/* 796 */
	HB_P_MESSAGE, 130, 0,	/* REFRESHALL */
	HB_P_PUSHLOCALNEAR, 1,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01691 */ HB_P_LINEOFFSET, 45,	/* 797 */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHLOCALNEAR, 1,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_NOT,
	HB_P_JUMPFALSENEAR, 4,	/* 4 (abs: 01705) */
	HB_P_JUMPNEAR, 244,	/* -12 (abs: 01691) */
/* 01705 */ HB_P_LINEOFFSET, 47,	/* 799 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 01710 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( ALTERAEMP )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 15, 1,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 45, 3,	/* 813 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* CCOR */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 3,	/* NCURSOR */
	HB_P_PUSHSYMNEAR, 20,	/* SCREENSAVE */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 79,	/* 79 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 4,	/* CTELA */
/* 00033 */ HB_P_LINEOFFSET, 4,	/* 817 */
	HB_P_PUSHVARIABLE, 110, 0,	/* CODIGO */
	HB_P_POPLOCALNEAR, 5,	/* NCODIGO */
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_POPLOCALNEAR, 6,	/* CDESCRI */
	HB_P_PUSHVARIABLE, 169, 0,	/* ENDERE */
	HB_P_POPLOCALNEAR, 7,	/* CENDERE */
	HB_P_PUSHVARIABLE, 170, 0,	/* BAIRRO */
	HB_P_POPLOCALNEAR, 8,	/* CBAIRRO */
	HB_P_PUSHVARIABLE, 171, 0,	/* CIDADE */
	HB_P_POPLOCALNEAR, 9,	/* CCIDADE */
	HB_P_PUSHVARIABLE, 172, 0,	/* ESTADO */
	HB_P_POPLOCALNEAR, 10,	/* CESTADO */
	HB_P_PUSHVARIABLE, 173, 0,	/* CODCEP */
	HB_P_POPLOCALNEAR, 11,	/* CCODCEP */
	HB_P_PUSHVARIABLE, 175, 0,	/* RESPON */
	HB_P_POPLOCALNEAR, 12,	/* CRESPON */
	HB_P_PUSHVARIABLE, 174, 0,	/* CGCMF_ */
	HB_P_POPLOCALNEAR, 13,	/* CCGCMF_ */
	HB_P_PUSHVARIABLE, 176, 0,	/* DATA__ */
	HB_P_POPLOCALNEAR, 14,	/* DDATA__ */
/* 00085 */ HB_P_LINEOFFSET, 5,	/* 818 */
	HB_P_PUSHSYMNEAR, 161,	/* INDEXORD */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 15,	/* NORDEM */
/* 00094 */ HB_P_LINEOFFSET, 6,	/* 819 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_DOSHORT, 1,
/* 00102 */ HB_P_LINEOFFSET, 7,	/* 820 */
	HB_P_PUSHSYMNEAR, 3,	/* VPBOX */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_PUSHBYTE, 75,	/* 75 */
	HB_P_PUSHSTRSHORT, 9,	/* 9 */
	' ', 'A', 'l', 't', 'e', 'r', 'a', ' ', 0, 
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_ARRAYPUSH,
	HB_P_DOSHORT, 6,
/* 00134 */ HB_P_LINEOFFSET, 8,	/* 821 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_ARRAYPUSH,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	',', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	',', ',', ',', 0, 
	HB_P_PLUS,
	HB_P_PUSHMEMVAR, 8, 0,	/* COR */
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_ARRAYPUSH,
	HB_P_PLUS,
	HB_P_DOSHORT, 1,
/* 00173 */ HB_P_LINEOFFSET, 9,	/* 822 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 18,	/* 18 */
	'C', 'o', 'd', 'i', 'g', 'o', '.', '.', '.', '.', '.', '.', '.', '.', ':', ' ', '[', 0, 
	HB_P_PUSHSYMNEAR, 182,	/* STR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 5,	/* NCODIGO */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ZERO,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_PLUS,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	']', 0, 
	HB_P_PLUS,
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 8,	/* 8 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
/* 00221 */ HB_P_LINEOFFSET, 10,	/* 823 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'N', 'o', 'm', 'e', '/', 'R', '.', ' ', 'S', 'o', 'c', 'i', 'a', 'l', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	6, 0,	/* CDESCRI */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00297) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00302) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'D', 'e', 's', 'c', 'r', 'i', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00332 */ HB_P_LINEOFFSET, 11,	/* 824 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'G', 'C', '/', 'M', 'F', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	13, 0,	/* CCGCMF_ */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00408) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00413) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'C', 'G', 'C', 'M', 'F', '_', 0, 
	HB_P_PUSHSTRSHORT, 22,	/* 22 */
	'@', 'R', ' ', '9', '9', '.', '9', '9', '9', '.', '9', '9', '9', '/', '9', '9', '9', '9', '-', '9', '9', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00466 */ HB_P_LINEOFFSET, 12,	/* 825 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'E', 'n', 'd', 'e', 'r', 'e', 'c', 'o', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 11,	/* 11 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	7, 0,	/* CENDERE */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00542) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00547) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'E', 'n', 'd', 'e', 'r', 'e', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00577 */ HB_P_LINEOFFSET, 13,	/* 826 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'B', 'a', 'i', 'r', 'r', 'o', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	8, 0,	/* CBAIRRO */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00653) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00658) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'B', 'a', 'i', 'r', 'r', 'o', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00688 */ HB_P_LINEOFFSET, 14,	/* 827 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'i', 'd', 'a', 'd', 'e', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	9, 0,	/* CCIDADE */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00764) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00769) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'C', 'i', 'd', 'a', 'd', 'e', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00799 */ HB_P_LINEOFFSET, 15,	/* 828 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'E', 's', 't', 'a', 'd', 'o', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	10, 0,	/* CESTADO */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00875) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00880) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'E', 's', 't', 'a', 'd', 'o', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 00910 */ HB_P_LINEOFFSET, 16,	/* 829 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'e', 'p', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	11, 0,	/* CCODCEP */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00986) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 00991) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'C', 'o', 'd', 'C', 'e', 'p', 0, 
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	'@', 'R', ' ', '9', '9', '9', '9', '9', '-', '9', '9', '9', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01035 */ HB_P_LINEOFFSET, 17,	/* 830 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'R', 'e', 's', 'p', 'o', 'n', 's', 'a', 'v', 'e', 'l', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 16,	/* 16 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	12, 0,	/* CRESPON */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 01111) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 01116) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'c', 'R', 'e', 's', 'p', 'o', 'n', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01146 */ HB_P_LINEOFFSET, 18,	/* 831 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'D', 'a', 't', 'a', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', ':', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_DOSHORT, 4,
	HB_P_PUSHSYMNEAR, 162,	/* SETPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 152,	/* ROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 163,	/* COL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_DOSHORT, 2,
	HB_P_PUSHSYMNEAR, 5,	/* AADD */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHSYMNEAR, 165,	/* __GET */
	HB_P_PUSHNIL,
	HB_P_PUSHBLOCK, 25, 0,	/* 25 */
	1, 0,	/* number of local parameters (1) */
	1, 0,	/* number of local variables (1) */
	14, 0,	/* DDATA__ */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_PUSHNIL,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 01222) */
	HB_P_PUSHLOCALNEAR, 255,	/* localvar1 */
	HB_P_JUMPNEAR, 7,	/* 7 (abs: 01227) */
	HB_P_PUSHLOCALNEAR, 1,	/* codeblockvar1 */
	HB_P_DUPLICATE,
	HB_P_POPLOCALNEAR, 255,	/* localvar1 */
	HB_P_ENDBLOCK,
	HB_P_PUSHSTRSHORT, 8,	/* 8 */
	'd', 'D', 'a', 't', 'a', '_', '_', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 5,
	HB_P_DOSHORT, 2,
	HB_P_MESSAGE, 166, 0,	/* DISPLAY */
	HB_P_PUSHMEMVAR, 164, 0,	/* GETLIST */
	HB_P_PUSHBYTE, 255,	/* -1 */
	HB_P_ARRAYPUSH,
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01257 */ HB_P_LINEOFFSET, 19,	/* 832 */
	HB_P_PUSHSYMNEAR, 167,	/* READMODAL */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 164, 0,	/* GETLIST */
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 7,
	HB_P_ARRAYGEN, 0, 0,	/* 0 */
	HB_P_POPVARIABLE, 164, 0,	/* GETLIST */
/* 01279 */ HB_P_LINEOFFSET, 20,	/* 833 */
	HB_P_PUSHSYMNEAR, 157,	/* LASTKEY */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHBYTE, 27,	/* 27 */
	HB_P_EXACTLYEQUAL,
	HB_P_NOT,
	HB_P_JUMPFALSE, 122, 0,	/* 122 (abs: 01412) */
/* 01293 */ HB_P_LINEOFFSET, 21,	/* 834 */
	HB_P_PUSHSYMNEAR, 178,	/* netrlock */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_JUMPFALSE, 110, 0,	/* 110 (abs: 01410) */
/* 01303 */ HB_P_LINEOFFSET, 30,	/* 843 */
	HB_P_PUSHLOCALNEAR, 6,	/* CDESCRI */
	HB_P_POPFIELD, 111, 0,	/* DESCRI */
	HB_P_PUSHLOCALNEAR, 7,	/* CENDERE */
	HB_P_POPFIELD, 169, 0,	/* ENDERE */
	HB_P_PUSHLOCALNEAR, 8,	/* CBAIRRO */
	HB_P_POPFIELD, 170, 0,	/* BAIRRO */
	HB_P_PUSHLOCALNEAR, 9,	/* CCIDADE */
	HB_P_POPFIELD, 171, 0,	/* CIDADE */
	HB_P_PUSHLOCALNEAR, 10,	/* CESTADO */
	HB_P_POPFIELD, 172, 0,	/* ESTADO */
	HB_P_PUSHLOCALNEAR, 11,	/* CCODCEP */
	HB_P_POPFIELD, 173, 0,	/* CODCEP */
	HB_P_PUSHLOCALNEAR, 13,	/* CCGCMF_ */
	HB_P_POPFIELD, 174, 0,	/* CGCMF_ */
	HB_P_PUSHLOCALNEAR, 12,	/* CRESPON */
	HB_P_POPFIELD, 175, 0,	/* RESPON */
	HB_P_PUSHLOCALNEAR, 14,	/* DDATA__ */
	HB_P_POPFIELD, 176, 0,	/* DATA__ */
	HB_P_PUSHSYMNEAR, 177,	/* FIELDPOS */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'F', 'I', 'L', 'I', 'A', 'L', 0, 
	HB_P_FUNCTIONSHORT, 1,
	HB_P_ZERO,
	HB_P_GREATER,
	HB_P_DUPLICATE,
	HB_P_JUMPFALSENEAR, 8,	/* 8 (abs: 01375) */
	HB_P_PUSHSYMNEAR, 178,	/* netrlock */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_AND,
	HB_P_JUMPFALSENEAR, 26,	/* 26 (abs: 01401) */
	HB_P_PUSHFIELD, 179, 0,	/* FILIAL */
	HB_P_ZERO,
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 16,	/* 16 (abs: 01398) */
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 121, 2,	/* 633 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_DUPLICATE,
	HB_P_POPFIELD, 179, 0,	/* FILIAL */
	HB_P_JUMPNEAR, 3,	/* 3 (abs: 01399) */
	HB_P_PUSHNIL,
	HB_P_JUMPNEAR, 3,	/* 3 (abs: 01402) */
	HB_P_PUSHNIL,
	HB_P_POP,
	HB_P_PUSHSYMNEAR, 180,	/* GRAVAEMDISCO */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01410) */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 01412) */
/* 01412 */ HB_P_LINEOFFSET, 33,	/* 846 */
	HB_P_PUSHSYMNEAR, 181,	/* DBSETORDER */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 15,	/* NORDEM */
	HB_P_DOSHORT, 1,
/* 01421 */ HB_P_LINEOFFSET, 34,	/* 847 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 01430 */ HB_P_LINEOFFSET, 35,	/* 848 */
	HB_P_PUSHSYMNEAR, 19,	/* SETCURSOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 3,	/* NCURSOR */
	HB_P_DOSHORT, 1,
/* 01439 */ HB_P_LINEOFFSET, 36,	/* 849 */
	HB_P_PUSHSYMNEAR, 69,	/* SCREENREST */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 4,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 01448 */ HB_P_LINEOFFSET, 37,	/* 850 */
	HB_P_MESSAGE, 130, 0,	/* REFRESHALL */
	HB_P_PUSHLOCALNEAR, 1,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_POP,
/* 01458 */ HB_P_LINEOFFSET, 38,	/* 851 */
	HB_P_MESSAGE, 52, 0,	/* STABILIZE */
	HB_P_PUSHLOCALNEAR, 1,	/* OTAB */
	HB_P_SENDSHORT, 0,
	HB_P_NOT,
	HB_P_JUMPFALSENEAR, 4,	/* 4 (abs: 01472) */
	HB_P_JUMPNEAR, 244,	/* -12 (abs: 01458) */
/* 01472 */ HB_P_LINEOFFSET, 40,	/* 853 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 01477 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( EXPTOLEDO )
{
   static const BYTE pcode[] =
   {
/* 00000 */ HB_P_BASELINE, 88, 3,	/* 856 */
	HB_P_PUSHSYMNEAR, 149,	/* CONFIRMA */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHSTRSHORT, 48,	/* 48 */
	'D', 'e', 's', 'e', 'j', 'a', ' ', 'I', 'm', 'p', 'o', 'r', 't', 'a', 'r', ' ', 'o', 's', ' ', 'P', 'r', 'o', 'd', 'u', 't', 'o', 's', ' ', 'p', 'a', 'r', 'a', ' ', 'T', 'X', 'I', 'N', 'T', 'E', 'N', 'S', '.', 'T', 'X', 'T', ' ', '?', 0, 
	HB_P_PUSHSTRSHORT, 23,	/* 23 */
	'D', 'i', 'g', 'i', 't', 'e', ' ', '[', 'S', ']', 'i', 'm', ' ', 'o', 'u', ' ', '[', 'N', ']', 'a', 'o', '.', 0, 
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'N', 0, 
	HB_P_FUNCTIONSHORT, 5,
	HB_P_JUMPFALSE, 213, 1,	/* 469 (abs: 00558) */
/* 00092 */ HB_P_LINEOFFSET, 1,	/* 857 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 51,	/* 51 */
	'A', 'g', 'u', 'a', 'r', 'd', 'e', ',', ' ', 'E', 'x', 'p', 'o', 'r', 't', 'a', 'n', 'd', 'o', ' ', 'P', 'r', 'o', 'd', 'u', 't', 'o', 's', ' ', 'P', 'a', 'r', 'a', ' ', 'T', 'X', 'T', 'I', 'T', 'E', 'N', 'S', '.', 'T', 'X', 'T', '.', '.', '.', ' ', 0, 
	HB_P_DOSHORT, 1,
/* 00152 */ HB_P_LINEOFFSET, 2,	/* 858 */
	HB_P_PUSHSYMNEAR, 106,	/* DBSELECTAR */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_DOSHORT, 1,
/* 00161 */ HB_P_LINEOFFSET, 3,	/* 859 */
	HB_P_PUSHSYMNEAR, 181,	/* DBSETORDER */
	HB_P_PUSHNIL,
	HB_P_ONE,
	HB_P_DOSHORT, 1,
/* 00169 */ HB_P_LINEOFFSET, 4,	/* 860 */
	HB_P_PUSHSYMNEAR, 183,	/* SET */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_POPVARIABLE, 184, 0,	/* CPORTA */
/* 00181 */ HB_P_LINEOFFSET, 5,	/* 861 */
	HB_P_PUSHSYMNEAR, 183,	/* SET */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHMEMVAR, 124, 0,	/* GDIR */
	HB_P_PUSHSTRSHORT, 13,	/* 13 */
	92, 'T', 'X', 'I', 'T', 'E', 'N', 'S', '.', 'T', 'X', 'T', 0, 
	HB_P_MINUS,
	HB_P_DOSHORT, 2,
/* 00209 */ HB_P_LINEOFFSET, 6,	/* 862 */
	HB_P_PUSHSYMNEAR, 183,	/* SET */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_PUSHSTRSHORT, 6,	/* 6 */
	'P', 'R', 'I', 'N', 'T', 0, 
	HB_P_DOSHORT, 2,
/* 00226 */ HB_P_LINEOFFSET, 7,	/* 863 */
	HB_P_PUSHSYMNEAR, 117,	/* DBGOTOP */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
/* 00233 */ HB_P_LINEOFFSET, 8,	/* 864 */
	HB_P_PUSHSYMNEAR, 129,	/* EOF */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_NOT,
	HB_P_JUMPFALSE, 234, 0,	/* 234 (abs: 00475) */
/* 00244 */ HB_P_LINEOFFSET, 9,	/* 865 */
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 185, 0,	/* INDICE */
	HB_P_ONE,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 3,
	HB_P_PUSHSYMNEAR, 64,	/* SWSET */
	HB_P_PUSHNIL,
	HB_P_PUSHINT, 206, 0,	/* 206 */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_INSTRING,
	HB_P_JUMPFALSE, 199, 0,	/* 199 (abs: 00465) */
/* 00269 */ HB_P_LINEOFFSET, 10,	/* 866 */
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 185, 0,	/* INDICE */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_POPVARIABLE, 186, 0,	/* CSTRING */
/* 00297 */ HB_P_LINEOFFSET, 11,	/* 867 */
	HB_P_PUSHVARIABLE, 186, 0,	/* CSTRING */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'0', '3', 0, 
	HB_P_PUSHSYMNEAR, 187,	/* UPPER */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 188, 0,	/* UNIDAD */
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSTRSHORT, 9,	/* 9 */
	'U', 'N', '-', 'P', 'C', '-', ' ', ' ', 0, 
	HB_P_INSTRING,
	HB_P_JUMPFALSENEAR, 8,	/* 8 (abs: 00335) */
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'1', 0, 
	HB_P_JUMPNEAR, 6,	/* 6 (abs: 00339) */
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'0', 0, 
	HB_P_PLUS,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 186, 0,	/* CSTRING */
/* 00344 */ HB_P_LINEOFFSET, 12,	/* 868 */
	HB_P_PUSHVARIABLE, 186, 0,	/* CSTRING */
	HB_P_PUSHSTRSHORT, 3,	/* 3 */
	'0', '0', 0, 
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 185, 0,	/* INDICE */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 185, 0,	/* INDICE */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_FUNCTIONSHORT, 3,
	HB_P_PLUS,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 186, 0,	/* CSTRING */
/* 00383 */ HB_P_LINEOFFSET, 13,	/* 869 */
	HB_P_PUSHVARIABLE, 186, 0,	/* CSTRING */
	HB_P_PUSHSYMNEAR, 121,	/* STRZERO */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 189, 0,	/* PRECOD */
	HB_P_ZERO,
	HB_P_NOTEQUAL,
	HB_P_JUMPFALSENEAR, 7,	/* 7 (abs: 00403) */
	HB_P_PUSHVARIABLE, 189, 0,	/* PRECOD */
	HB_P_JUMPNEAR, 5,	/* 5 (abs: 00406) */
	HB_P_PUSHVARIABLE, 190, 0,	/* PRECOV */
	HB_P_PUSHBYTE, 100,	/* 100 */
	HB_P_MULT,
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_ZERO,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_PUSHSTRSHORT, 4,	/* 4 */
	'0', '0', '0', 0, 
	HB_P_PLUS,
	HB_P_PUSHVARIABLE, 111, 0,	/* DESCRI */
	HB_P_LEFT, 20, 0,	/* 20 */
	HB_P_PLUS,
	HB_P_PLUS,
	HB_P_POPVARIABLE, 186, 0,	/* CSTRING */
/* 00432 */ HB_P_LINEOFFSET, 14,	/* 870 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHVARIABLE, 186, 0,	/* CSTRING */
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	13, 0, 
	HB_P_PLUS,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	10, 0, 
	HB_P_PLUS,
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 191,	/* PROW */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_PUSHSYMNEAR, 192,	/* PCOL */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_DOSHORT, 4,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00465) */
/* 00465 */ HB_P_LINEOFFSET, 16,	/* 872 */
	HB_P_PUSHSYMNEAR, 193,	/* DBSKIP */
	HB_P_PUSHNIL,
	HB_P_DOSHORT, 0,
	HB_P_JUMP, 17, 255,	/* -239 (abs: 00233) */
/* 00475 */ HB_P_LINEOFFSET, 18,	/* 874 */
	HB_P_PUSHSYMNEAR, 183,	/* SET */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 20,	/* 20 */
	HB_P_PUSHSTRSHORT, 7,	/* 7 */
	'S', 'C', 'R', 'E', 'E', 'N', 0, 
	HB_P_DOSHORT, 2,
/* 00493 */ HB_P_LINEOFFSET, 19,	/* 875 */
	HB_P_PUSHSYMNEAR, 183,	/* SET */
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHVARIABLE, 184, 0,	/* CPORTA */
	HB_P_DOSHORT, 2,
/* 00505 */ HB_P_LINEOFFSET, 20,	/* 876 */
	HB_P_PUSHSYMNEAR, 141,	/* AVISO */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	'F', 'i', 'm', ' ', 'd', 'a', ' ', 'E', 'x', 'p', 'o', 'r', 't', 'a', 'c', 'a', 'o', ' ', 'd', 'o', ' ', 'P', 'r', 'o', 'd', 'u', 't', 'o', 's', 0, 
	HB_P_TRUE,
	HB_P_DOSHORT, 2,
/* 00545 */ HB_P_LINEOFFSET, 21,	/* 877 */
	HB_P_PUSHSYMNEAR, 4,	/* MENSAGEM */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	' ', 0, 
	HB_P_DOSHORT, 1,
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00558) */
/* 00558 */ HB_P_LINEOFFSET, 23,	/* 879 */
	HB_P_TRUE,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 00563 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( DIGTOLEDO )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 4, 1,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 115, 3,	/* 883 */
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCODAVER */
	HB_P_ONE,
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCODAVER */
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PLUS,
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCODAVER */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PLUS,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_MULT,
	HB_P_POPLOCALNEAR, 3,	/* NNUM1 */
/* 00057 */ HB_P_LINEOFFSET, 1,	/* 884 */
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCODAVER */
	HB_P_PUSHBYTE, 2,	/* 2 */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PUSHSYMNEAR, 125,	/* VAL */
	HB_P_PUSHNIL,
	HB_P_PUSHSYMNEAR, 126,	/* SUBSTR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CCODAVER */
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 3,
	HB_P_FUNCTIONSHORT, 1,
	HB_P_PLUS,
	HB_P_POPLOCALNEAR, 4,	/* NNUM2 */
/* 00092 */ HB_P_LINEOFFSET, 2,	/* 885 */
	HB_P_PUSHLOCALNEAR, 3,	/* NNUM1 */
	HB_P_PUSHLOCALNEAR, 4,	/* NNUM2 */
	HB_P_PLUS,
	HB_P_POPLOCALNEAR, 3,	/* NNUM1 */
/* 00101 */ HB_P_LINEOFFSET, 3,	/* 886 */
	HB_P_PUSHLOCALNEAR, 3,	/* NNUM1 */
	HB_P_ADDINT, 1, 0,	/* 1*/
	HB_P_POPLOCALNEAR, 5,	/* CDEZENA */
/* 00110 */ HB_P_LINEOFFSET, 5,	/* 888 */
	HB_P_PUSHSYMNEAR, 182,	/* STR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 5,	/* CDEZENA */
	HB_P_PUSHBYTE, 5,	/* 5 */
	HB_P_FUNCTIONSHORT, 2,
	HB_P_RIGHT, 1, 0,	/* 1 */
	HB_P_PUSHSTRSHORT, 2,	/* 2 */
	'0', 0, 
	HB_P_EXACTLYEQUAL,
	HB_P_JUMPFALSENEAR, 6,	/* 6 (abs: 00135) */
	HB_P_JUMPNEAR, 13,	/* 13 (abs: 00144) */
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00135) */
/* 00135 */ HB_P_LINEOFFSET, 8,	/* 891 */
	HB_P_PUSHLOCALNEAR, 5,	/* CDEZENA */
	HB_P_INC,
	HB_P_POPLOCALNEAR, 5,	/* CDEZENA */
	HB_P_JUMPNEAR, 224,	/* -32 (abs: 00110) */
/* 00144 */ HB_P_LINEOFFSET, 10,	/* 893 */
	HB_P_PUSHLOCALNEAR, 5,	/* CDEZENA */
	HB_P_PUSHLOCALNEAR, 3,	/* NNUM1 */
	HB_P_MINUS,
	HB_P_POPLOCALNEAR, 2,	/* NDIGIT */
/* 00153 */ HB_P_LINEOFFSET, 11,	/* 894 */
	HB_P_PUSHLOCALNEAR, 2,	/* NDIGIT */
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_EQUAL,
	HB_P_JUMPFALSENEAR, 10,	/* 10 (abs: 00170) */
/* 00162 */ HB_P_LINEOFFSET, 12,	/* 895 */
	HB_P_LOCALNEARSETINT, 2, 0, 0,	/* NDIGIT 0*/
	HB_P_JUMPNEAR, 2,	/* 2 (abs: 00170) */
/* 00170 */ HB_P_LINEOFFSET, 14,	/* 897 */
	HB_P_PUSHSYMNEAR, 182,	/* STR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* NDIGIT */
	HB_P_ONE,
	HB_P_FUNCTIONSHORT, 2,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 00182 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

HB_FUNC( EXPWINLIVROS )
{
   static const BYTE pcode[] =
   {
	HB_P_FRAME, 3, 0,	/* locals, params */
/* 00003 */ HB_P_BASELINE, 134, 3,	/* 902 */
	HB_P_PUSHSYMNEAR, 1,	/* ZOOM */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_ZERO,
	HB_P_PUSHBYTE, 24,	/* 24 */
	HB_P_PUSHBYTE, 78,	/* 78 */
	HB_P_FUNCTIONSHORT, 4,
	HB_P_POPLOCALNEAR, 1,	/* CTELA */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_FUNCTIONSHORT, 0,
	HB_P_POPLOCALNEAR, 2,	/* CCOR */
	HB_P_LOCALNEARSETINT, 3, 0, 0,	/* NOPCAO 0*/
/* 00030 */ HB_P_LINEOFFSET, 2,	/* 904 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 24,	/* 24 */
	'N', 'o', 't', 'a', 's', ' ', 'F', 'i', 's', 'c', 'a', 'i', 's', ' ', 'd', 'e', ' ', 'S', 'a', 'i', 'd', 'a', '?', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 3,	/* 3 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00068 */ HB_P_LINEOFFSET, 3,	/* 905 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	'D', 'e', ':', ' ', '[', ' ', ' ', '/', ' ', ' ', '/', ' ', ' ', ']', ' ', 'a', 't', 130, ' ', '[', ' ', ' ', '/', ' ', ' ', '/', ' ', ' ', ']', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 4,	/* 4 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00112 */ HB_P_LINEOFFSET, 5,	/* 907 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 26,	/* 26 */
	'N', 'o', 't', 'a', 's', ' ', 'F', 'i', 's', 'c', 'a', 'i', 's', ' ', 'd', 'e', ' ', 'E', 'n', 't', 'r', 'a', 'd', 'a', '?', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 6,	/* 6 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00152 */ HB_P_LINEOFFSET, 6,	/* 908 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	'D', 'e', ':', ' ', '[', ' ', ' ', '/', ' ', ' ', '/', ' ', ' ', ']', ' ', 'a', 't', 130, ' ', '[', ' ', ' ', '/', ' ', ' ', '/', ' ', ' ', ']', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 7,	/* 7 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00196 */ HB_P_LINEOFFSET, 8,	/* 910 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 16,	/* 16 */
	'C', 'u', 'p', 'o', 'n', 's', ' ', 'F', 'i', 's', 'c', 'a', 'i', 's', '?', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 9,	/* 9 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00226 */ HB_P_LINEOFFSET, 9,	/* 911 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	'D', 'e', ':', ' ', '[', ' ', ' ', '/', ' ', ' ', '/', ' ', ' ', ']', ' ', 'a', 't', 130, ' ', '[', ' ', ' ', '/', ' ', ' ', '/', ' ', ' ', ']', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 10,	/* 10 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00270 */ HB_P_LINEOFFSET, 11,	/* 913 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 34,	/* 34 */
	'E', 's', 't', 'e', ' ', 'm', 'o', 'd', 'u', 'l', 'o', ' ', 'p', 'e', 'r', 'm', 'i', 't', 'e', ' ', 'a', ' ', 't', 'r', 'a', 'n', 's', 'f', 'e', 'r', 'e', 'n', '-', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 12,	/* 12 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00318 */ HB_P_LINEOFFSET, 12,	/* 914 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 34,	/* 34 */
	'c', 'i', 'a', ' ', 'd', 'e', ' ', 'a', 'r', 'q', 'u', 'i', 'v', 'o', 's', ' ', 'd', 'o', ' ', 'n', 'o', 's', 's', 'o', ' ', ' ', 's', 'i', 's', 't', 'e', 'm', 'a', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 13,	/* 13 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00366 */ HB_P_LINEOFFSET, 13,	/* 915 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 34,	/* 34 */
	'w', 'i', 'n', 'L', 'i', 'v', 'r', 'o', 's', ' ', 'q', 'u', 'e', ' ', 'e', ' ', ' ', 'o', ' ', ' ', 'a', 'p', 'l', 'i', 'c', 'a', 't', 'i', 'v', 'o', ' ', 'd', 'e', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 14,	/* 14 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00414 */ HB_P_LINEOFFSET, 14,	/* 916 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 30,	/* 30 */
	'l', 'i', 'v', 'r', 'o', 's', ' ', 'f', 'i', 's', 'c', 'a', 'i', 's', ' ', 'd', 'a', ' ', 'D', 'a', 't', 'a', 'C', 'e', 'm', 'p', 'r', 'o', '.', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 15,	/* 15 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00458 */ HB_P_LINEOFFSET, 16,	/* 918 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 34,	/* 34 */
	'D', 'e', 's', 'e', 'n', 'v', 'o', 'l', 'v', 'i', 'd', 'o', ' ', 'p', 'o', 'r', ' ', 'V', 'a', 'l', 'm', 'o', 'r', ' ', 'P', '.', ' ', 'F', 'l', 'o', 'r', 'e', 's', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 17,	/* 17 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00506 */ HB_P_LINEOFFSET, 17,	/* 919 */
	HB_P_PUSHSYMNEAR, 151,	/* DEVOUT */
	HB_P_PUSHNIL,
	HB_P_PUSHSTRSHORT, 31,	/* 31 */
	'e', 'm', ' ', '0', '5', '/', '0', '4', '/', '2', '0', '0', '4', '.', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 0, 
	HB_P_PUSHNIL,
	HB_P_PUSHBYTE, 18,	/* 18 */
	HB_P_PUSHBYTE, 45,	/* 45 */
	HB_P_DOSHORT, 4,
/* 00551 */ HB_P_LINEOFFSET, 19,	/* 921 */
	HB_P_PUSHSYMNEAR, 53,	/* INKEY */
	HB_P_PUSHNIL,
	HB_P_ZERO,
	HB_P_DOSHORT, 1,
/* 00559 */ HB_P_LINEOFFSET, 21,	/* 923 */
	HB_P_PUSHSYMNEAR, 18,	/* UNZOOM */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 1,	/* CTELA */
	HB_P_DOSHORT, 1,
/* 00568 */ HB_P_LINEOFFSET, 22,	/* 924 */
	HB_P_PUSHSYMNEAR, 2,	/* SETCOLOR */
	HB_P_PUSHNIL,
	HB_P_PUSHLOCALNEAR, 2,	/* CCOR */
	HB_P_DOSHORT, 1,
/* 00577 */ HB_P_LINEOFFSET, 23,	/* 925 */
	HB_P_PUSHNIL,
	HB_P_RETVALUE,
	HB_P_ENDPROC
/* 00582 */
   };

   hb_vmExecute( pcode, symbols, NULL );
}

