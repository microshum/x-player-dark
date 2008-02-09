object Form1: TForm1
  Left = 309
  Top = 187
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'DarkCFG Editor'
  ClientHeight = 204
  ClientWidth = 365
  Color = 4227327
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 232
    Top = 160
    Width = 117
    Height = 33
    Caption = 'DarkCFG'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 0
    Top = 168
    Width = 217
    Height = 10
    Shape = bsBottomLine
  end
  object Bevel2: TBevel
    Left = 216
    Top = 152
    Width = 17
    Height = 50
    Shape = bsLeftLine
  end
  object opt: TComboBox
    Left = 8
    Top = 8
    Width = 353
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnSelect = optSelect
  end
  object mem: TMemo
    Left = 8
    Top = 32
    Width = 353
    Height = 89
    Color = 10469119
    ReadOnly = True
    TabOrder = 1
  end
  object theval: TEdit
    Left = 8
    Top = 128
    Width = 353
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 24
    Top = 168
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1100
    Default = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 168
    Width = 75
    Height = 25
    Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
end
