object blacklist: Tblacklist
  Left = 391
  Top = 351
  Width = 322
  Height = 134
  BorderIcons = [biSystemMenu]
  Caption = #1063#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 6
    Top = 10
    Width = 301
    Height = 63
    AutoComplete = False
    Color = 8421440
    Ctl3D = False
    ExtendedSelect = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    MultiSelect = True
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object DF: TButton
    Left = 8
    Top = 84
    Width = 23
    Height = 17
    Caption = '+'
    TabOrder = 1
    OnClick = DFClick
  end
  object DEL: TButton
    Left = 36
    Top = 84
    Width = 25
    Height = 17
    Caption = '-'
    TabOrder = 2
    OnClick = DELClick
  end
  object pm: TPopupMenu
    Left = 176
    Top = 40
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100'...'
      OnClick = N1Click
    end
  end
  object OpenDialog: TOpenDialog
    Ctl3D = False
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 144
    Top = 40
  end
end
