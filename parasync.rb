class Parasync < Formula
  include Language::Python::Virtualenv

  desc "parasync is a parallelized rsync tool written in Python."
  homepage "https://github.com/rioriost/homebrew-parasync/"
  url "https://files.pythonhosted.org/packages/11/35/b3dff1a2292b8fb87f7ddfbdf10dad57046e5d385277022ed88cf52ecb0e/parasync-0.1.5.tar.gz"
  sha256 "a34378e9e96741a7b92809e9c08bddcb425ba13e791cbf6dd1e5666956df1df5"
  license "MIT"

  depends_on "python@3.9"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/e1/88/bdd0a41e5857d5d703287598cbf08dad90aed56774ea52ae071bae9071b6/psutil-7.1.3.tar.gz"
    sha256 "6c86281738d77335af7aec228328e944b30930899ea760ecf33a4dba66be5e74"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/parasync", "--help"
  end
end
