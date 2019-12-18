// First step is to open the communications device for read/write. This is 
// achieved using the Win32 'CreateFile' function.

Var

DeviceName: Array[0..80] of Char;
ComFile: THandle;

StrPCopy(DeviceName, 'COM1:');

ComFile := CreateFile(DeviceName, GENERIC_READ or GENERIC_WRITE, 0, Nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

if ComFile = INVALID_HANDLE_VALUE then
{ Raise an exception }

// Setting up the serial port
{
Setup is performed using the 'SetupComm', 'GetCommState', 'BuildCommDCB', 'SetCommState' and 'SetCommTimeouts' Win32 functions. The following code demonstrates. See the Win32 API documentation for more information on the parameters that may be passed to each call.
}
Const

RxBufferSize = 256;
TxBufferSize = 256;

Var

DCB: TDCB;
Config : String;
CommTimeouts : TCommTimeouts; 

if not SetupComm(ComFile, RxBufferSize, TxBufferSize) then
{ Raise an exception }

if not GetCommState(ComFile, DCB) then
{ Raise an exception }

Config := 'baud=19200 parity=n data=8 stop=1' + NUL;

if not BuildCommDCB(@Config[1], DCB) then
{ Raise an exception }

if not SetCommState(ComFile, DCB) then
{ Raise an exception }

with CommTimeouts do
begin

ReadIntervalTimeout := 0;
ReadTotalTimeoutMultiplier := 0;
ReadTotalTimeoutConstant := 1000;
WriteTotalTimeoutMultiplier := 0;
WriteTotalTimeoutConstant := 1000;

end;

if not SetCommTimeouts(ComFile, CommTimeouts) then
{ Raise an exception }

{
Writing a string to the serial port

The Win32 'WriteFile' function is used to write data to the serial port. Note that we pass an offset of 1 when referencing the string to send to avoid sending the length information that is held by Pascal. Also note that we send a CR (13) / LF (10) sequence to simulate the operation of a WriteLn statement. If the string cannot be sent within the time limit specified by the 'SetCommTimeouts' function because of flow control an error will occur. We have set the timeout in the example above to 1000 milliseconds, or one second.
}
 

Var

s: String;
BytesWritten: Integer;

 s := 'Test string…' + #13 + #10;

if not WriteFile (ComFile, s[1], Length(s), BytesWritten, Nil) then
{ Raise an exception }

Reading a string from the serial port

The following is an example of using the 'ReadFile' function to read data from the serial port. Note that some conversion is required to get the data back to a Pascal style string because we pass a raw buffer to the function. If no data is available within the time limits set by 'SetCommTimeouts' the call will return zero bytes read and hence we will have a zero length string. We have set the timeout in the example above to 1000 milliseconds, or one second.

 Var

d: array[1..80] of Char;
s: String;
BytesRead, i: Integer;

 if not ReadFile (ComFile, d, sizeof(d), BytesRead, Nil) then
{ Raise an exception }

s := '';

for i := 1 to BytesRead do s := s + d[I];

Closing the serial port

The following code closes the serial port. Your application should be coded with proper exception handling so that once the serial port has been opened it is properly closed when an error occurs.

CloseHandle(ComFile);

