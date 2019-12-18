REM assemble and link
call  edit %1.asm
if not exist %1.asm goto end
erase %1.obj
masm %1 %1
if not exist %1.obj goto end
link %1, %1, NUL
if not exist %1.exe goto end
if not "A%2"=="A"   goto RUN
exe2bin %1.exe %1.com
:run
PAUSE ctrl-break to terminate OR
%1
:END
