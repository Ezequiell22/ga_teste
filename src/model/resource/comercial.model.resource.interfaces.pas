unit comercial.model.resource.interfaces;

interface

uses
  Data.DB;

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


  iResource = interface
    function Conexao: iConexao;

  end;

implementation

end.
