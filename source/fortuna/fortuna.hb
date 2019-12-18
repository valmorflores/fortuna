#BCC
VERSION=BCB.01
!ifndef BCB
BCB = $(MAKEDIR)
!endif

!ifndef BHC
BHC = $(HMAKEDIR)
!endif
 
RECURSE= NO 
 
COMPRESS = NO
GUI = NO
MT = NO
OBJ = obj 
PROJECT = vpcei1u2.linux $(PR) 
OBJFILES = $(OBJ)/vpcei.o //
 $(OBJ)/atalho_.o //
 $(OBJ)/atualiza.o //
 $(OBJ)/ceconfig.o //
 $(OBJ)/cfgimp.o //
 $(OBJ)/clibarra.o //
 $(OBJ)/config.o //
 $(OBJ)/config00.o //
 $(OBJ)/config01.o //
 $(OBJ)/conta.o //
 $(OBJ)/conv_vpb.o //
 $(OBJ)/diversos.o //
 $(OBJ)/estatist.o //
 $(OBJ)/estoque.o //
 $(OBJ)/excel.o //
 $(OBJ)/fluxo.o //
 $(OBJ)/fonte.o //
 $(OBJ)/grupos.o //
 $(OBJ)/icliente.o //
 $(OBJ)/ientsai.o //
 $(OBJ)/iestoque.o //
 $(OBJ)/ifluxo.o //
 $(OBJ)/ifornece.o //
 $(OBJ)/imp.o //
 $(OBJ)/impcfg.o //
 $(OBJ)/impetq.o //
 $(OBJ)/impfis.o //
 $(OBJ)/impnf.o //
 $(OBJ)/impoc.o //
 $(OBJ)/import.o //
 $(OBJ)/impped.o //
 $(OBJ)/impprod.o //
 $(OBJ)/impres.o //
 $(OBJ)/impressa.o //
 $(OBJ)/imprim_.o //
 $(OBJ)/imprime.o //
 $(OBJ)/ioimp2.o //
 $(OBJ)/ioutros.o //
 $(OBJ)/ipagar.o //
 $(OBJ)/iprecoc.o //
 $(OBJ)/iprecov.o //
 $(OBJ)/iproduto.o //
 $(OBJ)/ireceber.o //
 $(OBJ)/iresumo.o //
 $(OBJ)/ivendas.o //
 $(OBJ)/ivendedo.o //
 $(OBJ)/libera.o //
 $(OBJ)/m.o //
 $(OBJ)/mail.o //
 $(OBJ)/material.o //
 $(OBJ)/maximo.o //
 $(OBJ)/mensfile.o //
 $(OBJ)/montagem.o //
 $(OBJ)/multipro.o //
 $(OBJ)/mvideo.o //
 $(OBJ)/natopera.o //
 $(OBJ)/nfiscal.o //
 $(OBJ)/nfmanual.o //
 $(OBJ)/parcela.o //
 $(OBJ)/pesquisa.o //
 $(OBJ)/poebarra.o //
 $(OBJ)/prodfarm.o //
 $(OBJ)/produtos.o //
 $(OBJ)/reltela.o //
 $(OBJ)/remessa2.o //
 $(OBJ)/serial.o //
 $(OBJ)/sistfile.o //
 $(OBJ)/solucao.o //
 $(OBJ)/suporte.o //
 $(OBJ)/swa00000.o //
 $(OBJ)/swconfig.o //
 $(OBJ)/telacfg.o //
 $(OBJ)/valor.o //
 $(OBJ)/vpbibaux.o //
 $(OBJ)/vpbibcei.o //
 $(OBJ)/vpc00000.o //
 $(OBJ)/vpc10000.o //
 $(OBJ)/vpc12300.o //
 $(OBJ)/vpc12350.o //
 $(OBJ)/vpc12600.o //
 $(OBJ)/vpc14100.o //
 $(OBJ)/vpc14300.o //
 $(OBJ)/vpc14310.o //
 $(OBJ)/vpc14320.o //
 $(OBJ)/vpc15000.o //
 $(OBJ)/vpc21000.o //
 $(OBJ)/vpc21100.o //
 $(OBJ)/vpc21110.o //
 $(OBJ)/vpc21111.o //
 $(OBJ)/vpc21210.o //
 $(OBJ)/vpc21300.o //
 $(OBJ)/vpc21400.o //
 $(OBJ)/vpc21410.o //
 $(OBJ)/vpc21500.o //
 $(OBJ)/vpc22100.o //
 $(OBJ)/vpc22110.o //
 $(OBJ)/vpc25000.o //
 $(OBJ)/vpc26000.o //
 $(OBJ)/vpc27000.o //
 $(OBJ)/vpc28600.o //
 $(OBJ)/vpc28700.o //
 $(OBJ)/vpc28800.o //
 $(OBJ)/vpc29700.o //
 $(OBJ)/vpc31000.o //
 $(OBJ)/vpc35100.o //
 $(OBJ)/vpc35120.o //
 $(OBJ)/vpc35130.o //
 $(OBJ)/vpc35140.o //
 $(OBJ)/vpc35200.o //
 $(OBJ)/vpc35300.o //
 $(OBJ)/vpc35400.o //
 $(OBJ)/vpc35500.o //
 $(OBJ)/vpc35600.o //
 $(OBJ)/vpc35700.o //
 $(OBJ)/vpc35800.o //
 $(OBJ)/vpc35900.o //
 $(OBJ)/vpc36000.o //
 $(OBJ)/vpc36600.o //
 $(OBJ)/vpc37100.o //
 $(OBJ)/vpc37200.o //
 $(OBJ)/vpc40000.o //
 $(OBJ)/vpc41000.o //
 $(OBJ)/vpc41234.o //
 $(OBJ)/vpc41333.o //
 $(OBJ)/vpc50000.o //
 $(OBJ)/vpc51000.o //
 $(OBJ)/vpc51100.o //
 $(OBJ)/vpc51999.o //
 $(OBJ)/vpc55000.o //
 $(OBJ)/vpc55500.o //
 $(OBJ)/vpc56000.o //
 $(OBJ)/vpc57400.o //
 $(OBJ)/vpc57500.o //
 $(OBJ)/vpc59999.o //
 $(OBJ)/vpc66000.o //
 $(OBJ)/vpc69999.o //
 $(OBJ)/vpc70000.o //
 $(OBJ)/vpc79999.o //
 $(OBJ)/vpc82000.o //
 $(OBJ)/vpc87500.o //
 $(OBJ)/vpc87600.o //
 $(OBJ)/vpc87700.o //
 $(OBJ)/vpc87800.o //
 $(OBJ)/vpc87900.o //
 $(OBJ)/vpc87970.o //
 $(OBJ)/vpc8800.o //
 $(OBJ)/vpc88000.o //
 $(OBJ)/vpc88011.o //
 $(OBJ)/vpc88012.o //
 $(OBJ)/vpc88013.o //
 $(OBJ)/vpc88014.o //
 $(OBJ)/vpc88100.o //
 $(OBJ)/vpc88200.o //
 $(OBJ)/vpc88300.o //
 $(OBJ)/vpc88700.o //
 $(OBJ)/vpc88701.o //
 $(OBJ)/vpc88770.o //
 $(OBJ)/vpc88780.o //
 $(OBJ)/vpc88800.o //
 $(OBJ)/vpc88870.o //
 $(OBJ)/vpc88888.o //
 $(OBJ)/vpc90000.o //
 $(OBJ)/vpc91000.o //
 $(OBJ)/vpc91100.o //
 $(OBJ)/vpc91200.o //
 $(OBJ)/vpc91300.o //
 $(OBJ)/vpc91320.o //
 $(OBJ)/vpc91350.o //
 $(OBJ)/vpc91400.o //
 $(OBJ)/vpc91500.o //
 $(OBJ)/vpc91600.o //
 $(OBJ)/vpc91700.o //
 $(OBJ)/vpc91800.o //
 $(OBJ)/vpc91900.o //
 $(OBJ)/vpc92000.o //
 $(OBJ)/vpc92200.o //
 $(OBJ)/vpc95300.o //
 $(OBJ)/vpc98700.o //
 $(OBJ)/vpc99999.o //
 $(OBJ)/vpcctrlb.o //
 $(OBJ)/vpcdoc.o //
 $(OBJ)/vpcimpp2.o //
 $(OBJ)/vpcimppe.o //
 $(OBJ)/vpcinipc.o //
 $(OBJ)/vpcinitc.o //
 $(OBJ)/vpcmovpc.o //
 $(OBJ)/vpcprodu.o //
 $(OBJ)/apres.o //
 $(OBJ)/apagamov.o //
 $(OB) 
