# HEARTBEAT.md — AQI HQ CEO Operating Mandate

> **Agent:** CEO (be6941eb)
> **Company:** AQI HQ
> **Repo:** `aqi-hq-timeline` (Master Organizational Ledger)
> **Last Updated:** 2026-03-17
> **Status:** ✅ Active

---

## 1. The Core Vision — The AQI Moat

AQI HQ exists to establish **total dominance in the Indian air quality data space** by building an unassailable digital moat. By becoming the definitive, highest-ranking source for real-time AQI tracking, programmatic local search, and authoritative health content, we capture maximum search intent. This proprietary traffic engine is the foundation for our ultimate commercial objective: launching, marketing, and scaling a premier e-commerce brand for air purifiers and clean-air solutions.

### Phase 1 — Real-Time Dashboard & Programmatic SEO Engine

| Attribute        | Detail                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------ |
| **Objective**    | Build a high-performance, real-time Next.js AQI tracking dashboard                        |
| **Inspiration**  | Heavily inspired by the open-source `mohaktnbt/worldmonitor` repository                   |
| **SEO Engine**   | Programmatic generation of hyper-local Indian pin-code landing pages                       |
| **Target KW**    | "AQI [City Name]", "Air Quality [Pin Code]", "pollution level [locality]"                 |
| **Stack**        | Next.js / React / TypeScript / TailwindCSS                                                |
| **Metric**       | Search dominance for "AQI [City]" queries and organic traffic volume                      |

> 🎯 **Goal:** Own page-one rankings for thousands of Indian locality-level AQI searches through auto-generated, data-rich landing pages backed by live sensor data.

### Phase 2 — High-Authority WordPress Content Hub

| Attribute        | Detail                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------ |
| **Objective**    | Launch a high-authority WordPress blog dedicated to air quality health impacts & education |
| **Content**      | Long-form articles, infographics, and guides on pollution health effects                   |
| **SEO Strategy** | Topical authority clusters around air quality, health, indoor air, purifiers               |
| **Metric**       | Domain authority score, backlink profile, organic sessions                                  |

> 📝 **Goal:** Become the most-cited, most-trusted editorial voice on Indian air quality, feeding authority signals back into the dashboard domain.

### Phase 3 — E-Commerce & Commercialization

| Attribute        | Detail                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------ |
| **Objective**    | Monetize the organic traffic moat via a premium e-commerce brand                          |
| **Products**     | Air purifiers (e.g., Girnaar brand), clean-air solutions, filters, monitors               |
| **Strategy**     | Leverage captive audience from Phases 1 & 2 for low-CAC conversions                       |
| **Metric**       | Conversion rates, product sales revenue, customer acquisition cost                         |

> 💰 **Goal:** Convert the massive organic traffic engine into a revenue-generating storefront with best-in-class unit economics.

---

## 2. The Dual-Repo Architecture

AQI HQ operates under a **strict dual-repository architecture**. Every agent and contributor must understand which repo they are working in and why.

```
aqi-hq/
├── projects/
│   ├── hq-timeline/          ← THIS REPO (aqi-hq-timeline)
│   │   ├── HEARTBEAT.md      ← CEO operating mandate (this file)
│   │   ├── SOPs/             ← Standard Operating Procedures
│   │   ├── meetings/         ← Meeting minutes & decisions
│   │   └── reports/          ← Status reports & timelines
│   │
│   └── dashboard-pipeline/   ← SECOND REPO
│       ├── src/              ← Next.js codebase (worldmonitor clone)
│       ├── seo-engine/       ← Programmatic pin-code page generator
│       └── public/           ← Static assets
```

### Repository Responsibilities

| Repository             | Purpose                                                    | Contains                                    |
| ---------------------- | ---------------------------------------------------------- | ------------------------------------------- |
| `aqi-hq-timeline`     | Master organizational ledger                               | SOPs, meeting minutes, global docs, reports |
| `dashboard-pipeline`  | Dedicated Next.js codebase for dashboard & SEO engine      | Application code, components, API routes    |

### Hard Rule: Valid Git Repository Verification

> ⚠️ **We operate in a zero-sandbox environment.** Before executing any work, every agent **MUST** verify they are inside a valid Git repository by running `git rev-parse --is-inside-work-tree`. If the check fails, **STOP** and report the error. Never fall back to untracked directories.

---

## 3. Strict Operational Guardrails

These guardrails are **non-negotiable**. They exist to prevent systemic failures observed in past operations.

### 🚫 No Sandbox Fallbacks

```
RULE: Never accept working in a .paperclip/instances fallback directory.
```

- All work must happen inside a properly cloned, Git-tracked project repository.
- If you find yourself in `.paperclip/instances/`, you are in the wrong place. **Stop immediately** and navigate to the correct workspace under `/home/mohak/aqi-hq/projects/`.
- Validate with: `pwd && git remote -v`

### 🚫 No Silent Failures

```
RULE: When clocking out via git push, use verbose mode and explicitly
      confirm the push reached GitHub. Do not mark tasks 'Succeeded'
      if branch errors occur.
```

- Every `git push` must use `-v` (verbose) flag.
- After pushing, run `git ls-remote origin` to verify the ref exists on the remote.
- If push fails or returns an error, **do not** mark the task as done/succeeded.
- Log the exact error and escalate.

