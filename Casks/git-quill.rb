# Generated from the v0.1.1 release by scripts/update-cask.sh. Do not edit.
cask "git-quill" do
  version "0.1.1"

  on_macos do
    on_arm do
      sha256 "05b460aa0f74df961b313ab737c4c7ddf33cd00b0d2c9bf54c6a572210224624"
      url "https://github.com/tonklasocute/git-quill/releases/download/v#{version}/git-quill_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "e163e08d460f4ea18ee1c4123245021dfb0ba2d13aee140fa137c2b5bba93935"
      url "https://github.com/tonklasocute/git-quill/releases/download/v#{version}/git-quill_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "4d9eeec8dd136a172cdec174e6ee3785baa53dcd6f608832cc923896d5d71618"
      url "https://github.com/tonklasocute/git-quill/releases/download/v#{version}/git-quill_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "f4c2199441993952890f925ee2a5828a1fc88b2b29217fd7d3cd98a38b379365"
      url "https://github.com/tonklasocute/git-quill/releases/download/v#{version}/git-quill_#{version}_linux_amd64.tar.gz"
    end
  end

  name "git-quill"
  desc "AI commit messages, PR descriptions, changelogs and reviews from your git diff"
  homepage "https://github.com/tonklasocute/git-quill"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "git-quill"

  # No zap stanza required

  caveats <<~EOS
    git-quill is not code-signed. If macOS blocks it, run:
      xattr -d com.apple.quarantine "$(brew --prefix)/bin/git-quill"
  EOS
end
