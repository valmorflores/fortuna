unit ESC13;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    BtFechar: TButton;
    Button1: TButton;
    procedure BtFecharClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

Implementation

{$R *.DFM}

procedure TForm1.BtFecharClick(Sender: TObject);
begin
     Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   I:integer;
   ArqDev:TextFile;
   resp,Comando:String[128];
begin
    Comando := Chr(27)+'.13}';
    AssignFile(ArqDev,'IFSWEDA');
    Rewrite(ArqDev);
    Write(ArqDev,comando);
    CloseFile(ArqDev);
    AssignFile(ArqDev,'IFSWEDA');
    Reset(ArqDev);
    Read(ArqDev,resp);
    CloseFile(ArqDev);
    messagedlg(resp,mtinformation,[mbok],0);
end;

end.
