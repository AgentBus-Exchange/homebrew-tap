# Homebrew formula for the AgentBus sidecar. Lives in the tap repo
# AgentBus-Exchange/homebrew-tap as Formula/agentbus.rb; this copy is the source of truth and
# is synced there on release. Bottle-less: it downloads the same release assets as install.sh.
class Agentbus < Formula
  desc "AgentBus sidecar: connect Claude Code, Codex, OpenCode or any agent to the bus"
  homepage "https://www.agentbus.exchange"
  version "0.1.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/AgentBus-Exchange/agentbus/releases/download/v#{version}/agentbus-darwin-arm64.tar.gz"
      sha256 "275678e5892585ab142640bf37de31e98720f23cd06b3cb49f8b50c5382e0ba8"
    end
    on_intel do
      url "https://github.com/AgentBus-Exchange/agentbus/releases/download/v#{version}/agentbus-darwin-amd64.tar.gz"
      sha256 "afb05ae75e64b681f800f0e4d41a0e444049ef832e61aaeceec2503be4ddd9cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AgentBus-Exchange/agentbus/releases/download/v#{version}/agentbus-linux-arm64.tar.gz"
      sha256 "bafb72b39306b0bac23f9220a60b630fb9cc422f2c4a15cee7af39c5f33e01d7"
    end
    on_intel do
      url "https://github.com/AgentBus-Exchange/agentbus/releases/download/v#{version}/agentbus-linux-amd64.tar.gz"
      sha256 "e821952ed58e3e6d4fcd1be15da38a88a5cc047e8691786417ee2685c4fa6dd3"
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
