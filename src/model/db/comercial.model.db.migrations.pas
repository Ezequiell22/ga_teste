unit comercial.model.db.migrations;

interface

uses
  System.SysUtils,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

type
  TDbMigrations = class
  private
    FExec: iQuery;
    FLookup: iQuery;
    function MetadataExists(aSQL: string): boolean;
    procedure ExecDDL(const aDDL: string);
    function EnsureException: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Apply;
  end;

implementation

constructor TDbMigrations.Create;
begin
  FExec := TModelResourceQueryIBX.NEw;
  FLookup := TModelResourceQueryIBX.New;
end;

destructor TDbMigrations.Destroy;
begin
  inherited;
end;

function TDbMigrations.MetadataExists(aSQL: string): boolean;
begin
  FLookup.active(False)
    .sqlClear
    .sqlAdd(aSQL)
    .open;
  Result := not FLookup.DataSet.IsEmpty;
  FLookup.active(False);
end;

procedure TDbMigrations.ExecDDL(const aDDL: string);
begin
  FExec.active(False)
    .sqlClear
    .sqlAdd(aDDL)
    .execSql(True);
end;

procedure TDbMigrations.Apply;
begin
  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''CLIENTE''') then
    ExecDDL(
      'create table CLIENTE ' + #13#10 +
      '(' + #13#10 +
      '  IDCLIENTE integer not null primary key,' + #13#10 +
      '  NM_FANTASIA varchar(150) not null,' + #13#10 +
      '  RAZAO_SOCIAL varchar(150) not null,' + #13#10 +
      '  CNPJ varchar(18),' + #13#10 +
      '  ENDERECO varchar(200),' + #13#10 +
      '  TELEFONE varchar(20)' + #13#10 +
      ')'
    );

  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''PRODUTO''') then
    ExecDDL(
      'create table PRODUTO ' + #13#10 +
      '(' + #13#10 +
      '  IDPRODUTO integer not null primary key,' + #13#10 +
      '  DESCRICAO varchar(150) not null,' + #13#10 +
      '  MARCA varchar(100),' + #13#10 +
      '  PRECO numeric(15,2) not null' + #13#10 +
      ')'
    );

  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''PEDIDO''') then
    ExecDDL(
      'create table PEDIDO ' + #13#10 +
      '(' + #13#10 +
      '  IDPEDIDO integer not null primary key,' + #13#10 +
      '  IDCLIENTE integer not null,' + #13#10 +
      '  DTEMISSAO date not null,' + #13#10 +
      '  VALOR_TOTAL numeric(15,2) default 0,' + #13#10 +
      '  constraint FK_PEDIDO_CLIENTE foreign key (IDCLIENTE) references CLIENTE(IDCLIENTE)' + #13#10 +
      ')'
    );

  if not MetadataExists('select rdb$relation_name from rdb$relations where rdb$relation_name = ''PEDIDO_ITENS''') then
    ExecDDL(
      'create table PEDIDO_ITENS ' + #13#10 +
      '(' + #13#10 +
      '  IDPEDIDO integer not null,' + #13#10 +
      '  SEQUENCIA integer not null,' + #13#10 +
      '  IDPRODUTO integer not null,' + #13#10 +
      '  VALOR_UNITARIO numeric(15,2) not null,' + #13#10 +
      '  QUANTIDADE numeric(15,3) not null,' + #13#10 +
      '  VALOR_TOTAL_ITEM numeric(15,2) not null,' + #13#10 +
      '  constraint PK_PEDIDO_ITENS primary key (IDPEDIDO, SEQUENCIA),' + #13#10 +
      '  constraint FK_ITENS_PEDIDO foreign key (IDPEDIDO) references PEDIDO(IDPEDIDO),' + #13#10 +
      '  constraint FK_ITENS_PRODUTO foreign key (IDPRODUTO) references PRODUTO(IDPRODUTO)' + #13#10 +
      ')'
    );

  if not EnsureException then
    ExecDDL('create exception EX_TELEFONE_OBRIGATORIO ''Telefone obrigatorio''');

  if not MetadataExists('select rdb$index_name from rdb$indices where rdb$index_name = ''IDX_PRODUTO_DESCRICAO_UNICO''') then
    ExecDDL('create unique index IDX_PRODUTO_DESCRICAO_UNICO on PRODUTO (DESCRICAO)');

  if not MetadataExists('select rdb$trigger_name from rdb$triggers where rdb$trigger_name = ''TRG_CLIENTE_TELEFONE''') then
    ExecDDL(
      'create trigger TRG_CLIENTE_TELEFONE for CLIENTE before insert or update as ' + #13#10 +
      'begin ' + #13#10 +
      '  if (new.TELEFONE is null or trim(new.TELEFONE) = '''') then ' + #13#10 +
      '    exception EX_TELEFONE_OBRIGATORIO; ' + #13#10 +
      'end'
    );

//  if not MetadataExists('select rdb$procedure_name from rdb$procedures where rdb$procedure_name = ''SP_TOP_PRODUTOS_VENDIDOS''') then
//    ExecDDL(
//      'create or alter procedure SP_TOP_PRODUTOS_VENDIDOS (DTINI date, DTFIM date) ' + #13#10 +
//      'returns (IDPRODUTO integer, DESCRICAO varchar(150), QTD integer) ' + #13#10 +
//      'as ' + #13#10 +
//      'begin ' + #13#10 +
//      '  for select first 2 i.IDPRODUTO, p.DESCRICAO, sum(i.QUANTIDADE) ' + #13#10 +
//      '  from PEDIDO_ITENS i ' + #13#10 +
//      '  join PRODUTO p on p.IDPRODUTO = i.IDPRODUTO ' + #13#10 +
//      '  join PEDIDO d on d.IDPEDIDO = i.IDPEDIDO ' + #13#10 +
//      '  where d.DTEMISSAO between :DTINI and :DTFIM ' + #13#10 +
//      '  group by i.IDPRODUTO, p.DESCRICAO ' + #13#10 +
//      '  order by sum(i.QUANTIDADE) desc ' + #13#10 +
//      '  into :IDPRODUTO, :DESCRICAO, :QTD do suspend; ' + #13#10 +
//      'end'
//    );
end;

function TDbMigrations.EnsureException: boolean;
begin
  Result := MetadataExists('select rdb$exception_name from rdb$exceptions where rdb$exception_name = ''EX_TELEFONE_OBRIGATORIO''');
end;

end.

