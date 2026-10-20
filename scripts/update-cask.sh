#!/usr/bin/env bash
# Regenerates Casks/git-quill.rb from the latest git-quill GitHub release
# (version + sha256 from its checksums.txt). Needs the gh CLI.
set -euo pipefail

repo=tonklasocute/git-quill
tag=${1:-$(gh release view -R "$repo" --json tagName --jq .tagName)}
version=${tag#v}
sums=$(gh release download "$tag" -R "$repo" -p checksums.txt -O -)

sum() {
  local s
  s=$(awk -v f="git-quill_${version}_$1.tar.gz" '$2 == f {print $1}' <<<"$sums")
  [[ $s =~ ^[0-9a-f]{64}$ ]] || { echo "no sha256 for $1 in $tag" >&2; exit 1; }
  echo "$s"
}

url="https://github.com/${repo}/releases/download/v#{version}/git-quill_#{version}"
cat > Casks/git-quill.rb <<EOF
# Generated from the ${tag} release by scripts/update-cask.sh. Do not edit.
cask "git-quill" do
  version "${version}"

  on_macos do
    on_arm do
      sha256 "$(sum darwin_arm64)"
      url "${url}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "$(sum darwin_amd64)"
      url "${url}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "$(sum linux_arm64)"
      url "${url}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "$(sum linux_amd64)"
      url "${url}_linux_amd64.tar.gz"
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
      xattr -d com.apple.quarantine "\$(brew --prefix)/bin/git-quill"
  EOS
end
EOF
echo "Casks/git-quill.rb -> ${version}"
