{
  description = "Pokemon team builder revolving around coverage.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    dev.url =
      "github:dyercode/dev";
  };

  outputs = { self, nixpkgs, flake-utils, dev }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            dev.packages.${system}.default
            yarn
            python3 # needed for installing rescript 😢
          ];
        };
      });
}
