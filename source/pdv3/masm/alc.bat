masm %1,t,nul,nul
link t,t,nul,,
exe2bin t.exe %1.com
erase t.*
copy %1.* b: