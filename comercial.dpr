program comercial;

uses
  Vcl.Forms,
  comercial.view.index in 'src\view\comercial.view.index.pas' {frmIndex},
  comercial.controller.interfaces in 'src\controller\comercial.controller.interfaces.pas',
  comercial.controller in 'src\controller\comercial.controller.pas',
  comercial.controller.entity in 'src\controller\comercial.controller.entity.pas',
  comercial.controller.business in 'src\controller\comercial.controller.business.pas',
  comercial.model.business.interfaces in 'src\model\business\comercial.model.business.interfaces.pas',
  comercial.model.resource.interfaces in 'src\model\resource\comercial.model.resource.interfaces.pas',
  comercial.model.resource.impl.queryIBX in 'src\model\resource\impl\comercial.model.resource.impl.queryIBX.pas',
  comercial.model.types.Db in 'src\model\types\comercial.model.types.Db.pas',
  comercial.model.db.migrations in 'src\model\db\comercial.model.db.migrations.pas',
  comercial.model.entity.cadCliente in 'src\model\entity\comercial.model.entity.cadCliente.pas',
  comercial.model.entity.cadProduto in 'src\model\entity\comercial.model.entity.cadProduto.pas',
  comercial.model.DAO.CadCliente in 'src\model\DAO\comercial.model.DAO.CadCliente.pas',
  comercial.model.DAO.CadProduto in 'src\model\DAO\comercial.model.DAO.CadProduto.pas',
  comercial.model.business.Pedido in 'src\model\business\comercial.model.business.Pedido.pas',
  comercial.model.business.RelatorioProdutos in 'src\model\business\comercial.model.business.RelatorioProdutos.pas',
  comercial.view.Cliente in 'src\view\comercial.view.Cliente.pas',
  comercial.view.Produto in 'src\view\comercial.view.Produto.pas',
  comercial.view.Pedido in 'src\view\comercial.view.Pedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  with TDbMigrations.Create('C:\testeEmpresa\DADOS.FDB','SYSDBA','masterkey') do
  try
    Apply;
  finally
    Free;
  end;
  Application.CreateForm(TfrmIndex, frmIndex);
  Application.Run;
end.
