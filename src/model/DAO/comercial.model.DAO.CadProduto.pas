unit comercial.model.DAO.CadProduto;

interface

uses
  comercial.model.DAO.interfaces,
  comercial.model.entity.cadProduto,
  Data.DB,
  comercial.model.resource.impl.queryIBX,
  System.Generics.Collections,
  comercial.model.types.Db;

type
  TModelDAOCadProduto = class(TInterfacedObject, iModelDAOEntity<TModelEntityCadProduto>)
  private
    FQuery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityCadProduto;
    procedure AfterScroll(DataSet: TDataSet);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDAOEntity<TModelEntityCadProduto>;
    function Delete: iModelDAOEntity<TModelEntityCadProduto>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadProduto>;
    function Get: iModelDAOEntity<TModelEntityCadProduto>; overload;
    function Insert: iModelDAOEntity<TModelEntityCadProduto>;
    function This: TModelEntityCadProduto;
    function Update: iModelDAOEntity<TModelEntityCadProduto>;
    function GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadProduto>;
    function GetDataSet: TDataSet;
    function Get(AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadProduto>; overload;
  end;

implementation

uses System.SysUtils;

procedure TModelDAOCadProduto.AfterScroll(DataSet: TDataSet);
begin
  FEntity.IDPRODUTO(DataSet.FieldByName('IDPRODUTO').AsInteger);
  FEntity.DESCRICAO(DataSet.FieldByName('DESCRICAO').AsString);
  FEntity.MARCA(DataSet.FieldByName('MARCA').AsString);
  FEntity.PRECO(DataSet.FieldByName('PRECO').AsFloat);
end;

constructor TModelDAOCadProduto.Create;
begin
  FEntity := TModelEntityCadProduto.Create(Self);
  FQuery := TModelResourceQueryIBX.New(tcFBTeste);
  FQuery.DataSet.AfterScroll := AfterScroll;
end;

function TModelDAOCadProduto.DataSet(AValue: TDataSource): iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := FQuery.DataSet;
end;

function TModelDAOCadProduto.Delete: iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('delete from PRODUTO where IDPRODUTO = :IDPRODUTO')
      .addParam('IDPRODUTO', FEntity.IDPRODUTO)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

destructor TModelDAOCadProduto.Destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOCadProduto.Get: iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select * from PRODUTO')
      .Open;
    FQuery.DataSet.First;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelDAOCadProduto.Get(AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
end;

function TModelDAOCadProduto.GetbyId(AValue: integer): iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('select * from PRODUTO where IDPRODUTO = :IDPRODUTO')
      .addParam('IDPRODUTO', AValue)
      .Open;
    FQuery.DataSet.First;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TModelDAOCadProduto.GetDataSet: TDataSet;
begin
  Result := FQuery.DataSet;
end;

function TModelDAOCadProduto.Insert: iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('insert into PRODUTO (IDPRODUTO, DESCRICAO, MARCA, PRECO)')
      .sqlAdd('values (:IDPRODUTO, :DESCRICAO, :MARCA, :PRECO)')
      .addParam('IDPRODUTO', FEntity.IDPRODUTO)
      .addParam('DESCRICAO', FEntity.DESCRICAO)
      .addParam('MARCA', FEntity.MARCA)
      .addParam('PRECO', FEntity.PRECO)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TModelDAOCadProduto.New: iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self.Create;
end;

function TModelDAOCadProduto.This: TModelEntityCadProduto;
begin
  Result := FEntity;
end;

function TModelDAOCadProduto.Update: iModelDAOEntity<TModelEntityCadProduto>;
begin
  Result := Self;
  try
    FQuery.active(False)
      .sqlClear
      .sqlAdd('update PRODUTO set DESCRICAO = :DESCRICAO, MARCA = :MARCA, PRECO = :PRECO')
      .sqlAdd('where IDPRODUTO = :IDPRODUTO')
      .addParam('IDPRODUTO', FEntity.IDPRODUTO)
      .addParam('DESCRICAO', FEntity.DESCRICAO)
      .addParam('MARCA', FEntity.MARCA)
      .addParam('PRECO', FEntity.PRECO)
      .execSql;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

