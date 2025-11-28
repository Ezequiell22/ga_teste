program comercial_dunitx_tests;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  Comercial.Tests.Migrations in 'Comercial.Tests.Migrations.pas',
  Comercial.Tests.Cliente in 'Comercial.Tests.Cliente.pas',
  Comercial.Tests.Produto in 'Comercial.Tests.Produto.pas',
  Comercial.Tests.Pedido in 'Comercial.Tests.Pedido.pas',
  Comercial.Tests.RelatorioHTML in 'Comercial.Tests.RelatorioHTML.pas';

var
  Runner: ITestRunner;
  Results: IRunResults;

begin
  ReportMemoryLeaksOnShutdown := True;

  TDUnitX.RegisterTestFixture(TTestMigrations);
  TDUnitX.RegisterTestFixture(TTestCliente);
  TDUnitX.RegisterTestFixture(TTestProduto);
  TDUnitX.RegisterTestFixture(TTestPedido);
  TDUnitX.RegisterTestFixture(TTestRelatorioHTML);

  Runner := TDUnitX.CreateRunner;
  Runner.AddLogger(TDUnitXConsoleLogger.Create(True));
  Runner.UseRTTI := True;
  Results := Runner.Execute;

  if Results.AllPassed then
    System.ExitCode := 0
  else
    System.ExitCode := 1;
end.
