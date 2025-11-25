unit comercial.view.ListagemCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, comercial.controller.interfaces;

type
  TfrmListagemCliente = class(TForm)
    Grid: TDBGrid;
    btnNovo: TButton;
    btnExcluir: TButton;
    btnEditar: TButton;
    FDS: TDataSource;
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FController: iController;
  public
    { Public declarations }
  end;

var
  frmListagemCliente: TfrmListagemCliente;

implementation

{$R *.dfm}

uses comercial.view.Cliente, comercial.controller;

procedure TfrmListagemCliente.btnExcluirClick(Sender: TObject);
begin
  FController.business.Cliente.Excluir(FDS.DataSet.FieldByName('IDCLIENTE')
    .AsInteger).Get;

end;

procedure TfrmListagemCliente.btnNovoClick(Sender: TObject);
begin
  with TfrmCliente.Create(self) do
    try
      Caption := 'Novo cliente';
      edtid.ReadOnly := true;
      ShowModal;
    finally
      Free;
    end;
  FController.business.Cliente.Get;
end;

procedure TfrmListagemCliente.btnEditarClick(Sender: TObject);
begin
  with TfrmCliente.Create(self) do
    try
      Caption := 'Editar cliente';
      edtid.text := FDS.DataSet.FieldByName('IDCLIENTE').asString;
      edtid.ReadOnly := true;
      ShowModal;
    finally
      Free;
    end;
  FController.business.Cliente.Get;
end;

procedure TfrmListagemCliente.FormShow(Sender: TObject);
begin
  FController := TController.New;
  Grid.DataSource := FDS;
  FController.business.Cliente.Bind(FDS).Get;
end;

end.
