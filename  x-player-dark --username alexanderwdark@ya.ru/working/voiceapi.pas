(* (c) Assembled by DarkSoft. Freeware & OpenSource *)

unit voiceapi;

interface

uses Classes, types, speech, activex, comobj;

type
  TMyAttr = record
    pitch:    word;
    speed:    cardinal;
    maxspeed: Dword;
    minspeed: Dword;
    maxpitch: word;
    minpitch: word;
  end;

{Creates Engine Instance and shows what engines are installed}
function CreateAndEnum(var modules: TStrings): boolean;
{Init voice engine by it's index (see index in modules) }
function EngineInit(Engineid: integer): boolean;
{Simply says some text}
function Say(what: ansistring): boolean;
procedure StopSpeak;
function getmodeinfo: PTTSModeInfo;
function GetAttributes(var A: Tmyattr): boolean;
function SetAttributes(var A: Tmyattr): boolean;
function AboutDialog(wnd: longword; title: PAnsiChar): boolean;
function TranslateDialog(wnd: longword; title: PAnsiChar): boolean;
function LexiconDialog(wnd: longword; title: PAnsiChar): boolean;
function GeneralDialog(wnd: longword; title: PAnsiChar): boolean;

implementation

var
  fITTSAttributes: ITTSAttributes;
  fITTSCentral: ITTSCentral;
  fITTSDialogs: ITTSDialogs;
  fIAMM:      IAudioMultimediaDevice;
  aTTSEnum:   ITTSEnum;
  fpModeInfo: PTTSModeInfo;

function GeneralDialog(wnd: longword; title: PAnsiChar): boolean;
begin
  if Assigned(fITTSDialogs) then
    fITTSDialogs.GeneralDlg(wnd, title);
end;

function LexiconDialog(wnd: longword; title: PAnsiChar): boolean;
begin
  if Assigned(fITTSDialogs) then
    fITTSDialogs.LexiconDlg(wnd, title);
end;

function TranslateDialog(wnd: longword; title: PAnsiChar): boolean;
begin
  if Assigned(fITTSDialogs) then
    fITTSDialogs.TranslateDlg(wnd, title);
end;

function AboutDialog(wnd: longword; title: PAnsiChar): boolean;
begin
  if Assigned(fITTSDialogs) then
    fITTSDialogs.AboutDlg(wnd, title);
end;


function GetAttributes(var A: Tmyattr): boolean;
begin
  FillChar(A, sizeof(Tmyattr), 0);
  Result := False;
  if not Assigned(fittsattributes) then
    Exit;
  if (TTSFEATURE_Pitch and fpModeInfo.dwFeatures) = TTSFEATURE_Pitch then
    if not (TTSERR_NOTSUPPORTED = fITTSAttributes.PitchGet(a.pitch)) then
      begin
      fittsattributes.PitchGet(a.pitch);
      end;
  if (TTSFEATURE_Speed and fpModeInfo.dwFeatures) = TTSFEATURE_Speed then
    if not (TTSERR_NOTSUPPORTED = fITTSAttributes.SpeedGet(a.speed)) then
      begin
      fittsattributes.SpeedGet(a.speed);
      end;
  Result := True;
end;

function SetAttributes(var A: Tmyattr): boolean;
begin
  Result := False;
  if not Assigned(fittsattributes) then
    Exit;
  if (TTSFEATURE_Pitch and fpModeInfo.dwFeatures) = TTSFEATURE_Pitch then
    fittsattributes.PitchSet(A.Pitch);
  if (TTSFEATURE_Speed and fpModeInfo.dwFeatures) = TTSFEATURE_Speed then
    fittsattributes.SpeedSet(A.Speed);
  Result := True;
end;

function getmodeinfo: PTTSModeInfo;
begin
  if assigned(fpModeInfo) then
    Result := fpModeInfo;
end;

function CreateAndEnum(var modules: TStrings): boolean;
var
  NumFound: DWord;
  ModeInfo: TTSModeInfo;
begin
  Result   := True;
  NumFound := 0;
  try
    CoCreateInstance(CLSID_MMAudioDest, nil, CLSCTX_ALL,
      IID_IAudioMultiMediaDevice, fIAMM);
  except
    Result := False;
    Exit;
    end;
  try
    CoCreateInstance(CLSID_TTSEnumerator, nil, CLSCTX_ALL, IID_ITTSEnum, aTTSEnum);
  except
    Result := False;
    end;
  try
    aTTSEnum.Reset;
    aTTSEnum.Next(1, ModeInfo, @NumFound);
  except
    Result := False;
    Exit;
    end;
  while NumFound > 0 do
    begin
    Modules.Add(ModeInfo.szModeName);
    aTTSEnum.Next(1, ModeInfo, @NumFound);
    end;
  Result := modules.Count > 0;
end;


function EngineInit(Engineid: integer): boolean;
var
  NumFound: DWord;
  ModeInfo: TTSModeInfo;
begin
  Result   := True;
  NumFound := 0;
  try
    CoCreateInstance(CLSID_MMAudioDest, nil,
      CLSCTX_ALL, IID_IAudioMultiMediaDevice, fIAMM);
    CoCreateInstance(CLSID_TTSEnumerator, nil, CLSCTX_ALL, IID_ITTSEnum, aTTSEnum);
    aTTSEnum.Reset;
    aTTSEnum.skip(EngineID);
    aTTSEnum.Next(1, ModeInfo, @NumFound);
    if assigned(fpModeInfo) then
      dispose(fpModeInfo);
    New(fpModeInfo);
    fpModeInfo^ := ModeInfo;
    aTTSEnum.Select(fpModeInfo^.gModeID, fITTSCentral, IUnknown(fIAMM));
    OleCheck(fITTSCentral.QueryInterface(IID_ITTSAttributes, fITTSAttributes));
    OleCheck(fITTSCentral.QueryInterface(IID_ITTSDialogs, fITTSDialogs));
  except
    Result := False;
    end;
end;

function Say(what: ansistring): boolean;
var
  SData: TSData;
begin
  Result := True;
  if not assigned(fITTSCentral) then
    begin
    Result := False;
    exit;
    end;
  SData.dwSize := length(What) + 1;
  SData.pData  := PChar(What);
  try
    fITTSCentral.TextData(CHARSET_TEXT, 0, SData, nil, IID_ITTSBufNotifySink);
  except
    Result := False;
    end;
end;

procedure StopSpeak;
begin
  if assigned(fITTSCentral) then
    fITTSCentral.AudioReset;
end;

procedure PauseSpeak;
begin

end;

end.
