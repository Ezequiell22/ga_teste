unit comercial.view.ListagemCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, comercial.controller.interfaces;

type
  TfrmListagemCliente = class(TForm)
    btnNovo: TButton;
    btnExcluir: TButton;
    btnEditar: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
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
  FController.business.Cliente.Excluir(DataSource1.DataSet.FieldByName('IDCLIENTE')
    .AsInteger).Get;

end;

procedure TfrmListagemCliente.btnNovoClick(Sender: TObject);
var frm : TfrmCliente;
begin
  frm := TfrmCliente.Create(self);

  try
    frm.Caption := 'Novo cliente';
    frm.edtid.text := '';
    frm.edtid.ReadOnly := true;
    frm.ShowModal;
  finally
    frm.Free;
  end;

  FController.business.Cliente.Get;
end;

procedure TfrmListagemCliente.btnEditarClick(Sender: TObject);
var frm : TfrmCliente;
begin
  frm := TfrmCliente.Create(self);

  try
    frm.Caption := 'Editar cliente';
    frm.edtid.text := datasource1.DataSet.FieldByName('IDCLIENTE').asString;
    frm.edtid.ReadOnly := true;
    frm.ShowModal;
  finally
    frm.Free;
  end;

  FController.business.Cliente.Get;
end;

procedure TfrmListagemCliente.FormShow(Sender: TObject);
begin
  FController := TController.New;
  dbgrid1.DataSource := datasource1;
  dbgrid1.Options := dbgrid1.Options - [dgediting];
  FController.business.Cliente.Bind(datasource1).Get;
end;

end.
