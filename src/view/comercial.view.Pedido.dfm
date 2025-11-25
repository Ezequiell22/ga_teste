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
  TextHeight = 13
  object btnFinalizar: TButton
    Left = 790
    Top = 451
    Width = 75
    Height = 25
    Caption = 'Finalizar'
    TabOrder = 0
    OnClick = BtnFinalizarClick
  end
  object btnImprimir: TButton
    Left = 709
    Top = 451
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 1
    OnClick = BtnImprimirClick
  end
  object GridItens: TDBGrid
    Left = 0
    Top = 197
    Width = 900
    Height = 248
    Align = alTop
    DataSource = DSItens
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 61
    Width = 900
    Height = 63
    Align = alTop
    Caption = 'Cliente'
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 67
    ExplicitWidth = 836
    object Label7: TLabel
      Left = 3
      Top = 10
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object Label8: TLabel
      Left = 89
      Top = 10
      Width = 59
      Height = 13
      Caption = 'Raz'#227'o social'
    end
    object edtIdCliente: TEdit
      Left = 3
      Top = 29
      Width = 80
      Height = 21
      TabOrder = 0
    end
    object ComboBoxCliente: TComboBox
      Left = 89
      Top = 29
      Width = 643
      Height = 21
      TabOrder = 1
      OnChange = ComboBoxClienteChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 124
    Width = 900
    Height = 73
    Align = alTop
    Caption = 'Produto'
    TabOrder = 4
    ExplicitLeft = 8
    ExplicitTop = 136
    ExplicitWidth = 841
    object Label3: TLabel
      Left = 3
      Top = 17
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object Label4: TLabel
      Left = 89
      Top = 17
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label2: TLabel
      Left = 335
      Top = 17
      Width = 29
      Height = 13
      Caption = 'Marca'
    end
    object Label5: TLabel
      Left = 523
      Top = 17
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label6: TLabel
      Left = 609
      Top = 17
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object edtIdProduto: TEdit
      Left = 3
      Top = 36
      Width = 80
      Height = 21
      TabOrder = 0
    end
    object ComboBoxProduto: TComboBox
      Left = 89
      Top = 36
      Width = 240
      Height = 21
      TabOrder = 1
      OnChange = ComboBoxProdutoChange
    end
    object edtDescricao: TEdit
      Left = 89
      Top = 36
      Width = 240
      Height = 21
      TabOrder = 6
    end
    object edtValor: TEdit
      Left = 523
      Top = 36
      Width = 80
      Height = 21
      TabOrder = 2
    end
    object edtQuantidade: TEdit
      Left = 609
      Top = 36
      Width = 80
      Height = 21
      TabOrder = 3
    end
    object btnAddItem: TButton
      Left = 695
      Top = 32
      Width = 100
      Height = 25
      Caption = 'Adicionar Item'
      TabOrder = 5
      OnClick = BtnAddItemClick
    end
    object edtMarca: TEdit
      Left = 335
      Top = 36
      Width = 179
      Height = 21
      TabOrder = 4
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 61
    Align = alTop
    TabOrder = 5
    object Label1: TLabel
      Left = 3
      Top = 8
      Width = 68
      Height = 13
      Caption = 'C'#243'digo pedido'
    end
    object edtIdPedido: TEdit
      Left = 3
      Top = 27
      Width = 80
      Height = 21
      TabOrder = 0
      OnExit = edtIdPedidoExit
    end
  end
  object DSPedido: TDataSource
    Left = 16
    Top = 560
  end
  object DSItens: TDataSource
    Left = 96
    Top = 560
  end
  object DSClientes: TDataSource
    Left = 176
    Top = 560
  end
  object DSProdutos: TDataSource
    Left = 256
    Top = 560
  end
end
