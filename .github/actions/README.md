# Non-Blocking Job Handling in CI

This directory contains reusable GitHub Actions for handling non-blocking jobs in our CI pipeline.

## What is a non-blocking job?

Non-blocking jobs are tasks in our CI workflow that:
1. Run tests or verifications that are important to track
2. Should not cause the entire workflow to fail if they fail
3. Need reporting mechanisms to notify developers of issues

## Using the handle-non-blocking-job action

To add a new non-blocking job to our workflow:

1. Create a new job in the workflow file with `continue-on-error: true`
2. Add a reporting job that uses this composite action
3. Optionally specify a target repository for issue creation

### Basic Example:

```yaml
# Your non-blocking job
my-experimental-job:
  name: Experimental Feature Tests
  runs-on: ubuntu-latest
  continue-on-error: true
  steps:
    - uses: actions/checkout@v4
    # Your job steps here...

# Reporting job
my-experimental-report:
  name: Experimental Feature Report
  needs: [my-experimental-job]
  runs-on: ubuntu-latest
  if: always()
  permissions:
    issues: write
    contents: read
  steps:
    - uses: actions/checkout@v4
    
    - name: Get additional info
      id: get-info
      if: needs.my-experimental-job.result == 'failure'
      run: |
        # Get any additional info needed for reporting
        echo "feature_version=1.2.3" >> $GITHUB_OUTPUT
    
    - name: Handle results
      uses: ./.github/actions/handle-non-blocking-job
      with:
        job-name: "Experimental Feature Tests"
        job-result: ${{ needs.my-experimental-job.result }}
        issue-label: "experimental-feature"
        issue-title-prefix: "Experimental Feature Failure"
        version-info: ${{ steps.get-info.outputs.feature_version || 'No version' }}
```

### Repository-Specific Issues:

For creating issues in specific repositories (such as components within a monorepo):

```yaml
# Report failures in a specific repository
- name: Handle test failures for component X
  uses: ./.github/actions/handle-non-blocking-job
  with:
    job-name: "Test Failures - Component X"
    job-result: ${{ needs.my-test-job.result }}
    issue-label: "test-failures"
    issue-title-prefix: "Test Failures in Component X"
    target-repo: "myorg/component-x-repo"
    version-info: "v1.2.3"
    failure-details: ${{ needs.my-test-job.outputs.failure_json }}
```

The `failure-details` parameter accepts a JSON string containing detailed information about the failures, which will be included in the issue body.

## Benefits

- Consistent reporting across different types of non-blocking jobs
- Automatic issue creation and deduplication
- Keeps workflow status green even when experimental features fail
- Documents issues for tracking and resolution
