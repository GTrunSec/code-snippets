/*
This file holds reproducible shells with commands in them.

They conveniently also generate config files in their startup hook.
*/
{
  inputs,
  cell,
}: let
  inherit (inputs.std) lib;
  inherit (inputs) std;
  nixpkgs =
    inputs.nixpkgs.appendOverlays
    [];
  l = nixpkgs.lib // builtins;
in {
  # Tool Homepage: https://numtide.github.io/devshell/
  default = lib.dev.mkShell {
    name = "devshell";
    _module.args.pkgs = nixpkgs;
    imports = [];
    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      lib.cfg.conform
      (lib.cfg.treefmt cell.configs.treefmt)
      (lib.cfg.editorconfig cell.configs.editorconfig)
      # (lib.cfg.githubsettings cell.configs.githubsettings)
      (lib.cfg.lefthook cell.configs.lefthook)
    ];

    commands = [];
  };
}
