# seo-audit

A Claude Code skill that runs a repo-wide, read-only sweep for **missing or
incomplete technical-SEO practices** — a fixed checklist of best practices
(search-engine verification, crawlable pagination, responsive images,
canonical tags, structured data, meta title/description, heading hierarchy,
alt text, robots.txt/sitemap health, hreflang, redirect chains, HTTPS/mixed
content, Core Web Vitals signals, URL structure, JS-render/prerender
coverage, Open Graph/Twitter tags, per-page robots meta), rather than
hunting for code that's actively wrong.

Framework-agnostic by design — the checklist categories describe *what* to
check and *why*, with discovery hints for finding the relevant
implementation across common stacks (React/CRA, Next.js, Vite, plain
server-rendered apps, etc.), not hardcoded paths.

## Install into a project

1. Copy `skills/seo-audit/categories.md` and `skills/seo-audit/seo-audit.md`
   into that project's `skills/seo-audit/` directory, unchanged.
2. Symlink `seo-audit.md` into the project's `.claude/commands/` directory
   so Claude Code resolves it as `/seo-audit`:
   ```bash
   ln -s ../../skills/seo-audit/seo-audit.md .claude/commands/seo-audit.md
   ```
3. Run `/seo-audit` in that project. Since it has no `project-checklist.md`
   yet, the first run treats every category as unaudited, uses
   `categories.md`'s discovery hints to find the equivalent implementation
   in that codebase, and creates a fresh `project-checklist.md` there as it
   goes.

## Two files, two jobs

- **`categories.md`** — generic, portable, framework-agnostic. Defines each
  technical-SEO category, why it matters, and how to *discover* the
  relevant implementation in an unfamiliar codebase. No hardcoded paths.
  Safe to copy verbatim into any project.
- **`seo-audit.md`** — the skill logic itself (also generic/portable): how
  to run the audit, verify findings before reporting them, and keep a
  per-project checklist up to date across runs.
- **`project-checklist.md`** — generated per-project, not included here.
  Each project that installs this skill gets its own instance with real
  file paths, current state, and a fast re-verification recipe per
  category. Never copy one project's checklist into another.

## How to use

```
/seo-audit                      # every category, using project-checklist.md's fast path + discovery for gaps
/seo-audit SEO-01               # one category only (e.g. search-engine verification)
/seo-audit add: <describe a new universal technical-SEO practice to track>
```

Every finding is re-verified against current code (a checklist entry
records a last-known state, but code moves) and reported as `STILL_OPEN`,
`PARTIALLY_RESOLVED`, `RESOLVED`, or `NOT_APPLICABLE`. The audit changes no
code — fixes go through explicit approval or your own follow-up process.

Each run also saves its full report — every category's status plus the
summary table — to `skills/seo-audit/reports/<YYYY-MM-DD>.md` in the
project being audited, so a given run's complete output is preserved as
its own shareable file, separate from `project-checklist.md`'s
cumulative last-known-state tracking.

## Categories (see `skills/seo-audit/categories.md` for full detail)

| ID | Category |
|---|---|
| SEO-01 | Search engine verification |
| SEO-02 | Crawlable pagination for infinite-scroll / paginated listings |
| SEO-03 | Responsive images (srcset/sizes, modern formats) |
| SEO-04 | Canonical tag correctness |
| SEO-05 | Structured data (JSON-LD) coverage & validity |
| SEO-06 | Meta title & description coverage |
| SEO-07 | Heading hierarchy |
| SEO-08 | Image alt text coverage |
| SEO-09 | Robots.txt & sitemap health |
| SEO-10 | hreflang / i18n signals |
| SEO-11 | Redirect chains & internal broken links |
| SEO-12 | HTTPS / mixed content |
| SEO-13 | Core Web Vitals signals |
| SEO-14 | URL structure & duplicate-content-prone query params |
| SEO-15 | JS-render / prerender coverage for crawlers |
| SEO-16 | Open Graph / Twitter Card social meta tags |
| SEO-17 | Per-page `<meta name="robots">` directives |
| SEO-18 | Viewport meta tag correctness |
| SEO-19 | Resource hints for LCP-critical origins (preconnect/dns-prefetch/preload) |

## Growing this skill

- New **universal** practice (applies to any project, no project-specific
  paths) → add it to `categories.md`.
- A **finding for a specific project** → belongs in that project's own
  `project-checklist.md`, not here.
- Wrong code already causing bugs (not a missing feature) is a different
  kind of check — this skill only tracks gaps against the checklist, not
  active bugs.
