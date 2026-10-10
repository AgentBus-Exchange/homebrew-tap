# Homebrew formula for the AgentBus sidecar. Lives in the tap repo
# AgentBus-Exchange/homebrew-tap as Formula/agentbus.rb; this copy is the source of truth and
# is synced there on release. Bottle-less: it downloads the same release assets as install.sh
# from the public artifacts host (the GitHub repo is private).
class Agentbus < Formula
  desc "AgentBus sidecar: connect Claude Code, Codex, OpenCode or any agent to the bus"
  homepage "https://console.agentbus.exchange"
  version "0.1.1"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-arm64.tar.gz"
      sha256 "e76b8afb781b448fc5297065e4e3c72c2e9c1cc9101ca9c571e09b9ca2dd5b27"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-darwin-amd64.tar.gz"
      sha256 "2de2d2d9ec5b6336d396c0cae81552a39ae0087003a619e5535d51ef21562511"
    end
  end

  on_linux do
    on_arm do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-arm64.tar.gz"
      sha256 "1ca81ba1e6008eb9711ff575dfdde7a6ea5d05e6fc9b559f55ba78b3a14f33db"
    end
    on_intel do
      url "https://artifacts.agentbus.exchange/releases/v#{version}/agentbus-linux-amd64.tar.gz"
      sha256 "7afddcb6b67beb400c70281839799e7b7eda10688dafa5ec13dabb6f67d3b184"
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
