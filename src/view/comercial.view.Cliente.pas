unit comercial.view.Cliente;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls,
  Data.DB,
  comercial.controller,
  comercial.controller.interfaces, Vcl.Controls, Vcl.Grids;

type
  TfrmCliente = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtId: TEdit;
    edtFantasia: TEdit;
    edtRazao: TEdit;
    edtCnpj: TEdit;
    edtEndereco: TEdit;
    edtTelefone: TEdit;
    dts2: TDataSource;
    procedure FormShow(Sender: TObject);
  published
    FController: iController;
    btnSalvar: TButton;
    procedure BtnSalvarClick(Sender: TObject);
  private
    procedure LoadData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  Vcl.Dialogs;

{$R *.dfm}

constructor TfrmCliente.Create(AOwner: TComponent);
begin
  inherited;
  FController := TController.New;
  FController.business.Cliente.Bind(dts2);
end;

destructor TfrmCliente.Destroy;
begin
  inherited;
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  FController.business.Cliente.GetById(strTointdef(edtId.Text, 0));
  LoadData;
  edtFantasia.SetFocus;
end;

procedure TfrmCliente.LoadData;
begin

  if not dts2.DataSet.Active then
    exit;

  edtId.Text := dts2.DataSet.FieldByName('IDCLIENTE').AsString;
  edtFantasia.Text := dts2.DataSet.FieldByName('NM_FANTASIA').AsString;
  edtRazao.Text := dts2.DataSet.FieldByName('RAZAO_SOCIAL').AsString;
  edtCnpj.Text := dts2.DataSet.FieldByName('CNPJ').AsString;
  edtEndereco.Text := dts2.DataSet.FieldByName('ENDERECO').AsString;
  edtTelefone.Text := dts2.DataSet.FieldByName('TELEFONE').AsString;

end;

function ValidateClienteInputs(AOwner: TfrmCliente): Boolean;
var
  Doc: string;
  Dig: string;
begin
  Result := False;
  if Trim(AOwner.edtFantasia.Text) = '' then
  begin
    ShowMessage('Nome fantasia obrigatorio');
    exit;
  end;
  if Trim(AOwner.edtRazao.Text) = '' then
  begin
    ShowMessage('Razao social obrigatoria');
    exit;
  end;
  if Trim(AOwner.edtTelefone.Text) = '' then
  begin
    ShowMessage('Telefone obrigatorio');
    exit;
  end;

  Result := True;
end;

procedure TfrmCliente.BtnSalvarClick(Sender: TObject);
begin
  if not ValidateClienteInputs(Self) then
    exit;

  if Trim(edtId.Text) = EmptyStr then
  begin
    FController.business.Cliente.Salvar( edtFantasia.Text, edtRazao.Text,
      edtCnpj.Text, edtEndereco.Text, edtTelefone.Text);
  end
  else
    FController.business.Cliente.Editar(dts2.DataSet.FieldByName('IDCLIENTE')
      .AsInteger, edtFantasia.Text, edtRazao.Text, edtCnpj.Text,
      edtEndereco.Text, edtTelefone.Text);

  self.Close;
end;

end.
