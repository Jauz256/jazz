# Global Claude Context

## About Me
- Name: Aung Kyaw Min
- Working Directory: /Users/aungkyawmin
- Platform: macOS (Darwin)

## Model Preference
- **Always use Opus 4.5** (claude-opus-4-5-20251101) for all tasks
- For GSD: Use **quality** profile (`/gsd:set-profile quality`)
- For Ralph Loop: Specify `--model opus` when available

## My Workflow Philosophy
- Ship fast, iterate often
- Use GSD for structured planning and execution
- Use Ralph Loop for complex tasks requiring iteration
- Prefer pragmatic solutions over over-engineering

## Installed Tools

### GSD (Get Shit Done) - `/gsd:*`
For structured, spec-driven development with fresh context per task.

**Key Commands:**
- `/gsd:help` - Show all commands
- `/gsd:new-project` - Start new project with guided setup
- `/gsd:map-codebase` - Analyze existing codebase
- `/gsd:create-roadmap` - Break project into phases
- `/gsd:plan-phase [N]` - Generate atomic tasks for phase
- `/gsd:execute-plan` - Run tasks with fresh 200k context each
- `/gsd:progress` - Check status and next steps

### Ralph Loop - `/ralph-loop`
For autonomous iteration until task completion.

**Usage:**
```
/ralph-loop "Task description" --max-iterations 20 --completion-promise "DONE"
```

**Project Setup:**
```
Install Ralph loops in this project. Verification command is `pnpm verify`.
```

## When to Use What

| Situation | Tool |
|-----------|------|
| New project from scratch | `/gsd:new-project` |
| Understanding existing codebase | `/gsd:map-codebase` |
| Building features with clear specs | GSD workflow |
| Debugging, complex iteration | Ralph Loop |
| Quick single task | Direct prompting |

## Code Preferences
- Write clean, readable code
- Avoid over-abstraction
- Test critical paths
- Commit atomically with clear messages

## Project Structure Convention
When I create new projects, follow this general structure:
```
project/
├── src/           # Source code
├── tests/         # Test files
├── docs/          # Documentation
├── scripts/       # Utility scripts
└── README.md      # Project overview
```

## Rules
- Ask clarifying questions before major decisions
- Don't over-engineer simple solutions
- Keep dependencies minimal
- Prefer composition over inheritance
- Write self-documenting code
