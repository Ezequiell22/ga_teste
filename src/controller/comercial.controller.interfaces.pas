unit comercial.controller.interfaces;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.business.interfaces,
  comercial.model.entity.cadCliente,
  comercial.model.entity.cadProduto,
  Data.DB;

type
  iControllerEntity = interface;
  iControllerBusiness = interface;
  iControllerCliente = interface;
  iControllerProduto = interface;

  iController = interface
    ['{7C276AC1-0385-4CFE-8395-319A67F573E2}']
    function entity: iControllerEntity;
    function business: iControllerBusiness;
  end;

  iControllerEntity = interface
    ['{9EDCA6E3-A329-454A-8755-67C9919C0B29}']
    function cadCliente: iControllerCliente;
    function cadProduto: iControllerProduto;
  end;

  iControllerBusiness = interface
    ['{D64C6AAD-C4A3-46BC-BBE4-3CF753379DA5}']
    function Pedido: iModelBusinessPedido;
    function RelatorioProdutos: iModelBusinessRelatorioProdutos;
  end;

  iControllerCliente = interface
    ['{2B9E8397-AC4B-4C88-91CE-346F1A0C0B71}']
    function Bind(aDataSource: TDataSource): iControllerCliente;
    function Get: iControllerCliente;
    function GetById(aId: Integer): iControllerCliente;
    function Salvar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iControllerCliente;
    function Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iControllerCliente;
    function Excluir(aId: Integer): iControllerCliente;
  end;

  iControllerProduto = interface
    ['{D8A2EADA-59F2-4A6F-A3B1-2E4A9C9F93AB}']
    function Bind(aDataSource: TDataSource): iControllerProduto;
    function Get: iControllerProduto;
    function GetById(aId: Integer): iControllerProduto;
    function Salvar(aId: Integer; aDescricao, aMarca: string; aPreco: Double): iControllerProduto;
    function Editar(aId: Integer; aDescricao, aMarca: string; aPreco: Double): iControllerProduto;
    function Excluir(aId: Integer): iControllerProduto;
  end;

implementation

end.
