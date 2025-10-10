# Getting Started with Claude Code Plugins

Complete guide for installing, using, and managing Claude Code plugins.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installing Claude Code](#installing-claude-code)
- [Understanding Plugins](#understanding-plugins)
- [Installing Plugins](#installing-plugins)
- [Managing Plugins](#managing-plugins)
- [Using Plugins](#using-plugins)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### System Requirements

- **Node.js**: v18.0.0 or higher
- **npm**: v8.0.0 or higher
- **Git**: For marketplace installations
- **Claude API Key**: From Anthropic

### Supported Platforms

- macOS (x64, ARM64)
- Linux (x64, ARM64)
- Windows (x64, via WSL recommended)

## Installing Claude Code

### Installation

```bash
# Install globally via npm
npm install -g @anthropic-ai/claude-code

# Verify installation
claude --version
```

### Configuration

```bash
# First run - configure API key
claude

# Or set environment variable
export ANTHROPIC_API_KEY=your_api_key_here
```

## Understanding Plugins

### What are Plugins?

Plugins extend Claude Code with:

- **📝 Slash Commands**: Custom shortcuts like `/deploy`, `/review`
- **🤖 Agents**: Specialized AI personalities for specific tasks
- **🪝 Hooks**: Automated actions at workflow points
- **🔌 MCP Servers**: External tool integrations

### Plugin Components

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # Manifest
├── commands/                # Slash commands
├── agents/                  # Specialized agents
├── hooks/                   # Workflow hooks
└── .mcp.json               # MCP servers
```

## Installing Plugins

### Method 1: From Marketplace

```bash
# Add a marketplace
/plugin marketplace add anthropics/claude-code

# Browse plugins
/plugin

# Install a specific plugin
/plugin install feature-dev
```

### Method 2: From GitHub

```bash
# Add GitHub repository as marketplace
/plugin marketplace add username/repo-name

# Install plugin
/plugin install plugin-name
```

### Method 3: From Git URL

```bash
# Add Git repository
/plugin marketplace add https://gitlab.com/org/plugins.git

# Install plugin
/plugin install plugin-name
```

### Method 4: From Local Directory

```bash
# For development/testing
/plugin marketplace add ./path/to/plugin

# Install
/plugin install plugin-name
```

## Managing Plugins

### List Installed Plugins

```bash
/plugin list

# Output:
# Installed Plugins:
# - feature-dev (v1.2.0) - enabled
# - code-reviewer (v2.0.1) - enabled
# - test-automation (v1.5.0) - disabled
```

### Enable/Disable Plugins

```bash
# Disable a plugin
/plugin disable code-reviewer

# Enable a plugin
/plugin enable code-reviewer

# Why disable? Reduce context and complexity when not needed
```

### Update Plugins

```bash
# Check for updates
/plugin update --check

# Update specific plugin
/plugin update feature-dev

# Update all plugins
/plugin update --all
```

### Uninstall Plugins

```bash
# Uninstall a plugin
/plugin uninstall test-automation

# Remove marketplace
/plugin marketplace remove anthropics/claude-code
```

## Using Plugins

### Discovering Plugin Commands

After installing a plugin, discover available commands:

```bash
# List all commands
/help

# Search for plugin commands
/help | grep plugin-name
```

### Example Workflow

#### 1. Install Development Plugin

```bash
/plugin marketplace add anthropics/claude-code
/plugin install feature-dev
```

#### 2. Use Plugin Commands

```bash
# Plan a feature
/feature-spec "Add user authentication"

# Generates:
# - Feature requirements
# - Implementation tasks
# - Technical architecture
# - Testing strategy
```

#### 3. Leverage Plugin Agents

Plugin agents activate automatically when appropriate:

```
You: "Review this authentication code for security issues"

# The security-review agent (if installed) automatically engages
# to provide specialized security analysis
```

#### 4. Benefit from Hooks

Hooks run automatically:

```bash
git commit -m "Add auth feature"

# Pre-commit hook automatically:
# 1. Runs linter
# 2. Executes tests
# 3. Checks for secrets
# 4. Validates commit message
```

## Plugin Configuration

### Global Configuration

Located at `~/.claude/config.json`:

```json
{
  "plugins": {
    "code-reviewer": {
      "strictness": "high",
      "auto_fix": true
    },
    "test-automation": {
      "coverage_threshold": 80
    }
  }
}
```

### Project-Local Configuration

Located at `./.claude/config.json`:

```json
{
  "plugins": {
    "deployment": {
      "environment": "staging",
      "auto_deploy": false
    }
  }
}
```

### Priority Order

1. Project-local config (`./.claude/config.json`)
2. Global config (`~/.claude/config.json`)
3. Plugin defaults (`plugin.json` config section)

## Advanced Usage

### Plugin Dependencies

Some plugins require other plugins:

```json
// In plugin.json
{
  "dependencies": {
    "security-scanner": "^2.0.0",
    "test-runner": "~1.5.0"
  }
}
```

Claude Code automatically installs dependencies.

### Plugin Contexts

Plugins can be context-aware:

- **Project Type**: Different behavior for React vs Node.js
- **File Type**: Special handling for .ts vs .js files
- **Git State**: Actions based on branch, commits, etc.

### Custom Plugin Sources

Create private plugin repositories:

```bash
# Private GitHub repo
/plugin marketplace add https://github.com/company/private-plugins
# Requires: GitHub authentication configured

# Private GitLab
/plugin marketplace add https://gitlab.company.com/devtools/plugins.git
# Requires: Git credentials configured

# Internal file server
/plugin marketplace add file:///company/shared/claude-plugins
```

## Troubleshooting

### Plugin Won't Install

**Symptoms**: Installation fails or hangs

**Solutions**:
```bash
# Clear plugin cache
rm -rf ~/.claude/plugin-cache

# Reinstall plugin
/plugin install plugin-name

# Check network connectivity
ping github.com

# Use debug mode
claude --debug
```

### Commands Not Available

**Symptoms**: `/command` not found after installation

**Solutions**:
```bash
# Verify plugin is installed
/plugin list

# Check if plugin is enabled
/plugin enable plugin-name

# Restart Claude Code
# Exit and restart claude command

# Check for conflicts
claude --debug | grep conflict
```

### Hooks Not Running

**Symptoms**: Pre-commit hooks don't execute

**Solutions**:
```bash
# Verify hook script is executable
chmod +x ~/.claude/plugins/plugin-name/hooks/scripts/pre-commit.sh

# Check hooks.json syntax
cat ~/.claude/plugins/plugin-name/hooks/hooks.json

# Test hook manually
~/.claude/plugins/plugin-name/hooks/scripts/pre-commit.sh

# Enable debug logging
CLAUDE_DEBUG=1 git commit -m "test"
```

### Plugin Updates Fail

**Symptoms**: `PLUGIN install update` shows errors

**Solutions**:
```bash
# Remove and reinstall
/plugin uninstall plugin-name
/plugin install plugin-name

# Check for breaking changes in changelog
# Visit plugin repository

# Clear cache
rm -rf ~/.claude/plugin-cache
```

### Configuration Not Applied

**Symptoms**: Plugin ignores config settings

**Solutions**:
```bash
# Validate JSON syntax
cat ~/.claude/config.json | python -m json.tool

# Check config location
# Global: ~/.claude/config.json
# Project: ./.claude/config.json

# Verify plugin name matches
/plugin list

# Restart Claude Code
```

## Security Best Practices

### Review Plugin Code

Before installing plugins:

1. **Check Repository**: Visit the source code repository
2. **Read Code**: Review what the plugin does
3. **Check Stars/Forks**: Community trust indicators
4. **Review Permissions**: What access does it need?
5. **Check Maintenance**: Active development?

### Trust but Verify

```bash
# Clone and inspect before installing
git clone https://github.com/user/plugin
cd plugin
cat .claude-plugin/plugin.json
cat commands/*.md
cat hooks/scripts/*.sh

# Install from local after review
/plugin marketplace add ./
```

### Disable Unused Plugins

```bash
# Reduce attack surface
/plugin disable unused-plugin

# Re-enable when needed
/plugin enable unused-plugin
```

## Performance Tips

### Minimize Active Plugins

- Only enable plugins you're actively using
- Disable plugins when not needed
- Each active plugin adds to context size

### Optimize Plugin Loading

```bash
# Use project-specific plugin profiles
# .claude/config.json
{
  "plugins": {
    "feature-dev": { "enabled": true },
    "heavy-plugin": { "enabled": false }
  }
}
```

### Cache Management

```bash
# Clear cache periodically
rm -rf ~/.claude/plugin-cache

# Rebuild cache
claude --rebuild-plugin-cache
```

## Next Steps

1. **Explore Marketplaces**: Browse available plugins
2. **Try Examples**: Install and test example plugins
3. **Create Your Own**: Follow [Creating Your First Plugin](../tutorials/first-plugin.md)
4. **Join Community**: Share and learn in [Discord](https://anthropic.com/discord)

## Resources

- [Plugin Architecture](../architecture/plugin-system.md)
- [Creating Plugins](../tutorials/first-plugin.md)
- [Publishing Plugins](../tutorials/publishing-plugins.md)
- [Official Documentation](https://docs.anthropic.com/en/docs/claude-code/plugins)
- [Example Plugins](../../examples/)

## Getting Help

- 💬 [Discord Community](https://anthropic.com/discord)
- 💬 [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- 📚 [Official Docs](https://docs.anthropic.com/en/docs/claude-code/overview)
- 🐛 [Report Issues](https://github.com/anthropics/claude-code/issues)

---

**Happy plugin exploring!** 🚀
