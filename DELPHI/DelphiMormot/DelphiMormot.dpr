program DelphiMormot;

{$APPTYPE CONSOLE}

uses
  System.JSON,
  REST.Json,
  SysUtils,
  SynCommons,
  SynCrtSock,
  mORMot,
  mORMotHttpServer,
  SynDBFireDAC,
  SynDB,
  mORMotDB,
  Cliente in 'Cliente.pas',
  ClienteRepository in 'ClienteRepository.pas',
  Conexao in 'Conexao.pas';

type
  TMyServices = class(TSynPersistent)
  published
    procedure ping(ctxt: TSQLRestServerURIContext);
    procedure clientes(ctxt: TSQLRestServerURIContext);
    procedure clientesMormot(ctxt: TSQLRestServerURIContext);
  end;
var
  FoFirebirdDB: TSQLDBConnectionPropertiesThreadSafe;
  porta: AnsiString;
  aRestServer: TSQLRestServer;
{ TMyServices }
procedure TMyServices.clientes(ctxt: TSQLRestServerURIContext);
begin
  if ctxt.Method = TSQLURIMethod.mGET then
    ctxt.Returns(TJson.ObjectToJsonString(TClienteRepository.new().RetornarCliente), STATUS_SUCCESS)
  else //if ctxt.Method = TSQLURIMethod.mPost then
    begin
      if TClienteRepository.new().GravarCliente(ctxt.Call.InBody) then
        ctxt.Returns(ctxt.Call.InBody, STATUS_SUCCESS)
      else
        ctxt.Returns('', STATUS_BADREQUEST);
    end;
end;

procedure TMyServices.clientesMormot(ctxt: TSQLRestServerURIContext);
var
  oCliente : TCliente;
const
  SQLInsert: String = 'INSERT INTO CLIENTEFB' + sLineBreak +
                      '(nome, endereco, cpf) VALUES' + sLineBreak +
                      '(?, ?, ?)';
begin

  if ctxt.Method = TSQLURIMethod.mGET then
    ctxt.Returns(FoFirebirdDB.Execute('SELECT * FROM CLIENTEFB',[]).FetchAllAsJSON(true))
  else if ctxt.Method = TSQLURIMethod.mPost then
    begin
    oCliente := TJson.JsonToObject<TCliente>(ctxt.Call.InBody);
    FoFirebirdDB.ExecuteNoResult(SQLInsert, [oCliente.Nome, ocliente.Endereco, oCliente.Cpf]);
    ctxt.Returns(ctxt.Call.InBody, STATUS_SUCCESS);
  end;

end;

procedure TMyServices.ping(ctxt: TSQLRestServerURIContext);
begin
  ctxt.Returns('pong', STATUS_SUCCESS);
end;

procedure CriarServidor(const porta: AnsiString; const nome: RawUTF8);
var
  aHttpServer: TSQLHttpServer;
  aServices: TMyServices;
begin
  aRestServer := TSQLRestServer.CreateWithOwnModel([],false, nome); // authentication=false
  try
    aServices := TMyServices.Create();
    aRestServer.ServiceMethodRegisterPublishedMethods('', aServices);
    try
      aHttpServer := TSQLHttpServer.Create(porta,[aRestServer], '+', HTTP_DEFAULT_MODE, 100);
      try
        aHttpServer.AccessControlAllowOrigin := '*'; // allow cross-site AJAX queries
        writeln('Servidor está ativo na porta: ', porta);
        writeln('Press [Enter] to close the server.');
        readln;
      finally
        aHttpServer.Free;
      end;
    finally
      aServices.Free;
    end;
  finally
    FreeAndNil(aRestServer);
  end;
end;

procedure CriarConexao(AcBanco: RawUTF8);
begin
  FoFirebirdDB := TSQLDBFireDACConnectionProperties.Create(
                  FIREDAC_PROVIDER[dFirebird],
                  AcBanco,
                  'sysdba',
                  'masterkey');
end;

begin
  porta := '8888';
  CriarConexao('D:\ZREDE\TestesDesenvolvimento\TestePerformance\DelphiMormot\AGRO.FDB');
  CriarServidor(porta,'api');
end.