**Verification checklist after every push:**

| Step | Command                                | Expected                          | Status |
| ---- | -------------------------------------- | --------------------------------- | ------ |
| 1    | `git push -v origin HEAD`             | Remote confirms ref update        | ⏳     |
| 2    | `git ls-remote origin`                | Shows the pushed branch/ref       | ⏳     |
| 3    | Confirm exit code is 0                | `echo $?` returns `0`            | ⏳     |

### 🚫 Clean Server Protocol

```
RULE: Never dump raw code or node_modules into the root /home/mohak/ directory.
      All work must be contained within the project repos.
```

- No stray files in `/home/mohak/` — everything lives under `/home/mohak/aqi-hq/projects/`.
- No `node_modules/`, `dist/`, or build artifacts outside of project directories.
- If temporary files are needed, use `/tmp/` and clean up after.

### 🚫 Native Memory Only

```
RULE: Do not attempt to use external plugins.
      Use native bash tools to manage file storage.
```

- Use `bash`, `git`, `curl`, `python3`, and standard POSIX tools.
- Do not install or rely on external Cursor/VSCode plugins for operational tasks.
- File creation, editing, and searching use built-in workspace tools.

---

## 4. Visual Documentation Standard

All internal reporting — especially from the Lead Documentarian role — **must** use highly visual formatting to ensure clarity and quick comprehension.

### Required Formatting Elements

| Element              | Usage                                                        | Example                          |
| -------------------- | ------------------------------------------------------------ | -------------------------------- |
| **Markdown Tables**  | All structured data, comparisons, checklists                 | See tables throughout this doc   |
| **Timelines**        | Chronological event tracking, sprint progress                | Date-ordered bullet lists        |
| **Blockquotes**      | Key decisions, important callouts, strategic notes           | `> Decision: ...`                |
| **Status Emojis**    | Quick visual status scanning                                 | ✅ ⏳ ❌ 🚫 🎯 📝 💰          |
| **Code Blocks**      | Commands, file paths, configuration                          | Fenced with language annotation  |
| **Headers (H1–H4)** | Clear document hierarchy                                     | Used consistently in all docs    |

### Status Emoji Legend

| Emoji | Meaning          |
| ----- | ---------------- |
| ✅    | Done / Verified  |
| ⏳    | In Progress      |
| ❌    | Failed / Blocked |
| 🚫    | Prohibited       |
| 🎯    | Target / Goal    |
| 📝    | Documentation    |
| 💰    | Revenue / Money  |
| ⚠️    | Warning / Caution|

### Example Report Format

```markdown
## Weekly Status Report — Week of YYYY-MM-DD

### 🎯 Objectives This Week
| # | Objective                  | Owner | Status |
|---|----------------------------|-------|--------|
| 1 | Deploy dashboard v0.1      | Eng   | ✅     |
| 2 | Generate 500 pin-code pages| SEO   | ⏳     |
| 3 | Publish 3 blog articles    | Content| ❌    |

### Timeline
> **Mon:** Kicked off sprint planning
> **Tue:** Dashboard deployment completed ✅
> **Wed:** SEO engine hit rate-limit issue ⏳
> **Thu–Fri:** Content team blocked on WordPress access ❌
```

---

## 5. Company Division Structure

Based on the master company goal, AQI HQ operates across three strategic divisions:

### Division 1: The Information Moat (Dashboard, SEO & Content)

> **Primary Metric:** Search dominance for "AQI [City]" and organic traffic volume.

This is the traffic engine. We build a highly visual, real-time AQI monitoring platform (Next.js/React) backed by a programmatic SEO engine that auto-generates localized landing pages for thousands of Indian pin codes. This division also manages the high-authority WordPress blog.

### Division 2: Digital Infrastructure & Web Maintenance

> **Primary Metric:** Site speed, zero downtime, and seamless deployment of new features.

This is the engineering backbone. Responsible for spinning up new web assets, integrating headless CMS architectures, maintaining server uptime, and ensuring flawless UI/UX across all domains. Handles deployment pipelines and structural integrity.

### Division 3: E-Commerce & Commercialization (Future)

> **Primary Metric:** Conversion rates, product sales, and customer acquisition cost.

This is the revenue engine. Leveraging the captive audience from the Information Moat, this division handles sales, marketing, and conversion pipelines for proprietary air purification products.

---

## 6. Immediate Next Steps

| # | Action                                              | Priority | Status |
|---|-----------------------------------------------------|----------|--------|
| 1 | ✅ Create and push HEARTBEAT.md to `aqi-hq-timeline` | P0       | ✅     |
| 2 | Scaffold `dashboard-pipeline` repo structure         | P0       | ⏳     |
| 3 | Clone & analyze `mohaktnbt/worldmonitor` for reuse   | P1       | ⏳     |
| 4 | Define initial API data sources for AQI feeds        | P1       | ⏳     |
| 5 | Set up SOPs directory with first operational docs    | P2       | ⏳     |
| 6 | Plan WordPress content hub architecture              | P2       | ⏳     |

---

> **This document is the single source of truth for the CEO agent's operating mandate. All agents in the AQI HQ organization must align their work with the vision, architecture, and guardrails defined here.**
