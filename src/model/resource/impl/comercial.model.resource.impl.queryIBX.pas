unit comercial.model.resource.impl.queryIBX;

interface

uses
  Data.DB,
  IBDatabase,
  IBQuery,
  System.SysUtils,
  comercial.model.resource.interfaces,
  comercial.model.types.Db;

type
  TModelResourceQueryIBX = class(TInterfacedObject, iQuery)
  private
    FQuery: TIBQuery;
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
  public
    constructor Create(aDataBase: TDataBaseType);
    destructor Destroy; override;
    class function New(aDataBase: TDataBaseType): iQuery;
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

implementation

function TModelResourceQueryIBX.active(aValue: boolean): iQuery;
begin
  Result := Self;
  FQuery.Active := aValue;
end;

function TModelResourceQueryIBX.addParam(aParam: string; aValue: Variant): iQuery;
begin
  Result := Self;
  FQuery.Params.ParamByName(aParam).Value := aValue;
end;

constructor TModelResourceQueryIBX.Create(aDataBase: TDataBaseType);
begin
  FDatabase := TIBDatabase.Create(nil);
  FTransaction := TIBTransaction.Create(nil);
  FQuery := TIBQuery.Create(nil);

  case aDataBase of
    tcFBTeste:
      begin
        FDatabase.DatabaseName := 'C:\testeEmpresa\DADOS.FDB';
        FDatabase.Params.Values['user_name'] := 'SYSDBA';
        FDatabase.Params.Values['password'] := 'masterkey';
      end;
  else
    raise Exception.Create('Database não configurado');
  end;

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

class function TModelResourceQueryIBX.New(aDataBase: TDataBaseType): iQuery;
begin
  Result := Self.Create(aDataBase);
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

