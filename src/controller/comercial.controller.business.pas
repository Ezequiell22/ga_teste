unit comercial.controller.business;

interface

uses
  comercial.controller.interfaces,
  comercial.model.business.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.DAO.interfaces,
  comercial.model.business.Pedido,
  comercial.model.business.RelatorioProdutos;

type
  TControllerBusiness = class(TInterfacedObject, iControllerBusiness)
  private
    FPedido: iModelBusinessPedido;
    FRelatorio: iModelBusinessRelatorioProdutos;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerBusiness;
    function Pedido: iModelBusinessPedido;
    function RelatorioProdutos: iModelBusinessRelatorioProdutos;
  end;

implementation


{ TControllerBusiness }

constructor TControllerBusiness.create;
begin
 
end;

destructor TControllerBusiness.destroy;
begin

  inherited;
end;

function TControllerBusiness.Pedido: iModelBusinessPedido;
begin
  if not assigned(FPedido) then
    FPedido := TModelBusinessPedido.New;
  result := FPedido;
end;

function TControllerBusiness.RelatorioProdutos: iModelBusinessRelatorioProdutos;
begin
  if not assigned(FRelatorio) then
    FRelatorio := TModelBusinessRelatorioProdutos.New;
  result := FRelatorio;
end;

class function TControllerBusiness.New: iControllerBusiness;
begin
  result := Self.create;
end;


end.
