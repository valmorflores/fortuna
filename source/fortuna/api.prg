
/* TEST of TIP libs (for higher level URI interface)
 *
 * Usage: This file is similar to a wget command
 *
 * Without the filename, tipwget will be in demo mode,
 * just demostrating it is working
 *
 * With the filename, data will be stored to the file or
 * retrieved from the file and sent to Internet.
 *
 * Usage of URI.
 * HTTP[S] Protocol
 *   http[s]:///?
 *   - at the moment HTTP URI is not able to send data,
 *     (f.e. a form)
 *
 * POP[S] Protocol
 *    pop[s]://:@/[-][MsgNum]
 *    - Without MsgNum, you get the list of messages
 *    - With MsgNum get Message MsgNum
 *    - With -MsgNum deletes message MsgNum
 *
 * SMTP[S] Protocol
 *    smtp[s]://@/RCPT
 *    - (You have to provide a filename)
 *    - use &at; in mail-from message
 *    - Send the mail in filename (that must include
 *      headers) to RCPT f.e.
 *      stmp[s]://user&at;example.com@smtp.example.com/gian@niccolai.ws
 *
 *      NOTE: In Unix, to use '&' from command-line you have to surround
 *      the URL with "", f.e. "smtp[s]://...&at;...@server/dest"
 *
 * FTP[S] Protocol
 *    ftp[s]://user:passwd@/[]
 *    - without path, get the list of files (use path/ to get the list of
 *      files in a dir.
 *    - with path, get a file. If the target file (second param) starts with '+'
 *      it will be sent instead of being retrieved.
 */

#include "inkey.ch"

function ComunicaApi()
  GoGet( 'https://www.useamind.com.br/now/wp-content/uploads/2019/09/people-3104635_1920.jpg')

 
 PROCEDURE GoGet( cURL, cFile )
 return .T.