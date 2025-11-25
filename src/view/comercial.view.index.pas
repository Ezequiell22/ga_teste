unit comercial.view.index;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  comercial.controller.interfaces;

type
  TfrmIndex = class(Tform)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    MenuCadastros: TMenuItem;
    MenuClientes: TMenuItem;
    MenuProdutos: TMenuItem;
    MenuPedidos: TMenuItem;
    MenuRelatorio: TMenuItem;
    procedure MenuClientesClick(Sender: TObject);
    procedure MenuProdutosClick(Sender: TObject);
    procedure MenuPedidosClick(Sender: TObject);

  private
    Fcontroller: iController;
  public
  end;

var
  frmIndex: TfrmIndex;

implementation

{$R *.dfm}

uses
  System.UITypes, comercial.controller,
  comercial.view.Cliente,
  comercial.view.Produto,
  comercial.view.Pedido,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  comercial.view.ListagemCliente;

procedure TfrmIndex.MenuClientesClick(Sender: TObject);
begin

  with TfrmListagemCliente.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmIndex.MenuPedidosClick(Sender: TObject);
begin
  with TfrmPedido.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmIndex.MenuProdutosClick(Sender: TObject);
begin
  inherited;
  with TfrmProduto.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

end.
