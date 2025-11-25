unit comercial.model.resource.interfaces;

interface

uses
  Data.DB;

type

  iQuery = interface
    ['{2C301581-2B46-4318-B344-E30883A1EB74}']
    function active(aValue: boolean): iQuery;
    function addParam(aParam: string; aValue: Variant): iQuery;
    function DataSet: TDataSet;
    function execSql(commit: boolean = True): iQuery;
    function open: iQuery;
    function sqlClear: iQuery;
    function sqlAdd(aValue: string): iQuery;
    function isEmpty: boolean;
    function eof: boolean;
    procedure next;
  end;

  iQueryFactory = interface
    ['{8F1A49E8-6D84-4E9E-8E3C-AD2F6A6D1B37}']
    function NewQuery: iQuery;
  end;

implementation

end.
