cask "moment-tally" do
  version "1.0.0"
  sha256 "6084919a3c30d4c2ce682818d223653ab452a3f3a74548b6fc4051ace8d15b86"

  url "https://github.com/sf1tzp/moment-tally/releases/download/v#{version}/MomentTally-#{version}.zip"
  name "Moment Tally"
  desc "Menu-bar time tracker that turns your day into queryable key: value data"
  homepage "https://moment-tally.com/"

  # Version and sha256 are bumped automatically by Moment Tally's release
  # pipeline (scripts/release.sh); livecheck is for `brew livecheck` audits.
  livecheck do
    url "https://github.com/sf1tzp/moment-tally"
    strategy :github_latest
  end

  auto_updates true # Sparkle
  # Universal (arm64+x86_64); :sonoma keeps the macOS 14 floor on Intel too
  # (2018-or-later hardware).
  depends_on macos: :sonoma

  app "MomentTally.app"
  # The scriptable CLI rides inside the app bundle (see Moment Tally's
  # scripts/bundle-app.sh); Sparkle updates the app in place, so the
  # symlink survives auto-updates.
  binary "#{appdir}/MomentTally.app/Contents/Helpers/moment-tally"

  zap trash: [
    "~/Library/Application Support/MomentTally",
    "~/Library/Caches/com.streetfortress.MomentTally",
    "~/Library/Containers/com.streetfortress.MomentTally",
    "~/Library/HTTPStorages/com.streetfortress.MomentTally",
    "~/Library/Preferences/com.streetfortress.MomentTally.plist",
    "~/Library/Saved Application State/com.streetfortress.MomentTally.savedState",
  ]

  caveats <<~EOS
    Sync credentials saved in the macOS Keychain are not removed by
    `brew uninstall --zap`; delete "Moment Tally" items in Keychain Access
    if you want them gone.
  EOS
end
