unit comercial.view.Pedido;

interface

uses System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.DBGrids, Data.DB,
  comercial.controller,
  comercial.controller.interfaces, Vcl.Controls, Vcl.Grids, Vcl.ExtCtrls;

type
  TfrmPedido = class(TForm)
    GroupBox1: TGroupBox;
    edtIdCliente: TEdit;
    ComboBoxCliente: TComboBox;
    GroupBox2: TGroupBox;
    edtIdProduto: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtDescricao: TEdit;
    edtValor: TEdit;
    edtQuantidade: TEdit;
    btnAddItem: TButton;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtMarca: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    edtIdPedido: TEdit;
    Label1: TLabel;
    procedure edtIdPedidoExit(Sender: TObject);
  published
    FController: iController;
    DSPedido: TDataSource;
    DSItens: TDataSource;
    btnFinalizar: TButton;
    btnImprimir: TButton;
    GridItens: TDBGrid;
    procedure BtnNovoClick(Sender: TObject);

    procedure BtnAddItemClick(Sender: TObject);
    procedure BtnFinalizarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
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
  FController.business.Pedido.LinkDataSourcePedido(DSPedido).LinkDataSourceItens(DSItens);
end;

destructor TfrmPedido.Destroy;
begin
  inherited;
end;

procedure TfrmPedido.edtIdPedidoExit(Sender: TObject);
begin
  if not ValidatePedidoCab(Self) then Exit;
  FController.business.Pedido.Novo(StrToIntDef(edtIdPedido.Text, 0), StrToIntDef(edtIdCliente.Text, 0));
end;

function ValidatePedidoCab(AOwner: TfrmPedido): Boolean;
begin
  Result := False;
  if StrToIntDef(AOwner.edtIdPedido.Text, 0) <= 0 then begin ShowMessage('ID Pedido invalido'); Exit; end;
  if StrToIntDef(AOwner.edtIdCliente.Text, 0) <= 0 then begin ShowMessage('ID Cliente invalido'); Exit; end;
  Result := True;
end;

function ValidatePedidoItem(AOwner: TfrmPedido): Boolean;
var V, Q: Double;
begin
  Result := False;
  if StrToIntDef(AOwner.edtIdProduto.Text, 0) <= 0 then begin ShowMessage('ID Produto invalido'); Exit; end;
  if Trim(AOwner.edtDescricao.Text) = '' then begin ShowMessage('Descricao obrigatoria'); Exit; end;
  V := StrToFloatDef(AOwner.edtValor.Text, -1);
  if V < 0 then begin ShowMessage('Valor deve ser numero maior ou igual a zero'); Exit; end;
  Q := StrToFloatDef(AOwner.edtQuantidade.Text, -1);
  if Q <= 0 then begin ShowMessage('Quantidade deve ser maior que zero'); Exit; end;
  Result := True;
end;

procedure TfrmPedido.BtnNovoClick(Sender: TObject);
begin
 
end;

procedure TfrmPedido.BtnAddItemClick(Sender: TObject);
begin
  if not ValidatePedidoItem(Self) then Exit;
  FController.business.Pedido.AdicionarItem(StrToIntDef(edtIdProduto.Text, 0), edtDescricao.Text, StrToFloatDef(edtValor.Text, 0), StrToFloatDef(edtQuantidade.Text, 0));
end;

procedure TfrmPedido.BtnFinalizarClick(Sender: TObject);
begin
  if not ValidatePedidoCab(Self) then Exit;
  FController.business.Pedido.Finalizar;
end;

procedure TfrmPedido.BtnImprimirClick(Sender: TObject);
var
  L: string;
begin
  L := 'Pedido ' + edtIdPedido.Text;
  if Assigned(DSPedido.DataSet) and not DSPedido.DataSet.IsEmpty then
  begin
    L := L + '  Cliente ' + DSPedido.DataSet.FieldByName('NM_FANTASIA').AsString;
    L := L + '  Emissao ' + DateToStr(DSPedido.DataSet.FieldByName('DTEMISSAO').AsDateTime);
  end
  else
    L := L + '  Cliente ' + edtIdCliente.Text;
  L := L + 'Itens:' + sLineBreak;
  var Total := 0.0;
  if Assigned(DSItens.DataSet) then
  begin
    DSItens.DataSet.DisableControls;
    try
      DSItens.DataSet.First;
      while not DSItens.DataSet.Eof do
      begin
        L := L + Format('%s  Qt:%.3f  Vlr:%.2f  Tot:%.2f',[
          DSItens.DataSet.FieldByName('DESCRICAO').AsString,
          DSItens.DataSet.FieldByName('QUANTIDADE').AsFloat,
          DSItens.DataSet.FieldByName('VALOR_UNITARIO').AsFloat,
          DSItens.DataSet.FieldByName('VALOR_TOTAL_ITEM').AsFloat]) + sLineBreak;
        Total := Total + DSItens.DataSet.FieldByName('VALOR_TOTAL_ITEM').AsFloat;
        DSItens.DataSet.Next;
      end;
    finally
      DSItens.DataSet.EnableControls;
    end;
  end;
  L := L + sLineBreak + Format('Total do Pedido: %.2f',[Total]);
  ShowMessage(L);
end;

end.
procedure TfrmPedido.BtnSelecionarClienteClick(Sender: TObject);
var frm: TForm; ds: TDataSource; grid: TDBGrid;
begin
  frm := TForm.Create(Self);
  try
    frm.Caption := 'Selecionar Cliente'; frm.Width := 600; frm.Height := 400; frm.Position := poScreenCenter;
    ds := TDataSource.Create(frm);
    grid := TDBGrid.Create(frm); grid.Parent := frm; grid.Align := alClient; grid.DataSource := ds;
    FController.entity.cadCliente.Bind(ds).Get;
    grid.OnDblClick := procedure(Sender: TObject)
    begin
      if Assigned(ds.DataSet) and not ds.DataSet.IsEmpty then
      begin
        edtIdCliente.Text := ds.DataSet.FieldByName('IDCLIENTE').AsString;
        frm.ModalResult := mrOk;
      end;
    end;
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;
