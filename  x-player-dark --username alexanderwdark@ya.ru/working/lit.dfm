object playlist: Tplaylist
  Left = 407
  Top = 129
  BorderIcons = [biSystemMenu]
  Caption = #1055#1083#1077#1081#1083#1080#1089#1090
  ClientHeight = 109
  ClientWidth = 316
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCanResize = FormCanResize
  OnCreate = oncreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object link: TLabel
    Left = 320
    Top = 88
    Width = 70
    Height = 13
    Caption = #1044#1080#1089#1082#1080' '#1087#1086#1095#1090#1086#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = linkClick
    OnMouseEnter = linkMouseEnter
    OnMouseLeave = linkMouseLeave
  end
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
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = PopupMenu
    TabOrder = 0
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
    OnKeyDown = ListBox1KeyDown
  end
  object DF: TButton
    Left = 8
    Top = 84
    Width = 23
    Height = 17
    Caption = '+'
    PopupMenu = PM
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
  object misc: TButton
    Left = 66
    Top = 84
    Width = 25
    Height = 17
    Caption = '='
    TabOrder = 3
    OnClick = miscClick
  end
  object pan: TTrackBar
    Left = 108
    Top = 80
    Width = 75
    Height = 25
    LineSize = 10
    Max = 100
    Min = -101
    Frequency = 25
    TabOrder = 4
    ThumbLength = 10
    TickMarks = tmTopLeft
    OnChange = panChange
  end
  object volume: TTrackBar
    Left = 196
    Top = 80
    Width = 75
    Height = 25
    LineSize = 10
    Max = 100
    Frequency = 10
    TabOrder = 5
    ThumbLength = 10
    TickMarks = tmTopLeft
    OnChange = volumeChange
  end
  object Button1: TButton
    Left = 282
    Top = 88
    Width = 25
    Height = 17
    Caption = 'I'
    TabOrder = 6
    OnClick = about
  end
  object PM: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Left = 272
    Top = 38
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1072#1081#1083#1099
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1090#1072#1083#1086#1075
      OnClick = N2Click
    end
    object N24: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1085#1090#1077#1088#1085#1077#1090'-'#1088#1072#1076#1080#1086
      OnClick = N24Click
    end
  end
  object mm: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = mmPopup
    Left = 242
    Top = 38
    object newlst: TMenuItem
      Caption = #1053#1086#1074#1099#1081
      OnClick = newlstClick
    end
    object N4: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      OnClick = N5Click
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object N15: TMenuItem
      Caption = #1057#1083#1091#1095#1072#1081#1085#1099#1081' '#1087#1086#1088#1103#1076#1086#1082' '#1090#1088#1077#1082#1086#1074
      OnClick = N14Click
    end
  end
  object PopupMenu: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PopupMenuPopup
    Left = 208
    Top = 38
    object N8: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = N8Click
    end
    object cdlist: TMenuItem
      Caption = #1042#1086#1089#1087#1088#1086#1080#1079#1074#1077#1076#1077#1085#1080#1077' Audio CD'
    end
    object remlist: TMenuItem
      Caption = #1042#1086#1089#1087#1088#1086#1080#1079#1074#1077#1089#1090#1080' '#1089#1086' '#1089#1098#1077#1084#1085#1086#1075#1086' '#1076#1080#1089#1082#1072
    end
    object kdisk: TMenuItem
      Caption = #1042#1086#1087#1088#1086#1080#1079#1074#1077#1089#1090#1080' '#1089' CD/DVD '#1076#1080#1089#1082#1072
    end
    object hdisk: TMenuItem
      Caption = #1042#1086#1087#1088#1086#1080#1079#1074#1077#1089#1090#1080' '#1080' '#1053#1046#1052#1044
    end
    object CDTE: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1088#1101#1082#1086#1074' CD'
      OnClick = CDTEClick
    end
    object N10: TMenuItem
      Caption = #1059#1073#1088#1072#1090#1100' '#1085#1077#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1077
      OnClick = N10Click
    end
    object N9: TMenuItem
      Caption = #1069#1092#1092#1077#1082#1090#1099
      OnClick = N9Click
    end
    object N7: TMenuItem
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      OnClick = N7Click
    end
    object devices: TMenuItem
      Caption = #1059#1089#1090#1088#1086#1081#1089#1090#1074#1072' '#1074#1099#1074#1086#1076#1072
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = #1055#1086#1080#1089#1082' '#1074' '#1089#1087#1080#1089#1082#1077
      OnClick = N6Click
    end
    object N110: TMenuItem
      Caption = #1063#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
      object N12: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = N12Click
      end
      object sbl: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100
        OnClick = shbl
      end
    end
    object N3: TMenuItem
      Caption = #1057#1087#1077#1082#1090#1088
      OnClick = N3Click
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object N18: TMenuItem
      Caption = #1048#1085#1090#1077#1075#1088#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1054#1057
      OnClick = N18Click
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object N20: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072'...'
      object N21: TMenuItem
        Caption = #1059#1090#1080#1083#1080#1090#1072' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = N21Click
      end
      object N22: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1075#1086#1083#1086#1089#1086#1074#1086#1075#1086' '#1076#1074#1080#1078#1072
        OnClick = N22Click
      end
      object N23: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1088#1077#1087#1083#1080#1082
        OnClick = N23Click
      end
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object N13: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      OnClick = about
    end
  end
  object SaveDialog: TSaveDialog
    Ctl3D = False
    DefaultExt = '.lst'
    OptionsEx = [ofExNoPlacesBar]
    Left = 140
    Top = 22
  end
  object OpenDialog: TOpenDialog
    Ctl3D = False
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofCreatePrompt, ofEnableSizing, ofDontAddToRecent, ofForceShowHidden]
    Left = 106
    Top = 22
  end
end
