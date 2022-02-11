FROM golang:1.14-alpine as builder
WORKDIR /usr/src/app
ENV GOPROXY=https://goproxy.cn
COPY ./go.mod ./
RUN go mod download
COPY . .
RUN go build -ldflags "-s -w" -o hello

FROM scratch as runner
COPY --from=builder /usr/src/app/hello /opt/app/
CMD ["/opt/app/hello"]