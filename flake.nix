{
  description = "AzurCrystal's NixOS Configuration";

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
        "kvm-aliyun" = {name,nodes,...}:{
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
      };
    };
}
