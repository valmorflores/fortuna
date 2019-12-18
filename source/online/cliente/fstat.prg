*/
* Demo montado por Sandro Ricardo R. Freire sandrorrfreire@yahoo.com.br
* Copyright (c) 2003
* c/ Hwgui by Alexander Kresin
*/
#include "windows.ch"
#include "guilib.ch"

STATIC oServer, oTable

memvar cHostName, cUser, cPassWord, cDataBase, cTable, cPath, cLoja

Function Main
Local TelaPrincipal, oBitmap := HBitmap():AddResource("TESTE")
Local oMainWindow, oTrayMenu, oIcon := HIcon():AddResource("ICON_1"),;
     oIcon2:= HIcon():AddResource("ICON_2")
private  nVariavel:= 0, nFlag:= 0
Public cHostName, cUser, cPassWord, cDataBase, cTable, cPath, cLoja 
Public DiretorioDeDados:= "\dev\testes\fortuna\dados"

Private MySql:= .F.

   SET EXCLUSIVE OFF
   SET DELETED ON


   INIT WINDOW TelaPrincipal MAIN TITLE "FStat-Sistema de verificacao de status das tabelas" ;
        AT 200,0 SIZE 500,150 BACKGROUND BITMAP oBitMap


   Executar()
   MENU OF TelaPrincipal
     MENUITEM "&Sair"   ACTION EndWindow()
     MENU TITLE "Ferramentas"
        MENUITEM "&Quantidade de Registros"      ACTION VerQuantidades()
     ENDMENU
   ENDMENU

   ACTIVATE WINDOW TelaPrincipal

   Return Nil


Function ProgressTest
   Local Variavel:=100000, Varinicio:=0

   barra := HProgressBar():NewBox( "Atualizando Dados ...",,,,,10,Variavel )
   Do While Varinicio<Variavel
      ++Varinicio
      barra:Step()
   Enddo
   barra:End()
Return Nil



Function VerQuantidades()
Local nQtd:= 0
Local oRow, cIndice, cDescri, nPrecov, cUnidad, nSaldo_
    Conecta()
    oTable:= oServer:Query( "Select * from cdmprima" )
    IF !oTable:NetErr()
       oTable:DBGoTop()
       nQtd:= 0
       WHILE !oTable:EOF()  
           nQtd:= nQtd + 1
           oRow:= oTable:GetRow( nQtd )
           cIndice:= oRow:FieldGet( 1 )
           cDescri:= oRow:FieldGet( 2 )
           nPrecov:= oRow:FieldGet( 3 )
           cUnidad:= oRow:FieldGet( 4 )
           nSaldo_:= oRow:FieldGet( 5 )
           oTable:Skip()
       ENDDO
    ENDIF

    msginfo( "abrir cdmprima" )
    DBSelectAr( _COD_MPRIMA )
    IF !Used()
       USE "&DiretorioDeDados\CDMPRIMA.DBF" ALIAS MPR SHARED
       msginfo( "aberto" )
    ENDIF
    MsgInfo( "Numero de Registros do servidor: " + StrZero( nQtd, 4, 0 ) + "" + CHR( 13 ) + CHR( 10 ) +;
             "Numero de Registros da base local: " + StrZero( MPR->( LASTREC() ), 4, 0 ) )

    Desconecta()
Return Nil

Function Desconecta()
   oTable:Destroy()
   oServer:Destroy()
   oServer:= Nil
   Return Nil


Function Executar

    Local aIni, aSect, cSection, cKey, nRow
    
    Local cFile
    Local cTemp:= ''


    //msgInfo( "ler config.ini" )
    Cls
    aIni:= HB_ReadIni( 'gConfig.ini' )
    //msgInfo( "lido o  config.ini" )
    If Empty( aIni )
        msginfo( 'Arquivo de Configuracoes Vazio !!!' )
	Quit
    Else
    //msgInfo( time()  + "lido o  config.ini" )
//@ 03, 00 Say time()+' lido: '
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


// Ler o arquivo INI
RDIni( "gConfig.ini" )

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

    //msgInfo( time()  + "teste de file pdv_bak.dbf" )



Return Nil


Function Conecta
STATIC nSegundos

 IF nSegundos == Nil
    nSegundos:= SECONDS()
 ENDIF
 IF !MySql
    oServer:= TMySQLServer():New( cHostName, cUser, cPassWord )
    If oServer:NetErr()
        IF SECONDS() > ( nSegundos + 10 ) 
           swlog( oServer:Error() )
           nSegundos:= SECONDS()
        ENDIF
	MySql:= .F.
    Else
        //msginfo( "?" +  time()+': conectou servidor: '+cHostName )
        oServer:SelectDB( cDataBase )
	If oServer:NetErr()
	    MySql:= .F.
            swlog( oServer:Error() )
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
                    swlog( oServer:Error() )
		else
		    MySql:= .T.
                    //msginfo( "?" + time()+': criado: '+cTable )
		EndIf
	    Else
		MySql:= .T.
                //msginfo( "?" + time()+': existe: '+cTable )
	    EndIf
	EndIf
    EndIf
 ENDIF
 if MySQL
    swlog( "Conectado ao servidor" )
 endif
Return Nil


Function swlog( cMsg )
  Local Comando:= DTOC( DATE() ) + "-" + TIME() + ": " +  cMsg + Chr( 13 ) + Chr( 10 )
    hFile:= Fopen( "flinelog.txt", 2 + 64 )  // READWRITE + SHARED
    IF !( FError() == 0 )
       msginfo( "Impossivel abrir flinelog.txt (DOS error:" + Str( FError() ) + ")" )
    ELSE
       Fseek( hFile, 0, 2 )
       FWrite( hFile, Comando, Len( Comando ) )
       FClose( hFile )
    ENDIF
    Return Nil


