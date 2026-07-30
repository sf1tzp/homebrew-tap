cask "primetime" do
  version "0.2.0"
  sha256 "76fec69a0f7a6a614cca4666361a2a2309f58ff62f45c17b721581ad0b3708b2"

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
