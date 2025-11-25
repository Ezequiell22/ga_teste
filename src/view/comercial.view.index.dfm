object frmIndex: TfrmIndex
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'M'#243'dulo Comercial'
  ClientHeight = 148
  ClientWidth = 400
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  Position = poScreenCenter
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 129
    Width = 400
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 157
    ExplicitWidth = 459
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 24
    object MenuCadastros: TMenuItem
      Caption = 'Cadastros'
      object MenuClientes: TMenuItem
        Caption = 'Clientes'
        OnClick = MenuClientesClick
      end
      object MenuProdutos: TMenuItem
        Caption = 'Produtos'
        OnClick = MenuProdutosClick
      end
    end
    object MenuPedidos: TMenuItem
      Caption = 'Pedidos'
      OnClick = MenuPedidosClick
    end
    object MenuRelatorio: TMenuItem
      Caption = 'Relatorio Top Produtos'
    end
  end
end
