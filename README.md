

# Projeto Prático: Otimização de uma imagem GoLang

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Go_Logo_Blue.svg/200px-Go_Logo_Blue.svg.png" alt="GoLang" width="20"/> Descrição do Projeto

Este projeto tem como objetivo criar uma imagem Docker otimizada para uma aplicação em GoLang que exibe a mensagem `Full Cycle Rocks!!` quando executada.

## Utilizando Multi-Stage Build para compilar a aplicação e otimizar a imagem

### Dockerfile

```Dockerfile
# Estágio 1: Compilação
FROM golang:1.12.16-alpine AS builder

WORKDIR /app

COPY main.go .

RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o /app/app main.go

# Estágio 2: Imagem final
FROM scratch

WORKDIR /app

COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]
````

## Inserindo alguns parâmetros para o linker via -ldflags
Parâmetros para o Linker
Os parâmetros para o linker ajudarão a diminuir o tamanho do executável final. -ldflags '-s -w'

O parâmetro -s remove informações de debug do executável e o -w impede a geração do DWARF (Debugging With Attributed Record Formats).

## Build
```shell
docker build -t joseaugustoss/fullcyle . 
````
## Run
```shell
docker run -p 8080:8080 joseaugustoss/fullcycle
````
## Para baixar a imagem
```shell
docker pull joseaugustoss/fullcycle
````
## Referências

- [Exemplo de "Hello, World!" em Go](http://goporexemplo.golangbr.org/hello-world.html)
- [Imagem oficial "scratch" no Docker Hub](https://hub.docker.com/_/scratch/)
- [Imagem oficial do GoLang no Docker Hub](https://hub.docker.com/_/golang/)
- [Compilação estática com GoLang](https://imasters.com.br/desenvolvimento/compilacao-estatica-com-golang/)

