cask "authsia" do
  version "1.6.0"
  sha256 "002a6a095f2f3db53a75f605f2e51ca249183f89d3140ff190fe600b49e8c17e"

  url "https://authsia.clarionstack.com/Authsia/Authsia-1.6.0.dmg?v=20260712144245"
  name "Authsia"
  desc "Local-first secret manager with a CLI, agent JIT approvals, and 2FA"
  homepage "https://authsia.clarionstack.com/"

  livecheck do
    url "https://authsia.clarionstack.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sequoia

  app "Authsia.app"
  binary "#{appdir}/Authsia.app/Contents/Helpers/authsia"

  uninstall launchctl: [
              "Authsia.Bridge",
              "Authsia.SSHAgent",
            ],
            quit:      "app.authsia"

  zap trash: [
    "~/.authsia",
    "~/Library/Application Support/Authsia",
    "~/Library/Caches/app.authsia",
    "~/Library/HTTPStorages/app.authsia",
    "~/Library/LaunchAgents/Authsia.Bridge.plist",
    "~/Library/LaunchAgents/Authsia.SSHAgent.plist",
    "~/Library/Preferences/app.authsia.plist",
  ]

  caveats <<~EOS
    Launch Authsia once so it can register its background helpers
    (Authsia.Bridge and Authsia.SSHAgent), then enable CLI access in
    Authsia > Settings > Security > CLI Access.

    Shell integration (SSH agent + guarded workspaces):
      eval "$(authsia init zsh)"

    Vault secrets are stored in the Apple Keychain and are NOT removed
    by uninstall or zap.
  EOS
end
