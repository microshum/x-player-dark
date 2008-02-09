object Form1: TForm1
  Left = 438
  Top = 86
  BorderStyle = bsDialog
  Caption = 'XAMP Voice Engine Setup'
  ClientHeight = 300
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 305
    Height = 300
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1043#1083#1072#1074#1085#1086#1077
      object ComboBox1: TComboBox
        Left = 8
        Top = 16
        Width = 265
        Height = 21
        Style = csDropDownList
        Color = clBtnFace
        ItemHeight = 13
        TabOrder = 0
        OnSelect = ComboBox1Change
      end
      object memo1: TMemo
        Left = 8
        Top = 48
        Width = 265
        Height = 89
        Color = clBtnFace
        Lines.Strings = (
          #1050#1072#1082' '#1075#1083#1072#1074#1072' '#1087#1088#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1072' '#1051#1077#1085#1080#1085' '#1095#1072#1089#1090#1086' '
          #1076#1086#1087#1091#1089#1082#1072#1083' '#1074#1086#1083#1102#1085#1090#1072#1088#1080#1079#1084' '#1080' '#1089#1072#1084#1086#1074#1083#1072#1089#1090#1080#1077'.')
        ReadOnly = True
        TabOrder = 1
      end
      object ti: TTrackBar
        Left = 8
        Top = 176
        Width = 265
        Height = 49
        LineSize = 50
        Max = 40000
        Min = 10
        PageSize = 150
        Frequency = 1000
        Position = 10
        TabOrder = 2
        TickMarks = tmBoth
        OnChange = tiChange
      end
      object Button1: TButton
        Left = 8
        Top = 144
        Width = 105
        Height = 25
        Caption = #1058#1077#1089#1090
        TabOrder = 3
        OnClick = SpeakClick
      end
      object Button2: TButton
        Left = 168
        Top = 144
        Width = 105
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        TabOrder = 4
        OnClick = Button2Click
      end
      object red: TCheckBox
        Left = 16
        Top = 221
        Width = 137
        Height = 17
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1089#1090
        TabOrder = 5
        OnClick = redClick
      end
      object disable: TCheckBox
        Left = 16
        Top = 248
        Width = 129
        Height = 17
        Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1076#1080#1082#1090#1086#1088#1072
        TabOrder = 6
      end
      object Button9: TButton
        Left = 120
        Top = 144
        Width = 41
        Height = 25
        Caption = '?'
        TabOrder = 7
        OnClick = Button9Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 79
        Height = 13
        Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 42
        Height = 13
        Caption = #1055#1088#1086#1076#1091#1082#1090
      end
      object Label3: TLabel
        Left = 8
        Top = 80
        Width = 35
        Height = 13
        Caption = #1056#1077#1078#1080#1084
      end
      object Label4: TLabel
        Left = 8
        Top = 144
        Width = 44
        Height = 13
        Caption = #1044#1080#1072#1083#1077#1082#1090
      end
      object Label5: TLabel
        Left = 8
        Top = 112
        Width = 38
        Height = 13
        Caption = #1044#1080#1082#1090#1086#1088
      end
      object Label6: TLabel
        Left = 8
        Top = 176
        Width = 30
        Height = 13
        Caption = #1057#1090#1080#1083#1100
      end
      object Label7: TLabel
        Left = 8
        Top = 208
        Width = 42
        Height = 13
        Caption = #1042#1086#1079#1088#1072#1089#1090
      end
      object Edit1: TEdit
        Left = 104
        Top = 8
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 104
        Top = 40
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object Edit3: TEdit
        Left = 104
        Top = 72
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object Edit4: TEdit
        Left = 104
        Top = 136
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
      object Edit5: TEdit
        Left = 104
        Top = 104
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object Edit6: TEdit
        Left = 104
        Top = 168
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
      object Edit7: TEdit
        Left = 104
        Top = 200
        Width = 169
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1040#1090#1090#1088#1080#1073#1091#1090#1099
      ImageIndex = 2
      object Label8: TLabel
        Left = 32
        Top = 40
        Width = 31
        Height = 13
        Caption = 'Speed'
      end
      object Label9: TLabel
        Left = 32
        Top = 72
        Width = 24
        Height = 13
        Caption = 'Pitch'
      end
      object Button3: TButton
        Left = 8
        Top = 0
        Width = 75
        Height = 25
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100
        TabOrder = 0
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 96
        Top = 0
        Width = 75
        Height = 25
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 16
        Top = 104
        Width = 75
        Height = 25
        Caption = #1043#1083#1072#1074#1085#1086#1077
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 96
        Top = 104
        Width = 75
        Height = 25
        Caption = #1051#1077#1082#1089#1080#1082#1072
        TabOrder = 3
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 184
        Top = 104
        Width = 75
        Height = 25
        Caption = #1055#1077#1088#1077#1074#1086#1076
        TabOrder = 4
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 96
        Top = 136
        Width = 75
        Height = 25
        Caption = #1048#1085#1092#1086
        TabOrder = 5
        OnClick = Button8Click
      end
      object pit: TEdit
        Left = 112
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 6
      end
      object spd: TEdit
        Left = 112
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 7
      end
    end
  end
  object timer: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 296
    Top = 296
  end
end
