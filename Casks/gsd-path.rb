cask "gsd-path" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "6147d1825cc6d5d48ae49bcb244257c997159960fffb94f49332a1402937046e",
         intel: "47b4d4ac5782dc782b2af808d36a6473a380a3520593b34de963927217cc27bc"

  url "https://github.com/open-gsd/gsd-path/releases/download/app-v#{version}/OpenGSD.Path_#{version}_#{arch}.dmg"
  name "OpenGSD Path"
  desc "Desktop dashboard for the GSD Path AI agent workflow"
  homepage "https://github.com/open-gsd/gsd-path"

  livecheck do
    url :url
    regex(/^app-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      release_arches = %w[aarch64 x64]
      json.filter_map do |release|
        next if release["draft"]

        # Upstream publishes desktop app builds as prereleases.
        match = release["tag_name"]&.match(regex)
        next if match.blank?

        release_version = match[1]
        next unless release_arches.all? do |release_arch|
          release["assets"]&.any? do |asset|
            asset["name"] == "OpenGSD.Path_#{release_version}_#{release_arch}.dmg"
          end
        end

        release_version
      end
    end
  end

  auto_updates true
  depends_on :macos

  app "OpenGSD Path.app"

  # No zap stanza required
end
