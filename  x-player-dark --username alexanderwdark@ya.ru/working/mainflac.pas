unit MainFlac;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ID3v1, flacfile, gui, ComCtrls, ShellCtrls, FileCtrl, darkstr;

type
  TID3EDITF = class (TForm)
    SaveButton: TButton;
    RemoveButton: TButton;
    InfoBevel: TBevel;
    TagExistsLabel: TLabel;
    TagExistsValue: TEdit;
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
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FileListChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveButtonClick(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    FileTag: TFlacFile;
    procedure ClearAll;
    procedure TagC;
  end;

var
  ID3EDITF: TID3EDITF;

implementation

uses lit;

{$R *.dfm}

procedure TID3EditF.TagC;
begin
  TagChanged(FileList.FileName);
end;


procedure TID3EDITF.ClearAll;
begin
  { Clear all captions }
  TagExistsValue.Text := '';
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

procedure TID3EDITF.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FileTag := TFlacFile.Create;
  ClearAll;
  for i := 0 to MAX_MUSIC_GENRES - 1 do
    if (aTAG_MusicGenre[i] <> '') then
      genreedit.Items.Add(aTAG_MusicGenre[i]);

  if (playlist.ListBox1.Items.Count > 0) and (playlist.ListBox1.ItemIndex >= 0) then
    begin
    filelist.filename := (PTag(mainlist.items[playlist.ListBox1.ItemIndex])^.fname);
    FileList.OnChange(Self);
    end;

end;

procedure TID3EDITF.FileListChange(Sender: TObject);
begin
  ClearAll;
  if FileList.FileName = '' then
    exit;
  if not FileExists(FileList.FileName) then
    Exit;


  if FileTag.ReadFromFile(FileList.FileName) then
    if FileTag.Exists then
      begin
      TagExistsValue.Text := 'ДА';
      TitleEdit.Text     := tagprepare(FileTag.Title);
      ArtistEdit.Text    := tagprepare(FileTag.Artist);
      AlbumEdit.Text     := tagprepare(FileTag.Album);
      TrackEdit.Text     := FileTag.TrackString;
      YearEdit.Text      := FileTag.Year;
      GenreEdit.Text     := FileTag.Genre;
      CommentEdit.Text   := tagprepare(FileTag.Comment);
      ComposerEdit.Text  := tagprepare(FileTag.Composer);
      EncoderEdit.Text   := tagprepare(FileTag.Encoder);
      CopyrightEdit.Text := tagprepare(FileTag.Copyright);
      LanguageEdit.Text  := tagprepare(FileTag.Language);
      LinkEdit.Text      := tagprepare(FileTag.Link);
      EXIT;
      end;

  TitleEdit.Text  := ExtractFileName(ChangeFileExt(FileList.FileName, ''));
  artistedit.Text := DGetKeyEx(TitleEdit.Text);
  if FindDelimiterEx(TitleEdit.Text) <> 0 then
    TitleEdit.Text := DGetValueEx(TitleEdit.Text);
  YearEdit.Text := Default.Year;
  GenreEdit.Text     := Default.Genre;
  CommentEdit.Text   := Default.Comment;
  ComposerEdit.Text  := Default.Composer;
  EncoderEdit.Text   := Default.Encoder;
  CopyrightEdit.Text := Default.Copyright;
  LanguageEdit.Text  := Default.Language;
  LinkEdit.Text      := Default.Link;
  TagExistsValue.Text := 'НЕТ';

end;

procedure TID3EDITF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FileTag);
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

procedure TID3EDITF.SaveButtonClick(Sender: TObject);

begin
  removebutton.Enabled := False;
  savebutton.Enabled := False;
  button3.Enabled   := False;
  FileTag.Title     := TitleEdit.Text;
  FileTag.Artist    := ArtistEdit.Text;
  FileTag.Album     := AlbumEdit.Text;
  FileTag.TrackString := TrackEdit.Text;
  FileTag.Year      := YearEdit.Text;
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

  if Assigned(FileList.OnChange) then
    FileList.OnChange(Self);
  TagC;
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button3.Enabled      := True;

end;

procedure TID3EDITF.RemoveButtonClick(Sender: TObject);
begin
  removebutton.Enabled := False;
  savebutton.Enabled   := False;
  button3.Enabled      := False;

  if (FileExists(FileList.FileName)) and
    (FileTag.RemoveFromFile(FileList.FileName)) then
    ClearAll
  else
    ShowMessage('Не могу удалить ID3: ' + FileList.FileName);
  TagC;
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button3.Enabled      := True;

end;

procedure TID3EDITF.Button3Click(Sender: TObject);
var
  i:  integer;
  fe: TNotifyEvent;
begin
  if FileList.Count = 0 then
    exit;
  if messagedlg(
    'Для всех файлов в этом каталоге будет установлен один тэг, указанный сейчас. Действительно продоложить?',
    mtConfirmation, [mbOK, mbCancel], 0) <> idOk then
    exit;

  removebutton.Enabled := False;
  savebutton.Enabled   := False;
  button3.Enabled      := False;
  FileList.Items.BeginUpdate;
  fe := filelist.OnChange;
  filelist.OnChange := nil;
  for i := 0 to FileList.Count - 1 do
    begin
    FileList.ItemIndex := i;
    savebutton.Click;
    end;
  FileList.Items.EndUpdate;
  filelist.OnChange    := fe;
  removebutton.Enabled := True;
  savebutton.Enabled   := True;
  button3.Enabled      := True;

end;

end.
