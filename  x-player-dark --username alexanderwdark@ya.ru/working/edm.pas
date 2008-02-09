unit edm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cfg, ovcbase, ovceditu, ovcedit;

type
  Tedroot = class (TForm)
    edit:    TOVCTextFileEditor;
    cb:      TControlBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button8: TButton;
    Button12: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  edroot: Tedroot;

implementation

{$R *.dfm}

procedure Tedroot.Button1Click(Sender: TObject);
var
  s: string;
begin
edit.InsertString((Sender as TButton).Caption);
//  s := edit.Lines[edit.caretpos.y];
//  insert((Sender as TButton).Caption, s, edit.caretpos.X + 1);
//  edit.Lines[edit.CaretPos.Y] := s;
end;

procedure Tedroot.FormCreate(Sender: TObject);
var
  i:   integer;
  ini: TCfg;
begin
  for i := 0 to cb.ControlCount - 1 do
    begin
    ini := TCfg.Create(extractfilepath(application.ExeName) + 'options.ini');
    cb.Controls[i].Top := ini.ReadInteger('Control_' + IntToStr(i) +
      '_Top', cb.Controls[i].Top);
    cb.Controls[i].Left := ini.ReadInteger('Control_' + IntToStr(i) +
      '_Left', cb.Controls[i].Left);
    ini.Free;
    end;
  if fileexists(extractfilepath(application.ExeName) + 'voice.cfg') then
    edit.LoadFromFile(extractfilepath(application.ExeName) + 'voice.cfg')
  else
    edit.SaveToFile(extractfilepath(application.ExeName) + 'voice.cfg');
edit.Modified:=false;
end;

procedure Tedroot.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:   integer;
  ini: TCfg;
begin
if edit.Modified then
  if messagedlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = idYes then
    edit.SaveToFile(extractfilepath(application.ExeName) + 'voice.cfg');
  for i := 0 to cb.ControlCount - 1 do
    begin
    ini := TCfg.Create(extractfilepath(application.ExeName) + 'options.ini');
    ini.WriteInteger('Control_' + IntToStr(i) + '_Top', cb.Controls[i].Top);
    ini.WriteInteger('Control_' + IntToStr(i) + '_Left', cb.Controls[i].Left);
    ini.Free;
    end;
end;

end.
