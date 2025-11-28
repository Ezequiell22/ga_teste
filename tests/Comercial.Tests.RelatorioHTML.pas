unit Comercial.Tests.RelatorioHTML;

interface

uses
  DUnitX.TestFramework,
  comercial.util.printhtml,
  comercial.model.db.migrations;

type
  [TestFixture]
  TTestRelatorioHTML = class
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure ShouldGenerateTopProdutosHTML;
  end;

implementation

uses
  System.SysUtils;

procedure TTestRelatorioHTML.Setup;
begin
  TDbMigrations.Create.Apply;
end;

procedure TTestRelatorioHTML.ShouldGenerateTopProdutosHTML;
var
  S: string;
begin
  S := TPrintHtmlPedido.GerarRelatorioTopProdutos(Now - 30, Now, '');
  Assert.IsTrue(S <> '');
  Assert.IsTrue(Pos('<html', S) > 0);
  Assert.IsTrue(Pos('Top Produtos Vendidos', S) > 0);
end;

end.
