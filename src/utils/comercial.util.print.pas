unit comercial.util.print;

interface

type
  TPrintPedido = class
  public
    class procedure ImprimirPedido(aIdPedido: Integer); static;
  end;

implementation

uses
  System.SysUtils,
  Data.DB,
  Vcl.Printers,
  Vcl.Graphics,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

class procedure TPrintPedido.ImprimirPedido(aIdPedido: Integer);
var
  QCab, QItens: iQuery;
  x, y, lh, mx, my, pw: Integer;
  s: string;
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

  if QCab.DataSet.IsEmpty then Exit;

  QItens.active(False)
    .sqlClear
    .sqlAdd('select i.DESCRICAO, p.MARCA, i.QUANTIDADE, i.VALOR_UNITARIO, i.VALOR_TOTAL_ITEM')
    .sqlAdd('  from PEDIDO_ITENS i')
    .sqlAdd('  left join PRODUTO p on p.IDPRODUTO = i.IDPRODUTO')
    .sqlAdd(' where i.IDPEDIDO = :ID')
    .addParam('ID', aIdPedido)
    .open;

  Printer.BeginDoc;
  try
    mx := 100;
    my := 100;
    x := mx;
    y := my;
    lh := Printer.Canvas.TextHeight('Hg') + 6;
    pw := Printer.PageWidth - mx;

    s := 'Pedido ' + QCab.DataSet.FieldByName('IDPEDIDO').AsString;
    Printer.Canvas.Font.Style := [fsBold];
    Printer.Canvas.TextOut(x, y, s);
    y := y + lh;

    Printer.Canvas.Font.Style := [];
    Printer.Canvas.TextOut(x, y, 'Data: ' + DateTimeToStr(QCab.DataSet.FieldByName('DTEMISSAO').AsDateTime));
    y := y + lh;

    Printer.Canvas.Font.Style := [fsBold];
    Printer.Canvas.TextOut(x, y, 'Cliente');
    y := y + lh;
    Printer.Canvas.Font.Style := [];
    Printer.Canvas.TextOut(x, y, 'ID: ' + QCab.DataSet.FieldByName('IDCLIENTE').AsString);
    y := y + lh;
    Printer.Canvas.TextOut(x, y, 'Nome fantasia: ' + QCab.DataSet.FieldByName('NM_FANTASIA').AsString);
    y := y + lh;
    Printer.Canvas.TextOut(x, y, 'Razao social: ' + QCab.DataSet.FieldByName('RAZAO_SOCIAL').AsString);
    y := y + lh;
    Printer.Canvas.TextOut(x, y, 'CNPJ: ' + QCab.DataSet.FieldByName('CNPJ').AsString);
    y := y + lh;
    Printer.Canvas.TextOut(x, y, 'Endereco: ' + QCab.DataSet.FieldByName('ENDERECO').AsString);
    y := y + lh;
    Printer.Canvas.TextOut(x, y, 'Telefone: ' + QCab.DataSet.FieldByName('TELEFONE').AsString);
    y := y + lh * 2;

    Printer.Canvas.Font.Style := [fsBold];
    Printer.Canvas.TextOut(x, y, 'Itens');
    y := y + lh;
    Printer.Canvas.Font.Style := [];

    Printer.Canvas.TextOut(x, y, 'Descricao');
    Printer.Canvas.TextOut(x + 350, y, 'Marca');
    Printer.Canvas.TextOut(x + 550, y, 'Qtde');
    Printer.Canvas.TextOut(x + 650, y, 'Unit');
    Printer.Canvas.TextOut(x + 800, y, 'Total');
    y := y + lh;

    QItens.DataSet.First;
    while not QItens.DataSet.Eof do
    begin
      Printer.Canvas.TextOut(x, y, QItens.DataSet.FieldByName('DESCRICAO').AsString);
      Printer.Canvas.TextOut(x + 350, y, QItens.DataSet.FieldByName('MARCA').AsString);
      Printer.Canvas.TextOut(x + 550, y, QItens.DataSet.FieldByName('QUANTIDADE').AsString);
      Printer.Canvas.TextOut(x + 650, y, FormatFloat('0.00', QItens.DataSet.FieldByName('VALOR_UNITARIO').AsFloat));
      Printer.Canvas.TextOut(x + 800, y, FormatFloat('0.00', QItens.DataSet.FieldByName('VALOR_TOTAL_ITEM').AsFloat));
      y := y + lh;
      if y > Printer.PageHeight - my - lh then
      begin
        Printer.NewPage;
        y := my;
      end;
      QItens.DataSet.Next;
    end;

    y := y + lh;
    Printer.Canvas.Font.Style := [fsBold];
    Printer.Canvas.TextOut(x + 800, y, 'Total: ' + FormatFloat('0.00', QCab.DataSet.FieldByName('VALOR_TOTAL').AsFloat));

  finally
    Printer.EndDoc;
  end;
end;

end.

