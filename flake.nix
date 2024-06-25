{
  description = "A flake for Parasoft C++test";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = nixpkgs.lib.mkShell {
      buildInputs = [ self.defaultPackage.x86_64-linux ];
    };

    defaultPackage.x86_64-linux = nixpkgs.stdenv.mkDerivation {
      pname = "parasoft-cpptest";
      version = "2024.1.0";

      src = nixpkgs.fetchurl {
        url = "ftp://10.0.1.162/upload/parasoft_cpptest_standard-2024.1.0-linux.x86_64.rekovar.tar.gz";
        sha256 = "0r3c377g63f2yb37cviwscdgsqk8c5p0h7j13p65x14vjqi9nd1k";
      };

      buildInputs = [ nixpkgs.libarchive ];

      installPhase = ''
        mkdir -p $out/bin
        tar -xzf $src --strip-components=1 -C $out
        chmod +x $out/cpptestcli
        ln -s $out/cpptestcli $out/bin/cpptestcli
      '';

      meta = with nixpkgs.lib; {
        description = "Parasoft C++test Standard Edition";
        homepage = "https://www.parasoft.com/products/ctest/";
        license = licenses.proprietary;
        maintainers = with maintainers; [ "abelREK" ];
      };
    };
  };
}

