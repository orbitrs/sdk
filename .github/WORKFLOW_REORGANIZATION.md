# GitHub Workflows Reorganization Plan

## Overview

This document outlines the reorganization of GitHub workflows for the Orbit Framework SDK to follow monorepo best practices and eliminate conflicts.

## Current Issues Addressed

1. **Redundant workflows**: Each crate had duplicate CI and release logic
2. **GitHub Pages conflicts**: Multiple workflows trying to deploy documentation
3. **Complex cross-compilation**: Scattered across multiple workflows
4. **Inconsistent patterns**: Different approaches for similar tasks

## New Workflow Structure

### Workspace-Level Workflows (Primary)

Located in `/Volumes/EXT/repos/orbitrs/sdk/.github/workflows/`

#### 1. `workspace-ci.yml` - Main CI Pipeline
- **Purpose**: Comprehensive testing for the entire workspace
- **Triggers**: Push/PR to main/develop branches
- **Responsibilities**:
  - Format and lint checking for all crates
  - Cross-platform testing (Ubuntu, Windows, macOS)
  - Multiple Rust versions (stable, beta, nightly)
  - Feature matrix testing
  - Coverage reporting (main branch only)

#### 2. `workspace-release.yml` - Main Release Pipeline
- **Purpose**: Coordinated releases for the entire workspace
- **Triggers**: Git tags (`v*`) or manual dispatch
- **Responsibilities**:
  - Publish all crates to crates.io
  - Build cross-platform binary artifacts
  - Deploy unified documentation to GitHub Pages
  - Create GitHub releases with artifacts
  - Version coordination across crates

### Crate-Specific Workflows (Secondary)

Located in respective crate directories (e.g., `orbit/.github/workflows/`)

#### 1. Crate CI Workflows
- **`orbit-ci.yml`**: Core framework specific tests
- **`orbiton-ci.yml`**: CLI tool integration tests
- **`orlint-ci.yml`**: Linter accuracy tests

**Purpose**: 
- Run only when specific crate changes
- Test crate-specific functionality
- Feature matrix testing for individual crates

#### 2. Crate Release Workflows (Simplified)
- **`orbit-release.yml`**: Manual orbit crate publishing
- **`orbiton-release.yml`**: Manual orbiton crate publishing
- **`orlint-release.yml`**: Manual orlint crate publishing

**Purpose**:
- Emergency/hotfix releases for individual crates
- Manual publishing with validation
- NO documentation deployment (handled by workspace)
- NO artifact building (handled by workspace)

## Migration Steps

### Phase 1: Deploy New Workflows ✅
1. ✅ Create new workspace-level workflows
2. ✅ Create simplified crate-specific workflows

### Phase 2: Remove Old Workflows
1. 🔄 Remove old complex release workflows from crates
2. 🔄 Remove old CI workflows from crates
3. 🔄 Remove special workflows (changelog, coverage) from crates

### Phase 3: Update Repository Settings
1. 🔄 Update branch protection rules to use new workflow names
2. 🔄 Configure GitHub Pages to use workspace deployment
3. 🔄 Update README badges to point to new workflows

### Phase 4: Testing and Validation
1. 🔄 Test new CI pipeline with sample PRs
2. 🔄 Test new release pipeline with pre-release tags
3. 🔄 Validate documentation deployment
4. 🔄 Verify artifact generation

## Key Improvements

### 1. Centralized Documentation
- Single source of truth for documentation deployment
- No conflicts between crate-level and workspace-level deployments
- Unified documentation site with all crates

### 2. Efficient CI/CD
- Reduced redundancy in CI runs
- Path-based triggering for crate-specific workflows
- Shared cache and dependency management

### 3. Coordinated Releases
- Version synchronization across workspace
- Single release process for all artifacts
- Consistent release notes and changelog management

### 4. Simplified Maintenance
- Fewer workflow files to maintain
- Consistent patterns across all workflows
- Clear separation of concerns

## Workflow Triggers

### Workspace CI (`workspace-ci.yml`)
- Push to main/develop
- Pull requests to main/develop
- Runs on all changes affecting workspace

### Crate CI (e.g., `orbit-ci.yml`)
- Push to main/develop with crate-specific path changes
- Pull requests with crate-specific path changes
- Only runs when relevant crate is modified

### Workspace Release (`workspace-release.yml`)
- Git tags matching `v*` pattern
- Manual workflow dispatch for testing
- Handles all release artifacts

### Crate Release (e.g., `orbit-release.yml`)
- Manual workflow dispatch only
- Used for emergency releases or hotfixes
- Simplified publishing without artifacts

## Dependencies and Secrets

### Required Secrets
- `CRATES_TOKEN`: For publishing to crates.io
- `GITHUB_TOKEN`: Automatically provided (for releases and pages)

### Required Permissions
- `contents: write`: For creating releases
- `pages: write`: For GitHub Pages deployment
- `id-token: write`: For OIDC authentication

## Benefits

1. **No More Conflicts**: Single documentation deployment source
2. **Faster CI**: Reduced redundancy and better caching
3. **Easier Maintenance**: Fewer workflows to manage
4. **Better Testing**: Comprehensive workspace testing
5. **Coordinated Releases**: All crates released together with proper versioning

## Next Steps

1. Remove old workflows after testing new ones
2. Update documentation to reflect new workflow structure
3. Train team on new release process
4. Monitor and optimize workflow performance
