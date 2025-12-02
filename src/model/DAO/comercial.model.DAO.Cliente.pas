unit comercial.model.DAO.Cliente;

interface

uses
    Data.DB,
    System.Generics.Collections,
  comercial.model.DAO.interfaces,
  comercial.model.entity.Cliente,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

type
  TModelDAOCliente = class(TInterfacedObject, iModelDAOEntity<TModelEntityCliente>)
  private
    FQuery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCliente;
    procedure AfterScroll(DataSet: TDataSet);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDAOEntity<TModelEntityCliente>;
    function Delete: iModelDAOEntity<TModelEntityCliente>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCliente>;
    function Get: iModelDAOEntity<TModelEntityCliente>; overload;
    function Insert: iModelDAOEntity<TModelEntityCliente>;
    function This: TModelEntityCliente;
    function Update: iModelDAOEntity<TModelEntityCliente>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCliente>;
    function GetDataSet: TDataSet;
    function Get(AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCliente>; overload;
  end;

implementation

uses System.SysUtils;

procedure TModelDAOCliente.AfterScroll(DataSet: TDataSet);
begin

end;

constructor TModelDAOCliente.Create;
begin
  FEntity := TModelEntityCliente.Create(Self);
  FQuery := TModelResourceQueryIBX.New;
  FQuery.DataSet.AfterScroll := AfterScroll;
end;

function TModelDAOCliente.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := FQuery.DataSet;
end;

function TModelDAOCliente.Delete: iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
 try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('update CLIENTE set ACTIVE = :ACTIVE ')
      .sqlAdd('where IDCLIENTE = :IDCLIENTE')
      .addParam('IDCLIENTE', FEntity.IDCLIENTE)
      .addParam('ACTIVE', 0)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TModelDAOCliente.Destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCliente.Get: iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select * from CLIENTE where ACTIVE = 1')
      .Open;
    FQuery.DataSet.First;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelDAOCliente.Get(AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
end;

function TModelDAOCliente.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select * from CLIENTE where IDCLIENTE = :IDCLIENTE')
      .addParam('IDCLIENTE', AValue)
      .Open;
    FQuery.DataSet.First;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelDAOCliente.GetDataSet: TDataSet;
begin
  Result := FQuery.DataSet;
end;

function TModelDAOCliente.Insert: iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('insert into CLIENTE (IDCLIENTE, NM_FANTASIA, ')
      .sqlAdd(' RAZAO_SOCIAL, CNPJ, ENDERECO, TELEFONE, ACTIVE)')
      .sqlAdd('values ((select coalesce(max(IDCLIENTE),0)+1 from CLIENTE),')
      .sqlAdd(':NM_FANTASIA, :RAZAO_SOCIAL, :CNPJ, :ENDERECO, :TELEFONE, :ACTIVE)')
      .addParam('NM_FANTASIA', FEntity.NM_FANTASIA)
      .addParam('RAZAO_SOCIAL', FEntity.RAZAO_SOCIAL)
      .addParam('CNPJ', FEntity.CNPJ)
      .addParam('ENDERECO', FEntity.ENDERECO)
      .addParam('TELEFONE', FEntity.TELEFONE)
      .addParam('ACTIVE', 1)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;

end;

class function TModelDAOCliente.New: iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self.Create;
end;

function TModelDAOCliente.This: TModelEntityCliente;
begin
  Result := FEntity;
end;

function TModelDAOCliente.Update: iModelDAOEntity<TModelEntityCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('update CLIENTE set NM_FANTASIA = :NM_FANTASIA, ')
      .sqlAdd(' RAZAO_SOCIAL = :RAZAO_SOCIAL, CNPJ = :CNPJ, ')
      .sqlAdd(' ENDERECO = :ENDERECO, TELEFONE = :TELEFONE,')
      .sqlAdd(' ACTIVE = :ACTIVE')
      .sqlAdd('where IDCLIENTE = :IDCLIENTE')
      .addParam('IDCLIENTE', FEntity.IDCLIENTE)
      .addParam('NM_FANTASIA', FEntity.NM_FANTASIA)
      .addParam('RAZAO_SOCIAL', FEntity.RAZAO_SOCIAL)
      .addParam('CNPJ', FEntity.CNPJ)
      .addParam('ENDERECO', FEntity.ENDERECO)
      .addParam('TELEFONE', FEntity.TELEFONE)
      .addParam('ACTIVE', 1)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

