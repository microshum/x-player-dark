unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StrUtils,StdCtrls, ExtCtrls, ID3v2, ID3v1, gui, ComCtrls, ShellCtrls, FileCtrl, darkstr;

type
  TID3EDIT = class (TForm)
    SaveButton: TButton;
    RemoveButton: TButton;
    InfoBevel: TBevel;
    TagExistsLabel: TLabel;
    TagExistsValue: TEdit;
    VersionLabel: TLabel;
    VersionValue: TEdit;
    SizeLabel: TLabel;
    SizeValue: TEdit;
    TitleLabel: TLabel;
    TitleEdit: TEdit;
    ArtistLabel: TLabel;
    ArtistEdit: TEdit;
    AlbumLabel: TLabel;
    AlbumEdit: TEdit;
    TrackLabel: TLabel;
    TrackEdit: TEdit;
    YearLabel: TLabel;
    YearEdit: TEdit;
    GenreLabel: TLabel;
    CommentLabel: TLabel;
    CommentEdit: TEdit;
    ComposerLabel: TLabel;
    ComposerEdit: TEdit;
    EncoderLabel: TLabel;
    EncoderEdit: TEdit;
    CopyrightLabel: TLabel;
    CopyrightEdit: TEdit;
    LanguageLabel: TLabel;
    LanguageEdit: TEdit;
    LinkLabel: TLabel;
    LinkEdit: TEdit;
    genreedit: TComboBox;
    FileList: TFileListBox;
    dirlist: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    ver:     TTrackBar;
    Label1:  TLabel;
    Label2:  TLabel;
    Bevel1:  TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FileListChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveButtonClick(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure verChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    FileTag:  TID3v2;
    FileTag1: TID3v1;
    procedure ClearAll;
    procedure TagC;
  end;

var
  ID3EDIT: TID3EDIT;

implementation

uses lit;

{$R *.dfm}


procedure TID3Edit.TagC;
begin
  TagChanged(FileList.FileName);
end;

procedure TID3EDIT.ClearAll;
begin
  { Clear all captions }
  TagExistsValue.Text := '';
  VersionValue.Text  := '';
  SizeValue.Text     := '';
  TitleEdit.Text     := '';
  ArtistEdit.Text    := '';
  AlbumEdit.Text     := '';
  TrackEdit.Text     := '';
  YearEdit.Text      := '';
  GenreEdit.ItemIndex := -1;
  CommentEdit.Text   := '';
  ComposerEdit.Text  := '';
  EncoderEdit.Text   := '';
  CopyrightEdit.Text := '';
  LanguageEdit.Text  := '';
  LinkEdit.Text      := '';
end;

procedure TID3EDIT.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FileTag  := TID3v2.Create;
  FileTag1 := TID3v1.Create;
  ClearAll;
  for i := 0 to MAX_MUSIC_GENRES - 1 do
    if (aTAG_MusicGenre[i] <> '') then
      genreedit.Items.Add(aTAG_MusicGenre[i]);

  if (playlist.ListBox1.Items.Count > 0) and (playlist.ListBox1.ItemIndex >= 0) then
    begin
    filelist.filename := (PTag(mainlist.items[playlist.ListBox1.ItemIndex])^.fname);
    FileList.OnChange(Self);
    VerChange(Self);
    end;

end;

procedure TID3EDIT.FileListChange(Sender: TObject);
begin
  ClearAll;
  if FileList.FileName = '' then
    exit;
  if not FileExists(FileList.FileName) then
    Exit;


  if ver.Position = 1 then
    begin
    if FileTag.ReadFromFile(FileList.FileName) then
      if FileTag.Exists then
        begin
        TagExistsValue.Text := 'ДА';
        VersionValue.Text   := '2.' + IntToStr(FileTag.VersionID);
        SizeValue.Text      := IntToStr(FileTag.Size) + ' байт';
        TitleEdit.Text      := tagprepare(FileTag.Title);
        ArtistEdit.Text     := tagprepare(FileTag.Artist);
        AlbumEdit.Text      := tagprepare(FileTag.Album);
        if FileTag.Track > 0 then
          TrackEdit.Text := IntToStr(FileTag.Track);
        YearEdit.Text := FileTag.Year;
        GenreEdit.Text     := FileTag.Genre;
        CommentEdit.Text   := tagprepare(FileTag.Comment);
        ComposerEdit.Text  := tagprepare(FileTag.Composer);
        EncoderEdit.Text   := tagprepare(FileTag.Encoder);
        CopyrightEdit.Text := tagprepare(FileTag.Copyright);
        LanguageEdit.Text  := tagprepare(FileTag.Language);
        LinkEdit.Text      := tagprepare(FileTag.Link);
        end;
    //id3v2
    EXIT;
    end;

  if ver.Position = 0 then
    begin
    if FileTag1.ReadFromFile(FileList.FileName) then
      if FileTag1.Exists then
        begin
        TagExistsValue.Text := 'ДА';
        VersionValue.Text   := '2.' + IntToStr(FileTag1.VersionID);
        TitleEdit.Text      := tagprepare(FileTag1.Title);
        ArtistEdit.Text     := tagprepare(FileTag1.Artist);
        AlbumEdit.Text      := tagprepare(FileTag1.Album);
        if FileTag.Track > 0 then
          TrackEdit.Text := IntToStr(FileTag1.Track);
        YearEdit.Text := FileTag1.Year;
        GenreEdit.ItemIndex := GenreEdit.Items.IndexOf(FileTag1.Genre);
        CommentEdit.Text := tagprepare(FileTag1.Comment);
        ComposerEdit.Text := '';
        EncoderEdit.Text := '';
        CopyrightEdit.Text := '';
        LanguageEdit.Text := '';
        LinkEdit.Text  := '';
        SizeValue.Text := '128 байт';
        end;
    //id3v1
    EXIT;
    end;
  TitleEdit.Text  := ExtractFileName(ChangeFileExt(FileList.FileName, ''));
  artistedit.Text := DGetKeyEx(TitleEdit.Text);
  if FindDelimiterEx(TitleEdit.Text) <> 0 then
    TitleEdit.Text := DGetValueEx(TitleEdit.Text);
  YearEdit.Text := Default.Year;
  if ver.Position = 1 then
    GenreEdit.Text      := Default.Genre
  else
    GenreEdit.ItemIndex := GenreEdit.Items.IndexOf(Default.Genre);
  CommentEdit.Text := Default.Comment;
  ComposerEdit.Text  := Default.Composer;
  EncoderEdit.Text   := Default.Encoder;
  CopyrightEdit.Text := Default.Copyright;
  LanguageEdit.Text  := Default.Language;
  LinkEdit.Text      := Default.Link;
  TagExistsValue.Text := 'НЕТ';

end;

procedure TID3EDIT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FileTag);
  FreeAndNil(FileTag1);
