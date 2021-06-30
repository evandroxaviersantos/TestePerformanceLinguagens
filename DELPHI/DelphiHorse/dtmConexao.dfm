object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 189
  Width = 257
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\Firebird\GIRO\AGRO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    Left = 48
    Top = 24
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 136
    Top = 88
  end
end
