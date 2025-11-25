unit comercial.view.Pedido;

interface

uses System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.DBGrids,
  Data.DB,
  comercial.controller,
  comercial.controller.interfaces, Vcl.Controls, Vcl.Grids, Vcl.ExtCtrls;

type
  TfrmPedido = class(TForm)
    GroupBox2: TGroupBox;
    Label4: TLabel;
    edtValor: TEdit;
    edtQuantidade: TEdit;
    btnAddItem: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    edtIdPedido: TEdit;
    Label1: TLabel;

    DSPedido: TDataSource;
    DSItens: TDataSource;
    DSClientes: TDataSource;
    DSProdutos: TDataSource;
    btnFinalizar: TButton;
    GridItens: TDBGrid;
    Label8: TLabel;
    ComboBoxCliente: TComboBox;
    ComboBoxProduto: TComboBox;

    procedure edtIdPedidoExit(Sender: TObject);
    procedure BtnAddItemClick(Sender: TObject);
    procedure BtnFinalizarClick(Sender: TObject);
    procedure ComboBoxClienteChange(Sender: TObject);
    procedure ComboBoxProdutoChange(Sender: TObject);
  private
    FController: iController;
    function ValidatePedidoItem : Boolean;
    function ValidatePedidoCab: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  Vcl.Dialogs;

{$R *.dfm}

constructor TfrmPedido.Create(AOwner: TComponent);
begin
  inherited;
  FController := TController.New;
  FController.business.Pedido.LinkDataSourcePedido(DSPedido)
    .LinkDataSourceItens(DSItens);
  DSClientes.DataSet := nil;
  DSProdutos.DataSet := nil;
  FController.business.Cliente.Bind(DSClientes).Get;
  FController.business.Produto.Bind(DSProdutos).Get;
  ComboBoxCliente.Items.Clear;
  if Assigned(DSClientes.DataSet) then
  begin
    DSClientes.DataSet.First;
    while not DSClientes.DataSet.Eof do
    begin
      ComboBoxCliente.Items.Add(DSClientes.DataSet.FieldByName('NM_FANTASIA')
        .AsString);
      DSClientes.DataSet.Next;
    end;
  end;
  if Assigned(DSProdutos.DataSet) then
  begin
    if FindComponent('ComboBoxProduto') = nil then
    begin
      // no-op
    end
    else
    begin
      TComboBox(FindComponent('ComboBoxProduto')).Items.Clear;
      DSProdutos.DataSet.First;
      while not DSProdutos.DataSet.Eof do
      begin
        TComboBox(FindComponent('ComboBoxProduto'))
          .Items.Add(DSProdutos.DataSet.FieldByName('DESCRICAO').AsString);
        DSProdutos.DataSet.Next;
      end;
    end;
  end;
end;

destructor TfrmPedido.Destroy;
begin
  inherited;
end;

procedure TfrmPedido.edtIdPedidoExit(Sender: TObject);
var
  id: Integer;
begin
  id := StrToIntDef(edtIdPedido.Text, 0);
  if id <= 0 then
    Exit;
  FController.business.Pedido.Abrir(id);
  if (DSPedido.DataSet = nil) or DSPedido.DataSet.IsEmpty then
  begin
    ShowMessage('Pedido não encontrado. Selecione o cliente e clique em Novo.');
    Exit;
  end;
end;

function TfrmPedido.ValidatePedidoCab: Boolean;
begin
  Result := False;
  if StrToIntDef(edtIdPedido.Text, 0) <= 0 then
  begin
    ShowMessage('ID Pedido invalido');
    Exit;
  end;
  if Trim(ComboBoxCliente.Text) = EmptyStr  then
  begin
    ShowMessage('ID Cliente invalido');
    Exit;
  end;
  Result := True;
end;

function TfrmPedido.ValidatePedidoItem: Boolean;
var
  V, Q: Double;
begin
  Result := False;
  if Trim(ComboBoxProduto.Text) = EmptyStr then
  begin
    ShowMessage('ID Produto invalido');
    Exit;
  end;

  V := StrToFloatDef(edtValor.Text, -1);
  if V < 0 then
  begin
    ShowMessage('Valor deve ser numero maior ou igual a zero');
    Exit;
  end;
  Q := StrToFloatDef(edtQuantidade.Text, -1);
  if Q <= 0 then
  begin
    ShowMessage('Quantidade deve ser maior que zero');
    Exit;
  end;
  Result := True;
end;

procedure TfrmPedido.BtnAddItemClick(Sender: TObject);
begin
  if not ValidatePedidoItem(Self) then
    Exit;
  FController.business.Pedido.AdicionarItem(StrToIntDef(edtIdProduto.Text, 0),
    edtDescricao.Text, StrToFloatDef(edtValor.Text, 0),
    StrToFloatDef(edtQuantidade.Text, 0));
end;

procedure TfrmPedido.BtnFinalizarClick(Sender: TObject);
begin
  if not ValidatePedidoCab(Self) then
    Exit;
  FController.business.Pedido.Finalizar;
end;

procedure TfrmPedido.ComboBoxClienteChange(Sender: TObject);
begin
  if Assigned(DSClientes.DataSet) then
    if DSClientes.DataSet.Locate('NM_FANTASIA', ComboBoxCliente.Text, []) then
      edtIdCliente.Text := DSClientes.DataSet.FieldByName('IDCLIENTE').AsString;
end;

procedure TfrmPedido.ComboBoxProdutoChange(Sender: TObject);
var
  combo: TComboBox;
begin
  combo := TComboBox(FindComponent('ComboBoxProduto'));
  if (combo <> nil) and Assigned(DSProdutos.DataSet) then
    if DSProdutos.DataSet.Locate('DESCRICAO', combo.Text, []) then
    begin
      edtIdProduto.Text := DSProdutos.DataSet.FieldByName('IDPRODUTO').AsString;
      edtDescricao.Text := DSProdutos.DataSet.FieldByName('DESCRICAO').AsString;
      edtMarca.Text := DSProdutos.DataSet.FieldByName('MARCA').AsString;
      edtValor.Text := DSProdutos.DataSet.FieldByName('PRECO').AsString;
    end;
end;

end.
