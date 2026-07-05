# Authsia for Homebrew

**Local-first secrets for macOS workspaces, terminal tools, SSH, and coding agents.**

Author: [James Liang](https://github.com/james-liang-cs)

Authsia keeps credentials in your Mac's Apple security stack while giving developers a clean way to run commands, wire project env refs, approve agent access, and use SSH keys without turning the shell into a bag of long-lived secrets.

```sh
brew install --cask james-liang-cs/authsia/authsia
```

Already installed from the DMG?

```sh
brew install --cask --adopt james-liang-cs/authsia/authsia
```

Requires macOS 26 or later.

## Why Authsia

Modern developer work crosses terminals, repo-local env files, AI coding agents, SSH keys, and automation scripts. Authsia gives those workflows a local secret boundary instead of spreading plaintext across shell history, dotfiles, prompts, and copied keys.

| Capability | What it gives you |
| --- | --- |
| Local-first vault | Passwords, notes, certificates, SSH keys, and 2FA data stay on your Mac through Apple security services. |
| Workspace refs | Store project secrets in Authsia and leave commit-safe `authsia://` refs in selected env files or `.authsia/workspace.json`. |
| Guarded terminal | Route supported developer tools through Authsia workspace mediation without exporting resolved secrets into the parent shell. |
| Agent JIT approvals | Let coding agents request short-lived, scoped access through Access Center, then revoke it when the work is done. |
| SSH signing | Adopt SSH keys into the vault and let Git/SSH use the local Authsia agent for signing. |
| Local audit and revoke | Review CLI and agent access locally, lock active sessions, and revoke grants from Access Center. |

## Install, Upgrade, Uninstall

Install Authsia.app and the bundled `authsia` CLI:

```sh
brew install --cask james-liang-cs/authsia/authsia
```

If Homebrew asks you to trust the tap first:

```sh
brew trust james-liang-cs/authsia
brew install --cask james-liang-cs/authsia/authsia
```

Authsia can update itself through Sparkle. To ask Homebrew to upgrade the cask-managed app path:

```sh
brew update
brew upgrade --cask --greedy authsia
```

Remove the app, CLI symlink, and running launch agents:

```sh
brew uninstall --cask authsia
```

Remove support files too:

```sh
brew uninstall --zap --cask authsia
```

Vault secrets live in Apple Keychain and are not removed by `uninstall` or `zap`.

## First Run

Launch Authsia once so it can register its local helpers, then enable CLI access:

```text
Authsia > Settings > Security > CLI Access
```

Check that the app, bridge, CLI, and SSH agent are ready:

```sh
authsia status
authsia doctor
```

## CLI Quickstart

Set up shell integration for the SSH agent and workspace helpers:

```sh
eval "$(authsia init zsh)"
```

Use `authsia init bash` if your shell is bash.

Create a workspace, keep refs commit-safe, and run commands through Authsia:

```sh
authsia workspace init
authsia workspace status
authsia workspace run -- npm test
```

Start guarded terminal shims in an existing shell:

```sh
eval "$(authsia workspace guard --print-env)"
```

Run shell-expanded commands inside the guarded child shell:

```sh
authsia workspace run --shell -- 'curl "$API_KEY"'
```

Adopt SSH keys into Authsia:

```sh
authsia ssh adopt --path ~/.ssh --dry-run
authsia ssh adopt --path ~/.ssh --yes --folder Infra/SSH
```

## What This Tap Installs

This cask installs:

- `Authsia.app`
- `authsia` CLI symlinked onto your Homebrew `PATH`
- uninstall hooks for `Authsia.Bridge` and `Authsia.SSHAgent`
- Sparkle livecheck metadata for release tracking

The CLI is linked from the app bundle:

```text
authsia -> /Applications/Authsia.app/Contents/Helpers/authsia
```

## Links

- Product site: https://authsia.clarionstack.com
- CLI guide: https://authsia.clarionstack.com/cli.html
- User guide: https://authsia.clarionstack.com/user-guide.html
- Changelog: https://authsia.clarionstack.com/changelog
- Release feed: https://authsia.clarionstack.com/appcast.xml
- Homebrew tap: https://github.com/james-liang-cs/homebrew-authsia

## Tap Maintenance

The cask lives in [`Casks/authsia.rb`](Casks/authsia.rb). Authsia updates itself with Sparkle, and Homebrew `livecheck` reads the public appcast so the cask can be audited against the latest release.
