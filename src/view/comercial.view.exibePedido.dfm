object frmExibePedido: TfrmExibePedido
  Left = 0
  Top = 0
  Caption = 'Visualiza'#231#227'o do pedido'
  ClientHeight = 320
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblidPedido: TLabel
    Left = 24
    Top = 16
    Width = 89
    Height = 15
    Caption = 'Pedido c'#243'digo: 1'
  end
  object lblCliente: TLabel
    Left = 24
    Top = 37
    Width = 143
    Height = 15
    Caption = 'Cliente: Comercio portineri'
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 72
    Width = 783
    Height = 248
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    Left = 344
    Top = 160
  end
end
