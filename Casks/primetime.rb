cask "primetime" do
  version "0.1.0"
  sha256 "91ebd06be3600b5e402785816c9db810ebf527660791aaf04c9eba98c7270e79"

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

  depends_on macos: ">= :sonoma"
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
