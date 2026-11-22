cask "currently" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.0-alpha1"
  sha256 arm:   "d32083711b830b43fe04a13307d89361cbc5dc5f92acc0f9d4afc055e9cd177a",
         intel: "846b9d42bd5ad87d665f3ffbda4ff8645784c7f64fde69d3490ca3c7db4f29bc"

  url "https://github.com/duskglow/currently/releases/download/v#{version}/currently_#{version}_darwin_#{arch}.tar.gz"
  name "Currently"
  desc "UPS monitor with NUT, Prometheus, REST, and SNMP interfaces"
  homepage "https://github.com/duskglow/currently"

  livecheck do
    skip "Prerelease updates are proposed for review by bump-currently.yml."
  end

  depends_on :macos

  binary "currently"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/currently"], must_succeed: false
    end
  end

  zap :not_required

  caveats <<~EOS
    Currently is an alpha release whose macOS USB transport is not yet
    validated by the upstream developer on physical hardware.

    Test in the foreground before configuring a persistent service:
      currently detect
      currently serve

    In another terminal, inspect the UPS variables with:
      currently status
      currently vars <UPS_NAME>

    To keep native macOS UPS shutdown management in control, do not add
    a "shutdown:" section to Currently's config. Only install and start
    Currently as a launchd service after confirming shared USB access,
    an accurate ups.load value, and macOS's own UPS status.
  EOS
end
