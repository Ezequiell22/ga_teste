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
    function Get: iModelBusinessPedido;
    function Abrir(aIdPedido: Integer): iModelBusinessPedido;
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

  iModelBusinessCliente = interface
    ['{1C7D9A4A-6B23-4B3B-9E2A-8A63B6D4F5A1}']
    function Bind(aDataSource: TDataSource): iModelBusinessCliente;
    function Get: iModelBusinessCliente;
    function GetById(aId: Integer): iModelBusinessCliente;
    function Salvar(aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
    function Editar(aId: Integer; aFantasia, aRazao, aCnpj, aEndereco, aTelefone: string): iModelBusinessCliente;
    function Excluir(aId: Integer): iModelBusinessCliente;
  end;

  iModelBusinessProduto = interface
    ['{5B29E6D1-37B9-4C8C-8F0C-9D27E3A5B812}']
    function Bind(aDataSource: TDataSource): iModelBusinessProduto;
    function Get: iModelBusinessProduto;
    function GetById(aId: Integer): iModelBusinessProduto;
    function Salvar(aDescricao, aMarca: string; aPreco: Double): iModelBusinessProduto;
    function Editar(aId: Integer; aDescricao, aMarca: string; aPreco: Double): iModelBusinessProduto;
    function Excluir(aId: Integer): iModelBusinessProduto;
  end;

implementation

end.
