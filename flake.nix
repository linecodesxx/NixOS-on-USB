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
        nodePackages.typescript
	
	# Rust
	rustc
	cargo

        # Tools
        git
        curl
        jq
      ];

      shellHook = ''
        echo "=== 🚀 Web Dev Shell ==="
        echo "Python: $(python3 --version)"
        echo "Node: $(node --version)"
        echo "npm: $(npm --version)"
        echo ""
        echo "Доступные команды:"
        echo "  create-vite - Создать новый Vite проект"
        echo "  create-next - Создать Next.js проект"
        echo "  create-react - Создать React проект"
        alias create-vite="npm create vite@latest"
        alias create-next="npm create next-app"
        alias create-react="npm create react-app"
      '';
      };
  };
}
