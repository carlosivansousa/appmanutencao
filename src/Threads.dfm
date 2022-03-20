object fThreads: TfThreads
  Left = 0
  Top = 0
  Caption = 'Threads'
  ClientHeight = 311
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 17
    Width = 55
    Height = 13
    Caption = 'Qtd Thread'
  end
  object Label2: TLabel
    Left = 200
    Top = 17
    Width = 98
    Height = 13
    Caption = 'Tempo (milisegundo)'
  end
  object EdNumThread: TEdit
    Left = 24
    Top = 36
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '2'
  end
  object MemTherad: TMemo
    Left = 24
    Top = 86
    Width = 601
    Height = 89
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object btExecuta: TButton
    Left = 24
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 2
    OnClick = btExecutaClick
  end
  object edTempo: TEdit
    Left = 200
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '11'
  end
  object ProgressBar: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 291
    Width = 637
    Height = 17
    Align = alBottom
    TabOrder = 4
  end
  object Button1: TButton
    Left = 550
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 5
    OnClick = Button1Click
  end
end
