# Step 2: Plan

**REMINDER: Do NOT call `EnterPlanMode`. Write the plan directly to `.claude/plans/` using this skill's process below.**

**Input:** Spec file path from brainstorm step.

**Goal:** Create a detailed, bite-sized implementation plan with exact file paths and exact Lua code changes per task.

**Output:** Plan file at `.claude/plans/YYYY-MM-DD-<feature>-plan.md`

---

### Process

1. **Read the spec file completely**
2. **Read the affected config files** — Understand the exact current state before proposing changes
3. **Break into tasks** — Each task is 1-3 minutes of work (one logical change)
4. **Order tasks** — Dependencies first (e.g., add plugin spec before adding its keymaps)
5. **Write the plan file**

### Plan File Structure

Save to: `.claude/plans/YYYY-MM-DD-<feature>-plan.md`

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence]
**Spec:** [Path to spec file]

---

### Task 1: [Task Name]

**Files:**

- Modify: `lua/plugins/example.lua` (lines ~N-M)
- OR Create: `lua/plugins/new-plugin.lua`

**Steps:**

1. [Exact description of what to change]
2. [Include the exact Lua code to add/modify if helpful]
3. [Commit]

---

### Task N: [Task Name]

**Files:**

- Modify: `lua/config/keymaps.lua`

**Steps:**

1. Add keymap: `vim.keymap.set("n", "<key>", "<action>", { desc = "description" })`
2. Verify no conflict with existing keymaps
3. Commit
```

### Task Granularity

Each task should be one logical unit:
- One plugin spec file (create or modify)
- One section of keymaps
- One LSP server + its `ensure_installed` entry
- One formatter + its `ensure_installed` entry

**Every multi-part change must have both parts in the same task** (e.g., adding an LSP server always includes both the `servers` table and `ensure_installed` — never split these).

### Consistency Rules (Enforce in Plan)

- **LSP server:** Task must update BOTH `servers` table AND `ensure_installed` in `lua/plugins/lsp.lua`
- **Formatter:** Task must update BOTH `formatters_by_ft` AND `ensure_installed` in `lua/plugins/formatting.lua`
- **Colorscheme:** Task must update BOTH `lua/plugins/colorscheme.lua` AND lualine theme in `lua/plugins/ui.lua`
- **Keymap:** Task must include conflict check against `lua/config/keymaps.lua`
