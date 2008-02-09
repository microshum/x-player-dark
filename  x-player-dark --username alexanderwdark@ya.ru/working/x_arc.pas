//{$R X_ARC.res}

{ (C) Full source code 2004 DarkSoft. FreeWare}

{Класс для работы с хранилищем файлов}
unit x_arc;

interface


uses
  SysUtils, Classes, Masks, bitmath, Dialogs, Windows;

(********************)
procedure Register;
(********************)
const
  VerH: byte = 0;

const
  VerL: byte = 1;

const
  DefaultTempFileExt = '.$$$';

const
  CopyrightString = '(C) 2004 DarkSoft';

type
  bool = boolean;

type
  TVAL = record
    Offset: int64;
    Size:   int64;
  end;

type
  TXARC = class (TComponent)
    ///////////////////////////
  protected
    //////////////////////////
    Quick:   bool;
    WasModifed: bool;
    ReadOnly: bool;
    Ext:     string;
    Header:  int64;
    Stream:  TFileStream;
    Frec:    TStringList;
    FCREC:   TStringList;
    CHeader: int64;
    CStream: TFileStream;
    My_Path: string;
    My_Name: string;
    Find_data: packed record
      pos:  longint;
      mask: string;
    end;
    {********* FOR COMPACT *********}
    function CreateArcCompact(S: string): bool;
    function CloseArcCompact: bool;
    function AddArcCompact(s, s2: string; offset, size: int64): bool;
    function UpdateFATCompact: bool;
    {******* END COMPACT *****}
    {-}
    function UpdateFAT: bool;
    function FindVal(s: string): Tval;
    function UnVal(s: string): string;
    {******* FOR PROPERTIES *****}
    function GetExt: string;
    function GetCopyRight: string;
    procedure SetExt(X: string);
    {******* END PROPERTIES *****}
    //////////////////////////////
  public
    /////////////////////////////
    found_rec: packed record
      offset: longint;
      size:    longint;
      Name:    string;
    end;
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; virtual;
    function CreateArc(S: string): bool;
    function OpenArc(s: string): bool;
    function CloseArc: bool;
    function ExtractArc(s: string; to_dir: string): bool;
    function ExtractArcLastFound(to_dir: string): bool;
    function ExtractAll(m: string; to_dir: string): bool;
    function MakeWord(A, B: byte): word;
    function ReadFAT: bool;
    function DeleteArc(s: string): bool;
    function DeleteAll(m: string): bool;
    function AddArc(s: string): bool;
    function AddAll(m: string): bool;
    function ListArc: TStringList;
    function Compact: bool;
    function LibVer: word;
    function AFindFirst(mask: string): bool;
    function AFindClose: bool;
    function AFindNext: bool;
    ///////////////////////////
  published
    //////////////////////////
    property About: string Read GetCopyright;
    property TempExt: string Read GetEXT Write SetExt;
  end;

implementation


{FUNCTIONS}


destructor TXarc.Destroy;
begin
  inherited Destroy;
end;


function TXARC.GetExt: string;
begin
  Result := Ext;
  if Result = '' then
    Result := DefaultTempFileExt;
end;

procedure TXARC.SetExt;
begin
  Ext := Trim(X);
  if Ext = '' then
    Ext := DefaultTempFileExt;
end;

constructor TXARC.Create;
begin
  Header     := -1;
  CHeader    := -1;
  Quick      := False;
  WasModifed := False;
  ReadOnly   := False;
  inherited Create(aOwner);
end;

function TXARC.GetCopyright: string;
begin
  Result := CopyrightString;
end;


function TXARC.ReadFAT: bool;
var
  i:   longint;
  Buf: PChar;
begin
  Result := False;
  if Stream = nil then
    exit;
  Stream.Seek(0, soFromBeginning);
  header := 0;
  Stream.Read(Header, SizeOf(Header));
  Stream.Seek(Header, soFromBeginning);
  Stream.Read(I, SizeOf(I));
  Buf := StrAlloc(I);
  Stream.Read(Buf^, I);
  Frec.Delimiter     := #1;
  Frec.DelimitedText := Buf;
  StrDispose(Buf);
  Result := True;
