unit bl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, shellapi;

type
  Tblacklist = class (TForm)
    ListBox1: TListBox;
    DF:  TButton;
    DEL: TButton;
    pm:  TPopupMenu;
    N1:  TMenuItem;
    OpenDialog: TOpenDialog;
    procedure FormResize(Sender: TObject);
    procedure DELClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure DFClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer;
      var Resize: boolean);
  private
    { Private declarations }
    procedure WMDROPFILES(var Message: TWMDROPFILES); message WM_DROPFILES;
  public
    { Public declarations }
    procedure savelist(f: string);
    procedure loadlist(f: string);
  end;

var
  blacklist: Tblacklist;

implementation

uses gui;

{$R *.dfm}

procedure Tblacklist.FormResize(Sender: TObject);
begin
  listbox1.Items.BeginUpdate;
  listbox1.Left   := 10;
  listbox1.Width  := blacklist.Width - 25;
  listbox1.top    := 10;
  listbox1.Height := blacklist.Height - 76;
  if listbox1.Width > blmintoinc then
    listbox1.Font.Size := blbf
  else
    listbox1.Font.Size := blsf;
  listbox1.Items.EndUpdate;
  df.Top  := listbox1.Height + 20;
  del.Top := listbox1.Height + 20;
end;

procedure Tblacklist.DELClick(Sender: TObject);
var
  num: integer;
begin
  num := listbox1.ItemIndex;
  if (listbox1.Items.Count > 0) and (NUM <> -1) then
    begin
    Listbox1.Items.Delete(NUM);
    Dispose(blist.Items[Num]);
    blist.Items[Num] := nil;
    blist.Delete(NUM);
    end;

end;


procedure Tblacklist.SaveList(f: string);
var
  T: TextFile;
  i:    integer;
begin
  assignfile(t, f);
  rewrite(t);
  if blist.Count > 0 then
    for i := 0 to blist.Count - 1 do
      begin
      writeln(t, pbl(blist.Items[i])^.Name);
      end;
  closefile(t);
end;


procedure Tblacklist.LoadList(f: string);
var
  T: TextFile;
  s:    string;
  dum:  PBL;
begin
  ListBox1.Items.BeginUpdate;
  assignfile(t, f);
  reset(t);

  repeat
    readln(t, s);
    s := trim(s);
    if s <> '' then
      begin
      new(dum);
      dum.Name := s;
      blist.Add(dum);
      listbox1.Items.Add(dum^.Name);
      end;
  until EOF(t);
  closefile(t);
  ListBox1.Items.EndUpdate;
end;


procedure Tblacklist.FormCreate(Sender: TObject);
begin
  ////
  if (bltop <> -1) and (blleft <> -1) and (blheight <> -1) and (blwidth <> -1) then
    begin
    blacklist.Top    := bltop;
    blacklist.Left   := blleft;
    blacklist.Height := blheight;
    blacklist.Width  := blwidth;
    end
  else
    begin
    blacklist.Width  := frmmp3.Width;
    blacklist.Height := frmmp3.Height;
    if frmmp3.Top + frmmp3.Height + blacklist.Height >= screen.Width then
      blacklist.Top := frmmp3.Top - blacklist.Height
    else
      blacklist.Top := frmmp3.Top + frmmp3.Height;
    blacklist.Left := frmmp3.Left;
    end;
  ////
  if fileexists(mypath + 'blacklist.xa') then
    loadlist(mypath + 'blacklist.xa');
  DragAcceptFiles(blacklist.Handle, True);
end;

procedure Tblacklist.N1Click(Sender: TObject);
var
  i:   integer;
  dum: PBl;
begin
  Opendialog.Filter :=
    'MPEG Audio  (*.mp1,*.mp2;*.mp3)|*.mp?|Ogg Vorbis (*.ogg)|*.ogg|'
{$IFDEF WMA}
    + 'Windows Media Audio (*.wma)|*.wma|'
{$ENDIF WMA}
{$IFDEF FLAC}
    + 'FLAC AUDIO (*.flac)|*.flac|'
{$ENDIF FLAC}
    + 'Wave File (*.wav)|*.wav|CD Track File' +
    '|*.cda|Все форматы|*.wma;*.ogg;*.mp?;*.wav;*.cda';
  if OpenDialog.Execute then
    begin
    for i := 0 to opendialog.Files.Count - 1 do
      begin
      New(dum);
      dum.Name := opendialog.Files[i];
      blist.Add(dum);
      listbox1.Items.Append(dum^.Name);
      end;
    end;

end;

procedure Tblacklist.DFClick(Sender: TObject);
begin
  df.Enabled := False;
  pm.Popup(blacklist.left + df.Left, blacklist.top + df.Top);
  df.Enabled := True;

end;

procedure Tblacklist.WMDROPFILES(var Message: TWMDROPFILES);
var
  Files:  longint;
  I:      longint;
  Buffer: array[0..MAX_PATH] of char;
  dum:    PBl;
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
      dum^.Name := Buffer;
      blist.Add(dum);
      listbox1.Items.Append(dum^.Name);
      end; {
      else begin
      if filegetattr(buffer) and faDirectory<>0 then frmmp3.FindFiles(buffer);
      end;}

    end;
  DragFinish(Message.Drop);
end;


procedure Tblacklist.FormCanResize(Sender: TObject; var NewWidth, NewHeight: integer;
  var Resize: boolean);
begin
  resize := (newwidth >= frmmp3.Width) and (newheight >= frmmp3.Height div 2);
  if not resize then
    begin
    blacklist.Width  := frmmp3.Width;
    blacklist.Height := frmmp3.Height;
    end;
end;

end.
