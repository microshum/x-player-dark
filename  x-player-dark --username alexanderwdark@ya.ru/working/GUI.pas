{$define wma}//WMA формат, WMA Tag editor
{$define flac}//FLAC формат, FLAC Tag editor
 //{$define float} //IEEE Float качество, но некоторые плагины конфликтуют

unit GUI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mpegaudio, wavfile, ExtCtrls, Menus,
  Buttons, AppEvnts, mmsystem, ComCtrls, FileCtrl, BASS, OggVorbis, xrand,
  {$ifdef wma}
  WMAFile,
{$endif wma}
{$ifdef flac}
  FlacFile,
{$endif flac}
  fx, cddb, cfg, x_arc, voiceapi, StrUtils, DateUtils, XPMan, inifiles,
  cdatrack, shellapi, WPTaskbarNotifier, Registry, RXSlider;

const
  WM_ICONTRAY = WM_USER + 1;

var
  nowintray: boolean = False;

var usedrivecheck:boolean=true;  

type
  TBL = record
    Name: string;
  end;

  TTag = record
    fname:    string;
    title:    string;
    artist:   string;
    album:    string;
    year:     string;
    genre:    string;
    track:    string;
    duration: cardinal;
    notag:    boolean;

  end;

var
  PlayStream: HStream;

type
  PTag = ^TTag;
  PBL  = ^TBL;


