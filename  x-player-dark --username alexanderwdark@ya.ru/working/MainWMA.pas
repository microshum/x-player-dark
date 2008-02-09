unit Mainwma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, wmafile, FileCtrl, gui, ComCtrls, ShellCtrls, darkstr;

type
  TID3EDITWM = class (TForm)
    InfoBevel:    TBevel;
    TitleLabel:   TLabel;
    TitleEdit:    TEdit;
    ArtistLabel:  TLabel;
    ArtistEdit:   TEdit;
    AlbumLabel:   TLabel;
    AlbumEdit:    TEdit;
    TrackLabel:   TLabel;
    TrackEdit:    TEdit;
    YearLabel:    TLabel;
    YearEdit:     TEdit;
    GenreLabel:   TLabel;
    CommentLabel: TLabel;
    CommentEdit:  TEdit;
    FileList:     TFileListBox;
    dirlist:      TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    genreedit:    TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FileListChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClearAll;
  end;

var
  ID3EDITWM: TID3EDITWM;
  filetag:   TWMAFile;

implementation

uses lit;

{$R *.dfm}

procedure TID3EDITWM.ClearAll;
begin
  { Clear all captions }
  TitleEdit.Text   := '';
  ArtistEdit.Text  := '';
  AlbumEdit.Text   := '';
  TrackEdit.Text   := '';
  YearEdit.Text    := '';
  GenreEdit.Text   := '';
  CommentEdit.Text := '';
end;

procedure TID3EDITWM.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FileTag := TWMAFile.Create;
  ClearAll;
  if (playlist.ListBox1.Items.Count > 0) and (playlist.ListBox1.ItemIndex >= 0) then
    begin
    filelist.filename := (PTag(mainlist.items[playlist.ListBox1.ItemIndex])^.fname);
    FileListChange(Self);
    end;

end;

procedure TID3EDITWM.FileListChange(Sender: TObject);
begin
  ClearAll;
  if FileList.FileName = '' then
    exit;
  if not FileExists(FileList.FileName) then
    Exit;

    begin
    if FileTag.ReadFromFile(FileList.FileName) then
      if FileTag.Valid then
        begin
        TitleEdit.Text  := tagprepare(FileTag.Title);
        ArtistEdit.Text := tagprepare(FileTag.Artist);
        AlbumEdit.Text  := tagprepare(FileTag.Album);
        if FileTag.Track > 0 then
          TrackEdit.Text := IntToStr(FileTag.Track);
        YearEdit.Text := FileTag.Year;
        GenreEdit.Text   := FileTag.Genre;
        CommentEdit.Text := tagprepare(FileTag.Comment);
        end;
    //id3v2
    EXIT;
    end;

  TitleEdit.Text  := ExtractFileName(ChangeFileExt(FileList.FileName, ''));
  artistedit.Text := DGetKeyEx(TitleEdit.Text);
  if FindDelimiterEx(TitleEdit.Text) <> 0 then
    TitleEdit.Text := DGetValueEx(TitleEdit.Text);
  YearEdit.Text := Default.Year;
  GenreEdit.Text   := Default.Genre;
  CommentEdit.Text := Default.Comment;
end;

procedure TID3EDITWM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FileTag);
end;


procedure TID3EDITWM.SaveButtonClick(Sender: TObject);
var
  Value, Code: integer;
begin
  FileListChange(Self);
end;

end.
