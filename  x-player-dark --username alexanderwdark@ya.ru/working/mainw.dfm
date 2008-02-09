object ID3EDITW: TID3EDITW
  Left = 481
  Top = 38
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WAV Info'
  ClientHeight = 421
  ClientWidth = 361
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
    Left = 8
    Top = 172
    Width = 345
    Height = 239
  end
  object Label1: TLabel
    Left = 16
    Top = 184
    Width = 116
    Height = 13
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090
    Transparent = True
  end
  object Label2: TLabel
    Left = 16
    Top = 208
    Width = 42
    Height = 13
    Caption = #1060#1086#1088#1084#1072#1090
    Transparent = True
  end
  object Label3: TLabel
    Left = 16
    Top = 232
    Width = 80
    Height = 13
    Caption = #1056#1077#1078#1080#1084' '#1082#1072#1085#1072#1083#1086#1074
    Transparent = True
  end
  object Label4: TLabel
    Left = 16
    Top = 256
    Width = 42
    Height = 13
    Caption = #1063#1072#1089#1090#1086#1090#1072
    Transparent = True
  end
  object Label5: TLabel
    Left = 16
    Top = 280
    Width = 76
    Height = 13
    Caption = #1041#1072#1081#1090' '#1074' '#1089#1077#1082#1091#1085#1076#1091
    Transparent = True
  end
  object Label6: TLabel
    Left = 16
    Top = 304
    Width = 68
    Height = 13
    Caption = #1041#1080#1090' '#1085#1072' '#1089#1101#1084#1087#1083
    Transparent = True
  end
  object Label7: TLabel
    Left = 16
    Top = 328
    Width = 77
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1082#1072#1085#1072#1083#1086#1074
    Transparent = True
  end
  object Label8: TLabel
    Left = 16
    Top = 352
    Width = 105
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1097#1077#1085#1080#1077' '#1073#1083#1086#1082#1086#1074
    Transparent = True
  end
  object Label9: TLabel
    Left = 16
    Top = 376
    Width = 76
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1057#1101#1084#1087#1083#1072
    Transparent = True
  end
  object FileList: TFileListBox
    Left = 168
    Top = 40
    Width = 185
    Height = 121
    Color = clWhite
    Ctl3D = False
    FileType = [ftReadOnly, ftHidden, ftSystem, ftArchive, ftNormal]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Mask = '*.Wav'
    ParentCtl3D = False
    ParentFont = False
    ShowGlyphs = True
    TabOrder = 0
    OnChange = FileListChange
  end
  object dirlist: TDirectoryListBox
    Left = 8
    Top = 16
    Width = 153
    Height = 145
    Color = clWhite
    Ctl3D = False
    FileList = FileList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
  end
  object DriveComboBox1: TDriveComboBox
    Left = 168
    Top = 16
    Width = 185
    Height = 19
    Color = clWhite
    Ctl3D = False
    DirList = dirlist
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object TagExistsValue: TEdit
    Left = 200
    Top = 184
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 3
  end
  object Format: TEdit
    Left = 200
    Top = 208
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 4
  end
  object ChM: TEdit
    Left = 200
    Top = 232
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 5
  end
  object Sr: TEdit
    Left = 200
    Top = 256
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 6
  end
  object Bps: TEdit
    Left = 200
    Top = 280
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 7
  end
  object bips: TEdit
    Left = 200
    Top = 304
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 8
  end
  object cn: TEdit
    Left = 200
    Top = 328
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 9
  end
  object ba: TEdit
    Left = 200
    Top = 352
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 10
  end
  object sn: TEdit
    Left = 200
    Top = 376
    Width = 121
    Height = 19
    Color = clWhite
    ReadOnly = True
    TabOrder = 11
  end
end
