unit F_PSIGDown;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
    // Descarregar o driver SIG2000
    PostMessage(FindWindow(nil, 'Driver Sig2000 Versão 1.0, Desenvolvido por LOGICBOX AUTOMAÇÃO'), WM_CLOSE,0,0);
    PostMessage(FindWindow(nil, 'PSIG2000'), WM_CLOSE,0,0);
    PostMessage(FindWindow(nil, 'PSIG2000.EXE'), WM_CLOSE,0,0);
    Close;
end;

end.
