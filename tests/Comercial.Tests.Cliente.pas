unit Comercial.Tests.Cliente;

interface

uses
  DUnitX.TestFramework,
  Data.DB,
  comercial.model.business.interfaces,
  comercial.model.business.Cliente,
  comercial.model.resource.interfaces,
  comercial.model.resource.impl.queryIBX;

type
  [TestFixture]
  TTestCliente = class
  private

  public
    [Setup]
    procedure Setup;
    [Test]
    procedure InsertUpdateDeleteCliente;
    [Test]
    procedure ShouldEnforceTelefoneTrigger;
  end;

implementation

uses
  System.SysUtils;

procedure TTestCliente.Setup;
begin

end;

procedure TTestCliente.InsertUpdateDeleteCliente;
var
  B: iModelBusinessCliente;
  id: Integer;
  Q: iQuery;
begin
  id := 0;

  Q := TModelResourceQueryIBX.New;
  B := TModelBusinessCliente.New;

  {}
  B.Salvar('Fantasia UT', 'Razao UT', '12.345.678/0001-95', 'End UT', '999');

  Q.active(False).sqlClear
  .sqlAdd('select max(IDCLIENTE) as ID from CLIENTE')
  .open;
  id := Q.DataSet.FieldByName('ID').AsInteger;

  Assert.IsTrue(id > 0);

  {}
  B.Editar(id, 'Fantasia UP', 'Razao UP', '12.345.678/0001-95', 'End UP', '888');
  Q.active(False).sqlClear
  .sqlAdd('select * from CLIENTE where IDCLIENTE = :ID')
  .addParam('ID', id).open;
  Assert.AreEqual('Fantasia UP', Q.DataSet.FieldByName('NM_FANTASIA').AsString);
  Assert.AreEqual('888', Q.DataSet.FieldByName('TELEFONE').AsString);

  {}
  B.Excluir(id);
  Q.active(False).sqlClear.sqlAdd('select 1 from CLIENTE where IDCLIENTE = :ID').addParam('ID', id).open;
  Assert.IsTrue(Q.DataSet.IsEmpty);
end;

procedure TTestCliente.ShouldEnforceTelefoneTrigger;
var
  Q: iQuery;
begin
  Q := TModelResourceQueryIBX.New;
  Assert.WillRaise(
    procedure
    begin
      Q.active(False).sqlClear
        .sqlAdd('insert into CLIENTE (IDCLIENTE, NM_FANTASIA, RAZAO_SOCIAL, CNPJ, ENDERECO, TELEFONE)')
        .sqlAdd('values ((select coalesce(max(IDCLIENTE),0)+1 from CLIENTE), ''X'', ''Y'', ''12.345.678/0001-95'', ''Z'', '''')')
        .execSql;
    end
  );
end;

end.
