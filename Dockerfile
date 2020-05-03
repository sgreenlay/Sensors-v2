FROM golang as builder
RUN mkdir /build 
ADD . /build/
WORKDIR /build 
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .
FROM scratch
COPY --from=builder /build/main /app/
WORKDIR /app
EXPOSE 80
CMD ["./main"]