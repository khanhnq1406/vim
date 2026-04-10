# Step 4: Review

**Input:** Implementation report path from implement step.

**Goal:** Final review of the entire implementation against the spec, checking spec completeness and code quality across all changed files.

---

### Process

1. **Read the implementation report**
2. **Read the original spec**
3. **Dispatch review agents in parallel:**

   a. **Spec Compliance Review** — Read ALL changed files, verify against every requirement in the spec

   b. **Code Quality Review** — Verify Lua code follows project conventions, no redundant code, consistent style

4. **Compile verdict:**
   - **APPROVED** — All reviews pass, ready to commit
   - **ISSUES FOUND** — List specific issues with severity and `file:line` references

### Verdict Format

```markdown
## Review Verdict: [APPROVED / ISSUES FOUND]

### Spec Compliance: [PASS / FAIL]

[Details — which requirements were met, which were missed]

### Code Quality: [PASS / FAIL]

[Details — Lua style, project conventions, any issues]

### Issues (if any)

| # | Severity | Category | Description | File:Line |
| - | -------- | -------- | ----------- | --------- |
| 1 | Critical | Spec     | ...         | ...       |

### Recommendation

[Approve / Fix issues and re-review]
```
