class Sember < Formula
  desc "Semantic line breaks for cleaner text and smaller, more manageable diffs."
  homepage "https://github.com/nickvigilante/sember"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.1/sember-aarch64-apple-darwin.tar.xz"
      sha256 "4580aadb9253df94dc134909a1a0d7d6559b6dfbdd0ec547430100dda4ab25b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.1/sember-x86_64-apple-darwin.tar.xz"
      sha256 "8982aba51d109719f8a14c0234f7fc12fa2b814ef399c18d52c5dd01d5e803c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.1/sember-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3d3b4afeefffbd5b407aa1be529a45f88edd147de5484628d419e9c5ccc0fe94"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.1/sember-x86_64-unknown-linux-musl.tar.xz"
      sha256 "cfee4b4bebb5a16a5bb73e5bd6e4f22d59c7605971ac4dc90efd25afffb97b8b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sember"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sember"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sember"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sember"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
