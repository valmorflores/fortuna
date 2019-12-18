program SchFline;

uses
  Forms, Windows,
  uSchFline in 'uSchFline.pas' {Form1};

{$R *.res}
var ExtendedStyle : Integer;
begin
  Application.Initialize;

//  ExtendedStyle := GetWindowLong(Application.Handle, gwl_ExStyle); SetWindowLong(Application.Handle, gwl_ExStyle, ExtendedStyle or ws_Ex_ToolWindow and not ws_Ex_AppWindow);

  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
