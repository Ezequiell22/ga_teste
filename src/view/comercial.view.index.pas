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
    ButtonClientes: TButton;
    ButtonProdutos: TButton;
    ButtonPedidos: TButton;
    procedure ButtonProdutosClick(Sender: TObject);
    procedure ButtonClientesClick(Sender: TObject);
    procedure ButtonPedidosClick(Sender: TObject);

  private
    Fcontroller: iController;
  public
  end;

var
  frmIndex: TfrmIndex;

implementation

{$R *.dfm}

uses
  System.UITypes,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  comercial.controller,
  comercial.view.Cliente,
  comercial.view.Produto,
  comercial.view.Pedido,
  comercial.view.ListagemCliente,
  comercial.view.ListagemProduto,
  comercial.view.ListagemPedido;

procedure TfrmIndex.ButtonClientesClick(Sender: TObject);
begin
  with TfrmListagemCliente.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmIndex.ButtonPedidosClick(Sender: TObject);
begin
  with TfrmListagemPedido.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmIndex.ButtonProdutosClick(Sender: TObject);
begin
  with TfrmListagemProduto.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

end.
