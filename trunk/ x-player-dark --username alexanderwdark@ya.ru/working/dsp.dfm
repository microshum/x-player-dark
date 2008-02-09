object frmDSP: TfrmDSP
  Left = 239
  Top = 213
  BorderStyle = bsDialog
  Caption = #1069#1092#1092#1077#1082#1090#1099
  ClientHeight = 240
  ClientWidth = 408
  Color = clWindow
  Ctl3D = False
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox: TGroupBox
    Left = 0
    Top = 0
    Width = 408
    Height = 240
    Align = alClient
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 0
      Top = 85
      Width = 401
      Height = 9
      Shape = bsTopLine
    end
    object lblDX: TLabel
      Left = 8
      Top = 176
      Width = 369
      Height = 13
      AutoSize = False
      Caption = #1063#1072#1089#1090#1086#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lblDXClick
    end
    object e1: TScrollBar
      Left = 8
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 1
      OnChange = e1Change
    end
    object e2: TScrollBar
      Left = 48
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 2
      OnChange = e2Change
    end
    object e3: TScrollBar
      Left = 88
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 3
      OnChange = e3Change
    end
    object tbDXRate: TTrackBar
      Left = 8
      Top = 192
      Width = 385
      Height = 25
      Ctl3D = False
      Max = 57330
      Min = 30870
      ParentCtl3D = False
      PageSize = 100
      Frequency = 2000
      Position = 44100
      TabOrder = 4
      ThumbLength = 15
      TickMarks = tmTopLeft
      TickStyle = tsNone
      OnChange = tbDXRateChange
    end
    object chkEqualizer: TCheckBox
      Left = 8
      Top = 8
      Width = 105
      Height = 17
      Caption = #1069#1082#1074#1072#1083#1072#1081#1079#1077#1088
      Ctl3D = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnClick = chkEqualizerClick
    end
    object e4: TScrollBar
      Left = 128
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 5
      OnChange = e4Change
    end
    object e8: TScrollBar
      Left = 288
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 6
      OnChange = e8Change
    end
    object e7: TScrollBar
      Left = 248
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 7
      OnChange = e7Change
    end
    object e6: TScrollBar
      Left = 208
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 8
      OnChange = e6Change
    end
    object e5: TScrollBar
      Left = 168
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 9
      OnChange = e5Change
    end
    object e10: TScrollBar
      Left = 368
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 10
      OnChange = e10Change
    end
    object e9: TScrollBar
      Left = 328
      Top = 32
      Width = 17
      Height = 100
      Ctl3D = False
      Kind = sbVertical
      Max = 10
      Min = -10
      PageSize = 0
      ParentCtl3D = False
      TabOrder = 11
      OnChange = e9Change
    end
    object Button1: TButton
      Left = 168
      Top = 144
      Width = 75
      Height = 17
      Caption = #1086#1090#1082#1088#1099#1090#1100
      TabOrder = 12
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 88
      Top = 144
      Width = 75
      Height = 17
      Caption = #1089#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 13
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 144
      Width = 75
      Height = 17
      Caption = #1089#1073#1088#1086#1089
      TabOrder = 14
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 8
      Top = 216
      Width = 65
      Height = 17
      Caption = #1089#1073#1088#1086#1089
      TabOrder = 15
      OnClick = Button4Click
    end
  end
  object SaveDialog: TSaveDialog
    Ctl3D = False
    Left = 224
  end
  object OpenDialog: TOpenDialog
    Ctl3D = False
    Left = 256
  end
  object lmenu: TPopupMenu
    AutoHotkeys = maManual
    Left = 152
    Top = 65528
    object preset: TMenuItem
      Caption = #1047#1072#1090#1086#1090#1086#1074#1082#1091
    end
    object N1: TMenuItem
      Caption = #1048#1079' '#1092#1072#1081#1083#1072'...'
      OnClick = open
    end
  end
  object smenu: TPopupMenu
    AutoHotkeys = maManual
    Left = 120
    Top = 65528
    object N3: TMenuItem
      Caption = #1050#1072#1082' '#1079#1072#1075#1086#1090#1086#1074#1082#1091
      OnClick = N3Click
    end
    object N2: TMenuItem
      Caption = #1042' '#1092#1072#1081#1083'...'
      OnClick = save
    end
  end
end
