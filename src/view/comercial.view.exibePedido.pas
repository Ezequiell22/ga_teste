unit comercial.view.exibePedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, comercial.controller.interfaces;

type
  TfrmExibePedido = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    lblidPedido: TLabel;
    lblCliente: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
     FController: iController;
  public
    { Public declarations }
  end;

var
  frmExibePedido: TfrmExibePedido;

implementation

uses
  comercial.controller, comercial.view.Pedido;

{$R *.dfm}

procedure TfrmExibePedido.btnNovoClick(Sender: TObject);
begin;
end;

procedure TfrmExibePedido.FormShow(Sender: TObject);
begin
  FController := TController.New;
  dbgrid1.DataSource := datasource1;

end;

end.
