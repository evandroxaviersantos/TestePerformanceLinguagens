program DelphiHorse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.JSON,
  REST.Json,
  Cliente in 'Cliente.pas',
  ClienteRepository in 'ClienteRepository.pas',
  dtmConexao in 'dtmConexao.pas' {DataModule1: TDataModule},
  Conexao in 'Conexao.pas', Horse.Commons;

begin
  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

  THorse.Get('/api/clientes',
     procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
     begin
       Res.Status(THTTPStatus.OK).Send(TJson.ObjectToJsonString(TClienteRepository.New().RetornarCliente));
     end);

  THorse.Post('/api/clientes',
     procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
     begin
       if TClienteRepository.New().GravarCliente(Req.Body) then
         Res.Status(THTTPStatus.Created).Send(Req.Body)
       else
         Res.Status(THTTPStatus.BadRequest);
     end);

  THorse.Listen(9001);
end.
