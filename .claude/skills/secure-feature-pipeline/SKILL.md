---
name: secure-feature-pipeline
description: "Use when implementing a new feature or change in this Neovim configuration. Covers the full lifecycle: brainstorm, plan, implement, review, and fix. Invoked with command steps: brainstorm, plan, implement, review, fix."
---

# Feature Pipeline

## Overview

End-to-end feature delivery pipeline for this Neovim configuration. Takes a change from raw requirement through brainstorming, planning, implementation, and review.

**What counts as a "feature" here:**
- Adding or configuring a new plugin
- Adding/modifying keymaps
- Adding/modifying LSP servers or formatters
- UI changes (colorscheme, statusline, etc.)
- Refactoring existing config structure
- Bug fixes in the Lua config

**Core principle:** Understand the existing codebase first, plan the change precisely, implement it cleanly, and verify it works without breaking existing behavior.

**Announce at start:** "I'm using the feature-pipeline skill — step: `{step}`."

## CRITICAL: Do NOT Use Claude Code Plan Mode

**NEVER call `EnterPlanMode` when this skill is active.** This skill has its own planning process (Step 2: Plan).

## Priority Rule: Error Handling and Retries

1. **Investigate Root Cause First** — Read the error, identify WHY it failed
2. **DON'T Retry Immediately** — Same error will recur
3. **Retry Limit** — Max 5 retries, then ask user

## Command Steps

| Step | Command      | Input                     | Output                                    |
| ---- | ------------ | ------------------------- | ----------------------------------------- |
| 1    | `brainstorm` | Requirement (text)        | Spec file (`.claude/specs/YYYY-MM-DD-<feature>-spec.md`) |
| 2    | `plan`       | Spec file path            | Plan file (`.claude/plans/YYYY-MM-DD-<feature>-plan.md`) |
| 3    | `implement`  | Plan file path            | Implementation report (`.claude/reports/YYYY-MM-DD-<feature>-report.md`) |
| 4    | `review`     | Implementation report path | Review verdict (approve / issues found) |
| 5    | `fix`        | Issue description          | Loops back to step 1 (brainstorm the fix) |

## Step Routing

**Based on the command step, read the corresponding file for full instructions:**

| Step | File to Read |
| ---- | ------------ |
| 1 — Brainstorm | `./step-1-brainstorm.md` |
| 2 — Plan | `./step-2-plan.md` |
| 3 — Implement | `./step-3-implement.md` |
| 4 — Review | `./step-4-review.md` |
| 5 — Fix | `./step-5-fix.md` |

**STOP GATE — Do NOT proceed until you have read the step file.**

1. Use the `Read` tool to load the step file in full.
2. Before doing ANY work, cite the **Process flowchart** (or first heading) and **the output artifact path** from the file you just read. This proves you read it.

## Red Flags — STOP and Reassess

- Starting work on a step without citing the step file's process and output path
- Calling `EnterPlanMode` at any point
- Planning without reading the current config files
- Implementing without a spec
- Adding a plugin without checking if an existing plugin already covers the need
- Modifying keymaps without checking for conflicts in `keymaps.lua`
- Adding an LSP server without updating both `servers` table AND `ensure_installed`
- Adding a formatter without updating both `formatters_by_ft` AND `ensure_installed`
- Changing the colorscheme in only one place (must update both `colorscheme.lua` and lualine theme in `ui.lua`)
- Skipping verification after implementation (must test that Neovim starts without errors)
- Dispatching parallel agents on the same config files

## Prompt Templates

**Step 3 — Implementation:**
- `./implementer-agent-prompt.md` — Implementer: reads plan task, implements, self-reviews, produces structured report. Does NOT commit.
- `./reviewer-agent-prompt.md` — Reviewer: fresh context, reads actual code, runs 2 review stages (spec compliance + code quality), produces verdict. Does NOT commit.

## Project Architecture (Quick Reference)

- `init.lua` — Entry point, loads config modules then bootstraps Lazy.nvim
- `lua/config/options.lua` — Neovim settings
- `lua/config/keymaps.lua` — All keybindings (centralized)
- `lua/config/autocmds.lua` — Auto-commands
- `lua/config/lazy.lua` — Lazy.nvim bootstrap
- `lua/plugins/*.lua` — Each file returns a Lazy.nvim plugin spec table

**Key rules:**
- Keymaps are centralized in `keymaps.lua` (except buffer-local LSP/gitsigns keymaps set in `on_attach`)
- LSP servers: update both `servers` table in `lsp.lua` AND `ensure_installed` in mason-lspconfig
- Formatters: update both `formatters_by_ft` in `formatting.lua` AND `ensure_installed` in mason-tool-installer
- Colorscheme changes require updating both `colorscheme.lua` and lualine theme in `ui.lua`
- Format-on-save toggle: `vim.g.format_on_save` (`:ToggleFormatOnSave`)
