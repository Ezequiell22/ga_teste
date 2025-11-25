object frmListagemCliente: TfrmListagemCliente
  Left = 0
  Top = 0
  Caption = 'Listagem de clientes'
  ClientHeight = 249
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Grid: TDBGrid
    Left = 0
    Top = 49
    Width = 624
    Height = 200
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnNovo: TButton
    Left = 379
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 1
    OnClick = btnNovoClick
  end
  object btnExcluir: TButton
    Left = 541
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 2
    OnClick = btnExcluirClick
  end
  object btnEditar: TButton
    Left = 460
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 3
    OnClick = btnEditarClick
  end
  object FDS: TDataSource
    Left = 392
    Top = 176
  end
end
