# Contributing to the Orbit Framework

Thank you for your interest in contributing to the Orbit Framework! This document provides guidelines and instructions for contributing to the various components of the Orbit ecosystem.

> **Important Development Priority Notice**: As of May 23, 2025, the primary focus is on core framework development rather than SDK improvements. Please review [Development Priorities](docs/DEVELOPMENT_PRIORITIES.md) for details on current focus areas.

## Table of Contents

- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Contribution Guidelines](#contribution-guidelines)
- [Code Style and Standards](#code-style-and-standards)
- [Testing Requirements](#testing-requirements)
- [Documentation Requirements](#documentation-requirements)
- [Pull Request Process](#pull-request-process)
- [Community Guidelines](#community-guidelines)

## Project Structure

The Orbit Framework consists of several interrelated projects:

- **orbit**: Core library with the component model, reactivity system, and rendering pipeline
- **orbiton**: CLI tooling for creating, developing, and building Orbit applications
- **orlint**: Code analyzer and linter for Orbit components
- **docs**: Official documentation

## Getting Started

### Prerequisites

- Rust (stable channel, 1.70.0+)
- Cargo (comes with Rust)
- Git
- Node.js and npm (for some examples and tooling)
- GitHub CLI (optional, for GitHub Copilot CLI integration)

### Setting Up the Development Environment

1. Fork the repository on GitHub
2. Clone your fork
   ```bash
   git clone https://github.com/your-username/orbitrs.git
   cd orbitrs
   ```
3. Set up the upstream remote
   ```bash
   git remote add upstream https://github.com/orbitrs/orbitrs.git
   ```
4. Install development dependencies
   ```bash
   cargo build
   ```
5. (Optional) Set up GitHub Copilot CLI for enhanced development assistance
   ```bash
   # Run the setup script
   ./scripts/setup-copilot-cli.sh
   ```

## Development Workflow

We use a feature branch workflow:

1. Ensure your main branch is up-to-date
   ```bash
   git checkout main
   git pull upstream main
   ```
2. Create a feature branch
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make changes, commit often with clear messages
4. Push your branch to your fork
   ```bash
   git push -u origin feature/your-feature-name
   ```
5. Create a pull request against the upstream main branch

### Working on Specific Subprojects

#### Orbit Core

```bash
cd orbit
cargo build
cargo test
```

#### Orbiton CLI

```bash
cd orbiton
cargo build
cargo run -- --help
```

#### Orlint

```bash
cd orlint
cargo build
cargo run -- --help
```

## Contribution Guidelines

### Types of Contributions We're Looking For

- Bug fixes
- Performance improvements
- Documentation improvements
- Feature implementations from the roadmap
- New components for the component library
- Test coverage improvements

### Before You Start

1. **Check existing issues** - Look for open issues or create a new one to discuss your planned contribution
2. **Discuss major changes** - For significant features or changes, open an issue first to discuss the approach
3. **Review the roadmap** - See if your contribution aligns with project goals

## Code Style and Standards

We follow standard Rust coding conventions with some additional guidelines:

### Rust Code

- Use `rustfmt` with our project configuration
- Follow the [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- Use meaningful variable and function names
- Write comments for complex logic

To format code:

```bash
cargo fmt
```

### Documentation Standards

- Use Markdown for documentation files
- Follow existing documentation structure
- Include code examples for API documentation
- Write clear and concise explanations

### Commit Messages

- Use clear and descriptive commit messages
- Start with a verb in imperative form (e.g., "Add," "Fix," "Update")
- Reference issue numbers when applicable

## Testing Requirements

All code contributions should include appropriate tests:

- **Unit Tests** - For individual functions and components
- **Integration Tests** - For interactions between components
- **Documentation Tests** - For code examples in documentation

To run tests:

```bash
cargo test
```

## Documentation Requirements

Any new feature or significant change should include:

- Update to API documentation with examples
- Changes to relevant guides or tutorials
- New documentation files if appropriate

## Pull Request Process

1. **Fill out the PR template** with all required information
2. **Ensure CI passes** - All tests, linting, and builds must pass
3. **Request review** from maintainers
4. **Address feedback** promptly
5. **Update documentation** if needed
6. **Wait for approval** from at least one maintainer

## Community Guidelines

### Communication Channels

- **GitHub Issues** - For bug reports, feature requests, and discussions
- **Discord Server** - For real-time discussions and community support
- **Forums** - For longer discussions and knowledge sharing

### Code of Conduct

We are committed to providing a friendly, safe, and welcoming environment for all contributors. Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

### Recognition

We believe in recognizing all contributors. Your name will be added to the contributors list after your first merged PR.

## Specialized Contribution Areas

### Component Library Contributions

When contributing to the component library:

- Follow the component API design standards
- Include accessibility features
- Provide comprehensive examples
- Include documentation for all props and events

### Documentation Contributions

Documentation improvements are highly valued:

- Fix typos and clarify existing content
- Add examples for complex concepts
- Ensure code examples are current and working
- Translate documentation (when applicable)

### Performance Optimizations

When submitting performance improvements:

- Include before/after benchmarks
- Document the approach taken
- Explain potential trade-offs

## Getting Help

If you need assistance with your contribution:

- Ask in the "Contributing" channel on Discord
- Comment on the relevant GitHub issue
- Contact the maintainers directly

---

Thank you for contributing to Orbit Framework! Your efforts help make this project better for everyone.