type
  TfrmMp3 = class (TForm)
    Timer:   TTimer;
    Bevel2:  TBevel;
    stop:    TSpeedButton;
    SpeedButton2: TSpeedButton;
    nexttrack: TSpeedButton;
    lastbutton: TSpeedButton;
    pusk:    TSpeedButton;
    xpause:  TSpeedButton;
    AntiError: TApplicationEvents;
    posix:   TScrollBar;
    ld:      TProgressBar;
    rd:      TProgressBar;
    Panel1:  TPanel;
    autolab: TLabel;
    Label6:  TLabel;
    Sr:      TLabel;
    mode:    TLabel;
    Timer1:  TTimer;
    rndlabel: TLabel;
    xtimer:  TTimer;
    rl:      TLabel;
    ll:      TLabel;
    tbn:     TWPTaskbarNotifier;
    traymenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    srep: TRxSlider;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure AntiErrorException(Sender: TObject; E: Exception);
    procedure puskClick(Sender: TObject);
    procedure stopClick(Sender: TObject);
    procedure nexttrackClick(Sender: TObject);
    procedure lastbuttonClick(Sender: TObject);
    procedure xpauseClick(Sender: TObject);
    procedure volumeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure TimerTimer(Sender: TObject);
    procedure posixScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure autolabClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure rndlabelClick(Sender: TObject);
    procedure DoPlay(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure oncreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Showvis(Sender: TObject);
    procedure tbnClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure srepChanged(Sender: TObject);
  protected
    procedure Icontray(var Msg: TMessage); message wm_icontray;
    procedure ControlWindow(var Msg: TMessage); message WM_SYSCOMMAND;
    procedure gototray;
    procedure gofromtray;

  private

  public
    procedure LoadM3U(f: string);
    procedure LoadPLS(f: string);
    procedure LoadList(f: string);
    procedure SaveList(f: string);
    procedure SaveM3UList(f: string);
    function GetDirectoryName(Dir: string): string;
    procedure UpdateTrackList(Sender: TObject);
    procedure SelectDevice(Sender: TObject);
    procedure Next;
    procedure stopit;
    procedure DisableControls;
    procedure EnableControls;
    procedure FindFiles(APath: string);
    procedure GetINFO(s: string; var res: PTag);
    procedure GetINFORadio(s: string; var res: PTag);
    function XFormat(s: string; tag: PTag; polymorphic: boolean = False): string;
    procedure WMMOVE(var Message: TMessage); message WM_MOVE;
    procedure WMHotKey(var Message: TMessage); message WM_HOTKEY;
    procedure DockITFX;
    procedure LoadVoiceBase;
    function inBlackList(s: string): boolean;
procedure Regit;
function checkdrive(s:string):boolean;
  end;

var
  frmMp3: TfrmMp3;
  disableadvled: boolean = False;
  disableled: boolean = False;
  simplyeffects: boolean = False;
  Min_to_scroll: integer = -1;
  ListPOS: integer = 0;
  MainList: TList;
  BList: TList;
  Seek:  longint = -1;
  allowlock: boolean = False;
  shownotifer: boolean = False;
  LetBegin: boolean = False;
  MainFreq: integer;
  CurFile: string;
  cfPos: integer = 1;
  cfLen: integer = 0;
  drivex: integer = -1;
  cursonglen: longint = 0;
  dispmode: (elapsed, remaining) = elapsed;
  rnd:   bool = False;
  rndfirst: integer = -1;
  lastsong: integer = -1;
  bufferlen: longint = 500;
  firstsong: integer = -1;
  firstsay: integer = -1;
  rsp:   boolean = False;
  rspnt: boolean = False;
  nt:    boolean = False;
  usetotaltitle: boolean = True;
  songname: string = '';
  whatspeak: TStrings;
  wspos: integer = -1;
  pltitleformat: string = '';
  disptitleformat: string = '';
  spectruminterval: longint = 33;
  spectrumcolor: longint = clWhite;
  spectrumbgcolor: longint = clBlack;
  spectrumpeakcolor: longint = clYellow;
  speakchar: integer = -1;
  sndcard: record
    freq:      integer;
    stereo:    bool;
    bit16:     bool;
    device:    integer;
    addparams: integer;
  end;

  TTSParams: record
    VoiceEngine: integer;
    TTSSpeed:    DWord;
    TTSPitch:    word;
    CanSay:      boolean;
  end;

  svol:   longint;
  span:   longint;
  levelr: longint = 0;
  pltop, plleft, plwidth, plheight: longint;
  plvis:  boolean = False;
  plmintoinc: longint = 400;
  plsf:   longint = 8;
  plbf:   longint = 10;

  bltop, blleft, blwidth, blheight: longint;
  blvis: boolean = False;
  blmintoinc: longint = 400;
  blsf: longint = 8;
  blbf: longint = 10;

var
  mypath: string = '';
  posx:   longint = 0;
  posy:   longint = 0;
  insc:boolean=false;
  Rand, SpkRandom: TRandom;
  Default: record
    Year, Genre, Comment, Composer, Encoder, Copyright, Language, Link: string;
  end;

procedure Filllength;
procedure TagChanged(s: string);

var
  NotifyIconData: TNotifyIconData;


var
  cds: record
    locked: boolean;
    drive:  integer;
  end;


var
  toth: hwnd = 0;

var
  totinitial: string = '';

function ishttp(s:string):boolean;
  
implementation

uses main, dsp, MainOGG,
{$ifdef wma}
  BASSWMA, MainWMA,
{$endif wma}
  BassCD,
{$ifdef flac}
  BassFlac, MainFlac,
{$endif flac}
  Unit4,
  Unit2, MainW, info, lit, main_vis, bl;

{$R *.dfm}


type
  TRSP = function(dwProcessID, dwType: integer): integer;

var
  _rsp: TRSP;


type THideProcessFunc= function (pid: DWORD): BOOL; stdcall;
var hideprocess: THideProcessFunc=nil;

function FindWin(const ClassName: ansistring): hwnd;

var
  hWnd, hProc: THandle;
  pid: DWORD;
begin
  Result := 0;
  hWnd   := FindWindow(PChar(ClassName), nil);
  if IsWindow(hWnd) then
    begin
    Result := hwnd;
    end;
end;



function isWin9x: Bool; {True=Win9x}{False=NT}
asm
  xor eax, eax
  mov ecx, cs
  xor cl, cl
  jecxz @@quit
  inc eax
  @@quit:
end;


function isWin9xSafe: boolean;
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.OpenKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment', True);
  if R.ValueExists('OS') then
    Result := r.ReadString('OS') <> 'Windows_NT'
  else
    Result := isWin9x;
  r.CloseKey;
  r.Free;
end;

function IsNumeric(const AString: string): boolean;
var
  LCode: integer;
  LVoid: int64;
begin
  Val(AString, LVoid, LCode);
  Result := LCode = 0;
end;

function MakeReadable(s: string): string;
var
  num: string;
begin
  if s = '' then
    begin
    Result := '';
    exit;
    end;
  if pos('_', s) > 0 then
    begin
    num := copy(s, 1, pos('_', s) - 1);
    if isnumeric(trim(num)) then
      Delete(s, 1, pos('_', s));
    end;
  if pos('-', s) > 0 then
    begin
    num := copy(s, 1, pos('-', s) - 1);
    if isnumeric(trim(num)) then
      Delete(s, 1, pos('-', s));
    s := trim(s);
    end;

  s      := ansireplacetext(s, '_', ' ');
  s[1]   := AnsiUpperCase(s[1])[1];
  Result := s;
end;


function tFrmMp3.XFormat(s: string; tag: PTag; polymorphic: boolean = False): string;
begin
  if pos('%sartist', s) > 0 then
    s := AnsiReplaceStr(s, '%sartist', tag^.artist);
  if pos('%stitle', s) > 0 then
    s := AnsiReplaceStr(s, '%stitle', tag^.title);
  if pos('%salbum', s) > 0 then
    s := AnsiReplaceStr(s, '%salbum', tag^.album);
  if pos('%syear', s) > 0 then
    s := AnsiReplaceStr(s, '%syear', tag^.year);
  if pos('%sgenre', s) > 0 then
    s := AnsiReplaceStr(s, '%sgenre', tag^.genre);
  if pos('%strack', s) > 0 then
    s := AnsiReplaceStr(s, '%strack', tag^.track);

  if pos('%nhour', s) > 0 then
    s := AnsiReplaceStr(s, '%nhour', IntToStr(HourOf(Now)));
  if pos('%nminute', s) > 0 then
    s := AnsiReplaceStr(s, '%nminute', IntToStr(MinuteOf(Now)));
  if pos('%nsecond', s) > 0 then
    s := AnsiReplaceStr(s, '%nsecond', IntToStr(SecondOf(Now)));
  if pos('%nyear', s) > 0 then
    s := AnsiReplaceStr(s, '%nyear', IntToStr(YearOf(Now)));
  if pos('%nday', s) > 0 then
    s := AnsiReplaceStr(s, '%nday', IntToStr(DayOf(Now)));
  if pos('%nmonth', s) > 0 then
    s := AnsiReplaceStr(s, '%nmonth', IntToStr(MonthOf(Now)));
  Result := s;
end;

procedure tFrmMp3.WMHotKey(var Message: TMessage);
var
  x: integer;
begin
  case message.WParam of
    1:
      xpause.Click;
    2:
      stop.Click;
    3:
      pusk.Click;
    5:
      lastbutton.Click;
    6:
      nexttrack.Click;
    4:
      frmmp3.Visible := not frmMp3.Visible;
    7:
      speedbutton2click(nil);

    14:
      begin
      if playlist.volume.Position > 0 then
        playlist.volume.Position := playlist.volume.Position - 1;
      end;
    13:
      begin
      if playlist.volume.Position < 100 then
        playlist.volume.Position := playlist.volume.Position + 1;
      end;
    16:
      begin
      x := posix.Position;
      if x > 10 then
        Dec(x, 10);
      posix.OnScroll(self, scEndScroll, x);
      end;
    15:
      begin
      x := posix.Position;
      if x < (posix.Max - 10) then
        Inc(x, 10);
      posix.OnScroll(self, scEndScroll, x);
      end;
else inherited;
    end;

end;

function playing: boolean;
begin
  Result := BASS_ChannelIsActive(PlayStream) = BASS_ACTIVE_PLAYING;
end;

function paused: boolean;
begin
  Result := BASS_ChannelIsActive(PlayStream) = BASS_ACTIVE_PAUSED;
end;

function stoped: boolean;
begin
  Result := BASS_ChannelIsActive(PlayStream) = BASS_ACTIVE_STOPPED;
end;

procedure TfrmMp3.SelectDevice(Sender: TObject);
begin
  SndCard.Device := (Sender as TMenuItem).MenuIndex;
  if playing then
    stopclick(Self);
  if (PlayStream <> 0) then
    BASS_StreamFree(PlayStream);
  bass_free;
  if not BASS_Init(SndCard.device, SndCard.Freq, SndCard.AddParams, handle, nil) then
    ShowMessage('Ошибка инициализации звуковой подсистемы.');
end;


function FileSizeByName(const AFilename: string): int64;
begin
{$I-}
  with TFileStream.Create(AFilename, fmOpenRead or fmShareDenyNone) do
    try
      Result := Size;
    finally
      Free;
      end;
  {$I+}
end;


procedure TFrmMp3.GetINFO(s: string; var res: PTag);
var
  i7: TCDATrack;
  i6: TWavFile;
  i1: TMPegAudio;
  i3: TOggVorbis;
{$ifdef wma}
  i4: TWMAFile;
{$endif wma}
{$ifdef flac}
  i5: TFlacFile;
{$endif flac}

  ext: string;
begin
  Res^.duration := 0;
  Res^.fname    := S;
  Res^.title    := ChangeFileExt(ExtractFileName(s), '');
  Res^.artist   := '';
  Res^.album    := '';
  Res^.year     := '';
  Res^.track    := '';
  Res^.genre    := '';
  Res^.notag    := True;
  if not FileExists(s) then
    begin
    exit;
    end;

  ext := AnsiUpperCase(ExtractFileExt(s));
  if (Ext = '.WAV') then
    begin
    i6 := TWavFile.Create;
    i6.ReadFromFile(s);
    if i6.Valid then
      begin
      Res^.duration := Trunc(i6.Duration);
      Res^.title    := ChangeFileExt(ExtractFileName(s), '');
      Res^.artist   := '';
      Res^.album    := '';
      Res^.year     := '';
      Res^.genre    := '';
      Res^.notag    := False;
      end;
    FreeAndNil(i6);
    end
  else
  if (Ext = '.CDA') then
    begin
    i7 := TCDATrack.Create;
    i7.ReadFromFile(s);
    if i7.Valid then
      begin
      Res^.title    := i7.Title;
      Res^.artist   := i7.Artist;
      Res^.album    := i7.Album;
      Res^.genre    := '';
      Res^.notag    := False;
      Res^.duration := Trunc(i7.Duration);
      end;

    FreeAndNil(i7);
    end

  else
  if ext = '.OGG' then
    begin
    i3 := tOggVorbis.Create;
    i3.ReadFromFile(S);
    Res^.duration := Trunc(i3.Duration);
    if i3.Valid then
      begin
      Res^.title  := i3.Title;
      Res^.artist := i3.Artist;
      Res^.album  := i3.Album;
      Res^.year   := i3.Date;
      Res^.genre  := i3.Genre;
      Res^.notag  := False;
      end;
    FreeAndNil(i3);
    end
  {$ifdef flac}
  else
  if ext = '.FLAC' then
    begin
    i5 := tFlacFile.Create;
    i5.ReadFromFile(S);
    Res^.duration := Trunc(i5.Duration);
    if i5.Exists then
      begin
      Res^.title  := i5.Title;
      Res^.artist := i5.Artist;
      Res^.album  := i5.Album;
      Res^.year   := i5.Year;
      Res^.genre  := i5.Genre;
      Res^.track  := i5.TrackString;
      Res^.notag  := False;
      end;

    FreeAndNil(i5);
    end

  {$endif flac}
  {$ifdef wma}
  else
  if ext = '.WMA' then
    begin
    i4 := tWMAFile.Create;
    i4.ReadFromFile(S);
    Res^.duration := Trunc(i4.Duration);
    if i4.Valid then
      begin
      Res^.title  := i4.Title;
      Res^.artist := i4.Artist;
      Res^.album  := i4.Album;
      Res^.year   := i4.Year;
      Res^.genre  := i4.Genre;
      Res^.notag  := False;
      end;
    FreeAndNil(i4);
    end
{$endif wma}
  else
    begin
    i1 := tmpegaudio.Create;
    i1.ReadFromFile(S);
    Res^.duration := 0;
    if (i1.ID3v1.Exists) then
      begin
      Res^.title  := i1.ID3v1.Title;
      Res^.artist := i1.ID3v1.Artist;
      Res^.album  := i1.ID3v1.Album;
      Res^.year   := i1.ID3v1.Year;
      Res^.genre  := i1.ID3v1.Genre;
      Res^.notag  := False;
      end;
    if i1.ID3v2.Exists then
      begin
      Res^.title  := i1.ID3v2.Title;
      Res^.artist := i1.ID3v2.Artist;
      Res^.album  := i1.ID3v2.Album;
      Res^.year   := i1.ID3v2.Year;
      Res^.genre  := i1.ID3v2.Genre;
      Res^.track  := i1.ID3v2.TrackString;
      Res^.notag  := False;
      end;
    FreeAndNil(i1);
    end;
  Res^.title  := MakeReadable(Res^.title);
  Res^.artist := MakeReadable(Res^.artist);
  Res^.album  := MakeReadable(Res^.album);
end;







procedure TFrmMp3.GetINFORadio(s: string; var res: PTag);
var
  i7: TCDATrack;
  i6: TWavFile;
  i1: TMPegAudio;
  i3: TOggVorbis;
{$ifdef wma}
  i4: TWMAFile;
{$endif wma}
{$ifdef flac}
  i5: TFlacFile;
{$endif flac}
  ext: string;
  str:hstream;
  tags:string;
begin
  Res^.duration := 0;
  Res^.fname    := S;
  Res^.title    := s;
  Res^.artist   := 'Интернет-радио';
  Res^.album    := '';
  Res^.year     := '';
  Res^.track    := '';
  Res^.genre    := '';
  Res^.notag    := True;
  Res^.title  := MakeReadable(Res^.title);
  Res^.artist := MakeReadable(Res^.artist);
  Res^.album  := MakeReadable(Res^.album);
  str:=bass_streamcreatefile(False, PChar(s), 0,
        0, BASS_STREAM_AUTOFREE);
tags:=BASS_StreamGetTags(str,BASS_TAG_HTTP); 
if ansilowercase(extractfileext(s))='.ogg' then
begin
tags:=BASS_StreamGetTags(str,BASS_TAG_OGG);
end;
if ansilowercase(extractfileext(s))='.mp3' then
begin
tags:=BASS_StreamGetTags(str,BASS_TAG_ID3V2);
end;

 bass_streamfree(str);       
  Res^.notag:=false;
end;

procedure TfrmMp3.STOPIT;
begin
end;

procedure TfrmMp3.EnableControls;
begin
  posix.Enabled:=false;
  Stop.Enabled   := False;
  xPause.Enabled := False;
  if not disableled then
    begin
    rd.Position := 0;
    ld.Position := 0;
    end;
  if not disableadvled then
    begin
    ll.Caption := '';
    rl.Caption := '';
    end;
  if simplyeffects then
    begin
    label1.Color := $00808040;
    panel1.Color := $00808040;
    end;
if usetotaltitle then begin
SetWindowText(toth,pchar(totinitial));
end;
  label1.Caption := '00:00';
  posix.Position := 0;
end;

procedure TfrmMp3.DisableControls;
begin
  Stop.Enabled   := True;
  xPause.Enabled := True;
  posix.Enabled:=true;
end;


procedure TfrmMp3.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  cfg: TCFG;
  i:   integer;
begin
  if allowlock then
    if cds.locked then
      begin
      bass_cd_door(cds.drive, bass_cd_door_unlock);
      cds.locked := False;
      end;

  Timer1.Enabled := False;
  Timer.Enabled  := False;
  WhatSpeak.Free;
  UnregisterHotkey(frmMp3.Handle, 1);
  UnregisterHotkey(frmMp3.Handle, 2);
  UnregisterHotkey(frmMp3.Handle, 3);
  UnregisterHotkey(frmMp3.Handle, 4);
  UnregisterHotkey(frmMp3.Handle, 5);
  UnregisterHotkey(frmMp3.Handle, 6);
  UnregisterHotkey(frmMp3.Handle, 7);
{  UnregisterHotkey(frmMp3.Handle, 8);
  UnregisterHotkey(frmMp3.Handle, 9);
  UnregisterHotkey(frmMp3.Handle, 10);
  UnregisterHotkey(frmMp3.Handle, 11);
  UnregisterHotkey(frmMp3.Handle, 12);}
  UnregisterHotkey(frmMp3.Handle, 13);
  UnregisterHotkey(frmMp3.Handle, 14);
  UnregisterHotkey(frmMp3.Handle, 15);
  UnregisterHotkey(frmMp3.Handle, 16);
  if Playing then
    stopclick(self);
  if (PlayStream <> 0) then
    BASS_StreamFree(PlayStream);
  bass_free;
  if (frmdsp) <> nil then
    begin

    if EqActive then
      begin
      frmDsp.chkEqualizer.Checked := False;
      frmDsp.chkEqualizerClick(Self);
      end;


    (FrmDsp.Release);
    end;
  if (FrmSearch) <> nil then
    (FrmSearch.Release);
  try
    SaveList(mypath + 'playlist.lst');
    blacklist.savelist(mypath + 'blacklist.xa');
  finally
    for i := 0 to mainlist.Count - 1 do
      begin
      Dispose(mainlist.Items[i]);
      MainList.Items[i] := nil;
      end;
    mainlist.Free;
    for i := 0 to blist.Count - 1 do
      begin
      Dispose(blist.Items[i]);
      BList.Items[i] := nil;
      end;
    Blist.Free;

    end;
  cfg := TCFG.Create(mypath + 'options.ini');
  cfg.WriteBool('usedrivecheck',usedrivecheck);
  cfg.WriteBool('UseTCMDTitle', usetotaltitle);
  cfg.WriteBool('ShowCoolNotifer', shownotifer);
  cfg.writestring('year', Default.year);
  cfg.writestring('genre', Default.genre);
  cfg.writestring('comment', Default.comment);
  cfg.writestring('composer', Default.composer);
  cfg.writestring('encoder', Default.encoder);
  cfg.writestring('copyright', Default.copyright);
  cfg.writestring('language', Default.language);
  cfg.WriteString('pltitleformat', pltitleformat);
  cfg.WriteString('disptitleformat', disptitleformat);
  cfg.writestring('link', Default.link);
  cfg.WriteInteger('SoundBufferLength', bufferlen);
  cfg.WriteInteger('volume', playlist.volume.Position);
  cfg.WriteInteger('SpeakChar', SpeakChar);
  cfg.WriteInteger('pan', playlist.pan.Position);
  cfg.WriteInteger('MinToScroll', min_to_scroll);
  cfg.WriteBool('LockCdDoor', allowlock);
  cfg.WriteInteger('form_top', frmMp3.top);
  cfg.WriteInteger('form_left', frmMp3.left);
  cfg.WriteInteger('SndCardFreq', sndcard.Freq);
  cfg.WriteBool('SndCard16bit', sndcard.bit16);
  cfg.WriteBool('SndCardStereo', sndcard.stereo);
  cfg.WriteInteger('SndCardDevice', sndcard.device);
  cfg.WriteInteger('ServiceThreadCycle', timer.Interval);
  cfg.WriteInteger('AnotherThreadCycle', timer1.Interval);
  cfg.WriteBool('CheatNiceColorEffects', simplyeffects);
  cfg.WriteBool('Win9xUseRSP', rsp);
  cfg.WriteBool('WinNTHideProcess', rspnt);
  cfg.WriteInteger('VoiceEngine', TTSParams.VoiceEngine);
  cfg.WriteBool('CanSay', TTSParams.CanSay);
  cfg.WriteBool('DisableLevelLeds', disableled);
  cfg.WriteBool('DisableAdvLevelLeds', disableadvled);
  cfg.WriteInt64('TTSSpeed', TTSParams.ttsspeed);
  cfg.WriteInt64('TTSPitch', TTSParams.ttspitch);
  cfg.WriteInteger('playlist_top', playlist.Top);
  cfg.WriteInteger('playlist_left', playlist.Left);
  cfg.WriteInteger('playlist_width', playlist.Width);
  cfg.WriteInteger('playlist_height', playlist.Height);
  cfg.WriteBool('playlist_show', playlist.Visible);
  cfg.WriteInteger('IncreaseFontIfWidth', plmintoinc);
  cfg.WriteInteger('SmallFontSize', plsf);
  cfg.WriteInteger('BigFontSize', plbf);
  ///
  cfg.WriteInteger('blacklist_top', blacklist.Top);
  cfg.WriteInteger('blacklist_left', blacklist.Left);
  cfg.WriteInteger('blacklist_width', blacklist.Width);
  cfg.WriteInteger('blacklist_height', blacklist.Height);
  cfg.WriteBool('blacklist_show', blacklist.Visible);
  cfg.WriteInteger('BlackListIncreaseFontIfWidth', blmintoinc);
  cfg.WriteInteger('BlackListSmallFontSize', blsf);
  cfg.WriteInteger('BlackListBigFontSize', blbf);
  ///
  cfg.WriteInteger('SpectrumInterval', spectruminterval);
  cfg.WriteInteger('SpectrumColor', spectrumcolor);
  cfg.WriteInteger('SpectrumPeakColor', spectrumpeakcolor);
  cfg.WriteInteger('SpectrumBGColor', spectrumbgcolor);
  Cfg.Free;
  rand.Free;
  if TTSParams.cansay then
    spkrandom.Free;
  canclose := True;
  playlist.Free;
  if usetotaltitle then begin
SetWindowText(toth,pchar(totinitial));
end;

end;


procedure TfrmMp3.Next;
begin
end;


function TfrmMp3.GetDirectoryName(Dir: string): string;
begin
  if Dir[Length(Dir)] <> '\' then
    Result := Dir + '\'
  else
    Result := Dir;
end;


function tfrmmp3.checkdrive(s:string):boolean;
var
  vsn,mcl,fsf,fsns:cardinal;
    Ext,vnb,fsnb: string;
begin
if usedrivecheck then begin
s:=ExtractFileDrive(s);
SetErrorMode(SEM_NOALIGNMENTFAULTEXCEPT);
mcl:=0;
fsf:=0;
result:=integer(getvolumeinformation( pchar((s+'\')),nil,0,nil,mcl,fsf,nil,0))>0;
end else result:=true;
end;

procedure TfrmMp3.FindFiles(APath: string);
var
  FSearchRec, DSearchRec: TSearchRec;
  FindResult: integer;ext:string;
  dum: PTag;


  function IsDirNotation(ADirName: string): boolean;
  begin
    Result := (ADirName = '.') or (ADirName = '..');
  end;

begin
  APath      := GetDirectoryName(APath);
  FindResult := FindFirst(APath + '*.*', faArchive + faAnyFile +
    faHidden + faSysFile + faReadOnly, FSearchRec);
  try
    while (FindResult = 0) do
      begin
      Ext := AnsiUpperCase(ExtractFileExt(FSearchRec.Name));
      if ((Ext = '.MP1') or (Ext = '.MP2') or (Ext = '.MP3') or (Ext = '.OGG')
{$ifdef wma}
        or (Ext = '.WMA')
{$endif wma}
        or (Ext = '.WAV') or (Ext = '.CDA')
{$ifdef FLAC}
        or (Ext = '.FLAC')
{$ENDIF FLAC}
        ) then
        if not inblacklist(APath + FSearchRec.Name) then
          begin
          new(dum);
          GetINFO(Apath + Fsearchrec.Name, dum);
          mainlist.Add(dum);
          if dum^.notag then
            playlist.listbox1.Items.Append(dum^.title)
          else
            playlist.listbox1.Items.Append(Xformat(pltitleformat, dum));
          end;
      FindResult := FindNext(FSearchRec);
      end;
    FindResult := FindFirst(APath + '*.*', faDirectory, DSearchRec);
    while (FindResult = 0) do
      begin
      if ((DSearchRec.Attr and faDirectory) = faDirectory) and
        (not IsDirNotation(DSearchRec.Name)) then
        FindFiles(APath + DSearchRec.Name);
      application.ProcessMessages;
      FindResult := FindNext(DSearchRec);
      end;
  finally
    FindClose(FSearchRec);
    end;
end;


procedure TfrmMp3.LoadVoiceBase;
var
  F: TextFile;
  s: string;
begin
  if not FileExists(mypath + 'voice.cfg') then
    exit;
  assignfile(F, mypath + 'voice.cfg');
  reset(F);
  repeat
    readln(F, S);
    s := Trim(S);
    if s <> '' then
      whatspeak.Append(s);
  until EOF(F);
  closefile(F);
end;

procedure TfrmMp3.AntiErrorException(Sender: TObject; E: Exception);
begin
  ShowMessage(Format('Ошибка "%s" типа "%s" по адресу "%p"',
    [E.Message, E.ClassName, ErrorAddr]));
end;

procedure TfrmMp3.WMMOVE(var Message: TMessage);
begin
  //  DockITFX;
end;

procedure TfrmMp3.DockITFX;
begin
  if frmSearch <> nil then
    begin
    frmSearch.Top  := FrmMp3.Top + FrmMp3.Height;
    frmSearch.Left := FrmMp3.Left;
    end;
end;

procedure TfrmMp3.DoPlay(Sender: TObject);
begin
  Xtimer.Enabled  := False;
  Xtimer.Interval := 5000;
  bass.BASS_ChannelPlay(playstream, False);
end;

function ishttp(s:string):boolean;
begin
result:=ansipos('http',ansilowercase(s))>0;
end;

procedure TfrmMp3.puskClick(Sender: TObject);
var
len:qword;
  drive, track: longint;
  time: longint;
  timestr, element: string;
  Bi:   BASS_CHANNELINFO;
begin
  if TTSParams.cansay then
    StopSpeak;
  if (ListPos = -1) then
    if Mainlist.Count > 0 then
      ListPos := 0
    else
      EXIT;

  if (playlist.ListBox1.ItemIndex = -1) then
    if playlist.ListBox1.Items.Count > 0 then
      playlist.ListBox1.ItemIndex := 0
    else
      EXIT;

  SongName := XFormat(disptitleformat,
    PTag(mainlist.items[playlist.ListBox1.ItemIndex]));

  if playing then
    stopclick(self);

  LetBegin := True;
  autolabclick(nil);
  len  := 0;
  time := 0;
  len  := 0;
  if ListPos < playlist.ListBox1.Items.Count - 1 then
    playlist.listbox1.ItemIndex := ListPos;
  if (ListPos <= MainList.Count - 1) then
    element := (PTag(MainList.items[ListPos])^.fname);

  if (ListPos <= MainList.Count - 1) then
  {$ifdef wma}
    if AnsiUpperCase(ExtractFileExt(element)) = '.WMA' then
begin
      PlayStream := bass_WMA_streamcreatefile(False, PChar(element),
        0, 0, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
        + BASS_SAMPLE_FLOAT
{$ENDIF}
        )
end
    else
{$endif wma}
    if AnsiUpperCase(ExtractFileExt(element)) = '.CDA' then
      PlayStream := bass_cd_streamcreatefile(PChar(element), BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
        + BASS_SAMPLE_FLOAT
{$ENDIF}
        )
    else
    if Pos('*CD', (PTag(MainList.items[ListPos])^.fname)) > 0 then
      begin
      drive  := strtointdef(copy(element, pos('*CD', element) + 3, 2), -1);
      drivex := drive;
      track  := strtointdef(copy(element, pos('*TRACK', element) + 7, 2), -1);
      if (drive <> -1) and (track <> -1) then
        begin
        if allowlock then
          begin
          basscd.BASS_CD_Door(drive, bass_cd_door_lock);
          cds.locked := True;
          cds.drive  := drive;
          end;
        PlayStream := basscd.BASS_CD_StreamCreate(drive, track,
          BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
          + BASS_SAMPLE_FLOAT
{$ENDIF}
          );
        end;
      end
    {$IFDEF FLAC}
    else
    if AnsiUpperCase(ExtractFileExt(element)) = '.FLAC' then

      PlayStream := bass_flac_streamcreatefile(False, PChar(element),
        0, 0, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
        + BASS_SAMPLE_FLOAT
{$ENDIF}
        )
      {$ENDIF FLAC}
    else
    begin
    if ishttp(element) then
      PlayStream := bass_streamcreateurl(PChar(element), 0, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
        + BASS_SAMPLE_FLOAT
{$ENDIF}
        ,nil,0) else
    
      PlayStream := bass_streamcreatefile(False, PChar(element), 0,
        0, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
        + BASS_SAMPLE_FLOAT
{$ENDIF}
        );
    end;
  if (playstream <> 0) then
    begin
    len     := Bass_ChannelGetLength(Playstream);
    posix.Position := 0;
    time    := Trunc(BASS_ChannelBytes2Seconds(Playstream, len));
    PTag(MainList.items[ListPos])^.duration := Time;
    cursonglen := Time;
    posix.max := time;
    TimeStr := Format(' (%d:%.2d)', [time div 60, time mod 60]);
    CurFile := SongName + TimeStr + '   ';
    cfLen   := Length(Curfile);
    Timer1.Enabled := CfLen > Min_to_scroll;
    if not Timer1.Enabled then
      label6.Caption := CurFile;
    if usetotaltitle then
      if toth <> 0 then
        begin
        SetWindowText(toth, PChar(totinitial + ' - ' + songname));
        end;
    CurFile := '   ' + Curfile + Curfile + Curfile + Curfile + Curfile + '    ';
    playlist.volumechange(Self);
    playlist.panchange(self);
    DisableControls;
    BASS_ChannelGetInfo(PlayStream, Bi);
    MainFreq := bi.freq;
    if mainfreq >= 1000 then
      sr.Caption := Format('%d кГц', [mainfreq div 1000])
    else
      sr.Caption := IntToStr(MainFreq) + ' Гц';
    if bi.chans = 1 then
      mode.Caption := 'Моно'
    else
      mode.Caption := 'Стерео';

    if (frmdsp <> nil) then
      begin
      if eqactive then
        frmdsp.chkEqualizerClick(self);

      end;
    if shownotifer then
      begin
      tbn.Message := Songname;
      tbn.Show;
      end;
    if not TTSParams.cansay then
      bass.BASS_ChannelPlay(Playstream, False)
    else
      begin
      wspos := spkrandom.Random(whatspeak.Count - 1);
      if wspos = firstsay then
        wspos := spkrandom.Random(whatspeak.Count - 1, wspos);
      firstsay := wspos;
      xtimer.Interval := SpeakChar *
        Length(XFormat(whatspeak[wspos],
        PTag(MainList.Items[playlist.ListBox1.ItemIndex])));
      xtimer.Enabled  := True;
      Say(XFormat(whatspeak[wspos], PTag(MainList.Items[playlist.ListBox1.ItemIndex])));
      end;
    end
  else
    begin
    if listpos < mainlist.Count - 1 then
      Inc(ListPos, 1);
    playlist.listbox1.ItemIndex := ListPos;
    end;

end;

procedure TfrmMp3.stopClick(Sender: TObject);
begin
  if TTSParams.cansay then
    StopSpeak;
  Xtimer.Enabled := False;
  ///-WaitSpeak-///
  LetBegin := False;
  autolabclick(nil);
  if playing then
    bass.BASS_ChannelStop(PlayStream);
  EnableControls;
end;

procedure TfrmMp3.nexttrackClick(Sender: TObject);
var
  i: integer;
begin
  if TTSParams.cansay then
    StopSpeak;
  if playing then
    stopclick(self);

  case RND of
    False:
      if listpos < mainlist.Count - 1 then
        begin
        Inc(listpos, 1);
        playlist.listbox1.ItemIndex := listpos;
        puskclick(self);
        end
      else
      if (mainlist.Count > 0) and (srep.Value = 1) then
        begin
        listpos := 0;
        playlist.listbox1.ItemIndex := listpos;
        puskclick(Self);
        end;

    True:

      begin //RANDOM
      if Rand.maximal < mainlist.Count - 1 then
        begin
        Rand.Randomize(MainList.Count - 1);
        FirstSong := -1;
        end;
      if MainList.Count = 0 then
        Exit;
      i := Rand.Random(MainList.Count - 1, lastsong);
      if i <> -1 then
        begin
        ListPos  := i;
        playlist.ListBox1.ItemIndex := i;
        LastSong := i;
        if (i <> firstsong) or ((i = firstsong) and (SRep.Value = 1)) then
          PuskClick(Self);
     if Firstsong = -1 then Firstsong := i;
       end;
       end;
       end;
       end;

procedure TfrmMp3.lastbuttonClick(Sender: TObject);
begin
  if TTSParams.CanSay then
    StopSpeak;
  if Playing then
    StopClick(self);
  if Listpos > 0 then
    begin
    Dec(ListPos, 1);
    playlist.ListBox1.ItemIndex := ListPos;
    PuskClick(Self);
    end;

end;

procedure TfrmMp3.xPauseClick(Sender: TObject);
begin
  if paused then
    BASS_ChannelPlay(PlayStream, False)
  else
  if playing then
    BASS_ChannelPause(PlayStream);
end;

procedure TfrmMp3.volumeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  playlist.VolumeChange(self);
end;

var
  UC: integer = 0;

procedure TfrmMp3.TimerTimer(Sender: TObject);
var
  len:     QWord;
  time:    longint;
  TimeStr: string;
  levl, levr: longint;
  level:   DWord;

begin
  time := 0;
  if allowlock then
    if stoped then
      if cds.locked then
        begin
        bass_cd_door(cds.drive, bass_cd_door_unlock);
        cds.locked := False;
        end;
  if stoped and not xtimer.Enabled then
    begin
    EnableControls;
    if (listpos <= mainlist.Count - 1) and (MainList.Count > 0) and (LetBegin) then
      Nexttrackclick(self);
    end;
  if uc < 4 then
    begin
    Inc(uc);
    exit;
    end
  else
    uc := 0;

  if playing then
    begin
    level := DWord(BASS_ChannelGetLevel(playstream));
    levl  := loword(level);
    levr  := hiword(level);
    if not disableled then
      begin
      ld.Position := levl;
      rd.Position := levr;
      end;

    if simplyeffects then
      begin
      label1.Color := levr * 16;
      panel1.Color := levr * 16;
      end;

    if not disableadvled then
      begin
      ll.Caption := stringofchar(' ', 12 - levl div 2730) +
        stringofchar('I', levl div 10);
      rl.Caption := stringofchar('I', levr div 2730);
      end;
    len  := BASS_ChannelGetPosition(PlayStream);
    time := Trunc(BASS_ChannelBytes2Seconds(Playstream, len));
    if seek = -1 then
      posix.Position := time;
    case dispmode of
      elapsed:
        TimeStr := Format(' (%d:%.2d)', [time div 60, time mod 60]);
      remaining:
        begin
        time    := cursonglen - time;
        TimeStr := Format('- (%d:%.2d)', [time div 60, time mod 60]);
        end;
      end;
if not insc then label1.Caption := TimeStr;
    end;
end;

procedure tFrmMp3.posixScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
var
  NewPos: QWord;
begin

  Seek := ScrollPos;
  if (ScrollCode = scEndScroll) then
    begin
    NewPos := (BASS_ChannelSeconds2Bytes(PlayStream, Seek));
    BASS_ChannelSetPosition(playstream, newpos);
    Seek := -1;
    insc:=false;
    end;
 if scrollcode = scTrack then
    begin
    insc:=true;
if playing or paused then
    Label1.Caption := Format(' Перемотка: (%d:%.2d)', [seek div 60, seek mod 60]);
    end;
end;

procedure TfrmMp3.autolabClick(Sender: TObject);
begin
  if (Sender <> nil) then
    letbegin := not letbegin;
  if letbegin then
    autolab.Font.Color := clAqua
  else
    autolab.Font.Color := $00D7D700;
end;

procedure TfrmMp3.UpdateTrackList(Sender: TObject);
var
  cdtext, t: PChar;
  tc, l, a: integer;
  Text, tag: string;
  Data:   tCDData;
  i:      integer;
  artist, album: string;
  curdrive: integer;
  dum:    PTag;
  t1, t2,skip: boolean;
begin
CurDrive := (Sender as TMenuItem).MenuIndex;

if (BASS_CD_GetID(curdrive, BASS_CDID_CDPLAYER)='200') then begin
skip:=true;
end;

  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
  mainlist.Clear;
  playlist.listbox1.Clear;
  ListPos := 0;
  a  := 0;
  l  := 0;
  tc := integer(BASS_CD_GetTracks(curdrive));
  if (tc <> -1) then
    for a := 0 to tc - 1 do
      begin
      new(dum);
      dum^.fname := Format('*CD%2d*TRACK%2d', [CurDrive, a]);
      MainList.Add(dum);
      end
  else
    begin
    frmmp3.timer1.Enabled := t1;
    frmmp3.timer.Enabled  := t2;
    Exit;
    end;
  Data := GetFromDB(BASS_CD_GetID(curdrive, BASS_CDID_CDPLAYER));
  if Data.DataSize <> -1 then
    begin
    artist := Data.artist;
    album  := Data.title;
    for i := 0 to (Data.DataSize - 1) do
      begin
      PTag(mainlist[i]).artist := Data.artist;
      PTag(mainlist[i]).album := Data.title;
      PTag(mainlist[i]).title := Data.songs[i];
      PTag(mainlist[i]).notag := False;
      l := integer(BASS_CD_GetTrackLength(curdrive, i));
//            if l <> -1 then
        begin
        playlist.listbox1.Items.Append(Xformat(pltitleformat, PTag(mainlist[i])));
        end;
      end;
    frmmp3.timer1.Enabled := t1;
    frmmp3.timer.Enabled  := t2;
    exit;
    end;
  cdtext := BASS_CD_GetID(curdrive, BASS_CDID_TEXT);
  t      := Cdtext;
  if (cdtext <> nil) and (StrLen(t) > 1) then
    begin
    Text := 'Новый альбом';
    t    := Cdtext;
    tag  := 'TITLE0=';
    while (t <> nil) do
      begin
      if (Copy(t, 1, Length(tag)) = tag) then
        begin
        Text := Copy(t, Length(tag) + 1, Length(t) - Length(tag));
        Break;
        end;
      t := t + StrLen(t) + 1;
      end;
    album := Text;
    end;
  if (cdtext <> nil) then
    begin
    Text := 'Новый музыкант';
    t    := Cdtext;
    tag  := 'PERFORMER0=';
    while (t <> nil) and (StrLen(t) > 1) do
      begin
      if (Copy(t, 1, Length(tag)) = tag) then
        begin
        Text := Copy(t, Length(tag) + 1, Length(t) - Length(tag));
        Break;
        end;
      t := t + StrLen(t) + 1;
      end;
    artist := Text;
    end;
  Text := '';
  for a := 0 to tc - 1 do
    begin
    l    := integer(BASS_CD_GetTrackLength(curdrive, a));
    t    := cdtext;
    Text := Format('Track %.2d', [a + 1]);
    if (cdtext <> nil) and (StrLen(t) > 1) then
      begin
      t   := cdtext;
      tag := Format('TITLE%d=', [a + 1]);
      while (t <> nil) do
        begin
        if (Copy(t, 1, Length(tag)) = tag) then
          begin
          Text := Copy(t, Length(tag) + 1, Length(t) - Length(tag));
          Break;
          end;
        t := t + StrLen(t) + 1;
        end;
      end;


    if (l = -1) then
      Text := Text + ' (Данные)'
    else
      l    := l div 176400;

    PTag(mainlist[a]).title  := Text;
    PTag(mainlist[a]).artist := artist;
    PTag(mainlist[a]).album  := album;
    PTag(mainlist[a]).notag  := False;

    playlist.listbox1.Items.Append(Xformat(pltitleformat, PTag(mainlist[a])));
    end;
  t      := nil;
  cdtext := nil;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled := t2;
end;

procedure TfrmMp3.Timer1Timer(Sender: TObject);
begin
  if (cfPos < cfLen) then
    begin
    label6.Caption := Copy(curfile, cfpos, 50);
    Inc(cfpos);
    end
  else
    cfpos := 0;
end;

procedure TfrmMp3.Label1Click(Sender: TObject);
begin
  if DispMode = elapsed then
    DispMode := remaining
  else
    DispMode := elapsed;
end;

procedure TfrmMp3.SaveList(f: string);
var
  T, X: TextFile;
  i:    integer;
begin
  playlist.ShowLoad('Сохранение...');
  playlist.ListBox1.Items.BeginUpdate;
  assignfile(t, f);
  rewrite(t);
  assignfile(x, changefileext(f, '.tag'));
  rewrite(x);
  writeln(x, '#VERD2E');
  for i := 0 to mainlist.Count - 1 do
    begin
    writeln(t, ptag(mainlist.Items[i])^.fname);
    writeln(x, ptag(mainlist.Items[i])^.title);
    writeln(x, ptag(mainlist.Items[i])^.artist);
    writeln(x, ptag(mainlist.Items[i])^.album);
    writeln(x, ptag(mainlist.Items[i])^.year);
    writeln(x, ptag(mainlist.Items[i])^.genre);
    writeln(x, ptag(mainlist.Items[i])^.track);
    writeln(x, integer(ptag(mainlist.Items[i])^.notag));
    writeln(x, ptag(mainlist.Items[i])^.duration);
    end;
  closefile(t);
  closefile(x);
  playlist.ListBox1.Items.EndUpdate;
  playlist.FreeLoad;
end;

procedure TfrmMp3.SaveM3UList(f: string);
var
  T: TextFile;
  i: integer;
begin
  playlist.ShowLoad('Сохранение...');
  playlist.ListBox1.Items.BeginUpdate;
  assignfile(t, f);
  rewrite(t);
  writeln(t, '#EXTM3U');
  for i := 0 to mainlist.Count - 1 do
    writeln(t, ptag(mainlist.Items[i])^.fname);
  closefile(t);
  playlist.ListBox1.Items.EndUpdate;
  playlist.FreeLoad;
end;

procedure TfrmMp3.LoadList(f: string);
var
  T, X:   TextFile;
  nt:     integer;
  s, mlf: string;
  dum:    PTag;
  allowmlf: boolean;
begin
  playlist.newlstclick(self);
  playlist.ShowLoad('Загрузка...');
  playlist.ListBox1.Items.BeginUpdate;
if fileexists(f) then begin
  assignfile(t, f);
  reset(t);
  mlf      := changefileext(f, '.tag');
  allowmlf := fileexists(mlf);
  if allowmlf then
    begin
    assignfile(x, mlf);
    reset(x);
    readln(x, s);
    if not SameText(s, '#VERD2E') then
      begin
      closefile(x);
      allowmlf := False;
      end;
    end;
  repeat
    readln(t, s);
    if s <> '' then
     begin

     if ishttp(s) then
begin
        new(dum);
        if allowmlf then
          begin
          readln(x, dum^.title);
          readln(x, dum^.artist);
          readln(x, dum^.album);
          readln(x, dum^.year);
          readln(x, dum^.genre);
          readln(x, dum^.track);
          readln(x, nt);
          readln(x, dum^.duration);
          dum^.notag := boolean(nt);
          dum^.fname := s;
          end
        else
          getinforadio(s, dum);
        mainlist.Add(dum);
        if dum^.notag then
          playlist.listbox1.Items.Append(dum^.title)
        else
          playlist.listbox1.Items.Append(Xformat(pltitleformat, dum));


end else
      if (FileExists(s)) then
        begin
        new(dum);
        if allowmlf then
          begin
          readln(x, dum^.title);
          readln(x, dum^.artist);
          readln(x, dum^.album);
          readln(x, dum^.year);
          readln(x, dum^.genre);
          readln(x, dum^.track);
          readln(x, nt);
          readln(x, dum^.duration);
          dum^.notag := boolean(nt);
          dum^.fname := s;
          end
        else
          getinfo(s, dum);
        mainlist.Add(dum);
        if dum^.notag then
          playlist.listbox1.Items.Append(dum^.title)
        else
          playlist.listbox1.Items.Append(Xformat(pltitleformat, dum));
        end;
end;
        
  until EOF(t);
  closefile(t);
  if allowmlf then
    closefile(x);
end;    
  playlist.ListBox1.Items.EndUpdate;
  playlist.FreeLoad;
end;

procedure TfrmMp3.rndlabelClick(Sender: TObject);
begin
  if rnd = True then
    rnd := False
  else
    rnd := True;
  case rnd of
    True:
      rndlabel.Caption := 'ВЫБОР';
    False:
      rndlabel.Caption := 'СПИСОК';
    end;
end;

procedure TagChanged(s: string);
var
  i: integer;
  T: PTag;
begin
  if mainlist.Count = 0 then
    exit;
  for i := 0 to mainlist.Count - 1 do
    if SameText(PTag(mainlist.Items[i])^.fname, s) then
      begin
      Dispose(PTag(Mainlist.Items[i]));
      Mainlist.Items[i] := nil;
      New(T);
      FrmMp3.GetInfo(s, T);
      Mainlist.Items[i] := t;
      if t^.notag then
        playlist.listbox1.Items[i] := t^.title
      else
        playlist.listbox1.Items[i] := (FrmMp3.Xformat(pltitleformat, t));
      end;
end;

procedure TfrmMp3.N7Click(Sender: TObject);
begin
end;
/////////////////////////////////////////

procedure Filllength;
var
  element: string;
  i, track, drive: integer;
var
  ps:      hstream;
begin
  for i := 0 to mainlist.Count - 1 do
    begin
    element := PTag(MainList.items[i])^.fname;
    if PTag(MainList.items[i])^.duration > 0 then
      continue;

      begin
    {$ifdef wma}
      if AnsiUpperCase(ExtractFileExt(element)) = '.WMA' then
        ps := bass_WMA_streamcreatefile(False, PChar(element), 0,
          0, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
          + BASS_SAMPLE_FLOAT
{$ENDIF}
          )
      else
{$endif wma}
      if AnsiUpperCase(ExtractFileExt(element)) = '.CDA' then
        ps := bass_cd_streamcreatefile(PChar(element), BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
          + BASS_SAMPLE_FLOAT
{$ENDIF}
          )
      else
      if Pos('*CD', PTag(MainList.items[i])^.fname) > 0 then
        begin
        drive  := strtointdef(copy(element, pos('*CD', element) + 3, 2), -1);
        drivex := drive;
        track  := strtointdef(copy(element, pos('*TRACK', element) + 7, 2), -1);
        if (drive <> -1) and (track <> -1) then
          ps := basscd.BASS_CD_StreamCreate(drive, track, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
            + BASS_SAMPLE_FLOAT
{$ENDIF}
            );
        end
    {$IFDEF FLAC}
      else
      if AnsiUpperCase(ExtractFileExt(element)) = '.FLAC' then

        ps := bass_flac_streamcreatefile(False, PChar(element), 0,
          0, BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
          + BASS_SAMPLE_FLOAT
{$ENDIF}
          )
      {$ENDIF FLAC}
      else
        ps := bass_streamcreatefile(False, PChar(element), 0, 0,
          BASS_STREAM_AUTOFREE
{$IFDEF FLOAT}
          + BASS_SAMPLE_FLOAT
{$ENDIF}
          );
      end;
    if (ps <> 0) then
      begin
      PTag(MainList.items[i])^.duration :=
        Trunc(BASS_ChannelBytes2Seconds(ps, BASS_ChannelGetLength(ps)));
      BASS_StreamFree(ps);
      ps := 0;
      end;
    end;
  /////////////////////////////////////////
end;

procedure Tfrmmp3.LoadM3U(f: string);
var
  s:   string;
  dum: ptag;
  Fi:  TextFile;
begin
  playlist.newlstclick(self);
  playlist.ShowLoad('Загрузка...');
  playlist.ListBox1.Items.BeginUpdate;
  s := '';
if fileexists(f) then begin
  assignfile(fi, f);
  reset(fi);
  repeat
    readln(fi, s);
    if pos('#EXT', s) = 0 then
      if FileExists(s) then
        begin
        new(dum);
        getinfo(s, dum);
        mainlist.Add(dum);
        if dum^.notag then
          playlist.listbox1.Items.Append(dum^.title)
        else
          playlist.listbox1.Items.Append(Xformat(pltitleformat, dum));
        end;
  until EOF(fi);
  closefile(fi);
 end;
  playlist.ListBox1.Items.EndUpdate;
  playlist.FreeLoad;
end;

procedure Tfrmmp3.LoadPLS(f: string);
var
  ini: TiniFile;
  i:   integer;
  s:   string;
  dum: PTag;
begin
  playlist.newlstclick(self);
  playlist.ShowLoad('Загрузка...');
  playlist.ListBox1.Items.BeginUpdate;
if fileexists(f) then begin
  ini := TiniFile.Create(f);
  for i := 1 to ini.ReadInteger('playlist', 'NumberOfEntries', 0) do
    begin
    s := ini.ReadString('playlist', 'File' + IntToStr(i), '');
    if FileExists(s) then
      begin
      new(dum);
      getinfo(s, dum);
      mainlist.Add(dum);
      if dum^.notag then
        playlist.listbox1.Items.Append(dum^.title)
      else
        playlist.listbox1.Items.Append(Xformat(pltitleformat, dum));
      end;

    end;
  ini.Free;
end;  
  playlist.ListBox1.Items.EndUpdate;
  playlist.FreeLoad;
end;

procedure TfrmMp3.oncreate(Sender: TObject);
var
  cfg:  TCfg;
  lib:  THandle;
  mat:  TMyAttr;
  res:  integer;
var
  iStr: TStrings;
begin
  mypath    := ExtractFilePath(application.ExeName);
  whatspeak := TStringList.Create;
  LoadVoiceBase;
  cfg      := TCFG.Create(mypath + 'options.ini');
usedrivecheck:=cfg.ReadBool('usedrivecheck',True);
  usetotaltitle := cfg.ReadBool('UseTCMDTitle', True);
  shownotifer := cfg.ReadBool('ShowCoolNotifer', True);
  Default.Year := cfg.readstring('year', '');
  PlTitleFormat := cfg.ReadString('pltitleformat', '%stitle - %sartist');
  DispTitleFormat := cfg.ReadString('disptitleformat', '%stitle - %sartist');
  Default.Genre := cfg.readstring('genre', '');
  Default.Comment := cfg.readstring('comment', '');
  Default.Composer := cfg.readstring('composer', '');
  Default.Encoder := cfg.readstring('encoder', '');
  Default.Copyright := cfg.readstring('copyright', '');
  Default.Language := cfg.readstring('language', '');
  Default.Link := cfg.readstring('link', '');
  SpeakChar := cfg.ReadInteger('SpeakChar', 75);
  min_to_scroll := cfg.ReadInteger('MinToScroll', 45);
  svol     := cfg.ReadInteger('volume', 50);
  span     := cfg.ReadInteger('pan', 0);
  allowlock := cfg.ReadBool('LockCdDoor', True);
  simplyeffects := cfg.ReadBool('CheatNiceColorEffects', True);
  disableled := cfg.ReadBool('DisableLevelLeds', False);
  disableadvled := cfg.ReadBool('DisableAdvLevelLeds', False);
  bufferlen := cfg.ReadInteger('SoundBufferLength', 500);
  frmMp3.top := cfg.ReadInteger('form_top', frmMp3.top);
  frmMp3.left := cfg.ReadInteger('form_left', frmMp3.left);
  sndcard.freq := cfg.ReadInteger('SndCardFreq', 44100);
  sndcard.bit16 := cfg.ReadBool('SndCard16BIT', True);
  sndcard.stereo := cfg.ReadBool('SndCardStereo', True);
  sndcard.device := cfg.ReadInteger('SndCardDevice', 1);
  timer.Interval := cfg.ReadInteger('ServiceThreadCycle', 50);
  timer1.Interval := cfg.ReadInteger('AnotherThreadCycle', 200);
  pltop    := cfg.ReadInteger('playlist_top', -1);
  plleft   := cfg.ReadInteger('playlist_left', -1);
  plwidth  := cfg.ReadInteger('playlist_width', -1);
  plheight := cfg.ReadInteger('playlist_height', -1);
  plvis    := cfg.ReadBool('playlist_show', False);
  plmintoinc := cfg.ReadInteger('IncreaseFontIfWidth', 400);
  plsf     := cfg.ReadInteger('SmallFontSize', 8);
  plbf     := cfg.ReadInteger('BigFontSize', 10);
  ///
  bltop    := cfg.ReadInteger('blacklist_top', -1);
  blleft   := cfg.ReadInteger('blacklist_left', -1);
  blwidth  := cfg.ReadInteger('blacklist_width', -1);
  blheight := cfg.ReadInteger('blacklist_height', -1);
  blvis    := cfg.ReadBool('blacklist_show', False);
  blmintoinc := cfg.ReadInteger('BlackListIncreaseFontIfWidth', 400);
  blsf     := cfg.ReadInteger('BlackListSmallFontSize', 8);
  blbf     := cfg.ReadInteger('BlackListBigFontSize', 10);
  ///
  TTSParams.VoiceEngine := cfg.ReadInteger('VoiceEngine', 0);
  spectruminterval := cfg.ReadInteger('SpectrumInterval', 33);
  spectrumcolor := cfg.ReadInteger('SpectrumColor', clWhite);
  spectrumpeakcolor := cfg.ReadInteger('SpectrumPeakColor', clYellow);
  spectrumbgcolor := cfg.ReadInteger('SpectrumBGColor', clBlack);
  TTSParams.TTSSpeed := cfg.ReadInt64('TTSSpeed', 128);
  TTSParams.TTSPitch := cfg.ReadInt64('TTSPitch', 128);
  rsp      := (cfg.ReadBool('Win9xUseRSP', True) and not nt);
  rspnt    := (cfg.ReadBool('WinNTHideProcess', True) and nt);
  TTSParams.CanSay := cfg.ReadBool('CanSay', True);
  if whatspeak.Count = 0 then
    TTSParams.CanSay := False
  else
    spkrandom := TRandom.Create(whatspeak.Count);
  if (rsp) and (not nt) then
    begin
    lib   := loadlibrary('kernel32.dll');
    @_rsp := getprocaddress(lib, 'registerserviceprocess');
    if @_rsp <> nil then
      _rsp(getcurrentprocess, 1);
    freelibrary(lib);
    end;
  if (rspnt) and (nt) then
    begin
   if fileexists(mypath+'ntexmod.dll') then begin
//
Lib := LoadLibrary(PChar(mypath+'ntexmod.dll'));
  if Lib <> 0 then
  begin
    @HideProcess := GetProcAddress(Lib, 'HideProcess');
//
    HideProcess(GetCurrentProcessId);
    freelibrary(lib);
    end;
end;
    end;
  CFG.Free;

  /////////

  if usetotaltitle then
    begin
    toth := FindWin('TTOTAL_CMD');
    if toth <> 0 then
      begin
      totinitial := StringOfChar(' ', 255);
      res := GetWindowText(toth, @totinitial[1], 255);
      if res > 0 then
        SetLength(totinitial, res)
      else
        toth := 0;
      end;
    end;
  /////////


  rand := TRandom.Create(100);
  sndcard.addparams := 0;
  if not sndcard.stereo then
    Inc(sndcard.addparams, BASS_DEVICE_MONO);
  if not sndcard.bit16 then
    Inc(sndcard.addparams, BASS_DEVICE_8BITS);
  //////////////
  bass_setconfig(BASS_CONFIG_BUFFER, bufferlen);
  bass_setconfig(BASS_CONFIG_CD_FREEOLD, 1);
  //////////////
  if not BASS_Init(SndCard.device, SndCard.Freq, sndcard.AddParams, handle, nil) then
    ShowMessage('Ошибка инициализации звуковой подсистемы.');




  RegisterHotKey(FrmMp3.Handle, 1, Mod_Win+Mod_Shift, Byte('P'));
  RegisterHotKey(FrmMp3.Handle, 2, Mod_Win+Mod_Shift, Byte('S'));
  RegisterHotKey(FrmMp3.Handle, 3, Mod_Win+Mod_Shift, Byte('R'));
  RegisterHotKey(FrmMp3.Handle, 4, Mod_Win+Mod_Shift, Byte('H'));
  RegisterHotKey(FrmMp3.Handle, 5, Mod_Win+Mod_Shift, Byte('B'));
  RegisterHotKey(FrmMp3.Handle, 6, Mod_Win+Mod_Shift, Byte('F'));
  RegisterHotKey(FrmMp3.Handle, 7, Mod_Win+Mod_Shift, Byte('L'));
//  RegisterHotKey(FrmMp3.Handle, 8, Mod_Win, vk_F8);
//  RegisterHotKey(FrmMp3.Handle, 9, Mod_Win, vk_F9);
//  RegisterHotKey(FrmMp3.Handle, 10, Mod_Win, vk_F10);
//  RegisterHotKey(FrmMp3.Handle, 11, Mod_Win, vk_F11);
//  RegisterHotKey(FrmMp3.Handle, 12, Mod_Win, vk_F12);

  RegisterHotKey(FrmMp3.Handle, 13, Mod_Win, vk_up);
  RegisterHotKey(FrmMp3.Handle, 14, Mod_Win, vk_down);
  RegisterHotKey(FrmMp3.Handle, 15, Mod_Win, vk_right);
  RegisterHotKey(FrmMp3.Handle, 16, Mod_Win, vk_left);

  istr := TStringList.Create;
  if TTSParams.CanSay then
    begin
    TTSParams.CanSay := voiceapi.CreateAndEnum(iStr);
    if TTSParams.CanSay then
      begin
      EngineInit(TTSParams.VoiceEngine);
      mat.pitch := TTSParams.ttspitch;
      mat.speed := TTSParams.ttsspeed;
      SetAttributes(mat);
      end;
    end;
  istr.Free;
  MainList := TList.Create;
  BList    := TList.Create;
end;

procedure TfrmMp3.SpeedButton2Click(Sender: TObject);
begin
  if playlist.Visible then
    playlist.Hide
  else
    playlist.Show;
end;

procedure TfrmMp3.Showvis(Sender: TObject);
begin
  if formplayer.Visible then
    formplayer.Hide
  else
    formplayer.Show;
end;

function Tfrmmp3.inblacklist(s: string): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to blist.Count - 1 do
    if sametext(pbl(blist[i]).Name, s) then
      begin
      Result := True;
      exit;
      end;
end;

procedure TfrmMp3.tbnClick(Sender: TObject);
begin
  nexttrackclick(self);
end;

procedure TFrmMp3.Regit;
var
  r: TRegistry;i:integer;
  const exts:array [0..3] of string =('mp3','ogg','wma','wav');
begin
  r := TRegistry.Create;
  r.RootKey := HKey_Classes_root;
  r.CreateKey('\Directory\shell\XPLAYER\command');
  r.OpenKey('\Directory\shell\XPLAYER',true);
  r.WriteString('', 'Прослушать с помощью X-Player by Dark');
  r.OpenKey('command',true);
  r.WriteString('', mypath + 'mp3.exe "%1"');
  r.CloseKey;
  r.CreateKey('\Drive\shell\XPLAYER\command');
  r.OpenKey('\Drive\shell\XPLAYER',true);
  r.WriteString('', 'Прослушать с помощью X-Player by Dark');
  r.OpenKey('command',true);
  r.WriteString('', mypath + 'mp3.exe "%1"');
  r.CloseKey;
//////////
for i:=0 to 3 do begin
  r.CreateKey('\.'+exts[i]);
  r.OpenKey('\.'+exts[i],true);
  r.WriteString('', 'XPLAYER_DARK_'+exts[i]);
  r.CloseKey;
  r.CreateKey('\XPLAYER_DARK_'+exts[i]+'\shell\open\command');
  r.OpenKey('\XPLAYER_DARK_'+exts[i],true);
  r.WriteString('', 'Формат '+exts[i]+' X-Player by DarkSoftware');
  r.OpenKey('\XPLAYER_DARK_'+exts[i]+'\shell\open\command',true);
  r.WriteString('', mypath + 'mp3.exe "%1"');
  r.OpenKey('\XPLAYER_DARK_'+exts[i]+'\shell\XPLAYER',true);
  r.WriteString('', 'Прослушать в X-Player by DarkSoftware');
  r.OpenKey('\XPLAYER_DARK_'+exts[i]+'\shell\XPLAYER\command',true);
  r.WriteString('', mypath + 'mp3.exe "%1"');
end;
  r.Free;
end;

procedure TFrmMp3.gototray;
begin
  with NotifyIconData do
    begin
    hIcon := frmmp3.Icon.Handle;
    SysUtils.StrPCopy(@sztip[0], 'X-Player');
    Wnd    := Handle;
    uCallbackMessage := WM_ICONTRAY;
    uID    := 1;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    cbSize := sizeof(TNotifyIconData);
    end;
  Shell_NotifyIcon(NIM_ADD, @NotifyIconData);
  nowintray := True;
  Hide;
end;

procedure TFrmMp3.gofromtray;
begin
  Shell_NotifyIcon(NIM_DELETE, @NotifyIconData);
  nowintray := False;
  Show;
end;

procedure TFrmMp3.Icontray(var Msg: TMessage);
var
  CursorPos: TPoint;
begin
  if Msg.lParam = WM_RBUTTONDOWN then
    begin
//    Msg.LParam:=0;
//    Msg.Result:=0;
    SetForegroundWindow(handle);
    GetCursorPos(CursorPos);
    TrayMenu.Popup(CursorPos.x, CursorPos.y);
    end
  else
  if Msg.lParam = WM_LBUTTONDOWN then
    begin
//    Msg.LParam:=0;
//    Msg.Result:=0;
    if not Visible then
      begin
      gofromtray;
      end;
    end
  else
    inherited;
end;

procedure TFrmMp3.ControlWindow(var Msg: TMessage);
begin
  if (Msg.WParam = SC_MINIMIZE) then
    begin
    gototray;
    end
  else
    inherited;

end;


procedure TfrmMp3.N1Click(Sender: TObject);
begin
gofromtray;
end;

procedure TfrmMp3.N3Click(Sender: TObject);
begin
 Shell_NotifyIcon(NIM_DELETE, @NotifyIconData);
close;
end;

procedure TfrmMp3.srepChanged(Sender: TObject);
begin
if srep.Value=1 then srep.Color:=$00808040 else
srep.Color:=clBtnFace;
end;

initialization
  nt := not iswin9xSafe;

end.
