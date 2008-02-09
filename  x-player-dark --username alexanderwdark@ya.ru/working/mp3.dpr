program MP3;


uses
  Forms,
  GUI in 'GUI.pas' {frmMp3},
  Main in 'main.pas' {ID3EDIT},
  Bass in 'Bass.pas',
  OggVorbis in 'OggVorbis.pas',
  MainOGG in 'mainogg.pas' {ID3EDITOGG},
  BASSWMA in 'basswma.pas',
  fx in 'fx.pas' {frmSearch},
  Unit4 in 'unit4.pas' {frmTe},
  dsp in 'dsp.pas' {frmDSP},
  Unit2 in 'Unit2.pas' {LoadForm},
  cfg in 'cfg.pas',
  XRAND in 'XRAND.pas',
  voiceapi in 'voiceapi.pas',
  MainFlac in 'mainflac.pas' {ID3EDITF},
  WMAfile in 'wmafile.pas',
  MainW in 'mainw.pas' {ID3EDITW},
  info in 'info.pas' {infoform},
  lit in 'lit.pas' {playlist},
  main_vis in 'main_vis.pas' {FormPlayer},
  Mainwma in 'MainWMA.pas' {ID3EDITWM},
  about in 'about.pas' {simplyabout},
  bl in 'bl.pas' {blacklist};

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'X-Player';
  Application.CreateForm(TfrmMp3, frmMp3);
  Application.CreateForm(Tblacklist, blacklist);
  Application.CreateForm(Tplaylist, playlist);
  Application.CreateForm(TFormPlayer, FormPlayer);
  if plvis then
    playlist.Show;
  if blvis then
    blacklist.Show;
  Application.Run;
end.
