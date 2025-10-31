class Parasync < Formula
  include Language::Python::Virtualenv

  desc "parasync is a parallelized rsync tool written in Python."
  homepage "https://github.com/rioriost/homebrew-parasync/"
  url "https://files.pythonhosted.org/packages/35/56/4c9b5957d0edb5a33459744496dc3752992c1ae5c0a740a96c3170de4193/parasync-0.1.3.tar.gz"
  sha256 "2471a3f5a2093628ca88fdf665d998f4e8dee40269a54097f9e5c8a21ad1e18f"
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
