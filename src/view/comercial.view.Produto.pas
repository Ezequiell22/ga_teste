unit comercial.view.Produto;

interface

uses System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.DBGrids, Data.DB,
  comercial.controller,
  comercial.controller.interfaces, Vcl.Controls, Vcl.Grids;

type
  TfrmProduto = class(TForm)
  published
    FController: iController;
    FDS: TDataSource;
    edtId: TEdit;
    edtDescricao: TEdit;
    edtMarca: TEdit;
    edtPreco: TEdit;
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

uses
  Vcl.Dialogs;

{$R *.dfm}

constructor TfrmProduto.Create(AOwner: TComponent);
begin
  inherited;
  FController := TController.New;
  FController.entity.cadProduto.Bind(FDS).Get;
end;

destructor TfrmProduto.Destroy;
begin
  inherited;
end;

function ValidateProdutoInputs(AOwner: TfrmProduto): Boolean;
var P: Double;
begin
  Result := False;
  if Trim(AOwner.edtDescricao.Text) = '' then begin ShowMessage('Descricao obrigatoria'); Exit; end;
  P := StrToFloatDef(AOwner.edtPreco.Text, -1);
  if P < 0 then begin ShowMessage('Preco deve ser numero maior ou igual a zero'); Exit; end;
  Result := True;
end;

procedure TfrmProduto.BtnNovoClick(Sender: TObject);
begin
  edtId.Text := '';
  edtDescricao.Text := '';
  edtMarca.Text := '';
  edtPreco.Text := '';
end;

procedure TfrmProduto.BtnSalvarClick(Sender: TObject);
begin
  if not ValidateProdutoInputs(Self) then Exit;
  FController.entity.cadProduto.Salvar(edtDescricao.Text, edtMarca.Text, StrToFloatDef(edtPreco.Text, 0));
end;

procedure TfrmProduto.BtnEditarClick(Sender: TObject);
begin
  if not ValidateProdutoInputs(Self) then Exit;
  FController.entity.cadProduto.Editar(FDS.DataSet.FieldByName('IDPRODUTO').AsInteger, edtDescricao.Text, edtMarca.Text, StrToFloatDef(edtPreco.Text, 0));
end;

procedure TfrmProduto.BtnExcluirClick(Sender: TObject);
begin
  FController.entity.cadProduto.Excluir(FDS.DataSet.FieldByName('IDPRODUTO').AsInteger);
end;

end.
