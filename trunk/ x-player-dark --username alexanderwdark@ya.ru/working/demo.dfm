object Form1: TForm1
  Left = 301
  Top = 185
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'XARC'
  ClientHeight = 343
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 272
    Width = 481
    Height = 65
    Caption = 'console'
    TabOrder = 10
  end
  object Button1: TButton
    Left = 360
    Top = 8
    Width = 129
    Height = 25
    Caption = 'new archive'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 360
    Top = 40
    Width = 129
    Height = 25
    Caption = 'open arcive'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 360
    Top = 72
    Width = 129
    Height = 25
    Caption = 'list files'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 360
    Top = 104
    Width = 129
    Height = 25
    Caption = 'delete file(s)'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 360
    Top = 136
    Width = 129
    Height = 25
    Caption = 'add file(s)'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 360
    Top = 168
    Width = 129
    Height = 25
    Caption = 'compact arcive'
    TabOrder = 5
    OnClick = Button6Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 329
    Height = 217
    ItemHeight = 15
    TabOrder = 6
    OnDblClick = ListBox1DblClick
  end
  object Edit1: TEdit
    Left = 24
    Top = 296
    Width = 449
    Height = 23
    TabOrder = 7
  end
  object Button7: TButton
    Left = 360
    Top = 200
    Width = 129
    Height = 25
    Caption = 'extract file(s)'
    TabOrder = 8
    OnClick = Button7Click
  end
  object destdir: TEdit
    Left = 8
    Top = 240
    Width = 481
    Height = 23
    TabOrder = 9
    Text = 'c:\windows\temp'
  end
  object od: TOpenDialog
    Filter = '*.*|*.*'
    Left = 104
    Top = 24
  end
  object sd: TSaveDialog
    Filter = '*.*|*.*'
    Left = 136
    Top = 24
  end
  object XARC1: TXARC
    TempExt = '.$$$'
    Left = 136
    Top = 88
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 248
    Top = 152
  end
end
