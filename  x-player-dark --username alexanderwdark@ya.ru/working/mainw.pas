unit MainW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, wavfile, gui, ComCtrls, ShellCtrls, FileCtrl, darkstr;

type
  TID3EDITW = class (TForm)
    InfoBevel: TBevel;
    FileList: TFileListBox;
    dirlist: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    TagExistsValue: TEdit;
    Format: TEdit;
    ChM:    TEdit;
    Sr:     TEdit;
    Bps:    TEdit;
    bips:   TEdit;
    cn:     TEdit;
    ba:     TEdit;
    sn:     TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FileListChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FileTag: TWavFile;
  end;

var
  ID3EDITW: TID3EDITW;

implementation

uses lit;

{$R *.dfm}


procedure TID3EDITW.FormCreate(Sender: TObject);
begin
  FileTag := TWavFile.Create;

  if (playlist.ListBox1.Items.Count > 0) and (playlist.ListBox1.ItemIndex >= 0) then
    begin
    filelist.filename := (PTag(mainlist.items[playlist.ListBox1.ItemIndex])^.fname);
    FileList.OnChange(Self);
    end;

end;

procedure TID3EDITW.FileListChange(Sender: TObject);
begin
  if FileList.FileName = '' then
    exit;
  if not FileExists(FileList.FileName) then
    Exit;
    begin
    if FileTag.ReadFromFile(FileList.FileName) then
      if FileTag.Valid then
        begin
        TagExistsValue.Text := 'дю';
        format.Text := FileTag.Format;
        ChM.Text    := FileTag.ChannelMode;
        sr.Text     := IntToStr(FileTag.SampleRate);
        bps.Text    := IntToStr(FileTag.BytesPerSecond);
        bips.Text   := IntToStr(FileTag.BitsPerSample);
        cn.Text     := IntToStr(FileTag.ChannelNumber);
        ba.Text     := IntToStr(FileTag.BlockAlign);
        sn.Text     := IntToStr(FileTag.SampleNumber);
        end;
    //id3v2
    EXIT;
    end;

  TagExistsValue.Text := 'мер';

end;

procedure TID3EDITW.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FileTag);
end;


end.
