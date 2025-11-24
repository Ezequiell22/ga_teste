unit comercial.model.entity.cadProduto;

interface

uses comercial.model.DAO.interfaces;

type
  TModelEntityCadProduto = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadProduto>;
    FIDPRODUTO: Integer;
    FDESCRICAO: string;
    FMARCA: string;
    FPRECO: Double;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadProduto>);
    destructor Destroy; override;
    function IDPRODUTO(aValue: Integer): TModelEntityCadProduto; overload;
    function IDPRODUTO: Integer; overload;
    function DESCRICAO(aValue: string): TModelEntityCadProduto; overload;
    function DESCRICAO: string; overload;
    function MARCA(aValue: string): TModelEntityCadProduto; overload;
    function MARCA: string; overload;
    function PRECO(aValue: Double): TModelEntityCadProduto; overload;
    function PRECO: Double; overload;
    function &End: iModelDAOEntity<TModelEntityCadProduto>;
  end;

implementation

uses System.SysUtils;

constructor TModelEntityCadProduto.Create(aParent: iModelDAOEntity<TModelEntityCadProduto>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadProduto.Destroy;
begin
  inherited;
end;

function TModelEntityCadProduto.&End: iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := FParent;
end;

function TModelEntityCadProduto.IDPRODUTO(aValue: Integer): TModelEntityCadProduto;
begin
  Result := Self;
  FIDPRODUTO := aValue;
end;

function TModelEntityCadProduto.IDPRODUTO: Integer;
begin
  if FIDPRODUTO <= 0 then
    raise Exception.Create('id inválido');
  Result := FIDPRODUTO;
end;

function TModelEntityCadProduto.DESCRICAO(aValue: string): TModelEntityCadProduto;
begin
  Result := Self;
  FDESCRICAO := aValue;
end;

function TModelEntityCadProduto.DESCRICAO: string;
begin
  if Trim(FDESCRICAO) = '' then
    raise Exception.Create('descrição obrigatória');
  Result := FDESCRICAO;
end;

function TModelEntityCadProduto.MARCA(aValue: string): TModelEntityCadProduto;
begin
  Result := Self;
  FMARCA := aValue;
end;

function TModelEntityCadProduto.MARCA: string;
begin
  Result := FMARCA;
end;

function TModelEntityCadProduto.PRECO(aValue: Double): TModelEntityCadProduto;
begin
  Result := Self;
  FPRECO := aValue;
end;

function TModelEntityCadProduto.PRECO: Double;
begin
  if FPRECO < 0 then
    raise Exception.Create('preço inválido');
  Result := FPRECO;
end;

end.

