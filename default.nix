{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "parasoft-cpptestcli";
  version = "2024.1.0";

  src = pkgs.fetchurl {
    url = "ftp://10.0.1.162/upload/parasoft_cpptest_standard-2024.1.0-linux.x86_64.rekovar.tar.gz";
    sha256 = "0r3c377g63f2yb37cviwscdgsqk8c5p0h7j13p65x14vjqi9nd1k";
  };

  buildInputs = [ pkgs.libarchive ];

  installPhase = ''
    mkdir -p $out/bin
    tar -xzf $src --strip-components=1 -C $out
    chmod +x $out/cpptestcli
    ln -s $out/cpptestcli $out/bin/cpptestcli
  '';

  meta = with pkgs.lib; {
    description = "Parasoft CppTestCli";
    homepage = "https://example.com";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = with maintainers; [ abeljim ];
  };
}

