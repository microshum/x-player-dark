program ed;

uses
  Forms,
  edm in 'edm.pas' {edroot};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Редактор Voice.cfg';
  Application.CreateForm(Tedroot, edroot);
  Application.Run;
end.
