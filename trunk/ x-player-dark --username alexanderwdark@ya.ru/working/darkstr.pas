{$R-}
{$H+}
unit DarkStr;
 ///Dark strings functions:
 // Dark StrScan function for one char (FindDeLimiter)
 // Dark GetKey and GetValue
 // (C) 2003, 2004 A.Dark
interface

function Replace(path: string): string;
function DGetKey(what: ansistring): string;
function DGetKeyEx(what: ansistring): string;
function FindDeLimiter(str: ansistring): longint;
function DGetValue(what: ansistring): string;
function FindDeLimiterEx(str: ansistring): longint;
function DGetValueEx(what: ansistring): string;

implementation

uses SysUtils;

function FindDeLimiter(str: ansistring): longint;
var
  q, z:  longint;
  found: boolean;
begin
  q     := 0;
  found := False;
  while q < length(str) do
    begin
    Inc(q, 1);
    if str[q] = '\' then
      begin
      found := True;
      z     := q;
      end;
    end;
  if found then
    Result := z
  else
    Result := 0;
end;

function DGetValue(what: ansistring): string;
var
  a: longint;
begin
  what   := trim(what);
  a      := finddelimiter(what) + 1;
  Result := copy(what, a, 255);
  Result := trim(Result);
end;
/////////////////////////////////////
function FindDeLimiterEx(str: ansistring): longint;
var
  q, z:  longint;
  found: boolean;
begin
  q     := 0;
  found := False;
  while q < length(str) do
    begin
    Inc(q, 1);
    if str[q] = '-' then
      begin
      found := True;
      z     := q;
      end;
    end;
  if found then
    Result := z
  else
    Result := 0;
end;

function DGetValueEx(what: ansistring): string;
var
  a: longint;
begin
  what   := trim(what);
  a      := FinddelimiterEx(what) + 1;
  Result := copy(what, a, 255);
  Result := trim(Result);
end;

function DGetKeyEx(what: ansistring): string;
var
  a: longint;
begin
  what   := trim(what);
  a      := finddelimiterEx(what) - 1;
  Result := copy(what, 1, a);
  Result := trim(Result);
end;
/////////////////////////////////////
function DGetKey(what: ansistring): string;
var
  a: longint;
begin
  what   := trim(what);
  a      := finddelimiter(what) - 1;
  Result := copy(what, 1, a);
  Result := trim(Result);
end;

function Replace(path: string): string;
var
  newpath: string;
  i: longint;
begin
  i := 0;
  newpath := '';
  while i < length(path) do
    begin
    Inc(i, 1);
    if not (path[i] = '\') then
      newpath := newpath + path[i]
    else
      newpath := newpath + '\\';
    end;
  Result := newpath;
end;

begin
end.