PRGFILES = vpcei.prg //
 atalho_.prg //
 atualiza.prg //
 ceconfig.prg //
 cfgimp.prg //
 clibarra.prg //
 config.prg //
 config00.prg //
 config01.prg //
 conta.prg //
 conv_vpb.prg //
 diversos.prg //
 estatist.prg //
 estoque.prg //
 excel.prg //
 fluxo.prg //
 fonte.prg //
 grupos.prg //
 icliente.prg //
 ientsai.prg //
 iestoque.prg //
 ifluxo.prg //
 ifornece.prg //
 imp.prg //
 impcfg.prg //
 impetq.prg //
 impfis.prg //
 impnf.prg //
 impoc.prg //
 import.prg //
 impped.prg //
 impprod.prg //
 impres.prg //
 impressa.prg //
 imprim_.prg //
 imprime.prg //
 ioimp2.prg //
 ioutros.prg //
 ipagar.prg //
 iprecoc.prg //
 iprecov.prg //
 iproduto.prg //
 ireceber.prg //
 iresumo.prg //
 ivendas.prg //
 ivendedo.prg //
 libera.prg //
 m.prg //
 mail.prg //
 material.prg //
 maximo.prg //
 mensfile.prg //
 montagem.prg //
 multipro.prg //
 mvideo.prg //
 natopera.prg //
 nfiscal.prg //
 nfmanual.prg //
 parcela.prg //
 pesquisa.prg //
 poebarra.prg //
 prodfarm.prg //
 produtos.prg //
 reltela.prg //
 remessa2.prg //
 serial.prg //
 sistfile.prg //
 solucao.prg //
 suporte.prg //
 swa00000.prg //
 swconfig.prg //
 telacfg.prg //
 valor.prg //
 vpbibaux.prg //
 vpbibcei.prg //
 vpc00000.prg //
 vpc10000.prg //
 vpc12300.prg //
 vpc12350.prg //
 vpc12600.prg //
 vpc14100.prg //
 vpc14300.prg //
 vpc14310.prg //
 vpc14320.prg //
 vpc15000.prg //
 vpc21000.prg //
 vpc21100.prg //
 vpc21110.prg //
 vpc21111.prg //
 vpc21210.prg //
 vpc21300.prg //
 vpc21400.prg //
 vpc21410.prg //
 vpc21500.prg //
 vpc22100.prg //
 vpc22110.prg //
 vpc25000.prg //
 vpc26000.prg //
 vpc27000.prg //
 vpc28600.prg //
 vpc28700.prg //
 vpc28800.prg //
 vpc29700.prg //
 vpc31000.prg //
 vpc35100.prg //
 vpc35120.prg //
 vpc35130.prg //
 vpc35140.prg //
 vpc35200.prg //
 vpc35300.prg //
 vpc35400.prg //
 vpc35500.prg //
 vpc35600.prg //
 vpc35700.prg //
 vpc35800.prg //
 vpc35900.prg //
 vpc36000.prg //
 vpc36600.prg //
 vpc37100.prg //
 vpc37200.prg //
 vpc40000.prg //
 vpc41000.prg //
 vpc41234.prg //
 vpc41333.prg //
 vpc50000.prg //
 vpc51000.prg //
 vpc51100.prg //
 vpc51999.prg //
 vpc55000.prg //
 vpc55500.prg //
 vpc56000.prg //
 vpc57400.prg //
 vpc57500.prg //
 vpc59999.prg //
 vpc66000.prg //
 vpc69999.prg //
 vpc70000.prg //
 vpc79999.prg //
 vpc82000.prg //
 vpc87500.prg //
 vpc87600.prg //
 vpc87700.prg //
 vpc87800.prg //
 vpc87900.prg //
 vpc87970.prg //
 vpc8800.prg //
 vpc88000.prg //
 vpc88011.prg //
 vpc88012.prg //
 vpc88013.prg //
 vpc88014.prg //
 vpc88100.prg //
 vpc88200.prg //
 vpc88300.prg //
 vpc88700.prg //
 vpc88701.prg //
 vpc88770.prg //
 vpc88780.prg //
 vpc88800.prg //
 vpc88870.prg //
 vpc88888.prg //
 vpc90000.prg //
 vpc91000.prg //
 vpc91100.prg //
 vpc91200.prg //
 vpc91300.prg //
 vpc91320.prg //
 vpc91350.prg //
 vpc91400.prg //
 vpc91500.prg //
 vpc91600.prg //
 vpc91700.prg //
 vpc91800.prg //
 vpc91900.prg //
 vpc92000.prg //
 vpc92200.prg //
 vpc95300.prg //
 vpc98700.prg //
 vpc99999.prg //
 vpcctrlb.prg //
 vpcdoc.prg //
 vpcimpp2.prg //
 vpcimppe.prg //
 vpcinipc.prg //
 vpcinitc.prg //
 vpcmovpc.prg //
 vpcprodu.prg //
 apres.prg //
 apagamov.prg //
 $(PS) 
