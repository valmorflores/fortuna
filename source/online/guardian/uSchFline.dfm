object Form1: TForm1
  Left = 372
  Top = 137
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 74
  ClientWidth = 117
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMinimized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Interval = 40000
    OnTimer = Timer1Timer
    Left = 32
    Top = 16
  end
end
