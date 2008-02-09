program darkcfg;

uses
  Forms,
  cfgmain in 'cfgmain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