OBJCFILES = $(OBC) 
CFILES = $(CF)
RESFILES =                                                   
RESDEPEN =                                                   
LIBFILES = 
DEFFILE = 
HARBOURFLAGS =  -I/mnt/projetos/dev/linux/include 
CFLAG1 =  -I/mnt/projetos/dev/linux/include-I/usr/include/xharbour -c -Wall
CFLAG2 = -L$(HB_LIB_INSTALL)
RFLAGS = 
LFLAGS =-static-gtcrs
IFLAGS = 
LINKER = xhblnk
 
ALLOBJ = $(OBJFILES)  $(OBJCFILES)
ALLRES = $(RESDEPEN) 
ALLLIB = $(LIBFILES) 
.autodepend
 
#COMMANDS
.cpp.o:
gcc $(CFLAG1) $(CFLAG2) -o$* $**
 
.c.o:
gcc -I/usr/include/xharbour $(CFLAG1) $(CFLAG2) -I. -g -o$* $**
 
.prg.o:
harbour -n  -go -I/usr/include/xharbour -I.  -o$* $**
 
#BUILD
 
$(PROJECT): $(CFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(LINKER) @&&!
    $(PROJECT) 
    $(ALLOBJ)  
    $(LFLAGS)  
    $(ALLLIB)  
!
