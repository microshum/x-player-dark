unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tsimplyabout = class (TForm)
    Label25: TLabel;
    pb:      TPaintBox;
    Memo2:   TMemo;
    Label1:  TLabel;
    procedure Label25MouseEnter(Sender: TObject);
    procedure Label25MouseLeave(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure pbPaint(Sender: TObject);
    procedure Memo2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  simplyabout: Tsimplyabout;

implementation

{$R *.dfm}

procedure Tsimplyabout.Label25MouseEnter(Sender: TObject);
begin
  (Sender as tlabel).Font.Color := clRed;
end;

procedure Tsimplyabout.Label25MouseLeave(Sender: TObject);
begin
  (Sender as tlabel).Font.Color := clBlack;
end;

procedure Tsimplyabout.Label25Click(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure Tsimplyabout.pbPaint(Sender: TObject);
var
  i:    integer;
  x, y: integer;
const
  str = 'X-P.L.A.Y.E.R';
begin
  x := 80;
  y := 1;
  pb.Canvas.Font.Style := pb.Canvas.Font.Style + [fsBold];
  pb.Canvas.Font.Name := 'Arial';
  pb.Canvas.Font.Size := 36;
  pb.Canvas.Font.Charset := RUSSIAN_CHARSET;
  for i := 1 to length(str) do
    begin
    pb.Canvas.Font.Color := Random(maxlongint);
    pb.Canvas.TextOut(x, y, str[i]);
    Inc(x, pb.Canvas.TextWidth(str[i]));
    end;
end;

procedure Tsimplyabout.Memo2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  HideCaret(memo2.Handle);
end;

procedure Tsimplyabout.FormActivate(Sender: TObject);
begin
  HideCaret(memo2.Handle);
end;

end.
