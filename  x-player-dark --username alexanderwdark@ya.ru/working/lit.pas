{$define wma}//WMA формат, WMA Tag editor
{$define flac}//FLAC формат, FLAC Tag editor
 //{$define float} //IEEE Float качество, но некоторые плагины конфликтуют

unit lit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, basscd, bass, FileCtrl, shellapi,
  strutils,mainwma, about, xrand;

type
  Tplaylist = class (TForm)
    ListBox1: TListBox;
    DF:      TButton;
    DEL:     TButton;
    misc:    TButton;
    pan:     TTrackBar;
    volume:  TTrackBar;
    Button1: TButton;
    PM:      TPopupMenu;
    N1:      TMenuItem;
    N2:      TMenuItem;
    mm:      TPopupMenu;
    newlst:  TMenuItem;
    N4:      TMenuItem;
    N5:      TMenuItem;
    PopupMenu: TPopupMenu;
    N7:      TMenuItem;
    N8:      TMenuItem;
    N6:      TMenuItem;
    N9:      TMenuItem;
    cdlist:  TMenuItem;
    CDTE:    TMenuItem;
    devices: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    link:    TLabel;
    N3:      TMenuItem;
    N10:     TMenuItem;
    N110:    TMenuItem;
    N12:     TMenuItem;
    sbl:     TMenuItem;
    N11:     TMenuItem;
    N13:     TMenuItem;
    N14:     TMenuItem;
    N15:     TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    remlist: TMenuItem;
    kdisk: TMenuItem;
    hdisk: TMenuItem;
    N24: TMenuItem;
    procedure PopupMenuPopup(Sender: TObject);
    procedure mmPopup(Sender: TObject);
    procedure DFClick(Sender: TObject);
    procedure DELClick(Sender: TObject);
    procedure miscClick(Sender: TObject);
    procedure panChange(Sender: TObject);
    procedure volumeChange(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure CDTEClick(Sender: TObject);
    procedure newlstClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ShowLoad(s: string);
    procedure FreeLoad;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure oncreate(Sender: TObject);
    procedure linkClick(Sender: TObject);
    procedure linkMouseEnter(Sender: TObject);
    procedure linkMouseLeave(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer;
      var Resize: boolean);
    procedure N10Click(Sender: TObject);
    procedure about(Sender: TObject);
    procedure shbl(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMDROPFILES(var Message: TWMDROPFILES); message WM_DROPFILES;
  public
    { Public declarations }
procedure    addfiles(s:string);
procedure playfromrem(sender:tobject);                             
procedure adddir(s:string);
  end;

function tagprepare(s:string):string;  
var
  playlist: Tplaylist;

var
  oldcap: string = '';


implementation

uses GUI, info, MainW, MainOGG, fx, dsp, main, unit4, Unit2, MainFlac, bl;

{$R *.dfm}


procedure tplaylist.playfromrem(sender:tobject);

var
  Dir:    string;
  t1, t2: boolean;
begin
  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
    begin
    ShowLoad('Загрузка...');
    listbox1.Items.BeginUpdate;
if frmmp3.checkdrive((sender as tmenuitem).Caption+':') then
    frmmp3.findfiles((sender as tmenuitem).Caption+':');
    listbox1.Items.EndUpdate;
    FreeLoad;
    end;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled  := t2;

end;

function tagprepare(s:string):string;
begin
result:='';
s:=trim(s);
s:=ansireplacetext(s,#13,' ');
s:=ansireplacetext(s,#10,'');
result:=s;
end;


procedure Tplaylist.ShowLoad(s: string);
begin
  oldcap := frmmp3.Label1.Caption;
  frmmp3.Label1.Caption := 'Ждите...';
  application.CreateForm(TLoadForm, LoadForm);
  loadform.Title.Caption := s;
  loadform.Show;
  loadform.Update;
end;

procedure Tplaylist.FreeLoad;
begin
  frmmp3.Label1.Caption := oldcap;
  LoadForm.Free;
end;


procedure Tplaylist.PopupMenuPopup(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to cdlist.Count - 1 do
    cdlist.Items[i].Enabled := BASS_CD_IsReady(i);
  n8.Enabled := (listbox1.Count > 0) and (listbox1.ItemIndex <> -1);
end;

procedure Tplaylist.mmPopup(Sender: TObject);
begin
  newlst.Enabled := listbox1.Items.Count > 0;
end;

procedure Tplaylist.DFClick(Sender: TObject);
begin
  df.Enabled := False;
  pm.Popup(playlist.left + df.Left, playlist.top + df.Top - 20);
  df.Enabled := True;

end;

procedure Tplaylist.DELClick(Sender: TObject);
var
  NUM: integer;
begin
  num := listbox1.ItemIndex;
  if (listbox1.Items.Count > 0) and (NUM <> -1) then
    begin
    Listbox1.Items.Delete(NUM);
    Dispose(mainlist.Items[Num]);
    mainlist.Items[Num] := nil;
    mainlist.Delete(NUM);
    end;

end;

procedure Tplaylist.miscClick(Sender: TObject);
begin
  misc.Enabled := False;
  mm.Popup(playlist.Left + misc.Left, playlist.Top + misc.Top - 20);
  misc.Enabled := True;

end;

procedure Tplaylist.panChange(Sender: TObject);
begin
  BASS_ChannelSetAttributes(playstream, -1, -1, pan.Position);
end;

procedure Tplaylist.volumeChange(Sender: TObject);
begin
  BASS_ChannelSetAttributes(playstream, -1, Volume.Position, -101);
end;

procedure Tplaylist.N7Click(Sender: TObject);
begin
  application.CreateForm(Tinfoform, infoform);
  infoform.ShowModal;
  infoform.Release;

end;

procedure Tplaylist.N8Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex < 0) and (listbox1.Items.Count > 0) then
    listbox1.ItemIndex := 0;
  if listbox1.ItemIndex <> -1 then
    begin
if ishttp(PTag(MainList.items[ListBox1.ItemIndex])^.fname) then begin
showmessage(Format('HTTP радио, URL=%s',[PTag(MainList.items[ListBox1.ItemIndex])^.fname]));
end else

begin
    if AnsiUpperCase(ExtractFileExt(PTag(MainList.items[ListBox1.ItemIndex])^.fname)) =
      '.WAV' then
      begin
      application.CreateForm(TID3EDITW, id3editw);
      id3editw.ShowModal;
      id3editw.Release;
      end;


    if AnsiUpperCase(ExtractFileExt(PTag(MainList.items[ListBox1.ItemIndex])^.fname)) =
      '.MP3' then
      begin
      application.CreateForm(TID3EDIT, id3edit);
      id3edit.ShowModal;
      id3edit.Release;
      end;

    if AnsiUpperCase(ExtractFileExt(PTag(MainList.items[ListBox1.ItemIndex])^.fname)) =
      '.OGG' then
      begin
      application.CreateForm(TID3EDITOGG, id3editOGG);
      id3editogg.ShowModal;
      id3editogg.Release;
      end;
    {$ifdef flac}
    if AnsiUpperCase(ExtractFileExt(PTag(MainList.items[ListBox1.ItemIndex])^.fname)) =
      '.FLAC' then
      begin
      application.CreateForm(TID3EDITF, id3editf);
      id3editf.ShowModal;
      id3editf.Release;
      end;
{$endif flac}
    {$ifdef wma}

    if AnsiUpperCase(ExtractFileExt(PTag(MainList.items[ListBox1.ItemIndex])^.fname)) =
      '.WMA' then
      begin
      application.CreateForm(TID3EDITWM, id3editwm);
      id3editwm.ShowModal;
      id3editwm.Release;
      end;
{$endif wma}

end;
    end;

end;

procedure Tplaylist.N6Click(Sender: TObject);
begin
  if FrmSearch = nil then
    application.CreateForm(TFrmSearch, FrmSearch);
  if playlist.Top + playlist.Height + frmsearch.Height <= screen.Height then
    begin
    frmSearch.Top  := playlist.Top + playlist.Height;
    frmSearch.Left := playlist.Left;
    end
  else
    begin
    frmSearch.Top  := playlist.Top + playlist.Height - frmsearch.Height;
    frmSearch.Left := playlist.Left;
    end;
  frmSearch.Show;

end;

procedure Tplaylist.N9Click(Sender: TObject);
begin
  if FrmDSP = nil then
    application.CreateForm(TFrmDSP, FrmDSP);
  frmdsp.Show;
  frmdsp.InitX;

end;

procedure Tplaylist.CDTEClick(Sender: TObject);
begin
  if Drivex = -1 then
    if CdList.Count = 1 then
      DriveX := 0;
  Application.CreateForm(TFrmTe, FrmTe);
  frmTE.ShowModal;
  frmTE.Release;

end;

procedure Tplaylist.newlstClick(Sender: TObject);
begin
  mainlist.Clear;
  listbox1.Clear;
  ListPos := 0;

end;

procedure Tplaylist.N4Click(Sender: TObject);
begin
  savedialog.Filter := 'Xamp File List (*.lst)|*.lst|WinAmp M3U (*.m3u)|*.m3u';
  if savedialog.Execute then
    case savedialog.FilterIndex
      of
      1:
        frmmp3.savelist(ChangeFileExt(savedialog.FileName, '.lst'));
      2:
        frmmp3.savem3ulist(ChangeFileExt(savedialog.FileName, '.m3u'));
      end;

end;

procedure Tplaylist.N5Click(Sender: TObject);
var
  ext: string;
begin
  opendialog.Filter :=
    'Xamp File List (*.lst)|*.lst|Winamp M3U (*.m3u)|*.m3u|Winamp PLS (*.pls)|*.pls';
  if OpenDialog.Execute then
    if FileExists(OpenDialog.FileName) then
      begin
      ext := AnsiUpperCase(ExtractFileExt(opendialog.FileName));
      if ext = '.M3U' then
        frmmp3.LoadM3u(OpenDialog.FileName)
      else
      if ext = '.LST' then
        frmmp3.LoadList(OpenDialog.FileName)
      else
      if ext = '.PLS' then
        frmmp3.LoadPLS(OpenDialog.FileName);
      end;

end;

procedure Tplaylist.N1Click(Sender: TObject);
var
  i:      integer;
  dum:    PTag;
  t1, t2: boolean;
begin
  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
  Opendialog.Filter :=
    'Все форматы|*.ogg;*.mp?;' +
{$IFDEF WMA}
    '*.wma;' +
{$ENDIF WMA}
{$IFDEF FLAC}
    '*.flac;' +
    {$ENDIF FLAC}
    '*.wav;*.cda|MPEG Audio  (*.mp1,*.mp2;*.mp3)|*.mp?|Ogg Vorbis (*.ogg)|*.ogg|'
        {$IFDEF WMA}
    + 'Windows Media Audio (*.wma)|*.wma|'
    {$ENDIF WMA}
{$IFDEF FLAC}
    + 'FLAC AUDIO (*.flac)|*.flac|'
{$ENDIF FLAC}
    + 'Wave File (*.wav)|*.wav|CD Track File|*.cda';
  if OpenDialog.Execute then
    begin
    showload('Загрузка...');
    for i := 0 to opendialog.Files.Count - 1 do
      begin
      New(dum);
      frmmp3.Getinfo(opendialog.Files[i], dum);
      mainlist.Add(dum);
      if dum^.notag then
        listbox1.Items.Append(dum^.title)
      else
        listbox1.Items.Append(frmmp3.Xformat(pltitleformat, dum));
      end;
    freeload;
    end;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled  := t2;
end;

procedure Tplaylist.N2Click(Sender: TObject);
var
  Dir:    string;
  t1, t2: boolean;
begin
  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
  SelectDirectory('Укажите каталог с аудио файлами:', '', Dir);
  if (Dir <> '') then
    begin
    ShowLoad('Загрузка...');
    listbox1.Items.BeginUpdate;
    if DirectoryExists(Dir) then if frmmp3.checkdrive(Dir) then FrmMp3.FindFiles(Dir);
    listbox1.Items.EndUpdate;
    FreeLoad;
    end;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled  := t2;
end;

procedure Tplaylist.ListBox1Click(Sender: TObject);
begin
  if playlist.ListBox1.ItemIndex = -1 then
    EXIT;
  if playlist.ListBox1.Items.Count > 0 then
    ListPos := playlist.ListBox1.ItemIndex;
end;

procedure Tplaylist.ListBox1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  idX: integer;
begin
  if (playlist.ListBox1.Items.Count = 0) then
    Exit;
  if Key = vk_Return then
    begin
    ListPos := playlist.ListBox1.ItemIndex;
    frmmp3.PuskClick(Self);
    end;

  if Key = vk_Delete then
    begin
    idx := playlist.ListBox1.ItemIndex;
    if (idx <> -1) then
      begin
      playlist.ListBox1.Items.Delete(idx);
      MainList.Delete(idx);
      end;
    end;

end;

procedure Tplaylist.ListBox1DblClick(Sender: TObject);
begin
  frmmp3.puskClick(self);
end;

procedure Tplaylist.FormResize(Sender: TObject);
begin
  listbox1.Items.BeginUpdate;
  listbox1.Left   := 10;
  listbox1.Width  := playlist.Width - 25;
  listbox1.top    := 10;
  listbox1.Height := playlist.Height - 76;
  if listbox1.Width > plmintoinc then
    listbox1.Font.Size := plbf
  else
    listbox1.Font.Size := plsf;
  listbox1.Items.EndUpdate;
  df.Top      := listbox1.Height + 20;
  del.Top     := listbox1.Height + 20;
  misc.Top    := listbox1.Height + 20;
  button1.Top := listbox1.Height + 20;
  pan.Top     := misc.Top - 4;
  volume.Top  := misc.Top - 4;
  link.Top    := misc.Top;
end;

procedure Tplaylist.oncreate(Sender: TObject);
var
  cdinfo: bass_cd_info;prm,ext:string;
  a, i,dt:   longint;
  n:      PChar;
  m:      TMenuItem;
  Text, pref,s: string;
begin

//
s:='';
  for i := 0 to 31 do
      begin
      dt := getdrivetype(PChar(char(byte('A') + i) + ':\'));
      if (i <> 0) and (dt = DRIVE_REMOVABLE) then
       begin
       m:=Tmenuitem.Create(remlist);
       m.Caption:=char(byte('A') + i);
       m.OnClick:=playfromrem;
       remlist.Add(m);
       end;

      end;

//

//
s:='';
  for i := 0 to 31 do
      begin
      dt := getdrivetype(PChar(char(byte('A') + i) + ':\'));
      if (i <> 0) and (dt = DRIVE_CDROM) then
       begin
       m:=Tmenuitem.Create(kdisk);
       m.Caption:=char(byte('A') + i);
       m.OnClick:=playfromrem;
       kdisk.Add(m);
       end;

      end;

//

//
s:='';
  for i := 0 to 31 do
      begin
      dt := getdrivetype(PChar(char(byte('A') + i) + ':\'));
      if (i <> 0) and (dt = DRIVE_FIXED) then
       begin
       m:=Tmenuitem.Create(hdisk);
       m.Caption:=char(byte('A') + i);
       m.OnClick:=playfromrem;
       hdisk.Add(m);
       end;

      end;

//


n21.enabled:=fileexists(ExtractFilePath(Application.ExeName)+'darkcfg.exe');
n22.enabled:=fileexists(ExtractFilePath(Application.ExeName)+'speech2.exe');
n23.enabled:=fileexists(ExtractFilePath(Application.ExeName)+'ed.exe');
  if (pltop <> -1) and (plleft <> -1) and (plheight <> -1) and (plwidth <> -1) then
    begin
    playlist.Top    := pltop;
    playlist.Left   := plleft;
    playlist.Height := plheight;
    playlist.Width  := plwidth;
    end
  else
    begin
    playlist.Width  := frmmp3.Width;
    playlist.Height := frmmp3.Height;
    if frmmp3.Top + frmmp3.Height + playlist.Height >= screen.Width then
      playlist.Top := frmmp3.Top - playlist.Height
    else
      playlist.Top := frmmp3.Top + frmmp3.Height;
    playlist.Left := frmmp3.Left;
    end;
  a := 0;
  n := BASS_CD_GetDriveDescription(a);

  while (a < 10) and (n <> nil) do
    begin
    BASS_CD_GetInfo(a, cdinfo);
    if cdinfo.cdtext then
      pref := 'CD-Text'
    else
      pref := '';
    if (BASS_CD_RWFLAG_READDVD and cdinfo.rwflags <> 0) then
      Text := Format('%s: %s %dx %d Kb (DVD) %s',
        [char(BASS_CD_GetDriveLetter(a) + Ord('A')), n, cdinfo.maxspeed div
        176, cdinfo.cache, pref])
    else
      Text := Format('%s: %s %dx %d Kb %s',
        [char(BASS_CD_GetDriveLetter(a) + Ord('A')), n, cdinfo.maxspeed div
        176, cdinfo.cache, pref]);

    m := TMenuItem.Create(cdlist);
    cdlist.Add(m);
    m.Caption := Text;
    m.OnClick := frmmp3.UpdateTrackList;
    Inc(a);
    n := BASS_CD_GetDriveDescription(a);
    end;

  i := 0;
  n := bass.BASS_GetDeviceDescription(i);
  while n <> nil do
    begin
    m := TMenuItem.Create(devices);
    devices.Add(m);
    m.Caption := Format('[%d] %s', [i, string(n)]);
    m.OnClick := frmmp3.SelectDevice;
    Inc(i);
    n := bass.BASS_GetDeviceDescription(i);
    end;

  playlist.CDTE.Enabled := playlist.cdList.Count > 0;
  if not playlist.CDTE.Enabled then
    begin
    playlist.CDLIST.Enabled := False;
    playlist.CDTE.Caption   := 'CD устройства не найдены';
    end;
prm:=sysutils.AnsiDequotedStr(paramstr(1),'"');
if ansilowercase(prm)='-register' then
begin
frmmp3.Regit;
prm:='';
end;
if (prm<>'') then begin
if extractfiledir(prm)='' then if (fileexists(mypath+prm) or directoryexists(mypath+prm)) then prm:=mypath+prm;
if directoryexists(prm) then adddir(prm)
else if fileexists(prm) then begin
ext:=ansilowercase(extractfileext(prm));
 if ext = '.m3u' then
        frmmp3.LoadM3u(prm)
      else
      if ext = '.lst' then
        frmmp3.LoadList(prm)
      else
      if ext = '.pls' then
        frmmp3.LoadPLS(prm)
        else addfiles(prm);
     end;
if ansilowercase(paramstr(2))='-play' then frmmp3.pusk.Click;
end else begin
  if fileexists(mypath + 'playlist.lst') then
      frmmp3.loadlist(mypath + 'playlist.lst');
end;
  frmmp3.Timer.Enabled  := True;
  frmmp3.Timer1.Enabled := True;
  pan.Position    := span;
  volume.Position := svol;
  DragAcceptFiles(playlist.Handle, True);
end;

procedure Tplaylist.linkClick(Sender: TObject);
begin
  shellapi.ShellExecute(handle, 'open',
    'http://www.hotcd.ru/cgi-bin/index.pl?0==0==0==darksoftware',
    '', '', sw_show);

end;

procedure Tplaylist.linkMouseEnter(Sender: TObject);
begin
  (Sender as tlabel).Font.Color := clRed;
end;

procedure Tplaylist.linkMouseLeave(Sender: TObject);
begin
  (Sender as tlabel).Font.Color := clBlack;
end;

procedure Tplaylist.WMDROPFILES(var Message: TWMDROPFILES);
var
  Files:  longint;
  I:      longint;
  Buffer: array[0..MAX_PATH] of char;
  dum:    PTag;
  ext:    string;
begin
  Files := DragQueryFile(Message.Drop, $FFFFFFFF, nil, 0);
  for I := 0 to Files - 1 do
    begin
    DragQueryFile(Message.Drop, I, @Buffer, SizeOf(Buffer));
    Ext := AnsiUpperCase(ExtractFileExt(Buffer));
    if ((Ext = '.MP1') or (Ext = '.MP2') or (Ext = '.MP3') or (Ext = '.OGG')
{$ifdef wma}
      or (Ext = '.WMA')
{$endif wma}
      or (Ext = '.WAV') or (Ext = '.CDA')
{$ifdef FLAC}
      or (Ext = '.FLAC')
{$ENDIF FLAC}
      ) then
      begin
      New(dum);
      frmmp3.Getinfo(buffer, dum);
      mainlist.Add(dum);
      if dum^.notag then
        listbox1.Items.Append(dum^.title)
      else
        listbox1.Items.Append(frmmp3.Xformat(pltitleformat, dum));
      end
    else
    if ext = '.M3U' then
      frmmp3.LoadM3u(buffer)
    else
    if ext = '.LST' then
      frmmp3.LoadList(buffer)
    else
    if ext = '.PLS' then
      frmmp3.LoadPLS(buffer)
    else
      begin
      if filegetattr(buffer) and faDirectory <> 0 then
        frmmp3.FindFiles(buffer);
      end;

    end;
  DragFinish(Message.Drop);
end;

procedure Tplaylist.N3Click(Sender: TObject);
begin
  frmmp3.Showvis(self);
end;

procedure Tplaylist.FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer;
  var Resize: boolean);
begin
  resize := (newwidth >= frmmp3.Width) and (newheight >= frmmp3.Height div 2);
  if not resize then
    begin
    playlist.Width  := frmmp3.Width;
    playlist.Height := frmmp3.Height;
    end;
end;

procedure Tplaylist.N10Click(Sender: TObject);
var
  i: integer;
begin
  if mainlist.Count = 0 then
    exit;
  for i := 0 to mainlist.Count - 1 do
    begin
    if (pos('*CD', ptag(mainlist[i]).fname) = 0) and (not ishttp(ptag(mainlist[i]).fname)) then
      if not fileexists(ptag(mainlist[i]).fname) then
        begin
        playlist.ListBox1.Items.Delete(i);
        MainList.Delete(i);
        end;
    end;
end;

procedure Tplaylist.about(Sender: TObject);
begin
  with tsimplyabout.Create(self) do
    begin
    showmodal;
    Free;
    end;
end;

procedure Tplaylist.shbl(Sender: TObject);
begin
  if blacklist.Visible then
    blacklist.Hide
  else
    blacklist.Show;

end;

procedure Tplaylist.N12Click(Sender: TObject);
var
  bl: pbl;
begin
  if listbox1.ItemIndex = -1 then
    exit;
  new(bl);
  bl^.Name := ptag(mainlist[listbox1.ItemIndex]).fname;
  blist.Add(bl);
  blacklist.listbox1.Items.Add(bl^.Name);
end;

procedure Tplaylist.N14Click(Sender: TObject);
var
  list: TList;
  str:  TStringList;
  ra:   TRandom;
  i, n: integer;
begin
  if mainlist.Count = 0 then
    exit;
  list := TList.Create;
  str  := TStringList.Create;
  ///
  listbox1.Items.BeginUpdate;
  ra := TRandom.Create(mainlist.Count);
  for i := 0 to mainlist.Count - 1 do
    begin
    n := ra.Random(mainlist.Count - 1);
    list.Add(mainlist[n]);
    str.Append(listbox1.Items[n]);
    end;
  ///
  mainlist.Assign(list);
  listbox1.Items.Assign(str);
  list.Free;
  str.Free;
  listbox1.Items.EndUpdate;
end;

procedure Tplaylist.addfiles(s:string);
var
  i:      integer;
  dum:    PTag;
  t1, t2: boolean;
begin
  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
      showload('Загрузка...');
      New(dum);
      frmmp3.Getinfo(s, dum);
      mainlist.Add(dum);
      if dum^.notag then
        listbox1.Items.Append(dum^.title)
      else
        listbox1.Items.Append(frmmp3.Xformat(pltitleformat, dum));
      freeload;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled  := t2;
end;


procedure Tplaylist.adddir(s:string);
var
  Dir:    string;
  t1, t2: boolean;
begin
  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
  if (s <> '') then
    begin
    ShowLoad('Загрузка...');
    listbox1.Items.BeginUpdate;
    if DirectoryExists(s) then if frmmp3.CheckDrive(s) then
      FrmMp3.FindFiles(s);
    listbox1.Items.EndUpdate;
    FreeLoad;
    end;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled  := t2;
end;


procedure Tplaylist.N18Click(Sender: TObject);
begin
frmmp3.regit;
end;

procedure Tplaylist.N21Click(Sender: TObject);
begin
  shellapi.ShellExecute(handle, 'open',
    PChar(ExtractFilePath(Application.ExeName)+'darkcfg.exe'),
    '', PChar(ExtractFilePath(Application.ExeName)), sw_show);
frmmp3.close;
end;

procedure Tplaylist.N22Click(Sender: TObject);
begin
  shellapi.ShellExecute(handle, 'open',
    PChar(ExtractFilePath(Application.ExeName)+'speech2.exe'),
    '', PChar(ExtractFilePath(Application.ExeName)), sw_show);
frmmp3.close;
end;

procedure Tplaylist.N23Click(Sender: TObject);
begin
  shellapi.ShellExecute(handle, 'open',
    PChar(ExtractFilePath(Application.ExeName)+'ed.exe'),
    '', PChar(ExtractFilePath(Application.ExeName)), sw_show);
frmmp3.close;
end;

procedure Tplaylist.N24Click(Sender: TObject);
var
  i:      integer;
  dum:    PTag;
  t1, t2: boolean;url:string;
begin
  t1 := frmmp3.timer1.Enabled;
  t2 := frmmp3.timer.Enabled;
  frmmp3.timer1.Enabled := False;
  frmmp3.timer.Enabled := False;
    begin
    showload('Загрузка...');

url:=trim(inputbox('Добавить радио:','URL',''));
if url<>'' then
      begin
   New(dum);
  frmmp3.GetinfoRadio(url, dum);
      mainlist.Add(dum);
      if dum^.notag then
        listbox1.Items.Append(dum^.title)
      else
        listbox1.Items.Append(frmmp3.Xformat(pltitleformat, dum));
      end;
    freeload;
    end;
  frmmp3.timer1.Enabled := t1;
  frmmp3.timer.Enabled  := t2;
end;

end.
