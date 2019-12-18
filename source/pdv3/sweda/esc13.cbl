      $SET ANS85 SPZERO NOWARNING
      $SET FILESHARE

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    ESC13.
       AUTHOR.        SWEDA.
      *********************************************************************
      *SISTEMA => COMANDOS IMPRESSORA FISCAL IF-S7000                     *
      *PROGRAMA P/ EFETUAR O RELATORIO X NA IMPRESSORA FISCAL             *
      *OBS.: COMANDOS IF-S7000 SO FUNCIONAM COM PROGRAMA COMPILADO COM  O *
      *      COBOL 4.5                                                    *
      *********************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.  PC.
       OBJECT-COMPUTER.  PC.
       SPECIAL-NAMES.
           CONSOLE       IS CRT
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
      *********************************************************************
      * TRATAMENTO ARQUIVOS                                               *
      *********************************************************************
       FILE-CONTROL.

           SELECT ARQIMP ASSIGN TO DISK
               ORGANIZATION      IS LINE SEQUENTIAL
               ACCESS MODE       IS SEQUENTIAL
               FILE STATUS       IS WSTA.

       FILE SECTION.

       FD  ARQIMP
           VALUE OF FILE-ID IS "IFSWEDA.PRN".
       01  LINHA                        PIC X(132).

       WORKING-STORAGE SECTION.
      ******************************************************************
      * CAMPOS AUXILIARES                                              *
      ******************************************************************
      * LINHAS DOS COMANDOS
       01  LINHA-13.
           03 FILLER                   PIC X(001) VALUE X"1B".
           03 FILLER                   PIC X(001) VALUE ".".
           03 FILLER                   PIC X(002) VALUE "13".
           03 FILLER                   PIC X(001) VALUE "}".

      * TRATAMENTO STATUS DOS ARQUIVOS *********************************
       01  AUXILIARES.
           03  WSTA                    PIC X(02).
           03  FILLER REDEFINES WSTA.
               05  WSTA-1              PIC X(01).
               05  WSTA-2              PIC X(01).
           03  WSTA-R REDEFINES WSTA   PIC 9(04) COMP.
           03  WST2B                   PIC 9(03).
           03  WSTA-AUX                PIC X(02).

       PROCEDURE DIVISION.
      ******************************************************************
      * ROTINA DE PROCESSAMENTO                                        *
      ******************************************************************
       INICIO.

           DISPLAY SPACES WITH BLANK SCREEN FOREGROUND-COLOR IS 7
           BACKGROUND-COLOR IS 0.
           MOVE LINHA-13 TO LINHA.

           OPEN OUTPUT ARQIMP.
           IF WSTA NOT = "00"
              GO TO FINALIZA.

           WRITE LINHA.
           IF WSTA NOT = "00"
              GO TO FINALIZA.

           CLOSE ARQIMP.
           OPEN INPUT ARQIMP.
           IF WSTA NOT = "00"
              GO TO FINALIZA.

           MOVE SPACES TO LINHA.
           READ ARQIMP.
           IF WSTA NOT = "00"
              GO TO FINALIZA.
           DISPLAY "STATUS DA IMPRESSORA: " AT 2303.
           DISPLAY LINHA AT 2325.

       FINALIZA.
           CLOSE ARQIMP.
           STOP RUN.

