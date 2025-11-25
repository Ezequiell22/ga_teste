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
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerEntity;
    function cadCliente: iModelDAOEntity<TModelEntityCadCliente>;
    function cadProduto: iModelDAOEntity<TModelEntityCadProduto>;
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

// Removidas classes de controller específicas; controller.entity apenas instancia modelos.

function TControllerEntity.cadCliente: iModelDAOEntity<TModelEntityCadCliente>;
begin
  if not assigned(FcadClienteDAO) then
    FcadClienteDAO := TModelDAOCadCliente.New;
  result := FcadClienteDAO;
end;

function TControllerEntity.cadProduto: iModelDAOEntity<TModelEntityCadProduto>;
begin
  if not assigned(FcadProdutoDAO) then
    FcadProdutoDAO := TModelDAOCadProduto.New;
  result := FcadProdutoDAO;
end;

// Removida lógica; o controller.entity apenas retorna as instâncias dos modelos.

class function TControllerEntity.New: iControllerEntity;
begin
  result := self.create;
end;

end.
