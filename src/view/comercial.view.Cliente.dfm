object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 323
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 10
    Height = 13
    Caption = 'Id'
  end
  object Label2: TLabel
    Left = 96
    Top = 13
    Width = 71
    Height = 13
    Caption = 'Nome Fantasia'
  end
  object Label3: TLabel
    Left = 304
    Top = 13
    Width = 60
    Height = 13
    Caption = 'Raz'#227'o Social'
  end
  object Label4: TLabel
    Left = 8
    Top = 65
    Width = 48
    Height = 13
    Caption = 'CNPJ-CPF'
  end
  object Label5: TLabel
    Left = 164
    Top = 65
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object Label6: TLabel
    Left = 470
    Top = 65
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object edtId: TEdit
    Left = 8
    Top = 32
    Width = 80
    Height = 21
    TabOrder = 0
  end
  object edtFantasia: TEdit
    Left = 96
    Top = 32
    Width = 200
    Height = 21
    TabOrder = 1
  end
  object edtRazao: TEdit
    Left = 304
    Top = 32
    Width = 200
    Height = 21
    TabOrder = 2
  end
  object edtCnpj: TEdit
    Left = 8
    Top = 84
    Width = 150
    Height = 21
    TabOrder = 3
  end
  object edtEndereco: TEdit
    Left = 164
    Top = 84
    Width = 300
    Height = 21
    TabOrder = 4
  end
  object edtTelefone: TEdit
    Left = 468
    Top = 84
    Width = 120
    Height = 21
    TabOrder = 5
  end
  object btnSalvar: TButton
    Left = 637
    Top = 82
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = BtnSalvarClick
  end
  object btnEditar: TButton
    Left = 637
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 7
    OnClick = BtnEditarClick
  end
  object btnExcluir: TButton
    Left = 637
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 8
    OnClick = BtnExcluirClick
  end
  object Grid: TDBGrid
    Left = 0
    Top = 113
    Width = 631
    Height = 200
    DataSource = FDS
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FDS: TDataSource
    Left = 16
    Top = 560
  end
end
