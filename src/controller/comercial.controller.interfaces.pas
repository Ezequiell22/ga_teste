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

  iController = interface
    ['{7C276AC1-0385-4CFE-8395-319A67F573E2}']
    function entity: iControllerEntity;
    function business: iControllerBusiness;
  end;

  iControllerEntity = interface
    ['{9EDCA6E3-A329-454A-8755-67C9919C0B29}']
    function cadCliente: iModelDAOEntity<TModelEntityCadCliente>;
    function cadProduto: iModelDAOEntity<TModelEntityCadProduto>;
  end;

  iControllerBusiness = interface
    ['{D64C6AAD-C4A3-46BC-BBE4-3CF753379DA5}']
    function Pedido: iModelBusinessPedido;
    function RelatorioProdutos: iModelBusinessRelatorioProdutos;
    function Cliente: iModelBusinessCliente;
    function Produto: iModelBusinessProduto;
  end;

  // Removidas interfaces específicas de cliente/produto do controller,
  // o controller.entity retorna diretamente os modelos (DAO/Entity).

implementation

end.
