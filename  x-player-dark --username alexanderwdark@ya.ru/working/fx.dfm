object frmSearch: TfrmSearch
  Left = 260
  Top = 399
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1074' '#1089#1087#1080#1089#1082#1077
  ClientHeight = 72
  ClientWidth = 312
  Color = clBtnFace
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit: TEdit
    Left = 4
    Top = 8
    Width = 301
    Height = 21
    AutoSize = False
    BevelEdges = []
    BevelInner = bvLowered
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Color = clWhite
    Ctl3D = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnKeyUp = EditKeyUp
  end
  object Button1: TButton
    Left = 2
    Top = 40
    Width = 149
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 1
    OnClick = searchS
  end
  object Button2: TButton
    Left = 164
    Top = 40
    Width = 143
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
end
