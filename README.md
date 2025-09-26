# devops3_5
Module 3 task 5

## Overview
This project provides a multi-platform Docker build system for testing Go applications across different operating systems and architectures. It includes a Makefile with platform-specific targets and a Dockerfile using the quay.io registry to avoid Docker Hub limitations.

## Prerequisites
- Docker installed and running
- Make utility
- Go environment (optional, for local development)

## Usage

### Available Make Targets

#### Platform-specific builds:
- `make linux` - Build for Linux AMD64
- `make arm` - Build for Linux ARM64  
- `make macos` - Build for macOS ARM64 (Apple Silicon)
- `make windows` - Build for Windows AMD64

#### General targets:
- `make image` - Build for current host platform/architecture
- `make clean` - Remove all created Docker images

### Examples

Build for specific platform:
```bash
make linux
make arm
make macos
make windows
```

Build for current host:
```bash
make image
```

Clean up all images:
```bash
make clean
```

### Docker Registry
This project uses `quay.io/yournamespace` as the container registry to avoid Docker Hub licensing and rate limiting issues.

### Configuration
You can modify the following variables in the Makefile:
- `APP_NAME` - Application name (default: testapp)
- `VERSION` - Image version tag (default: latest)
- `REGISTRY` - Container registry URL (default: quay.io/yournamespace)

### Testing
The Docker container runs a simple Go application that displays the target OS and architecture, helping verify cross-platform builds work correctly.
