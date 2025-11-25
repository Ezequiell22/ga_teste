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
    FQueryRead: iQuery;
    FQueryWrite: iQuery;
    FDataSource: TDataSource;
  public
    constructor Create;
    class function New: iModelBusinessCliente;
    function Bind(aDataSource: TDataSource): iModelBusinessCliente;
    function Get: iModelBusinessCliente;
    function GetById(aId: Integer): iModelBusinessCliente;
    function Salvar(aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
    function Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
    function Excluir(aId: Integer): iModelBusinessCliente;
  end;

implementation

uses System.SysUtils;

constructor TModelBusinessCliente.Create;
begin
  FQueryRead := TModelResourceQueryIBX.New;
  FQueryWrite := TModelResourceQueryIBX.New;
end;

class function TModelBusinessCliente.New: iModelBusinessCliente;
begin
  Result := Self.Create;
end;

function TModelBusinessCliente.Bind(aDataSource: TDataSource): iModelBusinessCliente;
begin
  Result := Self;
  FDataSource := aDataSource;
  FDataSource.DataSet := FQueryRead.DataSet;
end;

function TModelBusinessCliente.Get: iModelBusinessCliente;
begin
  Result := Self;
  FQueryRead.active(False)
    .sqlClear
    .sqlAdd('select * from CLIENTE')
    .Open;
end;

function TModelBusinessCliente.GetById(aId: Integer): iModelBusinessCliente;
begin
  Result := Self;
  FQueryRead.active(False)
    .sqlClear
    .sqlAdd('select * from CLIENTE where IDCLIENTE = :IDCLIENTE')
    .addParam('IDCLIENTE', aId)
    .Open;
end;

function TModelBusinessCliente.Salvar( aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
begin
  Result := Self;

  FQueryRead.active(false)
  .sqlClear
  .sqlAdd('select (count(idCliente) + 1) as idn from cliente')
  .open;

  var newId :=FQueryRead.DataSet.FieldByName('idn').Asinteger;

  FQueryWrite.active(False)
    .sqlClear
    .sqlAdd('insert into CLIENTE (IDCLIENTE, NM_FANTASIA, RAZAO_SOCIAL, CNPJ, ENDERECO, TELEFONE)')
    .sqlAdd('values (:IDCLIENTE, :NM_FANTASIA, :RAZAO_SOCIAL, :CNPJ, :ENDERECO, :TELEFONE)')
    .addParam('IDCLIENTE', newId)
    .addParam('NM_FANTASIA', aFantasia)
    .addParam('RAZAO_SOCIAL', aRazao)
    .addParam('CNPJ', aCnpj)
    .addParam('ENDERECO', aEndereco)
    .addParam('TELEFONE', aTelefone)
    .execSql(True);

end;

function TModelBusinessCliente.Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
begin
  Result := Self;
  FQueryWrite.active(False)
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

end;

function TModelBusinessCliente.Excluir(aId: Integer): iModelBusinessCliente;
begin
  Result := Self;
  FQueryWrite.active(False)
    .sqlClear
    .sqlAdd('delete from CLIENTE where IDCLIENTE = :IDCLIENTE')
    .addParam('IDCLIENTE', aId)
    .execSql(True);
end;

end.
