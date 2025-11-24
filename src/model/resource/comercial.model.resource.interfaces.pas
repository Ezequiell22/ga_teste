unit comercial.model.resource.interfaces;

interface

uses
  Data.DB,
  comercial.model.types.Db;

type
  iConexao = interface
    function Connect: TCustomConnection;
  end;

  iQuery = interface
    function active(aValue: boolean): iQuery;
    function addParam(aParam: string; aValue: Variant)
      : iQuery;
    function DataSet: TDataSet;
    function execSql( commit : Boolean = True): iQuery;
    function open: iQuery;
    function sqlClear: iQuery;
    function sqlAdd(aValue: string): iQuery;
    function isEmpty: boolean;
    function eof: boolean;
    procedure next;
  end;

  iConfiguracao = interface
    function DriverID(Value: String): iConfiguracao; overload;
    function DriverID: String; overload;
    function Database(Value: TDataBaseType): iConfiguracao; overload;
    function Database: TDataBaseType; overload;
    function DatabaseStr : String;
    function UserName(Value: String): iConfiguracao; overload;
    function UserName: String; overload;
    function Password(Value: String): iConfiguracao; overload;
    function Password: String; overload;
    function Port(Value: String): iConfiguracao; overload;
    function Port: String; overload;
    function Server(Value: String): iConfiguracao; overload;
    function Server: String; overload;
    function Schema(Value: String): iConfiguracao; overload;
    function Schema: String; overload;
    function Locking(Value: String): iConfiguracao; overload;
    function Locking: String; overload;
    function ModeDev : Boolean;
    function Instance(instance : TDataBaseType ) : iConfiguracao;
  end;

  iResource = interface
    function Conexao: iConexao;

  end;

implementation

end.
