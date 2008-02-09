unit demo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, x_arc, StdCtrls, ExtCtrls;

type
  TForm1 = class (TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ListBox1: TListBox;
    Edit1:  TEdit;
    Button7: TButton;
    destdir: TEdit;
    GroupBox1: TGroupBox;
    od:     TOpenDialog;
    sd:     TSaveDialog;
    XARC1:  TXARC;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
begin
  if not sd.Execute then
    exit;
  xarc1.CreateArc(sd.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not od.Execute then
    exit;
  xarc1.OpenArc(od.FileName);

end;

procedure TForm1.Button3Click(Sender: TObject);

begin
  listbox1.Items.Clear;
  listbox1.Items.BeginUpdate;
  listbox1.Items.AddStrings(xarc1.ListArc);
{if xarc1.AFindFirst('*.*') then begin
repeat
listbox1.Items.Add(Format('%s',[xarc1.found_rec.name]));
until not xarc1.AFindNext;
end;}
  listbox1.Items.EndUpdate;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  xarc1.deleteall(edit1.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  xarc1.AddAll(edit1.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  xarc1.compact;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  xarc1.CloseArc;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  xarc1.ExtractAll(edit1.Text, destdir.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  buf: PChar;
begin
  buf := stralloc(16384);
  Windows.GetTempPath(16384, buf);
  destdir.Text := buf;
  strdispose(buf);
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  if (listbox1.ItemIndex = -1) or (listbox1.Items.Count = 0) then
    exit;
  edit1.Text := listbox1.Items[listbox1.ItemIndex];
end;

var
  state: (H, V) = H;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  P: TPoint;
begin
  p.X := mouse.CursorPos.X;
  p.Y := mouse.CursorPos.Y;
  if state = H then
    begin
    if p.X > 0 then
      Dec(p.x)
    else
      p.x := screen.Width;
    state := V;
    end
  else
    begin
    if p.Y > 0 then
      Dec(p.y)
    else
      p.y := screen.Height;
    state := H;
    end;
  mouse.CursorPos := p;
end;

end.
