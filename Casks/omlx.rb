cask "omlx" do
  version "0.7.2"
  sha256 "0ceddaf7a8901d440bc88acb3e033b294ad4d1b45b57d02fb73833c839d270b9"

  url "https://github.com/jundot/omlx/releases/download/v#{version}/oMLX-#{version}-macos26-27.dmg"
  name "oMLX"
  desc "LLM inference server and menu bar app optimized for Apple Silicon"
  homepage "https://github.com/jundot/omlx"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        release_version = match[1]
        next unless release["assets"]&.any? do |asset|
          asset["name"] == "oMLX-#{release_version}-macos26-27.dmg"
        end

        release_version
      end
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: [
    :tahoe,
    :golden_gate,
  ]

  app "oMLX.app"

  # No zap stanza required
end
