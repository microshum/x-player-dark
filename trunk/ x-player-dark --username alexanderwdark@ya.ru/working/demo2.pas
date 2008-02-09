unit demo2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xrand, StdCtrls;

type
  TForm1 = class (TForm)
    Button1: TButton;
    Memo1:   TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  R: TRandom;
  i: integer;
begin
  r := TRandom.Create(3);
  for i := 0 to 2 do
    memo1.Lines.Add(Format('%d', [r.random(3)]));
  memo1.Lines.Add('-----');
end;

end.
