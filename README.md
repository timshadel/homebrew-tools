# Homebrew Tools Tap

This personal Homebrew tap provides command-line tools and macOS applications that are not available from the official Homebrew repositories.

## Installation

First, add the tap:

```bash
brew tap timshadel/tools
```

Then install any package listed below.

## Formulae

### `pikchr`

Command-line tool for rendering Pikchr diagrams as SVG.

```bash
brew install pikchr
```

## Casks

### `flying-logic`

Flying Logic visual reasoning and planning software. Supports Intel and Apple Silicon Macs running macOS 11 or later.

```bash
brew install --cask timshadel/tools/flying-logic
```

The official download includes a 14-day trial. Continued editing requires a paid subscription; after the trial, the app can still open documents in Reader Mode. `brew livecheck --cask timshadel/tools/flying-logic` checks the vendor's download page for updates. The vendor replaces the DMGs at unversioned URLs, so the cask uses Homebrew's `sha256 :no_check` convention.

### `gsd-path`

OpenGSD Path desktop dashboard for the GSD Path AI agent workflow. Supports Intel and Apple Silicon Macs.

```bash
brew install --cask gsd-path
```

The daily GitHub Actions updater follows `app-v*` desktop releases, including upstream's prerelease builds, and opens a pull request with the new version and both DMG SHA-256 hashes. It can also be run manually using the **Bump GSD Path cask** workflow.

### `omlx`

Official oMLX LLM inference server and menu bar application for Apple Silicon Macs running macOS 26 or 27.

```bash
brew install --cask omlx
```

### `openclaw-1p-sdk-resolver`

OpenClaw exec secrets provider backed by the official 1Password Go SDK. Supports Intel and Apple Silicon Macs.

```bash
brew install --cask openclaw-1p-sdk-resolver
```

## Currently UPS monitor (formula)

Currently is a UPS monitoring daemon exposing NUT, REST, Prometheus and SNMP.
This tap installs the upstream macOS release for Apple Silicon or Intel, including
the CLI and its plugins. Installation requires no Go toolchain. **No hardware IDs, device names, IP addresses or
shutdown policies are included in the formula.**

The formula is versioned by a daily and manually dispatched **Bump Currently
formula** GitHub Actions workflow, which verifies upstream’s signed checksum
manifest and opens review PRs for new upstream
releases (including prereleases) rather than merging them automatically.

### Install and migrate from the previous cask

If the old binary-only cask is installed, stop any foreground Currently process
and uninstall that cask before installing the formula:

```bash
brew uninstall --cask timshadel/tools/currently
brew install timshadel/tools/currently
currently version
```

### Approve the first launch on macOS if prompted

The upstream macOS release is not notarized. On macOS 27.2.1, Gatekeeper may
show **“currently” Not Opened** when you first run `currently version`.
On a headless Mac, connect through Screen Sharing to see the alert.

1. Click **Done** to dismiss the alert. The first command may end with
   `zsh: killed`.
2. On the Mac running Currently, open **System Settings → Privacy & Security**,
   scroll to **Security**, and click **Open Anyway** for Currently.
3. Run `currently version` again. Click **Open Anyway** in the second alert
   and authenticate with an administrator password when prompted.
4. Confirm that the version prints, then run `currently version` once more
   to check that it runs without another prompt.

Use this process for the **Apple could not verify** alert after verifying
the download. See [Apple’s Gatekeeper guidance](https://support.apple.com/en-us/102445).

Once the version check succeeds, run `currently detect` before configuring the
service. Homebrew leaves the service stopped at installation.

### Configure for monitoring only

Discover the local UPS(es), then generate an operator-owned configuration:

```bash
currently init --yes --no-shutdown --output "$(brew --prefix)/etc/currently/currently.yaml"
currently config validate --config "$(brew --prefix)/etc/currently/currently.yaml"
```

**No `shutdown:` section** means Currently will not shut down the host.
The operator can deliberately enable a shutdown policy later, without
reinstalling. Native macOS UPS shutdown management remains independent.

The default `listen.nut` and `listen.http` values bind only to localhost.
For a remote NUT client (such as Home Assistant), opt in by editing the
operator's `currently.yaml` and setting `listen.nut` to the intended LAN
address and port (for example, `"0.0.0.0:3493"`). Restrict access to the
trusted network; NUT reads need no login. No remote publishing is enabled by
the formula itself.

### Recommended: start at boot as a system service

```bash
sudo brew services start timshadel/tools/currently
sudo brew services list
```

This installs a system LaunchDaemon and runs without anyone being logged in.
Use `sudo brew services restart timshadel/tools/currently` after changing the
config. The formula uses Homebrew's stable `opt` path and keeps per-machine
configuration outside versioned installs. The service is optional; user-level
service management is also supported by Homebrew.

`brew services` with sudo runs the service as root and trusts Homebrew's prefix
owner; review the Homebrew security guidance before enabling system service.

## Notes

Packages in this tap may be maintained here permanently or until they meet the requirements for inclusion in an official Homebrew repository.
