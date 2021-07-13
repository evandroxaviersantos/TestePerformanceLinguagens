# Teste de Performance em diferentes linguagens de programação

## Metodologia
- Será medido o Troughput da API em todas as linguagens por um tempo de 60 segundos. Os testes foram executados 5 vezes em cada linguagem e foi obtido a média da execução com a seguinte fórmula:
```shell
(Resultado1 + Resultado2 + Resultado3 + Resultado4 + Resultado5) / 5
```

- Realizar requisições ping/pong. Ex:
Essas requisições Ping/Pong nos permitem testar um método padrão em todas as linguagens, o que dá uma boa base de performance da linguagem/framework.
```java
public String ping() {
  return "pong";
}
```

- Realizar cadastro de clientes


## Linguagens já implementadas:
- .NET 5.0 / C#
- Java Spring
- GoLang
- Delphi + Horse
- Delphi + Mormot


