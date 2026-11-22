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

### `currently`

Currently is an alpha UPS monitoring daemon that exposes a NUT-compatible server,
Prometheus, REST, and SNMP. Its macOS IOKit USB access is designed to coexist with
Apple's native UPS shutdown handling, but has not yet been validated on real
macOS UPS hardware. This tap pins the upstream v0.1.0-alpha1 release.

```bash
brew install --cask timshadel/tools/currently
currently detect
currently serve
```

In another terminal, run `currently status` and `currently vars <UPS_NAME>`.
Verify that `ups.load` is reported correctly and `pmset -g ps` still shows
the UPS before enabling a persistent service. To preserve native macOS UPS
shutdown, **do not configure Currently's `shutdown:` section**. Currently's
NUT server can then be exposed to Home Assistant on a LAN-only interface.

## Notes

Packages in this tap may be maintained here permanently or until they meet the requirements for inclusion in an official Homebrew repository.
