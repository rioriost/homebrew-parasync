class Parasync < Formula
  include Language::Python::Virtualenv

  desc "parasync is a parallelized rsync tool written in Python."
  homepage "https://github.com/rioriost/homebrew-parasync/"
  url "https://files.pythonhosted.org/packages/c0/54/42a9591a339d82cf5bfe6dd8bf23472208dc92e16f305f291529742150af/parasync-0.1.1.tar.gz"
  sha256 "113d5d5b98de60faadf0a7e43c0afeb785679ee07d23ad93b2e5cd9741ad0977"
  license "MIT"

  depends_on "python@3.9"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/cd/ec/7b8e6b9b1d22708138630ef34c53ab2b61032c04f16adfdbb96791c8c70c/psutil-7.1.2.tar.gz"
    sha256 "aa225cdde1335ff9684708ee8c72650f6598d5ed2114b9a7c5802030b1785018"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/parasync", "--help"
  end
end
