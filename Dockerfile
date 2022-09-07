# Imagem base da linguagem go
FROM golang:1.19-alpine as build-step

# Seta o diretório base da aplicação
WORKDIR /go/src/app

# Copia o arquivo para o WORKDIR
COPY src/main.go .

# Roda o build da aplicação
RUN go build /go/src/app/main.go

# Minimal image do docker
# Utilizada para criar a imagem com o mínimo de recursos
# Aqui é o que faz a imagem ser mais leve
FROM scratch

# Copia o arquivo do step anterior para a pasta 
COPY --from=build-step /go/src/app /go/src/app

# Roda o arquivo buildado
CMD ["/go/src/app/main"]

# Comando para criar container:
# docker run --rm -it --name golang md91/golang-fullcycle
## --rm: Cria e remove o container
## -it: Cria em modo interativo, irá exibir o output do container ao encerrar a execução
## --name: Nome do container
## md91/golang-fullcycle: Nome da imagem utilizada