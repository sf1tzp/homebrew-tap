cask "primetime" do
  version "0.6.0"
  sha256 "8ac9107ade2de35d210ceb500a355b0457510493e5774f3679eb9ef197595cd9"

  url "https://github.com/sf1tzp/PrimeTime/releases/download/v#{version}/PrimeTime-#{version}.zip"
  name "PrimeTime"
  desc "Menu-bar time tracker that turns your day into queryable key: value data"
  homepage "https://primetime.tools/"

  # Version and sha256 are bumped automatically by PrimeTime's release
  # pipeline (scripts/release.sh); livecheck is for `brew livecheck` audits.
  livecheck do
    url "https://github.com/sf1tzp/PrimeTime"
    strategy :github_latest
  end

  auto_updates true # Sparkle
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "PrimeTime.app"
  # The scriptable CLI rides inside the app bundle (see PrimeTime's
  # scripts/bundle-app.sh); Sparkle updates the app in place, so the
  # symlink survives auto-updates.
  binary "#{appdir}/PrimeTime.app/Contents/Helpers/primetime"

  zap trash: [
    "~/Library/Application Support/PrimeTime",
    "~/Library/Caches/tools.primetime.PrimeTime",
    "~/Library/HTTPStorages/tools.primetime.PrimeTime",
    "~/Library/Preferences/tools.primetime.PrimeTime.plist",
    "~/Library/Saved Application State/tools.primetime.PrimeTime.savedState",
  ]

  caveats <<~EOS
    Sync credentials saved in the macOS Keychain are not removed by
    `brew uninstall --zap`; delete "PrimeTime" items in Keychain Access
    if you want them gone.
  EOS
end
