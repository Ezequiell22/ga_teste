unit comercial.view.Cliente;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.DBGrids, Data.DB,
  comercial.controller,
  comercial.controller.interfaces;

type
  TfrmCliente = class(TForm)
  published
    FController: iController;
    FDS: TDataSource;
    edtId: TEdit;
    edtFantasia: TEdit;
    edtRazao: TEdit;
    edtCnpj: TEdit;
    edtEndereco: TEdit;
    edtTelefone: TEdit;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    Grid: TDBGrid;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

$R *.dfm

constructor TfrmCliente.Create(AOwner: TComponent);
begin
  inherited;
  FController := TController.New;
  FController.entity.cadCliente.Bind(FDS).Get;
end;

destructor TfrmCliente.Destroy;
begin
  inherited;
end;

function DigitsOnly(const S: string): string;
var I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if CharInSet(S[I], ['0'..'9']) then
      Result := Result + S[I];
end;

function IsAllSame(const S: string): Boolean;
var I: Integer;
begin
  Result := True;
  for I := 2 to Length(S) do
    if S[I] <> S[1] then
    begin
      Result := False;
      Exit;
    end;
end;

function IsValidCPF(const S: string): Boolean;
var D: string; I, Sum, R, D1, D2: Integer;
begin
  D := DigitsOnly(S);
  if Length(D) <> 11 then
  begin Result := False; Exit; end;
  if IsAllSame(D) then
  begin Result := False; Exit; end;
  Sum := 0;
  for I := 1 to 9 do Sum := Sum + StrToInt(D[I]) * (10 - I);
  R := Sum mod 11; if R < 2 then D1 := 0 else D1 := 11 - R;
  Sum := 0;
  for I := 1 to 10 do Sum := Sum + StrToInt(D[I]) * (11 - I);
  R := Sum mod 11; if R < 2 then D2 := 0 else D2 := 11 - R;
  Result := (StrToInt(D[10]) = D1) and (StrToInt(D[11]) = D2);
end;

function IsValidCNPJ(const S: string): Boolean;
const W1: array[1..12] of Integer = (5,4,3,2,9,8,7,6,5,4,3,2);
      W2: array[1..13] of Integer = (6,5,4,3,2,9,8,7,6,5,4,3,2);
var D: string; I, Sum, R, D1, D2: Integer;
begin
  D := DigitsOnly(S);
  if Length(D) <> 14 then
  begin Result := False; Exit; end;
  if IsAllSame(D) then
  begin Result := False; Exit; end;
  Sum := 0;
  for I := 1 to 12 do Sum := Sum + StrToInt(D[I]) * W1[I];
  R := Sum mod 11; if R < 2 then D1 := 0 else D1 := 11 - R;
  Sum := 0;
  for I := 1 to 13 do Sum := Sum + StrToInt(D[I]) * W2[I];
  R := Sum mod 11; if R < 2 then D2 := 0 else D2 := 11 - R;
  Result := (StrToInt(D[13]) = D1) and (StrToInt(D[14]) = D2);
end;

function ValidateClienteInputs(AOwner: TfrmCliente): Boolean;
var Doc: string; Dig: string;
begin
  Result := False;
  if Trim(AOwner.edtFantasia.Text) = '' then begin ShowMessage('Nome fantasia obrigatorio'); Exit; end;
  if Trim(AOwner.edtRazao.Text) = '' then begin ShowMessage('Razao social obrigatoria'); Exit; end;
  if Trim(AOwner.edtTelefone.Text) = '' then begin ShowMessage('Telefone obrigatorio'); Exit; end;
  Doc := Trim(AOwner.edtCnpj.Text);
  Dig := DigitsOnly(Doc);
  if (Length(Dig) = 11) then
  begin if not IsValidCPF(Doc) then begin ShowMessage('CPF invalido'); Exit; end; end
  else if (Length(Dig) = 14) then
  begin if not IsValidCNPJ(Doc) then begin ShowMessage('CNPJ invalido'); Exit; end; end
  else begin ShowMessage('Documento deve ser CPF (11 digitos) ou CNPJ (14)'); Exit; end;
  Result := True;
end;

procedure TfrmCliente.BtnNovoClick(Sender: TObject);
begin
  edtId.Text := '';
  edtFantasia.Text := '';
  edtRazao.Text := '';
  edtCnpj.Text := '';
  edtEndereco.Text := '';
  edtTelefone.Text := '';
end;

procedure TfrmCliente.BtnSalvarClick(Sender: TObject);
begin
  if not ValidateClienteInputs(Self) then Exit;
  FController.entity.cadCliente.Salvar(StrToIntDef(edtId.Text, 0), edtFantasia.Text, edtRazao.Text, edtCnpj.Text, edtEndereco.Text, edtTelefone.Text);
end;

procedure TfrmCliente.BtnEditarClick(Sender: TObject);
begin
  if not ValidateClienteInputs(Self) then Exit;
  FController.entity.cadCliente.Editar(FDS.DataSet.FieldByName('IDCLIENTE').AsInteger, edtFantasia.Text, edtRazao.Text, edtCnpj.Text, edtEndereco.Text, edtTelefone.Text);
end;

procedure TfrmCliente.BtnExcluirClick(Sender: TObject);
begin
  FController.entity.cadCliente.Excluir(FDS.DataSet.FieldByName('IDCLIENTE').AsInteger);
end;

end.
