
function modelo

function  SELECAODEVICE()
function  ATALHO()
function  CALCULADOR()
function  CALENDAR()
function  EXECUTEEXTERNAL()
function  AREASUSADAS()


function  SWSET( nId, xStatus )
   STATIC aFuncoes[1]
   if len( aFuncoes ) <= 1   
      for I:= 0 to 1024 
        AADD( aFuncoes, 0 )
      next
    end
   if xStatus <> nil
      aFuncoes[nId]:= xStatus
   else
      return aFuncoes[nId]
    end
return 0


function  FINALIZA()
   quit

function  MODOVGA() 

function  AJUDA( cMsg )
    local cCor:= SetColor()
    Set Color to "0/W"
    @ MaxRow(),00 say Space(MaxCol())
    @ MaxRow(),00 say cMsg
    SetColor( cCor )

function MENSAGEM( cMsg )
    local cCor:= SetColor()
    Set Color to "W+/B"
    @ MaxRow()-1,00 say Space(MaxCol())
    @ MaxRow()-1,00 say cMsg
    SetColor( cCor )
return .t.

function  PAUSA()
   inkey(0)

function  FIM()
 
function  VERVERSAOSISTEMA()
function        MONTAARQUIVO()

function  SYSTEM()
function  DESLIGAMOUSE()

function  DIRETORIO( cDir )
return HB_DirExists( cDir ) 

function SWALERTA(cMsg, aOpcoes)
    local i:= 0
    local cCor:= SetColor()
    vpbox( 01, 01, 08, 50, ' Alerta ', 'w/g' )
    SetColor( "w+/g" )
    @ 03,05 say cMsg
    for i:= 1 to Len( aOpcoes )
        @ 05+i,5 PROMPT aOpcoes[i]
    next
    MENU TO nOpcao
    SetColor( cCor )
return nOpcao


function swMenu( aMenu, nOpcao )
    for i:= 1 to Len( aMenu )
        @ aMenu[i][1],aMenu[i][2] PROMPT aMenu[i][3]
    next    
    MENU TO nOpcao
return nOpcao 

/*
swmenunew(09,03," 4 Compras       ",2,COR[11],;
        "Controle de compras.",,,COR[6],.F.))
*/
function swMenuNew( lin, col, texto, opc, cor, mensagem, a,b, cor2, stat )
return { lin, col, texto,  opc, cor, mensagem, a,b, cor2, stat }

function vpBox( lin1, col1, lin2, col2, texto, cor )
    Local cCor:= setColor()
    SetColor( cor )
    SCROLL( lin1, col1, lin2, col2 )
    DispBox( lin1, col1, lin2, col2, nil, cor )
    if texto <> nil
       @ lin1, col1 + 2 say texto color cor
    end
    setColor(cCor)

function  SCREENSAVE( l1, c1, l2, c2 )
return chr(l1)+chr(c1)+chr(l2)+chr(c2) + SAVESCREEN( l1, c1, l2, c2 )

function  SCREENREST( cTela )
local l1:= asc( substr( cTela, 1, 1 ) )
local c1:= asc( substr( cTela, 2, 1 ) )
local l2:= asc( substr( cTela, 3, 1 ) )
local c2:= asc( substr( cTela, 4, 1 ) )
cTela:= SUBSTR( cTela, 5 )
return RESTSCREEN( l1, c1, l2, c2, cTela )

function AVISO( cTxt )
    Local cCor:= setcolor()
   vpbox( (MaxRow()/2)-2, ( MaxCol()/2 ) - ( len( cTxt ) / 2 ) - 4, ;
          (MaxRow()/2)+2, ( MaxCol()/2 ) + ( len( cTxt ) / 2 ) + 4, ;
        ' AVISO ', 'W/R+'  )
    setColor( 'W/R+' )
    @ (MaxRow()/2), (( MaxCol()/2 ) - ( len( cTxt ) / 2 )) SAY cTxt 
    SetColor(cCor)
 
function  VPTELA()
    Local cCor:= SetColor()
    VPFundoFrase( 0, 0, MaxRow(), MaxCol(), " Sistema " )
    SetColor( '15/02')
    @ 00,00 say space( MaxCol()+1 )
    @ 01,00 say space( MaxCol()+1 )
    @ 01,00 say 'SISTEMA DE GERENCIAMENTO'
    USERSCREEN()
    USERMODULO()
    SetColor( cCor )


