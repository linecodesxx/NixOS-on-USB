{pkgs, ...}: {
  home.username = "linecodesx";

  home.stateVersion = "25.05";
  
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    neovim
    kitty
    firefox
    waybar
    fastfetch
    vscode
    ayugram-desktop
    wofi
    git
    curl
    wget
    unzip
    zip
    hyprshot
    wvkbd
    yazi
  ];

  xdg.configFile = {
    # Hyprland
  "hypr/hyprland.conf".source = ./.dotfiles/hypr/hyprland.conf;
  
  # Hyprshot
  "hyprshot/config.toml".source = ./.dotfiles/hyprshot/config.toml;
  };

  programs.bash.enable = true;
  programs.vscode = {
  enable = true;
  profiles.default.userSettings = {
    "editor.fontSize" = 14;
    "workbench.colorTheme" = "Default Dark+";
  };
  
  # Только реально нужные расширения
  profiles.default.extensions = with pkgs.vscode-extensions; [
    # Python
    ms-python.python
    ms-python.pylint
    ms-python.vscode-pylance

    # Rust
    rust-lang.rust-analyzer

    # C++
    ms-vscode.cpptools

    # Nix
    b4dm4n.vscode-nixpkgs-fmt

    # AI
    github.copilot
    github.copilot-chat

    # Lint
    esbenp.prettier-vscode
    dbaeumer.vscode-eslint

    # Visual
    pkief.material-icon-theme


  ];
};

  programs.kitty = {
	enable = true;
	font = {
	  name = "JetBrainsMono Nerd Font";
	  size = 12;
	};
	themeFile = "Dracula";

	settings = {
	  background_opacity = "0.9";
	  enable_audio_bell = "no";
	  scrollback_lines = 5000;
	  cursor_shape = "block";
	  window_padding_width = 5;
	};

	keybindings= {
	  "ctrl+shift+enter" = "new_window";
	  "ctrl+shift+right" = "next_tab";
	  "ctrl+shift+left" = "previous_tab";
	};
  };
}
