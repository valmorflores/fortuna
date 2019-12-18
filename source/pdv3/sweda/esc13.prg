*
* Programa ESC13.PRG
* Envia o comando Esc.13 (Leitura X) ao impressor e recebe o status
*******************************************************************

set device to printer
set printer to ifsweda
@ prow(),pcol() say chr(27)+".13}"
set printer to
set device to screen

arq = fopen("ifsweda.prn")
status = freadstr(arq,128)
fclose(arq)
? "Status = "+status
