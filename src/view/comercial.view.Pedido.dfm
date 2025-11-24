object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 600
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  object DSPedido: TDataSource
    Left = 16
    Top = 560
  end
  object DSItens: TDataSource
    Left = 96
    Top = 560
  end
  object edtIdPedido: TEdit
    Left = 8
    Top = 8
    Width = 80
    Height = 21
    TabOrder = 0
  end
  object edtIdCliente: TEdit
    Left = 96
    Top = 8
    Width = 80
    Height = 21
    TabOrder = 1
  end
  object btnNovo: TButton
    Left = 184
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 2
    OnClick = BtnNovoClick
  end
  object btnSelecionarCliente: TButton
    Left = 264
    Top = 8
    Width = 140
    Height = 25
    Caption = 'Selecionar Cliente'
    TabOrder = 11
    OnClick = BtnSelecionarClienteClick
  end
  object edtIdProduto: TEdit
    Left = 8
    Top = 40
    Width = 80
    Height = 21
    TabOrder = 3
  end
  object edtDescricao: TEdit
    Left = 96
    Top = 40
    Width = 240
    Height = 21
    TabOrder = 4
  end
  object edtValor: TEdit
    Left = 340
    Top = 40
    Width = 80
    Height = 21
    TabOrder = 5
  end
  object edtQuantidade: TEdit
    Left = 424
    Top = 40
    Width = 80
    Height = 21
    TabOrder = 6
  end
  object btnAddItem: TButton
    Left = 508
    Top = 40
    Width = 100
    Height = 25
    Caption = 'Adicionar Item'
    TabOrder = 7
    OnClick = BtnAddItemClick
  end
  object btnFinalizar: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Finalizar'
    TabOrder = 8
    OnClick = BtnFinalizarClick
  end
  object btnImprimir: TButton
    Left = 96
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 9
    OnClick = BtnImprimirClick
  end
  object GridItens: TDBGrid
    Left = 0
    Top = 180
    Width = 900
    Height = 420
    Align = alBottom
    DataSource = DSItens
    TabOrder = 10
  end
end
