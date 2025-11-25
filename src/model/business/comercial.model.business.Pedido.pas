unit comercial.model.business.Pedido;

interface

uses
  comercial.model.business.interfaces,
  comercial.model.resource.Interfaces,
  comercial.model.resource.impl.queryIBX,
  Data.DB;

type
  TModelBusinessPedido = class(TInterfacedObject, iModelBusinessPedido)
  private
    FQuery: iQuery;
    FQueryItens: iQuery;
    FQueryLookup : iQuery;
    FIdPedido: Integer;
    FIdCliente: Integer;
    FTotal: Double;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessPedido;
    function Novo(aIdPedido, aIdCliente: Integer): iModelBusinessPedido;
    function Get: iModelBusinessPedido;
    function Abrir(aIdPedido: Integer): iModelBusinessPedido;
    function AdicionarItem(aIdProduto: Integer; aDescricao: string; aValor: Double; aQuantidade: Double): iModelBusinessPedido;
    function Finalizar: iModelBusinessPedido;
    function LinkDataSourcePedido(aDataSource: TDataSource): iModelBusinessPedido;
    function LinkDataSourceItens(aDataSource: TDataSource): iModelBusinessPedido;
  end;

implementation

uses System.SysUtils;

constructor TModelBusinessPedido.Create;
begin
  FQuery := TModelResourceQueryIBX.New();
  FQueryItens := TModelResourceQueryIBX.New();
  FQueryLookup := TModelResourceQueryIBX.New();
end;

function TModelBusinessPedido.Abrir(aIdPedido: Integer): iModelBusinessPedido;
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
//  FQueryRead.active(False)
//    .sqlClear
//    .sqlAdd('select * from CLIENTE')
//    .Open;
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

function TModelBusinessPedido.Novo(aIdPedido, aIdCliente: Integer): iModelBusinessPedido;
begin
  Result := Self;
  FIdPedido := aIdPedido;
  FIdCliente := aIdCliente;
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

function TModelBusinessPedido.AdicionarItem(aIdProduto: Integer; aDescricao: string; aValor: Double; aQuantidade: Double): iModelBusinessPedido;
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
        .addParam('IDPRODUTO', aIdProduto)
        .Open;
      if not FQueryLookup.DataSet.IsEmpty then
        VUnit := FQueryLookup.DataSet.FieldByName('PRECO').AsFloat;
    end;

    VTotalItem := VUnit * aQuantidade;
    FTotal := FTotal + VTotalItem;

    FQueryItens.active(False)
      .sqlClear
      .sqlAdd('insert into PEDIDO_ITENS (IDPEDIDO, SEQUENCIA, IDPRODUTO, DESCRICAO, VALOR_UNITARIO, QUANTIDADE, VALOR_TOTAL_ITEM)')
      .sqlAdd('values (:IDPEDIDO, (select coalesce(max(SEQUENCIA),0)+1 from PEDIDO_ITENS where IDPEDIDO = :IDPED), :IDPRODUTO, :DESCRICAO, :VALOR_UNITARIO, :QUANTIDADE, :VALOR_TOTAL_ITEM)')
      .addParam('IDPEDIDO', FIdPedido)
      .addParam('IDPED', FIdPedido)
      .addParam('IDPRODUTO', aIdProduto)
      .addParam('DESCRICAO', aDescricao)
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
