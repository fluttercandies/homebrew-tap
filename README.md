# fluttercandies/homebrew-tap

**[简体中文](README-ZH.md)** | English

Organization-wide Homebrew tap for [FlutterCandies](https://github.com/fluttercandies) CLI and developer tools, providing a single Homebrew distribution entry point for tools published by the organization.

**Current status**: this repository contains infrastructure only (structure, basic checks, onboarding docs); no formulae have been published yet. Install commands become usable once the first formula lands.

## Scope

- Hosts Homebrew formulae for CLI / developer tools **publicly released** by FlutterCandies.
- This tap is a **distribution entry point only**: formulae describe how to download, verify and install released artifacts. No source build logic lives here.
- One formula per tool (`Formula/<name>.rb`); tools stay independent of each other unless truly dependent.
- Not accepted: internal-only tools, closed-source/private software (Homebrew distributes over the public internet), third-party software unrelated to the organization.

## Install

```bash
# Option 1: install directly (recommended; Homebrew trusts just this formula)
brew install fluttercandies/tap/<formula-name>

# Option 2: tap first, then install
brew tap fluttercandies/tap
brew install <formula-name>
```

> **Homebrew 7+ tap trust**: formulae from non-official taps are untrusted by default. Option 1 implicitly trusts the single formula being installed; with Option 2 you need to trust explicitly first:
>
> ```bash
> brew trust --formula fluttercandies/tap/<formula-name>   # trust one formula
> # or
> brew trust --tap fluttercandies/tap                      # trust the whole tap
> ```

## Repository layout

```text
homebrew-tap/
├── Formula/                  # all formulae (currently empty)
├── .github/
│   ├── workflows/
│   │   └── ci.yml            # basic check: tap syntax & naming conventions
│   └── dependabot.yml        # keeps GitHub Actions used by CI up to date
└── README.md                 # this document: conventions & onboarding
```

## Formula conventions

When adding or updating a formula:

- **Location & naming**: one file per tool at `Formula/<name>.rb`. The name uses lowercase letters, digits and hyphens (`-`) and matches the actual CLI command; the Ruby class follows Homebrew's conversion (`foo-bar` → `class FooBar < Formula`).
- **Version**: `version` mirrors the tool's GitHub Release tag (convention: `v` prefix + semantic versioning; Homebrew usually derives it from the URL). A release update changes only `url`, `version`, `sha256` (plus dependencies that actually changed) — no unrelated edits.
- **Download URL**: must point to a public, directly downloadable, immutable artifact (prefer that tool's GitHub Release assets) over HTTPS.
- **Multiple platforms**: macOS must cover both Apple Silicon (`aarch64`) and Intel (`x86_64`); add Linux as needed. Use `on_macos`/`on_arm`/`on_intel`/`on_linux` blocks to give each platform its own `url` and `sha256`.
- **SHA256**: mandatory, and it must be the SHA256 of the asset **the end user's platform downloads** — not of some "primary" asset. A missing or mismatched SHA256 blocks merging.
- **Quality gates**: `brew audit --strict` and `brew style` must pass before merging (see below), and the CI tap syntax check must be green.
- **Prohibited**: committing credentials/tokens; install logic that fetches and executes arbitrary remote scripts; `bottle` blocks before the organization decides to enable bottles (see [Open decisions](#open-decisions)).

## Verification

### Local checklist (every formula add/update)

```bash
# 1. Audit & style
brew audit --strict --formula fluttercandies/tap/<name>
brew style --formula fluttercandies/tap/<name>

# 2. Install from the released artifact (--build-from-source bypasses caches)
brew install --build-from-source fluttercandies/tap/<name>

# 3. Smoke test (at least --version / --help, or one core command)

# 4. Upgrade / reinstall / uninstall (verify upgrade when bumping a version;
#    verify at least once that uninstall followed by install works)
brew upgrade <name>
brew reinstall <name>
brew uninstall <name>
```

If the formula defines a `test do ... end` block, also run `brew test <name>`.

### CI (automatic in this repository)

Every push to `main` and every pull request runs [`brew test-bot --only-tap-syntax`](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap), validating Ruby syntax plus file/class naming for everything in the tap. It depends on no particular tool, so it runs fine on an empty tap.

## Onboarding a new project

The standard flow for bringing a project into this tap:

1. **Prepare a release**: tag a version in the project repository (recommended: `v` + semver), create a GitHub Release (a final release, not a prerelease, unless intentionally rolling out gradually), and upload build artifacts as release assets.
2. **Provide platform assets**: at minimum macOS Apple Silicon and Intel, plus Linux as needed. Asset names include the tool name, version, OS and CPU architecture (e.g. `<name>-<version>-<os>-<arch>.<ext>`) and, once chosen, stay stable across all future releases of that tool. **Naming and packaging (zip / tar.gz, …) are decided when the project onboards** — this tap does not impose a house style.
3. **Generate & publish SHA256**: compute SHA256 for every asset inside the build pipeline (`shasum -a 256 <asset>` or `sha256sum <asset>`) and publish them alongside the release (e.g. in the release notes) for the formula and for human cross-checking. After publishing, `brew fetch --formula fluttercandies/tap/<name>` re-verifies.
4. **Create / review the formula**: add or update `Formula/<name>.rb`. The first onboarding goes through PR review (at least one other maintainer confirms name, dependencies and install logic); later version bumps state the tool and version in the PR and only need `url` / `version` / `sha256` checked against the upstream release.
5. **Verify the install**: run the local checklist above (audit / style / install / smoke / upgrade / reinstall / uninstall).
6. **Land it in this tap**: open a pull request against `main` of `fluttercandies/homebrew-tap`. Any GitHub account can open a PR against a public repository — **the manual phase needs no extra permissions or tokens**. After CI passes and review approves, users can `brew install fluttercandies/tap/<name>`.

## Automated publishing & cross-repository updates (design only, not implemented)

Today we run **phase 0 (manual PRs)**. As the number of tools grows, evolve on demand — nothing needs to be pre-configured:

- **Phase 1 — automated PRs from tool repositories**: a tool's release workflow updates its formula here and opens a PR automatically (still human-reviewed before merge). Credentials are described under [Permissions & credentials](#permissions--credentials). Alternatively `repository_dispatch` could trigger a workflow in this tap to do the update, but it needs the same level of credentials, adds maintenance surface to this repository, and is not the preferred option.
- **Phase 2 — tap-side automation (available from the official template whenever needed)**: Homebrew's own `brew tap-new` template ships two optional workflows to adopt at that point:
  - `brew bump`, a daily job that checks upstream for new versions and opens PRs (works with the default `GITHUB_TOKEN` alone);
  - a bottle (pre-built binary) build & publish pipeline (`--only-formulae` + `brew pr-pull` + GitHub Packages/GHCR), which speeds up user installs but introduces bottle root-url and GHCR credential conventions — **enabling it is an open decision**.

## Permissions & credentials

- **This repository's CI**: the `GITHUB_TOKEN` needs read-only access (`contents: read`). No custom secrets are configured today, and no unrelated secrets should be added.
- **Cross-repository updates (future)**: phase 1 automation needs a credential that can write to this repository. Pick one:
  - **Fine-grained PAT** (recommended starting point): grant it **Contents: Read & write on `fluttercandies/homebrew-tap` only** — no other repositories, no other permissions. Store it in the **tool repository's** Actions secrets (e.g. `HOMEBREW_TAP_TOKEN`); never commit it, never print it.
  - **Organization GitHub App** (at scale): install it on the tool repositories and grant Contents: Read & write on this tap; exchange the app's key for short-lived installation tokens instead of a long-lived PAT.
- **General rules**: least privilege (write to this repository only, never admin), regular rotation, immediate revocation on offboarding/handover; record the credential name and purpose in the tool repository's README.
- **Never** request relaxations of organization security policies, branch protection or review rules for automation convenience; if genuinely needed, go through organization admin review.

## Open decisions

These choices depend on each tool's language and build system, or on real scale, and are **decided at onboarding time** rather than fixed here:

- Asset naming and packaging per tool (zip / tar.gz / single binary), and whether to cover Linux.
- Whether to enable bottles (GHCR publishing, root-url conventions, a `publish` workflow and its secrets).
- How far to automate formula updates (manual PR / release-triggered PR / daily `brew bump`).
- Cross-repository credential type (fine-grained PAT vs GitHub App).
- Whether a formula needs a `livecheck` block (recommended where the project has a stable release feed).
- Branch protection, required checks and the repository license (organization admin decisions).

## Links

- Organization: <https://github.com/fluttercandies>
- Maintaining a tap: <https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap>
- Formula Cookbook: <https://docs.brew.sh/Formula-Cookbook>
