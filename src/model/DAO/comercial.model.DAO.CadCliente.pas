unit comercial.model.DAO.CadCliente;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.cadCliente,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX,
  System.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOCadCliente = class(TInterfacedObject, iModelDAOEntity<TModelEntityCadCliente>)
  private
    FQuery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCadCliente;
    procedure AfterScroll(DataSet: TDataSet);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDAOEntity<TModelEntityCadCliente>;
    function Delete: iModelDAOEntity<TModelEntityCadCliente>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadCliente>;
    function Get: iModelDAOEntity<TModelEntityCadCliente>; overload;
    function Insert: iModelDAOEntity<TModelEntityCadCliente>;
    function This: TModelEntityCadCliente;
    function Update: iModelDAOEntity<TModelEntityCadCliente>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadCliente>;
    function GetDataSet: TDataSet;
    function Get(AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadCliente>; overload;
  end;

implementation

uses System.SysUtils;

procedure TModelDAOCadCliente.AfterScroll(DataSet: TDataSet);
begin
  FEntity.IDCLIENTE(DataSet.FieldByName('IDCLIENTE').AsInteger);
  FEntity.NM_FANTASIA(DataSet.FieldByName('NM_FANTASIA').AsString);
  FEntity.RAZAO_SOCIAL(DataSet.FieldByName('RAZAO_SOCIAL').AsString);
  FEntity.CNPJ(DataSet.FieldByName('CNPJ').AsString);
  FEntity.ENDERECO(DataSet.FieldByName('ENDERECO').AsString);
  FEntity.TELEFONE(DataSet.FieldByName('TELEFONE').AsString);
end;

constructor TModelDAOCadCliente.Create;
begin
  FEntity := TModelEntityCadCliente.Create(Self);
  FQuery := TModelResourceQueryIBX.New(tcFBTeste);
  FQuery.DataSet.AfterScroll := AfterScroll;
end;

function TModelDAOCadCliente.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := FQuery.DataSet;
end;

function TModelDAOCadCliente.Delete: iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('delete from CLIENTE where IDCLIENTE = :IDCLIENTE')
      .addParam('IDCLIENTE', FEntity.IDCLIENTE)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TModelDAOCadCliente.Destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCadCliente.Get: iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select * from CLIENTE')
      .Open;
    FQuery.DataSet.First;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelDAOCadCliente.Get(AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self;
end;

function TModelDAOCadCliente.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadCliente>;
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

function TModelDAOCadCliente.GetDataSet: TDataSet;
begin
  Result := FQuery.DataSet;
end;

function TModelDAOCadCliente.Insert: iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('insert into CLIENTE (IDCLIENTE, NM_FANTASIA, RAZAO_SOCIAL, CNPJ, ENDERECO, TELEFONE)')
      .sqlAdd('values (:IDCLIENTE, :NM_FANTASIA, :RAZAO_SOCIAL, :CNPJ, :ENDERECO, :TELEFONE)')
      .addParam('IDCLIENTE', FEntity.IDCLIENTE)
      .addParam('NM_FANTASIA', FEntity.NM_FANTASIA)
      .addParam('RAZAO_SOCIAL', FEntity.RAZAO_SOCIAL)
      .addParam('CNPJ', FEntity.CNPJ)
      .addParam('ENDERECO', FEntity.ENDERECO)
      .addParam('TELEFONE', FEntity.TELEFONE)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TModelDAOCadCliente.New: iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self.Create;
end;

function TModelDAOCadCliente.This: TModelEntityCadCliente;
begin
  Result := FEntity;
end;

function TModelDAOCadCliente.Update: iModelDAOEntity<TModelEntityCadCliente>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('update CLIENTE set NM_FANTASIA = :NM_FANTASIA, RAZAO_SOCIAL = :RAZAO_SOCIAL, CNPJ = :CNPJ, ENDERECO = :ENDERECO, TELEFONE = :TELEFONE')
      .sqlAdd('where IDCLIENTE = :IDCLIENTE')
      .addParam('IDCLIENTE', FEntity.IDCLIENTE)
      .addParam('NM_FANTASIA', FEntity.NM_FANTASIA)
      .addParam('RAZAO_SOCIAL', FEntity.RAZAO_SOCIAL)
      .addParam('CNPJ', FEntity.CNPJ)
      .addParam('ENDERECO', FEntity.ENDERECO)
      .addParam('TELEFONE', FEntity.TELEFONE)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

