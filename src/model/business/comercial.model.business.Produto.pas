unit comercial.model.business.Produto;

interface

uses
  Data.DB,
  comercial.model.business.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

type
  TModelBusinessProduto = class(TInterfacedObject, iModelBusinessProduto)
  private

    FQuery: iQuery;
    FLookup: iQuery;
    FDataSource: TDataSource;
  public
    constructor Create;
    class function New: iModelBusinessProduto;
    function Bind(aDataSource: TDataSource): iModelBusinessProduto;
    function Get: iModelBusinessProduto;
    function GetById(aId: Integer): iModelBusinessProduto;
    function Salvar(aDescricao, aMarca: string; aPreco: Double): iModelBusinessProduto;
    function Editar(aId: Integer; aDescricao, aMarca: string; aPreco: Double): iModelBusinessProduto;
    function Excluir(aId: Integer): iModelBusinessProduto;
  end;

implementation

uses System.SysUtils;

constructor TModelBusinessProduto.Create;
begin
  FQuery := TModelResourceQueryIBX.new;
  FLookup := TModelResourceQueryIBX.new;
end;

class function TModelBusinessProduto.New: iModelBusinessProduto;
begin
  Result := Self.Create();
end;

function TModelBusinessProduto.Bind(aDataSource: TDataSource): iModelBusinessProduto;
begin
  Result := Self;
  FDataSource := aDataSource;
  FDataSource.DataSet := FQuery.DataSet;
end;

function TModelBusinessProduto.Get: iModelBusinessProduto;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('select * from PRODUTO')
    .Open;
end;

function TModelBusinessProduto.GetById(aId: Integer): iModelBusinessProduto;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('select * from PRODUTO where IDPRODUTO = :IDPRODUTO')
    .addParam('IDPRODUTO', aId)
    .Open;
end;

function TModelBusinessProduto.Salvar(aDescricao, aMarca: string; aPreco: Double): iModelBusinessProduto;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('insert into PRODUTO (IDPRODUTO, DESCRICAO, MARCA, PRECO)')
    .sqlAdd('values ((select coalesce(max(IDPRODUTO),0)+1 from PRODUTO), :DESCRICAO, :MARCA, :PRECO)')
    .addParam('DESCRICAO', aDescricao)
    .addParam('MARCA', aMarca)
    .addParam('PRECO', aPreco)
    .execSql(True);
end;

function TModelBusinessProduto.Editar(aId: Integer; aDescricao, aMarca: string; aPreco: Double): iModelBusinessProduto;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('update PRODUTO set DESCRICAO = :DESCRICAO, MARCA = :MARCA, PRECO = :PRECO')
    .sqlAdd('where IDPRODUTO = :IDPRODUTO')
    .addParam('IDPRODUTO', aId)
    .addParam('DESCRICAO', aDescricao)
    .addParam('MARCA', aMarca)
    .addParam('PRECO', aPreco)
    .execSql(True);
end;

function TModelBusinessProduto.Excluir(aId: Integer): iModelBusinessProduto;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('delete from PRODUTO where IDPRODUTO = :IDPRODUTO')
    .addParam('IDPRODUTO', aId)
    .execSql(True);

end;

end.
