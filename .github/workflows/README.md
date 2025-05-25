# Orbit Framework CI/CD Pipeline

This workflow runs tests, builds, and deployments for the Orbit Framework SDK.

## Overview

The pipeline consists of several jobs:

- **Fast Check**: Quick feedback for PRs and pushes
- **Test Suite (Stable)**: Comprehensive tests on stable Rust across platforms (required)
- **Test Suite (Beta)**: Non-blocking tests on beta Rust across platforms
- **Build Verification**: Ensures the project builds correctly
- **WebAssembly Build**: Verifies WebAssembly compilation
- **Documentation**: Generates and deploys API documentation
- **Beta Compatibility Report**: Reports on beta toolchain compatibility

## Non-Blocking Beta Channel Testing

The workflow is designed to test against both stable and beta Rust toolchains, but failures in the beta channel will not block the pipeline. This design choice provides:

1. **Early Warning**: Detect potential issues in upcoming Rust releases
2. **No Blocking**: PRs and pushes still succeed even if beta tests fail
3. **Repository-Specific Reporting**: Automated issue creation in specific repositories where failures occur
4. **Detailed Analysis**: Test and clippy results are reported separately for each package
5. **Deduplication**: Similar failures are grouped together in each repository

## Adding New Non-Blocking Jobs

See `.github/actions/README.md` for instructions on adding new non-blocking jobs.

## Workflow Dependencies

```
fast-check --+
              |
              v
test-stable ---+--------------------+----+
                |                    |    |
                v                    v    v
              build           wasm-build  docs
               
test-beta -----> beta-report
```

## Configuration Options

- **Environments**: The workflow runs on Ubuntu, Windows, and macOS
- **Rust Toolchains**: Testing on both stable and beta
- **Features**: Desktop and WebAssembly builds are verified
