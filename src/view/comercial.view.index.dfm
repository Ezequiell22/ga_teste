object frmIndex: TfrmIndex
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'M'#243'dulo Comercial'
  ClientHeight = 176
  ClientWidth = 459
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 157
    Width = 459
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
    ExplicitTop = 630
    ExplicitWidth = 1322
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 32
    object MenuCadastros: TMenuItem
      Caption = 'Cadastros'
      object MenuClientes: TMenuItem
        Caption = 'Clientes'
        OnClick = MenuClientesClick
      end
      object MenuProdutos: TMenuItem
        Caption = 'Produtos'
      end
    end
    object MenuPedidos: TMenuItem
      Caption = 'Pedidos'
    end
    object MenuRelatorio: TMenuItem
      Caption = 'Relatorio Top Produtos'
    end
  end
end
