# Publishing Your Plugin to Claude Code Marketplace

This guide walks you through publishing your Claude Code plugin to a marketplace so others can easily discover and install it.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Understanding marketplace.json](#understanding-marketplacejson)
- [Step-by-Step Guide](#step-by-step-guide)
- [Plugin Organization](#plugin-organization)
- [Best Practices](#best-practices)
- [Testing Your Marketplace](#testing-your-marketplace)
- [Promotion and Distribution](#promotion-and-distribution)

## Prerequisites

Before publishing, ensure you have:

- ✅ A working Claude Code plugin
- ✅ GitHub repository (or GitLab, any Git hosting)
- ✅ Plugin tested and documented
- ✅ Clear README with installation instructions
- ✅ Valid plugin manifest (`.claude-plugin/plugin.json`)

## Quick Start

The fastest way to publish your plugin:

```bash
# 1. Create marketplace configuration
mkdir -p .claude-plugin
cat > .claude-plugin/marketplace.json << 'EOF'
{
  "name": "your-marketplace",
  "owner": {
    "name": "Your Name",
    "email": "you@example.com",
    "url": "https://github.com/yourusername"
  },
  "metadata": {
    "description": "Your marketplace description",
    "version": "1.0.0"
  },
  "plugins": [
    {
      "name": "your-plugin",
      "source": "./",
      "description": "Your plugin description",
      "version": "1.0.0",
      "author": {"name": "Your Name"},
      "license": "MIT",
      "keywords": ["claude-code", "plugin"],
      "strict": false
    }
  ]
}
EOF

# 2. Commit and push
git add .claude-plugin/marketplace.json
git commit -m "Add Claude Code marketplace configuration"
git push

# 3. Users can now install with:
# /plugin marketplace add yourusername/your-repo
```

## Understanding marketplace.json

The `.claude-plugin/marketplace.json` file is the core of your marketplace:

```json
{
  "name": "marketplace-identifier",           // Unique marketplace name
  "owner": {                                  // Marketplace owner info
    "name": "Owner Name",
    "email": "contact@example.com",
    "url": "https://github.com/username"
  },
  "metadata": {                               // Marketplace metadata
    "description": "Description of marketplace",
    "version": "1.0.0",
    "homepage": "https://your-site.com",      // Optional
    "repository": "https://github.com/...",   // Optional
    "license": "MIT"                          // Optional
  },
  "plugins": [                                // Array of plugins
    {
      "name": "plugin-name",                  // Plugin identifier
      "source": "./path/to/plugin",           // Relative path or URL
      "description": "Plugin description",
      "version": "1.0.0",
      "author": {"name": "Author Name"},
      "license": "MIT",
      "keywords": ["tag1", "tag2"],
      "strict": false,                        // Flexible installation
      "commands": [                           // Optional: explicit paths
        "./commands/command1.md"
      ],
      "agents": [                             // Optional: agent paths
        "./agents/agent1.md"
      ],
      "mcpServers": [                         // Optional: MCP configs
        "./mcps/server.json"
      ]
    }
  ]
}
```

### Key Fields Explained

| Field | Required | Description |
|-------|----------|-------------|
| `name` | ✅ Yes | Unique marketplace identifier (kebab-case recommended) |
| `owner` | ✅ Yes | Marketplace maintainer information |
| `metadata` | ✅ Yes | Marketplace description and version |
| `plugins` | ✅ Yes | Array of available plugins |
| `plugins[].name` | ✅ Yes | Unique plugin identifier |
| `plugins[].source` | ✅ Yes | Plugin location (relative path or URL) |
| `plugins[].description` | ✅ Yes | Brief plugin description |
| `plugins[].version` | ⚪ Recommended | Semantic version number |
| `plugins[].keywords` | ⚪ Recommended | Search/discovery tags |
| `plugins[].strict` | ⚪ Optional | `false` allows flexible installation |

## Step-by-Step Guide

### Step 1: Prepare Your Plugin

Ensure your plugin has proper structure:

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── commands/                # Slash commands (optional)
│   ├── command1.md
│   └── command2.md
├── agents/                  # AI agents (optional)
│   └── specialist-agent.md
├── mcps/                    # MCP integrations (optional)
│   └── server-config.json
├── hooks/                   # Workflow hooks (optional)
│   └── hooks.json
├── scripts/                 # Helper scripts (optional)
│   └── setup.sh
└── README.md               # Documentation
```

### Step 2: Create Marketplace Configuration

Create `.claude-plugin/marketplace.json` at repository root:

```json
{
  "name": "awesome-tools",
  "owner": {
    "name": "Jane Developer",
    "email": "jane@example.com",
    "url": "https://github.com/janedev"
  },
  "metadata": {
    "description": "Productivity tools for Claude Code",
    "version": "1.0.0",
    "homepage": "https://janedev.github.io/awesome-tools",
    "license": "MIT"
  },
  "plugins": [
    {
      "name": "code-formatter",
      "source": "./plugins/formatter",
      "description": "Automatic code formatting with style guide enforcement",
      "version": "1.2.0",
      "author": {"name": "Jane Developer"},
      "license": "MIT",
      "keywords": ["formatting", "style", "prettier", "eslint"],
      "strict": false,
      "commands": [
        "./plugins/formatter/commands/format.md",
        "./plugins/formatter/commands/check-style.md"
      ],
      "agents": [
        "./plugins/formatter/agents/style-enforcer.md"
      ]
    },
    {
      "name": "test-runner",
      "source": "./plugins/testing",
      "description": "Comprehensive test automation and coverage analysis",
      "version": "2.0.1",
      "author": {"name": "Jane Developer"},
      "license": "MIT",
      "keywords": ["testing", "jest", "coverage", "automation"],
      "strict": false
    }
  ]
}
```

### Step 3: Test Locally

Before publishing, test your marketplace locally:

```bash
# Add local marketplace
/plugin marketplace add /absolute/path/to/your/repo

# Or use relative path from your project
/plugin marketplace add ./

# Browse plugins
/plugin

# Install a plugin
/plugin install your-plugin-name

# Test the plugin
/your-command
```

### Step 4: Commit and Push

```bash
git add .claude-plugin/marketplace.json
git commit -m "feat: add Claude Code marketplace configuration"
git push origin main
```

### Step 5: Publish and Share

Your marketplace is now live! Users can add it:

```bash
/plugin marketplace add yourusername/your-repo
```

## Plugin Organization

### Single Plugin Repository

For a single plugin, use `"source": "./"`:

```json
{
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./",
      "description": "My awesome plugin"
    }
  ]
}
```

Structure:
```
my-plugin-repo/
├── .claude-plugin/
│   ├── marketplace.json
│   └── plugin.json
├── commands/
├── agents/
└── README.md
```

### Multiple Plugins Repository

For multiple plugins, organize in subdirectories:

```json
{
  "plugins": [
    {
      "name": "plugin-one",
      "source": "./plugins/one",
      "description": "First plugin"
    },
    {
      "name": "plugin-two",
      "source": "./plugins/two",
      "description": "Second plugin"
    }
  ]
}
```

Structure:
```
marketplace-repo/
├── .claude-plugin/
│   └── marketplace.json
├── plugins/
│   ├── one/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   └── README.md
│   └── two/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── agents/
│       └── README.md
└── README.md
```

### Themed Collections

Group plugins by theme or workflow:

```json
{
  "name": "frontend-toolkit",
  "plugins": [
    {
      "name": "react-helpers",
      "source": "./frontend/react"
    },
    {
      "name": "css-optimizer",
      "source": "./frontend/css"
    },
    {
      "name": "bundle-analyzer",
      "source": "./frontend/bundler"
    }
  ]
}
```

## Best Practices

### Naming Conventions

✅ **Good naming:**
- `git-flow-tools`
- `security-scanner`
- `test-automation-suite`

❌ **Avoid:**
- `MyAwesomeTool` (use kebab-case)
- `tool` (too generic)
- `plugin1` (not descriptive)

### Versioning

Follow [Semantic Versioning](https://semver.org/):

- `1.0.0` - Major release
- `1.1.0` - New features (backwards compatible)
- `1.1.1` - Bug fixes

Update `marketplace.json` when you release:

```json
{
  "metadata": {
    "version": "1.2.0"  // Marketplace version
  },
  "plugins": [
    {
      "version": "2.1.0"  // Individual plugin version
    }
  ]
}
```

### Documentation

Each plugin should have:

1. **Clear README.md**:
```markdown
# Plugin Name

Brief description of what it does.

## Installation

\`\`\`bash
/plugin marketplace add username/repo
/plugin install plugin-name
\`\`\`

## Usage

\`\`\`bash
/command-example
\`\`\`

## Features

- Feature 1
- Feature 2

## Requirements

- Claude Code v1.0+
- Node.js 18+
```

2. **Detailed Command Documentation** (in command files)
3. **Examples** (in `examples/` directory)
4. **Changelog** (for version updates)

### Keywords

Choose relevant, searchable keywords:

```json
{
  "keywords": [
    "testing",           // Primary function
    "jest",             // Technology
    "automation",       // Use case
    "coverage",         // Feature
    "ci-cd"            // Context
  ]
}
```

### License

Specify clear licensing:

```json
{
  "license": "MIT",           // Permissive
  "license": "Apache-2.0",    // Patent grant
  "license": "GPL-3.0",       // Copyleft
  "license": "CC0-1.0"        // Public domain
}
```

## Testing Your Marketplace

### Pre-Publication Checklist

- [ ] All plugin paths in `marketplace.json` are correct
- [ ] Each plugin has valid `plugin.json`
- [ ] All commands/agents files exist at specified paths
- [ ] README.md is complete and accurate
- [ ] License file is present
- [ ] Repository is public (if sharing publicly)
- [ ] Installation works locally
- [ ] All commands execute without errors

### Testing Script

Create `test-marketplace.sh`:

```bash
#!/bin/bash

echo "🧪 Testing Claude Code Marketplace..."

# Test 1: Validate JSON
echo "✓ Validating marketplace.json..."
cat .claude-plugin/marketplace.json | jq . > /dev/null
if [ $? -eq 0 ]; then
  echo "  ✅ Valid JSON"
else
  echo "  ❌ Invalid JSON"
  exit 1
fi

# Test 2: Check required fields
echo "✓ Checking required fields..."
jq -e '.name, .owner, .metadata, .plugins' .claude-plugin/marketplace.json > /dev/null
if [ $? -eq 0 ]; then
  echo "  ✅ All required fields present"
else
  echo "  ❌ Missing required fields"
  exit 1
fi

# Test 3: Verify plugin paths
echo "✓ Verifying plugin paths..."
jq -r '.plugins[].source' .claude-plugin/marketplace.json | while read path; do
  if [ -d "$path" ] || [ "$path" = "./" ]; then
    echo "  ✅ Path exists: $path"
  else
    echo "  ❌ Path not found: $path"
    exit 1
  fi
done

echo "✅ All tests passed!"
```

## Promotion and Distribution

### Submit to Collections

Add your marketplace to curated lists:

1. **[Awesome Claude Code Plugins](https://github.com/awesome-claude-code/awesome-claude-code-plugins)**
2. **[Official Claude Code Discussions](https://github.com/anthropics/claude-code/discussions)**

### Share on Social Media

```markdown
🚀 Just published my Claude Code marketplace!

🔧 Features:
- [Feature 1]
- [Feature 2]
- [Feature 3]

📦 Install:
/plugin marketplace add username/repo

🔗 https://github.com/username/repo

#ClaudeCode #AI #Development
```

### Create a Website

Consider creating a landing page:

- Plugin showcase
- Installation instructions
- Live examples
- Documentation
- Blog/updates

Example: [aitmpl.com](https://aitmpl.com/)

## Maintenance

### Updating Your Marketplace

When adding new plugins or updating existing ones:

```bash
# 1. Update marketplace.json
# Add new plugin or update version

# 2. Commit changes
git add .claude-plugin/marketplace.json
git commit -m "feat: add new-plugin v1.0.0"

# 3. Tag release (optional)
git tag -a v1.1.0 -m "Release v1.1.0"
git push --tags

# 4. Users can update with:
# /plugin update
```

### Version Management

Keep track of changes:

```json
{
  "metadata": {
    "version": "2.0.0",
    "changelog": "https://github.com/user/repo/blob/main/CHANGELOG.md"
  }
}
```

### Deprecation

If deprecating a plugin:

```json
{
  "plugins": [
    {
      "name": "old-plugin",
      "deprecated": true,
      "deprecationMessage": "Use new-plugin instead",
      "replacement": "new-plugin"
    }
  ]
}
```

## Troubleshooting

### Common Issues

**Issue**: Plugin not found after installation
- ✅ Check `source` path in `marketplace.json`
- ✅ Verify plugin structure matches expected format
- ✅ Ensure `plugin.json` exists at correct location

**Issue**: Commands not recognized
- ✅ Check command file paths in `marketplace.json`
- ✅ Verify `.md` files exist in `commands/` directory
- ✅ Restart Claude Code after installation

**Issue**: Invalid JSON error
- ✅ Validate JSON syntax: `cat marketplace.json | jq .`
- ✅ Check for trailing commas
- ✅ Ensure proper quote escaping

## Additional Resources

- [Claude Code Plugin Reference](https://docs.claude.com/en/docs/claude-code/plugins-reference)
- [Marketplace Examples](https://github.com/davila7/claude-code-templates)
- [Plugin Creation Guide](./first-plugin.md)
- [Best Practices](../architecture/best-practices.md)

## Next Steps

After publishing:

1. ✅ Monitor issues and user feedback
2. ✅ Regular updates and maintenance
3. ✅ Engage with community
4. ✅ Share success stories
5. ✅ Contribute to ecosystem

---

**Need help?** Join the [Claude Developers Discord](https://anthropic.com/discord) or open an issue on GitHub.

**Happy publishing!** 🚀
