unit comercial.model.business.interfaces;

interface

uses System.Generics.Collections,
  Data.DB,
  System.Classes,
  Vcl.CheckLst,
  Vcl.StdCtrls,
  Vcl.DBGrids,
  comercial.model.DAO.interfaces;

type

  // Interfaces antigas removidas

  iModelBusinessPedido = interface
    ['{6E2D3C1A-8E5A-4A6F-8B71-2E6C8146E1C2}']
    function Novo(aIdPedido, aIdCliente: Integer): iModelBusinessPedido;
    function AdicionarItem(aIdProduto: Integer; aDescricao: string; aValor: Double; aQuantidade: Double): iModelBusinessPedido;
    function Finalizar: iModelBusinessPedido;
    function LinkDataSourcePedido(aDataSource: TDataSource): iModelBusinessPedido;
    function LinkDataSourceItens(aDataSource: TDataSource): iModelBusinessPedido;
  end;

  iModelBusinessRelatorioProdutos = interface
    ['{BFD1E2A4-1F1C-4C76-AE2B-8D6B6A1B1D3C}']
    function Gerar(aDtIni, aDtFim: TDateTime): iModelBusinessRelatorioProdutos;
    function LinkDataSource(aDataSource: TDataSource): iModelBusinessRelatorioProdutos;
  end;

implementation

end.
