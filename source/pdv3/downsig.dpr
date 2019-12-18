program DownSIG;

uses
  Forms,
  F_PSIGDown in 'F_PSIGDown.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
