# Creating Your First Claude Code Plugin

A step-by-step tutorial for creating a simple yet functional Claude Code plugin.

## What We'll Build

A **productivity timer plugin** that helps developers track focused work sessions using the Pomodoro technique.

**Features**:
- `/pomodoro start` - Start a 25-minute focus session
- `/pomodoro break` - Start a 5-minute break
- `/pomodoro status` - Check current timer status

## Prerequisites

- Claude Code installed (`npm install -g @anthropic-ai/claude-code`)
- Basic understanding of markdown
- Text editor
- 15 minutes of time

## Step 1: Create Plugin Directory

```bash
mkdir pomodoro-timer
cd pomodoro-timer
```

## Step 2: Create Plugin Manifest

Create `.claude-plugin/plugin.json`:

```bash
mkdir -p .claude-plugin
```

Create the manifest file:

```json
{
  "name": "pomodoro-timer",
  "version": "1.0.0",
  "description": "Productivity timer using the Pomodoro technique",
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "keywords": ["productivity", "timer", "pomodoro", "focus"]
}
```

### Understanding the Manifest

- `name`: Unique identifier (lowercase, hyphens only)
- `version`: Semantic version (MAJOR.MINOR.PATCH)
- `description`: What your plugin does
- `author`: Your contact information
- `license`: License identifier (e.g., MIT, Apache-2.0)
- `keywords`: Help users discover your plugin

## Step 3: Create Commands

Create the commands directory:

```bash
mkdir commands
```

### Command 1: Start Pomodoro

Create `commands/pomodoro-start.md`:

```markdown
# Start Pomodoro Timer

You are a productivity coach helping a developer start a focused work session.

1. **Acknowledge** the user is starting a 25-minute Pomodoro session
2. **Encourage** them to focus on a single task
3. **Suggest** turning off notifications and closing distractions
4. **Set a mental checkpoint** for 25 minutes from now

Use an enthusiastic but professional tone. Include a tomato emoji 🍅 to represent Pomodoro.

Example response:
"🍅 **Pomodoro Started!** You have 25 minutes of focused work time.

Tips for this session:
- Focus on ONE task only
- Turn off notifications
- Ignore non-urgent messages
- Take notes of ideas for later

I'll check in with you in 25 minutes. Let's make it count! 💪"
```

### Command 2: Start Break

Create `commands/pomodoro-break.md`:

```markdown
# Start Pomodoro Break

You are a productivity coach helping a developer take a productive break.

1. **Congratulate** them on completing a focus session
2. **Instruct** them to take a 5-minute break
3. **Suggest** break activities:
   - Stand up and stretch
   - Walk around
   - Get water or coffee
   - Look away from the screen
   - Rest your eyes

4. **Remind** them NOT to check email or social media during the break

Use a warm, encouraging tone. Include relevant emojis.

Example response:
"☕ **Break Time!** You've earned a 5-minute rest.

Great break activities:
- 🚶 Take a short walk
- 💧 Grab some water
- 🧘 Stretch your body
- 👀 Rest your eyes

Avoid:
- ❌ Email
- ❌ Social media
- ❌ Work tasks

See you in 5 minutes, refreshed and ready!"
```

### Command 3: Check Status

Create `commands/pomodoro-status.md`:

```markdown
# Pomodoro Status

You are a productivity tracker reporting on the user's Pomodoro progress.

Ask the user:
1. How many Pomodoros have they completed today?
2. What task are they currently working on?
3. How are they feeling about their focus?

Then provide:
- Encouragement based on their progress
- Suggestions for staying on track
- Reminder about the Pomodoro technique benefits

Be supportive and motivating!
```

## Step 4: Add Documentation

Create `README.md`:

```markdown
# Pomodoro Timer Plugin

A productivity plugin for Claude Code implementing the Pomodoro Technique.

## Installation

\`\`\`bash
# From local directory
cd /path/to/pomodoro-timer
/plugin marketplace add ./
/plugin install pomodoro-timer
\`\`\`

## Usage

### Start a Focus Session
\`\`\`bash
/pomodoro-start
\`\`\`

### Take a Break
\`\`\`bash
/pomodoro-break
\`\`\`

### Check Status
\`\`\`bash
/pomodoro-status
\`\`\`

## The Pomodoro Technique

1. Work for 25 minutes (one "Pomodoro")
2. Take a 5-minute break
3. After 4 Pomodoros, take a 15-30 minute break

## Benefits

- Improved focus and concentration
- Better time management
- Reduced mental fatigue
- Increased productivity

## License

MIT
```

## Step 5: Test Your Plugin

### Install Locally

