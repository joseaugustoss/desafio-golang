FROM golang:1.12.16-alpine AS builder

WORKDIR /app

COPY main.go .

RUN CG0_ENABLED=0 go build -ldflags="-w -s" -o /app/app main.go

FROM scratch

WORKDIR /app

COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]
