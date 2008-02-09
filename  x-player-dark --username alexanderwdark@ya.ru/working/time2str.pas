{DarkSoftware, 2004}
unit time2str;

interface

uses dateutils, SysUtils;

function time2text(i: tdatetime): string;
function time2texts(str: string): string;

implementation

type
  state = (ho, mi, se, dum2_);

const
  names: array[0..2] of string = ('час', 'минут', 'секунд');

const
  digm: array[0..19] of string = ('ноль', 'один', 'два', 'три', 'четыре',
    'пять', 'шесть', 'семь', 'восемь', 'девять', 'десять', 'одинадцать', 'двенадцать',
    'тринадцать', 'четырнадцать', 'пятьнадцать', 'шестьнадцать', 'семьнадцать',
    'восемьнадцать', 'девятьнадцать');

const
  digj: array[0..19] of string = ('ноль', 'одна', 'две', 'три', 'четыре',
    'пять', 'шесть', 'семь', 'восемь', 'девять', 'десять', 'одинадцать', 'двенадцать',
    'тринадцать', 'четырнадцать', 'пятьнадцать', 'шестьнадцать', 'семьнадцать',
    'восемьнадцать', 'девятьнадцать');

const
  dig10: array[0..9] of string = ('ноль', '', 'двадцать', 'тридцать', 'сорок',
    'пятьдесят', 'шестьдесят', 'семьдесят', 'восемьдесят', 'девяносто');

function num3totext(s: string; st: state): string;
begin
  Result := '';
  if StrToInt(s) <= 19 then
    if st in [mi, se] then
      Result := digj[StrToInt(s)]
    else
      Result := digm[StrToInt(s)]
  else
    begin
    Result := dig10[StrToInt(s[1])];
    if st in [mi, se] then
      Result := Result + ' ' + digj[StrToInt(s[2])]
    else
      Result := Result + ' ' + digm[StrToInt(s[2])];
    end;
  if st = ho then
    if s[1] = '0' then
      case s[2] of
        '1':
          Result := Result + ' ' + names[0];
        '2'..'4':
          Result := Result + ' ' + names[0] + 'а';
        '0', '5'..'9':
          Result := Result + ' ' + names[0] + 'ов';
        end
    else
    if s[1] = '1' then
      Result := Result + ' ' + names[0] + 'ов'
    else
      case s[2] of
        '1':
          Result := Result + ' ' + names[0];
        '2'..'4':
          Result := Result + ' ' + names[0] + 'а';
        '0', '5'..'9':
          Result := Result + ' ' + names[0];
        end
  else
  if st = mi then
    if s[1] = '0' then
      case s[2] of
        '1':
          Result := Result + ' ' + names[1] + 'а';
        '2'..'4':
          Result := Result + ' ' + names[1] + 'ы';
        '0', '5'..'9':
          Result := Result + ' ' + names[1];
        end
    else
    if s[1] = '1' then
      Result := Result + ' ' + names[1]
    else
      case s[2] of
        '1':
          Result := Result + ' ' + names[1] + 'а';
        '2'..'4':
          Result := Result + ' ' + names[1] + 'ы';
        '0', '5'..'9':
          Result := Result + ' ' + names[1];
        end
  else
  if st = se then
    if s[1] = '0' then
      case s[2] of
        '1':
          Result := Result + ' ' + names[2] + 'а';
        '2'..'4':
          Result := Result + ' ' + names[2] + 'ы';
        '0', '5'..'9':
          Result := Result + ' ' + names[2];
        end
    else
    if s[1] = '1' then
      Result := Result + ' ' + names[2] + 'ы'
    else
      case s[2] of
        '1':
          Result := Result + ' ' + names[2] + 'а';
        '2'..'4':
          Result := Result + ' ' + names[2] + 'ы';
        '0', '5'..'9':
          Result := Result + ' ' + names[2];
        end;

end;

function time2text(i: tdatetime): string;
var
  str: string;
  n:   integer;
  st:  state;
begin
  n      := 1;
  Result := '';
  str    := FormatDateTime('hhnnss', i);
  st     := ho;
  repeat
    Result := Result + ' ' + num3totext(copy(str, n, 2), st);
    Inc(st);
    Inc(n, 2);
  until n > 5;
  Result := trim(Result);
end;

function time2texts(str: string): string;
var
  n:  integer;
  st: state;
begin
  n      := 1;
  Result := '';
  st     := ho;
  repeat
    Result := Result + ' ' + num3totext(copy(str, n, 2), st);
    Inc(st);
    Inc(n, 2);
  until n > 5;
  Result := trim(Result);
end;


end.
