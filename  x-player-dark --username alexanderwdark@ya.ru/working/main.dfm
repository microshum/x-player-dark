object ID3EDIT: TID3EDIT
  Left = 220
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' MPEG ID3'
  ClientHeight = 459
  ClientWidth = 520
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
  object Bevel1: TBevel
    Left = 368
    Top = 16
    Width = 137
    Height = 57
  end
  object InfoBevel: TBevel
    Left = 8
    Top = 172
    Width = 505
    Height = 239
  end
  object TagExistsLabel: TLabel
    Left = 18
    Top = 176
    Width = 65
    Height = 17
    AutoSize = False
    Caption = 'ID3V2'
    Transparent = True
    Layout = tlCenter
  end
  object VersionLabel: TLabel
    Left = 168
    Top = 176
    Width = 49
    Height = 17
    AutoSize = False
    Caption = #1042#1077#1088#1089#1080#1103':'
    Transparent = True
    Layout = tlCenter
  end
  object SizeLabel: TLabel
    Left = 290
    Top = 176
    Width = 47
    Height = 17
    AutoSize = False
    Caption = #1056#1072#1079#1084#1077#1088':'
    Transparent = True
    Layout = tlCenter
  end
  object TitleLabel: TLabel
    Left = 18
    Top = 204
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    Transparent = True
    Layout = tlCenter
  end
  object ArtistLabel: TLabel
    Left = 18
    Top = 230
    Width = 69
    Height = 17
    AutoSize = False
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':'
    Transparent = True
    Layout = tlCenter
  end
  object AlbumLabel: TLabel
    Left = 18
    Top = 256
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1040#1083#1100#1073#1086#1084':'
    Transparent = True
    Layout = tlCenter
  end
  object TrackLabel: TLabel
    Left = 18
    Top = 280
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1058#1088#1101#1082':'
    Transparent = True
    Layout = tlCenter
  end
  object YearLabel: TLabel
    Left = 158
    Top = 278
    Width = 49
    Height = 17
    AutoSize = False
    Caption = #1043#1086#1076':'
    Transparent = True
    Layout = tlCenter
  end
  object GenreLabel: TLabel
    Left = 244
    Top = 278
    Width = 57
    Height = 17
    AutoSize = False
    Caption = #1046#1072#1085#1088':'
    Transparent = True
    Layout = tlCenter
  end
  object CommentLabel: TLabel
    Left = 18
    Top = 306
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1044#1086#1087'. '#1080#1085#1092#1086':'
    Transparent = True
    Layout = tlCenter
  end
  object ComposerLabel: TLabel
    Left = 18
    Top = 334
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1050#1086#1084#1087#1086#1079#1080#1090#1086#1088':'
    Transparent = True
    Layout = tlCenter
  end
  object CopyrightLabel: TLabel
    Left = 18
    Top = 358
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1055#1088#1072#1074#1072':'
    Transparent = True
    Layout = tlCenter
  end
  object EncoderLabel: TLabel
    Left = 290
    Top = 334
    Width = 73
    Height = 17
    AutoSize = False
    Caption = #1050#1086#1076#1080#1088#1086#1074#1097#1080#1082':'
    Transparent = True
    Layout = tlCenter
  end
  object LanguageLabel: TLabel
    Left = 290
    Top = 360
    Width = 57
    Height = 17
    AutoSize = False
    Caption = #1071#1079#1099#1082':'
    Transparent = True
    Layout = tlCenter
  end
  object LinkLabel: TLabel
    Left = 18
    Top = 384
    Width = 65
    Height = 17
    AutoSize = False
    Caption = #1057#1089#1099#1083#1082#1072':'
    Transparent = True
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 451
    Top = 24
    Width = 35
    Height = 13
    Caption = 'ID3v1'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 448
    Top = 48
    Width = 39
    Height = 13
    Caption = ' ID3v2'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object TagExistsValue: TEdit
    Left = 96
    Top = 176
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
    TabOrder = 0
  end
  object VersionValue: TEdit
    Left = 226
    Top = 176
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
    TabOrder = 1
  end
  object SizeValue: TEdit
    Left = 348
    Top = 176
    Width = 145
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
    TabOrder = 2
  end
  object TitleEdit: TEdit
    Left = 96
    Top = 204
    Width = 397
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
  object ArtistEdit: TEdit
    Left = 96
    Top = 228
    Width = 397
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
  object AlbumEdit: TEdit
    Left = 96
    Top = 252
    Width = 397
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
  object TrackEdit: TEdit
    Left = 96
    Top = 276
    Width = 53
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
    TabOrder = 6
  end
  object YearEdit: TEdit
    Left = 190
    Top = 278
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
    TabOrder = 7
  end
  object CommentEdit: TEdit
    Left = 96
    Top = 306
    Width = 397
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
    TabOrder = 8
  end
  object RemoveButton: TButton
    Left = 366
    Top = 86
    Width = 139
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 15
    OnClick = RemoveButtonClick
  end
  object SaveButton: TButton
    Left = 366
    Top = 114
    Width = 141
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 14
    OnClick = SaveButtonClick
  end
  object ComposerEdit: TEdit
    Left = 96
    Top = 332
    Width = 181
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
    TabOrder = 9
  end
  object EncoderEdit: TEdit
    Left = 364
    Top = 330
    Width = 129
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
    TabOrder = 10
  end
  object CopyrightEdit: TEdit
    Left = 96
    Top = 358
    Width = 183
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
    TabOrder = 11
  end
  object LanguageEdit: TEdit
    Left = 364
    Top = 356
    Width = 129
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
    TabOrder = 12
  end
  object LinkEdit: TEdit
    Left = 96
    Top = 382
    Width = 397
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
    TabOrder = 13
  end
  object genreedit: TComboBox
    Left = 294
    Top = 278
    Width = 199
    Height = 21
    AutoDropDown = True
    AutoCloseUp = True
    Style = csDropDownList
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
    TabOrder = 16
  end
  object FileList: TFileListBox
    Left = 168
    Top = 40
    Width = 185
    Height = 121
    Color = clWhite
    FileType = [ftReadOnly, ftHidden, ftSystem, ftArchive, ftNormal]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Mask = '*.mp3'
    ParentFont = False
    ShowGlyphs = True
    TabOrder = 17
    OnChange = FileListChange
  end
  object dirlist: TDirectoryListBox
    Left = 8
    Top = 16
    Width = 153
    Height = 145
    Color = clWhite
    FileList = FileList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 18
  end
  object DriveComboBox1: TDriveComboBox
    Left = 168
    Top = 16
    Width = 185
    Height = 19
    Color = clWhite
    DirList = dirlist
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
  end
  object ver: TTrackBar
    Left = 376
    Top = 24
    Width = 57
    Height = 41
    Max = 1
    Orientation = trVertical
    TabOrder = 20
    ThumbLength = 25
    TickMarks = tmBoth
    OnChange = verChange
  end
  object Button1: TButton
    Left = 14
    Top = 426
    Width = 141
    Height = 25
    Caption = 'ID3v1 '#1074' ID3v2'
    TabOrder = 21
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 166
    Top = 426
    Width = 141
    Height = 25
    Caption = 'ID3v2 '#1074' ID3v1'
    TabOrder = 22
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 318
    Top = 426
    Width = 141
    Height = 25
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1072#1083#1100#1073#1086#1084
    TabOrder = 23
    OnClick = Button3Click
  end
end
