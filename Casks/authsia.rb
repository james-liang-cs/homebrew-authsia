cask "authsia" do
  version "1.8.0"
  sha256 "c3d105b78ba9ac8346ff1212c3982f4f52a2cb80b8640d1a54a0017e899ae2e7"

  url "https://authsia.clarionstack.com/Authsia/Authsia-#{version}.dmg?v=c3d105b78ba9ac8346ff1212c3982f4f52a2cb80b8640d1a54a0017e899ae2e7&source=homebrew"
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
