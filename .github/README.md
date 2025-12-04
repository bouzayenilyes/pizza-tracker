# GitHub Actions Pipeline

This document describes the complete CI/CD pipeline for the Pizza Tracker Go project.

## Overview

The pipeline consists of 4 main workflows that handle different aspects of the software development lifecycle:

1. **CI Workflow** - Continuous Integration
2. **Docker Workflow** - Container building and security
3. **Security Workflow** - Security scanning and vulnerability assessment
4. **Release Workflow** - Automated releases and distribution

---

## 🔄 CI Workflow (`ci.yml`)

**Triggers:** Push to `main`/`develop` branches, Pull requests to `main`

**Purpose:** Ensures code quality and builds the application

### Key Features:
- **Multi-version testing**: Tests against Go 1.23, 1.24, and 1.24.2
- **Dependency management**: Downloads and verifies Go modules
- **Code quality checks**:
  - `go vet` for static analysis
  - `gofmt` for code formatting
  - `goimports` for import organization
  - `golangci-lint` for comprehensive linting
- **Test execution**: Runs unit tests and generates coverage reports
- **Binary building**: Compiles the application for Linux
- **Coverage reporting**: Uploads results to Codecov

### Jobs:
- **test**: Main testing and validation job

---

## 🐳 Docker Workflow (`docker.yml`)

**Triggers:** Push to `main`/`develop` branches, Version tags (`v*`), Pull requests

**Purpose:** Builds and publishes Docker images with security scanning

### Key Features:
- **Multi-platform builds**: Uses Docker Buildx for cross-platform compatibility
- **Container registry**: Pushes to GitHub Container Registry (ghcr.io)
- **Automated tagging**: 
  - Branch-based tags (`main`, `develop`)
  - Version tags (semantic versioning)
  - Commit SHA tags
- **Security scanning**:
  - Trivy vulnerability scanner
  - Docker Scout analysis
  - SARIF reports uploaded to GitHub Security tab

### Jobs:
- **build-and-push**: Builds and pushes Docker images
- **security-scan**: Performs container security scanning

---

## 🔒 Security Workflow (`security.yml`)

**Triggers:** Push to `main`/`develop` branches, Pull requests, Daily at 2 AM UTC

**Purpose:** Comprehensive security scanning and vulnerability assessment

### Key Features:
- **Dependency scanning**: Go vulnerability checker (govulncheck)
- **Static Application Security Testing (SAST)**: CodeQL analysis
- **Code scanning**: Semgrep for security patterns
- **Secrets detection**: TruffleHog for credential scanning
- **Scheduled runs**: Daily security audits

### Jobs:
- **dependency-scan**: Scans Go dependencies for vulnerabilities
- **codeql**: GitHub's CodeQL security analysis
- **semgrep**: Pattern-based security scanning
- **secrets-scan**: Detects exposed secrets and credentials

### Required Secrets:
- `SEMGREP_APP_TOKEN`: For Semgrep cloud scanning (optional)

---

## 🚀 Release Workflow (`release.yml`)

**Triggers:** Version tags (`v*`)

**Purpose:** Automated release creation with multi-platform binaries and Docker images

### Key Features:
- **Comprehensive testing**: Runs all tests before release
- **Multi-platform builds**:
  - Linux AMD64
  - macOS AMD64
  - macOS ARM64 (Apple Silicon)
  - Windows AMD64
- **Automated releases**: Creates GitHub releases with changelog
- **Binary distribution**: Provides pre-compiled binaries with checksums
- **Docker Hub sync**: Updates Docker Hub repository description
- **Prerelease detection**: Automatically marks pre-release versions

### Required Secrets:
- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token

### Jobs:
- **release**: Main release job with testing, building, and distribution

---

## 🏗️ Workflow Dependencies

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Push     │    │   Pull      │    │    Tag      │
│             │    │  Request    │    │   v*.*.*    │
└──────┬──────┘    └──────┬──────┘    └──────┬──────┘
       │                  │                  │
       │                  │                  │
       ▼                  ▼                  ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ CI Workflow │    │ CI Workflow │    │Release      │
│Docker       │    │Security     │    │Workflow     │
│Workflow     │    │Workflow     │    │             │
│Security     │    │             │    │             │
│Workflow     │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
```

---

## 🔧 Configuration

### Environment Variables
- `REGISTRY`: Container registry (default: ghcr.io)
- `IMAGE_NAME`: Container image name (derived from repository)

### Required GitHub Secrets
| Secret | Usage | Required For |
|--------|-------|--------------|
| `GITHUB_TOKEN` | Authentication | All workflows (auto-provided) |
| `SEMGREP_APP_TOKEN` | Security scanning | Security workflow (optional) |
| `DOCKERHUB_USERNAME` | Docker Hub auth | Release workflow |
| `DOCKERHUB_TOKEN` | Docker Hub auth | Release workflow |

### Branch Protection Rules
Recommended branch protection settings for `main`:
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Include administrators
- Required status checks:
  - `test` (CI workflow)
  - `build-and-push` (Docker workflow)
  - `dependency-scan` (Security workflow)
  - `codeql` (Security workflow)

---

## 📊 Monitoring and Alerts

### GitHub Security Tab
- **Code scanning alerts**: From CodeQL and Semgrep
- **Dependency graph**: Automatic dependency analysis
- **Secret scanning alerts**: From TruffleHog

### Container Security
- **Vulnerability alerts**: From Trivy and Docker Scout
- **SARIF reports**: Uploaded automatically for review

### Release Monitoring
- **Failed workflows**: Notifications in GitHub
- **Release creation**: Automatic notifications to watchers
- **Container registry**: Images available at `ghcr.io/{owner}/{repo}`

---

## 🛠️ Development Workflow

### For Contributors
1. **Create feature branch**: `git checkout -b feature/amazing-feature`
2. **Make changes** and commit
3. **Push branch** and create Pull Request
4. **Automatic checks**:
   - CI workflow runs tests and quality checks
   - Security workflow scans for vulnerabilities
   - Docker workflow builds and tests container
5. **Merge after approval** and status checks pass

### For Maintainers
1. **Create release**: `git tag v1.0.0 && git push origin v1.0.0`
2. **Automatic release process**:
   - Release workflow triggers
   - Multi-platform binaries built
   - Docker images published
   - GitHub release created with changelog
   - Container security scans performed

---

## 🔄 Maintenance

### Regular Tasks
- **Weekly**: Review security alerts and dependency updates
- **Monthly**: Update GitHub Actions versions
- **Quarterly**: Review and update security scanning configurations
- **Annually**: Update Go version support matrix

### Dependency Updates
- **Go modules**: Automated checks via `go mod tidy`
- **GitHub Actions**: Use Dependabot for automated updates
- **Container base images**: Regular updates for security patches

---

## 📚 Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Go Security Guidelines](https://golang.org/security/)
- [Container Security Scanning](https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions)

---

**Last Updated**: December 2025  
**Pipeline Version**: 1.0.0  
**Supported Go Versions**: 1.23, 1.24, 1.24.2