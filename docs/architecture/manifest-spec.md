# Plugin Manifest Specification

> Complete technical specification for `plugin.json` and `marketplace.json`

## Table of Contents

- [plugin.json Specification](#pluginjson-specification)
- [marketplace.json Specification](#marketplacejson-specification)
- [Validation Rules](#validation-rules)
- [Examples](#examples)

## plugin.json Specification

### Schema

```typescript
interface PluginManifest {
  // Required fields
  name: string;                    // Unique plugin identifier
  version: string;                 // Semantic version

  // Metadata (optional but recommended)
  description?: string;            // Brief description
  author?: string | Author;        // Author information
  homepage?: string;               // Plugin website
  repository?: string | Repository;// Source code location
  license?: string;                // License identifier
  keywords?: string[];             // Search keywords

  // Dependencies (optional)
  dependencies?: {
    [pluginName: string]: string;  // Version range
  };

  // Requirements (optional)
  engines?: {
    "claude-code"?: string;        // Claude Code version requirement
    node?: string;                 // Node.js version requirement
  };

  // Configuration (optional)
  config?: {
    [key: string]: any;            // Plugin-specific configuration
  };
}

interface Author {
  name: string;
  email?: string;
  url?: string;
}

interface Repository {
  type: string;                    // e.g., "git"
  url: string;                     // Repository URL
}
```

### Field Details

#### name (required)

**Type**: `string`

**Rules**:
- Lowercase alphanumeric with hyphens
- Must start with letter
- 3-50 characters
- Must be unique in marketplace

**Valid Examples**:
```json
"name": "code-reviewer"
"name": "test-automation-suite"
"name": "my-plugin-123"
```

**Invalid Examples**:
```json
"name": "Code Reviewer"    // No spaces
"name": "123-plugin"       // Can't start with number
"name": "my_plugin"        // No underscores
```

#### version (required)

**Type**: `string`

**Format**: Semantic Versioning 2.0.0

**Pattern**: `MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]`

**Examples**:
```json
"version": "1.0.0"
"version": "2.3.1"
"version": "1.0.0-alpha"
"version": "1.0.0-beta.1"
"version": "1.0.0+20230615"
```

#### description (optional)

**Type**: `string`

**Max Length**: 200 characters

**Best Practices**:
- Clear and concise
- Describe main functionality
- No marketing language

**Examples**:
```json
"description": "Automated code review with security scanning"
"description": "Test generation and coverage analysis tools"
```

#### author (optional)

**Type**: `string | object`

**String Format**:
```json
"author": "John Doe <john@example.com> (https://johndoe.com)"
```

**Object Format**:
```json
"author": {
  "name": "John Doe",
  "email": "john@example.com",
  "url": "https://johndoe.com"
}
```

#### homepage (optional)

**Type**: `string` (URL)

**Examples**:
```json
"homepage": "https://github.com/username/plugin"
"homepage": "https://mycompany.com/claude-plugins/my-plugin"
```

#### repository (optional)

**Type**: `string | object`

**String Format**:
```json
"repository": "https://github.com/username/plugin"
```

**Object Format**:
```json
"repository": {
  "type": "git",
  "url": "https://github.com/username/plugin.git"
}
```

#### license (optional)

**Type**: `string`

**Common Values**: SPDX License Identifiers

**Examples**:
```json
"license": "MIT"
"license": "Apache-2.0"
"license": "GPL-3.0"
"license": "BSD-3-Clause"
"license": "ISC"
"license": "UNLICENSED"
```

#### keywords (optional)

**Type**: `string[]`

**Max Items**: 10
**Max Length per Keyword**: 30 characters

**Examples**:
```json
"keywords": ["testing", "automation", "quality-assurance"]
"keywords": ["deployment", "ci-cd", "devops"]
```

#### dependencies (optional)

**Type**: `object`

**Format**: `{ "plugin-name": "version-range" }`

**Version Range Syntax**:
- `1.0.0` - Exact version
- `^1.0.0` - Compatible with 1.x.x
- `~1.0.0` - Compatible with 1.0.x
- `>=1.0.0` - Greater than or equal
- `<2.0.0` - Less than
- `1.0.0 - 2.0.0` - Range

**Example**:
```json
"dependencies": {
  "security-scanner": "^2.0.0",
  "code-formatter": "~1.5.0",
  "test-runner": ">=3.0.0 <4.0.0"
}
```

#### engines (optional)

**Type**: `object`

**Common Engines**:
- `claude-code` - Claude Code version
- `node` - Node.js version

**Example**:
```json
"engines": {
  "claude-code": ">=1.0.0",
  "node": ">=18.0.0"
}
```

#### config (optional)

**Type**: `object`

**Purpose**: Plugin-specific configuration with defaults

**Example**:
```json
"config": {
  "maxFileSize": 1048576,
  "enableCache": true,
  "outputFormat": "markdown"
}
```

### Complete Example

```json
{
  "name": "enterprise-security-suite",
  "version": "2.1.0",
  "description": "Comprehensive security scanning and compliance checking for enterprise applications",
  "author": {
    "name": "Acme Security Team",
    "email": "security@acme.com",
    "url": "https://acme.com/security"
  },
  "homepage": "https://acme.com/claude-plugins/security-suite",
  "repository": {
    "type": "git",
    "url": "https://github.com/acme/security-suite.git"
  },
  "license": "MIT",
  "keywords": [
    "security",
    "compliance",
    "scanning",
    "audit",
    "enterprise"
  ],
  "dependencies": {
    "vulnerability-db": "^3.0.0"
  },
  "engines": {
    "claude-code": ">=1.0.0",
    "node": ">=18.0.0"
  },
  "config": {
    "scanTimeout": 300000,
    "severityThreshold": "medium",
    "reportFormat": "json"
  }
}
```

## marketplace.json Specification

### Schema

```typescript
interface MarketplaceManifest {
  name: string;                    // Marketplace name
  owner: Owner;                    // Marketplace owner
  description?: string;            // Marketplace description
  url?: string;                    // Marketplace website
  plugins: PluginEntry[];          // Available plugins
}

interface Owner {
  name: string;                    // Owner name
  email?: string;                  // Contact email
  url?: string;                    // Owner website
}

interface PluginEntry {
  name: string;                    // Plugin name (matches plugin.json)
  source: string;                  // Plugin source location
  description?: string;            // Plugin description
  category?: string;               // Plugin category
  tags?: string[];                 // Additional tags
  featured?: boolean;              // Featured plugin
}
```

### Field Details

#### name (required)

**Type**: `string`

**Purpose**: Marketplace identifier

**Example**:
```json
"name": "Acme Enterprise Plugin Marketplace"
```

#### owner (required)

**Type**: `object`

**Example**:
```json
"owner": {
  "name": "Acme Corporation",
  "email": "plugins@acme.com",
  "url": "https://acme.com"
}
```

#### plugins (required)

**Type**: `array`

**Plugin Entry Fields**:

- **name** (required): Plugin identifier
- **source** (required): Plugin location
  - GitHub: `owner/repo` or `https://github.com/owner/repo`
  - Git: `https://gitlab.com/owner/repo.git`
  - Local: `./path/to/plugin`
- **description** (optional): Brief description
- **category** (optional): Plugin category
- **tags** (optional): Additional metadata
- **featured** (optional): Highlight in marketplace

**Example**:
```json
"plugins": [
  {
    "name": "code-reviewer",
    "source": "acme/code-reviewer",
    "description": "Automated code review with AI",
    "category": "development",
    "tags": ["quality", "automation"],
    "featured": true
  },
  {
    "name": "deploy-helper",
    "source": "https://github.com/acme/deploy-helper",
    "description": "Deployment automation tools",
    "category": "devops"
  },
  {
    "name": "local-plugin",
    "source": "./plugins/custom-formatter",
    "description": "Custom code formatter",
    "category": "tools"
  }
]
```

### Complete Example

```json
{
  "name": "Acme Enterprise Plugins",
  "owner": {
    "name": "Acme Corporation",
    "email": "plugins@acme.com",
    "url": "https://acme.com"
  },
  "description": "Official enterprise plugins for Claude Code by Acme Corporation",
  "url": "https://acme.com/claude-plugins",
  "plugins": [
    {
      "name": "security-scanner",
      "source": "acme/security-scanner",
      "description": "Comprehensive security vulnerability scanning",
      "category": "security",
      "tags": ["security", "compliance", "audit"],
      "featured": true
    },
    {
      "name": "test-automation",
      "source": "acme/test-automation",
      "description": "Automated test generation and execution",
      "category": "testing",
      "tags": ["testing", "quality", "ci-cd"]
    },
    {
      "name": "doc-generator",
      "source": "https://github.com/acme/doc-generator",
      "description": "Automatic documentation generation",
      "category": "documentation",
      "tags": ["docs", "automation"]
    }
  ]
}
```

## Validation Rules

### Validation Process

1. **JSON Syntax**: Must be valid JSON
2. **Schema Compliance**: All required fields present
3. **Type Checking**: Fields match expected types
4. **Format Validation**: URLs, versions, names conform to patterns
5. **Dependency Resolution**: Referenced plugins exist
6. **Version Compatibility**: Engine requirements satisfied

### Common Validation Errors

```json
{
  "error": "INVALID_NAME",
  "message": "Plugin name must be lowercase with hyphens",
  "field": "name",
  "value": "My Plugin"
}
```

```json
{
  "error": "INVALID_VERSION",
  "message": "Version must follow semantic versioning",
  "field": "version",
  "value": "1.0"
}
```

```json
{
  "error": "MISSING_REQUIRED_FIELD",
  "message": "Required field 'name' is missing",
  "field": "name"
}
```

### Validation Tools

**Command Line**:
```bash
# Validate plugin manifest
claude plugin validate ./path/to/plugin

# Validate marketplace manifest
claude plugin validate-marketplace ./marketplace.json
```

**Programmatic**:
```typescript
import { validatePluginManifest } from '@anthropic-ai/claude-code';

const manifest = require('./plugin.json');
const result = validatePluginManifest(manifest);

if (result.valid) {
  console.log('✓ Manifest is valid');
} else {
  console.error('✗ Validation errors:', result.errors);
}
```

## Examples

### Minimal Plugin

```json
{
  "name": "simple-greeter",
  "version": "1.0.0"
}
```

### Standard Plugin

```json
{
  "name": "code-formatter",
  "version": "1.2.3",
  "description": "Automatic code formatting for multiple languages",
  "author": "Jane Developer <jane@dev.com>",
  "license": "MIT",
  "keywords": ["formatting", "style", "prettier"]
}
```

### Enterprise Plugin

```json
{
  "name": "enterprise-workflow-suite",
  "version": "3.0.0",
  "description": "Complete enterprise development workflow automation",
  "author": {
    "name": "Enterprise DevTools Team",
    "email": "devtools@enterprise.com",
    "url": "https://enterprise.com/devtools"
  },
  "homepage": "https://enterprise.com/claude-plugins/workflow-suite",
  "repository": {
    "type": "git",
    "url": "https://github.com/enterprise/workflow-suite.git"
  },
  "license": "Apache-2.0",
  "keywords": [
    "enterprise",
    "workflow",
    "automation",
    "ci-cd",
    "deployment"
  ],
  "dependencies": {
    "security-scanner": "^2.0.0",
    "compliance-checker": "^1.5.0",
    "deployment-tools": "~3.2.0"
  },
  "engines": {
    "claude-code": ">=1.5.0",
    "node": ">=18.0.0"
  },
  "config": {
    "enableSecurityScanning": true,
    "complianceStandards": ["SOC2", "GDPR"],
    "deploymentTargets": ["production", "staging"],
    "maxParallelDeployments": 3
  }
}
```

## Schema Files

JSON Schema files for validation:

- [plugin.schema.json](../schemas/plugin.schema.json)
- [marketplace.schema.json](../schemas/marketplace.schema.json)

---

**See Also**:
- [Plugin System Architecture](./plugin-system.md)
- [Creating Your First Plugin](../tutorials/first-plugin.md)
- [Publishing to Marketplaces](../tutorials/publishing-plugins.md)
