class Parasync < Formula
  include Language::Python::Virtualenv

  desc "parasync is a parallelized rsync tool written in Python."
  homepage "https://github.com/rioriost/homebrew-parasync/"
  url "https://files.pythonhosted.org/packages/02/f2/533347ec21b572d7221d40b3499fff6ecf3a77f24c788a3cfe03c452c0a0/parasync-0.1.7.tar.gz"
  sha256 "b90db496ea93543ff9a38bb808311f7650635a21cc213ea324ec305fbb945825"
  license "MIT"

  depends_on "python@3.9"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/parasync", "--help"
  end
end
