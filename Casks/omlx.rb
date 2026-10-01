cask "omlx" do
  version "0.7.0"
  sha256 "2e3bb06ac6ee7f50986ba1417e909d432ccd2be471db752a4a2d3b5651e3bce0"

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
