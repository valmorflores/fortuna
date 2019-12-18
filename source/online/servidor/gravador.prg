#Include "VPF.CH"

/*

 GRAVADOR
 --------------------------
 Programa responsavel pela gravacao das informacoes no sistema FORTUNA
 Valmor Pereira Flores

*/
Function main()
    GravarInformacoes()

Function GravarInformacoes
Private DiretorioDeDados:= "\dev\testes\fortuna\dados",;
        CodigoCaixa:= 0,;
        CodigoFilial:= 0

   VendaFile( _ABRIR )
   NumeroCupom( StrZero( VDA->( NUMCUP ), 09, 0 ) )
   LancaEstoque()

   Return Nil



function impCupomAtual()
    Return 0

function PrecoConvertido()
    Return 0 
