# Teste de Performance em diferentes linguagens de programação

## Metodologia
- Será medido o Troughput da API em todas as linguagens por um tempo de 60 segundos. Os testes foram executados 5 vezes em cada linguagem e foi obtido a média da execução com a seguinte fórmula:
<img align="center" alt="Formula" src="http://www.sciweavers.org/tex2img.php?eq=\frac%20{r1%20%2B%20r2%20%2B%20r3%20%2B%20r4%20%2B%20r5}%20{5}&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=">  


- Realizar requisições ping/pong. Ex:
Essas requisições Ping/Pong nos permitem testar um método padrão em todas as linguagens
```java
public String ping() {
  return "pong";
}
```

### Requisições Get - 60 segundos executando.

- No Java estou enfrentando um problema pois o mesmo consegue utilizar 100% do CPU por aproximadamente 40 segundos do teste, após isso a JVM para de "escalar" a API e o Throughput cai consideravelmente. Quando conseguir solucionar esse problema estarei atualizando os dados.

<img width="667" alt="Ping Pong API" src="https://user-images.githubusercontent.com/3423282/125724080-aa69fc49-e1b4-455a-b861-7303ddc841af.png">


## Novas linguagens serão adicionadas aos poucos ao projeto de teste de performance.

- Quer contribuir? Você pode! É só implementar sua API com a requisição "Ping/Pong" conforme descrito acima e enviar um Pull Request.



## Linguagens já implementadas:
- .NET 5.0 / C#
- Java Spring
- GoLang
- Delphi + Mormot


