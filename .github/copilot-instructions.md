# GitHub Copilot Instructions for Orbit Framework SDK

This file provides fundamental knowledge for Copilot to assist effectively in the Orbit Framework SDK project.

## MVP Development Context (Updated: May 25, 2025)

- **Current Phase**: 21-day sprint for 0.1.0 MVP Release
- **Current User**: @itsalfredakku (Technical Lead & Core Architecture)
- **Focus Areas**: Component model, rendering pipeline coordination, and MVP integration
- **Documentation**: See `docs/progress-reports/MVP_TEAM_TASK_ASSIGNMENTS.md` for complete team assignments

## Project Overview

- **Name**: Orbit UI Framework
- **Purpose**: A cross-platform Rust-based UI framework, including:
  - **orbit/**: Core rendering engine and component model
  - **orbiton/**: CLI tool for project scaffolding, development server, build, and analysis
  - **orlint/**: Static analyzer and linter for `.orbit` single-file components
  - **docs/**: Comprehensive documentation (getting-started, core concepts, API, guides)

## Repository Structure

- `sdk/` (workspace root)
  - `Cargo.toml`: Workspace configuration
  - `docs/`: Project documentation
    - `getting-started/`, `core-concepts/`, `api/`, `guides/`, `progress-reports/`, etc.
  - `orbit/`: Core framework implementation (Rust crate)
  - `orbiton/`: CLI implementation (Rust crate)
  - `orlint/`: Analyzer implementation (Rust crate)
  - `examples/`: Sample applications and component demos

## Development Priorities

1. **Core Framework First**: Focus on `orbit/` implementation, component lifecycle, rendering pipeline, and core APIs.
2. **Documentation**: Keep docs up-to-date with high-priority tasks (Getting Started, API, guides) and reflect changelog "Unreleased" features.
3. **Tooling**: Enhance `orbiton` and `orlint` documentation (CLI commands, configuration files, best practices).
4. **SDK Enhancements**: Marked as low priority; archive or deprecate SDK-specific docs when not relevant to core functionality.

## Documentation Best Practices

- Use consistent templates and headers (see `docs/DOCUMENTATION_PLAN.md`).
- Mark completed tasks in `docs/CONTENT_GAP_ANALYSIS.md` and add new tasks as needed.
- Keep CHANGELOG.md files in sync with documentation progress reports.
- Leverage existing guides (core concepts, API reference, examples) and avoid duplication.
- Add troubleshooting sections, usage examples, and placeholders for screenshots or diagrams.

## Continuous Lifecycle Management

- **Phase 1**: Structure and foundation (consistency, gap analysis, high-priority docs)
- **Phase 2**: Content development (complete API, core concepts, examples)
- **Phase 3**: Interactive content (live examples, diagrams, video tutorials)
- **Phase 4**: Maintenance (audits, community contributions, automation)

## Copilot Guidance

- Refer to `docs/DEVELOPMENT_PRIORITIES.md` and `docs/DOCUMENTATION_PROGRESS_REPORT.md` for current focus areas.
- Use semantic precision when editing or creating markdown files.
- Ensure all new docs follow the existing style and directory conventions.
- Highlight ports and environment guidelines for web, CLI, and GUI contexts as specified in CLI docs.
- Archive or deprecate SDK docs marked as non-essential in `docs/DEVELOPMENT_PRIORITIES.md`.

## Role-Specific Task Focus (@itsalfredakku)

### Current Week 1 Tasks (Days 1-7)

1. **Component Lifecycle Enhancement** (Days 1-2)
   - Complete component mounting/unmounting lifecycle
   - Implement state change detection and batching
   - Add component tree management
   - **Success criteria**: All component lifecycle methods fully implemented and tested

2. **Props and Events System** (Days 3-4)
   - Finalize type-safe props validation
   - Complete event delegation system
   - Implement parent-child communication patterns
   - **Success criteria**: Complete props/events framework with validation

3. **State Management Integration** (Days 5-7)
   - Reactive state tracking completion
   - Context API implementation
   - Signal system optimization
   - **Success criteria**: Unified state management system with reactive updates

### Code Approach Preferences
   
- **Component Architecture**: Favor composition over inheritance
- **API Design**: Design for developer experience with clear type signatures
- **Error Handling**: Use Result with custom ComponentError types
- **Performance**: Focus on optimizing component update cycle and state change detection
- **Code Style**: Follow Rust idioms with comprehensive documentation

### Coordination Focus

- Daily coordination with @dev1-devstroop on renderer integration
- API design reviews with full team
- Integration testing with all components

---

*End of Copilot instructions*
