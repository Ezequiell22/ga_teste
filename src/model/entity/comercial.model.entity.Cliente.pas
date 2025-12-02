unit comercial.model.entity.Cliente;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.validation;

type
  TModelEntityCliente = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityCliente>;
    FIDCLIENTE: Integer;
    FNM_FANTASIA: string;
    FRAZAO_SOCIAL: string;
    FCNPJ: string;
    FENDERECO: string;
    FTELEFONE: string;
    FACTIVE : Boolean;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityCliente>);
    destructor Destroy; override;
    function IDCLIENTE(aValue: Integer): TModelEntityCliente; overload;
    function IDCLIENTE: Integer; overload;
    function NM_FANTASIA(aValue: string): TModelEntityCliente; overload;
    function NM_FANTASIA: string; overload;
    function RAZAO_SOCIAL(aValue: string): TModelEntityCliente; overload;
    function RAZAO_SOCIAL: string; overload;
    function CNPJ(aValue: string): TModelEntityCliente; overload;
    function CNPJ: string; overload;
    function ENDERECO(aValue: string): TModelEntityCliente; overload;
    function ENDERECO: string; overload;
    function TELEFONE(aValue: string): TModelEntityCliente; overload;
    function TELEFONE: string; overload;
    function ACTIVE(aValue: Boolean): TModelEntityCliente; overload;
    function ACTIVE: Boolean; overload;
    function &End: iModelDAOEntity<TModelEntityCliente>;
  end;

implementation

uses System.SysUtils;

constructor TModelEntityCliente.Create(aParent: iModelDAOEntity<TModelEntityCliente>);
begin
  FParent := aParent;
end;

destructor TModelEntityCliente.Destroy;
begin
  inherited;
end;

function TModelEntityCliente.&End: iModelDAOEntity<TModelEntityCliente>;
begin
  Result := FParent;
end;

function TModelEntityCliente.IDCLIENTE(aValue: Integer): TModelEntityCliente;
begin
  Result := Self;
  FIDCLIENTE := aValue;
end;

function TModelEntityCliente.IDCLIENTE: Integer;
begin
  if FIDCLIENTE <= 0 then
    raise Exception.Create('id inválido');
  Result := FIDCLIENTE;
end;

function TModelEntityCliente.NM_FANTASIA(aValue: string): TModelEntityCliente;
begin
  Result := Self;
  FNM_FANTASIA := aValue;
end;

function TModelEntityCliente.NM_FANTASIA: string;
begin
  Result := FNM_FANTASIA;
end;

function TModelEntityCliente.RAZAO_SOCIAL(aValue: string): TModelEntityCliente;
begin
  Result := Self;
  FRAZAO_SOCIAL := aValue;
end;

function TModelEntityCliente.RAZAO_SOCIAL: string;
begin
  Result := FRAZAO_SOCIAL;
end;

function TModelEntityCliente.CNPJ(aValue: string): TModelEntityCliente;
begin

  Result := Self;

  if not IsValidCNPJ(aValue) then
     raise Exception.Create('CNPJ inválido!');

  FCNPJ := aValue;
end;

function TModelEntityCliente.ACTIVE: Boolean;
begin
  result := Factive
end;

function TModelEntityCliente.ACTIVE(aValue: Boolean): TModelEntityCliente;
begin
  result := Self;
  Factive := Avalue
end;

function TModelEntityCliente.CNPJ: string;
begin
  Result := FCNPJ;
end;

function TModelEntityCliente.ENDERECO(aValue: string): TModelEntityCliente;
begin
  Result := Self;
  FENDERECO := aValue;
end;

function TModelEntityCliente.ENDERECO: string;
begin
  Result := FENDERECO;
end;

function TModelEntityCliente.TELEFONE(aValue: string): TModelEntityCliente;
begin
  Result := Self;
  FTELEFONE := aValue;
end;

function TModelEntityCliente.TELEFONE: string;
begin
  if Trim(FTELEFONE) = '' then
    raise Exception.Create('telefone obrigatório');
  Result := FTELEFONE;
end;

end.

