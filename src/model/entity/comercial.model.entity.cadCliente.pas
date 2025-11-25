unit comercial.model.entity.cadCliente;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.validation;

type
  TModelEntityCadCliente = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCadCliente>;
    FIDCLIENTE: Integer;
    FNM_FANTASIA: string;
    FRAZAO_SOCIAL: string;
    FCNPJ: string;
    FENDERECO: string;
    FTELEFONE: string;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCadCliente>);
    destructor Destroy; override;
    function IDCLIENTE(aValue: Integer): TModelEntityCadCliente; overload;
    function IDCLIENTE: Integer; overload;
    function NM_FANTASIA(aValue: string): TModelEntityCadCliente; overload;
    function NM_FANTASIA: string; overload;
    function RAZAO_SOCIAL(aValue: string): TModelEntityCadCliente; overload;
    function RAZAO_SOCIAL: string; overload;
    function CNPJ(aValue: string): TModelEntityCadCliente; overload;
    function CNPJ: string; overload;
    function ENDERECO(aValue: string): TModelEntityCadCliente; overload;
    function ENDERECO: string; overload;
    function TELEFONE(aValue: string): TModelEntityCadCliente; overload;
    function TELEFONE: string; overload;
    function &End: iModelDAOEntity<TModelEntityCadCliente>;
  end;

implementation

uses System.SysUtils;

constructor TModelEntityCadCliente.Create(aParent: iModelDAOEntity<TModelEntityCadCliente>);
begin
  FParent := aParent;
end;

destructor TModelEntityCadCliente.Destroy;
begin
  inherited;
end;

function TModelEntityCadCliente.&End: iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := FParent;
end;

function TModelEntityCadCliente.IDCLIENTE(aValue: Integer): TModelEntityCadCliente;
begin
  Result := Self;
  FIDCLIENTE := aValue;
end;

function TModelEntityCadCliente.IDCLIENTE: Integer;
begin
  if FIDCLIENTE <= 0 then
    raise Exception.Create('id inválido');
  Result := FIDCLIENTE;
end;

function TModelEntityCadCliente.NM_FANTASIA(aValue: string): TModelEntityCadCliente;
begin
  Result := Self;
  FNM_FANTASIA := aValue;
end;

function TModelEntityCadCliente.NM_FANTASIA: string;
begin
  Result := FNM_FANTASIA;
end;

function TModelEntityCadCliente.RAZAO_SOCIAL(aValue: string): TModelEntityCadCliente;
begin
  Result := Self;
  FRAZAO_SOCIAL := aValue;
end;

function TModelEntityCadCliente.RAZAO_SOCIAL: string;
begin
  Result := FRAZAO_SOCIAL;
end;

function TModelEntityCadCliente.CNPJ(aValue: string): TModelEntityCadCliente;
begin

  Result := Self;

  if not IsValidCNPJ(aValue) then
     raise Exception.Create('CNPJ inválido!');

  FCNPJ := aValue;
end;

function TModelEntityCadCliente.CNPJ: string;
begin
  Result := FCNPJ;
end;

function TModelEntityCadCliente.ENDERECO(aValue: string): TModelEntityCadCliente;
begin
  Result := Self;
  FENDERECO := aValue;
end;

function TModelEntityCadCliente.ENDERECO: string;
begin
  Result := FENDERECO;
end;

function TModelEntityCadCliente.TELEFONE(aValue: string): TModelEntityCadCliente;
begin
  Result := Self;
  FTELEFONE := aValue;
end;

function TModelEntityCadCliente.TELEFONE: string;
begin
  if Trim(FTELEFONE) = '' then
    raise Exception.Create('telefone obrigatório');
  Result := FTELEFONE;
end;

end.

