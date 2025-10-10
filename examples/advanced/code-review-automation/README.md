# Code Review Automation Plugin

An advanced plugin demonstrating commands, agents, and hooks for automated code review workflows.

## Features

- 📝 `/review` - Perform comprehensive code review
- 🤖 **Review Agent** - Specialized code review agent
- 🪝 **Pre-commit Hook** - Automatic checks before commits
- ⚙️ **Configuration** - Customizable review rules

## Structure

```
code-review-automation/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── review.md
│   └── review-config.md
├── agents/
│   └── code-reviewer.md
├── hooks/
│   ├── hooks.json
│   └── scripts/
│       └── pre-commit-check.sh
└── README.md
```

## Installation

```bash
/plugin marketplace add <your-marketplace>
/plugin install code-review-automation
```

## Usage

### Manual Code Review

```bash
/review
```

This triggers a comprehensive review of recent changes.

### Configure Review Settings

```bash
/review-config
```

Interactive configuration of review preferences.

### Automatic Pre-commit Checks

The plugin automatically runs checks before each commit:

1. Linting
2. Type checking
3. Security scanning
4. Test execution

## Configuration

Edit your `.claude/config.json`:

```json
{
  "plugins": {
    "code-review-automation": {
      "strictness": "high",
      "autofix": true,
      "require_tests": true,
      "security_scan": true
    }
  }
}
```

## Components Deep Dive

### 1. Review Command (`commands/review.md`)

Structured prompt for thorough code review covering:
- Code quality and style
- Potential bugs
- Performance issues
- Security vulnerabilities
- Test coverage
- Documentation

### 2. Code Reviewer Agent (`agents/code-reviewer.md`)

Specialized agent persona with expertise in:
- Software engineering best practices
- Security patterns
- Performance optimization
- Testing strategies

### 3. Pre-commit Hook (`hooks/hooks.json`)

Automated workflow that runs before commits:
- Validates code syntax
- Runs linters
- Executes tests
- Checks for secrets
- Enforces commit message format

### 4. Pre-commit Script (`hooks/scripts/pre-commit-check.sh`)

Shell script that performs actual validation:
- Runs ESLint/Prettier
- Executes test suite
- Scans for hardcoded secrets
- Validates commit message

## Advanced Features

### Review Severity Levels

```bash
# Quick review
/review --level quick

# Standard review (default)
/review

# Deep review with security focus
/review --level deep --security
```

### Team Standards Enforcement

Configure team-specific rules in `plugin.json`:

```json
{
  "config": {
    "style_guide": "airbnb",
    "max_function_length": 50,
    "required_test_coverage": 80,
    "enforce_documentation": true
  }
}
```

## Hook Configuration Details

### Event Triggers

- `before-commit` - Pre-commit validation
- `after-edit` - Post-edit formatting (optional)
- `before-push` - Pre-push comprehensive checks

### Approval Requirements

```json
{
  "hooks": [
    {
      "event": "before-commit",
      "approval_required": false,  // Auto-run
      "timeout": 30000
    },
    {
      "event": "before-push",
      "approval_required": true,   // Requires user approval
      "timeout": 120000
    }
  ]
}
```

## Customization

### Disable Specific Checks

```bash
# Skip tests in pre-commit
SKIP_TESTS=true git commit -m "WIP: feature implementation"

# Skip all hooks
git commit --no-verify -m "Emergency fix"
```

### Custom Review Prompts

Add your own review focuses in `commands/`:

```markdown
<!-- commands/review-security.md -->
Focus exclusively on security vulnerabilities:
- SQL injection risks
- XSS vulnerabilities
- Authentication bypasses
- Sensitive data exposure
```

## Troubleshooting

### Hook Not Running

1. Verify script is executable:
```bash
chmod +x hooks/scripts/pre-commit-check.sh
```

2. Check hook configuration:
```bash
claude --debug
```

3. Verify event name spelling in `hooks.json`

### Review Agent Not Activated

- Ensure plugin is enabled: `/plugin list`
- Reload Claude Code
- Check for naming conflicts

## Performance Tips

- Use `--level quick` for rapid iterations
- Configure selective checks for large codebases
- Disable hooks temporarily with `--no-verify`

## Examples

### Example 1: Review Recent Changes

```bash
/review

# Output:
# 📝 Code Review Report
#
# ✅ Strengths:
# - Clean separation of concerns
# - Comprehensive error handling
#
# ⚠️ Issues Found:
# - auth.ts:45 - Potential SQL injection
# - utils.ts:12 - Unused import
#
# 🔧 Recommendations:
# 1. Use parameterized queries in auth.ts
# 2. Remove unused imports
# 3. Add unit tests for error paths
```

### Example 2: Security-Focused Review

```bash
/review --security

# Focuses exclusively on security concerns
```

## Integration with CI/CD

Use the hook scripts in your CI pipeline:

```yaml
# .github/workflows/review.yml
name: Code Review
on: [pull_request]
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Review Checks
        run: ./hooks/scripts/pre-commit-check.sh
```

## Related Examples

- [Simple Code Review](../simple-review/) - Minimal review command
- [Security Scanner](../security-scanner/) - Security-focused plugin
- [Test Automation](../test-automation/) - Testing workflows

## Resources

- [Hook System Documentation](../../../docs/architecture/hooks.md)
- [Agent Development Guide](../../../docs/guides/creating-agents.md)
- [Best Practices](../../../docs/guides/best-practices.md)
