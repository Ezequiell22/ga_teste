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



