unit spectrum_vis;

{ Spectrum Visualyzation by Alessandro Cappellozza
  version 0.8 05/2002
  http://digilander.iol.it/Kappe/audioobject
}

interface

uses Windows, Dialogs, Graphics, SysUtils, CommonTypes, Classes;

type
  TSpectrum = class (TObject)
  private
    VisBuff: TBitmap;
    BackBmp: TBitmap;

    BkgColor:   TColor;
    SpecHeight: integer;
    PenColor:   TColor;
    PeakColor:  TColor;
    DrawType:   integer;
    DrawRes:    integer;
    FrmClear:   boolean;
    PeakFall:   integer;
    LineFall:   integer;
    ColWidth:   integer;
    ShowPeak:   boolean;

    FFTPeacks:  array [0..128] of integer;
    FFTFallOff: array [0..128] of integer;

  public
    constructor Create(Width, Height: integer);
    procedure Draw(HWND: THandle; FFTData: TFFTData; X, Y: integer);
    procedure SetBackGround(Active: boolean; BkgCanvas: TGraphic);

    property BackColor: TColor Read BkgColor Write BkgColor;
    property Height: integer Read SpecHeight Write SpecHeight;
    property Width: integer Read ColWidth Write ColWidth;
    property Pen: TColor Read PenColor Write PenColor;
    property Peak: TColor Read PeakColor Write PeakColor;
    property Mode: integer Read DrawType Write DrawType;
    property Res: integer Read DrawRes Write DrawRes;
    property FrameClear: boolean Read FrmClear Write FrmClear;
    property PeakFallOff: integer Read PeakFall Write PeakFall;
    property LineFallOff: integer Read LineFall Write LineFall;
    property DrawPeak: boolean Read ShowPeak Write ShowPeak;
  end;

var
  Spectrum: TSpectrum;

implementation

constructor TSpectrum.Create(Width, Height: integer);
begin
  VisBuff := TBitmap.Create;
  BackBmp := TBitmap.Create;

  VisBuff.Width  := Width;
  VisBuff.Height := Height;
  BackBmp.Width  := Width;
  BackBmp.Height := Height;

  BkgColor   := clBlack;
  SpecHeight := 100;
  PenColor   := clWhite;
  PeakColor  := clYellow;
  DrawType   := 0;
  DrawRes    := 1;
  FrmClear   := True;
  PeakFall   := 1;
  LineFall   := 3;
  ColWidth   := 5;
  ShowPeak   := True;
end;

procedure TSpectrum.SetBackGround(Active: boolean; BkgCanvas: TGraphic);
begin
  BackBmp.Canvas.Draw(0, 0, BkgCanvas);
end;

procedure TSpectrum.Draw(HWND: THandle; FFTData: TFFTData; X, Y: integer);
var
  i, YPos: longint;
  YVal:    single;
begin
  if FrmClear then
    begin
    VisBuff.Canvas.Pen.Color   := BkgColor;
    VisBuff.Canvas.Brush.Color := BkgColor;
    VisBuff.Canvas.Rectangle(0, 0, VisBuff.Width, VisBuff.Height);
    end;

  VisBuff.Canvas.Pen.Color := PenColor;
  for i := 0 to 128 do
    begin
    YVal := Abs(FFTData[(i * DrawRes) + 5]);
    YPos := Trunc((YVal) * 500);
    if YPos > Height then
      YPos := SpecHeight;

    if YPos >= FFTPeacks[i] then
      FFTPeacks[i] := YPos
    else
      FFTPeacks[i] := FFTPeacks[i] - PeakFall;

    if YPos >= FFTFallOff[i] then
      FFTFallOff[i] := YPos
    else
      FFTFallOff[i] := FFTFallOff[i] - LineFall;

    if (VisBuff.Height - FFTPeacks[i]) > VisBuff.Height then
      FFTPeacks[i] := 0;
    if (VisBuff.Height - FFTFallOff[i]) > VisBuff.Height then
      FFTFallOff[i] := 0;

    if ShowPeak then
      VisBuff.Canvas.Pen.Color := PeakColor;
    if ShowPeak then
      VisBuff.Canvas.MoveTo(X + i * (ColWidth + 1), Y + VisBuff.Height - FFTPeacks[i]);
    if ShowPeak then
      VisBuff.Canvas.LineTo(X + i * (ColWidth + 1) + ColWidth, Y +
        VisBuff.Height - FFTPeacks[i]);

    VisBuff.Canvas.Pen.Color   := PenColor;
    VisBuff.Canvas.Brush.Color := PenColor;
    VisBuff.Canvas.Rectangle(X + i * (ColWidth + 1),
      Y + VisBuff.Height - FFTFallOff[i], X + i * (ColWidth + 1) +
      ColWidth, Y + VisBuff.Height);
    end;

  BitBlt(HWND, 0, 0, VisBuff.Width, VisBuff.Height,
    VisBuff.Canvas.Handle, 0, 0, srccopy);

end;

end.
