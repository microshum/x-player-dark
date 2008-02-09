unit Unit1;

interface

uses
  voiceapi, inifiles, cfg, StdCtrls, Controls, Classes, Forms, SysUtils,
  ExtCtrls, ComCtrls, Graphics, speech, Dialogs;

type
  TForm1 = class (TForm)
    timer:   TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ComboBox1: TComboBox;
    memo1:   TMemo;
    ti:      TTrackBar;
    Button1: TButton;
    Button2: TButton;
    red:     TCheckBox;
    Edit1:   TEdit;
    Edit2:   TEdit;
    Edit3:   TEdit;
    Edit4:   TEdit;
    Edit5:   TEdit;
    Edit6:   TEdit;
    Label1:  TLabel;
    Label2:  TLabel;
    Label3:  TLabel;
    Label4:  TLabel;
    Label5:  TLabel;
    Label6:  TLabel;
    Edit7:   TEdit;
    Label7:  TLabel;
    TabSheet3: TTabSheet;
    Button3: TButton;
    Button4: TButton;
    Label8:  TLabel;
    Label9:  TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    disable: TCheckBox;
    Button9: TButton;
    pit:     TEdit;
    spd:     TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpeakClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tiChange(Sender: TObject);
    procedure redClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
var
  S:   TStrings;
  cfg: TCFG;
begin
  pagecontrol1.ActivePageIndex := 0;
  S := TStringList.Create;
  CreateAndEnum(S);
  combobox1.Items.AddStrings(S);
  S.Free;
  if combobox1.Items.Count > 0 then
    begin
    ///////
    cfg := TCFG.Create(ExtractFilePath(application.ExeName) + 'options.ini');
    combobox1.ItemIndex := cfg.ReadInteger('VoiceEngine', 0);
    ComboBox1Change(self);
    button3.Click;
    Disable.Checked := not cfg.ReadBool('CanSay', False);
    ti.Position := Length(memo1.Text) * cfg.ReadInteger('SpeakChar', 0);
    spd.Text := IntToStr(cfg.ReadInteger('ttsSpeed', StrToInt(spd.Text)));
    pit.Text := IntToStr(cfg.ReadInteger('ttsPitch', StrToInt(pit.Text)));
    button4.Click;
    cfg.Free;

    ///////
    end
  else
    begin
    combobox1.Enabled := False;
    button1.Enabled   := False;
    disable.Checked   := True;
    disable.Enabled   := False;
    end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  mi: PTTSModeInfo;
begin
  if EngineInit(combobox1.ItemIndex) then
    begin
    mi := getmodeinfo;
    edit1.Text := mi.szMfgName;
    edit2.Text := mi.szProductName;
    edit3.Text := mi.szModeName;
    edit4.Text := mi.Language.szDialect;
    edit5.Text := mi.szSpeaker;
    edit6.Text := mi.szStyle;
    edit7.Text := IntToStr(mi.wAge);
    button3.Click;
    end;
end;

procedure TForm1.SpeakClick(Sender: TObject);
begin
  button1.Enabled := False;
  memo1.Color     := clYellow;
  timer.Enabled   := True;
  Say(memo1.Text);
  button1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  cfg: TCfg;
begin
  cfg := TCFG.Create(ExtractFilePath(application.ExeName) + 'options.ini');
  cfg.WriteInteger('VoiceEngine', combobox1.ItemIndex);
  if combobox1.Items.Count > 0 then
    begin
    cfg.WriteBool('CanSay', not Disable.Checked);
    cfg.WriteInteger('SpeakChar', (ti.Position) div Length(Memo1.Text));
    cfg.WriteInteger('ttsSpeed', StrToInt(spd.Text));
    cfg.WriteInteger('ttsPitch', StrToInt(pit.Text));
    end
  else
    cfg.WriteBool('CanSay', False);
  cfg.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  voiceapi.StopSpeak;
  memo1.Color   := clRed;
  timer.Enabled := False;
end;

procedure TForm1.tiChange(Sender: TObject);
begin
  timer.Interval := ti.Position;
end;

procedure TForm1.redClick(Sender: TObject);
begin
  memo1.ReadOnly := not red.Checked;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  A: TMyAttr;
begin
  GetAttributes(A);
  spd.Text := IntToStr(a.speed);
  pit.Text := IntToStr(a.pitch);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  A: TMyAttr;
begin
  GetAttributes(A);
  a.speed := StrToInt(spd.Text);
  a.pitch := StrToInt(pit.Text);
  SetAttributes(A);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  voiceapi.GeneralDialog(handle, 'Главное');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  voiceapi.LexiconDialog(handle, 'Лексика');
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  voiceapi.TranslateDialog(handle, 'Перевод');
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  voiceapi.AboutDialog(handle, 'Инфо');
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  ShowMessage('С помощью данного теста вы можете настроить необходимую задержку произношения.'#13#10'Подберите позицию движка так, чтобы чтение завершалось чуть раньше появления красного экрана.');
end;

end.
