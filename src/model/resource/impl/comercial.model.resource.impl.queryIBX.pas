unit comercial.model.resource.impl.queryIBX;

interface

uses
  Data.DB,
  IBX.IBDatabase,
  IBX.IBQuery,
  System.SysUtils,
  comercial.model.resource.interfaces;

type
  TModelResourceQueryIBX = class(TInterfacedObject, iQuery)
  private
    FQuery: TIBQuery;
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iQuery;
    function active(aValue: boolean): iQuery;
    function addParam(aParam: string; aValue: Variant): iQuery;
    function DataSet: TDataSet;
    function execSql(commit: Boolean = True): iQuery;
    function open: iQuery;
    function sqlClear: iQuery;
    function sqlAdd(aValue: string): iQuery;
    function isEmpty: boolean;
    function eof: boolean;
    procedure next;
  end;

  TQueryFactoryIBX = class(TInterfacedObject, iQueryFactory)
  public
    constructor Create;
    class function New: iQueryFactory;
    function NewQuery: iQuery;
  end;

implementation

function TModelResourceQueryIBX.active(aValue: boolean): iQuery;
begin
  Result := Self;
  FQuery.Active := aValue;
end;

constructor TQueryFactoryIBX.Create;
begin
end;

class function TQueryFactoryIBX.New: iQueryFactory;
begin
  Result := Self.Create;
end;

function TQueryFactoryIBX.NewQuery: iQuery;
begin
  Result := TModelResourceQueryIBX.New;
end;

function TModelResourceQueryIBX.addParam(aParam: string; aValue: Variant): iQuery;
begin
  Result := Self;
  FQuery.Params.ParamByName(aParam).Value := aValue;
end;

constructor TModelResourceQueryIBX.Create;
begin
  FDatabase := TIBDatabase.Create(nil);
  FTransaction := TIBTransaction.Create(nil);
  FQuery := TIBQuery.Create(nil);

  FDatabase.DatabaseName := 'C:\testeEmpresa\DADOS.FDB';
  FDatabase.Params.Values['user_name'] := 'SYSDBA';
  FDatabase.Params.Values['password'] := 'masterkey';

  FTransaction.DefaultDatabase := FDatabase;
  FDatabase.DefaultTransaction := FTransaction;
  FQuery.Database := FDatabase;
  FQuery.Transaction := FTransaction;
end;

function TModelResourceQueryIBX.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TModelResourceQueryIBX.Destroy;
begin
  FQuery.Free;
  FTransaction.Free;
  FDatabase.Free;
  inherited;
end;

function TModelResourceQueryIBX.eof: boolean;
begin
  Result := FQuery.EOF;
end;

function TModelResourceQueryIBX.execSql(commit: Boolean = True): iQuery;
begin
  Result := Self;
  try
    if not FDatabase.Connected then
      FDatabase.Open;

    if not FTransaction.InTransaction then
      FTransaction.StartTransaction;

    FQuery.ExecSQL;

    if commit and FTransaction.InTransaction then
      FTransaction.CommitRetaining;
  except
    on E: Exception do
    begin
      if FTransaction.InTransaction then
        FTransaction.RollbackRetaining;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TModelResourceQueryIBX.isEmpty: boolean;
begin
  Result := (FQuery.Active) and (FQuery.RecordCount = 0);
end;

class function TModelResourceQueryIBX.New: iQuery;
begin
  Result := Self.Create;
end;

procedure TModelResourceQueryIBX.next;
begin
  FQuery.Next;
end;

function TModelResourceQueryIBX.open: iQuery;
begin
  if not FDatabase.Connected then
    FDatabase.Open;
  FQuery.Open;
  Result := Self;
end;

function TModelResourceQueryIBX.sqlAdd(aValue: string): iQuery;
begin
  Result := Self;
  FQuery.SQL.Add(aValue);
end;

function TModelResourceQueryIBX.sqlClear: iQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
end;

end.
