unit comercial.controller.business;

interface

uses
  comercial.controller.interfaces,
  comercial.model.business.interfaces,
  comercial.model.resource.interfaces,
  comercial.model.DAO.interfaces,
  comercial.model.business.Pedido,
  comercial.model.business.RelatorioProdutos,
  comercial.model.db.migrations,
  System.IniFiles,
  System.SysUtils;

type
  TControllerBusiness = class(TInterfacedObject, iControllerBusiness)
  private
    FPedido: iModelBusinessPedido;
    FRelatorio: iModelBusinessRelatorioProdutos;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerBusiness;
    function Pedido: iModelBusinessPedido;
    function RelatorioProdutos: iModelBusinessRelatorioProdutos;
  end;

implementation


{ TControllerBusiness }

constructor TControllerBusiness.create;
begin
  try
    var iniPath := ExtractFilePath(ParamStr(0)) + 'comercial.ini';
    var ini := TIniFile.Create(iniPath);
    try
      var dbPath := ini.ReadString('Database', 'Path', 'C:\\testeEmpresa\\DADOS.FDB');
      var dbUser := ini.ReadString('Database', 'User', 'SYSDBA');
      var dbPass := ini.ReadString('Database', 'Password', 'masterkey');
      var Mig := TDbMigrations.Create(dbPath, dbUser, dbPass);
      try
        Mig.Apply;
      finally
        Mig.Free;
      end;
    finally
      ini.Free;
    end;
    try
    except
    end;
  except
  end;
end;

destructor TControllerBusiness.destroy;
begin

  inherited;
end;

function TControllerBusiness.Pedido: iModelBusinessPedido;
begin
  if not assigned(FPedido) then
    FPedido := TModelBusinessPedido.New;
  result := FPedido;
end;

function TControllerBusiness.RelatorioProdutos: iModelBusinessRelatorioProdutos;
begin
  if not assigned(FRelatorio) then
    FRelatorio := TModelBusinessRelatorioProdutos.New;
  result := FRelatorio;
end;

class function TControllerBusiness.New: iControllerBusiness;
begin
  result := Self.create;
end;


end.
