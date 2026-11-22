class Currently < Formula
  desc "UPS monitoring daemon with NUT, Prometheus, REST, and SNMP"
  homepage "https://github.com/duskglow/currently"
  url "https://github.com/duskglow/currently.git",
      tag:      "v0.1.0-alpha1",
      revision: "b0445ffef9fc12b84b7b40dc8e23cf29c8448267"
  license "Apache-2.0"

  livecheck do
    skip "Prerelease updates are proposed for review by bump-currently.yml."
  end

  depends_on "go" => :build
  depends_on :macos

  def install
    libexec.mkpath
    ldflags = "-s -w -X github.com/duskglow/currently/internal/version.Version=#{version}"
    system "go", "build", "-trimpath", "-ldflags=#{ldflags}", "-o", libexec/"currently", "./cmd/currently"

    (libexec/"plugins").mkpath
    {
      "mqtt"   => "currently-output-mqtt",
      "snmp"   => "currently-driver-snmp",
      "serial" => "currently-driver-serial",
    }.each do |plugin, executable|
      system "go", "build", "-trimpath", "-ldflags=-s -w",
             "-o", libexec/"plugins"/executable, "./plugins/#{plugin}"
    end

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
    assert_path_exists pkgshare/"currently.example.yaml"
  end
end