```bash
# Navigate to your plugin directory
cd pomodoro-timer

# Start Claude Code
claude

# Add your plugin directory as a marketplace
/plugin marketplace add ./

# Install your plugin
/plugin install pomodoro-timer

# Test the commands
/pomodoro-start
/pomodoro-break
/pomodoro-status
```

### Verify Installation

```bash
# List installed plugins
/plugin list

# You should see: pomodoro-timer (v1.0.0)
```

## Step 6: Enhance Your Plugin

### Add an Agent (Optional)

Create `agents/pomodoro-coach.md`:

```markdown
# Pomodoro Productivity Coach

You are an expert productivity coach specializing in the Pomodoro Technique.

Your role:
- Help developers stay focused during work sessions
- Provide encouragement and motivation
- Suggest productivity improvements
- Track progress and celebrate wins
- Offer tips for better time management

Your personality:
- Supportive and encouraging
- Knowledgeable about productivity techniques
- Patient and understanding
- Enthusiastic about helping people succeed

When users struggle with focus or procrastination, provide:
1. Empathy for their challenges
2. Specific, actionable advice
3. Techniques to overcome obstacles
4. Encouragement to keep trying

Use the Pomodoro Technique as your primary framework but be flexible and adaptive to individual needs.
```

### Add Configuration (Optional)

Update `plugin.json` to include configurable timers:

```json
{
  "name": "pomodoro-timer",
  "version": "1.1.0",
  "description": "Productivity timer using the Pomodoro technique",
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "keywords": ["productivity", "timer", "pomodoro", "focus"],
  "config": {
    "workDuration": 25,
    "shortBreak": 5,
    "longBreak": 15,
    "sessionsBeforeLongBreak": 4
  }
}
```

## Step 7: Share Your Plugin

### Create a Git Repository

```bash
git init
git add .
git commit -m "Initial commit: Pomodoro Timer plugin"

# Create a repository on GitHub, then:
git remote add origin https://github.com/yourusername/pomodoro-timer
git push -u origin main
```

### Create a Marketplace Entry

Create `.claude-plugin/marketplace.json`:

```json
{
  "name": "Your Plugin Marketplace",
  "owner": {
    "name": "Your Name",
    "email": "your.email@example.com"
  },
  "plugins": [
    {
      "name": "pomodoro-timer",
      "source": "yourusername/pomodoro-timer",
      "description": "Productivity timer using the Pomodoro technique",
      "category": "productivity"
    }
  ]
}
```

### Share with the Community

1. Submit to [Awesome Claude Code Plugins](https://github.com/yourusername/awesome-claude-code-plugins)
2. Share in [Claude Developers Discord](https://anthropic.com/discord)
3. Post on social media with #ClaudeCode

## Complete Directory Structure

```
pomodoro-timer/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── commands/
│   ├── pomodoro-start.md
│   ├── pomodoro-break.md
│   └── pomodoro-status.md
├── agents/
│   └── pomodoro-coach.md
├── README.md
└── LICENSE
```

## Common Issues & Solutions

### Plugin Not Loading

**Problem**: Plugin doesn't appear after installation

**Solutions**:
1. Check `plugin.json` is valid JSON
2. Verify plugin name matches directory name
3. Restart Claude Code
4. Use `claude --debug` to see loading errors

### Commands Not Working

**Problem**: `/pomodoro-start` command not found

**Solutions**:
1. Ensure commands are in `commands/` directory
2. Check file extension is `.md`
3. Verify plugin is installed: `/plugin list`
4. Reload Claude Code

### JSON Syntax Errors

**Problem**: "Unexpected token" error

**Solutions**:
1. Validate JSON at [jsonlint.com](https://jsonlint.com)
2. Check for missing commas
3. Ensure proper quote usage
4. Remove trailing commas

## Next Steps

1. **Add More Features**:
   - Long break command
   - Session counter
   - Daily statistics

2. **Improve User Experience**:
   - Add hooks for automatic reminders
   - Create a status display agent
   - Add keyboard shortcuts

3. **Integrate External Tools**:
   - Connect to time tracking apps
   - Integration with calendar
   - Notification system via MCP

4. **Advanced Topics**:
   - [Working with Hooks](./hooks-tutorial.md)
   - [MCP Server Integration](./mcp-integration.md)
   - [Creating Specialized Agents](./creating-agents.md)

## Resources

- [Plugin System Architecture](../architecture/plugin-system.md)
- [Manifest Specification](../architecture/manifest-spec.md)
- [Example Plugins](../../examples/)
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/plugins)

## Congratulations! 🎉

You've created your first Claude Code plugin! Share it with the community and keep building!
