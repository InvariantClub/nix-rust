{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem =
    { pkgs, lib, ... }:
    {
      treefmt = {
        programs.rustfmt.enable = true;
        # Nix
        programs.nixpkgs-fmt.enable = true;
      };
    };
}
