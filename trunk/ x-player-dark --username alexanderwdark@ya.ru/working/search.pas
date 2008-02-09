unit search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, masks, bass, ComCtrls, ExtCtrls, inifiles;

var
  EchoActive, EQActive, GActive: boolean;

type
  TForm2 = class (TForm)
    EOF:     TButton;
    EQOff:   TButton;
    Button3: TButton;
    Bevel1:  TBevel;
    e1:      TScrollBar;
    e2:      TScrollBar;
    e3:      TScrollBar;
    e4:      TScrollBar;
    e5:      TScrollBar;
    e6:      TScrollBar;
    e7:      TScrollBar;
    e8:      TScrollBar;
    e9:      TScrollBar;
    e10:     TScrollBar;
    eqON:    TButton;
    eon:     TButton;
    gain:    TScrollBar;
    edge:    TScrollBar;
    center:  TScrollBar;
    band:    TScrollBar;
    Button1: TButton;
    Button2: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    cutoff:  TScrollBar;
    Button4: TButton;
    Button5: TButton;
    Bevel2:  TBevel;
    wave:    TScrollBar;
    wtype:   TScrollBar;
    goff:    TButton;
    gon:     TButton;
    procedure eofClick(Sender: TObject);
    procedure e1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure EQOffClick(Sender: TObject);
    procedure e2Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e3Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e4Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e5Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e6Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e7Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e8Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure Button3Click(Sender: TObject);
    procedure e9Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure e10Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure eqONClick(Sender: TObject);
    procedure EchoOn(Sender: TObject);
    procedure gainScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure edgeScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure centerScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure bandScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure gonClick(Sender: TObject);
    procedure goffClick(Sender: TObject);
    procedure waveScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure wtypeScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
  private
    procedure WMMOVEF2(var Message: TMessage); message WM_MOVE;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses gui;

{$R *.dfm}


procedure TForm2.WMMOVEF2(var Message: TMessage);
begin
  if (ABS(form1.Top + form1.Height - Form2.Top) < 15) and
    (ABS(form1.Left - form2.Left) < form2.Width) then
    form1.DockIT;
end;

var
  EFX, EQ1, EQ2, EQ3, EQ4, EQ5, EQ6, EQ7, EQ8, EQ9, EQ10, FXG: HFX;

var
  Echo: BASS_FXDISTORTION;

var
  EQ: BASS_FXPARAMEQ;

var
  gargle: BASS_FXGARGLE;

procedure TForm2.eofClick(Sender: TObject);
begin
  EOn.Enabled := True;
  EOF.Enabled := False;
  echoactive  := False;
  BASS_ChannelRemoveFX(PlayStream, EFX);
end;

procedure TForm2.e1Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 1;
  eq.fCenter    := 80;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.EQOffClick(Sender: TObject);
begin
  EqOn.Enabled  := True;
  Eqoff.Enabled := False;
  eqactive      := False;
  BASS_ChannelRemoveFX(PlayStream, Eq1);
end;

procedure TForm2.e2Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 2;
  eq.fCenter    := 170;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e3Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 3;
  eq.fCenter    := 310;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e4Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 4;
  eq.fCenter    := 600;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e5Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 5;
  eq.fCenter    := 1000;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e6Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 6;
  eq.fCenter    := 3000;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e7Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 7;
  eq.fCenter    := 6000;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e8Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 8;
  eq.fCenter    := 9000;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);

end;

