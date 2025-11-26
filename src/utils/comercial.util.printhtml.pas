unit comercial.util.printhtml;

interface

type
  TPrintHtmlPedido = class
  public
    class function GerarHtmlPedido(aIdPedido: Integer; const aFilePath: string): string; static;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  Data.DB,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

class function TPrintHtmlPedido.GerarHtmlPedido(aIdPedido: Integer; const aFilePath: string): string;
var
  QCab, QItens: iQuery;
  SB: TStringBuilder;
begin
  QCab := TModelResourceQueryIBX.New;
  QItens := TModelResourceQueryIBX.New;

  QCab.active(False)
    .sqlClear
    .sqlAdd('select d.IDPEDIDO, d.IDCLIENTE, d.DTEMISSAO, d.VALOR_TOTAL,')
    .sqlAdd('       c.NM_FANTASIA, c.RAZAO_SOCIAL, c.CNPJ, c.ENDERECO, c.TELEFONE')
    .sqlAdd('  from PEDIDO d')
    .sqlAdd('  join CLIENTE c on c.IDCLIENTE = d.IDCLIENTE')
    .sqlAdd(' where d.IDPEDIDO = :ID')
    .addParam('ID', aIdPedido)
    .open;

  if QCab.DataSet.IsEmpty then
  begin
    Result := '';
    Exit;
  end;

  QItens.active(False)
    .sqlClear
    .sqlAdd('select i.DESCRICAO, p.MARCA, i.QUANTIDADE, i.VALOR_UNITARIO, i.VALOR_TOTAL_ITEM')
    .sqlAdd('  from PEDIDO_ITENS i')
    .sqlAdd('  left join PRODUTO p on p.IDPRODUTO = i.IDPRODUTO')
    .sqlAdd(' where i.IDPEDIDO = :ID')
    .addParam('ID', aIdPedido)
    .open;

  SB := TStringBuilder.Create;
  try
    SB.AppendLine('<!DOCTYPE html>');
    SB.AppendLine('<html lang="pt-br">');
    SB.AppendLine('<head>');
    SB.AppendLine('<meta charset="utf-8">');
    SB.AppendLine('<title>Pedido</title>');
    SB.AppendLine('<style>');
    SB.AppendLine('body{font-family: Arial, sans-serif; margin:24px;}');
    SB.AppendLine('h1{margin:0 0 8px 0;}');
    SB.AppendLine('table{border-collapse:collapse; width:100%;}');
    SB.AppendLine('th,td{border:1px solid #ccc; padding:8px; text-align:left;}');
    SB.AppendLine('th{background:#f5f5f5;}');
    SB.AppendLine('.section{margin-top:16px;}');
    SB.AppendLine('.total{font-weight:bold; text-align:right;}');
    SB.AppendLine('</style>');
    SB.AppendLine('</head>');
    SB.AppendLine('<body>');
    SB.AppendLine('<h1>Pedido ' + QCab.DataSet.FieldByName('IDPEDIDO').AsString + '</h1>');
    SB.AppendLine('<div>Data: ' + DateTimeToStr(QCab.DataSet.FieldByName('DTEMISSAO').AsDateTime) + '</div>');
    SB.AppendLine('<div class="section">');
    SB.AppendLine('<h2>Cliente</h2>');
    SB.AppendLine('<div>ID: ' + QCab.DataSet.FieldByName('IDCLIENTE').AsString + '</div>');
    SB.AppendLine('<div>Nome fantasia: ' + QCab.DataSet.FieldByName('NM_FANTASIA').AsString + '</div>');
    SB.AppendLine('<div>Razão social: ' + QCab.DataSet.FieldByName('RAZAO_SOCIAL').AsString + '</div>');
    SB.AppendLine('<div>CNPJ: ' + QCab.DataSet.FieldByName('CNPJ').AsString + '</div>');
    SB.AppendLine('<div>Endereço: ' + QCab.DataSet.FieldByName('ENDERECO').AsString + '</div>');
    SB.AppendLine('<div>Telefone: ' + QCab.DataSet.FieldByName('TELEFONE').AsString + '</div>');
    SB.AppendLine('</div>');
    SB.AppendLine('<div class="section">');
    SB.AppendLine('<h2>Itens</h2>');
    SB.AppendLine('<table>');
    SB.AppendLine('<tr><th>Descrição</th><th>Marca</th><th>Quantidade</th><th>Unitário</th><th>Total</th></tr>');
    QItens.DataSet.First;
    while not QItens.DataSet.Eof do
    begin
      SB.Append('<tr>');
      SB.Append('<td>' + QItens.DataSet.FieldByName('DESCRICAO').AsString + '</td>');
      SB.Append('<td>' + QItens.DataSet.FieldByName('MARCA').AsString + '</td>');
      SB.Append('<td>' + QItens.DataSet.FieldByName('QUANTIDADE').AsString + '</td>');
      SB.Append('<td>' + FormatFloat('0.00', QItens.DataSet.FieldByName('VALOR_UNITARIO').AsFloat) + '</td>');
      SB.Append('<td>' + FormatFloat('0.00', QItens.DataSet.FieldByName('VALOR_TOTAL_ITEM').AsFloat) + '</td>');
      SB.AppendLine('</tr>');
      QItens.DataSet.Next;
    end;
    SB.AppendLine('</table>');
    SB.AppendLine('</div>');
    SB.AppendLine('<div class="section total">Total: ' + FormatFloat('0.00', QCab.DataSet.FieldByName('VALOR_TOTAL').AsFloat) + '</div>');
    SB.AppendLine('</body>');
    SB.AppendLine('</html>');

    if aFilePath <> '' then
      TFile.WriteAllText(aFilePath, SB.ToString, TEncoding.UTF8);
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

end.

