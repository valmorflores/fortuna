/*

  FLINE.prg
  Fortuna (online)

  Sistema para integraá∆o de lojas tornando-as online por intermÇdio da
  internet de velocidade (ADSL ou cabo).

  Este programa fica hospedado e operante no computador cliente (Loja-Filial)
  da rede de lojas e transporta as operaá‰es para uma base de dados
  no formato MYSQL situada em algum provedor ou local previamente determinado e
  com ip fixo.

  As informacoes de conexao estao contidas no arquivo gConfig.ini

  Gelson Ingracio
  Valmor Pereira Flores

  ====Data====Versao===Programador===========================================
  11/06/04 . 0.01.04 . VALMOR      Texto de aviso de atualizacao
  13/05/04 . 0.01.03 . VALMOR      Acrescentando o teste ( TRIM( MPR->CODFAB )
                                   <> TRIM( cCodFab ) para a rotina de
                                   atualizacao de informacoes dos produtos

  10/05/04 . 0.01.02 . GELSON      Upload FLINE 0.01.02 para LOJA1

  10/05/04 . 0.01.02 . VALMOR      Ajuste para o saldo n∆o ser implantado a n∆o
                                   ser que esteja em uma das lojas

  10/05/04 . 0.01.02 . VALMOR      Criacao da importacao do campo CODFAB para
                                   a base de dados local.

  04/05/04 . 0.01.01 . VALMOR      Implementacao na loja.
  ---------------------------------------------------------------------------

*/

/*

  INSTRUCOES P/ COMPILACAO
        BLD fline

*/
#define VERSAO   "0.01.04"

#include 'inkey.ch'

#include "windows.ch"
#include "guilib.ch"

#include "\dev\source\pdv3\vpf.ch" 


STATIC oServer
STATIC oTable

memvar cHostName, cUser, cPassWord, cDataBase, cTable, cPath, cLoja


Function Main
Local nSegundos
Local oMainWindow, oTrayMenu, oIcon := HIcon():AddResource("ICON_1"),;
     oIcon2:= HIcon():AddResource("ICON_2")
private  nVariavel:= 0, nFlag:= 0
Public cHostName, cUser, cPassWord, cDataBase, cTable, cPath, cLoja 
Public DiretorioDeDados:= "\dev\testes\fortuna\dados"
public MySql:= .F.


   SET EXCLUSIVE OFF
   SET DELETED ON
   SET DATE BRITISH

   // INICIO DA APLICACAO
   INIT WINDOW oMainWindow MAIN TITLE "f-line"

   WHILE .T.

        // POSICIONA NA BARRA TRAY DO WINDOWS
        oMainWindow:InitTray( oIcon,,oTrayMenu, "Fortuna (online)" )

        // INICIO DA APLICACAO F-LINE
        swlog( "F-line versao " + VERSAO )
        swlog( "Inicio =====================================================" )
        nSegundos:= SECONDS()

        WHILE .T.
             IF SECONDS() < 1000
                nSegundos:= SECONDS()
             ELSEIF ( SECONDS() > ( nSegundos + ( 60 * 10 ) ) ) 
                swlog( "f-line Ativo e aguardando informacoes." )
                nSegundos:= SECONDS()
             ENDIF
             Conecta()
             Executar()
             AtualizaMeuSaldo()
             Desconecta()
             IF FILE( "C:\FINALIZA.OK" )
                !DEL C:\FINALIZA.OK
                FErase( "C:\FINALIZA.OK" )
                quit
             ENDIF
        ENDDO

        ACTIVATE WINDOW oMainWindow NOSHOW
        oTrayMenu:End()

   ENDDO
   Return Nil


Function Desconecta()
   if oServer <> nil
      oServer:Destroy()
      oServer:= Nil
   endif
   // swlog( "Desconectado do servidor" )
   MySql:= .F.
   Return Nil


