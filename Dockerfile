# Build stage
FROM golang:1.24-alpine AS builder

# Install build dependencies
RUN apk add --no-cache gcc musl-dev

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
# CGO_ENABLED=1 is needed for go-sqlite3
RUN CGO_ENABLED=1 GOOS=linux go build -o server cmd/*.go

# Final stage
FROM alpine:latest

WORKDIR /app

# Install runtime dependencies (sqlite libs)
RUN apk add --no-cache sqlite-libs ca-certificates

# Copy binary from builder
COPY --from=builder /app/server .

# Copy templates and static files
COPY --from=builder /app/templates ./templates

# Create data directory for SQLite
RUN mkdir -p data

# Expose port
EXPOSE 8080

# Run the application
CMD ["./server"]
