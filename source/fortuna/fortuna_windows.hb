#BCC
VERSION=BCB.01
!ifndef BCB
BCB = $(MAKEDIR)
!endif

!ifndef BHC
BHC = $(HMAKEDIR)
!endif
 
RECURSE= NO 
 
FWH = c:\harbour\lib                                                                                                                                                                                          
GUI = YES
MT = NO
SRC02 = obj 
PROJECT = fortuna_windows.exe $(PR) 
OBJFILES = $(SRC02)\VPCEI.obj //
 $(SRC02)\VPC88700.obj //
 $(SRC02)\apagamov.obj //
 $(SRC02)\apres.obj //
 $(SRC02)\atalho_.obj //
 $(SRC02)\atualiza.obj //
 $(SRC02)\ceconfig.obj //
 $(SRC02)\cfgimp.obj //
 $(SRC02)\clibarra.obj //
 $(SRC02)\config.obj //
 $(SRC02)\config00.obj //
 $(SRC02)\config01.obj //
 $(SRC02)\conta.obj //
 $(SRC02)\conv_vpb.obj //
 $(SRC02)\diversos.obj //
 $(SRC02)\estatist.obj //
 $(SRC02)\estoque.obj //
 $(SRC02)\excel.obj //
 $(SRC02)\fluxo.obj //
 $(SRC02)\fonte.obj //
 $(SRC02)\grupos.obj //
 $(SRC02)\icliente.obj //
 $(SRC02)\ientsai.obj //
 $(SRC02)\iestoque.obj //
 $(SRC02)\ifluxo.obj //
 $(SRC02)\ifornece.obj //
 $(SRC02)\imp.obj //
 $(SRC02)\impcfg.obj //
 $(SRC02)\impetq.obj //
 $(SRC02)\impfis.obj //
 $(SRC02)\impnf.obj //
 $(SRC02)\impoc.obj //
 $(SRC02)\import.obj //
 $(SRC02)\impped.obj //
 $(SRC02)\impprod.obj //
 $(SRC02)\impres.obj //
 $(SRC02)\impressa.obj //
 $(SRC02)\imprim_.obj //
 $(SRC02)\imprime.obj //
 $(SRC02)\ioimp2.obj //
 $(SRC02)\ioutros.obj //
 $(SRC02)\ipagar.obj //
 $(SRC02)\iprecoc.obj //
 $(SRC02)\iprecov.obj //
 $(SRC02)\iproduto.obj //
 $(SRC02)\ireceber.obj //
 $(SRC02)\iresumo.obj //
 $(SRC02)\ivendas.obj //
 $(SRC02)\ivendedo.obj //
 $(SRC02)\libera.obj //
 $(SRC02)\m.obj //
 $(SRC02)\mail.obj //
 $(SRC02)\material.obj //
 $(SRC02)\maximo.obj //
 $(SRC02)\mensfile.obj //
 $(SRC02)\montagem.obj //
 $(SRC02)\multipro.obj //
 $(SRC02)\natopera.obj //
 $(SRC02)\nfiscal.obj //
 $(SRC02)\nfmanual.obj //
 $(SRC02)\parcela.obj //
 $(SRC02)\pesquisa.obj //
 $(SRC02)\reltela.obj //
 $(SRC02)\remessa2.obj //
 $(SRC02)\serial.obj //
 $(SRC02)\sistfile.obj //
 $(SRC02)\solucao.obj //
 $(SRC02)\suporte.obj //
 $(SRC02)\swconfig.obj //
 $(SRC02)\telacfg.obj //
 $(SRC02)\valor.obj //
 $(SRC02)\vpbibaux.obj //
 $(SRC02)\vpbibcei.obj //
 $(SRC02)\vpc00000.obj //
 $(SRC02)\vpc10000.obj //
 $(SRC02)\vpc12300.obj //
 $(SRC02)\vpc12350.obj //
 $(SRC02)\vpc12600.obj //
 $(SRC02)\vpc14100.obj //
 $(SRC02)\vpc14300.obj //
 $(SRC02)\vpc14310.obj //
 $(SRC02)\vpc14320.obj //
 $(SRC02)\vpc15000.obj //
 $(SRC02)\vpc21000.obj //
 $(SRC02)\vpc21100.obj //
 $(SRC02)\vpc21110.obj //
 $(SRC02)\vpc21111.obj //
 $(SRC02)\vpc21210.obj //
 $(SRC02)\vpc21300.obj //
 $(SRC02)\vpc21400.obj //
 $(SRC02)\vpc21410.obj //
 $(SRC02)\vpc21500.obj //
 $(SRC02)\vpc22100.obj //
 $(SRC02)\vpc22110.obj //
 $(SRC02)\vpc25000.obj //
 $(SRC02)\vpc26000.obj //
 $(SRC02)\vpc27000.obj //
 $(SRC02)\vpc28600.obj //
 $(SRC02)\vpc28700.obj //
 $(SRC02)\vpc28800.obj //
 $(SRC02)\vpc29700.obj //
 $(SRC02)\vpc31000.obj //
 $(SRC02)\vpc35100.obj //
 $(SRC02)\vpc35120.obj //
 $(SRC02)\vpc35130.obj //
 $(SRC02)\vpc35140.obj //
 $(SRC02)\vpc35200.obj //
 $(SRC02)\vpc35300.obj //
 $(SRC02)\vpc35400.obj //
 $(SRC02)\vpc35500.obj //
 $(SRC02)\vpc35600.obj //
 $(SRC02)\vpc35700.obj //
 $(SRC02)\vpc35800.obj //
 $(SRC02)\vpc35900.obj //
 $(SRC02)\vpc36000.obj //
 $(SRC02)\vpc36600.obj //
 $(SRC02)\vpc37100.obj //
 $(SRC02)\vpc37200.obj //
 $(SRC02)\vpc40000.obj //
 $(SRC02)\vpc41000.obj //
 $(SRC02)\vpc41234.obj //
 $(SRC02)\vpc41333.obj //
 $(SRC02)\vpc50000.obj //
 $(SRC02)\vpc51000.obj //
 $(SRC02)\vpc51100.obj //
 $(SRC02)\vpc51999.obj //
 $(SRC02)\vpc55000.obj //
 $(SRC02)\vpc55500.obj //
 $(SRC02)\vpc56000.obj //
 $(SRC02)\vpc57400.obj //
 $(SRC02)\vpc57500.obj //
 $(SRC02)\vpc59999.obj //
 $(SRC02)\vpc66000.obj //
 $(SRC02)\vpc69999.obj //
 $(SRC02)\vpc70000.obj //
 $(SRC02)\vpc79999.obj //
 $(SRC02)\vpc82000.obj //
 $(SRC02)\vpc87500.obj //
 $(SRC02)\vpc87600.obj //
 $(SRC02)\vpc87700.obj //
 $(SRC02)\vpc87800.obj //
 $(SRC02)\vpc87900.obj //
 $(SRC02)\vpc87970.obj //
 $(SRC02)\vpc8800.obj //
 $(SRC02)\vpc88000.obj //
 $(SRC02)\vpc88011.obj //
 $(SRC02)\vpc88012.obj //
 $(SRC02)\vpc88013.obj //
 $(SRC02)\vpc88014.obj //
 $(SRC02)\vpc88100.obj //
 $(SRC02)\vpc88200.obj //
 $(SRC02)\vpc88300.obj //
 $(SRC02)\vpc88701.obj //
 $(SRC02)\vpc88770.obj //
 $(SRC02)\vpc88780.obj //
 $(SRC02)\vpc88800.obj //
 $(SRC02)\vpc88870.obj //
 $(SRC02)\vpc88888.obj //
 $(SRC02)\vpc90000.obj //
 $(SRC02)\vpc91000.obj //
 $(SRC02)\vpc91100.obj //
 $(SRC02)\vpc91200.obj //
 $(SRC02)\vpc91300.obj //
 $(SRC02)\vpc91320.obj //
 $(SRC02)\vpc91350.obj //
 $(SRC02)\vpc91400.obj //
 $(SRC02)\vpc91500.obj //
 $(SRC02)\vpc91600.obj //
 $(SRC02)\vpc91700.obj //
 $(SRC02)\vpc91800.obj //
 $(SRC02)\vpc91900.obj //
 $(SRC02)\vpc92000.obj //
 $(SRC02)\vpc92200.obj //
 $(SRC02)\vpc95300.obj //
 $(SRC02)\vpc98700.obj //
 $(SRC02)\vpc99999.obj //
 $(SRC02)\vpcctrlb.obj //
 $(SRC02)\vpcdoc.obj //
 $(SRC02)\vpcimpp2.obj //
 $(SRC02)\vpcimppe.obj //
 $(SRC02)\vpcinipc.obj //
 $(SRC02)\vpcinitc.obj //
 $(SRC02)\vpcmovpc.obj //
 $(SRC02)\vpcprodu.obj $(OB) 
