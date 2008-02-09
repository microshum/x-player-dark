object frmTe: TfrmTe
  Left = 440
  Top = 437
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1076#1086#1088#1086#1078#1077#1082
  ClientHeight = 317
  ClientWidth = 536
  Color = clWindow
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 72
    Width = 67
    Height = 13
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
    Transparent = True
  end
  object Label2: TLabel
    Left = 272
    Top = 72
    Width = 39
    Height = 13
    Caption = #1040#1083#1100#1073#1086#1084
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 0
    Top = 88
    Width = 537
    Height = 9
    Shape = bsTopLine
  end
  object cds: TComboBox
    Left = 16
    Top = 16
    Width = 505
    Height = 21
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
    TabOrder = 0
    OnSelect = cdsSelect
  end
  object ListBox1: TListBox
    Left = 16
    Top = 96
    Width = 505
    Height = 153
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
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 256
    Width = 505
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    OnKeyDown = Edit1KeyDown
  end
  object artist: TEdit
    Left = 16
    Top = 48
    Width = 241
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
  end
  object album: TEdit
    Left = 272
    Top = 48
    Width = 248
    Height = 19
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
  end
  object Save: TButton
    Left = 16
    Top = 288
    Width = 505
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 5
    OnClick = SaveClick
  end
end
