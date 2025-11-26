unit comercial.model.business.Pedido;

interface

uses
  Data.DB, Vcl.StdCtrls,
  comercial.model.business.interfaces,
  comercial.model.resource.Interfaces,
  comercial.model.resource.impl.queryIBX,
  comercial.model.DAO.interfaces,
  comercial.model.entity.Cliente;

type
  TModelBusinessPedido = class(TInterfacedObject, iModelBusinessPedido)
  private
    FQuery: iQuery;
    FQueryItens: iQuery;
    FQueryLookup : iQuery;
    FIdPedido: Integer;
    FIdCliente: Integer;
    FTotal: Double;
    FIdProduto : integer;
    FDAOCliente: iModelDAOEntity<TModelEntityCliente>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessPedido;
    function Novo : iModelBusinessPedido;
    function Get: iModelBusinessPedido;
    function Abrir(aIdPedido: Integer;
    AcomboBoxcliente : TComboBox): iModelBusinessPedido;
    function AdicionarItem(aValor: Double; aQuantidade: Double): iModelBusinessPedido;
    function Finalizar: iModelBusinessPedido;
    function LinkDataSourcePedido(aDataSource: TDataSource): iModelBusinessPedido;
    function LinkDataSourceItens(aDataSource: TDataSource): iModelBusinessPedido;
    function setIdproduto(aValue : integer) : iModelBusinessPedido;
    function setIdCliente(aValue : integer) : iModelBusinessPedido;
  end;

implementation

uses System.SysUtils, comercial.model.DAO.Cliente;

constructor TModelBusinessPedido.Create;
begin
  FQuery := TModelResourceQueryIBX.New();
  FQueryItens := TModelResourceQueryIBX.New();
  FQueryLookup := TModelResourceQueryIBX.New();
end;

function TModelBusinessPedido.Abrir(aIdPedido: Integer;
  AcomboBoxcliente : TComboBox): iModelBusinessPedido;
begin
  Result := Self;
  FIdPedido := aIdPedido;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select p.IDPEDIDO, p.IDCLIENTE, p.DTEMISSAO, p.VALOR_TOTAL, c.NM_FANTASIA')
      .sqlAdd('from PEDIDO p')
      .sqlAdd('join CLIENTE c on c.IDCLIENTE = p.IDCLIENTE')
      .sqlAdd('where p.IDPEDIDO = :IDPEDIDO')
      .addParam('IDPEDIDO', FIdPedido)
      .Open;

    FQueryItens.active(False)
      .sqlClear
      .sqlAdd('select * from PEDIDO_ITENS where IDPEDIDO = :IDPEDIDO order by SEQUENCIA')
      .addParam('IDPEDIDO', FIdPedido)
      .Open;

    FIdCliente := FQuery.DataSet.FieldByName('IDCLIENTE').AsInteger;

    // coloca somente o cliente do pedido
    FDAOCliente:= TmodelDAOCliente.new;
    FDAOCliente.GetbyId(FIdCliente);

    AcomboBoxcliente.Items.Clear;
    AcomboBoxcliente.Items.Add(FDAOCliente.GetDataSet
      .FieldByName('NM_FANTASIA').AsString);

    AcomboBoxcliente.ItemIndex := 0;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TModelBusinessPedido.Destroy;
begin
  inherited;
end;

function TModelBusinessPedido.Finalizar: iModelBusinessPedido;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select SUM(VALOR_TOTAL_ITEM) vl from pedido_itens')
      .sqlAdd('where idpedido = :idpedido')
      .addParam('idpedido', FIdPedido)
      .open;

    FTotal := Fquery.DataSet.FieldByName('vl').AsFloat;

    FQuery.active(False)
      .sqlClear
      .sqlAdd('update PEDIDO set VALOR_TOTAL = :VALOR_TOTAL where IDPEDIDO = :IDPEDIDO')
      .addParam('VALOR_TOTAL', FTotal)
      .addParam('IDPEDIDO', FIdPedido)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelBusinessPedido.Get: iModelBusinessPedido;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('select * from Pedido')
    .Open;
end;

function TModelBusinessPedido.LinkDataSourceItens(aDataSource: TDataSource): iModelBusinessPedido;
begin
  Result := Self;
  aDataSource.DataSet := FQueryItens.DataSet;
end;

function TModelBusinessPedido.LinkDataSourcePedido(aDataSource: TDataSource): iModelBusinessPedido;
begin
  Result := Self;
  aDataSource.DataSet := FQuery.DataSet;
