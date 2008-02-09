unit fx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, masks;

type
  TfrmSearch = class (TForm)
    Edit:    TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure searchS(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
  private
    procedure WMMOVEF2(var Message: TMessage); message WM_MOVE;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearch: TfrmSearch;

implementation

uses gui, lit;

{$R *.dfm}

var
  Last: integer = -1;

procedure TfrmSearch.searchS(Sender: TObject);
var
  i, Min: integer;
begin
  if Trim(edit.Text) <> '' then
    begin
    if (Last <> -1) and (Last < playlist.ListBox1.Items.Count - 1) then
      Min := Last + 1
    else
      Min := 0;
    for i := Min to (playlist.ListBox1.Items.Count - 1) do
      if MatchesMask(AnsiUpperCase(playlist.ListBox1.Items[i]), '*' +
        AnsiUpperCase(edit.Text) + '*') then
        begin
        playlist.ListBox1.ItemIndex := i;
        playlist.ListBox1.Selected[i] := True;
        listpos := i;
        playlist.ListBox1.SetFocus;
        Last := i;
        exit;
        end;
    end;
  Last := -1;
end;

procedure TfrmSearch.EditKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = vk_return then
    searchs(Self);
end;

procedure TfrmSearch.WMMOVEF2(var Message: TMessage);
begin
  if (ABS(frmMp3.Top + frmMp3.Height - FrmSearch.Top) < 15) and
    (ABS(frmMp3.Left - frmSearch.Left) < frmSearch.Width) then
    frmMp3.DockITFX;
end;

procedure TfrmSearch.Button2Click(Sender: TObject);
begin
  frmSearch.Close;
end;

end.
