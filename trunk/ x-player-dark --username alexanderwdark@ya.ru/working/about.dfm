object simplyabout: Tsimplyabout
  Left = 315
  Top = 249
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086
  ClientHeight = 278
  ClientWidth = 478
  Color = clWindow
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label25: TLabel
    Left = 8
    Top = 87
    Width = 465
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1086#1089#1074#1103#1097#1072#1077#1090#1089#1103' '#1083#1102#1073#1080#1084#1086#1081' '#1085#1077#1074#1077#1089#1090#1077' '#1052'.'#1042'.'#1064'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    OnClick = Label25Click
    OnMouseEnter = Label25MouseEnter
    OnMouseLeave = Label25MouseLeave
  end
  object pb: TPaintBox
    Left = 8
    Top = 8
    Width = 465
    Height = 49
    OnPaint = pbPaint
  end
  object Label1: TLabel
    Left = 8
    Top = 64
    Width = 465
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 
      '('#1089') 2003-2007 '#1040#1083#1077#1082#1089#1072#1085#1076#1088' '#1044'ark. DarkSoftware. '#1055#1088#1086#1080#1079#1074#1077#1076#1077#1085#1086' '#1074' '#1056#1086#1089#1089#1080#1081 +
      #1089#1082#1086#1081' '#1060#1077#1076#1077#1088#1072#1094#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo2: TMemo
    Left = 8
    Top = 112
    Width = 465
    Height = 161
    Cursor = crArrow
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    Lines.Strings = (
      #1050#1083#1072#1074#1080#1096#1080' (+ Win+Shift):'
      'P - '#1087#1072#1091#1079#1072
      'S - '#1089#1090#1086#1087
      'R - '#1087#1091#1089#1082
      'H - '#1087#1086#1082#1072#1079#1072#1090#1100' '#1086#1082#1085#1086
      'F - '#1085#1072#1079#1072#1076' '#1087#1086' '#1089#1087#1080#1089#1082#1091
      'B - '#1074#1087#1077#1088#1077#1076' '#1087#1086' '#1089#1087#1080#1089#1082#1091
      'L - '#1087#1086#1082#1072#1079#1072#1090#1100' '#1087#1083#1077#1081#1083#1080#1089#1090
      ''
      #1050#1083#1072#1074#1080#1096#1080' (+ Win):'
      ''
      #1074#1085#1080#1079' - '#1090#1080#1096#1077
      #1074#1074#1077#1088#1093' - '#1075#1088#1086#1084#1095#1077' '
      #1074#1083#1077#1074#1086' - '#1085#1072#1079#1072#1076
      #1074#1087#1088#1072#1074#1086' - '#1074#1087#1077#1088#1077#1076
      ''
      #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1079#1072#1087#1091#1089#1082#1072':'
      'mp3.exe <'#1092#1072#1081#1083', '#1082#1072#1090#1072#1083#1086#1075' '#1080#1083#1080' '#1087#1083#1077#1081#1083#1080#1089#1090'> [-play]'
      #1075#1076#1077' -play '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1076#1083#1103' '#1072#1074#1090#1086#1074#1086#1089#1087#1088#1086#1080#1079#1074#1077#1076#1077#1085#1080#1103
      #1044#1083#1080#1085#1085#1099#1077' '#1080#1084#1077#1085#1072' '#1092#1072#1081#1083#1086#1074' '#1091#1082#1072#1079#1099#1074#1072#1102#1090#1089#1103' '#1074' '#1082#1072#1074#1099#1095#1082#1072#1093' " "'
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnMouseDown = Memo2MouseDown
  end
end
