# Homebrew formula for the AgentBus sidecar. Lives in the tap repo
# AgentBus-Exchange/homebrew-tap as Formula/agentbus.rb; this copy is the source of truth and
# is synced there on release. Bottle-less: it downloads the same release assets as install.sh
# from the public artifacts host (the GitHub repo is private).
class Agentbus < Formula
  desc "AgentBus sidecar: connect Claude Code, Codex, OpenCode or any agent to the bus"
  homepage "https://console.agentbus.exchange"
  version "0.3.36"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-arm64.tar.gz"
      sha256 "be8fcb3f09f1b0efe38a85034e77f7194b97c012b0297f0a59f3765bd5f59ab3"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-amd64.tar.gz"
      sha256 "a3b162ca291f92e89eb4d8e3b6439603fbcb5d79fe0cfff8cf0129506ca3e470"
    end
  end

  on_linux do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-arm64.tar.gz"
      sha256 "c9932629592e8a4727dbf81b20024c86005fdf550771273ba6c1e7dff44e9278"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-amd64.tar.gz"
      sha256 "ce2eb76d49e41bd469e9ba071fb874c6b10d21dcf0678ce49b6667e27b98bd9b"
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
