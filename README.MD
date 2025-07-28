# NixOS on USB Flake.

## So, what is this?
This is my own flake config to build an "easy-going lightweight nixos". It has more neccessary applications like `firefox`, `ayugram`, `vscode`, etc. To use for developping, it has installed `python`, `nodejs`, etc.

## How to configure?
### DE (Desktop Environment)  
You can configure hyprland in `[repo]/home/.dotfiles/hypr/hyprland.conf`.

### Other Configs
To config other packages, you should to configure it from `[repo]/home/linecodesx.nix`.
But instead you can configure traditionaly in `.conf` like before, but you will have to declare it in `[repo]/home/linecodesx.nix` like this:
```nix
xdg.configFile = {

    "[package]/[config-name].conf".source = ./.dotfiles/[package]/[config-name].conf;
}
```
and save the config in `[repo]/home/.dotfiles/`

### How to install new apps 
To install another not temporary-use app, you must declare it at `line 8` in `[repo/home/linecodesx.nix]`.

To install temporary app, you should use 
```bash
nix-shell -p [package]
```

## Installing and applying configs 
Work in progress