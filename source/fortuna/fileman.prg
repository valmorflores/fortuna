#Include "C:\CLIP52\INCLUDE\INKEY.CH"

#DEFINE GV_BLOCKSIZE      50000

genericviewer("X.TXT")


/***
*
*  GenericViewer( <cFile> ) --> cFile
*
*  View the contents of a text file (?)
*
*/
STATIC FUNCTION GenericViewer( cFile )
LOCAL i:= 1, LIN:= 1

   LOCAL cBuffer := ""
   LOCAL nHandle := 0
   LOCAL nBytes  := 0

   cBuffer := SPACE( GV_BLOCKSIZE )
   nHandle := FOPEN( cFile )


   SETCOLOR( "15/01" )

cor:= 0

   IF FERROR() != 0
      cBuffer := "Error reading file!"
   ELSE
      nBytes = FREAD( nHandle, @cBuffer, GV_BLOCKSIZE )
      WHILE .T.
         aFile:= BufferToArray( cBuffer, 24 )
         LCONTINUE:= .T.
         WHILE LcONTINUE
             ++I
             IF I <= LEN( AFILE )
               @ ++LIN,00 say aFile[ i ]
               if LIN >= 24
                   inkey(0)
                   cls
                   LIN:= 0
               endif
             ENDIF
             IF LastKey() == K_PGUP
                i:= i - 24
                IF i <= 0
                   FSeek( nHandle, Len( cBuffer ) * -1 )
                   cBuffer:= SPACE( GV_BLOCKSIZE )
                   nBytes = FREAD( nHandle, @cBuffer, GV_BLOCKSIZE )
                   i:= 0
                ENDIF
             ELSEIF LastKey() == K_CTRL_PGDN .OR. i >= LEN( aFile )
                setColor( "15/" + strzero( ++cor, 2, 0 ) )
                cBuffer:= SPACE( GV_BLOCKSIZE )
                nBytes = FREAD( nHandle, @cBuffer, GV_BLOCKSIZE )
                I:= 1
                IF nBytes < Len( Space( GV_BLOCKSIZE  ) ) 
                   lContinue:= .F.
                ENDIF
             ENDIF
         ENDDO
         @ 24,00 SAY "FINAL DO ARQUIVO LOCALIZADO"
         INKEY(0)
         @ 24,00 SAY SPACE( 70 )


      ENDDO
   ENDIF
   FCLOSE( nHandle )

   RETURN ( cFile )


Function BufferToArray( cBuffer )
Local i, cString:= "", aFile:= {}
   FOR i:= 1 TO Len( cBuffer )
      IF SubStr( cBuffer, i, 1 ) == CHR( 13 )
         AAdd( aFile, cString )
         cString:= ""
      ELSE
         cString:= cString + SubStr( cBuffer, i, 1 )
      ENDIF
   NEXT
   Return aFile




