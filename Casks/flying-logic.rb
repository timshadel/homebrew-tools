cask "flying-logic" do
  arch arm: "_arm"

  version "4.1"
  sha256 :no_check

  url "https://s3.amazonaws.com/flyinglogic.com/download/flying_logic_mac#{arch}.dmg"
  name "Flying Logic"
  desc "Visual reasoning and planning software"
  homepage "https://flyinglogic.com/"

  livecheck do
    url "https://flyinglogic.com/fldownload/"
    regex(/Latest\s+version:\s*v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  app "Flying Logic.app"

  zap trash: [
    "~/Library/Preferences/com.flyinglogic.plist",
    "~/Library/Saved Application State/com.flyinglogic.savedState",
  ]
end
