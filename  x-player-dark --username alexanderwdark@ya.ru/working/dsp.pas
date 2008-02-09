
unit dsp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, BASS, BASS_FX, gui, inifiles, ExtCtrls, Menus;

var
  EQActive: boolean;

var
  FlangerActive: boolean = False;
  EchoActive:    boolean = False;

var
  normalfreq: cardinal = 0;

type
  TfrmDSP = class (TForm)
    GroupBox: TGroupBox;
    chkEqualizer: TCheckBox;
    e1:      TScrollBar;
    e2:      TScrollBar;
    e3:      TScrollBar;
    tbDXRate: TTrackBar;
    lblDX:   TLabel;
    e4:      TScrollBar;
    e8:      TScrollBar;
    e7:      TScrollBar;
    e6:      TScrollBar;
    e5:      TScrollBar;
    e10:     TScrollBar;
    e9:      TScrollBar;
    Button1: TButton;
    Button2: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Button3: TButton;
    Button4: TButton;
    Bevel1:  TBevel;
    lmenu:   TPopupMenu;
    N1:      TMenuItem;
    preset:  TMenuItem;
    smenu:   TPopupMenu;
    N2:      TMenuItem;
    N3:      TMenuItem;
    procedure INITX;
    procedure lblDXClick(Sender: TObject);
    procedure tbDXRateChange(Sender: TObject);
    procedure chkEqualizerClick(Sender: TObject);
    procedure e1Change(Sender: TObject);
    procedure e2Change(Sender: TObject);
    procedure e3Change(Sender: TObject);
    procedure UpdateEQ(b, pos: integer);
    procedure FormDestroy(Sender: TObject);
    procedure e4Change(Sender: TObject);
    procedure e5Change(Sender: TObject);
    procedure e6Change(Sender: TObject);
    procedure e7Change(Sender: TObject);
    procedure e8Change(Sender: TObject);
    procedure e9Change(Sender: TObject);
    procedure e10Change(Sender: TObject);
    procedure save(Sender: TObject);
    procedure Open(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LoadPreset(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ListPresets;

  private

    freq: DWORD;
    eq:   BASS_FX_DSPPEAKEQ;
    vol:  DWORD;
    pan:  integer;
  public

  end;

var
  frmDSP: TfrmDSP;

const
  maxp: float = 1.3;
  minp: float = 0.7;

implementation

const
  EQArray: array[1..9] of integer =
    (170, 310, 600, 1000, 3000, 6000, 12000, 14000, 16000);

{$R *.DFM}


procedure TfrmDSP.INITX;
begin
  BASS_ChannelGetAttributes(playstream, freq, vol, pan);
  normalfreq := mainfreq;
  with tbDXRate do
    begin
    max      := round(normalfreq * maxp);
    min      := round(normalfreq * minp);
    pagesize := round(normalfreq * 0.01);
    end;
  lblDX.OnClick(self);
end;

procedure TfrmDSP.lblDXClick(Sender: TObject);
begin
  tbDXRate.Position := freq;
  tbDXRate.OnChange(self);
end;

procedure TfrmDSP.tbDXRateChange(Sender: TObject);
begin
  if BASS_ChannelIsActive(playstream) = 0 then
    Exit;

  BASS_ChannelSetAttributes(playstream, tbDXRate.position, -1, -101);

  lblDX.Caption := 'Частота = ' + IntToStr(tbDXRate.position) + 'Hz';
  if eqactive then
    begin
    e1.OnChange(Self);
    e2.OnChange(Self);
    e3.OnChange(Self);
    e4.OnChange(Self);
    e5.OnChange(Self);
    e6.OnChange(Self);
    e7.OnChange(Self);
    e8.OnChange(Self);
    e9.OnChange(Self);
    e10.OnChange(Self);
    end;
end;

procedure TfrmDSP.chkEqualizerClick(Sender: TObject);
begin
  eqactive := chkEqualizer.Checked;
  if eqactive then
    begin
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    BASS_FX_DSP_Set(playstream, BASS_FX_DSPFX_PEAKEQ, 0);
    e1.OnChange(Self);
    e2.OnChange(Self);
    e3.OnChange(Self);
    e4.OnChange(Self);
    e5.OnChange(Self);
    e6.OnChange(Self);
    e7.OnChange(Self);
    e8.OnChange(Self);
    e9.OnChange(Self);
    e10.OnChange(Self);
    end
  else
    begin
    BASS_FX_DSP_Remove(playstream, BASS_FX_DSPFX_PEAKEQ);
    ;
    end;
end;

procedure TfrmDSP.e1Change(Sender: TObject);
begin
  UpdateEQ(0, e1.Position);
end;

procedure TfrmDSP.e2Change(Sender: TObject);
begin
  UpdateEQ(1, e2.Position);
end;

procedure TfrmDSP.e3Change(Sender: TObject);
begin
  UpdateEQ(2, E3.Position);
end;




procedure TfrmDSP.UpdateEQ(b, pos: integer);
var
  f: DWord;
begin
  BASS_ChannelGetAttributes(playstream, f, vol, pan);
  EQ.lFreq := f;
  EQ.FQ    := 0;

  if (b = 0) then
    begin
    EQ.fBandwidth := 2.5;
    EQ.FQ      := 0;
    EQ.fGain   := 0;
    EQ.lBand   := 0;
    EQ.fCenter := 125;
    end
  else
    begin
    EQ.fBandwidth := 0;
    EQ.lBand      := b;
    EQ.fCenter    := EQArray[b];
    end;
  eq.fGain := (-pos);
  BASS_FX_DSP_SetParameters(playstream, BASS_FX_DSPFX_PEAKEQ, @eq);
end;



procedure TfrmDSP.FormDestroy(Sender: TObject);
begin
  //!!!!!!!!!!!  bass_fx_free;
end;

procedure TfrmDSP.e4Change(Sender: TObject);
begin
  UpdateEQ(3, E4.Position);
end;

procedure TfrmDSP.e5Change(Sender: TObject);
begin
  UpdateEQ(4, E5.Position);
end;

procedure TfrmDSP.e6Change(Sender: TObject);
begin
  UpdateEQ(5, E6.Position);
end;

procedure TfrmDSP.e7Change(Sender: TObject);
begin
  UpdateEQ(6, E7.Position);
end;

procedure TfrmDSP.e8Change(Sender: TObject);
begin
  UpdateEQ(7, E8.Position);
end;

procedure TfrmDSP.e9Change(Sender: TObject);
begin
  UpdateEQ(8, E9.Position);
end;

procedure TfrmDSP.e10Change(Sender: TObject);
begin
  UpdateEQ(9, E10.Position);
end;

procedure TfrmDSP.save(Sender: TObject);
var
  ini: TIniFile;
begin
  savedialog.FileName   := mypath + 'default.xp';
  savedialog.DefaultExt := '.xp';
  savedialog.Filter     := 'EQ Preset|*.xp';
  if (savedialog.Execute) then
    begin
    ini := tinifile.Create(ChangeFileExt(savedialog.FileName, '.xp'));
    ini.WriteString('Comment', 'Name', 'Dark Software XAmp Eq Preset "' +
      ExtractFileName(savedialog.FileName) + '"');
    ini.WriteString('Comment', 'DateStamp', DateToStr(Date));
    ini.WriteInteger('EQ', '1', e1.Position);
    ini.WriteInteger('EQ', '2', e2.Position);
    ini.WriteInteger('EQ', '3', e3.Position);
    ini.WriteInteger('EQ', '4', e4.Position);
    ini.WriteInteger('EQ', '5', e5.Position);
    ini.WriteInteger('EQ', '6', e6.Position);
    ini.WriteInteger('EQ', '7', e7.Position);
    ini.WriteInteger('EQ', '8', e8.Position);
    ini.WriteInteger('EQ', '9', e9.Position);
    ini.WriteInteger('EQ', '10', e10.Position);
    ini.Free;
    end;

end;

procedure TfrmDSP.Open(Sender: TObject);
var
  ini: TIniFile;
begin
  opendialog.FileName   := mypath + 'default.xp';
  opendialog.DefaultExt := '.xp';
  opendialog.Filter     := 'EQ Preset|*.xp';
  if opendialog.Execute then
    begin
    ini := tinifile.Create(opendialog.FileName);
    e1.Position := ini.ReadInteger('EQ', '1', e1.Position);
    e2.Position := ini.ReadInteger('EQ', '2', e2.Position);
    e3.Position := ini.ReadInteger('EQ', '3', e3.Position);
    e4.Position := ini.ReadInteger('EQ', '4', e4.Position);
    e5.Position := ini.ReadInteger('EQ', '5', e5.Position);
    e6.Position := ini.ReadInteger('EQ', '6', e6.Position);
    e7.Position := ini.ReadInteger('EQ', '7', e7.Position);
    e8.Position := ini.ReadInteger('EQ', '8', e8.Position);
    e9.Position := ini.ReadInteger('EQ', '9', e9.Position);
    e10.Position := ini.ReadInteger('EQ', '10', e10.Position);
    ini.Free;
    if eqactive then
      begin
      e1.OnChange(Self);
      e2.OnChange(Self);
      e3.OnChange(Self);
      e4.OnChange(Self);
      e5.OnChange(Self);
      e6.OnChange(Self);
      e7.OnChange(Self);
      e8.OnChange(Self);
      e9.OnChange(Self);
      e10.OnChange(Self);
      end;
    end;

end;

procedure TfrmDSP.Button3Click(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 10 do
    TScrollBar(FindComponent(Format('e%d', [i]))).Position := 0;
  if eqactive then
    begin
    e1.OnChange(Self);
    e2.OnChange(Self);
    e3.OnChange(Self);
    e4.OnChange(Self);
    e5.OnChange(Self);
    e6.OnChange(Self);
    e7.OnChange(Self);
    e8.OnChange(Self);
    e9.OnChange(Self);
    e10.OnChange(Self);
    end;
end;

procedure TfrmDSP.Button4Click(Sender: TObject);
begin
  tbDXRate.Position := normalfreq;
  tbDXRateChange(Self);
end;

procedure TfrmDSP.Button1Click(Sender: TObject);
begin
  lmenu.Popup(frmdsp.Left + button1.Left, frmdsp.Top + button1.Top);
end;

procedure TfrmDSP.LoadPreset(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := tinifile.Create(mypath + 'EQ\' + (Sender as TMenuItem).Caption + '.xp');
  e1.Position := ini.ReadInteger('EQ', '1', e1.Position);
  e2.Position := ini.ReadInteger('EQ', '2', e2.Position);
  e3.Position := ini.ReadInteger('EQ', '3', e3.Position);
  e4.Position := ini.ReadInteger('EQ', '4', e4.Position);
  e5.Position := ini.ReadInteger('EQ', '5', e5.Position);
  e6.Position := ini.ReadInteger('EQ', '6', e6.Position);
  e7.Position := ini.ReadInteger('EQ', '7', e7.Position);
  e8.Position := ini.ReadInteger('EQ', '8', e8.Position);
  e9.Position := ini.ReadInteger('EQ', '9', e9.Position);
  e10.Position := ini.ReadInteger('EQ', '10', e10.Position);
  ini.Free;
  if eqactive then
    begin
    e1.OnChange(Self);
    e2.OnChange(Self);
    e3.OnChange(Self);
    e4.OnChange(Self);
    e5.OnChange(Self);
    e6.OnChange(Self);
    e7.OnChange(Self);
    e8.OnChange(Self);
    e9.OnChange(Self);
    e10.OnChange(Self);
    end;
end;

procedure TfrmDSP.FormCreate(Sender: TObject);
begin
  if not directoryexists(mypath + 'EQ') then
    createdir(mypath + 'EQ');
  listpresets;
end;

procedure TfrmDSP.Button2Click(Sender: TObject);
begin
  smenu.Popup(frmdsp.Left + button2.Left, frmdsp.Top + button2.Top);
end;

procedure TfrmDSP.N3Click(Sender: TObject);
var
  ini:  TIniFile;
  Name: string;
begin
  Name := trim(inputbox('Затотовка', 'Имя', ''));
  if Name <> '' then
    begin
    ini := tinifile.Create(mypath + 'EQ\' + Name + '.xp');
    ini.WriteString('Comment', 'Name', 'Dark Software XAmp Eq Preset "' +
      Name + '.xp' + '"');
    ini.WriteString('Comment', 'DateStamp', DateToStr(Date));
    ini.WriteInteger('EQ', '1', e1.Position);
    ini.WriteInteger('EQ', '2', e2.Position);
    ini.WriteInteger('EQ', '3', e3.Position);
    ini.WriteInteger('EQ', '4', e4.Position);
    ini.WriteInteger('EQ', '5', e5.Position);
    ini.WriteInteger('EQ', '6', e6.Position);
    ini.WriteInteger('EQ', '7', e7.Position);
    ini.WriteInteger('EQ', '8', e8.Position);
    ini.WriteInteger('EQ', '9', e9.Position);
    ini.WriteInteger('EQ', '10', e10.Position);
    ini.Free;
    listpresets;
    end;
end;

procedure TFrmDsp.ListPresets;
var
  S: TSearchRec;
  m: TMenuitem;
begin
  preset.Clear;
  if findfirst(mypath + 'EQ\*.xp', faAnyFile + faArchive + faHidden +
    faSysFile + faReadOnly, s) = 0 then
    repeat
      m := Tmenuitem.Create(preset);
      m.Caption := ExtractFileName(ChangeFileExt(s.Name, ''));
      m.OnClick := LoadPreset;
      preset.Add(m);
    until findnext(s) <> 0;
end;


end.
