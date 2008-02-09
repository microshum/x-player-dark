unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cddb, basscd, ExtCtrls;

type
  TfrmTe = class (TForm)
    cds:      TComboBox;
    ListBox1: TListBox;
    Edit1:    TEdit;
    artist:   TEdit;
    album:    TEdit;
    Save:     TButton;
    Label1:   TLabel;
    Label2:   TLabel;
    Bevel1:   TBevel;
    procedure FormCreate(Sender: TObject);
    procedure cdsSelect(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure UpdateTrackList(Sender: TObject);
    { Public declarations }
  end;

var
  frmTe: TfrmTe;

implementation

uses gui, lit;

{$R *.dfm}

procedure TfrmTe.UpdateTrackList(Sender: TObject);
var
  cdtext, t: PChar;
  tc, l, a: integer;
  Text, tag: string;
  Data: tcddata;
  i:  integer;
  id: string;
  curdrive: integer;
begin
  listbox1.Items.Clear;
  Artist.Clear;
  Album.Clear;
  a  := 0;
  l  := 0;
  CurDrive := cds.ItemIndex;
  tc := integer(BASS_CD_GetTracks(curdrive));
  Save.Enabled := False;
  if (tc = -1) then
    Exit;
  Save.Enabled := True;
  id   := BASS_CD_GetID(curdrive, BASS_CDID_CDPLAYER);
  Data := GetFromDB(id);
  frmTE.Caption := 'Редактор дорожек [' + id + ']';
  if Data.DataSize <> -1 then
    begin
    artist.Text := Data.artist;
    album.Text  := Data.title;
    for i := 0 to (Data.DataSize - 1) do
      begin
      l := integer(BASS_CD_GetTrackLength(curdrive, i));
      //      if l <> -1 then
        begin
        listbox1.Items.Add(Data.songs[i]);
        end;
      end;
    exit;
    end;
  cdtext := BASS_CD_GetID(curdrive, BASS_CDID_TEXT);
  t      := Cdtext;
  if (cdtext <> nil) and (StrLen(t) > 1) then
    begin
    Text := 'Новый альбом';
    t    := Cdtext;
    tag  := 'TITLE0=';
    while (t <> nil) do
      begin
      if (Copy(t, 1, Length(tag)) = tag) then
        begin
        Text := Copy(t, Length(tag) + 1, Length(t) - Length(tag));
        Break;
        end;
      t := t + StrLen(t) + 1;
      end;
    album.Text := Text;
    end;
  if (cdtext <> nil) then
    begin
    Text := 'Новый музыкант';
    t    := Cdtext;
    tag  := 'PERFORMER0=';
    while (t <> nil) and (StrLen(t) > 1) do
      begin
      if (Copy(t, 1, Length(tag)) = tag) then
        begin
        Text := Copy(t, Length(tag) + 1, Length(t) - Length(tag));
        Break;
        end;
      t := t + StrLen(t) + 1;
      end;
    artist.Text := Text;
    end;
  Text := '';
  for a := 0 to tc - 1 do
    begin
    l    := integer(BASS_CD_GetTrackLength(curdrive, a));
    t    := cdtext;
    Text := Format('Track %.2d', [a + 1]);
    if (cdtext <> nil) and (StrLen(t) > 1) then
      begin
      t   := cdtext;
      tag := Format('TITLE%d=', [a + 1]);
      while (t <> nil) do
        begin
        if (Copy(t, 1, Length(tag)) = tag) then
          begin
          Text := Copy(t, Length(tag) + 1, Length(t) - Length(tag));
          Break;
          end;
        t := t + StrLen(t) + 1;
        end;
      end;
    if (l = -1) then
      Text := Text + ' (Данные)'
    else
      begin
      l    := l div 176400;
      Text := Text + Format('', []);
      end;
    listBox1.Items.Add(Text);
    end;
  if t <> nil then
    t := nil;
  if cdtext <> nil then
    t := nil;
end;

procedure TfrmTe.FormCreate(Sender: TObject);
var
  i: integer;
begin
  cds.Clear;
  for i := 0 to playlist.cdlist.Count - 1 do
    cds.Items.Add(playlist.cdlist.Items[i].Caption);
  listbox1.Items.Clear;
  listbox1.Items.Add('Дисковод не выбран...');
   listbox1.Items.Add('Пожалуйста, выберите устройство из списка.');
  if Drivex <> -1 then
    begin
    cds.ItemIndex := DriveX;
    cdsSelect(Self);
    end;
end;

procedure TfrmTe.cdsSelect(Sender: TObject);
begin
  artist.Clear;
  album.Clear;
  listbox1.Items.Clear;
  if not basscd.BASS_CD_IsReady(cds.ItemIndex) then
    begin
    save.Enabled := False;
    listbox1.Items.Add('Диск не вставлен или устройство не готово!');
   listbox1.Items.Add(format('Выбран привод: %s',[cds.Items[cds.ItemIndex]]));
    exit;
    end;

  if basscd.BASS_CD_GetID(cds.ItemIndex, BASS_CDID_CDPLAYER) <> '200' then
    updatetracklist(self)
  else
    begin
    listbox1.Items.Add('Носитель не является Audio-CD');
    listbox1.Items.Add('Диск содержит данные, не являющиеся дорожками аудио.');
    save.Enabled := False;
    end;
end;

procedure TfrmTe.ListBox1Click(Sender: TObject);
begin
  if listbox1.ItemIndex <> -1 then
    edit1.Text := listbox1.Items[listbox1.ItemIndex];
end;

procedure TfrmTe.SaveClick(Sender: TObject);
var
  Data: tcddata;
  i:    integer;
begin
  Data.title  := album.Text;
  Data.artist := artist.Text;
  if listbox1.Count = 0 then
    exit;
  Data.songs    := TStringList.Create;
  Data.DataSize := listbox1.Count;
  for i := 0 to listbox1.Count - 1 do
    Data.songs.Add(listbox1.Items[i]);
  cddb.ADDTODB(BASS_CD_GetID(cds.ItemIndex, BASS_CDID_CDPLAYER), Data);
  Data.songs.Free;

end;

procedure TfrmTe.Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (key <> vk_return) or (ListBox1.ItemIndex = -1) then
    exit;
  listbox1.Items[ListBox1.ItemIndex] := edit1.Text;
end;

end.
