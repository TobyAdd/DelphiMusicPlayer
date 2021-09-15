object Form1: TForm1
  Left = 192
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1083#1077#1077#1088
  ClientHeight = 304
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object NameTrackLbl: TLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object TimeLbl: TLabel
    Left = 8
    Top = 32
    Width = 21
    Height = 13
    Caption = '0:00'
  end
  object ScrollBar1: TScrollBar
    Left = 8
    Top = 96
    Width = 233
    Height = 13
    PageSize = 0
    TabOrder = 0
    OnScroll = ScrollBar1Scroll
  end
  object VolumeSB: TScrollBar
    Left = 152
    Top = 32
    Width = 89
    Height = 13
    PageSize = 0
    TabOrder = 1
    OnChange = VolumeSBChange
  end
  object ListBox1: TListBox
    Left = 8
    Top = 120
    Width = 233
    Height = 145
    ItemHeight = 13
    TabOrder = 2
    OnClick = ListBox1Click
  end
  object Button1: TButton
    Left = 104
    Top = 56
    Width = 41
    Height = 25
    Caption = '[>'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 56
    Top = 56
    Width = 41
    Height = 25
    Caption = '[ ]'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 56
    Width = 41
    Height = 25
    Caption = '<<'
    TabOrder = 5
    OnClick = Button3Click
  end
  object NextTrackBtn: TButton
    Left = 200
    Top = 56
    Width = 41
    Height = 25
    Caption = '>>'
    TabOrder = 6
    OnClick = NextTrackBtnClick
  end
  object Button5: TButton
    Left = 168
    Top = 272
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button4: TButton
    Left = 152
    Top = 56
    Width = 41
    Height = 25
    Caption = '| |'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button6: TButton
    Left = 8
    Top = 272
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 9
    OnClick = Button6Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 16
    Top = 128
  end
  object XPManifest1: TXPManifest
    Left = 48
    Top = 128
  end
  object OpenDialog1: TOpenDialog
    Filter = 'MP3 '#1092#1072#1081#1083#1099'|*.mp3|WAV '#1092#1072#1081#1083#1099'|*.wav'
    Left = 88
    Top = 128
  end
end
