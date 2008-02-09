unit MainOGG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, oggvorbis, gui, darkstr,
  ComCtrls, ShellCtrls, FileCtrl;

type
  TID3EDITOGG = class (TForm)
    SaveButton: TButton;
    RemoveButton: TButton;
    InfoBevel: TBevel;
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
    genreedit: TComboBox;
    FileList: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    vendor:  TEdit;
    Label2:  TLabel;
    sr:      TEdit;
    Button1: TButton;
    br:      TEdit;
    Label1:  TLabel;
    nom:     TEdit;
    Label3:  TLabel;
    mode:    TEdit;
    Label4:  TLabel;
    Label5:  TLabel;
    enc:     TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FileListChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveButtonClick(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FileTag: TOggVorbis;
    procedure ClearAll;
    procedure TagC;
  end;

var
  ID3EDITOGG: TID3EDITOGG;
  MusicGenre: array[0..255] of string;

implementation

uses lit;

{$R *.dfm}


procedure TID3EditOgg.TagC;
begin
  TagChanged(FileList.FileName);
end;


procedure TID3EDITOGG.ClearAll;
begin
  TitleEdit.Text := '';
  ArtistEdit.Text := '';
  AlbumEdit.Text := '';
  TrackEdit.Text := '';
  YearEdit.Text := '';
  GenreEdit.Text := '';
  CommentEdit.Text := '';
  sr.Text     := '';
  br.Text     := '';
  nom.Text    := '';
  vendor.Text := '';
  mode.Text   := '';
  enc.Text    := '';
end;

procedure TID3EDITOGG.FormCreate(Sender: TObject);
var
  i: integer;
begin

  FileTag := TOggVorbis.Create;
  ClearAll;

  if (playlist.ListBox1.Items.Count > 0) and (playlist.ListBox1.ItemIndex >= 0) then
    filelist.filename := (PTag(mainlist.items[playlist.ListBox1.ItemIndex])^.fname);
  MusicGenre[0] := 'Blues';
  MusicGenre[1]   := 'Classic Rock';
  MusicGenre[2]   := 'Country';
  MusicGenre[3]   := 'Dance';
  MusicGenre[4]   := 'Disco';
  MusicGenre[5]   := 'Funk';
  MusicGenre[6]   := 'Grunge';
  MusicGenre[7]   := 'Hip-Hop';
  MusicGenre[8]   := 'Jazz';
  MusicGenre[9]   := 'Metal';
  MusicGenre[10]  := 'New Age';
  MusicGenre[11]  := 'Oldies';
  MusicGenre[12]  := 'Other';
  MusicGenre[13]  := 'Pop';
  MusicGenre[14]  := 'R&B';
  MusicGenre[15]  := 'Rap';
  MusicGenre[16]  := 'Reggae';
  MusicGenre[17]  := 'Rock';
  MusicGenre[18]  := 'Techno';
  MusicGenre[19]  := 'Industrial';
  MusicGenre[20]  := 'Alternative';
  MusicGenre[21]  := 'Ska';
  MusicGenre[22]  := 'Death Metal';
  MusicGenre[23]  := 'Pranks';
  MusicGenre[24]  := 'Soundtrack';
  MusicGenre[25]  := 'Euro-Techno';
  MusicGenre[26]  := 'Ambient';
  MusicGenre[27]  := 'Trip-Hop';
  MusicGenre[28]  := 'Vocal';
  MusicGenre[29]  := 'Jazz+Funk';
  MusicGenre[30]  := 'Fusion';
  MusicGenre[31]  := 'Trance';
  MusicGenre[32]  := 'Classical';
  MusicGenre[33]  := 'Instrumental';
  MusicGenre[34]  := 'Acid';
  MusicGenre[35]  := 'House';
  MusicGenre[36]  := 'Game';
  MusicGenre[37]  := 'Sound Clip';
  MusicGenre[38]  := 'Gospel';
  MusicGenre[39]  := 'Noise';
  MusicGenre[40]  := 'AlternRock';
  MusicGenre[41]  := 'Bass';
  MusicGenre[42]  := 'Soul';
  MusicGenre[43]  := 'Punk';
  MusicGenre[44]  := 'Space';
  MusicGenre[45]  := 'Meditative';
  MusicGenre[46]  := 'Instrumental Pop';
  MusicGenre[47]  := 'Instrumental Rock';
  MusicGenre[48]  := 'Ethnic';
  MusicGenre[49]  := 'Gothic';
  MusicGenre[50]  := 'Darkwave';
  MusicGenre[51]  := 'Techno-Industrial';
  MusicGenre[52]  := 'Electronic';
  MusicGenre[53]  := 'Pop-Folk';
  MusicGenre[54]  := 'Eurodance';
  MusicGenre[55]  := 'Dream';
  MusicGenre[56]  := 'Southern Rock';
  MusicGenre[57]  := 'Comedy';
  MusicGenre[58]  := 'Cult';
  MusicGenre[59]  := 'Gangsta';
  MusicGenre[60]  := 'Top 40';
  MusicGenre[61]  := 'Christian Rap';
  MusicGenre[62]  := 'Pop/Funk';
  MusicGenre[63]  := 'Jungle';
  MusicGenre[64]  := 'Native American';
  MusicGenre[65]  := 'Cabaret';
  MusicGenre[66]  := 'New Wave';
  MusicGenre[67]  := 'Psychadelic';
  MusicGenre[68]  := 'Rave';
  MusicGenre[69]  := 'Showtunes';
  MusicGenre[70]  := 'Trailer';
  MusicGenre[71]  := 'Lo-Fi';
  MusicGenre[72]  := 'Tribal';
  MusicGenre[73]  := 'Acid Punk';
  MusicGenre[74]  := 'Acid Jazz';
  MusicGenre[75]  := 'Polka';
  MusicGenre[76]  := 'Retro';
  MusicGenre[77]  := 'Musical';
  MusicGenre[78]  := 'Rock & Roll';
  MusicGenre[79]  := 'Hard Rock';
  MusicGenre[80]  := 'Folk';
  MusicGenre[81]  := 'Folk-Rock';
  MusicGenre[82]  := 'National Folk';
  MusicGenre[83]  := 'Swing';
  MusicGenre[84]  := 'Fast Fusion';
  MusicGenre[85]  := 'Bebob';
  MusicGenre[86]  := 'Latin';
  MusicGenre[87]  := 'Revival';
  MusicGenre[88]  := 'Celtic';
  MusicGenre[89]  := 'Bluegrass';
  MusicGenre[90]  := 'Avantgarde';
  MusicGenre[91]  := 'Gothic Rock';
  MusicGenre[92]  := 'Progessive Rock';
  MusicGenre[93]  := 'Psychedelic Rock';
  MusicGenre[94]  := 'Symphonic Rock';
  MusicGenre[95]  := 'Slow Rock';
  MusicGenre[96]  := 'Big Band';
  MusicGenre[97]  := 'Chorus';
  MusicGenre[98]  := 'Easy Listening';
  MusicGenre[99]  := 'Acoustic';
  MusicGenre[100] := 'Humour';
  MusicGenre[101] := 'Speech';
  MusicGenre[102] := 'Chanson';
  MusicGenre[103] := 'Opera';
  MusicGenre[104] := 'Chamber Music';
  MusicGenre[105] := 'Sonata';
  MusicGenre[106] := 'Symphony';
  MusicGenre[107] := 'Booty Bass';
  MusicGenre[108] := 'Primus';
  MusicGenre[109] := 'Porn Groove';
  MusicGenre[110] := 'Satire';
  MusicGenre[111] := 'Slow Jam';
  MusicGenre[112] := 'Club';
  MusicGenre[113] := 'Tango';
  MusicGenre[114] := 'Samba';
  MusicGenre[115] := 'Folklore';
  MusicGenre[116] := 'Ballad';
  MusicGenre[117] := 'Power Ballad';
  MusicGenre[118] := 'Rhythmic Soul';
  MusicGenre[119] := 'Freestyle';
  MusicGenre[120] := 'Duet';
  MusicGenre[121] := 'Punk Rock';
  MusicGenre[122] := 'Drum Solo';
  MusicGenre[123] := 'A capella';
  MusicGenre[124] := 'Euro-House';
  MusicGenre[125] := 'Dance Hall';
  MusicGenre[126] := 'Goa';
  MusicGenre[127] := 'Drum & Bass';
  MusicGenre[128] := 'Club-House';
  MusicGenre[129] := 'Hardcore';
  MusicGenre[130] := 'Terror';
  MusicGenre[131] := 'Indie';
  MusicGenre[132] := 'BritPop';
  MusicGenre[133] := 'Negerpunk';
  MusicGenre[134] := 'Polsk Punk';
  MusicGenre[135] := 'Beat';
  MusicGenre[136] := 'Christian Gangsta Rap';
  MusicGenre[137] := 'Heavy Metal';
  MusicGenre[138] := 'Black Metal';
  MusicGenre[139] := 'Crossover';
  MusicGenre[140] := 'Contemporary Christian';
  MusicGenre[141] := 'Christian Rock';
  MusicGenre[142] := 'Merengue';
  MusicGenre[143] := 'Salsa';
  MusicGenre[144] := 'Trash Metal';
  MusicGenre[145] := 'Anime';
  MusicGenre[146] := 'JPop';
  MusicGenre[147] := 'Synthpop';
  for i := 0 to 255 do
    if MusicGenre[i] <> '' then
      genreedit.Items.Add(musicgenre[i]);
  FileListChange(Self);
end;

procedure TID3EDITOGG.FileListChange(Sender: TObject);
begin

  ClearAll;
  if FileList.FileName = '' then
    exit;
  if FileExists(FileList.FileName) then

    if FileTag.ReadFromFile(FileList.FileName) then
      if FileTag.Valid then
        begin
        TitleEdit.Text  := tagprepare(FileTag.Title);
        ArtistEdit.Text := tagprepare(FileTag.Artist);
        AlbumEdit.Text  := tagprepare(FileTag.Album);
        if FileTag.Track > 0 then
          TrackEdit.Text := IntToStr(FileTag.Track);
        YearEdit.Text := FileTag.Date;
        GenreEdit.Text := FileTag.Genre;
        CommentEdit.Text := tagprepare(FileTag.Comment);
        Vendor.Text := tagprepare(FileTag.Vendor);
        br.Text   := IntToStr(FileTag.BitRate);
        nom.Text  := IntToStr(FileTag.BitRateNominal);
        sr.Text   := IntToStr(FileTag.SampleRate);
        mode.Text := filetag.ChannelMode;
        enc.Text  := tagprepare(filetag.Encoder);
        end
      else
        begin
        TitleEdit.Text  := ExtractFileName(ChangeFileExt(FileList.FileName, ''));
        artistedit.Text := DGetKeyEx(TitleEdit.Text);
        if FindDelimiterEx(TitleEdit.Text) <> 0 then
          TitleEdit.Text := DGetValueEx(TitleEdit.Text);
        YearEdit.Text := Default.Year;
        GenreEdit.Text   := Default.Genre;
        CommentEdit.Text := Default.Comment;
        Vendor.Clear;
        end
    else
      ShowMessage('Не могу прочитать тэг!' + FileList.FileName)
  else
    ShowMessage('Файл не найден: ' + FileList.FileName);
end;

procedure TID3EDITOGG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FileTag);
end;

