object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  object FDS: TDataSource
    Left = 16
    Top = 560
  end
  object edtId: TEdit
    Left = 8
    Top = 8
    Width = 80
    Height = 21
    TabOrder = 0
  end
  object edtFantasia: TEdit
    Left = 96
    Top = 8
    Width = 200
    Height = 21
    TabOrder = 1
  end
  object edtRazao: TEdit
    Left = 304
    Top = 8
    Width = 200
    Height = 21
    TabOrder = 2
  end
  object edtCnpj: TEdit
    Left = 8
    Top = 36
    Width = 150
    Height = 21
    TabOrder = 3
  end
  object edtEndereco: TEdit
    Left = 164
    Top = 36
    Width = 300
    Height = 21
    TabOrder = 4
  end
  object edtTelefone: TEdit
    Left = 468
    Top = 36
    Width = 120
    Height = 21
    TabOrder = 5
  end
  object btnNovo: TButton
    Left = 8
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 6
    OnClick = BtnNovoClick
  end
  object btnSalvar: TButton
    Left = 88
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 7
    OnClick = BtnSalvarClick
  end
  object btnEditar: TButton
    Left = 168
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 8
    OnClick = BtnEditarClick
  end
  object btnExcluir: TButton
    Left = 248
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 9
    OnClick = BtnExcluirClick
  end
  object Grid: TDBGrid
    Left = 0
    Top = 200
    Width = 800
    Height = 400
    Align = alBottom
    DataSource = FDS
    TabOrder = 10
  end
end
