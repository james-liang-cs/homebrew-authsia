cask "authsia" do
  version "1.7.3"
  sha256 "c06653f0cd739a5f4db34c0c4c5108809692cd3ab3a65620fbfbb7900951c460"

  url "https://authsia.clarionstack.com/Authsia/Authsia-#{version}.dmg?v=20260727104904"
  name "Authsia"
  desc "Local-first secret manager with a CLI, agent JIT approvals, and 2FA"
  homepage "https://authsia.clarionstack.com/"

  livecheck do
    url "https://authsia.clarionstack.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :tahoe

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