function  USERSCREEN()
    Local cCor:= SetColor()
    SetColor( '00/15')
    @ 02,00 say space( MaxCol()+1 )
    @ 02,00 say 'Sitema'
    SetColor( cCor )

function  USERMODULO()
    Local cCor:= SetColor()
    SetColor( '01/15')
    @ 02,MaxCol()-10 say ' Usuario '
    SetColor( cCor )

function  GUARDIAO()
function  CONFIGURASENHAS()

function  ZOOM( nL1, nC1, nL2, nC2 )
return Screensave(nL1, nC1, nL2, nC2)

function UNZOOM( cTela )
ScreenRest( cTela )
return .t.

function  TITULO()
function  USUARIO()
function  CORFUNDOATUAL()
function  LIMPAVAR()
function        LIBERAMEMORIA()
function  SETOPCAO() 
function  GUARDAPODERES()

function  FORTUNA()
function  NATOPERA()
function  VIEWFILE()
function  PCF()
function  VPBOXSOMBRA()
function        SKIPPERARR()




function  CONFIRMA( nLin, nSize, Titulo, Texto, cSN, cor )
    local cCor:= SETCOLOR(), cTela:= ScreenSave(0,0,MaxRow(),MaxCol())
    local nOpcao
    local nLin1, nCol1, nLin2, nCol2
    cor:= '01/15,15/01,,,14/00'
    nSize:= len( Texto )+10
    nLin1:= nLin
    nCol1:= (MaxCol()-nSize)/2
    nLin2:= nLin1+6
    nCol2:= (MaxCol()-nCol1)
    SetColor( cor )
    vpBox( nLin1, nCol1, nLin2, nCol2, Titulo, cor )
    @ nLin1+2, ( (MaxCol()/2)-(len(Texto)/2)) say Texto 
    @ nLin1+4, ( MaxCol() / 2 )-10 PROMPT '  Sim  '
    @ nLin1+4, ( MaxCol() / 2 )+10 PROMPT '  Nao  '
    menu to nOpcao
    SetColor( cCor )
    ScreenRest( cTela )
    if nOpcao == 1
       return .t.
    else
        return .f.
    end
  

function  FECHAARQUIVOS()

function  NETRLOCK()
return RLOCK() // //netReclock( 6 ) // Segundos

function        BUSCANET()
return .t.

function  BOXSAVE()
function  BOXREST()

function  CONFIG01()

function  MOUSESTATUS()
function  LIGAMOUSE()
function  VPOBSBOX()
function        PROTECAOTELA()

function  UNZIPCHR( cStr )
return cStr

function  ZIPCHR( cStr )
return cStr

function  ROLLER()
function  CGCMF()
return .t.

function        CPF()
return .t.

function  ASTERISCO()
return .t.

function  NETUSE( cfile, bool1, position, calias, bool2 )
    USE &cfile Alias &calias
return .T.

function  NFISCAL()
function        VALSIZE()
function  VALDEC()
function  SWBOTAO()
function  OCORRENCIA()
function  PROCESSO()

function        PESTATISTICA()

function  VPTERM()
function  STRVEZES()


function  SEMANA()
function  MES()

function ACESSO( nTecla )
Return .F.

function  ABREGAVETA()
function  MULTA()
function  JUROSSIMPLES()
function  JUROSFUTUROS()
function        PULACAMPO()
function  SWGRAVAR()
function  FECHAAREA()
function  ESTATISTICA()

function  VERUF( cUf )
return .t.


function        LASTDAY()

function  NOSSONUMERO()
function  BUSCAULTIMA()

function        IESTADUAL()
function  FCONTACORR()
function  NFMANUAL()
function  GRAVAUSUARIO()

function        PEGACODFISCAL()
 
function  DISPLAYSCAN()
function  ABREVIATURA()
function        ARQUIVOS()
 
 

    function DEBUG()

//VPFundoFrase( 17, 02, 20, 76, ALLTRIM( aMatriz[nRow][2] ) )
function VPFundoFrase( nl1, nc1, nl2, nc2, ctxt )
    local i:= 0, j:= 0, n:= 0
    for i:= nl1 to nl2 
        for j:= nc1 to nc2 
            n:= n+1
            if n>len(ctxt)
                n:= 1
            end
            @ i, j say substr(ctxt,n,1)  
        next
    next
return .t.