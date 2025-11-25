unit comercial.model.resource.impl.queryIBX;

{ arquivo da classe de query do firedac, este arquivo pode ser replicado
  e feito a adaptadação para outro componente e por sua vez chamado sem depedencia do
  firedac em outros locais...}

interface

uses
  Data.DB,
  System.SysUtils,
  IBX.IBQuery,
  IBX.IBDatabase,
  comercial.model.resource.impl.factory,
  comercial.model.resource.interfaces;

type
  TModelResourceQueryIBX = class(TInterfacedObject, iQuery)
  private
    FQuery: TIBQuery;
    FConexao : iConexao;
    FConnection : TIBDatabase;
    FFDTransaction: TIBTransaction;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iQuery;
    function active(aValue: boolean): iQuery;
    function addParam(aParam: string; aValue: Variant): iQuery;
    function DataSet: TDataSet;
    function execSql( commit : Boolean = True): iQuery;
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
  result := Self;
  FQuery.active := aValue;
end;

function TModelResourceQueryIBX.addParam(aParam: string; aValue: Variant): iQuery;
begin
  result := Self;
  FQuery.ParamByName(aParam).Value := aValue;
end;

constructor TModelResourceQueryIBX.Create;
begin

  FQuery := TIBQuery.Create(nil);
  FFDTransaction := TIBTransaction.Create(nil);

  FConexao := TResource.New
  .Conexao;
  FConnection := TIBDatabase(FConexao.Connect);
  FFDTransaction.DefaultDatabase := FConnection;
  FQuery.Database := FConnection;
  FQuery.Transaction := FFDTransaction;

end;

function TModelResourceQueryIBX.DataSet: TDataSet;
begin
  result := FQuery;
end;

destructor TModelResourceQueryIBX.Destroy;
begin

  FFDTransaction.Free;
  FQuery.Free;

  inherited;
end;

function TModelResourceQueryIBX.eof: boolean;
begin
  result := FQuery.eof;
end;

function TModelResourceQueryIBX.execSql( commit : Boolean = True): iQuery;
begin
  result := Self;

  try

    if not FQuery.Transaction.active then
      FQuery.Transaction.StartTransaction;

    FQuery.execSql;

    if FQuery.Transaction.active then
      FQuery.Transaction.Commit;

  except
    on E: exception do
    begin
      if FQuery.Transaction.active then
        FQuery.Transaction.Rollback;

      raise exception.Create(E.Message);
    end;

  end;
end;

function TModelResourceQueryIBX.isEmpty: boolean;
begin
  result := FQuery.isEmpty;
end;

class function TModelResourceQueryIBX.New: iQuery;
begin
  result := Self.Create;
end;

procedure TModelResourceQueryIBX.next;
begin
  FQuery.next;
end;

function TModelResourceQueryIBX.open: iQuery;
begin
  FQuery.open;
end;

function TModelResourceQueryIBX.sqlAdd(aValue: string): iQuery;
begin
  result := Self;
  FQuery.SQL.Add(aValue);
end;

function TModelResourceQueryIBX.sqlClear: iQuery;
begin
  result := Self;
  FQuery.SQL.Clear;
end;

end.
