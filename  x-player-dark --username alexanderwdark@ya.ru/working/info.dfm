object infoform: Tinfoform
  Left = 230
  Top = 269
  Width = 322
  Height = 296
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
  Color = clWindow
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Mem: TMemo
    Left = 0
    Top = 29
    Width = 314
    Height = 240
    Cursor = crArrow
    Align = alClient
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnMouseDown = MemMouseDown
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 314
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 54
    Caption = 'ToolBar1'
    ParentColor = False
    ShowCaptions = True
    TabOrder = 1
    object GetInfo: TToolButton
      Left = 0
      Top = 2
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100
      ImageIndex = 0
      OnClick = GetInfoClick
    end
  end
end
