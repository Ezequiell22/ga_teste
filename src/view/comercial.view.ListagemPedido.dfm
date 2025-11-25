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
  OnShow = FormShow
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 56
    Width = 783
    Height = 264
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnNovo: TButton
    Left = 692
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 1
    OnClick = btnNovoClick
  end
  object btnExcluir: TButton
    Left = 533
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 2
  end
  object DataSource1: TDataSource
    Left = 344
    Top = 152
  end
end