Function Executar

    Local nVezes:= 0
    Local aIni, aSect, cSection, cKey, nRow
    
    Local cFile
    Local cTemp:= ''

    Cls
    aIni:= HB_ReadIni( 'gConfig.ini' )
    If Empty( aIni )
        msginfo( 'Arquivo de Configuracoes Vazio !!!' )
	Quit
    Else
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

    IF !File( cPdv_Bak_Dbf )
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
    ENDIF    

    WHILE ( ++nVezes < 50 )

        If File( "C:\FINALIZA.OK" )
           swlog( "Finalizado" )
           EXIT
        ENDIF
        
        If File( cPdv_Ok_Ok )

            // msgInfo( time()  + "use pdv ok " )
	    Use ( cPdv_Ok_Dbf ) Alias pdv_ok New

            // Valmor: Limpar o pdv_bak se possivel abri-lo em modo exclusivo
            Use ( cPdv_Bak_Dbf ) Alias pdv_bak Exclusive New
            dbselectar( "pdv_bak" )
            if used()
               swlog( "Executando Pack em pdv_bak.dbf" )
               pack
               swlog( "Total de " + alltrim( str( lastrec() ) ) + " registro(s) pendente(s) no pdv_bak.dbf..." )
               dbcloseArea()
            endif           

            // Abrir o pdv_bak em modo compartilhado
            //Use ( cPdv_Bak_Dbf ) Alias pdv_bak New

	    Envia()

            DBSelectAr( "pdv_ok" )
            IF USED()
               DBCloseArea()
            ENDIF

            Ferase( cPdv_Ok_Dbf )
//            swlog( "DEBUG: Fechado" )

	    Ferase( cPdv_Ok_Ok )
//            swlog( "DEBUG: Fechado" )

        else
            //msginfo( "nao existe" )
            //@ 24, 00 Say time()+': nao existe '+cPdv_Ok_Ok
	EndIf

        //swlog( "DEBUG: Envia BAK" )
	Envia_Bak()
       
    EndDo    

Return Nil


Function Envia
    Local lFalhaAoEnviar:= .T.
    Local nReg:= 0
    If !MySql
        //? "valmor: Conectando ao mysql, aguarde..."
        //inkey(0)
        //Conecta()
    EndIf
    If MySql
	pdv_ok->( DBGoTop() )
        swlog( "Gravando bloco de informacoes iniciadas no cupom nß" + StrZero( PDV_OK->NUMCUP, 09, 0 ) )
        While !pdv_ok->( Eof() )
            //? "valmor: Acessando a tabela, aguarde..."
            //inkey(0)
	    oTable:= oServer:Query( "Select * from "+cTable )
	    If oTable:NetErr()
		MySql:= .F.
                swlog( oTable:Error() )
                lFalhaAoEnviar:= .T.
                EXIT
            else
               If pdv_ok->ENVIAD=='S'
                   pdv_ok->( DBSkip() )
                   Loop
               EndIf
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

               // valmor: Gravando informacoes do produto
               // valmor: Informacao apenas para depuracao de programa
               swlog( "Gravando o produto " + pdv_ok->INDICE )

               oTable:= oServer:Query( cTemp )
               If oTable:NetErr()
                  swlog( oTable:Error() )
                  lFalhaAoEnviar:= .T.
                  EXIT
               Else
                   if pdv_ok->( rlock() )
                      Repl pdv_ok->ENVIAD With 'S'
                   else
                      swlog( "Impossivel marcar registro como enviado..." )
                   endif
                   lFalhaAoEnviar:= .F.
                   nReg:= nReg + 1
               EndIf
               oTable:Destroy()
            ENDIF
            pdv_ok->( DBSkip() )           
        EndDo
        swlog( "Termino da gravacao de bloco com " + alltrim( Str( nReg, 12, 0 ) ) + " registro(s)." )
    Endif

    IF lFalhaAoEnviar
       swlog( "Servidor ocupado ou fora do ar, armazenando em PDV_BAK.DBF" )
       Use ( cPdv_Bak_Dbf ) Alias pdv_bak Exclusive New 
       if !Used()
           swlog( "Falha ao tentar armazenar PDV_BAK.DBF" )
       else
//          swlog( "DEBUG: Transferinfo informacoes para  PDV_BAK.DBF" )
          While !pdv_ok->( Eof() )
//            swlog( "DEBUG: Selecionando PDV_BAK" )
            DBSelectAr( "pdv_bak" )
//            swlog( "DEBUG: Selecionando PDV_BAK" )
            IF !( pdv_ok->ENVIAD == "S" )
//               swlog( "DEBUG: Novo registro em PDV_BAK" )
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
            ENDIF
            if pdv_ok->( RLOCK() )
//               swlog( "DEBUG: ENVIAD=S em pdv_ok" )
               Repl pdv_ok->ENVIAD With 'S'
            endif
//            swlog( "DEBUG: skip em pdv_ok" )
            pdv_ok->( DBSkip() )
          EndDo
