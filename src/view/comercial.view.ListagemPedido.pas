unit comercial.view.ListagemPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, comercial.controller.interfaces;

type
  TfrmListagemPedido = class(TForm)
    DBGrid1: TDBGrid;
    btnNovo: TButton;
    btnExcluir: TButton;
    DataSource1: TDataSource;
    btnImprimir: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
     FController: iController;
  public
    { Public declarations }
  end;

var
  frmListagemPedido: TfrmListagemPedido;

implementation

uses
  comercial.controller, comercial.view.Pedido;

{$R *.dfm}

procedure TfrmListagemPedido.btnNovoClick(Sender: TObject);
var frm : TfrmPedido;
begin
  frm := TfrmPedido.Create(self);

  try
    frm.Caption := 'Novo Pedido';
    frm.edtIdPedido.text := EmptyStr;
    frm.edtIdPedido.ReadOnly := true;
    frm.ShowModal;
  finally
    frm.Free;
  end;

  FController.business.Pedido.Get;
end;

procedure TfrmListagemPedido.FormShow(Sender: TObject);
begin
  FController := TController.New;
  dbgrid1.DataSource := datasource1;
  FController.business.Pedido.LinkDataSourcePedido(datasource1).
    Get;
end;

end.
