class Dag < Formula
  desc "DNS Anomaly Generator - High-performance DNS query tool and protocol fuzzer"
  homepage "https://github.com/NoelMinamino/KariDNS"
  url "https://github.com/NoelMinamino/KariDNS/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "0781e6ac32dbf0660487da0542a58b4a69c34fb1286aae1b2a441d68efc69493"
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
