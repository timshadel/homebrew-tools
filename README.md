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

## Notes

Packages in this tap may be maintained here permanently or until they meet the requirements for inclusion in an official Homebrew repository.
