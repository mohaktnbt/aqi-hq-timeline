# SOP-001: No Silent Failures — Git Push Protocol

> **Author:** Founding Engineer (3cfc33fd-ade6-49c0-8d92-0c96e11d7852)  
> **Issue:** AQIAAA-28  
> **Status:** ✅ Active  
> **Created:** 2026-03-17  
> **Applies To:** All agents performing git operations

---

## Background

Multiple agents have marked git push tasks as "Succeeded" when in fact zero changes reached the GitHub remote repositories. This was caused by:

1. **Missing remote URLs** — local repos had no `origin` remote configured
2. **Credential failures** — headless PM2 environment could not read cached credentials
3. **Unrelated histories** — diverged local and remote git histories caused silent aborts
4. **No output verification** — agents did not capture and verify `git push` terminal output

This SOP is **mandatory for all agents** and prevents "git black holes" going forward.

---

## Rule 1: Always Use Verbose Push

**NEVER run:** `git push`

**ALWAYS run:** `git push -v`

The `-v` flag outputs the remote response line by line. If the push fails, the error is visible in the transcript. Without `-v`, failures can appear silent.

```bash
# ✅ CORRECT
git push -v origin main

# ❌ FORBIDDEN
git push
```

---

## Rule 2: Verify Push Output — Required Transcript Lines

After every `git push -v`, the agent MUST confirm the following line appears in output:

```
To https://github.com/mohaktnbt/<repo-name>.git
   <old-sha>..<new-sha>  main -> main
```

If instead you see:

```
Everything up-to-date
```

This means **no new commits were pushed**. Do NOT mark the task as complete — investigate why no new commits were made.

If you see any `fatal:` or `error:` lines — **the push FAILED**. Copy the exact error into your task transcript and do NOT mark the task as succeeded.

---

## Rule 3: Hard-Wired Remote URLs

All repository remotes MUST use embedded token authentication:

```bash
# ✅ CORRECT format (token embedded)
git remote set-url origin "https://mohaktnbt:<TOKEN>@github.com/mohaktnbt/<repo>.git"

# ❌ WRONG (relies on system credential store — fails in PM2/headless)
git remote set-url origin "https://github.com/mohaktnbt/<repo>.git"
```

### Current Repository Remote URLs

| Local Path | Remote URL |
|------------|------------|
| `/home/mohak/aqi-website` | `https://mohaktnbt:<TOKEN>@github.com/mohaktnbt/AQI-DASBOARD-DATA-PIPELINE.git` |
| `/home/mohak/aqi-hq/projects/hq-timeline` | `https://mohaktnbt:<TOKEN>@github.com/mohaktnbt/aqi-hq-timeline.git` |
| `/home/mohak/aqi-hq/projects/dashboard-pipeline` | `https://mohaktnbt:<TOKEN>@github.com/mohaktnbt/AQI-DASBOARD-DATA-PIPELINE.git` |

> The token is stored in `~/.git-credentials`. To re-embed it, run:
> ```bash
> GH_TOKEN=$(grep -o 'ghp_[^@]*' ~/.git-credentials | head -1)
> git remote set-url origin "https://mohaktnbt:${GH_TOKEN}@github.com/mohaktnbt/<repo>.git"
> ```

---

## Rule 4: Pre-Push Checklist

Before any `git push`, complete this checklist:

```
[ ] 1. git status  — confirm changes are staged and committed
[ ] 2. git log --oneline -3  — confirm commits exist locally
[ ] 3. git remote -v  — confirm remote URL includes embedded token
[ ] 4. git push -v origin main  — push with verbose output
[ ] 5. Read output — confirm "sha..sha main -> main" line present
[ ] 6. Copy output to task transcript
```

---

## Rule 5: Verify on GitHub (Optional but Recommended)

To independently verify the push reached GitHub:

```bash
GH_TOKEN=$(grep -o 'ghp_[^@]*' ~/.git-credentials | head -1)
curl -s -H "Authorization: token $GH_TOKEN" \
  "https://api.github.com/repos/mohaktnbt/<repo>/commits?per_page=1" | \
  python3 -c "import sys,json; d=json.load(sys.stdin); print(d[0]['sha'][:7], d[0]['commit']['message'][:60])"
```

Expected output: the SHA and message of your latest commit.

---

## Failure Reporting Protocol

If a git push fails:

1. **Do NOT mark the task as Succeeded**
2. Copy the exact error output into the task transcript
3. Common errors and fixes:

| Error | Cause | Fix |
|-------|-------|-----|
| `fatal: No configured push destination` | No remote set | `git remote add origin <token-url>` |
| `fatal: Authentication failed` | Token expired or wrong | Update `~/.git-credentials` |
| `error: failed to push some refs` | Local behind remote | `git pull --rebase && git push` |
| `fatal: refusing to merge unrelated histories` | Diverged repos | `git merge origin/main --allow-unrelated-histories` |

---

## Visibility Tool

Run `bash ~/check_pulse.sh` at any time to see:

- Last 3 commits across all repos
- Any uncommitted files
- True sync status with GitHub (verified via API)

---

> **This SOP is non-negotiable. Silent failures erode trust and stall the organization. When in doubt, run `check_pulse.sh` and report the output.**
