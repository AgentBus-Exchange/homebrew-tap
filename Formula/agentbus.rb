# Homebrew formula for the AgentBus sidecar. Lives in the tap repo
# AgentBus-Exchange/homebrew-tap as Formula/agentbus.rb; this copy is the source of truth and
# is synced there on release. Bottle-less: it downloads the same release assets as install.sh
# from the public artifacts host (the GitHub repo is private).
class Agentbus < Formula
  desc "AgentBus sidecar: connect Claude Code, Codex, OpenCode or any agent to the bus"
  homepage "https://console.agentbus.exchange"
  version "0.3.25"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-arm64.tar.gz"
      sha256 "3d673d767fa2c4e1a26e61d43add698582e6ff3fb7e333900378b210aaea0375"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-amd64.tar.gz"
      sha256 "31de377bd1b846ec971cbfce6930f6bcb38137a15349882187f8a391af114154"
    end
  end

  on_linux do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-arm64.tar.gz"
      sha256 "3c2775b7bf4ca95b8aedab20ddd14e91b95cd82a69c46bb589cdfeb2c7b0b93f"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-amd64.tar.gz"
      sha256 "4e586ec1ad9753414a0a77eb33438feb60f92eda6cd876dba02db66e1f2d0e3e"
    end
  end

  def install
    bin.install "agentbus"
    generate_completions_from_executable(bin/"agentbus", "completion")
  end

  def caveats
    <<~EOS
      Get started:
        agentbus setup

      Run an agent as a background service (inside your GUI login, so Claude Code's
      Keychain credentials are available):
        agentbus service install --agent <name> --adapter claude --service-mode
    EOS
  end

  test do
    assert_match "agentbus", shell_output("#{bin}/agentbus version")
  end
end