end;


function TXARC.FindVal(s: string): Tval;
var
  a, b, c: string;
begin
  Result.offset := -1;
  Result.size := -1;
  a := Trim(Frec.Values[s]);
  if (a = '') then
    Exit;
  b := Copy(a, 1, (pos('^', a) - 1));
  Delete(a, 1, Length(b) + 1);
  c := Copy(a, 1, length(a));
  Result.offset := StrToInt(b);
  Result.size := StrToInt(c);
end;

function TXARC.UnVal(s: string): string;
var
  a, b, c: string;
begin
  a := Trim(Frec.Values[s]);
  if (a = '') then
    Exit;
  b := Copy(a, 1, (pos('^', a) - 1));
  Delete(a, 1, Length(b) + 1);
  c      := a;
  Result := Format('@=%s^%s', [b, c]);
end;


function TXARC.DeleteArc(s: string): bool;
var
  i: longint;
begin
  Result := False;
  if Stream = nil then
    exit;
  i := Frec.IndexOfName(s);
  if i = -1 then
    exit;
  Frec[i]    := Unval(Frec.Names[i]);
  WasModifed := True;
  Result     := True;
end;

function TXARC.DeleteAll(m: string): bool;
var
  i: longint;
begin
  if M = '*.*' then
    M := '*';
  Result := False;
  if Stream = nil then
    exit;
  for i := 0 to FRec.Count - 1 do
    if MatchesMask(Frec.Names[i], m) then
      deletearc(Frec.Names[i]);
end;

function TXARC.ExtractArc(s: string; to_dir: string): bool;
var
  F: TFileStream;
  v: TVal;
begin
  Result := False;
  if Stream = nil then
    exit;
  v := findval(s);
  if (v.offset = -1) or (v.size = -1) then
    exit;
  Stream.Seek(v.offset, soFrombeginning);
  F := TFileStream.Create(IncludeTrailingPathDelimiter(to_dir) + s,
    fmCreate or fmShareDenyNone);
  F.Seek(0, soFromBeginning);
  F.CopyFrom(Stream, v.size);
  FreeAndNil(F);
  Result := True;
end;


function TXARC.ExtractArcLastFound(to_dir: string): bool;
var
  F: TFileStream;
begin
  Result := False;
  if Stream = nil then
    exit;
  if (found_rec.offset = -1) or (found_rec.size = -1) then
    exit;
  Stream.Seek(found_rec.offset, soFrombeginning);
  F := TFileStream.Create(IncludeTrailingPathDelimiter(to_dir) +
    found_rec.Name, fmCreate or fmShareDenyNone);
  F.Seek(0, soFromBeginning);
  F.CopyFrom(Stream, found_rec.size);
  FreeAndNil(F);
  Result := True;
end;


function TXARC.UpdateFAT: bool;
var
  I:   longint;
  Buf: PChar;
begin
  Result := False;
  if Stream = nil then
    exit;
  Frec.Delimiter := #1;
  Buf := PChar(Frec.DelimitedText);
  i   := StrLen(Buf) + 1;
  Stream.Seek(0, soFromBeginning);
  if Header = -1 then
    header := Stream.Size;
  Stream.Write(Header, SizeOf(Header));
  Stream.Seek(Header, soFromBeginning);
  Stream.Write(I, SizeOf(I));
  Stream.Write(Buf^, I);
  Stream.Size := Stream.Position;
  Result      := True;
end;


function TXARC.AddArc(s: string): bool;
var
  F: TFileStream;
begin
  Result := False;
  if not (FileExists(s)) then
    exit;
  if not bitmath.HasReadAccess(s) then
    exit;
  if Stream = nil then
    exit;
  if afindfirst(ExtractFileName(s)) then
    deletearc(ExtractFileName(s));
  afindclose;
  F := TFileStream.Create(s, fmOpenread or fmShareDenyNone);
  F.Seek(0, soFromBeginning);
  Stream.Seek(Header, soFrombeginning);
  FRec.Add(Format('%s=%d^%d', [ExtractFileName(s), Stream.position, F.Size]));
  Stream.CopyFrom(F, F.Size);
  Header := Stream.Position;
  FreeAndNil(F);
  WasModifed := True;
  Result     := True;
