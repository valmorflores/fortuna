@ECHO OFF
ECHO.

CALL E.BAT %1

ECHO.
ECHO.��������������������������������������������������������������������������������
ECHO. Compila��o ? ...
PAUSE > NUL
ECHO.
CALL C.BAT

ECHO.
ECHO.��������������������������������������������������������������������������������
ECHO. Liga��o ? ...
PAUSE > NUL
ECHO.
CALL L.BAT

ECHO.
ECHO.��������������������������������������������������������������������������������
ECHO. Execu��o ? ...
PAUSE > NUL
ECHO.
CALL F.BAT

