cask "gsd-path" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.3"
  sha256 arm:   "b87d1789114d1da40a1b3113e548e06cc2cfbf0ef8e6a434856b0470d3dbb633",
         intel: "beb8bde4aabccdb70ba7516075893e651fad097dbd1040fca2584ed8dec74385"

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

  zap :not_required
end
