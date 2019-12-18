#include 'inkey.ch'
STATIC oServer
STATIC oTable

Function Main

    Local aIni, aSect, cSection, cKey, nRow
    
    Local cFile
    Local cTemp:= ''
    MySql:= .F.

    Cls
    aIni:= HB_ReadIni( 'gConfig.ini' )
    If Empty( aIni )
	Alert( 'Arquivo de Configuracoes Vazio !!!' )
	Quit
    Else
@ 03, 00 Say time()+' lido: '
	For Each cSection in aIni:Keys
	    aSect:= aIni[ cSection ]

//
// Carregamento de parametros 
//
cHostName := "200.203.42.30"
cUser := "root"
cPassWord := "197610"
cDataBase := "agendakylix"
cTable := "telefones"
cPath := "\dev\source\pdv3\"   // VALMOR MUDOU
cLoja := "1"

//            For Each cKey in aSect:Keys
//                &(cKey) := aSect[ cKey ]         
//? time()+' '+cKey
//? time()+' '+&cKey 
//            Next
	Next
    EndIf
    cLoja:= StrZero( Val( cLoja ), 3 )
    cPath:= AllTrim( cPath )
    cHostName:= AllTrim( cHostName )
    cUser:= AllTrim( cUser )
    cDataBase:= AllTrim( cDataBase )
    cTable:= AllTrim( cTable )+'_'+cLoja
    cPassWord:= AllTrim( cPassWord )
    cPdv_Ok_Ok:= cPath+'PDV_OK.OK'
    cPdv_Ok_Dbf:= cPath+'PDV_OK.DBF' 
    cPdv_Bak_Dbf:= cPath+'pdv_bak.dbf'
    
    If !File( cPdv_Bak_Dbf )
    	DBCreate( cPdv_Bak_Dbf, { ;
	{ 'CODLAN', 'N', 03, 00 },;
	{ 'INDICE', 'C', 12, 00 },;
	{ 'CODFAB', 'C', 13, 00 },;
	{ 'DESCRI', 'C', 45, 00 },;
	{ 'UNIDAD', 'C', 02, 00 },;
	{ 'PRECOV', 'N', 16, 02 },;
	{ 'PRECOT', 'N', 16, 02 },;
	{ 'QUANT_', 'N', 16, 03 },;
	{ 'ST____', 'C', 03, 00 },;
	{ 'STATUS', 'C', 01, 00 },;
	{ 'DATA__', 'D', 08, 00 },;
	{ 'HORA__', 'C', 08, 00 },;
	{ 'INFO__', 'C', 80, 00 },;
	{ 'PCPCLA', 'N', 03, 00 },;
	{ 'PCPTAM', 'N', 02, 00 },;
	{ 'PCPCOR', 'N', 03, 00 },;
	{ 'NUMCUP', 'N', 09, 00 },;
	{ 'ENVIAD', 'C', 01, 00 } } )
    EndIf    

    While .T.
        // VALMOR
        If File( "FINALIZA.OK" )
           EXIT
        ENDIF
        If File( cPdv_Ok_Ok )
	    Use ( cPdv_Ok_Dbf ) Alias pdv_ok New
	    Use ( cPdv_Bak_Dbf ) Alias pdv_bak New
	    Envia()
	    Sele pdv_ok
	    Use
	    Sele pdv_bak
	    Use
	    Ferase( cPdv_Ok_Dbf )
	    Ferase( cPdv_Ok_Ok )
 ? time()+': abriu '+cPdv_Ok_Dbf
else
 @ 24, 00 Say time()+': nao existe '+cPdv_Ok_Ok
	EndIf
	Envia_Bak()
inkey( .1 )
if lastkey()==27
 exit
endif	
    EndDo    

Return Nil


