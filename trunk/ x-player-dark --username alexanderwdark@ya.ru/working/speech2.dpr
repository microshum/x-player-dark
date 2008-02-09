program Speech2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  voiceapi in 'voiceapi.pas',
  Cfg in 'cfg.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Voice engine setup';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
