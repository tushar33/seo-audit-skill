# Contributing

This is a Claude Code skill: two Markdown files (`skills/seo-audit/categories.md`
and `skills/seo-audit/seo-audit.md`) that instruct the model how to run a
technical-SEO completeness audit. There's no code, no scripts, no
dependencies — contributions are welcome, but the review bar is "does this
actually generalize," not "does this pass tests."

## Ground rules

- **`categories.md` stays generic, forever.** No hardcoded file paths, no
  framework-specific implementation details as the *only* detection method
  (name a stack's tool as an example, not a requirement — see how SEO-01's
  discovery hints cover CRA/Vite, Next.js, and plain server apps side by
  side). If a change only makes sense for one stack or one project, it
  belongs in that project's own `project-checklist.md`, not here.
- **Read-only by default.** The skill's job is to report gaps, not fix
  them. Any workflow change that would make it edit code, commit, or open
  tickets without explicit user approval first is out of scope.
- **Evidence-first.** `seo-audit.md`'s Rules section already requires
  re-running a category's detection recipe before reporting a gap as real,
  and flags "manual check required" categories as needing that check before
  they count as findings. New categories should carry the same discipline —
  a grep hit is a candidate, not a finding.
- **Each category is self-contained.** What it is → why it matters → how to
  detect it generically → discovery hints across a few common stacks → when
  it's N/A. Keep new entries in that shape so the file stays skimmable.

## Reporting a problem with the skill

Open an issue with: which category (e.g. `SEO-06`), what the skill told you
to check or how it phrased the finding, and what was wrong or unclear about
it. If a detection approach or discovery hint turned out not to generalize
across stacks the way it claims to, that's a good bug report — include which
stack broke it.

## Adding a new category

- Only add a category that's a **universal** technical-SEO practice —
  applicable across projects and frameworks, not specific to how one site
  happens to be built.
- Follow the existing five-part structure (What / Why / Generic detection /
  Discovery hints / N/A when) and give discovery hints for more than one
  stack where practical.
- Pick the next available `SEO-NN` ID and add it to the categories table in
  `README.md` as well as `categories.md`.
- If you're not sure whether something is universal enough, open an issue
  describing the practice before writing the full entry — cheaper to align
  on scope early than to rewrite it.

## Adding to the workflow (`seo-audit.md`)

Changes here should make the audit more accurate or more useful across *any*
project, not encode assumptions from one codebase. If your change assumes a
particular file-tree convention (e.g. where `reports/` lives, how
`.claude/commands/` is wired), call that out explicitly as a convention
rather than baking it in silently.
