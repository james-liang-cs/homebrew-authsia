# Authsia

**Runtime security for AI coding agents.**

Agents can run commands. They don’t inherit your secrets until you say so.

Authsia is a macOS vault and execution broker. Credentials stay in your local
Keychain. Coding agents request scoped, time-boxed access. You approve, deny,
or revoke from Access Center.

```sh
brew install --cask james-liang-cs/authsia/authsia
```

Already installed from the DMG?

```sh
brew install --cask --adopt james-liang-cs/authsia/authsia
```

Requires macOS 26 or later. [Website](https://authsia.clarionstack.com) ·
[CLI guide](https://authsia.clarionstack.com/cli.html) ·
[Verify a release](https://authsia.clarionstack.com/verify.html)

## The gap a vault leaves open

A coding agent runs with your permissions. It can launch tools, touch cloud
CLIs, and act on your machine. A password manager that only protects secrets
at rest does not decide whether that agent should receive a credential
**right now**.

Once a secret is in the parent shell, traditional controls lose the plot:
who used it, which command ran, and how to take it back.

Authsia is the local enforcement layer between your Mac, the AI agent, and
the process that needs the secret. It does not replace a team vault for
sharing and lifecycle.

## Core features

### Approve the agent, not the whole shell

Access is a grant, not a standing environment variable. You see who is
asking, the workspace and command scope, and how long access lasts. End the
grant when the task is done.

Claude Code, Codex, Cursor, and similar callers request short-lived `exec` or
list access. Approve from Access Center — or a paired iPhone — then revoke
without changing project files.

### Last-mile injection

Projects keep commit-safe `authsia://` references instead of plaintext.
Authsia resolves them at the last mile and injects credentials into the
approved child process only. The parent shell stays clean. Known secret
values can be masked on mediated output.

```sh
authsia workspace init
authsia workspace run -- npm test
```

### MCP gateway for local servers

Coding clients launch filesystem, shell, browser, and other MCP servers with
your full local authority. Authsia is the local MCP gateway: wrap those
stdio servers — or serve validated localhost Streamable HTTP — so admission,
JIT, and revoke apply before the child runs.

Open MCP Manager, protect a scanned connection, and the client starts Authsia
instead of the raw server. Secrets stay behind Keychain references. Remote
HTTP MCP stays on your company gateway; Authsia covers the local lane.

```sh
authsia mcp start
authsia mcp configure --client codex
```

### Guarded terminal

Route supported developer tools through Authsia without exporting resolved
secrets into the parent environment.

```sh
eval "$(authsia workspace guard --print-env)"
```

### SSH without exporting the key

Adopt SSH keys into the vault. Git and SSH sign through Authsia’s agent
(`SSH_AUTH_SOCK`) under the same approval policy — not by dumping a private
key into the shell.

```sh
eval "$(authsia init zsh)"
authsia ssh adopt --path ~/.ssh --dry-run
```

### Local audit, local revoke

Access Center and `authsia audit list` record what was released, who
approved it, and what ran under that grant. No telemetry leaves the Mac.

## Install, upgrade, uninstall

```sh
brew install --cask james-liang-cs/authsia/authsia
```

If Homebrew asks you to trust the tap first:

```sh
brew trust james-liang-cs/authsia
brew install --cask james-liang-cs/authsia/authsia
```

Authsia can update itself through Sparkle. To ask Homebrew to upgrade the
cask-managed app path:

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

Vault secrets live in Apple Keychain and are not removed by `uninstall` or
`zap`.

## First run

Launch Authsia once so it can register its local helpers, then enable CLI
access:

```text
Authsia > Settings > Security > CLI Access
```

```sh
authsia status
authsia doctor
```

## What this repository is

This is the public Homebrew tap. It ships the cask that installs the
notarized Authsia app and CLI. It does not contain application source.

This cask installs:

- `Authsia.app`
- `authsia` CLI, linked from
  `/Applications/Authsia.app/Contents/Helpers/authsia`
- uninstall hooks for `Authsia.Bridge` and `Authsia.SSHAgent`

Verify a downloaded release with Developer ID signing and artifact hashes on
the [verify page](https://authsia.clarionstack.com/verify.html). Report
vulnerabilities on the
[security page](https://authsia.clarionstack.com/security.html), not in this
tap.

The cask lives in [`Casks/authsia.rb`](Casks/authsia.rb). Homebrew
`livecheck` reads the public appcast.

## Links

- [Product site](https://authsia.clarionstack.com)
- [CLI guide](https://authsia.clarionstack.com/cli.html)
- [User guide](https://authsia.clarionstack.com/user-guide.html)
- [Security](https://authsia.clarionstack.com/security.html)
- [Verify a release](https://authsia.clarionstack.com/verify.html)
- [Changelog](https://authsia.clarionstack.com/changelog)
- [Release feed](https://authsia.clarionstack.com/appcast.xml)
