{$D-}
{$Q-}
{$L-}
{$Y-}
{$S-}
 {Простейшая реализация плагина для Total Commander 6+}
 {Исходный код 2003 XARC by DarkSoft}
 {Исходный код 2004 XARC4TC by DarkSoft}
 {Freeware}

library xarc4tc6;


uses
  XARCFSHELP,
  Classes,
  x_arc,
  fsplugin,
  Windows,
  SysUtils,
  Cfg in 'cfg.pas';

{$E wfx}
{$R xarc.res}

var
  PPROC: tProgressProc;
  PNum:  integer;

  function FsInit(PluginNr: integer; pProgressProc: tProgressProc;
    pLogProc: tLogProc; pRequestProc: tRequestProc): integer; stdcall;
  begin
    PProc  := pProgressProc;
    PNum   := PluginNr;
    Result := 0;
  end;

var
  founds:      bool = False;
var
  specialpath: bool = False;

  function FsFindFirst(path: PChar; var FindData: tWIN32FINDDATA): thandle;
  stdcall;
  begin
    if path = '\*options' then
      begin
      finddata.dwFileAttributes := Windows.FILE_ATTRIBUTE_NORMAL;
      finddata.ftCreationTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastAccessTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastWriteTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.nFileSizeLOW     := 0;
      finddata.nFileSizeHIGH    := 0;
      StrPCopy(finddata.cFileName, '.compact');
      StrPCopy(finddata.cAlternateFileName, '.compact');
      Result      := 0;
      specialpath := True;
      exit;
      end;
    founds      := False;
    specialpath := False;
    if a.AFindFirst('*.*') then
      begin
      finddata.dwFileAttributes := Windows.FILE_ATTRIBUTE_NORMAL;
      finddata.ftCreationTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastAccessTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastWriteTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.nFileSizeLOW     := (int64(a.found_rec.size) and maxdword);
      finddata.nFileSizeHIGH    := (int64(a.found_rec.size) shr 32 and maxdword);
      StrPCopy(finddata.cFileName, a.found_rec.Name);
      StrPCopy(finddata.cAlternateFileName, a.found_rec.Name);
      Result := 0;
      end
    else
      begin
      finddata.dwFileAttributes := Windows.FILE_ATTRIBUTE_NORMAL;
      finddata.ftCreationTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastAccessTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastWriteTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.nFileSizeLOW     := 0;
      finddata.nFileSizeHIGH    := 0;
      StrPCopy(finddata.cFileName, '.');
      StrPCopy(finddata.cAlternateFileName, '.');
      Result := 0;
      end;

  end;


  function FsFindNext(Hdl: thandle; var FindData: tWIN32FINDDATA): bool; stdcall;
  begin
    if not specialpath then
      if a.aFindNext then
        begin
        finddata.dwFileAttributes := Windows.FILE_ATTRIBUTE_NORMAL;
        finddata.ftCreationTime.dwLowDateTime := $FFFFFFFF;
        finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
        finddata.ftLastAccessTime.dwLowDateTime := $FFFFFFFF;
        finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
        finddata.ftLastWriteTime.dwLowDateTime := $FFFFFFFF;
        finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
        finddata.nFileSizeLOW     := (int64(a.found_rec.size) and maxdword);
        finddata.nFileSizeHIGH    := (int64(a.found_rec.size) shr 32 and maxdword);
        StrPCopy(finddata.cFileName, a.found_rec.Name);
        StrPCopy(finddata.cAlternateFileName, a.found_rec.Name);
        Result := True;
        exit;
        end;
    if not founds then
      begin
      finddata.dwFileAttributes := Windows.FILE_ATTRIBUTE_DIRECTORY;
      finddata.ftCreationTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastAccessTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.ftLastWriteTime.dwLowDateTime := $FFFFFFFF;
      finddata.ftCreationTime.dwHighDateTime := $FFFFFFFF;
      finddata.nFileSizeLOW     := 0;
      finddata.nFileSizeHIGH    := 0;
      StrPCopy(finddata.cFileName, '*options');
      StrPCopy(finddata.cAlternateFileName, '*options');
      founds := True;
      Result := True;
      exit;
      end;

    Result := False;
  end;

  function FsFindClose(Hdl: thandle): integer; stdcall;
  begin
    a.AFindClose;
  end;


  procedure FsGetDefRootName(DefRootName: PChar; maxlen: integer); stdcall;
  begin
    strlcopy(DefRootName, 'Darksoft xARC as FS', maxlen - 1);
  end;


  function FsGetFile(RemoteName, LocalName: PChar; CopyFlags: integer;
    RemoteInfo: pRemoteInfo): integer; stdcall;
  var
    Fi: Text;
  begin
    if remotename = '\*options\.compact' then
      begin
      //showmessage(localname);
      //assignfile(Fi,LocalName);
      //rewrite(Fi);
      //writeln(Fi,'Команда .compact используется для уплотнения архива после удаления из него файлов.');
      //writeln(Fi,'(с) 2004 DarkSoft ltd.');
      //closefile(Fi);
      Result := FS_FILE_OK;
      exit;
      end;

    if a.ExtractArc(ExtractFileName(RemoteName), ExtractFilePath(LocalName)) then
      Result := FS_FILE_OK
    else
      Result := FS_FILE_NOTFOUND;
    if CopyFlags and FS_COPYFLAGS_MOVE = FS_COPYFLAGS_MOVE then
      if a.DeleteArc(ExtractFileName(RemoteName)) then
        Result := FS_FILE_OK
      else
        Result := FS_FILE_NOTFOUND;
  end;


  function FsPutFile(LocalName, RemoteName: PChar; CopyFlags: integer): integer;
  stdcall;
  begin
    if a.addArc(LocalName) then
      Result := FS_FILE_OK
    else
      Result := FS_FILE_NOTFOUND;
    if CopyFlags and FS_COPYFLAGS_MOVE = FS_COPYFLAGS_MOVE then
      if DeleteFile(LocalName) then
        Result := FS_FILE_OK
      else
        Result := FS_FILE_NOTFOUND;
  end;

  function FsDeleteFile(RemoteName: PChar): bool; stdcall;
  begin
    if remotename = '\*options\.compact' then
      begin
      Result := True;
      exit;
      end;

    Result := A.DeleteArc(EXTRACTFILENAME(remotename));
  end;

  function FsExecuteFile(MainWin: thandle; RemoteName, Verb: PChar): integer;
  stdcall;
  begin
    if remotename = '\*options\.compact' then
      a.Compact;
    Result := FS_EXEC_YOURSELF;
  end;


exports
  FsInit,
  FsFindNext,
  FsFindFirst,
  FsFindClose,
  FsGetDefRootName,
  FsgetFile,
  FsPutFile,
  FsDeleteFile,
  FsExecuteFile;


begin

end.