PRGFILES = VPCEI.PRG //
 VPC88700.PRG //
 apagamov.prg //
 apres.prg //
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
 natopera.prg //
 nfiscal.prg //
 nfmanual.prg //
 parcela.prg //
 pesquisa.prg //
 reltela.prg //
 remessa2.prg //
 serial.prg //
 sistfile.prg //
 solucao.prg //
 suporte.prg //
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
 vpcprodu.prg $(PS) 
OBJCFILES = $(OBC) 
CFILES = $(CF)
RESFILES =                                                   
RESDEPEN =                                                   
LIBFILES = $(FWH)\lib\fiveh.lib $(FWH)\lib\fivehc.lib  bcc640.lib lang.lib vm.lib rtl.lib rdd.lib macro.lib pp.lib dbfntx.lib dbfcdx.lib common.lib gtwin.lib  libct.lib
DEFFILE = 
HARBOURFLAGS =  -I\dev\HB\include  -m 
CFLAG1 =  -OS $(CFLAGS) -d -L$(BHC)\lib;$(FWH)\lib -c -I\dev\HB\include 
CFLAG2 =  -I$(BHC)\include;$(BCB)\include
RFLAGS = 
LFLAGS = -L$(BCB)\lib\obj;$(BCB)\lib;$(BHC)\lib;$(FWH)\lib -Gn -M -m -s -Tpe -aa
IFLAGS = 
LINKER = ilink32
 
ALLOBJ = c0w32.obj $(OBJFILES) $(OBJCFILES)
ALLRES = $(RESDEPEN)
ALLLIB = $(LIBFILES) import32.lib cw32.lib
.autodepend
 
#COMMANDS
.cpp.obj:
$(BCB)\BIN\bcc32 $(CFLAG1) $(CFLAG2) -o$* $**
 
.c.obj:
$(BCB)\BIN\bcc32 -I$(BHC)\include $(CFLAG1) $(CFLAG2) -o$* $**
 
.prg.obj:
$(BHC)\bin\harbour -n -go -I$(BHC)\include $(HARBOURFLAGS) -I$(FWH)\include -o$* $**
#era -go ===== virou -gw
.rc.res:
$(BCB)\BIN\brcc32 $(RFLAGS) $<
 
#BUILD
 
$(PROJECT): $(CFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(BCB)\BIN\$(LINKER) @&&!  
    $(LFLAGS) +
    $(ALLOBJ), +
    $(PROJECT),, +
    $(ALLLIB), +
    $(DEFFILE), +
    $(ALLRES) 
!
