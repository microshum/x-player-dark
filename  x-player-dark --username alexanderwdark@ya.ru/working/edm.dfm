object edroot: Tedroot
  Left = 192
  Top = 199
  Width = 690
  Height = 388
  BorderWidth = 2
  Caption = 'Voice.cfg Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000007777770000000000000000
    0000000000000007000000000000000000000000000000070000000000000000
    0000000000777007000000000000000000077070007770070000700000000000
    0077000700787000000007000000000007708000077877000070007000000000
    07088807777777770777000700000000008F88877FFFFF077887700700000000
    00088888F88888FF08870070000000000000880888877778F070007000000007
    77088888880007778F770077777000700008F088007777077F07000000700700
    008F08880800077778F7700000700708888F0880F08F807078F7777700700708
    F88F0780F070F07078F7887700700708888F0780F077807088F7777700700700
    008F0788FF00080888F77000007000000008F0780FFFF0088F77007000000000
    0008F07788000888887700700000000000008F07788888880870007000000000
    00088FF0077788088887000700000000008F888FF00000F87887700700000000
    0708F8088FFFFF88078700700000000007708000088888000070070000000000
    0077007000888007000070000000000000077700008F80070007000000000000
    0000000000888007000000000000000000000000000000070000000000000000
    000000000777777700000000000000000000000000000000000000000000FFFF
    FFFFFFFC0FFFFFFC0FFFFFF80FFFFFF80FFFFE180E7FFC00043FF800001FF800
    000FF800000FFC00001FFE00001FE0000001C000000180000001800000018000
    00018000000180000001FC00001FFC00001FFE00001FFC00000FF800000FF800
    001FF800003FFC180C7FFE380EFFFFF80FFFFFF80FFFFFF80FFFFFFFFFFF}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object edit: TOvcTextFileEditor
    Left = 0
    Top = 56
    Width = 678
    Height = 301
    AutoIndent = False
    CaretOvr.Shape = csBlock
    FixedFont.Color = clWindowText
    FixedFont.Name = 'Fixedsys'
    FixedFont.Size = 8
    FixedFont.Style = []
    HighlightColors.BackColor = clHighlight
    HighlightColors.TextColor = clHighlightText
    LeftMargin = 36
    MarginColor = 16769505
    MarginOptions.Right.LinePosition = 5
    MarginOptions.Left.LinePosition = 36
    RightMargin = 5
    ShowLineNumbers = True
    ShowRules = True
    WrapColumn = 75
    WrapToWindow = True
    Align = alClient
    Color = 15269887
    TabOrder = 0
  end
  object cb: TControlBar
    Left = 0
    Top = 0
    Width = 678
    Height = 56
    Align = alTop
    AutoSize = True
    TabOrder = 1
    object Button1: TButton
      Left = 11
      Top = 2
      Width = 75
      Height = 22
      Caption = '%sartist'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 99
      Top = 2
      Width = 75
      Height = 22
      Caption = '%stitle'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 187
      Top = 2
      Width = 75
      Height = 22
      Caption = '%salbum'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 275
      Top = 2
      Width = 75
      Height = 22
      Caption = '%syear'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button5: TButton
      Left = 363
      Top = 2
      Width = 75
      Height = 22
      Caption = '%nyear'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button6: TButton
      Left = 451
      Top = 2
      Width = 75
      Height = 22
      Caption = '%nmonth'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button7: TButton
      Left = 539
      Top = 2
      Width = 75
      Height = 22
      Caption = '%nday'
      TabOrder = 6
      OnClick = Button1Click
    end
    object Button9: TButton
      Left = 11
      Top = 28
      Width = 75
      Height = 22
      Caption = '%nhour'
      TabOrder = 7
      OnClick = Button1Click
    end
    object Button10: TButton
      Left = 99
      Top = 28
      Width = 75
      Height = 22
      Caption = '%nminute'
      TabOrder = 8
      OnClick = Button1Click
    end
    object Button11: TButton
      Left = 187
      Top = 28
      Width = 75
      Height = 22
      Caption = '%nsecond'
      TabOrder = 9
      OnClick = Button1Click
    end
    object Button8: TButton
      Left = 280
      Top = 28
      Width = 75
      Height = 22
      Caption = '%sgenre'
      TabOrder = 10
      OnClick = Button1Click
    end
    object Button12: TButton
      Left = 368
      Top = 28
      Width = 75
      Height = 22
      Caption = '%strack'
      TabOrder = 11
      OnClick = Button1Click
    end
  end
end
