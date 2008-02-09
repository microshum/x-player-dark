object ID3EDITOGG: TID3EDITOGG
  Left = 253
  Top = 197
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' Ogg'
  ClientHeight = 391
  ClientWidth = 515
  Color = clWindow
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
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
    Left = 14
    Top = 180
    Width = 491
    Height = 213
  end
  object TitleLabel: TLabel
    Left = 20
    Top = 220
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    Transparent = True
    Layout = tlCenter
  end
  object ArtistLabel: TLabel
    Left = 22
    Top = 246
    Width = 69
    Height = 17
    AutoSize = False
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':'
    Transparent = True
    Layout = tlCenter
  end
  object AlbumLabel: TLabel
    Left = 22
    Top = 272
    Width = 51
    Height = 17
    AutoSize = False
    Caption = #1040#1083#1100#1073#1086#1084':'
    Transparent = True
    Layout = tlCenter
  end
  object TrackLabel: TLabel
    Left = 22
    Top = 296
    Width = 43
    Height = 17
    AutoSize = False
    Caption = #1058#1088#1101#1082':'
    Transparent = True
    Layout = tlCenter
  end
  object YearLabel: TLabel
    Left = 158
    Top = 302
    Width = 35
    Height = 17
    AutoSize = False
    Caption = #1043#1086#1076':'
    Transparent = True
    Layout = tlCenter
  end
  object GenreLabel: TLabel
    Left = 268
    Top = 302
    Width = 45
    Height = 17
    AutoSize = False
    Caption = #1046#1072#1085#1088':'
    Transparent = True
    Layout = tlCenter
  end
  object CommentLabel: TLabel
    Left = 22
    Top = 330
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1044#1086#1087'. '#1080#1085#1092#1086':'
    Transparent = True
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 24
    Top = 360
    Width = 58
    Height = 13
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
    Transparent = True
  end
  object Label1: TLabel
    Left = 168
    Top = 192
    Width = 101
    Height = 13
    Caption = #1041#1080#1090#1088#1077#1081#1090' / '#1053#1086#1084#1080#1085#1072#1083':'
  end
  object Label3: TLabel
    Left = 24
    Top = 192
    Width = 45
    Height = 13
    Caption = #1063#1072#1089#1090#1086#1090#1072':'
  end
  object Label4: TLabel
    Left = 400
    Top = 192
    Width = 38
    Height = 13
    Caption = #1056#1077#1078#1080#1084':'
  end
  object Label5: TLabel
    Left = 288
    Top = 360
    Width = 40
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103':'
  end
  object TitleEdit: TEdit
    Left = 104
    Top = 220
    Width = 395
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object ArtistEdit: TEdit
    Left = 104
    Top = 246
    Width = 394
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
  end
  object AlbumEdit: TEdit
    Left = 104
    Top = 272
    Width = 393
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object TrackEdit: TEdit
    Left = 104
    Top = 304
    Width = 44
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
  end
  object YearEdit: TEdit
    Left = 200
    Top = 304
    Width = 49
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
  end
  object CommentEdit: TEdit
    Left = 104
    Top = 333
    Width = 395
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
  end
  object RemoveButton: TButton
    Left = 384
    Top = 14
    Width = 121
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 7
    OnClick = RemoveButtonClick
  end
  object SaveButton: TButton
    Left = 384
    Top = 50
    Width = 121
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 6
    OnClick = SaveButtonClick
  end
  object genreedit: TComboBox
    Left = 328
    Top = 302
    Width = 167
    Height = 21
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 8
  end
  object FileList: TFileListBox
    Left = 168
    Top = 40
    Width = 201
    Height = 129
    Color = clWhite
    FileType = [ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftArchive, ftNormal]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    Mask = '*.ogg'
    ParentFont = False
    TabOrder = 9
    OnChange = FileListChange
    OnClick = FileListChange
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 16
    Top = 16
    Width = 145
    Height = 153
    Color = clWhite
    FileList = FileList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 10
  end
  object DriveComboBox1: TDriveComboBox
    Left = 168
    Top = 16
    Width = 201
    Height = 19
    Color = clWhite
    DirList = DirectoryListBox1
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object vendor: TEdit
    Left = 104
    Top = 360
    Width = 177
    Height = 19
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 12
  end
  object sr: TEdit
    Left = 104
    Top = 192
    Width = 55
    Height = 19
    TabStop = False
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
  end
  object Button1: TButton
    Left = 384
    Top = 88
    Width = 121
    Height = 25
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1072#1083#1100#1073#1086#1084
    TabOrder = 14
    OnClick = Button1Click
  end
  object br: TEdit
    Left = 272
    Top = 192
    Width = 55
    Height = 19
    TabStop = False
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 15
  end
  object nom: TEdit
    Left = 336
    Top = 192
    Width = 55
    Height = 19
    TabStop = False
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 16
  end
  object mode: TEdit
    Left = 448
    Top = 192
    Width = 49
    Height = 19
    TabStop = False
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 17
  end
  object enc: TEdit
    Left = 336
    Top = 360
    Width = 161
    Height = 19
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 18
  end
end