Function Envia

    If !MySql
        //? "valmor: Conectando ao mysql, aguarde..."
        //inkey(0)
	Conecta()
    EndIf
    If MySql
	pdv_ok->( DBGoTop() )
	While !pdv_ok->( Eof() )
            //? "valmor: Acessando a tabela, aguarde..."
            //inkey(0)
	    oTable:= oServer:Query( "Select * from "+cTable )
	    If oTable:NetErr()
		MySql:= .F.
		Alert( oTable:Error() )
else
 ? time()+': leu toda tabela: '+cTable
	    EndIf    
	    If pdv_ok->ENVIAD=='S'
		pdv_ok->( DBSkip() )
		Loop
	    EndIf
            //? "valmor: Gravando informacoes, aguarde..."
            //inkey(0)
	    cTemp:= [INSERT INTO ]+cTable+[ ( SEQUEN,]+;
		[ CODLAN, INDICE, CODFAB, DESCRI, UNIDAD, PRECOV, PRECOT,]+;
		[ QUANT_, ST____, STATUS, DATA__, HORA__, INFO__, PCPCLA,]+;
		[ PCPTAM, PCPCOR, NUMCUP, ENVIAD ) VALUES ( ]+;
		[]+AllTrim( Str( oTable:LastRec()+1 ) )+[, ]+;
		[]+AllTrim( Str( pdv_ok->CODLAN ) )+[, ]+;
		["]+AllTrim( pdv_ok->INDICE )+[", ]+;
		["]+AllTrim( pdv_ok->CODFAB )+[", ]+;
		["]+AllTrim( pdv_ok->DESCRI )+[", ]+;
		["]+AllTrim( pdv_ok->UNIDAD )+[", ]+;
		[]+AllTrim( Str( pdv_ok->PRECOV ) )+[, ]+;
		[]+AllTrim( Str( pdv_ok->PRECOT ) )+[, ]+;
		[]+AllTrim( Str( pdv_ok->QUANT_ ) )+[, ]+;
		["]+AllTrim( pdv_ok->ST____ )+[", ]+;
		["]+AllTrim( pdv_ok->STATUS )+[", ]+;
		["]+AllTrim( Str( Year( pdv_ok->DATA__ ) ) )+[/]+;
		[]+AllTrim( Str( Month( pdv_ok->DATA__ ) ) )+[/]+;
		[]+AllTrim( Str( Day( pdv_ok->DATA__ ) ) )+[", ]+;
		["]+AllTrim( pdv_ok->HORA__ )+[", ]+;
		["]+AllTrim( pdv_ok->INFO__ )+[", ]+;
		[]+AllTrim( Str( pdv_ok->PCPCLA ) )+[, ]+;
		[]+AllTrim( Str( pdv_ok->PCPTAM ) )+[, ]+;
		[]+AllTrim( Str( pdv_ok->PCPCOR ) )+[, ]+;
		[]+AllTrim( Str( pdv_ok->NUMCUP ) )+[, 'N' ) ]
? time()+': '+cTemp
	    oTable:= oServer:Query( cTemp )
	    If oTable:NetErr()
		Alert( oTable:Error() )
	    Else
		Repl pdv_ok->ENVIAD With 'S'
? time()+': registro ok gravado em '+cTable
	    EndIf
	    pdv_ok->( DBSkip() )
	EndDo
    Else
	While !pdv_ok->( Eof() )
	    Sele pdv_bak
	    Appe Blan
	    Repl pdv_bak->CODLAN With pdv_ok->CODLAN
	    Repl pdv_bak->INDICE With pdv_ok->INDICE
	    Repl pdv_bak->CODFAB With pdv_ok->CODFAB
	    Repl pdv_bak->DESCRI With pdv_ok->DESCRI
	    Repl pdv_bak->UNIDAD With pdv_ok->UNIDAD
	    Repl pdv_bak->PRECOV With pdv_ok->PRECOV
	    Repl pdv_bak->PRECOT With pdv_ok->PRECOT
	    Repl pdv_bak->QUANT_ With pdv_ok->QUANT_
	    Repl pdv_bak->ST____ With pdv_ok->ST____
	    Repl pdv_bak->STATUS With pdv_ok->STATUS
	    Repl pdv_bak->DATA__ With pdv_ok->DATA__
	    Repl pdv_bak->HORA__ With pdv_ok->HORA__
	    Repl pdv_bak->INFO__ With pdv_ok->INFO__
	    Repl pdv_bak->PCPCLA With pdv_ok->PCPCLA
	    Repl pdv_bak->PCPTAM With pdv_ok->PCPTAM
	    Repl pdv_bak->PCPCOR With pdv_ok->PCPCOR
	    Repl pdv_bak->NUMCUP With pdv_ok->NUMCUP
	    pdv_ok->( DBSkip() )	        
	EndDo
    EndIf
            
Return Nil


Function Envia_Bak

    If !MySql
	Conecta()
    EndIf
    If MySql
	Use ( cPdv_Bak_Dbf ) Alias pdv_bak New	
	pdv_bak->( DBGoTop() )
	While !pdv_bak->( Eof() )
	    oTable:= oServer:Query( "Select * from "+cTable )
	    If oTable:NetErr()
		MySql:= .F.
		Alert( oTable:Error() )
else
 ? time()+': leu toda tabela: '+cTable
	    EndIf    
            If pdv_bak->ENVIAD=='S'
		pdv_bak->( DBSkip() )
		Loop
	    EndIf
	    cTemp:= [INSERT INTO ]+cTable+[ ( SEQUEN,]+;
		[ CODLAN, INDICE, CODFAB, DESCRI, UNIDAD, PRECOV, PRECOT,]+;
		[ QUANT_, ST____, STATUS, DATA__, HORA__, INFO__, PCPCLA,]+;
		[ PCPTAM, PCPCOR, NUMCUP, ENVIAD ) VALUES ( ]+;
		[]+AllTrim( Str( oTable:LastRec()+1 ) )+[, ]+;
		[]+AllTrim( Str( pdv_bak->CODLAN ) )+[, ]+;
		["]+AllTrim( pdv_bak->INDICE )+[", ]+;
		["]+AllTrim( pdv_bak->CODFAB )+[", ]+;
		["]+AllTrim( pdv_bak->DESCRI )+[", ]+;
		["]+AllTrim( pdv_bak->UNIDAD )+[", ]+;
		[]+AllTrim( Str( pdv_bak->PRECOV ) )+[, ]+;
		[]+AllTrim( Str( pdv_bak->PRECOT ) )+[, ]+;
		[]+AllTrim( Str( pdv_bak->QUANT_ ) )+[, ]+;
		["]+AllTrim( pdv_bak->ST____ )+[", ]+;
		["]+AllTrim( pdv_bak->STATUS )+[", ]+;
		["]+AllTrim( Str( Year( pdv_bak->DATA__ ) ) )+[/]+;
		[]+AllTrim( Str( Month( pdv_bak->DATA__ ) ) )+[/]+;
		[]+AllTrim( Str( Day( pdv_bak->DATA__ ) ) )+[", ]+;
		["]+AllTrim( pdv_bak->HORA__ )+[", ]+;
		["]+AllTrim( pdv_bak->INFO__ )+[", ]+;
		[]+AllTrim( Str( pdv_bak->PCPCLA ) )+[, ]+;
		[]+AllTrim( Str( pdv_bak->PCPTAM ) )+[, ]+;
		[]+AllTrim( Str( pdv_bak->PCPCOR ) )+[, ]+;
		[]+AllTrim( Str( pdv_bak->NUMCUP ) )+[, 'N' ) ]
? time()+': '+cTemp 
	    oTable:= oServer:Query( cTemp )
	    If oTable:NetErr()
		Alert( oTable:Error() )
		MySql:= .F.
		Exit
	    Else
		Repl pdv_bak->ENVIAD With 'S'
? time()+': registro bak gravado em '+cTable
	    EndIf
	    pdv_bak->( DBSkip() )
	EndDo
	Use
    EndIf
    
Return Nil


Function Conecta
      
    oServer:= TMySQLServer():New( cHostName, cUser, cPassWord )
    If oServer:NetErr()
	Alert( oServer:Error() )
	MySql:= .F.
    Else
? time()+': conectou servidor: '+cHostName 
        oServer:SelectDB( cDataBase )
	If oServer:NetErr()
	    MySql:= .F.
	    Alert( oServer:Error() )
	Else
	    If Ascan( oServer:ListTables(), cTable ) == 0
    	        oServer:CreateTable( cTable, { ;
		{ 'SEQUEN', 'N', 10, 00 },;
		{ 'CODLAN', 'N', 03, 00 },;
		{ 'INDICE', 'C', 12, 00 },;
		{ 'CODFAB', 'C', 13, 00 },;
		{ 'DESCRI', 'C', 45, 00 },;
		{ 'UNIDAD', 'C', 02, 00 },;
	    	{ 'PRECOV', 'N', 16, 02 },;
		{ 'PRECOT', 'N', 16, 02 },;
		{ 'QUANT_', 'N', 16, 03 },;
	    	{ 'ST____', 'C', 03, 00 },;
		{ 'STATUS', 'C', 01, 00 },;
		{ 'DATA__', 'D', 08, 00 },;
		{ 'HORA__', 'C', 08, 00 },;
		{ 'INFO__', 'C', 80, 00 },;
		{ 'PCPCLA', 'N', 03, 00 },;
		{ 'PCPTAM', 'N', 02, 00 },;
		{ 'PCPCOR', 'N', 03, 00 },;
		{ 'NUMCUP', 'N', 09, 00 },;
    		{ 'ENVIAD', 'C', 01, 00 } }, 'SEQUEN', 'SEQUEN' )
		If oServer:NetErr()
		    MySql:= .F.
		    Alert( oServer:Error() )
		else
		    MySql:= .T.
? time()+': criado: '+cTable
		EndIf
	    Else
		MySql:= .T.
? time()+': exsite: '+cTable
	    EndIf
	EndIf
    EndIf
    
Return Nil


Function Nada    
    
    oServer:CreateDB( cDataBase )
    If oServer:NetErr()
	Alert( oServer:Error() )
	Quit
    Else
	Alert( 'Criou DB' )
    EndIf
    
    oServer:SelectDB( cDataBase )
    If oServer:NetErr()
	Alert( oServer:Error() )
	Quit
    Else
	Alert( 'Ok 2' )
    EndIf
    
    oTable:= oServer:Query( "SELECT * FROM "+cTable )
    If oTable:NetErr()
	Alert( oTable:Error() )
	Quit
    Else
	Alert( 'Ok 3' )
    EndIf
    
    oServer:CreateIndex( "codigo", "nome", { "agenda_id", "agenda_nome" } )
    
//    cTemp:="INSERT INTO "+cTable+" (' ) VALUES ( )"
//    +' ( "agenda_id", "agenda_nome", "agenda_tel" ) VALUES ( 2, "1gelson", "91071315" )' )

    cTemp:= [INSERT INTO ]+cTable+[ ( agenda_id, agenda_nome, agenda_tel ) VALUES ( 2, "gelson", "91071315" )]
    Alert( cTemp )
    oTable:= oServer:Query( cTemp )
    If oTable:NetErr()
	Alert( oTable:Error() )
//	Quit
    Else
	Alert( 'Ok 4' )
    EndIf
    
    oTable:= oServer:Query( "Select * from "+cTable )
    If oTable:NetErr()
	Alert( oTable:Error() )
//	Quit
    Else
	Alert( 'Ok 5' )
    EndIf
    
    oTable:= oServer:Query( "Select * from "+cTable )
    If oTable:NetErr()
	Alert( oTable:Error() )
//	Quit
    Else
	Alert( 'Ok 5' )
    EndIf
    
alert( 'antes' )
i:= 0
    while !oTable:eof()
	i++
	oRow:= oTable:GetRow( i )
	Alert( oRow:FieldGet( 1 ) )
        oTable:skip( 1 )
    enddo
alert( 'depois' )    
    
*    DefProc( ob, 5, cTable )
/*    ob:= TBrowseSQL():New( 1, 1, 20, 79, oServer, oTable, 'nome' )
    ob:SetKey( 22, { | ob, nKey | DefProc( ob, nKey, cTable ) } )
    
    While .T.
	ob:ForceStable()
	If ( ob:applyKey( Inkey( 0 ) ) == -1 )
	    Exit
	EndIf
    EndDo
*/    
    oTable:Destroy()
    oServer:Destroy()
    
Return Nil


Function DefProc( ob, k, cTable )

    Local op:= ' ' 
    Local oRecord
    Local afDatas:= Array( 3 )
    Local cScreen:= SaveScreen()
    Local n
    
    Cls
    SetColor( 'w/b,w/b+,w/r,b/w' )
    DispBox( 0, 0, MaxRow(), MaxCol() )
//    Afill( afDatas[ 1 ], Space( 30 
    Aadd( afDatas, { 0, Space( 20 ), Space( 10 ) } )
//    afDatas[ 1 ]:= 0
//    afDatas[ 2 ]:= Space( 20 )
//    afDatas[ 3 ]:= Space( 10 )
    
    @ 02, 02 Say 'Codigo ' Get afDatas[ 1 ]
    @ 03, 02 Say 'Nome   ' Get afDatas[ 2 ]
    @ 04, 02 Say 'Fone   ' Get afDatas[ 3 ]
    Read
    
    @ 23, 02 Say 'Salva (S/N)? ' Get op Pict "!"
    Read
    If op=='S'
	oRecord:= ob:oQuery:GetBlankRow()
	For n:= 1 to 3
	    oRecord:FieldPut( n, afDatas[ n ] )
	Next
	oTable:Append( oRecord )
	If oTable:NetErr()
	    Alert( oTable:Error() )
	EndIf	
    EndIf
    RestScreen( ,,,, cScreen )
    oTable:Refresh()
    ob:RefreshAll()
    
Return Nil

FUNC maii
    oServer := TMySQLServer():New( AllTrim( cHostName ), AllTrim( cUser ), AllTrim( cPassWord ) )
    IF oServer:NetErr()
       ? oServer:Error()
       QUIT
    ENDIF
    oServer:SelectDB( cDataBase )
    IF oServer:NetErr()
       ? oServer:Error()
       QUIT
    ENDIF
    
    If Ascan(oServer:ListTables(), cTable) == 0
       oServer:CreateTable( cTable, { ;
       { "fname", "C", 30, 0 }, ;
       { "lname", "C", 30, 0 }, ;
       { "phone", "C", 30, 0 }, ;
       { "fax", "C", 30, 0 }, ;
       { "address", "C", 30, 0 }, ;
       { "city", "C", 30, 0 }, ;
       { "zip", "C", 30, 0 }, ;
       { "notes", "C", 50, 0 } }, 'lname', 'lname' )
    endif

    oTable := oServer:Query( "SELECT * FROM " + cTable )
    IF oTable:NetErr()
       Alert( oTable:Error() )
       QUIT
    ENDIF

    oServer:Createindex( "luiz", "luizx", { "fname", "zip" }, )

    ob := TBrowseSQL():new( 1, 1, 20, 79, oserver, otable, 'luizx' )
    ob:SetKey( 22, { | ob, nkey | Defproc( ob, nKey, ctable ) } )

    WHILE .t.
       oB:ForceStable()
       IF ( oB:applykey( Inkey( 0 ) ) == - 1 )
          EXIT
       ENDIF
    ENDDO

    oTable:Destroy()

    oServer:Destroy()

RETURN nil
