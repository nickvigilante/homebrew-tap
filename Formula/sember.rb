class Sember < Formula
  desc "Semantic line breaks for cleaner text and smaller, more manageable diffs."
  homepage "https://github.com/nickvigilante/sember"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.2/sember-aarch64-apple-darwin.tar.xz"
      sha256 "1ca555bcd409c25bdf1266b93f3f5c0b771ba884043c7785135b8665ca5716ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.2/sember-x86_64-apple-darwin.tar.xz"
      sha256 "0a0fb8039f727418e5dfb288fb7fca15a8c636226121afc2b1a5dc9aeae6d71a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.2/sember-aarch64-unknown-linux-musl.tar.xz"
      sha256 "de62c7bb4091943b4e9025c871644c285e825fedc07c987d8a4385e3c3a22a42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nickvigilante/sember/releases/download/v0.1.2/sember-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7d35c65e0329384950b0773c2f91092d35fe86b53df7a7757a54d2e25f5b76bf"
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
