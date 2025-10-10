# Hello World Plugin

A minimal Claude Code plugin that demonstrates the basic structure.

## What This Plugin Does

Adds a `/hello` command that greets the user warmly.

## Structure

```
hello-world/
├── .claude-plugin/
│   └── plugin.json       # Plugin manifest
└── commands/
    └── hello.md          # Hello command
```

## Installation

### From Local Directory

```bash
cd /path/to/hello-world
claude
/plugin marketplace add ./
/plugin install hello-world
```

### Testing

```bash
/hello
```

Expected output:
> 👋 Hello! I'm your friendly Claude Code assistant. How can I help you code better today?

## Files

### .claude-plugin/plugin.json

```json
{
  "name": "hello-world",
  "version": "1.0.0",
  "description": "A simple greeting plugin",
  "author": "Your Name",
  "license": "MIT"
}
```

### commands/hello.md

```markdown
You are a friendly and enthusiastic assistant. Greet the user warmly and ask how you can help them with their coding tasks today. Keep it brief and welcoming.
```

## Key Concepts

1. **Minimal Structure**: Only requires `plugin.json` and at least one component
2. **Slash Commands**: Markdown files in `commands/` become `/command-name`
3. **Simple Prompts**: Command files contain instructions for Claude

## Next Steps

- Add more commands
- Try adding an agent
- Explore hooks
- Add MCP server integration

## Related Examples

- [Multiple Commands](../multiple-commands/) - Plugin with several commands
- [With Configuration](../with-config/) - Plugin with custom configuration
