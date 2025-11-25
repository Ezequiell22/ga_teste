unit comercial.model.business.Cliente;

interface

uses
  Data.DB,
  comercial.model.business.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX,
  comercial.model.DAO.interfaces,
  comercial.model.entity.Cliente;

type
  TModelBusinessCliente = class(TInterfacedObject, iModelBusinessCliente)
  private
    FDAOCliente: iModelDAOEntity<TModelEntityCliente>;
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

uses System.SysUtils,
  comercial.model.DAO.Cliente;

constructor TModelBusinessCliente.Create;
begin
  FDAOCliente := TmodelDaoCliente.New;
end;

class function TModelBusinessCliente.New: iModelBusinessCliente;
begin
  Result := Self.Create;
end;

function TModelBusinessCliente.Bind(aDataSource: TDataSource): iModelBusinessCliente;
begin
  Result := Self;

  FDAOCliente.DataSet(aDataSource)
end;

function TModelBusinessCliente.Get: iModelBusinessCliente;
begin
  Result := Self;

  FDAOCliente.Get
end;

function TModelBusinessCliente.GetById(aId: Integer): iModelBusinessCliente;
begin
  Result := Self;
  FDAOCliente
    .GetbyId(aId)
end;

function TModelBusinessCliente.Salvar( aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
begin
  Result := Self;

  FDAOCliente
    .This
      .NM_FANTASIA(aFantasia)
      .RAZAO_SOCIAL(aRazao)
      .CNPJ(aCnpj)
      .ENDERECO(aEndereco)
      .TELEFONE(aTelefone)
      .&End
    .Insert

end;

function TModelBusinessCliente.Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
begin
  Result := Self;
  FDAOCliente
    .This
      .NM_FANTASIA(aFantasia)
      .RAZAO_SOCIAL(aRazao)
      .CNPJ(aCnpj)
      .ENDERECO(aEndereco)
      .TELEFONE(aTelefone)
      .&End
    .Update


end;

function TModelBusinessCliente.Excluir(aId: Integer): iModelBusinessCliente;
begin
  Result := Self;
  FDAOCliente
    .This
     .IDCLIENTE(aId)
      .&End
    .delete

end;

end.
