{ inputs, ... }:
with inputs; {
  perSystem =
    { lib
    , system
    , ...
    }:
    let
      pkgs = import nixpkgs { inherit system; };

      # Following: https://crane.dev/getting-started.html
      craneLib = crane.mkLib pkgs;

      commonArgs = {
        src = craneLib.cleanCargoSource ../.;
        strictDeps = true;

        buildInputs = [
          # Add additional build inputs here
        ]
        ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
          pkgs.libiconv
        ];
      };

      my-crate = craneLib.buildPackage (
        commonArgs
        // {
          cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        }
      );
    in
    {
      packages.default = my-crate;

      devShells.default = craneLib.devShell {
        packages = [ ];
      };
    };
}