//          swlog( "DEBUG: PDVBAK" )
          DBSelectAr( "pdv_bak" )
//          swlog( "DEBUG: fechando area em pdv_bak" )
          DBCloseArea()
       Endif
    EndIf
//    swlog( "DEBUG: saindo da rotina Envia" )
            
Return Nil


Function Envia_Bak
   LOCAL nReg:= 0

    //msginfo( "envia_bak" )
    If !MySql
      //  msginfo( "conecta mysql" )
      /////  Conecta()
      //  msginfo( "mysql conectado" )
    EndIf

    If MySql
        //swlog( "DEBUG: Abre PDV_BAK" )
	Use ( cPdv_Bak_Dbf ) Alias pdv_bak New
        dbSelectAr( "pdv_bak" )
        //swlog( "DEBUG: Selectar    " )
        if Used()
           pdv_bak->( DBGoTop() )
           // Enquanto nao encontrar um item enviado ou o final
           while pdv_bak->ENVIAD == 'S' .and. !( pdv_bak->( EOF() ) )
              pdv_bak->( dbskip() )
           enddo
           if !pdv_bak->( EOF() )
              swlog( "Enviando informacoes contidas em PDV_BAK.DBF" )
           endif
           While !pdv_bak->( Eof() )
              //msginfo( "select * from cTabela" )
              oTable:= oServer:Query( "Select * from "+cTable )
              If oTable:NetErr()
                  MySql:= .F.
                  swlog( oTable:Error() )
              else
                   //msginfo( "?" +  time()+': leu toda tabela: '+cTable )
              endIf
              //msginfo( "enviado?" )
              If pdv_bak->ENVIAD=='S'
                  //msginfo( "enviado? Sim" )
                  pdv_bak->( DBSkip() )
                  Loop
              EndIf
              //msginfo( "inserindo informacoes" )
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
              //? time()+': '+cTemp 
              //msginfo( "executando query" )
              oTable:Destroy()

              oTable:= oServer:Query( cTemp )
              If oTable:NetErr()
                  swlog( oTable:Error() )
                  MySql:= .F.
                  Exit
              Else
                  ++nReg
                  if pdv_bak->( Rlock() )
                     Repl pdv_bak->ENVIAD With 'S'
                  else
                     swlog( "Impossivel marcar registro ENVIADO=S. Bloqueio nao permitido..." )
                  endif
                  //msginfo( "?" +  time()+': registro bak gravado em '+cTable )
              EndIf
              oTable:Destroy()
              pdv_bak->( DBSkip() )
           EndDo       
           if nReg > 0
              swlog( "Gravados " + Alltrim( Str( nReg, 12, 0 ) ) + " registro(s) a partir de PDV_BAK.DBF" )
              pdv_bak->( dbgotop() )
              while !pdv_bak->( EOF() ) 
                 if pdv_bak->ENVIAD == 'S' .and. !( pdv_bak->( EOF() ) )
                    IF pdv_bak->( rLock() )
                       pdv_bak->( dbdelete() )
                    ENDIF
                 endif
                 pdv_bak->( dbskip() )
              enddo
           endif
           dbSelectAr( "pdv_bak" )
           dbCloseArea()
        endif
    endif
    
Return Nil


Function Conecta()
STATIC nSegundos

 IF nSegundos == Nil
    nSegundos:= SECONDS()
 ENDIF
// swlog( "DEBUG: Conecta" )
 IF !MySql  
    oServer:= TMySQLServer():New( cHostName, cUser, cPassWord )
    If oServer:NetErr()
        IF SECONDS() > ( nSegundos + 10 ) 
           swlog( oServer:Error() )
           nSegundos:= SECONDS()
        ENDIF
	MySql:= .F.
    Else
//        swlog( "DEBUG: Conectado ao servidor. " )
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
                    // swlog( "?" + time()+': criado: '+cTable )
		EndIf
	    Else
		MySql:= .T.
                // swlog( "?" + time()+': existe: '+cTable )
	    EndIf
	EndIf
    EndIf
 ENDIF
 if MySQL
//    swlog( "Conectado ao servidor" )
 endif
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
    
//  @ 02, 02 Say 'Codigo ' Get afDatas[ 1 ]
//  @ 03, 02 Say 'Nome   ' Get afDatas[ 2 ]
//  @ 04, 02 Say 'Fone   ' Get afDatas[ 3 ]
//  Read
    