procedure TForm2.Button3Click(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 10 do
    TScrollBar(FindComponent('e' + IntToStr(i))).Position := 0;
  if not EqActive then
    exit;
  EqOffClick(Self);
  EqOnClick(Self);
end;

procedure TForm2.e9Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 9;
  eq.fCenter    := 12000;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.e10Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    Exit;
  EQ.fBandwidth := 10;
  eq.fCenter    := 14000;
  eq.fGain      := -ScrollPos;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.eqONClick(Sender: TObject);
begin
  EqOn.Enabled := False;
  Eqoff.Enabled := True;
  eqactive := True;
  EQ1      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ2      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ3      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ4      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ5      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ6      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ7      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ8      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ9      := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  EQ10     := BASS_ChannelSetFX(PlayStream, BASS_FX_PARAMEQ);
  ///////////////////////////////////////////
  EQ.fBandwidth := 1;
  eq.fCenter := 80;
  eq.fGain := -e1.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 2;
  eq.fCenter    := 170;
  eq.fGain      := -e2.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 3;
  eq.fCenter    := 310;
  eq.fGain      := -e3.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 4;
  eq.fCenter    := 600;
  eq.fGain      := -e4.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 5;
  eq.fCenter    := 1000;
  eq.fGain      := -e5.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 6;
  eq.fCenter    := 3000;
  eq.fGain      := -e6.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 7;
  eq.fCenter    := 6000;
  eq.fGain      := -e7.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 8;
  eq.fCenter    := 9000;
  eq.fGain      := -e8.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 9;
  eq.fCenter    := 12000;
  eq.fGain      := -e9.position;
  BASS_FXSetParameters(EQ1, @EQ);
  EQ.fBandwidth := 10;
  eq.fCenter    := 14000;
  eq.fGain      := -e10.position;
  BASS_FXSetParameters(EQ1, @EQ);
end;

procedure TForm2.EchoOn(Sender: TObject);
begin
  EOn.Enabled := False;
  EOF.Enabled := True;
  echoactive := True;
  EFX := BASS_ChannelSetFX(PlayStream, BASS_FX_DISTORTION);
  echo.fGain := gain.Position;
  echo.fEdge := edge.Position;
  echo.fPostEQCenterFrequency := center.Position;
  echo.fPostEQBandwidth := band.Position;
  echo.fPreLowpassCutoff := cutoff.Position;
  BASS_FXSetParameters(EFX, @Echo);
end;

procedure TForm2.gainScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if scrollcode <> scEndScroll then
    Exit;
  echo.fGain := ScrollPos;
  echo.fEdge := edge.Position;
  echo.fPostEQCenterFrequency := center.Position;
  echo.fPostEQBandwidth := band.Position;
  echo.fPreLowpassCutoff := cutoff.Position;
  BASS_FXSetParameters(EFX, @Echo);
end;

procedure TForm2.edgeScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if scrollcode <> scEndScroll then
    Exit;
  echo.fGain := gain.Position;
  echo.fEdge := ScrollPos;
  echo.fPostEQCenterFrequency := center.Position;
  echo.fPostEQBandwidth := band.Position;
  echo.fPreLowpassCutoff := cutoff.Position;
  BASS_FXSetParameters(EFX, @Echo);

end;

procedure TForm2.centerScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if scrollcode <> scEndScroll then
    Exit;
  echo.fGain := gain.Position;
  echo.fEdge := edge.Position;
  echo.fPostEQCenterFrequency := ScrollPos;
  echo.fPostEQBandwidth := band.Position;
  echo.fPreLowpassCutoff := cutoff.Position;
  BASS_FXSetParameters(EFX, @Echo);
end;

procedure TForm2.bandScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if scrollcode <> scEndScroll then
    Exit;
  echo.fGain := gain.Position;
  echo.fEdge := edge.Position;
  echo.fPostEQCenterFrequency := center.Position;
  echo.fPostEQBandwidth := ScrollPos;
  echo.fPreLowpassCutoff := cutoff.Position;
  BASS_FXSetParameters(EFX, @Echo);

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  ini: TIniFile;
begin
  savedialog.Filter := 'EQ Preset|*.xp';
  if (savedialog.Execute) then
    begin
    ini := tinifile.Create(ChangeFileExt(savedialog.FileName, '.xp'));
    ini.WriteString('Comment', 'Name', 'DarkSoft XPlayer Eq Preset "' +
      ExtractFileName(opendialog.FileName) + '"');
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

procedure TForm2.Button2Click(Sender: TObject);
var
  ini: TIniFile;
begin
  opendialog.Filter := 'EQ Preset|*.xp';
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
      EqOffClick(Self);
      EqOnClick(Self);
      end;
    end;

end;

procedure TForm2.Button4Click(Sender: TObject);
var
  ini: TIniFile;
begin
  savedialog.Filter := 'Distorition Preset|*.dxp';
  if (savedialog.Execute) then
    begin
    ini := tinifile.Create(ChangeFileExt(savedialog.FileName, '.dxp'));
    ini.WriteString('Comment', 'Name', 'DarkSoft XPlayer Distorition Preset "' +
      ExtractFileName(opendialog.FileName) + '"');
    ini.WriteString('Comment', 'DateStamp', DateToStr(Date));
    ini.WriteInteger('Distorition', 'Gain', gain.Position);
    ini.WriteInteger('Distorition', 'Edge', edge.Position);
    ini.WriteInteger('Distorition', 'PostEQBandwidth', band.Position);
    ini.WriteInteger('Distorition', 'PostEQCenterFrequency', center.Position);
    ini.WriteInteger('Distorition', 'PreLowpassCutoff', cutoff.Position);
    ini.Free;
    end;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  ini: TIniFile;
begin
  opendialog.Filter := 'Distorition Preset|*.dxp';
  if (opendialog.Execute) then
    begin
    gain.Position   := ini.ReadInteger('Distorition', 'Gain', gain.Position);
    edge.Position   := ini.ReadInteger('Distorition', 'Edge', edge.Position);
    band.Position   := ini.ReadInteger('Distorition', 'PostEQBandwidth', band.Position);
    center.Position := ini.ReadInteger('Distorition', 'PostEQCenterFrequency',
      center.Position);
    cutoff.Position := ini.ReadInteger('Distorition', 'PreLowpassCutoff',
      cutoff.Position);
    ini.Free;
    end;
end;

procedure TForm2.gonClick(Sender: TObject);
begin
  gactive := True;
  gon.Enabled := False;
  goff.Enabled := True;
  FXG := BASS_ChannelSetFX(PlayStream, BASS_FX_GARGLE);
  BASS_FXSetParameters(FXG, @Gargle);
end;

procedure TForm2.goffClick(Sender: TObject);
begin
  gactive      := False;
  gon.Enabled  := True;
  goff.Enabled := False;
  BASS_ChannelRemoveFX(PlayStream, FXG);
end;

procedure TForm2.waveScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    exit;
  gargle.dwWaveShape := wtype.Position;
  gargle.dwRateHz    := ScrollPos;
  BASS_FXSetParameters(FXG, @Gargle);
end;

procedure TForm2.wtypeScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if ScrollCode <> scEndScroll then
    exit;
  if ScrollCode <> scEndScroll then
    exit;
  gargle.dwWaveShape := ScrollPos;
  gargle.dwRateHz    := wave.Position;
  BASS_FXSetParameters(FXG, @Gargle);

end;

end.