procedure TID3EDITOGG.SaveButtonClick(Sender: TObject);
var
  Value, Code: integer;
begin
  savebutton.Enabled := False;
  removebutton.Enabled := False;
  FileTag.Title  := TitleEdit.Text;
  FileTag.Artist := ArtistEdit.Text;
  FileTag.Album  := AlbumEdit.Text;
  Val(TrackEdit.Text, Value, Code);
  if (Code = 0) and (Value > 0) then
    FileTag.Track := Value
  else
    FileTag.Track := 0;
  FileTag.Genre := GenreEdit.Text;
  FileTag.Comment := CommentEdit.Text;
  FileTag.Vendor  := Vendor.Text;
  FileTag.Date    := YearEdit.Text;
  if (not FileExists(FileList.FileName)) or
    (not FileTag.SaveTag(FileList.FileName)) then
    ShowMessage('Не могу изменить: ' + FileList.FileName);
  FileListChange(Self);
  TagC;
  savebutton.Enabled   := True;
  removebutton.Enabled := True;

end;

procedure TID3EDITOGG.RemoveButtonClick(Sender: TObject);
begin
  removebutton.Enabled := False;
  if (FileExists(FileList.FileName)) and (FileTag.ClearTag(FileList.FileName)) then
    ClearAll
  else
    ShowMessage('Не могу удалить тэг: ' + FileList.FileName);

  TagC;
  removebutton.Enabled := True;
end;

procedure TID3EDITOGG.Button1Click(Sender: TObject);
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
  button1.Enabled      := False;
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
  button1.Enabled      := True;

end;

end.
