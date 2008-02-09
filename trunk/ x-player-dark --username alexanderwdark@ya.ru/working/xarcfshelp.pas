unit XARCFSHELP;

interface

uses
  x_arc, FSPLUGIN, cfg, Dialogs, SysUtils;

var
  A: TXARC;

var
  ArcName: string;

var
  Log: TLogProc;
  num: integer;

implementation

function libexit: boolean;
begin
  A.CloseArc;
  A.Free;
  Result := True;
end;

var
  cfg: TCFG;

initialization
  cfg     := TCFG.Create(extractfilepath(ParamStr(0)) + 'xarc.cfg');
  arcname := cfg.ReadString('path_to_arcvive', '');
  ///
  if (arcname = '') then
    begin
    arcname := inputbox('XARC as FS plugin for TC6+', 'Имя архива xarc',
      'c:\xarc_main.xarc');
    cfg.WriteString('path_to_arcvive', arcname);
    end;
  ///
  cfg.Free;
  A := TXARC.Create(nil);
  if not fileexists(arcname) then
    a.CreateArc(arcname)
  else
    a.openarc(arcname);

finalization
  libexit;

end.
