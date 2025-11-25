object frmListagemPedido: TfrmListagemPedido
  Left = 0
  Top = 0
  Caption = 'Listagem Pedidos'
  ClientHeight = 320
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 64
    Width = 783
    Height = 256
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnNovo: TButton
    Left = 539
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 1
  end
  object btnEditar: TButton
    Left = 620
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 2
  end
  object btnExcluir: TButton
    Left = 701
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 3
  end
end