end;


function TXARC.MakeWord(A, B: byte): word;
begin
  Result := A or B shl 8;
end;

function TXARC.LibVer: word;
begin
  Result := makeword(verl, verh);
end;


function TXARC.AddAll(m: string): bool;
var
  S:    TsearchRec;
  path: string;
begin
  Result := False;
  if Stream = nil then
    exit;
  if (m <> '*.*') then
    path := ExtractFilePath(M)
  else
    path := GetCurrentDir + '\';
  if FindFirst(M, faReadOnly + faHidden + faSysFile + faArchive + faAnyFile, S) = 0 then
    repeat
      addarc(string(Path + S.Name));
    until FindNext(S) <> 0;
  SysUtils.FindClose(S);
  Result := True;
end;

function TXARC.ExtractAll(m: string; to_dir: string): bool;
var
  i: longint;
begin
  if M = '*.*' then
    M := '*';
  Result := False;
  if Stream = nil then
    exit;
  for i := 0 to FRec.Count - 1 do
    if MatchesMask(Frec.Names[i], m) then
      Extractarc(Frec.Names[i], to_dir);

  Result := True;
end;


function TXARC.CreateArc(S: string): bool;
begin
  Header := -1;
  Result := False;
  if not haswriteaccess(s) then
    exit;
  if Stream <> nil then
    exit;
  my_path    := ExtractFilePath(S);
  my_name    := S;
  find_data.pos := -1;
  found_rec.offset := -1;
  found_rec.size := -1;
  Stream     := TFileStream.Create(s, fmCreate or fmShareDenyWrite);
  WasModifed := True;
  Stream.Seek(0, soFromBeginning);
  Stream.Write(Header, SizeOf(Header));
  Frec   := TStringList.Create;
  Result := UpdateFat;
end;

function TXARC.OpenArc(s: string): bool;
begin
  try
    Header := -1;
    Result := False;
    if not FileExists(s) then
      Exit;
    ReadOnly := not HasWriteAccess(s);
    if Stream <> nil then
      exit;
    find_data.pos := -1;
    found_rec.offset := -1;
    found_rec.size := -1;
    my_path := ExtractFilePath(S);
    my_name := s;
    Stream  := TFileStream.Create(s, fmOpenreadWrite or fmShareDenyWrite);
    Stream.Seek(0, soFromBeginning);
    Stream.Read(Header, SizeOf(Header));
    if not quick then
      Frec := TStringList.Create;
  except
    end;
  Result := ReadFat;
end;

function TXARC.CloseArc: bool;
begin
  if (Stream <> nil) then
    begin
    if (Frec <> nil) then
      if wasmodifed then
        if not ReadOnly then
          updatefat;
    try
      FreeAndNil(Stream);
    except
      end;
    end;
  if not quick then
    if (Frec <> nil) then
      try
        FreeAndNil(Frec);
      except
        end;
  Header := -1;
  Result := True;

end;


function TXARC.AFindFirst(mask: string): bool;
var
  i:   longint;
  v:   TVal;
  nam: string;
begin
  Result := False;
  if Stream = nil then
    Exit;
  if mask = '*.*' then
    mask := '*';
  for i := 0 to FRec.Count - 1 do
    begin
    nam := Frec.Names[i];
    if nam[1] <> '@' then
      if MatchesMask(nam, mask) then
        begin
        v      := FindVal(nam);
        found_rec.offset := v.Offset;
        found_rec.size := v.Size;
        found_rec.Name := nam;
        find_data.pos := i;
        find_data.mask := mask;
        Result := True;
        break;
        end;
    end;
  if Result = False then
    begin
    find_data.pos    := -1;
    found_rec.offset := -1;
    found_rec.size   := -1;
    end;
end;


function TXARC.AFindClose: bool;
begin
  Result := False;
  if Stream = nil then
    Exit;
  find_data.pos := -1;
  find_data.mask := '';
  Result := True;
end;

function TXARC.AFindNext: bool;
var
  i:   longint;
  nam: string;
  v:   TVal;
