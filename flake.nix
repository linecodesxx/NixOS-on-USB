{
  description = "NixOS configuration for line-usb";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations."line-usb" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.linecodesx = import ./home/linecodesx.nix;
        }
      ];
    };

    # Добавляем devShell для разработки
    devShells.${system}.default = pkgs.mkShell {
      name = "web-dev";

      packages = with pkgs; [
        # Python
        python3
        python3Packages.pip
        python3Packages.virtualenv

        # Node.js
        nodejs_20
        yarn
        nodePackages.npm
        nodePackages.pnpm

        # Frameworks
        nodePackages.vite
        nodePackages.next
        nodePackages.create-react-app
        nodePackages.vue-cli
        nodePackages.typescript

        # Tools
        git
        curl
        jq
      ];

      shellHook = ''
        echo "=== 🚀 Development shell ready ==="
        echo "Python: $(python3 --version)"
        echo "Node: $(node --version)"
        echo "npm: $(npm --version)"
        echo ""
        echo "Available commands:"
        echo "  pyenv - Create Python virtualenv"
        echo "  npminit - Start new Vite project"
        echo ""
        alias pyenv="python3 -m venv .venv && source .venv/bin/activate"
        alias npminit="npm init vite@latest"
      '';
    };
  };
}
