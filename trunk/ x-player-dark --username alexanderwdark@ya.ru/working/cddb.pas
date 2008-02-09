{$D+}
{$Q+}
// Local CD DB by DarkSoft, 2004
unit CDDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ComCtrls, ExtCtrls, inifiles, X_ARC;

var
  XDB: TXARC;

var
  my_path: string;

type
  Bool = boolean;

type
  tcddata = packed record
    title:    string;
    artist:   string;
    DataSize: longint;
    songs:    TStringList;
  end;

function ADDTODB(ID: string; Data: tcdDATA): BOOL;
function GetFromDB(ID: string): tcdData;

implementation

function ADDTODB(ID: string; Data: tcdDATA): BOOL;
var
  Fi:  Text;
  i:   integer;
  ini: TIniFile;
begin
  AssignFile(Fi, my_path + id + '.x');
{$I-}
  ReWrite(Fi);
  if (ioresult <> 0) then
    begin
{$I+}
    CloseFile(Fi);
    Result := False;
    Exit;
    end;
{$I+}
  Writeln(Fi, Data.title);
  Writeln(Fi, Data.artist);
  Writeln(Fi, Data.datasize);
  for i := 0 to (Data.songs.Count - 1) do
    Writeln(Fi, Data.songs[i]);
  CloseFile(Fi);
  ini := TIniFile.Create('cdplayer.ini');
  ini.WriteString(ID, 'artist', Data.artist);
  ini.WriteString(ID, 'title', Data.title);
  ini.WriteInteger(ID, 'numtracks', Data.DataSize);
  ini.WriteInteger(ID, 'numplay', Data.DataSize);
  ini.WriteInteger(ID, 'entrytype', 1);
  for i := 0 to (Data.songs.Count - 1) do
    ini.WriteString(ID, IntToStr(i), Data.songs[i]);
  ini.Free;
  Result := xdb.AddAll(my_path + id + '.x');
  DeleteFile(my_path + id + '.x');
end;

function GetFromDB(ID: string): tcdData;
var
  F:   Text;
  i:   integer;
  s:   string;
  ini: TIniFile;
begin
  Result.DataSize := -1;
  xdb.ExtractAll(id + '.x', my_path);
  if not FileExists(my_path + id + '.x') then
    begin
    ini := TIniFile.Create('cdplayer.ini');
    Result.DataSize := Ini.ReadInteger(ID, 'numTracks', -1);
    if (Result.DataSize <> -1) then
      begin
      Result.songs := TStringList.Create;
      for i := 0 to (Result.DataSize - 1) do
        Result.songs.Add(ini.ReadString(id, IntToStr(i), 'track' + IntToStr(i)));
      Result.title  := ini.ReadString(id, 'title', 'Новый альбом');
      Result.artist := ini.ReadString(id, 'artist', 'Новый исполнитель');
      end;
    ini.Free;
    end
  else
    begin
    AssignFile(F, my_path + id + '.x');
{$I-}
    Reset(F);
    if ioresult <> 0 then
      begin
{$I+}
      CloseFile(F);
      exit;
      end;
{$I+}
    Readln(F, S);
    Result.Title := s;
    Readln(F, S);
    Result.Artist := s;
    Readln(F, S);
    Result.DataSize := StrToIntDef(s, -1);
    Result.Songs    := TStringList.Create;
    if Result.DataSize <> -1 then
      for i := 0 to (Result.DataSize - 1) do
        begin
        Readln(F, S);
        Result.Songs.Add(S);
        end;
    CloseFile(F);
    end;
  deletefile(my_path + id + '.x');
end;

initialization
  my_path := ExtractFilePath(ParamStr(0));
  xdb     := TXARC.Create(nil);
  if FileExists(my_path + 'cddb.dat') then
    xdb.OpenArc(my_path + 'cddb.dat')
  else
    xdb.createarc(my_path + 'cddb.dat');

finalization
  xdb.CloseArc;
  FreeAndNil(XDB);
end.
