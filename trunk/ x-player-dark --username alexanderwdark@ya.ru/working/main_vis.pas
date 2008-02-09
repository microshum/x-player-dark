
unit main_vis;

interface

uses
  Classes, Forms, spectrum_vis,
  Dialogs, Bass, CommonTypes, gui, ExtCtrls, Controls, Menus;

type
  TFormPlayer = class (TForm)
    PaintFrame: TPaintBox;
    TimerRender: TTimer;
    BackImageRes: TImage;
    pm: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    CD: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure TimerRenderTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer;
      var Resize: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPlayer: TFormPlayer;

implementation

{$R *.dfm}

procedure TFormPlayer.FormCreate(Sender: TObject);
begin
  Spectrum      := TSpectrum.Create(PaintFrame.Width, PaintFrame.Height);
  FormPlayer.Color := spectrumbgcolor;
  Spectrum.BackColor := spectrumbgcolor;
  Spectrum.Peak := spectrumpeakcolor;
  Spectrum.Pen  := spectrumcolor;
  TimerRender.Interval := spectruminterval;
  TimerRender.Enabled := True;
end;


procedure TFormPlayer.TimerRenderTimer(Sender: TObject);
var
  FFTFata: TFFTData;
begin
  if not FormPlayer.Visible then
    Exit;
  if BASS_ChannelIsActive(playstream) <> BASS_ACTIVE_PLAYING then
    Exit;
  BASS_ChannelGetData(playstream, @FFTFata, BASS_DATA_FFT1024);
  Spectrum.Draw(PaintFrame.Canvas.Handle, FFTFata, 10, -10);
end;

procedure TFormPlayer.FormResize(Sender: TObject);
begin
  PaintFrame.Top      := 10;
  PaintFrame.Left     := 10;
  PaintFrame.Width    := FormPlayer.Width - 30;
  PaintFrame.Height   := FormPlayer.Height - 40;
  timerrender.Enabled := False;
  Spectrum.Free;
  if formplayer.Color <> spectrumbgcolor then
    formplayer.Color := spectrumbgcolor;
  Spectrum := TSpectrum.Create(PaintFrame.Width, PaintFrame.Height);
  Spectrum.BackColor := spectrumbgcolor;
  Spectrum.Peak := spectrumpeakcolor;
  Spectrum.Pen := spectrumcolor;
  timerrender.Enabled := True;
end;

procedure TFormPlayer.FormDestroy(Sender: TObject);
begin
  TimerRender.Enabled := False;
  Spectrum.Free;
end;

procedure TFormPlayer.N1Click(Sender: TObject);
begin
  cd.Color := spectrumbgcolor;
  if cd.Execute then
    begin
    spectrumbgcolor := cd.Color;
    formplayer.FormResize(self);
    end;
end;

procedure TFormPlayer.N2Click(Sender: TObject);
begin
  cd.Color := spectrumcolor;
  if cd.Execute then
    begin
    spectrumcolor := cd.Color;
    formplayer.FormResize(self);
    end;

end;

procedure TFormPlayer.N3Click(Sender: TObject);
begin
  cd.Color := spectrumpeakcolor;
  if cd.Execute then
    begin
    spectrumpeakcolor := cd.Color;
    formplayer.FormResize(self);
    end;

end;

procedure TFormPlayer.FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer;
  var Resize: boolean);
begin
  resize := (newwidth > 100) and (newheight > 100);
end;

end.
