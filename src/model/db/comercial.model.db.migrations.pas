unit comercial.model.db.migrations;

interface

uses
  IBX.IBDatabase,
  IBX.IBSQL,
  System.SysUtils;

type
  TDbMigrations = class
  private
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    FSQL: TIBSQL;
    procedure EnsureConnected;
    function MetadataExists(aSQL: string): boolean;
  procedure ExecDDL(const aDDL: string);
  function EnsureException: boolean;
  public
    constructor Create(const aDbPath, aUser, aPassword: string);
    destructor Destroy; override;
    procedure Apply;
  end;

implementation

constructor TDbMigrations.Create(const aDbPath, aUser, aPassword: string);
begin
  FDatabase := TIBDatabase.Create(nil);
  FTransaction := TIBTransaction.Create(nil);
  FSQL := TIBSQL.Create(nil);
  FDatabase.DatabaseName := aDbPath;
  FDatabase.Params.Values['user_name'] := aUser;
  FDatabase.Params.Values['password'] := aPassword;
  FTransaction.DefaultDatabase := FDatabase;
  FSQL.Database := FDatabase;
  FSQL.Transaction := FTransaction;
end;

destructor TDbMigrations.Destroy;
begin
  FSQL.Free;
  FTransaction.Free;
  FDatabase.Free;
  inherited;
end;

procedure TDbMigrations.EnsureConnected;
begin
  if not FDatabase.Connected then
    FDatabase.Open;
  if not FTransaction.InTransaction then
    FTransaction.StartTransaction;
end;

function TDbMigrations.MetadataExists(aSQL: string): boolean;
begin
  EnsureConnected;
  FSQL.SQL.Text := aSQL;
  FSQL.ExecQuery;
  Result := not FSQL.EOF;
  FSQL.Close;
end;

procedure TDbMigrations.ExecDDL(const aDDL: string);
begin
  EnsureConnected;
  FSQL.SQL.Text := aDDL;
  FSQL.ExecQuery;
  FTransaction.CommitRetaining;
end;

procedure TDbMigrations.Apply;
begin
  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''CLIENTE''') then
    ExecDDL('create table CLIENTE (IDCLIENTE integer not null primary key, NM_FANTASIA varchar(150) not null, RAZAO_SOCIAL varchar(150) not null, CNPJ varchar(18), ENDERECO varchar(200), TELEFONE varchar(20))');
  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''PRODUTO''') then
    ExecDDL('create table PRODUTO (IDPRODUTO integer not null primary key, DESCRICAO varchar(150) not null, MARCA varchar(100), PRECO numeric(15,2) not null)');
  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''PEDIDO''') then
    ExecDDL('create table PEDIDO (IDPEDIDO integer not null primary key, IDCLIENTE integer not null, DTEMISSAO date not null, VALOR_TOTAL numeric(15,2) default 0, constraint FK_PEDIDO_CLIENTE foreign key (IDCLIENTE) references CLIENTE(IDCLIENTE))');
  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''PEDIDO_ITENS''') then
    ExecDDL('create table PEDIDO_ITENS (IDPEDIDO integer not null, SEQUENCIA integer not null, IDPRODUTO integer not null, DESCRICAO varchar(150) not null, VALOR_UNITARIO numeric(15,2) not null, QUANTIDADE numeric(15,3) not null, VALOR_TOTAL_ITEM numeric(15,2) not null, constraint PK_PEDIDO_ITENS primary key (IDPEDIDO, SEQUENCIA), constraint FK_ITENS_PEDIDO foreign key (IDPEDIDO) references PEDIDO(IDPEDIDO), constraint FK_ITENS_PRODUTO foreign key (IDPRODUTO) references PRODUTO(IDPRODUTO))');
  if not EnsureException then
    ExecDDL('create exception EX_TELEFONE_OBRIGATORIO ''Telefone obrigatorio''');
  if not MetadataExists('select rdb$index_name from rdb$indices where rdb$index_name = ''IDX_PRODUTO_DESCRICAO_UNICO''') then
    ExecDDL('create unique index IDX_PRODUTO_DESCRICAO_UNICO on PRODUTO (DESCRICAO)');

  if not MetadataExists('select rdb$trigger_name from rdb$triggers where rdb$trigger_name = ''TRG_CLIENTE_TELEFONE''') then
    ExecDDL('create trigger TRG_CLIENTE_TELEFONE for CLIENTE before insert or update as begin if (new.TELEFONE is null or trim(new.TELEFONE) = '''') then exception EX_TELEFONE_OBRIGATORIO; end');

  if not MetadataExists('select rdb$procedure_name from rdb$procedures where rdb$procedure_name = ''SP_TOP_PRODUTOS_VENDIDOS''') then
    ExecDDL(
      'create or alter procedure SP_TOP_PRODUTOS_VENDIDOS (DTINI date, DTFIM date) returns (IDPRODUTO integer, DESCRICAO varchar(150), QTD integer) as begin '
      + 'for select i.IDPRODUTO, p.DESCRICAO, sum(i.QUANTIDADE) from PEDIDO_ITENS i '
      + 'join PRODUTO p on p.IDPRODUTO = i.IDPRODUTO '
      + 'join PEDIDO d on d.IDPEDIDO = i.IDPEDIDO '
      + 'where d.DTEMISSAO between :DTINI and :DTFIM '
      + 'group by i.IDPRODUTO, p.DESCRICAO order by sum(i.QUANTIDADE) desc rows 2 '
      + 'into :IDPRODUTO, :DESCRICAO, :QTD do suspend; end');
end;

function TDbMigrations.EnsureException: boolean;
begin
  Result := MetadataExists('select rdb$exception_name from rdb$exceptions where rdb$exception_name = ''EX_TELEFONE_OBRIGATORIO''');
end;

end.
