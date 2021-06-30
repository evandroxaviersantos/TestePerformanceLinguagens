unit Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.DApt,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI;

type
  IConexao = interface
    ['{AAB7DAB1-16F8-4914-A8F4-F25CDCC09816}']
    function GetConexao: TFDConnection;
    function GetDriver: TFDPhysFBDriverLink;

    property Conexao: TFDConnection read GetConexao;
    property DriverFB: TFDPhysFBDriverLink read GetDriver;
  end;

  TConexao = class(TInterfacedObject, IConexao)
  private
    FConexao: TFDConnection;
    FDriver : TFDPhysFBDriverLink;
    FWaitCursor: TFDGUIxWaitCursor;
    procedure CriarConexao;
    procedure ConfigurarConexao;
  public
    function GetConexao: TFDConnection;
    function GetDriver: TFDPhysFBDriverLink;
  end;

implementation

{ TConexao }

function TConexao.GetConexao: TFDConnection;
begin
  CriarConexao;
  ConfigurarConexao;
  result := FConexao;
end;

function TConexao.GetDriver: TFDPhysFBDriverLink;
begin
  Result := FDriver;
end;

procedure TConexao.ConfigurarConexao;
begin
  FConexao.Params.Database := 'E:\Firebird\GIRO\AGRO.FDB';
  FConexao.Params.UserName := 'SYSDBA';
  FConexao.Params.Password := 'masterkey';
  FConexao.Params.DriverID := 'FB';
  FConexao.Params.Add('Server=127.0.0.1/3050');
  FConexao.Params.Add('Port=3050');
end;

procedure TConexao.CriarConexao;
begin
  FWaitCursor := TFDGUIxWaitCursor.Create(nil);
  FConexao := TFDConnection.Create(nil);
  FDriver := TFDPhysFBDriverLink.Create(nil);
end;

end.
