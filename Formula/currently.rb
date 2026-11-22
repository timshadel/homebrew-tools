class Currently < Formula
  desc "UPS monitoring daemon with NUT, Prometheus, REST, and SNMP"
  homepage "https://github.com/duskglow/currently"
  version "0.1.0-alpha1"
  license "Apache-2.0"
  revision 1

  livecheck do
    skip "Prerelease updates are proposed for review by bump-currently.yml."
  end

  depends_on :macos

  on_arm do
    url "https://github.com/duskglow/currently/releases/download/v#{version}/currently_#{version}_darwin_arm64.tar.gz"
    sha256 "d32083711b830b43fe04a13307d89361cbc5dc5f92acc0f9d4afc055e9cd177a"
  end

  on_intel do
    url "https://github.com/duskglow/currently/releases/download/v#{version}/currently_#{version}_darwin_amd64.tar.gz"
    sha256 "846b9d42bd5ad87d665f3ffbda4ff8645784c7f64fde69d3490ca3c7db4f29bc"
  end

  def install
    libexec.install "currently", "plugins"
    bin.install_symlink libexec/"currently"
    pkgshare.install "currently.example.yaml"
  end

  def caveats
    <<~EOS
      Configure Currently before starting its service. The configuration is
      per-host and is not overwritten by Homebrew upgrades:

        currently detect
        currently init --yes --no-shutdown --output "#{etc}/currently/currently.yaml"
        currently config validate --config "#{etc}/currently/currently.yaml"

      No shutdown section means monitoring only. The generated configuration
      binds NUT and HTTP to localhost; edit listen.nut in the configuration
      if an operator explicitly wants remote NUT monitoring.

      Recommended system service (starts at boot, without login):

        sudo brew services start timshadel/tools/currently

      Then check readings with `currently status` and `currently vars <UPS_NAME>`.
      Native operating-system UPS shutdown management remains independent.
      To control shutdown with Currently, explicitly configure a shutdown
      policy; Homebrew does not select that policy.
    EOS
  end

  service do
    run [opt_libexec/"currently", "serve", "--config", etc/"currently/currently.yaml"]
    keep_alive true
    require_root true
    log_path var/"log/currently.log"
    error_log_path var/"log/currently.log"
  end

  test do
    assert_match "currently #{version}", shell_output("#{bin}/currently version")
    %w[currently-output-mqtt currently-driver-snmp currently-driver-serial].each do |plugin|
      assert_predicate libexec/"plugins"/plugin, :executable?
    end
    assert_path_exists pkgshare/"currently.example.yaml"
  end
end
