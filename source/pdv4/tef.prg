/*
  FUNCOES DE INTEGRACAO COM TEF
  -------------------------------------------------------------------------

  Data        - 01 de Outubro de 2003
  Programador - Valmor Pereira Flores

*/
#Define TEF_TIMEOUT  120

// tefGerenciadorAtivo
Function tefGerenciadorAtivo()
  cConteudo:= cConteudo + "000-000=ATV" + Chr( 13 ) + Chr( 10 )
  cConteudo:= cConteudo + "001-000=1" + Chr( 13 ) + Chr( 10 )
  cConteudo:= cConteudo + "999-999=0" + Chr( 13 ) + Chr( 10 )
  IF __TefGravaArquivo( cConteudo )
     IF cRetorno:= __TefLeArquivo( "GERENCIADOR_ATIVO" )
        IF !( cRetorno == "" )
           Return .T.
        ENDIF
     ENDIF
  ENDIF
  Return .F.

// __tefGravaArquivo
Function __TefGravaArquivo( cConteudo )
Prinvate cArquivoTmp:= tefEnvio + "temp.tmp", cArquivoTef:= "INTPOS.001"
   memowrite( cArquivo, cConteudo )
   if File( cArquivo )
      !ren &cArquivoTmp &cArquivoTef
   endif

// __tefLeArquivo
function __TefLeArquivo( cArquivo )
Local nSegundos:= 0
Local cRetorno:= ""
   if cArquivo == nil
      cArquivo:= "INTPOS.STS"

   // Se Ç para testar se o gerenciador esta ativo
   // Tenta localizar os arquivos ATIVO.001 ou INTPOS.STS
   if "GERENCIADOR_ATIVO" $ Upper( cArquivo )
      nSegundos:= SECOUNDS()
      WHILE ( SECOUNDS() - nSegundos ) <= TEF_TIMEOUT
         if file( TefRetorno + "ATIVO.001" ) .OR.;
            File( TefRetorno + "INTPOS.STS" )
            Return "<ok>"
         endif
      ENDDO
      Return ""
   endif

   // Se encontrar o arquivo, retorna o mesmo, sen∆o
   // retorna uma string vazia 
   IF File( cArquivo )
      cRetorno:= MemoRead( cArquivo )
   ELSE
      cRetorno:= ""
   ENDIF
   Return cRetorno
