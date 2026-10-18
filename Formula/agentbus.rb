# Homebrew formula for the AgentBus sidecar. Lives in the tap repo
# AgentBus-Exchange/homebrew-tap as Formula/agentbus.rb; this copy is the source of truth and
# is synced there on release. Bottle-less: it downloads the same release assets as install.sh
# from the public artifacts host (the GitHub repo is private).
class Agentbus < Formula
  desc "AgentBus sidecar: connect Claude Code, Codex, OpenCode or any agent to the bus"
  homepage "https://console.agentbus.exchange"
  version "0.3.21"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-arm64.tar.gz"
      sha256 "f478c95bd42d8c5dc358e4da58010973d6df93dbcf93f15290f0dd98a704a33a"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-amd64.tar.gz"
      sha256 "1924f875150c687bfe9d60055fcb2ad2ed9590c8538c62ed946c324c25f1f6a0"
    end
  end

  on_linux do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-arm64.tar.gz"
      sha256 "95dadddb49ae4e90457d825bcaafc229f050aa2e1c8259bb9ed34c01cf3057d7"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-amd64.tar.gz"
      sha256 "534276db56c07e8ab5d326044291bce4acd80f1110749764f930716fe55c48fa"
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
