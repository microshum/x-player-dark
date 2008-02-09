unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, ToolWin, StdCtrls, bass;

type
  Tinfoform = class (TForm)
    Mem:      TMemo;
    ToolBar1: TToolBar;
    GetInfo:  TToolButton;
    procedure LogNow(s: string);
    procedure GetInfoClick(Sender: TObject);
    procedure MemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  infoform: Tinfoform;

implementation

uses gui;

{$R *.dfm}

procedure Tinfoform.LogNow(s: string);
begin
  mem.Lines.Add(s);
end;


procedure Tinfoform.GetInfoClick(Sender: TObject);
var
  tl: cardinal;
  i, h, m, s: integer;
  bi: bass_info;
begin
  mem.Clear;
  bass.BASS_GetInfo(bi);
  lognow(format('Всего элементов в списке: %d', [gui.MainList.Count]));
  lognow(format('Голосовая база, элементов: %d', [whatspeak.Count]));
  lognow(format('Формат текста плэйлиста: %s', [gui.pltitleformat]));
  lognow(format('Формат текста на дисплее: %s', [gui.disptitleformat]));
  lognow(format('Минимальная длина надписи для пролистывания: %d', [gui.Min_to_scroll]));
  lognow(format('Время произношения одного символа: %d', [gui.speakchar]));
  lognow(format('Всего в генераторе случайных чисел: %d', [gui.Rand.maximal]));
  lognow('Поддержка всех частот: ' + booltostr(DSCAPS_CONTINUOUSRATE and
    bi.flags <> 0, True));
  lognow('Эмуляция: ' + booltostr(DSCAPS_EMULDRIVER and bi.flags <> 0, True));
  lognow('Сертифицирован: ' + booltostr(DSCAPS_CERTIFIED and bi.flags <> 0, True));
  lognow('Аппаратное моно: ' + booltostr(DSCAPS_SECONDARYMONO and bi.flags <> 0, True));
  lognow('Аппаратное стерео: ' + booltostr(DSCAPS_SECONDARYSTEREO and
    bi.flags <> 0, True));
  lognow('Аппаратное 8-разрядное: ' + booltostr(DSCAPS_SECONDARY8BIT and
    bi.flags <> 0, True));
  lognow('Аппаратное 16-разрядное: ' + booltostr(DSCAPS_SECONDARY16BIT and
    bi.flags <> 0, True));
  lognow('Аппаратная память (всего): ' + IntToStr(bi.hwsize));
  lognow('Аппаратная память (свободно): ' + IntToStr(bi.hwfree));
  lognow('Свободно слотов семплов: ' + IntToStr(bi.freesam));
  lognow('Свободно слотов 3D семплов: ' + IntToStr(bi.free3d));
  lognow('Частоты: ' + IntToStr(bi.minrate) + '-' + IntToStr(bi.maxrate));
  lognow('Драйвер: ' + bi.driver);
  lognow('Подсчет...');
  Filllength;
  tl := 0;
  for i := 0 to mainlist.Count - 1 do
    tl := tl + PTag(MainList.items[i])^.duration;
  h := (tl div 3600);
  if h > 0 then
    m := (tl mod 3600) div 60
  else
    m := tl div 60;
  if h > 0 then
    s := tl - (h * 3600 + m * 60)
  else
    s := tl mod 60;
  lognow('Общее время: ' + Format('%.2d:%.2d:%.2d', [h, m, s]));
end;

procedure Tinfoform.MemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  HideCaret(mem.Handle);
end;

procedure Tinfoform.FormActivate(Sender: TObject);
begin
  HideCaret(mem.Handle);
end;

end.
