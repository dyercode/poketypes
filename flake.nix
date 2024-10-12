{
  description = "Pokemon team builder revolving around coverage.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    dev.url = "github:dyercode/dev";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      dev,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        # system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in
      # pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            dev.packages.${system}.default
            yarn-berry
            python3 # needed for installing rescript 😢
            # steam-run
          ];
        };
      }
    );
}
