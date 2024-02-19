{
  description = "AzurCrystal's NixOS Configuration";

  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , nixos-wsl
    , sops-nix
    , home-manager
    , emacs-overlay
    , ...
    } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import emacs-overlay)
          (import ./overlays/sway-im)
        ];
      };
    in
    {
      nixosConfigurations = {
        "kh-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs;
          };
          modules = [
            ./profiles/laptops/ThinkPadX270
            sops-nix.nixosModules.sops
            ./modules/users
            ./modules/distbuilds
            ./modules/devices
            ./modules/devices/gui/wayland/sway
            ./modules/virts/docker
            home-manager.nixosModules.home-manager
            {
              home-manager =
                {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.azurcrystal = import ./home;
                };
            }
          ];
        };
      };
      colmena = {
        meta = {
          nixpkgs = import inputs.nixpkgs {
            inherit system;
          };
          specialArgs = {
            inherit nixpkgs;
          };
        };
        "wsl-main" = { name, nodes, ... }: {
          deployment = {
            tags = [ "builder" "china" ];
            targetHost = "wsl-main";
            targetUser = "azurcrystal";
          };
          imports = [
            nixos-wsl.nixosModules.wsl
            ./modules/virts/wsl
            sops-nix.nixosModules.sops
            ./profiles/hosts/wsl-main
            ./modules/users
            ./modules/users/builder
            ./modules/servers
          ];
        };
        "lxc-kabu" = { name, nodes, ... }: {
          deployment = {
            tags = [ "builder" "server" "china" ];
            targetHost = "lxc-kabu";
            targetUser = "azurcrystal";
          };
          imports = [
            "${nixpkgs}/nixos/modules/virtualisation/lxc-container.nix"
            sops-nix.nixosModules.sops
            ./modules/virts/lxc
            ./profiles/hosts/lxc-kabu
            ./modules/users
            ./modules/users/builder
            ./modules/servers
          ];
        };
        "kvm-aliyun" = { name, nodes, ... }: {
          deployment = {
            tags = [ "server" "china" ];
            targetHost = "kvm-aliyun";
            targetUser = "azurcrystal";
          };
          imports = [
            sops-nix.nixosModules.sops
            ./profiles/hosts/kvm-aliyun
            ./modules/users
            ./modules/servers
          ];
        };
        "kvm-us-1" = { name, nodes, ... }: {
          deployment = {
            tags = [ "server" "us" ];
            targetHost = "kvm-us-1";
            targetUser = "azurcrystal";
          };
          imports = [
            sops-nix.nixosModules.sops
            ./profiles/hosts/kvm-us-1
            ./modules/users
            ./modules/servers
          ];
        };
        "lxc-router" = { name, nodes, ... }: {
            deployment = {
              tags = [ "lxc" "server" "china" ];
              targetHost = "lxc-router";
              targetUser = "azurcrystal";
            };
            imports = [
              "${nixpkgs}/nixos/modules/virtualisation/lxc-container.nix"
              sops-nix.nixosModules.sops
              ./modules/virts/lxc
              ./profiles/hosts/lxc-router
              ./modules/users
              ./modules/users/builder
              ./modules/servers
            ];
          };
      };
    };
}
