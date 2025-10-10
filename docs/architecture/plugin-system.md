# Claude Code Plugin System Architecture

> Comprehensive technical overview of the Claude Code plugin architecture

## Table of Contents

- [Overview](#overview)
- [Core Components](#core-components)
- [Plugin Lifecycle](#plugin-lifecycle)
- [File Structure](#file-structure)
- [Configuration System](#configuration-system)
- [Loading Mechanism](#loading-mechanism)
- [Security Model](#security-model)

## Overview

The Claude Code plugin system enables extending Claude Code functionality through a modular, declarative architecture. Plugins are self-contained packages that can include commands, agents, hooks, and MCP server configurations.

### Design Principles

1. **Modularity**: Each plugin is self-contained and independent
2. **Declarative**: Configuration over code where possible
3. **Composability**: Plugins can work together seamlessly
4. **Safety**: Sandboxed execution with user approval requirements
5. **Discoverability**: Marketplace system for finding and sharing plugins

## Core Components

### 1. Slash Commands

Custom shortcuts that expand to full prompts when executed.

**Location**: `commands/*.md`

**Format**: Markdown files containing prompt instructions

**Example**:
```markdown
<!-- commands/review-code.md -->
# Code Review Assistant

Perform a thorough code review focusing on:

1. **Code Quality**
   - Readability and maintainability
   - Adherence to style guides
   - DRY principles

2. **Potential Issues**
   - Logic errors
   - Edge cases
   - Performance bottlenecks

3. **Security**
   - Input validation
   - SQL injection risks
   - XSS vulnerabilities

Provide specific, actionable feedback.
```

**Usage**: `/review-code`

### 2. Subagents

Specialized AI agents for specific tasks, with their own prompts and behaviors.

**Location**: `agents/*.md`

**Format**: Markdown files with agent persona and instructions

**Example**:
```markdown
<!-- agents/feature-planner.md -->
# Feature Planning Agent

You are an expert product manager and system architect.

Your role:
- Analyze feature requests
- Break down into implementation tasks
- Identify technical dependencies
- Estimate complexity
- Suggest architectural approaches

Always consider:
- Scalability implications
- Security requirements
- Testing strategies
- Documentation needs

Output structured implementation plans.
```

**Activation**: Automatic when specific tasks match agent specialization

### 3. Hooks

Event-driven automation that triggers at specific workflow points.

**Location**: `hooks/hooks.json`

**Format**: JSON configuration with event handlers

**Supported Events**:
- `before-commit` - Before git commits
- `after-edit` - After file edits
- `before-push` - Before git push
- `on-error` - When errors occur
- `user-prompt-submit` - When user submits prompt

**Example**:
```json
{
  "hooks": [
    {
      "event": "before-commit",
      "script": "./scripts/pre-commit-checks.sh",
      "description": "Run linting and tests",
      "approval_required": false
    },
    {
      "event": "after-edit",
      "script": "./scripts/auto-format.sh",
      "description": "Auto-format edited files",
      "approval_required": true
    }
  ]
}
```

### 4. MCP Servers

Model Context Protocol server integrations for external tools and data sources.

**Location**: `.mcp.json`

**Format**: JSON configuration for MCP server connections

**Example**:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "database": {
      "command": "docker",
      "args": ["run", "my-db-mcp-server"],
      "disabled": false
    }
  }
}
```

## Plugin Lifecycle

### 1. Discovery

```
User → /plugin marketplace add owner/repo
     ↓
Claude Code fetches marketplace.json
     ↓
Available plugins listed
```

### 2. Installation

```
User → /plugin install plugin-name
     ↓
Claude Code clones/downloads plugin
     ↓
Validates plugin.json manifest
     ↓
Copies to ~/.claude/plugins/
     ↓
Plugin available for activation
```

### 3. Activation

```
User enables plugin → Plugin components loaded
                    ↓
Commands registered → Available as /command
                    ↓
Hooks registered → Event listeners active
                    ↓
MCP servers started → External tools connected
                    ↓
Agents available → Specialized behaviors active
```

### 4. Execution

```
User invokes command/trigger → Hook validates
                             ↓
                        Approval required? → Yes → Prompt user
                             ↓ No                      ↓
                        Execute action ← Approved ← User approves
                             ↓
                        Return results
```

### 5. Update

```
Plugin maintainer releases v2.0
     ↓
Claude Code detects new version
     ↓
Notifies user of available update
     ↓
User approves update
     ↓
Old version backed up
     ↓
New version installed
```

## File Structure

### Complete Plugin Structure

```
my-enterprise-plugin/
├── .claude-plugin/
│   ├── plugin.json              # Manifest (required)
│   └── marketplace.json         # Marketplace metadata (optional)
│
├── commands/                    # Slash commands
│   ├── deploy.md
│   ├── review-pr.md
│   └── generate-docs.md
│
├── agents/                      # Specialized agents
│   ├── security-auditor.md
│   ├── performance-optimizer.md
│   └── test-generator.md
│
├── hooks/                       # Workflow hooks
│   ├── hooks.json
│   └── scripts/
│       ├── pre-commit.sh
│       ├── post-deploy.sh
│       └── error-handler.sh
│
├── scripts/                     # Utility scripts
│   ├── setup.sh
│   ├── install-deps.sh
│   └── cleanup.sh
│
├── .mcp.json                   # MCP server configs
├── README.md                    # Plugin documentation
└── LICENSE                      # License file
```

### Path Resolution

All paths in configuration files must be relative and start with `./`:

```json
{
  "hooks": [
    {
      "script": "./hooks/scripts/pre-commit.sh"  // ✅ Correct
    },
    {
      "script": "/absolute/path/script.sh"       // ❌ Invalid
    },
    {
      "script": "script.sh"                      // ❌ Invalid
    }
  ]
}
```

**Environment Variable**: `${CLAUDE_PLUGIN_ROOT}` resolves to plugin installation directory.

## Configuration System

### Plugin Manifest (plugin.json)

**Required Fields**:
- `name` (string) - Unique plugin identifier
- `version` (string) - Semantic version (e.g., "1.2.3")

**Optional Fields**:
- `description` (string) - Brief plugin description
- `author` (string) - Plugin creator
- `homepage` (string) - Plugin website URL
- `repository` (string) - Source code repository
- `license` (string) - License identifier (e.g., "MIT")
- `keywords` (string[]) - Search keywords
- `dependencies` (object) - Required plugins
- `engines` (object) - Version requirements

**Full Example**:
```json
{
  "name": "enterprise-workflow",
  "version": "2.1.0",
  "description": "Enterprise development workflow automation",
  "author": "Acme Corp <dev@acme.com>",
  "homepage": "https://acme.com/claude-plugins",
  "repository": "https://github.com/acme/claude-enterprise-plugin",
  "license": "MIT",
  "keywords": ["enterprise", "workflow", "automation", "ci-cd"],
  "dependencies": {
    "security-scanner": "^1.0.0"
  },
  "engines": {
    "claude-code": ">=1.0.0"
  }
}
```

### Marketplace Manifest (marketplace.json)

```json
{
  "name": "Acme Plugin Marketplace",
  "owner": {
    "name": "Acme Corporation",
    "url": "https://acme.com",
    "email": "support@acme.com"
  },
  "description": "Official Acme plugins for Claude Code",
  "plugins": [
    {
      "name": "enterprise-workflow",
      "source": "https://github.com/acme/enterprise-workflow",
      "description": "Enterprise workflow automation",
      "category": "development"
    },
    {
      "name": "security-suite",
      "source": "./plugins/security-suite",
      "description": "Security scanning and compliance",
      "category": "security"
    }
  ]
}
```

## Loading Mechanism

### 1. Plugin Discovery

```typescript
// Pseudocode for plugin loading
async function loadPlugins() {
  const pluginDirs = [
    '~/.claude/plugins/',           // Global plugins
    './.claude-plugins/',           // Project-local plugins
    process.env.CLAUDE_PLUGIN_PATH  // Custom path
  ];

  for (const dir of pluginDirs) {
    const plugins = await discoverPlugins(dir);
    for (const plugin of plugins) {
      await loadPlugin(plugin);
    }
  }
}
```

### 2. Component Registration

```typescript
async function loadPlugin(pluginPath: string) {
  // 1. Load and validate manifest
  const manifest = await loadManifest(`${pluginPath}/.claude-plugin/plugin.json`);
  validateManifest(manifest);

  // 2. Register commands
  const commands = await loadCommands(`${pluginPath}/commands/`);
  registerCommands(commands);

  // 3. Register agents
  const agents = await loadAgents(`${pluginPath}/agents/`);
  registerAgents(agents);

  // 4. Register hooks
  const hooks = await loadHooks(`${pluginPath}/hooks/hooks.json`);
  registerHooks(hooks);

  // 5. Start MCP servers
  const mcpConfig = await loadMCP(`${pluginPath}/.mcp.json`);
  await startMCPServers(mcpConfig);
}
```

### 3. Priority and Conflicts

**Resolution Order**:
1. Built-in Claude Code commands (highest priority)
2. User-defined commands in `.claude/`
3. Plugin commands (by load order)
4. Default behaviors (lowest priority)

**Conflict Handling**:
- Duplicate command names: Last loaded plugin wins
- Warning logged to console
- Use `claude --debug` to see resolution details

## Security Model

### Sandboxing

1. **File System Access**
   - Plugins can only access files within their installation directory
   - Cross-plugin access requires explicit permissions

2. **Network Access**
   - MCP servers run in isolated processes
   - Network calls require user approval for first execution

3. **Script Execution**
   - Scripts must be executable (`chmod +x`)
   - Shell scripts run with restricted permissions
   - User approval required for sensitive operations

### Permission System

**Automatic Approval**: Safe operations (reading files, running tests)
**User Approval Required**:
- Writing/modifying files
- Git operations (commit, push)
- Network requests
- Installing dependencies
- Executing external commands

### Hook Safety

```json
{
  "hooks": [
    {
      "event": "before-commit",
      "script": "./scripts/lint.sh",
      "approval_required": false,      // Auto-approved: read-only
      "timeout": 30000                 // 30 second timeout
    },
    {
      "event": "before-push",
      "script": "./scripts/deploy.sh",
      "approval_required": true,       // Requires approval: writes data
      "timeout": 300000                // 5 minute timeout
    }
  ]
}
```

## Debugging

### Enable Debug Mode

```bash
claude --debug
```

**Debug Output Includes**:
- Plugin loading sequence
- Component registration
- Hook executions
- MCP server startup
- Error stack traces

### Common Issues

1. **Plugin Not Loading**
   - Check `plugin.json` is valid JSON
   - Verify paths are relative and start with `./`
   - Ensure files are in correct directories

2. **Commands Not Available**
   - Verify plugin is activated (`/plugin list`)
   - Check for naming conflicts (`claude --debug`)
   - Reload Claude Code

3. **Hooks Not Firing**
   - Verify `hooks.json` syntax
   - Check script is executable
   - Review event name spelling

## Performance Considerations

### Plugin Load Time

- Commands: ~1ms per command
- Agents: ~5ms per agent
- Hooks: ~2ms per hook
- MCP servers: ~100-500ms per server (varies by server)

### Memory Usage

- Average plugin: ~5-10MB
- MCP servers: ~20-100MB each (varies by implementation)

### Optimization Tips

1. **Lazy Loading**: Load components only when needed
2. **Caching**: Cache frequently used data
3. **Minimal Dependencies**: Keep plugin dependencies minimal
4. **Async Operations**: Use async for I/O operations

## Best Practices

1. **Semantic Versioning**: Follow semver for plugin versions
2. **Clear Documentation**: Include README with usage examples
3. **Error Handling**: Gracefully handle and report errors
4. **Testing**: Test plugins across different environments
5. **Security**: Never include secrets in plugin code
6. **Performance**: Minimize startup time and resource usage

## Future Enhancements

Planned features for the plugin system:

- Plugin dependency resolution
- Automatic update notifications
- Plugin analytics and telemetry (opt-in)
- Enhanced security sandboxing
- Plugin marketplace curation
- Cross-plugin communication APIs

---

**See Also**:
- [Manifest Specification](./manifest-spec.md)
- [Marketplace Protocol](./marketplace-protocol.md)
- [Hook System Details](./hooks.md)
- [MCP Integration Guide](./mcp-integration.md)