//  @ 23, 02 Say 'Salva (S/N)? ' Get op Pict "!"
    Read
    If op=='S'
	oRecord:= ob:oQuery:GetBlankRow()
	For n:= 1 to 3
	    oRecord:FieldPut( n, afDatas[ n ] )
	Next
	oTable:Append( oRecord )
	If oTable:NetErr()
            swlog( oTable:Error() )
	EndIf	
    EndIf
    RestScreen( ,,,, cScreen )
    oTable:Refresh()
    ob:RefreshAll()
    
Return Nil





Function AtualizaMeuSaldo()
Local oTabela, lFalhaAoEnviar:= .T.
Local cIndice, cDescri, cUnidad, nPrecov, nSaldo_, cCodFab
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
      IF ( nSegundos + 10 ) < SECONDS() .OR. ( nSegundos - SECONDS() ) > 1000
         nSegundos:= SECONDS()
      ELSE 
         // Se ainda nao chegou ao tempo estimado em segundos
         // sai da rotina sem efetuar nada retornando a aplicacao
         Return .F.
      ENDIF
   ENDIF
//   SwLog( 'Seconds OK (depois do teste)' )

  IF MySQL

     // SwLog( 'MySqL .T.' )
     DBSelectAr( _COD_MPRIMA )
     IF !Used()
//        SWLOG( "DEBUG: abrir "+ DiretorioDeDados + "\cdmprima.dbf" )
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
//        SWLOG( "DEBUG: abertura de cdmprima.dbf realizada com sucesso " )
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
              cCodfab:= oRow:FieldGet( 6 )

              ///////// oRow:Destroy()
              // Destruicao de oRow

//              SWLog( "DEBUG: " + cIndice + " " + cDescri )

              IF !( alltrim( cIndice ) == "" )
                 MPR->( DBSetOrder( 1 ) )
                 IF MPR->( DBSeek( cIndice ) )
//                    SWLog( "DEBUG: Encontrou " + cIndice + " " + cDescri )
                    IF ( MPR->SALDO_ <> nSaldo_ ) .OR.;
                       ( !( ALLTRIM( MPR->DESCRI ) == ALLTRIM( cDescri ) ) ) .OR.;
                       ( !( MPR->UNIDAD == cUnidad ) ) .OR.;
                       ( MPR->PRECOV <> nPrecoV ) .OR. ( TRIM( MPR->CODFAB ) <> TRIM( cCodFab ) )
                       SWLog( "Atualizando o produto " + cIndice + " " + cDescri + " " + cUnidad )
                       IF MPR->( RLock() )
//                          SWLog( "DEBUG: Incremento " )
                          nProduto:= nProduto + 1
//                          SWLog( "DEBUG: Gravacao  " )
                          Replace MPR->DESCRI with cDescri,;
                                  MPR->UNIDAD With cUnidad,;
                                  MPR->PRECOV With nPrecov,;
                                  MPR->CODFAB With cCodFab

                           IF ( AT( "\0", DiretorioDeDados ) > 0 )
                           ELSE
                              swlog( "Empresa Principal. Atualizando saldo do produto." )
                              // Esta no deposito
                              Replace MPR->SALDO_ With nSaldo_
                           ENDIF

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
                            MPR->CODIGO With cIndice,;
                            MPR->CODRED With SubStr( cIndice, 4, 4 ),;
                            MPR->DESCRI with cDescri,;
                            MPR->UNIDAD With cUnidad,;                           
                            MPR->PRECOV With nPrecov,;
                            MPR->CODFAB With cCodFab

                    // Est† em uma empresa, n∆o faz nada com os produtos locais
                    IF ( AT( "\0", DiretorioDeDados ) > 0 )
                    ELSE
                       swlog( "Empresa Principal. Atualizando saldo do produto." )
                       // Esta no deposito
                       REPLACE MPR->SALDO_ With nSaldo_
                    ENDIF

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



Function swlog( cMsg )
  Local Comando:= DTOC( DATE() ) + "-" + TIME() + ": " +  cMsg + Chr( 13 ) + Chr( 10 )
  Local hFile
    hFile:= Fopen( "flinelog.txt", 2 + 64 )  // READWRITE + SHARED
    IF !( FError() == 0 )
       msginfo( "Impossivel abrir flinelog.txt (DOS error:" + Str( FError() ) + ")" )
    ELSE
       Fseek( hFile, 0, 2 )
       FWrite( hFile, Comando, Len( Comando ) )
       FClose( hFile )
    ENDIF
    Return Nil

