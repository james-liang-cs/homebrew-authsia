# Authsia

Local-first secrets for developers, installed through Homebrew.

Authsia gives you a macOS vault, the `authsia` CLI, guarded workspace commands,
agent JIT approvals, SSH signing, audit history, and browser autofill without
handing secrets to your shell or AI tooling by default.

## Install

Requires macOS 15 or later.

```sh
brew install --cask jamesliang-cs/authsia/authsia
```

If Homebrew asks you to trust the tap first:

```sh
brew trust jamesliang-cs/authsia
brew install --cask jamesliang-cs/authsia/authsia
```

Already installed from the DMG? Let Homebrew adopt the existing app:

```sh
brew install --cask --adopt jamesliang-cs/authsia/authsia
```

After install, launch Authsia once and enable CLI access in:

```text
Authsia > Settings > Security > CLI Access
```

## Why Developers Use Authsia

- Run commands with scoped secrets without exporting them into the parent shell.
- Give agents short-lived JIT access to specific work, then revoke it from Access Center.
- Keep SSH keys in the vault while Git and SSH use Authsia's local agent.
- Track secret access through local audit events.
- Use one local-first app for 2FA codes, passwords, notes, certificates, and SSH keys.

## Quick Start

```sh
authsia status
eval "$(authsia init zsh)"
authsia workspace init
authsia workspace run -- npm test
```

Use `authsia init bash` if your shell is bash.

## Useful Links

- Website: https://authsia.clarionstack.com
- CLI guide: https://authsia.clarionstack.com/cli.html
- Direct DMG download: https://authsia.clarionstack.com

## What This Tap Installs

This cask installs `Authsia.app` and links the bundled CLI onto your Homebrew
`PATH`:

```text
authsia -> /Applications/Authsia.app/Contents/Helpers/authsia
```

The app updates itself with Sparkle. Homebrew `livecheck` tracks the public
appcast so the cask can still be audited against the latest release.
