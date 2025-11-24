object frmProduto: TfrmProduto
  Left = 0
  Top = 0
  Caption = 'Produtos'
  ClientHeight = 471
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object edtId: TEdit
    Left = 8
    Top = 8
    Width = 80
    Height = 21
    TabOrder = 0
  end
  object edtDescricao: TEdit
    Left = 96
    Top = 8
    Width = 300
    Height = 21
    TabOrder = 1
  end
  object edtMarca: TEdit
    Left = 400
    Top = 8
    Width = 180
    Height = 21
    TabOrder = 2
  end
  object edtPreco: TEdit
    Left = 586
    Top = 8
    Width = 100
    Height = 21
    TabOrder = 3
  end
  object btnNovo: TButton
    Left = 8
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 4
    OnClick = BtnNovoClick
  end
  object btnSalvar: TButton
    Left = 88
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 5
    OnClick = BtnSalvarClick
  end
  object btnEditar: TButton
    Left = 168
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 6
    OnClick = BtnEditarClick
  end
  object btnExcluir: TButton
    Left = 248
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 7
    OnClick = BtnExcluirClick
  end
  object Grid: TDBGrid
    Left = 0
    Top = 71
    Width = 800
    Height = 400
    Align = alBottom
    DataSource = FDS
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDS: TDataSource
    Left = 16
    Top = 560
  end
end
