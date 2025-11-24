unit comercial.view.index;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  comercial.controller.interfaces;

type
  TfrmIndex = class(Tform)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    MenuCadastros: TMenuItem;
    MenuClientes: TMenuItem;
    MenuProdutos: TMenuItem;
    MenuPedidos: TMenuItem;
    MenuRelatorio: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuClientesClick(Sender: TObject);
    procedure MenuProdutosClick(Sender: TObject);
    procedure MenuPedidosClick(Sender: TObject);
    procedure MenuRelatorioClick(Sender: TObject);
  private
    Fcontroller: iController;
    CloseForm: Word;
    MutexHandle: THandle;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  public
  end;

var
  frmIndex: TfrmIndex;

implementation

{$R *.dfm}

uses
  System.UITypes, comercial.controller,
  comercial.view.Cliente,
  comercial.view.Produto,
  comercial.view.Pedido,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  comercial.controller.interfaces;

procedure TfrmIndex.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin

  if (Msg.message = WM_KEYDOWN) or (Msg.message = WM_COMMAND) or
    (Msg.message = WM_MOUSEMOVE) then
  begin
    CloseForm := 0;
    Handled := FALSE;
  end;

  if (Msg.message = WM_KEYDOWN) and (GetKeyState(VK_CONTROL) < 0) and
    (Msg.wParam = VK_DELETE) then
  begin
    Handled := True;
  end;

end;

procedure TfrmIndex.MenuClientesClick(Sender: TObject);
begin
  inherited;
  with TfrmCliente.Create(self) do
  try ShowModal; finally Free; end;
end;

procedure TfrmIndex.FormCreate(Sender: TObject);
var
  numberVersion, dateVersion: string;
begin
  try
    MutexHandle := CreateMutex(nil, True, 'AppDelphiComercial');
    if (MutexHandle = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
      raise Exception.Create('O aplicativo j� est� em execu��o.');

    SystemParametersInfo(SPI_SETBEEP, 0, nil, SPIF_SENDWININICHANGE);

    numberVersion := '1';
    dateVersion := '28/11/2024';

    self.Caption := 'M�dulo Comercial | Vers�o liberada ' + numberVersion +
      '  | Data ' + dateVersion;
  except
    on e: Exception do
      showMessage(e.message)
  end;
end;

procedure TfrmIndex.FormDestroy(Sender: TObject);
begin
  inherited;
  if MutexHandle <> 0 then
    CloseHandle(MutexHandle);
end;

procedure TfrmIndex.FormShow(Sender: TObject);
begin
  inherited;
  CloseForm := 0;
  application.OnMessage := AppMessage;

  StatusBar1.Panels[0].Width := 200;
  StatusBar1.Panels[1].Width := 200;

  Fcontroller := TController.new;
  StatusBar1.Panels[0].Text := 'Pedidos de Venda';
  StatusBar1.Panels[1].Text := '';

end;

end.
procedure TfrmIndex.MenuProdutosClick(Sender: TObject);
begin
  inherited;
  with TfrmProduto.Create(self) do
  try ShowModal; finally Free; end;
end;

procedure TfrmIndex.MenuPedidosClick(Sender: TObject);
begin
  inherited;
  with TfrmPedido.Create(self) do
  try ShowModal; finally Free; end;
end;

procedure TfrmIndex.MenuRelatorioClick(Sender: TObject);
begin
  inherited;
  var frm := TForm.Create(Self);
  try
    frm.Caption := 'Top Produtos Vendidos';
    frm.Width := 700; frm.Height := 500;
    var ds := TDataSource.Create(frm);
    var grid := TDBGrid.Create(frm); grid.Parent := frm; grid.Align := alClient; grid.DataSource := ds;
    var pnl := TPanel.Create(frm); pnl.Parent := frm; pnl.Align := alTop; pnl.Height := 40;
    var dtIni := TDateTimePicker.Create(frm); dtIni.Parent := pnl; dtIni.Left := 8; dtIni.Top := 8;
    var dtFim := TDateTimePicker.Create(frm); dtFim.Parent := pnl; dtFim.Left := 180; dtFim.Top := 8;
    var btn := TButton.Create(frm); btn.Parent := pnl; btn.Left := 360; btn.Top := 8; btn.Caption := 'Gerar';
    Fcontroller.business.RelatorioProdutos.LinkDataSource(ds);
    btn.OnClick := procedure(Sender: TObject)
    begin
      Fcontroller.business.RelatorioProdutos.Gerar(dtIni.Date, dtFim.Date);
    end;
    frm.Position := poScreenCenter;
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;
