unit comercial.view.Pedido;

interface

uses System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.DBGrids,
  Data.DB,
  comercial.controller,
  comercial.controller.interfaces, Vcl.Controls, Vcl.Grids, Vcl.ExtCtrls,
  comercial.view.exibePedido;

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
    btnNovo: TButton;
    procedure BtnAddItemClick(Sender: TObject);
    procedure BtnFinalizarClick(Sender: TObject);
    procedure ComboBoxClienteSelect(Sender: TObject);
    procedure ComboBoxProdutoSelect(Sender: TObject);
    procedure edtIdPedidoExit(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    FController: iController;
    function ValidatePedidoItem: Boolean;
    function ValidatePedidoCab: Boolean;
    procedure LoadComboboxCliente;
    procedure LoadComboBoxProduto;
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

  FController.business.Pedido
    .LinkDataSourcePedido(DSPedido)
    .LinkDataSourceItens(DSItens);

  LoadComboboxCliente;
  LoadComboBoxProduto;

end;

destructor TfrmPedido.Destroy;
begin
  inherited;
end;

procedure TfrmPedido.edtIdPedidoExit(Sender: TObject);
begin

  FController.business.Pedido.Abrir(strTointDef(edtIdPedido.Text, 0),
    comboboxcliente)

end;

procedure TfrmPedido.LoadComboboxCliente;
begin
  FController.business.Cliente.Bind(DSClientes).Get;
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
end;

procedure TfrmPedido.LoadComboBoxProduto;
begin
  FController.business.Produto.Bind(DSProdutos).Get;
  TComboBox(FindComponent('ComboBoxProduto')).Items.Clear;
  if Assigned(DSProdutos.DataSet) then
  begin
    DSProdutos.DataSet.First;
    while not DSProdutos.DataSet.Eof do
    begin
      TComboBox(FindComponent('ComboBoxProduto'))
        .Items.Add(DSProdutos.DataSet.FieldByName('DESCRICAO').AsString);
      DSProdutos.DataSet.Next;
    end;

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
  if Trim(ComboBoxCliente.Text) = EmptyStr then
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
  if not ValidatePedidoItem then
    Exit;
  FController.business.Pedido
    .AdicionarItem(
          StrToFloatDef(edtValor.Text, 0),
          StrToFloatDef(edtQuantidade.Text, 0));
end;

procedure TfrmPedido.BtnFinalizarClick(Sender: TObject);
begin
  if not ValidatePedidoCab then
    Exit;
  FController.business.Pedido.Finalizar;

  if MessageDlg('Deseja imprimir o pedido?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin

    with TfrmExibePedido.Create(self) do
    try
      ShowModal;
    finally
      Free;
    end;

  end
end;

procedure TfrmPedido.btnNovoClick(Sender: TObject);
begin
   FController.business
    .Pedido.novo;
end;

procedure TfrmPedido.ComboBoxClienteSelect(Sender: TObject);
begin
  if Assigned(DSClientes.DataSet) then
  begin
    FController.business.Pedido.
      setIdCliente(
        DSClientes.DataSet.FieldByName('IDCLIENTE').AsInteger);
  end;
end;

procedure TfrmPedido.ComboBoxProdutoSelect(Sender: TObject);
begin
   if Assigned(DSProdutos.DataSet) then
  begin
    FController.business.Pedido.
      setIdProduto(
        DSProdutos.DataSet.FieldByName('idProduto').AsInteger);
    edtValor.Text := DSProdutos.DataSet.FieldByName('PRECO').AsString;
  end;
end;

end.
