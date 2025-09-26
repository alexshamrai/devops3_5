FROM quay.io/projectquay/golang:1.21 AS builder

WORKDIR /app

ARG TARGETOS
ARG TARGETARCH

# Створюємо простий Go файл для тестування
RUN echo 'package main' > main.go && \
    echo 'import (' >> main.go && \
    echo '    "fmt"' >> main.go && \
    echo '    "runtime"' >> main.go && \
    echo ')' >> main.go && \
    echo 'func main() {' >> main.go && \
    echo '    fmt.Printf("Hello from %s/%s\\n", runtime.GOOS, runtime.GOARCH)' >> main.go && \
    echo '}' >> main.go

ENV GOOS=$TARGETOS
ENV GOARCH=$TARGETARCH
ENV CGO_ENABLED=0

RUN go build -o app main.go

FROM quay.io/projectquay/golang:1.21

WORKDIR /root/

COPY --from=builder /app/app .

CMD ["./app"]