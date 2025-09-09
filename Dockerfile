FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /parcel-tracker

FROM scratch

COPY --from=builder /parcel-tracker /parcel-tracker

COPY . ./

ENTRYPOINT ["/parcel-tracker"]