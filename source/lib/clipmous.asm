; M_STAT()  mov ax,3; int 33h; mov rezm,bx; mov c1,cx; mov d1,dx }
; M_YTEXT()
; M_XTEXT()
; M_SHOW() mov ax,1; int 33h;
; M_HIDE() mov ax,2; int 33h;
; M_INIT() mov ax,0; int 33h; mov rez,ax;
; M_END()

     INCLUDE EXTENDA.MAC
     PUBLIC M_INIT
     PUBLIC M_SHOW
     PUBLIC M_HIDE
     PUBLIC M_STAT
     PUBLIC M_YPOS
     PUBLIC M_XPOS
     _PROG        segment 'CODE'
     ASSUME       cs:_PROG
     ;
     M_INIT          PROC   FAR
;
          push bp
          mov  bp,sp
          push ds
          push es
          push si
          push di
;
          Mov     AX,0
          Int     33h
;
          pop   di
          pop   si
          pop   es              ;����⠭���� ॣ�����
          pop   ds
          pop   bp
          RET_INT AX
          ret                  ;�����᪮� �����饭��.
;
     M_INIT     ENDP                 ;����� ��楤���.
;
;
     M_SHOW          PROC   FAR
;
          push bp
          mov  bp,sp
          push ds
          push es
          push si
          push di
;
          Mov     AX,1
          Int     33h
;
          pop   di
          pop   si
          pop   es              ;����⠭���� ॣ�����
          pop   ds
          pop   bp
          ret                  ;�����᪮� �����饭��.
;
     M_SHOW     ENDP                 ;����� ��楤���.
;
     M_HIDE          PROC   FAR
;
          push bp
          mov  bp,sp
          push ds
          push es
          push si
          push di
;
          Mov     AX,2
          Int     33h
;
          pop   di
          pop   si
          pop   es              ;����⠭���� ॣ�����
          pop   ds
          pop   bp
          ret                  ;�����᪮� �����饭��.
;
     M_HIDE     ENDP                 ;����� ��楤���.
;
     M_STAT          PROC   FAR
;
          push bp
          mov  bp,sp
          push ds
          push es
          push si
          push di
;
          Mov     AX,3
          Int     33h
;
          pop   di
          pop   si
          pop   es              ;����⠭���� ॣ�����
          pop   ds
          pop   bp
          RET_INT BX
          ret                  ;�����᪮� �����饭��.
;
     M_STAT     ENDP                 ;����� ��楤���.
;
     M_YPOS          PROC   FAR
;
          push bp
          mov  bp,sp
          push ds
          push es
          push si
          push di
;
          Mov     AX,3
          Int     33h
;
          pop   di
          pop   si
          pop   es              ;����⠭���� ॣ�����
          pop   ds
          pop   bp
          RET_INT DX
          ret                  ;�����᪮� �����饭��.
;
     M_YPOS     ENDP                 ;����� ��楤���.
;
     M_XPOS          PROC   FAR
;
          push bp
          mov  bp,sp
          push ds
          push es
          push si
          push di
;
          Mov     AX,3
          Int     33h
;
          pop   di
          pop   si
          pop   es              ;����⠭���� ॣ�����
          pop   ds
          pop   bp
          RET_INT CX
          ret                  ;�����᪮� �����饭��.
;
     M_XPOS     ENDP                 ;����� ��楤���.
;

;
    _prog    ENDS
              END