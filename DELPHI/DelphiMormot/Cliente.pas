unit Cliente;

interface

type
  TCliente = class
  private
    FCpf: string;
    FId: Integer;
    FNome: string;
    FEndereco: string;
    procedure SetCpf(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
  public
  published
    property Id: Integer read FId write SetId;
    property Nome: string read FNome write SetNome;
    property Endereco: string read FEndereco write SetEndereco;
    property Cpf: string read FCpf write SetCpf;
  end;

  ClienteArray = array of TCliente;

  TClienteArray = class
  private

  public
    FoClienteArray: ClienteArray;
    procedure SetoClienteArray(const Value: ClienteArray);
    property oClienteArray: ClienteArray read FoClienteArray write SetoClienteArray;
  end;

implementation

{ TCliente }

procedure TCliente.SetCpf(const Value: string);
begin
  FCpf := Value;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TClienteArray }

procedure TClienteArray.SetoClienteArray(const Value: ClienteArray);
begin
  FoClienteArray := Value;
end;

end.