end;

function GenreToID(s: string): byte;
var
  i: integer;
begin
  for i := 0 to MAX_MUSIC_GENRES - 1 do
    if AnsiCompareText(s, aTAG_MusicGenre[i]) = 0 then
      begin
      Result := i;
      Exit;
      end;
  Result := 255;
end;

procedure TID3EDIT.SaveButtonClick(Sender: TObject);
var
  Value, Code: integer;
begin
  removebutton.Enabled := False;
  savebutton.Enabled   := False;
  button1.Enabled      := False;
  button2.Enabled      := False;
  button3.Enabled      := False;

  if ver.Position = 1 then
    begin
    FileTag.Title  := TitleEdit.Text;
    FileTag.Artist := ArtistEdit.Text;
    FileTag.Album  := AlbumEdit.Text;
    Val(TrackEdit.Text, Value, Code);
    if (Code = 0) and (Value > 0) then
      FileTag.Track := Value
    else
      FileTag.Track := 0;
    FileTag.Year := YearEdit.Text;
    FileTag.Genre     := GenreEdit.Text;
    FileTag.Comment   := CommentEdit.Text;
    FileTag.Composer  := ComposerEdit.Text;
    FileTag.Encoder   := EncoderEdit.Text;
    FileTag.Copyright := CopyrightEdit.Text;
    FileTag.Language  := LanguageEdit.Text;
    FileTag.Link      := LinkEdit.Text;
    if (not FileExists(FileList.FileName)) or
      (not FileTag.SaveToFile(FileList.FileName)) then
      ShowMessage('Не могу изменить: ' + FileList.FileName);
    end
  else
    begin
    FileTag1.Title  := TitleEdit.Text;
    FileTag1.Artist := ArtistEdit.Text;
    FileTag1.Album  := AlbumEdit.Text;
    Val(TrackEdit.Text, Value, Code);
    if (Code = 0) and (Value > 0) then
      FileTag1.Track := Value
    else
      FileTag1.Track := 0;
    FileTag1.Year := YearEdit.Text;
    FileTag1.GenreID := Genretoid(GenreEdit.Text);
    FileTag1.Comment := CommentEdit.Text;
    if (not FileExists(FileList.FileName)) or
      (not FileTag1.SaveToFile(FileList.FileName)) then
      ShowMessage('Не могу изменить: ' + FileList.FileName);

    end;
  if Assigned(FileList.OnChange) then
    FileList.OnChange(Self);
  tagc;
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button1.Enabled      := True;
  button2.Enabled      := True;
  button3.Enabled      := True;

