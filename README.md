# Orbitrs SDK Monorepo

<p align="center">
  <img src="public/assets/orbitrs.svg" alt="Orbitrs Logo" width="200">
</p>

Orbitrs SDK is a workspace containing the core Orbit UI framework, CLI tooling, static analysis tools, public assets, and comprehensive documentation to power Rust-first UI across web, desktop, native, and embedded targets.

## Development Priority

> **Important**: The SDK itself is currently used for personal development purposes and improvements to it are considered non-essential. The primary focus is on core framework development. Contributors should prioritize work on the core components (orbit, orbiton, orlint) rather than SDK enhancements.

## Recent Progress (May 2025)

- Fixed build target conflicts in examples project structure
- Created comprehensive examples demonstrating props and events system
- Implemented component lifecycle demonstration
- Added WGPU renderer examples for 3D capabilities
- Refactored project organization for better maintainability

See [Milestone 1 Tracking](docs/roadmap/tracking/milestone-1-tracking.md) for detailed progress updates.

## Workspace Structure

| Component              | Path        | Description                                                     |
|------------------------|-------------|-----------------------------------------------------------------|
| Core Framework         | `orbit/`    | Orbit UI framework with Skia & WGPU rendering                   |
| CLI Tools              | `orbiton/`  | Command-line interface for development, building, and deployment|
| Linting & Analysis     | `orlint/`   | Static analysis, linting, and validation for `.orbit` files     |
| Public Assets & Site   | `public/`   | Organization website, assets, and examples                      |
| Documentation          | `docs/`     | Guides, API references, tutorials, roadmap, and progress reports|

## Getting Started

# Build the entire workspace
```bash
cargo build --workspace
```

# Install and run the CLI
```bash
cargo install --path orbiton
orbiton new my-app
cd my-app
orbiton dev
```

# Run tests and lint
```bash
cargo test --workspace
orlint lint
```

## Documentation

Explore detailed guides, API references, and tutorials in [docs/README.md](docs/README.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on reporting issues, contributing code, documentation, and other improvements.

<p align="center">
  <em>Crafted with ❤️ by the Orbitrs Team</em>
</p>