Function AtualizaMeuSaldo()
Local oTabela, lFalhaAoEnviar:= .T.
Local cIndice, cDescri, cUnidad, nPrecov, nSaldo_
Local nProduto:= 0
/*

  TEMPORTIZADOR para nao realizar a tarefa
  exaustivamente, dando um tempo ao servidor,
  mantendo o trafego em um limite aceitavel
  evitando assim algum prejuizo para a aplicacao
  client ou servidor.

                         By Valmor em 05/11/2003

*/
Static nSegundos


   IF nSegundos == Nil
      nSegundos:= SECONDS()
   ELSE
      IF ( nSegundos + 10 ) < SECONDS()
         nSegundos:= SECONDS()
      ELSE 
         // Se ainda nao chegou ao tempo estimado em segundos
         // sai da rotina sem efetuar nada retornando a aplicacao
         Return .F.
      ENDIF
   ENDIF


  IF MySQL

     DBSelectAr( _COD_MPRIMA )
     IF !Used()
        SWLOG( "DEBUG: abrir "+ DiretorioDeDados + "\cdmprima.dbf" )
        USE "&DiretorioDeDados\CDMPRIMA.DBF" ALIAS MPR SHARED
        IF .NOT. File( DiretorioDeDados + "\MPRIND01.NTX" )
            SWLog( "Falha na abertura dos indices. Favor reindexar a base de dados." )
            quit
        ELSE
           SET INDEX TO "&DiretorioDeDados\MPRIND01.NTX",;
                        "&DiretorioDeDados\MPRIND02.NTX",;
                        "&DiretorioDeDados\MPRIND03.NTX",;
                        "&DiretorioDeDados\MPRIND04.NTX",;
                        "&DiretorioDeDados\MPRIND05.NTX"
           DBSetOrder( 1 )
        ENDIF
        SWLOG( "DEBUG: abertura de cdmprima.dbf realizada com sucesso " )
     ENDIF

     // [ CDMPRIMA ]
//     SWLOG( "DEBUG: abrir cdmprima do servidor" )
     oTable:= oServer:Query( "Select * from cdmprima" )
     IF oTable:NetErr()
         MySql:= .F.
         swlog( oTable:Error() )
         lFalhaAoEnviar:= .T.
     ELSE
//          SWLOG( "DEBUG: buscando informacoes na tabela" )
          oTable:DBGoTop()

          nRow:= 0
          WHILE !oTable:EOF()
    
              nRow:= nRow + 1
              cIndice:= ""
              oRow:= oTable:GetRow( nRow )
              cIndice:= oRow:FieldGet( 1 )
              cDescri:= oRow:FieldGet( 2 )
              nPrecov:= oRow:FieldGet( 3 )
              cUnidad:= oRow:FieldGet( 4 )
              nSaldo_:= oRow:FieldGet( 5 )
//              SWLog( "DEBUG: " + cIndice + " " + cDescri )

              IF !( alltrim( cIndice ) == "" )
                 MPR->( DBSetOrder( 1 ) )
                 IF MPR->( DBSeek( cIndice ) )
//                    SWLog( "DEBUG: Encontrou " + cIndice + " " + cDescri )
                    IF ( MPR->SALDO_ <> nSaldo_ ) .OR.;
                       ( !( ALLTRIM( MPR->DESCRI ) == ALLTRIM( cDescri ) ) ) .OR.;
                       ( !( MPR->UNIDAD == cUnidad ) ) .OR.;
                       ( MPR->PRECOV <> nPrecoV )
//                       SWLog( "DEBUG: Bloqueio " + cIndice + " " + cDescri )
                       IF MPR->( RLock() )
//                          SWLog( "DEBUG: Incremento " )
                          nProduto:= nProduto + 1
//                          SWLog( "DEBUG: Gravacao  " )
                          Replace MPR->DESCRI with cDescri,;
                                  MPR->UNIDAD With cUnidad,;
                                  MPR->SALDO_ With nSaldo_,;
                                  MPR->PRECOV With nPrecov
//                          SWLog( "DEBUG: Gravacao realizada com sucesso" )
                       ELSE
//                          SWLog( "DEBUG: Falhou" )
                          lFalhaAoEnviar:= .T.
                       ENDIF
                    ENDIF
                 ELSE
                    SWLog( "Adicionando um novo produto " + cIndice + " na tabela de produtos local..." )
                    MPR->( DBAppend() )
                    nProduto:= nProduto + 1
                    Replace MPR->INDICE With cIndice,;
                            mpr->CODIGO With cIndice,;
                            MPR->CODRED With SubStr( cIndice, 4, 4 ),;
                            MPR->DESCRI with cDescri,;
                            MPR->UNIDAD With cUnidad,;
                            MPR->SALDO_ With nSaldo_,;
                            MPR->PRECOV With nPrecov
                    SWLog( ">" + cDescri )
                 ENDIF
              ENDIF
              MPR->( dbUnlockAll() )
              MPR->( DBCommitAll() )
              oTable:Skip()
          ENDDO
     ENDIF
  ENDIF
  IF nProduto > 0
     SWLog( "Atualizadas informacoes de " + Alltrim( Str( nProduto ) ) + " produto(s)." )
  ENDIF
  // DBSelectAr( _COD_MPRIMA )
  // IF USED()
  //    DBCloseAll()
  // ENDIF
  Return ( ! lFalhaAoEnviar )