end;

procedure TID3EDIT.RemoveButtonClick(Sender: TObject);
begin
  removebutton.Enabled := False;
  savebutton.Enabled   := False;
  button1.Enabled      := False;
  button2.Enabled      := False;
  button3.Enabled      := False;
  if ver.Position = 1 then
    if (FileExists(FileList.FileName)) and
      (FileTag.RemoveFromFile(FileList.FileName)) then
      ClearAll
    else
      ShowMessage('Не могу удалить ID3V1: ' + FileList.FileName)
  else
  if (FileExists(FileList.FileName)) and
    (FileTag1.RemoveFromFile(FileList.FileName)) then
    ClearAll
  else
    ShowMessage('Не могу удалить ID3V2: ' + FileList.FileName);
  tagc;
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button1.Enabled      := True;
  button2.Enabled      := True;
  button3.Enabled      := True;

end;

procedure TID3EDIT.verChange(Sender: TObject);
begin
  if ver.Position = 0 then
    begin
    ComposerEdit.Enabled  := False;
    EncoderEdit.Enabled   := False;
    CopyrightEdit.Enabled := False;
    LanguageEdit.Enabled  := False;
    LinkEdit.Enabled      := False;
    SizeValue.Clear;
    ComposerEdit.Clear;
    EncoderEdit.Clear;
    CopyrightEdit.Clear;
    LanguageEdit.Clear;
    LinkEdit.Clear;
    GenreEdit.Style     := csDropDownList;
    GenreEdit.ItemIndex := -1;
    end
  else
    begin
    ComposerEdit.Enabled := True;
    EncoderEdit.Enabled := True;
    CopyrightEdit.Enabled := True;
    LanguageEdit.Enabled := True;
    LinkEdit.Enabled    := True;
    GenreEdit.Style     := csDropDown;
    GenreEdit.ItemIndex := -1;
    end;
  if Assigned(FileList.OnChange) then
    FileList.OnChange(Self);
end;

procedure TID3EDIT.Button1Click(Sender: TObject);
var
  p: TNotifyEvent;
begin
  removebutton.Enabled := False;
  savebutton.Enabled   := False;
  button1.Enabled      := False;
  button2.Enabled      := False;
  button3.Enabled      := False;

  ver.Position := 0;
  p := ver.OnChange;
  ver.OnChange := nil;
  ver.Position := 1;
  savebutton.Click;
  ver.OnChange := p;
  p := nil;
  if assigned(ver.onchange) then
    ver.OnChange(self);
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button1.Enabled      := True;
  button2.Enabled      := True;
  button3.Enabled      := True;

end;

procedure TID3EDIT.Button2Click(Sender: TObject);
var
  p: TNotifyEvent;
begin
  removebutton.Enabled := False;
  savebutton.Enabled := False;
  button1.Enabled := False;
  button2.Enabled := False;
  button3.Enabled := False;
  ver.Position := 1;
  p := ver.OnChange;
  ver.OnChange := nil;
  ver.Position := 0;
  savebutton.Click;
  ver.OnChange := p;
  p := nil;
  if assigned(ver.onchange) then
    ver.OnChange(self);
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button1.Enabled      := True;
  button2.Enabled      := True;
  button3.Enabled      := True;

end;

procedure TID3EDIT.Button3Click(Sender: TObject);
var
  i:      integer;
  fe, ve: TNotifyEvent;
  isv2:   boolean;
begin
  if FileList.Count = 0 then
    exit;
  if messagedlg(
    'Для всех файлов в этом каталоге будет установлен один тэг, указанный сейчас. Действительно продоложить?',
    mtConfirmation, [mbOK, mbCancel], 0) <> idOk then
    exit;
  removebutton.Enabled := False;
  savebutton.Enabled   := False;
  button1.Enabled      := False;
  button2.Enabled      := False;
  button3.Enabled      := False;
  FileList.Items.BeginUpdate;
  fe   := filelist.OnChange;
  ve   := ver.OnChange;
  filelist.OnChange := nil;
  ver.OnChange := nil;
  isv2 := ver.Position = 1;
  for i := 0 to FileList.Count - 1 do
    begin
    FileList.ItemIndex := i;
    if isv2 then
      ver.Position := 1
    else
      ver.Position := 0;
    savebutton.Click;
    if isv2 then
      button2.Click
    else
      button1.Click;
    end;

  ver.OnChange      := ve;
  filelist.OnChange := fe;
  FileList.Items.EndUpdate;
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button1.Enabled      := True;
  button2.Enabled      := True;
  button3.Enabled      := True;

end;

end.
