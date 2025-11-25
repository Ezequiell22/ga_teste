unit comercial.model.business.Cliente;

interface

uses
  Data.DB,
  comercial.model.business.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

type
  TModelBusinessCliente = class(TInterfacedObject, iModelBusinessCliente)
  private
    FFactory: iQueryFactory;
    FQuery: iQuery;
    FLookup: iQuery;
    FDataSource: TDataSource;
  public
    constructor Create(aFactory: iQueryFactory);
    class function New: iModelBusinessCliente;
    function Bind(aDataSource: TDataSource): iModelBusinessCliente;
    function Get: iModelBusinessCliente;
    function GetById(aId: Integer): iModelBusinessCliente;
    function Salvar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
    function Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
    function Excluir(aId: Integer): iModelBusinessCliente;
  end;

implementation

uses System.SysUtils;

constructor TModelBusinessCliente.Create(aFactory: iQueryFactory);
begin
  FFactory := aFactory;
  FQuery := FFactory.NewQuery;
  FLookup := FFactory.NewQuery;
end;

class function TModelBusinessCliente.New: iModelBusinessCliente;
begin
  Result := Self.Create(TQueryFactoryIBX.New);
end;

function TModelBusinessCliente.Bind(aDataSource: TDataSource): iModelBusinessCliente;
begin
  Result := Self;
  FDataSource := aDataSource;
  FDataSource.DataSet := FQuery.DataSet;
end;

function TModelBusinessCliente.Get: iModelBusinessCliente;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('select * from CLIENTE')
    .Open;
end;

function TModelBusinessCliente.GetById(aId: Integer): iModelBusinessCliente;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('select * from CLIENTE where IDCLIENTE = :IDCLIENTE')
    .addParam('IDCLIENTE', aId)
    .Open;
end;

function TModelBusinessCliente.Salvar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('insert into CLIENTE (IDCLIENTE, NM_FANTASIA, RAZAO_SOCIAL, CNPJ, ENDERECO, TELEFONE)')
    .sqlAdd('values (:IDCLIENTE, :NM_FANTASIA, :RAZAO_SOCIAL, :CNPJ, :ENDERECO, :TELEFONE)')
    .addParam('IDCLIENTE', aId)
    .addParam('NM_FANTASIA', aFantasia)
    .addParam('RAZAO_SOCIAL', aRazao)
    .addParam('CNPJ', aCnpj)
    .addParam('ENDERECO', aEndereco)
    .addParam('TELEFONE', aTelefone)
    .execSql(True);
  Get;
end;

function TModelBusinessCliente.Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('update CLIENTE set NM_FANTASIA = :NM_FANTASIA, RAZAO_SOCIAL = :RAZAO_SOCIAL, CNPJ = :CNPJ, ENDERECO = :ENDERECO, TELEFONE = :TELEFONE')
    .sqlAdd('where IDCLIENTE = :IDCLIENTE')
    .addParam('IDCLIENTE', aId)
    .addParam('NM_FANTASIA', aFantasia)
    .addParam('RAZAO_SOCIAL', aRazao)
    .addParam('CNPJ', aCnpj)
    .addParam('ENDERECO', aEndereco)
    .addParam('TELEFONE', aTelefone)
    .execSql(True);
  Get;
end;

function TModelBusinessCliente.Excluir(aId: Integer): iModelBusinessCliente;
begin
  Result := Self;
  FQuery.active(False)
    .sqlClear
    .sqlAdd('delete from CLIENTE where IDCLIENTE = :IDCLIENTE')
    .addParam('IDCLIENTE', aId)
    .execSql(True);
  Get;
end;

end.
