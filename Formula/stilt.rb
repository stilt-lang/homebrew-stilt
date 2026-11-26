# The formula of Stilt 2027.1.0, written by tools/release/homebrew.py from the release's
# SHA256SUMS.
class Stilt < Formula
  desc "Compiled language whose compiler infers what code costs and shows it"
  homepage "https://github.com/stilt-lang/stilt"
  version "2027.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/stilt-lang/stilt/releases/download/2027.1.0/stilt-aarch64-macos.tar.gz"
      sha256 "d36b9bc2ebd45b073c75a4bbd66afd34b986d09f41c84ce2d497b1ec1a12d3f1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/stilt-lang/stilt/releases/download/2027.1.0/stilt-x86_64-linux.tar.gz"
      sha256 "383005bd43b9ad9fb262830124405fa5aaea2c88fa54a0a8bb2cc4259e5f4a20"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stilt-lang/stilt/releases/download/2027.1.0/stilt-aarch64-linux.tar.gz"
      sha256 "c5141b691619a7d0bf8e42eef005d58507a413dc7a1371f3711a9759055bacdb"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/stilt"
    man1.install Dir[libexec/"share/man/man1/*.1"]
    bash_completion.install libexec/"share/bash-completion/completions/stilt"
    zsh_completion.install libexec/"share/zsh/site-functions/_stilt"
    fish_completion.install libexec/"share/fish/vendor_completions.d/stilt.fish"
  end

  test do
    system bin/"stilt", "new", "hello"
    cd "hello" do
      system bin/"stilt", "check"
      assert_match "Hello", shell_output("#{bin}/stilt run")
    end
  end
end
