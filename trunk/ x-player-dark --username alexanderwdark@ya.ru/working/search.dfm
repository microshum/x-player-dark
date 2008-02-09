object Form2: TForm2
  Left = 149
  Top = 132
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1069#1092#1092#1077#1082#1090#1099
  ClientHeight = 362
  ClientWidth = 360
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 120
    Width = 361
    Height = 9
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = -16
    Top = 256
    Width = 377
    Height = 9
    Shape = bsTopLine
  end
  object eof: TButton
    Left = 8
    Top = 8
    Width = 57
    Height = 17
    Caption = #1042#1099#1082#1083
    Enabled = False
    TabOrder = 0
    OnClick = eofClick
  end
  object EQOff: TButton
    Left = 8
    Top = 128
    Width = 57
    Height = 17
    Caption = #1042#1099#1082#1083
    Enabled = False
    TabOrder = 1
    OnClick = EQOffClick
  end
  object Button3: TButton
    Left = 144
    Top = 128
    Width = 57
    Height = 17
    Caption = #1057#1073#1088#1086#1089
    TabOrder = 2
    OnClick = Button3Click
  end
  object e1: TScrollBar
    Left = 16
    Top = 152
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 3
    OnScroll = e1Scroll
  end
  object e2: TScrollBar
    Left = 52
    Top = 153
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 4
    OnScroll = e2Scroll
  end
  object e3: TScrollBar
    Left = 88
    Top = 153
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 5
    OnScroll = e3Scroll
  end
  object e4: TScrollBar
    Left = 125
    Top = 154
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 6
    OnScroll = e4Scroll
  end
  object e5: TScrollBar
    Left = 161
    Top = 153
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 7
    OnScroll = e5Scroll
  end
  object e6: TScrollBar
    Left = 198
    Top = 153
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 8
    OnScroll = e6Scroll
  end
  object e7: TScrollBar
    Left = 234
    Top = 152
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 9
    OnScroll = e7Scroll
  end
  object e8: TScrollBar
    Left = 271
    Top = 152
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 10
    OnScroll = e8Scroll
  end
  object e9: TScrollBar
    Left = 307
    Top = 152
    Width = 10
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 11
    OnScroll = e9Scroll
  end
  object e10: TScrollBar
    Left = 344
    Top = 152
    Width = 9
    Height = 97
    Kind = sbVertical
    Max = 15
    Min = -15
    PageSize = 0
    TabOrder = 12
    OnScroll = e10Scroll
  end
  object eqON: TButton
    Left = 72
    Top = 128
    Width = 57
    Height = 17
    Caption = #1042#1082#1083
    TabOrder = 13
    OnClick = eqONClick
  end
  object eon: TButton
    Left = 80
    Top = 8
    Width = 57
    Height = 17
    Caption = #1042#1082#1083
    TabOrder = 14
    OnClick = EchoOn
  end
  object gain: TScrollBar
    Left = 8
    Top = 32
    Width = 150
    Height = 16
    Max = 0
    Min = -60
    PageSize = 0
    TabOrder = 15
    OnScroll = gainScroll
  end
  object edge: TScrollBar
    Left = 200
    Top = 32
    Width = 150
    Height = 16
    PageSize = 0
    TabOrder = 16
    OnScroll = edgeScroll
  end
  object center: TScrollBar
    Left = 8
    Top = 64
    Width = 150
    Height = 16
    Max = 8000
    Min = 100
    PageSize = 0
    Position = 100
    TabOrder = 17
    OnScroll = centerScroll
  end
  object band: TScrollBar
    Left = 200
    Top = 64
    Width = 150
    Height = 16
    Max = 8000
    Min = 100
    PageSize = 0
    Position = 100
    TabOrder = 18
    OnScroll = bandScroll
  end
  object Button1: TButton
    Left = 216
    Top = 128
    Width = 57
    Height = 17
    Caption = #1057#1086#1093#1088'.'
    TabOrder = 19
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 128
    Width = 57
    Height = 17
    Caption = #1047#1072#1075#1088'.'
    TabOrder = 20
    OnClick = Button2Click
  end
  object cutoff: TScrollBar
    Left = 7
    Top = 94
    Width = 150
    Height = 16
    Max = 8000
    Min = 100
    PageSize = 0
    Position = 100
    TabOrder = 21
    OnScroll = bandScroll
  end
  object Button4: TButton
    Left = 216
    Top = 88
    Width = 57
    Height = 17
    Caption = #1057#1086#1093#1088'.'
    TabOrder = 22
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 288
    Top = 88
    Width = 57
    Height = 17
    Caption = #1047#1072#1075#1088'.'
    TabOrder = 23
    OnClick = Button5Click
  end
  object wave: TScrollBar
    Left = 8
    Top = 264
    Width = 121
    Height = 16
    Max = 1000
    Min = 1
    PageSize = 0
    Position = 1
    TabOrder = 24
    OnScroll = waveScroll
  end
  object wtype: TScrollBar
    Left = 8
    Top = 296
    Width = 121
    Height = 16
    Max = 1
    PageSize = 0
    TabOrder = 25
    OnScroll = wtypeScroll
  end
  object goff: TButton
    Left = 144
    Top = 264
    Width = 57
    Height = 17
    Caption = #1042#1099#1082#1083
    Enabled = False
    TabOrder = 26
    OnClick = goffClick
  end
  object gon: TButton
    Left = 208
    Top = 264
    Width = 57
    Height = 17
    Caption = #1042#1082#1083
    TabOrder = 27
    OnClick = gonClick
  end
  object SaveDialog: TSaveDialog
    Filter = 'XPlayer Preset|*.xp'
    Options = [ofHideReadOnly, ofEnableSizing, ofDontAddToRecent]
    Left = 152
    Top = 65520
  end
  object OpenDialog: TOpenDialog
    Filter = 'XPlayer Preset|*.xp'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 184
    Top = 65528
  end
end
