FROM golang:1.14-alpine AS builder
# 按需安装依赖包
# RUN  apk --update --no-cache add gcc libc-dev ca-certificates  
RUN  apk --update --no-cache add git ca-certificates 
# 设置Go编译参数
ARG TOKEN
ARG VERSION
ARG COMMIT
ARG BUILDTIME
WORKDIR /app
COPY . .
RUN git config --global url."https://${TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
RUN GOOS=linux go build -o main -ldflags "-X github.com/x-mod/build.version=${VERSION} -X github.com/x-mod/build.commit=${COMMIT} -X github.com/x-mod/build.date=${BUILDTIME}"

# 第二阶段
FROM  alpine
# 安装必要的工具包
RUN  apk --update --no-cache add tzdata ca-certificates \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=builder /app/main /usr/local/bin
ENTRYPOINT [ "main" ]