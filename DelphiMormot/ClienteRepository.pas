unit ClienteRepository;

interface

uses
  Cliente, System.JSON, REST.Json,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Phys.PG, FireDAC.Phys.PGDef,FireDAC.DApt,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
  IClienteRepository = interface
    ['{2D745C0D-7389-4B8C-8F44-74513E12C7C3}']
    function GravarCliente(AoJson: String): Boolean;
    function RetornarCliente: TClienteArray;
  end;

  TClienteRepository = class(TInterfacedObject, IClienteRepository)
  private

  public
    function GravarCliente(AoJson: String): Boolean;
    function RetornarCliente: TClienteArray;
    class function New:IClienteRepository;
  end;

implementation

uses
  Conexao, FireDAC.Comp.Client, FireDAC.Comp.UI;

{ TClienteRepository }


function TClienteRepository.GravarCliente(AoJson: String): boolean;
var
  oCliente   : TCliente;
  oConexao   : IConexao;
  oQuery     : TFDQuery;
  const
    SQLInsert: String = 'INSERT INTO CLIENTEFB' + sLineBreak +
                                   '(nome, endereco, cpf) VALUES' + sLineBreak +
                                   '(:nome, :endereco, :cpf)';

begin
  oConexao := TConexao.Create;
  oQuery := TFDQuery.Create(Nil);
  try
    oQuery.Connection := oConexao.Conexao;

    oCliente := TJson.JsonToObject<TCliente>(AoJson);

    oQuery.SQL.Add(SQLInsert);
    oQuery.ParamByName('nome').AsString := oCliente.Nome;
    oQuery.ParamByName('endereco').AsString := oCliente.Endereco;
    oQuery.ParamByName('cpf').AsString := oCliente.Cpf;
    oQuery.ExecSQL;
    oConexao.Conexao.Commit;
    Result := System.True;
  finally
    oCliente := nil;
    FreeAndNil(oQuery);
    oConexao.MatarConexao;
  end;
end;

class function TClienteRepository.New: IClienteRepository;
begin
  Result := TClienteRepository.Create;
end;

function TClienteRepository.RetornarCliente: TClienteArray;
var
  oClienteArray: ClienteArray;
  oConexao   : IConexao;
  oQuery     : TFDQuery;
  i: Integer;
  const
    SQLSelect: String = 'SELECT * FROM CLIENTEFB';
begin
  oConexao := TConexao.Create;
  oQuery := TFDQuery.Create(Nil);
  TRY
    oQuery.Connection := oConexao.Conexao;
    oQuery.SQL.Add(SQLSelect);
    oQuery.Open();
    oQuery.FetchAll;

    Result := TClienteArray.Create;
    i := 0;
    SetLength(oClienteArray, oQuery.RecordCount);
    while not oQuery.Eof do
      begin
      oClienteArray[i]:= TCliente.Create;
      oClienteArray[i].Id       := oQuery.FieldByName('ID').AsInteger;
      oClienteArray[i].Nome     := oQuery.FieldByName('Nome').AsString;
      oClienteArray[i].Endereco := oQuery.FieldByName('Endereco').AsString;
      oClienteArray[i].Cpf      := oQuery.FieldByName('Cpf').AsString;
      oQuery.Next;
      Inc(i);
    end;
    Result.FoClienteArray := oClienteArray;
  FINALLY
    FreeAndNil(oQuery);
    oConexao.MatarConexao;
  END;
end;

end.