begin
  Result := False;
  if find_data.pos = -1 then
    exit;
  Result := False;
  if Stream = nil then
    Exit;
  if find_data.pos = Frec.Count - 1 then
    exit;
  for i := find_data.pos + 1 to FRec.Count - 1 do
    begin
    nam := Frec.Names[i];
    if nam[1] <> '@' then
      if MatchesMask(nam, find_data.mask) then
        begin
        v      := FindVal(nam);
        found_rec.offset := v.Offset;
        found_rec.size := v.Size;
        found_rec.Name := nam;
        find_data.pos := i;
        Result := True;
        break;
        end;
    end;
  if Result = False then
    begin
    find_data.pos    := -1;
    found_rec.offset := -1;
    found_rec.size   := -1;
    end;

end;


function TXARC.ListArc: TStringList;
var
  i: longint;
begin
  Result := TStringList.Create;
  if stream = nil then
    exit;
  for i := 0 to (Frec.Count - 1) do
    if Frec.Names[i] <> '@' then
      Result.Add(Frec.Names[i])
    else
      Result.Add('-Deleted Entry-');
end;

function TXARC.Compact: bool;
var
  i: longint;
  v: TVal;
begin
  Result := False;
  if Stream = nil then
    exit;
  quick := True;
  CloseArc;
  CreateArcCompact(PChar(ChangeFileExt(my_name, Ext)));
  for i := 0 to FRec.Count - 1 do
    begin
    if Frec.Names[i] = '@' then
      continue;
    v := FindVal(PChar(Frec.names[i]));
    if (v.offset <> -1) and (v.size <> -1) then
      AddArcCompact(PChar(my_name), PChar(Frec.Names[i]), v.offset, v.size);
    end;
  CloseArcCompact;
  SysUtils.DeleteFile(my_name);
  RenameFile(ChangeFileExt(my_name, Ext), my_name);
  OpenArc(PChar(my_name));
  Result := True;
  quick  := False;
end;
/// CompactLib
function TXARC.UpdateFATCompact: bool;
var
  I:   longint;
  Buf: PChar;
begin
  Result := False;
  if ReadOnly then
    Exit;
  if CStream = nil then
    exit;
  FCREC.Delimiter := #1;
  Buf := PChar(FCREC.DelimitedText);
  i   := StrLen(Buf) + 1;
  CStream.Seek(0, soFromBeginning);
  if CHeader = -1 then
    CHeader := CStream.Size;
  CStream.Write(CHeader, SizeOf(CHeader));
  CStream.Seek(CHeader, soFromBeginning);
  CStream.Write(I, SizeOf(I));
  CStream.Write(Buf^, I);
  CStream.Size := CStream.Position;
  Result := True;
end;

function TXARC.AddArcCompact(s, s2: string; offset, size: int64): bool;
var
  F: TFileStream;
begin
  Result := False;
  if CStream = nil then
    exit;
  F := TFileStream.Create(s, fmOpenReadWrite or fmShareDenyWrite);
  F.Seek(offset, soFromBeginning);
  CStream.Seek(CHeader, soFrombeginning);
  FCREC.Add(Format('%s=%d^%d', [s2, CStream.position, Size]));
  CStream.CopyFrom(F, Size);
  CHeader := CStream.Position;
  FreeAndNil(F);
  Result := True;
end;


function TXARC.CreateArcCompact(S: string): bool;
begin
  CHeader := -1;
  Result  := False;
  if CStream <> nil then
    exit;
  CStream := TFileStream.Create(s, fmCreate or fmShareDenyWrite);
  CStream.Seek(0, soFromBeginning);
  CStream.Write(CHeader, SizeOf(CHeader));
  FCREC  := TStringList.Create;
  Result := UpdateFatCompact;
end;


function TXARC.CloseArcCompact: bool;
begin
  if CStream <> nil then
    begin
    UpdateFatCompact;
    FreeAndNil(CStream);
    end;
  if FCREC <> nil then
    FreeAndNil(FCREC);
  CHeader := -1;
  Result  := True;
end;


procedure Register;
begin
  RegisterComponents('DarkSoft', [TXARC]);
end;

begin
end.
