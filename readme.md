\# criar banco de dados



CREATE DATABASE 'localhost:C:\\ga\_teste\\win32\\debug\\dados.fdb'

USER 'sysdba' PASSWORD 'masterkey';



\# criar procedure do relatorio



SET TERM ^ ;



CREATE OR ALTER PROCEDURE SP\_TOP\_PRODUTOS\_VENDIDOS (

&nbsp; DTINI DATE,

&nbsp; DTFIM DATE

)

RETURNS (

&nbsp; IDPRODUTO INTEGER,

&nbsp; DESCRICAO VARCHAR(150),

&nbsp; QTD NUMERIC(15,3)

)

AS

BEGIN

&nbsp; FOR

&nbsp;   SELECT 

&nbsp;          i.IDPRODUTO,

&nbsp;          p.DESCRICAO,

&nbsp;          SUM(i.QUANTIDADE) AS QTD

&nbsp;     FROM PEDIDO\_ITENS i

&nbsp;     JOIN PRODUTO p ON p.IDPRODUTO = i.IDPRODUTO

&nbsp;     JOIN PEDIDO d ON d.IDPEDIDO = i.IDPEDIDO

&nbsp;    WHERE d.DTEMISSAO BETWEEN :DTINI AND :DTFIM

&nbsp;    GROUP BY i.IDPRODUTO, p.DESCRICAO

&nbsp;    ORDER BY QTD DESC

&nbsp;    ROWS 2

&nbsp;    INTO :IDPRODUTO, :DESCRICAO, :QTD

&nbsp; DO

&nbsp; BEGIN

&nbsp;   SUSPEND;

&nbsp; END

END^



SET TERM ; ^


## Configuração da Aplicação

- Arquivo `comercial.ini` (no mesmo diretório do executável) define conexão Firebird:
  - `[Database]`
  - `Path`: caminho do banco (ex.: `C:\ga_teste\Win32\Debug\dados.fdb`)
  - `User`: usuário (ex.: `SYSDBA`)
  - `Password`: senha (ex.: `masterkey`)

## Conexão e Transações (IBX)

- Conexão única compartilhada (`TIBDatabase`) reutilizada por todas as queries.
- Cada query cria sua própria `TIBTransaction` para isolamento transacional.
- Parâmetros de transação: `read_committed`, `rec_version`, `nowait`.

## Estrutura de Projeto

- `src/model/resource/impl`: conexão IBX, factory, query.
- `src/model/db`: migrações de banco.
- `src/model/business`: regras de negócio (Cliente, Produto, Pedido, Relatórios).
- `src/model/DAO`: operações CRUD e binding de `DataSource`.
- `src/model/entity`: validações de entidades.
- `src/utils`: logs e impressão HTML.
- `src/view`: telas VCL com MVC chamando apenas controllers.

## Testes (DUnitX)

- Projeto de testes: `tests/comercial.dunitx.tests.dproj`.
- Runner console: `tests/comercial.dunitx.tests.dpr`.
- Suites:
  - Migrações: valida tabelas, índices, triggers, procedure.
  - Cliente: CRUD e trigger de telefone obrigatório.
  - Produto: CRUD e índice único de descrição.
  - Pedido: criação, itens, totalização.
  - Relatório HTML: geração de Top Produtos.

## Relatórios

- HTML de Pedido e Top Produtos gerados em `reports/` próximo ao executável.
- Procedure `SP_TOP_PRODUTOS_VENDIDOS` retorna os dois mais vendidos no período.

## Build e Execução

- Abrir `comercial.dproj` e compilar em `Win32/Debug`.
- Garantir `comercial.ini` com Path/credenciais válidas.
- Rodar testes compilando `tests/comercial.dunitx.tests.dproj` e executando o console.

