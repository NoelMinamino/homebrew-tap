class Dag < Formula
  desc "DNS Anomaly Generator - High-performance DNS query tool and protocol fuzzer"
  homepage "https://github.com/NoelMinamino/KariDNS"
  url "https://github.com/NoelMinamino/KariDNS/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "cfbe6f153ff2704af8efab0737d0447c102f2f18bc9c37acde448a5d1a6b3e7e"
  license "BSD-2-Clause"

  depends_on "openssl@3"
  depends_on "zlib"
  depends_on "libidn2" => :optional

  def install
    ENV.append "CFLAGS", "-I#{Formula["openssl@3"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["openssl@3"].opt_lib}"
    if build.with? "libidn2"
      ENV.append "CFLAGS", "-I#{Formula["libidn2"].opt_include} -DHAVE_LIBIDN2"
      ENV.append "LDFLAGS", "-L#{Formula["libidn2"].opt_lib} -lidn2"
    end

    system "make", "dag"
    bin.install "dag"
    doc.install "README.md", "docs/dag.md" if File.exist?("docs/dag.md")
  end

  test do
    assert_match "dag", shell_output("#{bin}/dag --help 2>&1", 0)
  end
end
