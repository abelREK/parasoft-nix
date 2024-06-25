{
  description = "Parasoft CppTestCli package using Nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
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
        license = licenses.mit;
        platforms = platforms.linux;
        maintainers = with maintainers; [ abeljim ];
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        self.packages.${system}.default
      ];
      # shellHook = ''
      #   echo "Started Parasoft CppTestCli environment..."
      # '';
    };
  };
}
