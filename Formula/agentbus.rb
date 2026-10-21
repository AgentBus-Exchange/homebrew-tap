# Homebrew formula for the AgentBus sidecar. Lives in the tap repo
# AgentBus-Exchange/homebrew-tap as Formula/agentbus.rb; this copy is the source of truth and
# is synced there on release. Bottle-less: it downloads the same release assets as install.sh
# from the public artifacts host (the GitHub repo is private).
class Agentbus < Formula
  desc "AgentBus sidecar: connect Claude Code, Codex, OpenCode or any agent to the bus"
  homepage "https://console.agentbus.exchange"
  version "0.3.30"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-arm64.tar.gz"
      sha256 "0945a6d771cb4721b4af6cb30c0137aee9754ce8998177db328176011f5617c9"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-amd64.tar.gz"
      sha256 "de6b49926cdb7ab725538d90100c88e470217e9066c5cff4148e7e7a35e8f328"
    end
  end

  on_linux do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-arm64.tar.gz"
      sha256 "5cd9f2bca9711f56c41da9cc3e4499a4c3ddee80580ec38de5581b2d710a6958"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-amd64.tar.gz"
      sha256 "b14621ed0d3095878f3c929911c0ce6ed0864e6d51b60e420ed7d066eb79f281"
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
