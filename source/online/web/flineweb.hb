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
SRC02 = obj 
PROJECT = flineweb.exe $(PR) 
OBJFILES = $(SRC02)\testcgi.obj $(OB) 
PRGFILES = testcgi.prg $(PS) 
OBJCFILES = $(OBC) 
CFILES = $(CF)
RESFILES =                                                   
RESDEPEN =                                                   
LIBFILES = optcon.lib  bcc640.lib lang.lib vm.lib rtl.lib rdd.lib macro.lib pp.lib dbfntx.lib dbfcdx.lib dbffpt.lib dbfdbt.lib common.lib gtwin.lib codepage.lib  mysql.lib libmysql.lib mysqlclient.lib
DEFFILE = 
HARBOURFLAGS = 
CFLAG1 =  -OS $(CFLAGS) -d -L$(BHC)\lib;$(FWH)\lib -c -I 
CFLAG2 =  -I$(BHC)\include;$(BCB)\include
RFLAGS = 
LFLAGS = -L$(BCB)\lib\obj;$(BCB)\lib;$(BHC)\lib -Gn -M -m -s -Tpe -ap
IFLAGS = 
LINKER = ilink32
 
ALLOBJ = c0x32.obj $(OBJFILES) $(OBJCFILES)
ALLRES = $(RESDEPEN)
ALLLIB = $(LIBFILES) import32.lib cw32.lib
.autodepend
 
#COMMANDS
.cpp.obj:
$(BCB)\BIN\bcc32 $(CFLAG1) $(CFLAG2) -o$* $**
 
.c.obj:
$(BCB)\BIN\bcc32 -I$(BHC)\include $(CFLAG1) $(CFLAG2) -o$* $**
 
.prg.obj:
$(BHC)\bin\harbour -n -go -I$(BHC)\include $(HARBOURFLAGS) -o$* $**
 
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
