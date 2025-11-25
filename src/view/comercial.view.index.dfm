object frmIndex: TfrmIndex
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'M'#243'dulo Comercial'
  ClientHeight = 143
  ClientWidth = 402
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Position = poScreenCenter
  TextHeight = 13
  object ButtonClientes: TButton
    Left = 120
    Top = 24
    Width = 137
    Height = 25
    Caption = 'Clientes'
    TabOrder = 0
    OnClick = ButtonClientesClick
  end
  object ButtonProdutos: TButton
    Left = 120
    Top = 55
    Width = 137
    Height = 25
    Caption = 'Produtos'
    TabOrder = 1
    OnClick = ButtonProdutosClick
  end
  object ButtonPedidos: TButton
    Left = 120
    Top = 86
    Width = 137
    Height = 25
    Caption = 'Pedido'
    TabOrder = 2
    OnClick = ButtonPedidosClick
  end
end
