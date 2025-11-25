unit comercial.controller.entity;

interface

uses
  comercial.controller.interfaces,
  comercial.model.DAO.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.entity.cadCliente,
  comercial.model.entity.cadProduto,
  Data.DB;

type
  TControllerEntity = class(TInterfacedObject, iControllerEntity)
  private
    FcadClienteDAO: iModelDAOEntity<TModelEntityCadCliente>;
    FcadProdutoDAO: iModelDAOEntity<TModelEntityCadProduto>;
    FCli: iControllerCliente;
    FProd: iControllerProduto;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerEntity;
    function cadCliente: iControllerCliente;
    function cadProduto: iControllerProduto;
end;

implementation

uses
  comercial.model.DAO.CadCliente,
  comercial.model.DAO.CadProduto, comercial.model.resource.impl.queryIBX;

{ TControllerEntity }

constructor TControllerEntity.create;
begin

end;

destructor TControllerEntity.destroy;
begin

  inherited;
end;

type
  TControllerCliente = class(TInterfacedObject, iControllerCliente)
  private
    FDAO: iModelDAOEntity<TModelEntityCadCliente>;
  public
    constructor Create(aDAO: iModelDAOEntity<TModelEntityCadCliente>);
    function Bind(aDataSource: TDataSource): iControllerCliente;
    function Get: iControllerCliente;
    function GetById(aId: Integer): iControllerCliente;
    function Salvar( aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iControllerCliente;
    function Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iControllerCliente;
    function Excluir(aId: Integer): iControllerCliente;
  end;

  TControllerProduto = class(TInterfacedObject, iControllerProduto)
  private
    FDAO: iModelDAOEntity<TModelEntityCadProduto>;
  public
    constructor Create(aDAO: iModelDAOEntity<TModelEntityCadProduto>);
    function Bind(aDataSource: TDataSource): iControllerProduto;
    function Get: iControllerProduto;
    function GetById(aId: Integer): iControllerProduto;
    function Salvar( aDescricao, aMarca: string; aPreco: Double): iControllerProduto;
    function Editar(aId: Integer;  aDescricao, aMarca: string; aPreco: Double): iControllerProduto;
    function Excluir(aId: Integer): iControllerProduto;
  end;

function TControllerEntity.cadCliente: iControllerCliente;
begin
  if not assigned(FCli) then
  begin
    if not assigned(FcadClienteDAO) then
      FcadClienteDAO := TModelDAOCadCliente.New;
    FCli := TControllerCliente.Create(FcadClienteDAO);
  end;
  result := FCli;
end;

function TControllerEntity.cadProduto: iControllerProduto;
begin
  if not assigned(FProd) then
  begin
    if not assigned(FcadProdutoDAO) then
      FcadProdutoDAO := TModelDAOCadProduto.New;
    FProd := TControllerProduto.Create(FcadProdutoDAO);
  end;
  result := FProd;
end;

constructor TControllerCliente.Create(aDAO: iModelDAOEntity<TModelEntityCadCliente>);
begin
  FDAO := aDAO;
end;

function TControllerCliente.Bind(aDataSource: TDataSource): iControllerCliente;
begin
  Result := Self;
  FDAO.DataSet(aDataSource);
end;

function TControllerCliente.Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iControllerCliente;
begin
  Result := Self;
  FDAO.This.IDCLIENTE(aId)
    .NM_FANTASIA(aFantasia)
    .RAZAO_SOCIAL(aRazao)
    .CNPJ(aCnpj)
    .ENDERECO(aEndereco)
    .TELEFONE(aTelefone);
  FDAO.Update;

end;

function TControllerCliente.Excluir(aId: Integer): iControllerCliente;
begin
  Result := Self;
  FDAO.This.IDCLIENTE(aId);
  FDAO.Delete;

end;

function TControllerCliente.Get: iControllerCliente;
begin
  Result := Self;
  FDAO.Get;
end;

function TControllerCliente.GetById(aId: Integer): iControllerCliente;
begin
  Result := Self;
  FDAO.GetbyId(aId);
end;

function TControllerCliente.Salvar( aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iControllerCliente;
var FQuery: iQuery;
  newId : integer;
begin
  Result := Self;

  FQuery := TQueryFactoryIBX.New.NewQuery;

  FQuery.active(false)
  .sqlClear
  .sqlAdd('select (count(idCliente) + 1) idN from cliente')
  .open;

  newId := FQuery.DataSet.FieldByName('idN').AsInteger;

  FDAO.This.IDCLIENTE(newId)
    .NM_FANTASIA(aFantasia)
    .RAZAO_SOCIAL(aRazao)
    .CNPJ(aCnpj)
    .ENDERECO(aEndereco)
    .TELEFONE(aTelefone);
  FDAO.Insert;

end;

constructor TControllerProduto.Create(aDAO: iModelDAOEntity<TModelEntityCadProduto>);
begin
  FDAO := aDAO;
end;

function TControllerProduto.Bind(aDataSource: TDataSource): iControllerProduto;
begin
  Result := Self;
  FDAO.DataSet(aDataSource);
end;

function TControllerProduto.Editar(aId: Integer; aDescricao, aMarca: string; aPreco: Double): iControllerProduto;
begin
  Result := Self;
  FDAO.This.IDPRODUTO(aId)
    .DESCRICAO(aDescricao)
    .MARCA(aMarca)
    .PRECO(aPreco);
  FDAO.Update;

end;

function TControllerProduto.Excluir(aId: Integer): iControllerProduto;
begin
  Result := Self;
  FDAO.This.IDPRODUTO(aId);
  FDAO.Delete;

end;

function TControllerProduto.Get: iControllerProduto;
begin
  Result := Self;
  FDAO.Get;
end;

function TControllerProduto.GetById(aId: Integer): iControllerProduto;
begin
  Result := Self;
  FDAO.GetbyId(aId);
end;

function TControllerProduto.Salvar( aDescricao, aMarca: string; aPreco: Double): iControllerProduto;
var FQuery: iQuery;
  newId : integer;
begin
  Result := Self;

  FQuery := TQueryFactoryIBX.New.NewQuery;

  FQuery.active(false)
  .sqlClear
  .sqlAdd('select (count(idProduto) + 1) idN from produto')
  .open;

  newId := FQuery.DataSet.FieldByName('idN').AsInteger;
  FDAO.This.IDPRODUTO(newId)
    .DESCRICAO(aDescricao)
    .MARCA(aMarca)
    .PRECO(aPreco);
  FDAO.Insert;

end;

class function TControllerEntity.New: iControllerEntity;
begin
  result := self.create;
end;

end.
