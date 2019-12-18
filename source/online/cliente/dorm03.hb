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
PROJECT = dorm03 $(PR) 
OBJFILES = $(OBJ)/dorm03.o $(OB) 
PRGFILES = dorm03.prg $(PS) 
OBJCFILES = $(OBC) 
CFILES = $(CF)
RESFILES =                                                   
RESDEPEN =                                                   
LIBFILES = -Wl,--start-group -lvm -lrtl -lgtcrs -llang -lrdd -lrtl -lvm -lmacro -lpp -ldbfntx -ldbfcdx -lcommon -lcodepage -lncurses -lgpm -lpthread -lm  -lmysql -lmysqlclient -Wl,--end-group 
DEFFILE = 
HARBOURFLAGS = 
CFLAG1 = -I$(HB_INC_INSTALL) -c -Wall
CFLAG2 = -L $(HB_LIB_INSTALL)
RFLAGS = 
LFLAGS = $(CFLAG2)
IFLAGS = 
LINKER = gcc
 
ALLOBJ = $(OBJFILES)  $(OBJCFILES)
ALLRES = $(RESDEPEN) 
ALLLIB = $(LIBFILES) 
.autodepend
 
#COMMANDS
.cpp.o:
gcc $(CFLAG1) $(CFLAG2) -o$* $**
 
.c.o:
gcc -I$(HB_INC_INSTALL) $(CFLAG1) $(CFLAG2) -I. -g -o$* $**
 
.prg.o:
harbour -n  -go -I$(HB_INC_INSTALL) -I.  -o$* $**
 
#BUILD
 
$(PROJECT): $(CFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(LINKER) @&&!
    $(PROJECT) 
    $(ALLOBJ)  
    $(LFLAGS)  
    $(ALLLIB)  
!