end;

class function TModelBusinessPedido.New: iModelBusinessPedido;
begin
  Result := Self.Create;
end;

function TModelBusinessPedido.Novo: iModelBusinessPedido;
begin
  Result := Self;

  FQuery.active(False)
      .sqlClear
      .sqlAdd('select (coalesce(max(IDPEDIDO),0)+1) idn from PEDIDO')
      .open;


  FIdPedido := FQuery.DataSet.FieldByName('idn').AsInteger;

  if (FIdPedido <= 0) then
      raise Exception.Create('Não foi possível criar o pedido');

  if (FIdCliente <= 0)then
      raise Exception.Create('Selecione um cliente');

  FTotal := 0;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('insert into PEDIDO (IDPEDIDO, IDCLIENTE, DTEMISSAO, VALOR_TOTAL)')
      .sqlAdd('values (:IDPEDIDO, :IDCLIENTE, :DTEMISSAO, :VALOR_TOTAL)')
      .addParam('IDPEDIDO', FIdPedido)
      .addParam('IDCLIENTE', FIdCliente)
      .addParam('DTEMISSAO', Now)
      .addParam('VALOR_TOTAL', FTotal)
      .execSql;

    FQuery.active(False)
      .sqlClear
      .sqlAdd('select p.IDPEDIDO, p.IDCLIENTE, p.DTEMISSAO, p.VALOR_TOTAL, c.NM_FANTASIA')
      .sqlAdd('from PEDIDO p')
      .sqlAdd('join CLIENTE c on c.IDCLIENTE = p.IDCLIENTE')
      .sqlAdd('where p.IDPEDIDO = :IDPEDIDO')
      .addParam('IDPEDIDO', FIdPedido)
      .Open;

    FQueryItens.active(False)
      .sqlClear
      .sqlAdd('select * from PEDIDO_ITENS where IDPEDIDO = :IDPEDIDO order by SEQUENCIA')
      .addParam('IDPEDIDO', FIdPedido)
      .Open;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelBusinessPedido.setIdCliente(
  aValue: integer): iModelBusinessPedido;
begin
  result := Self;
  FIdCliente := aValue
end;

function TModelBusinessPedido.setIdproduto(
  aValue: integer): iModelBusinessPedido;
begin
 result := Self;
 FIdProduto := aValue;
end;

function TModelBusinessPedido.AdicionarItem(
    aValor: Double; aQuantidade: Double): iModelBusinessPedido;
var
  VUnit: Double;
  VTotalItem: Double;
begin
  Result := Self;
  try
    VUnit := aValor;
    if VUnit <= 0 then
    begin
      FQueryLookup.active(False)
        .sqlClear
        .sqlAdd('select PRECO from PRODUTO where IDPRODUTO = :IDPRODUTO')
        .addParam('IDPRODUTO', FIdProduto)
        .Open;
      if not FQueryLookup.DataSet.IsEmpty then
        VUnit := FQueryLookup.DataSet.FieldByName('PRECO').AsFloat;
    end;

    VTotalItem := VUnit * aQuantidade;
    FTotal := FTotal + VTotalItem;

    FQueryItens.active(False)
      .sqlClear
      .sqlAdd('insert into PEDIDO_ITENS (IDPEDIDO, SEQUENCIA,')
      .sqlAdd('IDPRODUTO, VALOR_UNITARIO, QUANTIDADE, VALOR_TOTAL_ITEM)')
      .sqlAdd('values (:IDPEDIDO, (select coalesce(max(SEQUENCIA),0)+1 from PEDIDO_ITENS where IDPEDIDO = :IDPEDIDO),')
      .sqlAdd(' :IDPRODUTO, :VALOR_UNITARIO, :QUANTIDADE, :VALOR_TOTAL_ITEM)')
      .addParam('IDPEDIDO', FIdPedido)
      .addParam('IDPRODUTO', FIdProduto)
      .addParam('VALOR_UNITARIO', VUnit)
      .addParam('QUANTIDADE', aQuantidade)
      .addParam('VALOR_TOTAL_ITEM', VTotalItem)
      .execSql;

    FQueryItens.active(False)
      .sqlClear
      .sqlAdd('select * from PEDIDO_ITENS where IDPEDIDO = :IDPEDIDO order by SEQUENCIA')
      .addParam('IDPEDIDO', FIdPedido)
      .Open;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
