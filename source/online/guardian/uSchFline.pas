unit uSchFline;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    TrayIconData: TNotifyIconData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if FileExists( 'c:\finaliza.gok' ) then
    Close;
  if FindWindow( Nil, 'f-line' ) = 0 Then
    Winexec( 'c:\fortuna\fline.exe', SW_HIDE );
end;

procedure TForm1.FormCreate(Sender: TObject);
type
  TRegisterServiceProcess = function (dwProcessID, dwType:DWord) : DWORD; stdcall;
const
  WM_ICONTRAY = WM_USER + 1;
var
  H : HWnd;
  Handle: THandle;
  RegisterServiceProcess: TRegisterServiceProcess;
begin
  //*** Nao aparece no Ctr+Alt+Del ***********************************************
  Handle := LoadLibrary('KERNEL32.DLL');
  RegisterServiceProcess := GetProcAddress(Handle, 'RegisterServiceProcess');
  RegisterServiceProcess(GetCurrentProcessID, 1);
  FreeLibrary(Handle);

{
  with TrayIconData do
  begin
    cbSize:= SizeOf( TrayIconData );
    Wnd:= Handle;
    uID:= 0;
    uFlags:= NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage:= WM_ICONTRAY;
    hIcon:= Application.Icon.Handle;
    StrPCopy( szTip, 'Fortuna (Sched Fline)' ); // Application.Title );
  end;
  Shell_NotifyIcon( NIM_ADD, @TrayIconData );
}

  //*** Nao aparece na barra ***********************************************
{  SetWindowLong(Application.Handle, GWL_EXSTYLE,
  GetWindowLong(Application.Handle, GWL_EXSTYLE) or
  WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
}
//  H := FindWindow( Nil, 'schfline' );
//  if H <> 0 then ShowWindow( H, SW_HIDE );
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  if FileExists( 'c:\finaliza.gok' ) then
  begin
    DeleteFile( 'c:\finaliza.gok' );
//    Shell_NotifyIcon( NIM_DELETE, @TrayIconData );
    CanClose:= True;
  end;
end;

end.
