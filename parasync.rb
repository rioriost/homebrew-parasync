class Parasync < Formula
  include Language::Python::Virtualenv

  desc "parasync is a parallelized rsync tool written in Python."
  homepage "https://github.com/rioriost/homebrew-parasync/"
  url "https://files.pythonhosted.org/packages/11/24/09d06b6a1b108e18b176a6319fc5e0a286df05dccf63b270eeb99d0d6d41/parasync-0.1.4.tar.gz"
  sha256 "95c1d3789bd96d124dd63970fc8a674079745141bab9475deaeb7514d8cbc6ea"
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
