#include <stdio.h>
#include <fcntl.h>
#include <io.h>

main()
/*
	Programa exemplo da utilizacao do device driver SERSWEDA.SYS
	pelo TURBO C, VERSAO 2.0

*/
{
	char v[5]={0x1b,0x2e,0x31,0x33,0x7d}; /* Envia o comando ESC.13} */
	char b[7];
	int a;
	a=open("IFSWEDA",O_BINARY|O_RDWR);    /* Abre dispositivo IFSWEDA */
	write(a,v,5);			      /* Envia comando ao device */
	read(a,b,7);			      /* Le status do comando */
	printf("\n STATUS = %c",b[0]);
	printf("%c",b[1]);
	printf("%c",b[2]);
	printf("%c",b[3]);
	printf("%c",b[4]);
	printf("%c",b[5]);
	printf("%c",b[6]);
	close(a);			       /* Fecha dispositivo IFSWEDA */
}

