object ID3EDITWM: TID3EDITWM
  Left = 485
  Top = 155
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' WMA'
  ClientHeight = 322
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object InfoBevel: TBevel
    Left = 8
    Top = 172
    Width = 505
    Height = 141
  end
  object TitleLabel: TLabel
    Left = 18
    Top = 180
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    Layout = tlCenter
  end
  object ArtistLabel: TLabel
    Left = 18
    Top = 206
    Width = 69
    Height = 17
    AutoSize = False
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':'
    Layout = tlCenter
  end
  object AlbumLabel: TLabel
    Left = 18
    Top = 232
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1040#1083#1100#1073#1086#1084':'
    Layout = tlCenter
  end
  object TrackLabel: TLabel
    Left = 18
    Top = 256
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1058#1088#1101#1082':'
    Layout = tlCenter
  end
  object YearLabel: TLabel
    Left = 158
    Top = 254
    Width = 49
    Height = 17
    AutoSize = False
    Caption = #1043#1086#1076':'
    Layout = tlCenter
  end
  object GenreLabel: TLabel
    Left = 252
    Top = 254
    Width = 45
    Height = 17
    AutoSize = False
    Caption = #1046#1072#1085#1088':'
    Layout = tlCenter
  end
  object CommentLabel: TLabel
    Left = 18
    Top = 282
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1044#1086#1087'. '#1080#1085#1092#1086':'
    Layout = tlCenter
  end
  object TitleEdit: TEdit
    Left = 104
    Top = 180
    Width = 393
    Height = 21
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object ArtistEdit: TEdit
    Left = 104
    Top = 204
    Width = 393
    Height = 21
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object AlbumEdit: TEdit
    Left = 104
    Top = 228
    Width = 393
    Height = 21
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object TrackEdit: TEdit
    Left = 104
    Top = 252
    Width = 45
    Height = 21
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object YearEdit: TEdit
    Left = 190
    Top = 254
    Width = 49
    Height = 21
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object CommentEdit: TEdit
    Left = 104
    Top = 282
    Width = 393
    Height = 21
    Color = clWhite
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object FileList: TFileListBox
    Left = 168
    Top = 40
    Width = 345
    Height = 121
    Color = clWhite
    FileType = [ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftArchive, ftNormal]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Mask = '*.wma'
    ParentFont = False
    ShowGlyphs = True
    TabOrder = 6
    OnChange = FileListChange
    OnClick = FileListChange
  end
  object dirlist: TDirectoryListBox
    Left = 8
    Top = 16
    Width = 153
    Height = 145
    Color = clWhite
    FileList = FileList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 7
  end
  object DriveComboBox1: TDriveComboBox
    Left = 168
    Top = 16
    Width = 345
    Height = 19
    Color = clWhite
    DirList = dirlist
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object genreedit: TEdit
    Left = 312
    Top = 256
    Width = 185
    Height = 21
    ReadOnly = True
    TabOrder = 9
  end
end
