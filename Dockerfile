FROM --platform=$BUILDPLATFORM golang:1.20.5 AS build

ARG TARGETARCH
WORKDIR /go/src/github.com/gihyodocker/print-version
COPY . .
RUN GOARCH=$TARGETARCH make build

FROM gcr.io/distroless/base-debian11
LABEL org.opencontainers.image.source=https://github.com/gihyodocker/print-version

COPY --from=build /go/src/github.com/gihyodocker/print-version/bin/print-version /usr/local/bin/

ENTRYPOINT ["print-version"]